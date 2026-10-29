using Newtonsoft.Json;
using NReco.PdfGenerator;
using OncologyEMR.App_Start;
using OncologyEMR.CommonSerRef;
using OncologyEMR.DataClass;
using OncologyEMR.ICUServRef;
using OncologyEMR.Models;
using OncologyEMR.NSServRef;
using OncologyEMR.Oncology;
using OncologyEMR.OncologyServRef;
using OncologyEMR.Pdf;
using OncologyEMR.Report;
using Org.BouncyCastle.Asn1.Cmp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Helpers;
using System.Web.Hosting;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Services.Description;
using System.Web.UI.WebControls;
using System.Xml;

namespace OncologyEMR.Controllers
{
    [SessionExpiry]
    public class SinglePageController : Controller
    {

        private static readonly HttpClient _client = new HttpClient();
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

        #region Common

        #region Header Control
        public ActionResult HeaderControl()
        {
            ViewBag.RightUnitList = GeneralFunction.GetUnitRightsList();
            ViewBag.AllergyTypeLst = GeneralFunction.GetAllergyTypeList();
            return PartialView("HeaderControl", null);
        }

        public ActionResult SingleTumorSchedule()
        {
            return PartialView("SingleTumorSchedule", null);
        }

        public ActionResult AppSettingConfig()
        {
            CommonServiceClient comclient = new CommonServiceClient();
            AppSettingConfigMdl AppSetting = new AppSettingConfigMdl();
            AppSetting.ImageList = DataClass.GeneralFunction.GetImageList();
            ViewBag.varImgLst = DataClass.GeneralFunction.GetImageList();
            AppSetting.Module = comclient.GetModuleList();
            ViewBag.ModuleLst = comclient.GetModuleList();
            AppSetting.Rights = "Y";
            return PartialView("AppSettingConfig", AppSetting);
        }

        public ActionResult ErrorLogInfo()
        {
            return PartialView("ErrorLog", null);
        }
        public ActionResult SingleSurgicalSchedule()
        {
            return PartialView("SingleSurgicalSchedule", null);
        }

        public JsonResult GetMasterSetupAllDetails()
        {
            string clinicCode = Session["ClinicCode"].ToString().Trim();
            string userId = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            OncologyModel mdl = new OncologyModel();
            var result = new
            {
                Remarks = mdl.GetRemarkList(clinicCode, userId),
                Routes = GeneralFunction.MedicineRouteRX()
            };
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        #endregion

        #region Menu List
        public ActionResult SinglePageMenuList()
        {
            DataTable dtEmpty = new DataTable();
            formrights Frights = new formrights();
            if (("" + System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString().Trim() != "")
                Frights.GetLoginRights(System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().ToUpper());
            else
                System.Web.HttpContext.Current.Session.Add("FRMRIGHTS", dtEmpty);
            ViewBag.RightUnitList = GeneralFunction.GetUnitRightsList();
            return View();
        }
        #endregion

        #endregion

        #region OPD

        #region Patient Waiting List
        public ActionResult WaitingListOPD()
        {
            WaitingListOPD clonco = new WaitingListOPD();
            CommonServiceClient com = new CommonServiceClient();
            var model = new WaitingListOPD
            {
                //VisitPurposeList = GeneralFunction.GetVisitPurposeList()
                VisitPurposeList = com.GetVisitPurposeList().Where(x => x.Status == "A").ToList(),  //Pournima 9th April 2026
            };
            return View(model);
        }


        public JsonResult GetPatientList(string strClinicCode, string strSrchByDoctYN = "Y", string DateType = "T", string CustomeDate = "", string Type = "")
        {
            try
            {
                WaitingListOPD clonco = new WaitingListOPD();
                string strDoctorCd = Convert.ToString(HttpContext.Session["gDoctCode"]);

                // If "All Patients" is selected, clear the doctor code so the SP returns everyone
                if (strSrchByDoctYN == "N")
                    strDoctorCd = "";

                Session["ClinicCode"] = strClinicCode;

                // Call the logic layer
                return Json(clonco.GetPatientList(strClinicCode, strDoctorCd, DateType, CustomeDate, Type), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                // LogError(ex);
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        #region Main Screen 

        public ActionResult SinglePageOPD()
        {
            try
            {
                ViewBag.FormLinkRouteList = GeneralFunction.GetFormLinkRouteList();
                return View();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public ActionResult SinglePageIPD()
        {
            try
            {
                ViewBag.FormLinkRouteList = GeneralFunction.GetFormLinkRouteList();
                return View();
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        #endregion

        #region Patient Info
        public ActionResult PatientInfoOPD()
        {
            return PartialView("PatientInfoOPD", null);
        }
        #endregion

        #region Complaints
        public ActionResult Complaints()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        #endregion

        #region ClinicalNotes
        public ActionResult ClinicalNotes()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region  Examination
        public ActionResult Examination()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        #endregion

        #region Diagnosis
        public ActionResult Diagnosis()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        #region Diagnosis
        public JsonResult SaveDiagnosis(string strMRNO, string strIPNO, string strTranNo,
           string ICDOTopoList, string ICDOHistoList, string DiagPrimary, string DiagSecondary, string Gact)
        {
            IPDiagnosis Mdl = new IPDiagnosis();
            var data = Mdl.SaveDiagnosis(strMRNO, strIPNO, strTranNo, ICDOTopoList, ICDOHistoList, DiagPrimary, DiagSecondary, Gact);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SetDataForIPDDiagnosis(string strTranNo, string strMRNO, string strIpNo)
        {
            IPDiagnosis Mdl = new IPDiagnosis();
            return Json(Mdl.SetDataForIPDDiagnosis(strTranNo, strMRNO, strIpNo), JsonRequestBehavior.AllowGet);
        }
        #endregion

        #endregion

        #region  Instructions
        public ActionResult Instruction()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region  Investigation
        public ActionResult Investigation()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region  Chemo Planning
        public ActionResult ChemoPlanning()
        {
            try
            {
                OncologyModel mdl = new OncologyModel();
                var model = new OncologyEMR.Models.ChemoPlanning();
                model.FillCombo();
                model.ChemoPlanTempGaction = "N";
                string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
                ViewBag.RXIntake = mdl.RetriveMedicineIntake(srtUserID);
                return View(model);

            }
            catch (Exception)
            {
                throw;
            }
        }

        #region Save Chemo Planning
        public JsonResult GetMedOncoSave(ChemoPlanning OPDMdl)
        {
            ChemoPlanning clonclo = new ChemoPlanning();
            var data = clonclo.MedOncoSave(OPDMdl);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SaveChemoPrMaster(string AdmnDet, string Name, string Protocol, string Days, string AdmissionYN, string AdmissionNo, string ProtocolType)
        {
            ChemoPlanning ChemoPrMasterMdl = new ChemoPlanning();
            return Json(ChemoPrMasterMdl.SaveChemoPrMaster(AdmnDet, Name, Protocol, Days, AdmissionYN, AdmissionNo, ProtocolType), JsonRequestBehavior.AllowGet);
        }

        public JsonResult ChemoProtocolList()
        {
            ChemoPlanning ChemoPrMasterMdl = new ChemoPlanning();
            CommonServiceClient cs = new CommonServiceClient();
            ChemoPrMasterMdl.ChemoPlanLstChemoName = cs.GetChemoNameLst().Where(x => x.Status == "A").ToList();
            return Json(ChemoPrMasterMdl.ChemoPlanLstChemoName, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #endregion

        #region  Rx
        public ActionResult RX()
        {
            try
            {
                OncologyModel mdl = new OncologyModel();
                string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
                ViewBag.RXRemarkArray = mdl.GetRemarkList(Session["ClinicCode"].ToString().Trim(), srtUserID);
                ViewBag.RXMedRoute = GeneralFunction.MedicineRouteRX();
                ViewBag.RXIntake = mdl.RetriveMedicineIntake(srtUserID);
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public JsonResult GetAllOtherMasterForRX()
        {
            OncologyModel mdl = new OncologyModel();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            var result = new
            {
                RXRemarkArray = mdl.GetRemarkList(Session["ClinicCode"].ToString().Trim(), srtUserID),
                RXMedRoute = GeneralFunction.MedicineRouteRX(),
                RXIntake = mdl.RetriveMedicineIntake(srtUserID)
            };
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region  Advice
        public ActionResult Advice()
        {
            try
            {
                CommonServiceClient comm = new CommonServiceClient();
                ViewBag.CareTypeList = comm.GetCareType().Where(p => p.Status == "A");
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region  Save OPD
        public JsonResult SaveFollowUpData(SaveOPD OPDMdl , SchemePreAuth SchmMdl)
        {
            SaveOPD clonclo = new SaveOPD();
            var data = Json(clonclo.SaveOPDConsultation(OPDMdl, SchmMdl), JsonRequestBehavior.AllowGet);
            string result = data.Data.ToString();
            if (result == "Transaction successful.")
            {
                if (OPDMdl.Redirect == "M")
                    return Json("Presription Saved Successful", JsonRequestBehavior.AllowGet);
                else
                    return Json("Draft Saved Successful", JsonRequestBehavior.AllowGet);
            }
            else
            {
                result = result == "" ? "Please Contact to service provider" : result;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #endregion

        #region IPD

        #region Patient Waiting List
        public ActionResult WaitingListIPD()
        {
            WaitingListIPD model = new WaitingListIPD();
            CommonServiceClient common = new CommonServiceClient();

            model.CaseTypeList = common.GetCaseType()
                 .Where(x => x.Status == "A")
                 .Select(x => new SelectListItem
                 {
                     Text = x.Text,
                     Value = x.Value.ToString()
                 })
                 .ToList();

            return View(model);
        }

        public JsonResult GetAdmissionFrmList(string FrmdateA, string ToDateA, string IPNoA, string MRNOA, string PAtNameA, string nursingSta, string StatusA, string strSrchByDoctYN, string strDoctCode)
        {

            try
            {
                DataSet load = new DataSet();
                string DoctCode = ""; //priyanka 01/04/2026
                CommonServiceClient comm = new CommonServiceClient();
                OncologyEMRClient Onco = new OncologyEMRClient();
                var patSourceLst = comm.GetPatSourceList();
                var doctorList = comm.GetDoctLst();
                var outDocLst = comm.GetReferedDoctList();
                var refHospList = comm.GetRefHospLst();
                var AdmnTypeLst = comm.GetAdmTypeLst();
                var CareTypeLst = comm.GetCareType();
                var CaseTypeLst = comm.GetCaseType();
                FrmdateA = GeneralFunction.GetDateInSpecifiedFormat(FrmdateA, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                ToDateA = GeneralFunction.GetDateInSpecifiedFormat(ToDateA, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                IPNoA = ("" + IPNoA).Trim(); MRNOA = ("" + MRNOA).Trim(); PAtNameA = ("" + PAtNameA).Trim(); nursingSta = ("" + nursingSta).Trim(); StatusA = ("" + StatusA).Trim();
                if (strDoctCode == "") //priyanka 01/04/2026
                {
                    DoctCode = System.Web.HttpContext.Current.Session["gDoctCode"].ToString();
                }
                else
                {
                    DoctCode = strDoctCode;
                    strSrchByDoctYN = "N";
                }
                load = GeneralFunction.FillDatasetXMl(Onco.GetIPPatinetListForDoctor(DoctCode, "", strSrchByDoctYN));//priyanka 06/03/2026
                DataTable jsondata = new DataTable();

                jsondata = load.Tables[0];
                var DoctorList = comm.GetDoctLst();
                string patcatsetval = comm.GetSetupValue("CREDITCOMPCATG");

                //Nursing Station dropdown list 
                var nursList = (from DataRow row in jsondata.Select("(DISCHRGDT IS NULL OR len(trim(DISCHRGDT)) = 0)")
                                select row)
                               .Select(row => new
                               {
                                   Value = ("" + row["NURSCODE"]).Trim(),
                                   Text = ("" + row["NURSTNM"]).Trim()
                               })
                               .Where(x => !string.IsNullOrEmpty(x.Value))
                               .GroupBy(x => x.Value)
                               .Select(g => g.First())
                               .OrderBy(x => x.Text)
                               .ToList();
                //End
                var jsonData = new
                {
                    rows = (from DataRow row in jsondata.Select("(DISCHRGDT IS NULL OR len(trim(DISCHRGDT)) = 0)")
                            select row)
                           .Select((row, index) =>
                           {
                               string admDoctForRow = "";
                               if (row["DATATYPE"].ToString().Trim() == "A")
                               {
                                   string rawDoctVal = ("" + row["DOCTOR"]).Trim();
                                   if (!string.IsNullOrEmpty(rawDoctVal))
                                   {
                                       var parts = rawDoctVal.Split(',');
                                       string firstCode = parts.Length > 0 ? parts[0].Trim() : "";
                                       string secondName = parts.Length > 1 ? parts[1].Trim() : "";

                                       var matchedDoc = doctorList.FirstOrDefault(x => x.Value == firstCode);
                                       string firstName = matchedDoc != null ? ("" + matchedDoc.Text).Trim() : firstCode;

                                       if (string.IsNullOrEmpty(secondName) ||
                                           string.Equals(firstName, secondName, StringComparison.OrdinalIgnoreCase))
                                       {
                                           admDoctForRow = firstName;
                                       }
                                       else
                                       {
                                           admDoctForRow = firstName + ", " + secondName;
                                       }
                                   }
                               }

                               return new
                               {
                                   IPNO = ("" + row["IPNO"]).Trim(),
                                   MRNO = ("" + row["MRNO"]).Trim(),
                                   PATNAME = ("" + row["SALUNAME"]).Trim() + " " + ("" + row["PATNAME"]).Trim(),
                                   ADMNDATE = GeneralFunction.GetDate(("" + row["ADMNDATE"]).Trim()),
                                   ADMNTIME = GetTimeAMPM(("" + row["ADMNTIME"]).Trim()),
                                   NURSTNM = ("" + row["NURSTNM"]).Trim(),
                                   NURSCODE = ("" + row["NURSCODE"]).Trim(), // Abhishesh || 20260904
                                   WARDNM = ("" + row["WARDNM"]).Trim(),
                                   CURRBEDNO = ("" + row["CURRBEDNO"]).Trim(),
                                   PATCATGNM = ("" + row["PATCATGNM"]).Trim(),
                                   STATUS = GeneralFunction.GetAdmnStatus(("" + row["STATUS"]).Trim()),
                                   Gender = row["PATSEX"].ToString().Trim() == "M" ? "Male" : row["PATSEX"].ToString().Trim() == "F" ? "Female" : "",
                                   DISCHRGDT = (row["DISCHRGDT"].ToString().Trim()),
                                   DISCHRGTM = (row["DISCHRGTM"].ToString().Trim()),
                                   PATAGE = GeneralFunction.GetPrintAge(row["PATAGE"].ToString().Trim()),
                                   ADMNDOCT = (row["DATATYPE"].ToString().Trim() == "A") ? admDoctForRow : "",
                                   ADMNDOCTNM = (row["DATATYPE"].ToString().Trim() == "R") ? (row["DOCTOR"].ToString().Trim()) : admDoctForRow,
                                   IsReferred = (row["DATATYPE"].ToString().Trim() == "R"),
                                   indexno = index + 1,
                                   GetPatientImageBase64 = GetPatientImageBase64(row["MRNO"].ToString().Trim()),
                                   CASETYPECD = (row["CASETYPECD"].ToString().Trim()),
                                   CASETYPECDValue = (row["CASETYPENM"].ToString().Trim()),
                                   IPDCompCode = (row["CRDCOMPCD"].ToString().Trim()), //priyanka 04/05/2026
                                   IPDCompNM = (row["COMPNAME"].ToString().Trim()) //priyanka 04/05/2026
                               };
                           }).ToArray(),
                    nursList = nursList // Abhishesh || 20260904
                };
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }

        }
        //public JsonResult GetAdmissionFrmList(string FrmdateA, string ToDateA, string IPNoA, string MRNOA, string PAtNameA, string nursingSta, string StatusA, string strSrchByDoctYN, string strDoctCode)
        //{

        //    try
        //    {
        //        DataSet load = new DataSet();
        //        string DoctCode = ""; //priyanka 01/04/2026
        //        CommonServiceClient comm = new CommonServiceClient();
        //        OncologyEMRClient Onco = new OncologyEMRClient();
        //        var patSourceLst = comm.GetPatSourceList();
        //        var doctorList = comm.GetDoctLst();
        //        var outDocLst = comm.GetReferedDoctList();
        //        var refHospList = comm.GetRefHospLst();
        //        var AdmnTypeLst = comm.GetAdmTypeLst();
        //        var CareTypeLst = comm.GetCareType();
        //        var CaseTypeLst = comm.GetCaseType();
        //        FrmdateA = GeneralFunction.GetDateInSpecifiedFormat(FrmdateA, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
        //        ToDateA = GeneralFunction.GetDateInSpecifiedFormat(ToDateA, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
        //        IPNoA = ("" + IPNoA).Trim(); MRNOA = ("" + MRNOA).Trim(); PAtNameA = ("" + PAtNameA).Trim(); nursingSta = ("" + nursingSta).Trim(); StatusA = ("" + StatusA).Trim();
        //        if (strDoctCode == "") //priyanka 01/04/2026
        //        {
        //            DoctCode = System.Web.HttpContext.Current.Session["gDoctCode"].ToString();
        //        }
        //        else
        //        {
        //            DoctCode = strDoctCode;
        //            strSrchByDoctYN = "N";
        //        }
        //        load = GeneralFunction.FillDatasetXMl(Onco.GetIPPatinetListForDoctor(DoctCode, "", strSrchByDoctYN));//priyanka 06/03/2026
        //        DataTable jsondata = new DataTable();

        //        jsondata = load.Tables[0];
        //        var DoctorList = comm.GetDoctLst();
        //        string patcatsetval = comm.GetSetupValue("CREDITCOMPCATG");
        //        var jsonData = new
        //        {
        //            rows = (from DataRow row in jsondata.Select("(DISCHRGDT IS NULL OR len(trim(DISCHRGDT)) = 0)")
        //                    select row)
        //                    .Select((row, index) => new
        //                    {  
        //                        IPNO = ("" + row["IPNO"]).Trim(),
        //                        MRNO = ("" + row["MRNO"]).Trim(),
        //                        PATNAME = ("" + row["SALUNAME"]).Trim() + " " + ("" + row["PATNAME"]).Trim(),
        //                        ADMNDATE = GeneralFunction.GetDate(("" + row["ADMNDATE"]).Trim()),
        //                        ADMNTIME = GetTimeAMPM(("" + row["ADMNTIME"]).Trim()),
        //                        NURSTNM = ("" + row["NURSTNM"]).Trim(),
        //                        WARDNM = ("" + row["WARDNM"]).Trim(),
        //                        CURRBEDNO = ("" + row["CURRBEDNO"]).Trim(),
        //                        PATCATGNM = ("" + row["PATCATGNM"]).Trim(),
        //                        STATUS = GeneralFunction.GetAdmnStatus(("" + row["STATUS"]).Trim()),
        //                        Gender = row["PATSEX"].ToString().Trim() == "M" ? "Male" : row["PATSEX"].ToString().Trim() == "F" ? "Female" : "",
        //                        DISCHRGDT = (row["DISCHRGDT"].ToString().Trim()),
        //                        DISCHRGTM = (row["DISCHRGTM"].ToString().Trim()),
        //                        PATAGE = GeneralFunction.GetPrintAge(row["PATAGE"].ToString().Trim()),
        //                        ADMNDOCT = (row["DATATYPE"].ToString().Trim() == "A") ? DoctCode : "",
        //                        ADMNDOCTNM = (row["DATATYPE"].ToString().Trim() == "R") ? (row["DOCTOR"].ToString().Trim()) : "",
        //                        IsReferred = (row["DATATYPE"].ToString().Trim() == "R"),
        //                        indexno = index + 1,
        //                        GetPatientImageBase64 = GetPatientImageBase64(row["MRNO"].ToString().Trim()),
        //                        CASETYPECD = (row["CASETYPECD"].ToString().Trim()),
        //                        CASETYPECDValue = (row["CASETYPENM"].ToString().Trim()),
        //                        IPDCompCode = (row["CRDCOMPCD"].ToString().Trim()), //priyanka 04/05/2026
        //                        IPDCompNM = (row["COMPNAME"].ToString().Trim()) //priyanka 04/05/2026
        //                    }).ToArray()
        //        };
        //        return Json(jsonData, JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
        //    }

        //}

        public static string GetTimeAMPM(string time)
        {
            if (string.IsNullOrWhiteSpace(time))
                return "";

            DateTime dt;
            if (DateTime.TryParse(time, out dt))
            {
                return dt.ToString("hh:mm:ss tt");
            }

            return time;
        }


        private string GetPatientImageBase64(string mrno)
        {
            byte[] imgbyte = null;
            string PatImageURL = "";

            new CommonServiceClient().UsingSafe(comser =>
            {
                imgbyte = comser.GetPatientPhoto(mrno);
            });

            if (imgbyte != null && imgbyte.Length > 0)
            {
                PatImageURL = "data:image/png;base64," + Convert.ToBase64String(imgbyte);
            }
            else
            {
                string noPreviewPath = System.Web.HttpContext.Current.Server.MapPath("~/Images/NoPreview.png");
                byte[] noPreviewBytes = System.IO.File.ReadAllBytes(noPreviewPath);
                PatImageURL = "data:image/png;base64," + Convert.ToBase64String(noPreviewBytes);
            }

            return PatImageURL;
        }


        public string GetReferedBy(string strAmnSource, string strRefCD, string strRefHosp, IEnumerable<OncologyEMR.Oncology.DoctorSelLstItem> docList, IEnumerable<RefDoctListItem> outDoctList, IEnumerable<OncologyEMR.Oncology.SelectLstItem> RefHospLst)
        {

            try
            {
                string strRefBy = "";
                if (strAmnSource.ToString().Trim() == "01")
                {
                    strRefBy = (strRefCD == "") ? "" : outDoctList.Where(x => x.Value == strRefHosp.ToString().Trim()).Count() == 0 ? "" : outDoctList.Where(x => x.Value == strRefHosp.ToString().Trim()).First().Text;
                }
                else if (strAmnSource.ToString().Trim() == "05")
                {
                    strRefBy = (strRefCD == "") ? "" : outDoctList.Where(x => x.Value == strRefHosp.ToString().Trim()).Count() == 0 ? "" : outDoctList.Where(x => x.Value == strRefHosp.ToString().Trim()).First().Text;
                }
                else if (strAmnSource.ToString().Trim() == "03")
                {
                    strRefBy = (strRefCD == "") ? "" : outDoctList.Where(x => x.Value == strRefHosp.ToString().Trim()).Count() == 0 ? "" : outDoctList.Where(x => x.Value == strRefHosp.ToString().Trim()).First().Text;
                }
                else
                {
                    strRefBy = "";
                }

                return strRefBy;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        #endregion

        #region Patient Info
        public ActionResult PatientInfoIPD()
        {
            return PartialView("PatientInfoIPD", null);
        }

        public JsonResult GetEMRReportLists()
        {
            Reports rpt = new Reports();

            rpt.FillCombos(rpt);

            return Json(new
            {
                EmployeeList = rpt.EmployeeList,
                TimeList = rpt.TimeList,
                BundleList = rpt.BundleList(),
                PerphlBundleList = rpt.PerphlBundleList(),
                ShiftList = rpt.ShiftSelected
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult EMRReports()
        {
            Reports rpt = new Reports();
            CommonServiceClient common = new CommonServiceClient();

            ViewBag.ServerDate = common.GetServerDate();
            ViewBag.ServerTime = common.GetServerTime();
            ViewBag.ICUNSYN = Session["ICUNSYN"].ToString();
            return View(rpt); // 👈 MUST return View
        }

        public JsonResult GetIsbarYTimeSlots(string strDate, string strIPNo, string strType)
        {
            Reports Rpt = new Reports();
            object obj = Rpt.FillCombos(strDate, strIPNo, strType);
            return Json(JsonConvert.SerializeObject(obj), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetIsbarDrTimeSlots(string strDate, string strIPNo, string strType)
        {
            Reports Rpt = new Reports();
            object obj = Rpt.FillCombos(strDate, strIPNo, strType);
            return Json(JsonConvert.SerializeObject(obj), JsonRequestBehavior.AllowGet);
        }

        public string GetNursAssmntTime(string strDate, string strIPNO)
        {
            DataSet load = new DataSet();
            OncologyEMR.Models.Reports dt = new OncologyEMR.Models.Reports();
            return dt.GetNursngAss(strIPNO).GetXml();
        }

        public async Task<JsonResult> printEMRReport(string strIPNO, string strDate, string strTime, string ReportType, string strToDt, string strBundletype,
    string strtoTime, string IsbarType, string PatStatus, string NoteType, string ProblemCD)
        {
            try
            {
                string Msg = "";
                string url = Convert.ToString(System.Configuration.ConfigurationManager.AppSettings["EMRReportPrintURL"]) + "/";
                if (url == "")
                {
                    Msg = "Please Set Url Config for print";
                    return Json(Msg, JsonRequestBehavior.AllowGet);
                }
                var A = "1";
                if (A == "1")
                {
                    url = url + "GetICUSetCritCareGraphDatePrint";
                }
                else
                {
                    url = url + "ICUReportPrint/PrintEMRReportLocal";

                }


                object[] parameters = new object[5];
                parameters[0] = strIPNO;
                parameters[1] = strDate;
                parameters[2] = strTime;
                parameters[3] = ReportType;
                parameters[4] = strToDt;
                parameters[5] = strBundletype;
                parameters[6] = strtoTime;
                parameters[7] = IsbarType;
                parameters[8] = PatStatus;
                parameters[9] = NoteType;
                parameters[10] = ProblemCD;

                var response = await ExternalCallForPrint(url, parameters);
                if (response != null)
                {
                    object[] Result = response as object[];
                    Msg = Result[0].ToString();
                    if (Result[1] != null)
                    {
                        byte[] byteArray = Convert.FromBase64String(Result[1].ToString());
                        TempData["printdata"] = byteArray;
                    }
                }
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string Msg = string.Empty;
                Msg = ex.Message;
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
        }

        public async Task<object> ExternalCallForPrint(string UrlCall, object[] Param)
        {
            object[] obj = new object[2];
            obj[0] = string.Empty;
            obj[1] = string.Empty;

            try
            {
                string jsonData = JsonConvert.SerializeObject(new
                {
                    Parameters = Param
                });
                var content = new StringContent(jsonData, Encoding.UTF8, "application/json");
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
                    obj[1] = "";
                }
            }
            catch (Exception ex)
            {
                obj[0] = ex.Message;
                obj[1] = "";
            }
            return obj;
        }




        public ActionResult DisplayICUPrint(string ReportType)
        {
            byte[] printdata = TempData["printdata"] as byte[];
            if (printdata == null || printdata.Length == 1)
            {
                return null;
            }
            else
            {
                MemoryStream outmeomery = new MemoryStream();
                return new BinaryContentResult(printdata, "application/pdf", ReportType);
            }
        }

        public ActionResult DisplayICUPrints(string ReportType)
        {
            byte[] printdata1 = TempData["printdata1"] as byte[];
            if (printdata1 == null || printdata1.Length == 1)
            {
                return null;
            }
            else
            {
                MemoryStream outmeomery = new MemoryStream();
                return new BinaryContentResult(printdata1, "application/pdf", ReportType);
            }
        }

        public JsonResult GetProblemList(string strIPNO, string strDate, string strToDt, string strTime, string strToTime, string strproblemcd, string CloseYN)
        {
            try
            {
                Reports rt = new Reports();
                strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                strToDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                List<CommonSerRef.SelectLstItem> problemList = rt.GetICUNurseNotes(strIPNO, strDate, strToDt, strTime, strToTime, strproblemcd, CloseYN);

                return Json(problemList, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        //Added By Roshan 22/1/2026
        public JsonResult GetPateintInfo(string strIpNo)
        {
            WaitingListIPD mdl = new WaitingListIPD();
            var data = mdl.GetIPPateintInfo(strIpNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetPatientVitalInfo(string strIpNo)
        {
            WaitingListIPD mdl = new WaitingListIPD();
            var data = mdl.GetIPPatientVitalInfo(strIpNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region EMR Records

        public ActionResult EMRRecords()
        {
            try
            {
                Reports Rpt = new Reports();
                CommonServiceClient common = new CommonServiceClient();
                Rpt.FillCombos(Rpt);
                Rpt.Time = common.GetServerTime();
                Rpt.BundleListSelected = Rpt.BundleList();
                Rpt.PerphlBundleListSelected = Rpt.PerphlBundleList();
                ViewBag.ServerTime = common.GetServerTime();
                ViewBag.ServerDate = common.GetServerDate();
                return PartialView("EMRRecords", Rpt);
            }
            catch (Exception)
            {
                throw;
            }
        }













        [HttpPost]
        public JsonResult SetCritCareGraphDate(string strDate, string strIPNo)
        {
            TempData["CFDate"] = strDate;
            TempData["ReportIPNo"] = strIPNo;
            return Json("Success");
        }

        public ActionResult CriticalCareGraph()
        {
            CommonServiceClient comserv = new CommonServiceClient();
            CriticalCareGraph g = new CriticalCareGraph();
            ICUClient icuClient = new ICUClient();
            g = g.GetGraphDetails(TempData["ReportIPNo"].ToString());
            DataSet dstemp = new DataSet();
            dstemp.ReadXml(new XmlTextReader(new StringReader(icuClient.GetMaxTemp(TempData["ReportIPNo"].ToString(), GeneralFunction.GetDateInSpecifiedFormat(TempData["CFDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD)))));
            if (dstemp.Tables.Count >= 1)
            {
                g.TempMax = dstemp.Tables[0].Rows[0]["VALUE"].ToString().Trim();
            }
            DataSet load = new DataSet();
            DataTable dtRespiratory = new DataTable();
            DataTable dtResp = new DataTable();
            DataSet ds = g.GetGraphDetail(TempData["ReportIPNo"].ToString(), TempData["CFDate"].ToString());
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetRespiAssesPrint(TempData["ReportIPNo"].ToString(), GeneralFunction.GetDateInSpecifiedFormat(TempData["CFDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD)))));
            if (load.Tables.Count > 0)
            {
                dtRespiratory = load.Tables[0];
                dtRespiratory.TableName = "RESP";
                dtRespiratory.Columns.Add("SEQNO", typeof(int));
                for (int i = 0; i <= dtRespiratory.Rows.Count - 1; i++)
                {
                    dtRespiratory.Rows[i]["SEQNO"] = i;
                }
            }
            DataSet load1 = new DataSet();
            DataTable dtAssmmntOfLine = new DataTable();
            DataTable dtAssmmntLn = new DataTable();
            load1.ReadXml(new XmlTextReader(new StringReader(icuClient.GetAssesOfLine(TempData["ReportIPNo"].ToString(), GeneralFunction.GetDateInSpecifiedFormat(TempData["CFDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD), ""))));
            if (load1.Tables.Count > 0)
            {
                dtAssmmntOfLine = load1.Tables[0];
                dtAssmmntLn = dtAssmmntOfLine.Copy();
                dtAssmmntLn.Columns.Add("AssmntOfLine");
                var AsstLst = GeneralFunction.AssmntList();
                var SideList = GeneralFunction.SideList();
                var CondList = GeneralFunction.ConditionList();
                var TubeList = GeneralFunction.TUBELIST();
                var ShiftList = GeneralFunction.ShiftList();
                for (int i = 0; i <= dtAssmmntLn.Rows.Count - 1; i++)
                {
                    dtAssmmntLn.Rows[i]["SHIFTTM"] = GeneralFunction.GetShiftSeq(dtAssmmntLn.Rows[i]["SHIFTTM"].ToString()) + (ShiftList.Where(x => x.Value == dtAssmmntLn.Rows[i]["SHIFTTM"].ToString().Trim()).Count() == 0 ? "" : ShiftList.Where(p => p.Value == dtAssmmntLn.Rows[i]["SHIFTTM"].ToString().Trim()).First().Text);
                    dtAssmmntLn.Rows[i]["TUBECD"] = TubeList.Where(x => x.Value == dtAssmmntLn.Rows[i]["TUBECD"].ToString().Trim()).Count() == 0 ? "" : TubeList.Where(p => p.Value == dtAssmmntLn.Rows[i]["TUBECD"].ToString().Trim()).First().Text;
                    dtAssmmntLn.Rows[i]["TUBETYPE"] = AsstLst.Where(x => x.Value == dtAssmmntLn.Rows[i]["TUBETYPE"].ToString().Trim()).Count() == 0 ? "" : AsstLst.Where(p => p.Value == dtAssmmntLn.Rows[i]["TUBETYPE"].ToString().Trim()).First().Text;
                    dtAssmmntLn.Rows[i]["COND"] = CondList.Where(x => x.Value == dtAssmmntLn.Rows[i]["COND"].ToString().Trim()).Count() == 0 ? "" : CondList.Where(p => p.Value == dtAssmmntLn.Rows[i]["COND"].ToString().Trim()).First().Text;
                    dtAssmmntLn.Rows[i]["SIDE"] = SideList.Where(x => x.Value == dtAssmmntLn.Rows[i]["SIDE"].ToString().Trim()).Count() == 0 ? "" : SideList.Where(p => p.Value == dtAssmmntLn.Rows[i]["SIDE"].ToString().Trim()).First().Text;
                    dtAssmmntLn.Rows[i]["AssmntOfLine"] = ((dtAssmmntLn.Rows[i]["TUBECD"].ToString().Trim() == "") ? dtAssmmntLn.Rows[i]["OTHERLINES"].ToString().Trim() : dtAssmmntLn.Rows[i]["TUBECD"].ToString().Trim()).Trim() + "  " + dtAssmmntLn.Rows[i]["SIDE"] + "  " + dtAssmmntLn.Rows[i]["TUBETYPE"] + "  " + dtAssmmntLn.Rows[i]["OTHERTXT"];
                }
                dtAssmmntLn.TableName = "ASSMNTOFLINE";
                ds.Tables.Add(dtAssmmntLn);
            }
            else
            {
                dtAssmmntLn = null;
            }
            g.Date = ("" + TempData["CFDate"]).ToString();

            if (ds.Tables.Contains("RECTTEMP"))
                ViewData["RECTAL"] = JsonConvert.SerializeObject(ds.Tables["RECTTEMP"]);
            else
                ViewData["RECTAL"] = null;

            if (ds.Tables.Contains("ORALTEMP"))
                ViewData["ORAL"] = JsonConvert.SerializeObject(ds.Tables["ORALTEMP"]);
            else
                ViewData["ORAL"] = null;

            if (ds.Tables.Contains("PERIPHERAL"))
                ViewData["PERIPHERAL"] = JsonConvert.SerializeObject(ds.Tables["PERIPHERAL"]);
            else
                ViewData["PERIPHERAL"] = null;

            if (ds.Tables.Contains("PATRATE"))
                ViewData["PATRATE"] = JsonConvert.SerializeObject(ds.Tables["PATRATE"]);
            else
                ViewData["PATRATE"] = null;

            if (ds.Tables.Contains("PACERATE"))
                ViewData["PACERATE"] = JsonConvert.SerializeObject(ds.Tables["PACERATE"]);
            else
                ViewData["PACERATE"] = null;

            if (ds.Tables.Contains("NIBP"))
                ViewData["NIBP"] = JsonConvert.SerializeObject(ds.Tables["NIBP"]);
            else
                ViewData["NIBP"] = null;

            if (ds.Tables.Contains("IABP"))
                ViewData["IABP"] = JsonConvert.SerializeObject(ds.Tables["IABP"]);
            else
                ViewData["IABP"] = null;

            if (ds.Tables.Contains("PAP"))
                ViewData["PAP"] = JsonConvert.SerializeObject(ds.Tables["PAP"]);
            else
                ViewData["PAP"] = null;

            if (ds.Tables.Contains("CVP"))
                ViewData["CVP"] = JsonConvert.SerializeObject(ds.Tables["CVP"]);
            else
                ViewData["CVP"] = null;

            if (ds.Tables.Contains("RR"))
                ViewData["RR"] = JsonConvert.SerializeObject(ds.Tables["RR"]);
            else
                ViewData["RR"] = null;

            if (ds.Tables.Contains("IBP"))
                ViewData["IBP"] = JsonConvert.SerializeObject(ds.Tables["IBP"]);
            else
                ViewData["IBP"] = null;
            if (ds.Tables.Contains("ASSMNTOFLINE"))
                ViewData["ASSMNTOFLINE"] = JsonConvert.SerializeObject(ds.Tables["ASSMNTOFLINE"]).Replace(@"\", @"\\").Replace("'", @"\'");      ///vishal 9th Feb 2019
            else
                ViewData["ASSMNTOFLINE"] = null;

            if (ds.Tables.Contains("SPECOBSERV"))
            {
                for (int i = 0; i <= ds.Tables["SPECOBSERV"].Rows.Count - 1; i++)
                {
                    ds.Tables["SPECOBSERV"].Rows[i]["OBSERVDT"] = GeneralFunction.GetDate(ds.Tables["SPECOBSERV"].Rows[i]["OBSERVDT"].ToString());
                }
                ViewData["SPECOBSERV"] = JsonConvert.SerializeObject(ds.Tables["SPECOBSERV"]).Replace(@"\", @"\\").Replace("'", @"\'").Replace("'", @"\'"); ;
            }
            else
            {
                ViewData["SPECOBSERV"] = null;
            }
            if (ds.Tables.Contains("OTHER"))
            {
                ds.Tables["OTHER"].Columns.Add("SEQNO", typeof(int));
                for (int i = 0; i <= ds.Tables["OTHER"].Rows.Count - 1; i++)
                {
                    ds.Tables["OTHER"].Rows[i]["SEQNO"] = i;
                }
                DataRow[] dr = ds.Tables["OTHER"].Select("[7AM]<>'' OR [8AM]<>'' OR [9AM]<>'' OR [10AM]<>''OR [11AM]<>''OR [12PM]<>''OR [1PM]<>''OR [2PM]<>''OR [3PM]<>''OR [4PM]<>''OR [5PM]<>''OR [6PM]<>''OR [7PM]<>''OR [8PM]<>''OR [9PM]<>''OR [10PM]<>''OR [11PM]<>''OR [12AM]<>''OR [1AM]<>''OR [2AM]<>''OR [3AM]<>''OR [4AM]<>''OR [5AM]<>''OR [6AM]<>''");
                if (dr.Count() > 0)
                {
                    DataTable dt = ds.Tables["OTHER"].Select("[7AM]<>'' OR [8AM]<>'' OR [9AM]<>'' OR [10AM]<>''OR [11AM]<>''OR [12PM]<>''OR [1PM]<>''OR [2PM]<>''OR [3PM]<>''OR [4PM]<>''OR [5PM]<>''OR [6PM]<>''OR [7PM]<>''OR [8PM]<>''OR [9PM]<>''OR [10PM]<>''OR [11PM]<>''OR [12AM]<>''OR [1AM]<>''OR [2AM]<>''OR [3AM]<>''OR [4AM]<>''OR [5AM]<>''OR [6AM]<>''").CopyToDataTable();
                    dt.TableName = "OTHERS";
                    DataView dv = dt.DefaultView;
                    dv.Sort = "SEQNO";
                    dt = dv.ToTable();
                    if (dt != null)
                        ds.Tables.Add(dt);
                }
            }
            if (ds.Tables.Contains("OTHERS"))
                ViewData["OTHERDT"] = JsonConvert.SerializeObject(ds.Tables["OTHERS"]);
            else
                ViewData["OTHERDT"] = null;
            if (dtRespiratory.Rows.Count > 0)
            {
                DataRow[] dr = dtRespiratory.Select("[Desc] ='GCS SCALE' OR [7 AM]<>'' OR [8 AM]<>'' OR [9 AM]<>'' OR [10 AM]<>''OR [11 AM]<>''OR [12 PM]<>''OR [1 PM]<>''OR [2 PM]<>''OR [3 PM]<>''OR [4 PM]<>''OR [5 PM]<>''OR [6 PM]<>''OR [7 PM]<>''OR [8 PM]<>''OR [9 PM]<>''OR [10 PM]<>''OR [11 PM]<>''OR [12 AM]<>''OR [1 AM]<>''OR [2 AM]<>''OR [3 AM]<>''OR [4 AM]<>''OR [5 AM]<>''OR [6 AM]<>''");
                if (dr.Count() > 0)
                {
                    DataTable dt = dtRespiratory.Select("[Desc] ='GCS SCALE' OR [7 AM]<>'' OR [8 AM]<>'' OR [9 AM]<>'' OR [10 AM]<>''OR [11 AM]<>''OR [12 PM]<>''OR [1 PM]<>''OR [2 PM]<>''OR [3 PM]<>''OR [4 PM]<>''OR [5 PM]<>''OR [6 PM]<>''OR [7 PM]<>''OR [8 PM]<>''OR [9 PM]<>''OR [10 PM]<>''OR [11 PM]<>''OR [12 AM]<>''OR [1 AM]<>''OR [2 AM]<>''OR [3 AM]<>''OR [4 AM]<>''OR [5 AM]<>''OR [6 AM]<>''").CopyToDataTable();
                    dt.TableName = "RESPR";
                    DataView dv = dt.DefaultView;
                    dv.Sort = "SEQNO";
                    dt = dv.ToTable();
                    if (dt != null)
                    {
                        if (dt.Rows.Count == 1)
                        {

                        }
                        else
                        {
                            ds.Tables.Add(dt);
                        }

                    }
                }
            }
            if (ds.Tables.Contains("RESPR"))
                ViewData["RESPIRATORY"] = JsonConvert.SerializeObject(ds.Tables["RESPR"]);
            else
                ViewData["RESPIRATORY"] = null;
            if (ds.Tables.Contains("CRIT"))
            {
                DataTable dt2 = ds.Tables["CRIT"];
                if (dt2.Columns.Contains("desc"))
                {
                    DataRow[] rowsToDelete = dt2.Select("desc = 'Total (c) UF output UPTO the Hour:'");
                    if (rowsToDelete.Length > 0)
                    {
                        dt2.Rows.Remove(rowsToDelete[0]);
                    }
                }
                foreach (DataRow row in dt2.Rows)
                {
                    for (int col = 0; col < dt2.Columns.Count; col++)
                    {
                        if (row[col] != null && (row[col].ToString().Trim() == "0" || row[col].ToString().Trim() == "0.00"))
                        {
                            row[col] = "";
                        }
                    }
                }
                ViewData["GRIDDATA"] = JsonConvert.SerializeObject(dt2);
            }
            else
            {
                ViewData["GRIDDATA"] = null;
            }
            if (ds.Tables.Contains("IPOP"))
            {
                if (ds.Tables["IPOP"].Rows.Count > 0)
                {
                    var table = ds.Tables["IPOP"];
                    g.ParentalIP = table.Rows.Count > 0 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[0][1]) : 0.0;
                    g.NonParentamIP = table.Rows.Count > 1 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[1][1]) : 0.0;
                    g.OTIP = table.Rows.Count > 3 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[2][1]) : 0.0;
                    g.TotalIP = Convert.ToDouble(g.NonParentamIP + g.ParentalIP + g.OTIP);
                    g.RTOP = table.Rows.Count > 4 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[3][1]) : 0.0;
                    g.UrineOP = table.Rows.Count > 5 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[4][1]) : 0.0;
                    g.UFOP = table.Rows.Count > 6 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[5][1]) : 0.0;
                    g.DrainOP = table.Rows.Count > 7 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[6][1]) : 0.0;
                    g.BloodOP = table.Rows.Count > 8 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[7][1]) : 0.0;
                    g.OTOP = table.Rows.Count > 9 ? Convert.ToDouble(ds.Tables["IPOP"].Rows[8][1]) : 0.0;
                    g.TotalOP = Convert.ToDouble(g.RTOP + g.UrineOP + g.DrainOP + g.UFOP + g.BloodOP + g.OTOP);
                    g.Balance = Math.Round(Convert.ToDouble(g.TotalIP - g.TotalOP), 2);
                }
            }
            if (ds.Tables.Contains("ICUDAYS"))
            {
                if (ds.Tables["ICUDAYS"].Rows.Count > 0)
                {
                    g.ICUDays = Convert.ToString(ds.Tables["ICUDAYS"].Rows[0]["ICUDAY"]);
                    g.WardBedNo = ds.Tables["ICUDAYS"].Rows[0]["WARNNAME"].ToString();

                }
            }
            if (ds.Tables.Contains("IPOPSUM"))
            {
                DataTable dt = ds.Tables["IPOPSUM"];

                if (dt.Rows.Count > 0)
                {
                    dt.DefaultView.Sort = "INFUSNDESC asc";

                    double TotalIP = 0;
                    double TotalOP = 0;

                    // Safely sum IP values (assuming first 3 rows are IP)
                    for (int i = 0; i < 3 && i < dt.Rows.Count; i++)
                    {
                        TotalIP += Convert.ToDouble(dt.Rows[i][1]);
                    }

                    // Safely sum OP values (assuming next rows are OP)
                    for (int i = 3; i <= 8 && i < dt.Rows.Count; i++)
                    {
                        TotalOP += Convert.ToDouble(dt.Rows[i][1]);
                    }

                    g.CumulativeBal = Math.Round(TotalIP - TotalOP, 2);
                }
            }

            if (ds.Tables.Contains("CASEDET"))
            {
                if (ds.Tables["CASEDET"].Rows.Count > 0)
                {
                    g.Diagnosis = ds.Tables["CASEDET"].Rows[0]["DIAGNOSIS"].ToString();
                    g.SurgeryNm = ds.Tables["CASEDET"].Rows[0]["SURGNAME"].ToString();
                    g.Height = ds.Tables["CASEDET"].Rows[0]["HEIGHT"].ToString();
                    g.Weight = ds.Tables["CASEDET"].Rows[0]["WEIGHT"].ToString();
                    g.EF = ds.Tables["CASEDET"].Rows[0]["EF"].ToString();
                    g.BMI = ds.Tables["CASEDET"].Rows[0]["BMI"].ToString();
                    if (ds.Tables["CASEDET"].Rows[0]["POSTOPDAYS"].ToString().Trim() != "")
                    {
                        string strCFDate = GeneralFunction.GetDateInSpecifiedFormat(TempData["CFDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        string surgDt = GeneralFunction.GetDate(ds.Tables["CASEDET"].Rows[0]["SURGDATE"].ToString());
                        ds.Tables["CASEDET"].Rows[0]["POSTOPDAYS"] = GeneralFunction.calPostOperDays(surgDt, strCFDate);
                    }

                    g.PostOPDays = ds.Tables["CASEDET"].Rows[0]["POSTOPDAYS"].ToString();

                }
            }
            return View(g);
        }

        [HttpPost]
        public JsonResult SetTISSDatesNIPNO(string strFrmDate, string strToDate, string strIPNo)
        {
            TISS28ScoringModel mdl = new TISS28ScoringModel();
            mdl = mdl.GetDataForTISSReport(strIPNo, strFrmDate, strToDate, System.Web.HttpContext.Current.Session["gOncoUserId"].ToString());

            if (mdl == null || string.IsNullOrEmpty(mdl.TISS28ScorerptData))
            {
                return Json("No Data Found");
            }
            TempData["TISSFrmDate"] = strFrmDate;
            TempData["TISSToDate"] = strToDate;
            TempData["TISSIPNO"] = strIPNo;

            return Json("Success");
        }

        public ActionResult TISSReport()
        {
            TISS28ScoringModel mdl = new TISS28ScoringModel();
            var strFrmDate = TempData["TISSFrmDate"].ToString();
            var strToDate = TempData["TISSToDate"].ToString();
            var strIPNo = TempData["TISSIPNO"].ToString();
            mdl.ICUYN = (Session["ICUNSYN"].ToString() ?? "N").ToUpper();
            var Bedno = mdl.BedNo;
            mdl = mdl.GetDataForTISSReport(strIPNo, strFrmDate, strToDate, System.Web.HttpContext.Current.Session["gOncoUserId"].ToString());
            mdl.FrmDate = strFrmDate;
            mdl.ToDate = strToDate;
            if (!string.IsNullOrEmpty(mdl.TISS28ScorerptData))
                ViewData["REPORTTABLE"] = mdl.TISS28ScorerptData;
            return View(mdl);
        }

        public ActionResult BedwiseReport()
        {
            TISS28ScoringModel mdl = new TISS28ScoringModel();
            //Session["NSCODE"] = GetLoggedInNurseCode();
            //Session["NSNAME"] = GetLoggedInNurseName();
            var NurstCode = Session["NSCODE"].ToString();
            var NursName = Session["NSNAME"].ToString();
            var strFrmDate = TempData["TISSFrmDate"].ToString();
            var strToDate = TempData["TISSToDate"].ToString();
            mdl = mdl.GetDataForBedwiseScoreReport(Session["NSCODE"].ToString());
            mdl.FrmDate = strFrmDate;
            mdl.ToDate = strToDate;
            mdl.ReportTitle = Session["NSNAME"] + " - Patient Acuity";
            ViewData["REPORTTABLE"] = mdl.BedwiseScoreData;

            return View("BedwiseReport", mdl);
        }


        public JsonResult GetInvestReportData(string strIPNO, string strDate, string strTime, string ReportType, string strToDt, string chkInvstg)
        {
            try
            {
                TempData["IPNO"] = strIPNO;
                TempData["FROMDATE"] = strDate;
                TempData["TODATE"] = strToDt;
                TempData["chkInvstg"] = chkInvstg;

                Reports dt = new Reports();
                DataSet ds = dt.GetInvestResult(strIPNO, strDate, strToDt, chkInvstg);

                if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                {
                    return Json("No Data Found", JsonRequestBehavior.AllowGet);
                }

                return Json("Success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = 400;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult InvestigateResult()
        {
            Reports dt = new Reports();
            CriticalCareGraph g = new CriticalCareGraph();
            string IPNo = TempData["IPNO"].ToString();
            string FromDate = TempData["FROMDATE"].ToString();
            string Todate = TempData["TODATE"].ToString();
            string chkinvstg = TempData["chkInvstg"].ToString();
            g = g.GetGraphDetails(IPNo);
            ViewBag.FromDate = FromDate;
            ViewBag.ToDate = Todate;
            DataSet InvestigateData = dt.GetInvestResult(IPNo, FromDate, Todate, chkinvstg);

            if (InvestigateData.Tables.Contains("Investigate"))
                ViewData["InvestReportData"] = JsonConvert.SerializeObject(InvestigateData);
            else
                ViewData["InvestReportData"] = null;

            return View(g);
        }

        #region DiacomImages
        public string RedirectToDicom(string strMrNo)
        {
            string strURL = GeneralFunction.GetAppsettingUnitWiseValue("LocalDicomURL").ToString();
            return strURL + strMrNo;
        }
        #endregion

        #endregion EMR Records

        #region EMR Records Print
        public ActionResult EMRRecordsPrint()
        {
            try
            {
                Reports Rpt = new Reports();
                CommonServiceClient common = new CommonServiceClient();
                Rpt.FillCombos(Rpt);
                Rpt.Time = common.GetServerTime();
                Rpt.BundleListSelected = Rpt.BundleList();
                Rpt.PerphlBundleListSelected = Rpt.PerphlBundleList();
                ViewBag.ServerTime = common.GetServerTime();
                ViewBag.ServerDate = common.GetServerDate();
                return View(Rpt);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public async Task<JsonResult> NurseCareFlowSheet(string strIPNO, string strDate)
        {
            try
            {
                string Msg = "";
                string url = Convert.ToString(System.Configuration.ConfigurationManager.AppSettings["EMRReportPrintURL"]) + "/";
                if (url == "")
                {
                    Msg = "Please Set Url Config for print";
                    return Json(Msg, JsonRequestBehavior.AllowGet);
                }
                url = url + "GetICUSetCritCareGraphDatePrint";
                object[] parameters = new object[5];
                parameters[0] = strIPNO;
                parameters[1] = strDate;
                parameters[2] = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString().Trim();

                var response = await ExternalCallForEMRRecordsPrint(url, parameters);
                if (response != null)
                {
                    object[] Result = response as object[];
                    Msg = Result[0].ToString();
                    if (Result[1] != null)
                    {
                        byte[] byteArray = Convert.FromBase64String(Result[1].ToString());
                        TempData["printdata"] = byteArray;
                    }
                }
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string Msg = string.Empty;
                Msg = ex.Message;
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
        }

        public async Task<object> ExternalCallForEMRRecordsPrint(string UrlCall, object[] Param)
        {
            object[] obj = new object[2];
            obj[0] = string.Empty;
            obj[1] = string.Empty;

            try
            {
                string jsonData = JsonConvert.SerializeObject(new
                {
                    Parameters = Param
                });
                var content = new StringContent(jsonData, Encoding.UTF8, "application/json");
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
                    obj[1] = "";
                }
            }
            catch (Exception ex)
            {
                obj[0] = ex.Message;
                obj[1] = "";
            }
            return obj;
        }



        public async Task<JsonResult> PrintEMRReports(string strIPNO, string strDate, string strTime, string ReportType, string strToDt, string strBundletype,
            string strtoTime, string IsbarType, string PatStatus, string NoteType, string ProblemCD)
        {
            try
            {
                string Msg = "";
                string url = Convert.ToString(System.Configuration.ConfigurationManager.AppSettings["EMRReportPrintURL"]) + "/";
                if (url == "")
                {
                    Msg = "Please Set Url Config for print";
                    return Json(Msg, JsonRequestBehavior.AllowGet);
                }
                var A = "1";
                if (A == "1")
                {
                    url = url + "GetICUSetCritCareGraphDatePrint";
                }
                else
                {
                    url = url + "ICUReportPrint/PrintEMRReportLocal";

                }


                object[] parameters = new object[5];
                parameters[0] = strIPNO;
                parameters[1] = strDate;
                parameters[2] = strTime;
                parameters[3] = ReportType;
                parameters[4] = strToDt;
                parameters[5] = strBundletype;
                parameters[6] = strtoTime;
                parameters[7] = IsbarType;
                parameters[8] = PatStatus;
                parameters[9] = NoteType;
                parameters[10] = ProblemCD;

                var response = await ExternalCallForPrint(url, parameters);
                if (response != null)
                {
                    object[] Result = response as object[];
                    Msg = Result[0].ToString();
                    if (Result[1] != null)
                    {
                        byte[] byteArray = Convert.FromBase64String(Result[1].ToString());
                        TempData["printdata"] = byteArray;
                    }
                }
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string Msg = string.Empty;
                Msg = ex.Message;
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult GenerateExcelReports(string strFrmDate, string strToDate, string IPNO, string filename)
        {
            Reports md = new Reports();
            string strToExcel = md.GenerateExcelReports(strFrmDate, strToDate, IPNO);
            TempData["printdata"] = strToExcel.ToString();
            TempData["filename"] = filename.ToString();
            string response = "success";
            if (strToExcel == "No Data Found")
            {
                response = "No Data Found";
            }
            else
            {

                response = "success";
            }
            return Json(response);
        }

        public ActionResult DisplayGenerateExcelReports()
        {

            string printdata = TempData["printdata"] as string;
            string filename = TempData["filename"] as string;
            return new OncologyEMR.DataClass.ExcelResult
            {
                FileName = filename,
                XMLStream = printdata
            };
        }
        #endregion

        #region  Progress Notes
        public ActionResult ProgressNotes()
        {
            try
            {
                DateTime dt = DateTime.Now;
                CommonServiceClient comserv = new CommonServiceClient();
                NursingNotes nursgnote = new NursingNotes();
                nursgnote.ShiftSelected = nursgnote.ShiftList();
                nursgnote.shifttodayDate = comserv.GetServerDate();
                nursgnote.todaystime = comserv.GetServerTime();
                nursgnote.TimeSelection = nursgnote.TimeList();
                nursgnote.FillCombo(nursgnote);
                ViewBag.UserList = comserv.GetUserList();
                ViewBag.ICUEVALUATELIST = comserv.GetICUEvalOutLst("").Where(x => x.Status == "A");
                return View(nursgnote);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public JsonResult GetCurDateTime()
        {
            DateTime dt = DateTime.Now;
            return Json(dt.ToString("dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture), JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetICUProgressNotes(string strIPNo, string strFromDate, string strToDate, string strTime, string strToTime, string userid, string NoteType)
        {
            NursingNotes nursgnote = new NursingNotes();
            object json = nursgnote.GetICUProgressNotesData(strIPNo, strFromDate, strToDate, strTime, strToTime, userid, NoteType);
            return Json(json, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetThreefieldGridData(string MasterLabel)
        {
            NursingNotes nursgnote = new NursingNotes();
            var jsonResult = Json(nursgnote.GetProKeyMasterList(), JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = 2147483647;
            return jsonResult;
        }
        public JsonResult SaveNursingNotes(string PatientData, string NursgNotes, string prblmdate, string prblmtime, string staffid, string mode)
        {
            NursingNotes nursgnote = new NursingNotes();
            string jsong = nursgnote.SaveNursingNotesTran(PatientData, NursgNotes, prblmdate, prblmtime, staffid, mode);
            return Json(jsong);
        }
        public JsonResult GetNursingNotes(string ipno, string notedate, string userid, string problemcd, string CloseYN)
        {
            NursingNotes nursgnote = new NursingNotes();
            object jsong = nursgnote.GetNursgNotesData(ipno, notedate, userid, problemcd, CloseYN);
            return Json(jsong, JsonRequestBehavior.AllowGet);

        }
        public JsonResult GetNursgAdditionalNotes(string ipno, string notedate, string notetime, string userid, string NoteType)
        {

            NursingNotes nursgnote = new NursingNotes();
            object jsong = nursgnote.GetNursgAdditionalNotesTran(ipno, notedate, notetime, userid, NoteType);
            return Json(jsong, JsonRequestBehavior.AllowGet);
        }
        public object GetNursgAdditionalNotesTime(string ipno, string notedate, string notetime, string userid, string NoteType)
        {
            NursingNotes nursgnote = new NursingNotes();
            object jsong = nursgnote.GetNursgAdditionalNotesTime(ipno, notedate, notetime, userid, NoteType);
            return Json(jsong, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SaveNursgAdditionalNotes(string ipno, string NursgNotesData, string notedate, string notetime, string userid, string strInkColor, string nmode, string AuthYn, string NoteType)
        {
            NursingNotes nursgnote = new NursingNotes();
            string jsong = nursgnote.SaveNursgAdditionalNotesTran(ipno, NursgNotesData, notedate, notetime, userid, strInkColor, nmode, AuthYn, NoteType);
            return Json(jsong);
        }
        public JsonResult GetProKeyDescription(string ProKeyName)
        {
            NursingNotes nursgnote = new NursingNotes();
            object jsong = nursgnote.GetProKeyDescription(ProKeyName);
            return Json(jsong, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region  OTBookingRequest
        public ActionResult OTBookingRequest()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult SaveOTCathReq(string Ipno, string Mrno, string NursStation, string BedWardNo, string GridData, string GAction, string ReqNo, string SurgeryDate, string SurgeryTime, string OTCathType, string strPriority, string Remarks, string Diagnosis, string SchemeCodes,string Side) //priyanka 04/05/2026
        {
            try
            {
                NSOTCathBookReqModel mdl = new NSOTCathBookReqModel();
                var response = mdl.SaveOTCathReqMdl(Ipno, Mrno, NursStation, BedWardNo, GridData, GAction, ReqNo, SurgeryDate, SurgeryTime, OTCathType, strPriority, Remarks, Diagnosis, SchemeCodes,Side);
                return Json(response, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetSurgeryList()
        {
            try
            {
                NSOTCathBookReqModel objOTBookReq = new NSOTCathBookReqModel();
                var response = objOTBookReq.GetSurgryMaster("OT");
                return Json(response, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public string GetSurgryCatg()
        {
            NSOTCathBookReqModel objOTBookReq = new NSOTCathBookReqModel();
            return objOTBookReq.GetSurgeryCatg();
        }

        public JsonResult GetOTBookingRequestData(string RGaction = "N", string ModuleID = "", string IPNO = "", string RREQNO = "")
        {
            try
            {
                NSOTCathBookReqModel NSBOOK = new NSOTCathBookReqModel();
                NSBOOK.fillCombo();
                object jsonData = new { rows = new object[] { } }; // Default empty structure

                if (Session["NSCODE"] != null)
                {
                    NSBOOK.StrGblNursCode = Session["NSCODE"].ToString();
                }

                // Logic only runs if RGaction is NOT "N"
                if (RGaction != "N")
                {
                    DataSet ORDERDS = new DataSet();
                    NursingStationClient nurclient = new NursingStationClient();
                    string ORDERLIST = nurclient.GetOTBookRequestList("", "", RREQNO, "", IPNO, "", NSBOOK.StrGblNursCode, "", "D", "");

                    if (!string.IsNullOrEmpty(ORDERLIST))
                    {
                        StringReader theReader = new StringReader(ORDERLIST);
                        ORDERDS.ReadXml(theReader);

                        // Check Table 0 for Header Data
                        if (ORDERDS.Tables.Count > 0 && ORDERDS.Tables[0].Rows.Count > 0)
                        {
                            var TRANDATA = ORDERDS.Tables[0].Select("REQNO='" + RREQNO + "'");
                            if (TRANDATA.Length > 0)
                            {
                                NSBOOK.Priority = TRANDATA[0]["PRIORITY"].ToString().Trim();
                                NSBOOK.Remarks = TRANDATA[0]["REMARKS"].ToString().Trim();
                                NSBOOK.SurgDate = GeneralFunction.GetDate(TRANDATA[0]["SURGDATE"].ToString().Trim());
                            }
                        }

                        // Check Table 1 for Surgery Grid Data
                        if (ORDERDS.Tables.Count > 1 && ORDERDS.Tables[1].Rows.Count > 0)
                        {
                            DataTable l_oDT = ORDERDS.Tables[1].Copy();
                            jsonData = new
                            {
                                rows = (from DataRow row in l_oDT.Rows
                                        select new
                                        {
                                            CODE = (string.Empty + row["SURGCODE"]).Trim(),
                                            DESCRIPTION = (string.Empty + row["SERVNAME"]).Trim(),
                                            DOCTOR = (string.Empty + row["DOCTCODE"]).Trim(),
                                            SIDE = (string.Empty + row["SIDE"]).Trim(),
                                            REMARK = (string.Empty + row["SURGREMARK"]).Trim(),
                                        }).ToArray()
                            };
                        }
                    }
                }

                return Json(new
                {
                    Success = true,
                    Priority = NSBOOK.Priority,
                    Remarks = NSBOOK.Remarks,
                    SurgDate = NSBOOK.SurgDate,
                    SurgData = jsonData
                });
            }
            catch (Exception ex)
            {
                // Return the error as JSON so the AJAX 'error' or 'success' block can see it
                return Json(new { Success = false, Message = ex.Message });
            }
        }

        public JsonResult GetPatientOTBookings(string ipno = "", string mrno = "")
        {
            try
            {
                OncologyEMR.OT.OTClient otClient = new OncologyEMR.OT.OTClient();
                string xmlResult = otClient.GetOTBookingList("", "", "", "", "", "", "", "O", mrno, ipno, "");
                DataSet ds = new DataSet();
                if (!string.IsNullOrEmpty(xmlResult))
                {
                    ds.ReadXml(new System.IO.StringReader(xmlResult));
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        var rows = (from DataRow row in ds.Tables[0].AsEnumerable()
                                    select new
                                    {
                                        BOOKNO = row["BOOKINGNO"].ToString().Trim(),
                                        SURDATE = OncologyEMR.DataClass.GeneralFunction.GetDate(row["SURGDATE"].ToString().Trim()),
                                        SURFRM = row["SURGTIME"].ToString().Trim(),
                                        SURGERY_DESC = row["SURGERY_DESC"].ToString().Trim(),
                                        STATUS = row["STATUS"].ToString().Trim()
                                    }).ToList();
                        return Json(rows, JsonRequestBehavior.AllowGet);
                    }
                }
                return Json(new object[] { }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        #endregion

        #region TreatmentOrder
        public ActionResult TreatmentOrder()
        {
            try
            {
                TreatmentOrder treatorder = new TreatmentOrder();
                CommonServiceClient comclient = new CommonServiceClient();
                ICUClient ic = new ICUClient();
                treatorder.FillCombo(treatorder);
                ViewBag.NutritionList = treatorder.NutritionList;
                ViewBag.CurrServerTime = comclient.GetServerTime();
                ViewBag.CurrServerDate = comclient.GetServerDate();
                string xmlData = ic.GetChemoProtocol("");

                DataSet ds = new DataSet();
                ds.ReadXml(new StringReader(xmlData));
                treatorder.ChemoTemplateLst = (from DataRow row in ds.Tables["Table1"].Rows
                                               where row["STATUS"].ToString().Trim().ToUpper() == "A"
                                               select new SelectListItem
                                               {
                                                   Text = row["NAME"].ToString().Trim(),
                                                   Value = row["CODE"].ToString().Trim(),
                                                   Selected = false
                                               }).ToList();
                return View(treatorder);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public JsonResult GetTranslst(string IpNo, string strDate)
        {
            try
            {
                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                return Json(objTreatmentSheet.GetTransactionList(IpNo, strDate), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetMaxSEQNO(string IPNO)
        {
            try
            {
                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                return Json(objTreatmentSheet.RetriveMaxSEQNO(IPNO), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetInvetiLst(string strMtrl)
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.getTestList(strMtrl), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetDruglst(string searchstring, string Type, string strChecmoMedYN, string IPNO)
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.getDrugList(searchstring, Type, strChecmoMedYN, IPNO), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetInfusionData()
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.GetInfusionList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public JsonResult SaveTreatmentOrderTran(string tableMedicationData, string tableInvestigationData, string IpNo, string MrNo, string PatName, string TranctionId, string TypData, string DrVerified)
        {
            object data = "";
            //TS.VerifiedByDr = DrVerified;
            //TreatmentOrder _objTreatmentSheet = new TreatmentOrder();
            //object data = _objTreatmentSheet.SaveTreatmentSheetData(TS, action, tableMedicationData, tableNebulizationData, tableSTATOrdFilterData, tableSpeciaInstructionsData,
            //    tableBloodProductData, tableInfusionData, tableInvestigationData, tableReferralsFilterData, tableAntibioticData, tableMeicationStatOrderData, IpNo, MrNo,
            //    PatName, TranctionId, TypData, DrVerified, tableChemoAntiData, tableChemoAMediData);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetMedicineRoute()
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.GetMedicineRoutList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetDilutionVolumList()
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.GetDilutionVolumeList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetAdminiStrDur()
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.GetAdministrationDurList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetUnitList()
        {
            try
            {
                object UnitList = GeneralFunction.GetUnitList();
                return Json(UnitList, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        //20260730
        public JsonResult GetCaseDetails(string IPNo)
        {
            try
            {
                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                return Json(objTreatmentSheet.GetCaseDetailsList(IPNo), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetLatestAllergies(string Ipno)
        {
            try
            {
                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                var data = objTreatmentSheet.GetLatestAllergies(Ipno);

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                throw;
            }
        }
        //End
        public JsonResult ProcessCancellation(string TBLTYPE, string TRANNO, string SEQNO, string CANTIME)
        {
            try
            {

                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                return Json(objTreatmentSheet.UpdateCancellation(TRANNO, SEQNO, TBLTYPE, CANTIME), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetBloodProductList()
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.RetriveBloodProductList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ProcessHoldUnhold(string TBLTYPE, string TRANNO, string SEQNO, string strHoldYN, string strHoldReason, string strDrugCode, string strDrugName, string strSetNo)
        {
            try
            {
                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                return Json(objTreatmentSheet.UpdateHoldUnhold(TRANNO, SEQNO, TBLTYPE, strHoldYN, strHoldReason, strDrugCode, strDrugName, strSetNo), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetHoldUnholdLogs(string TRANNO, string SEQNO, string TBLTYPE, string strDrugCode)
        {
            try
            {
                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                return Json(objTreatmentSheet.GetHoldLog(TRANNO, SEQNO, TBLTYPE, strDrugCode), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetDoctorInfo(string Gaction)
        {
            try
            {
                TreatmentOrder objTreatmentSheet = new TreatmentOrder();
                return Json(objTreatmentSheet.GetDoctorInfo(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SaveTreatmentSheetTran(TreatmentOrder TS, string action, string tableMedicationData,
            string tableNebulizationData, string tableSTATOrdFilterData, string tableSpeciaInstructionsData, string tableBloodProductData,
            string tableInfusionData, string tableInvestigationData, string tableReferralsFilterData, string tableAntibioticData, string tableMeicationStatOrderData,
            string IpNo, string MrNo, string PatName, string TranctionId, string TypData, string DrVerified, string tableChemoAntiData, string tableChemoAMediData, string tableNutriIntake)
        {
            TreatmentOrder _objTreatmentSheet = new TreatmentOrder();
            object data = _objTreatmentSheet.SaveTreatmentSheetData(TS, action, tableMedicationData, tableNebulizationData, tableSTATOrdFilterData, tableSpeciaInstructionsData,
                tableBloodProductData, tableInfusionData, tableInvestigationData, tableReferralsFilterData, tableAntibioticData, tableMeicationStatOrderData, IpNo, MrNo,
                PatName, TranctionId, TypData, DrVerified, tableChemoAntiData, tableChemoAMediData, tableNutriIntake);
            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public JsonResult BindChemoData(string strPrtocolCD, string MRNO, string HEIGHT, string WEIGHT, string BSA, string DayNo, bool calcDose, string CycleNo)
        {
            TreatmentOrder mdl = new TreatmentOrder();
            var data = mdl.BindChemoData(strPrtocolCD, MRNO, HEIGHT, WEIGHT, BSA, DayNo, calcDose, CycleNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetProtocolCode(string MRNO)
        {
            TreatmentOrder mdl = new TreatmentOrder();
            var data = mdl.GetProtocolCode(MRNO);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetTreatmentOrderData(string TranNo, string IPNum, string IsRollover, string tsTime, string tsDate, string CallFrmAdmistrn = "N")
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();
                return Json(objTreatmentOrder.getTreatmentOrderdata(TranNo, IsRollover, IPNum, tsTime, tsDate, CallFrmAdmistrn), JsonRequestBehavior.AllowGet);
                //  return Json(objTreatmentSheet.getTreatmentSheetdataForTest(TranNo, IsRollover, IPNum), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetTSPlandList(string IPNum, string TsDate, string RecordType, string IsRollver, string callfrom, string gblNurscode, string notifYn = "N", string strTranNo = "")
        {
            try
            {
                TreatmentOrder objTreatmentOrder = new TreatmentOrder();

                return Json(objTreatmentOrder.RetriveTSPlandData(IPNum, TsDate, RecordType, IsRollver, callfrom, gblNurscode, notifYn, strTranNo), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        #region PAC IPD
        //public ActionResult PACIPD(string PatMRNO = "", string PatTRANNO = "", string Gaction = "N", string IPDPACStatus = "N", char MasterPage = 'N')
        //{
        //    PACMdl Mdl = new PACMdl();
        //    Session["FromClinic"] = "";
        //    Session["PageId"] = "PAC";
        //    Mdl.MRNO = PatMRNO;
        //    Mdl.TRANNO = PatTRANNO;
        //    Mdl.Gaction = Gaction;
        //    Mdl.BindPACDtls(Mdl);
        //    ViewBag.FormLinkRouteList = GeneralFunction.GetFormLinkRouteList();
        //    ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();
        //    OncologyModel mdl = new OncologyModel();
        //    string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
        //    ViewBag.RemarkArray = mdl.GetRemarkList("", srtUserID);
        //    ViewBag.MasterPage = MasterPage;
        //    ViewBag.IPDPACStatus = IPDPACStatus;
        //    ViewBag.PACIntake = mdl.RetriveMedicineIntake(srtUserID);
        //    return View("PACIPD", Mdl);
        //}
        public ActionResult PACIPD(string PatMRNO = "", string PatTRANNO = "", string Gaction = "N", string IPDPACStatus = "N", char MasterPage = 'N',
    string LOGYN = "N", string Type = "", string LogDT = "", string LogTM = "")
        {
            PACMdl Mdl = new PACMdl();
            Session["FromClinic"] = "";
            Session["PageId"] = "PAC";
            Mdl.MRNO = PatMRNO;
            Mdl.TRANNO = PatTRANNO;
            Mdl.Gaction = Gaction;
            Mdl.BindPACDtls(Mdl, LOGYN, PatTRANNO, LogDT, LogTM, Type);
            ViewBag.FormLinkRouteList = GeneralFunction.GetFormLinkRouteList();
            ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();
            OncologyModel mdl = new OncologyModel();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            ViewBag.RemarkArray = mdl.GetRemarkList("", srtUserID);
            ViewBag.MasterPage = MasterPage;
            ViewBag.IPDPACStatus = IPDPACStatus;
            ViewBag.PACIntake = mdl.RetriveMedicineIntake(srtUserID);
            return View("PACIPD", Mdl);
        }

        public JsonResult GetPACHistory(string MRNO)
        {
            PACMdl Mdl = new PACMdl();
            return Json(Mdl.GetPACHistoryJson(MRNO),JsonRequestBehavior.AllowGet);
        }
        #endregion

        #endregion

        #region PAC
        public ActionResult PAC(string PatMRNO = "", string PatTRANNO = "", string Gaction = "N", string IPDPACStatus = "N", char MasterPage = 'N',
    string LOGYN = "N", string Type = "", string LogDT = "N", string LogTM = "")
        {
            PACMdl Mdl = new PACMdl();
            Session["FromClinic"] = "";
            Session["PageId"] = "PAC";
            Mdl.MRNO = PatMRNO;
            Mdl.TRANNO = PatTRANNO;
            Mdl.Gaction = Gaction;
            Mdl.BindPACDtls(Mdl, LOGYN, PatTRANNO, LogDT, LogTM, Type);
            ViewBag.FormLinkRouteList = GeneralFunction.GetFormLinkRouteList();
            ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();
            OncologyModel mdl = new OncologyModel();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            ViewBag.RemarkArray = mdl.GetRemarkList("", srtUserID);
            ViewBag.MasterPage = MasterPage;
            ViewBag.PACIntake = mdl.RetriveMedicineIntake(srtUserID);
            return View(Mdl);
        }

        #endregion

        #region Patient Waiting List
        public ActionResult WaitingListPAC()
        {
            return View();
        }
        #endregion

        #region Reports

        #region OPD Clinical History
        public ActionResult OPDClinicalHistory()
        {
            OncologyModel oncomdl = new OncologyModel();
            ViewBag.DoctorList = oncomdl.GetDoctTypeList();
            return PartialView("OPDClinicalHistory");
        }
        #endregion

        #region Patient Clinical History
        public ActionResult PatientClinicalHistory()
        {
            OncologyModel oncomdl = new OncologyModel();
            ViewBag.DoctorList = oncomdl.GetDoctTypeList();
            return PartialView("PatientClinicalHistory");
        }
        #endregion

        #region Investigation Report
        public ActionResult InvestigationReport()
        {
            try
            {
                return PartialView("InvestigationReport");
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion

        #region History

        public ActionResult History()
        {
            try
            {
                return PartialView("History");
            }
            catch (Exception)
            {
                throw;
            }
        }

        public ActionResult FamilyHistory()
        {
            try
            {
                return PartialView("FamilyHistory");
            }
            catch (Exception)
            {
                throw;
            }
        }

        public ActionResult PersonalHistory()
        {
            try
            {
                return PartialView("PersonalHistory");
            }
            catch (Exception)
            {
                throw;
            }
        }

        public ActionResult MedicalHistory()
        {
            try
            {
                return PartialView("MedicalHistory");
            }
            catch (Exception)
            {
                throw;
            }
        }

        public ActionResult PatientMedicalHistory()
        {
            try
            {
                return PartialView("PatientMedicalHistory");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult AllergyHistory()
        {
            try
            {
                ViewBag.AllergyTypeLst = GeneralFunction.GetAllergyTypeList();
                return PartialView("AllergyHistory");
            }
            catch (Exception)
            {
                throw;
            }
        }
        //Added By Roshan 20/2/2026
        public ActionResult SurgicalHistory()
        {
            try
            {
                return PartialView("_SurgicalHistory");
            }
            catch (Exception)
            {
                throw;
            }
        }
        //End By Roshan 
        #endregion

        #region Outside Investigation Reports
        public ActionResult OutsideInvestReport()
        {
            OutsideInvstMdl Mdl = new OutsideInvstMdl();
            Mdl.BindPACDtls(Mdl);
            ViewBag.DoctorList = Mdl.GetDoctTypeList();

            //return PartialView("OutsideInvestReport");
            return PartialView("OutsideInvestReport", Mdl);
        }
        #endregion
        #endregion


        #region External Discharge Summary Call

        public JsonResult GetExternalDischargeSummaryUrl(string IPNo)
        {
            try
            {
                string url = Convert.ToString(GeneralFunction.GetAppsettingUnitWiseValue("URLEXTERNALDISCHARGESUMMARY"));

                if (string.IsNullOrEmpty(url))
                {
                    return Json(new { Status = "Error", Message = "Please Set Url Config for Discharge Summary" }, JsonRequestBehavior.AllowGet);
                }


                string FullUrl = url.TrimEnd('/');
                if (!string.IsNullOrEmpty(IPNo))
                {
                    FullUrl += (FullUrl.Contains("?") ? "&" : "?") + "IPNo=" + Uri.EscapeDataString(IPNo);
                }

                return Json(new { Status = "Success", Url = FullUrl }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Status = "Error", Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion
        #region Document Upload 
        public ActionResult DocumentUpload()
        {
            try
            {
                DMSDocUpload dmsdocupload = new DMSDocUpload();
                dmsdocupload.DocTypeList = dmsdocupload.GetDocumentMaster();
                return PartialView("DocumentUpload", dmsdocupload);
            }
            catch (Exception)
            {
                throw;
            }
        }
        public JsonResult GetUploadDocuments(string strBillIP, string strDocType, string strMRNo)
        {
            DMSDocUpload dmsdocupload = new DMSDocUpload();
            object status = dmsdocupload.GetDMSUploadDocuments(strBillIP, strDocType, strMRNo);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public async Task<JsonResult> PrintDMSUploadDoc(string docPath, string docName)
        {
            try
            {
                string strUnitCD = System.Web.HttpContext.Current.Session["UNITCODE"].ToString();
                string Msg = "";
                string url = Convert.ToString(GeneralFunction.GetAppsettingUnitWiseValue("URLDMSUPLOADEDDOC")) + "";
                if (url == "")
                {
                    Msg = "Please Set Url Config for print";
                    return Json(Msg, JsonRequestBehavior.AllowGet);
                }
                object[] parameters = new object[4];
                parameters[0] = strUnitCD;
                parameters[1] = docPath;
                parameters[2] = docName;
                parameters[3] = "Y"; //Speciality Reference Print 
                var response = await ExternalCallForDMSDocPrint(url, parameters);
                if (response != null)
                {
                    object[] Result = response as object[];
                    Msg = Result[0].ToString();
                    if (Result[1] != null)
                    {
                        byte[] byteArray = Convert.FromBase64String(Result[1].ToString());
                        TempData["printdata"] = byteArray;
                    }
                }
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string Msg = string.Empty;
                Msg = ex.Message;
                return Json(Msg, JsonRequestBehavior.AllowGet);
            }

        }
        public async Task<object> ExternalCallForDMSDocPrint(string UrlCall, object[] Param)
        {
            object[] obj = new object[3];
            obj[0] = string.Empty;
            obj[1] = string.Empty;
            obj[2] = string.Empty;

            try
            {
                string jsonData = JsonConvert.SerializeObject(new
                {
                    Parameters = Param
                });
                var content = new StringContent(jsonData, Encoding.UTF8, "application/json");
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
                    obj[1] = "";
                }
            }
            catch (Exception ex)
            {
                obj[0] = ex.Message;
                obj[1] = "";
            }
            return obj;
        }

        public ActionResult DisplayDMSUploadDocPrintAction(string FileName)
        {
            byte[] printdata = TempData["printdata"] as byte[];

            if (printdata == null || printdata.Length == 0)
                return Content("File not found");

            string contentType = GetContentType(FileName);

            return new BinaryContentResult(printdata, contentType, FileName);
        }
        private string GetContentType(string fileName)
        {
            string extension = Path.GetExtension(fileName).ToLower();

            switch (extension)
            {
                case ".pdf":
                    return "application/pdf";

                case ".jpg":
                case ".jpeg":
                    return "image/jpeg";

                case ".png":
                    return "image/png";

                case ".gif":
                    return "image/gif";

                case ".doc":
                    return "application/msword";

                case ".docx":
                    return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";

                case ".xls":
                    return "application/vnd.ms-excel";

                case ".xlsx":
                    return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                case ".txt":
                    return "text/plain";

                default:
                    return "application/octet-stream";
            }
        }
        #endregion

        #region attachemnt
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
                    if (file.ContentType == "application/pdf" || file.ContentType == "image/jpeg" || file.ContentType == "image/png" || file.ContentType == "application/pdf")
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
                            //fname = Regex.Replace(file.FileName, @"\s+", "");
                            fname = file.FileName.Trim();
                        }

                        // Get the complete folder path and store the file inside it.                 
                        var labpath = directory;
                        var subpath = directory + "/" + mrno;
                        var path1 = directory + "/" + mrno + "/" + fname;
                        countpath = directory + "/" + mrno + "//";
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

        //public ActionResult DeleteUploadedFile(string MrNo, string FileName)
        //{
        //    bool isDeleted = false;
        //    string message = "";

        //    try
        //    {
        //        string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
        //        string directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString()
        //                           + "/DoctDeskAttachments/" + strUnit;

        //        if (string.IsNullOrEmpty(MrNo) || string.IsNullOrEmpty(FileName))
        //        {
        //            message = "Invalid request.";
        //            return Json(new { Message = message, isDeleted = false }, JsonRequestBehavior.AllowGet);
        //        }

        //        string folderPath = Path.Combine(directory, MrNo);
        //        string filePath = Path.Combine(folderPath, FileName);

        //        if (System.IO.File.Exists(filePath))
        //        {
        //            System.IO.File.Delete(filePath);
        //            isDeleted = true;
        //            message = "File deleted successfully.";
        //        }
        //        else
        //        {
        //            message = "File not found.";
        //        }

        //        // Optional: return updated file list after deletion
        //        DataTable dtfile = new DataTable();
        //        dtfile.Columns.Add("FilePath");
        //        dtfile.Columns.Add("FileName");
        //        dtfile.Columns.Add("View");

        //        if (Directory.Exists(folderPath))
        //        {
        //            string[] filePaths = Directory.GetFiles(folderPath);

        //            foreach (string path in filePaths)
        //            {
        //                DataRow dr = dtfile.NewRow();
        //                dr["FilePath"] = path;
        //                dr["FileName"] = Path.GetFileName(path);
        //                dtfile.Rows.Add(dr);
        //            }
        //        }

        //        var jsonDatas = new
        //        {
        //            rows = (from DataRow row in dtfile.Rows
        //                    select new
        //                    {
        //                        FilePath = ("" + row["FilePath"]).Trim(),
        //                        FileName = ("" + row["FileName"]).Trim(),
        //                        View = ("" + row["View"]).Trim(),
        //                    }).ToArray()
        //        };

        //        return Json(new
        //        {
        //            Message = message,
        //            isDeleted = isDeleted,
        //            jsonData = jsonDatas
        //        }, JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        message = "Error occurred. Error details: " + ex.Message;
        //        return Json(new { Message = message, isDeleted = false }, JsonRequestBehavior.AllowGet);
        //    }
        //}


        public ActionResult DeleteUploadedFile(string MrNo, string FileName)
        {
            bool isDeleted = false;
            string message = "";

            try
            {
                if (string.IsNullOrWhiteSpace(MrNo) || string.IsNullOrWhiteSpace(FileName))
                {
                    return Json(new { Message = "Invalid request.", isDeleted = false }, JsonRequestBehavior.AllowGet);
                }

                string strUnit = Convert.ToString(Session["UNITCODE"]);

                string basePath = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString();

                string folderPath = Path.Combine(basePath, "DoctDeskAttachments", strUnit, MrNo);

                FileName = Regex.Replace(FileName, @"\s+", "");
                string filePath = Path.Combine(folderPath, FileName);

                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                    isDeleted = true;
                    message = "File deleted successfully.";
                }
                else
                {
                    message = "File not found. Path checked: " + filePath;
                }

                return Json(new { Message = message, isDeleted = isDeleted }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Message = ex.Message, isDeleted = false }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        #region Upload Examination
        public ActionResult UploadExaminationFile()
        {
            bool isUploaded = false;
            string message = "";
            int fileCount = 0;
            var countpath = "";
            var DoctCode = Convert.ToString(HttpContext.Session["gDoctCode"]);
            //var name = Request.Form["IpNo"];
            DataTable dtfile = new DataTable();
            dtfile.Columns.Add("FilePath");
            dtfile.Columns.Add("FileName");
            dtfile.Columns.Add("View");

            var directory = "";

            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/HumanBodyImg/";

            Dictionary<string, object> dc = new Dictionary<string, object>();
            if (Request.Files.Count > 0)
            {

                try
                {
                    var strDoctCode = DoctCode;

                    HttpFileCollectionBase files = Request.Files;
                    HttpPostedFileBase file = files[0];
                    if (file.ContentType == "image/jpeg" || file.ContentType == "image/png" || file.ContentType == "image/jpg")
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
                        }

                        // Get the complete folder path and store the file inside it.                 
                        var labpath = directory;
                        var subpath = directory + "/" + strDoctCode;
                        var path1 = directory + "/" + strDoctCode + "/" + fname;
                        countpath = directory + "/" + strDoctCode + "//";
                        if (strDoctCode != "")
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
                                    DirectoryInfo dis = dInfo.CreateSubdirectory(strDoctCode);
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
                                    DirectoryInfo dis = dInfo.CreateSubdirectory(strDoctCode);
                                    file.SaveAs(path1);
                                    isUploaded = true;
                                    message = "File Uploaded Successfully!";
                                    int count = Directory.GetFiles(countpath).Length;
                                }
                            }
                        }


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
                }
            }
            else
            {
                message = "No files selected.";
                dc.Add("Message", message);
                return Json(dc);
            }
        }

        public JsonResult GetUploadedExamImages(string MRNO)
        {
            DirectoryInfo salesFTPDirectory = null;
            FileInfo[] files = null;
            List<string> names = new List<string>();
            var directory = "";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            var DoctCode = Convert.ToString(HttpContext.Session["gDoctCode"]);
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/HumanBodyImg/";

            string salesFTPPath = directory + "/" + DoctCode;
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


        public FileContentResult ExamFileDownload(string MRNo, string filename, string fileType = "A")
        {
            var directory = "";
            var filepath = "";
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            var DoctCode = Convert.ToString(HttpContext.Session["gDoctCode"]);
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
                directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString() + "/HumanBodyImg/";
                filepath = directory + "/" + DoctCode + "/" + filename;
            }

            byte[] fileBytes = System.IO.File.ReadAllBytes(filepath);

            string contentType = "";
            string[] Extension = filename.Split('.');
            var FileExtension = Extension[Extension.Length - 1];
            if (FileExtension.ToLower() == "jpg" || FileExtension.ToLower() == "jpeg")
            {
                contentType = "image/jpeg";
            }
            else if (FileExtension.ToLower() == "png")
            {
                contentType = "image/png";
            }
            else
            {
                contentType = "application/" + FileExtension.ToLower();
            }
            Response.AppendHeader("Content-Disposition", "inline; filename=" + filename);
            return File(fileBytes, contentType);
        }

        public ActionResult DeleteUploadedExaminationFile(string MrNo, string FileName)
        {
            bool isDeleted = false;
            string message = "";
            string DoctCode = Convert.ToString(HttpContext.Session["gDoctCode"]);
            try
            {
                if (string.IsNullOrWhiteSpace(DoctCode) || string.IsNullOrWhiteSpace(FileName))
                {
                    return Json(new { Message = "Invalid request.", isDeleted = false }, JsonRequestBehavior.AllowGet);
                }

                string strUnit = Convert.ToString(Session["UNITCODE"]);

                string basePath = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString();

                string folderPath = Path.Combine(basePath, "HumanBodyImg", DoctCode);

                FileName = FileName.Trim();
                string filePath = Path.Combine(folderPath, FileName);

                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                    isDeleted = true;
                    message = "File deleted successfully.";
                }
                else
                {
                    message = "File not found. Path checked: " + filePath;
                }

                return Json(new { Message = message, isDeleted = isDeleted }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { Message = ex.Message, isDeleted = false }, JsonRequestBehavior.AllowGet);
            }
        }


        public JsonResult RetriveUploadedExamImages(string MrNo, string TranNo,string ConultCode = "")
        {
            try
            {
                ExaminationImages examimg = new ExaminationImages();
                List<string> Images = null;
                Images = examimg.RetriveUploadedExamImages(MrNo, TranNo, ConultCode);
                return Json(Images, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw (ex);
                //return Json(new { Status = "Failed", Result = "Something Went Wrong." }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion

        #region CKEditor Image Drag and Drop
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult DragUploadImage(HttpPostedFileBase upload)
        {
            if (upload != null && upload.ContentLength > 0)
            {
                string urlpath = "Content/TemplateImages/";
                string filename = Path.GetFileName(upload.FileName);
                string filepath = Path.Combine(Server.MapPath("~/" + urlpath), filename);
                int i = 1;
                while (System.IO.File.Exists(filepath))
                {
                    string tempFilename = Path.GetFileNameWithoutExtension(upload.FileName);
                    string extension = Path.GetExtension(upload.FileName);
                    filename = tempFilename + "_" + (i++) + extension;
                    filepath = Path.Combine(Server.MapPath("~/" + urlpath), filename);
                }
                upload.SaveAs(filepath);
                string fileUrl = Url.Content("~/" + urlpath + filename);
                return Json(new
                {
                    uploaded = 1,
                    fileName = filename,
                    url = fileUrl
                });
            }
            return Json(new { uploaded = 0, error = new { message = "Upload failed" } });
        }
        //End  - For Drag and Crop Image  in the CKEditor
        #endregion

        #region OT Booking Request List
        public JsonResult GetOTCathBookRequestList(string DTFrm, string DTto, string ReqNo, string OTCath, string IPNO, string smrno, string SNURSESTN, string status, string sType, string PatName, string ORDERTYPE, string strCrdtCompCode, string Speciality) //priyanka 05/05/2026
        {
            DataSet DS = new DataSet();
            NSOTCathBookReqModel NSPATHBOOKLST = new NSOTCathBookReqModel();
            DTFrm = DTFrm + "";
            DTto = DTto + "";
            if (smrno != null || IPNO != null)
            {
                //var dict = NSPATHBOOKLST.getOTCathOrderBookList(IPNO, ReqNo, GeneralFunction.GetDateInSpecifiedFormat(DTFrm, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD),
                //      GeneralFunction.GetDateInSpecifiedFormat(DTto, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD), status, smrno, OTCath, SNURSESTN, ORDERTYPE, PatName);

                var dict = NSPATHBOOKLST.getOTCathOrderBookList(DTFrm, DTto, ReqNo, OTCath, IPNO, smrno, SNURSESTN, status, sType, PatName, ORDERTYPE, strCrdtCompCode, Speciality);
                if (dict != null)
                    return Json(dict, JsonRequestBehavior.AllowGet);
                else
                    return Json("", JsonRequestBehavior.AllowGet);
            }
            else
                return Json("", JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Pre Auth Scheme
    
        public ActionResult SchemeAdvice(string ClinicType)
        {
            try
            {
                ViewBag.SchemeClinicType = ClinicType;
                return View();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public JsonResult GetPreAuthSchemeList(string SchemeType, string MRNo, string IPNo,string ConsultTranNo)
        {
            SchemePreAuth Mdl = new SchemePreAuth();
            var data = Mdl.GetPreAuthSchemeList(SchemeType, MRNo, IPNo, ConsultTranNo);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSchemeCodeToList(string CreditComp, string SchemeType, string SchemeCodes)
        {
            SchemePreAuth Mdl = new SchemePreAuth();
            var data = Mdl.GetSchemeCodeToList(CreditComp, SchemeType, SchemeCodes);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }

}


