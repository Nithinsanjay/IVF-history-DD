using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

namespace OncologyEMR.Pdf
{
    public class CrystalReportPdfResult
    {
        private readonly byte[] _contentBytes;

        public byte[] CrystalReportPdf(string reportPath, object dataSet)
        {
            try
            {
                ReportDocument reportDocument = new ReportDocument();
                //MemoryStream oStream = null;
                reportDocument.Load(reportPath);
                reportDocument.SetDataSource(dataSet);
                //oStream = (MemoryStream)reportDocument.ExportToStream(ExportFormatType.PortableDocFormat);
                return StreamToBytes(reportDocument.ExportToStream(ExportFormatType.PortableDocFormat));
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        //public byte[] DynamicCrystalReportPdf(ReportDocument reportDocument, object dataSet)
        //{

        //    reportDocument.SetDataSource(dataSet);
        //    return StreamToBytes(reportDocument.ExportToStream(ExportFormatType.PortableDocFormat));
        //}
        public byte[] DynamicCrystalReportPdf(ReportDocument reportDocument, object dataSet, string MarginTop = "0", string MarginBottom = "0")
        {
            try
            {
                reportDocument.SetDataSource(dataSet);
                PageMargins margins;
                margins = reportDocument.PrintOptions.PageMargins;
                margins.topMargin = MarginTop.Trim() != "" && Convert.ToInt32(MarginTop) > 0 ? Convert.ToInt32(MarginTop) : margins.topMargin;
                margins.bottomMargin = MarginBottom.Trim() != "" && Convert.ToInt32(MarginBottom) > 0 ? Convert.ToInt32(MarginBottom) : margins.bottomMargin;
                reportDocument.PrintOptions.ApplyPageMargins(margins);
                //return StreamToBytes(reportDocument.ExportToStream(ExportFormatType.PortableDocFormat));
                byte[] byteArray = null;
                using (System.IO.Stream oStream = reportDocument.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat))
                {
                    byteArray = new byte[oStream.Length];
                    oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));
                }
                return byteArray; // Using statement is added to auto clear the memory as per suggested by karthik and final discussion.
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                reportDocument.Close();
                reportDocument.Dispose();
            }
        }


        private static byte[] StreamToBytes(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }


    }
    public class BinaryContentResult : ActionResult
    {
        private readonly string contentType;
        private readonly byte[] contentBytes;
        private readonly string FileName;
        public BinaryContentResult(byte[] contentBytes, string contentType, string strFileName)
        {
            this.contentBytes = contentBytes;
            this.contentType = contentType;
            this.FileName = strFileName;
        }

        public override void ExecuteResult(ControllerContext context)
        {
            var response = context.HttpContext.Response;
            response.Clear();

            response.ContentType = this.contentType;
            response.AddHeader("content-disposition", "filename=" + this.FileName + ".pdf");
            using (var stream = new MemoryStream(this.contentBytes))
            {
                stream.WriteTo(response.OutputStream);
                stream.Flush();
            }
            response.Flush();
        }
    }
}