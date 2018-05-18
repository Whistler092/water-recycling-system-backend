using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WaterRecycling.Entities;

namespace WaterRecycling.Controllers
{
    [Route("api/[controller]")]
    public class EventsController : Controller
    {
        // POST api/events
        [Route("{id}")]
        public async Task<IActionResult> SaveEvent([FromRoute]string id, [FromBody]RecyclingProcess data)
        {
            
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                using(DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    var device = db.Devices.Where(i => i.Code == id).FirstOrDefault();
                    data.From = device ?? throw new ArgumentNullException("id", "Dispositivo no identificado");

                    data.CaptureDate = DateTime.Now;

                    data.Process = !string.IsNullOrEmpty(data.Process) ? data.Process : GetnewProcess();

                    var result = await db.AddAsync(data);

                    await db.SaveChangesAsync();
                    return Ok(data.Process);
                }


            }
            catch (System.Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError,
                        ex);
            }
        }

        string GetnewProcess()
        {
            return Guid.NewGuid().ToString().Substring(0,6);
        }


        // GET api/values
        /*[HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        [HttpPost]
        public void Post([FromBody]string value)
        {
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }*/
    }
}
