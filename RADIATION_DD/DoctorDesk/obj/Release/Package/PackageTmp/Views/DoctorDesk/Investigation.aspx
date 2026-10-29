<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div style="width:100%;text-align:center">
            <a class="button1 button1-green" id="divForBack"  style="margin-bottom: 1.5%;" onclick="SetpageDirctn()">
  <i class="fa fa-arrow-left"></i>
  <strong>Back</strong>
</a>
            </div>
    <div class="row" style="margin-left: 0px !important">
        <div class="">
            <%-- added by vijeta on 23rd July 2018--%>
            <div style="" id="divDates">
                <span id="DATE1" style="display: inline-block; font-size: 13px; font-weight: bold; width: 50px">From </span>
                <input type="text" id="RptFrmDate" class="inputDates" readonly />
                <span id="DATE2" style="display: inline-block; font-size: 13px; font-weight: bold; width: 40px">To </span>
                <input type="text" id="RptToDate" class="inputDates" readonly />
                <i class="fa fa-search" aria-hidden="true" id="btnSearch" style="font-size: 17px; margin-left: 4px"></i>
            </div>
            <div class="nav-tabs-custom" style="margin-bottom: 0px !important; margin-top: 15px; background-color: #f3d9dd">
                <ul class="nav nav-tabs">
                    <li class="active"><a id="Investigation" class="Investigation" data-toggle="tab" aria-expanded="true">Investigation Wise</a></li>
                    <li class=""><a href="#DateWise" class="DateWise" data-toggle="tab" aria-expanded="false">Date Wise</a></li>
                    <li class=""><a href="#AbnormalValues" class="AbnormalValues" data-toggle="tab" aria-expanded="false">Abnormal Values</a></li>
                    <li class=""><a href="#Trends" class="Trends" data-toggle="tab" aria-expanded="false">Trends</a></li>
                    <li class=""><a href="#OthRpt" class="OthRpt" data-toggle="tab" aria-expanded="false">Other Reports</a></li>
                     <li class=""><a href="#CultureRpt" class="CultureRpt" data-toggle="tab" aria-expanded="false">Culture Report</a></li>  <%--Added by Dhanjay 20241012--%>     
                    <li class=""><a href="#OutsideRpt" class="OutRpt" data-toggle="tab" aria-expanded="false">Outside Reports <i id="outRptPresent" class="fa fa-info-circle" style="color:#37a0ee;font-size: 15px;" aria-hidden="true"></i></a></li>
                </ul>
                <!-- /.tab-content -->
            </div>
            <div id="wrapper" style="overflow: hidden; width: 100%">
                <div class="tableDivInvestig" style="padding-top: 5px; display: none">
                    <div class="row" style="margin-left: 0px !important; margin-right: 0px !important">
                      <%--  <h4 style="color: darkslategray; font-weight: bold">Investigation Chart</h4>--%>
                        <div class="sticky-table sticky-headers sticky-ltr-cells" id="fixedTable">
                            <table id="tblInvestigationChart" style="line-height: 1.5; width: 100%" class="table table-striped">
                                <thead class="fixedHeader"></thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="tableDivAbnormal" style="padding-top: 5px; display: none">
                </div>
                <div class="tableDivDateWise" style="padding-top: 5px; display: none">
                </div>
                <div class="tableTrends" style="padding-top: 5px; display: none">
                    <%--added by vijeta on 25th July 2018--%>
                    <div style="border: 1px solid #afe3f3">
                        <div class="col-md-12 box-header with-border" style="padding-left: 4px; padding-right: 4px;" id="TestListDivHead">
                            <span class="box-title" style="font-size: 19px; font-weight: 400; color: black;">Tests</span>
                            <b><span id="lblTestName" style="margin-left: 2px; font-size: 14px; color: black"></span></b>
                            <!-- /.box-tools -->
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

                </div>
                 <div class="tableOthTempRpt" style="padding-top: 5px; display: none">
                </div>
              
                 <div class="tblOutRptAttachments"  style="padding-top: 5px; display: none">
                 <div id="wrapper1" style="width: 100%">
                    <div class="tableDiv">
                    <table id="tbl1" class="table" style="width: 100%">
                        <tbody id="tblsort1"></tbody>
                    </table>
                </div>
                </div>
            </div>

            <%--// Added by Dhananjay 20240712--%>
                <div id="container"></div>

            </div>
            <div class="alert alert-danger NoRecord">
                <strong>
                    <i class="ace-icon fa fa-times"></i>
                    No Record Found
                </strong>

            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <script src="../plugins/chartjs/chart.min.js"></script>
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
            display: none;
            text-align: center;
            height: 34px;
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
            margin-left: 5px;
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

        @media only screen and (min-width: 1400px) {
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
        $(document).ready(function () {
            $(".tbldiv").css('display', 'none')     // Added by Dhananjay 20240712
            SetPatientDtl();
            AddClinics(urls);
            $("#outRptPresent").hide();
            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
            }

            SetDateTime();

            //Meenakshi
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');
            if (pathFrom != "" && pathFrom != "PAC") {
                $("#divForBack").hide();
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

            localStorage.setItem('IsInvestigationData', false);
            //localStorage.setItem('IsAbnoramlData', false);
            //localStorage.setItem('IsDatewiseData', false);
            //localStorage.setItem('IstTrendsData', false);
            loadInvestigationReport(Mrno);
            showLabFiles(LabFile); //Meenakshi

            $('.Investigation').click(function () {
                $("#divDates").hide();
                $("#container").css('display', 'none')
                var flag = localStorage.getItem("IsInvestigationData")
                $(".tableDivInvestig").css('display', 'block')
                $(".tableDivDateWise").css('display', 'none')
                $(".tableDivAbnormal").css('display', 'none')
                $('.tableOthTempRpt').css('display', 'none')
                $(".tableTrends").css('display', 'none')
                $(".tblOutRptAttachments").css('display', 'none')

                if (flag === 'false') {
                    loadInvestigationReport(Mrno);
                }
            });

            $('.AbnormalValues').click(function () {
                $("#divDates").show();
                //var flag = localStorage.getItem("IsAbnoramlData")
                $(".tableDivAbnormal").css('display', 'block');
                $(".tableDivInvestig").css('display', 'none');
                $(".tableDivDateWise").css('display', 'none');
                $(".tableTrends").css('display', 'none');
                $('.tableOthTempRpt').css('display', 'none')
                $(".tblOutRptAttachments").css('display', 'none')
                $("#container").css('display', 'none')
                // if (flag === 'false') {
                BindAbNormalData();
                //}
            });

            $('.OthRpt').click(function () {
                $("#divDates").show();
                $(".tableDivAbnormal").css('display', 'none');
                $(".tableDivInvestig").css('display', 'none');
                $(".tableDivDateWise").css('display', 'none');
                $(".tableTrends").css('display', 'none');
                $(".tableOthTempRpt").css('display', 'block');
                $(".tblOutRptAttachments").css('display', 'none')
                $("#container").css('display', 'none')
                BindTemplRptData();
            });



            $('.OutRpt').click(function () {
                $("#divDates").hide();
                $(".tableDivAbnormal").css('display', 'none');
                $(".tableDivInvestig").css('display', 'none');
                $(".tableDivDateWise").css('display', 'none');
                $(".tableTrends").css('display', 'none');
                $(".tableOthTempRpt").css('display', 'none');
                $(".tableOthTempRpt").css('display', 'none');
                $(".tblOutRptAttachments").css('display', 'block');
                $("#container").css('display', 'none')
                $('.NoRecord').hide();
            });

            $('.DateWise').click(function () {
                $("#divDates").show(); //added on 24th July 2018
                //$("#btnSearch").addClass("btnSearchCSS");//added on 24th July 2018
                $(".tableDivAbnormal").css('display', 'none')
                $(".tableDivInvestig").css('display', 'none')
                $(".tableDivDateWise").css('display', 'block')
                $(".tableTrends").css('display', 'none')
                $('.tableOthTempRpt').css('display', 'none')
                //var flag = localStorage.getItem("IsDatewiseData")
                //if (flag === 'false') {
                BindDatewiseInvest();
                //}
                $(".tblOutRptAttachments").css('display', 'none')
                $("#container").css('display', 'none')
            });

            $('.Trends').click(function () {
                $("#divDates").show(); //added on 24th July 2018
                $(".tableDivInvestig").css('display', 'none')
                $(".tableDivDateWise").css('display', 'none')
                $(".tableDivAbnormal").css('display', 'none')
                $(".tableTrends").css('display', 'block')
                $('.tableOthTempRpt').css('display', 'none')
                //var flag = localStorage.getItem("IstTrendsData")
                //if (flag === 'false') {
                GetTestList();//added on 25th july 2018
                //GetTrendWiseData()
                //}
                $(".tblOutRptAttachments").css('display', 'none')
                $("#container").css('display', 'none')
            });

            // Added by Dhananjay 20240712  -- 
            $('.CultureRpt').click(function () {
                $("#divDates").show();    // date display on top
                $('.NoRecord').hide();     // hide no records alert
                $(".tableDivAbnormal").css('display', 'none');
                $(".tableDivInvestig").css('display', 'none');
                $(".tableDivDateWise").css('display', 'none');
                $(".tableTrends").css('display', 'none');
                $(".tblOutRptAttachments").css('display', 'none')
                $('.tableOthTempRpt').css('display', 'none')       // Added by Dhananjay 20240730
                $("#container").css('display', 'block') // display table 
                getCultureResult();     // Added by Dhananjay 20240730
            });

            //added on 23rd July 2018
            $("#RptFrmDate,#RptToDate").click(function () {
                $("#ui-datepicker-div.ui-widget").css("z-index", "1000");
            });

            //added on 24th July 2018
            $("#btnSearch").click(function () {

                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();
                var flgInvest = $(".tableDivInvestig").css('display');
                var flagDateWise = $(".tableDivDateWise").css('display');
                var flagAbnormal = $(".tableDivAbnormal").css('display');
                var flagTrends = $(".tableTrends").css('display');
                var flagTempRpt = $(".tableOthTempRpt").css('display');
                var flagCultureRpt = $("#container").css('display');  // Added by Dhananjay 20240712s

                if (flagDateWise == "block")
                    BindDatewiseInvest();

                if (flagAbnormal == "block")
                    BindAbNormalData();

                if (flagTrends == "block")
                    GetTestList();

                if (flagTempRpt == "block")
                    BindTemplRptData();

                if (flagCultureRpt == "block") {  // Added by Dhananjay 20240712 
                    $("#container").empty();
                    getCultureResult();
                }
            });
            //added on 2th July 2018
            //$("#TestListDivHead").click(function () {
            //    tooglediv();
            //});
        });

        // Added by Dhananjay 20240712 
        function getCultureResult() {
            $("#container").empty();   // Added by Dhananjay 20240730
            var strMRNO = ($.session.get('PatMRNO'));
            var frmDate = $("#RptFrmDate").val();
            var toDate = $("#RptToDate").val();

            $.ajax({
                type: "GET",
                url: "../DoctorDesk/GetCultureResult",
                data: {
                    MrnNo: strMRNO,
                    strFrmDate: frmDate,
                    strTodate: toDate
                },
                dataType: "json",
                success: function (response) {
                    $('.NoRecord').hide();
                    var data = (JSON.parse(response)).Results
                    for (let i = 0; i < data.length; i++) {
                        BindCultureRptData(data[i])
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    $('.NoRecord').show();
                }
            });
        }

        // Added by Dhananjay 20240712 
        function BindCultureRptData(result) {

            if (result != null) {
                $("#tblVitalHistory").empty();
                $("#resultInfoDiv").remove(); // Remove existing resultInfoDiv if present
                $("#footerInfoDiv").remove(); // Remove existing footerInfoDiv if present

                // Create tbldiv container for each record with a unique ID
                var $tbldiv = $('<div class="tbldiv" id="tbldiv_' + result.RESULTNO + '" style="overflow-x:auto;"></div>');

                // Create divCaption with a toggle icon
                var formattedDate = formatDate(result.RESULTDATE);
                var resultNo = result.RESULTNO || '';
                // var $divCaption = $('<div class="panel-heading divHeads" style="text-align:center;font-size:14px;background-color:rgba(107, 107, 107, 0.12941176470588237);"></div>');
                var $divCaption = $('<div class="panel-heading divHeads" style="text-align:center;font-size:14px;background-color:rgba(107, 107, 107, 0.12941176470588237);"></div>');
                var leftText = "Result Date " + formattedDate;
                var leftText1 = "Time " + ':' + result.RESULTTIME;
                var middleText = "Result No : " + resultNo + " ";

                //$divCaption.html('<div class="left-side" style="position:relative;padding:0;margin: 0; flex: 1;background:none;">' + leftText + '</div>' +
                //                 '<div class="left-side" style="position:relative;padding:0;margin: 0; flex: 1;background:none;font-size:14px;">' + leftText1 + '</div>' +
                //                 '<div class="middle-side" >' + middleText + '</div>' +
                //                 '<i class="fa fa-caret-right spanCls"></i>'); // Add toggle icon

                //$tbldiv.append($divCaption); // Append caption to tbldiv

                $divCaption.html(
                   "<table style='width:100%;color:white;font-size:12px;'>" +
                       "<tr>" +
                       "<td style='width:24.90%;position:relative;padding:0;margin:0;'>" + leftText + "</td>" +
                       "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + leftText1 + "</td>" +
                       "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + '<span class="TestName">Test Name:</h4> <span>' + (result.TESTNAME || '') + '</span>' + "</td>" +
                        "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + middleText + "</td>" +
                       "<td style='width:auto;position:relative;padding:0;margin:0;'><i class='fa fa-caret-right spanCls'></i></td>" +
                       "</tr>" +
                   "</table>"
                );

                $tbldiv.append($divCaption);

                // First row: Result Date and Result No
                var $firstRow = $('<div class="first-row" style="display:flex;margin-bottom:10px;"></div>');
                //  $firstRow.append('<h5 style="font-weight:bold;">Result Date/Time:</h5> <h5 style="margin-right: 57%;">' + (formattedDate + ' ' + result.RESULTTIME || '') + '</h5>');
                $firstRow.append('');
                $tbldiv.append($firstRow);

                // Second row: Test Name
                var $secondRow = $('<div class="second-row"></div>');
                // $firstRow.append('<h4 class="TestName" style="font-weight:bold;font-size:16px;">Test Name:</h4> <h4 style="font-size:16px;">' + (result.TESTNAME || '') + '</h4>');
                $tbldiv.append($secondRow);

                var $tblVitalHistory = $('<table class="table" style="width: 95%; border-collapse: collapse; border: 1px solid #afadad; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);"></table>');

                // Create table headers
                var $th = "<thead><tr style='background-color:#e3f4fb;'><th>Antibiotics</th><th>MIC</th><th>Interpretation</th></tr></thead>";
                $tblVitalHistory.append($th); // Append headers to tblVitalHistory
                var $tbody = $("<tbody></tbody>"); // Create tbody for table data

                // Add table rows with result details
                var rows = "";
                $.each(result.CultureResults, function (i, item) {
                    var cultypeStyle = (item.CULTYPE === "O") ? "font-size:15px; color:yellowgreen;" : "";
                    rows += "<tr>" +
                        "<td style='width:20%;" + cultypeStyle + "'>" + item.ANTIBIOTIC + "</td>" +
                        "<td style='width:20%;'>" + item.MICVALUE + "</td>" +
                        "<td style='width:20%;'>" + item.Column1 + "</td>" +
                        "</tr>";
                });

                $tbody.append(rows);
                $tblVitalHistory.append($tbody); // Append tbody to tblVitalHistory

                // Append tblVitalHistory to tbldiv
                $tbldiv.append($tblVitalHistory);

                var $footerInfoDiv = $('<div class="footerInfo" style="margin-top:0px;padding:5px;background-color:#f0f0f1;box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);"></div>');
                //$footerInfoDiv.append('<div style="display:flex;margin-bottom:10px;">' +
                //    '<h5 style="font-weight:bold;font-size:14px;">Verify Date/Time:</h5> <h5 style="margin-right: 58%;font-size:14px;">' + (formatDate(result.VERIFIEDON) + '  ' + result.VERIFIEDAT || '') + '</h5>' +
                //    '<h5 style="font-weight:bold;font-size:14px;float:right;">Verify By:</h5> <h5 style="font-size:14px;">' + (result.VERIFIEDBY || '') + '</h5>' +
                //    '</div>');
                //$footerInfoDiv.append('<span style="font-weight:bold;font-size:14px;">Culture Comment:</span> <span style="font-size:14px;">' + result.CULTCOMMENT || '' + '</span>');

                $footerInfoDiv.html(
                "<table style='width:100%;color:black;'>" +
                    "<tr>" +
                    "<td style='width:33.33%;position:relative;padding:0;margin:0;font-size:12px;'>" + "<span style='font-weight:bold;font-size:14px;'>Verify Date/Time:</span>" + (formatDate(result.VERIFIEDON) + '  ' + result.VERIFIEDAT || '') + "</td>" +
                      "<td style='width:33.33%;position:relative;padding:0;margin:0;font-size:12px;'>" + "<span style='font-weight:bold;font-size:14px;'>Verify By:</span>" + (result.VERIFIEDBY || '') + "</td>" +
                     "</tr>" +
                    "<tr>" +
                          "<td colspan='2' style='position:relative;padding:0;margin:0;margin-top:5px;font-size:12px;'>" +
                             "<span style='font-weight:bold;font-size:14px;'>Culture Comment:</span> <span style='font-size:14px;'>" + (result.CULTCOMMENT || '') + "</span>" +
                    "</td>" +
                  "</tr>" +
                "</table>"
              );


                $tbldiv.append($footerInfoDiv);

                // Append footerInfoDiv to tbldiv - 
                $tbldiv.append($footerInfoDiv);

                // Append tbldiv to the parent container - 
                $("#container").append($tbldiv);

                $divCaption.click(function () {
                    var $tbldiv = $(this).closest('.tbldiv');
                    var $table = $tbldiv.find('.table');
                    var $firstRow = $tbldiv.find('.first-row');
                    var $footerInfoDiv = $tbldiv.find('.footerInfo');
                    var $icon = $(this).find('.spanCls');
                    var $secondrow = $(this).find('.second-row')

                    $table.toggle();
                    $firstRow.toggle();
                    $footerInfoDiv.toggle();
                    $secondrow.toggle();

                    // Rotate icon based on visibility 
                    $(this).toggleClass('open');
                });

                // Initially hide the table, firstRow, and footerInfoDiv content
                $tbldiv.find('.table, .first-row, .second-row ,.footerInfo').hide();

            } else {
                // Handle scenario when no data is found
                $("#container").empty().append("<div>No data available</div>"); // Replace #container with your parent element ID or class
            }
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
            // SaveVitals();
            if (pathFrom == "PAC") {
                window.location.href = '../DoctorDesk/PAC?PatMRNO=' + $.session.get('PatMRNO') + '&PatTRANNO=' + $.session.get('PatTRANNO');
            }
            else if (pathFrom == "") {
                window.location.href = '../ClinicalNotes/ClinicEntry';
            } else
                window.location.href = '../DoctorDesk/PatientEntry';
        }

        function openLabNewWin(obj) {
            NAME = obj.innerText;
            var MRNO = ($.session.get('PatMRNO'));
            var url = "../DoctorDesk/LabFileDownload?MRNo=" + MRNO + "&&filename=" + NAME
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

        function loadInvestigationReport(Mrno) {
            checkNoRecordClass();
            $(".tableDivInvestig").css('display', 'block')
            $(".tableDivDateWise").css('display', 'none')
            $(".tableDivAbnormal").css('display', 'none')
            $(".tableTrends").css('display', 'none')
            $.ajax({
                type: 'post',
                url: 'GetInvestigationResult',
                cache: false,
                dataType: "json",
                data: { mrNo: Mrno },
                async: false,
                success: function (response) {

                    if (response != "Unsucessfull") {
                        $("#tblInvestigationChart").empty();

                        if (response == "No Data Found" || response == "") {
                            //$.messager.alert("Information", "No Data Found");
                            //   var emptyRow = "<tr style='background-color: #3c8dbc;color: white;'><td>No Data Found</td></tr>";
                            // $("#tblInvestigationChart").append(emptyRow);

                            $('#fixedTable').hide();
                            //var NorecordDiv = $('.NoRecord')
                            //if ($(NorecordDiv).hasClass('hide')) {
                            //    $(NorecordDiv).removeClass('hide')
                            //}
                            $('.NoRecord').show();
                        }
                        else {
                            console.log(response);

                            result = JSON.parse(response);
                            localStorage.setItem('IsInvestigationData', true);
                            $("#tblInvestigationChart").append('<thead></thead><tbody></tbody>')
                            var strdynamicDate = "";
                            for (var H = 0; H < result.TblDate.length; H++) {
                                strdynamicDate += "<th class='dateColumn'>" + result.TblDate[H].DATETIME + "</th>";
                            }

                            var thead = "<tr class='sticky-row'><th class='first sticky-cell'>Test Name</th><th class='second sticky-cell'>Investigation</th><th class='sticky-cell'>Normal Range</th>" + strdynamicDate + "</tr>";
                            $("#tblInvestigationChart thead").append(thead);
                            var row = '';
                            for (var D = 0; D < result.Investigate.length; D++) {
                                var dateResult = "";
                                for (var H = 0; H < result.TblDate.length; H++) {
                                    var DateOf = result.TblDate[H].DATETIME
                                    dateResult += "<td class='dateColumn'>" + (result.Investigate[D][DateOf] != null ? result.Investigate[D][DateOf] : "") + "</td>";
                                }

                                row += "<tr class='GridViewScrollItem'><td class='testNameCls first sticky-cell'>" + result.Investigate[D]["TESTNAME"].toString().trim() + "</td><td class='second sticky-cell'>" + result.Investigate[D]["INVESTDESC"].toString().trim() + "</td><td class='sticky-cell'>" + result.Investigate[D]["NORMRANGE"].toString().trim() + "</td>" + dateResult + "</tr>";
                            }
                            $("#tblInvestigationChart tbody").append(row);
                            $('.NoRecord').hide();
                        }
                    }
                },
                complete: function (data) {

                    groupTable($('#tblInvestigationChart tr:has(td)'), 0, 1);  // tr:has(td)
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

        function tableGenteAbnormalData(result, datafilter, idval) {
            var AbnormFinalData = jQuery.grep(result.Table, function (j, k) {
                return (j.INVESTDESC == datafilter && j.ABNORMAL == 'Y');
            });
            var selector = '#abnormal_' + idval;
            var element = $(selector);

            if (AbnormFinalData.length > 0) {
                element.append('<div class="box"><div class="box-body table-responsive no-padding"><table class="table table-hover" id="table_Abn' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

                var tableElementSelect = '#table_Abn' + idval;
                var tableElement = $(tableElementSelect)
                var headerRow = $(tableElement).children('thead').children('tr:first')
                var BodyRow = $(tableElement).children('tbody').children('tr:first')

                $.each(AbnormFinalData, function (j, item) {
                    headerRow.append(
                        '<th style="text-align:center;padding:4px !important;">' + $.trim(item.RESULTDATE) + '</th>'
                    );
                });

                $.each(AbnormFinalData, function (i, item) {
                    BodyRow.append(
                        '<td style="text-align:center;padding:4px !important;">' + '<span class="' + item.ABNORMAL + '">' + $.trim(item.RESULTDT) + '</span>' + '</td>'
                    );
                });
            }
            else {
                element.css('display', 'none')
            }
        }

        function tableGenteDatewiseData(result, datafilter, idval) {
            var DateWiseData = jQuery.grep(result.Table, function (j, k) {
                return (j.RESULTDATE == datafilter);
            });
            var selector = '#DateWiseDiv_' + idval;
            var element = $(selector);
            element.append('<div class="box"><div class="box-body table-responsive no-padding"><table class="table table-hover" id="table_Datewise' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

            var tableElementSelect = '#table_Datewise' + idval;
            var tableElement = $(tableElementSelect)
            var headerRow = $(tableElement).children('thead').children('tr:first')
            var BodyRow = $(tableElement).children('tbody').children('tr:first')

            $.each(DateWiseData, function (j, item) {
                headerRow.append(
                    '<th style="text-align:center;padding:4px !important;">' + $.trim(item.INVESTDESC) + '</th>'
                );
            });

            $.each(DateWiseData, function (i, item) {
                BodyRow.append(
                    '<td style="text-align:center;padding:4px !important;">' + '<span class="' + item.ABNORMAL + '">' + $.trim(item.RESULTDT) + '</span>' + '</td>'
                );
            });
        }

        function tableTrendsLineData(result, datafilter, idval) {
            var finalFilterdata = jQuery.grep(result.Table, function (a, index) {
                return (a.INVESTDESC == datafilter);
            });

            /*----------------------labeldata-------------------------------------------------------*/
            var lablelval = $(finalFilterdata).map(function (idex, val) {
                return (val.RESULTDATE);
            }).get().join(',');

            var temp = new Array();
            temp = lablelval.split(",");

            /*----------------------labeldata-------------------------------------------------------*/

            /*----------------------Resultdata-------------------------------------------------------*/

            var actulD = $(finalFilterdata).map(function (idex, val) {
                return $.trim(parseFloat(val.RESULTDT));
            }).get().join(',')

            var Actualdata = new Array();
            Actualdata = actulD.split(",");

            /*----------------------Resultdata-------------------------------------------------------*/

            var Norm1 = $(finalFilterdata).map(function (idex, val) {
                return $.trim(parseFloat(val.NORMALVAL1));
            }).get().join(',')

            var normalData1 = new Array();
            normalData1 = Norm1.split(",");
            console.log(normalData1);

            var Normdata1 = new Array();
            for (var m = 0; m < finalFilterdata.length; m++) {
                Normdata1.push(normalData1[0])
            }

            var Norm2 = $(finalFilterdata).map(function (idex, val) {
                return $.trim(parseFloat(val.NORMALVAL2));
            }).get().join(',')

            var normalData2 = new Array();
            normalData2 = Norm2.split(",");

            var Normdata2 = new Array();
            for (var m = 0; m < finalFilterdata.length; m++) {
                Normdata2.push(normalData2[0])
            }


            var selector = '#line-chart' + idval
            var lineChartData = {
                labels: temp,
                datasets: [
                    {
                        label: "My dataset",
                        fillColor: "rgba(255,255,255,0)",
                        strokeColor: "#120dd6",
                        pointColor: "#120dd6",
                        pointStrokeColor: "#120dd6",
                        pointHighlightFill: "#120dd6",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                        data: Actualdata
                    },

                {
                    label: "My dataset",
                    fillColor: "rgba(255,255,255,0)",
                    strokeColor: "#dd4b39",
                    pointColor: "#dd4b39 ",
                    pointStrokeColor: "#dd4b39",
                    pointHighlightFill: "#dd4b39",
                    pointHighlightStroke: "rgba(220,220,220,1)",
                    data: Normdata2
                }, {
                    label: "My dataset",
                    fillColor: "rgba(255,255,255,0)",
                    strokeColor: "#f6ea0a",
                    pointColor: "#f6ea0a ",
                    pointStrokeColor: "#f6ea0a",
                    pointHighlightFill: "#f6ea0a",
                    pointHighlightStroke: "rgba(220,220,220,1)",
                    data: Normdata1
                }
                ]
            }


            var lineChart = $(selector).get(0).getContext("2d")

            window.lineChart = new Chart(lineChart).Line(lineChartData, {
                scaleShowGridLines: false,
                bezierCurve: false,
                scaleFontSize: 11,
                scaleFontStyle: "normal",
                scaleFontColor: "#fff",
                responsive: true,
                pointDotRadius: 1,
                pointDotStrokeWidth: 3,
                pointLabelFontSize: 10,
                tooltipFontSize: 10,
                tooltipFontStyle: "normal",
            });

        }

        function BindAbNormalData() {
            checkNoRecordClass();
            var frmDate = $("#RptFrmDate").val();
            var toDate = $("#RptToDate").val();
            $.ajax({
                type: 'post',
                url: 'GetInvestigation',
                cache: false,
                dataType: "json",
                data: { mrNo: Mrno, strFrmDate: frmDate, strTodate: toDate },
                async: false,
                success: function (response) {
                    $('.tableDivAbnormal').empty();

                    if (response != "Unsucessfull") {
                        var resultAbnormal = JSON.parse(response);
                        var mainAbNdiv = $('.tableDivAbnormal');
                        var filterAbnormal = '';
                        //localStorage.setItem('IsAbnoramlData', true);

                        $.each(resultAbnormal.INVESTDESC, function (i, v) {
                            mainAbNdiv.append('<div class="" id="abnormal_' + (i) + '">'
                                                  + '<div style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.INVESTDESC + ' </label><div></div>');
                            filterAbnormal = v.INVESTDESC;
                            tableGenteAbnormalData(resultAbnormal, filterAbnormal, i);
                            filterAbnormal = ''
                        });

                        $('.NoRecord').hide();
                    }
                    else {
                        //var NorecordDiv = $('.NoRecord')
                        //if ($(NorecordDiv).hasClass('hide')) {
                        //    $(NorecordDiv).removeClass('hide')
                        //}
                        $('.NoRecord').show();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Information", "An error occurred while processing your request.");

                }
            });
        }

        function BindDatewiseInvest() {
            checkNoRecordClass();
            var frmDate = $("#RptFrmDate").val();
            var toDate = $("#RptToDate").val();
            $.ajax({
                type: 'post',
                url: 'GetDateWiseInvestigation',
                cache: false,
                dataType: "json",
                data: { mrNo: Mrno, strFrmDate: frmDate, strTodate: toDate },
                async: false,
                success: function (response) {
                    $('.tableDivDateWise').empty();

                    if (response != "Unsucessfull") {
                        var resultDateWise = JSON.parse(response);
                        var mainDateWisediv = $('.tableDivDateWise');
                        var filterAbnormal = '';
                        //localStorage.setItem('IsDatewiseData', true);

                        $.each(resultDateWise.RESULTDATE, function (i, v) {
                            mainDateWisediv.append('<div class="" id="DateWiseDiv_' + (i) + '">'
                                                  + '<div style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label><div></div>');
                            filterAbnormal = v.RESULTDATE;
                            tableGenteDatewiseData(resultDateWise, filterAbnormal, i);
                            filterAbnormal = ''
                        });
                        $('.NoRecord').hide();
                    }

                    else {
                        //var NorecordDiv = $('.NoRecord')
                        //if ($(NorecordDiv).hasClass('hide')) {
                        //    $(NorecordDiv).removeClass('hide')
                        //}
                        $('.NoRecord').show();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Information", "An error occurred while processing your request.");

                }
            });
        }

        function BindTemplRptData() {
            checkNoRecordClass();
            var frmDate = $("#RptFrmDate").val();
            var toDate = $("#RptToDate").val();
            $.ajax({
                type: 'post',
                url: 'GetTemplateResult',
                cache: false,
                dataType: "json",
                data: { mrNo: Mrno, strFrmDate: frmDate, strTodate: toDate },
                async: false,
                success: function (response) {
                    $('.tableOthTempRpt').empty();
                    if (response != "Unsucessfull") {
                        var resultDateWise = JSON.parse(response);
                        var mainDateWisediv = $('.tableOthTempRpt');
                        $.each(resultDateWise.Table, function (i, v) {
                            var CollectionNo = v.SAMLECOLNO;
                            var DicomLink = v.LABTYPE == "R" && v.SAMLECOLNO != "" ? "<a style='float: right; text-decoration: underline; cursor: pointer;' onclick='RedirecttoDICOMSampleCollect(" + CollectionNo + ")'>DICOM</a>" : "";
                            mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label>' + DicomLink + '</div>');
                            mainDateWisediv.append('<div class="parent" id="TmpRptDtWise_' + (i) + '" onClick="selectText(this.id);" > ');
                            v.RESULTDT = v.RESULTDT.replace(/<link[^>]*href="data:text\/css[^"]*"[^>]*>/i,'');
                            $("#TmpRptDtWise_" + (i)).html(v.RESULTDT);
                            mainDateWisediv.append('</div><div style="font-size: 13px !important;"><div class="parent" id="TmpRptAmentDtWise_' + (i) + '">');
                            $("#TmpRptAmentDtWise_" + (i)).html(v.Ammendments);
                            mainDateWisediv.append('</div><div style="float:left;" class="" id="TmpRptVerifiedDtWise_' + (i) + '">');
                            $("#TmpRptVerifiedDtWise_" + (i)).html("<b>Verified By : " + v.VERIFIEDBY + "</b>");
                            mainDateWisediv.append('</div><div style="margin-left : 50px ;float:left;" class="" id="TmpRprtByDtWise_' + (i) + '">');
                            $("#TmpRprtByDtWise_" + (i)).html("<b>Reported By : " + v.CREATEDBY + "</b>");
                            mainDateWisediv.append('</div></div></br><hr>');
                        });
                        $('.NoRecord').hide();
                    }

                    else {
                        //var NorecordDiv = $('.NoRecord')
                        //if ($(NorecordDiv).hasClass('hide')) {
                        //    $(NorecordDiv).removeClass('hide')
                        //}
                        $('.NoRecord').show();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Information", "An error occurred while processing your request.");
                }
            });
        }

        function RedirecttoDICOMSampleCollect(CollectNo) {
            if (CollectNo != "") {
                HoldOn.open();
                $.ajax({
                    type: 'POST',
                    url: '../DoctorDesk/RedirectToDicomSample',
                    data: { SampleNo: CollectNo },
                    success: function (data) {
                        HoldOn.close();
                        window.open(data);
                    },
                    error: function () {
                        HoldOn.close();
                    }
                });
            }
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
            $("#RptFrmDate").val(prevDate);
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
        function GetTestList() {
            var frmDate = ""; var toDate = ""; var TestList = "";
            var frmDate = $("#RptFrmDate").val();
            var toDate = $("#RptToDate").val();
            var strmrno = ($.session.get('PatMRNO'));
            $.ajax({
                type: 'post',
                url: 'GetTrendsTestCode',
                cache: false,
                dataType: "json",
                data: { mrNo: strmrno, FrmDate: frmDate, ToDate: toDate },
                async: false,
                success: function (response) {

                    if (response != "Unsucessfull") {
                        $('.NoRecord').hide();
                        $("#chartNote").hide();
                        $("#divCharts").empty();
                        $('#lblTestName').text('');
                        $("#TestListDivHead").show();
                        ParseResult = JSON.parse(response);
                        $('#TestListDiv').children().remove();

                        $.each(ParseResult, function (I, E) {
                            var color = getRandomColor();
                            var TestName = E.TESTNAME;
                            var More = "";
                            if (TestName.length > 20) {
                                More = "....."
                            }
                            var SummaryTestName = TestName.substring(0, 20);
                            TestList += '<div class="col-md-2 col-xs-6"><button id="' + E.TESTCODE + '" style="outline:none;background-color:' + color
                                + ';width:140px;height:28px;color:#252020;font-weight:bold;font-size:11px;" title="' + TestName.toString().trim() + '"  class="btnTrend btnTrend-primary btnTrend-block" onclick="GetTestTrends(this)">' + SummaryTestName + More + '</button></div>'

                        });


                        $('#TestListDiv').append(TestList);

                    }
                    else {

                        $('.NoRecord').show();
                        $('#TestListDiv').children().remove();
                        $("#chartNote").hide();
                        $("#TestListDivHead").hide();
                        $("#divCharts").empty();

                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //$.messager.alert("Information", "An error occurred while processing your request.");
                    $.alert({
                        title: 'Alert!',
                        content: 'An error occurred while processing your request !',
                    });
                }
            });
        }

        //added on 25th July 2018
        function getRandomColor() {
            color = "hsl(" + Math.random() * 12000 + ", 30%, 60%)";
            return color;
        }
        //added on 25th July 2018
        function GetTestTrends(obj) {
            $('#lblTestName').text('');
            var TestCode = $(obj).attr('id');
            var TestName = $(obj)[0].title;//$(obj).text();
            GetTrendWiseData(TestCode)
            $('#lblTestName').text(" [" + TestName.toString().trim() + "] ");

        }
        //added on 25th July 2018
        function GetTrendWiseData(TestCode) {

            var frmDate = ""; var toDate = "";
            var frmDate = $("#RptFrmDate").val();
            var toDate = $("#RptToDate").val();
            var strmrno = ($.session.get('PatMRNO'));

            checkNoRecordClass();
            $.ajax({
                type: 'post',
                url: 'GetTrendsInvestigation',
                cache: false,
                dataType: "json",
                data: { mrNo: strmrno, TestCode: TestCode, strFrmDate: frmDate, strTodate: toDate },
                async: false,
                success: function (response) {
                    $('#chartNote').show();
                    var maindiv = $('.divSubList');
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        innerMainDiv = $(maindiv).find('div');
                        $(innerMainDiv).find('div').remove();
                        var datafilter;
                        //localStorage.setItem('IstTrendsData', true);
                        $.each(result.INVESTDESC, function (i, v) {
                            $(innerMainDiv).append('<div class="col-md-6" style="padding:1px !important" id="my_test_' + (i) + '">'
                                                  + '<div class="card"><div class="card-content  teal darken-2"><div class="line-chart-wrapper"><p class="margin white-text" style="font-weight:400;font-size:13px">'
                                                  + v.INVESTDESC + '</p><canvas height="77" width="203" style="width: 203px; height: 77px;"id="line-chart' + (i) + '"></canvas></div></div></div>');
                            datafilter = v.INVESTDESC;
                            tableTrendsLineData(result, datafilter, i)
                        });

                        //tooglediv();
                        //ajaxindicatorstop();
                    }
                    else {
                        //ajaxindicatorstop();
                        //$(maindiv).find('div').remove();
                        $.alert({
                            title: 'Alert!',
                            content: 'No records founds !',
                        });

                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //ajaxindicatorstop();
                    //  $.messager.alert("Information", "An error occurred while processing your request.");
                    $.alert({
                        title: 'Alert!',
                        content: 'An error occurred while processing your request !',
                    });
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
    </script>
</asp:Content>
