using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Http;
using System.Text.RegularExpressions;
namespace OncologyEMR
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
             name: "Login",
             url: "{controller}/{action}/{id}",
             defaults: new { controller = "Account", action = "Login", id = RouteParameter.Optional },
             constraints: new { strMrNo = @"^OE\d{1,10}$" }
         );
        //    routes.MapRoute(
        //    name: "PatEntry",
        //    url: "{controller}/{action}",
        //    defaults: new { controller = "Oncology", action = "PatientEntry" }          
        //);
            routes.MapRoute(
               name: "Default",
               url: "{controller}/{action}/{id}",
               defaults: new { controller = "Account", action = "Login", id = RouteParameter.Optional }
           );
        }
    }
}