using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRUDUsingMVC.Data
{
    public interface IGenericRepository<TEntity, TKey>
        where TEntity : class
    {
        List<TEntity> GetList(string sql);

        TEntity GetOne(string sql);

        void Save(string sql);

        List<TEntity> GetAll();

        TEntity GetById(TKey id);

        void Create(TEntity entity);

        void UpdateById(TEntity entity, TKey id);

        void DeleteById(TKey id);
    }
}
