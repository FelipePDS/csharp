using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Data
{
    interface IProductRepository : IGenericRepository<Product, int>
    {
    }
}
