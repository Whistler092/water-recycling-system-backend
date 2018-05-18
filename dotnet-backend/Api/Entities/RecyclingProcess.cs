namespace WaterRecycling.Entities
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public class RecyclingProcess
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [MaxLength(12)]
        public string Process { get; set; } 

        public decimal Distance { get; set; }

        public decimal Turbidity { get; set; }

        public DateTime CaptureDate { get; set; }

        public int IdFrom { get; set; }

        public Device From { get; set; }
    }
}
