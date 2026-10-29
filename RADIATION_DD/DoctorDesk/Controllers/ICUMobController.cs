using Newtonsoft.Json;
using OncologyEMR.CommonSerRef;
using OncologyEMR.DataClass;
using OncologyEMR.ICUServRef;
using OncologyEMR.Models;
using OncologyEMR.NSServRef;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;

namespace OncologyEMR.Controllers
{
    public class ICUMobController : Controller
    {
        //
        // GET: /ICUMob/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ICUReport()
        {
            TempData["PageID"] = "ICUReport";  //added on 28th may 2018
            return View();
        }

      //  public JsonResult GetNSMainFormGrid(string StrNurscode, string StrBedStatus, string StrNursName)
      //  {
      //      NursingStationClient nurCli = new NursingStationClient();
      //      DataSet dsBordDetails = new DataSet();
      //      DataTable dtBordDet = new DataTable();
      //      if (StrNurscode != Session["NSCODE"].ToString().Trim())
      //      {
      //          Session["NSIPNO"] = "";
      //      }
      //      Session["NSCODE"] = StrNurscode;
      //      Session["NSNAME"] = StrNursName;
      //      string strGetBordData = nurCli.GetNsBordList(StrNurscode, StrBedStatus);
      //      dsBordDetails.ReadXml(new XmlTextReader(new StringReader(strGetBordData)));
      //      if (dsBordDetails.Tables.Count > 0)
      //      {
      //          dtBordDet = dsBordDetails.Tables[0];
      //      }
      //      var jsonBordGrid = new
      //      {
      //          rows = (from DataRow row in dtBordDet.Rows
      //                  select new
      //                  {
      //                      cell = new string[]{
      //                         row["WARDNO"].ToString().Trim(),row["BEDNO"].ToString().Trim(),
      //                         row["IPNO"].ToString().Trim(),row["MRNO"].ToString(),row["SALUNAME"].ToString().Trim(),GeneralFunction.CheckDblToSingleQuote(row["PATNAME"].ToString()),row["PATAGE"].ToString().Trim(),
      //                         row["GENDER"].ToString(),row["ADMNDTTM"].ToString().Trim()!=""?GeneralFunction.GetDate(row["ADMNDTTM"].ToString().Substring(0,8).Trim())+" "+row["ADMNDTTM"].ToString().Substring(8).Trim():row["ADMNDTTM"].ToString().Trim()
      //                         ,row["ADMNDOCTNM"].ToString(),row["CONSDOCTOR"].ToString(),row["BEDSTATUS"].ToString().Trim(),
      //                         row["OCCUBEDCATGNM"].ToString(),
      //                         row["MLCNO"].ToString(),row["ADMNSTATUS"].ToString().Trim(),row["RESERVEDON"].ToString().Trim(),
      //                         row["PATCATGNM"].ToString().Trim(),row["COMPNAME"].ToString().Trim(),
      //                         row["INSURCMPNM"].ToString().Trim(),
      //                         row["TARIFFDESC"].ToString().Trim(),
      //                         row["NURSTNM"].ToString().Trim(),
      //                         row["BLBEDCATGNM"].ToString().Trim(),
      //                         row["DISNOTIFSTATUS"].ToString().Trim()
      //                     }
      //                  }).ToArray()
      //      };
      //      return Json(jsonBordGrid, JsonRequestBehavior.AllowGet);
      //  }

        #region Nusing Station and Patients
        public JsonResult GetNursStationsNPAtients()
        {
            ICUMobModels model = new ICUMobModels();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            var data = model.GetNursStationsNPAtients(srtUserID);
                return Json(data,JsonRequestBehavior.AllowGet);
        }
        #endregion Nusing Station and Patients

        #region Date Wise Max Temp Report
        public ActionResult DateWiseMaxTempReport()
        {
            return View();
        }
        #endregion DateWiseMaxTempReport

        #region RespiratoryAssessment
        public ActionResult RespiratoryAssessment()
        {
            return View();
        }
        #endregion RespiratoryAssessment

        #region InvestigationChart
        public ActionResult InvestigationChart()
        {
            return View();
        }
        #endregion InvestigationChart

        #region Diabetic Chart
        public ActionResult DiabeticChart()
        {
            return View();
        }
        #endregion Diabetic Chart

        #region Common Report function
        public JsonResult ICUPrint(string strIPNO, string strDate, string strTime, string ReportType, string strToDt)
        {
            ICUClient icuClient = new ICUClient();
            ICUMobModels model = new ICUMobModels();
            CriticalCareGraph criticalGrphMdl = new Models.CriticalCareGraph();
            DataSet load = new DataSet();
            object data=new object();
       
            switch (ReportType)
            {
                //case "ISBAR":
                //    load = dt.getPrintISBAR(strIPNO, strDate, strTime, CounterName);
                //    reportPath = Path.Combine(Server.MapPath("~/report"), "ISBAR.rpt");
                //    break;
                //case "NURSES NOTES":
                //    load = dt.GetNursNotePrint(strIPNO, strDate, strTime, CounterName);
                //    reportPath = Path.Combine(Server.MapPath("~/report"), "OthrNursngAss.rpt");
                //    break;
                case "RESPIRATORY":
                    data = model.GetRespiAssesPrint(strIPNO, strDate, "");
                    // reportPath = Path.Combine(Server.MapPath("~/report"), "RespiratoryAss.rpt");
                    break;

                case "DATE WISE MAX TEMP":
                    data = model.GetMaxTempList(strIPNO);
                    //if (load != null)
                    //{
                    //    if (load.Tables.Count > 0)
                    //        load.Tables[0].TableName = "MAXTEMP";
                    //}
                    //reportPath = Path.Combine(Server.MapPath("~/report"), "MaxTemp.rpt");
                    break;
                //case "NURSING ASSESSMENT":
                //    load = dt.GetNursngAss(strIPNO);
                //    reportPath = Path.Combine(Server.MapPath("~/report"), "NursingAssessment.rpt");
                //    break;
                case "INVESTIGATION":
                    data = model.GetInvestData(strIPNO, strDate, strToDt, "");   //counter name= nursing station name       
                    //reportPath = Path.Combine(Server.MapPath("~/report"), "InvestigationChart.rpt");
                    break;
                case "DIABETIC":
                    data = model.GetDiabeticData(strIPNO, strDate, strToDt, "");
                    //reportPath = Path.Combine(Server.MapPath("~/report"), "DiabeticChart.rpt");
                    break;
                //case "CRITICAL CARE GRAPH" :
                //    data = criticalGrphMdl.GetGraphDetails(strIPNO, strDate, strToDt);
                //    break;
            }

            if (data == null || data.ToString() == "")
            {               
                return Json("No Data Found");
            }
            else
            {              
                return Json(data,JsonRequestBehavior.AllowGet);
            }
        }
        #endregion Common Report function

        #region Critical care graph
        public ActionResult CriticalCareGraph1(string strIPNO, string strDate)
        {

            CriticalCareGraph g = new CriticalCareGraph();


            //g = g.GetGraphDetails(TempData["ReportIPNo"].ToString());
            g = g.GetGraphDetails(strIPNO);


            DataSet ds = g.GetGraphDetail(strIPNO, strDate);

            g.Date = (strDate).ToString();

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

                    //   Sort data
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

            if (ds.Tables.Contains("CRIT"))
                ViewData["GRIDDATA"] = JsonConvert.SerializeObject(ds.Tables["CRIT"]);
            else
                ViewData["GRIDDATA"] = null;

            if (ds.Tables.Contains("IPOP"))
            {
                if (ds.Tables["IPOP"].Rows.Count > 0)
                {
                    g.ParentalIP = Convert.ToDouble(ds.Tables["IPOP"].Rows[0][1]);
                    g.NonParentamIP = Convert.ToDouble(ds.Tables["IPOP"].Rows[1][1]);
                    g.OTIP = Convert.ToDouble(ds.Tables["IPOP"].Rows[2][1]);

                    g.TotalIP = Convert.ToDouble(g.NonParentamIP + g.ParentalIP + g.OTIP);

                    g.RTOP = Convert.ToDouble(ds.Tables["IPOP"].Rows[3][1]);
                    g.UrineOP = Convert.ToDouble(ds.Tables["IPOP"].Rows[4][1]);
                    g.UFOP = Convert.ToDouble(ds.Tables["IPOP"].Rows[5][1]);
                    g.DrainOP = Convert.ToDouble(ds.Tables["IPOP"].Rows[6][1]);
                    g.BloodOP = Convert.ToDouble(ds.Tables["IPOP"].Rows[7][1]);
                    g.OTOP = Convert.ToDouble(ds.Tables["IPOP"].Rows[8][1]);

                    g.TotalOP = Convert.ToDouble(g.RTOP + g.UrineOP + g.DrainOP + g.UFOP + g.BloodOP + g.OTOP);

                    g.Balance = Math.Round(Convert.ToDouble(g.TotalIP - g.TotalOP), 2);
                }
            }

            if (ds.Tables.Contains("ICUDAYS"))
            {
                if (ds.Tables["ICUDAYS"].Rows.Count > 0)
                {
                    g.ICUDays = Convert.ToString(ds.Tables["ICUDAYS"].Rows[0]["ICUDAY"]);
                    g.WardBedNo = ds.Tables["ICUDAYS"].Rows[0]["WARNNAME"].ToString() + " / " + ds.Tables["ICUDAYS"].Rows[0]["BEDNUMBER"].ToString();
                }
            }

            if (ds.Tables.Contains("IPOPSUM"))
            {
                if (ds.Tables["IPOPSUM"].Rows.Count > 0)
                {
                    double TotalIP = Convert.ToDouble(Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[0][1]) + Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[1][1]) + Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[2][1]));
                    double TotalOP = Convert.ToDouble(Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[3][1]) + Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[4][1]) + Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[5][1]) + Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[6][1]) + Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[7][1]) + Convert.ToDouble(ds.Tables["IPOPSUM"].Rows[8][1]));
                    g.CumulativeBal = Math.Round(Convert.ToDouble(TotalIP - TotalOP), 2);
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
                        //string strCFDate = GeneralFunction.GetDateInSpecifiedFormat(TempData["CFDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        string surgDt = GeneralFunction.GetDate(ds.Tables["CASEDET"].Rows[0]["SURGDATE"].ToString());
                        ds.Tables["CASEDET"].Rows[0]["POSTOPDAYS"] = GeneralFunction.calPostOperDays(surgDt, strDate);
                    }

                    g.PostOPDays = ds.Tables["CASEDET"].Rows[0]["POSTOPDAYS"].ToString();

                }
            }

            //Assessment of lines
            DataSet load = g.GetAssessmentOfLines(strIPNO, strDate);
            if (load.Tables.Count > 0 && load.Tables[0].Rows.Count > 0)
            {
                DataRow[] filteredRows = load.Tables[0].Select("DOI <> '' AND COND<>'' ");

                if (filteredRows.Count() > 0)
                {
                    var assessmentLinesLst = g.AssessmentLinesList();
                    var conditionLst = g.ConditionList();
                    var tubeTypeLst = g.tubeTypeLst();

                    var data = (from DataRow row in filteredRows
                                select new
                                {
                                    Shift = row["SHIFTTM"].ToString() == "E" ? "2. Evening" : row["SHIFTTM"].ToString() == "M" ? "1. Morning" : row["SHIFTTM"].ToString() == "N" ? "3. Night" : "",
                                    LINES = GetAssmntLineName(assessmentLinesLst, tubeTypeLst, row),
                                    DOI = row["DOI"].ToString(),
                                    DOR = row["DOR"].ToString(),
                                    Days = row["DAYNO"].ToString(),
                                    Condition = row["COND"].ToString().Trim() != "" ? conditionLst.Where(x => x.Value == row["COND"].ToString().Trim()).Count() > 0 ? conditionLst.Where(x => x.Value == row["COND"].ToString().Trim()).FirstOrDefault().Text : "" : ""
                                }).ToArray();

                    ViewData["ASSOFLINEDATA"] = JsonConvert.SerializeObject(data);
                }
            }
            else
                ViewData["ASSOFLINEDATA"] = null;

            //Get Max Temperature 
            DataSet dsMaxTemp = g.GetMaxTemp(strIPNO, strDate);
            if (dsMaxTemp.Tables.Count >= 1)
            {
                g.TempMax = dsMaxTemp.Tables[0].Rows[0]["VALUE"].ToString().Trim();
            }

            //Get Respiratory Assessment Data
            DataSet dsRespiratoryAss = g.GetRespiratoryAssessment(strIPNO, strDate);
            DataTable dtRespiratory = new DataTable();
            if (dsRespiratoryAss.Tables.Count > 0)
            {
                dtRespiratory = dsRespiratoryAss.Tables[0];
                dtRespiratory.TableName = "RESP";
                dtRespiratory.Columns.Add("SEQNO", typeof(int));
                for (int i = 0; i <= dtRespiratory.Rows.Count - 1; i++)
                {
                    dtRespiratory.Rows[i]["SEQNO"] = i;
                }
            }

            if (dtRespiratory.Rows.Count > 0)
            {
                DataRow[] dr = dtRespiratory.Select("[Desc] ='GCS SCALE' OR [7 AM]<>'' OR [8 AM]<>'' OR [9 AM]<>'' OR [10 AM]<>''OR [11 AM]<>''OR [12 PM]<>''OR [1 PM]<>''OR [2 PM]<>''OR [3 PM]<>''OR [4 PM]<>''OR [5 PM]<>''OR [6 PM]<>''OR [7 PM]<>''OR [8 PM]<>''OR [9 PM]<>''OR [10 PM]<>''OR [11 PM]<>''OR [12 AM]<>''OR [1 AM]<>''OR [2 AM]<>''OR [3 AM]<>''OR [4 AM]<>''OR [5 AM]<>''OR [6 AM]<>''");

                if (dr.Count() > 0)
                {
                    DataTable dt = dtRespiratory.Select("[Desc] ='GCS SCALE' OR [7 AM]<>'' OR [8 AM]<>'' OR [9 AM]<>'' OR [10 AM]<>''OR [11 AM]<>''OR [12 PM]<>''OR [1 PM]<>''OR [2 PM]<>''OR [3 PM]<>''OR [4 PM]<>''OR [5 PM]<>''OR [6 PM]<>''OR [7 PM]<>''OR [8 PM]<>''OR [9 PM]<>''OR [10 PM]<>''OR [11 PM]<>''OR [12 AM]<>''OR [1 AM]<>''OR [2 AM]<>''OR [3 AM]<>''OR [4 AM]<>''OR [5 AM]<>''OR [6 AM]<>''").CopyToDataTable();
                    dt.TableName = "RESPR";

                    DataView dv = dt.DefaultView;

                    //   Sort data
                    dv.Sort = "SEQNO";
                    //   Convert back your sorted DataView to DataTable


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


            return View(g);
        }

        private static string GetAssmntLineName(List<SelectLstItem> assessmentLinesLst, List<SelectLstItem> tubeTypeLst, DataRow row)
        {
            //string str = ((row["TUBECD"].ToString().Trim() != "") ? assessmentLinesLst.Where(x => x.Value == row["TUBECD"].ToString().Trim()).First().Text : "") + "  " + row["OTHERLINES"].ToString().Trim() + " " + ((row["SIDE"].ToString().Trim() == "L") ? "Left" : "Right") + "  " + ((row["TUBETYPE"].ToString().Trim() != "") ? tubeTypeLst.Where(x => x.Value == row["TUBETYPE"].ToString().Trim()).First().Text : "");
            //string str = ((row["TUBECD"].ToString().Trim() != "") ? assessmentLinesLst.Where(x => x.Value == row["TUBECD"].ToString().Trim()).First().Text : row["OTHERLINES"].ToString().Trim()) + "  " + ((row["SIDE"].ToString().Trim() == "L") ? "Left" : "Right") + "  " + ((row["TUBETYPE"].ToString().Trim() != "") ? tubeTypeLst.Where(x => x.Value == row["TUBETYPE"].ToString().Trim()).First().Text : "");
            //+row["TUBETYPE"].ToString().Trim() != "" ? tubeTypeLst.Where(x => x.Value == row["TUBETYPE"].ToString().Trim()).First().Text : "" + " " + row["OTHERTXT"].ToString();
            //return str;
            var tubetxt = "";
            var tubetyp = "";
            var side = "";
            if (row["TUBECD"].ToString().Trim() != "")
            {
                tubetxt = assessmentLinesLst.Where(x => x.Value == row["TUBECD"].ToString().Trim()).Count() > 0 ? assessmentLinesLst.Where(x => x.Value == row["TUBECD"].ToString().Trim()).First().Text : "";
                tubetyp = tubeTypeLst.Where(x => x.Value == row["TUBETYPE"].ToString().Trim()).Count() > 0 ? tubeTypeLst.Where(x => x.Value == row["TUBETYPE"].ToString().Trim()).First().Text : "";
                side = row["SIDE"].ToString().Trim() == "L" ? "Left" : "Right";
            }
            string str = tubetxt + "  " + " " + row["OTHERLINES"].ToString().Trim() + " " + side + "  " + tubetyp + " " + row["OTHERTXT"].ToString().Trim();
            return str;

        }

        [HttpPost]
        public JsonResult SetCritCareGraphDate(string strDate, string strIPNo)
        {
            TempData["CFDate"] = strDate;
            TempData["ReportIPNo"] = strIPNo;
            return Json("Success");
        }
        #endregion

        #region TreatmentSheetAll
        #region TreatmentSheet

        public ActionResult TreatmentSheet()
        {
            TreatmentSheet ts = new TreatmentSheet();
            return View(ts);
        }

        public JsonResult GetDoctorInfo(string Gaction)
        {
            try
            {
                TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetDruglst(string searchstring)
        {
            try
            {
                TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json(objTreatmentSheet.getDrugList(searchstring), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        //public JsonResult GetTranslst(string IpNo)
        //{
        //    try
        //    {
        //        TreatmentSheet objTreatmentSheet = new TreatmentSheet();
        //        return Json(objTreatmentSheet.GetTransactionList(IpNo), JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
        //        Response.StatusDescription = ex.Message;
        //        return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
        //    }
        //}


        public JsonResult GetVrifyTransaction(string TranNo)
        {
            try
            {
                TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json(objTreatmentSheet.VrifyTransactionData(TranNo), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        #endregion


        # region TreatmentSheetDetails
        public ActionResult TreatmentSheetDetails(string MediName, string MediCode, string TreatsheetType)
        {
            ViewBag.MedicineName = MediName;
            ViewBag.MediCode = MediCode;
            ViewBag.TrentSheetType = TreatsheetType;
            return View();
        }

        public JsonResult SaveTreatmentSheetTran(string action, string tableData, string IpNo, string MrNo, string PatName, string TranctionId)
        {
            IPInfusion _objTreatmentSheet = new IPInfusion();
            object status = "";// _objTreatmentSheet.SaveTreatmentSheetData(_objTreatmentSheet, action, "", "", "", "", "", tableData, "", "", "", "", IpNo, MrNo, PatName, TranctionId);	
            return Json(status, JsonRequestBehavior.AllowGet);
        }//	


        public JsonResult GetMedicineRoute()
        {
            try
            {
                TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json(objTreatmentSheet.GetMedicineRoutList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        //public JsonResult GetTreatmentSheetData(string TranNo, string IPNum, string IsRollover)
        //{
        //    try
        //    {
        //        TreatmentSheet objTreatmentSheet = new TreatmentSheet();
        //        return Json(objTreatmentSheet.getTreatmentSheetdata(TranNo, IsRollover, IPNum), JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
        //        Response.StatusDescription = ex.Message;
        //        return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
        //    }
        //}

        //public JsonResult GetMedicineType()
        //{
        //    try
        //    {
        //        TreatmentSheet objTreatmentSheet = new TreatmentSheet();
        //        return Json(objTreatmentSheet.GetMedicineType(), JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
        //        Response.StatusDescription = ex.Message;
        //        return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
        //    }
        //}

        #endregion

        # region TreatmentSheetlist
        public ActionResult TreatmentSheetList(string TreatsheetType)
        {
            ViewBag.TrentSheetType = TreatsheetType;
            return View();
        }

        public JsonResult TSRefillMedicine(string strTranNO, string strMRNo, string strTYEPCode, string strIPNo, string strPatName)
        {
            TreatmentSheet objTreatmentSheet = new TreatmentSheet();
            string strResult = objTreatmentSheet.TSRefillMedicine(strTranNO, strMRNo, strTYEPCode, strIPNo, strPatName);
            return Json(true, JsonRequestBehavior.AllowGet);
        }
        # endregion

        # region TreatmentSheetTestlist
        public ActionResult TreatmentSheetTestList(string TreatsheetType)
        {
            ViewBag.TrentSheetType = TreatsheetType;
            return View();
        }

        //public JsonResult GetInvetiLst(string searchstring)
        //{
        //    try
        //    {
        //        TreatmentSheet objTreatmentSheet = new TreatmentSheet();
        //        return Json(objTreatmentSheet.getTestList(searchstring), JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
        //        Response.StatusDescription = ex.Message;
        //        return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
        //    }
        //}


        public JsonResult GetTestTimingList()
        {
            try
            {
                TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json(objTreatmentSheet.GetTestTimeList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult SaveTreatsheetTestData(string strtableTestData, string strMRNO, string strIpNo, string strTranNO, string stringPatName)
        {
            TreatmentSheet _objTreatmentSheet = new TreatmentSheet();
            object status = _objTreatmentSheet.SaveTrmnStTestData(strtableTestData, strMRNO, strIpNo, strTranNO, stringPatName);
            return Json(status, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetMedicineTretSheetList(string strTranNo, string strRollOverYN, string strIPNO, string strType, string TableTypeCode)
        {
            try
            {
                TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json(objTreatmentSheet.getTSMedicineData(strTranNo, strRollOverYN, strIPNO, strType, TableTypeCode), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetMedicineDetailsList(string strTranNo, string strRollOverYN, string strIPNO, string strType, string TableTypeCode, string MedicinCode)
        {
            try
            {
                TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json(objTreatmentSheet.getTSMedicineDetails(strTranNo, strRollOverYN, strIPNO, strType, TableTypeCode, MedicinCode), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        # endregion

        #region Refferal DoctorList
        public ActionResult TSDoctorList(string TreatsheetType)
        {
            ViewBag.TrentSheetType = TreatsheetType;
            return View();
        }

        public JsonResult SaveTreatsheetDoctData(string strtableTestData, string strMRNO, string strIpNo, string strTranNO, string stringPatName)
        {
            TreatmentSheet _objTreatmentSheet = new TreatmentSheet();
            object status = _objTreatmentSheet.SaveTrmnSTDoctData(strtableTestData, strMRNO, strIpNo, strTranNO, stringPatName);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region TreatmentInfusion
        public ActionResult TSInfusion(string TreatsheetType)
        {
            ViewBag.TrentSheetType = TreatsheetType;
            return View();
        }

        public JsonResult SaveTreatsheetInfusionData(string strInfusionDTtable, string strMRNO, string strIpNo, string strTranNO, string stringPatName)
        {
            TreatmentSheet _objTreatmentSheet = new TreatmentSheet();
            object status = _objTreatmentSheet.SaveTreatsheetInfusionData(strInfusionDTtable, strMRNO, strIpNo, strTranNO, stringPatName);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        #endregion TreatmentInfusion

        #endregion TreatmentSheetAll

        #region InvestigateReport
        public ActionResult InvestigationReport()
        {
            return View();
        }

        public JsonResult GetInvestReportData(string strIPNO, string strDate, string strToDt)
        {
            try
            {
                ICUMobModels model = new ICUMobModels();

                object jsonData = model.GetInvestResult(strIPNO, strDate, strToDt, "");
                return Json(jsonData, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion

        //26-11-19 start

        #region IP medication
        public ActionResult IPMedication()
        {
            OncologyModel mdl = new OncologyModel();
            IPMedication objTreatmentSheet = new IPMedication();
            string srtUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            ViewBag.RemarkArray = mdl.GetRemarkList(Session["ClinicCode"].ToString().Trim(), srtUserID);//
            ViewBag.MedRoute = GeneralFunction.MedicineRouteRX();//
            return View(objTreatmentSheet);
        }
        public JsonResult GetDilutionVolumList()
        {
            try
            {
                IPMedication objTreatmentSheet = new IPMedication();
                return Json(objTreatmentSheet.GetDilutionVolumeList(), JsonRequestBehavior.AllowGet);
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
                IPMedication objTreatmentSheet = new IPMedication();
                return Json(objTreatmentSheet.GetAdministrationDurList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetMedicineType()
        {
            try
            {
                IPMedication objTreatmentSheet = new IPMedication();
                return Json(objTreatmentSheet.GetMedicineType(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SaveTreatmentIPMedication(IPMedication TS, string action, string tableMedicationData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy, string statMed)
        {
            IPMedication inf = new IPMedication();
            object data = inf.SaveIPMedTreatmentSheetData(TS, action, tableMedicationData, IpNo, MrNo, PatName, TranctionId, Prov, Allergy, statMed);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        //public JsonResult GetTSPlandList(string IPNum, string TsDate, string RecordType, string IsRollver, string NurseCode)
        //{
        //    try
        //    {
        //        IPMedication objTreatmentSheet = new IPMedication();
        //        return Json(objTreatmentSheet.RetriveTSPlandData(IPNum, TsDate, RecordType, IsRollver, NurseCode), JsonRequestBehavior.AllowGet);
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
        //        Response.StatusDescription = ex.Message;
        //        return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
        //    }
        //}
        #endregion

        #region IPInfusion
        public ActionResult IPInfusion()
        {
            CommonServiceClient comser = new CommonServiceClient();
            IPInfusion inf = new IPInfusion();
            ViewBag.CurrServerTime = comser.GetServerTime();
            ViewBag.CurrServerDate = comser.GetServerDate();
            return View(inf);
        }
        public JsonResult GetInfusionData()
        {
            try
            {
                IPInfusion objTreatmentSheet = new IPInfusion();
                return Json(objTreatmentSheet.GetInfusionList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SaveTreatmentIPInfu(IPInfusion TS, string action, string tableData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            IPInfusion inf = new IPInfusion();
            object data = inf.SaveTreatmentSheetinfuData(TS, action, tableData, IpNo, MrNo, PatName, TranctionId, Prov, Allergy);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetTranslst(string IpNo, string strDate)
        {
            try
            {
                IPInfusion objTreatmentSheet = new IPInfusion();
                return Json(objTreatmentSheet.GetTransactionList(IpNo, strDate), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion
        #region IPStatOrders
        public ActionResult IPStatOrders()
        {

            return View();
        }
        #endregion
        #region IVsuplement
        public ActionResult IVsuplement()
        {
            CommonServiceClient comser = new CommonServiceClient();

            ViewBag.CurrServerTime = comser.GetServerTime();
            ViewBag.CurrServerDate = comser.GetServerDate();

            return View();
        }
        public JsonResult SaveTreatmentIVSuplmnt(IVsupplement TS, string action, string tableSpeciaInstructionsData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            IVsupplement inf = new IVsupplement();
            object data = inf.SaveIVTreatmentSheetData(TS, tableSpeciaInstructionsData, action, IpNo, MrNo, PatName, TranctionId, Prov, Allergy);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region BloodProduct
        public ActionResult BloodProduct()
        {
            CommonServiceClient comser = new CommonServiceClient();
            BloodProduct objBlood = new BloodProduct();
            ViewBag.CurrServerTime = comser.GetServerTime();
            ViewBag.CurrServerDate = comser.GetServerDate();
            return View(objBlood);
        }
        public JsonResult GetBloodProductList()
        {
            try
            {
                BloodProduct objTreatmentSheet = new BloodProduct();
                return Json(objTreatmentSheet.RetriveBloodProductList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult SaveTreatmentBloodProduct(BloodProduct TS, string action, string tableBloodProductData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            BloodProduct inf = new BloodProduct();
            object data = inf.SaveBloodProductTreatmentSheetData(TS, action, tableBloodProductData, IpNo, MrNo, PatName, TranctionId, Prov, Allergy);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region NonDrugOrder
        public ActionResult NonDrugOrder()
        {
            NonDrugOrder non = new NonDrugOrder();
            non.FillCombo(non);
            return View(non);
        }
        public JsonResult SaveTreatmentNoNDrug(NonDrugOrder TS, string action, string IpNo, string MrNo, string PatName, string TranctionId)
        {
            NonDrugOrder inf = new NonDrugOrder();
            object data = inf.SaveTreatmentNoNDrugMdl(TS, action, IpNo, MrNo, PatName, TranctionId);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region IPInvestigation
        public ActionResult IPInvestigation()
        {
            IPInvestigation inf = new IPInvestigation();
            inf.FillCombo(inf);
            return View(inf);
        }
        public JsonResult GetInvetiLst(string searchstring)
        {
            try
            {
                IPInvestigation objTreatmentSheet = new IPInvestigation();
                return Json(objTreatmentSheet.RetriveTestList(searchstring), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }

        }
        public JsonResult SaveTreatmentIpInVestigation(string action, string tableInvest, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy, string NutIntake, string DoctorRemark, string VolSuplmnt)
        {
            IPInvestigation inf = new IPInvestigation();
            object data = inf.SaveTreatmentIpInVestigation(action, tableInvest, IpNo, MrNo, PatName, TranctionId, Prov, Allergy, NutIntake, DoctorRemark, VolSuplmnt);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region IPReferrals
        public ActionResult IPReferrals()
        {

            CommonServiceClient comser = new CommonServiceClient();

            IPReferrals non = new IPReferrals();
            ViewBag.CurrServerTime = comser.GetServerTime();
            ViewBag.CurrServerDate = comser.GetServerDate();
            non.FillCombo(non);
            return View(non);
        }
        public JsonResult SaveTreatmentReferral(IPReferrals TS, string action, string tableReferralsFilterData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            IPReferrals inf = new IPReferrals();
            object data = inf.SaveReferralTreatmentSheetData(TS, action, tableReferralsFilterData, IpNo, MrNo, PatName, TranctionId, Prov, Allergy);
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        #endregion

        //public string RedirectToDicom(string mrNo)
        //{
        //    return "http://103.59.215.74:8081/SampleViewer/index?mrno=" + mrNo;  //Meenakshi path for thane dicom
        //}
        public JsonResult GetDoctorInfoNew(string Gaction)
        {
            try
            {
                IPReferrals objTreatmentSheet = new IPReferrals();
                return Json(objTreatmentSheet.GetDoctorInfo(), JsonRequestBehavior.AllowGet);
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
                IPReferrals objTreatmentSheet = new IPReferrals();
                return Json(objTreatmentSheet.RetriveMaxSEQNO(IPNO), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetSpecilizationbyCode()
        {
            try
            {
                IPReferrals objTreatmentSheet = new IPReferrals();
                return Json(objTreatmentSheet.GetSpecilizationList(), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult GetTreatmentSheetData(string TranNo, string IPNum, string IsRollover, string tsTime, string tsDate, string NurseCode)
        {
            try
            {
                ICUMobModels ICUmodel = new ICUMobModels();
                // TreatmentSheet objTreatmentSheet = new TreatmentSheet();
                return Json(ICUmodel.getTreatmentSheetdata(TranNo, IsRollover, IPNum, tsTime, tsDate, NurseCode), JsonRequestBehavior.AllowGet);
                //  return Json(objTreatmentSheet.getTreatmentSheetdataForTest(TranNo, IsRollover, IPNum), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult ProcessCancellation(string TBLTYPE, string TRANNO, string SEQNO, string CANTIME)
        {
            try
            {
                ICUMobModels ICUmodel = new ICUMobModels();
                return Json(ICUmodel.UpdateCancellation(TRANNO, SEQNO, TBLTYPE, CANTIME), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public JsonResult GetCaseDetails(string IPNo)
        {
            try
            {
                IPInfusion inf = new IPInfusion();
                return Json(inf.GetCaseDetailsList(IPNo), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.StatusDescription = ex.Message;
                return Json(new { Message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        //end by  26-11-19
    }
}
