<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.InvestigationVerify>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	
	
		<div style="float:right;">
			<%--<a class="button1 button1-Addnew" id="myAdd11"  style="margin-bottom: 10px;margin-top: -10px;" onclick="ClearAllData()">--%>
			<a class="button1 button1-green" id="myAdd11"  style="margin-bottom: 1.5%;" onclick="ClearAllData()">
				<i class="fa fa-refresh"></i>
				Clear
			</a>
    </div>
    <div style="width:100%;text-align:left">
				<a class="button1 button1-green" id="divForBack"  style="margin-bottom: 1.5%;" onclick="SetpageDirctn()">
					<i class="fa fa-arrow-left"></i>
					<strong>Back</strong>
				</a>
    </div>
	  <div id="divMains" class="row" style="width:100%;margin-left: 0px !important;display: flex; flex-wrap: wrap;">

			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
								<span  id="DATE1"  class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">From </span>
								<input type="text"  class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" id="RptFrmDate"  readonly />
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
								<span id="DATE2"  class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">To </span>
								<input type="text"   class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" id="RptToDate" readonly />
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
								<span id="Dept"  class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold; ">Department </span>
								<select id="txtLabDepartment"   class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" onchange="getLabDeptwiseTest(this)">
									<option>--Select--</option>
								</select>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
								<span id="MrNo" class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">MR No. </span>
								<input type="text" id="txtMrNo"  class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" />
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
								<span id="Name" class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold; ">Pat. Name </span>
								<input type="text" id="txtPatName"  class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" />
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
						<span id="Mobile" class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold; ">Mobile No. </span>
								<input type="text" id="txtMobileNo"  class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" />
			</div>

			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
								<span id="MrNo" class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">Test Name </span>
								<%--<input type="text" id="txtTest"  class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" />--%>
								<select id="txtTest"   class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" >
									<option>--Select--</option>
								</select>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
								<span id="Name" class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold; ">Sample No. </span>
								<input type="text" id="txtSampleNo"  class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" />
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
						<span id="Mobile" class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold; ">Ref. Doctor </span>
						<%--		<input type="text" id="txtRefDr"  class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" />--%>
					<select id="txtRefDr"   class="col-xs-8 col-sm-8 col-md-8 col-lg-6 PaddingZero" >
						<option>--Select--</option>
					</select>
			</div>
			<div id="divRadio" class="col-xs-12 col-sm-12 col-md-6 col-lg-6 RowMargin" style="display: flex;align-items: center;">
				 <div class="col-xs-12 col-sm-12" style="display:flex;vertical-align: middle;">
						<input type="radio" name="Verify" id="rbtnTechVeriY" value="Y"  onclick = "rbtnTVYClick()">
								<label class="RadioLbl">Tech. Verified</label>
								<input type="radio"  class="col-3" name="Verify" id="rbtnTechVeriN" value="N" onclick = "rbtnTVNClick()">
								<label class="RadioLbl">Rejected</label>
								<input type="radio"  class="col-3" name="Verify" id="rbtnDrVerify" value="D"  checked onclick = "rbtnTVDClick()">
								<label class="RadioLbl">Dr. Verified</label>
				 </div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 RowMargin" style="float:right">
					<a class="button1 button1-green" id="btnSearch" style="float:right" ><i class="fa fa-search"></i>Search</a>

			</div>

	  </div>
    <div id="divMain" style="width:100%;margin-left: 0px !important;">

       <%-- <div class=""  style="width: 100%;display: flex;flex-wrap: wrap;align-items: center;">--%>
            <%-- added by vijeta on 23rd July 2018--%>
<%--            <div style="width: 100%;display: flex;flex-wrap: wrap;align-items: center;flex-direction:row;" id="divDates">
							<div class="col-sm-12 col-md-6 col-lg-3">
								<span  id="DATE1"  class="col-xs-5" style="display: inline-block; font-size: 13px; font-weight: bold;">From </span>
								<input type="text"  class="col-xs-6" id="RptFrmDate"  readonly />
							</div>
							<div class="col-sm-12 col-md-6 col-lg-3">
								<span id="DATE2"  class="col-xs-4" style="display: inline-block; font-size: 13px; font-weight: bold;">To </span>
								<input type="text"  class="col-xs-6" id="RptToDate" readonly />
							</div>
							<div class="col-sm-12 col-md-6 col-lg-3">	
								<span id="Dept"  class="col-xs-4" style="display: inline-block; font-size: 13px; font-weight: bold; ">Department </span>
								<select id="txtLabDepartment"  class="col-xs-8" >
									<option>--Select--</option>
								</select>
							</div>
              <div class="col-sm-12 col-md-6 col-lg-3">
								<input type="radio"  class="col-3" name="Verify" id="rbtnTechVeriY" value="Y" checked onclick = "rbtnTVYClick()">
								<label style="vertical-align:middle">Tech. Verified</label>
								<input type="radio"  class="col-3" name="Verify" id="rbtnTechVeriN" value="N" onclick = "rbtnTVNClick()">
								<label style="vertical-align:middle">Rejected</label>
									<input type="radio"  class="col-3" name="Verify" id="rbtnDrVerify" value="D" onclick = "rbtnTVDClick()">
								<label style="vertical-align:middle">Dr. Verified</label>
              </div>

                <%--<i class="fa fa-search" aria-hidden="true" id="btnSearch1" style="font-size: 17px; margin-left: 30px"></i>--%>
						
           <%-- </div>--%>
<%--						<div style="width: 100%;display: flex;flex-wrap: wrap;align-items:flex-start ;flex-direction:row;" id="divPatSearch">
							<div class="col-sm-12 col-md-6 col-lg-3">
								<span id="MrNo" class="col-xs-5" style="display: inline-block; font-size: 13px; font-weight: bold;">MR No. </span>
								<input type="text" id="txtMrNo" class="col-xs-6" />
							</div>
							<div class="col-sm-12 col-md-6 col-lg-3">
								<span id="Name" class="col-xs-4" style="display: inline-block; font-size: 13px; font-weight: bold; ">Pat. Name </span>
								<input type="text" id="txtPatName" class="col-xs-8" />
							</div>
							<div class="col-sm-12 col-md-6 col-lg-3">
								<span id="Mobile" class="col-xs-4" style="display: inline-block; font-size: 13px; font-weight: bold; ">Mobile No. </span>
								<input type="text" id="txtMobileNo" class="col-xs-8" />
							</div>
							<div class="col-sm-12 col-md-6 col-lg-3">
								<a class="button1 button1-green" id="btnSearch"  style="margin-bottom: 1.5%;"><i class="fa fa-search"></i>Search</a>
							</div>
						</div>--%>
            <div class="nav-tabs-custom" style="margin-bottom: 0px !important; margin-top: 15px; background-color: #f3d9dd; width: 100%;">
                <ul class="nav nav-tabs">
                    <li class="active"><a id="Investigation" class="Investigation" data-toggle="tab" aria-expanded="true">Verified Lab Records</a></li>
                   <%-- <li class=""><a href="#DateWise" class="DateWise" data-toggle="tab" aria-expanded="false">Date Wise</a></li>
                    <li class=""><a href="#AbnormalValues" class="AbnormalValues" data-toggle="tab" aria-expanded="false">Abnormal Values</a></li>
                    <li class=""><a href="#Trends" class="Trends" data-toggle="tab" aria-expanded="false">Trends</a></li>--%>
                    <li class=""><a href="#OthRpt" class="OthRpt" data-toggle="tab" aria-expanded="false">View</a></li>
                    <%-- <li class=""><a href="#CultureRpt" class="CultureRpt" data-toggle="tab" aria-expanded="false">Culture Report</a></li>  
                    <li class=""><a href="#OutsideRpt" class="OutRpt" data-toggle="tab" aria-expanded="false">Outside Reports <i id="outRptPresent" class="fa fa-info-circle" style="color:#37a0ee;font-size: 15px;" aria-hidden="true"></i></a></li>--%>
                </ul>
                <!-- /.tab-content -->
            </div>
            <div id="wrapper" style="overflow: hidden; width: 100%">
                <div class="tableDivInvestig" style="padding-top: 5px; display: block;min-width: 100%;overflow: auto;">
                    <%--<div class="row" style="margin-left: 0px !important; margin-right: 0px !important">--%>
											<%--<div class="sticky-table sticky-headers" id="fixedTable">--%>
                            <%--<table id="tblInvestigationChart" style="line-height: 1.5; width: 100%" class="table table-striped">--%>
														<table id="tblInvestigationChart" style="line-height: 1.5; width: 100%;min-width: 100%;width: max-content;" class="">
                                <thead class="fixedHeader"></thead>
                                <tbody></tbody>
                            </table>
                       <%-- </div>--%>
                    <%--</div>--%>
                </div>
               <%-- <div class="tableDivAbnormal" style="padding-top: 5px; display: none">
                </div>
                <div class="tableDivDateWise" style="padding-top: 5px; display: none">
                </div>
                <div class="tableTrends" style="padding-top: 5px; display: none">
                    <div style="border: 1px solid #afe3f3">
                        <div class="col-md-12 box-header with-border" style="padding-left: 4px; padding-right: 4px;" id="TestListDivHead">
                            <span class="box-title" style="font-size: 19px; font-weight: 400; color: black;">Tests</span>
                            <b><span id="lblTestName" style="margin-left: 2px; font-size: 14px; color: black"></span></b>
                        </div>
                    </div>
                    <div>
                        <div class="col-md-12 col-xs-12" style="border: 1px solid #436d92" id="TestListDiv"></div>
                    </div>

                    <div>
                        <div class="col-md-12  col-xs-12" id="chartNote" style="display: none">
                            <div style="float: left">Note-</div>
                            <div class="square"></div>
                             &nbsp;&nbsp;Result</div>
                        <div class="col-md-12  col-xs-12 divSubList">
                            <div id="divCharts"></div>
                        </div>
                    </div>

                </div>--%>
                 <div class="tableOthTempRpt" style="padding-top: 5px; display: none">
                </div>
              
                <%-- <div class="tblOutRptAttachments"  style="padding-top: 5px; display: none">
                 <div id="wrapper1" style="width: 100%">
                    <div class="tableDiv">
                    <table id="tbl1" class="table" style="width: 100%">
                        <tbody id="tblsort1"></tbody>
                    </table>
                </div>
                </div>--%>
            </div>

            <%--// Added by Dhananjay 20240712--%>
                <div id="container"></div>

           <%-- </div>--%>
            <div class="alert alert-danger NoRecord" style="width:100%;">
                <strong>
                    <i class="ace-icon fa fa-times"></i>
                    No Record Found
                </strong>

            </div>
			<%--<div id="divRejRemarks" title="Add Rejection Remarks" style="display: none"><table><tbody><tr id="trError1" style="display: none;"><td colspan="5"><label id="OutSideError1" style="color: Red"></label></td></tr><tr><td><label>Reason for Rejection*</label></td></tr><tr><td colspan="5"><textarea cols="50" rows="10" id="txtRejRemarks" class="TextBxFormat" style="width: 380px; height:50px;" maxlength="255"></textarea></td></tr></tbody></table></div>--%>
			<div id="divRejRemarks" title="Add Rejection Remarks" style="display: none">
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin">
					<span id="OutSideError1" class="col-xs-4 col-sm-4 col-md-4 col-lg-6" style="display:none; font-size: 13px; font-weight: bold;color: Red;"></span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-12 RowMargin">
					<span id="Reason" class="col-xs-4 col-sm-4 col-md-4 col-lg-12" style="display: inline-block; font-size: 13px; font-weight: bold;">Reason for Rejection* </span>
					<%--<input type="textarea" id="txtRejRemarks"  class="col-xs-8 col-sm-8 col-md-8 col-lg-12 PaddingZero" />--%>
					<textarea id="txtRejRemarks" class="col-xs-8 col-sm-8 col-md-8 col-lg-12 PaddingZero"></textarea>
				</div>
			</div>

        </div>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <script src="../plugins/chartjs/chart.min.js"></script>
	  <link href="../Content/select2-bootstrap.css" rel="stylesheet" type="text/css" />
	  <script src="../js/select2.js"></script>
    <style>
      .tbldiv {
            margin-top:10px;
             -webkit-box-shadow: 0px 1px 2px 0px #878888;    /* Added by Dhananjay - 20240712*/
      }

     .divHeads {
         display: flex;
         justify-content: space-between; /*Added by Dhananjay - 20240712*/
         align-items: center;
         cursor: pointer; 
    }

    .spanCls {
        font-size: 16px;
       transition: transform 0.3s ease;  /* Added by Dhananjay - 20240712*/
     }
          
     .open .spanCls {
        transform: rotate(90deg);   /* Added by Dhananjay - 20240712*/
     }

     .divHeads {    /* Added by Dhananjay - 20240712*/
          display: flex;
          justify-content: space-between;
          align-items: center;
          cursor: pointer; 
          padding: 10px;
          border-bottom: 1px solid #ddd; 
    }

        /* Style for the middle-side text */
        .middle-side {
             flex: 4; /* Takes up more space compared to left-side */
             text-align: center; /* Center the text */
        }


        /*added by vijeta on 24th July 2018*/
        .inputDates {
            width: 86px;
            height: 26px;
            margin-top: 4px;
        }

        /*added by vijeta on 24th July 2018*/
        #divDates {
            /*background-color: #f5dff5;*/
            border-radius: 8px 8px 8px 8px;
            margin-bottom: 0px !important;
            display: block;
            text-align: center;
            /*height: 34px;*/
        }

        #chartNote {
            height: 20px;
            font-size: 14px;
            font-weight: bold;
            background-color: #afe3f3;
        }

        .square {
            height: 10px;
            width: 10px;
            background-color: blue;
            float: left;
            margin-top: 6px;
            margin-left: 10px;
        }
        /*added by vijeta on 25th july 2018*/
        .btnTrend.btnTrend-primary {
            color: #fff;
            /*background-color: #9c27b0;*/
            border-color: #9c27b0;
            -webkit-box-shadow: 0 2px 2px 0 rgba(156,39,176,.14),0 3px 1px -2px rgba(156,39,176,.2),0 1px 5px 0 rgba(156,39,176,.12);
            box-shadow: 0 2px 2px 0 rgba(156,39,176,.14),0 3px 1px -2px rgba(156,39,176,.2),0 1px 5px 0 rgba(156,39,176,.12);
        }

            .btnTrend.btnTrend-primary.focus, .btnTrend.btnTrend-primary:focus, .btnTrend.btnTrend-primary:hover {
                color: #fff;
                background-color: #9124a3;
                border-color: #701c7e;
            }

        .btnTrend {
            position: relative;
            padding: 0px 0px;
            margin: .3125rem 1px;
            font-size: .75rem;
            font-weight: 400;
            line-height: 1;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 0;
            border: 0;
            border-radius: 1.5rem;
            outline: 0;
            -webkit-transition: background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
            transition: background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
            transition: box-shadow .2s cubic-bezier(.4,0,1,1),background-color .2s cubic-bezier(.4,0,.2,1);
            transition: box-shadow .2s cubic-bezier(.4,0,1,1),background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
        }

        .btnTrend-block {
            display: block;
        }

        .box-header {
            color: #fff;
            background: #afe3f3;
            background-color: #afe3f3;
            height: 36px;
        }
        /*------------------------------*/
        #ui-datepicker-div.ui-datepicker ui-widget {
            position: absolute;
            top: 92px;
            left: 343.656px;
            z-index: 1000;
            display: block;
            font-size: 14px;
            z-index: 1000;
        }

        .buttonstyle {
            background-color: transparent;
            margin-right: 2px;
            color: black;
            font-weight: bold;
            border-top: 1px solid transparent;
            border-right: 1px solid transparent;
            border-bottom: solid rgb(60, 141, 188);
            border-left: 1px solid transparent;
            border-image: initial;
            font-size: 10px;
            white-space: normal;
            outline: 0px;
        }

        .Y {
            background-color: #dd4b39 !important;
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 10px;
            font-weight: 600;
            color: #fff;
            line-height: 1;
            vertical-align: middle;
            text-align: center;
            border-radius: 10px;
        }

        .card-panel {
            transition: box-shadow .25s;
            padding: 20px;
            margin: 0.5rem 0 1rem 0;
            border-radius: 2px;
            background-color: #fff;
        }

        .card {
            position: relative;
            margin: 0.5rem 0 1rem 0;
            background-color: #fff;
            transition: box-shadow .25s;
            border-radius: 2px;
        }

            .card .card-title {
                font-size: 24px;
                font-weight: 300;
                color: #f6ea0a;
            }

            .card .card-content {
                padding: 10px 14px;
            }

        .teal.darken-2 {
            /*background-color: #00796b !important;*/
            background-color: #292727;
        }

        .white-text {
            color: #fff !important;
        }

        Label {
            /*margin-left: 5px;*/
        }

				.RowMargin{
					    margin-bottom: 5px;
				}
				.PaddingZero{
					padding:0;
				}
    	.RadioLbl {
    		vertical-align: middle;
    		margin-bottom: 0px;
    		padding-left: 5px;
    		padding-right: 5px;
    	}
			input[type="radio"]
			{
				margin:0 !important;
			}

        /*.hide {
            display: none;
        }*/

        #tblInvestigationChart {
            /*font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;*/
            border-collapse: collapse;
            width: 100%;
            margin-left: 20px;
        }

            #tblInvestigationChart td, #tblInvestigationChart th {
                border: 1px solid #ddd;
                padding: 1px;
            }

            #tblInvestigationChart tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            #tblInvestigationChart tr:hover {
                background-color: #ddd;
            }

            #tblInvestigationChart th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #cdf5cb;
                color: black;
            }

        /*for increasing width of table from left and right side*/
        #fixedTable {
            margin-left: -20px;
            width: 368px;
        }

        /*first column test name wrapped*/
        #tblInvestigationChart tbody .testNameCls {
            word-wrap: break-word;
            white-space: pre-wrap;
            width: 20% !important;
        }

        @media only screen and (min-width : 992px) {
            #tblInvestigationChart td, #tblInvestigationChart th {
                border: 1px solid #ddd;
                padding: 6px;
            }

            #fixedTable {
                margin-left: -18px;
                width: 100%;
            }
        }

        #tblInvestigationChart tbody tr:nth-child(even) {
            background: #e8ba541c !important;
        }

        #tblInvestigationChart tbody tr:nth-child(odd) {
            background: #c5eff17a !important;
        }

        #tblInvestigationChart tbody tr:hover {
            background: #f4f4f4 !important;
            /*font-weight: bold !important;*/
            box-shadow: 1px 6px 13px 2px #a09d9da6;
        }

        /*@media only screen and (min-width: 992px) {
            .row {
                margin-right: -278px !important;
            }
        }*/

        /*@media only screen and (min-width: 1400px) {
            .row {
                margin-left: 0px;
            }
        }

        @media only screen and (min-width: 1366px) {
            .row {
                margin-left: 0px;
            }
        }

        @media only screen and (min-width: 1024px) {
            .row {
                margin-left: 0px;
            }
        }
				@media only screen and (min-width: 768px) {
            .row {
                margin-left: 0px;
            }
        }*/

				.bordered-div {
            border: 2px solid black;
            padding: 20px;
            margin: 0 auto;
            max-width: 906px;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        p {
            color: #666;
            line-height: 1.6;
        }
    </style>

    <script src="../Scripts/PatList.js"></script>
    <link href="../plugins/Freez/jquery.stickytable.min.css" rel="stylesheet" />
    <script src="../plugins/Freez/jquery.stickytable.min.js"></script>
    <!-- Font Awesome -->

    <script>
        var Mrno = ($.session.get('PatMRNO'));
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var InvestigateResultData = "";
        var InvestigateData = "";
        var InvestigateTrendsData = "";
       <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var LabFile = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.LabAttach))%>');
    	var pathFrom = "";
    	var GlbResult = [];
    	//PointerEvent tstRpt = new PointerEvent();
        $(document).ready(function () {
        	$(".tbldiv").css('display', 'none')     // Added by Dhananjay 20240712
        	$("#divRadio").hide();
        	

        	getLabDepartments();
        	getLabDeptwiseTest();
        	getRefDoctors();
        	$("#txtLabDepartment").select2();
        	$("#txtTest").select2();
        	$("#txtRefDr").select2();
            $("#outRptPresent").hide();
        	document.getElementById("menuList").style.visibility = "hidden";
        	document.getElementById("sideList").style.visibility = "hidden";
            //if ($(window).width() >= 996) {                                            //screen width size comparion
            //    var menuL = document.getElementById('menuList');
            //    menuL.style.display = "block";
            //    var dispLst = document.getElementById('sideList');
            //    dispLst.style.display = "block";
            //}
        	$('.OthRpt').css('display', 'none');
            $("#divDates").show();
        	//added on 23rd July 2018
            $("#RptFrmDate,#RptToDate").click(function () {
            	$("#ui-datepicker-div.ui-widget").css("z-index", "1000");
            });


            SetDateTime();

        	//Meenakshi
            var pagefrom = '../Clinicalnotes/InvestigationVerify';
            $.session.set('Pagefrom', pagefrom);

            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');
            if (pathFrom != "") {
                //$("#divForBack").hide();
                $('#menuBar').removeAttr('disabled');
            }
            else {

                $("#divForBack").show()

                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
                $('#menuBar').attr('disabled', 'disabled');
            }
            $(".tableDivInvestig").css('display','none');
            localStorage.setItem('IsInvestigationData', false);
            //localStorage.setItem('IsAbnoramlData', false);
            //localStorage.setItem('IsDatewiseData', false);
            //localStorage.setItem('IstTrendsData', false);
            //loadInvestigationReport();

            //$('.Investigation').click(function () {
            //    //$("#divDates").hide();
            //    //$("#container").css('display', 'none')
            //    var flag = localStorage.getItem("IsInvestigationData")
            //    $(".tableDivInvestig").css('display', 'block')
            //    $('.tableOthTempRpt').css('display', 'none')
            //    if (flag === 'false') {
            //        loadInvestigationReport();
            //    }
            //});

            //added on 24th July 2018
            $("#btnSearch").click(function () {
            	$(".tableDivInvestig table").empty();
                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();
                var flgInvest = $(".tableDivInvestig").css('display');
                var flagTempRpt = $(".tableOthTempRpt").css('display', 'none');
               
                if (flgInvest == "block" || flgInvest == "none")
                		loadInvestigationReport();
            });
            //$('.Investigation').trigger('click');
            $('.Investigation').on('click', function () {
            	$(".tableDivInvestig table").empty();
            	var frmDate = $("#RptFrmDate").val();
            	var toDate = $("#RptToDate").val();
            	var flgInvest = $(".tableDivInvestig").css('display');
            	var flagTempRpt = $(".tableOthTempRpt").css('display', 'none');

            	$('.OthRpt').css('display', 'none');

            	if (flgInvest == "none")
            		loadInvestigationReport();
            });
            //$(".Investigation").click(function () {
            //	$(".tableDivInvestig table").empty();
            //	var frmDate = $("#RptFrmDate").val();
            //	var toDate = $("#RptToDate").val();
            //	var flgInvest = $(".tableDivInvestig").css('display');
            //	var flagTempRpt = $(".tableOthTempRpt").css('display', 'none');

            //	if (flgInvest == "block")
            //		loadInvestigationReport();
            //});
        });

        function getLabDepartments()
        {
        	$.ajax({
                url: '../Clinicalnotes/GetLabDepartments',
        		type: "post",
        		datatype: "json",
        		//data: { strDate: $("#txtAppointmntDate").val() },
        		success: function (response) {
        			$("#txtLabDepartment").empty();
        			if (response != "") {
        				$('#txtLabDepartment')
												.append($("<option>--Select--</option>"));
        				$.each(response, function (key, value) {
        					$('#txtLabDepartment')
											.append($("<option></option>")
																	.attr("value", value.DEPTCODE)
																	.text(value.DEPTDESC));
        					$('#txtLabDepartment').css('border', '2px solid green');//added on 17th jan19
        					//$("#txtLabDepartment").select2();
        				});
        			}
        			else {
        				$('#txtLabDepartment').append($("<option>--Select--</option>"));
        				$('#txtLabDepartment').css('border', '2px solid red');//added on 17th jan19
        			}
        		}
        	});
        }
        function getLabDeptwiseTest()
        {
        	var labDept = "";
        	if ($("#txtLabDepartment").val() != "" && $("#txtLabDepartment").val() != "--Select--")
        		labDept = $("#txtLabDepartment").val();
        	//else {
        	//	//MsgDia('Please select the lab department.', 'Information');
        	//	$.messager.alert("Information", 'Please select the lab department.');
        	//	return;
        	//}
        	$.ajax({
        		url: '../Clinicalnotes/GetLabDeptTests',
        		type: "post",
        		datatype: "json",
        		data: { strLabDept: labDept },
        		success: function (response) {
        			$("#txtTest").empty();
        			if (response != "") {
        				$('#txtTest')
												.append($("<option>--Select--</option>"));
        				$.each(response, function (key, value) {
        					$('#txtTest')
											.append($("<option></option>")
																	.attr("value", value.TESTCODE)
																	.text(value.TESTNAME));
        					$('#txtTest').css('border', '2px solid green');//added on 17th jan19
        				});
        			}
        			else {
        				$('#txtTest').append($("<option>--Select--</option>"));
        				$('#txtTest').css('border', '2px solid red');//added on 17th jan19
        			}
        		}
        	});
        }
        function getRefDoctors() {
        	$.ajax({
        		url: '../Clinicalnotes/GetRefDoctors',
        		type: "post",
        		datatype: "json",
        		//data: { strDate: $("#txtAppointmntDate").val() },
        		success: function (response) {
        			$("#txtRefDr").empty();
        			if (response != "") {
        				$('#txtRefDr')
												.append($("<option>--Select--</option>"));
        				$.each(response, function (key, value) {
        					$('#txtRefDr')
											.append($("<option></option>")
																	.attr("value", value.DoctCode)
																	.text(value.DoctName));
        					$('#txtRefDr').css('border', '2px solid green');//added on 17th jan19
        				});
        			}
        			else {
        				$('#txtRefDr').append($("<option>--Select--</option>"));
        				$('#txtRefDr').css('border', '2px solid red');//added on 17th jan19
        			}
        		}
        	});
        }
        // Added by Dhananjay 20240712 - 
        function formatDate(yyyymmdd) {
            var year = yyyymmdd.substring(0, 4);
            var month = parseInt(yyyymmdd.substring(4, 6), 10) - 1;
            var day = yyyymmdd.substring(6, 8);

            // Create a new Date object
            var date = new Date(year, month, day);

            var options = { year: 'numeric', month: 'long', day: 'numeric' };

            // Format the date using toLocaleDateString
            return date.toLocaleDateString('en-US', options);
        }


        function showLabFiles(File) {
            if (File != null) {
                if (File.length >= 1) {
                    $('#tbl1 tbody').empty();
                    for (i = 0; i < File.length; i++) {
                        var rows = "<tr> <td class='disp' style='cursor:pointer' onclick='openLabNewWin(this)'><u>" + File[i] + "</u></td><tr>";
                        $('#tbl1 tbody').append(rows);
                    }
                    $("#outRptPresent").show();
                }
                else
                    $("#outRptPresent").hide();
            }
            else
                $("#outRptPresent").hide();
        }

        function SetpageDirctn() {

        	window.location.href = '../Account/MenuList?pageId=Menu';
            // SaveVitals();
            //if (pathFrom == "") {
            //    window.location.href = '../ClinicalNotes/ClinicEntry';
            //} else
            //    window.location.href = '../DoctorDesk/PatientEntry';
        }

        function openLabNewWin(obj) {
            NAME = obj.innerText;
            var MRNO = ($.session.get('PatMRNO'));
            var url = "../Clinicalnotes/LabFileDownload?MRNo=" + MRNO + "&&filename=" + NAME
            window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
            //var Details = '<a href=' + url + ' id="imgdownload" download=' + NAME + '>Download file</a>';
            return Details;
        }

        function selectText(node) {
            node = document.getElementById(node);

            if (document.body.createTextRange) {
                const range = document.body.createTextRange();
                range.moveToElementText(node);
                range.select();
            } else if (window.getSelection) {
                const selection = window.getSelection();
                const range = document.createRange();
                range.selectNodeContents(node);
                selection.removeAllRanges();
                selection.addRange(range);
            } else {
                console.warn("Could not select text in node: Unsupported browser.");
            }
        }

        function loadInvestigationReport() {
            checkNoRecordClass();
            $(".tableDivInvestig").css('display', 'block')

            var frmDate = $("#RptFrmDate").val();
            var toDate = $("#RptToDate").val();
            var labDept = "";
            if ($("#txtLabDepartment").val() != "" && $("#txtLabDepartment").val() != "--Select--")
            	labDept = $("#txtLabDepartment").val();
            else if ($("#txtTest").val() != "" && $("#txtTest").val() != "--Select--")
            	labDept = $("#txtTest").val();
            else
            {
            	//MsgDia('Please select the lab department.', 'Information');
            	$.messager.alert("Information", 'Please select the lab department or Test Name.');
            	return;
            }

            var MrNo = $("#txtMrNo").val();
            var PatName = $("#txtPatName").val();
            var Contact = $("#txtMobileNo").val();

            var Test = ""; //$("#txtTest").val();
            if ($("#txtTest").val() != "" && $("#txtTest").val() != "--Select--")
            	Test = $("#txtTest").val();
            
            var Sample = $("#txtSampleNo").val();
            var Doctor = "";//$("#txtRefDr").val();

            if ($("#txtRefDr").val() != "" && $("#txtRefDr").val() != "--Select--")
            	Doctor = $("#txtRefDr").val();
          

            	
            var TechVerify = "";
            if ($("#rbtnTechVeriY")[0].checked == true)
            	TechVerify = "Y";
            else if ($("#rbtnTechVeriN")[0].checked == true)
            	TechVerify = "N";
            else if ($("#rbtnDrVerify")[0].checked == true)
            	TechVerify = "D";

            $.ajax({
                type: 'post',
                url: 'GetTechVerifiedData',
                cache: false,
                dataType: "json",
                data: { FromDt: frmDate, ToDt: toDate, LabDept: labDept, TechVerify: TechVerify, strMRNO: MrNo, strPatName: PatName, strContact: Contact, strTest: Test, strSample: Sample, strDoctor: Doctor },
                async: false,
                success: function (response) {
                	GlbResult = [];
                    if (response != "Unsucessfull") {
                        $("#tblInvestigationChart").empty();

                        if (response == "No Data Found" || response == "") {
                            $.messager.alert("Information", "No Data Found");
                            //   var emptyRow = "<tr style='background-color: #3c8dbc;color: white;'><td>No Data Found</td></tr>";
                            // $("#tblInvestigationChart").append(emptyRow);

                            $('#fixedTable').hide();
                            //var NorecordDiv = $('.NoRecord')
                            //if ($(NorecordDiv).hasClass('hide')) {
                            //    $(NorecordDiv).removeClass('hide')
                            //}
                        	  //$('.NoRecord').show();
                        }
                        else {
                            console.log(response);

                            $('#fixedTable').show();

                            result = JSON.parse(response);
                            GlbResult = JSON.parse(response);
                            localStorage.setItem('IsInvestigationData', true);
                            $("#tblInvestigationChart").append('<thead></thead><tbody></tbody>')
                            var strdynamicDate = "";
                            for (var H = 0; H < result.TblDate.length; H++) {
                                strdynamicDate += "<th class='dateColumn'>" + result.TblDate[H].DATETIME + "</th>";
                            }
                        	//<th class='first sticky-cell'></th>
                            if ($("#rbtnDrVerify")[0].checked == true)
                            {
                            	var thead = "<tr class='sticky-row'><th class='sticky-cell' style='width: 90px;'>Print</th><th class='first sticky-cell' style='width: 120px;'>Result No.</th><th class='second sticky-cell' style='width: 150px;'>Result Date & Time</th><th class='sticky-cell' style='width: 100px;'>Sample No.</th><th class='sticky-cell' style='width: 100px;'>MRNO</th><th class='second sticky-cell' style='width: 250px;'>Patient Name</th><th class='sticky-cell' style='width: 150px;' >Order No.</th><th class='sticky-cell' style='width: 90px;'>Order Date</th><th class='sticky-cell' style='width: 200px;'>Test Name</th><th class='sticky-cell' style='width: 200px;'>Rejection Remarks</th></tr>";
                            }
                            else
                            {
                            	var thead = "<tr class='sticky-row'><th class='first sticky-cell' style='width: 120px;'>Result No.</th><th class='second sticky-cell' style='width: 150px;'>Result Date & Time</th><th class='sticky-cell' style='width: 100px;'>Sample No.</th><th class='sticky-cell' style='width: 100px;'>MRNO</th><th class='second sticky-cell' style='width: 250px;'>Patient Name</th><th class='sticky-cell' style='width: 150px;' >Order No.</th><th class='sticky-cell' style='width: 90px;'>Order Date</th><th class='sticky-cell' style='width: 200px;'>Test Name</th><th class='sticky-cell' style='width: 200px;'>Rejection Remarks</th></tr>";
                            }
                            //var thead = "<tr class='sticky-row'><th class='first sticky-cell' style='width: 120px;'>Result No.</th><th class='second sticky-cell' style='width: 150px;'>Result Date & Time</th><th class='sticky-cell' style='width: 100px;'>MRNO</th><th class='second sticky-cell' style='width: 250px;'>Patient Name</th><th class='sticky-cell' style='width: 150px;' >Order No.</th><th class='sticky-cell' style='width: 90px;'>Order Date</th><th class='sticky-cell' style='width: 200px;'>Test Name</th><th class='sticky-cell' style='width: 200px;'>Rejection Remarks</th></tr>"; //<th class='first sticky-cell'>IPNO</th>
                            $("#tblInvestigationChart thead").append(thead);
                            var row = '';
                            var strDateTime = ""; var strOderDate = "";
                            for (var D = 0; D < result.TblResult.length; D++) {
                                //var dateResult = "";
                                //for (var H = 0; H < result.TblDate.length; H++) {
                                //    var DateOf = result.TblDate[H].DATETIME
                                //    dateResult += "<td class='dateColumn'>" + (result.Investigate[D][DateOf] != null ? result.Investigate[D][DateOf] : "") + "</td>";
                                //}
                            	if (result.TblResult[D]["DATETIME"].toString().trim() != "")
                            	{
                            		var dateTime = result.TblResult[D]["DATETIME"].toString().split('T');
                            		var strDate = dateTime[0].split('-');
                            		strDateTime = strDate[2] + "/" + strDate[1] + "/" + strDate[0] + " " + dateTime[1].toString();
                            	}
                            	if (result.TblResult[D]["ORDERDATE"].toString().trim() != "")
                            	{
                            		strOderDate = result.TblResult[D]["ORDERDATE"].toString().substr(6, 2) + "/" + result.TblResult[D]["ORDERDATE"].toString().substr(4, 2) + "/" + result.TblResult[D]["ORDERDATE"].toString().substr(0, 4)
                            	}
                            	//<td><i class='fa fa-view' aria-hidden='true' id='btnView' style='font-size: 17px; margin-left: 4px'></i></td>
                            	if ($("#rbtnDrVerify")[0].checked == true) {
                            		row += "<tr class='GridViewScrollItem' id=" + result.TblResult[D]["RESULTNO"].toString().trim() + "><td class='sticky-cell'><a class='button1 button1-green' id='Print_" + D + "' onclick='FileView(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\")'><i class='fa fa-cap'></i><strong>Print</strong></a></td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + result.TblResult[D]["RESULTNO"].toString().trim() + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + strDateTime + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + result.TblResult[D]["SAMLECOLNO"].toString().trim() + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + result.TblResult[D]["MRNO"].toString().trim() + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + result.TblResult[D]["PATNAME"].toString().trim() + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + result.TblResult[D]["ORDERNO"].toString().trim() + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + strOderDate + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + result.TblResult[D]["TESTNAME"].toString().trim() + "</td><td class='sticky-cell' onclick='BindTemplRptData(\"" + result.TblResult[D]["RESULTNO"].toString().trim() + "\");'>" + result.TblResult[D]["REMARKS"].toString().trim() + "</td></tr>";
                            	}
                            	else
                            	{
                            		row += "<tr class='GridViewScrollItem' id=" + result.TblResult[D]["RESULTNO"].toString().trim() + " onclick='BindTemplRptData(event);'><td class='sticky-cell'>" + result.TblResult[D]["RESULTNO"].toString().trim() + "</td><td class='sticky-cell'>" + strDateTime + "</td><td class='sticky-cell'>" + result.TblResult[D]["SAMLECOLNO"].toString().trim() + "</td><td class='sticky-cell'>" + result.TblResult[D]["MRNO"].toString().trim() + "</td><td class='sticky-cell'>" + result.TblResult[D]["PATNAME"].toString().trim() + "</td><td class='sticky-cell'>" + result.TblResult[D]["ORDERNO"].toString().trim() + "</td><td class='sticky-cell'>" + strOderDate + "</td><td class='sticky-cell'>" + result.TblResult[D]["TESTNAME"].toString().trim() + "</td><td class='sticky-cell'>" + result.TblResult[D]["REMARKS"].toString().trim() + "</td></tr>";
                            	}
                            	//<td class='sticky-cell'>" + result.TblResult[D]["IPNO"].toString().trim() + "</td>
                            }
                            $("#tblInvestigationChart tbody").append(row);
                            $('.NoRecord').hide();
                        }
                    }
                },
                complete: function (data) {

                    //groupTable($('#tblInvestigationChart tr:has(td)'), 0, 1);  // tr:has(td)
                    $('#tblInvestigationChart .deleted').remove();

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Information", "An error occurred while processing your request.");

                }
            });


        }

        function enhance() {
            gridViewScroll.enhance();
        }

        function groupTable($rows, startIndex, total) {
            if (total === 0) {
                return;
            }
            var i, currentIndex = startIndex, count = 1, lst = [];
            var tds = $rows.find('td:eq(' + currentIndex + ')');
            var ctrl = $(tds[0]);
            lst.push($rows[0]);
            for (i = 1; i <= tds.length; i++) {
                if (ctrl.text() == $(tds[i]).text()) {
                    count++;
                    $(tds[i]).addClass('deleted');
                    lst.push($rows[i]);
                }
                else {
                    if (count > 1) {
                        ctrl.attr('rowspan', count);
                        groupTable($(lst), startIndex + 1, total - 1)
                    }
                    count = 1;
                    lst = [];
                    ctrl = $(tds[i]);
                    lst.push($rows[i]);
                }
            }
        }

        function checkNoRecordClass() {
            //var NorecordDiv = $('.NoRecord')
            //if (!$(NorecordDiv).hasClass('hide')) {
            //    $(NorecordDiv).addClass('hide')
            //}

        }

        function tablegeneration(result, datafilter, idval) {

            var finalFilterdata = jQuery.grep(result.Table, function (a, index) {
                return (a.INVESTDESC == datafilter);
            });
            var selector = '#my_test_' + idval;
            var element = $(selector);
            element.append('<div class="box" style="margin-bottom:6px"><div class="box-body table-responsive no-padding"><table class="table table-hover" style="text-align:center;" id="table_' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

            var tableElementSelect = '#table_' + idval;
            var tableElement = $(tableElementSelect)
            var headerRow = $(tableElement).children('thead').children('tr:first')
            var BodyRow = $(tableElement).children('tbody').children('tr:first')

            $.each(finalFilterdata, function (Uniq, item) {
                headerRow.append(
                    '<th style="text-align:center;padding:4px !important;">' + item.RESULTDATE + '</th>'
                );
            });

            $.each(finalFilterdata, function (index, item) {
                BodyRow.append(
                    '<td style="text-align:center;padding:4px !important;">' + '<span class="' + item.ABNORMAL + '">' + item.RESULTDT + '</span>' + '</td>'
                );
            });
        }

        function BindTemplRptData(ResNo) {
        	var FilterDt = [];
        	jQuery.grep(GlbResult.TblResult, function (a) {
        		if (a.RESULTNO == ResNo)
        			FilterDt.push(a);
        	});
        	//checkNoRecordClass();
					
        	var strVerify = "";
        	//sessionStorage.setItem(tstRpt, e);
        	//var resultno = e.currentTarget.cells[0].innerHTML;
        	var resultdate = FilterDt[0].DATETIME.substring(0, 10).split('-');//e.currentTarget.cells[1].innerHTML.substring(0, 10).split('-');
        	//frmDate = resultdate[0] + resultdate[1] + resultdate[2];
        	var Mrno = FilterDt[0].MRNO;//e.currentTarget.cells[2].innerHTML;
        	var ResultNo = FilterDt[0].RESULTNO;//e.currentTarget.cells[0].innerHTML;
        	var frmDate = resultdate[2] + "/" + resultdate[1] + "/" + resultdate[0];//$("#RptFrmDate").val();
        	var toDate = resultdate[2] + "/" + resultdate[1] + "/" + resultdate[0];//$("#RptToDate").val();

        	var TechVerify = "";
        	if ($("#rbtnTechVeriY")[0].checked == true)
        		TechVerify = "Y";
        	else if ($("#rbtnTechVeriN")[0].checked == true)
        		TechVerify = "N";
        	else if ($("#rbtnDrVerify")[0].checked == true)
        		TechVerify = "D";

            $.ajax({
                type: 'post',
                url: 'GetTemplateResultToVerify',
                cache: false,
                dataType: "json",
                data: { mrNo: Mrno, strFrmDate: frmDate, strTodate: toDate, resultNo: ResultNo, Type: TechVerify },
                async: false,
                success: function (response) {
                	$('.OthRpt').trigger('click');
                	$('.OthRpt').css('display', 'block');
                	$(".tableDivInvestig").css('display', 'none');
                	$('.tableOthTempRpt').css('display', 'block');
                    $('.tableOthTempRpt').empty();
                    if (response != "Unsucessfull") {
                        var resultDateWise = JSON.parse(response);
                        var mainDateWisediv = $('.tableOthTempRpt');
                        $.each(resultDateWise.Table, function (i, v) {
                        	//mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label></div>');
                        	//mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><div id="PatInfo" style="display: block"><table style="width: 65%" id="tblPatInfo"><tr><td style="width: 15%;font-weight: bold;">Result No.: </td><td><input class="TextBxFormat" id="txtResultNo" name="ResultNo" readonly="True" style="width:115px" type="text" value=\'' + resultDateWise.Table[0].RESULTNO + '\'"></td><td style="font-weight: bold;">Mr No.: </td><td><input class="TextBxFormat" id="txtMrNo" name="MRNo" readonly="True" style="width:90px" type="text" value=\'' + resultDateWise.Table[0].MRNO + '\'"></td><td><div class="input-group" style="width:100%"><input type="radio" name="Prov" id="rbtnProv" value="P" style="margin-left:4%" onclick = "rbtnPClick()" checked "><label style="vertical-align:middle">Provisional</label><input type="radio" name="Final" id="rbtnFinal" style="margin-left:14%" value="F" onclick = "rbtnFClick()"><label style="vertical-align:middle">Final</label></td></div></tr></table></div></div>');
                        	if ($("#rbtnTechVeriY")[0].checked == true) {
                        		mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; padding: 0px 10px; margin-top: 0;"><div id="divHead" class="row" style="padding-top:10px;width:100%;margin-left: 0px !important;display: flex; flex-wrap: wrap;"><div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin"><span id="ResultNo" class="col-xs-5 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">Result No.: </span><input type="text" id="txtResultNo" value=\'' + resultDateWise.Table[0].RESULTNO + '\'"  class="col-xs-6 col-sm-8 col-md-8 col-lg-6 PaddingZero" readonly /></div><div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin"><span id="MrNo" class="col-xs-5 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">MR No.: </span><input type="text" id="txtMrNo" value=\'' + resultDateWise.Table[0].MRNO + '\'"  class="col-xs-6 col-sm-8 col-md-8 col-lg-6 PaddingZero" readonly /></div><div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin" style="display: flex;align-items: center;"><div class="col-xs-12 col-sm-12" style="display:flex;vertical-align: middle;"><input type="radio" class="col-4" name="RptType' + (i) + '" id="rbtnProv" value="P" checked onclick = "rbtnPClick()"><label class="RadioLbl">Provisional</label><input type="radio"  class="col-4" name="RptType' + (i) + '" id="rbtnFinal" value="F" onclick = "rbtnFClick()"><label class="RadioLbl">Final</label></div></div></div></div>');
                        	}
                        	else
                        	{
                        		var Chk = resultDateWise.Table[0].REPORTTYPE; // P | F
                        		mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; padding: 0px 10px; margin-top: 0;"><div id="divHead" class="row" style="padding-top:10px;width:100%;margin-left: 0px !important;display: flex; flex-wrap: wrap;"><div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin"><span id="ResultNo" class="col-xs-5 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">Result No.: </span><input type="text" id="txtResultNo" value=\'' + resultDateWise.Table[0].RESULTNO + '\'"  class="col-xs-6 col-sm-8 col-md-8 col-lg-6 PaddingZero" readonly /></div><div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin"><span id="MrNo" class="col-xs-5 col-sm-4 col-md-4 col-lg-6" style="display: inline-block; font-size: 13px; font-weight: bold;">MR No.: </span><input type="text" id="txtMrNo" value=\'' + resultDateWise.Table[0].MRNO + '\'"  class="col-xs-6 col-sm-8 col-md-8 col-lg-6 PaddingZero" readonly /></div><div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 RowMargin" style="display: flex;align-items: center;"><div class="col-xs-12 col-sm-12" style="display:flex;vertical-align: middle;"><input type="radio" class="col-4" name="RptType' + (i) + '" id="rbtnProv" ' + (resultDateWise.Table[0].REPORTTYPE == "P" ? 'checked' : '') + '><label class="RadioLbl">Provisional</label><input type="radio"  class="col-4" name="RptType' + (i) + '" id="rbtnFinal" ' + (resultDateWise.Table[0].REPORTTYPE == "F" ? 'checked' : '') + '><label class="RadioLbl">Final</label></div></div></div></div>');
                        	}
                        	mainDateWisediv.append('<div class="bordered-div" id="TmpRptDtWise_' + (i) + '" onClick="selectText(this.id);" > ');
                            $("#TmpRptDtWise_" + (i)).html(v.RESULTDT);
                            mainDateWisediv.append('</div><div style="font-size: 13px !important;"><div class="parent" id="TmpRptAmentDtWise_' + (i) + '">');
                            $("#TmpRptAmentDtWise_" + (i)).html(v.Ammendments);
                            if (v.VERIFIEDBY == null)
                            	strVerify = "";
                            else
                            	strVerify = v.VERIFIEDBY;
                            mainDateWisediv.append('</div><div style="height: 15px;">');
                            mainDateWisediv.append('</div><div style="float:left;" class="" id="TmpRptVerifiedDtWise_' + (i) + '">');
                            $("#TmpRptVerifiedDtWise_" + (i)).html("<b>Verified By : " + strVerify + "</b>");
                            mainDateWisediv.append('</div><div style="margin-left : 15px ;float:left;" class="" id="TmpRprtByDtWise_' + (i) + '">');
                            $("#TmpRprtByDtWise_" + (i)).html("<b>Reported By : " + v.CREATEDBY + "</b>");
                            //mainDateWisediv.append('</div><div style="position: relative;" class="" id="txtTmpRptReject_' + (i) + '">');
                            //mainDateWisediv.append('<label id="lblRemarks">Reason for Remarks</label><input class="TextBxFormat" id="txtRejRemarks" name="RejRemarks" style="width:750px; height:40px;display: none" type="text" value=\'' + resultDateWise.Table[0].REMARKS + '\'">');
                            mainDateWisediv.append('</div> <div id="divButtons" class="" style="padding: 10px;width:100%;display: flex; justify-content: center;flex-wrap: wrap;">');
                        	//mainDateWisediv.append('<input type="button" id="btnVerify" style="width: 91px; margin-top: 4px; margin-left: 114px" class="Nbutton" value="Verify" onclick = "rptVerify()">');
                            if ($("#rbtnTechVeriY")[0].checked == true) {
                            	//mainDateWisediv.append('<a class="button1 button1-green" id="btnVerify"  style="margin-bottom: 1.5%;margin-left: 230px;" onclick="rptVerify()"><i class="fa fa-cap"></i><strong>Verify</strong></a>');
                            	$("#divButtons").append('<a class="button1 button1-green" id="btnVerify"   onclick="rptVerify()"><i class="fa fa-cap"></i><strong>Verify</strong></a>');
                            	$("#divButtons").append('<a class="button1 button1-green" id="btnReject" style="margin-left: 10px;" onclick="rptReject()"><i class="fa fa-cap"></i><strong>Reject</strong></a>');
                            	//mainDateWisediv.append('<a class="button1 button1-green" id="btnVerify"   onclick="rptVerify()"><i class="fa fa-cap"></i><strong>Verify</strong></a>');
                            	//mainDateWisediv.append('<input type="button" id="btnReject" style="width: 91px; margin-top: 4px; margin-left: 114px" class="Nbutton" value="Reject" onclick = "rptReject()">');
                            	//mainDateWisediv.append('</div><div class = "col-xs-12 col-sm-12 col-md-6 col-lg-6 RowMargin" style="position: relative;" id="btnReject_' + (i) + '">');
                            	//mainDateWisediv.append('<a class="button1 button1-green" id="btnReject"  onclick="rptReject()"><i class="fa fa-cap"></i><strong>Reject</strong></a>');
                            }
                        	//mainDateWisediv.append('<input type="button" id="btnVerify" style="width: 91px; margin-top: 4px; margin-left: 114px" class="Nbutton" value="Verify" onclick="rptVerify(\'' + tstRpt + '\')">'); resultDateWise.Table[0].RESULTNO
                            mainDateWisediv.append('</div></div></div></br><hr>');
                        });
                        $('.NoRecord').hide();
                    }

                    else {
                        //var NorecordDiv = $('.NoRecord')
                        //if ($(NorecordDiv).hasClass('hide')) {
                        //    $(NorecordDiv).removeClass('hide')
                    	//}
                    	$.messager.alert("Information", "No Data Found");
                        //$('.NoRecord').show();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Information", "An error occurred while processing your request.");
                }
            });
        }

        //added on 24th july 2018
        function addMonths(date, months) {
            date.setMonth(date.getMonth() + months);
            return date;
        }

        //added on 24th July 2018
        function SetDateTime() {
            var today = new Date();
            var prevDate = addMonths(new Date(), -6);
            var dd = today.getDate();
            var mm = today.getMonth() + 1;
            var yyyy = today.getFullYear();

            var dd1 = prevDate.getDate();
            var mm1 = prevDate.getMonth() + 1;
            var yyyy1 = prevDate.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }

            if (dd1 < 10) {
                dd1 = '0' + dd1
            }
            if (mm1 < 10) {
                mm1 = '0' + mm1
            }
            today = dd + '/' + mm + '/' + yyyy;
            prevDate = dd1 + '/' + mm1 + '/' + yyyy1;
        	//$("#RptFrmDate").val(prevDate);
            $("#RptFrmDate").val(today);
            $("#RptToDate").val(today);

            $("#RptFrmDate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            maxDate: new Date(),
                            onSelect: function (selected) {
                                if (new Date($('#RptFrmDate').datepicker('getDate')) > new Date($('#RptToDate').datepicker('getDate'))) {
                                    $.alert("From date should be less then or equal to todate.", "Validation");
                                }
                            }
                        })

            $("#RptToDate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            maxDate: new Date(),
                            //minDate: admissiondate
                            onSelect: function (selected) {
                                if (new Date($('#RptToDate').datepicker('getDate')) < new Date($('#RptFrmDate').datepicker('getDate'))) {
                                    $.alert("To date should be greater then or equal to from date.", "Validation");
                                }
                            }
                        });

        }


        //added on 25th July 2018
        function tooglediv() {
            var header = $("#TestListDivHead")
            $("#TestListDiv").slideToggle("slow");
            $("i", header).toggleClass("fa-plus-circle fa-minus-circle");
        }

        //<span class="box-tools pull-right" style="color: black">
        //<i class="fa fa-minus-circle fa-2x"></i>
			//</span>
        function rbtnPClick()
        {
        	if ($("#rbtnFinal")[0].checked == true)
        			$("#rbtnFinal")[0].checked = false;
        }
        function rbtnFClick() {
        	if ($("#rbtnProv")[0].checked == true)
        		$("#rbtnProv")[0].checked = false;
        }
        
        function rbtnTVYClick() {
        	if ($("#rbtnTechVeriN")[0].checked == true)
        		$("#rbtnTechVeriN")[0].checked = false;
        	if ($("#rbtnDrVerify")[0].checked == true)
        		$("#rbtnDrVerify")[0].checked = false;
        	
        	$("#btnVerify").show();
        	$("#btnReject").show();
        	$('.Investigation').trigger('click');
        	$('.OthRpt').css('display', 'none');
        	$('#btnSearch').click();
        }
        function rbtnTVNClick() {
        	if ($("#rbtnTechVeriY")[0].checked == true)
        		$("#rbtnTechVeriY")[0].checked = false;
        	if ($("#rbtnDrVerify")[0].checked == true)
        		$("#rbtnDrVerify")[0].checked = false;

        	$("#btnVerify").hide();
        	$("#btnReject").hide();
        	$('.Investigation').trigger('click');
        	$('.OthRpt').css('display', 'none');
        	$('#btnSearch').click();
        }
        function rbtnTVDClick() {
        	if ($("#rbtnTechVeriY")[0].checked == true)
        		$("#rbtnTechVeriY")[0].checked = false;
        	if ($("#rbtnTechVeriN")[0].checked == true)
        		$("#rbtnTechVeriN")[0].checked = false;

        	$("#btnVerify").hide();
        	$("#btnReject").hide();
        	$('.Investigation').trigger('click');
        	$('.OthRpt').css('display', 'none');
        	$('#btnSearch').click();
        }
        function rptVerify() {
        	var ResultNo = $("#txtResultNo").val();
        	var ReportType = "";
        	//$("#txtRejRemarks").css('display', 'none');
        	//document.getElementById("txtRejRemarks").style.display = 'none';
        	//document.getElementById("lblRemarks").style.display = 'none';
        	
        	if ($("#rbtnProv")[0].checked == true)
        		ReportType = "P";
        	else if ($("#rbtnFinal")[0].checked == true)
        		ReportType = "F";
        	
        	$.ajax({
        		type: 'post',
        		data: { ResultNo: ResultNo, RptType: ReportType },
                url: '../Clinicalnotes/SaveTmplRptVerify',
        		cache: false,
        		dataType: 'json',
        		success: function (response) {
        			//MsgDia(response);
        			$.messager.alert("Information", response);
        			$('.Investigation').trigger('click');
        			$('.OthRpt').css('display', 'none');
        			//$('#btnSearch').click();
        			loadInvestigationReport();
        		},
        		error: function () {
        			//MsgDia('getting error while requsesting process', 'information');
        			$.messager.alert("Information", "An error occurred while processing your request.");
        		},

        	});

        }
        function rptReject() {
        	var ResultNo = $("#txtResultNo").val();
        	
        		$('#divRejRemarks').dialog({
        			width: 428, modal: true,
        			buttons: [
									{
										text: "Save",
										click: function () {
											//var validate = validateOutRefComp();
											//if (validate == true) {
											var RejRemarks = $('#txtRejRemarks').val();
											if (RejRemarks.trim() != "") {
												$.ajax({
													type: 'post',
													data: {
														ResultNo: ResultNo,
														RejRemarks: RejRemarks,
													},
													url: 'SaveTmplRptReject',
													cache: false,
													dataType: "json",
													async: false,
													success: function (result) {
														if (result.search("Successful") != -1) // Meenakshi
														{
															$.messager.alert("Information", result);
															//$(this).dialog("close");
															$('#divRejRemarks').dialog("close");
															$('.Investigation').click();
															$('.OthRpt').css('display', 'none');
															$('#btnSearch').click();
															loadInvestigationReport();
															//$('#divRejRemarks').hide();
															var element = document.getElementById("divMain");

															element.scrollIntoView({ behavior: "smooth" });
														}
														else
															$.messager.alert("Information", "An error occurred while processing your request.");
														//MsgDia(result, "Error Information");
													},
													error: function (XMLHttpRequest, textStatus, errorThrown) {
														//MsgDia("An error occurred while processing your request.", "Error Information");
														$.messager.alert("Information", "An error occurred while processing your request.");
													}
												});
											}
											else {
												$.messager.alert("Information", "Please enter the Rejection Remarks.");
												$('#txtRejRemarks').focus();
												return;
											}
											//}
										}
									},
									//{
									//	text: "Cancel",
									//	click: function () {
									//		$(this).dialog("close");
									//	}
									//}
        			],
        			beforeClose: function () {
        				//$('#divRejRemarks input[type=textarea]').val('');
        				$('#divRejRemarks textarea').val('');
        				$('#divRejRemarks').val("");
        			},
        			create: function () {
        				$(this).closest(".ui-dialog").find(".ui-dialog-buttonpane").find(".ui-dialog-buttonset").css("margin-right", "50px");
        			}
        		});
        	
        
        	//var ResultNo = $("#txtResultNo").val();
        	//var RejRemarks = $("#txtRejRemarks").val();
        	////$("#txtRejRemarks").prop('display', 'block');
        	//document.getElementById("txtRejRemarks").style.display = 'block';
        	//document.getElementById("lblRemarks").style.display = 'block';
        	//$.ajax({
        	//	type: 'post',
        	//	data: { ResultNo: ResultNo, RejRemarks: RejRemarks },
        	//	url: '../DoctorDesk/SaveTmplRptReject',
        	//	cache: false,
        	//	dataType: 'json',
        	//	success: function (response) {
        	//		//MsgDia(response);
        	//		$.messager.alert("Information", response);
        	//		$('#btnSearch').click();
        	//		loadInvestigationReport();
        	//	},
        	//	error: function () {
        	//		//MsgDia('getting error while requsesting process', 'information');
        	//		$.messager.alert("Information", "An error occurred while processing your request.");
        	//	},

        	//});

        }
        function ClearAllData() {// 19-12-19
        	SetDateTime();
        
        	$('.Investigation').click();
        	$('.OthRpt').css('display', 'none');
        	$(".tableDivInvestig").css('display', 'none');
        	$("#txtLabDepartment").val("--Select--");
        	$("#rbtnTechVeriY").prop("checked", true);
        	//loadInvestigationReport();        	
        }

        function rptPrint() {
        	var ResultNo = $("#txtResultNo").val();
        	var ReportType = "";
        
        	if ($("#rbtnProv")[0].checked == true)
        		ReportType = "P";
        	else if ($("#rbtnFinal")[0].checked == true)
        		ReportType = "F";

        	$.ajax({
        		type: 'post',
        		data: { ResultNo: ResultNo, RptType: ReportType },
        		url: '../Clinicalnotes/SaveTmplRptVerify',
        		cache: false,
        		dataType: 'json',
        		success: function (response) {
        			if (response == "Success") {

        				var url = 'DisplayPrintTemplate?FormName=' + $('#txtTPatName').val();
        				var win = window.open(url, '_blank');
        				win.focus();
        			}
        			else
        			    MsgDia(response, "Information.");
        			$.messager.alert("Information", response);
        		},
        		error: function () {
        			//MsgDia('getting error while requsesting process', 'information');
        			$.messager.alert("Information", "An error occurred while processing your request.");
        		},

        	});

        }
        //$('#btnRview').click(function () {
        //	FileInfoGrid();
        //	DialogMessage();
        //	FileView();
        //});
        function FileView(RsltNo) {
        	var FilterDt = [];
        	jQuery.grep(GlbResult.TblResult, function (a) {
        		if (a.RESULTNO == RsltNo)
        			FilterDt.push(a);
        	});
        	var datatosend = {
        		MrNo: FilterDt[0].MRNO,
        		OrderNo: FilterDt[0].ORDERNO,
        		SampleNo: FilterDt[0].SAMLECOLNO,
        		strResultno: RsltNo,
        	}
        	$.ajax({
        		type: "POST",
        		url: '../Clinicalnotes/GetDocument',
        		data: datatosend,
        		success: function (response) {
        			jsonData = response.rows;
        			if (jsonData.length > 0) {
        				jQuery.grep(jsonData, function (a) {
        					window.open('../Clinicalnotes/NextTabDownloadFiles?filepath=' + a.PATH.toString().replace(/\s/g, '') + '&filename=' + a.FILENAME.toString(), "_blank");
        				});
        			}
        		},
        		error: function (XMLHttpRequest, textStatus, errorThrown) {
        		    $.messager.alert("Information", textStatus);
        		}
        	});
        }
    </script>
</asp:Content>
