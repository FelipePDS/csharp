using System;
using System.Collections.Generic;
using System.Web.Mvc;
using CRUDUsingMVC.Services;
using CRUDUsingMVC.Models;
using Unity;
using CRUDUsingMVC;

namespace CRUDUsingMVC.Controllers
{
    public class CategoryController : Controller
    {
        //static readonly IUnityContainer container = new UnityContainer();

        //private readonly ICategoryService _categoryService = container.Resolve<ICategoryService>();

        private CategoryService _categoryService = new CategoryService();

        [HttpGet]
        public ActionResult Index()
        {
            try
            {
                List<Category> categoryList = _categoryService.GetAll();

                return View(categoryList);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public ActionResult Create()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public ActionResult Create(Category category)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _categoryService.Create(category);

                    return RedirectToAction("Edit", new { id = category.Id });
                }

                return View(new { category, ErrorMessage = "Fill in all information to create a new category!" });
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public ActionResult Edit(int id)
        {
            try
            {
                Category category = _categoryService.GetById(id);

                if (category == null)
                {
                    return HttpNotFound();
                }

                return View(category);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public ActionResult Edit(Category category)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _categoryService.UpdateById(category, category.Id);
                    return RedirectToAction("Index");
                }

                return View(new { category, ErrorMessage = "Fill in all information to edit category!" });
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpDelete]
        public ActionResult Delete(int id)
        {
            try
            {
                _categoryService.DeleteById(id);

                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
