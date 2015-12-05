using OnBoardService.Models;
using OnBoardService.Models.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace OnBoardService.Controllers
{
    public class ActiveDatasController : ApiController
    {
        ActiveDatasUtility activeDatasUtil = new ActiveDatasUtility();
        // GET: api/ActiveDatas
        public IEnumerable<ActiveData> Get()
        {
            return activeDatasUtil.GetAllActiveDatas();
        }

        // GET: api/ActiveDatas/5
        public string Get(int id)
        {
            return "value";
        }

        // GET: api/ActiveDatas?userId= 
        public ActiveData GetByUserId(int userId)
        {
            return activeDatasUtil.GetActiveDataForUserId(userId);
        }


        // POST: api/ActiveDatas?userID=1&lat=1&lon=2&statuscode=1
        public ActiveData Post(int userId, double lat, double lon, string statusCode)
        {
            return activeDatasUtil.SaveActiveData(userId, lat, lon, statusCode);
        }

        // PUT: api/ActiveDatas/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/ActiveDatas/5
        public void Delete(int id)
        {
        }
    }
}
