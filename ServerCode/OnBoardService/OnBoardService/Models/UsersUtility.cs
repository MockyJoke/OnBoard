using OnBoardService.Models.Database;
using OnBoardService.Models.Groups;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace OnBoardService.Models.Users
{
    public class UsersUtility
    {
        OnBoardDbContext _context;
        public UsersUtility()
        {
            _context = new OnBoardDbContext();
        }
        public User GetUserByUserId(int userId)
        {
            return _context.Users.FirstOrDefault(u => (u.Id == userId));
        }

        public User GetUserByUserNickName(string name)
        {
            return _context.Users.FirstOrDefault(u => (u.Name == name));
        }

        public int GetMaxUserId()
        {
            return _context.Users.Max(u => u.Id);
        }

        public List<User> GetUsersByGroupId(int groupId)
        {
            return _context.Users.Where(u => u.GroupId == groupId).ToList();
        }

        public List<User> GetAllUsers()
        {
            return _context.Users.ToList();
        }

        public User CreateUser(string name)
        {
            User result = GetUserByUserNickName(name);
            if (result == null)
            {
                result = new User()
                {
                    Name = name
                };
                _context.Users.Add(result);
                _context.SaveChanges();
            }
            return result;
        }

        public User UpdateUser(User user)
        {
            User result = _context.Users.FirstOrDefault(u => u.Id == user.Id);
            if (result != null)
            {
                result.Name = user.Name;
                result.GroupId = user.GroupId;
                _context.SaveChanges();
            }
            return result;
        }

        public User JoinGroup(int userId, int groupId)
        {
            User user = GetUserByUserId(userId);
            GroupsUtility groupsUtil = new GroupsUtility();
            Group group = groupsUtil.GetGroupById(groupId);
            if (user != null && group != null)
            {
                user.GroupId = groupId;
                _context.SaveChanges();
            }
            return user;
        }
    }
}