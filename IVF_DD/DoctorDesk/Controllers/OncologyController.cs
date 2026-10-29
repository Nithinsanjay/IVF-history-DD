using Newtonsoft.Json;
using NReco.PdfGenerator;
using OncologyEMR.App_Start;
using OncologyEMR.CommonSerRef;
using OncologyEMR.DataClass;
using OncologyEMR.Models;
using OncologyEMR.Oncology;
using OncologyEMR.Pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
//using OncologyEMR.PISServRef;
using System.Net;
using System.Net.Http; 
using System.Reflection;
//using OncologyEMR.SecRefServ;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using WebJupCommonTemplates.DataClass;
namespace OncologyEMR.Controllers
{
    [SessionExpiry]
    public class DoctorDeskController : Controller
    {

        CommonServiceClient com = new CommonServiceClient();
        OncologyEMRClient OncoCli = new OncologyEMRClient();
        protected override JsonResult Json(object data, string contentType, System.Text.Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return new JsonResult()
            {
                Data = data,
                ContentType = contentType,
                ContentEncoding = contentEncoding,
                JsonRequestBehavior = behavior,
                MaxJsonLength = 2147483647,
            };
        }

        [HttpGet]
        public ActionResult Transaction(string strConsNo, string StrTranNo, string StrConsDT)
        {
            OncologyModel clOncology = new OncologyModel();

            var DTCompareValue = DateTime.Compare(DateTime.ParseExact(StrConsDT, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture), DateTime.Today);
            if (("" + StrTranNo.Trim() != "") && DTCompareValue != -1)
            {
                clOncology.TranMode = 2;
                clOncology.TRANNO = StrTranNo;
            }
            else if (("" + StrTranNo.Trim()) == "" && DTCompareValue != -1)
            {
                clOncology.TranMode = 1;
            }
            else
            {
                clOncology.TranMode = 3;
                clOncology.TRANNO = StrTranNo;
            }

            clOncology.fillcombos(clOncology);

            ViewBag.CompList = OncoCli.GetMainComplaintList();//.Where(x => x.ThirdCd == Session["ClinicCode"].ToString().Trim());
            clOncology.Imgsrc = "../Images/NoPreview.png";
            clOncology.GetPatHist(strConsNo, clOncology);
            return View(clOncology);
        }

        public ActionResult Home()
        {
            return View();
        }

        #region Patient Medical History
        public JsonResult GetPatientMedicalHistory(string sMRNo, int sDays)
        {
            try
            {
                OncologyModel clOncology = new OncologyModel();
                object jsonData = clOncology.GetPatientMedicalHistory(sMRNo, sDays);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region patientEntry
        byte[] oldbyteimage = null;//added by priyanka on 08/10/2025
        [HttpGet]
        public ActionResult PatientEntry(string DoctrClincStr = "")
        {
            Session["PageId"] = "PatientEntry";
            PatientSearch patSearch = new PatientSearch();
            patSearch.TranMode = 1;
            patSearch.Gender = "";
            var CurrMonth = "";
            if (DateTime.Now.Month.ToString().PadLeft(2).Trim().Length < 2)
                CurrMonth = "0" + DateTime.Now.Month.ToString().PadLeft(2).Trim();
            else CurrMonth = DateTime.Now.Month.ToString().PadLeft(2).Trim();

            var CurrDate = "";
            if (DateTime.Now.Day.ToString().PadLeft(2).Trim().Length < 2)
                CurrDate = "0" + DateTime.Now.Day.ToString().PadLeft(2).Trim();
            else CurrDate = DateTime.Now.Day.ToString().PadLeft(2).Trim();

            patSearch.CurDate = CurrDate + "/" + CurrMonth + "/" + DateTime.Now.Year.ToString().PadLeft(4);
            Session["FromClinic"] = ""; // added by vijeta on 5th april 2018
            return View(patSearch);
        }

        public JsonResult GetPatientList(string strClinicCode, string strSrchByDoctYN = "Y", string DateType = "T", int CustomeDate = 0, string Type = "")
        {
            try
            {
                PatientSearch clonco = new PatientSearch();
                string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                if (strSrchByDoctYN == "N")
                    strDoctorCd = "";
                Session["ClinicCode"] = strClinicCode;
                return Json(clonco.GetPatientList(strClinicCode, strDoctorCd, DateType, CustomeDate, Type), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        //suchita for tommorows patient list
        public JsonResult GetPatData(string strClinicCode, string appNsurType = "")
        {
            try
            {
                PatientSearch clonco = new PatientSearch();
                string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                Session["ClinicCode"] = strClinicCode;
                return Json(clonco.GetPatientListofTommorow(strClinicCode, strDoctorCd), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetCounts(string strTranNo, string strMrno)//-mrno added
        {
            try
            {
                OncologyModel oncmdl = new OncologyModel();
                object jsonData = oncmdl.GetCounts(strTranNo, strMrno);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string UploadPrescriptFile(string strImageIn64Format, string mrno, string consNo)
        {
            bool isUploaded = false;
            string message = "";
            int fileCount = 0;
            var countpath = "";
            //var name = Request.Form["IpNo"];
            DataTable dtfile = new DataTable();
            dtfile.Columns.Add("FilePath");
            dtfile.Columns.Add("FileName");
            dtfile.Columns.Add("View");
            var directory = "";
            //if(  System.Web.HttpContext.Current.Application["Location"].ToString()== "Thane")
            //    directory = @"\\192.168.3.16\3.90 Backup Data\DoctDeskAttachments";
            //else if(  System.Web.HttpContext.Current.Application["Location"].ToString()== "Pune")
            //    directory = @"F:\\DoctDeskAttachments";

            //var directory = @"\\192.168.3.253\ErrorLogs\DoctDeskAttachments";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/DoctDeskAttachments/" + strUnit;

            if (Request.Files.Count > 0)
            {
                try
                {
                    // Get the complete folder path and store the file inside it.                 
                    var labpath = directory;
                    var subpath = directory + "/" + mrno;
                    var path1 = "";
                    countpath = directory + "/" + mrno + "//";

                    HttpFileCollectionBase files = Request.Files;
                    HttpPostedFileBase file = files[0];
                    if (file.ContentType == "application/pdf" || file.ContentType == "image/jpeg" || file.ContentType == "image/png")
                    {
                        string currDate = GeneralFunction.GetDateInSpecifiedFormat(com.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_DDMMYYYY);
                        string fname;
                        fname = currDate;

                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                        }
                        else
                        {

                            for (int i = 0; i <= 10; i++)
                            {
                                path1 = directory + "/" + mrno + "/" + fname + "(" + (i + 1) + ")" + file.FileName.Substring(file.FileName.IndexOf("."));
                                if (System.IO.File.Exists(path1))
                                {

                                }
                                else
                                {
                                    fname = currDate + "(" + (i + 1) + ")" + file.FileName.Substring(file.FileName.IndexOf("."));
                                    path1 = directory + "/" + mrno + "/" + fname;
                                    break;
                                }
                            }

                            //fname = Regex.Replace(file.FileName, @"\s+", "");

                        }

                        if (mrno != "")
                        {
                            if (Directory.Exists(path1))
                            {
                                System.IO.File.Delete(path1);
                                file.SaveAs(path1);
                                isUploaded = true;
                                message = "File Uploaded Successfully!";
                                int count = Directory.GetFiles(countpath).Length;
                            }
                            else if (!Directory.Exists(labpath))
                            {
                                Directory.CreateDirectory(labpath);
                                if (Directory.Exists(directory))
                                {
                                    DirectoryInfo dInfo = new DirectoryInfo(labpath);
                                    DirectoryInfo dis = dInfo.CreateSubdirectory(mrno);
                                    file.SaveAs(path1);
                                    isUploaded = true;
                                    message = "File Uploaded Successfully!";
                                    int count = Directory.GetFiles(countpath).Length;
                                }
                            }
                            if (Directory.Exists(labpath))
                            {
                                if (Directory.Exists(subpath))
                                {
                                    file.SaveAs(path1);
                                    isUploaded = true;
                                    message = "File Uploaded Successfully!";
                                }
                                else
                                {
                                    DirectoryInfo dInfo = new DirectoryInfo(labpath);
                                    DirectoryInfo dis = dInfo.CreateSubdirectory(mrno);
                                    file.SaveAs(path1);
                                    isUploaded = true;
                                    message = "File Uploaded Successfully!";
                                    int count = Directory.GetFiles(countpath).Length;
                                }
                            }
                        }
                        // }
                        // Returns message that successfully uploaded  

                        fileCount = Directory.GetFiles(countpath).Length;
                        string[] filePaths = Directory.GetFiles(countpath);

                        for (int i = 0; i <= filePaths.Length - 1; i++)
                        {
                            DataRow dr = dtfile.NewRow();
                            dr["FilePath"] = filePaths[i];
                            int len = filePaths[i].Length;
                            int pos = filePaths[i].LastIndexOf("//");
                            var filenm = filePaths[i].Substring(pos + 2).Trim();
                            dr["FileName"] = filenm;
                            dtfile.Rows.Add(dr);
                        }

                        var jsonDatas = new
                        {
                            rows = (from DataRow row in dtfile.Rows
                                    select new
                                    {
                                        FilePath = ("" + row["FilePath"]).Trim(),
                                        FileName = ("" + row["FileName"]).Trim(),
                                        View = ("" + row["View"]).Trim(),
                                    }).ToArray()

                        };

                        return message;

                    }
                    else
                    {
                        message = "Incorrect File Format.";
                        return message;
                    }
                }
                catch (Exception ex)
                {
                    message = "Error occurred. Error details: " + ex.Message;
                    return message;
                    // return Json("Error occurred. Error details: " + ex.Message);
                }
            }
            else
            {
                message = "No files selected.";
                return message;

                //return Json("No files selected.");
            }
        }

        public JsonResult CallWaitPatSave(string mrno, string consNo, string TokenNo, string Patient, string ConsDate)
        {
            try
            {
                OncologyModel oncmdl = new OncologyModel();
                string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                object jsonData = oncmdl.CallWaitPatSave(mrno, consNo, TokenNo, strDoctorCd, Patient, ConsDate);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult CheckPatConsult(string mrno, string ConsDate)
        {
            try
            {
                OncologyModel oncmdl = new OncologyModel();
                object jsonData = oncmdl.CheckPatOnConsult(mrno, ConsDate);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion PatientEntry

        private void LogError(Exception ex)
        {
            string message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
            message += Environment.NewLine;
            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            message += string.Format("Message: {0}", ex.Message);
            message += Environment.NewLine;
            message += string.Format("StackTrace: {0}", ex.StackTrace);
            message += Environment.NewLine;
            message += string.Format("Source: {0}", ex.Source);
            message += Environment.NewLine;
            message += string.Format("TargetSite: {0}", ex.TargetSite.ToString());
            message += Environment.NewLine;
            message += "-----------------------------------------------------------";
            message += Environment.NewLine;
            string path = Server.MapPath("~/ErrorLog/ErrorLog.txt");
            using (StreamWriter writer = new StreamWriter(path, true))
            {
                writer.WriteLine(message);
                writer.Close();
            }
        }

        [HttpPost]
        public JsonResult GotoPatientEntry(string strConsNo, string StrTranNo, string StrConsDT)
        {
            try
            {
                //for new tran in transaction form
                Session["strConsNo"] = "";
                Session["StrConsDT"] = "";
                if (StrTranNo == "")
                {
                    Session["strConsNo"] = strConsNo;
                    Session["StrConsDT"] = StrConsDT;
                }

                return Json(new { Status = "Success", Message = "../DoctorDesk/Transaction?strConsNo=" + strConsNo + "&StrTranNo=" + StrTranNo + "&StrConsDT=" + StrConsDT }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                if (ex.Message.Contains("Cannot insert duplicate key"))
                {
                    return Json(new { Status = "Failed", Message = "This Patient Already Registered." }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { Status = "Failed", Message = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
                }
            }
        }

        public JsonResult GetDoctorDeskData(string tranno, string type, string MrNo, string language = "")
        {
            try
            {
                OncologyModel oncmdl = new OncologyModel();
                object jsonData = oncmdl.GetDoctorDeskMdlData(tranno, type, MrNo, language);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [ValidateInput(false)]
        public ActionResult PrintPatientReport(string strHtml)
        {
            try
            {
                OncologyModel cloncology = new OncologyModel();
                return new BinaryContentResult(cloncology.PrintPatientReport(strHtml), "application/pdf", "Cost Estimation Print");
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public JsonResult GetServiceSearchInfo()
        {
            OncologyModel oncMdl = new OncologyModel();
            object LstService = oncMdl.GetServiceSearchInfo();
            return Json(LstService, JsonRequestBehavior.AllowGet);
        }
       
        public JsonResult GetMainCompList(string ClinicCode)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                return Json(clonclo.RetriveMainCompListrevised(ClinicCode), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetSubCompList()
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();

                return Json(clonclo.GetSubCompListdt(), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetICDLISTVALUE(string name)
        {
            try
            {
                ICDUserCntrlMdl ICDMODE = new ICDUserCntrlMdl();
                object jsonData = ICDMODE.GETICDLIST(name);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult ChangePWD(string uid, string Npwd, string Cpwd)
        {
            OncologyModel clonclo = new OncologyModel();
            string status = clonclo.ChangePWD(uid, Npwd, Cpwd);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public bool CheckUserExist(string uid, string Opwd)
        {
            OncologyModel clonclo = new OncologyModel();
            bool ret = clonclo.CheckUserExist(uid, Opwd);
            return ret;
        }

        public string BindTestResultList(string FromDate, string ToDate, string TestName)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                string data = clonclo.BindTestResultList(FromDate, ToDate, TestName);
                return data;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #region Complaints

        public JsonResult AddComplaint(string strComplaint, string strGrpCode = "")
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.SaveMainCompAddItemdt(strComplaint, strGrpCode), JsonRequestBehavior.AllowGet);
        }

        public ActionResult Complaints()
        {
            return View();
        }

        public JsonResult SaveComplaints(string strComplaints, string strMRNO, string strTranNo)
        {
            //DataTable dt = new DataTable();
            OncologyModel clonclo = new OncologyModel();
            Session["ComplaintsList"] = strComplaints;
            var data = clonclo.SaveComplaints(strComplaints, strMRNO, strTranNo);
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SetDataForComplaints(string strTranNo)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.SetDataForComplaints(strTranNo), JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetDBComplainList(string complainName, string ClinicCode)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                return Json(clonclo.RetriveDBComplainList(complainName, ClinicCode), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        //added on 17th dec 2018
        public JsonResult AddFreeComplaint(string strComplaint, string strTran, string strMrNo)
        {
            try
            {
                OncologyModel oncoMdl = new OncologyModel();
                var data = oncoMdl.AddFreeComplaint(strComplaint, strTran, strMrNo);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        #region vitals

        public ActionResult Vitals()
        {
            return View();
        }

        public JsonResult SaveVitals(string strWeight, string strHeight, string strTemp, string strPulse, string strBlood, string strResp,
            string strOther, string strPrevWt, string strTranno, string strMrNo, string strWalkngYN, string strDietYN, string strMedicineYN,
            string strWalkDur, string strWalkDurType, string strSPO2, string strBMI, string strHeadCircf, string strPEFR, string strTechnique,
            string strCompliance, string streleTemp, string strelePulse, string streleBlood, string strPainScore, string strBSA
            , string strRBS, string strkarkyscore, string strEcogScore, string strPulseCond
            , string strIBW, string strBWPerc, string strWaistCircum, string strHip, string strWHR
            , string NutriScore, string NutriScoreNA, string NutriDescreseFoodInTake, string NutriWeightLoss, string NutriMobility, string NutriAcuteDisease, string NutriNeuropsy, string NutriBodyHabit
            , string strCmbWeight, string strCmbHeight, string strProxyVisit
            )  //Added by Murali on 25/04/2024                          
        {
            DataTable dt = new DataTable();
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.SaveVitalsTr(strWeight, strHeight, strTemp, strPulse, strBlood, strResp, strOther, strPrevWt, strTranno, strMrNo,
                strWalkngYN, strDietYN, strMedicineYN, strWalkDur, strWalkDurType, strSPO2, strBMI, strHeadCircf, strPEFR, strTechnique, strCompliance, streleTemp,
                strelePulse, streleBlood, strPainScore, strBSA, strRBS, strkarkyscore, strEcogScore, strPulseCond, 
                strIBW, strBWPerc, strWaistCircum, strHip, strWHR,
                NutriScore, NutriScoreNA, NutriDescreseFoodInTake, NutriWeightLoss, NutriMobility, NutriAcuteDisease, NutriNeuropsy, NutriBodyHabit, strCmbWeight, strCmbHeight, strProxyVisit);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SetDataForVitals(string strTranNo, string Type, string strMRNo)
        {
            OncologyModel cloncology = new OncologyModel();
            var data = cloncology.SetDataForVitals(strTranNo, Type, strMRNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMedHistory(string strMRNo, string strTranNo)
        {
            CommonServiceClient com = new CommonServiceClient();
            OncologyModel cloncology = new OncologyModel();
            var data = cloncology.GetMedHistory(strMRNo, strTranNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        #endregion

        //roshan 
        #region chemoPlanning
        public ActionResult ChmoPlanning(string PatMRNO = "")
        {
            var model = new OncologyEMR.Models.Planning();
            PatMRNO = PatMRNO == "" ? Convert.ToString(HttpContext.Session["PatMRNO"]) : PatMRNO;
            model.FillCombo(model, PatMRNO);
            model.TempGaction = "N";
            return View(model);
        }
        public JsonResult GetchemoHistory(string strMrNo)
        {
            OncologyModel oncomdl = new OncologyModel();
            var data = oncomdl.GetchemoHistory(strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCycleCount(string MRNo, string StrProtocole)
        {
            try
            {
                OncologyModel oncomdl = new OncologyModel();
                var data = oncomdl.GetCycleCount(MRNo, StrProtocole);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion chemoPlanning

        #region ClinicalHistory
        public ActionResult ClinicalNotes()
        {
            return View();
        }
        public JsonResult SaveClinicalNotes(string notes, string strTranno, string strMrNo)
        {
            DataTable dt = new DataTable();
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.SaveNotes(notes, strTranno, strMrNo);
            Session["ExamList"] = notes;
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetChemoNotes(string Tran, string Type)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                return Json(clonclo.GetClinicalNotes(Tran, Type), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetPreviousNotes(string strMrNo)
        {
            OncologyModel oncomdl = new OncologyModel();
            var data = oncomdl.GetPreviousNotes(strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion ClinicalHistory

        # region diagnosis
        public ActionResult Diagnosis()
        {
            return View();
        }

        public JsonResult SaveDiagnosis(string strDiagnosis, string strICDDiagnosis, string strMRNO, string strTranNo, string Tlst, string Nlst, string Mlst, string Site, string SubSite, string Stage,
            string ICDOTopoList, string ICDOHistoList, string CancerYN, string RadOnco, string MedOnco, string Palliative) //Added By Rajan - To Get the TNM List 
        {

            // DataTable dt = new DataTable();
            OncologyModel clonclo = new OncologyModel();
            Session["DiagnosisList"] = strDiagnosis;
            var data = clonclo.SaveDiagnosis(strDiagnosis, strICDDiagnosis, strMRNO, strTranNo, Tlst, Nlst, Mlst, Site, SubSite, Stage, ICDOTopoList, ICDOHistoList, CancerYN, RadOnco, MedOnco, Palliative);
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddDiagnosis(string strDiagnosis)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.SaveDiagnosisAddItemdt(strDiagnosis), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMainDiagnoList(string ClinicCode)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();

                return Json(clonclo.GetDiagnosisListdt(ClinicCode), JsonRequestBehavior.AllowGet);
                //return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult SetDataForDiagnosis(string strTranNo, string strMRNO)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.SetDataForDiagnosis(strTranNo, strMRNO), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetICDDiagnoList()
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                string clncCode = Convert.ToString(HttpContext.Session["ClinicCode"]);
                return Json(clonclo.GetICDDiagnosisListdt(clncCode), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetNonFregqentICDList(string NonFreqICD)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveNonFqtICDlist(NonFreqICD);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetNonFregqentICDOList(string NonFreqICDO, string ICDCode)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveNonFqtICDOlist(NonFreqICDO, ICDCode);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetNonFregqentDiagnoList(string NonFreqDiagno, string strClinincode)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.GetNonFregqentDiagnoList(NonFreqDiagno, strClinincode);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        //added by meenakshi on  3 may 2021
        public JsonResult AddDiagnosisDet(string strProvDiagnosis, string CompositStag, string TStage, string NStage, string MStage, string strTran, string strMrNo)
        {
            try
            {
                OncologyModel oncoMdl = new OncologyModel();
                var data = oncoMdl.AddDiagnosisDet(strProvDiagnosis, CompositStag, TStage, NStage, MStage, strTran, strMrNo);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        //Added By Rajan - To Get the TNM Site and Sub Site List 
        public JsonResult GetSiteSubSiteList(string SiteCd = "")
        {
            try
            {

                CommonServiceClient comser = new CommonServiceClient();
                var CSiteLst = comser.GetCRSiteLst();
                object CSite = null;
                if (SiteCd != "")
                {
                    CSite = CSiteLst.Where(x => x.CancerGrp == SiteCd && x.Status == "A").ToArray();
                }
                else
                {
                    CSite = comser.GetCRGrpLst().Where(x => x.Status == "A").ToArray();
                }
                return Json(CSite, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //Added By Rajan - To Get the TNM Stage List 
        public JsonResult GetStagingList(string SiteCode, string SubSiteCode)
        {
            OncologyModel oncoMdl = new OncologyModel();
            var jsonData = oncoMdl.GetTNMListForSite(SiteCode, SubSiteCode);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetToplogyHistoDefList()
        {
            CommonServiceClient Com = new CommonServiceClient();
            object[] obj = new object[4];
            obj[0] = Com.ICDOLst("");
            obj[1] = Com.ICDHISTOLst("");
            obj[2] = GeneralFunction.GetHitologyGrade();
            obj[3] = GeneralFunction.GetPrefixTNM();
            return Json(obj, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetICDOHistoList(string MRNo, string Type)
        {
            OncologyModel oncoMdl = new OncologyModel();
            var jsonData = oncoMdl.GetICDOHistory(MRNo, Type);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Examination
        public ActionResult Examination()
        {
            return View();
        }

        public JsonResult SaveExam(string strExam, string strTranno, string strMrNo, string OtherHistory, string PassHistYN = "N")
        {
            DataTable dt = new DataTable();
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.SaveexamTr(strExam, strTranno, strMrNo, OtherHistory, PassHistYN);
            Session["ExamList"] = strExam;
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetExam(string Tran, string Type)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                return Json(clonclo.GetExamdt(Tran, Type), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult RetriveExamImages(string MrNo, string TranNo)
        {
            try
            {
                OncologyModel cloncology = new OncologyModel();
                List<string> Images = null;
                Images = cloncology.GetExaminationImages(MrNo, TranNo);
                return Json(Images, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult RemoveExaminationFile(string MrNo, string TranNo, string FileName)
        {
            var directory = "";

            //if ( System.Web.HttpContext.Current.Application["Location"].ToString()== "Thane")
            //       directory = @"\\192.168.3.16\3.90 Backup Data\DoctDeskAttachments";
            //else if ( System.Web.HttpContext.Current.Application["Location"].ToString()== "Pune")
            //    directory = @"F:\\DoctDeskAttachments";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/PrescriptionImages/" + strUnit;
            string message = "";
            string result = "";

            var subPath = directory + "/" + MrNo;
            var TranPath = directory + "/" + MrNo + "/" + TranNo.Trim();
            var FinalPath = TranPath + "/" + (TranNo + "_" + FileName + ".png");

            try
            {
                if (Directory.Exists(directory))
                {
                    if (Directory.Exists(TranPath))
                    {
                        if (System.IO.File.Exists(FinalPath))
                        {
                            System.IO.File.Delete(FinalPath);
                            message = "File Deleted Successfully!";
                        }
                        else
                        {
                            message = "File Deleted Failed!";
                        }
                    }
                }
                result = message;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                message = "Error occurred. Error details: " + ex.Message;
                result = message;
                return Json(result, JsonRequestBehavior.AllowGet);
            }

        }


        #endregion


        #region "Examination setup"
        public JsonResult AddExaminationSetUp(string strSetUpName, string strExamSetupTempData, string strSetUpCode)
        {
            ExaminationSetup clonclo = new ExaminationSetup();
            return Json(clonclo.AddExaminationSetUp(strSetUpName, strExamSetupTempData, strSetUpCode), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetExamSetupList()
        {
            ExaminationSetup OM = new ExaminationSetup();
            object strResult = OM.GetExamSetupList();
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        //added on 6th MArch 2019
        public JsonResult GetExamSetupDataByCode(string strSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.GetPatAdvcListBySetupCode(strSetUpCode), JsonRequestBehavior.AllowGet);
        }

        #endregion "Examination setup"

        #region Completed
        //public JsonResult SaveComplete(string strTranno)
        //{
        //    DataTable dt = new DataTable();
        //    OncologyModel cloncology = new OncologyModel();
        //    var jsonData = cloncology.SavecompleteTr(strTranno);
        //    //  Session["ComplaintsList"] = strComplaints;
        //    return Json(jsonData, JsonRequestBehavior.AllowGet);
        //}

        #endregion

        #region InvestigationTran
        public ActionResult InvestigationTran()
        {
            OncologyModel clonclo = new OncologyModel();//added on 2nd may 2018
            clonclo.FillCombo(clonclo);//added on 2nd may 2018
            ViewBag.SRVCGRPLIST = clonclo.ServiceGrpLst;//added on 2nd may 2018
            return View();
        }

        public JsonResult SaveInvestigation(string strInvest, string strMRNO, string strTranNo)
        {
            //DataTable dt = new DataTable();
            OncologyModel clonclo = new OncologyModel();
            Session["InvestigationList"] = strInvest;
            var data = clonclo.SaveInvestigation(strInvest, strMRNO, strTranNo);
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetInvestigationList(string strTranNo)
        {
            try
            {

                OncologyModel clonclo = new OncologyModel();
                string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                return Json(clonclo.GetInvestigationList(strDoctorCd, strTranNo), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SetDataForInvestigation(string strTranNo)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.SetDataForInvestigation(strTranNo), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTestList(string testname, string strTranNo)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                return Json(clonclo.RetriveTestList(testname, strTranNo), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetPersInvestigationList()
        {
            OncologyModel OM = new OncologyModel();
            object strResult = OM.GetPersInvestigationList();
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SavePersonInvestigation(string Code, string strTranNO, string strMRNo)
        {
            try
            {
                OncologyModel OM = new OncologyModel();
                string strResult = OM.SavePerInvestigationTran(Code, strTranNO, strMRNo);
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult AddInvestnSetUp(string strInvestSetUpName, string strInvestigationLst, string strNameLst, string strSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.AddInvestnSetUp(strInvestSetUpName, strInvestigationLst, strNameLst, strSetUpCode), JsonRequestBehavior.AllowGet);
        }

        //added on 7th MArch 2019
        public JsonResult GetInvstListBySetupCode(string strSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.GetInvstListBySetupCode(strSetUpCode), JsonRequestBehavior.AllowGet);
        }

        //vijeta 18th march 19
        public JsonResult AddFreeInvestigation(string strInvestigation, string strTran, string strMrNo)
        {
            try
            {
                OncologyModel oncoMdl = new OncologyModel();
                var data = oncoMdl.AddFreeInvestigation(strInvestigation, strTran, strMrNo);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        #region PatPresc
        public JsonResult GetPatPresc(string strMRNO)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                //string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                return Json(clonclo.GetPatPresc(strMRNO), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }

        }

        public JsonResult SaveCopy(string PrevTranNo, string strMRNO, string strTranNo)
        {
            // DataTable dt = new DataTable();
            OncologyModel clonclo = new OncologyModel();
            //Session["PatPreTran"] = PrevTranNo;
            var data = clonclo.SaveCopy(PrevTranNo, strMRNO, strTranNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region History
        public ActionResult History()
        {
            return View();
        }
        public JsonResult GetHistory(string strMrNo)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                //string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                return Json(clonclo.GetHistory(strMrNo), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        #region Patient Advice
        public ActionResult PatientAdvice()
        {
            return View();
        }

        public JsonResult AddPatAdvice(string strPatAdv)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.SavePatadvAddItemdt(strPatAdv), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetPatAdvList(string ClinicCode)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                return Json(clonclo.GetPatAdvList(ClinicCode), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SavePatAdv(string strPatAdv, string strMRNO, string strTranNo)
        {
            // DataTable dt = new DataTable();
            OncologyModel clonclo = new OncologyModel();
            Session["PatAdviceList"] = strPatAdv;
            var data = clonclo.SavePatAdv(strPatAdv, strMRNO, strTranNo);
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SetDataForPatAdv(string strTranNo)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.SetDataForPatAdv(strTranNo), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDBPatientAdvice(string PatAdvice, string ClinicCode)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                return Json(clonclo.RetriveDBPatAdvice(PatAdvice, ClinicCode), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult AddFreeAdvice(string strAdvice, string strTran, string strMrNo)
        {
            try
            {
                OncologyModel oncoMdl = new OncologyModel();
                var data = oncoMdl.AddFreePatAdvice(strAdvice, strTran, strMrNo);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }


        //added on 6th sep 2018
        #region Patient Advice Personalized
        public JsonResult GetPersPatientAdviceList()
        {
            OncologyModel OM = new OncologyModel();
            object strResult = OM.GetPersPatientAdviceList();
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddPatAdviceSetUp(string strPatAdviceSetUpName, string strAdviceLst, string strNameLst, string strSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.AddPatAdviceSetUp(strPatAdviceSetUpName, strAdviceLst, strNameLst, strSetUpCode), JsonRequestBehavior.AllowGet);
        }

        public JsonResult SavePersonalizedAdvces(string Code, string strTranNO, string strMRNo)
        {
            try
            {
                OncologyModel OM = new OncologyModel();
                string strResult = OM.SavePersonalizedAdvces(Code, strTranNO, strMRNo);
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetAdvicesBySetUpCode(string strCode, string strType)
        {
            try
            {
                OncologyModel oncologyModel = new OncologyModel();
                object strResult = oncologyModel.GetAdvicesBySetUpCode(strCode, strType);
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json("Unsucessfull", JsonRequestBehavior.AllowGet);
            }
        }

        //added on 6th MArch 2019
        public JsonResult GetPatAdvcListBySetupCode(string strSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.GetPatAdvcListBySetupCode(strSetUpCode), JsonRequestBehavior.AllowGet);
        }
        #endregion
        //----------------------------------
        #endregion

        #region Cost Estimation
        //public ActionResult CostEstimation()
        //{
        //    return View();
        //}

        public ActionResult CostEstimation(string GAction = "N", string TRANNO = "")
        {
            COSTESTIMATIONMDL COSTESTMDL = new COSTESTIMATIONMDL();
            var BEDCATGLIST = OncoCli.GetBedCatgList().Where(x => x.Status == "A").ToList().OrderBy(x => x.Value).ToList();
            ViewBag.BEDCATGITEMLIST = (from OncologyEMR.Oncology.SelectLstItem row in BEDCATGLIST
                                       select new { id = row.Value, CHECK = false, BEDCATGCD = row.Value, BEDCATGNM = row.Text }).ToArray();
            if (GAction != "N")
            {
                //COSTESTMDL.FILLCOMBOS(COSTESTMDL, GAction);
                COSTESTMDL.GETCOSTESTIDET(COSTESTMDL, TRANNO);
                ViewBag.SERVGETSETDATA = COSTESTMDL.STRGESSETDATA;
                ViewBag.COMPGETSETDATA = COSTESTMDL.STRGESSETCOMPDATA;
            }
            ViewBag.RGaction = GAction;
            Session["PRNCOSTEST"] = COSTESTMDL;
            COSTESTMDL.FILLCOMBOS(COSTESTMDL, GAction);

            //COSTESTMDL.Rights = OncologyEMR.DataClass.GeneralFunction.assignRightToModel(COSTESTMDL, "CostEstimation");
            return View(COSTESTMDL);
        }

        public JsonResult GetAssoSergSearchInfo()
        {

            IEnumerable<OncologyEMR.Oncology.SelectLstItem> servlst;
            servlst = OncoCli.GetServiceList().Where(x => x.Status == "A" && x.Text.ToUpper().Contains("ASSOCIATE")); //
            SelectList LstService = new SelectList((from a in servlst select new { ServiceCode = a.Value, ServiceName = a.Text, }).ToList(), "ServiceCode", "ServiceName");
            return Json(LstService, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSergerySearchInfo()
        {
            CommonServiceClient com = new CommonServiceClient();
            string strSurgType = "";
            IEnumerable<OncologyEMR.Oncology.SurgListItem> servlst;
            servlst = OncoCli.GetSurgeryList().Where(x => x.Status == "A");
            SelectList LstService = new SelectList((from a in servlst select new { ServiceCode = a.Value, ServiceName = a.Text, }).ToList(), "ServiceCode", "ServiceName");
            return Json(LstService, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetGIPSASergerySearchInfo()
        {
            IEnumerable<OncologyEMR.Oncology.SelectLstItem> servlst;
            servlst = OncoCli.GetGIPSAList().Where(x => x.Status == "A");
            SelectList LstService = new SelectList((from a in servlst select new { ServiceCode = a.Value, ServiceName = a.Text, }).ToList(), "ServiceCode", "ServiceName");
            return Json(LstService, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GETSERVICEDATA(string SERVCODE, string FROMSEARCH)
        {
            object[] RESULTDATA = new object[7];
            string data = FROMSEARCH == "GIPSA" ? OncoCli.GetSurgCostEstiDetails("", SERVCODE) : OncoCli.GetSurgCostEstiDetails(SERVCODE, "");
            DataSet DsDet = new DataSet();
            DsDet.ReadXml(new XmlTextReader(new StringReader(data)));
            List<LISTDATA> COMPOLIST = new List<LISTDATA>();
            if (DsDet.Tables.Count > 0)
            {

                var RowDS = DsDet.Tables[0].Rows[0];
                double WARDQTY = Convert.ToDouble(RowDS["NOOFWARD"].ToString().Trim());
                double ISUQTY = Convert.ToDouble(RowDS["NOOFICU"].ToString().Trim());

                COMPOLIST.Add(new LISTDATA { DESC = "PROCEDURE CHARGES", QTYDAYS = "", Value = "01" });
                COMPOLIST.Add(new LISTDATA { DESC = "ASSOC SURG CHARGES", QTYDAYS = "", Value = "02" });
                COMPOLIST.Add(new LISTDATA { DESC = "BED CHARGES WARD", QTYDAYS = RowDS["NOOFWARD"].ToString().Trim(), Value = "03" });
                COMPOLIST.Add(new LISTDATA { DESC = "BED CHARGES ICU", QTYDAYS = RowDS["NOOFICU"].ToString().Trim(), Value = "04" });
                COMPOLIST.Add(new LISTDATA { DESC = "DR. VISIT CHARGES WARD", QTYDAYS = WARDQTY > 0 ? (WARDQTY + 1).ToString() : "0", Value = "05" });
                COMPOLIST.Add(new LISTDATA { DESC = "DR. VISIT CHARGES ICU", QTYDAYS = ISUQTY > 0 ? (ISUQTY + 1).ToString() : "0", Value = "06" });
                COMPOLIST.Add(new LISTDATA { DESC = "INVESTIGATION", QTYDAYS = RowDS["INVESTAMT"].ToString().Trim(), Value = "07" });
                COMPOLIST.Add(new LISTDATA { DESC = "MEDICINE & CONSUMABLES", QTYDAYS = RowDS["MEDIAMT"].ToString().Trim(), Value = "08" });
                COMPOLIST.Add(new LISTDATA { DESC = "BLOOD BANK CHARGES", QTYDAYS = RowDS["BLDBANKAMT"].ToString().Trim(), Value = "09" });
                COMPOLIST.Add(new LISTDATA { DESC = "OTHER", QTYDAYS = RowDS["OTHERAMT"].ToString().Trim(), Value = "10" });

                var jsonData = (from LISTDATA row in COMPOLIST
                                select new
                                {
                                    id = row.Value,
                                    COMPONENT = row.DESC,
                                    QTYDAYS = row.QTYDAYS,
                                }).ToArray();
                RESULTDATA[0] = "SUCCESS";
                RESULTDATA[1] = jsonData;
                RESULTDATA[2] = DsDet.Tables[0].Rows[0]["SERVCODE"].ToString().Trim();
                RESULTDATA[3] = DsDet.Tables[0].Rows[0]["SERVNAME"].ToString().Trim();
                RESULTDATA[4] = DsDet.Tables[0].Rows[0]["GIPSACODE"].ToString().Trim();
                RESULTDATA[5] = DsDet.Tables[0].Rows[0]["GIPSANAME"].ToString().Trim();
                RESULTDATA[6] = DsDet.Tables[0].Rows[0]["ASSSURGCODE"].ToString().Trim();
            }
            else
            {
                RESULTDATA[0] = "FAIL";
            }


            return Json(RESULTDATA, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GETCOSTESTIMATION(COSTESTIMATIONMDL COSTESTMDL, string TARIFF = "", string COMPCODE = "")
        {

            TARIFF = TARIFF.Trim();
            if (TARIFF == "")
            {
                TARIFF = com.GetSetupValue("HOSPTARIFFCAT");
            }

            string TRANYEAR = OncoCli.GetTranYrOFCrdComp(COMPCODE);

            string SURGCODE = COSTESTMDL.STRSURGECODE == null || COSTESTMDL.STRSURGECODE.Trim() == "" ? "" : COSTESTMDL.STRSURGECODE.Substring(COSTESTMDL.STRSURGECODE.Length - 12, 12).Trim();
            string ASSOSURGCODE = COSTESTMDL.STRASSOSURGECODE == null || COSTESTMDL.STRASSOSURGECODE.Trim() == "" ? "" : COSTESTMDL.STRASSOSURGECODE.Substring(COSTESTMDL.STRASSOSURGECODE.Length - 12, 12).Trim();
            string GIPSASURGCODE = COSTESTMDL.STRGIPSACODE == null || COSTESTMDL.STRGIPSACODE.Trim() == "" ? "" : COSTESTMDL.STRGIPSACODE.Substring(COSTESTMDL.STRGIPSACODE.Length - 12, 12).Trim();

            string STRSERVCODE = SURGCODE != "" ? "'" + SURGCODE + "'," : "";
            STRSERVCODE += ASSOSURGCODE != "" ? "'" + ASSOSURGCODE + "'," : "";
            STRSERVCODE += GIPSASURGCODE != "" ? "'" + GIPSASURGCODE + "'," : "";
            STRSERVCODE = STRSERVCODE.Substring(0, STRSERVCODE.Length - 1);
            DataTable bedcatg = JsonConvert.DeserializeObject<DataTable>(COSTESTMDL.STRBEDLIST);
            string BedcatgLST = "";
            foreach (DataRow rw in bedcatg.Rows)
            {
                BedcatgLST += "'" + rw["BEDCATGCD"].ToString().Trim() + "',";
            }
            BedcatgLST = BedcatgLST.Substring(0, BedcatgLST.Length - 1);

            var sdata = OncoCli.GetSurgCostEstiCosts(STRSERVCODE, BedcatgLST, TARIFF, TRANYEAR);
            DataSet DsDet = new DataSet();
            DsDet.ReadXml(new XmlTextReader(new StringReader(sdata)));

            object[] RESULTDATA = new object[3];

            var PERCENDATA = (from DataRow row in DsDet.Tables[0].Rows
                              select new
                              {
                                  id = row["BEDCATGCD"].ToString().Trim(),
                                  BEDCATGCD = row["BEDCATGCD"].ToString().Trim(),
                                  INVESTICHARGE = row["INVESTICHARGE"].ToString().Trim(),
                                  BLDBNKCHARGE = row["BLDBNKCHARGE"].ToString().Trim(),
                                  BEDCHRGWARD = row["BEDCHRGWARD"].ToString().Trim(),
                                  VISITCHRGWARD = row["VISITCHRGWARD"].ToString().Trim(),
                                  ICUYN = "N", //row["ICUYN"].ToString().Trim(),
                                  BEDCHRG = row["BEDCHRG"].ToString().Trim(),
                                  VISITCHRG = row["VISITCHRG"].ToString().Trim()
                              }).ToList();
            if (DsDet.Tables.Contains("servCost"))
            {
                RESULTDATA[2] = (from DataRow row in DsDet.Tables[1].Rows
                                 select new
                                 {
                                     id = row["SERVCODE"].ToString().Trim() + row["BEDCATGCD"].ToString().Trim(),
                                     SERVCODE = row["SERVCODE"].ToString().Trim(),
                                     BEDCATGCD = row["BEDCATGCD"].ToString().Trim(),
                                     SERVCOST = row["SERVCOST"].ToString().Trim()
                                 }).ToList();

            }
            else { RESULTDATA[2] = ("").ToList(); }
            RESULTDATA[0] = "SUCCESS";
            RESULTDATA[1] = PERCENDATA;
            //RESULTDATA[2] = SURGERYDATA;
            return Json(RESULTDATA, JsonRequestBehavior.AllowGet);
        }

        //[cutomRights("CostEstimation", "BTNNEW")]
        public JsonResult SaveCostEstimate(COSTESTIMATIONMDL COSTESTMDL, string CTYPE, string MRNO, string PATNAME, string ACTIONMODE = "N", string TRANNO = "")
        {
            var UserID = Session["gOncoUserId"].ToString();
            var MchIPAddress = string.IsNullOrEmpty(Session["MchIPAddress"].ToString()) ? "" : Session["MchIPAddress"].ToString();
            var ModuleIDGlobal = string.IsNullOrEmpty(Session["ModuleIDGlobal"].ToString()) ? "" : Session["ModuleIDGlobal"].ToString();
            var FundSource = string.IsNullOrEmpty(Session["FundSource"].ToString()) ? "" : Session["FundSource"].ToString();
            var HospUnit = string.IsNullOrEmpty(Session["HospUnit"].ToString()) ? "" : Session["HospUnit"].ToString();
            var CntrCd = string.IsNullOrEmpty(Session["CounterCd"].ToString()) ? "" : Session["CounterCd"].ToString();
            string DOCTCODE = Convert.ToString(HttpContext.Session["gDoctCode"]);
            object Status = COSTESTMDL.SaveCostEstimate(COSTESTMDL, MRNO, PATNAME, DOCTCODE, ACTIONMODE, CTYPE, UserID, MchIPAddress, ModuleIDGlobal, FundSource, HospUnit, CntrCd, TRANNO);

            return Json(Status, JsonRequestBehavior.AllowGet);
        }

        //[cutomRights("CostEstimation", "BTNPRINT")]
        public object PrintCostEstmn(string DATA, string STRPATNM, string STRDOCTNAME, string STRSURGONNM, string STRSRGRYNM, string TRANNO, string TRANDATE, string TRANTIME, string ACTIONMODE, string PRINTTYPE)
        {
            COSTESTIMATIONMDL COSTESTMDL = new COSTESTIMATIONMDL();
            DataSet AllData = new DataSet();
            DataTable HFData = new DataTable();
            string formName = "Surgery Estimation";
            Dictionary<string, object> dict = new Dictionary<string, object>();
            object jsonComplaints = "";

            var data = (COSTESTIMATIONMDL)Session["PRNCOSTEST"];
            data.STRGESSETDATA = null;
            data.STRGESSETCOMPDATA = null;

            DataTable dsDET = new DataTable();

            dsDET.TableName = "COSTESTMNDET";

            dsDET.Columns.Add("STRPATNAME");
            dsDET.Columns.Add("STRDOCTCODE");
            dsDET.Columns.Add("STRSURGEDOCTCODE");
            dsDET.Columns.Add("STRSURGECODE");
            dsDET.Columns.Add("STRGIPSACODE");
            dsDET.Columns.Add("STRCOMPCODE");
            dsDET.Columns.Add("STRREMARKS");

            dsDET.Rows.Add();
            dsDET.Rows[0]["STRPATNAME"] = STRPATNM;
            dsDET.Rows[0]["STRDOCTCODE"] = STRDOCTNAME.ToString().Trim();
            //dsDET.Rows[0]["STRDOCTCODE"] = data.DOCTORLIST.Where(x => x.Value == data.STRDOCTCODE).FirstOrDefault().Text;
            dsDET.Rows[0]["STRSURGEDOCTCODE"] = data.STRSURGEDOCTCODE != null ? data.DOCTORLIST.Where(x => x.Value == data.STRSURGEDOCTCODE).Count() > 0 ? data.DOCTORLIST.Where(x => x.Value == data.STRSURGEDOCTCODE).FirstOrDefault().Text : "" : "";
            dsDET.Rows[0]["STRSURGECODE"] = STRSRGRYNM;
            dsDET.Rows[0]["STRGIPSACODE"] = "";
            dsDET.Rows[0]["STRCOMPCODE"] = data.STRCOMPCODE != null ? data.COMPONYLIST.Where(x => x.Value == data.STRCOMPCODE).Count() > 0 ? data.COMPONYLIST.Where(x => x.Value == data.STRCOMPCODE).FirstOrDefault().Text : "" : "";

            dsDET.Rows[0]["STRREMARKS"] = data.STRREMARKS; //


            DataTable dtSRVdata = JsonConvert.DeserializeObject<DataTable>(DATA);
            var Bedlist = OncoCli.GetBedCatgList();

            string Bedname1 = dtSRVdata.Columns.Count > 3 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[3].ColumnName.Substring(1, 2)).Count() > 0 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[3].ColumnName.Substring(1, 2)).FirstOrDefault().Text : "" : "";
            string Bedname2 = dtSRVdata.Columns.Count > 4 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[4].ColumnName.Substring(1, 2)).Count() > 0 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[4].ColumnName.Substring(1, 2)).FirstOrDefault().Text : "" : "";
            string Bedname3 = dtSRVdata.Columns.Count > 5 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[5].ColumnName.Substring(1, 2)).Count() > 0 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[5].ColumnName.Substring(1, 2)).FirstOrDefault().Text : "" : "";
            string Bedname4 = dtSRVdata.Columns.Count > 6 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[6].ColumnName.Substring(1, 2)).Count() > 0 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[6].ColumnName.Substring(1, 2)).FirstOrDefault().Text : "" : "";
            string Bedname5 = dtSRVdata.Columns.Count > 7 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[7].ColumnName.Substring(1, 2)).Count() > 0 ? Bedlist.Where(x => x.Value == dtSRVdata.Columns[7].ColumnName.Substring(1, 2)).FirstOrDefault().Text : "" : "";

            dtSRVdata.Columns.Add("COLUMN1");
            dtSRVdata.Columns.Add("COLUMN2");
            dtSRVdata.Columns.Add("COLUMN3");
            dtSRVdata.Columns.Add("COLUMN4");
            dtSRVdata.Columns.Add("COLUMN5");
            dtSRVdata.Rows[0]["COLUMN1"] = Bedname1;
            dtSRVdata.Rows[0]["COLUMN2"] = Bedname2;
            dtSRVdata.Rows[0]["COLUMN3"] = Bedname3;
            dtSRVdata.Rows[0]["COLUMN4"] = Bedname4;
            dtSRVdata.Rows[0]["COLUMN5"] = Bedname5;
            dtSRVdata.Columns.Remove("id");
            dtSRVdata.TableName = "COSTESTMNDETLST";

            HFData = GeneralFunction.getHeaderFooter(formName, "", "", PRINTTYPE);
            HFData.TableName = "HeaderFooter";


            jsonComplaints = (from DataRow row in HFData.AsEnumerable()
                              select new
                              {

                                  HospName = row["HospName"].ToString().Trim(),
                                  HospAdd = row["HospAdd"].ToString().Trim(),
                                  HospLogo = Convert.ToBase64String((byte[])(row["HospLogo"]), 0, ((byte[])(row["HospLogo"])).Length),
                                  ForDate = row["ForDate"].ToString().Trim(),
                                  PrintDateTime = row["PrintDateTime"].ToString().Trim(),
                                  PrintedBy = row["PrintedBy"].ToString().Trim(),
                                  FormName = row["FormName"].ToString().Trim(),
                                  Duplicate = row["Duplicate"].ToString().Trim()
                              }).ToArray();
            dict.Add("jsonComplaints", jsonComplaints);


            return Json(dict, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DISPLAYCOSTESTMN()
        {
            MemoryStream outmeomery = new MemoryStream();
            byte[] printdata = TempData["printdata"] as byte[];
            return new BinaryContentResult(printdata, "application/pdf", "Cost-Estimation");
        }
        #endregion

        #region Attachments
        public ActionResult Attachments(string MRNO)
        {
            var directory = "";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/DoctDeskAttachments/" + strUnit;

            string salesFTPPath = directory + "/" + MRNO;
            if (!Directory.Exists(salesFTPPath))
            {
                return View();
            }
            else
            {
                GetAttachment(MRNO);
                //GetLabAttachment(MRNO);
                return View();
            }
        }

        public JsonResult GetAttachment(string MRNO)
        {
            DirectoryInfo salesFTPDirectory = null;
            FileInfo[] files = null;
            List<string> names = new List<string>();
            var directory = "";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/DoctDeskAttachments/" + strUnit;

            string salesFTPPath = directory + "/" + MRNO;
            if (Directory.Exists(salesFTPPath))
            {
                salesFTPDirectory = new DirectoryInfo(salesFTPPath);
                files = salesFTPDirectory.GetFiles();
                //files = files.OrderBy(f => f.Name).Where(f => f.Extension == ".pdf" || f.Extension == ".jpg" || f.Extension == ".jpeg" || f.Extension == ".txt").ToArray();
                for (int i = 0; i < files.Length; i++)
                {
                    names.Add(files[i].Name);
                }
            }

            ViewBag.Attach = names;

            return Json(ViewBag.Attach, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDisSummaryAttachment(string MRNO)
        {
            using (OncologyEMRClient OncoCli = new OncologyEMRClient())
            {
                var xmlData = OncoCli.GetDisSumList(MRNO);

                List<string> ipnos = new List<string>();
                Dictionary<string, List<string>> filesByIpno = new Dictionary<string, List<string>>();

                DataSet dsDisSumLst = new DataSet();
                dsDisSumLst.ReadXml(new XmlTextReader(new StringReader(xmlData)));

                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                string directory = GeneralFunction.GetAppsettingUnitWiseValue("DSPDFDocumentPath").ToString() + "/" + strUnit;
                var formattedResults = new List<string>();

                if (dsDisSumLst.Tables.Count > 0)
                {
                    //for (int i = 0; i < ipnos.Count; i++)
                    //{
                    //    string currentIpno = ipnos[i];
                    //    string salesFTPPath = Path.Combine(directory, currentIpno);

                    //    if (Directory.Exists(salesFTPPath))
                    //    {
                    //        DirectoryInfo salesFTPDirectory = new DirectoryInfo(salesFTPPath);
                    //        FileInfo[] files = salesFTPDirectory.GetFiles();


                    //        List<string> fileNamesForCurrentIpno = new List<string>();

                    //        foreach (var file in files)
                    //        {
                    //            fileNamesForCurrentIpno.Add(file.Name);
                    //        }

                    //        filesByIpno[currentIpno] = fileNamesForCurrentIpno;
                    //    }
                    //}
                    for (int i = 0; i < dsDisSumLst.Tables[0].Rows.Count; i++)
                    {
                        formattedResults.Add(dsDisSumLst.Tables[0].Rows[i]["IPNO"].ToString().Trim() + "_" + dsDisSumLst.Tables[0].Rows[i]["DISSUMNO"] + ".pdf");
                    }
                }


                //var formattedResults = new List<string>();

                //foreach (var kvp in filesByIpno)
                //{
                //    string ipno = kvp.Key;
                //    foreach (var fileName in kvp.Value)
                //    {
                //        formattedResults.Add(ipno + "/" + fileName);
                //    }
                //}

                var result = new
                {
                    FileNames = formattedResults,
                    Directory = directory // Add directory to the response
                };

                return Json(result, JsonRequestBehavior.AllowGet);
            }
        }


        public JsonResult GetLabAttachment(string MRNO ,string strUnit = "")
        {
            DirectoryInfo salesFTPDirectory = null;
            FileInfo[] files = null;
            List<string> names = new List<string>();
            var directory = "";
            strUnit = strUnit == "" ? ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString() : strUnit;
            directory = GeneralFunction.GetAppsettingUnitWiseValue("LABDocPath").ToString() + "/" + strUnit;

            string salesFTPPath = directory + "/" + MRNO;
            if (Directory.Exists(salesFTPPath))
            {
                var SubDirectories = Directory.GetDirectories(salesFTPPath);
                for (int f = 0; f <= SubDirectories.Length - 1; f++)
                {
                    string[] a = SubDirectories[f].Split('\\');
                    salesFTPDirectory = new DirectoryInfo(SubDirectories[f]);
                    files = salesFTPDirectory.GetFiles();
                    for (int i = 0; i < files.Length; i++)
                    {
                        //Added By Priyanka on 05/02/2025
                        //to skip the file starts with below initials
                        if (!(files[i].Name.ToUpper().StartsWith("LB") || files[i].Name.ToUpper().StartsWith("CB") || files[i].Name.ToUpper().StartsWith("RB") || files[i].Name.ToUpper().StartsWith("NB")))
                        {
                            if (!files[i].Name.ToUpper().Contains("_RH") && !files[i].Name.ToUpper().Contains("LBRN"))
                                names.Add("/" + a[a.Length - 1] + "/" + files[i].Name);
                        }
                }
                }
                //files = files.OrderBy(f => f.Name).Where(f => f.Extension == ".pdf" || f.Extension == ".jpg" || f.Extension == ".jpeg" || f.Extension == ".txt").ToArray();

            }

            ViewBag.LabAttach = names;

            //return Json(ViewBag.Attach == null ? "" : ViewBag.Attach, JsonRequestBehavior.AllowGet);
            return Json(names, JsonRequestBehavior.AllowGet); ;//priyanka 14/03/2026
            //  return names;
        }

        public ActionResult UploadFile()
        {
            bool isUploaded = false;
            string message = "";
            int fileCount = 0;
            var countpath = "";
            //var name = Request.Form["IpNo"];
            DataTable dtfile = new DataTable();
            dtfile.Columns.Add("FilePath");
            dtfile.Columns.Add("FileName");
            dtfile.Columns.Add("View");

            var directory = "";

            //if ( System.Web.HttpContext.Current.Application["Location"].ToString() == "Thane")
            //    directory = @"\\192.168.3.16\3.90 Backup Data\DoctDeskAttachments";
            //else if ( System.Web.HttpContext.Current.Application["Location"].ToString()== "Pune")
            //    directory = @"F:\\DoctDeskAttachments";

            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/DoctDeskAttachments/" + strUnit;

            Dictionary<string, object> dc = new Dictionary<string, object>();
            if (Request.Files.Count > 0)
            {

                try
                {
                    //  Get all files from Request object  
                    var mrno = Request.Form["MrNo"];

                    HttpFileCollectionBase files = Request.Files;
                    HttpPostedFileBase file = files[0];
                    if (file.ContentType == "application/pdf" || file.ContentType == "image/jpeg" || file.ContentType == "image/png" || file.ContentType == "image/jpg") //priyanka 14/04/2026
                    {
                        string fname;

                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                        }
                        else
                        {
                            fname = Regex.Replace(file.FileName, @"\s+", "");
                            //fname = file.FileName.Trim();
                        }

                        // Get the complete folder path and store the file inside it.                 
                        var labpath = directory;
                        var subpath = directory + "/" + mrno;
                        var path1 = directory + "/" + mrno + "/" + fname;
                        countpath = directory + "/" + mrno + "//";
                        if (mrno != "")
                        {

                            if (System.IO.File.Exists(path1))
                            {
                                isUploaded = false;
                                message = "File already uploaded!";
                                return Json(new { success = isUploaded, Message = message }, JsonRequestBehavior.AllowGet);
                            }

                            if (Directory.Exists(path1))
                            {
                                System.IO.File.Delete(path1);
                                file.SaveAs(path1);
                                isUploaded = true;
                                message = "File Uploaded Successfully!";
                                int count = Directory.GetFiles(countpath).Length;

                            }
                            else if (!Directory.Exists(labpath))
                            {
                                Directory.CreateDirectory(labpath);
                                if (Directory.Exists(directory))
                                {
                                    DirectoryInfo dInfo = new DirectoryInfo(labpath);
                                    DirectoryInfo dis = dInfo.CreateSubdirectory(mrno);
                                    file.SaveAs(path1);
                                    isUploaded = true;
                                    message = "File Uploaded Successfully!";
                                    int count = Directory.GetFiles(countpath).Length;
                                }
                            }
                            if (Directory.Exists(labpath))
                            {
                                if (Directory.Exists(subpath))
                                {
                                    file.SaveAs(path1);
                                    isUploaded = true;
                                    message = "File Uploaded Successfully!";
                                }
                                else
                                {
                                    DirectoryInfo dInfo = new DirectoryInfo(labpath);
                                    DirectoryInfo dis = dInfo.CreateSubdirectory(mrno);
                                    file.SaveAs(path1);
                                    isUploaded = true;
                                    message = "File Uploaded Successfully!";
                                    int count = Directory.GetFiles(countpath).Length;
                                }
                            }
                        }
                        // }
                        // Returns message that successfully uploaded  


                        fileCount = Directory.GetFiles(countpath).Length;
                        string[] filePaths = Directory.GetFiles(countpath);

                        for (int i = 0; i <= filePaths.Length - 1; i++)
                        {
                            DataRow dr = dtfile.NewRow();
                            dr["FilePath"] = filePaths[i];
                            int len = filePaths[i].Length;
                            int pos = filePaths[i].LastIndexOf("//");
                            var filenm = filePaths[i].Substring(pos + 2).Trim();
                            dr["FileName"] = filenm;
                            dtfile.Rows.Add(dr);
                        }

                        var jsonDatas = new
                        {
                            rows = (from DataRow row in dtfile.Rows
                                    select new
                                    {
                                        FilePath = ("" + row["FilePath"]).Trim(),
                                        FileName = ("" + row["FileName"]).Trim(),
                                        View = ("" + row["View"]).Trim(),
                                    }).ToArray()

                        };


                        if (isUploaded == true)
                        {
                            dc.Add("Message", message);
                            dc.Add("isUploaded", isUploaded);
                            dc.Add("jsonData", jsonDatas);
                        }

                        return Json(dc);

                    }
                    else
                    {
                        message = "Incorrect File Format.";
                        dc.Add("Message", message);
                        return Json(dc);
                    }
                }
                catch (Exception ex)
                {
                    message = "Error occurred. Error details: " + ex.Message;
                    dc.Add("Message", message);
                    return Json(dc);
                    // return Json("Error occurred. Error details: " + ex.Message);
                }
            }
            else
            {
                message = "No files selected.";
                dc.Add("Message", message);
                return Json(dc);

                //return Json("No files selected.");
            }
        }

        public string RemoveFile(string filename, string Mrno)               //vishal 9th March 2019
        {
            var directory = "";

            //if ( System.Web.HttpContext.Current.Application["Location"].ToString()== "Thane")
            //       directory = @"\\192.168.3.16\3.90 Backup Data\DoctDeskAttachments";
            //else if ( System.Web.HttpContext.Current.Application["Location"].ToString()== "Pune")
            //    directory = @"F:\\DoctDeskAttachments";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/DoctDeskAttachments/" + strUnit;


            // Checking for Internet Explorer  
            if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
            {
                string[] testfiles = filename.Split(new char[] { '\\' });
                filename = testfiles[testfiles.Length - 1];
            }
            else
            {
                filename = Regex.Replace(filename, @"\s+", "");
            }
            string message = "";
            string result = "";
            var path1 = directory;
            var path2 = directory + "/" + Mrno;
            var path3 = directory + "/" + Mrno + "/" + filename.Trim();
            try
            {
                if (Directory.Exists(directory))
                {
                    if (Directory.Exists(path2))
                    {
                        if (System.IO.File.Exists(path3))
                        {
                            System.IO.File.Delete(path3);
                            message = "File Deleted Successfully!";
                        }
                        else
                        {
                            message = "File Deleted Failed!";
                        }
                    }
                }
                result = message;
                return result;
            }
            catch (Exception ex)
            {
                message = "Error occurred. Error details: " + ex.Message;
                result = message;
                return result;
            }
        }

        public FileContentResult FileDownload(string MRNo, string filename, string fileType = "A")
        {
            var directory = "";
            var filepath = "";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            if (fileType == "A")
            {
                if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                {
                    string[] testfiles = filename.Split(new char[] { '\\' });
                    filename = testfiles[testfiles.Length - 1];
                }
                else
                {
                    filename = Regex.Replace(filename, @"\s+", "");
                }
                directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/DoctDeskAttachments/" + strUnit;
                filepath = directory + "/" + MRNo + "/" + filename;
            }
            else if (fileType == "D") //Discharge summmary added by meenakhi on 08-10-2024
            {
                directory = GeneralFunction.GetAppsettingUnitWiseValue("DSPDFDocumentPath").ToString() + "/" + strUnit;
                filepath = directory + "/" + filename;
            }

            byte[] fileBytes = System.IO.File.ReadAllBytes(filepath);

            string contentType = "";
            string[] Extension = filename.Split('.');
            var FileExtension = Extension[Extension.Length - 1];
            if (FileExtension.ToLower() == "pdf")
            {
                contentType = "application/pdf";
            }
            else if (FileExtension.ToLower() == "txt")
            {
                contentType = "text/plain";
            }
            else if (FileExtension.ToLower() == "jpg" || FileExtension.ToLower() == "jpeg")
            {
                contentType = "image/jpeg";
            }
            else if (FileExtension.ToLower() == "png")
            {
                contentType = "image/png";
            }
            else if (FileExtension.ToLower() == "xslx")
            {
                contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            }
            else if (FileExtension.ToLower() == "xls")
            {
                contentType = "application/vnd.ms-excel";
            }
            else
            {
                contentType = "application/" + FileExtension.ToLower();
            }
            Response.AppendHeader("Content-Disposition", "inline; filename=" + filename);
            return File(fileBytes, contentType);
        }

        public FileContentResult LabFileDownload(string MRNo, string filename, string strUnit = "")
        {
            var directory = "";

            strUnit = strUnit != "" ? strUnit : ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("LABDocPath").ToString() + "/" + strUnit;
            var filepath = directory + "/" + MRNo + "/" + filename;
            byte[] fileBytes = System.IO.File.ReadAllBytes(filepath);

            string contentType = "";
            string[] Extension = filename.Split('.');
            var FileExtension = Extension[Extension.Length - 1];
            if (FileExtension == "pdf")
            {
                contentType = "application/pdf";
            }
            else if (FileExtension.ToLower() == "txt")
            {
                contentType = "text/plain";
            }
            else if (FileExtension.ToLower() == "jpg" || FileExtension.ToLower() == "jpeg")
            {
                contentType = "image/jpeg";
            }
            else if (FileExtension.ToLower() == "png")
            {
                contentType = "image/png";
            }
            else if (FileExtension.ToLower() == "xslx")
            {
                contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            }
            else if (FileExtension.ToLower() == "xls")
            {
                contentType = "application/vnd.ms-excel";
            }

            Response.AppendHeader("Content-Disposition", "inline; filename=" + filename);
            return File(fileBytes, contentType);

        }

        public ActionResult DisplayFile(string path)
        {

            byte[] fileBytes = System.IO.File.ReadAllBytes(path);

            string contentType;
            string[] Extension = path.Split('.');

            contentType = "image/" + Extension[Extension.Length - 1];

            return new BinaryContentResult(fileBytes, contentType, Extension[Extension.Length - 2] + "." + Extension[Extension.Length - 1]);
        }
        #endregion
        //end

        #region InvestigationReport---------

        public ActionResult Investigation(string MRNO)
        {
            GetLabAttachment(MRNO);
            return View();
        }

        public JsonResult GetInvestigation(string mrNo, string strFrmDate, string strTodate)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveInvestigations(mrNo, strFrmDate, strTodate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDateWiseInvestigation(string mrNo, string strFrmDate, string strTodate)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveDateWiseInvesg(mrNo, strFrmDate, strTodate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTemplateResult(string mrNo, string strFrmDate, string strTodate)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveTempReportData(mrNo, strFrmDate, strTodate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTrendsInvestigation(string mrNo, string TestCode, string strFrmDate, string strTodate)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveTrendWiseInvesg(mrNo, TestCode, strFrmDate, strTodate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetInvestigationResult(string mrNo)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveInvestiResult(mrNo);

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        // Added by Dhananjay - 20240712
        public JsonResult GetCultureResult(string MrnNo, string strFrmDate, string strTodate)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetrieveCultureResult(MrnNo, strFrmDate, strTodate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);

        }
        public JsonResult GetInvestigationAdviceOrderStatus(string MrnNo, string FrmDate, string ToDate, string DoctCode)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                var jsonData = clonclo.RetrieveInvestigationAdviceOrderStatus(
                    MrnNo, FrmDate, ToDate, DoctCode);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        //Abhishesh || 20260805
        private static readonly HttpClient _client = new HttpClient();

        public async Task<JsonResult> PrintInvestigationOrderResult(string ResultNo, string MRNo)
        {
            try
            {
                string Msg = "";
                string url = GeneralFunction.GetAppsettingUnitWiseValue("URLLISRESULTPRINT");
                if (url == "")
                {
                    Msg = "Please Set Url Config for print";
                    return Json(Msg, JsonRequestBehavior.AllowGet);
                }
                string strUnitCD = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                string LetterHeaderYN = GeneralFunction.GetAppsettingUnitWiseValue("INVRESULTPWLH");

                object[] parameters = new object[6];
                parameters[0] = strUnitCD;
                parameters[1] = ResultNo;
                parameters[2] = LetterHeaderYN;
                parameters[3] = ""; // Show Specimen
                parameters[4] = ""; // Show Bed No
                parameters[5] = MRNo;

                var response = await ExternalCallForInvestigationPrint(url, parameters);
                if (response != null)
                {
                    object[] Result = response as object[];
                    Msg = Result[0].ToString();
                    if (Result[1] != null && Result[1].ToString() != "")
                    {
                        byte[] byteArray = Convert.FromBase64String(Result[1].ToString());
                        TempData["printdata"] = byteArray;
                    }
                }
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public async Task<object> ExternalCallForInvestigationPrint(string UrlCall, object[] Param)
        {
            object[] obj = new object[2] { string.Empty, string.Empty };
            try
            {
                string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(new { Parameters = Param });
                var content = new StringContent(jsonData, System.Text.Encoding.UTF8, "application/json");
                HttpResponseMessage response = await _client.PostAsync(UrlCall, content);
                if (response.IsSuccessStatusCode)
                {
                    string base64Pdf = await response.Content.ReadAsStringAsync();
                    base64Pdf = base64Pdf.Trim('"').Replace("\\\"", "\"");
                    obj[0] = "Success";
                    obj[1] = base64Pdf;
                }
                else
                {
                    obj[0] = response.StatusCode + " - " + response.ReasonPhrase;
                }
            }
            catch (Exception ex)
            {
                obj[0] = ex.Message;
            }
            return obj;
        }

        public ActionResult DisplayPrintInvestigationOrderResult()
        {
            byte[] printdata = TempData["printdata"] as byte[];
            return new BinaryContentResult(printdata, "application/pdf", "Investigation - Result");
        }
        //End
        //added on 25th July 2018
        public JsonResult GetTrendsTestCode(string mrNo, string FrmDate, string ToDate)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.GetTrendsTestCode(mrNo, FrmDate, ToDate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Prescription Print

        public ActionResult PrescriptionPrint()
        {
            CommonServiceClient comm = new CommonServiceClient();//Added By Rajan
            OncologyModel mdl = new OncologyModel();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            ViewBag.RemarkArray = mdl.GetRemarkList(Session["ClinicCode"].ToString().Trim(), srtUserID);//03-10-19
            ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();//03-10-19
            ViewBag.CareTypeList = comm.GetCareType().Where(p => p.Status == "A"); //Added By Rajan
            return View();
        }

        public JsonResult SaveFollowUpData(string DaySelected, string number, string MrnNo, string Transno, string RefDoctor, string patName, string SurgyAdvice,
            string RefCliniName, string patAge, string patGender, string patMobile, string AppmntDate, string AppmntTime, string strSlotNo, string prescRemarks,
            string planOfTreatmnt, string CallDoneYN, string strAdveFrAdmn, string RedirectOpt, string TBRef, string PropAdmnDT, string CareType, string SurgeryCode,
            string SurgyAdvDate, string PACAdvDate, string SurgeryAdviceType, string NotesLst, string SchemeCodes, string LevelUrg)
        {
            OncologyModel clonclo = new OncologyModel();
            var data = Json(clonclo.SaveFollowUp(DaySelected, number, MrnNo, Transno, RefDoctor, patName, SurgyAdvice, RefCliniName, patAge, patGender, patMobile,
                AppmntDate, AppmntTime, strSlotNo, prescRemarks, planOfTreatmnt, CallDoneYN, strAdveFrAdmn, RedirectOpt, TBRef, PropAdmnDT, CareType, SurgeryCode,
                SurgyAdvDate, PACAdvDate, SurgeryAdviceType, SchemeCodes, LevelUrg, NotesLst), JsonRequestBehavior.AllowGet);
            string result = data.Data.ToString();
            if (result == "Transaction successful.")
                return Json("Successful", JsonRequestBehavior.AllowGet);
            else
                return Json("UnsucessFull", JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveComplete(string Number, string DaySelected, string MrnNo, string Transno, string refDoctName, string patName, string patAge, string patGender, string patMobile, string SurgyAdvice, string RefCliniName, string AppmntDate, string AppmntTime, string strSlotNo)
        {
            DataTable dt = new DataTable();
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.SavecompleteTr(Number, DaySelected, MrnNo, Transno, refDoctName, patName, patAge, patGender, patMobile, SurgyAdvice, RefCliniName, AppmntDate, AppmntTime, strSlotNo);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult BookAppoinment(string AppmntDate, string AppmntTime, string strSlotNo, string patName, string patAge, string patGender,
            string patMobile, string mrNo, string tranno, string Number, string DaySelected, string SurgyAdvice, string RefCliniName, string refDoctName)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.BookAppoinment(AppmntDate, AppmntTime, strSlotNo, patName, patAge, patGender, patMobile, mrNo, tranno, Number, DaySelected, SurgyAdvice, RefCliniName, refDoctName);
            return Json(data, JsonRequestBehavior.AllowGet);
        }



        public JsonResult GetDoctorsByClinic(string ClinicCode)
        {
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.GetDoctorsByClinic(ClinicCode);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetDoctors(string DoctName, string Type = "")
        {
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.GetDoctors(DoctName, Type);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        //Abhishesh || 20260902
        public JsonResult GetIPDAdmDoctors(string userid)
        {
            try
            {
                OncologyEMR.ISecurServRef.SecurityClient SecClient = new OncologyEMR.ISecurServRef.SecurityClient();
                DataSet load = GeneralFunction.FillDatasetXMl(SecClient.GetUserList(userid));

                DataTable dt3 = new DataTable();
                if (load.Tables.Count > 2)
                    dt3 = load.Tables[2];

                var savedDoctCodes = (from DataRow row in dt3.Rows
                                      select ("" + row["ADMDOCTCODE"]).Trim())
                                       .Where(x => x != "")
                                       .Distinct()
                                       .ToList();
                CommonServiceClient comserv = new CommonServiceClient();
                var doctList = comserv.GetDoctLst().Where(x => x.Status == "A" && x.AdmnRight == "Y");

                if (savedDoctCodes.Count > 0)
                {
                    doctList = doctList.Where(x => savedDoctCodes.Contains(x.Value.ToString().Trim()));
                }

                var data = (from OncologyEMR.CommonSerRef.DoctorSelLstItem t in doctList
                            select new
                            {
                                DoctName = t.Text.ToString(),
                                DoctCode = t.Value.ToString()
                            }).ToArray();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(new object[0], JsonRequestBehavior.AllowGet);
            }
        }
        //End

        public JsonResult GetClinic()
        {
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.GetCliniclst();
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SetDataForPrescriptionPrint(string strTranNo)
        {
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.SetDataForPrescriptionPrint(strTranNo);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        //added on 27th July 2018e
        public JsonResult GetAppointmnentSlots(string strDate)
        {
            OncologyModel mdl = new OncologyModel();
            var jsonData = mdl.GetAppointmnentSlots(strDate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        //Added by Murali on 20/02/2024
        //******************************************************************************************
        public ActionResult GetDoctorAval(string CLINICCODE, string DOCTORCODE, string SEARCHDATE, string NumWeekday, string Searchwise)
        {
            OncologyModel AppmentNewModel = new OncologyModel();
            return Json(AppmentNewModel.GetDoctorAval(CLINICCODE, DOCTORCODE, SEARCHDATE, NumWeekday, Searchwise), JsonRequestBehavior.AllowGet);
        }
        //******************************************************************************************

        //added on 13th March 19
        public JsonResult GetSurgeries(string strSurgName)
        {
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.GetSurgeries(strSurgName);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public byte[] GetPrescriptionDataToPrint(string printdata, string TranNo, string Mrno, string printdataTop, string emailCall, string printedBy)
        {
            string htmlContent = HttpUtility.UrlDecode(printdata); string[] filepath = { }; string HeaderHtml = ""; string htmlTop = HttpUtility.UrlDecode(printdataTop);
            PdfTemplate std = new PdfTemplate();
            HtmlToPdfConverter html = new HtmlToPdfConverter();
            try
            {
                OncologyModel cloncology = new OncologyModel();
                filepath = cloncology.GetExaminationFile(TranNo, Mrno);
                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                var directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/PrescriptionImages/" + strUnit;
                string PrintWithLetterHeadYN = emailCall == "Y" ? "Y" : GeneralFunction.GetAppsettingUnitWiseValue("PWLH").ToString();
                string PrintWithLetterFooterYN = emailCall == "Y" ? "Y" : GeneralFunction.GetAppsettingUnitWiseValue("PWLF").ToString();
                foreach (string s in filepath)
                {
                    var filename = s.Split('\\').Last();

                    var strUrl1 = directory + "/" + Mrno + '/' + TranNo + '/' + filename;
                    string DefaultImagePath = strUrl1;

                    byte[] imageArray = System.IO.File.ReadAllBytes(DefaultImagePath);
                    string base64ImageRepresentation = Convert.ToBase64String(imageArray);

                    htmlContent = htmlContent.Replace(strUrl1, "data:image/jpg;base64," + base64ImageRepresentation);

                    base64ImageRepresentation = "";
                }



                HeaderHtml = "<html><body style=font-size: 12px;color:blue;font-family: cambria !important;>";
                HeaderHtml += "<div>";

                bool FlagForHeaderImg = false;
                string base64ImageRepresentation1 = "";
                if (PrintWithLetterHeadYN == "Y")
                {
                    string DefaultImagePath1 = GeneralFunction.GetImageUnitWise("LHHeader.png");
                    if (DefaultImagePath1 != "")
                    {
                        byte[] imageArray1 = System.IO.File.ReadAllBytes(DefaultImagePath1);
                        base64ImageRepresentation1 = Convert.ToBase64String(imageArray1);
                        FlagForHeaderImg = true;
                    }
                }

                if (FlagForHeaderImg)
                {
                    string PRESCRIPTIONHEADHEIGHT = GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONHEADHEIGHT").ToString();
                    string PRESCRIPTIONHEADWIDTH = GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONHEADWIDTH").ToString();
                    HeaderHtml += "<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'><tr style='width:100%;'><td><div style=''><img style='height:" + PRESCRIPTIONHEADHEIGHT + "px;width:" + PRESCRIPTIONHEADWIDTH + "px;' src='data:image/jpg;base64," + base64ImageRepresentation1 + "'/></div></td></tr></table>";
                }
                else
                {
                    string HospLogo = System.Web.HttpContext.Current.Session["HOSPLOGO"] != null ? System.Web.HttpContext.Current.Session["HOSPLOGO"].ToString() : "";
                    string HospName = System.Web.HttpContext.Current.Session["HOSPITALNAME"] != null ? System.Web.HttpContext.Current.Session["HOSPITALNAME"].ToString() : "";
                    string HospAdd = System.Web.HttpContext.Current.Session["HOSPITALADDRESS"] != null ? System.Web.HttpContext.Current.Session["HOSPITALADDRESS"].ToString() : "";

                    string base64HospLogo = "";
                    if (!string.IsNullOrEmpty(HospLogo) && System.IO.File.Exists(HospLogo))
                    {
                        byte[] hospLogoArr = System.IO.File.ReadAllBytes(HospLogo);
                        base64HospLogo = Convert.ToBase64String(hospLogoArr);
                    }
                    HeaderHtml += "<table style='border-collapse:collapse;width:100%;table-layout:fixed;font-family:cambria !important;'><tr>";
                    HeaderHtml += "<td style='width:15%;vertical-align:middle;text-align:left;padding:2px 6px;'>";
                    if (!string.IsNullOrEmpty(base64HospLogo))
                    {
                        HeaderHtml += "<img style='width:110px;height:80px;object-fit:contain;' src='data:image/jpg;base64," + base64HospLogo + "'/>";
                    }
                    HeaderHtml += "</td>";
                    HeaderHtml += "<td style='width:85%;vertical-align:middle;text-align:center;padding:2px 6px;white-space:nowrap;'>";
                    HeaderHtml += "<div style='font-size:20px;font-weight:bold;color:#0000CC;font-family:cambria !important;line-height:1.2;'>" + HospName + "</div>";
                    HeaderHtml += "<div style='font-size:14px;font-weight:bold;color:#0000CC;font-family:cambria !important;'>" + HospAdd + "</div>";
                    HeaderHtml += "</td>";
                    HeaderHtml += "</tr></table>";
                }

                HeaderHtml += "</div>";
                string PrescriptionHeaderName = GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONHEADERNAME");
                string PrescriptionHeaderNameStyle = GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONHEADERNAMESTYLE");
                if (PrescriptionHeaderName != "")
                {
                    HeaderHtml += "<hr> ";
                    HeaderHtml += "<div style='width:100%;text-align:center;'>";
                    HeaderHtml += "<label style='" + PrescriptionHeaderNameStyle + "'>" + PrescriptionHeaderName + "</label>";
                    HeaderHtml += "</div>";
                }
                HeaderHtml += "<hr>";
                HeaderHtml += htmlTop;
                HeaderHtml += "<hr> ";
                HeaderHtml += "</body></html>";
                html.PageHeaderHtml = HeaderHtml;

                string Footerhtml = "<html><body style='font-size:10px; width:100%;font-family:cambria !important;'>";
                Footerhtml += "<hr>";
                Footerhtml += "<div style='width:100%;'>";
                Footerhtml += "<div style='float:left; width:33%; text-align:left;'>";
                Footerhtml += "Printed By: " + printedBy;
                Footerhtml += "</div>";
                Footerhtml += "<div style='float:right; width:33%; text-align:right;'>";
                Footerhtml += "Printed On: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm tt");
                Footerhtml += "</div>";
                Footerhtml += "</div>";
                string base64ImageRepresentation2 = "";
                FlagForHeaderImg = false;
                if (PrintWithLetterFooterYN == "Y")
                {
                    string DefaultImagePath2 = GeneralFunction.GetImageUnitWise("LHFooter.png");
                    if (DefaultImagePath2 != "")
                    {
                        byte[] imageArray1 = System.IO.File.ReadAllBytes(DefaultImagePath2);
                        base64ImageRepresentation2 = Convert.ToBase64String(imageArray1);
                        FlagForHeaderImg = true;
                    }
                    if (FlagForHeaderImg)
                    {
                        string LetterFootHeight = GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONFOOTHEIGHT").ToString();
                        string LetterFootWidth = GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONFOOTWIDTH").ToString();
                        Footerhtml += "<div style='width:100%; margin-top:5px;'>";
                        Footerhtml += "<img style='width:100%;height:" + LetterFootHeight + "px;width:" + LetterFootWidth + "px;' src=data:image/jpg;base64," + base64ImageRepresentation2 + " />";
                        Footerhtml += "</div>";
                    }
                }

                Footerhtml += "</body></html>";
                html.PageFooterHtml = PrintWithLetterHeadYN == "N" ? "" : Footerhtml;
                //TempData["printdata"] = HeaderHtml + htmlContent + Footerhtml;
                var BottomMargin = GeneralFunction.GetAppsettingUnitWiseValue("BottomMargin").ToString();
                var TopMargin = GeneralFunction.GetAppsettingUnitWiseValue("TopMargin").ToString();

                string top = TopMargin.Contains("px") || TopMargin.Contains("cm") || TopMargin.Contains("mm") ? TopMargin : TopMargin + "px";
                string bottom = BottomMargin.Contains("px") || BottomMargin.Contains("cm") || BottomMargin.Contains("mm") ? BottomMargin : BottomMargin + "px";

                // Inject a script that runs on load, creating the correct print stylesheet dynamically
                string dynamicPrintInjector = $@"
<script>
    window.addEventListener('DOMContentLoaded', (event) => {{
        var style = document.createElement('style');
        style.type = 'text/css';
        style.innerHTML = `
            @media print {{
                @page {{
                    size: auto;
                    margin-top: {top} !important;
                    margin-bottom: {bottom} !important;
                    margin-left: 15px !important;
                    margin-right: 15px !important;
                }}
                body, html {{
                    margin: 0 !important;
                    padding: 0 !important;
                }}
            }}
        `;
        document.head.appendChild(style);
    }});
</script>";

                // Concatenate safely: leave HeaderHtml, htmlContent, and Footerhtml untouched, 
                // and append the dynamic style injector at the very end.
                TempData["printdata"] = HeaderHtml + htmlContent + Footerhtml + dynamicPrintInjector;

                html.Size = PageSize.A4;

                //var BottomMargin = GeneralFunction.GetAppsettingUnitWiseValue("BottomMargin").ToString();
                //var TopMargin = GeneralFunction.GetAppsettingUnitWiseValue("TopMargin").ToString();
                html.CustomWkHtmlArgs =
                    "--print-media-type --margin-top " + TopMargin + " --header-spacing 3 --margin-left 15 --margin-right 15 --margin-bottom " + BottomMargin + " --no-stop-slow-scripts";

                List<string> lst1 = null;
                List<string> lst2 = null;
                List<byte[]> lst3 = null;
                byte[] printarr = html.GeneratePdf(htmlContent);
                byte[] printarr1 = std.AddLabWatermark(printarr, "", lst1, lst2, lst3);
                return printarr1;
            }
            catch (Exception ex)
            {
                return (byte[])null;
            }
            finally
            {
                HeaderHtml = null; htmlContent = null; std = null; html = null;
            }
        }

        public JsonResult PrintPrescription(string printdata, string TranNo, string Mrno, string printdataTop, string printedBy)
        {
            try
            {
                printedBy = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();//priyanka 14/04/2026
                this.GetPrescriptionDataToPrint(printdata, TranNo, Mrno, printdataTop, "", printedBy);
                return Json("Success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult SendFileToSQS(string printdata, string TranNo, string Mrno, string printdataTop, string printedBy)
        {
            try
            {
                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                if (GeneralFunction.GetAppsettingUnitWiseValue("SQS_ENABLE").ToString().Trim() == "Y")
                {
                    string pathToSave = GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTION_FILE_PATH").ToString() + "/" + strUnit + "/PrescriptionFilePath/" + TranNo + ".Pdf";
                    byte[] printarr = this.GetPrescriptionDataToPrint(printdata, TranNo, Mrno, printdataTop, printedBy, "");
                    System.IO.File.WriteAllBytes(pathToSave, printarr);
                    //
                    OPServRef.OutpatientClient op = new OPServRef.OutpatientClient();
                    op.PushClinicalDataFile(Mrno, pathToSave, "prescription", DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss"), TranNo);
                    return this.Json((object)"Success", JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return this.Json((object)"Success", JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult DisplayPrintTemplate(string FormName)
        {
            try
            {
                string printdata = TempData["printdata"] as string;
                if (!string.IsNullOrEmpty(printdata))
                {
                    return Content(printdata, "text/html");
                }
                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public ActionResult SendMailAction(string printdata, string TranNo, string ToMailId, string Mrno, string printdataTop, string printedBy, string Subject = "", string DoctorCode = "")
        {
            try
            {
                string FrmMailIdStr = GeneralFunction.GetAppsettingUnitWiseValue("FrmEmailForPrescript").ToString().Trim();
                string FrmPwdStr = GeneralFunction.Decrypt(GeneralFunction.GetAppsettingUnitWiseValue("Password").ToString().Trim());
                if (FrmMailIdStr == "")
                    return (ActionResult)this.Json((object)"From Email is not provided in setup");
                byte[] prescriptionDataToPrint = Subject == "" ? this.GetPrescriptionDataToPrint(printdata, TranNo, Mrno, printdataTop, printedBy, "Y") : this.GetCertificateToPrint(printdata, DoctorCode, "Y");
                string TranNo1 = TranNo;
                string FrmName = Subject == "" ? "Consultation Prescription" : Subject;
                string PathToSave = this.Server.MapPath("~/Emails/MRNO");
                string BodyStr = "Kindly find attached herewith your " + (Subject == "" ? "consultation prescription." : Subject) + "   <br /> <br /> Regards,  <br /> " + System.Web.HttpContext.Current.Session["HOSPITALNAME"].ToString().Trim() + "  <br /> <br />  <i> Please do not reply to this mail as this is an automated mail service.</i>";
                return (ActionResult)this.Json((object)GeneralFunction.SendMailFunction(TranNo1, FrmName, PathToSave, prescriptionDataToPrint, FrmMailIdStr, FrmPwdStr, ToMailId, BodyStr));
            }
            catch (Exception ex)
            {
                return (ActionResult)this.Json((object)ex.Message);
            }
        }

        public JsonResult GetSchemaList(string PatMRNO, string Speciality, string strCompCode)
        {
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.GetSchemeCreditCompList(PatMRNO, Speciality, strCompCode);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSchemaInfo(string SchemeCode)
        {
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.GetSchemeDtls(SchemeCode);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        #endregion

        public string RedirectToDicom(string mrNo)
        {
            string strPreviousPage = Request.UrlReferrer.ToString();

            string url = GeneralFunction.GetAppsettingUnitWiseValue("LocalDicomURL").ToString();

            return url + mrNo;
        }

        public string RedirectToDicomSample(string SampleNo)
        {
            string strPreviousPage = Request.UrlReferrer.ToString();

            string url = GeneralFunction.GetAppsettingUnitWiseValue("LocalDicomURLSampleCol").ToString();

            return url + SampleNo;
        }

        #region Advice---------
        public ActionResult Advice()
        {
            return View();
        }

        public JsonResult GetFregqentMaterial()
        {
            string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveFqtAdicMaterial(strDoctorCd);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMedicineInTake()
        {
            //string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]); passed userid to fectch intake by ID Meenakhsi 01/04/2019
            var UserID = Session["gOncoUserId"].ToString();
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveMedicineIntake(UserID);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSavedMediList(string strConsNo, string strMrno, string strMedicineCode)
        {
            OncologyModel OM = new OncologyModel();
            DataSet ds = OM.GetSavedMedDet(strMrno, strConsNo, strMedicineCode);
            if (ds.Tables.Count > 0)
                return Json(JsonConvert.SerializeObject(ds.Tables[0]), JsonRequestBehavior.AllowGet);
            else
                return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetNonFregqentDrugList(string NonFreqDrug)
        {
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.RetriveNonFqtDruglist(NonFreqDrug);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RefillMedicine(string strTranNO, string strMRNo, string cimsYN)// -cimsyn added
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.RefillMedicine(strTranNO, strMRNo, cimsYN);// -cimsyn added
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        public JsonResult RefillRoutineMedicine(string strMRNo)
        {
            OncologyModel OM = new OncologyModel();
            //string strResult = OM.RefillRoutineMedicine(strMRNo);// -cimsyn added
            //return Json(strResult, JsonRequestBehavior.AllowGet);
            return Json(OM.RefillRoutineMedicine(strMRNo), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPersDiseaseList(string CIMS)
        {
            OncologyModel OM = new OncologyModel();
            object strResult = OM.GetPersDiseaseList(CIMS);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SavePersonDises(string Code, string strTranNO, string strMRNo)
        {
            try
            {
                OncologyModel OM = new OncologyModel();
                string strResult = OM.SavePersonDiseaMedicine(Code, strTranNO, strMRNo);
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult DeleteMedicine(string strMaterialCode, string strTranNo)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.DeleteMedicine(strMaterialCode, strTranNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveMedicineResequence(string strMedicineList, string strTranNO, string strMRNo)
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.SaveMediResequence(strMedicineList, strTranNO, strMRNo);
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        //added on 16th may 2018
        public JsonResult AddMedicineSetUp(string strMedicineSetUpName, string strMedicineLst, string strSetUpCode, string CIMSYN)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.AddMedicineSetUp(strMedicineSetUpName, strMedicineLst, strSetUpCode, CIMSYN), JsonRequestBehavior.AllowGet);
        }

        //added on 6th MArch 2019
        public JsonResult GetMedListBySetupCode(string strSetUpCode, string strType = "A")
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.GetMedListBySetupCode(strSetUpCode, strType), JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Advice New---------
        //public ActionResult AdviceNew(string MediName, string MediCode, string GenricName)
        //{
        //    ViewBag.MedicineName = MediName;
        //    ViewBag.MediCode = MediCode;
        //    ViewBag.GenricName = GenricName;
        //    return View();
        //}

        public ActionResult AdviceNew()
        {
            ViewBag.MedicineName = TempData["MediName"].ToString();
            ViewBag.MediCode = TempData["MediCode"].ToString();
            ViewBag.GenricName = TempData["GenricName"].ToString();
            ViewBag.GenricID = TempData["GenricID"].ToString(); //vijeta 17/4/19        
            return View();
        }

        public void CallToAdviceNew(string MediName, string MediCode, string GenricName, string GenricID) //vijeta 17/4/19
        {
            TempData["MediName"] = MediName;
            TempData["MediCode"] = MediCode;
            TempData["GenricName"] = GenricName;
            TempData["GenricID"] = GenricID;
            //return RedirectToAction("AdviceNew");
        }

        public JsonResult saveMedIntkCombintn(string strMedIntkComb, decimal TabCount)
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.saveMedIntkCombintn(strMedIntkComb, TabCount);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveAdvice(string strAdviceList, string strTranNO, string strMRNo, string MedicineCD, string Medicinename)
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.SaveMediAdvice(strAdviceList, strTranNO, strMRNo, MedicineCD, Medicinename);
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public JsonResult saveIntakeRemark(string strNewRemark)
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.saveNewINtakeRemark(strNewRemark);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult saveRoute(string strNewRoute)
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.saveNewRoute(strNewRoute);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult getRemarkList(string strClinincode)
        {
            OncologyModel OM = new OncologyModel();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();//
            object strResult = OM.GetRemarkList(strClinincode, srtUserID);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        //added on 11th oct 2018
        public JsonResult SaveRx(string strAdviceList, string strTranNO, string strMRNo)
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.SaveRx(strAdviceList, strTranNO, strMRNo);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region PreciptionImages---------
        public ActionResult PrecriptionImages()
        {
            return View();
        }

        public JsonResult Save_Picture(string imageData, string MrNo, string TranNo, List<ImageInfo> existingImages)
        {
            OncologyModel cloncology = new OncologyModel();
            object Data = cloncology.SaveExaminationPic(imageData, MrNo, TranNo, existingImages);
            return Json(Data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RetriveAllImages(string ConultCode = "")
        {
            try
            {
                OncologyModel cloncology = new OncologyModel();
                object jsonData = cloncology.RetriveImageByDoctor(ConultCode);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }



        #endregion

        //added on 4th april 2018
        #region Vital History
        public ActionResult VitalHistory()
        {
            return View();
        }

        public JsonResult GetVitalHistory(string strMRNO)
        {
            OncologyModel oncomdl = new OncologyModel();
            var data = oncomdl.GetVitalHistory(strMRNO);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

        //added on 19th april 2018
        #region Medication hiistory
        public ActionResult MedicationHistory()
        {
            OncologyModel oncomdl = new OncologyModel();
            ViewBag.DoctorList = oncomdl.GetDoctTypeList();
            return View();
        }

        public JsonResult GetMedicationtHistory(string strMrNo, string FromDate, string ToDate, string DoctCode)
        {
            OncologyModel oncomdl = new OncologyModel();
            var data = oncomdl.GetMedicationtHistory(strMrNo, FromDate, ToDate, DoctCode);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RefillRxFromMedHist(string strTranNo, string strConsultNo, string strMrno, string strpatName, string strpatAge, string strpatGender, string strTranDate, string strTranTime)
        {
            // DataTable dt = new DataTable();
            OncologyModel clonclo = new OncologyModel();
            //Session["PatPreTran"] = PrevTranNo;
            var data = clonclo.RefillRxFromMedHistMdl(strTranNo, strConsultNo, strMrno, strpatName, strpatAge, strpatGender, strTranDate, strTranTime);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region SaveNotes
        public JsonResult SaveNotes(string strNotes, string strTranNo, string strMrNo, string strNoteType, string tranMode, string TagYN, string strNoteCode)
        {
            OncologyModel oncomdl = new OncologyModel();
            var data = oncomdl.DDSaveNotes(strNotes, strTranNo, strMrNo, strNoteType, tranMode, TagYN, strNoteCode);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPatNotes(string strTranNo, string strMrNo)
        {
            OncologyModel oncomdl = new OncologyModel();
            var data = oncomdl.GetPatNotes(strTranNo, strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public ActionResult Notes()
        {
            return View();
        }
        public JsonResult GetAllNotes(string strMrNo)
        {
            OncologyModel oncomdl = new OncologyModel();
            var data = oncomdl.GetAllNotes(strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion SaveNotes

        #region Allergy
        public ActionResult Allergy(string PrntModeYN)
        {
            AllergyModel mdl = new AllergyModel();
            ViewBag.PrintMode = "N";

            if (PrntModeYN != null)
                ViewBag.PrintMode = "Y";

            return View(mdl);
        }

        public JsonResult SaveAllergyQuestionnair(AllergyModel algMdl, string mrNo, string tranNo, string doctName)
        {
            OncologyModel mdl = new OncologyModel();
            var str = mdl.SaveAllergyQuestionnair(algMdl, mrNo, tranNo, doctName);
            return Json(str, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllergies(string strMrNo, string strTranNo)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetAllergies(strMrNo, strTranNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        //added on 11th July 2018
        public JsonResult GetPatientPrevAllergies(string strMrNo)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetPatientPrevAllergies(strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

        //added on 28th June 2018
        #region SPT Reporting
        public ActionResult SPTReporting(string strAllergenList)
        {

            return View();
        }

        public JsonResult SPTReportingTran(string strAllergenList, string strTranNo, string strMrNo, string doctName)
        {

            OncologyModel mdl = new OncologyModel();
            var data = mdl.SPTReportingTran(strAllergenList, strTranNo, strMrNo, doctName);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSptReportingData(string strTranNo, string strMrNo)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetSptReportingData(strTranNo, strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        //added on 2nd July 2018
        public JsonResult GetSptReportingDataFrPrint(string strTranNo, string strMrNo)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetSptReportingDataFrPrint(strTranNo, strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        //added on 10th July 2018
        public JsonResult GetPatientPrevSPTReports(string strMRNO)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetPatientPrevSPTReports(strMRNO);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Rx Desktop
        public ActionResult RxDesktop()
        {
            OncologyModel mdl = new OncologyModel();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();//
            ViewBag.RemarkArray = mdl.GetRemarkList(Session["ClinicCode"].ToString().Trim(), srtUserID);
            ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();//kavita 08-aug
            return View();
        }

        //vijeta 8/5/19
        public JsonResult GetNonFreqDrugLstFrRxDesktop(string NonFreqDrug)
        {
            OncologyModel model = new OncologyModel();
            var data = model.GetNonFreqDrugLstFrRxDesktop(NonFreqDrug);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region RX NEW SEARCH
        public ActionResult RxNewSearch()
        {
            OncologyModel mdl = new OncologyModel();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();//
            ViewBag.RemarkArray = mdl.GetRemarkList(Session["ClinicCode"].ToString().Trim(), srtUserID);
            ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();//kavita 08-aug
            //TempData["RemarkArray"] = RemarkArray;
            //ViewData["RemarkArray"] = RemarkArray;
            return View();
        }

        public ActionResult SearchMaterial(string NonFreqDrug)//18-9-19 - chnge the string name as NonFreqDrug
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.SearchMaterial(NonFreqDrug);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        //to get materifal infor from CIMS medicine details
        public JsonResult GetMaterialInfo(string mtrlCode)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetMaterialInfo(mtrlCode);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        //to get materifal infor from HIS medicine details from phmaster
        public JsonResult GetPHMaterialInfo(string mtrlCode)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetPHMaterialInfo(mtrlCode);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CreateMaterialInfoPartial(string refCode)
        {
            OncologyModel mdl = new OncologyModel();
            //var data = mdl.GetMonographInfo(refCode);
            return View("_MaterialInfoPartial");
        }

        public ContentResult GetMonographInfo(string refCode)
        {
            OncologyModel mdl = new OncologyModel();
            string data = mdl.GetMonographInfo(refCode);
            return Content(data, "text/html");
        }

        public JsonResult GetMaterialInteraction(string[] refCodeArry)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetMaterialInteraction(refCodeArry);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetFregqentMaterialCIMS()
        {
            string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
            OncologyModel clonclo = new OncologyModel();
            var jsonData = clonclo.GetFregqentMaterialCIMS(strDoctorCd);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SaveRxCIMS(string strAdviceList, string strTranNO, string strMRNo)
        {
            OncologyModel OM = new OncologyModel();
            string strResult = OM.SaveRxCIMS(strAdviceList, strTranNO, strMRNo);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        [ChildActionOnly]
        public ActionResult GetHtmlPage(string path)
        {
            return new FilePathResult(path, "text/html");
        }
        #endregion

        //added on 2nd nov 2018
        public JsonResult GetAllHistoryCounts(string strMrNo)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetAllHistoryCounts(strMrNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        //added by vij on 19th nov 2018
        public JsonResult SearchNotAppointedPatients(string strMrName)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.SearchNotAppointedPatients(strMrName);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveSMS(string strMRNo, string smsLang = "E", string strMobile = "")
        {
            try
            {
                return Json("Setup Pending", JsonRequestBehavior.AllowGet);
                //string messg = "";
                //OncologyModel clModel = new OncologyModel();
                //if (smsLang == "E")
                //{
                //    messg = "Thank you for placing your trust in Jupiter Hospital for your health. We would request you to write a few words for our team. This greatly motivates all the care givers to strive harder to look after you and all other patients. To share feedback click http://bit.ly/2SM7tn1";
                //}
                //else if (smsLang == "H")
                //{
                //    messg = "आपके स्वास्थ्य के लिए ज्युपिटर हॉस्पिटल में अपना विश्वास रखने के लिए धन्यवाद। हम आपको हमारी टीम के लिये कुछ शब्द लिखने का अनुरोध करते है| इससे हमे आपकी व अन्य मरिजोंकी देखभाल करने की प्रेरणा मिलती है| प्रतिक्रिया साझा करने के लिए http://bit.ly/2SM7tn1 पर क्लिक करें";
                //}
                //else if (smsLang == "M")
                //{
                //    messg = "आपल्या आरोग्यासाठी ज्युपिटर हॉस्पिटलवर विश्वास ठेवल्याबद्दल धन्यवाद. आमच्या टीमसाठी आपण काही शब्द लिहावे अशी आम्ही विनंती करतो. तुमचा प्रतिसाद आम्हाला रुग्णांची चांगल्या प्रकारे काळजी घेण्यास प्रेरित करते. आपले मत देण्यासाठी http://bit.ly/2SM7tn1 वर क्लिक करा";
                //}

                //if (strMRNo != "" && messg != "" && strMobile != "")
                //{
                //    //strMobile = "SELECT PATMOBILE FROM MSTPATINDX WHERE MEDRECNO ='" + strMRNo + "'";

                //    //strCellNo = Execut (strMobile);

                //       string res =  clModel.SendSMS(strMobile, messg, "GR", smsLang);
                //        if(res =="Success")
                //            return Json("Message is Sent for Google rating on your patient's registered mobile no. (XXXXXXXX" + strMobile.Substring(strMobile.Length-2,2) + ")", JsonRequestBehavior.AllowGet);
                //        else
                //            return Json("Message not sent please check your internet connection. Or try next time.", JsonRequestBehavior.AllowGet);
                //}
                //else
                //{
                //    return Json("Contact No. is not registered.", JsonRequestBehavior.AllowGet);
                //}

                // return Json("Success", JsonRequestBehavior.AllowGet); 
            }
            catch (Exception ex)
            {
                return Json("Message not Sent. Exception occured. Try next time.", JsonRequestBehavior.AllowGet);
                throw;
            }
        }

        //added by vij on 25th june 2019
        public JsonResult SavePerMasterSetUp(string strTran, string strMrNo, string strSetUpCd, string strPatName, string strPatAge, string strPatGender, string strPatMobile)
        {
            OncologyModel oncoModel = new OncologyModel();
            var data = oncoModel.SavePerMasterSetUp(strTran, strMrNo, strSetUpCd, strPatName, strPatAge, strPatGender, strPatMobile);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        #region Signatory

        public ActionResult Signatory()
        {
            OncologyEMR.Models.SignatoryMdl signmdl = new OncologyEMR.Models.SignatoryMdl();
            ViewBag.strdoctcode = HttpContext.Session["gDoctCode"].ToString().Trim();

            return View(signmdl);
        }


        public JsonResult SaveSignatory(SignatoryMdl rnc)
        {
            OncologyEMR.Models.SignatoryMdl signmdl = new OncologyEMR.Models.SignatoryMdl();
            string status = rnc.SaveSignatory(rnc);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSignatory(string strdoctcode)
        {
            OncologyEMR.Models.SignatoryMdl signmdl = new OncologyEMR.Models.SignatoryMdl();
            string status = signmdl.GetDoctSignature(strdoctcode);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion Signaory

        #region "Add Patient"
        public ActionResult AddPatient(string FromTriage) //Added FromTriage parameter by Murali on 22/05/2024
        {
            ViewBag.strTraige = FromTriage;
            return View();
        }

        public JsonResult GETOPSEARCHDATA(string SMRNO, string SFNAME, string SMNAME, string SLNAME, string SCONTACT, string SDOB, string SOnlyComp = "N", string strEMPID = "")
        {
            try
            {
                UserControlModel UCMODE = new UserControlModel();
                object jsonData = UCMODE.GETOPSEARCHDATA(SMRNO, SFNAME, SMNAME, SLNAME, SCONTACT, SDOB, SOnlyComp, strEMPID);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult GetBillInfo(string strConsNo, string strBillNO)
        {
            try
            {
                UserControlModel UCMODE = new UserControlModel();
                object jsonData = UCMODE.GetBillInfo(strConsNo, strBillNO);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public JsonResult GetConsultSave(UserControlModel UCModel, string Gaction, string Tranno = "", string STREMPID = "", string PAYOLSTATUS = "N", string strClinicCD = "", string strTraigeYN = "")
        {
            string strMOde = Gaction;
            string strCntrCode = GeneralFunction.GetAppsettingUnitWiseValue("DeskCntrCD").ToString();
            Patient Conmodel = new Patient();
            var IPAddress = (System.Web.HttpContext.Current.Session["MchIPAddress"]).ToString();
            object status = Conmodel.saveconsultdata(UCModel, strCntrCode, IPAddress, "01", "32", strMOde, Tranno, STREMPID, strClinicCD, strTraigeYN); //Added strTraigeYN parameter by Murali on 22/05/2024
            object[] saveRecord = new object[2];

            saveRecord[0] = ((OncologyEMR.OPServRef.BL_TransactionInfo[])(status))[0].message;

            return Json(saveRecord, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult checkpatcatSetupval(string patcat)
        {
            try
            {
                string setupval = "a";
                patcat = patcat.Substring(patcat.Length - 3, 3);
                new CommonServiceClient().UsingSafe(common =>
                {
                    if (("" + patcat).Trim() == common.GetSetupValue("CREDITCOMPCATG"))
                    {
                        setupval = "COMPANY";
                    }
                });
                return Json(setupval);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult getAge(string dateOB, string Billdt = "")         //sOMNATH
        {
            string age = "";
            if ((dateOB != "undefined" && dateOB != "") || (Billdt != "undefined" && Billdt != "")) //sOMNATH
            {
                age = GeneralFunction.GetAge(dateOB);//sOMNATH
            }
            return Json(age);

        }
        #endregion "Add patient"

        #region Certificate
        public ActionResult Certificate()
        {
            CertificateMdl Mdl = new CertificateMdl();
            return View(Mdl);
        }

        public JsonResult SaveCertificate(string Act, string TranNo, string Mrno, string PatName, string IssueDate, string Subject, string Para1, string Para2, string Para3)
        {
            CertificateMdl clonclo = new CertificateMdl();
            return Json(clonclo.SaveCertificateDtls(Act, TranNo, Mrno, PatName, IssueDate, Subject, Para1, Para2, Para3), JsonRequestBehavior.AllowGet);
        }

        public JsonResult BindCertificateList(string Mrno)
        {
            CertificateMdl OM = new CertificateMdl();
            object strResult = OM.GetCertificateList(Mrno);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult PrintCertificate(string printdata, string DoctCode)
        {
            try
            {
                byte[] printarr = this.GetCertificateToPrint(printdata, DoctCode);
                TempData["PrintCertificate"] = (object)printarr;
                return this.Json((object)"Success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public byte[] GetCertificateToPrint(string printdata, string DoctCode, string EmailYN = "N")
        {
            string htmlContent = HttpUtility.UrlDecode(printdata); string HeaderHtml = "";
            PdfTemplate std = new PdfTemplate();
            HtmlToPdfConverter html = new HtmlToPdfConverter();
            try
            {
                OncologyModel cloncology = new OncologyModel();
                //Header
                FileStream fs1;
                var headerImgPath = System.Web.HttpContext.Current.Server.MapPath("~/Images/CertificateHeader.png");
                fs1 = new FileStream(headerImgPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                byte[] headerimg = new byte[fs1.Length];
                fs1.Read(headerimg, 0, Convert.ToInt32(fs1.Length));
                string Headerimg = "data:image/jpg;base64," + Convert.ToBase64String(headerimg);
                fs1.Close();
                HeaderHtml = "<html><body>";
                HeaderHtml += "<div style='width:100%'><img style='width: 100%;height:160px;' src='" + Headerimg + "'/></div>";
                HeaderHtml += "<div style='border-bottom: 1px solid #909093;border-TOP: 1px solid #909093;'>";
                HeaderHtml += "</div></body></html>";
                html.PageHeaderHtml = HeaderHtml;
                //Footer
                string DefaultImagePath2 = System.Web.HttpContext.Current.Server.MapPath("~/Images/CertificateFooter.png");
                byte[] imageArray2 = System.IO.File.ReadAllBytes(DefaultImagePath2);
                string base64ImageRepresentation2 = Convert.ToBase64String(imageArray2);
                string Footerhtml = "<html><body>";
                Footerhtml += "<hr>";
                Footerhtml += "<div style='float:left'>";
                Footerhtml += "<table style='width:100%'><tr><td><img src=data:image/jpg;base64," + base64ImageRepresentation2 + "'/></td><tr></table>";
                Footerhtml += "</div>";
                Footerhtml += "</body></html>";
                html.PageFooterHtml = Footerhtml;
                html.Size = PageSize.A4;
                var BottomMargin = GeneralFunction.GetAppsettingUnitWiseValue("BottomMargin").ToString();
                var TopMargin = GeneralFunction.GetAppsettingUnitWiseValue("TopMargin").ToString();
                html.CustomWkHtmlArgs =
                    "--print-media-type --margin-top " + TopMargin + " --header-spacing 3 --margin-left 15 --margin-right 15 --margin-bottom " + BottomMargin + " --no-stop-slow-scripts";
                //..........................................................................
                List<string> lst1 = null;
                List<string> lst2 = null;
                List<byte[]> lst3 = null;
                byte[] printarr = html.GeneratePdf(htmlContent);
                byte[] printarr1 = std.AddLabWatermark(printarr, "", lst1, lst2, lst3);
                return printarr1;
            }
            catch (Exception ex)
            {
                return (byte[])null;
            }
            finally
            {
                HeaderHtml = null; htmlContent = null; std = null; html = null;
            }
        }

        public ActionResult DisplayPrintCertifcate(string FormName)
        {
            try
            {
                MemoryStream memoryStream = new MemoryStream();
                if (TempData["PrintCertificate"] != null)
                    return (ActionResult)new BinaryContentResult(TempData["PrintCertificate"] as byte[], "application/pdf", FormName);
                else
                    return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Certificate 2
        public ActionResult Certificate2()
        {
            CertificateMdl2 Mdl = new CertificateMdl2();
            return View(Mdl);
        }

        public JsonResult SaveCertificate2(string Act, string TranNo, string Mrno, string Subject, string AttendDate, string BodyTemplate, string RestFromDate, string RestToDate, string IssueDate)
        {
            CertificateMdl2 clonclo = new CertificateMdl2();
            return Json(clonclo.SaveCertificate2Dtls(Act, TranNo, Mrno, Subject, AttendDate, BodyTemplate, RestFromDate, RestToDate, IssueDate), JsonRequestBehavior.AllowGet);
        }

        public JsonResult BindCertificateList2(string Mrno, string TranNo)
        {
            CertificateMdl2 OM = new CertificateMdl2();
            object strResult = OM.GetCertificateList2(Mrno, TranNo);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        public JsonResult BindCertificateDtls2(string Mrno)
        {
            CertificateMdl2 OM = new CertificateMdl2();
            object strResult = OM.GetCertificateNewData2(Mrno);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }

        public JsonResult PrintCertificate2(string Tempdata, string Subject, string DoctSignData, string IssueDT)
        {
            try
            {
                byte[] printarr = this.GetCertificateToPrint2(Tempdata, Subject, DoctSignData, IssueDT);
                TempData["PrintCertificate"] = (object)printarr;
                return this.Json((object)"Success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public byte[] GetCertificateToPrint2(string Tempdata, string Subject, string DoctSignData, string IssueDT)
        {
            string htmlContent = ""; string HeaderHtml = "";
            PdfTemplate std = new PdfTemplate();
            HtmlToPdfConverter html = new HtmlToPdfConverter();
            try
            {
                OncologyModel cloncology = new OncologyModel();
                //Header
                FileStream fs1;
                var headerImgPath = System.Web.HttpContext.Current.Server.MapPath("~/Images/CertificateHeader2.png");
                fs1 = new FileStream(headerImgPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                byte[] headerimg = new byte[fs1.Length];
                fs1.Read(headerimg, 0, Convert.ToInt32(fs1.Length));
                string Headerimg = "data:image/jpg;base64," + Convert.ToBase64String(headerimg);
                fs1.Close();
                HeaderHtml = "<html><body>";
                HeaderHtml += "<div style='width:100%'><img style='width: 100%;' src='" + Headerimg + "'/></div>";
                HeaderHtml += "<div style='border-bottom: 1px solid #909093;border-TOP: 1px solid #909093;'>";
                HeaderHtml += "</div></body></html>";
                html.PageHeaderHtml = HeaderHtml;
                //Content
                htmlContent = "<html><body><style>.IssDate{width:100%;float:left} .Header{text-align:center;font-size:30px;font-weight: bold;margin-top:15px;display: inline-block;width:100%} .Paragraph{line-height:1.5;text-align: justify;font-size:18px;display: inline-block;margin-top:20px}</style>";
                htmlContent += "<div class='Header'>" + Subject + "</div>";
                htmlContent += "<div style='width:100%;float:right;font-size:18px;display: inline-block;margin-top:20px;text-align: end;'>Date : " + IssueDT + "</div>";
                htmlContent += "<div class='Paragraph'>" + Tempdata.Replace("\n", "<br>").Replace("\t", "&emsp;&emsp;") + "</div>";
                htmlContent += HttpUtility.UrlDecode(DoctSignData) + "</body></html>";
                //Footer
                string DefaultImagePath2 = System.Web.HttpContext.Current.Server.MapPath("~/Images/CertificateFooter2.png");
                byte[] imageArray2 = System.IO.File.ReadAllBytes(DefaultImagePath2);
                string base64ImageRepresentation2 = Convert.ToBase64String(imageArray2);
                string Footerhtml = "<html><body>";
                Footerhtml += "<hr>";
                Footerhtml += "<div style='float:left'>";
                Footerhtml += "<table style='width:100%'><tr><td><img src=data:image/jpg;base64," + base64ImageRepresentation2 + "'/></td><tr></table>";
                Footerhtml += "</div>";
                Footerhtml += "</body></html>";
                html.PageFooterHtml = Footerhtml;
                html.Size = PageSize.A4;
                var BottomMargin = GeneralFunction.GetAppsettingUnitWiseValue("BottomMargin").ToString();
                var TopMargin = GeneralFunction.GetAppsettingUnitWiseValue("CertificateTopMargin").ToString();
                html.CustomWkHtmlArgs =
                    "--print-media-type --margin-top " + TopMargin + " --header-spacing 3 --margin-left 15 --margin-right 15 --margin-bottom " + BottomMargin + " --no-stop-slow-scripts";
                //..........................................................................
                List<string> lst1 = null;
                List<string> lst2 = null;
                List<byte[]> lst3 = null;
                byte[] printarr = html.GeneratePdf(htmlContent);
                byte[] printarr1 = std.AddLabWatermark(printarr, "", lst1, lst2, lst3);
                return printarr1;
            }
            catch (Exception ex)
            {
                return (byte[])null;
            }
            finally
            {
                HeaderHtml = null; htmlContent = null; std = null; html = null;
            }
        }

        public ActionResult DisplayPrintCertifcate2(string FormName)
        {
            try
            {
                MemoryStream memoryStream = new MemoryStream();
                if (TempData["PrintCertificate"] != null)
                    return (ActionResult)new BinaryContentResult(TempData["PrintCertificate"] as byte[], "application/pdf", FormName);
                else
                    return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        //added by priyanka on 25/01/2025
        #region ICD Diagnosis SetUp List
        public JsonResult GetNonFregqentICDDiagnosisList(string NonFreqICD)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                var jsonData = clonclo.GetNonFrequentICDDiagnosisListdt(NonFreqICD);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult GetICDDiagnoListBySetupCode(string strSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.GetICDDiagnoListBySetupCode(strSetUpCode), JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddICDDiagnosisSetUp(string strICDDiagnSetUpName, string strICDDiagnLst, string strICDDiagNameLst, string strICDDiagSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.AddICDDiagnosisSetUp(strICDDiagnSetUpName, strICDDiagnLst, strICDDiagNameLst, strICDDiagSetUpCode), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPersICDDiagnoList()
        {
            try
            {
                OncologyModel OM = new OncologyModel();
                object strResult = OM.GetPersICDDiagnoList();
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult SavePersonICDDiagnosis(string Code, string strTranNO, string strMRNo)
        {
            try
            {
                OncologyModel OM = new OncologyModel();
                string strResult = OM.SavePerICDDiagnosis(Code, strTranNO, strMRNo);
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
         
        #endregion

        //Added By Priyanka on 14/02/2025
        #region Diagnosis Setup
        public JsonResult GetNonFregqentDiagnosisListForDiagSetup(string NonFreqDiagno, string strClinincode)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                var jsonData = clonclo.GetNonFregqentDiagnoListForSetup(NonFreqDiagno, strClinincode);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult GetPersDiagnoList()
        {
            try
            {
                OncologyModel OM = new OncologyModel();
                object strResult = OM.GetPersDiagnoList();
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult GetDiagnosisListBySetupCode(string strSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.GetDiagnosisListBySetupCode(strSetUpCode), JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddDiagnosisSetUp(string strDiagnSetUpName, string strDiagnLst, string strDiagNameLst, string strDiagSetUpCode)
        {
            OncologyModel clonclo = new OncologyModel();
            return Json(clonclo.AddDiagnosisSetUp(strDiagnSetUpName, strDiagnLst, strDiagNameLst, strDiagSetUpCode), JsonRequestBehavior.AllowGet);
        }

        public JsonResult SavePersonDiagnosisSetup(string Code, string strTranNO, string strMRNo)
        {
            try
            {
                OncologyModel OM = new OncologyModel();
                string strResult = OM.SavePersonDiagnosisSetup(Code, strTranNO, strMRNo);
                return Json(strResult, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        #region "Planning"

        public ActionResult LoadPlanningView(string PatMRNO)
        {
            var model = new OncologyEMR.Models.Planning();
            model.FillCombo(model, PatMRNO);
            model.TempGaction = "N";
            return PartialView("PlanningView", model);
        }

        public JsonResult GetProtocol(string id)
        {
            CommonServiceClient comser = new CommonServiceClient();
            Planning mdl = new Planning();
            var visit = mdl.GetProtocol(id);
            return Json(visit, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMedOncoSave(string ConsultNo, string MRNO, string EntryDate, string Diagnosis, string T, string N, string M, string ChemoCourse,
            string HPReport, string PrevTreatment, string PreChemoFindings, string Height, string Weight, string BSA, string PerformStatus, string M2, string Regime, string ChemoName,
            string Protocol, string ToRepeat, string TreatmentPlan, string TotalCycles, string TreatmentModification, string ICDYN, string CancelRemarks, string Scheme,
            string SchemeOth, string PatCatg, string gact, string TranNo, string Duration, string HourorDay, string ReportRemark, string gridChemo, string TreatmentDone, string ConclusionStatus, string TreatmentDate, string SchemeCodes,
            string ChemoStartDate)
        {
            Planning mdl = new Planning();
            var UserID = Session["gOncoUserId"].ToString();
            var MchIPAddress = string.IsNullOrEmpty(Session["MchIPAddress"].ToString()) ? "" : Session["MchIPAddress"].ToString();
            var ModuleIDGlobal = string.IsNullOrEmpty(Session["ModuleIDGlobal"].ToString()) ? "" : Session["ModuleIDGlobal"].ToString();
            var doctorCode = System.Web.HttpContext.Current.Session["gDoctCode"].ToString();
            object status = mdl.MedOncoSave(MchIPAddress, ModuleIDGlobal, UserID, ConsultNo, MRNO, EntryDate, Diagnosis, T, N, M, ChemoCourse, HPReport, PrevTreatment, PreChemoFindings,
               Height, Weight, BSA, PerformStatus, M2, Regime, ChemoName, Protocol, ToRepeat, TreatmentPlan, TotalCycles, TreatmentModification, ICDYN,
               CancelRemarks, Scheme, SchemeOth, PatCatg, doctorCode, gact, TranNo, Duration, HourorDay, ReportRemark, gridChemo, TreatmentDone, ConclusionStatus, TreatmentDate, SchemeCodes, ChemoStartDate);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public string GetChemoMedicationMasterList(string strProtocol, string strType)
        {
            Planning mdl = new Planning();
            return mdl.GetChemoPrMasterList(strProtocol, strType);

        }

        public JsonResult GetMedOncoData(string strConsultNo, string TranNo, string MrNo)
        {
            try
            {
                Planning mdl = new Planning();
                var response = mdl.GetMedOncoDataMdl(strConsultNo, MrNo, TranNo);
                return Json(response, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public JsonResult GetchemoSMedication(string MRNo, string PlanNo, string CycleNo)
        {
            try
            {
                Planning mdl = new Planning();
                var response = mdl.GetChemoSMedication(MRNo, PlanNo, CycleNo);
                return Json(response, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult PrintChemoPlanning(string MRNo, string ConsultNo, string PlanNo, string CycleNo, string StrProtocole, string LetterHeaderYN = "")
        {
            try
            {
                Planning Mdl = new Planning();
                byte[] printarr = Mdl.PrintChemoPlan(MRNo, ConsultNo, PlanNo, CycleNo, StrProtocole, LetterHeaderYN);
                Session["chemo_pdf"] = printarr;
                return this.Json("Success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ActionResult DisplayPrintChemoPlan()
        {
            MemoryStream outmeomery = new MemoryStream();
            byte[] printdata = Session["chemo_pdf"] as byte[];
            return new BinaryContentResult(printdata, "application/pdf", "Chemo Planning");
        }

        public ActionResult DisplayChemoPrMaster()
        {
            MemoryStream outmeomery = new MemoryStream();
            byte[] printdata = TempData["printdata"] as byte[];
            return new BinaryContentResult(printdata, "application/pdf", "Chemo Protocol Master List");
        }

        #endregion "Planning"

        #region Calender

        public ActionResult LoadCalenderView()
        {
            return PartialView("CalendarPartialView", null);
        }

        public JsonResult GetScheduleCalenderDtls(string FDate, string TDate)
        {
            CalenderMdl mdl = new CalenderMdl();
            var response = mdl.GetCalenderData(FDate, TDate);
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetScheduleUnallocatedPatDtls(string FDate, string TDate, string PatName) // PatName Added By Abhsihesh || 20260820
        {
            CalenderMdl mdl = new CalenderMdl();
            var response = mdl.GetCalenderDataUnallocated(FDate, TDate, PatName);// PatName Added By Abhsihesh || 20260820
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAdvPatScheduleList(string FDate)
        {
            CalenderMdl mdl = new CalenderMdl();
            var response = mdl.GetAdvPatListData(FDate);
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveScheduleCalender(string Calender)
        {
            CalenderMdl mdl = new CalenderMdl();
            var response = mdl.TranCalenderData(Calender);
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveApprovelList(string ApprovelList, string Remarks, string ApprovalStatus)
        {
            CalenderMdl mdl = new CalenderMdl();
            var response = mdl.TranAdvListApprovData(ApprovelList, Remarks, ApprovalStatus);
            return Json(response, JsonRequestBehavior.AllowGet);
        }

        #endregion Calender

        #region PAC
        //public ActionResult PAC(string PatMRNO = "" , string PatTRANNO = "")
        //{
        //    PACMdl Mdl = new PACMdl();
        //    Session["FromClinic"] = "";
        //    Session["PageId"] = "PAC";
        //    Mdl.MRNO = PatMRNO;
        //    Mdl.TRANNO = PatTRANNO;
        //    Mdl.BindPACDtls(Mdl);
        //    ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();
        //    OncologyModel mdl = new OncologyModel();
        //    string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
        //    ViewBag.RemarkArray = mdl.GetRemarkList("", srtUserID);
        //    return View(Mdl);
        //}

        public JsonResult SetPACDetails(string MRNO, string AdvConsultNo)
        {
            TempData["PACMRNO"] = MRNO;
            TempData["PACADVCONSLTNO"] = AdvConsultNo;
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetInvestList(string TestCode)
        {
            PACMdl Mdl = new PACMdl();
            var Result = Mdl.GetInvstListData(TestCode);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SavePAC(PACMdl SMdl)
        {
            PACMdl Mdl = new PACMdl();
            var Result = Mdl.SavepreAnaestCheckup(SMdl);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult PrintPACDtls(string TranNo, string MRNo, string SpecialityYN, string PACInvstResultYN, PACMdl mdldata, string AllOptionYN = "N", string IPNo = "", string LetterHeaderYN = "", string PrintPrvw = "")//priyanka 08/06/2026
        {
            try
            {
                PACMdl Mdl = new PACMdl();
                string PrintedBy = ("" + System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString();
                List<byte[]> pdfByteArrays = Mdl.PrintPACRpt(TranNo, MRNo, SpecialityYN, PACInvstResultYN, mdldata, AllOptionYN, PrintedBy, IPNo, LetterHeaderYN, PrintPrvw);
                byte[] concatenatedPdf = PdfTemplate.concatAndAddContent(pdfByteArrays);
                TempData["printdata"] = concatenatedPdf;
                return this.Json("Success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult PrintPACReferrence(PACMdl PMdl) //priyanka 20/02/2026
        {
            try
            {
                PACMdl Mdl = new PACMdl();
                List<byte[]> pdfByteArrays = new List<byte[]>();
                DataTable PACSPECREFINFO = new DataTable();
                PACSPECREFINFO = JsonConvert.DeserializeObject<DataTable>(PMdl.SpecialityRefData);
                //byte[] printarr = Mdl.PrintSpecialityRefRpt(PACSPECREFINFO);
                byte[] printarr = Mdl.PrintSpecialityRefRpt(PACSPECREFINFO, PMdl.TRANNO, PMdl.MRNO);
                TempData["printdata"] = printarr;
                return this.Json("Success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ActionResult DisplayPrintPAC()
        {
            MemoryStream outmeomery = new MemoryStream();
            byte[] printdata = TempData["printdata"] as byte[];
            return new BinaryContentResult(printdata, "application/pdf", "PAC");
         }

        public JsonResult PrintPACResult(string Mrno, string TranNo)
        {
            try
            {
                PACMdl Mdl = new PACMdl();
                byte[] printarr = Mdl.PrintResultRpt(Mrno, TranNo);
                TempData["printdata"] = printarr;
                if (printarr == null || printarr.Length == 0) //priyanka 03/04/2026
                {
                    return Json(new { status = "fail", message = "No data to print" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { status = "Success", message = "Report generated" }, JsonRequestBehavior.AllowGet);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ActionResult DisplayPrintPACResult()
        {
            MemoryStream outmeomery = new MemoryStream();
            byte[] printdata = TempData["printdata"] as byte[];
            return new BinaryContentResult(printdata, "application/pdf", "PAC - Result");
        }

        public JsonResult GetMedicineRXList(string DrugName)
        {
            try
            {
                string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                PACMdl Mdl = new PACMdl();
                return Json(Mdl.GetMedicineList(DrugName), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetPACLogInfoList(string TranNo)
        {
            CommonServiceClient comserv = new CommonServiceClient();
            DataSet dsgetLogInfo = new DataSet();
            dsgetLogInfo = comserv.GetIPLogInfo(TranNo);
            var DoctLst = OncoCli.GetDoctLst("", "D");
            var jsonData = (from DataRow row in dsgetLogInfo.Tables[0].Rows
                            where row["TABLNAME"].ToString().Trim() != "OTBOOKREQHD,OTBOOKREQDT"  // Pournima
                            select new
                            {
                                USERID = row["USERID"].ToString().Split('(')[0].Trim() != "" ?
                                (
                                   DoctLst.Where(x => x.Value == row["USERID"].ToString().Split('(')[0].Trim()).Count() > 0 ?
                                   DoctLst.Where(x => x.Value == row["USERID"].ToString().Split('(')[0].Trim()).FirstOrDefault().Text :
                                   GeneralFunction.GetUserName(row["USERID"].ToString().Split('(')[0].Trim())
                                )
                                : "", //priyanka 20/05/2026
                                ACTION = GeneralFunction.GetAction(Convert.ToString(row["ACTION"])),
                                LOGDATE = GeneralFunction.GetDate(Convert.ToString(row["LOGDATE"])),
                                LOGTIME = row["LOGTIME"].ToString(),
                            }).ToArray();

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetPACHistory(string Mrno, string FromDate, string ToDate)
        {
            PACMdl Mdl = new PACMdl();
            var Result = Mdl.GetPACHistList(Mrno, FromDate, ToDate);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetPACVisit(PACMdl mdls)
        {
            PACMdl mdl = new PACMdl();
            var result = mdl.GetVisitPACList(mdls);
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        #endregion
        // Added By Roshan CIMS 20251012
        #region CIMS
        public JsonResult GetDrugInformation(string DrugCode)
        {
            try
            {
                CIMSModel mdl = new CIMSModel();
                object jsondata = mdl.GetDrugInformation(DrugCode);
                return Json(jsondata, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                using (MvcApplication mvc = new MvcApplication())
                {
                    mvc.WriteErrorLog(ex.Message);
                }
                return Json("0", JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetDrugInteration(string DrugCodes, string Type, string Mrno, string Ipno)
        {
            try
            {
                CIMSModel mdl = new CIMSModel();
                object jsondata = mdl.GetDrugInteration(DrugCodes, Type, Mrno, Ipno);
                return Json(jsondata, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                using (MvcApplication mvc = new MvcApplication())
                {
                    mvc.WriteErrorLog(ex.Message);
                }
                return Json("0", JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetDrugDuplicate(string DrugCodes, string Type)
        {
            try
            {
                CIMSModel mdl = new CIMSModel();
                object jsondata = mdl.GetDrugDuplicate(DrugCodes, Type);
                return Json(jsondata, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                using (MvcApplication mvc = new MvcApplication())
                {
                    mvc.WriteErrorLog(ex.Message);
                }
                return Json("0", JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetDrugAllergy(string DrugCodes, string Type)
        {
            try
            {
                CIMSModel mdl = new CIMSModel();
                object jsondata = mdl.GetDrugAllergy(DrugCodes, Type);
                return Json(jsondata, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                using (MvcApplication mvc = new MvcApplication())
                {
                    mvc.WriteErrorLog(ex.Message);
                }
                return Json("0", JsonRequestBehavior.AllowGet);
            }
        }
        #endregion CIMS
        // End By Roshan CIMS 20251012

        #region "Surgical History"
        public ActionResult SurgicalHistory()
        {
            SurgicalHist mdl = new SurgicalHist();
            return View();
        }

        public JsonResult SaveSurgicalHistory(string MRNO, string UniqueId, string SurgeonDoctorName, string SurgeryDate, string SurgeryName, string SurgeryNotes, string gact)
        {
            try
            {
                SurgicalHist mdl = new SurgicalHist();
                object jsonData = mdl.SaveSurgicalHistory(MRNO, UniqueId, SurgeonDoctorName, SurgeryDate, SurgeryName, SurgeryNotes, gact);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public JsonResult GetSurgicalHistoryData(string strMrNo)
        {

            SurgicalHist mdl = new SurgicalHist();
            var jsonData = mdl.GetSurgicalHistoryData(strMrNo);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        #endregion

        //Added by Murali on 09/03/2022 for Treatment Plan Completed Status Report
        //******************************************************************************
        #region PlanCompletedStatus
        public ActionResult PlanCompletedStatus()
        {
            PlanCompletedStatus pt = new PlanCompletedStatus();
            return View(pt);
        }
        public ActionResult PrintPlanCompleteStatusLst(string data, string frmdate, string todate)
        {
            try
            {
                PlanCompletedStatus refReq = new PlanCompletedStatus();
                DataSet AllData = refReq.PrintPlanCompleteStatusLst(data, frmdate, todate);
                string reportPath = Path.Combine(Server.MapPath("~/Reports"), "rptPatTrackDTWiseLst.rpt");
                CrystalReportPdfResult cry = new CrystalReportPdfResult();
                byte[] printarr = cry.CrystalReportPdf(reportPath, AllData);
                TempData["printdata"] = printarr;
                return Json("sucess");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ActionResult DisplayPlanCompleteLst()
        {
            MemoryStream outmeomery = new MemoryStream();
            byte[] printdata = TempData["printdata"] as byte[];
            return new BinaryContentResult(printdata, "application/pdf", "Patient Tracking Datewise List");
        }
        public ActionResult ExcelBindPlanCompleteLst(string data, string FrmDate, string ToDate, string searchCriteria)
        {
            try
            {
                PlanCompletedStatus PatTrack = new PlanCompletedStatus();
                TempData["printdata"] = PatTrack.ExcelBindPlanCompleteLst(data, FrmDate, ToDate, searchCriteria);
                return Json("success");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult ExcelResultPlanCompleteLst()
        {
            try
            {
                MemoryStream outmeomery = new MemoryStream();
                string printdata = TempData["printdata"] as string;
                return new OncologyEMR.DataClass.ExcelResult
                {
                    FileName = "Treatment Plan Completion Status List.xls",
                    XMLStream = printdata
                };
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public JsonResult GetPlanCompletedStatus(string MRNumber, string FromDT, string ToDT, string PatName, string PlanNumber)
        {
            PlanCompletedStatus PlanComplete = new PlanCompletedStatus();
            CommonServiceClient COMCLIENT = new CommonServiceClient();
            //    FromDT = COMCLIENT.GetServerDate(); ToDT = COMCLIENT.GetServerDate();
            object jsonData = PlanComplete.GetPlanCompletedStatus(MRNumber, FromDT, ToDT, PatName, PlanNumber);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        #endregion PlanCompletedStatus
        //******************************************************************************
        #region TumorBoardSchedule
        public ActionResult TumorBoardSchedule()
        {
            TumorBoardSchedule tm = new TumorBoardSchedule();
            return View();
        }
        //Calender View
        public ActionResult TumorBoardScheduleCalender()
        {
            return PartialView("CalendarPartialTumorSchedule", null);
        }
        public JsonResult GetDoctorsMeetingDet(string strDoctCode, string type)
        {
            TumorBoardSchedule PlanComplete = new TumorBoardSchedule();
            CommonServiceClient COMCLIENT = new CommonServiceClient();
            //    FromDT = COMCLIENT.GetServerDate(); ToDT = COMCLIENT.GetServerDate();
            object jsonData = PlanComplete.GetDoctorsMeetingDet(strDoctCode, type);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public ActionResult PrintTumorBrdDisc(string MrNo, string TranNo)
        {
            try
            {
                TumorBoardSchedule refReq = new TumorBoardSchedule();
                DataSet AllData = refReq.PrintTumorBrdDisc(MrNo, TranNo);
                if (AllData.Tables.Count > 0)
                {
                    string reportPath = Path.Combine(Server.MapPath("~/Report"), "rptTumorBoardDisc.rpt");
                    CrystalReportPdfResult cry = new CrystalReportPdfResult();
                    byte[] printarr = cry.CrystalReportPdf(reportPath, AllData);

                    TempData["printdata"] = printarr;
                    return Json("sucess");
                }
                else
                    return Json("No Data to Print.");

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public ActionResult PrintTumorTransactionAction()
        {
            try
            {
                MemoryStream outmeomery = new MemoryStream();
                byte[] printdata = TempData["printdata"] as byte[];
                return new BinaryContentResult(printdata, "application/pdf", "Tumor Da");
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }
        //notification
        public JsonResult PatTumorTreatmentDet(string strMrNo)
        {
            try
            {
                OncologyModel clonclo = new OncologyModel();
                //string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                return Json(clonclo.PatTumorTreatmentDet(strMrNo), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }

        }
        #endregion TumorBoardSchedule

         #region RefferalNotes
        public JsonResult GetReferralNotesList()
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetReferralNotesLst();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPatReferralNotes(string TranNo, string Mrno)
        {
            OncologyModel mdl = new OncologyModel();
            var data = mdl.GetPatReferralNotes(TranNo, Mrno);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
         #endregion 
        
        #region GetPatImage
        public JsonResult getphoto(string mrno)
        {
            byte[] imgbyte = null;
            new CommonServiceClient().UsingSafe(comser =>
            {
                imgbyte = comser.GetPatientPhoto(mrno);
            });
            System.Drawing.Image returnImage = null;
            if (imgbyte == null ? false : (imgbyte.Length > 0))
            {
                oldbyteimage = imgbyte;
                TempData["oldbyteimage"] = imgbyte; 
                string imreBase64Data = Convert.ToBase64String(oldbyteimage);
                string imgDataURL = string.Format("data:image/png;base64,{0}", imreBase64Data);
                return Json(imgDataURL);
            }
            else { return Json(""); }
        }
        #endregion

        //Pournima 27th Oct 2025
        #region OutsideInvestigation
        public ActionResult OutsideInvestigation(string PatMRNO = "", string PatTRANNO = "")
        {
            OutsideInvstMdl Mdl = new OutsideInvstMdl();
            Mdl.MRNO = PatMRNO;
            Mdl.TRANNO = PatTRANNO;
            Mdl.BindPACDtls(Mdl);
            ViewBag.DoctorList = Mdl.GetDoctTypeList();
            return View(Mdl);
        }
        public JsonResult GetOutInvestList(string TestCode)
        {
            OutsideInvstMdl Mdl = new OutsideInvstMdl();
            var Result = Mdl.GetInvstListData(TestCode);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveOutsideInvstg(OutsideInvstMdl SMdl)
        {
            OutsideInvstMdl Mdl = new OutsideInvstMdl();
            var Result = Mdl.SaveOutsideInvstg(SMdl);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetOutsideInvestigationResult(string strTranNo)
        {
            OutsideInvstMdl OM = new OutsideInvstMdl();
            object strResult = OM.GetOutsideInvestigationResult(strTranNo);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        #endregion

        //Priyanka on 13/11/2025
        #region Scheme Approval Status
        public ActionResult SchemeApprovalStatus()
        {
            SchemeApprovalStatus sa = new SchemeApprovalStatus();
            return View(sa);
        }
        public JsonResult GetSchemeApprovalStatusDetails(string FromDT, string ToDT, string strPreAuthStatus)
        {
            SchemeApprovalStatus SchemeApproval = new SchemeApprovalStatus();
            OncologyEMRClient oncoemr = new OncologyEMRClient();
            string strDoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            object jsonData = SchemeApproval.GetSchemeApprovalStatDetails(FromDT, ToDT, strPreAuthStatus, strDoctorCode);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ExcelBindSchemeApprovalStatusLst(string data, string FrmDate, string ToDate, string searchCriteria)
        {
            try
            {
                SchemeApprovalStatus schemeexceldt = new SchemeApprovalStatus();
                TempData["printdata"] = schemeexceldt.ExcelBindSchemeApprovalStatLst(data, FrmDate, ToDate, searchCriteria);
                return Json("success");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult DisplayExcelSchemeApprovalStatusLst()
        {
            try
            {
                MemoryStream outmeomery = new MemoryStream();
                string printdata = TempData["printdata"] as string;
                return new OncologyEMR.DataClass.ExcelResult
                {
                    FileName = "Scheme Approval Status List.xls",
                    XMLStream = printdata
                };
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Patients Clinical details
        public ActionResult PatientClinicDetails()
        {
            OncologyModel oncomdl = new OncologyModel();
            ViewBag.DoctorList = oncomdl.GetDoctTypeList();
            return View();
        }

        public JsonResult GetFractionsStatus(string Mrno)
        {
            OncologyModel clo = new OncologyModel();
            object jsonData = clo.GetFractionsStatus(Mrno);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPerviousPCDet(string Mrno)
        {
            OncologyModel clo = new OncologyModel();
            object status = clo.GetPerviousPCDet(Mrno);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAdmissionList(string Mrno, string FromDate, string ToDate)
        {
            OncologyModel clo = new OncologyModel();
            object jsonData = clo.GetAdmLst(Mrno, FromDate, ToDate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetNotesList(string strIPNo, string AdmorFromDate, string CurorToDate, string Doctor, string FromTime, string ToTime)
        {
            OncologyModel clo = new OncologyModel();
            object jsonData = clo.GetNotesLst(strIPNo, AdmorFromDate, CurorToDate, Doctor, FromTime, ToTime);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDischargeList(string Mrno, string FromDate, string ToDate)
        {
            OncologyModel clo = new OncologyModel();
            object jsonData = clo.GetDischargeLst(Mrno, FromDate, ToDate);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetDischargeDetails(string DisSummryNo, string Mrno, string IPNo)
        {
            OncologyModel clo = new OncologyModel();
            string jsonData = clo.GetDischargeDtls(DisSummryNo, Mrno, IPNo);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult TumorBoardPatListBinding(string sfrmdate, string stodate, string spatname, string smrno, string RefTumor, string RefTumorStatus)
        {
            OncologyModel clo = new OncologyModel();
            object RadOncoListData = clo.TumorBoardPatLstBindingData(sfrmdate, stodate, spatname, smrno, RefTumor, RefTumorStatus);

            return Json(RadOncoListData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetTumorBoardDetails(string MrNo, string TranNo)
        {
            try
            {
                OncologyModel model = new OncologyModel();
                var data = model.GetCombinedTumorBoardDetails(MrNo, TranNo);

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = true, message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion


        #region Clinical Entry 
        public string SavePatientConsltStatus(string ConsNo, string markStatus)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = Session["gOncoUserId"].ToString();
                Result = Oncoser.MarkPatientProgress(ConsNo, markStatus, User);  //SavePatNote(Type, TransactNo, MRNO, "", "", "", 0, "", "N");
                return Result;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        #endregion
    }
}

