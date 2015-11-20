using System.Data.SqlClient;

namespace OnBoardService.Models.Users
{
    public class User
    {
        public int Id { get; private set; }
        public string NickName { get; private set; }
        public int GroupId { get; private set; }

        public User()
        {
            Id = 0;
        }
        public User(int id, string nickName, int groupId)
        {
            Id = id;
            NickName = nickName;
            GroupId = groupId;
        }
        
        public static User ParseUserFromSqlRow(SqlDataReader reader)
        {
            return new User(reader.GetInt32(0),
                reader.GetString(1),
                reader.GetInt32(2));
        }
    }
}