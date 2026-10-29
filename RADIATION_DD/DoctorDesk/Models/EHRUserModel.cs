using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using OncologyEMR.OPServRef;
using OncologyEMR.CommonSerRef;
using OncologyEMR.DataClass;
using Newtonsoft.Json;
using System.Web.Script.Serialization;
using OncologyEMR.OncologyServRef;
using OncologyEMR.Oncology;
using System.Web.UI;
using System.Web.Mvc;
using OncologyEMR.Pdf;


namespace OncologyEMR.Models
{
    #region OP User Control
    public class UserControlModel
    {
        /// <summary>
        /// Patient Info
        /// </summary>
        ///  OutpatientClient op = new OutpatientClient();

        string space = "                                                                                          ";
        public string strpatCatgCd { get; set; }
        public string strMrNo { get; set; }
        public string strPatNm { get; set; }
        public string strGender { get; set; }
        public string strSalutation { get; set; }
        public string strTariffCatg { get; set; }
        public string strCompNm { get; set; }
        //pradnya
        public string strEmployeeId { get; set; }
        public string strAge { get; set; }
        public string strDOB { get; set; }
        public string strEmpNo { get; set; }
        public string strContactNo { get; set; }
        public string strPayType { get; set; }
        public string strPriority { get; set; }
        public string strPriorityCode { get; set; }
        public string strFirstNm { get; set; }
        public string strMidNm { get; set; }
        public string strLstNm { get; set; }
        public string strBillFrmDt { get; set; }
        public string strBillToDt { get; set; }
        public string strReqNo { get; set; }
        public string strReqTDT { get; set; }
        public string strReqFDT { get; set; }
        public string strIPNo { get; set; }
        public string strScheme { get; set; }
        public string strCapYN { get; set; }
        public double strLimit { get; set; }
        public string strMemberID { get; set; }

        /// <summary>
        /// Bill Info
        /// </summary>
        public string strBillNo { get; set; }
        public string strBillDate { get; set; }
        public string strBillTime { get; set; }
        public string strEmgTax { get; set; }
        public string strConsltNo { get; set; }
        public string strServiceTax { get; set; }
        public string strTotalAmt { get; set; }
        public string strCnAmtPat { get; set; }
        public string strCnAmtComp { get; set; }
        public string strDiscount { get; set; }
        public string strCompAmt { get; set; }
        public string strPatAmt { get; set; }
        public string strSurcharge { get; set; }
        public string strNetAmt { get; set; }
        public string strPayingAmt { get; set; }
        public string strCompPayingAmt { get; set; }
        public string strDueAmt { get; set; }
        public string strCompDueAmt { get; set; }
        public string strAdjustAmt { get; set; }
        public string strRefundAmt { get; set; }
        public string strExemptioncat { get; set; }
        //public string strEmployeeId { get; set; } // 01/06/2019
        public string strEmpId { get; set; }
        public string strLetterNo { get; set; }
        public string strEmpName { get; set; } //Added by Murali on 29/07/2024
        
        
        public object GETDATABILLWISE(string SBMRNo, string SBPatName, string SBFrmDate, string SBToDate, string SBBillNo,
            string formNameA)
        {
            DataSet load1 = new DataSet();
            DataTable jsondata = new DataTable();
            SBFrmDate = GeneralFunction.GetDateInSpecifiedFormat(SBFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            SBToDate = GeneralFunction.GetDateInSpecifiedFormat(SBToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            new OutpatientClient().UsingSafe(op =>
            {
                if (formNameA == "BCN")
                    load1 = op.GetBillInfo(SBFrmDate, SBToDate, "", "", "", "", "A", "", "", "", "", "", "", SBMRNo, SBPatName, "",
                        SBBillNo, "", "", "", System.Web.HttpContext.Current.Session["FundSource"].ToString(), "", "", "", "");
                else if (formNameA == "CDC")
                    load1 = op.GetBillInfo(SBFrmDate, SBToDate, "", "", "", "C", "A", "", "", "", "", "", "", SBMRNo, SBPatName, "",
                        "", "", "", "", System.Web.HttpContext.Current.Session["FundSource"].ToString(), SBBillNo, "", "", "");
                else if (formNameA == "BR")
                    load1 = op.GetBillInfo(SBFrmDate, SBToDate, "", "", "", "", "A", "<", "", "", "", "", "", SBMRNo, SBPatName, "",
                        SBBillNo, "", "", "", "", "", "", "", "");
                else if (formNameA == "OpDepositAdjustmentList")//
                {
                    load1 = op.GetBillInfo(SBFrmDate, SBToDate, "", "", "", "", "A", "", "", "", "", "", "", SBMRNo, SBPatName, "",
                       SBBillNo, "", "", "Y", "", "", "", "", "");
                }
                else
                    load1 = op.GetBillInfo(SBFrmDate, SBToDate, "", "", "", "", "A", "", "", "", "", "", "", SBMRNo, SBPatName, "",
                        SBBillNo, "", "", "", System.Web.HttpContext.Current.Session["FundSource"].ToString(), "", "", "", "");
            });
           
            jsondata = load1.Tables[0];
            if (formNameA == "BillChkLst")
            {
                if (jsondata.Select("HCCHKLSTYN='N'").Length > 0)
                    jsondata = jsondata.Select("HCCHKLSTYN='N'").CopyToDataTable();
                else
                    jsondata.Rows.Clear();
            }
          
            string space = "                                                                                          ";
            var jsonData = new
            {
                rows = (from DataRow row in jsondata.Rows
                        select new
                        {
                            id = row["BILLNO"].ToString(),
                            cell = new string[] {("" + row["MRNO"]).Trim(), GeneralFunction.CheckDblToSingleQuote(("" + row["PATNAME"]).Trim()),("" + row["BILLNO"]).Trim(),("" + row["OPCONSNO"]).Trim(),
                            GeneralFunction.GetDate(("" + row["BILLDATE"]).Trim()), ("" + row["BILLTIME"]).Trim(), ("" + row["TOTSERVAMT"]).Trim(),
                            ("" + row["DISCOUNT"]).Trim(), ("" + row["TOTSURCAMT"]).Trim(), ("" + row["TOTEMERGAMT"]).Trim(),
                            Convert.ToString(Convert.ToDouble(row["COMCNAMT"]) +Convert.ToDouble(row["PATCNAMT"])),
                            ("" + row["NETAMOUNT"]).Trim(), ("" + row["PATBILLAMT"]).Trim(),("" + row["COMBILLAMT"]).Trim(),("" + row["PATAMTPAID"]).Trim(), (""+row["COMAMTPAID"]).Trim(),
                            ("" + row["ADVADJAMT"]).Trim(),Convert.ToString((Convert.ToDouble(row["PATRFNDAMT"]) + Convert.ToDouble(row["COMRFNDAMT"]))),
                            ("" + row["PATDUE"]).Trim() ,("" + row["COMPDUE"]).Trim() , ("" + row["DOLLERRATE"]).Trim(), GeneralFunction.GetDate(("" + row["DOLLERDATE"]).Trim()),
                            ("" + row["SALUNAME"]).Trim() + space + ("" + row["SALUTATION"]).Trim(),
                            GeneralFunction.GetPatGender(("" + row["SEX"]).Trim()),
                            //Meenakshi change PATCATGNM to PATCATG in below line as it was showing wrong company name in patient catgory in patient info and also 
                            //it was givign error nin cedit bill while company patient search so please do not change 
                             //("" + row["PATCATGNM"]).Trim() + space + ("" + row["PATCATGCD"]).Trim(),
                            ("" + row["PATCATG"]).Trim() + space + ("" + row["PATCATGCD"]).Trim(),
                            (("" + row["COMPNAME"]).Trim() + space + ("" + row["CRDCOMPCD"]).Trim()),GeneralFunction.GetDate(("" + row["DOB"]).Trim()),
                            ("" + row["PATPHONE"]).Trim(),("" + row["TARIFFDESC"]).Trim() + space + ("" + row["TARIFFID"]).Trim(),
                            ("" + row["PAYTYPEMST"]).Trim() + space + ("" + row["PAYTYPE"]).Trim(),("" + row["AGE"]).Trim(),("" + row["PRIODESC"]).Trim()
                            //,(""+row["PATFNAME"]).Trim(),(""+row["PATMNAME"]).Trim(),(""+row["PATLNAME"]).Trim(),
                            ,(""+row["REFFROMOUT"]).Trim(),(""+row["REFDOCTCD"]).Trim(),GeneralFunction.CheckDblToSingleQuote((""+row["COCANAME"]).Trim()),
                            (""+row["PRIODESC"]).Trim(),(""+row["DEPTCODE"]).Trim(),("" + row["PATCNAMT"]).Trim(),("" + row["COMCNAMT"]).Trim(),
                            (""+row["SERVICETAX"]).Trim(),(""+row["HCCHKLSTYN"]).Trim(),
                            (""+row["PATCATGNM"]).Trim() //Meenakshi here pass pat cag name as it will display complay name if patient is company 
                            }
                        }).ToArray()
            };
            return jsonData;
        }
        public object GETOPSEARCHDATAREQWISE(string SMRNO, string SNAME, string SCONTACT, string SREQNO, string SREQFDT, string SREQTDT)
        {
            DataSet load1 = new DataSet();
            new OutpatientClient().UsingSafe(op =>
            {
                load1 = op.GetRefRquestList(SMRNO, SREQNO, "N", SNAME, GeneralFunction.GetDateInSpecifiedFormat(SREQFDT,
                    GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD),
                    GeneralFunction.GetDateInSpecifiedFormat(SREQTDT, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD), SCONTACT, "", "");
            });
            var jsonData = new
            {
                rows = (from DataRow row in load1.Tables[0].Rows
                        select new
                        {
                            id = row["REFREQNO"].ToString(),
                            cell = new string[] { row["MRNO"].ToString(),  row["SALUNAME"].ToString(), 
                                GeneralFunction.CheckDblToSingleQuote(row["PATNAME"].ToString()),
                                GeneralFunction .GetDate("" + row["PATDOB"].ToString().Trim()), row["PATAGE"].ToString(),
                                row["GENDER"].ToString(),
                                row["PATCATG"].ToString(),
                                row["TARIFFDESC"].ToString(),
                                row["PATMOBILE"].ToString(),
                               // row["COMPNAME"].ToString(),
                                row["PAYTYPDESC"].ToString(),
                                row["PRIODESC"].ToString(),
                                row["REFREQNO"].ToString(),
                                GeneralFunction .GetDate("" + row["REFREQDT"].ToString().Trim()), row["REFREQTM"].ToString(),
                                row["REFREQAMT"].ToString(), row["FUNDSOURCE"].ToString(),
                                GeneralFunction.CheckDblToSingleQuote(row["REMARK"].ToString()),GeneralFunction.CheckDblToSingleQuote(row["COCANAME"].ToString()),
                                row["PRIORITY"].ToString(),
                                }
                        }).ToArray()
            };
            return jsonData;
        }
        public object GETOPSEARCHDATA(string SMRNO, string SFNAME, string SMNAME, string SLNAME, string SCONTACT, string SDOB, string SOnlyComp = "N", string strEMPID ="")
        {
            string patcatg = "";
            DataSet dsPatInfoDetails = new DataSet();
            if ((SDOB + "").Trim() != "")
            {
                SDOB = GeneralFunction.GetDateInSpecifiedFormat(SDOB, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            DataTable l_oDT = new DataTable();
            new CommonServiceClient().UsingSafe(CommonServ =>
           {
               if (SOnlyComp == "Y")
                   patcatg = CommonServ.GetSetupValue("CREDITCOMPCATG");
               dsPatInfoDetails= GeneralFunction.FillDatasetXMl(CommonServ.GetOPPatientDetails(SMRNO, SFNAME, SMNAME, SLNAME, SCONTACT, "", SDOB, "",
                                                 "", patcatg, "", "", "", "", "", "", "", "", "Y", strEMPID));
           });
            if (dsPatInfoDetails.Tables.Count > 0)
                l_oDT = dsPatInfoDetails.Tables[0];
            var jsonData = new
            {
                rows = (from DataRow row in l_oDT.Rows
                        select new
                        {
                            id = row["MRNO"].ToString(),
                            cell = new string[] { 
                                row["MRNO"].ToString().Trim(),
                               GeneralFunction.CheckDblToSingleQuote(row["PATNAME"].ToString().Trim()),
                                GeneralFunction.GetDate("" + row["PATDOB"].ToString().Trim()),
                                row["PATAGE"].ToString().Trim(),
                                //row["PATSEX"].ToString().Trim(),//row["PATADDR1"].ToString()+ space + row["PATADDR2"].ToString()+ space + row["PATADDR3"].ToString(),
                                row["Gender"].ToString().Trim(),
                                GeneralFunction.CheckDblToSingleQuote(row["PATADDR1"].ToString().Trim()),
                                GeneralFunction.CheckDblToSingleQuote(row["PATADDR2"].ToString().Trim()),
                                GeneralFunction.CheckDblToSingleQuote(row["PATADDR3"].ToString().Trim()),
                                row["PATCATGNM"].ToString() + space + row["PATCATGCD"].ToString(),
                                row["TARIFFDESC"].ToString() + space + row["TARIFFID"].ToString(), 
                                row["PATMOBILE"].ToString(),
                                row["COMPNAME"].ToString()+ space + row["CRDCOMPCD"].ToString(),
                                l_oDT.Columns.Contains("PAYTYPDESC")? row["PAYTYPDESC"].ToString() + space + row["PAYTYPE"].ToString():"",
                                row["SALUNAME"].ToString() + space + row["SALUTATION"].ToString(),
                                row["CARDLIMIT"].ToString().Trim(),
                                row["AVLLMT"].ToString().Trim(),
                                row["COCANAME"].ToString() + space + row["CONSCATG"].ToString(),
                                row["APLIDAMT"].ToString().Trim(),
                                row["PREFDOCT"].ToString().Trim(),
                                row["PRIORITY"].ToString().Trim(),
                                row["ADMNSTATUS"].ToString().Trim(),
                                row["DEPSTAMT"].ToString().Trim(),
                                row["REFNDAMT"].ToString().Trim(),
                                row["IPTRANSFR"].ToString().Trim(),
                                GeneralFunction.CheckDblToSingleQuote(row["COCANAME"].ToString().Trim()),
                                row["PRIODESC"].ToString().Trim(),
                                row["TPALMT"].ToString().Trim(),
                                row["CITYID"].ToString().Trim(),
                                row["DISTRICTID"].ToString().Trim(),
                                row["PATFNAME"].ToString().Trim(),
                                row["PATMNAME"].ToString().Trim(),
                                row["PATLNAME"].ToString().Trim(),
                                row["PATEMAIL"].ToString().Trim(),
                                row["EMPID"].ToString().Trim(),
                                row["LETTERNO"].ToString().Trim(),
                                Convert.ToString(Convert.ToDouble(row["DEPSTAMT"])-(Convert.ToDouble(row["REFNDAMT"])+Convert.ToDouble(row["APLIDAMT"])+Convert.ToDouble(row["IPTRANSFR"])))
                                , l_oDT.Columns.Contains("CLINICCD") ? row["CLINICCD"].ToString().Trim() : "",
                                l_oDT.Columns.Contains("CARDNO") ? row["CARDNO"].ToString().Trim() : "",
                                 l_oDT.Columns.Contains("SCHEMECD") ? row["SCHEMENM"].ToString().Trim() + this.space + row["SCHEMECD"].ToString().Trim() : "",
                                l_oDT.Columns.Contains("CAPITZNYN") ? row["CAPITZNYN"].ToString().Trim() : "",
                                 row["COPAYAMT"].ToString().Trim(),
                                 row["EMPNAME"].ToString().Trim() //Added by Murali on 29/07/2024
                            }
                        }).ToArray()
            };
            return jsonData;
        }
        public void GETBILLDATA(UserControlModel UM, DataTable dt)
        {
            UM.strTotalAmt = ("" + dt.Rows[0]["TOTSERVAMT"]).Trim();
            UM.strCnAmtPat = ("0" + dt.Rows[0]["PATCNAMT"]).Trim();
            UM.strCnAmtComp = ("0" + dt.Rows[0]["COMCNAMT"]).Trim();
            UM.strPayingAmt = ("" + dt.Rows[0]["AMOUNTPAID"]).Trim();
            UM.strConsltNo = ("" + dt.Rows[0]["OPCONSNO"]).Trim();
            UM.strDiscount = ("" + dt.Rows[0]["DISCOUNT"]).Trim();
            UM.strNetAmt = ("" + dt.Rows[0]["NETAMOUNT"]).Trim();
            UM.strAdjustAmt = ("" + dt.Rows[0]["ADVADJAMT"]).Trim();
            UM.strBillDate = GeneralFunction.GetDate(("" + dt.Rows[0]["BILLDATE"]).Trim()); //+ "/" + ("" + dt.Rows[0]["BILLTIME"]).Trim();
            UM.strBillTime = ("" + dt.Rows[0]["BILLTIME"]).Trim();
            UM.strSurcharge = ("" + dt.Rows[0]["TOTSURCAMT"]).Trim();
            UM.strPatAmt = ("" + dt.Rows[0]["PATBILLAMT"]).Trim();
            UM.strRefundAmt = (Convert.ToDouble(("0" + dt.Rows[0]["PATRFNDAMT"]).Trim()) + Convert.ToDouble(("0" + dt.Rows[0]["COMRFNDAMT"]).Trim())).ToString();
            UM.strEmgTax = ("" + dt.Rows[0]["TOTEMERGAMT"]).Trim();
            UM.strCompAmt = ("" + dt.Rows[0]["COMBILLAMT"]).Trim();
            UM.strDueAmt = ("" + dt.Rows[0]["TOTALDUE"]).Trim();
            UM.strServiceTax = ("" + dt.Rows[0]["SERVICETAX"]).Trim();
            UM.strCompDueAmt = ("" + dt.Rows[0]["COMPDUE"]).Trim();
            UM.strCompPayingAmt = ("" + dt.Rows[0]["COMAMTPAID"]).Trim();
        }
        public void SETOPUSERCNTRLDATA(UserControlModel UM, DataTable l_oDS)
        {
            UM.strMrNo = l_oDS.Rows[0]["MRNO"].ToString();
            UM.strPatNm = GeneralFunction.CheckDblToSingleQuote(l_oDS.Rows[0]["PATNAME"].ToString());
            UM.strDOB = GeneralFunction.GetDate(l_oDS.Rows[0]["PATDOB"].ToString());
            UM.strAge = l_oDS.Rows[0]["PATAGE"].ToString();
            if (l_oDS.Rows[0]["PATSEX"].ToString() == "M")
            {
                UM.strGender = "Male";
            }
            else if (l_oDS.Rows[0]["PATSEX"].ToString() == "F")
            {
                UM.strGender = "Female";
            }
            else { UM.strGender = "Other"; }
            UM.strpatCatgCd = l_oDS.Rows[0]["PATCATGNM"].ToString();
            UM.strTariffCatg = l_oDS.Rows[0]["TARIFFDESC"].ToString();
            UM.strCompNm = l_oDS.Rows[0]["COMPNAME"].ToString();
            UM.strSalutation = l_oDS.Rows[0]["SALUNAME"].ToString();
            UM.strPayType = l_oDS.Rows[0]["PAYTYPDESC"].ToString();
            UM.strContactNo = l_oDS.Rows[0]["PATMOBILE"].ToString();
            UM.strExemptioncat = GeneralFunction.CheckDblToSingleQuote(l_oDS.Rows[0]["COCANAME"].ToString());
            UM.strPriority = l_oDS.Rows[0]["PRIODESC"].ToString();
            UM.strPriorityCode = l_oDS.Rows[0]["PRIORITY"].ToString();
        }

        public object GetBillInfo(string strConsNo, string strBillNO)
        {
           
                DataSet load1 = new DataSet();
                DataTable dataTable = new DataTable();
        
                 new Oncology.OncologyEMRClient().UsingSafe<Oncology.OncologyEMRClient>((Action<Oncology.OncologyEMRClient>)(op => load1 = GeneralFunction.FillDatasetXMl(op.GetOPDBillInfo(strConsNo, strBillNO))));
                if (load1.Tables.Count <= 0)
                    return (object)"";
                DataTable table = load1.Tables[0];
                return table.Rows.Count > 0 ? (object)table.Rows.Cast<DataRow>().Select(row =>
                {
                    var billInfo = new
                    {
                        BillNo = row["BILLNO"].ToString().Trim(),
                        TOTBillAmt = row["TOTSERVAMT"].ToString().Trim(),
                        AvailLimit = row["LIMIT"].ToString().Trim(),
                        Balance = Convert.ToDouble(row["LIMIT"].ToString().Trim()) > 0.0 ? row["BALANCE"].ToString().Trim() : "0.00",
                        CompName = row["CRDCOMPCD"].ToString().Trim(),
                        TariffName = row["TARIFF"].ToString().Trim(),
                        PatCatgName = row["PATCATG"].ToString().Trim()
                    };
                    return billInfo;
                }).ToArray() : (object)"";
            
        }
    }


    #endregion
  
    #region Loginfo control model
    public class LogInfo
    {
        public object GetLogInfo(string strTranNo, string LogType)
        {
            
            DataSet dsgetLogInfo = new DataSet();
            new CommonServiceClient().UsingSafe(com =>
            {
                if (LogType == "I")
                    dsgetLogInfo = com.GetIPLogInfo(strTranNo);
                else if (LogType == "H")
                    dsgetLogInfo = com.GetHRLogInfo(strTranNo);
                else if (LogType == "O")
                    dsgetLogInfo = com.GetOPLogInfo(strTranNo);
                else if (LogType == "S")
                    dsgetLogInfo = com.GetStoreLogInfo(strTranNo);
            });
            var jsonData = new
            {
                rows = (from DataRow row in dsgetLogInfo.Tables[0].Rows
                        select new
                        {
                            id = row["USERID"].ToString(),
                            cell = new string[] {row["USERID"].ToString(),  GeneralFunction.GetAction(row["ACTION"].ToString()),GeneralFunction.GetDate(Convert.ToString(row["LOGDATE"])),
                                row["LOGTIME"].ToString()
                        }
                        })
            };
            return jsonData;
        }
    }
    #endregion Loginfo control model

    #region Planning
    public class Planning
    {
        public string ChemotherapyName { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> LstChemoName { set; get; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> LstDiagnosis { set; get; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> LstTreatPlan { set; get; }
        public string TreatmentName { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> LstCourse { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> LstScheme { get; set; }
        public string SchemeSel { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.PatCatgList> LstPatcatg { set; get; }
        public string PatCatSel { get; set; }
        public string CouseName { get; set; }
        public string ChemoTextArea { get; set; }
        public string PerformanceStatus { get; set; }
        public string PrevTreatmentTextArea { get; set; }
        public string ModifttreatTextArea { get; set; }
        public string DiagnosisCode { get; set; }
        public string PerformaceStatusTextArea { get; set; }
        public string HPReportTextArea { get; set; }
        public string HPReportRemark { get; set; }
        public string CoMorbiditiesTextArea { get; set; }
        public string TempGaction { get; set; }
        public string Duration { get; set; }
        public string HourorDay { get; set; }
        public string HPReportResultDate { get; set; }
        public List<SelectListItem> LstTreatmentHrs { set; get; }
        public List<SelectListItem> StatusList { get; set; }
        public List<SelectListItem> DrugType { get; set; }
        public string PlanStatus { get; set; }
        public IEnumerable<SelectListItem> LstConStatus { get; set; }
        public List<SelectListItem> MedType { get; set; }
        public List<SelectListItem> DoseCalculation { get; set; }
        public IEnumerable<OncologyEMR.Oncology.BL_GeneralFunctionsSelectLstItem> RouteList { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> PHGenericNAmesLst { set; get; }
        public List<SelectListItem> AdministrationDurations { get; set; }
        public List<SelectListItem> DilutionVolume { get; set; }
        public List<SelectListItem> MedicalSetNo { get; set; }
        public List<SelectListItem> ProtocoleList { set; get; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> ProtocoleName { set; get; }
        OncologyClient onclgclnt = new OncologyClient();
        OncologyEMR.Oncology.OncologyEMRClient comser = new OncologyEMR.Oncology.OncologyEMRClient();
        CommonServiceClient cs = new CommonServiceClient();
        public void FillCombo(Planning Mdl, string PatMRNO)
        {
            LstChemoName = cs.GetChemoNameLst().Where(x => x.Status == "A");
            LstDiagnosis = cs.DDICDLst().Where(x => x.Status == "A");
            LstTreatPlan = cs.GetTreatPlanLst().Where(x => x.Status == "A");
            LstCourse = cs.GetCourseLst().Where(x => x.Status == "A");
            LstScheme = cs.GetTariffLst().Where(x => x.Status == "A");
            LstPatcatg = cs.GetPatCatgLst().Where(x => x.Status == "A");
            LstTreatmentHrs = GeneralFunction.TreatmentHrsList();
            StatusList = GeneralFunction.GetStatusCmb();
            MedType = GeneralFunction.MedType();
            DoseCalculation = GeneralFunction.DoseCalculation();
            DrugType = GeneralFunction.MedicineType();
            RouteList = comser.GetRouteList();
            DilutionVolume = GeneralFunction.DilutionVolumeChemo();
            MedicalSetNo = GeneralFunction.MedicalSetNo();
            AdministrationDurations = GeneralFunction.AdministrationDurationChemo();
            PHGenericNAmesLst = cs.GetPHGenericNAmesLst();
            ProtocoleName = cs.GetChemoNameLst().Where(x => x.Status == "A");
            LstConStatus = GeneralFunction.LstConStatus;
            DataSet DS = new DataSet();
            DS.ReadXml(new XmlTextReader(new StringReader(onclgclnt.GetPatHPMedHistory(PatMRNO))));
            if (DS.Tables.Count > 0)
            {
                if (DS.Tables.Contains("MEDHISTORY") && DS.Tables["MEDHISTORY"].Rows.Count > 0)
                {
                    Mdl.CoMorbiditiesTextArea = DS.Tables["MEDHISTORY"].Rows[0]["MEDIHIST"].ToString().Trim();
                }
                if (DS.Tables.Contains("HPREPORT") && DS.Tables["HPREPORT"].Rows.Count > 0)
                {
                    Mdl.HPReportTextArea = DS.Tables["HPREPORT"].Rows[0]["IMPRESSIONDT"].ToString().Trim();
                    Mdl.HPReportResultDate = GeneralFunction.GetDate(DS.Tables["HPREPORT"].Rows[0]["RESULTDATE"].ToString().Trim());
                }
            }
        }

        public string[] GetProtocol(string TranNo)
        {
            OncologyClient onclgclnt = new OncologyClient();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            string[] strProtoRemarks = new string[5];
            load.ReadXml(new XmlTextReader(new StringReader(onclgclnt.GetChemoProtocol(TranNo))));
            if (load.Tables.Count > 0)
            {
                if (load.Tables[0].Rows.Count > 0)
                {
                    l_oDT = load.Tables[0];
                    foreach (DataRow row in l_oDT.Rows)
                    {
                        strProtoRemarks[0] = row["PROTOCOL"].ToString().Trim();
                        strProtoRemarks[2] = row["DURATION"].ToString().Trim();
                        strProtoRemarks[3] = row["PROTOCOLTYPE"].ToString().Trim();
                        strProtoRemarks[4] = row["NOOFADMISSIONS"].ToString().Trim();
                    }
                }
            }
            return strProtoRemarks;
        }

        public object MedOncoSave(string IP, string ModuleID, string UserID, string ConsultNo, string MRNO, string EntryDate, string Diagnosis, string T, string N, string M, string ChemoCourse,
            string HPReport, string PrevTreatment, string PreChemoFindings, string Height, string Weight, string BSA, string PerformStatus, string M2, string Regime, string ChemoName,
            string Protocol, string ToRepeat, string TreatmentPlan, string TotalCycles, string TreatmentModification, string ICDYN, string CancelRemarks, string Scheme,
            string SchemeOth, string PatCatg, string Consultant, string gact, string TranNo, string Duration, string HourorDay, string ReportRemark, string chemo, string TreatmentDone, string ConclusionStatus, string TreatmentDate, string SchemeCodes,
            string ChemoAdvStart)
        {
            try
            {
                OncologyClient onco = new OncologyClient();
                BL_MedOnco template = new BL_MedOnco();
                if (gact == "N")
                {
                    template.TranMode = (int)GeneralFunction.modes.NewMode;
                }
                else if (gact == "E")
                {
                    if (string.IsNullOrEmpty(TranNo))
                    {
                        return new { success = false, message = "Invalid Transaction No.", ConsultNo = TranNo };
                    }

                    template.TranMode = (int)GeneralFunction.modes.EditMode;
                }
                else
                {
                    return new { success = false, message = "Invalid Action", ConsultNo = TranNo };
                }
                template.IpAddress = IP;
                template.UserID = UserID;
                template.ModuleID = ModuleID;
                template.TranNo = TranNo ?? string.Empty;
                template.MRNO = MRNO;
                template.ChemoName = ChemoName;
                template.Protocol = Protocol;
                template.ToRepeat = ToRepeat;
                template.TotalCycles = TotalCycles;
                template.TreatmentModification = TreatmentModification;
                template.Consultant = Consultant;
                template.ChemoCourse = ChemoCourse;
                template.HPReport = HPReport;
                template.PrevTreatment = PrevTreatment;
                template.Duration = Duration;
                double Tt;
                double Nn;
                double Mm;
                bool TRecord = double.TryParse(T, out Tt);
                bool NRecord = double.TryParse(N, out Nn);
                bool MRecord = double.TryParse(M, out Mm);
                if (TRecord)
                {
                    template.T = Tt.ToString();
                }
                else
                {
                    template.T = "0";
                }
                if (NRecord)
                {
                    template.N = Nn.ToString();
                }
                else
                {
                    template.N = "0";
                }
                if (MRecord)
                {
                    template.M = Mm.ToString();
                }
                else
                {
                    template.M = "0";
                }
                if (M2 != "" && M2 != null)
                    template.M2 = M2;
                else
                    template.M2 = "0.00";
                double height;
                if (double.TryParse(Height, out height))
                {
                    template.Height = height;
                }
                else
                {
                    template.Height = 0;
                }
                double weight;
                if (double.TryParse(Weight, out weight))
                {
                    template.Weight = weight;
                }
                else
                {
                    template.Weight = 0;
                }
                double Bsa;
                if (double.TryParse(BSA, out Bsa))
                {
                    template.BSA = Bsa;
                }
                else
                {
                    template.BSA = 0;
                }
                template.Regime = string.Empty;
                template.TreatmentPlan = TreatmentPlan;
                template.CancelRemarks = CancelRemarks;
                template.Scheme = "" + Scheme;
                template.SchemeOth = "" + SchemeOth;
                template.PatCatg = "" + PatCatg;
                template.PerformStatus = PerformStatus;
                template.EntryDate = EntryDate;
                template.Diagnosis = string.Empty;
                template.PreChemoFindings = PreChemoFindings;
                template.ConsultNo = ConsultNo;
                template.ICDYN = ICDYN;
                template.Status = "V";
                template.Duration = Duration;
                template.HourorDay = HourorDay;
                template.HPRemarks = ReportRemark;
                DataSet ds = new DataSet("DSMED");
                DataTable dtAllPhases = new DataTable("MEDDET");
                if (!string.IsNullOrWhiteSpace(chemo) && chemo != "[]")
                {
                    DataTable dtInv = JsonConvert.DeserializeObject<DataTable>(chemo);
                    if (dtInv != null && dtInv.Rows.Count > 0)
                    {
                        DataTableReader reader = new DataTableReader(dtInv);
                        DataTable dtResult = new DataTable("MEDDET");
                        dtResult.Load(reader);

                        ds.Tables.Add(dtResult);
                        template.CHEMOMEDSTRUCTXML = ds.GetXml();
                    }
                }
                template.PlanCompletedYN = TreatmentDone;
                template.PlanStatus = ConclusionStatus;
                if (TreatmentDate != string.Empty)
                {
                    template.PlanCompletedDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(TreatmentDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
                }
                template.SchemeCodes = SchemeCodes;
                template.AdvStartDate = GeneralFunction.GetDateInSpecifiedFormat(ChemoAdvStart, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                string result = onco.SMedOncoTran(template);
                if (result.Contains("Saved successfully"))
                {
                    var obj = new
                    {
                        success = true,
                        message = result,
                        ConsultNo = result.Split('.')[1].Trim()
                    };
                    return obj;
                }
                else if (result.Contains("Updation Successful."))
                {
                    var obj = new
                    {
                        success = true,
                        message = result,
                        ConsultNo = ConsultNo
                    };
                    return obj;
                }
                else
                {
                    var obj = new
                    {
                        success = false,
                        message = result,
                        ConsultNo = string.Empty
                    };
                    return obj;
                }
            }
            catch (Exception ex)
            {
                return string.Empty;
                throw ex;
            }
        }

        public string GetChemoPrMasterList(string strProtocol, string strType)
        {
            CommonServiceClient common = new CommonServiceClient();
            OncologyClient onco = new OncologyClient();
            string response = onco.GetChemoMedication(strProtocol, strType);
            var MedtypeList = GeneralFunction.MedicineType();
            var ChemoLst = common.GetChemoNameLst();
            DataSet ds = new DataSet();
            ds.ReadXml(new XmlTextReader(new StringReader(response)));
            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            {
                return Newtonsoft.Json.JsonConvert.SerializeObject("");
            }
            DataTable table1 = ds.Tables[0];
            var DrugFormLst = GeneralFunction.GetDrugFormList();
            if (strType == "L")
            {
                var rows = (from DataRow row in table1.Rows
                            select new
                            {
                                PROTOCOLECODE = row["PROTOCOLCODE"].ToString().Trim(),
                                NAME = ChemoLst.Where(x => x.Value == row["PROTOCOLCODE"].ToString().Trim()).Count() > 0 ? ChemoLst.Where(x => x.Value == row["PROTOCOLCODE"].ToString().Trim()).First().Text : "",
                                FORMNAME = row["DRUGFORM"].ToString().Trim() == "" ? "" : GeneralFunction.GetListValue(DrugFormLst, row["DRUGFORM"].ToString().Trim()),
                                DRUGFORM = row["DRUGFORM"].ToString().Trim(),
                                CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                CREATEDON = row["CREATEDON"].ToString().Trim(),
                                CREATEDAT = row["CREATEDAT"].ToString().Trim(),
                                EDITEDBY = row["EDITEDBY"].ToString(),
                                EDITEDON = row["EDITEDON"].ToString().Trim(),
                                EDITEDAT = (row["EDITEDAT"].ToString().Trim()),
                                STATUS = row["STATUS"].ToString().Trim(),
                            }).ToArray();
                return Newtonsoft.Json.JsonConvert.SerializeObject(rows);
            }
            else if (strType == "D")
            {
                var rows = (from DataRow row in table1.Rows
                            select new
                            {
                                MEDTYPE = row["MEDTYPE"].ToString().Trim(),
                                MEDSETNO = row["MEDSETNO"].ToString().Trim(),
                                GENERICID = row["GENERICID"].ToString().Trim(),
                                FORMNAME = row["DRUGFORM"].ToString().Trim() == "" ? "" : GeneralFunction.GetListValue(DrugFormLst, row["DRUGFORM"].ToString().Trim()),
                                DRUGFORM = row["DRUGFORM"].ToString().Trim(),
                                GENERICNM = row["GENERICID"].ToString().Trim(),
                                DOSE = row["DOSE"].ToString(),
                                DOSEUNIT = row["DOSEUNIT"].ToString(),
                                CALCULATEON = row["CALCULATEON"].ToString().Trim(),
                                ROUTECD = (row["ROUTECD"].ToString().Trim()),
                                FREQUENCY = row["FREQUENCY"].ToString().Trim(),
                                DILNTGENCD = row["DILNTGENCD"].ToString().Trim(),
                                DILUENT = row["DILUENT"].ToString().Trim(),
                                VOLDILTN = row["VOLDILTN"].ToString().Trim(),
                                DURATION = row["DURATION"].ToString().Trim(),
                                ADMINSEQNO = row["ADMINSEQNO"].ToString().Trim(),
                                APLYTODAY = row["APLYTODAY"].ToString().Trim(),
                                REMARKS = row["REMARKS"].ToString().Trim(),
                                ORIGINALDOSE = row["DOSE"].ToString(),
                                ADMNYN = string.IsNullOrWhiteSpace(row["ADMNYN"].ToString().Trim()) ? "" : row["ADMNYN"].ToString().Trim() == "Y" ? "Yes" : row["ADMNYN"].ToString().Trim() == "N" ? "No" : "",
                                ADMNNO = row["ADMNNO"].ToString().Trim(),
                                ONDAY = row["ONDAY"].ToString().Trim(),
                                CYCLENO = "",//priyanka 23/03/2026
                                act = ""
                            }).ToArray();
                return Newtonsoft.Json.JsonConvert.SerializeObject(rows);
            }
            else
                return "";
        }

        public object GetMedOncoDataMdl(string ConsultNo, string MrNo, string TranNo)
        {
            DataSet ds = new DataSet();
            OncologyClient onco = new OncologyClient();
            ds.ReadXml(new XmlTextReader(new StringReader(onco.SGetMedOncoLst("", "", "", "", MrNo, "", "D", ConsultNo, ""))));
            var DrugFormLst = GeneralFunction.GetDrugFormList();
            try
            {
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var jsonData = (from DataRow row in ds.Tables[0].Rows
                                    select new
                                    {
                                        TRANID = row["TRANID"].ToString().Trim(),
                                        MRNO = row["MRNO"].ToString().Trim(),
                                        ENTRYDATE = GeneralFunction.GetDate(row["ENTRYDATE"].ToString().Trim()),
                                        DIAGNOSIS = row["DIAGNOSIS"].ToString().Trim(),
                                        T = row["T"],
                                        N = row["N"],
                                        M = row["M"],
                                        CHEMOCOURSE = row["CHEMOCOURSE"].ToString().Trim(),
                                        HPREPORT = row["HPREPORT"].ToString().Trim(),
                                        HPREPORTREMARK = row["HPREMARKS"].ToString().Trim(),
                                        PREVTREATMENT = row["PREVTREATMENT"].ToString().Trim(),
                                        CLINICALFIND = row["CLINICALFIND"].ToString().Trim(),
                                        HEIGHT = row["HEIGHT"].ToString().Trim(),
                                        WEIGHT = row["WEIGHT"].ToString().Trim(),
                                        BSA = row["BSA"].ToString().Trim(),
                                        PERFORMANCESTATUS = row["PERFORMSTATUS"].ToString().Trim(),
                                        M2 = row["M2"].ToString().Trim(),
                                        CHEMOREGIME = row["CHEMOREGIME"].ToString().Trim(),
                                        CHEMOTHERAPYNM = row["CHEMOTHERAPYNM"].ToString().Trim(),
                                        PROTOCOL = ("" + row["ENTRY_PROTOCOL"].ToString().Trim() == "") ? row["PROTOCOL"].ToString().Trim() : row["ENTRY_PROTOCOL"].ToString().Trim(),
                                        REPEATAFTER = row["REPEATAFTER"].ToString().Trim(),
                                        TREATMENTPLAN = row["TREATMENTPLAN"].ToString().Trim(),
                                        TOTALCYCLE = row["TOTALCYCLE"].ToString().Trim(),
                                        MODIFICATION = row["MODIFICATION"].ToString().Trim(),
                                        VERIFIEDBY = row["VERIFIEDBY"].ToString().Trim(),
                                        STATUS = row["STATUS"].ToString().Trim(),
                                        TRANDATE = GeneralFunction.GetDate(row["TRANDATE"].ToString().Trim()),
                                        TRAMTIME = row["TRANTIME"].ToString().Trim(),
                                        CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                        VERIFIEDDATE = GeneralFunction.GetDate(row["VERIFIEDDT"].ToString().Trim()),
                                        VERIFIEDAT = row["VERIFIEDAT"].ToString().Trim(),
                                        ICDYN = row["ICDYN"].ToString().Trim(),
                                        REMARKS = row["REMARKS"].ToString().Trim(),
                                        PATCAT = row["PATCATG"].ToString().Trim(),
                                        CONSULTCODE = row["CONSULTANTCD"].ToString().Trim(),
                                        SCHEME = row["SCHEME"].ToString().Trim(),
                                        SCHEMEOHT = row["SCHEMEOTH"].ToString().Trim(),
                                        PLANCOMPLETE = row["PLANCOMPLETE"].ToString().Trim(),
                                        CONSULTNO = row["CONSULTNO"].ToString().Trim(),
                                        SALUTATION = row["SALUTATION"].ToString().Trim(),
                                        PATNAME = row["PATNAME"].ToString().Trim(),
                                        PATSEX = row["PATSEX"].ToString().Trim(),
                                        PATDOB = GeneralFunction.GetDate(row["PATDOB"].ToString().Trim()),
                                        PATAGE = row["PATAGE"].ToString().Trim(),
                                        PATCATGNM = row["PATCATGNM"].ToString().Trim(),
                                        HRSORDAY = row["HOURORDAY"].ToString().Trim(),
                                        DURATION = row["DURATION"].ToString().Trim(),
                                        COMPLETESTATUS = row["COMPLETESTATUS"].ToString().Trim(),
                                        COMPLETEDATE = GeneralFunction.GetDate(row["COMPLETEDATE"].ToString().Trim()),
                                        PROTOCOLTYPE = row["PROTOCOLTYPE"].ToString().Trim(),
                                        SCHEMECODES = row["SCHEMECODES"].ToString().Trim(),
                                        ADVSTARTDATE = GeneralFunction.GetDate(row["ADVSTARTDATE"].ToString().Trim()),
                                        DATAMIGRATION = row["DATAMIGRATION"].ToString().Trim(),
                                        COMPLETEDCYCLES = row["COMPLETEDCYCLES"].ToString().Trim(),
                                        MIGRATIONPLANNEDYN = "Y",
                                        CONCLUSIONREMARK = row["CONSLREMARKS"].ToString().Trim(),
                                    }).ToList();


                    var table1Data = new List<object>();

                    //if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count == 0 &&
                    //    jsonData.Any(x => x.DATAMIGRATION == "Y"))
                        if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0 && jsonData.Any(x => x.DATAMIGRATION == "Y"))
                        {
                            table1Data = (from DataRow row in ds.Tables[1].Rows
                                          select new
                                          {
                                              CYCLENO = row["CYCLENO"].ToString().Trim(),
                                              MEDTYPE = row["MEDTYPE"].ToString().Trim(),
                                              MEDSETNO = row["MEDSETNO"].ToString().Trim(),
                                              GENERICID = row["GENERICID"].ToString().Trim(),
                                              GENERICNM = row["GENERICID"].ToString().Trim(),
                                              DOSE = row["DOSE"].ToString(),
                                              DOSEUNIT = row["DOSEUNIT"].ToString(),
                                              CALCULATEON = row["CALCULATEON"].ToString().Trim(),
                                              ROUTECD = (row["ROUTECD"].ToString().Trim()),
                                              FREQUENCY = row["FREQUENCY"].ToString().Trim(),
                                              DILNTGENCD = row["DILNTGENCD"].ToString().Trim(),
                                              DILUENT = row["DILUENT"].ToString().Trim(),
                                              VOLDILTN = row["VOLDILTN"].ToString().Trim(),
                                              DURATION = row["DURATION"].ToString().Trim(),
                                              ADMINSEQNO = row["ADMINSEQNO"].ToString().Trim(),
                                              APLYTODAY = row["APLYTODAY"].ToString().Trim(),
                                              REMARKS = row["REMARKS"].ToString().Trim(),
                                              ORIGINALDOSE = row["DOSE"].ToString(),
                                              OMITDRUG = row["OMITDRUG"].ToString().Trim(),
                                              FORMNAME = row["DRUGFORM"].ToString().Trim() == "" ? "" : GeneralFunction.GetListValue(DrugFormLst, row["DRUGFORM"].ToString().Trim()),
                                              DRUGFORM = row["DRUGFORM"].ToString().Trim(),
                                              ADMNYN = string.IsNullOrWhiteSpace(row["ADMNYN"].ToString().Trim()) ? "" : row["ADMNYN"].ToString().Trim() == "Y" ? "Yes" : row["ADMNYN"].ToString().Trim() == "N" ? "No" : "",
                                              ADMNNO = row["ADMNNO"].ToString().Trim(),
                                              ADMNSTATUS = row["ADMNSTATUS"].ToString().Trim(),
                                              ONDAY = row["ONDAY"].ToString().Trim(),
                                              TRANNO = row["TRANNO"].ToString().Trim()
                                          }).ToList<object>();
                        }
                    return new
                    {
                        data = jsonData,
                        migrationData = table1Data,
                        success = true
                    };

                    //return new { data = jsonData, success = true };
                }
                else
                {
                    return "[]";
                }
            }
            catch (Exception ex)
            {
                return "[]";
            }
        }
        public object GetChemoSMedication(string MrNo, string PlanNo, string CycleNo)
        {
            DataSet ds = new DataSet();
            DataSet dsvalue = new DataSet();
            OncologyClient onco = new OncologyClient();
            string strCycleNo = "";
            dsvalue.ReadXml(new XmlTextReader(new StringReader(onco.GetChemoSMedCycle(MrNo, PlanNo))));
            if (dsvalue.Tables.Count > 0 && dsvalue.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i <= dsvalue.Tables[0].Rows.Count - 1; i++)
                {
                    strCycleNo = dsvalue.Tables[0].Rows[i]["CYCLENO"].ToString().Trim();
                }
            }
            ds.ReadXml(new XmlTextReader(new StringReader(onco.GetChemoSMedication(MrNo, PlanNo, "", strCycleNo))));
            var DrugFormLst = GeneralFunction.GetDrugFormList();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var jsonData = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    CYCLENO = row["CYCLENO"].ToString().Trim(),
                                    MEDTYPE = row["MEDTYPE"].ToString().Trim(),
                                    MEDSETNO = row["MEDSETNO"].ToString().Trim(),
                                    GENERICID = row["GENERICID"].ToString().Trim(),
                                    GENERICNM = row["GENERICID"].ToString().Trim(),
                                    DOSE = row["DOSE"].ToString(),
                                    DOSEUNIT = row["DOSEUNIT"].ToString(),
                                    CALCULATEON = row["CALCULATEON"].ToString().Trim(),
                                    ROUTECD = (row["ROUTECD"].ToString().Trim()),
                                    FREQUENCY = row["FREQUENCY"].ToString().Trim(),
                                    DILNTGENCD = row["DILNTGENCD"].ToString().Trim(),
                                    DILUENT = row["DILUENT"].ToString().Trim(),
                                    VOLDILTN = row["VOLDILTN"].ToString().Trim(),
                                    DURATION = row["DURATION"].ToString().Trim(),
                                    ADMINSEQNO = row["ADMINSEQNO"].ToString().Trim(),
                                    APLYTODAY = row["APLYTODAY"].ToString().Trim(),
                                    REMARKS = row["REMARKS"].ToString().Trim(),
                                    ORIGINALDOSE = row["DOSE"].ToString(),
                                    OMITDRUG = row["OMITDRUG"].ToString().Trim(),
                                    FORMNAME = row["DRUGFORM"].ToString().Trim() == "" ? "" : GeneralFunction.GetListValue(DrugFormLst, row["DRUGFORM"].ToString().Trim()),
                                    DRUGFORM = row["DRUGFORM"].ToString().Trim(),
                                    ADMNYN = string.IsNullOrWhiteSpace(row["ADMNYN"].ToString().Trim()) ? "" : row["ADMNYN"].ToString().Trim() == "Y" ? "Yes" : row["ADMNYN"].ToString().Trim() == "N" ? "No" : "",
                                    ADMNNO = row["ADMNNO"].ToString().Trim(),
                                    ADMNSTATUS = row["ADMNSTATUS"].ToString().Trim(),
                                    ONDAY = row["ONDAY"].ToString().Trim(),
                                    TRANNO = row["TRANNO"].ToString().Trim()
                                }).ToList();
                return new { data = jsonData, success = true };
            }
            else
            {
                return "[]";
            }
        }

        //public byte[] PrintChemoPlan(string Mrno, string ConsultNo, string PlanNo, string CycleNo, string StrProtocole, string LetterHeaderYN = "")
        //{
        //    DataSet AllData = new DataSet();
        //    DataTable DT = new DataTable();
        //    DataSet ds = new DataSet();
        //    string doctCode = "";
        //    OncologyClient onco = new OncologyClient();
        //    string strCycleNo = "";
        //    DataSet dsvalue = new DataSet();
        //    dsvalue.ReadXml(new XmlTextReader(new StringReader(onco.GetChemoSMedCycle(Mrno, PlanNo))));
        //    if (dsvalue.Tables.Count > 0 && dsvalue.Tables[0].Rows.Count > 0)
        //    {
        //        for (int i = 0; i <= dsvalue.Tables[0].Rows.Count - 1; i++)
        //        {
        //            strCycleNo = dsvalue.Tables[0].Rows[i]["CYCLENO"].ToString().Trim();
        //        }
        //    }
        //    strCycleNo = strCycleNo == "" ? CycleNo : strCycleNo;
        //    ds.ReadXml(new XmlTextReader(new StringReader(onco.SGetMedOncoLst("", "", "", "", Mrno, PlanNo, "D", "", strCycleNo))));
        //    DT.Columns.Add("PATNAME");
        //    DT.Columns.Add("PATMRNO");
        //    DT.Columns.Add("TRANNO");
        //    DT.Columns.Add("HEIGHT");
        //    DT.Columns.Add("WEIGHT");
        //    DT.Columns.Add("PATGENDER");
        //    DT.Columns.Add("PATAGE");
        //    DT.Columns.Add("PS");
        //    DT.Columns.Add("HPREPORT");
        //    DT.Columns.Add("PREVTREATMENT");
        //    DT.Columns.Add("INTENTTREATPLAN");
        //    DT.Columns.Add("COMORBID");
        //    DT.Columns.Add("CHEMOCOURSE");
        //    DT.Columns.Add("CHEMONAME");
        //    DT.Columns.Add("PROTOCAL");
        //    DT.Columns.Add("REPEATDAYS");
        //    DT.Columns.Add("TOTALCYCLE");
        //    DT.Columns.Add("MODIFICATION");
        //    DT.Columns.Add("CONSULTNAME");
        //    DT.Columns.Add("BSA");
        //    DT.Columns.Add("REMARKS");
        //    DT.Columns.Add("TRANDATE");
        //    DT.Columns.Add("DURATION");
        //    DT.Columns.Add("HOURORDAY");
        //    DT.Columns.Add("COMPLETEDCYCLES");
        //    DT.Columns.Add("CURRENTCYCLE");
        //    DT.Columns.Add("SHOWMEDYN");
        //    DT.Columns.Add("SHOWPROTCOLYN");
        //    DT.Columns.Add("PROTOCOLTYPE");
        //    DT.Columns.Add("CHEMOSTARTDATE");
        //    DT.Columns.Add("DOCTNAME");
        //    DT.Columns.Add("QUALI");
        //    DT.Columns.Add("MCCNO");
        //    DT.Columns.Add("SPECIALIZATION");
        //    DT.Columns.Add("SIGN");
        //    DT.Columns.Add("CHEMOMEDYN");
        //    var LstChemoName = cs.GetChemoNameLst().Where(x => x.Status == "A");
        //    var LstTreatPlan = cs.GetTreatPlanLst().Where(x => x.Status == "A");
        //    var LstCourse = cs.GetCourseLst().Where(x => x.Status == "A");
        //    var LstUser = cs.GetUserList();
        //    var LstRoute = comser.GetRouteList();
        //    var LstGeneric = cs.GetPHGenericNAmesLst();
        //    string ShowMedYN = "N";
        //    DataTable DTMed = new DataTable();
        //    DataSet CountDS = new DataSet();
        //    CountDS.ReadXml(new XmlTextReader(new StringReader(onco.SGetChemoCycle(Mrno, StrProtocole))));
        //    if (ds.Tables.Contains("ChemoMed"))
        //    {
        //        ShowMedYN = "Y";
        //        DTMed = ds.Tables["ChemoMed"].Copy();
        //        DTMed.Columns.Add("ORIGINALDOSE");
        //        DTMed.Columns.Add("FORMNAME");
        //        DTMed.Columns.Add("APLYTODAY1", typeof(Int32));
        //        var DrugFormLst = GeneralFunction.GetDrugFormList();
        //        foreach (DataRow row in DTMed.Select("OMITDRUG = 'Y'"))
        //        {
        //            row.Delete();
        //        }
        //        DTMed.AcceptChanges();
        //        foreach (DataRow DR in DTMed.Rows)
        //        {
        //            DR["APLYTODAY1"] = string.IsNullOrWhiteSpace(Convert.ToString(DR["ONDAY"])) ? 0 : Convert.ToInt32(("" + DR["ONDAY"]).ToString().Trim());
        //            DR["GENERICNM"] = ("" + DR["GENERICID"]).ToString().Trim() == "" ? "" : (LstGeneric.Where(x => x.Value == ("" + DR["GENERICID"]).ToString().Trim()).Count() > 0 ? LstGeneric.Where(x => x.Value == ("" + DR["GENERICID"]).ToString().Trim()).FirstOrDefault().Text : ("" + DR["GENERICNM"]).ToString().Trim());
        //            DR["ROUTECD"] = ("" + DR["ROUTECD"]).ToString().Trim() == "" ? "" : (LstRoute.Where(x => x.Value == ("" + DR["ROUTECD"]).ToString().Trim()).Count() > 0 ? LstRoute.Where(x => x.Value == ("" + DR["ROUTECD"]).ToString().Trim()).FirstOrDefault().Text : ("" + DR["ROUTECD"]).ToString().Trim());
        //            DR["FORMNAME"] = ("" + DR["DRUGFORM"]).ToString().Trim() == "" ? "" : GeneralFunction.GetListValue(DrugFormLst, ("" + DR["DRUGFORM"]).ToString().Trim());
        //        }
        //        DTMed.Columns.Remove("APLYTODAY");
        //        DTMed.Columns.Remove("DRUGFORM");
        //        DTMed.Columns["APLYTODAY1"].ColumnName = "APLYTODAY";
        //        DTMed.Columns["FORMNAME"].ColumnName = "DRUGFORM";
        //    }
        //    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        //    {
        //        DataRow DNew = DT.NewRow();
        //        DNew["PATNAME"] = ds.Tables[0].Rows[0]["PATNAME"].ToString().Trim();
        //        if (HttpContext.Current.Session["gDoctCode"] != null)
        //        {
        //            doctCode = HttpContext.Current.Session["gDoctCode"].ToString();
        //        }
        //        DNew["PATMRNO"] = Mrno;
        //        DNew["TRANNO"] = ds.Tables[0].Rows[0]["TRANID"].ToString().Trim();
        //        DNew["HEIGHT"] = ds.Tables[0].Rows[0]["HEIGHT"].ToString().Trim() == "" || ds.Tables[0].Rows[0]["HEIGHT"].ToString().Trim() == "0.00" ? "-" : ds.Tables[0].Rows[0]["HEIGHT"].ToString().Trim();
        //        DNew["WEIGHT"] = ds.Tables[0].Rows[0]["WEIGHT"].ToString().Trim() == "" || ds.Tables[0].Rows[0]["WEIGHT"].ToString().Trim() == "0.00" ? "-" : ds.Tables[0].Rows[0]["WEIGHT"].ToString().Trim();
        //        DNew["BSA"] = ds.Tables[0].Rows[0]["BSA"].ToString().Trim() == "" || ds.Tables[0].Rows[0]["BSA"].ToString().Trim() == "0.00" ? "-" : ds.Tables[0].Rows[0]["BSA"].ToString().Trim();
        //        DNew["PATGENDER"] = GeneralFunction.GetPatGender(ds.Tables[0].Rows[0]["PATSEX"].ToString().Trim());
        //        DNew["PATGENDER"] = GeneralFunction.GetPatGender(ds.Tables[0].Rows[0]["PATSEX"].ToString().Trim());
        //        string[] strAge = ds.Tables[0].Rows[0]["PATAGE"].ToString().Trim().Split(':');
        //        string sAge = Convert.ToInt32(strAge[0]) > 0 ? Convert.ToInt32(strAge[0]) + " Years" : Convert.ToInt32(strAge[1]) > 0 ? Convert.ToInt32(strAge[1]) + " Months" : Convert.ToInt32(strAge[2]) + " Days";
        //        DNew["PATAGE"] = sAge;
        //        DNew["PS"] = ds.Tables[0].Rows[0]["PERFORMSTATUS"].ToString().Trim();
        //        DNew["HPREPORT"] = ds.Tables[0].Rows[0]["HPREPORT"].ToString().Trim();
        //        DNew["PREVTREATMENT"] = ds.Tables[0].Rows[0]["PREVTREATMENT"].ToString().Trim();
        //        DNew["INTENTTREATPLAN"] = ds.Tables[0].Rows[0]["TREATMENTPLAN"].ToString().Trim() == "" ? "" :
        //            (LstTreatPlan.Where(x => x.Value == ds.Tables[0].Rows[0]["TREATMENTPLAN"].ToString().Trim()).Count() > 0 ? LstTreatPlan.Where(x => x.Value == ds.Tables[0].Rows[0]["TREATMENTPLAN"].ToString().Trim()).FirstOrDefault().Text : "");
        //        DNew["COMORBID"] = ds.Tables[0].Rows[0]["CLINICALFIND"].ToString().Trim();
        //        DNew["CHEMOCOURSE"] = ds.Tables[0].Rows[0]["CHEMOCOURSE"].ToString().Trim() == "" ? "" :
        //            (LstCourse.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOCOURSE"].ToString().Trim()).Count() > 0 ? LstCourse.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOCOURSE"].ToString().Trim()).FirstOrDefault().Text : "");
        //        DNew["CHEMONAME"] = ds.Tables[0].Rows[0]["CHEMOTHERAPYNM"].ToString().Trim() == "" ? "" :
        //            (LstChemoName.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOTHERAPYNM"].ToString().Trim()).Count() > 0 ? LstChemoName.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOTHERAPYNM"].ToString().Trim()).FirstOrDefault().Text : "");
        //        //DNew["PROTOCAL"] = ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim();
        //        DNew["PROTOCAL"] = ds.Tables[0].Rows[0]["PROTOCOLTYPE"].ToString().Trim() == "U" && !string.IsNullOrWhiteSpace(ds.Tables[0].Rows[0]["PROTOCOL"].ToString()) ? ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim() : "";
        //        DNew["SHOWPROTCOLYN"] = ShowMedYN == "Y" || ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim() == "" ? "N" : "Y";
        //        DNew["REPEATDAYS"] = ds.Tables[0].Rows[0]["REPEATAFTER"].ToString().Trim();
        //        DNew["TOTALCYCLE"] = ds.Tables[0].Rows[0]["TOTALCYCLE"].ToString().Trim();
        //        DNew["MODIFICATION"] = ds.Tables[0].Rows[0]["MODIFICATION"].ToString().Trim();
        //        DNew["CONSULTNAME"] = ds.Tables[0].Rows[0]["CREATEDBY"].ToString().Trim() == "" ? "" :
        //                    (LstUser.Where(x => x.Value == ds.Tables[0].Rows[0]["CREATEDBY"].ToString().Trim()).Count() > 0 ? LstUser.Where(x => x.Value == ds.Tables[0].Rows[0]["CREATEDBY"].ToString().Trim()).FirstOrDefault().Text : "");
        //        DNew["REMARKS"] = ds.Tables[0].Rows[0]["HPREMARKS"].ToString().Trim();
        //        DNew["TRANDATE"] = GeneralFunction.GetDate(ds.Tables[0].Rows[0]["TRANDATE"].ToString().Trim()) + " - " + DateTime.ParseExact(ds.Tables[0].Rows[0]["TRANTIME"].ToString().Trim(), "HH:mm:ss", null).ToString("hh:mm tt");
        //        DNew["DURATION"] = ds.Tables[0].Rows[0]["DURATION"].ToString().Trim();
        //        DNew["HOURORDAY"] = ds.Tables[0].Rows[0]["HOURORDAY"].ToString().Trim();
        //        string CompletedCycle = "0";
        //        int CurCycle = 0;

        //        //Chemo Changes Comment By Rajan
        //        //if (CountDS.Tables.Count > 0 && CountDS.Tables[0].Rows.Count > 0)
        //        //{
        //        //    CompletedCycle = CountDS.Tables[0].Rows[0]["CYCLENO"].ToString();
        //        //}
        //        //else 
        //        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        //        {
        //            CompletedCycle = ds.Tables[0].Columns.Contains("COMPLETEDCYCLES") ? Convert.ToString(ds.Tables[0].Rows[0]["COMPLETEDCYCLES"]) : "";
        //        }
        //        //priyanka 11/04/2026
        //        CompletedCycle = CompletedCycle.Trim() == "" ? "0" : CompletedCycle;
        //        CurCycle = CompletedCycle.Trim() == "0" ? 0 : Convert.ToInt32(CompletedCycle.Trim());
        //        //end

        //        //CurCycle = CompletedCycle.Trim() == "" ? 0 : Convert.ToInt32(CompletedCycle.Trim());
        //        DNew["COMPLETEDCYCLES"] = CompletedCycle == "" ? "0" : CompletedCycle; //priyanka 07/04/2026
        //        int TotalCycle = ds.Tables[0].Rows[0]["TOTALCYCLE"].ToString().Trim() == "" ? 0 : Convert.ToInt32(ds.Tables[0].Rows[0]["TOTALCYCLE"].ToString().Trim());
        //        if ((CompletedCycle == "0" && CurCycle == 0))
        //        {
        //            DNew["CURRENTCYCLE"] = 1;
        //        }
        //        else if (TotalCycle == Convert.ToInt32(CompletedCycle))
        //        {
        //            DNew["CURRENTCYCLE"] = "Cycle Completed.";
        //        }
        //        else
        //        {
        //            DNew["CURRENTCYCLE"] = CurCycle + 1;
        //        }
        //        DNew["SHOWMEDYN"] = (ShowMedYN == "Y" && ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim() != "") ? "N" : "Y"; //ShowMedYN;
        //        DNew["PROTOCOLTYPE"] = ds.Tables[0].Rows[0]["PROTOCOLTYPE"].ToString().Trim();
        //        DNew["CHEMOSTARTDATE"] = ds.Tables[0].Rows[0]["ADVSTARTDATE"].ToString().Trim() == "" ? "" : GeneralFunction.GetDate(ds.Tables[0].Rows[0]["ADVSTARTDATE"].ToString().Trim());
        //        if (!string.IsNullOrEmpty(doctCode))
        //        {
        //            OncologyEMRClient oncclnt = new OncologyEMRClient();
        //            string jsonDoct = oncclnt.GetDoctDetails(doctCode);

        //            DataSet dsDoctor = GeneralFunction.FillDatasetXMl(jsonDoct);

        //            if (dsDoctor.Tables.Contains("Table") && dsDoctor.Tables["Table"].Rows.Count > 0)
        //            {
        //                var row = dsDoctor.Tables["Table"].Rows[0];

        //                DNew["DOCTNAME"] = row["DOCTNAME"].ToString().Trim();
        //                DNew["QUALI"] = row["QUALI"].ToString().Trim();
        //                DNew["MCCNO"] = row["MCCNO"].ToString().Trim();
        //                DNew["SPECIALIZATION"] = row["DOSPNAME"].ToString().Trim();
        //                DNew["SIGN"] = row["SIGN"].ToString().Trim();
        //            }
        //        }
        //        DNew["CHEMOMEDYN"] = "N";
        //        if (ds.Tables.Contains("ChemoMed") && ds.Tables["ChemoMed"].Rows.Count > 0)
        //        {
        //            DNew["CHEMOMEDYN"] = "Y";
        //        }
        //        DT.Rows.Add(DNew);
        //    }
        //    DTMed.TableName = "CHEMOMEDS";
        //    DT.TableName = "CHEMOPLAN";
        //    DataTable HData = new DataTable();
        //    var formlist = "Chemotherapy Plan";
        //    HData = GeneralFunction.getHeaderFooter(formlist, "", "", "", "", LetterHeaderYN, GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGHEADFILENM"), GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGFOOTFILENM"));
        //    HData.TableName = "HeaderFooter";
        //    AllData.Tables.Add(DT);
        //    AllData.Tables.Add(DTMed);
        //    AllData.Tables.Add(HData);
        //    string reportPath = Path.Combine(HttpContext.Current.Server.MapPath("~/Report"), "rptChemoPlan.rpt");
        //    //Abhishesh || 20260720
        //    byte[] printarr = GeneralFunction.SetHeaderFootermargTopBottom(AllData, reportPath, HData.Rows[0]["ImageLetterYN"].ToString().Trim(), GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGHEADHEIGHT"), GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGFOOTHEIGHT")
        //    );
        //    //End
        //    return printarr;
        //}

        public byte[] PrintChemoPlan(string Mrno, string ConsultNo, string PlanNo, string CycleNo, string StrProtocole, string LetterHeaderYN = "")
        {
            DataSet AllData = new DataSet();
            DataTable DT = new DataTable();
            DataSet ds = new DataSet();
            string doctCode = "";
            OncologyClient onco = new OncologyClient();
            string strCycleNo = "";
            DataSet dsvalue = new DataSet();
            dsvalue.ReadXml(new XmlTextReader(new StringReader(onco.GetChemoSMedCycle(Mrno, PlanNo))));
            if (dsvalue.Tables.Count > 0 && dsvalue.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i <= dsvalue.Tables[0].Rows.Count - 1; i++)
                {
                    strCycleNo = dsvalue.Tables[0].Rows[i]["CYCLENO"].ToString().Trim();
                }
            }
            ds.ReadXml(new XmlTextReader(new StringReader(onco.SGetMedOncoLst("", "", "", "", Mrno, PlanNo, "A", "", (CycleNo == "" ? strCycleNo : CycleNo)))));
            DT.Columns.Add("PATNAME");
            DT.Columns.Add("PATMRNO");
            DT.Columns.Add("TRANNO");
            DT.Columns.Add("HEIGHT");
            DT.Columns.Add("WEIGHT");
            DT.Columns.Add("PATGENDER");
            DT.Columns.Add("PATAGE");
            DT.Columns.Add("PS");
            DT.Columns.Add("HPREPORT");
            DT.Columns.Add("PREVTREATMENT");
            DT.Columns.Add("INTENTTREATPLAN");
            DT.Columns.Add("COMORBID");
            DT.Columns.Add("CHEMOCOURSE");
            DT.Columns.Add("CHEMONAME");
            DT.Columns.Add("PROTOCAL");
            DT.Columns.Add("REPEATDAYS");
            DT.Columns.Add("TOTALCYCLE");
            DT.Columns.Add("MODIFICATION");
            DT.Columns.Add("CONSULTNAME");
            DT.Columns.Add("BSA");
            DT.Columns.Add("REMARKS");
            DT.Columns.Add("TRANDATE");
            DT.Columns.Add("DURATION");
            DT.Columns.Add("HOURORDAY");
            DT.Columns.Add("COMPLETEDCYCLES");
            DT.Columns.Add("CURRENTCYCLE");
            DT.Columns.Add("SHOWMEDYN");
            DT.Columns.Add("SHOWPROTCOLYN");
            DT.Columns.Add("PROTOCOLTYPE");
            DT.Columns.Add("CHEMOSTARTDATE");
            DT.Columns.Add("DOCTNAME");
            DT.Columns.Add("QUALI");
            DT.Columns.Add("MCCNO");
            DT.Columns.Add("SPECIALIZATION");
            DT.Columns.Add("SIGN");
            DT.Columns.Add("CHEMOMEDYN");
            var LstChemoName = cs.GetChemoNameLst().Where(x => x.Status == "A");
            var LstTreatPlan = cs.GetTreatPlanLst().Where(x => x.Status == "A");
            var LstCourse = cs.GetCourseLst().Where(x => x.Status == "A");
            var LstUser = cs.GetUserList();
            var LstRoute = comser.GetRouteList();
            var LstGeneric = cs.GetPHGenericNAmesLst();
            string ShowMedYN = "N";
            DataTable DTMed = new DataTable();
            if (ds.Tables.Contains("ChemoMed"))
            {
                ShowMedYN = "Y";
                DTMed = ds.Tables["ChemoMed"].Copy();
                DTMed.Columns.Add("ORIGINALDOSE");
                DTMed.Columns.Add("FORMNAME");
                DTMed.Columns.Add("APLYTODAY1", typeof(Int32));
                var DrugFormLst = GeneralFunction.GetDrugFormList();
                foreach (DataRow row in DTMed.Select("OMITDRUG = 'Y'"))
                {
                    row.Delete();
                }
                DTMed.AcceptChanges();
                foreach (DataRow DR in DTMed.Rows)
                {
                    DR["APLYTODAY1"] = string.IsNullOrWhiteSpace(Convert.ToString(DR["ONDAY"])) ? 0 : Convert.ToInt32(("" + DR["ONDAY"]).ToString().Trim());
                    DR["GENERICNM"] = ("" + DR["GENERICID"]).ToString().Trim() == "" ? "" : (LstGeneric.Where(x => x.Value == ("" + DR["GENERICID"]).ToString().Trim()).Count() > 0 ? LstGeneric.Where(x => x.Value == ("" + DR["GENERICID"]).ToString().Trim()).FirstOrDefault().Text : ("" + DR["GENERICNM"]).ToString().Trim());
                    DR["ROUTECD"] = ("" + DR["ROUTECD"]).ToString().Trim() == "" ? "" : (LstRoute.Where(x => x.Value == ("" + DR["ROUTECD"]).ToString().Trim()).Count() > 0 ? LstRoute.Where(x => x.Value == ("" + DR["ROUTECD"]).ToString().Trim()).FirstOrDefault().Text : ("" + DR["ROUTECD"]).ToString().Trim());
                    DR["FORMNAME"] = ("" + DR["DRUGFORM"]).ToString().Trim() == "" ? "" : GeneralFunction.GetListValue(DrugFormLst, ("" + DR["DRUGFORM"]).ToString().Trim());
                }
                DTMed.Columns.Remove("APLYTODAY");
                DTMed.Columns.Remove("DRUGFORM");
                DTMed.Columns["APLYTODAY1"].ColumnName = "APLYTODAY";
                DTMed.Columns["FORMNAME"].ColumnName = "DRUGFORM";
            }
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow DNew = DT.NewRow();
                DNew["PATNAME"] = ds.Tables[0].Rows[0]["PATNAME"].ToString().Trim();
                if (HttpContext.Current.Session["gDoctCode"] != null)
                {
                    doctCode = HttpContext.Current.Session["gDoctCode"].ToString();
                }
                DNew["PATMRNO"] = Mrno;
                DNew["TRANNO"] = ds.Tables[0].Rows[0]["TRANID"].ToString().Trim();
                DNew["HEIGHT"] = ds.Tables[0].Rows[0]["HEIGHT"].ToString().Trim() == "" || ds.Tables[0].Rows[0]["HEIGHT"].ToString().Trim() == "0.00" ? "-" : ds.Tables[0].Rows[0]["HEIGHT"].ToString().Trim();
                DNew["WEIGHT"] = ds.Tables[0].Rows[0]["WEIGHT"].ToString().Trim() == "" || ds.Tables[0].Rows[0]["WEIGHT"].ToString().Trim() == "0.00" ? "-" : ds.Tables[0].Rows[0]["WEIGHT"].ToString().Trim();
                DNew["BSA"] = ds.Tables[0].Rows[0]["BSA"].ToString().Trim() == "" || ds.Tables[0].Rows[0]["BSA"].ToString().Trim() == "0.00" ? "-" : ds.Tables[0].Rows[0]["BSA"].ToString().Trim();
                DNew["PATGENDER"] = GeneralFunction.GetPatGender(ds.Tables[0].Rows[0]["PATSEX"].ToString().Trim());
                DNew["PATGENDER"] = GeneralFunction.GetPatGender(ds.Tables[0].Rows[0]["PATSEX"].ToString().Trim());
                string[] strAge = ds.Tables[0].Rows[0]["PATAGE"].ToString().Trim().Split(':');
                string sAge = Convert.ToInt32(strAge[0]) > 0 ? Convert.ToInt32(strAge[0]) + " Years" : Convert.ToInt32(strAge[1]) > 0 ? Convert.ToInt32(strAge[1]) + " Months" : Convert.ToInt32(strAge[2]) + " Days";
                DNew["PATAGE"] = sAge;
                DNew["PS"] = ds.Tables[0].Rows[0]["PERFORMSTATUS"].ToString().Trim();
                DNew["HPREPORT"] = ds.Tables[0].Rows[0]["HPREPORT"].ToString().Trim();
                DNew["PREVTREATMENT"] = ds.Tables[0].Rows[0]["PREVTREATMENT"].ToString().Trim();
                DNew["INTENTTREATPLAN"] = ds.Tables[0].Rows[0]["TREATMENTPLAN"].ToString().Trim() == "" ? "" :
                    (LstTreatPlan.Where(x => x.Value == ds.Tables[0].Rows[0]["TREATMENTPLAN"].ToString().Trim()).Count() > 0 ? LstTreatPlan.Where(x => x.Value == ds.Tables[0].Rows[0]["TREATMENTPLAN"].ToString().Trim()).FirstOrDefault().Text : "");
                DNew["COMORBID"] = ds.Tables[0].Rows[0]["CLINICALFIND"].ToString().Trim();
                DNew["CHEMOCOURSE"] = ds.Tables[0].Rows[0]["CHEMOCOURSE"].ToString().Trim() == "" ? "" :
                    (LstCourse.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOCOURSE"].ToString().Trim()).Count() > 0 ? LstCourse.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOCOURSE"].ToString().Trim()).FirstOrDefault().Text : "");
                DNew["CHEMONAME"] = ds.Tables[0].Rows[0]["CHEMOTHERAPYNM"].ToString().Trim() == "" ? "" :
                    (LstChemoName.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOTHERAPYNM"].ToString().Trim()).Count() > 0 ? LstChemoName.Where(x => x.Value == ds.Tables[0].Rows[0]["CHEMOTHERAPYNM"].ToString().Trim()).FirstOrDefault().Text : "");
                //DNew["PROTOCAL"] = ds.Tables[0].Rows[0]["PROTOCOLTYPE"].ToString().Trim() == "U" && !string.IsNullOrWhiteSpace(ds.Tables[0].Rows[0]["PROTOCOL"].ToString()) ? ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim() : "";
                DNew["PROTOCAL"] = "";
                if (ds.Tables[0].Rows[0]["PROTOCOLTYPE"].ToString().Trim() == "U")
                {
                    if (ds.Tables[0].Columns.Contains("ENTRY_PROTOCOL") && !string.IsNullOrWhiteSpace(ds.Tables[0].Rows[0]["ENTRY_PROTOCOL"].ToString()))
                    {
                        DNew["PROTOCAL"] = ds.Tables[0].Rows[0]["ENTRY_PROTOCOL"].ToString().Trim();
                    }
                    else
                    {
                        DNew["PROTOCAL"] = ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim();
                    }
                } 
                DNew["SHOWPROTCOLYN"] = ShowMedYN == "Y" || ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim() == "" ? "N" : "Y";
                DNew["REPEATDAYS"] = ds.Tables[0].Rows[0]["REPEATAFTER"].ToString().Trim();
                DNew["TOTALCYCLE"] = ds.Tables[0].Rows[0]["TOTALCYCLE"].ToString().Trim();
                DNew["MODIFICATION"] = ds.Tables[0].Rows[0]["MODIFICATION"].ToString().Trim();
                DNew["CONSULTNAME"] = ds.Tables[0].Rows[0]["CREATEDBY"].ToString().Trim() == "" ? "" :
                            (LstUser.Where(x => x.Value == ds.Tables[0].Rows[0]["CREATEDBY"].ToString().Trim()).Count() > 0 ? LstUser.Where(x => x.Value == ds.Tables[0].Rows[0]["CREATEDBY"].ToString().Trim()).FirstOrDefault().Text : "");
                DNew["REMARKS"] = ds.Tables[0].Rows[0]["HPREMARKS"].ToString().Trim();
                DNew["TRANDATE"] = GeneralFunction.GetDate(ds.Tables[0].Rows[0]["TRANDATE"].ToString().Trim()) + " - " + DateTime.ParseExact(ds.Tables[0].Rows[0]["TRANTIME"].ToString().Trim(), "HH:mm:ss", null).ToString("hh:mm tt");
                DNew["DURATION"] = ds.Tables[0].Rows[0]["DURATION"].ToString().Trim();
                DNew["HOURORDAY"] = ds.Tables[0].Rows[0]["HOURORDAY"].ToString().Trim();

                string CompletedCycle = CycleNo == "" ? Convert.ToInt32(strCycleNo).ToString() : (Convert.ToInt32(CycleNo) - 1).ToString();
                string CurrentCycle = CycleNo == "" ? (Convert.ToInt32(CompletedCycle) + 1).ToString() : CycleNo;
                int TotalCycle = ds.Tables[0].Rows[0]["TOTALCYCLE"].ToString().Trim() == "" ? 0 : Convert.ToInt32(ds.Tables[0].Rows[0]["TOTALCYCLE"].ToString().Trim());
                DNew["COMPLETEDCYCLES"] = CompletedCycle == "" ? "0" : CompletedCycle;
                if ((CompletedCycle == "0" && CurrentCycle == ""))
                {
                    DNew["CURRENTCYCLE"] = 1;
                }
                else if (TotalCycle == Convert.ToInt32(CompletedCycle))
                {
                    DNew["CURRENTCYCLE"] = "Cycle Completed.";
                }
                else
                {
                    DNew["CURRENTCYCLE"] = CurrentCycle;
                }
                DNew["SHOWMEDYN"] = (ShowMedYN == "Y" && ds.Tables[0].Rows[0]["PROTOCOL"].ToString().Trim() != "") ? "N" : "Y"; 
                DNew["PROTOCOLTYPE"] = ds.Tables[0].Rows[0]["PROTOCOLTYPE"].ToString().Trim();
                DNew["CHEMOSTARTDATE"] = ds.Tables[0].Rows[0]["ADVSTARTDATE"].ToString().Trim() == "" ? "" : GeneralFunction.GetDate(ds.Tables[0].Rows[0]["ADVSTARTDATE"].ToString().Trim());
                if (!string.IsNullOrEmpty(doctCode))
                {
                    OncologyEMRClient oncclnt = new OncologyEMRClient();
                    string jsonDoct = oncclnt.GetDoctDetails(doctCode);
                    DataSet dsDoctor = GeneralFunction.FillDatasetXMl(jsonDoct);
                    if (dsDoctor.Tables.Contains("Table") && dsDoctor.Tables["Table"].Rows.Count > 0)
                    {
                        var row = dsDoctor.Tables["Table"].Rows[0];
                        DNew["DOCTNAME"] = row["DOCTNAME"].ToString().Trim();
                        DNew["QUALI"] = row["QUALI"].ToString().Trim();
                        DNew["MCCNO"] = row["MCCNO"].ToString().Trim();
                        DNew["SPECIALIZATION"] = row["DOSPNAME"].ToString().Trim();
                        DNew["SIGN"] = row["SIGN"].ToString().Trim();
                    }
                }
                DNew["CHEMOMEDYN"] = "N";
                if (ds.Tables.Contains("ChemoMed") && ds.Tables["ChemoMed"].Rows.Count > 0)
                {
                    DNew["CHEMOMEDYN"] = "Y";
                }
                DT.Rows.Add(DNew);
            }
            DTMed.TableName = "CHEMOMEDS";
            DT.TableName = "CHEMOPLAN";
            DataTable HData = new DataTable();
            var formlist = "Chemotherapy Plan";
            HData = GeneralFunction.getHeaderFooter(formlist, "", "", "", "", LetterHeaderYN, GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGHEADFILENM"), GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGFOOTFILENM"));
            HData.TableName = "HeaderFooter";
            AllData.Tables.Add(DT);
            AllData.Tables.Add(DTMed);
            AllData.Tables.Add(HData);
            string reportPath = Path.Combine(HttpContext.Current.Server.MapPath("~/Report"), "rptChemoPlan.rpt");
            byte[] printarr = GeneralFunction.SetHeaderFootermargTopBottom(AllData, reportPath, HData.Rows[0]["ImageLetterYN"].ToString().Trim(), GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGHEADHEIGHT"), GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGFOOTHEIGHT") );
            return printarr;
        }
    }
    #endregion 
}