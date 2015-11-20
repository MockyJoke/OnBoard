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
        GroupsUtility groupsUtil = new GroupsUtility();
        // GET: api/Groups
        public IEnumerable<Group> Get()
        {
            IEnumerable<Group> result = groupsUtil.GetAllGroups();
            return this.SmartWebReturn(result);
        }

        // GET: api/Groups/5
        public Group Get(int id)
        {
                Group result = groupsUtil.GetGroupById(id);
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

                Group result = groupsUtil.CreateGroup(name);
                return this.SmartWebReturn(result);

        }

        // DELETE: api/Groups/5
        public void Delete(int id)
        {
        }
    }

}
