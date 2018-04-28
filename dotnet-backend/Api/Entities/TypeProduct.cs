namespace WaterRecycling.Entities
{
    using System.Collections.Generic;

    public class TypeProduct
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public List<Product> Products { get; set; }
    }
}
