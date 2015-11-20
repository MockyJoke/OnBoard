using OnBoardService.Models.Database;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace OnBoardService.Models.Groups
{
    public class GroupsUtility
    {
        OnBoardDbContext _context;
        public GroupsUtility ()
        {
            _context = new OnBoardDbContext();
        }

        public List<Group> GetAllGroups()
        {
            return _context.Groups.ToList();
        }

        public Group GetGroupById(int id)
        {
            return _context.Groups.FirstOrDefault(g => g.Id == id);
        }

        public Group GetGroupByName(string name)
        {
            return _context.Groups.FirstOrDefault(g => g.Name == name);
        }

        public int GetMaxGroupId()
        {
            return _context.Groups.Max(g => g.Id);
        }

        public Group CreateGroup(string name)
        {
            Group result = GetGroupByName(name);
            if(result == null)
            {
                result = new Group()
                {
                    Name = name
                };
                _context.Groups.Add(result);
                _context.SaveChanges();
            }
            return result;
        }
    }
}