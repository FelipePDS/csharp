using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
using OfficeOpenXml;
using ExcelGenerator.Models;

namespace ExcelGenerator.Controllers
{
    public class UsersController : Controller
    {
        private AspNetExcelGeneratorDBContext db = new AspNetExcelGeneratorDBContext();

        // GET: Users
        public ActionResult Index(string searchString)
        {
            var userList = from u in db.Users select u;

            if (!String.IsNullOrEmpty(searchString))
            {
                userList = userList.Where(user => user.Name.Contains(searchString));
            }

            UserViewModel data = new UserViewModel()
            {
                UserList = userList,
                SearchString = searchString
            };

            return View(data);
        }

        // GET: Users/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Users/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name,Email")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(user);
        }

        // GET: Users/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Users/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name,Email")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(user);
        }

        // GET: Users/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            User user = db.Users.Find(id);
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpPost]
        public ActionResult ExportUserDataToExcelEPPlus(IList<User> userList)
        {
            DataTable dataTable = new DataTable("User Data");

            dataTable.Columns.Add("User Name");
            dataTable.Columns.Add("Email");

            foreach (var user in userList)
            {
                dataTable.Rows.Add(user.Name, user.Email);
            }

            string filePath = "~/Template/Template.xlsx";

            FileInfo fileInfoTemplate = new FileInfo(System.Web.HttpContext.Current.Server.MapPath(filePath));

            ExcelPackage excel = new ExcelPackage(fileInfoTemplate);

            ExcelWorksheet worksheet = excel.Workbook.Worksheets.Add("Teste");
            worksheet.Name = "User Data";
            worksheet.TabColor = Color.Black;
            worksheet.Cells["A1"].LoadFromDataTable(dataTable, true);

            MemoryStream stream = new MemoryStream();

            excel.SaveAs(stream);

            HttpContext.Response.Clear();
            HttpContext.Response.AddHeader(
                "content-disposition",
                string.Format("attachment;filename=Teste_{0}.xlsx", DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss"))
            );

            HttpContext.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Response.ContentEncoding = Encoding.Default;

            HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);

            stream.WriteTo(Response.OutputStream);

            Response.End();

            return null;
        }

        [HttpPost]
        public ActionResult ExportUserDataToExcelGoogleLibrary(List<User> users)
        {
            // Adicionar código de exportar para excel

            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
