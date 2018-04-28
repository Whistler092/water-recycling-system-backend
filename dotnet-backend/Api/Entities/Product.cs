namespace WaterRecycling.Entities
{
    public class Product
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public int IdTypeProduct { get; set; }
        public TypeProduct TypeProduct { get; set; }
    }
}
