namespace WaterRecycling.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    public class Device
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [MaxLength(8)]
        public string Code { get; set; }

        [MaxLength(64)]
        public string Ip { get; set; }

        public DateTime Created { get; set; }

        public List<RecyclingProcess> RecyclingProcessList { get; set; }

        public bool State { get; set; }

        [MaxLength(512)]
        public string DeviceToken { get; set; }
    }
}
