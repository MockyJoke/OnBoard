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
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Users/5
        public User Get(string id)
        {
            UsersUtility userUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            User result = userUtil.GetUserByUserIdAsync(id).Result;
            if (result == null)
            {
                throw new HttpResponseException(HttpStatusCode.NotFound);
            }
            else
            {
                return result;
            }
        }

        // POST: api/Users
        //public void Post([FromBody]string value)
        //{
        //}

        // POST: /api/Users?nickName={} 
        public HttpResponseMessage Post(string nickName)
        {
            UsersUtility userUtil = new UsersUtility(DatabaseManager.Instance.Connection);
            User user= userUtil.AddUserAsync(nickName).Result;
            HttpResponseMessage responseMessage = Request.CreateResponse<User>(user);
            return responseMessage;
        }

        // PUT: api/Users/5
        public void Put(string id, [FromBody]string NickName)
        {
        }

        // DELETE: api/Users/5
        public void Delete(int id)
        {
        }
    }
}
