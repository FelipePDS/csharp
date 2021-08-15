using System.Data.Entity;

namespace ExcelGenerator.Models
{
    public class User
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }
    }

    public class AspNetExcelGeneratorDBContext : DbContext
    {
        public DbSet<User> Users { get; set; }
    }
}