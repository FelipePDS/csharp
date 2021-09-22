using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Data
{
    public interface ICategoryRepository : IGenericRepository<Category, int>
    {
    }
}