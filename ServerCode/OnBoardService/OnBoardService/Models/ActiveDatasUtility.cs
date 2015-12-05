using OnBoardService.Models.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OnBoardService.Models
{
    public class ActiveDatasUtility
    {
        OnBoardDbContext _context;
        public ActiveDatasUtility()
        {
            _context = new OnBoardDbContext();
        }

        public ActiveData SaveActiveData(int userId, double lat, double lon, string statusCode)
        {
            User user = _context.Users.FirstOrDefault(u => u.Id == userId);
            ActiveData result = null;
            if (user != null)
            {
                result = GetActiveDataForUserId(user.Id);
                if (result == null)
                {
                    result = new ActiveData();
                    _context.ActiveDatas.Add(result);
                }
                result.User = user;
                result.Lat = lat;
                result.Lon = lon;
                result.StatusCode = statusCode;
                _context.SaveChanges();
            }
            return result;
        }

        public List<ActiveData> GetAllActiveDatas()
        {
            return  _context.ActiveDatas.ToList();
        }

        public ActiveData GetActiveDataForUserId(int userId)
        {
            return _context.ActiveDatas.FirstOrDefault(ad => ad.User.Id == userId);
        }
    }
}