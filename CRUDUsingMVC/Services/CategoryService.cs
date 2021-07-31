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

        public void Create(Category category)
        {
            try
            {
                if (category != null)
                {
                    _categoryRepository.Create(category);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateById(Category category, int id)
        {
            try
            {
                if (category != null)
                {
                    _categoryRepository.UpdateById(category, id);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteById(int id)
        {
            try
            {
                _categoryRepository.DeleteById(id);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}