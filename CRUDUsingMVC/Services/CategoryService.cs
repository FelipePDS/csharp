using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CRUDUsingMVC.Data;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Services
{
    public class CategoryService
    {
        private CategoryRepository _categoryRepository = new CategoryRepository(new Category());

        public List<Category> GetAll()
        {
            try
            {
                List<Category> categoryList = _categoryRepository.GetAll();

                return categoryList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Category GetById(int id)
        {
            try
            {
                Category category = _categoryRepository.GetById(id);

                return category;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}