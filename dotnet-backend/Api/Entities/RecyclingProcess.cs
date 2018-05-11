using System;
namespace WaterRecycling.Entities
{
    public class RecyclingProcess
    {
        public int Id { get; set; }

        public int Process { get; set; } 

        public decimal Distance { get; set; }

        public decimal Turbidity { get; set; }

        public DateTime CaptureDate { get; set; }

        public Device From { get; set; }
    }
}
