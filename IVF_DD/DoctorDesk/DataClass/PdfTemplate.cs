using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OncologyEMR.DataClass
{
    using System.IO;

    using iTextSharp.text;
    using iTextSharp.text.html.simpleparser;
    using iTextSharp.text.pdf;
    using System.Web;
    using System.Data;
    using System.Globalization;
    using System;
   // using ReportManagement;
    using System.Collections;
    using iTextSharp.text.html;
    using iTextSharp.tool.xml;
    using iTextSharp.tool.xml.pipeline.html;
    using iTextSharp.tool.xml.html;
    using iTextSharp.tool.xml.css;
    using System.Text;
    using iTextSharp.tool.xml.pipeline.end;
    using iTextSharp.tool.xml.pipeline.css;
    using iTextSharp.tool.xml.parser;

    /// <summary>
    /// This class is responsible for rendering a html text string to a PDF document using the html renderer of iTextSharp.
    /// </summary>
    public class PdfTemplate
    {
        private const int HorizontalMargin = 40;
        private const int VerticalMargin = 40;
        public byte[] AddWatermark(byte[] bytes, string strWaterMark, List<string> lstProfile = null, List<string> lstName = null)
        {
            var font = BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED);
            Font blackFont = FontFactory.GetFont("Arial", 12, Font.NORMAL, BaseColor.BLACK);
            using (var ms = new MemoryStream(10 * 1024))
            {
                using (var reader = new PdfReader(bytes))
                using (var stamper = new PdfStamper(reader, ms))
                {
                    int times = reader.NumberOfPages;
                    for (int i = 1; i <= times; i++)
                    {
                        var dc = stamper.GetOverContent(i);
                        AddWaterMark(dc, strWaterMark, font, 48, 35, BaseColor.BLACK, reader.GetPageSizeWithRotation(i));
                        AddPageNumber(dc, "Page " + i.ToString() + " of " + times.ToString(), font, 10, 0, BaseColor.BLACK, reader.GetPageSizeWithRotation(i));

                        if (i == times)
                        {
                            if (lstName == null)
                                break;

                            PdfPTable nTbl = new PdfPTable(3);

                            //float[] st = { 100 };
                            //nTbl.SetWidths(st);
                            nTbl.TotalWidth = PageSize.A4.Width - 80;
                            nTbl.SpacingBefore = 10f;
                            Font timesRoman12Font = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 12, Font.BOLD, BaseColor.BLACK);
                            Font timesRoman9Font = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 9, BaseColor.BLACK);
                            nTbl.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                            if (lstName.Count > 0)
                            {
                                PdfPCell cell = new PdfPCell(new Phrase(lstName[0].ToString(), timesRoman12Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);
                                cell = new PdfPCell(new Phrase(lstName[1].ToString(), timesRoman12Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);
                                cell = new PdfPCell(new Phrase(lstName[2].ToString(), timesRoman12Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);

                                cell = new PdfPCell(new Phrase(lstProfile[0].ToString(), timesRoman9Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);
                                cell = new PdfPCell(new Phrase(lstProfile[1].ToString(), timesRoman9Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);
                                cell = new PdfPCell(new Phrase(lstProfile[2].ToString(), timesRoman9Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);

                            }
                            nTbl.WriteSelectedRows(0, 2, 40, 105, stamper.GetOverContent(i));

                        }

                    }
                    stamper.Close();
                }
                return ms.ToArray();

            }

        }


        public static void AddSignature(PdfContentByte dc, string text,
            BaseFont font, float fontSize, float angle, BaseColor color,
            Rectangle realPageSize, Rectangle rect = null, float xval = 0.0f, float yval = 0.0f)
        {
            var gstate = new PdfGState { FillOpacity = 0.3f, StrokeOpacity = 0.5f };
            dc.SaveState();
            dc.SetGState(gstate);
            dc.SetColorFill(color);
            dc.BeginText();
            dc.SetFontAndSize(font, fontSize);
            var ps = rect ?? realPageSize; /*dc.PdfDocument.PageSize is not always correct*/
            var x = (ps.Right + ps.Left) / 2;
            var y = (ps.Bottom) + 30;
            dc.ShowTextAligned(Element.ALIGN_CENTER, text, x + xval, y + yval, angle);
            dc.EndText();
            dc.RestoreState();
        }
        public static void AddPageNumber(PdfContentByte dc, string text, BaseFont font, float fontSize, float angle, BaseColor color, Rectangle realPageSize, Rectangle rect = null)
        {
            var gstate = new PdfGState { FillOpacity = 0.3f, StrokeOpacity = 0.5f };
            dc.SaveState();
            dc.SetGState(gstate);
            dc.SetColorFill(color);
            dc.BeginText();
            dc.SetFontAndSize(font, fontSize);
            var ps = rect ?? realPageSize; /*dc.PdfDocument.PageSize is not always correct*/
            var x = (ps.Right + ps.Left) / 2;
            var y = (ps.Bottom) + 30;
            dc.ShowTextAligned(Element.ALIGN_CENTER, text, x, y, angle);
            dc.EndText();
            dc.RestoreState();
        }
        public static void AddWaterMark(PdfContentByte dc, string text, BaseFont font, float fontSize, float angle, BaseColor color, Rectangle realPageSize, Rectangle rect = null)
        {
            var gstate = new PdfGState { FillOpacity = 0.3f, StrokeOpacity = 0.5f };
            dc.SaveState();
            dc.SetGState(gstate);
            dc.SetColorFill(color);
            dc.BeginText();
            dc.SetFontAndSize(font, fontSize);
            var ps = rect ?? realPageSize; /*dc.PdfDocument.PageSize is not always correct*/
            var x = (ps.Right + ps.Left) / 2;
            var y = (ps.Bottom + ps.Top) / 2;
            dc.ShowTextAligned(Element.ALIGN_CENTER, text, x, y, angle);
            dc.EndText();
            dc.RestoreState();
        }


        public static byte[] concatAndAddContent(List<byte[]> pdf)
        {
            byte[] all;

            using (MemoryStream ms = new MemoryStream())
            {
                Document doc = new Document();
                PdfWriter writer = PdfWriter.GetInstance(doc, ms);
                doc.Open();
                PdfContentByte cb = writer.DirectContent;
                PdfImportedPage page;
                PdfReader reader;
                PdfPTable pdftable = new PdfPTable(10);
                foreach (byte[] p in pdf)
                {
                    reader = new PdfReader(p);
                    int pages = reader.NumberOfPages;
                    for (int i = 1; i <= pages; i++)
                    {
                        doc.NewPage();
                        page = writer.GetImportedPage(reader, i);
                        cb.AddTemplate(page, 0, 0);
                    }
                }
                doc.Close();
                all = ms.GetBuffer();
                ms.Flush();
                ms.Dispose();
            }
            return all;
        }

        public byte[] AddLabWatermark(byte[] bytes, string strWaterMark, List<string> lstProfile = null, List<string> lstName = null, List<byte[]> lstSign = null)
        {
            var font = BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED);
            Font blackFont = FontFactory.GetFont("Arial", 12, Font.NORMAL, BaseColor.BLACK);
            using (var ms = new MemoryStream(10 * 1024))
            {
                using (var reader = new PdfReader(bytes))
                using (var stamper = new PdfStamper(reader, ms))
                {
                    int times = reader.NumberOfPages;
                    for (int i = 1; i <= times; i++)
                    {
                        var dc = stamper.GetOverContent(i);
                        //AddWaterMark(dc, strWaterMark, font, 48, 35, BaseColor.BLACK, reader.GetPageSizeWithRotation(i));
                        AddPageNumber(dc, "Page " + i.ToString() + " of " + times.ToString(), font, 10, 0, BaseColor.BLACK, reader.GetPageSizeWithRotation(i));

                        if (i == times)
                        {
                            if (lstName == null)
                                break;

                            PdfPTable nTbl = new PdfPTable(4);

                            //float[] st = { 100 };
                            //nTbl.SetWidths(st);
                            nTbl.TotalWidth = PageSize.A4.Width - 80;
                            nTbl.SpacingBefore = 10f;
                            Font timesRoman12Font = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 12, Font.BOLD, BaseColor.BLACK);
                            Font timesRoman9Font = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 9, BaseColor.BLACK);
                            nTbl.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                            if (lstName.Count > 0)
                            {
                                PdfPCell cell;

                                if (lstSign[0].Length > 0)
                                {
                                    iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(lstSign[0]);
                                    img.ScaleAbsolute(100f, 20f);
                                    cell = new PdfPCell(img);
                                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                    cell.BorderWidth = 0;
                                    nTbl.AddCell(cell);
                                }
                                else
                                {
                                    cell = new PdfPCell();
                                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                    cell.BorderWidth = 0;
                                    nTbl.AddCell(cell);
                                }


                                if (lstSign[1].Length > 10)
                                {
                                    iTextSharp.text.Image img1 = iTextSharp.text.Image.GetInstance(lstSign[1]);
                                    img1.ScaleAbsolute(100f, 20f);
                                    cell = new PdfPCell(img1);
                                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                    cell.BorderWidth = 0;
                                    nTbl.AddCell(cell);
                                }

                                else
                                {
                                    cell = new PdfPCell();
                                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                    cell.BorderWidth = 0;
                                    nTbl.AddCell(cell);
                                }

                                if (lstSign[2].Length > 10)
                                {
                                    iTextSharp.text.Image img1 = iTextSharp.text.Image.GetInstance(lstSign[2]);
                                    img1.ScaleAbsolute(100f, 20f);
                                    cell = new PdfPCell(img1);
                                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                    cell.BorderWidth = 0;
                                    nTbl.AddCell(cell);
                                }

                                else
                                {
                                    cell = new PdfPCell();
                                    cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                    cell.BorderWidth = 0;
                                    nTbl.AddCell(cell);
                                }
                                cell = new PdfPCell();
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);

                                cell = new PdfPCell(new Phrase(lstName[0].ToString(), timesRoman12Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);
                                cell = new PdfPCell(new Phrase(lstName[1].ToString(), timesRoman12Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);

                                cell = new PdfPCell(new Phrase(lstName[2].ToString(), timesRoman12Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);


                                cell = new PdfPCell(new Phrase(lstName[3].ToString(), timesRoman12Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);

                                cell = new PdfPCell(new Phrase(lstProfile[0].ToString(), timesRoman9Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);
                                cell = new PdfPCell(new Phrase(lstProfile[1].ToString(), timesRoman9Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);
                                cell = new PdfPCell(new Phrase(lstProfile[2].ToString(), timesRoman9Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);

                                cell = new PdfPCell(new Phrase(lstProfile[3].ToString(), timesRoman9Font));
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                cell.BorderWidth = 0;
                                nTbl.AddCell(cell);


                            }
                            nTbl.WriteSelectedRows(0, 3, 40, 160, stamper.GetOverContent(i));
                        }


                    }
                    stamper.Close();
                }
                return ms.ToArray();

            }

        }

        public byte[] AddLabPreviewWatermark(byte[] bytes, string strWaterMark)
        {
            var font = BaseFont.CreateFont(BaseFont.TIMES_BOLD, BaseFont.WINANSI, BaseFont.EMBEDDED);
            using (var ms = new MemoryStream(10 * 1024))
            {
                using (var reader = new PdfReader(bytes))
                using (var stamper = new PdfStamper(reader, ms))
                {
                    int times = reader.NumberOfPages;
                    for (int i = 1; i <= times; i++)
                    {
                        var dc = stamper.GetOverContent(i);
                        AddWaterMark(dc, strWaterMark, font, 120, 40, BaseColor.LIGHT_GRAY, reader.GetPageSizeWithRotation(i));
                    }
                    stamper.Close();
                }
                return ms.ToArray();
            }
        }
    }

}