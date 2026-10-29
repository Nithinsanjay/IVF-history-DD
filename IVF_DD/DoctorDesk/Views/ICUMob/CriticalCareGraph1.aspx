<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.CriticalCareGraph>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="dateDiv">
        <span id="DATE" style="display: inline-block;">Date :</span><%=Html.TextBoxFor(x => Model.Date, new { id="Rptdate",@class = "TextBxFormat",@style="width:90px; readonly :true;     margin-top: 6px; margin-left: 20px", @readonly=true })%>
       <%--   <label class="lblHeading">Date: <%: Model.Date %></label>--%>
          <label class="lblHeading">IP NO: <%: Model.IPNO %></label>
            <label class="lblHeading" style="margin-left:3px;">MR NO: <%: Model.MrNo %></label>
    </div>
   <%-- <div id="heading" style="margin-top: 10px;margin-left:4px;">
        <div class="row">
            <label class="lblHeading">Date: <%: Model.Date %></label>
            <label class="lblHeading">IP NO: <%: Model.IPNO %></label>
            <label class="lblHeading">MR NO: <%: Model.MrNo %></label>
        </div>
    </div>--%>

    <div id="CaseDetDiv" style="font-size:13px;">
        <table id="tblCaseDetail" border="1" style="width: 80%;">
            <tr>
                <th colspan="8">Diagnosis: 
                    <label style="color: #f64a07; font-weight: bold;"><%: Model.Diagnosis %></label></th>
            </tr>
            <tr>
                <th colspan="8">Operation:
                    <label style="color: #f64a07;  font-weight: bold;"><%: Model.SurgeryNm %> </label>
                </th>
            </tr>
            <tr>
                <th>Post OP Days</th>
                <td style="color: #f64a07; font-weight: bold;"><%: Model.PostOPDays %></td>
                <th>ICU Days</th>
                <td style="color: #f64a07;  font-weight: bold;"><%: Model.ICUDays %></td>
                <th>EF</th>
                <td style="color: #f64a07; font-weight: bold;"><%: Model.EF %></td>
                <th>Temp Max</th>
                <td style="color: #f64a07;font-weight: bold;"><%=Model.TempMax %></td>
            </tr>
            <tr>
                <th>Weight</th>
                <td style="color: #f64a07;font-weight: bold;"><%: Model.Weight %></td>
                <th>Height</th>
                <td style="color: #f64a07;  font-weight: bold;"><%: Model.Height %></td>
                <th>BMI</th>
                <td style="color: #f64a07;font-weight: bold;"><%: Model.BMI %></td>
                <th></th>
                <td></td>
            </tr>
        </table>

        <table border="1" style="width:80%; margin-top: 7px;" id="tblCaseDetail2">
            <tr style="background-color: #c6eaea;">
                <th colspan="3" style="font-size: 13px; text-align: center;">Input</th>
                <th colspan="6" style="font-size: 13px; text-align: center;">Output</th>
            </tr>
            <tr>
                <th>Non Parental</th>
                <th>Parental</th>
                <th>OT</th>
                <th>UF</th>
                <th>Urine</th>
                <th>Drain</th>
                <th>RT</th>
                <th>Blood Collection</th>
                <th>OT</th>
            </tr>
            <tr>
                <td><%: Model.NonParentamIP %></td>
                <td><%: Model.ParentalIP %></td>
                <td><%: Model.OTIP %></td>
                <td><%: Model.UFOP %></td>
                <td><%: Model.UrineOP %></td>
                <td><%: Model.DrainOP %></td>
                <td><%: Model.RTOP %></td>
                <td><%: Model.BloodOP %></td>
                <td><%: Model.OTOP %></td>
            </tr>
            <tr>
                <th colspan="3">Total:
                    <label style="color: #f64a07;  font-weight: bold;"><%: Model.TotalIP %></label></th>
                <th colspan="6">Total:<label style="color: #f64a07; font-weight: bold;"><%: Model.TotalOP %></label></th>
            </tr>
            <tr style="background-color: #c6eaea; font-size: 13px">
                <th colspan="3">
                    <label style="font-weight: bold;">Balance:</label>
                    <label style="color: #f64a07; font-weight: bold;"><%: Model.Balance %></label></th>
                <th colspan="6">
                    <label style="font-weight: bold;">Cummulative Balance:</label><label style="color: #f64a07; font-weight: bold;"><%: Model.CumulativeBal %></label></th>
            </tr>
        </table>
    </div>


    <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding: 25px; margin-top: -22px;">Temperature </label>
    <div class="chartWrapper" style="overflow-x: auto; overflow-y: hidden; margin-top: -20px;" id="chartWrapperTemp">
        <div class="chartAreaWrapper">
            <div id="TemperatureGraph" class="tempGraph"></div>
        </div>

    </div>


    <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding: 25px">Heart Rate </label>
    <div class="chartWrapper" style="overflow-x: auto; overflow-y: hidden; margin-top: -20px;" id="chartWrapperHeart">
        <div class="chartAreaWrapper">
            <div id="HeartRateGraph" class="tempGraph"></div>
            <div style="text-align: center;">
            </div>
        </div>
    </div>

    <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding: 25px">Pressure </label>
    <div class="chartWrapper" style="overflow-x: auto; overflow-y: hidden; margin-top: -20px;" id="chartWrapperPressure">
        <div class="chartAreaWrapper">
            <div id="pressureGraph" class="pressGraph"></div>
            <div style="text-align: center;">
                <%-- <label>Page 2/4</label>--%>
            </div>
        </div>
    </div>

    <div style="margin-top: 16px; text-align: left; margin-left: -7px;">
        <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding-left: 22px">Intake And Output </label>
        <p id="pTagCriticalAssmnt2"></p>
        <table id="tblCriticalList2" class="tblCriticalLst2Cls" style="margin-top: -20px;"></table>
    </div>

    <div style="margin-top: 16px; margin-left: -7px;">
        <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding-left: 22px">Critical care assessment </label>
        <p id="pTagCriticalAssmnt1"></p>

        <table id="tblCriticalList" class="tblCriticalCls" style="margin-top: -20px;"></table>
    </div>
    <div style="margin-top: 16px; text-align: left; margin-left: -7px;">
        <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding-left: 22px">Respiratory Assessment </label>
        <p id="pTagRespiratoryAssessment"></p>
        <table id="tblRespiratoryAss" style="margin-top: -20px;"></table>
    </div>

    <div style="margin-top: 16px; margin-left: -7px;" id="AssmntOfLineDiv">
        <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding-left: 22px; margin-top: 10px">Assessment Of Line </label>
        <p id="pTagAssessmentOfLine"></p>
        <table id="tblAssessmentOfLine"></table>
    </div>

     <div style="margin-top: 16px; margin-left: -7px;" id="SpclObsrvDiv">
        <label style="font-weight: bolder; color: #008B8B; font-family: tahoma; font-size: 20px; padding-left: 22px; margin-top: 10px">Special Observation </label>
        <p id="pSpclObsrv"></p>
        <table id="tblSpclObsrv"></table>
    </div>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style>
        #tblCaseDetail td, #tblCaseDetail th {
            border: 1px solid #777474;
            padding: 2px;
            font-size: 11px;
        }

        #tblCaseDetail2 td, #tblCaseDetail2 th {
            border: 1px solid #777474;
            padding: 2px;
            font-size: 11px;
        }

        .canvasjs-chart-canvas {
            position: unset !important;
        }

        .canvasjs-chart-tooltip.canvasjs-chart-toolbars {
            position: absolute !important;
        }


        .ui-jqgrid tr.jqgrow td.colCellWrap {
            word-wrap: break-word; /* IE 5.5+ and CSS3 */
            white-space: pre-wrap; /* CSS3 */
            white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
            white-space: -pre-wrap; /* Opera 4-6 */
            white-space: -o-pre-wrap; /* Opera 7 */
            overflow: hidden;
            height: auto;
            vertical-align: middle;
            padding-top: 3px;
            padding-bottom: 3px;
        }


        .chartWrapper {
            position: relative;
            margin-left: 10px;
        }

            .chartWrapper > canvas {
                left: 0;
                top: 0;
                pointer-events: none;
            }

        .chartAreaWrapper {
            width: 997px;
        }


        .tempGraph {
            height: 350px;
            width: 1000px;
        }

        .pressGraph {
            height: 400px;
            width: 1000px;
        }


        .tblCriticalLst2Cls {
            width: 900px;
        }

        .lblHeading {
            font-weight: bolder;
            color: #6b2525;
            font-family: tahoma;
            font-Size: 11px;
            /*padding: 5px;*/
            margin-top: -30px;
        }

        .ui-jqgrid-view#gview_tblCriticalList2 {
            height: 400px;
        }

        .StyleCss {
            background-color: #ececaf !important;
        }

        .one {
            background-color: #ececaf !important;
            font-size: 12px;
            color: red !important;
            font-weight: bold !important;
        }

        /*20-11-17*/
        .ui-jqgrid tr.jqgrow td {
            white-space: normal !important;
            height: auto;
            vertical-align: middle;
            padding-top: 2px;
            padding-bottom: 2px;
        }

        .ui-jqgrid .ui-jqgrid-htable th.ui-th-column {
            padding-top: 2px;
            padding-bottom: 2px;
        }

        .ui-jqgrid .frozen-bdiv, .ui-jqgrid .frozen-div {
            overflow: hidden;
        }


        /*set back color to saome rows of Respiratory assessment*/
        .backcolor {
            background-color: #ececaf !important;
            color: blue !important;
        }

        /*text-align of group headers of Respiratory Assess set to center*/
        th.ui-th-column-header {
            text-align: center;
            /*font-family: Arial,Helvetica,sans-serif;*/
            font-weight: bold !important;
            font-size: 12px;
        }

        /*ui-jqgrid-bdiv.ui-jqgrid-btable {
            margin-top: 0px;
        }*/

        table.ui-jqgrid-btable {
            margin-top: 0px !important;
        }
        /*20-11-17*/

        @media only screen and (min-width : 992px) {
            /*meenakshi*/
            /*.content {
                width: 105%;
                padding-left: 315px;
            }*/

            .tempGraph {
                height: 350px;
                width: 100%;
            }

            .pressGraph {
                height: 780px;
                width: 100%;
            }



            .tblCriticalLst2Cls {
                width: 1150px;
                /*height:800px;*/
            }


            .chartWrapper {
                position: relative;
                margin-left: 0px;
            }

            /*.chartAreaWrapper {
                width: 100%;
                overflow-x: hidden;
            }*/
            .ui-jqgrid-view#gview_tblCriticalList {
                width: auto;
            }

            .ui-jqgrid-view#gview_tblCriticalList2 {
                height: auto;
            }

            .inputbackcolor {
                background-color: #eddffb !important;
            }

            .outputbackcolor {
                background-color: #e1faff !important;
            }

            .two {
                /*background-color:#ececaf !important;*/
                font-size: 12px;
                color: blue !important;
                /*font-weight:bold !important;*/
            }

                .two td {
                    font-weight: bold !important;
                }

            .backcolor {
                background-color: #ececaf !important;
                color: blue !important;
            }

            .CancelClass td {
                color: rgb(220, 9, 9) !important;
                background-image: none;
                font-weight: bold !important;
                background: rgba(190, 53, 51, 0.04);
            }
        }
    </style>
    <link href="../Content/calenderextra.css" rel="stylesheet" />
    <link href="../Content/select2-bootstrap.css" rel="stylesheet" />
    <script src="../Scripts/ICUPatList.js"></script>
    <meta name="viewport" content="width=device-width" />
    <link href="../Content/braviStyle.css" rel="stylesheet" />
    <link href="../Content/style.css" rel="stylesheet" />
    <link href="../js/ui.jqgrid.css" rel="stylesheet" />
  <%--  <link href="../Content/Jquery-ui-Custom.css" rel="stylesheet" />--%>
    
    <script>
        var dt1 = "Date1";
        var dt2 = "Date2";
        $(document).ready(function () {

            SetDateTime();
            SetPatientDtl();
            if ($(window).width() >= 996) {                                            //screen width size comparison
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
            }

            DatePlus1DayIncrement();
            GetNursStationsNPAtients();



            var oTable = '<%= ViewData["RECTAL"] %>';
            var RectalTempData;
            if (oTable != '' && oTable != null)
                RectalTempData = JSON.parse(oTable);
            else
                RectalTempData = '';

            oTable = '<%= ViewData["ORAL"] %>';
            var OralTempData;
            if (oTable != '' && oTable != null)
                OralTempData = JSON.parse(oTable);
            else
                OralTempData = '';

            oTable = '<%= ViewData["PERIPHERAL"] %>';
            var periPheralTempData;
            if (oTable != '' && oTable != null)
                periPheralTempData = JSON.parse(oTable);
            else
                periPheralTempData = '';

            CreateTempChart(periPheralTempData,RectalTempData, OralTempData);

            //Heart Rate

            oTable = '<%= ViewData["PATRATE"] %>';
            var patRateDt;
            if (oTable != '' && oTable != null)
                patRateDt = JSON.parse(oTable);
            else
                patRateDt = '';


            oTable = '<%= ViewData["PACERATE"] %>';
            var paceRatedt;
            if (oTable != '' && oTable != null)
                var paceRatedt = JSON.parse(oTable);
            else
                paceRatedt = '';

            CreateHeartRateChart(patRateDt, paceRatedt);

            //Pressure

            oTable = '<%= ViewData["NIBP"] %>';
            var NIABPDT = '';
            if (oTable != '' && oTable != null)
                NIABPDT = JSON.parse(oTable);

            oTable = '<%= ViewData["IABP"] %>';
            var IABPDT = '';
            if (oTable != '' && oTable != null)
                IABPDT = JSON.parse(oTable);

            oTable = '<%= ViewData["PAP"] %>';
            var PAPDT = '';
            if (oTable != '' && oTable != null)
                PAPDT = JSON.parse(oTable);

            oTable = '<%= ViewData["CVP"] %>';
            var CVPDT = '';
            if (oTable != '' && oTable != null)
                CVPDT = JSON.parse(oTable);

            oTable = '<%= ViewData["IBP"] %>';
            var IBPDT = '';
            if (oTable != '' && oTable != null)
                IBPDT = JSON.parse(oTable);

            oTable = '<%= ViewData["RR"] %>';
            var RRDT = '';
            if (oTable != '' && oTable != null)
                RRDT = JSON.parse(oTable);

            CreatePressureChart(NIABPDT, IABPDT, PAPDT, CVPDT, IBPDT, RRDT);

            if ('<%= ViewData["OTHERDT"] %>' != null && '<%= ViewData["OTHERDT"] %>' != '') {
                BindCriticalAssmntListGrid();
                var LISTDATA = '<%:Html.Raw(ViewData["OTHERDT"])%>';
                $('#tblCriticalList').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA)
                }).trigger("reloadGrid");
            }
            else {
                $("#pTagCriticalAssmnt1").html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }

            if ('<%= ViewData["GRIDDATA"] %>' != null && '<%= ViewData["GRIDDATA"] %>' != '') {
                BindCriticalAssmntList2Grid();
                var LISTDATA2 = '<%:Html.Raw(ViewData["GRIDDATA"])%>';
                $('#tblCriticalList2').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA2)
                }).trigger("reloadGrid");
            }
            else {
                $("#pTagCriticalAssmnt2").html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }

            if ('<%= ViewData["ASSOFLINEDATA"] %>' != null && '<%= ViewData["ASSOFLINEDATA"] %>' != '') {
                //$("#AssmntOfLineDiv").show();
                BindAssessmentOfLinesGrid();
                var ASSOFLINELIST = '<%:Html.Raw(ViewData["ASSOFLINEDATA"])%>';
                $('#tblAssessmentOfLine').jqGrid('setGridParam', {
                    data: JSON.parse(ASSOFLINELIST)
                }).trigger("reloadGrid");
            }
            else {
                $("#pTagAssessmentOfLine").html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }


            if ('<%= ViewData["RESPIRATORY"] %>' != null && '<%= ViewData["RESPIRATORY"] %>' != '') {
                BindRespiratoryAssessmentGrid();
                var RESPASSLIST = '<%:Html.Raw(ViewData["RESPIRATORY"])%>';
                $('#tblRespiratoryAss').jqGrid('setGridParam', {
                    data: JSON.parse(RESPASSLIST)
                }).trigger("reloadGrid");
            }
            else {
                $("#pTagRespiratoryAssessment").html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }


            if ('<%= ViewData["SPECOBSERV"] %>' != null && '<%= ViewData["SPECOBSERV"] %>' != '') {
                BindSpclObservationGrid();
                var LISTDATA = '<%:Html.Raw(ViewData["SPECOBSERV"])%>';
                $('#tblSpclObsrv').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA)
                }).trigger("reloadGrid");
            }
            else {
                $("#pSpclObsrv").html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }




            //}

            //$(window).on("resize", function () {
            //    var $grid = $("#tblCriticalList"),
            //        newWidth = $grid.closest(".ui-jqgrid").parent().width();
            //    $grid.jqGrid("setGridWidth", newWidth, true);                           
            //});

            $("#Rptdate").change(function () {
                var strDate = $("#Rptdate").val();
                var strIPNO = $.session.get('ICUPatIPNO');
                window.location.href = '../ICUMob/CriticalCareGraph1?strIPNO=' + strIPNO + '&&strDate=' + strDate;
            });
        });


        function SetDateTime() {
            var admissiondate = $.session.get('ICUPatAdmnDate');
            //var today = new Date();
            //var dd = today.getDate();
            //var mm = today.getMonth() + 1;
            //var yyyy = today.getFullYear();
            //if (dd < 10) {
            //    dd = '0' + dd
            //}
            //if (mm < 10) {
            //    mm = '0' + mm
            //}
            //today = dd + '/' + mm + '/' + yyyy;
            //$("#Rptdate").val(today);

            $("#Rptdate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            maxDate: new Date(),
                            minDate: admissiondate
                        });

            //   MinDate();

        }

        function DatePlus1DayIncrement() {
            var chngDate1 = '<%: Model.Date%>';
            dt1 = chngDate1; //Meenakshi

            var chngDate2 = '<%: Model.Date%>';
            var year = chngDate2.substring(10, 6);
            var month = chngDate2.substring(5, 3);
            var day = chngDate2.substring(0, 2);
            var setadmndate = year + ',' + month + ',' + day;
            var actualDate = new Date(setadmndate); // convert to actual date

            var nextDate = new Date(actualDate.getFullYear(), actualDate.getMonth(), actualDate.getDate() + 1);
            var nextDate1 = new Date(nextDate);
            var noday = nextDate1.getDate();
            var month = nextDate1.getMonth() + 1;
            var monthname = GetMonthName(month);
            var year = nextDate1.getFullYear();

            dt2 = noday + " " + " " + monthname + " " + year;

        }

        function GetMonthName(monthNumber) {
            var months = ['January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'];
            return months[monthNumber - 1];
        }

        function CreateTempChart(periPheralTempData, RectalTempData, OralTempData, type) {
            //var ChartHeading = "Temperature";
            var gDivNm = "";

            var chart = new CanvasJS.Chart("TemperatureGraph",
                {
                    animationEnabled: false,
                    animationDuration: 1500,
                    zoomEnabled: true,
                    panEnabled: false,
                    exportEnabled: false,
                    //title: {
                    //    text: ChartHeading,
                    //    fontWeight: "bolder",
                    //    fontColor: "#008B8B",
                    //    fontfamily: "tahoma",
                    //    horizontalAlign: "left",
                    //    fontSize: 40,
                    //    padding: 15,
                    //    margin: 10,
                    //},
                    axisY: {

                        interval: 1,
                        includeZero: false,
                        labelFontSize: 12,
                        minimum: 90,
                        maximum: 107,
                        valueFormatString: "##.#",
                        labelFontColor: "black",
                        stripLines: [
			                            {
			                                startValue: 98.7,
			                                endValue: 98.6,
			                                color: "black",
			                            }
                        ]
                    },
                    axisX: {

                        gridThickness: 1,
                        //labelFormatter: function (e) {
                        //    return "x: " + e.value;
                        //}
                        interval: 1,
                        //intervalType: "hour",
                        //valueFormatString: "hh TT",
                        labelFontSize: 12,
                        labelAngle: -20,
                        labelFontColor: "black",
                    },
                    legend: {
                        verticalAlign: "bottom",
                        horizontalAlign: "left"
                    },

                    data: [
                        {
                            connectNullData: false, indexLabel: "{y}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal", type: "line", dataPoints: [], showInLegend: true, legendText: "Oral", lineColor: "red", markerType: "triangle"
                        },
                        {
                            connectNullData: false, indexLabel: "{y}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal", type: "line", dataPoints: [], showInLegend: true, legendText: "Peripheral", lineColor: "green", markerType: "cross"
                        },
                        {
                            connectNullData: false, indexLabel: "{y}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal", type: "line", dataPoints: [], showInLegend: true, legendText: "Rectal", lineColor: "blue", markerType: "circle"
                        }
                    ]
                });

            var periPheralArry = [];
            var oralArry = [];
            var rectalArry = [];


            for (var i = 0; i <= periPheralTempData.length - 1 ; i++) {
                var value = periPheralTempData[i].VALUE;
                if (("" + value).toString().trim() == "") {
                    periPheralArry.push(false);
                    chart.options.data[0].dataPoints.push({ y: null, label: periPheralTempData[i].TIME });
                }
                else {
                    periPheralArry.push(true);
                    chart.options.data[0].dataPoints.push({ y: parseFloat(value), label: periPheralTempData[i].TIME });
                }
            }

            for (var i = 0; i <= OralTempData.length - 1 ; i++) {

                var value = OralTempData[i].VALUE;
                if (("" + value).toString().trim() == "") {
                    oralArry.push(false);
                    chart.options.data[1].dataPoints.push({ y: null, label: OralTempData[i].TIME });
                }
                else {
                    oralArry.push(true);
                    chart.options.data[1].dataPoints.push({ y: parseFloat(value), label: OralTempData[i].TIME });
                }
            }


            for (var i = 0; i <= RectalTempData.length - 1 ; i++) {
                var value = RectalTempData[i].VALUE;
                if (("" + value).toString().trim() == "") {
                    rectalArry.push(false);
                    chart.options.data[2].dataPoints.push({ y: null, label: RectalTempData[i].TIME });
                }
                else {
                    rectalArry.push(true);
                    chart.options.data[2].dataPoints.push({ label: RectalTempData[i].TIME, y: parseFloat(RectalTempData[i].VALUE) });
                }
            }

            if ($.inArray(true, periPheralArry) != -1 || $.inArray(true, oralArry) != -1 || $.inArray(true, rectalArry) != -1)
                chart.render();
            else {
                $("#chartWrapperTemp").css({ "height": "20px" }).html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }

        }



        function CreateHeartRateChart(PatRateData, PaceRateData, type) {
            //var ChartHeading = "Heart Rate";
            var gDivNm = "";

            var chart = new CanvasJS.Chart("HeartRateGraph",
                {
                    animationEnabled: true,
                    animationDuration: 1500,
                    zoomEnabled: true,
                    panEnabled: true,
                    exportEnabled: false,
                    //title: {
                    //    text: ChartHeading,
                    //    fontWeight: "bolder",
                    //    fontColor: "#008B8B",
                    //    fontfamily: "tahoma",
                    //    horizontalAlign: "left",
                    //    fontSize: 30,
                    //    padding: 25
                    //},
                    legend: {
                        verticalAlign: "bottom",
                        horizontalAlign: "left"
                    },
                    axisY: {
                        interval: 10,
                        includeZero: false,
                        labelFontSize: 12,
                        minimum: 20
                        //maximum: 200
                    },
                    axisX: {
                        gridThickness: 1,
                        interval: 1,
                        labelFontSize: 12,
                        labelAngle: -20,
                    },
                    data: [
                        {
                            type: "line", indexLabel: "{y}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal", dataPoints: [], markerType: "circle", showInLegend: true, legendText: "Patient Rate", legendMarkerType: "circle", lineColor: "red"
                        },
                        {
                            type: "line", indexLabel: "{y}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal", dataPoints: [], markerType: "cross", showInLegend: true, legendText: "Paced Rate ", legendMarkerType: "cross", lineColor: "green"
                        },
                    ]
                });

            var patRateArry = [];
            var paceRateArry = [];
            for (var i = 0; i <= PatRateData.length - 1 ; i++) {
                var value = PatRateData[i].VALUE;
                if (("" + value).toString().trim() == "") {
                    patRateArry.push(false);
                    chart.options.data[0].dataPoints.push({ y: null, label: PatRateData[i].TIME });
                }
                else {
                    patRateArry.push(true);
                    chart.options.data[0].dataPoints.push({ y: parseFloat(PatRateData[i].VALUE), label: PatRateData[i].TIME });
                }
            }

            for (var i = 0; i <= PaceRateData.length - 1 ; i++) {
                var value = PaceRateData[i].VALUE;
                if (("" + value).toString().trim() == "") {
                    paceRateArry.push(false);
                    chart.options.data[1].dataPoints.push({ y: null, label: PaceRateData[i].TIME });
                }
                else {
                    paceRateArry.push(true);
                    chart.options.data[1].dataPoints.push({ y: parseFloat(PaceRateData[i].VALUE), label: PaceRateData[i].TIME });
                }
            }
            //chart.options.title.text = ChartHeading;
            if ($.inArray(true, patRateArry) != -1 || $.inArray(true, paceRateArry) != -1)
                chart.render();
            else {
                $("#chartWrapperHeart").css({ "height": "20px" }).html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }
        }

        function CreatePressureChart(NIABPData, IABPData, PAPData, CVPData, IBPData, RRData) {
            <%--var ChartHeading = "Pressure Chart Dated On (" + '<%: Model.Date%>' + ") of Patient " + '<%: Model.PatientName%>' + " having IP No.: " + ("" + '<%: Model.IPNO %>').toString().trim() + " and MR No.: " + ("" + '<%: Model.MrNo %>').toString().trim();--%>
            //var ChartHeading = "Pressure Chart";
            var gDivNm = "";

            var chart = new CanvasJS.Chart("pressureGraph",
                {
                    animationEnabled: true,
                    animationDuration: 1500,
                    zoomEnabled: true,
                    panEnabled: true,
                    dataPointWidth: 5,
                    exportEnabled: false,
                    //title: {
                    //    text: ChartHeading,
                    //    fontWeight: "bolder",
                    //    fontColor: "#008B8B",
                    //    fontfamily: "tahoma",
                    //    horizontalAlign: "left",
                    //    fontSize: 30,
                    //    padding: 25
                    //},

                    axisY: {
                        includeZero: false,
                        interval: 5,
                        includeZero: false,
                        labelFontSize: 12,
                        minimum: 0
                    },
                    axisX: {
                        gridThickness: 1,
                        interval: 1,
                        labelFontSize: 12,
                        labelAngle: -20
                    },
                    legend: {
                        verticalAlign: "bottom",
                        horizontalAlign: "left",
                        fontSize: 12
                    },
                    data: [
                        {
                            type: "rangeColumn", indexLabel: "{y[#index]}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal",

                            dataPoints: [], showInLegend: true, legendText: "NIBP", toolTipContent: "{label}: {y[0]} / {y[1]}"
                        },
                         {
                             type: "rangeColumn", indexLabel: "{y[#index]}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                             indexLabelOrientation: "horizontal",

                             dataPoints: [], showInLegend: true, legendText: "IBP", toolTipContent: "{label}: {y[0]} / {y[1]}"
                         },
                        {
                            type: "rangeColumn", indexLabel: "{y[#index]}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal",

                            dataPoints: [], showInLegend: true, legendText: "IABP", toolTipContent: "{label}: {y[0]} / {y[1]}"
                        },
                        {
                            type: "rangeColumn", indexLabel: "{y[#index]}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal",

                            dataPoints: [], showInLegend: true, legendText: "PAP", toolTipContent: "{label}: {y[0]} / {y[1]}"
                        },
                        {
                            type: "line", indexLabel: "{y}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal", dataPoints: [], showInLegend: true, legendText: "CVP", markerType: "circle"
                        },
                        {
                            type: "line", indexLabel: "{y}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                            indexLabelOrientation: "horizontal", dataPoints: [], showInLegend: true, legendText: "RR", markerType: "triangle"
                        }
                    ]
                });

            var nibpArry = [];
            var ibpArry = [];
            var iabpArry = [];
            var papArry = [];
            var cvpArry = [];
            var rrArry = [];

            for (var i = 0; i <= NIABPData.length - 1 ; i++) {
                var value = NIABPData[i].NIBPSYS;
                if (("" + value).toString().trim() == "") {
                    nibpArry.push(false);
                }
                else {
                    nibpArry.push(true);
                }
                chart.options.data[0].dataPoints.push({ y: [parseFloat(NIABPData[i].NIBPSYS), parseFloat(NIABPData[i].NIBPDIA)], label: NIABPData[i].TIME });
            }

            for (var i = 0; i <= IBPData.length - 1 ; i++) {
                var value = IBPData[i].IBPSYS;
                if (("" + value).toString().trim() == "") {
                    ibpArry.push(false);
                }
                else {
                    ibpArry.push(true);
                }
                chart.options.data[1].dataPoints.push({ y: [parseFloat(IBPData[i].IBPSYS), parseFloat(IBPData[i].IBPDIA)], label: IBPData[i].TIME });
            }

            for (var i = 0; i <= IABPData.length - 1 ; i++) {
                var value = IABPData[i].IABPSYS;
                if (("" + value).toString().trim() == "") {
                    iabpArry.push(false);
                }
                else {
                    iabpArry.push(true);
                }
                chart.options.data[2].dataPoints.push({ y: [parseFloat(IABPData[i].IABPSYS), parseFloat(IABPData[i].IABPDIA)], label: IABPData[i].TIME });
            }

            for (var i = 0; i <= PAPData.length - 1 ; i++) {
                var value = PAPData[i].PAPSYS;
                if (("" + value).toString().trim() == "") {
                    papArry.push(false);
                }
                else {
                    papArry.push(true);
                }
                chart.options.data[3].dataPoints.push({ y: [parseFloat(PAPData[i].PAPSYS), parseFloat(PAPData[i].PAPDIA)], label: PAPData[i].TIME });
            }

            for (var i = 0; i <= CVPData.length - 1 ; i++) {
                var value = CVPData[i].VALUE;
                if (("" + value).toString().trim() == "") {
                    cvpArry.push(false);
                    chart.options.data[4].dataPoints.push({ y: null, label: CVPData[i].TIME });
                }
                else {
                    cvpArry.push(true);
                    chart.options.data[4].dataPoints.push({ y: parseFloat(value), label: CVPData[i].TIME });
                }
            }
            for (var i = 0; i <= RRData.length - 1 ; i++) {
                var value = RRData[i].VALUE;
                if (("" + value).toString().trim() == "") {
                    rrArry.push(false);
                    chart.options.data[5].dataPoints.push({ y: null, label: RRData[i].TIME });
                }
                else {
                    rrArry.push(true);
                    chart.options.data[5].dataPoints.push({ y: parseFloat(value), label: RRData[i].TIME });
                }
            }

            //chart.options.title.text = ChartHeading;
            if ($.inArray(true, nibpArry) != -1 || $.inArray(true, ibpArry) != -1 || $.inArray(true, iabpArry) != -1 || $.inArray(true, papArry) != -1 || $.inArray(true, cvpArry) != -1 || $.inArray(true, rrArry) != -1)
                chart.render();
            else {
                $("#chartWrapperPressure").css({ "height": "20px" }).html("<label style='font-weight: bold;margin-left: 25px;font-size: 14px;'>No Data Found</label>");
            }
        }

        function BindCriticalAssmntListGrid() {

            // 20-11-17
            $grid = $("#tblCriticalList"),
               resizeColumnHeader = function () {
                   var rowHight, resizeSpanHeight,
                       // get the header row which contains
                       headerRow = $(this).closest("div.ui-jqgrid-view")
                           .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

                   // reset column height
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.height = '';
                   });

                   // increase the height of the resizing span
                   resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.cssText = resizeSpanHeight;
                   });

                   // set position of the dive with the column header text to the middle
                   rowHight = headerRow.height();
                   headerRow.find("div.ui-jqgrid-sortable").each(function () {
                       var $div = $(this);
                       $div.css('top', (rowHight - $div.outerHeight()) / 2 + 'px');
                   });
               },
               fixPositionsOfFrozenDivs = function () {
                   var $rows;
                   if (this.grid.fbDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-btable>tbody>tr', this.grid.bDiv);
                       $('>table.ui-jqgrid-btable>tbody>tr', this.grid.fbDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           if ($(this).hasClass("jqgrow")) {
                               $(this).height(rowHight);
                               rowHightFrozen = $(this).height();
                               if (rowHight !== rowHightFrozen) {
                                   $(this).height(rowHight + (rowHight - rowHightFrozen));
                               }
                           }
                       });
                       $(this.grid.fbDiv).height(this.grid.bDiv.clientHeight);
                       $(this.grid.fbDiv).css($(this.grid.bDiv).position());
                   }
                   if (this.grid.fhDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-htable>thead>tr', this.grid.hDiv);
                       $('>table.ui-jqgrid-htable>thead>tr', this.grid.fhDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           $(this).height(rowHight);
                           rowHightFrozen = $(this).height();
                           if (rowHight !== rowHightFrozen) {
                               $(this).height(rowHight + (rowHight - rowHightFrozen));
                           }
                       });
                       $(this.grid.fhDiv).height(this.grid.hDiv.clientHeight);
                       $(this.grid.fhDiv).css($(this.grid.hDiv).position());
                   }
               },
               fixGboxHeight = function () {
                   var gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight(),
                       pagerHeight = $(this.p.pager).outerHeight();

                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
                   gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight();
                   pagerHeight = $(this.p.pager).outerHeight();
                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
               };

            //end
            jQuery("#tblCriticalList").jqGrid({
                datatype: 'local',
                colNames: ['Time', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM'],
                colModel: [
                    { name: 'DESC', index: 'DESC', width: 170, resizable: false, frozen: true, classes: 'colCellWrap' },
                    { name: '7AM', index: '7AM', width: 59, align: "right", sortable: false },
                    { name: '8AM', index: '8AM', width: 35, sortable: false, align: "right" },
                    { name: '9AM', index: '9AM', width: 35, align: "right", sortable: false },
                    { name: '10AM', index: '10AM', width: 35, align: "right", sortable: false },
                    { name: '11AM', index: '11AM', width: 35, align: "right", sortable: false },
                    { name: '12PM', index: '12PM', width: 35, align: "right", sortable: false },
                    { name: '1PM', index: '1PM', width: 35, align: "right", sortable: false },
                    { name: '2PM', index: '2PM', width: 35, align: "right", sortable: false },
                    { name: '3PM', index: '3PM', width: 35, align: "right", sortable: false },
                    { name: '4PM', index: '4PM', width: 35, align: "right", sortable: false },
                    { name: '5PM', index: '5PM', width: 35, align: "right", sortable: false },
                    { name: '6PM', index: '6PM', width: 35, align: "right", sortable: false },
                    { name: '7PM', index: '7PM', width: 35, align: "right", sortable: false },
                    { name: '8PM', index: '8PM', width: 35, align: "right", sortable: false },
                    { name: '9PM', index: '9PM', width: 35, align: "right", sortable: false },
                    { name: '10PM', index: '10PM', width: 35, align: "right", sortable: false },
                    { name: '11PM', index: '11PM', width: 35, align: "right", sortable: false },
                    { name: '12AM', index: '12AM', width: 35, align: "right", sortable: false },
                    { name: '1AM', index: '1AM', width: 35, align: "right", sortable: false },
                    { name: '2AM', index: '2AM', width: 35, align: "right", sortable: false },
                    { name: '3AM', index: '3AM', width: 35, align: "right", sortable: false },
                    { name: '4AM', index: '4AM', width: 35, align: "right", sortable: false },
                    { name: '5AM', index: '5AM', width: 35, align: "right", sortable: false },
                    { name: '6AM', index: '6AM', width: 35, align: "right", sortable: false }

                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                sortorder: 'asc',
                gridview: true,
                //width: 900,
                //autowidth: true,
                height: 'auto',
                hover: true,
                jsonReader: { cell: "" },
                loadComplete: function (data) {
                    var gridScroll = $('div.ui-jqgrid-bdiv');
                    var header = $('.ui-jqgrid-hdiv');
                    gridScroll[0].scrollLeft = header[0].scrollLeft;

                    //20-11-17
                    fixPositionsOfFrozenDivs.call(this);
                    //end
                },
                rowattr: function (rd) {
                    if (rd["DESC"] == "Hygiene and ADL") {
                        return { "class": "backcolor" };
                    }

                },

            }).trigger('reloadGrid');

            $('.div').removeClass('ui-jqgrid-sdiv');
            var windowWidth = $(window).width();
            var jqgridWidth = Number(windowWidth) - 21;

            if (windowWidth > 1100 && windowWidth <= 1300)// for laptops
            {
                $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "875px");
                $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "875px");
                $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "875px");
            }
            else if (windowWidth > 1300) { // for desktops
                $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "1035px");
                $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "1035px");
                $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "1035px");
            }
            else { // for all mobile devices
                $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", jqgridWidth);
                $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);
            }

            //if ($(window).width() <= 320)
            //{
            //    $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "295px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "295px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "295px");
            //}
            //else if ($(window).width() <= 375 && $(window).width()> 320) { //for galaxies

            //    $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "335px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "335px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "335px");
            //}
            //else if ($(window).width() > 375 && $(window).width() <= 384) { //for 

            //    $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "390px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "390px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "390px");
            //}

            //else if ($(window).width() > 384 && $(window).width() <630) { //for galaxies

            //    $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "500px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "500px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "500px");
            //}
            //else if ($(window).width() >=630 && $(window).width() <768) { //for galaxies landscape

            //    $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "600px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "600px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "600px");
            //}
            //else if ($(window).width() >= 768 && $(window).width() <= 1024) { //for i-pads

            //    $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "700px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "700px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "700px");
            //}
            // else if ($(window).width()  >=1024) {

            //     $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "900px");
            //     $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "900px");
            //     $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "900px");
            // }
            //else {
            //    $("#gbox_tblCriticalList,#gview_tblCriticalList").css("width", "900px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-hdiv').css("width", "900px");
            //    $("#gview_tblCriticalList").children('.ui-jqgrid-bdiv').css("width", "900px");
            //}

            jQuery("#tblCriticalList").jqGrid('setColProp', 'DESC', { frozen: true });
            jQuery("#tblCriticalList").jqGrid('setFrozenColumns');

            $grid.jqGrid('gridResize', {
                minWidth: 450,
                stop: function () {
                    fixPositionsOfFrozenDivs.call(this);
                    fixGboxHeight.call(this);
                }
            });
            $grid.bind("jqGridResizeStop", function () {
                resizeColumnHeader.call(this);
                fixPositionsOfFrozenDivs.call(this);
                fixGboxHeight.call(this);
            });
            resizeColumnHeader.call($grid[0]);
            $grid.jqGrid('setFrozenColumns');
            $grid.triggerHandler("jqGridAfterGridComplete");
            fixPositionsOfFrozenDivs.call($grid[0]);
        }

        function BindCriticalAssmntList2Grid() {
            // 20-11-17
            $grid = $("#tblCriticalList2"),
               resizeColumnHeader = function () {
                   var rowHight, resizeSpanHeight,
                       // get the header row which contains
                       headerRow = $(this).closest("div.ui-jqgrid-view")
                           .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

                   // reset column height
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.height = '';
                   });

                   // increase the height of the resizing span
                   resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.cssText = resizeSpanHeight;
                   });

                   // set position of the dive with the column header text to the middle
                   rowHight = headerRow.height();
                   headerRow.find("div.ui-jqgrid-sortable").each(function () {
                       var $div = $(this);
                       $div.css('top', (rowHight - $div.outerHeight()) / 2 + 'px');
                   });
               },
               fixPositionsOfFrozenDivs = function () {
                   var $rows;
                   if (this.grid.fbDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-btable>tbody>tr', this.grid.bDiv);
                       $('>table.ui-jqgrid-btable>tbody>tr', this.grid.fbDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           if ($(this).hasClass("jqgrow")) {
                               $(this).height(rowHight);
                               rowHightFrozen = $(this).height();
                               if (rowHight !== rowHightFrozen) {
                                   $(this).height(rowHight + (rowHight - rowHightFrozen));
                               }
                           }
                       });
                       $(this.grid.fbDiv).height(this.grid.bDiv.clientHeight);
                       $(this.grid.fbDiv).css($(this.grid.bDiv).position());
                   }
                   if (this.grid.fhDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-htable>thead>tr', this.grid.hDiv);
                       $('>table.ui-jqgrid-htable>thead>tr', this.grid.fhDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           $(this).height(rowHight);
                           rowHightFrozen = $(this).height();
                           if (rowHight !== rowHightFrozen) {
                               $(this).height(rowHight + (rowHight - rowHightFrozen));
                           }
                       });
                       $(this.grid.fhDiv).height(this.grid.hDiv.clientHeight);
                       $(this.grid.fhDiv).css($(this.grid.hDiv).position());
                   }
               },
               fixGboxHeight = function () {
                   var gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight(),
                       pagerHeight = $(this.p.pager).outerHeight();

                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
                   gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight();
                   pagerHeight = $(this.p.pager).outerHeight();
                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
               };

            //end
            jQuery("#tblCriticalList2").jqGrid({
                datatype: 'local',
                colNames: ['Time', 'Infusion Type', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM', 'Total'],
                colModel: [
                    { name: 'DESC', index: 'DESC', width: 150, align: "left", frozen: true, sortable: false, classes: 'colCellWrap' },
                     { name: 'INFUSNTYPE', index: 'INFUSNTYPE', width: 30, align: "left", hidden: true, sortable: false, },
                    { name: '7AM', index: '7AM', width: 35, align: "right", sortable: false },
                    { name: '8AM', index: '8AM', width: 35, sortable: false, align: "right" },
                    { name: '9AM', index: '9AM', width: 35, align: "right", sortable: false },
                    { name: '10AM', index: '10AM', width: 35, align: "right", sortable: false },
                    { name: '11AM', index: '11AM', width: 35, align: "right", sortable: false },
                    { name: '12PM', index: '12PM', width: 35, align: "right", sortable: false },
                    { name: '1PM', index: '1PM', width: 35, align: "right", sortable: false },
                    { name: '2PM', index: '2PM', width: 35, align: "right", sortable: false },
                    { name: '3PM', index: '3PM', width: 35, align: "right", sortable: false },
                    { name: '4PM', index: '4PM', width: 35, align: "right", sortable: false },
                    { name: '5PM', index: '5PM', width: 35, align: "right", sortable: false },
                    { name: '6PM', index: '6PM', width: 35, align: "right", sortable: false },
                    { name: '7PM', index: '7PM', width: 35, align: "right", sortable: false },
                    { name: '8PM', index: '8PM', width: 35, align: "right", sortable: false },
                    { name: '9PM', index: '9PM', width: 35, align: "right", sortable: false },
                    { name: '10PM', index: '10PM', width: 35, align: "right", sortable: false },
                    { name: '11PM', index: '11PM', width: 35, align: "right", sortable: false },
                    { name: '12AM', index: '12AM', width: 35, align: "right", sortable: false },
                    { name: '1AM', index: '1AM', width: 35, align: "right", sortable: false },
                    { name: '2AM', index: '2AM', width: 35, align: "right", sortable: false },
                    { name: '3AM', index: '3AM', width: 35, align: "right", sortable: false },
                    { name: '4AM', index: '4AM', width: 35, align: "right", sortable: false },
                    { name: '5AM', index: '5AM', width: 35, align: "right", sortable: false },
                    { name: '6AM', index: '6AM', width: 35, align: "right", sortable: false },
                    { name: 'TOTAL', index: 'TOTAL', width: 47, align: "right", sortable: false }
                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                sortorder: 'asc',
                gridview: true,
                //width: 1040,
                //height: 'auto',
                hover: true,
                jsonReader: { cell: "" },
                rowattr: function (rd) {
                    if (rd["DESC"] == "Total Input for the hour (1+2+3)") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "Total Input upto the hour (1b+2b+3b)") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "TOTAL OUTPUT FOR THE HOUR (A+B+C+D+E+F):") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "Total Output UPTO the Hour (a+b+c+d+e+f):") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) FOR the Hour:") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) UPTO the Hour:") {
                        return { "class": "one" };
                    }


                    if (rd["INFUSNTYPE"].trim() == "DR") {
                        return { "class": "inputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "DI") {
                        return { "class": "inputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "TP") {
                        return { "class": "inputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "NP") {
                        return { "class": "inputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "TNP") {
                        return { "class": "inputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "OI") {
                        return { "class": "inputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "TPIB" && rd["DESC"].trim() != "Total Input upto the hour (1b+2b+3b)") {
                        return { "class": "inputbackcolor" };
                    }




                    if (rd["INFUSNTYPE"].trim() == "RT" && rd["DESC"].trim() == "Urine Output for the hour (B)") {

                        return { "class": "outputbackcolor two" };
                    }

                    if (rd["INFUSNTYPE"].trim() == "RT") {

                        return { "class": "outputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "CT") {
                        return { "class": "outputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "BC") {
                        return { "class": "outputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "OE") {
                        return { "class": "outputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "MD") {
                        return { "class": "outputbackcolor" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "TT" && rd["DESC"].trim() == "Total (b) URINE output UPTO the Hour:") {

                        return { "class": "outputbackcolor two" };
                    }
                    if (rd["INFUSNTYPE"].trim() == "TT") {
                        return { "class": "outputbackcolor" };
                    }


                },
                loadComplete: function (data) {
                    var gridScroll = $('div.ui-jqgrid-bdiv');
                    var header = $('.ui-jqgrid-hdiv');
                    gridScroll[0].scrollLeft = header[0].scrollLeft;

                    //20-11-17
                    fixPositionsOfFrozenDivs.call(this);
                    //end
                }
            }).trigger('reloadGrid');
            $('.div').removeClass('ui-jqgrid-sdiv');
            var windowWidth = $(window).width();
            var jqgridWidth = Number(windowWidth) - 21;

            if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
            {
                $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblCriticalList2,#gview_tblCriticalList2").css("width", "875px");
                $("#gview_tblCriticalList2").children('.ui-jqgrid-hdiv').css("width", "875px");
                $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("width", "875px");
            }
            else if (windowWidth > 1300) { // for desktops
                $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblCriticalList2,#gview_tblCriticalList2").css("width", "1035px");
                $("#gview_tblCriticalList2").children('.ui-jqgrid-hdiv').css("width", "1035px");
                $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("width", "1035px");
            }
            else { // for all mobile devices
                $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("height", "400px");
                $("#gbox_tblCriticalList2,#gview_tblCriticalList2").css("width", jqgridWidth);
                $("#gview_tblCriticalList2").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);
            }
            //if ($(window).width() < 996) {

            //    $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("height", "400px");
            //    $("#gbox_tblCriticalList2,#gview_tblCriticalList2").css("width", "380px");
            //    $("#gview_tblCriticalList2").children('.ui-jqgrid-hdiv').css("width", "380px");
            //    $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("width", "380px");
            //}
            //else {
            //    $("#gview_tblCriticalList2").children('.ui-jqgrid-bdiv').css("height", "auto");
            //}

            jQuery("#tblCriticalList2").jqGrid('setColProp', 'DESC', { frozen: true });
            jQuery("#tblCriticalList2").jqGrid('setFrozenColumns');

            $grid.jqGrid('gridResize', {
                minWidth: 450,
                stop: function () {
                    fixPositionsOfFrozenDivs.call(this);
                    fixGboxHeight.call(this);
                }
            });
            $grid.bind("jqGridResizeStop", function () {
                resizeColumnHeader.call(this);
                fixPositionsOfFrozenDivs.call(this);
                fixGboxHeight.call(this);
            });
            resizeColumnHeader.call($grid[0]);
            $grid.jqGrid('setFrozenColumns');
            $grid.triggerHandler("jqGridAfterGridComplete");
            fixPositionsOfFrozenDivs.call($grid[0]);
        }


        function BindAssessmentOfLinesGrid() {
            // 20-11-17
            $grid = $("#tblAssessmentOfLine"),
               resizeColumnHeader = function () {
                   var rowHight, resizeSpanHeight,
                       // get the header row which contains
                       headerRow = $(this).closest("div.ui-jqgrid-view")
                           .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

                   // reset column height
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.height = '';
                   });

                   // increase the height of the resizing span
                   resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.cssText = resizeSpanHeight;
                   });

                   // set position of the dive with the column header text to the middle
                   rowHight = headerRow.height();
                   headerRow.find("div.ui-jqgrid-sortable").each(function () {
                       var $div = $(this);
                       $div.css('top', (rowHight - $div.outerHeight()) / 2 + 'px');
                   });
               },
               fixPositionsOfFrozenDivs = function () {
                   var $rows;
                   if (this.grid.fbDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-btable>tbody>tr', this.grid.bDiv);
                       $('>table.ui-jqgrid-btable>tbody>tr', this.grid.fbDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           if ($(this).hasClass("jqgrow")) {
                               $(this).height(rowHight);
                               rowHightFrozen = $(this).height();
                               if (rowHight !== rowHightFrozen) {
                                   $(this).height(rowHight + (rowHight - rowHightFrozen));
                               }
                           }
                       });
                       $(this.grid.fbDiv).height(this.grid.bDiv.clientHeight);
                       $(this.grid.fbDiv).css($(this.grid.bDiv).position());
                   }
                   if (this.grid.fhDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-htable>thead>tr', this.grid.hDiv);
                       $('>table.ui-jqgrid-htable>thead>tr', this.grid.fhDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           $(this).height(rowHight);
                           rowHightFrozen = $(this).height();
                           if (rowHight !== rowHightFrozen) {
                               $(this).height(rowHight + (rowHight - rowHightFrozen));
                           }
                       });
                       $(this.grid.fhDiv).height(this.grid.hDiv.clientHeight);
                       $(this.grid.fhDiv).css($(this.grid.hDiv).position());
                   }
               },
               fixGboxHeight = function () {
                   var gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight(),
                       pagerHeight = $(this.p.pager).outerHeight();

                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
                   gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight();
                   pagerHeight = $(this.p.pager).outerHeight();
                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
               };

            //end

            jQuery("#tblAssessmentOfLine").jqGrid({
                datatype: 'local',
                colNames: ['Lines/Tubes', 'DOI', 'DOR', 'Days', 'Condition', 'Shift'],
                colModel: [

                    { name: 'LINES', index: 'LINES', width: 180, align: "left", frozen: true, sortable: false, resizable: false, classes: 'colCellWrap' },
                    { name: 'DOI', index: 'DOI', width: 80, align: "right", sortable: false },
                    { name: 'DOR', index: 'DOR', width: 80, sortable: false, align: "right" },
                    { name: 'Days', index: 'Days', width: 50, align: "right", sortable: false },
                    { name: 'Condition', index: 'Condition', width: 350, align: "left", sortable: false, resizable: false },
                    { name: 'Shift', index: 'Shift', width: 130, align: "left", sortable: false },
                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                //gridview: true,
                sortorder: "desc",
                sortname: 'Condition',
                //width: 960,
                //height: 'auto',
                jsonReader: { cell: "" },
                rowattr: function (rd) {
                    if (rd["Condition"] == "Discontinued") {
                        return { "class": "CancelClass" };
                    }
                },
                grouping: true,
                groupingView: {
                    groupField: ['Shift'],
                    groupColumnShow: [false, false],
                },
                //grouping: true,
                //groupingView: {
                //    groupField: ["Shift", ],
                //    groupColumnShow: [false],

                //    groupOrder: ["asc"],
                //    groupSummary: [true],
                //    groupSummaryPos: ['header'],
                //    groupCollapse: false
                //},
                loadComplete: function (data) {
                    var gridScroll = $('div.ui-jqgrid-bdiv');
                    var header = $('.ui-jqgrid-hdiv');
                    gridScroll[0].scrollLeft = header[0].scrollLeft;

                    //20-11-17
                    fixPositionsOfFrozenDivs.call(this);
                    //end
                }
            }).trigger('reloadGrid');
            $('.div').removeClass('ui-jqgrid-sdiv');
            var windowWidth = $(window).width();
            var jqgridWidth = Number(windowWidth) - 21;

            if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
            {
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblAssessmentOfLine,#gview_tblAssessmentOfLine").css("width", "740px");
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-hdiv').css("width", "740px");
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("width", "740px");
            }
            else if (windowWidth > 1300) { // for desktops
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblAssessmentOfLine,#gview_tblAssessmentOfLine").css("width", "740px");
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-hdiv').css("width", "740px");
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("width", "740px");
            }
            else { // for all mobile devices
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblAssessmentOfLine,#gview_tblAssessmentOfLine").css("width", jqgridWidth);
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);
            }
            //if ($(window).width() < 996) {
            //    //$("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("height", "412px");
            //    $("#gbox_tblAssessmentOfLine,#gview_tblAssessmentOfLine").css("width", "380px");
            //    $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-hdiv').css("width", "380px");
            //    $("#gview_tblAssessmentOfLine").children('.ui-jqgrid-bdiv').css("width", "380px");
            //}
            jQuery("#tblAssessmentOfLine").jqGrid('setColProp', 'LINES', { frozen: true });
            jQuery("#tblAssessmentOfLine").jqGrid('setFrozenColumns');

            $grid.jqGrid('gridResize', {
                minWidth: 450,
                stop: function () {
                    fixPositionsOfFrozenDivs.call(this);
                    fixGboxHeight.call(this);
                }
            });
            $grid.bind("jqGridResizeStop", function () {
                resizeColumnHeader.call(this);
                fixPositionsOfFrozenDivs.call(this);
                fixGboxHeight.call(this);
            });
            resizeColumnHeader.call($grid[0]);
            $grid.jqGrid('setFrozenColumns');
            $grid.triggerHandler("jqGridAfterGridComplete");
            fixPositionsOfFrozenDivs.call($grid[0]);
        }

        function BindRespiratoryAssessmentGrid() {
            // 20-11-17
            $grid = $("#tblRespiratoryAss"),
               resizeColumnHeader = function () {
                   var rowHight, resizeSpanHeight,
                       // get the header row which contains
                       headerRow = $(this).closest("div.ui-jqgrid-view")
                           .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

                   // reset column height
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.height = '';
                   });

                   // increase the height of the resizing span
                   resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
                   headerRow.find("span.ui-jqgrid-resize").each(function () {
                       this.style.cssText = resizeSpanHeight;
                   });

                   // set position of the dive with the column header text to the middle
                   rowHight = headerRow.height();
                   headerRow.find("div.ui-jqgrid-sortable").each(function () {
                       var $div = $(this);
                       $div.css('top', (rowHight - $div.outerHeight()) / 2 + 'px');
                   });
               },
               fixPositionsOfFrozenDivs = function () {
                   var $rows;
                   if (this.grid.fbDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-btable>tbody>tr', this.grid.bDiv);
                       $('>table.ui-jqgrid-btable>tbody>tr', this.grid.fbDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           if ($(this).hasClass("jqgrow")) {
                               $(this).height(rowHight);
                               rowHightFrozen = $(this).height();
                               if (rowHight !== rowHightFrozen) {
                                   $(this).height(rowHight + (rowHight - rowHightFrozen));
                               }
                           }
                       });
                       $(this.grid.fbDiv).height(this.grid.bDiv.clientHeight);
                       $(this.grid.fbDiv).css($(this.grid.bDiv).position());

                   }
                   if (this.grid.fhDiv !== undefined) {
                       $rows = $('>div>table.ui-jqgrid-htable>thead>tr', this.grid.hDiv);
                       $('>table.ui-jqgrid-htable>thead>tr', this.grid.fhDiv).each(function (i) {
                           var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                           $(this).height(rowHight);
                           rowHightFrozen = $(this).height();
                           if (rowHight !== rowHightFrozen) {
                               $(this).height(rowHight + (rowHight - rowHightFrozen));
                           }
                       });
                       $(this.grid.fhDiv).height(this.grid.hDiv.clientHeight);
                       $(this.grid.fhDiv).css($(this.grid.hDiv).position());
                   }
               },
               fixGboxHeight = function () {
                   var gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight(),
                       pagerHeight = $(this.p.pager).outerHeight();

                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
                   gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight();
                   pagerHeight = $(this.p.pager).outerHeight();
                   $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
               };

            //end



            jQuery("#tblRespiratoryAss").jqGrid({
                datatype: 'local',
                colNames: ['Time', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                   '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM'],
                colModel: [

                    //{ name: 'LINES', index: 'LINES', width: 180, align: "left", frozen: true, sortable: false, resizable: false, classes: 'colCellWrap' },
                    //{ name: 'DOI', index: 'DOI', width: 80, align: "right", sortable: false },
                    //{ name: 'DOR', index: 'DOR', width: 80, sortable: false, align: "right" },
                    //{ name: 'Days', index: 'Days', width: 50, align: "right", sortable: false },
                    //{ name: 'Condition', index: 'Condition', width: 350, align: "left", sortable: false, resizable: false },
                    //{ name: 'Shift', index: 'Shift', width: 130, align: "left", sortable: false },
                      { name: 'DESC', index: 'DESC', width: 200, align: "left", frozen: true, sortable: false },
                     { name: '7 AM', index: '7 AM', width: 35, align: "right", sortable: false },
                    { name: '8 AM', index: '8 AM', width: 35, sortable: false, align: "right" },
                    { name: '9 AM', index: '9 AM', width: 35, align: "right", sortable: false },
                    { name: '10 AM', index: '10 AM', width: 35, align: "right", sortable: false },
                    { name: '11 AM', index: '11 AM', width: 35, align: "right", sortable: false },
                    { name: '12 PM', index: '12 PM', width: 35, align: "right", sortable: false },
                    { name: '1 PM', index: '1 PM', width: 35, align: "right", sortable: false },
                    { name: '2 PM', index: '2 PM', width: 35, align: "right", sortable: false },
                    { name: '3 PM', index: '3 PM', width: 35, align: "right", sortable: false },
                    { name: '4 PM', index: '4 PM', width: 35, align: "right", sortable: false },
                    { name: '5 PM', index: '5 PM', width: 35, align: "right", sortable: false },
                    { name: '6 PM', index: '6 PM', width: 35, align: "right", sortable: false },
                    { name: '7 PM', index: '7 PM', width: 35, align: "right", sortable: false },
                    { name: '8 PM', index: '8 PM', width: 35, align: "right", sortable: false },
                    { name: '9 PM', index: '9 PM', width: 35, align: "right", sortable: false },
                    { name: '10 PM', index: '10 PM', width: 35, align: "right", sortable: false },
                    { name: '11 PM', index: '11 PM', width: 35, align: "right", sortable: false },
                    { name: '12 AM', index: '12 AM', width: 35, align: "right", sortable: false },
                    { name: '1 AM', index: '1 AM', width: 35, align: "right", sortable: false },
                    { name: '2 AM', index: '2 AM', width: 35, align: "right", sortable: false },
                    { name: '3 AM', index: '3 AM', width: 35, align: "right", sortable: false },
                    { name: '4 AM', index: '4 AM', width: 35, align: "right", sortable: false },
                    { name: '5 AM', index: '5 AM', width: 35, align: "right", sortable: false },
                    { name: '6 AM', index: '6 AM', width: 35, align: "right", sortable: false }
                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                sortorder: 'asc',
                gridview: true,
                //width: 960,
                //height: 'auto',
                jsonReader: { cell: "" },
                rowattr: function (rd) {
                    if (rd["DESC"] == "Venti Settings") {
                        return { "class": "backcolor" };
                    }
                    if (rd["DESC"] == "GCS SCALE") {
                        return { "class": "backcolor" };
                    }
                    if (rd["DESC"] == "Total Score(A+B+C)") {
                        return { "class": "backcolor" };
                    }

                },
                //grouping: true,
                //groupingView: {
                //    groupField: ["Shift", ],
                //    groupColumnShow: [false],

                //    groupOrder: ["asc"],
                //    groupSummary: [true],
                //    groupSummaryPos: ['header'],
                //    groupCollapse: false
                //},
                loadComplete: function (data) {
                    var gridScroll = $('div.ui-jqgrid-bdiv');
                    var header = $('.ui-jqgrid-hdiv');
                    gridScroll[0].scrollLeft = header[0].scrollLeft;

                    //20-11-17
                    fixPositionsOfFrozenDivs.call(this);
                    //end
                }
            }).trigger('reloadGrid');
            $("#tblRespiratoryAss").jqGrid('destroyGroupHeader');
            $("#tblRespiratoryAss").jqGrid('setGroupHeaders', {
                useColSpanStyle: true,
                groupHeaders: [
                  { startColumnName: '7 AM', numberOfColumns: 17, titleText: dt1 },
                  { startColumnName: '12 AM', numberOfColumns: 7, titleText: dt2 },

                ]
            });
            $('.div').removeClass('ui-jqgrid-sdiv');

            var windowWidth = $(window).width();
            var jqgridWidth = Number(windowWidth) - 21;

            if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
            {
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblRespiratoryAss,#gview_tblRespiratoryAss").css("width", "1040px");
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-hdiv').css("width", "1040px");
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-bdiv').css("width", "1040px");
            }
            else if (windowWidth > 1300) { // for desktops
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblRespiratoryAss,#gview_tblRespiratoryAss").css("width", "1040px");
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-hdiv').css("width", "1040px");
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-bdiv').css("width", "1040px");
            }
            else { // for all mobile devices
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblRespiratoryAss,#gview_tblRespiratoryAss").css("width", jqgridWidth);
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                $("#gview_tblRespiratoryAss").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);
            }

            //$("#tblRespiratoryAss").jqGrid("inlineNav", "#pager", { addParams: { position: "last" } });


            jQuery("#tblRespiratoryAss").jqGrid('setColProp', 'DESC', { frozen: true });
            jQuery("#tblRespiratoryAss").jqGrid('setFrozenColumns');

            //$("#gview_tblRespiratoryAss").children('.ui-jqgrid-bdiv').children('.tblRespiratoryAssCls').css("margin-top", "0px");
            //$("#gview_tblRespiratoryAss").children('div.frozen-bdiv').children('table.ui-jqgrid-btable')[0].css("margin-top", "0px");

            //$grid.jqGrid('gridResize', {
            //    minWidth: 450,
            //    stop: function () {
            //        fixPositionsOfFrozenDivs.call(this);
            //        fixGboxHeight.call(this);
            //    }
            //});
            //$grid.bind("jqGridResizeStop", function () {
            //    resizeColumnHeader.call(this);
            //    fixPositionsOfFrozenDivs.call(this);
            //    fixGboxHeight.call(this);
            //});
            //resizeColumnHeader.call($grid[0]);
            //$grid.jqGrid('setFrozenColumns');
            //$grid.triggerHandler("jqGridAfterGridComplete");
            //fixPositionsOfFrozenDivs.call($grid[0]);
        }


        function BindSpclObservationGrid() {

            $grid = $("#tblSpclObsrv"),
             resizeColumnHeader = function () {
                 var rowHight, resizeSpanHeight,
                     // get the header row which contains
                     headerRow = $(this).closest("div.ui-jqgrid-view")
                         .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

                 // reset column height
                 headerRow.find("span.ui-jqgrid-resize").each(function () {
                     this.style.height = '';
                 });

                 // increase the height of the resizing span
                 resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
                 headerRow.find("span.ui-jqgrid-resize").each(function () {
                     this.style.cssText = resizeSpanHeight;
                 });

                 // set position of the dive with the column header text to the middle
                 rowHight = headerRow.height();
                 headerRow.find("div.ui-jqgrid-sortable").each(function () {
                     var $div = $(this);
                     $div.css('top', (rowHight - $div.outerHeight()) / 2 + 'px');
                 });
             },
             fixPositionsOfFrozenDivs = function () {
                 var $rows;
                 if (this.grid.fbDiv !== undefined) {
                     $rows = $('>div>table.ui-jqgrid-btable>tbody>tr', this.grid.bDiv);
                     $('>table.ui-jqgrid-btable>tbody>tr', this.grid.fbDiv).each(function (i) {
                         var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                         if ($(this).hasClass("jqgrow")) {
                             $(this).height(rowHight);
                             rowHightFrozen = $(this).height();
                             if (rowHight !== rowHightFrozen) {
                                 $(this).height(rowHight + (rowHight - rowHightFrozen));
                             }
                         }
                     });
                     $(this.grid.fbDiv).height(this.grid.bDiv.clientHeight);
                     $(this.grid.fbDiv).css($(this.grid.bDiv).position());

                 }
                 if (this.grid.fhDiv !== undefined) {
                     $rows = $('>div>table.ui-jqgrid-htable>thead>tr', this.grid.hDiv);
                     $('>table.ui-jqgrid-htable>thead>tr', this.grid.fhDiv).each(function (i) {
                         var rowHight = $($rows[i]).height(), rowHightFrozen = $(this).height();
                         $(this).height(rowHight);
                         rowHightFrozen = $(this).height();
                         if (rowHight !== rowHightFrozen) {
                             $(this).height(rowHight + (rowHight - rowHightFrozen));
                         }
                     });
                     $(this.grid.fhDiv).height(this.grid.hDiv.clientHeight);
                     $(this.grid.fhDiv).css($(this.grid.hDiv).position());
                 }
             },
             fixGboxHeight = function () {
                 var gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight(),
                     pagerHeight = $(this.p.pager).outerHeight();

                 $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
                 gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight();
                 pagerHeight = $(this.p.pager).outerHeight();
                 $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
             };

            jQuery("#tblSpclObsrv").jqGrid({
                datatype: 'local',
                colNames: ['IpNo.', 'Date', 'Time', 'Observation', 'Staff Name', 'INKCOLOR', 'VSTATUS', 'Verified By'],
                colModel: [
                     { name: 'IPNO', index: 'IPNO', width: 50, align: "left", hidden: true, sortable: false },
                     { name: 'OBSERVDT', index: 'OBSERVDT', width: 100, align: "center", hidden: false, },
                     { name: 'OBSERVTM', index: 'OBSERVTM', width: 100, align: "center", frozen: true, hidden: false, },
                     { name: 'OBSERVATION', index: 'OBSERVATION', width: 500, align: "center", hidden: false, },
                     { name: 'USERID', index: 'USERID', width: 100, align: "left", hidden: false, },
                     { name: 'INKCOLOR', index: 'INKCOLOR', width: 100, align: "left", hidden: true, },
                     { name: 'VSTATUS', index: 'VSTATUS', width: 100, align: "left", hidden: true, },
                     { name: 'VERIFIEDBY', index: 'VERIFIEDBY', width: 100, align: "left", hidden: false, },
                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                gridview: true,
                width: 1185,
                height: 'auto',
                sortorder: "desc",
                loadComplete: {

                },

            }).trigger('reloadGrid');


            var windowWidth = $(window).width();
            var jqgridWidth = Number(windowWidth) - 21;

            if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
            {
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblSpclObsrv,#gview_tblSpclObsrv").css("width", "1040px");
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-hdiv').css("width", "1040px");
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-bdiv').css("width", "1040px");
            }
            else if (windowWidth > 1300) { // for desktops
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblSpclObsrv,#gview_tblSpclObsrv").css("width", "1040px");
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-hdiv').css("width", "1040px");
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-bdiv').css("width", "1040px");
            }
            else { // for all mobile devices
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-bdiv').css("height", "auto");
                $("#gbox_tblSpclObsrv,#gview_tblSpclObsrv").css("width", jqgridWidth);
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                $("#gview_tblSpclObsrv").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);
            }

            //$("#tblRespiratoryAss").jqGrid("inlineNav", "#pager", { addParams: { position: "last" } });


            jQuery("#tblSpclObsrv").jqGrid('setColProp', 'OBSERVTM', { frozen: true });
            jQuery("#tblSpclObsrv").jqGrid('setFrozenColumns');

            $grid.jqGrid('gridResize', {
                minWidth: 450,
                stop: function () {
                    fixPositionsOfFrozenDivs.call(this);
                    fixGboxHeight.call(this);
                }
            });
            $grid.bind("jqGridResizeStop", function () {
                resizeColumnHeader.call(this);
                fixPositionsOfFrozenDivs.call(this);
                fixGboxHeight.call(this);
            });
            resizeColumnHeader.call($grid[0]);
            $grid.jqGrid('setFrozenColumns');
            $grid.triggerHandler("jqGridAfterGridComplete");
            fixPositionsOfFrozenDivs.call($grid[0]);
        }



        //function SetReportForCriticalCareGraph() {

        //    var strIPNO = $.session.get('ICUPatIPNO').toString();
        //    var strDate = getParameterByName('strDate');
        //    var strDate1 = "";
        //    var strTime = "";
        //    var rptType = "CRITICAL CARE GRAPH";

        //    $.ajax({
        //        url: '../ICUMob/ICUPrint?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&ReportType=' + rptType + '&&strToDt=' + strDate1,
        //        type: "POST",
        //        dataType: "JSON",
        //        success: function (response) {
        //            //ajaxindicatorstop();
        //            $("#tblDateWiseMaxTemp").empty();

        //            if (response == "No Data Found" || response == "") {
        //                //$.messager.alert("Information", "No Data Found");
        //                var emptyRow = "<tr style='background-color: #3c8dbc;color: white;'><td>No Data Found</td></tr>";
        //                $("#tblDateWiseMaxTemp").append(emptyRow);

        //            }
        //            else {

        //                var thead = "<tr><th>Date</th><th>Max Temperature</th><th>No of Times</th></tr>";
        //                $("#tblDateWiseMaxTemp").append(thead);
        //                $.each(response, function (key, value) {
        //                    var row = "<tr><td>" + value["Date"] + "</td><td>" + value["MaxTemp"] + "</td><td>" + value["NoOfTimes"] + "</td></tr>";
        //                    $("#tblDateWiseMaxTemp").append(row);
        //                });
        //            }
        //        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
        //            sWaitForPrint = "";
        //            MsgDia('An error occurred while processing your request.', "Error Information");
        //        }
        //    });
        //}


    </script>
</asp:Content>
