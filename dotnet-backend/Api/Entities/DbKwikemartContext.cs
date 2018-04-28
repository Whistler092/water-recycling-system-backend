namespace WaterRecycling.Entities
{
    using System;
    using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
    using Microsoft.EntityFrameworkCore;

    public class DbWaterRecyclingContext : IdentityDbContext<User>
    {
        public DbWaterRecyclingContext(DbContextOptions<DbWaterRecyclingContext> options)
            : base(options)
        {

        }

        public DbWaterRecyclingContext()
        : base()
        {
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
                    => optionsBuilder.UseMySQL(connectionString: ConnectionString);

        private static string ConnectionString
        {
            get
            {
                const string serverName = "127.0.0.1";
                const string databaseName = "water-recycling";
                const string databaseUser = "root";
                const string databasePass = "12345";

                return $"Server={serverName};" +
                       $"database={databaseName};" +
                       $"uid={databaseUser};" +
                       $"pwd={databasePass};" +
                       $"pooling=true;";
            }
        }
        public new DbSet<User> Users { get; set; }
        public new DbSet<Role> Roles { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<TypeProduct> TypeProducts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
                        modelBuilder.Entity<Product>()
            .HasOne(p => p.TypeProduct)
            .WithMany(b => b.Products)
            .HasForeignKey(f=> f.IdTypeProduct);
        }
    }
}
