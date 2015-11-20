using OnBoardService.Models.Users;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OnBoardService.Models.Groups
{
    public class Group
    {
        public string Id { get; private set; }
        public string Name { get; private set; }
        public List<User> Members { get; private set; }


        public Group(string id,string name)
        {
            Id = id;
            Name = name;
        }
        public static Group ParseGroupFromSqlRow(SqlDataReader reader)
        {
            return new Group(reader.GetString(0),
                reader.GetString(1));
        }


    }
}