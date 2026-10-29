using OncologyEMR.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
//using OncologyEMR.CommonSerRef;
//using OncologyEMR.SecRefServ;
using OncologyEMR.Oncology;
using OncologyEMR.CommonSerRef;
using System.Net.Http;
using OncologyEMR.DataClass;
using System.IO;
using System.Xml;
using Newtonsoft.Json;
using System.Drawing.Imaging;

namespace OncologyEMR.Controllers
{
    public class AccountController : Controller
    {
        [OutputCache(NoStore = true, Duration = 0)]
        public ActionResult Login(string LogOutYN)
        {
            try
            {
                Session.Clear();
                Session.Abandon();
                Session.RemoveAll();
                Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
                Response.Cache.SetValidUntilExpires(false);
                Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();
                AccountModel mod = new AccountModel();
                if ("" + LogOutYN == "Y")
                {
                    return RedirectToAction("Login", "Account");
                }
                if (GeneralFunction.GetAppsettingUnitWiseValue("IDP_KEYCLOAK_AUTH").ToString().ToUpper() == "TRUE")
                {
                    return Redirect(GeneralFunction.GetAppsettingUnitWiseValue("HMIS_LOGIN_URL").ToString().ToUpper()); 
                }
                return View(mod);
            }
            catch (Exception ex)
            {
                throw new Exception("Something went wrong.");
            }
        }

        public ActionResult GetLoginCheck(AccountModel log1)
        {
            try
            {
                AccountModel Mdl = new AccountModel();
                CommonServiceClient com = new CommonServiceClient();
                OncologyEMRClient OncolgyEMR = new OncologyEMRClient();
                string flg = "false";
                string IPAddress = System.Web.HttpContext.Current.Session["MchIPAddress"].ToString();
                var result = OncolgyEMR.ChkLogin(log1.UserID.ToUpper(), log1.Password.ToUpper());
                System.Web.HttpContext.Current.Session["ModuleIDGlobal"] = "32";
                System.Web.HttpContext.Current.Session["ModuleName"] = "EHR (Doctor Desk) / Triage";
                System.Web.HttpContext.Current.Session["UNITCODE"] = "";
                System.Web.HttpContext.Current.Session["REDIRECTHMIS"] = "N";
                System.Web.HttpContext.Current.Session["RedirectToDD"] = "Y";
                if (result == true)
                {
                    object[] userGUID = com.ChkLoginNew(log1.UserID, log1.Password, IPAddress);
                    string UnitRights = ("" + userGUID[4]).ToString().Trim();
                    System.Web.HttpContext.Current.Session.Add("UserToken", userGUID[3]);
                    System.Web.HttpContext.Current.Session.Add("LastLogIn", userGUID[1]);
                    System.Web.HttpContext.Current.Session.Add("UNITRIGHTS", UnitRights);
                    System.Web.HttpContext.Current.Session["SINGLEUNITYN"] = "Y";
                    if (UnitRights == "" && userGUID[3].ToString() == "")
                    {
                        flg = userGUID[2].ToString() == "" ? "No Unit Right Found." : userGUID[2].ToString();
                    }
                    else if (UnitRights != "" && UnitRights.Split('|').Length == 1)
                    {
                        System.Web.HttpContext.Current.Session["UNITCODE"] = UnitRights;
                        Mdl.SetHospitalUnit(UnitRights);
                        flg = SetDoctorRights(log1.UserID.ToUpper().ToString());
                    }
                    else
                    {
                        System.Web.HttpContext.Current.Session["SINGLEUNITYN"] = "N";
                        System.Web.HttpContext.Current.Session["gOncoUserId"] = log1.UserID.ToString().ToUpper();
                        flg = SetDoctorRights(log1.UserID.ToUpper().ToString());
                    }
                }
                else
                {
                    flg = "false";
                }
                return Json(flg, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string error = "";
                if (ex.Message == "There is no row at position 0.")
                    error = "false";
                else
                    error = ex.Message;
                return Json(error, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult UnitSelection()
        {
            UnitSelectionModel Mdl = new UnitSelectionModel();
            Mdl.HospUnit = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString().Trim();
            Mdl.HospUnitList = GeneralFunction.GetUnitRightsList();
            return View(Mdl);
        }

        public JsonResult ChangeUnitSel(string HospUnit)
        {
            AccountModel Mdl = new AccountModel();
            string Result = "";
            System.Web.HttpContext.Current.Session["UNITCODE"] = HospUnit;
            Mdl.SetHospitalUnit(HospUnit);
            string OncogId = ("" + System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString().Trim();
            Result = SetDoctorRights(OncogId);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

        //add by karthick for mob app 20191128
        public ActionResult LoginCheckMob(string TokenId)
        {
            try
            {
                DataTable dt = new DataTable();
                string URL = Request.Url.ToString();
                string flg = "false";

                MobSecServRef.SecurityClient secur = new MobSecServRef.SecurityClient();
                string Userid = secur.ConvertTokenToUser(TokenId, "", "");
                if (Userid != "")
                {
                    Session["MOBACCESS"] = true;
                    flg = SetDoctorRights(Userid);
                    //------------------------------
                }
                else
                {
                    flg = "false";
                }
                if (flg == "doctor")
                {
                    return Redirect(URL.Substring(0, URL.LastIndexOf("Account") + 7) + "/MenuList?pageId=Menu");
                }
                else if (flg == "staff")
                {
                    return Redirect(URL.Substring(0, URL.LastIndexOf("Account")) + "/ClinicalNotes/ClinicEntry");
                }
                else
                {
                    return Redirect(URL.Substring(0, URL.LastIndexOf("Account") + 7) + "/Login");
                }
                //return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string error = "";
                if (ex.Message == "There is no row at position 0.")
                    error = "false";
                else
                    error = ex.Message;
                return Json(error, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult LoginRedirectHMIS(string TokenId, string UnitRights, string token = "", string Rtoken = "", int Exp = 0, string UnitCode = "")
        {
            try
            {
                AccountModel Mdl = new AccountModel();
                System.Web.HttpContext.Current.Session["REDIRECTHMIS"] = "Y";
                System.Web.HttpContext.Current.Session["RedirectToDD"] = "N";
                System.Web.HttpContext.Current.Session["UNITCODE"] = UnitCode;
                System.Web.HttpContext.Current.Session["ModuleIDGlobal"] = "32";
                System.Web.HttpContext.Current.Session["UNITRIGHTS"] = UnitRights;
                System.Web.HttpContext.Current.Session["SINGLEUNITYN"] = "Y";
                if (UnitRights == "" || UnitRights.Split('|').Length > 1)
                    System.Web.HttpContext.Current.Session["SINGLEUNITYN"] = "N";
                Mdl.SetHospitalUnit(UnitCode);
                string URL = Request.UrlReferrer != null ? Request.UrlReferrer.ToString() : "";// Request.Url.ToString();
                string flg = "false";
                var baseUrl = "";
                if (URL != "" && URL.ToUpper().Contains("MODULELIST"))
                {
                    string[] str = URL.Split('/');
                    baseUrl = str[0] + "//" + str[2];
                    if (GeneralFunction.GetAppsettingUnitWiseValue("IDP_KEYCLOAK_AUTH").ToString().ToUpper() == "TRUE")
                    {
                        if (token == "")
                        {
                            return Redirect(baseUrl + "/WebHmis/Account/Login");
                        }
                        else
                        {
                            Session.Add("REFTOKEN", Rtoken);
                            Session.Add("Exp", Exp);
                            var tokenreposnse = GeneralFunction.CheckAuthToken(token, Rtoken, true);
                            if (tokenreposnse != null)
                            {
                                if (tokenreposnse.active == false)
                                {
                                    return Redirect(baseUrl + "/WebHmis/Account/Login");
                                }
                                else
                                {
                                    CommonServiceClient secur = new CommonServiceClient();
                                    string Userid = secur.GetUserIDFromGUID(TokenId);
                                    if (Userid != "" && tokenreposnse.preferred_username.ToString().Trim().ToUpper() == Userid.ToString().Trim().ToUpper())
                                    {
                                        flg = SetDoctorRights(Userid);
                                        //------------------------------
                                        Session.Add("AUTHTOKEN", token);
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        CommonServiceClient secur = new CommonServiceClient();
                        string Userid = secur.GetUserIDFromGUID(TokenId);
                        if (Userid != "")
                        {
                            flg = SetDoctorRights(Userid);
                            //------------------------------
                        }
                    }
                    
                    //baseUrl = URL.Substring(0, URL.ToUpper().IndexOf("/ACCOUNT"));
                    //baseUrl = baseUrl.Substring(0, baseUrl.LastIndexOf("/"));
                     str = URL.Split('/');
                    baseUrl = str[0] + "//" + str[2];    
                    
                }
                if (flg == "doctor")
                {
                    if (GeneralFunction.GetAppsettingUnitWiseValue("NewUI").ToString().ToUpper() == "Y")
                    {
                        return Redirect(baseUrl + "/WebEHR/SinglePage/SinglePageMenuList");
                    }
                    else
                    {
                        return Redirect(baseUrl + "/WebEHR/Account/MenuList");
                    }
                }
                else if (flg == "staff")
                {
                    return Redirect(baseUrl + "/WebEHR/ClinicalNotes/ClinicEntry");
                }
                else
                {
                    if (GeneralFunction.GetAppsettingUnitWiseValue("IDP_KEYCLOAK_AUTH").ToString().ToUpper() == "TRUE")
                    {
                        return Redirect(baseUrl + "/WebHmis/Account/Login");
                    }
                    else
                    {
                    return Redirect(baseUrl + "/WebEHR/Account/Login");
                }
                        
                }
                //return Json("", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string error = "";
                if (ex.Message == "There is no row at position 0.")
                    error = "false";
                else
                    error = ex.Message;
                return Json(error, JsonRequestBehavior.AllowGet);
            }
        }

        public string SetDoctorRights(string Userid)
        {
            try
            {
                OncologyEMRClient com = new OncologyEMRClient();
                string flg = "false";
                DataSet load = new DataSet();
                load.ReadXml(new System.Xml.XmlTextReader(new System.IO.StringReader(com.getLoginFormRights(Userid))));
                System.Web.HttpContext.Current.Session["gOncoUserId"] = Userid.ToString().ToUpper();
                System.Web.HttpContext.Current.Session["gDoctName"] = ("" + load.Tables["UserInfo"].Rows[0]["USERNAME"]).ToString();
                System.Web.HttpContext.Current.Session["gDoctCode"] = ("" + load.Tables["UserInfo"].Rows[0]["DOCTCODE"]).ToString().Trim();
                System.Web.HttpContext.Current.Session["ICUAUTHYN"] = ("" + load.Tables["UserInfo"].Rows[0]["ICUAUTHYN"]).ToString().Trim();
                System.Web.HttpContext.Current.Session["SHOWPRESYN"] = ("" + load.Tables["UserInfo"].Rows[0]["SHOWPRESYN"]).ToString().Trim(); 
                System.Web.HttpContext.Current.Session["staffUserName"] = ""; 
                System.Web.HttpContext.Current.Session["CIMYN"] = Convert.ToString("" + load.Tables["UserInfo"].Rows[0]["CIMYN"]).Trim();
                System.Web.HttpContext.Current.Session["RMOYN"] = ("" + load.Tables["UserInfo"].Rows[0]["RMOYN"]).ToString().Trim();
                System.Web.HttpContext.Current.Session["AUTHYN"] = ("" + load.Tables["UserInfo"].Rows[0]["ICUAUTHYN"]).ToString().Trim();
               
                if(Convert.ToInt32(load.Tables["UserInfo"].Rows[0]["CNT"]) == 0)
                {
                    flg = "false";
                }
                else if(load.Tables["UserInfo"].Rows[0]["NURSEYN"].ToString().Trim() == "Y")
                {
                    flg = "staff";
                    System.Web.HttpContext.Current.Session["staffUserName"] = ("" + load.Tables["UserInfo"].Rows[0]["USERNAME"]).ToString();
                }
                else if (System.Web.HttpContext.Current.Session["AUTHYN"].ToString().Trim() == "Y" || load.Tables["UserInfo"].Rows[0]["DOCTCODE"].ToString().Trim() != "" || System.Web.HttpContext.Current.Session["RMOYN"].ToString().Trim() == "Y")
                {
                    if (load.Tables["UserInfo"].Rows[0]["DOCTCODE"].ToString().Trim() != "")
                    {
                        System.Web.HttpContext.Current.Session["AUTHYN"] = "N";
                    }
                        flg = "doctor";
                }
                else 
                {
                    flg = "false";
                }

                    //if (load.Tables["UserInfo"].Rows[0]["DOCTCODE"].ToString().Trim() != "")
                    //{
                    //    System.Web.HttpContext.Current.Session["AUTHYN"] = "N";
                    //}

                    //if (Convert.ToInt32(load.Tables["UserInfo"].Rows[0]["CNT"]) == 0 && load.Tables["UserInfo"].Rows[0]["ICUAUTHYN"].ToString().Trim() != "Y")
                    //{
                    //    flg = "false";
                    //}
                    //else
                    //{
                    //    if (load.Tables["UserInfo"].Rows[0]["DOCTCODE"].ToString().Trim() != "" || System.Web.HttpContext.Current.Session["ICUAUTHYN"].ToString().Trim() == "Y" || System.Web.HttpContext.Current.Session["RMOYN"].ToString().Trim() == "Y")  // || System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().Trim() == "SYSTEM"
                    //    {
                    //        flg = "doctor";
                    //    }
                    //    else
                    //    {
                    //        flg = "staff";
                    //        System.Web.HttpContext.Current.Session["staffUserName"] = ("" + load.Tables["UserInfo"].Rows[0]["USERNAME"]).ToString();
                    //    }
                    //}


                    DataSet load1 = new DataSet();
                if (System.Web.HttpContext.Current.Session["gDoctCode"] != null)
                {
                    load1.ReadXml(new System.Xml.XmlTextReader(new System.IO.StringReader(com.GetDoctDetails(Convert.ToString(System.Web.HttpContext.Current.Session["gDoctCode"])))));
                }
                if (load1.Tables.Contains("Table"))
                {
                    //System.Web.HttpContext.Current.Session["gDoctSign"] = ("" + load1.Tables["Table"].Rows[0]["SIGN"]).ToString().Trim();
                }
                return flg;
            }
            catch (Exception ex)
            {
                string error = "";
                if (ex.Message == "There is no row at position 0.")
                    error = "false";
                else
                    error = ex.Message;
                return error;
            }
        }
        
        public IEnumerable<OncologyEMR.Oncology.SelectLstItem> DoctrClincList { get; set; }

        public ActionResult GetDctrClinic()
        {
            OncologyEMRClient comm = new OncologyEMRClient();
            DoctrClincList = comm.GetClinicByDoctor(Session["gDoctCode"].ToString());
            return Json(DoctrClincList, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetDctrAllClinic()
        {
            OncologyEMRClient comm = new OncologyEMRClient();
            DataSet load = new DataSet();
            load.ReadXml(new System.Xml.XmlTextReader(new System.IO.StringReader(comm.GetClinicByDoctorWithClinicType(Session["gDoctCode"].ToString()))));
            var rows = (from DataRow row in load.Tables[0].Rows
                        select new
                        {
                            ClinicCode = "" + row["CODE"].ToString().Trim(),
                            ClinicType = "" + row["CLINICTYPE"].ToString().Trim(),
                            ClinicName = GeneralFunction.CheckDblToSingleQuote(row["NAME"].ToString().Trim())                        
                        }).ToArray();
            return Json(rows, JsonRequestBehavior.AllowGet);
        }

        public ActionResult MenuList(string pageId = "Menu")
        {
            DataTable dtEmpty = new DataTable();
            formrights Frights = new formrights();
            if (("" + System.Web.HttpContext.Current.Session["gOncoUserId"]).ToString().Trim() != "")
                Frights.GetLoginRights(System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().ToUpper());
            else
                System.Web.HttpContext.Current.Session.Add("FRMRIGHTS", dtEmpty);
            System.Web.HttpContext.Current.Session["PageId"] = pageId;
            ViewBag.RightUnitList = GeneralFunction.GetUnitRightsList();
            return View();
        }
         
        public ActionResult ChangePIN(string strUserID, string strPIN)
        {
            OncologyEMRClient com = new OncologyEMRClient();
            var result = com.SetPIN(strUserID.ToUpper(), strPIN);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        
        public ActionResult GetPINCheck(string strUSerID, string strPIN)
        {
            DataTable dt = new DataTable();
            string flg = "false";
            OncologyEMRClient com = new OncologyEMRClient();
            var result = com.ChkPIN(strUSerID.ToUpper(), strPIN);
            if (result == true)
            {
                DataSet load = new DataSet();
                load.ReadXml(new System.Xml.XmlTextReader(new System.IO.StringReader(com.getLoginFormRights(strUSerID.ToUpper()))));
                System.Web.HttpContext.Current.Session["gOncoUserId"] = strUSerID.ToString().ToUpper();
                System.Web.HttpContext.Current.Session["gDoctName"] = ("" + load.Tables["UserInfo"].Rows[0]["USERNAME"]).ToString();
                System.Web.HttpContext.Current.Session["gDoctCode"] = ("" + load.Tables["UserInfo"].Rows[0]["DOCTCODE"]).ToString().Trim();
                if (Convert.ToInt32(load.Tables["UserInfo"].Rows[0]["CNT"]) == 0)
                {
                    flg = "false";
                }
                else
                {
                    flg = "doctor";
                }
            }
            else
            {
                flg = "false";
            }
            return Json(flg, JsonRequestBehavior.AllowGet);
        }

        public ActionResult PINLogin()
        {
            try
            {
                AccountModel mod = new AccountModel();

                return View(mod);
            }
            catch (Exception ex)
            {
                throw new Exception("Something went wrong.");

            }
        }

        public ActionResult SetPIN()
        {
            try
            {
                AccountModel mod = new AccountModel();
                return View(mod);
            }
            catch (Exception ex)
            {
                throw new Exception("Something went wrong.");

            }
        }

        //Meenakshi Added on 08-10-2024
        public string RedirectToOnco(string strMRNo)
        {
            CommonServiceClient com = new CommonServiceClient();
            //string strEncryptUserID = com.Encrypt(strUserId);
            string strEncryptUserID = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().Trim();
            string strPreviousPage = Request.UrlReferrer.ToString().ToUpper();
            string[] str = strPreviousPage.Split('/');
            if (strPreviousPage.ToUpper().Contains("DOCTORDESK"))
                return str[0] + "//" + str[2] + "/WebOncology/Account/OncologyHome?refID=" + strEncryptUserID + "&&MRNo=" + strMRNo;
            else
                return "about:blank";
        }

        #region Application Setting
        public ActionResult AppSettingConfig()
        {
            CommonServiceClient comclient = new CommonServiceClient();
            AppSettingConfigMdl AppSetting = new AppSettingConfigMdl();
            AppSetting.ImageList = DataClass.GeneralFunction.GetImageList();
            ViewBag.varImgLst = DataClass.GeneralFunction.GetImageList();
            AppSetting.Module = comclient.GetModuleList();
            ViewBag.ModuleLst = comclient.GetModuleList();
            AppSetting.Rights = GeneralFunction.assignRightToModel(AppSetting, "AppSettingConfig");
            return View(AppSetting);
        }
        private byte[] CompressImage(Stream inputStream, long compressionQuality)
        {
            using (var inputImage = System.Drawing.Image.FromStream(inputStream))
            {
                ImageCodecInfo jpgEncoder = GetEncoderInfo("image/jpeg");
                EncoderParameters encoderParameters = new EncoderParameters(1);
                encoderParameters.Param[0] = new EncoderParameter(Encoder.Quality, compressionQuality);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    inputImage.Save(memoryStream, jpgEncoder, encoderParameters);
                    return memoryStream.ToArray();
                }
            }
        }
        private ImageCodecInfo GetEncoderInfo(string mimeType)
        {
            ImageCodecInfo[] codecs = ImageCodecInfo.GetImageEncoders();
            foreach (ImageCodecInfo codec in codecs)
            {
                if (codec.MimeType == mimeType)
                {
                    return codec;
                }
            }
            return null;
        }
        public JsonResult SaveImageSetting(AppSettingConfigMdl AppSetting)
        {
            try
            {
                HttpFileCollectionBase files = Request.Files;
                if (Request.Files.Count > 0)
                {
                    HttpPostedFileBase file = files[0];
                    if (file != null && file.ContentLength > 0)
                    {
                        string UnitCD = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
                        string filePath = UnitCD == "00" ? Path.Combine(HttpRuntime.AppDomainAppPath, "Images", AppSetting.Filepath.Trim()) : Path.Combine(HttpRuntime.AppDomainAppPath, "UnitConfig", UnitCD, "Images", AppSetting.Filepath.Trim());
                        string directoryPath = Path.GetDirectoryName(filePath);
                        if (System.IO.File.Exists(filePath))
                        {
                            System.IO.File.Delete(filePath);
                        }
                        if (!Directory.Exists(directoryPath))
                        {
                            Directory.CreateDirectory(directoryPath);
                        }
                        string filetype = file.ContentType.ToString();
                        if (filetype.Contains("image"))
                        {
                            byte[] compressedImageBytes;
                            compressedImageBytes = CompressImage(file.InputStream, 60);
                            using (FileStream fs = new FileStream(filePath, FileMode.Create))
                            {
                                fs.Write(compressedImageBytes, 0, compressedImageBytes.Length);
                            }
                            return Json("Uploaded Successfully", JsonRequestBehavior.AllowGet);
                        }
                        else
                        {
                            file.SaveAs(filePath);
                            return Json("Uploaded Successfully", JsonRequestBehavior.AllowGet);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            }
            return Json("Sucess", JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveWebConfig(string Act, string Module, string FormName, string Key, string Value, string Description, string CreatedBy, string CreatedDtTm)
        {
            string Result = "";
            string PrevValue = "";
            string UnitCD = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            string appSettingFile;
            if (string.IsNullOrEmpty(UnitCD) || UnitCD == "00")
            {
                appSettingFile = Path.Combine(Server.MapPath("~"), "AppSettings.config");
            }
            else
            {
                string unitFolder = Server.MapPath("~/UnitConfig/" + UnitCD);
                appSettingFile = Path.Combine(unitFolder, "AppSetting.config");
            }
            string directoryPath = Path.GetDirectoryName(appSettingFile);
            if (!Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }

            if (!System.IO.File.Exists(appSettingFile))
            {
                string defaultContent = @"<?xml version=""1.0"" encoding=""utf-8""?><configuration><appSettings></appSettings></configuration>";
                System.IO.File.WriteAllText(appSettingFile, defaultContent);
            }

            XmlDocument doc = new XmlDocument();
            doc.Load(appSettingFile);
            XmlNodeList nodes = doc.SelectNodes(UnitCD == "00" ? "/appSettings/add" : "/configuration/appSettings/add");

            //Duplicate Key Restriction
            DataTable Keys = new DataTable();
            Keys.Columns.Add("Key");
            foreach (XmlNode node in nodes)
            {
                XmlAttribute keyAttribute = node.Attributes["key"];
                if (keyAttribute != null)
                {
                    DataRow row = Keys.NewRow();
                    row["Key"] = keyAttribute.Value;
                    Keys.Rows.Add(row);
                }
            }
            if (Act == "N")
            {
                DataRow[] Dr = Keys.Select("Key = '" + Key + "'");
                if (Dr.Length > 0)
                {
                    Result = "Key Already Exists";
                }
                else
                {
                    string Comment = Module + " ! Added By :" + CreatedBy + " ! " + CreatedDtTm + " ! " + Description + " ! " + FormName;
                    XmlComment AddComment = doc.CreateComment(Comment);
                    XmlNode root = doc.SelectSingleNode(UnitCD == "00" ? "/appSettings" : "/configuration/appSettings");
                    root.AppendChild(AddComment);
                    XmlElement NewKey = doc.CreateElement("add");
                    NewKey.SetAttribute("key", Key);
                    NewKey.SetAttribute("value", Value);
                    root.AppendChild(NewKey);
                    doc.Save(appSettingFile);
                }
            }
            else if (Act == "E")
            {
                XmlNode KeyNode = nodes.Cast<XmlNode>().FirstOrDefault(node => node.Attributes["key"].Value == Key);
                if (KeyNode != null)
                {
                    PrevValue = KeyNode.Attributes["value"].Value;
                    KeyNode.Attributes["value"].Value = Value;
                    XmlNode previousNode = KeyNode.PreviousSibling;
                    if (previousNode != null && previousNode.NodeType == XmlNodeType.Comment)
                    {
                        string Desc = previousNode.InnerText.Trim();
                        string[] DescArray = Desc.Split('!');
                        if (DescArray.Length == 4)
                            previousNode.InnerText = Module + " ! " + DescArray[1].Trim() + " ! " + DescArray[2].Trim() + " ! " + Description + " ! " + FormName;
                        else
                            previousNode.InnerText = Module + " ! Added By :" + CreatedBy + " ! " + CreatedDtTm + " ! " + Description + " ! " + FormName;
                    }
                    else
                    {
                        string Comment = Module + " ! Added By :" + CreatedBy + " ! " + CreatedDtTm + " ! " + Description + " ! " + FormName;
                        XmlComment newComment = doc.CreateComment(Comment);
                        KeyNode.ParentNode.InsertBefore(newComment, KeyNode);
                    }
                    doc.Save(appSettingFile);
                }
                else
                {
                    //Result = "Key is not found";
                    string Comment = Module + " ! Added By :" + CreatedBy + " ! " + CreatedDtTm + " ! " + Description + " ! " + FormName;
                    XmlComment AddComment = doc.CreateComment(Comment);
                    XmlNode root = doc.SelectSingleNode(UnitCD == "00" ? "/appSettings" : "/configuration/appSettings");
                    root.AppendChild(AddComment);
                    XmlElement NewKey = doc.CreateElement("add");
                    NewKey.SetAttribute("key", Key);
                    NewKey.SetAttribute("value", Value);
                    root.AppendChild(NewKey);
                    doc.Save(appSettingFile);
                }
            }
            if (Result == "")
            {
                Result = "Sucess";
                StreamWriter logWriter;
                string path = System.Web.Hosting.HostingEnvironment.MapPath("~/log");
                if (UnitCD != "00")
                {
                    path = Path.Combine(HttpRuntime.AppDomainAppPath, "UnitConfig", UnitCD);
                }
                if (!Directory.Exists(path))
                    Directory.CreateDirectory(path);
                path = Path.Combine(path, "WebConfigLog.txt");
                if (System.IO.File.Exists(path))
                    logWriter = System.IO.File.AppendText(path);
                else
                    logWriter = System.IO.File.CreateText(path);
                logWriter.WriteLine("=>" + DateTime.Now + " | " + System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().ToUpper().Trim() + " | " +
                     " Key : " + Key +
                     "; Previous Value : " + PrevValue +
                     " ,New Value : " + Value);

                logWriter.WriteLine("-----------------------------------------------------------------------------------------------");
                logWriter.Close();
            }
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetWebConfig()
        {
            string UnitCD = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            string appSettingFile = Path.Combine(Server.MapPath("~"), "AppSettings.config");
            bool DefAppSetting = true;

            if (!string.IsNullOrEmpty(UnitCD) && UnitCD != "00")
            {
                DefAppSetting = false;
                string unitFolder = Server.MapPath("~/UnitConfig/" + UnitCD);
                appSettingFile = Path.Combine(unitFolder, "AppSetting.config");
                string directoryPath = Path.GetDirectoryName(appSettingFile);
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }
                if (!System.IO.File.Exists(appSettingFile))
                {
                    string defaultContent = @"<?xml version=""1.0"" encoding=""utf-8""?><configuration><appSettings></appSettings></configuration>";
                    System.IO.File.WriteAllText(appSettingFile, defaultContent);
                }
            }
            DataTable DT = new DataTable();
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(appSettingFile);
                XmlNodeList nodes = doc.SelectNodes(DefAppSetting == true ? "/appSettings/add" : "/configuration/appSettings/add");
                DT.Columns.Add("KEY");
                DT.Columns.Add("VALUE");
                DT.Columns.Add("DESCRIPTION");
                DT.Columns.Add("PREVVALUE");
                DT.Columns.Add("MODULE");
                DT.Columns.Add("CREATEDBY");
                DT.Columns.Add("CREATEDONAT");
                DT.Columns.Add("FORMNAME");
                foreach (XmlNode node in nodes)
                {
                    DataRow newRow = DT.NewRow();
                    newRow["KEY"] = node.Attributes["key"].Value;
                    newRow["VALUE"] = node.Attributes["value"].Value;
                    newRow["PREVVALUE"] = node.Attributes["value"].Value;
                    if (node.PreviousSibling != null && node.PreviousSibling.NodeType == XmlNodeType.Comment)
                    {
                        if (node.PreviousSibling.InnerText.Trim().ToUpper() != "IGNORE" && node.PreviousSibling.InnerText.Trim() != "")
                        {
                            string Desc = node.PreviousSibling.InnerText.Trim();
                            string[] DescArray = Desc.Split('!');
                            newRow["MODULE"] = "";
                            newRow["CREATEDBY"] = "";
                            newRow["CREATEDONAT"] = "";
                            newRow["DESCRIPTION"] = DescArray[0].Trim();
                            newRow["FORMNAME"] = "";
                            if (DescArray.Length == 5 && DescArray[1].Trim().Split(':').Length > 1)
                            {
                                newRow["MODULE"] = DescArray[0].Trim();
                                newRow["CREATEDBY"] = DescArray[1].Trim().Split(':')[1];
                                newRow["CREATEDONAT"] = DescArray[2].Trim();
                                newRow["DESCRIPTION"] = DescArray[3].Trim();
                                newRow["FORMNAME"] = DescArray[4].Trim();
                            }
                            DT.Rows.Add(newRow);
                        }
                    }
                    else
                    {
                        newRow["MODULE"] = "";
                        newRow["CREATEDBY"] = "";
                        newRow["CREATEDONAT"] = "";
                        newRow["DESCRIPTION"] = "";
                        newRow["FORMNAME"] = "";
                        DT.Rows.Add(newRow);
                    }
                }
                doc.Save(appSettingFile);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return Json(Newtonsoft.Json.JsonConvert.SerializeObject(DT), JsonRequestBehavior.AllowGet);
        }
        public ActionResult PrintExcelWebConfigListData(string data)
        {
            DataTable df = new DataTable();
            try
            {
                df = JsonConvert.DeserializeObject<DataTable>(data);
                if (df.Columns.Contains("PREVVALUE"))
                    df.Columns.Remove("PREVVALUE");
                df.Columns["MODULE"].ColumnName = "Module";
                df.Columns["KEY"].ColumnName = "Key";
                df.Columns["VALUE"].ColumnName = "Value";
                df.Columns["DESCRIPTION"].ColumnName = "Description";
                df.Columns["CREATEDBY"].ColumnName = "Created By";
                df.Columns["CREATEDONAT"].ColumnName = "Created Date / Time";
                df.Columns["FORMNAME"].ColumnName = "Form Name";
                df.Columns["Module"].SetOrdinal(0);
                df.Columns["Form Name"].SetOrdinal(1);
                df.Columns["Key"].SetOrdinal(2);
                df.Columns["Value"].SetOrdinal(3);
                df.Columns["Description"].SetOrdinal(4);
                string AllData = GeneralFunction.getHeaderFooterExcel("Application Configurations", "", "");
                TempData["printdata"] = AllData.ToString();
                return Json("SUCCESS", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ActionResult DisplayExcelWebConfigList()
        {
            try
            {
                MemoryStream outmeomery = new MemoryStream();
                string printdata = TempData["printdata"] as string;
                return new DataClass.ExcelResult
                {
                    FileName = "Application Configurations List.xls",
                    XMLStream = printdata
                };
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public JsonResult GetWebConfigLogInfo()
        {
            string UnitCD = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            string filePath = Path.Combine(Server.MapPath("~/log"), "WebConfigLog.txt");
            if (UnitCD != "00")
            {
                filePath = Path.Combine(HttpRuntime.AppDomainAppPath, "UnitConfig", UnitCD, "WebConfigLog.txt");
            }

            string directoryPath = Path.GetDirectoryName(filePath);
            if (!Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }
            if (!System.IO.File.Exists(filePath))
            {
                System.IO.File.WriteAllText(filePath, "");
                return Json("", JsonRequestBehavior.AllowGet);
            }
            string Text = System.IO.File.ReadAllText(filePath);
            return Json(Text, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetImage(string FileName)
        {
            string UnitCD = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]).ToString();
            string filePath = UnitCD == "00" ? Path.Combine(HttpRuntime.AppDomainAppPath, "Images", FileName) : Path.Combine(HttpRuntime.AppDomainAppPath, "UnitConfig", UnitCD, "Images", FileName);
            if (string.IsNullOrEmpty(FileName))
            {
                return Json(new { success = false, message = "File Name is Empty." }, JsonRequestBehavior.AllowGet);
            }
            if (!System.IO.File.Exists(filePath))
            {
                return Json(new { success = true, imageDataUrl = "" }, JsonRequestBehavior.AllowGet);
            }
            FileName = filePath;
            byte[] imageBytes = System.IO.File.ReadAllBytes(FileName);
            string base64String = Convert.ToBase64String(imageBytes);
            string imageDataUrl = "data:image/png;base64," + base64String;
            return Json(new { success = true, imageDataUrl = imageDataUrl }, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region Error Log Info
        public ActionResult ErrorLogInfo()
        {
            ErrorLogInfoMdl Mdl = new ErrorLogInfoMdl();
            string path = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "" || ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "00" ? System.Web.Hosting.HostingEnvironment.MapPath("~/log") : System.Web.Hosting.HostingEnvironment.MapPath("~/UnitConfig/" + ("" + System.Web.HttpContext.Current.Session["UNITCODE"] + "/"));
            string filePath = Path.Combine(path, "ErrorLog.txt");
            Mdl.Rights = GeneralFunction.assignRightToModel(Mdl, "ErrorLogInfo");
            return View(Mdl);
        }
        public JsonResult GetErrolog(string Type)
        {
            string Result = "";
            string path = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "" || ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "00" ? System.Web.Hosting.HostingEnvironment.MapPath("~/log") : System.Web.Hosting.HostingEnvironment.MapPath("~/UnitConfig/" + ("" + System.Web.HttpContext.Current.Session["UNITCODE"] + "/"));
            string filePath = Path.Combine(path, "ErrorLog.txt");
            if (Type == "S")
            {
                filePath = "C:\\inetpub\\ErrorLogs\\ServiceErrorLog.txt";
            }

            if (System.IO.File.Exists(filePath))
            {
                Result = System.IO.File.ReadAllText(filePath);
            }
            else
            {
                string directoryPath = Path.GetDirectoryName(filePath);
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }
                if (!System.IO.File.Exists(filePath))
                {
                    System.IO.File.WriteAllText(filePath, "");
                    Result = "";
                }
            }
            return Json(Result, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ClearErrorLog(string Type)
        {
            string path = ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "" || ("" + System.Web.HttpContext.Current.Session["UNITCODE"]) == "00" ? System.Web.Hosting.HostingEnvironment.MapPath("~/log") : System.Web.Hosting.HostingEnvironment.MapPath("~/UnitConfig/" + ("" + System.Web.HttpContext.Current.Session["UNITCODE"] + "/"));
            string filePath = Path.Combine(path, "ErrorLog.txt");
            if (Type == "S")
            {
                filePath = "C:\\inetpub\\ErrorLogs\\ServiceErrorLog.txt";
            }
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.WriteAllText(filePath, "");
            }
            return Json("Error Log Cleared Successfully.", JsonRequestBehavior.AllowGet);
        }
        #endregion

        public JsonResult GetDoctCode()
        {
            CommonServiceClient comclient = new CommonServiceClient();
            string Result = "success";
            if (System.Web.HttpContext.Current.Session["gDoctCode"] == null)
                return Json("Doctor", JsonRequestBehavior.AllowGet);
            //if (System.Web.HttpContext.Current.Session["UNITCODE"] == null)
            //    return Json("unit", JsonRequestBehavior.AllowGet);
            //This Code for User Can Login Only One Device at the time
            //string Userid = comclient.GetUserIDFromGUID(System.Web.HttpContext.Current.Session["UserToken"].ToString().Trim());
            //if (string.IsNullOrEmpty(Userid)) 
            //    return Json("USER", JsonRequestBehavior.AllowGet);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }

        public string SetClinic(string ClinicCode, string ClinicName, string ClinicType)
        {
            string Result = "Success";
            System.Web.HttpContext.Current.Session["CLINICCODE"] = ClinicCode;
            System.Web.HttpContext.Current.Session["CLINICNAME"] = ClinicName;
            System.Web.HttpContext.Current.Session["CLINICTYPE"] = ClinicType;
            return Result;
        }

        public JsonResult SetDoctorSessionMaintainence()
        {
            AccountModel Mdl = new AccountModel();
            string ClinicCode =  System.Web.HttpContext.Current.Session["CLINICCODE"].ToString().Trim();
            string ClinicName = System.Web.HttpContext.Current.Session["CLINICNAME"].ToString().Trim();
            string ClinicType = System.Web.HttpContext.Current.Session["CLINICTYPE"].ToString().Trim();
            SetDoctorRights(System.Web.HttpContext.Current.Session["gOncoUserId"].ToString().Trim());
            Mdl.SetHospitalUnit(System.Web.HttpContext.Current.Session["UNITCODE"].ToString().Trim());
            SetClinic(ClinicCode, ClinicName, ClinicType);
            System.Web.HttpContext.Current.Session["MchIPAddress"] = System.Web.HttpContext.Current.Session["MchIPAddress"].ToString();
            System.Web.HttpContext.Current.Session["gOncoUserId"] = System.Web.HttpContext.Current.Session["gOncoUserId"].ToString();
            System.Web.HttpContext.Current.Session["ModuleIDGlobal"] = "32";
            System.Web.HttpContext.Current.Session["ModuleName"] = "EHR (Doctor Desk) / Triage";
            System.Web.HttpContext.Current.Session["REDIRECTHMIS"] = System.Web.HttpContext.Current.Session["REDIRECTHMIS"].ToString();
            System.Web.HttpContext.Current.Session["RedirectToDD"] = System.Web.HttpContext.Current.Session["RedirectToDD"].ToString();
            System.Web.HttpContext.Current.Session["UserToken"] = System.Web.HttpContext.Current.Session["UserToken"].ToString();
            System.Web.HttpContext.Current.Session["LastLogIn"] = System.Web.HttpContext.Current.Session["LastLogIn"].ToString();
            System.Web.HttpContext.Current.Session["UNITRIGHTS"] = System.Web.HttpContext.Current.Session["UNITRIGHTS"].ToString();
            System.Web.HttpContext.Current.Session["SINGLEUNITYN"] = System.Web.HttpContext.Current.Session["SINGLEUNITYN"].ToString();
            return Json("", JsonRequestBehavior.AllowGet);
        }

        public ActionResult KeepSessionAlive()
        {
            try
            {
                if (Session != null && Session["gOncoUserId"] != null)
                {
                    return Json("success", JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json("expired", JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ClearServerSession()
        {
            try
            {
                if (Session != null)
                {
                    Session.Clear();
                    Session.Abandon();
                }
                return Json("success", JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json("error", JsonRequestBehavior.AllowGet);
            }
        }
    }
}
