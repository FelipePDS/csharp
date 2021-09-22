using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRUDUsingMVC.Models
{
    public class Product
    {
        public int Id { get; set; }

        public string ProductName { get; set; }

        public string ProductDesc { get; set; }

        public decimal Cost { get; set; }

        public int Stock { get; set; }
    }
}