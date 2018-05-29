using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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

                using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    var device = db.Devices.Where(i => i.Code == id).FirstOrDefault();
                    data.From = device ?? throw new ArgumentNullException("id", "Dispositivo no identificado");

                    data.CaptureDate = DateTime.Now;

                    data.Process = !string.IsNullOrEmpty(data.Process) ? data.Process : GetnewProcess(device);

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

        // POST api/events
        [Route("{id}/Simulate")]
        public IActionResult SimulateEvent([FromRoute]string id, [FromBody]RecyclingProcess data)
        {


            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    var device = db.Devices.Where(i => i.Code == id).FirstOrDefault();
                    var from = device ?? throw new ArgumentNullException("id", "Dispositivo no identificado");
                    var process = !string.IsNullOrEmpty(data.Process) ? data.Process : GetnewProcess(device);


                    for (int i = 0; i < data.Distance; i++)
                    {
                        int milliseconds = 2000;
                        Thread.Sleep(milliseconds);

                        data.Distance = data.Distance - 1;
                        if (data.Distance <= 2)
                        {
                            break;
                        }
                        db.Add(new RecyclingProcess
                        {
                            From = from,
                            CaptureDate = DateTime.Now,
                            Process = process,
                            Distance = data.Distance,
                            Turbidity = data.Turbidity,
                        });
                        db.SaveChanges();
                    }

                    return Ok(process);
                }


            }
            catch (System.Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError,
                        ex);
            }
        }

      

        private static void SaveEvent(RecyclingProcess data, Device from, string process)
        {
            using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
            {
                

            }
        }

        string GetnewProcess(Device device)
        {
            Notifications.Notify notify = new Notifications.Notify();
            notify.NewEvent(device);
            return Guid.NewGuid().ToString().Substring(0, 6);
        }


        // GET: api/events
        [Route("")]
        public async Task<IActionResult> GetEvents([FromQuery]string id)
        {
            try
            {
                using (DbWaterRecyclingContext db = new DbWaterRecyclingContext())
                {
                    var events = await db.RecyclingProcesses
                                        .Where(i => i.Process.Equals(id))
                                         .GroupBy(i => new { i.Distance, i.Turbidity })
                                         .Select(i => new
                                         {
                                             i.Key.Distance,
                                             i.Key.Turbidity,
                                             i.First().CaptureDate
                                         })
                                         .OrderByDescending(i => i.CaptureDate)
                                         .ToListAsync();
                    return Ok(events.Take(5));
                }
            }
            catch (System.Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError,
                        ex);
            }
        }

    }
}
