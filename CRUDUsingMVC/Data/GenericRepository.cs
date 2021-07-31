using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

//Refatorar:

//Adicionar parametros nos sqlcommand
//Fazer excessões de erros sql
//Melhorar conversão do entity type

namespace CRUDUsingMVC.Data
{
    public class GenericRepository<TEntity, TKey>
        where TEntity : class
    {
        private string _stringConnection = WebConfigurationManager.ConnectionStrings["SystemAdoNet"].ConnectionString;

        protected TEntity _entity;
        private string _entityName;

        public GenericRepository(TEntity entity)
        {
            _entity = entity;

            string[] entityObjectNames = _entity.ToString().Split('.');
            _entityName = entityObjectNames[entityObjectNames.Length - 1];
        }

        public List<TEntity> GetList(string sql)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                SqlCommand cmd = new SqlCommand(sql, db);

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
                                var entityType = entityProperty.PropertyType.ToString().Split('.')[1];
                                string entityPropertyName = entityProperty.Name;

                                switch (entityType)
                                {
                                    case "Int32":
                                        entityProperty.SetValue(entity, Convert.ToInt32(reader[entityPropertyName]));
                                        break;
                                    case "String":
                                        entityProperty.SetValue(entity, Convert.ToString(reader[entityPropertyName]));
                                        break;
                                    case "Decimal":
                                        entityProperty.SetValue(entity, Convert.ToDecimal(reader[entityPropertyName]));
                                        break;
                                    case "Char":
                                        entityProperty.SetValue(entity, Convert.ToChar(reader[entityPropertyName]));
                                        break;
                                    case "Byte":
                                        entityProperty.SetValue(entity, Convert.ToByte(reader[entityPropertyName]));
                                        break;
                                    case "Boolean":
                                        entityProperty.SetValue(entity, Convert.ToBoolean(reader[entityPropertyName]));
                                        break;
                                }
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

        public TEntity GetOne(string sql)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                SqlCommand cmd = new SqlCommand(sql, db);

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
                                    var entityPropertyType = entityProperty.PropertyType.ToString().Split('.')[1];
                                    string entityPropertyName = entityProperty.Name;

                                    switch (entityPropertyType)
                                    {
                                        case "Int32":
                                            entityProperty.SetValue(entity, Convert.ToInt32(reader[entityPropertyName]));
                                            break;
                                        case "String":
                                            entityProperty.SetValue(entity, Convert.ToString(reader[entityPropertyName]));
                                            break;
                                        case "Decimal":
                                            entityProperty.SetValue(entity, Convert.ToDecimal(reader[entityPropertyName]));
                                            break;
                                        case "Char":
                                            entityProperty.SetValue(entity, Convert.ToChar(reader[entityPropertyName]));
                                            break;
                                        case "Byte":
                                            entityProperty.SetValue(entity, Convert.ToByte(reader[entityPropertyName]));
                                            break;
                                        case "Boolean":
                                            entityProperty.SetValue(entity, Convert.ToBoolean(reader[entityPropertyName]));
                                            break;
                                    }
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

        public void Save(string sql)
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                using (var cmd = new SqlCommand(sql, db))
                {
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

        private string GetPrimaryKeyFromEntity()
        {
            using (var db = new SqlConnection(_stringConnection))
            {
                string sqlCommand = "SELECT " +
                                        "Col.Column_Name " +
                                    "FROM " +
                                        "INFORMATION_SCHEMA.TABLE_CONSTRAINTS Tab, " +
                                        "INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE Col " +
                                    "WHERE " +
                                        "Col.Constraint_Name = Tab.Constraint_Name " +
                                        "AND Col.Table_Name = Tab.Table_Name " +
                                        "AND Constraint_Type = 'PRIMARY KEY' " +
                                        "AND Col.Table_Name = '" + _entityName + "'";

                SqlCommand cmd = new SqlCommand(sqlCommand, db);

                string primaryKey = null;

                try
                {
                    db.Open();

                    using(var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
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

        public List<TEntity> GetAll()
        {
            try
            {
                string sqlCommand = @"SELECT * FROM " + _entityName;

                List<TEntity> entityList = GetList(sqlCommand);

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
                string primaryKeyName = GetPrimaryKeyFromEntity();

                string sqlCommand = @"SELECT * FROM " + _entityName + " WHERE " + primaryKeyName + " = " + id;

                TEntity entity = GetOne(sqlCommand);

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
                string primaryKeyName = GetPrimaryKeyFromEntity();

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
                    var entityPropertyValue = entityProperty.GetValue(entity);

                    if (entityPropertyName != primaryKeyName)
                    {
                        sqlCommandFieldNamesAndValues += entityPropertyValue + ", ";
                    }
                }

                sqlCommandFieldNamesAndValues += ")";

                sqlCommandFieldNamesAndValues = sqlCommandFieldNamesAndValues.Replace(", )", ")");

                string sqlCommandFull = sqlCommandBase + sqlCommandFieldNamesAndValues;

                Save(sqlCommandFull);
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
                string primaryKeyName = GetPrimaryKeyFromEntity();

                foreach (var entityProperty in entityProperties)
                {
                    string entityPropertyName = entityProperty.Name;
                    var entityPropertyValue = entityProperty.GetValue(entity);

                    if (entityPropertyName != primaryKeyName)
                    {
                        sqlCommandSetValues += entityPropertyName + "=" + entityPropertyValue + " ";
                    }
                }

                string sqlCommandFilterById = "WHERE " + primaryKeyName + "=" + id;

                string sqlCommandFull = sqlCommandBase + sqlCommandSetValues + sqlCommandFilterById;

                Save(sqlCommandFull);
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
                string primaryKeyName = GetPrimaryKeyFromEntity();

                string sqlCommand = "DELETE FROM " + _entityName + " WHERE " + primaryKeyName + " = " + id;

                Save(sqlCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
