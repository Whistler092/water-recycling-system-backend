using System;
using System.Collections.Generic;

namespace WaterRecycling.Entities
{
    public class Device
    {
        public int Id { get; set; }

        public string Code { get; set; }

        public string Ip { get; set; }

        public DateTime Created { get; set; }

        public List<RecyclingProcess> RecyclingProcessList { get; set; }

        public bool State { get; set; }
    }
}
