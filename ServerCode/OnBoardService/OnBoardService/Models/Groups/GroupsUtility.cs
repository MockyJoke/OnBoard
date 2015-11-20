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

        public async Task<List<Group>> GetAllGroupsAsync()
        {
            string sql = string.Format(OnBoardResource.Sql_GroupGetAllGroups);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            List<Group> result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                while (await reader.ReadAsync().ConfigureAwait(false))
                {
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
            string sql = string.Format(OnBoardResource.Sql_GroupGetGroupById_Id, groupId);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            Group result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync().ConfigureAwait(false);
                    result = Group.ParseGroupFromSqlRow(reader);
                }
            }
            return result;
        }

        public async Task<Group> GetGroupByNameAsync(string groupName)
        {
            string sql = string.Format(OnBoardResource.Sql_GroupGetGroupByName_Name, groupName);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            Group result = null;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync().ConfigureAwait(false);
                    result = Group.ParseGroupFromSqlRow(reader);
                }
            }
            return result;
        }

        public async Task<int> GetMaxGroupId()
        {
            string sql = string.Format(OnBoardResource.Sql_GroupGetMaxGroupId);
            SqlCommand cmd = new SqlCommand(sql, _connection);
            int result = 0;
            using (SqlDataReader reader = await cmd.ExecuteReaderAsync().ConfigureAwait(false))
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync().ConfigureAwait(false);
                    result = reader.GetInt32(0);
                }
            }
            return result;
        }

        public async Task<Group> CreateGroup(string groupName)
        {
            Group result = await GetGroupByIdAsync(groupName).ConfigureAwait(false);
            if(result == null)
            {
                int maxUserId = 0;
                try
                {
                    maxUserId = Convert.ToInt32(await GetMaxGroupId().ConfigureAwait(false));
                }
                catch
                {
                    maxUserId = 0;
                }
                int newGroupId = maxUserId + 1;
                string sql = string.Format(OnBoardResource.Sql_GroupInsertGroup_Id_Name, newGroupId, groupName);
                ExecuteNonQuery(sql);
                result = await GetGroupByIdAsync(newGroupId.ToString());
            }
            return result;
        }

        
    }
}