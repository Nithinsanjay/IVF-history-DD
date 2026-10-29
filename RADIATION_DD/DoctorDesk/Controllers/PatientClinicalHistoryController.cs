using OncologyEMR.CommonSerRef;
using OncologyEMR.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace OncologyEMR.Controllers
{
    public class PatientClinicalHistoryController : Controller
    {
        //
        // GET: /PatientClinicalHistory/

        public ActionResult Index()
        {
            return View();
        }



        #region SurgeryHistory

        public ActionResult SurgicalHistoryTumor(string data, string PatMrno, string PatName, string Gender, string Age, string type, string MeetingTime, string MeetingDate, string Duration, string Tranno, string UnitCode = "")
        {
            AccountModel AcctMdl = new AccountModel();
            System.Web.HttpContext.Current.Session["UNITCODE"] = UnitCode;
            AcctMdl.SetHospitalUnit(UnitCode);
            string responseMessage = string.Empty;
            if (!string.IsNullOrEmpty(data))
            {
                string decrypted = Decrypt(HttpUtility.UrlDecode(data));
                var q = System.Web.HttpUtility.ParseQueryString(decrypted);

                type = q["Type"];
                if (type == "E")
                {
                    PatMrno = q["PatMrno"];
                    PatName = q["PatName"];
                    Gender = q["Gender"];
                    Age = q["Age"];
                    MeetingDate = q["Date"];
                    MeetingTime = q["Time"];
                    Duration = System.Configuration.ConfigurationManager.AppSettings["DURATION"].ToString();
                    System.Web.HttpContext.Current.Session["DoctorCode"] = q["DoctorCode"];//For Link Only for used to Save the Recommendation
                    System.Web.HttpContext.Current.Session["ExTranno"] = q["Tranno"];
                    System.Web.HttpContext.Current.Session["MeetingTime"] = q["Time"];
                    System.Web.HttpContext.Current.Session["MeetingDate"] = q["Date"];

                }
                DateTime now = DateTime.Now;

                DateTime parsedMeetingDate, parsedMeetingTime;
                int durationMinutes;

                if (DateTime.TryParse(MeetingDate, out parsedMeetingDate) &&
                    DateTime.TryParse(MeetingTime, out parsedMeetingTime) &&
                    int.TryParse(Duration, out durationMinutes))
                {
                    DateTime meetingStart = parsedMeetingDate.Date.Add(parsedMeetingTime.TimeOfDay);
                    DateTime meetingEnd = meetingStart.AddMinutes(durationMinutes);

                    // If login already expired
                    if (string.IsNullOrEmpty(Convert.ToString(System.Web.HttpContext.Current.Session["DoctorCode"])))
                    {
                        responseMessage = "Link Expired";
                        System.Web.HttpContext.Current.Session["DoctorCode"] = null;
                    }
                    // Meeting date is before today
                    else if (parsedMeetingDate.Date < now.Date)
                    {
                        responseMessage = "Link Expired";
                        System.Web.HttpContext.Current.Session["DoctorCode"] = null;
                    }
                    // Meeting is today but already finished
                    else if (parsedMeetingDate.Date == now.Date && now > meetingEnd)
                    {
                        responseMessage = "Meeting finished";
                        System.Web.HttpContext.Current.Session["DoctorCode"] = null;
                    }
                    // Meeting has not started yet
                    else if (parsedMeetingDate.Date >= now.Date && now < meetingStart)
                    {
                        type = "";  // <-- Whatever you want before meeting starts
                        System.Web.HttpContext.Current.Session["DoctorCode"] = null;
                    }
                }
            }
            SurgicalHist mdl = new SurgicalHist();
            ViewBag.Message = responseMessage;
            ViewBag.PATMRNO = PatMrno;
            ViewBag.PatName = PatName;
            ViewBag.Gender = Gender;
            ViewBag.Age = Age;
            ViewBag.Type = type;
            ViewBag.UNITCODE = UnitCode;
            return View();
        }



        public static string Decrypt(string cipher)
        {

            string key = System.Configuration.ConfigurationManager.AppSettings["ExternalLink"];
            string salt = ConfigurationManager.AppSettings["salt"];
            // Create a new AES encryption object
            using (Aes aes = Aes.Create())
            {
                // Create a key generator using a password (key) and a salt ("Salt1234")
                // This helps make the encryption stronger and more secure
                var pdb = new Rfc2898DeriveBytes(key, Encoding.UTF8.GetBytes(salt));

                // Generate the AES key (32 bytes) and initialization vector (16 bytes)
                aes.Key = pdb.GetBytes(32);
                aes.IV = pdb.GetBytes(16);

                // Convert the base64 encrypted text (cipher) back to bytes
                byte[] bytes = Convert.FromBase64String(cipher.Replace(" ", "+"));

                // Create a memory stream to hold the decrypted data
                using (var ms = new MemoryStream())
                // Create a crypto stream that will handle the actual decryption process
                using (var cs = new CryptoStream(ms, aes.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    // Write the encrypted bytes into the crypto stream to decrypt them
                    cs.Write(bytes, 0, bytes.Length);
                   
                    // Close the crypto stream to finish decryption
                    cs.Close();

                    // Convert the decrypted bytes from memory stream into a readable string
                    return Encoding.UTF8.GetString(ms.ToArray());
                }
            }
        }



        public JsonResult GetPatDiagVitalHistory(string MrNo)
        {
            PatientClinicalHistory md = new PatientClinicalHistory();
            object status = md.GetPatDiagVitalHistory(MrNo);
            return Json(status, JsonRequestBehavior.AllowGet);
        }



        public JsonResult GetRadHistForTBD(string MrnNo, string strLabType,string strUnit = "")
        {
            PatientClinicalHistory clonclo = new PatientClinicalHistory();
            System.Web.HttpContext.Current.Session["UNITCODE"] = strUnit != "" ? strUnit : System.Web.HttpContext.Current.Session["UNITCODE"];
            var jsonData = clonclo.GetRadHistForTBD(MrnNo, strLabType);
            return Json(jsonData, JsonRequestBehavior.AllowGet);

        }

        public ActionResult GetDept(string Type)
        {
            object lst;
            CommonServiceClient com = new CommonServiceClient();
            if (Type == "L")
            {
                lst = com.GetLabDeptLst().Where(x => x.LabType == "L");
            }
            else
            {
                lst = com.GetLabDeptLst().Where(x => x.LabType == "R" || x.LabType == "N");
            }
            return Json(lst, JsonRequestBehavior.AllowGet);
        }

        #endregion

        public JsonResult GetPACHistory(string Mrno)
        {
            PatientClinicalHistory Mdl = new PatientClinicalHistory();
            var Result = Mdl.GetPACHistList(Mrno);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

       


        #region Medication hiistory
        public ActionResult MedicationHistory(string PatMrno, string PatName, string Gender, string Age)
        {
            PatientClinicalHistory Pc = new PatientClinicalHistory();
            ViewBag.PATMRNO = PatMrno;
            ViewBag.DoctorList = Pc.GetDoctTypeList();
            ViewBag.PatName = PatName;
            ViewBag.Gender = Gender;
            ViewBag.Age = Age;
            return View();
        }
        #endregion


        public JsonResult GetBiposyReport(string MrNo)
        {
            PatientClinicalHistory md = new PatientClinicalHistory();
            object status = md.GetBiposyReport(MrNo);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
    }
}
