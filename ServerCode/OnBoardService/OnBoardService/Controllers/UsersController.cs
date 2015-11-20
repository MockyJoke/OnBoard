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
        // GET: api/Users
        public IEnumerable<User> Get()
        {
            using (UsersUtility usersUtil = new UsersUtility())
            {
                IEnumerable<User> result = usersUtil.GetAllUsers();
                return this.SmartWebReturn(result);
            }
        }

        // GET: api/Users/5
        public User Get(int id)
        {
            using (UsersUtility usersUtil = new UsersUtility())
            {
                User result = usersUtil.GetUserByUserId(id);
                return this.SmartWebReturn(result);
            }
        }

        // GET: api/Users?nickName=
        public User GetByNickName(string name)
        {
            using (UsersUtility usersUtil = new UsersUtility())
            {
                User result = usersUtil.GetUserByUserNickName(name);
                return this.SmartWebReturn(result);
            }
        }

        // GET: api/Users?groupId=
        public IEnumerable<User> GetByGroupId(int groupId)
        {
            using (UsersUtility usersUtil = new UsersUtility())
            {
                 IEnumerable<User> result = usersUtil.GetUsersByGroupId(groupId);
                return this.SmartWebReturn(result);
            }
        }

        // POST: api/Users
        //public void Post([FromBody]string value)
        //{
        //}


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
            using (UsersUtility usersUtil = new UsersUtility())
            {
                User result = usersUtil.CreateUser(name);
                return this.SmartWebReturn(result);
            }
        }

        // DELETE: api/Users/5
        public void Delete(int id)
        {
        }
    }
}
