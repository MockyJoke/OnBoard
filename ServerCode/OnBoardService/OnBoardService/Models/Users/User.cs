using System.Data.SqlClient;

namespace OnBoardService.Models.Users
{
    public class User
    {
        public string Id { get; private set; }
        public string NickName { get; private set; }
        public string GroupId { get; private set; }

        public User()
        {
            Id = "0";
        }
        public User(string id, string nickName, string groupId)
        {
            Id = id;
            NickName = nickName;
            GroupId = groupId;
        }
        
        public static User ParseUserFromSqlRow(SqlDataReader reader)
        {
            return new User(reader.GetString(0),
                reader.GetString(1),
                reader.IsDBNull(2) ? null : reader.GetString(2));
        }
    }
}