using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace OnBoardService.Models.Groups
{
    public class GroupsUtility :DatabaseUtility
    {
        public GroupsUtility (SqlConnection connection)
        {
            _connection = connection;
        }

        public async Task<List<Group>> GetAllGroups()
        {
            string sql = string.Format(OnBoardResource.Sql_GroupGetAllGroups);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            List<Group> result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {

                    await reader.ReadAsync().ConfigureAwait(false);
                    if (result == null)
                    {
                        result = new List<Group>();
                    }
                        result.Add(Group.ParseGroupFromSqlRow(reader));
                }
            }
            return result;
        }

        public async Task<Group> GetGroupByIdAsync(string groupId)
        {
            string sql = string.Format(OnBoardResource.Sql_UserGetUserById_Id, groupId);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            Group result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    
                    await reader.ReadAsync().ConfigureAwait(false);
                    if(result == null)
                    result = Group.ParseGroupFromSqlRow(reader);
                }
            }
            return result;
        }


        public void CreateGroup()
        {

        }

        /*public async Task<User> CreateUserAsync(string nickName)
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
        }*/
    }
}