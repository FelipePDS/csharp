using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CRUDUsingMVCWithAdoNet.Models;

namespace CRUDUsingMVCWithAdoNet.Data
{
    public class PessoaRepository : AbstractRepository<Pessoa, int>
    {
        public override void Delete(Pessoa entity)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                string sql = "DELETE Pessoa WHERE ID=@ID";
                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@ID", entity.ID);

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
                string sql = "DELETE Pessoa WHERE ID=@ID";
                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@ID", id);

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

        public override List<Pessoa> GetAll()
        {
            string sql = "SELECT ID, Nome, Email, Cidade, Endereco FROM Pessoa ORDER BY Nome";

            using (var db = new SqlConnection(StringConnection))
            {
                SqlCommand cmd = new SqlCommand(sql, db);
                List<Pessoa> list = new List<Pessoa>();
                Pessoa p = null;
                
                try
                {
                    db.Open();
                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        while (reader.Read())
                        {
                            p = new Pessoa();
                            p.ID = (int)reader["ID"];
                            p.Nome = reader["Nome"].ToString();
                            p.Email = reader["Email"].ToString();
                            p.Cidade = reader["Cidade"].ToString();
                            p.Endereco = reader["Endereco"].ToString();
                            list.Add(p);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }

                return list;
            }
        }

        public override Pessoa GetById(int id)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                string sql = "SELECT ID, Nome, Email, Cidade, Endereco FROM Pessoa WHERE ID=@ID";
                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@ID", id);
                Pessoa p = null;

                try
                {
                    db.Open();
                    using (var reader = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                p = new Pessoa();
                                p.ID = (int)reader["ID"];
                                p.Nome = reader["Nome"].ToString();
                                p.Email = reader["Email"].ToString();
                                p.Cidade = reader["Cidade"].ToString();
                                p.Endereco = reader["Endereco"].ToString();
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

        public override void Save(Pessoa entity)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                var sql = "INSERT INTO Pessoa (Nome, Email, Cidade, Endereco) VALUES (@Nome, @Email, @Cidade, @Endereco)";
                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@Nome", entity.Nome);
                cmd.Parameters.AddWithValue("@Email", entity.Email);
                cmd.Parameters.AddWithValue("@Cidade", entity.Cidade);
                cmd.Parameters.AddWithValue("@Endereco", entity.Endereco);

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

        public override void Update(Pessoa entity)
        {
            using (var db = new SqlConnection(StringConnection))
            {
                var sql = "UPDATE Pessoa SET Nome=@Nome, Email=@Email, Cidade=@Cidade, Endereco=@Endereco WHERE ID=@ID";
                SqlCommand cmd = new SqlCommand(sql, db);
                cmd.Parameters.AddWithValue("@Nome", entity.Nome);
                cmd.Parameters.AddWithValue("@Email", entity.Email);
                cmd.Parameters.AddWithValue("@Cidade", entity.Cidade);
                cmd.Parameters.AddWithValue("@Endereco", entity.Endereco);
                cmd.Parameters.AddWithValue("@ID", entity.ID);

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