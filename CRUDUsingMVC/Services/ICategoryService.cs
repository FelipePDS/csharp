using System.Collections.Generic;
using CRUDUsingMVC.Models;

namespace CRUDUsingMVC.Services
{
    public interface ICategoryService
    {
        List<Category> GetAll();

        Category GetById(int id);

        void Create(Category category);

        void UpdateById(Category category, int id);

        void DeleteById(int id);
    }
}
