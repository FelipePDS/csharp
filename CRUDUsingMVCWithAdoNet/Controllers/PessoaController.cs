using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CRUDUsingMVCWithAdoNet.Data;
using CRUDUsingMVCWithAdoNet.Models;

namespace CRUDUsingMVCWithAdoNet.Controllers
{
    public class PessoaController : Controller
    {
        private PessoaRepository repository = new PessoaRepository();

        public ActionResult Index()
        {
            return View(repository.GetAll());
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Pessoa pessoa)
        {
            if (ModelState.IsValid)
            {
                repository.Save(pessoa);
                return RedirectToAction("Index");
            }

            return View(pessoa);
        }

        public ActionResult Edit(int id)
        {
            var pessoa = repository.GetById(id);

            if (pessoa == null)
            {
                return HttpNotFound();
            }

            return View(pessoa);
        }

        [HttpPost]
        public ActionResult Edit(Pessoa pessoa)
        {
            if (ModelState.IsValid)
            {
                repository.Update(pessoa);
                return RedirectToAction("Index");
            }

            return View(pessoa);
        }

        [HttpDelete]
        public ActionResult Delete(int id)
        {
            repository.DeleteById(id);

            return Json(repository.GetAll());
        }
    }
}