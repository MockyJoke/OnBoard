using OnBoardService.Models.Users;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace OnBoardService.Models.Database
{
    public class DatabaseManager
    {
        private static DatabaseManager _instance = new DatabaseManager();
        private SqlConnection _connection;

        public bool IsInitialied { get; private set; }
        public static DatabaseManager Instance
        {
            get
            {
                return _instance ?? (_instance = new DatabaseManager());
            }
        }

        public SqlConnection Connection
        {
            get
            {
                return _connection;
            }
        }

        private DatabaseManager()
        {
            //_connection = new SqlConnection(OnBoardResource.LocalDatabaseConStr);
            _connection = new SqlConnection(OnBoardResource.RemoteDatabaseConstr);
        }

        /// <summary>
        /// Try to make a connection to the sql server
        /// </summary>
        /// <returns>Returns true if the connection is opened correctly</returns>
        public async Task<bool> InitializeAsync()
        {
            try
            {
                await _connection.OpenAsync().ConfigureAwait(false);
            }
            catch
            {
                return false;
            }
            IsInitialied = true;
            return true;
        }
    }
}