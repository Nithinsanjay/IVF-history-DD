using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OncologyEMR.DataClass
{
    public class BillListDetails
    {
        # region "Param"
        private string srchBillFromDate = "";
        private string srchBillToDate = "";
        private string srchMrNo = "";
        private string srchPatCatGcd = "";
        private string srchexemptionCatg = "";
        private string srchDoctorCode = "";
        private string srchRefDoctCode = "";
        private string srchCounter = "";
        private string srchUser = "";
        private string SrchCompName = "";

        public string SrchCompName1
        {
            get { return SrchCompName; }
            set { SrchCompName = value; }
        }
        public string SrchRefDoctCode
        {
            get { return srchRefDoctCode; }
            set { srchRefDoctCode = value; }
        }

        public string SrchDoctorCode
        {
            get { return srchDoctorCode; }
            set { srchDoctorCode = value; }
        }
        public string SrchPatCatGcd
        {
            get { return srchPatCatGcd; }
            set { srchPatCatGcd = value; }
        }


        public string ExemptionCatg
        {
            get { return srchexemptionCatg; }
            set { srchexemptionCatg = value; }
        }


        public string SrchMrNo
        {
            get { return srchMrNo; }
            set { srchMrNo = value; }
        }

        public string SrchBillToDate
        {
            get { return srchBillToDate; }
            set { srchBillToDate = value; }
        }

        public string SrchBillFromDate
        {
            get { return srchBillFromDate; }
            set { srchBillFromDate = value; }
        }
        # endregion
    }
}