using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SmallBakery.Models;

namespace SmallBakery.Data
{
    public class ProductRepository : AbstractRepository<Product, int>
    {
        public override List<Product> GetAll()
        {
            using (var db = new SqlConnection(StringConnection))
            {
                string sql = "SELECT IdProduct, Name, Description, Price FROM product";
                SqlCommand cmd = new SqlCommand(sql, db);

                List<Product> listProduct = new List<Product>();
                Product p = null;

                try
                {
                    db.Open();
                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (reader.Read())
                        {
                            p = new Product();
                            p.IdProduct = (int)reader["IdProduct"];
                            p.Name = reader["Name"].ToString();
                            p.Description = reader["Description"].ToString();
                            p.Price = (decimal)reader["Price"];

                            listProduct.Add(p);
                        }
                    }
                }
                catch (Exception ex) 
                {
                    throw ex;
                }

                return listProduct;
            }
        }

        public override Product GetById(int id)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                string sql = "SELECT IdProduct, Name, Description, Price FROM product WHERE IdProduct = @Id";
                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@Id", id);

                Product p = null;

                try
                {
                    db.Open();

                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                p = new Product();
                                p.IdProduct = (int)reader["IdProduct"];
                                p.Name = reader["Name"].ToString();
                                p.Description = reader["Description"].ToString();
                                p.Price = (decimal)reader["Price"];
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                return p;
            }
        }

        public override void Save(Product entity)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                string sql = "INSERT INTO product (Name, Description, Price) VALUES (@Name, @Description, @Price)";
                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@Name", entity.Name);
                cmd.Parameters.AddWithValue("@Description", entity.Description);
                cmd.Parameters.AddWithValue("@Price", entity.Price);

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

        public override void Update(Product entity)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                string sql = "UPDATE product SET Name=@Name, Description=@Description, Price=@Price WHERE IdProduct=@Id";

                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@Name", entity.Name);
                cmd.Parameters.AddWithValue("@Description", entity.Description);
                cmd.Parameters.AddWithValue("@Price", entity.Price);
                cmd.Parameters.AddWithValue("@Id", entity.IdProduct);

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

        public override void DeleteById(int id)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                string sql = "DELETE product WHERE IdProduct=@Id";

                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@Id", id);

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
}