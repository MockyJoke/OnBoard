using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace OnBoardService.Models.Users
{
    public class UsersUtility : DatabaseUtility
    {
        public UsersUtility(SqlConnection connection)
        {
            _connection = connection;
        }

        public async Task<User> GetUserByUserIdAsync(string userId)
        {
            string sql = string.Format(OnBoardResource.Sql_UserGetUserById_Id, userId);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            User result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync().ConfigureAwait(false);
                    result = User.ParseUserFromSqlRow(reader);
                }
            }
            return result;
        }

        public async Task<User> GetUserByUserNickNameAsync(string nickName)
        {
            string sql = string.Format(OnBoardResource.Sql_UserGetUserByNickName_NickName, nickName);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            User result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync().ConfigureAwait(false);
                    result = User.ParseUserFromSqlRow(reader);
                }
            }
            return result;
        }

        public async Task<string> GetMaxUserId()
        {
            string sql = string.Format(OnBoardResource.Sql_UserGetMaxUserId);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            string result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync().ConfigureAwait(false);
                    result = reader.GetString(0);
                }
            }
            return result;
        }

        public async Task<List<User>> GetUsersByGroupIdAsync(string groupId)
        {
            string sql = string.Format(OnBoardResource.Sql_UserGetUsersByGroupId_GroupId, groupId);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            List<User> result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    if (result == null)
                    {
                        result = new List<User>();
                    }
                    await reader.ReadAsync().ConfigureAwait(false);
                    result.Add(User.ParseUserFromSqlRow(reader));
                }
            }
            return result;
        }

        public async Task<List<User>> GetAllUsers()
        {
            string sql = string.Format(OnBoardResource.Sql_UserGetAllUsers);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            List<User> result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    if (result == null)
                    {
                        result = new List<User>();
                    }
                    await reader.ReadAsync().ConfigureAwait(false);
                    result.Add(User.ParseUserFromSqlRow(reader));
                }
            }
            return result;
        }


        public async Task<User> CreateUserAsync(string nickName)
        {
            User result = await GetUserByUserNickNameAsync(nickName).ConfigureAwait(false);
            if (result == null)
            {
                int maxUserId = 0;
                try
                {
                    maxUserId = Convert.ToInt32(await GetMaxUserId().ConfigureAwait(false));
                }
                catch
                {
                    maxUserId = 0;
                }
                int newUserId = maxUserId + 1;
                string sql = string.Format(OnBoardResource.Sql_UserInsertUser_Id_NickName_GroupId,
                    newUserId.ToString(),
                    nickName,
                    0.ToString());
                ExecuteNonQuery(sql);
                result = await GetUserByUserIdAsync(newUserId.ToString());
            }
            else
            {
                // A user with the same nickname already exist
                string sql = string.Format(OnBoardResource.Sql_UserUpdateUserById_Id_Nickname_GroupId,
                    result.Id,
                    result.NickName,
                    result.GroupId);
                ExecuteNonQuery(sql);
            }
            return result;
        }

        public User UpdateUser(User user)
        {
            string sql = string.Format(OnBoardResource.Sql_UserUpdateUserById_Id_Nickname_GroupId,
                    user.Id,
                    user.NickName,
                    user.GroupId);
            ExecuteNonQuery(sql);
            return user;
        }


    }
}