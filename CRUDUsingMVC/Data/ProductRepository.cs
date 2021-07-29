using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Data
{
    public class ProductRepository : GenericRepository<Product, int>
    {
        public ProductRepository(Product product)
            : base(product)
        {
            _entity = product;
        }
    }
}