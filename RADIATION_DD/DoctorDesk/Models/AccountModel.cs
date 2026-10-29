using OncologyEMR.CommonSerRef;
using OncologyEMR.DataClass;
using OncologyEMR.ISecurServRef;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;

namespace OncologyEMR.Models
{
    public class AccountModel
    {
        public string Password { get; set; }
        public string UserID { get; set; }

        public string SetHospitalUnit(string HospUnit)
        {
            string Result = "Success";
            CommonServiceClient comm = new CommonServiceClient();
            System.Web.HttpContext.Current.Session["FINANCIALYEAR"] = comm.GetTranYear(comm.GetServerDate());
            System.Web.HttpContext.Current.Session["CHANGEUNITYN"] = "Y";
            System.Web.HttpContext.Current.Session["Location"] = "Thane";
            if (HospUnit == "00")
            {
                System.Web.HttpContext.Current.Session["UNITCODE"] = HospUnit;
                System.Web.HttpContext.Current.Session["HOSPITALNAME"] = GeneralFunction.GetAppsettingUnitWiseValue("HOSPNAME");
                System.Web.HttpContext.Current.Session["HOSPITALADDRESS"] = GeneralFunction.GetAppsettingUnitWiseValue("HOSPADD");
                System.Web.HttpContext.Current.Session["UNITOF"] = "";
                System.Web.HttpContext.Current.Session["HOSPLOGO"] = HttpRuntime.AppDomainAppPath + @"\Images\logo.jpg";
                System.Web.HttpContext.Current.Session["HOSPEMRGCONTACT"] = "";
                System.Web.HttpContext.Current.Session["CONSOLEAPPYN"] = "Y";
            }
            else
            {
                string ds = comm.GetHospitalInfo(HospUnit);
                DataSet newTable = new DataSet();
                StringReader theReader = new StringReader(ds);
                newTable.ReadXml(theReader);
                if (newTable.Tables.Count > 0 && newTable.Tables[0].Rows.Count > 0)
                {
                    System.Web.HttpContext.Current.Session["UNITCODE"] = newTable.Tables[0].Rows[0]["HOSPUNIT"].ToString().Trim();
                    System.Web.HttpContext.Current.Session["HOSPITALNAME"] = newTable.Tables[0].Rows[0]["HOSPNAME"].ToString().Trim();
                    System.Web.HttpContext.Current.Session["HOSPITALADDRESS"] = newTable.Tables[0].Rows[0]["HOSPADDRESS"].ToString().Trim();
                    System.Web.HttpContext.Current.Session["UNITOF"] = newTable.Tables[0].Rows[0]["UNITOF"].ToString().Trim();
                    string FileName = HttpRuntime.AppDomainAppPath + @"\UnitConfig\" + newTable.Tables[0].Rows[0]["HOSPUNIT"].ToString().Trim() + @"\Images\logo.jpg";
                    if (System.IO.File.Exists(FileName))
                        System.Web.HttpContext.Current.Session["HOSPLOGO"] = FileName;
                    else
                        System.Web.HttpContext.Current.Session["HOSPLOGO"] = HttpRuntime.AppDomainAppPath + @"\Images\logo.jpg";
                    System.Web.HttpContext.Current.Session["HOSPEMRGCONTACT"] = newTable.Tables[0].Rows[0]["EMRGCONTACT"].ToString().Trim();
                    System.Web.HttpContext.Current.Session["CONSOLEAPPYN"] = "N";
                    // KEYCLOAK RELATED CHANGES ADD BY KARTHICK
                    if (newTable.Tables[0].Columns.Contains("IDPBASEADDRESS"))//Condistion is added becasue error was there for this column meenakshi
                    {
                        System.Web.HttpContext.Current.Session["idpbaseaddress"] = newTable.Tables[0].Rows[0]["IDPBASEADDRESS"].ToString().Trim();//@"https://dev-sso.tatamd.com"; // done
                        System.Web.HttpContext.Current.Session["idprealms"] = newTable.Tables[0].Rows[0]["IDPREALMS"].ToString().Trim(); //"Urban-Care";
                        System.Web.HttpContext.Current.Session["idpclientid"] = newTable.Tables[0].Rows[0]["IDPCLIENTID"].ToString().Trim(); //"uc-emr";
                        System.Web.HttpContext.Current.Session["idpclientSecret"] = newTable.Tables[0].Rows[0]["IDPCLIENTSECRET"].ToString().Trim(); //"7iO9e2onjxPRGzIkTtnpZ0MTfLA29zhK";
                        System.Web.HttpContext.Current.Session["idpredirectUri"] = newTable.Tables[0].Rows[0]["IDPREDIRECTURI"].ToString().Trim(); // @"https://emr-sandbox.tatamd.com/webhmis/moduleList";
                    }
                    System.Web.HttpContext.Current.Session["CLINICCODE"] = "";
                    System.Web.HttpContext.Current.Session["CLINICNAME"] = "";
                    System.Web.HttpContext.Current.Session["CLINICTYPE"] = "";
                }
                else
                {
                    Result = "Unit is not configuration";
                }
            }
            return Result;
        }
    }

    //Added By Priyanka on 31/01/2025
    #region Rights
    public class formrights
    {
        public string PrintYN { get; set; }
        public string TranPrintYN { get; set; }
        public string NewYN { get; set; }
        public string ExcelYN { get; set; }
        public string EditYN { get; set; }
        public string ShowYN { get; set; }
        public string Rights { get; set; }
        public string verifyYn { get; set; }
        public string cancelYN { get; set; }
        public string DisplayYN { get; set; }

        public DataSet GetLoginRights(string userid)
        {
            DataSet load = new DataSet();
            DataTable dtEmpty = new DataTable();
            System.Web.HttpContext.Current.Session.Add("FRMRIGHTS", dtEmpty);
            if (userid != "")
            {
                SecurityClient SercRef = new SecurityClient();
                load = OncologyEMR.DataClass.GeneralFunction.FillDatasetXMl(SercRef.getLoginFormRight(userid));
                if (load.Tables.Contains("UserRights"))
                    System.Web.HttpContext.Current.Session.Add("FRMRIGHTS", load.Tables["UserRights"]);
                return load;
            }
            else
            {
                return new DataSet();
            }
        }
        public bool FormRightsCheck(string FormName)
        {
            try
            {
                DataTable Sessiondt = new DataTable();
                Sessiondt = (DataTable)HttpContext.Current.Session["FRMRIGHTS"];
                string strModuleid = HttpContext.Current.Session["ModuleIDGlobal"].ToString();
                DataRow[] sessiondr;
                if (Sessiondt != null && Sessiondt.Rows.Count > 0)
                {
                    sessiondr = Sessiondt.Select("FORMNAME ='" + FormName + "' AND MODULEID='" + strModuleid + "'");
                    if (sessiondr.Length > 0)
                        return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }

    }
    #endregion
    //Added By Priyanka on 31/01/2025
    #region Application Setting
    public class AppSettingConfigMdl : formrights
    {
        public string ImageKeyCD { get; set; }
        public string ModuleCD { get; set; }
        public string Filepath { get; set; }
        public List<DataClass.GeneralFunction.ThreeSelectListItem> ImageList { set; get; }
        public IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem> Module { get; set; }
    }
    #endregion

    //Added By Priyanka on 01/02/2025
    #region Error Log Info
    public class ErrorLogInfoMdl : formrights
    {
        public string ErrorTxt { get; set; }
    }
    #endregion

    #region Unit Selection
    public class UnitSelectionModel
    {
        public string HospUnit { get; set; }
        public IEnumerable<CommonSerRef.SelectLstItem> HospUnitList { set; get; }
    }
    #endregion Unit Selection
}