using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Stud.Factory
{
    public class SqlDbConnections
    {
        private readonly IConfiguration configuration;
        public SqlDbConnections(IConfiguration config)
        {
            this.configuration = config;
        }
    }
    public class SelectQuery
    {
        public DataSet fnSelectQuery(string query, SqlParameter[] sqlParams, SqlConnection selectCon)
        {
            try
            {
                using (selectCon)
                {
                    var cmd = new SqlCommand(query, selectCon);
                    cmd.CommandTimeout = 0;
                    if (sqlParams != null)
                    {
                        foreach (SqlParameter para in sqlParams)
                        {
                            if (para != null)
                                cmd.Parameters.Add(para);
                        }
                    }
                    using (var sda = new SqlDataAdapter())
                    {
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            sda.Fill(ds);
                            cmd.Parameters.Clear();
                            selectCon.Close();
                            return ds;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                selectCon.Close();
            }
        }
        public DataSet fnSelectQueryUsingStoredProc(string query, SqlParameter[] sqlParams, SqlConnection selectCon)
        {
            try
            {
                using (selectCon)
                {
                    var cmd = new SqlCommand(query, selectCon);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandTimeout = 0;
                    if (sqlParams != null)
                    {
                        foreach (SqlParameter para in sqlParams)
                        {
                            if (para != null)
                                cmd.Parameters.Add(para);
                        }
                    }
                    using (var sda = new SqlDataAdapter())
                    {
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            sda.Fill(ds);
                            cmd.Parameters.Clear();
                            selectCon.Close();
                            return ds;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + "-" + query);
            }
            finally
            {
                selectCon.Close();
            }
        }
    }

    public class InsertQuery
    {
        string output = string.Empty;
        DataSet ds = new DataSet();
        public void fnInsertQuery(string query, SqlParameter[] sqlParams, SqlConnection insCon)
        {
            try
            {
                using (insCon)
                {
                    var cmd = new SqlCommand(query, insCon);
                    if (sqlParams != null)
                    {
                        foreach (SqlParameter para in sqlParams)
                        {
                            if (para != null)
                                cmd.Parameters.Add(para);
                        }
                    }
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    insCon.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + "-" + query);
            }
            finally
            {
                insCon.Close();
            }
        }

        public void fnInsertQueryUsinStoredProc(string query, SqlParameter[] sqlParams, SqlConnection insCon)
        {
            try
            {
                using (insCon)
                {
                    var cmd = new SqlCommand(query, insCon);
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (sqlParams != null)
                    {
                        foreach (SqlParameter para in sqlParams)
                        {
                            if (para != null)
                                cmd.Parameters.Add(para);
                        }
                    }
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    insCon.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + "-" + query);
            }
            finally
            {
                insCon.Close();
            }
        }
    }
    public class UpdateQuery
    {
        public void fnUpdateQuery(string query, SqlParameter[] sqlParams, SqlConnection updateCon)

        {
            try
            {
                using (updateCon)
                {
                    var cmd = new SqlCommand(query, updateCon);
                    if (sqlParams != null)
                    {
                        foreach (SqlParameter para in sqlParams)
                        {
                            if (para != null)
                                cmd.Parameters.Add(para);
                        }
                    }
                    SqlDataReader dr;
                    dr = cmd.ExecuteReader();
                    cmd.Parameters.Clear();
                    updateCon.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                updateCon.Close();
            }
        }

        public void fnUpdateQueryUsinStoredProc(string query, SqlParameter[] sqlParams, SqlConnection updateCon)
        {
            try
            {
                using (updateCon)
                {
                    var cmd = new SqlCommand(query, updateCon);
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (sqlParams != null)
                    {
                        foreach (SqlParameter para in sqlParams)
                        {
                            if (para != null)
                                cmd.Parameters.Add(para);
                        }
                    }
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    updateCon.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                updateCon.Close();
            }
        }
    }
    public class DeleteQuery
    {
        public void fnDeleteQuery(string query, SqlParameter[] sqlParams, SqlConnection delCon)
        {
            try
            {
                using (delCon)
                {
                    var cmd = new SqlCommand(query, delCon);
                    if (sqlParams != null)
                    {
                        foreach (SqlParameter para in sqlParams)
                        {
                            if (para != null)
                                cmd.Parameters.Add(para);
                        }
                    }
                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    delCon.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                delCon.Close();
            }
        }
    }
}
