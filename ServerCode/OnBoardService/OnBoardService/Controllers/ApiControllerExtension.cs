using System.Net;
using System.Web.Http;

namespace OnBoardService.Controllers
{
    public static class ApiControllerExtension
    {
        public static T SmartWebReturn<T>(this ApiController controller, T result)
        {
            if (result == null)
            {
                throw new HttpResponseException(HttpStatusCode.NotFound);
            }
            else
            {
                return result;
            }
        }
    }
}