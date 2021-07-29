using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CRUDUsingMVC.Services;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Controllers
{
    public class CategoryController : Controller
    {
        private CategoryService _categoryService = new CategoryService();

        // GET: Category List
        [HttpGet]
        public ActionResult Index()
        {
            List<Category> categoryList = _categoryService.GetAll();

            return View(categoryList);
        }

        // GET: Edit Category
        [HttpGet]
        public ActionResult Edit(int id)
        {
            Category category = _categoryService.GetById(id);

            if (category == null)
            {
                return HttpNotFound();
            }

            return View(category);
        }
    }
}