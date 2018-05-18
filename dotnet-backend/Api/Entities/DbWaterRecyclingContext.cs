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
                const string serverName = "mysql";
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

        public DbSet<Device> Devices { get; set; }
        public DbSet<RecyclingProcess> RecyclingProcesses { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
                    modelBuilder.Entity<RecyclingProcess>()
                    .HasOne(p => p.From)
                    .WithMany(b => b.RecyclingProcessList)
                    .HasForeignKey(f=> f.IdFrom);
        }
    }
}
