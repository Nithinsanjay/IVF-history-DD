using OncologyEMR.App_Start;
using OncologyEMR.CommonSerRef;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace OncologyEMR
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            
            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            BundleTable.EnableOptimizations = true;

            //CommonServiceClient comm = new CommonServiceClient();
            //string ds = comm.GetHospitalInfo("01");
            //DataSet newTable = new DataSet();
            //StringReader theReader = new StringReader(ds);
            //newTable.ReadXml(theReader);

            //Application["HOSPITALNAME"] = newTable.Tables[0].Rows[0]["HOSPNAME"].ToString().Trim(); 
            //Application["HOSPITALADDRESS"] = newTable.Tables[0].Rows[0]["HOSPADDRESS"].ToString().Trim();
            //Application["HOSPLOGO"] = HttpRuntime.AppDomainAppPath + @"\Images\logo.jpg";  
            Application["DUPLICATE"] = HttpRuntime.AppDomainAppPath + @"\Images\dupcteWtermrkpng.png";
            Application["CANCEL"] = HttpRuntime.AppDomainAppPath + @"\Images\CancelWaterMark.png";
            //Application["Location"] = "Thane";

            // KEYCLOAK RELATED CHANGES ADD BY KARTHICK
            //if (newTable.Tables[0].Columns.Contains("IDPBASEADDRESS"))//Condistion is added becasue error was there for this column meenakshi
            //{
            //    Application["idpbaseaddress"] = newTable.Tables[0].Rows[0]["IDPBASEADDRESS"].ToString().Trim();//@"https://dev-sso.tatamd.com"; // done
            //    Application["idprealms"] = newTable.Tables[0].Rows[0]["IDPREALMS"].ToString().Trim(); //"Urban-Care";
            //    Application["idpclientid"] = newTable.Tables[0].Rows[0]["IDPCLIENTID"].ToString().Trim(); //"uc-emr";
            //    Application["idpclientSecret"] = newTable.Tables[0].Rows[0]["IDPCLIENTSECRET"].ToString().Trim(); //"7iO9e2onjxPRGzIkTtnpZ0MTfLA29zhK";
            //    Application["idpredirectUri"] = newTable.Tables[0].Rows[0]["IDPREDIRECTURI"].ToString().Trim(); // @"https://emr-sandbox.tatamd.com/webhmis/moduleList";
            //}
            //----END----
        }

        protected void Session_Start()
        {

            Session.Add("gOncoUserId", "");
            Session.Add("gDoctCode", "");
            Session.Add("gDoctName", "");
            Session.Add("ClinicCode", "");
        
            Session.Add("MOBACCESS", false);
       
            HttpContext.Current.Session.Add("MchIPAddress", Request.ServerVariables["REMOTE_HOST"]);
            HttpContext.Current.Session.Add("HospUnit", "");
            HttpContext.Current.Session.Add("ModuleIDGlobal", "");
            HttpContext.Current.Session.Add("FundSource", "");
            HttpContext.Current.Session.Add("CounterCd", "");
            //end
        }

        //Added from HMIS Global Asax meenakshi on 06-08-2024  for VAPT
        protected void Application_PreSendRequestHeaders(object sender, EventArgs e)
        {
            var request = HttpContext.Current.Request;
            var path = request.Path.ToLower();

            bool isEmbeddableRoute =
             path.Contains("/patientclinicalhistory/medicationhistory") ||
             path.Contains("/patientclinicalhistory/callpalliativecarelist") ||
             path.Contains("/patientclinicalhistory/getexternalpatinethistory");
            //Karthik
            if (HttpContext.Current.Response.Headers.AllKeys.Contains("X-Powered-By"))
            {
                HttpContext.Current.Response.Headers.Remove("X-Powered-By");
            }
            if (HttpContext.Current.Response.Headers.AllKeys.Contains("X-AspNet-Version"))
            {
                HttpContext.Current.Response.Headers.Remove("X-AspNet-Version");
            }
            if (HttpContext.Current.Response.Headers.AllKeys.Contains("X-AspNetMvc-Version"))
            {
                HttpContext.Current.Response.Headers.Remove("X-AspNetMvc-Version");
            }
            if (HttpContext.Current.Response.Headers.AllKeys.Contains("Server"))
            {
                HttpContext.Current.Response.Headers.Remove("Server");
            }
            if (!isEmbeddableRoute && !HttpContext.Current.Response.Headers.AllKeys.Contains("X-Frame-Options"))
            {
                HttpContext.Current.Response.Headers.Add("X-Frame-Options", "SAMEORIGIN");
            }

            if (!HttpContext.Current.Response.Headers.AllKeys.Contains("X-XSS-Protection"))
            {
                HttpContext.Current.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
            }
            if (!HttpContext.Current.Response.Headers.AllKeys.Contains("Strict-Transport-Security"))
            {
                HttpContext.Current.Response.Headers.Add("Strict-Transport-Security", "max-age=31536000");
            }
            //
            //Meenakshi om 19/02/2024
            if (!HttpContext.Current.Response.Headers.AllKeys.Contains("X-Content-Type-Options"))
            {
                HttpContext.Current.Response.Headers.Add("X-Content-Type-Options", "nosniff");
            }
            if (!HttpContext.Current.Response.Headers.AllKeys.Contains("Content-Security-Policy"))
            {
                //HttpContext.Current.Response.Headers.Add("Content-Security-Policy", "default-src 'self' style-src 'self' 'unsafe-inline' script-src 'self' 'unsafe-eval' img-src 'self' data:;"); //Changes By Rajan - For Display the Sign Picture in MedicalExam
                //HttpContext.Current.Response.Headers["Content-Security-Policy"] =
                //"default-src 'self'; " +
                //"style-src 'self' 'unsafe-inline' http://13.200.96.116:8078; " +
                //"script-src 'self' 'unsafe-inline' 'unsafe-eval' http://13.200.96.116:8078; " +
                //"img-src 'self' data: http://13.200.96.116:8078; " +
                //"frame-src 'self' http://13.200.96.116:8078;";


                //string extraSources =  ConfigurationManager.AppSettings["CSP:ExtraSources"];
                string extraSources = OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CSP:ExtraSources");// ConfigurationManager.AppSettings["CSP:ExtraSources"];

                //string csp = "default-src 'self'; " +
                //             "style-src 'self' 'unsafe-inline'; " +
                //             "script-src 'self' 'unsafe-inline' 'unsafe-eval'; " +
                //             "img-src 'self' data:; " +
                //             "font-src 'self' data:; " +
                //             "frame-src 'self';";

                string csp =
                    "default-src 'self'; " +
                    "style-src 'self' 'unsafe-inline' data:; " +
                    "script-src 'self' 'unsafe-inline' 'unsafe-eval'; " +
                    "img-src 'self' data:; " +
                    "font-src 'self' data:; " +
                    "frame-src 'self';";

                if (!string.IsNullOrWhiteSpace(extraSources))
                {
                    csp = csp.Replace(
                        "style-src 'self' 'unsafe-inline' data:;",
                        "style-src 'self' 'unsafe-inline' data: " + extraSources + ";"
                    );

                    csp = csp.Replace(
                        "script-src 'self' 'unsafe-inline' 'unsafe-eval';",
                        "script-src 'self' 'unsafe-inline' 'unsafe-eval' " + extraSources + ";"
                    );

                    csp = csp.Replace(
                        "img-src 'self' data:;",
                        "img-src 'self' data: " + extraSources + ";"
                    );

                    csp = csp.Replace(
                        "frame-src 'self';",
                        "frame-src 'self' " + extraSources + ";"
                    );
                }


                //if (extraSources != null && extraSources.Trim() != "")
                //{
                //    csp = csp.Replace("style-src 'self' 'unsafe-inline';",
                //                      "style-src 'self' 'unsafe-inline' " + extraSources + ";");

                //    csp = csp.Replace("script-src 'self' 'unsafe-inline' 'unsafe-eval';",
                //                      "script-src 'self' 'unsafe-inline' 'unsafe-eval' " + extraSources + ";");

                //    csp = csp.Replace("img-src 'self' data:;",
                //                      "img-src 'self' data: " + extraSources + ";");

                //    csp = csp.Replace("frame-src 'self';",
                //                      "frame-src 'self' " + extraSources + ";");
                //}

                HttpContext.Current.Response.Headers["Content-Security-Policy"] = csp;

            }
            if (HttpContext.Current.Response.Headers.AllKeys.Contains("Host"))
            {
                HttpContext.Current.Response.Headers.Remove("Host");
            }
            if (HttpContext.Current.Response.Headers.AllKeys.Contains("Cookie"))
            {
                HttpContext.Current.Response.Headers.Remove("Cookie");
            }
            if (HttpContext.Current.Response.Headers.AllKeys.Contains("Remote Address"))
            {
                HttpContext.Current.Response.Headers.Remove("Remote Address");
            }
            //

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            var httpContext = ((MvcApplication)sender).Context;

            string errormsg = (httpContext.Error).Message;
            
            WriteErrorLog(errormsg);

            var currentRouteData = RouteTable.Routes.GetRouteData(new HttpContextWrapper(httpContext));
            var currentController = " ";
            var currentAction = " ";

            if (currentRouteData != null)
            {
                if (currentRouteData.Values["controller"] != null && !String.IsNullOrEmpty(currentRouteData.Values["controller"].ToString()))
                {
                    currentController = currentRouteData.Values["controller"].ToString();
                }

                if (currentRouteData.Values["action"] != null && !String.IsNullOrEmpty(currentRouteData.Values["action"].ToString()))
                {
                    currentAction = currentRouteData.Values["action"].ToString();
                }
            }

            //var ex = Server.GetLastError();
            //var controller = new ErrorController();
            //var routeData = new RouteData();
            //var action = "Index";

            //if (ex is HttpException)
            //{
            //    var httpEx = ex as HttpException;

            //    switch (httpEx.GetHttpCode())
            //    {
            //        case 404:
            //            action = "NotFound";
            //            break;

            //        // others if any

            //        default:
            //            action = "Index";
            //            break;
            //    }
            //}

            //httpContext.ClearError();
            //httpContext.Response.Clear();
            //httpContext.Response.StatusCode = ex is HttpException ? ((HttpException)ex).GetHttpCode() : 500;
            //httpContext.Response.TrySkipIisCustomErrors = true;
            //routeData.Values["controller"] = "Error";
            //routeData.Values["action"] = action;

            //controller.ViewData.Model = new HandleErrorInfo(ex, currentController, currentAction);

            //((IController)controller).Execute(new RequestContext(new HttpContextWrapper(httpContext), routeData));
        }

        public void WriteErrorLog(string message)
        {
            StreamWriter logWriter;
            string filePath = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "" || ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "00" ?
                System.Web.Hosting.HostingEnvironment.MapPath("~/log/ErrorLog.txt") : System.Web.Hosting.HostingEnvironment.MapPath("~/UnitConfig/" + ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) + "/ErrorLog.txt");
            string directoryPath = Path.GetDirectoryName(filePath);
            if (!Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }
            if (File.Exists(filePath))
                logWriter = File.AppendText(filePath);
            else
                logWriter = File.CreateText(filePath);
            logWriter.WriteLine("=>" + DateTime.Now + " | " + HttpContext.Current.Session["MchIPAddress"] + " | " + HttpContext.Current.Session["ModuleIDGlobal"] + " | " + HttpContext.Current.Session["UserID"] + " | " + " An Error occured : " +
                 " Message : " + message);
            logWriter.WriteLine("-----------------------------------------------------------------------------------------------");
            logWriter.Close();
        }
         
    }
}