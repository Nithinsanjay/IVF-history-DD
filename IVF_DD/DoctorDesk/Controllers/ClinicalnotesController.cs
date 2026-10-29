using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OncologyEMR.Models;
using OncologyEMR.Oncology;
using OncologyEMR.DataClass;
using System.IO;
using System.Data;
using System.Xml;
using OncologyEMR.Pdf;
using OncologyEMR.App_Start;
//using OncologyEMR.CommonSerRef;
using Newtonsoft.Json;
using OncologyEMR.CommonSerRef;

namespace OncologyEMR.Controllers
{
    [SessionExpiry]
    public class ClinicalnotesController : Controller
    {
        //
        // GET: /Clinicalnotes/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ClinicEntry(string isVitalsCompleted = "")
        {

            Session["FromClinic"] = "Y"; // added by vijeta on 5th april 2018
            DataTable dtEmpty = new DataTable();
            formrights Frights = new formrights();
            if (("" + System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString().Trim() != "")
                Frights.GetLoginRights(System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().ToUpper());
            else
                System.Web.HttpContext.Current.Session.Add("FRMRIGHTS", dtEmpty);
            ViewBag.RightUnitList = GeneralFunction.GetUnitRightsList();
            ViewBag.IsVitalsCompleted = isVitalsCompleted;//priyanka 12/03/2026
            return View();
        }


        public JsonResult GetDoctors()
        {
            Clinicalnotes cloncology = new Clinicalnotes();
            var jsonData = cloncology.GetDoctors();
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetRefDoctors()
        {
            Clinicalnotes cloncology = new Clinicalnotes();
            var jsonData = cloncology.GetRefDoctors();
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetPatientList(string strClinicCode,string strdoctCode, string dayType, int CustomeDate = 0, string Type = "")
        {
            try
            {
                //Clinicalnotes clonco = new Clinicalnotes();
                PatientSearch clonco = new PatientSearch();
                //string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);
                // Session["ClinicCode"] = strClinicCode;
                return Json(clonco.GetPatientListForClinicalNotes(strClinicCode,strdoctCode, dayType,CustomeDate,Type), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        #region Vitals
        public ActionResult ClinicalVitals()
        {
            return View();
        }
        public JsonResult SaveVitals(string strWeight, string strHeight, string strTemp, string strPulse, string strBlood, string strResp, string strOther, 
            string strPrevWt, string strTranno, string strMrNo, string strWalkngYN, string strDietYN, string strMedicineYN, string strWalkDur, string strWalkDurType,
            string strspo2, string strBMI, string strHeadCircf, string strPEFR, string strTechnique, string strCompliance, string strBSA,
            string strRBS, string strkarkyscore, string strEcogScore, string strPulseCond
            , string strIBW, string strBWPerc, string strWaistCircum, string strHip, string strWHR, string CmbHeight, string CmbWeight, string strProxyVisit) //Added by Murali on 25/04/2024    )                                
        {
            DataTable dt = new DataTable();
            OncologyModel cloncology = new OncologyModel();
            var jsonData = cloncology.SaveVitalsTr(strWeight, strHeight, strTemp, strPulse, strBlood, strResp, strOther, strPrevWt, strTranno, strMrNo,
                strWalkngYN, strDietYN, strMedicineYN, strWalkDur, strWalkDurType, strspo2, strBMI, strHeadCircf, strPEFR, strTechnique, strCompliance, "", "", "", "", strBSA,
                strRBS, strkarkyscore, strEcogScore, strPulseCond, strIBW, strBWPerc, strWaistCircum, strHip, strWHR,
                "", "", "", "", "", "", "", "", CmbHeight, CmbWeight, strProxyVisit);
            //  Session["ComplaintsList"] = strComplaints;
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SetDataForVitals(string strTranNo, string Type)
        {
            //Clinicalnotes cloncology = new Clinicalnotes();
            OncologyModel cloncology = new OncologyModel();
            var data = cloncology.SetDataForVitals(strTranNo, Type);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Personal History
        public ActionResult PersonalHist()
        {
            return View();
        }

        public JsonResult AddAddiction(string strAddict, string strGrpCode = "")
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            return Json(clonclo.SaveAddictAddItemdt(strAddict, strGrpCode), JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveAddiction(string strAddict, string strMRNO, string strTranNo)
        {
            //DataTable dt = new DataTable();
            Clinicalnotes clonclo = new Clinicalnotes();
            Session["AddictionList"] = strAddict;
            var data = clonclo.SaveAddiction(strAddict, strMRNO, strTranNo);
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMainAddicList()
        {
            try
            {
                Clinicalnotes clonclo = new Clinicalnotes();

                return Json(clonclo.GetMainAddicListdt(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult SetDataForAddiction(string strTranNo, string strMrNo)
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            return Json(clonclo.SetDataForAddiction(strTranNo,strMrNo), JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Medical History
        public ActionResult MedicalHist()
        {
            return View();
        }
        public JsonResult AddMedical(string strMedical, string strGrpCode = "")
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            return Json(clonclo.SaveMedicAddItemdt(strMedical, strGrpCode), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetMainMedicList()
        {
            try
            {
                Clinicalnotes clonclo = new Clinicalnotes();

                return Json(clonclo.GetMainMedicListdt(), JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SetDataForMedical(string strTranNo, string strMrNo)
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            return Json(clonclo.SetDataForMedical(strTranNo,strMrNo), JsonRequestBehavior.AllowGet);
        }
        public JsonResult SaveMedical(string strMedic, string strMRNO, string strTranNo)
        {
            //DataTable dt = new DataTable();
            Clinicalnotes clonclo = new Clinicalnotes();
            Session["AddictionList"] = strMedic;
            var data = clonclo.SaveMedical(strMedic, strMRNO, strTranNo);
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Family History
        public ActionResult FamilyHist()
        {
            return View();
        }
        public JsonResult GetDiseaseList()
        {
            try
            {
                Clinicalnotes clonclo = new Clinicalnotes();
                return Json(clonclo.GetDiseaseListdt(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SaveFamily(string strMedic, string strMRNO, string strTranNo)
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            Session["AddictionList"] = strMedic;
            var data = clonclo.SaveFamily(strMedic, strMRNO, strTranNo);
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SetDataForFamily(string strTranNo,string strMrNo)
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            return Json(clonclo.SetDataForFamily(strTranNo,strMrNo), JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region LanguageEntry

        public ActionResult LanguageEntry()
        {
            ViewBag.AllergyTypeLst = GeneralFunction.GetAllergyTypeList();
            return View();
        }


        public JsonResult GetReportData(string strType)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            object jsond = cnotes.GetReportData(strType);
            return Json(jsond, JsonRequestBehavior.AllowGet);

        }


        public JsonResult SendData(string data, string strType)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            string str_SaveMsg = cnotes.SendData(data, strType);
            return Json(str_SaveMsg, JsonRequestBehavior.AllowGet);

        }

        public JsonResult AddLanguageEntry(string NAME, string strType, string strHindi, string strMarathi, string strGujrati, string Field3)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            string str_SaveMsg = cnotes.AddLanguageEntry(NAME, strType, strHindi, strMarathi, strGujrati, Field3);
            return Json(str_SaveMsg, JsonRequestBehavior.AllowGet);
        }


        public JsonResult ClinicIndexChanged()
        {
            try
            {
                OncologyEMRClient onco = new OncologyEMRClient();
                var store = onco.GetClinicLst();
                return Json(store);


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region MasterSetup by 

        public ActionResult MasterSetup()
        {
            //added 12/6/19
            OncologyModel mdl = new OncologyModel();
            string setUpCode = Convert.ToString(TempData["MasterSetUpCode"]);
            ViewBag.SetUpCode = setUpCode;
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            ViewBag.RemarkArray = mdl.GetRemarkList(Session["ClinicCode"].ToString().Trim(), srtUserID);
            ViewBag.RouteArray = GeneralFunction.MedicineRouteRX();
            //--------------

            return View();
        }
        //public JsonResult AddMasterSetUp(string masterSetup, string Gender, string AgeF, string AgeT, string strComplaints, string strDiagnosis, string strRxdata, string strInvestigtn, string strPatadv)
        //{
        //    Clinicalnotes cnotes = new Clinicalnotes();
        //    //OncologyModel clonclo = new OncologyModel();
        //    return Json(cnotes.AddMasterSetUpModel(masterSetup, Gender, AgeF, AgeT, strComplaints, strDiagnosis, strRxdata, strInvestigtn, strPatadv), JsonRequestBehavior.AllowGet);
        //}
        public ActionResult CalToMasterSetup(string masterSetUpCode)
        {
            try
            {
                TempData["MasterSetUpCode"] = masterSetUpCode;
                return RedirectToAction("MasterSetup", "Clinicalnotes");
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        //added 15/6/19
        public JsonResult AddMasterSetUp(string masterSetup, string Gender, string AgeF, string AgeT, string strComplaints, string strDiagnosis, string strRxdata, string strInvestigtn, string strPatadv, string strInvestigtnTitle, string strPatadvTitle, string strDiagnosisTitle, string strComplaintsTitle, string setUpCode, string status)
        {
            Clinicalnotes mdl = new Clinicalnotes();
            var data = mdl.AddMasterSetUp(masterSetup, Gender, AgeF, AgeT, strComplaints, strDiagnosis, strRxdata, strInvestigtn, strPatadv, strInvestigtnTitle, strPatadvTitle, strDiagnosisTitle, strComplaintsTitle, setUpCode, status);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetMasterSetUpList(string strAge, string strCimsYN, string strGender)//
        {
            Clinicalnotes clinicalModel = new Clinicalnotes();
            object strResult = clinicalModel.GetMasterSetUpList(strAge, strCimsYN, strGender);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetMasterSetUpData(string strSetUpCode)
        {
            Clinicalnotes clinicalModel = new Clinicalnotes();
            object strResult = clinicalModel.GetMasterSetUpData(strSetUpCode);
            return Json(strResult, JsonRequestBehavior.AllowGet);
        }
        //-------------------
        #endregion

        //vijeta 13/7/19
        #region Vaccination
        public ActionResult GetVaccinationLst(string AgeGrpCode)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            object jsond = cnotes.GetVaccinationLst(AgeGrpCode);
            return Json(jsond, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAgeGroupLst(string ageGrpId = "")
        {

            Clinicalnotes cnotes = new Clinicalnotes();
            object jsond = cnotes.GetAgeGroupLst(ageGrpId);
            return Json(jsond, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveAgeGrouop(string ageGrp, string frmAge, string toAge, string remark, string status, int seq, string AgeGroupCode)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            object jsond = cnotes.SaveAgeGrouop(ageGrp, frmAge, toAge, remark, status, seq, AgeGroupCode);
            return Json(jsond, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveVaccines(string ageGrpCode, string xmlString)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            object data = cnotes.SaveVaccines(ageGrpCode, xmlString);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion
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

        public JsonResult SetDoctSession(string strDoctCd, string strDoctNm)
        {
            System.Web.HttpContext.Current.Session["gDoctName"] = strDoctNm.ToString().Trim();
            System.Web.HttpContext.Current.Session["gDoctCode"] = strDoctCd.ToString().Trim();
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        //vijeta 23rd march 19
        public JsonResult AddFreeHistory(string strText, string strTran, string strMrNo, string strType)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            object jsondata = cnotes.AddFreeHistory(strText, strTran, strMrNo, strType);
            return Json(jsondata, JsonRequestBehavior.AllowGet);
        }

       public ActionResult Vaccination()
        {
            VaccinationModel vm = new VaccinationModel();
            vm.BirthHistoryList = GeneralFunction.GetBirthHistory();
            CommonServiceClient com = new CommonServiceClient();//

            ViewBag.CurrntDate = com.GetServerDate();
            ViewBag.CurrntTime = com.GetServerTime();
            return View(vm);
        }
        public JsonResult GetVaccinationData(string strMrNo, string strDOB)
        {

            VaccinationModel vm = new VaccinationModel();
            object jsond = vm.GetVaccinationDataList(strMrNo, strDOB);
            return Json(jsond, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveVaccinationData11(string strMRNO, string strTime, string strWeight, string strHis, string strBloodGrp, string strMotBldGrp, string strApOne, string strApFiv, string strVitk, string strEDD, string strData)
        {
            VaccinationModel vm = new VaccinationModel();
            object jsond = vm.SaveVaccination(strMRNO, strTime, strWeight, strHis, strBloodGrp, strMotBldGrp, strApOne, strApFiv, strVitk, strEDD, strData);
            return Json(jsond, JsonRequestBehavior.AllowGet);
        }//


        #region Allergy History
        public ActionResult AllergyHist()
        {
            ViewBag.AllergyTypeLst = GeneralFunction.GetAllergyTypeList();
            return View();
        }
        public JsonResult AddAllergy(string strMedical, string Type, string strGrpCode = "")
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            return Json(clonclo.SaveAllergyItemdt(strMedical, strGrpCode, Type), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetMainAllergyListdt()
        {
            try
            {
                Clinicalnotes clonclo = new Clinicalnotes();
                return Json(clonclo.GetMainAllergyListdt(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SetDataForAllergy(string strTranNo, string strMrNo)
        {
            Clinicalnotes clonclo = new Clinicalnotes();
            return Json(clonclo.SetDataForAllergy(strTranNo, strMrNo), JsonRequestBehavior.AllowGet);
        }
        public JsonResult SaveAllergy(string strMedic, string strMRNO, string strTranNo)
        {
            //DataTable dt = new DataTable();
            Clinicalnotes clonclo = new Clinicalnotes();
            Session["AddictionList"] = strMedic;
            var data = clonclo.SaveAllergy(strMedic, strMRNO, strTranNo);
            //return Json(true, JsonRequestBehavior.AllowGet);
            return Json(new { success = true, data = data }, JsonRequestBehavior.AllowGet);
        }
        #endregion



        #region Investigation Verify
        //added on 27th July 2018e

        public ActionResult InvestigationVerify()
        {
            GetLabDepartments();
            GetDoctors();
            return View();
        }
        public JsonResult GetLabDepartments()
        {
            InvestigationVerify mdl = new InvestigationVerify();
            var jsonData = mdl.GetLabDepartments();
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetLabDeptTests(string strLabDept)
        {
            InvestigationVerify mdl = new InvestigationVerify();
            var jsonData = mdl.GetLabDeptTests(strLabDept);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTechVerifiedData(string FromDt, string ToDt, string LabDept, string TechVerify, string strMRNO, string strPatName, string strContact, string strTest, string strSample, string strDoctor)
        {
            InvestigationVerify clonclo = new InvestigationVerify();
            var jsonData = clonclo.GetTechVerifiedData(FromDt, ToDt, LabDept, TechVerify, strMRNO, strPatName, strContact, strTest, strSample, strDoctor);

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTemplateResultToVerify(string mrNo, string strFrmDate, string strTodate, string resultNo, string Type)
        {
            InvestigationVerify clonclo = new InvestigationVerify();
            var jsonData = clonclo.GetTemplateResultToVerify(mrNo, strFrmDate, strTodate, resultNo, Type);
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveTmplRptVerify(string ResultNo, string RptType)
        {
            try
            {
                InvestigationVerify clonclo = new InvestigationVerify();
                var UserID = Session["gOncoUserId"].ToString();
                var MchIPAddress = string.IsNullOrEmpty(Session["MchIPAddress"].ToString()) ? "" : Session["MchIPAddress"].ToString();
                var ModuleIDGlobal = string.IsNullOrEmpty(Session["ModuleIDGlobal"].ToString()) ? "" : Session["ModuleIDGlobal"].ToString();

                //var jsonData 
                string strStatus = clonclo.SaveTmplRptVerify(ResultNo, RptType, UserID, MchIPAddress, ModuleIDGlobal);

                //if (strStatus.Contains("success")  && ("" + GeneralFunction.GetAppsettingUnitWiseValue("GenerateVerifiedReportPDFYN")) == "Y" && ("" + GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath")) != "")
                //{
                //	//VerifyandPrint blPrint = new VerifyandPrint();
                //	string str = clonclo.PreparePDFDocumentForPassedResultNo(ResultNo);
                //}
                return Json(strStatus, JsonRequestBehavior.AllowGet);

                //return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult SaveTmplRptReject(string ResultNo, string RejRemarks)
        {
            try
            {
                InvestigationVerify clonclo = new InvestigationVerify();
                var UserID = Session["gOncoUserId"].ToString();
                var MchIPAddress = string.IsNullOrEmpty(Session["MchIPAddress"].ToString()) ? "" : Session["MchIPAddress"].ToString();
                var ModuleIDGlobal = string.IsNullOrEmpty(Session["ModuleIDGlobal"].ToString()) ? "" : Session["ModuleIDGlobal"].ToString();

                var jsonData = clonclo.SaveTmplRptReject(ResultNo, RejRemarks);
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult GetDocument(string MrNo, string OrderNo, string SampleNo, string strResultno)
        {
            try
            {
                //var labpath = @"\\desktop-omjrssv\Share with other\LapReport\" + MrNo + "/" + strResultno + "//";

                //var labpath = System.Web.Hosting.HostingEnvironment.MapPath("~/LabReport") + "/" + MrNo + "/" + strResultno + "//";
                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();

                var labpath = GeneralFunction.GetAppsettingUnitWiseValue("LABDocPath").ToString() + "/" + strUnit + "/" + MrNo + "/" + strResultno + "/";
                DataTable dt = new DataTable();
                dt.Columns.Add("FileName");
                dt.Columns.Add("FilePath");
                dt.Columns.Add("View");
                var i = 0;
                if (Directory.Exists(labpath))
                {
                    string[] files = Directory.GetFiles(labpath);
                    foreach (string file in files)
                    {
                        dt.Rows.Add();
                        dt.Rows[i]["FileName"] = Path.GetFileName(file);
                        dt.Rows[i]["FilePath"] = (labpath + Path.GetFileName(file) + "");
                        i++;
                    }
                }
                var jsonData = new
                {
                    rows = (from DataRow row in dt.Rows
                            select new
                            {
                                FILENAME = row["FILENAME"].ToString().Trim(),
                                PATH = row["FilePath"].ToString().Trim(),
                                View = ("" + row["View"]).Trim(),
                            }).ToArray()
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string strmsg = ex.Message;
                return Json("", JsonRequestBehavior.AllowGet);
            }
        }

        public FileContentResult NextTabDownloadFiles(string filepath, string filename)
        {
            byte[] FileBytes = System.IO.File.ReadAllBytes(filepath);
            string mimeType = "";
            if (filename.ToString().ToLower().Contains(".pdf"))
            {
                mimeType = "application/pdf";
            }
            else if (filename.ToString().ToLower().Contains(".txt"))
            {
                mimeType = "text/plain";
            }
            else if (filename.ToString().ToLower().Contains(".jpg") || filename.Contains(".jpeg"))
            {
                mimeType = "image/jpeg";
            }
            else if (filename.ToString().ToLower().Contains(".png"))
            {
                mimeType = "image/png";
            }
            else if (filename.Contains(".xslx"))
            {
                mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            }
            else if (filename.ToString().ToLower().Contains(".xls"))
            {
                //mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                mimeType = "application/vnd.ms-excel";
            }
            else if (filename.Contains(".docx"))
            {
                mimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            }
            else if (filename.ToString().ToLower().Contains(".doc"))
            {
                //mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                mimeType = "application/vnd.ms-word";
            }

            Response.AppendHeader("Content-Disposition", "inline; filename=" + filename);
            return File(FileBytes, mimeType);

        }
        #endregion

        public ActionResult DisplayPrintTemplate(string FormName)
        {
            try
            {
                MemoryStream memoryStream = new MemoryStream();
                if (TempData["PrintResultTemplate"] != null)
                    return (ActionResult)new BinaryContentResult(TempData["PrintResultTemplate"] as byte[], "application/pdf", FormName);
                else
                    return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
