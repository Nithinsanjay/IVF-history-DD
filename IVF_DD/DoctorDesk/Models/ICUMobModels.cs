using Newtonsoft.Json;
using OncologyEMR.CommonSerRef;
using OncologyEMR.Oncology;
using OncologyEMR.DataClass;
using OncologyEMR.ICUServRef;
using OncologyEMR.NSServRef;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Xml;
using NReco.PdfGenerator;
//using OncologyEMR.Oncology;	
using OncologyEMR.Pdf;
using System.Reflection;
using System.Globalization;

namespace OncologyEMR.Models
{
    public class ICUMobModels
    {
        public string strDate { get; set; }

        public object[] GetNursStationsNPAtients(string srtUserID)
        {
            object[] data = new object[2];
            try
            {
                CommonServiceClient com = new CommonServiceClient();
                NursingStationClient nurCli = new NursingStationClient();

                DataSet DataSetPatLst = new DataSet();
                //List<SelectLstItem> nursingStationLst=new List<SelectLstItem>();
                string admittingDoct = ("" + System.Web.HttpContext.Current.Session["gDoctCode"]).ToString().Trim();
                string icuAuthorizationYn = ("" + System.Web.HttpContext.Current.Session["ICUAUTHYN"]).ToString().Trim();

                if (icuAuthorizationYn == "Y")
                    DataSetPatLst = com.GetIPPatInfo("", "", "", "", "", "", "", "", "", "A", "", "", "", "", "", "");
                else
                    DataSetPatLst = com.GetIPPatInfo("", "", "", "", "", "", "", "", "", "A", "", "", "", admittingDoct, "", "");

                if (DataSetPatLst.Tables.Count > 0)
                {
                    // DataRow[] row1 = DataSetPatLst.Tables[0].Select("ADMNDOCT='" + admittingDoct + "'");

                    DataTable tblFiltered = new DataTable();
                    //if (row1.Length > 0)
                    tblFiltered = DataSetPatLst.Tables[0].Copy();

                    DataTable dt = new DataTable();
                    if (tblFiltered.Rows.Count > 0)
                    {
                        dt = tblFiltered.AsEnumerable()
                                   .GroupBy(r => new { NURSCODE = r["NURSCODE"] })
                                   .Select(g => g.OrderBy(r => r["NURSCODE"]).First())
                                   .CopyToDataTable();
                    }

                    if (dt.Rows.Count > 0)
                    {
                        var nursingStnLst = (from DataRow r in dt.AsEnumerable()
                                             select new
                                             {
                                                 Value = r["NURSCODE"].ToString(),
                                                 Text = r["NURSTNM"].ToString().Replace("NURSING STATION", "NS")
                                             }).ToArray();

                        data[0] = nursingStnLst;
                    }
                    else
                        data[0] = "";

                    if (tblFiltered.Rows.Count > 0)
                    {
                        var patLst = (from DataRow row in tblFiltered.AsEnumerable()
                                      select new
                                      {
                                          NurstCode = row["NURSCODE"].ToString(),
                                          PatName = row["PATNAME"].ToString(),
                                          PatFName = row["PATFNAME"].ToString(),
                                          PatLName = row["PATLNAME"].ToString(),
                                          IPNO = row["IPNO"].ToString(),
                                          MRNO = row["MRNO"].ToString(),
                                          BedNo = row["CURRBEDNO"].ToString(),
                                          PatGender = row["GENDER"].ToString(),
                                          AdmnDt = GeneralFunction.GetUIDateFormat(row["ADMNDATE"].ToString(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
                                          PatAge = row["PatAge"].ToString(),
                                          Salutation = row["SALUNAME"].ToString(),// added by vijeta on 30th may 2018
                                      }).ToArray();

                        data[1] = patLst;
                    }
                    else

                        data[1] = "";
                }
                return data;
            }
            catch (Exception ex)
            {
                data[0] = "Error";
                data[1] = ex.Message;
                return data;
            }
        }

        private static string GetAdmissionDate(DataRow row)
        {
            string str = row["ADMNDTTM"].ToString().Trim() != "" ? (row["ADMNDTTM"].ToString().Trim()).Substring(0, 8) : "";
            var date = "";

            if (str.Length > 0)
                date = GeneralFunction.GetUIDateFormat(str, GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);

            return date;
        }

        public object GetMaxTempList(string strIPNO)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            ICUClient icuClient = new ICUClient();

            DataSet load = new DataSet();

            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetMaxTempList(strIPNO))));

            if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            {
                return "No Data Found";
            }
            else
            {
                var data = (from DataRow row in load.Tables[0].Rows
                            select new
                            {
                                Date = row["TRANDATE"].ToString(),
                                MaxTemp = row["MAXPTEMP"].ToString(),
                                NoOfTimes = row["NOOFMAXTEMP"].ToString()
                            }).ToArray();
                return data;
            }
        }

        public object GetInvestData(string strIPNo, string strFromDate, string strToDate, string strNsNm)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            ICUClient icuClient = new ICUClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();

            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string str = icuClient.GetInvestChart(strIPNo, strFromDate, strToDate);

            load.ReadXml(new XmlTextReader(new StringReader(str)));

            if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            {
                return "No Data Found";
            }
            else
            {
                var data = (from DataRow row in load.Tables[0].Rows
                            select new
                            {
                                TestName = row["TESTNAME"].ToString(),
                                INVESTDESC = row["INVESTDESC"].ToString(),
                                RESUTL = row["RESUTL"].ToString(),
                                NORMRANGE = row["NORMRANGE"].ToString(),
                                RESULTTYPE = row["RESULTTYPE"].ToString(),
                                RESULTDATE = row["RESULTDATE"].ToString()
                            }).ToArray();
                return data;
            }
        }

        public object GetInvestResult(string strIPNo, string strFromDate, string strToDate, string strNsNm)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            ICUClient icuClient = new ICUClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string str = icuClient.GetInvestResult(strIPNo, strFromDate, strToDate, "A");
            load.ReadXml(new XmlTextReader(new StringReader(str)));

            if (load.Tables.Contains("investigateLst"))
            {
                load.Tables[0].Columns.Add("DATETIME", System.Type.GetType("System.DateTime"));
                load.Tables[0].Columns.Add("DateTimeString");
                //load.Tables[0].Columns.Add("DATETIME");
                IFormatProvider culture = new System.Globalization.CultureInfo("fr-FR", true);
                for (int i = 0; i < load.Tables[0].Rows.Count; i++)
                {
                    string s = GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()) + " " + load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim();
                    //DateTime dtdatev = Convert.ToDateTime(GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()) + " "+ load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim());

                    if (s.Trim() != "")
                    {
                        DateTime dtdatev = DateTime.Parse(s, culture, System.Globalization.DateTimeStyles.AssumeLocal);
                        load.Tables[0].Rows[i]["TESTNAME"] = load.Tables[0].Rows[i]["TESTNAME"].ToString().Replace("'", "");
                        load.Tables[0].Rows[i]["INVESTDESC"] = load.Tables[0].Rows[i]["INVESTDESC"].ToString().Replace("'", "");
                        //load.Tables[0].Rows[i]["DATETIME"] = ConvertStrToDateTimeValue(load.Tables[0].Rows[i]);
                        load.Tables[0].Rows[i]["DATETIME"] = dtdatev;
                        //load.Tables[0].Rows[i]["DATETIME"] = string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim()) != "" ? Convert.ToDateTime(string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim())) : DateTime.Now;
                        //load.Tables[0].Rows[i]["DateTimeString"] = GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()) + "" + load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim();
                        load.Tables[0].Rows[i]["DateTimeString"] = string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim().Substring(0, 5));
                    }
                }


                DataView viewDate = new DataView(load.Tables[0]);
                viewDate.Sort = "DATETIME  ASC";

                DataTable distinctValues = viewDate.ToTable(true, "DateTimeString");
                DataTable ViewDistInvestValues = viewDate.ToTable(true, "TESTNAME", "INVESTDESC");

                load.Tables[1].Columns.Add("NORMRANGE");

                for (int i = 0; i < distinctValues.Rows.Count; i++)
                {
                    load.Tables[1].Columns.Add(distinctValues.Rows[i]["DateTimeString"].ToString());
                }


                for (int n = 0; n < load.Tables[1].Rows.Count; n++)
                {
                    DataRow[] dmrow = load.Tables[0].Select("INVESTDESC='" + load.Tables[1].Rows[n]["INVESTDESC"].ToString().Trim().Replace("'", "") + "'AND TESTNAME='" + load.Tables[1].Rows[n]["TESTNAME"].ToString().Trim().Replace("'", "") + "'");
                    for (int p = 0; p < dmrow.Length; p++)
                    {
                        if (dmrow[p][13].ToString() == "")
                            continue;

                        load.Tables[1].Rows[n][dmrow[p][13].ToString()] = GetResultWithAbNorm(dmrow[p][4].ToString(), dmrow[p][7].ToString(), dmrow[p][8].ToString(), dmrow[p][6].ToString(), dmrow[p][9].ToString(), dmrow[p]["STATUS"].ToString(), p);
                    }
                    load.Tables[1].Rows[n]["NORMRANGE"] = dmrow[0][5].ToString();
                    load.Tables[1].Rows[n]["TESTNAME"] = dmrow[0][0].ToString().ToString();
                    load.Tables[1].Rows[n]["INVESTDESC"] = dmrow[0][1].ToString().ToString();

                }

                DataTable TblInvestiDate = new DataTable();
                TblInvestiDate.Columns.Add("DATETIME");
                for (int n = 0; n < distinctValues.Rows.Count; n++)
                {
                    TblInvestiDate.Rows.Add();
                    TblInvestiDate.Rows[n]["DATETIME"] = distinctValues.Rows[n]["DateTimeString"].ToString();
                }

                load.Tables[1].TableName = "Investigate";
                TblInvestiDate.TableName = "TblDate";
                load.Tables.Remove("investigateLst");
                //load.Tables.Remove("Table1");
                load.Tables.Add(TblInvestiDate);
                string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                return jsonData;

            }
            else
            {
                return "No Data Found";
            }
        }

        string GetResultWithAbNorm(string strResult, string strNormVal1, string strNormval2, string strResultType, string strDefVal, string Status, int p)
        {
            string result = "";

            if (strResultType == "V" || strResultType == "O")
            {
                if (strNormval2 != "" && strNormval2 != "")
                {
                    double iValue = 0;
                    bool testResult = double.TryParse(strResult, out iValue);
                    if (testResult == true)
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
            return result + "<input type=hidden id=" + Status + "_" + p.ToString() + " />";
        }

        public object GetRespiAssesPrint(string strIPNo, string strFromDate, string strNsNm)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            ICUClient icuClient = new ICUClient();
            DataSet dsRespiratoryAss = new DataSet();
            //DataTable dt = new DataTable();
            DataSet ds = new DataSet();

            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            string str = icuClient.GetRespiAssesPrint(strIPNo, strFromDate);

            dsRespiratoryAss.ReadXml(new XmlTextReader(new StringReader(str)));

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
                            return "No Data Found";
                        }
                        else
                        {
                            ds.Tables.Add(dt);
                            var data = JsonConvert.SerializeObject(ds.Tables["RESPR"]);
                            return data;
                        }

                    }


                }


            }
            return "No Data Found";

            ////DataRow[] dr = load.Tables["RESPIRATORY"].Select("[DESC]='GCS SCALE' OR [DESC]='ABG READING' OR [10 AM]<>''OR [11 AM]<>''OR [12 PM]<>''OR [1 PM]<>''OR [2 PM]<>''OR [3 PM]<>''OR [4 PM]<>''OR [5 PM]<>''OR [6 PM]<>''OR [7 PM]<>''OR [8 PM]<>''OR [9 PM]<>''OR [10 PM]<>''OR [11 PM]<>''OR [12 AM]<>''OR [1 AM]<>''OR [2 AM]<>''OR [3 AM]<>''OR [4 AM]<>''OR [5 AM]<>''OR [6 AM]<>''");

            ////if (dr.Count() > 0)
            ////{
            ////    DataTable dtt = load.Tables["RESPIRATORY"].Select("[DESC]='GCS SCALE' OR [DESC]='ABG READING' OR[10 AM]<>''OR [11 AM]<>''OR [12 PM]<>''OR [1 PM]<>''OR [2 PM]<>''OR [3 PM]<>''OR [4 PM]<>''OR [5 PM]<>''OR [6 PM]<>''OR [7 PM]<>''OR [8 PM]<>''OR [9 PM]<>''OR [10 PM]<>''OR [11 PM]<>''OR [12 AM]<>''OR [1 AM]<>''OR [2 AM]<>''OR [3 AM]<>''OR [4 AM]<>''OR [5 AM]<>''OR [6 AM]<>''").CopyToDataTable();
            ////    dtt.TableName = "RESPIRATORYY";

            ////    if (dtt != null)
            ////        if (dtt.Rows.Count == 2)
            ////        {
            ////            return "No Data Found";
            ////        }
            ////        else
            ////        {
            ////            load1.Tables.Add(dtt);
            ////        }
            ////}

            ////if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            ////{
            ////    return "No Data Found";
            ////}
            ////else
            ////{
            ////    var data = (from DataRow row in load1.Tables[0].Rows
            ////                select new
            ////                {
            ////                    DESC = row["DESC"].ToString(),
            ////                    SAM = row["7 AM"].ToString(),
            ////                    EAM = row["8 AM"].ToString(),
            ////                    NAM = row["9 AM"].ToString(),
            ////                    T0AM = row["10 AM"].ToString(),
            ////                    EEAM = row["11 AM"].ToString(),
            ////                    TTPM = row["12 PM"].ToString(),
            ////                    OPM = row["1 PM"].ToString(),
            ////                    TWPM = row["2 PM"].ToString(),
            ////                    THPM = row["3 PM"].ToString(),
            ////                    FOPM = row["4 PM"].ToString(),
            ////                    FIPM = row["5 PM"].ToString(),
            ////                    SIPM = row["6 PM"].ToString(),
            ////                    SPM = row["7 PM"].ToString(),
            ////                    EPM = row["8 PM"].ToString(),
            ////                    NPM = row["9 PM"].ToString(),
            ////                    TPM = row["10 PM"].ToString(),
            ////                    EEPM = row["11 PM"].ToString(),
            ////                    TAM = row["12 AM"].ToString(),
            ////                    OAM = row["1 AM"].ToString(),
            ////                    TWAM = row["2 AM"].ToString(),
            ////                    THAM = row["3 AM"].ToString(),
            ////                    FOAM = row["4 AM"].ToString(),
            ////                    FIAM = row["5 AM"].ToString(),
            ////                    SIAM = row["6 AM"].ToString(),

            ////                }).ToArray();
            //    return data;
            //}
        }


        public object GetDiabeticData(string strIPNo, string strFromDate, string strToDate, string strNsNm)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            ICUClient icuClient = new ICUClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();

            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetDiabeticChartData(strIPNo, strFromDate, strToDate))));

            if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            {
                return "No Data Found";
            }
            else
            {
                var data = (from DataRow row in load.Tables[0].Rows
                            select new
                            {
                                Date_Time = "" + GeneralFunction.GetUIDateFormat(row["CA1DATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY) + " " + row["CA1TIME"].ToString(),
                                HGT = row["HGT"].ToString(),
                                US = row["US"].ToString(),
                                UK = row["UK"].ToString(),
                                HGTMEDADMN = row["HGTMEDADMN"].ToString(),
                                USERNAME = row["USERNAME"].ToString()
                            }).ToArray();
                return data;
            }

        }

        // 26-11-19 start
        public object getTreatmentSheetdata(string TransacNo, string IsrollOver, string IPNo, string tsTime, string tstDate, string NurseCode)
        {
            Dictionary<string, object> dict = new Dictionary<string, object>();
            try
            {
                JavaScriptSerializer ser = new JavaScriptSerializer();
                DataSet load = new DataSet();
                TreatmentSheet objTreatSheet = new TreatmentSheet();
                ICUClient icuclnt = new ICUClient();
                //if (IsrollOver != "Y")
                //{
                //    tsTime = "";
                //    tstDate = "";
                //}

                //else
                //{
                if (tstDate != string.Empty)
                {
                    tstDate = GeneralFunction.GetDateInSpecifiedFormat(tstDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                //}

                CommonServiceClient comser = new CommonServiceClient();
                DataSet ds = GetCaseDetails(IPNo);
                load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetTreatmentSheetData(TransacNo, IsrollOver, IPNo, tsTime, tstDate))));

                if (load.Tables.Count > 0)
                {
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
                    DataTable dt12 = new DataTable();

                    object jsonDetailsData = "";
                    object jsonMedicineData = "";
                    object jsonNubellizationdata = "";
                    object jsonSpecilInstData = "";
                    object jsonStatOrderData = "";
                    object jsonInfusionData = "";
                    object jsonTestData = "";
                    object jsonDoctorData = "";
                    object JsonCaseDetailData = "";
                    object JsonAllergisData = "";
                    object jsonAntibioticData = "";
                    object jsonStatOrderMediData = "";
                    object jsonBloodProductData = "";

                    if (ds.Tables.Contains("TblDiagnosis"))
                    {
                        dt8 = ds.Tables["TblDiagnosis"];
                        if (dt8.Rows.Count > 0)
                        {
                            JsonCaseDetailData = (from DataRow row in dt8.AsEnumerable()
                                                  select new
                                                  {
                                                      PROVDIAGNO = row["DIAGNOSIS"].ToString().Trim(),
                                                  }).ToArray();
                        }
                    }
                    if (ds.Tables.Contains("TblAllergies"))
                    {
                        dt9 = ds.Tables["TblAllergies"];
                        if (dt9.Rows.Count > 0)
                        {
                            JsonAllergisData = (from DataRow row in dt9.AsEnumerable()
                                                select new
                                                {
                                                    ALLERGYDESC = row["ALLERGYDESC"].ToString().Trim(),
                                                }).ToArray();
                        }
                    }

                    if (load.Tables.Count > 0)//nondrug
                    {
                        if (load.Tables.Contains("TREATMNTHEAD"))
                        {
                            dt = load.Tables["TREATMNTHEAD"];
                            jsonDetailsData = (from DataRow row in dt.AsEnumerable()
                                               select new
                                               {

                                                   TRANNO = row["TRANNO"].ToString().Trim(),
                                                   TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                                   TRANTIME = row["TRANTIME"].ToString().Trim(),
                                                   PROVDIAGNO = row["PROVDIAGNO"].ToString().Trim(),
                                                   ALLERGIES = row["ALLERGIES"].ToString().Trim(),
                                                   REMARK = row["REMARK"].ToString().Trim(),
                                                   VITALSIGNS = row["VITALSIGNS"].ToString().Trim(),
                                                   HGT = row["HGT"].ToString().Trim(),
                                                   OXYGENADMIN = row["OXYGENADMIN"].ToString().Trim(),
                                                   DEEPBREATH = row["DEEPBREATH"].ToString().Trim(),
                                                   SPIROMETRY = row["SPIROMETRY"].ToString().Trim(),
                                                   CHESTPT = row["CHESTPT"].ToString().Trim(),
                                                   STEAMINHAL = row["STEAMINHAL"].ToString().Trim(),
                                                   DVTPROPHY = row["DVTPROPHY"].ToString().Trim(),
                                                   CHANGEPOSI = row["CHANGEPOSI"].ToString().Trim(),
                                                   MOBILI = row["MOBILI"].ToString().Trim(),
                                                   ABDOMINAL = row["ABDOMINAL"].ToString().Trim(),
                                                   RTASPIRATION = row["RTASPIRATION"].ToString().Trim(),
                                                   OTHER = row["OTHER"].ToString().Trim(),
                                                   DOCREMARK = row["DOCREMARK"].ToString().Trim(),
                                                   INTMNURT = row["INTMNURT"].ToString().Trim(),
                                                   CHEMOMED = row["CHEMOMED"].ToString().Trim(),
                                                   STATUS = row["STATUS"].ToString().Trim(),
                                                   VOLSUPL = row["VOLSUPL"].ToString().Trim(),
                                               }).ToArray();
                            //return jsonData1;
                        }

                        //if (load.Tables.Contains("TREATMNTDETAIL"))
                        //{
                        //    bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "AB");
                        //    if (result)
                        //    {
                        //        dt1 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "AB").CopyToDataTable(); 
                        //        jsonMedicineData = GetColumnByType(dt1);
                        //    }
                        //}

                        if (load.Tables.Contains("TREATMNTDETAIL"))
                        {
                            bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "DL");
                            if (result)
                            {
                                dt2 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "DL").CopyToDataTable();
                                jsonNubellizationdata = GetColumnByType(dt2);
                            }
                        }

                        if (load.Tables.Contains("TREATMNTDETAIL"))
                        {
                            bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "IV");
                            if (result)
                            {
                                dt3 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "IV").CopyToDataTable();
                                jsonSpecilInstData = GetColumnByTypenewone(dt3);
                            }
                        }

                        if (load.Tables.Contains("TREATMNTDETAIL"))
                        {
                            bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("MEDSTAT") == "S");//TBLTYPE SO replacd 
                            if (result)
                            {
                                dt4 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("MEDSTAT") == "S").CopyToDataTable();

                                //........................

                                //DataSet dsnew = RetriveTSPlandData(IPNo, tstDate, "P", "N", NurseCode);
                                //DataTable plantab = new DataTable();
                                //if (dsnew.Tables.Contains("TRETMEDICINE"))
                                //{
                                //    plantab = dsnew.Tables["TRETMEDICINE"];


                                //}
                                //var flag1 = 0;
                                //if (result)
                                //{
                                //    dt4 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("MEDSTAT") == "M").CopyToDataTable();
                                //    //   jsonMedicineData = GetColumnByType(dt1);
                                //}

                                // dt4.Columns.Add("PLOMIT", typeof(String));
                                dt4.Columns.Add("PL", typeof(String));




                                //.............


                                jsonStatOrderData = GetColumnByType(dt4);
                            }
                        }


                        if (load.Tables.Contains("TREATMNTDETAIL"))
                        {
                            bool result1 = false, resultplan = false;
                            if (load.Tables.Contains("TREATMNTDETAIL"))
                            {

                                result1 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("MEDSTAT") == "M");//TBLTYPE AB replacd 

                            }
                            DataSet ds1 = RetriveTSPlandData(IPNo, tstDate, "P", "N", NurseCode);
                            if (ds1.Tables.Contains("TRETMEDICINE"))
                            {

                                resultplan = ds1.Tables["TRETMEDICINE"].AsEnumerable().Any(r => r.Field<string>("CODE") != "");
                            }

                            DataTable plantab = new DataTable();
                            if (resultplan)
                            {
                                plantab = ds1.Tables["TRETMEDICINE"];


                            }
                            var flag1 = 0;
                            if (result1)
                            {
                                dt1 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("MEDSTAT") == "M").CopyToDataTable();
                                dt1.Columns.Add("PL", typeof(String));

                            }

                            // dt1.Columns.Add("PLOMIT", typeof(String));


                            if (resultplan && result1)
                            {

                                foreach (DataRow drplan in plantab.Rows)
                                {
                                    //DataTable NewTab = plantab.AsEnumerable().Where(r => r.Field<string>("CODE") == dr["CODE"]).CopyToDataTable();
                                    flag1 = 0;
                                    string omit = "N";
                                    foreach (DataRow dr in dt1.Rows)
                                    {
                                        omit = "N";
                                        if (dr["CODE"].ToString().Trim() == drplan["CODE"].ToString().Trim() || dr["DRUGNAME"].ToString().Trim() == drplan["DRUGNAME"].ToString().Trim())
                                        {//OR condition need to chnge later all bcz al medcn check by code only

                                            //if( dr["OMIT"].ToString().Trim() == "Y"){
                                            //    dr["PLOMIT"] = "Y";
                                            //}
                                            //else
                                            //{
                                            omit = dr["OMIT"].ToString().Trim();
                                            dr["PL"] = "Y";
                                            //}
                                            flag1 = 1;
                                            break;

                                        }
                                    }
                                    if (flag1 == 0)
                                    {
                                        DataRow Dr = dt1.NewRow();
                                        Dr["CODE"] = drplan["CODE"];
                                        Dr["DRUGNAME"] = drplan["DRUGNAME"];
                                        Dr["FREQ"] = drplan["FREQ"];
                                        Dr["DAYOFDRUG"] = drplan["DAYOFDRUG"];
                                        Dr["OMIT"] = omit;
                                        Dr["DOSE"] = drplan["DOSE"];
                                        // Dr["DILUENT"] = dr1["DILUENT"];
                                        Dr["STARTFRMDT"] = drplan["TRANDATE"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(drplan["TRANDATE"].ToString().Trim()) : string.Empty;

                                        Dr["ROUTE"] = drplan["ROUTE"];
                                        Dr["REMARK"] = drplan["REMARK"];
                                        Dr["TYPE"] = drplan["TYPE"];
                                        Dr["DILVOLUME"] = drplan["DILVOLUME"];
                                        Dr["ADMINDUR"] = drplan["ADMINDUR"];
                                        Dr["SEQNO"] = drplan["SEQNO"];
                                        Dr["TYPE"] = drplan["TYPE"];
                                        Dr["ADMINYN"] = "N";//doubt
                                        Dr["STATUS"] = drplan["STATUS"];
                                        Dr["ALERTYN"] = drplan["ALERTYN"];
                                        // Dr["PLOMIT"] = "N";
                                        Dr["PL"] = "Y";

                                        dt1.Rows.Add(Dr);

                                    }


                                }
                            }
                            if (!result1 && resultplan)
                            {
                                plantab.Columns.Add("PL", typeof(String));
                                plantab.Columns.Add("OMIT", typeof(String));
                                plantab.Columns.Add("ORDERBY", typeof(String));


                                plantab.Columns.Add("ORDTIME", typeof(String));
                                plantab.Columns.Add("ORDDATE", typeof(String));
                                plantab.Columns.Add("OMITBY", typeof(String));
                                plantab.Columns.Add("OMITDT", typeof(String));
                                plantab.Columns.Add("OMITTM", typeof(String));
                                plantab.Columns.Add("STARTFRMDT", typeof(String));
                                plantab.Columns.Add("INFRATE", typeof(String));
                                plantab.Columns.Add("MACROSET", typeof(String));
                                plantab.Columns.Add("MICROSET", typeof(String));
                                plantab.Columns.Add("ADMINYN", typeof(String));
                                plantab.Columns.Add("NOTIFYN", typeof(String));
                                plantab.Columns.Add("DURATION", typeof(String));
                                plantab.Columns.Add("DILUENT", typeof(String));
                                foreach (DataRow dr1 in plantab.Rows)
                                {
                                    dr1["PL"] = "Y";

                                }

                                jsonMedicineData = GetColumnByType(plantab);
                            }
                            else if (result1)
                                jsonMedicineData = GetColumnByType(dt1);




                            //bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "MD");
                            //if (result)
                            //{
                            //    dt10 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "MD").CopyToDataTable();// MD and AB chnged
                            //   // jsonAntibioticData = GetColumnByType(dt10);
                            //}

                            //if (result1 || result)
                            //{
                            //    dt1.Merge(dt10);
                            //    jsonMedicineData = GetColumnByType(dt1);

                            //}
                        }

                        //if (load.Tables.Contains("TREATMNTDETAIL"))
                        //{
                        //    bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "SM");
                        //    bool result1 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "SO");
                        //    if (result1)
                        //    {
                        //        dt4 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "SO").CopyToDataTable();
                        //       // jsonStatOrderData = GetColumnByType(dt4);
                        //    }
                        //    if (result)
                        //    {
                        //        dt11 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "SM").CopyToDataTable();

                        //       // jsonStatOrderMediData = GetColumnByType(dt11);
                        //    }


                        //    if (result1 || result)
                        //    {
                        //        dt11.Merge(dt4);





                        //        jsonStatOrderData = GetColumnByType(dt11);

                        //    }
                        //}

                        if (load.Tables.Contains("TREATMNTDETAIL"))//bloodprodct
                        {
                            bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "BP");
                            if (result)
                            {
                                dt12 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "BP").CopyToDataTable();
                                jsonBloodProductData = GetColumnByTypenewone(dt12);
                            }
                        }

                        if (load.Tables.Contains("TREATINFUSION"))
                        {
                            dt5 = load.Tables["TREATINFUSION"];
                            if (dt5.Rows.Count > 0)
                            {
                                jsonInfusionData = (from DataRow row in dt5.AsEnumerable()
                                                    select new
                                                    {
                                                        action = "",
                                                        Infusion = row["INFUSION"].ToString().Trim(),
                                                        InfusionRate = row["RATE"].ToString().Trim(),
                                                        StartTime = row["STARTTIME"].ToString().Trim(),
                                                        EndTime = row["ENDTIME"].ToString().Trim(),
                                                        TypeCode = "IN",
                                                        ORDERBY = row["ORDERBY"].ToString().Trim(),
                                                        ORDDATE = row["ORDERDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["ORDERDT"].ToString().Trim()) : string.Empty,
                                                        ORDTIME = row["ORDERTM"].ToString().Trim(),
                                                        SEQNO = row["SEQNO"].ToString().Trim(),
                                                        HighAlert = row["ALERTYN"].ToString().Trim(),
                                                        Omit = row["OMIT"].ToString().Trim(),
                                                        OMITBY = row["OMITBY"].ToString().Trim(),
                                                        OMITDT = row["OMITDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["OMITDT"].ToString().Trim()) : string.Empty,
                                                        OMITTM = row["OMITTM"].ToString().Trim(),
                                                        Remark = row["REMARK"].ToString().Trim(),
                                                        Dose = row["DOSE"].ToString().Trim(),
                                                        NOTIFYN = row["NOTIFYN"].ToString().Trim(),
                                                        STATUS = row["STATUS"].ToString().Trim(),
                                                        ADMINYN = row["ADMINYN"].ToString().Trim(),
                                                    }).ToArray();
                            }
                        }

                        if (load.Tables.Contains("TEST"))//investigatn
                        {
                            dt6 = load.Tables["TEST"];
                            if (dt6.Rows.Count > 0)
                            {
                                jsonTestData = (from DataRow row in dt6.AsEnumerable()
                                                select new
                                                {
                                                    action = "",
                                                    Test = row["TESTNAME"].ToString().Trim(),
                                                    OrderDate = row["ORDERDATE"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["ORDERDATE"].ToString().Trim()) : string.Empty,
                                                    OrderTime = row["ORDERTIME"].ToString().Trim(),
                                                    TestCode = row["TESTCODE"].ToString().Trim(),
                                                    TypeCode = "IG",                             ///VISHAL 6TH FEB 2019
                                                    ORDERBY = row["ORDERBY"].ToString().Trim(),
                                                    SEQNO = row["SEQNO"].ToString().Trim(),
                                                    REMARKS = row["REMARKS"].ToString().Trim(),
                                                    CancelBY = row["CANCELBY"].ToString().Trim(),
                                                    CancelDT = row["CANCELDT"].ToString().Trim(),
                                                    CancelTM = row["CANCELTM"].ToString().Trim(),
                                                    STATUS = row["STATUS"].ToString().Trim(),
                                                }).ToArray();
                            }
                        }

                        if (load.Tables.Contains("DOCTOR"))
                        {
                            dt7 = load.Tables["DOCTOR"];
                            if (dt7.Rows.Count > 0)
                            {
                                jsonDoctorData = (from DataRow row in dt7.AsEnumerable()
                                                  select new
                                                  {
                                                      action = "",
                                                      Doctor = row["DOCTNAME"].ToString().Trim(),
                                                      ReferralType = row["REFERRALTYPE"].ToString().Trim(),
                                                      DoctorCode = row["DOCTCODE"].ToString().Trim(),
                                                      ReferralTypeCode = "",
                                                      TypeCode = "DC",                            ///VISHAL 6TH FEB 2019
                                                      SEQNO = row["SEQNO"].ToString().Trim(),
                                                      SpecilizationName = row["DOSPNAME"].ToString().Trim(),
                                                      STATUS = row["STATUS"].ToString().Trim(),
                                                      CancelBY = row["CANCELBY"].ToString().Trim(),
                                                      CancelDT = row["CANCELDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetUIDateFormat(row["CANCELDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY) : string.Empty,
                                                      CancelTM = row["CANCELTM"].ToString().Trim(),
                                                      SUGESTBY = row["SUGESTBY"].ToString().Trim(),
                                                      REASON = row["REASON"].ToString().Trim(),
                                                      CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                                  }).ToArray();
                            }
                        }
                    }


                    dict.Add("jsonDetailsData", jsonDetailsData);
                    dict.Add("jsonMedicineData", jsonMedicineData);
                    dict.Add("jsonNubellizationdata", jsonNubellizationdata);
                    dict.Add("jsonSpecilInstData", jsonSpecilInstData);
                    dict.Add("jsonStatOrderData", jsonStatOrderData);
                    dict.Add("jsonInfusionData", jsonInfusionData);
                    dict.Add("jsonTestData", jsonTestData);
                    dict.Add("jsonDoctorData", jsonDoctorData);
                    dict.Add("JsonCaseDetailData", JsonCaseDetailData);
                    dict.Add("JsonAllergisData", JsonAllergisData);
                    dict.Add("jsonAntibioticData", jsonAntibioticData);

                    dict.Add("jsonStatOrderMediData", jsonStatOrderMediData);
                    dict.Add("jsonBloodProductData", jsonBloodProductData);
                }



                return dict;


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetColumnByTypenewone(DataTable Dt)
        {
            object TableData = (from DataRow row in Dt.AsEnumerable()
                                select new
                                {
                                    action = "",
                                    Type = row["TYPE"].ToString().Trim(),
                                    DrugName = row["DRUGNAME"].ToString().Trim(),
                                    DrugCode = row["CODE"].ToString().Trim(),
                                    DayOfDrug = row["DAYOFDRUG"].ToString().Trim(),
                                    Dose = row["DOSE"].ToString().Trim(),
                                    Route = row["ROUTE"].ToString().Trim(),
                                    Freq = row["FREQ"].ToString().Trim(),
                                    Omit = row["OMIT"].ToString().Trim(),
                                    Remark = row["REMARK"].ToString().Trim(),
                                    TypeCode = row["TBLTYPE"].ToString().Trim(),
                                    ORDERBY = row["ORDERBY"].ToString().Trim(),
                                    ORDDATE = row["ORDDATE"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["ORDDATE"].ToString().Trim()) : string.Empty,
                                    ORDTIME = row["ORDTIME"].ToString().Trim(),
                                    OMITBY = row["OMITBY"].ToString().Trim(),
                                    OMITDT = row["OMITDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["OMITDT"].ToString().Trim()) : string.Empty,
                                    OMITTM = row["OMITTM"].ToString().Trim(),
                                    DILVOLUME = row["DILVOLUME"].ToString().Trim(),
                                    ADMINDUR = row["ADMINDUR"].ToString().Trim(),
                                    STARTFRMDT = row["STARTFRMDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["STARTFRMDT"].ToString().Trim()) : string.Empty,
                                    SEQNO = row["SEQNO"].ToString().Trim(),
                                    HighAlert = row["ALERTYN"].ToString().Trim(),
                                    INFRATE = row["INFRATE"].ToString().Trim(),
                                    MACROSET = row["MACROSET"].ToString().Trim(),
                                    MICROSET = row["MICROSET"].ToString().Trim(),
                                    NOTIFYN = row["NOTIFYN"].ToString().Trim(),
                                    STATUS = row["STATUS"].ToString().Trim(),
                                    ADMINYN = row["ADMINYN"].ToString().Trim(),
                                    Duration = row["DURATION"].ToString().Trim(),
                                    Diluent = row["DILUENT"].ToString().Trim(),
                                }).ToArray();
            return TableData;

        }
        public object GetColumnByType(DataTable Dt)
        {
            object TableData = (from DataRow row in Dt.AsEnumerable()
                                select new
                                {
                                    action = "",
                                    TYPE = row["TYPE"].ToString().Trim(),
                                    DRUGNAME = row["DRUGNAME"].ToString().Trim(),
                                    CODE = row["CODE"].ToString().Trim(),
                                    DAYOFDRUG = row["DAYOFDRUG"].ToString().Trim(),
                                    DOSE = row["DOSE"].ToString().Trim(),
                                    ROUTE = row["ROUTE"].ToString().Trim(),
                                    FREQ = row["FREQ"].ToString().Trim(),
                                    OMIT = row["OMIT"].ToString().Trim(),
                                    REMARK = row["REMARK"].ToString().Trim(),
                                    TBLTYPE = row["TBLTYPE"].ToString().Trim(),
                                    ORDERBY = row["ORDERBY"].ToString().Trim(),
                                    ORDDATE = row["ORDDATE"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["ORDDATE"].ToString().Trim()) : string.Empty,
                                    ORDTIME = row["ORDTIME"].ToString().Trim(),
                                    OMITBY = row["OMITBY"].ToString().Trim(),
                                    OMITDT = row["OMITDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["OMITDT"].ToString().Trim()) : string.Empty,
                                    OMITTM = row["OMITTM"].ToString().Trim(),
                                    DILVOLUME = row["DILVOLUME"].ToString().Trim(),
                                    ADMINDUR = row["ADMINDUR"].ToString().Trim(),
                                    STARTFRMDT = row["STARTFRMDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["STARTFRMDT"].ToString().Trim()) : string.Empty,
                                    SEQNO = row["SEQNO"].ToString().Trim(),
                                    ALERTYN = row["ALERTYN"].ToString().Trim(),
                                    INFRATE = row["INFRATE"].ToString().Trim(),
                                    MACROSET = row["MACROSET"].ToString().Trim(),
                                    MICROSET = row["MICROSET"].ToString().Trim(),
                                    NOTIFYN = row["NOTIFYN"].ToString().Trim(),
                                    STATUS = row["STATUS"].ToString().Trim(),
                                    ADMINYN = row["ADMINYN"].ToString().Trim(),
                                    DURATION = row["DURATION"].ToString().Trim(),
                                    DILUENT = row["DILUENT"].ToString().Trim(),
                                    PL = row["PL"].ToString().Trim() != string.Empty ? row["PL"].ToString().Trim() : string.Empty,

                                }).ToArray();
            return TableData;

        }
        public DataSet GetCaseDetails(string IPNo)
        {
            DataSet load = new DataSet();
            object TableData = "";
            ICUClient icuclnt = new ICUClient();
            DataTable Dt = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetCaseDetail(IPNo, "", ""))));

            if (load.Tables.Count > 0)
            {
                if (load.Tables.Contains("Table"))
                {
                    load.Tables["Table"].TableName = "TblDiagnosis";
                }
                if (load.Tables.Contains("Table1"))
                {
                    load.Tables["Table1"].TableName = "TblAllergies";
                }
            }
            return load;

        }

        public object UpdateCancellation(string TRANNO, string SEQNO, string TBLTYPE, string CANTIME)
        {
            ICUClient icuclnt = new ICUClient();
            CommonServiceClient comserv = new CommonServiceClient();
            string CANDate = "" + GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string userID = "SYSTEM";
            string TreatmentSheetResult = icuclnt.CancelTSTran(TRANNO, SEQNO, TBLTYPE, userID, CANDate, CANTIME);
            return TreatmentSheetResult;
        }
        public DataSet RetriveTSPlandData(string IPNo, string TranDate, string RecordType, string IsRollver, string NurseCode)
        {
            DataSet load = new DataSet();
            ICUClient icuclnt = new ICUClient();
            string TranFormatedDate = string.Empty;
            string NScode = NurseCode.ToString().Trim();
            //if (TranDate != string.Empty)
            //{
            //    TranFormatedDate = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(TranDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            //}

            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetTSAdminAndPlanList(IPNo, TranDate, "P", IsRollver, NScode, ""))));
            if (load != null && load.Tables.Count > 0)
            {
                if (load.Tables["TRETMEDICINE"].Rows.Count > 0)
                {
                    for (int i = 0; i < load.Tables["TRETMEDICINE"].Rows.Count; i++)
                    {
                        for (int col = 1; col < 25; col++)
                        {
                            string colnum = col.ToString();
                            if (load.Tables["TRETMEDICINE"].Rows[i]["D" + colnum].ToString() != string.Empty)
                            {
                                load.Tables["TRETMEDICINE"].Rows[i]["D" + colnum] = GeneralFunction.GetDate(load.Tables["TRETMEDICINE"].Rows[i]["D" + colnum].ToString().Trim());
                            }

                            if (load.Tables["TRETMEDICINE"].Rows[i]["CD" + colnum].ToString() != string.Empty)
                            {
                                load.Tables["TRETMEDICINE"].Rows[i]["CD" + colnum] = GeneralFunction.GetDate(load.Tables["TRETMEDICINE"].Rows[i]["CD" + colnum].ToString().Trim());
                            }
                        }

                        load.Tables["TRETMEDICINE"].Rows[i]["TRANDATE"] = GeneralFunction.GetDate(load.Tables["TRETMEDICINE"].Rows[i]["TRANDATE"].ToString().Trim());

                    }
                }

                // string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                return load;
            }
            else
            {
                return load;
            }
        }

        //end

    }

    #region Criticl Care Sheet
    public class CriticalCareGraph
    {
        public string PatientName { get; set; }
        public string Consulatation { get; set; }
        public string AgeGender { get; set; }
        public string AdmnDateTime { get; set; }
        public string MrNo { get; set; }
        public string IPNO { get; set; }
        public string Date { get; set; }
        public string WardBedNo { get; set; }

        public double NonParentamIP { get; set; }
        public double ParentalIP { get; set; }
        public double OTIP { get; set; }
        public double TotalIP { get; set; }

        public double UrineOP { get; set; }
        public double DrainOP { get; set; }
        public double RTOP { get; set; }
        public double UFOP { get; set; }
        public double OTOP { get; set; }
        public double BloodOP { get; set; }
        public double TotalOP { get; set; }

        public double Balance { get; set; }
        public double CumulativeBal { get; set; }

        public string PostOPDays { get; set; }
        public string ICUDays { get; set; }
        public string Diagnosis { get; set; }
        public string SurgeryNm { get; set; }
        public string Height { get; set; }
        public string Weight { get; set; }
        public string BMI { get; set; }
        public string EF { get; set; }
        public string TempMax { get; set; }


        public static List<OncologyEMR.CommonSerRef.SelectLstItem> SideList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Left", Value = "L" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Right", Value = "R" });
            return list;
        }


        public List<OncologyEMR.CommonSerRef.SelectLstItem> tubeTypeLst()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Radial", Value = "R" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Femoral", Value = "F" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Others", Value = "O" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Jugular", Value = "J" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Subclavian", Value = "S" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Ryles tube", Value = "T" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Percutaneous Enterogastric Tube", Value = "P" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Nasojejunal tube", Value = "N" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Foleys", Value = "Y" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Supra-pubic", Value = "U" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Silicon", Value = "L" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = " Jejunostomy tube", Value = "M" });
            return list;
        }

        public List<OncologyEMR.CommonSerRef.SelectLstItem> ConditionList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "No redness,No leak,No air", Value = "O" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Redness at site", Value = "R" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Swelling at site", Value = "Sw" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Discontinued", Value = "D/C" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Positional", Value = "P" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Blocked", Value = "B" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Redressed Swelling at site", Value = "R+Sw" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Draining", Value = "Dr" });
            return list;
        }

        public List<OncologyEMR.CommonSerRef.SelectLstItem> AssessmentLinesList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Arterial Line I", Value = "01" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Arterial Line II", Value = "02" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Arterial Line III", Value = "03" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Arterial Line IV", Value = "04" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Central Line I", Value = "05" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Central Line II", Value = "06" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Central Line III", Value = "07" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Central Line IV", Value = "08" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Dialysis Catheter I", Value = "09" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Dialysis Catheter II", Value = "10" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Dialysis Catheter III", Value = "11" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Dialysis Catheter IV", Value = "12" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "P.A Catheter I", Value = "13" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "P.A Catheter II", Value = "14" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Feeding Tube", Value = "15" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Urinary Catheter I", Value = "16" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Urinary Catheter II", Value = "17" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Urinary Catheter III", Value = "18" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Urinary Catheter IV", Value = "19" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Peripheral Line I", Value = "20" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Peripheral Line II", Value = "21" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Peripheral Line III", Value = "22" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Peripheral Line IV", Value = "23" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Temporary Pace maker I", Value = "24" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Temporary Pace maker II", Value = "25" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Temporary Pace maker III", Value = "26" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Temporary Pace maker IV", Value = "27" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "I.A.B.P.", Value = "28" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Endotrachael Tube I", Value = "29" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Endotrachael Tube II", Value = "30" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Endotrachael Tube III", Value = "31" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Nasotrachael Tube I", Value = "32" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Nasotrachael Tube II", Value = "33" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Nasotrachael Tube III", Value = "34" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Tracheostomy Tube", Value = "35" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Ventilator", Value = "36" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "DrainTubes", Value = "37" });

            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Mediastinal Tube I", Value = "38" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Mediastinal Tube II", Value = "39" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Left Pleural I", Value = "40" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Left Pleural II", Value = "41" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Right Pleural I", Value = "42" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Right Pleural II", Value = "43" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Pericardial", Value = "44" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Abdominal Drain I", Value = "45" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Abdominal Drain II", Value = "46" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem { Text = "Morrison Drain", Value = "47" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Plevic Drain", Value = "48" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Pancreatic Head", Value = "49" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Pancreatic Tail", Value = "50" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Romovac Drain", Value = "51" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Radial Drain", Value = "52" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "OTHERTXT", Value = "53" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "", Value = "54" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "", Value = "55" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "", Value = "56" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "", Value = "57" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "", Value = "58" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "", Value = "59" });
            return list;
        }

        public CriticalCareGraph GetGraphDetails(string IPNo)
        {
            CriticalCareGraph g = new CriticalCareGraph();
            CommonServiceClient comm = new CommonServiceClient();
            DataSet ds = new DataSet();

            if (IPNo != "")
            {
                ds = comm.GetIPPatInfo(("" + IPNo).Trim(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            }
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    g.PatientName = ds.Tables[0].Rows[0]["PATNAME"].ToString();
                    g.MrNo = ds.Tables[0].Rows[0]["MRNO"].ToString();
                    g.IPNO = ds.Tables[0].Rows[0]["IPNO"].ToString();
                    g.AgeGender = ds.Tables[0].Rows[0]["PATAGE"].ToString() + " / " + ds.Tables[0].Rows[0]["GENDER"].ToString();
                    g.Consulatation = ds.Tables[0].Rows[0]["CONSDOCT"].ToString();
                    g.AdmnDateTime = GeneralFunction.GetDate(("" + ds.Tables[0].Rows[0]["ADMNDATE"]).Trim()) + " / " + ("" + ds.Tables[0].Rows[0]["ADMNTIME"]).Trim();
                    g.WardBedNo = ds.Tables[0].Rows[0]["WARDNM"].ToString().Trim() + " / " + ds.Tables[0].Rows[0]["CURRBEDNO"].ToString().Trim();
                }
            }
            return g;
        }

        public DataSet GetGraphDetail(string IPNO, string strDate)
        {
            ICUClient icu = new ICUClient();
            DataSet ds = new DataSet();
            string strDate1 = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            ds.ReadXml(new XmlTextReader(new StringReader(icu.GetCritCareFlowGrapPrint(IPNO, strDate1))));
            return ds;
        }

        public DataSet GetAssessmentOfLines(string IPNO, string strDate)
        {
            ICUClient icu = new ICUClient();
            DataSet ds = new DataSet();
            string strDate1 = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            ds.ReadXml(new XmlTextReader(new StringReader(icu.GetAssesOfLine(IPNO, strDate1, ""))));
            return ds;
        }

        public DataSet GetMaxTemp(string IPNO, string strDate)
        {
            ICUClient icu = new ICUClient();
            DataSet ds = new DataSet();
            string strDate1 = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            ds.ReadXml(new XmlTextReader(new StringReader(icu.GetMaxTemp(IPNO, strDate1))));
            return ds;
        }

        public DataSet GetRespiratoryAssessment(string IPNO, string strDate)
        {
            ICUClient icu = new ICUClient();
            DataSet ds = new DataSet();
            string strDate1 = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            ds.ReadXml(new XmlTextReader(new StringReader(icu.GetRespiAssesPrint(IPNO, strDate1))));
            return ds;
        }
        //public object GetGraphDetails(string strIPNo, string strFromDate, string strToDate)
        //{
        //    CommonServiceClient comclient = new CommonServiceClient();
        //    ICUClient icuClient = new ICUClient();
        //    DataSet load = new DataSet();
        //    DataTable dt = new DataTable();

        //    strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
        //    strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
        //    load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetCritCareFlowGrapPrint(IPNO, strFromDate))));

        //    if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
        //    {
        //        return "No Data Found";
        //    }
        //    else
        //    {
        //        var data = (from DataRow row in load.Tables[0].Rows
        //                    select new
        //                    {
        //                        CADATE = GeneralFunction.GetUIDateFormat(row["CA1DATE"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
        //                        CATIME = row["CA1TIME"].ToString(),
        //                        HGT = row["HGT"].ToString(),
        //                        US = row["US"].ToString(),
        //                        UK = row["UK"].ToString(),
        //                        HGTMEDADMN = row["HGTMEDADMN"].ToString(),
        //                        USERNAME = row["USERNAME"].ToString()
        //                    }).ToArray();
        //        return data;
        //    }

        //}
    }
    #endregion Criticl Care Sheet

    #region TreatmentSheet
    public class TreatmentSheet : BL_TreatmentSheet
    {
        CommonServiceClient comser = new CommonServiceClient();
        public List<SelectListItem> MedicineTypeList { get; set; }
        public List<SelectListItem> MedicineRouteList { get; set; }
        public List<SelectListItem> TesttimeLst { get; set; }
        public List<SelectListItem> TractionNumlist { get; set; }
        public string TractionDate { get; set; }
        public string TractionTime { get; set; }



        //public object GetTransactionList(string IpNo)
        //{
        //    string SFrmDate = GeneralFunction.GetDateInSpecifiedFormat(comser.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
        //    IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> GetTransactionList;

        //    GetTransactionList = comser.GetTreatmntSheetTranLst(IpNo, SFrmDate);

        //    SelectList TransLst = new SelectList((from a in GetTransactionList
        //                                          select new
        //                                          {
        //                                              Value = a.Value,
        //                                              Text = a.Text,
        //                                          }).ToList(), "Value", "Text");
        //    return TransLst;

        //}


        public object getDrugList(string DrugName)
        {
            try
            {
                string jsonData = string.Empty;

                DataSet load = new DataSet();
                TreatmentSheet objTreatSheet = new TreatmentSheet();
                CommonServiceClient comser = new CommonServiceClient();
                // load.ReadXml(new XmlTextReader(new StringReader(comser.GetDrugListByName(DrugName))));

                if (load != null && load.Tables.Contains("Table"))
                {
                    if (load.Tables[0].Rows.Count > 0)
                    {
                        jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    }
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

        public object getTestList(string TestName)
        {
            try
            {

                DataSet load = new DataSet();
                TreatmentSheet objTreatSheet = new TreatmentSheet();
                CommonServiceClient comser = new CommonServiceClient();
                //  load.ReadXml(new XmlTextReader(new StringReader(comser.GetTestListByName(TestName))));

                if (load != null && load.Tables.Contains("Table"))
                {

                    var jsonData = new
                    {
                        rows = (from DataRow row in load.Tables["Table"].Rows
                                select new
                                {
                                    CODE = ("" + row["TESTCODE"]).Trim(),
                                    NAME = ("" + row["TESTNAME"]).Trim(),
                                }).ToArray()
                    };
                    return jsonData;
                }
                else
                {
                    var jsonData = "Unsuccessful";
                    return jsonData;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object GetMedicineType()
        {

            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            MedicineTypeList = GeneralFunction.MedicineType();

            SelectList LstService = new SelectList((from a in MedicineTypeList
                                                    select new
                                                    {
                                                        Value = a.Value,
                                                        Text = a.Text,
                                                    }).ToList(), "Value", "Text");
            return LstService;

        }

        public object GetMedicineRoutList()
        {

            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            MedicineRouteList = GeneralFunction.MedicineRoute();

            SelectList LstService = new SelectList((from a in MedicineRouteList
                                                    select new
                                                    {
                                                        Value = a.Value,
                                                        Text = a.Text,
                                                    }).ToList(), "Value", "Text");
            return LstService;


        }


        public object GetTestTimeList()
        {

            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            TesttimeLst = GeneralFunction.TetstTimeList();

            SelectList testtime = new SelectList((from a in TesttimeLst
                                                  select new
                                                  {
                                                      Value = a.Value,
                                                      Text = a.Text,
                                                  }).ToList(), "Value", "Text");
            return testtime;


        }


        public object SaveTreatmentSheetData(string tableMedicationData, string IpNo, string MrNo, string PatName, string TranctionId, string stringType, string DrugCode)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();
            DataTable MedicationData = JsonConvert.DeserializeObject<DataTable>(tableMedicationData);

            if (MedicationData.Rows.Count > 0 && MedicationData.Columns.Contains("action"))
            {
                MedicationData.Columns.Remove("action");
            }

            /*----------------------------------------Merge all Drugrelated Table to DrugList table--------------------------------------------*/

            Drugs.Merge(MedicationData);

            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                DrugDataset.Tables.Add(Drugs);
            }

            ObjBL_TreatmentSheet.Type = "" + stringType;
            ObjBL_TreatmentSheet.DrugCode = string.Format("{0}", DrugCode);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", PatName);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.userID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            // ObjBL_TreatmentSheet.ModuleID = "23";
            ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();
            ObjBL_TreatmentSheet.TranNo = TranctionId;
            // ObjBL_TreatmentSheet.Tranmode = 2;
            string TreatmentSheetResult = icuclnt.MobTreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }

        public object getTSMedicineData(string strTranNo, string strRollOverYN, string strIPNO, string strType, string TypeCode)
        {
            try
            {
                string jsonData = string.Empty;

                DataSet load = new DataSet();
                TreatmentSheet objTreatSheet = new TreatmentSheet();
                ICUClient icuclnt = new ICUClient();
                load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetMobTreatmentSheetData(string.Format("{0}", strTranNo), strRollOverYN, strIPNO, strType))));

                if (load != null && load.Tables.Contains("Table"))
                {
                    if (load.Tables[0].Rows.Count > 0)
                    {
                        jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    }
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


        public object getTSMedicineDetails(string strTranNo, string strRollOverYN, string strIPNO, string strType, string TypeCode, string drugCode)
        {
            try
            {
                string jsonData = string.Empty;

                DataSet load = new DataSet();
                TreatmentSheet objTreatSheet = new TreatmentSheet();
                ICUClient icuclnt = new ICUClient();
                load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetMobTreatmentSheetData(strTranNo, strRollOverYN, strIPNO, strType))));

                if (load != null && load.Tables.Contains("Table"))
                {
                    if (load.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = GetMedicineDetailCode(load.Tables["Table"], TypeCode, drugCode);
                        dt.TableName = "FilterMDTable";
                        if (dt.Rows.Count > 0)
                        {
                            load.Tables.Add(dt);
                        }
                        jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                    }
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


        DataTable GetFilterMedicine(DataTable dt, string TypeCode)
        {
            bool result = dt.AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == TypeCode);
            if (result)
            {
                DataTable FilterByType = dt.AsEnumerable()
                                  .Where(r => r.Field<string>("TBLTYPE") == TypeCode)
                                  .CopyToDataTable();

                DataView view = new DataView(FilterByType);
                DataTable distinctValues = view.ToTable(true, "CODE", "DRUGNAME");
                return distinctValues;
            }
            else
            {
                dt.Clear();
                return dt;
            }
        }


        DataTable GetMedicineDetailCode(DataTable dt, string TypeCode, string DrugCode)
        {
            bool result = dt.AsEnumerable().Any(r => r.Field<string>("CODE").Trim() == DrugCode && r.Field<string>("TBLTYPE") == TypeCode);
            if (result)
            {
                DataTable FilterTable = dt.AsEnumerable()
                              .Where(r => r.Field<string>("CODE").Trim() == DrugCode && r.Field<string>("TBLTYPE") == TypeCode)
                              .CopyToDataTable();
                return FilterTable;
            }
            else
            {
                dt.Clear();
                return dt;
            }
        }

        public object SaveTrmnStTestData(string strtableTestData, string MrNo, string strIpNo, string strTranNO, string stringPatName)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet TestDataset = new DataSet("DATA");
            DataTable Drugs = new DataTable();
            ICUClient icuclnt = new ICUClient();
            Drugs = JsonConvert.DeserializeObject<DataTable>(strtableTestData);


            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                TestDataset.Tables.Add(Drugs);
            }

            Drugs.TableName = "TEST";

            ObjBL_TreatmentSheet.Type = "" + "T";
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", stringPatName);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", strIpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.userID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            // ObjBL_TreatmentSheet.ModuleID = "23";
            ObjBL_TreatmentSheet.TreatmentTestData = TestDataset.GetXml();
            ObjBL_TreatmentSheet.TranNo = strTranNO;
            string TreatmentSheetResult = icuclnt.MobTreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }

        public object SaveTrmnSTDoctData(string strtableTestData, string MrNo, string strIpNo, string strTranNO, string stringPatName)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DoctDataset = new DataSet("DATA");
            DataTable Doct = new DataTable();
            ICUClient icuclnt = new ICUClient();
            Doct = JsonConvert.DeserializeObject<DataTable>(strtableTestData);

            if (Doct != null && Doct.Rows.Count > 0)
            {
                DoctDataset.Tables.Add(Doct);
            }

            Doct.TableName = "DOCTOR";

            ObjBL_TreatmentSheet.Type = "" + "D";
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", stringPatName);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", strIpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.userID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            // ObjBL_TreatmentSheet.ModuleID = "23";
            ObjBL_TreatmentSheet.TreatmentDoctData = DoctDataset.GetXml();
            ObjBL_TreatmentSheet.TranNo = strTranNO;
            string TreatmentSheetResult = icuclnt.MobTreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }
        public object VrifyTransactionData(string TranctionId)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            ICUClient icuclnt = new ICUClient();

            ObjBL_TreatmentSheet.Tranmode = 3;
            ObjBL_TreatmentSheet.TranNo = TranctionId;
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }


        public string TSRefillMedicine(string strTranno, string strMrNo, string strTYEPCode, string strIPNo, string PatName)
        {
            try
            {
                string Result = string.Empty;
                string UserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
                ICUClient icuclnt = new ICUClient();
                Result = icuclnt.ICURefillMedicines(string.Format("{0}", strTranno), string.Format("{0}", strIPNo), string.Format("{0}", strMrNo), string.Format("{0}", strTYEPCode), string.Format("{0}", PatName), string.Format("{0}", UserID));
                return Result;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public object SaveTreatsheetInfusionData(string strtableInfusionData, string MrNo, string strIpNo, string strTranNO, string stringPatName)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet dsInfusion = new DataSet("DATA");
            DataTable dtInfusion = new DataTable();
            ICUClient icuclnt = new ICUClient();
            dtInfusion = JsonConvert.DeserializeObject<DataTable>(strtableInfusionData);

            if (dtInfusion != null && dtInfusion.Rows.Count > 0)
            {
                dsInfusion.Tables.Add(dtInfusion);
            }

            dtInfusion.TableName = "INFUSION";

            ObjBL_TreatmentSheet.Type = "" + "I";
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", stringPatName);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", strIpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.userID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            // ObjBL_TreatmentSheet.ModuleID = "23";
            ObjBL_TreatmentSheet.TreatmentInfusionData = dsInfusion.GetXml();
            ObjBL_TreatmentSheet.TranNo = strTranNO;
            string TreatmentSheetResult = icuclnt.MobTreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }


    }
    #endregion
    //26-11-19
    #region IPInfusion
    public class IPInfusion : BL_TreatmentSheet
    {
        public string DVTProphylaxis { get; set; }


        public string RTAspiration { get; set; }
        public string ChestPT { get; set; }
        public string NDOthers { get; set; }
        public string SteamInhalation { get; set; }
        public string VitalSigns { get; set; }
        public string Weight { get; set; }
        public string BMI { get; set; }
        public string EF { get; set; }
        public string TempMax { get; set; }
        public string ProvDiagno { get; set; }
        public string Allergies { get; set; }
        public string DocRemarks { get; set; }

        CommonServiceClient comserv = new CommonServiceClient();
        public IEnumerable<OncologyEMR.CommonSerRef.InfusionDrugLstItem> GetInfusionList()
        {
            return comserv.ICUInfusionLst().Where(x => x.Status == "A").ToArray();
        }


        public object SaveTreatmentSheetinfuData(IPInfusion TS, string action, string tableData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();

            DataTable Infusion = JsonConvert.DeserializeObject<DataTable>(tableData);


            // Nebulization.Reset();



            if (Infusion != null && Infusion.Rows.Count > 0 && Infusion.Columns.Contains("action"))
            {
                Infusion.Columns.Remove("action");
                Infusion.Columns["Remark"].ColumnName = "REMARK";
                if (Infusion.Columns.Contains("OrderedDate"))
                {
                    for (int i = 0; i < Infusion.Rows.Count; i++)
                    {
                        if (Infusion.Rows[i]["OrderedDate"].ToString() != "")
                        {
                            Infusion.Rows[i]["OrderedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Infusion.Rows[i]["OrderedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }
                        if (Infusion.Rows[i]["OmittedDate"].ToString() != "")
                        {
                            Infusion.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Infusion.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }
                        if (string.IsNullOrEmpty(Infusion.Rows[i]["Dose"].ToString()))
                        {
                            Infusion.Rows[i]["Dose"] = string.Empty;
                        }
                    }
                }
            }






            DataSet Infu = new DataSet("DATA");
            Infusion.TableName = "INFUSION";
            if (Infusion != null && Infusion.Rows.Count > 0)
            {
                Infu.Tables.Add(Infusion);
            }



            ObjBL_TreatmentSheet.ProvDiagno = string.Format("{0}", Prov);
            ObjBL_TreatmentSheet.Allergies = string.Format("{0}", Allergy);

            ObjBL_TreatmentSheet.Remarks = string.Format("{0}", TS.Remarks);

            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);

            ObjBL_TreatmentSheet.PatName = string.Format("{0}", PatName);

            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            string input = comserv.GetServerTime();

            var timeFromInput = DateTime.ParseExact(input, "H:m:s", null, DateTimeStyles.None);

            string timeIn12HourFormatForDisplay = timeFromInput.ToString(
                "hh:mm tt",
                CultureInfo.InvariantCulture);
            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", timeIn12HourFormatForDisplay);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = System.Web.HttpContext.Current.Session["MchIPAddress"].ToString();
            //ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();
            ObjBL_TreatmentSheet.TreatmentInfusionData = Infu.GetXml();

            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }

            //ObjBL_TreatmentSheet.Type = "I";
            ObjBL_TreatmentSheet.TypeOfData = "I";
            //  string TreatmentSheetResult = string.Empty;
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }


        public object GetCaseDetailsList(string IPNo)
        {
            Dictionary<string, object> dict = new Dictionary<string, object>();
            object JsonCaseDetailData = "";
            object JsonAllergisData = "";
            DataTable dt1 = new DataTable();
            DataTable dt2 = new DataTable();

            DataSet ds = GetCaseDetails(IPNo);
            if (ds.Tables.Contains("TblDiagnosis"))
            {
                dt1 = ds.Tables["TblDiagnosis"];
                if (dt1.Rows.Count > 0)
                {
                    JsonCaseDetailData = (from DataRow row in dt1.AsEnumerable()
                                          select new
                                          {
                                              PROVDIAGNO = row["DIAGNOSIS"].ToString().Trim(),
                                          }).ToArray();
                }
            }
            if (ds.Tables.Contains("TblAllergies"))
            {
                dt2 = ds.Tables["TblAllergies"];
                if (dt2.Rows.Count > 0)
                {
                    JsonAllergisData = (from DataRow row in dt2.AsEnumerable()
                                        select new
                                        {
                                            ALLERGYDESC = row["ALLERGYDESC"].ToString().Trim(),
                                        }).ToArray();
                }
            }

            dict.Add("JsonCaseDetailData", JsonCaseDetailData);
            dict.Add("JsonAllergisData", JsonAllergisData);
            return dict;
        }
        public DataSet GetCaseDetails(string IPNo)
        {
            DataSet load = new DataSet();
            object TableData = "";
            ICUClient icuclnt = new ICUClient();
            DataTable Dt = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetCaseDetail(IPNo, "", ""))));

            if (load.Tables.Count > 0)
            {
                if (load.Tables.Contains("Table"))
                {
                    load.Tables["Table"].TableName = "TblDiagnosis";
                }
                if (load.Tables.Contains("Table1"))
                {
                    load.Tables["Table1"].TableName = "TblAllergies";
                }
            }
            return load;

        }

        public object GetTransactionList(string IpNo, string strdate)
        {
            string SFrmDate = string.Empty;
            if ((string.IsNullOrEmpty(strdate)))
            {
                SFrmDate = GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            }
            else
            {
                SFrmDate = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(strdate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            }
            IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> GetTransactionList;

            GetTransactionList = comserv.GetTreatmntSheetTranLst(IpNo, SFrmDate);

            SelectList TransLst = new SelectList((from a in GetTransactionList
                                                  select new
                                                  {
                                                      Value = a.Value,
                                                      Text = a.Text,
                                                  }).ToList(), "Value", "Text");
            return TransLst;
        }
    }
    #endregion
    #region NonDrugOrder
    public class NonDrugOrder
    {

        public string HGT { get; set; }
        public string ChangeOfPos { get; set; }
        public string OxygenAdmin { get; set; }
        public string MobileAmbul { get; set; }
        public string DeepBreathing { get; set; }
        public string AbdominalGirth { get; set; }
        public string Spirometry { get; set; }
        public List<SelectListItem> DVTProphylaxisList { get; set; }   //vishal 14th Nov
        public string DVTProphylaxis { get; set; }
        CommonServiceClient comserv = new CommonServiceClient();
        //  public double RTAspiration { get; set; }
        //public double ParentalIP { get; set; }
        //public double OTIP { get; set; }
        //public double TotalIP { get; set; }

        //public double UrineOP { get; set; }
        //public double DrainOP { get; set; }
        //public double RTOP { get; set; }
        //public double UFOP { get; set; }
        //public double OTOP { get; set; }
        //public double BloodOP { get; set; }
        //public double TotalOP { get; set; }

        //public double Balance { get; set; }
        //public double CumulativeBal { get; set; }

        public string RTAspiration { get; set; }
        public string ChestPT { get; set; }
        public string NDOthers { get; set; }
        public string SteamInhalation { get; set; }
        public string DocRemarks { get; set; }
        public string VolSupplmnt { get; set; }
        public string NutriIntake { get; set; }

        public string VitalSigns { get; set; }
        public string Weight { get; set; }
        public string BMI { get; set; }
        public string EF { get; set; }
        public string TempMax { get; set; }
        public string ProvDiagno { get; set; }
        public string Allergies { get; set; }

        public void FillCombo(NonDrugOrder ts)
        {
            CommonServiceClient comserv = new CommonServiceClient();

            ts.DVTProphylaxisList = GeneralFunction.GetDVTProphylaxisList();
            // ts.NutritionList = GeneralFunction.GetNutritionIntakeList();
        }
        public object SaveTreatmentNoNDrugMdl(NonDrugOrder TS, string action, string IpNo, string MrNo, string PatName, string TranctionId)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();







            /*----------------------------------------Merge all Drugrelated Table to DrugList table--------------------------------------------*/



            if (Drugs.Rows.Count > 0)
            {
                if (!Drugs.Columns.Contains("INFRATE"))
                {
                    Drugs.Columns.Add("INFRATE");
                    Drugs.Columns["INFRATE"].SetOrdinal(8);
                }
                Drugs.Columns.Add("MACROSET");
                Drugs.Columns.Add("MICROSET");

                Drugs.Columns["MACROSET"].DefaultValue = string.Empty;
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;

                Drugs.Columns["MACROSET"].SetOrdinal(10);
                Drugs.Columns["MICROSET"].SetOrdinal(11);
            }



            if (!Drugs.Columns.Contains("MICROSET"))
            {
                Drugs.Columns.Add("MICROSET");
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;
            }
            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                DrugDataset.Tables.Add(Drugs);
            }





            if (Drugs.Rows.Count > 0)
            {
                if (Drugs.Columns.Contains("OrderedDate"))
                {
                    for (int i = 0; i < Drugs.Rows.Count; i++)
                    {
                        if (Drugs.Rows[i]["OrderedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OrderedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OrderedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["DGSTARTDATE"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["DGSTARTDATE"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["DGSTARTDATE"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["OmittedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Columns.Contains("INFRATE"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["INFRATE"].ToString()))
                            {
                                Drugs.Rows[i]["INFRATE"] = string.Empty;
                            }
                        }

                        if (Drugs.Columns.Contains("MACROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MACROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MACROSET"] = string.Empty;
                            }
                        }
                        if (Drugs.Columns.Contains("MICROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MICROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MICROSET"] = string.Empty;
                            }
                        }
                    }
                }
            }
            ObjBL_TreatmentSheet.ProvDiagno = string.Format("{0}", TS.ProvDiagno);
            ObjBL_TreatmentSheet.Allergies = string.Format("{0}", TS.Allergies);
            //ObjBL_TreatmentSheet.CHEMOMED = string.Format("{0}", TS.CHEMOMED);
            //ObjBL_TreatmentSheet.Remarks = string.Format("{0}", TS.Remarks);
            // ObjBL_TreatmentSheet.VitalPedalPulse = string.Format("{0}", TS.VitalPedalPulse);
            ObjBL_TreatmentSheet.DVTProxy = string.Format("{0}", TS.DVTProphylaxis);            //vishal 14th Nov
            ObjBL_TreatmentSheet.HGT = string.Format("{0}", TS.HGT);
            ObjBL_TreatmentSheet.ChangeOfPos = string.Format("{0}", TS.ChangeOfPos);
            ObjBL_TreatmentSheet.OxygenAdmin = string.Format("{0}", TS.OxygenAdmin);
            ObjBL_TreatmentSheet.MobileAmbul = string.Format("{0}", TS.MobileAmbul);
            ObjBL_TreatmentSheet.DeepBreathing = string.Format("{0}", TS.DeepBreathing);
            ObjBL_TreatmentSheet.AbdominalGirth = string.Format("{0}", TS.AbdominalGirth);
            ObjBL_TreatmentSheet.Spirometry = string.Format("{0}", TS.Spirometry);
            ObjBL_TreatmentSheet.RTAspiration = string.Format("{0}", TS.RTAspiration);
            ObjBL_TreatmentSheet.ChestPT = string.Format("{0}", TS.ChestPT);
            ObjBL_TreatmentSheet.NDOthers = string.Format("{0}", TS.NDOthers);
            ObjBL_TreatmentSheet.SteamInhalation = string.Format("{0}", TS.SteamInhalation);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.VitalSigns = string.Format("{0}", TS.VitalSigns);
            ObjBL_TreatmentSheet.DocRemarks = string.Format("{0}", TS.DocRemarks);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", PatName);
            ObjBL_TreatmentSheet.NutriIntake = string.Format("{0}", TS.NutriIntake);
            ObjBL_TreatmentSheet.VolSuplmnt = string.Format("{0}", TS.VolSupplmnt);     //vishal 16th Jan 2018
            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            string input = comserv.GetServerTime();

            var timeFromInput = DateTime.ParseExact(input, "H:m:s", null, DateTimeStyles.None);

            string timeIn12HourFormatForDisplay = timeFromInput.ToString(
                "hh:mm tt",
                CultureInfo.InvariantCulture);


            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", timeIn12HourFormatForDisplay);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = Convert.ToString(HttpContext.Current.Session["MchIPAddress"]);
            ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();

            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }
            ObjBL_TreatmentSheet.TypeOfData = "N";
            //  string TreatmentSheetResult = string.Empty;
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }




    }
    #endregion
    #region BloodProduct
    public class BloodProduct : BL_TreatmentSheet
    {
        CommonServiceClient comserv = new CommonServiceClient();
        public string DVTProphylaxis { get; set; }
        //public string HGT { get; set; }
        //public string ChangeOfPos { get; set; }
        //public string OxygenAdmin { get; set; }
        //public string MobileAmbul { get; set; }
        //public string DeepBreathing { get; set; }
        //public string AbdominalGirth { get; set; }
        //public string Spirometry { get; set; }

        //  public double RTAspiration { get; set; }
        //public double ParentalIP { get; set; }
        //public double OTIP { get; set; }
        //public double TotalIP { get; set; }

        //public double UrineOP { get; set; }
        //public double DrainOP { get; set; }
        //public double RTOP { get; set; }
        //public double UFOP { get; set; }
        //public double OTOP { get; set; }
        //public double BloodOP { get; set; }
        //public double TotalOP { get; set; }

        //public double Balance { get; set; }
        //public double CumulativeBal { get; set; }

        //public string RTAspiration { get; set; }
        //public string ChestPT { get; set; }
        //public string NDOthers { get; set; }
        //public string SteamInhalation { get; set; }
        //public string VitalSigns { get; set; }
        public string Weight { get; set; }
        public string BMI { get; set; }
        public string EF { get; set; }
        public string TempMax { get; set; }
        public string ProvDiagno { get; set; }
        public string Allergies { get; set; }
        public List<SelectListItem> BloodProductList { get; set; }
        public object RetriveBloodProductList()
        {
            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            BloodProductList = GeneralFunction.TSBloodProduct();

            SelectList BPList = new SelectList((from a in BloodProductList
                                                select new
                                                {
                                                    Value = a.Value,
                                                    Text = a.Text,
                                                }).ToList(), "Value", "Text");
            return BPList;
        }

        public object SaveBloodProductTreatmentSheetData(BloodProduct TS, string action, string tableBloodProductData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();

            DataTable BloodProductData = JsonConvert.DeserializeObject<DataTable>(tableBloodProductData);

            // Nebulization.Reset();



            if (BloodProductData != null && BloodProductData.Rows.Count > 0 && BloodProductData.Columns.Contains("action"))
            {
                BloodProductData.Columns.Remove("action");
                BloodProductData.Columns["BPSTARTDATE"].ColumnName = "DGSTARTDATE";

            }



            if (Drugs.Rows.Count > 0)
            {
                if (!Drugs.Columns.Contains("INFRATE"))
                {
                    Drugs.Columns.Add("INFRATE");
                    Drugs.Columns["INFRATE"].SetOrdinal(8);
                }
                Drugs.Columns.Add("MACROSET");
                Drugs.Columns.Add("MICROSET");

                Drugs.Columns["MACROSET"].DefaultValue = string.Empty;
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;

                Drugs.Columns["MACROSET"].SetOrdinal(10);
                Drugs.Columns["MICROSET"].SetOrdinal(11);
            }

            if (BloodProductData != null) Drugs.Merge(BloodProductData);


            if (!Drugs.Columns.Contains("MICROSET"))
            {
                Drugs.Columns.Add("MICROSET");
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;
            }
            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                DrugDataset.Tables.Add(Drugs);
            }




            if (Drugs.Rows.Count > 0)
            {
                if (Drugs.Columns.Contains("OrderedDate"))
                {
                    for (int i = 0; i < Drugs.Rows.Count; i++)
                    {
                        if (Drugs.Rows[i]["OrderedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OrderedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OrderedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["DGSTARTDATE"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["DGSTARTDATE"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["DGSTARTDATE"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["OmittedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Columns.Contains("INFRATE"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["INFRATE"].ToString()))
                            {
                                Drugs.Rows[i]["INFRATE"] = string.Empty;
                            }
                        }

                        if (Drugs.Columns.Contains("MACROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MACROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MACROSET"] = string.Empty;
                            }
                        }
                        if (Drugs.Columns.Contains("MICROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MICROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MICROSET"] = string.Empty;
                            }
                        }
                    }
                }
            }
            ObjBL_TreatmentSheet.ProvDiagno = string.Format("{0}", Prov);
            ObjBL_TreatmentSheet.Allergies = string.Format("{0}", Allergy);
            // ObjBL_TreatmentSheet.CHEMOMED = string.Format("{0}", TS.CHEMOMED);
            //ObjBL_TreatmentSheet.Remarks = string.Format("{0}", TS.Remarks);
            // ObjBL_TreatmentSheet.VitalPedalPulse = string.Format("{0}", TS.VitalPedalPulse);
            // ObjBL_TreatmentSheet.DVTProxy = string.Format("{0}", TS.DVTProphylaxis);            //vishal 14th Nov
            //ObjBL_TreatmentSheet.HGT = string.Format("{0}", TS.HGT);
            //ObjBL_TreatmentSheet.ChangeOfPos = string.Format("{0}", TS.ChangeOfPos);
            //ObjBL_TreatmentSheet.OxygenAdmin = string.Format("{0}", TS.OxygenAdmin);
            // ObjBL_TreatmentSheet.MobileAmbul = string.Format("{0}", TS.MobileAmbul);
            //ObjBL_TreatmentSheet.DeepBreathing = string.Format("{0}", TS.DeepBreathing);
            // ObjBL_TreatmentSheet.AbdominalGirth = string.Format("{0}", TS.AbdominalGirth);
            // ObjBL_TreatmentSheet.Spirometry = string.Format("{0}", TS.Spirometry);
            //ObjBL_TreatmentSheet.RTAspiration = string.Format("{0}", TS.RTAspiration);
            // ObjBL_TreatmentSheet.ChestPT = string.Format("{0}", TS.ChestPT);
            //ObjBL_TreatmentSheet.NDOthers = string.Format("{0}", TS.NDOthers);
            // ObjBL_TreatmentSheet.SteamInhalation = string.Format("{0}", TS.SteamInhalation);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            //ObjBL_TreatmentSheet.VitalSigns = string.Format("{0}", TS.VitalSigns);
            //ObjBL_TreatmentSheet.DocRemarks = string.Format("{0}", TS.DocRemarks);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", PatName);
            // ObjBL_TreatmentSheet.NutriIntake = string.Format("{0}", TS.NutriIntake);
            // ObjBL_TreatmentSheet.VolSuplmnt = string.Format("{0}", TS.VolSupplmnt);     //vishal 16th Jan 2018
            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));

            string input = comserv.GetServerTime();

            var timeFromInput = DateTime.ParseExact(input, "H:m:s", null, DateTimeStyles.None);

            string timeIn12HourFormatForDisplay = timeFromInput.ToString(
                "hh:mm tt",
                CultureInfo.InvariantCulture);


            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", timeIn12HourFormatForDisplay);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = System.Web.HttpContext.Current.Session["MchIPAddress"].ToString();
            ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();
            // ObjBL_TreatmentSheet.TreatmentInfusionData = Infu.GetXml();
            // ObjBL_TreatmentSheet.TreatmentTestData = Investi.GetXml();
            // ObjBL_TreatmentSheet.TreatmentDoctData = referral.GetXml();
            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }
            ObjBL_TreatmentSheet.TypeOfData = "B";
            //  string TreatmentSheetResult = string.Empty;
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }

    }




    #endregion

    #region IVsuplement
    public class IVsupplement : BL_TreatmentSheet
    {

        CommonServiceClient comserv = new CommonServiceClient();

        public object SaveIVTreatmentSheetData(IVsupplement TS, string tableSpeciaInstructionsData, string action, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();

            DataTable SpeciaInstructions = JsonConvert.DeserializeObject<DataTable>(tableSpeciaInstructionsData);





            if (SpeciaInstructions.Rows.Count > 0 && SpeciaInstructions.Columns.Contains("action"))
            {
                SpeciaInstructions.Columns.Remove("action");
                SpeciaInstructions.Columns["SpiDGSTARTDATE"].ColumnName = "DGSTARTDATE";

            }








            if (Drugs.Rows.Count > 0)
            {
                if (!Drugs.Columns.Contains("INFRATE"))
                {
                    Drugs.Columns.Add("INFRATE");
                    Drugs.Columns["INFRATE"].SetOrdinal(8);
                }
                Drugs.Columns.Add("MACROSET");
                Drugs.Columns.Add("MICROSET");

                Drugs.Columns["MACROSET"].DefaultValue = string.Empty;
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;

                Drugs.Columns["MACROSET"].SetOrdinal(10);
                Drugs.Columns["MICROSET"].SetOrdinal(11);
            }


            Drugs.Merge(SpeciaInstructions);

            if (!Drugs.Columns.Contains("MICROSET"))
            {
                Drugs.Columns.Add("MICROSET");
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;
            }
            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                DrugDataset.Tables.Add(Drugs);
            }







            if (Drugs.Rows.Count > 0)
            {
                if (Drugs.Columns.Contains("OrderedDate"))
                {
                    for (int i = 0; i < Drugs.Rows.Count; i++)
                    {
                        if (Drugs.Rows[i]["OrderedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OrderedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OrderedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["DGSTARTDATE"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["DGSTARTDATE"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["DGSTARTDATE"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["OmittedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Columns.Contains("INFRATE"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["INFRATE"].ToString()))
                            {
                                Drugs.Rows[i]["INFRATE"] = string.Empty;
                            }
                        }

                        if (Drugs.Columns.Contains("MACROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MACROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MACROSET"] = string.Empty;
                            }
                        }
                        if (Drugs.Columns.Contains("MICROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MICROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MICROSET"] = string.Empty;
                            }
                        }
                    }
                }
            }
            ObjBL_TreatmentSheet.ProvDiagno = string.Format("{0}", Prov);
            ObjBL_TreatmentSheet.Allergies = string.Format("{0}", Allergy);
            // ObjBL_TreatmentSheet.CHEMOMED = string.Format("{0}", TS.CHEMOMED);
            //ObjBL_TreatmentSheet.Remarks = string.Format("{0}", TS.Remarks);
            // ObjBL_TreatmentSheet.VitalPedalPulse = string.Format("{0}", TS.VitalPedalPulse);
            //ObjBL_TreatmentSheet.DVTProxy = string.Format("{0}", TS.DVTProphylaxis);            //vishal 14th Nov
            ObjBL_TreatmentSheet.HGT = string.Format("{0}", "HGT1");
            // ObjBL_TreatmentSheet.ChangeOfPos = string.Format("{0}", TS.ChangeOfPos);
            ObjBL_TreatmentSheet.OxygenAdmin = string.Format("{0}", "OXY1");
            // ObjBL_TreatmentSheet.MobileAmbul = string.Format("{0}", TS.MobileAmbul);
            //ObjBL_TreatmentSheet.DeepBreathing = string.Format("{0}", TS.DeepBreathing);
            //ObjBL_TreatmentSheet.AbdominalGirth = string.Format("{0}", TS.AbdominalGirth);
            //ObjBL_TreatmentSheet.Spirometry = string.Format("{0}", TS.Spirometry);
            //ObjBL_TreatmentSheet.RTAspiration = string.Format("{0}", TS.RTAspiration);
            //ObjBL_TreatmentSheet.ChestPT = string.Format("{0}", TS.ChestPT);
            //ObjBL_TreatmentSheet.NDOthers = string.Format("{0}", TS.NDOthers);
            //ObjBL_TreatmentSheet.SteamInhalation = string.Format("{0}", TS.SteamInhalation);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.VitalSigns = string.Format("{0}", "VITAL1");
            //ObjBL_TreatmentSheet.DocRemarks = string.Format("{0}", TS.DocRemarks);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", PatName);
            // ObjBL_TreatmentSheet.NutriIntake = string.Format("{0}", TS.NutriIntake);
            //  ObjBL_TreatmentSheet.VolSuplmnt = string.Format("{0}", TS.VolSupplmnt);     //vishal 16th Jan 2018
            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));

            string input = comserv.GetServerTime();

            var timeFromInput = DateTime.ParseExact(input, "H:m:s", null, DateTimeStyles.None);

            string timeIn12HourFormatForDisplay = timeFromInput.ToString(
                "hh:mm tt",
                CultureInfo.InvariantCulture);
            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", timeIn12HourFormatForDisplay);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = Convert.ToString(HttpContext.Current.Session["MchIPAddress"]);
            ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();
            // ObjBL_TreatmentSheet.TreatmentInfusionData = Infu.GetXml();
            // ObjBL_TreatmentSheet.TreatmentTestData = Investi.GetXml();
            //ObjBL_TreatmentSheet.TreatmentDoctData = referral.GetXml();
            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }
            //ObjBL_TreatmentSheet.Type = "V";
            ObjBL_TreatmentSheet.TypeOfData = "V";
            //  string TreatmentSheetResult = string.Empty;
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }



    }

    #endregion

    #region IPReferrals
    public class IPReferrals : BL_TreatmentSheet
    {
        public string DVTProphylaxis { get; set; }
        public string HGT { get; set; }
        public string ChangeOfPos { get; set; }
        public string OxygenAdmin { get; set; }
        public string MobileAmbul { get; set; }
        public string DeepBreathing { get; set; }
        public string AbdominalGirth { get; set; }
        public string Spirometry { get; set; }

        //  public double RTAspiration { get; set; }
        //public double ParentalIP { get; set; }
        //public double OTIP { get; set; }
        //public double TotalIP { get; set; }

        //public double UrineOP { get; set; }
        //public double DrainOP { get; set; }
        //public double RTOP { get; set; }
        //public double UFOP { get; set; }
        //public double OTOP { get; set; }
        //public double BloodOP { get; set; }
        //public double TotalOP { get; set; }

        //public double Balance { get; set; }
        //public double CumulativeBal { get; set; }

        public string RTAspiration { get; set; }
        public string ChestPT { get; set; }
        public string NDOthers { get; set; }
        public string SteamInhalation { get; set; }
        public string VitalSigns { get; set; }
        public string Weight { get; set; }
        public string BMI { get; set; }
        public string EF { get; set; }
        public string TempMax { get; set; }
        public string ProvDiagno { get; set; }
        public string Allergies { get; set; }
        public List<SelectListItem> BloodProductList { get; set; }
        public List<SelectListItem> NutritionList { get; set; }
        public string VolSupplmnt { get; set; }

        CommonServiceClient comserv = new CommonServiceClient();

        public void FillCombo(IPReferrals ts)
        {
            CommonServiceClient comserv = new CommonServiceClient();


            ts.NutritionList = GeneralFunction.GetNutritionIntakeList();

        }
        public IEnumerable<OncologyEMR.CommonSerRef.DoctorSelLstItem> GetDoctorInfo()
        {
            return comserv.GetDoctLst().Where(x => x.Status == "A").ToArray();
        }
        public object RetriveMaxSEQNO(string IPNO)
        {
            //object jsonData = string.Empty;
            DataSet load = new DataSet();
            ICUClient icuclnt = new ICUClient();

            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetMaxMedSeq(IPNO))));

            if (load != null && load.Tables.Count > 0)
            {
                string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                return jsonData;
            }
            else
            {
                return "UNSUCESSFULL";
            }
        }
        public object GetSpecilizationList()
        {
            IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> GetSpecilizationlistList;
            GetSpecilizationlistList = comserv.GetSpecilstnList();
            SelectList splist = new SelectList((from a in GetSpecilizationlistList
                                                select new
                                                {
                                                    Value = a.Value,
                                                    Text = a.Text,
                                                }).ToList(), "Value", "Text");
            return splist;
        }
        public object SaveReferralTreatmentSheetData(IPReferrals TS, string action, string tableReferralsFilterData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();

            DataTable Referrals = JsonConvert.DeserializeObject<DataTable>(tableReferralsFilterData);

            if (Referrals != null && Referrals.Rows.Count > 0 && Referrals.Columns.Contains("action"))
            {
                Referrals.Columns.Remove("action");
            }


            /*----------------------------------------Merge all Drugrelated Table to DrugList table--------------------------------------------*/


            if (Drugs.Rows.Count > 0)
            {
                if (!Drugs.Columns.Contains("INFRATE"))
                {
                    Drugs.Columns.Add("INFRATE");
                    Drugs.Columns["INFRATE"].SetOrdinal(8);
                }
                Drugs.Columns.Add("MACROSET");
                Drugs.Columns.Add("MICROSET");

                Drugs.Columns["MACROSET"].DefaultValue = string.Empty;
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;

                Drugs.Columns["MACROSET"].SetOrdinal(10);
                Drugs.Columns["MICROSET"].SetOrdinal(11);
            }



            if (!Drugs.Columns.Contains("MICROSET"))
            {
                Drugs.Columns.Add("MICROSET");
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;
            }
            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                DrugDataset.Tables.Add(Drugs);
            }





            DataSet referral = new DataSet("DATA");

            if (Referrals != null && Referrals.Rows.Count > 0)
            {
                Referrals.TableName = "DOCTOR";
                for (int r = 0; r < Referrals.Rows.Count; r++)
                {
                    Referrals.Rows[r]["CancelDT"] = GeneralFunction.GetDateInSpecifiedFormat(Referrals.Rows[r]["CancelDT"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                referral.Tables.Add(Referrals);
            }

            if (Drugs.Rows.Count > 0)
            {
                if (Drugs.Columns.Contains("OrderedDate"))
                {
                    for (int i = 0; i < Drugs.Rows.Count; i++)
                    {
                        if (Drugs.Rows[i]["OrderedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OrderedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OrderedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["DGSTARTDATE"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["DGSTARTDATE"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["DGSTARTDATE"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["OmittedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Columns.Contains("INFRATE"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["INFRATE"].ToString()))
                            {
                                Drugs.Rows[i]["INFRATE"] = string.Empty;
                            }
                        }

                        if (Drugs.Columns.Contains("MACROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MACROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MACROSET"] = string.Empty;
                            }
                        }
                        if (Drugs.Columns.Contains("MICROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MICROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MICROSET"] = string.Empty;
                            }
                        }
                    }
                }
            }
            ObjBL_TreatmentSheet.ProvDiagno = string.Format("{0}", Prov);
            ObjBL_TreatmentSheet.Allergies = string.Format("{0}", Allergy);
            //ObjBL_TreatmentSheet.CHEMOMED = string.Format("{0}", TS.CHEMOMED);
            /// ObjBL_TreatmentSheet.Remarks = string.Format("{0}", TS.Remarks);
            // ObjBL_TreatmentSheet.VitalPedalPulse = string.Format("{0}", TS.VitalPedalPulse);
            // ObjBL_TreatmentSheet.DVTProxy = string.Format("{0}", "");            //vishal 14th Nov
            ObjBL_TreatmentSheet.HGT = string.Format("{0}", "HGT");
            // ObjBL_TreatmentSheet.ChangeOfPos = string.Format("{0}", TS.ChangeOfPos);
            ObjBL_TreatmentSheet.OxygenAdmin = string.Format("{0}", "ADM1");
            // ObjBL_TreatmentSheet.MobileAmbul = string.Format("{0}", TS.MobileAmbul);
            //ObjBL_TreatmentSheet.DeepBreathing = string.Format("{0}", TS.DeepBreathing);
            //ObjBL_TreatmentSheet.AbdominalGirth = string.Format("{0}", TS.AbdominalGirth);
            //ObjBL_TreatmentSheet.Spirometry = string.Format("{0}", TS.Spirometry);
            // ObjBL_TreatmentSheet.RTAspiration = string.Format("{0}", TS.RTAspiration);
            //ObjBL_TreatmentSheet.ChestPT = string.Format("{0}", TS.ChestPT);
            //ObjBL_TreatmentSheet.NDOthers = string.Format("{0}", TS.NDOthers);
            //ObjBL_TreatmentSheet.SteamInhalation = string.Format("{0}", TS.SteamInhalation);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.VitalSigns = string.Format("{0}", "Vital1");
            // ObjBL_TreatmentSheet.DocRemarks = string.Format("{0}", TS.DocRemarks);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", PatName);
            ObjBL_TreatmentSheet.NutriIntake = string.Format("{0}", "NBM");
            ObjBL_TreatmentSheet.VolSuplmnt = string.Format("{0}", "45");     //vishal 16th Jan 2018
            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            string input = comserv.GetServerTime();

            var timeFromInput = DateTime.ParseExact(input, "H:m:s", null, DateTimeStyles.None);

            string timeIn12HourFormatForDisplay = timeFromInput.ToString(
                "hh:mm tt",
                CultureInfo.InvariantCulture);
            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", timeIn12HourFormatForDisplay);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = System.Web.HttpContext.Current.Session["MchIPAddress"].ToString();
            //ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();
            //ObjBL_TreatmentSheet.TreatmentInfusionData = Infu.GetXml();
            //ObjBL_TreatmentSheet.TreatmentTestData = Investi.GetXml();
            ObjBL_TreatmentSheet.TreatmentDoctData = referral.GetXml();
            //ObjBL_TreatmentSheet.Type = "D";
            ObjBL_TreatmentSheet.TypeOfData = "D";
            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }

            //  string TreatmentSheetResult = string.Empty;
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }



    }
    #endregion

    #region IPMedication

    public class IPMedication : BL_TreatmentSheet
    {
        public List<SelectListItem> AdministrationDurList { get; set; }
        public List<SelectListItem> DilutionVolumeList { get; set; }
        public List<SelectListItem> MedicineTypeList { get; set; }
        public string ProvDiagno { get; set; }
        public string Allergies { get; set; }
        CommonServiceClient comserv = new CommonServiceClient();
        public object GetDilutionVolumeList()
        {

            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            DilutionVolumeList = GeneralFunction.DilutionVolume();

            SelectList LstService = new SelectList((from a in DilutionVolumeList
                                                    select new
                                                    {
                                                        Value = a.Value,
                                                        Text = a.Text,
                                                    }).ToList(), "Value", "Text");
            return LstService;
        }
        public object GetAdministrationDurList()
        {
            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            AdministrationDurList = GeneralFunction.AdministrationDuration();

            SelectList LstService = new SelectList((from a in AdministrationDurList
                                                    select new
                                                    {
                                                        Value = a.Value,
                                                        Text = a.Text,
                                                    }).ToList(), "Value", "Text");
            return LstService;
        }
        public object GetMedicineType()
        {

            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            MedicineTypeList = GeneralFunction.MedicineType();

            SelectList LstService = new SelectList((from a in MedicineTypeList
                                                    select new
                                                    {
                                                        Value = a.Value,
                                                        Text = a.Text,
                                                    }).ToList(), "Value", "Text");
            return LstService;

        }


        public object SaveIPMedTreatmentSheetData(IPMedication TS, string action, string tableMedicationData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy, string statMed)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();
            DataTable MedicationData = JsonConvert.DeserializeObject<DataTable>(tableMedicationData);



            if (MedicationData.Rows.Count > 0 && MedicationData.Columns.Contains("action"))
            {
                MedicationData.Columns.Remove("action");
                MedicationData.Columns["MediDGSTARTDATE"].ColumnName = "DGSTARTDATE";
            }




            string input = comserv.GetServerTime();

            var timeFromInput = DateTime.ParseExact(input, "H:m:s", null, DateTimeStyles.None);

            string timeIn12HourFormatForDisplay = timeFromInput.ToString(
                "hh:mm tt",
                CultureInfo.InvariantCulture);

            //var timeInTodayDate = DateTime.Today.Add(timeFromInput.TimeOfDay);








            /*----------------------------------------Merge all Drugrelated Table to DrugList table--------------------------------------------*/

            Drugs.Merge(MedicationData);


            if (Drugs.Rows.Count > 0)
            {
                if (!Drugs.Columns.Contains("INFRATE"))
                {
                    Drugs.Columns.Add("INFRATE");
                    Drugs.Columns["INFRATE"].SetOrdinal(8);
                }
                Drugs.Columns.Add("MACROSET");
                Drugs.Columns.Add("MICROSET");

                Drugs.Columns["MACROSET"].DefaultValue = string.Empty;
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;

                Drugs.Columns["MACROSET"].SetOrdinal(10);
                Drugs.Columns["MICROSET"].SetOrdinal(11);
            }



            if (!Drugs.Columns.Contains("MICROSET"))
            {
                Drugs.Columns.Add("MICROSET");
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;
            }
            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                DrugDataset.Tables.Add(Drugs);
            }







            if (Drugs.Rows.Count > 0)
            {
                if (Drugs.Columns.Contains("OrderedDate"))
                {
                    for (int i = 0; i < Drugs.Rows.Count; i++)
                    {
                        if (Drugs.Rows[i]["OrderedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OrderedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OrderedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["DGSTARTDATE"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["DGSTARTDATE"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["DGSTARTDATE"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["OmittedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Columns.Contains("INFRATE"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["INFRATE"].ToString()))
                            {
                                Drugs.Rows[i]["INFRATE"] = string.Empty;
                            }
                        }

                        if (Drugs.Columns.Contains("MACROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MACROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MACROSET"] = string.Empty;
                            }
                        }
                        if (Drugs.Columns.Contains("MICROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MICROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MICROSET"] = string.Empty;
                            }
                        }
                    }
                }
            }

            // ObjBL_TreatmentSheet.VitalPedalPulse = string.Format("{0}", TS.VitalPedalPulse);
            //ObjBL_TreatmentSheet.DVTProxy = string.Format("{0}", TS.DVTProphylaxis);            //vishal 14th Nov
            ObjBL_TreatmentSheet.HGT = string.Format("{0}", TS.HGT);//complsry
            ObjBL_TreatmentSheet.ChangeOfPos = string.Format("{0}", TS.ChangeOfPos);
            ObjBL_TreatmentSheet.OxygenAdmin = string.Format("{0}", TS.OxygenAdmin);//complsry
            ObjBL_TreatmentSheet.MobileAmbul = string.Format("{0}", TS.MobileAmbul);
            ObjBL_TreatmentSheet.DeepBreathing = string.Format("{0}", TS.DeepBreathing);
            ObjBL_TreatmentSheet.AbdominalGirth = string.Format("{0}", TS.AbdominalGirth);
            ObjBL_TreatmentSheet.Spirometry = string.Format("{0}", TS.Spirometry);
            ObjBL_TreatmentSheet.RTAspiration = string.Format("{0}", TS.RTAspiration);
            ObjBL_TreatmentSheet.ChestPT = string.Format("{0}", TS.ChestPT);
            ObjBL_TreatmentSheet.NDOthers = string.Format("{0}", TS.NDOthers);
            ObjBL_TreatmentSheet.SteamInhalation = string.Format("{0}", TS.SteamInhalation);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.VitalSigns = string.Format("{0}", TS.VitalSigns);//complsry
            ObjBL_TreatmentSheet.DocRemarks = string.Format("{0}", TS.DocRemarks);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", TS.PatName);
            ObjBL_TreatmentSheet.NutriIntake = string.Format("{0}", TS.NutriIntake);
            //  ObjBL_TreatmentSheet.VolSuplmnt = string.Format("{0}", TS.VolSupplmnt);     //vishal 16th Jan 2018
            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", timeIn12HourFormatForDisplay);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = Convert.ToString(HttpContext.Current.Session["MchIPAddress"]);
            ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();


            ObjBL_TreatmentSheet.TypeOfData = statMed;

            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }
            //  string TreatmentSheetResult = string.Empty;
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }




    }


    #endregion
    #region IPInvestigation

    public class IPInvestigation : BL_TreatmentSheet
    {
        public List<SelectListItem> AdministrationDurList { get; set; }
        public List<SelectListItem> DilutionVolumeList { get; set; }
        public string ProvDiagno { get; set; }
        public string Allergies { get; set; }
        CommonServiceClient comserv = new CommonServiceClient();
        public List<SelectListItem> NutritionList { get; set; }
        public string VolSupplmnt { get; set; }
        public string NutriIntake { get; set; }
        public string DocRemarks { get; set; }

        public void FillCombo(IPInvestigation ts)
        {
            CommonServiceClient comserv = new CommonServiceClient();


            ts.NutritionList = GeneralFunction.GetNutritionIntakeList();

        }
        public object RetriveTestList(string TestName)
        {
            //object jsonData = string.Empty;
            OncologyEMRClient client = new OncologyEMRClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            var strServType = GeneralFunction.GetAppsettingUnitWiseValue("ServTypes").ToString().Trim();
            load.ReadXml(new XmlTextReader(new StringReader(client.GetMatchedTest(TestName, "", ""))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables["Table"];
            var rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            TESTCODE = ("" + row["TESTCODE"]).Trim(),
                            TESTNAME = ("" + row["TESTNAME"]).Trim(),
                            CNT = ("" + 0).Trim()
                        }).ToArray();
            return rows;
        }
        //public object getTestList(string TestName)
        //{
        //    try
        //    {

        //        DataSet load = new DataSet();
        //        TreatmentSheet objTreatSheet = new TreatmentSheet();
        //        CommonServiceClient comser = new CommonServiceClient();
        //        load.ReadXml(new XmlTextReader(new StringReader(comser.GetTestListByName(TestName))));

        //        if (load.Tables["Table"] != null && load.Tables["Table"].Rows.Count > 0)
        //        {
        //            DataTable FilterTable = load.Tables["Table"];

        //            var jsonData = new
        //            {
        //                rows = (from DataRow row in FilterTable.Rows
        //                        select new
        //                        {
        //                            CODE = ("" + row["TESTCODE"]).Trim(),
        //                            NAME = ("" + row["TESTNAME"]).Trim(),
        //                        }).ToArray()
        //            };
        //            return jsonData;
        //        }
        //        else
        //        {
        //            var jsonData = "";
        //            return jsonData;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        public object SaveTreatmentIpInVestigation(string action, string tableInvestigationData, string IpNo, string MrNo, string PatName, string TranctionId, string Prov, string Allergy, string NutIntake, string DoctorRemark, string VolSuplmnt)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();

            DataTable Investigation = JsonConvert.DeserializeObject<DataTable>(tableInvestigationData);

            if (Investigation.Rows.Count > 0 && Investigation.Columns.Contains("action"))
            {
                Investigation.Columns.Remove("action");

                if (Investigation.Columns.Contains("OrderDate"))
                {
                    for (int i = 0; i < Investigation.Rows.Count; i++)
                    {
                        if (Investigation.Rows[i]["OrderDate"].ToString() != "")
                        {
                            Investigation.Rows[i]["OrderDate"] = GeneralFunction.GetDateInSpecifiedFormat(Investigation.Rows[i]["OrderDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                            Investigation.Rows[i]["CancelDT"] = GeneralFunction.GetDateInSpecifiedFormat(Investigation.Rows[i]["CancelDT"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                            Investigation.Rows[i]["ProposedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Investigation.Rows[i]["ProposedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);


                        }
                    }
                }
            }




            if (Drugs.Rows.Count > 0)
            {
                if (!Drugs.Columns.Contains("INFRATE"))
                {
                    Drugs.Columns.Add("INFRATE");
                    Drugs.Columns["INFRATE"].SetOrdinal(8);
                }
                Drugs.Columns.Add("MACROSET");
                Drugs.Columns.Add("MICROSET");

                Drugs.Columns["MACROSET"].DefaultValue = string.Empty;
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;

                Drugs.Columns["MACROSET"].SetOrdinal(10);
                Drugs.Columns["MICROSET"].SetOrdinal(11);
            }


            if (!Drugs.Columns.Contains("MICROSET"))
            {
                Drugs.Columns.Add("MICROSET");
                Drugs.Columns["MICROSET"].DefaultValue = string.Empty;
            }
            if (Drugs != null && Drugs.Rows.Count > 0)
            {
                DrugDataset.Tables.Add(Drugs);
            }



            DataSet Investi = new DataSet("DATA");
            Investigation.TableName = "TEST";

            if (Investigation != null && Investigation.Rows.Count > 0)
            {
                Investi.Tables.Add(Investigation);
            }



            if (Drugs.Rows.Count > 0)
            {
                if (Drugs.Columns.Contains("OrderedDate"))
                {
                    for (int i = 0; i < Drugs.Rows.Count; i++)
                    {
                        if (Drugs.Rows[i]["OrderedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OrderedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OrderedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["DGSTARTDATE"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["DGSTARTDATE"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["DGSTARTDATE"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Rows[i]["OmittedDate"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        if (Drugs.Columns.Contains("INFRATE"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["INFRATE"].ToString()))
                            {
                                Drugs.Rows[i]["INFRATE"] = string.Empty;
                            }
                        }

                        if (Drugs.Columns.Contains("MACROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MACROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MACROSET"] = string.Empty;
                            }
                        }
                        if (Drugs.Columns.Contains("MICROSET"))
                        {
                            if (string.IsNullOrEmpty(Drugs.Rows[i]["MICROSET"].ToString()))
                            {
                                Drugs.Rows[i]["MICROSET"] = string.Empty;
                            }
                        }
                    }
                }
            }
            ObjBL_TreatmentSheet.ProvDiagno = string.Format("{0}", Prov);
            ObjBL_TreatmentSheet.Allergies = string.Format("{0}", Allergy);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            // ObjBL_TreatmentSheet.VitalSigns = string.Format("{0}", TS.VitalSigns);
            ObjBL_TreatmentSheet.DocRemarks = string.Format("{0}", DoctorRemark);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", PatName);
            //ObjBL_TreatmentSheet.NutriIntake = string.Format("{0}", TS.NutriIntake);
            ObjBL_TreatmentSheet.VolSuplmnt = string.Format("{0}", VolSuplmnt);     //vishal 16th Jan 2018

            ObjBL_TreatmentSheet.NutriIntake = string.Format("{0}", NutIntake);



            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));

            string input = comserv.GetServerTime();

            var timeFromInput = DateTime.ParseExact(input, "H:m:s", null, DateTimeStyles.None);

            string timeIn12HourFormatForDisplay = timeFromInput.ToString(
                "hh:mm tt",
                CultureInfo.InvariantCulture);
            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", timeIn12HourFormatForDisplay);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = Convert.ToString(HttpContext.Current.Session["MchIPAddress"]);
            // ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();

            ObjBL_TreatmentSheet.TreatmentTestData = Investi.GetXml();

            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }
            //  string TreatmentSheetResult = string.Empty;
            ObjBL_TreatmentSheet.TypeOfData = "T";
            //ObjBL_TreatmentSheet.Type = "T";
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }


    }


    #endregion
}