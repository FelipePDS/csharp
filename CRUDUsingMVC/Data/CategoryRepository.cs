using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Data
{
    public class CategoryRepository : GenericRepository<Category, int>
    {
        public CategoryRepository(Category category)
            : base(category)
        {
            _entity = category;
        }
    }
}