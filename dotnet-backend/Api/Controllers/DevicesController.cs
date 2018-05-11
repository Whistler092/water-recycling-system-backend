
namespace WaterRecycling.Controllers
{
    using System;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using WaterRecycling.Entities;

    [Microsoft.AspNetCore.Mvc.Route("api/[controller]")]
    public class DevicesController : Controller
    {
        // GET: api/devices
        [HttpGet("")]
        public async Task<IActionResult> Get([FromQuery]string id)
        {
            using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
            {
                return Ok(await db.Devices.Where(i => !string.IsNullOrEmpty(id) ? i.Code.Equals(id) : true)
                                          .Include(i => i.RecyclingProcessList)
                                          .ToListAsync());
            }
        }

        // GET: api/devices
        [Route("new")]
        public async Task<IActionResult> NewDevice()
        {
            using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
            {

                var exist = false;
                string code = "";
                while(!exist)
                {
                    code = GenerateUniqueCode();

                    var existCode = await db.Devices.Where(i => i.Code.Equals(code))
                                            .FirstOrDefaultAsync();

                    if (existCode == null)
                    {
                        exist = true;
                    }
                }

                Device device = new Device();
                device.Code = code;
                device.Created = DateTime.Now;
                device.Ip = this.HttpContext.Connection.RemoteIpAddress.ToString();

                var result = await db.AddAsync(device);
                await db.SaveChangesAsync();

                return Ok(code);
            }
        }

        private static string GenerateUniqueCode()
        {
            return new Random().Next(0, 9999).ToString("D4");
        }


    }
}
