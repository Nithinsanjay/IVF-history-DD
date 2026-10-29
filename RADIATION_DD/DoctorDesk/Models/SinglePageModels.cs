using iTextSharp.text.pdf;
using iTextSharp.text.pdf.qrcode;
using Newtonsoft.Json;
using OncologyEMR.AdminSevRef;
using OncologyEMR.CommonSerRef;
using OncologyEMR.DataClass;
using OncologyEMR.DocuServRef;
using OncologyEMR.ICUServRef;
using OncologyEMR.IPServRef;
using OncologyEMR.NSServRef;
using OncologyEMR.Oncology;
using OncologyEMR.OncologyServRef;
using OncologyEMR.OT;
using OncologyEMR.Pdf;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;


namespace OncologyEMR.Models
{
    #region Common

    #endregion

    #region OPD

    #region Patient Waiting List
    public class WaitingListOPD
    {
        public string VisitPurpose { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> VisitPurposeList { get; set; } //Pournima 9th April 2026

        public Dictionary<string, object> GetPatientList(string strClinicCode, string strDoctorCd, string dayType = "T", string CustomeDate = "", string Type = "")
        {
            Dictionary<string, object> dicResult = new Dictionary<string, object>();
            OncologyEMR.Oncology.OncologyEMRClient clOnco = new OncologyEMR.Oncology.OncologyEMRClient();
            DataSet ds = new DataSet();
            List<PatientSearch> listPatSearch = new List<PatientSearch>();
            CommonServiceClient com = new CommonServiceClient();
            string strDate = GeneralFunction.GetDateInSpecifiedFormat(CustomeDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            //var ApmntVisitTypeLst = GeneralFunction.GetAppointmentVisitPurposeList().ToList();
            var ApmntVisitTypeLst = com.GetVisitPurposeList().Where(x => x.Status == "A");
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
                //if (strDoctorCd != "" )//&& Convert.ToString(HttpContext.Current.Session["AUTHYN"]) != "Y" && Convert.ToString(HttpContext.Current.Session["RMOYN"]) != "Y")
                //{
                //    string strLoginDoctorCD = Convert.ToString(HttpContext.Current.Session["gDoctCode"]);
                //    DataRow[] rowSelInComplPres = ds.Tables["Table"].Select("COMPLETEDYN='N' OR CONSDOCT = '" + strLoginDoctorCD + "' OR PRESCDOCT='" + strLoginDoctorCD + "'");
                //    ds.Tables.Remove(ds.Tables["Table"].TableName);
                //    if (rowSelInComplPres != null && rowSelInComplPres.Length > 0)
                //    {
                //        DataTable tbl = rowSelInComplPres.CopyToDataTable();
                //        tbl.TableName = "Table";
                //        ds.Tables.Add(tbl);
                //    }
                //}
                if (ds.Tables.Contains("Table"))
                {
                    foreach (DataRow dr in ds.Tables["Table"].Rows)
                    {
                        var status = Type == "PAC" ? "" : (dr["ARRIVEDYN"].ToString().Trim() == "Y" && dr["POSTTOCONSYN"].ToString().Trim() == "N") ? "Arrived" : (dr["ARRIVEDYN"].ToString().Trim() == "Y" && dr["POSTTOCONSYN"].ToString().Trim() == "Y") ? "Waiting for consultation" : (dr["ARRIVEDYN"].ToString().Trim() == "N" && dr["POSTTOCONSYN"].ToString().Trim() == "N") ? "Not Arrived" : (dr["ARRIVEDYN"].ToString().Trim() == "Y" && dr["POSTTOCONSYN"].ToString().Trim() == "Y" && dr["COMPLETEDYN"].ToString().Trim() == "Y") ? "Completed" : "-";

                        PatientSearch clPat = new PatientSearch();
                        OncologyEMR.Oncology.OncologyEMRClient oncclnt = new OncologyEMR.Oncology.OncologyEMRClient();
                        var DoctLst = oncclnt.GetDoctLst("", "D");
                        clPat.CONSNO = Convert.ToString(dr["CONSNO"]);
                        clPat.MRNO = Convert.ToString(dr["MRNO"]);
                        clPat.CONSDOCT = Convert.ToString(dr["CONSDOCT"]);

                        clPat.PatName = Convert.ToString(dr["PATNAME"]).Trim();
                        clPat.CompletedYN = Convert.ToString(dr["COMPLETEDYN"]);
                        clPat.ConsDate = GeneralFunction.GetDate(Convert.ToString(dr["CONSDATE"]));
                        clPat.ConsTime = Convert.ToString(dr["CONSTIME"]);
                        clPat.APPTTM = Convert.ToString(dr["APPTTIME"]).Replace(".", ":");
                        if (clPat.APPTTM != "")
                        {
                            TimeSpan diff = (DateTime.Now - new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day,
                                             Convert.ToInt32(clPat.APPTTM.Split(':')[0]),
                                             Convert.ToInt32(clPat.APPTTM.Split(':')[1]), 0));
                            clPat.DIFFTM = diff.TotalMinutes.ToString();
                        }
                        else { clPat.DIFFTM = "0"; }
                        clPat.APPTTM = clPat.APPTTM;
                        clPat.CompName = Type == "PAC" ? Convert.ToString(dr["COMPNAME"]) : Convert.ToString(dr["COMPNAME"]);
                        clPat.DOB = GeneralFunction.GetDate(Convert.ToString(dr["PATDOB"]));
                        clPat.Age = GeneralFunction.GetPrintAge(GeneralFunction.GetAge(clPat.DOB));
                        clPat.Gender = Convert.ToString(dr["PATSEX"]);
                        clPat.TRANNO = Convert.ToString(dr["TRANNO"]);
                        clPat.CONTOKNO = Convert.ToString(dr["CONTOKNO"]).Trim();
                        clPat.ComCode = Type == "PAC" ? Convert.ToString(dr["CRDCOMPCD"]) : Convert.ToString(dr["COMPCODE"]);
                        clPat.Appmntno = dr.Table.Columns.Contains("APPMNTNO") ? Convert.ToString(dr["APPMNTNO"]).Trim() : "";
                        clPat.Status = status;
                        clPat.SurgName = Type == "PAC" ? GeneralFunction.GetCombinedValue(dr["SURGERYNAME"].ToString(), dr["SURGADVICEOTHER"].ToString()) : "";//  dr["SURGERYNAME"].ToString().Trim() : ""; //priyanka 23/02/2026
                        clPat.NatureSurgy = Type == "PAC" ?
                        dr["NATUREOFSURGERY"].ToString().Trim() == "R" ? "Elective" :
                        dr["NATUREOFSURGERY"].ToString().Trim() == "E" ? "Emergency" :
                        dr["NATUREOFSURGERY"].ToString().Trim() == "T" ? "Tentative" : "" : ""; //priyanka 23/02/2026
                        clPat.RefDoctor = Type == "PAC" ? "" : "";
                        clPat.RefPACTranNo = Type == "PAC" ? Convert.ToString(dr["TRANNO"]) : "";//priyanka 19/02/2026
                        if (Type != "PAC")
                        {
                            string payStat = Convert.ToString(dr["ONLPAYSTAT"]);
                            string compName = Type == "PAC" ? Convert.ToString(dr["COMPNAME"]) : Convert.ToString(dr["COMPNAME"]);
                            if (!string.IsNullOrEmpty(compName)) clPat.CompName = compName;
                            else if (payStat == "Y") clPat.CompName = "Online Paid";
                            else
                                clPat.CompName = Convert.ToString(dr["PATCATGNM"]).Trim();
                            clPat.OnlyPayStat = payStat;
                            string visitTypeCd = dr.Table.Columns.Contains("VISITTYPECD") ? Convert.ToString(dr["VISITTYPECD"]).Trim() : "";
                            if (visitTypeCd == "01") clPat.VisitType = "NW";
                            else if (visitTypeCd == "02" && Convert.ToString(dr["REVIEWRPTYN"]) == "Y") clPat.VisitType = "RR";
                            else if (visitTypeCd == "02" && Convert.ToString(dr["REVIEWRPTYN"]) != "Y") clPat.VisitType = "FU";
                            else clPat.VisitType = "";
                            clPat.MobileNo = Convert.ToString(dr["PATPHONE"]).Trim();
                            clPat.PatEmail = Convert.ToString(dr["PATEMAIL"]).Trim();
                            clPat.OutRefDrName = Convert.ToString(dr["OREFDRNM"]).Trim();
                            clPat.OutRefDrContact = Convert.ToString(dr["OREFDRPHONNO"]).Trim();
                            clPat.ReviewRYN = dr.Table.Columns.Contains("REVIEWRPTYN") ? Convert.ToString(dr["REVIEWRPTYN"]).Trim() : "";
                            clPat.VisitTypeCD = visitTypeCd == "" ? "C" : visitTypeCd;
                            clPat.ARRIVEDTM = Type == "PAC" ? "" : dr["ARRIVEDTM"].ToString().Trim() == "" ? "-" : dr["ARRIVEDTM"].ToString().Trim();
                            clPat.Compltm = Type == "PAC" ? "" : GeneralFunction.ConvertTimeTo24Hour(dr["COMPLTM"].ToString().Trim()); // Abhishesh || 20260323
                            string apmnttypecd = dr.Table.Columns.Contains("APMNTTYPE") ? Convert.ToString(dr["APMNTTYPE"]).Trim() : "";
                            if (apmnttypecd == "01") clPat.Apmnttype = "NW";
                            else if (apmnttypecd == "02") clPat.Apmnttype = "FU";
                            else if (apmnttypecd == "03") clPat.Apmnttype = "RR";
                            clPat.Apmnttypecd = apmnttypecd;
                            clPat.ApmntVisitType = ApmntVisitTypeLst.FirstOrDefault(x => x.Value == ("" + dr["APMNTVISITTYPE"]).Trim())?.Text ?? "";
                            clPat.ApmntVisitTypeCD = Convert.ToString(dr["APMNTVISITTYPE"]).Trim();

                        }


                        byte[] imgbyte = null;
                        new CommonServiceClient().UsingSafe(comser =>
                        {
                            imgbyte = comser.GetPatientPhoto(Convert.ToString(dr["MRNO"]));
                        });
                        System.Drawing.Image returnImage = null;
                        if (imgbyte == null ? false : (imgbyte.Length > 0))
                        {
                            byte[] oldbyteimage = null;
                            oldbyteimage = imgbyte;
                            string imreBase64Data = Convert.ToBase64String(oldbyteimage);
                            clPat.PatImageURL = string.Format("data:image/png;base64,{0}", imreBase64Data);
                        }
                        else
                        {
                            string noPreviewPath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/Images"), "NoPreview.png");
                            byte[] noPreviewBytes = File.ReadAllBytes(noPreviewPath);
                            string noPreviewBase64 = Convert.ToBase64String(noPreviewBytes);
                            clPat.PatImageURL = string.Format("data:image/png;base64,{0}", noPreviewBase64);
                        }
                        clPat.ConsDoctName = ("" + dr["CONSDOCT"]).Trim() == "" ? "" : (DoctLst.Where(X => X.Value == ("" + dr["CONSDOCT"]).Trim()).Count() > 0 ? DoctLst.Where(X => X.Value == ("" + dr["CONSDOCT"]).Trim()).First().Text : "");
                        clPat.AdvisedDoctName = ("" + dr["PRESCDOCT"]).Trim() == "" ? "" : (DoctLst.Where(X => X.Value == ("" + dr["PRESCDOCT"]).Trim()).Count() > 0 ? DoctLst.Where(X => X.Value == ("" + dr["PRESCDOCT"]).Trim()).First().Text : "");//priyanka 23/02/2026
                        if (dr.Table.Columns.Contains("PRIORITY"))
                        {
                            string p = Convert.ToString(dr["PRIORITY"]).Trim();
                            if (p.Contains("H") || p.Contains("I") || p.Contains("V")) clPat.PriorityType = "-" + p;
                        }
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
    }
    #endregion

    #region ChemoPlanning
    public class ChemoPlanning : BL_MedOnco
    {
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> ChemoPlanLstCourse { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> ChemoPlanLstTreatPlan { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> ChemoPlanLstChemoName { get; set; }
        public IEnumerable<SelectListItem> ChemoPlanLstConStatus { get; set; }
        public string ChemoPlanTempGaction { get; set; }
        public string ChemoPlanDuration { get; set; }
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
        public string gact { set; get; }
        public string gridChemo { set; get; }
        public string ReportRemark { set; get; }
        public string TreatmentDone { set; get; }
        public string ConclusionStatus { set; get; }
        public string TreatmentDate { set; get; }
        public string ChemoAdvStart { set; get; }
        public string ConclusionRemark { set; get; }   //vandana 160226
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> DiluentList { get; set; } // Added by Dhananjay 20260311 
        public List<SelectListItem> HoursLst { get; set; } //Pournima 26th June 2026

        OncologyEMR.OncologyServRef.OncologyClient onclgclnt = new OncologyEMR.OncologyServRef.OncologyClient();
        OncologyEMR.Oncology.OncologyEMRClient comser = new OncologyEMR.Oncology.OncologyEMRClient();
        CommonServiceClient cs = new CommonServiceClient();

        public void FillCombo()
        {
            ChemoPlanLstTreatPlan = cs.GetTreatPlanLst().Where(x => x.Status == "A").ToList();
            ChemoPlanLstChemoName = cs.GetChemoNameLst().Where(x => x.Status == "A").ToList();
            ChemoPlanLstCourse = cs.GetCourseLst().Where(x => x.Status == "A").ToList();
            ChemoPlanLstConStatus = GeneralFunction.LstConStatus;
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
            DiluentList = cs.GetPHGenericNAmesLst();
            DataSet DS = new DataSet();
            HoursLst = GeneralFunction.TreatmentHrsList(); //Pournima 26th June 2026
        }

        public object MedOncoSave(ChemoPlanning OPDMdl)
        {
            try
            {
                OncologyClient onco = new OncologyClient();
                BL_MedOnco template = new BL_MedOnco();

                if (OPDMdl.gact == "N")
                {
                    template.TranMode = (int)GeneralFunction.modes.NewMode;
                }
                else if (OPDMdl.gact == "E")
                {
                    if (string.IsNullOrEmpty(OPDMdl.TranNo))
                    {
                        return new { success = false, message = "Invalid Transaction No.", ConsultNo = OPDMdl.TranNo };
                    }

                    template.TranMode = (int)GeneralFunction.modes.EditMode;
                }
                else
                {
                    return new { success = false, message = "Invalid Action", ConsultNo = OPDMdl.TranNo };
                }


                template.IpAddress = HttpContext.Current.Session["MchIPAddress"].ToString();
                template.UserID = HttpContext.Current.Session["gOncoUserId"].ToString();
                template.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
                template.TranNo = OPDMdl.TranNo ?? string.Empty;
                template.MRNO = OPDMdl.MRNO;
                template.ChemoName = OPDMdl.ChemoName;
                template.Protocol = OPDMdl.Protocol;
                template.ToRepeat = OPDMdl.ToRepeat;
                template.TotalCycles = OPDMdl.TotalCycles;
                template.TreatmentModification = OPDMdl.TreatmentModification;
                template.Consultant = HttpContext.Current.Session["gDoctCode"].ToString();
                template.ChemoCourse = OPDMdl.ChemoCourse;
                template.HPReport = OPDMdl.HPReport;
                template.PrevTreatment = OPDMdl.PrevTreatment;
                template.Duration = OPDMdl.Duration;
                if (OPDMdl.DataMigrationDataModificationYN == "Y")
                {
                    template.DataMigrationDataModificationYN = OPDMdl.DataMigrationDataModificationYN;
                    template.CompletedCycles = OPDMdl.CompletedCycles;
                }
                //template.com
                double Tt;
                double Nn;
                double Mm;

                bool TRecord = double.TryParse(OPDMdl.T, out Tt);
                bool NRecord = double.TryParse(OPDMdl.N, out Nn);
                bool MRecord = double.TryParse(OPDMdl.M, out Mm);

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
                    template.M2 = OPDMdl.M2;
                else
                    template.M2 = "0.00";
                template.Height = OPDMdl.Height;
                template.Weight = OPDMdl.Weight;
                template.BSA = OPDMdl.BSA;

                template.Regime = string.Empty;
                template.TreatmentPlan = OPDMdl.TreatmentPlan;
                template.CancelRemarks = OPDMdl.CancelRemarks;
                template.Scheme = "" + OPDMdl.Scheme;
                template.SchemeOth = "" + OPDMdl.SchemeOth;
                template.PatCatg = "" + OPDMdl.PatCatg;
                template.PerformStatus = OPDMdl.PerformStatus;
                template.EntryDate = OPDMdl.EntryDate;
                template.Diagnosis = string.Empty;
                template.PreChemoFindings = OPDMdl.PreChemoFindings;
                template.ConsultNo = OPDMdl.ConsultNo;
                template.ICDYN = OPDMdl.ICDYN;
                template.Status = "V";
                template.Duration = OPDMdl.Duration;
                template.HourorDay = OPDMdl.HourorDay;
                template.HPRemarks = OPDMdl.ReportRemark;
                DataSet ds = new DataSet("DSMED");
                DataTable dtAllPhases = new DataTable("MEDDET");
                if (!string.IsNullOrWhiteSpace(OPDMdl.gridChemo) && OPDMdl.gridChemo != "[]")
                {
                    DataTable dtInv = JsonConvert.DeserializeObject<DataTable>(OPDMdl.gridChemo);

                    if (dtInv != null && dtInv.Rows.Count > 0)
                    {
                        DataTableReader reader = new DataTableReader(dtInv);
                        DataTable dtResult = new DataTable("MEDDET");
                        dtResult.Load(reader);

                        ds.Tables.Add(dtResult);
                        template.CHEMOMEDSTRUCTXML = ds.GetXml();
                    }
                }

                template.PlanCompletedYN = OPDMdl.TreatmentDone;
                template.PlanStatus = OPDMdl.ConclusionStatus;
                if (OPDMdl.TreatmentDate != string.Empty)
                {
                    template.PlanCompletedDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(OPDMdl.TreatmentDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
                }
                template.SchemeCodes = ""; //OPDMdl.SchemeCodes;
                template.AdvStartDate = GeneralFunction.GetDateInSpecifiedFormat(OPDMdl.ChemoAdvStart, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                template.ConclRemarks = OPDMdl.ConclusionRemark;     //vandana 170226
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
                        ConsultNo = OPDMdl.ConsultNo
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

        public string SaveChemoPrMaster(string AdmnDet, string Name, string Protocol, string Days, string AdmissionYN, string AdmissionNo, string ProtocolType)
        {
            CommonSerRef.CommonServiceClient comserv = new CommonSerRef.CommonServiceClient();
            OncologyClient OncClient = new OncologyClient();
            BL_ChemoProtocol ChemoPrMst = new BL_ChemoProtocol();
            ChemoPrMst.TranMode = (int)GeneralFunction.modes.NewMode;
            ChemoPrMst.Status = "A"; // model.Status;
            ChemoPrMst.Name = GeneralFunction.CheckSingleQuote(Name);
            ChemoPrMst.Protocol = Protocol;
            ChemoPrMst.Duration = string.Empty + Days;
            ChemoPrMst.AdmissionYN = string.Empty + AdmissionYN;
            ChemoPrMst.AdmissionNo = string.Empty + AdmissionNo;
            ChemoPrMst.ProtocolType = string.Empty + ProtocolType;
            var AllUnitList = comserv.GetUnitLst().Where(x => x.Status == "A");
            string UnitSatus = "";
            foreach (var unit in AllUnitList)
            {
                string UnitCd = unit.Value;
                if (("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString().Trim() == unit.Value)
                {
                    UnitSatus = UnitSatus + (UnitSatus == "" ? (UnitCd + ":A") : ("|" + UnitCd + ":A"));
                }
                else
                {
                    UnitSatus = UnitSatus + (UnitSatus == "" ? (UnitCd + ":I") : ("|" + UnitCd + ":I"));
                }
            }
            ChemoPrMst.UnitStatus = UnitSatus;
            DataSet ds = new DataSet("ADMNDS");
            if (!string.IsNullOrEmpty(AdmnDet))
            {
                try
                {
                    string cleanedDuration = AdmnDet.Trim();
                    DataTableReader reader = new DataTableReader(JsonConvert.DeserializeObject<DataTable>(AdmnDet));
                    DataTable dtadms = new DataTable("ADMNLST");
                    dtadms.Load(reader);
                    ds.Tables.Add(dtadms);
                    ChemoPrMst.AdmnDetXML = ds.GetXml();
                }
                catch (JsonReaderException ex)
                {
                    Console.WriteLine("JSON parsing error: " + ex.Message);
                }
            }

            ChemoPrMst.UserID = HttpContext.Current.Session["gOncoUserId"].ToString();

            string ret = OncClient.SaveChemoProtocol(ChemoPrMst);
            return ret;
        }


    }
    #endregion

    #region  Save OPD
    public class SaveOPD : BL_Oncology
    {
        public string StrComplaints { get; set; }
        public string StrDiagnosis { get; set; }
        public string StrICDDiagnosis { get; set; }
        public string StrICDODiagnosis { get; set; }
        public string StrICDHDiagnosis { get; set; }
        public string StrInvestigation { get; set; }
        public string StrRx { get; set; }
        public string StrInstruction { get; set; }
        public string StrNotesList { get; set; }
        public string StrFollowUpNo { get; set; }
        public string StrFollowUpDays { get; set; }
        public string StrPreAdmissionRemark { get; set; }
        public string SaveOPDConsultation(SaveOPD Mdl, SchemePreAuth SchemMdl)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();

            //General Info
            blOncology.TRANNO = Mdl.TRANNO;
            blOncology.MRNO = Mdl.MRNO;
            blOncology.CREATEDBY = ("" + System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString();
            blOncology.DoctorName = ("" + System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " ");
            blOncology.DoctorCode = ("" + System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.TranMode = 1;
            blOncology.PatName = Mdl.PatName;
            blOncology.Age = Mdl.Age;
            blOncology.Gender = Mdl.Gender;
            blOncology.MobileNo = Mdl.MobileNo;

            //Complaints
            DataSet DSForComplaints = new DataSet();
            DataTable DTForComplaintst = new DataTable();
            DSForComplaints.DataSetName = "DATA";
            if (Mdl.StrComplaints != null)
                DTForComplaintst = JsonConvert.DeserializeObject<DataTable>(Mdl.StrComplaints);
            DTForComplaintst.TableName = "COMPLAINT";
            DSForComplaints.Tables.Add(DTForComplaintst);
            blOncology.xmlComplaints = DSForComplaints.GetXml().Replace("&amp;", "");
            blOncology.FreeComplaint = Mdl.FreeComplaint;

            //Examination
            blOncology.ExamDet = Mdl.ExamDet;
            blOncology.PastHist = Mdl.PastHist;
            if (GeneralFunction.GetAppsettingUnitWiseValue("PassExamHistYN").ToString().Trim() == "Y")
            {
                string json = "";
                DataSet load = new DataSet();
                json = client.GetDoctDesk(Mdl.TRANNO, "S", Mdl.MRNO);
                load = GeneralFunction.FillDatasetXMl(json);
                json = load.Tables.Contains("EXAMS") == true ? (load.Tables["EXAMS"].Rows.Count > 0 ? load.Tables["EXAMS"].Rows[0]["PASTHIST"].ToString() : "") : "";
                blOncology.PastHist = json;
            }

            //Diagnosis
            DataSet DSForAllDiagnosis = new DataSet();
            DataTable DTForDiagnosis = new DataTable();
            DataTable DTForICDDiagnosis = new DataTable();
            DataTable DTForICDODiagnosis = new DataTable();
            DataTable DTForICDHDiagnosis = new DataTable();
            DSForAllDiagnosis.DataSetName = "DATA";
            if (Mdl.StrDiagnosis != null)
                DTForDiagnosis = JsonConvert.DeserializeObject<DataTable>(Mdl.StrDiagnosis);
            DTForDiagnosis.TableName = "DIGNOSIS";
            DSForAllDiagnosis.Tables.Add(DTForDiagnosis);
            if (Mdl.StrICDDiagnosis != null)
                DTForICDDiagnosis = JsonConvert.DeserializeObject<DataTable>(Mdl.StrICDDiagnosis);
            DTForICDDiagnosis.TableName = "ICDDIGNOSIS";
            DSForAllDiagnosis.Tables.Add(DTForICDDiagnosis);
            if (Mdl.StrICDODiagnosis != null)
                DTForICDODiagnosis = JsonConvert.DeserializeObject<DataTable>(Mdl.StrICDODiagnosis);
            DTForICDODiagnosis.TableName = "ICDODIGNOSIS";
            DSForAllDiagnosis.Tables.Add(DTForICDODiagnosis);
            if (Mdl.StrICDHDiagnosis != null)
                DTForICDHDiagnosis = JsonConvert.DeserializeObject<DataTable>(Mdl.StrICDHDiagnosis);
            DTForICDHDiagnosis.TableName = "ICDOHDIGNOSIS";
            DSForAllDiagnosis.Tables.Add(DTForICDHDiagnosis);
            blOncology.xmlDiagnosis = DSForAllDiagnosis.GetXml().Replace("&amp;", "");
            //Added By Rajan - To Get the TNM List 
            blOncology.type = "H";
            blOncology.TStag = Mdl.TStag;
            blOncology.NStag = Mdl.NStag;
            blOncology.MStag = Mdl.MStag;
            blOncology.DiagnosisSiteCode = Mdl.DiagnosisSiteCode;
            blOncology.DiagnosisSubSiteCode = Mdl.DiagnosisSubSiteCode;
            blOncology.CompositStag = Mdl.CompositStag;
            blOncology.CancerCaseYN = Mdl.CancerCaseYN;
            blOncology.RadiationOncoYN = Mdl.RadiationOncoYN;
            blOncology.MedcialOncoYN = Mdl.MedcialOncoYN;
            blOncology.PalliativeCareYN = Mdl.PalliativeCareYN;
            blOncology.ProviDiagnosis = Mdl.ProviDiagnosis;
            //client.SaveDoctorDesk(blOncology);

            //Clinical Notes
            blOncology.ClinicalNotes = Mdl.ClinicalNotes;

            //Investigation
            DataSet DSForInvestigation = new DataSet();
            DataTable DTForInvestigation = new DataTable();
            DSForInvestigation.DataSetName = "DATA";
            if (Mdl.StrInvestigation != null)
                DTForInvestigation = JsonConvert.DeserializeObject<DataTable>(Mdl.StrInvestigation);
            DTForInvestigation.TableName = "INVEST";
            foreach (DataRow drRow in DTForInvestigation.Rows)
            {
                drRow["TESTNAME"] = drRow["TESTNAME"].ToString().Contains('[') ? drRow["TESTNAME"].ToString().Substring(0, drRow["TESTNAME"].ToString().LastIndexOf("[")) : drRow["TESTNAME"].ToString().Trim();
            }
            DSForInvestigation.Tables.Add(DTForInvestigation);
            blOncology.xmlInvest = DSForInvestigation.GetXml().Replace("&amp;", "");
            blOncology.FreeInvestigation = Mdl.FreeInvestigation;


            //RX
            DataSet DSForRx = new DataSet("DATA");
            DataTable DTForRx = new DataTable();
            if (Mdl.StrRx != null)
                DTForRx = JsonConvert.DeserializeObject<DataTable>(Mdl.StrRx);
            DTForRx.TableName = "MEDICINE";
            if (DTForRx != null && DTForRx.Rows.Count > 0)
            {
                DSForRx.Tables.Add(DTForRx);
            }
            blOncology.xmlMedicine = DSForRx.GetXml();

            //Instruction And Advice
            DataSet DSForInstructionAndNotes = new DataSet();

            //Instruction
            DataTable DTForInstruction = new DataTable();
            if (Mdl.StrInstruction != null)
                DTForInstruction = JsonConvert.DeserializeObject<DataTable>(Mdl.StrInstruction);
            DTForInstruction.TableName = "PATADVICE";
            DSForInstructionAndNotes.Tables.Add(DTForInstruction);
            blOncology.FreeAdvice = Mdl.FreeAdvice;

            //Chemo Planning


            //Advice
            DataTable DTForNotes = new DataTable();
            if (Mdl.StrNotesList != null && Mdl.StrNotesList != "")
            {
                DTForNotes = JsonConvert.DeserializeObject<DataTable>(Mdl.StrNotesList);
            }

            if (Mdl.StrFollowUpNo != "0")
            {
                blOncology.FollowUpDt = string.Format("{0} {1}", Mdl.StrFollowUpNo, Mdl.StrFollowUpDays);
            }
            else
            {
                blOncology.FollowUpDt = string.Empty;
            }
            blOncology.SurgHist = Mdl.SurgHist;
            blOncology.TOthers = Mdl.TOthers;
            blOncology.RefDoctCode = Mdl.RefDoctCode;
            blOncology.CallDoneYN = Mdl.CallDoneYN;
            blOncology.ApmntDate = GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.ApmntDate), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blOncology.ApmntTime = ("" + Mdl.ApmntTime).Trim();
            blOncology.PrescRemark = Mdl.PrescRemark;
            blOncology.PlanOfTreatmnt = Mdl.PlanOfTreatmnt;
            blOncology.AdvAdmnYN = Mdl.AdvAdmnYN;
            blOncology.Redirect = Mdl.Redirect;
            blOncology.TBRefYN = Mdl.TBRefYN;
            blOncology.ProposeAdmnDt = GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.ProposeAdmnDt), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blOncology.PatCareTypeAdviced = Mdl.PatCareTypeAdviced;
            blOncology.SurgeryCodeAdviced = Mdl.SurgeryCodeAdviced;
            blOncology.SurgAdvicedDate = GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.SurgAdvicedDate), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blOncology.PACAdvicedDate = GeneralFunction.GetDateInSpecifiedFormat(("" + Mdl.PACAdvicedDate), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blOncology.SurgeryAdviceType = Mdl.SurgeryAdviceType;
            blOncology.SchemeCodes = Mdl.SchemeCodes;
            blOncology.AdmnUrgencyLevel = Mdl.AdmnUrgencyLevel;
            DTForNotes.TableName = "REFDOCT";
            DSForInstructionAndNotes.Tables.Add(DTForNotes);
            DSForInstructionAndNotes.DataSetName = "DATA";
            blOncology.xmlPatAdvice = DSForInstructionAndNotes.GetXml();
            blOncology.AdmnAdviceRemarks = Mdl.StrPreAdmissionRemark;
            blOncology.SurgeryAdviceOther = Mdl.SurgeryAdviceOther;
            blOncology.type = ("" + System.Web.HttpContext.Current.Session["RMOYN"]).ToString() == "Y" ? "3" : "0";
            blOncology.ReqSchemeCompCode = Mdl.ReqSchemeCompCode; // Pournima 2nd Sept 2026
            if (blOncology.CREATEDBY == "" && blOncology.CREATEDBY == "" && blOncology.CREATEDBY == "")
            {
                return "Session Timeout";
            }
            string PrescSaveResult = client.SaveDoctorDesk(blOncology);
            if (!PrescSaveResult.Trim().ToUpper().Contains("SUCCESS"))
            {
                return PrescSaveResult;
            }
            if (SchemMdl.SaveSchemeYN == "Y")
            {
                string PreAuthSchemeSaveResult = SchemMdl.SaveSchemePreAuth(SchemMdl);
                if (!PreAuthSchemeSaveResult.Trim().ToUpper().Contains("SUCCESS"))
                {
                    return PreAuthSchemeSaveResult;
                }
            }
            return PrescSaveResult;
        }
    }

    #endregion

    #endregion

    #region IPD

    #region Patient Waiting List
    public class WaitingListIPD
    {
        public string CaseType { get; set; }
        public List<SelectListItem> CaseTypeList { get; set; }

        public object GetIPPateintInfo(string strIpNo)
        {
            IPServiceClient ipserv = new IPServiceClient();
            DataSet ds = new DataSet();
            ds.ReadXml(new XmlTextReader(new StringReader(ipserv.GetIPRegistDet(strIpNo))));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Columns.Contains("MRNO"))
                {
                    CommonServiceClient comm = new CommonServiceClient();
                    var CaseTypeLst = comm.GetCaseType();
                    var data = (from DataRow row in ds.Tables[0].Rows
                                select new
                                {
                                    MRNO = Convert.ToString(row["MRNO"]).Trim(),
                                    IPNO = Convert.ToString(row["IPNO"]).Trim(),
                                    NAME = Convert.ToString(row["PATNAME"]).Trim(),
                                    GENDER = Convert.ToString(row["Gender"]).Trim(),
                                    PATDOB = GeneralFunction.GetDate(row["PATDOB"].ToString().Trim()), //Added by Murali on 02/08/2024 to get the DOB for Not Appointed Patients
                                    AGE = GeneralFunction.GetAge(GeneralFunction.GetDate(Convert.ToString(row["PATDOB"].ToString().Trim()))),  //row["PATAGE"].ToString().Trim(),
                                    MOBILE = Convert.ToString(row["PATMOBILE"]).Trim(),
                                    EMAIL = Convert.ToString(row["PATEMAIL"]).Trim(),
                                    SALUNAME = Convert.ToString(row["SALUNAME"]).Trim(),
                                    Category = Convert.ToString(row["PATCATGNM"]).Trim(),
                                    NURSCODE = Convert.ToString(row["NURSCODE"]).Trim(),
                                    //NEW: Admission Details Added By Abhishesh 
                                    ADMNDATE = ds.Tables[0].Columns.Contains("ADMNDATE") ? GeneralFunction.GetDate(Convert.ToString(row["ADMNDATE"]).Trim()) : "",
                                    ADMNTIME = ds.Tables[0].Columns.Contains("ADMNTIME") ? GeneralFunction.ConvertTo12HourFormat(Convert.ToString(row["ADMNTIME"]).Trim()) : "",
                                    CASETYPE = ds.Tables[0].Columns.Contains("CASETYPECD") ? GeneralFunction.GetListValue(CaseTypeLst, Convert.ToString(row["CASETYPECD"]).Trim()) : "",
                                    BEDCATEGORY = ds.Tables[0].Columns.Contains("OCCUBEDCATGNM") ? Convert.ToString(row["OCCUBEDCATGNM"]).Trim() : "",
                                    ADMNBEDNO = ds.Tables[0].Columns.Contains("ADMNBEDNO") ? Convert.ToString(row["ADMNBEDNO"]).Trim() : "",
                                    WARDNM = ds.Tables[0].Columns.Contains("WARDNM") ? Convert.ToString(row["WARDNM"]).Trim() : "",
                                    NURSTNM = ds.Tables[0].Columns.Contains("NURSTNM") ? Convert.ToString(row["NURSTNM"]).Trim() : "",
                                }).ToArray();
                    return data;
                }
            }

            return "";
        }

        public object GetIPPatientVitalInfo(string strIpNo)
        {
            Dictionary<string, string> dict = new Dictionary<string, string>();
            ICUClient ICUCLNT = new ICUClient();
            DataSet ds = new DataSet();
            ds.ReadXml(new XmlTextReader(new StringReader(ICUCLNT.GetIPPatLastVitals(strIpNo))));
            string StrWeight = "";
            string StrHeight = "";
            string StrRR = "";
            string StrSPO2 = "";
            string StrBMI = "";
            string StrBSA = "";
            string StrBP = "";
            string StrTemp = "";
            string CREATEDON = "";
            string CREATEDAT = "";
            string PATINTRNSCRT = "";
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    StrRR = ds.Tables[0].Rows[0]["RR"].ToString().Trim();
                    StrSPO2 = ds.Tables[0].Rows[0]["SPO2"].ToString().Trim();
                    StrBP = ds.Tables[0].Rows[0]["NIBPSYS"].ToString().Trim() != "" && ds.Tables[0].Rows[0]["NIBPDIA"].ToString().Trim() != "" ? ds.Tables[0].Rows[0]["NIBPSYS"].ToString().Trim() + "/" + ds.Tables[0].Rows[0]["NIBPDIA"].ToString().Trim() : "";
                    StrTemp = ds.Tables[0].Rows[0]["PERIPHRAL"].ToString().Trim();
                    CREATEDON = GeneralFunction.GetDate(("" + ds.Tables[0].Rows[0]["CREATEDON"]).Trim());
                    CREATEDAT = GeneralFunction.ConvertTo12HourFormat(("" + ds.Tables[0].Rows[0]["CREATEDAT"]).Trim());
                    PATINTRNSCRT = ds.Tables[0].Rows[0]["PATINTRNSCRT"].ToString().Trim();

                }
                if (ds.Tables.Count >= 1 && ds.Tables[1].Rows.Count > 0)
                {
                    StrWeight = ds.Tables[1].Rows[0]["WEIGHT"].ToString().Trim();
                    StrHeight = ds.Tables[1].Rows[0]["HEIGHT"].ToString().Trim();
                    StrBMI = ds.Tables[1].Rows[0]["BMI"].ToString().Trim();
                    StrBSA = ds.Tables[1].Rows[0]["BSA"].ToString().Trim();
                }
            }
            dict.Add("Weight", StrWeight);
            dict.Add("HEIGHT", StrHeight);
            dict.Add("TEMP", StrTemp);
            dict.Add("RESP", StrRR);
            dict.Add("SPO2", StrSPO2);
            dict.Add("BMI", StrBMI);
            dict.Add("BSA", StrBSA);
            dict.Add("BP", StrBP);
            dict.Add("CREATEDON", CREATEDON);
            dict.Add("CREATEDAT", CREATEDAT);
            dict.Add("PATINTRNSCRT", PATINTRNSCRT);

            return dict;
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
    }
    #endregion
    #region History & Examination IPD
    public class HistoryExamIPDModel
    {
        public string MRNO { get; set; }
        public string IPNO { get; set; }
        public string CREATEDBY { get; set; }
        public string DoctorCode { get; set; }
        public string FreeComplaint { get; set; }
        public string PresentIllness { get; set; }
        public string PastHist { get; set; }
        public string ecog { get; set; }
        public string GeneralExam { get; set; }
        public string LocalExam { get; set; }
        public string ProviDiagnosis { get; set; }

        public string SaveHistoryExamIPD(HistoryExamIPDModel mdl)
        {
            BL_Oncology blOncology = new BL_Oncology();
            OncologyEMRClient client = new OncologyEMRClient();



            blOncology.MRNO = mdl.MRNO ?? "";
            blOncology.IPNO = mdl.IPNO ?? "";
            blOncology.TRANNO = mdl.IPNO ?? "";
            blOncology.DoctorCode = ("" + System.Web.HttpContext.Current.Session["gDoctCode"]).ToString();
            blOncology.CREATEDBY = ("" + System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString();
            blOncology.DoctorName = ("" + System.Web.HttpContext.Current.Session["gDoctName"]).ToString().Replace("  ", " ");


            blOncology.TranMode = 1;
            blOncology.type = "H";


            blOncology.FreeComplaint = mdl.FreeComplaint ?? "";
            blOncology.PresentIllness = mdl.PresentIllness ?? "";
            blOncology.PCOthers = mdl.PresentIllness ?? "";
            blOncology.PastHist = mdl.PastHist ?? "";
            blOncology.ecog = mdl.ecog ?? "";
            blOncology.GeneralExam = mdl.GeneralExam ?? "";
            blOncology.ExamDet = mdl.GeneralExam ?? "";
            blOncology.LocalExam = mdl.LocalExam ?? "";
            blOncology.Onexamdet = mdl.LocalExam ?? "";
            blOncology.ProviDiagnosis = mdl.ProviDiagnosis ?? "";

            return client.SaveIPDDischargeTran(blOncology);


        }

        public object GetHistoryExamIPDData(string ipno, string mrno)
        {
            OncologyEMRClient client = new OncologyEMRClient();
            Dictionary<string, string> result = new Dictionary<string, string>();
            result["FreeComplaint"] = "";
            result["PresentIllness"] = "";
            result["PastHist"] = "";
            result["ecog"] = "";
            result["GeneralExam"] = "";
            result["LocalExam"] = "";
            result["ProviDiagnosis"] = "";

            try
            {
                // Call GetIPDDischargeDtls passing only ipno
                string xmlData = client.GetIPDDischargeDtls(ipno);

                if (!string.IsNullOrEmpty(xmlData))
                {
                    DataSet ds = new DataSet();
                    ds.ReadXml(new StringReader(xmlData));

                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = ds.Tables.Contains("Table") ? ds.Tables["Table"] : ds.Tables[0];
                        DataRow row = dt.Rows[0];

                        if (dt.Columns.Contains("FREETEXTCOMPLAINT"))
                            result["FreeComplaint"] = row["FREETEXTCOMPLAINT"].ToString();

                        if (dt.Columns.Contains("PRESENTILLNESS"))
                            result["PresentIllness"] = row["PRESENTILLNESS"].ToString();

                        if (dt.Columns.Contains("PASTHIST"))
                            result["PastHist"] = row["PASTHIST"].ToString();

                        if (dt.Columns.Contains("ECOGSCORE"))
                            result["ecog"] = row["ECOGSCORE"].ToString();

                        if (dt.Columns.Contains("GENEXAM"))
                            result["GeneralExam"] = row["GENEXAM"].ToString();

                        if (dt.Columns.Contains("LOCALEXAM"))
                            result["LocalExam"] = row["LOCALEXAM"].ToString();

                        if (dt.Columns.Contains("PROVDIAGNOSIS"))
                            result["ProviDiagnosis"] = row["PROVDIAGNOSIS"].ToString();
                    }
                }
            }
            catch (Exception)
            {
                // Return default empty fields if error or not found
            }

            return result;
        }
    }

    #endregion

        #region Progress Notes
        public class NursingNotes : formrights
    {
        ICUClient icuclnt = new ICUClient();
        CommonServiceClient comserv = new CommonServiceClient();
        public List<OncologyEMR.CommonSerRef.SelectLstItem> ShiftSelected { get; set; }
        public string ShiftDate { get; set; }
        public string shifts { get; set; }
        public string shifttodayDate { get; set; }
        public string todaystime { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> AMPM { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> ProblemList { get; set; }
        public string ProblemCode { get; set; }
        public string AuthUserId { get; set; }
        public string AuthPwd { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.UserLstItem> AuthUserIdList { get; set; }
        public int TranMode { get; set; }
        public string NursgNotes { get; set; }
        public string NursgNotesDate { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> TimeSelection { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> InkColorLst { get; set; }
        public string UserType { get; set; }
        public string ProvDiagno { get; set; }
        public string Allergies { get; set; }
        public string NursgAddNotesTime { get; set; }

        public void FillCombo(NursingNotes nursgnote)
        {
            CommonServiceClient comserv = new CommonServiceClient();
            nursgnote.ProblemList = comserv.GetICUProbList().Where(x => x.Status == "A").Select(x => new OncologyEMR.CommonSerRef.SelectLstItem { Text = x.Text, Value = x.Value }).ToList();
            nursgnote.AuthUserIdList = comserv.GetUserList();
            List<OncologyEMR.CommonSerRef.SelectLstItem> inklist = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            inklist.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Black", Value = "B" });
            inklist.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Red", Value = "R" });
            nursgnote.InkColorLst = inklist;
            nursgnote.Rights = OncologyEMR.DataClass.GeneralFunction.assignRightToModel(nursgnote, "NursingNotes");
        }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> TimeList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            return list;
        }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> ShiftList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Morning", Value = "Morning" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Evening", Value = "Evening" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Night", Value = "Night" });
            return list;
        }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> AMPMList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "AM", Value = "AM" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "PM", Value = "PM" });
            return list;
        }
        public object GetICUInterventionListData(string problmcd, string ProblmTm, string Problemdt)
        {
            ICUClient icuclnt = new ICUClient();
            CommonServiceClient comserv = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataTable dts = new DataTable();
            DataTable bc = new DataTable();
            List<OncologyEMR.CommonSerRef.SelectLstItem> ProblmList;
            var userid = HttpContext.Current.Session["UserID"].ToString();
            ProblmList = comserv.ICUInterventionLst(problmcd).ToList();
            var UserList = comserv.GetUserList();
            var ProblemCode = comserv.GetICUProbList().Where(x => x.Value == problmcd.Trim()).Count() == 0 ? "" : comserv.GetICUProbList().Where(x => x.Value == problmcd.Trim()).First().Value;
            var ProblemText = comserv.GetICUProbList().Where(x => x.Value == problmcd.Trim()).Count() == 0 ? "" : comserv.GetICUProbList().Where(x => x.Value == problmcd.Trim()).First().Text;
            var GuideLineText = comserv.GetICUProbList().Where(x => x.Value == problmcd.Trim()).Count() == 0 ? "" : comserv.GetICUProbList().Where(x => x.Value == problmcd.Trim()).First().GuideLine;
            object usercd = UserList.Where(x => x.Value == userid.Trim()).Count() == 0 ? "" : UserList.Where(x => x.Value == userid.Trim()).First().Text;
            object jsonData = "";
            jsonData = new
            {
                rows = (from lst in new[] { 1 }
                        select new
                        {
                            PROBLEMDATE = Problemdt.Trim(),
                            PROBLEMTIME = ProblmTm.Trim(),
                            PROBLEMCODE = ProblemCode.Trim(),
                            PROBLEMTEXT = ProblemText.Trim(),
                            PROBLEMS = ProblmTm.Trim() + "      " + ProblemText.Trim(),
                            ExpectedOutcome = "",
                            Select = "Y",
                            EVALAUTETIME = "",
                            STAFFID = userid,
                            STAFFNAME = usercd,
                            INTERVENTIONCODE = "",
                            INTERVENTIONTEXT = "",
                            GUIDELINE = GuideLineText.Trim(),
                            FinalRemark = "",
                            RemarkAddedBy = "",
                            RemarkAddOn = "",
                            RemarkAddAt = "",
                            IsSave = ""
                        }).ToArray()
            };
            return jsonData;

        }
        public object GetNursgNotesData(string ipno, string notedate, string userid, string problemcd, string CloseYN)
        {
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            object jsonData = "";
            notedate = GeneralFunction.GetDateInSpecifiedFormat(notedate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            var authby = HttpContext.Current.Session["AUTHYN"].ToString();
            var ProblmList = comserv.ICUInterventionLst("").ToList();
            var UserList = comserv.GetUserList();
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetICUNurseNotes(ipno, "", "", "", "", "", problemcd, CloseYN))));  //as per new changes pass the date "" And and get all the notes added 
            if (load.Tables.Count > 0)
            {
                dt = load.Tables[0];
                jsonData = new
                {
                    rows = (from DataRow row in dt.Rows
                            select new
                            {
                                Select = ("" + row["SELECTEDYN"]).Trim(),
                                PROBLEMDATE = GeneralFunction.GetDate(("" + row["NOTEDT"]).Trim()),
                                PROBLEMCODE = ("" + row["PROBCODE"]).Trim(),
                                PROBLEMTIME = ("" + row["PROBTM"]).Trim(),
                                PROBLEMTEXT = ("" + row["PROBLEMTXT"]).Trim(),
                                PROBLEMS = ("" + row["PROBTM"]).Trim() + "      " + ("" + row["PROBLEMTXT"]).Trim(),
                                INTERVENTIONCODE = ("" + row["INTERVENTCD"]).Trim(),
                                INTERVENTIONTEXT = ("" + row["INVENTDESCRIPT"]).Trim(),
                                ExpectedOutcome = ("" + row["EXPECTOUTPUT"]).Trim(),
                                EVALAUTETIME = ("" + row["EVALWITHTM"]).Trim(),
                                STAFFID = ("" + row["USERID"]).ToString().Trim(),
                                STAFFNAME = UserList.Where(x => x.Value == ("" + row["USERID"]).Trim()).Count() == 0 ? "" : UserList.Where(x => x.Value == ("" + row["USERID"]).Trim()).First().Text,
                                NOTEDT = GeneralFunction.GetDate(("" + row["NOTEDT"]).Trim()),
                                VSTATUS = ("" + row["VSTATUS"]).Trim(),
                                VERIFIEDBY = UserList.Where(x => x.Value == ("" + row["VERIFIEDBY"]).Trim()).Count() == 0 ? "" : UserList.Where(x => x.Value == ("" + row["VERIFIEDBY"]).Trim()).First().Text,
                                VERIFIEDON = GeneralFunction.GetDate(("" + row["VERIFIEDON"]).Trim()),
                                VERIFIEDAT = GeneralFunction.ConvertTo12HourFormat(("" + row["VERIFIEDAT"]).Trim()),
                                ASSESSMENT = ("" + row["ASSESSMENT"]).Trim(),
                                PLANNINGTXT = ("" + row["PLANNING"]).Trim(),
                                GUIDELINE = ("" + row["GUIDELINE"]).Trim(),
                                FinalRemark = ("" + row["FINALREMARK"]).Trim(),
                                IsSave = string.IsNullOrWhiteSpace("" + row["FINALREMARK"]) ? "" : "D",
                                RemarkAddedBy = ("" + row["REMARKADDBY"]).Trim().Trim().ToString(),
                                RemarkAddOn = GeneralFunction.GetDate(("" + row["REMARKADDON"]).Trim()),
                                RemarkAddAt = ("" + row["REMARKADDAT"]).Trim(),
                                InterventionAddedBy = ("" + row["INTERVADDBY"]).Trim().Trim().ToString(),
                                InterventionAddOn = GeneralFunction.GetDate(("" + row["INTERVADDON"]).Trim()),
                                InterventionAddAt = ("" + row["INTERVADDAT"]).Trim(),
                                CLOSEYN = ("" + row["CLOSEYN"]).Trim(),
                                isNewRow = (("" + row["INTERVADDBY"]).Trim() == "") ? "true" : "false",

                            }).ToArray()
                };
            }
            return jsonData;
        }
        public object GetICUProgressNotesData(string strIPNo, string strFromDate, string strToDate, string strTime, string strToTime, string userid, string NoteType)
        {
            DataSet loads = new DataSet();
            List<UserLstItem> userLst = null;
            CommonServiceClient SecUser = new CommonServiceClient();
            userLst = SecUser.GetUserList().ToList();
            object jsonData = new { rows = new object[] { } };
            object JsonCaseDetailData = new object[] { };
            object JsonAllergisData = new object[] { };
            DataTable dt8 = new DataTable();
            DataTable dt9 = new DataTable();
            userid = HttpContext.Current.Session["gOncoUserId"].ToString().Trim() ?? "";
            string username = HttpContext.Current.Session["gDoctName"].ToString().Trim() ?? "";
            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            CommonServiceClient comser = new CommonServiceClient();
            DataSet ds = GetCaseDetails(strIPNo);
            loads.ReadXml(new XmlTextReader(new StringReader(
                icuclnt.GetAddNurseNotes(strIPNo, strFromDate, strTime, strToDate, strToTime, userid, "N")
            )));
            if (loads.Tables.Contains("Table"))
            {
                DataTable nurseNotesTable = loads.Tables["Table"];
                DataView dv = nurseNotesTable.DefaultView;
                //dv.Sort = "NOTEDT DESC, NOTETM DESC"; // Abhishesh || 20260818
                nurseNotesTable = dv.ToTable();
                jsonData = new
                {
                    rows = (from DataRow row in nurseNotesTable.Rows
                            select new
                            {
                                NOTEDT = GeneralFunction.GetDate(row["NOTEDT"].ToString().Trim()),
                                NOTETM = GeneralFunction.ConvertTimeTo24Hour(row["NOTETM"].ToString().Trim()), // Abhishesh || 20260323
                                USERID = !string.IsNullOrEmpty(row["USERID"].ToString().Trim()) ? ((row["NOTETYPE"].ToString().Trim() != "N" ? "Dr. " : "") +
                                     GeneralFunction.GetListValue(userLst, row["USERID"].ToString().Trim()) + " (" + row["USERID"].ToString().Trim() + ")") : "",
                                NURSENOTES = row["NURSENOTES"].ToString().Trim(),
                                NOTETYPE = row["NOTETYPE"].ToString().Trim(),
                                NoteNo = row["NOTENO"].ToString().Trim(),
                                INKCOLOR = row["INKCOLOR"].ToString().Trim()

                            }).ToArray()
                };
            }
            if (ds.Tables.Contains("CaseDetails"))
            {
                dt8 = ds.Tables["CaseDetails"];
                if (dt8.Rows.Count > 0)
                {
                    JsonCaseDetailData = (from DataRow row in dt8.AsEnumerable()
                                          select new
                                          {
                                              PROVDIAGNO = row["PROVDIAG"].ToString().Trim(),
                                              DIAGNOSIS = row["DIAGNOSIS"].ToString().Trim(),
                                              WEIGHT = row["WEIGHT"].ToString().Trim(),
                                              HEIGHT = row["HEIGHT"].ToString().Trim(),
                                              BSA = row["BSA"].ToString().Trim(),
                                          }).ToArray();
                }
            }
            if (ds.Tables.Contains("Allergy"))
            {
                dt9 = ds.Tables["Allergy"];
                if (dt9.Rows.Count > 0)
                {
                    JsonAllergisData = (from DataRow row in dt9.AsEnumerable()
                                        select new
                                        {
                                            ALLERGYDESC = row["ALLERGYDESC"].ToString().Trim(),
                                        }).ToArray();
                }
            }
            return new
            {
                Notes = jsonData,
                JsonCaseDetailData = JsonCaseDetailData,
                JsonAllergisData = JsonAllergisData
            };
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
        public string SaveNursingNotesTran(string PatientData, string NursgNotes, string prblmdate, string prblmtime, string staffid, string mode)
        {
            ICUClient icuclnt = new ICUClient();
            AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            var serializer = new JavaScriptSerializer();
            BL_NurseNotes blnursgnotes = new BL_NurseNotes();
            var AsstLst = assmntofline.AssmntList();
            var UserLst = comserv.GetUserList();
            DataSet ds = new DataSet("NursingNotes");
            DataTable dt = new DataTable();
            dt = JsonConvert.DeserializeObject<DataTable>(NursgNotes);
            if (mode == "S")
            {
                foreach (DataRow row in dt.Rows.Cast<DataRow>().ToList())
                {
                    bool isAllEmpty =
                        string.IsNullOrWhiteSpace(row["ASSESSMENT"].ToString()) &&
                        string.IsNullOrWhiteSpace(row["ExpectedOutcome"].ToString()) &&
                        string.IsNullOrWhiteSpace(row["PLANNINGTXT"].ToString());
                    if (isAllEmpty)
                    {
                        dt.Rows.Remove(row);
                    }
                }
            }
            ds.Tables.Add(dt);
            if (dt.Rows.Count > 0)
            {
                dt.TableName = "Problems";
                dt.Columns.Remove("PROBLEMTEXT");
                dt.Columns.Add("SEQNO");
                if (dt.Columns.Contains("PROBLEMS"))
                {
                    dt.Columns.Remove("PROBLEMS");
                }
                int seqno = 1;
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    if (dt.Rows[i]["STAFFID"].ToString().Trim() == "")
                    {
                        dt.Rows[i]["STAFFID"] = staffid.ToString().Trim();
                    }
                    dt.Rows[i]["SEQNO"] = seqno;
                    if (dt.Rows[i]["INTERVENTIONTEXT"].ToString().Trim() == "")
                    {
                        dt.Rows[i]["InterventionAddOn"] = "";
                        dt.Rows[i]["InterventionAddedBy"] = "";
                        dt.Rows[i]["InterventionAddAt"] = "";
                    }
                    else
                    {
                        if (dt.Rows[i]["InterventionAddOn"] != "")
                        {
                            dt.Rows[i]["InterventionAddOn"] = GeneralFunction.GetDateInSpecifiedFormat(dt.Rows[i]["InterventionAddOn"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }
                    }
                    if (dt.Rows[i]["RemarkAddOn"] != "")
                    {
                        dt.Rows[i]["RemarkAddOn"] = GeneralFunction.GetDateInSpecifiedFormat(dt.Rows[i]["RemarkAddOn"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                    }
                    if (dt.Rows[i]["VERIFIEDON"] != "")
                    {
                        dt.Rows[i]["VERIFIEDON"] = GeneralFunction.GetDateInSpecifiedFormat(dt.Rows[i]["VERIFIEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                    }
                    if (dt.Rows[i]["VERIFIEDAT"] != "")
                    {
                        dt.Rows[i]["VERIFIEDAT"] = GeneralFunction.ConvertTo24HourFormat(dt.Rows[i]["VERIFIEDAT"].ToString().Trim());
                    }
                    if (dt.Rows[i]["VERIFIEDBY"] != "")
                    {
                        dt.Rows[i]["VERIFIEDBY"] = GeneralFunction.GetUserIdByUserName(dt.Rows[i]["VERIFIEDBY"].ToString().Trim());
                    }
                    seqno++;
                }
                dt.Columns.Remove("STAFFNAME");
                dt.Columns.Remove("AddBtn");
                dt.Columns.Remove("InterAddBtn");
            }
            string nursgxml = ds.GetXml();
            blnursgnotes.IpAdress = HttpContext.Current.Session["MchIPAddress"].ToString();
            blnursgnotes.IPNo = "";//userModal.strUIPNo;
            blnursgnotes.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            blnursgnotes.MRNo = "";//userModal.strUMrNo;
            blnursgnotes.PatName = "";//userModal.strUName;
            blnursgnotes.Status = "";
            blnursgnotes.NoteDt = GeneralFunction.GetDateInSpecifiedFormat(prblmdate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blnursgnotes.NewYN = "";
            blnursgnotes.PrintYN = "";
            blnursgnotes.ShowYN = "";
            if (mode == "S")
            {
                blnursgnotes.NurseNotesDtXML = nursgxml;
                blnursgnotes.Tranmode = 1;
            }
            else if (mode == "C")
            {

                blnursgnotes.NurseNotesDtXML = nursgxml;
                blnursgnotes.Tranmode = 7;
            }
            else
            {
                blnursgnotes.NurseNotesDtXML = nursgxml;
                blnursgnotes.Tranmode = 6;
            }
            blnursgnotes.TranNo = "";
            blnursgnotes.userID = HttpContext.Current.Session["UserID"].ToString();
            blnursgnotes.AuthYN = HttpContext.Current.Session["AUTHYN"].ToString();
            blnursgnotes.verifyYn = "";
            string snlst = "";
            return snlst = icuclnt.NurseNoteTran(blnursgnotes);
        }
        public object AuthonticateData(string AuthUserid, string Authpwd)
        {
            bool logins = false;
            logins = comserv.ChkLogin(AuthUserid, Authpwd);
            return logins;
        }
        public object GetNursgAdditionalNotesTran(string ipno, string notedate, string notetime, string userid, string NoteType)
        {
            ICUClient icuclnt = new ICUClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            CommonServiceClient comserv = new CommonServiceClient();
            object jsonData = string.Empty;
            notedate = GeneralFunction.GetDateInSpecifiedFormat(notedate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            var authby = HttpContext.Current.Session["AUTHYN"].ToString();
            if (authby == "Y")
            {
                userid = "";
            }
            else
            {
                userid = HttpContext.Current.Session["UserID"].ToString();
            }
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetAddNurseNotes(ipno, notedate, notetime, "", "", userid, NoteType))));
            if (NoteType != "S")
            {
                if (load.Tables.Count > 0)
                {
                    dt = load.Tables[0];
                    if (dt.Columns.Count > 1)
                    {
                        jsonData = new
                        {
                            rows = (from DataRow row in dt.Rows
                                    select new
                                    {
                                        IPNO = ("" + row["IPNO"]).Trim(),
                                        NOTEDT = ("" + row["NOTEDT"]).Trim(),
                                        NOTETM = ("" + row["NOTETM"]).Trim(),
                                        NURSENOTES = ("" + row["NURSENOTES"]).Trim(),
                                        USERID = ("" + row["USERID"]).Trim().ToString().Trim(),
                                        CREATEDON = ("" + row["CREATEDON"]).Trim(),
                                        CREATEDAT = ("" + row["CREATEDAT"]).Trim(),
                                        INKCOLOR = ("" + row["INKCOLOR"]).Trim(),
                                        VSTATUS = ("" + row["VSTATUS"]).Trim(),
                                        VERIFIEDBY = ("" + row["VERIFIEDBY"]).Trim().Trim().ToString().Trim(),
                                        VERIFIEDON = GeneralFunction.GetDate(("" + row["VERIFIEDON"]).Trim()),
                                        VERIFIEDAT = ("" + row["VERIFIEDAT"]).Trim(),
                                    }).ToArray()
                        };
                    }
                    else
                    {
                        jsonData = new
                        {
                            rows = (from DataRow row in dt.Rows
                                    select new
                                    {
                                        IPNO = "",
                                        NOTEDT = "",
                                        NOTETM = ("" + row["NOTETM"]).Trim(),
                                        NURSENOTES = "",
                                        USERID = "",
                                        CREATEDON = "",
                                        CREATEDAT = "",
                                    }).ToArray()
                        };
                    }
                }
            }
            else if (NoteType == "S")
            {
                if (load.Tables.Count > 0)
                {
                    dt = load.Tables[0];
                    if (dt.Columns.Count > 1)
                    {
                        jsonData = new
                        {
                            rows = (from DataRow row in dt.Rows
                                    select new
                                    {
                                        IPNO = ("" + row["IPNO"]).Trim(),
                                        OBSERVDT = ("" + row["OBSERVDT"]).Trim(),
                                        OBSERVTM = ("" + row["OBSERVTM"]).Trim(),
                                        OBSERVATION = ("" + row["OBSERVATION"]).Trim(),
                                        USERID = ("" + row["USERID"]).Trim().ToString().Trim(),
                                        CREATEDON = ("" + row["CREATEDON"]).Trim(),
                                        CREATEDAT = ("" + row["CREATEDAT"]).Trim(),
                                        INKCOLOR = ("" + row["INKCOLOR"]).Trim(),
                                        VSTATUS = ("" + row["VSTATUS"]).Trim(),
                                        VERIFIEDBY = ("" + row["VERIFIEDBY"]).Trim().Trim().ToString().Trim(),
                                        VERIFIEDON = GeneralFunction.GetDate(("" + row["VERIFIEDON"]).Trim()),
                                        VERIFIEDAT = ("" + row["VERIFIEDAT"]).Trim(),
                                    }).ToArray()
                        };
                    }
                    else
                    {
                        jsonData = new
                        {
                            rows = (from DataRow row in dt.Rows
                                    select new
                                    {
                                        IPNO = "",
                                        NOTEDT = "",
                                        OBSERVTM = ("" + row["OBSERVTM"]).Trim(),
                                        OBSERVATION = "",
                                        USERID = "",
                                        CREATEDON = "",
                                        CREATEDAT = "",
                                    }).ToArray()
                        };
                    }
                }
            }
            return jsonData;
        }
        public object GetNursgAdditionalNotesTime(string ipno, string notedate, string notetime, string userid, string NoteType)
        {
            ICUClient icuclnt = new ICUClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            CommonServiceClient comserv = new CommonServiceClient();
            object jsonData = string.Empty;
            object jsonDatas = string.Empty;
            notedate = GeneralFunction.GetDateInSpecifiedFormat(notedate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            var authby = HttpContext.Current.Session["AUTHYN"].ToString();
            if (authby == "Y")
            {
                userid = "";
            }
            else
            {
                userid = HttpContext.Current.Session["UserID"].ToString();
            }
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetAddNurseNotes(ipno, notedate, notetime, "", "", userid, NoteType))));
            if (load.Tables.Count > 0)
            {
                dt = load.Tables[0];

                if (dt.Columns.Count == 3)
                {
                    if (NoteType == "S")
                    {
                        jsonData = new
                        {
                            rows = (from DataRow row in dt.Rows
                                    select new
                                    {
                                        OBSERVTM = ("" + row["OBSERVTM"]).Trim(),
                                        VSTATUS = ("" + row["VSTATUS"]).Trim(),
                                        USERID = ("" + row["USERID"]).Trim(),
                                    }).ToArray()
                        };
                    }
                    else if (NoteType != "S")
                    {
                        jsonData = new
                        {
                            rows = (from DataRow row in dt.Rows
                                    select new
                                    {
                                        NOTETM = ("" + row["NOTETM"]).Trim(),
                                        VSTATUS = ("" + row["VSTATUS"]).Trim(),
                                        USERID = ("" + row["USERID"]).Trim(),
                                    }).ToArray()
                        };
                    }

                }
            }
            return jsonData;
        }
        public string SaveNursgAdditionalNotesTran(string ipno, string NursgNotesData, string notedate, string notetime, string userid, string strInkColor, string nmode, string AuthYn, string NoteType)
        {
            ICUClient icuclnt = new ICUClient();
            var shifttodayDate = comserv.GetServerDate();
            var todaytime = comserv.GetServerTime();
            string pcdate = notedate + " " + notetime;
            DateTime dateFrompc = DateTime.ParseExact(pcdate, "dd/MM/yyyy hh:mm tt", System.Globalization.CultureInfo.InvariantCulture);
            dateFrompc.ToString("dd-MMM-yyyy");
            string srvdate = shifttodayDate + " " + notetime;
            //string s = DateTime.ParseExact(todaytime, "hh:mm tt", CultureInfo.CurrentCulture).ToString("hh:mm tt");
            //DateTime s = DateTime.ParseExact(srvdate, "dd/MM/yyyy hh:mm tt", System.Globalization.CultureInfo.InvariantCulture);
            //s.ToString("dd-MMM-yyyy");
            string srvdt = shifttodayDate + " " + notetime;
            DateTime dateFromsrv = DateTime.ParseExact(srvdt, "dd/MM/yyyy hh:mm tt", System.Globalization.CultureInfo.InvariantCulture);
            dateFromsrv.ToString("dd-MMM-yyyy");
            TimeSpan duration = dateFrompc - dateFromsrv;
            DateTime dt1srv = DateTime.ParseExact(shifttodayDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            DateTime dt2pc = DateTime.ParseExact(notedate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            dateFromsrv.ToString("dd-MMM-yyyy");
            bool flag = false;
            int minutes = dateFrompc.Minute - dateFromsrv.Minute;
            if (duration.Minutes >= 5)
            {
                flag = true;
            }
            if (dt2pc > dt1srv)
            {
                return "Please Set ur PC Date Properly";
            }
            else if (dateFrompc >= dateFromsrv && flag == true)
            {
                return "Please Set ur PC Time Properly";
            }
            else
            {
                BL_NurseNotes blnursgnotes = new BL_NurseNotes();
                blnursgnotes.AddNotes = NursgNotesData;
                blnursgnotes.AddNursDt = GeneralFunction.GetDateInSpecifiedFormat(notedate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD); ;
                blnursgnotes.AddNursTM = notetime;
                blnursgnotes.IPNo = ipno;
                blnursgnotes.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
                blnursgnotes.InkColor = strInkColor;
                blnursgnotes.AuthYN = AuthYn;
                blnursgnotes.AdminYN = ""; //HttpContext.Current.Session["ADMINYN"].ToString();
                if (nmode == "S")
                {
                    blnursgnotes.Tranmode = 1;
                }
                else
                {
                    blnursgnotes.Tranmode = 6;
                }
                blnursgnotes.NSType = NoteType;
                string snlst = "";
                return snlst = icuclnt.AddNurseNoteTran(blnursgnotes);
            }
        }
        public object GetProKeyDescription(string ProKeyName)
        {
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            object jsonData = "";
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.ICUProKeyList(ProKeyName))));
            if (load.Tables.Count > 0)
            {
                dt = load.Tables[0];
                jsonData = new
                {
                    rows = (from DataRow row in dt.Rows
                            select new
                            {
                                PROKEY = row["PROKEY"].ToString(),
                                STATUS = row["STATUS"].ToString(),
                                PROCODE = row["PROCODE"].ToString(),
                                PRONAME = row["PRONAME"].ToString()
                            }).ToArray()
                };
            }
            return jsonData;
        }

        public object GetProKeyMasterList()
        {
            CommonServiceClient common = new CommonServiceClient();
            DataSet load = new DataSet();
            JavaScriptSerializer ser = new JavaScriptSerializer();
            load.ReadXml(new XmlTextReader(new StringReader(common.Get2or3FldMstData("PROKEYS", GeneralFunction.SetModule.ICU.ToString(), ""))));
            if (load.Tables.Count > 0)
            {
                var jsonData = (from DataRow row in load.Tables[0].Rows
                                select new
                                {
                                    CODE = row["CODE"].ToString().Trim(),
                                    NAME = row["NAME"].ToString().Trim(),
                                    STATUS = row["STATUS"].ToString().Trim(),
                                    FIELD3 = "",
                                    HIDDENVAL = row["PRONAME"].ToString().Trim().Trim(),
                                    CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                    CREATEDON = GeneralFunction.GetUIDateFormat(row["CREATEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
                                    CREATEDAT = row["CREATEDAT"].ToString().Trim(),
                                    EDITEDBY = row["EDITEDBY"].ToString().Trim(),
                                    EDITEDON = GeneralFunction.GetUIDateFormat(row["EDITEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
                                    EDITEDAT = row["EDITEDAT"].ToString().Trim(),
                                    UNITCODE = row["UNITCODE"].ToString().Trim(),
                                    UNITNAME = GeneralFunction.GetUnitName(row["UNITCODE"].ToString().Trim()),
                                }).ToArray();
                return jsonData;
            }
            else
            {
                return ser.Serialize("");
            }
        }

    }
    #endregion

    #region OT Booking Request
    public class NSOTCathBookReqModel : BL_NSCommonProp
    {
        public string OTCathType { get; set; }
        public string Priority { get; set; }
        public string SurgDate { get; set; }
        public string SurgTime { get; set; }
        public string Remarks { get; set; }
        public string TranDate { get; set; }
        public string TranTime { get; set; }
        public string searchSurgryCode { get; set; }
        public IEnumerable<OTCathSurgery> OTSURGLIST { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.DoctorSelLstItem> OTDOCTLIST { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.DoctorSelLstItem> CATHDOCTLIST { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string StrGblNursCode { get; set; }
        public string Diagnosis { get; set; }
        public void fillCombo()
        {
            CommonServiceClient comclient = new CommonServiceClient();
            string OTDeptCode = comclient.GetSetupValue("OTDEPARTMENT");
            OTSURGLIST = comclient.GetOTCathSurgList(OTDeptCode);
            CATHDOCTLIST = comclient.GetDoctLst();
            OTDOCTLIST = CATHDOCTLIST.Where(x => x.SurgYN.ToString() == "Y");
        }
        public object SaveOTCathReqMdl(string Ipno, string Mrno, string NursStation,
                string BedWardNo, string GridData, string GAction, string ReqNo, string SurgeryDate, string SurgeryTime, string OTCathType, string strPriority, string Remarks,string SurgeryRemarks, string Diagnosis, string SchemeCodes, string Side) //priyanka 04/05/2026
        {
            CommonServiceClient comclient = new CommonServiceClient();
            NursingStationClient nurclient = new NursingStationClient();
            BL_OTBookingRequest NSBOOKREQ = new BL_OTBookingRequest();
            string[] formats = { "hh:mm:ss tt", "hh:mm tt", "h:mm tt", "h:mm:ss tt" };
            NSBOOKREQ.SurgeryDate = GeneralFunction.GetDateInSpecifiedFormat(SurgeryDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            NSBOOKREQ.SurgeryTime = "";
            NSBOOKREQ.Priority = strPriority;
            NSBOOKREQ.PatientType = "I";
            NSBOOKREQ.OTCathType = OTCathType;
            NSBOOKREQ.IpNo = ("" + Ipno).Trim();
            NSBOOKREQ.MRNo = ("" + Mrno).Trim();
            NSBOOKREQ.NursCode = "";
            NSBOOKREQ.WardNo = "";
            NSBOOKREQ.BedNo = BedWardNo;
            NSBOOKREQ.CasualtyNo = "";
            NSBOOKREQ.Remarks = "" + Remarks;
            NSBOOKREQ.UserID = Convert.ToString(System.Web.HttpContext.Current.Session["gOncoUserId"]);
            NSBOOKREQ.ModuleID = Convert.ToString(System.Web.HttpContext.Current.Session["ModuleIDGlobal"]);
            NSBOOKREQ.IpAddress = Convert.ToString(System.Web.HttpContext.Current.Session["MchIPAddress"]);
            NSBOOKREQ.Tranmode = 1;
            NSBOOKREQ.TranNo = "" + ReqNo;
            NSBOOKREQ.Side = "" + ReqNo;
            NSBOOKREQ.SurgeryAdvOther = "" + SurgeryRemarks;
            if (string.IsNullOrEmpty(GridData))
            {
                return "Please Select Surgery";
            }
            DataTable GridDt = Newtonsoft.Json.JsonConvert.DeserializeObject<DataTable>(GridData ?? "[]");
            DataSet ORDERDET = new DataSet("SURGERY");
            DataTable TestGrid = new DataTable("LIST");
            TestGrid.Columns.Add("SURGCODE");
            TestGrid.Columns.Add("DOCTCODE");
            TestGrid.Columns.Add("SIDE");
            TestGrid.Columns.Add("REMARK");
            foreach (DataRow dr in GridDt.Rows)
            {
                DataRow drNew = TestGrid.NewRow();
                drNew["SURGCODE"] = dr["CODE"];
                drNew["DOCTCODE"] = System.Web.HttpContext.Current.Session["gDoctCode"].ToString();
                drNew["SIDE"] = dr["SIDE"];
                drNew["REMARK"] = dr["REMARK"];
                TestGrid.Rows.Add(drNew);
            }
            ORDERDET.Tables.Add(TestGrid);
            string Testlistxml = ORDERDET.GetXml();
            NSBOOKREQ.XMLSurgList = Testlistxml;
            NSBOOKREQ.Diagnosis = "" + Diagnosis;
            if (NSBOOKREQ.NursCode == comclient.GetSetupValue("CASUALTYNS"))
            {
                if (NSBOOKREQ.MRNo.Trim() == "")
                    NSBOOKREQ.MRNo = "" + NSBOOKREQ.IpNo.ToUpper().Trim();
                NSBOOKREQ.CasualtyNo = "" + "";
                NSBOOKREQ.PatientType = "C";
            }
            NSBOOKREQ.SchemeCodes = SchemeCodes; //priyanka 04/05/2026
            var Status = nurclient.OTBookingRequestTran(NSBOOKREQ);
            return Status[0].message;
        }
        public object getOTCathOrderBookList(string DTFrm, string DTto, string ReqNo, string OTCath, string IPNO, string smrno, string SNURSESTN, string status, string sType, string PatName, string ORDERTYPE, string strCrdtCompCode, string Speciality) //priyanka 05/05/2026
        {
            NursingStationClient nurclient = new NursingStationClient();
            CommonServiceClient common = new CommonServiceClient();
            DataSet GetRRVdt = new DataSet();
            string strGetRRV = nurclient.GetOTBookRequestList(DTFrm, DTto, ReqNo, OTCath, IPNO, smrno, SNURSESTN, status, ORDERTYPE, PatName);
            StringReader theReader = new StringReader(strGetRRV);
            GetRRVdt.ReadXml(theReader);
            var NurStn = common.GetNursStnList();
            var WardNm = common.GetWardLst();
            string schemeListXml = common.GetSchemeSpecialityCompanyWise(strCrdtCompCode, Speciality);
            DataSet schemeListDs = new DataSet();
            using (StringReader reader = new StringReader(schemeListXml))
            {
                schemeListDs.ReadXml(reader);
            }
            var schemeList = schemeListDs.Tables[0].AsEnumerable()
                            .Select(r => new
                            {
                                Value = r["SCHEMECD"].ToString().Trim(),
                                Text = r["SCHEMENM"].ToString().Trim()
                            })
                            .ToList();
            if (GetRRVdt.Tables.Count > 0)
            {
                var jsonResult = (from DataRow row in GetRRVdt.Tables[0].Rows
                                  select new
                                  {
                                      act = "",
                                      REQNO = row["REQNO"].ToString().Trim(),
                                      REQDATETIME = GeneralFunction.GetDate(row["REQDATE"].ToString()) + " " + GeneralFunction.ConvertTimeTo24Hour(row["REQTIME"].ToString()), // Abhishesh || 20260323
                                      MRNO = row["MRNO"].ToString().Trim(),
                                      IPNO = row["IPNO"].ToString().Trim(),
                                      PATIENTNAME = row["PATNAME"].ToString().Trim(),
                                      WARD = WardNm.FirstOrDefault(x => x.Value == row["WARDNO"].ToString().Trim()) != null
                                       ? WardNm.FirstOrDefault(x => x.Value == row["WARDNO"].ToString().Trim()).Text
                                       : "",
                                      BEDNO = row["BEDNUMBER"].ToString().Trim(),
                                      NURST = NurStn.FirstOrDefault(x => x.Value == row["NURSTCODE"].ToString().Trim()) != null
                                           ? NurStn.FirstOrDefault(x => x.Value == row["NURSTCODE"].ToString().Trim()).Text
                                           : "",
                                      SURGDTTM = GeneralFunction.GetDate(row["SURGDATE"].ToString().Trim()) + " " + GeneralFunction.ConvertTimeTo24Hour(row["SURGTIME"].ToString()),  // Abhishesh || 20260323
                                      SURGERY = row["Surgery"].ToString().Trim(),
                                      PRIORITY = row["PRIORITY"].ToString().Trim() == "R" ? "Elective" : row["PRIORITY"].ToString().Trim() == "E" ? "Emergency" : row["PRIORITY"].ToString().Trim(), //priyanka 05/05/2026
                                      PATTYPE = row["PATTYPE"].ToString().Trim(),
                                      OTCATHTYPE = row["OTCATHTYPE"].ToString().Trim() == "O" ? "Operation Theater" : row["OTCATHTYPE"].ToString().Trim() == "C" ? "Cath Lab" : "", //priyanka 05/05/2026
                                      REMARKS = row["REMARKS"].ToString().Trim(),
                                      OTBOOKINGNO = row["OTBOOKINGNO"].ToString().Trim(),
                                      CASUALNO = row["CASUALNO"].ToString().Trim(),
                                      STATUS = row["STATUS"].ToString().Trim() == "P" ? "Pending" :
                                               (row["STATUS"].ToString().Trim() == "A" ? "Completed" : "Cancelled"),
                                      SCHEMES = string.Join(", ",
                                                row["SCHEMECODES"].ToString()
                                                .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                                                .Select(code => schemeList
                                                    .FirstOrDefault(x => x.Value == code.Trim())?.Text)
                                                .Where(name => !string.IsNullOrEmpty(name))
                                             ),
                                      SURGERYCODES = row["SurgeryCodes"].ToString().Trim(),
                                      STATUSCODE = row["STATUS"].ToString().Trim(),
                                      SURGADVICEOTHER = ("" + row["SURGADVICEOTHER"].ToString().Trim())
                                  }).ToList();
                return jsonResult;
            }
            else
            {
                return "0";
            }
        }
        public string GetSurgryMaster(string a)
        {
            DataSet load = new DataSet();
            JavaScriptSerializer ser = new JavaScriptSerializer();
            OTClient OTserRef = new OTClient();
            CommonServiceClient comm = new CommonServiceClient();
            string DeptCode = comm.GetSetupValue("OTDEPARTMENT");
            var SurgDispLst = comm.GetSurgDispLst();
            var SurgLevelLst = comm.GetSurgLevelLst();
            load.ReadXml(new XmlTextReader(new StringReader(OTserRef.GetSurgMstList(DeptCode))));

            if (load.Tables.Count > 0)
            {
                var jsonData = (from DataRow row in load.Tables[0].Rows
                                select new
                                {
                                    SURGERY_CODE = row["SURGERY_CODE"].ToString().Trim(),
                                    SURGERY_DESC = row["SURGERY_DESC"].ToString().Trim(),
                                    STRDISIPLINCD = ("" + row["DISIPLINCD"].ToString().Trim()) == "" ? "" :
                                    SurgDispLst.Where(x => x.Value == row["DISIPLINCD"].ToString().Trim()).Count() == 0 ? "" :
                                    SurgDispLst.Where(x => x.Value == row["DISIPLINCD"].ToString().Trim()).First().Text,
                                    DISIPLINCD = row["DISIPLINCD"].ToString().Trim(),
                                }).ToList();
                return ser.Serialize(jsonData);
            }
            else
            {
                return ser.Serialize("");
            }
        }
        public string GetSurgeryCatg()
        {
            DataSet load = new DataSet();
            CommonServiceClient comm = new CommonServiceClient();
            JavaScriptSerializer ser = new JavaScriptSerializer();
            load.ReadXml(new XmlTextReader(new StringReader(comm.Get2or3FldMstData("DISP", "OT", ""))));

            if (load.Tables.Count > 0)
            {
                var jsonData = (from DataRow row in load.Tables[0].Rows
                                select new
                                {
                                    Value = row["CODE"].ToString().Trim(),
                                    Text = row["NAME"].ToString().Trim(),
                                }).ToList();
                return ser.Serialize(jsonData);
            }
            return ser.Serialize(new List<object>());
        }
    }
    #endregion

    #region TreatmentOrder
    public class TreatmentOrder : BL_TreatmentSheet
    {
        CommonServiceClient comser = new CommonServiceClient();
        public List<SelectListItem> MedicineTypeList { get; set; }
        public List<SelectListItem> MedicineRouteList { get; set; }
        public List<SelectListItem> TractionNumlist { get; set; }
        public List<SelectListItem> DilutionVolumeList { get; set; }
        public List<SelectListItem> AdministrationDurList { get; set; }
        public List<SelectListItem> BloodProductList { get; set; }

        public IEnumerable<OncologyEMR.CommonSerRef.UserLstItem> AuthUserIdList { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.UserLstItem> RemarkAuthUserIdList { get; set; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> ClinicList { set; get; }

        public List<SelectListItem> DVTProphylaxisList { get; set; }
        public string DVTProphylaxis { get; set; }

        public string Unit { get; set; }
        public List<SelectListItem> UnitList { get; set; }

        public List<SelectListItem> NutritionList { get; set; }

        public string VolSupplmnt { get; set; }

        public string AuthUserId { get; set; }

        public string Passwords { get; set; }
        public string PlanTranNo { get; set; }
        public string CIMS { get; set; }

        public IEnumerable<OncologyEMR.CommonSerRef.DoctorSelLstItem> DoctorList { set; get; }
        public string SearchDoctorSelected { get; set; }
        public string ChemoTemplate { get; set; }
        public List<SelectListItem> ChemoTemplateLst { get; set; }
        public string JsonChemoDet { get; set; }

        public bool chkchemo { get; set; }

        public object GetTransactionList(string IpNo, string strdate)
        {
            string SFrmDate = string.Empty;
            if ((string.IsNullOrEmpty(strdate)))
            {
                SFrmDate = GeneralFunction.GetDateInSpecifiedFormat(comser.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            }
            else
            {
                SFrmDate = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(strdate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            }
            IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> GetTransactionList;

            GetTransactionList = comser.GetTreatmntSheetTranLst(IpNo, SFrmDate);

            SelectList TransLst = new SelectList((from a in GetTransactionList
                                                  select new
                                                  {
                                                      Value = a.Value,
                                                      Text = a.Text,
                                                  }).ToList(), "Value", "Text");
            return TransLst;
        }
        public void FillCombo(TreatmentOrder ts)
        {
            CommonServiceClient comserv = new CommonServiceClient();

            ts.AuthUserIdList = comserv.GetUserList().Where(x => x.ICUAuthYN == "Y");

            ts.RemarkAuthUserIdList = comserv.GetUserList().Where(x => x.DoctCode != "" && x.STATUS == "A").ToArray();
            ts.DVTProphylaxisList = GeneralFunction.GetDVTProphylaxisList();
            ts.UnitList = GeneralFunction.GetUnitList();
            ts.NutritionList = comserv.GetDietCatgList().Select(x => new SelectListItem { Value = x.Value, Text = x.Text }).ToList();
            ts.DoctorList = comserv.GetDoctLst();
        }

        public IEnumerable<OncologyEMR.CommonSerRef.DoctorSelLstItem> GetDoctorInfo()
        {
            return comser.GetDoctLst().Where(x => x.Status == "A").ToArray();
        }

        public IEnumerable<OncologyEMR.CommonSerRef.InfusionDrugLstItem> GetInfusionList()
        {
            return comser.ICUInfusionLst().Where(x => x.Status == "A").ToArray();
        }

        public object getDrugList(string DrugName, string Type, string strChecmoMedYN, string IPNO)
        {
            try
            {

                DataSet load = new DataSet();
                TreatmentSheet objTreatSheet = new TreatmentSheet();
                CommonServiceClient comser = new CommonServiceClient();
                ICUClient icuser = new ICUClient();
                load.ReadXml(new XmlTextReader(new StringReader(icuser.GetEMRDrugListByName(DrugName, Type, strChecmoMedYN, IPNO))));
                if (load.Tables.Contains("Table") && load.Tables["Table"].Rows.Count > 0)
                {
                    DataTable FilterTable = load.Tables["Table"];

                    var jsonData = new
                    {
                        rows = (from DataRow row in FilterTable.Rows
                                select new
                                {
                                    CODE = ("" + row["MTRLCODE"]).Trim(),
                                    NAME = ("" + row["MTRLNAME"]).Trim(),
                                    GENERICID = ("" + row["GENERICID"]).Trim(),
                                    GENERICNAM = ("" + row["GENERICNAM"]).Trim(),
                                    HIGHALERT = ("" + row["HIGHALERT"]).Trim(),
                                    MTRLBRAND = ("" + row["MTRLBRAND"]).Trim(),
                                    QOH = ("" + row["QOH"]).Trim(),
                                    PRELOADDOSE = ("" + row["LOADDOSE"]).Trim(),
                                    MAINCEDOSE = ("" + row["MAINTDOSE"]).Trim(),
                                    FREQUENCY = ("" + row["FREQ"]).Trim(),
                                    DILUTION = ("" + row["DILUTION"]).Trim(),
                                    ANTIBIOYN = ("" + row["ANTIBIOYN"]).Trim(),
                                    MTRLFORMCODE = ("" + row["MTRLFORMCODE"]).Trim(),//priyanka 27/04/2026
                                    MTRLFORM = ("" + row["MTRLFORM"]).Trim(),
                                    GENMTRLFORM = ("" + row["GENMTRLFORM"]).Trim(),
                                    GENMTRLFORMCODE = ("" + row["GENMTRLFORMCODE"]).Trim()//END
                                }).ToArray()
                    };
                    //Changes By Abhishesh || 20260731
                    string strGenericWiseYN = OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN");
                    if (strGenericWiseYN == "Y")
                    {
                        var filteredRows = jsonData.rows.GroupBy(r => r.GENERICID).Select(g => g.First()).ToArray();

                        return new { rows = filteredRows };
                    }
                    //End
                    return jsonData;
                }
                else
                {
                    var jsonData = "";
                    return jsonData;
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
                load.ReadXml(new XmlTextReader(new StringReader(comser.GetTestListByName(TestName))));

                if (load.Tables["Table"] != null && load.Tables["Table"].Rows.Count > 0)
                {
                    DataTable FilterTable = load.Tables["Table"];

                    var jsonData = new
                    {
                        rows = (from DataRow row in FilterTable.Rows
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
                    var jsonData = "";
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
            MedicineRouteList = GeneralFunction.Medicine_MedicineRoute();

            SelectList LstService = new SelectList((from a in MedicineRouteList
                                                    select new
                                                    {
                                                        Value = a.Value,
                                                        Text = a.Text,
                                                    }).ToList(), "Value", "Text");
            return LstService;
        }
        public object GetDilutionVolumeList()
        {

            DataTable table = new DataTable();
            DataTable dt = new DataTable();
            DilutionVolumeList = GeneralFunction.Medicine_DilutionVolume();

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
            AdministrationDurList = GeneralFunction.Medicine_AdministrationDuration();

            SelectList LstService = new SelectList((from a in AdministrationDurList
                                                    select new
                                                    {
                                                        Value = a.Value,
                                                        Text = a.Text,
                                                    }).ToList(), "Value", "Text");
            return LstService;
        }

        public object GetSpecilizationList()
        {
            IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> GetSpecilizationlistList;
            GetSpecilizationlistList = comser.GetSpecilstnList();
            SelectList splist = new SelectList((from a in GetSpecilizationlistList
                                                select new
                                                {
                                                    Value = a.Value,
                                                    Text = a.Text,
                                                }).ToList(), "Value", "Text");
            return splist;
        }
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
        public object SaveTreatmentSheetData(TreatmentOrder TS, string action, string tableMedicationData, string tableNebulizationData, string tableSTATOrdFilterData, string tableSpeciaInstructionsData,
                    string tableBloodProductData, string tableInfusionData, string tableInvestigationData, string tableReferralsFilterData, string tableAntibioticData, string tableMeicationStatOrderData,
                    string IpNo, string MrNo, string PatName, string TranctionId, string TypData, string DrVerified, string tableChemoAntiData, string tableChemoAMediData, string tableNutriIntake)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            DataSet DrugDataset = new DataSet("Drug");
            DataTable Drugs = new DataTable("DrugList");
            ICUClient icuclnt = new ICUClient();
            DataTable MedicationData = JsonConvert.DeserializeObject<DataTable>(tableMedicationData);
            DataTable Antibiotic = JsonConvert.DeserializeObject<DataTable>(tableAntibioticData);
            DataTable Nebulization = JsonConvert.DeserializeObject<DataTable>(tableNebulizationData);
            DataTable STATOrder = JsonConvert.DeserializeObject<DataTable>(tableSTATOrdFilterData);
            DataTable STATOrderMedication = JsonConvert.DeserializeObject<DataTable>(tableMeicationStatOrderData);
            DataTable SpeciaInstructions = JsonConvert.DeserializeObject<DataTable>(tableSpeciaInstructionsData);
            DataTable BloodProductData = JsonConvert.DeserializeObject<DataTable>(tableBloodProductData);
            DataTable Infusion = JsonConvert.DeserializeObject<DataTable>(tableInfusionData);
            DataTable Investigation = JsonConvert.DeserializeObject<DataTable>(tableInvestigationData);
            DataTable Referrals = JsonConvert.DeserializeObject<DataTable>(tableReferralsFilterData);
            DataTable ChemoAnti = JsonConvert.DeserializeObject<DataTable>(tableChemoAntiData);
            DataTable ChemoMedication = JsonConvert.DeserializeObject<DataTable>(tableChemoAMediData);

            DataTable JsonChecmoDet = JsonConvert.DeserializeObject<DataTable>(TS.JsonChemoDet);
            DataTable NutriData = JsonConvert.DeserializeObject<DataTable>(tableNutriIntake);

            Nebulization.Reset();

            if (MedicationData.Rows.Count > 0 && MedicationData.Columns.Contains("action"))
            {
                MedicationData.Columns.Remove("action");
                MedicationData.Columns.Add("DISPSEQNO");
                MedicationData.Columns["MediDGSTARTDATE"].ColumnName = "DGSTARTDATE";

            }
            if (MedicationData.Columns.Contains("Medicine"))
            {
                MedicationData.Columns.Remove("Medicine");
            }

            if (Antibiotic.Rows.Count > 0 && Antibiotic.Columns.Contains("action"))
            {
                Antibiotic.Columns.Remove("Action");
                Antibiotic.Columns["AntiBoDGSTARTDATE"].ColumnName = "DGSTARTDATE";
                Antibiotic.Columns.Add("DISPSEQNO");
            }

            //changes done on 03/07/2025
            if (ChemoMedication.Rows.Count > 0 && ChemoMedication.Columns.Contains("action"))
            {
                ChemoMedication.Columns.Remove("action");
                ChemoMedication.Columns.Add("DISPSEQNO");
                ChemoMedication.Columns["MediDGSTARTDATE"].ColumnName = "DGSTARTDATE";
            }

            if (ChemoAnti.Rows.Count > 0 && ChemoAnti.Columns.Contains("SETNO") || ChemoAnti.Columns.Contains("action"))
            {

                if (ChemoAnti.Columns.Contains("action"))
                    ChemoAnti.Columns.Remove("action");


                if (ChemoAnti.Columns.Contains("AntiBoDGSTARTDATE"))
                    ChemoAnti.Columns["AntiBoDGSTARTDATE"].ColumnName = "DGSTARTDATE";

                if (!ChemoAnti.Columns.Contains("DISPSEQNO"))
                    ChemoAnti.Columns.Add("DISPSEQNO");
                var setNumbers = ChemoAnti.AsEnumerable()
                                          .Select(r => r["SETNO"].ToString())
                                          .Distinct();

                foreach (var setNo in setNumbers)
                {
                    var rowsInSet = ChemoAnti.AsEnumerable()
                                             .Where(r => r["SETNO"].ToString() == setNo)
                                             .ToList();

                    var firstOmitted = rowsInSet.FirstOrDefault(r => r["OMIT"].ToString() == "Y");
                    if (firstOmitted != null)
                    {
                        var omittedBy = firstOmitted.Table.Columns.Contains("OmittedBy") ? firstOmitted["OmittedBy"] : null;
                        var omittedDate = firstOmitted.Table.Columns.Contains("OmittedDate") ? firstOmitted["OmittedDate"] : null;
                        var omittedTime = firstOmitted.Table.Columns.Contains("OmittedTime") ? firstOmitted["OmittedTime"] : null;

                        foreach (var row in rowsInSet)
                        {
                            row["OMIT"] = "Y";

                            if (omittedBy != null) row["OmittedBy"] = omittedBy;
                            if (omittedDate != null) row["OmittedDate"] = omittedDate;
                            if (omittedTime != null) row["OmittedTime"] = omittedTime;
                        }
                    }
                }

            }


            if (Nebulization.Rows.Count > 0 && Nebulization.Columns.Contains("action"))
            {
                Nebulization.Columns.Remove("action");
                Nebulization.Columns["DilutionDGSTARTDATE"].ColumnName = "DGSTARTDATE";
                Nebulization.Columns.Add("DISPSEQNO");
            }

            if (STATOrder.Rows.Count > 0 && STATOrder.Columns.Contains("action"))
            {
                STATOrder.Columns.Remove("action");
                STATOrder.Columns["STATDGSTARTDATE"].ColumnName = "DGSTARTDATE";
                STATOrder.Columns.Add("DISPSEQNO");
            }

            if (STATOrderMedication.Rows.Count > 0 && STATOrderMedication.Columns.Contains("action"))
            {
                STATOrderMedication.Columns.Remove("action");
                STATOrderMedication.Columns["STATMediDGSTARTDATE"].ColumnName = "DGSTARTDATE";
                STATOrderMedication.Columns.Add("DISPSEQNO");
            }

            if (SpeciaInstructions.Rows.Count > 0 || SpeciaInstructions.Columns.Contains("action"))
            {
                if (SpeciaInstructions.Columns.Contains("action"))
                {
                    SpeciaInstructions.Columns.Remove("action");
                }
                if (SpeciaInstructions.Columns.Contains("Diluent"))
                {
                    foreach (DataRow row in SpeciaInstructions.Rows)
                    {
                        string rawValue = row["Diluent"]?.ToString() ?? "";

                        if (!string.IsNullOrEmpty(rawValue) && !int.TryParse(rawValue, out _))
                        {

                            row["Diluent"] = string.Empty;
                        }
                    }
                }
                SpeciaInstructions.Columns["SpiDGSTARTDATE"].ColumnName = "DGSTARTDATE";
                SpeciaInstructions.Columns.Add("DISPSEQNO");
                if (SpeciaInstructions.Columns.Contains("DiluentGenericCode"))
                {
                    SpeciaInstructions.Columns.Remove("DiluentGenericCode");
                }

                if (SpeciaInstructions.Columns.Contains("DOCNAME"))
                {
                    SpeciaInstructions.Columns.Remove("DOCNAME");
                }


                // SpeciaInstructions.Columns.Add("IsRollOver");

            }

            if (BloodProductData.Rows.Count > 0 || BloodProductData.Columns.Contains("action"))
            {
                if (BloodProductData.Columns.Contains("action"))
                {

                    BloodProductData.Columns.Remove("action");

                }
                if (BloodProductData.Columns.Contains("Diluent"))
                {
                    foreach (DataRow row in BloodProductData.Rows)
                    {
                        string rawValue = row["Diluent"]?.ToString() ?? "";
                        if (!string.IsNullOrEmpty(rawValue) && !int.TryParse(rawValue, out _))
                        {
                            row["Diluent"] = DBNull.Value;
                        }
                    }
                }
                //BloodProductData.Columns.Remove("AdministerSeq");
                BloodProductData.Columns["BPSTARTDATE"].ColumnName = "DGSTARTDATE";
                BloodProductData.Columns.Add("DISPSEQNO");
            }


            if (Infusion.Rows.Count > 0 || Infusion.Columns.Contains("action"))
            {
                //Infusion.Columns.Remove("action");
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

            //if (Investigation.Rows.Count > 0 && Investigation.Columns.Contains("action"))
            if (Investigation.Rows.Count > 0 && Investigation.Columns.Contains("action"))
            {
                Investigation.Columns.Remove("action");

                if (Investigation.Columns.Contains("OrderDate"))
                {
                    for (int i = 0; i < Investigation.Rows.Count; i++)
                    {
                        if ((Investigation.Rows[i]["OrderDate"].ToString() != "") || Investigation.Rows[i]["OrderDate"].ToString() == "")
                        {
                            Investigation.Rows[i]["OrderDate"] = GeneralFunction.GetDateInSpecifiedFormat(Investigation.Rows[i]["OrderDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                            Investigation.Rows[i]["ProposedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Investigation.Rows[i]["ProposedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }
                        if (Investigation.Rows[i]["OmittedDate"].ToString() != "")
                        {
                            Investigation.Rows[i]["OmittedDate"] = GeneralFunction.GetDateInSpecifiedFormat(Investigation.Rows[i]["OmittedDate"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }
                    }
                }
            }
            if (Referrals.Rows.Count > 0 || Referrals.Columns.Contains("action"))
            {
                if (Referrals.Columns.Contains("action"))
                {
                    Referrals.Columns.Remove("action");
                }

            }

            /*----------------------------------------Merge all Drugrelated Table to DrugList table--------------------------------------------*/

            Drugs.Merge(MedicationData);
            Drugs.Merge(Nebulization);
            Drugs.Merge(STATOrder);

            Drugs.Merge(Antibiotic);
            Drugs.Merge(STATOrderMedication);
            Drugs.Merge(ChemoAnti);
            Drugs.Merge(ChemoMedication);

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

            Drugs.Merge(BloodProductData);
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

            DataSet Infu = new DataSet("DATA");
            Infusion.TableName = "INFUSION";
            if (Infusion != null && Infusion.Rows.Count > 0)
            {
                Infu.Tables.Add(Infusion);
            }

            DataSet Investi = new DataSet("DATA");
            Investigation.TableName = "TEST";

            if (Investigation != null && Investigation.Rows.Count > 0)
            {
                Investi.Tables.Add(Investigation);
            }

            DataSet referral = new DataSet("DATA");
            Referrals.TableName = "DOCTOR";
            if (Referrals != null && Referrals.Rows.Count > 0)
            {
                for (int r = 0; r < Referrals.Rows.Count; r++)
                {
                    Referrals.Rows[r]["CancelDT"] = GeneralFunction.GetDateInSpecifiedFormat(Referrals.Rows[r]["CancelDT"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                referral.Tables.Add(Referrals);
            }
            //NutriData
            NutriData.TableName = "NUTRISUP";
            if (NutriData != null && NutriData.Rows.Count > 0)
            {
                for (int r = 0; r < NutriData.Rows.Count; r++)
                {
                    NutriData.Rows[r]["CREATEDBY"] = HttpContext.Current.Session["gOncoUserId"].ToString().Trim();
                    NutriData.Rows[r]["CREATEDON"] = GeneralFunction.GetDateInSpecifiedFormat(NutriData.Rows[r]["CREATEDON"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }
                Investi.Tables.Add(NutriData);
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
                        if (Drugs.Rows[i]["ENDDATE"].ToString() != string.Empty)
                        {
                            Drugs.Rows[i]["ENDDATE"] = GeneralFunction.GetDateInSpecifiedFormat(Drugs.Rows[i]["ENDDATE"].ToString(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                        }

                        Drugs.Rows[i]["DISPSEQNO"] = i;

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
                                Drugs.Rows[i]["MICROSET"] = 0;
                            }
                        }
                    }
                }
            }
            ObjBL_TreatmentSheet.Remarks = string.Format("{0}", TS.Remarks);
            ObjBL_TreatmentSheet.NDOthers = string.Format("{0}", TS.NDOthers);
            ObjBL_TreatmentSheet.IPNo = string.Format("{0}", IpNo);
            ObjBL_TreatmentSheet.MRNo = string.Format("{0}", MrNo);
            ObjBL_TreatmentSheet.DocRemarks = string.Format("{0}", TS.DocRemarks);
            ObjBL_TreatmentSheet.PatName = string.Format("{0}", TS.PatName);
            ObjBL_TreatmentSheet.VolSuplmnt = string.Format("{0}", TS.VolSupplmnt);     //vishal 16th Jan 2018
            ObjBL_TreatmentSheet.TreatmntSheetTranDt = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(TS.TreatmntSheetTranDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            ObjBL_TreatmentSheet.TreatmntSheetTranTm = string.Format("{0}", TS.TreatmntSheetTranTm);
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            ObjBL_TreatmentSheet.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            ObjBL_TreatmentSheet.IpAdress = Convert.ToString(HttpContext.Current.Session["MchIPAddress"]);
            ObjBL_TreatmentSheet.ProvDiagno = string.Format("{0}", TS.ProvDiagno);
            ObjBL_TreatmentSheet.Allergies = string.Format("{0}", TS.Allergies);
            ObjBL_TreatmentSheet.Weight = string.Format("{0}", TS.Weight);
            ObjBL_TreatmentSheet.Height = string.Format("{0}", TS.Height);
            ObjBL_TreatmentSheet.BSA = string.Format("{0}", TS.BSA);
            ObjBL_TreatmentSheet.VerifiedByDr = DrVerified;
            bool hasChemoTypeCode = false;

            if (Drugs != null && Drugs.Columns.Contains("TypeCode"))
            {
                hasChemoTypeCode = Drugs.AsEnumerable()
                                        .Any(r => r["TypeCode"] != DBNull.Value &&
                                                  r["TypeCode"].ToString().Trim().Equals("CO", StringComparison.OrdinalIgnoreCase));
            }
            bool isChemoDetailEmpty = (
            (JsonChecmoDet.Rows[0]["TotCycleNo"] == DBNull.Value ||
             string.IsNullOrWhiteSpace(JsonChecmoDet.Rows[0]["TotCycleNo"].ToString()) ||
             JsonChecmoDet.Rows[0]["TotCycleNo"].ToString() == "0")
            &&
            (JsonChecmoDet.Rows[0]["CycleNo"] == DBNull.Value ||
             string.IsNullOrWhiteSpace(JsonChecmoDet.Rows[0]["CycleNo"].ToString()) ||
             JsonChecmoDet.Rows[0]["CycleNo"].ToString() == "0")
            &&
            (JsonChecmoDet.Rows[0]["DayofCycle"] == DBNull.Value ||
             string.IsNullOrWhiteSpace(JsonChecmoDet.Rows[0]["DayofCycle"].ToString()) ||
             JsonChecmoDet.Rows[0]["DayofCycle"].ToString() == "0")
            );

            if ((ChemoAnti == null || ChemoAnti.Rows.Count == 0) && isChemoDetailEmpty && !hasChemoTypeCode)
            {
                var cycleNoValue = JsonChecmoDet.Rows[0]["TotCycleNo"];
                int result = 0;
                if (cycleNoValue != DBNull.Value && !string.IsNullOrWhiteSpace(cycleNoValue.ToString()))
                {
                    int.TryParse(cycleNoValue.ToString(), out result);
                }
                ObjBL_TreatmentSheet.TotCycleNo = result.ToString();
                var cycleno = JsonChecmoDet.Rows[0]["CycleNo"];

                int result1 = 0;
                if (cycleno != DBNull.Value && !string.IsNullOrWhiteSpace(cycleno.ToString()))
                {
                    int.TryParse(cycleno.ToString(), out result1);
                }
                ObjBL_TreatmentSheet.CycleNo = result1.ToString();
                var dayofcycle = JsonChecmoDet.Rows[0]["DayofCycle"];
                int result2 = 0;
                if (dayofcycle != DBNull.Value && !string.IsNullOrWhiteSpace(dayofcycle.ToString()))
                {
                    int.TryParse(dayofcycle.ToString(), out result2);
                }
                ObjBL_TreatmentSheet.DayofCycle = result2.ToString();

                ObjBL_TreatmentSheet.PlanID = "";
                ObjBL_TreatmentSheet.PlanDate = "";
                ObjBL_TreatmentSheet.ProtocolData = "";
                ObjBL_TreatmentSheet.ProtocolID = "";
                ObjBL_TreatmentSheet.ProtocolType = "";
                ObjBL_TreatmentSheet.ChemoCourseName = "";
                ObjBL_TreatmentSheet.ChemoStartDate = "";

            }
            else
            {
                var cycleNoValue = JsonChecmoDet.Rows[0]["TotCycleNo"];
                int result = 0;
                if (cycleNoValue != DBNull.Value && !string.IsNullOrWhiteSpace(cycleNoValue.ToString()))
                {
                    int.TryParse(cycleNoValue.ToString(), out result);
                }
                ObjBL_TreatmentSheet.TotCycleNo = result.ToString();

                var cycleno = JsonChecmoDet.Rows[0]["CycleNo"];

                int result1 = 0;
                if (cycleno != DBNull.Value && !string.IsNullOrWhiteSpace(cycleno.ToString()))
                {
                    int.TryParse(cycleno.ToString(), out result1);
                }
                ObjBL_TreatmentSheet.CycleNo = result1.ToString();

                var dayofcycle = JsonChecmoDet.Rows[0]["DayofCycle"];
                int result2 = 0;
                if (dayofcycle != DBNull.Value && !string.IsNullOrWhiteSpace(dayofcycle.ToString()))
                {
                    int.TryParse(dayofcycle.ToString(), out result2);
                }
                ObjBL_TreatmentSheet.DayofCycle = result2.ToString();


                ObjBL_TreatmentSheet.PlanID = JsonChecmoDet.Rows[0]["PlanID"].ToString();
                string uiDate = JsonChecmoDet.Rows[0]["PlanDate"].ToString();

                uiDate = GeneralFunction.GetDateInSpecifiedFormat(uiDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                ObjBL_TreatmentSheet.PlanDate = uiDate;
                ObjBL_TreatmentSheet.ProtocolData = JsonChecmoDet.Rows[0]["ProtocolData"].ToString();
                ObjBL_TreatmentSheet.ProtocolID = JsonChecmoDet.Rows[0]["ProtocolID"].ToString();
                ObjBL_TreatmentSheet.ProtocolType = JsonChecmoDet.Rows[0]["ProtocolType"].ToString();
                ObjBL_TreatmentSheet.ChemoCourseName = JsonChecmoDet.Rows[0]["COURSENM"].ToString();
                string startChemoDate = JsonChecmoDet.Rows[0]["STARTDATE"].ToString();
                startChemoDate = GeneralFunction.GetDateInSpecifiedFormat(startChemoDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                ObjBL_TreatmentSheet.ChemoStartDate = startChemoDate;
            }
            if (DrugDataset.Tables["DrugList"] != null)
            {
                if (DrugDataset.Tables["DrugList"].Rows.Count > 0)
                {
                    DrugDataset.Tables["DrugList"].Columns["OMIT"].ColumnName = "Omit";
                }
            }

            if (Infu.Tables["INFUSION"] != null)
            {
                if (Infu.Tables["INFUSION"].Rows.Count > 0)
                {
                    Infu.Tables["INFUSION"].Columns["OMIT"].ColumnName = "Omit";
                }
            }


            ObjBL_TreatmentSheet.TreatmentSheetData = DrugDataset.GetXml();
            ObjBL_TreatmentSheet.TreatmentInfusionData = Infu.GetXml();
            ObjBL_TreatmentSheet.TreatmentTestData = Investi.GetXml();
            ObjBL_TreatmentSheet.TreatmentDoctData = referral.GetXml();
            if (action == GeneralFunction.modes.NewMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 1;
            }
            else if (action == GeneralFunction.modes.EditMode.ToString().Substring(0, 1))
            {
                ObjBL_TreatmentSheet.Tranmode = 2;
                ObjBL_TreatmentSheet.TranNo = TranctionId;
            }
            ObjBL_TreatmentSheet.TypeOfData = TypData;

            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }


        public object VrifyTransactionData(string TranctionId)
        {
            BL_TreatmentSheet ObjBL_TreatmentSheet = new BL_TreatmentSheet();
            ICUClient icuclnt = new ICUClient();

            ObjBL_TreatmentSheet.Tranmode = 3;
            ObjBL_TreatmentSheet.TranNo = TranctionId;
            ObjBL_TreatmentSheet.userID = HttpContext.Current.Session["UserID"].ToString();
            ObjBL_TreatmentSheet.IpAdress = Convert.ToString(HttpContext.Current.Session["MchIPAddress"]);
            string TreatmentSheetResult = icuclnt.TreatmentSheetTran(ObjBL_TreatmentSheet);
            return TreatmentSheetResult;
        }

        public DataSet PrintTreatmentSheetData(string PatientData, string trano, string date, string time, string ProvDiag, string Allerg, string Antibiotics,
           string Medication, string Infusion, string Remarks, string STATOrders, string STATOrdersOnMedication, string IVFluids, string BloodProduct,
           string VitalPedalPulse, string HGT, string OxygenAdmin, string DeepBreathing, string Spirometry, string ChestPT, string SteamInhalation,
           string DVTProxy, string ChangeOfPos, string MobileAmbul, string AbdominalGirth, string RTAspiration, string Others, string Investigation,
           string Referrals, string DocRemarks, string NutriIntake, string VolSuplement, string VerifiedBy, string ChemoVolDil, string ChemoMedication, string DVT)
        {
            DataTable HData = new DataTable();
            AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            DataTable df = new DataTable();
            DataTable dtAntibiotics = new DataTable();
            DataTable dtMedication = new DataTable();
            DataTable dtInfusion = new DataTable();
            DataTable dtSTATOrders = new DataTable();
            DataTable dtSTATOrdersOnMedication = new DataTable();
            DataTable dtIVFluids = new DataTable();
            DataTable dtBloodProduct = new DataTable();
            DataTable dtInvestigation = new DataTable();
            DataTable dtReferrals = new DataTable();
            DataTable dtNonDrugOrders = new DataTable();
            DataTable dtChemoVolDil = new DataTable();
            DataTable dtChemoMedication = new DataTable();

            DataTable dtOthers = new DataTable();
            DataTable ds = new DataTable();
            DataTable du = new DataTable();
            DataTable search = new DataTable();
            DataSet AllData = new DataSet();
            DataTable user = new DataTable();
            df = JsonConvert.DeserializeObject<DataTable>(PatientData);
            dtAntibiotics = JsonConvert.DeserializeObject<DataTable>(Antibiotics);
            dtMedication = JsonConvert.DeserializeObject<DataTable>(Medication);
            dtInfusion = JsonConvert.DeserializeObject<DataTable>(Infusion);
            dtSTATOrders = JsonConvert.DeserializeObject<DataTable>(STATOrders);
            dtSTATOrdersOnMedication = JsonConvert.DeserializeObject<DataTable>(STATOrdersOnMedication);
            dtIVFluids = JsonConvert.DeserializeObject<DataTable>(IVFluids);
            dtBloodProduct = JsonConvert.DeserializeObject<DataTable>(BloodProduct);
            dtInvestigation = JsonConvert.DeserializeObject<DataTable>(Investigation);
            dtReferrals = JsonConvert.DeserializeObject<DataTable>(Referrals);
            dtChemoVolDil = JsonConvert.DeserializeObject<DataTable>(ChemoVolDil);
            dtChemoMedication = JsonConvert.DeserializeObject<DataTable>(ChemoMedication);

            DataTable patdt = new DataTable(); // GeneralFunction.CreateDataTablefroFormDatas("PatInfo1", df);

            dtAntibiotics = FilterRowsByStatus(dtAntibiotics);
            dtMedication = FilterRowsByStatus(dtMedication);
            dtInfusion = FilterRowsByStatus(dtInfusion);
            dtSTATOrders = FilterRowsByStatus(dtSTATOrders);
            dtSTATOrdersOnMedication = FilterRowsByStatus(dtSTATOrdersOnMedication);
            dtIVFluids = FilterRowsByStatus(dtIVFluids);
            dtBloodProduct = FilterRowsByStatus(dtBloodProduct);
            dtInvestigation = FilterRowsByStatus(dtInvestigation);
            dtReferrals = FilterRowsByStatus(dtReferrals);
            dtChemoVolDil = FilterRowsByStatus(dtChemoVolDil);
            dtChemoMedication = FilterRowsByStatus(dtChemoMedication);

            dtAntibiotics.TableName = "AntibioticsT";
            dtMedication.TableName = "MedicationT";
            dtInfusion.TableName = "InfusionT";
            dtSTATOrders.TableName = "STATOrdersT";
            dtSTATOrdersOnMedication.TableName = "STATOrdersOnMedicationT";
            dtIVFluids.TableName = "IVFluidsT";
            dtBloodProduct.TableName = "BloodProductT";
            dtInvestigation.TableName = "InvestigationT";
            dtReferrals.TableName = "ReferralsT";
            dtChemoVolDil.TableName = "ChemoVolDilT";
            dtChemoMedication.TableName = "ChemoMedicationT";

            if (dtAntibiotics.Columns.Contains("action"))
            {
                dtAntibiotics.Columns.Remove("action");
            }
            if (dtMedication.Columns.Contains("action"))
            {
                dtMedication.Columns.Remove("action");
            }
            if (dtChemoVolDil.Columns.Contains("action"))
            {
                dtChemoVolDil.Columns.Remove("action");
            }
            if (dtChemoMedication.Columns.Contains("action"))
            {
                dtChemoMedication.Columns.Remove("action");
            }
            if (dtInfusion.Columns.Contains("action"))
            {
                dtInfusion.Columns.Remove("action");
            }
            if (dtSTATOrders.Columns.Contains("action"))
            {
                dtSTATOrders.Columns.Remove("action");
            }
            if (dtSTATOrdersOnMedication.Columns.Contains("action"))
            {
                dtSTATOrdersOnMedication.Columns.Remove("action");
            }
            if (dtIVFluids.Columns.Contains("action"))
            {
                dtIVFluids.Columns.Remove("action");
            }
            if (dtBloodProduct.Columns.Contains("action"))
            {
                dtBloodProduct.Columns.Remove("action");
            }
            if (dtInvestigation.Columns.Contains("action"))
            {
                dtInvestigation.Columns.Remove("action");
            }
            if (dtReferrals.Columns.Contains("action"))
            {
                dtReferrals.Columns.Remove("action");
            }
            dtNonDrugOrders.TableName = "NonDrugOrdersT";
            dtNonDrugOrders.Columns.Add("VitalPedalPulse");
            dtNonDrugOrders.Columns.Add("HGT");
            dtNonDrugOrders.Columns.Add("DVTPROPHYLDET");
            dtNonDrugOrders.Columns.Add("OxygenAdmin");
            dtNonDrugOrders.Columns.Add("DeepBreathing");
            dtNonDrugOrders.Columns.Add("Spirometry");
            dtNonDrugOrders.Columns.Add("ChestPT");
            dtNonDrugOrders.Columns.Add("SteamInhalation");
            dtNonDrugOrders.Columns.Add("DVTProxy");
            dtNonDrugOrders.Columns.Add("ChangeOfPos");
            dtNonDrugOrders.Columns.Add("MobileAmbul");
            dtNonDrugOrders.Columns.Add("AbdominalGirth");
            dtNonDrugOrders.Columns.Add("RTAspiration");
            dtNonDrugOrders.Columns.Add("Others");
            DataRow drs = dtNonDrugOrders.NewRow();
            drs["VitalPedalPulse"] = VitalPedalPulse;
            drs["HGT"] = HGT;
            drs["DVTPROPHYLDET"] = DVT;
            drs["OxygenAdmin"] = OxygenAdmin;
            drs["DeepBreathing"] = DeepBreathing;
            drs["Spirometry"] = Spirometry;
            drs["ChestPT"] = ChestPT;
            drs["SteamInhalation"] = SteamInhalation;
            drs["DVTProxy"] = DVTProxy;
            drs["ChangeOfPos"] = ChangeOfPos;
            drs["MobileAmbul"] = MobileAmbul;
            drs["AbdominalGirth"] = AbdominalGirth;
            drs["RTAspiration"] = RTAspiration;
            drs["Others"] = Others;
            dtNonDrugOrders.Rows.Add(drs);

            dtOthers.TableName = "OthersT";
            dtOthers.Columns.Add("ProvDiag");
            dtOthers.Columns.Add("Allerg");
            dtOthers.Columns.Add("Remarks");
            dtOthers.Columns.Add("DocRemarks");
            dtOthers.Columns.Add("NutriIntake");
            dtOthers.Columns.Add("TreatSheetDt");
            dtOthers.Columns.Add("TreatSheetTm");
            dtOthers.Columns.Add("TranNo"); dtOthers.Columns.Add("VolSuplmnt");
            dtOthers.Columns.Add("VerifiedBy");

            CommonServiceClient ComServ = new CommonServiceClient();
            var DOCTLIST = ComServ.GetDoctLst();
            DataRow drss = dtOthers.NewRow();
            drss["ProvDiag"] = ProvDiag;
            drss["Allerg"] = Allerg;
            drss["Remarks"] = Remarks;
            drss["DocRemarks"] = DocRemarks;
            drss["NutriIntake"] = NutriIntake;
            drss["TreatSheetDt"] = date;
            drss["TreatSheetTm"] = time;
            drss["TranNo"] = trano;
            drss["VolSuplmnt"] = VolSuplement;
            drss["VerifiedBy"] = DOCTLIST.Where(x => x.Value == ("" + VerifiedBy).Trim()).Count() == 0 ? "" : DOCTLIST.Where(x => x.Value == ("" + VerifiedBy).ToString().Trim()).First().Text;
            dtOthers.Rows.Add(drss);

            CommonServiceClient comserv = new CommonServiceClient();
            GeneralFunction gf = new GeneralFunction();
            HData = GeneralFunction.getHeaderFooter("Treatment Orders", "", "", "");

            if (HData.Rows.Count > 0 && HData.Columns.Contains("PrintDateTime"))
            {
                HData.Rows[0]["PrintDateTime"] =
                    GeneralFunction.ConvertDateWithTimeTo12Hour(HData.Rows[0]["PrintDateTime"].ToString());
            }

            HData.TableName = "HeaderFooter";
            if (dtAntibiotics.Rows.Count == 0)
            {
                dtAntibiotics.Columns.Add("DayOfDrug");
                dtAntibiotics.Columns.Add("Type");
                dtAntibiotics.Columns.Add("DrugName");
                dtAntibiotics.Columns.Add("Dose");
                dtAntibiotics.Columns.Add("Route");
                dtAntibiotics.Columns.Add("Freq");
                dtAntibiotics.Columns.Add("Remark");
                dtAntibiotics.Columns.Add("DilutionVolume");
                dtAntibiotics.Columns.Add("AdminstrDuration");
                dtAntibiotics.Columns.Add("AntiBoDGSTARTDATE");

                dtAntibiotics.Columns.Add("Omit");
                dtAntibiotics.Columns.Add("DrugCode");
                dtAntibiotics.Columns.Add("TypeCode");
                dtAntibiotics.Columns.Add("OmittedBy");

                dtAntibiotics.Columns.Add("OmittedDate");
                dtAntibiotics.Columns.Add("OmittedTime");
                dtAntibiotics.Columns.Add("SQNumber");
                dtAntibiotics.Columns.Add("HighAlert");
                dtAntibiotics.Columns.Add("Duration");
                dtAntibiotics.Columns.Add("Diluent");
            }
            // Step 1: Ensure all columns from dtChemoVolDil exist in dtAntibiotics
            foreach (DataColumn col in dtChemoVolDil.Columns)
            {
                if (!dtAntibiotics.Columns.Contains(col.ColumnName))
                {
                    dtAntibiotics.Columns.Add(col.ColumnName, col.DataType);
                }
            }

            // Step 2: Import rows from dtChemoVolDil to dtAntibiotics
            foreach (DataRow row in dtChemoVolDil.Rows)
            {
                dtAntibiotics.ImportRow(row);
            }

            if (dtMedication.Rows.Count == 0)
            {
                dtMedication.Columns.Add("DayOfDrug");
                dtMedication.Columns.Add("Type");
                dtMedication.Columns.Add("DrugName");
                dtMedication.Columns.Add("Dose");
                dtMedication.Columns.Add("Route");
                dtMedication.Columns.Add("Freq");
                dtMedication.Columns.Add("Remark");
                dtMedication.Columns.Add("DilutionVolume");
                dtMedication.Columns.Add("AdminstrDuration");
                dtMedication.Columns.Add("MediDGSTARTDATE");

                dtMedication.Columns.Add("Omit");
                dtMedication.Columns.Add("DrugCode");
                dtMedication.Columns.Add("TypeCode");
                dtMedication.Columns.Add("OmittedBy");

                dtMedication.Columns.Add("OmittedDate");
                dtMedication.Columns.Add("OmittedTime");
                dtMedication.Columns.Add("SQNumber");
                dtMedication.Columns.Add("HighAlert");
                dtMedication.Columns.Add("Duration");
                dtMedication.Columns.Add("Diluent");

            }
            if (dtChemoVolDil.Rows.Count == 0)
            {
                dtChemoVolDil.Columns.Add("DayOfDrug");
                dtChemoVolDil.Columns.Add("Type");
                dtChemoVolDil.Columns.Add("DrugName");
                dtChemoVolDil.Columns.Add("Dose");
                dtChemoVolDil.Columns.Add("Route");
                dtChemoVolDil.Columns.Add("Freq");
                dtChemoVolDil.Columns.Add("Remark");
                dtChemoVolDil.Columns.Add("DilutionVolume");
                dtChemoVolDil.Columns.Add("AdminstrDuration");
                dtChemoVolDil.Columns.Add("AntiBoDGSTARTDATE");

                dtChemoVolDil.Columns.Add("Omit");
                dtChemoVolDil.Columns.Add("DrugCode");
                dtChemoVolDil.Columns.Add("TypeCode");
                dtChemoVolDil.Columns.Add("OmittedBy");

                dtChemoVolDil.Columns.Add("OmittedDate");
                dtChemoVolDil.Columns.Add("OmittedTime");
                dtChemoVolDil.Columns.Add("SQNumber");
                dtChemoVolDil.Columns.Add("HighAlert");
                dtChemoVolDil.Columns.Add("Duration");
                dtChemoVolDil.Columns.Add("Diluent");
            }
            foreach (DataColumn col in dtChemoMedication.Columns)
            {
                if (!dtMedication.Columns.Contains(col.ColumnName))
                {
                    dtMedication.Columns.Add(col.ColumnName, col.DataType);
                }
            }

            // Step 2: Import rows from dtChemoVolDil to dtAntibiotics
            foreach (DataRow row in dtChemoMedication.Rows)
            {
                dtMedication.ImportRow(row);
            }

            if (dtChemoMedication.Rows.Count == 0)
            {
                dtChemoMedication.Columns.Add("DayOfDrug");
                dtChemoMedication.Columns.Add("Type");
                dtChemoMedication.Columns.Add("DrugName");
                dtChemoMedication.Columns.Add("Dose");
                dtChemoMedication.Columns.Add("Route");
                dtChemoMedication.Columns.Add("Freq");
                dtChemoMedication.Columns.Add("Remark");
                dtChemoMedication.Columns.Add("DilutionVolume");
                dtChemoMedication.Columns.Add("AdminstrDuration");
                dtChemoMedication.Columns.Add("MediDGSTARTDATE");

                dtChemoMedication.Columns.Add("Omit");
                dtChemoMedication.Columns.Add("DrugCode");
                dtChemoMedication.Columns.Add("TypeCode");
                dtChemoMedication.Columns.Add("OmittedBy");

                dtChemoMedication.Columns.Add("OmittedDate");
                dtChemoMedication.Columns.Add("OmittedTime");
                dtChemoMedication.Columns.Add("SQNumber");
                dtChemoMedication.Columns.Add("HighAlert");
                dtChemoMedication.Columns.Add("Duration");
                dtChemoMedication.Columns.Add("Diluent");

            }
            if (dtInfusion.Rows.Count == 0)
            {
                dtInfusion.Columns.Add("Infusion");
                dtInfusion.Columns.Add("Dose");               ///ADDED BY VISHAL AS ON 22ND sEPT 2018
                dtInfusion.Columns.Add("InfusionRate");
                dtInfusion.Columns.Add("HighAlert");
                dtInfusion.Columns.Add("StartTime");
                dtInfusion.Columns.Add("EndTime");
                dtInfusion.Columns.Add("TypeCode");
                dtInfusion.Columns.Add("OrderedBy");
                dtInfusion.Columns.Add("OrderedDate");
                dtInfusion.Columns.Add("OrderedTime");
                dtInfusion.Columns.Add("SQNumber");
                dtInfusion.Columns.Add("Remark");
                dtInfusion.Columns.Add("Omit");
                dtInfusion.Columns.Add("OmmittedBy");
                dtInfusion.Columns.Add("OmittedDate");
                dtInfusion.Columns.Add("OmittedTime");
            }
            if (dtSTATOrders.Rows.Count == 0)
            {
                dtSTATOrders.Columns.Add("DayOfDrug");
                dtSTATOrders.Columns.Add("Type");
                dtSTATOrders.Columns.Add("DrugName");
                dtSTATOrders.Columns.Add("Dose");
                dtSTATOrders.Columns.Add("Route");
                dtSTATOrders.Columns.Add("Freq");
                dtSTATOrders.Columns.Add("Remark");
                dtSTATOrders.Columns.Add("DilutionVolume");
                dtSTATOrders.Columns.Add("AdminstrDuration");
                dtSTATOrders.Columns.Add("STATDGSTARTDATE");

                dtSTATOrders.Columns.Add("Omit");
                dtSTATOrders.Columns.Add("DrugCode");
                dtSTATOrders.Columns.Add("TypeCode");
                dtSTATOrders.Columns.Add("OmittedBy");

                dtSTATOrders.Columns.Add("OmittedDate");
                dtSTATOrders.Columns.Add("OmittedTime");
                dtSTATOrders.Columns.Add("SQNumber");
                dtSTATOrders.Columns.Add("HighAlert");
                dtSTATOrders.Columns.Add("Duration");
                dtSTATOrders.Columns.Add("Diluent");

            }
            if (dtSTATOrdersOnMedication.Rows.Count == 0)
            {
                dtSTATOrdersOnMedication.Columns.Add("DayOfDrug");
                dtSTATOrdersOnMedication.Columns.Add("Type");
                dtSTATOrdersOnMedication.Columns.Add("DrugName");
                dtSTATOrdersOnMedication.Columns.Add("Dose");
                dtSTATOrdersOnMedication.Columns.Add("Route");
                dtSTATOrdersOnMedication.Columns.Add("Freq");
                dtSTATOrdersOnMedication.Columns.Add("Remark");
                dtSTATOrdersOnMedication.Columns.Add("DilutionVolume");
                dtSTATOrdersOnMedication.Columns.Add("AdminstrDuration");
                dtSTATOrdersOnMedication.Columns.Add("STATMediDGSTARTDATE");

                dtSTATOrdersOnMedication.Columns.Add("Omit");
                dtSTATOrdersOnMedication.Columns.Add("DrugCode");
                dtSTATOrdersOnMedication.Columns.Add("TypeCode");
                dtSTATOrdersOnMedication.Columns.Add("OmittedBy");

                dtSTATOrdersOnMedication.Columns.Add("OmittedDate");
                dtSTATOrdersOnMedication.Columns.Add("OmittedTime");
                dtSTATOrdersOnMedication.Columns.Add("SQNumber");
                dtSTATOrdersOnMedication.Columns.Add("HighAlert");
                dtSTATOrdersOnMedication.Columns.Add("Duration");
                dtSTATOrdersOnMedication.Columns.Add("Diluent");
            }
            if (dtIVFluids.Rows.Count == 0)
            {
                dtIVFluids.Columns.Add("DayOfDrug");
                dtIVFluids.Columns.Add("Type");
                dtIVFluids.Columns.Add("DrugName");
                dtIVFluids.Columns.Add("Dose");
                dtIVFluids.Columns.Add("Route");
                dtIVFluids.Columns.Add("Freq");
                dtIVFluids.Columns.Add("Remark");
                dtIVFluids.Columns.Add("DilutionVolume");
                dtIVFluids.Columns.Add("AdminstrDuration");
                dtIVFluids.Columns.Add("SpiDGSTARTDATE");

                dtIVFluids.Columns.Add("Omit");
                dtIVFluids.Columns.Add("DrugCode");
                dtIVFluids.Columns.Add("TypeCode");
                dtIVFluids.Columns.Add("OmittedBy");

                dtIVFluids.Columns.Add("OmittedDate");
                dtIVFluids.Columns.Add("OmittedTime");
                dtIVFluids.Columns.Add("SQNumber");
                dtIVFluids.Columns.Add("HighAlert");

                dtIVFluids.Columns.Add("MACROSET");                        ///ADDED BY VISHAL AS ON 22ND sEPT 2018
                dtIVFluids.Columns.Add("MICROSET");
                dtIVFluids.Columns.Add("INFRATE");
            }
            if (dtBloodProduct.Rows.Count == 0)
            {
                dtBloodProduct.Columns.Add("DayOfDrug");
                dtBloodProduct.Columns.Add("Type");
                dtBloodProduct.Columns.Add("DrugName");
                dtBloodProduct.Columns.Add("Dose");
                dtBloodProduct.Columns.Add("Route");
                dtBloodProduct.Columns.Add("Freq");
                dtBloodProduct.Columns.Add("Remark");
                dtBloodProduct.Columns.Add("DilutionVolume");
                dtBloodProduct.Columns.Add("AdminstrDuration");
                dtBloodProduct.Columns.Add("BPSTARTDATE");

                dtBloodProduct.Columns.Add("Omit");
                dtBloodProduct.Columns.Add("DrugCode");
                dtBloodProduct.Columns.Add("TypeCode");
                dtBloodProduct.Columns.Add("OmittedBy");

                dtBloodProduct.Columns.Add("OmittedDate");
                dtBloodProduct.Columns.Add("OmittedTime");
                dtBloodProduct.Columns.Add("SQNumber");
                dtBloodProduct.Columns.Add("HighAlert");

                dtBloodProduct.Columns.Add("INFRATE");           ///ADDED BY VISHAL AS ON 22ND sEPT 2018
                dtBloodProduct.Columns.Add("MACROSET");
            }
            if (dtInvestigation.Rows.Count == 0)
            {
                dtInvestigation.Columns.Add("Test");
                dtInvestigation.Columns.Add("OrderDate");
                dtInvestigation.Columns.Add("OrderTime");
                dtInvestigation.Columns.Add("TestCode");
                dtInvestigation.Columns.Add("TypeCode");
                dtInvestigation.Columns.Add("OrderedBy");
                dtInvestigation.Columns.Add("SQNumber");
                dtInvestigation.Columns.Add("Remark");
            }
            if (dtReferrals.Rows.Count == 0)
            {
                dtReferrals.Columns.Add("Doctor");
                dtReferrals.Columns.Add("SpecilizationName");
                dtReferrals.Columns.Add("ReferralType");
                dtReferrals.Columns.Add("DoctorCode");
                dtReferrals.Columns.Add("ReferralTypeCode");
                dtReferrals.Columns.Add("TypeCode");
                dtReferrals.Columns.Add("SQNumber");
            }
            AllData.Tables.Add(patdt);
            AllData.Tables.Add(dtAntibiotics);
            AllData.Tables.Add(dtMedication);
            AllData.Tables.Add(dtChemoVolDil);
            AllData.Tables.Add(dtChemoMedication);
            AllData.Tables.Add(dtInfusion);
            AllData.Tables.Add(dtSTATOrders);
            AllData.Tables.Add(dtSTATOrdersOnMedication);
            AllData.Tables.Add(dtIVFluids);
            AllData.Tables.Add(dtBloodProduct);
            AllData.Tables.Add(dtInvestigation);
            AllData.Tables.Add(dtReferrals);
            AllData.Tables.Add(dtNonDrugOrders);
            AllData.Tables.Add(dtOthers);
            AllData.Tables.Add(HData);
            return AllData;

        }

        //Added by Aaryshree 20250811
        private DataTable FilterRowsByStatus(DataTable table)
        {
            if (table != null && table.Columns.Contains("Status"))
            {
                var filteredRows = table.AsEnumerable()
                                        .Where(row => row["Status"].ToString() != "C")
                                        .CopyToDataTable();

                return filteredRows;
            }

            return table;
        }

        public object RetriveTSNotifDetails(string strTranDate)
        {
            //object jsonData = string.Empty;
            DataSet load = new DataSet();
            ICUClient icuclnt = new ICUClient();
            string TranFormatedDate = string.Empty;
            string NScode = HttpContext.Current.Session["NSCODE"].ToString();
            if (strTranDate != string.Empty)
            {
                TranFormatedDate = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(strTranDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            }
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetTSNotifDetails(TranFormatedDate, NScode))));
            if (load != null && load.Tables.Count > 0)
            {
                bool IsPlanfrmRights = false;
                if (load.Tables.Contains("Table"))
                {
                    load.Tables["Table"].TableName = "CountDetailsData";
                }
                if (HttpContext.Current.Session["IsPlanfrmRight"].ToString().Trim() == string.Empty)
                {
                    formrights frmRights = new formrights();
                    // IsPlanfrmRights = ""; // frmRights.FormRightsCheck("PLANNING", "");
                    HttpContext.Current.Session["IsPlanfrmRight"] = true;
                }
                else
                {
                    IsPlanfrmRights = Convert.ToBoolean(HttpContext.Current.Session["IsPlanfrmRight"].ToString().Trim());
                }
                DataColumn DC = new DataColumn("IsFormRights", typeof(bool));
                DC.DefaultValue = IsPlanfrmRights;
                load.Tables[0].Columns.Add(DC);
                string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                return jsonData;
            }
            else
            {
                return "Unsucessfull";
            }
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
        public object UpdateNotificationTS(string TranctionId)
        {
            ICUClient icuclnt = new ICUClient();
            // string TreatmentSheetResult = "";
            string TreatmentSheetResult = icuclnt.GetUpdateTSNotif(TranctionId);
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
            if (ds.Tables.Contains("CaseDetails"))
            {
                dt1 = ds.Tables["CaseDetails"];
                if (dt1.Rows.Count > 0)
                {
                    JsonCaseDetailData = (from DataRow row in dt1.AsEnumerable()
                                          select new
                                          {
                                              PROVDIAGNO = row["PROVDIAG"].ToString().Trim(),

                                          }).ToArray();
                }
            }
            if (ds.Tables.Contains("TblAllergies"))
            {
                dt2 = ds.Tables["Allergy"];
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

        public object GetLatestAllergies(string IPNo)
        {
            Dictionary<string, object> dict = new Dictionary<string, object>();
            DataTable dt2 = new DataTable();

            DataSet ds = GetCaseDetails(IPNo);

            if (ds.Tables.Contains("LATESTALLERGY"))
            {
                dt2 = ds.Tables["LATESTALLERGY"]; // ✅ FIXED

                if (dt2.Rows.Count > 0)
                {
                    var JsonAllergiesData = (from DataRow row in dt2.AsEnumerable()
                                             let durationRaw = ("" + row["DURATION"]).Trim()
                                             let splitdur = durationRaw.Split('|')
                                             let durationValue = splitdur.Length > 0 ? splitdur[0] : ""
                                             let durationCode = splitdur.Length > 1 ? splitdur[1] : ""
                                             let duratonText =
                                                 durationCode == "D" ? "Days" :
                                                 durationCode == "W" ? "Weeks" :
                                                 durationCode == "M" ? "Months" :
                                                 durationCode == "Y" ? "Years" : ""
                                             select new
                                             {
                                                 ALLERGYCODE = row["ALLERGYDESC"].ToString().Trim(),
                                                 ALLERGYDESC = row["ALLERGYDESC"].ToString().Trim(),
                                                 DURATION = (durationValue + " " + duratonText).Trim(),
                                                 ALLRGTYPE = row["ALLRGTYPE"].ToString().Trim(),
                                                 REMARK = row["REMARK"].ToString(),
                                             }).ToArray();

                    dict.Add("JsonAllergiesData", JsonAllergiesData);
                }
                else
                {
                    dict.Add("JsonAllergiesData", new object[0]); // empty array
                }
            }
            else
            {
                dict.Add("JsonAllergiesData", new object[0]);
            }

            return dict;
        }

        public object UpdateCancellation(string TRANNO, string SEQNO, string TBLTYPE, string CANTIME)
        {
            ICUClient icuclnt = new ICUClient();
            CommonServiceClient comserv = new CommonServiceClient();
            string CANDate = "" + GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            string TreatmentSheetResult = icuclnt.CancelTSTran(TRANNO, SEQNO, TBLTYPE, userID, CANDate, CANTIME);
            return TreatmentSheetResult;
        }

        //Added By Aaryshree on 20250906
        public object UpdateHoldUnhold(string TRANNO, string SEQNO, string TBLTYPE, string strHoldYN, string strHoldReason, string strDrugCode, string strDrugName, string strSetNo)
        {
            ICUClient icuclnt = new ICUClient();
            CommonServiceClient comserv = new CommonServiceClient();
            string CANDate = "" + GeneralFunction.GetDateInSpecifiedFormat(comserv.GetServerDate(), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            //string userID = "" + HttpContext.Current.Session["UserID"].ToString();
            string userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            string TreatmentSheetResult = icuclnt.HoldynTSTran(TRANNO, SEQNO, TBLTYPE, userID, strHoldYN, strHoldReason, strDrugCode, strDrugName, strSetNo);
            return TreatmentSheetResult;
        }

        public object GetHoldLog(string TRANNO, string SEQNO, string TBLTYPE, string strDrugCode)
        {
            ICUClient icuclnt = new ICUClient();
            CommonServiceClient comserv = new CommonServiceClient();
            List<UserLstItem> userLst = comserv.GetUserList().ToList();

            DataSet dsgetLogInfo = new DataSet();
            string Treatment = icuclnt.GetHoldLogs(TRANNO, SEQNO, TBLTYPE, strDrugCode);

            if (!string.IsNullOrEmpty(Treatment))
            {
                dsgetLogInfo.ReadXml(new XmlTextReader(new StringReader(Treatment)));
            }

            if (dsgetLogInfo.Tables.Count > 0 && dsgetLogInfo.Tables[0].Rows.Count > 0)
            {
                var jsonData = new
                {
                    rows = (from DataRow row in dsgetLogInfo.Tables[0].Rows
                            select new
                            {
                                HOLDYN = row["HOLDYN"].ToString(),
                                TRANDATE = row["TRANDATE"].ToString(),
                                TRANTIME = row["TRANTIME"].ToString(),
                                DRUGCD = row["DRUGCD"].ToString(),
                                DRUGNAME = row["DRUGNAME"].ToString(),
                                REASON = row["REASON"].ToString(),
                                USERID = !string.IsNullOrEmpty(row["USERID"].ToString().Trim())
                                    ? GeneralFunction.GetListValue(userLst, row["USERID"].ToString().Trim()) + " (" + row["USERID"].ToString().Trim() + ")"
                                    : ""
                            })
                };
                return jsonData;
            }
            else
            {

                return new
                {
                    rows = new object[] { },
                    message = "No log data found"
                };
            }
        }

        public string SaveNewDrug(string MEDICINENM, string GENERICNM, string BRANDNM)
        {
            CommonServiceClient comser = new CommonServiceClient();

            string strResult = "";
            try
            {

                //  strResult = OEMRCli.SaveRemarksAddItem("", strRemark, HttpContext.Current.Session["ClinicCode"].ToString(), "A", HttpContext.Current.Session["gOncoUserId"].ToString(), 1);
                return strResult;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("uk_intake"))
                {
                    strResult = "This Drug is allready exist.";
                    return strResult;
                }
                else
                {
                    return ex.Message;
                }
            }
        }

        public string SavePanelDataMdl(string Medications, string Dilutions, string tranNo)
        {
            BL_TreatmentSheet bltreat = new BL_TreatmentSheet();
            object jsondata = "";
            DataTable dtmed = new DataTable();
            DataTable dtdilu = new DataTable();
            dtmed = JsonConvert.DeserializeObject<DataTable>(Medications);
            dtdilu = JsonConvert.DeserializeObject<DataTable>(Dilutions);

            DataSet ds = new DataSet("Dataset");

            dtmed.Merge(dtdilu);
            ds.Tables.Add(dtmed);
            dtmed.TableName = "Medications";
            string xml = ds.GetXml();

            bltreat.TreatmentSheetData = xml.ToString();
            bltreat.TranNo = tranNo;
            bltreat.userID = HttpContext.Current.Session["UserID"].ToString();
            bltreat.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            bltreat.IpAdress = Convert.ToString(HttpContext.Current.Session["MchIPAddress"]);

            //return jsondata;
            ICUClient icuclnt = new ICUClient();
            string result = icuclnt.UpdateMedType(bltreat);
            return result;
        }

        public object BindChemoData(string strPrtocolCD, string MRNO, string height, string weight, string BSA, string DayNo, bool calcDose, string CycleNo)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ICUClient icuclnt = new ICUClient();
            CommonServiceClient comser = new CommonServiceClient();

            double parsedHeight = 0, parsedWeight = 0, parsedBSA = 0;
            double.TryParse(height, out parsedHeight);
            double.TryParse(weight, out parsedWeight);
            double.TryParse(BSA, out parsedBSA);

            // ds.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetChemoProtoMedictns(strPrtocolCD, MRNO, DayNo, CycleNo))));
            var xml = icuclnt.GetChemoProtoMedictns(strPrtocolCD, MRNO, DayNo, CycleNo);

            if (string.IsNullOrWhiteSpace(xml))
            {
                return new { DilutionY = new object[0] };
            }

            ds.ReadXml(new XmlTextReader(new StringReader(xml)));


            if (ds.Tables.Count > 0 && ds.Tables.Contains("Table"))
            {
                CommonServiceClient cm = new CommonServiceClient();
                dt = ds.Tables["Table"];
                //  DataTable treatmentHeadTable = ds.Tables["TreatmentHead"];
                DataTable treatmentHeadTable = ds.Tables.Contains("TreatmentHead") ? ds.Tables["TreatmentHead"] : null;
                var medRoutLst = GeneralFunction.MedicineRouteForChemo().ToList();
                var DOCTLIST = cm.GetDoctLst();
                // Filter records where DILUTIONYN == "Y"
                //var dilutionYes = dt.AsEnumerable().Where(row => ("" + row["DILUTIONYN"]).Trim().ToUpper() == "N")
                var dilutionYes = dt.AsEnumerable()
                                   .Select((row, index) => new
                                   {
                                       DrugCode = ("" + row["MTRLCODE"]).Trim(),
                                       DrugName = ("" + row["MTRLNAME"]).Trim(),
                                       SetNo = ("" + row["MEDSETNO"]).Trim(),
                                       Dose = calcDose ? ((("" + row["CALCULATEON"]).Trim().ToUpper() == "B" && parsedBSA > 0) ?
                                                         (parsedBSA * Convert.ToDouble(("" + row["DOSE"]).Trim())).ToString("0.##") :
                                                         (("" + row["CALCULATEON"]).Trim().ToUpper() == "W" && parsedWeight > 0) ?
                                                         (parsedWeight * Convert.ToDouble(("" + row["DOSE"]).Trim())).ToString("0.##") :
                                                         (("" + row["CALCULATEON"]).Trim().ToUpper() == "H" && parsedHeight > 0) ?
                                                         (parsedHeight * Convert.ToDouble(("" + row["DOSE"]).Trim())).ToString("0.##") :
                                                         ("" + row["DOSE"]).Trim()) + " " + ("" + row["DOSEUNIT"]).Trim()
                                                          : ("" + row["DOSE"]).Trim() + " " + ("" + row["DOSEUNIT"]).Trim(),
                                       // Route = (string.Empty + row["ROUTECD"]).Trim() != "" ? medRoutLst.Where(n => n.Value == ("" + row["ROUTECD"]).Trim()).FirstOrDefault().Text : "",
                                       //Route = (string.Empty + row["ROUTECD"]).Trim() != "" ? medRoutLst.Where(n => n.Value == ("" + row["ROUTECD"]).Trim()).FirstOrDefault().Text : "",
                                       Route = (string.Empty + row["ROUTECD"]).Trim() != "" ?
                                       (GeneralFunction.GetListValue(medRoutLst, ("" + row["ROUTECD"]).ToString().Trim()) == "" ? (string.Empty + row["ROUTECD"]).Trim() : GeneralFunction.GetListValue(medRoutLst, ("" + row["ROUTECD"]).ToString().Trim()))
                                       : ("" + row["ROUTECD"]).Trim(),
                                       Freq = ("" + row["FREQUENCY"]).Trim(),
                                       Diluent = ("" + row["DILUENT"]).Trim(),
                                       DilutionVolume = ("" + row["VOLDILTN"]).Trim(),
                                       Duration = 1,
                                       AdminstrDuration = ("" + row["DURATION"]).Trim(),
                                       AdministerSeq = ("" + row["ADMINSEQNO"]).Trim(),
                                       DiluentGenericCode = ("" + row["DILNTGENCD"]).Trim(),
                                       Remark = ("" + row["REMARKS"]).Trim(),
                                       //DayOfDrug = ("" + row["APLYTODAY"]).Trim(),
                                       DayOfDrug = ("" + row["ONDAY"]).Trim(),
                                       TypeCode = "CO",
                                       //OrderedBy = HttpContext.Current.Session["UserID"].ToString(),
                                       OrderedBy = HttpContext.Current.Session["gOncoUserId"].ToString().Trim() ?? "",
                                       AntiBoDGSTARTDATE = comser.GetServerDate(), // DateTime.Now.ToString("dd/MM/yyyy"),
                                       ENDDATE = comser.GetServerDate(),
                                       OrderedDate = comser.GetServerDate(),
                                       OrderedTime = DateTime.Now.ToString("hh:mm tt"),
                                       NOTIFYN = "N",
                                       STATUS = "A",
                                       ADMINYN = "N",
                                       MEDSTAT = "C",
                                       MEDTYPE = ("" + row["MEDTYPE"]).Trim(),
                                       Type = ("" + row["DRUGFORM"]).Trim(),
                                       ORGDOSE = ("" + row["DOSE"]).Trim() + " " + ("" + row["DOSEUNIT"]).Trim(),
                                       CALCULATEON = ("" + row["CALCULATEON"]).Trim(),
                                       HighAlert = ("" + row["HIGHALERT"]).Trim(),
                                       PRESCRIBEBY = ("" + row["PRESCRIBEBY"]).Trim(),
                                       DOCNAME = GeneralFunction.GetListValue(DOCTLIST, row["PRESCRIBEBY"].ToString().Trim()),
                                       ISSUEYN = "N",
                                       INDENTYN = "N",
                                       MtrFormCode = ("" + row["DRUGFORM"]).Trim(),
                                       RoutCode = ("" + row["ROUTECD"]).Trim(),
                                       APLYTODAY = dt.Columns.Contains("APLYTODAY") ? ("" + row["APLYTODAY"]).Trim() : "",
                                       CycleNo = CycleNo,
                                       SQNumber = index
                                   }).ToArray();
                return new
                {
                    DilutionY = dilutionYes,
                    //DilutionN = dilutionNo
                };
            }
            // Return empty arrays if no data found
            return new
            {
                DilutionY = new object[0],
                DilutionN = new object[0]

            };
        }
        public object GetProtocolCode(string MRNO)
        {

            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable dt1 = new DataTable();
            ICUClient ic = new ICUClient();
            object jsonData = string.Empty;
            try
            {
                string xmlData = ic.GetChemoProtocolByMRNO(MRNO);

                if (!string.IsNullOrWhiteSpace(xmlData))
                {
                    ds.ReadXml(new XmlTextReader(new StringReader(xmlData)));
                    if (ds.Tables.Count > 0)
                    {
                        if (ds.Tables.Contains("Table1"))
                        {
                            dt = ds.Tables["Table1"];
                            jsonData = new
                            {
                                rows = (from DataRow row in dt.Rows
                                        select new
                                        {
                                            CODE = ("" + row["CHEMOTHERAPYNM"]).Trim(),
                                            PROTONAME = ("" + row["PROTONAME"]).Trim(),
                                            //PROTOCOL = ("" + row["PROTOCOL"]).Trim(),
                                            // PROTOCOL = ("" + row["PROTOCOL"]).Trim() + ("" + row["MODIFICATION"]).Trim(),
                                            PROTOCOL = ("" + row["PROTOCOL"]).Trim(),
                                            //+ (!string.IsNullOrWhiteSpace("" + row["MODIFICATION"])
                                            //? Environment.NewLine + "--------------------------------------------" 
                                            ////+ Environment.NewLine + "Modification During Treatment:" 
                                            //+ Environment.NewLine + ("" + row["MODIFICATION"]).Trim()
                                            //: ""),

                                            MODIFICATION = ("" + row["MODIFICATION"]).Trim(),
                                            TotalCycle = ("" + row["TOTALCYCLE"]).Trim(),
                                            CycleNo = ("" + row["CYCLENO"]).Trim(),
                                            PlanID = ("" + row["PLANID"]).Trim(),
                                            PlanDate = ("" + row["PLANDATE"]).Trim(),
                                            STATUS = ("" + row["STATUS"]).Trim(),
                                            DURATION = ("" + row["DURATION"]).Trim(),
                                            HOURORDAY = ("" + row["HOURORDAY"]).Trim(),
                                            STARTDATE = ("" + row["STARTDATE"]).Trim(),
                                            //ENDDATE = ("" + row["ENDDATE"]).Trim(),
                                            ENDDATE = row.IsNull("ENDDATE") ? "" : row["ENDDATE"].ToString().Trim(),
                                            DAY = ("" + row["DAY"]).Trim(),
                                            COURSENM = ("" + row["COURSENM"]).Trim(),
                                            PROTOCOLTYPE = ("" + row["PROTOCOLTYPE"]).Trim(),

                                        }).ToArray()
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                jsonData = new { rows = new object[] { }, error = ex.Message };
            }
            return jsonData;
        }

        public object getTreatmentOrderdata(string TransacNo, string IsrollOver, string IPNo, string tsTime, string tstDate, string CallFrmAdmistrn = "N")
        {
            Dictionary<string, object> dict = new Dictionary<string, object>();
            try
            {
                CommonServiceClient comser = new CommonServiceClient();
                List<UserLstItem> AlluserLst = comser.GetUserList().ToList();

                JavaScriptSerializer ser = new JavaScriptSerializer();
                DataSet load = new DataSet();
                TreatmentOrder objTreatOrder = new TreatmentOrder();
                ICUClient icuclnt = new ICUClient();
                string NScode = "018"; // HttpContext.Current.Session["NSCODE"].ToString();

                if (tstDate != string.Empty)
                {
                    tstDate = GeneralFunction.GetDateInSpecifiedFormat(tstDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                }

                DataSet ds = GetCaseDetails(IPNo);

                load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetTreatmentSheetData(TransacNo, IsrollOver, IPNo, tsTime, tstDate))));

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
                DataTable dt13 = new DataTable();
                DataTable dt14 = new DataTable();
                DataTable dt15 = new DataTable();

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
                object jsonWithoutTbltype = "";
                object jsonChemoAData = "";
                object jsonChemoMData = "";
                object jsonNutriData = "";
                OncologyEMR.Oncology.OncologyEMRClient OncServ = new OncologyEMR.Oncology.OncologyEMRClient();
                DataSet DSFormLinkList = new DataSet();
                DSFormLinkList.ReadXml(new StringReader(OncServ.GetFormRouteLink()));
                DataTable FormLstDT = new DataTable();
                if (DSFormLinkList.Tables.Count > 0 && DSFormLinkList.Tables[0].Rows.Count > 0)
                {
                    FormLstDT = DSFormLinkList.Tables[0];
                }
                if (ds.Tables.Contains("CaseDetails"))
                {
                    dt8 = ds.Tables["CaseDetails"];
                    if (dt8.Rows.Count > 0)
                    {
                        JsonCaseDetailData = (from DataRow row in dt8.AsEnumerable()
                                              select new
                                              {
                                                  PROVDIAGNO = row["PROVDIAG"].ToString().Trim(),
                                                  DIAGNOSIS = row["DIAGNOSIS"].ToString().Trim(),
                                                  WEIGHT = row["WEIGHT"].ToString().Trim(),
                                                  HEIGHT = row["HEIGHT"].ToString().Trim(),
                                                  BSA = row["BSA"].ToString().Trim(),
                                              }).ToArray();
                    }
                }
                if (ds.Tables.Contains("Allergy"))
                {
                    dt9 = ds.Tables["Allergy"];
                    if (dt9.Rows.Count > 0)
                    {
                        JsonAllergisData = (from DataRow row in dt9.AsEnumerable()
                                            select new
                                            {
                                                ALLERGYDESC = row["ALLERGYDESC"].ToString().Trim(),
                                            }).ToArray();
                    }
                }

                if (load.Tables.Count > 0)
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
                                               DIAGNOSIS = row["PROVDIAGNO"].ToString().Trim(),
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
                                               VERIFBYDR = row["VERIFBYDR"].ToString().Trim(),
                                               WEIGHT = row["WEIGHT"].ToString().Trim(),
                                               HEIGHT = row["HEIGHT"].ToString().Trim(),
                                               BSA = row["BSA"].ToString().Trim(),
                                               CHEMTREATCOMPLYN = row["CHEMTREATCOMPLYN"].ToString().Trim(),
                                               CHEMCOMPREMARK = row["CHEMCOMPREMARK"].ToString().Trim(),
                                               ProtocolType = row["PROTOCOLTYPE"].ToString().Trim(),
                                               CHMCOMPLBY = row["CHMCOMPLBY"].ToString().Trim(),
                                               CHMCOMPLON = row["CHMCOMPLON"].ToString().Trim(),
                                               CHMCOMPLAT = row["CHMCOMPLAT"].ToString().Trim(),
                                               CycleNo = row["CURRCYCLE"].ToString().Trim(),
                                               Day = row["DAYOFCYCLE"].ToString().Trim(),
                                               TotalCycle = row["TOTCYCLE"].ToString().Trim(),
                                               PlanID = ("" + row["PLANID"]).Trim(),
                                               PlanDate = GeneralFunction.GetDate(row["PLANDATE"].ToString().Trim()),
                                               ProtocolData = row["PROTODATA"].ToString().Trim(),
                                               ProtocolID = row["PROTOCOLCD"].ToString().Trim(),
                                               COURSENM = ("" + row["CHMCOURCEID"]).Trim(),
                                               STARTDATE = GeneralFunction.GetDate(row["CHMPLNSTARTDT"].ToString().Trim()),
                                               DVTPROPHYLDET = row["DVTPROPHYLDET"].ToString().Trim()
                                           }).ToArray();
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("MEDSTAT").ToString().Trim() != "");
                        var resulttbltyp = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE").ToString().Trim() == "");
                        if (result && resulttbltyp.Count() > 0)
                        {
                            dt1 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE").ToString().Trim() == "" && r.Field<string>("MEDSTAT").ToString().Trim() != "").CopyToDataTable();
                            jsonWithoutTbltype = GetColumnByType(dt1, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        //bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "MD");
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE").ToString().Trim() == "AB");
                        if (result)
                        {
                            dt1 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE").ToString().Trim() == "AB").CopyToDataTable();
                            jsonAntibioticData = GetColumnByType(dt1, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        //bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "MD");
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE").ToString().Trim() == "MD");
                        if (result)
                        {
                            dt1 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE").ToString().Trim() == "MD").CopyToDataTable();
                            jsonMedicineData = GetColumnByType(dt1, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "DL");
                        if (result)
                        {
                            dt2 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "DL").CopyToDataTable();
                            jsonNubellizationdata = GetColumnByType(dt2, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "IV");
                        if (result)
                        {
                            dt3 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "IV").CopyToDataTable();
                            jsonSpecilInstData = GetColumnByType(dt3, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "SO");
                        if (result)
                        {
                            dt4 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "SO").CopyToDataTable();
                            jsonStatOrderData = GetColumnByType(dt4, FormLstDT, AlluserLst);
                        }
                    }


                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        //bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "AB");
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE").ToString().Trim() == "AB");
                        if (result)
                        {
                            dt10 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE").ToString().Trim() == "AB").CopyToDataTable();
                            jsonAntibioticData = GetColumnByType(dt10, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "SM");
                        if (result)
                        {
                            dt11 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "SM").CopyToDataTable();
                            jsonStatOrderMediData = GetColumnByType(dt11, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "BP");
                        if (result)
                        {
                            dt12 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "BP").CopyToDataTable();
                            jsonBloodProductData = GetColumnByType(dt12, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "CO");
                        if (result)
                        {
                            dt12 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "CO").CopyToDataTable();
                            //dt12.Columns["CHADMINSEQ"].ColumnName = "AdministerSeq"; dt12.Columns["SETNO"].ColumnName = "SetNo"; dt12.Columns["DILUNTGENCD"].ColumnName = "DiluentGenericCode";
                            jsonChemoAData = GetColumnByType(dt12, FormLstDT, AlluserLst);
                        }
                    }

                    if (load.Tables.Contains("TREATMNTDETAIL"))
                    {
                        bool result = load.Tables["TREATMNTDETAIL"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "CM");
                        if (result)
                        {
                            dt12 = load.Tables["TREATMNTDETAIL"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "CM").CopyToDataTable();
                            jsonChemoMData = GetColumnByType(dt12, FormLstDT, AlluserLst);
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
                                                    ORDERBYNAME = row["ORDERBY"].ToString().Trim() != "" ? (AlluserLst.Where(X => X.UserId == row["ORDERBY"].ToString().Trim()).Count() > 0 ? AlluserLst.Where(X => X.UserId == row["ORDERBY"].ToString().Trim()).FirstOrDefault().Text : row["ORDERBY"].ToString().Trim()) : row["ORDERBY"].ToString().Trim(),
                                                    ORDERBY = row["ORDERBY"].ToString().Trim(),
                                                    ORDDATE = row["ORDERDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["ORDERDT"].ToString().Trim()) : string.Empty,
                                                    ORDTIME = row["ORDERTM"].ToString().Trim(),
                                                    SEQNO = row["SEQNO"].ToString().Trim(),
                                                    HighAlert = row["ALERTYN"].ToString().Trim(),
                                                    OMIT = row["OMIT"].ToString().Trim(),
                                                    OMITBYNAME = row["OMITBY"].ToString().Trim() != "" ? (AlluserLst.Where(X => X.UserId == row["OMITBY"].ToString().Trim()).Count() > 0 ? AlluserLst.Where(X => X.UserId == row["OMITBY"].ToString().Trim()).FirstOrDefault().Text : row["OMITBY"].ToString().Trim()) : row["OMITBY"].ToString().Trim(),
                                                    OMITBY = row["OMITBY"].ToString().Trim(),
                                                    OMITDT = row["OMITDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["OMITDT"].ToString().Trim()) : string.Empty,
                                                    OMITTM = row["OMITTM"].ToString().Trim(),
                                                    Remark = row["REMARK"].ToString().Trim(),
                                                    Dose = row["DOSE"].ToString().Trim(),
                                                    NOTIFYN = row["NOTIFYN"].ToString().Trim(),
                                                    STATUS = row["STATUS"].ToString().Trim(),
                                                    ADMINYN = row["ADMINYN"].ToString().Trim(),
                                                    IsRollOver = row["ROLLOVERYN"].ToString().Trim(),

                                                }).ToArray();
                        }
                    }

                    if (load.Tables.Contains("TEST"))
                    {

                        if (CallFrmAdmistrn == "Y" && load.Tables["TEST"].Rows.Count > 0)
                        {
                            dt6 = load.Tables["TEST"].Select("STATUS <> 'C'").CopyToDataTable();
                        }
                        else
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
                                                TypeCode = "IG",
                                                ORDERBYNAME = row["ORDERBY"].ToString().Trim() != "" ? (AlluserLst.Where(X => X.UserId == row["ORDERBY"].ToString().Trim()).Count() > 0 ? AlluserLst.Where(X => X.UserId == row["ORDERBY"].ToString().Trim()).FirstOrDefault().Text : row["ORDERBY"].ToString().Trim()) : row["ORDERBY"].ToString().Trim(),
                                                ORDERBY = row["ORDERBY"].ToString().Trim(),
                                                SEQNO = row["SEQNO"].ToString().Trim(),
                                                REMARKS = row["REMARKS"].ToString().Trim(),
                                                CancelBY = row["CANCELBY"].ToString().Trim(),
                                                CancelDT = row["CANCELDT"].ToString().Trim(),
                                                CancelTM = row["CANCELTM"].ToString().Trim(),
                                                //STATUS = row["STATUS"].ToString().Trim() == "C" ? "C" : "A",
                                                STATUS = row["STATUS"].ToString().Trim(),
                                                ProposedDate = GeneralFunction.GetDate(row["PROPOSEDT"].ToString().Trim()),
                                                ProposedTime = row["PROPOSETM"].ToString().Trim(),
                                                NotifYN = row["NOTIFYN"].ToString().Trim(),
                                                ORDERNO = row["ORDERNO"].ToString().Trim(),
                                                TestCount = row["TSTCNT"].ToString().Trim(),
                                                OrderPlaced = row["ORDERCNT"].ToString().Trim(),
                                                Pending = (Convert.ToInt32(row["TSTCNT"]) - Convert.ToInt32(row["ORDERCNT"])).ToString(),
                                                OMIT = row["OMITYN"].ToString().Trim(),
                                                OMITBYNAME = row["OMITBY"].ToString().Trim() != "" ? (AlluserLst.Where(X => X.UserId == row["OMITBY"].ToString().Trim()).Count() > 0 ? AlluserLst.Where(X => X.UserId == row["OMITBY"].ToString().Trim()).FirstOrDefault().Text : row["OMITBY"].ToString().Trim()) : row["OMITBY"].ToString().Trim(),
                                                OMITBY = row["OMITBY"].ToString().Trim(),
                                                OMITON = row["OMITON"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["OMITON"].ToString().Trim()) : string.Empty,
                                                OMITAT = row["OMITAT"].ToString().Trim(),
                                                IsRollOver = row["ROLLOVERYN"].ToString().Trim(),

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
                                                  CancelDT = GeneralFunction.GetUIDateFormat(row["CANCELDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
                                                  CancelTM = row["CANCELTM"].ToString().Trim(),
                                                  SUGESTBY = row["SUGESTBY"].ToString().Trim(),
                                                  REASON = row["REASON"].ToString().Trim(),
                                                  CREATEDBY = HttpContext.Current.Session["gOncoUserId"].ToString().Trim(),
                                              }).ToArray();
                        }
                    }

                    if (load.Tables.Contains("TREATNUTRISUPL"))
                    {
                        dt15 = load.Tables["TREATNUTRISUPL"];
                        if (dt15.Rows.Count > 0)
                        {
                            jsonNutriData = (from DataRow row in dt15.AsEnumerable()
                                             select new
                                             {
                                                 action = "",
                                                 NUTRIINTAKE = row["NUTRIINTAKE"].ToString().Trim(),
                                                 VOLSUP = row["VOLSUP"].ToString().Trim(),
                                                 CREATEDON = row["CREATEDON"].ToString().Trim(),
                                                 CREATEDAT = GeneralFunction.GetUIDateFormat(row["CREATEDAT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY),
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
                dict.Add("jsonWithoutTbltype", jsonWithoutTbltype);
                dict.Add("jsonChemoAData", jsonChemoAData);
                dict.Add("jsonChemoMData", jsonChemoMData);
                dict.Add("jsonNutriData", jsonNutriData);
                return dict;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public object GetColumnByType(DataTable Dt, DataTable FormLstDT, List<UserLstItem> AllUserList)
        {
            CommonServiceClient cm = new CommonServiceClient();
            // var medRoutLst = GeneralFunction.MedicineRoute().ToList();
            var DOCTLIST = cm.GetDoctLst();
            object TableData = (from DataRow row in Dt.AsEnumerable()
                                select new
                                {
                                    action = "",
                                    Type = row["TYPE"].ToString().Trim(),
                                    DrugName = row["DRUGNAME"].ToString().Trim(),
                                    DrugCode = Convert.ToString(row["CODE"]).Trim(),
                                    DayOfDrug = Convert.ToString(row["DAYOFDRUG"]).Trim(),
                                    Dose = row["DOSE"].ToString().Trim(),
                                    Route = Convert.ToString(row["ROUTE"]).Trim(),
                                    //Route = (string.Empty + row["ROUTE"]).Trim() != "" ? GeneralFunction.GetListValue(medRoutLst, row["ROUTE"].ToString().Trim()) : "",
                                    Freq = Convert.ToString(row["FREQ"]).Trim(),
                                    OMIT = row["OMIT"].ToString().Trim(),
                                    Remark = row["REMARK"].ToString().Trim(),
                                    TypeCode = row["TBLTYPE"].ToString().Trim(),
                                    ORDERBYNAME = row["ORDERBY"].ToString().Trim() != "" ? (AllUserList.Where(X => X.UserId == row["ORDERBY"].ToString().Trim()).Count() > 0 ? AllUserList.Where(X => X.UserId == row["ORDERBY"].ToString().Trim()).FirstOrDefault().Text : row["ORDERBY"].ToString().Trim()) : row["ORDERBY"].ToString().Trim(),
                                    ORDERBY = row["ORDERBY"].ToString().Trim(),
                                    //OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
                                    ORDDATE = row["ORDDATE"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["ORDDATE"].ToString().Trim()) : string.Empty,
                                    ORDTIME = row["ORDTIME"].ToString().Trim(),
                                    OMITBYNAME = row["OMITBY"].ToString().Trim() != "" ? (AllUserList.Where(X => X.UserId == row["OMITBY"].ToString().Trim()).Count() > 0 ? AllUserList.Where(X => X.UserId == row["OMITBY"].ToString().Trim()).FirstOrDefault().Text : row["OMITBY"].ToString().Trim()) : row["OMITBY"].ToString().Trim(),
                                    OMITBY = row["OMITBY"].ToString().Trim(),
                                    OMITDT = row["OMITDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["OMITDT"].ToString().Trim()) : string.Empty,
                                    OMITTM = row["OMITTM"].ToString().Trim(),
                                    DILVOLUME = row["DILVOLUME"].ToString().Trim(),
                                    ADMINDUR = row["ADMINDUR"].ToString().Trim(),
                                    STARTFRMDT = row["STARTFRMDT"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["STARTFRMDT"].ToString().Trim()) : string.Empty,
                                    SEQNO = row["SEQNO"].ToString().Trim(),
                                    HighAlert = row["ALERTYN"].ToString().Trim(),
                                    INFRATE = Convert.ToString(row["INFRATE"]).Trim(),
                                    MACROSET = Convert.ToString(row["MACROSET"]).Trim(),
                                    MICROSET = Convert.ToString(row["MICROSET"]).Trim(),
                                    NOTIFYN = row["NOTIFYN"].ToString().Trim(),
                                    STATUS = row["STATUS"].ToString().Trim(),
                                    ADMINYN = row["ADMINYN"].ToString().Trim(),
                                    Duration = Convert.ToString(row["DURATION"]).Trim(),
                                    Diluent = row["DILUENT"].ToString().Trim(),
                                    MEDSTAT = row["MEDSTAT"].ToString().Trim(),
                                    SetNo = row["SETNO"].ToString().Trim(),
                                    AdministerSeq = Convert.ToString(row["CHADMINSEQ"]).Trim(),
                                    DiluentGenericCode = row["DILUNTGENCD"].ToString().Trim(),
                                    ORGDOSE = row["ORGDOSE"].ToString().Trim(),
                                    HOLD = row["HOLDYN"].ToString().Trim(),
                                    ISSUEYN = row["IPISSUEYN"].ToString().Trim(),
                                    PRESCRIBEBY = row["PRESCRIBEBY"].ToString().Trim(),
                                    DOCNAME = GeneralFunction.GetListValue(DOCTLIST, row["PRESCRIBEBY"].ToString().Trim()),
                                    MEDTYPE = row["MEDTYPE"].ToString().Trim(),
                                    //IPISSUEYN = row["IPISSUEYN"].ToString().Trim(),
                                    INDENTYN = row["IPINDENTYN"].ToString().Trim(),
                                    IsRollOver = row["ROLLOVERYN"].ToString().Trim(),
                                    FormCode = row["DRUGFROMCD"].ToString().Trim(),//FormLstDT.Rows.Count > 0 ? (FormLstDT.Select("MTRLFORMID = '" + ("" + row["TYPE"]).ToString().Trim() + "'").Length > 0 ? FormLstDT.Select("MTRLFORMID = '" + ("" + row["TYPE"]).ToString().Trim() + "'")[0]["DESCR"].ToString().Trim() : "") : "",
                                    FormName = row["TYPE"].ToString().Trim(),
                                    // CALCULATEON = ("" + row["CALCULATEON"]).Trim(),
                                    CALCULATEON = Dt.Columns.Contains("CALCULATEON") ? row["CALCULATEON"].ToString().Trim() : "",
                                    APLYTODAY = Dt.Columns.Contains("APPLYTODAY") ? row["APPLYTODAY"].ToString().Trim() : "",
                                    CycleNo = Dt.Columns.Contains("CYCLENO") ? row["CYCLENO"].ToString().Trim() : "",
                                    ENDDATE = Dt.Columns.Contains("ENDDATE") ? row["ENDDATE"].ToString().Trim() != string.Empty ? GeneralFunction.GetDate(row["ENDDATE"].ToString().Trim()) : string.Empty : "",
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

        public object RetriveTSPlandData(string IPNo, string TranDate, string RecordType, string IsRollver, string callfrom, string gblNurscode, string notifYn = "N", string strTranNo = "")
        {
            DataSet load = new DataSet(); DataSet load1 = new DataSet();
            ICUClient icuclnt = new ICUClient();
            string TranFormatedDate = string.Empty;
            string NScode = gblNurscode;//HttpContext.Current.Session["NSCODE"].ToString();

            if (TranDate != string.Empty)
            {
                TranFormatedDate = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(TranDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            }
            if (callfrom == "OK")
            {
                NScode = gblNurscode;
            }
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetTSAdminAndPlanList(IPNo, TranFormatedDate, "P", IsRollver, NScode, strTranNo))));

            if (notifYn == "Y")
            {
                DateTime cur = DateTime.ParseExact(TranDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                var prevDate = cur.AddDays(-1).ToString("yyyyMMdd");
                load1.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetTSAdminAndPlanList(IPNo, prevDate, "P", IsRollver, NScode, ""))));
                load.Merge(load1);
            }

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

                string jsonData = JsonConvert.SerializeObject(load, Newtonsoft.Json.Formatting.Indented);
                return jsonData;
            }
            else
            {
                return "Unsucessfull";
            }
        }
    }

    #endregion

    #region AssessmentOfLine
    public class AssessmentOfLineMdl : BL_AssesOfLine
    {
        public int TranMode { get; set; }
        public string TranNo { get; set; }
        public string TranDate { get; set; }
        public string TranTime { get; set; }
        public string shifts { get; set; }
        public string LineTube { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> SideSelected { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> ConditionSelected { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> ShiftSelected { get; set; }
        public List<OncologyEMR.CommonSerRef.SelectLstItem> AssmntSelected { get; set; }
        public IEnumerable<OncologyEMR.ICUServRef.ICULineAndTube> LineTubeLst { get; set; }

        public void FillCombos(AssessmentOfLineMdl md)
        {
            ICUClient icuclnt = new ICUClient();
            md.LineTubeLst = icuclnt.GetLinesAndTubeLst().Where(x => x.Status == "A").ToList();
        }

        public List<OncologyEMR.CommonSerRef.SelectLstItem> ShiftList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Morning", Value = "Morning" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Evening", Value = "Evening" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Night", Value = "Night" });
            return list;
        }

        public List<OncologyEMR.CommonSerRef.SelectLstItem> AssmntList()
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

        public List<OncologyEMR.CommonSerRef.SelectLstItem> SideList()
        {
            List<OncologyEMR.CommonSerRef.SelectLstItem> list = new List<OncologyEMR.CommonSerRef.SelectLstItem>();
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Left", Value = "L" });
            list.Add(new OncologyEMR.CommonSerRef.SelectLstItem() { Text = "Right", Value = "R" });
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

        public string SaveAssessmentOfLineTran(string PatientData, string GrdAssemnt, string Shift, int TranMode, string TranNo, string TranDate, string TranTime, string ShiftDate)
        {
            ICUClient icuclnt = new ICUClient();
            AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            BL_AssesOfLine blassmntoflien = new BL_AssesOfLine();
            string grdxml = "";
            DataSet ds = new DataSet("TUBEDET");
            DataTable dt = new DataTable("TUBELST");
            dt = JsonConvert.DeserializeObject<DataTable>(GrdAssemnt);
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                if (Convert.ToInt32(dt.Rows[i]["TUBECD"]) < 54)
                {
                    dt.Rows[i]["AssessmentOfLine1"] = "";
                }
            }
            if (dt.Rows.Count > 0)
            {
                dt.Columns.Remove("TUBETYPE");
                dt.Columns["TUBETYPES"].ColumnName = "TUBETYPE";
                ds.Tables.Add(dt);
                dt.TableName = "TUBELST";
                grdxml = ds.GetXml();
            }
            else
            {
                grdxml = "";
            }
            blassmntoflien.IpAdress = HttpContext.Current.Session["MchIPAddress"].ToString();
            blassmntoflien.LineDet = grdxml;
            blassmntoflien.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
            blassmntoflien.Shift = Shift;
            blassmntoflien.ShiftDate = GeneralFunction.GetDateInSpecifiedFormat(ShiftDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blassmntoflien.Tranmode = Convert.ToInt16("1");
            blassmntoflien.TranNo = "";
            blassmntoflien.userID = HttpContext.Current.Session["UserID"].ToString(); ;
            blassmntoflien.IPNo = "";//userModal.strUIPNo;
            blassmntoflien.MRNo = "";//userModal.strUMrNo;
            blassmntoflien.PatName = "";//userModal.strUName;
            string lst = "";
            lst = icuclnt.AssessOfLineTran(blassmntoflien);
            return lst;
        }

        public DataSet PrintAssessmentOfLineData(string PatientData, string GrdAssemnt, string Shift, string ShiftDate)
        {
            DataTable HData = new DataTable();
            AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            DataTable df = new DataTable();
            DataTable dt = new DataTable();
            DataTable dg = new DataTable();
            DataTable ds = new DataTable();
            DataTable search = new DataTable();
            DataSet AllData = new DataSet();
            DataTable user = new DataTable();
            df = JsonConvert.DeserializeObject<DataTable>(PatientData);
            dt = JsonConvert.DeserializeObject<DataTable>(GrdAssemnt);
            DataTable patdt = new DataTable();
            dt.TableName = "AssessmentOfLine";
            dt.Columns.Add("ShiftDate");
            dt.Columns.Add("AssmntOfLine");
            dt.Columns.Add("Shift");
            dt.Rows[0]["Shift"] = Shift;
            dt.Rows[0]["ShiftDate"] = ShiftDate;
            var Slst = assmntofline.SideList();
            var Clst = assmntofline.ConditionList();
            var AsstLst = assmntofline.AssmntList();
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                dt.Rows[i]["SIDE"] = Slst.Where(x => x.Value == dt.Rows[i]["SIDE"].ToString().Trim()).Count() > 0 ? Slst.AsEnumerable().Where(x => x.Value == dt.Rows[i]["SIDE"].ToString().Trim()).First().Text : "";
                dt.Rows[i]["AssmntOfLine"] = dt.Rows[i]["AssessmentOfLine1"] + "  " + dt.Rows[i]["SIDE"] + "  " + dt.Rows[i]["TUBETYPE"] + "  " + dt.Rows[i]["OTHERTXT"];
                dt.Rows[i]["COND"] = Clst.Where(x => x.Value == dt.Rows[i]["COND"].ToString().Trim()).Count() > 0 ? Clst.AsEnumerable().Where(x => x.Value == dt.Rows[i]["COND"].ToString().Trim()).First().Text : "";
            }
            CommonServiceClient comserv = new CommonServiceClient();
            GeneralFunction gf = new GeneralFunction();
            HData = GeneralFunction.getHeaderFooter("Assessment of Line", "", "", "C");
            HData.TableName = "HeaderFooter";
            AllData.Tables.Add(patdt);
            AllData.Tables.Add(dt);
            AllData.Tables.Add(HData);
            return AllData;
        }

        public Tuple<object, object> GetBindingDataAssessment(string ipno, string Shiftdate, string shiftval, string strRollOver)
        {
            ICUClient icuclnt = new ICUClient();
            AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            object jsonData = "";
            object jsonDatas = "";
            Shiftdate = GeneralFunction.GetDateInSpecifiedFormat(Shiftdate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            var AsstLst = assmntofline.AssmntList();
            if (shiftval == "Morning")
                shiftval = "M";
            if (shiftval == "Evening")
                shiftval = "E";
            if (shiftval == "Night")
                shiftval = "N";
            if (strRollOver == "Y")
            {
                if (shiftval == "M")
                {
                    shiftval = "N";
                }
                else if (shiftval == "E")
                {
                    shiftval = "M";
                }
                else if (shiftval == "N")
                {
                    shiftval = "E";
                }
            }
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetAssesOfLine(ipno, Shiftdate, shiftval))));
            if (strRollOver == "Y")
            {
                if (shiftval == "E" && load.Tables.Count == 0)
                {
                    shiftval = "M";
                    load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetAssesOfLine(ipno, Shiftdate, shiftval))));
                }
                else if (shiftval == "N" && load.Tables.Count == 0)
                {
                    shiftval = "E";
                    load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetAssesOfLine(ipno, Shiftdate, shiftval))));

                    if (load.Tables.Count == 0)
                    {
                        shiftval = "M";
                        load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetAssesOfLine(ipno, Shiftdate, shiftval))));
                    }
                }
            }
            if (load.Tables.Count > 0)
            {
                l_oDT = load.Tables[0];
                jsonData = new
                {
                    rows = (from DataRow row in l_oDT.Rows
                            select new
                            {
                                TUBECD = ("" + row["TUBECD"]).Trim(),
                                TUBETYPE = AsstLst.Where(x => x.Value == ("" + row["TUBETYPE"]).Trim()).Count() == 0 ? "" : AsstLst.Where(p => p.Value == row["TUBETYPE"].ToString().Trim()).First().Text,
                                TUBETYPES = ("" + row["TUBETYPE"]).Trim(),
                                SIDE = ("" + row["SIDE"]).Trim(),
                                OTHERTXT = ("" + row["OTHERTXT"]).Trim(),
                                DOI = ("" + row["DOI"]).Trim(),
                                DOR = ("" + row["DOR"]).Trim(),
                                DAYNO = ("" + row["DAYNO"]).Trim(),
                                COND = ("" + row["COND"]).Trim(),
                                SHIFTDT = GeneralFunction.GetDate(row["SHIFTDT"].ToString().Trim()),
                                OTHERLINES = ("" + row["OTHERLINES"]).Trim(),
                                SHIFTTM = ("" + row["SHIFTTM"]).Trim(),
                            }).ToArray()

                };
            }
            if (load.Tables.Count > 0)
            {
                jsonDatas = new
                {
                    rows = (from DataRow row in l_oDT.Rows
                            select new
                            {
                                CREATEDBY = ("" + row["CREATEDBY"]).Trim(),
                                CREATEDAT = ("" + row["CREATEDAT"]).Trim(),
                                CREATEDON = GeneralFunction.GetDate(("" + row["CREATEDON"]).Trim()),
                            }).ToArray()

                };
            }
            return Tuple.Create(jsonData, jsonDatas);
        }

        public string SaveChkLstData(string PatientData, string FormData, string RemovalData, string StepsData, string AssessmentRow, string gact)
        {
            ICUClient icuclnt = new ICUClient();
            BL_AssesOfLine blassmntofline = new BL_AssesOfLine();
            string result = "";
            try
            {
                var formData = JsonConvert.DeserializeObject<Dictionary<string, string>>(FormData);
                var removalData = JsonConvert.DeserializeObject<Dictionary<string, string>>(RemovalData);
                var stepsData = JsonConvert.DeserializeObject<List<Dictionary<string, string>>>(StepsData);
                var assessmentRow = JsonConvert.DeserializeObject<Dictionary<string, string>>(AssessmentRow);
                string stepsXml = "";
                if (stepsData != null && stepsData.Count > 0)
                {
                    DataTable dt = JsonConvert.DeserializeObject<DataTable>(StepsData);
                    DataSet ds = new DataSet("STEPSDET");
                    dt.TableName = "STEP_LIST";
                    ds.Tables.Add(dt);
                    stepsXml = ds.GetXml();
                }
                blassmntofline.TranNo = formData.ContainsKey("TranNo") ? formData["TranNo"] : "";
                blassmntofline.ProcedureDone = formData.ContainsKey("ProcedureDone") ? formData["ProcedureDone"] : "";
                blassmntofline.Priority = formData.ContainsKey("Priority") ? formData["Priority"] : "";
                blassmntofline.ProcedureLocation = formData.ContainsKey("ProcedureLocation") ? formData["ProcedureLocation"] : "";
                blassmntofline.PreviousDetails = formData.ContainsKey("PreviousDetails") ? formData["PreviousDetails"] : "";
                blassmntofline.ProcedureDoneBy = formData.ContainsKey("ProcedureDoneBy") ? formData["ProcedureDoneBy"] : "";
                blassmntofline.AssistedBy = formData.ContainsKey("AssistedBy") ? formData["AssistedBy"] : "";
                blassmntofline.ProAuditedBy = formData.ContainsKey("ProAuditedBy") ? formData["ProAuditedBy"] : "";
                blassmntofline.CatheterType = formData.ContainsKey("CatheterType") ? formData["CatheterType"] : "";
                blassmntofline.Impregnated = formData.ContainsKey("Impregnated") ? formData["Impregnated"] : "";
                blassmntofline.NoOfLumens = formData.ContainsKey("NoOfLumens") ? formData["NoOfLumens"] : "";
                blassmntofline.CatheterLotNumber = formData.ContainsKey("CatheterLotNumber") ? formData["CatheterLotNumber"] : "";
                string ExpiryDate = formData.ContainsKey("ExpiryDt") ? formData["ExpiryDt"] : ""; ;
                string ExDate = GeneralFunction.GetDateInSpecifiedFormat(ExpiryDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                blassmntofline.ExpiryDt = ExDate;
                blassmntofline.GuideWireUsed = formData.ContainsKey("GuideWireUsed") ? formData["GuideWireUsed"] : "";
                blassmntofline.SkinPreparation = formData.ContainsKey("SkinPreparation") ? formData["SkinPreparation"] : "";
                blassmntofline.QtyOfSteral = formData.ContainsKey("QtyOfSteral") ? formData["QtyOfSteral"] : "";
                blassmntofline.SizeOfCath = formData.ContainsKey("SizeOfCath") ? formData["SizeOfCath"] : "";
                blassmntofline.MtrlOfTube = formData.ContainsKey("MtrlOfTube") ? formData["MtrlOfTube"] : "";
                blassmntofline.MtrlTubeOther = formData.ContainsKey("MtrlTubeOther") ? formData["MtrlTubeOther"] : "";
                blassmntofline.Condition = formData.ContainsKey("CondOfInsertionSite") ? formData["CondOfInsertionSite"] : "";
                blassmntofline.PrevInsertYN = formData.ContainsKey("PreviousDetailsYN") ? formData["PreviousDetailsYN"] : "";
                blassmntofline.DifficultyYN = formData.ContainsKey("DifficultyYN") ? formData["DifficultyYN"] : "";
                blassmntofline.DiffiDet = formData.ContainsKey("DiffiDet") ? formData["DiffiDet"] : "";
                blassmntofline.ProcEndTime = formData.ContainsKey("ProcEndTime") ? formData["ProcEndTime"] : "";
                blassmntofline.ClinicalCond = formData.ContainsKey("ClinicalIndication") ? formData["ClinicalIndication"] : "";
                blassmntofline.RemovalDet = removalData.ContainsKey("RemovalDetails") ? removalData["RemovalDetails"] : "";
                blassmntofline.RemovedBY = removalData.ContainsKey("RemovedBy") ? removalData["RemovedBy"] : "";
                blassmntofline.RemovalAssistBy = removalData.ContainsKey("RemovalAssistedBy") ? removalData["RemovalAssistedBy"] : "";
                blassmntofline.CatherIntactYN = removalData.ContainsKey("CatherIntact") ? removalData["CatherIntact"] : "";
                blassmntofline.CathIntactActTaken = removalData.ContainsKey("CatherIntactOther") ? removalData["CatherIntactOther"] : "";
                blassmntofline.RemovalCondOfInsertionSite = removalData.ContainsKey("RemovalCondOfInsertionSite") ? removalData["RemovalCondOfInsertionSite"] : "";
                blassmntofline.ReasonForRemoval = removalData.ContainsKey("RemovalReason") ? removalData["RemovalReason"] : "";
                blassmntofline.ReasonFrReintubtn = removalData.ContainsKey("ReasonFrReintubtn") ? removalData["ReasonFrReintubtn"] : "";
                blassmntofline.ReintbtnDoneBy = removalData.ContainsKey("ReintbtnDoneBy") ? removalData["ReintbtnDoneBy"] : "";
                blassmntofline.ReintubAssistBy = removalData.ContainsKey("ReintubAssistBy") ? removalData["ReintubAssistBy"] : "";
                blassmntofline.Bundle = assessmentRow.ContainsKey("BUNDLETYPE") ? assessmentRow["BUNDLETYPE"] : "";
                blassmntofline.TubeCode = assessmentRow.ContainsKey("TUBECD") ? assessmentRow["TUBECD"] : "";
                blassmntofline.TubeType = assessmentRow.ContainsKey("TUBETYPE") ? assessmentRow["TUBETYPE"] : "";
                blassmntofline.Othertext = assessmentRow.ContainsKey("OTHERTXT") ? assessmentRow["OTHERTXT"] : "";
                blassmntofline.BodySide = assessmentRow.ContainsKey("SIDE") ? assessmentRow["SIDE"] : "";
                blassmntofline.DayNo = assessmentRow.ContainsKey("DAYNO") ? assessmentRow["DAYNO"] : "";
                blassmntofline.OtherLines = assessmentRow.ContainsKey("AssessmentOfLine1") ? assessmentRow["AssessmentOfLine1"] : "";
                blassmntofline.DOR = GeneralFunction.GetDateInSpecifiedFormat((assessmentRow.ContainsKey("DOR") ? assessmentRow["DOR"] : ""), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                blassmntofline.DOI = GeneralFunction.GetDateInSpecifiedFormat((assessmentRow.ContainsKey("DOI") ? assessmentRow["DOI"] : ""), GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                blassmntofline.TimeOfRemoval = assessmentRow.ContainsKey("TOR") ? assessmentRow["TOR"] : "";
                blassmntofline.TOI = assessmentRow.ContainsKey("TOI") ? assessmentRow["TOI"] : "";
                blassmntofline.LineIndicator = assessmentRow.ContainsKey("INDICATOR") ? assessmentRow["INDICATOR"] : "";
                blassmntofline.CriticlStepXML = stepsXml;
                blassmntofline.IpAdress = HttpContext.Current.Session["MchIPAddress"].ToString();
                blassmntofline.IPNo = "";//userModal.strUIPNo;
                blassmntofline.MRNo = "";//userModal.strUMrNo;
                blassmntofline.PatName = "";//userModal.strUName;
                blassmntofline.ModuleID = HttpContext.Current.Session["ModuleIDGlobal"].ToString(); ;
                blassmntofline.userID = HttpContext.Current.Session["UserID"].ToString();
                if (gact == "N")
                {
                    blassmntofline.Tranmode = 1;
                }
                else if (gact == "E")
                {
                    blassmntofline.Tranmode = 2;
                }
                else if (gact == "R")
                {
                    blassmntofline.Tranmode = 7;
                }
                result = icuclnt.LineAndTubeNewTran(blassmntofline);
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
            return result;
        }

        public object GetLineTubeList(string IPNO)
        {
            ICUClient icuclnt = new ICUClient();
            AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            object jsonData = "";
            var AsstLst = assmntofline.AssmntList();
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetLineTubeList(IPNO))));
            if (load.Tables.Count > 0)
            {
                l_oDT = load.Tables[0];
                jsonData = new
                {
                    rows = (from DataRow row in l_oDT.Rows
                            let dor = GeneralFunction.GetDate(("" + row["DOR"]).Trim())
                            select new
                            {
                                AssessmentOfLine1 = ("" + row["OTHERLINES"]).Trim(),
                                TUBECD = ("" + row["TUBECD"]).Trim(),
                                TUBETYPE = AsstLst.Where(x => x.Value == ("" + row["TUBETYPE"]).Trim()).Count() == 0 ? "" : AsstLst.Where(p => p.Value == row["TUBETYPE"].ToString().Trim()).First().Text,
                                SIDE = ("" + row["SIDE"]).Trim(),
                                OTHERTXT = ("" + row["OTHERTXT"]).Trim(),
                                OTHERLINES = ("" + row["OTHERLINES"]).Trim(),
                                DOI = GeneralFunction.GetDate(("" + row["DOI"]).Trim()),
                                DOR = GeneralFunction.GetDate(("" + row["DOR"]).Trim()),
                                DAYNO = ("" + row["DAYNO"]).Trim(),
                                COND = ("" + row["COND"]).Trim(),
                                TOI = ("" + row["PROCSTARTTM"]).Trim(),
                                TOR = ("" + row["REMOVALTM"]).Trim(),
                                PROCENDTM = ("" + row["PROCENDTM"]).Trim(),
                                TRANNO = ("" + row["TRANNO"]).Trim(),
                                STATUS = !string.IsNullOrEmpty(dor)
                                 ? "R"
                                 : ("" + row["STATUS"]).Trim(),
                                INDICATOR = ("" + row["INDICATOR"]).Trim(),
                                BUNDLE = ("" + row["BUNDLE"]).Trim(),
                                BUNDLETYPE = ("" + row["BUNDLE"]).Trim(),
                            }).ToArray()

                };
            }
            Dictionary<string, object> dict = new Dictionary<string, object>();
            dict.Add("AssessmntData", jsonData);
            return dict;
        }

        public object GetLineTubeDet(string IPNO, string Tranno)
        {
            ICUClient icuclnt = new ICUClient();
            AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            object jsonData = "";
            var AsstLst = assmntofline.AssmntList();
            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetLineTubeDet(IPNO, Tranno))));
            if (load.Tables.Count > 0)
            {
                l_oDT = load.Tables[0];
                jsonData = new
                {
                    rows = (from DataRow row in l_oDT.Rows
                            let dor = GeneralFunction.GetDate(("" + row["DOR"]).Trim())
                            select new
                            {
                                TUBECD = ("" + row["TUBECD"]).Trim(),
                                TUBETYPE = AsstLst.Where(x => x.Value == ("" + row["TUBETYPE"]).Trim()).Count() == 0 ? "" : AsstLst.Where(p => p.Value == row["TUBETYPE"].ToString().Trim()).First().Text,
                                SIDE = ("" + row["SIDE"]).Trim(),
                                OTHERTXT = ("" + row["OTHERTXT"]).Trim(),
                                OTHERLINES = ("" + row["OTHERLINES"]).Trim(),
                                DOI = GeneralFunction.GetDate(("" + row["DOI"]).Trim()),
                                DOR = GeneralFunction.GetDate(("" + row["DOR"]).Trim()),
                                DAYNO = ("" + row["DAYNO"]).Trim(),
                                COND = ("" + row["COND"]).Trim(),
                                TOI = ("" + row["PROCSTARTTM"]).Trim(),
                                TOR = ("" + row["REMOVALTM"]).Trim(),
                                PROCENDTM = ("" + row["PROCENDTM"]).Trim(),
                                TRANNO = ("" + row["TRANNO"]).Trim(),
                                TRANDATE = GeneralFunction.GetDate(("" + row["CREATEDON"]).Trim()),
                                TRANTIME = ("" + row["CREATEDAT"]).Trim(),
                                PROCDONE = ("" + row["PROCDONE"]).Trim(),
                                PRIORITY = ("" + row["PRIORITY"]).Trim(),
                                LOCOFPROCE = ("" + row["LOCOFPROCE"]).Trim(),
                                PREINSERTYN = ("" + row["PREINSERTYN"]).Trim(),
                                PREINSERTDET = ("" + row["PREINSERTDET"]).Trim(),
                                CATHTYPE = ("" + row["CATHTYPE"]).Trim(),
                                IMPRGNTD = ("" + row["IMPRGNTD"]).Trim(),
                                NOOFLUMEN = ("" + row["NOOFLUMEN"]).Trim(),
                                GUWIUSE = ("" + row["GUWIUSE"]).Trim(),
                                SKINPREP = ("" + row["SKINPREP"]).Trim(),
                                MTRLOFTUBE = ("" + row["MTRLOFTUBE"]).Trim(),
                                MTRLTUBEOTH = ("" + row["MTRLTUBEOTH"]).Trim(),
                                BATCHNO = ("" + row["BATCHNO"]).Trim(),
                                DTOFEXPIRY = GeneralFunction.GetDate(("" + row["DTOFEXPIRY"]).Trim()),
                                PROCDONEBY = ("" + row["PROCDONEBY"]).Trim(),
                                ASSISTBY = ("" + row["ASSISTBY"]).Trim(),
                                AUDITBY = ("" + row["AUDITBY"]).Trim(),
                                CONDOFSITE = ("" + row["CONDOFSITE"]).Trim(),
                                NURSONDUTY = ("" + row["NURSONDUTY"]).Trim(),
                                QTYOFSTERAL = ("" + row["QTYOFSTERL"]).Trim(),
                                SIZEOFCATH = ("" + row["SIZEOFCATH"]).Trim(),
                                CLINICCOND = ("" + row["CLINICCOND"]).Trim(),
                                CATHERINTACT = ("" + row["INTACTYN"]).Trim(),
                                CATHERINTOCTH = ("" + row["INTACTTAKE"]).Trim(),
                                REMOVALDET = ("" + row["REMOVALDET"]).Trim(),
                                REMOVEDBY = ("" + row["REMOVEDBY"]).Trim(),
                                REMASSITBY = ("" + row["REMASSITBY"]).Trim(),
                                REMSITECOND = ("" + row["REMSITECOND"]).Trim(),
                                REASONFORREMOVAL = ("" + row["REMREASON"]).Trim(),
                                REINBREMAR = ("" + row["REINBREMAR"]).Trim(),
                                REINBDONEBY = ("" + row["REINBDONEBY"]).Trim(),
                                REINBASISTBY = ("" + row["REINBASISTBY"]).Trim(),
                                DIFFICULYN = ("" + row["DIFFICULYN"]).Trim(),
                                DIFFDETAIL = ("" + row["DIFFDETAIL"]).Trim(),
                                REMOVALTM = ("" + row["REMOVALTM"]).Trim(),
                                STATUS = !string.IsNullOrEmpty(dor)
                                 ? "R"
                                 : ("" + row["STATUS"]).Trim(),
                                BUNDLE = ("" + row["BUNDLE"]).Trim(),
                                INDICATOR = ("" + row["INDICATOR"]).Trim(),
                            }).ToArray(),
                    criticalSteps = (load.Tables.Count > 1)
                        ? (from DataRow row in load.Tables[1].Rows
                           select new
                           {
                               STEPCD = ("" + row["STEPCD"]).Trim(),
                               ANSWER = ("" + row["ANSWER"]).Trim(),
                               REMARK = ("" + row["REMARK"]).Trim()
                           }).ToArray()
                        : new object[0]

                };
            }
            Dictionary<string, object> dict = new Dictionary<string, object>();
            dict.Add("AssessmntData", jsonData);
            return dict;
        }
    }
    #endregion

    #region EMR Records

    #region Main EMR Record
    public class Reports : formrights
    {
        ICUClient icuClient = new ICUClient();
        CommonServiceClient common = new CommonServiceClient();
        public string strDate { get; set; }
        public string strToDate { get; set; }
        public string strTime { get; set; }
        public string Time { get; set; }
        public string strIPNO { get; set; }
        public List<SelectListItem> TimeList { get; set; }
        public List<SelectLstItem1> BundleListSelected { get; set; }
        public List<SelectLstItem1> PerphlBundleListSelected { get; set; }     //vishal 5th July 2019
        public string Bundle { get; set; }
        public IEnumerable<EmployeeLstItem> EmployeeList { get; set; }  //added by ashvini 
        public List<SelectLstItem1> BundleList()
        {
            List<SelectLstItem1> list = new List<SelectLstItem1>();
            list.Add(new SelectLstItem1() { Text = "I", Value = "I" });
            list.Add(new SelectLstItem1() { Text = "II", Value = "II" });
            list.Add(new SelectLstItem1() { Text = "III", Value = "III" });
            list.Add(new SelectLstItem1() { Text = "IV", Value = "IV" });
            return list;
        }
        //vishal 22ndMarch 2019
        public List<SelectLstItem1> PerphlBundleList()                //vishal 5th July 2019
        {
            List<SelectLstItem1> list = new List<SelectLstItem1>();
            list.Add(new SelectLstItem1() { Text = "I", Value = "I" });
            list.Add(new SelectLstItem1() { Text = "II", Value = "II" });
            list.Add(new SelectLstItem1() { Text = "III", Value = "III" });
            list.Add(new SelectLstItem1() { Text = "IV", Value = "IV" });

            list.Add(new SelectLstItem1() { Text = "V", Value = "V" });
            list.Add(new SelectLstItem1() { Text = "VI", Value = "VI" });
            list.Add(new SelectLstItem1() { Text = "VII", Value = "VII" });
            list.Add(new SelectLstItem1() { Text = "VIII", Value = "VIII" });

            list.Add(new SelectLstItem1() { Text = "IX", Value = "IX" });
            list.Add(new SelectLstItem1() { Text = "X", Value = "X" });
            list.Add(new SelectLstItem1() { Text = "XI", Value = "XI" });
            list.Add(new SelectLstItem1() { Text = "XII", Value = "XII" });

            list.Add(new SelectLstItem1() { Text = "XIII", Value = "XIII" });
            list.Add(new SelectLstItem1() { Text = "XIV", Value = "XIV" });
            list.Add(new SelectLstItem1() { Text = "XV", Value = "XV" });

            return list;
        }
        public string Shift { get; set; }
        public List<SelectLstItem1> ShiftSelected { get; set; }
        public IEnumerable<CommonSerRef.SelectLstItem> IsbarTime { get; set; }
        public IEnumerable<CommonSerRef.SelectLstItem> ProblemList { get; set; }   /*Madhuri:-for seprating 2 reports*/
        //  public string ProblemCode { get; set; }   /*Madhuri:-for seprating 2 reports*/
        public void FillCombos(Reports rpts)
        {
            CommonServiceClient comm = new CommonServiceClient();
            rpts.TimeList = GeneralFunction.GetTimeList();
            //  rpts.ProblemList = common.GetICUProbList().Where(x => x.Status == "A");
            rpts.ShiftSelected = GeneralFunction.ShiftList();  //vishal 22ndMarch 2019        
            //EmployeeList = comm.GetEmpList();
            var allEmployees = comm.GetEmpList();
            EmployeeList = allEmployees.Where(emp => emp.NURSYN == "Y").ToList();
        }

        public IEnumerable<CommonSerRef.SelectLstItem> FillCombos(string strDate, string strIPNO, string strType)
        {
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            List<CommonSerRef.SelectLstItem> list = null;

            if (strType == "ISBAR")
                list = common.GetISBARYTimeList(strDate, strIPNO).ToList();
            else if (strType == "ISBARDR")
                list = common.GetISBARDrTimeList(strDate, strIPNO).ToList();
            else if (strType == "NURSASSMNT")
                //list = common.GetNursAssmntTimeList(strDate, strIPNO).ToList();
                list = common.GetNursAssmntTimeList(strDate, strIPNO)
                   .OrderBy(x =>
                   {
                       string[] parts = x.Text.Split(' '); // ["10","AM"]
                       int hour = Convert.ToInt32(parts[0]);
                       string ampm = parts[1].ToUpper();
                       if (ampm == "PM" && hour != 12) hour += 12;
                       if (ampm == "AM" && hour == 12) hour = 0;
                       return hour;
                   })
                   .ToList();


            if (list != null && strType == "ISBAR" || strType == "ISBARDR")
            {
                foreach (var item in list)
                {
                    item.Text = GeneralFunction.ConvertTo12HourFormat(item.Text);
                }
            }

            return list;
        }

        public DataSet getPrintISBAR(string strIPNo, string strDate, string strTime, string CounterName, string IsbarType)
        {

            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");
            string strTimeSlot = "";
            DataTable HData = new DataTable();
            if (!string.IsNullOrEmpty(strTime))
            {
                DateTime dt1 = DateTime.ParseExact(strTime, "HH:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
                System.Threading.Thread.CurrentThread.CurrentCulture = System.Globalization.CultureInfo.InvariantCulture;
                strTimeSlot = dt1.ToString("hh tt");
            }


            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetISBARFieldPrint(strIPNo, strDate, strTime, strTimeSlot))));
            object[] obj = new object[1];
            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    // var DATE = load.Tables[0].Rows[0]["IFDATE"].ToString();
                    //load.Tables[0].Rows[0]["IFDATE"] = GeneralFunction.GetDate(DATE);

                    if (load.Tables.Contains("CASEDET") && load.Tables["CASEDET"].Rows.Count > 0)
                    {
                        dt = load.Tables["CASEDET"];
                        dt.Rows[0]["SURGDATE"] = GeneralFunction.GetDate(dt.Rows[0]["SURGDATE"].ToString());

                        if (dt.Rows[0]["POSTOPDAYS"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["POSTOPDAYS"] = GeneralFunction.calPostOperDays(dt.Rows[0]["SURGDATE"].ToString(), strDate);
                        }
                        if (dt.Rows[0]["ARRIVALDT"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["ARRIVALDT"] = GeneralFunction.GetUIDateFormat(dt.Rows[0]["ARRIVALDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                        }
                        if (dt.Rows[0]["TMOFARRIVAL"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["TMOFARRIVAL"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["TMOFARRIVAL"].ToString().Trim());
                        }
                        if (dt.Rows[0]["DISCHRGDT"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["DISCHRGDT"] = GeneralFunction.GetUIDateFormat(dt.Rows[0]["DISCHRGDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                        }


                        if (dt.Rows[0]["VULNRBLYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["VULNRBLYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["VULNRBLYN"].ToString() == "N")
                        {
                            dt.Rows[0]["VULNRBLYN"] = "No";
                        }
                        if (dt.Rows[0]["IDBANDYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["IDBANDYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["IDBANDYN"].ToString() == "N")
                        {
                            dt.Rows[0]["IDBANDYN"] = "No";
                        }


                        strDate = GeneralFunction.GetUIDateFormat(strDate, GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                        string arrival = dt.Rows[0]["ARRIVALDT"].ToString().Trim();
                        string discharge = dt.Rows[0]["DISCHRGDT"].ToString().Trim();
                        DateTime arrivalDate, dischargeDate, targetDate;
                        dt.Columns.Add("DISCHRGDAYS");
                        dt.Columns.Add("PRSNTDAYS");
                        if (
                            DateTime.TryParseExact(arrival, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out arrivalDate) &&
                            DateTime.TryParseExact(discharge, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dischargeDate)
                        )
                        {
                            int dischrgDays = (dischargeDate - arrivalDate).Days + 1;
                            dt.Rows[0]["DISCHRGDAYS"] = dischrgDays;
                        }
                        if (
                            DateTime.TryParseExact(arrival, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out arrivalDate) &&
                            DateTime.TryParseExact(strDate, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out targetDate)
                        )
                        {
                            int prsntDays = (targetDate - arrivalDate).Days + 1;
                            dt.Rows[0]["PRSNTDAYS"] = prsntDays;
                        }
                        if (dt.Rows[0]["ARRIVALDT"].ToString().Trim() != "" && dt.Rows[0]["TMOFARRIVAL"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["ARRIVALDT"] = dt.Rows[0]["ARRIVALDT"].ToString().Trim() + "   " + dt.Rows[0]["TMOFARRIVAL"].ToString().Trim();
                        }
                        Dictionary<string, string> PastHistName = new Dictionary<string, string>
                            {
                                { "HYPTENSYN", "Hypertension" },
                                { "TUBERCULYN", "Tuberculosis" },
                                { "DIABETMELTUYN", "Diabetes Mellitus" },
                                { "BLEEDISYN", "Bleeding Disorder" },
                                { "ASTHMAYN", "Asthma" },
                                { "RENALDISYN", "Renal Disease" },
                                { "STROKEYN", "Stroke" },
                                { "HEARTDISYN", "Heart Disease" }
                            };
                        List<string> presentPastHist = new List<string>();
                        foreach (var kvp in PastHistName)
                        {
                            string colName = kvp.Key;
                            string PstHistName = kvp.Value;
                            if (dt.Columns.Contains(colName) && dt.Rows[0][colName].ToString().Trim().ToUpper() == "Y")
                            {
                                presentPastHist.Add(PstHistName);
                            }
                        }
                        if (!dt.Columns.Contains("PASTHIST"))
                            dt.Columns.Add("PASTHIST");
                        dt.Rows[0]["PASTHIST"] = string.Join(", ", presentPastHist);
                        dt.Columns.Add("REPORTTYPE");
                        dt.Rows[0]["REPORTTYPE"] = IsbarType;
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable CASEDET = new DataTable();
                        CASEDET.TableName = "CASEDET";
                        CASEDET.Columns.Add("CASEOF");
                        CASEDET.Columns.Add("COMPLAINT");
                        CASEDET.Columns.Add("SURGNAME");
                        CASEDET.Columns.Add("SURGDATE");
                        CASEDET.Columns.Add("POSTOPDAYS");
                        CASEDET.Columns.Add("PASTHISTORY");
                        CASEDET.Columns.Add("DIAGNOSIS");
                        CASEDET.Columns.Add("PROVDIAG");
                        CASEDET.Columns.Add("WEIGHT");
                        CASEDET.Columns.Add("HEIGHT");
                        CASEDET.Columns.Add("BMI");
                        CASEDET.Columns.Add("EF");
                        CASEDET.Columns.Add("REPORTTYPE");
                        CASEDET.Columns.Add("DISCHRGDAYS");
                        CASEDET.Columns.Add("PRSNTDAYS");
                        CASEDET.Columns.Add("ARRIVALDT");
                        CASEDET.Columns.Add("TMOFARRIVAL");
                        CASEDET.Columns.Add("DISCHRGDT");
                        CASEDET.Columns.Add("VULNRBLYN");
                        CASEDET.Columns.Add("IDBANDYN");
                        CASEDET.Columns.Add("PASTHIST");
                        CASEDET.Columns.Add("OTHPASTHISDET");
                        dsFinalForPrint.Tables.Add(CASEDET);
                    }
                    if (load.Tables.Contains("DIET") && load.Tables["DIET"].Rows.Count > 0)
                    {

                        List<SelectListItem> NutriIntakelist = GeneralFunction.GetNutritionIntakeList();
                        dt = load.Tables["DIET"];
                        foreach (DataRow row in dt.Rows)
                        {
                            row["INTMNURT"] = GeneralFunction.GetListValue(NutriIntakelist, row["INTMNURT"].ToString().Trim());
                        }
                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable ALLERGYDET = new DataTable();
                        ALLERGYDET.TableName = "DIET";
                        ALLERGYDET.Columns.Add("INTMNURT");
                        dsFinalForPrint.Tables.Add(ALLERGYDET);
                    }

                    if (load.Tables.Contains("ALLERGYDET") && load.Tables["ALLERGYDET"].Rows.Count > 0)
                    {
                        string strAllergy = "";
                        foreach (DataRow row in load.Tables["ALLERGYDET"].Rows)
                        {
                            strAllergy = strAllergy + "," + row["ALLERGYDESC"].ToString();
                        }
                        strAllergy = strAllergy.Remove(0, 1);
                        dt = load.Tables["ALLERGYDET"];
                        dt.Rows.Clear();
                        DataRow dr = dt.NewRow();
                        dr["ALLERGYDESC"] = strAllergy;
                        dt.Rows.Add(dr);
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable ALLERGYDET = new DataTable();
                        ALLERGYDET.TableName = "ALLERGYDET";
                        ALLERGYDET.Columns.Add("ALLERGYDESC");
                        dsFinalForPrint.Tables.Add(ALLERGYDET);

                    }
                    if (load.Tables.Contains("ISBARDET") && load.Tables["ISBARDET"].Rows.Count > 0)
                    {
                        List<SelectListItem> physioList = GeneralFunction.GetPhysiotherapyList();
                        dt = load.Tables["ISBARDET"];
                        dt.Rows[0]["IFDATE"] = GeneralFunction.GetDate(dt.Rows[0]["IFDATE"].ToString());
                        foreach (DataRow row in dt.Rows)
                        {
                            row["PHYSIOTHRPY"] = GeneralFunction.GetListValue(physioList, row["PHYSIOTHRPY"].ToString().Trim());


                        }
                        dt.Rows[0]["CREATEDAT"] = strDate + "  " + GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["CREATEDAT"].ToString().Trim());
                        if (dt.Rows[0]["ANTIBIOTICYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["ANTIBIOTICYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["ANTIBIOTICYN"].ToString() == "N")
                        {
                            dt.Rows[0]["ANTIBIOTICYN"] = "No";
                        }
                        if (dt.Rows[0]["INJECTTAB"].ToString() == "I")
                        {
                            dt.Rows[0]["INJECTTAB"] = "Injection";
                        }
                        else if (dt.Rows[0]["INJECTTAB"].ToString() == "T")
                        {
                            dt.Rows[0]["INJECTTAB"] = "Tablets";
                        }
                        if (dt.Rows[0]["EDEMAYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["EDEMAYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["EDEMAYN"].ToString() == "N")
                        {
                            dt.Rows[0]["EDEMAYN"] = "No";
                        }
                        if (dt.Rows[0]["DRESSINGYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["DRESSINGYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["DRESSINGYN"].ToString() == "N")
                        {
                            dt.Rows[0]["DRESSINGYN"] = "No";
                        }
                        if (dt.Rows[0]["GENCONDI"].ToString() == "S")
                        {
                            dt.Rows[0]["GENCONDI"] = "Stable";
                        }
                        else if (dt.Rows[0]["GENCONDI"].ToString() == "U")
                        {
                            dt.Rows[0]["GENCONDI"] = "Unstable";
                        }
                        else if (dt.Rows[0]["GENCONDI"].ToString() == "O")
                        {
                            dt.Rows[0]["GENCONDI"] = "Other :";
                        }
                        if (dt.Rows[0]["HANDOVERTYPE"].ToString().Trim() == "S")
                        {
                            dt.Rows[0]["HANDOVERTYPE"] = "Shift-wise handover ";
                        }
                        else if (dt.Rows[0]["HANDOVERTYPE"].ToString().Trim() == "T")
                        {
                            dt.Rows[0]["HANDOVERTYPE"] = "Transfer handover";
                        }
                        List<UserLstItem> userLst = null;
                        userLst = common.GetUserList().ToList();
                        if (dt.Rows[0]["RECEIVNGSTAFF"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["RECEIVNGSTAFF"] = GeneralFunction.GetListValue(userLst, dt.Rows[0]["RECEIVNGSTAFF"].ToString().Trim()) + " (" + dt.Rows[0]["RECEIVNGSTAFF"].ToString().Trim() + ")";
                        }
                        if (dt.Rows[0]["RECEIVINGDR"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["RECEIVINGDR"] = GeneralFunction.GetListValue(userLst, dt.Rows[0]["RECEIVINGDR"].ToString().Trim()) + " (" + dt.Rows[0]["RECEIVINGDR"].ToString().Trim() + ")";
                        }

                        //dt = load.Tables["CASEDET2"];
                        Dictionary<string, string> IVCAN = new Dictionary<string, string>
                                {
                                    { "ETTUBEYN", "ET Tube" },
                                    { "RTYN", "RT" },
                                    { "CUPYN", "CVP" },
                                    { "ARTLNEYN", "Arterial Line" },
                                    { "HDCTHETRYN", "HD Catheter" },
                                    { "PICCLINE", "PICC Line" },
                                    { "CHEMOPORT", "Chemo Port" },
                                    { "PERIPHLINE", "Peripheral Line" }

                                };

                        List<string> IVLIST = new List<string>();

                        foreach (var kvp in IVCAN)
                        {
                            string colName = kvp.Key;
                            string deviceName = kvp.Value;

                            if (dt.Columns.Contains(colName) && dt.Rows[0][colName].ToString().Trim().ToUpper() == "Y")
                            //if (dt.Columns.Contains(colName) && dt.Rows[0][colName]?.ToString().Trim().ToUpper() == "Y")
                            {
                                IVLIST.Add(deviceName);
                            }
                        }

                        if (IVLIST.Count == 0)
                        {
                            dt.Rows[0]["ETTUBEYN"] = "--";
                        }
                        else
                        {
                            dt.Rows[0]["ETTUBEYN"] = string.Join(", ", IVLIST);
                        }
                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable ISBARDET = new DataTable();
                        ISBARDET.TableName = "ISBARDET";
                        ISBARDET.Columns.Add("IFDATE");
                        ISBARDET.Columns.Add("IFTIME");
                        ISBARDET.Columns.Add("THROMB");
                        ISBARDET.Columns.Add("PREULCER");
                        ISBARDET.Columns.Add("TRACTNYN");
                        ISBARDET.Columns.Add("CRITICALVAL");
                        ISBARDET.Columns.Add("SPLINSTRUCT");
                        ISBARDET.Columns.Add("PHYSIOTHRPY");
                        ISBARDET.Columns.Add("PNDNGVOUCHER");
                        ISBARDET.Columns.Add("PNDNGREPORT");
                        ISBARDET.Columns.Add("INVESTIGATN");
                        ISBARDET.Columns.Add("PNDNGINDENT");
                        ISBARDET.Columns.Add("REFERRAL");
                        ISBARDET.Columns.Add("PHYSIOOTHER");
                        ISBARDET.Columns.Add("DRAINOTHR");
                        ISBARDET.Columns.Add("INVASVOETHR");
                        ISBARDET.Columns.Add("HANDNGSTAFF");
                        ISBARDET.Columns.Add("RECEIVNGSTAFF");
                        ISBARDET.Columns.Add("ETTUBEYN");
                        ISBARDET.Columns.Add("CUPYN");
                        ISBARDET.Columns.Add("ARTLNEYN");
                        ISBARDET.Columns.Add("RTYN");
                        ISBARDET.Columns.Add("ICDYN");
                        ISBARDET.Columns.Add("SELFVOIDYN");
                        ISBARDET.Columns.Add("URNRYCTHETRYN");
                        ISBARDET.Columns.Add("CNDOMCTHETRYN");
                        ISBARDET.Columns.Add("HDCTHETRYN");
                        ISBARDET.Columns.Add("ABDOMINALYN");
                        ISBARDET.Columns.Add("PRPYN");
                        ISBARDET.Columns.Add("PRRYN");
                        ISBARDET.Columns.Add("MLC");
                        ISBARDET.Columns.Add("OTHREMARK");
                        ISBARDET.Columns.Add("SPECNEED");
                        ISBARDET.Columns.Add("HANDOVERDR");
                        ISBARDET.Columns.Add("RECEIVINGDR");
                        ISBARDET.Columns.Add("ANTIBIOTICYN");

                        ISBARDET.Columns.Add("ANTIBITICDAYS");
                        ISBARDET.Columns.Add("INJECTTAB");
                        ISBARDET.Columns.Add("EDEMAYN");
                        ISBARDET.Columns.Add("EDEMASITE");
                        ISBARDET.Columns.Add("DRESSINGYN");
                        ISBARDET.Columns.Add("DRESSINGTM");
                        ISBARDET.Columns.Add("MEDICSHEET");
                        ISBARDET.Columns.Add("BLOODTRANSF");
                        ISBARDET.Columns.Add("CONSULTDUE");
                        ISBARDET.Columns.Add("PLNOFDAY");
                        ISBARDET.Columns.Add("ISBARREMARK");
                        ISBARDET.Columns.Add("GENCONDI");
                        ISBARDET.Columns.Add("INVESTIGATNYN");
                        ISBARDET.Columns.Add("PNDNGREPORTYN");
                        ISBARDET.Columns.Add("CREATEDAT");
                        ISBARDET.Columns.Add("HANDOVERTYPE");
                        ISBARDET.Columns.Add("CREATEDBY");
                        ISBARDET.Columns.Add("INVASVOTHR");
                        dsFinalForPrint.Tables.Add(ISBARDET);
                    }

                    if (load.Tables.Contains("OTHNSDET") && load.Tables["OTHNSDET"].Rows.Count > 0)
                    {
                        List<SelectListItem> dietList = GeneralFunction.GetDietList();
                        List<SelectListItem> IsoPrectnList = GeneralFunction.GetIsolationPrecautionList();
                        dt = load.Tables["OTHNSDET"];
                        foreach (DataRow row in dt.Rows)
                        {
                            // row["DIET"] = dietList.Where(X => X.Value == ("" + row["DIET"]).Trim()).Count() == 0 ? "" : dietList.Where(X => X.Value == row["DIET"].ToString().Trim()).FirstOrDefault().Text;
                            row["DIET"] = GeneralFunction.GetListValue(dietList, row["DIET"].ToString().Trim());

                            if (dt.Rows[0]["DIET"].ToString().Trim() == "Others")
                                row["DIET"] = "";

                            row["ISOPRECTN"] = GeneralFunction.GetListValue(IsoPrectnList, row["ISOPRECTN"].ToString().Trim());
                        }
                        if (dt.Rows[0]["MOBILISTN"].ToString() == "M")
                        {
                            dt.Rows[0]["MOBILISTN"] = "Mobilised";
                        }
                        else if (dt.Rows[0]["MOBILISTN"].ToString() == "C")
                        {
                            dt.Rows[0]["MOBILISTN"] = "Chair Rest";
                        }
                        else if (dt.Rows[0]["MOBILISTN"].ToString() == "B")
                        {
                            dt.Rows[0]["MOBILISTN"] = "Bed Rest";
                        }

                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable OTHNSDET = new DataTable();
                        OTHNSDET.TableName = "OTHNSDET";
                        OTHNSDET.Columns.Add("SURGSITE");
                        OTHNSDET.Columns.Add("WOUND");
                        OTHNSDET.Columns.Add("DIET");
                        OTHNSDET.Columns.Add("DIETOTHR");
                        OTHNSDET.Columns.Add("MOBILISTN");
                        OTHNSDET.Columns.Add("ISOPRECTN");
                        dsFinalForPrint.Tables.Add(OTHNSDET);
                    }

                    if (load.Tables.Contains("SCALEDET") && load.Tables["SCALEDET"].Rows.Count > 0)
                    {
                        dt = load.Tables["SCALEDET"];
                        if (dt.Rows[0]["DVTPROPHYLAXS"].ToString() == "C")
                        {
                            dt.Rows[0]["DVTPROPHYLAXS"] = "Chemical";
                        }
                        else if (dt.Rows[0]["DVTPROPHYLAXS"].ToString() == "M")
                        {
                            dt.Rows[0]["DVTPROPHYLAXS"] = "Mechanical";
                        }
                        else if (dt.Rows[0]["DVTPROPHYLAXS"].ToString() == "B")
                        {
                            dt.Rows[0]["DVTPROPHYLAXS"] = "Mechanical & Chemical";
                        }
                        if (dt.Rows[0]["INTACTYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["INTACTYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["INTACTYN"].ToString() == "N")
                        {
                            dt.Rows[0]["INTACTYN"] = "No";
                        }
                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable SCALEDET = new DataTable();
                        SCALEDET.TableName = "SCALEDET";
                        SCALEDET.Columns.Add("BRADENSCALE");
                        SCALEDET.Columns.Add("PAINSCORE");
                        SCALEDET.Columns.Add("DVTPROPHYLAXS");
                        SCALEDET.Columns.Add("INTACTYN");
                        SCALEDET.Columns.Add("INTACT");
                        SCALEDET.Columns.Add("FALLRISKSCORE");
                        SCALEDET.Columns.Add("PAINLOCATION");
                        dsFinalForPrint.Tables.Add(SCALEDET);
                    }

                    if (load.Tables.Contains("CLINICALDET") && load.Tables["CLINICALDET"].Rows.Count > 0)
                    {
                        // List<SelectListItem> O2DeliverdList = GeneralFunction.GetO2deliveredbyList();
                        dt = load.Tables["CLINICALDET"];
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["O2DELIVERD"] = O2DeliverdList.Where(X => X.Value == ("" + row["O2DELIVERD"]).Trim()).Count() == 0 ? "" : 
                            //    O2DeliverdList.Where(X => X.Value == row["O2DELIVERD"].ToString().Trim()).FirstOrDefault().Text;
                            // row["O2DELIVERD"] = GeneralFunction.GetListValue(O2DeliverdList, row["O2DELIVERD"].ToString().Trim());

                        }
                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable CLINICALDET = new DataTable();
                        CLINICALDET.TableName = "CLINICALDET";
                        CLINICALDET.Columns.Add("BOWLDOPNYN");
                        CLINICALDET.Columns.Add("GCS");
                        CLINICALDET.Columns.Add("BOWOPNREMARK");
                        dsFinalForPrint.Tables.Add(CLINICALDET);
                    }

                    DataTable ioTable = load.Tables.Contains("IO") ? load.Tables["IO"].Copy() : null;
                    DataTable finalIO = new DataTable("IO");

                    finalIO.Columns.Add("IP");
                    finalIO.Columns.Add("OP");

                    DataRow newRow = finalIO.NewRow();

                    if (ioTable != null && ioTable.Rows.Count > 0)
                    {
                        foreach (DataRow row in ioTable.Rows)
                        {
                            string desc = row["INFUSNDESC"].ToString().Trim();
                            string val = row["value"].ToString().Trim();

                            if (desc.Equals("IP", StringComparison.OrdinalIgnoreCase))
                                newRow["IP"] = val;
                            else if (desc.Equals("OP", StringComparison.OrdinalIgnoreCase))
                                newRow["OP"] = val;
                        }
                    }
                    if (newRow["IP"] == DBNull.Value || string.IsNullOrEmpty(newRow["IP"].ToString()))
                        newRow["IP"] = "0";
                    if (newRow["OP"] == DBNull.Value || string.IsNullOrEmpty(newRow["OP"].ToString()))
                        newRow["OP"] = "0";
                    finalIO.Rows.Add(newRow);
                    dsFinalForPrint.Tables.Add(finalIO);

                    //if (load.Tables.Contains("IO"))
                    //{
                    //    dt = load.Tables["IO"];

                    //    dsFinalForPrint.Tables.Add(dt.Copy());
                    //}
                    //else
                    //{
                    //    DataTable IO = new DataTable();
                    //    IO.TableName = "IO";
                    //    IO.Columns.Add("OP");
                    //    IO.Columns.Add("IP");
                    //    DataRow dr = IO.NewRow();
                    //    dr["OP"] = "0";
                    //    dr["IP"] = "0";
                    //    IO.Rows.Add(dr);
                    //    dsFinalForPrint.Tables.Add(IO);
                    //}
                    if (load.Tables.Contains("CRITIALCARE1") && load.Tables["CRITIALCARE1"].Rows.Count > 0)
                    {
                        List<SelectListItem> O2DeliverdList = GeneralFunction.GetO2deliveredbyList();
                        dt = load.Tables["CRITIALCARE1"];
                        foreach (DataRow row in dt.Rows)
                        {
                            row["O2DELIVERD"] = O2DeliverdList.Where(X => X.Value == ("" + row["O2DELIVERD"]).Trim()).Count() == 0 ? "" :
                               O2DeliverdList.Where(X => X.Value == row["O2DELIVERD"].ToString().Trim()).FirstOrDefault().Text;
                            // row["O2DELIVERD"] = GeneralFunction.GetListValue(O2DeliverdList, row["O2DELIVERD"].ToString().Trim());

                        }
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable CRITIALCARE1 = new DataTable();
                        CRITIALCARE1.TableName = "CRITIALCARE1";
                        CRITIALCARE1.Columns.Add("PERIPHRAL");
                        CRITIALCARE1.Columns.Add("ORAL");
                        CRITIALCARE1.Columns.Add("RECTAL");
                        CRITIALCARE1.Columns.Add("PACEDRT");
                        CRITIALCARE1.Columns.Add("PATINTRNSCRT");
                        CRITIALCARE1.Columns.Add("NIBPSYS");
                        CRITIALCARE1.Columns.Add("IBPSYS");
                        CRITIALCARE1.Columns.Add("IABPSYS");
                        CRITIALCARE1.Columns.Add("PAP");
                        CRITIALCARE1.Columns.Add("CVP");
                        CRITIALCARE1.Columns.Add("PWP");
                        CRITIALCARE1.Columns.Add("LAPPWP");
                        CRITIALCARE1.Columns.Add("NIBPDIA");
                        CRITIALCARE1.Columns.Add("IBPDIA");
                        CRITIALCARE1.Columns.Add("IABPDIA");
                        CRITIALCARE1.Columns.Add("O2DELIVERD");
                        CRITIALCARE1.Columns.Add("SPO2");
                        CRITIALCARE1.Columns.Add("HGT");
                        CRITIALCARE1.Columns.Add("RR");
                        CRITIALCARE1.Columns.Add("OXYFLOWRT");
                        dsFinalForPrint.Tables.Add(CRITIALCARE1);
                    }
                    if (load.Tables.Contains("Table10") && load.Tables["Table10"].Rows.Count > 0)
                    {
                        dt = load.Tables["Table10"].Copy();
                        dt.TableName = "PERIBUNDLE";
                        dsFinalForPrint.Tables.Add(dt);
                    }
                    else
                    {
                        DataTable periBundleTable = new DataTable("PERIBUNDLE");
                        periBundleTable.Columns.Add("VALUE");
                        dsFinalForPrint.Tables.Add(periBundleTable);
                    }

                    obj[0] = JsonConvert.SerializeObject(load.Tables[0]);
                    HData = GeneralFunction.getHeaderFooter("ISBAR", "", "", "");


                    HData.TableName = "HeaderFooter";
                    dsFinalForPrint.Tables.Add(HData);


                    DataTable dt1 = new DataTable();
                    dt1.TableName = "PatInfo";
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("IPNO");
                        dt1.Columns.Add("MRNO");
                        dt1.Columns.Add("ADMNDATE");
                        dt1.Columns.Add("PATNAME");
                        dt1.Columns.Add("ADMNTIME");
                        dt1.Columns.Add("Gender");
                        dt1.Columns.Add("PATAGE");
                        dt1.Columns.Add("CONSDOCT");
                        dt1.Columns.Add("SALUNAME");
                        dt1.Columns.Add("CURRBEDNO");
                        dt1.Columns.Add("WARDNM");
                        dt1.Columns.Add("NURSTNM");
                        dt1.Columns.Add("DATE");
                        dt1.Columns.Add("TIME");
                        dt1.Columns.Add("CNAME");
                        dt1.Columns.Add("TOMOROWDATE");
                        dt1.Columns.Add("MLCYORN");
                        DataRow patRow = dt1.NewRow();
                        patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                        patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                        patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                        patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                        patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                        patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                        patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                        patRow["DATE"] = GeneralFunction.GetDate(strDate);
                        patRow["TIME"] = strTime;
                        patRow["CNAME"] = CounterName;
                        patRow["TOMOROWDATE"] = "";
                        dt1.Rows.Add(patRow);
                    }
                    dsFinalForPrint.Tables.Add(dt1);
                }
            }

            foreach (DataTable table in dsFinalForPrint.Tables)
            {
                if (table.Rows.Count == 0)
                {
                    DataRow emptyRow = table.NewRow();
                    foreach (DataColumn col in table.Columns)
                    {
                        emptyRow[col] = (object)"";  // Assign "--" regardless of data type
                    }
                    table.Rows.Add(emptyRow);
                }
            }
            return dsFinalForPrint;

        }

        public DataSet GetNursNotePrint(string strIPNo, string strDate, string strTime, string CounterName)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            DataTable HData = new DataTable();

            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetNursNotePrint(strIPNo, strDate, strTime))));
            object[] objData = new object[1];
            if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            {
                objData[0] = "No Data Found";
            }
            object[] obj = new object[1];
            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    if (load.Tables.Contains("NSCLINICALDET"))
                    {

                        List<SelectListItem> LOCList = GeneralFunction.GetLevelOfConciousnessList();
                        dt = load.Tables["NSCLINICALDET"];
                        foreach (DataRow row in dt.Rows)
                        {


                            row["CONCIUSLEVEL"] = GeneralFunction.GetListValue(LOCList, row["CONCIUSLEVEL"].ToString().Trim());

                        }
                        dt = load.Tables["NSCLINICALDET"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NSCLINICALDET = new DataTable();
                        NSCLINICALDET.TableName = "NSCLINICALDET";
                        NSCLINICALDET.Columns.Add("TIMEYN");
                        NSCLINICALDET.Columns.Add("PLACEYN");
                        NSCLINICALDET.Columns.Add("PERSONYN");
                        NSCLINICALDET.Columns.Add("CONCIUSLEVEL");
                        NSCLINICALDET.Columns.Add("LEVELOTHER");
                        NSCLINICALDET.Columns.Add("BOWLDOPNYN");
                        NSCLINICALDET.Columns.Add("BOWOPNREMARK");
                        NSCLINICALDET.Columns.Add("GCSSCORE");
                        dsFinalForPrint.Tables.Add(NSCLINICALDET);
                    }
                    if (load.Tables.Contains("NSOTHNSDET"))
                    {
                        List<SelectListItem> IsoPrectnList = GeneralFunction.GetIsolationPrecautionList();
                        List<SelectListItem> dietList = GeneralFunction.GetDietList();
                        List<UserLstItem> userLst = comclient.GetUserList().ToList();
                        dt = load.Tables["NSOTHNSDET"];

                        if (dt.Rows[0]["ISOTYPE"].ToString() == "P")
                        {
                            dt.Rows[0]["ISOTYPE"] = "Positive";
                        }
                        else if (dt.Rows[0]["ISOTYPE"].ToString() == "N")
                        {
                            dt.Rows[0]["ISOTYPE"] = "Negative";
                        }
                        if (dt.Rows[0]["APPETITE"].ToString() == "G")
                        {
                            dt.Rows[0]["APPETITE"] = "Good";
                        }
                        else if (dt.Rows[0]["APPETITE"].ToString() == "A")
                        {
                            dt.Rows[0]["APPETITE"] = "Average";
                        }
                        else if (dt.Rows[0]["APPETITE"].ToString() == "P")
                        {
                            dt.Rows[0]["APPETITE"] = "Poor";
                        }

                        if (dt.Rows[0]["ACTIVITY"].ToString() == "I")
                        {
                            dt.Rows[0]["ACTIVITY"] = "Independent";
                        }
                        else if (dt.Rows[0]["ACTIVITY"].ToString() == "P")
                        {
                            dt.Rows[0]["ACTIVITY"] = "Partially Dependent";
                        }
                        else if (dt.Rows[0]["ACTIVITY"].ToString() == "F")
                        {
                            dt.Rows[0]["ACTIVITY"] = "Fully Dependent";
                        }

                        if (dt.Rows[0]["MOBILISTN"].ToString() == "B")
                        {
                            dt.Rows[0]["MOBILISTN"] = "Bedrest";
                        }
                        else if (dt.Rows[0]["MOBILISTN"].ToString() == "C")
                        {
                            dt.Rows[0]["MOBILISTN"] = "Chairrest";
                        }
                        else if (dt.Rows[0]["MOBILISTN"].ToString() == "M")
                        {
                            dt.Rows[0]["MOBILISTN"] = "Mobilised";
                        }

                        foreach (DataRow row in dt.Rows)
                        {
                            //row["ISOPRECTN"] = IsoPrectnList.Where(X => X.Value == ("" + row["ISOPRECTN"]).Trim()).Count() == 0 ? "" : IsoPrectnList.Where(X => X.Value == row["ISOPRECTN"].ToString().Trim()).FirstOrDefault().Text;
                            //row["DIET"] = dietList.Where(X => X.Value == ("" + row["DIET"]).Trim()).Count() == 0 ? "" : dietList.Where(X => X.Value == row["DIET"].ToString().Trim()).FirstOrDefault().Text;

                            row["ISOPRECTN"] = GeneralFunction.GetListValue(IsoPrectnList, row["ISOPRECTN"].ToString().Trim());
                            row["DIET"] = GeneralFunction.GetListValue(dietList, row["DIET"].ToString().Trim());

                            if (dt.Rows[0]["DIET"].ToString().Trim() == "Others")
                                row["DIET"] = "";
                        }
                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NSOTHNSDET = new DataTable();
                        NSOTHNSDET.TableName = "NSOTHNSDET";
                        NSOTHNSDET.Columns.Add("FTDRAING");
                        NSOTHNSDET.Columns.Add("DIET");
                        NSOTHNSDET.Columns.Add("APPETITE");
                        NSOTHNSDET.Columns.Add("FTASPDONE");
                        NSOTHNSDET.Columns.Add("RTNGTYN");
                        NSOTHNSDET.Columns.Add("NJTYN");
                        NSOTHNSDET.Columns.Add("PEGYN");
                        NSOTHNSDET.Columns.Add("JTYN");
                        NSOTHNSDET.Columns.Add("ACTIVITY");
                        NSOTHNSDET.Columns.Add("MOBILISTN");
                        NSOTHNSDET.Columns.Add("BATHYN");
                        NSOTHNSDET.Columns.Add("ORALCARE");
                        NSOTHNSDET.Columns.Add("BACKCARE");
                        NSOTHNSDET.Columns.Add("PERINEAL");
                        NSOTHNSDET.Columns.Add("HAIRWASH");
                        NSOTHNSDET.Columns.Add("ISOPRECTN");
                        NSOTHNSDET.Columns.Add("ISOTYPE");
                        NSOTHNSDET.Columns.Add("DIETOTHR");
                        NSOTHNSDET.Columns.Add("SPONGEYN");
                        dsFinalForPrint.Tables.Add(NSOTHNSDET);
                    }

                    if (load.Tables.Contains("NSCRTCAREASS1"))
                    {
                        List<SelectListItem> physioList = GeneralFunction.GetPhysiotherapyList();
                        List<SelectListItem> O2DeliverdList = GeneralFunction.GetO2deliveredbyList();
                        dt = load.Tables["NSCRTCAREASS1"];
                        foreach (DataRow row in dt.Rows)
                        {

                            row["O2DELIVERD"] = GeneralFunction.GetListValue(O2DeliverdList, row["O2DELIVERD"].ToString().Trim());
                        }
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NSCRTCAREASS1 = new DataTable();
                        NSCRTCAREASS1.TableName = "NSCRTCAREASS1";
                        NSCRTCAREASS1.Columns.Add("PEDALPULSATN");
                        NSCRTCAREASS1.Columns.Add("IABPSYS");
                        NSCRTCAREASS1.Columns.Add("IBPSYS");
                        NSCRTCAREASS1.Columns.Add("NIBPSYS");
                        NSCRTCAREASS1.Columns.Add("PATINTRNSCRT");
                        NSCRTCAREASS1.Columns.Add("PACEDRT");
                        NSCRTCAREASS1.Columns.Add("RR");
                        NSCRTCAREASS1.Columns.Add("SPO2");
                        NSCRTCAREASS1.Columns.Add("O2DELIVERD");
                        NSCRTCAREASS1.Columns.Add("HGT");
                        dsFinalForPrint.Tables.Add(NSCRTCAREASS1);
                    }

                    if (load.Tables.Contains("NSSCALEDET"))
                    {
                        List<SelectListItem> SknCondtnList = GeneralFunction.GetSkinConditionList();
                        List<SelectListItem> SknColorList = GeneralFunction.GetSkinColorList();
                        dt = load.Tables["NSSCALEDET"];
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["SKINCONDTN"] = SknCondtnList.Where(X => X.Value == ("" + row["SKINCONDTN"]).Trim()).Count() == 0 ? "" : SknCondtnList.Where(X => X.Value == row["SKINCONDTN"].ToString().Trim()).FirstOrDefault().Text;
                            //row["SKINCOLOR"] = SknColorList.Where(X => X.Value == ("" + row["SKINCOLOR"]).Trim()).Count() == 0 ? "" : SknColorList.Where(X => X.Value == row["SKINCOLOR"].ToString().Trim()).FirstOrDefault().Text;

                            row["SKINCONDTN"] = GeneralFunction.GetListValue(SknCondtnList, row["SKINCONDTN"].ToString().Trim());
                            row["SKINCOLOR"] = GeneralFunction.GetListValue(SknColorList, row["SKINCOLOR"].ToString().Trim());
                        }
                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NSSCALEDET = new DataTable();
                        NSSCALEDET.TableName = "NSSCALEDET";
                        NSSCALEDET.Columns.Add("SKINCONDTN");
                        NSSCALEDET.Columns.Add("SKINCOLOR");
                        NSSCALEDET.Columns.Add("FALLRISKYN");
                        NSSCALEDET.Columns.Add("BRADENSCALE");
                        NSSCALEDET.Columns.Add("PAINSCORE");
                        NSSCALEDET.Columns.Add("INTACTYN");
                        NSSCALEDET.Columns.Add("INTACT");
                        NSSCALEDET.Columns.Add("FALLRISKSCORE");
                        NSSCALEDET.Columns.Add("BRADENREMARK");
                        NSSCALEDET.Columns.Add("PAINREMARK");
                        NSSCALEDET.Columns.Add("FALLRISKREMARK");
                        NSSCALEDET.Columns.Add("DVTSCORE");
                        NSSCALEDET.Columns.Add("ECOGSCORE");
                        dsFinalForPrint.Tables.Add(NSSCALEDET);
                    }

                    if (load.Tables.Contains("NSISBARDET"))
                    {
                        dt = load.Tables["NSISBARDET"];

                        if (dt.Rows[0]["PRPYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["PRPYN"] = "Present";
                        }
                        else if (dt.Rows[0]["PRPYN"].ToString() == "N")
                        {
                            dt.Rows[0]["PRPYN"] = "Absent";
                        }
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NSISBARDET = new DataTable();
                        NSISBARDET.TableName = "NSISBARDET";
                        NSISBARDET.Columns.Add("URNRYCTHETRYN");
                        NSISBARDET.Columns.Add("SELFVOIDYN");
                        NSISBARDET.Columns.Add("CNDOMCTHETRYN");
                        NSISBARDET.Columns.Add("ETTUBEYN");
                        NSISBARDET.Columns.Add("RTYN");
                        NSISBARDET.Columns.Add("CUPYN");
                        NSISBARDET.Columns.Add("ARTLNEYN");
                        NSISBARDET.Columns.Add("HDCTHETRYN");
                        NSISBARDET.Columns.Add("INVASVOETHR");
                        NSISBARDET.Columns.Add("ICDYN");
                        NSISBARDET.Columns.Add("ABDOMINALYN");
                        NSISBARDET.Columns.Add("DRAINOTHR");
                        NSISBARDET.Columns.Add("PRPYN");
                        NSISBARDET.Columns.Add("PICCLINE");
                        NSISBARDET.Columns.Add("CHEMOPORT");
                        NSISBARDET.Columns.Add("PERIPHLINE");
                        dsFinalForPrint.Tables.Add(NSISBARDET);
                    }
                    //  obj[0] = JsonConvert.SerializeObject(load.Tables[0]);
                    HData = GeneralFunction.getHeaderFooter("Other Nursing Assessment", "", "", "");


                    HData.TableName = "HeaderFooter";
                    dsFinalForPrint.Tables.Add(HData);
                    DataTable dt1 = new DataTable();
                    dt1.TableName = "PatInfo";
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("IPNO");
                        dt1.Columns.Add("MRNO");
                        dt1.Columns.Add("ADMNDATE");
                        dt1.Columns.Add("PATNAME");
                        dt1.Columns.Add("ADMNTIME");
                        dt1.Columns.Add("Gender");
                        dt1.Columns.Add("PATAGE");
                        dt1.Columns.Add("CONSDOCT");
                        dt1.Columns.Add("SALUNAME");
                        dt1.Columns.Add("WARDNM");
                        dt1.Columns.Add("NURSTNM");
                        dt1.Columns.Add("CURRBEDNO");
                        dt1.Columns.Add("DATE");
                        dt1.Columns.Add("TIME");
                        dt1.Columns.Add("CNAME");
                        DataRow patRow = dt1.NewRow();
                        patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                        patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                        patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                        patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                        patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                        patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                        patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                        patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                        patRow["DATE"] = GeneralFunction.GetDate(strDate);
                        patRow["TIME"] = strTime;
                        patRow["CNAME"] = CounterName;
                        dt1.Rows.Add(patRow);
                    }
                    dsFinalForPrint.Tables.Add(dt1);
                }
            }
            foreach (DataTable dt1 in dsFinalForPrint.Tables)
            {
                if (dt1.Rows.Count == 0)
                {
                    DataRow dr = dt1.NewRow();
                    dt1.Rows.Add(dr);
                }
            }

            return dsFinalForPrint;
        }

        public DataSet GetRespiAssesPrint(string strIPNo, string strDate)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            DateTime todate = DateTime.ParseExact(strDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            todate = todate.AddDays(1);
            string strtodt = todate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);

            DataTable HData = new DataTable();
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetRespiAssesPrint(strIPNo, strDate))));
            object[] objData = new object[1];
            if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            {
                objData[0] = "No Data Found";
            }
            object[] obj = new object[1];
            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    // var DATE = load.Tables[0].Rows[0]["IFDATE"].ToString();
                    //load.Tables[0].Rows[0]["IFDATE"] = GeneralFunction.GetDate(DATE);
                    if (load.Tables.Contains("RESPIRATORY"))
                    {
                        dt = load.Tables["RESPIRATORY"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable RESPIRATORY = new DataTable();
                        RESPIRATORY.TableName = "RESPIRATORY";
                        RESPIRATORY.Columns.Add("DESC");

                        RESPIRATORY.Columns.Add("7 AM");
                        RESPIRATORY.Columns.Add("8 AM");
                        RESPIRATORY.Columns.Add("9 AM");
                        RESPIRATORY.Columns.Add("10 AM");
                        RESPIRATORY.Columns.Add("11 AM");
                        RESPIRATORY.Columns.Add("12 PM");
                        RESPIRATORY.Columns.Add("1 PM");
                        RESPIRATORY.Columns.Add("2 PM");
                        RESPIRATORY.Columns.Add("3 PM");
                        RESPIRATORY.Columns.Add("4 PM");
                        RESPIRATORY.Columns.Add("5 PM");
                        RESPIRATORY.Columns.Add("6 PM");
                        RESPIRATORY.Columns.Add("7 PM");
                        RESPIRATORY.Columns.Add("8 PM");
                        RESPIRATORY.Columns.Add("9 PM");
                        RESPIRATORY.Columns.Add("10 PM");
                        RESPIRATORY.Columns.Add("11 PM");
                        RESPIRATORY.Columns.Add("12 AM");
                        RESPIRATORY.Columns.Add("1 AM");
                        RESPIRATORY.Columns.Add("2 AM");
                        RESPIRATORY.Columns.Add("3 AM");
                        RESPIRATORY.Columns.Add("4 AM");
                        RESPIRATORY.Columns.Add("5 AM");
                        RESPIRATORY.Columns.Add("6 AM");
                        dsFinalForPrint.Tables.Add(RESPIRATORY);
                    }

                    if (load.Tables.Contains("CASEDET"))
                    {
                        dt = load.Tables["CASEDET"];

                        dt.Rows[0]["SURGDATE"] = GeneralFunction.GetDate(dt.Rows[0]["SURGDATE"].ToString());

                        if (dt.Rows[0]["POSTOPDAYS"].ToString().Trim() != "")
                        {
                            dt.Rows[0]["POSTOPDAYS"] = GeneralFunction.calPostOperDays(dt.Rows[0]["SURGDATE"].ToString(), strDate);
                        }
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable CASEDET = new DataTable();
                        CASEDET.TableName = "CASEDET";
                        CASEDET.Columns.Add("DIAGNOSIS");
                        CASEDET.Columns.Add("WEIGHT");
                        CASEDET.Columns.Add("HEIGHT");
                        CASEDET.Columns.Add("POSTOPDAYS");
                        CASEDET.Columns.Add("BMI");
                        CASEDET.Columns.Add("EF");
                        CASEDET.Columns.Add("SURGNAME");
                        dsFinalForPrint.Tables.Add(CASEDET);
                    }

                    if (load.Tables.Contains("ICUDAYS"))
                    {
                        dt = load.Tables["ICUDAYS"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable DTICUDAYS = new DataTable();
                        DTICUDAYS.TableName = "ICUDAYS";
                        DTICUDAYS.Columns.Add("BEDNUMBER");
                        DTICUDAYS.Columns.Add("ICUDAYS");
                        DTICUDAYS.Columns.Add("PATAGE");
                        DTICUDAYS.Columns.Add("WARNNAME");
                        DTICUDAYS.Columns.Add("NURSSTNNAME");
                        dsFinalForPrint.Tables.Add(DTICUDAYS);
                    }


                    HData = GeneralFunction.getHeaderFooter("Respiratory Assessment", "", "", "");

                    HData.TableName = "HeaderFooter";
                    dsFinalForPrint.Tables.Add(HData);
                    DataTable dt1 = new DataTable();
                    dt1.TableName = "PatInfo";
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("IPNO");
                        dt1.Columns.Add("MRNO");
                        dt1.Columns.Add("ADMNDATE");
                        dt1.Columns.Add("PATNAME");
                        dt1.Columns.Add("ADMNTIME");
                        dt1.Columns.Add("Gender");
                        dt1.Columns.Add("PATAGE");
                        dt1.Columns.Add("CONSDOCT");
                        dt1.Columns.Add("SALUNAME");
                        dt1.Columns.Add("CURRBEDNO");
                        dt1.Columns.Add("WARDNM");
                        dt1.Columns.Add("NURSTNM");
                        dt1.Columns.Add("DATE");
                        dt1.Columns.Add("TOMOROWDATE");

                        DataRow patRow = dt1.NewRow();
                        patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                        patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                        patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                        patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                        patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                        patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                        patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                        patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                        patRow["DATE"] = GeneralFunction.GetDate(strDate);
                        patRow["TOMOROWDATE"] = strtodt;
                        dt1.Rows.Add(patRow);
                    }
                    dsFinalForPrint.Tables.Add(dt1);
                }
            }
            return dsFinalForPrint;
        }

        public DataSet GetMaxTempList(string strIPNO)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNO, "", "", "", "", "", "", "", "", "", "", "", "", "");
            DataTable HData = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetMaxTempList(strIPNO))));
            object[] objData = new object[1];
            if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            {
                objData[0] = "No Data Found";
            }
            object[] obj = new object[1];
            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    load.Tables[0].TableName = "MAXTEMP";
                    if (load.Tables.Contains("MAXTEMP"))
                    {
                        dt = load.Tables["MAXTEMP"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    HData = GeneralFunction.getHeaderFooter("Max Temp", "", "", "");

                    HData.TableName = "HeaderFooter";
                    dsFinalForPrint.Tables.Add(HData);
                    DataTable dt1 = new DataTable();
                    dt1.TableName = "PatInfo";
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("IPNO");
                        dt1.Columns.Add("MRNO");
                        dt1.Columns.Add("ADMNDATE");
                        dt1.Columns.Add("PATNAME");
                        dt1.Columns.Add("ADMNTIME");
                        dt1.Columns.Add("Gender");
                        dt1.Columns.Add("PATAGE");
                        dt1.Columns.Add("CONSDOCT");
                        dt1.Columns.Add("SALUNAME");
                        dt1.Columns.Add("CURRBEDNO");
                        dt1.Columns.Add("WARDNM");
                        dt1.Columns.Add("NURSTNM");

                        DataRow patRow = dt1.NewRow();
                        patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                        patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                        patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                        patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                        patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                        patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                        patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                        patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                        dt1.Rows.Add(patRow);
                    }
                    dsFinalForPrint.Tables.Add(dt1);
                }
            }
            return dsFinalForPrint;
        }

        public DataSet GetNursngAss(string strIPNO)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNO, "", "", "", "", "", "", "", "", "", "", "", "", "");
            DataTable HData = new DataTable();
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetNursAssmntRptDet(strIPNO))));
            object[] objData = new object[1];
            if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
            {
                objData[0] = "No Data Found";
            }
            object[] obj = new object[1];
            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    load.Tables[0].TableName = "NACASEDET";
                    if (load.Tables.Contains("NACASEDET"))
                    {
                        dt = load.Tables["NACASEDET"];
                        if (dt.Rows[0]["PSYILLYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["PSYILLYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["PSYILLYN"].ToString() == "N")
                        {
                            dt.Rows[0]["PSYILLYN"] = "No";
                        }
                        if (dt.Rows[0]["RELTOLOVEONEYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["RELTOLOVEONEYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["RELTOLOVEONEYN"].ToString() == "N")
                        {
                            dt.Rows[0]["RELTOLOVEONEYN"] = "No";
                        }
                        if (dt.Rows[0]["CHNGINLIFEYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["CHNGINLIFEYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["CHNGINLIFEYN"].ToString() == "N")
                        {
                            dt.Rows[0]["CHNGINLIFEYN"] = "No";
                        }
                        if (dt.Rows[0]["LEARNDIFFYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["LEARNDIFFYN"] = "Yes";
                        }
                        else if (dt.Rows[0]["LEARNDIFFYN"].ToString() == "N")
                        {
                            dt.Rows[0]["LEARNDIFFYN"] = "No";
                        }
                        var occupatnLst = GeneralFunction.GetOccupationList();
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["OCCUPATION"] = occupatnLst.Where(X => X.Value == ("" + row["OCCUPATION"]).Trim()).Count() == 0 ? "" : occupatnLst.Where(X => X.Value == row["OCCUPATION"].ToString().Trim()).FirstOrDefault().Text;
                            row["OCCUPATION"] = GeneralFunction.GetListValue(occupatnLst, row["OCCUPATION"].ToString().Trim());

                        }
                        foreach (DataRow row in dt.Rows)
                        {
                            row["CREATEDON"] = GeneralFunction.GetUIDateFormat(row["CREATEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                        }

                        dt.Columns.Add("CASEDTLIMG", System.Type.GetType("System.Byte[]"));

                        dt = load.Tables["NACASEDET"];

                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NACASEDET = new DataTable();
                        NACASEDET.TableName = "NACASEDET";
                        NACASEDET.Columns.Add("OCCUPATION");
                        NACASEDET.Columns.Add("PSYILLYN");
                        NACASEDET.Columns.Add("PSYILLNESS");
                        NACASEDET.Columns.Add("RELTOLOVEONEYN");
                        NACASEDET.Columns.Add("RELTOLOVEONE");
                        NACASEDET.Columns.Add("CHNGINLIFEYN");
                        NACASEDET.Columns.Add("CHNGINLIFE");
                        NACASEDET.Columns.Add("LEARNDIFFYN");
                        NACASEDET.Columns.Add("LEARNDIFF");
                        NACASEDET.Columns.Add("WEIGHT");
                        NACASEDET.Columns.Add("HEIGHT");
                        NACASEDET.Columns.Add("CREATEDON");
                        NACASEDET.Columns.Add("CREATEDAT");
                        ///Added by vishal as on 2nd May 2018
                        NACASEDET.Columns.Add("INFORMANT");
                        NACASEDET.Columns.Add("MOA");
                        NACASEDET.Columns.Add("MOAOTHER");
                        NACASEDET.Columns.Add("FRMSOURCE");
                        NACASEDET.Columns.Add("OTHERSOURCE");
                        NACASEDET.Columns.Add("ADMITWITH");
                        NACASEDET.Columns.Add("UNITORIENTYN");
                        NACASEDET.Columns.Add("CELLBELLYN");
                        NACASEDET.Columns.Add("INFORMTODR");
                        NACASEDET.Columns.Add("INFORMTODIET");
                        NACASEDET.Columns.Add("INFORMPANTRY");
                        NACASEDET.Columns.Add("INFORMTOHK");
                        NACASEDET.Columns.Add("INASCOMPTIME");
                        NACASEDET.Columns.Add("INASSMNTDONEBY");
                        NACASEDET.Columns.Add("INFORMANTOTHER");
                        NACASEDET.Columns.Add("PATRELATION");
                        NACASEDET.Columns.Add("PATRELNAME");
                        NACASEDET.Columns.Add("CASEDTLIMG", System.Type.GetType("System.Byte[]"));

                        NACASEDET.Columns.Add("PROVDIAG");
                        NACASEDET.Columns.Add("FAMHIST");
                        NACASEDET.Columns.Add("TREATMNTADVICE");
                        NACASEDET.Columns.Add("DIAGNOSIS");
                        NACASEDET.Columns.Add("PASTHISTORY");
                        NACASEDET.Columns.Add("CASEOF");
                        NACASEDET.Columns.Add("COMPLAINT"); NACASEDET.Columns.Add("GYNACHISTORY");
                        NACASEDET.Columns.Add("PLANOFCARE"); NACASEDET.Columns.Add("PREVASPECT"); NACASEDET.Columns.Add("OTHERINVEST");

                        dsFinalForPrint.Tables.Add(NACASEDET);
                    }
                    if (load.Tables.Contains("NASCALEDET"))
                    {
                        dt = load.Tables["NASCALEDET"];
                        //if (dt.Rows[0]["FALLRISK"].ToString() == "A")
                        //{
                        //    dt.Rows[0]["FALLRISK"] = "Assessed";
                        //}
                        //else if (dt.Rows[0]["FALLRISK"].ToString() == "NSF")
                        //{
                        //    dt.Rows[0]["FALLRISK"] = "No Significant Finding";
                        //}
                        //else if (dt.Rows[0]["FALLRISK"].ToString() == "C")
                        //{
                        //    dt.Rows[0]["FALLRISK"] = "Cannot be assessed";
                        //}
                        if (dt.Rows[0]["DAILYLIVNG"].ToString() == "A")
                        {
                            dt.Rows[0]["DAILYLIVNG"] = "Assessed";
                        }
                        else if (dt.Rows[0]["DAILYLIVNG"].ToString() == "NSF")
                        {
                            dt.Rows[0]["DAILYLIVNG"] = "No Significant Finding";
                        }
                        else if (dt.Rows[0]["DAILYLIVNG"].ToString() == "C")
                        {
                            dt.Rows[0]["DAILYLIVNG"] = "Cannot be assessed";
                        }
                        if (dt.Rows[0]["NEUROLOGCYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["NEUROLOGCYN"] = "Assessed";
                        }
                        else if (dt.Rows[0]["NEUROLOGCYN"].ToString() == "N")
                        {
                            dt.Rows[0]["NEUROLOGCYN"] = "No Significant Finding";
                        }
                        if (dt.Rows[0]["PAINASSESMNT"].ToString() == "A")
                        {
                            dt.Rows[0]["PAINASSESMNT"] = "Assessed";
                        }
                        else if (dt.Rows[0]["PAINASSESMNT"].ToString() == "NSF")
                        {
                            dt.Rows[0]["PAINASSESMNT"] = "No Significant Finding";
                        }
                        else if (dt.Rows[0]["PAINASSESMNT"].ToString() == "C")
                        {
                            dt.Rows[0]["PAINASSESMNT"] = "Cannot be assessed";
                        }
                        var characterpainLst = GeneralFunction.GetCharacterOfPainList();
                        foreach (DataRow row in dt.Rows)
                        {
                            // row["CHAROFPAIN"] = characterpainLst.Where(X => X.Value == ("" + row["CHAROFPAIN"]).Trim()).Count() == 0 ? "" : characterpainLst.Where(X => X.Value == row["CHAROFPAIN"].ToString().Trim()).FirstOrDefault().Text;

                            row["CHAROFPAIN"] = GeneralFunction.GetListTxt(characterpainLst, row["CHAROFPAIN"].ToString().Trim());

                        }
                        var txtFallRisk = "";
                        if (dt.Rows[0]["NEUROLOGCYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Neurological Deficit";
                        }
                        if (dt.Rows[0]["REQAIDYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Ambulatory Aid";
                        }
                        if (dt.Rows[0]["HOFALLYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",History of falls-immediate or within 3 months";
                        }
                        if (dt.Rows[0]["MENTALSTSYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Mental Status";
                        }
                        if (dt.Rows[0]["IVINFUSIONYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Intranvenous Infusion";
                        }
                        if (dt.Rows[0]["POORHEARNGYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Poor Hearing/Eye Sight";
                        }
                        if (dt.Rows[0]["AGEBELWYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Age(below or above 65 yrs)";
                        }
                        if (dt.Rows[0]["MEDICATIONYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Medications";
                        }
                        if (dt.Rows[0]["LANBARRIERYN"].ToString() == "Y")
                        {
                            txtFallRisk = txtFallRisk + ",Language Barrier";
                        }

                        if (txtFallRisk.IndexOf(",") == 0)
                        {
                            // var lengthTxt = txtFallRisk.Length;
                            txtFallRisk = txtFallRisk.Substring(1);
                        }



                        dt.Rows[0]["LANBARRIERYN"] = txtFallRisk;
                        dt = load.Tables["NASCALEDET"];
                        dt.AcceptChanges();
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NASCALEDET = new DataTable();
                        NASCALEDET.TableName = "NASCALEDET";
                        NASCALEDET.Columns.Add("DAILYLIVNG");
                        NASCALEDET.Columns.Add("FEEDING");
                        NASCALEDET.Columns.Add("ORALHYGNE");
                        NASCALEDET.Columns.Add("BATHING");
                        NASCALEDET.Columns.Add("TOILATING");
                        NASCALEDET.Columns.Add("GENMOBILTY");
                        NASCALEDET.Columns.Add("DRESSING");
                        NASCALEDET.Columns.Add("FALLRISK");
                        NASCALEDET.Columns.Add("SASCORE");
                        NASCALEDET.Columns.Add("AGEBELWYN");
                        NASCALEDET.Columns.Add("NEUROLOGCYN");
                        NASCALEDET.Columns.Add("REQAIDYN");
                        NASCALEDET.Columns.Add("MENTALSTSYN");
                        NASCALEDET.Columns.Add("POORHEARNGYN");
                        NASCALEDET.Columns.Add("IVINFUSIONYN");
                        NASCALEDET.Columns.Add("MEDICATIONYN");
                        NASCALEDET.Columns.Add("LANBARRIERYN");
                        NASCALEDET.Columns.Add("PAINASSESMNT");
                        NASCALEDET.Columns.Add("PAIN");
                        NASCALEDET.Columns.Add("WONGBAKSCALE");
                        NASCALEDET.Columns.Add("TYPEOFPAIN");
                        NASCALEDET.Columns.Add("EXFACTOR");
                        NASCALEDET.Columns.Add("CHAROFPAIN");
                        NASCALEDET.Columns.Add("PAINLOCATION");
                        NASCALEDET.Columns.Add("PAINDURATION");
                        NASCALEDET.Columns.Add("HOFALLYN");
                        NASCALEDET.Columns.Add("RELIEVFACT");
                        NASCALEDET.Columns.Add("AFFECTSLEEPYN");
                        dsFinalForPrint.Tables.Add(NASCALEDET);
                    }
                    if (load.Tables.Contains("NACLINICAL"))
                    {
                        dt = load.Tables["NACLINICAL"];
                        var lvlOfCounsiousness = GeneralFunction.GetLevelOfConciousnessList();
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["CONCIUSLEVEL"] = lvlOfCounsiousness.Where(X => X.Value == ("" + row["CONCIUSLEVEL"]).Trim()).Count() == 0 ? "" : lvlOfCounsiousness.Where(X => X.Value == row["CONCIUSLEVEL"].ToString().Trim()).FirstOrDefault().Text;
                            row["CONCIUSLEVEL"] = GeneralFunction.GetListValue(lvlOfCounsiousness, row["CONCIUSLEVEL"].ToString().Trim());

                        }

                        var speechLst = GeneralFunction.GetSpeechList();
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["SPEECHYN"] = speechLst.Where(X => X.Value == ("" + row["SPEECHYN"]).Trim()).Count() == 0 ? "" : speechLst.Where(X => X.Value == row["SPEECHYN"].ToString().Trim()).FirstOrDefault().Text;
                            row["SPEECHYN"] = GeneralFunction.GetListValue(speechLst, row["SPEECHYN"].ToString().Trim());

                        }

                        var shapeLst = GeneralFunction.GetShapeList();
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["PUPILRSHAPE"] = shapeLst.Where(X => X.Value == ("" + row["PUPILRSHAPE"]).Trim()).Count() == 0 ? "" : shapeLst.Where(X => X.Value == row["PUPILRSHAPE"].ToString().Trim()).FirstOrDefault().Text;
                            //row["PUPILLSHAPE"] = shapeLst.Where(X => X.Value == ("" + row["PUPILLSHAPE"]).Trim()).Count() == 0 ? "" : shapeLst.Where(X => X.Value == row["PUPILLSHAPE"].ToString().Trim()).FirstOrDefault().Text;

                            row["PUPILRSHAPE"] = GeneralFunction.GetListValue(shapeLst, row["PUPILRSHAPE"].ToString().Trim());
                            row["PUPILLSHAPE"] = GeneralFunction.GetListValue(shapeLst, row["PUPILLSHAPE"].ToString().Trim());

                        }

                        var reactnLst = GeneralFunction.GetReactionList();
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["PUPILRREACTN"] = reactnLst.Where(X => X.Value == ("" + row["PUPILRREACTN"]).Trim()).Count() == 0 ? "" : reactnLst.Where(X => X.Value == row["PUPILRREACTN"].ToString().Trim()).FirstOrDefault().Text;
                            //row["PUPILLREACTN"] = reactnLst.Where(X => X.Value == ("" + row["PUPILLREACTN"]).Trim()).Count() == 0 ? "" : reactnLst.Where(X => X.Value == row["PUPILLREACTN"].ToString().Trim()).FirstOrDefault().Text;
                            row["PUPILRREACTN"] = GeneralFunction.GetListValue(reactnLst, row["PUPILRREACTN"].ToString().Trim());
                            row["PUPILLREACTN"] = GeneralFunction.GetListValue(reactnLst, row["PUPILLREACTN"].ToString().Trim());

                        }

                        var extraOculrMovmntLst = GeneralFunction.GetExtraOccularMvemntList();
                        foreach (DataRow row in dt.Rows)
                        {
                            // row["PUPILREXTRA"] = extraOculrMovmntLst.Where(X => X.Value == ("" + row["PUPILREXTRA"]).Trim()).Count() == 0 ? "" : extraOculrMovmntLst.Where(X => X.Value == row["PUPILREXTRA"].ToString().Trim()).FirstOrDefault().Text;
                            //row["PUPILLEXTRA"] = extraOculrMovmntLst.Where(X => X.Value == ("" + row["PUPILLEXTRA"]).Trim()).Count() == 0 ? "" : extraOculrMovmntLst.Where(X => X.Value == row["PUPILLEXTRA"].ToString().Trim()).FirstOrDefault().Text;

                            row["PUPILREXTRA"] = GeneralFunction.GetListValue(reactnLst, row["PUPILREXTRA"].ToString().Trim());
                            row["PUPILLEXTRA"] = GeneralFunction.GetListValue(reactnLst, row["PUPILLEXTRA"].ToString().Trim());

                        }

                        var gaitLst = GeneralFunction.GetGaitList();
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["GAIT"] = gaitLst.Where(X => X.Value == ("" + row["GAIT"]).Trim()).Count() == 0 ? "" : gaitLst.Where(X => X.Value == row["GAIT"].ToString().Trim()).FirstOrDefault().Text;
                            row["GAIT"] = GeneralFunction.GetListValue(gaitLst, row["GAIT"].ToString().Trim());

                        }

                        var facialSymmLst = GeneralFunction.GetFacialSymmetryList();
                        foreach (DataRow row in dt.Rows)
                        {
                            //row["FACIALSYM"] = facialSymmLst.Where(X => X.Value == ("" + row["FACIALSYM"]).Trim()).Count() == 0 ? "" : facialSymmLst.Where(X => X.Value == row["FACIALSYM"].ToString().Trim()).FirstOrDefault().Text;
                            row["FACIALSYM"] = GeneralFunction.GetListValue(facialSymmLst, row["FACIALSYM"].ToString().Trim());

                        }
                        if (dt.Rows[0]["GAGREFLXYN"].ToString() == "Y")
                        {
                            dt.Rows[0]["GAGREFLXYN"] = "Present";
                        }
                        else if (dt.Rows[0]["GAGREFLXYN"].ToString() == "N")
                        {
                            dt.Rows[0]["GAGREFLXYN"] = "Absent";
                        }
                        else { }
                        dt = load.Tables["NACLINICAL"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NACLINICAL = new DataTable();
                        NACLINICAL.TableName = "NACLINICAL";
                        NACLINICAL.Columns.Add("NEUROCOMPLNT");
                        NACLINICAL.Columns.Add("HEADCHEYN");
                        NACLINICAL.Columns.Add("MEMRYCHNGEYN");
                        NACLINICAL.Columns.Add("WEAKNESYN");
                        NACLINICAL.Columns.Add("SENSRYSYMYN");
                        NACLINICAL.Columns.Add("SENSOR");
                        NACLINICAL.Columns.Add("MOTORYN");
                        NACLINICAL.Columns.Add("MOTOR");
                        NACLINICAL.Columns.Add("CONVULSIONYN");
                        NACLINICAL.Columns.Add("CONVULSIONS");
                        NACLINICAL.Columns.Add("CONCIUSLEVEL");
                        NACLINICAL.Columns.Add("PERSONYN");
                        NACLINICAL.Columns.Add("PLACEYN");
                        NACLINICAL.Columns.Add("TIMEYN");
                        NACLINICAL.Columns.Add("SPEECHYN");
                        NACLINICAL.Columns.Add("GCSSCORE");
                        NACLINICAL.Columns.Add("PUPILLSIZE");
                        NACLINICAL.Columns.Add("PUPILRSIZE");
                        NACLINICAL.Columns.Add("PUPILLSHAPE");
                        NACLINICAL.Columns.Add("PUPILRSHAPE");
                        NACLINICAL.Columns.Add("PUPILRREACTN");
                        NACLINICAL.Columns.Add("PUPILLREACTN");
                        NACLINICAL.Columns.Add("PUPILLEXTRA");
                        NACLINICAL.Columns.Add("PUPILREXTRA");
                        NACLINICAL.Columns.Add("FACIALSYM");
                        NACLINICAL.Columns.Add("GAIT");
                        NACLINICAL.Columns.Add("OTHRFINDNG");
                        NACLINICAL.Columns.Add("SPO2");
                        NACLINICAL.Columns.Add("RR");

                        NACLINICAL.Columns.Add("COOPERTIVEYN");
                        NACLINICAL.Columns.Add("SEIZUREYN");
                        NACLINICAL.Columns.Add("HEMIPLEGIAYN");
                        NACLINICAL.Columns.Add("PARAPLEGIAYN");
                        NACLINICAL.Columns.Add("QUADRIPLEGIAYN");
                        NACLINICAL.Columns.Add("GAGREFLXYN");

                        dsFinalForPrint.Tables.Add(NACLINICAL);
                    }

                    //load.Tables[0].TableName = "NAPATALLERGY";
                    if (load.Tables.Contains("NAPATALLERGY"))
                    {
                        dt = load.Tables["NAPATALLERGY"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NAPATALLERGY = new DataTable("NAPATALLERGY");
                        NAPATALLERGY.TableName = "NAPATALLERGY";
                        NAPATALLERGY.Columns.Add("ALLERGYDESC");
                        NAPATALLERGY.Columns.Add("DURATION");
                        NAPATALLERGY.Columns.Add("REMARK");
                        dsFinalForPrint.Tables.Add(NAPATALLERGY);
                    }


                    //load.Tables[0].TableName = "NACRITICPARAM";
                    if (load.Tables.Contains("NACRITICPARAM"))
                    {
                        dt = load.Tables["NACRITICPARAM"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable NACRITICPARAM = new DataTable("NACRITICPARAM");
                        NACRITICPARAM.TableName = "NACRITICPARAM";
                        NACRITICPARAM.Columns.Add("PERIPHRAL");
                        NACRITICPARAM.Columns.Add("PACEDRT");
                        NACRITICPARAM.Columns.Add("PATINTRNSCRT");
                        NACRITICPARAM.Columns.Add("IABPSYS");
                        NACRITICPARAM.Columns.Add("IABPDIA");
                        NACRITICPARAM.Columns.Add("IBPSYS");
                        NACRITICPARAM.Columns.Add("IBPDIA");
                        NACRITICPARAM.Columns.Add("NIBPSYS");
                        NACRITICPARAM.Columns.Add("NIBPDIA");
                        dsFinalForPrint.Tables.Add(NACRITICPARAM);

                    }
                    if (load.Tables.Contains("HABIT"))
                    {
                        dt = load.Tables["HABIT"];
                        dsFinalForPrint.Tables.Add(dt.Copy());
                    }
                    else
                    {
                        DataTable habitDt = new DataTable("HABIT");
                        habitDt.TableName = "HABIT";
                        habitDt.Columns.Add("HABITNM");
                        habitDt.Columns.Add("DURATION");

                        dsFinalForPrint.Tables.Add(habitDt);
                    }

                    HData = GeneralFunction.getHeaderFooter("Initial Nursing Assessment", "", "", "");

                    if (HData.Rows.Count > 0 && HData.Columns.Contains("PrintDateTime"))
                    {
                        HData.Rows[0]["PrintDateTime"] =
                            GeneralFunction.ConvertDateWithTimeTo12Hour(HData.Rows[0]["PrintDateTime"].ToString());
                    }
                    HData.TableName = "HeaderFooter";
                    dsFinalForPrint.Tables.Add(HData);
                    DataTable dt1 = new DataTable();
                    dt1.TableName = "PatInfo";
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("IPNO");
                        dt1.Columns.Add("MRNO");
                        dt1.Columns.Add("ADMNDATE");
                        dt1.Columns.Add("PATNAME");
                        dt1.Columns.Add("ADMNTIME");
                        dt1.Columns.Add("Gender");
                        dt1.Columns.Add("PATAGE");
                        dt1.Columns.Add("CONSDOCT");
                        dt1.Columns.Add("SALUNAME");
                        dt1.Columns.Add("CURRBEDNO");
                        dt1.Columns.Add("WARDNM");
                        dt1.Columns.Add("MLCYORN");
                        dt1.Columns.Add("NURSTNM");

                        DataRow patRow = dt1.NewRow();
                        patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                        patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                        patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                        patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                        patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                        patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                        patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                        patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                        patRow["MLCYORN"] = dt.Rows[0]["MLCYORN"].ToString() == "Y" ? "Yes" : "No";
                        dt1.Rows.Add(patRow);
                        FileStream fs;
                        byte[] Image = new byte[0];
                        var Pic_Path = System.Web.HttpContext.Current.Server.MapPath("~/CaseDetailImages");
                        var finalPath = Pic_Path + @"\" + strIPNO + @"\" + strIPNO + "findings" + ".png";
                        if (File.Exists(finalPath))
                        {
                            fs = new FileStream(finalPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                            Image = new byte[fs.Length];
                            fs.Read(Image, 0, Convert.ToInt32(fs.Length));
                            dsFinalForPrint.Tables["NACASEDET"].Rows[0]["CASEDTLIMG"] = Image;
                            fs.Close();
                        }
                    }
                    dsFinalForPrint.Tables.Add(dt1);
                }
            }
            return dsFinalForPrint;
        }

        //Added by priyanka on 21/06/2025
        #region New Nursing Assessment Details
        public DataSet GetNursingAssessmentDetails(string strIPNO)
        {

            try
            {
                DataSet load = new DataSet();
                DataTable dt = new DataTable();
                DataSet dsFinalForPrint = new DataSet();
                GeneralFunction gen = new GeneralFunction();
                //ICUClient icuClient = new ICUClient();
                CommonServiceClient SecUser = new CommonServiceClient();
                List<UserLstItem> userLst = null;
                userLst = SecUser.GetUserList().ToList();
                DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNO, "", "", "", "", "", "", "", "", "", "", "", "", "");
                DataTable HData = new DataTable();
                load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetNursAssmntRptDetNew(strIPNO))));
                object[] objData = new object[1];
                if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
                {
                    objData[0] = "No Data Found";
                }
                object[] obj = new object[1];
                if (load == null)
                {
                    obj[0] = "";
                }
                else
                {
                    if (load.Tables.Count > 0)
                    {
                        //NACASEDET1
                        if (load.Tables.Contains("NACASEDET1"))
                        {
                            dt = load.Tables["NACASEDET1"];
                            dt.TableName = "NACASEDET";
                            dt.Columns.Add("CASEDETIMGYN");
                            dt.Rows[0]["RCVDWITH"] = dt.Rows[0]["RCVDWITH"].ToString().Trim();
                            dt.Rows[0]["VERIFIEDON"] = dt.Rows[0]["VERIFIEDON"] = GeneralFunction.GetUIDateFormat(dt.Rows[0]["VERIFIEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                            if (dt.Rows[0]["PSYILLYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["PSYILLYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["PSYILLYN"].ToString() == "N")
                            {
                                dt.Rows[0]["PSYILLYN"] = "No";
                            }
                            if (dt.Rows[0]["RELTOLOVEONEYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["RELTOLOVEONEYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["RELTOLOVEONEYN"].ToString() == "N")
                            {
                                dt.Rows[0]["RELTOLOVEONEYN"] = "No";
                            }
                            if (dt.Rows[0]["CHNGINLIFEYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["CHNGINLIFEYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["CHNGINLIFEYN"].ToString() == "N")
                            {
                                dt.Rows[0]["CHNGINLIFEYN"] = "No";
                            }
                            if (dt.Rows[0]["LEARNDIFFYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["LEARNDIFFYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["LEARNDIFFYN"].ToString() == "N")
                            {
                                dt.Rows[0]["LEARNDIFFYN"] = "No";
                            }
                            var occupatnLst = common.GetOccupLst();
                            var RelationLst = SecUser.GetRelationLst();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["OCCUPATION"].ToString().Trim() != "")
                                {
                                    //row["OCCUPATION"] = occupatnLst.Where(X => X.Value == ("" + row["OCCUPATION"]).Trim()).Count() == 0 ? "" : occupatnLst.Where(X => X.Value == row["OCCUPATION"].ToString().Trim()).FirstOrDefault().Text;
                                    row["OCCUPATION"] = GeneralFunction.GetListValue(occupatnLst, row["OCCUPATION"].ToString().Trim());
                                }
                                if (row["CREATEDON"].ToString().Trim() != "")
                                {
                                    row["CREATEDON"] = GeneralFunction.GetUIDateFormat(row["CREATEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["ARRIVALDT"].ToString().Trim() != "")
                                {
                                    row["ARRIVALDT"] = GeneralFunction.GetUIDateFormat(row["ARRIVALDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["TMOFARRIVAL"].ToString().Trim() != "")
                                {
                                    row["TMOFARRIVAL"] = GeneralFunction.ConvertTo12HourFormat(row["TMOFARRIVAL"].ToString().Trim());
                                }

                                if (row["ARRIVALDT"].ToString().Trim() != "" && row["TMOFARRIVAL"].ToString().Trim() != "")
                                {
                                    row["ARRIVALDT"] = row["ARRIVALDT"].ToString().Trim() + "   " + row["TMOFARRIVAL"].ToString().Trim();
                                }

                                if (row["ASSSTARTDT"].ToString().Trim() != "")
                                {
                                    row["ASSSTARTDT"] = GeneralFunction.GetUIDateFormat(row["ASSSTARTDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["TMOFASSSTART"].ToString().Trim() != "")
                                {
                                    row["TMOFASSSTART"] = GeneralFunction.ConvertTo12HourFormat(row["TMOFASSSTART"].ToString().Trim());
                                }

                                if (row["ASSSTARTDT"].ToString().Trim() != "" && row["TMOFASSSTART"].ToString().Trim() != "")
                                {
                                    row["ASSSTARTDT"] = row["ASSSTARTDT"].ToString().Trim() + "   " + row["TMOFASSSTART"].ToString().Trim();
                                }

                                if (row["INASSMNTDONEBY"].ToString().Trim() != "")
                                {
                                    row["INASSMNTDONEBY"] = GeneralFunction.GetListValue(userLst, row["INASSMNTDONEBY"].ToString().Trim()) + " (" + row["INASSMNTDONEBY"].ToString().Trim() + ")";
                                }
                                if (row["ASSMCOMPDT"].ToString().Trim() != "")
                                {
                                    row["ASSMCOMPDT"] = GeneralFunction.GetUIDateFormat(row["ASSMCOMPDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["INASCOMPTIME"].ToString().Trim() != "")
                                {
                                    row["INASCOMPTIME"] = GeneralFunction.ConvertTo12HourFormat(row["INASCOMPTIME"].ToString().Trim());
                                }
                                if (row["INASCOMPTIME"].ToString().Trim() != "" || row["ASSMCOMPDT"].ToString().Trim() != "")
                                {
                                    row["INASCOMPTIME"] = (row["ASSMCOMPDT"].ToString().Trim() + "  " + row["INASCOMPTIME"].ToString().Trim()).Trim();
                                }



                                if (row["VERIFIEDBY"].ToString().Trim() != "")
                                {
                                    row["VERIFIEDBY"] = GeneralFunction.GetListValue(userLst, row["VERIFIEDBY"].ToString().Trim()) + " (" + row["VERIFIEDBY"].ToString().Trim() + ")";
                                }
                                //if (row["VERIFIEDON"].ToString().Trim() != "")
                                //{
                                //    row["VERIFIEDON"] = GeneralFunction.GetUIDateFormat(row["VERIFIEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                //}
                                if (row["VERIFIEDAT"].ToString().Trim() != "")
                                {
                                    row["VERIFIEDAT"] = GeneralFunction.ConvertTo12HourFormat(row["VERIFIEDAT"].ToString().Trim());
                                }

                                if (row["VERIFIEDON"].ToString().Trim() != "" || row["VERIFIEDAT"].ToString().Trim() != "")
                                {
                                    row["VERIFIEDON"] = (row["VERIFIEDON"].ToString().Trim() + "  " + row["VERIFIEDAT"].ToString().Trim()).Trim();
                                }

                                if (row["FAMMEMNRELN"].ToString().Trim() != "")
                                {
                                    row["FAMMEMNRELN"] = GeneralFunction.GetListValue(RelationLst, row["FAMMEMNRELN"].ToString().Trim());
                                }
                                if (row["PATRELATION"].ToString().Trim() != "")
                                {
                                    row["PATRELATION"] = GeneralFunction.GetListValue(RelationLst, row["PATRELATION"].ToString().Trim());
                                }
                            }


                            dt.Columns.Add("CASEDTLIMG", System.Type.GetType("System.Byte[]"));

                            dt = load.Tables["NACASEDET"];

                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }

                        else
                        {
                            DataTable NACASEDET = new DataTable();
                            NACASEDET.TableName = "NACASEDET";
                            NACASEDET.Columns.Add("OCCUPATION");
                            NACASEDET.Columns.Add("PSYILLYN");
                            NACASEDET.Columns.Add("PSYILLNESS");
                            NACASEDET.Columns.Add("RELTOLOVEONEYN");
                            NACASEDET.Columns.Add("RELTOLOVEONE");
                            NACASEDET.Columns.Add("CHNGINLIFEYN");
                            NACASEDET.Columns.Add("CHNGINLIFE");
                            NACASEDET.Columns.Add("LEARNDIFFYN");
                            NACASEDET.Columns.Add("LEARNDIFF");
                            NACASEDET.Columns.Add("WEIGHT");
                            NACASEDET.Columns.Add("HEIGHT");
                            NACASEDET.Columns.Add("CREATEDON");
                            NACASEDET.Columns.Add("CREATEDAT");
                            ///Added by vishal as on 2nd May 2018
                            NACASEDET.Columns.Add("INFORMANT");
                            NACASEDET.Columns.Add("MOA");
                            NACASEDET.Columns.Add("MOAOTHER");
                            NACASEDET.Columns.Add("FRMSOURCE");
                            NACASEDET.Columns.Add("OTHERSOURCE");
                            NACASEDET.Columns.Add("ADMITWITH");
                            NACASEDET.Columns.Add("UNITORIENTYN");
                            NACASEDET.Columns.Add("CELLBELLYN");
                            NACASEDET.Columns.Add("INFORMTODR");
                            NACASEDET.Columns.Add("INFORMTODIET");
                            NACASEDET.Columns.Add("INFORMPANTRY");
                            NACASEDET.Columns.Add("INFORMTOHK");
                            NACASEDET.Columns.Add("INASCOMPTIME");
                            NACASEDET.Columns.Add("INASSMNTDONEBY");
                            NACASEDET.Columns.Add("INFORMANTOTHER");
                            NACASEDET.Columns.Add("PATRELATION");
                            NACASEDET.Columns.Add("PATRELNAME");
                            NACASEDET.Columns.Add("CASEDTLIMG", System.Type.GetType("System.Byte[]"));
                            NACASEDET.Columns.Add("PROVDIAG");
                            NACASEDET.Columns.Add("FAMHIST");
                            NACASEDET.Columns.Add("TREATMNTADVICE");
                            NACASEDET.Columns.Add("DIAGNOSIS");
                            NACASEDET.Columns.Add("PASTHISTORY");
                            NACASEDET.Columns.Add("CASEOF");
                            NACASEDET.Columns.Add("COMPLAINT");
                            NACASEDET.Columns.Add("GYNACHISTORY");
                            NACASEDET.Columns.Add("PLANOFCARE");
                            NACASEDET.Columns.Add("PREVASPECT");
                            NACASEDET.Columns.Add("OTHERINVEST");
                            NACASEDET.Columns.Add("RCVDWITH");
                            NACASEDET.Columns.Add("TMOFARRIVAL");
                            NACASEDET.Columns.Add("TMOFASSSTART");
                            NACASEDET.Columns.Add("ARRIVALDT");
                            NACASEDET.Columns.Add("ASSSTARTDT");
                            NACASEDET.Columns.Add("HYPTENSYN");
                            NACASEDET.Columns.Add("TUBERCULYN");
                            NACASEDET.Columns.Add("OTHPASTHISYN");
                            NACASEDET.Columns.Add("OTHPASTHISDET");
                            NACASEDET.Columns.Add("DIABETMELTUYN");
                            NACASEDET.Columns.Add("BLEEDISYN");
                            NACASEDET.Columns.Add("ASTHMAYN");
                            NACASEDET.Columns.Add("RENALDISYN");
                            NACASEDET.Columns.Add("PASTSURGYN");
                            NACASEDET.Columns.Add("STROKEYN");
                            NACASEDET.Columns.Add("HEARTDISYN");
                            NACASEDET.Columns.Add("VULNRBLYN");
                            NACASEDET.Columns.Add("PASTSURGNM");
                            NACASEDET.Columns.Add("BMI");
                            NACASEDET.Columns.Add("BSA");
                            NACASEDET.Columns.Add("EF");
                            NACASEDET.Columns.Add("IDBANDYN");
                            NACASEDET.Columns.Add("SIDERAILYN");
                            NACASEDET.Columns.Add("BSIDESYN");
                            NACASEDET.Columns.Add("VERIFIEDBY");
                            NACASEDET.Columns.Add("VERIFIEDON");
                            NACASEDET.Columns.Add("VERIFIEDAT");
                            NACASEDET.Columns.Add("FAMMEMBNM");
                            NACASEDET.Columns.Add("FAMMEMNRELN");
                            NACASEDET.Columns.Add("ICUNSYN");
                            NACASEDET.Columns.Add("TLNAME");
                            dsFinalForPrint.Tables.Add(NACASEDET);
                        }
                        //END

                        //NACASEDETAILS2
                        if (load.Tables.Contains("NACASEDET2"))
                        {
                            dt = load.Tables["NACASEDET2"];

                            //if(dt.Rows.Count == 0)
                            //{
                            //    dt.Rows[0]["IVLINENSF"] = "";
                            //    dt.Rows[0]["BLDMANINSF"] = "";
                            //}
                            dt.TableName = "NACASEDETAILS2";

                            if (dt.Rows.Count > 0)
                            {
                                if (dt.Rows[0]["DIETHABIT"].ToString().Trim() == "O")
                                {
                                    dt.Rows[0]["DIETHABIT"] = "Other";
                                }
                                else if (dt.Rows[0]["DIETHABIT"].ToString().Trim() == "V")
                                {
                                    dt.Rows[0]["DIETHABIT"] = "Vegetarian";
                                }
                                else if (dt.Rows[0]["DIETHABIT"].ToString().Trim() == "N")
                                {
                                    dt.Rows[0]["DIETHABIT"] = "Non-Vegetarian";
                                }

                                if (dt.Rows[0]["READENGYN"].ToString().Trim() == "Y")
                                {
                                    dt.Rows[0]["READENGYN"] = "Yes";
                                }
                                else if (dt.Rows[0]["READENGYN"].ToString().Trim() == "N")
                                {
                                    dt.Rows[0]["READENGYN"] = "No";
                                }

                                if (dt.Rows[0]["CULTCONSIYN"].ToString().Trim() == "Y")
                                {
                                    dt.Rows[0]["CULTCONSIYN"] = "Yes";
                                }
                                else if (dt.Rows[0]["CULTCONSIYN"].ToString().Trim() == "N")
                                {
                                    dt.Rows[0]["CULTCONSIYN"] = "No";
                                }
                                else if (dt.Rows[0]["CULTCONSIYN"].ToString().Trim() == "O")
                                {
                                    dt.Rows[0]["CULTCONSIYN"] = "Other";
                                }


                                var MaleBrstList = GeneralFunction.GetMaleBrstList();
                                foreach (DataRow row in dt.Rows)
                                {
                                    //row["MALEBRESTCD"] = MaleBrstList.Where(X => X.Value == ("" + row["MALEBRESTCD"]).Trim()).Count() == 0 ? "" : MaleBrstList.Where(X => X.Value == row["MALEBRESTCD"].ToString().Trim()).FirstOrDefault().Text;

                                    row["MALEBRESTCD"] = GeneralFunction.GetListValue(MaleBrstList, row["MALEBRESTCD"].ToString().Trim());

                                }
                                var EmotionalStat = GeneralFunction.GetEmotionalStatusList();
                                foreach (DataRow row in dt.Rows)
                                {
                                    if (row["EMOTSTAT"].ToString().Trim() != "")
                                    {
                                        row["EMOTSTAT"] = GeneralFunction.GetListValue(EmotionalStat, row["EMOTSTAT"].ToString().Trim());
                                    }
                                    if (row["SECVERIFBY"].ToString().Trim() != "")
                                    {
                                        // row["SECVERIFBY"] = userLst.Where(x => x.UserId == row["SECVERIFBY"].ToString().Trim()).FirstOrDefault().Text + "(" + row["SECVERIFBY"].ToString().Trim() + ")";

                                        row["SECVERIFBY"] = GeneralFunction.GetListValue(userLst, row["SECVERIFBY"].ToString().Trim()) + " (" + row["SECVERIFBY"].ToString().Trim() + ")";
                                    }
                                    if (row["SECASMNDONEBY"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEBY"] = GeneralFunction.GetListValue(userLst, row["SECASMNDONEBY"].ToString().Trim()) + " (" + row["SECASMNDONEBY"].ToString().Trim() + ")";
                                        // row["SECASMNDONEBY"] = userLst.Where(x => x.UserId == row["SECASMNDONEBY"].ToString().Trim()).FirstOrDefault().Text + "(" + row["SECASMNDONEBY"].ToString().Trim() + ")";
                                    }
                                    if (row["SECVERIFON"].ToString().Trim() != "")
                                    {
                                        row["SECVERIFON"] = GeneralFunction.GetUIDateFormat(row["SECVERIFON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["SECVERIFAT"].ToString().Trim() != "")
                                    {
                                        row["SECVERIFAT"] = GeneralFunction.ConvertTo12HourFormat(row["SECVERIFAT"].ToString().Trim());
                                    }

                                    if (row["SECVERIFON"].ToString().Trim() != "" || row["SECVERIFAT"].ToString().Trim() != "")
                                    {
                                        row["SECVERIFON"] = (row["SECVERIFON"].ToString().Trim() + "  " + row["SECVERIFAT"].ToString().Trim()).Trim();
                                    }
                                    if (row["SECASMNDONEON"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEON"] = GeneralFunction.GetUIDateFormat(row["SECASMNDONEON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["SECASMNDONEAT"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEAT"] = GeneralFunction.ConvertTo12HourFormat(row["SECASMNDONEAT"].ToString().Trim());
                                    }

                                    if (row["SECASMNDONEON"].ToString().Trim() != "" || row["SECASMNDONEAT"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEON"] = (row["SECASMNDONEON"].ToString().Trim() + "  " + row["SECASMNDONEAT"].ToString().Trim()).Trim();
                                    }
                                    if (row["FLSTDREXAMDT"].ToString().Trim() != "")
                                    {
                                        row["FLSTDREXAMDT"] = GeneralFunction.GetUIDateFormat(row["FLSTDREXAMDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["FMAMOGDT"].ToString().Trim() != "")
                                    {
                                        row["FMAMOGDT"] = GeneralFunction.GetUIDateFormat(row["FMAMOGDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["FLMPDT"].ToString().Trim() != "")
                                    {
                                        row["FLMPDT"] = GeneralFunction.GetUIDateFormat(row["FLMPDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["FLASTPAP"].ToString().Trim() != "")
                                    {
                                        row["FLASTPAP"] = GeneralFunction.GetUIDateFormat(row["FLASTPAP"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["LSTPRPEXAMDT"].ToString().Trim() != "")
                                    {
                                        row["LSTPRPEXAMDT"] = GeneralFunction.GetUIDateFormat(row["LSTPRPEXAMDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["LSTPSADT"].ToString().Trim() != "")
                                    {
                                        row["LSTPSADT"] = GeneralFunction.GetUIDateFormat(row["LSTPSADT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    //row["SECSTARTDT"] = GeneralFunction.GetDate(row["SECSTARTDT"].ToString().Trim());
                                    //row["SECSTARTTM"] = GeneralFunction.ConvertTo12HourFormat(row["SECSTARTTM"].ToString().Trim());

                                    if (row["SECSTARTDT"].ToString().Trim() != "")
                                    {
                                        row["SECSTARTDT"] = GeneralFunction.GetUIDateFormat(row["SECSTARTDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["SECSTARTTM"].ToString().Trim() != "")
                                    {
                                        row["SECSTARTTM"] = GeneralFunction.ConvertTo12HourFormat(row["SECSTARTTM"].ToString().Trim());
                                    }

                                    if (row["SECSTARTDT"].ToString().Trim() != "" && row["SECSTARTTM"].ToString().Trim() != "")
                                    {
                                        row["SECSTARTDT"] = row["SECSTARTDT"].ToString().Trim() + "   " + row["SECSTARTTM"].ToString().Trim();
                                    }

                                }


                            }
                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());

                        }
                        else
                        {
                            DataTable NACASEDETAILS2 = new DataTable();
                            NACASEDETAILS2.Columns.Add("IVLINENSF");
                            NACASEDETAILS2.Columns.Add("IVCANULAYN");
                            NACASEDETAILS2.Columns.Add("PICCYN");
                            NACASEDETAILS2.Columns.Add("PORTACCYN");
                            NACASEDETAILS2.Columns.Add("DRAINYN");
                            NACASEDETAILS2.Columns.Add("AVFISTULA");
                            NACASEDETAILS2.Columns.Add("ETTUBEYN");
                            NACASEDETAILS2.Columns.Add("ICDYN");
                            NACASEDETAILS2.Columns.Add("FOLCATHYN");
                            NACASEDETAILS2.Columns.Add("CVLINEYN");
                            NACASEDETAILS2.Columns.Add("PERICATHYN");
                            NACASEDETAILS2.Columns.Add("CONDRAINYN");
                            NACASEDETAILS2.Columns.Add("RYLTUBFDYN");
                            NACASEDETAILS2.Columns.Add("RYLTUBASPYN");
                            NACASEDETAILS2.Columns.Add("NEPHROTBYN");
                            NACASEDETAILS2.Columns.Add("SUPPUBCATYN");
                            NACASEDETAILS2.Columns.Add("INVASREMARK");
                            NACASEDETAILS2.Columns.Add("EDUCLEVEL");
                            NACASEDETAILS2.Columns.Add("PRIMLANG");
                            NACASEDETAILS2.Columns.Add("READENGYN");
                            NACASEDETAILS2.Columns.Add("BARTOLEARN");
                            NACASEDETAILS2.Columns.Add("DIETHABIT");
                            NACASEDETAILS2.Columns.Add("DIETOTHDET");
                            NACASEDETAILS2.Columns.Add("CONDRAINYN");
                            NACASEDETAILS2.Columns.Add("CULTCONSIYN");
                            NACASEDETAILS2.Columns.Add("CULTCONSIDET");
                            NACASEDETAILS2.Columns.Add("EMOTSTAT");
                            NACASEDETAILS2.Columns.Add("PSYCCULREMK");
                            NACASEDETAILS2.Columns.Add("HEMATOYN");
                            NACASEDETAILS2.Columns.Add("BRUSINGYN");
                            NACASEDETAILS2.Columns.Add("BRUSINGDET");
                            NACASEDETAILS2.Columns.Add("BLDTRANYN");
                            NACASEDETAILS2.Columns.Add("BLDTRANDET");
                            NACASEDETAILS2.Columns.Add("HBRESULT");
                            NACASEDETAILS2.Columns.Add("TLCRESULT");
                            NACASEDETAILS2.Columns.Add("NRESULT");
                            NACASEDETAILS2.Columns.Add("LRESULT");
                            NACASEDETAILS2.Columns.Add("ERESULT");
                            NACASEDETAILS2.Columns.Add("BRESULT");
                            NACASEDETAILS2.Columns.Add("MRESULT");
                            NACASEDETAILS2.Columns.Add("PLATRESULT");
                            NACASEDETAILS2.Columns.Add("BUNRESULT");
                            NACASEDETAILS2.Columns.Add("SERUMRESULT");
                            NACASEDETAILS2.Columns.Add("FREPRODTYN");
                            NACASEDETAILS2.Columns.Add("FBREASTS");
                            NACASEDETAILS2.Columns.Add("FMNTHSBEYN");
                            NACASEDETAILS2.Columns.Add("FLUMPYN");
                            NACASEDETAILS2.Columns.Add("FBRSTFEEDYN");
                            NACASEDETAILS2.Columns.Add("FLSTDREXAMDT");
                            NACASEDETAILS2.Columns.Add("FMAMOGDT");
                            NACASEDETAILS2.Columns.Add("FNIPLDISYN");
                            NACASEDETAILS2.Columns.Add("FDIMPYN");
                            NACASEDETAILS2.Columns.Add("FSYMYN");
                            NACASEDETAILS2.Columns.Add("FNIPINVYN");
                            NACASEDETAILS2.Columns.Add("FPAINYN");
                            NACASEDETAILS2.Columns.Add("FLMPDT");
                            NACASEDETAILS2.Columns.Add("FG");
                            NACASEDETAILS2.Columns.Add("FP");
                            NACASEDETAILS2.Columns.Add("FA");
                            NACASEDETAILS2.Columns.Add("FLASTPAP");
                            NACASEDETAILS2.Columns.Add("FMENOPYN");
                            NACASEDETAILS2.Columns.Add("FMENOPDUR");
                            NACASEDETAILS2.Columns.Add("FVAGDISYN");
                            NACASEDETAILS2.Columns.Add("FVAGITCHYN");
                            NACASEDETAILS2.Columns.Add("FVAGDISMENYN");
                            NACASEDETAILS2.Columns.Add("FVAGAMENORYN");
                            NACASEDETAILS2.Columns.Add("FVAGINFECYN");
                            NACASEDETAILS2.Columns.Add("FREPRREMARK");
                            NACASEDETAILS2.Columns.Add("MREPRODYN");
                            NACASEDETAILS2.Columns.Add("MBRESTREMARK");
                            NACASEDETAILS2.Columns.Add("LSTPRPEXAMDT");
                            NACASEDETAILS2.Columns.Add("LSTPSADT");
                            NACASEDETAILS2.Columns.Add("MPENILDISYN");
                            NACASEDETAILS2.Columns.Add("MITCHINGYN");
                            NACASEDETAILS2.Columns.Add("MHERNIAYN");
                            NACASEDETAILS2.Columns.Add("MTESTLUMPYN");
                            NACASEDETAILS2.Columns.Add("MINFECTHYN");
                            NACASEDETAILS2.Columns.Add("MALEREMARK");
                            NACASEDETAILS2.Columns.Add("VENACAVTOL");
                            NACASEDETAILS2.Columns.Add("SECSTARTDT");
                        }
                        //END
                        if (load.Tables.Contains("OTHENURSASS"))
                        {
                            dt = load.Tables["OTHENURSASS"];


                            dt.TableName = "OTHENURSASS";

                            if (dt.Rows.Count > 0)
                            {
                                dt.AcceptChanges();
                                dsFinalForPrint.Tables.Add(dt.Copy());
                            }
                        }
                        else
                        {
                            DataTable OTHENURSASS = new DataTable();
                            OTHENURSASS.Columns.Add("NSCORE");
                        }
                        //NACASEDET3
                        if (load.Tables.Contains("NACASEDET3"))
                        {
                            dt = load.Tables["NACASEDET3"];
                            if (dt.Rows.Count > 0)
                            {
                                if (dt.Rows[0]["CVSPULREGIRREGYN"].ToString() == "R")
                                {
                                    dt.Rows[0]["CVSPULREGIRREGYN"] = "Regular";
                                }
                                else if (dt.Rows[0]["CVSPULREGIRREGYN"].ToString() == "I")
                                {
                                    dt.Rows[0]["CVSPULREGIRREGYN"] = "Irregular";
                                }


                                if (dt.Rows[0]["ORALMMS"].ToString() == "O")
                                {
                                    dt.Rows[0]["ORALMMS"] = "Moderate";
                                }
                                else if (dt.Rows[0]["ORALMMS"].ToString() == "M")
                                {
                                    dt.Rows[0]["ORALMMS"] = "Mild";
                                }
                                else if (dt.Rows[0]["ORALMMS"].ToString() == "S")
                                {
                                    dt.Rows[0]["ORALMMS"] = "Servere";
                                }

                                if (dt.Rows[0]["SKINROMFULREST"].ToString() == "F")
                                {
                                    dt.Rows[0]["SKINROMFULREST"] = "Full";
                                }
                                else if (dt.Rows[0]["SKINROMFULREST"].ToString() == "R")
                                {
                                    dt.Rows[0]["SKINROMFULREST"] = "Restricted";
                                }



                                if (dt.Rows[0]["SKINTURGGP"].ToString() == "G")
                                {
                                    dt.Rows[0]["SKINTURGGP"] = "Good";
                                }
                                else if (dt.Rows[0]["SKINTURGGP"].ToString() == "P")
                                {
                                    dt.Rows[0]["SKINTURGGP"] = "Poor";
                                }


                                if (dt.Rows[0]["GENCATHFS"].ToString() == "F")
                                {
                                    dt.Rows[0]["GENCATHFS"] = "Foley's";
                                }
                                else if (dt.Rows[0]["GENCATHFS"].ToString() == "S")
                                {
                                    dt.Rows[0]["GENCATHFS"] = "Suprapubic";
                                }

                                if (dt.Rows[0]["LASTDENEXAMINEYN"].ToString().Trim() != "")
                                {
                                    dt.Rows[0]["LASTDENEXAMINEYN"] = GeneralFunction.GetUIDateFormat(dt.Rows[0]["LASTDENEXAMINEYN"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                            }
                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());

                        }
                        else
                        {
                            DataTable NACASEDET3 = new DataTable();
                            NACASEDET3.Columns.Add("EYESNSFYN");
                            NACASEDET3.Columns.Add("VSLIMPRVYN");
                            NACASEDET3.Columns.Add("INFMATIONYN");
                            NACASEDET3.Columns.Add("EYEPAINYN");
                            NACASEDET3.Columns.Add("EYEDISHRGYN");
                            NACASEDET3.Columns.Add("EYEREMARK");
                            NACASEDET3.Columns.Add("EARNSFYN");
                            NACASEDET3.Columns.Add("ERIMPHEAYN");
                            NACASEDET3.Columns.Add("ERDEAFYN");
                            NACASEDET3.Columns.Add("ERTINNIYN");
                            NACASEDET3.Columns.Add("ERDIZZIYN");
                            NACASEDET3.Columns.Add("ERDISCHRGYN");
                            NACASEDET3.Columns.Add("ERPAINYN");
                            NACASEDET3.Columns.Add("ERREMARK");
                            NACASEDET3.Columns.Add("NOSENSFYN");
                            NACASEDET3.Columns.Add("NSCONGYN");
                            NACASEDET3.Columns.Add("NSPAINYN");
                            NACASEDET3.Columns.Add("NSGROWYN");
                            NACASEDET3.Columns.Add("NSSINUSYN");
                            NACASEDET3.Columns.Add("NSDISHRGYN");
                            NACASEDET3.Columns.Add("NSBLEDYN");
                            NACASEDET3.Columns.Add("NSREMARK");

                            NACASEDET3.Columns.Add("MOUTHNSFYN");
                            NACASEDET3.Columns.Add("MHALITOSISYN");
                            NACASEDET3.Columns.Add("MOUTHPAINYN");
                            NACASEDET3.Columns.Add("MBLDGUMSYN");
                            NACASEDET3.Columns.Add("MSTOMATITISYN");
                            NACASEDET3.Columns.Add("MLOSSTASTEYN");
                            NACASEDET3.Columns.Add("MDENTALHYGNYN");
                            NACASEDET3.Columns.Add("LASTDENEXAMINEYN");
                            NACASEDET3.Columns.Add("MOUTHREMARK");
                            NACASEDET3.Columns.Add("THRTNECKNSFYN");
                            NACASEDET3.Columns.Add("THRTSOREYN");
                            NACASEDET3.Columns.Add("THRTHOARSEYN");
                            NACASEDET3.Columns.Add("THRTLUMPSYN");
                            NACASEDET3.Columns.Add("THRTSWLGLNDSYN");
                            NACASEDET3.Columns.Add("THRTSTIFYN");
                            NACASEDET3.Columns.Add("THRTPAINYN");
                            NACASEDET3.Columns.Add("THRTDYSPHAGIAYN");
                            NACASEDET3.Columns.Add("THRTNECKREMARK");
                            NACASEDET3.Columns.Add("CARDVASNSFYN");
                            NACASEDET3.Columns.Add("CVSFATIGUEYN");
                            NACASEDET3.Columns.Add("CVSSYNCOPEYN");
                            NACASEDET3.Columns.Add("CVSCHTPAINYN");
                            NACASEDET3.Columns.Add("CVSORTHOPNOEAYN");
                            NACASEDET3.Columns.Add("CVSPLUSEYN");
                            NACASEDET3.Columns.Add("CVSPULREGIRREGYN");
                            NACASEDET3.Columns.Add("CVSPACEMAKERYN");
                            NACASEDET3.Columns.Add("CVSNCKVNDISTYN");
                            NACASEDET3.Columns.Add("CVSCYANOSISYN");
                            NACASEDET3.Columns.Add("CARDVASREMARK");
                            NACASEDET3.Columns.Add("RESPNSFYN");
                            NACASEDET3.Columns.Add("RESPCOUGYN");
                            NACASEDET3.Columns.Add("RESPSPUTYN");
                            NACASEDET3.Columns.Add("RESPBRADYN");
                            NACASEDET3.Columns.Add("RESPDYSPYN");
                            NACASEDET3.Columns.Add("RESPTACHYYN");
                            NACASEDET3.Columns.Add("RESPSTRIDOYN");
                            NACASEDET3.Columns.Add("RESPSOTHRPYN");
                            NACASEDET3.Columns.Add("RESPREMARK");
                            NACASEDET3.Columns.Add("GASTRONSFYN");
                            NACASEDET3.Columns.Add("GASDENTURESYN");
                            NACASEDET3.Columns.Add("GASLOOSTTHYN");
                            NACASEDET3.Columns.Add("GASTONGCOATYN");
                            NACASEDET3.Columns.Add("GASNAUSEAYN");
                            NACASEDET3.Columns.Add("GASVOMITYN");
                            NACASEDET3.Columns.Add("GASDYSPHAGIAYN");
                            NACASEDET3.Columns.Add("GASCONSTIYN");
                            NACASEDET3.Columns.Add("GASDIARYN");
                            NACASEDET3.Columns.Add("GASASCYN");
                            NACASEDET3.Columns.Add("GASPROCYN");
                            NACASEDET3.Columns.Add("GASHAEMORYN");
                            NACASEDET3.Columns.Add("ORALMUCSYN");
                            NACASEDET3.Columns.Add("ORALMMS");
                            NACASEDET3.Columns.Add("GASTROINSTREMARK");
                            NACASEDET3.Columns.Add("SKELETNSFYN");
                            NACASEDET3.Columns.Add("SKLWEAKYN");
                            NACASEDET3.Columns.Add("SKLTEMORSYN");
                            NACASEDET3.Columns.Add("SKINROMYN");
                            NACASEDET3.Columns.Add("SKINROMFULREST");
                            NACASEDET3.Columns.Add("SKINROMREMARK");
                            NACASEDET3.Columns.Add("SKLDEFORYN");
                            NACASEDET3.Columns.Add("SKLRESTRYN");
                            NACASEDET3.Columns.Add("SKLFRACYN");
                            NACASEDET3.Columns.Add("SKLMUSCJOINTPNYN");
                            NACASEDET3.Columns.Add("SKLASSAMBULTIONYN");
                            NACASEDET3.Columns.Add("ASSISTAMBUREMARK");
                            NACASEDET3.Columns.Add("SKINTURGGP");
                            NACASEDET3.Columns.Add("ICTERUSYN");
                            NACASEDET3.Columns.Add("SKELTLINSTREMARK");
                            NACASEDET3.Columns.Add("GENITONSFYN");
                            NACASEDET3.Columns.Add("GENFREQYN");
                            NACASEDET3.Columns.Add("GENFLNKPLNYN");
                            NACASEDET3.Columns.Add("GENURGENYN");
                            NACASEDET3.Columns.Add("GENHOCALCUYN");
                            NACASEDET3.Columns.Add("GENDYSURIYN");
                            NACASEDET3.Columns.Add("GENRETENSYN");
                            NACASEDET3.Columns.Add("GENINCONTINYN");
                            NACASEDET3.Columns.Add("GENUTIYN");
                            NACASEDET3.Columns.Add("GENOBSFLOW");
                            NACASEDET3.Columns.Add("GENHAEMOCYSTIYN");
                            NACASEDET3.Columns.Add("GENUROSTOMYN");
                            NACASEDET3.Columns.Add("GENCATHETDAYS");
                            NACASEDET3.Columns.Add("GENCATHFS");
                            NACASEDET3.Columns.Add("GENURINREMARK");
                            NACASEDET3.Columns.Add("OSTOMYNSFYN");
                            NACASEDET3.Columns.Add("OTCOLOSTYN");
                            NACASEDET3.Columns.Add("OTURETEROYN");
                            NACASEDET3.Columns.Add("OTILEOSTOMYN");
                            NACASEDET3.Columns.Add("OTNEPHROSYN");
                            NACASEDET3.Columns.Add("OTSUPRCYSTOSYN");
                            NACASEDET3.Columns.Add("OTTRACHEOSYN");
                            NACASEDET3.Columns.Add("OTGASTROSYN");
                            NACASEDET3.Columns.Add("OTJEJUNOSYN");
                            NACASEDET3.Columns.Add("OSTOMYREMARK");
                            NACASEDET3.Columns.Add("EYEITCHYN");
                            NACASEDET3.Columns.Add("CVSPALPITATIONYN");
                            NACASEDET3.Columns.Add("ABDGIRTHYN");
                            NACASEDET3.Columns.Add("ABGSIZE");
                            NACASEDET3.Columns.Add("BOWOPENYN");
                            NACASEDET3.Columns.Add("NEURONSFYN");

                        }
                        //END

                        //NASCALEDET
                        if (load.Tables.Contains("NASCALEDET"))
                        {
                            dt = load.Tables["NASCALEDET"];
                            dt.TableName = "NASCALEDET";


                            if (dt.Rows[0]["AFFECTSLEEPYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["AFFECTSLEEPYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["AFFECTSLEEPYN"].ToString() == "N")
                            {
                                dt.Rows[0]["AFFECTSLEEPYN"] = "No";
                            }

                            if (dt.Rows[0]["INTACTYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["INTACTYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["INTACTYN"].ToString() == "N")
                            {
                                dt.Rows[0]["INTACTYN"] = "No";
                            }

                            var characterpainLst = GeneralFunction.GetCharacterOfPainList();
                            foreach (DataRow row in dt.Rows)
                            {
                                // row["CHAROFPAIN"] = characterpainLst.Where(X => X.Value == ("" + row["CHAROFPAIN"]).Trim()).Count() == 0 ? "" : characterpainLst.Where(X => X.Value == row["CHAROFPAIN"].ToString().Trim()).FirstOrDefault().Text;
                                if (row["CHAROFPAIN"].ToString().Trim() != "")
                                {
                                    row["CHAROFPAIN"] = GeneralFunction.GetListValue(characterpainLst, row["CHAROFPAIN"].ToString().Trim());
                                }
                            }
                            dt = load.Tables["NASCALEDET"];
                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NASCALEDET = new DataTable();
                            NASCALEDET.TableName = "NASCALEDET";
                            NASCALEDET.Columns.Add("DAILYLIVNG");
                            NASCALEDET.Columns.Add("FEEDING");
                            NASCALEDET.Columns.Add("ORALHYGNE");
                            NASCALEDET.Columns.Add("BATHING");
                            NASCALEDET.Columns.Add("TOILATING");
                            NASCALEDET.Columns.Add("GENMOBILTY");
                            NASCALEDET.Columns.Add("DRESSING");
                            NASCALEDET.Columns.Add("FALLRISK");
                            NASCALEDET.Columns.Add("SASCORE");
                            NASCALEDET.Columns.Add("AGEBELWYN");
                            NASCALEDET.Columns.Add("NEUROLOGCYN");
                            NASCALEDET.Columns.Add("REQAIDYN");
                            NASCALEDET.Columns.Add("MENTALSTSYN");
                            NASCALEDET.Columns.Add("POORHEARNGYN");
                            NASCALEDET.Columns.Add("IVINFUSIONYN");
                            NASCALEDET.Columns.Add("MEDICATIONYN");
                            NASCALEDET.Columns.Add("LANBARRIERYN");
                            NASCALEDET.Columns.Add("PAINASSESMNT");
                            NASCALEDET.Columns.Add("PAIN");
                            NASCALEDET.Columns.Add("WONGBAKSCALE");
                            NASCALEDET.Columns.Add("TYPEOFPAIN");
                            NASCALEDET.Columns.Add("EXFACTOR");
                            NASCALEDET.Columns.Add("CHAROFPAIN");
                            NASCALEDET.Columns.Add("PAINLOCATION");
                            NASCALEDET.Columns.Add("PAINDURATION");
                            NASCALEDET.Columns.Add("HOFALLYN");
                            NASCALEDET.Columns.Add("ECOGSCORE");
                            NASCALEDET.Columns.Add("FRFALLSCORE");
                            NASCALEDET.Columns.Add("DVTSCORE");
                            NASCALEDET.Columns.Add("INTACTYN");
                            NASCALEDET.Columns.Add("INTACT");
                            dsFinalForPrint.Tables.Add(NASCALEDET);
                        }
                        //END

                        //NACLINICAL
                        if (load.Tables.Contains("NACLINICAL"))
                        {
                            dt = load.Tables["NACLINICAL"];

                            if (dt.Rows.Count > 0) // Safe check inside
                            {
                                if (dt.Rows[0]["GAGREFLXYN"].ToString() == "Y")
                                {
                                    dt.Rows[0]["GAGREFLXYN"] = "Present";
                                }
                                else if (dt.Rows[0]["GAGREFLXYN"].ToString() == "N")
                                {
                                    dt.Rows[0]["GAGREFLXYN"] = "Absent";
                                }



                            }
                            var lvlOfCounsiousness = GeneralFunction.GetLevelOfConciousnessList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["CONCIUSLEVEL"].ToString().Trim() != "")
                                {
                                    //row["CONCIUSLEVEL"] = lvlOfCounsiousness.Where(X => X.Value == ("" + row["CONCIUSLEVEL"]).Trim()).Count() == 0 ? "" : lvlOfCounsiousness.Where(X => X.Value == row["CONCIUSLEVEL"].ToString().Trim()).FirstOrDefault().Text;
                                    row["CONCIUSLEVEL"] = GeneralFunction.GetListValue(lvlOfCounsiousness, row["CONCIUSLEVEL"].ToString().Trim());
                                }

                            }

                            var speechLst = GeneralFunction.GetSpeechList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["SPEECHYN"].ToString().Trim() != "")
                                {

                                    //row["SPEECHYN"] = speechLst.Where(X => X.Value == ("" + row["SPEECHYN"]).Trim()).Count() == 0 ? "" : speechLst.Where(X => X.Value == row["SPEECHYN"].ToString().Trim()).FirstOrDefault().Text;
                                    row["SPEECHYN"] = GeneralFunction.GetListValue(speechLst, row["SPEECHYN"].ToString().Trim());
                                }

                            }

                            var shapeLst = GeneralFunction.GetShapeList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if ((row["PUPILLSHAPE"].ToString().Trim() != ""))
                                {
                                    row["PUPILLSHAPE"] = GeneralFunction.GetListValue(shapeLst, row["PUPILLSHAPE"].ToString().Trim());
                                }
                                if ((row["PUPILRSHAPE"].ToString().Trim() != ""))
                                {
                                    row["PUPILRSHAPE"] = GeneralFunction.GetListValue(shapeLst, row["PUPILRSHAPE"].ToString().Trim());
                                }

                            }

                            var reactnLst = GeneralFunction.GetReactionList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if ((row["PUPILRREACTN"].ToString().Trim() != ""))
                                {
                                    row["PUPILRREACTN"] = GeneralFunction.GetListValue(reactnLst, row["PUPILRREACTN"].ToString().Trim());

                                }
                                if ((row["PUPILLREACTN"].ToString().Trim() != ""))
                                {
                                    row["PUPILLREACTN"] = GeneralFunction.GetListValue(reactnLst, row["PUPILLREACTN"].ToString().Trim());
                                }

                            }

                            var extraOculrMovmntLst = GeneralFunction.GetExtraOccularMvemntList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if ((row["PUPILREXTRA"].ToString().Trim() != ""))
                                {
                                    row["PUPILREXTRA"] = GeneralFunction.GetListValue(extraOculrMovmntLst, row["PUPILREXTRA"].ToString().Trim());

                                }
                                if ((row["PUPILLEXTRA"].ToString().Trim() != ""))
                                {
                                    row["PUPILLEXTRA"] = GeneralFunction.GetListValue(extraOculrMovmntLst, row["PUPILLEXTRA"].ToString().Trim());
                                }
                            }

                            var gaitLst = GeneralFunction.GetGaitList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["GAIT"].ToString().Trim() != "")
                                {
                                    row["GAIT"] = GeneralFunction.GetListValue(gaitLst, row["GAIT"].ToString().Trim());
                                }

                            }

                            var Powerlist = GeneralFunction.GetPowerList();
                            foreach (DataRow row in dt.Rows)
                            {

                                if (row["UPLIMBRGHT"].ToString().Trim() != "")
                                {
                                    row["UPLIMBRGHT"] = GeneralFunction.GetListValue(Powerlist, row["UPLIMBRGHT"].ToString().Trim());
                                }
                                if (row["UPLIMBLFT"].ToString().Trim() != "")
                                {
                                    row["UPLIMBLFT"] = GeneralFunction.GetListValue(Powerlist, row["UPLIMBLFT"].ToString().Trim());
                                }
                                if (row["LOWLIMBRGHT"].ToString().Trim() != "")
                                {
                                    row["LOWLIMBRGHT"] = GeneralFunction.GetListValue(Powerlist, row["LOWLIMBRGHT"].ToString().Trim());
                                }
                                if (row["LOWLIMBLFT"].ToString().Trim() != "")
                                {
                                    row["LOWLIMBLFT"] = GeneralFunction.GetListValue(Powerlist, row["LOWLIMBLFT"].ToString().Trim());
                                }

                            }

                            dt = load.Tables["NACLINICAL"];
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NACLINICAL = new DataTable();
                            NACLINICAL.TableName = "NACLINICAL";
                            NACLINICAL.Columns.Add("NEUROCOMPLNT");
                            NACLINICAL.Columns.Add("HEADCHEYN");
                            NACLINICAL.Columns.Add("MEMRYCHNGEYN");
                            NACLINICAL.Columns.Add("WEAKNESYN");
                            NACLINICAL.Columns.Add("SENSRYSYMYN");
                            NACLINICAL.Columns.Add("SENSOR");
                            NACLINICAL.Columns.Add("MOTORYN");
                            NACLINICAL.Columns.Add("MOTOR");
                            NACLINICAL.Columns.Add("CONVULSIONYN");
                            NACLINICAL.Columns.Add("CONVULSIONS");
                            NACLINICAL.Columns.Add("CONCIUSLEVEL");
                            NACLINICAL.Columns.Add("PERSONYN");
                            NACLINICAL.Columns.Add("PLACEYN");
                            NACLINICAL.Columns.Add("TIMEYN");
                            NACLINICAL.Columns.Add("SPEECHYN");
                            NACLINICAL.Columns.Add("GCSSCORE");
                            NACLINICAL.Columns.Add("PUPILLSIZE");
                            NACLINICAL.Columns.Add("PUPILRSIZE");
                            NACLINICAL.Columns.Add("PUPILLSHAPE");
                            NACLINICAL.Columns.Add("PUPILRSHAPE");
                            NACLINICAL.Columns.Add("PUPILRREACTN");
                            NACLINICAL.Columns.Add("PUPILLREACTN");
                            NACLINICAL.Columns.Add("PUPILLEXTRA");
                            NACLINICAL.Columns.Add("PUPILREXTRA");
                            NACLINICAL.Columns.Add("FACIALSYM");
                            NACLINICAL.Columns.Add("GAIT");
                            NACLINICAL.Columns.Add("OTHRFINDNG");
                            NACLINICAL.Columns.Add("SPO2");
                            NACLINICAL.Columns.Add("HGT");
                            NACLINICAL.Columns.Add("NEUROREMARK");
                            NACLINICAL.Columns.Add("GAGREFLXYN");
                            NACLINICAL.Columns.Add("RR");
                            NACLINICAL.Columns.Add("OXYFLOWRT");
                            NACLINICAL.Columns.Add("DIZZINESYN");
                            NACLINICAL.Columns.Add("SEDATNSCORE");
                            NACLINICAL.Columns.Add("UPLIMBLFT");
                            NACLINICAL.Columns.Add("UPLIMBRGHT");
                            NACLINICAL.Columns.Add("LOWLIMBRGHT");
                            NACLINICAL.Columns.Add("LOWLIMBLFT");
                            dsFinalForPrint.Tables.Add(NACLINICAL);
                        }
                        //END
                        //SUB REPORT TABLES Allergy
                        if (load.Tables.Contains("NAPATALLERGY"))
                        {
                            dt = load.Tables["NAPATALLERGY"];
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NAPATALLERGY = new DataTable("NAPATALLERGY");
                            NAPATALLERGY.TableName = "NAPATALLERGY";
                            NAPATALLERGY.Columns.Add("ALLERGYDESC");
                            NAPATALLERGY.Columns.Add("DURATION");
                            NAPATALLERGY.Columns.Add("REMARK");
                            dsFinalForPrint.Tables.Add(NAPATALLERGY);
                        }

                        //End

                        //MEDICATION
                        if (load.Tables.Contains("MEDICATION"))
                        {
                            dt = load.Tables["MEDICATION"];
                            dt.TableName = "MEDICATIONDET";

                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["DRUGDT"].ToString().Trim() != "")
                                {
                                    row["DRUGDT"] = GeneralFunction.GetUIDateFormat(row["DRUGDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);

                                }
                                if (row["SEQNO"].ToString().Trim() != "")
                                {
                                    row["SEQNO"] = (Convert.ToInt32(row["SEQNO"]));
                                }
                            }

                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable MEDICATIONDET = new DataTable();
                            MEDICATIONDET.TableName = "MEDICATIONDET";
                            MEDICATIONDET.Columns.Add("SEQNO");
                            MEDICATIONDET.Columns.Add("DRUGNM");
                            MEDICATIONDET.Columns.Add("DOSE");
                            MEDICATIONDET.Columns.Add("FREQNCY");
                            MEDICATIONDET.Columns.Add("DRUGDT");
                            MEDICATIONDET.Columns.Add("DRUGTM");
                            dsFinalForPrint.Tables.Add(MEDICATIONDET);
                        }
                        //END

                        //CAREPLAN
                        if (load.Tables.Contains("CAREPLAN"))
                        {
                            dt = load.Tables["CAREPLAN"];
                            dt.TableName = "CAREPLAN";

                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["SEQNO"].ToString().Trim() != "")
                                {
                                    row["SEQNO"] = (Convert.ToInt32(row["SEQNO"]));
                                }
                            }
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable CAREPLAN = new DataTable();
                            CAREPLAN.TableName = "CAREPLAN";
                            CAREPLAN.Columns.Add("SEQNO");
                            CAREPLAN.Columns.Add("PLANOFCARE");
                            CAREPLAN.Columns.Add("PLANREMARK");
                            dsFinalForPrint.Tables.Add("CAREPLAN");
                        }
                        //END

                        //EDUNEEDS
                        //CAREPLAN
                        if (load.Tables.Contains("EDUNEEDS"))
                        {
                            dt = load.Tables["EDUNEEDS"];
                            dt.TableName = "EDUNEEDS";
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["SEQNO"].ToString().Trim() != "")
                                {
                                    row["SEQNO"] = (Convert.ToInt32(row["SEQNO"]));
                                }
                            }
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable EDUNEEDS = new DataTable();
                            EDUNEEDS.TableName = "EDUNEEDS";
                            EDUNEEDS.Columns.Add("SEQNO");
                            EDUNEEDS.Columns.Add("EDUNEEDS");
                            EDUNEEDS.Columns.Add("INTERVENPLAN");
                            EDUNEEDS.Columns.Add("EDUREMARK");
                            dsFinalForPrint.Tables.Add("EDUNEEDS");
                        }
                        //END
                        //END


                        //NACRITICPARAM
                        if (load.Tables.Contains("NACRITICPARAM"))
                        {
                            dt = load.Tables["NACRITICPARAM"];
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NACRITICPARAM = new DataTable("NACRITICPARAM");
                            NACRITICPARAM.TableName = "NACRITICPARAM";
                            NACRITICPARAM.Columns.Add("PERIPHRAL");
                            NACRITICPARAM.Columns.Add("PACEDRT");
                            NACRITICPARAM.Columns.Add("PATINTRNSCRT");
                            NACRITICPARAM.Columns.Add("IABPSYS");
                            NACRITICPARAM.Columns.Add("IABPDIA");
                            NACRITICPARAM.Columns.Add("IBPSYS");
                            NACRITICPARAM.Columns.Add("IBPDIA");
                            NACRITICPARAM.Columns.Add("NIBPSYS");
                            NACRITICPARAM.Columns.Add("NIBPDIA");
                            NACRITICPARAM.Columns.Add("MEWSSCORE");
                            NACRITICPARAM.Columns.Add("SPO2");
                            NACRITICPARAM.Columns.Add("RR");

                            NACRITICPARAM.Columns.Add("HGT");
                            NACRITICPARAM.Columns.Add("OXYFLOWRT");
                            dsFinalForPrint.Tables.Add(NACRITICPARAM);

                        }
                        //END
                        //HABIT
                        if (load.Tables.Contains("HABIT"))
                        {
                            dt = load.Tables["HABIT"];

                            // If the table exists but has no rows, add an empty row
                            if (dt.Rows.Count == 0)
                            {
                                DataRow emptyRow = dt.NewRow();
                                emptyRow["HABITNM"] = "";
                                emptyRow["DURATION"] = "";
                                dt.Rows.Add(emptyRow);
                            }

                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            // Create the table and add an empty row
                            DataTable habitDt = new DataTable("HABIT");
                            habitDt.Columns.Add("HABITNM");
                            habitDt.Columns.Add("DURATION");

                            DataRow emptyRow = habitDt.NewRow();
                            emptyRow["HABITNM"] = "";
                            emptyRow["DURATION"] = "";
                            habitDt.Rows.Add(emptyRow);

                            dsFinalForPrint.Tables.Add(habitDt);
                        }
                        //Pat Info Data
                        HData = GeneralFunction.getHeaderFooter("Initial Nursing Assessment", "", "", "");

                        if (HData.Rows.Count > 0 && HData.Columns.Contains("PrintDateTime"))
                        {
                            HData.Rows[0]["PrintDateTime"] =
                                GeneralFunction.ConvertDateWithTimeTo12Hour(HData.Rows[0]["PrintDateTime"].ToString());
                        }
                        HData.TableName = "HeaderFooter";
                        dsFinalForPrint.Tables.Add(HData);

                        DataTable dt1 = new DataTable();
                        dt1.TableName = "PatInfo";
                        if (dsPatInfo.Tables.Count > 0)
                        {
                            dt = dsPatInfo.Tables[0];

                            dt1.Columns.Add("IPNO");
                            dt1.Columns.Add("MRNO");
                            dt1.Columns.Add("ADMNDATE");
                            dt1.Columns.Add("PATNAME");
                            dt1.Columns.Add("ADMNTIME");
                            dt1.Columns.Add("Gender");
                            dt1.Columns.Add("PATAGE");
                            dt1.Columns.Add("CONSDOCT");
                            dt1.Columns.Add("SALUNAME");
                            dt1.Columns.Add("CURRBEDNO");
                            dt1.Columns.Add("WARDNM");
                            dt1.Columns.Add("NURSTNM");
                            dt1.Columns.Add("MLCYORN");

                            DataRow patRow = dt1.NewRow();
                            patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                            patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                            patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                            //patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                            string fullName = dt.Rows[0]["PATNAME"].ToString().Trim();
                            string[] nameParts = fullName.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

                            if (nameParts.Length == 1)
                            {
                                patRow["PATNAME"] = nameParts[0]; // only one word
                            }
                            else if (nameParts.Length > 1)
                            {
                                patRow["PATNAME"] = nameParts[0] + " " + nameParts[nameParts.Length - 1]; // first and last
                            }
                            else
                            {
                                patRow["PATNAME"] = ""; // empty or invalid
                            }

                            patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                            patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                            patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                            patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                            patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                            patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                            patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                            patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                            patRow["MLCYORN"] = dt.Rows[0]["MLCYORN"].ToString() == "Y" ? "Yes" : "No";
                            dt1.Rows.Add(patRow);
                            FileStream fs;
                            byte[] Image = new byte[0];
                            var Pic_Path = System.Web.HttpContext.Current.Server.MapPath("~/CaseDetailImages");
                            var folderPath = Path.Combine(Pic_Path, strIPNO); // folder only
                            var finalPath = Pic_Path + @"\" + strIPNO + @"\" + strIPNO + "findings" + ".png";
                            if (File.Exists(finalPath))
                            {
                                fs = new FileStream(finalPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                                Image = new byte[fs.Length];
                                fs.Read(Image, 0, Convert.ToInt32(fs.Length));
                                dsFinalForPrint.Tables["NACASEDET"].Rows[0]["CASEDTLIMG"] = Image;
                                dsFinalForPrint.Tables["NACASEDET"].Rows[0]["CASEDETIMGYN"] = "Y";
                                fs.Close();
                            }
                            else
                            {
                                if (!Directory.Exists(folderPath))
                                {
                                    Directory.CreateDirectory(folderPath);
                                }
                                dsFinalForPrint.Tables["NACASEDET"].Rows[0]["CASEDETIMGYN"] = "N";
                            }
                        }


                        dsFinalForPrint.Tables.Add(dt1);

                        if ((dsFinalForPrint.Tables.Contains("NACASEDET3") && dsFinalForPrint.Tables["NACASEDET3"].Rows.Count == 0) ||
    (dsFinalForPrint.Tables.Contains("NACASEDETAILS2") && dsFinalForPrint.Tables["NACASEDETAILS2"].Rows.Count == 0))
                        {
                            // Clear all tables from the dataset
                            dsFinalForPrint.Tables.Clear();
                        }
                        //End

                    }
                }


                return dsFinalForPrint;
            }
            catch (Exception ex)
            {
                return null;

            }
        }
        public DataSet GetNursingAssessmentDetailsNew(string strIPNO)
        {

            try
            {
                DataSet load = new DataSet();
                DataTable dt = new DataTable();
                DataSet dsFinalForPrint = new DataSet();
                GeneralFunction gen = new GeneralFunction();
                //ICUClient icuClient = new ICUClient();
                CommonServiceClient SecUser = new CommonServiceClient();
                List<UserLstItem> userLst = null;
                userLst = SecUser.GetUserList().ToList();
                DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNO, "", "", "", "", "", "", "", "", "", "", "", "", "");
                DataTable HData = new DataTable();
                load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetNursAssmntRptDetNew(strIPNO))));
                object[] objData = new object[1];

                Dictionary<string, string> PastHistName = new Dictionary<string, string>
                    {
                    { "HYPTENSYN", "Hypertension" },{ "TUBERCULYN", "Tuberculosis" },{ "DIABETMELTUYN", "Diabetes Mellitus" },{ "BLEEDISYN", "Bleeding Disorder" },
                    { "ASTHMAYN", "Asthma" },{ "RENALDISYN", "Renal Disease" },{ "STROKEYN", "Stroke" },{ "HEARTDISYN", "Heart Disease" }
                    };

                if (load.Tables.Count == 0 || load.Tables[0].Rows.Count == 0)
                {
                    objData[0] = "No Data Found";
                }
                object[] obj = new object[1];
                if (load == null)
                {
                    obj[0] = "";
                }
                else
                {
                    if (load.Tables.Count > 0)
                    {
                        //NACASEDET1
                        if (load.Tables.Contains("NACASEDET1"))
                        {
                            dt = load.Tables["NACASEDET1"];
                            DataRow dr = dt.Rows.Count > 0 ? dt.Rows[0] : null;

                            List<string> presentPastHist = new List<string>();

                            if (dr != null)
                            {
                                foreach (var kvp in PastHistName)
                                {
                                    if (dt.Columns.Contains(kvp.Key) && dr[kvp.Key] != DBNull.Value && dr[kvp.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        presentPastHist.Add(kvp.Value);
                                    }
                                }
                            }

                            string pastHistoryStr = presentPastHist.Count > 0 ? string.Join(", ", presentPastHist) : "";

                            // dt.TableName = "NACASEDET";
                            dt = load.Tables["NACASEDET1"];
                            dt.TableName = "NACASEDET";
                            dt.Columns.Add("CASEDETIMGYN");
                            dt.Rows[0]["RCVDWITH"] = dt.Rows[0]["RCVDWITH"].ToString().Trim();
                            dt.Rows[0]["VERIFIEDON"] = dt.Rows[0]["VERIFIEDON"] = GeneralFunction.GetUIDateFormat(dt.Rows[0]["VERIFIEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                            if (dt.Rows[0]["PSYILLYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["PSYILLYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["PSYILLYN"].ToString() == "N")
                            {
                                dt.Rows[0]["PSYILLYN"] = "No";
                            }
                            if (dt.Rows[0]["RELTOLOVEONEYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["RELTOLOVEONEYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["RELTOLOVEONEYN"].ToString() == "N")
                            {
                                dt.Rows[0]["RELTOLOVEONEYN"] = "No";
                            }
                            if (dt.Rows[0]["CHNGINLIFEYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["CHNGINLIFEYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["CHNGINLIFEYN"].ToString() == "N")
                            {
                                dt.Rows[0]["CHNGINLIFEYN"] = "No";
                            }
                            if (dt.Rows[0]["LEARNDIFFYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["LEARNDIFFYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["LEARNDIFFYN"].ToString() == "N")
                            {
                                dt.Rows[0]["LEARNDIFFYN"] = "No";
                            }
                            var occupatnLst = common.GetOccupLst();
                            var RelationLst = SecUser.GetRelationLst();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["OCCUPATION"].ToString().Trim() != "")
                                {
                                    //row["OCCUPATION"] = occupatnLst.Where(X => X.Value == ("" + row["OCCUPATION"]).Trim()).Count() == 0 ? "" : occupatnLst.Where(X => X.Value == row["OCCUPATION"].ToString().Trim()).FirstOrDefault().Text;
                                    row["OCCUPATION"] = GeneralFunction.GetListValue(occupatnLst, row["OCCUPATION"].ToString().Trim());
                                }
                                if (row["CREATEDON"].ToString().Trim() != "")
                                {
                                    row["CREATEDON"] = GeneralFunction.GetUIDateFormat(row["CREATEDON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["CREATEDAT"].ToString().Trim() != "")
                                {
                                    row["CREATEDAT"] = GeneralFunction.ConvertTo12HourFormat(row["CREATEDAT"].ToString().Trim());

                                }
                                if (row["ARRIVALDT"].ToString().Trim() != "")
                                {
                                    row["ARRIVALDT"] = GeneralFunction.GetUIDateFormat(row["ARRIVALDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["TMOFARRIVAL"].ToString().Trim() != "")
                                {
                                    row["TMOFARRIVAL"] = GeneralFunction.ConvertTo12HourFormat(row["TMOFARRIVAL"].ToString().Trim());
                                }

                                if (row["ARRIVALDT"].ToString().Trim() != "" && row["TMOFARRIVAL"].ToString().Trim() != "")
                                {
                                    row["ARRIVALDT"] = row["ARRIVALDT"].ToString().Trim() + "   " + row["TMOFARRIVAL"].ToString().Trim();
                                }

                                if (row["ASSSTARTDT"].ToString().Trim() != "")
                                {
                                    row["ASSSTARTDT"] = GeneralFunction.GetUIDateFormat(row["ASSSTARTDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["TMOFASSSTART"].ToString().Trim() != "")
                                {
                                    row["TMOFASSSTART"] = GeneralFunction.ConvertTo12HourFormat(row["TMOFASSSTART"].ToString().Trim());
                                }

                                if (row["ASSSTARTDT"].ToString().Trim() != "" && row["TMOFASSSTART"].ToString().Trim() != "")
                                {
                                    row["ASSSTARTDT"] = row["ASSSTARTDT"].ToString().Trim() + "   " + row["TMOFASSSTART"].ToString().Trim();
                                }

                                if (row["INASSMNTDONEBY"].ToString().Trim() != "")
                                {
                                    row["INASSMNTDONEBY"] = GeneralFunction.GetListValue(userLst, row["INASSMNTDONEBY"].ToString().Trim()) + " (" + row["INASSMNTDONEBY"].ToString().Trim() + ")";
                                }
                                if (row["ASSMCOMPDT"].ToString().Trim() != "")
                                {
                                    row["ASSMCOMPDT"] = GeneralFunction.GetUIDateFormat(row["ASSMCOMPDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                                if (row["INASCOMPTIME"].ToString().Trim() != "")
                                {
                                    row["INASCOMPTIME"] = GeneralFunction.ConvertTo12HourFormat(row["INASCOMPTIME"].ToString().Trim());
                                }
                                if (row["INASCOMPTIME"].ToString().Trim() != "" || row["ASSMCOMPDT"].ToString().Trim() != "")
                                {
                                    row["INASCOMPTIME"] = (row["ASSMCOMPDT"].ToString().Trim() + "  " + row["INASCOMPTIME"].ToString().Trim()).Trim();
                                }



                                if (row["VERIFIEDBY"].ToString().Trim() != "")
                                {
                                    row["VERIFIEDBY"] = GeneralFunction.GetListValue(userLst, row["VERIFIEDBY"].ToString().Trim()) + " (" + row["VERIFIEDBY"].ToString().Trim() + ")";
                                }
                                if (row["VERIFIEDAT"].ToString().Trim() != "")
                                {
                                    row["VERIFIEDAT"] = GeneralFunction.ConvertTo12HourFormat(row["VERIFIEDAT"].ToString().Trim());
                                }

                                if (row["VERIFIEDON"].ToString().Trim() != "" || row["VERIFIEDAT"].ToString().Trim() != "")
                                {
                                    row["VERIFIEDON"] = (row["VERIFIEDON"].ToString().Trim() + "  " + row["VERIFIEDAT"].ToString().Trim()).Trim();
                                }

                                if (row["FAMMEMNRELN"].ToString().Trim() != "")
                                {
                                    row["FAMMEMNRELN"] = GeneralFunction.GetListValue(RelationLst, row["FAMMEMNRELN"].ToString().Trim());
                                }
                                if (row["PATRELATION"].ToString().Trim() != "")
                                {
                                    row["PATRELATION"] = GeneralFunction.GetListValue(RelationLst, row["PATRELATION"].ToString().Trim());
                                }

                            }

                            dt.Rows[0]["HYPTENSYN"] = pastHistoryStr ?? string.Empty;
                            dt.Columns.Add("CASEDTLIMG", System.Type.GetType("System.Byte[]"));

                            dt = load.Tables["NACASEDET"];

                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }

                        else
                        {
                            DataTable NACASEDET = new DataTable();
                            NACASEDET.TableName = "NACASEDET";
                            NACASEDET.Columns.Add("OCCUPATION");
                            NACASEDET.Columns.Add("PSYILLYN");
                            NACASEDET.Columns.Add("PSYILLNESS");
                            NACASEDET.Columns.Add("RELTOLOVEONEYN");
                            NACASEDET.Columns.Add("RELTOLOVEONE");
                            NACASEDET.Columns.Add("CHNGINLIFEYN");
                            NACASEDET.Columns.Add("CHNGINLIFE");
                            NACASEDET.Columns.Add("LEARNDIFFYN");
                            NACASEDET.Columns.Add("LEARNDIFF");
                            NACASEDET.Columns.Add("WEIGHT");
                            NACASEDET.Columns.Add("HEIGHT");
                            NACASEDET.Columns.Add("CREATEDON");
                            NACASEDET.Columns.Add("CREATEDAT");
                            ///Added by vishal as on 2nd May 2018
                            NACASEDET.Columns.Add("INFORMANT");
                            NACASEDET.Columns.Add("MOA");
                            NACASEDET.Columns.Add("MOAOTHER");
                            NACASEDET.Columns.Add("FRMSOURCE");
                            NACASEDET.Columns.Add("OTHERSOURCE");
                            NACASEDET.Columns.Add("ADMITWITH");
                            NACASEDET.Columns.Add("UNITORIENTYN");
                            NACASEDET.Columns.Add("CELLBELLYN");
                            NACASEDET.Columns.Add("INFORMTODR");
                            NACASEDET.Columns.Add("INFORMTODIET");
                            NACASEDET.Columns.Add("INFORMPANTRY");
                            NACASEDET.Columns.Add("INFORMTOHK");
                            NACASEDET.Columns.Add("INASCOMPTIME");
                            NACASEDET.Columns.Add("INASSMNTDONEBY");
                            NACASEDET.Columns.Add("INFORMANTOTHER");
                            NACASEDET.Columns.Add("PATRELATION");
                            NACASEDET.Columns.Add("PATRELNAME");
                            NACASEDET.Columns.Add("CASEDTLIMG", System.Type.GetType("System.Byte[]"));

                            NACASEDET.Columns.Add("PROVDIAG");
                            NACASEDET.Columns.Add("FAMHIST");
                            NACASEDET.Columns.Add("TREATMNTADVICE");
                            NACASEDET.Columns.Add("DIAGNOSIS");
                            NACASEDET.Columns.Add("PASTHISTORY");
                            NACASEDET.Columns.Add("CASEOF");
                            NACASEDET.Columns.Add("COMPLAINT");
                            NACASEDET.Columns.Add("GYNACHISTORY");
                            NACASEDET.Columns.Add("PLANOFCARE");
                            NACASEDET.Columns.Add("PREVASPECT");
                            NACASEDET.Columns.Add("OTHERINVEST");
                            NACASEDET.Columns.Add("RCVDWITH");
                            NACASEDET.Columns.Add("TMOFARRIVAL");
                            NACASEDET.Columns.Add("TMOFASSSTART");
                            NACASEDET.Columns.Add("ARRIVALDT");
                            NACASEDET.Columns.Add("ASSSTARTDT");
                            NACASEDET.Columns.Add("HYPTENSYN");
                            NACASEDET.Columns.Add("TUBERCULYN");
                            NACASEDET.Columns.Add("OTHPASTHISYN");
                            NACASEDET.Columns.Add("OTHPASTHISDET");
                            NACASEDET.Columns.Add("DIABETMELTUYN");
                            NACASEDET.Columns.Add("BLEEDISYN");
                            NACASEDET.Columns.Add("ASTHMAYN");
                            NACASEDET.Columns.Add("RENALDISYN");
                            NACASEDET.Columns.Add("PASTSURGYN");
                            NACASEDET.Columns.Add("STROKEYN");
                            NACASEDET.Columns.Add("HEARTDISYN");
                            NACASEDET.Columns.Add("VULNRBLYN");
                            NACASEDET.Columns.Add("PASTSURGNM");
                            NACASEDET.Columns.Add("BMI");
                            NACASEDET.Columns.Add("BSA");
                            NACASEDET.Columns.Add("EF");
                            NACASEDET.Columns.Add("IDBANDYN");
                            NACASEDET.Columns.Add("SIDERAILYN");
                            NACASEDET.Columns.Add("BSIDESYN");
                            NACASEDET.Columns.Add("VERIFIEDBY");
                            NACASEDET.Columns.Add("VERIFIEDON");
                            NACASEDET.Columns.Add("VERIFIEDAT");
                            NACASEDET.Columns.Add("FAMMEMBNM");
                            NACASEDET.Columns.Add("FAMMEMNRELN");
                            NACASEDET.Columns.Add("ICUNSYN");
                            NACASEDET.Columns.Add("TLNAME");
                            dsFinalForPrint.Tables.Add(NACASEDET);
                        }
                        //END

                        //NACASEDETAILS2
                        Dictionary<string, string> INVASIVENAME = new Dictionary<string, string>
                    {
                        { "IVCANULAYN", "IV Cannula" },{ "PICCYN", "PICC" },{ "PORTACCYN", "Port Access" },{ "DRAINYN", "Drain" },{ "AVFISTULA", "AV Fistula" },
                        { "ETTUBEYN", "ET Tube" },{ "ICDYN", "ICD" },{ "FOLCATHYN", "Foley's Catheter" },{ "CVLINEYN", "Central Venous Line" },{ "PERICATHYN", "Pericardial Catheter" },
                        { "CONDRAINYN", "Condom Drainage" },{ "RYLTUBFDYN", "Ryle’s Tube (Feeding)" },{ "RYLTUBASPYN", "Ryle’s Tube (aspiration)" },
                        { "NEPHROTBYN", "Nephrostomy Tube" },{ "SUPPUBCATYN", "Supra Public Catheter" }
                    };
                        Dictionary<string, string> BLDMANFSTNAME = new Dictionary<string, string>
                    {
                        { "CONJBLDYN", "Conjunctival Bleed" },{ "EPISTAXYN", "Epistaxis" },{ "GUMBLDYN", "Gum Bleed" },
                        { "ORALBLDYN", "Oral Mucosa Bleed" },{ "HEMATBLDYN", "Hematemesis" },{ "HAEMOPTBLDYN", "Haemoptysis" },
                        { "PUNCBLDYN", "From Puncture Site" },{ "PRBLDYN", "Bleeding PR" },{ "MALENABLDYN", "Malena" },
                        { "HAEMATUBLDYN", "Haematuria" },{ "PVBLDYN", "Bleeding PV" },{ "TUMORBLDYN", "Tumour Site Bleed" }
                    };
                        Dictionary<string, string> MONTHLYSBE1 = new Dictionary<string, string>
                    {
                        { "FLUMPYN", "Lumps" },{ "FBRSTFEEDYN", "Breast Feeding" }
                    };
                        Dictionary<string, string> MONTHLYSBE2 = new Dictionary<string, string>
                    {
                        { "FNIPLDISYN", "Nipple Discharge" },{ "FDIMPYN", "Dimpling" },{ "FSYMYN", "Symmetry" },{ "FNIPINVYN", "Nipple Inversion" },
                        { "FPAINYN", "Pain" }
                    };
                        Dictionary<string, string> MENOPAUSAL = new Dictionary<string, string>
                    {
                        { "FVAGDISYN", "Vaginal Discharg" },{ "FVAGITCHYN", "Itching" },{ "FVAGDISMENYN", "Dysmenorrhoea" },
                        { "FVAGAMENORYN", "Amenorrhoea" },{ "FVAGINFECYN", "H/o Infections" }
                    };
                        Dictionary<string, string> MALEREP = new Dictionary<string, string>
                    {
                        { "MPENILDISYN", "Penile Discharge" },{ "MITCHINGYN", "Itching" },{ "MHERNIAYN", "Hernia" },
                        { "MTESTLUMPYN", "Testicular Lumps" },{ "MINFECTHYN", "H/o Infections" }
                    };
                        if (load.Tables.Contains("NACASEDET2"))
                        {

                            dt = load.Tables["NACASEDET2"];
                            DataRow dr = dt.Rows.Count > 0 ? dt.Rows[0] : null;

                            List<string> invasiveLinechk = new List<string>(); List<string> bldmnsfchk = new List<string>();
                            List<string> montlychk1 = new List<string>(); List<string> montlychk2 = new List<string>();
                            List<string> menopauschk = new List<string>();
                            List<string> malerepochk = new List<string>();

                            if (dr != null)
                            {
                                foreach (var inv in INVASIVENAME)
                                {
                                    if (dt.Columns.Contains(inv.Key) && dr[inv.Key] != DBNull.Value && dr[inv.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        invasiveLinechk.Add(inv.Value);
                                    }
                                }
                                foreach (var BLDMNFS in BLDMANFSTNAME)
                                {
                                    if (dt.Columns.Contains(BLDMNFS.Key) && dr[BLDMNFS.Key] != DBNull.Value && dr[BLDMNFS.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        bldmnsfchk.Add(BLDMNFS.Value);
                                    }
                                }
                                foreach (var SBE1 in MONTHLYSBE1)
                                {
                                    if (dt.Columns.Contains(SBE1.Key) && dr[SBE1.Key] != DBNull.Value && dr[SBE1.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        montlychk1.Add(SBE1.Value);
                                    }
                                }
                                foreach (var SBE2 in MONTHLYSBE2)
                                {
                                    if (dt.Columns.Contains(SBE2.Key) && dr[SBE2.Key] != DBNull.Value && dr[SBE2.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        montlychk2.Add(SBE2.Value);
                                    }
                                }
                                foreach (var MENUP in MENOPAUSAL)
                                {
                                    if (dt.Columns.Contains(MENUP.Key) && dr[MENUP.Key] != DBNull.Value && dr[MENUP.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        menopauschk.Add(MENUP.Value);
                                    }
                                }
                                foreach (var MALE in MALEREP)
                                {
                                    if (dt.Columns.Contains(MALE.Key) && dr[MALE.Key] != DBNull.Value && dr[MALE.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        malerepochk.Add(MALE.Value);
                                    }
                                }

                            }

                            string INVASIVENAMEStr = invasiveLinechk.Count > 0 ? string.Join(", ", invasiveLinechk) : "";

                            string BLDMNFSTStr = bldmnsfchk.Count > 0 ? string.Join(", ", bldmnsfchk) : "";

                            string MONTHLYSBEStr1 = montlychk1.Count > 0 ? string.Join(", ", montlychk1) : "";
                            string MONTHLYSBEStr2 = montlychk2.Count > 0 ? string.Join(", ", montlychk2) : "";
                            string MENOPAUSALStr = menopauschk.Count > 0 ? string.Join(", ", menopauschk) : "";
                            string MALEREPStr = malerepochk.Count > 0 ? string.Join(",", malerepochk) : "";

                            dt.TableName = "NACASEDETAILS2";

                            if (dt.Rows.Count > 0)
                            {
                                //foreach (DataRow dr in dt.Rows)
                                //{
                                dt.Rows[0]["IVCANULAYN"] = INVASIVENAMEStr ?? string.Empty;
                                dt.Rows[0]["CONJBLDYN"] = BLDMNFSTStr ?? string.Empty;
                                dt.Rows[0]["FLUMPYN"] = MONTHLYSBEStr1 ?? string.Empty;
                                dt.Rows[0]["FNIPLDISYN"] = MONTHLYSBEStr2 ?? string.Empty;
                                dt.Rows[0]["FVAGDISYN"] = MENOPAUSALStr ?? string.Empty;
                                dt.Rows[0]["MPENILDISYN"] = MALEREPStr ?? string.Empty;
                                //}
                                if (dt.Rows[0]["DIETHABIT"].ToString().Trim() == "O")
                                {
                                    dt.Rows[0]["DIETHABIT"] = "Other";
                                }
                                else if (dt.Rows[0]["DIETHABIT"].ToString().Trim() == "V")
                                {
                                    dt.Rows[0]["DIETHABIT"] = "Vegetarian";
                                }
                                else if (dt.Rows[0]["DIETHABIT"].ToString().Trim() == "N")
                                {
                                    dt.Rows[0]["DIETHABIT"] = "Non-Vegetarian";
                                }

                                if (dt.Rows[0]["READENGYN"].ToString().Trim() == "Y")
                                {
                                    dt.Rows[0]["READENGYN"] = "Yes";
                                }
                                else if (dt.Rows[0]["READENGYN"].ToString().Trim() == "N")
                                {
                                    dt.Rows[0]["READENGYN"] = "No";
                                }

                                if (dt.Rows[0]["CULTCONSIYN"].ToString().Trim() == "Y")
                                {
                                    dt.Rows[0]["CULTCONSIYN"] = "Yes";
                                }
                                else if (dt.Rows[0]["CULTCONSIYN"].ToString().Trim() == "N")
                                {
                                    dt.Rows[0]["CULTCONSIYN"] = "No";
                                }
                                else if (dt.Rows[0]["CULTCONSIYN"].ToString().Trim() == "O")
                                {
                                    dt.Rows[0]["CULTCONSIYN"] = "Other";
                                }


                                var MaleBrstList = GeneralFunction.GetMaleBrstList();
                                foreach (DataRow row in dt.Rows)
                                {
                                    row["MALEBRESTCD"] = GeneralFunction.GetListValue(MaleBrstList, row["MALEBRESTCD"].ToString().Trim());

                                }
                                var EmotionalStat = GeneralFunction.GetEmotionalStatusList();
                                foreach (DataRow row in dt.Rows)
                                {
                                    if (row["EMOTSTAT"].ToString().Trim() != "")
                                    {
                                        row["EMOTSTAT"] = GeneralFunction.GetListValue(EmotionalStat, row["EMOTSTAT"].ToString().Trim());
                                    }
                                    if (row["SECVERIFBY"].ToString().Trim() != "")
                                    {
                                        row["SECVERIFBY"] = GeneralFunction.GetListValue(userLst, row["SECVERIFBY"].ToString().Trim()) + " (" + row["SECVERIFBY"].ToString().Trim() + ")";
                                    }
                                    if (row["SECASMNDONEBY"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEBY"] = GeneralFunction.GetListValue(userLst, row["SECASMNDONEBY"].ToString().Trim()) + " (" + row["SECASMNDONEBY"].ToString().Trim() + ")";
                                    }
                                    if (row["SECVERIFON"].ToString().Trim() != "")
                                    {
                                        row["SECVERIFON"] = GeneralFunction.GetUIDateFormat(row["SECVERIFON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["SECVERIFAT"].ToString().Trim() != "")
                                    {
                                        row["SECVERIFAT"] = GeneralFunction.ConvertTo12HourFormat(row["SECVERIFAT"].ToString().Trim());
                                    }

                                    if (row["SECVERIFON"].ToString().Trim() != "" || row["SECVERIFAT"].ToString().Trim() != "")
                                    {
                                        row["SECVERIFON"] = (row["SECVERIFON"].ToString().Trim() + "  " + row["SECVERIFAT"].ToString().Trim()).Trim();
                                    }
                                    if (row["SECASMNDONEON"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEON"] = GeneralFunction.GetUIDateFormat(row["SECASMNDONEON"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["SECASMNDONEAT"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEAT"] = GeneralFunction.ConvertTo12HourFormat(row["SECASMNDONEAT"].ToString().Trim());
                                    }

                                    if (row["SECASMNDONEON"].ToString().Trim() != "" || row["SECASMNDONEAT"].ToString().Trim() != "")
                                    {
                                        row["SECASMNDONEON"] = (row["SECASMNDONEON"].ToString().Trim() + "  " + row["SECASMNDONEAT"].ToString().Trim()).Trim();
                                    }
                                    if (row["FLSTDREXAMDT"].ToString().Trim() != "")
                                    {
                                        row["FLSTDREXAMDT"] = GeneralFunction.GetUIDateFormat(row["FLSTDREXAMDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["FMAMOGDT"].ToString().Trim() != "")
                                    {
                                        row["FMAMOGDT"] = GeneralFunction.GetUIDateFormat(row["FMAMOGDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["FLMPDT"].ToString().Trim() != "")
                                    {
                                        row["FLMPDT"] = GeneralFunction.GetUIDateFormat(row["FLMPDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["FLASTPAP"].ToString().Trim() != "")
                                    {
                                        row["FLASTPAP"] = GeneralFunction.GetUIDateFormat(row["FLASTPAP"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["LSTPRPEXAMDT"].ToString().Trim() != "")
                                    {
                                        row["LSTPRPEXAMDT"] = GeneralFunction.GetUIDateFormat(row["LSTPRPEXAMDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["LSTPSADT"].ToString().Trim() != "")
                                    {
                                        row["LSTPSADT"] = GeneralFunction.GetUIDateFormat(row["LSTPSADT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["SECSTARTDT"].ToString().Trim() != "")
                                    {
                                        row["SECSTARTDT"] = GeneralFunction.GetUIDateFormat(row["SECSTARTDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                    }
                                    if (row["SECSTARTTM"].ToString().Trim() != "")
                                    {
                                        row["SECSTARTTM"] = GeneralFunction.ConvertTo12HourFormat(row["SECSTARTTM"].ToString().Trim());
                                    }

                                    if (row["SECSTARTDT"].ToString().Trim() != "" && row["SECSTARTTM"].ToString().Trim() != "")
                                    {
                                        row["SECSTARTDT"] = row["SECSTARTDT"].ToString().Trim() + "   " + row["SECSTARTTM"].ToString().Trim();
                                    }

                                }


                            }
                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());

                        }
                        else
                        {
                            DataTable NACASEDETAILS2 = new DataTable();
                            NACASEDETAILS2.Columns.Add("IVLINENSF");
                            NACASEDETAILS2.Columns.Add("IVCANULAYN");
                            NACASEDETAILS2.Columns.Add("PICCYN");
                            NACASEDETAILS2.Columns.Add("PORTACCYN");
                            NACASEDETAILS2.Columns.Add("DRAINYN");
                            NACASEDETAILS2.Columns.Add("AVFISTULA");
                            NACASEDETAILS2.Columns.Add("ETTUBEYN");
                            NACASEDETAILS2.Columns.Add("ICDYN");
                            NACASEDETAILS2.Columns.Add("FOLCATHYN");
                            NACASEDETAILS2.Columns.Add("CVLINEYN");
                            NACASEDETAILS2.Columns.Add("PERICATHYN");
                            NACASEDETAILS2.Columns.Add("CONDRAINYN");
                            NACASEDETAILS2.Columns.Add("RYLTUBFDYN");
                            NACASEDETAILS2.Columns.Add("RYLTUBASPYN");
                            NACASEDETAILS2.Columns.Add("NEPHROTBYN");
                            NACASEDETAILS2.Columns.Add("SUPPUBCATYN");
                            NACASEDETAILS2.Columns.Add("INVASREMARK");
                            NACASEDETAILS2.Columns.Add("EDUCLEVEL");
                            NACASEDETAILS2.Columns.Add("PRIMLANG");
                            NACASEDETAILS2.Columns.Add("READENGYN");
                            NACASEDETAILS2.Columns.Add("BARTOLEARN");
                            NACASEDETAILS2.Columns.Add("DIETHABIT");
                            NACASEDETAILS2.Columns.Add("DIETOTHDET");
                            NACASEDETAILS2.Columns.Add("CONDRAINYN");
                            NACASEDETAILS2.Columns.Add("CULTCONSIYN");
                            NACASEDETAILS2.Columns.Add("CULTCONSIDET");
                            NACASEDETAILS2.Columns.Add("EMOTSTAT");
                            NACASEDETAILS2.Columns.Add("PSYCCULREMK");
                            NACASEDETAILS2.Columns.Add("HEMATOYN");
                            NACASEDETAILS2.Columns.Add("BRUSINGYN");
                            NACASEDETAILS2.Columns.Add("BRUSINGDET");
                            NACASEDETAILS2.Columns.Add("BLDTRANYN");
                            NACASEDETAILS2.Columns.Add("BLDTRANDET");
                            NACASEDETAILS2.Columns.Add("HBRESULT");
                            NACASEDETAILS2.Columns.Add("TLCRESULT");
                            NACASEDETAILS2.Columns.Add("NRESULT");
                            NACASEDETAILS2.Columns.Add("LRESULT");
                            NACASEDETAILS2.Columns.Add("ERESULT");
                            NACASEDETAILS2.Columns.Add("BRESULT");
                            NACASEDETAILS2.Columns.Add("MRESULT");
                            NACASEDETAILS2.Columns.Add("PLATRESULT");
                            NACASEDETAILS2.Columns.Add("BUNRESULT");
                            NACASEDETAILS2.Columns.Add("SERUMRESULT");
                            NACASEDETAILS2.Columns.Add("FREPRODTYN");
                            NACASEDETAILS2.Columns.Add("FBREASTS");
                            NACASEDETAILS2.Columns.Add("FMNTHSBEYN");
                            NACASEDETAILS2.Columns.Add("FLUMPYN");
                            NACASEDETAILS2.Columns.Add("FBRSTFEEDYN");
                            NACASEDETAILS2.Columns.Add("FLSTDREXAMDT");
                            NACASEDETAILS2.Columns.Add("FMAMOGDT");
                            NACASEDETAILS2.Columns.Add("FNIPLDISYN");
                            NACASEDETAILS2.Columns.Add("FDIMPYN");
                            NACASEDETAILS2.Columns.Add("FSYMYN");
                            NACASEDETAILS2.Columns.Add("FNIPINVYN");
                            NACASEDETAILS2.Columns.Add("FPAINYN");
                            NACASEDETAILS2.Columns.Add("FLMPDT");
                            NACASEDETAILS2.Columns.Add("FG");
                            NACASEDETAILS2.Columns.Add("FP");
                            NACASEDETAILS2.Columns.Add("FA");
                            NACASEDETAILS2.Columns.Add("FLASTPAP");
                            NACASEDETAILS2.Columns.Add("FMENOPYN");
                            NACASEDETAILS2.Columns.Add("FMENOPDUR");
                            NACASEDETAILS2.Columns.Add("FVAGDISYN");
                            NACASEDETAILS2.Columns.Add("FVAGITCHYN");
                            NACASEDETAILS2.Columns.Add("FVAGDISMENYN");
                            NACASEDETAILS2.Columns.Add("FVAGAMENORYN");
                            NACASEDETAILS2.Columns.Add("FVAGINFECYN");
                            NACASEDETAILS2.Columns.Add("FREPRREMARK");
                            NACASEDETAILS2.Columns.Add("MREPRODYN");
                            NACASEDETAILS2.Columns.Add("MBRESTREMARK");
                            NACASEDETAILS2.Columns.Add("LSTPRPEXAMDT");
                            NACASEDETAILS2.Columns.Add("LSTPSADT");
                            NACASEDETAILS2.Columns.Add("MPENILDISYN");
                            NACASEDETAILS2.Columns.Add("MITCHINGYN");
                            NACASEDETAILS2.Columns.Add("MHERNIAYN");
                            NACASEDETAILS2.Columns.Add("MTESTLUMPYN");
                            NACASEDETAILS2.Columns.Add("MINFECTHYN");
                            NACASEDETAILS2.Columns.Add("MALEREMARK");
                            NACASEDETAILS2.Columns.Add("VENACAVTOL");
                            NACASEDETAILS2.Columns.Add("SECSTARTDT");
                        }
                        //END
                        if (load.Tables.Contains("OTHENURSASS"))
                        {
                            dt = load.Tables["OTHENURSASS"];


                            dt.TableName = "OTHENURSASS";

                            if (dt.Rows.Count > 0)
                            {
                                dt.AcceptChanges();
                                dsFinalForPrint.Tables.Add(dt.Copy());
                            }
                        }
                        else
                        {
                            DataTable OTHENURSASS = new DataTable();
                            OTHENURSASS.Columns.Add("NSCORE");
                        }
                        //NACASEDET3
                        Dictionary<string, string> OSTOMYNAME = new Dictionary<string, string>
                    {
                        { "OTCOLOSTYN", "Colostomy" },{ "OTURETEROYN", "Ureterostomy" },{ "OTILEOSTOMYN", "Ileostomy" },
                        { "OTNEPHROSYN", "Nephrostomy" },{ "OTSUPRCYSTOSYN", "Suprapubic Cystostomy" },
                        { "OTTRACHEOSYN", "Tracheostomy" },{ "OTGASTROSYN", "Gastrostomy" },{ "OTJEJUNOSYN", "Jejunostomy" }
                    };

                        Dictionary<string, string> EYESNAME = new Dictionary<string, string>
                        {
                            { "VSLIMPRVYN", "Visual Impairment" },{ "INFMATIONYN", "Inflammation" },{ "EYEPAINYN", "Pain" },
                            { "EYEITCHYN", "Itching" },{ "EYEDISHRGYN", "Discharge" }
                        };
                        Dictionary<string, string> EARNAME = new Dictionary<string, string>
                        {
                            { "ERIMPHEAYN", "Impaired Hearing – R/L" },{ "ERDEAFYN", "Deaf" },{ "ERTINNIYN", "Tinnitus" },
                            { "ERDIZZIYN", "Dizziness" },{ "ERDISCHRGYN", "Discharge" },{ "ERPAINYN", "Pain" }
                        };
                        Dictionary<string, string> NOSENAME = new Dictionary<string, string>
                        {
                            { "NSCONGYN", "Congestion" },{ "NSPAINYN", "Pain" },{ "NSGROWYN", "Growth" },
                            { "NSSINUSYN", "Sinus problem" },{ "NSDISHRGYN", "Discharge" },{ "NSBLEDYN", "Nose bleeds" }
                        };
                        Dictionary<string, string> MOUTHNAME = new Dictionary<string, string>
                        {
                            { "MHALITOSISYN", "Halitosis" },{ "MOUTHPAINYN", "Pain" },{ "MBLDGUMSYN", "Bleeding Gums" },
                            { "MSTOMATITISYN", "Stomatitis" },{ "MLOSSTASTEYN", "Loss of taste" },{ "MDENTALHYGNYN", "Dental Hygiene" }
                        };
                        Dictionary<string, string> THRTNECKNAME = new Dictionary<string, string>
                        {
                            { "THRTSOREYN", "Sore throat" },{ "THRTHOARSEYN", "Hoarseness" },{ "THRTLUMPSYN", "Lumps" },{ "THRTSWLGLNDSYN", "Swollen glands" },
                            { "THRTSTIFYN", "Stiffness" },{ "THRTPAINYN", "Pain" },{ "THRTDYSPHAGIAYN", "Dysphagia" }
                        };

                        Dictionary<string, string> CARDIONAME = new Dictionary<string, string>
                    {
                        { "CVSFATIGUEYN", "Fatigue" },{ "CVSPALPITATIONYN", "Palpitation" },{ "CVSSYNCOPEYN", "Syncope" },{ "CVSCHTPAINYN", "Chest Pain" },
                        { "CVSORTHOPNOEAYN", "Orthopnoea" },{ "CVSPACEMAKERYN", "Pacemaker" },{ "CVSNCKVNDISTYN", "Neck Vein Distension" },
                        { "CVSCYANOSISYN", "Cyanosis" }
                    };
                        Dictionary<string, string> RESPNAME = new Dictionary<string, string>
                    {
                        { "RESPCOUGYN", "Cough" },{ "RESPSPUTYN", "Sputum" },{ "RESPBRADYN", "Bradypnoea" },{ "RESPDYSPYN", "Dyspnoea" },
                        { "RESPTACHYYN", "Tachypnoea" },{ "RESPSTRIDOYN", "Stridor" },{ "RESPSOTHRPYN", "O2 Therapy" }
                    };
                        Dictionary<string, string> GASTRONAME = new Dictionary<string, string>
                    {
                        { "GASDENTURESYN", "Dentures" },{ "GASLOOSTTHYN", "Loose Teeth" },{ "GASTONGCOATYN", "Tongue Coated" },{ "GASNAUSEAYN", "Nausea" },{ "GASVOMITYN", "Vomiting" },
                        { "GASDYSPHAGIAYN", "Dysphagia" },{ "BOWOPENYN", "Bowel Opened" },{ "GASCONSTIYN", "Constipation" },{ "GASDIARYN", "Diarrhoea" },
                        { "GASASCYN", "Ascites" },{ "GASPROCYN", "Proctitis" },
                        { "GASHAEMORYN", "Haemorrhoids" }
                    };
                        Dictionary<string, string> SKINNAME = new Dictionary<string, string>
                    {
                        { "SKLWEAKYN", "Weakness" },{ "SKLTEMORSYN", "Tremors" },
                        { "SKLDEFORYN", "Deformity" },{ "SKLRESTRYN", "Restraints" },{ "SKLFRACYN", "Fracture" },
                        { "SKLMUSCJOINTPNYN", "Muscle/Joint Pain" }
                    };

                        Dictionary<string, string> GENITONAME = new Dictionary<string, string>
                    {
                        { "GENFREQYN", "Frequency" },{ "GENFLNKPLNYN", "Flank Pain" },
                        { "GENURGENYN", "Urgency" },{ "GENHOCALCUYN", "H/o Calculi" },{ "GENDYSURIYN", "Dysuria" },
                        { "GENRETENSYN", "Retention" },
                        { "GENINCONTINYN", "Incontinence" },{ "GENUTIYN", "H/o UTI" },
                        { "GENOBSFLOW", "Obstructed Flow" },{ "GENHAEMOCYSTIYN", "Haemorrhagic Cystitis" },{ "GENUROSTOMYN", "Urostomy" },
                    };

                        if (load.Tables.Contains("NACASEDET3"))
                        {
                            dt = load.Tables["NACASEDET3"];
                            DataRow dr = dt.Rows.Count > 0 ? dt.Rows[0] : null;

                            List<string> ostomychk = new List<string>(); List<string> cardiochk = new List<string>();
                            List<string> respchk = new List<string>(); List<string> gaschk = new List<string>();
                            List<string> sknchk = new List<string>(); List<string> genitochk = new List<string>();
                            List<string> eyeschk = new List<string>();
                            List<string> earchk = new List<string>();
                            List<string> nosechk = new List<string>();
                            List<string> mouthchk = new List<string>();
                            List<string> thrneckchk = new List<string>();
                            if (dr != null)
                            {

                                foreach (var OSTMY in OSTOMYNAME)
                                {
                                    if (dt.Columns.Contains(OSTMY.Key) && dr[OSTMY.Key] != DBNull.Value && dr[OSTMY.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        ostomychk.Add(OSTMY.Value);
                                    }
                                }
                                foreach (var CARDIO in CARDIONAME)
                                {
                                    if (dt.Columns.Contains(CARDIO.Key) && dr[CARDIO.Key] != DBNull.Value && dr[CARDIO.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        cardiochk.Add(CARDIO.Value);
                                    }
                                }
                                foreach (var RESP in RESPNAME)
                                {
                                    if (dt.Columns.Contains(RESP.Key) && dr[RESP.Key] != DBNull.Value && dr[RESP.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        respchk.Add(RESP.Value);
                                    }
                                }
                                foreach (var GAS in GASTRONAME)
                                {
                                    if (dt.Columns.Contains(GAS.Key) && dr[GAS.Key] != DBNull.Value && dr[GAS.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        gaschk.Add(GAS.Value);
                                    }
                                }
                                foreach (var SKN in SKINNAME)
                                {
                                    if (dt.Columns.Contains(SKN.Key) && dr[SKN.Key] != DBNull.Value && dr[SKN.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        sknchk.Add(SKN.Value);
                                    }
                                }
                                foreach (var GNT in GENITONAME)
                                {
                                    if (dt.Columns.Contains(GNT.Key) && dr[GNT.Key] != DBNull.Value && dr[GNT.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        genitochk.Add(GNT.Value);
                                    }
                                }
                                foreach (var EYES in EYESNAME)
                                {
                                    if (dt.Columns.Contains(EYES.Key) && dr[EYES.Key] != DBNull.Value && dr[EYES.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        eyeschk.Add(EYES.Value);
                                    }
                                }
                                foreach (var EAR in EARNAME)
                                {
                                    if (dt.Columns.Contains(EAR.Key) && dr[EAR.Key] != DBNull.Value && dr[EAR.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        earchk.Add(EAR.Value);
                                    }
                                }
                                foreach (var NOSE in NOSENAME)
                                {
                                    if (dt.Columns.Contains(NOSE.Key) && dr[NOSE.Key] != DBNull.Value && dr[NOSE.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        nosechk.Add(NOSE.Value);
                                    }
                                }
                                foreach (var MOUTH in MOUTHNAME)
                                {
                                    if (dt.Columns.Contains(MOUTH.Key) && dr[MOUTH.Key] != DBNull.Value && dr[MOUTH.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        mouthchk.Add(MOUTH.Value);
                                    }
                                }
                                foreach (var THRTNECK in THRTNECKNAME)
                                {
                                    if (dt.Columns.Contains(THRTNECK.Key) && dr[THRTNECK.Key] != DBNull.Value && dr[THRTNECK.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        thrneckchk.Add(THRTNECK.Value);
                                    }
                                }
                            }
                            string OSTOMYStr = ostomychk.Count > 0 ? string.Join(", ", ostomychk) : "";
                            string CARDIOStr = cardiochk.Count > 0 ? string.Join(", ", cardiochk) : "";
                            string RESPtr = respchk.Count > 0 ? string.Join(", ", respchk) : "";
                            string GASStr = gaschk.Count > 0 ? string.Join(", ", gaschk) : "";
                            string SKNStr = sknchk.Count > 0 ? string.Join(", ", sknchk) : "";
                            string GentStr = genitochk.Count > 0 ? string.Join(", ", genitochk) : "";
                            string EYESstr = eyeschk.Count > 0 ? string.Join(", ", eyeschk) : "";
                            string EARSTStr = earchk.Count > 0 ? string.Join(", ", earchk) : "";
                            string NOSEStr = nosechk.Count > 0 ? string.Join(", ", nosechk) : "";
                            string MOUTHStr = mouthchk.Count > 0 ? string.Join(", ", mouthchk) : "";
                            string THRTNECStr = thrneckchk.Count > 0 ? string.Join(", ", thrneckchk) : "";


                            if (dt.Rows.Count > 0)
                            {
                                dt.Rows[0]["OTCOLOSTYN"] = OSTOMYStr ?? string.Empty;
                                dt.Rows[0]["CVSFATIGUEYN"] = CARDIOStr ?? string.Empty;
                                dt.Rows[0]["RESPCOUGYN"] = RESPtr ?? string.Empty;
                                dt.Rows[0]["GASDENTURESYN"] = GASStr ?? string.Empty;
                                dt.Rows[0]["SKLWEAKYN"] = SKNStr ?? string.Empty;
                                dt.Rows[0]["GENFREQYN"] = GentStr ?? string.Empty;
                                dt.Rows[0]["VSLIMPRVYN"] = EYESstr ?? string.Empty;
                                dt.Rows[0]["ERIMPHEAYN"] = EARSTStr ?? string.Empty;
                                dt.Rows[0]["NSCONGYN"] = NOSEStr ?? string.Empty;
                                dt.Rows[0]["MHALITOSISYN"] = MOUTHStr ?? string.Empty;
                                dt.Rows[0]["THRTSOREYN"] = THRTNECStr ?? string.Empty;


                                if (dt.Rows[0]["CVSPULREGIRREGYN"].ToString() == "R")
                                {
                                    dt.Rows[0]["CVSPULREGIRREGYN"] = "Regular";
                                }
                                else if (dt.Rows[0]["CVSPULREGIRREGYN"].ToString() == "I")
                                {
                                    dt.Rows[0]["CVSPULREGIRREGYN"] = "Irregular";
                                }


                                if (dt.Rows[0]["ORALMMS"].ToString() == "O")
                                {
                                    dt.Rows[0]["ORALMMS"] = "Moderate";
                                }
                                else if (dt.Rows[0]["ORALMMS"].ToString() == "M")
                                {
                                    dt.Rows[0]["ORALMMS"] = "Mild";
                                }
                                else if (dt.Rows[0]["ORALMMS"].ToString() == "S")
                                {
                                    dt.Rows[0]["ORALMMS"] = "Servere";
                                }

                                if (dt.Rows[0]["SKINROMFULREST"].ToString() == "F")
                                {
                                    dt.Rows[0]["SKINROMFULREST"] = "Full";
                                }
                                else if (dt.Rows[0]["SKINROMFULREST"].ToString() == "R")
                                {
                                    dt.Rows[0]["SKINROMFULREST"] = "Restricted";
                                }



                                if (dt.Rows[0]["SKINTURGGP"].ToString() == "G")
                                {
                                    dt.Rows[0]["SKINTURGGP"] = "Good";
                                }
                                else if (dt.Rows[0]["SKINTURGGP"].ToString() == "P")
                                {
                                    dt.Rows[0]["SKINTURGGP"] = "Poor";
                                }


                                if (dt.Rows[0]["GENCATHFS"].ToString() == "F")
                                {
                                    dt.Rows[0]["GENCATHFS"] = "Foley's";
                                }
                                else if (dt.Rows[0]["GENCATHFS"].ToString() == "S")
                                {
                                    dt.Rows[0]["GENCATHFS"] = "Suprapubic";
                                }

                                if (dt.Rows[0]["LASTDENEXAMINEYN"].ToString().Trim() != "")
                                {
                                    dt.Rows[0]["LASTDENEXAMINEYN"] = GeneralFunction.GetUIDateFormat(dt.Rows[0]["LASTDENEXAMINEYN"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);
                                }
                            }
                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());

                        }
                        else
                        {
                            DataTable NACASEDET3 = new DataTable();
                            NACASEDET3.Columns.Add("EYESNSFYN");
                            NACASEDET3.Columns.Add("VSLIMPRVYN");
                            NACASEDET3.Columns.Add("INFMATIONYN");
                            NACASEDET3.Columns.Add("EYEPAINYN");
                            NACASEDET3.Columns.Add("EYEDISHRGYN");
                            NACASEDET3.Columns.Add("EYEREMARK");
                            NACASEDET3.Columns.Add("EARNSFYN");
                            NACASEDET3.Columns.Add("ERIMPHEAYN");
                            NACASEDET3.Columns.Add("ERDEAFYN");
                            NACASEDET3.Columns.Add("ERTINNIYN");
                            NACASEDET3.Columns.Add("ERDIZZIYN");
                            NACASEDET3.Columns.Add("ERDISCHRGYN");
                            NACASEDET3.Columns.Add("ERPAINYN");
                            NACASEDET3.Columns.Add("ERREMARK");
                            NACASEDET3.Columns.Add("NOSENSFYN");
                            NACASEDET3.Columns.Add("NSCONGYN");
                            NACASEDET3.Columns.Add("NSPAINYN");
                            NACASEDET3.Columns.Add("NSGROWYN");
                            NACASEDET3.Columns.Add("NSSINUSYN");
                            NACASEDET3.Columns.Add("NSDISHRGYN");
                            NACASEDET3.Columns.Add("NSBLEDYN");
                            NACASEDET3.Columns.Add("NSREMARK");

                            NACASEDET3.Columns.Add("MOUTHNSFYN");
                            NACASEDET3.Columns.Add("MHALITOSISYN");
                            NACASEDET3.Columns.Add("MOUTHPAINYN");
                            NACASEDET3.Columns.Add("MBLDGUMSYN");
                            NACASEDET3.Columns.Add("MSTOMATITISYN");
                            NACASEDET3.Columns.Add("MLOSSTASTEYN");
                            NACASEDET3.Columns.Add("MDENTALHYGNYN");
                            NACASEDET3.Columns.Add("LASTDENEXAMINEYN");
                            NACASEDET3.Columns.Add("MOUTHREMARK");
                            NACASEDET3.Columns.Add("THRTNECKNSFYN");
                            NACASEDET3.Columns.Add("THRTSOREYN");
                            NACASEDET3.Columns.Add("THRTHOARSEYN");
                            NACASEDET3.Columns.Add("THRTLUMPSYN");
                            NACASEDET3.Columns.Add("THRTSWLGLNDSYN");
                            NACASEDET3.Columns.Add("THRTSTIFYN");
                            NACASEDET3.Columns.Add("THRTPAINYN");
                            NACASEDET3.Columns.Add("THRTDYSPHAGIAYN");
                            NACASEDET3.Columns.Add("THRTNECKREMARK");
                            NACASEDET3.Columns.Add("CARDVASNSFYN");
                            NACASEDET3.Columns.Add("CVSFATIGUEYN");
                            NACASEDET3.Columns.Add("CVSSYNCOPEYN");
                            NACASEDET3.Columns.Add("CVSCHTPAINYN");
                            NACASEDET3.Columns.Add("CVSORTHOPNOEAYN");
                            NACASEDET3.Columns.Add("CVSPLUSEYN");
                            NACASEDET3.Columns.Add("CVSPULREGIRREGYN");
                            NACASEDET3.Columns.Add("CVSPACEMAKERYN");
                            NACASEDET3.Columns.Add("CVSNCKVNDISTYN");
                            NACASEDET3.Columns.Add("CVSCYANOSISYN");
                            NACASEDET3.Columns.Add("CARDVASREMARK");
                            NACASEDET3.Columns.Add("RESPNSFYN");
                            NACASEDET3.Columns.Add("RESPCOUGYN");
                            NACASEDET3.Columns.Add("RESPSPUTYN");
                            NACASEDET3.Columns.Add("RESPBRADYN");
                            NACASEDET3.Columns.Add("RESPDYSPYN");
                            NACASEDET3.Columns.Add("RESPTACHYYN");
                            NACASEDET3.Columns.Add("RESPSTRIDOYN");
                            NACASEDET3.Columns.Add("RESPSOTHRPYN");
                            NACASEDET3.Columns.Add("RESPREMARK");
                            NACASEDET3.Columns.Add("GASTRONSFYN");
                            NACASEDET3.Columns.Add("GASDENTURESYN");
                            NACASEDET3.Columns.Add("GASLOOSTTHYN");
                            NACASEDET3.Columns.Add("GASTONGCOATYN");
                            NACASEDET3.Columns.Add("GASNAUSEAYN");
                            NACASEDET3.Columns.Add("GASVOMITYN");
                            NACASEDET3.Columns.Add("GASDYSPHAGIAYN");
                            NACASEDET3.Columns.Add("GASCONSTIYN");
                            NACASEDET3.Columns.Add("GASDIARYN");
                            NACASEDET3.Columns.Add("GASASCYN");
                            NACASEDET3.Columns.Add("GASPROCYN");
                            NACASEDET3.Columns.Add("GASHAEMORYN");
                            NACASEDET3.Columns.Add("ORALMUCSYN");
                            NACASEDET3.Columns.Add("ORALMMS");
                            NACASEDET3.Columns.Add("GASTROINSTREMARK");
                            NACASEDET3.Columns.Add("SKELETNSFYN");
                            NACASEDET3.Columns.Add("SKLWEAKYN");
                            NACASEDET3.Columns.Add("SKLTEMORSYN");
                            NACASEDET3.Columns.Add("SKINROMYN");
                            NACASEDET3.Columns.Add("SKINROMFULREST");
                            NACASEDET3.Columns.Add("SKINROMREMARK");
                            NACASEDET3.Columns.Add("SKLDEFORYN");
                            NACASEDET3.Columns.Add("SKLRESTRYN");
                            NACASEDET3.Columns.Add("SKLFRACYN");
                            NACASEDET3.Columns.Add("SKLMUSCJOINTPNYN");
                            NACASEDET3.Columns.Add("SKLASSAMBULTIONYN");
                            NACASEDET3.Columns.Add("ASSISTAMBUREMARK");
                            NACASEDET3.Columns.Add("SKINTURGGP");
                            NACASEDET3.Columns.Add("ICTERUSYN");
                            NACASEDET3.Columns.Add("SKELTLINSTREMARK");
                            NACASEDET3.Columns.Add("GENITONSFYN");
                            NACASEDET3.Columns.Add("GENFREQYN");
                            NACASEDET3.Columns.Add("GENFLNKPLNYN");
                            NACASEDET3.Columns.Add("GENURGENYN");
                            NACASEDET3.Columns.Add("GENHOCALCUYN");
                            NACASEDET3.Columns.Add("GENDYSURIYN");
                            NACASEDET3.Columns.Add("GENRETENSYN");
                            NACASEDET3.Columns.Add("GENINCONTINYN");
                            NACASEDET3.Columns.Add("GENUTIYN");
                            NACASEDET3.Columns.Add("GENOBSFLOW");
                            NACASEDET3.Columns.Add("GENHAEMOCYSTIYN");
                            NACASEDET3.Columns.Add("GENUROSTOMYN");
                            NACASEDET3.Columns.Add("GENCATHETDAYS");
                            NACASEDET3.Columns.Add("GENCATHFS");
                            NACASEDET3.Columns.Add("GENURINREMARK");
                            NACASEDET3.Columns.Add("OSTOMYNSFYN");
                            NACASEDET3.Columns.Add("OTCOLOSTYN");
                            NACASEDET3.Columns.Add("OTURETEROYN");
                            NACASEDET3.Columns.Add("OTILEOSTOMYN");
                            NACASEDET3.Columns.Add("OTNEPHROSYN");
                            NACASEDET3.Columns.Add("OTSUPRCYSTOSYN");
                            NACASEDET3.Columns.Add("OTTRACHEOSYN");
                            NACASEDET3.Columns.Add("OTGASTROSYN");
                            NACASEDET3.Columns.Add("OTJEJUNOSYN");
                            NACASEDET3.Columns.Add("OSTOMYREMARK");
                            NACASEDET3.Columns.Add("EYEITCHYN");
                            NACASEDET3.Columns.Add("CVSPALPITATIONYN");
                            NACASEDET3.Columns.Add("ABDGIRTHYN");
                            NACASEDET3.Columns.Add("ABGSIZE");
                            NACASEDET3.Columns.Add("BOWOPENYN");
                            NACASEDET3.Columns.Add("NEURONSFYN");

                        }
                        //END

                        //NASCALEDET
                        if (load.Tables.Contains("NASCALEDET"))
                        {
                            dt = load.Tables["NASCALEDET"];
                            dt.TableName = "NASCALEDET";


                            if (dt.Rows[0]["AFFECTSLEEPYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["AFFECTSLEEPYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["AFFECTSLEEPYN"].ToString() == "N")
                            {
                                dt.Rows[0]["AFFECTSLEEPYN"] = "No";
                            }

                            if (dt.Rows[0]["INTACTYN"].ToString() == "Y")
                            {
                                dt.Rows[0]["INTACTYN"] = "Yes";
                            }
                            else if (dt.Rows[0]["INTACTYN"].ToString() == "N")
                            {
                                dt.Rows[0]["INTACTYN"] = "No";
                            }


                            var characterpainLst = GeneralFunction.GetCharacterOfPainList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["CHAROFPAIN"].ToString().Trim() != "")
                                {
                                    row["CHAROFPAIN"] = GeneralFunction.GetListValue(characterpainLst, row["CHAROFPAIN"].ToString().Trim());
                                }
                            }

                            dt = load.Tables["NASCALEDET"];
                            dt.AcceptChanges();
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NASCALEDET = new DataTable();
                            NASCALEDET.TableName = "NASCALEDET";
                            NASCALEDET.Columns.Add("DAILYLIVNG");
                            NASCALEDET.Columns.Add("FEEDING");
                            NASCALEDET.Columns.Add("ORALHYGNE");
                            NASCALEDET.Columns.Add("BATHING");
                            NASCALEDET.Columns.Add("TOILATING");
                            NASCALEDET.Columns.Add("GENMOBILTY");
                            NASCALEDET.Columns.Add("DRESSING");
                            NASCALEDET.Columns.Add("FALLRISK");
                            NASCALEDET.Columns.Add("SASCORE");
                            NASCALEDET.Columns.Add("AGEBELWYN");
                            NASCALEDET.Columns.Add("NEUROLOGCYN");
                            NASCALEDET.Columns.Add("REQAIDYN");
                            NASCALEDET.Columns.Add("MENTALSTSYN");
                            NASCALEDET.Columns.Add("POORHEARNGYN");
                            NASCALEDET.Columns.Add("IVINFUSIONYN");
                            NASCALEDET.Columns.Add("MEDICATIONYN");
                            NASCALEDET.Columns.Add("LANBARRIERYN");
                            NASCALEDET.Columns.Add("PAINASSESMNT");
                            NASCALEDET.Columns.Add("PAIN");
                            NASCALEDET.Columns.Add("WONGBAKSCALE");
                            NASCALEDET.Columns.Add("TYPEOFPAIN");
                            NASCALEDET.Columns.Add("EXFACTOR");
                            NASCALEDET.Columns.Add("CHAROFPAIN");
                            NASCALEDET.Columns.Add("PAINLOCATION");
                            NASCALEDET.Columns.Add("PAINDURATION");
                            NASCALEDET.Columns.Add("HOFALLYN");
                            NASCALEDET.Columns.Add("ECOGSCORE");
                            NASCALEDET.Columns.Add("FALLRISKSCORE");
                            NASCALEDET.Columns.Add("DVTSCORE");
                            NASCALEDET.Columns.Add("INTACTYN");
                            NASCALEDET.Columns.Add("INTACT");
                            NASCALEDET.Columns.Add("FLACCSCORE");
                            NASCALEDET.Columns.Add("BRADENREMARK");
                            NASCALEDET.Columns.Add("PAINREMARK");
                            NASCALEDET.Columns.Add("FALLRISKREMARK");
                            dsFinalForPrint.Tables.Add(NASCALEDET);
                        }
                        //END

                        //NACLINICAL
                        Dictionary<string, string> NEURONAME = new Dictionary<string, string>
                    {
                        { "HEADCHEYN", "Headache" },{ "MEMRYCHNGEYN", "Memory Changes" },{ "WEAKNESYN", "Weakness" },{ "DIZZINESYN", "Dizziness" },
                        { "COOPERTIVEYN", "Cooperative" },{ "SEIZUREYN", "Seizure" },{ "HEMIPLEGIAYN", "Hemiplegia" },
                        { "PARAPLEGIAYN", "Paraplegia" },{ "QUADRIPLEGIAYN", "Quadriplegia" }
                    };

                        if (load.Tables.Contains("NACLINICAL"))
                        {
                            dt = load.Tables["NACLINICAL"];

                            DataRow dr = dt.Rows.Count > 0 ? dt.Rows[0] : null;

                            List<string> neurochk = new List<string>();

                            if (dr != null)
                            {
                                foreach (var neuro in NEURONAME)
                                {
                                    if (dt.Columns.Contains(neuro.Key) && dr[neuro.Key] != DBNull.Value && dr[neuro.Key].ToString().Trim().ToUpper() == "Y")
                                    {
                                        neurochk.Add(neuro.Value);
                                    }
                                }

                            }

                            string NEUROStr = neurochk.Count > 0 ? string.Join(", ", neurochk) : "";
                            if (dt.Rows.Count > 0)
                            {

                                dt.Rows[0]["HEADCHEYN"] = NEUROStr ?? string.Empty;

                                if (dt.Rows[0]["GAGREFLXYN"].ToString() == "Y")
                                {
                                    dt.Rows[0]["GAGREFLXYN"] = "Present";
                                }
                                else if (dt.Rows[0]["GAGREFLXYN"].ToString() == "N")
                                {
                                    dt.Rows[0]["GAGREFLXYN"] = "Absent";
                                }
                            }
                            var lvlOfCounsiousness = GeneralFunction.GetLevelOfConciousnessList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["CONCIUSLEVEL"].ToString().Trim() != "")
                                {
                                    //row["CONCIUSLEVEL"] = lvlOfCounsiousness.Where(X => X.Value == ("" + row["CONCIUSLEVEL"]).Trim()).Count() == 0 ? "" : lvlOfCounsiousness.Where(X => X.Value == row["CONCIUSLEVEL"].ToString().Trim()).FirstOrDefault().Text;
                                    row["CONCIUSLEVEL"] = GeneralFunction.GetListValue(lvlOfCounsiousness, row["CONCIUSLEVEL"].ToString().Trim());
                                }

                            }

                            var speechLst = GeneralFunction.GetSpeechList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["SPEECHYN"].ToString().Trim() != "")
                                {

                                    //row["SPEECHYN"] = speechLst.Where(X => X.Value == ("" + row["SPEECHYN"]).Trim()).Count() == 0 ? "" : speechLst.Where(X => X.Value == row["SPEECHYN"].ToString().Trim()).FirstOrDefault().Text;
                                    row["SPEECHYN"] = GeneralFunction.GetListValue(speechLst, row["SPEECHYN"].ToString().Trim());
                                }

                            }

                            var shapeLst = GeneralFunction.GetShapeList();
                            foreach (DataRow row in dt.Rows)
                            {
                                //row["PUPILRSHAPE"] = shapeLst.Where(X => X.Value == ("" + row["PUPILRSHAPE"]).Trim()).Count() == 0 ? "" : shapeLst.Where(X => X.Value == row["PUPILRSHAPE"].ToString().Trim()).FirstOrDefault().Text;
                                //row["PUPILLSHAPE"] = shapeLst.Where(X => X.Value == ("" + row["PUPILLSHAPE"]).Trim()).Count() == 0 ? "" : shapeLst.Where(X => X.Value == row["PUPILLSHAPE"].ToString().Trim()).FirstOrDefault().Text;
                                if ((row["PUPILLSHAPE"].ToString().Trim() != ""))
                                {
                                    row["PUPILLSHAPE"] = GeneralFunction.GetListValue(shapeLst, row["PUPILLSHAPE"].ToString().Trim());
                                }
                                if ((row["PUPILRSHAPE"].ToString().Trim() != ""))
                                {
                                    row["PUPILRSHAPE"] = GeneralFunction.GetListValue(shapeLst, row["PUPILRSHAPE"].ToString().Trim());
                                }

                            }

                            var reactnLst = GeneralFunction.GetReactionList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if ((row["PUPILRREACTN"].ToString().Trim() != ""))
                                {
                                    //row["PUPILRREACTN"] = reactnLst.Where(X => X.Value == ("" + row["PUPILRREACTN"]).Trim()).Count() == 0 ? "" : reactnLst.Where(X => X.Value == row["PUPILRREACTN"].ToString().Trim()).FirstOrDefault().Text;
                                    //row["PUPILLREACTN"] = reactnLst.Where(X => X.Value == ("" + row["PUPILLREACTN"]).Trim()).Count() == 0 ? "" : reactnLst.Where(X => X.Value == row["PUPILLREACTN"].ToString().Trim()).FirstOrDefault().Text;
                                    row["PUPILRREACTN"] = GeneralFunction.GetListValue(reactnLst, row["PUPILRREACTN"].ToString().Trim());

                                }
                                if ((row["PUPILLREACTN"].ToString().Trim() != ""))
                                {
                                    row["PUPILLREACTN"] = GeneralFunction.GetListValue(reactnLst, row["PUPILLREACTN"].ToString().Trim());
                                }

                            }

                            var extraOculrMovmntLst = GeneralFunction.GetExtraOccularMvemntList();
                            foreach (DataRow row in dt.Rows)
                            {
                                // row["PUPILREXTRA"] = extraOculrMovmntLst.Where(X => X.Value == ("" + row["PUPILREXTRA"]).Trim()).Count() == 0 ? "" : extraOculrMovmntLst.Where(X => X.Value == row["PUPILREXTRA"].ToString().Trim()).FirstOrDefault().Text;
                                //row["PUPILLEXTRA"] = extraOculrMovmntLst.Where(X => X.Value == ("" + row["PUPILLEXTRA"]).Trim()).Count() == 0 ? "" : extraOculrMovmntLst.Where(X => X.Value == row["PUPILLEXTRA"].ToString().Trim()).FirstOrDefault().Text;
                                if ((row["PUPILREXTRA"].ToString().Trim() != ""))
                                {
                                    row["PUPILREXTRA"] = GeneralFunction.GetListValue(extraOculrMovmntLst, row["PUPILREXTRA"].ToString().Trim());

                                }
                                if ((row["PUPILLEXTRA"].ToString().Trim() != ""))
                                {
                                    row["PUPILLEXTRA"] = GeneralFunction.GetListValue(extraOculrMovmntLst, row["PUPILLEXTRA"].ToString().Trim());
                                }
                            }

                            var gaitLst = GeneralFunction.GetGaitList();
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["GAIT"].ToString().Trim() != "")
                                {
                                    //row["GAIT"] = gaitLst.Where(X => X.Value == ("" + row["GAIT"]).Trim()).Count() == 0 ? "" : gaitLst.Where(X => X.Value == row["GAIT"].ToString().Trim()).FirstOrDefault().Text;
                                    row["GAIT"] = GeneralFunction.GetListValue(gaitLst, row["GAIT"].ToString().Trim());
                                }

                            }

                            var Powerlist = GeneralFunction.GetPowerList();
                            foreach (DataRow row in dt.Rows)
                            {

                                if (row["UPLIMBRGHT"].ToString().Trim() != "")
                                {//row["FACIALSYM"] = facialSymmLst.Where(X => X.Value == ("" + row["FACIALSYM"]).Trim()).Count() == 0 ? "" : facialSymmLst.Where(X => X.Value == row["FACIALSYM"].ToString().Trim()).FirstOrDefault().Text;
                                    row["UPLIMBRGHT"] = GeneralFunction.GetListValue(Powerlist, row["UPLIMBRGHT"].ToString().Trim());
                                }
                                if (row["UPLIMBLFT"].ToString().Trim() != "")
                                {//row["FACIALSYM"] = facialSymmLst.Where(X => X.Value == ("" + row["FACIALSYM"]).Trim()).Count() == 0 ? "" : facialSymmLst.Where(X => X.Value == row["FACIALSYM"].ToString().Trim()).FirstOrDefault().Text;
                                    row["UPLIMBLFT"] = GeneralFunction.GetListValue(Powerlist, row["UPLIMBLFT"].ToString().Trim());
                                }
                                if (row["LOWLIMBRGHT"].ToString().Trim() != "")
                                {//row["FACIALSYM"] = facialSymmLst.Where(X => X.Value == ("" + row["FACIALSYM"]).Trim()).Count() == 0 ? "" : facialSymmLst.Where(X => X.Value == row["FACIALSYM"].ToString().Trim()).FirstOrDefault().Text;
                                    row["LOWLIMBRGHT"] = GeneralFunction.GetListValue(Powerlist, row["LOWLIMBRGHT"].ToString().Trim());
                                }
                                if (row["LOWLIMBLFT"].ToString().Trim() != "")
                                {//row["FACIALSYM"] = facialSymmLst.Where(X => X.Value == ("" + row["FACIALSYM"]).Trim()).Count() == 0 ? "" : facialSymmLst.Where(X => X.Value == row["FACIALSYM"].ToString().Trim()).FirstOrDefault().Text;
                                    row["LOWLIMBLFT"] = GeneralFunction.GetListValue(Powerlist, row["LOWLIMBLFT"].ToString().Trim());
                                }

                            }

                            dt = load.Tables["NACLINICAL"];
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NACLINICAL = new DataTable();
                            NACLINICAL.TableName = "NACLINICAL";
                            NACLINICAL.Columns.Add("NEUROCOMPLNT");
                            NACLINICAL.Columns.Add("HEADCHEYN");
                            NACLINICAL.Columns.Add("MEMRYCHNGEYN");
                            NACLINICAL.Columns.Add("WEAKNESYN");
                            NACLINICAL.Columns.Add("SENSRYSYMYN");
                            NACLINICAL.Columns.Add("SENSOR");
                            NACLINICAL.Columns.Add("MOTORYN");
                            NACLINICAL.Columns.Add("MOTOR");
                            NACLINICAL.Columns.Add("CONVULSIONYN");
                            NACLINICAL.Columns.Add("CONVULSIONS");
                            NACLINICAL.Columns.Add("CONCIUSLEVEL");
                            NACLINICAL.Columns.Add("PERSONYN");
                            NACLINICAL.Columns.Add("PLACEYN");
                            NACLINICAL.Columns.Add("TIMEYN");
                            NACLINICAL.Columns.Add("SPEECHYN");
                            NACLINICAL.Columns.Add("GCSSCORE");
                            NACLINICAL.Columns.Add("PUPILLSIZE");
                            NACLINICAL.Columns.Add("PUPILRSIZE");
                            NACLINICAL.Columns.Add("PUPILLSHAPE");
                            NACLINICAL.Columns.Add("PUPILRSHAPE");
                            NACLINICAL.Columns.Add("PUPILRREACTN");
                            NACLINICAL.Columns.Add("PUPILLREACTN");
                            NACLINICAL.Columns.Add("PUPILLEXTRA");
                            NACLINICAL.Columns.Add("PUPILREXTRA");
                            NACLINICAL.Columns.Add("FACIALSYM");
                            NACLINICAL.Columns.Add("GAIT");
                            NACLINICAL.Columns.Add("OTHRFINDNG");
                            //NACLINICAL.Columns.Add("SPO2");
                            //NACLINICAL.Columns.Add("HGT");
                            NACLINICAL.Columns.Add("NEUROREMARK");
                            NACLINICAL.Columns.Add("GAGREFLXYN");
                            //NACLINICAL.Columns.Add("RR");
                            //NACLINICAL.Columns.Add("OXYFLOWRT");
                            NACLINICAL.Columns.Add("DIZZINESYN");
                            NACLINICAL.Columns.Add("SEDATNSCORE");
                            NACLINICAL.Columns.Add("UPLIMBLFT");
                            NACLINICAL.Columns.Add("UPLIMBRGHT");
                            NACLINICAL.Columns.Add("LOWLIMBRGHT");
                            NACLINICAL.Columns.Add("LOWLIMBLFT");
                            NACLINICAL.Columns.Add("FLACCSCORE");
                            NACLINICAL.Columns.Add("VISUALANALOGSCALE");
                            dsFinalForPrint.Tables.Add(NACLINICAL);
                        }
                        //END
                        //SUB REPORT TABLES Allergy
                        if (load.Tables.Contains("NAPATALLERGY"))
                        {
                            dt = load.Tables["NAPATALLERGY"];
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NAPATALLERGY = new DataTable("NAPATALLERGY");
                            NAPATALLERGY.TableName = "NAPATALLERGY";
                            NAPATALLERGY.Columns.Add("ALLERGYDESC");
                            NAPATALLERGY.Columns.Add("DURATION");
                            NAPATALLERGY.Columns.Add("REMARK");
                            dsFinalForPrint.Tables.Add(NAPATALLERGY);


                            //dt = load.Tables["NAPATALLERGY"];
                            //dt.AcceptChanges();
                            //dsFinalForPrint.Tables.Add(dt.Copy());
                        }

                        //End

                        //MEDICATION
                        if (load.Tables.Contains("MEDICATION"))
                        {
                            dt = load.Tables["MEDICATION"];
                            dt.TableName = "MEDICATIONDET";

                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["DRUGDT"].ToString().Trim() != "")
                                {
                                    row["DRUGDT"] = GeneralFunction.GetUIDateFormat(row["DRUGDT"].ToString().Trim(), GeneralFunction.DateModes.DATEWITHSEPARATOR_DDMMYYYY);

                                }
                                if (row["SEQNO"].ToString().Trim() != "")
                                {
                                    row["SEQNO"] = (Convert.ToInt32(row["SEQNO"]));
                                }
                            }

                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable MEDICATIONDET = new DataTable();
                            MEDICATIONDET.TableName = "MEDICATIONDET";
                            MEDICATIONDET.Columns.Add("SEQNO");
                            MEDICATIONDET.Columns.Add("DRUGNM");
                            MEDICATIONDET.Columns.Add("DOSE");
                            MEDICATIONDET.Columns.Add("FREQNCY");
                            MEDICATIONDET.Columns.Add("DRUGDT");
                            MEDICATIONDET.Columns.Add("DRUGTM");
                            dsFinalForPrint.Tables.Add(MEDICATIONDET);
                        }
                        //END

                        //CAREPLAN
                        if (load.Tables.Contains("CAREPLAN"))
                        {
                            dt = load.Tables["CAREPLAN"];
                            dt.TableName = "CAREPLAN";

                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["SEQNO"].ToString().Trim() != "")
                                {
                                    row["SEQNO"] = (Convert.ToInt32(row["SEQNO"]));
                                }
                            }
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable CAREPLAN = new DataTable();
                            CAREPLAN.TableName = "CAREPLAN";
                            CAREPLAN.Columns.Add("SEQNO");
                            CAREPLAN.Columns.Add("PLANOFCARE");
                            CAREPLAN.Columns.Add("PLANREMARK");
                            dsFinalForPrint.Tables.Add("CAREPLAN");
                        }
                        //END

                        //EDUNEEDS
                        //CAREPLAN
                        if (load.Tables.Contains("EDUNEEDS"))
                        {
                            dt = load.Tables["EDUNEEDS"];
                            dt.TableName = "EDUNEEDS";
                            foreach (DataRow row in dt.Rows)
                            {
                                if (row["SEQNO"].ToString().Trim() != "")
                                {
                                    row["SEQNO"] = (Convert.ToInt32(row["SEQNO"]));
                                }
                            }
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable EDUNEEDS = new DataTable();
                            EDUNEEDS.TableName = "EDUNEEDS";
                            EDUNEEDS.Columns.Add("SEQNO");
                            EDUNEEDS.Columns.Add("EDUNEEDS");
                            EDUNEEDS.Columns.Add("INTERVENPLAN");
                            EDUNEEDS.Columns.Add("EDUREMARK");
                            dsFinalForPrint.Tables.Add("EDUNEEDS");
                        }
                        //END
                        //END


                        //NACRITICPARAM
                        if (load.Tables.Contains("NACRITICPARAM"))
                        {
                            dt = load.Tables["NACRITICPARAM"];
                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            DataTable NACRITICPARAM = new DataTable("NACRITICPARAM");
                            NACRITICPARAM.TableName = "NACRITICPARAM";
                            NACRITICPARAM.Columns.Add("PERIPHRAL");
                            NACRITICPARAM.Columns.Add("PACEDRT");
                            NACRITICPARAM.Columns.Add("PATINTRNSCRT");
                            NACRITICPARAM.Columns.Add("IABPSYS");
                            NACRITICPARAM.Columns.Add("IABPDIA");
                            NACRITICPARAM.Columns.Add("IBPSYS");
                            NACRITICPARAM.Columns.Add("IBPDIA");
                            NACRITICPARAM.Columns.Add("NIBPSYS");
                            NACRITICPARAM.Columns.Add("NIBPDIA");
                            NACRITICPARAM.Columns.Add("MEWSSCORE");
                            NACRITICPARAM.Columns.Add("SPO2");
                            NACRITICPARAM.Columns.Add("RR");

                            NACRITICPARAM.Columns.Add("HGT");
                            NACRITICPARAM.Columns.Add("OXYFLOWRT");
                            dsFinalForPrint.Tables.Add(NACRITICPARAM);

                        }
                        //END
                        //HABIT
                        if (load.Tables.Contains("HABIT"))
                        {
                            dt = load.Tables["HABIT"];

                            // If the table exists but has no rows, add an empty row
                            if (dt.Rows.Count == 0)
                            {
                                DataRow emptyRow = dt.NewRow();
                                emptyRow["HABITNM"] = "";
                                emptyRow["DURATION"] = "";
                                dt.Rows.Add(emptyRow);
                            }

                            dsFinalForPrint.Tables.Add(dt.Copy());
                        }
                        else
                        {
                            // Create the table and add an empty row
                            DataTable habitDt = new DataTable("HABIT");
                            habitDt.Columns.Add("HABITNM");
                            habitDt.Columns.Add("DURATION");

                            DataRow emptyRow = habitDt.NewRow();
                            emptyRow["HABITNM"] = "";
                            emptyRow["DURATION"] = "";
                            habitDt.Rows.Add(emptyRow);

                            dsFinalForPrint.Tables.Add(habitDt);
                        }

                        //if (load.Tables.Contains("HABIT"))
                        //{
                        //    dt = load.Tables["HABIT"];
                        //    dsFinalForPrint.Tables.Add(dt.Copy());
                        //}
                        //else
                        //{
                        //    DataTable habitDt = new DataTable("HABIT");
                        //    habitDt.TableName = "HABIT";
                        //    habitDt.Columns.Add("HABITNM");
                        //    habitDt.Columns.Add("DURATION");

                        //    dsFinalForPrint.Tables.Add(habitDt);
                        //}
                        //END


                        //Pat Info Data
                        HData = GeneralFunction.getHeaderFooter("Initial Nursing Assessment", "", "", "");

                        if (HData.Rows.Count > 0 && HData.Columns.Contains("PrintDateTime"))
                        {
                            HData.Rows[0]["PrintDateTime"] =
                                GeneralFunction.ConvertDateWithTimeTo12Hour(HData.Rows[0]["PrintDateTime"].ToString());
                        }
                        HData.TableName = "HeaderFooter";
                        dsFinalForPrint.Tables.Add(HData);

                        DataTable dt1 = new DataTable();
                        dt1.TableName = "PatInfo";
                        if (dsPatInfo.Tables.Count > 0)
                        {
                            dt = dsPatInfo.Tables[0];

                            dt1.Columns.Add("IPNO");
                            dt1.Columns.Add("MRNO");
                            dt1.Columns.Add("ADMNDATE");
                            dt1.Columns.Add("PATNAME");
                            dt1.Columns.Add("ADMNTIME");
                            dt1.Columns.Add("Gender");
                            dt1.Columns.Add("PATAGE");
                            dt1.Columns.Add("CONSDOCT");
                            dt1.Columns.Add("SALUNAME");
                            dt1.Columns.Add("CURRBEDNO");
                            dt1.Columns.Add("WARDNM");
                            dt1.Columns.Add("NURSTNM");
                            dt1.Columns.Add("MLCYORN");

                            DataRow patRow = dt1.NewRow();
                            patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                            patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                            patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                            //patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                            string fullName = dt.Rows[0]["PATNAME"].ToString().Trim();
                            string[] nameParts = fullName.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

                            if (nameParts.Length == 1)
                            {
                                patRow["PATNAME"] = nameParts[0]; // only one word
                            }
                            else if (nameParts.Length > 1)
                            {
                                patRow["PATNAME"] = nameParts[0] + " " + nameParts[nameParts.Length - 1]; // first and last
                            }
                            else
                            {
                                patRow["PATNAME"] = ""; // empty or invalid
                            }

                            patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                            patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                            patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                            patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                            patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                            patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                            patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                            patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                            patRow["MLCYORN"] = dt.Rows[0]["MLCYORN"].ToString() == "Y" ? "Yes" : "No";
                            dt1.Rows.Add(patRow);
                            FileStream fs;
                            byte[] Image = new byte[0];
                            var Pic_Path = System.Web.HttpContext.Current.Server.MapPath("~/CaseDetailImages");
                            var folderPath = Path.Combine(Pic_Path, strIPNO); // folder only
                            var finalPath = Pic_Path + @"\" + strIPNO + @"\" + strIPNO + "findings" + ".png";
                            if (File.Exists(finalPath))
                            {
                                fs = new FileStream(finalPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                                Image = new byte[fs.Length];
                                fs.Read(Image, 0, Convert.ToInt32(fs.Length));
                                dsFinalForPrint.Tables["NACASEDET"].Rows[0]["CASEDTLIMG"] = Image;
                                dsFinalForPrint.Tables["NACASEDET"].Rows[0]["CASEDETIMGYN"] = "Y";
                                fs.Close();
                            }
                            else
                            {
                                if (!Directory.Exists(folderPath))
                                {
                                    Directory.CreateDirectory(folderPath);
                                }
                                dsFinalForPrint.Tables["NACASEDET"].Rows[0]["CASEDETIMGYN"] = "N";
                            }
                        }


                        dsFinalForPrint.Tables.Add(dt1);
                        //if (dsFinalForPrint.Tables.Contains("NACASEDET") && dsFinalForPrint.Tables["NACASEDET"].Rows.Count > 0)
                        //{
                        //    DataTable nacaseDet = dsFinalForPrint.Tables["NACASEDET"];

                        //    string[] extraTables = { "HABIT", "EDUNEEDS", "CAREPLAN", "MEDICATIONDET", "NAPATALLERGY" };

                        //    foreach (string tblName in extraTables)
                        //    {
                        //        if (!nacaseDet.Columns.Contains(tblName))
                        //            nacaseDet.Columns.Add(tblName, typeof(int));

                        //        int val = (dsFinalForPrint.Tables.Contains(tblName) && dsFinalForPrint.Tables[tblName].Rows.Count > 0) ? 1 : 0;

                        //        nacaseDet.Rows[0][tblName] = val;
                        //    }
                        //}


                        if (dsFinalForPrint.Tables.Contains("NACASEDET") && dsFinalForPrint.Tables["NACASEDET"].Rows.Count > 0)
                        {
                            DataTable nacaseDet = dsFinalForPrint.Tables["NACASEDET"];

                            Dictionary<string, string> tableColumnMap = new Dictionary<string, string>
                            {{ "HABIT", "HABITNM" },{ "EDUNEEDS", "EDUNEEDS" },{ "CAREPLAN", "PLANOFCARE" },
                            { "MEDICATIONDET", "DRUGNM" },{ "NAPATALLERGY", "ALLRGTYPE" }};

                            foreach (var kv in tableColumnMap)
                            {
                                string tblName = kv.Key;
                                string colName = kv.Value;

                                if (!nacaseDet.Columns.Contains(tblName))
                                    nacaseDet.Columns.Add(tblName, typeof(int));

                                int val = 0;

                                if (dsFinalForPrint.Tables.Contains(tblName) && dsFinalForPrint.Tables[tblName].Rows.Count > 0)
                                {
                                    bool hasData = dsFinalForPrint.Tables[tblName]
                                                       .AsEnumerable()
                                                       .Any(r => r[colName] != DBNull.Value &&
                                                                 !string.IsNullOrWhiteSpace(r[colName].ToString()));

                                    val = hasData ? 1 : 0;
                                }

                                nacaseDet.Rows[0][tblName] = val;
                            }
                        }



                        if ((dsFinalForPrint.Tables.Contains("NACASEDET3") && dsFinalForPrint.Tables["NACASEDET3"].Rows.Count == 0) ||
    (dsFinalForPrint.Tables.Contains("NACASEDETAILS2") && dsFinalForPrint.Tables["NACASEDETAILS2"].Rows.Count == 0))
                        {
                            dsFinalForPrint.Tables.Clear();
                        }
                        //End

                    }
                }


                return dsFinalForPrint;
            }
            catch (Exception ex)
            {
                return null;

            }
        }
        #endregion
        //End
        public DataSet GetInvestData(string strIPNo, string strFromDate, string strToDate, string strNsNm)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            DataTable HData = new DataTable();

            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetInvestChart(strIPNo, strFromDate, strToDate))));
            object[] obj = new object[1];
            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    load.Tables[0].TableName = "IINVESTIGATION";
                    dsFinalForPrint.Tables.Add(load.Tables[0].Copy());
                }
                else
                {
                    DataTable finalDt = new DataTable();
                    finalDt.TableName = "IINVESTIGATION";
                    finalDt.Columns.Add("TESTNAME");
                    finalDt.Columns.Add("INVESTDESC");
                    finalDt.Columns.Add("RESUTL");
                    finalDt.Columns.Add("NORMRANGE");
                    finalDt.Columns.Add("RESULTTYPE");
                    finalDt.Columns.Add("RESULTDATE");
                    dsFinalForPrint.Tables.Add(finalDt);
                }

                HData = GeneralFunction.getHeaderFooter("ISBAR", "", "", "");
                string strFrmDt = GeneralFunction.GetDate(strFromDate);
                string strToDt = GeneralFunction.GetDate(strToDate);
                HData.TableName = "HeaderFooter";
                if (strFrmDt == strToDate)
                    HData.Rows[0]["ForDate"] = "On " + strFrmDt;
                else
                    HData.Rows[0]["ForDate"] = "From " + strFrmDt + " To " + strToDt;

                dsFinalForPrint.Tables.Add(HData);

                DataTable dt1 = new DataTable();
                dt1.TableName = "PatInfo";

                if (dsPatInfo.Tables.Count > 0)
                {
                    dt = dsPatInfo.Tables[0];

                    dt1.Columns.Add("IPNO");
                    dt1.Columns.Add("MRNO");
                    dt1.Columns.Add("ADMNDATE");
                    dt1.Columns.Add("PATNAME");
                    dt1.Columns.Add("ADMNTIME");
                    dt1.Columns.Add("Gender");
                    dt1.Columns.Add("PATAGE");
                    dt1.Columns.Add("CONSDOCT");
                    dt1.Columns.Add("SALUNAME");
                    dt1.Columns.Add("CURRBEDNO");
                    dt1.Columns.Add("WARDNM");
                    dt1.Columns.Add("NURSTNM");
                    dt1.Columns.Add("DATE");
                    dt1.Columns.Add("TIME");
                    dt1.Columns.Add("CNAME");
                    dt1.Columns.Add("TOMOROWDATE");
                    DataRow patRow = dt1.NewRow();
                    patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                    patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                    patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                    patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                    patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                    patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                    patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                    patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                    patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                    patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                    patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                    patRow["DATE"] = GeneralFunction.GetDate(strDate);
                    patRow["TIME"] = strTime;
                    patRow["CNAME"] = strNsNm;
                    patRow["TOMOROWDATE"] = "";
                    dt1.Rows.Add(patRow);
                }
                dsFinalForPrint.Tables.Add(dt1);
            }


            return dsFinalForPrint;
        }

        public DataSet GetDiabeticData(string strIPNo, string strFromDate, string strToDate, string strNsNm)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            DataTable HData = new DataTable();

            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetDiabeticChartData(strIPNo, strFromDate, strToDate))));
            object[] obj = new object[1];
            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    load.Tables[0].TableName = "DIABETIC";
                    for (var i = 0; i <= load.Tables[0].Rows.Count - 1; i++)
                    {
                        load.Tables[0].Rows[i]["CA1DATE"] = GeneralFunction.GetDate(load.Tables[0].Rows[i]["CA1DATE"].ToString());
                        load.Tables[0].Rows[i]["USERNAME"] = GeneralFunction.GetFstNameUserId(load.Tables[0].Rows[i]["USERNAME"].ToString().Trim());
                    }
                    dsFinalForPrint.Tables.Add(load.Tables[0].Copy());
                }
                else
                {
                    DataTable finalDt = new DataTable();
                    finalDt.TableName = "DIABETIC";
                    finalDt.Columns.Add("CADATE");
                    finalDt.Columns.Add("CATIME");
                    finalDt.Columns.Add("HGT");
                    finalDt.Columns.Add("US");
                    finalDt.Columns.Add("UK");
                    finalDt.Columns.Add("HGTMEDADMN");
                    finalDt.Columns.Add("USERNAME");
                    finalDt.Columns.Add("INSULIN");
                    dsFinalForPrint.Tables.Add(finalDt);
                }

                HData = GeneralFunction.getHeaderFooter("ISBAR", "", "", "");
                string strFrmDt = GeneralFunction.GetDate(strFromDate);
                string strToDt = GeneralFunction.GetDate(strToDate);
                HData.TableName = "HeaderFooter";
                if (strFrmDt == strToDate)
                    HData.Rows[0]["ForDate"] = "On " + strFrmDt;
                else
                    HData.Rows[0]["ForDate"] = "From " + strFrmDt + " To " + strToDt;

                dsFinalForPrint.Tables.Add(HData);

                DataTable dt1 = new DataTable();
                dt1.TableName = "PatInfo";

                if (dsPatInfo.Tables.Count > 0)
                {
                    dt = dsPatInfo.Tables[0];

                    dt1.Columns.Add("IPNO");
                    dt1.Columns.Add("MRNO");
                    dt1.Columns.Add("ADMNDATE");
                    dt1.Columns.Add("PATNAME");
                    dt1.Columns.Add("ADMNTIME");
                    dt1.Columns.Add("Gender");
                    dt1.Columns.Add("PATAGE");
                    dt1.Columns.Add("CONSDOCT");
                    dt1.Columns.Add("SALUNAME");
                    dt1.Columns.Add("CURRBEDNO");
                    dt1.Columns.Add("WARDNM");
                    dt1.Columns.Add("NURSTNM");
                    dt1.Columns.Add("DATE");
                    dt1.Columns.Add("TIME");
                    dt1.Columns.Add("CNAME");
                    dt1.Columns.Add("TOMOROWDATE");
                    DataRow patRow = dt1.NewRow();
                    patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                    patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                    patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                    patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                    patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                    patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                    patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                    patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                    patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                    patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                    patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                    patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                    patRow["DATE"] = GeneralFunction.GetDate(strDate);
                    patRow["TIME"] = strTime;
                    patRow["CNAME"] = strNsNm;
                    patRow["TOMOROWDATE"] = "";
                    dt1.Rows.Add(patRow);
                }
                dsFinalForPrint.Tables.Add(dt1);
            }


            return dsFinalForPrint;
        }

        public DataTable SortGetREsultdate(DataTable dtREsultdate)
        {
            var Rows = (from row in dtREsultdate.AsEnumerable()
                        orderby row["RESULTDATE"] descending
                        select row);
            dtREsultdate = Rows.AsDataView().ToTable();
            return dtREsultdate;
        }

        public object RetriveTempReportData(string MrnNo, string strFrmDate, string strTodate)
        {
            try
            {
                DataSet load = new DataSet();

                ICUClient icuCli = new ICUClient();

                var sDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                var tDate = GeneralFunction.GetDateInSpecifiedFormat(strTodate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                load.ReadXml(new StringReader(icuCli.GetTemplateResult(MrnNo, sDate, tDate, "")));

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

        public string GetAmendmntDet(string strResultNo)
        {
            ICUClient icuCli = new ICUClient();
            DataSet load = new DataSet();
            string amendData = icuCli.GetAmendmentData(strResultNo.ToString().Trim());
            return amendData;
        }

        public DataSet GetInvestResult(string strIPNo, string strFromDate, string strToDate, string chkinvstg)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            ICUClient icuClient = new ICUClient();
            DataSet load = new DataSet();
            DataTable dt = new DataTable();
            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string str = icuClient.GetInvestResult(strIPNo, strFromDate, strToDate, chkinvstg);
            load.ReadXml(new XmlTextReader(new StringReader(str)));

            if (load.Tables.Contains("investigateLst"))
            {
                load.Tables[0].Columns.Add("DATETIME", System.Type.GetType("System.DateTime"));
                load.Tables[0].Columns.Add("DateTimeString");
                //load.Tables[0].Columns.Add("DATETIME");
                IFormatProvider culture = new System.Globalization.CultureInfo("fr-FR", true);
                for (int i = 0; i < load.Tables[0].Rows.Count; i++)
                {
                    string s = GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()) + " " + GeneralFunction.ConvertTo24HourFormat(load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim());
                    if (s.Trim() != "")
                    {
                        DateTime dtdatev = DateTime.Parse(s, culture, System.Globalization.DateTimeStyles.AssumeLocal);
                        load.Tables[0].Rows[i]["TESTNAME"] = load.Tables[0].Rows[i]["TESTNAME"].ToString().Trim().Replace("'", "");
                        load.Tables[0].Rows[i]["INVESTDESC"] = load.Tables[0].Rows[i]["INVESTDESC"].ToString().Trim().Replace("'", "");
                        load.Tables[0].Rows[i]["DATETIME"] = dtdatev;
                        //load.Tables[0].Rows[i]["DATETIME"] = string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim()) != "" ? Convert.ToDateTime(string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim())) : DateTime.Now;
                        load.Tables[0].Rows[i]["DateTimeString"] = string.Format("{0} {1}", GeneralFunction.GetDate(load.Tables[0].Rows[i]["RESULTDATE"].ToString().Trim()), GeneralFunction.ConvertTo12HourFormat(load.Tables[0].Rows[i]["RESULTTIME"].ToString().Trim().Substring(0, 5)));
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
                    DataRow[] dmrow = load.Tables[0].Select("INVESTDESC='" + load.Tables[1].Rows[n]["INVESTDESC"].ToString().Trim().Replace("'", "") + "' AND TESTNAME='" + load.Tables[1].Rows[n]["TESTNAME"].ToString().Trim().Replace("'", "") + "'");
                    for (int p = 0; p < dmrow.Length; p++)
                    {
                        if (dmrow[p][13].ToString() == "")
                            continue;

                        load.Tables[1].Rows[n][dmrow[p][13].ToString()] = GetResultWithAbNorm(dmrow[p][4].ToString(), dmrow[p][7].ToString(), dmrow[p][8].ToString(), dmrow[p][6].ToString(), dmrow[p][9].ToString(), dmrow[p]["STATUS"].ToString(), p); //  Rows[n][dmrow[p][12] changed to Rows[n][dmrow[p][13] by vijeta on 4th Aug 2018
                    }
                    if (dmrow.Count() > 0)
                    {
                        load.Tables[1].Rows[n]["NORMRANGE"] = dmrow[0][5].ToString();
                        load.Tables[1].Rows[n]["TESTNAME"] = dmrow[0][0].ToString().ToString();
                        load.Tables[1].Rows[n]["INVESTDESC"] = dmrow[0][1].ToString().ToString();
                    }
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
                load.Tables.Add(TblInvestiDate);
                return load;
            }

            else
            {
                return load;
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
            return result + "<input type=hidden id=" + Status + "_" + p.ToString() + " />";//changed by vijeta on 4th Aug 2018
        }

        //Add by vishal 13/12/2017
        public DataSet GetICUNurseNotesData(string strIPNo, string strFromDate, string strToDate, string strTime, string strToTime, string strNsNm,
            string NoteType, string ProblemCD, string ReportType)
        {
            CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataSet loads = new DataSet();
            DataTable dt = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            DataTable dt1 = new DataTable();
            DataTable dt2 = new DataTable();
            DataTable dt3 = new DataTable();
            dt3.TableName = "Criteria";
            dt3.Columns.Add("FrmDate");
            dt3.Columns.Add("ToDate");
            dt3.Columns.Add("FrmTime");
            dt3.Columns.Add("ToTime");
            dt3.Columns.Add("NURSENOTES");
            DataRow dr = dt3.NewRow();
            dr["FrmDate"] = strFromDate;
            dr["ToDate"] = strToDate;
            dr["FrmTime"] = strTime;
            dr["ToTime"] = strToTime;
            dt3.Rows.Add(dr);
            dsFinalForPrint.Tables.Add(dt3);
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            DataTable HData = new DataTable();

            strFromDate = GeneralFunction.GetDateInSpecifiedFormat(strFromDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string userid = "";
            var authby = HttpContext.Current.Session["AUTHYN"].ToString();
            if (authby == "Y")
            {
                userid = "";
            }
            else
            {
                userid = HttpContext.Current.Session["UserID"].ToString();
            }


            /*Madhuri:- Code for seprating 2 reports*/
            if (ReportType == "NURSINGNOTES") // Care Plan
            {
                load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetICUNurseNotes(strIPNo, strFromDate, userid, strToDate, strTime, strToTime, ProblemCD, ""))));
                if (load.Tables.Contains("Table") && load.Tables["Table"] != null)
                {
                    DataTable problemcdTable = load.Tables["Table"];
                    DataRow[] filteredRows = null;


                    // 🔁 Blank duplicates anywhere, keep first occurrence
                    for (int i = 0; i < problemcdTable.Rows.Count; i++)
                    {
                        for (int j = 0; j < i; j++)
                        {
                            if (problemcdTable.Rows[i]["ASSESSMENT"].ToString() == problemcdTable.Rows[j]["ASSESSMENT"].ToString() &&
                                problemcdTable.Rows[i]["EXPECTOUTPUT"].ToString() == problemcdTable.Rows[j]["EXPECTOUTPUT"].ToString() &&
                                problemcdTable.Rows[i]["PLANNING"].ToString() == problemcdTable.Rows[j]["PLANNING"].ToString())
                            {
                                problemcdTable.Rows[i]["ASSESSMENT"] = "";
                                problemcdTable.Rows[i]["EXPECTOUTPUT"] = "";
                                problemcdTable.Rows[i]["PLANNING"] = "";
                                break; // stop once a duplicate is found
                            }
                        }
                    }

                    // 🔁 Propagate FinalRemark for same PROBCODE and PROBTM
                    // First, build a dictionary of PROBCODE+PROBTM → FinalRemark
                    var finalRemarkMap = new Dictionary<string, string>();

                    foreach (DataRow row in problemcdTable.Rows)
                    {
                        var key = row["PROBCODE"].ToString().Trim() + "|" + row["PROBTM"].ToString().Trim();
                        var remark = row["FINALREMARK"].ToString().Trim();
                        //if (remark != "")
                        //{
                        //    remark = remark + " - "  + GeneralFunction.GetUserName(row["REMARKADDBY"].ToString().Trim());
                        //}
                        if (!string.IsNullOrEmpty(remark))
                        {
                            finalRemarkMap[key] = remark; // store last non-empty FinalRemark
                        }
                    }

                    // Now, propagate to all rows 
                    foreach (DataRow row in problemcdTable.Rows)
                    {
                        var key = row["PROBCODE"].ToString().Trim() + "|" + row["PROBTM"].ToString().Trim();
                        if (finalRemarkMap.ContainsKey(key))
                        {
                            row["FinalRemark"] = finalRemarkMap[key];
                        }
                        //var interventiondesc = row["INVENTDESCRIPT"];
                        var intervaddby = row["INTERVADDBY"];
                        //if (interventiondesc != "")
                        //{
                        //    row["INVENTDESCRIPT"] = interventiondesc + " - " + GeneralFunction.GetUserName(intervaddby.ToString().Trim());
                        //}
                        row["INTERVADDBY"] = GeneralFunction.GetUserName(intervaddby.ToString().Trim());
                        row["INTERVADDON"] = GeneralFunction.GetDate(row["INTERVADDON"].ToString().Trim());
                        row["INTERVADDAT"] = GeneralFunction.ConvertTo12HourFormat(row["INTERVADDAT"].ToString().Trim());
                    }

                    // 🗑 Remove rows where all 5 columns are empty
                    for (int i = problemcdTable.Rows.Count - 1; i >= 0; i--)
                    {
                        bool allEmpty =
                            string.IsNullOrWhiteSpace(problemcdTable.Rows[i]["ASSESSMENT"].ToString()) &&
                            string.IsNullOrWhiteSpace(problemcdTable.Rows[i]["EXPECTOUTPUT"].ToString()) &&
                            string.IsNullOrWhiteSpace(problemcdTable.Rows[i]["PLANNING"].ToString()) &&
                            string.IsNullOrWhiteSpace(problemcdTable.Rows[i]["INVENTDESCRIPT"].ToString()) &&
                            string.IsNullOrWhiteSpace(problemcdTable.Rows[i]["EVALWITHTM"].ToString());

                        if (allEmpty)
                        {
                            problemcdTable.Rows.RemoveAt(i);
                        }
                    }

                    if (!string.IsNullOrEmpty(ProblemCD))
                    {
                        filteredRows = problemcdTable.Select(string.Format("PROBCODE = '{0}'", ProblemCD));

                    }
                    else
                    {
                        filteredRows = problemcdTable.Select();
                    }


                    if (filteredRows != null && filteredRows.Length > 0)
                    {
                        DataTable filteredTable = problemcdTable.Clone();
                        filteredTable = filteredRows.CopyToDataTable();
                        load.Tables.Remove("Table");
                        filteredTable.TableName = "Table";
                        load.Tables.Add(filteredTable);
                    }
                    else
                    {
                        load.Tables.Remove("Table");
                        return load;
                    }

                }
                else
                {
                    return load;
                }
            }
            object[] obj = new object[1];



            if (ReportType == "PROGNOTE") // Nurse Note
            {
                loads.ReadXml(new XmlTextReader(new StringReader(icuClient.GetAddNurseNotes(
                strIPNo, strFromDate, strTime, strToDate, strToTime, userid, "N"))));


                if (loads.Tables.Contains("Table") && loads.Tables["Table"] != null)
                {
                    DataTable nurseNotesTable = loads.Tables["Table"];
                    DataRow[] filteredRows = null;

                    if (!string.IsNullOrEmpty(NoteType))
                    {
                        var noteTypes = NoteType.Trim().Split('|');
                        string filterCondition;

                        if (noteTypes.Length == 1)
                        {
                            filterCondition = "NOTETYPE = '" + noteTypes[0].Replace("'", "''") + "'";
                        }
                        else
                        {
                            List<string> conditions = new List<string>();
                            foreach (string nt in noteTypes)
                            {
                                conditions.Add("NOTETYPE = '" + nt.Replace("'", "''") + "'");
                            }
                            filterCondition = string.Join(" OR ", conditions);
                        }

                        // ✅ FIXED: Don't redeclare filteredRows
                        filteredRows = nurseNotesTable.Select(filterCondition);

                        if (filteredRows != null && filteredRows.Length > 0)
                        {
                            DataTable filteredTable = nurseNotesTable.Clone();
                            filteredTable = filteredRows.CopyToDataTable();
                            loads.Tables.Remove("Table");
                            filteredTable.TableName = "Table";
                            loads.Tables.Add(filteredTable);
                        }
                        else
                        {
                            loads.Tables.Remove("Table");
                            return load;
                        }
                    }
                }


                else
                {
                    return load;
                }
            }

            /*Madhuri:- End Code for seprating 2 reports*/

            DataTable dtnotes = new DataTable();

            if (ReportType == "PROGNOTE") //PROGRESS  NOTE
            {
                if (loads.Tables.Count > 0)
                {
                    for (int i = 0; i <= loads.Tables[0].Rows.Count - 1; i++)
                    {

                        loads.Tables[0].Rows[i]["NOTEDT"] = GeneralFunction.GetDate(loads.Tables[0].Rows[i]["NOTEDT"].ToString());
                        loads.Tables[0].Rows[i]["USERID"] = GeneralFunction.GetFstNameUserId(loads.Tables[0].Rows[i]["USERID"].ToString().Trim());
                        loads.Tables[0].Rows[i]["VERIFIEDBY"] = GeneralFunction.GetFstNameUserId(loads.Tables[0].Rows[i]["VERIFIEDBY"].ToString().Trim());
                        //loads.Tables[0].Rows[i]["USERID"] = loads.Tables[0].Rows[i]["USERID"].Equals(loads.Tables[0].Rows[i]["VERIFIEDBY"]) ? loads.Tables[0].Rows[i]["USERID"].ToString().Trim() : loads.Tables[0].Rows[i]["USERID"].ToString().Trim() + "/" + loads.Tables[0].Rows[i]["VERIFIEDBY"].ToString().Trim();
                        loads.Tables[0].Rows[i]["USERID"] = loads.Tables[0].Rows[i]["USERID"].Equals(loads.Tables[0].Rows[i]["VERIFIEDBY"])
                                                 ? loads.Tables[0].Rows[i]["USERID"].ToString().Trim()
                                                 : loads.Tables[0].Rows[i]["USERID"].ToString().Trim() +
                                                   (string.IsNullOrEmpty(loads.Tables[0].Rows[i]["VERIFIEDBY"].ToString().Trim()) ? "" : "/" + loads.Tables[0].Rows[i]["VERIFIEDBY"].ToString().Trim());

                    }
                    dtnotes = loads.Tables[0].Copy();
                    dtnotes.TableName = "NURSADDNOTES";
                    dsFinalForPrint.Tables.Add(dtnotes);
                    dt3.Rows[0]["NURSENOTES"] = loads.Tables[0].Rows[0]["NURSENOTES"];

                }
                else
                {
                    dtnotes.TableName = "NURSADDNOTES";
                    dtnotes.Columns.Add("IPNO");
                    dtnotes.Columns.Add("NOTEDT");
                    dtnotes.Columns.Add("NOTETM");
                    dtnotes.Columns.Add("NURSENOTES");
                    dtnotes.Columns.Add("USERID");
                    //dtnotes.Columns.Add("CREATEDON");
                    dtnotes.Columns.Add("CREATEDAT");
                    dtnotes.Columns.Add("INKCOLOR");
                    dsFinalForPrint.Tables.Add(dtnotes);
                }
            }

            ///Addes by vishal as on 14th March ///
            if (ReportType == "NURSINGNOTES") //Care Plan
            {
                if (load.Tables.Count == 0)
                {
                    obj[0] = "";

                    dt2.TableName = "NursingNotes";
                    dt2.Columns.Add("STAFFNAME");
                    dt2.Columns.Add("prblmdate");
                    dt2.Columns.Add("PROBLEMS");
                    dt2.Columns.Add("PROBLEMTIME");
                    dt2.Columns.Add("PROBLEMCODE");
                    dt2.Columns.Add("Select");
                    dt2.Columns.Add("INTERVENTIONCODE");
                    dt2.Columns.Add("INTERVENTIONTEXT");
                    dt2.Columns.Add("EVALAUTETIME");
                    dt2.Columns.Add("STAFFID");
                    dt2.Columns.Add("PROBLEMTEXT");
                    dt2.Columns.Add("ASSESSMENT");
                    //Aaryshree changes done on 21/06/2025
                    dt2.Columns.Add("PLANNINGTXT");
                    dt2.Columns.Add("ExpectedOutcome");
                    dt2.Columns.Add("FinalRemark");
                    //Madhuri 02/07/2025
                    dt2.Columns.Add("VERIFIEDBY");
                    dt2.Columns.Add("REMARKADDBY");

                    dsFinalForPrint.Tables.Add(dt2);
                }
                else
                {
                    if (load.Tables.Count > 0)
                    {
                        load.Tables[0].TableName = "NursingNotes";
                        load.Tables[0].Columns.Add("STAFFNAME");
                        load.Tables[0].Columns.Add("prblmdate");
                        load.Tables[0].Columns.Add("PROBLEMS");
                        load.Tables[0].Columns.Add("GrpPrblemsWithTime");
                        load.Tables[0].Columns["PROBTM"].ColumnName = "PROBLEMTIME";
                        load.Tables[0].Columns["PROBCODE"].ColumnName = "PROBLEMCODE";
                        load.Tables[0].Columns["SELECTEDYN"].ColumnName = "Select";
                        load.Tables[0].Columns["INTERVENTCD"].ColumnName = "INTERVENTIONCODE";
                        load.Tables[0].Columns["INVENTDESCRIPT"].ColumnName = "INTERVENTIONTEXT";
                        load.Tables[0].Columns["EVALWITHTM"].ColumnName = "EVALAUTETIME";
                        load.Tables[0].Columns["USERID"].ColumnName = "STAFFID";
                        load.Tables[0].Columns["PROBLEMTXT"].ColumnName = "PROBLEMTEXT";
                        load.Tables[0].Columns["ASSESSMENT"].ColumnName = "ASSESSMENT";
                        load.Tables[0].Columns["PLANNING"].ColumnName = "PLANNING";

                        //Aaryshree changes done on 21/06/2025
                        load.Tables[0].Columns["EXPECTOUTPUT"].ColumnName = "ExpectedOutcome";
                        load.Tables[0].Columns["FINALREMARK"].ColumnName = "FinalRemark";

                        for (var i = 0; i <= load.Tables[0].Rows.Count - 1; i++)
                        {
                            load.Tables[0].Rows[i]["STAFFNAME"] = load.Tables[0].Rows[i]["STAFFID"];
                            //load.Tables[0].Rows[i]["STAFFNAME"] = comclient.GetUserList().Where(x => x.Value == ("" + load.Tables[0].Rows[i]["STAFFID"]).Trim()).Count() == 0 ? "" : comclient.GetUserList().Where(x => x.Value == ("" + load.Tables[0].Rows[i]["STAFFID"]).Trim()).First().Text;
                            load.Tables[0].Rows[i]["prblmdate"] = GeneralFunction.GetDate(strFromDate);
                            load.Tables[0].Rows[i]["PROBLEMS"] = load.Tables[0].Rows[i]["PROBLEMTEXT"]; //+ "      " + load.Tables[0].Rows[i]["PROBLEMTIME"];
                            load.Tables[0].Rows[i]["NOTEDT"] = GeneralFunction.GetDate(load.Tables[0].Rows[i]["NOTEDT"].ToString());
                            load.Tables[0].Rows[i]["GrpPrblemsWithTime"] = load.Tables[0].Rows[i]["PROBLEMTIME"].ToString().Trim() + "    " + load.Tables[0].Rows[i]["PROBLEMTEXT"].ToString().Trim();
                            // load.Tables[0].Rows[i]["STAFFID"] = GeneralFunction.GetFstNameUserId(load.Tables[0].Rows[i]["STAFFID"].ToString().Trim());
                            load.Tables[0].Rows[i]["STAFFID"] = GeneralFunction.GetListValue(common.GetUserList(), load.Tables[0].Rows[i]["STAFFID"].ToString().Trim());
                            load.Tables[0].Rows[i]["VERIFIEDBY"] = GeneralFunction.GetListValue(common.GetUserList(), load.Tables[0].Rows[i]["VERIFIEDBY"].ToString().Trim());
                            load.Tables[0].Rows[i]["REMARKADDBY"] = GeneralFunction.GetListValue(common.GetUserList(), load.Tables[0].Rows[i]["REMARKADDBY"].ToString().Trim());
                            load.Tables[0].Rows[i]["REMARKADDON"] = GeneralFunction.GetDate(load.Tables[0].Rows[i]["REMARKADDON"].ToString().Trim());
                            load.Tables[0].Rows[i]["REMARKADDAT"] = GeneralFunction.ConvertTo12HourFormat(load.Tables[0].Rows[i]["REMARKADDAT"].ToString().Trim());
                            load.Tables[0].Rows[i]["STAFFID"] = load.Tables[0].Rows[i]["STAFFID"].Equals(load.Tables[0].Rows[i]["VERIFIEDBY"]) ? load.Tables[0].Rows[i]["STAFFID"].ToString().Trim() : load.Tables[0].Rows[i]["STAFFID"].ToString().Trim() + "/" + load.Tables[0].Rows[i]["VERIFIEDBY"].ToString().Trim();
                        }

                        DataTable ddt = new DataTable();
                        ddt = load.Tables[0].Copy();
                        DataRow[] tr = ddt.Select("select='Y'");
                        ddt = tr.CopyToDataTable();
                        ddt.TableName = "NursingNotes";
                        dsFinalForPrint.Tables.Add(ddt);
                    }
                    else
                    {
                        //DataTable finalDt = new DataTable();
                        //finalDt.TableName = "DIABETIC";
                        //finalDt.Columns.Add("CADATE");
                        //finalDt.Columns.Add("CATIME");
                        //finalDt.Columns.Add("HGT");
                        //finalDt.Columns.Add("US");
                        //finalDt.Columns.Add("UK");
                        //finalDt.Columns.Add("HGTMEDADMN");
                        //finalDt.Columns.Add("IPNO");
                        //dsFinalForPrint.Tables.Add(finalDt);
                    }


                }
            }
            HData = GeneralFunction.getHeaderFooter("Nursing Care Plan", "", "", "");
            if (HData.Rows.Count > 0 && HData.Columns.Contains("PrintDateTime"))
            {
                string dateTimeStr = HData.Rows[0]["PrintDateTime"].ToString();

                string[] parts = dateTimeStr.Split(new[] { " - " }, StringSplitOptions.None);

                if (parts.Length == 2)
                {
                    string datePart = parts[0];
                    string timePart = parts[1];

                    string formattedTime = DateTime.Parse(timePart).ToString("hh:mm tt");

                    HData.Rows[0]["PrintDateTime"] = datePart + " - " + formattedTime;
                }
            }

            string FrmDt = GeneralFunction.GetDate(strFromDate);
            string ToDt = GeneralFunction.GetDate(strToDate);
            HData.TableName = "HeaderFooter";
            if (FrmDt == strToDate)
                HData.Rows[0]["ForDate"] = "On " + FrmDt;
            else
                HData.Rows[0]["ForDate"] = "From " + FrmDt + " To " + ToDt;
            HData.Columns.Remove("Duplicate");
            dsFinalForPrint.Tables.Add(HData);

            dt1.TableName = "PatInfoNursgNotes";
            if (dsPatInfo.Tables.Count > 0)
            {
                dt = dsPatInfo.Tables[0];

                dt1.Columns.Add("strUIPNo");
                dt1.Columns.Add("strUMrNo");
                dt1.Columns.Add("strUAdmDtTm");
                dt1.Columns.Add("strUName");
                dt1.Columns.Add("strUTariffCat");
                dt1.Columns.Add("strUOccuBedCat");
                dt1.Columns.Add("strUAgeGender");
                dt1.Columns.Add("strUPatCat");
                dt1.Columns.Add("strUBillBedCat");
                dt1.Columns.Add("strUBedward");
                dt1.Columns.Add("strUNurstSta");
                dt1.Columns.Add("strUAdmDr");
                dt1.Columns.Add("strUConsDr");
                dt1.Columns.Add("strUExempCat");
                dt1.Columns.Add("strUInshuComp");
                dt1.Columns.Add("strEmpID");
                dt1.Columns.Add("strUCrdComp");
                DataRow patRow = dt1.NewRow();
                patRow["strUIPNo"] = dt.Rows[0]["IPNO"].ToString();
                patRow["strUMrNo"] = dt.Rows[0]["MRNO"].ToString();
                patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString()) + " / " + GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                patRow["strUName"] = dt.Rows[0]["SALUNAME"].ToString() + "  " + dt.Rows[0]["PATNAME"].ToString();
                patRow["strUTariffCat"] = dt.Rows[0]["TARIFFDESC"].ToString();
                patRow["strUOccuBedCat"] = dt.Rows[0]["OCCUBEDCATGNM"].ToString();
                //patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + "   " + dt.Rows[0]["Gender"].ToString();
                patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + " / " + dt.Rows[0]["Gender"].ToString();
                patRow["strUPatCat"] = dt.Rows[0]["PATCATGNM"].ToString();
                patRow["strUBillBedCat"] = dt.Rows[0]["BLBEDCATGNM"].ToString();
                patRow["strUBedward"] = dt.Rows[0]["WARDNM"].ToString();
                patRow["strUNurstSta"] = dt.Rows[0]["NURSTNM"].ToString();
                patRow["strUAdmDr"] = dt.Rows[0]["ADMNDOCTNM"].ToString();
                patRow["strUConsDr"] = dt.Rows[0]["CONSDOCT"].ToString();
                patRow["strUExempCat"] = dt.Rows[0]["EXEMPNM"].ToString();
                patRow["strUInshuComp"] = dt.Rows[0]["INSURCMPNM"].ToString();
                patRow["strEmpID"] = "";
                patRow["strUCrdComp"] = dt.Rows[0]["COMPNAME"].ToString();
                dt1.Rows.Add(patRow);
                dsFinalForPrint.Tables.Add(dt1);
            }
            return dsFinalForPrint;
        }

        public DataSet GetUCVBundleCheckListData(string strIPNo, string strDate, string strToDt, string strNsNm, string strBundletype, string strTime)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable finalurinary = new DataTable();
            DataTable finalcentral = new DataTable();
            DataTable finalventilator = new DataTable();
            DataTable finalhddialyzer = new DataTable();
            finalurinary.TableName = "URINARY";
            finalcentral.TableName = "CENTRAL";
            finalventilator.TableName = "VENTILATOR";
            finalhddialyzer.TableName = "HDDIALYZER";
            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");
            DataTable dtucv = new DataTable();

            DataTable dtDate = new DataTable();
            DataTable dtCDate = new DataTable();
            DataTable dtVDate = new DataTable();
            DataTable dtHDDate = new DataTable();
            DataTable dtproc = new DataTable();
            DataTable dt = new DataTable();
            DataTable dt1 = new DataTable();
            DataTable HData = new DataTable();
            DataTable combinedtbl = new DataTable();
            DataTable tbldatacount = new DataTable();

            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            try
            {
                load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetBundleCheckList(strIPNo, strDate, "", "", strToDt, strTime))));

                object[] obj = new object[1];

                if (load == null)
                {
                    obj[0] = "";
                }
                else
                {
                    if (load.Tables.Count > 0)
                    {

                        DataTable dt1u = new DataTable();
                        DataRow[] dru = load.Tables[0].Select("TUBETYPE='U'");
                        if (dru.Length > 0)
                        {
                            dt1u = dru.CopyToDataTable();
                        }
                        else
                        {
                            dt1u = null;
                        }


                        DataTable dt1c = new DataTable();
                        DataRow[] drc = load.Tables[0].Select("TUBETYPE='C'");
                        if (drc.Length > 0)
                        {
                            dt1c = drc.CopyToDataTable();
                        }
                        else
                        {
                            dt1c = null;
                        }

                        DataTable dt1v = new DataTable();
                        DataRow[] drv = load.Tables[0].Select("TUBETYPE='V'");
                        if (drv.Length > 0)
                        {
                            dt1v = drv.CopyToDataTable();
                        }
                        else
                        {
                            dt1v = null;
                        }

                        DataTable dt1d = new DataTable();
                        DataRow[] drd = load.Tables[0].Select("TUBETYPE='D'");
                        if (drd.Length > 0)
                        {
                            dt1d = drd.CopyToDataTable();
                        }
                        else
                        {
                            dt1d = null;
                        }

                        dtucv.TableName = "UCVCheckListData";
                        load.Tables[0].DefaultView.ToTable(false, "UCLIREASONYN", "CCLIREASONYN", "VCLIREASONYN", "UAPPEQUIPYN", "CAPPEQUIPYN", "VAPPEQUIPYN", "UHYGINEYN", "CHYGINEYN", "VHYGINEYN", "HDCLIREASYN", "HDEQUIPYN", "HDHYGINEYN", "STAFFNAME", "SHIFTTIME");

                        dtucv.Columns.Add("UCLIREASONYN1");
                        dtucv.Columns.Add("UAPPEQUIPYN1");
                        dtucv.Columns.Add("UHYGINEYN1");

                        dtucv.Columns.Add("CCLIREASONYN2");
                        dtucv.Columns.Add("CAPPEQUIPYN2");
                        dtucv.Columns.Add("CHYGINEYN2");

                        dtucv.Columns.Add("VCLIREASONYN3");
                        dtucv.Columns.Add("VAPPEQUIPYN3");
                        dtucv.Columns.Add("VHYGINEYN3");

                        //HDCLIREASONYN4,HDAPPEQUIPYN4,HDHYGINEYN4
                        dtucv.Columns.Add("HDCLIREASYN");
                        dtucv.Columns.Add("HDEQUIPYN");
                        dtucv.Columns.Add("HDHYGINEYN");

                        dtucv.Columns.Add("REMARKS");
                        dtucv.Columns.Add("STAFFNAME");
                        dtucv.Columns.Add("SHIFTTIME");

                        //dtucv.Columns.Add("UREMARKS");
                        //dtucv.Columns.Add("CREMARKS");
                        //dtucv.Columns.Add("VREMARKS");
                        //dtucv.Columns.Add("DREMARKS");
                        //dtucv.Columns.Add("USTAFFNAME");
                        //dtucv.Columns.Add("CSTAFFNAME");
                        //dtucv.Columns.Add("VSTAFFNAME");
                        //dtucv.Columns.Add("DSTAFFNAME");

                        DataRow dr = dtucv.NewRow();


                        if (dt1v != null)
                        {
                            dr["VCLIREASONYN3"] = dt1v.Rows[0]["VCLIREASONYN"].ToString();
                            dr["VAPPEQUIPYN3"] = dt1v.Rows[0]["VAPPEQUIPYN"].ToString();
                            dr["VHYGINEYN3"] = dt1v.Rows[0]["VHYGINEYN"].ToString();
                        }

                        if (dt1u != null)
                        {
                            dr["UCLIREASONYN1"] = dt1u.Rows[0]["UCLIREASONYN"].ToString();
                            dr["UAPPEQUIPYN1"] = dt1u.Rows[0]["UAPPEQUIPYN"].ToString();
                            dr["UHYGINEYN1"] = dt1u.Rows[0]["UHYGINEYN"].ToString();
                        }
                        if (dt1c != null)
                        {
                            dr["CAPPEQUIPYN2"] = dt1c.Rows[0]["CAPPEQUIPYN"].ToString();
                            dr["CHYGINEYN2"] = dt1c.Rows[0]["CHYGINEYN"].ToString();
                            dr["CCLIREASONYN2"] = dt1c.Rows[0]["CCLIREASONYN"].ToString();
                        }

                        //dr["REMARKS"] = load.Tables[0].Rows[0]["REMARKS"];
                        //dr["STAFFNAME"] = load.Tables[0].Rows[0]["STAFFNAME"];

                        dr["SHIFTTIME"] = load.Tables[0].Rows[0]["SHIFTTIME"];
                        if (dt1d != null) //"HDCLIREASONYN", "HDEQUIPYN", "HDHYGINEYN"
                        {
                            dr["HDEQUIPYN"] = dt1d.Rows[0]["HDEQUIPYN"].ToString();
                            dr["HDHYGINEYN"] = dt1d.Rows[0]["HDHYGINEYN"].ToString();
                            dr["HDCLIREASYN"] = dt1d.Rows[0]["HDCLIREASYN"].ToString();
                        }

                        //combinedtbl = GeneralFunction.CombineTablesDistinct(new List<DataTable> { dt1u, dt1c, dt1v, dt1d }, new List<string> { "CHKLSTDT", "REMARKS", "STAFFNAME" }, "CHKLSTDT", true);
                        //combinedtbl.TableName = "RemarkStfName";

                        combinedtbl = GeneralFunction.CombineTablesDistinct(new List<DataTable> { dt1u, dt1c, dt1v, dt1d }, new List<string> { "CHKLSTDT", "REMARKS", "STAFFNAME" }, dateColumn: "CHKLSTDT",
                            sortByColumn: "CHKLSTDT", ascending: true);

                        combinedtbl.TableName = "RemarkStfName";
                        dtucv.Rows.Add(dr);

                        var distinctIds = load.Tables[0].AsEnumerable()
                   .Select(s => new
                   {
                       id = s.Field<string>("CHKLSTDT"),
                   })
                   .Distinct().ToList();
                        var leng = distinctIds.Count - 1;
                        dtproc.Columns.Add("cathprocdoneby");
                        dtproc.Columns.Add("urinprocdoneby");
                        dtproc.Columns.Add("ventirocdoneby");
                        dtproc.Columns.Add("cathdoi");
                        dtproc.Columns.Add("cathdor");
                        dtproc.Columns.Add("urindoi");
                        dtproc.Columns.Add("urindor");
                        dtproc.Columns.Add("ventidoi");
                        dtproc.Columns.Add("ventidor");
                        dtproc.Columns.Add("bundletype");
                        dtproc.Columns.Add("hddoi");
                        dtproc.Columns.Add("hddor");
                        dtproc.Columns.Add("hdprocdoneby");
                        DataRow dtprocrow = dtproc.NewRow();
                        DataTable dtc = new DataTable();
                        if (dt1u != null)
                        {
                            var i = dt1u.Rows.Count - 1;
                            dtprocrow["urinprocdoneby"] = dt1u.Rows[0]["URINPROCDONEBY"].ToString();
                            var urindoi = GeneralFunction.GetDate(dt1u.Rows[0]["URINDOI"].ToString());
                            if (dt1u.Rows[0]["URINPROCDONEBY"].ToString().Trim() == "OutSide" && urindoi.ToString().Trim() == "")
                            {
                                dtprocrow["urindoi"] = "Not Known";
                            }
                            else
                            {
                                dtprocrow["urindoi"] = GeneralFunction.GetDate(dt1u.Rows[0]["URINDOI"].ToString());
                            }
                            dtprocrow["urindor"] = GeneralFunction.GetDate(dt1u.Rows[i]["URINDOR"].ToString());
                        }
                        if (dt1c != null)
                        {
                            var i = dt1c.Rows.Count - 1;
                            dtprocrow["cathprocdoneby"] = dt1c.Rows[0]["CATHPROCDONEBY"].ToString();
                            var cathdoi = GeneralFunction.GetDate(dt1c.Rows[0]["CATHDOI"].ToString());
                            if (dt1c.Rows[0]["CATHPROCDONEBY"].ToString().Trim() == "OutSide" && !String.IsNullOrEmpty(cathdoi.ToString().Trim()))
                            {
                                dtprocrow["cathdoi"] = "Not Known";
                            }
                            else
                            {
                                dtprocrow["cathdoi"] = GeneralFunction.GetDate(dt1c.Rows[0]["CATHDOI"].ToString());
                            }
                            dtprocrow["cathdor"] = GeneralFunction.GetDate(dt1c.Rows[i]["CATHDOR"].ToString());
                        }

                        if (dt1v != null)
                        {
                            var i = dt1v.Rows.Count - 1;
                            dtprocrow["ventirocdoneby"] = dt1v.Rows[0]["VENTIROCDONEBY"].ToString();
                            var ventidoi = GeneralFunction.GetDate(dt1v.Rows[0]["VENTIDOI"].ToString());
                            if (dt1v.Rows[0]["VENTIROCDONEBY"].ToString().Trim() == "OutSide" && ventidoi.ToString().Trim() == "")
                            {
                                dtprocrow["ventidoi"] = "Not Known";
                            }
                            else
                            {
                                dtprocrow["ventidoi"] = GeneralFunction.GetDate(dt1v.Rows[0]["VENTIDOI"].ToString());
                            }
                            dtprocrow["ventidor"] = GeneralFunction.GetDate(dt1v.Rows[i]["VENTIDOR"].ToString());
                        }
                        //HDPROCDONEBY,HDDOI,HDDOR
                        if (dt1d != null)
                        {
                            var i = dt1d.Rows.Count - 1;
                            dtprocrow["hdprocdoneby"] = dt1d.Rows[0]["HDPROCDONEBY"].ToString();
                            var hddoi = GeneralFunction.GetDate(dt1d.Rows[0]["HDDOI"].ToString());
                            if (dt1d.Rows[0]["HDPROCDONEBY"].ToString().Trim() == "OutSide" && hddoi.ToString().Trim() == "")
                            {
                                dtprocrow["hddoi"] = "Not Known";
                            }
                            else
                            {
                                dtprocrow["hddoi"] = GeneralFunction.GetDate(dt1d.Rows[0]["HDDOI"].ToString());
                            }
                            dtprocrow["hddor"] = GeneralFunction.GetDate(dt1d.Rows[i]["HDDOR"].ToString());
                        }
                        dtprocrow["bundletype"] = load.Tables[0].Rows[0]["bundletype"];
                        dtproc.Rows.Add(dtprocrow);
                        dtDate.TableName = "DATE";
                        dtDate.Columns.Add("Column1");
                        dtDate.Columns.Add("Column2");
                        dtDate.Columns.Add("Column3");
                        dtDate.Columns.Add("Column4");
                        dtDate.Columns.Add("Column5");
                        dtDate.Columns.Add("Column6");
                        dtDate.Columns.Add("Column7");
                        dtDate.Columns.Add("Column8");
                        dtDate.Columns.Add("Column9");
                        dtDate.Columns.Add("Column10");
                        dtDate.Rows.Add();
                        int g = 0;
                        foreach (DataColumn column in dtDate.Columns)
                        {
                            if (g <= leng)
                            {
                                var a = GeneralFunction.GetDate(distinctIds[g].id);
                                var d1 = a.Substring(0, 6);
                                var d2 = a.Substring(8, 2);
                                dtDate.Rows[0][column.ColumnName] = d1 + d2;
                                g++;
                            }
                            else
                            {
                                dtDate.Rows[0][column.ColumnName] = "";
                            }
                        }
                        CommonServiceClient comclient = new CommonServiceClient();
                        var UCheckList = comclient.GetICUBundleChkList().Where(x => x.BundleType == "U" && x.Status == "A").ToArray();
                        var CCheckList = comclient.GetICUBundleChkList().Where(x => x.BundleType == "C" && x.Status == "A").ToArray();
                        var VCheckList = comclient.GetICUBundleChkList().Where(x => x.BundleType == "V" && x.Status == "A").ToArray();
                        var HDCheckList = comclient.GetICUBundleChkList().Where(x => x.BundleType == "D" && x.Status == "A").ToArray();
                        //DataTable dturinary = new DataTable();
                        finalurinary.Columns.Add("Code");
                        finalurinary.Columns.Add("Name");
                        int u = 0;
                        foreach (DataColumn column in dtDate.Columns)
                        {
                            if (u <= leng)
                            {

                                finalurinary.Columns.Add(GeneralFunction.GetDate(distinctIds[u].id));
                                u++;
                            }
                            else
                            {
                                finalurinary.Columns.Add(column.ColumnName);
                            }
                        }

                        int cn = 0;
                        finalcentral.Columns.Add("Code");
                        finalcentral.Columns.Add("Name");
                        foreach (DataColumn column in dtDate.Columns)
                        {
                            if (cn <= leng)
                            {
                                finalcentral.Columns.Add(GeneralFunction.GetDate(distinctIds[cn].id));
                                cn++;
                            }
                            else
                            {
                                finalcentral.Columns.Add(column.ColumnName);
                            }
                        }

                        int v = 0;
                        finalventilator.Columns.Add("Code");
                        finalventilator.Columns.Add("Name");
                        foreach (DataColumn column in dtDate.Columns)
                        {
                            if (v <= leng)
                            {
                                finalventilator.Columns.Add(GeneralFunction.GetDate(distinctIds[v].id));
                                v++;
                            }
                            else
                            {
                                finalventilator.Columns.Add(column.ColumnName);
                            }
                        }
                        finalhddialyzer.Columns.Add("Code");
                        finalhddialyzer.Columns.Add("Name");
                        int r = 0;
                        foreach (DataColumn column in dtDate.Columns)
                        {
                            if (r <= leng)
                            {

                                finalhddialyzer.Columns.Add(GeneralFunction.GetDate(distinctIds[r].id));
                                r++;
                            }
                            else
                            {
                                finalhddialyzer.Columns.Add(column.ColumnName);
                            }
                        }

                        //for (int f = 0; f <= UCheckList.Count() - 1; f++)
                        //{
                        //    DataRow dr1 = finalurinary.NewRow();
                        //    dr1["Code"] = UCheckList[f].Value;
                        //    dr1["Name"] = UCheckList[f].Text;
                        //    finalurinary.Rows.Add(dr1);
                        //}
                        // ✅ Get unique TRANNOs for TUBETYPE = 'U'
                        var uniqueUTrans = dt1u.AsEnumerable()
                            .Where(row => row.Field<string>("TUBETYPE") == "U")
                            .Select(row => new
                            {
                                UTranNo = row.Field<string>("URINTRANNO"),
                                UBundleType = row.Field<string>("UBUNDLETYPE"),
                                udoi = row.Field<string>("URINDOI"),
                                udor = row.Field<string>("URINDOR"),
                                uprocdoneby = row.Field<string>("URINPROCDONEBY")
                            })
                            .Distinct()
                            .ToList();

                        finalurinary.Columns.Add("UTRANNO");
                        finalurinary.Columns.Add("UBUNDLETYPE");
                        finalurinary.Columns.Add("UDOI");
                        finalurinary.Columns.Add("UDOR");
                        finalurinary.Columns.Add("UPROCDONEBY");


                        // ✅ Loop unique TRANNOs
                        foreach (var tran in uniqueUTrans)
                        {
                            for (int f = 0; f <= UCheckList.Count() - 1; f++)
                            {
                                DataRow dr1 = finalurinary.NewRow();
                                dr1["Code"] = UCheckList[f].Value;
                                dr1["Name"] = UCheckList[f].Text;

                                // Set TRANNO & BUNDLETYPE
                                dr1["UTRANNO"] = tran.UTranNo;
                                dr1["UBUNDLETYPE"] = tran.UBundleType;
                                dr1["UDOI"] = GeneralFunction.GetDate((tran.udoi).ToString().Trim());
                                dr1["UDOR"] = GeneralFunction.GetDate((tran.udor).ToString().Trim());
                                dr1["UPROCDONEBY"] = tran.uprocdoneby;

                                finalurinary.Rows.Add(dr1);
                            }
                        }





                        //for (int f = 0; f <= CCheckList.Count() - 1; f++)
                        //{
                        //    DataRow dr2 = finalcentral.NewRow();
                        //    dr2["Code"] = CCheckList[f].Value;
                        //    dr2["Name"] = CCheckList[f].Text;
                        //    finalcentral.Rows.Add(dr2);
                        //}

                        // ✅ Get unique CENTTRANNO + CBUNDLETYPE pairs for TUBETYPE = 'C'
                        var cuniqueTrans = dt1c.AsEnumerable()
                            .Where(row => row.Field<string>("TUBETYPE") == "C")
                            .Select(row => new
                            {
                                CTranNo = row.Field<string>("CENTTRANNO"),
                                CBundleType = row.Field<string>("CBUNDLETYPE"),
                                Cathdoi = row.Field<string>("CATHDOI"),
                                Cathdor = row.Field<string>("CATHDOR"),
                                Cathprocdoneby = row.Field<string>("CATHPROCDONEBY")

                            })
                            .Distinct()
                            .ToList();

                        // ✅ Add required columns
                        finalcentral.Columns.Add("CTRANNO");
                        finalcentral.Columns.Add("CBUNDLETYPE");
                        finalcentral.Columns.Add("CATHDOI");
                        finalcentral.Columns.Add("CATHDOR");
                        finalcentral.Columns.Add("CATHPROCDONEBY");

                        // ✅ Loop unique transactions
                        foreach (var tran in cuniqueTrans)
                        {
                            // ✅ For each transaction, repeat checklist
                            for (int f = 0; f < CCheckList.Count(); f++)
                            {
                                DataRow dr2 = finalcentral.NewRow();
                                dr2["Code"] = CCheckList[f].Value;
                                dr2["Name"] = CCheckList[f].Text;

                                // Set TRANNO and CBUNDLETYPE
                                dr2["CTRANNO"] = tran.CTranNo;
                                dr2["CBUNDLETYPE"] = tran.CBundleType;
                                dr2["CATHDOI"] = GeneralFunction.GetDate((tran.Cathdoi).ToString().Trim());
                                dr2["CATHDOR"] = GeneralFunction.GetDate((tran.Cathdor).ToString().Trim());
                                dr2["CATHPROCDONEBY"] = tran.Cathprocdoneby;
                                finalcentral.Rows.Add(dr2);
                            }
                        }




                        //for (int f = 0; f <= VCheckList.Count() - 1; f++)
                        //{
                        //    DataRow dr3 = finalventilator.NewRow();
                        //    dr3["Code"] = VCheckList[f].Value;
                        //    dr3["Name"] = VCheckList[f].Text;
                        //    finalventilator.Rows.Add(dr3);
                        //}
                        var vuniqueTrans = dt1v.AsEnumerable()
                            .Where(row => row.Field<string>("TUBETYPE") == "V")
                            .Select(row => new
                            {
                                VTranNo = row.Field<string>("VENTTRANNO"),
                                VBundleType = row.Field<string>("VBUNDLETYPE"),
                                Vdoi = row.Field<string>("VENTIDOI"),
                                Vdor = row.Field<string>("VENTIDOR"),
                                Vprocdoneby = row.Field<string>("VENTIROCDONEBY")
                            })
                            .Distinct()
                            .ToList();

                        // ✅ Add required columns (make sure "Code" & "Name" already exist)
                        finalventilator.Columns.Add("VTRANNO");
                        finalventilator.Columns.Add("VBUNDLETYPE");
                        finalventilator.Columns.Add("VDOI");
                        finalventilator.Columns.Add("VDOR");
                        finalventilator.Columns.Add("VPROCDONEBY");

                        // ✅ Loop unique transactions
                        foreach (var tran in vuniqueTrans)
                        {
                            // ✅ For each transaction, repeat checklist
                            for (int f = 0; f < VCheckList.Count(); f++)
                            {
                                DataRow dr3 = finalventilator.NewRow();
                                dr3["Code"] = VCheckList[f].Value;
                                dr3["Name"] = VCheckList[f].Text;

                                dr3["VTRANNO"] = tran.VTranNo;
                                dr3["VBUNDLETYPE"] = tran.VBundleType;
                                dr3["VDOI"] = GeneralFunction.GetDate(tran.Vdoi.Trim());
                                dr3["VDOR"] = GeneralFunction.GetDate(tran.Vdor.Trim());
                                dr3["VPROCDONEBY"] = tran.Vprocdoneby;

                                finalventilator.Rows.Add(dr3);
                            }
                        }


                        for (int f = 0; f <= HDCheckList.Count() - 1; f++)
                        {
                            DataRow dr4 = finalhddialyzer.NewRow();
                            dr4["Code"] = HDCheckList[f].Value;
                            dr4["Name"] = HDCheckList[f].Text;
                            finalhddialyzer.Rows.Add(dr4);
                        }

                        //if (dt1u != null)
                        //{
                        //    for (int d = 0; d <= dt1u.Rows.Count - 1; d++)
                        //    {
                        //        for (int c = 0; c <= finalurinary.Rows.Count - 1; c++)
                        //        {
                        //            if (finalurinary.Rows[c]["Code"].ToString() == dt1u.Rows[d]["CHKLSTCODE"].ToString())
                        //            {
                        //                foreach (DataColumn column in finalurinary.Columns)
                        //                {
                        //                    if (dt1u.Rows[d]["CHKLSTDT"].ToString() == GeneralFunction.GetDateInSpecifiedFormat(column.ColumnName, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD))
                        //                    {

                        //                        finalurinary.Rows[c][column.ColumnName] = "Y";
                        //                        if (dt1u.Rows[d]["VALUE"].ToString().Trim() != "")
                        //                        {
                        //                            finalurinary.Rows[c][column.ColumnName] = dt1u.Rows[d]["VALUE"].ToString().Trim();
                        //                        }

                        //                    }

                        //                }

                        //            }
                        //            else //if (("" + finalurinary.Rows[c][dt1u.Rows[d]["CHKLSTDT"].ToString()]) == "")
                        //            {
                        //                if (("" + finalurinary.Rows[c][GeneralFunction.GetDate(dt1u.Rows[d]["CHKLSTDT"].ToString())]).ToString() == "")
                        //                {
                        //                    finalurinary.Rows[c][GeneralFunction.GetDate(dt1u.Rows[d]["CHKLSTDT"].ToString())] = "N";
                        //                }
                        //            }


                        //        }
                        //    }

                        //}
                        if (dt1u != null)
                        {
                            for (int d = 0; d < dt1u.Rows.Count; d++)
                            {
                                for (int c = 0; c < finalurinary.Rows.Count; c++)
                                {
                                    // ✅ Match Code + TRANNO + BUNDLETYPE
                                    if (finalurinary.Rows[c]["Code"].ToString() == dt1u.Rows[d]["CHKLSTCODE"].ToString()
                                        && finalurinary.Rows[c]["UTRANNO"].ToString() == dt1u.Rows[d]["URINTRANNO"].ToString()
                                        && finalurinary.Rows[c]["UBUNDLETYPE"].ToString() == dt1u.Rows[d]["UBUNDLETYPE"].ToString())
                                    {
                                        foreach (DataColumn column in finalurinary.Columns)
                                        {
                                            if (dt1u.Rows[d]["CHKLSTDT"].ToString() ==
                                                GeneralFunction.GetDateInSpecifiedFormat(column.ColumnName,
                                                    GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD))
                                            {
                                                finalurinary.Rows[c][column.ColumnName] = "Y";

                                                // ✅ Overwrite if VALUE exists
                                                if (!string.IsNullOrWhiteSpace(dt1u.Rows[d]["VALUE"].ToString()))
                                                {
                                                    finalurinary.Rows[c][column.ColumnName] = dt1u.Rows[d]["VALUE"].ToString().Trim();
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                        // ✅ Only mark N if same TRANNO + BUNDLETYPE
                                        if (finalurinary.Rows[c]["UTRANNO"].ToString() == dt1u.Rows[d]["URINTRANNO"].ToString()
                                            && finalurinary.Rows[c]["UBUNDLETYPE"].ToString() == dt1u.Rows[d]["UBUNDLETYPE"].ToString())
                                        {
                                            var dateCol = GeneralFunction.GetDate(dt1u.Rows[d]["CHKLSTDT"].ToString());
                                            if (string.IsNullOrWhiteSpace("" + finalurinary.Rows[c][dateCol]))
                                            {
                                                finalurinary.Rows[c][dateCol] = "N";
                                            }
                                        }
                                    }
                                }
                            }
                        }




                        //if (dt1c != null)
                        //{
                        //    for (int d = 0; d <= dt1c.Rows.Count - 1; d++)
                        //    {
                        //        for (int c = 0; c <= finalcentral.Rows.Count - 1; c++)
                        //        {
                        //            if (finalcentral.Rows[c]["Code"].ToString() == dt1c.Rows[d]["CHKLSTCODE"].ToString())
                        //            {
                        //                foreach (DataColumn column in finalurinary.Columns)
                        //                {
                        //                    if (dt1c.Rows[d]["CHKLSTDT"].ToString() == GeneralFunction.GetDateInSpecifiedFormat(column.ColumnName, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD))
                        //                    {
                        //                        finalcentral.Rows[c][column.ColumnName] = "Y";

                        //                        if (dt1c.Rows[d]["VALUE"].ToString().Trim() != "")
                        //                        {
                        //                            finalcentral.Rows[c][column.ColumnName] = dt1c.Rows[d]["VALUE"].ToString().Trim();
                        //                        }
                        //                    }
                        //                }
                        //            }
                        //            else
                        //            {
                        //                if (("" + finalcentral.Rows[c][GeneralFunction.GetDate(dt1c.Rows[d]["CHKLSTDT"].ToString())]).ToString() == "")
                        //                {
                        //                    finalcentral.Rows[c][GeneralFunction.GetDate(dt1c.Rows[d]["CHKLSTDT"].ToString())] = "N";
                        //                }
                        //            }
                        //        }
                        //    }
                        //}

                        if (dt1c != null)
                        {
                            for (int d = 0; d < dt1c.Rows.Count; d++)
                            {
                                for (int c = 0; c < finalcentral.Rows.Count; c++)
                                {
                                    // ✅ Match on Code + TRANNO (+ optionally CBUNDLETYPE if needed)
                                    if (finalcentral.Rows[c]["Code"].ToString() == dt1c.Rows[d]["CHKLSTCODE"].ToString()
                                        && finalcentral.Rows[c]["CTRANNO"].ToString() == dt1c.Rows[d]["CENTTRANNO"].ToString()
                                        && finalcentral.Rows[c]["CBUNDLETYPE"].ToString() == dt1c.Rows[d]["CBUNDLETYPE"].ToString())
                                    {
                                        foreach (DataColumn column in finalurinary.Columns)
                                        {
                                            if (dt1c.Rows[d]["CHKLSTDT"].ToString() ==
                                                GeneralFunction.GetDateInSpecifiedFormat(column.ColumnName,
                                                    GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD))
                                            {
                                                finalcentral.Rows[c][column.ColumnName] = "Y";

                                                if (!string.IsNullOrWhiteSpace(dt1c.Rows[d]["VALUE"].ToString()))
                                                {
                                                    finalcentral.Rows[c][column.ColumnName] = dt1c.Rows[d]["VALUE"].ToString().Trim();
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                        // Only mark N if it's the same TRANNO + CBUNDLETYPE + matching date
                                        if (finalcentral.Rows[c]["CTRANNO"].ToString() == dt1c.Rows[d]["CENTTRANNO"].ToString()
                                            && finalcentral.Rows[c]["CBUNDLETYPE"].ToString() == dt1c.Rows[d]["CBUNDLETYPE"].ToString())
                                        {
                                            var dateCol = GeneralFunction.GetDate(dt1c.Rows[d]["CHKLSTDT"].ToString());
                                            if (("" + finalcentral.Rows[c][dateCol]).ToString() == "")
                                            {
                                                finalcentral.Rows[c][dateCol] = "N";
                                            }
                                        }
                                    }
                                }
                            }
                        }


                        //if (dt1v != null)
                        //{
                        //    for (int d = 0; d <= dt1v.Rows.Count - 1; d++)
                        //    {
                        //        for (int c = 0; c <= finalventilator.Rows.Count - 1; c++)
                        //        {
                        //            if (finalventilator.Rows[c]["Code"].ToString() == dt1v.Rows[d]["CHKLSTCODE"].ToString())
                        //            {
                        //                foreach (DataColumn column in finalurinary.Columns)
                        //                {
                        //                    if (dt1v.Rows[d]["CHKLSTDT"].ToString() == GeneralFunction.GetDateInSpecifiedFormat(column.ColumnName, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD))
                        //                    {
                        //                        finalventilator.Rows[c][column.ColumnName] = "Y";

                        //                        if (!String.IsNullOrEmpty(dt1v.Rows[d]["VALUE"].ToString().Trim()))
                        //                        {
                        //                            finalventilator.Rows[c][column.ColumnName] = dt1v.Rows[d]["VALUE"].ToString().Trim();
                        //                        }

                        //                    }
                        //                }
                        //            }
                        //            else
                        //            {
                        //                if (("" + finalventilator.Rows[c][GeneralFunction.GetDate(dt1v.Rows[d]["CHKLSTDT"].ToString())]).ToString() == "")
                        //                {
                        //                    finalventilator.Rows[c][GeneralFunction.GetDate(dt1v.Rows[d]["CHKLSTDT"].ToString())] = "N";
                        //                }
                        //            }
                        //        }
                        //    }
                        //}
                        if (dt1v != null)
                        {
                            for (int d = 0; d < dt1v.Rows.Count; d++)
                            {
                                for (int c = 0; c < finalventilator.Rows.Count; c++)
                                {
                                    // ✅ Match Code + TRANNO + BUNDLETYPE
                                    if (finalventilator.Rows[c]["Code"].ToString() == dt1v.Rows[d]["CHKLSTCODE"].ToString()
                                        && finalventilator.Rows[c]["VTRANNO"].ToString() == dt1v.Rows[d]["VENTTRANNO"].ToString()
                                        && finalventilator.Rows[c]["VBUNDLETYPE"].ToString() == dt1v.Rows[d]["VBUNDLETYPE"].ToString())
                                    {
                                        foreach (DataColumn column in finalventilator.Columns)
                                        {
                                            // ✅ Check if column matches the checklist date
                                            if (dt1v.Rows[d]["CHKLSTDT"].ToString() ==
                                                GeneralFunction.GetDateInSpecifiedFormat(column.ColumnName,
                                                    GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD))
                                            {
                                                finalventilator.Rows[c][column.ColumnName] = "Y";

                                                // ✅ Overwrite if VALUE exists
                                                if (!string.IsNullOrWhiteSpace(dt1v.Rows[d]["VALUE"].ToString()))
                                                {
                                                    finalventilator.Rows[c][column.ColumnName] = dt1v.Rows[d]["VALUE"].ToString().Trim();
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                        // ✅ Only mark N if same TRANNO + BUNDLETYPE and the cell is empty
                                        if (finalventilator.Rows[c]["VTRANNO"].ToString() == dt1v.Rows[d]["VENTTRANNO"].ToString()
                                            && finalventilator.Rows[c]["VBUNDLETYPE"].ToString() == dt1v.Rows[d]["VBUNDLETYPE"].ToString())
                                        {
                                            var dateCol = GeneralFunction.GetDate(dt1v.Rows[d]["CHKLSTDT"].ToString());
                                            if (string.IsNullOrWhiteSpace("" + finalventilator.Rows[c][dateCol]))
                                            {
                                                finalventilator.Rows[c][dateCol] = "N";
                                            }
                                        }
                                    }
                                }
                            }
                        }


                        if (dt1d != null)
                        {
                            for (int d = 0; d <= dt1d.Rows.Count - 1; d++)
                            {
                                for (int c = 0; c <= finalhddialyzer.Rows.Count - 1; c++)
                                {
                                    if (finalhddialyzer.Rows[c]["Code"].ToString() == dt1d.Rows[d]["CHKLSTCODE"].ToString())
                                    {
                                        foreach (DataColumn column in finalhddialyzer.Columns)
                                        {
                                            if (dt1d.Rows[d]["CHKLSTDT"].ToString() == GeneralFunction.GetDateInSpecifiedFormat(column.ColumnName, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD))
                                            {
                                                finalhddialyzer.Rows[c][column.ColumnName] = "Y";

                                                if (dt1d.Rows[d]["VALUE"].ToString().Trim() != "")
                                                {
                                                    finalhddialyzer.Rows[c][column.ColumnName] = dt1d.Rows[d]["VALUE"].ToString().Trim();
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (("" + finalhddialyzer.Rows[c][GeneralFunction.GetDate(dt1d.Rows[d]["CHKLSTDT"].ToString())]).ToString() == "")
                                        {
                                            finalhddialyzer.Rows[c][GeneralFunction.GetDate(dt1d.Rows[d]["CHKLSTDT"].ToString())] = "N";
                                        }
                                    }
                                }
                            }
                        }

                    }



                    dt1.TableName = "PatInfoNursgNotes";
                    if (load.Tables.Count > 0)
                    {
                        if (dsPatInfo.Tables.Count > 0)
                        {
                            dt = dsPatInfo.Tables[0];

                            dt1.Columns.Add("strUIPNo");
                            dt1.Columns.Add("strUMrNo");
                            dt1.Columns.Add("strUAdmDtTm");
                            dt1.Columns.Add("strUName");
                            dt1.Columns.Add("strUTariffCat");
                            dt1.Columns.Add("strUOccuBedCat");
                            dt1.Columns.Add("strUAgeGender");
                            dt1.Columns.Add("strUPatCat");
                            dt1.Columns.Add("strUBillBedCat");
                            dt1.Columns.Add("strUBedward");
                            dt1.Columns.Add("strUNurstSta");
                            dt1.Columns.Add("strUAdmDr");
                            dt1.Columns.Add("strUConsDr");
                            dt1.Columns.Add("strUExempCat");
                            dt1.Columns.Add("strUInshuComp");
                            dt1.Columns.Add("strEmpID");
                            dt1.Columns.Add("strUCrdComp");
                            dt1.Columns.Add("strBundletype");
                            DataRow patRow = dt1.NewRow();
                            patRow["strUIPNo"] = dt.Rows[0]["IPNO"].ToString();
                            patRow["strUMrNo"] = dt.Rows[0]["MRNO"].ToString();
                            //patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString()) + "   " + dt.Rows[0]["ADMNTIME"].ToString();
                            patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString()) + " / " + GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                            patRow["strUName"] = dt.Rows[0]["SALUNAME"].ToString() + "  " + dt.Rows[0]["PATNAME"].ToString();
                            patRow["strUTariffCat"] = dt.Rows[0]["TARIFFDESC"].ToString();
                            patRow["strUOccuBedCat"] = dt.Rows[0]["OCCUBEDCATGNM"].ToString();
                            //patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + "   " + dt.Rows[0]["Gender"].ToString();
                            patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + " / " + dt.Rows[0]["Gender"].ToString();
                            patRow["strUPatCat"] = dt.Rows[0]["PATCATGNM"].ToString();
                            patRow["strUBillBedCat"] = dt.Rows[0]["BLBEDCATGNM"].ToString();
                            patRow["strUBedward"] = dt.Rows[0]["WARDNM"].ToString();
                            patRow["strUNurstSta"] = dt.Rows[0]["NURSTNM"].ToString();
                            patRow["strUAdmDr"] = dt.Rows[0]["ADMNDOCTNM"].ToString();
                            patRow["strUConsDr"] = dt.Rows[0]["CONSDOCT"].ToString();
                            patRow["strUExempCat"] = dt.Rows[0]["EXEMPNM"].ToString();
                            patRow["strUInshuComp"] = dt.Rows[0]["INSURCMPNM"].ToString();
                            patRow["strEmpID"] = "";
                            patRow["strUCrdComp"] = dt.Rows[0]["COMPNAME"].ToString();
                            patRow["strBundletype"] = strBundletype.ToString().Trim();
                            dt1.Rows.Add(patRow);
                        }
                        finalurinary.Columns[2].ColumnName = "Column1";
                        finalurinary.Columns[3].ColumnName = "Column2";
                        finalurinary.Columns[4].ColumnName = "Column3";
                        finalurinary.Columns[5].ColumnName = "Column4";
                        finalurinary.Columns[6].ColumnName = "Column5";
                        finalurinary.Columns[7].ColumnName = "Column6";
                        finalurinary.Columns[8].ColumnName = "Column7";
                        finalurinary.Columns[9].ColumnName = "Column8";
                        finalurinary.Columns[10].ColumnName = "Column9";
                        finalurinary.Columns[11].ColumnName = "Column10";

                        finalcentral.Columns[2].ColumnName = "Column1";
                        finalcentral.Columns[3].ColumnName = "Column2";
                        finalcentral.Columns[4].ColumnName = "Column3";
                        finalcentral.Columns[5].ColumnName = "Column4";
                        finalcentral.Columns[6].ColumnName = "Column5";
                        finalcentral.Columns[7].ColumnName = "Column6";
                        finalcentral.Columns[8].ColumnName = "Column7";
                        finalcentral.Columns[9].ColumnName = "Column8";
                        finalcentral.Columns[10].ColumnName = "Column9";
                        finalcentral.Columns[11].ColumnName = "Column10";

                        finalventilator.Columns[2].ColumnName = "Column1";
                        finalventilator.Columns[3].ColumnName = "Column2";
                        finalventilator.Columns[4].ColumnName = "Column3";
                        finalventilator.Columns[5].ColumnName = "Column4";
                        finalventilator.Columns[6].ColumnName = "Column5";
                        finalventilator.Columns[7].ColumnName = "Column6";
                        finalventilator.Columns[8].ColumnName = "Column7";
                        finalventilator.Columns[9].ColumnName = "Column8";
                        finalventilator.Columns[10].ColumnName = "Column9";
                        finalventilator.Columns[11].ColumnName = "Column10";

                        finalhddialyzer.Columns[2].ColumnName = "Column1";
                        finalhddialyzer.Columns[3].ColumnName = "Column2";
                        finalhddialyzer.Columns[4].ColumnName = "Column3";
                        finalhddialyzer.Columns[5].ColumnName = "Column4";
                        finalhddialyzer.Columns[6].ColumnName = "Column5";
                        finalhddialyzer.Columns[7].ColumnName = "Column6";
                        finalhddialyzer.Columns[8].ColumnName = "Column7";
                        finalhddialyzer.Columns[9].ColumnName = "Column8";
                        finalhddialyzer.Columns[10].ColumnName = "Column9";
                        finalhddialyzer.Columns[11].ColumnName = "Column10";
                        foreach (DataRow row in dtucv.Rows)
                        {
                            string code = row["SHIFTTIME"].ToString().Trim();
                            if (code == "M")
                                row["SHIFTTIME"] = "Morning";
                            else if (code == "E")
                                row["SHIFTTIME"] = "Evening";
                            else if (code == "N")
                                row["SHIFTTIME"] = "Night";
                        }


                        dtCDate = dtDate.Copy();
                        dtVDate = dtDate.Copy();
                        dtHDDate = dtDate.Copy();
                        dtCDate.TableName = "CDate";
                        dtVDate.TableName = "VDate";
                        dtHDDate.TableName = "HDDate";
                        dtproc.TableName = "Procedure";
                        dsFinalForPrint.Tables.Add(dt1);
                        dsFinalForPrint.Tables.Add(finalurinary);
                        dsFinalForPrint.Tables.Add(finalcentral);
                        dsFinalForPrint.Tables.Add(finalventilator);
                        dsFinalForPrint.Tables.Add(dtDate);
                        dsFinalForPrint.Tables.Add(dtCDate);
                        dsFinalForPrint.Tables.Add(dtVDate);
                        dsFinalForPrint.Tables.Add(dtHDDate);
                        dsFinalForPrint.Tables.Add(dtproc);
                        dsFinalForPrint.Tables.Add(finalhddialyzer);
                        dsFinalForPrint.Tables.Add(combinedtbl);
                        HData = GeneralFunction.getHeaderFooter("Bundle Check List", "", "", "");
                        string strFrmDt = GeneralFunction.GetDate(strDate);
                        string strToDts = GeneralFunction.GetDate(strToDt);
                        HData.TableName = "HeaderFooter";
                        if (strFrmDt == strToDate)
                            HData.Rows[0]["ForDate"] = "On " + strFrmDt;
                        else
                            HData.Rows[0]["ForDate"] = "From " + strFrmDt + " To " + strToDts;
                        HData.Columns.Remove("Duplicate");
                        dsFinalForPrint.Tables.Add(HData);
                        dsFinalForPrint.Tables.Add(dtucv);
                        DataTable tbdatacount = new DataTable("tbdatacount");
                        string uresult = "N"; string cresult = "N"; string vresult = "N"; string hdresult = "N";

                        if (dtproc != null && dtproc.Rows.Count > 0 && dtproc.Columns.Contains("urinprocdoneby"))
                        {
                            foreach (DataRow row in dtproc.Rows)
                            {
                                object value = row["urinprocdoneby"];
                                if (value != null && value != DBNull.Value && !string.IsNullOrWhiteSpace(value.ToString()))
                                {
                                    uresult = "Y";
                                    break;
                                }
                            }
                        }

                        if (dtproc != null && dtproc.Rows.Count > 0 && dtproc.Columns.Contains("cathprocdoneby"))
                        {
                            foreach (DataRow row in dtproc.Rows)
                            {
                                object value = row["cathprocdoneby"];
                                if (value != null && value != DBNull.Value && !string.IsNullOrWhiteSpace(value.ToString()))
                                {
                                    cresult = "Y";
                                    break;
                                }
                            }
                        }
                        if (dtproc != null && dtproc.Rows.Count > 0 && dtproc.Columns.Contains("ventirocdoneby"))
                        {
                            foreach (DataRow row in dtproc.Rows)
                            {
                                object value = row["ventirocdoneby"];
                                if (value != null && value != DBNull.Value && !string.IsNullOrWhiteSpace(value.ToString()))
                                {
                                    vresult = "Y";
                                    break;
                                }
                            }
                        }
                        if (dtproc != null && dtproc.Rows.Count > 0 && dtproc.Columns.Contains("hdprocdoneby"))
                        {
                            foreach (DataRow row in dtproc.Rows)
                            {
                                object value = row["hdprocdoneby"];
                                if (value != null && value != DBNull.Value && !string.IsNullOrWhiteSpace(value.ToString()))
                                {
                                    hdresult = "Y";
                                    break;
                                }
                            }
                        }

                        tbdatacount.Columns.Add("Urinary");
                        tbdatacount.Columns.Add("Central");
                        tbdatacount.Columns.Add("Ventilator");
                        tbdatacount.Columns.Add("Hdialzer");
                        tbdatacount.Rows.Add();
                        tbdatacount.Rows[0]["Urinary"] = uresult;
                        tbdatacount.Rows[0]["Central"] = cresult;
                        tbdatacount.Rows[0]["Ventilator"] = vresult;
                        tbdatacount.Rows[0]["Hdialzer"] = hdresult;


                        dsFinalForPrint.Tables.Add(tbdatacount);
                    }
                }

                return dsFinalForPrint;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetChemoAntibioticData(string strIPNo, string strTblType, string ReportType = "", string strtodt = "")
        {
            DataSet dsTreatmentSheet = new DataSet();
            ICUClient icuClient = new ICUClient();
            GeneralFunction gen = new GeneralFunction();

            DataSet dsPatInfoRaw = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");
            DataTable dtPatInfo = new DataTable("PatInfo");

            dtPatInfo.Columns.AddRange(new DataColumn[]
            {
                new DataColumn("IPNO"), new DataColumn("MRNO"), new DataColumn("ADMNDATE"),
                new DataColumn("PATNAME"), new DataColumn("ADMNTIME"), new DataColumn("Gender"),
                new DataColumn("PATAGE"), new DataColumn("CONSDOCT"), new DataColumn("SALUNAME"),
                new DataColumn("CURRBEDNO"), new DataColumn("WARDNM"), new DataColumn("NURSTNM")
            });

            if (dsPatInfoRaw.Tables.Count > 0 && dsPatInfoRaw.Tables[0].Rows.Count > 0)
            {
                DataRow row = dsPatInfoRaw.Tables[0].Rows[0];
                DataRow newRow = dtPatInfo.NewRow();
                newRow["IPNO"] = row["IPNO"];
                newRow["MRNO"] = row["MRNO"];
                newRow["ADMNDATE"] = GeneralFunction.GetDate(row["ADMNDATE"].ToString());
                newRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(row["ADMNTIME"].ToString());
                newRow["PATNAME"] = row["PATNAME"];
                //newRow["ADMNTIME"] = row["ADMNTIME"];
                newRow["Gender"] = row["Gender"];
                newRow["PATAGE"] = row["PATAGE"];
                newRow["CONSDOCT"] = row["CONSDOCT"];
                newRow["SALUNAME"] = row["SALUNAME"];
                newRow["CURRBEDNO"] = row["CURRBEDNO"];
                newRow["WARDNM"] = row["WARDNM"];
                newRow["NURSTNM"] = row["NURSTNM"];
                dtPatInfo.Rows.Add(newRow);
            }
            dsTreatmentSheet.Tables.Add(dtPatInfo);

            DataTable dtHeader = GeneralFunction.getHeaderFooter("Protocol  Administration Summary", "", "", "");
            if (dtHeader.Rows.Count > 0 && dtHeader.Columns.Contains("PrintDateTime"))
                dtHeader.Rows[0]["PrintDateTime"] = GeneralFunction.ConvertDateWithTimeTo12Hour(dtHeader.Rows[0]["PrintDateTime"].ToString());
            dtHeader.TableName = "HeaderFooter";
            dsTreatmentSheet.Tables.Add(dtHeader);



            DataTable dtPatientDetails = new DataTable("PatientDetails");
            try
            {
                string xmlData = icuClient.GetAdmisnisteredMedication(strIPNo, "CO");
                if (!string.IsNullOrEmpty(xmlData))
                {
                    DataSet dsLoad = new DataSet();
                    dsLoad.ReadXml(new XmlTextReader(new StringReader(xmlData)));

                    if (dsLoad.Tables.Contains("TREATMNTHEAD") && dsLoad.Tables["TREATMNTHEAD"].Rows.Count > 0)
                    {
                        dtPatientDetails = dsLoad.Tables["TREATMNTHEAD"].Copy();
                        dtPatientDetails.TableName = "PatientDetails";

                        string[] removeCols = { "STATUS", "VERIFIEDBY", "VERIFIEDON", "VERIFIEDAT" };
                        foreach (var colName in removeCols)
                            if (dtPatientDetails.Columns.Contains(colName))
                                dtPatientDetails.Columns.Remove(colName);

                        if (dtPatientDetails.Columns.Contains("CREATEDON"))
                        {
                            foreach (DataRow row in dtPatientDetails.Rows)
                                row["CREATEDON"] = GeneralFunction.GetDate(row["CREATEDON"].ToString());
                        }

                        if (dtPatientDetails.Columns.Contains("TRANDATE"))
                            dtPatientDetails.Rows[0]["TRANDATE"] = GeneralFunction.GetDate(dtPatientDetails.Rows[0]["TRANDATE"].ToString().Trim());

                        if (!dtPatientDetails.Columns.Contains("TODATE")) dtPatientDetails.Columns.Add("TODATE");
                        if (!dtPatientDetails.Columns.Contains("ReportType")) dtPatientDetails.Columns.Add("ReportType");

                        dtPatientDetails.Rows[0]["TODATE"] = strtodt;
                        dtPatientDetails.Rows[0]["ReportType"] = ReportType;

                        dsTreatmentSheet.Tables.Add(dtPatientDetails);
                    }
                }
            }
            catch
            {

            }
            DataTable dtChemoAntibiotic = new DataTable("ChemoAntibioticA");
            dtChemoAntibiotic = AddMedicinalColumntoTable(dtChemoAntibiotic);
            dtChemoAntibiotic = AddChemoAntibioticColumns(dtChemoAntibiotic);

            try
            {
                string xmlData = icuClient.GetAdmisnisteredMedication(strIPNo, "CO");
                if (!string.IsNullOrEmpty(xmlData))
                {
                    DataSet dsLoad = new DataSet();
                    dsLoad.ReadXml(new XmlTextReader(new StringReader(xmlData)));

                    string tableName = dsLoad.Tables.Contains("TRETMEDICINE") ? "TRETMEDICINE" :
                                       dsLoad.Tables.Contains("Table") ? "Table" : null;

                    if (!string.IsNullOrEmpty(tableName) && dsLoad.Tables[tableName].Rows.Count > 0)
                    {
                        DataTable dtLoaded = dsLoad.Tables[tableName].Copy();
                        foreach (DataRow row in dtLoaded.Rows)
                        {
                            // Process UID1
                            string uid1 = row["UID1"].ToString();
                            if (uid1.Contains(","))
                            {
                                int commaIndex = uid1.IndexOf(',');
                                string firstPart = uid1.Substring(0, commaIndex);
                                string secondPart = uid1.Substring(commaIndex + 1);

                                row["UID1"] = string.Format("{0}, Checked by : {1}", firstPart, secondPart);
                            }

                            // Process UID2 (if it exists and has similar format)
                            if (dtLoaded.Columns.Contains("UID2"))
                            {
                                string uid2 = row["UID2"].ToString();
                                if (!string.IsNullOrEmpty(uid2) && uid2.Contains(","))
                                {
                                    int commaIndex2 = uid2.IndexOf(',');
                                    string firstPart2 = uid2.Substring(0, commaIndex2);
                                    string secondPart2 = uid2.Substring(commaIndex2 + 1);

                                    row["UID2"] = string.Format("{0}, Checked by : {1}", firstPart2, secondPart2);
                                }
                            }

                            DataRow newRow = dtChemoAntibiotic.NewRow();
                            foreach (DataColumn col in dtLoaded.Columns)
                                if (dtChemoAntibiotic.Columns.Contains(col.ColumnName))
                                    newRow[col.ColumnName] = row[col.ColumnName];
                            dtChemoAntibiotic.Rows.Add(newRow);
                        }

                        if (!dtChemoAntibiotic.Columns.Contains("Remarks"))
                            dtChemoAntibiotic.Columns.Add("Remarks");

                        DataTable dtTable1 = dsLoad.Tables.Contains("Table1") ? dsLoad.Tables["Table1"] : null;
                        DataTable dtTable = dsLoad.Tables.Contains("Table") ? dsLoad.Tables["Table"] : null;

                        if (dtTable1 != null && dtTable != null)
                        {

                            var remarksLookup = dtTable1.AsEnumerable()
                                .Where(r => r["TYPECODE"] != null && r["TYPECODE"].ToString().Trim().Equals("CO", StringComparison.OrdinalIgnoreCase))
                                .ToDictionary(
                                    r => r["DRUGCODE"].ToString().Trim() + "_" + r["SEQNO"].ToString().Trim(),
                                    r => r.Table.Columns.Contains("Remarks") ? r["Remarks"].ToString().Trim()
                                         : (r.Table.Columns.Contains("PLANTIME") ? r["PLANTIME"].ToString().Trim() : "")
                                );

                            foreach (DataRow row in dtChemoAntibiotic.Rows)
                            {
                                string code = row.Table.Columns.Contains("CODE1")
                                                ? row["CODE1"].ToString().Trim()
                                                : (row.Table.Columns.Contains("CODE")
                                                    ? row["CODE"].ToString().Trim()
                                                    : "");

                                string seqno = row["SEQNO"] != null ? row["SEQNO"].ToString().Trim() : "";
                                string key = code + "_" + seqno;

                                if (remarksLookup.ContainsKey(key))
                                    row["Remarks"] = remarksLookup[key];
                            }
                        }

                    }
                }
            }
            catch
            {

            }
            foreach (var colName in new[] { "D1", "D2" })
            {
                if (dtChemoAntibiotic.Columns.Contains(colName))
                {
                    foreach (DataRow row in dtChemoAntibiotic.Rows)
                    {
                        if (!string.IsNullOrEmpty(row[colName].ToString()))
                            row[colName] = GeneralFunction.GetDate(row[colName].ToString().Trim());
                    }
                }
            }
            CommonServiceClient SecUser = new CommonServiceClient();
            var userLst = SecUser.GetUserList().ToList();
            foreach (DataRow row in dtChemoAntibiotic.Rows)
            {
                if (dtChemoAntibiotic.Columns.Contains("CHMCOMPLBY") && !string.IsNullOrEmpty(row["CHMCOMPLBY"].ToString().Trim()))
                {
                    string uid = row["CHMCOMPLBY"].ToString().Trim();
                    string name = GeneralFunction.GetListValue(userLst, uid);
                    row["CHMCOMPLBY"] = name + " (" + uid + ")";
                }
                if (dtChemoAntibiotic.Columns.Contains("CHMCOMPLON") && !string.IsNullOrEmpty(row["CHMCOMPLON"].ToString()))
                    row["CHMCOMPLON"] = GeneralFunction.GetDate(row["CHMCOMPLON"].ToString().Trim());
                if (dtChemoAntibiotic.Columns.Contains("CHMCOMPLAT") && !string.IsNullOrEmpty(row["CHMCOMPLAT"].ToString()))
                    row["CHMCOMPLAT"] = GeneralFunction.ConvertTo12HourFormat(row["CHMCOMPLAT"].ToString().Trim());
            }

            if (dtChemoAntibiotic.Columns.Contains("CHEMTREATCOMPLYN"))
            {
                foreach (DataRow row in dtChemoAntibiotic.Rows)
                {
                    if (row["CHEMTREATCOMPLYN"] != null)
                    {
                        string val = row["CHEMTREATCOMPLYN"].ToString().Trim().ToUpper();
                        if (val == "Y")
                            row["CHEMTREATCOMPLYN"] = "Yes";
                        else if (val == "N")
                            row["CHEMTREATCOMPLYN"] = "No";
                        else
                            row["CHEMTREATCOMPLYN"] = "";
                    }
                }
            }

            dsTreatmentSheet.Tables.Add(dtChemoAntibiotic);

            return dsTreatmentSheet;
        }

        public DataSet RetriveTSAdminiData(string IPNo, string TranDate, string RecordType, string ReportType)
        {
            DataSet load = new DataSet();
            ICUClient icuclnt = new ICUClient();
            string TranFormatedDate = string.Empty;
            //CommonServiceClient comclient = new CommonServiceClient();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(IPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            DateTime todate = DateTime.ParseExact(TranDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            todate = todate.AddDays(1);
            string strtodt = todate.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);

            DataSet dsTreatmentSheet = new DataSet();
            DataTable dtMedication = new DataTable("Medication");
            DataTable dtAntibiotic = new DataTable("Antibiotic");
            DataTable dtChemoMedication = new DataTable("ChemoMedication");
            DataTable dtChemoAntibiotic = new DataTable("ChemoAntibiotic");
            DataTable dtSTATOrderDiln = new DataTable("STATOrderDiln");
            DataTable dtSTATOrderMedicn = new DataTable("STATOrderMedicn");
            DataTable dtIVFluid = new DataTable("IVFluid");
            DataTable dtBloodProduct = new DataTable("BloodProduct");
            DataTable dtINfusion = new DataTable("Infusion");
            DataTable dtPatientDetails = new DataTable("PatientDetails");
            DataTable dtInvestigation = new DataTable("TreatmentsheetTest");
            DataTable dtRfDoctor = new DataTable("RefDoctor");
            DataTable dtAdminRemark = new DataTable("AdminRemark");
            DataTable HData = new DataTable();

            string NScode = HttpContext.Current.Session["NSCODE"].ToString();


            if (TranDate != string.Empty)
            {
                TranFormatedDate = string.Format("{0}", GeneralFunction.GetDateInSpecifiedFormat(TranDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD));
            }

            load.ReadXml(new XmlTextReader(new StringReader(icuclnt.GetTSAdminAndPlanList(IPNo, TranFormatedDate, "A", "", NScode, ""))));

            if (load.Tables.Count > 0)
            {
                if (load != null && load.Tables.Contains("TRETMEDICINE"))
                {
                    if (load.Tables["TRETMEDICINE"].Rows.Count > 0)
                    {
                        load.Tables["TRETMEDICINE"].Columns.Add("ADMINISTRATION");
                        load.Tables["TRETMEDICINE"].Columns.Add("ADMINDATE");
                        load.Tables["TRETMEDICINE"].Columns.Add("ADMINTIME");
                        load.Tables["TRETMEDICINE"].Columns.Add("ADMINUSERID");
                        for (int i = 0; i < load.Tables["TRETMEDICINE"].Rows.Count; i++)
                        {
                            var sb = new System.Text.StringBuilder();

                            for (int col = 1; col < 25; col++)
                            {
                                string colnum = col.ToString();
                                if (load.Tables["TRETMEDICINE"].Rows[i]["D" + colnum].ToString().Trim() != string.Empty)
                                {
                                    sb.Append(string.Format("{0}  {1}  {2} ", GeneralFunction.GetDate(load.Tables["TRETMEDICINE"].Rows[i]["D" + colnum].ToString().Trim()),
                                       "&ensp;" + load.Tables["TRETMEDICINE"].Rows[i]["T" + colnum].ToString().Trim(),
                                       "&ensp;" + GeneralFunction.GetFstNameUserId(load.Tables["TRETMEDICINE"].Rows[i]["UID" + colnum].ToString().Trim())));
                                    sb.Append('-');
                                }
                            }
                            var comp = load.Tables["TRETMEDICINE"].Rows[i]["ALERTYN"];
                            var tblType = load.Tables["TRETMEDICINE"].Rows[i]["TBLTYPE"].ToString().Trim();
                            load.Tables["TRETMEDICINE"].Rows[i]["ADMINISTRATION"] = sb.ToString() != string.Empty ? sb.ToString().Substring(0, sb.ToString().Length - 1) : string.Empty;
                            var abs = sb;
                            string[] arryinyn = comp.ToString().Split('-');
                            string[] arry = abs.ToString().Split('-');
                            var sbnew = new System.Text.StringBuilder();

                            for (int s = 0; s <= arry.Length - 1; s++)
                            {
                                for (int q = 0; q < 1; q++)
                                {
                                    if (arry[s] != "")
                                    {
                                        string line = arry[s];

                                        if (tblType == "CO")
                                        {
                                            if (s % 2 == 0)
                                            {
                                                sbnew.Append("Start Date/Time:-<br>");
                                            }
                                            else
                                            {
                                                sbnew.Append("<br>End Date/Time:-<br>");
                                            }
                                        }
                                        if (arryinyn[q].Contains('Y'))
                                        {
                                            int posSystem = line.IndexOf("System (SYSTEM)");
                                            if (posSystem > -1)
                                            {
                                                posSystem += "System (SYSTEM)".Length;
                                                line = line.Insert(posSystem, " /");
                                            }
                                        }
                                        //if (line.Contains(',') || arryinyn[q].Contains('Y'))
                                        //{
                                        //    var pos = line.IndexOf(',');
                                        //    if (pos > -1)
                                        //    {
                                        //        var ab1 = line.Substring(0, pos + 1);
                                        //        var endpos = line.Substring(pos + 1);
                                        //        var cd = ab1 + "<font color='red'>" + endpos + "</font>";
                                        //        sbnew.Append(cd);
                                        //    }
                                        //    else
                                        //    {
                                        //        sbnew.Append("<font color='red'>" + line + "</font>");
                                        //    }
                                        //}
                                        //else
                                        //{
                                        sbnew.Append(line);
                                        //}
                                        //sbnew.Append("<br>");
                                    }
                                }
                            }
                            load.Tables["TRETMEDICINE"].Rows[i]["ADMINISTRATION"] = sbnew;
                        }
                    }

                    for (int col = 1; col < 25; col++)
                    {
                        string colnum = col.ToString();
                        load.Tables["TRETMEDICINE"].Columns.Remove("D" + colnum);
                        load.Tables["TRETMEDICINE"].Columns.Remove("T" + colnum);
                        load.Tables["TRETMEDICINE"].Columns.Remove("UID" + colnum);
                        load.Tables["TRETMEDICINE"].Columns.Remove("CT" + colnum);
                        load.Tables["TRETMEDICINE"].Columns.Remove("CD" + colnum);
                    }
                    load.Tables["TRETMEDICINE"].Columns.Remove("TRANNO");
                    load.Tables["TRETMEDICINE"].Columns.Remove("IPNO");
                    load.Tables["TRETMEDICINE"].Columns.Remove("TRANDATE");

                    /*-------------Medication-----------------------------------------------------------------------------*/
                    bool resultMD = load.Tables["TRETMEDICINE"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "MD");
                    if (resultMD)
                    {
                        dtMedication = load.Tables["TRETMEDICINE"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "MD").CopyToDataTable();
                        dtMedication.TableName = "Medication";
                    }
                    if (dtMedication.Rows.Count > 0)
                    {
                        dsTreatmentSheet.Tables.Add(dtMedication);
                    }
                    else
                    {
                        dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtMedication));
                    }

                    /*-------------Antibiotic-----------------------------------------------------------------------------*/

                    bool resultAB = load.Tables["TRETMEDICINE"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "AB");
                    if (resultAB)
                    {
                        dtAntibiotic = load.Tables["TRETMEDICINE"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "AB").CopyToDataTable();
                        dtAntibiotic.TableName = "Antibiotic";
                    }

                    if (dtAntibiotic.Rows.Count > 0)
                    {
                        dsTreatmentSheet.Tables.Add(dtAntibiotic);
                    }
                    else
                    {
                        dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtAntibiotic));
                    }
                    /*-------------ChemoMedication-----------------------------------------------------------------------------*/
                    bool resultCM = load.Tables["TRETMEDICINE"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "CM");
                    if (resultCM)
                    {
                        dtChemoMedication = load.Tables["TRETMEDICINE"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "CM").CopyToDataTable();
                        dtChemoMedication.TableName = "ChemoMedication";
                    }
                    if (dtChemoMedication.Rows.Count > 0)
                    {
                        dsTreatmentSheet.Tables.Add(dtChemoMedication);
                    }
                    else
                    {
                        dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtChemoMedication));
                    }

                    /*-------------ChemoAntibiotic-----------------------------------------------------------------------------*/

                    bool resultCO = load.Tables["TRETMEDICINE"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "CO");
                    if (resultCO)
                    {
                        dtChemoAntibiotic = load.Tables["TRETMEDICINE"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "CO").CopyToDataTable();
                        dtChemoAntibiotic.TableName = "ChemoAntibiotic";

                        if (!dtChemoAntibiotic.Columns.Contains("DelayRemark"))
                            dtChemoAntibiotic.Columns.Add("DelayRemark");
                        if (load.Tables.Contains("ADMINREMARK") && load.Tables["ADMINREMARK"].Rows.Count > 0)
                        {
                            var dtAdminRemarks = load.Tables["ADMINREMARK"];
                            var coRemarks = dtAdminRemarks.AsEnumerable()
                                              .Where(r => r.Field<string>("TYPECODE") == "CO");

                            foreach (DataRow chemoRow in dtChemoAntibiotic.Rows)
                            {
                                // Map remark based on DRUGNAME (adjust key if needed)
                                var remark = coRemarks
                                             .Where(r => r.Field<string>("SEQNO") == chemoRow.Field<string>("SEQNO"))
                                             .Select(r => r.Field<string>("REMARKS"))
                                             .FirstOrDefault();

                                chemoRow["DelayRemark"] = remark ?? "";
                            }

                            // Remove CO-type rows from ADMINREMARK before adding to dataset
                            for (int i = dtAdminRemarks.Rows.Count - 1; i >= 0; i--)
                            {
                                if (dtAdminRemarks.Rows[i]["TYPECODE"].ToString() == "CO")
                                    dtAdminRemarks.Rows.RemoveAt(i);
                            }
                        }
                    }

                    if (dtChemoAntibiotic == null || dtChemoAntibiotic.Rows.Count == 0)
                    {

                        dtChemoAntibiotic = AddMedicinalColumntoTable(dtChemoAntibiotic);
                        DataRow dr = dtChemoAntibiotic.NewRow();
                        dr["DelayRemark"] = "";
                        dr["ADMINISTRATION"] = "";
                        dtChemoAntibiotic.Rows.Add(dr);
                    }
                    dsTreatmentSheet.Tables.Add(dtChemoAntibiotic);

                    /*-------------Stat order dilution-----------------------------------------------------------------------------*/


                    bool resultSO = load.Tables["TRETMEDICINE"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "SO");
                    if (resultSO)
                    {
                        dtSTATOrderDiln = load.Tables["TRETMEDICINE"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "SO").CopyToDataTable();
                        dtSTATOrderDiln.TableName = "STATOrderDiln";
                    }

                    if (dtSTATOrderDiln.Rows.Count > 0)
                    {
                        dsTreatmentSheet.Tables.Add(dtSTATOrderDiln);
                    }
                    else
                    {
                        dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtSTATOrderDiln));
                    }

                    /*-------------Stat order Medication-----------------------------------------------------------------------------*/

                    bool resultSM = load.Tables["TRETMEDICINE"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "SM");
                    if (resultSM)
                    {
                        dtSTATOrderMedicn = load.Tables["TRETMEDICINE"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "SM").CopyToDataTable();
                        dtSTATOrderMedicn.TableName = "STATOrderMedicn";
                    }

                    if (dtSTATOrderMedicn.Rows.Count > 0)
                    {
                        dsTreatmentSheet.Tables.Add(dtSTATOrderMedicn);
                    }
                    else
                    {
                        dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtSTATOrderMedicn));
                    }

                }
                else
                {
                    dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtMedication));
                    dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtAntibiotic));
                    dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtSTATOrderDiln));
                    dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtSTATOrderMedicn));
                    dsTreatmentSheet.Tables.Add(AddMedicinalColumntoTable(dtChemoAntibiotic));
                }
                DataTable dtTREATIVBP = new DataTable();
                dtTREATIVBP.TableName = "TREATIVBP";
                if (load.Tables.Contains("TREATBP"))
                {
                    dtTREATIVBP.Merge(load.Tables["TREATBP"]);
                }
                if (load.Tables.Contains("TREATIV"))
                {
                    dtTREATIVBP.Merge(load.Tables["TREATIV"]);
                }

                load.Tables.Add(dtTREATIVBP);

                if (load.Tables.Contains("TREATIVBP"))
                {
                    if (load.Tables["TREATIVBP"].Rows.Count > 0)
                    {
                        load.Tables["TREATIVBP"].Columns.Add("IVBPStartActivity");
                        load.Tables["TREATIVBP"].Columns.Add("IVBPStartDate");
                        load.Tables["TREATIVBP"].Columns.Add("IVBPStartTime");
                        load.Tables["TREATIVBP"].Columns.Add("IVBPStartUserID");
                        load.Tables["TREATIVBP"].Columns.Add("IVBPEndActivity");
                        load.Tables["TREATIVBP"].Columns.Add("IVBPEndDate");
                        load.Tables["TREATIVBP"].Columns.Add("IVBPEndTime");
                        load.Tables["TREATIVBP"].Columns.Add("IVBPEndUserID");
                        for (int i = 0; i < load.Tables["TREATIVBP"].Rows.Count; i++)
                        {
                            var sb1 = new System.Text.StringBuilder();
                            var sb2 = new System.Text.StringBuilder();
                            for (int col = 1; col <= 12; col++)
                            {
                                string colnum = col.ToString();
                                if (load.Tables["TREATIVBP"].Columns.Contains("ST" + colnum))
                                {

                                    if (load.Tables["TREATIVBP"].Rows[i]["ST" + colnum].ToString().Trim() != string.Empty)
                                    {
                                        sb1.Append(string.Format("{0}  {1}  {2} ", GeneralFunction.GetDate(load.Tables["TREATIVBP"].Rows[i]["SD" + colnum].ToString().Trim()),
                                            "&ensp;" + load.Tables["TREATIVBP"].Rows[i]["ST" + colnum].ToString().Trim(),
                                            "&ensp;" + GeneralFunction.GetFstNameUserId(load.Tables["TREATIVBP"].Rows[i]["SUID" + colnum].ToString().Trim())));
                                        sb1.Append('-');
                                    }
                                    if (load.Tables["TREATIVBP"].Rows[i]["ET" + colnum].ToString().Trim() != string.Empty)
                                    {
                                        sb2.Append(string.Format("{0}  {1}  {2} ", GeneralFunction.GetDate(load.Tables["TREATIVBP"].Rows[i]["ED" + colnum].ToString().Trim()),
                                            "&ensp;" + load.Tables["TREATIVBP"].Rows[i]["ET" + colnum].ToString().Trim(),
                                            "&ensp;" + GeneralFunction.GetFstNameUserId(load.Tables["TREATIVBP"].Rows[i]["EUID" + colnum].ToString().Trim())));
                                        sb2.Append('-');
                                    }
                                }
                            }
                            load.Tables["TREATIVBP"].Rows[i]["IVBPStartActivity"] = sb1.ToString() != string.Empty ? sb1.ToString().Substring(0, sb1.ToString().Length - 1) : string.Empty;
                            var comp = load.Tables["TREATIVBP"].Rows[i]["ALERTYN"];
                            if (!String.IsNullOrEmpty(load.Tables["TREATIVBP"].Rows[i]["IVBPStartActivity"].ToString().Trim()))
                            {
                                var abs = sb1;
                                string[] arryinyn = comp.ToString().Split('-');
                                string[] arryinf1 = abs.ToString().Split('-');
                                var cdf = "";
                                var sbinf1 = new System.Text.StringBuilder();
                                for (int s = 0; s <= arryinf1.Length - 1; s++)
                                {
                                    for (int q = 0; q < 1; q++)
                                    {
                                        if (arryinf1[s] != "")
                                        {
                                            if (arryinf1[s].Contains(',') || arryinyn[q].Contains('Y'))  //alert color
                                            {
                                                var pos = arryinf1[s].ToString().IndexOf(',');
                                                var ab1 = arryinf1[s].ToString().Substring(0, pos + 1);
                                                var endpos = arryinf1[s].ToString().Substring(pos + 1);
                                                //var cd = ab1 + "<font color='red'>" + endpos + "</font>";
                                                var cd = ab1 + "" + endpos;
                                                sbinf1.Append("<p>");
                                                sbinf1.Append(cd);
                                            }
                                            else
                                            {
                                                sbinf1.Append("<p>");
                                                sbinf1.Append(arryinf1[s]);
                                            }

                                        }

                                    }
                                }
                                load.Tables["TREATIVBP"].Rows[i]["IVBPStartActivity"] = sbinf1;
                            }
                            load.Tables["TREATIVBP"].Rows[i]["IVBPEndActivity"] = sb2.ToString() != string.Empty ? sb2.ToString().Substring(0, sb2.ToString().Length - 1) : string.Empty;
                            if (load.Tables["TREATIVBP"].Rows[i]["IVBPEndActivity"].ToString().Trim() != "")
                            {
                                var inf2 = sb2;
                                string[] arryinyn = comp.ToString().Split('-');
                                string[] arryinf2 = inf2.ToString().Split('-');
                                //var inf2 = "";
                                var sbinf2 = new System.Text.StringBuilder();
                                for (int s = 0; s <= arryinf2.Length - 1; s++)
                                {
                                    for (int q = 0; q < 1; q++)
                                    {
                                        if (arryinf2[s] != "")
                                        {
                                            if (arryinf2[s].Contains(',') || arryinyn[q].Contains('Y')) //alert color
                                            {
                                                var pos = arryinf2[s].ToString().IndexOf(',');
                                                var ab1 = arryinf2[s].ToString().Substring(0, pos + 1);
                                                var endpos = arryinf2[s].ToString().Substring(pos + 1);
                                                //var cd = ab1 + "<font color='red'>" + endpos + "</font>";
                                                var cd = ab1 + "" + endpos;
                                                sbinf2.Append("<p>");
                                                sbinf2.Append(cd);
                                            }
                                            else
                                            {
                                                sbinf2.Append("<p>");
                                                sbinf2.Append(arryinf2[s]);
                                            }

                                        }

                                    }
                                }
                                load.Tables["TREATIVBP"].Rows[i]["IVBPEndActivity"] = sbinf2;

                            }

                        }

                        load.Tables["TREATIVBP"].Columns.Remove("TRANNO");
                        load.Tables["TREATIVBP"].Columns.Remove("IPNO");
                        load.Tables["TREATIVBP"].Columns.Remove("TRANDATE");
                        load.Tables["TREATIVBP"].Columns.Remove("ET1");
                        load.Tables["TREATIVBP"].Columns.Remove("ED1");
                        load.Tables["TREATIVBP"].Columns.Remove("EUID1");
                        load.Tables["TREATIVBP"].Columns.Remove("SD1");
                        load.Tables["TREATIVBP"].Columns.Remove("ST1");
                        load.Tables["TREATIVBP"].Columns.Remove("SUID1");
                        load.Tables["TREATIVBP"].Columns.Remove("CREATEDON");
                        load.Tables["TREATIVBP"].Columns.Remove("ORDERBY");
                        load.Tables["TREATIVBP"].Columns.Remove("CREATEDAT");


                        bool resultIV = load.Tables["TREATIVBP"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "IV");
                        if (resultIV)
                        {
                            dtIVFluid = load.Tables["TREATIVBP"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "IV").CopyToDataTable();
                            dtIVFluid.TableName = "IVFluid";
                        }

                        if (dtIVFluid.Rows.Count > 0)
                        {
                            dsTreatmentSheet.Tables.Add(dtIVFluid);
                        }
                        else
                        {
                            dsTreatmentSheet.Tables.Add(AddIVBPColumnToTable(dtIVFluid));
                        }

                        bool resultBP = load.Tables["TREATIVBP"].AsEnumerable().Any(r => r.Field<string>("TBLTYPE") == "BP");
                        if (resultBP)
                        {
                            dtBloodProduct = load.Tables["TREATIVBP"].AsEnumerable().Where(r => r.Field<string>("TBLTYPE") == "BP").CopyToDataTable();
                            dtBloodProduct.TableName = "BloodProduct";
                        }
                        if (dtBloodProduct.Rows.Count > 0)
                        {
                            dsTreatmentSheet.Tables.Add(dtBloodProduct);
                        }
                        else
                        {
                            dsTreatmentSheet.Tables.Add(AddIVBPColumnToTable(dtBloodProduct));
                        }

                    }
                    else
                    {
                        dsTreatmentSheet.Tables.Add(AddIVBPColumnToTable(dtIVFluid));
                        dsTreatmentSheet.Tables.Add(AddIVBPColumnToTable(dtBloodProduct));
                    }
                }
                else
                {
                    dsTreatmentSheet.Tables.Add(AddIVBPColumnToTable(dtIVFluid));
                    dsTreatmentSheet.Tables.Add(AddIVBPColumnToTable(dtBloodProduct));
                }


                if (load.Tables.Contains("TREATINFUSION"))
                {
                    load.Tables["TREATINFUSION"].Columns.Add("INFStartActivity");
                    load.Tables["TREATINFUSION"].Columns.Add("INFStartDate");
                    load.Tables["TREATINFUSION"].Columns.Add("INFStarttime");
                    load.Tables["TREATINFUSION"].Columns.Add("INFStartUserID");
                    load.Tables["TREATINFUSION"].Columns.Add("INFEndActivity");
                    load.Tables["TREATINFUSION"].Columns.Add("INFEndDate");
                    load.Tables["TREATINFUSION"].Columns.Add("INFEndTime");
                    load.Tables["TREATINFUSION"].Columns.Add("INFEndUserID");
                    if (load.Tables["TREATINFUSION"].Rows.Count > 0)
                    {
                        for (int i = 0; i < load.Tables["TREATINFUSION"].Rows.Count; i++)
                        {
                            var sb1 = new System.Text.StringBuilder();
                            var sb2 = new System.Text.StringBuilder();
                            for (int col = 1; col <= 12; col++)
                            {
                                string colnum = col.ToString();
                                if (load.Tables["TREATINFUSION"].Rows[i]["ST" + colnum].ToString().Trim() != string.Empty)
                                {
                                    sb1.Append(string.Format("{0} {1} {2} ", GeneralFunction.GetDate(load.Tables["TREATINFUSION"].Rows[i]["SD" + colnum].ToString().Trim()),
                                        "&ensp;" + load.Tables["TREATINFUSION"].Rows[i]["ST" + colnum].ToString().Trim(),
                                        "&ensp;" + GeneralFunction.GetFstNameUserId(load.Tables["TREATINFUSION"].Rows[i]["SUID" + colnum].ToString().Trim())));
                                    sb1.Append('-');
                                }
                                if (load.Tables["TREATINFUSION"].Rows[i]["ET" + colnum].ToString().Trim() != string.Empty)
                                {
                                    sb2.Append(string.Format("{0} {1} {2} ", GeneralFunction.GetDate(load.Tables["TREATINFUSION"].Rows[i]["ED" + colnum].ToString().Trim()),
                                        "&ensp;" + load.Tables["TREATINFUSION"].Rows[i]["ET" + colnum].ToString().Trim(),
                                        "&ensp;" + GeneralFunction.GetFstNameUserId(load.Tables["TREATINFUSION"].Rows[i]["EUID" + colnum].ToString().Trim())));
                                    sb2.Append('-');
                                }
                            }
                            load.Tables["TREATINFUSION"].Rows[i]["INFStartActivity"] = sb1.ToString() != string.Empty ? sb1.ToString().Substring(0, sb1.ToString().Length - 1) : string.Empty;
                            var comp = load.Tables["TREATINFUSION"].Rows[i]["ALERTYN"];
                            if (!String.IsNullOrEmpty(load.Tables["TREATINFUSION"].Rows[i]["INFStartActivity"].ToString().Trim()))
                            {
                                var abs = sb1;
                                string[] arryinf1 = abs.ToString().Split('-');
                                string[] arryinyn = comp.ToString().Split('-');
                                var cdf = "";
                                var sbinf1 = new System.Text.StringBuilder();
                                for (int s = 0; s <= arryinf1.Length - 1; s++)
                                {
                                    for (int q = 0; q < 1; q++)
                                    {
                                        if (arryinf1[s] != "")
                                        {
                                            if (arryinf1[s].Contains(',') || arryinyn[q].Contains('Y'))//alert color
                                            {
                                                var pos = arryinf1[s].ToString().IndexOf(',');
                                                var ab1 = arryinf1[s].ToString().Substring(0, pos + 1);
                                                var endpos = arryinf1[s].ToString().Substring(pos + 1);
                                                //var cd = ab1 + "<font color='red'>" + endpos + "</font>";
                                                var cd = ab1 + "" + endpos;
                                                sbinf1.Append("<p>");
                                                sbinf1.Append(cd);
                                            }
                                            else
                                            {
                                                sbinf1.Append("<p>");
                                                sbinf1.Append(arryinf1[s]);
                                            }

                                        }
                                    }

                                }
                                load.Tables["TREATINFUSION"].Rows[i]["INFStartActivity"] = sbinf1;
                            }

                            load.Tables["TREATINFUSION"].Rows[i]["INFEndActivity"] = sb2.ToString() != string.Empty ? sb2.ToString().Substring(0, sb2.ToString().Length - 1) : string.Empty;
                            if (load.Tables["TREATINFUSION"].Rows[i]["INFEndActivity"].ToString().Trim() != "")
                            {
                                var inf2 = sb2;
                                string[] arryinyn = comp.ToString().Split('-');
                                string[] arryinf2 = inf2.ToString().Split('-');
                                //var inf2 = "";
                                var sbinf2 = new System.Text.StringBuilder();
                                for (int s = 0; s <= arryinf2.Length - 1; s++)
                                {
                                    for (int q = 0; q < 1; q++)
                                    {
                                        if (arryinf2[s] != "")
                                        {
                                            if (arryinf2[s].Contains(',') || arryinyn[q].Contains('Y')) //alert color
                                            {
                                                var pos = arryinf2[s].ToString().IndexOf(',');
                                                var ab1 = arryinf2[s].ToString().Substring(0, pos + 1);
                                                var endpos = arryinf2[s].ToString().Substring(pos + 1);
                                                //var cd = ab1 + "<font color='red'>" + endpos + "</font>";
                                                var cd = ab1 + "" + endpos + "";
                                                sbinf2.Append("<p>");
                                                sbinf2.Append(cd);
                                            }
                                            else
                                            {
                                                sbinf2.Append("<p>");
                                                sbinf2.Append(arryinf2[s]);
                                            }
                                        }
                                    }
                                }
                                load.Tables["TREATINFUSION"].Rows[i]["INFEndActivity"] = sbinf2;
                            }
                        }

                        load.Tables["TREATINFUSION"].Columns.Remove("TRANNO");
                        load.Tables["TREATINFUSION"].Columns.Remove("IPNO");
                        load.Tables["TREATINFUSION"].Columns.Remove("ED1");
                        load.Tables["TREATINFUSION"].Columns.Remove("ET1");
                        load.Tables["TREATINFUSION"].Columns.Remove("EUID1");
                        load.Tables["TREATINFUSION"].Columns.Remove("SD1");
                        load.Tables["TREATINFUSION"].Columns.Remove("ST1");
                        load.Tables["TREATINFUSION"].Columns.Remove("SUID1");
                        //load.Tables["TREATINFUSION"].Columns.Remove("SUID1");
                        load.Tables["TREATINFUSION"].Columns.Remove("CREATEDON");
                        load.Tables["TREATINFUSION"].Columns.Remove("ORDERBY");
                        load.Tables["TREATINFUSION"].Columns.Remove("CREATEDAT");
                        dtINfusion = load.Tables["TREATINFUSION"].Copy();
                        dtINfusion.TableName = "Infusion";
                        dsTreatmentSheet.Tables.Add(dtINfusion);
                    }
                }

                else
                {
                    dsTreatmentSheet.Tables.Add(AddInfusionColumnToTable(dtINfusion));
                }


                if (load.Tables.Contains("TREATMNTHEAD"))
                {

                    load.Tables["TREATMNTHEAD"].Columns.Remove("STATUS");
                    load.Tables["TREATMNTHEAD"].Columns.Remove("VERIFIEDBY");
                    load.Tables["TREATMNTHEAD"].Columns.Remove("VERIFIEDON");
                    load.Tables["TREATMNTHEAD"].Columns.Remove("VERIFIEDAT");

                    for (int i = 0; i < load.Tables["TREATMNTHEAD"].Rows.Count; i++)
                    {
                        load.Tables["TREATMNTHEAD"].Rows[i]["CREATEDON"] = GeneralFunction.GetDate(load.Tables["TREATMNTHEAD"].Rows[i]["CREATEDON"].ToString());
                    }

                    dtPatientDetails = load.Tables["TREATMNTHEAD"].Copy();
                    dtPatientDetails.TableName = "PatientDetails";
                    dtPatientDetails.Rows[0]["TRANDATE"] = GeneralFunction.GetDate(dtPatientDetails.Rows[0]["TRANDATE"].ToString().Trim());
                    dtPatientDetails.Columns.Add("TODATE");
                    dtPatientDetails.Columns.Add("ReportType");
                    dtPatientDetails.Rows[0]["ReportType"] = ReportType;
                    dtPatientDetails.Rows[0]["TODATE"] = strtodt;

                    dsTreatmentSheet.Tables.Add(dtPatientDetails);
                }

                if (load.Tables.Contains("DOCTOR"))
                {
                    dtRfDoctor = load.Tables["DOCTOR"].Copy();
                    dtRfDoctor.TableName = "RefDoctor";
                    dtRfDoctor.Columns.Remove("TRANNO");
                    dsTreatmentSheet.Tables.Add(dtRfDoctor);
                }
                else
                {
                    dsTreatmentSheet.Tables.Add(AddReferralColumnToTable(dtRfDoctor));
                }

                if (load.Tables.Contains("ADMINREMARK"))
                {
                    for (int i = 0; i < load.Tables["ADMINREMARK"].Rows.Count; i++)
                    {
                        load.Tables["ADMINREMARK"].Rows[i]["AUTHUSERID"] = GeneralFunction.GetFstNameUserId(load.Tables["ADMINREMARK"].Rows[i]["AUTHUSERID"].ToString());
                        load.Tables["ADMINREMARK"].Rows[i]["CREATEDBY"] = GeneralFunction.GetFstNameUserId(load.Tables["ADMINREMARK"].Rows[i]["CREATEDBY"].ToString());
                    }
                    dsTreatmentSheet.Tables.Add(load.Tables["ADMINREMARK"].Copy());
                }
                else
                {
                    dtAdminRemark.TableName = "ADMINREMARK";
                    dtAdminRemark.Columns.Add("DRUGNAME");
                    dtAdminRemark.Columns.Add("PLANTIME");
                    dtAdminRemark.Columns.Add("TYPECODE");
                    dtAdminRemark.Columns.Add("REMARKS");
                    dtAdminRemark.Columns.Add("AUTHUSERID");
                    dtAdminRemark.Columns.Add("ADMINTIME");
                    dtAdminRemark.Columns.Add("CREATEDBY");
                    dsTreatmentSheet.Tables.Add(dtAdminRemark);
                }

                HData = GeneralFunction.getHeaderFooter("Medication Administration", "", "", "");
                if (HData.Rows.Count > 0 && HData.Columns.Contains("PrintDateTime"))
                {
                    HData.Rows[0]["PrintDateTime"] =
                        GeneralFunction.ConvertDateWithTimeTo12Hour(HData.Rows[0]["PrintDateTime"].ToString());
                }
                HData.TableName = "HeaderFooter";


                DataTable dtPatInfo = new DataTable();
                DataTable dt = new DataTable();

                dtPatInfo.TableName = "PatInfo";
                if (dsPatInfo.Tables.Count > 0)
                {
                    dt = dsPatInfo.Tables[0];

                    dtPatInfo.Columns.Add("IPNO");
                    dtPatInfo.Columns.Add("MRNO");
                    dtPatInfo.Columns.Add("ADMNDATE");
                    dtPatInfo.Columns.Add("PATNAME");
                    dtPatInfo.Columns.Add("ADMNTIME");
                    dtPatInfo.Columns.Add("Gender");
                    dtPatInfo.Columns.Add("PATAGE");
                    dtPatInfo.Columns.Add("CONSDOCT");
                    dtPatInfo.Columns.Add("SALUNAME");
                    dtPatInfo.Columns.Add("CURRBEDNO");
                    dtPatInfo.Columns.Add("WARDNM");
                    dtPatInfo.Columns.Add("NURSTNM");

                    DataRow patRow = dtPatInfo.NewRow();
                    patRow["IPNO"] = dt.Rows[0]["IPNO"].ToString();
                    patRow["MRNO"] = dt.Rows[0]["MRNO"].ToString();
                    patRow["ADMNDATE"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString());
                    patRow["PATNAME"] = dt.Rows[0]["PATNAME"].ToString();
                    //patRow["ADMNTIME"] = dt.Rows[0]["ADMNTIME"].ToString();
                    patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                    patRow["Gender"] = dt.Rows[0]["Gender"].ToString();
                    patRow["PATAGE"] = dt.Rows[0]["PATAGE"].ToString();
                    patRow["CONSDOCT"] = dt.Rows[0]["CONSDOCT"].ToString();
                    patRow["SALUNAME"] = dt.Rows[0]["SALUNAME"].ToString();
                    patRow["CURRBEDNO"] = dt.Rows[0]["CURRBEDNO"].ToString();
                    patRow["WARDNM"] = dt.Rows[0]["WARDNM"].ToString();
                    patRow["NURSTNM"] = dt.Rows[0]["NURSTNM"].ToString();
                    dtPatInfo.Rows.Add(patRow);
                }

                if (load.Tables.Contains("TEST"))
                {

                    dtInvestigation = load.Tables["TEST"].Copy();
                    dtInvestigation.TableName = "TreatmentsheetTest";
                    dtInvestigation.Columns.Remove("TRANNO");
                    dtInvestigation.Columns.Remove("TESTCODE");
                    dtInvestigation.Columns.Remove("TESTPRIORITY");

                    for (int t = 0; t < dtInvestigation.Rows.Count; t++)
                    {
                        if (dtInvestigation.Rows[t]["ORDERDATE"].ToString().Trim() != string.Empty)
                            dtInvestigation.Rows[t]["ORDERDATE"] = GeneralFunction.GetDate(dtInvestigation.Rows[t]["ORDERDATE"].ToString().Trim());
                    }

                    dsTreatmentSheet.Tables.Add(dtInvestigation);
                }
                else
                {
                    dsTreatmentSheet.Tables.Add(AddInvestigateColumnToTable(dtInvestigation));
                }
                dsTreatmentSheet.Tables.Add(HData);
                dsTreatmentSheet.Tables.Add(dtPatInfo);

            }
            //return dsTreatmentSheet;

            DataSet dsFiltered = new DataSet();

            // Copy mandatory tables
            string[] mandatoryTables = { "HeaderFooter", "PatientDetails", "PatInfo" };
            foreach (var tName in mandatoryTables)
            {
                if (dsTreatmentSheet.Tables.Contains(tName))
                    dsFiltered.Tables.Add(dsTreatmentSheet.Tables[tName].Copy());
            }

            // Determine tables to include based on report type
            string[] tablesToInclude = { "Medication", "Antibiotic","ChemoAntibiotic",
                             "STATOrderDiln", "STATOrderMedicn", "IVFluid", "BloodProduct",
                             "Infusion", "TreatmentsheetTest", "RefDoctor", "ADMINREMARK" };

            if (ReportType == "TS_ADMINISTRATION_REPORT" || ReportType == "TS_MEDREMARK_REPORT")
            {
                foreach (var tableName in tablesToInclude)
                {
                    if (dsTreatmentSheet.Tables.Contains(tableName))
                    {
                        DataTable dtCopy = dsTreatmentSheet.Tables[tableName].Copy();

                        // Adding dummy row if table is empty
                        if (dtCopy.Rows.Count == 0)
                        {
                            DataRow dummyRow = dtCopy.NewRow();
                            foreach (DataColumn col in dtCopy.Columns)
                            {
                                if (col.DataType == typeof(string)) dummyRow[col] = "";
                                else if (col.DataType == typeof(int)) dummyRow[col] = 0;
                                else if (col.DataType == typeof(DateTime)) dummyRow[col] = DateTime.MinValue;
                                else dummyRow[col] = DBNull.Value;
                            }
                            dtCopy.Rows.Add(dummyRow);
                        }

                        dsFiltered.Tables.Add(dtCopy);
                    }
                }
            }

            return dsFiltered;
        }


        public DataTable AddMedicinalColumntoTable(DataTable dt)
        {
            if (dt == null)
                dt = new DataTable();

            if (!dt.Columns.Contains("TYPE")) dt.Columns.Add("TYPE");
            if (!dt.Columns.Contains("CODE")) dt.Columns.Add("CODE");
            if (!dt.Columns.Contains("DRUGNAME")) dt.Columns.Add("DRUGNAME");
            if (!dt.Columns.Contains("DAYOFDRUG")) dt.Columns.Add("DAYOFDRUG");
            if (!dt.Columns.Contains("DOSE")) dt.Columns.Add("DOSE");
            if (!dt.Columns.Contains("ROUTE")) dt.Columns.Add("ROUTE");
            if (!dt.Columns.Contains("FREQ")) dt.Columns.Add("FREQ");
            if (!dt.Columns.Contains("REMARK")) dt.Columns.Add("REMARK");
            if (!dt.Columns.Contains("DILVOLUME")) dt.Columns.Add("DILVOLUME");
            if (!dt.Columns.Contains("ADMINDUR")) dt.Columns.Add("ADMINDUR");
            if (!dt.Columns.Contains("TBLTYPE")) dt.Columns.Add("TBLTYPE");
            if (!dt.Columns.Contains("RECTYPE")) dt.Columns.Add("RECTYPE");
            if (!dt.Columns.Contains("SEQNO")) dt.Columns.Add("SEQNO");
            if (!dt.Columns.Contains("ADMINISTRATION")) dt.Columns.Add("ADMINISTRATION");
            if (!dt.Columns.Contains("ALERTYN")) dt.Columns.Add("ALERTYN");
            if (!dt.Columns.Contains("DelayRemark")) dt.Columns.Add("DelayRemark");

            return dt;
        }

        public DataTable AddChemoAntibioticColumns(DataTable dt)
        {
            if (dt == null)
                dt = new DataTable();
            if (!dt.Columns.Contains("TYPE")) dt.Columns.Add("TYPE");
            if (!dt.Columns.Contains("DAYOFDRUG")) dt.Columns.Add("DAYOFDRUG");
            if (!dt.Columns.Contains("CODE")) dt.Columns.Add("CODE");
            if (!dt.Columns.Contains("DRUGNAME")) dt.Columns.Add("DRUGNAME");
            if (!dt.Columns.Contains("DOSE")) dt.Columns.Add("DOSE");
            if (!dt.Columns.Contains("ROUTE")) dt.Columns.Add("ROUTE");
            if (!dt.Columns.Contains("FREQ")) dt.Columns.Add("FREQ");
            if (!dt.Columns.Contains("REMARK")) dt.Columns.Add("REMARK");
            // Fixed administration columns
            if (!dt.Columns.Contains("D1")) dt.Columns.Add("D1");
            if (!dt.Columns.Contains("D2")) dt.Columns.Add("D2");
            if (!dt.Columns.Contains("T1")) dt.Columns.Add("T1");
            if (!dt.Columns.Contains("T2")) dt.Columns.Add("T2");
            if (!dt.Columns.Contains("UID1")) dt.Columns.Add("UID1");
            if (!dt.Columns.Contains("UID2")) dt.Columns.Add("UID2");
            // Basic chemo columns
            if (!dt.Columns.Contains("CHEMCOMPREMARK")) dt.Columns.Add("CHEMCOMPREMARK");
            if (!dt.Columns.Contains("CHEMTREATCOMPLYN")) dt.Columns.Add("CHEMTREATCOMPLYN");
            if (!dt.Columns.Contains("CHMCOMPLBY")) dt.Columns.Add("CHMCOMPLBY");
            if (!dt.Columns.Contains("CHMCOMPLON")) dt.Columns.Add("CHMCOMPLON");
            if (!dt.Columns.Contains("CHMCOMPLAT")) dt.Columns.Add("CHMCOMPLAT");
            return dt;
        }

        public DataTable AddIVBPColumnToTable(DataTable dt)
        {
            dt.Columns.Add("CODE");
            dt.Columns.Add("DRUGNAME");
            dt.Columns.Add("REMARK");
            dt.Columns.Add("TBLTYPE");
            dt.Columns.Add("RECTYPE");
            dt.Columns.Add("SEQNO");
            dt.Columns.Add("IVBPStartActivity");
            dt.Columns.Add("IVBPEndActivity");
            dt.Columns.Add("ALERTYN");
            dt.Columns.Add("DOSE");
            dt.Columns.Add("IVBPStartDate");
            dt.Columns.Add("IVBPStartTime");
            dt.Columns.Add("IVBPStartUserID");
            dt.Columns.Add("IVBPEndDate");
            dt.Columns.Add("IVBPEndTime");
            dt.Columns.Add("IVBPEndUserID");
            return dt;
        }

        public DataTable AddInfusionColumnToTable(DataTable dt)
        {
            dt.Columns.Add("INFUSION");
            dt.Columns.Add("InfusionRate");
            dt.Columns.Add("REMARK");
            dt.Columns.Add("TBLTYPE");
            dt.Columns.Add("RECTYPE");
            dt.Columns.Add("SEQNO");
            dt.Columns.Add("INFStartActivity");
            dt.Columns.Add("INFEndActivity");
            dt.Columns.Add("ALERTYN");
            return dt;
        }

        public DataTable AddReferralColumnToTable(DataTable dt)
        {
            dt.Columns.Add("DOCTCODE");
            dt.Columns.Add("REFERRALTYPE");
            dt.Columns.Add("DOCTNAME");
            dt.Columns.Add("SEQNO");
            dt.Columns.Add("DOSPNAME");
            return dt;
        }

        public DataTable AddInvestigateColumnToTable(DataTable dt)
        {
            dt.Columns.Add("ORDERDATE");
            dt.Columns.Add("ORDERTIME");
            dt.Columns.Add("ORDERBY");
            dt.Columns.Add("TESTNAME");
            dt.Columns.Add("SEQNO");
            return dt;
        }

        //added by vijeta on 21st july 2018
        public DataSet GetOrderTestList(string strIPNo)
        {
            ICUClient icuClient = new ICUClient();
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet ds = new DataSet();
            DataSet finalDsToSend = new DataSet();
            DataTable HData = new DataTable();
            DataTable dtPatInfo = new DataTable();
            DataTable dtOrderLst = new DataTable();

            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            if (dsPatInfo.Tables.Count > 0)
            {
                dtPatInfo.TableName = "PatInfo";
                dtPatInfo.Columns.Add("IPNO");
                dtPatInfo.Columns.Add("MRNO");
                dtPatInfo.Columns.Add("ADMNDATE");
                dtPatInfo.Columns.Add("PATNAME");
                dtPatInfo.Columns.Add("ADMNTIME");
                dtPatInfo.Columns.Add("Gender");
                dtPatInfo.Columns.Add("PATAGE");
                dtPatInfo.Columns.Add("CONSDOCT");
                dtPatInfo.Columns.Add("SALUNAME");
                dtPatInfo.Columns.Add("CURRBEDNO");
                dtPatInfo.Columns.Add("WARDNM");
                dtPatInfo.Columns.Add("NURSTNM");
                dtPatInfo.Columns.Add("DATE");
                dtPatInfo.Columns.Add("TIME");
                dtPatInfo.Columns.Add("CNAME");
                dtPatInfo.Columns.Add("TOMOROWDATE");
                DataRow patRow = dtPatInfo.NewRow();
                patRow["IPNO"] = dsPatInfo.Tables[0].Rows[0]["IPNO"].ToString();
                patRow["MRNO"] = dsPatInfo.Tables[0].Rows[0]["MRNO"].ToString();
                patRow["ADMNDATE"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString());
                patRow["PATNAME"] = dsPatInfo.Tables[0].Rows[0]["PATNAME"].ToString();
                //patRow["ADMNTIME"] = dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString();
                patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString());
                patRow["Gender"] = dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                patRow["PATAGE"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString();
                patRow["CONSDOCT"] = dsPatInfo.Tables[0].Rows[0]["CONSDOCT"].ToString();
                patRow["CURRBEDNO"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString();
                patRow["WARDNM"] = dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString();
                patRow["NURSTNM"] = dsPatInfo.Tables[0].Rows[0]["NURSTNM"].ToString();
                patRow["DATE"] = GeneralFunction.GetDate("");
                patRow["TIME"] = "";
                patRow["CNAME"] = "";
                patRow["TOMOROWDATE"] = "";
                dtPatInfo.Rows.Add(patRow);
            }

            HData = GeneralFunction.getHeaderFooter("ORDER TEST LIST", "", "", "");
            HData.TableName = "HeaderFooter";
            object[] obj = new object[1];


            string str = icuClient.GetOrderTestList(strIPNo);
            ds.ReadXml(new XmlTextReader(new StringReader(str)));
            if (ds == null)
            {
                obj[0] = "";
            }
            else
            {
                if (ds.Tables.Count > 0)
                {
                    //ds.Tables[0].TableName = "ORDERTESTLIST";
                    ds.Tables[0].Columns["OrderDate"].ColumnName = "ORDERDATE";
                    ds.Tables[0].Columns["OrderNo"].ColumnName = "ORDERNO";
                    ds.Tables[0].Columns["TestName"].ColumnName = "TESTNAME";
                    ds.Tables[0].Columns["CreatedBy"].ColumnName = "STAFFID";

                    var data = (from r in ds.Tables[0].AsEnumerable()
                                group r by r["ORDERNO"].ToString() into g
                                select new
                                {
                                    ORDERNO = g.Select(s => s["ORDERNO"].ToString()).FirstOrDefault(),
                                    ORDERDATE = GeneralFunction.GetDate(g.Select(s => s["ORDERDATE"].ToString()).FirstOrDefault()),
                                    ORDERTIME = g.Select(s => s["ORDERTIME"].ToString().Trim()).FirstOrDefault(),
                                    STAFFID = GeneralFunction.GetFstNameUserId(g.Select(s => s["STAFFID"].ToString()).FirstOrDefault().Trim()),
                                    CULTURE = string.Join(", ", g.OrderBy(s => s["ORDERDATE"])
                                                                .Where(s => s["LABDPTCODE"].ToString() == "043").Select(s => s["TESTNAME"].ToString().Trim())),
                                    TESTNAME = string.Join(", ", g.OrderBy(s => s["ORDERDATE"])
                                                             .Where(s => s["LABDPTCODE"].ToString() != "043" && s["REPRTSTATUS"].ToString() != "P").Select(s => s["TESTNAME"].ToString().Trim())),
                                    TESTPENDINGS = string.Join(", ", g.OrderBy(s => s["ORDERDATE"])
                                                              .Where(s => s["LABDPTCODE"].ToString() != "043" && s["REPRTSTATUS"].ToString() == "P").Select(s => s["TESTNAME"].ToString().Trim())),

                                    CULTURECOLOR = (g.Select(s => s["REPRTSTATUS"].ToString()).FirstOrDefault().ToString() == "P" && g.Select(s => s["LABDPTCODE"].ToString()).FirstOrDefault() == "043") ? "Y" : "N",
                                }).ToList();


                    dtOrderLst = ConvertToDataTable(data);
                    dtOrderLst.TableName = "ORDERTESTLIST";

                }
                else
                {
                    return null;
                }
            }

            finalDsToSend.Tables.Add(dtOrderLst);
            finalDsToSend.Tables.Add(dtPatInfo.Copy());
            finalDsToSend.Tables.Add(HData);
            return finalDsToSend;
        }

        //added by vijeta on 21st july 2018
        public DataTable ConvertToDataTable<T>(IList<T> data)
        {
            PropertyDescriptorCollection properties =
               TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in data)
            {
                DataRow row = table.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                table.Rows.Add(row);
            }
            return table;
        }

        //added by vishal on 18th feb 2019
        public DataSet GetSkinReAssment(string strIPNo, string strDate, string strToDt)
        {
            ICUClient icuClient = new ICUClient();
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet ds = new DataSet();
            DataSet finalDsToSend = new DataSet();
            DataTable HData = new DataTable();
            DataTable dtPatInfo = new DataTable();
            DataTable dtSkinAssmnt = new DataTable();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            if (dsPatInfo.Tables.Count > 0)
            {
                dtPatInfo.TableName = "PatInfo";
                dtPatInfo.Columns.Add("IPNO");
                dtPatInfo.Columns.Add("MRNO");
                dtPatInfo.Columns.Add("ADMNDATE");
                dtPatInfo.Columns.Add("PATNAME");
                dtPatInfo.Columns.Add("ADMNTIME");
                dtPatInfo.Columns.Add("Gender");
                dtPatInfo.Columns.Add("PATAGE");
                dtPatInfo.Columns.Add("CONSDOCT");
                dtPatInfo.Columns.Add("SALUNAME");
                dtPatInfo.Columns.Add("CURRBEDNO");
                dtPatInfo.Columns.Add("WARDNM");
                dtPatInfo.Columns.Add("NURSTNM");
                dtPatInfo.Columns.Add("DATE");
                dtPatInfo.Columns.Add("TIME");
                dtPatInfo.Columns.Add("CNAME");
                dtPatInfo.Columns.Add("TOMOROWDATE");
                DataRow patRow = dtPatInfo.NewRow();
                patRow["IPNO"] = dsPatInfo.Tables[0].Rows[0]["IPNO"].ToString();
                patRow["MRNO"] = dsPatInfo.Tables[0].Rows[0]["MRNO"].ToString();
                patRow["ADMNDATE"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString());
                patRow["PATNAME"] = dsPatInfo.Tables[0].Rows[0]["PATNAME"].ToString();
                //patRow["ADMNTIME"] = dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString();
                patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString());
                patRow["Gender"] = dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                patRow["PATAGE"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString();
                patRow["CONSDOCT"] = dsPatInfo.Tables[0].Rows[0]["CONSDOCT"].ToString();
                patRow["CURRBEDNO"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString();
                patRow["WARDNM"] = dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString();
                patRow["NURSTNM"] = dsPatInfo.Tables[0].Rows[0]["NURSTNM"].ToString();
                patRow["SALUNAME"] = dsPatInfo.Tables[0].Rows[0]["SALUNAME"].ToString();
                patRow["DATE"] = strDate;
                patRow["TIME"] = "";
                patRow["CNAME"] = "";
                patRow["TOMOROWDATE"] = strToDt;
                dtPatInfo.Rows.Add(patRow);
            }

            HData = GeneralFunction.getHeaderFooter("Skin Re-Assessment Braden Score", "", "", "");
            HData.TableName = "HeaderFooter";
            HData.Columns.Remove("Duplicate");
            object[] obj = new object[1];
            var frmDt = "";
            var toDt = "";
            frmDt = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            toDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            string str = icuClient.GetSkinReAssBradenScale(strIPNo, frmDt, toDt);

            ds.ReadXml(new XmlTextReader(new StringReader(str)));
            if (ds.Tables.Count > 0)
            {
                dtSkinAssmnt = ds.Tables[0];
                dtSkinAssmnt.Columns.Add("SkinAsmntWithDtTime");
                if (dtSkinAssmnt.Rows.Count > 0)
                {
                    for (int i = 0; i < dtSkinAssmnt.Rows.Count; i++)
                    {
                        dtSkinAssmnt.Rows[i]["NOTEDT"] = GeneralFunction.GetDate(dtSkinAssmnt.Rows[i]["NOTEDT"].ToString());
                        string bradenscore = dtSkinAssmnt.Rows[i]["BRADENSCORE"].ToString() == "0" ? "  " : dtSkinAssmnt.Rows[i]["BRADENSCORE"].ToString();
                        string userId = dtSkinAssmnt.Rows[i]["USERID"].ToString().Trim();
                        string verifiedBy = dtSkinAssmnt.Rows[i]["VERIFIEDBY"].ToString().Trim();
                        if (string.IsNullOrEmpty(verifiedBy))
                        {
                            dtSkinAssmnt.Rows[i]["USERID"] = GeneralFunction.GetFstNameUserId(userId);
                        }
                        else
                        {
                            dtSkinAssmnt.Rows[i]["USERID"] = GeneralFunction.GetFstNameUserId(userId) + "/" + GeneralFunction.GetFstNameUserId(verifiedBy);
                        }
                    }
                    dtSkinAssmnt.TableName = "SkinReAssmnt";
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
            ds.Tables.Add(dtPatInfo.Copy());
            ds.Tables.Add(HData);
            return ds;
        }
        //added by Haritha on 16/01/2026
        public List<SelectLstItem1> AssmntList()
        {
            List<SelectLstItem1> list = new List<SelectLstItem1>();
            list.Add(new SelectLstItem1() { Text = "Radial", Value = "R" });
            list.Add(new SelectLstItem1() { Text = "Femoral", Value = "F" });
            list.Add(new SelectLstItem1() { Text = "Others", Value = "O" });

            list.Add(new SelectLstItem1() { Text = "Jugular", Value = "J" });
            list.Add(new SelectLstItem1() { Text = "Subclavian", Value = "S" });
            list.Add(new SelectLstItem1() { Text = "Ryles tube", Value = "T" });

            list.Add(new SelectLstItem1() { Text = "Percutaneous Enterogastric Tube", Value = "P" });
            list.Add(new SelectLstItem1() { Text = "Nasojejunal tube", Value = "N" });
            list.Add(new SelectLstItem1() { Text = "Foleys", Value = "Y" });

            list.Add(new SelectLstItem1() { Text = "Supra-pubic", Value = "U" });
            list.Add(new SelectLstItem1() { Text = "Silicon", Value = "L" });
            list.Add(new SelectLstItem1() { Text = " Jejunostomy tube", Value = "M" });
            return list;
        }
        public List<SelectLstItem1> SideList()
        {
            List<SelectLstItem1> list = new List<SelectLstItem1>();
            list.Add(new SelectLstItem1() { Text = "Left", Value = "L" });
            list.Add(new SelectLstItem1() { Text = "Right", Value = "R" });
            return list;
        }
        public DataSet GetInvasiveLinesTube(string strIPNo, string strDate, string strTime)
        {
            Reports rpts = new Reports();
            ICUClient icuClient = new ICUClient();
            DataSet ds = new DataSet();
            DataSet finalDsToSend = new DataSet();
            DataTable HData = new DataTable();
            DataTable dtPatInfo1 = new DataTable();
            DataTable dtInvasive = new DataTable();
            DataTable dts = new DataTable();
            GeneralFunction gen = new GeneralFunction();
            //AssessmentOfLineMdl assmntofline = new AssessmentOfLineMdl();
            var AsstLst = AssmntList();
            var SideLst = SideList();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            if (dsPatInfo.Tables.Count > 0)
            {
                dtPatInfo1.TableName = "PatInfo1";
                dtPatInfo1.Columns.Add("strUIPNo");
                dtPatInfo1.Columns.Add("strUMrNo");
                dtPatInfo1.Columns.Add("strUAdmDtTm");
                dtPatInfo1.Columns.Add("strUName");
                //dtPatInfo.Columns.Add("ADMNTIME");
                dtPatInfo1.Columns.Add("strUAgeGender");
                //dtPatInfo.Columns.Add("PATAGE");
                dtPatInfo1.Columns.Add("strUConsDr");
                dtPatInfo1.Columns.Add("strUSaluNM");
                dtPatInfo1.Columns.Add("strUBedward");
                //dtPatInfo.Columns.Add("WARDNM");
                //dtPatInfo.Columns.Add("DATE");
                //dtPatInfo.Columns.Add("TIME");
                //dtPatInfo.Columns.Add("CNAME");
                //dtPatInfo.Columns.Add("TOMOROWDATE");
                DataRow patRow = dtPatInfo1.NewRow();
                patRow["strUIPNo"] = dsPatInfo.Tables[0].Rows[0]["IPNO"].ToString();
                patRow["strUMrNo"] = dsPatInfo.Tables[0].Rows[0]["MRNO"].ToString();
                //patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString()) + "     " + dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString(); ;
                patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString()) + " / " + GeneralFunction.ConvertTo12HourFormat(dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString());
                patRow["strUName"] = dsPatInfo.Tables[0].Rows[0]["PATNAME"].ToString();
                //patRow["ADMNTIME"] =
                //patRow["strUAgeGender"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString() + "     " + dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                patRow["strUAgeGender"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString() + " / " + dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                patRow["strUSaluNM"] = dsPatInfo.Tables[0].Rows[0]["SALUNAME"].ToString();
                patRow["strUConsDr"] = dsPatInfo.Tables[0].Rows[0]["CONSDOCT"].ToString();
                //patRow["strUBedward"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString() + "     " + dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString();
                patRow["strUBedward"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString() + " / " + dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString();
                //patRow["WARDNM"] = 
                //patRow["DATE"] = strDate;
                //patRow["TIME"] = "";
                //patRow["CNAME"] = "";
                //patRow["TOMOROWDATE"] = "";
                dtPatInfo1.Rows.Add(patRow);

            }

            HData = GeneralFunction.getHeaderFooter("Assessment of Lines & Tubes", "", "", "");
            HData.TableName = "HeaderFooter";
            HData.Columns.Remove("Duplicate");
            object[] obj = new object[1];
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            //ds.ReadXml(new XmlTextReader(new StringReader(icuClient.GetAssesOfLine(strIPNo, strDate, strTime))));
            ds.ReadXml(new XmlTextReader(new StringReader(icuClient.GetLineTubeList(strIPNo))));

            if (ds.Tables.Count > 0)
            {
                dtInvasive = ds.Tables[0];

                for (int i = 0; i < dtInvasive.Rows.Count; i++)
                {

                    dtInvasive.Rows[i]["DOI"] = GeneralFunction.GetDate(dtInvasive.Rows[i]["DOI"].ToString().Trim());
                    dtInvasive.Rows[i]["DOR"] = GeneralFunction.GetDate(dtInvasive.Rows[i]["DOR"].ToString().Trim());

                    // Update TUBETYPE
                    var tubetypeValue = dtInvasive.Rows[i]["TUBETYPE"].ToString();
                    if (tubetypeValue.ToString().Trim() != "")
                    {
                        var tubetypeText = AsstLst.FirstOrDefault(x => x.Value == tubetypeValue).Text ?? "";
                        dtInvasive.Rows[i]["TUBETYPE"] = tubetypeText;
                        if (tubetypeText != "" && dtInvasive.Rows[i]["OTHERTXT"] != "")
                        {
                            dtInvasive.Rows[i]["TUBETYPE"] = tubetypeText + " - " + dtInvasive.Rows[i]["OTHERTXT"].ToString().Trim();
                        }
                    }

                    //update side
                    var SideVal = dtInvasive.Rows[i]["SIDE"].ToString();
                    var SideText = SideLst.FirstOrDefault(x => x.Value == SideVal).Text ?? "";
                    dtInvasive.Rows[i]["SIDE"] = SideText;

                }


                dtInvasive.Columns["OTHERLINES"].ColumnName = "AssmntOfLine";
                dtInvasive.Columns["PROCSTARTTM"].ColumnName = "TOI";
                dtInvasive.Columns["REMOVALTM"].ColumnName = "TOR";
                dtInvasive.TableName = "AssessmentOfLine";

                dts = dtInvasive.Copy();
            }
            else
            {
                return null;
            }
            DataSet finalds = new DataSet();
            finalds.Tables.Add(dtPatInfo1);
            finalds.Tables.Add(dts);
            finalds.Tables.Add(HData);

            return finalds;
        }

        public DataSet GetReportCriticalAssmnt2(string strIPNo, string strDate)
        {
            Reports rpts = new Reports();
            ICUClient icuClient = new ICUClient();
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet ds = new DataSet();
            DataSet finalDsToSend = new DataSet();
            DataTable HData = new DataTable();
            DataTable dtPatInfo1 = new DataTable();
            DataTable dtcasedtls = new DataTable();
            DataTable dtcase = new DataTable();
            DataSet load = new DataSet();
            DataSet loadS = new DataSet();
            DataTable dtfinalcritcal = new DataTable();
            DataTable dtfinalicudays = new DataTable();
            GeneralFunction gen = new GeneralFunction();
            DataTable dt2 = new DataTable();

            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            if (dsPatInfo.Tables.Count > 0)
            {
                DateTime dt = DateTime.ParseExact(strDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                DateTime dt1 = dt.AddDays(1);
                dtPatInfo1.TableName = "PatInfo1";
                dtPatInfo1.Columns.Add("strUIPNo");
                dtPatInfo1.Columns.Add("strUMrNo");
                dtPatInfo1.Columns.Add("strUAdmDtTm");
                dtPatInfo1.Columns.Add("strUName");
                dtPatInfo1.Columns.Add("strUAgeGender");
                dtPatInfo1.Columns.Add("strUConsDr");
                dtPatInfo1.Columns.Add("strUSaluNM");
                dtPatInfo1.Columns.Add("strUBedward");
                dtPatInfo1.Columns.Add("DATE1");
                dtPatInfo1.Columns.Add("DATE2");
                dtPatInfo1.Columns.Add("strUAge");
                dtPatInfo1.Columns.Add("strUNurstSta");
                DataRow patRow = dtPatInfo1.NewRow();
                patRow["strUIPNo"] = dsPatInfo.Tables[0].Rows[0]["IPNO"].ToString();
                patRow["strUMrNo"] = dsPatInfo.Tables[0].Rows[0]["MRNO"].ToString();
                patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString()) + "/" + GeneralFunction.ConvertTo12HourFormat(dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString());
                patRow["strUName"] = dsPatInfo.Tables[0].Rows[0]["PATNAME"].ToString();

                //patRow["strUAgeGender"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString() + "     " + dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                patRow["strUAgeGender"] = dsPatInfo.Tables[0].Rows[0]["Gender"].ToString().Trim(); //modified by priyanka on 09/08/2025
                patRow["strUSaluNM"] = dsPatInfo.Tables[0].Rows[0]["SALUNAME"].ToString().Trim();
                patRow["strUConsDr"] = dsPatInfo.Tables[0].Rows[0]["CONSDOCT"].ToString().Trim();
                patRow["strUBedward"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString().Trim() + "/" + dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString().Trim();
                patRow["DATE1"] = strDate;
                patRow["DATE2"] = dt1.ToString("dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                patRow["strUAge"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString().Trim();//added by priyanka on 09/08/2025
                patRow["strUNurstSta"] = dsPatInfo.Tables[0].Rows[0]["NURSTNM"].ToString().Trim();//added by priyanka on 09/08/2025
                dtPatInfo1.Rows.Add(patRow);
            }

            loadS.ReadXml(new XmlTextReader(new StringReader(icuClient.GetCaseDetail(strIPNo, "", ""))));
            if (loadS.Tables.Contains("CaseDetails"))
            {
                dtcase = loadS.Tables["CaseDetails"];
                dtcasedtls = dtcase.DefaultView.ToTable(false, "DIAGNOSIS", "POSTOPDAYS", "EF", "BMI", "WEIGHT", "HEIGHT", "SURGNAME");
                dtcase.Rows[0]["SURGDATE"] = GeneralFunction.GetDate(dtcase.Rows[0]["SURGDATE"].ToString());
                string selDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                if (dtcasedtls.Rows[0]["POSTOPDAYS"].ToString().Trim() != "")
                    dtcasedtls.Rows[0]["POSTOPDAYS"] = GeneralFunction.calPostOperDays(dtcase.Rows[0]["SURGDATE"].ToString(), selDate);
                dtcasedtls.TableName = "CaseDtls";


            }
            else
            {
                dtcasedtls.TableName = "CaseDtls";
                dtcasedtls.Columns.Add("DIAGNOSIS");
                dtcasedtls.Columns.Add("POSTOPDAYS");
                dtcasedtls.Columns.Add("EF");
                dtcasedtls.Columns.Add("BMI");
                dtcasedtls.Columns.Add("WEIGHT");
                dtcasedtls.Columns.Add("HEIGHT");
                dtcasedtls.Columns.Add("SURGNAME");
            }
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetCriticAsses2Det(strIPNo, strDate))));
            if (load.Tables.Count > 0)
            {

                if (load.Tables.Contains("CRITDATA"))
                {
                    dt2 = load.Tables["CRITDATA"];

                    for (int i = 0; i < dt2.Rows.Count; i++)
                    {
                        string infusion = dt2.Rows[i]["INFUSNDESC"].ToString().Trim().ToLower();
                        string seqno = dt2.Rows[i]["SEQNO"].ToString().Trim();

                        if (dt2.Rows[i]["INFUSNDESC"].ToString().Trim() == "RT aspiration for the hour (A)")
                        {
                            DataRow blankRow = dt2.NewRow();
                            blankRow["INFUSNDESC"] = "Output";
                            dt2.Rows.InsertAt(blankRow, i);
                            break;
                        }
                    }

                    //Insert Blank row before the row with druginfusion = Net balance ! Added by priyanka on 28/08/2025 !
                    for (int i = 0; i < dt2.Rows.Count; i++)
                    {
                        string infusion = dt2.Rows[i]["INFUSNDESC"].ToString().Trim().ToLower();
                        string seqno = dt2.Rows[i]["SEQNO"].ToString().Trim();

                        if (dt2.Rows[i]["INFUSNDESC"].ToString().Trim() == "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) FOR the Hour:")
                        {
                            DataRow blankRow = dt2.NewRow();
                            blankRow["INFUSNDESC"] = "Balance";
                            dt2.Rows.InsertAt(blankRow, i);
                            break;
                        }
                    }

                    // Insert blank row before the first row with DRUGINFUSION = "Druginfusion input"
                    for (int i = 0; i < dt2.Rows.Count; i++)
                    {
                        string infusion = dt2.Rows[i]["INFUSNDESC"].ToString().Trim().ToLower();
                        string seqno = dt2.Rows[i]["SEQNO"].ToString().Trim();

                        if (seqno == "0")
                        {
                            DataRow blankRow = dt2.NewRow();
                            blankRow["INFUSNDESC"] = "Input";
                            dt2.Rows.InsertAt(blankRow, i);
                            break;
                        }
                    }

                    foreach (DataRow row in dt2.Rows)
                    {
                        for (int col = 0; col < dt2.Columns.Count; col++)
                        {
                            string columnName = dt2.Columns[col].ColumnName;

                            if (columnName.Equals("SEQNO", StringComparison.OrdinalIgnoreCase))
                                continue; // Skip the SEQNO column

                            if (row[col] != null && (row[col].ToString().Trim() == "0" || row[col].ToString().Trim() == "0.00"))
                            {
                                row[col] = ""; // Replace 0 with blank string
                            }
                        }
                    }
                }
            }




            if (load.Tables.Count > 0 && load.Tables.Contains("CRITDATA"))
            {
                dtfinalcritcal = load.Tables["CRITDATA"].Copy();
                if (load.Tables.Contains("ICUDAYS"))
                {
                    dtfinalicudays = load.Tables["ICUDAYS"].Copy();
                }
                else
                {
                    dtfinalicudays.TableName = "ICUDAYS";
                    dtfinalicudays.Columns.Add("BEDNUMBER");
                    dtfinalicudays.Columns.Add("ICUDAY");
                    dtfinalicudays.Columns.Add("PATAGE");
                    dtfinalicudays.Columns.Add("WARNNAME");
                    dtfinalicudays.Columns.Add("NURSSTNNAME");

                }

                dtfinalcritcal.Columns["7AM"].ColumnName = "FirstHour";
                dtfinalcritcal.Columns["8AM"].ColumnName = "SecondHour";
                dtfinalcritcal.Columns["9AM"].ColumnName = "ThirdHour";
                dtfinalcritcal.Columns["10AM"].ColumnName = "FourthHour";
                dtfinalcritcal.Columns["11AM"].ColumnName = "FifthHour";
                dtfinalcritcal.Columns["12PM"].ColumnName = "SixHour";
                dtfinalcritcal.Columns["1PM"].ColumnName = "SevenHour";
                dtfinalcritcal.Columns["2PM"].ColumnName = "EightHour";
                dtfinalcritcal.Columns["3PM"].ColumnName = "NineHour";
                dtfinalcritcal.Columns["4PM"].ColumnName = "TenHour";
                dtfinalcritcal.Columns["5PM"].ColumnName = "ElevenHour";
                dtfinalcritcal.Columns["6PM"].ColumnName = "TwelveHour";
                dtfinalcritcal.Columns["7PM"].ColumnName = "ThirteenHour";
                dtfinalcritcal.Columns["8PM"].ColumnName = "FourteenHour";
                dtfinalcritcal.Columns["9PM"].ColumnName = "FifteenHour";
                dtfinalcritcal.Columns["10PM"].ColumnName = "SixteenHour";
                dtfinalcritcal.Columns["11PM"].ColumnName = "SeventeenHour";
                dtfinalcritcal.Columns["12AM"].ColumnName = "EightteenHour";
                dtfinalcritcal.Columns["1AM"].ColumnName = "NineteenHour";
                dtfinalcritcal.Columns["2AM"].ColumnName = "TwentyHour";
                dtfinalcritcal.Columns["3AM"].ColumnName = "TwentyOneHour";
                dtfinalcritcal.Columns["4AM"].ColumnName = "TwentyTwoHour";
                dtfinalcritcal.Columns["5AM"].ColumnName = "TwentyThreeHour";
                dtfinalcritcal.Columns["6AM"].ColumnName = "TwentyFourHour";
                dtfinalcritcal.Columns["INFUSNDESC"].ColumnName = "DrugInfusion";
                dtfinalcritcal.Columns.Remove("CA2DATE");
                dtfinalcritcal.Columns.Remove("INFUSNTYPE");
                dtfinalcritcal.Columns.Remove("IPNO");
                dtfinalcritcal.Columns.Remove("CREATEDAT");
                dtfinalcritcal.Columns.Remove("CREATEDBY");
                dtfinalcritcal.Columns.Remove("CREATEDON");
                dtfinalcritcal.Columns.Remove("SEQNO");
                dtfinalcritcal.TableName = "CriticalAssessment2";

                HData = GeneralFunction.getHeaderFooter("Critical Assessment2", "", "", "");
                HData.TableName = "HeaderFooter";
                HData.Columns.Remove("Duplicate");
            }
            else
            {
                return null;
            }
            DataSet finalds = new DataSet();
            finalds.Tables.Add(dtPatInfo1);
            finalds.Tables.Add(dtcasedtls);
            finalds.Tables.Add(dtfinalcritcal);
            finalds.Tables.Add(dtfinalicudays);
            finalds.Tables.Add(HData);

            return finalds;
        }

        //added by vishal 17th June 2019
        public DataSet GetPeripheralVascularBundleData(string strIPNo, string strDate, string strToDt, string strNsNm, string strBundletype)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable finalperipheral = new DataTable();
            finalperipheral.TableName = "PERIPHERAL";

            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");
            DataTable dtDate = new DataTable();
            DataTable dtpephrl = new DataTable();
            DataTable dt = new DataTable();
            DataTable dtpatInfo = new DataTable();
            DataTable HData = new DataTable();
            DataTable dt1 = new DataTable();
            DataTable dtproc = new DataTable();
            DataTable dtprocedure = new DataTable();
            DataTable dtbldculture = new DataTable();
            DataTable dts = new DataTable();
            DataTable dtrmks = new DataTable();
            DataTable dtnewrmks = new DataTable();
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetPeriBundheckList(strIPNo, strDate, strBundletype, strToDt, ""))));
            object[] obj = new object[1];

            if (load == null)
            {
                obj[0] = "";
            }
            else
            {


                if (load.Tables.Count > 0)
                {
                    if (load.Tables.Contains("Table"))
                    {
                        if (load.Tables["Table"].Rows.Count > 0)
                        {
                            dt = load.Tables[0];

                            dtproc.Columns.Add("BUNDLETYPE");
                            dtproc.Columns.Add("CLIREASONYN");
                            dtproc.Columns.Add("PPEYN");
                            dtproc.Columns.Add("HANDTECHYN");
                            //dtproc.Columns.Add("DOI");
                            //dtproc.Columns.Add("DOR");
                            //dtproc.Columns.Add("PROCDONEBY");
                            //dtproc.Columns.Add("REMARKS");
                            dtproc.Columns.Add("STAFFNAME");

                            DataRow drproc = dtproc.NewRow();
                            drproc["BUNDLETYPE"] = dt.Rows[0]["BUNDLETYPE"];
                            drproc["CLIREASONYN"] = "Y";
                            drproc["PPEYN"] = "Y";
                            drproc["HANDTECHYN"] = "Y";
                            //drproc["PROCDONEBY"] = dt.Rows[0]["PROCDONEBY"];
                            //drproc["DOI"] = GeneralFunction.GetDate(dt.Rows[0]["DOI"].ToString());
                            //drproc["DOR"] = GeneralFunction.GetDate(dt.Rows[0]["DOR"].ToString());
                            //drproc["REMARKS"] = dt.Rows[0]["REMARKS"];
                            drproc["STAFFNAME"] = dt.Rows[0]["STAFFNAME"];
                            dtproc.Rows.Add(drproc);

                            //step 1 //               Uniques Dates
                            var distinctIds = dt.AsEnumerable()
                       .Select(s => new
                       {
                           id = s.Field<string>("CHKLSTDT"),
                       })
                       .Distinct().ToList();
                            var leng = distinctIds.Count - 1;

                            //step 2                 Creating Date Column Table

                            dtDate.TableName = "DATE";
                            dtDate.Columns.Add("Column1");
                            dtDate.Columns.Add("Column2");
                            dtDate.Columns.Add("Column3");
                            dtDate.Columns.Add("Column4");
                            dtDate.Columns.Add("Column5");
                            dtDate.Columns.Add("Column6");
                            dtDate.Columns.Add("Column7");
                            dtDate.Columns.Add("Column8");
                            dtDate.Columns.Add("Column9");
                            dtDate.Columns.Add("Column10");
                            dtDate.Rows.Add();
                            int g = 0;
                            foreach (DataColumn column in dtDate.Columns)
                            {
                                if (g <= leng)
                                {
                                    var a = GeneralFunction.GetDate(distinctIds[g].id);
                                    var d1 = a.Substring(0, 6);
                                    var d2 = a.Substring(8, 2);
                                    dtDate.Rows[0][column.ColumnName] = d1 + d2;


                                    g++;
                                }
                                else
                                {
                                    dtDate.Rows[0][column.ColumnName] = "";
                                }

                            }

                            //step 3 

                            DataTable PCheckList = dt.DefaultView.ToTable(true, "CHKLSTCODE", "CHKLSTDESC");

                            //var PCheckList = comclient.GetPeripheralChkList().Where(x => x.Status == "A").ToArray();
                            finalperipheral.Columns.Add("Code");
                            finalperipheral.Columns.Add("Name");

                            //setp 4
                            int p = 0;
                            foreach (DataColumn column in dtDate.Columns)
                            {
                                if (p <= leng)
                                {

                                    finalperipheral.Columns.Add(GeneralFunction.GetDate(distinctIds[p].id) + "M");
                                    finalperipheral.Columns.Add(GeneralFunction.GetDate(distinctIds[p].id) + "E");
                                    finalperipheral.Columns.Add(GeneralFunction.GetDate(distinctIds[p].id) + "N");
                                    p++;
                                }
                                else
                                {
                                    finalperipheral.Columns.Add(column.ColumnName + "M");
                                    finalperipheral.Columns.Add(column.ColumnName + "E");
                                    finalperipheral.Columns.Add(column.ColumnName + "N");
                                }
                            }

                            //setp 5
                            for (int f = 0; f <= PCheckList.Rows.Count - 1; f++)
                            {
                                DataRow dr1 = finalperipheral.NewRow();
                                //dr1["Code"] = PCheckList[f].Value;
                                //dr1["Name"] = PCheckList[f].Text;
                                dr1["Code"] = PCheckList.Rows[f]["CHKLSTCODE"];
                                dr1["Name"] = PCheckList.Rows[f]["CHKLSTDESC"];
                                finalperipheral.Rows.Add(dr1);
                            }



                            //setp 6

                            if (dt != null)
                            {
                                for (int d = 0; d <= dt.Rows.Count - 1; d++)
                                {
                                    for (int c = 0; c <= finalperipheral.Rows.Count - 1; c++)
                                    {
                                        if (finalperipheral.Rows[c]["Code"].ToString() == dt.Rows[d]["CHKLSTCODE"].ToString())
                                        {
                                            foreach (DataColumn column in finalperipheral.Columns)
                                            {
                                                var cl = (column.ColumnName).Substring(0, (column.ColumnName).Length - 1);
                                                var shift = (column.ColumnName).Substring((column.ColumnName).Length - 1, 1);
                                                if (dt.Rows[d]["CHKLSTDT"].ToString() == GeneralFunction.GetDateInSpecifiedFormat(cl, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD) && dt.Rows[d]["SHIFTTIME"].ToString() == shift)
                                                {

                                                    //finalperipheral.Rows[c][column.ColumnName] = "Y";
                                                    if (dt.Rows[d]["VALUE"].ToString().Trim() != "")
                                                    {
                                                        finalperipheral.Rows[c][column.ColumnName] = dt.Rows[d]["VALUE"].ToString().Trim();
                                                    }
                                                    else
                                                    {
                                                        finalperipheral.Rows[c][column.ColumnName] = "";
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                            }

                        }
                    }
                    else
                    {
                        finalperipheral.Columns.Add("Code");
                        finalperipheral.Columns.Add("Name");
                        finalperipheral.Columns.Add("Column1M");
                        finalperipheral.Columns.Add("Column1E");
                        finalperipheral.Columns.Add("Column1N");
                        finalperipheral.Columns.Add("Column2M");
                        finalperipheral.Columns.Add("Column2E");
                        finalperipheral.Columns.Add("Column2N");
                        finalperipheral.Columns.Add("Column3M");
                        finalperipheral.Columns.Add("Column3E");
                        finalperipheral.Columns.Add("Column3N");
                        finalperipheral.Columns.Add("Column4M");
                        finalperipheral.Columns.Add("Column4E");
                        finalperipheral.Columns.Add("Column4N");
                        finalperipheral.Columns.Add("Column5M");
                        finalperipheral.Columns.Add("Column5E");
                        finalperipheral.Columns.Add("Column5N");
                        finalperipheral.Columns.Add("Column6M");
                        finalperipheral.Columns.Add("Column6E");
                        finalperipheral.Columns.Add("Column6N");
                        finalperipheral.Columns.Add("Column7M");
                        finalperipheral.Columns.Add("Column7E");
                        finalperipheral.Columns.Add("Column7N");

                        dtDate.Columns.Add("Column1");
                        dtDate.Columns.Add("Column2");
                        dtDate.Columns.Add("Column3");
                        dtDate.Columns.Add("Column4");
                        dtDate.Columns.Add("Column5");
                        dtDate.Columns.Add("Column6");
                        dtDate.Columns.Add("Column7");
                        dtDate.Columns.Add("Column8");
                        dtDate.Columns.Add("Column9");
                        dtDate.Columns.Add("Column10");

                        dtproc.Columns.Add("BUNDLETYPE");
                        dtproc.Columns.Add("CLIREASONYN");
                        dtproc.Columns.Add("PPEYN");
                        dtproc.Columns.Add("HANDTECHYN");
                        dtproc.Columns.Add("DOI");
                        dtproc.Columns.Add("DOR");
                        dtproc.Columns.Add("PROCDONEBY");
                        dtproc.Columns.Add("REMARKS");
                        dtproc.Columns.Add("STAFFNAME");

                    }


                }
                else
                {

                }

                if (load.Tables.Contains("Table1"))
                {
                    if (load.Tables["Table1"].Rows.Count > 0)
                    {
                        dtbldculture = load.Tables["Table1"].Copy();
                        dtbldculture.TableName = "BLOODCULTURE";
                        for (int b = 0; b <= dtbldculture.Rows.Count - 1; b++)
                        {
                            dtbldculture.Rows[b]["bldculdt"] = GeneralFunction.GetDate(dtbldculture.Rows[b]["bldculdt"].ToString());
                        }
                    }

                }
                else
                {
                    dtbldculture.Columns.Add("bldculdt");
                    dtbldculture.Columns.Add("bldculresult");
                    dtbldculture.TableName = "BLOODCULTURE";
                }

                if (load.Tables.Contains("Table2"))
                {
                    if (load.Tables["Table2"].Rows.Count > 0)
                    {
                        dtprocedure = load.Tables["Table2"].Copy();
                        dtprocedure.TableName = "PPROCEDUREDONEBY";
                        for (int b = 0; b <= dtprocedure.Rows.Count - 1; b++)
                        {
                            if ((dtprocedure.Rows[b]["PROCDONEBY"].ToString().Trim().ToUpper() == "OUTSIDE") && (dtprocedure.Rows[b]["DOI"].ToString().Trim() == ""))
                            {
                                dtprocedure.Rows[b]["DOI"] = "Not Known";
                            }
                            else
                            {
                                dtprocedure.Rows[b]["DOI"] = GeneralFunction.GetDate(dtprocedure.Rows[b]["DOI"].ToString());
                                dtprocedure.Rows[b]["DOR"] = GeneralFunction.GetDate(dtprocedure.Rows[b]["DOR"].ToString());
                            }
                        }
                    }

                }
                else
                {
                    dtprocedure.Columns.Add("PROCDONEBY");
                    dtprocedure.Columns.Add("DOI");
                    dtprocedure.Columns.Add("DOR");
                    dtprocedure.TableName = "PPROCEDUREDONEBY";
                }

                if (load.Tables.Contains("Table3"))
                {
                    dtnewrmks.TableName = "PerphlRemarks";
                    if (load.Tables["Table3"].Rows.Count > 0)
                    {
                        dtrmks = load.Tables["Table3"].Copy();
                        DataTable dtdt = dtrmks.DefaultView.ToTable(true, "CHKLSTDT");
                        DataTable dtshft = dtrmks.DefaultView.ToTable(true, "SHIFTTIME");
                        dtnewrmks.Columns.Add("Date");
                        dtnewrmks.Columns.Add("Morning");
                        dtnewrmks.Columns.Add("Evening");
                        dtnewrmks.Columns.Add("Night");
                        dtnewrmks.Columns.Add("CreatedBy");

                        for (int m = 0; m <= dtdt.Rows.Count - 1; m++)
                        {
                            DataRow drnewrmks = dtnewrmks.NewRow();
                            drnewrmks["Date"] = GeneralFunction.GetDate(dtdt.Rows[m]["CHKLSTDT"].ToString());
                            dtnewrmks.Rows.Add(drnewrmks);
                        }

                        for (int n = 0; n <= dtnewrmks.Rows.Count - 1; n++)
                        {
                            for (int m = 0; m <= dtrmks.Rows.Count - 1; m++)
                            {
                                foreach (DataColumn column in dtnewrmks.Columns)
                                {
                                    //var cl = (column.ColumnName).Substring(0, (column.ColumnName).Length - 1);
                                    var shift = (column.ColumnName).Substring(0, 1);

                                    if (dtnewrmks.Rows[n]["Date"].ToString().Trim() == GeneralFunction.GetDate(dtrmks.Rows[m]["CHKLSTDT"].ToString().Trim()) && dtrmks.Rows[m]["SHIFTTIME"].ToString().Trim() == shift)
                                    {
                                        if (shift == "M")
                                        {
                                            var rmks = dtrmks.Rows[m]["REMARKS"].ToString().Trim();
                                            var sht = dtrmks.Rows[m]["STAFFNAME"].ToString().Trim();
                                            if (rmks.Length > 0 && sht.Length > 0)
                                            {
                                                dtnewrmks.Rows[n]["Morning"] = dtrmks.Rows[m]["REMARKS"] + " - " + dtrmks.Rows[m]["STAFFNAME"];
                                            }
                                            else if (rmks.Length == 0)
                                            {
                                                dtnewrmks.Rows[n]["Morning"] = dtrmks.Rows[m]["STAFFNAME"];
                                            }

                                        }

                                        else if (shift == "E")
                                        {
                                            var rmks = dtrmks.Rows[m]["REMARKS"].ToString().Trim();
                                            var sht = dtrmks.Rows[m]["STAFFNAME"].ToString().Trim();
                                            if (rmks.Length > 0 && sht.Length > 0)
                                            {
                                                dtnewrmks.Rows[n]["Evening"] = dtrmks.Rows[m]["REMARKS"] + " - " + dtrmks.Rows[m]["STAFFNAME"];
                                            }
                                            else if (rmks.Length == 0)
                                            {
                                                dtnewrmks.Rows[n]["Evening"] = dtrmks.Rows[m]["STAFFNAME"];
                                            }
                                        }

                                        else if (shift == "N")
                                        {
                                            var rmks = dtrmks.Rows[m]["REMARKS"].ToString().Trim();
                                            var sht = dtrmks.Rows[m]["STAFFNAME"].ToString().Trim();
                                            if (rmks.Length > 0 && sht.Length > 0)
                                            {
                                                dtnewrmks.Rows[n]["Night"] = dtrmks.Rows[m]["REMARKS"] + " - " + dtrmks.Rows[m]["STAFFNAME"];
                                            }
                                            else if (rmks.Length == 0)
                                            {
                                                dtnewrmks.Rows[n]["Night"] = dtrmks.Rows[m]["STAFFNAME"];
                                            }
                                        }


                                        dtnewrmks.Rows[n]["CreatedBy"] = dtrmks.Rows[m]["CREATEDBY"];
                                    }
                                }

                            }
                        }

                    }
                }
                else
                {
                    dtnewrmks.TableName = "PerphlRemarks";
                    dtnewrmks.Columns.Add("Date");
                    dtnewrmks.Columns.Add("Morning");
                    dtnewrmks.Columns.Add("Evening");
                    dtnewrmks.Columns.Add("Night");
                    dtnewrmks.Columns.Add("CreatedBy");
                }

                dt1.TableName = "PatInfoNursgNotes";
                if (load.Tables.Count > 0)
                {
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("strUIPNo");
                        dt1.Columns.Add("strUMrNo");
                        dt1.Columns.Add("strUAdmDtTm");
                        dt1.Columns.Add("strUName");
                        dt1.Columns.Add("strUTariffCat");
                        dt1.Columns.Add("strUOccuBedCat");
                        dt1.Columns.Add("strUAgeGender");
                        dt1.Columns.Add("strUPatCat");
                        dt1.Columns.Add("strUBillBedCat");
                        dt1.Columns.Add("strUBedward");
                        dt1.Columns.Add("strUNurstSta");
                        dt1.Columns.Add("strUAdmDr");
                        dt1.Columns.Add("strUConsDr");
                        dt1.Columns.Add("strUExempCat");
                        dt1.Columns.Add("strUInshuComp");
                        dt1.Columns.Add("strEmpID");
                        dt1.Columns.Add("strUCrdComp");
                        dt1.Columns.Add("strBundletype");
                        DataRow patRow = dt1.NewRow();
                        patRow["strUIPNo"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["strUMrNo"] = dt.Rows[0]["MRNO"].ToString();
                        patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString()) + "   " + GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["strUName"] = dt.Rows[0]["SALUNAME"].ToString() + "  " + dt.Rows[0]["PATNAME"].ToString();
                        patRow["strUTariffCat"] = dt.Rows[0]["TARIFFDESC"].ToString();
                        patRow["strUOccuBedCat"] = dt.Rows[0]["OCCUBEDCATGNM"].ToString();
                        patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + "   " + dt.Rows[0]["Gender"].ToString();
                        patRow["strUPatCat"] = dt.Rows[0]["PATCATGNM"].ToString();
                        patRow["strUBillBedCat"] = dt.Rows[0]["BLBEDCATGNM"].ToString();
                        patRow["strUBedward"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["strUNurstSta"] = dt.Rows[0]["NURSTNM"].ToString();
                        patRow["strUAdmDr"] = dt.Rows[0]["ADMNDOCTNM"].ToString();
                        patRow["strUConsDr"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["strUExempCat"] = dt.Rows[0]["EXEMPNM"].ToString();
                        patRow["strUInshuComp"] = dt.Rows[0]["INSURCMPNM"].ToString();
                        patRow["strEmpID"] = "";
                        patRow["strUCrdComp"] = dt.Rows[0]["COMPNAME"].ToString();
                        patRow["strBundletype"] = strBundletype.ToString().Trim();
                        dt1.Rows.Add(patRow);
                    }

                    if (finalperipheral.Rows.Count > 0)
                    {
                        finalperipheral.Columns[2].ColumnName = "Column1M";
                        finalperipheral.Columns[3].ColumnName = "Column1E";
                        finalperipheral.Columns[4].ColumnName = "Column1N";
                        finalperipheral.Columns[5].ColumnName = "Column2M";
                        finalperipheral.Columns[6].ColumnName = "Column2E";
                        finalperipheral.Columns[7].ColumnName = "Column2N";
                        finalperipheral.Columns[8].ColumnName = "Column3M";
                        finalperipheral.Columns[9].ColumnName = "Column3E";
                        finalperipheral.Columns[10].ColumnName = "Column3N";
                        finalperipheral.Columns[11].ColumnName = "Column4M";
                        finalperipheral.Columns[12].ColumnName = "Column4E";
                        finalperipheral.Columns[13].ColumnName = "Column4N";
                        finalperipheral.Columns[14].ColumnName = "Column5M";
                        finalperipheral.Columns[15].ColumnName = "Column5E";
                        finalperipheral.Columns[16].ColumnName = "Column5N";
                        finalperipheral.Columns[17].ColumnName = "Column6M";
                        finalperipheral.Columns[18].ColumnName = "Column6E";
                        finalperipheral.Columns[19].ColumnName = "Column6N";
                        finalperipheral.Columns[20].ColumnName = "Column7M";
                        finalperipheral.Columns[21].ColumnName = "Column7E";
                        finalperipheral.Columns[22].ColumnName = "Column7N";
                    }


                    dtDate.TableName = "PDate";
                    dtproc.TableName = "PProcedure";
                    dsFinalForPrint.Tables.Add(dt1);
                    dsFinalForPrint.Tables.Add(finalperipheral);
                    dsFinalForPrint.Tables.Add(dtDate);

                    HData = GeneralFunction.getHeaderFooter("Peripheral Bundle Check List", "", "", "");
                    string strFrmDt = GeneralFunction.GetDate(strDate);
                    string strToDts = GeneralFunction.GetDate(strToDt);
                    HData.TableName = "HeaderFooter";
                    if (strFrmDt == strToDate)
                        HData.Rows[0]["ForDate"] = "On " + strFrmDt;
                    else
                        HData.Rows[0]["ForDate"] = "From " + strFrmDt + " To " + strToDts;
                    HData.Columns.Remove("Duplicate");
                    dsFinalForPrint.Tables.Add(HData);
                    dsFinalForPrint.Tables.Add(dtproc);

                    dsFinalForPrint.Tables.Add(dtbldculture);
                    dsFinalForPrint.Tables.Add(dtprocedure);
                    dsFinalForPrint.Tables.Add(dtnewrmks);
                }


            }
            return dsFinalForPrint;
        }

        public DataSet GetFallRiskScoreData(string strIPNo, string strDate, string strToDt)
        {
            DataSet load = new DataSet();
            DataTable finalperipheral = new DataTable();
            finalperipheral.TableName = "FALLRISK";

            DataSet dsFinalForPrint = new DataSet();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");
            DataTable dtDate = new DataTable();
            DataTable dtpephrl = new DataTable();
            DataTable dt = new DataTable();
            DataTable dtpatInfo = new DataTable();
            DataTable HData = new DataTable();
            DataTable dt1 = new DataTable();
            DataTable dtproc = new DataTable();
            DataTable dtprocedure = new DataTable();
            DataTable dtbldculture = new DataTable();
            DataTable dts = new DataTable();
            DataTable dtrmks = new DataTable();
            DataTable dtnewrmks = new DataTable();
            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetFallRiskScore(strIPNo, strDate, strToDt, ""))));
            object[] obj = new object[1];

            if (load == null)
            {
                obj[0] = "";
            }
            else
            {
                if (load.Tables.Count > 0)
                {
                    if (load.Tables.Contains("Table"))
                    {
                        if (load.Tables["Table"].Rows.Count > 0)
                        {
                            dt = load.Tables[0];

                            dtproc.Columns.Add("STAFFNAME");

                            DataRow drproc = dtproc.NewRow();

                            drproc["STAFFNAME"] = GeneralFunction.GetFstNameUserId(dt.Rows[0]["STAFFNAME"].ToString());
                            dtproc.Rows.Add(drproc);

                            //step 1 //               Uniques Dates
                            var distinctIds = dt.AsEnumerable()
                       .Select(s => new
                       {
                           id = s.Field<string>("CHKLSTDT"),
                       })
                       .Distinct().ToList();
                            var leng = distinctIds.Count - 1;

                            //step 2                 Creating Date Column Table

                            dtDate.TableName = "DATE";
                            dtDate.Columns.Add("Column1");
                            dtDate.Columns.Add("Column2");
                            dtDate.Columns.Add("Column3");
                            dtDate.Columns.Add("Column4");
                            dtDate.Columns.Add("Column5");
                            dtDate.Columns.Add("Column6");
                            dtDate.Columns.Add("Column7");
                            dtDate.Columns.Add("Column8");
                            dtDate.Columns.Add("Column9");
                            dtDate.Columns.Add("Column10");
                            dtDate.Rows.Add();
                            int g = 0;
                            foreach (DataColumn column in dtDate.Columns)
                            {
                                if (g <= leng)
                                {
                                    var a = GeneralFunction.GetDate(distinctIds[g].id);
                                    var d1 = a.Substring(0, 6);
                                    var d2 = a.Substring(8, 2);
                                    dtDate.Rows[0][column.ColumnName] = d1 + d2;


                                    g++;
                                }
                                else
                                {
                                    dtDate.Rows[0][column.ColumnName] = "";
                                }

                            }

                            //step 3 

                            DataTable PCheckList = dt.DefaultView.ToTable(true, "FRCODE", "FRDESC");

                            //var PCheckList = comclient.GetPeripheralChkList().Where(x => x.Status == "A").ToArray();
                            finalperipheral.Columns.Add("Code");
                            finalperipheral.Columns.Add("Name");

                            //setp 4
                            int p = 0;
                            foreach (DataColumn column in dtDate.Columns)
                            {
                                if (p <= leng)
                                {

                                    finalperipheral.Columns.Add(GeneralFunction.GetDate(distinctIds[p].id) + "M");
                                    finalperipheral.Columns.Add(GeneralFunction.GetDate(distinctIds[p].id) + "E");
                                    finalperipheral.Columns.Add(GeneralFunction.GetDate(distinctIds[p].id) + "N");
                                    p++;
                                }
                                else
                                {
                                    finalperipheral.Columns.Add(column.ColumnName + "M");
                                    finalperipheral.Columns.Add(column.ColumnName + "E");
                                    finalperipheral.Columns.Add(column.ColumnName + "N");
                                }
                            }

                            //setp 5
                            for (int f = 0; f <= PCheckList.Rows.Count - 1; f++)
                            {
                                DataRow dr1 = finalperipheral.NewRow();
                                //dr1["Code"] = PCheckList[f].Value;
                                //dr1["Name"] = PCheckList[f].Text;
                                dr1["Code"] = PCheckList.Rows[f]["FRCODE"];
                                dr1["Name"] = PCheckList.Rows[f]["FRDESC"];
                                finalperipheral.Rows.Add(dr1);
                            }



                            //setp 6

                            if (dt != null)
                            {
                                for (int d = 0; d <= dt.Rows.Count - 1; d++)
                                {
                                    for (int c = 0; c <= finalperipheral.Rows.Count - 1; c++)
                                    {
                                        if (finalperipheral.Rows[c]["Code"].ToString() == dt.Rows[d]["FRCODE"].ToString())
                                        {
                                            foreach (DataColumn column in finalperipheral.Columns)
                                            {
                                                var cl = (column.ColumnName).Substring(0, (column.ColumnName).Length - 1);
                                                var shift = (column.ColumnName).Substring((column.ColumnName).Length - 1, 1);
                                                if (dt.Rows[d]["CHKLSTDT"].ToString() == GeneralFunction.GetDateInSpecifiedFormat(cl, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD) && dt.Rows[d]["SHIFTTIME"].ToString() == shift)
                                                {

                                                    //finalperipheral.Rows[c][column.ColumnName] = "Y";
                                                    if (dt.Rows[d]["SELYN"].ToString().Trim() == "Y")
                                                    {
                                                        finalperipheral.Rows[c][column.ColumnName] = dt.Rows[d]["SCORE"].ToString().Trim();
                                                    }
                                                    else
                                                    {
                                                        finalperipheral.Rows[c][column.ColumnName] = "";
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                            }

                        }
                    }
                    else
                    {
                        finalperipheral.Columns.Add("Code");
                        finalperipheral.Columns.Add("Name");
                        finalperipheral.Columns.Add("Column1M");
                        finalperipheral.Columns.Add("Column1E");
                        finalperipheral.Columns.Add("Column1N");
                        finalperipheral.Columns.Add("Column2M");
                        finalperipheral.Columns.Add("Column2E");
                        finalperipheral.Columns.Add("Column2N");
                        finalperipheral.Columns.Add("Column3M");
                        finalperipheral.Columns.Add("Column3E");
                        finalperipheral.Columns.Add("Column3N");
                        finalperipheral.Columns.Add("Column4M");
                        finalperipheral.Columns.Add("Column4E");
                        finalperipheral.Columns.Add("Column4N");
                        finalperipheral.Columns.Add("Column5M");
                        finalperipheral.Columns.Add("Column5E");
                        finalperipheral.Columns.Add("Column5N");
                        finalperipheral.Columns.Add("Column1");
                        finalperipheral.Columns.Add("Column2");
                        finalperipheral.Columns.Add("Column3");
                        finalperipheral.Columns.Add("Column4");
                        finalperipheral.Columns.Add("Column5");
                        finalperipheral.Columns.Add("Column6");
                        finalperipheral.Columns.Add("Column7");
                        finalperipheral.Columns.Add("Column8");
                        finalperipheral.Columns.Add("Column9");
                        finalperipheral.Columns.Add("Column10");
                        finalperipheral.Columns.Add("REMARKS");
                        finalperipheral.Columns.Add("STAFFNAME");
                    }
                }
                else
                {

                }

                if (load.Tables.Contains("Table1"))
                {
                    dtnewrmks.TableName = "PerphlRemarks";
                    if (load.Tables["Table1"].Rows.Count > 0)
                    {
                        dtrmks = load.Tables["Table1"].Copy();
                        DataTable dtdt = dtrmks.DefaultView.ToTable(true, "CHKLSTDT");
                        DataTable dtshft = dtrmks.DefaultView.ToTable(true, "SHIFTTIME");
                        dtnewrmks.Columns.Add("Date");
                        dtnewrmks.Columns.Add("Morning");
                        dtnewrmks.Columns.Add("Evening");
                        dtnewrmks.Columns.Add("Night");
                        dtnewrmks.Columns.Add("CreatedBy");

                        for (int m = 0; m <= dtdt.Rows.Count - 1; m++)
                        {
                            DataRow drnewrmks = dtnewrmks.NewRow();
                            drnewrmks["Date"] = GeneralFunction.GetDate(dtdt.Rows[m]["CHKLSTDT"].ToString());
                            dtnewrmks.Rows.Add(drnewrmks);
                        }

                        for (int n = 0; n <= dtnewrmks.Rows.Count - 1; n++)
                        {
                            for (int m = 0; m <= dtrmks.Rows.Count - 1; m++)
                            {
                                foreach (DataColumn column in dtnewrmks.Columns)
                                {
                                    //var cl = (column.ColumnName).Substring(0, (column.ColumnName).Length - 1);
                                    var shift = (column.ColumnName).Substring(0, 1);

                                    if (dtnewrmks.Rows[n]["Date"].ToString().Trim() == GeneralFunction.GetDate(dtrmks.Rows[m]["CHKLSTDT"].ToString().Trim()) && dtrmks.Rows[m]["SHIFTTIME"].ToString().Trim() == shift)
                                    {
                                        if (shift == "M")
                                        {
                                            var rmks = dtrmks.Rows[m]["REMARKS"].ToString().Trim();
                                            var sht = dtrmks.Rows[m]["STAFFNAME"].ToString().Trim();
                                            if (rmks.Length > 0 && sht.Length > 0)
                                            {
                                                dtnewrmks.Rows[n]["Morning"] = dtrmks.Rows[m]["REMARKS"] + " - " + GeneralFunction.GetFstNameUserId(dtrmks.Rows[m]["STAFFNAME"].ToString().Trim());
                                            }
                                            else if (rmks.Length == 0)
                                            {
                                                dtnewrmks.Rows[n]["Morning"] = GeneralFunction.GetFstNameUserId(dtrmks.Rows[m]["STAFFNAME"].ToString().Trim());
                                            }

                                        }

                                        else if (shift == "E")
                                        {
                                            var rmks = dtrmks.Rows[m]["REMARKS"].ToString().Trim();
                                            var sht = dtrmks.Rows[m]["STAFFNAME"].ToString().Trim();
                                            if (rmks.Length > 0 && sht.Length > 0)
                                            {
                                                dtnewrmks.Rows[n]["Evening"] = dtrmks.Rows[m]["REMARKS"] + " - " + GeneralFunction.GetFstNameUserId(dtrmks.Rows[m]["STAFFNAME"].ToString().Trim());
                                            }
                                            else if (rmks.Length == 0)
                                            {
                                                dtnewrmks.Rows[n]["Evening"] = GeneralFunction.GetFstNameUserId(dtrmks.Rows[m]["STAFFNAME"].ToString().Trim());
                                            }
                                        }

                                        else if (shift == "N")
                                        {
                                            var rmks = dtrmks.Rows[m]["REMARKS"].ToString().Trim();
                                            var sht = dtrmks.Rows[m]["STAFFNAME"].ToString().Trim();
                                            if (rmks.Length > 0 && sht.Length > 0)
                                            {
                                                dtnewrmks.Rows[n]["Night"] = dtrmks.Rows[m]["REMARKS"] + " - " + GeneralFunction.GetFstNameUserId(dtrmks.Rows[m]["STAFFNAME"].ToString().Trim());
                                            }
                                            else if (rmks.Length == 0)
                                            {
                                                dtnewrmks.Rows[n]["Night"] = GeneralFunction.GetFstNameUserId(dtrmks.Rows[m]["STAFFNAME"].ToString().Trim());
                                            }
                                        }


                                        dtnewrmks.Rows[n]["CreatedBy"] = GeneralFunction.GetFstNameUserId(dtrmks.Rows[m]["CREATEDBY"].ToString().Trim());
                                    }
                                }

                            }
                        }

                    }
                }
                else
                {
                    dtnewrmks.TableName = "PerphlRemarks";
                    dtnewrmks.Columns.Add("Date");
                    dtnewrmks.Columns.Add("Morning");
                    dtnewrmks.Columns.Add("Evening");
                    dtnewrmks.Columns.Add("Night");
                    dtnewrmks.Columns.Add("CreatedBy");
                }

                dt1.TableName = "PatInfoNursgNotes";
                if (load.Tables.Count > 0)
                {
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("strUIPNo");
                        dt1.Columns.Add("strUMrNo");
                        dt1.Columns.Add("strUAdmDtTm");
                        dt1.Columns.Add("strUName");
                        dt1.Columns.Add("strUTariffCat");
                        dt1.Columns.Add("strUOccuBedCat");
                        dt1.Columns.Add("strUAgeGender");
                        dt1.Columns.Add("strUPatCat");
                        dt1.Columns.Add("strUBillBedCat");
                        dt1.Columns.Add("strUBedward");
                        dt1.Columns.Add("strUNurstSta");
                        dt1.Columns.Add("strUAdmDr");
                        dt1.Columns.Add("strUConsDr");
                        dt1.Columns.Add("strUExempCat");
                        dt1.Columns.Add("strUInshuComp");
                        dt1.Columns.Add("strEmpID");
                        dt1.Columns.Add("strUCrdComp");
                        dt1.Columns.Add("strBundletype");
                        DataRow patRow = dt1.NewRow();
                        patRow["strUIPNo"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["strUMrNo"] = dt.Rows[0]["MRNO"].ToString();
                        patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString()) + "   " + GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["strUName"] = dt.Rows[0]["SALUNAME"].ToString() + "  " + dt.Rows[0]["PATNAME"].ToString();
                        patRow["strUTariffCat"] = dt.Rows[0]["TARIFFDESC"].ToString();
                        patRow["strUOccuBedCat"] = dt.Rows[0]["OCCUBEDCATGNM"].ToString();
                        patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + "   " + dt.Rows[0]["Gender"].ToString();
                        patRow["strUPatCat"] = dt.Rows[0]["PATCATGNM"].ToString();
                        patRow["strUBillBedCat"] = dt.Rows[0]["BLBEDCATGNM"].ToString();
                        patRow["strUBedward"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["strUNurstSta"] = dt.Rows[0]["NURSTNM"].ToString();
                        patRow["strUAdmDr"] = dt.Rows[0]["ADMNDOCTNM"].ToString();
                        patRow["strUConsDr"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["strUExempCat"] = dt.Rows[0]["EXEMPNM"].ToString();
                        patRow["strUInshuComp"] = dt.Rows[0]["INSURCMPNM"].ToString();
                        patRow["strEmpID"] = "";
                        patRow["strUCrdComp"] = dt.Rows[0]["COMPNAME"].ToString();
                        patRow["strBundletype"] = "";
                        dt1.Rows.Add(patRow);
                    }

                    if (finalperipheral.Rows.Count > 0)
                    {
                        finalperipheral.Columns[2].ColumnName = "Column1M";
                        finalperipheral.Columns[3].ColumnName = "Column1E";
                        finalperipheral.Columns[4].ColumnName = "Column1N";
                        finalperipheral.Columns[5].ColumnName = "Column2M";
                        finalperipheral.Columns[6].ColumnName = "Column2E";
                        finalperipheral.Columns[7].ColumnName = "Column2N";
                        finalperipheral.Columns[8].ColumnName = "Column3M";
                        finalperipheral.Columns[9].ColumnName = "Column3E";
                        finalperipheral.Columns[10].ColumnName = "Column3N";
                        finalperipheral.Columns[11].ColumnName = "Column4M";
                        finalperipheral.Columns[12].ColumnName = "Column4E";
                        finalperipheral.Columns[13].ColumnName = "Column4N";
                        finalperipheral.Columns[14].ColumnName = "Column5M";
                        finalperipheral.Columns[15].ColumnName = "Column5E";
                        finalperipheral.Columns[16].ColumnName = "Column5N";
                    }

                    dtDate.TableName = "PDate";
                    dtproc.TableName = "PProcedure";
                    dsFinalForPrint.Tables.Add(dt1);
                    dsFinalForPrint.Tables.Add(finalperipheral);
                    dsFinalForPrint.Tables.Add(dtDate);

                    HData = GeneralFunction.getHeaderFooter("Daily Assessment of Fall Risk", "", "", "");
                    string strFrmDt = GeneralFunction.GetDate(strDate);
                    string strToDts = GeneralFunction.GetDate(strToDt);
                    HData.TableName = "HeaderFooter";
                    if (strFrmDt == strToDate)
                        HData.Rows[0]["ForDate"] = "On " + strFrmDt;
                    else
                        HData.Rows[0]["ForDate"] = "From " + strFrmDt + " To " + strToDts;
                    HData.Columns.Remove("Duplicate");
                    dsFinalForPrint.Tables.Add(HData);
                    dsFinalForPrint.Tables.Add(dtproc);
                    dsFinalForPrint.Tables.Add(dtnewrmks);
                }
            }
            return dsFinalForPrint;
        }

        //added by vishal on 2nd July 2019
        public DataSet GetPainMonitoringChart(string strIPNo, string strDate, string strToDt, string strPatStatus)
        {
            ICUClient icuClient = new ICUClient();
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet ds = new DataSet();
            DataSet finalDsToSend = new DataSet();
            DataTable HData = new DataTable();
            DataTable dtPatInfo = new DataTable();
            DataTable dtPainChart = new DataTable();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            if (dsPatInfo.Tables.Count > 0)
            {
                dtPatInfo.TableName = "PatInfo";
                dtPatInfo.Columns.Add("IPNO");
                dtPatInfo.Columns.Add("MRNO");
                dtPatInfo.Columns.Add("ADMNDATE");
                dtPatInfo.Columns.Add("PATNAME");
                dtPatInfo.Columns.Add("ADMNTIME");
                dtPatInfo.Columns.Add("Gender");
                dtPatInfo.Columns.Add("PATAGE");
                dtPatInfo.Columns.Add("CONSDOCT");
                dtPatInfo.Columns.Add("SALUNAME");
                dtPatInfo.Columns.Add("CURRBEDNO");
                dtPatInfo.Columns.Add("WARDNM");
                dtPatInfo.Columns.Add("NURSTNM");
                dtPatInfo.Columns.Add("DATE");
                dtPatInfo.Columns.Add("TIME");
                dtPatInfo.Columns.Add("CNAME");
                dtPatInfo.Columns.Add("TOMOROWDATE");
                DataRow patRow = dtPatInfo.NewRow();
                patRow["IPNO"] = dsPatInfo.Tables[0].Rows[0]["IPNO"].ToString();
                patRow["MRNO"] = dsPatInfo.Tables[0].Rows[0]["MRNO"].ToString();
                patRow["ADMNDATE"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString());
                patRow["PATNAME"] = dsPatInfo.Tables[0].Rows[0]["PATNAME"].ToString();
                //patRow["ADMNTIME"] = dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString();
                patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString());
                patRow["Gender"] = dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                patRow["PATAGE"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString();
                patRow["CONSDOCT"] = dsPatInfo.Tables[0].Rows[0]["CONSDOCT"].ToString();
                patRow["CURRBEDNO"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString();
                patRow["WARDNM"] = dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString();
                patRow["NURSTNM"] = dsPatInfo.Tables[0].Rows[0]["NURSTNM"].ToString();
                patRow["SALUNAME"] = dsPatInfo.Tables[0].Rows[0]["SALUNAME"].ToString();
                patRow["DATE"] = strDate;
                patRow["TIME"] = "";
                patRow["CNAME"] = "";
                patRow["TOMOROWDATE"] = strToDt;
                dtPatInfo.Rows.Add(patRow);
            }

            HData = GeneralFunction.getHeaderFooter("Pain Monitoring Chart", "", "", "");
            HData.TableName = "HeaderFooter";
            HData.Columns.Remove("Duplicate");
            object[] obj = new object[1];
            var frmDt = "";
            var toDt = "";
            frmDt = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            toDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            string str = icuClient.GetPainMonitorChart(strIPNo, frmDt, toDt, strPatStatus);

            ds.ReadXml(new XmlTextReader(new StringReader(str)));
            if (ds.Tables.Count > 0)
            {
                dtPainChart = ds.Tables[0];
                dtPainChart.Columns.Add("PainChartWithDtTime");
                if (dtPainChart.Rows.Count > 0)
                {
                    for (int i = 0; i <= dtPainChart.Rows.Count - 1; i++)
                    {
                        dtPainChart.Rows[i]["SADATE"] = GeneralFunction.GetDate(dtPainChart.Rows[i]["SADATE"].ToString());
                        //dtPainChart.Rows[i]["PaintChartWithDtTime"] = dtPainChart.Rows[i]["SADATE"].ToString() + "       " + dtPainChart.Rows[i]["SATIME"].ToString() + "       " + dtPainChart.Rows[i]["BRADENSCORE"].ToString() + "                     " + dtSkinAssmnt.Rows[i]["level"].ToString();
                        dtPainChart.Rows[i]["PainChartWithDtTime"] = dtPainChart.Rows[i]["SADATE"].ToString() + "     " +
                            dtPainChart.Rows[i]["SATIME"].ToString() + "     " + dtPainChart.Rows[i]["TYPEOFPAIN"].ToString() + "        " +
                              dtPainChart.Rows[i]["PAINLOCATION"].ToString() + "        " + dtPainChart.Rows[i]["WONGBAKSCALE"].ToString() + "        " +
                            dtPainChart.Rows[i]["INTENSITY"].ToString() + "        " + dtPainChart.Rows[i]["VISUALANALOGSCALE"].ToString() + "        "
                            + dtPainChart.Rows[i]["INTENSITYVAS"].ToString();
                        //dtPainChart.Rows[i]["CREATEDBY"] = dtPainChart.Rows[i]["CREATEDBY"].Equals(dtPainChart.Rows[i]["VERIFIEDBY"]) ? GeneralFunction.GetFstNameUserId(dtPainChart.Rows[i]["CREATEDBY"].ToString().Trim()) : GeneralFunction.GetFstNameUserId(dtPainChart.Rows[i]["CREATEDBY"].ToString().Trim()) + " / " + GeneralFunction.GetFstNameUserId(dtPainChart.Rows[i]["VERIFIEDBY"].ToString().Trim());
                        string userId = dtPainChart.Rows[i]["CREATEDBY"].ToString().Trim();
                        string verifiedBy = dtPainChart.Rows[i]["VERIFIEDBY"].ToString().Trim();
                        if (string.IsNullOrEmpty(verifiedBy))
                        {
                            dtPainChart.Rows[i]["CREATEDBY"] = GeneralFunction.GetFstNameUserId(userId);
                        }
                        else
                        {
                            dtPainChart.Rows[i]["CREATEDBY"] = GeneralFunction.GetFstNameUserId(userId) + "/" + GeneralFunction.GetFstNameUserId(verifiedBy);
                        }
                    }
                    var characterpainLst = GeneralFunction.GetCharacterOfPainList();
                    foreach (DataRow row in dtPainChart.Rows)
                    {

                        row["CHAROFPAIN"] = GeneralFunction.GetListValue(characterpainLst, row["CHAROFPAIN"].ToString().Trim());

                    }
                    dtPainChart.TableName = "PainChart";
                }
                else
                {
                    return null;
                }

            }
            else
            {
                return null;
            }
            //ds.Tables.Add(dtSkinAssmnt);
            ds.Tables.Add(dtPatInfo.Copy());
            ds.Tables.Add(HData);
            return ds;
        }

        public DataSet GetHourlyMonitoringChart(string strIPNo, string strDate, string strToDt)
        {
            ICUClient icuClient = new ICUClient();
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet ds = new DataSet();
            DataSet finalDsToSend = new DataSet();
            DataTable HData = new DataTable();
            DataTable dtPatInfo = new DataTable();
            DataTable dtHourlyChart = new DataTable();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            if (dsPatInfo.Tables.Count > 0)
            {
                dtPatInfo.TableName = "PatInfo";
                dtPatInfo.Columns.Add("IPNO");
                dtPatInfo.Columns.Add("MRNO");
                dtPatInfo.Columns.Add("ADMNDATE");
                dtPatInfo.Columns.Add("PATNAME");
                dtPatInfo.Columns.Add("ADMNTIME");
                dtPatInfo.Columns.Add("Gender");
                dtPatInfo.Columns.Add("PATAGE");
                dtPatInfo.Columns.Add("CONSDOCT");
                dtPatInfo.Columns.Add("SALUNAME");
                dtPatInfo.Columns.Add("CURRBEDNO");
                dtPatInfo.Columns.Add("WARDNM");
                dtPatInfo.Columns.Add("NURSTNM");
                dtPatInfo.Columns.Add("DATE");
                dtPatInfo.Columns.Add("TIME");
                dtPatInfo.Columns.Add("CNAME");
                dtPatInfo.Columns.Add("TOMOROWDATE");
                //Added By Priyanka on 17/06/2025
                dtPatInfo.Columns.Add("HEIGHT");
                dtPatInfo.Columns.Add("WEIGHT");
                dtPatInfo.Columns.Add("BMI");
                dtPatInfo.Columns.Add("BSA");
                //End
                DataRow patRow = dtPatInfo.NewRow();
                patRow["IPNO"] = dsPatInfo.Tables[0].Rows[0]["IPNO"].ToString();
                patRow["MRNO"] = dsPatInfo.Tables[0].Rows[0]["MRNO"].ToString();
                patRow["ADMNDATE"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString());
                patRow["PATNAME"] = dsPatInfo.Tables[0].Rows[0]["PATNAME"].ToString();
                patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString());
                patRow["Gender"] = dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                patRow["PATAGE"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString();
                patRow["CONSDOCT"] = dsPatInfo.Tables[0].Rows[0]["CONSDOCT"].ToString();
                patRow["CURRBEDNO"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString();
                patRow["WARDNM"] = dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString();
                patRow["NURSTNM"] = dsPatInfo.Tables[0].Rows[0]["NURSTNM"].ToString();
                patRow["SALUNAME"] = dsPatInfo.Tables[0].Rows[0]["SALUNAME"].ToString();
                patRow["DATE"] = strDate;
                patRow["TIME"] = "";
                patRow["CNAME"] = "";
                patRow["TOMOROWDATE"] = strToDt;
                dtPatInfo.Rows.Add(patRow);
            }

            HData = GeneralFunction.getHeaderFooter("Hourly Monitoring Chart", "", "", "");
            HData.TableName = "HeaderFooter";
            HData.Columns.Remove("Duplicate");
            object[] obj = new object[1];
            var frmDt = "";
            var toDt = "";
            frmDt = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            toDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            string str = icuClient.GetHourMonitorChart(strIPNo, frmDt, toDt);
            var isIcu = HttpContext.Current.Session["ICUNSYN"].ToString();

            ds.ReadXml(new XmlTextReader(new StringReader(str)));
            if (ds.Tables.Count > 0)
            {
                dtHourlyChart = ds.Tables[0];
                dtHourlyChart.Columns.Add("PMIN");
                dtHourlyChart.Columns.Add("ISICUYN");

                if (isIcu == "D")
                {
                    dtHourlyChart.Columns.Remove("MEWSSCORE");
                }
                if (dtHourlyChart.Rows.Count > 0)
                {
                    //Added By Priyanka on 17/06/2025
                    string HEIGHT = dtHourlyChart.Columns.Contains("HEIGHT") ? dtHourlyChart.Rows[0]["HEIGHT"].ToString() : "";
                    string WEIGHT = dtHourlyChart.Columns.Contains("HEIGHT") ? dtHourlyChart.Rows[0]["WEIGHT"].ToString() : "";
                    string BMI = dtHourlyChart.Columns.Contains("BMI") ? dtHourlyChart.Rows[0]["BMI"].ToString() : "";
                    string BSA = dtHourlyChart.Columns.Contains("BSA") ? dtHourlyChart.Rows[0]["BSA"].ToString() : "";
                    if (dtPatInfo.Rows.Count > 0)
                    {
                        dtPatInfo.Rows[0]["HEIGHT"] = HEIGHT;
                        dtPatInfo.Rows[0]["WEIGHT"] = WEIGHT;
                        dtPatInfo.Rows[0]["BMI"] = BMI;
                        dtPatInfo.Rows[0]["BSA"] = BSA;
                    }
                    //End

                    for (int i = 0; i <= dtHourlyChart.Rows.Count - 1; i++)
                    {
                        dtHourlyChart.Rows[i]["CA1DATE"] = GeneralFunction.GetDate(dtHourlyChart.Rows[i]["CA1DATE"].ToString());
                        dtHourlyChart.Rows[i]["PMIN"] = dtHourlyChart.Rows[i]["PATINTRNSCRT"].ToString().Trim().Length > 0 ? dtHourlyChart.Rows[i]["PATINTRNSCRT"].ToString() : dtHourlyChart.Rows[i]["PACEDRT"].ToString();
                        dtHourlyChart.Rows[i]["CREATEDBY"] = GeneralFunction.GetFstNameUserId(dtHourlyChart.Rows[i]["CREATEDBY"].ToString().Trim());
                        dtHourlyChart.Rows[i]["ISICUYN"] = isIcu;
                    }
                    dtHourlyChart.TableName = "HourlyChart";
                }
                else
                {
                    return null;
                }

            }
            else
            {
                return null;
            }
            //ds.Tables.Add(dtSkinAssmnt);
            ds.Tables.Add(dtPatInfo.Copy());
            ds.Tables.Add(HData);
            return ds;
        }

        //added by vishal 17th June 2019
        public DataSet GetPhysicalRestraintsData(string strIPNo)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable dtphysicl = new DataTable();
            dtphysicl.TableName = "PHYSCLRESTRNTS";
            DataTable HData = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            DataTable dt1 = new DataTable();
            DataTable dt = new DataTable();
            DataTable dtfirst = new DataTable();
            DataTable dtsecond = new DataTable();
            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetPhyRestrdata(strIPNo))));
            object[] obj = new object[1];

            if (load == null)
            {
                obj[0] = "";
            }
            else
            {

                if (load.Tables.Count > 0)
                {
                    if (load.Tables.Contains("Table"))
                    {
                        dtfirst = load.Tables["Table"].Copy();
                        if (dtfirst.Rows.Count > 0)
                        {

                            dtfirst.TableName = "PhysclHead";
                            for (int i = 0; i <= dtfirst.Rows.Count - 1; i++)
                            {
                                dtfirst.Rows[i]["APPLDT"] = GeneralFunction.GetDate(dtfirst.Rows[i]["APPLDT"].ToString());
                                dtfirst.Rows[i]["DISCONTDT"] = GeneralFunction.GetDate(dtfirst.Rows[i]["DISCONTDT"].ToString());
                                dtfirst.Rows[i]["CREATEDON"] = GeneralFunction.GetDate(dtfirst.Rows[i]["CREATEDON"].ToString());
                                dtfirst.Rows[i]["DISCONTON"] = GeneralFunction.GetDate(dtfirst.Rows[i]["DISCONTON"].ToString());
                                dtfirst.Rows[i]["CREATEDBY"] = GeneralFunction.GetFstNameUserId(dtfirst.Rows[i]["CREATEDBY"].ToString());
                                dtfirst.Rows[i]["DISCONTBY"] = GeneralFunction.GetFstNameUserId(dtfirst.Rows[i]["DISCONTBY"].ToString());
                            }
                            dsFinalForPrint.Tables.Add(dtfirst);
                        }
                    }

                    if (load.Tables.Contains("Table1"))
                    {
                        dtsecond = load.Tables["Table1"].Copy();
                        if (dtsecond.Rows.Count > 0)
                        {
                            dtsecond.TableName = "PhysclDetails";
                            for (int i = 0; i <= dtsecond.Rows.Count - 1; i++)
                            {
                                dtsecond.Rows[i]["DATE"] = GeneralFunction.GetDate(dtsecond.Rows[i]["DATE"].ToString());
                                dtsecond.Rows[i]["SKINCOND"] = dtsecond.Rows[i]["SKINCOND"].ToString() == "C" ? "Cold" : dtsecond.Rows[i]["SKINCOND"].ToString() == "W" ? "Warm" : "";
                                dtsecond.Rows[i]["ROM"] = dtsecond.Rows[i]["ROM"].ToString() == "N" ? "Normal" : dtsecond.Rows[i]["ROM"].ToString() == "R" ? "Restricted" : dtsecond.Rows[i]["ROM"].ToString() == "P" ? "Painful" : "";
                            }
                            dsFinalForPrint.Tables.Add(dtsecond);


                        }
                    }
                }



                dt1.TableName = "PatInfoNursgNotes";
                if (load.Tables.Count > 0)
                {
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        dt = dsPatInfo.Tables[0];

                        dt1.Columns.Add("strUIPNo");
                        dt1.Columns.Add("strUMrNo");
                        dt1.Columns.Add("strUAdmDtTm");
                        dt1.Columns.Add("strUName");
                        dt1.Columns.Add("strUTariffCat");
                        dt1.Columns.Add("strUOccuBedCat");
                        dt1.Columns.Add("strUAgeGender");
                        dt1.Columns.Add("strUPatCat");
                        dt1.Columns.Add("strUBillBedCat");
                        dt1.Columns.Add("strUBedward");
                        dt1.Columns.Add("strUNurstSta");
                        dt1.Columns.Add("strUAdmDr");
                        dt1.Columns.Add("strUConsDr");
                        dt1.Columns.Add("strUExempCat");
                        dt1.Columns.Add("strUInshuComp");
                        dt1.Columns.Add("strEmpID");
                        dt1.Columns.Add("strUCrdComp");
                        dt1.Columns.Add("strBundletype");
                        DataRow patRow = dt1.NewRow();
                        patRow["strUIPNo"] = dt.Rows[0]["IPNO"].ToString();
                        patRow["strUMrNo"] = dt.Rows[0]["MRNO"].ToString();
                        //patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString()) + "   " + dt.Rows[0]["ADMNTIME"].ToString();
                        patRow["strUAdmDtTm"] = GeneralFunction.GetDate(dt.Rows[0]["ADMNDATE"].ToString()) + " / " + GeneralFunction.ConvertTo12HourFormat(dt.Rows[0]["ADMNTIME"].ToString());
                        patRow["strUName"] = dt.Rows[0]["SALUNAME"].ToString() + "  " + dt.Rows[0]["PATNAME"].ToString();
                        patRow["strUTariffCat"] = dt.Rows[0]["TARIFFDESC"].ToString();
                        patRow["strUOccuBedCat"] = dt.Rows[0]["OCCUBEDCATGNM"].ToString();
                        //patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + "   " + dt.Rows[0]["Gender"].ToString();
                        patRow["strUAgeGender"] = dt.Rows[0]["PATAGE"].ToString() + " / " + dt.Rows[0]["Gender"].ToString();
                        patRow["strUPatCat"] = dt.Rows[0]["PATCATGNM"].ToString();
                        patRow["strUBillBedCat"] = dt.Rows[0]["BLBEDCATGNM"].ToString();
                        patRow["strUBedward"] = dt.Rows[0]["WARDNM"].ToString();
                        patRow["strUNurstSta"] = dt.Rows[0]["NURSTNM"].ToString();
                        patRow["strUAdmDr"] = dt.Rows[0]["ADMNDOCTNM"].ToString();
                        patRow["strUConsDr"] = dt.Rows[0]["CONSDOCT"].ToString();
                        patRow["strUExempCat"] = dt.Rows[0]["EXEMPNM"].ToString();
                        patRow["strUInshuComp"] = dt.Rows[0]["INSURCMPNM"].ToString();
                        patRow["strEmpID"] = "";
                        patRow["strUCrdComp"] = dt.Rows[0]["COMPNAME"].ToString();
                        patRow["strBundletype"] = "";
                        dt1.Rows.Add(patRow);
                    }


                    dsFinalForPrint.Tables.Add(dt1);
                    HData = GeneralFunction.getHeaderFooter("Physical Restraints Monitoring Sheet", "", "", "");
                    HData.TableName = "HeaderFooter";
                    HData.Columns.Remove("Duplicate");
                    dsFinalForPrint.Tables.Add(HData);

                }
            }
            return dsFinalForPrint;
        }

        //added by vishal 12the Feb 2020
        public DataSet GetApacheIIScoreData(string strIPNo, string strDate, string strAgeInYear)
        {
            //CommonServiceClient comclient = new CommonServiceClient();
            DataSet load = new DataSet();
            DataTable HData = new DataTable();
            DataSet dsFinalForPrint = new DataSet();
            DataTable dt1 = new DataTable();
            DataTable dt = new DataTable();
            DataTable dtApacheDet = new DataTable();
            DataTable dtClincalDet = new DataTable();
            DataTable dtCritical = new DataTable();
            DataTable dtInvestg = new DataTable();

            GeneralFunction gen = new GeneralFunction();
            DataSet dsPatInfo = gen.GetIPPatInfo1(strIPNo, "", "", "", "", "", "", "", "", "", "", "", "", "");

            strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            Int32 AgeInYear = Convert.ToInt32(strAgeInYear.Substring(0, strAgeInYear.IndexOf(':')));
            load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetApacheIIScoreRptData(strIPNo, strDate, AgeInYear))));
            object[] obj = new object[1];

            if (load == null)
            {
                obj[0] = "";
            }
            else
            {

                if (load.Tables.Count > 0)
                {
                    if (load.Tables.Contains("ApacheDet"))
                    {
                        dtApacheDet = load.Tables["ApacheDet"].Copy();
                        if (dtApacheDet.Rows.Count > 0)
                        {
                            dtApacheDet.TableName = "ApacheDet";

                            dsFinalForPrint.Tables.Add(dtApacheDet);
                        }
                        else
                        {
                            obj[0] = "";
                            return dsFinalForPrint;
                        }
                    }
                    else
                    {
                        obj[0] = "";
                        return dsFinalForPrint;
                    }

                    if (load.Tables.Contains("ClinicalDet"))
                    {
                        dtClincalDet = load.Tables["ClinicalDet"].Copy();
                        if (dtClincalDet.Rows.Count > 0)
                        {
                            dtClincalDet.TableName = "ApacheClinicalDet";
                            dsFinalForPrint.Tables.Add(dtClincalDet);
                        }
                    }
                    else
                    {
                        dtClincalDet.TableName = "ApacheClinicalDet";
                        dtClincalDet.Columns.Add("RR");
                        dtClincalDet.Columns.Add("RRSCORE");
                        dtClincalDet.Columns.Add("O2DELIVERD");
                        dtClincalDet.Columns.Add("OXYFLOWRT");
                        dtClincalDet.Columns.Add("FIO2");
                        dtClincalDet.Columns.Add("FIO2SCORE");
                        dtClincalDet.Columns.Add("GCSSCORE");
                        dsFinalForPrint.Tables.Add(dtClincalDet);
                    }
                    if (load.Tables.Contains("CriticalAssmnt"))
                    {
                        dtCritical = load.Tables["CriticalAssmnt"].Copy();
                        if (dtCritical.Rows.Count > 0)
                        {
                            dtCritical.TableName = "ApacheCriticalAssmnt";
                            dsFinalForPrint.Tables.Add(dtCritical);
                        }
                    }
                    else
                    {
                        dtCritical.TableName = "ApacheCriticalAssmnt";
                        dtCritical.Columns.Add("TEMP");
                        dtCritical.Columns.Add("TEMPSCORE");
                        dtCritical.Columns.Add("HEARTRATE");
                        dtCritical.Columns.Add("HEARTRTSCORE");
                        dtCritical.Columns.Add("MAP");
                        dtCritical.Columns.Add("MAPSCORE");
                        dsFinalForPrint.Tables.Add(dtCritical);
                    }
                    if (load.Tables.Contains("InvestDet"))
                    {
                        dtInvestg = load.Tables["InvestDet"].Copy();
                        if (dtInvestg.Rows.Count > 0)
                        {
                            dtInvestg.TableName = "ApacheInvestDet";
                            dsFinalForPrint.Tables.Add(dtInvestg);
                        }
                    }
                    else
                    {
                        dtInvestg.TableName = "ApacheInvestDet";
                        dtInvestg.Columns.Add("INVESTDESC");
                        dtInvestg.Columns.Add("RESULTDT");
                        dtInvestg.Columns.Add("SCORE");
                        dtInvestg.Columns.Add("UNIT");
                        dsFinalForPrint.Tables.Add(dtInvestg);
                    }
                }

                dt.TableName = "PatInfo";
                if (dsPatInfo.Tables.Count > 0)
                {
                    if (dsPatInfo.Tables.Count > 0)
                    {
                        //dt = dsPatInfo.Tables[0];

                        dt.Columns.Add("IPNO");
                        dt.Columns.Add("MRNO");
                        dt.Columns.Add("ADMNDATE");
                        dt.Columns.Add("PATNAME");
                        dt.Columns.Add("ADMNTIME");
                        dt.Columns.Add("Gender");
                        dt.Columns.Add("PATAGE");
                        dt.Columns.Add("CONSDOCT");
                        dt.Columns.Add("SALUNAME");
                        dt.Columns.Add("CURRBEDNO");
                        dt.Columns.Add("WARDNM");
                        dt.Columns.Add("NURSTNM");
                        dt.Columns.Add("DATE");
                        dt.Columns.Add("TIME");
                        dt.Columns.Add("CNAME");
                        dt.Columns.Add("TOMOROWDATE");
                        dt.Columns.Add("MLCYORN");
                        DataRow patRow = dt.NewRow();
                        patRow["IPNO"] = dsPatInfo.Tables[0].Rows[0]["IPNO"].ToString();
                        patRow["MRNO"] = dsPatInfo.Tables[0].Rows[0]["MRNO"].ToString();
                        patRow["ADMNDATE"] = GeneralFunction.GetDate(dsPatInfo.Tables[0].Rows[0]["ADMNDATE"].ToString());
                        patRow["PATNAME"] = dsPatInfo.Tables[0].Rows[0]["PATNAME"].ToString();
                        patRow["ADMNTIME"] = GeneralFunction.ConvertTo12HourFormat(dsPatInfo.Tables[0].Rows[0]["ADMNTIME"].ToString());
                        patRow["Gender"] = dsPatInfo.Tables[0].Rows[0]["Gender"].ToString();
                        patRow["PATAGE"] = dsPatInfo.Tables[0].Rows[0]["PATAGE"].ToString();
                        patRow["CONSDOCT"] = dsPatInfo.Tables[0].Rows[0]["CONSDOCT"].ToString();
                        patRow["CURRBEDNO"] = dsPatInfo.Tables[0].Rows[0]["CURRBEDNO"].ToString();
                        patRow["WARDNM"] = dsPatInfo.Tables[0].Rows[0]["WARDNM"].ToString();
                        patRow["NURSTNM"] = dsPatInfo.Tables[0].Rows[0]["NURSTNM"].ToString();
                        patRow["DATE"] = GeneralFunction.GetDate(strDate);
                        patRow["TIME"] = "";
                        patRow["CNAME"] = "";
                        patRow["TOMOROWDATE"] = "";
                        patRow["MLCYORN"] = dsPatInfo.Tables[0].Rows[0]["MLCYORN"].ToString();
                        dt.Rows.Add(patRow);
                    }

                    dsFinalForPrint.Tables.Add(dt);
                    HData = GeneralFunction.getHeaderFooter("Apache II Score", "", "", "");
                    HData.TableName = "HeaderFooter";
                    HData.Columns.Remove("Duplicate");
                    dsFinalForPrint.Tables.Add(HData);

                }


                // Adding Table in Dataset
                DataTable ApacheClinicalDet = new DataTable();
                DataTable ApacheDet = new DataTable();
                DataTable ApacheCriticalAssmnt = new DataTable();
                DataTable ApacheInvestDet = new DataTable();


                // ApacheClinicalDet1 DataTable
                ApacheClinicalDet.TableName = "ApacheClinicalDet1";
                ApacheClinicalDet.Columns.Add("RR");
                ApacheClinicalDet.Columns.Add("RRSCORE");
                ApacheClinicalDet.Columns.Add("O2DELIVERD");
                ApacheClinicalDet.Columns.Add("OXYFLOWRT");
                ApacheClinicalDet.Columns.Add("FIO2");
                ApacheClinicalDet.Columns.Add("FIO2SCORE");
                ApacheClinicalDet.Columns.Add("GCSSCORE");
                dsFinalForPrint.Tables.Add(ApacheClinicalDet);

                // ApacheDet1 DataTable
                ApacheDet.TableName = "ApacheDet1";
                ApacheDet.Columns.Add("HISTOFORGFAILYN");
                ApacheDet.Columns.Add("ARTRENALFAILYN");
                ApacheDet.Columns.Add("POSTOPYN");
                ApacheDet.Columns.Add("OPRPRIORITY");
                ApacheDet.Columns.Add("TRANDT");
                ApacheDet.Columns.Add("TRANTM");
                ApacheDet.Columns.Add("USERID");
                ApacheDet.Columns.Add("AGESCORE");
                ApacheDet.Columns.Add("HISTORGSCORE");
                ApacheDet.Columns.Add("AGE");
                dsFinalForPrint.Tables.Add(ApacheDet);

                // ApacheCriticalAssmnt1 DataTable
                ApacheCriticalAssmnt.TableName = "ApacheCriticalAssmnt1";
                ApacheCriticalAssmnt.Columns.Add("TEMP");
                ApacheCriticalAssmnt.Columns.Add("TEMPSCORE");
                ApacheCriticalAssmnt.Columns.Add("HEARTRATE");
                ApacheCriticalAssmnt.Columns.Add("HEARTRTSCORE");
                ApacheCriticalAssmnt.Columns.Add("MAP");
                ApacheCriticalAssmnt.Columns.Add("MAPSCORE");
                dsFinalForPrint.Tables.Add(ApacheCriticalAssmnt);

                // ApacheInvestDet1 DataTable
                ApacheInvestDet.TableName = "ApacheInvestDet1";
                ApacheInvestDet.Columns.Add("INVESTDESC");
                ApacheInvestDet.Columns.Add("RESULTDT");
                ApacheInvestDet.Columns.Add("SCORE");
                ApacheInvestDet.Columns.Add("UNIT");
                dsFinalForPrint.Tables.Add(ApacheInvestDet);

            }
            return dsFinalForPrint;
        }


        //Madhuri:- Changes Done to Fetch the list of the selected Ipno into the dropdown 
        public List<CommonSerRef.SelectLstItem> GetICUNurseNotes(string strIPNO, string strDate, string strToDt, string strTime, string strToTime, string strproblemcd, string CloseYN)
        {
            try
            {
                strDate = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
                strToDt = GeneralFunction.GetDateInSpecifiedFormat(strToDt, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

                DataSet load = new DataSet();
                ICUClient icuClient = new ICUClient();
                var userid = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString(); //HttpContext.Current.Session["UserID"].ToString();

                load.ReadXml(new XmlTextReader(new StringReader(icuClient.GetICUNurseNotes(strIPNO, strDate, userid, strToDt, strTime, strToTime, strproblemcd, CloseYN))));

                List<CommonSerRef.SelectLstItem> problemList = new List<CommonSerRef.SelectLstItem>();

                if (load.Tables.Count > 0)
                {
                    DataTable dt = load.Tables[0];

                    problemList = dt.AsEnumerable()
                    .GroupBy(row => new
                    {
                        Code = row["PROBCODE"].ToString(),
                        Text = row["PROBLEMTXT"].ToString()
                    })
                    .Select(g => new CommonSerRef.SelectLstItem
                    {
                        Value = g.Key.Code,   // PROBCODE as Value
                        Text = g.Key.Text    // PROBLEMTXT as Text
                    })
                    .ToList();
                }

                return problemList;
            }
            catch (Exception ex)
            {
                // Log error if needed
                return new List<CommonSerRef.SelectLstItem>();  // Return empty list in case of an error
            }
        }
        //Madhuri:- End Changes Done to Fetch the list of the selected Ipno into the dropdown 

        //added by Ashvini

        public string GenerateExcelReports(string strFrmDate, string strToDate, string IPNO)
        {
            ICUClient ic = new ICUClient();
            CommonServiceClient comm = new CommonServiceClient();
            string AllData = string.Empty;
            DataTable resultTable = new DataTable();
            String reportTitle = "Assesment Report";
            strFrmDate = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            strToDate = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);

            string xmlData = ic.GetAssmntlistForTAT(strFrmDate, strToDate);

            if (!string.IsNullOrEmpty(xmlData))
            {
                DataSet ds = new DataSet();
                using (StringReader stringReader = new StringReader(xmlData))
                {

                    ds.ReadXml(stringReader);
                    if (ds.Tables.Count > 0)
                    {
                        resultTable = ds.Tables[0];

                        resultTable.Columns.Add("PATIENT_ACCEPT_TAT", typeof(string));
                        resultTable.Columns.Add("IA_COMPLETION_TAT", typeof(string));
                        resultTable.Columns.Add("ADMN_COMPLETION_TAT", typeof(string));
                        resultTable.Columns.Add("OVERALL_TAT", typeof(string));

                        foreach (DataRow row in resultTable.Rows)
                        {
                            // 1. Patient Acceptance TAT: ACCEPTDT + PATACCEPTTM - ADMNDATE + ADMNTIME
                            DateTime? admitDT = ParseDateTime(row["ADMNDATE"], row["ADMNTIME"]);
                            DateTime? acceptedDT = ParseDateTime(row["ACCEPTDT"], row["PATACCEPTTM"]);
                            if (admitDT.HasValue && acceptedDT.HasValue)
                                row["PATIENT_ACCEPT_TAT"] = GetTimeDiff(admitDT.Value, acceptedDT.Value);

                            // 2. Initial Assessment Completion TAT: IASTARTDT + IASTARTTM to ASSMCOMPDT + INASCOMPTIME
                            DateTime? iaStart = ParseDateTime(row["IASTARTDT"], row["IASTARTTM"]);
                            DateTime? iaEnd = ParseDateTime(row["VERIFIEDON"], row["VERIFIEDAT"]);
                            if (iaStart.HasValue && iaEnd.HasValue)
                                row["IA_COMPLETION_TAT"] = GetTimeDiff(iaStart.Value, iaEnd.Value);

                            // 3. Admission Assessment Completion TAT: SECSTARTDT + SECSTARTTM to SECASMNDONEON + SECASMNDONEAT
                            DateTime? admnStart = ParseDateTime(row["SECSTARTDT"], row["SECSTARTTM"]);
                            DateTime? admnEnd = ParseDateTime(row["SECVERIFON"], row["SECVERIFAT"]);
                            if (admnStart.HasValue && admnEnd.HasValue)
                                row["ADMN_COMPLETION_TAT"] = GetTimeDiff(admnStart.Value, admnEnd.Value);

                            // 4. Overall TAT: ADMNDATE + ADMNTIME to SECASMNDONEON + SECASMNDONEAT
                            DateTime? OveralladmnStart = ParseDateTime(row["IASTARTDT"], row["IASTARTTM"]);
                            DateTime? OveralladmnEnd = ParseDateTime(row["SECVERIFON"], row["SECVERIFAT"]);
                            if (OveralladmnStart.HasValue && OveralladmnEnd.HasValue)
                                row["OVERALL_TAT"] = GetTimeDiff(OveralladmnStart.Value, OveralladmnEnd.Value);
                            //if (admitDT.HasValue && admnEnd.HasValue)
                            //    row["OVERALL_TAT"] = GetTimeDiff(admitDT.Value, admnEnd.Value);


                        }


                        // ✅ Format date columns BEFORE renaming
                        string[] dateColumns = { "ADMNDATE", "ACCEPTDT", "IASTARTDT", "ASSMCOMPDT", "VERIFIEDON", "SECSTARTDT", "SECASMNDONEON", "SECVERIFON" };

                        foreach (string colName in dateColumns)
                        {
                            if (resultTable.Columns.Contains(colName))
                            {
                                foreach (DataRow row in resultTable.Rows)
                                {
                                    string originalDate = row[colName].ToString();
                                    if (!string.IsNullOrWhiteSpace(originalDate))
                                    {
                                        row[colName] = GeneralFunction.GetDate(originalDate);
                                    }
                                }
                            }
                        }



                        // Format user ID columns to usernames
                        string[] userIdColumns = { "ACCEPTEDBY", "INASSMNTDONEBY", "VERIFIEDBY", "SECASMNDONEBY", "SECVERIFBY" };

                        foreach (string colName in userIdColumns)
                        {
                            if (resultTable.Columns.Contains(colName))
                            {
                                foreach (DataRow row in resultTable.Rows)
                                {
                                    string userId = row[colName].ToString();
                                    if (!string.IsNullOrWhiteSpace(userId))
                                    {
                                        row[colName] = GeneralFunction.GetUserName(userId.ToString().Trim());
                                    }
                                }
                            }
                        }


                        resultTable.Columns["PATNAME"].ColumnName = "Patient Name";
                        resultTable.Columns["MRNO"].ColumnName = "MR No.";
                        resultTable.Columns["IPNO"].ColumnName = "IP No.";
                        resultTable.Columns["PATAGE"].ColumnName = "Age";
                        resultTable.Columns["GENDER"].ColumnName = "Gender";
                        resultTable.Columns["DOCTNAME"].ColumnName = "Admitting Doctor";
                        resultTable.Columns["WARDNM"].ColumnName = "Ward";
                        resultTable.Columns["ADMNBEDNO"].ColumnName = "Bed No.";
                        resultTable.Columns["ADMNDATE"].ColumnName = "Admission Date";
                        resultTable.Columns["ADMNTIME"].ColumnName = "Admission Time";
                        resultTable.Columns["ACCEPTDT"].ColumnName = "Patient Accepted Date (at NS)";
                        resultTable.Columns["PATACCEPTTM"].ColumnName = "Patient Accepted Time (at NS)";
                        resultTable.Columns["ACCEPTEDBY"].ColumnName = "Patient Accepted By";
                        resultTable.Columns["IASTARTDT"].ColumnName = "Initial Assessment(Part I) Start Date";
                        resultTable.Columns["IASTARTTM"].ColumnName = "Initial Assessment(Part I) Start Time";
                        resultTable.Columns["ASSMCOMPDT"].ColumnName = "Initial Assessment(Part I) End Date";
                        resultTable.Columns["INASCOMPTIME"].ColumnName = "Initial Assessment(Part I) End Time";
                        resultTable.Columns["INASSMNTDONEBY"].ColumnName = "Initial Assessment(Part I) Completed By";
                        resultTable.Columns["VERIFIEDON"].ColumnName = "Initial Assessment(Part I) Verifed Date";
                        resultTable.Columns["VERIFIEDAT"].ColumnName = "Initial Assessment(Part I) Verifed Time";
                        resultTable.Columns["VERIFIEDBY"].ColumnName = "Initial Assessment(Part I) Verified By";
                        resultTable.Columns["SECSTARTDT"].ColumnName = "Admission Assessment (Part II) Start Date ";
                        resultTable.Columns["SECSTARTTM"].ColumnName = "Admission Assessment (Part II) Start Time";
                        resultTable.Columns["SECASMNDONEON"].ColumnName = "Admission Assessment (Part II) End Date";
                        resultTable.Columns["SECASMNDONEAT"].ColumnName = "Admission Assessment (Part II) End Time";
                        resultTable.Columns["SECASMNDONEBY"].ColumnName = "Admission Assessment (Part II) Completed By";
                        resultTable.Columns["SECVERIFON"].ColumnName = "Admission Assessment (Part II) Verifed Date";
                        resultTable.Columns["SECVERIFAT"].ColumnName = "Admission Assessment (Part II) Verifed Time";
                        resultTable.Columns["SECVERIFBY"].ColumnName = "Admission Assessment (Part II) Verified By";
                        resultTable.Columns["PATIENT_ACCEPT_TAT"].ColumnName = "TAT of Patient Acceptance at NS";
                        resultTable.Columns["IA_COMPLETION_TAT"].ColumnName = "TAT of Initial Assessment (Part I) Completion";
                        resultTable.Columns["ADMN_COMPLETION_TAT"].ColumnName = "TAT of Admission Assessment (Part II) Completion";
                        resultTable.Columns["OVERALL_TAT"].ColumnName = "Overall TAT";

                        // Explicitly reorder columns as per required output
                        string[] finalColumnOrder = {
                    "Patient Name", "MR No.", "IP No.", "Age", "Gender", "Admitting Doctor", "Ward", "Bed No.",
                    "Admission Date", "Admission Time", "Patient Accepted Date (at NS)", "Patient Accepted Time (at NS)", "Patient Accepted By",
                    "Initial Assessment(Part I) Start Date", "Initial Assessment(Part I) Start Time", "Initial Assessment(Part I) End Date", "Initial Assessment(Part I) End Time",
                    "Initial Assessment(Part I) Completed By", "Initial Assessment(Part I) Verifed Date", "Initial Assessment(Part I) Verifed Time", "Initial Assessment(Part I) Verified By",
                    "Admission Assessment (Part II) Start Date ", "Admission Assessment (Part II) Start Time", "Admission Assessment (Part II) End Date", "Admission Assessment (Part II) End Time",
                    "Admission Assessment (Part II) Completed By", "Admission Assessment (Part II) Verifed Date", "Admission Assessment (Part II) Verifed Time", "Admission Assessment (Part II) Verified By",
                    "TAT of Patient Acceptance at NS", "TAT of Initial Assessment (Part I) Completion", "TAT of Admission Assessment (Part II) Completion", "Overall TAT"
                };

                        for (int i = 0; i < finalColumnOrder.Length; i++)
                        {
                            resultTable.Columns[finalColumnOrder[i]].SetOrdinal(i);
                        }

                    }
                }
            }

            AllData = GeneralFunction.getHeaderFooterExcel(
                reportTitle,
                "", "", "", "",
                resultTable
            );

            return AllData;
        }

        private DateTime? ParseDateTime(object dateObj, object timeObj)
        {
            try
            {
                string dateStr = dateObj.ToString().Trim();
                string timeStr = timeObj.ToString().Trim();

                if (string.IsNullOrWhiteSpace(dateStr) || string.IsNullOrWhiteSpace(timeStr))
                    return null;

                // Convert time to 24-hour format using your function
                timeStr = GeneralFunction.ConvertTo24HourFormat(timeStr);

                // Parse date in "yyyyMMdd" format
                DateTime date = DateTime.ParseExact(dateStr, "yyyyMMdd", CultureInfo.InvariantCulture);

                // Parse time in "HH:mm:ss" format (converted)
                TimeSpan time = TimeSpan.Parse(timeStr);

                return date.Add(time);
            }
            catch
            {
                return null;
            }
        }


        private string GetTimeDiff(DateTime start, DateTime end)
        {
            TimeSpan diff = end - start;

            int days = diff.Days;
            int hours = diff.Hours;
            int minutes = diff.Minutes;
            int seconds = diff.Seconds;

            List<string> parts = new List<string>();

            if (days > 0)
                parts.Add(days + " day(s)");

            if (hours > 0 || days > 0) // show hours if days is shown or hours > 0
                parts.Add(hours + "H");

            if (minutes > 0 || hours > 0 || days > 0) // same logic for minutes
                parts.Add(minutes + "M");

            parts.Add(seconds + "S"); // always show seconds

            return string.Join(" ", parts);
        }
    }

    #endregion

    #region TISS28 Scoring
    public class TISS28ScoringModel : BL_TISS28Scoring
    {
        ICUClient icuClient = new ICUClient();
        CommonServiceClient comm = new CommonServiceClient();
        public string TISSDate { get; set; }
        public string PatientName { get; set; }
        public string strNurseCode { get; set; }
        public string AgeGender { get; set; }
        public string Consulatation { get; set; }
        public string AdmnDateTime { get; set; }
        public string WardBedNo { get; set; }
        public string TISS28ScorerptData { get; set; }
        public string FrmDate { get; set; }
        public string ToDate { get; set; }
        public string DistinctDateValuesCnt { get; set; }
        public string DateDisplayInReport { get; set; }
        public string TimeDisplayInReport { get; set; }
        public List<OncologyEMR.CommonSerRef.SectionLstItem> ShiftSelected { get; set; }
        public string ICUYN { get; set; }
        public string BedwiseScoreData { get; set; }
        public string NurstCode { get; set; }
        public string TisAcuityAcore { get; set; }
        public string WAcuityScore { get; set; }
        public string ReportTitle { get; set; }

        public List<SelectLstItem1> ShiftList()
        {
            return GeneralFunction.ShiftList();
        }

        public object SaveTISS28Scoring(TISS28ScoringModel TISSMdl, string GACTION, string IPNO, string strUserId)
        {
            BL_TISS28Scoring blTISS = new BL_TISS28Scoring();
            string ret = "";
            NurstCode = HttpContext.Current.Session["NSCODE"].ToString();
            blTISS.IPNo = IPNO;
            blTISS.userID = strUserId;
            blTISS.ICUYN = HttpContext.Current.Session["ICUNSYN"].ToString();
            blTISS.TISSDate = GeneralFunction.GetDateInSpecifiedFormat(TISSMdl.TISSDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            blTISS.TISSShift = TISSMdl.TISSShift;
            blTISS.StandardMonitoring = TISSMdl.StandardMonitoring;
            blTISS.LaboratoryTests = TISSMdl.LaboratoryTests;
            blTISS.Medication = TISSMdl.Medication;
            blTISS.RoutineDressingChanges = TISSMdl.RoutineDressingChanges;
            blTISS.FreqDressingChanges = TISSMdl.FreqDressingChanges;
            blTISS.CareOfDrains = TISSMdl.CareOfDrains;
            blTISS.VasoacticeMedication = TISSMdl.VasoacticeMedication;
            blTISS.LargeFluidLossReplacement = TISSMdl.LargeFluidLossReplacement;
            blTISS.PeripheralArterialCatheter = TISSMdl.PeripheralArterialCatheter;
            blTISS.VenousCatheter = TISSMdl.VenousCatheter;
            blTISS.CPRPOSTARREST = TISSMdl.CPRPOSTARREST;
            blTISS.SpecificIntervention = TISSMdl.SpecificIntervention;
            blTISS.InterventionOutsideICU = TISSMdl.InterventionOutsideICU;
            blTISS.CareofArtificialAirways = TISSMdl.CareofArtificialAirways;
            blTISS.RespiratoryTreatment = TISSMdl.RespiratoryTreatment;
            blTISS.HemofiltrationDialysis = TISSMdl.HemofiltrationDialysis;
            blTISS.UrineOutputMeasurement = TISSMdl.UrineOutputMeasurement;
            blTISS.ActiveDiuresis = TISSMdl.ActiveDiuresis;
            blTISS.ICPMonitoring = TISSMdl.ICPMonitoring;
            blTISS.RxForAcidosisAlkalosis = TISSMdl.RxForAcidosisAlkalosis;
            blTISS.IVHyperalimentation = TISSMdl.IVHyperalimentation;
            blTISS.EnteralFeeding = TISSMdl.EnteralFeeding;
            blTISS.Ventilation = TISSMdl.Ventilation;
            blTISS.MeaIntraPress = TISSMdl.MeaIntraPress;
            blTISS.ADL = TISSMdl.ADL;
            blTISS.PhyRestraintApplied = TISSMdl.PhyRestraintApplied;
            blTISS.ContactIso = TISSMdl.ContactIso;
            blTISS.WAssessment = TISSMdl.WAssessment;
            blTISS.WRespiratory = TISSMdl.WRespiratory;
            blTISS.WCardiac = TISSMdl.WCardiac;
            blTISS.WMedication = TISSMdl.WMedication;
            blTISS.WDrainage = TISSMdl.WDrainage;
            blTISS.WPainMngmnt = TISSMdl.WPainMngmnt;
            blTISS.WPsychosocial = TISSMdl.WPsychosocial;
            blTISS.WWoundAstomy = TISSMdl.WWoundAstomy;
            blTISS.WADL = TISSMdl.WADL;
            blTISS.WADT = TISSMdl.WADT;
            blTISS.WSafety = TISSMdl.WSafety;
            blTISS.BedNo = TISSMdl.BedNo;
            blTISS.WAcuityScore = TISSMdl.WAcuityScore;
            blTISS.TisAcuityAcore = TISSMdl.TisAcuityAcore;
            blTISS.NurstCode = HttpContext.Current.Session["NSCODE"].ToString();
            if (GACTION == "N")
            {
                blTISS.Tranmode = Convert.ToInt16(GeneralFunction.modes.NewMode);
            }
            else if (GACTION == "E")
            {
                blTISS.Tranmode = Convert.ToInt16(GeneralFunction.modes.EditMode);
            }
            ret = icuClient.TISS28ScoringTran(blTISS);
            return ret;
        }

        public object GetTISS28ScoringData(string strIPNo, string strDate, string strTime, string ROLLOVER)
        {
            DataSet ds = new DataSet();
            string strDateToSend = GeneralFunction.GetDateInSpecifiedFormat(strDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            if (ROLLOVER == "Y")
            {
                if (strTime == "M" || strTime == "Morning")
                {
                    strTime = "Night";
                }
                else if (strTime == "E" || strTime == "Evening")
                {
                    strTime = "Morning";
                }
                else if (strTime == "N" || strTime == "Night")
                {
                    strTime = "Evening";
                }
            }
            string s = icuClient.GetTISS28Scoring(strIPNo, strDateToSend, strTime, strDateToSend, "");
            ds.ReadXml(new XmlTextReader(new StringReader(s)));
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    var jsondata = (from DataRow row in ds.Tables[0].Rows
                                    select new
                                    {
                                        IPNO = row["IPNO"].ToString().Trim(),
                                        TranDate = row["TRANDATE"].ToString().Trim(),
                                        ShiftTime = row["SHIFTTM"].ToString().Trim(),
                                        ADL = row["ADL"].ToString().Trim(),
                                        PHYRESTAPPL = row["PHYRESTAPPL"].ToString().Trim(),
                                        CONTISO = row["CONTISO"].ToString().Trim(),
                                        StdMonitor = row["STDMONITOR"].ToString().Trim(),
                                        LabTest = row["LABTESTS"].ToString().Trim(),
                                        Medication = row["MEDICATION"].ToString().Trim(),
                                        RoutineDressingChanges = row["ROUTDRESCHNG"].ToString().Trim(),
                                        FreqDressingChanges = row["FREQDRESCHNG"].ToString().Trim(),
                                        CareOfDrains = row["CAREDRAIN"].ToString().Trim(),
                                        VasoMedi = row["VASOMEDI"].ToString().Trim(),
                                        LargeFluidLossRpl = row["FLUIDREPLACEMNT"].ToString().Trim(),
                                        PeriCathe = row["PERIARTCATH"].ToString().Trim(),
                                        CentralVenousCathe = row["CENTRALVENCATH"].ToString().Trim(),
                                        CPRArrest = row["CRPPOSTARREST"].ToString().Trim(),
                                        SpecIntrv = row["SPECINTERVENT"].ToString().Trim(),
                                        IntrvntnOutsideICU = row["INTERVENTOUTICU"].ToString().Trim(),
                                        CareofArtificialAirways = row["CAREOFAIEWAY"].ToString().Trim(),
                                        RespTreat = row["RESPTREAT"].ToString().Trim(),
                                        HemoFilt = row["HEMOFILTDIALYSIS"].ToString().Trim(),
                                        UrineOPMeasurement = row["UROUTMEASUREMNT"].ToString().Trim(),
                                        ActiveDieuresis = row["ACTIVEDIURESIS"].ToString().Trim(),
                                        ICPMonitoring = row["IPCMONITOR"].ToString().Trim(),
                                        RxFrAcidosis = row["RXFORACIDALK"].ToString().Trim(),
                                        IVHyperAli = row["IVHYPERALAIL"].ToString().Trim(),
                                        EnteralFeeding = row["ENTERALFEED"].ToString().Trim(),
                                        Ventilation = row["VENTILATION"].ToString().Trim(),
                                        MeaIntraPress = row["MEASINTPRES"].ToString().Trim(),//added by aaryshree on 25/06/2025
                                        CREATEDBY = row["CREATEDBY"].ToString().Trim(),
                                        CREATEDON = row["CREATEDON"].ToString().Trim(),
                                        CREATEDAT = row["CREATEDAT"].ToString().Trim(),
                                        WAssessment = row["WASSESMENT"].ToString().Trim(),
                                        WRespiratory = row["WRESPIRATORY"].ToString().Trim(),
                                        WCardiac = row["WCARDIAC"].ToString().Trim(),
                                        WMedication = row["WMEDICATION"].ToString().Trim(),
                                        WDrainage = row["WDRAINAGE"].ToString().Trim(),
                                        WPainMngmnt = row["WPAIN"].ToString().Trim(),
                                        WPsychosocial = row["WPSYCHO"].ToString().Trim(),
                                        WWoundAstomy = row["WWOUND"].ToString().Trim(),
                                        WADL = row["WADL"].ToString().Trim(),
                                        WADT = row["WADT"].ToString().Trim(),
                                        WSafety = row["WSAFETY"].ToString().Trim(),
                                        ICUYN = row["ICUYN"].ToString().Trim(),
                                        BedNo = row["BEDNO"].ToString().Trim(),
                                        NurstCode = row["NURSTCD"].ToString().Trim(),
                                        TisAcuityAcore = row["TISSACUSCORE"].ToString().Trim(),
                                        WAcuityScore = row["WACUITYSCORE"].ToString().Trim(),

                                    }).ToArray();

                    return jsondata;
                }
            }
            return "";
        }

        public TISS28ScoringModel GetDataForTISSReport(string strIPNO, string strFrmDate, string strToDate, string strUserId)
        {
            DataSet ds = new DataSet();
            DataTable newDataTable = new DataTable();
            TISS28ScoringModel mdl = new TISS28ScoringModel();
            mdl.ICUYN = (HttpContext.Current.Session["ICUNSYN"].ToString() ?? "N").ToUpper();
            string strFDt = GeneralFunction.GetDateInSpecifiedFormat(strFrmDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string strTDt = GeneralFunction.GetDateInSpecifiedFormat(strToDate, GeneralFunction.DateModes.DATEWITHOUTSEPARATOR_YYYYMMDD);
            string s = icuClient.GetTISS28Scoring(strIPNO, strFDt, "", strTDt, "");
            ds.ReadXml(new XmlTextReader(new StringReader(s)));
            if (ds.Tables.Count > 0)
            {
                DataTable distinctDates = ds.Tables[0].DefaultView.ToTable(true, "TRANDATE");
                newDataTable.Columns.Add("ParaName");
                foreach (DataRow dateRow in distinctDates.Rows)
                {
                    string date = dateRow["TRANDATE"].ToString();
                    newDataTable.Columns.Add("M-" + date);
                    newDataTable.Columns.Add("E-" + date);
                    newDataTable.Columns.Add("N-" + date);
                }
                Dictionary<string, string> paramNameToFieldMap;
                Dictionary<string, List<string>> categoryToParams = null;
                if (mdl.ICUYN == "Y")
                {
                    paramNameToFieldMap = new Dictionary<string, string>
                {
                { "Standard monitoring (hourly vital signs, fluid balance)", "STDMONITOR" },
                { "Biochemical and microbiological investigations", "IVHYPERALAIL" },
                { "Intravenous medications", "MEDICATION" },
                { "Care and prevention of decubitus and daily dressing changes", "IPCMONITOR" },
                { "Frequent Dressing changes", "FREQDRESCHNG" },
                { "Care Of Drains", "CAREDRAIN" },

                { "Vasoactive Medication", "VASOMEDI" },
                { "Large Fluid Loss Replacement", "FLUIDREPLACEMNT" },
                { "Arterial Catheter", "PERIARTCATH" },
                { "Pulmonary artery flotation catheter", "PHYRESTAPPL" },
                { "Central Venous Catheter", "CENTRALVENCATH" },
                { "CPR/POST ARREST", "CRPPOSTARREST" },

                { "Specific intervention", "SPECINTERVENT" },
                 { "Specific interventions outside ICU (surgery or diagnostic procedures)", "INTERVENTOUTICU" },

                { "Ventilation", "VENTILATION" },
                { "Care of Artificial airways", "CAREOFAIEWAY" },
                { "Respiratory Treatment", "RESPTREAT" },

                { "Hemofiltration/Dialysis", "HEMOFILTDIALYSIS" },
                { "Urine Output Measurement", "UROUTMEASUREMNT" },
                { "Active Diuresis", "ACTIVEDIURESIS" },

                { "Rx for Acidosis/Alkalosis", "RXFORACIDALK" },
                { "lniravenous alimentation", "CONTISO" },
                { "Enteral feeding", "ENTERALFEED" },

                { "Measurement of intracranial pressure", "MEASINTPRES" },


            };

                    categoryToParams = new Dictionary<string, List<string>>
            {
                { "Basic Activities", new List<string>
                    {
                        "Standard monitoring (hourly vital signs, fluid balance)",
                        "Biochemical and microbiological investigations",
                        "Intravenous medications",
                        "Care and prevention of decubitus and daily dressing changes",
                        "Frequent Dressing changes",
                        "Care Of Drains"
                    }
                },
                { "Cardiovascular Support", new List<string>
                    {
                        "Vasoactive Medication",
                        "Large Fluid Loss Replacement",
                        "Arterial Catheter",
                        "Pulmonary artery flotation catheter",
                        "Central Venous Catheter",
                        "CPR/POST ARREST"
                    }
                },
                { "Specific intervention", new List<string> { "Specific intervention" ,"Specific interventions outside ICU (surgery or diagnostic procedures)"} },

                { "Ventilatory Support", new List<string>
                    {
                        "Ventilation",
                        "Care of Artificial airways",
                        "Respiratory Treatment"
                    }
                },
                { "Renal Support", new List<string>
                    {
                        "Hemofiltration/Dialysis",
                        "Urine Output Measurement",
                        "Active Diuresis"
                    }
                },
                { "Metabolic Support", new List<string>
                    {
                        "Rx for Acidosis/Alkalosis",
                        "lniravenous alimentation",
                        "Enteral feeding"
                    }
                },
                { "Neurological Support", new List<string> { "Measurement of intracranial pressure" } },
            };
                }
                else
                {

                    paramNameToFieldMap = new Dictionary<string, string>
            {
                { "Assessment", "WASSESMENT" },
                { "Respiratory", "WRESPIRATORY" },
                { "Cardiac", "WCARDIAC" },
                { "Medications", "WMEDICATION" },
                { "Drainage devices", "WDRAINAGE" },
                { "Pain management", "WPAIN" },
                {"ADT","WADT"},
                { "Psychosocial", "WPSYCHO" },
                { "Wound care", "WWOUND" },
                {"ADLs/ Isolation","WADL"},
                {"Safety","WSAFETY"},

            };
                }
                if (mdl.ICUYN == "Y")
                {
                    foreach (var category in categoryToParams)
                    {
                        DataRow catRow = newDataTable.NewRow();
                        catRow["ParaName"] = "##CATEGORY##" + category.Key;
                        newDataTable.Rows.Add(catRow);

                        foreach (var param in category.Value)
                        {
                            DataRow paramRow = newDataTable.NewRow();
                            paramRow["ParaName"] = param;
                            newDataTable.Rows.Add(paramRow);
                        }
                    }
                }
                else
                {
                    foreach (var param in paramNameToFieldMap.Keys)
                    {
                        DataRow paramRow = newDataTable.NewRow();
                        paramRow["ParaName"] = param;
                        newDataTable.Rows.Add(paramRow);
                    }
                }


                foreach (DataRow row in newDataTable.Rows)
                {
                    string paraName = row["ParaName"].ToString().Trim();
                    if (paraName.StartsWith("##CATEGORY##"))
                        continue;

                    if (!paramNameToFieldMap.ContainsKey(paraName))
                        continue;

                    string fieldName = paramNameToFieldMap[paraName];
                    if (!ds.Tables[0].Columns.Contains(fieldName))
                        continue;

                    for (int i = 1; i < newDataTable.Columns.Count; i++)
                    {
                        string colName = newDataTable.Columns[i].ColumnName;
                        string shift = colName.Substring(0, 1);
                        string date = colName.Substring(2);

                        var value = (from myRow in ds.Tables[0].AsEnumerable()
                                     where myRow.Field<string>("SHIFTTM") == shift &&
                                           myRow.Field<string>("TRANDATE") == date
                                     select myRow[fieldName].ToString().Trim()).SingleOrDefault();

                        row[i] = value ?? "";
                    }
                }

                mdl.TISS28ScorerptData = DataTableToJSONWithJSONNet(newDataTable);
                mdl.userID = strUserId;
                mdl.DateDisplayInReport = comm.GetServerDate();
                mdl.TimeDisplayInReport = comm.GetServerTime();


                if (!string.IsNullOrWhiteSpace(strIPNO))
                {
                    GeneralFunction gen = new GeneralFunction();
                    DataSet patDataSet = GeneralFunction.GetIPPatInfo(strIPNO.Trim(), "", "", "", "", "", "", "", "", "", "", "", "", "", "");

                    if (patDataSet.Tables.Count > 0 && patDataSet.Tables[0].Rows.Count > 0)
                    {
                        DataRow pRow = patDataSet.Tables[0].Rows[0];
                        mdl.PatientName = pRow["PATNAME"].ToString();
                        mdl.MRNo = pRow["MRNO"].ToString();
                        mdl.IPNo = pRow["IPNO"].ToString();
                        mdl.AgeGender = pRow["PATAGE"].ToString() + " / " + pRow["GENDER"].ToString();
                        mdl.Consulatation = pRow["CONSDOCT"].ToString();
                        mdl.AdmnDateTime = GeneralFunction.GetDate(pRow["ADMNDATE"].ToString()) + " / " + GeneralFunction.ConvertTo12HourFormat(pRow["ADMNTIME"].ToString());
                        mdl.WardBedNo = pRow["WARDNM"].ToString().Trim() + " / " + pRow["CURRBEDNO"].ToString().Trim();
                        mdl.BedNo = pRow["CURRBEDNO"].ToString().Trim();
                    }
                }
            }

            return mdl;
        }

        public TISS28ScoringModel GetDataForBedwiseScoreReport(string strNursCode)
        {
            TISS28ScoringModel model = new TISS28ScoringModel();
            DataSet ds = new DataSet();
            DataTable reportTable = new DataTable();
            model.ICUYN = (HttpContext.Current.Session["ICUNSYN"].ToString() ?? "N").ToUpper();
            string nurseCode = HttpContext.Current.Session["NSCODE"].ToString();
            string nuseName = HttpContext.Current.Session["NSNAME"].ToString();
            string responseXml = icuClient.GetBedwiseScore(nurseCode);
            ds.ReadXml(new XmlTextReader(new StringReader(responseXml)));
            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                return model;
            DataTable sourceTable = ds.Tables[0];
            reportTable.Columns.Add("Parameter");
            var bedList = sourceTable.AsEnumerable()
        .Where(r => (model.ICUYN == "Y") ? (r.Field<string>("ICUYN") == "Y") : (r.Field<string>("ICUYN") != "Y"))
        .Select(r => r.Field<string>("BEDNO"))
        .Distinct()
        .ToList();


            foreach (var bed in bedList)
                reportTable.Columns.Add(bed);

            Dictionary<string, string> paramMap;
            Dictionary<string, List<string>> categoryMap;

            if (model.ICUYN == "Y")
            {
                GetICUParamMapWithCategories(out paramMap, out categoryMap);
            }
            else
            {
                paramMap = GetWardParamMap();
                categoryMap = null; // No categories for ward
            }

            if (categoryMap != null)
            {
                foreach (var category in categoryMap)
                {
                    DataRow catRow = reportTable.NewRow();
                    catRow["Parameter"] = "##CATEGORY##" + category.Key;
                    reportTable.Rows.Add(catRow);

                    foreach (var param in category.Value)
                    {
                        DataRow paramRow = reportTable.NewRow();
                        paramRow["Parameter"] = param;

                        foreach (var bed in bedList)
                        {
                            var latestRow = sourceTable.AsEnumerable()
                                .Where(r => r.Field<string>("BEDNO") == bed)
                                .OrderByDescending(r => r.Field<string>("TRANDATE"))
                                .ThenByDescending(r => GetShiftSortValue(r.Field<string>("SHIFTTM")))
                                .FirstOrDefault();

                            if (latestRow != null && sourceTable.Columns.Contains(paramMap[param]))
                            {
                                paramRow[bed] = latestRow[paramMap[param]].ToString().Trim() ?? "";
                            }
                        }

                        reportTable.Rows.Add(paramRow);
                    }
                }
            }
            else
            {
                foreach (var param in paramMap.Keys)
                {
                    DataRow row = reportTable.NewRow();
                    row["Parameter"] = param;

                    foreach (var bed in bedList)
                    {
                        var latestRow = sourceTable.AsEnumerable()
                            .Where(r => r.Field<string>("BEDNO") == bed)
                            .OrderByDescending(r => r.Field<string>("TRANDATE"))
                            .ThenByDescending(r => GetShiftSortValue(r.Field<string>("SHIFTTM")))
                            .FirstOrDefault();

                        if (latestRow != null && sourceTable.Columns.Contains(paramMap[param]))
                        {
                            row[bed] = latestRow[paramMap[param]].ToString().Trim() ?? "";
                        }
                    }

                    reportTable.Rows.Add(row);
                }
            }
            model.BedwiseScoreData = DataTableToJSONWithJSONNet(reportTable);
            model.NurstCode = nurseCode;
            model.userID = HttpContext.Current.Session["UserID"].ToString();
            model.DateDisplayInReport = comm.GetServerDate();
            model.TimeDisplayInReport = comm.GetServerTime();
            return model;
        }

        private int GetShiftSortValue(string shift)
        {
            switch (shift.ToUpper())
            {
                case "N": return 3;
                case "E": return 2;
                case "M": return 1;
                default: return 0;
            }
        }
        private void GetICUParamMapWithCategories(
            out Dictionary<string, string> paramMap,
            out Dictionary<string, List<string>> categoryMap)
        {
            paramMap = new Dictionary<string, string>
    {
        { "Standard monitoring (hourly vital signs, fluid balance)", "STDMONITOR" },
        { "Biochemical and microbiological investigations", "IVHYPERALAIL" },
        { "Intravenous medications", "MEDICATION" },
        { "Care and prevention of decubitus and daily dressing changes", "IPCMONITOR" },
        { "Frequent Dressing changes", "FREQDRESCHNG" },
        { "Care Of Drains", "CAREDRAIN" },

        { "Vasoactive Medication", "VASOMEDI" },
        { "Large Fluid Loss Replacement", "FLUIDREPLACEMNT" },
        { "Arterial Catheter", "PERIARTCATH" },
        { "Pulmonary artery flotation catheter", "PHYRESTAPPL" },
        { "Central Venous Catheter", "CENTRALVENCATH" },
        { "CPR/POST ARREST", "CRPPOSTARREST" },

        { "Specific intervention", "SPECINTERVENT" },
        {"Specific interventions outside ICU (surgery or diagnostic procedures)", "INTERVENTOUTICU" },

        { "Ventilation", "VENTILATION" },
        { "Care of Artificial airways", "CAREOFAIEWAY" },
        { "Respiratory Treatment", "RESPTREATAS" },

        { "Hemofiltration/Dialysis", "HEMOFILTDIALYSIS" },
        { "Urine Output Measurement", "UROUTMEASUREMNT" },
        { "Active Diuresis", "ACTIVEDIURESIS" },

        { "Rx for Acidosis/Alkalosis", "RXFORACIDALK" },
        { "lniravenous alimentation", "CONTISO" },
        { "Enteral feeding", "ENTERALFEED" },

        { "Measurement of intracranial pressure", "MEASINTPRES" },
    };

            categoryMap = new Dictionary<string, List<string>>
    {
        { "Basic Activities", new List<string>
            {
                "Standard monitoring (hourly vital signs, fluid balance)",
                "Biochemical and microbiological investigations",
                "Intravenous medications",
                "Care and prevention of decubitus and daily dressing changes",
                "Frequent Dressing changes",
                "Care Of Drains"
            }
        },
        { "Cardiovascular Support", new List<string>
            {
                "Vasoactive Medication",
                "Large Fluid Loss Replacement",
                "Arterial Catheter",
                "Pulmonary artery flotation catheter",
                "Central Venous Catheter",
                "CPR/POST ARREST"
            }
        },
        { "Specific intervention", new List<string> { "Specific intervention" ,"Specific interventions outside ICU (surgery or diagnostic procedures)"} },
        { "Ventilatory Support", new List<string>
            {
                "Ventilation",
                "Care of Artificial airways",
                "Respiratory Treatment"
            }
        },
        { "Renal Support", new List<string>
            {
                "Hemofiltration/Dialysis",
                "Urine Output Measurement",
                "Active Diuresis"
            }
        },
        { "Metabolic Support", new List<string>
            {
                "Rx for Acidosis/Alkalosis",
                "lniravenous alimentation",
                "Enteral feeding"
            }
        },
        { "Neurological Support", new List<string>
            {
                "Measurement of intracranial pressure"
            }
        }
    };
        }
        private Dictionary<string, string> GetWardParamMap()
        {
            return new Dictionary<string, string>
    {
        { "Assessment", "WASSESMENT" },
        { "Respiratory", "WRESPIRATORY" },
        { "Cardiac", "WCARDIAC" },
        { "Medications", "WMEDICATION" },
        { "Drainage devices", "WDRAINAGE" },
        { "Pain management", "WPAIN" },
        { "ADT", "WADT" },
        { "Psychosocial", "WPSYCHO" },
        { "Wound care", "WWOUND" },
        { "ADLs/ Isolation", "WADL" },
        { "Safety", "WSAFETY" },
    };
        }


        private int GetColumnIndexByName(DataTable table, string paramName)
        {
            for (int i = 0; i < table.Columns.Count; i++)
            {
                if (table.Columns[i].ColumnName.Trim().Equals(paramName.Trim(), StringComparison.OrdinalIgnoreCase))
                    return i;
            }

            // Fuzzy fallback (optional)
            for (int i = 0; i < table.Columns.Count; i++)
            {
                if (table.Columns[i].ColumnName.IndexOf(paramName.Trim(), StringComparison.OrdinalIgnoreCase) >= 0)
                    return i;
            }

            return -1;
        }



        public string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = Newtonsoft.Json.JsonConvert.SerializeObject(table);
            return JSONString;
        }

        public static DataTable GetInversedDataTable(DataTable table, string columnX,
                                       params string[] columnsToIgnore)
        {
            //Create a DataTable to Return
            DataTable returnTable = new DataTable();

            if (columnX == "")
                columnX = table.Columns[0].ColumnName;

            //Add a Column at the beginning of the table

            returnTable.Columns.Add(columnX);

            //Read all DISTINCT values from columnX Column in the provided DataTale
            List<string> columnXValues = new List<string>();

            //Creates list of columns to ignore
            List<string> listColumnsToIgnore = new List<string>();
            if (columnsToIgnore.Length > 0)
                listColumnsToIgnore.AddRange(columnsToIgnore);

            if (!listColumnsToIgnore.Contains(columnX))
                listColumnsToIgnore.Add(columnX);

            foreach (DataRow dr in table.Rows)
            {
                string columnXTemp = dr[columnX].ToString();
                //Verify if the value was already listed
                if (!columnXValues.Contains(columnXTemp))
                {
                    //if the value id different from others provided, add to the list of 
                    //values and creates a new Column with its value.
                    columnXValues.Add(columnXTemp);
                    returnTable.Columns.Add(columnXTemp);
                }
                else
                {
                    //Throw exception for a repeated value
                    throw new Exception("The inversion used must have " +
                                        "unique values for column " + columnX);
                }
            }

            //Add a line for each column of the DataTable

            foreach (DataColumn dc in table.Columns)
            {
                if (!columnXValues.Contains(dc.ColumnName) &&
                    !listColumnsToIgnore.Contains(dc.ColumnName))
                {
                    DataRow dr = returnTable.NewRow();
                    dr[0] = dc.ColumnName;
                    returnTable.Rows.Add(dr);
                }
            }

            //Complete the datatable with the values
            for (int i = 0; i < returnTable.Rows.Count; i++)
            {
                for (int j = 1; j < returnTable.Columns.Count; j++)
                {
                    returnTable.Rows[i][j] =
                        string.IsNullOrEmpty(table.Rows[j - 1][returnTable.Rows[i][0].ToString()].ToString()) ? "0" : table.Rows[j - 1][returnTable.Rows[i][0].ToString()].ToString();
                }
            }
            return returnTable;
        }
    }
    #endregion TISS28Scoring

    #endregion

    #region IPD Diagnosis
    public class IPDiagnosis
    {
        public string SaveDiagnosis(string strMRNO, string strIPNO, string strTranNo, string ICDOTopoList, string ICDOHistoList, string DiagPrimary, string DiagSecondary, string Gact)
        {

            ICUClient client = new ICUClient();
            BL_IPDiagnosis bl = new BL_IPDiagnosis();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable dtt = new DataTable();
            DataTable dttO = new DataTable();
            DataTable dttH = new DataTable();
            ds.DataSetName = "DATA";
            dt = JsonConvert.DeserializeObject<DataTable>(DiagPrimary);
            if (dt != null)
            {
                dt.TableName = "DIGNOSIS";
                ds.Tables.Add(dt);
            }

            dtt = JsonConvert.DeserializeObject<DataTable>(DiagSecondary);
            if (dtt != null)
            {
                dtt.TableName = "ICDDIGNOSIS";
                ds.Tables.Add(dtt);
            }

            dttO = JsonConvert.DeserializeObject<DataTable>(ICDOTopoList);
            if (dttO != null)
            {
                dttO.TableName = "ICDODIGNOSIS";
                ds.Tables.Add(dttO);
            }

            dttH = JsonConvert.DeserializeObject<DataTable>(ICDOHistoList);
            if (dttH != null)
            {
                dttH.TableName = "ICDOHDIGNOSIS";
                ds.Tables.Add(dttH);
            }


            //bl.TranNo = strTranNo;
            bl.userID = HttpContext.Current.Session["gOncoUserId"].ToString();
            bl.MRNo = strMRNO;
            bl.IPNo = strIPNO;

            if (Gact == "N")
            {
                bl.Tranmode = Convert.ToInt16(GeneralFunction.modes.NewMode);
            }
            else if (Gact == "E")
            {
                bl.Tranmode = Convert.ToInt16(GeneralFunction.modes.EditMode);
            }

            // bl.cre
            bl.DiagnosisXMLDet = ds.GetXml().Replace("&amp;", "");
            string a = ds.GetXml().Replace("&amp;", "");

            return client.IPDiagnosisTran(bl);
        }


        public object SetDataForIPDDiagnosis(string strTranNo, string strMRNO, string strIpNo)
        {
            ICUClient cl = new ICUClient();
            bool HistoryFlag = true;
            string str = cl.GetIPDiagnosisDet(strIpNo, strMRNO);

            DataSet ds = new DataSet();
            ds.ReadXml(new StringReader(str));
            object[] objData = new object[6];
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
                DataSet ICDODs = new DataSet();
                ICDODs.ReadXml(new StringReader(str));
                if (ICDODs.Tables.Contains("ICDODiagDt"))
                    ICDOTopo = ICDODs.Tables["ICDODiagDt"];
                if (ICDODs.Tables.Contains("ICDOHDiagDt"))
                    ICDOHisto = ICDODs.Tables["ICDOHDiagDt"];
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
                                ADJUVANT = row["ADJUVANT"].ToString().ToUpper(), //priyanka 28/04/2026
                                RECCURENT = row["RECCURENT"].ToString().ToUpper(), //priyanka 28/04/2026
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
            return objData;
        }
    }
    #endregion

    #endregion

    #region PAC

    #endregion

    #region DMS Document Upload
    public class DMSDocUpload
    {
        public string SelectedDocType { get; set; }

        public List<SelectListItem> DocTypeList { get; set; }
        public List<SelectListItem> GetDocumentMaster()
        {
            DMSServiceClient docu = new DMSServiceClient();
            DataSet ds = new DataSet();

            ds.ReadXml(new XmlTextReader(new StringReader(docu.GetDocTypeMstList())));

            List<SelectListItem> docList = new List<SelectListItem>();

            if (ds.Tables["Table"] != null)
            {
                docList = (from DataRow row in ds.Tables["Table"].Rows
                           where ("" + row["CLINICALDOCYN"]).Trim() == "Y"
                           select new SelectListItem
                           {
                               Value = row["DOCTYPECODE"].ToString(),
                               Text = row["DOCTYPEDESC"].ToString().Trim()
                           }).ToList();
            }

            return docList;
        }

        public object GetDMSUploadDocuments(string strBillIP, string strDocType, string strMRNo)
        {
            DMSServiceClient docu = new DMSServiceClient();
            DataSet ds = new DataSet();
            object[] obj = new object[1];
            object jsonData = "";
            string strLocation = "";
            ds.ReadXml(new XmlTextReader(new StringReader(docu.GetUploadDocuments(strBillIP, strDocType, strLocation, strMRNo))));

            if (ds.Tables["Table"] == null)
            {
                obj[0] = null;
            }
            else
            {
                var DoctTypeLst = GetDocumentMaster();
                jsonData = new
                {
                    rows = (from DataRow row in ds.Tables["Table"].Rows
                            where ("" + row["CLINICALDOCYN"]).Trim() == "Y"
                            select new
                            {
                                IPNO = row["IPNO"].ToString(),
                                MRNO = row["MRNO"].ToString(),
                                DOCPATH = row["DOCPATH"].ToString(),
                                DOCTYPENM = row["DOCTYPECD"].ToString().Trim() != "" ? GeneralFunction.GetListValue(DoctTypeLst, row["DOCTYPECD"].ToString().Trim()) : "",
                                DOCTYPECD = row["DOCTYPECD"].ToString(),
                                DOCNAME = row["DOCNAME"].ToString(),
                                UPDDATE = row["UPDDATE"].ToString()
                            }).ToArray()
                };
                obj[0] = jsonData;
            }
            return obj;
        }
    }
    #endregion


    public class ExaminationImages
    {
        public List<string> RetriveUploadedExamImages(string MrNo, string TranNo, string ConultCode = "")
        {
            try
            {
                int fileCount = 0;
                string[] filePaths = { };
                List<string> ListofFileBytes = new List<string>();

                string strUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                string strDoctCode = ConultCode == "" ? ("" + System.Web.HttpContext.Current.Session["gDoctCode"]).ToString() : ConultCode;
                var Pic_Path = GeneralFunction.GetAppsettingUnitWiseValue("DocumentPath").ToString().Trim() + @"\HumanBodyImg\";
                var subpath = Pic_Path + strDoctCode;
                string countpath = subpath.Replace(@"\", @"/");

                if (Directory.Exists(subpath))
                {
                    fileCount = Directory.GetFiles(subpath).Length;
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
                //Common Folder Images
                var GlbPic_Path = AppDomain.CurrentDomain.BaseDirectory + @"\HumanBodyImg";
                string Glbcountpath = GlbPic_Path.Replace(@"\", @"/");
                fileCount = 0;
                if (Directory.Exists(Glbcountpath))
                {
                    fileCount = Directory.GetFiles(Glbcountpath).Length;
                }
                if (fileCount > 0)
                {
                    filePaths = Directory.GetFileSystemEntries(Glbcountpath);

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
    }

    #region Pre Auth Scheme
    public class SchemePreAuth
    {
        public string SaveSchemeYN { get; set; }
        public string SchemeMRNO { get; set; }
        public string SchemeRefTranNo { get; set; }
        public string SchemeType { get; set; }
        public string SchemeTranNo { get; set; }
        public string AllSchemeCodes { get; set; }
        public int SchemeTranMode { get; set; }
        public string SchemeCompanyCode { get; set; }
        public string SchemeAdviceTranNo { get; set; }

        public object GetSchemeCodeToList(string CreditCompCD, string SchemeType, string SchemeCodes)
        {
            DataSet DS = new DataSet();
            CommonServiceClient common = new CommonServiceClient();
            DS.ReadXml(new XmlTextReader(new StringReader(common.GetSchemeSpecialityCompanyWise(CreditCompCD, SchemeType))));
            if (DS.Tables.Count == 0 || DS.Tables[0].Rows.Count == 0)
            {
                return new object[0];
            }
            var codeList = (SchemeCodes ?? "").Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(x => x.Trim()).ToList();
            var rows = (from DataRow row in DS.Tables[0].Rows
                        let code = row["SCHEMECD"].ToString().Trim()
                        where codeList.Count == 0 || codeList.Contains(code)
                        select new
                        {
                            SCHEMENAME = GeneralFunction.CheckDblToSingleQuote(row["SCHEMENM"].ToString().Trim()),
                            SCHEMECODE = code
                        }).ToArray();
            return rows;
        }

        public object GetPreAuthSchemeList(string SchemeType, string Mrno, string IPNo, string ConsultTranNo = "")
        {
            OncologyClient ClOnco = new OncologyClient();
            DataSet DS = new DataSet();
            var PreAuthStatusList = GeneralFunction.PreAuthStatusList();
            DS.ReadXml(new XmlTextReader(new StringReader(ClOnco.GetRadDosePrescAprovalDet("", Mrno, "", "", "", "", SchemeType, ""))));
            if (DS.Tables.Count == 0 || DS.Tables[0].Rows.Count == 0)
            {
                return new object[0];
            }
            AdministrationClient admin = new AdministrationClient();
            var RefSchemeList = admin.GetSchemeMstList("", "");
            DataSet SchemeDS = new DataSet();
            if (RefSchemeList != "")
                SchemeDS = GeneralFunction.FillDatasetXMl(RefSchemeList);
            List<SelectListItem> schemeList = new List<SelectListItem>();
            DataTable schemeTable = SchemeDS.Tables["SchemeDet"];
            var schemeLookup = schemeTable.AsEnumerable().ToDictionary(x => x["SCHEMECD"].ToString().Trim(), x => x["SCHEMENM"].ToString().Trim());

            var rows = (from DataRow row in DS.Tables[0].Select("AUTHSTATUS <> 'R'")
                        select new
                        {
                            MRNO = (string.Empty + row["MRNO"]).Trim(),
                            TRANNO = (string.Empty + row["AUTHTRANNO"]).Trim(),
                            SCHEMECODES = (string.Empty + row["REFSCHEMECODES"]).Trim(),
                            SCHEMENAME = string.Join(", ", (row["REFSCHEMECODES"]?.ToString() ?? "").Replace("'", "").Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(code => code.Trim()).Where(code => schemeLookup.ContainsKey(code)).Select(code => schemeLookup[code])),
                            REFTRANNO = (string.Empty + row["REFTRANNO"]).Trim(),
                            SCHEMETYPE = SchemeType,
                            COMPANYCODE = (string.Empty + row["COMPCODE"]).Trim(),
                            ADVICETRANNO = (string.Empty + row["REFTRANNO"]).Trim(),
                            ADVICEDTTM = GeneralFunction.GetDate((string.Empty + row["REFTRANDATE"]).Trim()) + " " + (string.Empty + row["REFTRANTIME"]).Trim(),
                            AUTHSTATUS = (string.Empty + row["AUTHSTATUS"]).Trim() != "" ? GeneralFunction.GetListValue(PreAuthStatusList, (string.Empty + row["AUTHSTATUS"]).Trim()) : ""
                        }).ToArray();
            return rows;
        }
        public string SaveSchemePreAuth(SchemePreAuth Mdl)
        {
            OncologyClient ClOnco = new OncologyClient();
            BL_DosePlanPrescrAproval blOnco = new BL_DosePlanPrescrAproval();
            string[] schemeCodes = string.IsNullOrWhiteSpace(Mdl.AllSchemeCodes) ? new string[0] : Mdl.AllSchemeCodes.TrimEnd(',').Split(',');
            string[] SchemeTranNos = string.IsNullOrWhiteSpace(Mdl.SchemeTranNo) ? new string[0] : Mdl.SchemeTranNo.TrimEnd(',').Split(',');
            string[] SchemeCompanyCodes = string.IsNullOrWhiteSpace(Mdl.SchemeCompanyCode) ? new string[0] : Mdl.SchemeCompanyCode.TrimEnd(',').Split(',');
            string Result = "";
            for (int i = 0; i < schemeCodes.Length; i++)
            {
                blOnco.MRNO = Mdl.SchemeMRNO;
                blOnco.RefTranNo = Mdl.SchemeRefTranNo;
                blOnco.Type = Mdl.SchemeType;
                blOnco.SchemeCodes = schemeCodes[i];  // Mdl.AllSchemeCodes;
                blOnco.TranNo = SchemeTranNos.Length > i ? SchemeTranNos[i] : Mdl.SchemeTranNo;
                blOnco.TranMode = Mdl.SchemeTranMode;
                blOnco.CompanyCode = SchemeCompanyCodes.Length > i ? SchemeCompanyCodes[i] : Mdl.SchemeCompanyCode;
                blOnco.AdviceTranNo = Mdl.SchemeAdviceTranNo;
                blOnco.UserID = Convert.ToString(HttpContext.Current.Session["gOncoUserId"].ToString());
                blOnco.IpAddress = Convert.ToString(System.Web.HttpContext.Current.Session["MchIPAddress"]);
                blOnco.ModuleID = Convert.ToString(System.Web.HttpContext.Current.Session["ModuleIDGlobal"]);
                Result = ClOnco.SavePreAuthApprovalTran(blOnco);
            }
            return Result;
        }
    }
    #endregion
}