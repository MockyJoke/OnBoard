using OnBoardService.Models.Database;
using OnBoardService.Models.Groups;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace OnBoardService.Controllers
{
    public class GroupsController : ApiController
    {
        // GET: api/Groups
        public IEnumerable<Group> Get()
        {
            GroupsUtility groupsUtil = new GroupsUtility(DatabaseManager.Instance.Connection);
            IEnumerable<Group> result = groupsUtil.GetAllGroupsAsync().Result;
            return this.SmartWebReturn(result);
        }

        // GET: api/Groups/5
        public Group Get(string id)
        {
            GroupsUtility groupsUtil = new GroupsUtility(DatabaseManager.Instance.Connection);
            Group result = groupsUtil.GetGroupByIdAsync(id).Result;
            return this.SmartWebReturn(result);
        }

        // POST: api/Groups
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Groups/5
        //public void Put(int id, [FromBody]string value)
        //{
        //}

        // PUT: api/Groups?name=
        public Group Put(string name)
        {
            GroupsUtility groupsUtil = new GroupsUtility(DatabaseManager.Instance.Connection);
            Group result = groupsUtil.CreateGroup(name).Result;
            return this.SmartWebReturn(result);
        }

        // DELETE: api/Groups/5
        public void Delete(int id)
        {
        }
    }
    
}
