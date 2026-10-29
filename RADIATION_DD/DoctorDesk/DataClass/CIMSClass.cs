using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Xml;
using System.Xml.Xsl;
//using FastTrack5;

namespace OncologyEMR.DataClass
{
    public class MaterialDetails
    {
        public string MtrlRefCode { get; set; }
        public string BrandName { get; set; }
        public string Generic { get; set; }
        public string GenericCode { get; set; }
        public string Strength { get; set; }
        public string StrengthUnit { get; set; }
        public string Form { get; set; }
    }

    public class SelectLstItem1
    {
        public bool Selected { get; set; }

        public string Text { get; set; }

        public string Value { get; set; }

        public string Status { get; set; }
    }

    public class CIMSClass
    {
        System.ComponentModel.Container components = null;
        //FastTrack5.FastTrack_Creator FT = new FastTrack5.FastTrack_Creator();
        //FastTrack5.IFastTrack_Server SVR = null;
        public CIMSClass()
		{
			string sInitStr = "";
            //string sInitStr1 = "";
            //sInitStr = "<Initialize> <host>'192.168.0.126'GEQ5A2N93T</host> <domain>'WORKGROUP'</domain> <user> userid ='Ashutosh'</user> <pass> password ='123'</pass> </Initialize>";
            sInitStr = "<Initialize><DataFile password='7ph9f5TLja' path='" + DataPath + "'/></Initialize>";

            //SVR = FT.CreateServer(sInitStr, out sReturnValue, out sGUID);
				
			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

        //string DataPath = "D:\\Jupiter\\FastTrackData_IN_JupiterHospital_Q12020.mrc";
        //string DataPath = "D:\\CIMSDatabase\\FastTrackData_IN_JupiterHospital_Q12020.mrc";
        string DataPath = "E:\\CIMS\\Jupiter\\FastTrackData_IN_JupiterHospital_Q32019.mrc";
        string sReturnValue = "";
        string sGUID = "";

        private string GetCallByService(string strReq)
        {
            var result = "";
			var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://192.168.3.223:8080/RestFTWebService/FTRequest/xmlrequest/");  // Current CIMS URL in Live added by nitesh
            //var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://192.168.3.223:8080/FastTrackWebService/FTRequest/xmlrequest/");  // OLD CIMS URL was in Live
            //var httpWebRequest = (HttpWebRequest)WebRequest.Create("http://182.75.240.38:8080/FastTrackWebService/cimsws/xmlrequest/"); // Testing URL
            httpWebRequest.ContentType = "text/plain";
            httpWebRequest.Method = "POST";
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                streamWriter.Write(strReq);
                streamWriter.Flush();
                streamWriter.Close();
            }
            try
            {
                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();

                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    result = streamReader.ReadToEnd();
                }

                return result;
            }
            catch (Exception ex)
            {
                return "";
            }
        }

        private string GetCall(string strReq)
        {
            try
            {
                string sQueryResults = "";
                string sQueryString = strReq;
                //sReturnValue = SVR.RequestXML(sQueryString, out sQueryResults);
                return (string.Empty + sReturnValue);
            }
            catch (Exception ex)
            {
                return "";
            }
        }

        public List<SelectLstItem1> SearchMaterial(string sText)
        {
            string strReq = "<Request><List><Product><ByName>" + sText + "</ByName></Product></List></Request>";
            string result = GetCall(strReq);
            List<SelectLstItem1> selList = new List<SelectLstItem1>();
            if (result != "")
            {
                var xmlElem = System.Xml.Linq.XDocument.Parse(result);
                foreach (System.Xml.Linq.XElement element in xmlElem.Descendants("Product"))
                {
                    MaterialDetails m = GetMtrlDetails(element.Attribute("reference").Value);
                    selList.Add(new SelectLstItem1() { Text = element.Attribute("name").Value + " (" + m.Generic + ")", Value = element.Attribute("reference").Value, Status = "A" });
                }
            }
            return selList;
        }

        public MaterialDetails GetMtrlDetails(string strRefId)
        {
            try
            {
                string strReq = "<Request><Detail><Product reference=\"" + strRefId + "\"><Items/><Packages/><TherapeuticClasses/><ATCCodes/><Companies/><Documents/></Product></Detail></Request>";
                string result = GetCall(strReq);
                MaterialDetails mtrlDet = new MaterialDetails();
                if (result != "")
                {
                    var xmlElem = System.Xml.Linq.XDocument.Parse(result);


                    foreach (System.Xml.Linq.XElement element in xmlElem.Descendants("Form"))
                    {
                        mtrlDet.Form = element.Attribute("name").Value;
                    }
                    List<MaterialDetails> lstMtrl = new List<MaterialDetails>();
                    int I = 0;
                    foreach (System.Xml.Linq.XElement element in xmlElem.Descendants("Molecule"))
                    {
                        mtrlDet.Generic += ((mtrlDet.Generic + "") == "" ? "" : ",") + (element.Attribute("name").Value + " " + element.Attribute("strength").Value + element.Attribute("strengthUnit").Value);// : "," + element.Attribute("name").Value);
                        mtrlDet.GenericCode += ((mtrlDet.GenericCode + "") == "" ? "" : ":") + (element.Attribute("reference").Value);
                        //mtrlDet.Generic += ((mtrlDet.Generic + "") == "" ? element.Attribute("name").Value : "," + element.Attribute("name").Value);
                        mtrlDet.Strength = (I == 0) ? element.Attribute("strength").Value : "";
                        mtrlDet.StrengthUnit = (I == 0) ? element.Attribute("strengthUnit").Value : "";
                        I += 1;
                    }
                    foreach (System.Xml.Linq.XElement element in xmlElem.Descendants("Product"))
                    {
                        mtrlDet.MtrlRefCode = element.Attribute("reference").Value;
                        mtrlDet.BrandName = element.Attribute("name").Value;
                    }
                    // foreach (System.Xml.Linq.XElement element in xmlElem.Descendants("ProductLine"))
                    // {
                    // mtrlDet.BrandName = element.Attribute("name").Value;
                    // }

                }
                return mtrlDet;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public string GetMonographMtrl(string strMtrlRefCode)
        {
            string strReq = "<Request><Content><Product reference=\"" + strMtrlRefCode + "\" /></Content></Request>";
            string result = GetCall(strReq);
            string strPAth = System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath;
            XslCompiledTransform xslT = new XslCompiledTransform();
            XsltSettings xslSet = new XsltSettings(true, true);
            xslT.Load(strPAth+ "MIMS Stylesheet-CDSDefault_bySeverity.xsl", xslSet, new XmlUrlResolver());//ResultData
            //C:\Users\SWAPNIL\Desktop\WebServiceForFastTrack\WcfFastTrack\WcfFastTrack\App_Data\
            StringWriter results = new StringWriter();
            if (result != "")
            {
                using (XmlReader reader = XmlReader.Create(new StringReader(result)))
                {
                    xslT.Transform(reader, null, results);
                }
            }
            return results.ToString();
        }
        public string GetMtrlInteraction(List<string> strMtrl)
        {
            //strMtrl.Add("{DAABD513-72A6-41F2-ABEC-DDAEABBC18D9}");
            //strMtrl.Add("{997BCAA6-86AE-4940-BA4A-8ED750FE565A}");
            //strMtrl.Add("{C826573C-9E23-4D20-A092-4A3D17025FD4}");
            try
            {
                string strReq = "<Request><Interaction><Prescribing>";
                foreach (string str in strMtrl)
                {
                    strReq += "<Product reference=\"" + str + "\" />";
                }
                strReq += "</Prescribing></Interaction><References/><PatientProfile></PatientProfile></Request>";
                string result = GetCall(strReq);
                string strPAth = System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath;
                XslCompiledTransform xslT = new XslCompiledTransform();
                XsltSettings xslSet = new XsltSettings(true, true);
                xslT.Load(strPAth + "MIMS Stylesheet-CDSDefault_bySeverity.xsl", xslSet, new XmlUrlResolver());//ResultData
                //C:\Users\SWAPNIL\Desktop\WebServiceForFastTrack\WcfFastTrack\WcfFastTrack\App_Data\
                StringWriter results = new StringWriter();
                if (result != "")
                {
                    using (XmlReader reader = XmlReader.Create(new StringReader(result)))
                    {
                        xslT.Transform(reader, null, results);
                    }
                }
                return results.ToString();
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}