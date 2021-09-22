using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

//Refatorar:

//Adicionar dependency injection

namespace CRUDUsingMVC.Data
{
    public class GenericRepository<TEntity, TKey> : IGenericRepository<TEntity, TKey>
        where TEntity : class
    {
        private string _stringConnection = WebConfigurationManager.ConnectionStrings["SystemAdoNet"].ConnectionString;

        private TEntity _entity;
        private string _entityName;

        protected GenericRepository()
        {
            _entity = Activator.CreateInstance<TEntity>();
            _entityName = _entity.GetType().Name;
        }

        public List<TEntity> Fetch(string sql, object parameters = null)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                SqlCommand cmd = new SqlCommand(sql, db);

                SqlParameterMap(cmd, parameters);

                TEntity entity = _entity;
                List<TEntity> entityList = new List<TEntity>();
                var entityProperties = entity.GetType().GetProperties();

                try
                {
                    db.Open();

                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (reader.Read())
                        {
                            foreach (var entityProperty in entityProperties)
                            {
                                var entityPropertyType = entityProperty.PropertyType.Name;
                                string entityPropertyName = entityProperty.Name;

                                entityProperty.SetValue(
                                    entity,
                                    ConvertValueTypeToPropertyType(reader[entityPropertyName], entityPropertyType)
                                );
                            }

                            entityList.Add(entity);
                        }

                        return entityList;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public List<T> Fetch<T>(string sql, object parameters = null)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                SqlCommand cmd = new SqlCommand(sql, db);

                SqlParameterMap(cmd, parameters);

                T entity = Activator.CreateInstance<T>();
                List<T> entityList = new List<T>();
                var entityProperties = entity.GetType().GetProperties();

                try
                {
                    db.Open();

                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (reader.Read())
                        {
                            foreach (var entityProperty in entityProperties)
                            {
                                var entityPropertyType = entityProperty.PropertyType.Name;
                                string entityPropertyName = entityProperty.Name;

                                entityProperty.SetValue(
                                    entity,
                                    ConvertValueTypeToPropertyType(reader[entityPropertyName], entityPropertyType)
                                );
                            }

                            entityList.Add(entity);
                        }

                        return entityList;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public TEntity Single(string sql, object parameters = null)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                SqlCommand cmd = new SqlCommand(sql, db);

                SqlParameterMap(cmd, parameters);

                TEntity entity = _entity;
                var entityProperties = entity.GetType().GetProperties();

                try
                {
                    db.Open();

                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                foreach (var entityProperty in entityProperties)
                                {
                                    string entityPropertyType = entityProperty.PropertyType.Name;
                                    string entityPropertyName = entityProperty.Name;

                                    entityProperty.SetValue(
                                        entity,
                                        ConvertValueTypeToPropertyType(reader[entityPropertyName], entityPropertyType)
                                    );
                                }
                            }
                        }

                        return entity;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public T Single<T>(string sql, object parameters = null)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                SqlCommand cmd = new SqlCommand(sql, db);

                SqlParameterMap(cmd, parameters);

                T entity = Activator.CreateInstance<T>();
                var entityProperties = entity.GetType().GetProperties();

                try
                {
                    db.Open();

                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                foreach (var entityProperty in entityProperties)
                                {
                                    string entityPropertyType = entityProperty.PropertyType.Name;
                                    string entityPropertyName = entityProperty.Name;

                                    entityProperty.SetValue(
                                        entity,
                                        ConvertValueTypeToPropertyType(reader[entityPropertyName], entityPropertyType)
                                    );
                                }
                            }
                        }

                        return entity;
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public void Save(string sql, object parameters = null)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                using (var cmd = new SqlCommand(sql, db))
                {
                    SqlParameterMap(cmd, parameters);

                    try
                    {
                        db.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
        }

        public List<TEntity> GetAll()
        {
            try
            {
                string sqlCommand = @"SELECT * FROM " + _entityName;

                List<TEntity> entityList = Fetch(sqlCommand);

                return entityList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<T> GetAll<T>()
        {
            try
            {
                var entity = Activator.CreateInstance<T>();
                var entityName = entity.GetType().Name;

                string sqlCommand = @"SELECT * FROM " + entityName;

                List<T> entityList = Fetch<T>(sqlCommand);

                return entityList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public TEntity GetById(TKey id)
        {
            try
            {
                string primaryKeyName = GetPrimaryKeyFromEntity<TEntity>();

                string sqlCommand = @"SELECT * FROM " + _entityName + " WHERE " + primaryKeyName + " = @id";

                TEntity entity = Single(sqlCommand, new { id });

                return entity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public TEntity GetById(TKey id, string primaryKeyName)
        {
            try
            {
                string sqlCommand = @"SELECT * FROM " + _entityName + " WHERE " + primaryKeyName + " = @id";

                TEntity entity = Single(sqlCommand, new { id });

                return entity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public T GetById<T>(TKey id)
        {
            try
            {
                var entity = Activator.CreateInstance<T>();
                var entityName = entity.GetType().Name;

                string primaryKeyName = GetPrimaryKeyFromEntity<T>();

                string sqlCommand = @"SELECT * FROM " + entityName + " WHERE " + primaryKeyName + " = @id";

                entity = Single<T>(sqlCommand, new { id });

                return entity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public T GetById<T>(TKey id, string primaryKeyName)
        {
            try
            {
                var entity = Activator.CreateInstance<T>();
                var entityName = entity.GetType().Name;

                string sqlCommand = @"SELECT * FROM " + entityName + " WHERE " + primaryKeyName + " = @id";

                entity = Single<T>(sqlCommand, new { id });

                return entity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void Create(TEntity entity)
        {
            try
            {
                string sqlCommandBase = "INSERT INTO " + _entityName + " ";
                string sqlCommandFieldNamesAndValues = "(";

                var entityProperties = entity.GetType().GetProperties();
                string primaryKeyName = GetPrimaryKeyFromEntity<TEntity>();

                foreach (var entityProperty in entityProperties)
                {
                    string entityPropertyName = entityProperty.Name;

                    if (entityPropertyName != primaryKeyName)
                    {
                        sqlCommandFieldNamesAndValues += entityPropertyName + ", ";
                    }
                }

                sqlCommandFieldNamesAndValues += ") VALUES (";

                foreach (var entityProperty in entityProperties)
                {
                    string entityPropertyName = entityProperty.Name;

                    if (entityPropertyName != primaryKeyName)
                    {
                        sqlCommandFieldNamesAndValues += "@" + entityPropertyName + ", ";
                    }
                }

                sqlCommandFieldNamesAndValues += ")";

                sqlCommandFieldNamesAndValues = sqlCommandFieldNamesAndValues.Replace(", )", ")");

                string sqlCommandFull = sqlCommandBase + sqlCommandFieldNamesAndValues;

                Save(sqlCommandFull, entity);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateById(TEntity entity, TKey id)
        {
            try
            {
                string sqlCommandBase = "UPDATE " + _entityName + " SET ";
                string sqlCommandSetValues = "";

                var entityProperties = entity.GetType().GetProperties();
                string primaryKeyName = GetPrimaryKeyFromEntity<TEntity>();

                foreach (var entityProperty in entityProperties)
                {
                    string entityPropertyName = entityProperty.Name;

                    if (entityPropertyName != primaryKeyName)
                    {
                        sqlCommandSetValues += entityPropertyName + "= @" + entityPropertyName + " ";
                    }
                }

                string sqlCommandFilterById = "WHERE " + primaryKeyName + "= @id";

                string sqlCommandFull = sqlCommandBase + sqlCommandSetValues + sqlCommandFilterById;

                Save(sqlCommandFull, new { entity, id });
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateById(TEntity entity, TKey id, string primaryKeyName)
        {
            try
            {
                string sqlCommandBase = "UPDATE " + _entityName + " SET ";
                string sqlCommandSetValues = "";

                var entityProperties = entity.GetType().GetProperties();

                foreach (var entityProperty in entityProperties)
                {
                    string entityPropertyName = entityProperty.Name;

                    if (entityPropertyName != primaryKeyName)
                    {
                        sqlCommandSetValues += entityPropertyName + "= @" + entityPropertyName + " ";
                    }
                }

                string sqlCommandFilterById = "WHERE " + primaryKeyName + "= @id";

                string sqlCommandFull = sqlCommandBase + sqlCommandSetValues + sqlCommandFilterById;

                Save(sqlCommandFull, new { entity, id });
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteById(TKey id)
        {
            try
            {
                string primaryKeyName = GetPrimaryKeyFromEntity<TEntity>();

                string sqlCommand = @"DELETE FROM " + _entityName + " WHERE " + primaryKeyName + " = " + id;

                Save(sqlCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteById(TKey id, string primaryKeyName)
        {
            try
            {
                string sqlCommand = @"DELETE FROM " + _entityName + " WHERE " + primaryKeyName + " = " + id;

                Save(sqlCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string GetPrimaryKeyFromEntity<T>()
        {
            var entity = Activator.CreateInstance<T>();
            var entityName = entity.GetType().Name;

            using (var db = new SqlConnection(_stringConnection))
            {
                string sqlCommand = @"SELECT 
                                        Col.Column_Name 
                                    FROM 
                                        INFORMATION_SCHEMA.TABLE_CONSTRAINTS Tab, 
                                        INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE Col 
                                    WHERE 
                                        Col.Constraint_Name = Tab.Constraint_Name 
                                        AND Col.Table_Name = Tab.Table_Name 
                                        AND Constraint_Type = 'PRIMARY KEY' 
                                        AND Col.Table_Name = @entityName";

                SqlCommand cmd = new SqlCommand(sqlCommand, db);
                cmd.Parameters.AddWithValue("@entityName", entityName);

                string primaryKey = null;

                try
                {
                    db.Open();

                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                primaryKey = reader[0].ToString();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                return primaryKey;
            }
        }

        private void SqlParameterMap(SqlCommand cmd, object parameters)
        {
            if (parameters == null) return;

            foreach (var parameter in parameters.GetType().GetProperties())
            {
                string parameterName = $"@{parameter.Name}";
                object parameterValue = parameter.GetValue(parameters);

                cmd.Parameters.AddWithValue(
                    parameterName,
                    ConvertValueTypeToPropertyType(parameterValue, parameterValue.GetType().Name)
                );
            }
        }

        private object ConvertValueTypeToPropertyType(object value, string propertyTypeName)
        {
            switch (propertyTypeName)
            {
                case "Int32":
                    return Convert.ToInt32(value);
                case "String":
                    return Convert.ToString(value);
                case "Decimal":
                    return Convert.ToDecimal(value);
                case "Char":
                    return Convert.ToChar(value);
                case "Byte":
                    return Convert.ToByte(value);
                case "Boolean":
                    return Convert.ToBoolean(value);
                case "DateTime":
                    return Convert.ToDateTime(value);
                default:
                    return Convert.ToDouble(value);
            }
        }
    }
}
