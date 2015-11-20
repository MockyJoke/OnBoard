using OnBoardService.Models.Database;
using OnBoardService.Models.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace OnBoardService.Controllers
{
    public class UsersController : ApiController
    {
        UsersUtility usersUtil = new UsersUtility();
        // GET: api/Users
        public IEnumerable<User> Get()
        {
            UsersUtility usersUtil = new UsersUtility();
            IEnumerable<User> result = usersUtil.GetAllUsers();
            return this.SmartWebReturn(result);
        }

        // GET: api/Users/5
        public User Get(int id)
        {
            User result = usersUtil.GetUserByUserId(id);
            return this.SmartWebReturn(result);
        }

        // GET: api/Users?nickName=
        public User GetByNickName(string name)
        {
            User result = usersUtil.GetUserByUserNickName(name);
            return this.SmartWebReturn(result);
        }

        // GET: api/Users?groupId=
        public IEnumerable<User> GetByGroupId(int groupId)
        {
            IEnumerable<User> result = usersUtil.GetUsersByGroupId(groupId);
            return this.SmartWebReturn(result);
        }

        //POST: api/Users
        //public void Post([FromBody]string value)
        //{
        //}

        // POST: api/Users/01?groupId=0
        // Joing a group
        public User Post(int id, int groupId)
        {
            User result = usersUtil.JoinGroup(id, groupId);
            return this.SmartWebReturn(result);
        }


        // PUT: api/Users/5
        /*public void Put(string id, [FromBody]string NickName)
        {
        }*/

        // PUT: /api/Users?nickName={} 
        public User Put(string name)
        {
            //UsersUtility usersUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            //User user = usersUtil.CreateUserAsync(nickName).Result;
            //HttpResponseMessage responseMessage = Request.CreateResponse<User>(user);
            //return responseMessage;

            User result = usersUtil.CreateUser(name);
            return this.SmartWebReturn(result);

        }

        // DELETE: api/Users/5
        public void Delete(int id)
        {
        }
    }
}
