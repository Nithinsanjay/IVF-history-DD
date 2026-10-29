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
//using OncologyEMR.CommonSerRef;
//using OncologyEMR.SecRefServ;
using System.Xml;
using System.Globalization;
using System.Collections.Concurrent;
using System.Threading.Tasks;

namespace OncologyEMR.Models
{
    public class Clinicalnotes
    {
        
        public object GetDoctors()
        {

            OncologyEMRClient clOnco = new OncologyEMRClient();
            //CommonServiceClient comserv = new CommonServiceClient();
            var doctList = clOnco.GetDoctLst("","D");
            if (doctList.Count() > 0)
            {
                var data = (from DoctorSelLstItem t in doctList
                            select new
                            {
                                DoctName = t.Text.ToString(),
                                DoctCode = t.Value.ToString()
                            }).ToArray(); ;
                return data;
            }
            return "";
        }
        public object GetRefDoctors()
        {

            //OncologyEMRClient clOnco = new OncologyEMRClient();
            OncologyEMR.CommonSerRef.CommonServiceClient clOnco = new OncologyEMR.CommonSerRef.CommonServiceClient();
            var doctList = clOnco.GetReferedDoctList();
            if (doctList.Count() > 0)
            {

                //var data = (from DoctorSelLstItem t in doctList
                var data = (from OncologyEMR.CommonSerRef.RefDoctListItem t in doctList
                            select new
                            {
                                DoctName = t.Text.ToString(),
                                DoctCode = t.Value.ToString()
                            }).ToArray(); ;
                return data;
            }
            return "";
        }
        public Dictionary<string, object> GetPatientList( string strDoctorCd)
        {
            try
            {
                Dictionary<string, object> dicResult = new Dictionary<string, object>();
                OncologyEMRClient clOnco = new OncologyEMRClient();
                DataSet ds = new DataSet();
                List<PatientSearch> listPatSearch = new List<PatientSearch>();
                //string strClinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
                string strDate = DateTime.Now.Year + "" + PreFixZero(DateTime.Now.Month.ToString()) + "" + PreFixZero(DateTime.Now.Day.ToString());

                ds.ReadXml(new StringReader(clOnco.GetPatientDetails("", "", "", strDoctorCd, strDate, strDate, "")));

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
                        clPat.Age = GeneralFunction.GetAge(clPat.DOB); // Convert.ToString(dr["PATAGE"]);
                        clPat.Gender = Convert.ToString(dr["PATSEX"]);
                        clPat.APPTTM = Convert.ToString(dr["APPTTIME"]);
                        clPat.DIFFTM = Convert.ToString(dr["DIF"]);
                        clPat.TRANNO = Convert.ToString(dr["TRANNO"]);
                        clPat.CompletedYN = Convert.ToString(dr["COMPLETEDYN"]);
                        clPat.OnlyPayStat = Convert.ToString(dr["ONLPAYSTAT"]);
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

        //#region Vitals
        //public string SaveVitalsTr(string strWeight, string strHeight, string strTemp, string strPulse, string strBlood, string strResp, string strOther, string strPrevWt, string strTranno, string strMrNo)
        //{
        //    BL_Oncology blOncology = new BL_Oncology();
        //    OncologyEMRClient Oncoser = new OncologyEMRClient();

        //    blOncology.TRANNO = strTranno;
        //    blOncology.MRNO = strMrNo;
        //    blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
        //    blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
        //    blOncology.TranMode = 1;
        //    blOncology.type = "V";
        //    blOncology.Weight = Convert.ToDecimal(strWeight);
        //    blOncology.Height = Convert.ToDecimal(strHeight);
        //    blOncology.Temp = Convert.ToDecimal(strTemp);
        //    blOncology.Pulse = strPulse;
        //    blOncology.Bp = strBlood;
        //    blOncology.Resp = strResp;
        //    blOncology.VOthers = strOther;
        //    //blOncology.pre = strPrevWt;
        //    //blOncology.Diagnosis = "";
        //    //blOncology.SurgHist = "";
        //    //blOncology.TOthers = "";
        //    //blOncology.ExamDet = "";
        //    //blOncology.PCOthers = "";
        //    //blOncology.PPOthers = "";
        //    //blOncology.PMOthers = "";

        //    return Oncoser.SaveDoctorDesk(blOncology);
        //}
        //public object SetDataForVitals(string strTranNo)
        //{
        //    OncologyEMRClient Oncoser = new OncologyEMRClient();
        //    string str = "";
        //    str = Oncoser.GetDoctDesk(strTranNo, "V");
        //    DataSet ds = new DataSet();
        //    ds.ReadXml(new StringReader(str));

        //    if (ds.Tables[0].Rows.Count > 0)
        //    {
        //        var data = new
        //        {
        //            Weight = ds.Tables[0].Rows[0]["WEIGHT"].ToString(),
        //            PrevWeight = (ds.Tables[0].Columns.Contains("PREVWEIGHT")) ? ds.Tables[0].Rows[0]["PREVWEIGHT"] : 0,
        //            HEIGHT = ds.Tables[0].Rows[0]["HEIGHT"].ToString(),
        //            TEMP = ds.Tables[0].Rows[0]["TEMP"].ToString(),
        //            PULSE = ds.Tables[0].Rows[0]["PULSE"].ToString(),
        //            RESP = ds.Tables[0].Rows[0]["RESP"].ToString(),
        //            BP = ds.Tables[0].Rows[0]["BP"].ToString(),
        //            VOTHERS = ds.Tables[0].Rows[0]["VOTHERS"].ToString(),
        //        };
        //        return data;
        //    }
        //    return "";
        //}
        //#endregion

        #region Personal History
        public string SaveAddictAddItemdt(string Desc, string GrpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();


                Result = Oncoser.SaveAddiction("", Desc, clinicCode, "A", User, 1);

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
        public string SaveAddiction(string strAddict, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strAddict);
            dt.TableName = "ADDICTION";
            ds.Tables.Add(dt);

            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "T";
            blOncology.xmlAddicts = ds.GetXml().Replace("&amp;", "");

            return client.SaveDoctorDesk(blOncology);
        }
        public object GetMainAddicListdt()
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst;

            servlst = comser.GetAddictionList();
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

            return rows;
        }

        public object SetDataForAddiction(string strTranNo, string strMrNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            object[] objToSend = new object[2];
            str = Oncoser.GetDoctDesk(strTranNo, "H", strMrNo);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.ReadXml(new StringReader(str));

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("Table1"))
                {
                    dt = ds.Tables["Table1"];
                    var data = (from DataRow row in dt.Rows
                                select new
                                {
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    ADDICTCD = row["ADDICTCD"].ToString().Trim(),
                                    STARTAGE = row["STARTAGE"].ToString().Trim(),
                                    STOPAGE = row["STOPAGE"].ToString().Trim(),
                                }
                       ).ToArray();
                    objToSend[0] = data;
                }
                if (ds.Tables.Contains("Table3"))
                {
                    dt = ds.Tables["Table3"];
                    var data = (from DataRow row in dt.Rows
                                select new
                                {
                                    PERSHIS = row["PERSHIST"].ToString().Trim()
                                }
                       ).ToArray();
                    objToSend[1] = data;
                }
            }
            return objToSend;
        }
     
        #endregion
        #region Medical history
        public string SaveMedicAddItemdt(string Desc, string GrpCode)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();


                Result = Oncoser.SaveDisease("", Desc, clinicCode, "A", User, 1);

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
        public object GetMainMedicListdt()
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst;

            servlst = comser.GetDiseaseList();
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
        public object SetDataForMedical(string strTranNo,string strMrNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            object[] objToSend = new object[2];
            str = Oncoser.GetDoctDesk(strTranNo, "H", strMrNo);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.ReadXml(new StringReader(str));

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("Table2"))
                {
                    dt = ds.Tables["Table2"];
                    var data = (from DataRow row in dt.Rows
                                select new
                                {
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    MEDCD = row["MEDCD"].ToString().Trim(),
                                    DURATION = row["DURATION"].ToString().Trim(),
                                    DURTYPE = row["DURTYPE"].ToString().Trim(),
                                    // ONREGTREATYN = row["ONREGTREATYN"].ToString().Trim()
                                }
                       ).ToArray();
                    objToSend[0] = data;
                }
                if (ds.Tables.Contains("Table3"))
                {
                    dt = ds.Tables["Table3"];
                    var data = (from DataRow row in dt.Rows
                                select new
                                {
                                    MEDHIST = row["MEDIHIST"].ToString().Trim(),
                                }
                       ).ToArray();
                    objToSend[1] = data;
                }
            }
            return objToSend;
        }
        public string SaveMedical(string strMedic, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strMedic);
            dt.TableName = "MEDICAL";
            ds.Tables.Add(dt);

            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "M";
            blOncology.xmlMedical = ds.GetXml().Replace("&amp;", "");

            return client.SaveDoctorDesk(blOncology);
        }
        #endregion
        #region Family History
        public object GetDiseaseListdt()
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<BL_GeneralFunctionsSelectLstThreeItem> servlst;

            servlst = comser.GetDiseaseList();
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
        public string SaveFamily(string strMedic, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strMedic);
            foreach (DataRow row in dt.Rows)
            {
                row["DIAGNOSEDDATE"] = GeneralFunction.GetDateInSpecifiedFormat(row["DIAGNOSEDDATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                row["DATEOFDEATH"] = GeneralFunction.GetDateInSpecifiedFormat(row["DATEOFDEATH"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            dt.TableName = "FAMILY";
            ds.Tables.Add(dt);
            ds.DataSetName = "DATA";
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "F";
            blOncology.xmlFamily = ds.GetXml().Replace("&amp;", "");

            return client.SaveDoctorDesk(blOncology);
        }
        public object SetDataForFamily(string strTranNo,string strMrNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            object[] objToSend = new object[2];
            str = Oncoser.GetDoctDesk(strTranNo, "H", strMrNo);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.ReadXml(new StringReader(str));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("Table"))
                {
                    dt = ds.Tables["Table"];
                    var data = (from DataRow row in dt.Rows
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
                                    DISEASESTATUS = row["DISEASESTATUS"].ToString().Trim(),
                                    ALIVEYN = row["ALIVEYN"].ToString().Trim(),
                                    DATEOFDEATH = GeneralFunction.GetDate(row["DATEOFDEATH"].ToString().Trim()),
                                    CAUSEOFDEATH = row["CAUSEOFDEATH"].ToString().Trim()
                                }
                       ).ToArray();
                    objToSend[0] = data;
                }
                if (ds.Tables.Contains("Table3"))
                {
                    dt = ds.Tables["Table3"];
                    var data = (from DataRow row in dt.Rows
                                select new
                                {
                                    FAMHIST = row["FAMHIST"].ToString().Trim(),

                                }
                       ).ToArray();

                    objToSend[1] = data;
                }
            }
            return objToSend;
        }
        #endregion
        #region Language Entry

        public object GetReportData(string strType)
        {
            Clinicalnotes cnotes = new Clinicalnotes();
            OncologyEMRClient client = new OncologyEMRClient();
            DataTable dt = new DataTable();
            DataTable dts = new DataTable();
            DataSet ds = new DataSet();

            //object[] obj = new object[4];
            //object jsonData = "";
            string userid  =   System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().Trim();// Meenakshi on 22/11/2019

            if (userid == "ADMIN" || strType == "H" || strType == "M" || strType == "D" || strType == "C" || strType == "A")
                userid = "";
            ds.ReadXml(new XmlTextReader(new StringReader(client.GetMasters(strType, "", userid))));
            dts = ds.Tables["Table"];
            string jsonData = JsonConvert.SerializeObject(dts, Newtonsoft.Json.Formatting.Indented);
            return jsonData;
        }

        public string SendData(string data, string strType)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(data);
            dt.TableName = "LANGUAGE";
            if (dt.Columns.Contains("TABCOUNT") && !dt.Columns.Contains("FIELD3COL"))
                dt.Columns["TABCOUNT"].ColumnName = "FIELD3COL";
            ds.Tables.Add(dt);
            return client.SaveMasters(ds.GetXml(), strType);
        }

        public string AddLanguageEntry(string NAME, string strType, string strHindi, string strMarathi, string strGujrati, string Field3)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            string USERID = HttpContext.Current.Session["gOncoUserId"].ToString();
            string CLINICCODE = HttpContext.Current.Session["ClinicCode"].ToString();
            return client.SaveMastersNew(NAME, CLINICCODE, USERID, strType, strHindi, strMarathi, strGujrati, Field3);
        }

        #endregion

        #region MasterSetup 
        public string AddMasterSetUpModel(string masterSetup, string Gender, string AgeF, string AgeT, string strComplaints, string strDiagnosis, string strRxdata, string strInvestigtn, string strPatadv)
        {
            string Result = "";
            try
            {
                //OncologyEMRClient Oncoser = new OncologyEMRClient();
                //BL_PersonalSetUp bl = new BL_PersonalSetUp();

                //bl.DoctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                //bl.SetUpName = masterSetup;
                //bl.SetUpType = "I";
                //bl.SetupCode = strSetUpCode;//added on 7/3/19
                //string[] codesArray = strInvestigationLst.Split(',');
                //string[] namesArray = strNameLst.Split(',');//added on 19th May 2018

                //DataTable dt = new DataTable();
                //DataSet ds = new DataSet();
                //dt.Columns.Add("TESTCODE");
                //dt.Columns.Add("TESTNAME");
                //dt.Columns.Add("SEQNO");
                //int count = 0;
                //foreach (string s in codesArray)
                //{
                //    DataRow row1 = dt.NewRow();

                //    row1["TESTCODE"] = s;
                //    row1["TESTNAME"] = namesArray[count];//added on 19th May 2018
                //    row1["SEQNO"] = count + 1;

                //    count++;
                //    dt.Rows.Add(row1);
                //}
                //ds.Tables.Add(dt);
                //dt.TableName = "LIST";
                //ds.DataSetName = "DETAIL";

                //bl.SetUpLstXml = ds.GetXml();

                //Result = Oncoser.SavePersonalisedSetUp(bl);
                return "";
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

        //added 15/6/19
        public object AddMasterSetUp(string masterSetup, string Gender, string AgeF, string AgeT, string strComplaints, string strDiagnosis, string strRxdata, string strInvestigtn, string strPatadv, string strInvestigtnTitle, string strPatadvTitle, string strDiagnosisTitle, string strComplaintsTitle, string setUpCode, string status)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            BL_PersonalSetUp bl = new BL_PersonalSetUp();
            bl.SetupCode = setUpCode;
            bl.SetUpName = masterSetup;
            bl.Gender = Gender;
            bl.FrmAge = AgeF;
            bl.ToAge = AgeT;
            bl.DoctCode = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]);
            bl.UserID = Convert.ToString(System.Web.HttpContext.Current.Session["gOncoUserId"]);
            bl.status = status;
            bl.CimsYN = System.Web.HttpContext.Current.Session["CIMYN"].ToString();//
            DataSet ds = new DataSet();
            ds.DataSetName = "DETAIL";

            //Medicine Table
            DataTable dtMedicineLst = new DataTable();

            if (strRxdata != "[]")
            {
                dtMedicineLst = JsonConvert.DeserializeObject<DataTable>(strRxdata);
                dtMedicineLst.Columns.Add("SEQNO");

                int count = 1;
                foreach (DataRow row in dtMedicineLst.Rows)
                {

                    row["SEQNO"] = count;
                    count++;
                }
            }

            ds.Tables.Add(dtMedicineLst);
            dtMedicineLst.TableName = "DRUGLST";
            //---------------------


            //investigation table
            string[] codesArray = strInvestigtn.Split(',');
            string[] namesArray = strInvestigtnTitle.Split(',');//added on 19th May 2018
            DataTable dtInvestigation = new DataTable();
            if (strInvestigtn != "")
            {
                dtInvestigation.Columns.Add("TESTCODE");
                dtInvestigation.Columns.Add("TESTNAME");
                dtInvestigation.Columns.Add("SEQNO");
                int countInvst = 0;
                foreach (string s in codesArray)
                {
                    DataRow row1 = dtInvestigation.NewRow();

                    row1["TESTCODE"] = s;
                    row1["TESTNAME"] = namesArray[countInvst];//added on 19th May 2018
                    row1["SEQNO"] = countInvst + 1;

                    countInvst++;
                    dtInvestigation.Rows.Add(row1);
                }
            }

            ds.Tables.Add(dtInvestigation);
            dtInvestigation.TableName = "INVSTLST";
            //--------------------

            //patient advice table
            string[] codesArray1 = strPatadv.Split(',');
            string[] namesArray1 = strPatadvTitle.Split(',');

            DataTable dtPatientAdvice = new DataTable();

            if (strPatadv != "")
            {
                dtPatientAdvice.Columns.Add("PATADVICECODE");
                dtPatientAdvice.Columns.Add("NAME");
                dtPatientAdvice.Columns.Add("SEQNO");
                int countPatAdv = 0;
                foreach (string s in codesArray1)
                {
                    DataRow row1 = dtPatientAdvice.NewRow();

                    row1["PATADVICECODE"] = s;
                    row1["NAME"] = namesArray1[countPatAdv];
                    row1["SEQNO"] = countPatAdv + 1;

                    countPatAdv++;
                    dtPatientAdvice.Rows.Add(row1);
                }
            }

            ds.Tables.Add(dtPatientAdvice);
            dtPatientAdvice.TableName = "ADVICELST";
            //---------------------

            //diagnosis
            string[] codesArray2 = strDiagnosis.Split(',');
            string[] namesArray2 = strDiagnosisTitle.Split(',');

            DataTable dtDiagnosis = new DataTable();
            if (strDiagnosis != "")
            {
                dtDiagnosis.Columns.Add("PATADVICECODE");
                dtDiagnosis.Columns.Add("NAME");
                dtDiagnosis.Columns.Add("SEQNO");
                int countDiagno = 0;
                foreach (string s in codesArray2)
                {
                    DataRow row1 = dtDiagnosis.NewRow();

                    row1["PATADVICECODE"] = s;
                    row1["NAME"] = namesArray2[countDiagno];
                    row1["SEQNO"] = countDiagno + 1;

                    countDiagno++;
                    dtDiagnosis.Rows.Add(row1);
                }
            }

            ds.Tables.Add(dtDiagnosis);
            dtDiagnosis.TableName = "DIAGNOSIS";
            //------------------------------

            //complaints
            string[] codesArray3 = strComplaints.Split(',');
            string[] namesArray3 = strComplaintsTitle.Split(',');

            DataTable dtComplaint = new DataTable();
            if (strComplaints != "")
            {
                dtComplaint.Columns.Add("CMPLNTCODE");
                dtComplaint.Columns.Add("NAME");
                dtComplaint.Columns.Add("SEQNO");
                int countCmplnt = 0;
                foreach (string s in codesArray3)
                {
                    DataRow row1 = dtComplaint.NewRow();

                    row1["CMPLNTCODE"] = s;
                    row1["NAME"] = namesArray3[countCmplnt];
                    row1["SEQNO"] = countCmplnt + 1;

                    countCmplnt++;
                    dtComplaint.Rows.Add(row1);
                }
            }

            ds.Tables.Add(dtComplaint);
            dtComplaint.TableName = "COMPLAINT";
            //------------------------------
            bl.SetUpLstXml = ds.GetXml();
            var result = client.WholeSetupTran(bl);
            return result;
        }

        public object GetMasterSetUpList(string strAge, string strCimsYN, string strGender)// - strCimsYN added
        {
            try
            {
                var DoctorCode = string.Empty;
                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                DataSet ds = new DataSet();
                DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
                if (strAge != "")
                {
                    string[] ar = null;
                    strGender = (strGender == "Male") ? "M" : (strGender == "Female") ? "F" : "B";//
                    if(strAge.Contains('.'))
                        ar= strAge.Split('.'); //split separator changed from : to . In local age is separated by :
                    else  if(strAge.Contains(':'))
                        ar = strAge.Split(':'); //split separator changed from : to . In local age is separated by :
                    ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetMasterSetUpLst(DoctorCode, ar[0], strCimsYN, strGender)));// - strCimsYN added

                }
                else
                {
                    ds.ReadXml(new StringReader(ObjOncologyEMRClient.GetMasterSetUpLst(DoctorCode, "", strCimsYN, "")));// - strCimsYN added
                }

                if (ds != null && ds.Tables.Count > 0)
                {
                    string jsonData = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
                    return jsonData;
                }
                else
                {
                    return "Unsuccessfull";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetMasterSetUpData(string strSetUpCode)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            var doctCode = Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"]);
            string data = client.GetMasterSetUpData(strSetUpCode, doctCode);
            DataSet ds = new DataSet();
            ds.ReadXml(new XmlTextReader(new StringReader((data))));
            object[] objectToSend = new object[6];
            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("SETUPDTL"))
                {
                    if (ds.Tables["SETUPDTL"].Rows.Count > 0)
                    {
                        var setUpData = (from DataRow row in ds.Tables["SETUPDTL"].Rows
                                         select new
                                         {
                                             NAME = row["NAME"].ToString().Trim(),
                                             Gender = row["Gender"].ToString().Trim(),
                                             FromAge = row["FromAge"].ToString().Trim(),
                                             ToAge = row["ToAge"].ToString().Trim(),
                                             STATUS = row["STATUS"].ToString().Trim(),
                                         }
                          ).ToArray();

                        objectToSend[0] = setUpData;
                    }
                }


                if (ds.Tables.Contains("RXDETAIL"))
                {
                    if (ds.Tables["RXDETAIL"].Rows.Count > 0)
                    {
                        var RxData = (from DataRow row in ds.Tables["RXDETAIL"].Rows
                                      select new
                                      {
                                          SETUPCODE = row["CODE"].ToString().Trim(),
                                          NAME = row["DRUGNM"].ToString().Trim(),
                                          DOSAGE = row["Dossage"].ToString().Trim(),
                                          REMARK = row["Remarks"].ToString().Trim(),
                                          DAYS = row["Days"].ToString().Trim(),
                                          DURATION = GetDaysString(row["DURATION"].ToString().Trim()),
                                          GENERICID = row["GENERICID"].ToString().Trim(),
                                          GENERICNAM = row["GENERICNAME"].ToString().Trim(),
                                          ROUTE = row["ROUTE"].ToString().Trim(),//
                                          CODE = row["DRUGCD"].ToString().Trim(),
                                          FOOD = (row["ABFOOD"].ToString().Trim()) == "A" ? "After" : (row["ABFOOD"].ToString().Trim() == "E" ? "Before" : ""),
                                          INTAKE = row["INTAKEDESC"].ToString().Trim(),
                                          DRUGFORM = row["DRUGFORM"].ToString().Trim()  //Meenakshi
                                      }
                        ).ToArray();

                        objectToSend[1] = RxData;
                    }
                }


                if (ds.Tables.Contains("INVSTDETAIL"))
                {
                    if (ds.Tables["INVSTDETAIL"].Rows.Count > 0)
                    {
                        var investData = (from DataRow row in ds.Tables["INVSTDETAIL"].Rows
                                          select new
                                          {
                                              SETUPCODE = row["CODE"].ToString().Trim(),
                                              TESTCODE = row["TESTCODE"].ToString().Trim(),
                                              TESTNAME = row["TESTNAME"].ToString().Trim(),
                                              DURATION = row["DURATION"].ToString().Trim(),
                                              DURTYPE = row["DURTYPE"].ToString().Trim(),
                                              SEQNO = row["SEQNO"].ToString().Trim(),

                                          }
                        ).ToArray();

                        objectToSend[2] = investData;
                    }
                }

                if (ds.Tables.Contains("PATADVCDETAIL"))
                {
                    if (ds.Tables["PATADVCDETAIL"].Rows.Count > 0)
                    {
                        var patAdvData = (from DataRow row in ds.Tables["PATADVCDETAIL"].Rows
                                          select new
                                          {
                                              SETUPCODE = row["CODE"].ToString().Trim(),
                                              SEQNO = row["SEQNO"].ToString().Trim(),
                                              NAME = row["NAME"].ToString().Trim(),
                                              PATADVICECODE = row["PATADVICECODE"].ToString().Trim(),
                                          }
                        ).ToArray();

                        objectToSend[3] = patAdvData;
                    }
                }


                if (ds.Tables.Contains("DIAGNODETAIL"))
                {
                    if (ds.Tables["DIAGNODETAIL"].Rows.Count > 0)
                    {
                        var diagnoData = (from DataRow row in ds.Tables["DIAGNODETAIL"].Rows
                                          select new
                                          {
                                              SETUPCODE = row["CODE"].ToString().Trim(),
                                              SEQNO = row["SEQNO"].ToString().Trim(),
                                              NAME = row["NAME"].ToString().Trim(),
                                              DIAGNCD = row["DIAGNCD"].ToString().Trim(),
                                          }
                        ).ToArray();

                        objectToSend[4] = diagnoData;
                    }
                }

                if (ds.Tables.Contains("CMPLNTDETAIL"))
                {
                    if (ds.Tables["CMPLNTDETAIL"].Rows.Count > 0)
                    {
                        var cmplntData = (from DataRow row in ds.Tables["CMPLNTDETAIL"].Rows
                                          select new
                                          {
                                              SETUPCODE = row["CODE"].ToString().Trim(),
                                              SEQNO = row["SEQNO"].ToString().Trim(),
                                              NAME = row["NAME"].ToString().Trim(),
                                              CMPLNTCODE = row["CMPLNTCODE"].ToString().Trim(),
                                          }
                        ).ToArray();

                        objectToSend[5] = cmplntData;
                    }
                }

            }
            return objectToSend;
        }
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

        //---------------------

        #endregion

        #region Vaccination
        public object GetVaccinationLst(string AgeGrpCode)
        {
            try
            {
                Clinicalnotes cnotes = new Clinicalnotes();
                OncologyEMRClient client = new OncologyEMRClient();
                DataTable dtEmpty = new DataTable();
                DataTable dts = new DataTable();
                DataSet load = new DataSet();
                DataSet ds = new DataSet();

                //object obj=client.GetVaccinationLst(AgeGrpCode);

                //if(obj.GetType()==typeof(string))
                //  {
                //      return obj;
                //}
                //else{

                //string[] strArray=(string[])obj;
                object[] objToSend = new object[2];

                load.ReadXml(new XmlTextReader(new StringReader(client.GetVaccinationLst(AgeGrpCode))));

                if (load.Tables.Count > 0)
                {
                    if (load.Tables.Contains("Table"))// -table name chngd 
                    {
                        dtEmpty = BindEmptyDatatable(20 - load.Tables["Table"].Rows.Count, load.Tables["Table"].Rows.Count);// - table name chngd
                        load.Tables[0].Merge(dtEmpty);
                        load.Tables[0].TableName = "Vaccination";
                    }
                    else
                    {
                        dtEmpty = BindEmptyDatatable(20, 0);
                        dtEmpty.TableName = "Vaccination";
                        load.Tables.Add(dtEmpty);
                    }

                }
                else
                {
                    dtEmpty = BindEmptyDatatable(20, 0);
                    dtEmpty.TableName = "Vaccination";
                    load.Tables.Add(dtEmpty);
                }

                var jsonVaccines = (from DataRow row in load.Tables["Vaccination"].Rows
                                    select new
                                    {
                                        CODE = row["CODE"].ToString().Trim(),
                                        NAME = row["NAME"].ToString().Trim(),
                                        //SEQ = row["SEQ"].ToString().Trim(),
                                        STATUS = row["STATUS"].ToString().Trim(),
                                        AGEGRPCD = row["AGEGRPCD"].ToString().Trim(),

                                    }).ToArray();

                objToSend[0] = jsonVaccines;

                if (load.Tables.Contains("Table1"))// -table name chngd
                {
                    if (load.Tables["Table1"].Rows.Count > 0)
                        objToSend[1] = load.Tables["Table1"].Rows[0]["MAXCODE"];
                }


                return objToSend;


            }

            catch (Exception e)
            {
                throw e;
            }

        }
        private DataTable BindEmptyDatatable(int ROWCOUNT, int start)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CODE");
            dt.Columns.Add("NAME");
            dt.Columns.Add("AGEGRPCD");
            //dt.Columns.Add("SEQ");
            dt.Columns.Add("STATUS");

            //int seqCnt = start;
            for (int i = 0; i <= ROWCOUNT; i++)
            {
                DataRow dr = dt.NewRow();
                // seqCnt++;
                //dr["SEQ"] = seqCnt;

                dt.Rows.Add(dr);
            }
            return dt;

        }
        public object GetAgeGroupLst(string ageGrpId)
        {
            try
            {
                Clinicalnotes cnotes = new Clinicalnotes();
                OncologyEMRClient client = new OncologyEMRClient();
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();


                ds.ReadXml(new XmlTextReader(new StringReader(client.GetAgeGroupLst(ageGrpId))));

                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        dt = ds.Tables[0];

                        var data = (from DataRow row in dt.Rows
                                    select new
                                    {
                                        CODE = row["CODE"].ToString().Trim(),
                                        FRMAGE = row["FRMAGE"].ToString().Trim(),
                                        TOAGE = row["TOAGE"].ToString().Trim(),
                                        REMARK = row["REMARK"].ToString().Trim(),
                                        AGEGRP = row["AGEGROUP"].ToString().Trim(),
                                        STATUS = row["STATUS"].ToString().Trim(),
                                        CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                        SEQ = row["SEQ"].ToString().Trim(),
                                    }).ToArray();
                        return data;
                    }
                }
                else
                    return "";

                return "";
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public object SaveAgeGrouop(string ageGrp, string frmAge, string toAge, string remark, string status, int seq, string AgeGroupCode)
        {
            try
            {
                OncologyEMRClient client = new OncologyEMRClient();
                string userId = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
                string str = client.SaveAgeGrouop(ageGrp, frmAge, toAge, remark, status, userId, seq, AgeGroupCode);
                return str;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public object SaveVaccines(string ageGrpCode, string xmlString)
        {
            try
            {
                OncologyEMRClient client = new OncologyEMRClient();
                DataTable dt = JsonConvert.DeserializeObject<DataTable>(xmlString);
                dt.TableName = "VACCINE";
                dt.Columns.Add("SEQ");
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    dt.Rows[i]["SEQ"] = i + 1;

                }
                DataSet ds = new DataSet("DATA");
                if (dt != null && dt.Rows.Count > 0)
                {
                    ds.Tables.Add(dt);
                }

                string xmlVaccines = ds.GetXml();

                var str = client.SaveVaccines(ageGrpCode, xmlVaccines);

                return str;
            }
            catch (Exception e)
            {
                throw e;
            }

        }
        #endregion

        public object AddFreeHistory(string strText, string strTran, string strMrNo, string strType)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            var strUser = HttpContext.Current.Session["gOncoUserId"].ToString();
            if (strType == "P") //personal history
            {
                str = Oncoser.SaveFreeHistory(strTran, strMrNo, strText, null, null, strUser);
            }
            else if (strType == "F") //family history
            {
                str = Oncoser.SaveFreeHistory(strTran, strMrNo, null, null, strText, strUser);
            }
            else if (strType == "M") //Medical history
            {
                str = Oncoser.SaveFreeHistory(strTran, strMrNo, null, strText, null, strUser);
            }

            return str;
        }

        //kavita 20-sep-2019
        #region AllergyHist
        public object GetMainAllergyListdt()
        {
            OncologyEMRClient comser = new OncologyEMRClient();
            IEnumerable<AllergySelectLst> servlst;
            servlst = comser.GetAllergyMstList().Where(x => x.Status == "A");
            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            foreach (PropertyInfo info in typeof(AllergySelectLst).GetProperties())
            {
                dt.Columns.Add(new DataColumn(info.Name, info.PropertyType));
            }
            foreach (AllergySelectLst t in servlst)
            {
                DataRow row = dt.NewRow();
                foreach (PropertyInfo info in typeof(AllergySelectLst).GetProperties())
                {
                    row[info.Name] = info.GetValue(t, null);
                }
                dt.Rows.Add(row);
            }
            var rows = (from DataRow row in dt.AsEnumerable()
                        select new
                        {
                            CODE = ("" + row["Code"]).Trim(),
                            TEXT = ("" + row["Name"]).Trim(),
                            TYPE = ("" + row["AllergyType"]).Trim(),
                            STATUS = ("" + row["Status"]).Trim(),
                        }).ToList();
            return rows;
        }
        public object SetDataForAllergy(string strTranNo, string strMrNo)
        {
            OncologyEMRClient Oncoser = new OncologyEMRClient();
            string str = "";
            object[] objToSend = new object[2];
            str = Oncoser.GetDoctDesk(strTranNo, "H", strMrNo);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.ReadXml(new StringReader(str));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables.Contains("Table4"))
                {
                    dt = ds.Tables["Table4"];
                    var data = (from DataRow row in dt.Rows
                                select new
                                {
                                    MRNO = row["MRNO"].ToString().Trim(),
                                    ALLERGYCD = row["ALLERGYCD"].ToString().Trim(),
                                    DURATION = row["DURATION"].ToString().Trim(),
                                    DURTYPE = row["DURTYPE"].ToString().Trim(),
                                    REMARK = row["REMARKS"].ToString().Trim(),
                                    ALLERGYTYPE = row["ALLERGYTYPE"].ToString().Trim(),
                                    ALLERGYNM = row["NAME"].ToString().Trim()
                                    // ONREGTREATYN = row["ONREGTREATYN"].ToString().Trim()
                                }
                       ).ToArray();
                    objToSend[0] = data;
                }
                //if (ds.Tables.Contains("Table3"))
                //{
                //    dt = ds.Tables["Table3"];
                //    var data = (from DataRow row in dt.Rows
                //                select new
                //                {
                //                    MEDHIST = row["MEDIHIST"].ToString().Trim(),
                //                }
                //       ).ToArray();
                //    objToSend[1] = data;
                //}
            }
            return objToSend;
        }
        public string SaveAllergyItemdt(string Desc, string GrpCode, string Type)
        {
            string Result = "";
            try
            {
                OncologyEMRClient Oncoser = new OncologyEMRClient();
                string User = HttpContext.Current.Session["gOncoUserId"].ToString();
                string clinicCode = HttpContext.Current.Session["ClinicCode"].ToString();
                Result = Oncoser.SaveAllergyMst("", Desc, clinicCode, "A", User, 1, Type);
                return Result;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Violation of UNIQUE KEY constraint 'UQ__DDALLERG__D9C1FA001003378B'")) //18/12/2019
                {
                    Result = "This allergy is already Present.";
                    return Result;
                }
                else
                    return ex.Message;
            }
        }
        public string SaveAllergy(string strMedic, string strMRNO, string strTranNo)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(strMedic);
            dt.TableName = "ALLERGY";
            ds.Tables.Add(dt);
            blOncology.TRANNO = strTranNo;
            blOncology.MRNO = strMRNO;
            blOncology.DoctorCode = (System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            blOncology.TranMode = 1;
            blOncology.type = "K";
            blOncology.xmlMedical = ds.GetXml().Replace("&amp;", "");
            return client.SaveDoctorDesk(blOncology);
        }
        #endregion

    }

    //kavita 27-Aug-2019
    #region Vaccination
    public class VaccinationModel
    {
        public string BirthHistory { get; set; }
        public List<SelectListItem> BirthHistoryList { get; set; }
        public object GetVaccinationDataList(string strMrNo, string strDOB)
        {
            try
            {
                object[] res = new object[2];
                Clinicalnotes cnotes = new Clinicalnotes();
                OncologyEMRClient client = new OncologyEMRClient();

                DataTable dts = new DataTable();
                DataSet load = new DataSet();
                DataSet load2 = new DataSet();
                DataTable dt = new DataTable();
                DataTable dt2 = new DataTable();

                // string dob = (System.Web.HttpContext.Current.Session["PATDOB"]).ToString();

                load2.ReadXml(new XmlTextReader(new StringReader(client.GetVaccineDetails(strMrNo))));
                load.ReadXml(new XmlTextReader(new StringReader(client.GetAgeGrpVaccineLnk())));
                if (load2.Tables.Count > 1)
                {
                    dt2 = load2.Tables[1];
                    dt2.Columns["GRPCD"].ColumnName = "AGEGRPCD";
                    dt2.Columns["DUEDT"].ColumnName = "DUEDATE";
                    dt2.Columns["GIVENDT"].ColumnName = "GIVDATE";
                    dt2.Columns["VACINECD"].ColumnName = "VACCINECD";
                }

                if (load.Tables.Count > 0)
                {

                    dt = load.Tables[0];
                    dt.Columns.Add("DUEDATE");
                    dt.Columns.Add("GIVDATE");
                    dt.Columns.Add("REMARKS");
                    dt.Columns.Add("USERID");
                    dt.Columns.Add("CREATEDON");
                    dt.Columns.Add("CREATEDAT");

                    for (int row = 0; row < dt2.Rows.Count; row++)
                    {
                        for (int r = 0; r < dt.Rows.Count; r++)
                        {
                            if ((dt2.Rows[row]["VACCINECD"].ToString().Trim() == dt.Rows[r]["VACCINECD"].ToString().Trim()) && (dt2.Rows[row]["AGEGRPCD"].ToString().Trim() == dt.Rows[r]["AGEGRPCD"].ToString().Trim()))
                            {

                                dt.Rows[r]["AGEGROUP"] = dt2.Rows[row]["AGEGROUP"].ToString().Trim();
                                dt.Rows[r]["VACCINECD"] = dt2.Rows[row]["VACCINECD"].ToString().Trim();
                                dt.Rows[r]["DUEDATE"] = GeneralFunction.GetDate(dt2.Rows[row]["DUEDATE"].ToString().Trim());//dt2.Rows[row]["GIVDATE"].ToString().Substring(6) + "/" + dt2.Rows[row]["GIVDATE"].ToString().Substring(4,2) + "/" + dt2.Rows[row]["GIVDATE"].ToString().Substring(0,4);
                                dt.Rows[r]["GIVDATE"] = GeneralFunction.GetDate(dt2.Rows[row]["GIVDATE"].ToString().Trim());//GeneralFunction.GetDateInSpecifiedFormat(dt2.Rows[row]["GIVDATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);                           
                                dt.Rows[r]["USERID"] = dt2.Rows[row]["CREATEDBY"].ToString().Trim();
                                dt.Rows[r]["CREATEDON"] = GeneralFunction.GetDate(dt2.Rows[row]["CREATEDON"].ToString().Trim());
                                dt.Rows[r]["CREATEDAT"] = dt2.Rows[row]["CREATEDAT"].ToString().Trim();

                                dt.Rows[r]["REMARKS"] = dt2.Rows[row]["REMARKS"].ToString().Trim();

                                dt.Rows[r]["VACSTATUS"] = "A";
                                dt.Rows[r]["GRPSTATUS"] = "A";
                            }

                            //else if ((dt.Rows[r]["GRPSTATUS"].ToString().Trim() == "I" || dt.Rows[r]["VACSTATUS"].ToString().Trim() == "I") && (dt.Rows[r]["GIVDATE"].ToString().Trim() == "" || dt.Rows[r]["GIVDATE"].ToString().Trim() == null))
                            //{
                            //    dt.Rows[r].Delete();
                            //}


                            //if (dt.Rows[r]["DUEDATE"].ToString().Trim() == "") //duedate if not exist
                            //{
                            //    DateTime dob = DateTime.ParseExact(strDOB, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                            //    string[] toage = dt.Rows[r]["TOAGE"].ToString().Split(':');
                            //    int y = Convert.ToInt16(toage[0].Replace('_', '0'));
                            //    int m = Convert.ToInt16(toage[1].Replace('_', '0'));
                            //    double d = Convert.ToDouble(toage[2].Replace('_', '0'));
                            //    DateTime day = dob.AddDays(d);
                            //    DateTime mon = day.AddMonths(m);
                            //    DateTime years = mon.AddYears(y);
                            //    string DueDate = years.Day.ToString().PadLeft(2, '0') + "/" + years.Month.ToString().PadLeft(2, '0') + "/" + years.Year;
                            //    dt.Rows[r]["DUEDATE"] = DueDate;
                            //}

                        }
                    }
                    string DueDate = "";
                    for (int r = 0; r < dt.Rows.Count; r++)// 18-12-19
                    {
                        if (dt.Rows[r]["DUEDATE"].ToString().Trim() == "") //duedate if not exist
                        {
                            DateTime dob = DateTime.ParseExact(strDOB, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                            string[] toage = dt.Rows[r]["TOAGE"].ToString().Split(':');
                            int y = Convert.ToInt16(toage[0].Replace('_', '0'));
                            int m = Convert.ToInt16(toage[1].Replace('_', '0'));
                            double d = Convert.ToDouble(toage[2].Replace('_', '0'));
                            DateTime day = dob.AddDays(d);
                            DateTime mon = day.AddMonths(m);
                            DateTime years = mon.AddYears(y);
                            DueDate = years.Day.ToString().PadLeft(2, '0') + "/" + years.Month.ToString().PadLeft(2, '0') + "/" + years.Year;
                            dt.Rows[r]["DUEDATE"] = DueDate;
                        }

                    }
                    //Commented below code by Murali on 30/07/2024
                    // dt.AsEnumerable().Where(r => (r.Field<string>("GRPSTATUS") != "I" && r.Field<string>("VACSTATUS") != "I")).CopyToDataTable(); 
                    //Added below code by Murali on 30/07/2024
                    //*****************************************************************************
                    DataTable FilterTable = new DataTable(); 
                    FilterTable = dt.Clone();
                    DataRow[] rowsToCopy;
                    rowsToCopy = dt.Select("GRPSTATUS<>'I' AND VACSTATUS <> 'I'");
                    if (rowsToCopy.Length > 0)
                    {
                        foreach (DataRow temp in rowsToCopy)
                        {
                            FilterTable.ImportRow(temp);
                        }
                    }
                    //*****************************************************************************
                    if (FilterTable.Rows.Count > 0)  //Added Condition by Murali on 30/07/2024
                    {
                        var jsonVaccines = (from DataRow row in FilterTable.Rows
                                            select new
                                            {
                                                AGEGROUP = row["AGEGROUP"].ToString().Trim(),
                                                AGEGRPCD = row["AGEGRPCD"].ToString().Trim(),
                                                DUEDATE = row["DUEDATE"].ToString().Trim(),
                                                GIVDATE = row["GIVDATE"].ToString().Trim(),
                                                VACCINECD = row["VACCINECD"].ToString().Trim(),
                                                VACCINENM = row["VACCINENM"].ToString().Trim(),
                                                REMARK = row["REMARKS"].ToString().Trim(),
                                                USERID = row["USERID"].ToString().Trim(),
                                                CREATEDON = row["CREATEDON"].ToString().Trim(),
                                                CREATEDAT = row["CREATEDAT"].ToString().Trim(),
                                                HDUEDATE = row["DUEDATE"].ToString().Trim(), // Added by Murali on 31/07/2024
                                            }).ToArray();
                        if (load2.Tables.Count > 0)
                            res[0] = Newtonsoft.Json.JsonConvert.SerializeObject(load2.Tables[0]);
                        else
                            res[0] = "";
                        res[1] = jsonVaccines;
                    }
                    return res;

                }
                else
                {
                    return "";
                }

            }

            catch (Exception e)
            {
                throw e;
            }

        }

        public object SaveVaccination(string strMRNO, string strTime, string strWeight, string strHis, string strBloodGrp, string strMotBldGrp, string strApOne, string strApFiv, string strVitk, string strEDD, string strData)
        {
            try
            {
                OncologyEMRClient cl = new OncologyEMRClient();
                DataTable dt = JsonConvert.DeserializeObject<DataTable>(strData);
                dt.TableName = "VACCINE";
                DataSet ds = new DataSet("DATA");
                if (dt != null && dt.Rows.Count > 0)
                {
                    for (int row = 0; row < dt.Rows.Count; row++)
                    {
                        dt.Rows[row]["DUEDATE"] = GeneralFunction.GetDateInSpecifiedFormat(dt.Rows[row]["DUEDATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        dt.Rows[row]["GIVDATE"] = GeneralFunction.GetDateInSpecifiedFormat(dt.Rows[row]["GIVDATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        dt.Rows[row]["CREATEDON"] = GeneralFunction.GetDateInSpecifiedFormat(dt.Rows[row]["CREATEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);//
                    }
                    ds.Tables.Add(dt);
                }
                string xmlVaccines = ds.GetXml();
                var str = cl.SaveVaccinTran(strMRNO, xmlVaccines, strWeight, strBloodGrp, strMotBldGrp, strVitk, strHis, strApOne, strEDD, strTime, Convert.ToString(System.Web.HttpContext.Current.Session["gOncoUserId"]), strApFiv);
                return str;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
    #endregion




    #region InvestigationVerify
    public class InvestigationVerify
    {
        //public string BirthHistory { get; set; }
        //public List<SelectListItem> BirthHistoryList { get; set; }
        public object GetLabDepartments()
        {
            OncologyEMR.CommonSerRef.CommonServiceClient ComClient = new OncologyEMR.CommonSerRef.CommonServiceClient();

            OncologyEMR.OPServRef.OutpatientClient pissClient = new OncologyEMR.OPServRef.OutpatientClient();
            List<OncologyEMR.CommonSerRef.LabDeptLstItem> LabDeptLst = new List<OncologyEMR.CommonSerRef.LabDeptLstItem>();
            //StringWriter sw = new StringWriter();
            LabDeptLst = ComClient.GetLabDeptLst().Where(x => x.Status == "A" && x.LabType == "L").ToList();

            string json = Newtonsoft.Json.JsonConvert.SerializeObject(LabDeptLst);
            System.Data.DataTable dt = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(json);



            //var str1 = string.Join(",", ComClient.GetLabDeptLst().Where(x => x.Status == "A" && x.LabType == "L").ToList());

            if (dt.Rows.Count > 0)
            {
                var data = (from DataRow row in dt.Rows
                            select new
                            {
                                DEPTCODE = row["Value"].ToString().Trim(),
                                DEPTDESC = row["Text"].ToString().Trim(),
                            }).ToArray();
                return data;
            }
            else
            {
                return "";
            }


        }

        public object GetLabDeptTests(string strLabDept)
        {
            //OncologyEMR.CommonSerRef.CommonServiceClient ComClient = new OncologyEMR.CommonSerRef.CommonServiceClient();
            OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
            DataSet dsLabDepTst = new DataSet();
            string strUnit = "01";

            //OncologyEMR.OPServRef.OutpatientClient pissClient = new OncologyEMR.OPServRef.OutpatientClient();
            //List<OncologyEMR.CommonSerRef.LabDeptLstItem> LabDepTsttLst = new List<OncologyEMR.CommonSerRef.LabDeptLstItem>();
            ////StringWriter sw = new StringWriter();
            dsLabDepTst.ReadXml(new StringReader(ObjOncologyEMRClient.GetTestMstList(strLabDept, strUnit)));

            //string json = Newtonsoft.Json.JsonConvert.SerializeObject(LabDepTsttLst);
            //System.Data.DataTable dt = Newtonsoft.Json.JsonConvert.DeserializeObject<System.Data.DataTable>(json);



            //var str1 = string.Join(",", ComClient.GetLabDeptLst().Where(x => x.Status == "A" && x.LabType == "L").ToList());
            if (dsLabDepTst.Tables.Count > 0)
            {

                if (dsLabDepTst.Tables[0].Rows.Count > 0)
                {
                    var data = (from DataRow row in dsLabDepTst.Tables[0].Rows
                                select new
                                {
                                    TESTCODE = row["TESTCODE"].ToString().Trim(),
                                    TESTNAME = row["TESTNAME"].ToString().Trim(),
                                }).ToArray();
                    return data;
                }
                else
                {
                    return "";
                }
            }
            else
            {
                return "";
            }


        }

        public object GetTechVerifiedData(string FromDt, string ToDt, string LabDept, string TechVerify, string strMRNO, string strPatName, string strContact, string strTest, string strSample, string strDoctor)
        {
            try
            {

                DataSet load = new DataSet();
                DataTable dt = new DataTable();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();
                //string data = ObjOncologyEMRClient.GetInvestResult(MrnNo);
                var sDate = GeneralFunction.GetDateInSpecifiedFormat(FromDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(ToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetTechVerifiedData(sDate, tDate, LabDept, TechVerify, strMRNO, strPatName, strContact, strTest, strSample, strDoctor)));

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
                        load.Tables[0].Rows[i]["RESULTNO"] = load.Tables[0].Rows[i]["RESULTNO"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["DATETIME"] = dtdatev;
                        load.Tables[0].Rows[i]["MRNO"] = load.Tables[0].Rows[i]["MRNO"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["IPNO"] = load.Tables[0].Rows[i]["IPNO"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["PATNAME"] = load.Tables[0].Rows[i]["PATNAME"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["ORDERNO"] = load.Tables[0].Rows[i]["ORDERNO"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["ORDERDATE"] = load.Tables[0].Rows[i]["ORDERDATE"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["TESTNAME"] = load.Tables[0].Rows[i]["TESTNAME"].ToString().Replace("'", "");

                        load.Tables[0].Rows[i]["SEQUENCENo"] = load.Tables[0].Rows[i]["SEQNO"].ToString() != "" ? Int16.Parse(load.Tables[0].Rows[i]["SEQNO"].ToString()) : 0; // changed by vijeta on 23rd july 2018

                        load.Tables[0].Rows[i]["DateTimeString"] = string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim().Substring(0, 5));
                    }

                    DataView viewDate = new DataView(load.Tables[0]);
                    viewDate.Sort = "DATETIME desc";

                    DataTable distinctValues = viewDate.ToTable(true, "DateTimeString");
                    //DataTable ViewDistInvestValues = viewDate.ToTable(true, "TESTNAME", "INVESTDESC");

                    //		load.Tables[1].Columns.Add("NORMRANGE");
                    //		load.Tables[1].Columns.Add("SEQUENCENo", typeof(Int32));

                    //		for (int i = 0; i < distinctValues.Rows.Count; i++)
                    //		{
                    //			load.Tables[1].Columns.Add(distinctValues.Rows[i]["DateTimeString"].ToString());
                    //		}


                    //		for (int n = 0; n < load.Tables[1].Rows.Count; n++)
                    //		{
                    //			DataRow[] dmrow = load.Tables[0].Select("INVESTDESC='" + load.Tables[1].Rows[n]["INVESTDESC"].ToString().Trim().Replace("'", "") + "'AND TESTNAME='" + load.Tables[1].Rows[n]["TESTNAME"].ToString().Trim().Replace("'", "") + "'");
                    //			for (int p = 0; p < dmrow.Length; p++)
                    //			{
                    //				load.Tables[1].Rows[n][dmrow[p][13].ToString()] = GetResultWithAbNorm(dmrow[p][5].ToString(), dmrow[p][8].ToString(), dmrow[p][9].ToString(), dmrow[p][7].ToString(), dmrow[p][10].ToString());
                    //			}
                    //			load.Tables[1].Rows[n]["NORMRANGE"] = dmrow[0][6].ToString();
                    //			load.Tables[1].Rows[n]["TESTNAME"] = dmrow[0][1].ToString().ToString();
                    //			load.Tables[1].Rows[n]["INVESTDESC"] = dmrow[0][2].ToString().ToString();
                    //			load.Tables[1].Rows[n]["SEQUENCENo"] = dmrow[0][14];
                    //		}

                    //		var dtInvestigatetbl = load.Tables[1].AsEnumerable()
                    // .OrderBy(r => r.Field<Int32>("SEQUENCENo"))
                    // .CopyToDataTable();


                    //		var dtInvestigatetbl1 = dtInvestigatetbl.AsEnumerable()
                    //.OrderBy(r => r.Field<string>("TESTNAME"))
                    //.CopyToDataTable();

                    distinctValues.Columns["DateTimeString"].ColumnName = "DATETIME";
                    //		dtInvestigatetbl1.TableName = "Investigate";

                    distinctValues.TableName = "TblDate";
                    load.Tables[0].TableName = "TblResult";
                    //load.Tables.Remove("Table1");
                    //load.Tables.Remove("Table2");
                    load.Tables.Add(distinctValues);
                    //load.Tables.Add(dtInvestigatetbl1);
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

        public object GetTemplateResultToVerify(string MrnNo, string strFrmDate, string strTodate, string resultNo, string Type)
        {
            try
            {
                DataSet load = new DataSet();

                OncologyEMRClient ObjOncologyEMRClient = new OncologyEMRClient();

                var sDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                load.ReadXml(new StringReader(ObjOncologyEMRClient.GetTemplateResultToVerify(MrnNo, sDate, tDate, resultNo, Type)));

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

        public string SaveTmplRptVerify(string ResultNo, string RptType, string UserID, string MchIPAddress, string ModuleIDGlobal)
        {
            OncologyEMRClient onc = new OncologyEMRClient();
            //DataSet dsTestData = new DataSet();
            //DataTable dtTestData = new DataTable();
            //DataTable dtMicrobio = new DataTable();

            //onc.TRANNO = ResultNo;
            //onc.CREATEDBY = (string)HttpContext.Current.Session["UserID"];
            //onc.TranMode = 6;
            OncologyEMR.CommonSerRef.CommonServiceClient com = new OncologyEMR.CommonSerRef.CommonServiceClient();
            string strDate = com.GetServerDate();
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            return onc.VerifyTemplateRpt(ResultNo, RptType, "L", UserID, MchIPAddress, ModuleIDGlobal);

        }

        public string SaveTmplRptReject(string ResultNo, string RejRemarks)
        {
            OncologyEMRClient onc = new OncologyEMRClient();
            return onc.SaveTmplRptReject(ResultNo, RejRemarks);

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
            return amendData;
        }

        //public string PreparePDFDocumentForPassedResultNo(string strResultNo)
        //{
        //	try
        //	{
        //		DataSet load = new DataSet();
        //		OncologyEMRClient labClient = new OncologyEMRClient();
        //		load.ReadXml(new XmlTextReader(new StringReader(labClient.GetMultiResultData("L", strResultNo))));

        //		foreach (DataRow row in load.Tables["Table"].Rows)
        //		{
        //			byte[] PrintByte = null;
        //			string strLetterHeadYN = "Y";
        //			var strShowSpecimen = GeneralFunction.GetAppsettingUnitWiseValue("ShowSpecimenInPrint");
        //			var strShowBedNo = GeneralFunction.GetAppsettingUnitWiseValue("ShowBedNoInPrint");
        //			var ReportStatus = row["STATUS"].ToString(); //added by priyanka on 18/03/2025
        //			List<VerifyandPrint> lstData = new List<VerifyandPrint>
        //						{
        //								new VerifyandPrint { strResultNo = strResultNo } 
        //						};
        //			List<object> lstAll = new List<object>();
        //			lstAll = GetMultiplePrintData(lstData, strLetterHeadYN, strShowSpecimen, strShowBedNo);
        //			if (lstAll != null && lstAll.Count > 1)
        //			{
        //				PrintByte = (byte[])lstAll[1];
        //			}

        //			if (PrintByte != null && PrintByte.Length > 0)
        //			{
        //				string UnitCode = (string)HttpContext.Current.Session["UNITCODE"];
        //				if (UnitCode != "")
        //				{

        //					//--This copy we need to save without the password Protected
        //					string pathToSave = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath") + "\\" + UnitCode;
        //					DirectoryInfo di = Directory.CreateDirectory(pathToSave);
        //					pathToSave += "\\" + row["MRNO"].ToString();
        //					DirectoryInfo di1 = Directory.CreateDirectory(pathToSave);
        //					pathToSave += "\\" + strResultNo;
        //					DirectoryInfo di2 = Directory.CreateDirectory(pathToSave);


        //					//Added by priyanka on 18/03/2025 When user will change veririfed report then New file will get uploaded and previous file will get renamed with copy
        //					//start
        //					if (ReportStatus == "V")
        //					{
        //						// Check if the file already exists
        //						string filePath = pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf";
        //						if (File.Exists(filePath))
        //						{
        //							var files = di2.GetFiles();

        //							var matchedFiles = files.Where(f => f.Name.Contains(row["RESULTNO"].ToString())).ToList();
        //							if (matchedFiles.Count() > 0)
        //							{
        //								string newFileName = pathToSave + "\\" + row["RESULTNO"].ToString() + "_" + matchedFiles.Count.ToString("D2") + "_Copy.pdf";
        //								File.Move(filePath, newFileName);
        //							}
        //						}

        //						// Save the new file (latest one)
        //						System.IO.File.WriteAllBytes(filePath, PrintByte);
        //					}
        //					else
        //					{
        //						System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte);
        //					}
        //					//end
        //					System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte);

        //					var PatPhone = row["PATMOBILE"].ToString().Trim();
        //					byte[] PrintByte1 = GeneralFunction.ApplyPasswordProtection(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PatPhone);
        //					System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte1);
        //					//---//

        //					//To save the file for the QR Code scanning path
        //					pathToSave = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath") + "\\" + UnitCode;
        //					DirectoryInfo di3 = Directory.CreateDirectory(pathToSave);
        //					pathToSave += "\\" + "QRCode";
        //					DirectoryInfo di4 = Directory.CreateDirectory(pathToSave);
        //					pathToSave += "\\" + row["MRNO"].ToString();
        //					DirectoryInfo di5 = Directory.CreateDirectory(pathToSave);
        //					pathToSave += "\\" + strResultNo;
        //					DirectoryInfo di6 = Directory.CreateDirectory(pathToSave);
        //					System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte);
        //					//--//Meenakshi to save the one more copy in qrcode folder without password protection
        //				}
        //			}
        //		}
        //		return "Success";
        //	}
        //	catch (Exception ex)
        //	{
        //		GeneralFunction.WritePDFErrorLog(strResultNo, ex.Message);
        //		return "Failed To upload the report";
        //	}
        //}



    }
    #endregion

    //public class VerifyandPrint : formrights
    //{
    //	public List<OncologyEMR.CommonSerRef.LabDeptLstItem> lstLabDept { set; get; }
    //	public List<OncologyEMR.CommonSerRef.SelectLstItem> lstNursingStation { set; get; }
    //	public List<OncologyEMR.CommonSerRef.CounterSelItem> lstCounter { set; get; }
    //	public List<OncologyEMR.CommonSerRef.CompanySelLstItem> lstCreditCompany { set; get; }
    //	public List<OncologyEMR.CommonSerRef.SelectLstItem> lstSpeciman { set; get; }
    //	public List<OncologyEMR.CommonSerRef.LabTechnoLstItem> lstTechnologist { set; get; }
    //	public List<OncologyEMR.CommonSerRef.DoctorSelLstItem> lstDoctor { set; get; }
    //	public List<OncologyEMR.CommonSerRef.SelectLstItem> lstDept { set; get; }
    //	public List<OncologyEMR.CommonSerRef.ICDLstItem> lstICD { set; get; }
    //	//public List<WEBJUPCIS.LabServRef.LabTempplateList> lstTemplates { set; get; }
    //	//public List<WEBJUPCIS.ComServRef.SelectLstItem> lstOrgGrp { set; get; }
    //	//public List<WEBJUPCIS.LabServRef.MircroOrgItemList> lstMicroGrp { set; get; }
    //	public string strSensitivityLst { set; get; }
    //	public string strResultNo { set; get; }
    //	public string strResultType { set; get; }
    //	public string UpdateYN { set; get; }
    //	public string PrntPrvw { set; get; }
    //	public string isTechnician { get; set; }
    //	public string UpdateType { set; get; }
    //	public string PATEMAIL { get; set; }
    //	public string MRNO { get; set; }
    //	public string CommentsRights { set; get; } //Madhuri added this right for the comment entry
    //	[AllowHtml]
    //	public string HtmlTemplate { get; set; }

    //	[AllowHtml]
    //	public string HtmlImpressiveTemplate { get; set; }

    ////	public string GetResultVerfyPrint(string strFrmDt, string strToDt, string strMrNo, string strPatname, string strIpNo, string strNurseCd, string strDepcd,
    ////			string strCounterCd
    ////, string strCreditcompCd, string strPatType, string strPriority, string strCriteria, string strResultNo)
    ////	{
    ////		LaboratoryClient labClient = new LaboratoryClient();
    ////		JavaScriptSerializer ser = new JavaScriptSerializer();
    ////		DataSet load = new DataSet();
    ////		int i = 0;
    ////		string strPrintYN = "";
    ////		if (strCriteria == "P")
    ////		{
    ////			strCriteria = "V";
    ////			strPrintYN = "Y";
    ////		}
    ////		else if (strCriteria == "V")
    ////		{
    ////			strPrintYN = "N";
    ////		}
    ////		else if (strCriteria == "R")
    ////		{
    ////			strPrintYN = "N";
    ////		}
    ////		var TechVerify = GeneralFunction.GetAppsettingUnitWiseValue("TechVerifyYN");

    ////		load.ReadXml(new XmlTextReader(new StringReader(labClient.GetResultList(strFrmDt, strToDt, strCriteria, strMrNo, strIpNo,
    ////				strPatname, "", strDepcd, GeneralFunction.LabType.L.ToString(), strPatType, strPriority, strPrintYN, strCounterCd, strNurseCd, strCreditcompCd, strResultNo))));
    ////		if (load.Tables.Count > 0)
    ////		{
    ////			if (TechVerify == "Y")
    ////			{
    ////				if (load.Tables.Count > 0)
    ////				{
    ////					if (load.Tables[0].Select("TECHVERIRBY <> ''").Count() > 0)
    ////					{
    ////						DataTable DttechVerified = load.Tables[0].Select("TECHVERIRBY <> ''").CopyToDataTable();
    ////						load.Tables.Remove(load.Tables[0].TableName);
    ////						load.Tables.Add(DttechVerified);
    ////					}
    ////					else
    ////					{
    ////						load.Tables.Remove(load.Tables[0].TableName);
    ////					}
    ////				}

    ////			}

    ////			if (load.Tables.Count > 0)
    ////			{
    ////				var jsonData = (from DataRow row in load.Tables[0].Rows
    ////												select new
    ////												{
    ////													id = ++i,
    ////													SAMLECOLNO = row["SAMLECOLNO"].ToString().Trim(),
    ////													ORDERNO = row["ORDERNO"].ToString().Trim(),
    ////													MRNO = row["MRNO"].ToString().Trim(),
    ////													IPNO = row["IPNO"].ToString().Trim(),
    ////													PATNAME = row["PATNAME"].ToString().Trim(),
    ////													AGE = row["AGE"].ToString().Trim(),
    ////													SEX = GeneralFunction.GetPatGender(row["SEX"].ToString().Trim()),
    ////													PATCATGNM = row["PATCATGNM"].ToString().Trim(),
    ////													WARDNO = row["WARDNO"].ToString().Trim(),
    ////													WARDNAME = row["WARDNM"].ToString().Trim(),
    ////													BEDNUMBER = row["BEDNUMBER"].ToString().Trim(),
    ////													BILLNO = row["BILLNO"].ToString().Trim(),
    ////													ORDEREDBY = row["ORDERBYDOCTNM"].ToString().Trim(),
    ////													BILLREMARK = row["REMARKS"].ToString().Trim(),
    ////													CREATEDBY = row["CREATEDBY"].ToString().Trim(),
    ////													ORDERDATE = GeneralFunction.GetUIDateFormat(row["ORDERDATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
    ////													ORDERTIME = row["ORDERTIME"].ToString().Trim(),
    ////													NURSTNAME = row["NURSTNM"].ToString().Trim(),
    ////													RESULTNO = row["RESULTNO"].ToString().Trim(),
    ////													RESULTDT = GeneralFunction.GetUIDateFormat(row["RESULTDATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
    ////													RESULTTM = row["RESULTTIME"].ToString().Trim(),
    ////													PATPHONE = row["PATPHONE"].ToString().Trim(),
    ////													PATTYPE = GeneralFunction.GetPatTypeDesc(row["PATTYPE"].ToString().Trim()),//row["PATTYPE"].ToString().Trim() == "I" ? "Inpatient" : "OutPatient",
    ////													PRIORITY = GeneralFunction.GetPriorityDesc(row["PRIORITY"].ToString().Trim()),// row["PRIORITY"].ToString().Trim() == "E" ? "Emergency" : "Regular",
    ////													RESTYPECD = row["RESULTTYPE"].ToString().Trim(),
    ////													PATDUE = row["PATDUE"].ToString().Trim(),
    ////													PATMOBILE = row["PATMOBILE"].ToString().Trim(),
    ////													ORDERSTATUS = row["ORDSTATUS"].ToString().Trim(),
    ////													TESTNM = row["TEST"].ToString().Trim(),
    ////													//pRINTED BY,ON, AT ADDED BY MEENAKSHI
    ////													PRINTEDBY = GeneralFunction.GetUserName(row["PRINTEDBY"].ToString().Trim()),
    ////													PRINTEDON = GeneralFunction.GetUIDateFormat(row["PRINTEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
    ////													PRINTEDAT = row["PRINTEDAT"].ToString().Trim(),
    ////													// END
    ////													//pRINTED BY,ON, AT ADDED BY rajan
    ////													EMAILBY = row["EMAILEDBY"].ToString().Trim(),
    ////													EMAILDTTM = GeneralFunction.GetUIDateFormat(row["EMAILEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY) + " " + row["EMAILEDAT"].ToString().Trim(),
    ////													PATEMAIL = row["PATEMAIL"].ToString().Trim(),
    ////													///
    ////													DELIVEREDSTATUS = row["DELVSTATUS"].ToString().Trim(),
    ////												}).ToList();
    ////				ser.MaxJsonLength = int.MaxValue;
    ////				return ser.Serialize(jsonData);
    ////			}
    ////		}
    ////		ser.MaxJsonLength = int.MaxValue;
    ////		return ser.Serialize("");
    ////	}
    //	#region "MultiplePrint"

    //	public List<object> GetMultiplePrintData(List<VerifyandPrint> lstData, string strLetterHeadYN = "", string strShowSpecimen = "", string strShowBedNo = "")
    //	{
    //		try
    //		{
    //			DataSet load = new DataSet();
    //			DataSet dsSign = new DataSet();
    //			OncologyEMRClient labClient = new OncologyEMRClient();
    //			//CommonService commserv = new CommonSerRef();
    //			string strResultNo = string.Join(",", lstData.Select(x => x.strResultNo));
    //			load.ReadXml(new XmlTextReader(new StringReader(labClient.GetMultiResultData(GeneralFunction.LabType.L.ToString(), strResultNo))));
    //			dsSign.ReadXml(new XmlTextReader(new StringReader(labClient.GetLabSignDet())));
    //			byte[] PrintByte = null;
    //			string RefOutsideYN = "N";
    //			var reports = new ConcurrentBag<byte[]>();
    //			List<Task> lstTask = new List<Task>();
    //			List<byte[]> lstAllPrint = new List<byte[]>();
    //			foreach (DataRow row in load.Tables["Table"].Rows)
    //			{
    //				DataTable DTPATINFO = load.Tables["Table"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'").CopyToDataTable();
    //				if (row["RESULTTYPE"].ToString().Trim() == "01")
    //				{
    //					if (load.Tables.Contains("Table1"))
    //					{
    //						DataRow[] drRegular = load.Tables["Table1"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'");
    //						if (drRegular.Length > 0)
    //						{
    //							lstAllPrint.Add(BindRegularReport(drRegular, DTPATINFO.Rows[0], dsSign, "01", "", strLetterHeadYN, lstData[0].PrntPrvw,
    //									strShowSpecimen, strShowBedNo));
    //						}
    //						RefOutsideYN = RefOutsideYN == "Y" ? RefOutsideYN : load.Tables["Table1"].Select("EXTTSTYN = 'Y'").Count() > 0 ? "Y" : "N";
    //					}
    //					else
    //					{
    //						RefOutsideYN = "Y";
    //					}
    //				}
    //				else if (row["RESULTTYPE"].ToString().Trim() == "03")
    //				{
    //					if (load.Tables["Table1"] != null)
    //					{
    //						DataRow[] drRegular = load.Tables["Table1"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'");
    //						if (drRegular.Length > 0)
    //						{
    //							lstAllPrint.Add(BindRegularReport(drRegular, DTPATINFO.Rows[0], dsSign, "01", "", strLetterHeadYN, lstData[0].PrntPrvw, strShowSpecimen, strShowBedNo));
    //							RefOutsideYN = RefOutsideYN == "Y" ? RefOutsideYN : load.Tables["Table1"].Select("EXTTSTYN = 'Y'").Count() > 0 ? "Y" : "N";
    //						}
    //					}
    //					if (load.Tables["Table2"] != null)
    //					{
    //						DataRow[] drMicro = load.Tables["Table2"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'");
    //						if (drMicro.Length > 0)
    //						{
    //							lstAllPrint.Add(BindRegularReport(drMicro, DTPATINFO.Rows[0], dsSign, "03", "", strLetterHeadYN, lstData[0].PrntPrvw, strShowSpecimen, strShowBedNo));
    //						}
    //						RefOutsideYN = RefOutsideYN == "Y" ? RefOutsideYN : load.Tables["Table2"].Select("EXTTSTYN = 'Y'").Count() > 0 ? "Y" : "N";
    //					}
    //					if (load.Tables["Table3"] != null)
    //					{
    //						DataRow[] drMicro = load.Tables["Table3"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'");

    //						DataRow[] dr = load.Tables["Table3"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'");//.Rows[0]["TESTNAME"].ToString().Trim();

    //						string strTestName = dr[0]["TESTNAME"].ToString().Trim();

    //						if (drMicro.Length > 0)
    //						{
    //							lstAllPrint.Add(BindRegularReport(drMicro, DTPATINFO.Rows[0], dsSign, "03", strTestName, strLetterHeadYN, lstData[0].PrntPrvw, strShowSpecimen, strShowBedNo));
    //						}
    //						RefOutsideYN = RefOutsideYN == "Y" ? RefOutsideYN : load.Tables["Table3"].Select("EXTTSTYN = 'Y'").Count() > 0 ? "Y" : "N";
    //					}
    //				}
    //				else
    //				{
    //					DataRow[] drTemplate = load.Tables["Table2"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'");
    //					DataRow[] drTemplateInfo = load.Tables["Table"].Select("RESULTNO='" + row["RESULTNO"].ToString() + "'"); //added by priyanka on 25/03/2025
    //					if (drTemplate.Length > 0)
    //					{
    //						string AddendumDt = "";
    //						if (load.Tables.Contains("Table4"))
    //						{
    //							var Amendment = (from DataRow Addendumrow in load.Tables["Table4"].Rows
    //															 select new
    //															 {
    //																 SEQNO = Addendumrow["SEQNO"].ToString().Trim(),
    //																 AMNDMNTDET = Addendumrow["AMNDMNTDET"].ToString().Trim(),
    //																 AMNDBY = Addendumrow["AMNDBY"].ToString().Trim(),
    //																 AMNDDATE = Addendumrow["AMNDDATE"].ToString().Trim(),
    //																 AMNDTIME = Addendumrow["AMNDTIME"].ToString().Trim(),
    //																 STATUS = Addendumrow["STATUS"].ToString().Trim(),
    //																 RECORDTYPE = Addendumrow["RECORDTYPE"].ToString().Trim(), //added By Ashvini on 4/03/2025
    //																 VERIFYBY = Addendumrow["VERIFYBY"].ToString().Trim(), //added By Ashvini
    //																 VERIFYON = Addendumrow["VERIFYDT"].ToString().Trim(), //added By Ashvini
    //																 VERIFYAT = Addendumrow["VERIFYTM"].ToString().Trim(), //added By Ashvini
    //															 }).ToList();
    //							AddendumDt = JsonConvert.SerializeObject(Amendment);
    //						}
    //						//priyanka on 20/03/2025
    //						lstAllPrint.Add(PrintTemplate(drTemplate[0]["TEMPNAME"].ToString(), DTPATINFO.Rows[0], drTemplate[0]["RESULTDT"].ToString(), dsSign, strLetterHeadYN, lstData[0].PrntPrvw, drTemplate[0]["IMPRESSIONDT"].ToString(), AddendumDt, "", drTemplateInfo[0]["REMARKS"].ToString(), drTemplateInfo[0]["COMMENTDT"].ToString(), drTemplateInfo[0]["MTRLSENT"].ToString())); //added Remarks by priyanka on 24/03/2025
    //					}
    //					RefOutsideYN = RefOutsideYN == "Y" ? RefOutsideYN : load.Tables["Table2"].Select("EXTTSTYN = 'Y'").Count() > 0 ? "Y" : "N";
    //				}
    //			}

    //			List<object> lstAll = new List<object>();
    //			string PrintStaus = "Success";

    //			if (lstAllPrint.Count > 0)
    //			{
    //				PrintByte = WebJupCommonTemplates.DataClass.PdfTemplate.concatAndAddContent(lstAllPrint);
    //			}
    //			else
    //			{
    //				PrintStaus = "No Data Found.";
    //			}

    //			if (((VerifyandPrint)lstData[0]).UpdateYN == "Y")
    //			{
    //				var status = labClient.UpdatePrintStatus(strResultNo, (string)HttpContext.Current.Session["UserID"], ((VerifyandPrint)lstData[0]).UpdateType);
    //				if (status < 0)
    //				{
    //					PrintStaus = "Print Loading Failure.";
    //				}
    //			}

    //			lstAll.Add(PrintStaus);
    //			lstAll.Add(PrintByte);
    //			lstAll.Add(RefOutsideYN);
    //			return lstAll;
    //		}
    //		catch (Exception ex)
    //		{
    //			throw ex;
    //		}
    //	}


    //	public string PreparePDFDocumentForPassedResultNo(string strResultNo)
    //		{
    //				try
    //				{
    //						DataSet load = new DataSet();
    //						OncologyEMRClient labClient = new OncologyEMRClient();
    //						load.ReadXml(new XmlTextReader(new StringReader(labClient.GetMultiResultData("L", strResultNo))));

    //						foreach (DataRow row in load.Tables["Table"].Rows)
    //						{
    //								byte[] PrintByte = null;
    //								string strLetterHeadYN = "Y";
    //								var strShowSpecimen = GeneralFunction.GetAppsettingUnitWiseValue("ShowSpecimenInPrint");
    //								var strShowBedNo = GeneralFunction.GetAppsettingUnitWiseValue("ShowBedNoInPrint");
    //								var ReportStatus = row["STATUS"].ToString(); //added by priyanka on 18/03/2025
    //								List<VerifyandPrint> lstData = new List<VerifyandPrint>
    //								{
    //										new VerifyandPrint { strResultNo = strResultNo } 
    //								};
    //								List<object> lstAll = new List<object>();
    //								lstAll = GetMultiplePrintData(lstData, strLetterHeadYN, strShowSpecimen, strShowBedNo);
    //								if (lstAll != null && lstAll.Count > 1)
    //								{
    //										PrintByte = (byte[])lstAll[1];
    //								}

    //								if (PrintByte != null && PrintByte.Length > 0)
    //								{
    //										string UnitCode = (string)HttpContext.Current.Session["UNITCODE"];
    //										if (UnitCode != "")
    //										{

    //												//--This copy we need to save without the password Protected
    //												string pathToSave = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath") + "\\" + UnitCode  ;
    //												DirectoryInfo di = Directory.CreateDirectory(pathToSave);
    //												pathToSave += "\\" + row["MRNO"].ToString();
    //												DirectoryInfo di1 = Directory.CreateDirectory(pathToSave);
    //												pathToSave += "\\" + strResultNo;
    //												DirectoryInfo di2 = Directory.CreateDirectory(pathToSave);

    //											//Added by priyanka on 18/03/2025 When user will change veririfed report then New file will get uploaded and previous file will get renamed with copy
    //												//start
    //												if (ReportStatus == "V")
    //												{
    //														// Check if the file already exists
    //														string filePath = pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf";
    //														if (File.Exists(filePath))
    //														{
    //																var files = di2.GetFiles();

    //																var matchedFiles = files.Where(f => f.Name.Contains(row["RESULTNO"].ToString())).ToList();
    //																if (matchedFiles.Count() > 0)
    //																{
    //																		string newFileName = pathToSave + "\\" + row["RESULTNO"].ToString() + "_" + matchedFiles.Count.ToString("D2") + "_Copy.pdf";
    //																		File.Move(filePath, newFileName);
    //																}
    //														}

    //														// Save the new file (latest one)
    //														System.IO.File.WriteAllBytes(filePath, PrintByte);
    //												}
    //												else
    //												{
    //														System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte);
    //												}
    //												//end
    //												System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte);

    //												var PatPhone = row["PATMOBILE"].ToString().Trim();
    //												byte[] PrintByte1 = GeneralFunction.ApplyPasswordProtection(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PatPhone);
    //												System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte1);
    //												//---//

    //												//To save the file for the QR Code scanning path
    //												pathToSave = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath") + "\\" + UnitCode ;
    //												DirectoryInfo di3 = Directory.CreateDirectory(pathToSave);
    //												pathToSave += "\\" + "QRCode";
    //												DirectoryInfo di4 = Directory.CreateDirectory(pathToSave);
    //												pathToSave += "\\" + row["MRNO"].ToString();
    //												DirectoryInfo di5 = Directory.CreateDirectory(pathToSave);
    //												pathToSave += "\\" + strResultNo;
    //												DirectoryInfo di6 = Directory.CreateDirectory(pathToSave);
    //												System.IO.File.WriteAllBytes(pathToSave + "\\" + row["RESULTNO"].ToString() + ".pdf", PrintByte);
    //												//--//Meenakshi to save the one more copy in qrcode folder without password protection
    //										}
    //								}
    //						}
    //						return "Success";
    //				}
    //				catch (Exception ex)
    //				{
    //						GeneralFunction.WritePDFErrorLog(strResultNo, ex.Message);
    //						return "Failed To upload the report";
    //				}
    //		}


    //	//private byte[] BindRegularReport(DataRow[] drRegular, DataRow patInfo, DataSet dssign, string strResulttype, string strTestName = "", string strLetterHeadYN = "",
    //	//		string PrntPrvw = "", string strShowSpecimen = "", string strShowBedNo = "", string PrintedByUserName = "")
    //	//{
    //	//	var QREnableYN = GeneralFunction.GetAppsettingUnitWiseValue("QRREPORTYN").Trim();
    //	//	OncologyEMRClient lab = new OncologyEMRClient();
    //	//	//CommonServiceClient com = new CommonServiceClient();
    //	//	co
    //	//	DataTable dtInvestData = new DataTable();
    //	//	DataTable dtHeader = new DataTable();
    //	//	string strTstRemark = "";
    //	//	if (strResulttype == "01")
    //	//	{
    //	//		dtInvestData = BindPrintRegularReport(drRegular, ref strTstRemark, strShowSpecimen, strShowBedNo);
    //	//		dtInvestData.TableName = "ResultReportRegularDtl";
    //	//	}
    //	//	else
    //	//	{
    //	//		dtInvestData = BindPrintMicroBioReport(drRegular, strResulttype);

    //	//		dtInvestData.TableName = "MicrobiologyDtl";
    //	//	}

    //	//	dtHeader.Columns.Add("Name");
    //	//	dtHeader.Columns.Add("Age/Sex");
    //	//	dtHeader.Columns.Add("Referred By");
    //	//	dtHeader.Columns.Add("Result No");
    //	//	dtHeader.Columns.Add("Labdptcd");
    //	//	dtHeader.Columns.Add("Ordered By");
    //	//	dtHeader.Columns.Add("TestRemark");
    //	//	dtHeader.Columns.Add("Bed Number");
    //	//	dtHeader.Columns.Add("Ward Number");
    //	//	dtHeader.Columns.Add("Comment");
    //	//	dtHeader.Columns.Add("Bill Number");
    //	//	dtHeader.Columns.Add("HealthCheckYn");
    //	//	dtHeader.Columns.Add("Specimen");
    //	//	dtHeader.Columns.Add("MR No");
    //	//	dtHeader.Columns.Add("IP No");
    //	//	dtHeader.Columns.Add("Pat ID");
    //	//	dtHeader.Columns.Add("Result Date");
    //	//	dtHeader.Columns.Add("Result Time");
    //	//	dtHeader.Columns.Add("Sample Col Date");
    //	//	dtHeader.Columns.Add("Sample Col Time");
    //	//	dtHeader.Columns.Add("PrintDate");
    //	//	dtHeader.Columns.Add("PrintTime");
    //	//	dtHeader.Columns.Add("Print By");
    //	//	dtHeader.Columns.Add("Name1");
    //	//	dtHeader.Columns.Add("Name2");
    //	//	dtHeader.Columns.Add("Name3");
    //	//	dtHeader.Columns.Add("Profile1");
    //	//	dtHeader.Columns.Add("Profile2");
    //	//	dtHeader.Columns.Add("Profile3");
    //	//	dtHeader.Columns.Add("Sign1", typeof(byte[]));
    //	//	dtHeader.Columns.Add("Sign2", typeof(byte[]));
    //	//	dtHeader.Columns.Add("Sign3", typeof(byte[]));
    //	//	dtHeader.Columns.Add("Method");
    //	//	dtHeader.Columns.Add("TestName");
    //	//	dtHeader.Columns.Add("CreatedBY");
    //	//	dtHeader.Columns.Add("ReportType");
    //	//	dtHeader.Columns.Add("CultureRemark");
    //	//	dtHeader.Columns.Add("LetterHead");
    //	//	dtHeader.Columns.Add("OrderDate");
    //	//	dtHeader.Columns.Add("OrderTime");
    //	//	dtHeader.Columns.Add("ShowSpecimen"); //Added by Murali on 21/11/2021
    //	//	dtHeader.Columns.Add("ShowBedNo"); //Added by Murali on 21/11/2021
    //	//	dtHeader.Columns.Add("ResultBarCD", System.Type.GetType("System.Byte[]"));  //Added by Meenakshi on 19/07/2022
    //	//	dtHeader.Columns.Add("Sample Col No"); //Added by Murali on 13/09/2023

    //	//	dtHeader.Columns.Add("UNITNMYN");     // Added by Dhananjay 20240720 
    //	//	dtHeader.Columns.Add("BIOREFINTERVAL");   // Added by Dhananjay 20240720   
    //	//	dtHeader.Columns.Add("EXEMPPROOF");  //added by ashvini 
    //	//	dtHeader.Columns.Add("SHOWORDERDATETIME");   //added by ashvini
    //	//	dtHeader.Columns.Add("PathQR", System.Type.GetType("System.Byte[]"));  //Added by Dhananjay 20240807

    //	//	DataRow dr = dtHeader.NewRow();

    //	//	dr["Name"] = patInfo["PATNAME"].ToString();
    //	//	if (dssign.Tables.Count > 0)
    //	//	{
    //	//		//DataRow[] drsign = dssign.Tables[0].Select("DEPTCD='" + patInfo["LABDPTCODE"].ToString() + "'");

    //	//		DataRow[] drsign = dssign.Tables[0].Select("ID1<>''");

    //	//		if (drsign.Length > 0)
    //	//		{

    //	//			DataSet dsVerify = new DataSet();

    //	//			dsVerify = com.GetIPLogInfo(patInfo["RESULTNO"].ToString().Trim());
    //	//			dsVerify.Merge(com.GetOPLogInfo(patInfo["RESULTNO"].ToString().Trim()));

    //	//			DataTable dtVerify = new DataTable();
    //	//			dtVerify = dsVerify.Tables[0];

    //	//			DataRow[] dr1 = dtVerify.Select("ACTION='V'");
    //	//			DataRow[] dr2 = dtVerify.Select("ACTION='N'");

    //	//			string verifiedBy = ""; string TechVerifyBy = ""; string verifiedBy1 = "";

    //	//			//if (dr1.Length > 0)
    //	//			//   {
    //	//			//       var VerifiedByUser = "";
    //	//			//       VerifiedByUser = dr1[0]["USERID"].ToString().Trim() ;
    //	//			//       verifiedBy = VerifiedByUser.Contains(" ") ? VerifiedByUser.Substring(0,VerifiedByUser.IndexOf(' ')) : dr1[0]["USERID"].ToString().Trim();
    //	//			//   }
    //	//			//   if (dr1.Length > 1)
    //	//			//   {
    //	//			//       var VerifiedByUser = "";
    //	//			//       VerifiedByUser = dr1[1]["USERID"].ToString().Trim();
    //	//			//       verifiedBy1 = VerifiedByUser.Contains(" ") ? VerifiedByUser.Substring(0, VerifiedByUser.IndexOf(' ')) : dr1[1]["USERID"].ToString().Trim();
    //	//			//   }

    //	//			if (GeneralFunction.GetAppsettingUnitWiseValue("TechVerifyYN") == "N")
    //	//			{
    //	//				if (dr1.Length > 0)
    //	//				{
    //	//					var VerifiedByUser = "";
    //	//					VerifiedByUser = dr1[0]["USERID"].ToString().Trim();
    //	//					verifiedBy = VerifiedByUser.Contains(" ") ? VerifiedByUser.Substring(0, VerifiedByUser.IndexOf(' ')) : dr1[0]["USERID"].ToString().Trim();
    //	//				}
    //	//			}
    //	//			else
    //	//			{
    //	//				if (dr1.Length > 0)
    //	//				{
    //	//					var VerifiedByUser = "";
    //	//					VerifiedByUser = dr1[0]["USERID"].ToString().Trim();
    //	//					verifiedBy1 = VerifiedByUser.Contains(" ") ? VerifiedByUser.Substring(0, VerifiedByUser.IndexOf(' ')) : dr1[0]["USERID"].ToString().Trim();
    //	//				}

    //	//				if (dr1.Length > 1)
    //	//				{


    //	//					var VerifiedByUser = "";
    //	//					VerifiedByUser = dr1[dr1.Length - 1]["USERID"].ToString().Trim();
    //	//					verifiedBy = VerifiedByUser.Contains(" ") ? VerifiedByUser.Substring(0, VerifiedByUser.IndexOf(' ')) : dr1[dr1.Length - 1]["USERID"].ToString().Trim();


    //	//				}
    //	//			}

    //	//			//var tempa = verifiedBy1;

    //	//			//if (verifiedBy1 != "" )
    //	//			//{
    //	//			//    verifiedBy1 = verifiedBy;
    //	//			//    verifiedBy = tempa;
    //	//			//}
    //	//			var flag = false;
    //	//			for (int i = 0; i < drsign.Length; i++)
    //	//			{
    //	//				if (verifiedBy == drsign[i]["ID1"].ToString().ToUpper().Trim())
    //	//				{
    //	//					dr["Name1"] = drsign[i]["NAME1"].ToString().Trim();
    //	//					dr["Profile1"] = drsign[i]["PROFILE1"].ToString().Trim();
    //	//					dr["Sign1"] = Convert.FromBase64String(drsign[i]["SIGNATURE1"].ToString());
    //	//					flag = true;
    //	//					break;
    //	//				}
    //	//				else if (verifiedBy == drsign[i]["ID1"].ToString().ToUpper().Trim())
    //	//				{
    //	//					dr["Name2"] = drsign[i]["NAME1"].ToString().Trim();
    //	//					dr["Profile2"] = drsign[i]["PROFILE1"].ToString().Trim();
    //	//					dr["Sign2"] = Convert.FromBase64String(drsign[i]["SIGNATURE1"].ToString());
    //	//					flag = true;
    //	//					break;
    //	//				}
    //	//			}
    //	//			for (int j = 0; j < drsign.Length; j++)
    //	//			{

    //	//				if (verifiedBy1 == drsign[j]["ID1"].ToString().ToUpper().Trim())
    //	//				{
    //	//					dr["Name3"] = drsign[j]["NAME1"].ToString().Trim();
    //	//					dr["Profile3"] = drsign[j]["PROFILE1"].ToString().Trim();
    //	//					dr["Sign3"] = Convert.FromBase64String(drsign[j]["SIGNATURE1"].ToString());
    //	//					flag = true;
    //	//					break;
    //	//				}
    //	//			}

    //	//			if (flag == false)
    //	//			{
    //	//				dr["Name1"] = "";
    //	//				dr["Name2"] = "";
    //	//				dr["Name3"] = "";
    //	//				dr["Profile1"] = "";
    //	//				dr["Profile2"] = "";
    //	//				dr["Profile3"] = "";
    //	//				dr["Sign1"] = new byte[0];
    //	//				dr["Sign2"] = new byte[0];
    //	//				dr["Sign3"] = new byte[0];
    //	//			}
    //	//		}
    //	//	}
    //	//	else
    //	//	{
    //	//		dr["Name1"] = "";
    //	//		dr["Name2"] = "";
    //	//		dr["Name3"] = "";
    //	//		dr["Profile1"] = "";
    //	//		dr["Profile2"] = "";
    //	//		dr["Profile3"] = "";
    //	//		dr["Sign1"] = new byte[0];
    //	//		dr["Sign2"] = new byte[0];
    //	//		dr["Sign3"] = new byte[0];
    //	//	}

    //	//	string ageGender = GeneralFunction.GetAgeToPrint(patInfo["AGE"].ToString());
    //	//	ageGender += "/" + GeneralFunction.GetPatGender(patInfo["SEX"].ToString());
    //	//	dr["Age/Sex"] = ageGender;
    //	//	dr["SHOWORDERDATETIME"] = (string.Empty + GeneralFunction.GetAppsettingUnitWiseValue("PRINTORDERDATETIMEYN")).ToString().Trim();  //added by ashvini
    //	//	if (("" + patInfo["REPORTDCNM"]).ToString() == "")
    //	//	{
    //	//		dr["Referred By"] = "";
    //	//	}
    //	//	else
    //	//	{
    //	//		dr["Referred By"] = "Dr. " + patInfo["REPORTDCNM"].ToString();
    //	//	}

    //	//	dr["Result No"] = patInfo["RESULTNO"].ToString();
    //	//	dr["Labdptcd"] = patInfo["LABDPTDESC"].ToString();

    //	//	if (("" + patInfo["ORDERBYDOCTNM"]).ToString() == "")
    //	//	{
    //	//		dr["Referred By"] = "";
    //	//	}
    //	//	else
    //	//	{
    //	//		dr["Referred By"] = "Dr. " + patInfo["ORDERBYDOCTNM"].ToString();
    //	//	}

    //	//	GeneralFunction gen = new GeneralFunction();
    //	//	dr["ResultBarCD"] = gen.GenerateBarcode(dr["Result No"].ToString().Trim());

    //	//	// Added by Dhananjay for QR - 20240807
    //	//	if (PrntPrvw == "")
    //	//	{
    //	//		string resultNo = dr["Result No"].ToString().Trim();
    //	//		string mrNo = patInfo["MRNO"].ToString().Trim();
    //	//		string reportUrl = gen.GenerateReportUrl(resultNo, mrNo);
    //	//		dr["PathQR"] = (QREnableYN == "Y" && reportUrl != "") ? gen.GenerateQRCode(reportUrl, resultNo) : new byte[0];
    //	//	}

    //	//	dr["TestRemark"] = strTstRemark;
    //	//	dr["Bed Number"] = patInfo["BEDNUMBER"].ToString();
    //	//	dr["Ward Number"] = patInfo["WARDNM"].ToString();
    //	//	dr["Comment"] = patInfo["COMMENTDT"].ToString();
    //	//	dr["CultureRemark"] = patInfo["CULTCOMMENT"].ToString();
    //	//	dr["Bill Number"] = patInfo["BILLNO"].ToString().Trim();
    //	//	dr["HealthCheckYn"] = "";
    //	//	dr["Specimen"] = patInfo["SPECDESC"].ToString();
    //	//	dr["MR No"] = patInfo["MRNO"].ToString();
    //	//	dr["IP No"] = patInfo["IPNO"].ToString() == "" ? "" : patInfo["IPNO"].ToString();
    //	//	//dr["Pat ID"]=dtTop.Rows[0]["Name"].ToString();
    //	//	dr["Result Date"] = GeneralFunction.GetUIDateFormat(patInfo["RESULTDATE"].ToString(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
    //	//	dr["Result Time"] = patInfo["RESULTTIME"].ToString();
    //	//	dr["Sample Col Date"] = GeneralFunction.GetUIDateFormat(patInfo["SAMCOLDATE"].ToString(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
    //	//	dr["Sample Col Time"] = patInfo["SAMCOLTIME"].ToString();
    //	//	dr["PrintDate"] = DateTime.Now.ToString("dd/MM/yyyy");
    //	//	dr["PrintTime"] = DateTime.Now.ToString("HH:mm:ss");
    //	//	dr["Print By"] = PrintedByUserName == "" ? (string)HttpContext.Current.Session["UserID"] : PrintedByUserName;
    //	//	dr["TestName"] = strTestName;
    //	//	dr["Method"] = patInfo["AUTOMTHD"].ToString().Trim() == "Y" ? "Automated Method" : "Manual Method";
    //	//	//Added below condition by Murali on 17/05/2024 for Report Type
    //	//	//******************************************************************************
    //	//	string strPrintType = "";
    //	//	if (GeneralFunction.GetAppsettingUnitWiseValue("RevisedYN") == "Y")
    //	//	{
    //	//		if (patInfo["REVIEWYN"].ToString().Trim() == "Y")
    //	//		{
    //	//			strPrintType = "Revised & Finalized Report";
    //	//		}
    //	//		else
    //	//		{
    //	//			strPrintType = patInfo["REPORTTYPE"].ToString().Trim() == "P" ? "Provisional Report" : "";
    //	//		}
    //	//	}
    //	//	else
    //	//		strPrintType = patInfo["REPORTTYPE"].ToString().Trim() == "P" ? "Provisional Report" : "";
    //	//	//dr["ReportType"] = patInfo["REPORTTYPE"].ToString().Trim() == "P" ? "Provisional Report" : "";
    //	//	dr["ReportType"] = strPrintType;
    //	//	//*******************************************************************

    //	//	dr["LetterHead"] = strLetterHeadYN;
    //	//	DataSet load = new DataSet();
    //	//	//load.ReadXml(new XmlTextReader(new StringReader(lab.GetLabTechnoMstLst("L"))));

    //	//	SecurServRef.SecurityClient sec = new SecurServRef.SecurityClient();

    //	//	load.ReadXml(new XmlTextReader(new StringReader(sec.GetUserList(patInfo["CREATEDBY"].ToString()))));

    //	//	dr["OrderDate"] = GeneralFunction.GetUIDateFormat(patInfo["ORDERDATE"].ToString(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
    //	//	dr["OrderTime"] = patInfo["ORDERTIME"].ToString().Trim();
    //	//	dr["ShowSpecimen"] = strShowSpecimen; //Added by Murali on 21/11/2021
    //	//	dr["ShowBedNo"] = strShowBedNo; //Added by Murali on 21/11/2021
    //	//	dr["Sample Col No"] = patInfo["SAMLECOLNO"].ToString();
    //	//	DataTable HData = new DataTable();
    //	//	HData = GeneralFunction.getHeaderFooter("", "", "", "", PrntPrvw);
    //	//	HData.TableName = "HeaderFooter";

    //	//	DataTable dt = new DataTable();
    //	//	dt = load.Tables[0];

    //	//	dr["CreatedBY"] = dt.AsEnumerable().Where(x => x.Field<string>("USERID").ToString().Trim().ToUpper() == patInfo["CREATEDBY"].ToString().Trim().ToUpper()).FirstOrDefault().Field<string>("USERNAME");
    //	//	dtHeader.Rows.Add(dr);
    //	//	dtHeader.TableName = "RegularReportHead";

    //	//	//  dtInvestData = JsonConvert.DeserializeObject<DataTable>(InvestGrid);//
    //	//	if (strResulttype == "01")
    //	//	{
    //	//		DataRow[] unitdr = dtInvestData.Select("UNITNM<>''");
    //	//		DataRow[] biorefdr = dtInvestData.Select("LOWERLIMIT<>''");

    //	//		dtHeader.Rows[0]["UNITNMYN"] = "N"; dtHeader.Rows[0]["BIOREFINTERVAL"] = "N";
    //	//		if (unitdr.Count() > 0)
    //	//		{
    //	//			dtHeader.Rows[0]["UNITNMYN"] = "Y";
    //	//		}
    //	//		if (biorefdr.Count() > 0)
    //	//		{
    //	//			dtHeader.Rows[0]["BIOREFINTERVAL"] = "Y";
    //	//		}
    //	//	}

    //	//	DataSet dsAllData = new DataSet();
    //	//	dsAllData.Tables.Add(dtHeader);
    //	//	dsAllData.Tables.Add(HData);
    //	//	string reportPath = "";
    //	//	dsAllData.Tables.Add(dtInvestData);
    //	//	if (strResulttype == "01")
    //	//	{
    //	//		// reportPath = @"C:\Users\SWAPNIL\Desktop\29May\WEBJUPHMIS\WEBJUPHMIS\Report\LabReports\rptReportRegular.rpt";
    //	//		//reportPath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/Report/LabReports"), "rptReportRegular.rpt");

    //	//		if (GeneralFunction.GetAppsettingUnitWiseValue("SpecificStructureResultEntryRptName").ToString().Trim() != "")
    //	//		{
    //	//			reportPath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/Report/LabReports"), GeneralFunction.GetAppsettingUnitWiseValue("SpecificStructureResultEntryRptName").ToString().Trim());
    //	//		}
    //	//		else
    //	//		{
    //	//			reportPath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/Report/LabReports"), "rptReportRegular.rpt");
    //	//		}
    //	//	}
    //	//	else
    //	//	{
    //	//		reportPath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/Report/LabReports"), "rptMicroBiology.rpt");
    //	//	}

    //	//	CrystalReportPdfResult cry = new CrystalReportPdfResult();
    //	//	PdfTemplate pdf = new PdfTemplate();
    //	//	CrystalDecisions.CrystalReports.Engine.ReportDocument reportDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
    //	//	reportDocument.Load(reportPath);
    //	//	string HeightFooterYN = GeneralFunction.GetAppsettingUnitWiseValue("FooterExistYN").ToString().Trim();
    //	//	foreach (CrystalDecisions.CrystalReports.Engine.Section section in reportDocument.ReportDefinition.Sections)
    //	//	{
    //	//		foreach (CrystalDecisions.CrystalReports.Engine.ReportObject reportObject in section.ReportObjects)
    //	//		{
    //	//			if (reportObject.Kind == CrystalDecisions.Shared.ReportObjectKind.BlobFieldObject && reportObject.Name == "RptFooter1")
    //	//			{
    //	//				CrystalDecisions.CrystalReports.Engine.BlobFieldObject blobFieldObject = (CrystalDecisions.CrystalReports.Engine.BlobFieldObject)reportObject;
    //	//				blobFieldObject.Height = HeightFooterYN == "N" ? 1 : Convert.ToInt32(GeneralFunction.GetAppsettingUnitWiseValue("FooterImageHeight").ToString().Trim());
    //	//			}
    //	//		}
    //	//	}
    //	//	byte[] printarr = cry.DynamicCrystalReportPdf(reportDocument, dsAllData);
    //	//	if (PrntPrvw == "Y")
    //	//	{
    //	//		byte[] printarr1 = pdf.AddLabPreviewWatermark(printarr, "Preview");
    //	//		return printarr1;
    //	//	}
    //	//	else
    //	//	{
    //	//		return printarr;
    //	//	}

    //	//}

    //	private DataTable BindPrintMicroBioReport(DataRow[] drMicro, string strResulttype)
    //	{
    //		DataTable dtMirco = new DataTable();
    //		BindEmptyPrintRegulardt(ref dtMirco, strResulttype);
    //		foreach (DataRow dr in drMicro)
    //		{
    //			DataRow row = dtMirco.NewRow();
    //			row["ANTIBIOTIC"] = dr["CULSENDESC"].ToString().Trim();
    //			row["MIC"] = dr["MICVALUE"].ToString().Trim();
    //			row["CULTYPE"] = dr["CULTYPE"].ToString().Trim();
    //			row["SENSITIVITY"] = dr["SENSITIVE"].ToString().Trim();
    //			dtMirco.Rows.Add(row);
    //		}
    //		return dtMirco;
    //	}

    //	//function for regular report
    //	private DataTable BindPrintRegularReport(DataRow[] drRegular, ref string TestRemark, string strShowSpecimen = "", string strShowBedNo = "")
    //	{
    //		DataTable dtRegrular = new DataTable();
    //		BindEmptyPrintRegulardt(ref dtRegrular, "01");
    //		string strTestCode = "";
    //		string strProfileTestNm = "";
    //		int testcount = 0;

    //		List<DataRow> Header = new List<DataRow>();
    //		List<DataRow> InvetData = new List<DataRow>();

    //		int i = 0;
    //		DataRow[] RegularRow = drRegular.AsEnumerable().ToArray();
    //		foreach (DataRow row in RegularRow)
    //		{
    //			if (strTestCode != row["TESTCODE"].ToString().Trim())
    //			{
    //				strTestCode = row["TESTCODE"].ToString().Trim();
    //				if (strProfileTestNm != row["PROFTSTNM"].ToString().Trim())
    //				{
    //					strProfileTestNm = row["PROFTSTNM"].ToString().Trim();
    //					DataRow drHeader = dtRegrular.NewRow();
    //					drHeader["TESTDESC"] = strProfileTestNm;
    //					drHeader["MTHDNAME"] = "";
    //					drHeader["RESULT"] = "";
    //					drHeader["UNITNM"] = "";
    //					drHeader["LOWERLIMIT"] = "";
    //					drHeader["UPPERLIMIT"] = "";
    //					drHeader["RESULTYPE"] = "H";

    //					InvetData.Add(drHeader);
    //				}
    //				testcount = 0;
    //			}

    //			if (testcount == 0)
    //			{
    //				if (row["TSTREMARK"].ToString().Trim() != "")
    //				{
    //					if (TestRemark != "")
    //					{
    //						TestRemark += Environment.NewLine;
    //						//string strline = "";
    //						TestRemark += row["TESTNAME"].ToString().Trim() + " :";
    //						TestRemark += Environment.NewLine;
    //						//TestRemark += strline.PadLeft(row["TESTNAME"].ToString().Length, '=');
    //						//TestRemark += Environment.NewLine;
    //					}
    //					else
    //					{
    //						//string strline = "";
    //						TestRemark += row["TESTNAME"].ToString().Trim() + " :";
    //						TestRemark += Environment.NewLine;
    //						// TestRemark += strline.PadLeft(row["TESTNAME"].ToString().Length, '=');
    //						// TestRemark += Environment.NewLine;
    //					}

    //					TestRemark += row["TSTREMARK"].ToString();
    //					TestRemark += Environment.NewLine;
    //				}

    //				testcount += 1;
    //			}

    //			if (row["RESULTTYPE"].ToString().Trim() == "H")
    //			{
    //				if (InvetData.Count > 0)
    //				{

    //					if (Header.Count > 0)
    //						dtRegrular.Merge(Header.CopyToDataTable());
    //					dtRegrular.Merge(InvetData.CopyToDataTable());
    //					InvetData = new List<DataRow>();
    //					Header = new List<DataRow>();
    //				}
    //				if (CheckHeaderYN(i + 1, RegularRow))
    //				{
    //					DataRow drHeader = dtRegrular.NewRow();
    //					drHeader["TESTDESC"] = row["INVESTDESC"].ToString();
    //					drHeader["MTHDNAME"] = row["MTHDNAME"].ToString();
    //					drHeader["RESULT"] = row["RESULTDT"].ToString();
    //					drHeader["UNITNM"] = row["UNIT"].ToString();
    //					drHeader["LOWERLIMIT"] = row["NORMALVAL1"].ToString();
    //					drHeader["UPPERLIMIT"] = row["NORMALVAL2"].ToString();
    //					drHeader["ABNORMALYN"] = row["ABNORMALYN"].ToString();
    //					drHeader["RESULTYPE"] = row["RESULTTYPE"].ToString();
    //					Header.Add(drHeader);
    //				}

    //			}
    //			else if (row["RESULTDT"].ToString().Trim() != "")
    //			{

    //				DataRow dr = dtRegrular.NewRow();
    //				dr["TESTDESC"] = row["INVESTDESC"].ToString();
    //				dr["MTHDNAME"] = row["MTHDNAME"].ToString();
    //				dr["RESULT"] = row["RESULTDT"].ToString();
    //				dr["UNITNM"] = row["UNIT"].ToString();
    //				dr["LOWERLIMIT"] = row["NORMALVAL1"].ToString();
    //				dr["UPPERLIMIT"] = row["NORMALVAL2"].ToString();
    //				dr["ABNORMALYN"] = row["ABNORMALYN"].ToString();    // Added by Dhananjay 20240813


    //				dr["RESULTYPE"] = row["RESULTTYPE"].ToString();
    //				InvetData.Add(dr);
    //			}
    //			i++;
    //		}
    //		if (InvetData.Count > 0)
    //		{
    //			if (Header.Count > 0)
    //				dtRegrular.Merge(Header.CopyToDataTable());
    //			dtRegrular.Merge(InvetData.CopyToDataTable());
    //		}
    //		return dtRegrular;
    //	}

    //	private bool CheckHeaderYN(int starindx, DataRow[] drRegular)
    //	{
    //		bool flgCheck = false;
    //		bool flgHeader = true;

    //		for (int i = starindx; i < drRegular.Length; i++)
    //		{
    //			if (drRegular[i]["RESULTTYPE"].ToString().Trim() == "H" && flgHeader == true)
    //			{
    //			}
    //			else if (drRegular[i]["RESULTTYPE"].ToString().Trim() == "H" && flgHeader == false)
    //			{
    //				if (flgCheck == true)
    //				{
    //					return true;
    //				}
    //				else
    //					return false;
    //			}
    //			if (drRegular[i]["RESULTTYPE"].ToString().Trim() != "H")
    //				flgHeader = false;
    //			if (drRegular[i]["RESULTDT"].ToString().Trim() != "" && drRegular[i]["RESULTTYPE"].ToString().Trim() != "H")
    //				flgCheck = true;
    //		}
    //		if (flgCheck == true)
    //			return true;
    //		return false;
    //	}

    //	private bool FindAbNormalYN(double a, double b, double curval, string mincond, string maxcond)
    //	{

    //		if (a > 0 || b > 0)
    //		{
    //			if (mincond.Trim() == ">=" && maxcond.Trim() == "<=")
    //			{

    //				double min = Math.Min(a, b);
    //				double max = Math.Max(a, b);
    //				return curval >= min && curval <= max;
    //			}
    //			else if (mincond.Trim() == ">" && maxcond.Trim() == "<=")
    //			{
    //				double min = Math.Min(a, b);
    //				double max = Math.Max(a, b);
    //				return curval > min && curval <= max;
    //			}
    //			else if (mincond.Trim() == ">=" && maxcond.Trim() == "<")
    //			{
    //				double min = Math.Min(a, b);
    //				double max = Math.Max(a, b);
    //				return curval >= min && curval < max;
    //			}
    //			else if (mincond.Trim() == ">" && maxcond.Trim() == "<")
    //			{
    //				double min = Math.Min(a, b);
    //				double max = Math.Max(a, b);
    //				return curval > min && curval < max;
    //			}
    //			else if (mincond.Trim() == "<" && maxcond.Trim() == ">")
    //			{
    //				double min = Math.Min(a, b);
    //				double max = Math.Max(a, b);
    //				return curval < min && curval > max;
    //			}
    //			else if (mincond.Trim() == "=" && maxcond.Trim() == "=")
    //			{
    //				double min = Math.Min(a, b);
    //				double max = Math.Max(a, b);
    //				return curval == min || curval == max;
    //			}
    //			else if (mincond.Trim() == "" && maxcond.Trim() == "")
    //			{
    //				double min = Math.Min(a, b);
    //				double max = Math.Max(a, b);
    //				return curval >= min && curval <= max;
    //			}
    //			return true;
    //		}
    //		return true;
    //	}

    //	//private byte[] PrintTemplate(string TemplateName, DataRow patientInfo, string Template, DataSet dsSign, string strLetterHeadYN, string reporttype,
    //	//		 string ImpTemplate, string Adment, string PrintedByUserName = "", string strTRemarks = "", string strTComment = "", string strSpecimenNature = "") //added remarks, comment and specimen nature by priyanka on 24/03/2025
    //	//{
    //	//	patientInfo.Table.Columns["LABDPTDESC"].ColumnName = "LABDESC";
    //	//	patientInfo.Table.Columns["LABDPTCODE"].ColumnName = "LABDEPTCODE";
    //	//	string PatInfo = JsonConvert.SerializeObject(patientInfo.Table);
    //	//	TemplateReport temp = new TemplateReport();
    //	//	byte[] printarr1 = temp.PrintTemplate(TemplateName, PatInfo, PatInfo, Template, "Final", strLetterHeadYN, reporttype, ImpTemplate, Adment, "", PrintedByUserName, strTRemarks, strTComment, strSpecimenNature); //added remarks,comment and specimen nature by priyanka on 24/03/2025
    //	//	return printarr1;
    //	//}

    //	////this function for Empty RegularReport DataTable
    //	//private void BindEmptyPrintRegulardt(ref DataTable dtCopyTable, string resulttype)
    //	//{
    //	//	if (resulttype == "01")
    //	//	{
    //	//		dtCopyTable.Columns.Add("TESTDESC");
    //	//		dtCopyTable.Columns.Add("MTHDNAME");
    //	//		dtCopyTable.Columns.Add("RESULT");
    //	//		dtCopyTable.Columns.Add("UNITNM");
    //	//		dtCopyTable.Columns.Add("LOWERLIMIT");
    //	//		dtCopyTable.Columns.Add("UPPERLIMIT");
    //	//		dtCopyTable.Columns.Add("ABNORMALYN");
    //	//		dtCopyTable.Columns.Add("RESULTYPE");
    //	//	}
    //	//	else
    //	//	{
    //	//		dtCopyTable.Columns.Add("ANTIBIOTIC");
    //	//		dtCopyTable.Columns.Add("MIC");
    //	//		dtCopyTable.Columns.Add("CULTYPE");
    //	//		dtCopyTable.Columns.Add("SENSITIVITY");
    //	//	}
    //	//}
    //	//#endregion

    //	////this method for reported result entry list from verification and print
    //	//public string GetVerifFrmRptReportedResultEntry(string strResultType, string strResultNo, string strStatus, string strGridData)
    //	//{
    //	//	LaboratoryClient labClient = new LaboratoryClient();
    //	//	JavaScriptSerializer ser = new JavaScriptSerializer();
    //	//	DataSet load = new DataSet();
    //	//	DataSet dsReport = new DataSet();
    //	//	DataTable dtCopyTable = new DataTable();
    //	//	DataTable dtProfile = new DataTable();
    //	//	List<string> list = new List<string>();
    //	//	string strTstRemarks = "";
    //	//	int testcount = 0;
    //	//	dtProfile = JsonConvert.DeserializeObject<DataTable>(strGridData);
    //	//	int i = 0;

    //	//	load.ReadXml(new XmlTextReader(new StringReader(labClient.GetResultEntryData(strResultType, strResultNo, GeneralFunction.GetLabTypeDesc(HttpContext.Current.Session["ModuleIDGlobal"].ToString())))));
    //	//	BindReportTable(ref dtCopyTable);

    //	//	if (load.Tables.Contains("Investigation Info"))
    //	//	{
    //	//		string strTestCode = "";
    //	//		foreach (DataRow Irow in load.Tables["Investigation Info"].AsEnumerable().OrderBy(x => x.Field<string>("TESTCODE")).ThenBy(x => Convert.ToInt32(x.Field<string>("SEQNO"))))
    //	//		{
    //	//			if (strTestCode != Irow["TESTCODE"].ToString().Trim())
    //	//			{

    //	//				DataRow copyrow1 = dtCopyTable.NewRow();//THIS ROW FOR PROFILE BINDING
    //	//				DataRow copyrow2 = dtCopyTable.NewRow();//THIS ROW FOR TESTNAME BINDING
    //	//				copyrow1["PROFILEID"] = Irow["PROFILEID"].ToString().Trim();
    //	//				copyrow1["TESTNAME"] = Irow["PROFTSTNM"].ToString() == "" ? "Normal Test" : Irow["PROFTSTNM"].ToString().Trim();
    //	//				copyrow1["RESULTYPE"] = "P";
    //	//				copyrow1["TESTCODE"] = Irow["TESTCODE"].ToString().Trim();
    //	//				dtCopyTable.Rows.Add(copyrow1);
    //	//				copyrow2["TESTCODE"] = Irow["TESTCODE"].ToString();
    //	//				copyrow2["TESTNAME"] = Irow["TESTNAME"].ToString();
    //	//				copyrow2["RESULTYPE"] = "T";
    //	//				dtCopyTable.Rows.Add(copyrow2);
    //	//				testcount = 0;
    //	//				strTestCode = Irow["TESTCODE"].ToString(); ;

    //	//			}

    //	//			if (testcount == 0)
    //	//			{
    //	//				if (Irow["TSTREMARK"].ToString().Trim() != "")
    //	//				{
    //	//					if (strTstRemarks != "")
    //	//					{
    //	//						strTstRemarks += Environment.NewLine;
    //	//						// string strline = "";
    //	//						strTstRemarks += Irow["TESTNAME"].ToString();
    //	//						strTstRemarks += Environment.NewLine;
    //	//						// strTstRemarks += strline.PadLeft(Irow["TESTNAME"].ToString().Length, '=');
    //	//						// strTstRemarks += Environment.NewLine;
    //	//					}
    //	//					else
    //	//					{
    //	//						//  string strline = "";
    //	//						strTstRemarks += Irow["TESTNAME"].ToString();
    //	//						strTstRemarks += Environment.NewLine;
    //	//						//strTstRemarks += strline.PadLeft(Irow["TESTNAME"].ToString().Length, '=');
    //	//						//strTstRemarks += Environment.NewLine;
    //	//					}

    //	//					strTstRemarks += Irow["TSTREMARK"].ToString();
    //	//					strTstRemarks += Environment.NewLine;
    //	//				}

    //	//				testcount += 1;
    //	//			}

    //	//			DataRow copyrow = dtCopyTable.NewRow();//THIS ROW FOR ALL INVESTIGATION
    //	//			copyrow["TESTCODE"] = Irow["TESTCODE"].ToString().Trim();
    //	//			copyrow["TESTNAME"] = Irow["INVESTDESC"].ToString().Trim();
    //	//			copyrow["RESULT"] = Irow["RESULTDT"].ToString().Trim();
    //	//			copyrow["UNITNAME"] = Irow["UNIT"].ToString().Trim();
    //	//			copyrow["DFTVAL"] = Irow["DFTVAL"].ToString().Trim();
    //	//			copyrow["FORMULA"] = Irow["FORMULASTR"].ToString().Trim();
    //	//			copyrow["RESULTYPE"] = Irow["RESULTTYPE"].ToString().Trim();
    //	//			copyrow["LOWERLIMIT"] = Irow["NORMALVAL1"].ToString().Trim();
    //	//			copyrow["UPPERLIMIT"] = Irow["NORMALVAL2"].ToString().Trim();
    //	//			copyrow["MINCONDITION"] = Irow["MINCOND"].ToString().Trim();
    //	//			copyrow["MAXCONDITION"] = Irow["MAXCOND"].ToString().Trim();
    //	//			copyrow["PANICYN"] = Irow["PANICYN"].ToString().Trim();
    //	//			copyrow["PANMINCOND"] = Irow["PANMINCOND"].ToString().Trim();
    //	//			copyrow["PANMINVAL"] = Irow["PANMINVAL"].ToString().Trim();
    //	//			copyrow["PANMAXCOND"] = Irow["PANMAXCOND"].ToString().Trim();
    //	//			copyrow["PANMAXVAL"] = Irow["PANMAXVAL"].ToString().Trim();
    //	//			copyrow["INFORMTO"] = Irow["INFORMTO"].ToString().Trim(); ;
    //	//			copyrow["INFORMDATE"] = Irow["INFORMDT"].ToString().Trim();
    //	//			copyrow["INFORMTIME"] = Irow["INFORMTM"].ToString().Trim(); ;
    //	//			copyrow["NOOFDIGIT"] = "";
    //	//			copyrow["INVESTCODE"] = Irow["INVESTCODE"].ToString();
    //	//			copyrow["UNITCODE"] = Irow["UNIT"].ToString();
    //	//			copyrow["MTHDNAME"] = Irow["MTHDNAME"].ToString();
    //	//			copyrow["PROFILEID"] = Irow["PROFILEID"].ToString();
    //	//			copyrow["PROFILEYN"] = Irow["PROFILEYN"].ToString();
    //	//			copyrow["SEQNO"] = Irow["SEQNO"].ToString();

    //	//			dtCopyTable.Rows.Add(copyrow);
    //	//		}
    //	//	}

    //	//	var jsonData = (from DataRow row in dtCopyTable.Rows
    //	//									select new
    //	//									{
    //	//										id = ++i,
    //	//										HIDE = "No",
    //	//										TESTCODE = row["TESTCODE"].ToString().Trim(),
    //	//										TESTDESC = row["TESTNAME"].ToString().Trim(),
    //	//										RESULT = row["RESULT"].ToString().Trim(),
    //	//										UNITNM = row["UNITNAME"].ToString().Trim(),
    //	//										DEFAULTVAL = row["DFTVAL"].ToString().Trim(),
    //	//										FORMULA = row["FORMULA"].ToString().Trim(),
    //	//										RESULTYPE = row["RESULTYPE"].ToString().Trim(),
    //	//										LOWERLIMIT = row["LOWERLIMIT"].ToString().Trim(),
    //	//										UPPERLIMIT = row["UPPERLIMIT"].ToString().Trim(),
    //	//										MINCONDITION = row["MINCONDITION"].ToString().Trim(),
    //	//										MAXCONDITION = row["MAXCONDITION"].ToString().Trim(),
    //	//										PANICYN = row["PANICYN"].ToString().Trim(),
    //	//										PANICMINCON = row["PANMINCOND"].ToString().Trim(),
    //	//										PANICMINVAL = row["PANMINVAL"].ToString().Trim(),
    //	//										PANICMAXCON = row["PANMAXCOND"].ToString().Trim(),
    //	//										PANICMAXVAL = row["PANMAXVAL"].ToString().Trim(),
    //	//										INFORMTO = "",
    //	//										INFORMDT = "",
    //	//										INFORMTM = "",
    //	//										NOOFDIGIT = row["NOOFDIGIT"].ToString().Trim(),
    //	//										INVESTCODE = row["INVESTCODE"].ToString().Trim(),
    //	//										UNIT = row["UNITCODE"].ToString().Trim(),
    //	//										MTHDNAME = row["MTHDNAME"].ToString().Trim(),
    //	//										PROFILEID = row["PROFILEID"].ToString().Trim(),
    //	//										PROFILEYN = row["PROFILEYN"].ToString().Trim(),
    //	//										ABNORMALYN = "N",
    //	//										SEQUENCE = row["SEQNO"].ToString().Trim()
    //	//									}).ToList();

    //	//	var PatData = (from DataRow row in load.Tables["Patient Info"].Rows
    //	//								 select new
    //	//								 {
    //	//									 id = ++i,
    //	//									 MRNO = row["MRNO"].ToString().Trim(),
    //	//									 IPNO = row["IPNO"].ToString().Trim(),
    //	//									 ORDERBY = row["ORDERBYDOCTNM"].ToString(),
    //	//									 BILLNO = row["BILLNO"].ToString().Trim(),
    //	//									 PATNAME = row["PATNAME"].ToString(),
    //	//									 REPORTEDTO = row["REPORTDCNM"].ToString(),
    //	//									 NURSESTN = row["NURSTNM"].ToString(),
    //	//									 AGEGENDER = row["AGE"].ToString() + "\\" + GeneralFunction.GetPatGender(row["SEX"].ToString()),
    //	//									 BEDNO = row["BEDNUMBER"].ToString(),
    //	//									 WARDNM = row["WARDNM"].ToString(),
    //	//									 COMMENTDT = row["COMMENTDT"].ToString(),
    //	//									 REMARKS = row["Remarks"].ToString(),
    //	//									 ReDoRemark = row["REDOREMARK"].ToString(),
    //	//									 REPORTTYPE = row["REPORTTYPE"].ToString(),
    //	//									 SPECCODE = row["SPECCODE"].ToString()
    //	//								 }).ToList();
    //	//	Dictionary<string, object> FinalData = new Dictionary<string, object>();
    //	//	string StrMicro = "";
    //	//	List<object> MicroBioData = new List<object>();
    //	//	if (strResultType == "03")
    //	//	{
    //	//		i = 0;
    //	//		if (load.Tables.Contains("Microbiology Info"))
    //	//		{
    //	//			foreach (DataRow row in load.Tables["Microbiology Info"].Rows)
    //	//			{
    //	//				if (row["CULTYPE"].ToString() == "O")
    //	//				{
    //	//					StrMicro = row["CULSENCODE"].ToString();
    //	//				}
    //	//				MicroBioData.Add(new
    //	//				{
    //	//					id = ++i,
    //	//					ANTIBIOTIC = row["CULSENDESC"].ToString(),
    //	//					ANTIBIOID = row["ANTIBIOCD"].ToString(),
    //	//					CULSENCODE = row["CULSENCODE"].ToString(),
    //	//					SENSITIVITY = row["SENSITIVE"].ToString(),
    //	//					MIC = row["MICVALUE"].ToString(),
    //	//					MIRCROORGCD = StrMicro,
    //	//					ORGGRPCD = row["ORGGRPCD"].ToString(),
    //	//					CULTYPE = row["CULTYPE"].ToString()
    //	//				});
    //	//			}
    //	//		}

    //	//		FinalData.Add("MicroInfo", MicroBioData);
    //	//	}
    //	//	FinalData.Add("PatientInfo", PatData);
    //	//	FinalData.Add("ReportRegular", jsonData);
    //	//	FinalData.Add("TestRemark", new List<object>() { new { TESTREMARKS = strTstRemarks } });
    //	//	ser.MaxJsonLength = int.MaxValue;
    //	//	return ser.Serialize(FinalData);

    //	//}

    //	//public void BindReportTable(ref DataTable dtCopyTable)
    //	//{
    //	//	dtCopyTable.Columns.Add("TESTCODE");
    //	//	dtCopyTable.Columns.Add("TESTNAME");
    //	//	dtCopyTable.Columns.Add("RESULT");
    //	//	dtCopyTable.Columns.Add("UNITNAME");
    //	//	dtCopyTable.Columns.Add("DFTVAL");
    //	//	dtCopyTable.Columns.Add("LOWERLIMIT");
    //	//	dtCopyTable.Columns.Add("UPPERLIMIT");
    //	//	dtCopyTable.Columns.Add("FORMULA");
    //	//	dtCopyTable.Columns.Add("RESULTYPE");
    //	//	dtCopyTable.Columns.Add("MINCONDITION");
    //	//	dtCopyTable.Columns.Add("MAXCONDITION");
    //	//	dtCopyTable.Columns.Add("PANICYN");
    //	//	dtCopyTable.Columns.Add("PANMINCOND");
    //	//	dtCopyTable.Columns.Add("PANMINVAL");
    //	//	dtCopyTable.Columns.Add("PANMAXCOND");
    //	//	dtCopyTable.Columns.Add("PANMAXVAL");
    //	//	dtCopyTable.Columns.Add("INFORMTO");
    //	//	dtCopyTable.Columns.Add("INFORMDATE");
    //	//	dtCopyTable.Columns.Add("INFORMTIME");
    //	//	dtCopyTable.Columns.Add("NOOFDIGIT");
    //	//	dtCopyTable.Columns.Add("INVESTCODE");
    //	//	dtCopyTable.Columns.Add("UNITCODE");
    //	//	dtCopyTable.Columns.Add("MTHDNAME");
    //	//	dtCopyTable.Columns.Add("PROFILEID");
    //	//	dtCopyTable.Columns.Add("PROFILEYN");
    //	//	dtCopyTable.Columns.Add("ABNORMALYN");
    //	//	dtCopyTable.Columns.Add("SEQNO");
    //	//}
    //	#endregion
    //}
}