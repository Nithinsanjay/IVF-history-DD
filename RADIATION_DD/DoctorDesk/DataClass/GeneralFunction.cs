using Newtonsoft.Json;
using OncologyEMR.CommonSerRef;
using OncologyEMR.Pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using System.Xml;
namespace OncologyEMR.DataClass
{
    public class GeneralFunction
    {
        public static string padString(string str, int max)
        {
            return str.Length < max ? padString("0" + str, max) : str;
        }


        //Priyanka 06/01/2026
        public static List<SelectListItem> GetVisitPurposeList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "All", Value = "" });
            //items.Add(new SelectListItem { Text = "Visit Purpose", Value = "NW" });
            //items.Add(new SelectListItem { Text = "Consultation", Value = "C" });
            //items.Add(new SelectListItem { Text = "FollowUp", Value = "FU" });
            items.Add(new SelectListItem { Text = "FollowUp", Value = "02" });
            items.Add(new SelectListItem { Text = "New", Value = "01" });
            items.Add(new SelectListItem { Text = "Review after Inv. Reports/ Procedure", Value = "03" });
            return items;
        }


        public static List<SelectListItem> GetAppointmentVisitPurposeList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "All", Value = "" });
            //items.Add(new SelectListItem { Text = "Visit Purpose", Value = "NW" });
            //items.Add(new SelectListItem { Text = "Consultation", Value = "C" });
            //items.Add(new SelectListItem { Text = "FollowUp", Value = "FU" });
            items.Add(new SelectListItem { Text = "Chemo Review", Value = "01" });
            items.Add(new SelectListItem { Text = "Surgical Opinion", Value = "02" });
            items.Add(new SelectListItem { Text = "General Review", Value = "03" });
            return items;
        }

        public static string GetPrintAge(string strAge)
        {
            string[] splitVal = strAge.Split(':');
            string sage = ""; string smonth = ""; string sdays = "";
            if (splitVal[0].Trim() != "")
            {
                if (splitVal[0].Length <= 3)
                {
                    if (splitVal[0] != "0" && splitVal[0] != "00" && splitVal[0] != "000")
                    {
                        sage = splitVal[0].StartsWith("000") ? "" : (splitVal[0].StartsWith("00") ? splitVal[0].Substring(2) + " Year(s)" : (splitVal[0].StartsWith("0") ? splitVal[0].Substring(1) + " Year(s)" : splitVal[0] + " Year(s)"));
                    }
                }
                if (splitVal[1] != "0" && splitVal[1] != "00" && splitVal[1] != "000" && sage == "")
                {
                    smonth = splitVal[1].StartsWith("0") ? splitVal[1].Substring(1) + " Month(s)" : splitVal[1] + " Month(s)";
                    if (smonth != "")
                    {
                        if (sage != "")
                        {
                            if (Convert.ToInt32(splitVal[0]) <= 14) sage = sage + "," + smonth;
                        }
                        else
                            sage = smonth;
                    }
                }
                if (splitVal[2] != "0" && splitVal[2] != "00" && splitVal[2] != "000" && sage == "")
                {
                    sdays = splitVal[2].StartsWith("0") ? splitVal[2].Substring(1) + " Day(s)" : splitVal[2] + " Day(s)";
                    if (sdays != "")
                    {


                        if (Convert.ToInt32(splitVal[0]) < 1)
                        {
                            //sage = sage + "," + sdays;
                            sage = sage + sdays;
                        }
                    }
                }
            }
            return sage;
        }


        public static DataSet GetIPPatInfo(string strIPno, string strMRNo, string strPatFNm, string strPatMNm, string strPatLNm, string strPatDOB, string strPatContact, string strAdmnFrmDt, string strAdmnToDt, string strStatus, string strPatNm,
            string strNurstCD, string strMLCYN, string strAdmnDoct, string strBillYn, string strEmpID = "")
        {
            DataSet dsData = new DataSet();
            CommonServiceClient comm = new CommonServiceClient();
            if (System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString() != "25")
                dsData = comm.GetIPPatInfo(("" + strIPno).Trim(), strMRNo, strPatFNm, strPatMNm, strPatLNm, strPatDOB, strPatContact, strAdmnFrmDt, strAdmnToDt, strStatus, strPatNm, strNurstCD, strMLCYN, strAdmnDoct, strBillYn, strEmpID);
            else
                dsData = comm.GetCasIPPatInfo(("" + strIPno).Trim(), strMRNo, strPatDOB, strAdmnFrmDt, strAdmnToDt, strStatus, strPatNm, strAdmnDoct, strEmpID);
            return dsData;
        }
        //End

        public static List<SelectListItem> GetStatusCmb()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Active", Value = "A" });
            items.Add(new SelectListItem { Text = "Inactive", Value = "I" });
            return items;
        }

        public static List<SelectListItem> GetYears()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            var year = DateTime.Now.Year;
            for (int i = 2000; i <= year; i++)
            {
                items.Add(new SelectListItem { Text = i.ToString(), Value = i.ToString() });
            }
            //items.Add(new SelectListItem { Text = "Inactive", Value = "I" });
            return items;
        }
        public static List<SelectListItem> GetGenderCmb()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Male", Value = "M" });
            items.Add(new SelectListItem { Text = "Female", Value = "F" });
            items.Add(new SelectListItem { Text = "Others", Value = "O" });
            return items;
        }

        public static DataSet FillDatasetXMl(string Xmlstring)
        {
            DataSet dsData = new DataSet();
            dsData.ReadXml(new XmlTextReader(new StringReader(Xmlstring)));
            return dsData;
        }

        public static List<SelectListItem> GetPatCatg()
        {
            List<SelectListItem> lst = new List<SelectListItem>();
            lst.Add(new SelectListItem { Value = "", Text = "---- Select ----" });
            lst.Add(new SelectListItem { Value = "01", Text = "Pay Patient" });
            lst.Add(new SelectListItem { Value = "02", Text = "Credit Company Patient" });
            lst.Add(new SelectListItem { Value = "03", Text = "RGJAY" });
            lst.Add(new SelectListItem { Value = "04", Text = "CGHS" });
            lst.Add(new SelectListItem { Value = "05", Text = "Aarogyashree" });
            lst.Add(new SelectListItem { Value = "06", Text = "ECHS" });
            lst.Add(new SelectListItem { Value = "07", Text = "AIMS" });
            return lst;
        }

        public static List<SelectListItem> GetRelation()
        {
            List<SelectListItem> lst = new List<SelectListItem>();
            lst.Add(new SelectListItem { Value = "01", Text = "Father" });
            lst.Add(new SelectListItem { Value = "02", Text = "Mother" });
            lst.Add(new SelectListItem { Value = "03", Text = "Wife" });
            lst.Add(new SelectListItem { Value = "04", Text = "Brother" });
            lst.Add(new SelectListItem { Value = "05", Text = "Sister" });
            lst.Add(new SelectListItem { Value = "06", Text = "Grand Father" });
            lst.Add(new SelectListItem { Value = "07", Text = "Grand Mother" });
            return lst;
        }

        public static List<SelectListItem> GetBirthHistory()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Preterm", Value = "Preterm" });
            items.Add(new SelectListItem { Text = "Fullterm", Value = "Fullterm" });
            items.Add(new SelectListItem { Text = "Normal", Value = "Normal" });
            items.Add(new SelectListItem { Text = "Breech", Value = "Breech" });
            items.Add(new SelectListItem { Text = "Foceps", Value = "Foceps" });
            items.Add(new SelectListItem { Text = "Vaccum", Value = "Vaccum" });
            items.Add(new SelectListItem { Text = "Caesserean", Value = "Caesserean" });
            return items;
        }
        public static List<SelectListItem> MedicineRouteRX()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            OncologyEMR.Oncology.OncologyEMRClient comser = new OncologyEMR.Oncology.OncologyEMRClient();
            IEnumerable<OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstItem> Remarklst;
            Remarklst = comser.GetRouteList();

            for (int i = 0; i <= ((OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstItem[])(Remarklst)).Length - 1; i++)
            {
                var val = ((OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstItem[])(Remarklst))[i].Value;
                var text = ((OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstItem[])(Remarklst))[i].Text;
                items.Add(new SelectListItem { Text = text, Value = val });
            }

            return items;
        }
        // Execute ex = new Execute();
        public List<SelectListItem> fillcombo(DataTable combotable)
        {
            List<SelectListItem> items = new List<SelectListItem>();
            foreach (DataRow row in combotable.Rows)
            {
                items.Add(new SelectListItem { Text = row[1].ToString(), Value = row[0].ToString() });
            }
            return items;
        }

        public static string getHeaderFooterExcel(string frmName, string frmDate, string toDate)
        {
            string HospName = System.Web.HttpContext.Current.Session["HOSPITALNAME"].ToString();
            string HospAdd = System.Web.HttpContext.Current.Session["HOSPITALADDRESS"].ToString();
            //string img = HttpContext.Application["HOSPLOGO"].ToString();
            //userid = HttpContext.Current.Session["UserID"].ToString();
            string formheader = frmName;
            if (frmDate != "" && toDate != "")
            {
                if (frmDate == toDate)
                {
                    formheader += " - For " + frmDate; ;
                }
                else
                {
                    formheader += " - From " + frmDate + " To " + toDate;
                }
            }
            //  else data.Rows[0]["ForDate"] = "";
            string strHeader = " <table><tr><th scope='col'>" + HospName + "</th></tr><tr><th scope='col'>" + HospAdd + "</th></tr><th scope='col'><td>" + formheader + "</th></tr></table>";
            return strHeader;
        }
        //public string GetMaxValue(string FieldName)
        //{
        //    ex = new Execute();
        //    string SQLQUERY = "";
        //    SQLQUERY = "SELECT CURRENTNO frOM DOCUMENTNO where DOCUMENT ='" + FieldName + "' ";
        //    string Field1Value = ex.ExecuteScalar(SQLQUERY);
        //    return Field1Value;
        //}
        public List<SelectListItem> fillcombo(DataSet comboSET)
        {
            DataTable combotable = comboSET.Tables[0];
            List<SelectListItem> items = new List<SelectListItem>();
            foreach (DataRow row in combotable.Rows)
            {
                items.Add(new SelectListItem { Text = row[1].ToString().Trim(), Value = row[0].ToString().Trim() });
            }

            return items;

        }
        public enum SetModule
        {
            Admin = 1, NS = 02, IP = 3, OP = 4, HC = 5, Laboratory = 6, Purchase = 7, Store = 8,
            BloodBank = 9, Personal = 10, ICU = 23
        }
        public string ConvertToString(object input)
        {
            if (input == null)
                return String.Empty;

            string newString = Convert.ToString(input).Trim();
            return newString;

        }

        public static string CheckSingleQuote(object input)
        {
            if (input == null)
                return String.Empty;

            string newString = Convert.ToString(input).Trim();
            newString = newString.Replace("'", "''");
            return newString;

        }
        public static string CheckDblToSingleQuote(object input)
        {
            if (input == null)
                return String.Empty;

            string newString = Convert.ToString(input).Trim();
            newString = newString.Replace("''", "'");
            return newString;

        }
        //public string GetMaxValueFromDocument(string FieldName1, int MaxLngth, string WhereClause = "") //TextBox txtBox,
        //{
        //    string strmaxvalue = "";

        //    Execute EXECUTE = new Execute();
        //    strmaxvalue = EXECUTE.ExecuteScalar("CALL SP_DOCUMENTNO ('" + FieldName1 + "')");
        //    if (strmaxvalue.Trim() == "")
        //    {
        //        strmaxvalue = "0";

        //    }
        //    strmaxvalue = Convert.ToString(Convert.ToInt64("0" + strmaxvalue) + 1);
        //    if (MaxLngth > 0)
        //    {

        //        strmaxvalue = strmaxvalue.PadLeft(MaxLngth, '0');
        //    }
        //    return strmaxvalue;

        //}


        //public DataTable GetPatientCatData(string patCatg) //TextBox txtBox,
        //{
        //    DataTable patcatdata = new DataTable();

        //    Execute EXECUTE = new Execute();
        //    patcatdata = EXECUTE.FillDataTable("SELECT * FROM ADMPATCATGMST WHERE PATCATGCD ='" + patCatg.ToUpper() + "'");
        //    return patcatdata;

        //}


        //public string GetSaluData(string SALUCODE) //TextBox txtBox,
        //{
        //    string Gender = "";
        //    Execute EXECUTE = new Execute();

        //    Gender = EXECUTE.ExecuteScalar("SELECT DEFASEX FROM ADMSALUMST WHERE SALUCODE = '" + SALUCODE + "'");
        //    return Gender;

        //}

        //public DataTable GetCityData(string CITYCODE) //TextBox txtBox,
        //{
        //    DataTable citydata = new DataTable();
        //    Execute EXECUTE = new Execute();

        //    citydata = EXECUTE.FillDataTable("SELECT CITYCODE as Code, CITYNAME as Name,Distcode as District,Regicode as State,Councode as Country, STATUS FROM ADMCITYMST WHERE STATUS='A' AND  CITYCODE ='" + CITYCODE + "'");
        //    return citydata;

        //}


        //public string GetSetupValue(string SetupName) //TextBox txtBox,
        //{
        //    string SetupVal = "";

        //    Execute EXECUTE = new Execute();
        //    SetupVal = EXECUTE.ExecuteScalar("SELECT SETUPVAL FROM BOHOSPSTNG WHERE UPPER(SETUPNAME)='" + SetupName.ToUpper() + "'");
        //    return SetupVal.Trim();

        //}

        //public string GetandUpdateFieldValue(string strFldName, string strFldValue, int AccessMaxLength, Int16 incrment = 1)
        //{
        //    String strmaxvalue = "";
        //    string Strret = "";
        //    Execute EXECUTE = new Execute();
        //    strmaxvalue = EXECUTE.ExecuteScalar("CALL SP_DOCUMENTNO ('" + strFldName + "')");

        //    if (incrment > 1)
        //    {
        //        strFldValue = Convert.ToString(Convert.ToInt16("0" + strFldValue) + incrment);

        //    }
        //    else
        //    {
        //        strFldValue = Convert.ToString(Convert.ToInt16("0" + strFldValue) + 1);
        //    }

        //    return Strret;

        //}
        public static string GetDate(string dbDate)
        {
            string RawDate = "";
            try
            {
                if (dbDate.Length == 8) RawDate = dbDate.Substring(6, 2) + "/" + dbDate.Substring(4, 2) + "/" + dbDate.Substring(0, 4); else RawDate = "";
                return RawDate;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static string ConvertDateWithTimeTo12Hour(string dateTimeStr)
        {
            if (string.IsNullOrWhiteSpace(dateTimeStr))
                return dateTimeStr;

            string[] parts = dateTimeStr.Trim().Split(new[] { " - " }, StringSplitOptions.None);
            if (parts.Length != 2) return dateTimeStr;

            string datePart = parts[0].Trim();
            string timePart = parts[1].Trim();

            DateTime timeValue;
            if (DateTime.TryParse(timePart, out timeValue))
            {
                string formattedTime = timeValue.ToString("hh:mm tt");
                return datePart + " - " + formattedTime;
            }


            return dateTimeStr;
        }

        public static string GetAge(string DtDob, string BillDTget = "")
        {
            if (DtDob != "" && DtDob != "00/00/0000")
            {
                //CommonServiceClient com = new CommonServiceClient();

                DateTime dt = DateTime.Today;

                if ("" + BillDTget != "") { dt = DateTime.ParseExact(BillDTget, @"dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture); }

                DateTime dob = DateTime.ParseExact(DtDob, @"dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);// Convert.ToDateTime(DtDob);
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
            }
            else
            {
                return "";
            }
        }

        public static string GetUIDateFormat(string dbDate, DateModes dateFormatMode)
        {

            bool val = System.Text.RegularExpressions.Regex.IsMatch(dbDate, @"\d");
            if (val == true)
            {
                string uiDate = "";
                string year = "";
                string month = "";
                string day = "";
                try
                {
                    if (dbDate.Trim().Length == 8)
                    {
                        year = dbDate.Trim().Substring(0, 4);
                        month = dbDate.Trim().Substring(4, 2);
                        day = dbDate.Trim().Substring(6, 2);
                        if (dateFormatMode == DateModes.DATEWITHSEPARATOR_YYYYMMDD)
                        {
                            uiDate = year + "/" + month + "/" + day;
                        }
                        else if (dateFormatMode == DateModes.DATEWITHSEPARATOR_DDMMYYYY)
                        {
                            uiDate = (day + "/" + month + "/" + year).ToString();
                        }
                        else if (dateFormatMode == DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD)
                        {
                            uiDate = year + month + day;
                        }
                    }
                    return uiDate;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                return dbDate;
            }

        }
        public static string GetDateInSpecifiedFormat(string givenDate, DateModes mode)
        {
            string resultant = "";
            if ((givenDate + "").ToString().Trim() != "")
            {
                char[] splitChar = null;

                string date1 = givenDate;
                // givenDate = CDate(givenDate).ToString("dd/MM/yyyy")
                if (givenDate.Contains("/"))
                {
                    splitChar = new char[] { Convert.ToChar("/") };
                }
                else if (givenDate.Contains("-"))
                {
                    splitChar = new char[] { Convert.ToChar("-") };
                }
                else
                {
                    //Return givenDate
                    //Exit Function
                }

                string[] splitVal = givenDate.TrimStart().Split(splitChar);

                if (splitVal.Length == 3)
                {
                    if (mode == DateModes.DayMode)
                    {
                        resultant = splitVal[0];
                    }
                    else if (mode == DateModes.MonthMode)
                    {
                        resultant = splitVal[1];
                    }
                    else if (mode == DateModes.YearMode)
                    {
                        resultant = splitVal[2];
                    }
                    else if (mode == DateModes.DATEWITHOUTSEPARATOR_DDMMYYYY)
                    {
                        resultant = splitVal[0] + splitVal[1] + splitVal[2];
                    }
                    else if (mode == DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD)
                    {
                        if (splitVal[0].Length == 4)
                        {
                            resultant = splitVal[0] + splitVal[1] + splitVal[2];
                        }
                        else
                        {
                            resultant = splitVal[2] + splitVal[1] + splitVal[0];
                        }
                    }
                    else if (mode == DateModes.DATEWITHSEPARATOR_DDMMYYYY)
                    {
                        resultant = splitVal[0] + "/" + splitVal[1] + "/" + splitVal[2];
                    }

                }
            }
            return resultant;
        }
        public static string GetCodeFromComboBox(string strComboString)
        {
            if (strComboString.ToString().Trim() != "" && ("" + strComboString).Contains(" ") == true)
            {
                strComboString = strComboString.ToString().Trim().Substring(strComboString.ToString().Trim().LastIndexOf(' '), (strComboString.ToString().Trim().Length - strComboString.ToString().Trim().LastIndexOf(' '))).Trim();
            }
            return strComboString;
        }
        public static string GetNameFromComboByCode<T>(IEnumerable<T> data, string code)
        {
            if (code.Trim() != "")
            {
                foreach (var type in data)
                {
                    if (type.GetType().GetProperty("Value").GetValue(type, null).ToString().Trim() == code.Trim())
                    {
                        return type.GetType().GetProperty("Text").GetValue(type, null).ToString().Trim();
                    }
                }
            }
            return "";
        }
        public static string GetPatGender(string gener)
        {
            if (gener == "M")
            {
                return "Male";
            }
            else if (gener == "F")
            {
                return "Female";
            }
            return "Other";
        }
        public static string GetStatus(string status)
        {
            switch (status)
            {
                case "A":
                    return "Active";
                case "C":
                    return "Cancelled";

                case "I":
                    return "Inactive";
                case "W":
                    return "Working";
                case "P":
                    return "Pending";
                case "R":
                    return "Rejected";
                case "S":
                    return "Sanctioned";

                default:
                    return "";

            }
        }

        public static string GetAction(string action)
        {
            switch (action)
            {
                case "N":
                    return "New";
                case "U":
                    return "Edit";
                case "E":
                    return "Edit";
                case "C":
                    return "Cancel";
                case "V":
                    return "Verify";
                case "I":
                    return "Issue";
                default:
                    return "";
            }
        }

        public static byte[] GetBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }

        public static string GetWeekDay(string AppUIDate)
        {
            var convertedDate = GetDate(AppUIDate);                                    //appUIDate in YYYYMMDD format
            DateTime date = DateTime.ParseExact(convertedDate, @"dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture.DateTimeFormat);
            string DayofWeek = date.DayOfWeek.ToString();
            switch (DayofWeek.ToUpper())
            {
                case "SUNDAY":
                    {
                        DayofWeek = "1";
                        break;
                    }
                case "MONDAY":
                    {
                        DayofWeek = "2";
                        break;
                    }
                case "TUESDAY":
                    {
                        DayofWeek = "3";
                        break;
                    }
                case "WEDNESDAY":
                    {
                        DayofWeek = "4";
                        break;
                    }
                case "THURSDAY":
                    {
                        DayofWeek = "5";
                        break;
                    }
                case "FRIDAY":
                    {
                        DayofWeek = "6";
                        break;
                    }
                case "SATURDAY":
                    {
                        DayofWeek = "7";
                        break;
                    }
            }
            return DayofWeek;
        }
        public enum modes
        {
            NewMode = 1,
            EditMode = 2,
            CancelMode = 3,
            ViewMode = 4,
            PrintMode = 5,
            VerifyMode = 6,
            ClosedMode = 7,
            RejectMode = 8,
        };

        public enum DateModes
        {
            DayMode,
            MonthMode,
            YearMode,
            DATEWITHOUTSEPARATOR_DDMMYYYY,
            DATEWITHOUTSEPARATOR_YYYYMMDD,
            DATEWITHSEPARATOR_YYYYMMDD,
            DATEWITHSEPARATOR_DDMMYYYY
        };


        public static string GetAdmnStatus(string status)
        {
            switch (status)
            {
                case "A": return "Admitted";
                case "C": return "Cancelled";
                case "D": return "Discharged";
                case "I": return "InActive";
                case "Admitted": return "A";
                case "Cancelled": return "C";
                case "Discharged": return "D";
                case "InActive": return "I";
                default: return "";
            }
        }

        public static string getHeader(string formName, string frmDate, string toDate, string filtYN = "N")
        {
            string strHeader = formName;
            if (frmDate == "" || toDate == "")
                return strHeader;
            if (frmDate == toDate)
            {
                strHeader = formName + " For " + frmDate;
            }
            else
            {
                strHeader = formName + " From " + frmDate + " To " + toDate;
            }
            // if (filtYN == "Y") { strHeader += "*"; }
            return strHeader;
        }

        //public static DataTable getHeaderFooter(string frmName, string frmDate, string toDate, string duplicate = null, string PrintedBy = "")
        //{
        public static DataTable getHeaderFooter(string frmName, string frmDate, string toDate, string duplicate = null, string PrintedBy = "", string LetterHeaderYN = "N", string LetterHeadFName = "", string LetterFootFName = "")
        {
            string HospName = HttpContext.Current.Session["HOSPITALNAME"].ToString();
            string HospAdd = HttpContext.Current.Session["HOSPITALADDRESS"].ToString();
            string HospLogo = HttpContext.Current.Session["HOSPLOGO"].ToString();
            string Duplicate = HttpContext.Current.Application["DUPLICATE"].ToString();
            string Cancel = HttpContext.Current.Application["CANCEL"].ToString();
            string createdBy = PrintedBy == "" ? ("" + HttpContext.Current.Session["gOncoUserId"]).ToString() : PrintedBy;

            DataTable data = new DataTable();
            data.Columns.Add("HospName");
            data.Columns.Add("HospAdd");
            data.Columns.Add("HospLogo", System.Type.GetType("System.Byte[]"));
            data.Columns.Add("ForDate");
            data.Columns.Add("PrintDateTime");
            data.Columns.Add("PrintedBy");
            data.Columns.Add("FormName");
            data.Columns.Add("Duplicate", System.Type.GetType("System.Byte[]"));
            data.Columns.Add("ImageLetterYN");
            data.Columns.Add("ImgLetterHeader", System.Type.GetType("System.Byte[]"));
            data.Columns.Add("ImgLetterFooter", System.Type.GetType("System.Byte[]"));
            data.Rows.Add(1);
            data.Rows[0]["HospName"] = HospName;
            data.Rows[0]["HospAdd"] = HospAdd;
            //byte[] b = File.ReadAllBytes(HospLogo);
            //data.Rows[0]["HospLogo"] = b;
            data.Rows[0]["FormName"] = frmName;

            FileStream fs;
            fs = new FileStream(HospLogo, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            byte[] Image = new byte[fs.Length];
            fs.Read(Image, 0, Convert.ToInt32(fs.Length));
            data.Rows[0]["HospLogo"] = Image;

            if (duplicate == "Y")
            {
                fs = new FileStream(Duplicate, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            }
            else fs = new FileStream(Cancel, System.IO.FileMode.Open, System.IO.FileAccess.Read);

            byte[] DupImage = new byte[fs.Length];
            if (duplicate == "Y" || duplicate == "C")
            {
                fs.Read(DupImage, 0, Convert.ToInt32(fs.Length));
                data.Rows[0]["Duplicate"] = DupImage;
            }
            else
            {
                fs.Read(DupImage, 0, 5);
                data.Rows[0]["Duplicate"] = DupImage;
            }


            fs.Close();
            if (frmDate.Trim() != "" || toDate.Trim() != "")
            {
                if (frmDate == toDate)
                {
                    data.Rows[0]["ForDate"] = "- For " + frmDate; ;
                }
                else
                {
                    data.Rows[0]["ForDate"] = "- From " + frmDate + " To " + toDate;
                }
            }
            else { data.Rows[0]["ForDate"] = ""; }
            data.Rows[0]["PrintDateTime"] = DateTime.Now.ToString("dd/MM/yyyy - HH:mm");
            data.Rows[0]["PrintedBy"] = createdBy;

            data.Rows[0]["ImageLetterYN"] = "N";
            byte[] ImgLetterHeader = new byte[0];
            byte[] ImgLetterFooter = new byte[0];
            string SpecLetterHeadPath = GetImageUnitWise(LetterHeadFName);
            string SpecLetterFootPath = GetImageUnitWise(LetterFootFName);
            if (LetterHeaderYN == "Y")
            {
                if (SpecLetterHeadPath != "" || SpecLetterFootPath != "")
                {
                    data.Rows[0]["ImageLetterYN"] = "Y";
                    if (SpecLetterHeadPath != "")
                    {
                        fs = new FileStream(SpecLetterHeadPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                        ImgLetterHeader = new byte[fs.Length];
                        fs.Read(ImgLetterHeader, 0, Convert.ToInt32(fs.Length));
                    }
                    if (SpecLetterFootPath != "")
                    {
                        fs = new FileStream(SpecLetterFootPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                        ImgLetterFooter = new byte[fs.Length];
                        fs.Read(ImgLetterFooter, 0, Convert.ToInt32(fs.Length));
                    }
                }
                else
                {
                    string ComLetterHeadPath = GetImageUnitWise(GetAppsettingUnitWiseValue("GLOBALLETTERHEADFNAME"));
                    string ComLetterFootPath = GetImageUnitWise(GetAppsettingUnitWiseValue("GLOBALLETTERFOOTFNAME"));
                    if (ComLetterHeadPath != "" || ComLetterFootPath != "")
                    {
                        data.Rows[0]["ImageLetterYN"] = "Y";
                        if (ComLetterHeadPath != "")
                        {
                            fs = new FileStream(ComLetterHeadPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                            ImgLetterHeader = new byte[fs.Length];
                            fs.Read(ImgLetterHeader, 0, Convert.ToInt32(fs.Length));
                        }
                        if (ComLetterFootPath != "")
                        {
                            fs = new FileStream(ComLetterFootPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                            ImgLetterFooter = new byte[fs.Length];
                            fs.Read(ImgLetterFooter, 0, Convert.ToInt32(fs.Length));
                        }
                    }
                }
            }
            data.Rows[0]["ImgLetterHeader"] = ImgLetterHeader;
            data.Rows[0]["ImgLetterFooter"] = ImgLetterFooter;
            return data;
        }

        public static DataTable CreateDataTableforSearch(string tablename, string[,] searchdata)
        {
            DataTable data = new DataTable();
            for (int i = 0; i <= (searchdata.Length / 2) - 1; i++)
            {
                data.Columns.Add(searchdata[i, 0]);
            }
            data.Rows.Add(1);
            for (int i = 0; i <= (searchdata.Length / 2) - 1; i++)
            {
                data.Rows[0][searchdata[i, 0]] = searchdata[i, 1];
            }
            data.TableName = tablename;
            return data;
        }

        public static string CalculateDOBFromAge(string age)
        {
            string[] strAge = age.Split(':');
            DateTime dt = DateTime.Now;
            if (strAge.Length == 3)
                dt = dt.AddYears(-Convert.ToInt16(strAge[0])).AddMonths(-Convert.ToInt16(strAge[1])).AddDays(-Convert.ToInt16(strAge[2]));
            else if (strAge.Length == 2)
                dt = dt.AddYears(-Convert.ToInt16(strAge[0])).AddMonths(-Convert.ToInt16(strAge[1]));
            else if (strAge.Length == 1)
                dt = dt.AddYears(-Convert.ToInt16(strAge[0]));

            return dt.ToString("dd/MM/yyyy");
        }

        public DataTable CreateDataTablefroFormData(string tableName, DataTable table)
        {
            DataTable mergetable = new DataTable();
            //DataRow[] row = table.Select("name = '__VIEWSTATE'");
            //foreach (DataRow r in row)
            //{
            //    r.Delete();
            //}
            for (int i = 0; i <= table.Rows.Count - 1; i++)
            {
                //if (Convert.ToString(table.Rows[i][0]).Trim() != "__VIEWSTATE")
                //{
                //    mergetable.Columns.Add(Convert.ToString(table.Rows[i][0]));
                //}
                //else
                //{
                //    table.Rows.RemoveAt(i);
                //}
                if (table.Rows[i][0].ToString().Contains("__"))
                {
                    table.Rows.RemoveAt(i);
                    i -= 1;
                }
                else
                {
                    DataColumnCollection columns = mergetable.Columns;

                    if (columns.Contains(Convert.ToString(table.Rows[i][0])))
                    {
                        table.Rows.RemoveAt(i);
                        i -= 1;
                    }
                    else
                        mergetable.Columns.Add(Convert.ToString(table.Rows[i][0]));
                }
            }
            mergetable.Rows.Add();
            for (int i = 0; i <= table.Rows.Count - 1; i++)
            {
                if (Convert.ToString(table.Rows[i][0]).Trim() != "__VIEWSTATE")
                {
                    mergetable.Rows[0][i] = table.Rows[i][1];
                }
            }

            mergetable.TableName = tableName;
            return mergetable;
        }


        public string GetAccountYear(string StrDate)
        {
            string StrMonth = "";
            string StrYearCode = "";
            string strYear = "";
            string currDate = "";
            string gAccPeriodFrom = "";
            string gAccPeriodTo = "";

            currDate = GetDateInSpecifiedFormat(StrDate, DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strYear = currDate.Substring(0, 4);
            StrMonth = currDate.Substring(4, 2);
            if (int.Parse(StrMonth) >= 4 && int.Parse(StrMonth) <= 12)
            {
                StrYearCode = strYear.PadLeft(4, '0') + "-" + (int.Parse(strYear) + 1).ToString().PadLeft(4, '0');
                gAccPeriodFrom = StrYearCode.Substring(0, 4) + "0701";
                gAccPeriodTo = StrYearCode.Substring(0, 4) + "0630";
            }
            else
            {
                StrYearCode = (int.Parse(strYear) - 1).ToString().PadLeft(4, '0') + "-" + strYear.PadLeft(4, '0');
            }
            return StrYearCode;
        }



        public static string AmountToWord(string inputAmount)
        {
            string[] strCol = inputAmount.Split('.');
            string AmtinWord = "";
            if (strCol.Length > 0 && Convert.ToInt32(strCol[0]) > 0)
            {
                AmtinWord = NumbersToWords(Convert.ToInt32(strCol[0])) + " Rupees";
            }
            if (strCol.Length > 1 && Convert.ToInt32(strCol[1]) > 0)
            {
                AmtinWord = AmtinWord + " And " + NumbersToWords(Convert.ToInt32(strCol[1])) + " Paise";
            }
            if (AmtinWord.Trim() != "")
            { AmtinWord = AmtinWord + " Only"; }
            return AmtinWord;
        }

        public static string NumbersToWords(int inputNumber)
        {
            int inputNo = inputNumber;

            if (inputNo == 0)
                return "Zero";

            int[] numbers = new int[4];
            int first = 0;
            int u, h, t;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            if (inputNo < 0)
            {
                sb.Append("Minus ");
                inputNo = -inputNo;
            }

            string[] words0 = {"" ,"One ", "Two ", "Three ", "Four ",
            "Five " ,"Six ", "Seven ", "Eight ", "Nine "};
            string[] words1 = {"Ten ", "Eleven ", "Twelve ", "Thirteen ", "Fourteen ",
            "Fifteen ","Sixteen ","Seventeen ","Eighteen ", "Nineteen "};
            string[] words2 = {"Twenty ", "Thirty ", "Forty ", "Fifty ", "Sixty ",
            "Seventy ","Eighty ", "Ninety "};
            string[] words3 = { "Thousand ", "Lakh ", "Crore " };

            numbers[0] = inputNo % 1000; // units
            numbers[1] = inputNo / 1000;
            numbers[2] = inputNo / 100000;
            numbers[1] = numbers[1] - 100 * numbers[2]; // thousands
            numbers[3] = inputNo / 10000000; // crores
            numbers[2] = numbers[2] - 100 * numbers[3]; // lakhs

            for (int i = 3; i > 0; i--)
            {
                if (numbers[i] != 0)
                {
                    first = i;
                    break;
                }
            }
            for (int i = first; i >= 0; i--)
            {
                if (numbers[i] == 0) continue;
                u = numbers[i] % 10; // ones
                t = numbers[i] / 10;
                h = numbers[i] / 100; // hundreds
                t = t - 10 * h; // tens
                if (h > 0) sb.Append(words0[h] + "Hundred ");
                if (u > 0 || t > 0)
                {
                    if (h > 0 || i == 0) if (sb.Length > 0) sb.Append("and ");
                    if (t == 0)
                        sb.Append(words0[u]);
                    else if (t == 1)
                        sb.Append(words1[u]);
                    else
                        sb.Append(words2[t - 2] + words0[u]);
                }
                if (i != 0) sb.Append(words3[i - 1]);
            }
            return sb.ToString().TrimEnd();
        }

        public static string GetLvAppStatus(string status)
        {
            switch (status)
            {
                case "C":
                    return "Cancelled";
                case "R":
                    return "Rejected";
                case "S":
                    return "Sanctioned";
                case "I":
                    return "Issued";
                case "P":
                    return "Pending";

                default:
                    return "";

            }
        }

        public static DataTable GetSearchFilterData(string searchCriteria, string FilterCriteria, int NoOFRecords)
        {
            DataTable SearchFilterDt = new DataTable();
            SearchFilterDt.Columns.Add("SearchCriteria");
            SearchFilterDt.Columns.Add("FilterCriteria");
            SearchFilterDt.Columns.Add("NoOfRecords");
            DataRow dr1 = SearchFilterDt.NewRow();
            DataTable FilterDt = new DataTable();
            string filterText = "";
            if (FilterCriteria == null || FilterCriteria == "")
            {
                filterText += "N/A";
            }
            else
                FilterDt = JsonConvert.DeserializeObject<DataTable>(FilterCriteria);
            foreach (DataRow dr in FilterDt.Rows)
            {
                if (dr[0].ToString().Trim().ToString().Trim() == "STATUS")
                {
                    filterText += dr[0].ToString().Trim() + " : " + (dr[2].ToString().Trim() == "A" ? "Active" : "Cancel" + " ,  ");
                }
                else
                    filterText += dr[0].ToString().Trim() + " : " + dr[2].ToString() + ",  ";
            }

            filterText = filterText.Trim();
            if (filterText != "" && FilterDt.Rows.Count > 0)
            {
                filterText = filterText.Substring(0, filterText.Length - 1);
            }

            if (searchCriteria == "")
                searchCriteria = "N/A";
            dr1["SearchCriteria"] = searchCriteria;
            dr1["FilterCriteria"] = filterText;
            dr1["NoOfRecords"] = NoOFRecords;
            SearchFilterDt.Rows.Add(dr1);
            SearchFilterDt.TableName = "FilterTable";
            return SearchFilterDt;
        }

        public static string calPostOperDays(string strSurgDt, string strSelDate)
        {
            //string toDate = GeneralFunction.GetDate(strSelDate.ToString());

            DateTime surgdt = DateTime.ParseExact(strSurgDt, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime selDate = DateTime.ParseExact(strSelDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            //DateTime selDate = Convert.ToDateTime(toDate);

            TimeSpan t = selDate - surgdt;
            var postOPDays = t.Days;

            postOPDays = postOPDays - 1;

            if (postOPDays < 0)
                postOPDays = 0;

            return postOPDays.ToString();
        }


        public static List<SelectListItem> MedicineType()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "INJ", Value = "INJ" });
            items.Add(new SelectListItem { Text = "TAB", Value = "TAB" });
            items.Add(new SelectListItem { Text = "CAP", Value = "CAP" });
            items.Add(new SelectListItem { Text = "SYR", Value = "SYR" });
            items.Add(new SelectListItem { Text = "IV", Value = "IV" });
            items.Add(new SelectListItem { Text = "UNG", Value = "UNG" });
            items.Add(new SelectListItem { Text = "GTT", Value = "GTT" });
            items.Add(new SelectListItem { Text = "SOL", Value = "SOL" });
            items.Add(new SelectListItem { Text = "NS", Value = "NS" });
            items.Add(new SelectListItem { Text = "PULV", Value = "PULV" });
            items.Add(new SelectListItem { Text = "TAB(MD)", Value = "TAB(MD)" });
            items.Add(new SelectListItem { Text = "ACCUHALER", Value = "ACCUHALER" });
            items.Add(new SelectListItem { Text = "BILAYER COATED TAB", Value = "BILAYER COATED TAB" });
            items.Add(new SelectListItem { Text = "CAP", Value = "CAP" });
            items.Add(new SelectListItem { Text = "CAPLET", Value = "CAPLET" });
            items.Add(new SelectListItem { Text = "CAPTAB", Value = "CAPTAB" });
            //items.Add(new SelectListItem { Text = "CHEWABLE T", Value = "CHEWABLE T" });
            items.Add(new SelectListItem { Text = "CHEWABLE TAB", Value = "CHEWABLE TAB" });
            items.Add(new SelectListItem { Text = "COATED TAB", Value = "COATED TAB " });
            items.Add(new SelectListItem { Text = "CR TAB", Value = "CR TAB" });


            items.Add(new SelectListItem { Text = "CREAM", Value = "CREAM" });
            items.Add(new SelectListItem { Text = "DENTAL SOL", Value = "DENTAL SOL" });
            items.Add(new SelectListItem { Text = "DISPERTAB", Value = "DISPERTAB" });
            items.Add(new SelectListItem { Text = "DR TAB", Value = "DR TAB" });
            items.Add(new SelectListItem { Text = "DRY SYR", Value = "DRY SYR" });
            items.Add(new SelectListItem { Text = "EAR DROPS", Value = "EAR DROPS" });
            items.Add(new SelectListItem { Text = "ENTERIC-COATED CAP", Value = "ENTERIC-COATED CAP" });
            items.Add(new SelectListItem { Text = "ENTERIC-COATED TAB", Value = "ENTERIC-COATED TAB" });
            items.Add(new SelectListItem { Text = "ER CAP", Value = "ER CAP" });


            items.Add(new SelectListItem { Text = "ER TAB", Value = "ER TAB" });
            items.Add(new SelectListItem { Text = "EXTENTAB", Value = "EXTENTAB" });
            items.Add(new SelectListItem { Text = "EYE DROPS", Value = "EYE DROPS" });
            //items.Add(new SelectListItem { Text = "EYE/EAR DR", Value = "EYE/EAR DR" });
            items.Add(new SelectListItem { Text = "EYE/EAR DROPS", Value = "DRY SYR" });
            items.Add(new SelectListItem { Text = "FILM-COATED TAB", Value = "EFILM-COATED TAB" });
            items.Add(new SelectListItem { Text = "FLEXPEN", Value = "FLEXPEN" });
            items.Add(new SelectListItem { Text = "GARGLE", Value = "GARGLE" });
            items.Add(new SelectListItem { Text = "GRANULES FOR ORAL SO", Value = "GRANULES FOR ORAL SO" });
            items.Add(new SelectListItem { Text = "GTT", Value = "GTT" });


            items.Add(new SelectListItem { Text = "INFUSION", Value = "INFUSION" });
            items.Add(new SelectListItem { Text = "INHALATION LIQD CAP", Value = "INHALATION LIQD CAP" });
            items.Add(new SelectListItem { Text = "INHALER", Value = "INHALER" });
            items.Add(new SelectListItem { Text = "INJ", Value = "INJ" });
            items.Add(new SelectListItem { Text = "IV", Value = "IV" });
            items.Add(new SelectListItem { Text = "JELLY", Value = "JELLY" });
            items.Add(new SelectListItem { Text = "KIT", Value = "KIT" });
            items.Add(new SelectListItem { Text = "LOTION", Value = "LOTION" });
            items.Add(new SelectListItem { Text = "LOZ ", Value = "LOZ" });
            items.Add(new SelectListItem { Text = "MDI", Value = "MDI" });


            items.Add(new SelectListItem { Text = "MODIFIED-RELEASE CAP", Value = "MODIFIED-RELEASE CAP" });
            items.Add(new SelectListItem { Text = "MODIFIED-RELEASE TAB", Value = "MODIFIED-RELEASE TAB" });
            items.Add(new SelectListItem { Text = "NASAL AERP", Value = "NASAL AERO" });
            items.Add(new SelectListItem { Text = "NASAL DROP", Value = "NASAL DROP" });
            items.Add(new SelectListItem { Text = "NASAL DROPS", Value = "NASAL DROPS" });
            items.Add(new SelectListItem { Text = "NASAL SPRAY", Value = "NASAL SPRAY" });
            items.Add(new SelectListItem { Text = "NEB", Value = "NEB" });
            items.Add(new SelectListItem { Text = "NOVOLET", Value = "NOVOLET" });
            items.Add(new SelectListItem { Text = "NS", Value = "NS" });
            items.Add(new SelectListItem { Text = "OIL ", Value = "OIL" });
            items.Add(new SelectListItem { Text = "OINT", Value = "OINT" });

            items.Add(new SelectListItem { Text = "ORAL DROPS", Value = "ORAL DROPS" });
            items.Add(new SelectListItem { Text = "ORAL EMULSION", Value = "ORAL EMULSION" });
            items.Add(new SelectListItem { Text = "ORAL GEL", Value = "ORAL GEL" });
            items.Add(new SelectListItem { Text = "ORAL LIQD", Value = "ORAL LIQD" });
            items.Add(new SelectListItem { Text = "ORAL SOLN", Value = "ORAL SOLN" });
            items.Add(new SelectListItem { Text = "ORAL SUSP", Value = "ORAL SUSP" });
            items.Add(new SelectListItem { Text = "ORAPASTE", Value = "ORAPASTE" });
            items.Add(new SelectListItem { Text = "PENFILL", Value = "PENFILL" });
            items.Add(new SelectListItem { Text = "PESSARY", Value = "PESSARY" });


            items.Add(new SelectListItem { Text = "POWD FOR INJ", Value = "POWD FOR INJ" });
            items.Add(new SelectListItem { Text = "POWD FOR ORAL SOLN", Value = "POWD FOR ORAL SOLN" });
            items.Add(new SelectListItem { Text = "POWD FOR ORAL SUSP", Value = "POWD FOR ORAL SUSP" });
            items.Add(new SelectListItem { Text = "PRE-FILLED PEN", Value = "PRE-FILLED PEN" });
            items.Add(new SelectListItem { Text = "PULV", Value = "PULV" });
            items.Add(new SelectListItem { Text = "RESPULES", Value = "RESPULES" });
            items.Add(new SelectListItem { Text = "ROTACAP", Value = "ROTACAP" });
            //items.Add(new SelectListItem { Text = "SHAMPOO ", Value = "SHAMPOO" });
            items.Add(new SelectListItem { Text = "SOFT-GELATIN CAP", Value = "SOFT-GELATIN CAP" });
            items.Add(new SelectListItem { Text = "SOFTGEL", Value = "SOFTGEL" });
            items.Add(new SelectListItem { Text = "SOL", Value = "SOL" });

            items.Add(new SelectListItem { Text = "SR CAP", Value = "SR CAP" });
            items.Add(new SelectListItem { Text = "SR COATED TAB", Value = "SR COATED TAB" });
            items.Add(new SelectListItem { Text = "SR TAB", Value = "SR TAB" });
            items.Add(new SelectListItem { Text = "SR-FC TAB", Value = "SR-FC TAB" });
            items.Add(new SelectListItem { Text = "SUBLINGUAL TAB", Value = "SUBLINGUAL TAB" });
            items.Add(new SelectListItem { Text = "SUGAR-COATED TAB", Value = "SUGAR-COATED TAB" });
            items.Add(new SelectListItem { Text = "SUSP (ORAL USE)", Value = "SUSP (ORAL USE)" });
            items.Add(new SelectListItem { Text = "SUSP FOR INJ", Value = "SUSP FOR INJ" });
            items.Add(new SelectListItem { Text = "SYR", Value = "SYR" });


            items.Add(new SelectListItem { Text = "TAB", Value = "TAB" });
            items.Add(new SelectListItem { Text = "TAB(MD)", Value = "TAB(MD)" });
            items.Add(new SelectListItem { Text = "TOPICAL GEL", Value = "TOPICAL GEL" });
            items.Add(new SelectListItem { Text = "TOPICAL POWD", Value = "TOPICAL POWD" });
            items.Add(new SelectListItem { Text = "TOPICAL SOLN", Value = "TOPICAL SOLN" });
            items.Add(new SelectListItem { Text = "UNG", Value = "UNG" });
            items.Add(new SelectListItem { Text = "VAG CAP ", Value = "VAG CAP" });
            items.Add(new SelectListItem { Text = "VAG INSERT", Value = "VAG INSERT" });
            items.Add(new SelectListItem { Text = "VAG SUPP", Value = "VAG SUPP" });
            items.Add(new SelectListItem { Text = "VAG WASH", Value = "VAG WASH" });
            items.Add(new SelectListItem { Text = "XR TAB", Value = "XR TAB" });


            return items;
        }

        public static List<SelectListItem> MedicineRoute()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Oral", Value = "Oral" });
            items.Add(new SelectListItem { Text = "Injection", Value = "Injection" });
            items.Add(new SelectListItem { Text = "Rectal", Value = "Rectal" });
            items.Add(new SelectListItem { Text = "Sublingual", Value = "Sublingual" });
            items.Add(new SelectListItem { Text = "buccal", Value = "buccal" });
            items.Add(new SelectListItem { Text = "Vaginal", Value = "Vaginal" });
            items.Add(new SelectListItem { Text = "Ocular", Value = "Ocular" });
            items.Add(new SelectListItem { Text = "Otic", Value = "Otic" });
            items.Add(new SelectListItem { Text = "Nasal", Value = "Nasal" });
            items.Add(new SelectListItem { Text = "Inhalation", Value = "Inhalation" });
            items.Add(new SelectListItem { Text = "Nebulization", Value = "Nebulization" });
            items.Add(new SelectListItem { Text = "Cutaneous", Value = "Cutaneous" });
            items.Add(new SelectListItem { Text = "Transdermal", Value = "Transdermal" });

            items.Add(new SelectListItem { Text = "OTIC", Value = "OTIC" });
            items.Add(new SelectListItem { Text = "BUCCAL", Value = "BUCCAL" });
            items.Add(new SelectListItem { Text = "CONJUNC", Value = "CONJUNC" });
            items.Add(new SelectListItem { Text = "CUTAN", Value = "CUTAN" });
            items.Add(new SelectListItem { Text = "DENTAL", Value = "DENTAL" });
            items.Add(new SelectListItem { Text = "EL-OSMOS", Value = "EL-OSMOS" });
            items.Add(new SelectListItem { Text = "E-CERVIC", Value = "E-CERVIC" });
            items.Add(new SelectListItem { Text = "E-SINUS", Value = "E-SINUS" });
            items.Add(new SelectListItem { Text = "E-TRACHE", Value = "E-TRACHE" });
            items.Add(new SelectListItem { Text = "ENTER", Value = "ENTER" });
            items.Add(new SelectListItem { Text = "EPIDUR", Value = "EPIDUR" });
            items.Add(new SelectListItem { Text = "X-AMNI", Value = "X-AMNI" });
            items.Add(new SelectListItem { Text = "X-CORPOR", Value = "X-CORPOR" });

            items.Add(new SelectListItem { Text = "HEMO", Value = "HEMO" });
            items.Add(new SelectListItem { Text = "INFIL", Value = "INFIL" });
            items.Add(new SelectListItem { Text = "INTERSTIT", Value = "INTERSTIT" });
            items.Add(new SelectListItem { Text = "I-ABDOM", Value = "I-ABDOM" });
            items.Add(new SelectListItem { Text = "I-AMNI", Value = "I-AMNI" });
            items.Add(new SelectListItem { Text = "I-ARTER", Value = "I-ARTER" });
            items.Add(new SelectListItem { Text = "I-ARTIC", Value = "I-ARTIC" });
            items.Add(new SelectListItem { Text = "I-BILI", Value = "I-BILI" });
            items.Add(new SelectListItem { Text = "I-BRONCHI", Value = "I-BRONCHI" });
            items.Add(new SelectListItem { Text = "I-BURSAL", Value = "I-BURSAL" });
            items.Add(new SelectListItem { Text = "I-CARDI", Value = "I-CARDI" });
            items.Add(new SelectListItem { Text = "I-CARTIL", Value = "I-CARTIL" });
            items.Add(new SelectListItem { Text = "I-CAUDAL", Value = "I-CAUDAL" });

            items.Add(new SelectListItem { Text = "I-CAVERN", Value = "I-CAVERN" });
            items.Add(new SelectListItem { Text = "I-CAVIT", Value = "I-CAVIT" });
            items.Add(new SelectListItem { Text = "I-CERE", Value = "I-CERE" });
            items.Add(new SelectListItem { Text = "I-CISTERN", Value = "I-CISTERN" });
            items.Add(new SelectListItem { Text = "I-CORNE", Value = "I-CORNE" });
            items.Add(new SelectListItem { Text = "I-CORONAL", Value = "I-CORONAL" });
            items.Add(new SelectListItem { Text = "I-CORONARY", Value = "I-CORONARY" });
            items.Add(new SelectListItem { Text = "I-CORPOR", Value = "I-CORPOR" });
            items.Add(new SelectListItem { Text = "I-DERMAL", Value = "I-DERMAL" });
            items.Add(new SelectListItem { Text = "I-DISCAL", Value = "I-DISCAL" });
            items.Add(new SelectListItem { Text = "I-DUCTAL", Value = "I-DUCTAL" });
            items.Add(new SelectListItem { Text = "I-DUCTAL", Value = "I-DUCTAL" });
            items.Add(new SelectListItem { Text = "I-DUOD", Value = "I-DUOD" });

            items.Add(new SelectListItem { Text = "I-DURAL", Value = "I-DURAL" });
            items.Add(new SelectListItem { Text = "I-EPIDERM", Value = "I-EPIDERM" });
            items.Add(new SelectListItem { Text = "I-ESO", Value = "I-ESO" });
            items.Add(new SelectListItem { Text = "I-GASTRIC", Value = "I-GASTRIC" });
            items.Add(new SelectListItem { Text = "I-GINGIV", Value = "I-GINGIV" });
            items.Add(new SelectListItem { Text = "I-ILE", Value = "I-ILE" });
            items.Add(new SelectListItem { Text = "I-LESION", Value = "I-LESION" });
            items.Add(new SelectListItem { Text = "I-LUMIN", Value = "I-LUMIN" });
            items.Add(new SelectListItem { Text = "I-LYMPHAT", Value = "I-LYMPHAT" });
            items.Add(new SelectListItem { Text = "I-MEDUL", Value = "I-MEDUL" });
            items.Add(new SelectListItem { Text = "I-MENIN", Value = "I-MENIN" });
            items.Add(new SelectListItem { Text = "IM", Value = "IM" });
            items.Add(new SelectListItem { Text = "I-OCUL", Value = "I-OCUL" });

            items.Add(new SelectListItem { Text = "I-OVAR", Value = "I-OVAR" });
            items.Add(new SelectListItem { Text = "I-PERICARD", Value = "I-PERICARD" });
            items.Add(new SelectListItem { Text = "I-PERITON", Value = "I-PERITON" });
            items.Add(new SelectListItem { Text = "I-PLEURAL", Value = "I-PLEURAL" });
            items.Add(new SelectListItem { Text = "I-PROSTAT", Value = "I-PROSTAT" });
            items.Add(new SelectListItem { Text = "I-PULMON", Value = "I-PULMON" });
            items.Add(new SelectListItem { Text = "I-SINAL", Value = "I-SINAL" });
            items.Add(new SelectListItem { Text = "I-SPINAL", Value = "I-SPINAL" });
            items.Add(new SelectListItem { Text = "I-SYNOV", Value = "I-SYNOV" });
            items.Add(new SelectListItem { Text = "I-TENDIN", Value = "I-TENDIN" });
            items.Add(new SelectListItem { Text = "I-TESTIC", Value = "I-TESTIC" });
            items.Add(new SelectListItem { Text = "IT", Value = "IT" });
            items.Add(new SelectListItem { Text = "I-THORAC", Value = "I-THORAC" });

            items.Add(new SelectListItem { Text = "I-TUBUL", Value = "I-TUBUL" });
            items.Add(new SelectListItem { Text = "I-TUMOR", Value = "I-TUMOR" });
            items.Add(new SelectListItem { Text = "I-ESO", Value = "I-ESO" });
            items.Add(new SelectListItem { Text = "I-TYMPAN", Value = "I-TYMPAN" });
            items.Add(new SelectListItem { Text = "I-GINGIV", Value = "I-GINGIV" });
            items.Add(new SelectListItem { Text = "I-UTER", Value = "I-UTER" });
            items.Add(new SelectListItem { Text = "I-VASC", Value = "I-VASC" });
            items.Add(new SelectListItem { Text = "IV", Value = "IV" });
            items.Add(new SelectListItem { Text = "IV BOLUS", Value = "IV BOLUS" });
            items.Add(new SelectListItem { Text = "IV DRIP", Value = "IV DRIP" });
            items.Add(new SelectListItem { Text = "I-VENTRIC", Value = "I-VENTRIC" });
            items.Add(new SelectListItem { Text = "I-VESIC", Value = "I-VESIC" });
            items.Add(new SelectListItem { Text = "I-VITRE", Value = "I-VITRE" });


            items.Add(new SelectListItem { Text = "ION", Value = "ION" });
            items.Add(new SelectListItem { Text = "IRRIG", Value = "IRRIG" });
            items.Add(new SelectListItem { Text = "LARYN", Value = "LARYN" });
            items.Add(new SelectListItem { Text = "NASAL", Value = "NASAL" });
            items.Add(new SelectListItem { Text = "NG", Value = "NG" });
            items.Add(new SelectListItem { Text = "NA", Value = "NA" });
            items.Add(new SelectListItem { Text = "OCCLUS", Value = "OCCLUS" });
            items.Add(new SelectListItem { Text = "OPHTHALM", Value = "OPHTHALM" });
            items.Add(new SelectListItem { Text = "ORAL", Value = "ORAL" });
            items.Add(new SelectListItem { Text = "ORO", Value = "ORO" });
            items.Add(new SelectListItem { Text = "OTHER", Value = "OTHER" });
            items.Add(new SelectListItem { Text = "PAREN", Value = "PAREN" });
            items.Add(new SelectListItem { Text = "PERCUT", Value = "PERCUT" });

            items.Add(new SelectListItem { Text = "P-ARTIC", Value = "P-ARTIC" });
            items.Add(new SelectListItem { Text = "P-DURAL", Value = "P-DURAL" });
            items.Add(new SelectListItem { Text = "P-NEURAL", Value = "P-NEURAL" });
            items.Add(new SelectListItem { Text = "P-ODONT", Value = "P-ODONT" });
            items.Add(new SelectListItem { Text = "RECTAL", Value = "RECTAL" });
            items.Add(new SelectListItem { Text = "RESPIR", Value = "RESPIR" });
            items.Add(new SelectListItem { Text = "RETRO", Value = "RETRO" });
            items.Add(new SelectListItem { Text = "SOFT TIS", Value = "SOFT TIS" });
            items.Add(new SelectListItem { Text = "S-ARACH", Value = "S-ARACH" });
            items.Add(new SelectListItem { Text = "S-CONJUNC", Value = "S-CONJUNC" });
            items.Add(new SelectListItem { Text = "SC", Value = "SC" });
            items.Add(new SelectListItem { Text = "SL", Value = "SL" });
            items.Add(new SelectListItem { Text = "S-MUCOS", Value = "S-MUCOS" });


            items.Add(new SelectListItem { Text = "TOPIC", Value = "TOPIC" });
            items.Add(new SelectListItem { Text = "T-DERMAL", Value = "T-DERMAL" });
            items.Add(new SelectListItem { Text = "T-MUCOS", Value = "T-MUCOS" });
            items.Add(new SelectListItem { Text = "T-PLACENT", Value = "T-PLACENT" });
            items.Add(new SelectListItem { Text = "T-TRACHE", Value = "T-TRACHE" });
            items.Add(new SelectListItem { Text = "T-TYMPAN", Value = "T-TYMPAN" });
            items.Add(new SelectListItem { Text = "UNAS", Value = "UNAS" });
            items.Add(new SelectListItem { Text = "UNKNOWN", Value = "UNKNOWN" });
            items.Add(new SelectListItem { Text = "URETER", Value = "URETER" });
            items.Add(new SelectListItem { Text = "URETH", Value = "URETH" });
            items.Add(new SelectListItem { Text = "VAGIN", Value = "VAGIN" });
            return items;
        }


        public static List<SelectListItem> TetstTimeList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "STAT", Value = "S" });
            items.Add(new SelectListItem { Text = "Today", Value = "T" });
            items.Add(new SelectListItem { Text = "Tomorrow", Value = "M" });
            items.Add(new SelectListItem { Text = "TomwMorng.", Value = "O" });
            items.Add(new SelectListItem { Text = "AftTwoDays", Value = "D" });
            return items;
        }

        //26-11-19
        public static List<SelectListItem> TSBloodProduct()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "CRYO PPT", Value = "CRYO PPT" });
            items.Add(new SelectListItem { Text = "FFP", Value = "FFP" });
            items.Add(new SelectListItem { Text = "PRBC", Value = "PRBC" });
            items.Add(new SelectListItem { Text = "RDP", Value = "RDP" });
            items.Add(new SelectListItem { Text = "SDP", Value = "SDP" });
            items.Add(new SelectListItem { Text = "SALINE WASHED PACKED CELL", Value = "SALINE WASHED PACKED CELL" });
            items.Add(new SelectListItem { Text = "WHOLE BLOOD", Value = "WHOLE BLOOD" });

            return items;
        }
        public static List<SelectListItem> DilutionVolumeChemo()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "5 ml", Value = "5 ml" });
            items.Add(new SelectListItem { Text = "10 ml", Value = "10 ml" });
            items.Add(new SelectListItem { Text = "15 ml", Value = "15 ml" });
            items.Add(new SelectListItem { Text = "20 ml", Value = "20 ml" });
            items.Add(new SelectListItem { Text = "25 ml", Value = "25 ml" });
            items.Add(new SelectListItem { Text = "50 ml", Value = "50 ml" });
            items.Add(new SelectListItem { Text = "75 ml", Value = "75 ml" });
            items.Add(new SelectListItem { Text = "100 ml", Value = "100 ml" });
            items.Add(new SelectListItem { Text = "125 ml", Value = "125 ml" });
            items.Add(new SelectListItem { Text = "150 ml", Value = "150 ml" });
            items.Add(new SelectListItem { Text = "175 ml", Value = "175 ml" });
            items.Add(new SelectListItem { Text = "200 ml", Value = "200 ml" });
            items.Add(new SelectListItem { Text = "250 ml", Value = "250 ml" });
            items.Add(new SelectListItem { Text = "275 ml", Value = "275 ml" });
            items.Add(new SelectListItem { Text = "300 ml", Value = "300 ml" });
            items.Add(new SelectListItem { Text = "400 ml", Value = "400 ml" });
            items.Add(new SelectListItem { Text = "500 ml", Value = "500 ml" });
            return items;
        }
        public static List<SelectListItem> DilutionVolume()//
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "20 ml", Value = "20ml" });
            items.Add(new SelectListItem { Text = "25 ml", Value = "25ml" });
            items.Add(new SelectListItem { Text = "50 ml", Value = "50ml" });
            items.Add(new SelectListItem { Text = "75 ml", Value = "75ml" });
            items.Add(new SelectListItem { Text = "100 ml", Value = "100ml" });
            items.Add(new SelectListItem { Text = "125 ml", Value = "125ml" });
            items.Add(new SelectListItem { Text = "150 ml", Value = "150ml" });
            items.Add(new SelectListItem { Text = "175 ml", Value = "175ml" });
            items.Add(new SelectListItem { Text = "200 ml", Value = "200ml" });
            items.Add(new SelectListItem { Text = "250 ml", Value = "250ml" });
            items.Add(new SelectListItem { Text = "275 ml", Value = "275ml" });
            items.Add(new SelectListItem { Text = "300 ml", Value = "300ml" });
            items.Add(new SelectListItem { Text = "400 ml", Value = "400ml" });
            items.Add(new SelectListItem { Text = "500 ml", Value = "500ml" });
            return items;
        }
        //adedd by Roshan 05-08-2025
        public static List<SelectListItem> DoseCalculation()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Direct", Value = "D" });
            items.Add(new SelectListItem { Text = "BSA", Value = "B" });
            items.Add(new SelectListItem { Text = "Weight", Value = "W" });
            return items;
        }
        public static List<SelectListItem> MedType()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Pre Medic", Value = "P" });
            items.Add(new SelectListItem { Text = "Chemo Medic", Value = "C" });
            items.Add(new SelectListItem { Text = "Supportive", Value = "S" });
            return items;
        }
        public static List<SelectListItem> MedicalSetNo()
        {
            List<SelectListItem> items = new List<SelectListItem>();

            for (int i = 1; i <= 50; i++)
            {
                items.Add(new SelectListItem
                {
                    Text = i.ToString(),
                    Value = i.ToString()
                });
            }
            return items;
        }
        public static List<SelectListItem> AdministrationDurationChemo()
        {
            List<SelectListItem> items = new List<SelectListItem>();

            items.Add(new SelectListItem { Text = "1 min", Value = "1 min" });
            items.Add(new SelectListItem { Text = "2 min", Value = "2 min" });
            items.Add(new SelectListItem { Text = "5 min", Value = "5 min" });
            items.Add(new SelectListItem { Text = "10 min", Value = "10 min" });
            items.Add(new SelectListItem { Text = "15 min", Value = "15 min" });
            items.Add(new SelectListItem { Text = "20 min", Value = "20 min" });
            items.Add(new SelectListItem { Text = "30 min", Value = "30 min" });

            items.Add(new SelectListItem { Text = "1 hr", Value = "1 hr" });
            items.Add(new SelectListItem { Text = "1 hr 10 min", Value = "1 hr 10 min" });
            items.Add(new SelectListItem { Text = "1 hr 15 min", Value = "1 hr 15 min" });
            items.Add(new SelectListItem { Text = "1 hr 20 min", Value = "1 hr 20 min" });
            items.Add(new SelectListItem { Text = "1 hr 30 min", Value = "1 hr 30 min" });

            items.Add(new SelectListItem { Text = "2 hr", Value = "2 hr" });
            items.Add(new SelectListItem { Text = "2 hr 10 min", Value = "2 hr 10 min" });
            items.Add(new SelectListItem { Text = "2 hr 15 min", Value = "2 hr 15 min" });
            items.Add(new SelectListItem { Text = "2 hr 20 min", Value = "2 hr 20 min" });
            items.Add(new SelectListItem { Text = "2 hr 30 min", Value = "2 hr 30 min" });

            items.Add(new SelectListItem { Text = "3 hr", Value = "3 hr" });
            items.Add(new SelectListItem { Text = "3 hr 10 min", Value = "3 hr 10 min" });
            items.Add(new SelectListItem { Text = "3 hr 15 min", Value = "3 hr 15 min" });
            items.Add(new SelectListItem { Text = "3 hr 20 min", Value = "3 hr 20 min" });
            items.Add(new SelectListItem { Text = "3 hr 30 min", Value = "3 hr 30 min" });

            items.Add(new SelectListItem { Text = "4 hr", Value = "4 hr" });
            items.Add(new SelectListItem { Text = "4 hr 10 min", Value = "4 hr 10 min" });
            items.Add(new SelectListItem { Text = "4 hr 15 min", Value = "4 hr 15 min" });
            items.Add(new SelectListItem { Text = "4 hr 20 min", Value = "4 hr 20 min" });
            items.Add(new SelectListItem { Text = "4 hr 30 min", Value = "4 hr 30 min" });

            items.Add(new SelectListItem { Text = "5 hr", Value = "5 hr" });
            items.Add(new SelectListItem { Text = "5 hr 10 min", Value = "5 hr 10 min" });
            items.Add(new SelectListItem { Text = "5 hr 15 min", Value = "5 hr 15 min" });
            items.Add(new SelectListItem { Text = "5 hr 20 min", Value = "5 hr 20 min" });
            items.Add(new SelectListItem { Text = "5 hr 30 min", Value = "5 hr 30 min" });

            items.Add(new SelectListItem { Text = "6 hr", Value = "6 hr" });
            items.Add(new SelectListItem { Text = "6 hr 10 min", Value = "6 hr 10 min" });
            items.Add(new SelectListItem { Text = "6 hr 15 min", Value = "6 hr 15 min" });
            items.Add(new SelectListItem { Text = "6 hr 20 min", Value = "6 hr 20 min" });
            items.Add(new SelectListItem { Text = "6 hr 30 min", Value = "6 hr 30 min" });

            items.Add(new SelectListItem { Text = "7 hr", Value = "7 hr" });
            items.Add(new SelectListItem { Text = "7 hr 10 min", Value = "7 hr 10 min" });
            items.Add(new SelectListItem { Text = "7 hr 15 min", Value = "7 hr 15 min" });
            items.Add(new SelectListItem { Text = "7 hr 20 min", Value = "7 hr 20 min" });
            items.Add(new SelectListItem { Text = "7 hr 30 min", Value = "7 hr 30 min" });

            items.Add(new SelectListItem { Text = "8 hr", Value = "8 hr" });
            items.Add(new SelectListItem { Text = "8 hr 10 min", Value = "8 hr 10 min" });
            items.Add(new SelectListItem { Text = "8 hr 15 min", Value = "8 hr 15 min" });
            items.Add(new SelectListItem { Text = "8 hr 20 min", Value = "8 hr 20 min" });
            items.Add(new SelectListItem { Text = "8 hr 30 min", Value = "8 hr 30 min" });

            items.Add(new SelectListItem { Text = "9 hr", Value = "9 hr" });
            items.Add(new SelectListItem { Text = "9 hr 10 min", Value = "9 hr 10 min" });
            items.Add(new SelectListItem { Text = "9 hr 15 min", Value = "9 hr 15 min" });
            items.Add(new SelectListItem { Text = "9 hr 20 min", Value = "9 hr 20 min" });
            items.Add(new SelectListItem { Text = "9 hr 30 min", Value = "9 hr 30 min" });

            items.Add(new SelectListItem { Text = "10 hr", Value = "10 hr" });

            return items;
        }

        public static List<SelectListItem> AdministrationDuration()  //                        
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = " 1 min", Value = " 1min" });
            items.Add(new SelectListItem { Text = " 5 min", Value = " 5min" });
            items.Add(new SelectListItem { Text = " 10 min", Value = " 10min" });
            items.Add(new SelectListItem { Text = " 15 min", Value = " 15min" });
            items.Add(new SelectListItem { Text = " 20 min", Value = " 20min" });
            items.Add(new SelectListItem { Text = " 30 min", Value = " 30min" });

            items.Add(new SelectListItem { Text = "1 hr", Value = "1hour" });
            items.Add(new SelectListItem { Text = "1 hr 10 min", Value = "1hour10min" });
            items.Add(new SelectListItem { Text = "1 hr 15 min", Value = "1hour15min" });
            items.Add(new SelectListItem { Text = "1 hr 20 min", Value = "1hour20min" });
            items.Add(new SelectListItem { Text = "1 hr 30 min", Value = "1hr30min" });


            items.Add(new SelectListItem { Text = "2 hr", Value = "2hr" });
            items.Add(new SelectListItem { Text = "2 hr 10 min", Value = "2hr10min" });
            items.Add(new SelectListItem { Text = "2 hr 15 min", Value = "2hr15min" });
            items.Add(new SelectListItem { Text = "2 hr 20 min", Value = "2hr20min" });
            items.Add(new SelectListItem { Text = "2 hr 30 min", Value = "2hr30min" });


            items.Add(new SelectListItem { Text = "3 hr", Value = "3hr" });
            items.Add(new SelectListItem { Text = "3 hr 10 min", Value = "3hr10min" });
            items.Add(new SelectListItem { Text = "3 hr 15min", Value = "3hr15min" });
            items.Add(new SelectListItem { Text = "3 hr 20 min", Value = "3hr20min" });
            items.Add(new SelectListItem { Text = "3 hr 30 min", Value = "3hr30min" });



            items.Add(new SelectListItem { Text = "4 hr", Value = "4hr" });
            items.Add(new SelectListItem { Text = "4 hr 10 min", Value = "4hr10min" });
            items.Add(new SelectListItem { Text = "4 hr 15 min", Value = "4hr15min" });
            items.Add(new SelectListItem { Text = "4 hr 20 min", Value = "4hr20min" });
            items.Add(new SelectListItem { Text = "4 hr 30 min", Value = "4hr30min" });


            items.Add(new SelectListItem { Text = "5 hr", Value = "5hr" });
            items.Add(new SelectListItem { Text = "5 hr 10 min", Value = "5hr10min" });
            items.Add(new SelectListItem { Text = "5 hr 15 min", Value = "5hr15min" });
            items.Add(new SelectListItem { Text = "5 hr 20 min", Value = "5hr20min" });
            items.Add(new SelectListItem { Text = "5 hr 30 min", Value = "5hr30min" });


            items.Add(new SelectListItem { Text = "6 hr", Value = "6hr" });
            items.Add(new SelectListItem { Text = "6 hr 10 min", Value = "6hr10min" });
            items.Add(new SelectListItem { Text = "6 hr 15 min", Value = "6hr15min" });
            items.Add(new SelectListItem { Text = "6 hr 20 min", Value = "6hr20min" });
            items.Add(new SelectListItem { Text = "6 hr 30 min", Value = "6hr30min" });

            items.Add(new SelectListItem { Text = "7 hr", Value = "7hr" });
            items.Add(new SelectListItem { Text = "7 hr 10 min", Value = "7hr10min" });
            items.Add(new SelectListItem { Text = "7 hr 15 min", Value = "7hr15min" });
            items.Add(new SelectListItem { Text = "7 hr 20 min", Value = "7hr20min" });
            items.Add(new SelectListItem { Text = "7 hr 30 min", Value = "7hr30min" });

            items.Add(new SelectListItem { Text = "8 hr", Value = "8hr" });
            items.Add(new SelectListItem { Text = "8 hr 10 min", Value = "8hr10min" });
            items.Add(new SelectListItem { Text = "8 hr 15 min", Value = "8hr15min" });
            items.Add(new SelectListItem { Text = "8 hr 20 min", Value = "8hr20min" });
            items.Add(new SelectListItem { Text = "8 hr 30 min", Value = "8hr30min" });

            items.Add(new SelectListItem { Text = "9 hr", Value = "9hr" });
            items.Add(new SelectListItem { Text = "9 hr 10 min", Value = "9hr10min" });
            items.Add(new SelectListItem { Text = "9 hr 15 min", Value = "9hr15min" });
            items.Add(new SelectListItem { Text = "9 hr 20 min", Value = "9hr20min" });
            items.Add(new SelectListItem { Text = "9 hr 30 min", Value = "9hr30min" });

            items.Add(new SelectListItem { Text = "10 hr", Value = "10hr" });

            return items;
        }


        public static List<SelectListItem> GetDVTProphylaxisList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "MECHANICAL", Value = "M" });
            items.Add(new SelectListItem { Text = "CHEMICAL", Value = "C" });
            items.Add(new SelectListItem { Text = "MECHANICAL & CHEMICAL", Value = "B" });

            return items;
        }
        public static List<SelectListItem> GetNutritionIntakeList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Nil By Mouth", Value = "NBM" });
            items.Add(new SelectListItem { Text = "On water", Value = "Sipsofwater" });
            items.Add(new SelectListItem { Text = "Liquid Diet", Value = "LD" });
            items.Add(new SelectListItem { Text = "Clear Liquid Diet", Value = "CLD" });
            items.Add(new SelectListItem { Text = "Full Liquid Diet", Value = "FullLD" });
            items.Add(new SelectListItem { Text = "Renal Liquid diet", Value = "RenalLD" });
            items.Add(new SelectListItem { Text = "Salt restricted soft diet", Value = "SRSD" });
            items.Add(new SelectListItem { Text = "Salt restricted-diabetic soft diet", Value = "SR-D SD" });
            items.Add(new SelectListItem { Text = "Chillifree Soft Diet", Value = "BlandSD" });


            items.Add(new SelectListItem { Text = "Blenderized soft Diet", Value = "BlendSD" });
            items.Add(new SelectListItem { Text = "Diabetic soft Diet", Value = "DSD" });
            items.Add(new SelectListItem { Text = "Renal soft diet", Value = "RenalSD" });
            items.Add(new SelectListItem { Text = "Renal Diabetic soft diet", Value = "RenalDSD" });

            items.Add(new SelectListItem { Text = "Soft Diet hepatic", Value = "SDHepatic" });
            items.Add(new SelectListItem { Text = "Full Diet", Value = "FD" });
            items.Add(new SelectListItem { Text = "Full Diet hepatic", Value = "FDHepatic" });
            items.Add(new SelectListItem { Text = "Full diet High protein diet", Value = "FDHPD" });
            items.Add(new SelectListItem { Text = "Full diet Renal", Value = "FDRenal" });

            items.Add(new SelectListItem { Text = "Full Diet Hepatic High Protein Diet", Value = "FDHepaticHPD" });
            items.Add(new SelectListItem { Text = "Diabetic Full Diet", Value = "DFD" });
            items.Add(new SelectListItem { Text = "Salt restricted Full Diet", Value = "SRFD" });
            items.Add(new SelectListItem { Text = "Salt restricted-diabetic Full Diet", Value = "SR-DFD" });

            items.Add(new SelectListItem { Text = "Diabetic Full Diet High protein Diet", Value = "DFDHPD" });
            items.Add(new SelectListItem { Text = "Diabetic Full Diet Renal", Value = "DFD Renal" });
            items.Add(new SelectListItem { Text = "Diabetic Full Diet Renal High protein Diet", Value = "DFDRenalHPD" });
            items.Add(new SelectListItem { Text = "Full Diet Pediatric", Value = "FDPed" });
            items.Add(new SelectListItem { Text = "Full diet Pediatric High protein Diet", Value = "FDPedHPD" });
            items.Add(new SelectListItem { Text = "Soft diet Pediatric", Value = "SDPed" });

            items.Add(new SelectListItem { Text = "Ryles tube/ naso gastric feeds", Value = "RTFEEDS/NGFEEDS" });
            items.Add(new SelectListItem { Text = "Naso Jejunal feeds", Value = "NJFEEDS" });
            items.Add(new SelectListItem { Text = "Percutaneous entero gastric feeds", Value = "PEGFEEDS" });
            items.Add(new SelectListItem { Text = "Percutaneous entero Jejunal feeds", Value = "PEJ/JTFEEDS" });
            items.Add(new SelectListItem { Text = "Antenatal Care", Value = "ANC" });  //vishal 17th Jan 2019
            return items;
        }

        public static string SendMailFunction(string TranNo, string FrmName, string PathToSave, byte[] printarr, string FrmMailIdStr,
            string FrmPwdStr, string ToMailIdStr, string BodyStr)
        {
            System.IO.FileStream fs = new FileStream(PathToSave + "\\" + FrmName + "--" + TranNo + ".pdf", FileMode.Create);
            try
            {
                string ResultOfSend = "";
                string CCEmailID = GeneralFunction.GetAppsettingUnitWiseValue("PrescriptCC").ToString();

                fs.Write(printarr, 0, printarr.Length);

                fs.Close();

                using (MailMessage mail = new MailMessage())
                {
                    string strDoctNAme = "Dr. " + (string.Empty + System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Trim();
                    mail.Subject = FrmName + " - " + strDoctNAme;
                    mail.Body = BodyStr;
                    mail.From = new MailAddress(FrmMailIdStr, (HttpContext.Current.Session["HOSPITALNAME"]).ToString().Trim());
                    if (ToMailIdStr.IndexOf(",") != -1)
                    {
                        var ArrayLst = ToMailIdStr.Split(',');
                        for (var i = 0; i < ArrayLst.Length; i++)
                            mail.To.Add(ArrayLst[i].Replace("\n", "").Replace("\r", ""));
                    }
                    else
                        mail.To.Add(ToMailIdStr);

                    if (CCEmailID != "")
                        mail.CC.Add(CCEmailID);

                    mail.Attachments.Add(new Attachment(PathToSave + "\\" + FrmName + "--" + TranNo + ".pdf"));
                    mail.IsBodyHtml = true;
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = GeneralFunction.GetAppsettingUnitWiseValue("OutgoingMailServer").ToString();
                    if (GeneralFunction.GetAppsettingUnitWiseValue("SSLYN").ToString() == "Y")
                        smtp.EnableSsl = true;
                    else
                        smtp.EnableSsl = false;
                    NetworkCredential networkCredential = new NetworkCredential(FrmMailIdStr, FrmPwdStr);
                    smtp.UseDefaultCredentials = true;
                    smtp.Credentials = networkCredential;
                    smtp.Port = Convert.ToInt32(GeneralFunction.GetAppsettingUnitWiseValue("Port").ToString());
                    try
                    {
                        smtp.Send(mail);
                        ResultOfSend = "Mail SuccessFully Send";
                    }
                    catch (Exception smtpex)
                    {
                        ResultOfSend = "Check Login Credentials Or Allow less secure apps in Gmail Account settings. Exception Message -- " + smtpex.Message;
                    }
                    mail.Attachments.Dispose();
                    if (Directory.Exists(Path.GetDirectoryName(PathToSave + "\\" + FrmName + "--" + TranNo + ".pdf")))
                    {
                        System.IO.File.Delete(PathToSave + "\\" + FrmName + "--" + TranNo + ".pdf");
                    }
                }
                return ResultOfSend;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                fs.Close();
                fs.Dispose();
            }
        }

        public static string Encrypt(string clearText)
        {
            string EncryptionKey = "AI2020";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        public static string Decrypt(string cipherText)
        {
            string EncryptionKey = "AI2020";
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }

        private static TokenResponse RefreshToken(string refreshToken)
        {
            using (var client = new HttpClient())
            {
                var tokenEndpoint = HttpContext.Current.Session["idpbaseaddress"].ToString() + "/realms/" + HttpContext.Current.Session["idprealms"].ToString() + "/protocol/openid-connect/token";
                var clientId = HttpContext.Current.Session["idpclientid"].ToString();
                var clientSecret = HttpContext.Current.Session["idpclientSecret"].ToString();

                var tokenRequest = new Dictionary<string, string>
                 {
                   { "grant_type", "refresh_token" },
                   { "refresh_token", refreshToken },
                   { "client_id", clientId },
                     { "client_secret", clientSecret }
                 };

                var responseTask = client.PostAsync(tokenEndpoint, new FormUrlEncodedContent(tokenRequest));
                responseTask.Wait();
                var response = responseTask.Result;
                response.EnsureSuccessStatusCode();

                var tokenResponseTask = response.Content.ReadAsAsync<TokenResponse>();
                tokenResponseTask.Wait();
                var tokenResponse = tokenResponseTask.Result;
                return tokenResponse;
            }
        }

        public static TokenIntrospect CheckAuthToken(string accesstoken, string refToken, bool UseRefToken)
        {
            try
            {
                using (var client = new HttpClient())
                {
                    var tokenEndpoint = HttpContext.Current.Session["idpbaseaddress"].ToString() + "/realms/" + HttpContext.Current.Session["idprealms"].ToString() + "/protocol/openid-connect/token/introspect";
                    var clientId = HttpContext.Current.Session["idpclientid"].ToString();
                    var clientSecret = HttpContext.Current.Session["idpclientSecret"].ToString();

                    var tokenRequest = new Dictionary<string, string>
                 {
                   { "token", accesstoken},
                   { "client_id", clientId },
                   { "client_secret", clientSecret }
                 };

                    var responseTask = client.PostAsync(tokenEndpoint, new FormUrlEncodedContent(tokenRequest));
                    responseTask.Wait();
                    var response = responseTask.Result;
                    response.EnsureSuccessStatusCode();

                    var tokenResponseTask = response.Content.ReadAsAsync<TokenIntrospect>();
                    tokenResponseTask.Wait();
                    var tokenResponse = tokenResponseTask.Result;
                    if (tokenResponse.active == false)
                    {
                        if (UseRefToken)
                        {
                            var TokenIntRep = RefreshToken(refToken);
                            HttpContext.Current.Session["REFTOKEN"] = TokenIntRep.refresh_token;
                            HttpContext.Current.Session["AUTHTOKEN"] = TokenIntRep.access_token;
                            return CheckAuthToken(TokenIntRep.access_token, "", false);
                        }
                    }
                    return tokenResponse;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //Added By Priyanka on 31/01/2025
        #region AppSettings
        public System.Reflection.PropertyInfo prop { get; set; }
        void GetString(string input, object target, string propertyName)
        {
            if (!string.IsNullOrEmpty(input))
            {
                prop = target.GetType().GetProperty(propertyName);
                prop.SetValue(target, input);
            }
        }


        #region App Setting and  Service Error Log
        //Added By Priyanka on 31/01/2025
        public class ThreeSelectListItem
        {
            public bool Selected { get; set; }
            public string Text { get; set; }
            public string Value { get; set; }
            public string Resolution { get; set; }
            public string FileFormat { get; set; }
            public string FileName { get; set; }
        }
        public static List<ThreeSelectListItem> GetImageList()
        {

            List<ThreeSelectListItem> items = new List<ThreeSelectListItem>();
            //items.Add(new ThreeSelectListItem { Text = "Client Login Logo(png)", Value = "COMPLOGO", Resolution = "64 x 49", FileFormat = "png", FileName = "Clientlogo" });
            items.Add(new ThreeSelectListItem { Text = "Client Print Logo(jpg)", Value = "HOSPLOGO", Resolution = "180 x 78", FileFormat = "png", FileName = "logo" });
            items.Add(new ThreeSelectListItem { Text = "Letter Head - Header(png)", Value = "LHHeader", Resolution = "1292 x 177", FileFormat = "png", FileName = "LHHeader" });
            items.Add(new ThreeSelectListItem { Text = "Letter Head - Footer(png)", Value = "LHFooter", Resolution = "1292 x 177", FileFormat = "png", FileName = "LHFooter" });
            //items.Add(new ThreeSelectListItem { Text = "Prescription - Header(png)", Value = "PrescrHeader", Resolution = "1292 x 177", FileFormat = "png", FileName = "PrescrHeader" });
            //items.Add(new ThreeSelectListItem { Text = "Prescription - Footer(png)", Value = "PrescrFooter", Resolution = "1292 x 177", FileFormat = "png", FileName = "PrescrFooter" });
            string FileName = "";
            if (GeneralFunction.GetAppsettingUnitWiseValue("IPDFBMEDHEADERPATH").ToString().Trim() != "")
            {
                FileName = GeneralFunction.GetAppsettingUnitWiseValue("IPDFBMEDHEADERPATH").ToString().Trim();
                items.Add(new ThreeSelectListItem { Text = "IPD Medicine Final Bill - Header(png)", Value = "IPDFBMEDHEADERPATH", Resolution = "1292 x 177", FileFormat = "png", FileName = FileName.Split('.')[0] });
            }
            if (GeneralFunction.GetAppsettingUnitWiseValue("IPDFBMEDFOOTERPATH").ToString().Trim() != "")
            {
                FileName = GeneralFunction.GetAppsettingUnitWiseValue("IPDFBMEDFOOTERPATH").ToString().Trim();
                items.Add(new ThreeSelectListItem { Text = "IPD Medicine Final Bill - Footer(png)", Value = "IPDFBMEDFOOTERPATH", Resolution = "1292 x 177", FileFormat = "png", FileName = FileName.Split('.')[0] });
            }
            if (GeneralFunction.GetAppsettingUnitWiseValue("DSUMMARYHEADERIMAGEPATH").ToString().Trim() != "")
            {
                FileName = GeneralFunction.GetAppsettingUnitWiseValue("DSUMMARYHEADERIMAGEPATH").ToString().Trim();
                items.Add(new ThreeSelectListItem { Text = "Discharge Summary - Header(png)", Value = "DSUMMARYHEADERIMAGEPATH", Resolution = "1292 x 177", FileFormat = "png", FileName = FileName.Split('.')[0] });
            }
            if (GeneralFunction.GetAppsettingUnitWiseValue("DSUMMARYFOOTERIMAGEPATH").ToString().Trim() != "")
            {
                FileName = GeneralFunction.GetAppsettingUnitWiseValue("DSUMMARYFOOTERIMAGEPATH").ToString().Trim();
                items.Add(new ThreeSelectListItem { Text = "Discharge Summary - Footer(png)", Value = "DSUMMARYFOOTERIMAGEPATH", Resolution = "1292 x 177", FileFormat = "png", FileName = FileName.Split('.')[0] });
            }
            return items;
        }


        //Added By Priyanka on 31/01/2025
        public static string assignRightToModel(object target, string formname)
        {
            try
            {
                DataTable dt = (DataTable)HttpContext.Current.Session["FRMRIGHTS"];
                string strModuleid = System.Web.HttpContext.Current.Session["ModuleIDGlobal"].ToString();
                if (dt.Rows.Count > 0)
                {
                    DataRow[] dr;
                    dr = dt.Select("FORMNAME ='" + formname + "' AND MODULEID='" + strModuleid + "'");
                    if (dr.Length > 0)
                    {
                        GeneralFunction general = new GeneralFunction();
                        general.GetString(dr[0]["BTNNEW"].ToString(), target, "NewYN");
                        general.GetString(dr[0]["BTNPRINT"].ToString(), target, "PrintYN");
                        general.GetString(dr[0]["BTNEXCEL"].ToString(), target, "ExcelYN");
                        general.GetString(dr[0]["BTNEDIT"].ToString(), target, "EditYN");
                        general.GetString(dr[0]["BTNSHOW"].ToString(), target, "ShowYN");
                        general.GetString(dr[0]["BTNVERIFY"].ToString(), target, "verifyYn");
                        general.GetString(dr[0]["BTNCANCEL"].ToString(), target, "cancelYN");
                        general.GetString(dr[0]["BTNTRANPRINT"].ToString(), target, "TranPrintYN");
                        //general.GetString(dr[0]["BTNSHOW"].ToString(), target, "DisplayYN");
                        general.GetString(dr[0]["CENTRALYN"].ToString(), target, "CentralMasterYN");
                        general.GetString(dr[0]["COMFORALLYN"].ToString(), target, "CommonForAllUnitsYN");
                        return "Y";
                    }
                    else
                    {
                        return "N";
                    }
                }
                else
                {
                    return "N";
                }
            }
            catch
            {
                return "N";
            }
        }

        public static string getHeaderFooterExcelAppSetting(string frmName, string frmDate, string toDate, string FilterData = "", string strSerachCriteria = "",
            DataTable df = null, DataTable df1 = null)
        {
            try
            {
                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);
                GridView gv = new GridView();
                gv.ShowFooter = true;
                gv.BorderWidth = 0;
                gv.GridLines = GridLines.Both;
                gv.DataSource = df;
                gv.DataBind();
                var footer = gv.FooterRow;
                gv.GridLines = GridLines.Both;
                gv.RenderControl(htw);
                StringBuilder sSchema = new StringBuilder();
                string formheader = frmName;
                if (frmDate != "" && toDate != "")
                {
                    if (frmDate == toDate)
                    {
                        formheader += " - For " + frmDate; ;
                    }
                    else
                    {
                        formheader += " - From " + frmDate + " To " + toDate;
                    }
                }
                string filterText = "";
                DataTable FilterDt = new DataTable();
                if (FilterData == null || FilterData == "")
                {
                    filterText += "N/A";
                }
                else
                    FilterDt = JsonConvert.DeserializeObject<DataTable>(FilterData);
                foreach (DataRow dr in FilterDt.Rows)
                {
                    if (dr[0].ToString().Trim() == "STATUS")
                    {
                        filterText += dr[0].ToString().Trim() + " : " + (dr[2].ToString().Trim() == "A" ? "Active" : "Cancel" + " ,  ");
                    }

                    else if (dr[0].ToString().Trim().ToString().Trim() == "TRACKSTAT")
                    {
                        filterText += "Status" + " : " + (dr[2].ToString().Trim() == "I" ? "CheckedIn" : "Consultation" + " ,  ");
                    }
                    else
                        filterText += dr[0].ToString().Trim() + " : " + dr[2].ToString() + ",  ";
                }
                if (strSerachCriteria == "")
                    strSerachCriteria = "N/A";
                string AllData = "";
                if (df != null)
                {
                    AllData = "<table><tr><th scope='col' colspan='" + df.Columns.Count + "'>" + formheader + "</th></tr><tr><td scope='col' colspan='" + df.Columns.Count + "'>" +
                        "Search Criteria : " + strSerachCriteria + "</td></tr><tr><td scope='col' colspan='" + df.Columns.Count + "'>" + "Filter Criteria : " + filterText +
                        "</td></tr></table>";
                    AllData = AllData + sw.ToString();
                }

                if (df1 != null)
                {
                    System.IO.StringWriter sw1 = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter htw1 = new System.Web.UI.HtmlTextWriter(sw1);
                    GridView gv1 = new GridView();
                    gv1.ShowFooter = true;
                    gv1.BorderWidth = 0;
                    gv1.GridLines = GridLines.Both;
                    gv1.DataSource = df1;
                    gv1.DataBind();
                    var footer1 = gv.FooterRow;
                    gv1.GridLines = GridLines.Both;
                    gv1.RenderControl(htw1);
                    string formheader1 = "Bill Info";
                    string AllDataInner = "<table><tr><th scope='col' colspan='" + df1.Columns.Count + "'>" + formheader1 + "</th></tr><tr><td scope='col' colspan='" + df1.Columns.Count + "'>" + "Search Criteria : " + strSerachCriteria + "</td></tr><tr><td scope='col' colspan='" + df1.Columns.Count + "'>" + "Filter Criteria : " + filterText + "</td></tr></table>";
                    if (frmName == "Consultation List") //Added By Rajan - Shiftwise Consultation And Admission Report 
                    {
                        formheader1 = "Admission List" + " - From " + frmDate + " To " + toDate;
                        AllDataInner = "<table><tr><th scope='col' colspan='" + df1.Columns.Count + "'>" + formheader1 + "</th></tr><tr><td scope='col' colspan='" + df1.Columns.Count + "'>" + "Search Criteria : " + strSerachCriteria + "</td></tr><tr><td scope='col' colspan='" + df1.Columns.Count + "'>" + "Filter Criteria : " + filterText + "</td></tr></table>";
                    }
                    AllData = AllData + AllDataInner + sw1.ToString();
                }
                //end
                sSchema.Append("<html xmlns:x=urn:schemas-microsoft-com:office:excel> <head><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head> <body>");
                sSchema.Append(AllData + "</body></html>");
                return sSchema.ToString();
            }
            catch (NullReferenceException ex1)
            {
                return "Object was not initialized: " + ex1.Message + " " + "getHeaderFooterExcel";
            }
        }
        #endregion

        #endregion

        //************************************** Unit Wise Appsetting Value ********************************** Added By Rajan
        public static string GetAppsettingUnitWiseValue(string ConfigKey)
        {
            string Value = "";
            if (ConfigKey != "")
            {
                Value = System.Configuration.ConfigurationManager.AppSettings[ConfigKey] == null ? "" : System.Configuration.ConfigurationManager.AppSettings[ConfigKey].ToString().Trim();
                string UnitCD = HttpContext.Current.Session != null ? ("" + HttpContext.Current.Session["UNITCODE"]).ToString() : "";
                if (UnitCD != "")
                {
                    string BasePath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath(("~/UnitConfig/" + UnitCD)), "AppSetting.config");
                    if (File.Exists(BasePath))
                    {
                        ExeConfigurationFileMap fileMap = new ExeConfigurationFileMap
                        {
                            ExeConfigFilename = BasePath
                        };
                        Configuration config = ConfigurationManager.OpenMappedExeConfiguration(fileMap, ConfigurationUserLevel.None);
                        if (config.AppSettings.Settings[ConfigKey] != null)
                        {
                            Value = config.AppSettings.Settings[ConfigKey].Value.ToString().Trim();
                        }
                    }
                }
            }
            return Value;
        }
        //************************************** Unit Wise Image ********************************** Added By Rajan
        public static string GetImageUnitWise(string ImageName)
        {
            string UnitCD = ("" + HttpContext.Current.Session["UNITCODE"]).ToString();
            string BasePath = HttpRuntime.AppDomainAppPath + @"\Images\" + ImageName;
            if (UnitCD != "")
            {
                string UnitBasePath = HttpRuntime.AppDomainAppPath + @"\UnitConfig\" + UnitCD + @"\Images\" + ImageName;
                if (File.Exists(UnitBasePath))
                {
                    return UnitBasePath;
                }
            }
            if (File.Exists(BasePath))
            {
                return BasePath;
            }
            return "";
        }
        //************************************** Unit Name with Separtor '|'********************************** Added By Rajan
        public static string GetUnitName(string UnitCode)
        {
            string AllUnitName = "";
            CommonSerRef.CommonServiceClient comserv = new CommonSerRef.CommonServiceClient();
            var Console = new CommonSerRef.SelectLstItem { Status = "A", Text = "Console", Value = "00" };
            var AllUnitList = comserv.GetUnitLst().Where(x => x.Status == "A").Concat(new[] { Console });
            string[] SpltunitCd = UnitCode.Split('|');
            foreach (string Unit in SpltunitCd)
            {
                if (AllUnitList.Where(x => x.Value == Unit).Count() > 0)
                {
                    AllUnitName = AllUnitName + (AllUnitName == "" ? AllUnitList.Where(x => x.Value == Unit).FirstOrDefault().Text : ("," + AllUnitList.Where(x => x.Value == Unit).FirstOrDefault().Text));
                }
            }
            AllUnitName = AllUnitName == "" ? "All Units" : AllUnitName;
            return AllUnitName;
        }

        public static List<CommonSerRef.SelectLstItem> GetUnitRightsList()
        {
            CommonSerRef.CommonServiceClient comserv = new CommonSerRef.CommonServiceClient();
            List<CommonSerRef.SelectLstItem> Type = new List<CommonSerRef.SelectLstItem>();
            string UnitRight = ("" + HttpContext.Current.Session["UNITRIGHTS"]).ToString();
            var Console = new CommonSerRef.SelectLstItem { Status = "A", Text = "Console", Value = "00" };
            //var AllUnitList = comserv.GetUnitLst().Where(x => x.Status == "A").Concat(new[] { Console });
            var AllUnitList = comserv.GetUnitLst().Where(x => x.Status == "A");
            if (UnitRight != "")
            {
                var SpltUnitList = UnitRight.Split('|');
                Type = AllUnitList.Where(x => SpltUnitList.Contains(x.Value)).Select(x => new CommonSerRef.SelectLstItem { Text = x.Text, Value = x.Value, Status = x.Status }).ToList();
            }
            else
            {
                Type = AllUnitList.Select(x => new CommonSerRef.SelectLstItem { Text = x.Text, Value = x.Value, Status = x.Status }).ToList();
            }
            return Type;
        }

        public static string GetListValue(dynamic List, string Val = "")
        {
            if (Val != "")
            {
                var AllLst = (IEnumerable<dynamic>)List;
                if (AllLst.Where(x => x.Value == Val).Count() > 0)
                {
                    return AllLst.Where(x => x.Value == Val).FirstOrDefault().Text;
                }
            }
            return "";
        }

        public static string GetListTxt(dynamic List, string Txt = "")
        {
            if (Txt != "")
            {
                var AllLst = (IEnumerable<dynamic>)List;
                if (AllLst.Where(x => x.Text == Txt).Count() > 0)
                {
                    return AllLst.Where(x => x.Text == Txt).FirstOrDefault().Value;
                }
            }
            return "";
        }


        public static byte[] ApplyPasswordProtection(string inputFilePath, string outputFilePath, string password)
        {
            // Ensure the input file exists
            if (!File.Exists(inputFilePath))
            {
                throw new FileNotFoundException("Input file not found.");
            }

            using (var outStream = new MemoryStream())
            {
                using (var reader = new iTextSharp.text.pdf.PdfReader(inputFilePath))
                {
                    using (var stamper = new iTextSharp.text.pdf.PdfStamper(reader, outStream))
                    {
                        var passwordBytes =
                                        Encoding.ASCII.GetBytes(password);

                        stamper.SetEncryption(
                                passwordBytes,
                                passwordBytes,
                                iTextSharp.text.pdf.PdfWriter.AllowPrinting,
                                iTextSharp.text.pdf.PdfWriter.ENCRYPTION_AES_256);
                    }
                }

                return outStream.ToArray();
            }

        }
        public static void WritePDFErrorLog(string sResultNo, string message)
        {
            StreamWriter logWriter;
            string path = System.Web.Hosting.HostingEnvironment.MapPath("~/log");
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);
            path = System.Web.Hosting.HostingEnvironment.MapPath("~/log/");

            path = Path.Combine(path + "ErrorPDFLog.txt");

            if (File.Exists(path))
                logWriter = File.AppendText(path);
            else
                logWriter = File.CreateText(path);
            logWriter.WriteLine("=>" + DateTime.Now + " | " + sResultNo + " | An Error occured : Message : " + message);
            logWriter.WriteLine("-----------------------------------------------------------------------------------------------");
            logWriter.Close();
        }

        public static List<SelectListItem> TreatmentHrsList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "00:30", Value = "00:30" });
            items.Add(new SelectListItem { Text = "01:00", Value = "01:00" });
            items.Add(new SelectListItem { Text = "01:30", Value = "01:30" });
            items.Add(new SelectListItem { Text = "02:00", Value = "02:00" });
            items.Add(new SelectListItem { Text = "02:30", Value = "02:30" });
            items.Add(new SelectListItem { Text = "03:00", Value = "03:00" });
            items.Add(new SelectListItem { Text = "03:30", Value = "03:30" });
            items.Add(new SelectListItem { Text = "04:00", Value = "04:00" });
            items.Add(new SelectListItem { Text = "04:30", Value = "04:30" });
            items.Add(new SelectListItem { Text = "05:00", Value = "05:00" });
            items.Add(new SelectListItem { Text = "05:30", Value = "05:30" });
            items.Add(new SelectListItem { Text = "06:00", Value = "06:00" });
            items.Add(new SelectListItem { Text = "06:30", Value = "06:30" });
            items.Add(new SelectListItem { Text = "07:00", Value = "07:00" });
            items.Add(new SelectListItem { Text = "07:30", Value = "07:30" });
            items.Add(new SelectListItem { Text = "08:00", Value = "08:00" });
            items.Add(new SelectListItem { Text = "08:30", Value = "08:30" });
            items.Add(new SelectListItem { Text = "09:00", Value = "09:00" });
            items.Add(new SelectListItem { Text = "09:30", Value = "09:30" });
            items.Add(new SelectListItem { Text = "10:00", Value = "10:00" });
            items.Add(new SelectListItem { Text = "10:30", Value = "10:30" });
            items.Add(new SelectListItem { Text = "11:00", Value = "11:00" });
            items.Add(new SelectListItem { Text = "11:30", Value = "11:30" });
            items.Add(new SelectListItem { Text = "12:00", Value = "12:00" });
            return items;
        }
        //Added By Rajan - To Get the TNM List 
        public static IEnumerable<SelectListItem> LstTumor
        {
            get
            {
                return new List<SelectListItem> { new SelectListItem { Value = "1", Text = "TX" } ,
                new SelectListItem { Value = "2", Text = "T0" },
                new SelectListItem { Value = "3", Text = "Tis" },
                new SelectListItem { Value = "4", Text = "T1" },
                                new SelectListItem { Value = "5", Text = "T2" },
                new SelectListItem { Value = "6", Text = "T3" },
                new SelectListItem { Value = "7", Text = "T4" } };
            }
        }
        public static IEnumerable<SelectListItem> LstNode
        {
            get
            {
                return new List<SelectListItem> { new SelectListItem { Value = "1", Text = "NX" } ,
                new SelectListItem { Value = "2", Text = "N0" },
                new SelectListItem { Value = "3", Text = "N1" } };

            }
        }
        public static IEnumerable<SelectListItem> LstMetastasis
        {
            get
            {
                return new List<SelectListItem> { new SelectListItem { Value = "1", Text = "M0" } ,
                new SelectListItem { Value = "2", Text = "M1" } };
            }
        }

        public static List<SelectListItem> GetPrefixTNM()
        {
            List<SelectListItem> lst = new List<SelectListItem>();
            lst.Add(new SelectListItem { Value = "c", Text = "c" });
            lst.Add(new SelectListItem { Value = "p", Text = "p" });
            lst.Add(new SelectListItem { Value = "yc", Text = "yc" });
            lst.Add(new SelectListItem { Value = "yp", Text = "yp" });
            lst.Add(new SelectListItem { Value = "r", Text = "r" });
            return lst;
        }

        public static List<HistoGradeList> GetHitologyGrade()
        {
            List<HistoGradeList> lst = new List<HistoGradeList>();
            lst.Add(new HistoGradeList { Value = "1", Text = "Grade I – Well differentiated or Differentiated, NOS", GradeType = "A" });
            lst.Add(new HistoGradeList { Value = "2", Text = "Grade II – Moderately differentiated or Intermediate differentiation", GradeType = "A" });
            lst.Add(new HistoGradeList { Value = "3", Text = "Grade III – Poorly differentiated", GradeType = "A" });
            lst.Add(new HistoGradeList { Value = "4", Text = "Grade IV – Undifferentiated or Anaplastic", GradeType = "A" });
            lst.Add(new HistoGradeList { Value = "9", Text = "Grade or differentiation not determined, not stated or not applicable", GradeType = "A" });
            lst.Add(new HistoGradeList { Value = "5", Text = "T-cell", GradeType = "B" });
            lst.Add(new HistoGradeList { Value = "6", Text = "B-cell", GradeType = "B" });
            lst.Add(new HistoGradeList { Value = "7", Text = "Null cell", GradeType = "B" });
            lst.Add(new HistoGradeList { Value = "8", Text = "NK cell", GradeType = "B" });
            lst.Add(new HistoGradeList { Value = "9", Text = "Cell type not determined, not stated or not applicable", GradeType = "B" });
            return lst;
        }

        public static List<SelectListItem> GetAllergyTypeList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Food", Value = "F" });
            items.Add(new SelectListItem { Text = "Drugs", Value = "D" });
            items.Add(new SelectListItem { Text = "Others", Value = "O" });
            return items;
        }

        public static string AgeFormat(string Age)
        {
            string ResultAge = "";
            if (Age.Trim() != "")
            {
                string[] SplitAge = Age.Split(':');
                if (SplitAge.Length == 3)
                {
                    int Year = Convert.ToInt32(SplitAge[0].ToString());
                    int Month = Convert.ToInt32(SplitAge[1].ToString());
                    int Days = Convert.ToInt32(SplitAge[2].ToString());
                    if (Year > 0)
                    {
                        ResultAge = Year + " Yrs";
                    }
                    else if (Year > 0)
                    {
                        ResultAge = Month + " Months";
                    }
                    else if (Year > 0)
                    {
                        ResultAge = Days + " Days";
                    }
                }
            }
            return ResultAge;
        }
        public static IEnumerable<SelectListItem> LstConStatus
        {
            get
            {
                return new List<SelectListItem> { new SelectListItem { Text = "Defaulted", Value = "03"  } ,
                    new SelectListItem { Text = "Cancelled", Value = "05" },
               };
            }
        }

        public static string ConvertTimeTo12Hour(string timeStr)
        {
            if (string.IsNullOrWhiteSpace(timeStr))
                return timeStr;
            DateTime timeValue;
            if (DateTime.TryParse(timeStr, out timeValue))
            {
                return timeValue.ToString("hh:mm tt");
            }
            return timeStr;
        }


        //Added By Abhishesh || 20260323
        public static string ConvertTimeTo24Hour(string timeStr)
        {
            if (string.IsNullOrWhiteSpace(timeStr))
                return timeStr;

            DateTime timeValue;

            if (DateTime.TryParse(timeStr, out timeValue))
            {
                return timeValue.ToString("HH:mm");
            }

            return timeStr;
        }
        //End

        public static List<SelectListItem> GetIntentList()
        {
            List<SelectListItem> Intentddl = new List<SelectListItem>();
            Intentddl.Add(new SelectListItem() { Text = "Radical RT alone", Value = "INTRTALONE" });
            Intentddl.Add(new SelectListItem() { Text = "Radical RT+CT", Value = "INTRTCT" });
            Intentddl.Add(new SelectListItem() { Text = "Intent Radical", Value = "INTRADICAL" });
            Intentddl.Add(new SelectListItem() { Text = "NART", Value = "INTNART" });
            Intentddl.Add(new SelectListItem() { Text = "NARTCT", Value = "INTNARTCT" });
            Intentddl.Add(new SelectListItem() { Text = "Adjuvant RT", Value = "INTADJRT" });
            Intentddl.Add(new SelectListItem() { Text = "Adjuvant RTCT", Value = "INTADJRTCT" });
            Intentddl.Add(new SelectListItem() { Text = "Prophylactic", Value = "INTPROPHYL" });
            Intentddl.Add(new SelectListItem() { Text = "Conditioning", Value = "INTCONDITION" });
            Intentddl.Add(new SelectListItem() { Text = "Palliative", Value = "INTPALLATIVE" });
            Intentddl.Add(new SelectListItem() { Text = "Blood products", Value = "INTBLDPRD" });
            return Intentddl;
        }

        //Added by Haritha on 16/01/2026
        public static List<SelectListItem> GetTimeList()
        {
            List<SelectListItem> items = new List<SelectListItem>();

            items.Add(new SelectListItem { Text = "12 AM", Value = "12 AM" });
            items.Add(new SelectListItem { Text = "01 AM", Value = "01 AM" });
            items.Add(new SelectListItem { Text = "02 AM", Value = "02 AM" });
            items.Add(new SelectListItem { Text = "03 AM", Value = "03 AM" });
            items.Add(new SelectListItem { Text = "04 AM", Value = "04 AM" });
            items.Add(new SelectListItem { Text = "05 AM", Value = "05 AM" });
            items.Add(new SelectListItem { Text = "06 AM", Value = "06 AM" });
            items.Add(new SelectListItem { Text = "07 AM", Value = "07 AM" });
            items.Add(new SelectListItem { Text = "08 AM", Value = "08 AM" });
            items.Add(new SelectListItem { Text = "09 AM", Value = "09 AM" });
            items.Add(new SelectListItem { Text = "10 AM", Value = "10 AM" });
            items.Add(new SelectListItem { Text = "11 AM", Value = "11 AM" });
            items.Add(new SelectListItem { Text = "12 PM", Value = "12 PM" });
            items.Add(new SelectListItem { Text = "01 PM", Value = "01 PM" });
            items.Add(new SelectListItem { Text = "02 PM", Value = "02 PM" });
            items.Add(new SelectListItem { Text = "03 PM", Value = "03 PM" });
            items.Add(new SelectListItem { Text = "04 PM", Value = "04 PM" });
            items.Add(new SelectListItem { Text = "05 PM", Value = "05 PM" });
            items.Add(new SelectListItem { Text = "06 PM", Value = "06 PM" });
            items.Add(new SelectListItem { Text = "07 PM", Value = "07 PM" });
            items.Add(new SelectListItem { Text = "08 PM", Value = "08 PM" });
            items.Add(new SelectListItem { Text = "09 PM", Value = "09 PM" });
            items.Add(new SelectListItem { Text = "10 PM", Value = "10 PM" });
            items.Add(new SelectListItem { Text = "11 PM", Value = "11 PM" });

            return items;
        }
        public static List<SelectLstItem1> ShiftList()
        {
            List<SelectLstItem1> list = new List<SelectLstItem1>();
            list.Add(new SelectLstItem1() { Text = "Morning", Value = "M" });
            list.Add(new SelectLstItem1() { Text = "Evening", Value = "E" });
            list.Add(new SelectLstItem1() { Text = "Night", Value = "N" });
            return list;
        }

        public static string GetShiftSeq(string shift)
        {
            if (shift == "M")
                return "1. ";
            else if (shift == "E")
                return "2. ";
            else if (shift == "N")
                return "3. ";
            else
                return "";
        }

        public static string ConvertTo12HourFormat(string inputTime)
        {
            if (inputTime != "")
            {
                DateTime parsedTime;

                if (DateTime.TryParse(inputTime, out parsedTime))
                {
                    return parsedTime.ToString("hh:mm:ss tt");
                }
            }
            else
            {
                inputTime = "";
            }
            return inputTime;
        }
        public DataSet GetIPPatInfo1(string strIPno, string strMRNo, string strPatFNm, string strPatMNm, string strPatLNm,
         string strPatDOB, string strPatContact, string strAdmnFrmDt, string strAdmnToDt, string strStatus, string strPatNm,
       string strNurstCD, string strMLCYN, string strAdmnDoct, string strBillYn = "", string strEmpID = "")
        {
            CommonServiceClient com = new CommonServiceClient();
            return com.GetIPPatInfo(strIPno, strMRNo, strPatFNm, strPatMNm, strPatLNm,
             strPatDOB, strPatContact, strAdmnFrmDt, strAdmnToDt, strStatus, strPatNm,
           strNurstCD, strMLCYN, strAdmnDoct, strBillYn, strEmpID);
        }
        public static List<SelectListItem> GetPhysiotherapyList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Chest PT", Value = "01" });
            items.Add(new SelectListItem { Text = "Limb PT (Passive)", Value = "02" });
            items.Add(new SelectListItem { Text = "Limb PT (Active)", Value = "03" });
            items.Add(new SelectListItem { Text = "OOB Mobilisation", Value = "04" });
            items.Add(new SelectListItem { Text = "Others", Value = "05" });
            return items;
        }
        public static List<SelectListItem> GetDietList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "NBM", Value = "01" });
            items.Add(new SelectListItem { Text = "Full Diet", Value = "02" });
            items.Add(new SelectListItem { Text = "Soft Diet", Value = "03" });
            items.Add(new SelectListItem { Text = "Liqids", Value = "04" });
            items.Add(new SelectListItem { Text = "Diabetic", Value = "05" });
            items.Add(new SelectListItem { Text = "Diabetic & Salt Restricted", Value = "07" });
            items.Add(new SelectListItem { Text = "Low Protein", Value = "08" });
            items.Add(new SelectListItem { Text = "High Protein", Value = "09" });
            items.Add(new SelectListItem { Text = "Others", Value = "10" });
            return items;
        }
        public static List<SelectListItem> GetIsolationPrecautionList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "None", Value = "N" });
            items.Add(new SelectListItem { Text = "Contact", Value = "C" });
            items.Add(new SelectListItem { Text = "Droplet", Value = "D" });
            items.Add(new SelectListItem { Text = "Airborne", Value = "A" });
            return items;
        }
        public static List<SelectListItem> GetO2deliveredbyList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Room Air", Value = "RA" });
            items.Add(new SelectListItem { Text = "Nasal prong", Value = "NP" });
            items.Add(new SelectListItem { Text = "O2 Mask", Value = "OM" });
            items.Add(new SelectListItem { Text = "High Conc. Mask", Value = "HCM" });
            items.Add(new SelectListItem { Text = "ET Venti", Value = "ETV" });
            items.Add(new SelectListItem { Text = "ET 'T' Piece", Value = "ETT" });
            items.Add(new SelectListItem { Text = "Tracheostomy Venti", Value = "TV" });
            items.Add(new SelectListItem { Text = "Tracheostomy 'T' Piece", Value = "TT" });
            items.Add(new SelectListItem { Text = "Tracheostomy Room Air", Value = "TRA" });
            items.Add(new SelectListItem { Text = "Non Invasive Venti", Value = "NIV" });
            items.Add(new SelectListItem { Text = "Nasal Intubated Venti", Value = "NSV" });
            items.Add(new SelectListItem { Text = "Nasal Intubated 'T' Piece", Value = "NIT" });
            items.Add(new SelectListItem { Text = "Venturi Mask", Value = "VM" });
            items.Add(new SelectListItem { Text = "Tracheostomy Bipap", Value = "TB" });
            items.Add(new SelectListItem { Text = "Tracheostomy Bipap Room Air", Value = "TBA" });
            return items;
        }
        public static List<SelectListItem> GetLevelOfConciousnessList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Alert", Value = "01" });
            items.Add(new SelectListItem { Text = "Restless", Value = "02" });
            items.Add(new SelectListItem { Text = "Lethargic", Value = "03" });
            items.Add(new SelectListItem { Text = "Confused", Value = "04" });
            items.Add(new SelectListItem { Text = "Sedated", Value = "05" });
            items.Add(new SelectListItem { Text = "Comatose", Value = "06" });
            items.Add(new SelectListItem { Text = "Somnolent", Value = "09" });
            items.Add(new SelectListItem { Text = "Agitated", Value = "10" });
            items.Add(new SelectListItem { Text = "Others", Value = "07" });
            items.Add(new SelectListItem { Text = "NA", Value = "08" });

            return items;
        }
        public static List<SelectListItem> GetSkinConditionList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Warm & Moist", Value = "01" });
            items.Add(new SelectListItem { Text = "Warm & Calmy ", Value = "02" });
            items.Add(new SelectListItem { Text = "Cold & Moist", Value = "03" });
            items.Add(new SelectListItem { Text = "Cold & Calmy", Value = "04" });
            items.Add(new SelectListItem { Text = "Warm", Value = "05" });
            items.Add(new SelectListItem { Text = "Moist", Value = "06" });
            items.Add(new SelectListItem { Text = "Cold", Value = "07" });
            items.Add(new SelectListItem { Text = "Calmy", Value = "08" });

            return items;
        }
        public static List<SelectListItem> GetSkinColorList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Pink", Value = "01" });
            items.Add(new SelectListItem { Text = "Pale", Value = "02" });
            items.Add(new SelectListItem { Text = "Flushed", Value = "03" });
            items.Add(new SelectListItem { Text = "Cyanotic", Value = "04" });
            return items;
        }
        public static List<SelectListItem> GetOccupationList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Self-Employed", Value = "01" });
            items.Add(new SelectListItem { Text = "Service", Value = "02" });
            items.Add(new SelectListItem { Text = "House Wife", Value = "03" });
            items.Add(new SelectListItem { Text = "Retired", Value = "04" });
            return items;
        }
        public static List<SelectListItem> GetCharacterOfPainList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Burning", Value = "01" });
            items.Add(new SelectListItem { Text = "Lancinating", Value = "02" });
            items.Add(new SelectListItem { Text = "Radiating", Value = "03" });
            items.Add(new SelectListItem { Text = "Dull", Value = "05" });
            items.Add(new SelectListItem { Text = "Sharp", Value = "06" });
            items.Add(new SelectListItem { Text = "Throbbing", Value = "07" });
            items.Add(new SelectListItem { Text = "Aching", Value = "08" });
            items.Add(new SelectListItem { Text = "Cramping", Value = "09" });
            items.Add(new SelectListItem { Text = "Shooting", Value = "10" });
            items.Add(new SelectListItem { Text = "Tingling", Value = "11" });
            items.Add(new SelectListItem { Text = "Pressure", Value = "12" });
            return items;
        }
        public static List<SelectListItem> GetSpeechList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "NA", Value = "01" });
            items.Add(new SelectListItem { Text = "Normal", Value = "02" });
            items.Add(new SelectListItem { Text = "Slurred", Value = "03" });
            items.Add(new SelectListItem { Text = "Aphasic", Value = "04" });
            items.Add(new SelectListItem { Text = "Dysphonic", Value = "05" });
            items.Add(new SelectListItem { Text = "Clear", Value = "06" });
            items.Add(new SelectListItem { Text = "None", Value = "07" });
            return items;
        }
        public static List<SelectListItem> GetShapeList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Normal", Value = "N" });
            items.Add(new SelectListItem { Text = "Abnormal", Value = "A" });
            items.Add(new SelectListItem { Text = "NA", Value = "NA" });
            return items;
        }
        public static List<SelectListItem> GetReactionList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Brisk", Value = "B" });
            items.Add(new SelectListItem { Text = "Sluggish", Value = "S" });
            items.Add(new SelectListItem { Text = "Absent", Value = "A" });
            items.Add(new SelectListItem { Text = "Abnormal side", Value = "As" });
            items.Add(new SelectListItem { Text = "NA", Value = "NA" });
            return items;
        }
        public static List<SelectListItem> GetExtraOccularMvemntList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Complete In All Directions", Value = "C" });
            items.Add(new SelectListItem { Text = "Restricted", Value = "R" });
            items.Add(new SelectListItem { Text = "NA", Value = "NA" });
            return items;
        }
        public static List<SelectListItem> GetGaitList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Normal", Value = "N" });
            items.Add(new SelectListItem { Text = "Abnormal", Value = "A" });
            items.Add(new SelectListItem { Text = "Cannot be Assessed", Value = "C" });
            return items;
        }
        public static List<SelectListItem> GetFacialSymmetryList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Symmetric", Value = "01" });
            items.Add(new SelectListItem { Text = "ASymmetric", Value = "02" });
            items.Add(new SelectListItem { Text = "Abnormal side", Value = "03" });
            return items;
        }
        public static List<SelectListItem> GetMaleBrstList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Pain", Value = "01" });
            items.Add(new SelectListItem { Text = "Lumps", Value = "02" });
            items.Add(new SelectListItem { Text = "Swelling", Value = "03" });
            items.Add(new SelectListItem { Text = "Nipple discharge", Value = "04" });
            return items;
        }
        public static List<SelectListItem> GetEmotionalStatusList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Cooperative", Value = "01" });
            items.Add(new SelectListItem { Text = "Anxious", Value = "02" });
            items.Add(new SelectListItem { Text = "Depressed", Value = "03" });
            items.Add(new SelectListItem { Text = "Restless", Value = "04" });

            return items;
        }
        public static List<SelectListItem> GetPowerList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Complete Paralysis", Value = "0" });
            items.Add(new SelectListItem { Text = "Flicker of Contraction", Value = "1" });
            items.Add(new SelectListItem { Text = "Gravity Excluded", Value = "2" });
            items.Add(new SelectListItem { Text = "Against Gravity", Value = "3" });
            items.Add(new SelectListItem { Text = "Against Some Resistance", Value = "4" });
            items.Add(new SelectListItem { Text = "Normal Power", Value = "5" });
            items.Add(new SelectListItem { Text = "NA", Value = "N" });
            return items;
        }
        public static string GetFstNameUserId(string strUserID)
        {
            string UserName = "";
            CommonServiceClient SecUser = new CommonServiceClient();
            List<string> NameUsrIdLst = new List<string>();
            List<UserLstItem> userLst = null;
            userLst = SecUser.GetUserList().ToList();
            string[] SplitID = strUserID.Split(',');
            int len = SplitID.Length;
            if (strUserID.Trim() != "")
            {
                if (len > 1)
                {
                    for (int i = 0; i < len; i++)
                    {
                        string Id = SplitID[i];
                        UserName = userLst.Where(x => x.UserId == Id.ToString().Trim()).FirstOrDefault().Text;
                        string[] splitnames = UserName.Split(' ');
                        string firstname = splitnames.First();
                        NameUsrIdLst.Add(firstname + " (" + Id + ")");
                    }
                    string NameUsrId = string.Join(Environment.NewLine, NameUsrIdLst.ToArray());
                    return NameUsrId;
                }
                else
                {
                    UserName = userLst.Where(x => x.UserId == strUserID.ToString().Trim()).FirstOrDefault().Text;
                    string[] splitnames = UserName.Split(' ');
                    if (UserName.Contains(" "))
                    {
                        string firstname = splitnames.First();
                        return firstname + " (" + strUserID + ")";
                    }
                    return UserName + " (" + strUserID + ")";
                }

            }
            return null;
        }
        public static string ConvertTo24HourFormat(string inputTime)
        {
            if (inputTime != "")
            {
                DateTime parsedTime;
                if (DateTime.TryParse(inputTime, out parsedTime))
                {
                    return parsedTime.ToString("HH:mm:ss");
                }
            }
            else
            {
                inputTime = "";
            }
            return inputTime;
        }
        public static string GetUserIdByUserName(string strUserName)
        {
            string UserId = "";
            CommonServiceClient comm = new CommonServiceClient();
            List<UserLstItem> userLst = null;
            userLst = comm.GetUserList().Where(u => u.STATUS == "A").ToList();
            if (userLst.Where(x => x.Text == (strUserName)).Count() > 0)
            {
                UserId = userLst.Where(x => x.Text.ToString().Trim() == ("" + strUserName.ToString().Trim()).ToString().Trim()).FirstOrDefault().UserId;
                return UserId;
            }
            return strUserName;
        }
        public static string GetUserName(string strUserID)
        {
            string UserName = "";
            CommonServiceClient comm = new CommonServiceClient();
            DataSet load = new DataSet();
            List<UserLstItem> userLst = null;
            userLst = comm.GetUserList().ToList();
            if (userLst.Where(x => x.UserId == (strUserID)).Count() > 0)
            {
                UserName = userLst.Where(x => x.UserId.ToString().Trim() == ("" + strUserID.ToString().Trim()).ToString().Trim()).FirstOrDefault().Text;
                return UserName;
            }

            return strUserID;
        }
        public static DataTable CombineTablesDistinct(List<DataTable> tables, List<string> columnNames, string dateColumn = null, string sortByColumn = null, bool ascending = true)
        {
            if (tables == null || tables.Count == 0 || columnNames == null || columnNames.Count == 0)
                return new DataTable();

            DataTable combined = new DataTable();
            columnNames.ForEach(c => combined.Columns.Add(c, typeof(string)));

            var seen = new HashSet<string>();

            foreach (var dt in tables ?? Enumerable.Empty<DataTable>())
            {
                if (dt == null) continue;

                foreach (DataRow row in dt.Rows)
                {
                    var newRow = combined.NewRow();
                    var keyParts = new List<string>();

                    foreach (var col in columnNames)
                    {
                        string val = "";
                        if (dt.Columns.Contains(col) && row[col] != DBNull.Value)
                        {
                            if (!string.IsNullOrEmpty(dateColumn) && col.Equals(dateColumn, StringComparison.OrdinalIgnoreCase))
                                val = GeneralFunction.GetDate(row[col].ToString());
                            else
                                val = row[col].ToString();
                        }

                        newRow[col] = val;
                        keyParts.Add(val);
                    }

                    string key = string.Join("|", keyParts);
                    if (!seen.Contains(key))
                    {
                        seen.Add(key);
                        combined.Rows.Add(newRow);
                    }
                }
            }

            if (!string.IsNullOrEmpty(sortByColumn) && combined.Columns.Contains(sortByColumn))
            {
                var dv = combined.DefaultView;
                dv.Sort = sortByColumn + (ascending ? " ASC" : " DESC");
                combined = dv.ToTable();
            }

            return combined;
        }
        public static string getHeaderFooterExcel(
      string frmName,
      string frmDate,
      string toDate,
      string FilterData = "",
      string strSerachCriteria = "",
      DataTable df = null,
      List<string> highlightAuditTitles = null,
      List<string> columnsToColor = null,
      List<string> indexedCol = null,
      List<string> rowColors = null,
      List<string> columnColors = null,
      int maxColumnColorRowCount = -1
  )
        {
            if (df.Columns.Contains("UNITCODE"))
                df.Columns.Remove("UNITCODE");

            System.IO.StringWriter sw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);

            GridView gv = new GridView();
            gv.ShowFooter = true;
            gv.BorderWidth = 0;
            gv.GridLines = GridLines.Both;
            gv.DataSource = df;

            gv.RowDataBound += (sender, e) =>
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    foreach (TableCell cell in e.Row.Cells)
                    {
                        string cellText = cell.Text;

                        if (!string.IsNullOrEmpty(cellText))
                        {
                            cell.Attributes.Add("style", "mso-number-format:\"@\";");
                            cell.Text = cellText + "\u00A0";
                        }
                    }
                }
            };
            highlightAuditTitles = highlightAuditTitles ?? new List<string>();
            columnsToColor = columnsToColor ?? new List<string>();
            indexedCol = indexedCol ?? new List<string>();
            rowColors = rowColors ?? new List<string>();
            columnColors = columnColors ?? new List<string>();
            int auditIndex = indexedCol.Count > 0 ? df.Columns.IndexOf(indexedCol[0]) : -1;
            Dictionary<string, int> columnNameToIndex = new Dictionary<string, int>();
            foreach (string col in columnsToColor)
            {
                int idx = df.Columns.IndexOf(col);
                if (idx >= 0)
                    columnNameToIndex[col] = idx;
            }
            int currentRowIndex = 0;
            gv.RowDataBound += (sender, e) =>
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    if (auditIndex >= 0 && auditIndex < e.Row.Cells.Count)
                    {
                        string auditTitle = System.Net.WebUtility.HtmlDecode(e.Row.Cells[auditIndex].Text).Trim().Replace("’", "'").ToUpper();
                        int matchIndex = highlightAuditTitles.FindIndex(x =>
                            x != null && System.Net.WebUtility.HtmlDecode(x).Trim().Replace("’", "'").ToUpper() == auditTitle
                        );

                        if (matchIndex >= 0 && matchIndex < rowColors.Count)
                        {
                            Color rowColor = Color.FromName(rowColors[matchIndex]);
                            e.Row.BackColor = rowColor;
                        }
                    }
                    if (maxColumnColorRowCount == -1 || currentRowIndex < maxColumnColorRowCount)
                    {
                        foreach (var kvp in columnNameToIndex)
                        {
                            int colIndex = kvp.Value;
                            string colName = kvp.Key;

                            if (colIndex < e.Row.Cells.Count)
                            {
                                int colorIndex = columnsToColor.IndexOf(colName);
                                if (colorIndex >= 0 && colorIndex < columnColors.Count)
                                {
                                    Color colColor = Color.FromName(columnColors[colorIndex]);
                                    e.Row.Cells[colIndex].BackColor = colColor;
                                }
                            }
                        }
                    }
                    currentRowIndex++;
                }
            };
            gv.DataBind();
            gv.RenderControl(htw);
            StringBuilder sSchema = new StringBuilder();
            string formheader = frmName;
            if (!String.IsNullOrEmpty(frmDate) && !String.IsNullOrEmpty(toDate))
            {
                formheader += frmDate == toDate
                    ? " - For " + frmDate
                    : " - From " + frmDate + " To " + toDate;
            }
            string filterText = "N/A";
            if (!string.IsNullOrWhiteSpace(FilterData))
            {
                filterText = "";
                DataTable FilterDt = JsonConvert.DeserializeObject<DataTable>(FilterData);
                foreach (DataRow dr in FilterDt.Rows)
                {
                    if (dr[0].ToString().Trim() == "STATUS")
                    {
                        filterText += dr[0] + " : " + (dr[2].ToString().Trim() == "A" ? "Active" : "Cancel") + " ,  ";
                    }
                    else
                    {
                        filterText += dr[0] + " : " + dr[2] + ",  ";
                    }
                }
                int lasti = filterText.LastIndexOf(',');
                if (lasti > 0) { filterText = filterText.Remove(lasti, 1); }
            }
            if (string.IsNullOrWhiteSpace(strSerachCriteria))
                strSerachCriteria = "N/A";
            string AllData;
            if (frmName.ToUpper().Contains("NURSING"))
            {
                AllData = "<table><tr><th scope='col' colspan='" + df.Columns.Count + "'>" + formheader + "</th></tr>" +
                          "<tr><td scope='col' colspan='" + df.Columns.Count + "'></td></tr></table>";
            }
            else
            {
                AllData = "<table><tr><th scope='col' colspan='" + df.Columns.Count + "'>" + formheader + "</th></tr>" +
                          "<tr><td scope='col' colspan='" + df.Columns.Count + "'>Search Criteria : " + strSerachCriteria + "</td></tr>" +
                          "<tr><td scope='col' colspan='" + df.Columns.Count + "'>Filter Criteria : " + filterText + "</td></tr></table>";
            }
            AllData += sw.ToString();
            sSchema.Append("<html xmlns:x=urn:schemas-microsoft-com:office:excel><head>");
            sSchema.Append("<xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>");
            sSchema.Append("<x:WorksheetOptions><x:Panes></x:Panes></x:WorksheetOptions>");
            sSchema.Append("</x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml>");
            sSchema.Append("</head><body>");
            sSchema.Append(AllData);
            sSchema.Append("</body></html>");

            return sSchema.ToString();
        }
        public static string GetSpecialityDoctor(IEnumerable<dynamic> DoctList, IEnumerable<dynamic> SpecList, string DoctorCD = "", string DoctName = "")
        {
            if (!string.IsNullOrWhiteSpace(DoctorCD) || !string.IsNullOrWhiteSpace(DoctName))
            {
                var doctor = !string.IsNullOrWhiteSpace(DoctName) ? DoctList.FirstOrDefault(x => x.Text == DoctName) : DoctList.FirstOrDefault(x => x.Value == DoctorCD);
                if (doctor != null && !string.IsNullOrWhiteSpace(doctor.Specialization))
                {
                    var spec = SpecList.FirstOrDefault(x => x.Value == doctor.Specialization);
                    if (spec != null)
                    {
                        return spec.Text;
                    }
                }
            }



            return "";
        }


        #region EMR Records

        public static List<SelectLstItem> AssmntList()
        {
            List<SelectLstItem> list = new List<SelectLstItem>();
            list.Add(new SelectLstItem() { Text = "Radial", Value = "R" });
            list.Add(new SelectLstItem() { Text = "Femoral", Value = "F" });
            list.Add(new SelectLstItem() { Text = "Others", Value = "O" });

            list.Add(new SelectLstItem() { Text = "Jugular", Value = "J" });
            list.Add(new SelectLstItem() { Text = "Subclavian", Value = "S" });
            list.Add(new SelectLstItem() { Text = "Ryles tube", Value = "T" });

            list.Add(new SelectLstItem() { Text = "Percutaneous Enterogastric Tube", Value = "P" });
            list.Add(new SelectLstItem() { Text = "Nasojejunal tube", Value = "N" });
            list.Add(new SelectLstItem() { Text = "Foleys", Value = "Y" });

            list.Add(new SelectLstItem() { Text = "Supra-pubic", Value = "U" });
            list.Add(new SelectLstItem() { Text = "Silicon", Value = "L" });
            list.Add(new SelectLstItem() { Text = " Jejunostomy tube", Value = "M" });
            return list;
        }
        public static List<SelectLstItem> SideList()
        {
            List<SelectLstItem> list = new List<SelectLstItem>();
            list.Add(new SelectLstItem() { Text = "Left", Value = "L" });
            list.Add(new SelectLstItem() { Text = "Right", Value = "R" });
            return list;
        }
        public static List<SelectLstItem> ConditionList()
        {
            List<SelectLstItem> list = new List<SelectLstItem>();
            list.Add(new SelectLstItem() { Text = "No redness,No leak,No air", Value = "O" });
            list.Add(new SelectLstItem() { Text = "Redness at site", Value = "R" });
            list.Add(new SelectLstItem() { Text = "Swelling at site", Value = "Sw" });
            list.Add(new SelectLstItem() { Text = "Discontinued", Value = "D/C" });
            list.Add(new SelectLstItem() { Text = "Positional", Value = "P" });
            list.Add(new SelectLstItem() { Text = "Blocked", Value = "B" });
            list.Add(new SelectLstItem() { Text = "Redressed Swelling at site", Value = "R+Sw" });
            list.Add(new SelectLstItem() { Text = "Draining", Value = "Dr" });
            return list;
        }
        public static List<SelectLstItem> TUBELIST()
        {
            List<SelectLstItem> list = new List<SelectLstItem>();
            list.Add(new SelectLstItem() { Text = "Arterial Line I", Value = "01" });
            list.Add(new SelectLstItem() { Text = "Arterial Line II", Value = "02" });
            list.Add(new SelectLstItem() { Text = "Arterial Line III", Value = "03" });
            list.Add(new SelectLstItem() { Text = "Arterial Line IV", Value = "04" });
            list.Add(new SelectLstItem() { Text = "Central Line I", Value = "05" });
            list.Add(new SelectLstItem() { Text = "Central Line II", Value = "06" });
            list.Add(new SelectLstItem() { Text = "Central Line III", Value = "07" });
            list.Add(new SelectLstItem() { Text = "Central Line IV", Value = "08" });

            list.Add(new SelectLstItem() { Text = "Dialysis Catheter I", Value = "09" });
            list.Add(new SelectLstItem() { Text = "Dialysis Catheter II", Value = "10" });
            list.Add(new SelectLstItem() { Text = "Dialysis Catheter III", Value = "11" });
            list.Add(new SelectLstItem() { Text = "Dialysis Catheter IV", Value = "12" });

            list.Add(new SelectLstItem() { Text = "P.A Catheter I", Value = "13" });
            list.Add(new SelectLstItem() { Text = "P.A Catheter II", Value = "14" });

            list.Add(new SelectLstItem() { Text = "Feeding Tube", Value = "15" });
            list.Add(new SelectLstItem() { Text = "Urinary Catheter I", Value = "16" });
            list.Add(new SelectLstItem() { Text = "Urinary Catheter II", Value = "17" });
            list.Add(new SelectLstItem() { Text = "Urinary Catheter III", Value = "18" });

            list.Add(new SelectLstItem() { Text = "Urinary Catheter IV", Value = "19" });
            list.Add(new SelectLstItem() { Text = "Peripheral Line I", Value = "20" });
            list.Add(new SelectLstItem() { Text = "Peripheral Line II", Value = "21" });
            list.Add(new SelectLstItem() { Text = "Peripheral Line III", Value = "22" });
            list.Add(new SelectLstItem() { Text = "Peripheral Line IV", Value = "23" });

            list.Add(new SelectLstItem() { Text = "Temporary Pace maker I", Value = "24" });
            list.Add(new SelectLstItem() { Text = "Temporary Pace maker II", Value = "25" });
            list.Add(new SelectLstItem() { Text = "Temporary Pace maker III", Value = "26" });
            list.Add(new SelectLstItem() { Text = "Temporary Pace maker IV", Value = "27" });
            list.Add(new SelectLstItem() { Text = "I.A.B.P.", Value = "28" });
            list.Add(new SelectLstItem() { Text = "Endotrachael Tube I", Value = "29" });
            list.Add(new SelectLstItem() { Text = "Endotrachael Tube II", Value = "30" });
            list.Add(new SelectLstItem() { Text = "Endotrachael Tube III", Value = "31" });

            list.Add(new SelectLstItem() { Text = "Nasotrachael Tube I", Value = "32" });
            list.Add(new SelectLstItem() { Text = "Nasotrachael Tube II", Value = "33" });
            list.Add(new SelectLstItem() { Text = "Nasotrachael Tube III", Value = "34" });
            list.Add(new SelectLstItem() { Text = "Tracheostomy Tube", Value = "35" });
            list.Add(new SelectLstItem() { Text = "Ventilator", Value = "36" });
            list.Add(new SelectLstItem() { Text = "DrainTubes", Value = "37" });

            list.Add(new SelectLstItem() { Text = "Mediastinal Tube I", Value = "38" });
            list.Add(new SelectLstItem() { Text = "Mediastinal Tube II", Value = "39" });
            list.Add(new SelectLstItem() { Text = "Left Pleural I", Value = "40" });
            list.Add(new SelectLstItem() { Text = "Left Pleural II", Value = "41" });
            list.Add(new SelectLstItem() { Text = "Right Pleural I", Value = "42" });
            list.Add(new SelectLstItem() { Text = "Right Pleural II", Value = "43" });
            list.Add(new SelectLstItem() { Text = "Pericardial", Value = "44" });
            list.Add(new SelectLstItem() { Text = "Abdominal Drain I", Value = "45" });
            list.Add(new SelectLstItem() { Text = "Abdominal Drain II", Value = "46" });
            list.Add(new SelectLstItem() { Text = "Morrison Drain", Value = "47" });
            list.Add(new SelectLstItem() { Text = "Plevic Drain", Value = "48" });
            list.Add(new SelectLstItem() { Text = "Pancreatic Head", Value = "49" });
            list.Add(new SelectLstItem() { Text = "Pancreatic Tail", Value = "50" });
            list.Add(new SelectLstItem() { Text = "Romovac Drain", Value = "51" });
            list.Add(new SelectLstItem() { Text = "Radial Drain", Value = "52" });
            list.Add(new SelectLstItem() { Text = "OTHERTXT", Value = "53" });
            list.Add(new SelectLstItem() { Text = "", Value = "54" });
            list.Add(new SelectLstItem() { Text = "", Value = "55" });
            list.Add(new SelectLstItem() { Text = "", Value = "56" });
            list.Add(new SelectLstItem() { Text = "", Value = "57" });
            list.Add(new SelectLstItem() { Text = "", Value = "58" });
            list.Add(new SelectLstItem() { Text = "", Value = "59" });
            return list;
        }

        #endregion EMR Records


        public static List<SelectListItem> GetUnitList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Centimeter(S)", Value = "CM" });
            items.Add(new SelectListItem { Text = "Cubi Centimeter", Value = "CC" });
            items.Add(new SelectListItem { Text = "Gram", Value = "G" });
            items.Add(new SelectListItem { Text = "KiloCalorie", Value = "KCAL" });
            items.Add(new SelectListItem { Text = "Kilogram", Value = "KG" });
            items.Add(new SelectListItem { Text = "Litre", Value = "L" });
            items.Add(new SelectListItem { Text = "Milligram", Value = "MG" });
            items.Add(new SelectListItem { Text = "Millilitre", Value = "ML" });
            items.Add(new SelectListItem { Text = "Millimetre", Value = "MM" });
            items.Add(new SelectListItem { Text = "Millimole", Value = "MMOL" });
            items.Add(new SelectListItem { Text = "Milliequivalent", Value = "MEQ" });
            items.Add(new SelectListItem { Text = "Microgram", Value = "MCG" });
            items.Add(new SelectListItem { Text = "Ounce", Value = "OZ" });
            items.Add(new SelectListItem { Text = "International Units", Value = "IU" });
            items.Add(new SelectListItem { Text = "Tablet", Value = "TAB" });
            items.Add(new SelectListItem { Text = "Ampoule", Value = "AMP" });
            items.Add(new SelectListItem { Text = "Milliequivalent", Value = "MEQ" });
            items.Add(new SelectListItem { Text = "Tablespoon", Value = "TBLSP" });
            items.Add(new SelectListItem { Text = "Teaspoon", Value = "TSP" });
            items.Add(new SelectListItem { Text = "Respules", Value = "RESP" });
            items.Add(new SelectListItem { Text = "Quantity Sufficient", Value = "QS" });
            return items;
        }

        //Pournima 27th Jan 2026 - As per EMR
        public static List<SelectListItem> MedicineRouteForChemo()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Intra muscular", Value = "01" });
            items.Add(new SelectListItem { Text = "Intra venous", Value = "02" });
            items.Add(new SelectListItem { Text = "Subcutaneous", Value = "03" });
            items.Add(new SelectListItem { Text = "Intra dermal", Value = "04" });
            items.Add(new SelectListItem { Text = "Intrathecal", Value = "05" });
            items.Add(new SelectListItem { Text = "Epidural", Value = "06" });
            items.Add(new SelectListItem { Text = "Intra articular", Value = "07" });
            items.Add(new SelectListItem { Text = "Intra osseous", Value = "08" });
            items.Add(new SelectListItem { Text = "Per oral", Value = "09" });
            items.Add(new SelectListItem { Text = "Per rectum", Value = "10" });
            items.Add(new SelectListItem { Text = "Per vagina", Value = "11" });
            items.Add(new SelectListItem { Text = "Sublingual", Value = "12" });
            items.Add(new SelectListItem { Text = "Nasal", Value = "13" });
            items.Add(new SelectListItem { Text = "Right ear", Value = "14" });
            items.Add(new SelectListItem { Text = "Left ear", Value = "15" });
            items.Add(new SelectListItem { Text = "Both ears", Value = "16" });
            items.Add(new SelectListItem { Text = "Right eye", Value = "17" });
            items.Add(new SelectListItem { Text = "Left eye", Value = "18" });
            items.Add(new SelectListItem { Text = "Both eyes", Value = "19" });
            items.Add(new SelectListItem { Text = "Transdermal", Value = "20" });
            items.Add(new SelectListItem { Text = "Nasogastric tube", Value = "21" });
            items.Add(new SelectListItem { Text = "PEG Tube", Value = "22" });
            items.Add(new SelectListItem { Text = "Jejunostomy tube", Value = "23" });
            items.Add(new SelectListItem { Text = "Local application", Value = "24" });
            items.Add(new SelectListItem { Text = "Tracheostomy Tube", Value = "25" });
            items.Add(new SelectListItem { Text = "Endotracheal Tube", Value = "26" });
            return items;
        }

        public static List<SelectListItem> Medicine_MedicineRoute()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Intra muscular", Value = "01" });
            items.Add(new SelectListItem { Text = "Intra venous", Value = "02" });
            items.Add(new SelectListItem { Text = "Subcutaneous", Value = "03" });
            items.Add(new SelectListItem { Text = "Intra dermal", Value = "04" });
            items.Add(new SelectListItem { Text = "Intrathecal", Value = "05" });
            items.Add(new SelectListItem { Text = "Epidural", Value = "06" });
            items.Add(new SelectListItem { Text = "Intra articular", Value = "07" });
            items.Add(new SelectListItem { Text = "Intra osseous", Value = "08" });
            items.Add(new SelectListItem { Text = "Per oral", Value = "09" });
            items.Add(new SelectListItem { Text = "Per rectum", Value = "10" });
            items.Add(new SelectListItem { Text = "Per vagina", Value = "11" });
            items.Add(new SelectListItem { Text = "Sublingual", Value = "12" });
            items.Add(new SelectListItem { Text = "Nasal", Value = "13" });
            items.Add(new SelectListItem { Text = "Right ear", Value = "14" });
            items.Add(new SelectListItem { Text = "Left ear", Value = "15" });
            items.Add(new SelectListItem { Text = "Both ears", Value = "16" });
            items.Add(new SelectListItem { Text = "Right eye", Value = "17" });
            items.Add(new SelectListItem { Text = "Left eye", Value = "18" });
            items.Add(new SelectListItem { Text = "Both eyes", Value = "19" });
            items.Add(new SelectListItem { Text = "Transdermal", Value = "20" });
            items.Add(new SelectListItem { Text = "Nasogastric tube", Value = "21" });
            items.Add(new SelectListItem { Text = "PEG Tube", Value = "22" });
            items.Add(new SelectListItem { Text = "Jejunostomy tube", Value = "23" });
            items.Add(new SelectListItem { Text = "Local application", Value = "24" });
            items.Add(new SelectListItem { Text = "Tracheostomy Tube", Value = "25" });
            items.Add(new SelectListItem { Text = "Endotracheal Tube", Value = "26" });
            return items;
        }
        public static List<SelectListItem> Medicine_DilutionVolume()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "5 ml", Value = "5 ml" });
            items.Add(new SelectListItem { Text = "10 ml", Value = "10 ml" });
            items.Add(new SelectListItem { Text = "15 ml", Value = "15 ml" });
            items.Add(new SelectListItem { Text = "20 ml", Value = "20 ml" });
            items.Add(new SelectListItem { Text = "25 ml", Value = "25 ml" });
            items.Add(new SelectListItem { Text = "50 ml", Value = "50 ml" });
            items.Add(new SelectListItem { Text = "75 ml", Value = "75 ml" });
            items.Add(new SelectListItem { Text = "100 ml", Value = "100 ml" });
            items.Add(new SelectListItem { Text = "125 ml", Value = "125 ml" });
            items.Add(new SelectListItem { Text = "150 ml", Value = "150 ml" });
            items.Add(new SelectListItem { Text = "175 ml", Value = "175 ml" });
            items.Add(new SelectListItem { Text = "200 ml", Value = "200 ml" });
            items.Add(new SelectListItem { Text = "250 ml", Value = "250 ml" });
            items.Add(new SelectListItem { Text = "275 ml", Value = "275 ml" });
            items.Add(new SelectListItem { Text = "300 ml", Value = "300 ml" });
            items.Add(new SelectListItem { Text = "400 ml", Value = "400 ml" });
            items.Add(new SelectListItem { Text = "500 ml", Value = "500 ml" });
            return items;
        }
        public static List<SelectListItem> Medicine_AdministrationDuration()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = " 1 min", Value = " 1 min" });
            items.Add(new SelectListItem { Text = " 5 min", Value = " 5 min" });
            items.Add(new SelectListItem { Text = " 10 min", Value = " 10 min" });
            items.Add(new SelectListItem { Text = " 15 min", Value = " 15 min" });
            items.Add(new SelectListItem { Text = " 20 min", Value = " 20 min" });
            items.Add(new SelectListItem { Text = " 30 min", Value = " 30 min" });

            items.Add(new SelectListItem { Text = "1 hr", Value = "1 hr" });
            items.Add(new SelectListItem { Text = "1 hr 10 min", Value = "1 hr 10 min" });
            items.Add(new SelectListItem { Text = "1 hr 15 min", Value = "1 hr 15 min" });
            items.Add(new SelectListItem { Text = "1 hr 20 min", Value = "1 hr 20 min" });
            items.Add(new SelectListItem { Text = "1 hr 30 min", Value = "1 hr 30 min" });


            items.Add(new SelectListItem { Text = "2 hr", Value = "2 hr" });
            items.Add(new SelectListItem { Text = "2 hr 10 min", Value = "2 hr 10 min" });
            items.Add(new SelectListItem { Text = "2 hr 15 min", Value = "2 hr 15 min" });
            items.Add(new SelectListItem { Text = "2 hr 20 min", Value = "2 hr 20 min" });
            items.Add(new SelectListItem { Text = "2 hr 30 min", Value = "2 hr 30 min" });


            items.Add(new SelectListItem { Text = "3 hr", Value = "3 hr" });
            items.Add(new SelectListItem { Text = "3 hr 10 min", Value = "3 hr 10 min" });
            items.Add(new SelectListItem { Text = "3 hr 15min", Value = "3 hr 15min" });
            items.Add(new SelectListItem { Text = "3 hr 20 min", Value = "3 hr 20 min" });
            items.Add(new SelectListItem { Text = "3 hr 30 min", Value = "3 hr 30 min" });



            items.Add(new SelectListItem { Text = "4 hr", Value = "4 hr" });
            items.Add(new SelectListItem { Text = "4 hr 10 min", Value = "4 hr 10 min" });
            items.Add(new SelectListItem { Text = "4 hr 15 min", Value = "4 hr 15 min" });
            items.Add(new SelectListItem { Text = "4 hr 20 min", Value = "4 hr 20 min" });
            items.Add(new SelectListItem { Text = "4 hr 30 min", Value = "4 hr 30 min" });


            items.Add(new SelectListItem { Text = "5 hr", Value = "5 hr" });
            items.Add(new SelectListItem { Text = "5 hr 10 min", Value = "5 hr 10 min" });
            items.Add(new SelectListItem { Text = "5 hr 15 min", Value = "5 hr 15 min" });
            items.Add(new SelectListItem { Text = "5 hr 20 min", Value = "5 hr 20 min" });
            items.Add(new SelectListItem { Text = "5 hr 30 min", Value = "5 hr 30 min" });


            items.Add(new SelectListItem { Text = "6 hr", Value = "6 hr" });
            items.Add(new SelectListItem { Text = "6 hr 10 min", Value = "6 hr 10 min" });
            items.Add(new SelectListItem { Text = "6 hr 15 min", Value = "6 hr 15 min" });
            items.Add(new SelectListItem { Text = "6 hr 20 min", Value = "6 hr 20 min" });
            items.Add(new SelectListItem { Text = "6 hr 30 min", Value = "6 hr 30 min" });

            items.Add(new SelectListItem { Text = "7 hr", Value = "7 hr" });
            items.Add(new SelectListItem { Text = "7 hr 10 min", Value = "7 hr 10 min" });
            items.Add(new SelectListItem { Text = "7 hr 15 min", Value = "7 hr 15 min" });
            items.Add(new SelectListItem { Text = "7 hr 20 min", Value = "7 hr 20 min" });
            items.Add(new SelectListItem { Text = "7 hr 30 min", Value = "7 hr 30 min" });

            items.Add(new SelectListItem { Text = "8 hr", Value = "8 hr" });
            items.Add(new SelectListItem { Text = "8 hr 10 min", Value = "8 hr 10 min" });
            items.Add(new SelectListItem { Text = "8 hr 15 min", Value = "8 hr 15 min" });
            items.Add(new SelectListItem { Text = "8 hr 20 min", Value = "8 hr 20 min" });
            items.Add(new SelectListItem { Text = "8 hr 30 min", Value = "8 hr 30 min" });

            items.Add(new SelectListItem { Text = "9 hr", Value = "9 hr" });
            items.Add(new SelectListItem { Text = "9 hr 10 min", Value = "9 hr 10 min" });
            items.Add(new SelectListItem { Text = "9 hr 15 min", Value = "9 hr 15 min" });
            items.Add(new SelectListItem { Text = "9 hr 20 min", Value = "9 hr 20 min" });
            items.Add(new SelectListItem { Text = "9 hr 30 min", Value = "9 hr 30 min" });

            items.Add(new SelectListItem { Text = "10 hr", Value = "10 hr" });

            return items;
        }

        public static string TestStatus(string strTestStatus)
        {
            if (strTestStatus.Trim() == "P")
            {
                return "Billed";
            }
            else if (strTestStatus.Trim() == "A")
            {
                return "Accepted";
            }
            else if (strTestStatus.Trim() == "S")
            {
                return "Collected";
            }
            else if (strTestStatus.Trim() == "R")
            {
                return "Reported";
            }
            else if (strTestStatus.Trim() == "V")
            {
                return "Verified";
            }
            else if (strTestStatus.Trim() == "C")
            {
                return "Cancelled";
            }
            return "";

        }

        public static object GetFormLinkRouteList()
        {
            OncologyEMR.Oncology.OncologyEMRClient OncServ = new OncologyEMR.Oncology.OncologyEMRClient();
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(OncServ.GetFormRouteLink()));
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var jsonData = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    Text = row["ROUTENM"]?.ToString(),
                                    Value = row["ROUTECD"]?.ToString(),
                                    FORMNAME = row["DESCR"]?.ToString(),
                                    FORMCODE = row["MTRLFORMID"]?.ToString(),
                                    DEFAULTYN = row["DEFUALTYN"]?.ToString(),
                                    QTYCALCFLAG = row["QTYCALCFLAG"]?.ToString()
                                }).ToArray();
                return jsonData;
            }
            return null;
        }

        public static List<SelectListItem> GetDrugFormList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            OncologyEMR.Oncology.OncologyEMRClient OncServ = new OncologyEMR.Oncology.OncologyEMRClient();
            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(OncServ.GetFormRouteLink()));
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataTable dtUnique = ds.Tables[0].DefaultView.ToTable(true, "MTRLFORMID", "DESCR");
                foreach (DataRow DR in dtUnique.Rows)
                {
                    items.Add(new SelectListItem { Text = ("" + DR["DESCR"]).ToString().Trim(), Value = ("" + DR["MTRLFORMID"]).ToString().Trim() });
                }
            }
            return items;
        }


        public static List<SelectListItem> PreAuthStatusList()
        {
            List<SelectListItem> items = new List<SelectListItem>();
            items.Add(new SelectListItem { Text = "Pending", Value = "P" });
            items.Add(new SelectListItem { Text = "Waiting For Approvel", Value = "W" });
            items.Add(new SelectListItem { Text = "Rejected", Value = "R" });
            items.Add(new SelectListItem { Text = "Approved", Value = "A" });
            return items;
        }

        public static byte[] SetHeaderFootermargTopBottom(DataSet AllData, string reportPath, string ImageletterHead = "N", string HeaderHeight = "", string FooterHeight = "")
        {
            try
            {
                string MarginTop = GetAppsettingUnitWiseValue("PrintLetterReportMarginTop");
                string MarginBottom = GetAppsettingUnitWiseValue("PrintLetterReportMarginBottom");
                string HeaderImageH = HeaderHeight == "" || HeaderHeight == null ? GetAppsettingUnitWiseValue("HeaderImageHeight") : HeaderHeight;
                string FooterImageH = FooterHeight == "" || FooterHeight == null ? GetAppsettingUnitWiseValue("FooterImageHeight") : FooterHeight;
                CrystalReportPdfResult cry = new CrystalReportPdfResult();
                CrystalDecisions.CrystalReports.Engine.ReportDocument reportDocument = new CrystalDecisions.CrystalReports.Engine.ReportDocument();
                reportDocument.Load(reportPath);
                if (ImageletterHead == "Y")
                {
                    foreach (CrystalDecisions.CrystalReports.Engine.Section section in reportDocument.ReportDefinition.Sections)
                    {
                        foreach (CrystalDecisions.CrystalReports.Engine.ReportObject reportObject in section.ReportObjects)
                        {
                            if (reportObject.Kind == CrystalDecisions.Shared.ReportObjectKind.BlobFieldObject && reportObject.Name == "RptFooter1")
                            {
                                CrystalDecisions.CrystalReports.Engine.BlobFieldObject blobFieldObject = (CrystalDecisions.CrystalReports.Engine.BlobFieldObject)reportObject;
                                blobFieldObject.Height = FooterImageH == "" || Convert.ToInt32(FooterImageH) <= 0 ? 1 : Convert.ToInt32(FooterImageH);

                            }
                            if (reportObject.Kind == CrystalDecisions.Shared.ReportObjectKind.BlobFieldObject && reportObject.Name == "RptHeader1")
                            {
                                CrystalDecisions.CrystalReports.Engine.BlobFieldObject blobFieldObject = (CrystalDecisions.CrystalReports.Engine.BlobFieldObject)reportObject;
                                blobFieldObject.Height = HeaderImageH == "" || Convert.ToInt32(HeaderImageH) <= 0 ? 1 : Convert.ToInt32(HeaderImageH);
                            }
                        }
                    }
                }
                byte[] printarr = cry.DynamicCrystalReportPdf(reportDocument, AllData, MarginTop, MarginBottom);
                return printarr;
            }
            catch (Exception ex)
            {
                WriteErrorLog(ex.Message);
                throw ex;
            }
        }
        public static void WriteErrorLog(string message)
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

        public static string GetCombinedValue(string firstValue, string secondValue)
        {
            var values = new List<string>();

            if (!string.IsNullOrWhiteSpace(firstValue))
            {
                values.Add(firstValue.Trim());
            }

            if (!string.IsNullOrWhiteSpace(secondValue))
            {
                values.Add(secondValue.Trim());
            }

            return string.Join(", ", values);
        }
    }

    public class HistoGradeList
    {
        public string Value { get; set; }
        public string Text { get; set; }
        public string GradeType { get; set; }
    }

    public class Helper
    {
        public static JwtSecurityToken DecodeToken(string token)
        {
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(token);
            return jsonToken as JwtSecurityToken;
        }

    }
    public class TokenResponse
    {
        private int _expires_in;
        private DateTime _expiryDate;
        public string access_token { get; set; }
        public int expires_in
        {
            get { return _expires_in; }
            set
            {
                _expires_in = value;
                _expiryDate = DateTime.Now.AddSeconds(_expires_in);
            }
        }
        public int refresh_expires_in { get; set; }
        public string refresh_token { get; set; }
        public string token_type { get; set; }
        public DateTime expiryDate
        {
            get { return _expiryDate; }
            set
            {
                _expiryDate = value;
            }
        }

    }

    public class TokenIntrospect
    {
        public Boolean active { get; set; }
        public string preferred_username { get; set;}
    }


}