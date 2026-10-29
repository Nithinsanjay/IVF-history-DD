using Newtonsoft.Json;
using NReco.PdfGenerator;
using OncologyEMR.DataClass;
using OncologyEMR.Oncology;
using OncologyEMR.Pdf;
using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using OncologyEMR.CommonSerRef;
//using OncologyEMR.SecRefServ;
using System.Xml;
using System.Text.RegularExpressions;
using System.Text;
using System.Web.UI.WebControls;
//using OncologyEMR.PISServRef;
using OncologyEMR.OPServRef;
using System.Net;
using System.Configuration;
using OncologyEMR.OncologyServRef;
using OncologyEMR.ILisInterface;
using OncologyEMR.ICUServRef;
using BL_GeneralFunctionsSelectLstThreeItem = OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstThreeItem;
using System.Xml.Linq;

namespace OncologyEMR.Models
{
    public class FamilyHis
    {
        public string NAME { get; set; }
        public string AGE { get; set; }
        public string RELATION { get; set; }
        public string RELATIONDESC { get; set; }
        public string STATUS { get; set; }
        public string DISEASES { get; set; }
        public string DURATION { get; set; }
        public string DURTYPE { get; set; }
        public string REMARKS { get; set; }
    }

    public class ICDUserCntrlMdl
    {
        public string Code { get; set; }
        public string Text { get; set; }

        public object GETICDLIST(string name)
        {
            //object jsonData = string.Empty;
            ////CommonServiceClient comserv = new CommonServiceClient();
            //OncologyEMRClient client = new OncologyEMRClient();

            //DataSet load = new DataSet();
            //DataTable l_oDT = new DataTable();
            //load.ReadXml(new XmlTextReader(new StringReader((client.GetICDList(name)))));
            //if (load.Tables.Count > 0)
            //    l_oDT = load.Tables["Table"];
            //if (l_oDT.Rows.Count > 0)
            //{
            //    jsonData = new
            //    {
            //        rows = (from DataRow row in l_oDT.Rows
            //                select new
            //                {
            //                    ICDCODE = ("" + row["ICODE"]).Trim(),
            //                    ICDNAME = ("" + row["INAME"]).Trim(),
            //                    ICDTYPE = ("" + row["INDEXTYPE"]).Trim(),
            //                }).ToArray()
            //    };
            //}
            //return jsonData;
            return "";
        }
    }

    public class OncologyModel : BL_Oncology
    {
        //CommonServiceClient com = new CommonServiceClient();
        OncologyEMRClient client = new OncologyEMRClient();

        public List<string> lstNotes { get; set; }
        public List<string> lstLastVisit { get; set; }
        public List<FamilyHis> lstFamilyHis { get; set; }
        public List<string> lstMedicine { get; set; }
        public List<string> lstComplaint { get; set; }
        //public List<BL_GeneralFunctionsSelectLstItem> selListComp;
        public string Imgsrc { get; set; }
        public string PatCatGcd { get; set; }
        public string PreWeight { get; set; }
        public string MainCompSel { get; set; }

        public string StrLabType { get; set; }
        public string Testlst { get; set; }
        public IEnumerable<OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstItem> TestList { get; set; }
        public IEnumerable<OncologyEMR.Oncology.ServMainGrp> ServiceGrpLst { get; set; } // added by vijeta on 2nd may 2018

        public void GetPatHist(string strConsNo, OncologyModel clOncoMod)
        {
            try
            {
                // OncologyModel clOncoMod = new OncologyModel();
                //OncologyEMRClient client = new OncologyEMRClient();
                DataSet ds = new DataSet();
                List<string> lstNote = new List<string>();
                List<string> lastVisit = new List<string>();
                List<string> Medicine = new List<string>();

                //clOncoMod.selListComp = client.GetMainComplaintList();

                List<FamilyHis> lstFamilyHst = new List<FamilyHis>();
                ds.ReadXml(new StringReader(client.GetPatHist(strConsNo, "", "")));
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    clOncoMod.ConsNo = Convert.ToString(dr["CONSNO"]);
                    clOncoMod.MRNO = Convert.ToString(dr["MRNO"]);
                    clOncoMod.PatName = Convert.ToString(dr["SALNAME"]) + " " + Convert.ToString(dr["PATNAME"]);
                    clOncoMod.DOB = GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"]).Trim());
                    clOncoMod.Age = Convert.ToString(dr["PATAGE"]);
                    clOncoMod.Gender = GeneralFunction.GetPatGender(Convert.ToString(dr["PATSEX"]).Trim());
                    clOncoMod.PatAdd = Convert.ToString(dr["PATADD"]);
                    clOncoMod.PatCatg = Convert.ToString(dr["PATCATG"]); //GeneralFunction.GetPatCatg().Where(x => x.Value == Convert.ToString(dr["PATCATG"])).First().Text;
                    clOncoMod.PatCatGcd = Convert.ToString(dr["PATCATG"]);
                    clOncoMod.DoctorCode = Convert.ToString(dr["DOCTCODE"]);
                    clOncoMod.DoctorName = "Dr. " + Convert.ToString(dr["DOCTNAME"]);
                    clOncoMod.CompName = ""; //Convert.ToString(dr["COMPNAME"]);
                    clOncoMod.MobileNo = Convert.ToString(dr["PATPHONE"]);
                    clOncoMod.ContactNo = "";// Convert.ToString(dr["CONTACTNO"]);
                    clOncoMod.Email = Convert.ToString(dr["PATEMAIL"]);
                    clOncoMod.Imgsrc = (DBNull.Value.Equals(dr["PATPHOTO"]) || dr["PATPHOTO"].Equals(string.Empty)) ? "../../Images/NoPreview.png" : "data:image/png;base64," + Convert.ToBase64String((byte[])dr["PATPHOTO"]);
                    clOncoMod.TranMode = clOncoMod.TranMode;
                }
                if (ds.Tables.Count > 1)
                {
                    //foreach (DataRow dr in ds.Tables[2].Rows)
                    //{
                    //    lstNote.Add(dr["NOTES"].ToString());
                    //}
                    foreach (DataRow dr in ds.Tables[1].Rows)
                    {
                        lastVisit.Add(GeneralFunction.GetUIDateFormat(dr["CONSDATE"].ToString(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY) + "," + dr["CONSNO"].ToString() + "," + dr["CONSDATE"].ToString());
                    }

                    for (int i = 0; i < 15; i++)//for Treatment
                    {
                        FamilyHis clfamily = new FamilyHis();
                        //if (ds.Tables[3].Rows.Count > i)
                        //{
                        //    clfamily.NAME = "" + Convert.ToString(ds.Tables[3].Rows[i]["NAME"]);
                        //    clfamily.AGE = Convert.ToString(ds.Tables[3].Rows[i]["AGE"]);
                        //    clfamily.RELATION = Convert.ToString(ds.Tables[3].Rows[i]["RELATION"]);
                        //    clfamily.RELATIONDESC = GeneralFunction.GetRelation().Where(x => x.Value == Convert.ToString(ds.Tables[3].Rows[i]["RELATION"])).FirstOrDefault().Text;
                        //    clfamily.STATUS = Convert.ToString(ds.Tables[3].Rows[i]["STATUS"]);
                        //    clfamily.DURATION = Convert.ToString(ds.Tables[3].Rows[i]["DURATION"]);
                        //    clfamily.DURTYPE = Convert.ToString(ds.Tables[3].Rows[i]["DURTYPE"]);
                        //    clfamily.DISEASES = Convert.ToString(ds.Tables[3].Rows[i]["DISEASES"]);
                        //    clfamily.REMARKS = Convert.ToString(ds.Tables[3].Rows[i]["REMARKS"]);
                        //}
                        //else
                        // {
                        clfamily.NAME = "";
                        clfamily.AGE = "";
                        clfamily.RELATION = "";
                        clfamily.STATUS = "";
                        clfamily.DURATION = "";
                        clfamily.DURTYPE = "";
                        clfamily.DISEASES = "";
                        clfamily.REMARKS = "";
                        // }
                        lstFamilyHst.Add(clfamily);
                    }
                    //foreach (DataRow row in ds.Tables[4].Rows)//for medicine
                    //{
                    //    string strTake = "";
                    //    string strTake1 = row["INT1"].ToString() == "N" ? "0" : "1";
                    //    string strTake2 = row["INT2"].ToString() == "N" ? "0" : "1";
                    //    string strTake3 = row["INT3"].ToString() == "N" ? "0" : "1";
                    //    string strTake4 = row["INT4"].ToString() == "N" ? "0" : "1";
                    //    string strTake5 = row["INT5"].ToString() == "N" ? "0" : "1";
                    //    strTake = strTake1 + "-" + strTake2 + "-" + strTake3 + "-" + strTake4 + "-" + strTake5;

                    //    string str = row["DRUGNM"].ToString().PadRight(row["DRUGNM"].ToString().Length + 4) + row["DOSSAGE"].ToString().PadRight(row["DOSSAGE"].ToString().Length + 4) + row["DAYS"].ToString().PadRight(row["DAYS"].ToString().Length + 4) + strTake;
                    //    Medicine.Add(str);

                    //}
                    clOncoMod.PreWeight = "0.00";
                    //foreach (DataRow row in ds.Tables[5].Rows)//for prevweight
                    //{
                    //    clOncoMod.PreWeight = Convert.ToString(row["WEIGHT"]);

                    //}

                    clOncoMod.lstFamilyHis = lstFamilyHst;
                    clOncoMod.lstLastVisit = lastVisit;
                    clOncoMod.lstNotes = lstNote;
                    clOncoMod.lstMedicine = Medicine;
                }

            }
            catch (Exception ex)
            {

                throw;
            }

        }

        public object GetPatientMedicalHistory(string sMRNo, int sDays)
        {
            CommonServiceClient ComClient = new CommonServiceClient();
            JavaScriptSerializer ser = new JavaScriptSerializer();
            ser.MaxJsonLength = int.MaxValue;
            DataSet load = new DataSet();
            load = GeneralFunction.FillDatasetXMl(ComClient.GetPatientMediHistory(sMRNo, sDays));

            if (load.Tables.Count == 0)
            {
                return ser.Serialize("");
            }
            else
            {
                var PatData = (from DataRow row in load.Tables[0].Rows
                               select new
                               {
                                   TYPE = row["TYPE"].ToString().Trim(),
                                   DT = GeneralFunction.GetUIDateFormat(row["DT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
                                   IPNO = row["IPNO"].ToString().Trim(),
                                   DOCTOR = row["DOCTOR"].ToString().Trim(),
                                   COMPLAINT = row["COMPLAINT"].ToString().Trim(),
                                   DIAGNOSIS = row["DIAGNOSIS"].ToString().Trim(),
                                   CNTRNAME = row["CNTRNAME"].ToString().Trim(),
                                   VISITTYPE = row["VISITTYPE"].ToString().Trim(),
                               }).ToList();
                return ser.Serialize(PatData);
            }
        }

        public object GetServiceSearchInfo()
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstItem> servlst;
            servlst = comser.GetTest();
            SelectList LstService = new SelectList((from a in servlst
                                                    select new
                                                    {
                                                        ServiceCode = a.Value,
                                                        ServiceName = a.Text,
                                                    }).ToList(), "ServiceCode", "ServiceName");
            //.PadRight(100, ' ') + "," + a.Value.PadLeft(20, ' ')
            return LstService;
        }
        public Dictionary<object, object> GetTranData(string strTranNo, string MRNo, string DoctorCode, string imgsrc)
        {
            try
            {
                Dictionary<object, object> dict = new Dictionary<object, object>();

                OncologyEMRClient client = new OncologyEMRClient();
                DataSet ds = new DataSet();
                ds.ReadXml(new StringReader(client.GetTranData(strTranNo, MRNo, DoctorCode)));
                dict.Add("Status", "Success");
                var trandate = GeneralFunction.GetDate(ds.Tables[0].Rows[0]["TRANDATE"].ToString().Trim());
                ds.Tables[0].Rows[0]["TRANDATE"] = trandate.ToString().Trim();
                dict.Add("PatHeadData", JsonConvert.SerializeObject(ds.Tables[0]));
                dict.Add("PresComp", JsonConvert.SerializeObject(ds.Tables[1]));
                dict.Add("PerAddict", JsonConvert.SerializeObject(ds.Tables[2]));
                dict.Add("PerMedical", JsonConvert.SerializeObject(ds.Tables[3]));
                dict.Add("FamilyHst", JsonConvert.SerializeObject(ds.Tables[4]));
                dict.Add("Treatment", JsonConvert.SerializeObject(ds.Tables[5]));
                dict.Add("Invest", JsonConvert.SerializeObject(ds.Tables[6]));
                dict.Add("Notes", JsonConvert.SerializeObject(ds.Tables[7]));
                dict.Add("TreatmentRec", JsonConvert.SerializeObject(ds.Tables[8]));
                //dict.Add("PatCatgNm", GeneralFunction.GetPatCatg().Where(x => x.Value == Convert.ToString(ds.Tables[0].Rows[0]["PATCATG"])).First().Text);
                if (System.IO.File.Exists(imgsrc))
                {
                    byte[] imageArray = System.IO.File.ReadAllBytes(imgsrc);
                    dict.Add("ExamImgSrc", Convert.ToBase64String(imageArray));
                }
                else
                {
                    dict.Add("ExamImgSrc", "");
                }
                return dict;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public object GetDoctorDeskMdlData(string tranno, string type, string MrNo, string language)
        {
            OncologyEMRClient oncclnt = new OncologyEMRClient();
            string[] filepath = { };
            DataSet load = new DataSet();
            DataSet ds1 = new DataSet();
            DataTable dt = new DataTable();
            DataTable dt1 = new DataTable();
            DataTable dt2 = new DataTable();
            DataTable dt3 = new DataTable();
            DataTable dt4 = new DataTable();
            DataTable dt5 = new DataTable();
            DataTable dt6 = new DataTable();
            DataTable dt7 = new DataTable();
            DataTable dt8 = new DataTable();
            DataTable dt9 = new DataTable();
            DataTable dt10 = new DataTable();
            DataTable dt11 = new DataTable();
            DataTable dtFrDoctDetls = new DataTable();
            string json = "";

            AdminSevRef.AdministrationClient common = new AdminSevRef.AdministrationClient();
            if (type == "LeftMenu")
                json = oncclnt.GetDoctDesk(tranno, "S", MrNo);
            else
                json = oncclnt.GetDoctDesk(tranno, "L", MrNo);

            load = GeneralFunction.FillDatasetXMl(json);
            //added on 23rd aug 2018
            var strDoctCD = "";
            if (load.Tables.Contains("PATDETAILS"))
            {
                strDoctCD = load.Tables["PATDETAILS"].Rows[0]["DOCTCODE"].ToString().Trim();
            }
            else
            {
                strDoctCD = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            }
            string jsonDoctDetails = oncclnt.GetDoctDetails(strDoctCD);

            ds1 = GeneralFunction.FillDatasetXMl(jsonDoctDetails);

            filepath = GetExaminationFile(tranno, MrNo);

            Dictionary<string, object> dict = new Dictionary<string, object>();
            object jsonFreeComplaints = "";//vijeta 18th march19
            object jsonComplaints = "";
            object jsonVital = "";
            object jsonExam = "";
            object jsonDiagnosis = "";
            object jsonAdvice = "";
            object jsonInvstg = "";
            object jsonUserdtls = "";
            object jsonFamilyHist = "";
            object jsonPersonalHist = "";
            object jsonMedicineHist = "";
            object jsonFollowUp = "";
            object jsonPatientAdvice = "";
            object jsonDoctorDetails = "";
            object jsonFreeInvestigation = "";
            object jsonFreeFamily = "";
            object jsonFreePersonal = "";
            object jsonFreeMedical = "";
            object jsonstrTranNo = tranno;
            object jsonAllergy = "";
            object jsonICDiagnosis = "";
            object jsonICDODiagnosis = "";
            object jsonPastHist = "";
            object jsonICDTopology = "";
            object jsonICDHistology = "";
            object jsonFreeAdvice = "";
            object jsonChemoPlan = "";
            object jsonRefDoctNote = "";
            object jsonClinicalHist = "";
            object jsonSchemeData = "";
            object jsonProvDiagnosis = "";
            string AdvTranNo = tranno;
            bool ChemoFlag = false;
            if (load.Tables.Count > 0)
            {
                DataSet SchemeDS = GeneralFunction.FillDatasetXMl(common.GetSchemeMstList("", ""));
                if (load.Tables.Contains("COMPLAINTS"))
                {
                    dt = load.Tables["COMPLAINTS"];
                    //if (dt.Columns.Contains("FREECOMPLAINT"))
                    //{
                    //    jsonComplaints = (from DataRow row in dt.AsEnumerable()
                    //                      select new
                    //                      {

                    //                          FREECOMPLAINT = row["FREECOMPLAINT"].ToString().Trim(),
                    //                      }).ToArray();
                    //}
                    //else
                    // {
                    jsonComplaints = (from DataRow row in dt.AsEnumerable()
                                      select new
                                      {

                                          TRANNO = row["TRANNO"].ToString().Trim(),
                                          MRNO = row["MRNO"].ToString().Trim(),
                                          DESCCD = row["DESCCD"].ToString().Trim(),
                                          DURATION = row["DURATION"].ToString().Trim(),
                                          DURTYPE = row["DURTYPE"].ToString().Trim(),
                                          REMARKS = row["REMARKS"].ToString().Trim(),
                                          GRPCD = row["GRPCD"].ToString().Trim(),
                                          NAME = (language == ("HINDI") || language == ("MARATHI") || language == ("GUJRATI")) ? row[language].ToString().Trim() == "" ? row["NAME"].ToString().Trim() : row[language].ToString().Trim() : row["NAME"].ToString().Trim(),
                                      }).ToArray();
                    //}
                    //return jsonData1;
                }
                if (load.Tables.Contains("FREECOMPLAINT"))
                {
                    dt = load.Tables["FREECOMPLAINT"];

                    jsonFreeComplaints = (from DataRow row in dt.AsEnumerable()
                                          select new
                                          {
                                              FREECOMPLAINT = row["FREECMPLNT"].ToString().Trim(),
                                          }).ToArray();

                }
                if (load.Tables.Contains("VITALS"))
                {
                    dt1 = load.Tables["VITALS"];
                    jsonVital = (from DataRow row in dt1.AsEnumerable()
                                 select new
                                 {
                                     WEIGHT = row["WEIGHT"].ToString().Trim(),
                                     HEIGHT = row["HEIGHT"].ToString().Trim(),
                                     TEMP = row["TEMP"].ToString().Trim(),//decimal.TryParse(row["TEMP"].ToString(), out decimal temp) ? temp.ToString("0.##") : row["TEMP"].ToString().Trim(), //Abhishesh || 20260704
                                     PULSE = row["PULSE"].ToString().Trim(),
                                     RESP = row["RESP"].ToString().Trim(),
                                     BP = row["BP"].ToString().Trim(),
                                     SPO2 = row["SPO2"].ToString().Trim(),
                                     VOTHERS = row["VOTHERS"].ToString().Trim(),
                                     BMI = row["BMI"].ToString().Trim(),
                                     HEAD_CIRCUMFERENCE = row["HEADCIRCUMFERENCE"].ToString().Trim(),
                                     PEFR = row["PEFR"].ToString().Trim(),
                                     Technique = GetComplianceSting(row["TECHNIQUE"].ToString().Trim()),
                                     Compliance = GetComplianceSting(row["COMPLIANCE"].ToString().Trim()),
                                     PAINSCORE = row["PAINSCORE"].ToString().Trim(),
                                     BSA = row["BSA"].ToString().Trim(),
                                     RBS = row["RBS"].ToString().Trim(),
                                     KARNOFSKY = row["KARNOFSKY"].ToString().Trim(),
                                     ECOG = row["ECOG"].ToString().Trim(),
                                     PULSECOND = row["PULSECOND"].ToString().Trim(),
                                     //Added by Murali on 25/04/2024
                                     //*******************************************
                                     IBW = row["IBW"].ToString(),
                                     BWPERC = row["BWPERC"].ToString(),
                                     WAISTCIRCUM = row["WAISTCIRCUM"].ToString(),
                                     HIPCIRCUM = row["HIPCIRCUM"].ToString(),
                                     WHR = row["WHR"].ToString()
                                     //*****************************************
                                 }).ToArray();
                    //return jsonData2;
                }
                if (load.Tables.Contains("EXAMS"))
                {
                    dt2 = load.Tables["EXAMS"];
                    jsonExam = (from DataRow row in dt2.AsEnumerable()
                                select new
                                {
                                    EXAM = row["EXAM"].ToString().Trim(),
                                }).ToArray();
                    jsonPastHist = (from DataRow row2 in dt2.AsEnumerable()
                                    select new
                                    {
                                        PASTHIST = row2["PASTHIST"].ToString().Trim(),
                                    }).ToArray();
                    //return jsonData3;
                }
                if (load.Tables.Contains("DIAGNOSIS"))
                {
                    dt3 = load.Tables["DIAGNOSIS"];
                    jsonDiagnosis = (from DataRow row in dt3.AsEnumerable()
                                     select new
                                     {
                                         TRANNO = row["TRANNO"].ToString().Trim(),
                                         MRNO = row["MRNO"].ToString().Trim(),
                                         DESCCD = row["DESCCD"].ToString().Trim(),
                                         DURATION = row["DURATION"].ToString().Trim(),
                                         DURTYPE = row["DURTYPE"].ToString().Trim(),
                                         REMARKS = row["REMARKS"].ToString().Trim(),
                                         //GRPCD = row["GRPCD"].ToString().Trim(),
                                         NAME = (language == ("HINDI") || language == ("MARATHI") || language == ("GUJRATI")) ? row[language].ToString().Trim() == "" ? row["NAME"].ToString().Trim() : row[language].ToString().Trim() : row["NAME"].ToString().Trim(),
                                         //NAME = row["NAME"].ToString().Trim(),

                                     }).ToArray();
                    //return jsonData4;
                }

                if (load.Tables.Contains("ICDDIAGNOSIS"))//24-12-19
                {
                    dt3 = load.Tables["ICDDIAGNOSIS"];
                    jsonICDiagnosis = (from DataRow row in dt3.AsEnumerable()
                                       select new
                                       {
                                           TRANNO = row["TRANNO"].ToString().Trim(),
                                           MRNO = row["MRNO"].ToString().Trim(),
                                           ICDCODE = row["ICDCODE"].ToString().Trim(),
                                           NAME = row["NAME"].ToString().Trim()
                                       }).ToArray();
                    //return jsonData4;
                }

                //if (load.Tables.Contains("ICDODIAGNOSIS"))//24-12-19
                //{
                //    dt3 = load.Tables["ICDODIAGNOSIS"];
                //    jsonICDODiagnosis = (from DataRow row in dt3.AsEnumerable()
                //                         select new
                //                         {
                //                             TRANNO = row["TRANNO"].ToString().Trim(),
                //                             MRNO = row["MRNO"].ToString().Trim(),
                //                             ICDOCODE = row["ICDOCODE"].ToString().Trim(),
                //                             NAME = row["NAME"].ToString().Trim()
                //                         }).ToArray();
                //}

                if (load.Tables.Contains("INVEST"))
                {
                    dt4 = load.Tables["INVEST"];
                    jsonInvstg = (from DataRow row in dt4.AsEnumerable()
                                  select new
                                  {
                                      TRANNO = row["TRANNO"].ToString().Trim(),
                                      MRNO = row["MRNO"].ToString().Trim(),
                                      TESTCODE = row["TESTCODE"].ToString().Trim(),
                                      TESTNAME = row["TESTNAME"].ToString().Trim(),
                                      DURATION = row["DURATION"].ToString().Trim(),// added by vijeta on 6th april 2018
                                      DURTYPE = row["DURTYPE"].ToString().Trim(),// added by vijeta on 6th april 2018
                                      REMARK = row["REMARK"].ToString().Trim(),// added by vijeta on 6th april 2018
                                  }).ToArray();
                    //return jsonData6;


                }
                //vijeta 20th march 19
                if (load.Tables.Contains("FREEINVESTIGATION"))
                {
                    dt = load.Tables["FREEINVESTIGATION"];

                    jsonFreeInvestigation = (from DataRow row in dt.AsEnumerable()
                                             select new
                                             {
                                                 FREEINVESTIGATION = row["FREEINVST"].ToString().Trim(),
                                             }).ToArray();

                }
                if (load.Tables.Contains("ADVICE"))
                {
                    dt5 = load.Tables["ADVICE"];
                    var medRoute = GeneralFunction.MedicineRouteRX();
                    jsonAdvice = (from DataRow row in dt5.AsEnumerable()
                                  select new
                                  {
                                      //TRANNO = row["TRANNO"].ToString().Trim(),
                                      // MRNO = row["MRNO"].ToString().Trim(),
                                      DRUGNM = (Convert.ToString(row["DRUGFORM"]).Trim() != "") ? Convert.ToString(row["DRUGFORM"]).Trim() + "." + " " + row["DRUGNM"].ToString().Trim() : row["DRUGNM"].ToString().Trim(),//
                                      DOSSAGE = row["DOSSAGE"].ToString().Trim(),
                                      DAYS = row["DAYS"].ToString().Trim(),
                                      GENERICNAME = row["GENERICNAM"].ToString().Trim(),
                                      INTAKE = row["INTAKE"].ToString().Trim(),
                                      REMARKS = row["Remarks"].ToString().Trim(),
                                      ROUTE = (row["ROUTE"].ToString().Trim() != "") ? medRoute.Where(x => x.Value == row["ROUTE"].ToString().Trim()).Count() > 0 ? medRoute.Where(x => x.Value == row["ROUTE"].ToString().Trim()).First().Text : row["ROUTE"].ToString().Trim() : row["ROUTE"].ToString().Trim(),
                                      ABFOOD = row["ABFOOD"].ToString().Trim(),
                                      QTY = row["QTY"].ToString().Trim(),
                                      MEDSTARTDATE = GeneralFunction.GetDate(row["MEDSTARTDATE"].ToString().Trim())
                                  }).ToArray();
                    //return jsonData5;
                }
                if (load.Tables.Contains("PATDETAILS"))
                {
                    dt6 = load.Tables["PATDETAILS"];
                    jsonUserdtls = (from DataRow row in dt6.AsEnumerable()
                                    select new
                                    {
                                        PATNAME = row["PATNAME"].ToString().Trim(),
                                        PATAGE = row["PATAGE"].ToString().Trim(),
                                        PATSEX = row["PATSEX"].ToString().Trim(),
                                        PATMOBILE = row["PATMOBILE"].ToString().Trim(),
                                        //PATSEX1 = row["PATSEX1"].ToString().Trim(),
                                        //TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()) + "  " + row["TRANTIME"].ToString().Trim(),
                                        //TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()) + "  " + DateTime.ParseExact(row["TRANTIME"].ToString().Trim(), "HH:mm:ss", null).ToString("hh:mm tt"),//priyanka 07/11/2025
                                        TRANDATE = GeneralFunction.GetDate(row["COMPLDT"].ToString().Trim()) + "  " + DateTime.ParseExact(row["COMPLTM"].ToString().Trim(), "HH:mm:ss", null).ToString("HH:mm"),//Pournima 16th June 2026
                                        DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                        COCANAME = row["COCANAME"].ToString().Trim(),
                                        EMPID = row["EMPID"].ToString().Trim(),
                                        CONSCATPROOF = row["CONSCATPROOF"].ToString().Trim(),
                                        EMPDEPNDCD = row["EMPDEPNDCD"].ToString().Trim(),
                                        COMPLETEDYN = row["COMPLETEDYN"].ToString().Trim(),
                                        PATEMAIL = row["PATEMAIL"].ToString().Trim(),
                                        PATADDRESS = row["PatAddress"].ToString().Trim()
                                    }).ToArray();
                }
                if (load.Tables.Contains("FAMILYHISTORY"))//family history
                {
                    dt7 = load.Tables["FAMILYHISTORY"];
                    jsonFamilyHist = (from DataRow row in dt7.AsEnumerable()
                                      select new
                                      {
                                          NAME = row["NAME"].ToString().Trim(),
                                          AGE = row["AGE"].ToString().Trim(),
                                          RELATION = row["RELATION"].ToString().Trim(),
                                          DISEASES = row["DISEASES"].ToString().Trim(),
                                          DURATION = row["DURATION"].ToString().Trim(),
                                          DURTYPE = row["DURTYPE"].ToString().Trim(),
                                          REMARKS = row["REMARKS"].ToString().Trim(),
                                          DIAGNOSEDDATE = GeneralFunction.GetDate(row["DIAGNOSEDDATE"].ToString().Trim()),
                                          DISEASESTATUS = row["DISEASESTATUS"].ToString().Trim() == "O" ? "Ongoing" : (row["DISEASESTATUS"].ToString().Trim() == "R" ? "Recovered" : ""),
                                          ALIVEYN = row["ALIVEYN"].ToString().Trim(),
                                          DATEOFDEATH = GeneralFunction.GetDate(row["DATEOFDEATH"].ToString().Trim()),
                                          CAUSEOFDEATH = row["CAUSEOFDEATH"].ToString().Trim(),
                                      }).ToArray();
                }
                if (load.Tables.Contains("ADDICTSHISTORY"))// addiction history
                {
                    dt8 = load.Tables["ADDICTSHISTORY"];
                    jsonPersonalHist = (from DataRow row in dt8.AsEnumerable()
                                        select new
                                        {
                                            MRNO = row["MRNO"].ToString().Trim(),
                                            ADDICTCD = row["ADDICTCD"].ToString().Trim(),
                                            STARTAGE = row["STARTAGE"].ToString().Trim(),
                                            STOPAGE = row["STOPAGE"].ToString().Trim(),
                                            NAME = row["NAME"].ToString().Trim(), //added on 14th march 2018
                                        }).ToArray();
                }
                if (load.Tables.Contains("MEDICINEHISTORY"))// medicine history
                {
                    dt9 = load.Tables["MEDICINEHISTORY"];
                    jsonMedicineHist = (from DataRow row in dt9.AsEnumerable()
                                        select new
                                        {
                                            MRNO = row["MRNO"].ToString().Trim(),
                                            MEDCD = row["MEDCD"].ToString().Trim(),
                                            DURATION = row["DURATION"].ToString().Trim(),
                                            DURTYPE = row["DURTYPE"].ToString().Trim(),
                                            NAME = row["NAME"].ToString().Trim(),//added on 14th march 2018
                                            //ONREGTREATYN = row["ONREGTREATYN"].ToString().Trim(),
                                        }).ToArray();
                }
                if (load.Tables.Contains("FOLLOWUP"))
                {
                    dt = load.Tables["FOLLOWUP"];
                    var StageTList = GeneralFunction.LstTumor;//Added By Rajan - To Get the TNM List 
                    var StageNList = GeneralFunction.LstNode;//Added By Rajan - To Get the TNM List 
                    var StageMList = GeneralFunction.LstMetastasis;//Added By Rajan - To Get the TNM List                     
                    CommonServiceClient Com = new CommonServiceClient();
                    var PatCarelst = Com.GetCareType();
                    jsonFollowUp = (from DataRow row in dt.AsEnumerable()
                                    select new
                                    {
                                        FOLLOWUPDT = row["FOLLOWUPDT"].ToString().Trim(),
                                        REFDOCT = row["DOCTNAME"].ToString().Trim(),
                                        SURGNMADVICE = row["SURGNMADVICE"].ToString().Trim(),
                                        REFSPECIALIST = row["REFSPECIALIST"].ToString().Trim(),
                                        REMARK = row["PRESCREMARK"].ToString().Trim(),
                                        APPMNTDT = GeneralFunction.GetDate(row["APPMNTDT"].ToString().Trim()),
                                        APPMNTTM = row["APPMNTTM"].ToString().Trim(),
                                        SIGN = "",// row["SIGNATORY"].ToString().Trim(), 
                                        PLANOFTREAT = row["PLANOFTREAT"].ToString().Trim(),
                                        PROVDIAG = row["PROVDIAG"].ToString().Trim(),
                                        COMPOSTAG = row["COMPOSTAG"].ToString().Trim(),
                                        TSTAGE = StageTList.Where(x => x.Value == row["TSTAGE"].ToString().Trim()).Count() > 0 ? StageTList.Where(x => x.Value == row["TSTAGE"].ToString().Trim()).FirstOrDefault().Text : row["TSTAGE"].ToString().Trim(),//Added By Rajan - To Get the TNM List
                                        NSTAGE = StageNList.Where(x => x.Value == row["NSTAGE"].ToString().Trim()).Count() > 0 ? StageNList.Where(x => x.Value == row["NSTAGE"].ToString().Trim()).FirstOrDefault().Text : row["NSTAGE"].ToString().Trim(),//Added By Rajan - To Get the TNM List
                                        MSTAGE = StageMList.Where(x => x.Value == row["MSTAGE"].ToString().Trim()).Count() > 0 ? StageMList.Where(x => x.Value == row["MSTAGE"].ToString().Trim()).FirstOrDefault().Text : row["MSTAGE"].ToString().Trim(),//Added By Rajan - To Get the TNM List
                                        CALLDONEYN = row["CALLDONEYN"].ToString().Trim(),
                                        SURGADVDATE = GeneralFunction.GetDate(row["SURGADVDATE"].ToString().Trim()),
                                        ADMNADVYN = row["ADMNADVYN"].ToString().Trim(),
                                        PROPADMNDT = GeneralFunction.GetDate(row["PROPADMNDT"].ToString().Trim()),
                                        SITE = row["DIASITECODE"].ToString().Trim() != "" ? GetSiteSubSite(row["DIASITECODE"].ToString().Trim(), "") : "",
                                        SUBSITE = row["DIASUBSITECODE"].ToString().Trim() != "" ? GetSiteSubSite(row["DIASITECODE"].ToString().Trim(), row["DIASUBSITECODE"].ToString().Trim()) : "",
                                        PACADVDATE = GeneralFunction.GetDate(row["PACADVDATE"].ToString().Trim()),
                                        SCHEMECODES = row["SCHEMECODES"].ToString().Trim(),
                                        PATCARETYPEADVICE = GeneralFunction.GetListValue(PatCarelst, row["PATCARETYPEADVICE"].ToString().Trim()),
                                        SCHEMENM = (row["SCHEMECODES"].ToString().Trim() != "" && SchemeDS != null && SchemeDS.Tables.Count > 0)
                                                  ? string.Join(", ",
                                                      row["SCHEMECODES"].ToString()
                                                          .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                                                          .Select(code => code.Trim())
                                                          .Select(code =>
                                                          {
                                                              DataRow[] schemeRows = SchemeDS.Tables[0].Select("SCHEMECD='" + code.Replace("'", "''") + "'");
                                                              return schemeRows.Length > 0 ? schemeRows[0]["SCHEMENM"].ToString().Trim() : "";
                                                          })
                                                          .Where(name => !string.IsNullOrEmpty(name)))
                                                  : "",
                                        SURGADVICEOTHER = row["SURGADVICEOTHER"].ToString().Trim(), // Pournima 18th Aug 2026
                                    }).ToArray();
                    //return jsonData3;
                }
                if (load.Tables.Contains("PATADVICE"))
                {
                    dt = load.Tables["PATADVICE"];

                    jsonPatientAdvice = (from DataRow row in dt.AsEnumerable()
                                         select new
                                         {
                                             DESCCD = row["DESCCD"].ToString().Trim(),

                                             NAME = (language == ("HINDI") || language == ("MARATHI") || language == ("GUJRATI")) ? row[language].ToString().Trim() == "" ? row["NAME"].ToString().Trim() : row[language].ToString().Trim() : row["NAME"].ToString().Trim(),
                                         }).ToArray();
                }
                if (load.Tables.Contains("FREEADVICETBL"))
                {
                    jsonFreeAdvice = (from DataRow row in load.Tables["FREEADVICETBL"].Rows
                                      select new
                                      {
                                          FREEADVICE = row["FREEADVICE"].ToString().Trim()
                                      }).ToArray();
                }

                if (ds1.Tables.Contains("Table"))
                {
                    dtFrDoctDetls = ds1.Tables["Table"];

                    jsonDoctorDetails = (from DataRow row in dtFrDoctDetls.AsEnumerable()
                                         select new
                                         {
                                             DOCTCODE = row["DOCTCODE"].ToString().Trim(),
                                             DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                             QUALI = row["QUALI"].ToString().Trim(),
                                             MCCNO = row["MCCNO"].ToString().Trim(),
                                             PRNTHISTYN = row["PRNTHISTYN"].ToString().Trim(),
                                             SPECIALIZATION = row["DOSPNAME"].ToString().Trim(),
                                             SIGN = row["SIGN"].ToString().Trim()
                                         }).ToArray();
                    //return jsonData6;
                }

                //vijeta 26th march 19
                if (load.Tables.Contains("FREEHISTORY"))
                {
                    dt = load.Tables["FREEHISTORY"];
                    var jsonData = (from DataRow row in dt.AsEnumerable()
                                    where ("" + row["FAMHIST"]).Trim() != ""
                                    select new
                                    {
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()),
                                        FAMHIST = ("" + row["FAMHIST"]).Trim(),
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonFreeFamily = jsonData;
                    else
                        jsonFreeFamily = "";

                }
                //vijeta 26th march 19
                if (load.Tables.Contains("FREEHISTORY"))
                {
                    dt = load.Tables["FREEHISTORY"];
                    var jsonData = (from DataRow row in dt.AsEnumerable()
                                    where ("" + row["PERSHIST"]).Trim() != ""
                                    select new
                                    {
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()),
                                        PERSHIST = ("" + row["PERSHIST"]).Trim(),
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonFreePersonal = jsonData;
                    else
                        jsonFreePersonal = "";

                }

                //vijeta 26th march 19
                if (load.Tables.Contains("FREEHISTORY"))
                {
                    dt = load.Tables["FREEHISTORY"];
                    var jsonData = (from DataRow row in dt.AsEnumerable()
                                    where ("" + row["MEDIHIST"]).Trim() != ""
                                    select new
                                    {
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()),
                                        MEDHIST = ("" + row["MEDIHIST"]).Trim(),
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonFreeMedical = jsonData;
                    else
                        jsonFreeMedical = "";

                }
                if (load.Tables.Contains("Allergy"))//
                {
                    dt = load.Tables["Allergy"];
                    var AllergyTypeLst = GeneralFunction.GetAllergyTypeList();
                    var jsonData = (from DataRow row in dt.AsEnumerable()
                                    where ("" + row["NAME"]).Trim() != ""
                                    select new
                                    {
                                        DURATION = ("" + row["DURATION"]).Trim(),
                                        DURTYPE = ("" + row["DURTYPE"]).Trim(),
                                        REMARKS = ("" + row["REMARKS"]).Trim(),
                                        NAME = ("" + row["NAME"]).Trim(),
                                        ALLERGYTYPE = ("" + row["ALLERGYTYPE"]).Trim() == "" ? "" : (AllergyTypeLst.Where(x => x.Value == ("" + row["ALLERGYTYPE"]).Trim()).Count() > 0 ? AllergyTypeLst.Where(x => x.Value == ("" + row["ALLERGYTYPE"]).Trim()).FirstOrDefault().Text : "")
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonAllergy = jsonData;
                    else
                        jsonAllergy = "";

                }
                string CANCERYN = "N";
                if (load.Tables.Contains("FOLLOWUP") && load.Tables["FOLLOWUP"].Rows.Count > 0)
                {
                    CANCERYN = load.Tables["FOLLOWUP"].Rows[0]["CANCERYN"].ToString().Trim();
                }
                if (load.Tables.Contains("ICDODIAGNOSIS") && CANCERYN == "Y")
                {
                    //var PrefixLst = GeneralFunction.GetPrefixTNM();
                    dt10 = load.Tables["ICDODIAGNOSIS"];
                    var jsonTopoDetails = (from DataRow row in dt10.AsEnumerable()
                                           select new
                                           {
                                               SITELEVEL = row["SITELEVEL"].ToString().Trim(),
                                               TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                                               TOPONAME = row["TOPODESC"].ToString().Trim(),
                                               TOPOTYPE = row["TOPOTYPE"].ToString().Trim(),
                                               SITE = row["TNMSITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["TNMSITECODE"].ToString().Trim(), ""),
                                               SUBSITE = row["TNMSUBSITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["TNMSITECODE"].ToString().Trim(), row["TNMSUBSITECODE"].ToString().Trim()),
                                               //PREFIX = row["TNMPREFIX"].ToString().Trim() == "" ? "" : PrefixLst.Where(x => x.Value == row["TNMPREFIX"].ToString().Trim()).Count() > 0 ? PrefixLst.Where(x => x.Value == row["TNMPREFIX"].ToString().Trim()).FirstOrDefault().Text : "",
                                               PREFIX = row["TNMPREFIX"].ToString().Trim(),
                                               T = row["T"].ToString().Trim(),
                                               N = row["N"].ToString().Trim(),
                                               M = row["M"].ToString().Trim(),
                                               GEOGRAPHIC = row["Geographic"].ToString().Trim(),
                                               LOCATION = row["Location"].ToString().Trim(),
                                               MITOTIC = row["Mitotic"].ToString().Trim(),
                                               PSA = row["PSA"].ToString().Trim(),
                                               SERUMMARKERS = row["SerumMarkers"].ToString().Trim(),
                                               HERITABLETRAIT = row["HeritableTrait"].ToString().Trim(),
                                               HER2 = row["HER2"].ToString().Trim(),
                                               ER = row["ER"].ToString().Trim(),
                                               PR = row["PR"].ToString().Trim(),
                                               BLOODINVL = row["BloodInvl"].ToString().Trim(),
                                               STAGE = row["STAGE"].ToString().Trim(),
                                               ADJUVANT = Convert.ToString(row["ADJUVANT"]),
                                               RECCURENT = Convert.ToString(row["RECCURENT"])
                                           }).ToArray();
                    if (jsonTopoDetails.Length > 0)
                        jsonICDTopology = jsonTopoDetails;
                    else
                        jsonICDTopology = "";
                }

                if (load.Tables.Contains("ICDOHDIAGNOSIS"))
                {
                    CommonServiceClient Com = new CommonServiceClient();
                    var HistoList = Com.ICDHISTOLst("");
                    var HistoGradeLst = GeneralFunction.GetHitologyGrade();
                    dt11 = load.Tables["ICDOHDIAGNOSIS"];
                    var jsonHistoDetails = (from DataRow row in dt11.AsEnumerable()
                                            select new
                                            {
                                                SITELEVEL = row["SITELEVEL"].ToString().Trim(),
                                                TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                                                TOPONAME = row["TOPODESC"].ToString().Trim(),
                                                TOPOTYPE = row["TOPODESC"].ToString().Trim(),
                                                HISTOCODE = row["HCODE"].ToString().Trim(),
                                                HISTONAME = row["HDESC"].ToString().Trim(), //row["HCODE"].ToString().Trim() == "" ? "" : (HistoList.Where(x => x.Value == row["HCODE"].ToString().Trim()).Count() > 0 ? HistoList.Where(x => x.Value == row["HCODE"].ToString().Trim()).FirstOrDefault().Text : ""),
                                                HISTOTYPE = row["HTYPE"].ToString().Trim(),
                                                GRADE = row["HGRADE"].ToString().Trim(),
                                                HISTOGRADETYPE = row["HISTOGRADETYPE"].ToString().Trim(),
                                                GRADENAME = row["HGRADE"].ToString().Trim() == "" ? "" : (HistoGradeLst.Where(x => x.Value == row["HGRADE"].ToString().Trim() && x.GradeType == row["HISTOGRADETYPE"].ToString().Trim()).Count() > 0 ? HistoGradeLst.Where(x => x.Value == row["HGRADE"].ToString().Trim() && x.GradeType == row["HISTOGRADETYPE"].ToString().Trim()).FirstOrDefault().Text : ""),
                                            }).ToArray();
                    if (jsonHistoDetails.Length > 0)
                        jsonICDHistology = jsonHistoDetails;
                    else
                        jsonICDHistology = "";
                }
                CommonServiceClient cs = new CommonServiceClient();
                var ChemoLst = cs.GetChemoNameLst().Where(x => x.Status == "A");
                if (load.Tables.Contains("CHEMOPLANNING"))
                {
                    dt = load.Tables["CHEMOPLANNING"];

                    var jsonData = dt.AsEnumerable()
                        .OrderByDescending(r => r["TRANDATE"].ToString().Trim())
                        .ThenByDescending(r => r["TRANTIME"].ToString().Trim())
                        .Select(row => new
                        {
                            PLANNO = ("" + row["TRANID"]).Trim(),
                            CHEMONAME = row["CHEMOTHERAPYNM"].ToString().Trim() == ""
                                ? ""
                                : ChemoLst.Any(x => x.Value == row["CHEMOTHERAPYNM"].ToString().Trim())
                                    ? ChemoLst.First(x => x.Value == row["CHEMOTHERAPYNM"].ToString().Trim()).Text
                                    : row["CHEMOTHERAPYNM"].ToString().Trim(),

                            TOTALCYCLE = ("" + row["TOTALCYCLE"]).Trim(),
                            ADVSTARTDATE = GeneralFunction.GetDate(row["ADVSTARTDATE"].ToString().Trim()),
                            PLANCOMPLETE = ("" + row["PLANCOMPLETE"]).Trim()
                        })
                        .ToArray();
                    if (jsonData.Length > 0)
                    {
                        jsonChemoPlan = jsonData;
                        AdvTranNo = jsonData.FirstOrDefault(x => x.PLANCOMPLETE == "N")?.PLANNO ?? "";
                        ChemoFlag = true;
                    }
                    else
                        jsonChemoPlan = "";
                }

                if (load.Tables.Contains("REFDOCTORNOTE"))
                {
                    var DoctLst = oncclnt.GetDoctLst("", "D");
                    dt = load.Tables["REFDOCTORNOTE"];
                    var jsonData = (from DataRow row in dt.AsEnumerable()
                                    select new
                                    {
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        DOCTNAME = ("" + row["DOCTCODE"]).Trim() == "" ? "" : (DoctLst.Where(X => X.Value == ("" + row["DOCTCODE"]).Trim()).Count() > 0 ? DoctLst.Where(X => X.Value == ("" + row["DOCTCODE"]).Trim()).First().Text : ""),
                                        REFDOCTNAME = ("" + row["REFDOCTCODE"]).Trim() == "" ? "" : (DoctLst.Where(X => X.Value == ("" + row["REFDOCTCODE"]).Trim()).Count() > 0 ? DoctLst.Where(X => X.Value == ("" + row["REFDOCTCODE"]).Trim()).First().Text : ""),
                                        NOTE = ("" + row["NOTE"]).Trim(),
                                        STATUS = ("" + row["STATUS"]).Trim()
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonRefDoctNote = jsonData;
                    else
                        jsonRefDoctNote = "";
                }

                if (load.Tables.Contains("Table20"))
                {
                    dt = load.Tables["Table20"];
                    var jsonData = (from DataRow row in dt.AsEnumerable()
                                    where ("" + row["CLINICALHIST"]).Trim() != ""
                                    select new
                                    {
                                        CLINICALHIST = ("" + row["CLINICALHIST"]).Trim(),
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonClinicalHist = jsonData;
                    else
                        jsonClinicalHist = "";

                }

                if (load.Tables.Contains("PRODIAGNOSIS"))
                {
                    dt = load.Tables["PRODIAGNOSIS"];
                    var jsonProvDiagData = (from DataRow row in dt.AsEnumerable()
                                            where ("" + row["PROVDIAG"]).Trim() != ""
                                            select new
                                            {
                                                PROVDIAG = ("" + row["PROVDIAG"]).Trim(),
                                            }).ToArray();
                    if (jsonProvDiagData.Length > 0)
                        jsonProvDiagnosis = jsonProvDiagData;
                    else
                        jsonProvDiagnosis = "";
                }
                if (load.Tables.Contains("FOLLOWUP") && load.Tables["FOLLOWUP"].Rows.Count > 0 && load.Tables["FOLLOWUP"].Rows[0]["SCHEMECODES"].ToString().Trim() != "")
                {
                    string[] SchemeSplt = load.Tables["FOLLOWUP"].Rows[0]["SCHEMECODES"].ToString().Trim().Split(',');
                    jsonSchemeData = SchemeSplt
                                        .Select(code =>
                                        {
                                            code = code.Trim();
                                            DataRow[] schemeRows = (SchemeDS != null && SchemeDS.Tables.Count > 0)
                                                ? SchemeDS.Tables[0].Select("SCHEMECD='" + code.Replace("'", "''") + "'") : new DataRow[0];
                                            return new
                                            {
                                                SCHEMENAME = schemeRows.Length > 0 ? schemeRows[0]["SCHEMENM"].ToString().Trim() : ""
                                            };
                                        }).ToArray();
                }
                else if (AdvTranNo != "")
                {
                    OncologyClient ClOnco = new OncologyClient();
                    DataSet DS = new DataSet();
                    var PreAuthStatusList = GeneralFunction.PreAuthStatusList();
                    if (ChemoFlag)
                        DS.ReadXml(new XmlTextReader(new StringReader(ClOnco.GetRadDosePrescAprovalDet("", MrNo, "", "", "", "", "M", ""))));
                    else
                    {
                        DS.ReadXml(new XmlTextReader(new StringReader(ClOnco.GetRadDosePrescAprovalDet("", MrNo, "", "", "", "", "R", ""))));
                        DataRow[] Drow = DS.Tables[0].Select("REFTRANNO = '" + AdvTranNo + "'");
                        if (Drow.Length == 0)
                        {
                            DS.ReadXml(new XmlTextReader(new StringReader(ClOnco.GetRadDosePrescAprovalDet("", MrNo, "", "", "", "", "S", ""))));
                        }
                    }
                    if (DS.Tables.Count > 0 && DS.Tables[0].Rows.Count > 0)
                    {
                        DataRow[] Drow = DS.Tables[0].Select("REFTRANNO = '" + AdvTranNo.Replace("'", "''") + "'");

                        if (Drow.Length > 0 && SchemeDS != null && SchemeDS.Tables.Count > 0)
                        {
                            jsonSchemeData = Drow
                                        .SelectMany(row =>
                                            row["REFSCHEMECODES"].ToString()
                                                .Trim()
                                                .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                                                .Select(code => code.Trim())
                                                .Select(code =>
                                                {
                                                    DataRow[] schemeRows = SchemeDS.Tables[0].Select(
                                                        "SCHEMECD='" + code.Replace("'", "''") + "'");

                                                    return new
                                                    {
                                                        SCHEMENAME = schemeRows.Length > 0
                                                            ? schemeRows[0]["SCHEMENM"].ToString().Trim()
                                                            : ""
                                                    };
                                                })
                                        )
                                        .Where(x => !string.IsNullOrEmpty(x.SCHEMENAME))
                                        .ToArray();
                        }
                    }
                }
            }
            dict.Add("jsonComplaints", jsonComplaints);
            dict.Add("jsonVital", jsonVital);
            dict.Add("jsonExam", jsonExam);
            dict.Add("jsonPastHist", jsonPastHist);
            dict.Add("jsonDiagnosis", jsonDiagnosis);
            dict.Add("jsonInvstg", jsonInvstg);
            dict.Add("jsonAdvice", jsonAdvice);
            dict.Add("jsonUserdtls", jsonUserdtls);
            dict.Add("jsonPersonalHist", jsonPersonalHist);
            dict.Add("jsonFamilyHist", jsonFamilyHist);
            dict.Add("jsonMedicineHist", jsonMedicineHist);
            dict.Add("jsonFollowUp", jsonFollowUp);
            dict.Add("jsonPatientAdvice", jsonPatientAdvice);
            dict.Add("jsonDoctorDetails", jsonDoctorDetails);
            dict.Add("ExamImagePath", filepath);
            dict.Add("TranNo", tranno);//added on 23rd aug 2018
            dict.Add("jsonFreeComplaints", jsonFreeComplaints);//added on 19th march 19
            dict.Add("jsonFreeInvestigation", jsonFreeInvestigation);//added on 20th march 19
            dict.Add("jsonFreeFamily", jsonFreeFamily);//vijeta 26th march 19
            dict.Add("jsonFreePersonal", jsonFreePersonal);//vijeta 26th march 19
            dict.Add("jsonFreeMedical", jsonFreeMedical);//vijeta 26th march 19
            dict.Add("jsonstrTranNo", jsonstrTranNo);//vijeta 15th may 2019
            dict.Add("jsonAllergy", jsonAllergy);//
            dict.Add("jsonICDiagnosis", jsonICDiagnosis);// 24-12-19
            dict.Add("jsonICDODiagnosis", jsonICDODiagnosis);// 24-12-19
            dict.Add("jsonICDOTopology", jsonICDTopology);// 24-12-19
            dict.Add("jsonICDOHistology", jsonICDHistology);// 24-12-19
            dict.Add("jsonFreeAdvice", jsonFreeAdvice);
            dict.Add("ChemoPlan", jsonChemoPlan);
            dict.Add("jsonRefDoctNote", jsonRefDoctNote);
            dict.Add("jsonClinicalHist", jsonClinicalHist);
            dict.Add("jsonScheme", jsonSchemeData);
            dict.Add("jsonProvDiagnosis", jsonProvDiagnosis);
            return dict;
        }

        public string GetSiteSubSite(string SiteCd = "", string SubSiteCd = "")
        {
            string Result = "";
            CommonServiceClient comser = new CommonServiceClient();
            var CSiteLst = comser.GetCRSiteLst();
            if (SiteCd != "" && SubSiteCd != "")
            {
                Result = CSiteLst.Where(x => x.Value == SubSiteCd && x.CancerGrp == SiteCd).Count() > 0 ? CSiteLst.Where(x => x.Value == SubSiteCd && x.CancerGrp == SiteCd).FirstOrDefault().Text : "";
            }
            else if (SiteCd != "")
            {
                var CGRPLst = comser.GetCRGrpLst();
                Result = CGRPLst.Where(x => x.Value == SiteCd).Count() > 0 ? CGRPLst.Where(x => x.Value == SiteCd).FirstOrDefault().Text : "";
            }
            return Result;
        }

        private string GetComplianceSting(string str)
        {
            if (str == "G")
                return "Good";
            else if (str == "F")
                return "Fair";
            else if (str == "A")
                return "Average";
            else if (str == "P")
                return "Poor";
            else
                return "N";
        }

        public string[] GetExaminationFile(string TranNo, string MrNo)
        {
            int fileCount = 0;
            string[] filePaths = { };
            //var Pic_Path = HttpContext.Current.Server.MapPath("~/PrescriptionImages");
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            var Pic_Path = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString().Trim() + "/PrescriptionImages/" + strUnit;
            var subpath = Pic_Path + @"\" + MrNo;
            var TranPath = Pic_Path + @"\" + MrNo + @"\" + TranNo;
            string countpath = TranPath;

            if (Directory.Exists(TranPath))
            {
                fileCount = Directory.GetFiles(TranPath).Length;
            }
            if (fileCount > 0)
            {
                filePaths = Directory.GetFileSystemEntries(countpath);
            }
            return filePaths;
        }


        public byte[] PrintPatientReport(string strHtml)
        {
            HtmlToPdfConverter pdf = new HtmlToPdfConverter();
            pdf.Margins = new PageMargins { Top = 20, Bottom = 20, Left = 10, Right = 10 };
            byte[] printData = pdf.GeneratePdf(strHtml);
            return printData;
        }

        public string SaveMainCompAddItemdt(string Desc, string GrpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();

                if (GrpCode.Trim() == "")
                    Result = Oncoser.SaveMainComplaint("", Desc, clinicCode, "A", User, 1);
                else
                    Result = Oncoser.SaveSubComplaint("", Desc, GrpCode, "A", User, 1);
                return Result;
            }
            catch (Exception ex)
            {
                //if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                if (ex.Message.Contains("Cannot insert duplicate key"))
                {
                    Result = "This complaint is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        //added on 19th dec 2018
        public string AddFreeComplaint(string strComplaint, string strTranNo, string strMrNo)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            BL_Oncology blOncology = new BL_Oncology();
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "S";
            blOncology.FreeComplaint = strComplaint;
            return oncoClient.SaveDoctorDesk(blOncology);
        }

        //save notes
        public string SaveMainNotesdt(string Notes, string MRNO, string TransactNo)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                //string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();

                Result = Oncoser.SavePatNote(Notes, TransactNo, MRNO, "", "", "", 0, "", "N");
                return Result;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        public object SetDataForComplaints(string strTranNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            object[] objToSend = new object[2];
            string str = "";
            str = Oncoser.GetDoctDesk(strTranNo, "C", "");
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("COMPLAINTS"))
                {
                    if (ds.Tables["COMPLAINTS"].Rows.Count > 0)
                    {
                        var data = (from DataRow row in ds.Tables["COMPLAINTS"].Rows
                                    select new
                                    {
                                        DESCCD = row["DESCCD"].ToString().Trim(),
                                        DESC = row["COMPLDESC"].ToString().Trim(),
                                        DURATION = row["DURATION"].ToString().Trim(),
                                        DURTYPE = row["DURTYPE"].ToString().Trim(),
                                        REMARKS = row["REMARKS"].ToString().Trim(),
                                        SETUPYN = row["SETUPYN"].ToString().Trim(),//added on 25th july 19
                                    }
                           ).ToArray();
                        //return Newtonsoft.Json.JsonConvert.SerializeObject(data);
                        //return data;
                        objToSend[0] = data;
                    }
                }
                if (ds.Tables.Contains("FREECOMPLNT"))
                {
                    if (ds.Tables["FREECOMPLNT"].Rows.Count > 0)
                    {
                        var data = (
                                    from DataRow row in ds.Tables["FREECOMPLNT"].Rows
                                    select new
                                    {
                                        FreeComplaint = row["FREECOMPLAINT"].ToString().Trim()
                                    }).ToArray();
                        objToSend[1] = data;
                    }
                }
            }
            return objToSend;
        }

        public object RetriveDBComplainList(string complainName, string ClinicCode)
        {
            //object jsonData = string.Empty;
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            // load.ReadXml(new XmlTextReader(new StringReader(client.GetComplaintByName(complainName, ClinicCode))));
            load.ReadXml(new XmlTextReader(new StringReader(client.GetComplaintByName(complainName, ""))));
            if (load != null && load.Tables.Count > 0)
            {
                string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                return jsonData;
            }
            else
            {
                return "Unsucessfull";
            }
        }

        #region Followup Print
        public string SaveFollowUp(string days, string number, string MRNO, string TransactNo, string RefDoctor, string Patname, string SurgyAdvice, string RefCliniName,
            string patAge, string patGender, string patMobile, string AppmntDate, string AppmntTime, string strSlotNo, string prescRemarks, string planOfTreatmnt,
            string strCallDoneYN, string strAdveFrAdmn, string RedirectOpt, string TBRef, string PropAdmnDT, string CareType, string SurgeryCode, string SurgyAdvDate,
            string PACAdvDate, string SurgeryAdviceType, string SchemeCodes, string LevelUrg, string NotesLst = "")
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataTable NotesLstDT = new DataTable();
            DataSet NotesDS = new DataSet();
            if (NotesLst != "")
            {
                NotesLstDT = JsonConvert.DeserializeObject<DataTable>(NotesLst);
            }
            if (number != "0")
            {
                blOncology.FollowUpDt = string.Format("{0} {1}", number, days);
            }
            else
            {
                blOncology.FollowUpDt = string.Empty;
            }
            blOncology.PatName = string.Format("{0}", Patname);
            blOncology.TRANNO = string.Format("{0}", TransactNo);
            blOncology.MRNO = string.Format("{0}", MRNO);
            blOncology.SurgHist = string.Format("{0}", SurgyAdvice);
            blOncology.TOthers = string.Format("{0}", RefCliniName);
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "W";
            blOncology.RefDoctCode = RefDoctor;
            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString();
            blOncology.CallDoneYN = strCallDoneYN;
            blOncology.Age = patAge;
            blOncology.Gender = patGender;
            blOncology.MobileNo = patMobile;
            blOncology.ApmntDate = GeneralFunction.GetDateInSpecifiedFormat(AppmntDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blOncology.ApmntTime = AppmntTime.Trim();
            blOncology.PrescRemark = prescRemarks;
            blOncology.PlanOfTreatmnt = planOfTreatmnt;
            blOncology.AdvAdmnYN = strAdveFrAdmn;
            blOncology.Redirect = RedirectOpt;
            blOncology.TBRefYN = TBRef;      // Added by Dhananjay 20241005
            blOncology.ProposeAdmnDt = GeneralFunction.GetDateInSpecifiedFormat(PropAdmnDT, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blOncology.PatCareTypeAdviced = CareType;
            blOncology.SurgeryCodeAdviced = SurgeryCode;  // Added by Rajan 
            blOncology.SurgAdvicedDate = GeneralFunction.GetDateInSpecifiedFormat(SurgyAdvDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);  // Added by Rajan 
            blOncology.PACAdvicedDate = GeneralFunction.GetDateInSpecifiedFormat(PACAdvDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD); // Added by Rajan 
            blOncology.SurgeryAdviceType = SurgeryAdviceType;
            blOncology.SchemeCodes = SchemeCodes;
            blOncology.AdmnUrgencyLevel = LevelUrg;
            NotesLstDT.TableName = "REFDOCT";
            NotesDS.Tables.Add(NotesLstDT);
            NotesDS.DataSetName = "DATA";
            blOncology.xmlPatAdvice = NotesDS.GetXml();
            return client.SaveDoctorDesk(blOncology);

        }

        public string SavecompleteTr(string Number, string DaySelected, string MrnNo, string Transno, string refDoctName, string patName, string patAge, string patGender,
            string patMobile, string SurgyAdvice, string RefCliniName, string AppmntDate, string AppmntTime, string strSlotNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();

            blOncology.TRANNO = Transno;
            if (Number != "0")
            {
                blOncology.FollowUpDt = string.Format("{0} {1}", Number, DaySelected);
            }
            else
            {
                blOncology.FollowUpDt = string.Empty;
            }
            // blOncology.MRNO = strMrNo;
            blOncology.SurgHist = string.Format("{0}", SurgyAdvice);
            blOncology.TOthers = string.Format("{0}", RefCliniName);
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 5;
            blOncology.type = "";
            blOncology.RefDoctCode = refDoctName;
            blOncology.PatName = patName;
            blOncology.Age = patAge;
            blOncology.Gender = patGender;
            blOncology.MobileNo = patMobile;
            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString();

            blOncology.ApmntDate = GeneralFunction.GetDateInSpecifiedFormat(AppmntDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blOncology.ApmntTime = AppmntTime.Trim();

            string doctDeskStatus = Oncoser.SaveDoctorDesk(blOncology);

            return doctDeskStatus;
        }

        public object BookAppoinment(string AppmntDate, string AppmntTime, string strSlotNo, string patName, string patAge, string patGender, string patMobile, string mrNo,
            string tranno, string Number, string DaySelected, string SurgyAdvice, string RefCliniName, string refDoctName)
        {
            var result = "";
            if (AppmntDate != "" && AppmntTime != "" && strSlotNo != "")
            {
                BL_Oncology blOncology = new BL_Oncology();
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                blOncology.ApmntDate = GeneralFunction.GetDateInSpecifiedFormat(AppmntDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                blOncology.ApmntTime = AppmntTime.Trim();
                OutpatientClient opcli = new OutpatientClient();
                // blOncology.MRNO = strMrNo;
                //blOncology.MRNO = mrNo;
                //blOncology.TranMode = 1;
                //blOncology.type = "W";
                //blOncology.SurgHist = string.Format("{0}", SurgyAdvice);
                //blOncology.TOthers = string.Format("{0}", RefCliniName);
                //blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                //blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
                //blOncology.RefDoctCode = refDoctName;
                //blOncology.PatName = patName;
                //blOncology.Age = patAge;
                //blOncology.Gender = patGender;
                //blOncology.MobileNo = patMobile;
                //blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString();
                //blOncology.TRANNO = tranno;
                //if (Number != "0")
                //{
                //    blOncology.FollowUpDt = string.Format("{0} {1}", Number, DaySelected);
                //}
                //else
                //{
                //    blOncology.FollowUpDt = string.Empty;
                //}
                //string doctDeskStatus = Oncoser.SaveDoctorDesk(blOncology);

                BL_OPAppointment blOpApptmnt = new BL_OPAppointment();

                blOpApptmnt.MRNo = mrNo.Trim();

                blOpApptmnt.Consdate = GeneralFunction.GetDateInSpecifiedFormat(AppmntDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                blOpApptmnt.Constime = AppmntTime.Trim();
                blOpApptmnt.Doctcode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                // blOpApptmnt.Doctcode = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString();
                blOpApptmnt.Clncode = HttpContext.Current.Session["ClinicCode"].ToString().Trim();
                blOpApptmnt.UserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
                blOpApptmnt.Patage = patAge;
                blOpApptmnt.Patsex = patGender.Substring(0, 1);
                blOpApptmnt.Phoneno = patMobile;
                string[] patientWords = patName.Trim().Split(' ');
                CommonServiceClient com = new CommonServiceClient();
                if (patientWords.Length == 4)
                {

                    blOpApptmnt.Salutation = com.GetSalutatioLst().Where(x => x.Text == patientWords[0].Trim()).Count() > 0 ? com.GetSalutatioLst().Where(x => x.Text == patientWords[0].Trim()).FirstOrDefault().Value : ""; // patientWords[0];
                    blOpApptmnt.Patfname = patientWords[1];
                    blOpApptmnt.Patmname = patientWords[2];
                    blOpApptmnt.Patlname = patientWords[3];
                }
                else if (patientWords.Length == 3)
                {
                    blOpApptmnt.Salutation = com.GetSalutatioLst().Where(x => x.Text == patientWords[0].Trim()).Count() > 0 ? com.GetSalutatioLst().Where(x => x.Text == patientWords[0].Trim()).FirstOrDefault().Value : "";
                    blOpApptmnt.Patfname = patientWords[1];
                    blOpApptmnt.Patlname = patientWords[2];
                }
                else if (patientWords.Length > 4)
                {
                    blOpApptmnt.Salutation = com.GetSalutatioLst().Where(x => x.Text == patientWords[0].Trim()).Count() > 0 ? com.GetSalutatioLst().Where(x => x.Text == patientWords[0].Trim()).FirstOrDefault().Value : "";
                    blOpApptmnt.Patfname = patientWords[1];
                    blOpApptmnt.Patlname = patientWords[3];
                }
                blOpApptmnt.Email = "";
                blOpApptmnt.Pataddr1 = "";
                blOpApptmnt.Pataddr2 = "";
                //blOpApptmnt.Pataddr3 = "";
                blOpApptmnt.CntrCd = "DD";
                blOpApptmnt.ModuleID = System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString();
                blOpApptmnt.Pataddr3 = tranno;
                blOpApptmnt.Weekday = GeneralFunction.GetWeekDay("" + GeneralFunction.GetDateInSpecifiedFormat(AppmntDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
                blOpApptmnt.PatType = "O";
                blOpApptmnt.Slotno = Convert.ToInt32(strSlotNo);
                blOpApptmnt.TranMode = 1;
                result = opcli.SaveUpdateAppointment(blOpApptmnt);
            }
            return result;
        }
        public IEnumerable<OncologyEMR.Oncology.SelectLstItem> ClincList { get; set; }

        public object GetCliniclst()
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            var ClincList = Oncoser.GetSpecialistnList();
            if (ClincList.Count() > 0)
            {
                var data = (from OncologyEMR.Oncology.SelectLstItem t in ClincList
                            select new
                            {
                                ClinicName = t.Text.ToString(),
                                ClinicCode = t.Value.ToString()
                            }
                    ).ToArray(); ;
                return data;
            }
            return "";
        }
        public List<SelectListItem> GetDoctorsByClinic(string cliniccode)
        {
            DataSet ds_Doctorddl = new DataSet();

            new CommonServiceClient().UsingSafe(comser =>
            {
                ds_Doctorddl = comser.GetClinicWiseDoctLst(cliniccode);
            });

            List<SelectListItem> DoctorddlList = new List<SelectListItem>();

            GeneralFunction obj = new GeneralFunction();
            DoctorddlList = obj.fillcombo(ds_Doctorddl);

            return DoctorddlList;
        }

        public object GetDoctors(string DoctName, string Type = "")
        {
            CommonServiceClient comserv = new CommonServiceClient();
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            if (Type == "P")
            {
                var doctList = comserv.GetDoctLst().Where(x => x.Status == "A");
                if (doctList.Count() > 0)
                {
                    var data = (from OncologyEMR.CommonSerRef.DoctorSelLstItem t in doctList
                                select new
                                {
                                    DoctName = t.Text.ToString(),
                                    DoctCode = t.Value.ToString()
                                }
                     ).ToArray();
                    return data;
                }
                return "";
            }
            else
            {
                var showOutside = GeneralFunction.GetAppsettingUnitWiseValue("showOutRefDrHosp").ToString().Trim();
                if (showOutside == "N")
                {
                    var doctList = Oncoser.GetDoctLst(DoctName, "").Where(x => x.Status == "A" && x.Type == "D");
                    if (doctList.Count() > 0)
                    {
                        var data = (from OncologyEMR.Oncology.DoctorSelLstItem t in doctList
                                    select new
                                    {
                                        DoctName = t.Text.ToString(),
                                        DoctCode = t.Value.ToString()
                                    }
                         ).ToArray();
                        return data;
                    }
                }
                else
                {
                    var doctList = Oncoser.GetDoctLst(DoctName, "").Where(x => x.Status == "A");
                    if (doctList.Count() > 0)
                    {
                        var data = (from OncologyEMR.Oncology.DoctorSelLstItem t in doctList
                                    select new
                                    {
                                        DoctName = t.Text.ToString(),
                                        DoctCode = t.Value.ToString()
                                    }
                         ).ToArray();
                        return data;
                    }
                }
            }
            return "";
        }

        public object GetAppointmnentSlots(string strDate)
        {
            OutpatientClient pissClient = new OutpatientClient();
            var dt = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            var clncCode = HttpContext.Current.Session["ClinicCode"].ToString().Trim();
            var doctCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            var weekDay = GeneralFunction.GetWeekDay("" + GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            var str = pissClient.GetDoctorSlots(clncCode, doctCode, weekDay, dt);

            DataSet ds = new DataSet();
            if (str != "")
            {
                ds.ReadXml(new StringReader(str));

                if (ds.Tables.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    Slot = row["SLOT"].ToString().Trim(),
                                    SLOTNO = row["SLOTNO"].ToString().Trim(),
                                }).ToArray();
                    return data;
                }
                else
                {
                    return "";
                }
            }
            else
                return "";
        }

        //Added by Murali on 20/02/2024
        //**********************************************************************************************************************************************
        public object GetDoctorAval(string CLINICCODE, string DOCTORCODE, string SEARCHDATE, string NumWeekday, string Searchwise)
        {
            DataSet dsDocAvaiDT = new DataSet(), dsAppList = new DataSet();
            DataSet dsDocLeave = new DataSet();
            //DateTime startTime, endTime, BrkFRTM, BrkTOTM;

            //int RecCount;
            ServiceClient.UsingSafe(new OutpatientClient(), x =>
            {
                dsDocLeave = x.GetDoctLeaveStat(DOCTORCODE, SEARCHDATE);
            });
            //if (dsDocLeave.Tables[0].Rows.Count == 0)
            //{
            //    RecCount = 0;
            //    return RecCount;
            //}
            return dsDocLeave.Tables[0].Rows.Count;
        }
        //**********************************************************************************************************************************************

        //by vijeta on 13th march 19
        public object GetSurgeries(string strSurgName)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            var surgList = Oncoser.GetSurgeryList();
            if (surgList.Count() > 0)
            {
                var data = (from OncologyEMR.Oncology.SurgListItem t in surgList
                            select new
                            {
                                SurgName = t.Text.ToString(),
                                SurgCode = t.Value.ToString()
                            }
                    ).ToArray(); ;
                return data.Where(x => x.SurgName.ToUpper().Contains(strSurgName.ToUpper())).ToArray(); ;
            }
            return "";
        }
        public object GetSchemeCreditCompList(string PatMRNO, string Speciality, string CreditCompCD)
        {
            CommonServiceClient common = new CommonServiceClient();
            DataSet SchemeList = new DataSet();

            SchemeList.ReadXml(new XmlTextReader(new StringReader(common.GetSchemeSpecialityCompanyWise(CreditCompCD, Speciality))));
            if (SchemeList.Tables.Count == 0 || SchemeList.Tables[0].Rows.Count == 0)
            {
                return "";
            }
            //Modified by Pournima on 1st Sept 2026
            if (CreditCompCD != "")
            {
                var data = (from DataRow row in SchemeList.Tables[0].Rows
                            select new
                            {
                                Text = GeneralFunction.CheckDblToSingleQuote(row["SCHEMENM"].ToString().Trim()),
                                Value = row["SCHEMECD"].ToString().Trim(),
                            }).ToArray();
                return data;
            }
            else
            {
                var CompList = common.GetCrdCompLst("");
                var data = (from DataRow row in SchemeList.Tables[0].Rows
                            select new
                            {
                                CompCode = row["COMPCD"].ToString().Trim(),
                                CompName = ("" + row["COMPCD"].ToString().Trim()) != "" ? GeneralFunction.GetListValue(CompList, row["COMPCD"].ToString().Trim()) : "",
                            }).ToArray();

                return data;
            }
        }

        public object[] GetSchemeDtls(string SchemeCD)
        {
            object[] Obj = new object[2];
            AdminSevRef.AdministrationClient common = new AdminSevRef.AdministrationClient();
            DataSet SchemeList = new DataSet();
            SchemeList.ReadXml(new XmlTextReader(new StringReader(common.GetSchemeMstList(SchemeCD, ""))));
            if (SchemeList.Tables.Contains("SchemeDet") && SchemeList.Tables["SchemeDet"].Rows.Count > 0)
            {
                var data = (from DataRow row in SchemeList.Tables["SchemeDet"].Rows
                            select new
                            {
                                SCHEMENAME = GeneralFunction.CheckDblToSingleQuote(row["SCHEMENM"].ToString().Trim()),
                                PREADVICE = row["PREADVICE"].ToString().Trim(),
                                POSTADVICE = row["POSTADVICE"].ToString().Trim(),
                            }).ToArray();
                Obj[0] = data;
            }
            if (SchemeList.Tables.Contains("ServLnk") && SchemeList.Tables["ServLnk"].Rows.Count > 0)
            {
                var data = (from DataRow row in SchemeList.Tables["ServLnk"].Select("LINKTYPE <> 'S'")
                            select new
                            {
                                SERVNAME = row["SERVNAME"].ToString().Trim(),
                                LINKTYPE = row["LINKTYPE"].ToString().Trim(),
                            }).ToArray();
                Obj[1] = data;
            }
            return Obj;
        }
        #endregion

        public string SaveComplaints(string strComplaints, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strComplaints);
            dt.TableName = "COMPLAINT";
            ds.Tables.Add(dt);

            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "C";
            blOncology.xmlComplaints = ds.GetXml().Replace("&amp;", "");

            return client.SaveDoctorDesk(blOncology);
        }

        public object SetDataForVitals(string strTranNo, string Type, string MRNo = "")
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            str = Oncoser.GetDoctDesk(strTranNo, (Type == "" || Type == null ? "V" : Type), MRNo);
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var data = new
                    {
                        Weight = ds.Tables[0].Rows[0]["WEIGHT"].ToString(),
                        PrevWeight = (ds.Tables[0].Columns.Contains("PREVWEIGHT")) ? ds.Tables[0].Rows[0]["PREVWEIGHT"] : 0,
                        HEIGHT = ds.Tables[0].Rows[0]["HEIGHT"].ToString(),
                        TEMP = ds.Tables[0].Rows[0]["TEMP"].ToString(),
                        PULSE = ds.Tables[0].Rows[0]["PULSE"].ToString(),
                        RESP = ds.Tables[0].Rows[0]["RESP"].ToString(),
                        BP = ds.Tables[0].Rows[0]["BP"].ToString(),
                        VOTHERS = ds.Tables[0].Rows[0]["VOTHERS"].ToString(),
                        WALKINGYN = ds.Tables[0].Rows[0]["WALKINGYN"].ToString(),
                        WALKINGDURATION = ds.Tables[0].Rows[0]["WALKINGDURATION"].ToString(),
                        WALKINGDURTYPE = ds.Tables[0].Rows[0]["WALKINGDURTYPE"].ToString(),
                        DIETYN = ds.Tables[0].Rows[0]["DIETYN"].ToString(),
                        REGULARMEDIYN = ds.Tables[0].Rows[0]["REGULARMEDIYN"].ToString(),
                        SPO2 = ds.Tables[0].Rows[0]["SPO2"].ToString().Trim(),
                        BMI = ds.Tables[0].Rows[0]["BMI"].ToString().Trim(),
                        HEADCIRCMF = ds.Tables[0].Rows[0]["HEADCIRCUMFERENCE"].ToString().Trim(),
                        PEFR = ds.Tables[0].Rows[0]["PEFR"].ToString().Trim(),
                        TECHNIQUE = ds.Tables[0].Rows[0]["TECHNIQUE"].ToString().Trim(),
                        COMPLIANCE = ds.Tables[0].Rows[0]["COMPLIANCE"].ToString().Trim(),

                        ELEPULSE = ds.Tables[0].Rows[0]["ELECTPULSE"].ToString().Trim(),
                        ELEBP = ds.Tables[0].Rows[0]["ELECTBP"].ToString().Trim(),
                        ELETEMP = ds.Tables[0].Rows[0]["ELECTTEMP"].ToString().Trim(),
                        PAINSCORE = ds.Tables[0].Rows[0]["PAINSCORE"].ToString(),
                        BSA = ds.Tables[0].Rows[0]["BSA"].ToString(),
                        RBS = ds.Tables[0].Rows[0]["RBS"].ToString(),
                        KARNOFSKY = ds.Tables[0].Rows[0]["KARNOFSKY"].ToString(),
                        ECOG = ds.Tables[0].Rows[0]["ECOG"].ToString(),
                        PULSECOND = ds.Tables[0].Rows[0]["PULSECOND"].ToString(),
                        IBW = ds.Tables[0].Rows[0]["IBW"].ToString(),
                        BWPERC = ds.Tables[0].Rows[0]["BWPERC"].ToString(),
                        WAISTCIRCUM = ds.Tables[0].Rows[0]["WAISTCIRCUM"].ToString(),
                        HIPCIRCUM = ds.Tables[0].Rows[0]["HIPCIRCUM"].ToString(),
                        WHR = ds.Tables[0].Rows[0]["WHR"].ToString(),
                        NutriScore = ds.Tables[0].Rows[0]["NUTSCORE"].ToString(),
                        NutriScoreNA = ds.Tables[0].Rows[0]["NUTSCORENA"].ToString(),
                        NutriDescreseFoodInTake = ds.Tables[0].Rows[0]["NUTDECFDSCORE"].ToString(),
                        NutriWeightLoss = ds.Tables[0].Rows[0]["NUTWHLOSSCORE"].ToString(),
                        NutriMobility = ds.Tables[0].Rows[0]["NUTMOBISCORE"].ToString(),
                        NutriAcuteDisease = ds.Tables[0].Rows[0]["NUTACUTDISESCORE"].ToString(),
                        NutriNeuropsy = ds.Tables[0].Rows[0]["NUTNEURSCORE"].ToString(),
                        NutriBodyHabit = ds.Tables[0].Rows[0]["NUTBODYSCORE"].ToString(),
                        CMBHEIGHT = ds.Tables[0].Rows[0]["HEIGHTINFOSOURCE"].ToString().Trim(),
                        CMBWEIGHT = ds.Tables[0].Rows[0]["WEIGHTINFOSOURCE"].ToString().Trim(),
                        PROXYVISITYN = ds.Tables[0].Columns.Contains("PROXYVISITYN") ? ds.Tables[0].Rows[0]["PROXYVISITYN"].ToString().Trim() : "N"
                    };
                    return data;
                }
            }
            return "";
        }

        public object GetMedHistory(string MRNo, string TranNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            object[] objToSend = new object[2];
            str = Oncoser.GetDoctDesk(TranNo, "H", MRNo);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.ReadXml(new StringReader(str));
            string strDuration = ""; string strComorbidities = "";
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("Table2"))
                {
                    for (int icnt = 0; icnt < ds.Tables["Table2"].Rows.Count; icnt++)
                    {

                        strDuration = (ds.Tables["Table2"].Rows[icnt]["DURTYPE"].ToString() == "D" ? "Day(s)" : (ds.Tables["Table2"].Rows[icnt]["DURTYPE"].ToString() == "M" ? "Month(s)" : (ds.Tables["Table2"].Rows[icnt]["DURTYPE"].ToString() == "Y" ? "Year(s)" : "")));
                        if (ds.Tables["Table2"].Rows.Count == 1)
                            strComorbidities = ds.Tables["Table2"].Rows[icnt]["NAME"].ToString() + " Since " + ds.Tables["Table2"].Rows[icnt]["DURATION"].ToString() + " " + strDuration;
                        else
                        {
                            if (strComorbidities == "")
                                strComorbidities = ds.Tables["Table2"].Rows[icnt]["NAME"].ToString() + " Since " + ds.Tables["Table2"].Rows[icnt]["DURATION"].ToString() + " " + strDuration;
                            else
                                strComorbidities = strComorbidities + ", " + ds.Tables["Table2"].Rows[icnt]["NAME"].ToString() + " Since " + ds.Tables["Table2"].Rows[icnt]["DURATION"].ToString() + " " + strDuration;
                        }
                    }
                }
                if (ds.Tables.Contains("Table3") && ds.Tables["Table3"].Rows.Count > 0)
                {
                    strComorbidities = strComorbidities + (strComorbidities == "" ? ds.Tables["Table3"].Rows[0]["MEDIHIST"].ToString() : (", " + ds.Tables["Table3"].Rows[0]["MEDIHIST"].ToString()));
                }
                var data = new
                {
                    Comorbidities = strComorbidities,
                };
                return data;
            }
            return "";

            //OncologyEMRClient Oncoser = new OncologyEMRClient();
            //CommonServiceClient comserv = new CommonServiceClient();
            //string str = "";
            //str = Oncoser.GetPatDiagVitalHistory(MRNo);
            //DataSet ds = new DataSet();
            //ds.ReadXml(new StringReader(str));
            //string strDuration = ""; string strComorbidities = "";
            //if (ds.Tables.Count > 0)
            //{
            //    if (ds.Tables[0].Rows.Count > 0)
            //    {
            //        for (int icnt = 0; icnt < ds.Tables[0].Rows.Count; icnt++)
            //        {

            //            strDuration = (ds.Tables[0].Rows[icnt]["DURTYPE"].ToString() == "D" ? "Day(s)" : (ds.Tables[0].Rows[icnt]["DURTYPE"].ToString() == "M" ? "Month(s)" : (ds.Tables[0].Rows[icnt]["DURTYPE"].ToString() == "Y" ? "Year(s)" : "")));
            //            if (ds.Tables[0].Rows.Count == 1)
            //                strComorbidities = ds.Tables[0].Rows[icnt]["NAME"].ToString() + " Since " + ds.Tables[0].Rows[icnt]["DURATION"].ToString() + " " + strDuration;
            //            else
            //            {
            //                if (strComorbidities == "")
            //                    strComorbidities = ds.Tables[0].Rows[icnt]["NAME"].ToString() + " Since " + ds.Tables[0].Rows[icnt]["DURATION"].ToString() + " " + strDuration;
            //                else
            //                    strComorbidities = strComorbidities + ", " + ds.Tables[0].Rows[icnt]["NAME"].ToString() + " Since " + ds.Tables[0].Rows[icnt]["DURATION"].ToString() + " " + strDuration;
            //            }
            //        }
            //        var data = new
            //        {
            //            Comorbidities = strComorbidities,
            //        };
            //        return data;
            //    }
            //}
            //return "";
        }

        public string SaveVitalsTr(string strWeight, string strHeight, string strTemp, string strPulse, string strBlood, string strResp, string strOther, string strPrevWt,
            string strTranno, string strMrNo, string strWalkngYN, string strDietYN, string strMedicineYN, string strWalkDur, string strWalkDurType, string strSPO2, string strBMI,
            string strHeadCirc, string strPEFR, string strTechnique, string strCompliance, string streleTemp, string strelePulse, string streleBlood, string strPainScore,
            string strBSA, string strRBS, string strkarkyscore, string strEcogScore, string strPulseCond
             , string strIBW, string strBWPerc, string strWaistCircum, string strHip, string strWHR,
            string NutriScore, string NutriScoreNA, string NutriDescreseFoodInTake, string NutriWeightLoss, string NutriMobility, string NutriAcuteDisease, string NutriNeuropsy, string NutriBodyHabit, string strCmbWeight, string strCmbHeight, string strProxyVisit)  //Added by Murali on 25/04/2024   
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();

            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            blOncology.TRANNO = strTranno;
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "V";
            blOncology.Weight = string.IsNullOrEmpty(strWeight) ? 0 : Convert.ToDecimal(strWeight);
            blOncology.Height = string.IsNullOrEmpty(strHeight) ? 0 : Convert.ToDecimal(strHeight);
            blOncology.Temp = string.IsNullOrEmpty(strTemp) ? 0 : Convert.ToDecimal(strTemp);
            blOncology.Pulse = strPulse;

            if (strBlood == "/")
                blOncology.Bp = "";
            else
                blOncology.Bp = strBlood;

            blOncology.Resp = strResp;
            blOncology.VOthers = strOther;
            blOncology.WalkingYN = strWalkngYN;
            blOncology.WalkingDur = (strWalkDur == "0") ? "" : strWalkDur;
            blOncology.WalkingDurType = (strWalkDur == "0") ? "" : strWalkDurType;
            blOncology.DietYN = strDietYN;
            blOncology.RegularMediYN = strMedicineYN;

            blOncology.SPO2 = strSPO2;

            blOncology.BMI = strBMI;
            blOncology.HeadCircmf = strHeadCirc;

            blOncology.PEFR = strPEFR;
            blOncology.technique = strTechnique;
            blOncology.compliance = strCompliance;

            if (streleBlood == "/")
                blOncology.ELECBP = "";
            else
                blOncology.ELECBP = streleBlood;

            blOncology.ELECPULSE = strelePulse;
            blOncology.ELECTEMP = streleTemp;

            blOncology.PainScore = strPainScore;
            blOncology.BSA = strBSA;

            blOncology.RBS = strRBS;
            blOncology.karnofsky = strkarkyscore;
            blOncology.ecog = strEcogScore;
            blOncology.PulseCond = strPulseCond;

            //Added by Murali on 25/04/2024 
            //*******************************************
            blOncology.IBW = strIBW;
            blOncology.BWPERC = strBWPerc;
            blOncology.WAISTCIRCUM = strWaistCircum;
            blOncology.HIPCIRCUM = strHip;
            blOncology.WHR = strWHR;
            //*****************************************
            blOncology.NutriScore = "" + NutriScore;
            blOncology.NutriScoreNA = "" + NutriScoreNA;
            blOncology.NutriDescreseFoodInTake = "" + NutriDescreseFoodInTake;
            blOncology.NutriWeightLoss = "" + NutriWeightLoss;
            blOncology.NutriMobility = "" + NutriMobility;
            blOncology.NutriAcuteDisease = "" + NutriAcuteDisease;
            blOncology.NutriNeuropsy = "" + NutriNeuropsy;
            blOncology.NutriBodyHabit = "" + NutriBodyHabit;
            blOncology.HeightInfoSource = "" + strCmbHeight;
            blOncology.WeightInfoSource = "" + strCmbWeight;
            blOncology.ProxyVisitYN = "" + strProxyVisit;
            return Oncoser.SaveDoctorDesk(blOncology);
        }

        //change pwd  
        public string ChangePWD(string uid, string Npwd, string Cpwd)
        {
            //SecurityClient secu = new SecurityClient();
            string pass = client.ChangePassword(uid, Npwd.ToUpper());
            return pass;
        }
        public bool CheckUserExist(string uid, string Opwd)
        {
            //SecurityClient secu = new SecurityClient();
            bool pass = client.ChkLogin(uid, Opwd);
            return pass;
        }

        public object GetMainCompListdt()
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst;

            servlst = comser.GetMainComplaintList();
            DataTable table = new DataTable();
            DataTable dt = new DataTable();

            foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
            {
                dt.Columns.Add(new DataColumn(info.Name, info.PropertyType));
            }
            foreach (BL_GeneralFunctionsSelectLstThreeItem t in servlst)
            {

                DataRow row = dt.NewRow();
                foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
                {
                    row[info.Name] = info.GetValue(t, null);
                }
                dt.Rows.Add(row);

            }
            //  DataRow[] dr = dt.Select("ThirdCd = " + HttpContext.Current.Session["ClinicCode"].ToString());
            //var jsonData = new
            //{
            var rows = (from DataRow row in dt.AsEnumerable()
                        select new
                        {
                            DESCCD = ("" + row["Value"]).Trim(),
                            CHECK = ("" + "False").Trim(),
                            DESC = ("" + row["Text"]).Trim(),
                        }).ToList();
            // };
            return rows;
        }

        public object RetriveMainCompListrevised(string ClinicCode)
        {
            try
            {
                string DoctorCode = string.Empty;
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                ClinicCode = (System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString();  //To fetch a data added by that dr ID only Meenakshi on 21/08/2019
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetMainComplaintFreqList(DoctorCode, ClinicCode)));
                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "UNSUCCESSFULL";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public object GetSubCompListdt()
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst;

            servlst = comser.GetSubComplaintList();
            DataTable table = new DataTable();
            DataTable dt = new DataTable();

            foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
            {
                dt.Columns.Add(new DataColumn(info.Name, info.PropertyType));
            }
            foreach (BL_GeneralFunctionsSelectLstThreeItem t in servlst)
            {
                DataRow row = dt.NewRow();
                foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
                {
                    row[info.Name] = info.GetValue(t, null);
                }
                dt.Rows.Add(row);
            }
            var jsonData = new
            {
                rows = (from DataRow row in dt.AsEnumerable()
                        select new
                        {
                            DESCCD = ("" + row["Value"]).Trim(),
                            GRPCD = ("" + row["ThirdCd"]).Trim(),
                            CHECK = ("" + "False").Trim(),
                            DESC = ("" + row["Text"]).Trim(),
                        })

            };

            return jsonData;
        }


        //Test Result

        public void fillcombos(OncologyModel clOncology)
        {
            clOncology.TestList = client.GetTest();
        }
        public string BindTestResultList(string FromDate, string ToDate, string TestName)
        {
            //CommonServiceClient comclient = new CommonServiceClient();        
            DataSet dsWardDetails = new DataSet();
            DataTable dtWard = new DataTable();
            string details = client.GetTestResultData(GeneralFunction.GetDateInSpecifiedFormat(FromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD)
                , GeneralFunction.GetDateInSpecifiedFormat(ToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD), "", TestName, "");
            dsWardDetails = GeneralFunction.FillDatasetXMl(details);
            if (dsWardDetails.Tables.Count > 0)
            {
                dtWard = dsWardDetails.Tables[0].Copy();
            }
            string jsonDataString = "";

            var jsonData = (from DataRow row in dtWard.AsEnumerable()
                            select new
                            {

                                ResultNo = row["RESULTNO"].ToString().Trim(),
                                ResultDate = GeneralFunction.GetDate(row["RESULTDATE"].ToString().Trim()) + " " + row["RESULTTIME"].ToString().Trim(),
                                // ResultTime = row["RESULTTIME"].ToString().Trim(),
                                InvestName = row["INVESTDESC"].ToString().Trim(),
                                TestName = row["TESTNAME"].ToString().Trim(),
                                Result = row["RESULTDT"].ToString().Trim(),
                            }).ToList();
            JavaScriptSerializer ser = new JavaScriptSerializer();
            ser.MaxJsonLength = int.MaxValue;
            jsonDataString = ser.Serialize(jsonData);
            return jsonDataString;

        }
        //end

        //
        # region diagnosis
        public object SetDataForDiagnosis(string strTranNo, string strMRNO)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            bool HistoryFlag = true;
            string str = Oncoser.GetDoctDesk(strTranNo, "D", strMRNO);
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));
            object[] objData = new object[7];
            DataTable ICDOTopo = new DataTable();
            DataTable ICDOHisto = new DataTable();
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("DIAGNOSIS"))
                {
                    if (ds.Tables["DIAGNOSIS"].Rows.Count > 0)
                    {
                        var data = (from DataRow row in ds.Tables["DIAGNOSIS"].Rows
                                    select new
                                    {
                                        TRANNO = row["TRANNO"].ToString().Trim(),
                                        MRNO = row["MRNO"].ToString().Trim(),
                                        DESCCD = row["DESCCD"].ToString().Trim(),
                                        REMARKS = row["REMARKS"].ToString().Trim(),
                                        NAME = row["NAME"].ToString().Trim(),
                                        SETUPYN = row["SETUPYN"].ToString().Trim()
                                    }
                           ).ToArray();

                        objData[0] = data;

                    }
                }
                if (ds.Tables.Contains("ICDDIAGNOSIS"))
                {

                    var data = (from DataRow row in ds.Tables["ICDDIAGNOSIS"].Rows
                                select new
                                {
                                    TRANNO = row["TRANNO"].ToString().Trim(),
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    ICDCODE = row["ICDCODE"].ToString().Trim(),
                                    NAME = row["NAME"].ToString().Trim(),

                                }
                          ).ToArray();

                    objData[1] = data;
                }
                if (ds.Tables.Contains("DIAGNOSDET"))
                {
                    if (ds.Tables["DIAGNOSDET"].Rows.Count > 0)
                    {
                        var data = (from DataRow row in ds.Tables["DIAGNOSDET"].Rows
                                    select new
                                    {
                                        PROVDIAGNOS = row["PROVDIAG"].ToString().Trim(),
                                        COMPOSTAGE = row["COMPOSTAG"].ToString().Trim(),
                                        TSTAGE = row["TSTAGE"].ToString().Trim(),
                                        NSTAGE = row["NSTAGE"].ToString().Trim(),
                                        MSTAGE = row["MSTAGE"].ToString().Trim(),
                                        SITE = row["DIASITECODE"].ToString().Trim(),
                                        SUBSITE = row["DIASUBSITECODE"].ToString().Trim(),
                                        CANCERYN = row["CANCERYN"].ToString().Trim(),
                                        RADIATIONONCOYN = row["RADIATIONONCO"].ToString().Trim(),
                                        MEDICALONCOYN = row["MEDICALONCO"].ToString().Trim(),
                                        PALLIATIVECAREYN = row["PALLIATIVECARE"].ToString().Trim(),
                                    }
                           ).ToArray();

                        objData[2] = data;

                    }
                }

                if (ds.Tables.Contains("Table3"))
                {
                    if (ds.Tables["Table3"].Rows.Count > 0)
                    {
                        var data = (from DataRow row in ds.Tables["Table3"].Rows
                                    select new
                                    {
                                        SEQNO = row["SEQNO"].ToString().Trim(),
                                        TRANNO = row["TRANNO"].ToString().Trim(),
                                        MRNO = row["MRNO"].ToString().Trim(),
                                        ICDCODE = row["ICODE"].ToString().Trim(),
                                        ICDOCODE = row["ICDOCODE"].ToString().Trim(),
                                        NAME = row["NAME"].ToString().Trim()
                                    }
                           ).ToArray();

                        objData[3] = data;

                    }
                }
                if (ds.Tables.Contains("ICDO"))
                {
                    ICDOTopo = ds.Tables["ICDO"];
                    HistoryFlag = false;
                }
                if (ds.Tables.Contains("ICDOH"))
                {
                    ICDOHisto = ds.Tables["ICDOH"];
                    HistoryFlag = false;
                }
            }
            if (HistoryFlag)
            {
                str = Oncoser.GetDoctDesk(strTranNo, "H", strMRNO);
                DataSet ICDODs = new DataSet();
                ICDODs.ReadXml(new StringReader(str));
                if (ICDODs.Tables.Contains("Table5"))
                    ICDOTopo = ICDODs.Tables["Table5"];
                if (ICDODs.Tables.Contains("Table6"))
                    ICDOHisto = ICDODs.Tables["Table6"];
            }

            if (ICDOTopo.Rows.Count > 0)
            {
                var data = (from DataRow row in ICDOTopo.Rows
                            select new
                            {
                                SITELEVEL = row["SITELEVEL"].ToString().Trim(),
                                TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                                TOPODESC = row["TOPODESC"].ToString().Trim(),
                                TOPOTYPE = row["TOPOTYPE"].ToString().Trim(),
                                TNMSITECODE = row["TNMSITECODE"].ToString().Trim(),
                                TNMSUBSITECODE = row["TNMSUBSITECODE"].ToString().Trim(),
                                TNMPREFIX = row["TNMPREFIX"].ToString().Trim(),
                                T = row["T"].ToString().Trim(),
                                N = row["N"].ToString().Trim(),
                                M = row["M"].ToString().Trim(),
                                STAGE = row["STAGE"].ToString().Trim(),
                                GEOGRAPHIC = row["Geographic"].ToString().Trim(),
                                LOCATION = row["Location"].ToString().Trim(),
                                MITOTIC = row["Mitotic"].ToString().Trim(),
                                PSA = row["PSA"].ToString().Trim(),
                                SERUMMARKERS = row["SerumMarkers"].ToString().Trim(),
                                HERITABLETRAIT = row["HeritableTrait"].ToString().Trim(),
                                HER2 = row["HER2"].ToString().Trim(),
                                ER = row["ER"].ToString().Trim(),
                                PR = row["PR"].ToString().Trim(),
                                BLOODINVL = row["BloodInvl"].ToString().Trim(),
                                //Added By Roshan 17/2/2026
                                FINALDIAGYN = row["FINALDIAGYN"].ToString().ToUpper() == "Y",
                                ADJUVANT = row["ADJUVANT"].ToString().ToUpper(),
                                RECCURENT = row["RECCURENT"].ToString().ToUpper(),
                                //End By Roshan 17/2/2026
                            }).ToArray();
                objData[4] = data;
            }

            if (ICDOHisto.Rows.Count > 0)
            {
                CommonServiceClient Com = new CommonServiceClient();
                var HistoList = Com.ICDHISTOLst("");
                var HistoGradeLst = GeneralFunction.GetHitologyGrade();
                var data = (from DataRow row in ICDOHisto.Rows
                            select new
                            {
                                SITELEVEL = row["SITELEVEL"].ToString().Trim(),
                                TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                                TOPODESC = row["TOPODESC"].ToString().Trim(),
                                TOPOTYPE = row["TOPOTYPE"].ToString().Trim(),
                                HCODE = row["HCODE"].ToString().Trim(),
                                HDESC = row["HDESC"].ToString().Trim(),//      row["HCODE"].ToString().Trim() == "" ? "" : (HistoList.Where(x => x.Value == row["HCODE"].ToString().Trim()).Count() > 0 ? HistoList.Where(x => x.Value == row["HCODE"].ToString().Trim()).FirstOrDefault().Text : ""),
                                HGRADE = row["HGRADE"].ToString().Trim(),
                                HTYPE = row["HTYPE"].ToString().Trim(),
                                HISTOGRADETYPE = row["HISTOGRADETYPE"].ToString().Trim(),
                                GRADENAME = row["HGRADE"].ToString().Trim() == "" ? "" : (HistoGradeLst.Where(x => x.Value == row["HGRADE"].ToString().Trim() && x.GradeType == row["HISTOGRADETYPE"].ToString().Trim()).Count() > 0 ? HistoGradeLst.Where(x => x.Value == row["HGRADE"].ToString().Trim() && x.GradeType == row["HISTOGRADETYPE"].ToString().Trim()).FirstOrDefault().Text : ""),
                            }).ToArray();
                objData[5] = data;
            }
            if (ds.Tables.Contains("ICDO"))
            {
                if (ds.Tables["ICDO"].Rows.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables["ICDO"].Rows
                                select new
                                {
                                    REMARKS = row["REMARKS"].ToString().Trim(),
                                }
                       ).ToArray();

                    objData[6] = data;
                }
            }
            return objData;
        }

        public string SaveDiagnosis(string strDiagnosis, string strICDDiagnosis, string strMRNO, string strTranNo, string Tlst, string Nlst, string Mlst, string Site, string SubSite, string Stage, string ICDOTopoList, string ICDOHistoList,
            string CancerYN, string RadOnco, string MedOnco, string Palliative)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable dtt = new DataTable();
            DataTable dttO = new DataTable();
            DataTable dttH = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strDiagnosis);
            dt.TableName = "DIGNOSIS";
            ds.Tables.Add(dt);
            dtt = JsonConvert.DeserializeObject<DataTable>(strICDDiagnosis);
            dtt.TableName = "ICDDIGNOSIS";
            ds.Tables.Add(dtt);
            dttO = JsonConvert.DeserializeObject<DataTable>(ICDOTopoList);
            dttO.TableName = "ICDODIGNOSIS";
            ds.Tables.Add(dttO);
            dttH = JsonConvert.DeserializeObject<DataTable>(ICDOHistoList);
            dttH.TableName = "ICDOHDIGNOSIS";
            ds.Tables.Add(dttH);

            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.xmlDiagnosis = ds.GetXml().Replace("&amp;", "");
            //Added By Rajan - To Get the TNM List 
            blOncology.type = "H";
            blOncology.TStag = Tlst;
            blOncology.NStag = Nlst;
            blOncology.MStag = Mlst;
            blOncology.DiagnosisSiteCode = Site;
            blOncology.DiagnosisSubSiteCode = SubSite;
            blOncology.CompositStag = Stage;
            blOncology.CancerCaseYN = CancerYN;
            blOncology.RadiationOncoYN = RadOnco;
            blOncology.MedcialOncoYN = MedOnco;
            blOncology.PalliativeCareYN = Palliative;
            client.SaveDoctorDesk(blOncology);
            //End
            blOncology.type = "D";
            return client.SaveDoctorDesk(blOncology);
        }

        public string SaveDiagnosisAddItemdt(string Desc)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();

                Result = Oncoser.SaveDiagnosisAddItem("", Desc, clinicCode, "", User, 1);

                return Result;
            }
            catch (Exception ex)
            {
                //if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                if (ex.Message.Contains("duplicate"))
                {
                    Result = "This diagnosis is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        public object GetDiagnosisListdt(string strClinincode)
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            //IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst;
            //servlst = comser.GetDiagnosisList();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst = Enumerable.Empty<BL_GeneralFunctionsSelectLstThreeItem>();
            DataTable table = new DataTable();
            DataTable dt = new DataTable();

            foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
            {
                dt.Columns.Add(new DataColumn(info.Name, info.PropertyType));
            }
            servlst = comser.GetDiagnosisList();
            foreach (BL_GeneralFunctionsSelectLstThreeItem t in servlst)
            {

                DataRow row = dt.NewRow();
                foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
                {
                    row[info.Name] = info.GetValue(t, null);
                }
                dt.Rows.Add(row);

            }
            //  DataRow[] dr = dt.Select("ThirdCd = " + HttpContext.Current.Session["ClinicCode"].ToString());
            //var jsonData = new
            //{
            var rows = (from DataRow row in dt.AsEnumerable().Where(x => x.Field<string>("ThirdCd").Length > 0 && x.Field<string>("ThirdCd") == strClinincode)
                        select new
                        {
                            DESCCD = ("" + row["Value"]).Trim(),
                            CHECK = ("" + "False").Trim(),
                            DESC = ("" + row["Text"]).Trim(),
                        }).ToList();

            // };

            return rows;
        }

        public object GetICDDiagnosisListdt(string clncCode)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();

            var doctcode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();

            load.ReadXml(new XmlTextReader(new StringReader((client.GetICDDiagnFreqList(clncCode, "")))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];

            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            CODE = ("" + row["CODE"]).Trim(),
                            NAME = ("" + row["NAME"]).Trim(),
                        }).ToArray();

            return rows;
        }

        public object RetriveNonFqtICDlist(string DiagName)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOnco = new OncologyEMRClient();
                if (DiagName.Trim() != "")
                {
                    load.ReadXml(new StringReader(ObjOnco.GetICDDiagnosisList(DiagName)));
                    if (load != null && load.Tables.Count > 0)
                    {
                        string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                        return jsonData;
                    }
                    else
                    {
                        return "";
                    }
                }
                else
                    return "";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object RetriveNonFqtICDOlist(string DiagName, string ICDCode)
        {
            try
            {
                DataSet load = new DataSet();
                if (("" + ICDCode).Trim() != "")
                {
                    CommonServiceClient comser = new CommonServiceClient();
                    var Lst = comser.DDICDOLst(ICDCode.Trim());
                    string jsonLst = JsonConvert.SerializeObject(Lst, Newtonsoft.Json.Formatting.Indented);
                    return jsonLst;
                }
                else if (DiagName.Trim() != "")
                {
                    OncologyEMRClient ObjOnco = new OncologyEMRClient();
                    load.ReadXml(new StringReader(ObjOnco.GetICDODiagnosisList(DiagName)));
                    if (load != null && load.Tables.Count > 0)
                    {
                        string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                        return jsonData;
                    }
                    else
                    {
                        return "";
                    }
                }
                else
                    return "";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetNonFregqentDiagnoList(string NonFreqDiagno, string strClinincode)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOnco = new OncologyEMRClient();
                if (NonFreqDiagno.Trim() != "")
                {
                    load.ReadXml(new StringReader(ObjOnco.NonFregqentDiagno(NonFreqDiagno, strClinincode)));
                    if (load != null && load.Tables.Count > 0)
                    {
                        string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                        return jsonData;
                    }
                    else
                    {
                        return "";
                    }
                }
                else
                    return "";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //added by meenakshi on  3  may 2021
        public string AddDiagnosisDet(string strProvDiagnosis, string CompositStag, string TStage, string NStage, string MStage, string strTran, string strMrNo)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            BL_Oncology blOncology = new BL_Oncology();
            blOncology.TRANNO = strTran;
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "H";
            blOncology.ProviDiagnosis = strProvDiagnosis;
            blOncology.CompositStag = CompositStag;
            blOncology.TStag = TStage;
            blOncology.NStag = NStage;
            blOncology.MStag = MStage;
            return oncoClient.SaveDoctorDesk(blOncology);
        }

        public object GetTNMListForSite(string SiteCode, string SubSiteCode)
        {
            CommonServiceClient Com = new CommonServiceClient();
            string str = "";
            str = Com.GetTNMStaging(SiteCode, SubSiteCode);
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));
            object[] objData = new object[2];
            if (ds.Tables.Count > 0)
            {
                var Alldata = (from DataRow row in ds.Tables[0].Rows
                               select new
                               {
                                   SITE = row["SITE"].ToString().Trim(),
                                   SUBSITE = row["SUBSITE"].ToString().Trim(),
                                   STAGE = row["STAGE"].ToString().Trim(),
                                   T = row["T"].ToString().Trim(),
                                   N = row["N"].ToString().Trim(),
                                   M = row["M"].ToString().Trim(),
                                   PC = row["PC"].ToString().Trim(),
                                   GEOGRAPHIC = row["Geographic"].ToString().Trim(),
                                   LOCATION = row["Location"].ToString().Trim(),
                                   MITOTIC = row["Mitotic"].ToString().Trim(),
                                   PSA = row["PSA"].ToString().Trim(),
                                   SERUMMARKERS = row["Serummarkers"].ToString().Trim(),
                                   HERITABLETRAIT = row["HeritableTrait"].ToString().Trim(),
                                   HER2 = row["HER2"].ToString().Trim(),
                                   ER = row["ER"].ToString().Trim(),
                                   PR = row["PR"].ToString().Trim(),
                                   BLOODINVL = row["Bloodinvl"].ToString().Trim(),
                               }).ToArray();
                objData[0] = Alldata;
                if (ds.Tables.Count > 1)
                {
                    var AlldataDesc = (from DataRow row in ds.Tables[1].Rows
                                       select new
                                       {
                                           SITE = row["SITE"].ToString().Trim(),
                                           SUBSITE = row["SUBSITE"].ToString().Trim(),
                                           TNM = row["TNM"].ToString().Trim(),
                                           DESCRIPTION = row["DESCRIPTION"].ToString().Trim(),
                                           PC = row["PC"].ToString().Trim()
                                       }).ToArray();
                    objData[1] = AlldataDesc;
                }
            }
            return objData;
        }

        public object GetICDOHistory(string MRNo, string Type)           //vandana 200226
        {
            OncologyEMRClient ObjOnco = new OncologyEMRClient();
            string str = ObjOnco.GetDiagnosisChangeHistory(MRNo);
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));
            object[] objData = new object[3];
            if (ds.Tables.Count > 0)
            {
                var Doct = ObjOnco.GetDoctLst("", "D");
                //var PrefixLst = GeneralFunction.GetPrefixTNM();
                var TopoData = (from DataRow row in ds.Tables[0].Rows
                                where (Type == "Final" ? row["FinalDiagYN"].ToString() == "Y" : true)
                                select new
                                {
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    SITELEVEL = row["SITELEVEL"].ToString().Trim(),
                                    TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                                    TOPODESC = row["TOPODESC"].ToString().Trim(),
                                    TOPOTYPE = row["TOPOTYPE"].ToString().Trim(),
                                    TNMSITE = row["TNMSITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["TNMSITECODE"].ToString().Trim(), ""),
                                    TNMSUBSITE = row["TNMSUBSITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["TNMSITECODE"].ToString().Trim(), row["TNMSUBSITECODE"].ToString().Trim()),
                                    //TNMPREFIX = row["TNMPREFIX"].ToString().Trim() == "" ? "" : PrefixLst.Where(x => x.Value == row["TNMPREFIX"].ToString().Trim()).Count() > 0 ? PrefixLst.Where(x => x.Value == row["TNMPREFIX"].ToString().Trim()).FirstOrDefault().Text : "",
                                    TNMPREFIX = row["TNMPREFIX"].ToString().Trim(),
                                    T = row["T"].ToString().Trim(),
                                    N = row["N"].ToString().Trim(),
                                    M = row["M"].ToString().Trim(),
                                    GEOGRAPHIC = row["Geographic"].ToString().Trim(),
                                    LOCATION = row["Location"].ToString().Trim(),
                                    MITOTIC = row["Mitotic"].ToString().Trim(),
                                    PSA = row["PSA"].ToString().Trim(),
                                    SERUMMARKERS = row["Serummarkers"].ToString().Trim(),
                                    HERITABLETRAIT = row["HeritableTrait"].ToString().Trim(),
                                    HER2 = row["HER2"].ToString().Trim(),
                                    ER = row["ER"].ToString().Trim(),
                                    PR = row["PR"].ToString().Trim(),
                                    BLOODINVL = row["Bloodinvl"].ToString().Trim(),
                                    STAGE = row["STAGE"].ToString().Trim(),
                                    CREATEDBY = row["CREATEDBY"].ToString().Trim() == "" ? "" : (Doct.Where(X => X.Value == row["CREATEDBY"].ToString().Trim()).Count() > 0 ? Doct.Where(X => X.Value == row["CREATEDBY"].ToString().Trim()).First().Text : ""),
                                    CREATEDON = GeneralFunction.GetDate(row["CREATEDON"].ToString().Trim()),
                                    CREATEDAT = row["CREATEDAT"].ToString().Trim(),
                                    REMARKS = row["REMARKS"].ToString().Trim(),
                                    REFTRANNO = row["REFTRANNO"].ToString().Trim()
                                }).ToArray();
                objData[0] = TopoData;
                if (ds.Tables.Count > 1)
                {
                    var HistoGradeLst = GeneralFunction.GetHitologyGrade();
                    var HistoData = (from DataRow row in ds.Tables[1].Rows
                                     select new
                                     {
                                         MRNO = row["MRNO"].ToString().Trim(),
                                         SITELEVEL = row["SITELEVEL"].ToString().Trim(),
                                         TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                                         TOPODESC = row["TOPODESC"].ToString().Trim(),
                                         TOPOTYPE = row["TOPOTYPE"].ToString().Trim(),
                                         HCODE = row["HCODE"].ToString().Trim(),
                                         HDESC = row["HDESC"].ToString().Trim(),
                                         HGRADE = row["HGRADE"].ToString().Trim(),
                                         GRADENAME = row["HGRADE"].ToString().Trim() == "" ? "" : (HistoGradeLst.Where(x => x.Value == row["HGRADE"].ToString().Trim() && x.GradeType == row["GRADETYPE"].ToString().Trim()).Count() > 0 ? HistoGradeLst.Where(x => x.Value == row["HGRADE"].ToString().Trim() && x.GradeType == row["GRADETYPE"].ToString().Trim()).FirstOrDefault().Text : ""),
                                         HTYPE = row["HTYPE"].ToString().Trim(),
                                         CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                         CREATEDON = GeneralFunction.GetDate(row["CREATEDON"].ToString().Trim()),
                                         CREATEDAT = row["CREATEDAT"].ToString().Trim(),
                                         REFTRANNO = row["REFTRANNO"].ToString().Trim(),
                                     }).ToArray();
                    objData[1] = HistoData;
                }

                var filteredRows = ds.Tables[0].AsEnumerable()
    .Where(row => Type == "Final" ? row["FinalDiagYN"].ToString() == "Y" : true)
    .ToList();

                DataTable filteredTable = new DataTable();
                if (filteredRows.Any())
                {
                    filteredTable = filteredRows.CopyToDataTable();
                }
                else
                {
                    // If no rows match, create an empty DataTable with the same schema
                    filteredTable = ds.Tables[0].Clone();
                }
                DataView viewDate = new DataView(filteredTable);/*new DataView(ds.Tables[0]);*/
                DataTable ConsDataDT = viewDate.ToTable(true, "REFTRANNO", "CREATEDBY", "CREATEDON", "CREATEDAT", "REMARKS");
                var ConsData = (from DataRow row in ConsDataDT.Rows
                                select new
                                {
                                    REFTRANNO = row["REFTRANNO"].ToString().Trim(),
                                    CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                    CREATEDON = GeneralFunction.GetDate(row["CREATEDON"].ToString().Trim()),
                                    CREATEDAT = row["CREATEDAT"].ToString().Trim(),
                                    REMARKS = row["REMARKS"].ToString().Trim(),
                                }).ToArray();
                objData[2] = ConsData;

            }
            return objData;
        }
        //Added By Priyanka on 25/01/2025
        //**********************************************************
        #region ICD Diagnosis Setup
        //Added By Priyanka on 25/01/2025

        public object GetNonFrequentICDDiagnosisListdt(string DiagName)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetICDDiagnosisList(DiagName)))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];

            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            CODE = ("" + row["CODE"]).Trim(),
                            NAME = ("" + row["NAME"]).Trim(),
                            CHECK = ("" + "False").Trim(),
                        }).ToArray();

            return rows;
        }
        //Added By Priyanka on 25/01/2025
        public object GetICDDiagnoListBySetupCode(string strSetUpCode)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var strDoctCode = Convert.ToString(HttpContext.Current.Session["gDoctCode"]);
            ds.ReadXml(new XmlTextReader(new StringReader(oncoClient.GetListBySetUpCode(strSetUpCode, strDoctCode, "D"))));
            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    CODE = row["CODE"].ToString().Trim(),
                                    NAME = row["NAME"].ToString().Trim(),
                                }
                                ).ToArray();
                    return data;
                }
            }
            return "";
        }
        //Added By Priyanka on 25/01/2025
        public string AddICDDiagnosisSetUp(string strICDDiagnSetUpName, string strICDDiagnLst, string strICDDiagNameLst, string strICDDiagSetUpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                BL_PersonalSetUp bl = new BL_PersonalSetUp();
                //string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                //string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
                bl.DoctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                bl.SetUpName = strICDDiagnSetUpName;
                bl.SetUpType = "D";
                bl.SetupCode = strICDDiagSetUpCode;//added on 7/3/19
                string[] codesArray = strICDDiagnLst.Split(',');
                //string[] namesArray = strICDDiagNameLst.Split(',');//added on 19th May 2018

                //string[] namesArray = Regex.Split(strICDDiagNameLst, @",\s*(?=A\d{3,4})");
                string[] namesArray = Regex.Split(strICDDiagNameLst, @",\s*(?=[A-Z]\d{2}\.?\d*)"); //priyanka 14/03/2026

                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                dt.Columns.Add("ICDCODE");
                dt.Columns.Add("ICDNAME");
                dt.Columns.Add("SEQNO");
                int count = 0;
                foreach (string s in codesArray)
                {
                    DataRow row1 = dt.NewRow();

                    row1["ICDCODE"] = s;
                    row1["ICDNAME"] = namesArray[count];//added on 19th May 2018
                    row1["SEQNO"] = count + 1;
                    count++;
                    dt.Rows.Add(row1);
                }
                ds.Tables.Add(dt);
                dt.TableName = "LIST";
                ds.DataSetName = "DETAIL";

                bl.SetUpLstXml = ds.GetXml();
                //DataSet dataSet = namesArray.ToDataSet();
                //XDocument doc = new XDocument();
                //doc.Add(new XElement("DETAIL", namesArray.Select(x => new XElement("LIST", x))));
                Result = Oncoser.SavePersonalisedSetUp(bl);
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                {
                    Result = "This complaint is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        //Added By Priyanka on 27/01/2025
        public object GetPersICDDiagnoList()
        {
            try
            {
                DoctorCode = string.Empty;
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataSet ds = new DataSet();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetPersICDSetupLst(DoctorCode)));
                if (ds != null && ds.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "UNSUCCESSFULL";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //Added by Priyanka on 27/01/2025
        public string SavePerICDDiagnosis(string Code, string strTranNO, string strMRNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            onc.type = "N";
            onc.TranMode = 1;

            onc.TRANNO = "" + strTranNO;
            onc.InvestOther = Code;
            onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
            onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
            onc.MRNO = "" + strMRNo;
            string strResult = client.SaveDoctorDesk(onc);
            return strResult;
        }

        //**********************************************************
        //Added By Priyanka on 14/02/2025
        #region Diagnosis Setup
        public object GetNonFregqentDiagnoListForSetup(string NonFreqDiagno, string strClinincode)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader((client.NonFregqentDiagno(NonFreqDiagno, strClinincode)))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table1"];

            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            CODE = ("" + row["CODE"]).Trim(),
                            NAME = ("" + row["NAME"]).Trim(),
                        }).ToArray();

            return rows;
        }

        public object GetPersDiagnoList()
        {
            try
            {
                DoctorCode = string.Empty;
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataSet ds = new DataSet();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetPersDiagSetupLst(DoctorCode)));
                if (ds != null && ds.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "UNSUCCESSFULL";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetDiagnosisListBySetupCode(string strSetUpCode)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var strDoctCode = Convert.ToString(HttpContext.Current.Session["gDoctCode"]);
            ds.ReadXml(new XmlTextReader(new StringReader(oncoClient.GetListBySetUpCode(strSetUpCode, strDoctCode, "G"))));
            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    CODE = row["CODE"].ToString().Trim(),
                                    NAME = row["NAME"].ToString().Trim(),
                                }
                                ).ToArray();
                    return data;
                }
            }
            return "";
        }

        public string AddDiagnosisSetUp(string strDiagnSetUpName, string strDiagnLst, string strDiagNameLst, string strDiagSetUpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                BL_PersonalSetUp bl = new BL_PersonalSetUp();
                //string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                //string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
                bl.DoctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                bl.SetUpName = strDiagnSetUpName;
                bl.SetUpType = "G";
                bl.SetupCode = strDiagSetUpCode;//added on 7/3/19
                string[] codesArray = strDiagnLst.Split(',');
                string[] namesArray = strDiagNameLst.Split(',');//added on 19th May 2018

                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                dt.Columns.Add("DIAGCODE");
                dt.Columns.Add("DIAGNAME");
                dt.Columns.Add("SEQNO");
                int count = 0;
                foreach (string s in codesArray)
                {
                    DataRow row1 = dt.NewRow();

                    row1["DIAGCODE"] = s;
                    row1["DIAGNAME"] = namesArray[count];
                    row1["SEQNO"] = count + 1;
                    count++;
                    dt.Rows.Add(row1);
                }
                ds.Tables.Add(dt);
                dt.TableName = "LIST";
                ds.DataSetName = "DETAIL";

                bl.SetUpLstXml = ds.GetXml();

                Result = Oncoser.SavePersonalisedSetUp(bl);
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                {
                    Result = "This complaint is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        public string SavePersonDiagnosisSetup(string Code, string strTranNO, string strMRNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            onc.type = "DI";
            onc.TranMode = 1;

            onc.TRANNO = "" + strTranNO;
            onc.InvestOther = Code;
            onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
            onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
            onc.MRNO = "" + strMRNo;
            string strResult = client.SaveDoctorDesk(onc);
            return strResult;
        }
        #endregion
        //********************************************************

        #endregion

        #endregion

        #region Examination
        public string SaveexamTr(string strExam, string strTranno, string strMrNo, string OtherHistory, string PassHistYN)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();

            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            blOncology.TRANNO = strTranno;
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "E";
            blOncology.ExamDet = strExam;
            blOncology.PastHist = OtherHistory;
            if (PassHistYN == "Y")
            {
                string json = "";
                DataSet load = new DataSet();
                json = Oncoser.GetDoctDesk(strTranno, "S", strMrNo);
                load = GeneralFunction.FillDatasetXMl(json);
                json = load.Tables.Contains("EXAMS") == true ? (load.Tables["EXAMS"].Rows.Count > 0 ? load.Tables["EXAMS"].Rows[0]["PASTHIST"].ToString() : "") : "";
                blOncology.PastHist = json;
            }
            return Oncoser.SaveDoctorDesk(blOncology);
        }
        public object GetExamdt(string Tran, string Type)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            blOncology.TRANNO = Tran;
            //blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = Type;
            // blOncology.ExamDet = strExam;
            string json = Oncoser.GetDoctDesk(blOncology.TRANNO, blOncology.type, "");

            ds = GeneralFunction.FillDatasetXMl(json);
            if (ds.Tables.Count > 0) //if condition added by vijeta on 2nd march 2018
            {
                dt = ds.Tables[0];
                var exam = (from DataRow row in dt.AsEnumerable()
                            select new
                            {
                                EXAM = ("" + row["EXAM"]).Trim(),
                                PASTHIST = ("" + row["PASTHIST"]).Trim(),
                            }).ToList();
                return exam;
            }
            return "";
        }
        public List<string> GetExaminationImages(string MrNo, string TranNo)
        {
            try
            {
                int fileCount = 0;
                string[] filePaths = { };
                List<string> ListofFileBytes = new List<string>();
                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                var Pic_Path = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString().Trim() + @"\PrescriptionImages\" + strUnit;  // System.Web.HttpContext.Current.Server.MapPath("~/PrescriptionImages");
                var subpath = Pic_Path + @"\" + MrNo;
                var TranPath = Pic_Path + @"\" + MrNo + @"\" + TranNo;
                string countpath = TranPath.Replace(@"\", @"/");

                if (Directory.Exists(TranPath))
                {
                    fileCount = Directory.GetFiles(TranPath).Length;
                }
                if (fileCount > 0)
                {
                    filePaths = Directory.GetFileSystemEntries(countpath);

                    for (int i = 0; i < fileCount; i++)
                    {

                        var fileNo = filePaths[i].Substring(filePaths[i].LastIndexOf('_') + 1, 2);

                        byte[] fileBytes = System.IO.File.ReadAllBytes(filePaths[i]);

                        ListofFileBytes.Add(fileNo + "|" + Convert.ToBase64String(fileBytes.ToArray()));
                    }

                }
                return ListofFileBytes;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region chemoplan
        public object GetchemoHistory(string strMrno)
        {
            OncologyEMRClient OncoEMRser = new OncologyEMRClient();
            OncologyClient Oncoser = new OncologyClient();

            DataSet ds = new DataSet();
            string str = OncoEMRser.GetPrevProtocolList(strMrno);

            ds.ReadXml(new StringReader(str));

            object jsondata = new object();
            object jsondata1 = new object();

            if (ds.Tables.Count > 0 && ds.Tables.Contains("Table1"))
            {
                DataTable complaintsTable = ds.Tables["Table1"];
                var DoctLst = OncoEMRser.GetDoctLst("", "D");
                var SpecList = OncoEMRser.GetSpecialistnList();
                if (complaintsTable.Rows.Count > 0)
                {
                    jsondata = (from DataRow row in complaintsTable.Rows
                                select new
                                {
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    TRANDATE = row["TRANDATE"].ToString().Trim(),
                                    CYCLENO = row["CYCLENO"].ToString().Trim(),
                                    DAY = row["DAY"].ToString().Trim(),
                                    STARTDATE = row["STARTDATE"].ToString().Trim(),
                                    ENDDATE = row["ENDDATE"].ToString().Trim(),
                                    CHEMOTHERAPYNM = row["CHEMOTHERAPYNM"].ToString().Trim(),
                                    PLANID = row["PLANID"].ToString().Trim(),
                                    NAME = row["NAME"].ToString().Trim(),
                                    PROTOCOL = row["PROTOCOL"].ToString().Trim(),
                                    MODIFYMEDS = row["MODIFYMEDS"].ToString().Trim(),
                                    TOTALCYCLE = row["TOTALCYCLE"].ToString().Trim(),
                                    DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                    DOCTSP = ("" + row["DOCTNAME"]).ToString().Trim() == "" ? "" : GeneralFunction.GetSpecialityDoctor(DoctLst, SpecList, "", ("" + row["DOCTNAME"]).ToString().Trim()),
                                    TREATMENTCOMPLETESTATUS = string.IsNullOrEmpty(row["COMPLETESTATUS"]?.ToString().Trim()) ? ""
                                                              : GeneralFunction.LstConStatus.FirstOrDefault(x => x.Value == row["COMPLETESTATUS"].ToString().Trim())?.Text,
                                    CONCLUSIONREMARK = ("" + row["CONSLREMARKS"].ToString().Trim())
                                }).ToArray();
                }
                if (ds.Tables.Count > 1)
                {
                    CommonServiceClient cs = new CommonServiceClient();
                    DataTable HistTable = ds.Tables["Table2"];
                    var MedType = GeneralFunction.MedType();
                    var DoseCalculation = GeneralFunction.DoseCalculation();
                    var DrugType = GeneralFunction.GetDrugFormList();
                    var RouteList = OncoEMRser.GetRouteList();
                    var DilutionVolume = GeneralFunction.DilutionVolumeChemo();
                    var MedicalSetNo = GeneralFunction.MedicalSetNo();
                    var AdministrationDurations = GeneralFunction.AdministrationDurationChemo();
                    var PHGenericNAmesLst = cs.GetPHGenericNAmesLst();
                    var ProtocoleName = cs.GetChemoNameLst().Where(x => x.Status == "A");
                    jsondata1 = (from DataRow row in HistTable.Rows
                                 select new
                                 {
                                     MRNO = row["MRNO"].ToString().Trim(),
                                     PLANID = row["TRANNO"].ToString().Trim(),
                                     MEDTYPE = row["MEDTYPE"].ToString().Trim() == "" ? "" : (MedType.Where(x => x.Value == row["MEDTYPE"].ToString().Trim()).Count() > 0 ? MedType.Where(x => x.Value == row["MEDTYPE"].ToString().Trim()).FirstOrDefault().Text : row["MEDTYPE"].ToString().Trim()),
                                     MEDSETNO = row["MEDSETNO"].ToString().Trim() == "" ? "" : (MedicalSetNo.Where(x => x.Value == row["MEDSETNO"].ToString().Trim()).Count() > 0 ? MedicalSetNo.Where(x => x.Value == row["MEDSETNO"].ToString().Trim()).FirstOrDefault().Text : row["MEDSETNO"].ToString().Trim()),
                                     GENERICID = row["GENERICID"].ToString().Trim(),
                                     GENERICNM = row["GENERICID"].ToString().Trim() == "" ? "" : (PHGenericNAmesLst.Where(x => x.Value == row["GENERICID"].ToString().Trim()).Count() > 0 ? PHGenericNAmesLst.Where(x => x.Value == row["GENERICID"].ToString().Trim()).FirstOrDefault().Text : row["GENERICID"].ToString().Trim()),
                                     DOSE = row["DOSE"].ToString(),
                                     DOSEUNIT = row["DOSEUNIT"].ToString(),
                                     CALCULATEON = row["CALCULATEON"].ToString().Trim() == "" ? "" : (DoseCalculation.Where(x => x.Value == row["CALCULATEON"].ToString().Trim()).Count() > 0 ? DoseCalculation.Where(x => x.Value == row["CALCULATEON"].ToString().Trim()).FirstOrDefault().Text : row["CALCULATEON"].ToString().Trim()),
                                     ROUTECD = (row["ROUTECD"].ToString().Trim()) == "" ? "" : (RouteList.Where(x => x.Value == row["ROUTECD"].ToString().Trim()).Count() > 0 ? RouteList.Where(x => x.Value == row["ROUTECD"].ToString().Trim()).FirstOrDefault().Text : row["ROUTECD"].ToString().Trim()),
                                     FREQUENCY = row["FREQUENCY"].ToString().Trim(),
                                     DILNTGENCD = row["DILNTGENCD"].ToString().Trim(),
                                     DILUENT = row["DILUENT"].ToString().Trim(),
                                     VOLDILTN = (row["VOLDILTN"].ToString().Trim()) == "" ? "" : (DilutionVolume.Where(x => x.Value == row["VOLDILTN"].ToString().Trim()).Count() > 0 ? DilutionVolume.Where(x => x.Value == row["VOLDILTN"].ToString().Trim()).FirstOrDefault().Text : row["VOLDILTN"].ToString().Trim()),
                                     DURATION = (row["DURATION"].ToString().Trim()) == "" ? "" : (AdministrationDurations.Where(x => x.Value == row["DURATION"].ToString().Trim()).Count() > 0 ? AdministrationDurations.Where(x => x.Value == row["DURATION"].ToString().Trim()).FirstOrDefault().Text : row["DURATION"].ToString().Trim()),
                                     ADMINSEQNO = row["ADMINSEQNO"].ToString().Trim() == "" ? "" : (MedicalSetNo.Where(x => x.Value == row["ADMINSEQNO"].ToString().Trim()).Count() > 0 ? MedicalSetNo.Where(x => x.Value == row["ADMINSEQNO"].ToString().Trim()).FirstOrDefault().Text : row["ADMINSEQNO"].ToString().Trim()),
                                     APLYTODAY = row["APLYTODAY"].ToString().Trim(),
                                     REMARKS = row["REMARKS"].ToString().Trim(),
                                     ORIGINALDOSE = row["DOSE"].ToString(),
                                     OMITDRUG = row["OMITDRUG"].ToString().Trim(),
                                     CYCLENO = row["CYCLENO"].ToString().Trim(),
                                     DRUGFORM = row["DRUGFORM"].ToString().Trim() == "" ? "" : (DrugType.Where(x => x.Value == row["DRUGFORM"].ToString().Trim()).Count() > 0 ? DrugType.Where(x => x.Value == row["DRUGFORM"].ToString().Trim()).FirstOrDefault().Text : row["DRUGFORM"].ToString().Trim()),
                                     ONDAY = row["ONDAY"].ToString().Trim()
                                 }).ToArray();
                }
            }
            return new { data = jsondata, data1 = jsondata1, success = true };
        }
        //public object GetCycleCount(string Mrno)
        //{
        //    OncologyEMR.OncologyServRef.OncologyClient Oncoser = new OncologyEMR.OncologyServRef.OncologyClient();
        //    DataSet ds = new DataSet();
        //    string str = Oncoser.SGetChemoCycle(Mrno);

        //    ds.ReadXml(new StringReader(str));

        //    object jsondata = new object();

        //    if (ds.Tables.Count > 0 && ds.Tables.Contains("Table"))
        //    {
        //        DataTable complaintsTable = ds.Tables["Table"];
        //        if (complaintsTable.Rows.Count > 0)
        //        {
        //            jsondata = (from DataRow row in complaintsTable.Rows
        //                        select new
        //                        {
        //                            CYCLENO =row["CYCLENO"].ToString().Trim()
        //                        }).ToArray();
        //        }
        //    }
        //    return jsondata;
        //}
        public object GetCycleCount(string MrNo, string StrProtocole)
        {
            DataSet ds = new DataSet();
            OncologyClient onco = new OncologyClient();
            ds.ReadXml(new XmlTextReader(new StringReader(onco.SGetChemoCycle(MrNo, StrProtocole))));
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var jsonData = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    CYCLENO = row["CYCLENO"].ToString().Trim()
                                }).ToList();

                return new { data = jsonData, success = true };

            }
            else
            {
                return "[]";
            }
        }

        #endregion chemoplan

        #region clinicalNotes
        public string SaveNotes(string notes, string strTranno, string strMrNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            blOncology.TRANNO = strTranno;
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "1";
            blOncology.ClinicalNotes = notes;
            var result = Oncoser.SaveDoctorDesk(blOncology);
            return result;

        }
        public object GetClinicalNotes(string Tran, string Type)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            blOncology.TRANNO = Tran;
            //blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = Type;
            // blOncology.ExamDet = strExam;
            string json = Oncoser.GetDoctDesk(blOncology.TRANNO, blOncology.type, "");

            ds = GeneralFunction.FillDatasetXMl(json);
            if (ds.Tables.Count > 0) //if condition added by vijeta on 2nd march 2018
            {
                dt = ds.Tables[0];
                var exam = (from DataRow row in dt.AsEnumerable()
                            select new
                            {
                                CLINICALHIST = ("" + row["CLINICALHIST"]).Trim()

                            }).ToList();
                return exam;
            }
            return "";
        }
        public object GetPreviousNotes(string strMrno)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            DataSet ds = new DataSet();
            string str = Oncoser.GetPrevClinicalNotes(strMrno);
            ds.ReadXml(new StringReader(str));

            object jsondata = new object();

            if (ds.Tables.Count > 0 && ds.Tables.Contains("Table1"))
            {
                DataTable complaintsTable = ds.Tables["Table1"];
                if (complaintsTable.Rows.Count > 0)
                {
                    jsondata = (from DataRow row in complaintsTable.Rows
                                select new
                                {
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                    CLINICALHIST = row["CLINICALHIST"].ToString().Trim(),
                                    PLANID = row["TRANNO"].ToString().Trim()

                                }).ToArray();
                }
            }

            return jsondata;
        }

        #endregion clinicalNotes

        //#region Completed
        //public string SavecompleteTr(string strTranno)
        //{
        //    BL_Oncology blOncology = new BL_Oncology();
        //    OncologyEMRClient Oncoser = new OncologyEMRClient();

        //    blOncology.TRANNO = strTranno;
        //    // blOncology.MRNO = strMrNo;
        //    blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
        //    blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
        //    blOncology.TranMode = 5;
        //    blOncology.type = "";
        //    // blOncology.ExamDet = strExam;

        //    // return("SUCCESS");
        //    return Oncoser.SaveDoctorDesk(blOncology);
        //}
        //#endregion

        #region InvestigationTran
        public string SaveInvestigation(string strInvest, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strInvest);

            dt.TableName = "INVEST";

            foreach (DataRow drRow in dt.Rows)
            {
                string Remark = "";
                if (drRow["TESTNAME"].ToString().Contains("-"))
                    Remark = drRow["TESTNAME"].ToString().Substring(drRow["TESTNAME"].ToString().LastIndexOf("-"));

                drRow["TESTNAME"] = drRow["TESTNAME"].ToString().Contains('[') ? drRow["TESTNAME"].ToString().Substring(0, drRow["TESTNAME"].ToString().LastIndexOf("[")) : drRow["TESTNAME"].ToString().Trim();
            }

            ds.Tables.Add(dt);

            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "I";
            blOncology.xmlInvest = ds.GetXml().Replace("&amp;", "");

            return client.SaveDoctorDesk(blOncology);
        }

        public object GetInvestigationList(string strDoctorCd, string strTranNo)
        {
            //object jsonData = string.Empty;
            //CommonServiceClient comserv = new CommonServiceClient();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetFreqTest(strDoctorCd, strTranNo)))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];
            // if (l_oDT.Rows.Count > 0)
            //{
            // jsonData = new
            // {
            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            TESTCODE = ("" + row["TESTCODE"]).Trim(),
                            //TESTNAME = ("" + row["TESTNAME"]).Trim() + "&nbsp;&nbsp[" + ("" + row["SERVCOST"]).Trim() + "]&nbsp;&nbsp",

                            TESTNAME = ("" + row["TESTNAME"]).Trim(),
                            CNT = ("" + row["CNT"]).Trim()
                        }).ToArray();
            //};
            //}
            return rows;
        }

        public object SetDataForInvestigation(string strTranNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            object[] objToSend = new object[2];//added on 20th march 19
            str = Oncoser.GetDoctDesk(strTranNo, "I", "");
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("INVEST"))
                {
                    if (ds.Tables["INVEST"].Rows.Count > 0)
                    {
                        var data = (from DataRow row in ds.Tables["INVEST"].Rows
                                    select new
                                    {
                                        TESTCODE = row["TESTCODE"].ToString().Trim(),
                                        TESTNAME = row["TESTNAME"].ToString().Trim(),
                                        DURATION = row["DURATION"].ToString().Trim(),
                                        DURTYPE = row["DURTYPE"].ToString().Trim(),
                                        //CNT = row["CNT"].ToString().Trim(),
                                        REMARKS = row["REMARK"].ToString().Trim(), // added by vijeta on  30th march 2018
                                        SETUPYN = row["SETUPYN"].ToString().Trim() // added by vijeta on  25/7/19
                                    }
                           ).ToArray();

                        objToSend[0] = data;
                    }
                }

                //added on 22nd march 19
                if (ds.Tables.Contains("FREEINVESTIGATION"))
                {
                    if (ds.Tables["FREEINVESTIGATION"].Rows.Count > 0)
                    {
                        var data = (
                                    from DataRow row in ds.Tables["FREEINVESTIGATION"].Rows
                                    select new
                                    {
                                        FreeInvestigation = row["FREEINVST"].ToString().Trim()
                                    }).ToArray();
                        objToSend[1] = data;
                    }
                }
            }
            return objToSend;
        }
        public object RetriveTestList(string TestName, string strTranNo)
        {
            //object jsonData = string.Empty;
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            var strServType = GeneralFunction.GetAppsettingUnitWiseValue("ServTypes").ToString().Trim();
            load.ReadXml(new XmlTextReader(new StringReader(client.GetMatchedTest(TestName, strServType, strTranNo))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];
            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            TESTCODE = ("" + row["TESTCODE"]).Trim(),
                            //TESTNAME = ("" + row["TESTNAME"]).Trim() + "&nbsp;&nbsp;[" + ("" + row["SERVCOST"]).Trim() + "]&nbsp;&nbsp",
                            TESTNAME = ("" + row["TESTNAME"]).Trim(),

                            //TESTNAME = ("" + row["TESTNAME"]).Trim()  ,
                            CNT = ("" + 0).Trim()
                        }).ToArray();
            return rows;
        }


        public object GetPersInvestigationList()
        {
            try
            {
                DoctorCode = string.Empty;
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataSet ds = new DataSet();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetPersInvestigations(DoctorCode)));
                if (ds != null && ds.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "UNSUCCESSFULL";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public string SavePerInvestigationTran(string Code, string strTranNO, string strMRNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            onc.type = "Z";
            onc.TranMode = 1;

            onc.TRANNO = "" + strTranNO;
            onc.InvestOther = Code;
            onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
            onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
            onc.MRNO = "" + strMRNo;
            string strResult = client.SaveDoctorDesk(onc);
            return strResult;
        }

        //added on 2nd may 2018
        public void FillCombo(OncologyModel mdl)
        {
            OncologyEMRClient comserv = new OncologyEMRClient();
            ServiceGrpLst = comserv.GetServGrpList();
        }

        public string AddInvestnSetUp(string strInvestSetUpName, string strInvestigationLst, string strNameLst, string strSetUpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                BL_PersonalSetUp bl = new BL_PersonalSetUp();
                //string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                //string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
                bl.DoctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                bl.SetUpName = strInvestSetUpName;
                bl.SetUpType = "I";
                bl.SetupCode = strSetUpCode;//added on 7/3/19
                string[] codesArray = strInvestigationLst.Split(',');
                string[] namesArray = strNameLst.Split(',');//added on 19th May 2018

                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                dt.Columns.Add("TESTCODE");
                dt.Columns.Add("TESTNAME");
                dt.Columns.Add("SEQNO");
                int count = 0;
                foreach (string s in codesArray)
                {
                    DataRow row1 = dt.NewRow();

                    row1["TESTCODE"] = s;
                    row1["TESTNAME"] = namesArray[count];//added on 19th May 2018
                    row1["SEQNO"] = count + 1;
                    count++;
                    dt.Rows.Add(row1);
                }
                ds.Tables.Add(dt);
                dt.TableName = "LIST";
                ds.DataSetName = "DETAIL";

                bl.SetUpLstXml = ds.GetXml();
                //DataSet dataSet = namesArray.ToDataSet();
                //XDocument doc = new XDocument();
                //doc.Add(new XElement("DETAIL", namesArray.Select(x => new XElement("LIST", x))));
                Result = Oncoser.SavePersonalisedSetUp(bl);
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                {
                    Result = "This Investigation is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        //added by vij on 7/3/19
        public object GetInvstListBySetupCode(string strSetUpCode)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var strDoctCode = Convert.ToString(HttpContext.Current.Session["gDoctCode"]);
            ds.ReadXml(new XmlTextReader(new StringReader(oncoClient.GetListBySetUpCode(strSetUpCode, strDoctCode, "I"))));
            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    CODE = row["CODE"].ToString().Trim(),
                                    TESTNAME = row["NAME"].ToString().Trim(),
                                    SETUPCODE = strSetUpCode
                                }
                                ).ToArray();
                    return data;
                }
            }
            return "";
        }

        //added on 18th march 19
        public string AddFreeInvestigation(string strInvestigation, string strTranNo, string strMrNo)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            BL_Oncology blOncology = new BL_Oncology();
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "G";
            blOncology.FreeInvestigation = strInvestigation;
            return oncoClient.SaveDoctorDesk(blOncology);
        }
        #endregion

        #region History
        public object GetHistory(string strMrNo)
        {
            Dictionary<string, object> dict = new Dictionary<string, object>();
            object jsonFamily = string.Empty;
            object jsonPersonal = string.Empty;
            object jsonMedical = string.Empty;
            object jsonAllergy = string.Empty;
            object jsonFreeFamily = string.Empty;//vijeta 25th march 19
            object jsonFreePersonal = string.Empty;//vijeta 25th march 19
            object jsonFreeMedical = string.Empty;//vijeta 25th march 19


            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetDoctDesk("", "O", strMrNo))))); // type 'H' changed to type 'O' vijeta 25th march 19
            //if (load.Tables.Count > 0)
            if (load.Tables[0].Rows.Count > 0)
            {
                if (load.Tables.Contains("Table"))
                {
                    l_oDT = load.Tables["Table"];
                    jsonFamily = (from DataRow row in l_oDT.Rows
                                  select new
                                  {
                                      // MRNO = ("" + row["MRNO"]).Trim(),
                                      NAME = ("" + row["NAME"]).Trim(),
                                      AGE = ("" + row["AGE"]).Trim(),
                                      RELATION = ("" + row["RELATION"]).Trim(),
                                      //STATUS = ("" + row["STATUS"]).Trim(),
                                      DISEASES = ("" + row["DISEASES"]).Trim(),
                                      DURATION = ("" + row["DURATION"]).Trim(),
                                      DURTYPE = ("" + row["DURTYPE"]).Trim(),
                                      REMARKS = ("" + row["REMARKS"]).Trim()
                                  }).ToArray();
                }
                if (load.Tables.Contains("Table1"))
                {
                    l_oDT = load.Tables["Table1"];
                    jsonPersonal = (from DataRow row in l_oDT.AsEnumerable()
                                    select new
                                    {
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        ADDICTCD = ("" + row["ADDICTCD"]).Trim(),
                                        STARTAGE = GetDaysString(("" + row["STARTAGE"]).Trim()),// added by vijeta on 19th april 2018
                                        STOPAGE = ("" + row["STOPAGE"]).Trim(),
                                        NAME = ("" + row["NAME"]).Trim(),
                                    }).ToArray();
                }
                if (load.Tables.Contains("Table2"))
                {
                    l_oDT = load.Tables["Table2"];
                    jsonMedical = (from DataRow row in l_oDT.AsEnumerable()
                                   select new
                                   {
                                       MRNO = ("" + row["MRNO"]).Trim(),
                                       MEDCD = ("" + row["MEDCD"]).Trim(),
                                       DURATION = ("" + row["DURATION"]).Trim(),
                                       DURTYPE = ("" + row["DURTYPE"]).Trim(),
                                       NAME = ("" + row["NAME"]).Trim(),
                                   }).ToArray();
                }

                //kavita 23-sep-2019
                if (load.Tables.Contains("Table4"))
                {
                    l_oDT = load.Tables["Table4"];
                    var AllergyTypeLst = GeneralFunction.GetAllergyTypeList();
                    jsonAllergy = (from DataRow row in l_oDT.AsEnumerable()
                                   select new
                                   {
                                       MRNO = ("" + row["MRNO"]).Trim(),
                                       ALLERGYCD = ("" + row["ALLERGYCD"]).Trim(),
                                       DURATION = ("" + row["DURATION"]).Trim(),
                                       DURTYPE = ("" + row["DURTYPE"]).Trim(),
                                       REMARKS = ("" + row["REMARKS"]).Trim(),
                                       NAME = ("" + row["NAME"]).Trim(),
                                       ALLERGYTYPE = ("" + row["ALLERGYTYPE"]).Trim() == "" ? "" : (AllergyTypeLst.Where(x => x.Value == ("" + row["ALLERGYTYPE"]).Trim()).Count() > 0 ? AllergyTypeLst.Where(x => x.Value == ("" + row["ALLERGYTYPE"]).Trim()).FirstOrDefault().Text : "")
                                   }).ToArray();
                }
                //vijeta 25th march 19
                if (load.Tables.Contains("Table3"))
                {
                    l_oDT = load.Tables["Table3"];
                    var jsonData = (from DataRow row in l_oDT.AsEnumerable()
                                    where ("" + row["FAMHIST"]).Trim() != ""
                                    select new
                                    {
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()),
                                        FAMHIST = ("" + row["FAMHIST"]).Trim(),
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonFreeFamily = jsonData;
                    else
                        jsonFreeFamily = "";

                }
                //vijeta 25th march 19
                if (load.Tables.Contains("Table3"))
                {
                    l_oDT = load.Tables["Table3"];
                    var jsonData = (from DataRow row in l_oDT.AsEnumerable()
                                    where ("" + row["PERSHIST"]).Trim() != ""
                                    select new
                                    {
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()),
                                        PERSHIST = ("" + row["PERSHIST"]).Trim(),
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonFreePersonal = jsonData;
                    else
                        jsonFreePersonal = "";

                }

                //vijeta 25th march 19
                if (load.Tables.Contains("Table3"))
                {
                    l_oDT = load.Tables["Table3"];
                    var jsonData = (from DataRow row in l_oDT.AsEnumerable()
                                    where ("" + row["MEDIHIST"]).Trim() != ""
                                    select new
                                    {
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()),
                                        MEDHIST = ("" + row["MEDIHIST"]).Trim(),
                                    }).ToArray();
                    if (jsonData.Length > 0)
                        jsonFreeMedical = jsonData;
                    else
                        jsonFreeMedical = "";

                }
                dict.Add("jsonFamily", jsonFamily);
                dict.Add("jsonPersonal", jsonPersonal);
                dict.Add("jsonMedical", jsonMedical);
                dict.Add("jsonAllergy", jsonAllergy);

                dict.Add("jsonFreeFamily", jsonFreeFamily);//vijeta 25th march 19
                dict.Add("jsonFreePersonal", jsonFreePersonal);//vijeta 25th march 19
                dict.Add("jsonFreeMedical", jsonFreeMedical);//vijeta 25th march 19
            }
            //return dict;
            if (dict.Count > 0)
            {
                return dict;
            }
            else
                return "";
        }

        // added by vijeta on 19th april 2018
        public string GetDaysString(string str)
        {
            if (str == "W")
                return "Weeks";
            else if (str == "D")
                return "Days";
            else if (str == "M")
                return "Months";
            else if (str == "Y")
                return "Years";
            else
                return "";
        }

        public object PatTumorTreatmentDet(string strMrName)
        {
            OncologyClient client = new OncologyClient();
            DataSet ds = new DataSet();
            var str = client.GetTBDTreatmentDet(strMrName);
            CommonServiceClient comm = new CommonServiceClient();
            var Surgery = comm.GetAllSurgeryLst();
            var Chemo = comm.GetChemoNameLst();

            ds.ReadXml(new XmlTextReader(new StringReader(str)));

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var data = (from DataRow row in ds.Tables[0].Rows
                            select new
                            {
                                TRANNO = row["TRANNO"].ToString().Trim(),
                                MRNO = row["MRNO"].ToString().Trim(),
                                TREATMENTNAME = row["TREATMENTNAME"].ToString().Trim(),
                                TREATMENTDET = row["TREATMENTNAME"].ToString().Trim() == "Surgery"
                                    ? (Surgery.Where(x => x.Value == ("" + row["TREATMENTDET"]).ToString().Trim()).Any()
                                        ? Surgery.Where(x => x.Value == ("" + row["TREATMENTDET"]).ToString().Trim()).First().Text
                                        : "")
                                    : row["TREATMENTNAME"].ToString().Trim() == "Chemotherapy"
                                        ? (Chemo.Where(x => x.Value == ("" + row["TREATMENTDET"]).Trim()).Any()
                                            ? Chemo.Where(x => x.Value == ("" + row["TREATMENTDET"]).Trim()).First().Text
                                            : "")
                                        : row["TREATMENTDET"].ToString().Trim(),
                                CYCLENO = row["CYCLENO"].ToString().Trim(),
                                TREATMENTDATE = GeneralFunction.GetDate(row["TREATMENTDATE"].ToString().Trim()),
                                REMARKS = row["REMARKS"].ToString().Trim()
                            }).ToArray();

                return data;
            }

            return "";
        }

        #endregion

        #region Patient Advice
        public string SavePatadvAddItemdt(string strPatAdv)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();

                // if (GrpCode.Trim() == "")
                Result = Oncoser.SavePatAdviceAddItem("", strPatAdv, clinicCode, "", User, 1);

                return Result;
            }
            catch (Exception ex)
            {
                //if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                if (ex.Message.Contains("Cannot insert duplicate key"))
                {
                    // Result = "This Patient Advice is allready Present.";
                    Result = "This Advice is allready Present.Please enter in search box."; //Meenakshi on 21/08/2019
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        public object GetPatAdvList(string ClinicCode)
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst;
            DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            ClinicCode = (System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString(); //To fetch a data added by that dr ID only Meenakshi on 21/08/2019
            servlst = comser.GetPatAdviceList(DoctorCode, ClinicCode);

            DataTable table = new DataTable();
            DataTable dt = new DataTable();

            foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
            {
                dt.Columns.Add(new DataColumn(info.Name, info.PropertyType));
            }
            foreach (BL_GeneralFunctionsSelectLstThreeItem t in servlst)
            {

                DataRow row = dt.NewRow();
                foreach (PropertyInfo info in typeof(BL_GeneralFunctionsSelectLstThreeItem).GetProperties())
                {
                    row[info.Name] = info.GetValue(t, null);
                }
                dt.Rows.Add(row);

            }

            var rows = (from DataRow row in dt.AsEnumerable()
                        select new
                        {
                            DESCCD = ("" + row["Value"]).Trim(),
                            CHECK = ("" + "False").Trim(),
                            DESC = ("" + row["Text"]).Trim(),
                        }).ToList();

            // };

            return rows;
        }
        public string SavePatAdv(string strPatAdv, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strPatAdv);
            dt.TableName = "PATADVICE";
            ds.Tables.Add(dt);

            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "P";
            blOncology.xmlPatAdvice = ds.GetXml().Replace("&amp;", "");

            return client.SaveDoctorDesk(blOncology);
        }
        public object SetDataForPatAdv(string strTranNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            str = Oncoser.GetDoctDesk(strTranNo, "P", "");
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));
            object[] objToSend = new object[2];//added on 20th march 19
            if (ds.Tables.Contains("Table"))
            {
                if (ds.Tables["Table"].Rows.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables["Table"].Rows
                                select new
                                {
                                    TRANNO = row["TRANNO"].ToString().Trim(),
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    DESCCD = row["DESCCD"].ToString().Trim(),
                                    SETUPYN = row["SETUPYN"].ToString().Trim(),
                                    DESC = row["ADVNAME"].ToString().Trim()
                                }
                       ).ToArray();
                    objToSend[0] = data;
                }
            }
            if (ds.Tables.Contains("Table1"))
            {
                if (ds.Tables["Table1"].Rows.Count > 0)
                {
                    var data = (
                                from DataRow row in ds.Tables["Table1"].Rows
                                select new
                                {
                                    FreePatAdvice = row["FREEADVICE"].ToString().Trim()
                                }).ToArray();
                    objToSend[1] = data;
                }
            }
            return objToSend;
        }


        public object RetriveDBPatAdvice(string PatAdvice, string ClinicCode)
        {
            //object jsonData = string.Empty;
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader(client.GetAdviceByName(PatAdvice, ClinicCode))));

            if (load != null && load.Tables.Count > 0)
            {
                string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                return jsonData;
            }
            else
            {
                return "";// 16-12-19
            }
        }

        public string AddFreePatAdvice(string strAdvice, string strTranNo, string strMrNo)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            BL_Oncology blOncology = new BL_Oncology();
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "2";
            blOncology.FreeAdvice = strAdvice;
            return oncoClient.SaveDoctorDesk(blOncology);
        }

        //added on 6th sep 2018
        #region Patient Advice Personalized
        public object GetPersPatientAdviceList()
        {
            try
            {
                DoctorCode = string.Empty;
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataSet ds = new DataSet();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetPersPatAdvices(DoctorCode)));
                if (ds != null && ds.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string AddPatAdviceSetUp(string strPatAdviceSetUpName, string strAdviceLst, string strNameLst, string strSetUpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                BL_PersonalSetUp bl = new BL_PersonalSetUp();

                bl.DoctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                bl.SetUpName = strPatAdviceSetUpName;
                bl.SetUpType = "P";
                bl.SetupCode = strSetUpCode;//added by vij on 7/3/19
                string[] codesArray = strAdviceLst.Split(',');
                string[] namesArray = strNameLst.Split(',');

                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                dt.Columns.Add("PATADVICECODE");
                dt.Columns.Add("NAME");
                dt.Columns.Add("SEQNO");
                int count = 0;
                foreach (string s in codesArray)
                {
                    DataRow row1 = dt.NewRow();

                    row1["PATADVICECODE"] = s;
                    row1["NAME"] = namesArray[count];
                    row1["SEQNO"] = count + 1;

                    count++;
                    dt.Rows.Add(row1);
                }
                ds.Tables.Add(dt);
                dt.TableName = "LIST";
                ds.DataSetName = "DETAIL";

                bl.SetUpLstXml = ds.GetXml();

                Result = Oncoser.SavePersonalisedSetUp(bl);
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                {
                    Result = "This set up is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        public string SavePersonalizedAdvces(string Code, string strTranNO, string strMRNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            onc.type = "Q";
            onc.TranMode = 1;

            onc.TRANNO = "" + strTranNO;
            onc.InvestOther = Code;
            onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
            onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
            onc.MRNO = "" + strMRNo;
            string strResult = client.SaveDoctorDesk(onc);
            return strResult;
        }

        public object GetAdvicesBySetUpCode(string strCode, string strType)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            DataSet ds = new DataSet();
            var str = "";
            str = oncoClient.GetListBySetUpCode(strCode, HttpContext.Current.Session["gDoctCode"].ToString(), strType);
            ds.ReadXml(new StringReader(str));
            if (ds != null && ds.Tables.Count > 0)
            {
                string jsonData = JsonConvert.SerializeObject(ds.Tables[0], Newtonsoft.Json.Formatting.Indented);
                return jsonData;
            }
            else
            {
                return "Unsucessfull";
            }

        }

        //added by vij on 6/3/19
        public object GetPatAdvcListBySetupCode(string strSetUpCode)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var strDoctCode = Convert.ToString(HttpContext.Current.Session["gDoctCode"]);
            ds.ReadXml(new XmlTextReader(new StringReader(oncoClient.GetListBySetUpCode(strSetUpCode, strDoctCode, "E"))));
            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select row["EXAMDET"].ToString().Trim()

                                ).ToArray();
                    return data;
                }
            }
            return "";
        }
        #endregion
        //-----------------------------------

        #endregion

        #region PatPresc
        public object GetPatPresc(string strMRNO)
        {
            //CommonServiceClient comserv = new CommonServiceClient();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            if (strMRNO != null && strMRNO != "")
            {
                load.ReadXml(new XmlTextReader(new StringReader((client.GetPatientConsList(strMRNO)))));
            }

            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];
            // if (l_oDT.Rows.Count > 0)
            //{
            // jsonData = new
            // {
            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            TRANDATE = ("" + GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim())),
                            TRANNO = ("" + row["TRANNO"]).Trim(),
                            DOCTNAME = ("" + row["DOCTNAME"]).Trim(),//added on 30th aug 2018
                            DOCTCODE = ("" + row["DOCTCODE"]).Trim(),//added on 20th sep 2018
                            //CNT = ("" + row["CNT"]).Trim()
                        }).ToArray();

            return rows;
        }

        public string SaveCopy(string PrevTranNo, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "Y";
            blOncology.PrevTranNo = PrevTranNo;
            blOncology.CIMSYN = System.Web.HttpContext.Current.Session["CIMYN"].ToString().Trim();
            SaveExaminationPrevTran(PrevTranNo, strTranNo, strMRNO);
            return client.SaveDoctorDesk(blOncology);
        }

        public string SaveExaminationPrevTran(string PrevTranNo, string strTranNo, string strMRNO)
        {
            string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            var Pic_Path = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString().Trim() + "/PrescriptionImages/" + strUnit;

            string PrevPath = Pic_Path + @"\" + strMRNO + @"\" + PrevTranNo;
            string DesPath = Pic_Path + @"\" + strMRNO + @"\" + strTranNo;

            if (Directory.Exists(PrevPath))
            {
                if (Directory.Exists(DesPath))
                {
                    Directory.Delete(DesPath, true);
                }

                CopyDirectory(PrevPath, DesPath);
            }

            return "";
        }

        private void CopyDirectory(string sourceDir, string destDir)
        {
            Directory.CreateDirectory(destDir);

            // Copy files
            foreach (string file in Directory.GetFiles(sourceDir))
            {
                string destFile = Path.Combine(destDir, Path.GetFileName(file));
                File.Copy(file, destFile, true);
            }

            // Copy subdirectories
            foreach (string folder in Directory.GetDirectories(sourceDir))
            {
                string destFolder = Path.Combine(destDir, Path.GetFileName(folder));
                CopyDirectory(folder, destFolder);
            }
        }

        public object SetDataForPrescriptionPrint(string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            CommonServiceClient com = new CommonServiceClient();
            var CompList = com.GetCrdCompLst("");
            ds.ReadXml(new XmlTextReader(new StringReader(client.GetDoctDesk(strTranNo, "L", ""))));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("FOLLOWUP"))
                {
                    //input = Regex.Replace(input, "[^0-9]+", string.Empty);
                    string dur = "0", durType = "Days"; string SurgyAdvice = string.Empty; string SurgyAdviceCode = string.Empty; string SurgyAdviceDate = string.Empty; string PACAdviceDT = string.Empty; string NatureSurgy = string.Empty;
                    string NotesLst = "";

                    dur = ds.Tables["FOLLOWUP"].Rows[0]["FOLLOWUPDT"].ToString() != "" ? Regex.Replace(ds.Tables["FOLLOWUP"].Rows[0]["FOLLOWUPDT"].ToString(), "[^0-9]+", string.Empty) : "0";
                    durType = ds.Tables["FOLLOWUP"].Rows[0]["FOLLOWUPDT"].ToString() != "" ? new String(ds.Tables["FOLLOWUP"].Rows[0]["FOLLOWUPDT"].ToString().Where(Char.IsLetter).ToArray()) : "Days";
                    SurgyAdvice = ds.Tables["FOLLOWUP"].Rows[0]["SURGNMADVICE"].ToString() != "" ? ds.Tables["FOLLOWUP"].Rows[0]["SURGNMADVICE"].ToString() : string.Empty;
                    SurgyAdviceCode = ds.Tables["FOLLOWUP"].Rows[0]["SURGADVCODES"].ToString() != "" ? ds.Tables["FOLLOWUP"].Rows[0]["SURGADVCODES"].ToString() : string.Empty;
                    SurgyAdviceDate = ds.Tables["FOLLOWUP"].Rows[0]["SURGADVDATE"].ToString() != "" ? GeneralFunction.GetDate("" + ds.Tables["FOLLOWUP"].Rows[0]["SURGADVDATE"].ToString().Trim()) : string.Empty;
                    PACAdviceDT = ds.Tables["FOLLOWUP"].Rows[0]["PACADVDATE"].ToString() != "" ? GeneralFunction.GetDate("" + ds.Tables["FOLLOWUP"].Rows[0]["PACADVDATE"].ToString().Trim()) : string.Empty;
                    NatureSurgy = ds.Tables["FOLLOWUP"].Rows[0]["SURGADVTYPE"].ToString() != "" ? ds.Tables["FOLLOWUP"].Rows[0]["SURGADVTYPE"].ToString() : string.Empty;

                    if (ds.Tables.Contains("REFDOCTORNOTE"))
                    {
                        var rows = (from DataRow row in ds.Tables["REFDOCTORNOTE"].Rows
                                    select new
                                    {
                                        TRANNO = ("" + row["TRANNO"]).Trim(),
                                        MRNO = ("" + row["MRNO"]).Trim(),
                                        DOCTCODE = ("" + row["DOCTCODE"]).Trim(),
                                        REFDOCTCODE = ("" + row["REFDOCTCODE"]).Trim(),
                                        NOTE = ("" + row["NOTE"]).Trim(),
                                        STATUS = ("" + row["STATUS"]).Trim()
                                    }).ToArray();
                        NotesLst = JsonConvert.SerializeObject(rows, Newtonsoft.Json.Formatting.Indented);
                    }



                    var data = new
                    {
                        DURATION = dur,
                        DURATIONTYPE = durType,
                        REFDOCTNAME = ds.Tables["FOLLOWUP"].Rows[0]["DOCTNAME"].ToString(),
                        SURGNMADVICE = SurgyAdvice,
                        REFSPECIALIST = "" + ds.Tables["FOLLOWUP"].Rows[0]["REFSPECIALIST"].ToString(),
                        APPMNTDT = GeneralFunction.GetDate("" + ds.Tables["FOLLOWUP"].Rows[0]["APPMNTDT"].ToString().Trim()),
                        APPMNTTM = "" + ds.Tables["FOLLOWUP"].Rows[0]["APPMNTTM"].ToString().Trim(),
                        REMARK = "" + ds.Tables["FOLLOWUP"].Rows[0]["PRESCREMARK"].ToString().Trim(),
                        PLANOFTREAT = "" + ds.Tables["FOLLOWUP"].Rows[0]["PLANOFTREAT"].ToString().Trim(),
                        CALLDONEYN = "" + ds.Tables["FOLLOWUP"].Rows[0]["CALLDONEYN"].ToString().Trim(),
                        ADMADVYN = "" + ds.Tables["FOLLOWUP"].Rows[0]["ADMNADVYN"].ToString().Trim(),
                        TBDREFYN = "" + ds.Tables["FOLLOWUP"].Rows[0]["TBDREFYN"].ToString().Trim(),         // Added by Dhananjay 20241005
                        PROPADMNDT = GeneralFunction.GetDate("" + ds.Tables["FOLLOWUP"].Rows[0]["PROPADMNDT"].ToString().Trim()),
                        CARETYPE = "" + ds.Tables["FOLLOWUP"].Rows[0]["PATCARETYPEADVICE"].ToString().Trim(), // Added by Rajan 
                        SURGNMADVICECODE = SurgyAdviceCode,// Added by Rajan 
                        ADVICEDATE = SurgyAdviceDate,// Added by Rajan 
                        PACADVICEDATE = PACAdviceDT, // Added by Rajan 
                        NATUREOFSURGY = NatureSurgy, // Added by Rajan 
                        NOTELIST = NotesLst, // Added by Rajan 
                        SCHEMECODE = ("" + ds.Tables["FOLLOWUP"].Rows[0]["SCHEMECODES"]).ToString().Trim(),  // Added by Rajan 
                        LEVELOFURGENCY = ("" + ds.Tables["FOLLOWUP"].Rows[0]["ADMNURGENCYLEVEL"]).ToString().Trim(),
                        ADMADVREMARK = ("" + ds.Tables["FOLLOWUP"].Rows[0]["ADMNADVREMARKS"]).ToString().Trim(),
                        SURGADVICEOTHER = ("" + ds.Tables["FOLLOWUP"].Rows[0]["SURGADVICEOTHER"].ToString().Trim()), // Pournima 18th Aug 2026
                        REQSCHEMECOMPCODE = ("" + ds.Tables["FOLLOWUP"].Rows[0]["REQSCHEMECOMPCODE"].ToString().Trim()), // Pournima 2nd Sept 2026
                        REQSCHEMECOMPNM = ("" + ds.Tables["FOLLOWUP"].Rows[0]["REQSCHEMECOMPCODE"].ToString().Trim()) != "" ? GeneralFunction.GetListValue(CompList, ds.Tables["FOLLOWUP"].Rows[0]["REQSCHEMECOMPCODE"].ToString().Trim()) : "", // Pournima 2nd Sept 2026
                    };
                    return data;
                }
            }
            return false;
        }
        #endregion
        //end

        #region Ivestigation Report
        //function for Retrive Investigation

        public object RetriveInvestiResult(string MrnNo)
        {
            try
            {

                DataSet load = new DataSet();
                DataTable dt = new DataTable();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                //string data = ObjOncologyEMRClient.GetInvestResult(MrnNo);

                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetInvestResult(MrnNo)));

                if (load.Tables.Contains("Table1"))
                {
                    load.Tables[0].Columns.Add("DATETIME", System.Type.GetType("System.DateTime"));
                    load.Tables[0].Columns.Add("DateTimeString");
                    load.Tables[0].Columns.Add("SEQUENCENo", typeof(Int32));
                    IFormatProvider culture = new System.Globalization.CultureInfo("fr-FR", true);
                    for (int i = 0; i < load.Tables[0].Rows.Count; i++)
                    {
                        string s = GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()) + " " + load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim();
                        DateTime dtdatev = DateTime.Parse(s, culture, System.Globalization.DateTimeStyles.AssumeLocal);
                        load.Tables[0].Rows[i]["TESTNAME"] = load.Tables[0].Rows[i]["TESTNAME"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["INVESTDESC"] = load.Tables[0].Rows[i]["INVESTDESC"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["DATETIME"] = dtdatev;
                        load.Tables[0].Rows[i]["SEQUENCENo"] = load.Tables[0].Rows[i]["SEQUENCE"].ToString() != "" ? Int16.Parse(load.Tables[0].Rows[i]["SEQUENCE"].ToString()) : 0; // changed by vijeta on 23rd july 2018
                        //load.Tables[0].Rows[i]["DATETIME"] = string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim()) != "" ? Convert.ToDateTime(string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim())) : DateTime.Now;
                        load.Tables[0].Rows[i]["DateTimeString"] = string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim().Substring(0, 5));
                    }

                    DataView viewDate = new DataView(load.Tables[0]);
                    viewDate.Sort = "DATETIME desc";

                    DataTable distinctValues = viewDate.ToTable(true, "DateTimeString");
                    DataTable ViewDistInvestValues = viewDate.ToTable(true, "TESTNAME", "INVESTDESC");

                    load.Tables[1].Columns.Add("NORMRANGE");
                    load.Tables[1].Columns.Add("SEQUENCENo", typeof(Int32));

                    for (int i = 0; i < distinctValues.Rows.Count; i++)
                    {
                        load.Tables[1].Columns.Add(distinctValues.Rows[i]["DateTimeString"].ToString());
                    }


                    for (int n = 0; n < load.Tables[1].Rows.Count; n++)
                    {
                        DataRow[] dmrow = load.Tables[0].Select("INVESTDESC='" + load.Tables[1].Rows[n]["INVESTDESC"].ToString().Trim().Replace("'", "") + "'AND TESTNAME='" + load.Tables[1].Rows[n]["TESTNAME"].ToString().Trim().Replace("'", "") + "'");
                        for (int p = 0; p < dmrow.Length; p++)
                        {
                            load.Tables[1].Rows[n][dmrow[p][13].ToString()] = GetResultWithAbNorm(dmrow[p][5].ToString(), dmrow[p][8].ToString(), dmrow[p][9].ToString(), dmrow[p][7].ToString(), dmrow[p][10].ToString());
                        }
                        load.Tables[1].Rows[n]["NORMRANGE"] = dmrow[0][6].ToString();
                        load.Tables[1].Rows[n]["TESTNAME"] = dmrow[0][1].ToString().ToString();
                        load.Tables[1].Rows[n]["INVESTDESC"] = dmrow[0][2].ToString().ToString();
                        load.Tables[1].Rows[n]["SEQUENCENo"] = dmrow[0][14];
                    }

                    var dtInvestigatetbl = load.Tables[1].AsEnumerable()
                 .OrderBy(r => r.Field<Int32>("SEQUENCENo"))
                 .CopyToDataTable();


                    var dtInvestigatetbl1 = dtInvestigatetbl.AsEnumerable()
                .OrderBy(r => r.Field<string>("TESTNAME"))
                .CopyToDataTable();

                    distinctValues.Columns["DateTimeString"].ColumnName = "DATETIME";
                    dtInvestigatetbl1.TableName = "Investigate";

                    distinctValues.TableName = "TblDate";
                    load.Tables.Remove("Table1");
                    load.Tables.Remove("Table2");
                    load.Tables.Add(distinctValues);
                    load.Tables.Add(dtInvestigatetbl1);
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }

                else
                {
                    return "No Data Found";
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        string GetResultWithAbNorm(string strResult, string strNormVal1, string strNormval2, string strResultType, string strDefVal)
        {
            string result = "";

            if (strResultType == "V" || strResultType == "O")
            {
                if (strNormval2 != "" && strNormval2 != "")
                {
                    double iValue = 0;

                    bool testResult = double.TryParse(strResult, out iValue);

                    bool testNormVal1 = double.TryParse(strNormVal1, out iValue);

                    bool testNormVal2 = double.TryParse(strNormval2, out iValue);

                    if (testResult == true && testNormVal1 == true && testNormVal2 == true)
                    {
                        if (Convert.ToDouble(strResult) < Convert.ToDouble(strNormVal1) || Convert.ToDouble(strResult) > Convert.ToDouble(strNormval2))
                        {
                            result = "<span style=color:red><b>" + strResult + "</b></span>";
                        }
                        else
                        {
                            result = "<span style=color:green><b>" + strResult + "</b></span>";
                        }
                    }
                    else
                    {
                        result = "<span style=color:green><b>" + strResult + "</b></span>";
                    }
                }
                else
                    result = "<span style=color:green><b>" + strResult + "</b></span>";
            }
            else if (strResultType == "F")
            {
                if (strDefVal.Trim() != "")
                {
                    if (strResult.Trim() != strDefVal.Trim())
                    {
                        // result = "<span style=color:red><b>" + strResult.Replace(@"\", @"\\").Replace(@"""", @"\""").Replace("\"", "") + "</b></span>";
                        result = "<span style=color:red><b>" + strResult.Replace("\"", "") + "</b></span>";

                    }
                    else
                        //  result = "<span style=color:green><b>" + strResult.Replace(@"\", @"\\").Replace(@"""", @"\""").Replace("\"", "") + "</b></span>";
                        result = "<span style=color:green><b>" + strResult.Replace("\"", "") + "</b></span>";
                }
                else
                    //  result = "<span style=color:green><b>" + strResult.Replace(@"\", @"\\").Replace(@"""", @"\""").Replace("\"", "") + "</b></span>";
                    result = "<span style=color:green><b>" + strResult.Replace("\"", "") + "</b></span>";
            }
            else
                //  result = "<span style=color:green><b>" + strResult.Replace(@"\", @"\\").Replace(@"""", @"\""").Replace("\"", "") + "</b></span>";
                result = "<span style=color:green><b>" + strResult.Replace("\"", "") + "</b></span>";
            return result;
        }

        // Added by Dhananjay 20240712 - Retrive Culture Data Based on Result No - 
        public string RetrieveCultureResult(string MrnNo, string strFrmDate, string strTodate)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                var sDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetCultureResult(MrnNo, sDate, tDate)));
                if (load != null && load.Tables.Count > 0)
                {
                    DataTable table = load.Tables[0];

                    // Create a dictionary to group data by RESULTNO
                    Dictionary<string, Dictionary<string, object>> groupedResults = new Dictionary<string, Dictionary<string, object>>();

                    foreach (DataRow row in table.Rows)
                    {
                        string resultNo = row["RESULTNO"].ToString().Trim();

                        if (!groupedResults.ContainsKey(resultNo))
                        {
                            groupedResults[resultNo] = new Dictionary<string, object>
                        {
                            { "TESTNAME" , row["TESTNAME"].ToString().Trim() },
                            { "VERIFIEDBY", table.Columns.Contains("VERIFIEDBY") ? row["VERIFIEDBY"].ToString().Trim() : "" },
                            { "VERIFIEDAT", row["VERIFIEDAT"].ToString().Trim() },
                            { "VERIFIEDON", row["VERIFIEDON"].ToString().Trim() },
                            { "RESULTNO", resultNo },
                            { "RESULTDATE", row["RESULTDATE"].ToString().Trim() },
                            { "RESULTTIME", row["RESULTTIME"].ToString().Trim() },
                            { "CULTCOMMENT" , row["CULTCOMMENT"].ToString().Trim() },

                            { "CultureResults", new List<Dictionary<string, string>>() }
                        };
                        }

                        // Add result details
                        var cultureResult = new Dictionary<string, string>
                    {
                        { "ANTIBIOTIC", row["ANTIBIOTIC"].ToString().Trim() },
                        { "MICVALUE", row["MICVALUE"].ToString().Trim() },
                        { "Column1", row["Column1"].ToString().Trim() },
                        { "CULTYPE", row["CULTYPE"].ToString().Trim() }
                    };

                        var resultsList = (List<Dictionary<string, string>>)groupedResults[resultNo]["CultureResults"];
                        if (!resultsList.Contains(cultureResult)) // Check for duplicates
                        {
                            resultsList.Add(cultureResult);
                        }
                    }

                    // Convert the dictionary to a list of results
                    var resultList = new List<Dictionary<string, object>>();
                    foreach (var entry in groupedResults)
                    {
                        resultList.Add(entry.Value);
                    }

                    // Convert to JSON
                    var jsonResult = JsonConvert.SerializeObject(new { Results = resultList }, Newtonsoft.Json.Formatting.Indented);
                    return jsonResult;
                }

                return string.Empty; // Return null if no data is found
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object RetrieveInvestigationAdviceOrderStatus(string MrnNo, string strFrmDate, string strTodate, string DoctCode)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();

                var sDate = GeneralFunction.GetDateInSpecifiedFormat(
                    strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(
                    strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetInvestigationAdviceOrderStatus(sDate, tDate, MrnNo, DoctCode)));

                if (load != null && load.Tables.Count > 0
                    && load.Tables[0].Rows.Count > 0)
                {
                    var result = (from DataRow row in load.Tables[0].Rows
                                  select new
                                  {
                                      CONSULTATIONNO = ("" + row["TRANNO"]).Trim(),
                                      DATETIME = (GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()) + " " + ("" + row["TRANTIME"]).Trim()).Trim(),
                                      ADVISEDBY = ("" + row["DOCTNAME"]).Trim(),
                                      TESTNAME = ("" + row["TESTNAME"]).Trim(),
                                      BILLNO = ("" + row["BILLNO"]).Trim(),
                                      TESTSTATUS = GeneralFunction.TestStatus(("" + row["TESTSTATUS"]).Trim()),
                                      RESULTNO = ("" + row["RESULTNO"]).Trim(), // Abhishesh || 20260805
                                  }).ToArray();

                    return result;
                }

                return "Unsucessfull";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public object RetriveInvestigations(string MrnNo, string strFrmDate, string strTodate)
        {
            try
            {

                DataSet load = new DataSet();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                var sDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetInvestigations(MrnNo, "", sDate, tDate)));

                if (load != null && load.Tables.Contains("Table"))
                {
                    if (load.Tables.Contains("Table") && load.Tables["Table"].Rows.Count > 0)
                    {
                        if (load.Tables["Table"].Columns.Contains("RESULTDATE"))
                        {
                            for (int i = 0; i < load.Tables["Table"].Rows.Count; i++)
                            {
                                load.Tables["Table"].Rows[i]["RESULTDATE"] = GeneralFunction.GetDate(load.Tables["Table"].Rows[i]["RESULTDATE"].ToString());
                            }
                        }
                    }

                    DataView view = new DataView(load.Tables[0]);
                    DataTable distinctInventigValues = view.ToTable(true, "INVESTDESC");
                    distinctInventigValues.TableName = "INVESTDESC";


                    load.Tables.Add(distinctInventigValues);
                }

                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public object RetriveDateWiseInvesg(string MrnNo, string strFrmDate, string strTodate)
        {
            try
            {
                DataSet load = new DataSet();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();

                var sDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetInvestigations(MrnNo, "", sDate, tDate)));

                if (load != null & load.Tables.Contains("Table"))
                {
                    DataView view = new DataView(load.Tables[0]);
                    DataTable distinctInventigValues = view.ToTable(true, "RESULTDATE");
                    DataTable Resultdate = SortGetREsultdate(distinctInventigValues);
                    Resultdate.TableName = "RESULTDATE";
                    load.Tables.Add(Resultdate);

                    if (load.Tables.Contains("Table") && load.Tables["Table"].Rows.Count > 0)
                    {
                        if (load.Tables["Table"].Columns.Contains("RESULTDATE"))
                        {
                            for (int i = 0; i < load.Tables["Table"].Rows.Count; i++)
                            {
                                load.Tables["Table"].Rows[i]["RESULTDATE"] = GeneralFunction.GetDate(load.Tables["Table"].Rows[i]["RESULTDATE"].ToString());
                            }
                        }
                    }

                    if (load.Tables.Contains("RESULTDATE") && load.Tables["RESULTDATE"].Rows.Count > 0)
                    {
                        if (load.Tables["RESULTDATE"].Columns.Contains("RESULTDATE"))
                        {
                            for (int i = 0; i < load.Tables["RESULTDATE"].Rows.Count; i++)
                            {
                                load.Tables["RESULTDATE"].Rows[i]["RESULTDATE"] = GeneralFunction.GetDate(load.Tables["RESULTDATE"].Rows[i]["RESULTDATE"].ToString());
                            }
                        }
                    }
                }

                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public DataTable SortGetREsultdate(DataTable dtREsultdate)
        {
            var Rows = (from row in dtREsultdate.AsEnumerable()
                        orderby row["RESULTDATE"] descending
                        select row);
            dtREsultdate = Rows.AsDataView().ToTable();
            return dtREsultdate;
        }

        public string GetAmendmntDet(string strResultNo)
        {
            OncologyEMRClient labClient = new OncologyEMRClient();
            DataSet load = new DataSet();
            string amendData = labClient.GetAmendmentData(strResultNo.ToString().Trim());
            amendData = System.Web.HttpUtility.UrlDecode(amendData);
            return amendData;
        }


        public object RetriveTempReportData(string MrnNo, string strFrmDate, string strTodate)
        {
            try
            {
                DataSet load = new DataSet();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();

                var sDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetTemplateResult(MrnNo, sDate, tDate)));
                //if (load.Tables.Count > 0)
                //{
                //    DataTable dt = load.Tables[0];
                //    DataTable distinctTable = dt.DefaultView.ToTable(true);
                //    load.Tables.RemoveAt(0);
                //    load.Tables.Add(distinctTable);
                //}
                if (load != null & load.Tables.Contains("Table"))
                {
                    DataView view = new DataView(load.Tables[0]);
                    DataTable distinctInventigValues = view.ToTable(true, "RESULTDATE");
                    DataTable Resultdate = SortGetREsultdate(distinctInventigValues);
                    Resultdate.TableName = "RESULTDATE";
                    load.Tables.Add(Resultdate);
                    load.Tables["Table"].Columns.Add("Ammendments");
                    if (load.Tables.Contains("Table") && load.Tables["Table"].Rows.Count > 0)
                    {
                        if (load.Tables["Table"].Columns.Contains("RESULTDATE"))
                        {
                            for (int i = 0; i < load.Tables["Table"].Rows.Count; i++)
                            {
                                load.Tables["Table"].Rows[i]["RESULTDATE"] = GeneralFunction.GetDate(load.Tables["Table"].Rows[i]["RESULTDATE"].ToString());
                                load.Tables["Table"].Rows[i]["Ammendments"] = GetAmendmntDet(load.Tables["Table"].Rows[i]["RESULTNO"].ToString().Trim());
                                load.Tables["Table"].Rows[i]["RESULTDT"] = load.Tables["Table"].Rows[i]["ENCODEDYN"].ToString() == "Y" ? HttpUtility.UrlDecode(load.Tables["Table"].Rows[i]["RESULTDT"].ToString()) : load.Tables["Table"].Rows[i]["RESULTDT"].ToString();
                            }
                        }
                    }
                }

                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public object RetriveTrendWiseInvesg(string MrnNo, string TestCode, string strFrmDate, string strTodate)
        {
            try
            {
                DataSet load = new DataSet();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                var sDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetInvestigations(MrnNo, TestCode, sDate, tDate)));

                if (load != null && load.Tables.Contains("Table"))
                {
                    /****************************/
                    if (load.Tables[0].Rows.Count > 0)
                    {

                        for (int i = 0; i < load.Tables[0].Rows.Count; i++)
                        {
                            load.Tables[0].Rows[i]["RESULTDATE"] = GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString());
                        }
                    }

                    DataTable FilterTable = RetriveInvestigByResulType(load.Tables[0], "V");


                    /*********************************/

                    if (FilterTable.Rows.Count > 0)
                    {
                        if (FilterTable.Columns.Contains("RESULTDATE"))
                        {
                            for (int i = 0; i < FilterTable.Rows.Count; i++)
                            {
                                FilterTable.Rows[i]["RESULTDATE"] = GeneralFunction.GetDate(FilterTable.Rows[i]["RESULTDATE"].ToString());
                            }
                        }
                    }

                    DataView view = new DataView(FilterTable);
                    DataTable distinctInventigValues = view.ToTable(true, "INVESTDESC");
                    distinctInventigValues.TableName = "INVESTDESC";


                    load.Tables.Add(distinctInventigValues);
                }

                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public DataTable RetriveInvestigByResulType(DataTable dt, string ResultType)
        {

            bool result = dt.AsEnumerable().Any(r => r.Field<string>("RESULTTYPE") == ResultType);
            if (result)
            {
                DataTable FilterTable = dt.AsEnumerable()
                           .Where(r => r.Field<string>("RESULTTYPE") == ResultType)
                           .CopyToDataTable();
                return FilterTable;
            }
            else
            {
                dt.Clear();
                return dt;
            }
        }

        //added on 25th July 2018
        public object GetTrendsTestCode(string mrNo, string FrmDate, string ToDate)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var sDate = GeneralFunction.GetDateInSpecifiedFormat(FrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            var tDate = GeneralFunction.GetDateInSpecifiedFormat(ToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string str = client.GetPerformedTestList(mrNo, sDate, tDate);

            ds.ReadXml(new XmlTextReader(new StringReader((str))));

            if (ds.Tables.Count > 0)
            {
                var data = (from DataRow row in ds.Tables[0].Rows
                            select new
                            {
                                TESTCODE = row["TESTCODE"].ToString().Trim(),
                                TESTNAME = row["TESTNAME"].ToString().Trim()
                            }).ToArray();
                return Newtonsoft.Json.JsonConvert.SerializeObject(data);

            }
            return "Unsucessfull";
        }
        #endregion

        #region Advice

        public object RetriveFqtAdicMaterial(string doctorCode)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                if (GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN").ToString().Trim() == "Y")
                {
                    load.ReadXml(new StringReader(ObjOncologyEMRClient.GetFreqGeneric(doctorCode)));
                }
                else
                {
                    load.ReadXml(new StringReader(ObjOncologyEMRClient.GetFreqMtrls(doctorCode)));
                }
                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public object RetriveMedicineIntake(string CreatedBy)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                CreatedBy = ""; //Copy Functionality is not Working If User Wise Getting in Intake List
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetMtrlIntake(CreatedBy)));
                DataTable tblResult = new DataTable();
                DataSet dsResult = new DataSet();

                if (load.Tables.Count > 0 && load.Tables[0].Rows.Count > 0)
                {

                    tblResult = load.Tables[0];

                    if (tblResult.Columns.Contains("INTAKE1"))
                    {
                        for (int i = 0; i < tblResult.Rows.Count; i++)
                        {
                            if (string.IsNullOrEmpty(tblResult.Rows[i]["INTAKE1"].ToString()))
                                tblResult.Rows[i]["INTAKE1"] = "";
                        }
                    }

                    if (tblResult.Columns.Contains("INTAKE2"))
                    {
                        for (int i = 0; i < tblResult.Rows.Count; i++)
                        {
                            if (string.IsNullOrEmpty(tblResult.Rows[i]["INTAKE2"].ToString()))
                                tblResult.Rows[i]["INTAKE2"] = "";
                        }
                    }

                    if (tblResult.Columns.Contains("INTAKE3"))
                    {
                        for (int i = 0; i < tblResult.Rows.Count; i++)
                        {
                            if (string.IsNullOrEmpty(tblResult.Rows[i]["INTAKE3"].ToString()))
                                tblResult.Rows[i]["INTAKE3"] = "";
                        }
                    }

                    if (tblResult.Columns.Contains("INTAKE4"))
                    {
                        for (int i = 0; i < tblResult.Rows.Count; i++)
                        {
                            if (string.IsNullOrEmpty(tblResult.Rows[i]["INTAKE4"].ToString()))
                                tblResult.Rows[i]["INTAKE4"] = "";
                        }
                    }

                    if (tblResult.Columns.Contains("INTAKE5"))
                    {
                        for (int i = 0; i < tblResult.Rows.Count; i++)
                        {
                            if (string.IsNullOrEmpty(tblResult.Rows[i]["INTAKE5"].ToString()))
                                tblResult.Rows[i]["INTAKE5"] = "";
                        }
                    }

                    if (tblResult.Columns.Contains("INTAKE6"))
                    {
                        for (int i = 0; i < tblResult.Rows.Count; i++)
                        {
                            if (string.IsNullOrEmpty(tblResult.Rows[i]["INTAKE6"].ToString()))
                                tblResult.Rows[i]["INTAKE6"] = "";
                        }
                    }
                }

                if (tblResult.Rows.Count > 0 && tblResult.Select("STATUS='A'").Length > 0)
                    dsResult.Tables.Add(tblResult.Select("STATUS='A'").CopyToDataTable());

                if (tblResult != null && tblResult.Rows.Count > 0 && dsResult.Tables.Count > 0)
                {
                    dsResult.Tables[0].TableName = "Intake";
                    string jsonData = JsonConvert.SerializeObject(dsResult, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object RetriveNonFqtDruglist(string DrugName)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                if (GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN").ToString().Trim() == "Y")
                {
                    load.ReadXml(new StringReader(ObjOncologyEMRClient.GetGenericList(DrugName)));
                }
                else
                {
                    load.ReadXml(new StringReader(ObjOncologyEMRClient.GetDrugList(DrugName)));
                }
                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public string SaveMediAdvice(string strMediList, string strTranNO, string strMRNo, string MedicineCD, string Medicinename)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            onc.type = "A";
            onc.TranMode = 1;

            onc.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
            onc.TRANNO = "" + strTranNO;
            onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
            onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
            onc.MRNO = "" + strMRNo;
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(strMediList);
            dt.TableName = "MEDICINE";

            DataSet ds = new DataSet("DATA");
            if (dt != null && dt.Rows.Count > 0)
            {
                ds.Tables.Add(dt);
            }
            onc.MedicineName = Medicinename;
            onc.DrugCode = string.Format("{0}", MedicineCD);
            onc.xmlMedicine = ds.GetXml();
            string strResult = client.SaveDoctorDesk(onc);
            return strResult;
        }

        public string SavePersonDiseaMedicine(string Code, string strTranNO, string strMRNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            onc.type = "X";
            onc.TranMode = 1;

            onc.TRANNO = "" + strTranNO;
            onc.InvestOther = Code;
            onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
            onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
            onc.MRNO = "" + strMRNo;
            string strResult = client.SaveDoctorDesk(onc);
            return strResult;
        }

        public object DeleteMedicine(string strMaterialCode, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();

            blOncology.TRANNO = strTranNo;
            //blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "A";
            blOncology.DrugCode = strMaterialCode;
            return Oncoser.SaveDoctorDesk(blOncology);
        }

        public string SaveMediResequence(string strMediList, string strTranNO, string strMRNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Oncology onc = new BL_Oncology();
            onc.type = "U";
            onc.TranMode = 1;

            onc.TRANNO = "" + strTranNO;
            onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
            onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
            onc.MRNO = "" + strMRNo;
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(strMediList);
            dt.TableName = "MEDICINE";

            DataSet ds = new DataSet("DATA");
            if (dt != null && dt.Rows.Count > 0)
            {
                ds.Tables.Add(dt);
            }

            onc.xmlMedicine = ds.GetXml();
            string strResult = client.SaveDoctorDesk(onc);
            return strResult;
        }


        public string saveMedIntkCombintn(string strMedIntkComb, decimal TabCount)
        {
            string strResult = "";
            try
            {
                OncologyEMRClient OEMRCli = new OncologyEMRClient();
                strResult = OEMRCli.SaveIntakeAddItem("", strMedIntkComb, 1, "A", HttpContext.Current.Session["gOncoUserId"].ToString(), TabCount);
                return strResult;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("uk_intake"))
                {
                    strResult = "This combination of prescription intake is allready exist.";
                    return strResult;
                }
                else
                {
                    return ex.Message;
                }
            }
        }

        public string saveNewRoute(string strRoute)
        {
            string strResult = "";
            try
            {

                OncologyEMRClient OEMRCli = new OncologyEMRClient();
                strResult = OEMRCli.SaveRoute("", strRoute, HttpContext.Current.Session["ClinicCode"].ToString(), "A", HttpContext.Current.Session["gOncoUserId"].ToString(), 1);
                return strResult;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("UNIQUE"))//kavita
                {
                    strResult = "This Remark is already exist.";
                    return strResult;
                }
                else if (ex.Message.Contains("uk_intake"))
                {
                    strResult = "This Remark is allready exist.";
                    return strResult;
                }
                else
                {
                    return ex.Message;
                }
            }
        }

        public string saveNewINtakeRemark(string strRemark)
        {
            string strResult = "";
            try
            {

                OncologyEMRClient OEMRCli = new OncologyEMRClient();
                strResult = OEMRCli.SaveRemarksAddItem("", strRemark, HttpContext.Current.Session["ClinicCode"].ToString(), "A", HttpContext.Current.Session["gOncoUserId"].ToString(), 1);
                return strResult;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("UNIQUE"))//kavita
                {
                    strResult = "This Remark is already exist.";
                    return strResult;
                }
                else if (ex.Message.Contains("uk_intake"))
                {
                    strResult = "This Remark is allready exist.";
                    return strResult;
                }
                else
                {
                    return ex.Message;
                }
            }
        }

        public object GetRemarkList(string strClinincode, string UserId)
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> Remarklst;
            Remarklst = comser.GetRemarksList(UserId.ToString().Trim());

            if (Remarklst != null && Remarklst.ToList().Count > 0)
            {
                return Remarklst.ToList();
            }
            else
                return "";
        }

        public DataSet GetSavedMedDet(string strMrno, string strConsNo, string strMedicineCode)
        {
            OncologyEMRClient OEMRCli = new OncologyEMRClient();
            string strResult = OEMRCli.GetDoctDeskMedicine(strConsNo, "A", strMedicineCode);
            DataSet load = new DataSet();
            load.ReadXml(new StringReader(strResult));
            return load;

        }

        public string RefillMedicine(string strTranno, string strMrNo, string cimsYN)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient Oncoser = new OncologyEMRClient();

            blOncology.TRANNO = strTranno;
            blOncology.CIMSYN = cimsYN;//
            blOncology.MRNO = strMrNo;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "R";
            return Oncoser.SaveDoctorDesk(blOncology);
        }

        public object GetPersDiseaseList(string CIMS)
        {
            try
            {
                DoctorCode = string.Empty;
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataSet ds = new DataSet();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetPersDiseaseList(DoctorCode, CIMS)));
                if (ds != null && ds.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //added on 16th may 2018
        public string AddMedicineSetUp(string strMedicineSetUpName, string strMedicineLst, string strSetUpCode, string CIMSYN)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                BL_PersonalSetUp bl = new BL_PersonalSetUp();
                //string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                //string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
                bl.DoctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                bl.SetUpName = strMedicineSetUpName;
                bl.SetUpType = "R";
                bl.SetupCode = strSetUpCode; //added on 6th march 19
                //string[] namesArray = strMedicineLst.Split(',');
                bl.CimsYN = CIMSYN;
                bl.UserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();

                DataSet ds = new DataSet();

                DataTable dtResult1 = new DataTable();
                dtResult1 = JsonConvert.DeserializeObject<DataTable>(strMedicineLst);

                dtResult1.Columns.Add("SEQNO");

                int count = 1;
                foreach (DataRow row in dtResult1.Rows)
                {
                    row["SEQNO"] = count;
                    count++;
                }
                ds.Tables.Add(dtResult1);
                dtResult1.TableName = "LIST";
                ds.DataSetName = "DETAIL";

                bl.SetUpLstXml = ds.GetXml();

                Result = Oncoser.SavePersonalisedSetUp(bl);
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                {
                    Result = "This complaint is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        //added on 11th oct 2018
        public string SaveRx(string strMediList, string strTranNO, string strMRNo)
        {
            string Result = "";
            try
            {
                OncologyEMRClient client = new OncologyEMRClient();
                BL_Oncology onc = new BL_Oncology();
                onc.type = "O";
                onc.TranMode = 1;

                onc.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
                onc.TRANNO = "" + strTranNO;
                onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
                onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
                onc.MRNO = "" + strMRNo;
                DataTable dt = JsonConvert.DeserializeObject<DataTable>(strMediList);
                dt.TableName = "MEDICINE";

                DataSet ds = new DataSet("DATA");
                if (dt != null && dt.Rows.Count > 0)
                {
                    ds.Tables.Add(dt);
                }
                // onc.MedicineName = Medicinename;
                // onc.DrugCode = string.Format("{0}", MedicineCD);
                onc.xmlMedicine = ds.GetXml();
                string strResult = client.SaveDoctorDesk(onc);
                return strResult;
            }
            catch (Exception ex)//
            {
                if (ex.Message.Contains("Cannot insert duplicate key in object"))
                {
                    Result = "Duplicate Mmedicines cant save.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        //added on 6th march 2019
        public object GetMedListBySetupCode(string strSetUpCode, string strType)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var strDoctCode = (HttpContext.Current.Session["gDoctCode"]).ToString();
            ds.ReadXml(new XmlTextReader(new StringReader(client.GetListBySetUpCode(strSetUpCode, strDoctCode, strType))));
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        var data = (from DataRow row in ds.Tables[0].Rows
                                    select new
                                    {
                                        CODE = row["DRUGCD"].ToString().Trim(),
                                        NAME = row["DRUGNM"].ToString().Trim(),
                                        INTAKE = row["INTAKEDESC"].ToString().Trim(),
                                        DAYS = row["DAYS"].ToString().Trim(),
                                        DURATION = GetDaysString(row["DURATION"].ToString().Trim()),
                                        FOOD = (row["ABFOOD"].ToString().Trim()) == "A" ? "After" : (row["ABFOOD"].ToString().Trim() == "E" ? "Before" : ""),
                                        DOSAGE = row["DOSSAGE"].ToString().Trim(),
                                        REMARK = row["Remarks"].ToString().Trim(),
                                        GENERICID = row["GENERICID"].ToString().Trim(),
                                        GENERICNAM = row["GENERICNAME"].ToString().Trim(),
                                        DRUGFORM = row["DRUGFORM"].ToString().Trim(),//	
                                        ROUTE = row["ROUTE"].ToString().Trim()//	
                                    }).ToList();
                        return data;
                    }
                }
            }
            return "";
        }

        public object RefillRoutineMedicine(string strMrNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            //var strDoctCode = (HttpContext.Current.Session["gDoctCode"]).ToString();
            ds.ReadXml(new XmlTextReader(new StringReader(client.GetRoutineMedList(strMrNo))));
            if (ds != null)
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        var data = (from DataRow row in ds.Tables[0].Rows
                                    select new
                                    {
                                        CODE = row["DRUGCD"].ToString().Trim(),
                                        NAME = row["DRUGNM"].ToString().Trim(),
                                        INTAKE = row["INTAKEDESC"].ToString().Trim(),
                                        DAYS = row["DAYS"].ToString().Trim(),
                                        DURATION = GetDaysString(row["DURATION"].ToString().Trim()),
                                        //FOOD = (row["ABFOOD"].ToString().Trim()) == "A" ? "After" : (row["ABFOOD"].ToString().Trim() == "E" ? "Before" : ""),
                                        FOOD = (row["ABFOOD"].ToString().Trim()),
                                        DOSAGE = row["DOSSAGE"].ToString().Trim(),
                                        REMARK = row["Remarks"].ToString().Trim(),
                                        GENERICID = row["GENERICID"].ToString().Trim(),
                                        GENERICNAM = row["GENERICNAME"].ToString().Trim(),
                                        DRUGFORM = row["DRUGFORM"].ToString().Trim(),//	
                                        ROUTE = row["ROUTE"].ToString().Trim(),//
                                        ROUTINEYN = row["ROUTINEYN"].ToString().Trim()//
                                    }).ToList();
                        return data;
                    }
                }
            }
            return "";
        }

        #endregion

        #region PreciptionImages---------

        public object SaveExaminationPic(string imageData, string MrNo, string TranNo, List<ImageInfo> existingImages)
        {
            try
            {
                object status = "";
                var finalPath = "";
                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                var Pic_Path = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString().Trim() + "/PrescriptionImages/" + strUnit; //System.Web.HttpContext.Current.Server.MapPath("~/PrescriptionImages");
                // var Pic_Path = @"D:\PrescriptionImages\Prece";
                var subpath = Pic_Path + @"\" + MrNo;
                var TranPath = Pic_Path + @"\" + MrNo + @"\" + TranNo;
                if (imageData != "")
                {
                    if (Directory.Exists(TranPath))
                    {
                        int fileCount = Directory.GetFiles(TranPath).Length;



                        finalPath = Pic_Path + @"\" + MrNo + @"\" + TranNo + @"\" + TranNo + "_" + (fileCount + 1).ToString().PadLeft(2, '0') + ".png";


                        int count = 1;
                        while (System.IO.File.Exists(finalPath))
                        {
                            finalPath = Pic_Path + @"\" + MrNo + @"\" + TranNo + @"\" + TranNo + "_" + (fileCount + count).ToString().PadLeft(2, '0') + ".png";
                            count++;
                        }
                    }
                    else
                    {
                        finalPath = Pic_Path + @"\" + MrNo + @"\" + TranNo + @"\" + TranNo + "_" + (1).ToString().PadLeft(2, '0') + ".png";
                    }

                    if (System.IO.File.Exists(finalPath))
                    {

                        status = "File with this name already exists, please rename the file.";
                    }
                    else
                    {
                        if (!Directory.Exists(Pic_Path))
                        {
                            Directory.CreateDirectory(Pic_Path);
                            if (Directory.Exists(Pic_Path))
                            {
                                DirectoryInfo dInfo = new DirectoryInfo(Pic_Path);
                                DirectoryInfo dis = dInfo.CreateSubdirectory(MrNo);
                                DirectoryInfo doctype = dis.CreateSubdirectory(TranNo);

                                using (FileStream fs = new FileStream(finalPath, FileMode.Create))
                                {
                                    using (BinaryWriter bw = new BinaryWriter(fs))
                                    {
                                        byte[] data = Convert.FromBase64String(imageData);
                                        bw.Write(data);
                                        bw.Close();
                                    }
                                }
                            }
                        }

                        else if (Directory.Exists(Pic_Path))
                        {
                            if (Directory.Exists(subpath))
                            {
                                if (Directory.Exists(TranPath))
                                {
                                    using (FileStream fs = new FileStream(finalPath, FileMode.Create))
                                    {
                                        using (BinaryWriter bw = new BinaryWriter(fs))
                                        {
                                            byte[] data = Convert.FromBase64String(imageData);
                                            bw.Write(data);
                                            bw.Close();
                                        }
                                    }
                                }
                                else
                                {
                                    Directory.CreateDirectory(TranPath);
                                    using (FileStream fs = new FileStream(finalPath, FileMode.Create))
                                    {
                                        using (BinaryWriter bw = new BinaryWriter(fs))
                                        {
                                            byte[] data = Convert.FromBase64String(imageData);
                                            bw.Write(data);
                                            bw.Close();
                                        }
                                    }
                                }
                            }
                            else
                            {
                                DirectoryInfo dInfo = new DirectoryInfo(Pic_Path);
                                DirectoryInfo dis = dInfo.CreateSubdirectory(MrNo);
                                DirectoryInfo doctype = dis.CreateSubdirectory(TranNo);
                                using (FileStream fs = new FileStream(finalPath, FileMode.Create))
                                {
                                    using (BinaryWriter bw = new BinaryWriter(fs))
                                    {
                                        byte[] data = Convert.FromBase64String(imageData);
                                        bw.Write(data);
                                        bw.Close();
                                    }
                                }
                            }
                        }
                    }
                    status = "Image saved and uploaded Successfully";
                }
                if (existingImages != null && existingImages.Count > 0)
                {
                    foreach (var img in existingImages)
                    {
                        if (!Directory.Exists(TranPath))
                        {
                            Directory.CreateDirectory(TranPath);
                        }
                        string fileName = TranNo + "_" + img.Id.PadLeft(2, '0') + ".png";
                        string filePath = Path.Combine(TranPath, fileName);
                        string base64 = img.Src;
                        if (base64.StartsWith("data:image"))
                        {
                            int commaIndex = base64.IndexOf(',');
                            if (commaIndex > -1)
                            {
                                base64 = base64.Substring(commaIndex + 1);
                            }
                        }
                        byte[] data = Convert.FromBase64String(base64);
                        if (File.Exists(filePath))
                        {
                            File.Delete(filePath);
                        }
                        using (FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.Write))
                        {
                            using (BinaryWriter bw = new BinaryWriter(fs))
                            {
                                bw.Write(data);
                                bw.Close();
                            }
                        }
                    }

                    status = "Image saved and uploaded Successfully";
                }
                return status;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object RetriveImageByDoctor(string ConultCode = "")
        {
            var directory = "";//priyanka 11/04/2026
            Dictionary<object, object> dict = new Dictionary<object, object>();
            int fileCount = 0; string[] filePaths = { };
            var strDoctCD = ConultCode == "" ? (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString() : ConultCode;
            directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString();//priyanka 11/04/2026
            //string countpath = System.Web.HttpContext.Current.Server.MapPath("~/HumanBodyImg") + "\\" + strDoctCD + "\\";
            //priyanka 11/04/2026
            string countpath = directory + "\\" + "HumanBodyImg" + "\\" + strDoctCD + "\\";

            if (Directory.Exists(countpath))
            {
                fileCount = Directory.GetFiles(countpath).Length;
            }
            if (fileCount > 0)
            {
                filePaths = Directory.GetFileSystemEntries(countpath);
            }

            dict.Add("ImagePath", filePaths);

            dict.Add("DocCode", strDoctCD);

            return dict;
        }

        #endregion

        //added on  4th april 2018
        #region Vital History
        public object[] GetVitalHistory(string strMRNO)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            //devendra 24/03/2026
            CommonServiceClient cs = new CommonServiceClient();
            var LstUser = cs.GetUserList();
            //end
            string data = oncoClient.GetDoctDesk("", "T", strMRNO);
            ds.ReadXml(new XmlTextReader(new StringReader((data))));
            object[] obj = new object[2];

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var jsondata = (from DataRow row in ds.Tables[0].Rows
                                    select new
                                    {
                                        WEIGHT = CheckNumber(row["WEIGHT"].ToString().Trim()),
                                        HEIGHT = CheckNumber(row["HEIGHT"].ToString().Trim()),
                                        TEMP = CheckNumber(row["TEMP"].ToString().Trim()),
                                        PULSE = CheckRESPAndBP(row["PULSE"].ToString().Trim()),
                                        RESP = CheckRESPAndBP(row["RESP"].ToString().Trim()),
                                        BP = CheckRESPAndBP(row["BP"].ToString().Trim()),
                                        VOTHERS = row["VOTHERS"].ToString().Trim(),
                                        WALKINGYN = StrYesNo(row["WALKINGYN"].ToString().Trim().ToString()),
                                        WALKINGDURATION = row["WALKINGDURATION"].ToString().Trim(),
                                        WALKINGDURTYPE = GetWalkingDurationType(row["WALKINGDURTYPE"].ToString().Trim()),
                                        DIETYN = row["DIETYN"].ToString().Trim().ToString() == "N" ? "No" : "Yes",
                                        REGULARMEDIYN = StrYesNo(row["REGULARMEDIYN"].ToString().Trim().ToString()),
                                        TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()) + " " + row["TRANTIME"].ToString().Trim(),// added by vijeta on 10th april 2018
                                        SPO2 = row["SPO2"].ToString().Trim().ToString(),//added on 29th aug 2018
                                        TRANDT = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),//added on 4th jan 2019
                                        AGE = row["PATAGE"].ToString().Trim().ToString(),//added vijeta 28th may 2019
                                        BMI = row["BMI"].ToString().Trim().ToString(),
                                        HEADCIR = row["HEADCIRCUMFERENCE"].ToString().Trim().ToString(),
                                        CREATEDBY = LstUser.FirstOrDefault(x => x.Value == row["CREATEDBY"].ToString().Trim())?.Text ?? "",//devendra 24/03/2026
                                    }
                       ).ToArray();

                    //return jsondata;
                    obj[0] = jsondata;
                    var jsondata1 = (from DataRow row in ds.Tables[0].Rows
                                     select new
                                     {
                                         WEIGHT = CheckNumber(row["WEIGHT"].ToString().Trim()),
                                         HEIGHT = CheckNumber(row["HEIGHT"].ToString().Trim()),
                                         BMI = row["BMI"].ToString().Trim().ToString(),
                                         HEADCIR = row["HEADCIRCUMFERENCE"].ToString().Trim().ToString(),
                                         AGE = GetAgeInMonths(row["PATAGE"].ToString().Trim().ToString()),//added vijeta 21st may 2019
                                     }).ToArray();
                    obj[1] = jsondata1;

                }
            }
            // return "";
            return obj;
        }

        public static string GetAgeInMonths(string age)
        {
            if (age != "")
            {
                string[] arr = null;
                if (age.Contains('.') == true)
                {
                    arr = age.Split('.');
                }
                else if (age.Contains(':') == true)
                {
                    arr = age.Split(':');
                }

                int ageinMonths = 0;
                ageinMonths = (Convert.ToInt32(arr[0]) * 12) + Convert.ToInt32(arr[1]);
                return Convert.ToString(ageinMonths);
            }
            else
                return "000:00:00";
        }


        public string GetWalkingDurationType(string str)
        {
            if (str == "D")
                return "Days";
            else if (str == "M")
                return "Months";
            else if (str == "W")
                return "Weeks";
            else if (str == "Y")
                return "Years";
            else return "";
        }

        //added on 13th april 2018
        public string StrYesNo(string str)
        {
            if (str == "Y")
                return "Yes";
            else if (str == "N")
                return "No";
            else
                return "";
        }

        public string CheckNumber(string str)
        {
            var num = Convert.ToDecimal(str);
            if (num > 0)
                return string.Format("{0:0,0.##}", num);
            else
                return "-";
        }

        public string CheckRESPAndBP(string str)
        {
            if (str == "" || str == "/")
                return "-";
            else
                return str;
        }
        //---------------------------------------------
        #endregion

        public object GetCounts(string strTranNo = "", string strMrno = "")
        {
            OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataSet load2 = new DataSet();
            DataTable dt2 = new DataTable();
            //
            load2.ReadXml(new XmlTextReader(new StringReader(client.GetVaccineDetails(strMrno))));

            string VaccFlag = "N";
            if (load2.Tables.Count > 0)
            {
                if (load2.Tables[1].Rows.Count > 0)
                {
                    VaccFlag = "Y";
                }
            }
            //end
            ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetDoctDesk(strTranNo, "L", strMrno)));
            if (ds.Tables.Count > 0)
            {
                var data = new
                {
                    COMPLAINTS = ds.Tables.Contains("COMPLAINTS") || ds.Tables.Contains("FREECOMPLAINT") ? "Y" : "N",
                    VITALS = ds.Tables.Contains("VITALS") ? CheckVitalAllFields(ds.Tables["VITALS"]) : "N",
                    //DIAGNOSIS = ds.Tables.Contains("DIAGNOSIS") || ds.Tables.Contains("ICDDIAGNOSIS") ? "Y" : "N",
                    //Added By Priyanka on 30/01/2025
                    //Changed the condition to update the flag on the diagnosis
                    DIAGNOSIS = ds.Tables.Contains("DIAGNOSIS") ? "Y" : "N", //Added By Priyanka on 30/01/2025
                    EXAMINATION = ds.Tables.Contains("EXAMS") ? (ds.Tables["EXAMS"].Rows[0]["EXAM"].ToString() != "") ? "Y" : "N" : "N",
                    INVESTIGATIONS = ds.Tables.Contains("INVEST") || ds.Tables.Contains("FREEINVESTIGATION") ? "Y" : "N",
                    MEDICINE = ds.Tables.Contains("ADVICE") ? "Y" : "N",
                    PATADVICE = ds.Tables.Contains("PATADVICE") ? "Y" : "N",
                    ADDICTHISTORY = (ds.Tables.Contains("ADDICTSHISTORY") || (ds.Tables.Contains("FREEHISTORY") ? (ds.Tables["FREEHISTORY"].Rows[0]["PERSHIST"].ToString() != "") ? true : false : false)) ? "Y" : "N", //added on 25th march 2019
                    MEDICINEHISTORY = (ds.Tables.Contains("MEDICINEHISTORY") || (ds.Tables.Contains("FREEHISTORY") ? (ds.Tables["FREEHISTORY"].Rows[0]["MEDIHIST"].ToString() != "") ? true : false : false)) ? "Y" : "N", //added on 25th march 2019
                    FAMILYHISTORY = (ds.Tables.Contains("FAMILYHISTORY") || (ds.Tables.Contains("FREEHISTORY") ? (ds.Tables["FREEHISTORY"].Rows[0]["FAMHIST"].ToString() != "") ? true : false : false)) ? "Y" : "N", //added on 25th march 2019
                    ALLERGY = ds.Tables.Contains("Allergy") ? "Y" : "N",
                    PRESCRIPTN = ds.Tables.Contains("PATDETAILS") ? (ds.Tables["PATDETAILS"].Rows[0]["COMPLETEDYN"].ToString() == "Y") ? "Y" : "N" : "N", //25-11-2019 18:26
                    // PRESCRIPTN = ds.Tables.Contains("FOLLOWUP") ? (ds.Tables["FOLLOWUP"].Rows[0]["ADMNADVYN"].ToString() != "") ? ds.Tables["FOLLOWUP"].Rows[0]["ADMNADVYN"].ToString() : "" : "", //Added by Murali on 28/02/2024
                    VACCINATION = VaccFlag.ToString(),
                    ICDDIAGNOSIS = ds.Tables.Contains("ICDDIAGNOSIS") || ds.Tables.Contains("ICDODIAGNOSIS") ? "Y" : "N",
                    CLINICALNOTES = ds.Tables.Contains("Table20") && ds.Tables["Table20"].Rows[0]["CLINICALHIST"].ToString().Trim() != "" ? "Y" : "N",
                    CHEMOPLAN = ds.Tables.Contains("CHEMOPLANNING") ? "Y" : "N",
                };
                return data;
            }
            return "";
        }

        // added by vijeta on 14th april 2018
        public string CheckVitalAllFields(DataTable dt)
        {
            if (dt.Rows.Count > 0)
            {
                //if (Convert.ToDecimal(dt.Rows[0]["WEIGHT"].ToString().Trim()) > 0 || Convert.ToDecimal(dt.Rows[0]["HEIGHT"].ToString().Trim()) > 0 || Convert.ToDecimal(dt.Rows[0]["TEMP"].ToString().Trim()) > 0 || dt.Rows[0]["PULSE"].ToString().Trim() != "" || Convert.ToInt32(dt.Rows[0]["PULSE"].ToString().Trim()) > 0 || dt.Rows[0]["BP"].ToString().Trim() != "" || dt.Rows[0]["RESP"].ToString().Trim() != "" || dt.Rows[0]["PEFR"].ToString().Trim() != "" || (dt.Rows[0]["TECHNIQUE"].ToString().Trim() != "N" && dt.Rows[0]["TECHNIQUE"].ToString().Trim() != "") || (dt.Rows[0]["COMPLIANCE"].ToString().Trim() != "N" && dt.Rows[0]["COMPLIANCE"].ToString().Trim() != ""))
                if (Convert.ToDecimal(dt.Rows[0]["WEIGHT"].ToString().Trim()) > 0 ||
                    Convert.ToDecimal(dt.Rows[0]["HEIGHT"].ToString().Trim()) > 0 ||
                    Convert.ToDecimal(dt.Rows[0]["TEMP"].ToString().Trim()) > 0 ||
                    (dt.Rows[0]["PULSE"].ToString().Trim() != "" &&
                    Convert.ToInt32(dt.Rows[0]["PULSE"].ToString().Trim()) > 0) ||
                    dt.Rows[0]["BP"].ToString().Trim() != "" ||
                    dt.Rows[0]["RESP"].ToString().Trim() != "" ||
                    dt.Rows[0]["PEFR"].ToString().Trim() != "" ||
                    (dt.Rows[0]["TECHNIQUE"].ToString().Trim() != "N" && dt.Rows[0]["TECHNIQUE"].ToString().Trim() != "") ||
                    (dt.Rows[0]["COMPLIANCE"].ToString().Trim() != "N" && dt.Rows[0]["COMPLIANCE"].ToString().Trim() != "") || dt.Rows[0]["PROXYVISITYN"].ToString().Trim() != "N")// - extra condition added for COMPLIANCE
                    return "Y";
                else
                    return "N";
            }
            else
                return "N";
        }

        #region Medication History
        public object GetMedicationtHistory(string strMrNo, string FromDate, string ToDate, string DoctCode)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            object[] objTosend = new object[16];//PRIYANKA 15/04/2026

            string data = oncoClient.GetDoctDesk("", "M", strMrNo);
            ds.ReadXml(new XmlTextReader(new StringReader((data))));
            var medRoute = GeneralFunction.MedicineRouteRX();
            object jsondata1 = "";
            object jsondata2 = "";
            object jsonComplaintData = "";
            object jsonDiagnosisData = "";
            object jsonVitalsData = "";
            object jsonExaminationData = "";
            object jsonPastHistData = "";
            object jsonInvestigationsData = "";
            object jsonPatAdviceData = "";
            object jsonFollowUpData = "";
            object jsonICDDIAGNOSISData = "";
            object jsonFreeComplaints = "";
            object jsonFreeInvestigation = "";
            object jsonICDODiagnosis = "";
            object jsonFreeAdvice = "";
            object jsonClinicalHist = "";//priyanka 15/04/2026
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataView view = new DataView(ds.Tables[0]);
                    DataTable distinctValues = view.ToTable(true, "TRANDATE", "TRANNO", "TRANTIME", "DOCTNAME", "PATAGE", "PATSEX", "PATNAME", "COMPLETEDYN", "DEPTCODE");//
                    //string[] array = distinctValues.AsEnumerable().Select(row =>  GeneralFunction.GetDate(row.Field<string>("TRANDATE"))).ToArray();
                    FromDate = GeneralFunction.GetDateInSpecifiedFormat(FromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                    ToDate = GeneralFunction.GetDateInSpecifiedFormat(ToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                    DataRow[] FilterRow = distinctValues.Select();
                    if (FromDate != "")
                    {
                        string filterExpression = "TRANDATE >= '" + FromDate + "' AND TRANDATE <= '" + ToDate + "'" + (DoctCode != "" ? (" AND DOCTNAME = '" + DoctCode + "'") : "");
                        FilterRow = distinctValues.Select(filterExpression);
                    }
                    CommonServiceClient comserv = new CommonServiceClient();
                    var detplst = comserv.GetDeptList("");
                    var DoctLst = oncoClient.GetDoctLst("", "D");
                    var SpecList = oncoClient.GetSpecialistnList();
                    jsondata1 = (from DataRow row in FilterRow
                                 select new
                                 {
                                     TRANNO = row["TRANNO"].ToString().Trim(),
                                     TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                     //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                     TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()), // Abhishesh || 20260323
                                     DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                     PATNAME = row["PATNAME"].ToString().Trim(),//
                                     PATAGE = row["PATAGE"].ToString().Trim(),//
                                     PATSEX = row["PATSEX"].ToString().Trim(),//
                                     COMPLETEDYN = row["COMPLETEDYN"].ToString().Trim(), //Ashvini passed this to chec the complete status at view side
                                     DEPTNAME = row["DEPTCODE"].ToString().Trim() != "" ? detplst.Where(x => x.Value == row["DEPTCODE"].ToString().Trim()).Count() > 0 ? detplst.Where(x => x.Value == row["DEPTCODE"].ToString().Trim()).First().Text.Trim() : "" : "",
                                     SPECNAME = ("" + row["DOCTNAME"]).ToString().Trim() == "" ? "" : GeneralFunction.GetSpecialityDoctor(DoctLst, SpecList, "", ("" + row["DOCTNAME"]).ToString().Trim()),

                                 }
                       ).ToArray();


                    if (ds.Tables.Contains("ADVICE"))
                    {
                        jsondata2 = (from DataRow row in ds.Tables["ADVICE"].Rows
                                     select new
                                     {
                                         TRANNO = row["TRANNO"].ToString().Trim(),
                                         INTAKE = row["INTAKE"].ToString().Trim(),
                                         DOSSAGE = row["DOSSAGE"].ToString().Trim(),
                                         DRUGNM = row["DRUGNM"].ToString().Trim(),
                                         DAYS = row["DAYS"].ToString().Trim(),
                                         GENERICNAM = row["GENERICNAM"].ToString().Trim(),
                                         ROUTE = (row["ROUTE"].ToString().Trim() != "") ? medRoute.Where(x => x.Value == row["ROUTE"].ToString().Trim()).Count() > 0 ? medRoute.Where(x => x.Value == row["ROUTE"].ToString().Trim()).First().Text.Trim() : "" : "",  //kavita 14-aug-2019
                                         Remarks = row["Remarks"].ToString().Trim(),
                                         ABFOOD = row["ABFOOD"].ToString().Trim() == "A" ? "After Food" : row["ABFOOD"].ToString().Trim() == "E" ? "Before Food" : "",
                                         TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                         //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                         TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()), // abhishesh || 20260323
                                         DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                         DRUGFORM = row["DRUGFORM"].ToString().Trim(),
                                         CIMSMEDYN = row["CIMSMEDYN"].ToString().Trim(),
                                         QTY = row["QTY"].ToString().Trim(),
                                         MEDSTARTDATE = GeneralFunction.GetDate(row["MEDSTARTDATE"].ToString().Trim()),
                                         GENERICID = row["GENERICID"].ToString().Trim(),
                                         DRUGCD = row["DRUGCD"].ToString().Trim(),
                                         ROUTECD = row["ROUTE"].ToString().Trim(),
                                         INTAKECD = row["INTAKECD"].ToString().Trim(),
                                         REMARKSCD = row["REMARKSCD"].ToString().Trim()
                                     }).ToArray();
                    }

                    if (ds.Tables.Contains("FREEADVICETBL"))
                    {
                        jsonFreeAdvice = (from DataRow row in ds.Tables["FREEADVICETBL"].Rows
                                          select new
                                          {
                                              TRANNO = row["TRANNO"].ToString().Trim(),
                                              TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                              //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                              TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                              FREEADVICE = row["FREEADVICE"].ToString().Trim()
                                          }).ToArray();
                    }

                    if (ds.Tables.Contains("COMPLAINTS"))
                    {
                        jsonComplaintData = (from DataRow row in ds.Tables["COMPLAINTS"].Rows
                                             select new
                                             {
                                                 TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                 //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                 TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                 DESCCD = row["DESCCD"].ToString().Trim(),
                                                 NAME = row["NAME"].ToString().Trim(),
                                                 DURATION = row["DURATION"].ToString().Trim(),
                                                 DURTYPE = GetWalkingDurationType(row["DURTYPE"].ToString().Trim()),
                                                 REMARKS = row["REMARKS"].ToString().Trim(),
                                                 TRANNO = row["TRANNO"].ToString().Trim(),
                                             }).ToArray();
                    }

                    //vijeta 19th march 19                  
                    if (ds.Tables.Contains("FREECOMPLAINT"))
                    {

                        jsonFreeComplaints = (from DataRow row in ds.Tables["FREECOMPLAINT"].Rows
                                              select new
                                              {
                                                  TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                  //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                  TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                  FREECOMPLAINT = row["FREECMPLNT"].ToString().Trim(),
                                                  TRANNO = row["TRANNO"].ToString().Trim()
                                              }).ToArray();

                    }

                    if (ds.Tables.Contains("DIAGNOSIS"))
                    {
                        jsonDiagnosisData = (from DataRow row in ds.Tables["DIAGNOSIS"].Rows
                                             select new
                                             {
                                                 TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                 //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                 TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                 NAME = row["NAME"].ToString().Trim(),
                                                 DURATION = row["DURATION"].ToString().Trim(),
                                                 DURTYPE = row["DURTYPE"].ToString().Trim(),
                                                 DESCCD = row["DESCCD"].ToString().Trim(),
                                                 REMARKS = row["REMARKS"].ToString().Trim(),
                                                 TRANNO = row["TRANNO"].ToString().Trim()
                                             }
                   ).ToArray();
                    }

                    if (ds.Tables.Contains("ICDODIAGNOSIS"))
                    {
                        jsonICDODiagnosis = (from DataRow row in ds.Tables["ICDODIAGNOSIS"].Rows
                                             select new
                                             {
                                                 TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                 //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                 TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                 NAME = row["NAME"].ToString().Trim(),
                                                 ICDOCODE = row["ICDOCODE"].ToString().Trim(),
                                                 TRANNO = row["TRANNO"].ToString().Trim()
                                             }
                   ).ToArray();
                    }

                    if (ds.Tables.Contains("VITALS"))
                    {
                        jsonVitalsData = (from DataRow row in ds.Tables["VITALS"].Rows
                                          select new
                                          {
                                              TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                              //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                              TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                              WEIGHT = row["WEIGHT"].ToString().Trim(),
                                              HEIGHT = row["HEIGHT"].ToString().Trim(),
                                              TEMP = row["TEMP"].ToString().Trim(),
                                              PULSE = row["PULSE"].ToString().Trim(),
                                              RESP = row["RESP"].ToString().Trim(),
                                              BP = row["BP"].ToString().Trim(),
                                              VOTHERS = row["VOTHERS"].ToString().Trim(),
                                              SPO2 = row["SPO2"].ToString().Trim(),
                                              TRANNO = row["TRANNO"].ToString().Trim(),
                                              BMI = row["BMI"].ToString().Trim(),//vijeta 17th may 2019
                                              HEADCIRCMF = row["HEADCIRCUMFERENCE"].ToString().Trim(),//vijeta 17th may 2019
                                              PEFR = row["PEFR"].ToString().Trim(),//vijeta 4th june 2019
                                              Technique = GetComplianceSting(row["TECHNIQUE"].ToString().Trim()),//vijeta 4th june 2019
                                              Compliance = GetComplianceSting(row["COMPLIANCE"].ToString().Trim()),
                                              DIETYN = row["DIETYN"].ToString().Trim(),
                                              REGMEDYN = row["REGULARMEDIYN"].ToString().Trim(),
                                              WALKYN = row["WALKINGYN"].ToString().Trim(),
                                              PAINSCORE = row["PAINSCORE"].ToString().Trim(),
                                              BSA = row["BSA"].ToString().Trim(),
                                              RBS = row["RBS"].ToString().Trim(),
                                              KARNOFSKY = row["KARNOFSKY"].ToString().Trim(),
                                              ECOG = row["ECOG"].ToString().Trim(),
                                              //Added by Murali on 25/04/2024
                                              //*******************************************
                                              IBW = row["IBW"].ToString(),
                                              BWPERC = row["BWPERC"].ToString(),
                                              WAISTCIRCUM = row["WAISTCIRCUM"].ToString(),
                                              HIPCIRCUM = row["HIPCIRCUM"].ToString(),
                                              WHR = row["WHR"].ToString(),
                                              //*******************************************
                                          }
                    ).ToArray();
                    }

                    if (ds.Tables.Contains("EXAMS"))
                    {
                        jsonExaminationData = (from DataRow row in ds.Tables["EXAMS"].Rows
                                               select new
                                               {
                                                   TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                   //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                   TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                   EXAM = row["EXAM"].ToString().Trim(),
                                                   FILEPATH = GetExaminationFile(row["TRANNO"].ToString().Trim(), strMrNo),
                                                   TRANNO = row["TRANNO"].ToString().Trim(),
                                                   PASTHIST = row["PASTHIST"].ToString().Trim(),
                                               }
               ).ToArray();
                        jsonPastHistData = (from DataRow row in ds.Tables["EXAMS"].Rows
                                            select new
                                            {
                                                TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                PASTHIST = row["PASTHIST"].ToString().Trim(),
                                                TRANNO = row["TRANNO"].ToString().Trim()
                                            }
                       ).ToArray();
                    }

                    if (ds.Tables.Contains("INVEST"))
                    {
                        jsonInvestigationsData = (from DataRow row in ds.Tables["INVEST"].Rows
                                                  select new
                                                  {
                                                      TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                      //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                      TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                      TESTCODE = row["TESTCODE"].ToString().Trim(),
                                                      TESTNAME = row["TESTNAME"].ToString().Trim(),
                                                      DURATION = row["DURATION"].ToString().Trim(),
                                                      DURTYPE = row["DURTYPE"].ToString().Trim(),
                                                      REMARK = row["REMARK"].ToString().Trim(),
                                                      TRANNO = row["TRANNO"].ToString().Trim()
                                                  }
               ).ToArray();
                    }

                    //vijeta 22nd march 19
                    if (ds.Tables.Contains("FREEINVESTIGATION"))
                    {

                        jsonFreeInvestigation = (from DataRow row in ds.Tables["FREEINVESTIGATION"].Rows
                                                 select new
                                                 {
                                                     TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                     //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                     TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                     FREEINVESTIGATION = row["FREEINVST"].ToString().Trim(),
                                                     TRANNO = row["TRANNO"].ToString().Trim()
                                                 }).ToArray();

                    }

                    if (ds.Tables.Contains("PATADVICE"))
                    {
                        jsonPatAdviceData = (from DataRow row in ds.Tables["PATADVICE"].Rows
                                             select new
                                             {
                                                 TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                 //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                 TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                 DESCCD = row["DESCCD"].ToString().Trim(),
                                                 NAME = row["NAME"].ToString().Trim(),
                                                 TRANNO = row["TRANNO"].ToString().Trim()
                                             }
                        ).ToArray();
                    }

                    if (ds.Tables.Contains("FOLLOWUP"))
                    {
                        jsonFollowUpData = (from DataRow row in ds.Tables["FOLLOWUP"].Rows
                                            select new
                                            {
                                                TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                FOLLOWUPDT = row["FOLLOWUPDT"].ToString().Trim(),
                                                DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                                SURGNMADVICE = row["SURGNMADVICE"].ToString().Trim(),
                                                REFSPECIALIST = row["REFSPECIALIST"].ToString().Trim(),
                                                PRESCREMARK = row["PRESCREMARK"].ToString().Trim(),
                                                TRANNO = row["TRANNO"].ToString().Trim(),
                                                APPMNTDT = GeneralFunction.GetDate(row["APPMNTDT"].ToString().Trim()),
                                                APPMNTTM = row["APPMNTTM"].ToString().Trim(),
                                                PLANOFTREAT = row["PLANOFTREAT"].ToString().Trim(),
                                                PROVDIAG = row["PROVDIAG"].ToString().Trim(),
                                                COMPOSTAG = row["COMPOSTAG"].ToString().Trim(),
                                                TSTAGE = row["TSTAGE"].ToString().Trim(),
                                                NSTAGE = row["NSTAGE"].ToString().Trim(),
                                                MSTAGE = row["MSTAGE"].ToString().Trim(),
                                                SURGADVDATE = GeneralFunction.GetDate(row["SURGADVDATE"].ToString().Trim()), //Column Need to Change
                                                ADMNADVYN = row["ADMNADVYN"].ToString().Trim(), //Column Need to Change
                                                PROPADMNDT = GeneralFunction.GetDate(row["PROPADMNDT"].ToString().Trim()), //Column Need to Change
                                                SITE = row["DIASITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["DIASITECODE"].ToString().Trim(), ""),
                                                SUBSITE = row["DIASUBSITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["DIASITECODE"].ToString().Trim(), row["DIASUBSITECODE"].ToString().Trim()),
                                                PACADVDATE = GeneralFunction.GetDate(row["PACADVDATE"].ToString().Trim()),
                                                SURGADVICEOTHER = row["SURGADVICEOTHER"].ToString().Trim(), // Pournima 18th Aug 2026
                                            }
                                    ).ToArray();
                    }


                    if (ds.Tables.Contains("ICDDIAGNOSIS"))
                    {
                        jsonICDDIAGNOSISData = (from DataRow row in ds.Tables["ICDDIAGNOSIS"].Rows
                                                select new
                                                {
                                                    TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                    //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                    TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                    ICDCODE = row["ICDCODE"].ToString().Trim(),
                                                    NAME = row["NAME"].ToString().Trim(),
                                                    SEQNO = row["SEQNO"].ToString().Trim(),
                                                    TRANNO = row["TRANNO"].ToString().Trim()
                                                }
                        ).ToArray();
                    }
                    if (ds.Tables.Contains("Table13")) //PRIYANKA 15/04/2026
                    {
                        jsonClinicalHist = (from DataRow row in ds.Tables["Table13"].Rows
                                            select new
                                            {
                                                TRANNO = row["TRANNO"].ToString().Trim(),
                                                TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                //TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                TRANTIME = GeneralFunction.ConvertTimeTo24Hour(row["TRANTIME"].ToString().Trim()),  // Abhishesh || 20260323
                                                CLINICALHIST = row["CLINICALHIST"].ToString().Trim()
                                            }).ToArray();
                    }
                    objTosend[0] = jsondata1;
                    objTosend[1] = jsondata2;
                    objTosend[2] = jsonComplaintData;
                    objTosend[3] = jsonDiagnosisData;
                    objTosend[4] = jsonVitalsData;
                    objTosend[5] = jsonExaminationData;
                    objTosend[6] = jsonInvestigationsData;
                    objTosend[7] = jsonPatAdviceData;
                    objTosend[8] = jsonFollowUpData;
                    objTosend[9] = jsonICDDIAGNOSISData;
                    objTosend[10] = jsonFreeComplaints;
                    objTosend[11] = jsonFreeInvestigation;
                    objTosend[12] = jsonPastHistData;
                    objTosend[13] = jsonICDODiagnosis;
                    objTosend[14] = jsonFreeAdvice;
                    objTosend[15] = jsonClinicalHist;//priyanka 15/04/2026
                }
            }
            return objTosend;
        }

        public string GetDoctTypeList()
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            var DoctList = oncoClient.GetDoctLst("", "D");
            var sample = (from Lst in DoctList.AsEnumerable()
                          select new
                          {
                              CODE = Lst.Value,
                              NAME = Lst.Text
                          }).ToArray();
            return Newtonsoft.Json.JsonConvert.SerializeObject(sample);
        }

        public string RefillRxFromMedHistMdl(string strTranNo, string strConsultNo, string strMrno, string strpatName, string strpatAge, string strpatGender, string strTranDate, string strTranTime)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();

            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMrno;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();

            blOncology.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;

            blOncology.type = "L";
            blOncology.PrevTranNo = strConsultNo;
            blOncology.PatName = strpatName;
            blOncology.Age = strpatAge;//added on 16th jan 2019
            blOncology.Gender = strpatGender;//added on 16th jan 2019
            blOncology.TRANDT = GeneralFunction.GetDateInSpecifiedFormat(strTranDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);//added on 16th jan 2019
            blOncology.TRANTM = strTranTime.Trim();

            return client.SaveDoctorDesk(blOncology);
        }

        //public object GetNonFreqDrugLstFrRxDesktop(string drugName)
        //{
        //    try
        //    {
        //        DataSet FreqDrugDs = new DataSet();
        //        DataSet NonFreqDrugDs = new DataSet();

        //        OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
        //        string doctorCode = "";
        //        doctorCode = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]).Trim();

        //        //freq matrls dataset
        //        FreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetFreqMtrls(doctorCode)));



        //        //non freq mtrl dataset
        //        NonFreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetDrugList(drugName)));



        //        if ((FreqDrugDs != null && FreqDrugDs.Tables.Count > 0) || (NonFreqDrugDs != null && NonFreqDrugDs.Tables.Count > 0))
        //        {
        //            DataTable dt = new DataTable();
        //            if (FreqDrugDs.Tables.Count > 0)
        //            {
        //                var result = FreqDrugDs.Tables[0].AsEnumerable().Where(dr => dr.Field<string>("MTRLNAME").ToLower().Contains(drugName.ToLower()));

        //                if (result.Count() > 0)
        //                {
        //                    dt = result.CopyToDataTable();
        //                }
        //                NonFreqDrugDs.Merge(dt);
        //            }
        //            string jsonData = JsonConvert.SerializeObject(NonFreqDrugDs, Newtonsoft.Json.Formatting.Indented);
        //            return jsonData;
        //        }
        //        else
        //        {
        //            return "Unsucessfull";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}



        public object GetNonFreqDrugLstFrRxDesktop(string drugName)
        {
            try
            {
                DataSet FreqDrugDs = new DataSet();
                DataSet NonFreqDrugDs = new DataSet();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                string doctorCode = "";
                doctorCode = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]).Trim();

                //freq matrls dataset
                //FreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetFreqMtrls(doctorCode)));

                //non freq mtrl dataset
                //NonFreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetDrugList(drugName)));

                if (GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN").ToString().Trim() == "Y")
                {
                    NonFreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetGenericList(drugName)));
                }
                else
                {
                    NonFreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetDrugList(drugName)));
                }

                if ((NonFreqDrugDs != null && NonFreqDrugDs.Tables.Count > 0))
                {
                    DataTable dt = new DataTable();
                    if (NonFreqDrugDs.Tables.Count > 0)
                    {
                        //var result = FreqDrugDs.Tables[0].AsEnumerable().Where(dr => dr.Field<string>("MTRLNAME").ToLower().Contains(drugName.ToLower()));

                        //if (result.Count() > 0)
                        //{
                        //    dt = result.CopyToDataTable();
                        //}
                        NonFreqDrugDs.Merge(dt);
                    }
                    string jsonData = JsonConvert.SerializeObject(NonFreqDrugDs, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        #endregion

        #region rx search new
        public object SearchMaterial(string strMtrl)
        {
            try
            {
                DataSet load = new DataSet();
                //OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                CIMSClass cimsObj = new CIMSClass();

                List<DataClass.SelectLstItem1> materialLst = new List<DataClass.SelectLstItem1>();
                materialLst = cimsObj.SearchMaterial(strMtrl);

                if (materialLst.Count() > 0)
                {
                    var query = (from material in materialLst
                                 select new
                                 {
                                     NAME = material.Text,
                                     CODE = material.Value,
                                 }).ToArray();
                    return query;
                }

                return "";
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public object GetMaterialInfo(string mtrlCode)
        {
            try
            {
                //OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataClass.CIMSClass obj = new CIMSClass();
                DataClass.MaterialDetails materialDt;
                materialDt = obj.GetMtrlDetails(mtrlCode.Trim());
                string text = materialDt.Strength;
                decimal reparsed = 0;
                if (text != null && text != "")
                {
                    decimal parsed = decimal.Parse(text.ToString().Trim());
                    reparsed = decimal.Parse(parsed.ToString());
                    if (parsed < 1)
                    {
                        string reformatted = parsed.ToString("0.00");
                        reparsed = decimal.Parse(reformatted);
                    }
                }

                var mtrl = new
                {
                    NAME = materialDt.BrandName,
                    CODE = materialDt.MtrlRefCode,
                    Generic = materialDt.Generic,
                    GenericCode = materialDt.GenericCode,
                    Form = materialDt.Form,
                    Strength = reparsed == 0 ? "" : reparsed.ToString(),

                    StrengthUnit = reparsed == 0 ? "" : materialDt.StrengthUnit,
                };

                return mtrl;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetPHMaterialInfo(string mtrlCode)
        {
            try
            {
                OncologyEMRClient obj = new OncologyEMRClient();
                bl_MaterialDetails mtrlInfo = new bl_MaterialDetails();
                mtrlInfo = obj.GetPHMaterialInfo(mtrlCode.Trim());
                var mtrl = new
                {
                    NAME = mtrlInfo.BrandName,
                    CODE = mtrlInfo.MtrlRefCode,
                    Generic = mtrlInfo.Generic,
                    GenericCode = mtrlInfo.GenericCode,
                    Form = mtrlInfo.Form,
                    Strength = "",
                    StrengthUnit = ""
                    //Strength =  "" : reparsed.ToString(),
                    //StrengthUnit = reparsed == 0 ? "" : materialDt.StrengthUnit,
                };
                return mtrl;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GetMonographInfo(string refCode)
        {
            try
            {
                //OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataClass.CIMSClass obj = new CIMSClass();

                string str = obj.GetMonographMtrl(refCode).Replace("scripts/", "../Scripts/").Replace("css/", "../css/");

                return str;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object[] GetMaterialInteraction(string[] refCodeArry)
        {
            try
            {
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                object[] objToSend = new object[2];
                //CIMSClass classobj = new CIMSClass();
                List<string> lst = JsonConvert.DeserializeObject<List<string>>(refCodeArry[0]);
                string str = "";//classobj.GetMtrlInteraction(lst).Replace("scripts/", "../Scripts/").Replace("css/", "../css/");

                int n = showMatch(str, "severity.\"");
                if (n != 0)
                {
                    objToSend[0] = n;
                }
                else
                {
                    objToSend[0] = "0";
                }

                objToSend[1] = str;
                return objToSend;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private static int showMatch(string text, string expr)
        {
            MatchCollection mc = Regex.Matches(text, expr);
            List<int> lst = new List<int>();
            foreach (Match m in mc)
            {
                Console.WriteLine(m);
                string s = m.ToString();
                lst.Add(Convert.ToInt16(s.Substring(s.Length - 2, 1)));
            }
            if (lst.Count > 0)
            {
                return lst.Max();
            }

            else
                return 0;
        }

        public object GetFregqentMaterialCIMS(string doctorCode)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetFreqMtrlsCIMS(doctorCode)));

                if (load != null && load.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public string SaveRxCIMS(string strMediList, string strTranNO, string strMRNo)////////////
        {
            string Result = "";
            try
            {
                OncologyEMRClient client = new OncologyEMRClient();
                BL_Oncology onc = new BL_Oncology();
                onc.type = "J";
                onc.TranMode = 1;

                onc.DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " "); //added on 28thfeb19
                onc.TRANNO = "" + strTranNO;
                onc.CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString();
                onc.DoctorCode = HttpContext.Current.Session["gDoctCode"].ToString();
                onc.MRNO = "" + strMRNo;
                DataTable dt = JsonConvert.DeserializeObject<DataTable>(strMediList);
                dt.TableName = "MEDICINE";

                DataSet ds = new DataSet("DATA");
                if (dt != null && dt.Rows.Count > 0)
                {
                    ds.Tables.Add(dt);
                }

                onc.xmlMedicine = ds.GetXml();
                string strResult = client.SaveDoctorDesk(onc);
                return strResult;
            }
            catch (Exception ex)//
            {
                if (ex.Message.Contains("Cannot insert duplicate key in object"))
                {
                    Result = "Duplicate Mmedicines cant save.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        #endregion

        #region Notes
        public string DDSaveNotes(string strNotes, string strTranNo, string strMrNo, string strNoteType, string tranMode, string TagYN, string strNoteCode)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            string strUserId = (System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString();
            string doctName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString();
            int NoteCode = (tranMode == "1") ? 0 : Int32.Parse(strNoteCode);
            string data = oncoClient.SavePatNote(strNotes, strTranNo, strMrNo, doctName, strUserId, strNoteType, NoteCode, tranMode, TagYN);
            return data;
        }

        public object GetPatNotes(string strTranNo, string strMrNo)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();

            DataSet ds = new DataSet();

            string data = oncoClient.GetPatNote(strTranNo, strMrNo);
            ds.ReadXml(new XmlTextReader(new StringReader((data))));
            //string[] arr=new string[2];
            var strDoctCD = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString();
            CommonServiceClient comm = new CommonServiceClient();
            List<UserLstItem> userLst = null;
            userLst = comm.GetUserList().Where(u => u.STATUS == "A").ToList();
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {

                    DataRow[] rows = ds.Tables[0].Select("(DOCTNAME='" + strDoctCD + "')");

                    var result = (from DataRow row in rows
                                  let doctName = row["DOCTNAME"].ToString().Trim()
                                  let matchedDoctor = userLst.FirstOrDefault(u => u.Text == doctName)
                                  let isDoctorExists = (matchedDoctor != null &&
                                                        !string.IsNullOrEmpty(matchedDoctor.DoctCode)) ? "Y" : "N"
                                  select new
                                  {
                                      CODE = row["CODE"].ToString().Trim(),
                                      TRANNO = row["TRANNO"].ToString().Trim(),
                                      MRNO = row["MRNO"].ToString().Trim(),
                                      NOTE = row["NOTE"].ToString().Trim(),
                                      NOTETYPE = row["NOTETYPE"].ToString().Trim(),
                                      DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                      DATE = GeneralFunction.GetDate(row["NOTEDATE"].ToString().Trim()) + " - " + row["NOTETIME"].ToString().Trim(),
                                      TAGYN = row["TAGYN"].ToString().Trim(),
                                      ISDOCT = isDoctorExists
                                  }).ToArray();
                    return result;
                }
            }
            return "";
        }

        public object GetAllNotes(string strMrNo)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            object[] objTosend = new object[1];
            string data = oncoClient.GetDoctDesk("", "N", strMrNo);
            var strDoctCD = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            CommonServiceClient comm = new CommonServiceClient();
            List<UserLstItem> userLst = null;
            userLst = comm.GetUserList().Where(u => u.STATUS == "A").ToList();
            ds.ReadXml(new XmlTextReader(new StringReader((data))));


            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow[] rows = ds.Tables[0].Select("(DOCTCODE='" + strDoctCD + "' AND  NOTETYPE='R') OR NOTETYPE='P' OR DOCTCODE=''");

                    //var jsondata = (from DataRow row in rows
                    //                select new
                    //                {
                    //                    TRANNO = row["TRANNO"].ToString().Trim(),
                    //                    NOTE = row["NOTE"].ToString().Trim(),
                    //                    DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                    //                    TRANDATE = GeneralFunction.GetDate(row["NOTEDATE"].ToString().Trim()),
                    //                    TRANTIME = row["NOTETIME"].ToString().Trim(),
                    //                    NOTETYPE = row["NOTETYPE"].ToString().Trim(),  //27-11-2019 19:03
                    //                    DATE = GeneralFunction.GetDate(row["NOTEDATE"].ToString().Trim()) + " - " + row["NOTETIME"].ToString().Trim(),
                    //                    TAGYN = row["TAGYN"].ToString().Trim(),
                    //                }
                    //   ).ToArray();

                    var jsondata = (from DataRow row in rows
                                    where row["STATUS"].ToString().Trim() == "A"
                                    let doctName = row["DOCTNAME"].ToString().Trim()
                                    let matchedDoctor = userLst.FirstOrDefault(u => u.Text == doctName)
                                    let isDoctorExists = (matchedDoctor != null &&
                                                          !string.IsNullOrEmpty(matchedDoctor.DoctCode)) ? "Y" : "N"
                                    select new
                                    {
                                        TRANNO = row["TRANNO"].ToString().Trim(),
                                        NOTE = row["NOTE"].ToString().Trim(),
                                        DOCTNAME = doctName,
                                        TRANDATE = GeneralFunction.GetDate(row["NOTEDATE"].ToString().Trim()),
                                        TRANTIME = row["NOTETIME"].ToString().Trim(),
                                        NOTETYPE = row["NOTETYPE"].ToString().Trim(),
                                        DATE = (!string.IsNullOrWhiteSpace(row["EDITEDON"]?.ToString()) && !string.IsNullOrWhiteSpace(row["EDITEDAT"]?.ToString()))
                                               ? GeneralFunction.GetDate(row["EDITEDON"].ToString().Trim()) + " - " + row["EDITEDAT"].ToString().Trim()
                                               : GeneralFunction.GetDate(row["NOTEDATE"].ToString().Trim()) + " - " + row["NOTETIME"].ToString().Trim(),
                                        TAGYN = row["TAGYN"].ToString().Trim(),
                                        ISDOCT = isDoctorExists,
                                        NOTECODE = row["UNIQUECODE"].ToString().Trim()
                                    }).ToArray();

                    // return jsondata;
                    objTosend[0] = jsondata;

                }
            }
            return objTosend;
        }
        #endregion

        #region Allergy
        public string SaveAllergyQuestionnair(AllergyModel algMdl, string mrNo, string tranNo, string doctName)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_Allergy blAllergy = new BL_Allergy();
            blAllergy.AllergicPeriod = algMdl.AllergicPeriod;
            blAllergy.MoreThan4daysYN = algMdl.MoreThan4daysYN;
            blAllergy.MoreThan4WeeksYN = algMdl.MoreThan4WeeksYN;
            blAllergy.SymptomsAffectActivities = algMdl.SymptomsAffectActivities;
            blAllergy.DisturbSleepYN = algMdl.DisturbSleepYN;
            blAllergy.BeforeHospitalizedYN = algMdl.BeforeHospitalizedYN;
            blAllergy.PastTestHistoryYN = algMdl.PastTestHistoryYN;
            blAllergy.BeforeAllergyVaccineYN = algMdl.BeforeAllergyVaccineYN;
            if (algMdl.CheckBoxParentAsthmaYN == true)
                blAllergy.ParentAsthmaYN = "Y";
            else
                blAllergy.ParentAsthmaYN = "N";

            if (algMdl.CheckBoxSiblingAsthmaYN == true)
                blAllergy.SiblingAsthmaYN = "Y";
            else
                blAllergy.SiblingAsthmaYN = "N";

            if (algMdl.CheckBoxChildrenAsthmaYN == true)
                blAllergy.ChildrenAsthmaYN = "Y";
            else
                blAllergy.ChildrenAsthmaYN = "N";

            if (algMdl.CheckBoxParentAllergicRhinitisYN == true)
                blAllergy.ParentAllergicRhinitisYN = "Y";
            else
                blAllergy.ParentAllergicRhinitisYN = "N";

            if (algMdl.CheckBoxSiblingAllergicRhinitisYN == true)
                blAllergy.SiblingAllergicRhinitisYN = "Y";
            else
                blAllergy.SiblingAllergicRhinitisYN = "N";

            if (algMdl.CheckBoxChildrenAllergicRhinitisYN == true)
                blAllergy.ChildrenAllergicRhinitisYN = "Y";
            else
                blAllergy.ChildrenAllergicRhinitisYN = "N";

            if (algMdl.CheckBoxParentSkinAllergyYN == true)
                blAllergy.ParentSkinAllergyYN = "Y";
            else
                blAllergy.ParentSkinAllergyYN = "N";

            if (algMdl.CheckBoxSiblingSkinAllergyYN == true)
                blAllergy.SiblingSkinAllergyYN = "Y";
            else
                blAllergy.SiblingSkinAllergyYN = "N";


            if (algMdl.CheckBoxChildrenSkinAllergyYN == true)
                blAllergy.ChildrenSkinAllergyYN = "Y";
            else
                blAllergy.ChildrenSkinAllergyYN = "N";


            if (algMdl.CheckBoxParentFoodAllergyYN == true)
                blAllergy.ParentFoodAllergyYN = "Y";
            else
                blAllergy.ParentFoodAllergyYN = "N";

            if (algMdl.CheckBoxSiblingFoodAllergyYN == true)
                blAllergy.SiblingFoodAllergyYN = "Y";
            else
                blAllergy.SiblingFoodAllergyYN = "N";

            if (algMdl.CheckBoxChildenFoodAllergyYN == true)
                blAllergy.ChildrenFoodAllergyYN = "Y";
            else
                blAllergy.ChildrenFoodAllergyYN = "N";


            blAllergy.NoOfSiblings = algMdl.NoOfSiblings;
            blAllergy.NoOfChildren = algMdl.NoOfChildren;

            if (algMdl.CheckBoxH1AntiOral == true)
                blAllergy.H1AntiOral = "Y";
            else
                blAllergy.H1AntiOral = "N";

            if (algMdl.CheckBoxH1AntiNasal == true)
                blAllergy.H1AntiNasal = "Y";
            else
                blAllergy.H1AntiNasal = "N";

            if (algMdl.CheckBoxH1AntiOpthaimic == true)
                blAllergy.H1AntiOpthaimic = "Y";
            else
                blAllergy.H1AntiOpthaimic = "N";

            if (algMdl.CheckBoxAllergicRhinitisOral == true)
                blAllergy.AllergicRhinitisOral = "Y";
            else
                blAllergy.AllergicRhinitisOral = "N";

            if (algMdl.CheckBoxAllergicRhinitisNasal == true)
                blAllergy.AllergicRhinitisNasal = "Y";
            else
                blAllergy.AllergicRhinitisNasal = "N";

            if (algMdl.CheckBoxAllergicRhinitisInhaled == true)
                blAllergy.AllergicRhinitisInhaled = "Y";
            else
                blAllergy.AllergicRhinitisInhaled = "N";

            if (algMdl.CheckBoxAllergicRhinitisTopical == true)
                blAllergy.AllergicRhinitisTopical = "Y";
            else
                blAllergy.AllergicRhinitisTopical = "N";



            blAllergy.SmokerYN = algMdl.SmokerYN;

            blAllergy.DoctName = doctName;//added on 11th July 2018
            #region SymptomsMonths
            var monthsArray = (from list in algMdl.SymptomsMonths
                               where list.Checked == true
                               select list.Name).ToArray();
            var strMonths = String.Join(",", monthsArray);
            blAllergy.SymptomsMonthsList = strMonths;
            #endregion

            #region Respiratory Tract Symptoms
            var respiratorySymptomsArray = (from list in algMdl.RespiratorySymptoms
                                            where list.Checked == true
                                            select list.Name).ToArray();
            var strRespiratorySymptoms = String.Join(",", respiratorySymptomsArray);
            blAllergy.RespiratoryTractSymptomsList = strRespiratorySymptoms;
            #endregion

            #region Eyes Symptoms
            var eyesSymptomsArray = (from list in algMdl.EyesSymptoms
                                     where list.Checked == true
                                     select list.Name).ToArray();
            var strEyesSymptoms = String.Join(",", eyesSymptomsArray);
            blAllergy.EyesSymptomsList = strEyesSymptoms;
            #endregion

            #region Skin Symptoms
            var skinSymptomsArray = (from list in algMdl.SkinSymptoms
                                     where list.Checked == true
                                     select list.Name).ToArray();
            var strSkinSymptoms = String.Join(",", skinSymptomsArray);
            blAllergy.SkinSymptomsList = strSkinSymptoms;
            #endregion

            #region GastroIntestinal Symptoms
            var gastroIntestinalSymptomsArray = (from list in algMdl.GastroIntestinalSymptoms
                                                 where list.Checked == true
                                                 select list.Name).ToArray();
            var strGastroIntestinalSymptoms = String.Join(",", gastroIntestinalSymptomsArray);
            blAllergy.GastroIntestinalSymptomsList = strGastroIntestinalSymptoms;
            #endregion

            #region WorseInLocation
            var worseInLocationArray = (from list in algMdl.WorseInLocations
                                        where list.Checked == true
                                        select list.Name).ToArray();
            var strWorseInLocation = String.Join(",", worseInLocationArray);
            blAllergy.WorseInLocationList = strWorseInLocation;
            #endregion

            #region WorseAtTime
            var worseAtTimeArray = (from list in algMdl.WorseAtTime
                                    where list.Checked == true
                                    select list.Name).ToArray();
            var strworseAtTime = String.Join(",", worseAtTimeArray);
            blAllergy.WorseAtTimeList = strworseAtTime;
            #endregion

            #region WorsenedByTriggers
            var worsenedByTriggersArray = (from list in algMdl.WorsenedByTriggers
                                           where list.Checked == true
                                           select list.Name).ToArray();
            var strworsenedByTriggers = String.Join(",", worsenedByTriggersArray);
            blAllergy.WorsenedByTriggersList = strworsenedByTriggers;
            #endregion

            blAllergy.TestDate = GeneralFunction.GetDateInSpecifiedFormat(algMdl.TestDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blAllergy.PositiveTests = algMdl.PositiveTests;
            blAllergy.VaccinatedAllergies = algMdl.VaccinatedAllergies;
            blAllergy.VaccinatedDate = GeneralFunction.GetDateInSpecifiedFormat(algMdl.VaccinatedDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blAllergy.VaccineYears = algMdl.VaccineYears;
            blAllergy.ResponseToTherapy = algMdl.ResponseToTherapy;

            blAllergy.H1AntiFrequency = algMdl.H1AntiFrequency;
            blAllergy.AllergicRhinitisFrequency = algMdl.AllergicRhinitisFrequency;
            blAllergy.B2AgonistsRoute = algMdl.B2AgonistsRoute;
            blAllergy.B2AgonistsFrequency = algMdl.B2AgonistsFrequency;
            blAllergy.OtherRoute = algMdl.OtherRoute;
            blAllergy.OtherFrequency = algMdl.OtherFrequency;

            blAllergy.TRANNO = tranNo;
            blAllergy.MRNO = mrNo;
            var str = "";
            str = client.SaveAllergyQuestionnair(blAllergy);
            return str;
        }

        public object GetAllergies(string strMrNo, string strTranNo)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            var str = client.GetPatientAllergiesData(strMrNo, strTranNo);
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));
            if (ds.Tables.Count > 0)
            {
                var jsonData = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    ALLERGICSYMPTOMSYN = row["ALLERGICSYMPTOMSYN"].ToString().Trim(),
                                    SYMPTOMSMONTHS = row["SYMPTOMSMONTHS"].ToString().Trim(),
                                    FOURDAYSPERWEEKYN = row["FOURDAYSPERWEEKYN"].ToString().Trim(),
                                    FOURWEEKSSTRETCHYN = row["FOURWEEKSSTRETCHYN"].ToString().Trim(),
                                    SYMPTOMSAFFECTYN = row["SYMPTOMSAFFECTYN"].ToString().Trim(),
                                    DISTURBSLEEPYN = row["DISTURBSLEEPYN"].ToString().Trim(),
                                    HOSPITALIZDBCZOFALLERGY = row["HOSPITALIZDBCZOFALLERGY"].ToString().Trim(),
                                    BLOODTEST = row["BLOODTEST"].ToString().Trim(),
                                    ALLERGYVACCINEBEFORE = row["ALLERGYVACCINEBEFORE"].ToString().Trim(),
                                    PARENTASTHMA = row["PARENTASTHMA"].ToString().Trim(),
                                    PARENTALLERGICRHINITIS = row["PARENTALLERGICRHINITIS"].ToString().Trim(),
                                    PARENTSKINALLERGY = row["PARENTSKINALLERGY"].ToString().Trim(),
                                    PARENTFOODALLERGY = row["PARENTFOODALLERGY"].ToString().Trim(),
                                    SIBLINGASTHMA = row["SIBLINGASTHMA"].ToString().Trim(),
                                    SIBLINGALLERGICRHINITIS = row["SIBLINGALLERGICRHINITIS"].ToString().Trim(),
                                    SIBLINGSKINALLERGY = row["SIBLINGSKINALLERGY"].ToString().Trim(),
                                    SIBLINGFOODALLERGY = row["SIBLINGFOODALLERGY"].ToString().Trim(),
                                    CHILDRENASTHMA = row["CHILDRENASTHMA"].ToString().Trim(),
                                    CHILDRENALLERGICRHINITIS = row["CHILDRENALLERGICRHINITIS"].ToString().Trim(),
                                    CHILDRENSKINALLERGY = row["CHILDRENSKINALLERGY"].ToString().Trim(),
                                    CHILDRENFOODALLERGY = row["CHILDRENFOODALLERGY"].ToString().Trim(),
                                    NOOFSIBLINGS = row["NOOFSIBLINGS"].ToString().Trim(),
                                    NOOFCHILDREN = row["NOOFCHILDREN"].ToString().Trim(),
                                    H1ANTIORAL = row["H1ANTIORAL"].ToString().Trim(),
                                    H1ANTINASAL = row["H1ANTINASAL"].ToString().Trim(),
                                    H1ANTIOPTHAIMIC = row["H1ANTIOPTHAIMIC"].ToString().Trim(),
                                    ALLERGICRHINITISORAL = row["ALLERGICRHINITISORAL"].ToString().Trim(),
                                    ALLERGICRHINITISNASAL = row["ALLERGICRHINITISNASAL"].ToString().Trim(),
                                    ALLERGICRHINITISINHALED = row["ALLERGICRHINITISINHALED"].ToString().Trim(),
                                    ALLERGICRHINITISTOPICAL = row["ALLERGICRHINITISTOPICAL"].ToString().Trim(),
                                    SMOKER = row["SMOKER"].ToString().Trim(),
                                    RESPIRATORYSYMPTOMS = row["RESPIRATORYSYMPTOMS"].ToString().Trim(),
                                    EYESSYMPTOMS = row["EYESSYMPTOMS"].ToString().Trim(),
                                    SKINSYMPTOMS = row["SKINSYMPTOMS"].ToString().Trim(),
                                    GASTROINTESTINALSYMPTOMS = row["GASTROINTESTINALSYMPTOMS"].ToString().Trim(),
                                    WORSEINLOCATION = row["WORSEINLOCATION"].ToString().Trim(),
                                    WORSEATTIME = row["WORSEATTIME"].ToString().Trim(),
                                    WORSENEDBYTRIGGERS = row["WORSENEDBYTRIGGERS"].ToString().Trim(),
                                    TESTDATE = GeneralFunction.GetDate(row["TESTDATE"].ToString().Trim()),
                                    POSITIVETESTS = row["POSITIVETESTS"].ToString().Trim(),
                                    VACCINATEDALLERGIES = row["VACCINATEDALLERGIES"].ToString().Trim(),
                                    VACCINEINITIATEDDATE = GeneralFunction.GetDate(row["VACCINEINITIATEDDATE"].ToString().Trim()),
                                    VACCINEYEARS = row["VACCINEYEARS"].ToString().Trim(),
                                    RESPONSETOTHERAPY = row["RESPONSETOTHERAPY"].ToString().Trim(),
                                    H1ANTIFREQUENCY = row["H1ANTIFREQUENCY"].ToString().Trim(),
                                    ALLERGICRHINITISFREQUENCY = row["ALLERGICRHINITISFREQUENCY"].ToString().Trim(),
                                    B2AGONISTROUTE = row["B2AGONISTROUTE"].ToString().Trim(),
                                    B2AGONISTFREQUENCY = row["B2AGONISTFREQUENCY"].ToString().Trim(),
                                    OTHERMEDICATIONROUTE = row["OTHERMEDICATIONROUTE"].ToString().Trim(),
                                    OTHERMEDICATIONFREQUENCY = row["OTHERMEDICATIONFREQUENCY"].ToString().Trim(),
                                    TRANDT = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                    TRANTM = row["TRANTIME"].ToString().Trim(),
                                    DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                }).ToList();
                return jsonData;
            }
            return "";
        }

        //added on 11th July 2018
        public object GetPatientPrevAllergies(string strMRNO)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetPatPrevAllergiesList(strMRNO)))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];

            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            TRANDATE = ("" + GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim())),
                            TRANNO = ("" + row["TRANNO"]).Trim(),

                        }).ToArray();

            return rows;
        }
        #endregion

        #region SPT Reporting
        public string SPTReportingTran(string strAllergenList, string strTranNo, string strMrNo, string doctName)
        {
            BL_SPTReporting sptBL = new BL_SPTReporting();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(strAllergenList);
            ds.Tables.Add(dt);
            ds.DataSetName = "SPT";
            ds.Tables[0].TableName = "LIST";
            sptBL.SPTListXml = ds.GetXml();
            sptBL.TRANNO = strTranNo.Trim();
            sptBL.MRNO = strMrNo.Trim();
            sptBL.DoctName = doctName;

            string ret = client.SPTReportingTran(sptBL);

            return ret;

        }

        public object GetSptReportingData(string strTranNo, string strMrNo)
        {
            BL_SPTReporting sptBL = new BL_SPTReporting();
            DataSet ds = new DataSet();
            string str = client.GetSptReportingData(strTranNo, strMrNo);


            ds.ReadXml(new XmlTextReader(new StringReader(str)));

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var data = (from DataRow rows in ds.Tables[0].Rows
                                select new
                                {
                                    CODE = rows["ALLERGENCODE"].ToString().Trim(),
                                    Allergen = rows["ALLERGEN"].ToString().Trim(),
                                    WheelDiameter = rows["WHEELDIAMETER"].ToString().Trim(),
                                    Type = rows["ALLERGENTYPE"].ToString().Trim()
                                }).ToArray();
                    return Newtonsoft.Json.JsonConvert.SerializeObject(data);
                }
            }

            return "";
        }

        //added on 2nd July 2018
        public object GetSptReportingDataFrPrint(string strTranNo, string strMrNo)
        {
            BL_SPTReporting sptBL = new BL_SPTReporting();
            DataSet ds = new DataSet();
            string str = client.GetSptReportingData(strTranNo, strMrNo);
            object[] objToSend = new object[2];

            ds.ReadXml(new XmlTextReader(new StringReader(str)));

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var array = ds.Tables[0].AsEnumerable().Select(r => r.Field<string>("ALLERGENTYPE")).Distinct().ToArray();
                    var data = (from DataRow rows in ds.Tables[0].Rows
                                select new
                                {
                                    CODE = rows["ALLERGENCODE"].ToString().Trim(),
                                    Allergen = rows["ALLERGEN"].ToString().Trim(),
                                    WheelDiameter = rows["WHEELDIAMETER"].ToString().Trim(),
                                    Type = rows["ALLERGENTYPE"].ToString().Trim(),
                                    TranDate = GeneralFunction.GetDate(rows["TRANDATE"].ToString().Trim()),
                                    TranTime = rows["TRANTIME"].ToString().Trim(),
                                    DOCTNAME = rows["DOCTNAME"].ToString().Trim()
                                }).ToArray();
                    objToSend[0] = array;
                    objToSend[1] = Newtonsoft.Json.JsonConvert.SerializeObject(data);
                }
            }

            return objToSend;
        }

        //added on 10th July 2018
        public object GetPatientPrevSPTReports(string strMRNO)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetPatSPTReportList(strMRNO)))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];

            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            TRANDATE = ("" + GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim())),
                            TRANNO = ("" + row["TRANNO"]).Trim(),

                        }).ToArray();

            return rows;
        }
        #endregion

        public object GetAllHistoryCounts(string strMrNo)
        {
            OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
            OncologyClient onco = new OncologyClient();
            int notesCount = 0;
            int vitalHistoryCount = 0;
            int medicationHisCount = 0;
            int HistoryCnt = 0;
            int VaccineCount = 0;
            string investNotifCode = "";
            int attachmentCount = 0;//Added By Priyanka on 07/02/2025
            int tumorDetails = 0;

            DataSet notesDs = new DataSet();
            DataSet vitalDs = new DataSet();
            DataSet medicationHisDs = new DataSet();
            DataSet historyCountDs = new DataSet();
            DataSet tumorTreatDet = new DataSet();//Added By Roshans on 24/10/2025

            DataSet ds = new DataSet();
            DataSet load2 = new DataSet();
            DataTable dt2 = new DataTable();
            //
            //vaccination count
            load2.ReadXml(new XmlTextReader(new StringReader(client.GetVaccineDetails(strMrNo))));
            //string VaccFlag = "N";
            if (load2.Tables.Count > 0)
            {
                //if (load2.Tables[1].Rows.Count > 0)
                //{
                //    VaccFlag = "Y";
                //}
                dt2 = load2.Tables[1];

                int count = 0;
                foreach (DataRow row in dt2.Rows)
                {
                    //if (row["VACINECD"].ToString().Trim() != "" || row["VACINECD"].ToString().Trim() != null) //Commented by Murali on 31/07/2024
                    if (row["VACINECD"].ToString().Trim() != "" && row["GIVENDT"].ToString().Trim() != "") //Added by Murali on 31/07/2024
                    {
                        count++;
                    }
                }
                VaccineCount = count;
            }
            //end

            //Notes Count
            notesDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetDoctDesk("", "N", strMrNo)));
            var strDoctCD = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            if (notesDs.Tables.Count > 0)
            {
                IEnumerable<DataRow> notesRows = notesDs.Tables[0].AsEnumerable()
                                      .Where(r => r.Field<string>("NOTETYPE") == "P"
                                        || r.Field<string>("DOCTCODE") == strDoctCD || r.Field<string>("DOCTCODE") == "");
                notesCount = notesRows.Count();
            }

            //Vital History Count
            vitalDs.ReadXml(new XmlTextReader(new StringReader((ObjOncologyEMRClient.GetDoctDesk("", "T", strMrNo)))));
            if (vitalDs.Tables.Count > 0)
            {
                int count = 0;
                foreach (DataRow row in vitalDs.Tables[0].Rows)
                {
                    if (Convert.ToDouble(row["WEIGHT"]) != 0.0 || Convert.ToDouble(row["HEIGHT"]) != 0.0 || Convert.ToDouble(row["TEMP"]) != 0.0 ||
                        row["PULSE"].ToString().Trim() != "" || Convert.ToString(row["BP"]).Trim() != "" || Convert.ToString(row["RESP"]) != "" ||
                        Convert.ToString(row["VOTHERS"]).Trim() != "" || Convert.ToString(row["WALKINGDURATION"]).Trim() != "" ||
                        Convert.ToString(row["WALKINGDURTYPE"]).Trim() != "" || row["SPO2"].ToString().Trim() != "" || Convert.ToString(row["WALKINGYN"]) != "N" ||
                        Convert.ToString(row["DIETYN"]) != "N" || Convert.ToString(row["REGULARMEDIYN"]) != "N")
                    {
                        count++;
                    }
                }
                vitalHistoryCount = count;
            }

            //Medication History Count
            if (strMrNo != null)
            {
                medicationHisDs.ReadXml(new XmlTextReader(new StringReader((ObjOncologyEMRClient.GetDoctDesk("", "M", strMrNo)))));
                if (medicationHisDs.Tables.Count > 0)
                {
                    medicationHisCount = medicationHisDs.Tables[0].Rows.Count;
                }
            }
            //Tumor Treatment Count
            if (strMrNo != null)
            {
                tumorTreatDet.ReadXml(new XmlTextReader(new StringReader((onco.GetTBDTreatmentDet(strMrNo)))));
                if (tumorTreatDet.Tables.Count > 0)
                {

                    tumorDetails = tumorTreatDet.Tables[0].Rows.Count;
                }
            }

            //History Count
            historyCountDs.ReadXml(new XmlTextReader(new StringReader((client.GetDoctDesk("", "O", strMrNo)))));
            if (historyCountDs.Tables.Count > 0)
            {
                if (historyCountDs.Tables.Contains("Table"))//family hist table
                {
                    HistoryCnt++;
                }
                if (historyCountDs.Tables.Contains("Table1")) //personal hist table
                {
                    DataRow[] row = historyCountDs.Tables["Table1"].Select("NAME<>'NIL'");
                    if (row.Length > 0)
                        HistoryCnt++;
                }
                if (historyCountDs.Tables.Contains("Table2"))//medical history table
                {
                    DataRow[] row = historyCountDs.Tables["Table2"].Select("NAME<>'NIL'");
                    if (row.Length > 0)
                        HistoryCnt++;
                }
                if (historyCountDs.Tables.Contains("Table4"))//allergy  table
                {
                    DataRow[] row = historyCountDs.Tables["Table4"].Select("NAME<>'NIL'");
                    if (row.Length > 0)
                        HistoryCnt++;
                }
                if (historyCountDs.Tables.Contains("Table3"))
                {
                    if (historyCountDs.Tables["Table3"].Rows.Count > 0) // Added by Murali on 03/08/2024
                    {
                        if (historyCountDs.Tables["Table3"].Rows[0]["PERSHIST"].ToString().Trim() != "" && !(historyCountDs.Tables.Contains("Table1")))
                            HistoryCnt++;
                        if (historyCountDs.Tables["Table3"].Rows[0]["MEDIHIST"].ToString().Trim() != "" && !(historyCountDs.Tables.Contains("Table2")))
                            HistoryCnt++;
                        if (historyCountDs.Tables["Table3"].Rows[0]["FAMHIST"].ToString().Trim() != "" && !(historyCountDs.Tables.Contains("Table")))
                            HistoryCnt++;
                    }
                }

                if (historyCountDs.Tables.Contains("Table5"))// Invest Notification Code  for abormal result
                {
                    if (historyCountDs.Tables["Table5"].Rows.Count > 0) // Added by Murali on 03/08/2024
                    {
                        investNotifCode = historyCountDs.Tables["Table5"].Rows[0]["NOTIFCODE"].ToString().Trim();
                    }
                }
            }

            //Added By Priyanka on 07/02/2025
            //Attachments Count
            if (strMrNo != null)
            {
                DirectoryInfo salesFTPDirectory = null;
                FileInfo[] files = null;
                var directory = "";
                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                directory = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString().Trim() + "/DoctDeskAttachments/" + strUnit;

                string salesFTPPath = directory + "/" + strMrNo;
                if (Directory.Exists(salesFTPPath))
                {
                    salesFTPDirectory = new DirectoryInfo(salesFTPPath);
                    files = salesFTPDirectory.GetFiles();
                    attachmentCount = files.Length;
                }
            }
            var dataToSend = new
            {
                notesCount = notesCount,
                vitalHistoryCount = vitalHistoryCount,
                medicationHisCount = medicationHisCount,
                HistoryCnt = HistoryCnt,
                VaccineCount = VaccineCount,
                InvestNotifCode = investNotifCode,
                attachmentCount = attachmentCount,
                tumorDetails = tumorDetails
            };
            return dataToSend;
        }

        public object SearchNotAppointedPatients(string strMrName)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var str = client.GetPatientLst(strMrName);
            ds.ReadXml(new XmlTextReader(new StringReader(str)));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Columns.Contains("MRNO"))
                {
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    NAME = row["PATNAME"].ToString().Trim(),
                                    GENDER = row["PATSEX"].ToString().Trim(),
                                    PATDOB = GeneralFunction.GetDate(row["PATDOB"].ToString().Trim()), //Added by Murali on 02/08/2024 to get the DOB for Not Appointed Patients
                                    AGE = GeneralFunction.GetAge(GeneralFunction.GetDate(Convert.ToString(row["PATDOB"].ToString().Trim()))),  //row["PATAGE"].ToString().Trim(),
                                    MOBILE = row["PATPHONE"].ToString().Trim(),
                                    EMAIL = row["PATEMAIL"].ToString().Trim(),
                                    REFDOCTNM = row["OREFDRNM"].ToString().Trim(),
                                    REFDOCTCONTACT = row["OREFDRMOBLNO"].ToString().Trim(),
                                    PATIMAGE = GetPatientImageBase64(row["MRNO"].ToString().Trim()),
                                    COMPCODE = row["COMPCODE"].ToString().Trim(), //PRIYANKA 01/04/2026
                                    COMPNAME = row["COMPNAME"].ToString().Trim() == "" ? "Self Paying Patient" : row["COMPNAME"].ToString().Trim() //PRIYANKA 01/04/2026
                                }).ToArray();
                    return data;
                }
            }

            return "";
        }

        private string GetPatientImageBase64(string mrno) //Priyanka 12/01/2026
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

        public string SendSMS(string strMobile, string strMsg, string strMsgType, string strMsgLang = "E")
        {
            try
            {
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create("https://smpp.keepintouch.co.in/vendorsms/pushsms.aspx?user=jupiter&password=jupiter@12345&msisdn=91" + strMobile + "&sid=JUPITR&msg=" + strMsg + "&fl=0&gwid=2&dc=8");
                HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();

                if (strMsgType == "GR")
                {

                }
                return "Success";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //added on 25th june 2019
        public object SavePerMasterSetUp(string strTran, string strMrNo, string strSetUpCd, string strPatName, string strPatAge, string strPatGender, string strPatMobile)
        {
            BL_Oncology bl = new BL_Oncology();
            bl.type = "B";
            bl.InvestOther = strSetUpCd;
            bl.TRANNO = strTran;
            bl.MRNO = strMrNo;
            bl.DoctorCode = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]);
            bl.PatName = string.Format("{0}", strPatName);
            bl.Age = strPatAge;
            bl.Gender = strPatGender;
            bl.MobileNo = strPatMobile;
            bl.TranMode = 1;
            bl.CREATEDBY = Convert.ToString(System.Web.HttpContext.Current.Session["gOncoUserId"].ToString());

            OncologyEMRClient client = new OncologyEMRClient();
            return client.SaveDoctorDesk(bl);

        }
        //Below function added by Murali on 23/10/2024 to call the waiting patient.
        public string CallWaitPatSave(string mrno, string consNo, string TokenNo, string Doctor, string Patient, string ConsDate)
        {
            string Result = "";
            try
            {
                Result = CheckPatOnConsult(mrno, ConsDate);
                if (Result == "")
                {
                    OncologyEMRClient Oncoser = new OncologyEMRClient();
                    string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                    string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
                    string DoctorName = (System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " ");
                    Result = Oncoser.CallWaitPatSave(consNo, TokenNo);
                }
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Cannot insert duplicate key"))
                {
                    Result = "This complaint is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        public string CheckPatOnConsult(string mrno, string ConsDate)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                DataSet dt = new DataSet();
                OutpatientClient Qmsclnt = new OutpatientClient();
                //ConsDate = GeneralFunction.GetDateInSpecifiedFormat(ConsDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                string CurrentDate = DateTime.Now.ToString("yyyyMMdd");
                dt.ReadXml(new XmlTextReader(new StringReader(Qmsclnt.GetDoctorWaitlistForPasswedDate(CurrentDate))));
                if (dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    string strDoctorCd = Convert.ToString(HttpContext.Current.Session["gDoctCode"]);
                    if (dt.Tables[0].Select("MRNO = '" + mrno + "' AND  DOCTCODE <>'" + strDoctorCd + "' AND COMPLETEDYN = 'N' AND STATUS = 'C'").Length > 0)
                    {
                        var DoctLst = Oncoser.GetDoctLst("", "D");
                        string DoctCode = dt.Tables[0].Select("MRNO = '" + mrno + "' AND  DOCTCODE <>'" + strDoctorCd + "' AND COMPLETEDYN = 'N' AND STATUS = 'C'")[0]["DOCTCODE"].ToString().Trim();
                        Result = (DoctLst.Where(x => x.Value == DoctCode).Count() > 0 ? DoctLst.Where(x => x.Value == DoctCode).FirstOrDefault().Text : DoctCode);
                    }
                }
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Cannot insert duplicate key"))
                {
                    Result = "Already Token Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        //Added By Rajan - To Get Referral Notes List
        public object GetReferralNotesLst()
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            string DoctCode = ("" + HttpContext.Current.Session["gDoctCode"]).ToString();
            var str = client.GetRefNotesNotification(DoctCode);
            ds.ReadXml(new XmlTextReader(new StringReader(str)));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var DoctLst = client.GetDoctLst("", "D");
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    TRANNO = row["TRANNO"].ToString().Trim(),
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    DOCTCODE = row["DOCTCODE"].ToString().Trim(),
                                    REFDOCTCODE = row["REFDOCTCODE"].ToString().Trim(),
                                    NOTE = row["NOTE"].ToString().Trim(),
                                    STATUS = row["STATUS"].ToString().Trim(),
                                    REFCONSNO = row["REFCONSNO"].ToString().Trim(),
                                    PATNAME = row["SALUNAME"].ToString().Trim() + " " + row["PATNAME"].ToString().Trim(),
                                    REFBYDOCTOR = row["REFBYDOCTOR"].ToString().Trim(),
                                    REFTODOCTOR = row["REFDOCTCODE"].ToString().Trim() == "" ? "" : (DoctLst.Where(x => x.Value == row["REFDOCTCODE"].ToString().Trim()).Count() > 0 ? DoctLst.Where(x => x.Value == row["REFDOCTCODE"].ToString().Trim()).FirstOrDefault().Text : ""),
                                    IPNO = row["IPNO"].ToString().Trim(),
                                    Date = GeneralFunction.GetDate(row["REFDATE"].ToString().Trim()),
                                    Time = GeneralFunction.ConvertTimeTo12Hour(row["REFTIME"].ToString().Trim()),
                                    ISDOCT = !string.IsNullOrWhiteSpace(row["DOCTCODE"]?.ToString()) && DoctLst.Any(x => x.Value == row["DOCTCODE"].ToString().Trim()) ? "Y" : "N"
                                }).ToArray();
                    return data;
                }
            }
            return "";
        }

        public object GetPatReferralNotes(string TranNo, string Mrno)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            string DoctCode = ("" + HttpContext.Current.Session["gDoctCode"]).ToString();
            var str = client.GetRefNotesAgainstPatient(DoctCode, TranNo, Mrno);
            ds.ReadXml(new XmlTextReader(new StringReader(str)));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var DoctLst = client.GetDoctLst("", "D");
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    TRANNO = row["TRANNO"].ToString().Trim(),
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    DOCTCODE = row["DOCTCODE"].ToString().Trim(),
                                    REFDOCTCODE = row["REFDOCTCODE"].ToString().Trim(),
                                    NOTE = row["NOTE"].ToString().Trim(),
                                    STATUS = row["STATUS"].ToString().Trim(),
                                    REFCONSNO = row["REFCONSNO"].ToString().Trim(),
                                    PATNAME = row["PATNAME"].ToString().Trim(),
                                    REFBYDOCTOR = row["REFBYDOCTOR"].ToString().Trim(),
                                    REFTODOCTOR = row["REFDOCTCODE"].ToString().Trim() == "" ? "" : (DoctLst.Where(x => x.Value == row["REFDOCTCODE"].ToString().Trim()).Count() > 0 ? DoctLst.Where(x => x.Value == row["REFDOCTCODE"].ToString().Trim()).FirstOrDefault().Text : ""),
                                    Date = GeneralFunction.GetDate(row["REFDATE"].ToString().Trim()),
                                    Time = GeneralFunction.ConvertTimeTo12Hour(row["REFTIME"].ToString().Trim()),
                                }).ToArray();
                    return data;
                }
            }
            return "";
        }

        public object GetFractionsStatus(string MRNumber)
        {
            OncologyClient Onco = new OncologyClient();
            DataTable dtPlanComplete = new DataTable();
            DataSet dsPlanComplete = new DataSet();
            CommonServiceClient comserv = new CommonServiceClient();
            object jsonData = "";
            DataTable dt = new DataTable();
            var SchemeList = comserv.GetTariffLst();
            var RTTechList = comserv.GetRTTechLst();
            var OncoDrList = comserv.GetDoctLst();
            var PhysicistList = comserv.GetDoctLst();
            var ConsStatus = GeneralFunction.LstConStatus;
            var SiteList = comserv.GetCRSiteLst();
            var IntType = GeneralFunction.GetIntentList();
            var MachineLst = comserv.GetMacineLst();
            try
            {
                dsPlanComplete.ReadXml(new XmlTextReader(new StringReader(Onco.GetFractionsStatus(MRNumber, "", "", "", "", ""))));
                if (dsPlanComplete.Tables.Count > 0)
                {
                    dt = dsPlanComplete.Tables[0];
                    int counter = 0;
                    jsonData = (from DataRow row in dt.Rows
                                select new
                                {
                                    SERIALNO = ++counter,
                                    MRNO = row["MRNO"].ToString(),
                                    RTNO = row["RTNO"].ToString(),
                                    RTPLANNO = row["RTPLANNO"].ToString(),
                                    PATNAME = row["PATNAME"].ToString(),
                                    PATSEX = GeneralFunction.GetPatGender(("" + row["PATSEX"]).Trim()),
                                    PATDOB = ("" + row["PATDOB"]).Trim() != "" ? GeneralFunction.GetDate(("" + row["PATDOB"]).Trim()) : "",
                                    PATAGE = ("" + row["PATAGE"]).Trim(),
                                    TREATMENT = ("" + row["TREATMENT"]).Trim(),
                                    CONSULTANT = row["CREATEDBY"].ToString().Trim() == "" ? "" : comserv.GetUserList().Where(x => x.UserId == row["CREATEDBY"].ToString().Trim()).Select(p => p.Text).FirstOrDefault(),
                                    TOTALDOSE = ("" + row["TOTALSELECTEDDOSE"]).Trim(),
                                    TOTALFR = ("" + row["TOTALSELECTEDFR"]).Trim(),
                                    ONDATE = row["ONDATE"].ToString() != "" ? GeneralFunction.GetDate(row["ONDATE"].ToString()) : "",
                                    ONTIME = GeneralFunction.ConvertTimeTo24Hour(("" + row["ONTIME"]).Trim()), // Abhishesh || 20260323
                                    STARTDATE = row["STARTDATE"].ToString() != "" ? GeneralFunction.GetDate(row["STARTDATE"].ToString()) : "",
                                    ENDDATE = row["ENDDATE"].ToString() != "" ? GeneralFunction.GetDate(row["ENDDATE"].ToString()) : "",
                                    COMPLETEDFR = ("" + row["COMPLETEDFRACTIONS"]).Trim(),
                                    PENDINGFR = ("" + row["PENDINGFR"]).Trim(),
                                    SCHDTIME = GeneralFunction.ConvertTimeTo24Hour(("" + row["FORTIME"]).Trim()), // Abhishesh || 20260323
                                    STATUS = (("" + row["PENDINGFR"]).Trim() == "0" ? "Completed" : "Pending"),
                                    DIAGNOSIS = ("" + row["DIAGNOSIS"]).Trim(),
                                    STAGE = ("" + row["STAGE"]).Trim(),
                                    TREATMENTSITE = ("" + row["SITE"]).Trim(),
                                    APPRVLSCHDWAITTM = ("" + row["APPRVLSCHDWAITTM"]).Trim(),
                                }).ToList();
                }

                return jsonData;
            }
            catch (Exception ex)
            {
                return ex;
            }
        }

        public object GetPerviousPCDet(string SMRNO)
        {
            OncologyClient Onco = new OncologyClient();
            DataSet dsRecrod = new DataSet();
            dsRecrod.ReadXml(new XmlTextReader(new StringReader(Onco.GetPreviousPCDet(SMRNO))));

            var jsonData = new object[0]; // default to empty array

            if (dsRecrod.Tables.Count > 0 && dsRecrod.Tables[0].Rows.Count > 0)
            {
                jsonData = (from DataRow row in dsRecrod.Tables[0].Rows
                            select new
                            {
                                TRANNO = row["TRANNO"].ToString().Trim(),
                                DATE = GeneralFunction.GetDate(row["CREATEDON"].ToString().Trim())
                            }).ToArray();
            }

            return jsonData;
        }

        public object GetAdmLst(string strMRNo, string FromDate, string ToDate)
        {
            OncologyEMRClient OncoEMRser = new OncologyEMRClient();
            DataTable dtAdm = new DataTable();
            DataSet loads = new DataSet();
            CommonServiceClient comserv = new CommonServiceClient();
            object jsonData = "";
            DataTable dt = new DataTable();
            try
            {
                FromDate = GeneralFunction.GetDateInSpecifiedFormat(FromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                ToDate = GeneralFunction.GetDateInSpecifiedFormat(ToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                loads = comserv.GetIPPatInfo("", strMRNo, "", "", "", "", "", FromDate, ToDate, "", "", "", "", "", "", "");
                if (loads.Tables.Count > 0)
                {
                    var DoctLst = OncoEMRser.GetDoctLst("", "D");
                    var SpecList = OncoEMRser.GetSpecialistnList();
                    dtAdm = loads.Tables[0];
                    jsonData = (from DataRow row in dtAdm.Rows
                                select new
                                {
                                    IPNO = ("" + row["IPNO"]).Trim(),
                                    CONSDOCT = ("" + row["CONSDOCT"]).Trim(),
                                    CONSDOCTSPEC = ("" + row["CONSDOCT"]).ToString().Trim() == "" ? "" : GeneralFunction.GetSpecialityDoctor(DoctLst, SpecList, "", ("" + row["CONSDOCT"]).ToString().Trim()),
                                    ADMNDATE = GeneralFunction.GetDate(("" + row["ADMNDATE"]).Trim()),
                                    ADMNTIME = ("" + row["ADMNTIME"]).Trim(),
                                }).ToList();
                }

                return jsonData;
            }
            catch (Exception ex)
            {
                return ex;
            }
        }

        public object GetNotesLst(string strIPNo, string AdmorFromDate, string CurorToDate, string Doctor, string FromTime, string ToTime)
        {
            ICUServRef.ICUClient icuClient = new ICUServRef.ICUClient();
            DataTable dtNotes = new DataTable();
            DataSet loads = new DataSet();
            CommonServiceClient comserv = new CommonServiceClient();
            object jsonData = "";
            DataTable dt = new DataTable();
            List<UserLstItem> userLst = null;
            CommonServiceClient SecUser = new CommonServiceClient();
            userLst = SecUser.GetUserList().ToList();
            try
            {
                AdmorFromDate = GeneralFunction.GetDateInSpecifiedFormat(AdmorFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                CurorToDate = GeneralFunction.GetDateInSpecifiedFormat(CurorToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                loads.ReadXml(new XmlTextReader(new StringReader(icuClient.GetAddNurseNotes(strIPNo, AdmorFromDate, FromTime, CurorToDate, ToTime, Doctor, "N"))));
                if (loads.Tables.Count > 0)
                {
                    dtNotes = loads.Tables[0];
                    //Abhishesh || 20260817
                    //DataView dv = dtNotes.DefaultView;
                    //dv.Sort = "NOTEDT DESC, NOTETM DESC";
                    //dtNotes = dv.ToTable();
                    //End
                    jsonData = (from DataRow row in dtNotes.Rows
                                select new
                                {
                                    NOTEDT = row["NOTEDT"].ToString().Trim(),
                                    NOTETM = row["NOTETM"].ToString().Trim(),
                                    USERID = !string.IsNullOrEmpty(row["USERID"].ToString().Trim()) ? ((row["NOTETYPE"].ToString().Trim() != "N" ? "Dr. " : "") +
                                         GeneralFunction.GetListValue(userLst, row["USERID"].ToString().Trim()) + " (" + row["USERID"].ToString().Trim() + ")") : "",
                                    NURSENOTES = row["NURSENOTES"].ToString().Trim(),
                                    NOTETYPE = row["NOTETYPE"].ToString().Trim(),
                                    NoteNo = row["NOTENO"].ToString().Trim(),
                                    INKCOLOR = row["INKCOLOR"].ToString().Trim()

                                }).ToList();
                }
                return jsonData;
            }
            catch (Exception ex)
            {
                return ex;
            }
        }

        public object GetDischargeLst(string strMrno, string FromDate, string ToDate)
        {
            DiscSummaryServRef.DischargeSummaryClient dsclnt = new DiscSummaryServRef.DischargeSummaryClient();
            DataSet load = new DataSet();
            object jsonData = string.Empty;
            List<UserLstItem> userLst = null;
            CommonServiceClient SecUser = new CommonServiceClient();
            userLst = SecUser.GetUserList().ToList();
            try
            {
                FromDate = GeneralFunction.GetDateInSpecifiedFormat(FromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                ToDate = GeneralFunction.GetDateInSpecifiedFormat(ToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                load = GeneralFunction.FillDatasetXMl((dsclnt.GetDSList(strMrno, "", FromDate, ToDate, "", "")));
                if (load.Tables.Count > 0)
                {
                    OncologyEMRClient oncoClient = new OncologyEMRClient();
                    var DoctLst = oncoClient.GetDoctLst("", "D");
                    var SpecList = oncoClient.GetSpecialistnList();
                    jsonData = (from DataRow row in load.Tables[0].Rows
                                select new
                                {
                                    DISSUMNO = ("" + row["DISSUMNO"]).Trim(),
                                    IPNO = ("" + row["IPNO"]).Trim(),
                                    DOCTNAME = ("" + row["ADMNDOCTNM"]).ToString().Trim() == "" ? "" : ("" + row["ADMNDOCTNM"]).ToString().Trim(),
                                    DOCTNAMESPC = ("" + row["ADMNDOCT"]).ToString().Trim() == "" ? "" : GeneralFunction.GetSpecialityDoctor(DoctLst, SpecList, ("" + row["ADMNDOCT"]).ToString().Trim(), ""),
                                    CREATEDBY = GeneralFunction.GetListValue(userLst, row["CREATEDBY"].ToString().Trim()) + (" (" + row["CREATEDBY"].ToString().Trim() + ")"),
                                    CREATEDON = GeneralFunction.GetDate(("" + row["CREATEDON"]).Trim()),
                                    CREATEDAT = GeneralFunction.ConvertTimeTo24Hour(("" + row["CREATEDAT"]).Trim()), // Abhishesh || 20260323
                                }).ToList();
                }
                return jsonData;
            }
            catch (Exception ex)
            {
                return ex;
            }
        }

        public List<CommonSerRef.SelectLstItem> GetGeneralExamListData()
        {
            CommonServiceClient comserv = new CommonServiceClient();

            var ICDList = comserv.GetGenralExamLst()
                            .Where(x => x.Status.Trim().ToUpper() == "A")
                            .ToList();

            return ICDList;
        }

        public string GetDischargeDtls(string DisSumaryNo, string Mrno, string IPNo)
        {
            string apPath = System.Web.Hosting.HostingEnvironment.MapPath("~/Upload/");
            CommonServiceClient comserv = new CommonServiceClient();
            DiscSummaryServRef.DischargeSummaryClient dsclnt = new DiscSummaryServRef.DischargeSummaryClient();
            DataTable IcdPrmy = new DataTable("PRIMARY");
            DataTable IcdSecondry = new DataTable("SECONDARY");
            DataTable SystemExm = new DataTable("SYSEXAM");
            DataTable GenExamdt = new DataTable("GENEXAM");
            DataTable dtEmgr = new DataTable("EMGR");
            DataTable dtdrug = new DataTable("DRUG");
            DataTable Attach = new DataTable("ATTACH");
            DataTable dtNewPersnlHist = new DataTable("NEWPERSONALHIST");
            DataTable dtNewPreventive = new DataTable("NEWPREVENTIVE");
            DataTable l_oDT = new DataTable("MAIN");
            DataTable dticd = new DataTable("ICD");
            DataTable dtsystm = new DataTable();
            DataTable dtattach = new DataTable();
            DataTable dtpersonalhist = new DataTable("PERSONALHIST");
            DataTable dtpreventive = new DataTable();
            DataTable dttreatgiv = new DataTable("TREATMENTGIVEN");
            DataSet load = new DataSet();
            load = GeneralFunction.FillDatasetXMl(dsclnt.GetDSDetailsDsSumNo(DisSumaryNo));

            DataSet TreatGN = new DataSet();
            TreatGN = GeneralFunction.FillDatasetXMl(dsclnt.GetDSDetailsPatWise(Mrno.Trim(), IPNo.Trim()));


            if (load.Tables.Count > 0)
                l_oDT = load.Tables[0];
            for (int i = 0; i <= l_oDT.Rows.Count - 1; i++)
            {
                l_oDT.Rows[i]["DIAGNOSIS"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["DIAGNOSIS"]);
                l_oDT.Rows[i]["FINALDIAGNOSIS"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["FINALDIAGNOSIS"]);
                l_oDT.Rows[i]["PASTHIST"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["PASTHIST"]);
                l_oDT.Rows[i]["FAMILYHISTORY"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["FAMILYHISTORY"]);
                l_oDT.Rows[i]["HOSPCOURSE"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["HOSPCOURSE"]);
                l_oDT.Rows[i]["FINDINGS"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["FINDINGS"]);
                l_oDT.Rows[i]["DRUGADVISE"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["DRUGADVISE"]);
                l_oDT.Rows[i]["ADMNREASON"] = GeneralFunction.CheckDblToSingleQuote(l_oDT.Rows[i]["ADMNREASON"]);
            }
            if (load.Tables.Contains("Table1"))
            {
                dtsystm = load.Tables["Table1"];
            }
            if (load.Tables.Contains("Table2"))
            {
                dticd = load.Tables["Table2"];
            }
            if (load.Tables.Contains("Table3"))
            {
                dtattach = load.Tables["Table3"];
            }
            if (load.Tables.Contains("Table4"))
            {
                dtpersonalhist = load.Tables["Table4"];
            }
            if (load.Tables.Contains("Table5"))
            {
                dtpreventive = load.Tables["Table5"];
            }
            if (load.Tables.Contains("Table6"))
            {
                dttreatgiv = load.Tables["Table6"];
            }
            DataTable dtprevious = new DataTable("PREVIOUS");
            dtprevious = l_oDT.Copy();
            dtprevious.TableName = "PREVIOUS";
            string icdprmycode = string.Empty;
            string icdprmyname = string.Empty;
            string icdsecndrycode = string.Empty;
            string icdsecndryname = string.Empty;
            string icdtype = string.Empty;
            string examcode = string.Empty;
            string examval = string.Empty;
            string emrgncycode = string.Empty;
            string emrgncyval = string.Empty;
            string emrgncyrmks = string.Empty;
            string noofdays = string.Empty;
            string dosage = string.Empty;
            string advremarks = string.Empty;
            string drugname = string.Empty;
            string drugcode = string.Empty;
            string genericnm = string.Empty;
            string seqno = string.Empty;
            string ipno = string.Empty;
            string filename = string.Empty;
            string filepath = string.Empty;
            string createdby = string.Empty;
            string createdon = string.Empty;
            string createdat = string.Empty;
            string doctype = string.Empty;
            string habitcd = string.Empty;
            string duration = string.Empty;
            IcdPrmy.Columns.Add("ICDCODE");
            IcdPrmy.Columns.Add("ICDNAME");
            IcdPrmy.Columns.Add("ICDTYPE");
            IcdSecondry.Columns.Add("ICDCODE");
            IcdSecondry.Columns.Add("ICDNAME");
            IcdSecondry.Columns.Add("ICDTYPE");

            SystemExm.Columns.Add("Value");
            SystemExm.Columns.Add("Values");
            SystemExm.Columns.Add("Text");
            GenExamdt.Columns.Add("Value");
            GenExamdt.Columns.Add("Values");
            GenExamdt.Columns.Add("Text");


            dtEmgr.Columns.Add("Select");
            dtEmgr.Columns.Add("TEXT");
            dtEmgr.Columns.Add("REMARKS");
            dtEmgr.Columns.Add("CODE");

            dtdrug.Columns.Add("DRUGCODE");
            dtdrug.Columns.Add("DRUGNAME");
            dtdrug.Columns.Add("GENERICNM");
            dtdrug.Columns.Add("QOH");
            dtdrug.Columns.Add("NOOFDAYS");
            dtdrug.Columns.Add("DOSAGE");
            dtdrug.Columns.Add("DOSAGEVAL");
            dtdrug.Columns.Add("INTAKETIME");
            dtdrug.Columns.Add("REMARKS");
            dtdrug.Columns.Add("SEQNO");

            Attach.Columns.Add("FILEPATH");
            Attach.Columns.Add("FILENAME");
            Attach.Columns.Add("FILEDATE");
            Attach.Columns.Add("DOCUMENTTYPE");
            Attach.Columns.Add("CREATEDBY");

            dtNewPersnlHist.Columns.Add("HABIT");
            dtNewPersnlHist.Columns.Add("DURATION");
            dtNewPreventive.Columns.Add("Code");
            dtNewPreventive.Columns.Add("Select");
            dtNewPreventive.Columns.Add("GUIDELNTEXT");
            dtNewPreventive.Columns.Add("Text");
            dtNewPreventive.Columns.Add("Language1");
            dtNewPreventive.Columns.Add("Language2");
            dtNewPreventive.Columns.Add("Language3");
            var GeneralExm = GetGeneralExamListData();
            for (int i = 0; i <= dticd.Rows.Count - 1; i++)
            {
                if (dticd.Rows[i]["ICDTYPE"].ToString() == "P")
                {
                    icdprmycode = dticd.Rows[i]["ICODE"].ToString().Trim();
                    icdprmyname = dticd.Rows[i]["INAME"].ToString().Trim();
                    icdtype = dticd.Rows[i]["ICDTYPE"].ToString().Trim();
                    DataRow dr = IcdPrmy.NewRow();
                    dr["ICDCODE"] = icdprmycode;
                    dr["ICDNAME"] = icdprmyname;
                    dr["ICDTYPE"] = icdtype;
                    IcdPrmy.Rows.Add(dr);
                }
                else if (dticd.Rows[i]["ICDTYPE"].ToString() == "S")
                {
                    icdsecndrycode = dticd.Rows[i]["ICODE"].ToString();
                    icdsecndryname = dticd.Rows[i]["INAME"].ToString();
                    icdtype = dticd.Rows[i]["ICDTYPE"].ToString();
                    DataRow dr = IcdSecondry.NewRow();
                    dr["ICDCODE"] = icdsecndrycode;
                    dr["ICDNAME"] = icdsecndryname;
                    dr["ICDTYPE"] = icdtype;
                    IcdSecondry.Rows.Add(dr);
                }
            }
            for (int s = 0; s <= GeneralExm.Count - 1; s++)
            {
                DataRow dr = GenExamdt.NewRow();
                dr["Value"] = GeneralExm[s].Value;
                dr["Text"] = GeneralExm[s].Text;
                dr["Values"] = "";
                GenExamdt.Rows.Add(dr);
            }
            for (int i = 0; i < dtsystm.Rows.Count; i++)
            {
                string geneamCode = dtsystm.Rows[i]["GENEAMCODE"].ToString().Trim();
                if (!string.IsNullOrEmpty(geneamCode))
                {
                    var match = GeneralExm
                                .FirstOrDefault(x => x.Value == geneamCode);
                    if (match != null)
                    {
                        examval = dtsystm.Rows[i]["GENEXAMVAL"].ToString().Trim();
                        DataRow dr = SystemExm.NewRow();
                        dr["Value"] = geneamCode;
                        dr["Text"] = match.Text;
                        dr["Values"] = examval;
                        SystemExm.Rows.Add(dr);
                    }
                }
            }


            for (int m = 0; m <= dtsystm.Rows.Count - 1; m++)
            {
                for (int i = 0; i <= GenExamdt.Rows.Count - 1; i++)
                {
                    if (dtsystm.Rows[m]["GENEAMCODE"].ToString().Trim() == GenExamdt.Rows[i]["Value"].ToString().Trim())
                    {
                        GenExamdt.Rows[i]["Values"] = dtsystm.Rows[m]["GENEXAMVAL"].ToString().Trim();
                    }
                }
            }

            for (int i = 0; i <= dtsystm.Rows.Count - 1; i++)
            {
                if (dtsystm.Rows[i]["EMRGNCYCODE"].ToString().Trim() != "")
                {
                    var EmergContactLst = comserv.GetEmergencyContactLst();

                    var emrgncytext = EmergContactLst.ToList().FindAll
                      (x => x.Value == dtsystm.Rows[i]["EMRGNCYCODE"].ToString().Trim()).First().Text;

                    emrgncyrmks = dtsystm.Rows[i]["EMRGNCYREMARKS"].ToString().Trim();
                    DataRow dr = dtEmgr.NewRow();
                    dr["TEXT"] = emrgncytext;
                    dr["CODE"] = dtsystm.Rows[i]["EMRGNCYCODE"];
                    dr["REMARKS"] = emrgncyrmks;
                    dr["Select"] = "Y";
                    dtEmgr.Rows.Add(dr);
                }

            }

            CommonSerRef.SelectLstItem[] selIntake = comserv.GetIntake();
            for (int i = 0; i <= dtsystm.Rows.Count - 1; i++)
            {
                if (dtsystm.Rows[i]["DRUGNAME"].ToString().Trim() != "")
                {
                    var intaketime = dtsystm.Rows[i]["INTAKETIME"].ToString().Trim();
                    DataRow dr = dtdrug.NewRow();
                    dr["DRUGCODE"] = dtsystm.Rows[i]["DRUGCODE"].ToString().Trim();
                    dr["DRUGNAME"] = dtsystm.Rows[i]["DRUGNAME"].ToString().Trim();
                    dr["GENERICNM"] = dtsystm.Rows[i]["GENERICNM"].ToString().Trim();
                    dr["NOOFDAYS"] = dtsystm.Rows[i]["NOOFDAYS"].ToString().Trim();
                    dr["DOSAGE"] = dtsystm.Rows[i]["DOSAGE"].ToString().Trim();
                    dr["INTAKETIME"] = selIntake.AsEnumerable().Where(x => x.Value == intaketime).Count() > 0 ? selIntake.AsEnumerable().Where(x => x.Value == intaketime).First().Text : intaketime;
                    dr["DOSAGEVAL"] = intaketime;
                    dr["REMARKS"] = dtsystm.Rows[i]["ADVREMARKS"].ToString().Trim();
                    dr["SEQNO"] = dtsystm.Rows[i]["SEQNO"].ToString().Trim();
                    dtdrug.Rows.Add(dr);
                }
            }
            for (int i = 0; i <= dtattach.Rows.Count - 1; i++)
            {
                ipno = dtattach.Rows[i]["IPNO"].ToString().Trim();
                filepath = dtattach.Rows[i]["FILEPATH"].ToString().Trim();
                filename = dtattach.Rows[i]["FILENM"].ToString().Trim();
                createdby = dtattach.Rows[i]["CREATEDBY"].ToString().Trim();
                createdon = dtattach.Rows[i]["CREATEDON"].ToString().Trim();
                createdat = dtattach.Rows[i]["CREATEDAT"].ToString().Trim();
                doctype = dtattach.Rows[i]["DOCTYPE"].ToString().Trim();
                DataRow dr = Attach.NewRow();
                dr["FILENAME"] = filename;
                dr["FILEDATE"] = GeneralFunction.GetDate(createdon) + " " + createdat;
                dr["CREATEDBY"] = createdby;
                dr["FILEPATH"] = filepath;
                dr["DOCUMENTTYPE"] = doctype;
                Attach.Rows.Add(dr);
            }
            var HabitList = comserv.GetHabitList();
            for (int i = 0; i <= dtpersonalhist.Rows.Count - 1; i++)
            {
                habitcd = HabitList.Where(x => x.Value == dtpersonalhist.Rows[i]["HABITCODE"].ToString().Trim()).Count() > 0 ? HabitList.Where(x => x.Value == dtpersonalhist.Rows[i]["HABITCODE"].ToString().Trim()).First().Text : dtpersonalhist.Rows[i]["HABITCODE"].ToString();
                duration = dtpersonalhist.Rows[i]["DURATION"].ToString();
                DataRow dr = dtNewPersnlHist.NewRow();
                dr["HABIT"] = habitcd;
                dr["DURATION"] = duration;
                dtNewPersnlHist.Rows.Add(dr);
            }
            var GuideLst = comserv.GetPrevGuideLineLst("");
            for (int i = 0; i <= dtpreventive.Rows.Count - 1; i++)
            {
                DataRow dr = dtNewPreventive.NewRow();
                dr["Select"] = "Y";
                dr["Code"] = dtpreventive.Rows[i]["GUIDELNCD"].ToString();
                dr["GUIDELNTEXT"] = dtpreventive.Rows[i]["GUIDELNTEXT"].ToString();
                dr["Text"] = GuideLst.Where(x => x.Value == dtpreventive.Rows[i]["GUIDELNCD"]).ToString().Trim().Count() == 0 ? "" :
                   GuideLst.Where(p => p.Value == dtpreventive.Rows[i]["GUIDELNCD"].ToString().Trim()).First().Text;
                dr["Language1"] = dtpreventive.Rows[i]["Language1"].ToString();
                dr["Language2"] = dtpreventive.Rows[i]["Language2"].ToString();
                dr["Language3"] = dtpreventive.Rows[i]["Language3"].ToString();
                dtNewPreventive.Rows.Add(dr);
            }
            if (dttreatgiv.Rows.Count > 0 && TreatGN.Tables.Contains("Table1"))
            {
                DataTable DT = TreatGN.Tables["Table1"];
                dttreatgiv.Columns.Add("ROUTE");
                dttreatgiv.Columns.Add("FREQ");
                dttreatgiv.Columns.Add("DOSE");
                dttreatgiv.Columns.Add("DRUGNAME");
                for (int i = 0; i <= dttreatgiv.Rows.Count - 1; i++)
                {
                    DataRow[] DR = DT.Select("MTRLCODE = '" + dttreatgiv.Rows[i]["DRUGCODE"] + "'");
                    if (DR.Length > 0)
                    {
                        dttreatgiv.Rows[i]["ROUTE"] = DR[0]["ROUTE"].ToString();
                        dttreatgiv.Rows[i]["FREQ"] = DR[0]["FREQ"].ToString();
                        dttreatgiv.Rows[i]["DOSE"] = DR[0]["DOSE"].ToString();
                        dttreatgiv.Rows[i]["DRUGNAME"] = DR[0]["MTRLNAME"].ToString();
                    }
                }
            }


            DataSet loadS = new DataSet();
            loadS.Tables.Add(l_oDT.Copy());
            loadS.Tables.Add(IcdPrmy);
            loadS.Tables.Add(IcdSecondry);
            loadS.Tables.Add(GenExamdt);
            loadS.Tables.Add(dtEmgr);
            loadS.Tables.Add(dtdrug);
            loadS.Tables.Add(Attach);
            loadS.Tables.Add(dtprevious);
            loadS.Tables.Add(dtNewPersnlHist);
            loadS.Tables.Add(dtNewPreventive);
            loadS.Tables.Add(dttreatgiv.Copy());
            object jsonData = string.Empty;
            return JsonConvert.SerializeObject(loadS, Newtonsoft.Json.Formatting.None);
        }

        public object TumorBoardPatLstBindingData(string sfrmdate, string stodate, string spatname, string smrno, string RefTumor, string RefTumorStatus)  //, string strType
        {
            OncologyClient onclgclnt = new OncologyClient();
            CommonServiceClient comserv = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();

            var ConsDrLst = comserv.GetConsDoctList();
            var patCatg = comserv.GetPatCatgLst();
            var cmpSchme = comserv.GetTariffLst();
            object jsonData = "";
            //string strType = "L";
            //Priyanka 09/04/2026
            sfrmdate = GeneralFunction.GetDateInSpecifiedFormat(sfrmdate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            stodate = GeneralFunction.GetDateInSpecifiedFormat(stodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            //End
            load.ReadXml(new XmlTextReader(new StringReader(onclgclnt.GetTumorBoardPatList(sfrmdate, stodate, spatname, smrno, "L", "", RefTumor, RefTumorStatus))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables[0];

            jsonData = new
            {
                rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            TRANNO = ("" + row["TRANNO"]).Trim(),
                            //TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()),
                            //TRANTIME = ("" + row["TRANTIME"]).Trim(),
                            TRANDATE = GeneralFunction.GetDate(("" + row["TRANDATE"]).Trim()) + "     " + GeneralFunction.ConvertTimeTo24Hour(("" + row["TRANTIME"]).Trim()), // Abhishesh || 20260323
                            MRNO = ("" + row["MRNO"]).Trim(),
                            //TBMSDATE = GeneralFunction.GetDate(("" + row["TBMSDATE"]).Trim()),
                            //TBMSTIME = ("" + row["TBMSTIME"]).Trim(),
                            TBMSDATE = GeneralFunction.GetDate(("" + row["TBMSDATE"]).Trim()) + "     " + ("" + row["TBMSTIME"]).Trim(),
                            //TBMSTIME = ("" + row["TBMSTIME"]).Trim(),
                            PATNAME = ("" + row["PATNAME"]).Trim(),
                            PATAGE = ("" + row["PATAGE"]).Trim(),
                            PATSEX = GeneralFunction.GetPatGender(("" + row["PATSEX"]).Trim()),
                            //PATDOB = GeneralFunction.GetDate(("" + row["PATDOB"]).Trim()),
                            CONTACTNO = ("" + row["PATMOBILE"]).Trim(),
                            REFDOCTCD = ("" + row["DOCTCODE"]).Trim(),
                            REFDOCTNM = ("" + row["DOCTNAME"]).Trim(),
                            REMARKS = ("" + row["PRESCREMARK"]).Trim(),
                            STATUS = ("" + row["STATUS"]).Trim(),

                            //MDIAGCD = ("" + row["MDIAG"]).Trim(),
                            //MDIAGNAME = ("" + row["MDIAGNAME"]).Trim(),

                            //ICDDIAGCD = ("" + row["ICDDIAG"]).Trim(),
                            //ICDDIAGNAME = ("" + row["ICDDIAGNAME"]).Trim(),
                            RESCHDDATE = GeneralFunction.GetDate(("" + row["RESCHDDATE"]).Trim()) + "     " + GeneralFunction.ConvertTimeTo24Hour(("" + row["RESCHDTIME"]).Trim()),  // Abhishesh || 20260323

                        }).ToArray()

            };

            return jsonData;

        }

        public DataSet getPatInfo(string MrNo, string Tranno)
        {
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataTable dtTest = new DataTable();
            new OncologyClient().UsingSafe(onc =>
            {
                load.ReadXml(new XmlTextReader(new StringReader(onc.GetTumorBoardPatList("", "", "", MrNo, "D", Tranno, "", ""))));
            });
            return load;
        }

        public object GetCombinedTumorBoardDetails(string MrNo, string TranNo)
        {
            // 1. Get Data from Service
            DataSet ds = getPatInfo(MrNo, TranNo); // Using your existing service call

            // We also need the service refs for descriptions (as in your previous function)
            //WEBJUPHMIS.OncoCommonServRef.CommonServiceClient Onco = new WEBJUPHMIS.OncoCommonServRef.CommonServiceClient();
            CommonServiceClient Onco = new CommonServiceClient();
            OncologyClient client = new OncologyClient();
            var HistoList = Onco.ICDHISTOLst("");
            var str = client.GetTBDTreatmentDet(MrNo);//PRIYANKA 14/04/2026

            var Surgery = Onco.GetAllSurgeryLst();
            var Chemo = Onco.GetChemoNameLst();

            // Initialize response structure
            var result = new
            {
                Table = new List<object>(), // Main Header info
                ICDO = new List<object>(),  // Histology/Topology
                TREATMENT = new List<object>() // Treatment Grid
            };

            if (ds == null || ds.Tables.Count == 0) return result;

            // --- TABLE 0: Main Info (Liability, Site, Stage, Meeting) ---
            if (ds.Tables.Contains("TumorBrdEntryDet") && ds.Tables["TumorBrdEntryDet"].Rows.Count > 0)
            {
                DataRow dr = ds.Tables["TumorBrdEntryDet"].Rows[0];

                // Handling the "Reason" logic
                string reason = dr["REASONOTH"].ToString();
                if (dr["REASONAGED"].ToString().ToUpper() == "Y") reason = "Aged " + reason;
                if (dr["REASONLOWTUMOR"].ToString().ToUpper() == "Y") reason = "Low Tumor " + reason;

                result.Table.Add(new
                {
                    SITE = ds.Tables["TumorBrdEntryDet"].Columns.Contains("SITE") ? dr["SITE"].ToString() : "",//PRIYANKA 14/04/2026
                    //SUBSITE = dr["SUBSITE"].ToString(),
                    SUBSITE = ds.Tables["TumorBrdEntryDet"].Columns.Contains("SUBSITE") ? dr["SUBSITE"].ToString() : "",//PRIYANKA 14/04/2026
                    //TNM = dr["TNM"].ToString(),
                    TNM = ds.Tables["TumorBrdEntryDet"].Columns.Contains("TNM") ? dr["TNM"].ToString() : "",//PRIYANKA 14/04/2026
                    //STAGE = dr["STAGE"].ToString(),
                    STAGE = ds.Tables["TumorBrdEntryDet"].Columns.Contains("STAGE") ? dr["STAGE"].ToString() : "",//PRIYANKA 14/04/2026
                    TBDATE = GeneralFunction.GetDate(Convert.ToString(dr["TBMSDATE"])),//PRIYANKA 14/04/2026
                    TBTIME = dr["TBMSTIME"].ToString().Trim(),
                    LIABILITY = dr["RESLIABILITY"].ToString() == "N" ? "NO" : dr["RESLIABILITY"].ToString() == "Y" ? "YES" : "",//PRIYANKA 14/04/2026
                    REASON = reason,
                    GENETIC_ALT = dr["GENERICALT"].ToString() == "N" ? "NO" : dr["GENERICALT"].ToString() == "Y" ? "YES" : "",//PRIYANKA 14/04/2026
                    ALT_COUNT = dr["NOGENERICALT"].ToString(),
                    RECOMMENDATIONS = dr["RECOMMENDATIONS"].ToString(),
                    CAREPLAN = dr["FINALCAREPLAN"].ToString(),
                    STATUS = dr["STATUS"].ToString().Trim() == "O" ? "Completed" :
                             dr["STATUS"].ToString().Trim() == "V" ? "Verified" :
                             dr["STATUS"].ToString().Trim() == "S" ? "Scheduled" :
                             dr["STATUS"].ToString().Trim() == "C" ? "Cancelled" :
                            string.IsNullOrEmpty(dr["STATUS"].ToString().Trim()) ? "Pending" : "",
                });
            }

            // --- ICDO: Histology (from Table 4 as per your GetPatDiagVitalHistory logic) ---
            if (ds.Tables.Count > 4 && ds.Tables[4].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[4].Rows)
                {
                    result.ICDO.Add(new
                    {
                        ICDCODE = row["HCODE"].ToString().Trim(),
                        TOPOLOGY = row["TOPODESC"].ToString().Trim(),
                        //HISTOLOGY = HistoList.FirstOrDefault(x => x.Value == row["HCODE"].ToString().Trim())?.Text ?? row["HCODE"].ToString()
                        HISTOLOGY = row["HCODE"].ToString() != "" ? GeneralFunction.GetListValue(HistoList, row["HCODE"].ToString()) : ""
                    });
                }
            }

            // --- TREATMENT: Treatment Grid (from TreatmentDet) ---
            if (ds.Tables.Contains("TreatmentDet"))
            {
                foreach (DataRow row in ds.Tables["TreatmentDet"].Rows)
                {
                    result.TREATMENT.Add(new
                    {
                        TREATNAME = row["TREATMENTNAME"].ToString(),
                        //DETAILS = row["TREATMENTDET"].ToString().Trim(),
                        //priyanka 14/04/2026
                        DETAILS = row["TREATMENTNAME"].ToString().Trim() == "Surgery"
                                   ? (Surgery.Where(x => x.Value == ("" + row["TREATMENTDET"]).ToString().Trim()).Any()
                                       ? Surgery.Where(x => x.Value == ("" + row["TREATMENTDET"]).ToString().Trim()).First().Text
                                       : "")
                                   : row["TREATMENTNAME"].ToString().Trim() == "Chemotherapy"
                                       ? (Chemo.Where(x => x.Value == ("" + row["TREATMENTDET"]).Trim()).Any()
                                           ? Chemo.Where(x => x.Value == ("" + row["TREATMENTDET"]).Trim()).First().Text
                                           : "")
                                       : row["TREATMENTDET"].ToString().Trim(),
                        //end
                        TDATE = GeneralFunction.GetDate(Convert.ToString(row["TREATMENTDATE"])),//PRIYANKA 14/04/2026
                        CYCLES = row["CYCLENO"].ToString(),
                        REMARKS = row["REMARKS"].ToString()
                    });
                }
            }

            return result;
        }

    }

    public class PatientSearch// : BL_PatRegister
    {
        public string OnlyPayStat { get; set; }
        public string PatEmail { get; set; }
        public string MRNO
        {
            get;
            set;
        }
        public string TRANNO
        {
            get;
            set;
        }
        public string TRANDT
        {
            get;
            set;
        }
        public string TRANTM
        {
            get;
            set;
        }
        public string CREATEDBY
        {
            get;
            set;
        }

        private Int32 tranmode = 0;
        public Int32 TranMode
        {
            get { return tranmode; }
            set { tranmode = value; }
        }
        public string PatName { get; set; }
        public string DOB { get; set; }
        public string Age { get; set; }
        public string Gender { get; set; }
        public string PatAdd { get; set; }
        public string PatCatg { get; set; }
        public string DoctorName { get; set; }
        public string DoctorCode { get; set; }
        public string CompName { get; set; }
        public string MobileNo { get; set; }
        public string ContactNo { get; set; }
        public string Email { get; set; }
        public byte[] PatPhoto { get; set; }

        public string CONSNO { get; set; }
        public string ConsDate { get; set; }
        public string ConsTime { get; set; }
        public string OutRefDrContact { get; set; }
        public string OutRefDrName { get; set; }
        public string CONTOKNO { get; set; } //Added by Murlai on 23/10/2024
        public string ConsDoctName { get; set; } //Added by Murlai on 23/10/2024
        public string AdvisedDoctName { get; set; }//priyanka 23/02/2026
        public List<SelectListItem> lstGender
        {
            get
            {
                return GeneralFunction.GetGenderCmb();
            }
        }

        public List<SelectListItem> lstPatCatGcd
        {
            get
            {

                return GeneralFunction.GetPatCatg();
            }
        }
        public string Imgsrc { get; set; }
        public string CurDate { get; set; }
        public string EDITEDBY { get; set; }
        public string APPTTM { get; set; }
        public string DIFFTM { get; set; }
        public string CompletedYN { get; set; }
        public string ComCode { get; set; }
        //Priyanka 14/11/2025
        public string VisitType { get; set; }
        public string ReviewRYN { get; set; }
        public string Appmntno { get; set; }
        public string PriorityType { get; set; }
        public string VisitTypeCD { get; set; } //Priyanka 06/01/2026
        public string PatImageURL { get; set; }
        public string VisitPurposeCD { get; set; }//Priyanka 13/01/2026
        public string Status { get; set; }
        public string Compltm { get; set; }
        public string SurgName { get; set; }
        public string NatureSurgy { get; set; }
        public string RefDoctor { get; set; }
        public string RefPACTranNo { get; set; } //Added by Priyanka on 19/02/2026
        public string Apmnttypecd { get; set; }
        public string Apmnttype { get; set; }
        public string ApmntVisitType { get; set; }
        public string ApmntVisitTypeCD { get; set; }

        public string CONSDOCT { get; set; }
        private string GetAge(string DtDob)
        {
            DateTime dt = DateTime.Today;
            DateTime dob = Convert.ToDateTime(DtDob);
            int days = dt.Day - dob.Day;
            if (days < 0)
            {
                dt = dt.AddMonths(-1);
                days += DateTime.DaysInMonth(dt.Year, dt.Month);
            }

            int months = dt.Month - dob.Month;
            if (months < 0)
            {
                dt = dt.AddYears(-1);
                months += 12;
            }

            int years = dt.Year - dob.Year;

            string AGE = "";
            AGE = years.ToString().PadLeft(3, '0') + ":" + months.ToString().PadLeft(2, '0') + ":" + days.ToString().PadLeft(2, '0');
            if (AGE.Contains('-'))
            {
                return AGE = "000:00:00";
            }
            else
            {
                return AGE;
            }
            //return string.Format("{0} year{1}, {2} month{3} and {4} day{5}",
            //                     years, (years == 1) ? "" : "s",
            //                     months, (months == 1) ? "" : "s",
            //                     days, (days == 1) ? "" : "s");
        }

        //Pournima 06/02/2026
        public string ARRIVEDYN { get; set; }
        public string ARRIVEDTM { get; set; }
        public string POSTTOCONSYN { get; set; }
        public string POSTTOCONSTM { get; set; }

        public Dictionary<string, object> GetPatientList(string strClinicCode, string strDoctorCd, string dayType = "T", int CustomeDate = 0, string Type = "")
        {
            Dictionary<string, object> dicResult = new Dictionary<string, object>();
            OncologyEMRClient clOnco = new OncologyEMRClient();
            DataSet ds = new DataSet();
            List<PatientSearch> listPatSearch = new List<PatientSearch>();
            CommonServiceClient com = new CommonServiceClient();
            string strDate = com.GetServerDate();

            //strDate = "23/08/2021"; 
            //strDate = "18/03/2021";

            DateTime dt = DateTime.ParseExact(strDate, @"dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            if (dayType == "Y")
            {
                dt = dt.Date.AddDays(-1);
                strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            else if (dayType == "O") // Tommarow
            {
                dt = dt.Date.AddDays(1);
                strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            else if (dayType == "B") // Day Before Yesterday
            {
                dt = dt.Date.AddDays(-2);
                strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            else if (dayType == "D") // Day Before Yesterday
            {
                dt = dt.Date.AddDays(-CustomeDate);
                strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            else
                strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            //strDate = "20210809";
            if (Type == "PAC")
            {
                ds.ReadXml(new StringReader(clOnco.GetPACPatientList(strDoctorCd, strDate, strClinicCode)));
            }
            else
            {
                ds.ReadXml(new StringReader(clOnco.GetPatientDetails("", "", "", strDoctorCd, strDate, strDate, strClinicCode)));
            }

            if (ds.Tables.Count > 0 && ds.Tables.Contains("Table"))
            {
                // In case of show all patient show only pending prescription of other doctors not completed one 
                // To avoid the modification so here added conditions without doctor search for perticular clinic
                if (strDoctorCd == "")
                {

                    string strLoginDoctorCD = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]);
                    DataRow[] rowSelInComplPres = ds.Tables["Table"].Select("COMPLETEDYN='N' OR CONSDOCT = '" + strLoginDoctorCD + "' OR PRESCDOCT='" + strLoginDoctorCD + "'");
                    ds.Tables.Remove(ds.Tables["Table"].TableName);
                    if (rowSelInComplPres != null && rowSelInComplPres.Length > 0)
                    {
                        DataTable tbl = rowSelInComplPres.CopyToDataTable();
                        tbl.TableName = "Table";
                        ds.Tables.Add(tbl);
                    }
                }//

                if (ds.Tables.Count > 0 && ds.Tables.Contains("Table"))
                {
                    foreach (DataRow dr in ds.Tables["Table"].Rows)
                    {
                        PatientSearch clPat = new PatientSearch();
                        clPat.CONSNO = Convert.ToString(dr["CONSNO"]);
                        clPat.MRNO = Convert.ToString(dr["MRNO"]);
                        clPat.ConsDate = GeneralFunction.GetDate(Convert.ToString(dr["CONSDATE"]));
                        clPat.ConsTime = Convert.ToString(dr["CONSTIME"]);
                        clPat.PatName = Convert.ToString(dr["PATNAME"]).Trim();
                        clPat.DOB = GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"])); //GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"]));
                        clPat.Age = GeneralFunction.GetAge(clPat.DOB);// Convert.ToString(dr["PATAGE"]);
                        clPat.Gender = Convert.ToString(dr["PATSEX"]);
                        clPat.APPTTM = Convert.ToString(dr["APPTTIME"]).Replace(".", ":");
                        clPat.MobileNo = Convert.ToString(dr["PATPHONE"]).Trim();
                        clPat.OnlyPayStat = Convert.ToString(dr["ONLPAYSTAT"]);
                        clPat.PatEmail = Convert.ToString(dr["PATEMAIL"]).Trim();
                        if (clPat.APPTTM != "")
                        {
                            TimeSpan diff2 = (DateTime.Now - new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, Convert.ToInt32(clPat.APPTTM.Split(':')[0]), Convert.ToInt32(clPat.APPTTM.Split(':')[1]), 0));
                            clPat.DIFFTM = diff2.TotalMinutes.ToString();
                        }
                        else { clPat.DIFFTM = "0"; }
                        //clPat.APPTTM = "<u>" + Convert.ToString(dr["PRIORITY"]).Trim() + "</u> " + clPat.APPTTM;
                        clPat.APPTTM = Type == "PAC" ? "<u>" + Convert.ToString(dr["PRIORITY"]).Trim() + "</u> " + clPat.APPTTM : clPat.APPTTM;//priyanka 14/11/2025
                        clPat.TRANNO = Convert.ToString(dr["TRANNO"]);
                        clPat.CompletedYN = Convert.ToString(dr["COMPLETEDYN"]);
                        clPat.OutRefDrName = Convert.ToString(dr["OREFDRNM"]).Trim();
                        clPat.OutRefDrContact = Convert.ToString(dr["OREFDRPHONNO"]).Trim() + " , " + Convert.ToString(dr["OREFDRMOBLNO"]).Trim();
                        clPat.CONTOKNO = Convert.ToString(dr["CONTOKNO"]).Trim();  //Added by Murali on 23/10/2024
                        clPat.ComCode = Type == "PAC" ? Convert.ToString(dr["CRDCOMPCD"]) : Convert.ToString(dr["COMPCODE"]);//added by priyanka on 08/10/2025
                        clPat.CompName = Type == "PAC" ? Convert.ToString(dr["COMPNAME"]) : Convert.ToString(dr["COMPNAME"]);//added by priyanka on 08/10/2025
                                                                                                                             //Priyanka 14/11/2025
                        clPat.VisitType = dr.Table.Columns.Contains("VISITTYPECD") && Convert.ToString(dr["VISITTYPECD"]).Trim() == "01" ? "NW" :
                                          dr.Table.Columns.Contains("VISITTYPECD") && Convert.ToString(dr["VISITTYPECD"]).Trim() == "02" ? "FU" : "";
                        clPat.ReviewRYN = dr.Table.Columns.Contains("REVIEWRPTYN") ? Convert.ToString(dr["REVIEWRPTYN"]).Trim() : "";
                        clPat.Appmntno = dr.Table.Columns.Contains("APPMNTNO") ? Convert.ToString(dr["APPMNTNO"]).Trim() : "";
                        clPat.PriorityType = dr.Table.Columns.Contains("PRIORITY") && (Convert.ToString(dr["PRIORITY"]).Trim().Contains("H") || Convert.ToString(dr["PRIORITY"]).Trim().Contains("I") || Convert.ToString(dr["PRIORITY"]).Trim().Contains("V")) ? ("-" + Convert.ToString(dr["PRIORITY"]).Trim()) : "";
                        clPat.ARRIVEDYN = Convert.ToString(dr["ARRIVEDYN"]);
                        clPat.ARRIVEDTM = Convert.ToString(dr["ARRIVEDTM"]);
                        clPat.POSTTOCONSYN = Convert.ToString(dr["POSTTOCONSYN"]);
                        clPat.POSTTOCONSTM = Convert.ToString(dr["POSTTOCONSTM"]);
                        listPatSearch.Add(clPat);
                    }
                }

            }
            string ClinicSpecLst = "";
            if (ds.Tables.Count > 0 && ds.Tables.Contains("Table1"))
            {
                ClinicSpecLst = JsonConvert.SerializeObject(ds.Tables["Table1"]);
            }
            dicResult.Add("Status", "Success");
            dicResult.Add("Result", listPatSearch);
            dicResult.Add("ClinicSpeciality", ClinicSpecLst);
            return dicResult;
        }

        //suchita -- for tommorows data
        public Dictionary<string, object> GetPatientListofTommorow(string strClinicCode, string strDoctorCd)
        {

            Dictionary<string, object> dicResult = new Dictionary<string, object>();
            OncologyEMRClient clOnco = new OncologyEMRClient();
            DataSet ds = new DataSet();
            List<PatientSearch> listPatSearch = new List<PatientSearch>();
            //string strClinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
            //    string strDate = DateTime.Now.Year + "" + PreFixZero(DateTime.Now.Month.ToString()) + "" + PreFixZero(DateTime.Now.Day.ToString());
            CommonServiceClient com = new CommonServiceClient();
            string strDate = com.GetServerDate();
            DateTime datetommorow = Convert.ToDateTime(strDate).AddDays(1);
            strDate = datetommorow.ToString("dd/MM/yyyy");
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            //ds.ReadXml(new StringReader(clOnco.GetPatientDetails("", "", "", strDoctorCd, "20170101", strDate, strClinicCode)));

            ds.ReadXml(new StringReader(clOnco.GetPatientDetails("", "", "", strDoctorCd, strDate, strDate, strClinicCode)));

            if (ds.Tables.Count > 0 && ds.Tables.Contains("Table"))
            {
                //ds.Tables[0].DefaultView.RowFilter = "TRANNO = ''";
                //DataTable newdt = (ds.Tables[0].DefaultView).ToTable();
                foreach (DataRow dr in ds.Tables["Table"].Rows)
                {
                    PatientSearch clPat = new PatientSearch();
                    clPat.CONSNO = Convert.ToString(dr["CONSNO"]);
                    clPat.MRNO = Convert.ToString(dr["MRNO"]);
                    clPat.ConsDate = GeneralFunction.GetDate(Convert.ToString(dr["CONSDATE"]));
                    clPat.ConsTime = Convert.ToString(dr["CONSTIME"]);
                    clPat.PatName = Convert.ToString(dr["PATNAME"]);
                    clPat.DOB = GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"])); //GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"]));
                    clPat.Age = GeneralFunction.GetAge(clPat.DOB); //Convert.ToString(dr["PATAGE"]);
                    clPat.Gender = Convert.ToString(dr["PATSEX"]);
                    clPat.APPTTM = Convert.ToString(dr["APPTTIME"]);
                    clPat.MobileNo = Convert.ToString(dr["PATPHONE"]);
                    clPat.OnlyPayStat = Convert.ToString(dr["ONLPAYSTAT"]);

                    if (clPat.APPTTM != "")
                    {
                        TimeSpan diff2 = (DateTime.Now - new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, Convert.ToInt32(clPat.APPTTM.Split(':')[0]), Convert.ToInt32(clPat.APPTTM.Split(':')[1]), 0));
                        clPat.DIFFTM = diff2.TotalMinutes.ToString();
                    }
                    else { clPat.DIFFTM = "0"; }

                    clPat.TRANNO = Convert.ToString(dr["TRANNO"]);
                    clPat.CompletedYN = Convert.ToString(dr["COMPLETEDYN"]);

                    listPatSearch.Add(clPat);
                    //if (Convert.ToDateTime(clPat.ConsDate) == DateTime.Now.Date)
                    //{ int text = 1; }
                }
            }
            string ClinicSpecLst = "";
            if (ds.Tables.Count > 0 && ds.Tables.Contains("Table1"))
            {
                ClinicSpecLst = JsonConvert.SerializeObject(ds.Tables["Table1"]);
            }
            //listPatSearch.Add(new PatientSearch { CONSNO = "12C190215JU0002", MRNO = "123", ConsDate = "16/02/2019", ConsTime = "10:16:54", PatName = "Mrs.Jigna  Upadhyay", DOB = "20/06/1981", Age = "035:10:02", Gender = "F", APPTTM = "", MobileNo = "8160422789", DIFFTM = "0", TRANNO = "", CompletedYN = "N", });
            //listPatSearch.Add(new PatientSearch { CONSNO = "12C190215JU0003", MRNO = "456", ConsDate = "16/02/2019", ConsTime = "11:10:00", PatName = "Mr.Sushil Shendge", DOB = "18/04/1991", Age = "035:10:02", Gender = "M", APPTTM = "", MobileNo = "8160422789", DIFFTM = "0", TRANNO = "", CompletedYN = "Y", });
            //listPatSearch.Add(new PatientSearch { CONSNO = "12C190215JU0004", MRNO = "789", ConsDate = "16/02/2019", ConsTime = "01:15:00", PatName = "Miss.Kavita", DOB = "24/05/1995", Age = "035:10:02", Gender = "F", APPTTM = "", MobileNo = "8160422789", DIFFTM = "0", TRANNO = "", CompletedYN = "N", });
            //listPatSearch.Add(new PatientSearch { CONSNO = "12C190215JU0005", MRNO = "987", ConsDate = "16/02/2019", ConsTime = "12:20:00", PatName = "Mrs.Aditya Thakkar", DOB = "02/07/1981", Age = "035:10:02", Gender = "F", APPTTM = "", MobileNo = "8160422789", DIFFTM = "0", TRANNO = "", CompletedYN = "Y", });
            //listPatSearch.Add(new PatientSearch { CONSNO = "12C190215JU0006", MRNO = "654", ConsDate = "16/02/2019", ConsTime = "02:16:00", PatName = "Mr.Jignesh", DOB = "10/01/1986", Age = "035:10:02", Gender = "M", APPTTM = "", MobileNo = "8160422789", DIFFTM = "-1", TRANNO = "", CompletedYN = "N", });
            //listPatSearch.Add(new PatientSearch { CONSNO = "12C190215JU0007", MRNO = "321", ConsDate = "16/02/2019", ConsTime = "03:20:00", PatName = "Mr.Kartik Kumar", DOB = "20/09/1971", Age = "035:10:02", Gender = "M", APPTTM = "", MobileNo = "8160422789", DIFFTM = "0", TRANNO = "", CompletedYN = "N", });

            dicResult.Add("Status", "Success");
            dicResult.Add("Result", listPatSearch);
            dicResult.Add("ClinicSpeciality", ClinicSpecLst);
            return dicResult;

        }


        //patient list for clinical notes
        public Dictionary<string, object> GetPatientListForClinicalNotes(string strClinicCode, string strDoctorCd, string dayType = "T", int CustomeDate = 0, string Type = "")
        {
            try
            {
                Dictionary<string, object> dicResult = new Dictionary<string, object>();
                OncologyEMRClient clOnco = new OncologyEMRClient();
                DataSet ds = new DataSet();
                List<PatientSearch> listPatSearch = new List<PatientSearch>();
                CommonServiceClient com = new CommonServiceClient();
                string strDate = com.GetServerDate();
                var doctList = clOnco.GetDoctLst("", "D");

                //strDate = "23/08/2021"; 
                //strDate = "18/03/2021";

                DateTime dt = DateTime.ParseExact(strDate, @"dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                if (dayType == "Y")
                {
                    dt = dt.Date.AddDays(-1);
                    strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                else if (dayType == "O") // Tommarow
                {
                    dt = dt.Date.AddDays(1);
                    strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                else if (dayType == "B") // Day Before Yesterday
                {
                    dt = dt.Date.AddDays(-2);
                    strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                else if (dayType == "D") // Day Before Yesterday
                {
                    dt = dt.Date.AddDays(-CustomeDate);
                    strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                else
                    strDate = GeneralFunction.GetDateInSpecifiedFormat(dt.ToString("dd/MM/yyyy"), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                if (Type == "PAC")
                {
                    ds.ReadXml(new StringReader(clOnco.GetPACPatientList(strDoctorCd, strDate, strClinicCode)));
                }
                else
                {
                    ds.ReadXml(new StringReader(clOnco.GetPatientDetails("", "", "", strDoctorCd, strDate, strDate, strClinicCode)));
                }

                if (ds.Tables.Count > 0 && ds.Tables.Contains("Table"))
                {
                    foreach (DataRow dr in ds.Tables["Table"].Rows)
                    {
                        PatientSearch clPat = new PatientSearch();
                        clPat.CONSNO = Convert.ToString(dr["CONSNO"]);
                        clPat.MRNO = Convert.ToString(dr["MRNO"]);
                        clPat.ConsDate = GeneralFunction.GetDate(Convert.ToString(dr["CONSDATE"]));
                        clPat.ConsTime = Convert.ToString(dr["CONSTIME"]);
                        clPat.PatName = Convert.ToString(dr["PATNAME"]).Trim();
                        clPat.DOB = GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"])); //GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"]));
                        clPat.Age = GeneralFunction.GetAge(clPat.DOB);// Convert.ToString(dr["PATAGE"]);
                        clPat.Gender = Convert.ToString(dr["PATSEX"]);
                        clPat.APPTTM = Convert.ToString(dr["APPTTIME"]).Replace(".", ":");
                        clPat.MobileNo = Convert.ToString(dr["PATPHONE"]).Trim();
                        clPat.OnlyPayStat = Convert.ToString(dr["ONLPAYSTAT"]);
                        clPat.PatEmail = Convert.ToString(dr["PATEMAIL"]).Trim();
                        clPat.DoctorName = ("" + dr["CONSDOCT"]).Trim() == "" ? "" : (doctList.Where(x => x.Value == ("" + dr["CONSDOCT"]).Trim()).Count() > 0 ? doctList.Where(x => x.Value == ("" + dr["CONSDOCT"]).Trim()).First().Text : "");

                        if (clPat.APPTTM != "")
                        {
                            TimeSpan diff2 = (DateTime.Now - new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, Convert.ToInt32(clPat.APPTTM.Split(':')[0]), Convert.ToInt32(clPat.APPTTM.Split(':')[1]), 0));
                            clPat.DIFFTM = diff2.TotalMinutes.ToString();
                        }
                        else { clPat.DIFFTM = "0"; }
                        //clPat.APPTTM = "<u>" + Convert.ToString(dr["PRIORITY"]).Trim() + "</u> " + clPat.APPTTM;
                        clPat.APPTTM = Type == "PAC" ? "<u>" + Convert.ToString(dr["PRIORITY"]).Trim() + "</u> " + clPat.APPTTM : clPat.APPTTM;//priyanka 14/11/2025
                        clPat.TRANNO = Convert.ToString(dr["TRANNO"]);
                        clPat.CompletedYN = Convert.ToString(dr["COMPLETEDYN"]);
                        clPat.OutRefDrName = Convert.ToString(dr["OREFDRNM"]).Trim();
                        clPat.OutRefDrContact = Convert.ToString(dr["OREFDRPHONNO"]).Trim() + " , " + Convert.ToString(dr["OREFDRMOBLNO"]).Trim();
                        clPat.CONTOKNO = Convert.ToString(dr["CONTOKNO"]).Trim();  //Added by Murali on 23/10/2024
                        clPat.ComCode = Type == "PAC" ? Convert.ToString(dr["CRDCOMPCD"]) : Convert.ToString(dr["COMPCODE"]);//added by priyanka on 08/10/2025
                        clPat.CompName = Type == "PAC" ? Convert.ToString(dr["COMPNAME"]) : Convert.ToString(dr["COMPNAME"]);//added by priyanka on 08/10/2025
                        clPat.VisitType = dr.Table.Columns.Contains("VISITTYPECD") && Convert.ToString(dr["VISITTYPECD"]).Trim() == "01" ? "NW" :
                                          dr.Table.Columns.Contains("VISITTYPECD") && Convert.ToString(dr["VISITTYPECD"]).Trim() == "02" ? "FU" : ""; //priyanka 05/03/2026                                                                                                
                        //clPat.VisitType = dr.Table.Columns.Contains("VISITTYPECD") ? Convert.ToString(dr["VISITTYPECD"]).Trim() : "";//priyanka 05/03/2026
                        clPat.ReviewRYN = dr.Table.Columns.Contains("REVIEWRPTYN") ? Convert.ToString(dr["REVIEWRPTYN"]).Trim() : "";
                        clPat.Appmntno = dr.Table.Columns.Contains("APPMNTNO") ? Convert.ToString(dr["APPMNTNO"]).Trim() : "";
                        clPat.PriorityType = dr.Table.Columns.Contains("PRIORITY") && (Convert.ToString(dr["PRIORITY"]).Trim().Contains("H") || Convert.ToString(dr["PRIORITY"]).Trim().Contains("I") || Convert.ToString(dr["PRIORITY"]).Trim().Contains("V")) ? ("-" + Convert.ToString(dr["PRIORITY"]).Trim()) : "";
                        clPat.ARRIVEDYN = Convert.ToString(dr["ARRIVEDYN"]);
                        clPat.ARRIVEDTM = Convert.ToString(dr["ARRIVEDTM"]);
                        clPat.POSTTOCONSYN = Convert.ToString(dr["POSTTOCONSYN"]);
                        clPat.POSTTOCONSTM = Convert.ToString(dr["POSTTOCONSTM"]);
                        listPatSearch.Add(clPat);
                    }

                }
                string ClinicSpecLst = "";
                if (ds.Tables.Count > 0 && ds.Tables.Contains("Table1"))
                {
                    ClinicSpecLst = JsonConvert.SerializeObject(ds.Tables["Table1"]);
                }
                dicResult.Add("Status", "Success");
                dicResult.Add("Result", listPatSearch);
                dicResult.Add("ClinicSpeciality", ClinicSpecLst);
                return dicResult;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public string PreFixZero(string dt)
        {
            if (dt.Length == 1)
                return "0" + dt;
            else
                return dt;
        }
        //public string SavePatientReg(BL_PatRegister clPatRegiseter)
        //{
        //    OncologyEMRClient client = new OncologyEMRClient();
        //    if (Convert.ToString(clPatRegiseter.MRNO) == null)
        //    {
        //        clPatRegiseter.TranMode = 1;
        //    }
        //    else
        //    {
        //        clPatRegiseter.TranMode = 2;
        //    }
        //    clPatRegiseter.DOB = GeneralFunction.GetDateInSpecifiedFormat(clPatRegiseter.DOB, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
        //    return client.SavePatRegTran(clPatRegiseter);
        //}


    }

    public class GenericUsrCntrlMdl
    {
        public string Code { get; set; }
        public string Text { get; set; }

        public object GetGENERICLIST(string name)
        {
            object jsonData = string.Empty;
            //CommonServiceClient comserv = new CommonServiceClient();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetDrugList(name)))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];
            if (l_oDT.Rows.Count > 0)
            {
                jsonData = new
                {
                    rows = (from DataRow row in l_oDT.Rows
                            select new
                            {
                                GENERICCODE = ("" + row["GENERICID"]).Trim(),
                                GENERICNAME = ("" + row["GENERICNAM"]).Trim(),
                                DRUGCODE = ("" + row["MTRLCODE"]).Trim(),
                                DRUGNAME = ("" + row["MTRLNAME"]).Trim(),
                            }).ToArray()
                };
            }
            return jsonData;
        }
    }

    #region Cost Estimation
    public class CSTMNDATA
    {
        public string id { set; get; }
        public string COMPONENT { set; get; }
        public string QTYDAYS { set; get; }
    }
    public class COSTESTIMATIONMDL
    {
        OncologyEMRClient OncoCli = new OncologyEMRClient();
        CommonServiceClient com = new CommonServiceClient();
        string space = "                                                                                          ";

        public string STRESTIMATIONNO { get; set; }
        public string STRESTIMATIONDATE { get; set; }
        public string STRESTIMATIONTIME { get; set; }
        public string STRMRNO { get; set; }
        public string STRPATNAME { get; set; }

        public string STRASSOSURGECODE { get; set; }
        public string STRSURGECODE { get; set; }
        public string STRGIPSACODE { get; set; }

        public string STRSURGEDOCTCODE { get; set; }
        public string STRDOCTCODE { get; set; }
        public IEnumerable<OncologyEMR.Oncology.DoctorSelLstItem> DOCTORLIST { set; get; }
        public string STRCOMPCODE { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.CompanySelLstItem> COMPONYLIST { set; get; }
        public IEnumerable<Oncology.SurgListItem> SURGERYLIST { set; get; }
        public string STRBEDLIST { get; set; }
        public string STRESTIMATIONLIST { get; set; }
        public string STRBEDCATLIST { get; set; }
        public string STRREMARKS { get; set; }
        public string STRVIEWSTATE { get; set; }
        public string STRGETTYPE { get; set; }
        public object STRGESSETDATA { get; set; }
        public object STRGESSETCOMPDATA { get; set; }

        public void FILLCOMBOS(COSTESTIMATIONMDL COSTESTMDL, string ActionMode = "N")
        {

            if (ActionMode == "N" || ActionMode == "E" || ActionMode == "D")
            {

                COSTESTMDL.DOCTORLIST = OncoCli.GetDoctLst("", "D").Where(x => (x.Status == "A"));
                COSTESTMDL.COMPONYLIST = com.GetCrdCompLst("").Where(x => x.Status == "A");
                COSTESTMDL.SURGERYLIST = OncoCli.GetSurgeryList().Where(x => x.Status == "A");
            }
            else
            {
                COSTESTMDL.DOCTORLIST = OncoCli.GetDoctLst("", "D");
                COSTESTMDL.COMPONYLIST = com.GetCrdCompLst("");
                COSTESTMDL.SURGERYLIST = OncoCli.GetSurgeryList();

            }


        }

        public object SaveCostEstimate(COSTESTIMATIONMDL COSTESTMDL, string MRNO, string PATNAME, string DOCTCODE, string ACTIONMODE, string CTYPE, string UserID, string MchIPAddress, string ModuleIDGlobal, string FunSource, string HospUnit, string CNTRCODE, string TRANNO)
        {
            BL_SurgCostEstimation SRTGCOSTEST = new BL_SurgCostEstimation();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jss.MaxJsonLength = int.MaxValue;
            DataSet SVDATASET = new DataSet("LIST");
            DataTable SVMULDATASET = new DataTable("COMPLIST");
            SVMULDATASET.Columns.Add("BEDCATGCD");
            SVMULDATASET.Columns.Add("COMPCODE");
            SVMULDATASET.Columns.Add("QTY");
            SVMULDATASET.Columns.Add("CHARGES");
            DataTable PackData = new DataTable();
            PackData = JsonConvert.DeserializeObject<DataTable>(COSTESTMDL.STRESTIMATIONLIST);
            DataTable BedData = new DataTable();
            BedData = JsonConvert.DeserializeObject<DataTable>(COSTESTMDL.STRBEDCATLIST);
            for (int l = 0; l < BedData.Rows.Count; l++)
            {

                for (int m = 1; m < 11; m++)
                {
                    DataRow Dr = SVMULDATASET.NewRow();
                    Dr["COMPCODE"] = m < 10 ? "0" + m.ToString() : m.ToString();
                    Dr["BEDCATGCD"] = BedData.Rows[l]["BEDCATGCD"].ToString();
                    SVMULDATASET.Rows.Add(Dr);
                }


            }


            for (int s = 0; s < SVMULDATASET.Rows.Count; s++)
            {
                DataRow dr = SVMULDATASET.Rows[s];
                //"B" + dr["BEDCATGCD"]
                dr["CHARGES"] = PackData.Select("id='" + dr["COMPCODE"] + "'")[0]["B" + dr["BEDCATGCD"]];
                if (dr["COMPCODE"].ToString().Trim() == "03" || dr["COMPCODE"].ToString().Trim() == "04" || dr["COMPCODE"].ToString().Trim() == "05" || dr["COMPCODE"].ToString().Trim() == "06")
                {
                    dr["QTY"] = PackData.Select("id='" + dr["COMPCODE"] + "'")[0]["QTYDAYS"];
                }

            }
            SVDATASET.Tables.Add(SVMULDATASET);
            SRTGCOSTEST.AssSurgCode = string.IsNullOrEmpty(COSTESTMDL.STRASSOSURGECODE) ? "" : COSTESTMDL.STRASSOSURGECODE.Substring(COSTESTMDL.STRASSOSURGECODE.Length - 12, 12).Trim();//
            SRTGCOSTEST.DoctCode = COSTESTMDL.STRDOCTCODE;
            SRTGCOSTEST.FundSource = FunSource;
            SRTGCOSTEST.IpAddress = MchIPAddress;
            SRTGCOSTEST.IpNo = ""; // NA
            SRTGCOSTEST.CmpType = CTYPE;
            SRTGCOSTEST.CmpCode = "" + COSTESTMDL.STRCOMPCODE;
            SRTGCOSTEST.ModuleID = ModuleIDGlobal;
            SRTGCOSTEST.MRNo = MRNO;
            SRTGCOSTEST.PatName = PATNAME;
            SRTGCOSTEST.Remarks = COSTESTMDL.STRREMARKS;//NA
            SRTGCOSTEST.SurgeonCode = DOCTCODE;
            SRTGCOSTEST.SurgeryCode = COSTESTMDL.STRSURGECODE.Substring(COSTESTMDL.STRSURGECODE.Length - 12, 12).Trim(); ;

            if (ACTIONMODE == "E")
            {
                SRTGCOSTEST.Tranmode = 2;
            }
            else if (ACTIONMODE == "C")
            {
                SRTGCOSTEST.Tranmode = 3;
            }
            else
                SRTGCOSTEST.Tranmode = 1;

            SRTGCOSTEST.TranNo = TRANNO;
            SRTGCOSTEST.UserID = UserID;
            SRTGCOSTEST.xmlCompList = SVDATASET.GetXml();
            object Status = OncoCli.SurgCostEstimationTran(SRTGCOSTEST);
            return Status;

        }

        public void GETCOSTESTIDET(COSTESTIMATIONMDL COSTESTMDL, string TRANNO)
        {
            DataSet dsDET = new DataSet();
            //       dsDET.ReadXml(new XmlTextReader(new StringReader(OncoCli.GetSurgCostEstiDetail(TRANNO))));

            var arrlst = (from DataRow row in dsDET.Tables[0].Rows
                          select new
                          {
                              TRANNO = row["TRANNO"].ToString().Trim(),
                              BEDCATGCD = row["BEDCATGCD"].ToString().Trim(),
                              COMPCODE = row["COMPCODE"].ToString().Trim(),
                              QTY = row["QTY"].ToString().Trim(),
                              CHARGES = row["CHARGES"].ToString().Trim()
                          }).ToArray();


            COSTESTMDL.STRGESSETDATA = arrlst;
            DataView view = new DataView(dsDET.Tables[0]);
            DataTable distinctValues = view.ToTable(true, "COMPCODE", "QTY");

            List<CSTMNDATA> COMPOLIST = new List<CSTMNDATA>();

            COMPOLIST.Add(new CSTMNDATA { id = "01", COMPONENT = "PROCEDURE CHARGES", QTYDAYS = "" });
            COMPOLIST.Add(new CSTMNDATA { id = "02", COMPONENT = "ASSOC SURG CHARGES", QTYDAYS = "" });
            COMPOLIST.Add(new CSTMNDATA { id = "03", COMPONENT = "BED CHARGES WARD", QTYDAYS = distinctValues.Select("COMPCODE=03")[0]["QTY"].ToString().Trim() });
            COMPOLIST.Add(new CSTMNDATA { id = "04", COMPONENT = "BED CHARGES ICU", QTYDAYS = distinctValues.Select("COMPCODE=04")[0]["QTY"].ToString().Trim() });
            COMPOLIST.Add(new CSTMNDATA { id = "05", COMPONENT = "DR. VISIT CHARGES WARD", QTYDAYS = distinctValues.Select("COMPCODE=05")[0]["QTY"].ToString().Trim() });
            COMPOLIST.Add(new CSTMNDATA { id = "06", COMPONENT = "DR. VISIT CHARGES ICU", QTYDAYS = distinctValues.Select("COMPCODE=06")[0]["QTY"].ToString().Trim() });
            COMPOLIST.Add(new CSTMNDATA { id = "07", COMPONENT = "INVESTIGATION", QTYDAYS = "" });
            COMPOLIST.Add(new CSTMNDATA { id = "08", COMPONENT = "MEDICINE & CONSUMABLES", QTYDAYS = "" });
            COMPOLIST.Add(new CSTMNDATA { id = "09", COMPONENT = "BLOOD BANK CHARGES", QTYDAYS = "" });
            COMPOLIST.Add(new CSTMNDATA { id = "10", COMPONENT = "OTHER", QTYDAYS = "" });

            COSTESTMDL.STRGESSETCOMPDATA = COMPOLIST;

            DataTable DTDET = dsDET.Tables[1];
            COSTESTMDL.STRASSOSURGECODE = DTDET.Rows[0]["ASSSURGERY"].ToString().Trim();
            COSTESTMDL.STRCOMPCODE = DTDET.Rows[0]["CMPCODE"].ToString().Trim();
            COSTESTMDL.STRDOCTCODE = DTDET.Rows[0]["DOCTCODE"].ToString().Trim();
            COSTESTMDL.STRESTIMATIONDATE = GeneralFunction.GetDate(DTDET.Rows[0]["CREATEDON"].ToString().Trim());
            COSTESTMDL.STRESTIMATIONNO = DTDET.Rows[0]["TRANNO"].ToString().Trim();
            COSTESTMDL.STRESTIMATIONTIME = DTDET.Rows[0]["CREATEDAT"].ToString().Trim();
            if (DTDET.Columns.Contains("GIPSANAME"))
                COSTESTMDL.STRGIPSACODE = DTDET.Rows[0]["GIPSANAME"].ToString().Trim();
            else
                COSTESTMDL.STRGIPSACODE = "";
            COSTESTMDL.STRMRNO = DTDET.Rows[0]["MRNO"].ToString().Trim();
            COSTESTMDL.STRPATNAME = DTDET.Rows[0]["PATNAME"].ToString().Trim();
            COSTESTMDL.STRREMARKS = DTDET.Rows[0]["REMARKS"].ToString().Trim();
            COSTESTMDL.STRSURGECODE = DTDET.Rows[0]["SURGERY"].ToString().Trim();
            COSTESTMDL.STRSURGEDOCTCODE = DTDET.Rows[0]["SURGEONCD"].ToString().Trim();
            COSTESTMDL.STRGETTYPE = DTDET.Rows[0]["CMPTYPE"].ToString().Trim();

        }

        //public object BindCostExtimationList(string DTFRM, string DTTO, string SMRNO, string SSTATUS)
        //{
        //    DataSet dsBillingList = new DataSet();
        //    dsBillingList.ReadXml(new XmlTextReader(new StringReader(OncoCli.GetSurgCostEstiList(SMRNO, GeneralFunction.GetDateInSpecifiedFormat(DTFRM, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD), GeneralFunction.GetDateInSpecifiedFormat(DTTO, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD), SSTATUS))));
        //    dsBillingList.GetXml();
        //    var DOCTLIST = OncoCli.GetDoctLst();
        //    var servList = OncoCli.GetServiceList();//
        //    JavaScriptSerializer ser = new JavaScriptSerializer();
        //    if (dsBillingList.Tables.Count > 0)
        //    {
        //        var jsonData = (from DataRow row in dsBillingList.Tables[0].Rows
        //                        select new
        //                        {
        //                            id = row["TRANNO"].ToString().Trim(),
        //                            TRANNO = row["TRANNO"].ToString().Trim(),
        //                            ESTDATETIME = GeneralFunction.GetDate(row["CREATEDON"].ToString().Trim()) + "  " + row["CREATEDAT"].ToString().Trim(),
        //                            IPNO = row["IPNO"].ToString().Trim().Count() == 0 ? "" : row["IPNO"].ToString().Trim().Trim(),
        //                            MRNO = row["MRNO"].ToString().Trim(),
        //                            PATNAME = row["PATNAME"].ToString().Trim(),
        //                            DOCTCODE = row["DOCTCODE"].ToString().Trim(),
        //                            DOCTNAME = DOCTLIST.Where(x => x.Value == ("" + row["DOCTCODE"]).Trim()).Count() == 0 ? "" : DOCTLIST.Where(x => x.Value == ("" + row["DOCTCODE"]).ToString().Trim()).First().Text,
        //                            //DOCTLIST.Where(x => x.Value == ("" + row["SURGEONCD"]).Trim()).Count() == 0 ? "" : DOCTLIST.Where(x => x.Value == ("" + row["SURGEONCD"]).ToString().Trim()).First().Text,
        //                            SURGEONCD = row["SURGEONCD"].ToString().Trim(),
        //                            SURGENAME = DOCTLIST.Where(x => x.Value == ("" + row["SURGEONCD"]).Trim()).Count() == 0 ? "" : DOCTLIST.Where(x => x.Value == ("" + row["SURGEONCD"]).ToString().Trim()).First().Text,
        //                            SURGERYNAME = row["SURGERYNAME"].ToString().Trim(), //
        //                            ASSOCSURGERYNAME = row["ASSOSURGCD"].ToString().Trim() == "" ? "" : servList.Where(x => x.Value == row["ASSOSURGCD"].ToString().Trim()).First().Text, //
        //                            STATUS = row["STATUS"].ToString().Trim() == "A" ? "Active" : "Cancelled",
        //                        }).ToList();
        //        return jsonData;
        //    }
        //    else
        //    {
        //        return ser.Serialize("");
        //    }

        //}

        public DataSet PrintCostEstimationListData(string searchCriteria, string FilterCriteria, string FROMDATE, string TODATE, DataTable df)
        {
            df.Columns.Remove("act");
            DataSet AllData = new DataSet();
            DataTable HData = new DataTable();
            DataTable FilterCriteriadt = new DataTable();
            FilterCriteriadt = GeneralFunction.GetSearchFilterData(searchCriteria, FilterCriteria, df.Rows.Count);
            FilterCriteriadt.TableName = "FilterTable";
            var formlist = "Cost Estimation List";
            HData = GeneralFunction.getHeaderFooter(formlist, FROMDATE, TODATE);
            HData.TableName = "HeaderFooter";
            AllData.Tables.Add(df);
            AllData.Tables.Add(HData);
            AllData.Tables.Add(FilterCriteriadt);
            return AllData;
        }

        public string PrintExcelCostEstimationListData(string searchCriteria, string FilterCriteria, string FROMDATE, string TODATE, DataTable df)
        {
            df.Columns.Remove("_id_");
            df.Columns["TRANNO"].ColumnName = "Transaction No.";
            df.Columns["ESTDATETIME"].ColumnName = "Estimate Date/Time";
            df.Columns["IPNO"].ColumnName = "IPNo.";
            df.Columns["MRNO"].ColumnName = "MRNo";
            df.Columns["PATNAME"].ColumnName = "Patient Name";
            df.Columns["DOCTNAME"].ColumnName = "Doctor Name";
            df.Columns["SURGENAME"].ColumnName = "Surgeon Name";
            df.Columns["ASSOCSURGERYNAME"].ColumnName = "Associate Surgery Name";
            df.Columns["STATUS"].ColumnName = "Status";
            System.IO.StringWriter sw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
            GridView gv = new GridView();
            gv.ShowFooter = true;
            gv.BorderWidth = 0;
            gv.DataSource = df;
            gv.DataBind();
            var footer = gv.FooterRow;
            gv.FooterRow.Visible = true;
            gv.RenderControl(htw);

            StringBuilder sSchema = new StringBuilder();
            string AllData = GeneralFunction.getHeaderFooterExcel("Cost Estimation List", FROMDATE, TODATE) + sw.ToString();
            sSchema.Append("<html xmlns:x=urn:schemas-microsoft-com:office:excel> <head><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head> <body>");
            sSchema.Append(AllData + "</body></html>");

            return sSchema.ToString();
        }

    }

    public class LISTDATA
    {
        public string id { set; get; }
        public string Text { set; get; }
        public string COMPONENT { set; get; }
        public string DESC { set; get; }
        public string QTYDAYS { set; get; }
        public string MIN { set; get; }
        public string MAX { set; get; }
        public string Value { set; get; }
        public string SERVDEPT { set; get; }
        public string SERVGRPCD { set; get; }
        public string SERVSUBGRPCD { set; get; }
        public string SERVTYPE { set; get; }
    }
    #endregion

    //added on 28th June 2018
    public class AllergyModel : BL_Allergy
    {
        public AllergyModel()
        {
            SymptomsMonths = new[]
        {
            new BaseClassViewModel { Name = "Jan" },
            new BaseClassViewModel { Name = "Feb" },
            new BaseClassViewModel { Name = "March" },
            new BaseClassViewModel { Name = "April" },
            new BaseClassViewModel { Name = "May" },
            new BaseClassViewModel { Name = "Jun" },
            new BaseClassViewModel { Name = "Jul" },
            new BaseClassViewModel { Name = "Aug" },
            new BaseClassViewModel { Name = "Sep" },
            new BaseClassViewModel { Name = "Oct" },
            new BaseClassViewModel { Name = "Nov" },
            new BaseClassViewModel { Name = "Dec" },

        }.ToList();

            RespiratorySymptoms = new[]
        {
            new BaseClassViewModel { Name = "Nasal Itching" },
            new BaseClassViewModel { Name = "Runny Nose" },
            new BaseClassViewModel { Name = "Blocked Nose" },
            new BaseClassViewModel { Name = "Sneezing" },
            new BaseClassViewModel { Name = "Chronic Cough" },
            new BaseClassViewModel { Name = "Shortness of Breath" },
            new BaseClassViewModel { Name = "Chest Tightness" },
        }.ToList();

            EyesSymptoms = new[]
        {
            new BaseClassViewModel { Name = "Itching" },
            new BaseClassViewModel { Name = "Watery" },
            new BaseClassViewModel { Name = "Redness" },
            new BaseClassViewModel { Name = "Swelling" },
            new BaseClassViewModel { Name = "Dark Circles" },
        }.ToList();

            SkinSymptoms = new[]
        {
            new BaseClassViewModel { Name = "Itching" },
            new BaseClassViewModel { Name = "Redness" },
            new BaseClassViewModel { Name = "Swelling" },
            new BaseClassViewModel { Name = "Skin rash or eczema" },
        }.ToList();

            GastroIntestinalSymptoms = new[]
        {
            new BaseClassViewModel { Name = "Abdominal Pain" },
            new BaseClassViewModel { Name = "Nausea or Vomitting" },
            new BaseClassViewModel { Name = "Diarrohea" },
            new BaseClassViewModel { Name = "Belching or gas formation" },
            new BaseClassViewModel { Name = "Indigestion" },
        }.ToList();

            WorseInLocations = new[]
        {
            new BaseClassViewModel { Name = "Indoors" },
            new BaseClassViewModel { Name = "OutDoors" },
            new BaseClassViewModel { Name = "At Home" },
            new BaseClassViewModel { Name = "At Work" },
            new BaseClassViewModel { Name = "At School" },
            new BaseClassViewModel { Name = "Others" },
        }.ToList();

            WorseAtTime = new[]
        {
            new BaseClassViewModel { Name = "Morning" },
            new BaseClassViewModel { Name = "Afternoon" },
            new BaseClassViewModel { Name = "Evening" },
            new BaseClassViewModel { Name = "Night" },
            new BaseClassViewModel { Name = "All Day long" },
        }.ToList();

            WorsenedByTriggers = new[]
        {
            new BaseClassViewModel { Name = "Walking In Garden" },
            new BaseClassViewModel { Name = "Sleeping or lying on bed" },
            new BaseClassViewModel { Name = "Damp Areas" },
            new BaseClassViewModel { Name = "Exposure to animals/pets" },
            new BaseClassViewModel { Name = "Dust or Dusty Atmosphere" },
            new BaseClassViewModel { Name = "Smog or pollution Exposure" },
            new BaseClassViewModel { Name = "After eating particular food items" },
            new BaseClassViewModel { Name = "Physical Exertion or Exercise" },
            new BaseClassViewModel { Name = "Soaps,Detergents or Cosmetics" },
            new BaseClassViewModel { Name = "Any Other" },
        }.ToList();
        }

        public bool CheckBoxParentAsthmaYN { get; set; }

        public bool CheckBoxSiblingAsthmaYN { get; set; }

        public bool CheckBoxChildrenAsthmaYN { get; set; }

        public bool CheckBoxParentAllergicRhinitisYN { get; set; }

        public bool CheckBoxSiblingAllergicRhinitisYN { get; set; }

        public bool CheckBoxChildrenAllergicRhinitisYN { get; set; }

        public bool CheckBoxParentSkinAllergyYN { get; set; }

        public bool CheckBoxSiblingSkinAllergyYN { get; set; }

        public bool CheckBoxChildrenSkinAllergyYN { get; set; }

        public bool CheckBoxParentFoodAllergyYN { get; set; }

        public bool CheckBoxSiblingFoodAllergyYN { get; set; }

        public bool CheckBoxChildenFoodAllergyYN { get; set; }

        public bool CheckBoxH1AntiOral { get; set; }

        public bool CheckBoxH1AntiNasal { get; set; }

        public bool CheckBoxH1AntiOpthaimic { get; set; }

        public bool CheckBoxAllergicRhinitisOral { get; set; }

        public bool CheckBoxAllergicRhinitisNasal { get; set; }

        public bool CheckBoxAllergicRhinitisInhaled { get; set; }

        public bool CheckBoxAllergicRhinitisTopical { get; set; }

        public IList<BaseClassViewModel> SymptomsMonths { get; set; }
        public IList<BaseClassViewModel> RespiratorySymptoms { get; set; }
        public IList<BaseClassViewModel> EyesSymptoms { get; set; }
        public IList<BaseClassViewModel> SkinSymptoms { get; set; }
        public IList<BaseClassViewModel> GastroIntestinalSymptoms { get; set; }
        public IList<BaseClassViewModel> WorseInLocations { get; set; }
        public IList<BaseClassViewModel> WorseAtTime { get; set; }
        public IList<BaseClassViewModel> WorsenedByTriggers { get; set; }
    }

    //added on 28th June 2018
    public class BaseClassViewModel
    {
        public string Name { get; set; }
        public bool Checked { get; set; }
    }

    #region Signatory
    public class SignatoryMdl
    {

        public string TextArea1 { get; set; }
        public string TextArea2 { get; set; }
        public string TextArea3 { get; set; }

        public string Signatory1 { get; set; }
        public string Signatory2 { get; set; }
        public string Signatory3 { get; set; }

        public string SaveSignatory(SignatoryMdl rnc)
        {

            BL_Signatory blsign = new BL_Signatory();
            OncologyEMRClient oncgClnt = new OncologyEMRClient();
            Byte[] array = new Byte[0];
            if (rnc.Signatory1 != null)
            {
                blsign.DigiSignImg1 = System.Convert.FromBase64String(rnc.Signatory1);

            }
            else
            {
                blsign.DigiSignImg1 = array;
            }
            if (rnc.Signatory2 != null)
            {
                blsign.DigiSignImg2 = System.Convert.FromBase64String(rnc.Signatory2);

            }
            else
            {
                blsign.DigiSignImg2 = array;
            }
            if (rnc.Signatory3 != null)
            {
                blsign.DigiSignImg3 = System.Convert.FromBase64String(rnc.Signatory3);

            }
            else
            {
                blsign.DigiSignImg3 = array;
            }
            blsign.Signatory1 = ("" + rnc.TextArea1);
            blsign.Signatory2 = ("" + rnc.TextArea2);
            blsign.Signatory3 = ("" + rnc.TextArea3);
            blsign.DoctCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();

            return oncgClnt.SaveSignatory(blsign);
        }

        public string GetDoctSignature(string doctcode)
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            ser.MaxJsonLength = int.MaxValue;
            OncologyEMRClient oncgClnt = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable dtEmpty = new DataTable();

            load.ReadXml(new XmlTextReader(new StringReader(oncgClnt.GetSignatoryData(doctcode))));
            if (load.Tables.Count > 0)
            {
                var jsonData = (from DataRow row in load.Tables[0].Rows
                                select new
                                {
                                    DOCTCODE = row["DOCTCODE"].ToString().Trim(),
                                    SIGN = row["SIGN"].ToString().Trim(),
                                    SIGN2 = row["SIGN2"].ToString().Trim(),
                                    SIGN3 = row["SIGN3"].ToString().Trim(),
                                    DIGSIGN1 = row["DIGSIGN1"].ToString().Trim(),
                                    DIGSIGN2 = row["DIGSIGN2"].ToString().Trim(),
                                    DIGSIGN3 = row["DIGSIGN3"].ToString().Trim(),

                                }).ToList();
                return ser.Serialize(jsonData);
            }
            return ser.Serialize("");
        }
    }



    #endregion Signatory

    #region "Add Patient"
    public class Patient : BL_Consultation
    {

        public object[] getConsultAmt(string ConDoctor, string ConClinic, string Tariff, string MRNO, string VISITTYPE,
            string CASETYPE, bool ISCOMPANYPAT, string COMPANY, string ExemptionCatg, string strPatCatgCD, string FreeYN)
        {
            object[] doctchrgdata = new object[15];//new code 3/1/2018
            string Status = "";
            string conservcode = string.Empty;
            string BEDCATS = string.Empty;
            new CommonServiceClient().UsingSafe(comser =>
            {
                BEDCATS = comser.GetSetupValue("BEDCATG");
                conservcode = comser.GetSetupValue("OPCONSULTSERV");
            });
            string SERVCODE = "";
            double CONSFEE = 0;
            double HOSPSHARE = 0;
            double DOCTSHAREPER = 0;
            double DOCTSHARE = 0;
            double SERCHRGAMT = 0;
            double SERVTAX = 0;
            double EMERAMT = 0;
            string SRVGRPCODE = "";
            string SUBGRPCODE = "";
            string SRVTYPCODE = "";
            string SERVDEPT = "";
            string ALLOWFREE = "";

            double dblDiscPer = 0.00;

            if (("" + ExemptionCatg).ToString().Trim() != "")
                ExemptionCatg = ExemptionCatg.Substring(ExemptionCatg.LastIndexOf(" ") + 1, 3);
            if (strPatCatgCD.ToString().Trim() != "")
                strPatCatgCD = strPatCatgCD.Substring(strPatCatgCD.LastIndexOf(" ") + 1, 3);
            if (COMPANY.ToString().Trim() != "")
                COMPANY = COMPANY.Substring(COMPANY.Trim().LastIndexOf(" ") + 1).Trim();

            if (FreeYN == "Y")
            {
                dblDiscPer = 100;
            }
            else
            {
                new CommonServiceClient().UsingSafe(comser =>
                {
                    dblDiscPer = comser.GetServDiscPer(conservcode, Tariff.Substring(Tariff.Length - 3, 3).Trim(), "", ExemptionCatg, COMPANY, "OP", strPatCatgCD, "");
                });
            }
            //end
            var doctchrgstr = string.Empty;
            new OutpatientClient().UsingSafe(op =>
            {
                doctchrgstr = op.GetOPDocConsFee(ConDoctor, Tariff.Substring(Tariff.Length - 3, 3).Trim(), VISITTYPE, ConClinic);// dbo.FillDataTable("SELECT * FROM DOCCONCHRG WHERE DOCTCODE ='" + ConDoctor + "' AND TRIFFID='" + Tariff.Substring(Tariff.Length - 3, 3).Trim() + "' AND CLINICCD='" + ConClinic + "' AND BEDCATGCD='" + BEDCATS + "' ");
            });
            StringReader theReader = new StringReader(doctchrgstr);
            DataSet doctchrg = new DataSet();
            doctchrg.ReadXml(theReader);
            if (doctchrg.Tables.Count > 0)
            {
                new CommonServiceClient().UsingSafe(comser =>
                {
                    if (doctchrg.Tables[0].Rows.Count > 0)
                    {
                        Status = "DOCTOR HAVE CHARGE";
                        var surchrgamt = comser.GetSetupValue("SURCHARGE");
                        var servamt = comser.GetSetupValue("SERVTAX");
                        SERVCODE = doctchrg.Tables[0].Rows[0]["SERVCODE"].ToString();
                        SRVGRPCODE = doctchrg.Tables[0].Rows[0]["SRVGRPCODE"].ToString();
                        SUBGRPCODE = doctchrg.Tables[0].Rows[0]["SRVSUBGRP"].ToString();
                        SRVTYPCODE = doctchrg.Tables[0].Rows[0]["SERVTYPECD"].ToString();
                        SERVDEPT = doctchrg.Tables[0].Rows[0]["DEPTCODE"].ToString();
                        if (CASETYPE == "02")
                        {
                            var emrper = comser.GetSetupValue("EMERGENCY");
                            CONSFEE = (Convert.ToDouble("0" + doctchrg.Tables[0].Rows[0]["COST"]));
                            DOCTSHAREPER = Convert.ToDouble(doctchrg.Tables[0].Rows[0]["DRSHRPER"]);
                            EMERAMT = (Convert.ToDouble(emrper));
                        }
                        else
                        {
                            CONSFEE = Convert.ToDouble(doctchrg.Tables[0].Rows[0]["COST"]);
                            DOCTSHAREPER = Convert.ToDouble(doctchrg.Tables[0].Rows[0]["DRSHRPER"]);
                        }
                        SERCHRGAMT = (Convert.ToDouble(surchrgamt));
                        SERVTAX = (Convert.ToDouble(servamt));
                        ALLOWFREE = doctchrg.Tables[0].Rows[0]["ALLOWFREE"].ToString(); //Meenakshi Need to set Y to allow free of cost new or followup consultaion in Doctor table
                    }
                });
            }
            else
                Status = "DOCTOR DONT HAVE CHARGE";

            doctchrgdata[0] = Status;
            doctchrgdata[1] = CONSFEE;
            doctchrgdata[2] = DOCTSHARE;
            doctchrgdata[3] = HOSPSHARE;
            doctchrgdata[4] = DOCTSHAREPER;
            doctchrgdata[5] = SERCHRGAMT;
            doctchrgdata[6] = SERVTAX;
            doctchrgdata[7] = EMERAMT;
            doctchrgdata[8] = SERVCODE;
            doctchrgdata[9] = SRVGRPCODE;
            doctchrgdata[10] = SUBGRPCODE;
            doctchrgdata[11] = SRVTYPCODE;
            doctchrgdata[12] = SERVDEPT;
            doctchrgdata[13] = dblDiscPer; //new code 3/1/201
            doctchrgdata[14] = ALLOWFREE;

            return doctchrgdata;
        }


        public DataSet SETVISITTYPE(string MRNOS, string DOCTCODE, string CLINICCODE, string TARIFF, bool ISCOMPANYPAT, string COMPANY, string PayOnlineYN = "N")
        {
            string MAXCONSL = string.Empty;
            object VISITTYPE = "01";
            var jsondata = "";
            new OutpatientClient().UsingSafe(op =>
            {
                MAXCONSL = op.GetOPConsultVisitType(MRNOS, DOCTCODE, CLINICCODE, TARIFF.Substring(TARIFF.Trim().LastIndexOf(" ")).Trim());
            });
            StringReader theReader = new StringReader(MAXCONSL);
            DataSet dsvisitype = new DataSet();
            dsvisitype.ReadXml(theReader);
            return dsvisitype;
        }

        public object saveconsultdata(UserControlModel UCModel, string strCounter, string strIpAddres, string strFundSource,
          string ModuleID, string TMode, string TRANNO, string STREMPID = "", string strClinicCD = "", string strTraigeYN = "")
        {

            CommonServiceClient comm = new CommonServiceClient();
            DataTable PAYMODEDATA = new DataTable();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jss.MaxJsonLength = int.MaxValue;
            PAYMODEDATA.Columns.Add("PAYMODE");
            PAYMODEDATA.Columns.Add("AMOUNT");
            PAYMODEDATA.Columns.Add("CHEQUEDDNO");
            PAYMODEDATA.Columns.Add("BANKNAME");
            PAYMODEDATA.Columns.Add("CHEQUEDATE");
            PAYMODEDATA.Columns.Add("DOCTCODE");

            DataTable DepositInfo = new DataTable();
            DataTable DepositFullData = new DataTable();
            DepositInfo.Columns.Add("APPLIEDBILLAMT");
            DepositInfo.Columns.Add("RCPTNO");
            DepositInfo.Columns.Add("DEPOSITAMT");
            DepositInfo.Columns.Add("DOCTCODE");

            DepositFullData.Columns.Add("APPLIEDBILLAMT");
            DepositFullData.Columns.Add("RCPTNO");

            DataTable dtConsultData = new DataTable();
            JavaScriptSerializer jss1 = new JavaScriptSerializer();
            jss1.MaxJsonLength = int.MaxValue;
            DataTable CONSULTDATA = new DataTable();
            CONSULTDATA.Columns.Add("DOCTCODE");
            CONSULTDATA.Columns.Add("CLNCODE");
            CONSULTDATA.Columns.Add("DEPTCODE");
            CONSULTDATA.Columns.Add("CONSFEE");
            CONSULTDATA.Columns.Add("REGFEE");
            CONSULTDATA.Columns.Add("DISCOUNT");
            CONSULTDATA.Columns.Add("TOTSURCAMT");
            CONSULTDATA.Columns.Add("TOTEMERGAMT");
            CONSULTDATA.Columns.Add("NETAMOUNT");
            CONSULTDATA.Columns.Add("PATBILLAMT");
            CONSULTDATA.Columns.Add("COMBILLAMT");
            CONSULTDATA.Columns.Add("PATAMTPAID");
            CONSULTDATA.Columns.Add("COMAMTPAID");
            CONSULTDATA.Columns.Add("ADVADJAMT");
            CONSULTDATA.Columns.Add("AMOUNTPAID");
            CONSULTDATA.Columns.Add("SERVICETAX");
            CONSULTDATA.Columns.Add("HOSPSHARE");
            CONSULTDATA.Columns.Add("DOCTSHARE");
            CONSULTDATA.Columns.Add("SERVCODE");
            CONSULTDATA.Columns.Add("SRVGRPCODE");
            CONSULTDATA.Columns.Add("SUBGRPCODE");
            CONSULTDATA.Columns.Add("SRVTYPCODE");
            CONSULTDATA.Columns.Add("SERVDEPT");
            CONSULTDATA.Columns.Add("DISCAUTHBY");
            CONSULTDATA.Columns.Add("VISITTYPECD");
            CONSULTDATA.Columns.Add("FILECHARGE");
            CONSULTDATA.Columns.Add("REGDISCAMT");
            CONSULTDATA.Columns.Add("FILECHRGEDISCAMT");

            CommonSerRef.CommonServiceClient com = new CommonSerRef.CommonServiceClient();
            var patcatg = com.GetSetupValue("CREDITCOMPCATG");
            DataRow row = CONSULTDATA.NewRow();

            //Added below condition by Murali on 22/05/2024
            if (strTraigeYN == "Y" || (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString() == "")
            {
                row["DOCTCODE"] = GeneralFunction.GetAppsettingUnitWiseValue("AssignDoctor").ToString().Trim().Split('|')[0].ToString();
                row["CLNCODE"] = GeneralFunction.GetAppsettingUnitWiseValue("AssignDoctor").ToString().Trim().Split('|')[1].ToString();
            }
            else
            {
                row["DOCTCODE"] = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                row["CLNCODE"] = strClinicCD.ToString().Trim();
            }

            var BEDCATS = com.GetSetupValue("BEDCATG");
            var conservcode = com.GetSetupValue("OPCONSULTSERV");
            var isCompany = false;
            if (patcatg == UCModel.strpatCatgCd.Substring(UCModel.strpatCatgCd.LastIndexOf(" ") + 1))
                isCompany = true;
            else
                isCompany = false;

            DataSet dsVisitType = SETVISITTYPE(UCModel.strMrNo, row["DOCTCODE"].ToString(), row["CLNCODE"].ToString(), UCModel.strTariffCatg, isCompany, UCModel.strCompNm.ToString().Trim());
            string strVisitType = "01";
            if (dsVisitType != null && dsVisitType.Tables.Count > 0)
                strVisitType = dsVisitType.Tables[0].Rows[0]["VISITTYPE"].ToString();

            DataSet DoctInfo = com.GetDoctorDetails(row["DOCTCODE"].ToString(), "", "", "", "", "");

            var DoctDeptCd = DoctInfo.Tables[0].Rows[0]["DEPTCODE"].ToString();

            row["DEPTCODE"] = DoctDeptCd;
            var ChargesInfo = getConsultAmt(row["DOCTCODE"].ToString(), row["CLNCODE"].ToString(), UCModel.strTariffCatg, UCModel.strMrNo, strVisitType, "", isCompany,
                UCModel.strCompNm, UCModel.strExemptioncat, UCModel.strpatCatgCd, "Y");
            row["PATAMTPAID"] = 0.00;
            row["ADVADJAMT"] = 0.00;
            row["CONSFEE"] = ChargesInfo[1];
            row["REGFEE"] = 0.00;
            row["DISCOUNT"] = row["CONSFEE"];
            row["TOTSURCAMT"] = 0.00;
            row["TOTEMERGAMT"] = 0.00;
            row["NETAMOUNT"] = 0.00;
            row["PATBILLAMT"] = 0.00;
            row["COMBILLAMT"] = 0.00;
            row["COMAMTPAID"] = "0";
            row["AMOUNTPAID"] = "0.00";
            row["SERVICETAX"] = 0.00;
            row["HOSPSHARE"] = 0.00;
            row["DOCTSHARE"] = 0.00;
            row["SERVCODE"] = conservcode;
            DataSet dsServInfo = com.GetServiceInfo(conservcode, "", "", "", "", "", "", "");
            row["SRVGRPCODE"] = dsServInfo.Tables[0].Rows[0]["SRVGRPCODE"];
            row["SUBGRPCODE"] = dsServInfo.Tables[0].Rows[0]["SRVSUBGRP"];
            row["SRVTYPCODE"] = dsServInfo.Tables[0].Rows[0]["SERVTYPECD"];
            row["SERVDEPT"] = dsServInfo.Tables[0].Rows[0]["DEPTCODE"];
            row["VISITTYPECD"] = strVisitType;
            row["DISCAUTHBY"] = "";
            row["FILECHARGE"] = 0.00;
            row["REGDISCAMT"] = 0.00;
            row["FILECHRGEDISCAMT"] = 0.00;
            CONSULTDATA.Rows.Add(row);

            OPServRef.BL_Consultation blcons = new BL_Consultation();
            blcons.Advadjamt = 0.00;
            blcons.Age = UCModel.strAge.Trim();
            blcons.Amtpaid = 0.00;
            blcons.Appmntno = "";
            blcons.Compcode = "";
            if (UCModel.strExemptioncat != null)
            {
                blcons.Conscatg = UCModel.strExemptioncat.ToString().Substring(UCModel.strExemptioncat.Length - 10, 10).Trim();
            }
            else
            {
                blcons.Conscatg = "";
            }
            blcons.Counterno = strCounter.Trim();
            blcons.Createdby = (System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString();
            blcons.Dob = GeneralFunction.GetDateInSpecifiedFormat(UCModel.strDOB, DataClass.GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blcons.Dollardt = "";
            blcons.Dollerrate = 0.00;
            blcons.Empid = "";
            blcons.Fundsource = strFundSource;
            blcons.Gender = UCModel.strGender;
            blcons.Ipaddress = strIpAddres;
            blcons.Counterno = strCounter;
            blcons.ModuleID = Convert.ToString(ModuleID); ;
            blcons.Mrno = (UCModel.strMrNo).Trim();
            blcons.Patcatg = (UCModel.strpatCatgCd.ToString().Substring(UCModel.strpatCatgCd.Length - 4, 4)).Trim();
            blcons.Patname = (UCModel.strPatNm).Trim();
            blcons.Patphone = UCModel.strContactNo.ToString().Trim();
            blcons.Paytype = UCModel.strPayType != null ? (UCModel.strPayType.ToString().Substring(UCModel.strPayType.Length - 3, 3)).Trim() : "";
            blcons.Priority = (UCModel.strPriorityCode).Trim();
            blcons.RegFee = 0.00;
            blcons.Remarks = "Added patient for consultation by doctor.";
            blcons.RefCompCd = "";
            blcons.Salucd = (UCModel.strSalutation.ToString().Substring(UCModel.strSalutation.Length - 3, 3)).Trim();
            blcons.Tariffid = (UCModel.strTariffCatg.ToString().Substring(UCModel.strTariffCatg.Length - 3, 3)).Trim();
            blcons.Time = (DateTime.Now.ToString("HH:mm:ss")).Trim();
            blcons.Date = (DateTime.Now.ToString("yyyyMMdd")).Trim();
            blcons.OnlPayStat = "";
            blcons.TranMode = 1;

            blcons.Letterno = "";
            blcons.OnlPayStat = "N";
            var inscompcode = ("" + blcons.Compcode) != "" ? comm.GetCrdCompLst("" + blcons.Compcode).First().InsComp : "";
            blcons.Inscompcode = inscompcode;

            //blcons.CareType = "";

            DataSet consds = new DataSet("BillDetails");
            CONSULTDATA.TableName = "BillHead";
            consds.Tables.Add(CONSULTDATA);
            string consxml = consds.GetXml();

            DataSet depods = new DataSet();
            depods.Tables.Add(DepositInfo);
            depods.Tables.Add(DepositFullData);
            string depoxml = depods.GetXml();
            DataSet Paymdds = new DataSet();
            Paymdds.Tables.Add(PAYMODEDATA);
            string paymdxml = Paymdds.GetXml();
            object status = null;
            new OutpatientClient().UsingSafe(op =>
            {
                status = op.SaveOrCancelOPConsltn(blcons, consxml, depoxml, paymdxml);
            });
            return status;
        }
    }

    #endregion "Add Patient"

    #region "Examination setup"
    public class ExaminationSetup
    {
        public string AddExaminationSetUp(string strPatAdviceSetUpName, string strExamSetupTempData, string strSetUpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                BL_PersonalSetUp bl = new BL_PersonalSetUp();

                bl.DoctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                bl.SetUpName = strPatAdviceSetUpName;
                bl.SetUpType = "E";
                bl.SetupCode = strSetUpCode;

                bl.SetupDetails = strExamSetupTempData;
                bl.UserID = HttpContext.Current.Session["gOncoUserId"].ToString();

                Result = Oncoser.SavePersonalisedSetUp(bl);
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDCOMPLA__D9C1FA000EB8D327'"))
                {
                    Result = "This set up is allready Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }

        public object GetExamSetupList()
        {
            try
            {
                var DoctorCode = string.Empty;
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataSet ds = new DataSet();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetPersExamSetup(DoctorCode)));
                if (ds != null && ds.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsucessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //added by Meenakshi on 10/01/2024
        public object GetPatAdvcListBySetupCode(string strSetUpCode)
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            DataSet ds = new DataSet();
            var strDoctCode = Convert.ToString(HttpContext.Current.Session["gDoctCode"]);
            ds.ReadXml(new XmlTextReader(new StringReader(oncoClient.GetListBySetUpCode(strSetUpCode, strDoctCode, "E"))));
            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select row["CODE"].ToString().Trim()).ToArray();
                    return data;
                }
            }
            return "";
        }

    }
    #endregion "Examination setup"

    #region Certificate
    public class CertificateMdl
    {
        public string SaveCertificateDtls(string Act, string TranNo, string Mrno, string PatName, string IssueDate, string Subject, string Para1, string Para2, string Para3)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            BL_FitnessCertificate Fit = new BL_FitnessCertificate();
            Fit.TranMode = Act == "E" ? 2 : Act == "C" ? 3 : 1;
            if (Act != "N")
                Fit.TranNo = int.Parse(TranNo);
            Fit.MRNO = Mrno;
            Fit.PatName = PatName;
            Fit.IssueDateInfo = IssueDate;
            Fit.Subject = Subject;
            Fit.Body1 = Para1;
            Fit.Body2 = Para2;
            Fit.Body3 = Para3;
            Fit.DoctCode = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]);
            Fit.UserId = Convert.ToString(System.Web.HttpContext.Current.Session["gOncoUserId"].ToString());
            string result = Oncoser.FitnesCertiTran(Fit);
            return result;
        }
        public object GetCertificateList(string Mrno)
        {
            CommonServiceClient ComClient = new CommonServiceClient();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            var DoctList = ComClient.GetDoctLst();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetFitnessData("", Mrno, Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]))))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];
            var rows = (from DataRow row in l_oDT.Select("STATUS = 'A'")
                        select new
                        {
                            CertificateNo = ("" + row["TRANNO"]).Trim(),
                            PatientName = ("" + row["PATNAME"]).Trim(),
                            Subject = ("" + row["CERTFSUB"]).Trim(),
                            DoctorName = row["ISSUEDOCTCD"].ToString().Trim() != "" ? DoctList.Where(x => x.Value == row["ISSUEDOCTCD"].ToString().Trim()).Count() > 0 ? DoctList.Where(x => x.Value == row["ISSUEDOCTCD"].ToString().Trim()).FirstOrDefault().Text : "" : "",
                            CreatedDTTM = GeneralFunction.GetDate(Convert.ToString(("" + row["CREATEDON"]).Trim())) + " / " + ("" + row["CREATEDAT"]).Trim(),
                            MRNO = ("" + row["MRNO"]).Trim(),
                            CERTFBODY1 = ("" + row["CERTFBODY1"]).Trim(),
                            CERTFBODY2 = ("" + row["CERTFBODY2"]).Trim(),
                            CERTFBODY3 = ("" + row["CERTFBODY3"]).Trim(),
                            DOCTCODE = ("" + row["ISSUEDOCTCD"]).Trim(),
                            ISSUEDTDET = ("" + row["ISSUEDTDET"]).Trim(),
                            STATUS = ("" + row["STATUS"]).Trim(),
                            CREATEDBY = ("" + row["CREATEDBY"]).Trim(),
                        }).ToArray();

            return rows;
        }
    }
    #endregion

    #region Certificate 2
    public class CertificateMdl2
    {
        public string SaveCertificate2Dtls(string Act, string TranNo, string Mrno, string Subject, string AttendDate, string BodyTemplate, string RestFromDate, string RestToDate, string IssueDate)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            BL_FitnessCertificate2 Fit = new BL_FitnessCertificate2();
            Fit.TranMode = Act == "E" ? 2 : Act == "C" ? 3 : 1;
            if (Act != "N")
                Fit.TranNo = int.Parse(TranNo);
            Fit.MRNO = Mrno;
            Fit.Subject = Subject;
            Fit.AttendDate = GeneralFunction.GetDateInSpecifiedFormat(AttendDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            Fit.Body = BodyTemplate;
            Fit.RestFromDate = GeneralFunction.GetDateInSpecifiedFormat(RestFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            Fit.RestToDate = GeneralFunction.GetDateInSpecifiedFormat(RestToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            Fit.IssueDate = GeneralFunction.GetDateInSpecifiedFormat(IssueDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            Fit.DoctCode = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]);
            Fit.UserId = Convert.ToString(System.Web.HttpContext.Current.Session["gOncoUserId"].ToString());
            string result = Oncoser.FitnesCertiTran2(Fit);
            return result;
        }
        public object GetCertificateList2(string Mrno, string TranNo)
        {
            CommonSerRef.CommonServiceClient ComClient = new CommonSerRef.CommonServiceClient();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetFitnessData2(TranNo, Mrno, Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]))))));
            var DoctList = ComClient.GetDoctLst();
            if (load.Tables.Count > 0)
            {
                var rows = (from DataRow row in load.Tables[0].Select("STATUS = 'A'")
                            select new
                            {
                                TRANNO = ("" + row["TRANNO"]).Trim(),
                                CERTFSUB = ("" + row["CERTFSUB"]).Trim(),
                                ISSUEDOCTCDNM = ("" + row["ISSUEDOCTCD"]).Trim() != "" ? DoctList.Where(x => x.Value == row["ISSUEDOCTCD"].ToString().Trim()).Count() > 0 ? DoctList.Where(x => x.Value == row["ISSUEDOCTCD"].ToString().Trim()).FirstOrDefault().Text : "" : "",
                                ISSUEDT = GeneralFunction.GetDate(row["ISSUEDT"].ToString().Trim()),
                                RESTFROMDT = GeneralFunction.GetDate(row["RESTFROMDT"].ToString().Trim()),
                                RESTTODT = GeneralFunction.GetDate(row["RESTTODT"].ToString().Trim()),
                                ATTENDDT = GeneralFunction.GetDate(row["ATTENDDT"].ToString().Trim()),
                                CREATEDBY = ("" + row["CREATEDBY"]).Trim(),
                                CREATEDDTTM = GeneralFunction.GetDate(row["CREATEDON"].ToString().Trim()) + " / " + ("" + row["CREATEDAT"]).Trim(),
                                ISSUEDOCTCD = ("" + row["ISSUEDOCTCD"]).Trim(),
                                STATUS = ("" + row["STATUS"]).Trim(),
                                CERTFBODY = row["CERTFBODY"],
                            }).ToArray();
                return rows;
            }
            return "";
        }
        public object GetCertificateNewData2(string Mrno)
        {
            CommonSerRef.CommonServiceClient ComClient = new CommonSerRef.CommonServiceClient();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            load.ReadXml(new XmlTextReader(new StringReader((client.GetFitnessMRDetails(Mrno, Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]))))));
            object[] obj = new object[2];
            obj[0] = ""; obj[1] = "";
            if (load.Tables.Count > 0)
            {
                Array Patrows = (from DataRow row in load.Tables[0].Rows
                                 select new
                                 {
                                     SALUNAME = ("" + row["SALUNAME"]).Trim(),
                                     PATNAME = ("" + row["PATNAME"]).Trim(),
                                     PATAGE = ("" + row["PATAGE"]).Trim() == "" ? "" : ("" + row["PATAGE"]).Trim().Split(':')[0],
                                     Gender = ("" + row["Gender"]).Trim(),
                                     Relation = ("" + row["Relation"]).Trim(),
                                     EMPNAME = ("" + row["EMPNAME"]).Trim(),
                                     PATPADDR1 = ("" + row["PATPADDR1"]).Trim(),
                                     PATPADDR2 = ("" + row["PATPADDR2"]).Trim(),
                                     PATPADDR3 = ("" + row["PATPADDR3"]).Trim(),
                                     PPINCODE = ("" + row["PPINCODE"]).Trim(),
                                     FATHERNAME = ("" + row["FATHNAME"]).Trim()
                                 }).ToArray();
                obj[0] = Patrows;
                if (load.Tables.Count > 1)
                {
                    Array rows = (from DataRow row in load.Tables[1].Rows
                                  select new
                                  {
                                      TRANNO = ("" + row["TRANNO"]).Trim(),
                                      TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                      FINALDIAGNOSIS = ("" + row["FINALDIAGNOSIS"]).Trim(),
                                  }).ToArray();
                    obj[1] = rows;
                }
            }

            return obj;
        }
    }
    #endregion

    #region Calender
    public class CalenderMdl
    {
        public object[] GetCalenderData(string FDate, string TDate)
        {
            object[] OBJ = new object[2];
            OncologyEMRClient OncoCli = new OncologyEMRClient();
            CommonServiceClient Comm = new CommonServiceClient();
            DataSet DoctLeaveDS = new DataSet();
            DataSet ds = new DataSet();
            FDate = GeneralFunction.GetDateInSpecifiedFormat(FDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            TDate = GeneralFunction.GetDateInSpecifiedFormat(TDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            DoctLeaveDS.ReadXml(new XmlTextReader(new StringReader(Comm.GetDoctorLeaveList(FDate, TDate, "Y"))));
            ds.ReadXml(new XmlTextReader(new StringReader(OncoCli.GetSurgeryAdviceList(FDate, TDate, (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString(), ""))));
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var jsonData = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    TRANNO = ("" + row["TRANNO"]).ToString().Trim(),
                                    MRNO = ("" + row["MRNO"]).ToString().Trim(),
                                    PATNAME = ("" + row["PATNAME"]).ToString().Trim(),
                                    DOCTCODE = ("" + row["DOCTCODE"]).ToString().Trim(),
                                    DOCTNAME = ("" + row["DOCTNAME"]).ToString().Trim(),
                                    PACSURGADVDATE = ("" + row["PACADVDATE"]).ToString().Trim(),
                                    SURGADVDATE = ("" + row["SURGADVDATE"]).ToString().Trim(),
                                    SURGERY = ("" + row["SURGERY"]).ToString().Trim(),
                                    ACT = "E",
                                    PREVSURGADVDATE = ("" + row["SURGADVDATE"]).ToString().Trim(),
                                    PACYN = ("" + row["PACYN"]).ToString().Trim(),
                                    PREAUTHYN = ("" + row["PREAUTHYN"]).ToString().Trim(),
                                    OTBOOKYN = ("" + row["OTBOOKYN"]).ToString().Trim(),
                                    DOCTORAPPROVAEDYN = ("" + row["DOCTORAPPROVAEDYN"]).ToString().Trim(),
                                    SURGYDATETIME = ("" + row["SURGDATE"]).ToString().Trim() == "" ? "" : (GeneralFunction.GetDate(("" + row["SURGDATE"]).ToString().Trim()) + " " + ("" + row["SURGTIME"]).ToString().Trim()),
                                    OTNOTESNO = ("" + row["OTNOTESNO"]).ToString().Trim(),
                                    ASARISKLEVEL = row["ASARISKLEVEL"].ToString().Trim() == "L" ? "Low" ://PRIYANKA 20/11/2025
                                                   row["ASARISKLEVEL"].ToString().Trim() == "M" ? "Medium" :
                                                   row["ASARISKLEVEL"].ToString().Trim() == "H" ? "High" : "",
                                    SCHEMECODES = ("" + row["SCHEMECODES1"]).ToString().Trim(),
                                    PATCATG = ("" + row["PATCATGNM"].ToString().Trim() + (("" + row["COMPNAME"].ToString()).Trim() == "" ? "" : (" (" + ("" + row["COMPNAME"].ToString()).Trim() + ")")))
                                }).ToList();
                OBJ[0] = jsonData;
            }
            if (DoctLeaveDS.Tables.Count > 0 && DoctLeaveDS.Tables[0].Rows.Count > 0)
            {
                var jsonData = (from DataRow row in DoctLeaveDS.Tables[0].Rows
                                select new
                                {
                                    DOCTCODE = ("" + row["DOCTCODE"]).ToString().Trim(),
                                    DOCTNAME = ("" + row["DOCTNAME"]).ToString().Trim(),
                                    FROMDATE = GeneralFunction.GetDate(("" + row["FROMDATE"]).ToString().Trim()),
                                    TODATE = GeneralFunction.GetDate(("" + row["TODATE"]).ToString().Trim()),
                                    SURGEONYN = ("" + row["SURGEONYN"]).ToString().Trim(),
                                    ANESTISTYN = ("" + row["ANESTISTYN"]).ToString().Trim(),
                                }).ToList();
                OBJ[1] = jsonData;
            }
            return OBJ;
        }

        //Get Unallocated Patient Data
        public object[] GetCalenderDataUnallocated(string FDate, string TDate, string PatName) // PatName Added By Abhsihesh || 20260820
        {
            object[] OBJ = new object[1]; // Only need unallocated surgeries
            OncologyEMRClient OncoCli = new OncologyEMRClient();
            DataSet ds = new DataSet();

            FDate = GeneralFunction.GetDateInSpecifiedFormat(FDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            TDate = GeneralFunction.GetDateInSpecifiedFormat(TDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            ds.ReadXml(new XmlTextReader(new StringReader(OncoCli.GetSurgeryAdviceList(FDate, TDate,
                (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString(), PatName)))); // PatName Added By Abhsihesh || 20260820

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var unallocatedData = (from DataRow row in ds.Tables[0].Rows
                                       where string.IsNullOrWhiteSpace(row["SURGADVDATE"].ToString().Trim())
                                       select new
                                       {
                                           TRANNO = ("" + row["TRANNO"]).ToString().Trim(),
                                           MRNO = ("" + row["MRNO"]).ToString().Trim(),
                                           PATNAME = ("" + row["PATNAME"]).ToString().Trim(),
                                           DOCTCODE = ("" + row["DOCTCODE"]).ToString().Trim(),
                                           DOCTNAME = ("" + row["DOCTNAME"]).ToString().Trim(),
                                           PACSURGADVDATE = GeneralFunction.GetDate(("" + row["PACADVDATE"]).ToString().Trim()),
                                           SURGADVDATE = ("" + row["SURGADVDATE"]).ToString().Trim(),
                                           SURGERY = ("" + row["SURGERY"]).ToString().Trim(),
                                           ACT = "E",
                                           PREVSURGADVDATE = GeneralFunction.GetDate(("" + row["SURGADVDATE"]).ToString().Trim()),
                                           PACYN = ("" + row["PACYN"]).ToString().Trim(),
                                           PREAUTHYN = ("" + row["PREAUTHYN"]).ToString().Trim(),
                                           OTBOOKYN = ("" + row["OTBOOKYN"]).ToString().Trim(),
                                           DOCTORAPPROVAEDYN = ("" + row["DOCTORAPPROVAEDYN"]).ToString().Trim(),
                                           SURGYDATETIME = ("" + row["SURGDATE"]).ToString().Trim() == "" ? "" : (GeneralFunction.GetDate(("" + row["SURGDATE"]).ToString().Trim()) + " " + ("" + row["SURGTIME"]).ToString().Trim()),
                                           OTNOTESNO = ("" + row["OTNOTESNO"]).ToString().Trim(),
                                           ASARISKLEVEL = row["ASARISKLEVEL"].ToString().Trim() == "L" ? "Low" ://PRIYANKA 20/11/2025
                                                          row["ASARISKLEVEL"].ToString().Trim() == "M" ? "Medium" :
                                                          row["ASARISKLEVEL"].ToString().Trim() == "H" ? "High" : "",
                                           SCHEMECODES = ("" + row["SCHEMECODES1"]).ToString().Trim(),
                                           PATCATGNM = ("" + row["PATCATGNM"].ToString().Trim()) //PRIYANKA 16/03/2026
                                       }).ToList();

                OBJ[0] = unallocatedData;
            }

            return OBJ;
        }


        public object GetAdvPatListData(string FDate)
        {
            OncologyEMRClient OncoCli = new OncologyEMRClient();
            DataSet ds = new DataSet();
            ds.ReadXml(new XmlTextReader(new StringReader(OncoCli.GetPACPatientWaitList(GeneralFunction.GetDateInSpecifiedFormat(FDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD)
                , "", (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString()))));
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var jsonData = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    CHECKED = "N",
                                    MRNO = ("" + row["MRNO"]).ToString().Trim(),
                                    PATNAME = ("" + row["PATNAME"]).ToString().Trim(),
                                    CONSNO = ("" + row["CONSNO"]).ToString().Trim(),
                                    DOCTCODE = ("" + row["DOCTCODE"]).ToString().Trim(),
                                    DOCTNAME = ("" + row["DOCTNAME"]).ToString().Trim(),
                                    SURGADVCODES = ("" + row["SURGADVCODES"]).ToString().Trim(),
                                    SURGADVDATE = GeneralFunction.GetDate(("" + row["SURGADVDATE"]).ToString().Trim()),
                                    SURGADVTYPE = ("" + row["SURGADVTYPE"]).ToString().Trim(),
                                    SURGNMADVICE = ("" + row["SURGNMADVICE"]).ToString().Trim(),
                                    PACSTATUS = ("" + row["PACSTATUS"]).ToString().Trim(),
                                    PREAUTHSTATUS = ("" + row["PREAUTHSTATUS"]).ToString().Trim(),
                                    OTBOOKSTATUS = ("" + row["OTBOOKSTATUS"]).ToString().Trim(),
                                    DRAPPROVEDYN = ("" + row["DRAPPROVEDYN"]).ToString().Trim(),
                                    SURGYDATETIME = ("" + row["SURGDATE"]).ToString().Trim() == "" ? "" : (GeneralFunction.GetDate(("" + row["SURGDATE"]).ToString().Trim()) + " " + ("" + row["SURGTIME"]).ToString().Trim()),
                                    SURGDATE = ("" + row["SURGDATE"]).ToString().Trim() == "" ? "" : GeneralFunction.GetDate(("" + row["SURGDATE"]).ToString().Trim()),
                                    SURGTIME = ("" + row["SURGTIME"]).ToString().Trim(),
                                    DRREJECTREMARKS = ("" + row["DRREJECTREMARKS"]).ToString().Trim(),
                                    PACFITDATE = ("" + row["PACFITDATE"]).ToString().Trim() == "" ? "" : GeneralFunction.GetDate(("" + row["PACFITDATE"]).ToString().Trim()),
                                    PACFITTIME = ("" + row["PACFITTIME"]).ToString().Trim(),
                                    OTNOTESNO = ("" + row["OTNOTESNO"]).ToString().Trim(),
                                    ASARISKLEVEL = row["ASARISKLEVEL"].ToString().Trim() == "L" ? "Low" ://PRIYANKA 20/11/2025
                                                   row["ASARISKLEVEL"].ToString().Trim() == "M" ? "Medium" :
                                                   row["ASARISKLEVEL"].ToString().Trim() == "H" ? "High" : "",
                                    SCHEMECODES = ("" + row["SCHEMECODES"]).ToString().Trim(),
                                    PATCATGNM = ("" + row["PATCATGNM"].ToString().Trim())//PRIYANKA 16/03/2026
                                }).ToList();
                return jsonData;
            }
            else
            {
                return "";
            }
        }

        public string TranCalenderData(string CalenderData)
        {
            OncologyEMRClient OncoCli = new OncologyEMRClient();
            DataSet DS = new DataSet();
            DataTable DT = new DataTable();
            DT = JsonConvert.DeserializeObject<DataTable>(CalenderData);
            foreach (DataRow DR in DT.Rows)
            {
                DR["SURGADVDATE"] = GeneralFunction.GetDateInSpecifiedFormat(("" + DR["SURGADVDATE"]).ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                DR["PACADVDATE"] = GeneralFunction.GetDateInSpecifiedFormat(("" + DR["PACADVDATE"]).ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            DT.TableName = "TBL";
            DS.DataSetName = "DS";
            DS.Tables.Add(DT);
            int Res = OncoCli.UpdateCalenderSurgeryAdviceDate(DS.GetXml(), System.Web.HttpContext.Current.Session["gOncoUserId"].ToString());
            return "";
        }

        public string TranAdvListApprovData(string ApprovelList, string Remarks, string ApprovalStatus)
        {
            OncologyEMRClient OncoCli = new OncologyEMRClient();
            DataSet DS = new DataSet();
            DataTable DT = new DataTable();
            DT = JsonConvert.DeserializeObject<DataTable>(ApprovelList);
            DT.TableName = "TBL";
            DS.DataSetName = "DS";
            DS.Tables.Add(DT);
            string Result = OncoCli.OTSurgeryBookApprovalTran("", Remarks, System.Web.HttpContext.Current.Session["gOncoUserId"].ToString(), DS.GetXml(), ApprovalStatus);
            return Result;
        }
    }
    #endregion

    #region PAC
    public class PACMdl : BL_PAC
    {
        CommonServiceClient Comm = new CommonServiceClient();
        OncologyEMRClient oncoClient = new OncologyEMRClient();
        public string PatName { get; set; }
        public string PatAge { get; set; }
        public string PatGender { get; set; }
        public string AdmDoctor { get; set; }
        public string ObesityScore { get; set; }
        public string ARISCATTotal { get; set; }
        public string Gaction { get; set; }
        public string DoctorCode { get; set; }
        public string DoctorName { get; set; }
        public string PlannedSurgeryNM { get; set; }
        public string PatHeight { get; set; }
        public string PatWeight { get; set; }
        public string PatBMI { get; set; }
        public string PatBSA { get; set; }
        public string VitalsData { get; set; }
        public string InvstData { get; set; }
        public string PACHistListData { get; set; }
        public string VisitRecord { get; set; }

        public string ResultInvstData { get; set; }
        public string ConsultDate { get; set; }
        public string ConsultTime { get; set; }
        public string SpecialityRefData { get; set; }
        public string MedGridData { get; set; }
        public string PreOPMedLst { get; set; }
        public string InductionLst { get; set; }
        public string PONVLst { get; set; }
        public string MaintenanceLst { get; set; }
        public string RevLst { get; set; }
        public string PACDoneBy { get; set; }
        public string OTNotesNo { get; set; }

        //Priyanka 23/02/2026
        public string ShowPatInfo { get; set; }
        public string ShowAdvisedSurgeryDtls { get; set; }
        public string ShowPatVitalDtls { get; set; }
        public string ShowGenPhysicalExamDtls { get; set; }
        public string ShowCombandTreatHistDtls { get; set; }
        public string ShowSubstanceAbuseHistDtls { get; set; }
        public string ShowAirwayAssmntDtls { get; set; }
        public string ShowSysExamDtls { get; set; }
        public string ShowARISCATtls { get; set; }
        public string ShowRevCardiacRiskDtls { get; set; }
        public string ShowChildPughTurcScoreDtls { get; set; }
        public string ShowSpecialityRefDtls { get; set; }
        public string ShowASADtls { get; set; }
        public string ShowInvestAdviceDtls { get; set; }
        public string ShowAneasandPreopDtls { get; set; }
        public string ShowAneasPlanDtls { get; set; }
        public string ShowInductionMedicineDtls { get; set; }

        //priyanka 01/03/2026
        public string ChemoTherapyData { get; set; }
        public string RadioTherapyData { get; set; }
        //end
        public string ASAPhysicalStatusEYN { get; set; } //priyanka 21/03/2026
        public string IsVisitPrint { get; set; } //priyanka 21/03/2026
        //CARDIAC SYSTEM
        //public string CARDIACIHDYN { get; set; }
        //public string CARDIACIHDRMK { get; set; }
        //public string CARDIACCHFYN { get; set; }
        //public string CARDIACCHFRMK { get; set; }
        //public string CARDIACRHDYN { get; set; }
        //public string CARDIACRHDRMK { get; set; }
        //public string CARDIACTHRYN { get; set; }
        //public string CARDIACTHRRMK { get; set; }


        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> cmbAneasType { get; set; }
        //public string CHILDPUGHNAYN { get; set; }
        //public string ARISCATNAYN { get; set; }
        //public string REVLEENAYN { get; set; }

        //public void BindPACDtls(PACMdl Mdl)
        public void BindPACDtls(PACMdl Mdl, string LOGYN, string PatTRANNO, string LogDT, string LogTM, string Type)
        {
            Mdl.Gaction = "N";
            Mdl.cmbAneasType = Comm.GetAnaesthTypeList();
            DataSet ListLoad = new DataSet();
            DataTable ListLoadDT = new DataTable();
            var DrugType = GeneralFunction.GetDrugFormList(); //Abhishesh || 20260617
            if (Mdl.MRNO != "")
            {
                //ListLoad.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACPatientWaitList("", Mdl.MRNO, "")))));
                ListLoad.ReadXml(new XmlTextReader(new StringReader(oncoClient.GetSurgeryAdvicedList(Mdl.MRNO))));
                if (ListLoad.Tables.Count > 0 && ListLoad.Tables[0].Rows.Count > 0)
                {
                    DataRow[] DrFilterR;
                    if (Mdl.TRANNO == "")
                    {
                        DrFilterR = ListLoad.Tables[0].Select("PACNO = ''");
                    }
                    else
                    {
                        DrFilterR = ListLoad.Tables[0].Select("PACNO = '" + Mdl.TRANNO + "'");
                    }
                    if (DrFilterR.Length > 0)
                    {
                        Mdl.SurgAdvConsNo = DrFilterR[0]["TRANNO"].ToString().Trim();
                        Mdl.DoctorCode = DrFilterR[0]["DOCTCODE"].ToString().Trim();
                        Mdl.DoctorName = DrFilterR[0]["DOCTNAME"].ToString().Trim();
                        Mdl.PlannedSurgeryNM = DrFilterR[0]["SURGNAME"].ToString().Trim();
                        Mdl.PlannedSurgeryCodes = DrFilterR[0]["SURGADVCODES"].ToString().Trim();
                        Mdl.AdvicedSurgeryDate = GeneralFunction.GetDate(Convert.ToString(DrFilterR[0]["SURGADVDATE"]).Trim());
                        Mdl.SurgBookType = DrFilterR[0]["SURGADVTYPE"].ToString().Trim();
                        Mdl.ConsultDate = GeneralFunction.GetDate(Convert.ToString(DrFilterR[0]["TRANDATE"]).Trim());
                        Mdl.ConsultTime = DrFilterR[0]["TRANTIME"].ToString().Trim();
                    }
                }

                if (ListLoad.Tables.Count > 1 && ListLoad.Tables[1].Rows.Count > 0)
                {
                    DataTable RADIOTHERAPYDETAILS = new DataTable();
                    RADIOTHERAPYDETAILS = ListLoad.Tables[1];
                    Mdl.RadioTherapyData = "#" + RADIOTHERAPYDETAILS.Rows[0]["COMPLETED_FRACTIONS"].ToString().Trim() + "Ld "
                    + GeneralFunction.GetDate(Convert.ToString(RADIOTHERAPYDETAILS.Rows[0]["LASTDATE_RT"].ToString().Trim()));
                }
                else
                {
                    Mdl.RadioTherapyData = "";
                }


                if (ListLoad.Tables.Count > 2 && ListLoad.Tables[2].Rows.Count > 0)
                {
                    DataTable CHEMOTHERAPYDETAILS = new DataTable();
                    CHEMOTHERAPYDETAILS = ListLoad.Tables[2];

                    Mdl.ChemoTherapyData = CHEMOTHERAPYDETAILS.Rows[0]["PROTOCOLNAME"].ToString().Trim() + "#"
                    + CHEMOTHERAPYDETAILS.Rows[0]["CYCLENO"].ToString().Trim() + "Ld "
                    + GeneralFunction.GetDate(Convert.ToString(CHEMOTHERAPYDETAILS.Rows[0]["TRANDATE"].ToString().Trim()));
                }
                else
                {
                    Mdl.ChemoTherapyData = "";
                }
            }
            if (Mdl.MRNO != "" && Mdl.TRANNO != "")
            {
                DataSet Load = new DataSet();
                DataTable LoadDT = new DataTable();
                //Load.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACDetails(Mdl.MRNO, Mdl.TRANNO)))));
                if (LOGYN == "Y")
                {
                    Load = GeneralFunction.FillDatasetXMl(oncoClient.GetPACLogHistoryList(PatTRANNO));

                    if (Load == null || Load.Tables.Count == 0 || Load.Tables[0].Rows.Count == 0)
                    {
                        return;
                    }

                    DataTable dt = Load.Tables[0];

                    string logDate = GeneralFunction.GetDateInSpecifiedFormat(LogDT, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                    string logTime = (LogTM ?? "").Trim();
                    DataRow matchedRow = null;

                    foreach (DataRow row in dt.Rows)
                    {
                        string matchedDate = "";
                        string matchedTime = "";

                        if (Type.Equals("New", StringComparison.OrdinalIgnoreCase))
                        {
                            matchedDate = row["TRANDATE"].ToString().Trim();
                            matchedTime = row["CREATEDAT"].ToString().Trim();
                        }
                        else if (Type.Equals("Edit", StringComparison.OrdinalIgnoreCase))
                        {
                            matchedDate = row["EDITEDON"].ToString().Trim();
                            matchedTime = row["EDITEDAT"].ToString().Trim();
                        }
                        else if (Type.Equals("Verify", StringComparison.OrdinalIgnoreCase))
                        {
                            matchedDate = row["VERIFIEDON"].ToString().Trim();
                            matchedTime = row["VERIFIEDAT"].ToString().Trim();
                        }

                        if (matchedDate == logDate &&
                            matchedTime == logTime)
                        {
                            matchedRow = row;
                            break;
                        }
                    }

                    if (matchedRow == null)
                    {
                        return;
                    }
                    DataTable matchedDT = dt.Clone();

                    matchedDT.ImportRow(matchedRow);
                    Load.Tables.RemoveAt(0);
                    Load.Tables.Add(matchedDT);
                }
                else
                {
                    Load.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACDetails(Mdl.MRNO, Mdl.TRANNO)))));
                }
                if (Load.Tables.Count > 0 && Load.Tables[0].Rows.Count > 0)
                {
                    LoadDT = Load.Tables[0];
                    BindPACProperty(Mdl, ListLoadDT, LoadDT);
                }
                if (Load.Tables.Count > 1 && Load.Tables[1].Rows.Count > 0)
                {
                    DataTable VITALSDT = new DataTable();
                    VITALSDT = Load.Tables[1];
                    int Index = 0;
                    Array VitalsArry = (from row1 in VITALSDT.AsEnumerable()
                                        select new
                                        {
                                            SEQNO = Index++,
                                            VITALDATE = ("" + row1["VITALDATE"]).ToString() == "" ? "" : GeneralFunction.GetDate(("" + row1["VITALDATE"]).ToString()),
                                            VITALTIME = row1["VITALTIME"],
                                            TEMP = row1["TEMP"],
                                            PULSE = row1["PULSE"],
                                            BLOODPRESSURE = row1["BLOODPRESSURE"],
                                            SPO2 = row1["SPO2"],
                                            PAINSCORE = row1["PAINSCORE"],
                                            BREATHHOLD = row1["BREATHHOLD"]
                                        }).ToArray();
                    Mdl.VitalsData = Newtonsoft.Json.JsonConvert.SerializeObject(VitalsArry);
                }


                DataTable TableResult = new DataTable();
                BindInvstData(Mdl, TableResult, Load);
                if (TableResult.Rows.Count > 0)
                {
                    Array ResutArry = (from row1 in TableResult.AsEnumerable()
                                       select new
                                       {
                                           INVDATE = GeneralFunction.GetDate(("" + row1["INVDATE"]).ToString()),
                                           INVINHOUSEDATE = GeneralFunction.GetDate(("" + row1["INVINHOUSEDATE"]).ToString()),
                                           TESTCODE = row1["TESTCODE"],
                                           INVSETCODE = row1["INVESTCODE"],
                                           INVSETDESC = row1["INVESTDESC"],
                                           RESULTTYPE = row1["RESULTTYPE"],
                                           SEQNO = row1["SEQNO"],
                                           RESULTDT = row1["RESULTDT"],
                                           INRESULTDT = row1["INRESULTDT"],
                                           TRANNO = row1["TRANNO"],
                                           TESTNAME = row1["TESTNAME"]
                                       }).ToArray();
                    Mdl.ResultInvstData = Newtonsoft.Json.JsonConvert.SerializeObject(ResutArry);
                }
                if (Load.Tables.Count > 5 && Load.Tables[5].Rows.Count > 0)
                {
                    DataTable REFDT = new DataTable();
                    REFDT = Load.Tables[5];
                    int Index = 0;
                    Array VitalsArry = (from row1 in REFDT.AsEnumerable()
                                        select new
                                        {
                                            INDEX = Index++,
                                            REFCODE = row1["REFCODE"],
                                            REFNAME = row1["REFNAME"],
                                            REFCONTENT = row1["REFCONTENT"],
                                            TRANNO = row1["TRANNO"]
                                        }).ToArray();
                    Mdl.SpecialityRefData = Newtonsoft.Json.JsonConvert.SerializeObject(VitalsArry);
                }
                if (Load.Tables.Count > 6 && Load.Tables[6].Rows.Count > 0)
                {
                    DataTable MEDDT = new DataTable();
                    MEDDT = Load.Tables[6];
                    Array MedArry = (from row1 in MEDDT.AsEnumerable()
                                     select new
                                     {
                                         SEQNO = row1["SEQNO"],
                                         TYPE = row1["TYPE"],
                                         DRUGCODE = row1["DRUGCODE"],
                                         DRUGNAME = row1["DRUGNM"],
                                         GENERICID = row1["GENERICID"],
                                         GENERICNAME = row1["GENERICNAME"],
                                         INTAKECD = row1["INTAKECD"],
                                         INTAKEDESC = row1["INTAKEDESC"],
                                         DAYS = row1["DAYS"],
                                         DURATION = row1["DURATION"],
                                         ABFOOD = row1["ABFOOD"],
                                         ROUTE = row1["ROUTE"].ToString().Trim(),
                                         DOSSAGE = row1["DOSSAGE"],
                                         QTY = row1["QTY"],
                                         Remarks = row1["Remarks"],
                                         SOSYN = row1["SOSYN"],
                                         DRUGFORMCODE = row1["DRUGFORM"].ToString().Trim(),
                                         DRUGFORM = GeneralFunction.GetListValue(DrugType, row1["DRUGFORM"].ToString().Trim()),  //Abhishesh || 20260617
                                         TRANNO = row1["TRANNO"]
                                     }).ToArray();
                    Mdl.MedGridData = Newtonsoft.Json.JsonConvert.SerializeObject(MedArry);
                }
                //if (Mdl.Gaction == "N")
                //{
                var DoctLst = oncoClient.GetDoctLst("", "D");
                DataSet HistDS = new DataSet();
                HistDS.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACList("", "", Mdl.MRNO, "", "")))));
                if (HistDS.Tables.Count > 0 && HistDS.Tables[0].Rows.Count > 0)
                {
                    Array HistListArry = (from row1 in HistDS.Tables[0].AsEnumerable()
                                          select new
                                          {
                                              PACCONSNO = ("" + row1["PACCONSNO"]).ToString(),
                                              MRNO = Mdl.MRNO,
                                              DOCTNAME = row1.Table.Columns.Contains("DOCTNAME")
                                                         ? row1["DOCTNAME"]?.ToString() ?? ""
                                                         : "",
                                              SURGADVDATE = GeneralFunction.GetDate(("" + row1["SURGADVDATE"]).ToString()),
                                              SURGNMADVICE = row1.Table.Columns.Contains("SURGNMADVICE")
                                                         ? row1["SURGNMADVICE"]?.ToString() ?? ""
                                                         : "",
                                              //("" + row1["SURGNMADVICE"]).ToString(),
                                              SURGADVTYPE = row1.Table.Columns.Contains("SURGADVTYPE")
                                                            ? row1["SURGADVTYPE"]?.ToString() ?? ""
                                                            : "",
                                              //("" + row1["SURGADVTYPE"]).ToString(),
                                              PACSTATUS = ("" + row1["PACSTATUS"]).ToString(),
                                              PACFITDATE = ("" + row1["PACFITDATE"]).ToString() == "" ? "" : GeneralFunction.GetDate(("" + row1["PACFITDATE"]).ToString()),
                                              PACFITTIME = ("" + row1["PACFITTIME"]).ToString(),
                                              PACDONEBY = ("" + row1["PACDONEBY"]).ToString().Trim() == "" ? "" : (DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).Count() > 0 ? DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).FirstOrDefault().Text : ("" + row1["PACDONEBY"]).ToString().Trim()),
                                              ASARISKLEVEL = ("" + row1["ASARISKLEVEL"]).ToString().Trim(),
                                              STATUS = ("" + row1["STATUS"]).ToString().Trim()
                                          }).ToArray();
                    Mdl.PACHistListData = Newtonsoft.Json.JsonConvert.SerializeObject(HistListArry);
                    //}
                }
                if (Load.Tables.Contains("Table9"))
                {
                    Array VisitRecordRef = (from row1 in Load.Tables["Table9"].AsEnumerable()
                                            select new
                                            {
                                                TRANNO = row1["TRANNO"],
                                                TRANDATE = GeneralFunction.GetDate(Convert.ToString(row1["TRANDATE"]).Trim()),//PRIYANKA 21/03/2026
                                                TRANTIME = row1["TRANTIME"],
                                                REFPACNO = row1["REFPACNO"],
                                                NOTES = row1["NOTES"].ToString().Replace("\\n", "\r\n").Trim('"'),
                                                SPECIALITYREFERENCE = row1["SPECIALITYREFERENCE"].ToString().Replace("\\n", "\r\n").Trim('"'),
                                                ANAESTADVICEOPERATIVEORDER = row1["ANAESTADVICEOPERATIVEORDER"].ToString().Replace("\\n", "\r\n").Trim('"')
                                            }).ToArray();
                    Mdl.VisitRecord = Newtonsoft.Json.JsonConvert.SerializeObject(VisitRecordRef);
                }
                //}
            }
        }

        //Added by Aaryshree on 20260220
        public object GetVisitPACList(PACMdl Mdl)
        {
            BL_PAC BL = new BL_PAC();
            DataSet Load = new DataSet();
            Load.ReadXml(new XmlTextReader(new StringReader(oncoClient.GetPACDetailsWithVisit(Mdl.MRNO, Mdl.TRANNO))));
            var RxList = new List<object>();
            var InvestigationList = new List<object>();
            var SpecialityAnaesthe = new List<object>();
            var specialityanaestadvic = new List<object>();
            var SpecilityRefrence = new List<object>();

            if (Load.Tables.Contains("Table6"))
            {
                DataTable dt = Load.Tables["Table6"];
                RxList = (from DataRow row in dt.Select("TYPE = 'I'")
                          select new
                          {
                              TRANNO = row["TRANNO"].ToString().Trim(),
                              GENERICID = row["GENERICID"].ToString().Trim(),
                              GENERICNAME = row["GENERICNAME"].ToString().Trim(),
                              DOSSAGE = row["DOSSAGE"].ToString().Trim(),
                              Remarks = row["Remarks"].ToString().Trim(),
                              ROUTE = row["ROUTE"].ToString().Trim(),
                              QTY = row["QTY"].ToString().Trim(),
                              DAYS = row["DAYS"].ToString().Trim(),
                              DURATION = row["DURATION"].ToString().Trim(),
                              INTAKECD = row["INTAKECD"].ToString().Trim(),
                              INTAKEDESC = row["INTAKEDESC"].ToString().Trim(),
                              DRUGFORM = row["DRUGFORM"].ToString().Trim(),
                          }).ToList<object>();
            }
            if (Load.Tables.Contains("Table3"))
            {
                DataTable dt = Load.Tables["Table3"];
                InvestigationList = (from DataRow row in dt.Rows
                                     select new
                                     {
                                         TRANNO = row["TRANNO"].ToString().Trim(),
                                         MRNO = row["MRNO"].ToString().Trim(),
                                         TESTCODE = row["TESTCODE"].ToString().Trim(),
                                         TESTNAME = row["TESTNAME"].ToString().Trim(),
                                         DURATION = row["DURATION"].ToString().Trim(),
                                         DURTYPE = row["DURTYPE"].ToString().Trim(),
                                         REMARK = row["REMARK"].ToString().Trim(),
                                         BILLEDYN = row["BILLEDYN"].ToString().Trim(),
                                         SETUPYN = row["SETUPYN"].ToString().Trim(),
                                         BILLNO = row["BILLNO"].ToString().Trim()

                                     }).ToList<object>();


            }
            if (Load.Tables.Contains("Table"))
            {
                DataTable dt = Load.Tables["Table"];
                SpecialityAnaesthe = (from DataRow row in dt.Rows
                                      select new
                                      {
                                          TRANNO = row["TRANNO"].ToString().Trim(),
                                          TRANDATE = GeneralFunction.GetDate(Convert.ToString(row["TRANDATE"]).Trim()),
                                          MRNO = row["MRNO"].ToString().Trim(),
                                          SPECIALITYREFERENCE = row["SPECIALITYREFERENCE"].ToString().Trim().Trim('"'),
                                          ANAESTADVICEOPERATIVEORDER = row["ANAESTADVICEOPERATIVEORDER"].ToString().Trim().Trim('"')

                                      }).ToList<object>();
            }
            if (Load.Tables.Contains("Table5"))
            {
                DataTable dt = Load.Tables["Table5"];
                SpecilityRefrence = (from DataRow row in dt.Rows
                                     select new
                                     {
                                         TRANNO = row["TRANNO"].ToString().Trim(),
                                         REFCODE = row["REFCODE"].ToString().Trim(),
                                         REFNAME = row["REFNAME"].ToString().Trim(),
                                         REFCONTENT = row["REFCONTENT"].ToString().Trim(),

                                     }).ToList<object>();

            }
            if (Load.Tables.Contains("Table7"))
            {
                DataTable dt = Load.Tables["Table7"];
                specialityanaestadvic = (from DataRow row in dt.Rows
                                         select new
                                         {
                                             TRANNO = row["TRANNO"].ToString().Trim(),
                                             TRANDATE = row["TRANDATE"].ToString().Trim(),
                                             TRANTIME = row["TRANTIME"].ToString().Trim(),
                                             MRNO = row["MRNO"].ToString().Trim(),
                                             CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                             NOTES = row["NOTES"].ToString().Trim(),
                                             REFPACNO = row["REFPACNO"].ToString().Trim(),
                                             SPECIALITYREFERENCE = row["SPECIALITYREFERENCE"].ToString().Trim(),
                                             ANAESTADVICEOPERATIVEORDER = row["ANAESTADVICEOPERATIVEORDER"].ToString().Trim(),
                                             DOCTNAME = row["DOCTNAME"].ToString().Trim()


                                         }).ToList<object>();


            }
            var allTables = Load.Tables.Cast<DataTable>()
                           .ToDictionary(
                               t => t.TableName,
                               t => t.Rows.Cast<DataRow>()
                                     .Select(r => t.Columns.Cast<DataColumn>()
                                     .ToDictionary(c => c.ColumnName, c => r[c]))
                           );

            var jsonData = new
            {
                Table6 = RxList,
                Table3 = InvestigationList,
                Table = SpecialityAnaesthe,
                Table7 = specialityanaestadvic,
                Table5 = SpecilityRefrence,
                AllTable = allTables
            };

            return jsonData;

        }
        public void BindPACProperty(PACMdl Mdl, DataTable ListLoadDT, DataTable LoadDT)
        {
            bool FlagFilter = false;
            var DoctLst = oncoClient.GetDoctLst("", "D");
            if (ListLoadDT.Rows.Count > 0)
            {
                //DataRow[] DrFilter = ListLoadDT.Select("CONSNO = '" + LoadDT.Rows[0]["SURGADVCONSNO"].ToString().Trim() + "'");
                DataRow[] DrFilter = ListLoadDT.Select("TRANNO = '" + LoadDT.Rows[0]["SURGADVCONSNO"].ToString().Trim() + "'");
                if (DrFilter.Length > 0)
                {
                    FlagFilter = true;
                    //Mdl.SurgAdvConsNo = DrFilter[0]["CONSNO"].ToString().Trim();
                    Mdl.SurgAdvConsNo = DrFilter[0]["TRANNO"].ToString().Trim();
                    Mdl.DoctorCode = DrFilter[0]["DOCTCODE"].ToString().Trim();
                    Mdl.DoctorName = DrFilter[0]["DOCTNAME"].ToString().Trim();
                    Mdl.PlannedSurgeryNM = DrFilter[0]["SURGNAME"].ToString().Trim();
                    Mdl.PlannedSurgeryCodes = DrFilter[0]["SURGADVCODES"].ToString().Trim();
                    Mdl.AdvicedSurgeryDate = GeneralFunction.GetDate(Convert.ToString(DrFilter[0]["SURGADVDATE"]).Trim());
                    Mdl.SurgBookType = DrFilter[0]["SURGADVTYPE"].ToString().Trim();
                    //Mdl.ConsultDate = GeneralFunction.GetDate(Convert.ToString(DrFilter[0]["CONSDATE"]).Trim());
                    //Mdl.ConsultTime = DrFilter[0]["CONSTIME"].ToString().Trim();
                    Mdl.ConsultDate = GeneralFunction.GetDate(Convert.ToString(DrFilter[0]["TRANDATE"]).Trim());
                    Mdl.ConsultTime = DrFilter[0]["TRANTIME"].ToString().Trim();
                    //Mdl.PACDoneBy = DrFilter.Columns.Contains("OTNOTESNO")) ? DrFilter[0]["PACDONEBY"].ToString().Trim() == "" ? "" : (DoctLst.Where(x => x.Value == DrFilter[0]["PACDONEBY"].ToString().Trim()).Count() > 0 ? DoctLst.Where(x => x.Value == DrFilter[0]["PACDONEBY"].ToString().Trim()).FirstOrDefault().Text : DrFilter[0]["PACDONEBY"].ToString().Trim());
                    //Mdl.PACDoneBy = DrFilter[0].Table.Columns.Contains("PACDONEBY")
                    //                ? (string.IsNullOrWhiteSpace(DrFilter[0]["PACDONEBY"]?.ToString())
                    //                ? "" : (DoctLst.Any(x => x.Value == DrFilter[0]["PACDONEBY"].ToString().Trim())
                    //                ? DoctLst.FirstOrDefault(x => x.Value == DrFilter[0]["PACDONEBY"].ToString().Trim()).Text
                    //                : DrFilter[0]["PACDONEBY"].ToString().Trim()))
                    //                : "";
                }
            }
            if (!FlagFilter)
            {
                Mdl.PlannedSurgeryCodes = LoadDT.Rows[0]["PLANNEDSURGERYCODES"].ToString().Trim();
                Mdl.AdvicedSurgeryDate = GeneralFunction.GetDate(Convert.ToString(LoadDT.Rows[0]["ADVICEDSURGDATE"]).Trim());
                Mdl.SurgBookType = LoadDT.Rows[0]["SURGBOOKTYPE"].ToString().Trim();
            }
            Mdl.Gaction = "V";
            Mdl.TRANNO = LoadDT.Rows[0]["TRANNO"].ToString().Trim();
            Mdl.TRANDT = GeneralFunction.GetDate(Convert.ToString(LoadDT.Rows[0]["TRANDATE"]).Trim());
            Mdl.TRANTM = LoadDT.Rows[0]["CREATEDAT"].ToString().Trim();
            Mdl.MRNO = LoadDT.Rows[0]["MRNO"].ToString().Trim();
            Mdl.PatName = LoadDT.Rows[0]["PATNAME"].ToString().Trim();
            Mdl.PatGender = LoadDT.Rows[0]["GENDER"].ToString().Trim() == "M" ? "Male" : (LoadDT.Rows[0]["GENDER"].ToString().Trim() == "F" ? "Female" : "");
            Mdl.PatAge = LoadDT.Rows[0]["AGE"].ToString().Trim();
            Mdl.AdmDoctor = LoadDT.Rows[0]["ADMISSIONDOCTOR"].ToString().Trim();
            Mdl.ReviewYN = LoadDT.Rows[0]["REVIEWYN"].ToString().Trim();
            Mdl.ReviewDate = GeneralFunction.GetDate(Convert.ToString(LoadDT.Rows[0]["REVIEWDATE"]).Trim());
            Mdl.PatHeight = LoadDT.Rows[0]["HEIGHT"].ToString().Trim();
            Mdl.PatWeight = LoadDT.Rows[0]["WEIGHT"].ToString().Trim();
            Mdl.PatBMI = LoadDT.Rows[0]["BMI"].ToString().Trim();
            Mdl.GeneralCondtion = LoadDT.Rows[0]["GENCONDITION"].ToString().Trim();
            Mdl.BreathPattern = LoadDT.Rows[0]["BREATHPATTERN"].ToString().Trim();
            Mdl.BreathingPatternRemark = LoadDT.Rows[0]["BREATHPATTERNREMARKS"].ToString().Trim();
            Mdl.Orientation = LoadDT.Rows[0]["ORIENTATION"].ToString().Trim();
            Mdl.RespiratoryRate = LoadDT.Rows[0]["RR"].ToString().Trim();
            Mdl.IsPallor = LoadDT.Rows[0]["ISPALLOR"].ToString().Trim();
            Mdl.Pallor = LoadDT.Rows[0]["PALLOR"].ToString().Trim();
            Mdl.IsIcterus = LoadDT.Rows[0]["ISICTERUS"].ToString().Trim();
            Mdl.Icterus = LoadDT.Rows[0]["ICTERUS"].ToString().Trim();
            Mdl.IsCyanosis = LoadDT.Rows[0]["ISCYANOSIS"].ToString().Trim();
            Mdl.Cyanosis = LoadDT.Rows[0]["CYANOSIS"].ToString().Trim();
            Mdl.IsClubbing = LoadDT.Rows[0]["ISCLUBBING"].ToString().Trim();
            Mdl.Clubbing = LoadDT.Rows[0]["CLUBBING"].ToString().Trim();
            Mdl.IsLymphadenopathy = LoadDT.Rows[0]["ISLYMPHADENOPATHY"].ToString().Trim();
            Mdl.Lymphadenopathy = LoadDT.Rows[0]["LYMPHADENOPATHY"].ToString().Trim();
            Mdl.IsPedalEDEMA = LoadDT.Rows[0]["ISPEDALEDEMA"].ToString().Trim();
            Mdl.PedalEDEMA = LoadDT.Rows[0]["PEDALEDEMA"].ToString().Trim();
            Mdl.HydrationStatus = LoadDT.Rows[0]["HYDRATIONSTATUS"].ToString().Trim();
            Mdl.HydrationStatusOther = LoadDT.Rows[0]["HYDRATIONSTATUSOTHER"].ToString().Trim();
            Mdl.IsVenousAccess = LoadDT.Rows[0]["ISVENOUSACCESS"].ToString().Trim();
            Mdl.VenousAccess = LoadDT.Rows[0]["VENOUSACCESS"].ToString().Trim();
            Mdl.METS = LoadDT.Rows[0]["METS"].ToString().Trim();
            Mdl.FunctCapacity = LoadDT.Rows[0]["FUNCTCAPACITY"].ToString().Trim();
            Mdl.IsLRTI = LoadDT.Rows[0]["ISLRTI"].ToString().Trim();
            Mdl.LRTI = LoadDT.Rows[0]["LRTI"].ToString().Trim();
            Mdl.IsURTI = LoadDT.Rows[0]["ISURTI"].ToString().Trim();
            Mdl.URTI = LoadDT.Rows[0]["URTI"].ToString().Trim();
            Mdl.IsFever = LoadDT.Rows[0]["ISFEVER"].ToString().Trim();
            Mdl.Fever = LoadDT.Rows[0]["FEVER"].ToString().Trim();
            Mdl.IsPreAnaestEvalHist = LoadDT.Rows[0]["ISPREANAESTEVALHIST"].ToString().Trim();
            Mdl.PreAnaestEvalHist = LoadDT.Rows[0]["PREANAESTEVALHIST"].ToString().Trim('"');
            Mdl.IsHypertension = LoadDT.Rows[0]["ISHYPERTENSION"].ToString().Trim();
            Mdl.Hypertension = LoadDT.Rows[0]["HYPERTENTION"].ToString().Trim();
            Mdl.IsDiabetesMellitus = LoadDT.Rows[0]["ISDIABETESMELLITUS"].ToString().Trim();
            Mdl.DiabetesMellitus = LoadDT.Rows[0]["DIABETESMELLITUS"].ToString().Trim();
            //Cardiac
            //Mdl.Cardiac = LoadDT.Rows[0]["CARDIAC"].ToString().Trim();
            //Mdl.CardiacOthrs = LoadDT.Rows[0]["CARDIACOTHERS"].ToString().Trim();

            Mdl.CardiacIHDYN = LoadDT.Rows[0]["CARDIACIHDYN"].ToString().Trim();
            Mdl.CardiacIHDRemarks = LoadDT.Rows[0]["CARDIACIHDRMK"].ToString().Trim();
            Mdl.CardiacCHFYN = LoadDT.Rows[0]["CARDIACCHFYN"].ToString().Trim();
            Mdl.CardiacCHFRemarks = LoadDT.Rows[0]["CARDIACCHFRMK"].ToString().Trim();
            Mdl.CardiacRHDYN = LoadDT.Rows[0]["CARDIACRHDYN"].ToString().Trim();
            Mdl.CardiacRHDRemarks = LoadDT.Rows[0]["CARDIACRHDRMK"].ToString().Trim();
            Mdl.CardiacTHRYN = LoadDT.Rows[0]["CARDIACTHRYN"].ToString().Trim();
            Mdl.CardiacTHRRemarks = LoadDT.Rows[0]["CARDIACTHRRMK"].ToString().Trim();
            Mdl.NYHA = LoadDT.Rows[0]["NYHA"].ToString().Trim();
            Mdl.ECOG = LoadDT.Rows[0]["ECOG"].ToString().Trim();
            Mdl.Respiratory = LoadDT.Rows[0]["RESPIRATORY"].ToString().Trim();
            Mdl.MMRC = LoadDT.Rows[0]["MMRC"].ToString().Trim();
            //Nervous System
            Mdl.NervsousSys = LoadDT.Rows[0]["NERVSOUSSYS"].ToString().Trim();
            Mdl.NervsousSysOthrs = LoadDT.Rows[0]["NERVSOUSSYSTHERS"].ToString().Trim();
            Mdl.NervSysEpilepsyYN = LoadDT.Rows[0]["NERVSYSEPILEPSYYN"].ToString().Trim();
            Mdl.NervSysEpilepsyRemarks = LoadDT.Rows[0]["NERVSYSEPILEPSYRMK"].ToString().Trim();
            Mdl.NervSysStrokeYN = LoadDT.Rows[0]["NERVSYSSTROKEYN"].ToString().Trim();
            Mdl.NervSysStrokeRemarks = LoadDT.Rows[0]["NERVSYSSTROKERMK"].ToString().Trim();
            Mdl.NervSysOtherYN = LoadDT.Rows[0]["NERVSYSOTHERYN"].ToString().Trim();
            Mdl.NervSysOtherRemarks = LoadDT.Rows[0]["NERVSYSOTHERRMK"].ToString().Trim();
            //Renal
            //Mdl.Renal = LoadDT.Rows[0]["RENAL"].ToString().Trim();
            //Mdl.RenalOthrs = LoadDT.Rows[0]["RENALOTHERS"].ToString().Trim();
            Mdl.RenalAKIYN = LoadDT.Rows[0]["RENALAKIYN"].ToString().Trim();
            Mdl.RenalAKIRemarks = LoadDT.Rows[0]["RENALAKIRMK"].ToString().Trim();
            Mdl.RenalCKDYN = LoadDT.Rows[0]["RENALCKDYN"].ToString().Trim();
            Mdl.RenalCKDRemarks = LoadDT.Rows[0]["RENALCKDRMK"].ToString().Trim();
            Mdl.RenalOtherYN = LoadDT.Rows[0]["RENALOTHERYN"].ToString().Trim();
            Mdl.RenalOtherRemarks = LoadDT.Rows[0]["RENALOTHERRMK"].ToString().Trim();

            //Respiratory
            Mdl.RespiAsthmaYN = LoadDT.Rows[0]["RESPIASTHAMAYN"].ToString().Trim();
            Mdl.RespiAsthmaRemarks = LoadDT.Rows[0]["RESPIASTHAMARMK"].ToString().Trim();
            Mdl.RespiTBYN = LoadDT.Rows[0]["RESPITBYN"].ToString().Trim();
            Mdl.RespiTBRemarks = LoadDT.Rows[0]["RESPITBRMK"].ToString().Trim();
            Mdl.RespiCOPDYN = LoadDT.Rows[0]["RESPICOPDYN"].ToString().Trim();
            Mdl.RespiCOPDRemarks = LoadDT.Rows[0]["RESPICOPDRMK"].ToString().Trim();

            Mdl.IsThyroidDisorder = LoadDT.Rows[0]["ISTHYROIDDISORDER"].ToString().Trim();
            Mdl.ThyroidDisorder = LoadDT.Rows[0]["THYROIDDISORDER"].ToString().Trim();
            Mdl.IsChemotherapy = LoadDT.Rows[0]["ISCHEMOTHERAPY"].ToString().Trim();
            Mdl.Chemotherapy = LoadDT.Rows[0]["CHEMOTHERAPY"].ToString().Trim();
            Mdl.IsRadiotherapy = LoadDT.Rows[0]["ISRADIOTHERAPY"].ToString().Trim();
            Mdl.Radiotherapy = LoadDT.Rows[0]["RADIOTHERAPY"].ToString().Trim();
            Mdl.IsAntHOSurgery = LoadDT.Rows[0]["ISANTHOSURGERY"].ToString().Trim();
            Mdl.AnyHOSurg = LoadDT.Rows[0]["ANYHOSURGERY"].ToString().Trim('"');
            Mdl.BloodRelated = LoadDT.Rows[0]["BLOODRELATED"].ToString().Trim();
            Mdl.BloodRelAnaYN = LoadDT.Rows[0]["BLOODRELANAYN"].ToString().Trim();
            Mdl.BloodRelAnaRemarks = LoadDT.Rows[0]["BLOODRELANARMK"].ToString().Trim();
            Mdl.BloodRelHoYN = LoadDT.Rows[0]["BLOODRELHOYN"].ToString().Trim();
            Mdl.BloodRelHoRemarks = LoadDT.Rows[0]["BLOODRELHORMK"].ToString().Trim();
            //Drug/snak/ScorpionBite
            //Mdl.IsDrugSnakeScorpionBite = LoadDT.Rows[0]["ISDRUGSNAKESCORPIONBITE"].ToString().Trim();
            //Mdl.DrugBite = LoadDT.Rows[0]["DRUGSNAKEBITE"].ToString().Trim();

            Mdl.DrugAllergyYN = LoadDT.Rows[0]["DRUGALLERYYN"].ToString().Trim();
            Mdl.DrugAllergyRemarks = LoadDT.Rows[0]["DRUGALLERYRMK"].ToString().Trim();
            Mdl.SnakeBiteYN = LoadDT.Rows[0]["SNAKEBITEYN"].ToString().Trim();
            Mdl.SnakeBiteRemarks = LoadDT.Rows[0]["SNAKEBITERMK"].ToString().Trim();
            Mdl.ScorpionBiteYN = LoadDT.Rows[0]["SCORPIONBITEYN"].ToString().Trim();
            Mdl.ScorpionBiteRemarks = LoadDT.Rows[0]["SCORPIONBITERMK"].ToString().Trim();

            Mdl.IsAnyRevlMediHist = LoadDT.Rows[0]["ISANYREVLMEDIHIST"].ToString().Trim();
            Mdl.OtherMedicalHist = LoadDT.Rows[0]["OTHMEDHISTORY"].ToString().Trim('"');
            Mdl.Obesity = LoadDT.Rows[0]["OBESITY"].ToString().Trim();
            Mdl.Drugs = LoadDT.Rows[0]["DRUGS"].ToString().Trim();
            Mdl.Alcohol = LoadDT.Rows[0]["ALCOHOL"].ToString().Trim();
            Mdl.BetalNut = LoadDT.Rows[0]["BETALNUT"].ToString().Trim();
            Mdl.Tobacco = LoadDT.Rows[0]["TOBACCO"].ToString().Trim();
            Mdl.Smoking = LoadDT.Rows[0]["SMOKING"].ToString().Trim();
            Mdl.NARES = LoadDT.Rows[0]["NARES"].ToString().Trim();
            Mdl.NASALSeptum = LoadDT.Rows[0]["NASALSEPTUM"].ToString().Trim();
            Mdl.MouthOpen = LoadDT.Rows[0]["MOUTHOPEN"].ToString().Trim();
            //Teeth
            //Mdl.Teeth = LoadDT.Rows[0]["TEETH"].ToString().Trim();

            Mdl.TeethNormalYN = LoadDT.Rows[0]["TEETHNORMALYN"].ToString().Trim();
            Mdl.TeethNormalRemarks = LoadDT.Rows[0]["TEETHNORMALRMK"].ToString().Trim();
            Mdl.TeethEdenYN = LoadDT.Rows[0]["TEETHEDENYN"].ToString().Trim();
            Mdl.TeethEdenRemarks = LoadDT.Rows[0]["TEETHEDENRMK"].ToString().Trim();
            Mdl.TeethProRemarks = LoadDT.Rows[0]["TEETHPRORMK"].ToString().Trim();
            Mdl.TeethProYN = LoadDT.Rows[0]["TEETHPROYN"].ToString().Trim();
            Mdl.TeethArtiYN = LoadDT.Rows[0]["TEETHARTIYN"].ToString().Trim();
            Mdl.TeethArtiRemarks = LoadDT.Rows[0]["TEETHARTIRMK"].ToString().Trim();
            Mdl.TeethBuckYN = LoadDT.Rows[0]["TEETHBUCKYN"].ToString().Trim();
            Mdl.TeethBuckRemarks = LoadDT.Rows[0]["TEETHBUCKRMK"].ToString().Trim();
            Mdl.TeethLooseYN = LoadDT.Rows[0]["TEETHLOOSEYN"].ToString().Trim();
            Mdl.TeethLooseRemarks = LoadDT.Rows[0]["TEETHLOOSERMK"].ToString().Trim();

            Mdl.Mallampati = LoadDT.Rows[0]["MALLAMPATI"].ToString().Trim();
            Mdl.MallampattiRemark = LoadDT.Rows[0]["MALLAMPATTIREMARK"].ToString().Trim();
            Mdl.Jawsliding = LoadDT.Rows[0]["JAWSLIDING"].ToString().Trim();
            Mdl.Trismus = LoadDT.Rows[0]["TRISMUS"].ToString().Trim();
            Mdl.ThyromentalDisorder = LoadDT.Rows[0]["THYROMENTALDISORDER"].ToString().Trim();
            Mdl.Neck = LoadDT.Rows[0]["NECK"].ToString().Trim();
            Mdl.Spine = LoadDT.Rows[0]["SPINE"].ToString().Trim();
            Mdl.IsTracheostomy = LoadDT.Rows[0]["ISTRACHEOSTOMY"].ToString().Trim();
            Mdl.Tracheostomy = LoadDT.Rows[0]["TRACHEOSTOMY"].ToString().Trim();
            Mdl.Airwaycomment = LoadDT.Rows[0]["AIRWAYCOMMENT"].ToString().Trim();
            Mdl.CardiovascularSys = LoadDT.Rows[0]["CARDIOVASCULARSYS"].ToString().Trim().Trim('"');
            Mdl.RespiratorySys = LoadDT.Rows[0]["RESPIRATORYSYS"].ToString().Trim().Trim('"');
            Mdl.AdbominalSys = LoadDT.Rows[0]["ABDOMINALSYS"].ToString().Trim().Trim('"');
            Mdl.CentralNervSys = LoadDT.Rows[0]["CENTRALNERVSYS"].ToString().Trim().Trim('"');
            Mdl.ARISCATNAYN = LoadDT.Rows[0]["ARISCATNAYN"].ToString().Trim();//
            Mdl.ARIAge = LoadDT.Rows[0]["ARIAGE"].ToString().Trim();
            Mdl.PreOPSPO2 = LoadDT.Rows[0]["PREOPSPO2"].ToString().Trim();
            Mdl.RespInfct1Month = LoadDT.Rows[0]["RESPINFCT1MONTH"].ToString().Trim();
            Mdl.PreOPHb = LoadDT.Rows[0]["PREOPHB"].ToString().Trim();
            Mdl.Incision = LoadDT.Rows[0]["INCISION"].ToString().Trim();
            Mdl.Surgery = LoadDT.Rows[0]["SURGERY"].ToString().Trim();
            Mdl.EmgProcedure = LoadDT.Rows[0]["EMGPROCEDURE"].ToString().Trim();
            Mdl.RiskCatg = LoadDT.Rows[0]["RISKCATG"].ToString().Trim();
            Mdl.PPCRate = LoadDT.Rows[0]["PPCRATE"].ToString().Trim();
            Mdl.REVLEENAYN = LoadDT.Rows[0]["REVLEENAYN"].ToString().Trim();//
            Mdl.ReviLeeCardiIndx = LoadDT.Rows[0]["REVILEECARDILINDX"].ToString().Trim();
            Mdl.ReviLeeClass = LoadDT.Rows[0]["REVILEECLASS"].ToString().Trim();
            Mdl.ReviLeeCardiEvent = LoadDT.Rows[0]["REVILEECARDIEVENT"].ToString().Trim();
            Mdl.CHILDPUGHNAYN = LoadDT.Rows[0]["CHILDPUGHNAYN"].ToString().Trim();//
            Mdl.Encephalopathy = LoadDT.Rows[0]["ENCEPHALOPATHY"].ToString().Trim();
            Mdl.Ascites = LoadDT.Rows[0]["ASCITES"].ToString().Trim();
            Mdl.Bilirubin = LoadDT.Rows[0]["BILIRUBIN"].ToString().Trim();
            Mdl.Albumin = LoadDT.Rows[0]["ALBUMIN"].ToString().Trim();
            Mdl.INR = LoadDT.Rows[0]["INR"].ToString().Trim();
            Mdl.ChildPughClass = LoadDT.Rows[0]["CHILDPUGHCLASS"].ToString().Trim();
            Mdl.ChildPughPoints = LoadDT.Rows[0]["CHILDPUGHPOINTS"].ToString().Trim();
            Mdl.SpecialityReference = LoadDT.Rows[0]["SPECIALITYREFERENCE"].ToString().Trim('"');
            Mdl.ASAPhysicalStatus = LoadDT.Rows[0]["ASAPHYSICALSTATUS"].ToString().Trim();
            Mdl.ASAFitnessStatus = LoadDT.Rows[0]["ASAFITNESSSTATUS"].ToString().Trim();
            Mdl.ASADate = GeneralFunction.GetDate(Convert.ToString(LoadDT.Rows[0]["ASADATE"]).Trim());
            Mdl.ASATime = GeneralFunction.ConvertTo24HourFormat(Convert.ToString(LoadDT.Rows[0]["ASATIME"])).ToString().Trim();
            Mdl.AnaestAdviceOperativeOrder = LoadDT.Rows[0]["ANAESTADVICEOPERATIVEORDER"].ToString().Trim('"');
            Mdl.CREATEDBY = LoadDT.Rows[0]["CREATEDBY"].ToString().Trim();
            Mdl.AneasthTypeCode = LoadDT.Rows[0]["ANESTHTYPE"].ToString().Trim();
            Mdl.PreOPMed = LoadDT.Rows[0]["PREOPMED"].ToString().Trim('"');
            Mdl.Induction = LoadDT.Rows[0]["INDUCTION"].ToString().Trim('"');
            Mdl.Maintenance = LoadDT.Rows[0]["MAINTENANCE"].ToString().Trim('"');
            Mdl.PONV = LoadDT.Rows[0]["PONV"].ToString().Trim('"');
            Mdl.Notes = LoadDT.Rows[0]["NOTES"].ToString().Trim('"');
            //PRIYANKA 19/11/2025
            Mdl.ASARiskLevel = LoadDT.Rows[0]["ASARISKLEVEL"].ToString().Trim();
            Mdl.IncisionOther = LoadDT.Rows[0]["INCISIONOTHR"].ToString().Trim();
            //END
            Mdl.ASARemarks = LoadDT.Rows[0]["ASAREMARKS"].ToString().Trim();
            Mdl.OTNotesNo = LoadDT.Rows[0]["OTNOTESNO"].ToString().Trim();
            Mdl.ASAPhysicalStatusEYN = LoadDT.Rows[0]["ASAPHYSICALSTATUSEYN"].ToString().Trim();//priyanka 21/03/2026
            Mdl.PACDoneBy = LoadDT.Columns.Contains("VERIFIEDBY")
                                    ? (string.IsNullOrWhiteSpace(LoadDT.Rows[0]["VERIFIEDBY"]?.ToString())
                                    ? "" : (DoctLst.Any(x => x.Value == LoadDT.Rows[0]["VERIFIEDBY"].ToString().Trim())
                                    ? DoctLst.FirstOrDefault(x => x.Value == LoadDT.Rows[0]["VERIFIEDBY"].ToString().Trim()).Text
                                    : LoadDT.Rows[0]["VERIFIEDBY"].ToString().Trim()))
                                    : "";
        }

        public void BindInvstData(PACMdl Mdl, DataTable TableResult, DataSet Load)
        {
            TableResult.Columns.Add("INVDATE");
            TableResult.Columns.Add("INVINHOUSEDATE");
            TableResult.Columns.Add("TESTCODE");
            TableResult.Columns.Add("INVESTCODE");
            TableResult.Columns.Add("INVESTDESC");
            TableResult.Columns.Add("RESULTTYPE");
            TableResult.Columns.Add("SEQNO");
            TableResult.Columns.Add("RESULTDT");
            TableResult.Columns.Add("INRESULTDT");
            TableResult.Columns.Add("TESTNAME");
            TableResult.Columns.Add("TRANNO");
            if (Load.Tables.Count > 3 && Load.Tables[3].Rows.Count > 0)
            {
                OncologyEMR.LabServRef.LaboratoryClient LabServ = new OncologyEMR.LabServRef.LaboratoryClient();

                DataTable ADVTESTDT = new DataTable();
                ADVTESTDT = Load.Tables[3];
                Array AdvTestArry = (from row1 in ADVTESTDT.AsEnumerable()
                                     orderby Convert.ToInt32(row1["SEQNO"]) ascending
                                     select new
                                     {
                                         SEQNO = row1["SEQNO"],
                                         TESTCODE = row1["TESTCODE"],
                                         TESTNAME = row1["TESTNAME"],
                                         CHECKED = "Y",
                                         TRANYN = "Y",
                                         TRANNO = row1["TRANNO"]
                                     }).ToArray();
                Mdl.InvstData = Newtonsoft.Json.JsonConvert.SerializeObject(AdvTestArry);

                foreach (DataRow Dr in ADVTESTDT.Rows)
                {
                    string TestCode = ("" + Dr["TESTCODE"]).ToString().Trim();
                    string TestNM = ("" + Dr["TESTNAME"]).ToString().Trim();
                    string xmlData = LabServ.GetInvestigDataByTestCode(TestCode);
                    bool TestRowFlag = true;
                    if (!string.IsNullOrEmpty(xmlData))
                    {
                        DataSet ds = new DataSet();
                        ds.ReadXml(new XmlTextReader(new StringReader(xmlData)));
                        string UnitCode = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'").Count() > 0)
                        {
                            TestRowFlag = false;
                            foreach (DataRow DrTest in ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'"))
                            {
                                string SInvstCode = ("" + DrTest["INVESTCODE"]).ToString().Trim();
                                string SInvstName = ("" + DrTest["INVESTDESC"]).ToString().Trim();
                                string SResultType = ("" + DrTest["RESULTYPE"]).ToString().Trim();
                                string SSeqNo = ("" + DrTest["SEQUENCE"]).ToString().Trim();
                                string InhouseResult = "";
                                string OutSideResult = "";
                                string TestInvstDate = "";
                                string TestInvstInDate = "";
                                bool InOutFlag = false;
                                if (Load.Tables.Count > 2 && Load.Tables[2].Rows.Count > 0)
                                {
                                    DataRow[] FilterOutside = Load.Tables[2].Select("TESTCODE = '" + TestCode + "' AND INVSETCODE='" + SInvstCode + "'");
                                    foreach (DataRow DROut in FilterOutside)
                                    {
                                        InOutFlag = true;
                                        DataRow FRow = TableResult.NewRow();
                                        FRow["INVDATE"] = DROut["INVDATE"].ToString().Trim();
                                        FRow["INVINHOUSEDATE"] = TestInvstInDate;
                                        FRow["TESTCODE"] = TestCode;
                                        FRow["TESTNAME"] = TestNM;
                                        FRow["INVESTCODE"] = SInvstCode;
                                        FRow["INVESTDESC"] = SInvstName;
                                        FRow["RESULTTYPE"] = SResultType;
                                        FRow["SEQNO"] = SSeqNo;
                                        FRow["RESULTDT"] = DROut["RESULTDT"].ToString().Trim();
                                        FRow["INRESULTDT"] = InhouseResult;
                                        FRow["TRANNO"] = DROut["TRANNO"].ToString().Trim();
                                        TableResult.Rows.Add(FRow);
                                    }
                                }

                                if (Load.Tables.Count > 4 && Load.Tables[4].Rows.Count > 0)
                                {
                                    DataRow[] FilterInside = Load.Tables[4].Select("TESTCODE = '" + TestCode + "' AND INVESTCODE='" + SInvstCode + "'");
                                    foreach (DataRow DRIn in FilterInside)
                                    {
                                        InOutFlag = true;
                                        DataRow FRow = TableResult.NewRow();
                                        FRow["INVDATE"] = TestInvstDate;
                                        FRow["INVINHOUSEDATE"] = DRIn["RESULTDATE"].ToString().Trim();
                                        FRow["TESTCODE"] = TestCode;
                                        FRow["TESTNAME"] = TestNM;
                                        FRow["INVESTCODE"] = SInvstCode;
                                        FRow["INVESTDESC"] = SInvstName;
                                        FRow["RESULTTYPE"] = SResultType;
                                        FRow["SEQNO"] = SSeqNo;
                                        FRow["RESULTDT"] = OutSideResult;
                                        FRow["INRESULTDT"] = DRIn["RESULTDT"].ToString().Trim();
                                        TableResult.Rows.Add(FRow);
                                    }
                                }
                                if (SResultType == "H" || InOutFlag == false)
                                {
                                    DataRow FRow = TableResult.NewRow();
                                    FRow["INVDATE"] = TestInvstDate;
                                    FRow["INVINHOUSEDATE"] = TestInvstInDate;
                                    FRow["TESTCODE"] = TestCode;
                                    FRow["TESTNAME"] = TestNM;
                                    FRow["INVESTCODE"] = SInvstCode;
                                    FRow["INVESTDESC"] = SInvstName;
                                    FRow["RESULTTYPE"] = SResultType;
                                    FRow["SEQNO"] = SSeqNo;
                                    FRow["RESULTDT"] = OutSideResult;
                                    FRow["INRESULTDT"] = InhouseResult;
                                    string TestTranNo = "";
                                    DataRow[] DRAdvTest = Load.Tables[3].Select("TESTCODE = '" + TestCode + "'");
                                    if (DRAdvTest.Length > 0)
                                    {
                                        TestTranNo = DRAdvTest[0]["TRANNO"].ToString().Trim();
                                    }
                                    FRow["TRANNO"] = TestTranNo;
                                    TableResult.Rows.Add(FRow);
                                }
                            }
                        }
                    }
                    if (TestRowFlag)
                    {
                        string InhouseResult = "";
                        string OutSideResult = "";
                        string TestInvstDate = "";
                        string TestInvstInDate = "";
                        if (Load.Tables.Count > 2 && Load.Tables[2].Rows.Count > 0)
                        {
                            DataRow[] FilterOutside = Load.Tables[2].Select("TESTCODE = '" + TestCode + "'");
                            foreach (DataRow DROut in FilterOutside)
                            {
                                DataRow FRow = TableResult.NewRow();
                                FRow["INVDATE"] = DROut["INVDATE"].ToString().Trim();
                                FRow["INVINHOUSEDATE"] = TestInvstInDate;
                                FRow["TESTCODE"] = TestCode;
                                FRow["TESTNAME"] = TestNM;
                                FRow["INVESTCODE"] = "";
                                FRow["INVESTDESC"] = ("" + Dr["TESTNAME"]).ToString().Trim();
                                FRow["RESULTTYPE"] = "V";
                                FRow["SEQNO"] = "";
                                FRow["RESULTDT"] = DROut["RESULTDT"].ToString().Trim();
                                FRow["INRESULTDT"] = InhouseResult;
                                FRow["TRANNO"] = DROut["TRANNO"].ToString().Trim();
                                TableResult.Rows.Add(FRow);
                            }
                        }

                        if (Load.Tables.Count > 4 && Load.Tables[4].Rows.Count > 0)
                        {
                            DataRow[] FilterInside = Load.Tables[4].Select("TESTCODE = '" + TestCode + "'");
                            foreach (DataRow DROut in FilterInside)
                            {
                                DataRow FRow = TableResult.NewRow();
                                FRow["INVDATE"] = TestInvstDate;
                                FRow["INVINHOUSEDATE"] = DROut["RESULTDATE"].ToString().Trim();
                                FRow["TESTCODE"] = TestCode;
                                FRow["TESTNAME"] = TestNM;
                                FRow["INVESTCODE"] = "";
                                FRow["INVESTDESC"] = ("" + Dr["TESTNAME"]).ToString().Trim();
                                FRow["RESULTTYPE"] = "V";
                                FRow["SEQNO"] = "";
                                FRow["RESULTDT"] = OutSideResult;
                                FRow["INRESULTDT"] = DROut["RESULTDT"].ToString().Trim();
                                TableResult.Rows.Add(FRow);
                            }
                        }
                    }
                }
            }
        }

        public object GetInvstListData(string TestCode)
        {
            OncologyEMR.LabServRef.LaboratoryClient LabServ = new OncologyEMR.LabServRef.LaboratoryClient();
            List<object> allJsonData = new List<object>();
            if (!string.IsNullOrEmpty(TestCode))
            {
                DataTable DT = JsonConvert.DeserializeObject<DataTable>(TestCode);
                foreach (DataRow DR in DT.Rows)
                {
                    string STestCode = DR["TESTCODE"].ToString().Trim();
                    string xmlData = LabServ.GetInvestigDataByTestCode(STestCode);
                    if (!string.IsNullOrEmpty(xmlData))
                    {
                        DataSet ds = new DataSet();
                        ds.ReadXml(new XmlTextReader(new StringReader(xmlData)));
                        string UnitCode = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'").Count() > 0)
                        {

                            var jsonData = (from DataRow row in ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'")
                                            select new
                                            {
                                                INVDATE = "",
                                                TESTCODE = row["TESTCODE"].ToString().Trim(),
                                                INVSETCODE = row["INVESTCODE"].ToString().Trim(),
                                                INVSETDESC = row["INVESTDESC"].ToString().Trim(),
                                                RESULTTYPE = row["RESULTYPE"].ToString().Trim(),
                                                SEQNO = row["SEQUENCE"].ToString().Trim(),
                                                RESULTDT = "",
                                                INRESULTDT = ""
                                            }).ToList<object>();
                            allJsonData.AddRange(jsonData);
                        }
                    }
                }
            }

            return allJsonData;
        }

        public string SavepreAnaestCheckup(PACMdl Mdl)
        {
            BL_PAC BL = new BL_PAC();
            BL.SurgAdvConsNo = Mdl.SurgAdvConsNo;
            BL.RefPACTranNo = Mdl.RefPACTranNo;
            BL.TRANNO = Mdl.TRANNO;
            BL.MRNO = Mdl.MRNO;
            BL.ReviewYN = ("" + Mdl.ReviewYN) == "" ? "N" : Mdl.ReviewYN;
            BL.ReviewDate = GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.ReviewDate), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            BL.Weight = Convert.ToDecimal(Mdl.PatWeight == "" || Mdl.PatWeight == null ? "0" : Mdl.PatWeight);
            BL.Height = Convert.ToDecimal(Mdl.PatHeight == "" || Mdl.PatHeight == null ? "0" : Mdl.PatHeight);
            BL.BMI = Convert.ToDecimal(Mdl.PatBMI == "" || Mdl.PatBMI == null ? "0" : Mdl.PatBMI);
            //Adviced Info
            BL.AdvicedSurgeryDate = GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.AdvicedSurgeryDate), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            BL.PlannedSurgeryCodes = Mdl.PlannedSurgeryCodes;
            BL.SurgBookType = Mdl.SurgBookType;
            //General Physical Examination
            BL.GeneralCondtion = Mdl.GeneralCondtion;
            BL.BreathPattern = Mdl.BreathPattern;
            BL.BreathingPatternRemark = Mdl.BreathingPatternRemark;
            BL.Orientation = Mdl.Orientation;
            BL.RespiratoryRate = Mdl.RespiratoryRate;
            BL.IsPallor = Mdl.IsPallor;
            BL.Pallor = Mdl.Pallor;
            BL.IsIcterus = Mdl.IsIcterus;
            BL.Icterus = Mdl.Icterus;
            BL.IsCyanosis = Mdl.IsCyanosis;
            BL.Cyanosis = Mdl.Cyanosis;
            BL.IsClubbing = Mdl.IsClubbing;
            BL.Clubbing = Mdl.Clubbing;
            BL.IsLymphadenopathy = Mdl.IsLymphadenopathy;
            BL.Lymphadenopathy = Mdl.Lymphadenopathy;
            BL.IsPedalEDEMA = Mdl.IsPedalEDEMA;
            BL.PedalEDEMA = Mdl.PedalEDEMA;
            BL.HydrationStatus = Mdl.HydrationStatus;
            BL.HydrationStatusOther = Mdl.HydrationStatusOther;
            BL.IsVenousAccess = Mdl.IsVenousAccess;
            BL.VenousAccess = Mdl.VenousAccess;
            BL.METS = Mdl.METS;
            BL.FunctCapacity = Mdl.FunctCapacity;
            BL.IsLRTI = Mdl.IsLRTI;
            BL.LRTI = Mdl.LRTI;
            BL.IsURTI = Mdl.IsURTI;
            BL.URTI = Mdl.URTI;
            BL.IsFever = Mdl.IsFever;
            BL.Fever = Mdl.Fever;
            BL.IsPreAnaestEvalHist = Mdl.IsPreAnaestEvalHist;
            BL.PreAnaestEvalHist = Mdl.PreAnaestEvalHist;
            //Comorbidities and Treatment History
            BL.IsHypertension = Mdl.IsHypertension;
            BL.Hypertension = Mdl.Hypertension;
            BL.IsDiabetesMellitus = Mdl.IsDiabetesMellitus;
            BL.DiabetesMellitus = Mdl.DiabetesMellitus;
            //BL.Cardiac = Mdl.Cardiac;
            //BL.CardiacOthrs = Mdl.CardiacOthrs;
            BL.CardiacIHDYN = Mdl.CardiacIHDYN;
            BL.CardiacIHDRemarks = Convert.ToString(Mdl.CardiacIHDRemarks);
            BL.CardiacCHFYN = Mdl.CardiacCHFYN;
            BL.CardiacCHFRemarks = Convert.ToString(Mdl.CardiacCHFRemarks);
            BL.CardiacRHDYN = Mdl.CardiacRHDYN;
            BL.CardiacRHDRemarks = Convert.ToString(Mdl.CardiacRHDRemarks);
            BL.CardiacTHRYN = Mdl.CardiacTHRYN;
            BL.CardiacTHRRemarks = Convert.ToString(Mdl.CardiacTHRRemarks);
            BL.NYHA = Mdl.NYHA;
            BL.ECOG = Mdl.ECOG;
            //BL.Respiratory = Mdl.Respiratory;
            BL.RespiAsthmaYN = Mdl.RespiAsthmaYN;
            BL.RespiAsthmaRemarks = Convert.ToString(Mdl.RespiAsthmaRemarks);
            BL.RespiTBYN = Mdl.RespiTBYN;
            BL.RespiTBRemarks = Convert.ToString(Mdl.RespiTBRemarks);
            BL.RespiCOPDYN = Mdl.RespiCOPDYN;
            BL.RespiCOPDRemarks = Convert.ToString(Mdl.RespiCOPDRemarks);
            BL.MMRC = Mdl.MMRC;
            //BL.NervsousSys = Mdl.NervsousSys;
            //BL.NervsousSysOthrs = Mdl.NervsousSysOthrs;
            BL.NervSysEpilepsyYN = Mdl.NervSysEpilepsyYN;
            BL.NervSysEpilepsyRemarks = Convert.ToString(Mdl.NervSysEpilepsyRemarks);
            BL.NervSysStrokeYN = Mdl.NervSysStrokeYN;
            BL.NervSysStrokeRemarks = Convert.ToString(Mdl.NervSysStrokeRemarks);
            BL.NervSysOtherYN = Mdl.NervSysOtherYN;
            BL.NervSysOtherRemarks = Convert.ToString(Mdl.NervSysOtherRemarks);
            //BL.Renal = Mdl.Renal;
            //BL.RenalOthrs = Mdl.RenalOthrs;
            BL.RenalAKIYN = Mdl.RenalAKIYN;
            BL.RenalAKIRemarks = Convert.ToString(Mdl.RenalAKIRemarks);
            BL.RenalCKDYN = Mdl.RenalCKDYN;
            BL.RenalCKDRemarks = Convert.ToString(Mdl.RenalCKDRemarks);
            BL.RenalOtherYN = Mdl.RenalOtherYN;
            BL.RenalOtherRemarks = Convert.ToString(Mdl.RenalOtherRemarks);
            BL.IsThyroidDisorder = Mdl.IsThyroidDisorder;
            BL.ThyroidDisorder = Mdl.ThyroidDisorder;
            BL.IsChemotherapy = Mdl.IsChemotherapy;
            BL.Chemotherapy = Mdl.Chemotherapy;
            BL.IsRadiotherapy = Mdl.IsRadiotherapy;
            BL.Radiotherapy = Mdl.Radiotherapy;
            BL.IsAntHOSurgery = Mdl.IsAntHOSurgery;
            BL.AnyHOSurg = Mdl.AnyHOSurg;
            //BL.BloodRelated = Mdl.BloodRelated;
            BL.BloodRelAnaYN = Mdl.BloodRelAnaYN;
            BL.BloodRelAnaRemarks = Convert.ToString(Mdl.BloodRelAnaRemarks);
            BL.BloodRelHoYN = Mdl.BloodRelHoYN;
            BL.BloodRelHoRemarks = Convert.ToString(Mdl.BloodRelHoRemarks);

            //drugs/snak bite/Scorpion Sting Bite
            //BL.IsDrugSnakeScorpionBite = Mdl.IsDrugSnakeScorpionBite;
            //BL.DrugBite = Mdl.DrugBite;
            BL.DrugAllergyYN = Mdl.DrugAllergyYN;
            BL.DrugAllergyRemarks = Mdl.DrugAllergyRemarks;
            BL.SnakeBiteYN = Mdl.SnakeBiteYN;
            BL.SnakeBiteRemarks = Mdl.SnakeBiteRemarks;
            BL.ScorpionBiteYN = Mdl.ScorpionBiteYN;
            BL.ScorpionBiteRemarks = Mdl.ScorpionBiteRemarks;

            BL.IsAnyRevlMediHist = Mdl.IsAnyRevlMediHist;
            BL.OtherMedicalHist = Mdl.OtherMedicalHist;
            BL.Obesity = Mdl.Obesity;
            //Substance Abuse History
            BL.Drugs = Mdl.Drugs;
            BL.Alcohol = Mdl.Alcohol;
            BL.BetalNut = Mdl.BetalNut;
            BL.Tobacco = Mdl.Tobacco;
            BL.Smoking = Mdl.Smoking;
            //Airway Assesment
            BL.NARES = Mdl.NARES;
            BL.NASALSeptum = Mdl.NASALSeptum;
            BL.MouthOpen = Mdl.MouthOpen;
            //BL.Teeth = Mdl.Teeth;
            BL.TeethNormalYN = Mdl.TeethNormalYN;
            BL.TeethNormalRemarks = Convert.ToString(Mdl.TeethNormalRemarks);
            BL.TeethEdenYN = Mdl.TeethEdenYN;
            BL.TeethEdenRemarks = Convert.ToString(Mdl.TeethEdenRemarks);
            BL.TeethProYN = Mdl.TeethProYN;
            BL.TeethProRemarks = Convert.ToString(Mdl.TeethProRemarks);
            BL.TeethArtiYN = Mdl.TeethArtiYN;
            BL.TeethArtiRemarks = Convert.ToString(Mdl.TeethArtiRemarks);
            BL.TeethBuckYN = Mdl.TeethBuckYN;
            BL.TeethBuckRemarks = Convert.ToString(Mdl.TeethBuckRemarks);
            BL.TeethLooseYN = Mdl.TeethLooseYN;
            BL.TeethLooseRemarks = Convert.ToString(Mdl.TeethLooseRemarks);
            BL.Mallampati = Mdl.Mallampati;
            BL.MallampattiRemark = Convert.ToString(Mdl.MallampattiRemark);
            BL.Jawsliding = Mdl.Jawsliding;
            BL.Trismus = Mdl.Trismus;
            BL.ThyromentalDisorder = Mdl.ThyromentalDisorder;
            BL.Neck = Mdl.Neck;
            BL.Spine = Mdl.Spine;
            BL.IsTracheostomy = Mdl.IsTracheostomy;
            BL.Tracheostomy = Mdl.Tracheostomy;
            BL.Airwaycomment = Mdl.Airwaycomment;
            //Systemic Examination
            BL.CardiovascularSys = Mdl.CardiovascularSys;
            BL.RespiratorySys = Mdl.RespiratorySys;
            BL.AdbominalSys = Mdl.AdbominalSys;
            BL.CentralNervSys = Mdl.CentralNervSys;
            //ARISCAT Criteria
            BL.ARISCATNAYN = Mdl.ARISCATNAYN;
            BL.ARIAge = Mdl.ARIAge;
            BL.PreOPSPO2 = Mdl.PreOPSPO2;
            BL.RespInfct1Month = Mdl.RespInfct1Month;
            BL.PreOPHb = Mdl.PreOPHb;
            BL.Incision = Mdl.Incision;
            BL.Surgery = Mdl.Surgery;
            BL.EmgProcedure = Mdl.EmgProcedure;
            BL.RiskCatg = Mdl.RiskCatg;
            BL.PPCRate = Mdl.PPCRate;
            //Revised Lee Cardiac Risk
            BL.REVLEENAYN = Mdl.REVLEENAYN;
            BL.ReviLeeCardiIndx = Mdl.ReviLeeCardiIndx;
            BL.ReviLeeClass = Mdl.ReviLeeClass;
            BL.ReviLeeCardiEvent = Mdl.ReviLeeCardiEvent;
            //Child Pugh Turcotte Score
            BL.CHILDPUGHNAYN = Mdl.CHILDPUGHNAYN;
            BL.Encephalopathy = Mdl.Encephalopathy;
            BL.Ascites = Mdl.Ascites;
            BL.Bilirubin = Mdl.Bilirubin;
            BL.Albumin = Mdl.Albumin;
            BL.INR = Mdl.INR;
            BL.ChildPughClass = Mdl.ChildPughClass;
            BL.ChildPughPoints = Mdl.ChildPughPoints;
            //Speciality Reference
            BL.SpecialityReference = Mdl.SpecialityReference;
            //ASA
            BL.ASAPhysicalStatus = Mdl.ASAPhysicalStatus;
            BL.ASAFitnessStatus = Mdl.ASAFitnessStatus;
            BL.ASADate = GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.ASADate), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            BL.ASATime = Mdl.ASATime;
            BL.ASARemarks = "";
            //Anaesthesiologist’s Advice & Preoperative Orders
            BL.AnaestAdviceOperativeOrder = Mdl.AnaestAdviceOperativeOrder;
            //Anaesthesia Plan
            BL.AneasthTypeCode = Mdl.AneasthTypeCode;
            BL.PreOPMed = Mdl.PreOPMed;
            BL.Induction = Mdl.Induction;
            BL.Maintenance = Mdl.Maintenance;
            BL.PONV = Mdl.PONV;
            BL.Notes = Mdl.Notes;
            //XML String
            DataSet DS = new DataSet();
            //Vitals Grid Data  - VitalsData 
            DataTable VitalsDT = new DataTable();
            if (Mdl.VitalsData != null && Mdl.VitalsData != "")
            {
                VitalsDT = JsonConvert.DeserializeObject<DataTable>(Mdl.VitalsData);
                foreach (DataRow DR in VitalsDT.Rows)
                {
                    DR["VITALDATE"] = ("" + DR["VITALDATE"]).ToString().Trim() == "" ? "" : GeneralFunction.GetDateInSpecifiedFormat(("" + DR["VITALDATE"]).ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
            }
            //Investigation Grid Data - InvstData
            DataTable InvstDT = new DataTable();
            if (Mdl.InvstData != null && Mdl.InvstData != "")
            {
                InvstDT = JsonConvert.DeserializeObject<DataTable>(Mdl.InvstData);
            }
            //Outside Result
            DataTable OutSideResultDT = new DataTable();
            if (Mdl.ResultInvstData != null && Mdl.ResultInvstData != "")
            {
                OutSideResultDT = JsonConvert.DeserializeObject<DataTable>(Mdl.ResultInvstData);
                foreach (DataRow DR in OutSideResultDT.Rows)
                {
                    DR["INVDATE"] = GeneralFunction.GetDateInSpecifiedFormat(("" + DR["INVDATE"]).ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
            }
            //Speciality Reference
            DataTable SpecRefDT = new DataTable();
            if (Mdl.SpecialityRefData != null && Mdl.SpecialityRefData != "")
            {
                SpecRefDT = JsonConvert.DeserializeObject<DataTable>(Mdl.SpecialityRefData);
            }
            //Medicine Grid Data - DrugData
            DataTable MedDT = new DataTable();
            if (Mdl.MedGridData != null && Mdl.MedGridData != "")
            {
                MedDT = JsonConvert.DeserializeObject<DataTable>(Mdl.MedGridData);
            }
            VitalsDT.TableName = "TBL";
            InvstDT.TableName = "TBLADVICEDINT";
            OutSideResultDT.TableName = "TBLOUTINTRESULT";
            SpecRefDT.TableName = "TBLREF";
            MedDT.TableName = "TBLMED"; //Pournima 18th July 2025
            DS.DataSetName = "DS";
            DS.Tables.Add(VitalsDT);
            DS.Tables.Add(InvstDT);
            DS.Tables.Add(OutSideResultDT);
            DS.Tables.Add(SpecRefDT);
            DS.Tables.Add(MedDT);
            BL.xmlString = DS.GetXml();
            if (Mdl.Gaction == "N")
                BL.TranMode = 1;
            else if (Mdl.Gaction == "E")
                BL.TranMode = 2;
            else if (Mdl.Gaction == "V")
                BL.TranMode = 5;
            BL.ModuleId = System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            BL.IPAddress = System.Web.HttpContext.Current.Session["MchIPAddress"].ToString();
            BL.CREATEDBY = System.Web.HttpContext.Current.Session["gDoctCode"].ToString();
            //Priyanka 19/11/2025
            BL.IncisionOther = ("" + Mdl.IncisionOther).ToString().Trim();
            BL.ASARiskLevel = ("" + Mdl.ASARiskLevel).ToString().Trim();
            BL.ASARemarks = ("" + Mdl.ASARemarks).ToString().Trim();
            BL.ASAPhysicalStatusE = ("" + Mdl.ASAPhysicalStatusE).ToString().Trim();//priyanka 21/03/2026
            //end
            string Result = oncoClient.SavePACTran(BL);
            return Result;
        }

        public void SetTablePACINFO(PACMdl Mdl, DataTable PACINFO)
        {
            //Patient Info
            PACINFO.Columns.Add("TRANNO");
            PACINFO.Columns.Add("TRANDATE");
            PACINFO.Columns.Add("MRNO");
            PACINFO.Columns.Add("PATIENTNAME");
            PACINFO.Columns.Add("AGE");
            PACINFO.Columns.Add("GENDER");
            PACINFO.Columns.Add("ADMDOCTOR");
            PACINFO.Columns.Add("REVIEWPAC");
            PACINFO.Columns.Add("WEIGHT");
            PACINFO.Columns.Add("HEIGHT");
            PACINFO.Columns.Add("BMI");
            PACINFO.Columns.Add("ANESTHESIOLOGIST");
            //Adviced Info
            PACINFO.Columns.Add("PROCPLANNED");
            PACINFO.Columns.Add("SCHDATESURGRY");
            PACINFO.Columns.Add("NATOFSURGRY");
            //General Physical Examination
            PACINFO.Columns.Add("GENCONDITION");
            PACINFO.Columns.Add("BREATHPATTERN");
            PACINFO.Columns.Add("BREATHREMARK");
            PACINFO.Columns.Add("RESPRATE");
            PACINFO.Columns.Add("ORIENTATION");
            PACINFO.Columns.Add("PALLOR");
            PACINFO.Columns.Add("ICTERUS");
            PACINFO.Columns.Add("CYANOSIS");
            PACINFO.Columns.Add("CLUBBING");
            PACINFO.Columns.Add("LYMPHADENO");
            PACINFO.Columns.Add("PEDALEDEMA");
            PACINFO.Columns.Add("HYDRASTATUS");
            PACINFO.Columns.Add("HYDRASTATUSOTHRS");
            PACINFO.Columns.Add("VENOUSACCESS");
            PACINFO.Columns.Add("METS");
            PACINFO.Columns.Add("FUNCCAPACITY");
            PACINFO.Columns.Add("LRTI");
            PACINFO.Columns.Add("URTI");
            PACINFO.Columns.Add("FEVER");
            PACINFO.Columns.Add("PREANAESTEVALHIST");
            //Comorbidities and Treatment History
            PACINFO.Columns.Add("HYPERTENSION");
            PACINFO.Columns.Add("DIABMELLTUS");
            PACINFO.Columns.Add("CARDIAC");
            PACINFO.Columns.Add("CARDIACREMARK");
            PACINFO.Columns.Add("NYHA");
            PACINFO.Columns.Add("ECOG");
            PACINFO.Columns.Add("REPIRATORY");
            PACINFO.Columns.Add("MMRC");
            PACINFO.Columns.Add("NERVSYSTEM");
            PACINFO.Columns.Add("NERVSYSTEMREMARK");
            PACINFO.Columns.Add("RENAL");
            PACINFO.Columns.Add("RENALREMARK");
            PACINFO.Columns.Add("THYROIDDISORDER");
            PACINFO.Columns.Add("CHEMOTHERAPY");
            PACINFO.Columns.Add("RADIOTHERAPY");
            PACINFO.Columns.Add("ANYHOSURGRY");
            PACINFO.Columns.Add("BLOODRELATED");
            PACINFO.Columns.Add("DRUGBITE");
            PACINFO.Columns.Add("ANYOTHRRELMEDHIST");
            PACINFO.Columns.Add("OBESITYSCORE");
            PACINFO.Columns.Add("OBESITY");

            //PRIYANKA 25/02/2026
            PACINFO.Columns.Add("DRUGALLERGIES");
            PACINFO.Columns.Add("SNAKEBITE");
            PACINFO.Columns.Add("SCORPIONSTINGBITE");

            //Substance Abuse History
            PACINFO.Columns.Add("DRUGS");
            PACINFO.Columns.Add("ALCOHOL");
            PACINFO.Columns.Add("BETALNUT");
            PACINFO.Columns.Add("TOBACCO");
            PACINFO.Columns.Add("SMOKING");
            //Airway Assesment
            PACINFO.Columns.Add("NARES");
            PACINFO.Columns.Add("NASALSEPTUM");
            PACINFO.Columns.Add("MOUTHOPEN");
            PACINFO.Columns.Add("TEETH");
            PACINFO.Columns.Add("MALLAMPATI");
            PACINFO.Columns.Add("MALLAMPATIREMARK");
            PACINFO.Columns.Add("JAWSLIDING");
            PACINFO.Columns.Add("TRISMUS");
            PACINFO.Columns.Add("THYROMENTALDIST");
            PACINFO.Columns.Add("NECK");
            PACINFO.Columns.Add("SPINE");
            PACINFO.Columns.Add("TRACHEOSTOMY");
            PACINFO.Columns.Add("AIRWAYCOMMENTS");
            //Systemic Examination
            PACINFO.Columns.Add("CARDIOSYSTEM");
            PACINFO.Columns.Add("RESPIRATORYSYSTEM");
            PACINFO.Columns.Add("ABDOMINALSYSTEM");
            PACINFO.Columns.Add("CENTRALNERVSYSTEM");
            //ARISCAT Criteria
            PACINFO.Columns.Add("ARISCATNA");
            PACINFO.Columns.Add("ARISCATAGE");
            PACINFO.Columns.Add("PREOPSPO2");
            PACINFO.Columns.Add("RESPINFTONEMONTH");
            PACINFO.Columns.Add("PREOPHB");
            PACINFO.Columns.Add("INCISION");
            PACINFO.Columns.Add("SURGERY");
            PACINFO.Columns.Add("EMGPROCEDURE");
            PACINFO.Columns.Add("TOTAL");
            PACINFO.Columns.Add("RISKCATG");
            PACINFO.Columns.Add("PPCRATE");
            //Revised Lee Cardiac Risk
            PACINFO.Columns.Add("REVLEENA");
            PACINFO.Columns.Add("REVLEECARDIARISKFACT");
            PACINFO.Columns.Add("REVLEECLASS");
            PACINFO.Columns.Add("MAJORCARDIACEVENT");
            //Child Pugh Turcotte Score
            PACINFO.Columns.Add("CHILDPUGHNA");
            PACINFO.Columns.Add("ENCEPHALOPATHY");
            PACINFO.Columns.Add("ASCITES");
            PACINFO.Columns.Add("BILIRUBIN");
            PACINFO.Columns.Add("ALBUMIN");
            PACINFO.Columns.Add("INR");
            PACINFO.Columns.Add("CLASS");
            PACINFO.Columns.Add("POINTS");
            //Speciality Reference
            PACINFO.Columns.Add("SPECIALITYREFERRENCE");
            //ASA
            PACINFO.Columns.Add("PHYSICALSTATUS");
            PACINFO.Columns.Add("FITNESSSTATUS");
            PACINFO.Columns.Add("ASADATE");
            PACINFO.Columns.Add("ASATIME");
            //Anaesthesiologist’s Advice & Preoperative Orders
            PACINFO.Columns.Add("ANAESTHPREOPERATIVEORDER");
            //Anaesthesia Plan
            PACINFO.Columns.Add("ANAESTHESIATYPE");
            PACINFO.Columns.Add("PREOP");
            PACINFO.Columns.Add("INDUCTION");
            PACINFO.Columns.Add("PONV");
            PACINFO.Columns.Add("MAINTENANCE");
            PACINFO.Columns.Add("NOTES");
            PACINFO.Columns.Add("INCISIONOTHER");//PRIYANKA 19/11/2025
            PACINFO.Columns.Add("ASAREMARKS");
            //PRIYANKA 24/02/2026
            //CARDIAC SYSTEM
            PACINFO.Columns.Add("CARDIACIHDYN");
            PACINFO.Columns.Add("CARDIACIHDRMK");
            PACINFO.Columns.Add("CARDIACCHFYN");
            PACINFO.Columns.Add("CARDIACCHFRMK");
            PACINFO.Columns.Add("CARDIACRHDYN");
            PACINFO.Columns.Add("CARDIACRHDRMK");
            PACINFO.Columns.Add("CARDIACTHRYN");
            PACINFO.Columns.Add("CARDIACTHRRMK");

            //DRUG ALLERGIES, SNAKE BITE, SCROPION BITE
            PACINFO.Columns.Add("DRUGALLERGIESRMK");
            PACINFO.Columns.Add("SNAKEBITERMK");
            PACINFO.Columns.Add("SCORPIONSTINGBITERMK");
            PACINFO.Columns.Add("ASAPHYSCIALSTATUSE");//PRIYANKA 21/03/2026
            //END

            var SurgyType = new Dictionary<string, string> { { "R", "Routine" }, { "E", "Emergency" }, { "T", "Tentative" } };
            var GenCondition = new Dictionary<string, string> { { "1", "Good" }, { "2", "Fair" }, { "3", "Poor" } };
            var BreathPatrn = new Dictionary<string, string> { { "1", "Normal" }, { "2", "Tachypnoea" }, { "3", "Bradypnoea" }, { "4", "Obstructed" } };
            var Orientation = new Dictionary<string, string> { { "1", "Normal" }, { "2", "Confused" }, { "3", "Very Poor" }, { "4", "Agitated" } };
            var HydrationStatus = new Dictionary<string, string> { { "W", "Well hydrated" }, { "D", "Dehydrated" }, { "O", "Other" } };
            var METS = new Dictionary<string, string> { { "1", "Less than 4" }, { "2", "4-7" }, { "3", "7-10" }, { "4", "More than 10" } };
            var FunctionalCapacity = new Dictionary<string, string> { { "1", "Poor" }, { "2", "Moderate" }, { "3", "Good" }, { "4", "Excellent" } };
            var Cardiac = new Dictionary<string, string> { { "1", "IHD" }, { "2", "CHF" }, { "3", "RHD" }, { "4", "Others" } };
            var NYHA = new Dictionary<string, string> { { "1", "I" }, { "2", "II" }, { "3", "III" }, { "4", "IV" } };
            var ECOG = new Dictionary<string, string> { { "0", "0" }, { "1", "1" }, { "2", "2" }, { "3", "3" }, { "4", "4" }, { "5", "5" } };
            var Respiratory = new Dictionary<string, string> { { "1", "ASTHMA" }, { "2", "TB" }, { "3", "COPD" } };
            var MMRC = new Dictionary<string, string> { { "0", "0" }, { "1", "1" }, { "2", "2" }, { "3", "3" }, { "4", "4" } };
            var NervousSystem = new Dictionary<string, string> { { "1", "Epilepsy" }, { "2", "Stroke" }, { "3", "Others" } };
            var Renal = new Dictionary<string, string> { { "1", "AKI" }, { "2", "CKD" }, { "3", "Others" } };
            var BloodRelated = new Dictionary<string, string> { { "1", "Anaemia" }, { "2", "H/o Transfusion / Disorders" } };
            var Obesity = new Dictionary<string, string> { { "1", "Snoring" }, { "2", "Tiredness" }, { "3", "Observed Apnoea" }, { "4", "High Blood Pressure" }, { "5", "35 kg/m²" }, { "6", "Age > 50yrs" }, { "7", "Neck Circumference > 40cm" }, { "8", "Male Gender" } };
            var NARES = new Dictionary<string, string> { { "1", "Normal" }, { "2", "Abnormal" } };
            var DeviatedNasalSeptum = new Dictionary<string, string> { { "1", "Normal" }, { "2", "Left" }, { "3", "Right" }, { "4", "Post Surgical" } };
            var MouthOpening = new Dictionary<string, string> { { "1", "<3cm" }, { "2", "3-4cm" }, { "3", "> 4cm" } };
            var Teeth = new Dictionary<string, string> { { "1", "Normal" }, { "2", "Edentulous" }, { "3", "Protruding" }, { "4", "Artificial" }, { "5", "Buck" }, { "6", "Loose Tooth" } };
            var Mallampati = new Dictionary<string, string> { { "1", "0" }, { "2", "1" }, { "3", "2" }, { "4", "3" }, { "5", "4" }, { "6", "NA" } };
            var JawSliding = new Dictionary<string, string> { { "1", "+1" }, { "2", "0" }, { "3", "-1" } };
            var Trismus = new Dictionary<string, string> { { "1", "Grade 0 (>35mm)" }, { "2", "Grade 1 (26-35mm)" }, { "3", "Grade 2 (16-25mm)" }, { "4", "Grade 3 (<15mm)" } };
            var ThyromentalDistance = new Dictionary<string, string> { { "1", "< 6 cm" }, { "2", "6-7.5 cm" }, { "3", ">7.5 cm" } };
            var Ageyrs = new Dictionary<string, string> { { "1", "0-51" }, { "2", "51-80" }, { "3", ">80" } };
            var PreopSpO2 = new Dictionary<string, string> { { "1", "0-90" }, { "2", "91-95" }, { "3", ">95" } };
            var RespiratoryInfection1month = new Dictionary<string, string> { { "1", "Yes" }, { "2", "No" } };
            var PreopHb = new Dictionary<string, string> { { "1", "≤ 10" }, { "2", "> 10" } };
            var Incision = new Dictionary<string, string> { { "1", "Upper Abdominal" }, { "2", "Intrathoracic" }, { "3", "None" }, { "4", "Other" } }; //Priyanka 19/11/2025
            var Surgery = new Dictionary<string, string> { { "1", ">3Hrs" }, { "2", "<3hrs" } };
            var EmergencyProcedure = new Dictionary<string, string> { { "1", "Yes" }, { "2", "No" } };
            var RevisedLeeCardiacRisk = new Dictionary<string, string> { { "1", "High Risk Surgery" }, { "2", "Coronary Artery Disease" }, { "3", "Congestive Heart Failure" }, { "4", "Cerebrovascular Disease" }, { "5", "DM on Insulin" }, { "6", "Creatinine >2mg%" } };
            var Encephalopathy = new Dictionary<string, string> { { "1", "None" }, { "2", "Mild – Moderate (Gr I-II)" }, { "3", "Severe (Gr III-IV)" } };
            var Ascites = new Dictionary<string, string> { { "1", "None" }, { "2", "Mild-Moderate" }, { "3", "Severe" } };
            var Bilirubin = new Dictionary<string, string> { { "1", "<2" }, { "2", "2-3" }, { "3", ">3" } };
            var Albumin = new Dictionary<string, string> { { "1", ">3.5" }, { "2", "2.8-3.5" }, { "3", "<2.8" } };
            var INR = new Dictionary<string, string> { { "1", "<1.7" }, { "2", "1.7-2.3" }, { "3", ">2.3" } };
            var PhysicalStatus = new Dictionary<string, string> { { "1", "I" }, { "2", "II" }, { "3", "III" }, { "4", "IV" }, { "5", "V" }, { "6", "VI" }, { "7", "E" } };
            var FitnessStatus = new Dictionary<string, string> { { "F", "Yes" }, { "W", "Yes, with Accepted Risk" }, { "U", "No" } };
            var RiskLvl = new Dictionary<string, string> { { "L", "Low" }, { "M", "Medium" }, { "H", "High" } };//priyanka 19/11/2025
            var AnthesiaLst = Comm.GetAnaesthTypeList();
            DataRow DRPAC = PACINFO.NewRow();
            DRPAC["TRANNO"] = Mdl.TRANNO;
            DRPAC["TRANDATE"] = ("" + Mdl.TRANDT).ToString();
            DRPAC["MRNO"] = Mdl.MRNO;
            DRPAC["PATIENTNAME"] = ("" + Mdl.PatName).ToString();
            DRPAC["AGE"] = ("" + Mdl.PatAge).ToString() == "" ? "" : GeneralFunction.AgeFormat(("" + Mdl.PatAge).ToString());
            DRPAC["GENDER"] = ("" + Mdl.PatGender).ToString();
            DRPAC["ADMDOCTOR"] = ("" + Mdl.AdmDoctor).ToString();
            DRPAC["REVIEWPAC"] = Mdl.ReviewYN == "Y" ? Mdl.ReviewDate : "No";
            DRPAC["WEIGHT"] = Mdl.PatWeight;
            DRPAC["HEIGHT"] = Mdl.PatHeight;
            DRPAC["BMI"] = Mdl.PatBMI;
            DRPAC["PROCPLANNED"] = ("" + Mdl.PlannedSurgeryNM).Replace("\\n", "\r\n").Trim('"');
            DRPAC["SCHDATESURGRY"] = Mdl.AdvicedSurgeryDate;
            DRPAC["NATOFSURGRY"] = Mdl.SurgBookType != "" ? SurgyType[Mdl.SurgBookType] : "";
            DRPAC["GENCONDITION"] = Mdl.GeneralCondtion != "" ? GenCondition[Mdl.GeneralCondtion] : "";
            DRPAC["BREATHPATTERN"] = Mdl.BreathPattern != "" ? BreathPatrn[Mdl.BreathPattern] : "";
            DRPAC["BREATHREMARK"] = Mdl.BreathingPatternRemark;
            DRPAC["RESPRATE"] = Mdl.RespiratoryRate;
            DRPAC["ORIENTATION"] = Mdl.Orientation != "" ? Orientation[Mdl.Orientation] : "";
            DRPAC["PALLOR"] = Mdl.IsPallor == "Y" ? Mdl.Pallor : "Absent";
            DRPAC["ICTERUS"] = Mdl.IsIcterus == "Y" ? Mdl.Icterus : "Absent";
            DRPAC["CYANOSIS"] = Mdl.IsCyanosis == "Y" ? Mdl.Cyanosis : "Absent";
            DRPAC["CLUBBING"] = Mdl.IsClubbing == "Y" ? Mdl.Clubbing : "Absent";
            DRPAC["LYMPHADENO"] = Mdl.IsLymphadenopathy == "Y" ? Mdl.Lymphadenopathy : "Absent";
            DRPAC["PEDALEDEMA"] = Mdl.IsPedalEDEMA == "Y" ? Mdl.PedalEDEMA : "Absent";
            DRPAC["HYDRASTATUS"] = Mdl.HydrationStatus != "" ? HydrationStatus[Mdl.HydrationStatus] : "";
            DRPAC["HYDRASTATUSOTHRS"] = Mdl.HydrationStatusOther;
            DRPAC["VENOUSACCESS"] = Mdl.IsVenousAccess == "Y" ? Mdl.VenousAccess : "Absent";
            DRPAC["METS"] = Mdl.METS != "" ? METS[Mdl.METS] : "";
            DRPAC["FUNCCAPACITY"] = Mdl.FunctCapacity != "" ? FunctionalCapacity[Mdl.FunctCapacity] : "";
            DRPAC["LRTI"] = Mdl.IsLRTI == "Y" ? Mdl.LRTI : "Absent";
            DRPAC["URTI"] = Mdl.IsURTI == "Y" ? Mdl.URTI : "Absent";
            DRPAC["FEVER"] = Mdl.IsFever == "Y" ? Mdl.Fever : "Absent";
            DRPAC["PREANAESTEVALHIST"] = Mdl.IsPreAnaestEvalHist == "Y" ? ("" + Mdl.PreAnaestEvalHist).Replace("\\n", "\r\n").Trim('"') : "Absent";
            DRPAC["HYPERTENSION"] = Mdl.IsHypertension == "Y" ? Mdl.Hypertension : "Absent";
            DRPAC["DIABMELLTUS"] = Mdl.IsDiabetesMellitus == "Y" ? Mdl.DiabetesMellitus : "Absent";
            DRPAC["CARDIAC"] = Mdl.Cardiac == null ? "" : Mdl.Cardiac != "" ? Cardiac[Mdl.Cardiac] : "";
            DRPAC["CARDIACREMARK"] = Mdl.CardiacOthrs;
            DRPAC["NYHA"] = Mdl.NYHA != "" ? NYHA[Mdl.NYHA] : "";
            DRPAC["ECOG"] = Mdl.ECOG != "" ? ECOG[Mdl.ECOG] : "";
            DRPAC["REPIRATORY"] = Mdl.Respiratory != "" ? Respiratory[Mdl.Respiratory] : "";
            DRPAC["MMRC"] = Mdl.MMRC != "" ? MMRC[Mdl.MMRC] : "";
            DRPAC["NERVSYSTEM"] = Mdl.NervsousSys != "" ? NervousSystem[Mdl.NervsousSys] : "";
            DRPAC["NERVSYSTEMREMARK"] = Mdl.NervsousSysOthrs;
            DRPAC["RENAL"] = Mdl.Renal == null ? "" : Mdl.Renal != "" ? Renal[Mdl.Renal] : "";
            DRPAC["RENALREMARK"] = Mdl.RenalOthrs == null ? "" : Mdl.RenalOthrs;
            DRPAC["THYROIDDISORDER"] = Mdl.IsThyroidDisorder == "Y" ? Mdl.ThyroidDisorder : "Absent";
            DRPAC["CHEMOTHERAPY"] = Mdl.IsChemotherapy == "Y" ? Mdl.Chemotherapy : "Absent";
            DRPAC["RADIOTHERAPY"] = Mdl.IsRadiotherapy == "Y" ? Mdl.Radiotherapy : "Absent";
            DRPAC["ANYHOSURGRY"] = Mdl.IsAntHOSurgery == "Y" ? ("" + Mdl.AnyHOSurg).Replace("\\n", "\r\n").Trim('"') : "Absent";
            DRPAC["BLOODRELATED"] = Mdl.BloodRelated != "" ? BloodRelated[Mdl.BloodRelated] : "";
            DRPAC["DRUGBITE"] = Mdl.IsDrugSnakeScorpionBite == null ? "" : Mdl.IsDrugSnakeScorpionBite == "Y" ? Mdl.DrugBite : "Absent";
            DRPAC["ANYOTHRRELMEDHIST"] = Mdl.IsAnyRevlMediHist == "Y" ? ("" + Mdl.OtherMedicalHist).Replace("\\n", "\r\n").Trim('"') : "Absent";
            DRPAC["OBESITYSCORE"] = Mdl.Obesity.Split(',').Length;
            DRPAC["OBESITY"] = ("" + Mdl.Obesity).Trim() != "" ? string.Join(", ", Mdl.Obesity.Split(',').Select(k => k.Trim()).Where(k => Obesity.ContainsKey(k)).Select(k => Obesity[k])) : "Absent";
            DRPAC["DRUGS"] = Mdl.Drugs;
            DRPAC["ALCOHOL"] = Mdl.Alcohol;
            DRPAC["BETALNUT"] = Mdl.BetalNut;
            DRPAC["TOBACCO"] = Mdl.Tobacco;
            DRPAC["SMOKING"] = Mdl.Smoking;
            DRPAC["NARES"] = Mdl.NARES != "" ? NARES[Mdl.NARES] : "";
            DRPAC["NASALSEPTUM"] = Mdl.NASALSeptum != "" ? DeviatedNasalSeptum[Mdl.NASALSeptum] : "";
            DRPAC["MOUTHOPEN"] = Mdl.MouthOpen != "" ? MouthOpening[Mdl.MouthOpen] : "";
            DRPAC["TEETH"] = Mdl.Teeth == null ? "" : Mdl.Teeth != "" ? Teeth[Mdl.Teeth] : "";
            DRPAC["MALLAMPATI"] = Mdl.Mallampati != "" ? Mallampati[Mdl.Mallampati] : "";
            DRPAC["MALLAMPATIREMARK"] = Mdl.MallampattiRemark;
            DRPAC["JAWSLIDING"] = Mdl.Jawsliding != "" ? JawSliding[Mdl.Jawsliding] : "";
            DRPAC["TRISMUS"] = Mdl.Trismus != "" ? Trismus[Mdl.Trismus] : "";
            DRPAC["THYROMENTALDIST"] = Mdl.ThyromentalDisorder != "" ? ThyromentalDistance[Mdl.ThyromentalDisorder] : "";
            DRPAC["NECK"] = Mdl.Neck;
            DRPAC["SPINE"] = Mdl.Spine;
            DRPAC["TRACHEOSTOMY"] = Mdl.IsTracheostomy == "Y" ? Mdl.Tracheostomy : "Absent";
            DRPAC["AIRWAYCOMMENTS"] = Mdl.Airwaycomment;
            DRPAC["CARDIOSYSTEM"] = Mdl.CardiovascularSys;
            DRPAC["RESPIRATORYSYSTEM"] = Mdl.RespiratorySys;
            DRPAC["ABDOMINALSYSTEM"] = Mdl.AdbominalSys;
            DRPAC["CENTRALNERVSYSTEM"] = Mdl.CentralNervSys;
            DRPAC["ARISCATNA"] = Mdl.ARISCATNAYN;
            DRPAC["ARISCATAGE"] = Mdl.ARIAge != "" ? Ageyrs[Mdl.ARIAge] : "";
            DRPAC["PREOPSPO2"] = Mdl.PreOPSPO2 != "" ? PreopSpO2[Mdl.PreOPSPO2] : "";
            DRPAC["RESPINFTONEMONTH"] = Mdl.RespInfct1Month != "" ? RespiratoryInfection1month[Mdl.RespInfct1Month] : "";
            DRPAC["PREOPHB"] = Mdl.PreOPHb != "" ? PreopHb[Mdl.PreOPHb] : "";
            DRPAC["INCISION"] = Mdl.Incision != "" ? Incision[Mdl.Incision] : "";
            DRPAC["SURGERY"] = Mdl.Surgery != "" ? Surgery[Mdl.Surgery] : "";
            DRPAC["EMGPROCEDURE"] = Mdl.EmgProcedure != "" ? EmergencyProcedure[Mdl.EmgProcedure] : "";
            int ARITotal = 0;
            if (Mdl.ARIAge == "2")
                ARITotal += 3;
            if (Mdl.ARIAge == "3")
                ARITotal += 16;
            if (Mdl.PreOPSPO2 == "1")
                ARITotal += 24;
            if (Mdl.PreOPSPO2 == "2")
                ARITotal += 8;
            if (Mdl.RespInfct1Month == "1")
                ARITotal += 17;
            if (Mdl.PreOPHb == "1")
                ARITotal += 11;
            if (Mdl.Incision == "1")
                ARITotal += 15;
            if (Mdl.Incision == "2")
                ARITotal += 24;
            if (Mdl.Surgery == "1")
                ARITotal += 16;
            if (Mdl.Surgery == "2")
                ARITotal += 23;
            if (Mdl.EmgProcedure == "1")
                ARITotal += 8;
            DRPAC["TOTAL"] = ARITotal;
            DRPAC["RISKCATG"] = Mdl.RiskCatg;
            DRPAC["PPCRATE"] = Mdl.PPCRate;
            DRPAC["REVLEENA"] = Mdl.REVLEENAYN;
            DRPAC["REVLEECARDIARISKFACT"] = Mdl.ReviLeeCardiIndx != "" ? string.Join(", ", Mdl.ReviLeeCardiIndx.Split(',').Select(k => k.Trim()).Where(k => RevisedLeeCardiacRisk.ContainsKey(k)).Select(k => RevisedLeeCardiacRisk[k])) : "";
            DRPAC["REVLEECLASS"] = Mdl.ReviLeeClass;
            DRPAC["MAJORCARDIACEVENT"] = Mdl.ReviLeeCardiEvent;
            DRPAC["CHILDPUGHNA"] = Mdl.CHILDPUGHNAYN;
            DRPAC["ENCEPHALOPATHY"] = Mdl.Encephalopathy != "" ? Encephalopathy[Mdl.Encephalopathy] : "";
            DRPAC["ASCITES"] = Mdl.Ascites != "" ? Ascites[Mdl.Ascites] : "";
            DRPAC["BILIRUBIN"] = Mdl.Bilirubin != "" ? Bilirubin[Mdl.Bilirubin] : "";
            DRPAC["ALBUMIN"] = Mdl.Albumin != "" ? Albumin[Mdl.Albumin] : "";
            DRPAC["INR"] = Mdl.INR != "" ? INR[Mdl.INR] : "";
            DRPAC["CLASS"] = Mdl.ChildPughClass;
            DRPAC["POINTS"] = Mdl.ChildPughPoints;
            DRPAC["SPECIALITYREFERRENCE"] = ("" + Mdl.SpecialityReference).Replace("\\n", "\r\n").Trim('"');
            DRPAC["PHYSICALSTATUS"] = Mdl.ASAPhysicalStatus != "" ? PhysicalStatus[Mdl.ASAPhysicalStatus] : "";
            DRPAC["FITNESSSTATUS"] = Mdl.ASAFitnessStatus != "" && Mdl.ASAFitnessStatus == "W" ? FitnessStatus[Mdl.ASAFitnessStatus] + (Mdl.ASARiskLevel != "" ? " (" + RiskLvl[Mdl.ASARiskLevel] + ")" : "") :
                                     Mdl.ASAFitnessStatus != "" && Mdl.ASAFitnessStatus != "W" ? FitnessStatus[Mdl.ASAFitnessStatus] : "";//priyanka 19/11/2025
            DRPAC["ASADATE"] = ("" + Mdl.ASADate).ToString() == "" ? "" : ("" + Mdl.ASADate).ToString();
            DRPAC["ASATIME"] = Mdl.ASATime;
            DRPAC["ANAESTHPREOPERATIVEORDER"] = ("" + Mdl.AnaestAdviceOperativeOrder).Replace("\\n", "\r\n").Trim('"');
            string AnaesthesiaType = "";
            if (("" + Mdl.AneasthTypeCode) != "")
            {
                string[] SpltValue = ("" + Mdl.AneasthTypeCode).ToString().Trim().Split('|');
                foreach (string AnesthCode in SpltValue)
                {
                    AnaesthesiaType = AnaesthesiaType == "" ? (AnthesiaLst.Where(x => x.Value == ("" + AnesthCode)).Count() > 0 ? AnthesiaLst.Where(x => x.Value == ("" + AnesthCode)).FirstOrDefault().Text : "") :
                        (AnaesthesiaType + "," + (AnthesiaLst.Where(x => x.Value == ("" + AnesthCode)).Count() > 0 ? AnthesiaLst.Where(x => x.Value == ("" + AnesthCode)).FirstOrDefault().Text : ""));
                }
            }
            DRPAC["ANAESTHESIATYPE"] = AnaesthesiaType;
            //DRPAC["ANAESTHESIATYPE"] = ("" + Mdl.AneasthTypeCode) == "" ? "" : (AnthesiaLst.Where(x => x.Value == ("" + Mdl.AneasthTypeCode)).Count() > 0 ? AnthesiaLst.Where(x => x.Value == ("" + Mdl.AneasthTypeCode)).FirstOrDefault().Text : "");
            DRPAC["PREOP"] = ("" + Mdl.PreOPMed).Replace("\\n", "\r\n").Trim('"');
            DRPAC["INDUCTION"] = ("" + Mdl.Induction).Replace("\\n", "\r\n").Trim('"');
            DRPAC["PONV"] = ("" + Mdl.PONV).Replace("\\n", "\r\n").Trim('"');
            DRPAC["MAINTENANCE"] = ("" + Mdl.Maintenance).Replace("\\n", "\r\n").Trim('"');
            DRPAC["NOTES"] = ("" + Mdl.Notes).Replace("\\n", "\r\n").Trim('"');
            DRPAC["ANESTHESIOLOGIST"] = ("" + Mdl.PACDoneBy);
            DRPAC["INCISIONOTHER"] = ("" + Mdl.IncisionOther);//priyanka 19/11/2025
            DRPAC["ASAREMARKS"] = ("" + Mdl.ASARemarks).Replace("\\n", "\r\n").Trim('"');

            //CARDIAC SYSTEM
            DRPAC["CARDIACIHDYN"] = ("" + Mdl.CardiacIHDYN == "Y" ? "IHD" : "");
            DRPAC["CARDIACIHDRMK"] = ("" + Mdl.CardiacIHDRemarks);
            DRPAC["CARDIACCHFYN"] = ("" + Mdl.CardiacCHFYN == "Y" ? "CHF" : "");
            DRPAC["CARDIACCHFRMK"] = ("" + Mdl.CardiacCHFRemarks);
            DRPAC["CARDIACRHDYN"] = ("" + Mdl.CardiacRHDYN == "Y" ? "RHD" : "");
            DRPAC["CARDIACRHDRMK"] = ("" + Mdl.CardiacRHDRemarks);
            DRPAC["CARDIACTHRYN"] = ("" + Mdl.CardiacTHRYN == "Y" ? "OTHER" : "");
            DRPAC["CARDIACTHRRMK"] = ("" + Mdl.CardiacTHRRemarks);

            //DURG ALLERGY, SNAKE BITE, SCOPRION BITE
            DRPAC["DRUGALLERGIESRMK"] = ("" + Mdl.DrugAllergyRemarks);
            DRPAC["SNAKEBITERMK"] = ("" + Mdl.SnakeBiteRemarks);
            DRPAC["SCORPIONSTINGBITERMK"] = ("" + Mdl.ScorpionBiteRemarks);
            DRPAC["ASAPHYSCIALSTATUSE"] = ("" + Mdl.ASAPhysicalStatusEYN == "Y" ? "Yes" : "No");//priyanka 21/03/2026

            PACINFO.Rows.Add(DRPAC);
        }

        public List<byte[]> PrintPACRpt(string TranNo, string Mrno, string SpecialityYN, string PACInvstResultYN, PACMdl mdldata, string PrintPACYN = "N", string PrintedBy = "", string IPNo = "", string LetterHeaderYN = "", string PrintPrvw = "")//priyanka 09/12/2025)//priyanka 09/12/2025
        {
            List<byte[]> pdfByteArrays = new List<byte[]>();
            PdfTemplate std = new PdfTemplate();
            DataSet AllData = new DataSet();
            DataTable PACINFO = new DataTable();
            DataTable VITALSINFO = new DataTable();
            DataTable INVSTINFO = new DataTable();
            DataTable PREOPMEDINFO = new DataTable();
            DataTable INDUMEDINFO = new DataTable();
            DataTable PONVMEDINFO = new DataTable();
            DataTable MAINTMEDINFO = new DataTable();
            DataTable REVMEDINFO = new DataTable();
            DataTable HData = new DataTable(); //priyanka 01/04/2026
            //PRIYANKA 25/02/2026
            DataTable CARDIACSYSINFO = new DataTable();
            DataTable RESPSYSINFO = new DataTable();
            DataTable NERVSYSINFO = new DataTable();
            DataTable RENALINFO = new DataTable();
            DataTable BLOODRELINFO = new DataTable();
            DataTable TEETHINFO = new DataTable();
            DataTable DOCTDETAILS = new DataTable();
            string ShowVitals = PrintPACYN == "Y" ? "Y" : "N";
            string ShowInvest = PrintPACYN == "Y" ? "Y" : "N";
            string ShowPreopMed = PrintPACYN == "Y" ? "Y" : "N";
            string ShowInduMed = PrintPACYN == "Y" ? "Y" : "N";
            string ShowPONVMed = PrintPACYN == "Y" ? "Y" : "N";
            string ShowMaintMed = PrintPACYN == "Y" ? "Y" : "N";
            string ShowRevMed = PrintPACYN == "Y" ? "Y" : "N";
            PACMdl Mdl = new PACMdl();
            DataSet ListLoad = new DataSet(); DataSet Load = new DataSet();
            DataTable ListLoadDT = new DataTable(); DataTable LoadDT = new DataTable();
            DataSet ds = new DataSet();
            DataSet doctDetails = new DataSet();
            ICUClient ICUCLNT = new ICUClient();
            Load.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACDetails(Mrno, TranNo)))));
            //ListLoad.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACPatientWaitList("", Mrno, "")))));
            ListLoad.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetSurgeryAdvicedList(Mrno)))));//PRIYANKA 24/02/2026
            if (ListLoad.Tables.Count > 0 && ListLoad.Tables[0].Rows.Count > 0)
            {
                ListLoadDT = ListLoad.Tables[0];
            }
            LoadDT = Load.Tables[0];
            BindPACProperty(Mdl, ListLoadDT, LoadDT);
            if (IPNo != "")
            {
                ds.ReadXml(new XmlTextReader(new StringReader(ICUCLNT.GetIPPatLastVitals(IPNo)))); //priyanka 08/06/2026
                if (ds.Tables.Count >= 1 && ds.Tables[1].Rows.Count > 0)
                {
                    Mdl.PatHeight = Convert.ToString(ds.Tables[1].Rows[0]["HEIGHT"]).Trim();

                    Mdl.PatWeight = Convert.ToString(ds.Tables[1].Rows[0]["WEIGHT"]).Trim();
                    Mdl.PatBMI = Convert.ToString(ds.Tables[1].Rows[0]["BMI"]).Trim();
                }
            }
            var strDoctCD = "";
            if (Load.Tables.Contains("Table1"))
            {
                strDoctCD = Load.Tables["Table1"].Rows[0]["CREATEDBY"].ToString().Trim();
            }
            else
            {
                strDoctCD = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            }
            string jsonDoctDetails = oncoClient.GetDoctDetails(strDoctCD);

            doctDetails = GeneralFunction.FillDatasetXMl(jsonDoctDetails);

            string DocSign = oncoClient.GetSignatoryData(strDoctCD);

            DataSet load = new DataSet();
            load.ReadXml(new StringReader(DocSign));

            string base64String = "";

            if (load.Tables.Count > 0 && load.Tables[0].Rows.Count > 0)
            {
                DataRow signRow = load.Tables[0].Rows[0];

                if (signRow["DIGSIGN1"] != DBNull.Value && signRow["DIGSIGN1"].ToString().Trim() != "")
                    base64String = signRow["DIGSIGN1"].ToString().Trim();
                else if (signRow["DIGSIGN2"] != DBNull.Value && signRow["DIGSIGN2"].ToString().Trim() != "")
                    base64String = signRow["DIGSIGN2"].ToString().Trim();
                else if (signRow["DIGSIGN3"] != DBNull.Value && signRow["DIGSIGN3"].ToString().Trim() != "")
                    base64String = signRow["DIGSIGN3"].ToString().Trim();
            }
            byte[] signBytes = null;



            // Create columns
            DOCTDETAILS.Columns.Add("DOCTCODE");
            DOCTDETAILS.Columns.Add("DOCTNAME");
            DOCTDETAILS.Columns.Add("QUALI");
            DOCTDETAILS.Columns.Add("MCCNO");
            DOCTDETAILS.Columns.Add("SIGN");
            DOCTDETAILS.Columns.Add("DOSPNAME");
            DOCTDETAILS.Columns.Add("DOCSIGN", typeof(byte[]));

            if (!string.IsNullOrWhiteSpace(base64String))
            {
                signBytes = Convert.FromBase64String(base64String);
            }

            if (doctDetails.Tables.Count > 0 && doctDetails.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in doctDetails.Tables[0].Rows)
                {
                    DataRow newRow = DOCTDETAILS.NewRow();

                    newRow["DOCTCODE"] = dr["DOCTCODE"];
                    newRow["DOCTNAME"] = dr["DOCTNAME"];
                    newRow["QUALI"] = dr["QUALI"];
                    newRow["MCCNO"] = dr["MCCNO"];
                    newRow["SIGN"] = dr["SIGN"];
                    newRow["DOSPNAME"] = dr["DOSPNAME"];
                    newRow["DOCSIGN"] = signBytes;

                    DOCTDETAILS.Rows.Add(newRow);
                }
            }
            if (Load.Tables.Count > 1 && Load.Tables[1].Rows.Count > 0)
            {
                int Index = 0;
                var VitalsPainScore = new Dictionary<string, string>{
                    { "0", "Pain Free" }, { "1", "Very Mild" }, { "2", "Hurts Little Bit" }, { "3", "Tolerable" }, { "4", "Hurts Little More" }, { "5", "Very Distressing" },
                    { "6", "Hurts Even More" }, { "7", "Very Intense" }, { "8", "Hurts Whole Lot" }, { "9", "Unbearable" }, { "10", "Hurts Worst" } };
                ShowVitals = "Y";
                VITALSINFO = Load.Tables[1];
                VITALSINFO.Columns.Add("SEQNO");
                VITALSINFO.Columns.Add("PAINSCORENAME");
                foreach (DataRow Dr in VITALSINFO.Rows)
                {
                    Dr["SEQNO"] = Index++;
                    Dr["VITALDATE"] = ("" + Dr["VITALDATE"]).ToString() == "" ? "" : GeneralFunction.GetDate(("" + Dr["VITALDATE"]).ToString());
                    Dr["PAINSCORENAME"] = "";
                    if (("" + Dr["PAINSCORE"]).ToString().Trim() != "")
                    {
                        Dr["PAINSCORENAME"] = VitalsPainScore[("" + Dr["PAINSCORE"]).ToString().Trim()] + "(" + ("" + Dr["PAINSCORE"]).ToString().Trim() + ")";
                    }
                }
            }
            else
            {
                ShowVitals = "N";
            }
            string ShowInvestInPrint = "N";
            string InvstAdv = "";
            ShowInvest = "N";
            if (ShowInvestInPrint == "Y")
            {
                BindInvstData(Mdl, INVSTINFO, Load);
                if (INVSTINFO.Rows.Count > 0)
                {
                    ShowInvest = "Y";
                    if (INVSTINFO.Columns.Contains("INVESTDESC"))
                    {
                        INVSTINFO.Columns["INVESTDESC"].ColumnName = "INVSETDESC";
                    }
                    foreach (DataRow Dr in INVSTINFO.Rows)
                    {
                        Dr["INVDATE"] = ("" + Dr["INVDATE"]).ToString() == "" ? "" : GeneralFunction.GetDate(("" + Dr["INVDATE"]).ToString());
                        Dr["INVINHOUSEDATE"] = ("" + Dr["INVINHOUSEDATE"]).ToString() == "" ? "" : GeneralFunction.GetDate(("" + Dr["INVINHOUSEDATE"]).ToString());
                    }
                }
            }
            else
            {
                //priyanka 25/02/2026
                List<string> investigations = new List<string>();
                DataRow[] DrVisit = Load.Tables[3].Select();
                if (("" + mdldata.IsVisitPrint) != "" && Load.Tables.Count > 3 && Load.Tables[3].Rows.Count > 0)
                {
                    DrVisit = Load.Tables[3].Select("TRANNO = '" + mdldata.IsVisitPrint + "'");
                }
                foreach (DataRow Dr in DrVisit)
                {
                    string InvstWithRate = Dr["TESTNAME"].ToString().Trim();
                    string OnlyInvst = InvstWithRate.Split('[')[0].Trim();
                    investigations.Add(OnlyInvst);
                }
                InvstAdv = string.Join(",", investigations);
                //end
            }

            if (Load.Tables.Count > 6 && Load.Tables[6].Rows.Count > 0)
            {
                DataTable MEDDT = new DataTable();
                MEDDT = Load.Tables[6];
                OncologyEMR.Oncology.OncologyEMRClient OncServ = new OncologyEMR.Oncology.OncologyEMRClient();
                DataSet FormLinkds = new DataSet();
                DataTable DTFormLink = new DataTable();
                FormLinkds.ReadXml(new StringReader(OncServ.GetFormRouteLink()));
                if (FormLinkds.Tables.Count > 0 && FormLinkds.Tables[0].Rows.Count > 0)
                    DTFormLink = FormLinkds.Tables[0];
                if (("" + mdldata.IsVisitPrint) == "")
                {
                    PrintMedData("P", MEDDT, ref ShowPreopMed, ref PREOPMEDINFO, DTFormLink, mdldata.IsVisitPrint);
                }
                PrintMedData("I", MEDDT, ref ShowInduMed, ref INDUMEDINFO, DTFormLink, mdldata.IsVisitPrint);
                PrintMedData("N", MEDDT, ref ShowPONVMed, ref PONVMEDINFO, DTFormLink, mdldata.IsVisitPrint);
                PrintMedData("M", MEDDT, ref ShowMaintMed, ref MAINTMEDINFO, DTFormLink, mdldata.IsVisitPrint);
                PrintMedData("R", MEDDT, ref ShowRevMed, ref REVMEDINFO, DTFormLink, mdldata.IsVisitPrint);
            }
            if (("" + mdldata.IsVisitPrint) != "" && Load.Tables.Count > 9 && Load.Tables[9].Rows.Count > 0)
            {
                DataRow[] DrVisit = Load.Tables[9].Select("TRANNO = '" + mdldata.IsVisitPrint + "'");
                if (DrVisit.Length > 0)
                {
                    Mdl.AnaestAdviceOperativeOrder = ("" + DrVisit[0]["ANAESTADVICEOPERATIVEORDER"]).ToString().Trim();
                }
                else
                {
                    Mdl.AnaestAdviceOperativeOrder = "";
                }
            }
            else
            {
                Mdl.AnaestAdviceOperativeOrder = "";
            }
            if (("" + mdldata.IsVisitPrint) != "" && Load.Tables.Count > 9 && Load.Tables[9].Rows.Count > 0)
            {
                DataRow[] DrVisit = Load.Tables[9].Select("TRANNO = '" + mdldata.IsVisitPrint + "'");
                if (DrVisit.Length > 0)
                {
                    Mdl.SpecialityReference = ("" + DrVisit[0]["SPECIALITYREFERENCE"]).ToString().Trim();
                }
                else
                {
                    Mdl.SpecialityReference = "";
                }
            }
            else
            {
                Mdl.SpecialityReference = "";
            }


            SetTablePACINFO(Mdl, PACINFO);
            PACINFO.Columns.Add("INVESTADV");
            PACINFO.Columns.Add("SHOWVITALS");
            PACINFO.Columns.Add("SHOWINVEST");
            PACINFO.Columns.Add("SHOWPREOPMED");
            PACINFO.Columns.Add("SHOWINDUMED");
            PACINFO.Columns.Add("SHOWPONVMED");
            PACINFO.Columns.Add("SHOWMAINTMED");
            PACINFO.Columns.Add("SHOWREVERSEMED");

            //priyanka 23/02/2026
            PACINFO.Columns.Add("ShowPatInfo");
            PACINFO.Columns.Add("ShowAdvisedSurgeryDtls");
            PACINFO.Columns.Add("ShowPatVitalDtls");
            PACINFO.Columns.Add("ShowGenPhysicalExamDtls");
            PACINFO.Columns.Add("ShowCombandTreatHistDtls");
            PACINFO.Columns.Add("ShowSubstanceAbuseHistDtls");
            PACINFO.Columns.Add("ShowAirwayAssmntDtls");
            PACINFO.Columns.Add("ShowSysExamDtls");
            PACINFO.Columns.Add("ShowARISCATtls");
            PACINFO.Columns.Add("ShowRevCardiacRiskDtls");
            PACINFO.Columns.Add("ShowChildPughTurcScoreDtls");
            PACINFO.Columns.Add("ShowSpecialityRefDtls");
            PACINFO.Columns.Add("ShowASADtls");
            PACINFO.Columns.Add("ShowInvestAdviceDtls");
            PACINFO.Columns.Add("ShowAneasandPreopDtls");
            PACINFO.Columns.Add("ShowAneasPlanDtls");
            PACINFO.Columns.Add("ShowInductionMedicineDtls");
            //end

            PACINFO.Rows[0]["SHOWVITALS"] = ShowVitals;
            PACINFO.Rows[0]["SHOWINVEST"] = ShowInvest;
            PACINFO.Rows[0]["SHOWPREOPMED"] = ShowPreopMed;
            PACINFO.Rows[0]["SHOWINDUMED"] = ShowInduMed;
            PACINFO.Rows[0]["SHOWPONVMED"] = ShowPONVMed;
            PACINFO.Rows[0]["SHOWMAINTMED"] = ShowMaintMed;
            PACINFO.Rows[0]["SHOWREVERSEMED"] = ShowRevMed;
            PACINFO.Rows[0]["INVESTADV"] = InvstAdv;

            //priyanka 23/02/2026
            PACINFO.Rows[0]["ShowPatInfo"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowPatInfo;
            PACINFO.Rows[0]["ShowAdvisedSurgeryDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowAdvisedSurgeryDtls;
            PACINFO.Rows[0]["ShowPatVitalDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowPatVitalDtls;
            PACINFO.Rows[0]["ShowGenPhysicalExamDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowGenPhysicalExamDtls;
            PACINFO.Rows[0]["ShowCombandTreatHistDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowCombandTreatHistDtls;
            PACINFO.Rows[0]["ShowSubstanceAbuseHistDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowSubstanceAbuseHistDtls;
            PACINFO.Rows[0]["ShowAirwayAssmntDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowAirwayAssmntDtls;
            PACINFO.Rows[0]["ShowSysExamDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowSysExamDtls;
            PACINFO.Rows[0]["ShowARISCATtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowARISCATtls;
            PACINFO.Rows[0]["ShowRevCardiacRiskDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowRevCardiacRiskDtls;
            PACINFO.Rows[0]["ShowChildPughTurcScoreDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowChildPughTurcScoreDtls;
            PACINFO.Rows[0]["ShowSpecialityRefDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowSpecialityRefDtls;
            PACINFO.Rows[0]["ShowASADtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowASADtls;
            PACINFO.Rows[0]["ShowInvestAdviceDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowInvestAdviceDtls == "V" ? "Y" : mdldata.ShowInvestAdviceDtls;
            PACINFO.Rows[0]["ShowAneasandPreopDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowAneasandPreopDtls;
            PACINFO.Rows[0]["ShowAneasPlanDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowAneasPlanDtls;
            PACINFO.Rows[0]["ShowInductionMedicineDtls"] = PrintPACYN == "Y" ? "Y" : mdldata.ShowInductionMedicineDtls;
            //end

            //CARDIAC SYSTEM 
            CARDIACSYSINFO.Columns.Add("CARDIACNAME");
            CARDIACSYSINFO.Columns.Add("CARDIACREMARK");
            CARDIACSYSINFO.Columns.Add("CARDIACNAMERMK");
            // IHD
            if (Mdl.CardiacIHDYN == "Y")
            {
                CARDIACSYSINFO.Rows.Add(
                    "IHD",
                    Mdl.CardiacIHDRemarks ?? "",
                    !string.IsNullOrWhiteSpace(Mdl.CardiacIHDRemarks)
                        ? $"• IHD - {Mdl.CardiacIHDRemarks}"
                        : "• IHD"
                );
            }

            if (Mdl.CardiacCHFYN == "Y")
            {
                CARDIACSYSINFO.Rows.Add(
                    "CHF",
                    Mdl.CardiacCHFRemarks ?? "",
                    !string.IsNullOrWhiteSpace(Mdl.CardiacCHFRemarks)
                        ? $"• CHF - {Mdl.CardiacCHFRemarks}"
                        : "• CHF"
                );
            }

            if (Mdl.CardiacRHDYN == "Y")
            {
                CARDIACSYSINFO.Rows.Add(
                    "RHD",
                    Mdl.CardiacRHDRemarks ?? "",
                    !string.IsNullOrWhiteSpace(Mdl.CardiacRHDRemarks)
                        ? $"• RHD - {Mdl.CardiacRHDRemarks}"
                        : "• RHD"
                );
            }

            if (Mdl.CardiacTHRYN == "Y")
            {
                CARDIACSYSINFO.Rows.Add(
                    "OTHER",
                    Mdl.CardiacTHRRemarks ?? "",
                    !string.IsNullOrWhiteSpace(Mdl.CardiacTHRRemarks)
                        ? $"• OTHER - {Mdl.CardiacTHRRemarks}"
                        : "• OTHER"
                );
            }
            //END


            //RESPIRATORY SYSTEM
            RESPSYSINFO.Columns.Add("RESPSYSNAMERMK");
            if (Mdl.RespiAsthmaYN == "Y")
            {
                RESPSYSINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.RespiAsthmaRemarks)
                        ? $"• ASTHAMA - {Mdl.RespiAsthmaRemarks}"
                        : "• ASTHAMA"
                );
            }

            if (Mdl.RespiTBYN == "Y")
            {
                RESPSYSINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.RespiTBRemarks)
                        ? $"• TB - {Mdl.RespiTBRemarks}"
                        : "• TB"
                );
            }

            if (Mdl.RespiCOPDYN == "Y")
            {
                RESPSYSINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.RespiCOPDRemarks)
                        ? $"• COPD - {Mdl.RespiCOPDRemarks}"
                        : "• COPD"
                );
            }
            //END

            //NERVOUS SYSTEM
            NERVSYSINFO.Columns.Add("NERVSYSNAMERMK");

            if (Mdl.NervSysEpilepsyYN == "Y")
            {
                NERVSYSINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.NervSysEpilepsyRemarks)
                        ? $"• EPILEPSY - {Mdl.NervSysEpilepsyRemarks}"
                        : "• EPILEPSY"
                );
            }

            if (Mdl.NervSysStrokeYN == "Y")
            {
                NERVSYSINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.NervSysStrokeRemarks)
                        ? $"• STROKE - {Mdl.NervSysStrokeRemarks}"
                        : "• STROKE"
                );
            }

            if (Mdl.NervSysOtherYN == "Y")
            {
                NERVSYSINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.NervSysOtherRemarks)
                        ? $"• OTHER - {Mdl.NervSysOtherRemarks}"
                        : "• OTHER"
                );
            }
            //END

            //RENAL
            RENALINFO.Columns.Add("RENALSYSNAMERMK");

            if (Mdl.RenalAKIYN == "Y")
            {
                RENALINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.RenalAKIRemarks)
                        ? $"• AKI - {Mdl.RenalAKIRemarks}"
                        : "• AKI"
                );
            }

            if (Mdl.RenalCKDYN == "Y")
            {
                RENALINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.RenalCKDRemarks)
                        ? $"• CKD - {Mdl.RenalCKDRemarks}"
                        : "• CKD"
                );
            }

            if (Mdl.RenalOtherYN == "Y")
            {
                RENALINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.RenalOtherRemarks)
                        ? $"• OTHER - {Mdl.RenalOtherRemarks}"
                        : "• OTHER"
                );
            }
            //END


            //BLOOD RELATED
            BLOODRELINFO.Columns.Add("BLOODRELNAMERMK");

            if (Mdl.BloodRelAnaYN == "Y")
            {
                BLOODRELINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.BloodRelAnaRemarks)
                        ? $"• ANAEMIA - {Mdl.BloodRelAnaRemarks}"
                        : "• ANAEMIA"
                );
            }

            if (Mdl.BloodRelHoYN == "Y")
            {
                BLOODRELINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.BloodRelHoRemarks)
                        ? $"• HO TRANSFUSION / DISORDERS - {Mdl.BloodRelHoRemarks}"
                        : "• HO TRANSFUSION / DISORDERS "
                );
            }
            //END

            //TEETH
            TEETHINFO.Columns.Add("TEETHNAMERMK");

            if (Mdl.TeethNormalYN == "Y")
            {
                TEETHINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.TeethNormalRemarks)
                        ? $"• NORMAL - {Mdl.TeethNormalRemarks}"
                        : "• NORMAL"
                );
            }
            if (Mdl.TeethEdenYN == "Y")
            {
                TEETHINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.TeethEdenRemarks)
                        ? $"• EDENTULOUS - {Mdl.TeethEdenRemarks}"
                        : "• EDENTULOUS"
                );
            }
            if (Mdl.TeethProYN == "Y")
            {
                TEETHINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.TeethProRemarks)
                        ? $"• PROTRUDING - {Mdl.TeethProRemarks}"
                        : "• PROTRUDING"
                );
            }
            if (Mdl.TeethArtiYN == "Y")
            {
                TEETHINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.TeethArtiRemarks)
                        ? $"• ARTIFICIAL - {Mdl.TeethArtiRemarks}"
                        : "• ARTIFICIAL"
                );
            }
            if (Mdl.TeethBuckYN == "Y")
            {
                TEETHINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.TeethBuckRemarks)
                        ? $"• BUCK - {Mdl.TeethBuckRemarks}"
                        : "• BUCK"
                );
            }
            if (Mdl.TeethLooseYN == "Y")
            {
                TEETHINFO.Rows.Add(
                    !string.IsNullOrWhiteSpace(Mdl.TeethLooseRemarks)
                        ? $"• LOOSE TOOTH - {Mdl.TeethLooseRemarks}"
                        : "• LOOSE TOOTH"
                );
            }
            //END


            CARDIACSYSINFO.TableName = "TBLCARDIACSYS";//PRIYANKA 25/02/2026
            RESPSYSINFO.TableName = "TBLRESPSYS";//PRIYANKA 25/02/2026
            NERVSYSINFO.TableName = "TBLNERVOUSSYS";//PRIYANKA 25/02/2026
            RENALINFO.TableName = "TBLRENALSYS";//PRIYANKA 25/02/2026
            BLOODRELINFO.TableName = "TBLBLOODREL";//PRIYANKA 25/02/2026
            TEETHINFO.TableName = "TBLTEETH";//PRIYANKA 25/02/2026
            PACINFO.TableName = "PAC";
            VITALSINFO.TableName = "VITALSINFO";
            INVSTINFO.TableName = "INVESTINFO";
            PREOPMEDINFO.TableName = "PREOPMEDINFO";
            INDUMEDINFO.TableName = "INDUMEDINFO";
            PONVMEDINFO.TableName = "PONVMEDINFO";
            MAINTMEDINFO.TableName = "MAINTMEDINFO";
            REVMEDINFO.TableName = "REVERSEMEDINFO";
            DOCTDETAILS.TableName = "TBLDOCTDETAILS";
            AllData.Tables.Add(PACINFO);
            DataTable vitalsCopy = VITALSINFO.Copy();
            AllData.Tables.Add(vitalsCopy);
            AllData.Tables.Add(INVSTINFO);
            AllData.Tables.Add(PREOPMEDINFO);
            AllData.Tables.Add(INDUMEDINFO);
            AllData.Tables.Add(PONVMEDINFO);
            AllData.Tables.Add(MAINTMEDINFO);
            AllData.Tables.Add(REVMEDINFO);
            AllData.Tables.Add(CARDIACSYSINFO);//PRIYANKA 25/02/2026
            AllData.Tables.Add(RESPSYSINFO);//PRIYANKA 25/02/2026
            AllData.Tables.Add(NERVSYSINFO);//PRIYANKA 25/02/2026
            AllData.Tables.Add(RENALINFO);//PRIYANKA 25/02/2026
            AllData.Tables.Add(BLOODRELINFO);//PRIYANKA 25/02/2026
            AllData.Tables.Add(TEETHINFO);//PRIYANKA 25/02/2026
            AllData.Tables.Add(DOCTDETAILS);
            //Priyanka 01/04/2026
            string PrintedByUserNM = GeneralFunction.GetUserName(PrintedBy);
            HData = GeneralFunction.getHeaderFooter("PAC Print", "", "", "", PrintedByUserNM, LetterHeaderYN, GeneralFunction.GetAppsettingUnitWiseValue("PACHEADFILENM"), GeneralFunction.GetAppsettingUnitWiseValue("PACFOOTFILENM"));
            HData.TableName = "HeaderFooter";
            AllData.Tables.Add(HData);
            //end
            string reportPath = Path.Combine(HttpContext.Current.Server.MapPath("~/Report"), "rptPAC.rpt");
            //Abhishesh || 20260720
            byte[] printarr = GeneralFunction.SetHeaderFootermargTopBottom(AllData, reportPath, HData.Rows[0]["ImageLetterYN"].ToString().Trim(), GeneralFunction.GetAppsettingUnitWiseValue("PACHEADHEIGHT"), GeneralFunction.GetAppsettingUnitWiseValue("PACFOOTHEIGHT")
            );
            //End

            //changes by aaryshree 20260409
            if (PrintPrvw == "Y")
            {
                byte[] printarr1 = std.AddLabPreviewWatermark(printarr, "Preview");
                pdfByteArrays.Add(printarr1);
            }
            else
            {
                pdfByteArrays.Add(printarr);
            }
            //end
            if (Load.Tables.Count > 5 && Load.Tables[5].Rows.Count > 0 && SpecialityYN == "Y")
            {
                DataTable PACSPECREFINFO = new DataTable();
                PACSPECREFINFO = Load.Tables[5];
                PACSPECREFINFO.Columns.Add("REFDATE");
                DataRow[] DRSpeciality = PACSPECREFINFO.Select("TRANNO ='" + mdldata.IsVisitPrint + "'");

                for (int i = 0; i < DRSpeciality.Count(); i += 2)
                {
                    // Changes By Abhishesh To Get The Value for REFDATE || 20260505
                    DataTable twoRowTable = PACSPECREFINFO.Clone();
                    twoRowTable.ImportRow(DRSpeciality[i]);
                    twoRowTable.Rows[i]["REFDATE"] = GeneralFunction.GetDate(("" + Mdl.TRANDT).ToString() == "" ? "" : GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.TRANDT).ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));

                    if (i + 1 < DRSpeciality.Count())
                    {
                        twoRowTable.ImportRow(DRSpeciality[i + 1]);
                    }
                    byte[] REFprintarr = Mdl.PrintSpecialityRefRpt(twoRowTable, "", "");
                    pdfByteArrays.Add(REFprintarr);
                    //End
                }
            }

            if (PACInvstResultYN == "Y")
            {
                byte[] InvResultprintarr = Mdl.PrintResultRpt(Mrno, TranNo);
                if (InvResultprintarr != null && InvResultprintarr.Length > 0) //priyanka 21/03/2026
                {
                    pdfByteArrays.Add(InvResultprintarr);
                }
            }
            return pdfByteArrays;
        }

        public void PrintMedData(string MedType, DataTable MEDDT, ref string ShowYN, ref DataTable MEDINFO, DataTable FormRouteLink, string VisitTranNo = "")
        {
            var DurCatg = new Dictionary<string, string> { { "D", "Days" }, { "W", "Weeks" }, { "M", "Months" }, { "Y", "Years" } };
            var FoodCatg = new Dictionary<string, string> { { "A", "After" }, { "B", "Before" } };
            int Seq = 1;
            if (MEDDT.Select("TYPE = '" + MedType + "'").Count() > 0)
            {
                ShowYN = "Y";
                MEDINFO = MEDDT.Clone();
                MEDINFO.Columns.Add("SNO");
                DataRow[] DrMed = MEDDT.Select("TYPE = '" + MedType + "'");
                if (VisitTranNo != "")
                    DrMed = MEDDT.Select("TYPE = '" + MedType + "' AND TRANNO = '" + VisitTranNo + "'");
                foreach (DataRow Dr in DrMed)
                {
                    DataRow NRow = MEDINFO.NewRow();
                    NRow["TRANNO"] = ("" + Dr["TRANNO"]).ToString().Trim();
                    NRow["DRUGCODE"] = ("" + Dr["DRUGCODE"]).ToString().Trim();
                    NRow["TYPE"] = ("" + Dr["TYPE"]).ToString().Trim();
                    NRow["DRUGNM"] = ("" + Dr["DRUGNM"]).ToString().Trim();
                    NRow["GENERICID"] = ("" + Dr["GENERICID"]).ToString().Trim();
                    NRow["GENERICNAME"] = ("" + Dr["GENERICNAME"]).ToString().Trim();
                    NRow["DRUGFORM"] = FormRouteLink.Select("MTRLFORMID = '" + ("" + Dr["DRUGFORM"]).ToString().Trim() + "'").Count() > 0 ? FormRouteLink.Select("MTRLFORMID = '" + ("" + Dr["DRUGFORM"]).ToString().Trim() + "'")[0]["DESCR"].ToString() : "";
                    NRow["DOSSAGE"] = ("" + Dr["DOSSAGE"]).ToString().Trim();
                    NRow["DAYS"] = ("" + Dr["DAYS"]).ToString().Trim();
                    NRow["REMARKS"] = ("" + Dr["REMARKS"]).ToString().Trim();
                    NRow["ROUTE"] = FormRouteLink.Select("ROUTECD = '" + ("" + Dr["ROUTE"]).ToString().Trim() + "'").Count() > 0 ? FormRouteLink.Select("ROUTECD = '" + ("" + Dr["ROUTE"]).ToString().Trim() + "'")[0]["ROUTENM"].ToString() : "";
                    NRow["INTAKECD"] = ("" + Dr["INTAKECD"]).ToString().Trim();
                    NRow["INTAKEDESC"] = ("" + Dr["INTAKEDESC"]).ToString().Trim();
                    NRow["SOSYN"] = ("" + Dr["SOSYN"]).ToString().Trim();
                    NRow["SEQNO"] = Seq;
                    NRow["SNO"] = Seq;
                    NRow["QTY"] = ("" + Dr["QTY"]).ToString().Trim();
                    NRow["DURATION"] = ("" + Dr["DURATION"]).ToString().Trim() == "" ? "" : DurCatg[("" + Dr["DURATION"]).ToString().Trim()];
                    NRow["ABFOOD"] = ("" + Dr["ABFOOD"]).ToString().Trim() == "" ? "" : FoodCatg[("" + Dr["ABFOOD"]).ToString().Trim()];
                    MEDINFO.Rows.Add(NRow);
                    Seq++;
                }
            }
            else
            {
                ShowYN = "N";
            }
        }

        public byte[] PrintSpecialityRefRpt(DataTable PACSPECREFINFO, string TRANNO = "", string MRNO = "")//priyanka 20/02/2026
        {
            DataSet AllData = new DataSet();
            OncologyEMRClient oncclnt = new OncologyEMRClient();
            string[] filepath = { };
            DataSet load = new DataSet();
            DataSet ds1 = new DataSet();
            DataTable dtEmpty = new DataTable();
            DataTable dtFrDoctDetls = new DataTable();

            var strDoctCD = System.Web.HttpContext.Current.Session["gDoctCode"].ToString();
            string jsonDoctDetails = oncclnt.GetDoctDetails(strDoctCD);

            ds1 = GeneralFunction.FillDatasetXMl(jsonDoctDetails);
            load.ReadXml(new XmlTextReader(new StringReader(oncclnt.GetSignatoryData(strDoctCD))));

            if (PACSPECREFINFO.Rows.Count > 0)
            {

                foreach (DataRow Dr in PACSPECREFINFO.Rows)
                {
                    string Content = new string(' ', 4) + Dr["REFCONTENT"].ToString();
                    Dr["REFCONTENT"] = Content;
                }
            }

            if (ds1.Tables.Contains("Table"))
            {
                dtFrDoctDetls = ds1.Tables["Table"];
                if (dtFrDoctDetls.Rows.Count > 0)
                {
                    if (!PACSPECREFINFO.Columns.Contains("DOCTNAME")) PACSPECREFINFO.Columns.Add("DOCTNAME", typeof(string));
                    if (!PACSPECREFINFO.Columns.Contains("SPECIALIZATION")) PACSPECREFINFO.Columns.Add("SPECIALIZATION", typeof(string));
                    if (!PACSPECREFINFO.Columns.Contains("DOCTSIGN")) PACSPECREFINFO.Columns.Add("DOCTSIGN", System.Type.GetType("System.Byte[]"));
                    if (!PACSPECREFINFO.Columns.Contains("QUALIFICATION")) PACSPECREFINFO.Columns.Add("QUALIFICATION", typeof(string));
                    if (!PACSPECREFINFO.Columns.Contains("MCCNO")) PACSPECREFINFO.Columns.Add("MCCNO", typeof(string));

                    var doctorRow = dtFrDoctDetls.Rows[0];
                    string doctName = doctorRow["DOCTNAME"].ToString();
                    string specialization = doctorRow["DOSPNAME"].ToString();
                    string qualification = doctorRow["QUALI"].ToString();
                    string mccno = doctorRow["MCCNO"].ToString();

                    byte[] Image = null;

                    if (load.Tables.Count > 0 && load.Tables[0].Rows.Count > 0)
                    {
                        DataRow row = load.Tables[0].Rows[0];
                        string base64String = null;
                        if (row["DIGSIGN1"] != DBNull.Value && row["DIGSIGN1"].ToString().Trim() != "")
                        {
                            base64String = row["DIGSIGN1"].ToString().Trim();
                        }
                        else if (row["DIGSIGN2"] != DBNull.Value && row["DIGSIGN2"].ToString().Trim() != "")
                        {
                            base64String = row["DIGSIGN2"].ToString().Trim();
                        }
                        else if (row["DIGSIGN3"] != DBNull.Value && row["DIGSIGN3"].ToString().Trim() != "")
                        {
                            base64String = row["DIGSIGN3"].ToString().Trim();
                        }

                        if (base64String != "")
                        {
                            Image = Convert.FromBase64String(base64String);
                        }

                        //string signPath = load.Tables[0].Rows[0]["DIGSIGN1"].ToString();
                        //base64String = load.Tables[0].Rows[0]["DIGSIGN1"].ToString();
                        Image = Convert.FromBase64String(base64String);
                    }

                    foreach (DataRow dr in PACSPECREFINFO.Rows)
                    {
                        dr["DOCTNAME"] = doctName;
                        dr["SPECIALIZATION"] = specialization;
                        dr["QUALIFICATION"] = qualification;
                        dr["MCCNO"] = mccno;
                        dr["DOCTSIGN"] = Image;
                    }
                }
            }

            PACSPECREFINFO.TableName = "SPECIALITYREF";
            AllData.Tables.Add(PACSPECREFINFO);
            string reportPath = Path.Combine(HttpContext.Current.Server.MapPath("~/Report"), "rptPACSpecialityRef.rpt");
            CrystalReportPdfResult crystal = new CrystalReportPdfResult();
            byte[] printarr = crystal.CrystalReportPdf(reportPath, AllData);
            return printarr;
        }

        public byte[] PrintResultRpt(string MRNO, string TRANNO)
        {
            int MaxDateColumn = 3;
            DataSet AllData = new DataSet();
            DataSet Load = new DataSet();
            DataTable LoadDT = new DataTable();
            Load.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACDetails(MRNO, TRANNO)))));
            DataTable DateDT = new DataTable();
            DataTable INVSTDT = new DataTable();
            DataTable PACResultPatInfo = new DataTable();//priyanka 09/12/2025
            DataTable HData = new DataTable(); // Abhishesh || 20260505
            INVSTDT.Columns.Add("SEQNO");
            INVSTDT.Columns.Add("TESTCODE");
            INVSTDT.Columns.Add("TESTNAME");
            INVSTDT.Columns.Add("INVSTCODE");
            INVSTDT.Columns.Add("INVSTNAME");
            INVSTDT.Columns.Add("RESULTTYPE");
            for (int i = 1; i <= MaxDateColumn; i++)
            {
                DateDT.Columns.Add(("DATE" + i + "YN"));
                INVSTDT.Columns.Add(("INHOUSEYN" + i));
                INVSTDT.Columns.Add(("RESULTDATE" + i));
                INVSTDT.Columns.Add(("RESULTVALUE" + i));
            }
            if (Load.Tables.Count > 3 && Load.Tables[3].Rows.Count > 0)
            {
                OncologyEMR.LabServRef.LaboratoryClient LabServ = new OncologyEMR.LabServRef.LaboratoryClient();
                DataTable ADVTESTDT = new DataTable();
                ADVTESTDT = Load.Tables[3];
                Array AdvTestArry = (from row1 in ADVTESTDT.AsEnumerable()
                                     orderby Convert.ToInt32(row1["SEQNO"]) ascending
                                     select new
                                     {
                                         SEQNO = row1["SEQNO"],
                                         TESTCODE = row1["TESTCODE"],
                                         TESTNAME = row1["TESTNAME"],
                                         CHECKED = "Y",
                                         TRANYN = "Y"
                                     }).ToArray();
                foreach (DataRow Dr in ADVTESTDT.Rows)
                {
                    string TestCode = ("" + Dr["TESTCODE"]).ToString().Trim();
                    string TestNM = ("" + Dr["TESTNAME"]).ToString().Trim();
                    string xmlData = LabServ.GetInvestigDataByTestCode(TestCode);
                    bool TestRowFlag = true;
                    bool AddTestFlag = true;
                    DataRow[] DROuthouseFilterInvstData = Load.Tables[2].Select("TESTCODE = '" + TestCode + "' AND RESULTDT <> ''");
                    DataRow[] DRInhouseFilterInvstData = Load.Tables[4].Select("TESTCODE = '" + TestCode + "' AND RESULTDT <> ''");
                    if (DROuthouseFilterInvstData.Length > 0 || DRInhouseFilterInvstData.Length > 0)
                    {
                        if (!string.IsNullOrEmpty(xmlData))
                        {
                            DataSet ds = new DataSet();
                            ds.ReadXml(new XmlTextReader(new StringReader(xmlData)));
                            string UnitCode = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'").Count() > 0)
                            {
                                TestRowFlag = false;
                                foreach (DataRow DrTest in ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'"))
                                {
                                    string SInvstCode = ("" + DrTest["INVESTCODE"]).ToString().Trim();
                                    string SInvstName = ("" + DrTest["INVESTDESC"]).ToString().Trim();
                                    string SResultType = ("" + DrTest["RESULTYPE"]).ToString().Trim();
                                    string SSeqNo = ("" + DrTest["SEQUENCE"]).ToString().Trim();
                                    //Inhouse
                                    DataView INview = new DataView(Load.Tables[4]);
                                    INview.RowFilter = "TESTCODE = '" + TestCode + "'";
                                    DataTable INuniqueTable = INview.ToTable(true, "RESULTDATE", "TESTCODE");
                                    //Outside
                                    DataView OUTview = new DataView(Load.Tables[2]);
                                    OUTview.RowFilter = "TESTCODE = '" + TestCode + "'";
                                    DataTable OUTuniqueTable = OUTview.ToTable(true, "INVDATE", "TESTCODE");
                                    var latestThreeDates = INuniqueTable.AsEnumerable().Select(r => r["RESULTDATE"].ToString()).Concat(OUTuniqueTable.AsEnumerable().Select(r => r["INVDATE"].ToString())).Distinct().OrderByDescending(d => d).Take(MaxDateColumn).ToList();
                                    DataRow FRow = INVSTDT.NewRow();
                                    DataRow TestRow = INVSTDT.NewRow();
                                    FRow["SEQNO"] = SSeqNo;
                                    FRow["TESTCODE"] = TestCode;
                                    FRow["TESTNAME"] = TestNM;
                                    FRow["INVSTCODE"] = SInvstCode;
                                    FRow["INVSTNAME"] = SInvstName;
                                    FRow["RESULTTYPE"] = SResultType;
                                    string InhouseYN = "N";
                                    for (int i = 0; i < latestThreeDates.Count; i++)
                                    {
                                        string Val = "";
                                        string dt = latestThreeDates[i];
                                        FRow[("RESULTDATE" + (i + 1))] = dt;
                                        TestRow[("RESULTDATE" + (i + 1))] = dt;
                                        //InHouse Filter Data
                                        DataRow[] DROuthouseFilterInvst = Load.Tables[2].Select("INVDATE = '" + dt + "' AND TESTCODE='" + TestCode + "' AND INVSETCODE='" + SInvstCode + "'");
                                        DataRow[] DRInhouseFilterInvst = Load.Tables[4].Select("RESULTDATE = '" + dt + "' AND TESTCODE='" + TestCode + "' AND INVESTCODE='" + SInvstCode + "'");
                                        if (DROuthouseFilterInvst.Length > 0)
                                        {
                                            InhouseYN = "N";
                                            Val = DROuthouseFilterInvst[0]["RESULTDT"].ToString().Trim();
                                        }
                                        if (DRInhouseFilterInvst.Length > 0)
                                        {
                                            InhouseYN = "Y";
                                            Val = DRInhouseFilterInvst[0]["RESULTDT"].ToString().Trim();
                                        }
                                        FRow[("INHOUSEYN" + (i + 1))] = InhouseYN;
                                        FRow[("RESULTVALUE" + (i + 1))] = Val;
                                    }
                                    if (AddTestFlag)
                                    {
                                        //Add Test Row
                                        TestRow["SEQNO"] = "";
                                        TestRow["TESTCODE"] = TestCode;
                                        TestRow["TESTNAME"] = TestNM;
                                        TestRow["INVSTCODE"] = "";
                                        TestRow["INVSTNAME"] = "";
                                        TestRow["RESULTTYPE"] = "";
                                        //Priyanka 09/12/2025
                                        for (int i = 0; i < latestThreeDates.Count; i++)
                                        {
                                            string Val = "";
                                            string dt = latestThreeDates[i];
                                            TestRow[("RESULTDATE" + (i + 1))] = dt;
                                            //InHouse Filter Data
                                            DataRow[] DROuthouseFilterInvst = Load.Tables[2].Select("INVDATE = '" + dt + "' AND TESTCODE='" + TestCode + "' AND RESULTDT <> ''");
                                            DataRow[] DRInhouseFilterInvst = Load.Tables[4].Select("RESULTDATE = '" + dt + "' AND TESTCODE='" + TestCode + "' AND RESULTDT <> ''");
                                            if (DROuthouseFilterInvst.Length > 0)
                                            {
                                                InhouseYN = "N";
                                                Val = DROuthouseFilterInvst[0]["RESULTDT"].ToString().Trim();
                                            }
                                            if (DRInhouseFilterInvst.Length > 0)
                                            {
                                                InhouseYN = "Y";
                                                Val = DRInhouseFilterInvst[0]["RESULTDT"].ToString().Trim();
                                            }

                                            TestRow[("INHOUSEYN" + (i + 1))] = InhouseYN;
                                        }

                                        INVSTDT.Rows.Add(TestRow);
                                        AddTestFlag = false;
                                    }
                                    INVSTDT.Rows.Add(FRow);
                                }
                            }
                        }
                        if (TestRowFlag)
                        {
                            //string SInvstCode = TestCode;
                            string SInvstCode = "";
                            string SInvstName = TestNM;
                            string SResultType = "V";
                            string SSeqNo = "";
                            //Inhouse
                            DataView INview = new DataView(Load.Tables[4]);
                            INview.RowFilter = "TESTCODE = '" + TestCode + "'";
                            DataTable INuniqueTable = INview.ToTable(true, "RESULTDATE", "TESTCODE");
                            //Outside
                            DataView OUTview = new DataView(Load.Tables[2]);
                            OUTview.RowFilter = "TESTCODE = '" + TestCode + "'";
                            DataTable OUTuniqueTable = OUTview.ToTable(true, "INVDATE", "TESTCODE");
                            var latestThreeDates = INuniqueTable.AsEnumerable().Select(r => r["RESULTDATE"].ToString()).Concat(OUTuniqueTable.AsEnumerable().Select(r => r["INVDATE"].ToString())).Distinct().OrderByDescending(d => d).Take(3).ToList();
                            DataRow FRow = INVSTDT.NewRow();
                            DataRow TestRow = INVSTDT.NewRow();
                            FRow["SEQNO"] = SSeqNo;
                            FRow["TESTCODE"] = TestCode;
                            FRow["TESTNAME"] = TestNM;
                            FRow["INVSTCODE"] = SInvstCode;
                            FRow["INVSTNAME"] = SInvstName;
                            FRow["RESULTTYPE"] = SResultType;
                            for (int i = 0; i < latestThreeDates.Count; i++)
                            {
                                string Val = "";
                                string InhouseYN = "N";
                                string dt = latestThreeDates[i];
                                FRow[("RESULTDATE" + (i + 1))] = dt;
                                TestRow[("RESULTDATE" + (i + 1))] = dt;
                                //InHouse Filter Data
                                DataRow[] DROuthouseFilterInvst = Load.Tables[2].Select("INVDATE = '" + dt + "' AND TESTCODE='" + TestCode + "' AND INVSETCODE='" + SInvstCode + "'");
                                DataRow[] DRInhouseFilterInvst = Load.Tables[4].Select("RESULTDATE = '" + dt + "' AND TESTCODE='" + TestCode + "' AND INVESTCODE='" + SInvstCode + "'");
                                if (DROuthouseFilterInvst.Length > 0)
                                {
                                    InhouseYN = "N";
                                    Val = DROuthouseFilterInvst[0]["RESULTDT"].ToString().Trim();
                                }
                                if (DRInhouseFilterInvst.Length > 0)
                                {
                                    InhouseYN = "Y";
                                    Val = DRInhouseFilterInvst[0]["RESULTDT"].ToString().Trim();
                                }
                                FRow[("INHOUSEYN" + (i + 1))] = InhouseYN;
                                FRow[("RESULTVALUE" + (i + 1))] = Val;
                            }
                            if (AddTestFlag)
                            {
                                //Add Test Row
                                TestRow["SEQNO"] = "";
                                TestRow["TESTCODE"] = TestCode;
                                TestRow["TESTNAME"] = TestNM;
                                TestRow["INVSTCODE"] = "";
                                TestRow["INVSTNAME"] = "";
                                TestRow["RESULTTYPE"] = "";
                                INVSTDT.Rows.Add(TestRow);
                                AddTestFlag = false;
                            }
                            INVSTDT.Rows.Add(FRow);
                        }
                    }
                }
            }
            DataRow DateR = DateDT.NewRow();
            for (int i = 1; i <= MaxDateColumn; i++)
            {
                int DateLength = INVSTDT.Select(("RESULTVALUE" + i + " <> ''")).Length;
                if (DateLength > 0)
                {
                    DateR[("DATE" + i + "YN")] = "Y";
                }
                else
                {
                    DateR[("DATE" + i + "YN")] = "N";
                }
            }
            DateDT.Rows.Add(DateR);
            foreach (DataRow row in INVSTDT.Rows)//Priyanka 09/12/2025
            {
                row["RESULTDATE1"] = GeneralFunction.GetDate(row["RESULTDATE1"].ToString().Trim());
                row["RESULTDATE2"] = GeneralFunction.GetDate(row["RESULTDATE2"].ToString().Trim());
                row["RESULTDATE3"] = GeneralFunction.GetDate(row["RESULTDATE3"].ToString().Trim());
            }
            //PRIYANKA 09/12/2025
            PACResultPatInfo.Columns.Add("PATNAME");
            PACResultPatInfo.Columns.Add("GENDER");
            PACResultPatInfo.Columns.Add("AGE");
            PACResultPatInfo.Columns.Add("TRANNO");
            PACResultPatInfo.Columns.Add("TRANDATE");
            PACResultPatInfo.Columns.Add("MRNO");
            PACResultPatInfo.Columns.Add("ADMISSIONDOCT");
            PACResultPatInfo.Columns.Add("HEIGHT");
            PACResultPatInfo.Columns.Add("WEIGHT");
            PACResultPatInfo.Columns.Add("BMI");
            if (Load.Tables.Count > 0 && Load.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in Load.Tables[0].Rows)
                {
                    DataRow newRow = PACResultPatInfo.NewRow();

                    newRow["PATNAME"] = row["PATNAME"];
                    newRow["GENDER"] = row["GENDER"].ToString().Trim() == "M" ? "Male" : row["GENDER"].ToString().Trim() == "F" ? "Female" : row["GENDER"].ToString().Trim() == "O" ? "Other" : "";
                    newRow["AGE"] = ("" + row["AGE"]).ToString() == "" ? "" : GeneralFunction.AgeFormat(("" + row["AGE"]).ToString());
                    newRow["TRANNO"] = row["TRANNO"];
                    newRow["TRANDATE"] = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim());
                    newRow["MRNO"] = row["MRNO"];
                    newRow["ADMISSIONDOCT"] = row["ADMISSIONDOCTOR"];
                    newRow["HEIGHT"] = row["HEIGHT"];
                    newRow["WEIGHT"] = row["WEIGHT"];
                    newRow["BMI"] = row["BMI"];

                    PACResultPatInfo.Rows.Add(newRow);
                }
            }
            HData = GeneralFunction.getHeaderFooter("", "", ""); // Abhishesh || 20260505
            DateDT.TableName = "DATESHOW";
            INVSTDT.TableName = "TBLRESULT";
            PACResultPatInfo.TableName = "INVSTRESULTPATINFO"; //PRIYANKA 09/12/2025
            HData.TableName = "HeaderFooter"; // Abhishesh || 20260505

            AllData.Tables.Add(DateDT);
            AllData.Tables.Add(INVSTDT);
            AllData.Tables.Add(HData); // Abhishesh || 20260505
            AllData.Tables.Add(PACResultPatInfo);//PRIYANKA 09/12/2025
            if (INVSTDT.Rows.Count == 0) //priyanka  21/03/2026
            {
                return null;
            }
            string reportPath = Path.Combine(HttpContext.Current.Server.MapPath("~/Report"), "rptPACResult.rpt");
            CrystalReportPdfResult crystal = new CrystalReportPdfResult();
            byte[] printarr = crystal.CrystalReportPdf(reportPath, AllData);
            return printarr;
        }

        public object GetMedicineList(string DrugName)
        {
            try
            {
                DataTable l_oDT = new DataTable();
                DataSet FreqDrugDs = new DataSet();
                DataSet NonFreqDrugDs = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                if (GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN").ToString().Trim() == "Y")
                {
                    NonFreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetGenericList(DrugName)));
                }
                else
                {
                    NonFreqDrugDs.ReadXml(new StringReader(ObjOncologyEMRClient.GetDrugList(DrugName)));
                }
                if (NonFreqDrugDs != null && NonFreqDrugDs.Tables.Count > 0)
                {
                    string GenYN = GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN").ToString().Trim();
                    l_oDT = NonFreqDrugDs.Tables["Table"];
                    var rows = (from DataRow row in l_oDT.Rows
                                select new
                                {
                                    MTRLCODE = GenYN == "Y" ? ("" + row["GENERICID"]).Trim() : ("" + row["MTRLCODE"]).Trim(),
                                    MTRLNAME = GenYN == "Y" ? ("" + row["GENERICNAM"]).Trim() : ("" + row["GENERICNAM"]).Trim(),
                                    GENERICNAM = ("" + row["GENERICNAM"]).Trim(),
                                    GENERICID = ("" + row["GENERICID"]).Trim(),
                                    MTRLFORMID = ("" + row["MTRLFORMID"]).Trim(),

                                }).ToArray();
                    return rows;
                }
                else
                {
                    return "[]";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetPACHistList(string mrno, string FromDate, string ToDate)
        {
            try
            {
                var DoctLst = oncoClient.GetDoctLst("", "D");
                DataSet HistDS = new DataSet();
                FromDate = GeneralFunction.GetDateInSpecifiedFormat(FromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                ToDate = GeneralFunction.GetDateInSpecifiedFormat(ToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                HistDS.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACList(FromDate, ToDate, mrno, "", "")))));
                if (HistDS.Tables.Count > 0 && HistDS.Tables[0].Rows.Count > 0)
                {
                    OncologyEMRClient Oncoser = new OncologyEMRClient();
                    var SpecList = oncoClient.GetSpecialistnList();
                    var rows = (from row1 in HistDS.Tables[0].AsEnumerable()
                                select new
                                {
                                    PACCONSNO = ("" + row1["PACCONSNO"]).ToString(),
                                    MRNO = mrno,
                                    DOCTNAME = ("" + row1["DOCTNAME"]).ToString(),
                                    SURGADVDATE = GeneralFunction.GetDate(("" + row1["SURGADVDATE"]).ToString()),
                                    SURGNMADVICE = ("" + row1["SURGNMADVICE"]).ToString(),
                                    SURGADVTYPE = ("" + row1["SURGADVTYPE"]).ToString(),
                                    PACSTATUS = ("" + row1["PACSTATUS"]).ToString(),
                                    PACFITDATE = ("" + row1["PACFITDATE"]).ToString() == "" ? "" : GeneralFunction.GetDate(("" + row1["PACFITDATE"]).ToString()),
                                    PACFITTIME = GeneralFunction.ConvertTimeTo24Hour(("" + row1["PACFITTIME"]).ToString()),  // Abhishesh || 20260323
                                    PACDONEBY = ("" + row1["PACDONEBY"]).ToString().Trim() == "" ? "" : (DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).Count() > 0 ? DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).FirstOrDefault().Text : ("" + row1["PACDONEBY"]).ToString().Trim()),
                                    PACDONESPEC = ("" + row1["PACDONEBY"]).ToString().Trim() == "" ? "" : GeneralFunction.GetSpecialityDoctor(DoctLst, SpecList, ("" + row1["PACDONEBY"]).ToString().Trim(), ""),
                                    ASARISKLEVEL = row1["ASARISKLEVEL"].ToString().Trim() == "L" ? "Low" ://PRIYANKA 20/11/2025
                                                  row1["ASARISKLEVEL"].ToString().Trim() == "M" ? "Medium" :
                                                  row1["ASARISKLEVEL"].ToString().Trim() == "H" ? "High" : ""
                                }).ToArray();
                    return rows;
                }
                else
                {
                    return "";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetPACHistoryJson(string MRNO)
        {
            var DoctLst = oncoClient.GetDoctLst("", "D");

            DataSet HistDS = new DataSet();

            HistDS.ReadXml(
                new XmlTextReader(
                    new StringReader(
                        oncoClient.GetPACList("", "", MRNO, "", "")
                    )
                )
            );

            if (HistDS.Tables.Count > 0 && HistDS.Tables[0].Rows.Count > 0)
            {
                var HistListArry =
                    (from row1 in HistDS.Tables[0].AsEnumerable()
                     select new
                     {
                         PACCONSNO = ("" + row1["PACCONSNO"]).ToString(),
                         MRNO = MRNO,
                         DOCTNAME = row1["DOCTNAME"].ToString(),
                         SURGADVDATE = GeneralFunction.GetDate(
                                            ("" + row1["SURGADVDATE"]).ToString()
                                       ),
                         SURGNMADVICE = row1["SURGNMADVICE"].ToString(),
                         SURGADVTYPE = row1["SURGADVTYPE"].ToString(),
                         PACSTATUS = row1["PACSTATUS"].ToString(),
                         PACFITDATE =
                            ("" + row1["PACFITDATE"]).ToString() == ""
                            ? ""
                            : GeneralFunction.GetDate(
                                ("" + row1["PACFITDATE"]).ToString()
                              ),
                         PACFITTIME = row1["PACFITTIME"].ToString(),
                         PACDONEBY = ("" + row1["PACDONEBY"]).ToString().Trim() == "" ? "" : (DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).Count() > 0 ? DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).FirstOrDefault().Text : ("" + row1["PACDONEBY"]).ToString().Trim()),
                         ASARISKLEVEL = row1["ASARISKLEVEL"].ToString(),
                         STATUS = row1["STATUS"].ToString(),
                         OTNOTESNO = row1["OTNOTESNO"].ToString()
                     }).ToArray();

                return HistListArry;
            }

            return new object[] { };
        }
    }
    #endregion
    // Added By Roshan CIMS 20251012
    #region CIMS
    public class CIMSModel
    {
        public object GetDrugInformation(string DrugCode)
        {
            Bl_Cims_Response BlResult = new Bl_Cims_Response();
            using (LisInterfaceClient lis = new LisInterfaceClient())
            {
                BlResult = lis.getDrugInformationHtml(DrugCode);
            }
            if (BlResult != null)
            {
                var result = new
                {
                    AlertYN = BlResult.AlertYN,
                    HtmlText = BlResult.HtmlText,
                    Status = BlResult.status,
                    ColorName = BlResult.Color

                };
                return result;
            }
            else
            {
                return new { Status = "No Data Found" };
            }
        }

        public object GetDrugInteration(string DrugCodes, string Type, string Mrno, string Ipno)
        {
            List<string> drugCodesArray = Newtonsoft.Json.JsonConvert.DeserializeObject<List<string>>(DrugCodes ?? "[]");
            Bl_Cims_Response BlResult = new Bl_Cims_Response();
            using (LisInterfaceClient sc = new LisInterfaceClient())
            {
                BlResult = sc.getDrug2DrugInteration(drugCodesArray.ToArray(), Type, Mrno, Ipno); // Changed by Dhananjay 20260326
            }
            if (BlResult != null)
            {
                var result = new
                {
                    AlertYN = BlResult.AlertYN,
                    HtmlText = BlResult.HtmlText,
                    Status = BlResult.status,
                    ColorName = BlResult.Color
                };
                return result;
            }
            else
            {
                return new { Status = "No Data Found" };
            }
        }
        public object GetDrugDuplicate(string DrugCodes, string Type)
        {
            List<string> drugCodesArray = Newtonsoft.Json.JsonConvert.DeserializeObject<List<string>>(DrugCodes ?? "[]");
            Bl_Cims_Response BlResult = new Bl_Cims_Response();
            using (LisInterfaceClient sc = new LisInterfaceClient())
            {
                BlResult = sc.GetDrugDuplicate(drugCodesArray.ToArray(), Type);
            }
            if (BlResult != null)
            {
                var result = new
                {
                    AlertYN = BlResult.AlertYN,
                    HtmlText = BlResult.HtmlText,
                    Status = BlResult.status,
                    ColorName = BlResult.Color
                };
                return result;
            }
            else
            {
                return new { Status = "No Data Found" };
            }
        }
        public object GetDrugAllergy(string DrugCodes, string Type)
        {
            List<string> drugCodesArray = Newtonsoft.Json.JsonConvert.DeserializeObject<List<string>>(DrugCodes ?? "[]");
            Bl_Cims_Response BlResult = new Bl_Cims_Response();
            using (LisInterfaceClient sc = new LisInterfaceClient())
            {
                BlResult = sc.GetDrugDuplicate(drugCodesArray.ToArray(), Type); // Need to Change Function for Allergy
            }
            if (BlResult != null)
            {
                var result = new
                {
                    AlertYN = BlResult.AlertYN,
                    HtmlText = BlResult.HtmlText,
                    Status = BlResult.status,
                    ColorName = "green"
                };
                return result;
            }
            else
            {
                return new { Status = "No Data Found" };
            }
        }
    }
    #endregion CIMS
    // End By Roshan CIMS 20251012
    #region "Surgical History"
    public class SurgicalHist : BL_SurgeryHistory
    {
        public string SURGTIME { get; set; }
        public string DOCTSP { get; set; }
        public string OTNotesNo { get; set; }



        public string SaveSurgicalHistory(string MRNO, string UniqueId, string SurgeonDoctorName, string SurgeryDate, string SurgeryName, string SurgeryNotes, string gact)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                BL_SurgeryHistory bl = new BL_SurgeryHistory();
                string SurgDate = GeneralFunction.GetDateInSpecifiedFormat(SurgeryDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                bl.MRNO = MRNO;
                bl.SurgeonDoctorName = SurgeonDoctorName;
                bl.SurgeryDate = SurgDate;
                bl.SurgeryName = SurgeryName;
                bl.SurgeryNotes = SurgeryNotes;

                if (gact != "N")
                {
                    bl.UniqueId = int.Parse(UniqueId);
                }

                if (gact == "N")
                {
                    bl.TranMode = 1;
                }
                else if (gact == "E")
                {
                    bl.TranMode = 2;
                }
                Result = Oncoser.SaveSurgeryHistoryTran(bl);

                return Result;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }


        public object GetSurgicalHistoryData(string strMrNo)
        {
            try
            {
                DataSet load = new DataSet();
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetSugeryHistoryDetails(strMrNo)));

                List<SurgicalHist> resultList = new List<SurgicalHist>();

                if (load.Tables.Count > 0)
                {
                    OncologyEMRClient oncoClient = new OncologyEMRClient();
                    DataTable tbl = load.Tables[0];
                    var DoctLst = oncoClient.GetDoctLst("", "D");
                    var SpecList = oncoClient.GetSpecialistnList();
                    foreach (DataRow row in tbl.Rows)
                    {
                        SurgicalHist item = new SurgicalHist
                        {
                            UniqueId = Convert.ToInt32(row["UNIQUEID"]),
                            SurgeonDoctorName = row["SURGEONDRNAME"].ToString(),
                            SurgeryName = row["SURGERYNAME"].ToString(),
                            SurgeryDate = GeneralFunction.GetDate(row["SURGDATE"].ToString()),
                            SurgeryNotes = row["SURGERYNOTES"].ToString(),
                            SURGTIME = GeneralFunction.ConvertTimeTo24Hour(row["SURGTIME"].ToString()), // Abhishesh || 20260323
                            DOCTSP = ("" + row["SURGEONDRNAME"]).ToString().Trim() == "" ? "" : GeneralFunction.GetSpecialityDoctor(DoctLst, SpecList, "", ("" + row["SURGEONDRNAME"]).ToString().Trim()),
                            OTNotesNo = row["OTNOTESNO"].ToString(),
                        };
                        resultList.Add(item);
                    }
                }

                return resultList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
    #endregion

    //Added by Murali on 09/03/2022 for Treatment Plan Completed Status Report
    //******************************************************************************
    #region "PlanCompletedStatus"

    public class PlanCompletedStatus
    {
        public string strFromDt { get; set; }
        public string strToDt { get; set; }
        public string MRNo { get; set; }
        public string PlanNo { get; set; }
        public string PatName { get; set; }

        public object GetPlanCompletedStatus(string MRNumber, string FromDT, string ToDT, string PatName, string strPlanNo)
        {
            OncologyClient Onco = new OncologyClient();
            DataTable dtPlanComplete = new DataTable();
            DataSet dsPlanComplete = new DataSet();
            object jsonData = "";
            DataTable dt = new DataTable();
            string Patdob = ""; string InDate = "";
            FromDT = GeneralFunction.GetDateInSpecifiedFormat(FromDT, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            ToDT = GeneralFunction.GetDateInSpecifiedFormat(ToDT, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            dsPlanComplete.ReadXml(new XmlTextReader(new StringReader(Onco.GetPlanCompletedDet(MRNumber, FromDT, ToDT, PatName, strPlanNo))));
            if (dsPlanComplete.Tables.Count > 0)
            {
                dt = dsPlanComplete.Tables[0].Copy();

                jsonData = (from DataRow row in dt.Rows
                            select new
                            {
                                //SERIALNO = row["IBMROWID"].ToString(),
                                PLANNO = row["TRANID"].ToString(),
                                MRNO = row["MRNO"].ToString(),
                                PATNAME = row["PATNAME"].ToString(),
                                ADDRESS = row["PATADDR1"].ToString() + "' " + row["PATADDR2"].ToString() + ", " + row["PATADDR3"].ToString(),
                                PATCATG = row["PATCATGNM"].ToString().Trim(),
                                COMPANY = row["COMPNAME"].ToString().Trim(),
                                TARIFF = row["TARIFFDESC"].ToString().Trim(),
                                PAYTYPE = row["PAYTYPDESC"].ToString().Trim(),
                                CONTACTNO = row["PATMOBILE"].ToString().Trim(),
                                CHEMONAME = row["NAME"].ToString().Trim(),
                                TOTALCYCLES = row["TOTALCYCLE"].ToString().Trim(),
                                COMPLETEDCYCLES = row["COMPCYCLES"].ToString().Trim(),
                                STATUS = (row["TOTALCYCLE"].ToString().Trim() == row["COMPCYCLES"].ToString().Trim() ? "Completed" : "Pending")
                            }).ToArray();
            }

            return jsonData;
        }

        public DataSet PrintPlanCompleteStatusLst(string data, string frmdate, string todate)
        {
            DataSet AllData = new DataSet();
            DataTable HData = new DataTable();
            DataTable df = new DataTable();
            DataTable search = new DataTable();
            df = JsonConvert.DeserializeObject<DataTable>(data);
            df.TableName = "PatTrackDTWiseLst";
            int NoOFRecords = df.Rows.Count;
            HData = GeneralFunction.getHeaderFooter("Patient Tracking Datewise List", frmdate, todate);
            HData.TableName = "HeaderFooter";
            AllData.Tables.Add(df);
            AllData.Tables.Add(HData);

            AllData.Tables.Add(GeneralFunction.GetSearchFilterData("", "", NoOFRecords));
            return AllData;
        }
        public string ExcelBindPlanCompleteLst(string data, string FrmDate, string ToDate, string searchCriteria)
        {
            DataTable df = new DataTable();
            df = JsonConvert.DeserializeObject<DataTable>(data);
            if (df.Rows.Count > 0)
            {
                df.Columns["PLANNO"].ColumnName = "Plan No";
                df.Columns["MRNO"].ColumnName = "MR No";
                df.Columns["PATNAME"].ColumnName = "Patient Name";
                df.Columns["ADDRESS"].ColumnName = "Address";
                df.Columns["PATCATG"].ColumnName = "Pat. Category";
                df.Columns["COMPANY"].ColumnName = "Company";
                df.Columns["TARIFF"].ColumnName = "Tariff";
                df.Columns["PAYTYPE"].ColumnName = "Pay Type";
                df.Columns["CONTACTNO"].ColumnName = "Contact No.";
                df.Columns["CHEMONAME"].ColumnName = "Chemotherapy Name";
                df.Columns["TOTALCYCLES"].ColumnName = "Planned Cycles";
                df.Columns["COMPLETEDCYCLES"].ColumnName = "Completed Cycles";
                df.Columns["STATUS"].ColumnName = "Status";

                return GeneralFunction.getHeaderFooterExcel("Treatment Plan Completion Status List", FrmDate, ToDate);
            }
            else return "";

        }
        #endregion "PlanCompletedStatus"
        //******************************************************************************
    }
    #region TumorBoardSchedule
    public class TumorBoardSchedule
    {
        public string strFromDt { get; set; }
        public string strToDt { get; set; }
        public string MRNo { get; set; }
        public string PlanNo { get; set; }
        public string PatName { get; set; }

        public object GetDoctorsMeetingDet(String Doctorcode, string type)
        {
            OncologyClient Onco = new OncologyClient();
            DataTable dtPlanComplete = new DataTable();
            DataSet dsPlanComplete = new DataSet();
            object jsonData = "";
            DataTable dt = new DataTable();
            //string Patdob = ""; string InDate = "";
            dsPlanComplete.ReadXml(new XmlTextReader(new StringReader(Onco.GetDoctorsMeetingDet(Doctorcode, type))));
            if (dsPlanComplete.Tables.Count > 0)
            {
                dt = dsPlanComplete.Tables[0].Copy();

                jsonData = (from DataRow row in dt.Rows
                            select new
                            {
                                //SERIALNO = row["IBMROWID"].ToString(),
                                TRANNO = row["TRANNO"].ToString(),
                                MRNO = row["MRNO"].ToString(),
                                PATNAME = row["PATNAME"].ToString(),
                                PATAGE = row["PATAGE"].ToString(),
                                PATDOB = GeneralFunction.GetDate(row["PATDOB"].ToString().Trim()),
                                GENDER = row["GENDER"].ToString().Trim(),
                                TBMSDATE = GeneralFunction.GetDate(row["TBMSDATE"].ToString().Trim()),
                                TBMSTIME = GeneralFunction.ConvertTimeTo24Hour(row["TBMSTIME"].ToString().Trim()), // Abhishesh || 20260323
                                STATUS = row["STATUS"].ToString().Trim(),
                                TUMOR_REFER = row["TBRREFYN"].ToString().Trim()
                            }).ToArray();
            }

            return jsonData;
        }
        //print for Tumor Report - Added By Roshan 25-10-2025
        public DataSet PrintTumorBrdDisc(string MrNo, string TranNo)
        {
            OncologyModel model = new OncologyModel();
            OncologyClient onclgclnt = new OncologyClient();
            CommonServiceClient comserv = new CommonServiceClient();
            var Surgery = comserv.GetAllSurgeryLst();
            var Chemo = comserv.GetChemoNameLst();
            DataSet load = new DataSet();
            object jsonData = "";
            var DoctDetGrid = "";
            DataTable PatDet = new DataTable("TumorBoardDisc");
            DataTable External = new DataTable("ExternalDoct");
            DataTable dtInvestDet = new DataTable();
            PatDet.Columns.Add("MRNO");
            PatDet.Columns.Add("PATNAME");
            PatDet.Columns.Add("GENDER");
            PatDet.Columns.Add("AGE");
            PatDet.Columns.Add("DIAGNOSIS");
            PatDet.Columns.Add("RECOMMENDATIONS");
            PatDet.Columns.Add("CONSDATE");
            PatDet.Columns.Add("TUMORBOARDDATE");
            PatDet.Columns.Add("MEETINGTIME");
            PatDet.Columns.Add("FINALCAREPLAN");
            PatDet.Columns.Add("RESLIABILITY");
            PatDet.Columns.Add("REASONAGED");
            PatDet.Columns.Add("REASONLOWTUMOR");
            PatDet.Columns.Add("REASONOTHER");
            PatDet.Columns.Add("REASONOTH");
            PatDet.Columns.Add("GENERICALT");
            PatDet.Columns.Add("NOGENERICALT");
            PatDet.Columns.Add("RESCHEDULE_DATE_TIME");
            PatDet.Columns.Add("RESCHEDULE_TIME");
            PatDet.Columns.Add("RESCHEDULE_REMARKS");
            PatDet.Columns.Add("DOCTNAME");

            load.ReadXml(new XmlTextReader(new StringReader(onclgclnt.GetTumorBoardPatList("", "", "", MrNo, "S", TranNo, "", ""))));
            if (load.Tables.Count > 0)
            {
                if (load.Tables.Contains("TumorBrdEntryDet"))
                {
                    if (load.Tables["TumorBrdEntryDet"].Rows.Count > 0)
                    {

                        for (int i = 0; i < load.Tables["TumorBrdEntryDet"].Rows.Count; i++)
                        {
                            PatDet.Rows.Add();
                            DataRow dr = load.Tables["TumorBrdEntryDet"].Rows[i];
                            PatDet.Rows[i]["MRNO"] = dr["MRNO"].ToString();
                            PatDet.Rows[i]["PATNAME"] = dr["SALUNAME"] + " " + dr["PATNAME"].ToString();
                            PatDet.Rows[i]["GENDER"] = (dr["PATSEX"].ToString() == "M" ? "Male" : (dr["PATSEX"].ToString() == "F" ? "Female" : ""));
                            PatDet.Rows[i]["AGE"] = dr["PATAGE"].ToString();
                            PatDet.Rows[i]["DIAGNOSIS"] = dr["DIAGNOSIS"].ToString();
                            PatDet.Rows[i]["RECOMMENDATIONS"] = dr["RECOMMENDATIONS"].ToString();
                            PatDet.Rows[i]["CONSDATE"] = GeneralFunction.GetDate(dr["TRANDATE"].ToString());
                            PatDet.Rows[i]["TUMORBOARDDATE"] = GeneralFunction.GetDate(dr["TBMSDATE"].ToString());
                            PatDet.Rows[i]["MEETINGTIME"] = GeneralFunction.ConvertTimeTo12Hour(dr["TBMSTIME"].ToString().Trim());
                            PatDet.Rows[i]["FINALCAREPLAN"] = dr["FINALCAREPLAN"].ToString();
                            PatDet.Rows[i]["RESLIABILITY"] = dr["RESLIABILITY"].ToString().Trim() == "" ? "" : dr["RESLIABILITY"].ToString() == "Y" ? "Appropriate" : "In-Appropriate";
                            //PatDet.Rows[i]["REASONAGED"] = dr["REASONAGED"].ToString() == "Y" ? "Aged Issue" : "";
                            //PatDet.Rows[i]["REASONLOWTUMOR"] = dr["REASONLOWTUMOR"].ToString() == "Y" ? "Low Tumor Cellularity" : "";
                            //PatDet.Rows[i]["REASONOTHER"] = dr["REASONOTHER"].ToString() == "Y" ? "Others" : "";
                            PatDet.Rows[i]["REASONOTH"] = dr["REASONOTH"].ToString();
                            PatDet.Rows[i]["DOCTNAME"] = dr["DOCTNAME"].ToString();
                            string combinedReason = string.Join(", ", new[]
                          {
                          dr["REASONAGED"].ToString() == "Y" ? "Aged Issue" : "",
                          dr["REASONLOWTUMOR"].ToString() == "Y" ? "Low Tumor Cellularity" : "",
                          }.Where(x => !string.IsNullOrEmpty(x)));
                            PatDet.Rows[i]["REASONAGED"] = combinedReason;
                            PatDet.Rows[i]["GENERICALT"] = dr["GENERICALT"].ToString().Trim() == "" ? "" : dr["GENERICALT"].ToString().Trim() == "Y" ? "Yes" : " No";
                            PatDet.Rows[i]["NOGENERICALT"] = dr["NOGENERICALT"].ToString().Trim() == "3" ? ">=3" : dr["NOGENERICALT"].ToString();
                            PatDet.Rows[i]["RESCHEDULE_DATE_TIME"] = dr["RESCHDDATE"].ToString().Trim() == "" ? "" : GeneralFunction.GetDate(dr["RESCHDDATE"].ToString());
                            PatDet.Rows[i]["RESCHEDULE_REMARKS"] = dr["RESCHDREMARKS"].ToString().Trim() == "" ? "" : dr["RESCHDREMARKS"].ToString().Trim();
                            PatDet.Rows[i]["RESCHEDULE_TIME"] = dr["RESCHDTIME"].ToString().Trim() == "" ? "" : GeneralFunction.ConvertTimeTo12Hour(dr["RESCHDTIME"].ToString());
                            //load.Tables["SignDet"].Rows[i]["SIGNATURE1"] = Convert.FromBase64String(dr["SIGNATURE"].ToString());
                        }
                    }
                }
            }

            if (load.Tables.Contains("DoctorDet"))
            {
                DataTable dt = load.Tables["DoctorDet"];

                // Remove old DoctorDet and ExternalDoctor first
                if (load.Tables.Contains("DoctorDet")) load.Tables.Remove("DoctorDet");
                if (load.Tables.Contains("ExternalDoctor")) load.Tables.Remove("ExternalDoctor");

                // ------- Internal Doctor (I) -------
                var internalRows = dt.Select("DOCTTYPE = 'I'");
                DataTable internalDt = dt.Clone();
                internalDt.TableName = "DoctorDet"; // Internal doctor table

                if (internalRows.Length > 0)
                {
                    foreach (DataRow r in internalRows)
                        internalDt.ImportRow(r);
                }
                else
                {
                    internalDt.Rows.Add(internalDt.NewRow()); // Add blank row if no internal doctor
                }

                load.Tables.Add(internalDt);

                // ------- External Doctor (E) -------
                var externalRows = dt.Select("DOCTTYPE = 'E'");
                DataTable externalDt = dt.Clone();
                externalDt.TableName = "ExternalDoctor";

                if (externalRows.Length > 0)
                {
                    foreach (DataRow r in externalRows)
                        externalDt.ImportRow(r);
                }
                else
                {
                    externalDt.Rows.Add(externalDt.NewRow()); // Add blank row if no external doctor
                }

                load.Tables.Add(externalDt);
            }
            else
            {
                // If DoctorDet is missing entirely, create blank tables
                DataTable internalDt = new DataTable("DoctorDet");
                internalDt.Columns.Add("DOCTTYPE");
                internalDt.Columns.Add("DOCTORNAME");
                internalDt.Rows.Add(internalDt.NewRow());
                load.Tables.Add(internalDt);

                DataTable externalDt = internalDt.Clone();
                externalDt.TableName = "ExternalDoctor";
                externalDt.Rows.Add(externalDt.NewRow());
                load.Tables.Add(externalDt);
            }

            // ---------- TreatmentDet ----------
            DataTable TreatmentDet;
            if (load.Tables.Contains("TreatmentDet"))
            {
                TreatmentDet = load.Tables["TreatmentDet"];
            }
            else
            {
                TreatmentDet = new DataTable("TreatmentDet");
                TreatmentDet.Columns.Add("TREATMENTNAME");
                TreatmentDet.Columns.Add("TREATMENTDET");
                TreatmentDet.Columns.Add("TREATMENTDATE");
                TreatmentDet.Columns.Add("REMARKS");
                TreatmentDet.Columns.Add("CYCLENO");
                TreatmentDet.Rows.Add(TreatmentDet.NewRow()); // Add blank row
                load.Tables.Add(TreatmentDet);
            }


            // Populate TreatmentDet using Surgery mapping
            for (int i = 0; i < TreatmentDet.Rows.Count; i++)
            {
                var dr = TreatmentDet.Rows[i];
                string currentValue = dr["TREATMENTDET"].ToString().Trim();
                string treatmentName = dr["TREATMENTNAME"].ToString().Trim(); // assuming column with type name like "Chemo" or "Surgery"
                string mappedValue = currentValue;

                if (treatmentName.Equals("Chemotherapy", StringComparison.OrdinalIgnoreCase))
                {
                    mappedValue = Chemo
                        .Where(x => x.Value == currentValue)
                        .Select(x => x.Text)
                        .FirstOrDefault() ?? currentValue;
                }
                else if (treatmentName.Equals("Surgery", StringComparison.OrdinalIgnoreCase))
                {
                    mappedValue = Surgery
                        .Where(x => x.Value == currentValue)
                        .Select(x => x.Text)
                        .FirstOrDefault() ?? currentValue;
                }
                // else keep original value

                dr["TREATMENTDET"] = mappedValue;
                dr["TREATMENTDATE"] = GeneralFunction.GetDate(dr["TREATMENTDATE"].ToString());
            }


            //ICD
            DataSet DiagICDODs = GetDiagICDOData(MrNo);
            DataTable icdDiagnosis = new DataTable("ICDDIAGNOSIS");
            icdDiagnosis.Columns.Add("CODE");
            icdDiagnosis.Columns.Add("DESC");
            var LstDiagnosis = comserv.DDICDLst();
            foreach (DataRow row in DiagICDODs.Tables[0].Rows)
            {
                DataRow newRow = icdDiagnosis.NewRow();
                newRow["CODE"] = row["ICDCODE"].ToString().Trim();
                newRow["DESC"] = LstDiagnosis
                               .Where(x => x.Value == row["ICDCODE"].ToString().Trim())
                               .Select(x => x.Text)
                               .FirstOrDefault() ?? "-";

                icdDiagnosis.Rows.Add(newRow);
            }
            icdDiagnosis.TableName = "ICDDIAGNOSIS";
            load.Tables.Add(icdDiagnosis);

            // ICDO
            CommonServiceClient Onco = new CommonServiceClient();
            var HistoList = Onco.ICDHISTOLst("");
            DataTable icdo = new DataTable("ICDO");
            icdo.Columns.Add("TCODE");
            icdo.Columns.Add("TDESC");
            icdo.Columns.Add("HDESC");
            icdo.Columns.Add("GDESC");
            icdo.Columns.Add("TNM");
            icdo.Columns.Add("STAGEUPDATED");
            icdo.Columns.Add("SUBSITE");
            icdo.Columns.Add("SITE");

            var HistoGradeLst = GeneralFunction.GetHitologyGrade();
            string tnm = "";
            string STAGE = "";
            string SUBSITE = "";
            string SITE = "";

            // ✅ Compute TNM & STAGE once outside
            if (DiagICDODs.Tables.Count > 3 && DiagICDODs.Tables[3].Rows.Count > 0)
            {
                DataRow row = DiagICDODs.Tables[3].Rows[0]; // first row from table 3

                tnm = string.Join(", ",
                    from DataRow tnmRow in DiagICDODs.Tables[3].Rows
                    select (tnmRow["TNMPREFIX"].ToString().Trim() + "-"
                          + tnmRow["T"].ToString().Trim()
                          + tnmRow["N"].ToString().Trim()
                          + tnmRow["M"].ToString().Trim()).Trim());

                STAGE = row["STAGE"].ToString().Trim();

                string tnmSiteCode = row["TNMSITECODE"].ToString().Trim();
                string tnmSubSiteCode = row["TNMSUBSITECODE"].ToString().Trim();

                SITE = string.IsNullOrEmpty(tnmSiteCode) ? "" : model.GetSiteSubSite(tnmSiteCode, "");
                SUBSITE = string.IsNullOrEmpty(tnmSubSiteCode) ? "" : model.GetSiteSubSite(tnmSiteCode, tnmSubSiteCode);
            }



            if (DiagICDODs.Tables.Count > 4 && DiagICDODs.Tables[4].Rows.Count > 0)
            {
                foreach (DataRow row in DiagICDODs.Tables[4].Rows)
                {
                    string topoCode = row["TOPOCODE"] != null ? row["TOPOCODE"].ToString().Trim() : "-";
                    string topoDesc = row["TOPODESC"] != null ? row["TOPODESC"].ToString().Trim() : "-";
                    string hcode = row["HCODE"] != null ? row["HCODE"].ToString().Trim() : "-";

                    string HDESC = row["HCODE"].ToString().Trim() == "" ? "" :
                        (HistoList.Any(x => x.Value == row["HCODE"].ToString().Trim())
                            ? HistoList.First(x => x.Value == row["HCODE"].ToString().Trim()).Text
                            : "");

                    string grade = row["HGRADE"] != null ? row["HGRADE"].ToString().Trim() : "-";
                    string gradeType = row["HISTOGRADETYPE"] != null ? row["HISTOGRADETYPE"].ToString().Trim() : "-";

                    // Find grade name
                    string gradeName = "";
                    if (!string.IsNullOrEmpty(grade))
                    {
                        foreach (var item in HistoGradeLst)
                        {
                            if (item.Value == grade && item.GradeType == gradeType)
                            {
                                gradeName = item.Text;
                                break;
                            }
                        }
                    }

                    // Final CODE + DIAGNAME
                    string code = (topoCode + hcode + " " + grade).Trim();
                    string TopoName = topoCode + topoDesc;
                    string Histology = hcode + HDESC;
                    string GradeDetails = grade + gradeName;
                    string diagName = topoDesc + HDESC + gradeName;
                    if (!string.IsNullOrEmpty(hcode))
                    {
                        diagName += " " + hcode;
                    }

                    // Add to ICDO table
                    DataRow newRow = icdo.NewRow();
                    newRow["TCODE"] = code;
                    newRow["TDESC"] = diagName;
                    newRow["HDESC"] = Histology;
                    newRow["GDESC"] = GradeDetails;
                    newRow["TNM"] = tnm;
                    newRow["STAGEUPDATED"] = STAGE;
                    newRow["SUBSITE"] = SUBSITE;
                    newRow["SITE"] = SITE;
                    icdo.Rows.Add(newRow);
                }
            }

            icdo.TableName = "ICDO";
            load.Tables.Add(icdo);


            DataTable HData = new DataTable();
            var formlist = "Medical Oncology - Nusing Sheet";
            HData = GeneralFunction.getHeaderFooter(formlist, "", "");
            if (HData.Rows.Count > 0 && HData.Columns.Contains("PrintDateTime"))
            {
                HData.Rows[0]["PrintDateTime"] =
                    GeneralFunction.ConvertDateWithTimeTo12Hour(HData.Rows[0]["PrintDateTime"].ToString());
            }
            HData.TableName = "HeaderFooter";
            load.Tables.Add(HData);
            load.Tables.Add(PatDet);
            load.Tables.Remove(load.Tables["TumorBrdEntryDet"]);
            //foreach (DataTable table in load.Tables)
            //{
            //    if(table.Rows.Count == 0)
            //    {
            //        table.Rows.Add();
            //    }
            //}
            return load;
        }
        public DataSet GetDiagICDOData(string Mrno)
        {
            OncologyClient Onco = new OncologyClient();
            DataSet load = new DataSet();
            load.ReadXml(new XmlTextReader(new StringReader(Onco.GetPatDiagVitalHistory(Mrno))));
            return load;
        }
    }

    #endregion TumorBoardSchedule

    //Pournima 27th Oct 2025
    #region OutsideInvestigation
    public class OutsideInvstMdl
    {
        public string Gaction { get; set; }
        public string InvstData { get; set; }
        public string ResultInvstData { get; set; }
        public string MRNO { get; set; }
        public string TRANNO { get; set; }
        public string strXMLString { get; set; }
        public string TranMode { get; set; }
        public string ModuleId { get; set; }
        public string IPAddress { get; set; }
        public string strUserId { get; set; }

        CommonServiceClient Comm = new CommonServiceClient();
        OncologyEMRClient oncoClient = new OncologyEMRClient();

        public void BindPACDtls(OutsideInvstMdl Mdl)
        {
            Mdl.Gaction = "N";
            //  Mdl.cmbAneasType = Comm.GetAnaesthTypeList();
            DataSet ListLoad = new DataSet();
            DataTable ListLoadDT = new DataTable();
            if (Mdl.MRNO != "")
            {
                DataSet Load = new DataSet();
                DataTable LoadDT = new DataTable();
                Load.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACDetails(Mdl.MRNO, "")))));
                if (Load.Tables.Count > 0 && Load.Tables[0].Rows.Count > 0)
                {
                    LoadDT = Load.Tables[0];
                    //BindPACProperty(Mdl, ListLoadDT, LoadDT);
                }
                DataTable TableResult = new DataTable();
                BindInvstData(Mdl, TableResult, Load);
                if (TableResult.Rows.Count > 0)
                {
                    Array ResutArry = (from row1 in TableResult.AsEnumerable()
                                       select new
                                       {
                                           INVDATE = GeneralFunction.GetDate(("" + row1["INVDATE"]).ToString()),
                                           INVINHOUSEDATE = GeneralFunction.GetDate(("" + row1["INVINHOUSEDATE"]).ToString()),
                                           TESTCODE = row1["TESTCODE"],
                                           INVSETCODE = row1["INVESTCODE"],
                                           INVSETDESC = row1["INVESTDESC"],
                                           RESULTTYPE = row1["RESULTTYPE"],
                                           SEQNO = row1["SEQNO"],
                                           RESULTDT = row1["RESULTDT"],
                                           INRESULTDT = row1["INRESULTDT"],
                                       }).ToArray();
                    Mdl.ResultInvstData = Newtonsoft.Json.JsonConvert.SerializeObject(ResutArry);
                }
            }
        }

        public void BindInvstData(OutsideInvstMdl Mdl, DataTable TableResult, DataSet Load)
        {
            TableResult.Columns.Add("INVDATE");
            TableResult.Columns.Add("INVINHOUSEDATE");
            TableResult.Columns.Add("TESTCODE");
            TableResult.Columns.Add("INVESTCODE");
            TableResult.Columns.Add("INVESTDESC");
            TableResult.Columns.Add("RESULTTYPE");
            TableResult.Columns.Add("SEQNO");
            TableResult.Columns.Add("RESULTDT");
            TableResult.Columns.Add("INRESULTDT");
            TableResult.Columns.Add("TESTNAME");
            if (Load.Tables.Count > 3 && Load.Tables[3].Rows.Count > 0)
            {
                OncologyEMR.LabServRef.LaboratoryClient LabServ = new OncologyEMR.LabServRef.LaboratoryClient();

                DataTable ADVTESTDT = new DataTable();
                ADVTESTDT = Load.Tables[3];
                Array AdvTestArry = (from row1 in ADVTESTDT.AsEnumerable()
                                     orderby Convert.ToInt32(row1["SEQNO"]) ascending
                                     select new
                                     {
                                         SEQNO = row1["SEQNO"],
                                         TESTCODE = row1["TESTCODE"],
                                         TESTNAME = row1["TESTNAME"],
                                         CHECKED = "Y",
                                         TRANYN = "Y"
                                     }).ToArray();
                Mdl.InvstData = Newtonsoft.Json.JsonConvert.SerializeObject(AdvTestArry);

                foreach (DataRow Dr in ADVTESTDT.Rows)
                {
                    string TestCode = ("" + Dr["TESTCODE"]).ToString().Trim();
                    string TestNM = ("" + Dr["TESTNAME"]).ToString().Trim();
                    string xmlData = LabServ.GetInvestigDataByTestCode(TestCode);
                    bool TestRowFlag = true;
                    if (!string.IsNullOrEmpty(xmlData))
                    {
                        DataSet ds = new DataSet();
                        ds.ReadXml(new XmlTextReader(new StringReader(xmlData)));
                        string UnitCode = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'").Count() > 0)
                        {
                            TestRowFlag = false;
                            foreach (DataRow DrTest in ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'"))
                            {
                                DataRow FRow = TableResult.NewRow();
                                string SInvstCode = ("" + DrTest["INVESTCODE"]).ToString();
                                string SInvstName = ("" + DrTest["INVESTDESC"]).ToString();
                                string SResultType = ("" + DrTest["RESULTYPE"]).ToString();
                                string SSeqNo = ("" + DrTest["SEQUENCE"]).ToString();
                                string InhouseResult = "";
                                string OutSideResult = "";
                                string TestInvstDate = "";
                                string TestInvstInDate = "";
                                if (Load.Tables.Count > 2 && Load.Tables[2].Rows.Count > 0)
                                {
                                    DataRow[] FilterOutside = Load.Tables[2].Select("TESTCODE = '" + TestCode + "' AND INVSETCODE='" + SInvstCode + "'");
                                    if (FilterOutside.Count() > 0)
                                    {
                                        OutSideResult = FilterOutside[0]["RESULTDT"].ToString().Trim();
                                        TestInvstDate = FilterOutside[0]["INVDATE"].ToString().Trim();
                                    }
                                }

                                if (Load.Tables.Count > 4 && Load.Tables[4].Rows.Count > 0)
                                {
                                    DataRow[] FilterInside = Load.Tables[4].Select("TESTCODE = '" + TestCode + "' AND INVESTCODE='" + SInvstCode + "'");
                                    if (FilterInside.Count() > 0)
                                    {
                                        InhouseResult = FilterInside[0]["RESULTDT"].ToString().Trim();
                                        TestInvstInDate = FilterInside[0]["RESULTDATE"].ToString().Trim();
                                    }
                                }
                                FRow["INVDATE"] = TestInvstDate;
                                FRow["INVINHOUSEDATE"] = TestInvstInDate;
                                FRow["TESTCODE"] = TestCode;
                                FRow["TESTNAME"] = TestNM;
                                FRow["INVESTCODE"] = SInvstCode;
                                FRow["INVESTDESC"] = SInvstName;
                                FRow["RESULTTYPE"] = SResultType;
                                FRow["SEQNO"] = SSeqNo;
                                FRow["RESULTDT"] = OutSideResult;
                                FRow["INRESULTDT"] = InhouseResult;
                                TableResult.Rows.Add(FRow);
                            }
                        }
                    }
                    if (TestRowFlag)
                    {
                        DataRow FRow = TableResult.NewRow();
                        string InhouseResult = "";
                        string OutSideResult = "";
                        string TestInvstDate = "";
                        string TestInvstInDate = "";
                        if (Load.Tables.Count > 2 && Load.Tables[2].Rows.Count > 0)
                        {
                            DataRow[] FilterOutside = Load.Tables[2].Select("TESTCODE = '" + TestCode + "'");
                            if (FilterOutside.Count() > 0)
                            {
                                OutSideResult = FilterOutside[0]["RESULTDT"].ToString().Trim();
                                TestInvstDate = FilterOutside[0]["INVDATE"].ToString().Trim();
                            }
                        }

                        if (Load.Tables.Count > 4 && Load.Tables[4].Rows.Count > 0)
                        {
                            DataRow[] FilterInside = Load.Tables[4].Select("TESTCODE = '" + TestCode + "'");
                            if (FilterInside.Count() > 0)
                            {
                                InhouseResult = FilterInside[0]["RESULTDT"].ToString().Trim();
                                TestInvstInDate = FilterInside[0]["RESULTDATE"].ToString().Trim();
                            }
                        }
                        FRow["INVDATE"] = TestInvstDate;
                        FRow["INVINHOUSEDATE"] = TestInvstInDate;
                        FRow["TESTCODE"] = TestCode;
                        FRow["TESTNAME"] = TestNM;
                        FRow["INVESTCODE"] = "";
                        FRow["INVESTDESC"] = ("" + Dr["TESTNAME"]).ToString().Trim();
                        FRow["RESULTTYPE"] = "V";
                        FRow["SEQNO"] = "";
                        FRow["RESULTDT"] = OutSideResult;
                        FRow["INRESULTDT"] = InhouseResult;
                        TableResult.Rows.Add(FRow);
                    }
                }
            }
        }

        public object GetInvstListData(string TestCode)
        {
            OncologyEMR.LabServRef.LaboratoryClient LabServ = new OncologyEMR.LabServRef.LaboratoryClient();
            List<object> allJsonData = new List<object>();
            if (!string.IsNullOrEmpty(TestCode))
            {
                DataTable DT = JsonConvert.DeserializeObject<DataTable>(TestCode);
                foreach (DataRow DR in DT.Rows)
                {
                    string STestCode = DR["TESTCODE"].ToString().Trim();
                    string xmlData = LabServ.GetInvestigDataByTestCode(STestCode);
                    if (!string.IsNullOrEmpty(xmlData))
                    {
                        DataSet ds = new DataSet();
                        ds.ReadXml(new XmlTextReader(new StringReader(xmlData)));
                        string UnitCode = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'").Count() > 0)
                        {

                            var jsonData = (from DataRow row in ds.Tables[0].Select("HOSPCODE = '" + UnitCode + "'")
                                            select new
                                            {
                                                INVDATE = "",
                                                TESTCODE = row["TESTCODE"].ToString().Trim(),
                                                INVSETCODE = row["INVESTCODE"].ToString().Trim(),
                                                INVSETDESC = row["INVESTDESC"].ToString().Trim(),
                                                RESULTTYPE = row["RESULTYPE"].ToString().Trim(),
                                                SEQNO = row["SEQUENCE"].ToString().Trim(),
                                                RESULTDT = "",
                                                INRESULTDT = ""
                                            }).ToList<object>();
                            allJsonData.AddRange(jsonData);
                        }
                    }
                }
            }

            return allJsonData;
        }

        public string SaveOutsideInvstg(OutsideInvstMdl Mdl)
        {
            OutsideInvstMdl BL = new OutsideInvstMdl();
            BL.TRANNO = string.Empty + Mdl.TRANNO;
            BL.MRNO = string.Empty + Mdl.MRNO;

            DataSet DS = new DataSet();
            DataTable OutSideResultDT = new DataTable();
            if (Mdl.ResultInvstData != null && Mdl.ResultInvstData != "")
            {
                OutSideResultDT = JsonConvert.DeserializeObject<DataTable>(Mdl.ResultInvstData);
                foreach (DataRow DR in OutSideResultDT.Rows)
                {
                    DR["INVDATE"] = GeneralFunction.GetDateInSpecifiedFormat(("" + DR["INVDATE"]).ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
            }

            OutSideResultDT.TableName = "TBLOUTINTRESULT";
            DS.DataSetName = "DS";
            DS.Tables.Add(OutSideResultDT);
            BL.strXMLString = DS.GetXml();
            if (Mdl.Gaction == "N")
                BL.TranMode = string.Empty + 1;
            else if (Mdl.Gaction == "E")
                BL.TranMode = string.Empty + 2;
            else if (Mdl.Gaction == "V")
                BL.TranMode = string.Empty + 5;
            BL.ModuleId = System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            BL.IPAddress = System.Web.HttpContext.Current.Session["MchIPAddress"].ToString();
            BL.strUserId = System.Web.HttpContext.Current.Session["gDoctCode"].ToString();
            string Result = oncoClient.SaveOutsideInvestigation(BL.TRANNO, BL.MRNO, BL.strUserId, BL.strXMLString);
            return Result;
        }
        public string GetDoctTypeList()
        {
            OncologyEMRClient oncoClient = new OncologyEMRClient();
            var DoctList = oncoClient.GetDoctLst("", "D");
            var sample = (from Lst in DoctList.AsEnumerable()
                          select new
                          {
                              CODE = Lst.Value,
                              NAME = Lst.Text
                          }).ToArray();
            return Newtonsoft.Json.JsonConvert.SerializeObject(sample);
        }

        public object GetOutsideInvestigationResult(string strTranNo)
        {
            try
            {
                OncologyEMRClient onco = new OncologyEMRClient();
                DataSet ds = new DataSet();
                ds.ReadXml(new StringReader(onco.GetOutsideInvestigationResult(strTranNo)));

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var load = ds.Tables[0];
                    var result = (from DataRow row in load.Rows
                                  select new
                                  {
                                      INVDATE = GeneralFunction.GetDate(row["INVDATE"].ToString().Trim()),
                                      TESTCODE = row["TESTCODE"].ToString().Trim(),
                                      INVSETCODE = row["INVSETCODE"].ToString().Trim(),
                                      INVSETDESC = row["INVSETDESC"].ToString().Trim(),
                                      RESULTTYPE = row["RESULTTYPE"].ToString().Trim(),
                                      SEQNO = row["SEQNO"].ToString().Trim(),
                                      RESULTDT = row["RESULTDT"].ToString().Trim(),
                                      TESTNAME = row["TESTNAME"].ToString().Trim(),
                                      INRESULTDT = "",
                                  }).ToList();
                    return JsonConvert.SerializeObject(result);
                }
                return JsonConvert.SerializeObject(new object[0]);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
    #endregion Outstanding Investigation

    #region Scheme Approval Status
    public class SchemeApprovalStatus
    {
        public string strFromDt { get; set; }
        public string strToDt { get; set; }
        public string MRNo { get; set; }
        public string PatName { get; set; }
        public List<SelectListItem> PreAuthAprovStatLst { get; set; }

        public object GetSchemeApprovalStatDetails(string FromDT, string ToDT, string strPreAuthStatus, string strDoctorCode)
        {
            OncologyEMRClient oncoemr = new OncologyEMRClient();
            DataSet dsSchemeApprStat = new DataSet();
            object jsonData = "";
            DataTable dt = new DataTable();
            FromDT = GeneralFunction.GetDateInSpecifiedFormat(FromDT, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            ToDT = GeneralFunction.GetDateInSpecifiedFormat(ToDT, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            dsSchemeApprStat.ReadXml(new XmlTextReader(new StringReader(oncoemr.GetSchemeStatusReport(FromDT, ToDT, strDoctorCode, strPreAuthStatus))));
            if (dsSchemeApprStat.Tables.Count > 0)
            {
                dt = dsSchemeApprStat.Tables[0].Copy();
                jsonData = (from DataRow row in dt.Rows
                            select new
                            {
                                TRANNO = row["TRANNO"].ToString(),
                                TRANDATETIME = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()) + " - " + DateTime.ParseExact(row["TRANTIME"].ToString().Trim(), "HH:mm:ss", null).ToString("hh:mm tt"),
                                MRNO = row["MRNO"].ToString().Trim().Trim(),
                                PATNAME = row["PATNAME"].ToString().Trim(),
                                COMPNAME = row["COMPNAME"].ToString().Trim(),
                                SCHEMECODES = row["SCHEMECODES"].ToString().Trim(),
                                SchemeNames = row["SchemeNames"].ToString().Trim(),
                                PreAuthStatus = row["PreAuthStatus"].ToString().Trim() == "P" ? "Pending" :
                                                row["PreAuthStatus"].ToString().Trim() == "W" ? "Waiting For Approval" :
                                                row["PreAuthStatus"].ToString().Trim() == "A" ? "Approved" :
                                                row["PreAuthStatus"].ToString().Trim() == "R" ? "Rejected" : "",
                                //PrescDtTime = string.IsNullOrWhiteSpace(row["TRANDATE"]?.ToString()) || string.IsNullOrWhiteSpace(row["TRANTIME"]?.ToString()) ? "" 
                                //: GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()) + " - " + DateTime.ParseExact(row["TRANTIME"].ToString().Trim(), "HH:mm:ss", null).ToString("hh:mm tt"),//priyanka 22/04/2026
                                ApprovalDtTime = string.IsNullOrWhiteSpace(row["APVDATE"]?.ToString()) || string.IsNullOrWhiteSpace(row["APVTIME"]?.ToString()) ? ""
                                                : (GeneralFunction.GetDate(row["APVDATE"].ToString().Trim()) + "  /  " + DateTime.ParseExact(row["APVTIME"].ToString().Trim(), "HH:mm:ss", null).ToString("hh:mm tt")) //priyanka 22/04/2026
                            }).ToArray();
            }
            return jsonData;
        }

        public string ExcelBindSchemeApprovalStatLst(string data, string frmDate, string toDate, string searchCriteria)
        {
            DataTable df = new DataTable();
            df = JsonConvert.DeserializeObject<DataTable>(data);
            if (df.Rows.Count > 0)
            {
                df.Columns.Remove("SCHEMECODES");
                df.Columns["TRANNO"].ColumnName = "Transaction No.";
                df.Columns["TRANDATETIME"].ColumnName = "Prescription Date / Time";
                df.Columns["MRNO"].ColumnName = "MR No.";
                df.Columns["PATNAME"].ColumnName = "Patient Name";
                df.Columns["COMPNAME"].ColumnName = "Company";
                df.Columns["SchemeNames"].ColumnName = "Schemes";
                df.Columns["PreAuthStatus"].ColumnName = "Pre Auth Approval Status";
                df.Columns["ApprovalDtTime"].ColumnName = "Approval Date / Time"; //priyanka 23/04/2026
                return GeneralFunction.getHeaderFooterExcelAppSetting("Schemes Approval Status List", frmDate, toDate, "", "", df, null);
            }
            else return "";

        }

    }
    #endregion

}
public class ImageInfo
{
    public string Id { get; set; }
    public string Src { get; set; }
}