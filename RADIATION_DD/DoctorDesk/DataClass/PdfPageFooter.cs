using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebJupCommonTemplates.DataClass
{
    public class PrintHeaderFooter : PdfPageEventHelper
    {
        private PdfContentByte pdfContent;
        private iTextSharp.text.pdf.PdfTemplate pageNumberTemplate;
        private BaseFont baseFont;
        private string printTime;

        public string Title { get; set; }
        public static bool blNormal { get; set; }
        public static byte[] Sign1 { get; set; }
        public static byte[] Sign2 { get; set; }
        public static byte[] Sign3 { get; set; }
        public static string Profile1 { get; set; }
        public static string Profile2 { get; set; }
        public static string Profile3 { get; set; }
        public static string Name1 { get; set; }
        public static string Name2 { get; set; }
        public static string Name3 { get; set; }


        public override void OnOpenDocument(PdfWriter writer, Document document)
        {
            // printTime = "Partial Reproduction of Report not permitted. This report relates to sample received by the laboratory.";
            baseFont = BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            pdfContent = writer.DirectContent;
            pageNumberTemplate = pdfContent.CreateTemplate(50, 50);
        }

        public override void OnStartPage(PdfWriter writer, Document document)
        {
            if (document.PageNumber == 1)
            {
                // document.SetPageSize(PageSize.A4);
                document.SetMargins(200f, 140f, 130f, 200f);
            }
            else
            {
                document.SetPageSize(PageSize.A4);
                document.SetMargins(10F, 140f, 130f, 200f);

            }
            document.NewPage();
            // base.OnStartPage(writer, document);


        }

        public override void OnEndPage(PdfWriter writer, Document document)
        {
            Paragraph footer = new Paragraph("THANK YOU", FontFactory.GetFont(FontFactory.TIMES, 10, iTextSharp.text.Font.NORMAL));
            footer.Alignment = Element.ALIGN_RIGHT;
            PdfPTable footerTbl = new PdfPTable(1);
            footerTbl.TotalWidth = 300;
            footerTbl.HorizontalAlignment = Element.ALIGN_CENTER;

            PdfPCell cell = new PdfPCell(footer);
            cell.Border = 0;
            cell.PaddingLeft = 10;

            footerTbl.AddCell(cell);
            footerTbl.WriteSelectedRows(0, -1, 415, 200, writer.DirectContent);
        }

        public override void OnCloseDocument(PdfWriter writer, Document document)
        {
            base.OnCloseDocument(writer, document);

            //pageNumberTemplate.BeginText();
            //pageNumberTemplate.SetFontAndSize(baseFont, 8);
            //pageNumberTemplate.SetTextMatrix(0, 0);
            //pageNumberTemplate.ShowText(string.Empty + (writer.PageNumber - 1));
            //pageNumberTemplate.EndText();
        }
    }
}