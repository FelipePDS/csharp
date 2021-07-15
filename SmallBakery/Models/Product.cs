using System.ComponentModel.DataAnnotations;

namespace SmallBakery.Models
{
    public class Product
    {
        public int IdProduct { get; set; }

        [Required(ErrorMessage = "Field 'Name' is required")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Field 'Description' is required")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Field 'Price' is required")]
        public decimal Price { get; set; }
    }
}