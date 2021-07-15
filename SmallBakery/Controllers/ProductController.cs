using System.Web.Mvc;
using SmallBakery.Data;
using SmallBakery.Models;

namespace SmallBakery.Controllers
{
    public class ProductController : Controller
    {
        private ProductRepository productRepository = new ProductRepository();

        public ActionResult Index()
        {
            return View(productRepository.GetAll());
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Product product)
        {
            if (ModelState.IsValid)
            {
                productRepository.Save(product);
                return RedirectToAction("Index");
            }

            return View(product);
        }

        public ActionResult Edit(int id)
        {
            var product = productRepository.GetById(id);

            if (product == null)
            {
                return HttpNotFound();
            }

            return View(product);
        }

        [HttpPost]
        public ActionResult Edit(Product product)
        {
            if (ModelState.IsValid)
            {
                productRepository.Update(product);
            }

            return View(product);
        }

        [HttpDelete]
        public ActionResult Delete(int id)
        {
            productRepository.DeleteById(id);

            return RedirectToAction("Index");
        }
    }
}