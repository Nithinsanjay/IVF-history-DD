using OncologyEMR.CommonSerRef;
using OncologyEMR.DataClass;
using OncologyEMR.Oncology;
using OncologyEMR.OncologyServRef;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml;


//using iTextSharp.text;
//using iTextSharp.text.pdf;


////using System.Web.Mvc;

////using Newtonsoft.Json;
//using System.Dynamic;
//using System.Text;
namespace OncologyEMR.Models
{
    public class PatientClinicalHistory
    {


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
        public object GetPatDiagVitalHistory(string MrNo)
        {
            CommonServiceClient Onco = new CommonServiceClient();
             OncologyClient OncoServ = new OncologyClient();
            JavaScriptSerializer ser = new JavaScriptSerializer();
           

            var LstDiagnosis = Onco.DDICDLst();
            var HistoGradeLst = GeneralFunction.GetHitologyGrade();
            var HistoList = Onco.ICDHISTOLst("");
            var CancerSiteList = Onco.GetCRSiteLst();
            var CancerGrpList = Onco.GetCRGrpLst().Where(x => x.Status == "A");
            DataSet dsRecrod = new DataSet();
            dsRecrod.ReadXml(new XmlTextReader(new StringReader(OncoServ.GetPatDiagVitalHistory(MrNo)))); // Onco.GetPatDiagVitalHistory(MrNo)

            var resultList = new List<object>();

            // Always initialize with empty lists
            var diagList = new List<object>();
            var historyList = new List<object>();
            var histologyList = new List<object>();
            var TNMlist = new List<Object>();

            // Table 0 - Diagnosis
            if (dsRecrod.Tables.Count > 1 && dsRecrod.Tables[0].Rows.Count > 0)
            {
                diagList = (from DataRow row in dsRecrod.Tables[0].Rows
                            select new
                            {
                                CODE = row["ICDCODE"].ToString().Trim(),
                                DIAGNAME = LstDiagnosis
                                           .Where(x => x.Value == row["ICDCODE"].ToString().Trim())
                                           .Select(x => x.Text)
                                           .FirstOrDefault() ?? ""
                            }).Cast<object>().ToList();
            }
            resultList.Add(diagList);

            //// Table 1 - Patient history
            //if (dsRecrod.Tables.Count > 2 && dsRecrod.Tables[1].Rows.Count > 0)
            //{
            //    historyList = (from DataRow row in dsRecrod.Tables[1].Rows
            //                   select new
            //                   {
            //                       PERSHIST = row["PERSHIST"].ToString().Trim(),
            //                       MEDIHIST = row["MEDIHIST"].ToString().Trim(),
            //                       FAMHIST = row["FAMHIST"].ToString().Trim()
            //                   }).Cast<object>().ToList();
            //}
            //resultList.Add(historyList);

            if (dsRecrod.Tables.Count > 3 && dsRecrod.Tables[3].Rows.Count > 0)
            {
                TNMlist = (from DataRow row in dsRecrod.Tables[3].Rows
                           select new
                           {
                               TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                               TOPODESC = row["TOPODESC"].ToString().Trim(),
                               TNM = row["TNMPREFIX"].ToString().Trim() + "-" + row["T"].ToString().Trim() + row["N"].ToString().Trim() + row["M"].ToString().Trim(),
                               STAGE = row["STAGE"].ToString().Trim(),
                               SITELEVEL = row["SITELEVEL"].ToString().Trim(),
                               SITELEVELNAME = row["SITELEVEL"].ToString().Trim() == "" ? "" : (CancerSiteList.Where(x => x.Value == row["SITELEVEL"].ToString().Trim() && x.Value == row["SITELEVEL"].ToString().Trim()).Count() > 0 ? CancerSiteList.Where(x => x.Value == row["SITELEVEL"].ToString().Trim() && x.Value == row["SITELEVEL"].ToString().Trim()).FirstOrDefault().Text : ""),
                               TNMSUBSITECODE = row["TNMSUBSITECODE"].ToString().Trim(),
                               TNMSITE = row["TNMSITECODE"].ToString().Trim(),
                               TNMSITENAME = row["TNMSITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["TNMSITECODE"].ToString().Trim(), ""),
                               TNMSUBSITE = row["TNMSUBSITECODE"].ToString().Trim() == "" ? "" : GetSiteSubSite(row["TNMSITECODE"].ToString().Trim(), row["TNMSUBSITECODE"].ToString().Trim()),
                           }).Cast<object>().ToList();
            }
            resultList.Add(TNMlist);
            // Table 4 - Histology
            if (dsRecrod.Tables.Count > 4 && dsRecrod.Tables[4].Rows.Count > 0)
            {
                histologyList = (from DataRow row in dsRecrod.Tables[4].Rows
                                 let grade = row["HGRADE"].ToString().Trim()
                                 select new
                                 {
                                     TOPOCODE = row["TOPOCODE"].ToString().Trim(),
                                     TOPODESC = row["TOPODESC"].ToString().Trim(),
                                     HCODE = row["HCODE"].ToString().Trim(),
                                     HDESC = row["HCODE"].ToString().Trim() == "" ? "" : (HistoList.Where(x => x.Value == row["HCODE"].ToString().Trim()).Count() > 0 ? HistoList.Where(x => x.Value == row["HCODE"].ToString().Trim()).FirstOrDefault().Text : ""),
                                     GRADE = grade,
                                     GRADENAME = string.IsNullOrEmpty(grade) ? "" :
                                        (HistoGradeLst
                                            .Where(x => x.Value == grade
                                                     && x.GradeType == row["HISTOGRADETYPE"].ToString().Trim())
                                            .Select(x => x.Text)
                                            .FirstOrDefault() ?? ""),
                                 }).Cast<object>().ToList();
            }
            resultList.Add(histologyList);

            return resultList.ToArray();
        }



        public object GetRadHistForTBD(string strMrNo, string LabType)
        {
            OncologyClient Onco = new OncologyClient();

            //dsRecrod.ReadXml(new XmlTextReader(new StringReader(Onco.GetPatDemographicalDet(strMrNo))));
            DataSet load = new DataSet();
            DataTable l_oDT = new DataTable();
            object jsonData = "";
            load.ReadXml(new XmlTextReader(new StringReader(Onco.GetRadHistForTBD(strMrNo, LabType))));
            if (load.Tables.Count > 0)
                l_oDT = load.Tables[0];
            if (l_oDT.Rows.Count > 0)
            {
                jsonData = new
                {
                    rows = (from DataRow row in l_oDT.Rows
                            select new
                            {
                                LABTYPECD = row["LABTYPECD"].ToString().Trim(),
                                LABTYPENM = row["LABTYPENM"].ToString().Trim(),
                                TESTCODE = row["TESTCODE"].ToString().Trim(),
                                TESTNAME = row["TESTNAME"].ToString().Trim(),
                                ORDERNO = row["ORDERNO"].ToString().Trim(),
                                RESULTDATE = GeneralFunction.GetDate(row["RESULTDATE"].ToString().Trim()) + " " + row["RESULTTIME"].ToString().Trim(),
                                RESULTTIME = row["RESULTTIME"].ToString().Trim(),
                                SAMLECOLNO = row["SAMLECOLNO"].ToString().Trim(),
                                IMPRESSIONDT = row["IMPRESSIONDT"].ToString().Trim(),  //Added by Murali on 24/02/2026
                                PACSURL = string.IsNullOrWhiteSpace(row["PACSURL"].ToString()) ? "" : row["PACSURL"].ToString().Trim() + "AccessionNumber=" + row["SAMLECOLNO"].ToString().Trim() + "&PatientID=" + strMrNo + "&Username=hisuser&Password=hisuser",    //Added By Roshan On 16-07-2025 As Per karthik Sir 
                                LABDPTCODE = row["LABDPTCODE"].ToString().Trim(),
                                RESULTNO = row["RESULTNO"].ToString().Trim(),
                            }).ToArray()

                };
            }
            return jsonData;
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

        public object GetPACHistList(string mrno)
        {
            try
            {
                OncologyEMRClient oncoClient = new OncologyEMRClient();
                var DoctLst = oncoClient.GetDoctLst("", "D");
                DataSet HistDS = new DataSet();
                HistDS.ReadXml(new XmlTextReader(new StringReader((oncoClient.GetPACList("", "", mrno, "", "")))));
                if (HistDS.Tables.Count > 0 && HistDS.Tables[0].Rows.Count > 0)
                {
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
                                    PACFITTIME = ("" + row1["PACFITTIME"]).ToString(),
                                    PACDONEBY = ("" + row1["PACDONEBY"]).ToString().Trim() == "" ? "" : (DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).Count() > 0 ? DoctLst.Where(x => x.Value == ("" + row1["PACDONEBY"]).ToString().Trim()).FirstOrDefault().Text : ("" + row1["PACDONEBY"]).ToString().Trim()),
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


        public object GetBiposyReport(string MrNo)
        {
            try
            {
                SurgicalHist surg = new SurgicalHist();
                OncologyClient Onco = new OncologyClient();
                DataSet dsRecrod = new DataSet();
                dsRecrod.ReadXml(new XmlTextReader(new StringReader(Onco.GetBiopsyRptTBD(MrNo))));
                if (dsRecrod.Tables.Count == 0)
                    return null;
                var jsonResult = (from DataRow row in dsRecrod.Tables[0].Rows
                                  select new
                                  {
                                      TESTCODE = row["TESTCODE"].ToString().Trim(),
                                      TESTNAME = row["TESTNAME"].ToString().Trim(),
                                      IMPRESSIONDT = DecodeEncodedHtml(row["RESULTDT"].ToString().Trim()),
                                      ORDERBY = row["ORDEREDBY"].ToString().Trim(),
                                      DOCTNAME = row["DOCTNAME"].ToString().Trim(),
                                      REPORTEDBY = row["REPORTEDBY"].ToString().Trim(),
                                      VERIFIEDBY = row["VERIFIEDBY"].ToString().Trim(),
                                      RESULTDATE = GeneralFunction.GetDate(row["RESULTDATE"].ToString()),
                                      RESULTNO = row["RESULTNO"].ToString().Trim(),
                                  }).ToArray();
                return jsonResult;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string DecodeEncodedHtml(string encoded)
        {
            return HttpUtility.UrlDecode(encoded);
        }

    }
}