
namespace WaterRecycling.Controllers
{
    using System;
    using System.Linq;
    using System.Net;
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
            try
            {
                using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    return Ok(await db.Devices.Where(i => !string.IsNullOrEmpty(id) ? i.Code.Equals(id) : true)
                                              .Include(i => i.RecyclingProcessList)
                                              .ToListAsync());
                }
            }
            catch (System.Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError,
                        ex);
            }
        }

        // GET: api/devices
        [Route("new")]
        public async Task<IActionResult> NewDevice()
        {
            try
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
            catch (System.Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError,
                        ex);
            }
        }

        // GET: api/devices
        [Route("{id}/activate")]
        public async Task<IActionResult> ActivateCode(string id)
        {
            try
            {
                using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    var code = await db.Devices.Where(i => i.Code.Equals(id)).FirstOrDefaultAsync();

                    if (code == null)
                    {
                        return BadRequest();
                    }
                    if (code.State)
                    {
                        return Ok(99);
                    }

                    code.State = true;

                    db.Update(code);

                    await db.SaveChangesAsync();
                    return Ok(10);
                }
            }
            catch (System.Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError,
                        ex);
            }
        }

        // GET: api/devices
        [Route("{id}/notifications")]
        public async Task<IActionResult> NotificationsDevice(string id, [FromQuery] string token)
        {
            try
            {
                using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    var code = await db.Devices.Where(i => i.Code.Equals(id)).FirstOrDefaultAsync();

                    if (code == null)
                    {
                        return BadRequest();
                    }

                    code.DeviceToken = token;
                    db.Update(code);

                    await db.SaveChangesAsync();

                    Notifications.Notify notify = new Notifications.Notify();
                    notify.NotifyNewDevice(code);
                    return Ok(10);
                }
            }
            catch (System.Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError,
                        ex);
            }
        }

        // GET: api/devices
        [Route("{id}/remove")]
        public async Task<IActionResult> RemoveCode(string id)
        {
            try
            {
                using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    var code = await db.Devices.Where(i => i.Code.Equals(id)).FirstOrDefaultAsync();

                    if (code == null)
                    {
                        return BadRequest("Código Incorrecto");
                    }
                    if (code.State)
                    {
                        code.State = false;

                        db.Update(code);

                        await db.SaveChangesAsync();
                        return Ok("Dispositivo Desasociado correctamente");
                    }

                    return BadRequest("El código no está asociado a ningun dispositivo");
                }
            }
            catch (Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, ex);
            }
        }


        private static string GenerateUniqueCode()
        {
            return new Random().Next(0, 9999).ToString("D4");
        }


    }
}
