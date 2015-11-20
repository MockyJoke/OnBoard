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
            UsersUtility usersUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            IEnumerable<User> result = usersUtil.GetAllUsersAsync().Result;
            return this.SmartWebReturn(result);
        }

        // GET: api/Users/5
        public User Get(string id)
        {
            UsersUtility usersUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            User result = usersUtil.GetUserByUserIdAsync(id).Result;
            return this.SmartWebReturn(result);
        }

        // GET: api/Users?nickName=
        public User GetByNickName(string nickName)
        {
            UsersUtility usersUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            User result = usersUtil.GetUserByUserNickNameAsync(nickName).Result;
            return this.SmartWebReturn(result);
        }

        // GET: api/Users?groupId=
        public IEnumerable<User> GetByGroupId(string groupId)
        {
            UsersUtility usersUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            IEnumerable<User> result = usersUtil.GetUsersByGroupIdAsync(groupId).Result;
            return this.SmartWebReturn(result);
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
        public HttpResponseMessage Put(string nickName)
        {
            UsersUtility usersUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            User user = usersUtil.CreateUserAsync(nickName).Result;
            HttpResponseMessage responseMessage = Request.CreateResponse<User>(user);
            return responseMessage;
        }

        // DELETE: api/Users/5
        public void Delete(int id)
        {
        }
    }
}
