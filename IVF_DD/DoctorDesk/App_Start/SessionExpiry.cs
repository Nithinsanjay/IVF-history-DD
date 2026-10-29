using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using OncologyEMR.DataClass;
namespace OncologyEMR.App_Start
{
    public class SessionExpiry : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            try
            {


                // KENYCLOACK RELATED CHANGES DONE KARTHICK
                if (GeneralFunction.GetAppsettingUnitWiseValue("IDP_KEYCLOAK_AUTH").ToString().Trim().ToUpper() == "TRUE")
                {

                    if (HttpContext.Current.Session["AUTHTOKEN"] == null)
                    {
                        FormsAuthentication.SignOut();
                        filterContext.Result =
                       new RedirectToRouteResult(new RouteValueDictionary
                    {
             { "action", "Login" },
            { "controller", "Account" },
            { "returnUrl", filterContext.HttpContext.Request.RawUrl}
                     });

                        return;
                    }
                    else if (HttpContext.Current.Session["AUTHTOKEN"].ToString().Trim() == "")
                    {
                        FormsAuthentication.SignOut();
                        filterContext.Result =
                       new RedirectToRouteResult(new RouteValueDictionary
                    {
             { "action", "Login" },
            { "controller", "Account" },
            { "returnUrl", filterContext.HttpContext.Request.RawUrl}
                     });

                        return;
                    }
                    else
                    {

                        var tokenverifyRes = GeneralFunction.CheckAuthToken(HttpContext.Current.Session["AUTHTOKEN"].ToString().Trim(),
                            HttpContext.Current.Session["REFTOKEN"].ToString().Trim(), true);

                        if (tokenverifyRes.active == false)
                        {
                            FormsAuthentication.SignOut();
                            filterContext.Result =
                           new RedirectToRouteResult(new RouteValueDictionary
                        {
             { "action", "Login" },
            { "controller", "Account" },
            { "returnUrl", filterContext.HttpContext.Request.RawUrl}
                         });

                            return;
                        }
                    }
                }

                // ----- end----
                if (HttpContext.Current.Session["gOncoUserId"] == null)
                {
                    FormsAuthentication.SignOut();
                    filterContext.Result =
                   new RedirectToRouteResult(new RouteValueDictionary
                {
             { "action", "Login" },
            { "controller", "Account" },
            { "returnUrl", filterContext.HttpContext.Request.RawUrl}
                 });

                    return;
                }
            }
            catch
            {
                FormsAuthentication.SignOut();
                filterContext.Result =
               new RedirectToRouteResult(new RouteValueDictionary
            {
             { "action", "Login" },
            { "controller", "Account" },
            { "returnUrl", filterContext.HttpContext.Request.RawUrl}
             });

                return;
            }
        }

    }
}