using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OncologyEMR.DataClass
{
    public class ExcelConvert : ActionResult
    {
        private readonly string contentType;
        private readonly byte[] contentBytes;
        private readonly string FileName;
        public ExcelConvert(byte[] contentBytes, string contentType, string strFileName)
        {
            this.contentBytes = contentBytes;
            this.contentType = contentType;
            this.FileName = strFileName;
        }
        public override void ExecuteResult(ControllerContext context)
        {
            var response = context.HttpContext.Response;
            response.Clear();
            response.Cache.SetCacheability(HttpCacheability.Public);
            response.ContentType = this.contentType;
            response.AddHeader("content-disposition", "filename=" + this.FileName + ".xls");
            using (var stream = new MemoryStream(this.contentBytes))
            {
                stream.WriteTo(response.OutputStream);
                stream.Flush();
            }
        }

        

    }
    public class ExcelResult : ActionResult
    {
        public string XMLStream { get; set; }
        public string FileName { get; set; }
        public override void ExecuteResult(ControllerContext context)
        {
            context.HttpContext.Response.Buffer = true;
            context.HttpContext.Response.Clear();
            context.HttpContext.Response.AddHeader("content-disposition", "attachment; filename=" + FileName);
            context.HttpContext.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            context.HttpContext.Response.Charset = "";
            context.HttpContext.Response.ContentEncoding = System.Text.Encoding.Unicode;
            context.HttpContext.Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            context.HttpContext.Response.Write(XMLStream);
        }
    }
}
