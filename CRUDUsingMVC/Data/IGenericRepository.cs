using System.Collections.Generic;

namespace CRUDUsingMVC.Data
{
    public interface IGenericRepository<TEntity, TKey>
        where TEntity : class
    {
        List<TEntity> Fetch(string sql, object parameters);
        List<T> Fetch<T>(string sql, object parameters);

        TEntity Single(string sql, object parameters);
        T Single<T>(string sql, object parameters);

        void Save(string sql, object parameters);

        List<TEntity> GetAll();
        List<T> GetAll<T>();

        TEntity GetById(TKey id);
        TEntity GetById(TKey id, string primaryKeyName);
        T GetById<T>(TKey id);
        T GetById<T>(TKey id, string primaryKeyName);

        void Create(TEntity entity);

        void UpdateById(TEntity entity, TKey id);
        void UpdateById(TEntity entity, TKey id, string primaryKeyName);

        void DeleteById(TKey id);
        void DeleteById(TKey id, string primaryKeyName);
    }
}
