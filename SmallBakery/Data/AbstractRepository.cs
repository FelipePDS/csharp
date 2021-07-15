using System.Collections.Generic;
using System.Web.Configuration;

namespace SmallBakery
{
    public abstract class AbstractRepository<TEntity, Tkey>
        where TEntity : class
    {
        protected string StringConnection { get; } = WebConfigurationManager.ConnectionStrings["SmallBakery"].ConnectionString;

        public abstract List<TEntity> GetAll();
        public abstract TEntity GetById(Tkey id);
        public abstract void Save(TEntity entity);
        public abstract void Update(TEntity entity);
        public abstract void DeleteById(Tkey id);
    }
}