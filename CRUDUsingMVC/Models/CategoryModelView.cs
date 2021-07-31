using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Models
{
    public class CategoryModelView : Category
    {
        public string ErrorMessage { get; set; }
    }
}