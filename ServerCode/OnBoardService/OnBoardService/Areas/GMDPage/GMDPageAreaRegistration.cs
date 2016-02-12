using System.Web.Mvc;

namespace OnBoardService.Areas.GMDPage
{
    public class GMDPageAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "GMDPage";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "GMDPage_default",
                "GMD/{id}",
                new { controller="GMDPage", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}