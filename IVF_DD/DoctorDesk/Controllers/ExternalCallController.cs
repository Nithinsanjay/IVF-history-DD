using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OncologyEMR.Controllers;
using OncologyEMR.Models;
using System.Data;
using System.IO;
using OncologyEMR.DataClass;
using OncologyEMR.Oncology;
using System.Xml;
using OncologyEMR.Pdf;
using OncologyEMR.App_Start;
using OncologyEMR.CommonSerRef;
using Newtonsoft.Json;
using NReco.PdfGenerator;
using WebJupCommonTemplates.DataClass;


namespace OncologyEMR.Controllers
{
    public class ExternalCallController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetPACReportPrint(object[] Parameters)
        {
            AccountModel AcctMdl = new AccountModel();
            System.Web.HttpContext.Current.Session["UNITCODE"] = Parameters[0].ToString();
            AcctMdl.SetHospitalUnit(Parameters[0].ToString());
            try
            {
                PACMdl Mdl = new PACMdl();
                List<byte[]> pdfByteArrays = new List<byte[]>();
                List<byte[]> PACprintarr = Mdl.PrintPACRpt(Parameters[1].ToString(), Parameters[2].ToString(), Parameters[3].ToString(), "Y", Mdl, "Y", ("" + Parameters[4]).ToString());
                byte[] Printarr = PdfTemplate.concatAndAddContent(PACprintarr);
                string base64Pdf = Convert.ToBase64String(Printarr);
                return Json(base64Pdf, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public JsonResult GetChemoReportPrint(object[] Parameters)
        {
            AccountModel AcctMdl = new AccountModel();
            System.Web.HttpContext.Current.Session["UNITCODE"] = Parameters[0].ToString();
            AcctMdl.SetHospitalUnit(Parameters[0].ToString());
            try
            {
                Planning Mdl = new Planning();

                string MRNo = ("" + Parameters[1]).ToString();
                string ConsultNo = ("" + Parameters[2]).ToString();
                string PlanNo = ("" + Parameters[3]).ToString();
                string CycleNo = ("" + Parameters[4]).ToString();
                string StrProtocole = ("" + Parameters[5]).ToString();
                string LetterHeaderYN = ("" + Parameters[6]).ToString();

                byte[] printarr = Mdl.PrintChemoPlan(MRNo, ConsultNo, PlanNo, CycleNo, StrProtocole, LetterHeaderYN);

                string base64Pdf = Convert.ToBase64String(printarr);
                return Json(base64Pdf, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
