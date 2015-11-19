using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnBoardService.Models
{
    public abstract class DatabaseUtility
    {
        protected SqlConnection _connection;
        public void ExecuteNonQuery(string sql)
        {
            SqlCommand cmd = new SqlCommand(sql, _connection);
            cmd.ExecuteNonQuery();
        }
    }
}