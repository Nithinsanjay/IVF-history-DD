<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.CriticalCareGraph>" %>

<!DOCTYPE html>

<html>
   
<head runat="server">
<style>
    .ui-jqgrid tr.jqgrow td {
        white-space: normal !important;
    }
    .ui-widget-content {
    border: 1.5px solid black !important;
    color:black !important;
    font-weight:bold !important;
}
    .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
    border-color:black !important;
    border-width:1.5px !important;
    color: #06385d !important;
}
    .ui-jqgrid .ui-jqgrid-view {
    font-weight: bold !important;
    font-size: 12px !important;
}
   .StyleCss{ background-color:#ececaf  !important; }
    .one {
            background-color:#ececaf  !important;
            font-size: 12px;
            color: Black !important;
            font-weight:bold !important;
        }

    /*Added by priyanka on 26/08/2025*/
    /*.rowbgcolor
    {
        background-color:#ececaf  !important;
        font-size: 12px;
        color: black !important;
        font-weight:bold !important;
    }*/
    .one td{
        font-weight:bold !important;
    }
    .two{
            /*background-color:#ececaf !important;*/
            font-size: 12px;
            color: blue !important;
            /*font-weight:bold !important;*/
    }
    .two td{
        font-weight:bold !important;
    }
    .backcolor{
        background-color:#ececaf !important;
        color: blue !important;
    }
     .backcolor td{
        font-weight:bold !important;
    }
       .inputbackcolor{
          /*background-color :#eddffb !important;*/
          background-color :#e8e2ec !important;
     }
     .outputbackcolor{
         background-color :#e1faff !important;
     }
     /*added by priyanka on 09/08/2025*/
     .ui-jqgrid-btable tr.one td {
    background-color: #fff3cd !important;
    font-size: 12px !important;
    font-weight: bold !important;
    /*color: red !important;*/
}
     .ui-jqgrid-btable tr.rowbgcolor td {
    /*background-color: #E1CBE1 !important;*/
    background-color: #f9e3f9 !important; /*changed color by priyanka on 28/08/2025*/
    font-size: 12px !important;
    font-weight: bold !important;
    /*color: red !important;*/
}
         .ui-jqgrid-btable tr.balancerowcol td {
    /*background-color: #BDF5E6 !important;*/
    background-color: #e2f5f0 !important; /*changed color by priyanka on 28/08/2025*/
    font-size: 12px !important;
    font-weight: bold !important;
    /*color: red !important;*/
}

</style>
    <meta name="viewport" content="width=device-width" />
    <title>CriticalCareGraph</title>
    <LINK href="~/Content/braviStyle.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/style.css" rel="stylesheet" type="text/css" />
    <LINK href="~/js/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/Jquery-ui-Custom.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/select2-bootstrap.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/calenderextra.css" rel="stylesheet" type="text/css" />
    <LINK href="~/Content/font-awesome.min.css" rel="stylesheet" />
    <SCRIPT src="<%=ResolveUrl("~/js/jquery-1-10-2.js")%>"></SCRIPT>
    <SCRIPT src="<%=ResolveUrl("~/js/jquery-1-11-1-ui.js")%>"></SCRIPT>
    <SCRIPT src="<%=ResolveUrl("~/js/i18n/grid.locale-en.js")%>"></SCRIPT>
    <SCRIPT src="<%=ResolveUrl("~/js/jquery.jqGrid.js")%>"></SCRIPT>
    <script src="../js/canvasjs.min.js"></script>
    <script>
        var dt1 = "Date1";
        var dt2 = "Date2";

        $(document).ready(function () {
            debugger
            //Temperature Graph();
            DatePlus1DayIncrement();
            var RTable = '<%= ViewData["RECTAL"] %>';
            var RectalTempData;
            if (RTable != '' && RTable != null)
                RectalTempData = JSON.parse(RTable);
            else
                RectalTempData = '';

            var oTable = '<%= ViewData["ORAL"] %>';
            var OralTempData;
            if (oTable != '' && oTable != null)
                OralTempData = JSON.parse(oTable);
            else
                OralTempData = '';

            PTable = '<%= ViewData["PERIPHERAL"] %>';
            var periPheralTempData;
            if (PTable != '' && PTable != null)
                periPheralTempData = JSON.parse(PTable);
            else
                periPheralTempData = '';

            CreateTempChart(periPheralTempData, RectalTempData, OralTempData);

            //Heart Rate

            var PRTable = '<%= ViewData["PATRATE"] %>';
            var patRateDt;
            if (PRTable != '' && PRTable != null)
                patRateDt = JSON.parse(PRTable);
            else
                patRateDt = '';


            PCTable = '<%= ViewData["PACERATE"] %>';
            var paceRatedt;
            if (PCTable != '' && PCTable != null)
                var paceRatedt = JSON.parse(PCTable);
            else
                paceRatedt = '';

            CreateHeartRateChart(patRateDt, paceRatedt);

            //Pressure

            var NTable = '<%= ViewData["NIBP"] %>';
            var NIABPDT = '';
            if (NTable != '' && NTable != null)
                NIABPDT = JSON.parse(NTable);

            ITable = '<%= ViewData["IABP"] %>';
            var IABPDT = '';
            if (ITable != '' && ITable != null)
                IABPDT = JSON.parse(ITable);

            PAPTable = '<%= ViewData["PAP"] %>';
            var PAPDT = '';
            if (PAPTable != '' && PAPTable != null)
                PAPDT = JSON.parse(PAPTable);

            CVPTable = '<%= ViewData["CVP"] %>';
            var CVPDT = '';
            if (CVPTable != '' && CVPTable != null)
                CVPDT = JSON.parse(CVPTable);

            IBPTable = '<%= ViewData["IBP"] %>';
            var IBPDT = '';
            if (IBPTable != '' && IBPTable != null)
                IBPDT = JSON.parse(IBPTable);

            RRTable = '<%= ViewData["RR"] %>';
            var RRDT = '';
            if (RRTable != '' && RRTable != null)
                RRDT = JSON.parse(RRTable);



            CreatePressureChart(NIABPDT, IABPDT, PAPDT, CVPDT, IBPDT, RRDT);

            BindCriticalAssmntListGrid();
            BindCriticalAssmntList2Grid();
            BindRespiratoryGrid();
            BindAssessmentOfLineGrid();
            BindSpclObservationGrid();
            if ('<%= ViewData["OTHERDT"] %>' != null && '<%= ViewData["OTHERDT"] %>' != '') {
                var LISTDATA = '<%:Html.Raw(ViewData["OTHERDT"])%>';
                $('#tblCriticalList').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA)
                }).trigger("reloadGrid");
            }

            //Modified  by priyanka on 09/08/2025
            if ('<%= ViewData["GRIDDATA"] %>' != null && '<%= ViewData["GRIDDATA"] %>' != '') {
                var LISTDATA2 = JSON.parse('<%:Html.Raw(ViewData["GRIDDATA"])%>');

                // 1. Insert blank "Input" row at the first position
                var blankInputRow = {};
                $.each(LISTDATA2[0], function (key) { blankInputRow[key] = ""; });
                blankInputRow["DESC"] = "Input";
                LISTDATA2.unshift(blankInputRow);

                // 2. Insert blank "Output" row before "RT aspiration for the hour (A)"
                //for (var i = 0; i < LISTDATA2.length; i++) {
                //    if ($.trim(LISTDATA2[i]["DESC"]) === "RT aspiration for the hour (A)") {
                //        var blankOutputRow = {};
                //        $.each(LISTDATA2[i], function (key) { blankOutputRow[key] = ""; });
                //        blankOutputRow["DESC"] = "Output";
                //        LISTDATA2.splice(i, 0, blankOutputRow);
                //        break;
                //    }
                //}

                //for (var i = 0; i < LISTDATA2.length; i++) {
                //    if ($.trim(LISTDATA2[i]["DESC"]) === "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) FOR the Hour:") {
                //        var blankOutputRow = {};
                //        $.each(LISTDATA2[i], function (key) { blankOutputRow[key] = ""; });
                //        blankOutputRow["DESC"] = "Balance";
                //        LISTDATA2.splice(i, 0, blankOutputRow);
                //        //break;
                //    }
                //}


                // Added by priyanka on 28/08/2025
                const outputIndex = LISTDATA2.findIndex(item => $.trim(item["DESC"]) === "RT aspiration for the hour (A)");
                if (outputIndex !== -1) {
                    const blankOutputRow = {};
                    $.each(LISTDATA2[outputIndex], function (key) { blankOutputRow[key] = ""; });
                    blankOutputRow["DESC"] = "Output";
                    LISTDATA2.splice(outputIndex, 0, blankOutputRow);
                }
                const balanceIndex = LISTDATA2.findIndex(item => $.trim(item["DESC"]) === "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) FOR the Hour:");
                if (balanceIndex !== -1) {
                    const blankBalanceRow = {};
                    $.each(LISTDATA2[balanceIndex], function (key) { blankBalanceRow[key] = ""; });
                    blankBalanceRow["DESC"] = "Balance";
                    LISTDATA2.splice(balanceIndex, 0, blankBalanceRow);
                }
                //end


                $('#tblCriticalList2').jqGrid('setGridParam', {
                    data: LISTDATA2,
                    //loadComplete: function () {
                    //    var ids = $("#tblCriticalList2").jqGrid('getDataIDs');
                    //    for (var i = 0; i < ids.length; i++) {
                    //        var rowData = $("#tblCriticalList2").jqGrid('getRowData', ids[i]);

                    //        if (rowData.DESC === "Input") {
                    //            $("#tblCriticalList2 tr[id='" + ids[i] + "'] td")
                    //                .attr("style", "background-color:#6DC4DF !important; font-weight:bold; font-size:12px;");
                    //        }
                    //        if (rowData.DESC === "Output") {
                    //            $("#tblCriticalList2 tr[id='" + ids[i] + "'] td")
                    //                .attr("style", "background-color:#fff3cd !important; font-weight:bold; font-size:12px;");
                    //        }
                    //    }
                    //}

                    loadComplete: function () {
                        var ids = $("#tblCriticalList2").jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var rowData = $("#tblCriticalList2").jqGrid('getRowData', ids[i]);
                            var desc = $.trim(rowData.DESC);
                            //Modified by priyanka on 28/08/2025
                            // Input row
                            if (desc === "Input") {
                                $("#tblCriticalList2 tr[id='" + ids[i] + "'] td")
                                    .attr("style", "background-color:#bcecfb !important; font-weight:bold; font-size:12px;");
                            }
                                // Output row
                            else if (desc === "Output") {
                                $("#tblCriticalList2 tr[id='" + ids[i] + "'] td")
                                    .attr("style", "background-color:#bcecfb !important; font-weight:bold; font-size:12px;");
                            }
                            else if (desc === "Balance") { //Balance row
                                $("#tblCriticalList2 tr[id='" + ids[i] + "'] td")
                                    .attr("style", "background-color:#bcecfb !important; font-weight:bold; font-size:12px;");
                            }
                                //End
                                // Apply red/black color to cells with negative/positive values for NET Balance rows
                            else if (
                                desc === "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) FOR the Hour:" ||
                                desc === "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) UPTO the Hour:"
                            ) {
                                var columnsToCheck = ["1AM", "1PM", "2AM", "2PM", "3AM", "3PM", "4AM", "4PM", "5AM", "5PM", "6AM","6PM", "7AM", "7PM", "8AM", "8PM", "9AM", "9PM", "10AM", "10PM", "11AM","11PM", "12AM", "12PM", "TOTAL"];// Replace with your actual column names

                                for (var j = 0; j < columnsToCheck.length; j++) {
                                    var colName = columnsToCheck[j];
                                    var cellValue = rowData[colName];

                                    var num = parseFloat($.trim(cellValue));
                                    if (!isNaN(num)) {
                                        var color = (num < 0) ? "red" : "black";
                                        $("#tblCriticalList2").jqGrid('setCell', ids[i], colName, '', {
                                            color: color,
                                            'font-weight': 'bold'
                                        });
                                    }
                                }
                            }
                        }
                    }
                }).trigger("reloadGrid");


                <%--//var LISTDATA2 = '<%:Html.Raw(ViewData["GRIDDATA"])%>';
                $('#tblCriticalList2').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA2)
                }).trigger("reloadGrid");--%>
            }
            //end

            /*Respiratiory Assessment changes by vishal as on 04/01/2018*/
            if ('<%= ViewData["RESPIRATORY"] %>' != null && '<%= ViewData["RESPIRATORY"] %>' != '') {
                var RESPDATA = '<%:Html.Raw(ViewData["RESPIRATORY"])%>';
                $('#tblRespiratory').jqGrid('setGridParam', {
                    data: JSON.parse(RESPDATA)
                }).trigger("reloadGrid");
            }
            if ('<%= ViewData["ASSMNTOFLINE"] %>' != null && '<%= ViewData["ASSMNTOFLINE"] %>' != '') {
                var ASMNTOFLINEDATA = '<%:Html.Raw(ViewData["ASSMNTOFLINE"])%>';
                $('#tblAssessmentOfLine').jqGrid('setGridParam', {
                    data: JSON.parse(ASMNTOFLINEDATA)
                }).trigger("reloadGrid");
            }
            /*Respiratiory Assessment changes by vishal as on 04/01/2018*/

            /*Special Observation changes by vishal as on 14/081/2018*/
            if ('<%= ViewData["SPECOBSERV"] %>' != null && '<%= ViewData["SPECOBSERV"] %>' != '') {
                var LISTDATA = '<%:Html.Raw(ViewData["SPECOBSERV"])%>';
                $('#tblSpclObsrv').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA)
                }).trigger("reloadGrid");
            } 
        });


        /*Respiratiory Assessment changes by vishal as on 04/01/2018*/
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
        function fnload(IPNO) {
            var IPNo = IPNO;
        }
        ///////////////////////////////

        function fnload(IPNO) {
            var IPNo = IPNO;
        }

        function CreateTempChart(periPheralTempData, RectalTempData, OralTempData, type) {
            var ChartHeading = "Temperature";
            var gDivNm = "";

            var chart = new CanvasJS.Chart("TemperatureGraph",
                {
                    animationEnabled: true,
                    animationDuration: 1500,
                    zoomEnabled: true,
                    panEnabled: true,
                    exportEnabled: false,

                    title: {
                        text: ChartHeading,
                        fontWeight: "bolder",
                        fontColor: "#008B8B",
                        fontfamily: "tahoma",
                        fontSize: 17,
                        padding: 5
                    },
                    axisY: {

                        interval: 1,
                        includeZero: false,
                        labelFontSize: 11,
                        minimum: 80,
                        maximum: 107,
                        valueFormatString: "##.#",
                        stripLines: [
			                            {
			                                startValue: 98.7,
			                                endValue: 98.6,
			                                color: "green",
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
                        labelFontSize: 11,
                        labelAngle: -30
                    },
                    legend: {
                        verticalAlign: "center",
                        horizontalAlign: "right"
                    },

                    data: [

                            { connectNullData: true, type: "line", dataPoints: [], showInLegend: true, legendText: "Oral", lineColor: "red", markerType: "triangle" },
                            { connectNullData: true, type: "line", dataPoints: [], showInLegend: true, legendText: "Peripheral", lineColor: "green", markerType: "cross" },
                            { connectNullData: true, type: "line", dataPoints: [], showInLegend: true, legendText: "Rectal", lineColor: "blue", markerType: "circle" }
                    ]

                });

            for (var i = 0; i <= OralTempData.length - 1 ; i++) {

                var value = OralTempData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[0].dataPoints.push({ y: null, label: OralTempData[i].CREATEDAT });
                else
                    chart.options.data[0].dataPoints.push({ y: parseFloat(value), label: OralTempData[i].CREATEDAT });
            }

            for (var i = 0; i <= periPheralTempData.length - 1 ; i++) {
                var value = periPheralTempData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[1].dataPoints.push({ y: null, label: periPheralTempData[i].CREATEDAT });
                else
                    chart.options.data[1].dataPoints.push({ y: parseFloat(value), label: periPheralTempData[i].CREATEDAT });
            }

            for (var i = 0; i <= RectalTempData.length - 1 ; i++) {
                var value = RectalTempData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[2].dataPoints.push({ y: null, label: RectalTempData[i].CREATEDAT });
                else
                    chart.options.data[2].dataPoints.push({ y: parseFloat(value), label: RectalTempData[i].CREATEDAT });

            }

            chart.options.title.text = ChartHeading;
            chart.render();
        }

        function CreateHeartRateChart(PatRateData, PaceRateData, type) {
            var ChartHeading = "Heart Rate";
            var gDivNm = "";

            var chart = new CanvasJS.Chart("HeartRateGraph",
                {
                    animationEnabled: true,
                    animationDuration: 1500,
                    zoomEnabled: true,
                    panEnabled: true,
                    exportEnabled: false,
                    title: {
                        text: ChartHeading,
                        fontWeight: "bolder",
                        fontColor: "#008B8B",
                        fontfamily: "tahoma",
                        fontSize: 17,
                        padding: 5
                    },
                    legend: {
                        verticalAlign: "center",
                        horizontalAlign: "right"
                    },
                    axisY: {
                        interval: 10,
                        includeZero: false,
                        labelFontSize: 11,
                        minimum: 20
                        //maximum: 200
                    },
                    axisX: {
                        gridThickness: 1,
                        interval: 1,
                        labelFontSize: 11,
                        labelAngle: -30,
                    },
                    data: [
                        { type: "line", dataPoints: [], markerType: "circle", showInLegend: true, legendText: "Patient Rate", legendMarkerType: "circle", lineColor: "red" },
                        { type: "line", dataPoints: [], markerType: "cross", showInLegend: true, legendText: "Paced Rate ", legendMarkerType: "cross", lineColor: "green" },
                    ]
                });

            for (var i = 0; i <= PatRateData.length - 1 ; i++) {
                var value = PatRateData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[0].dataPoints.push({ y: null, label: PatRateData[i].CREATEDAT });
                else
                    chart.options.data[0].dataPoints.push({ y: parseFloat(PatRateData[i].VALUE), label: PatRateData[i].CREATEDAT });
            }

            for (var i = 0; i <= PaceRateData.length - 1 ; i++) {
                var value = PaceRateData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[1].dataPoints.push({ y: null, label: PaceRateData[i].CREATEDAT });
                else
                    chart.options.data[1].dataPoints.push({ y: parseFloat(PaceRateData[i].VALUE), label: PaceRateData[i].CREATEDAT });
            }
            chart.options.title.text = ChartHeading;
            chart.render();
        }

        function CreatePressureChart(NIABPData, IABPData, PAPData, CVPData, IBPData, RRData) {
<%--            var ChartHeading = "Pressure Chart Dated On (" + '<%: Model.Date%>' + ") of Patient " + '<%: Model.PatientName%>' + " having IP No.: " + ("" + '<%: Model.IPNO %>').toString().trim() + " and MR No.: " + ("" + '<%: Model.MrNo %>').toString().trim();--%>
            var ChartHeading =
      "Pressure Chart\n" +
      "Dated on : <%= Model.Date %>      " +
    "Patient Name : <%= Model.PatientName %>      " +
    "IP No.: <%= Model.IPNO %>      " +
    "MR No.: <%= Model.MrNo %>";


            var chart = new CanvasJS.Chart("pressureGraph",
                {
                    animationEnabled: true,
                    animationDuration: 1500,
                    zoomEnabled: true,
                    panEnabled: true,
                    dataPointWidth: 5,
                    exportEnabled: false,
                    title: {
                        text: ChartHeading,
                        fontWeight: "bolder",
                        fontColor: "black",   //"#008B8B", 
                        fontfamily: "tahoma",
                        fontSize: 20,
                        padding: 5
                    },

                    axisY: {
                        includeZero: false,
                        interval: 5,
                        includeZero: false,
                        labelFontSize: 11,
                        minimum: 0
                    },
                    axisX: {
                        gridThickness: 1,
                        interval: 1,
                        labelFontSize: 11,
                        labelAngle: -30
                    },
                    legend: {
                        verticalAlign: "center",
                        horizontalAlign: "right",
                        fontSize: 12
                    },
                    data: [
                        { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "NIBP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                         { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "IBP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                        { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "IABP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                        { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "PAP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                        { type: "line", dataPoints: [], showInLegend: true, legendText: "CVP", markerType: "circle" },
                        { type: "line", dataPoints: [], showInLegend: true, legendText: "RR", markerType: "triangle" }
                    ]
                });

            for (var i = 0; i <= NIABPData.length - 1 ; i++) {
                chart.options.data[0].dataPoints.push({ y: [parseFloat(NIABPData[i].NIBPSYS), parseFloat(NIABPData[i].NIBPDIA)], label: NIABPData[i].CREATEDAT });
            }

            for (var i = 0; i <= IBPData.length - 1 ; i++) {
                chart.options.data[1].dataPoints.push({ y: [parseFloat(IBPData[i].IBPSYS), parseFloat(IBPData[i].IBPDIA)], label: IBPData[i].CREATEDAT });
            }

            for (var i = 0; i <= IABPData.length - 1 ; i++) {
                chart.options.data[2].dataPoints.push({ y: [parseFloat(IABPData[i].IABPSYS), parseFloat(IABPData[i].IABPDIA)], label: IABPData[i].CREATEDAT });
            }

            for (var i = 0; i <= PAPData.length - 1 ; i++) {
                chart.options.data[3].dataPoints.push({ y: [parseFloat(PAPData[i].PAPSYS), parseFloat(PAPData[i].PAPDIA)], label: PAPData[i].CREATEDAT });
            }

            for (var i = 0; i <= CVPData.length - 1 ; i++) {
                var value = CVPData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[4].dataPoints.push({ y: null, label: CVPData[i].CREATEDAT });
                else
                    chart.options.data[4].dataPoints.push({ y: parseFloat(value), label: CVPData[i].CREATEDAT });
            }
            for (var i = 0; i <= RRData.length - 1 ; i++) {
                var value = RRData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[5].dataPoints.push({ y: null, label: RRData[i].CREATEDAT });
                else
                    chart.options.data[5].dataPoints.push({ y: parseFloat(value), label: RRData[i].CREATEDAT });
            }

            chart.options.title.text = ChartHeading;
            chart.render();
        }

        function BindCriticalAssmntListGrid() {
            jQuery("#tblCriticalList").jqGrid({
                datatype: 'local',
                colNames: ['Time', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM', '7AM'],
                colModel: [
                    { name: 'DESC', index: 'DESC', width: 200, align: "left", frozen: true, sortable: false },
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
                    { name: '7AM', index: '7AM', width: 35, align: "right", sortable: false }
                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                sortorder: 'asc',
                gridview: true,
                width: 1185,
                height: 720,
                jsonReader: { cell: "" },
                rowattr: function (rd) {
                    if (rd["DESC"] == "Hygiene and ADL") {
                        return { "class": "backcolor" };
                    }

                },
                loadComplete: {

                }

            }).trigger('reloadGrid');
            $("#tblCriticalList").jqGrid('destroyGroupHeader');
            $("#tblCriticalList").jqGrid('setGroupHeaders', {
                useColSpanStyle: true,
                groupHeaders: [
                  { startColumnName: '8 AM', numberOfColumns: 16, titleText: dt1 },
                  { startColumnName: '12 AM', numberOfColumns: 8, titleText: dt2 },

                ]
            });
            $('.div').removeClass('ui-jqgrid-sdiv');
        }

        function BindCriticalAssmntList2Grid() {
            jQuery("#tblCriticalList2").jqGrid({
                datatype: 'local',
                colNames: ['Time', 'Infusion Type', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM', 'Total'],
                colModel: [
                    { name: 'DESC', index: 'DESC', width: 200, align: "left", sortable: false, },
                    { name: 'INFUSNTYPE', index: 'INFUSNTYPE', width: 34, align: "left", hidden: true, sortable: false, },
                    { name: '7AM', index: '7AM', width: 34, align: "right", sortable: false },
                    { name: '8AM', index: '8AM', width: 34, sortable: false, align: "right" },
                    { name: '9AM', index: '9AM', width:34, align: "right", sortable: false },
                    { name: '10AM', index: '10AM', width: 34, align: "right", sortable: false },
                    { name: '11AM', index: '11AM', width: 34, align: "right", sortable: false },
                    { name: '12PM', index: '12PM', width: 34, align: "right", sortable: false },
                    { name: '1PM', index: '1PM', width: 34, align: "right", sortable: false },
                    { name: '2PM', index: '2PM', width: 34, align: "right", sortable: false },
                    { name: '3PM', index: '3PM', width: 34, align: "right", sortable: false },
                    { name: '4PM', index: '4PM', width: 34, align: "right", sortable: false },
                    { name: '5PM', index: '5PM', width: 34, align: "right", sortable: false },
                    { name: '6PM', index: '6PM', width: 34, align: "right", sortable: false },
                    { name: '7PM', index: '7PM', width: 34, align: "right", sortable: false },
                    { name: '8PM', index: '8PM', width: 34, align: "right", sortable: false },
                    { name: '9PM', index: '9PM', width: 34, align: "right", sortable: false },
                    { name: '10PM', index: '10PM', width: 34, align: "right", sortable: false },
                    { name: '11PM', index: '11PM', width: 34, align: "right", sortable: false },
                    { name: '12AM', index: '12AM', width: 34, align: "right", sortable: false },
                    { name: '1AM', index: '1AM', width: 34, align: "right", sortable: false },
                    { name: '2AM', index: '2AM', width: 34, align: "right", sortable: false },
                    { name: '3AM', index: '3AM', width: 34, align: "right", sortable: false },
                    { name: '4AM', index: '4AM', width: 34, align: "right", sortable: false },
                    { name: '5AM', index: '5AM', width: 34, align: "right", sortable: false },
                    { name: '6AM', index: '6AM', width: 34, align: "right", sortable: false },
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
                width: 'auto',
                height: 600,
                jsonReader: { cell: "" },
                rowattr: function (rd) {
                    if (rd["DESC"] == "Total Input for the hour (1+2+3)") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "Total Input upto the hour (1b+2b+3b)") {
                        return { "class": "one" };
                    }
                    //if (rd["DESC"] == "TOTAL OUTPUT FOR THE HOUR (A+B+C+D+E+F+G):") {//modified by priyanka on 09/08/2025
                    if (rd["DESC"] == "TOTAL OUTPUT FOR THE HOUR (A+B+C+D+E+F):") {//modified by priyanka on 02/09/2025
                        return { "class": "one" };
                    }
                    //if (rd["DESC"] == "Total Output UPTO the Hour (a+b+c+d+e+f+g):") {//modified by priyanka on 09/08/2025
                    if (rd["DESC"] == "Total Output UPTO the Hour (a+b+c+d+e+f):") {//modified by priyanka on 02/09/2025
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) FOR the Hour:") {
                        return { "class": "balancerowcol" };
                    }
                    if (rd["DESC"] == "NET Balance (TOTAL INTAKE-TOTAL OUTPUT) UPTO the Hour:") {
                        return { "class": "balancerowcol" };
                    }
                    //added by priyanka on 26/08/2025
                    if (rd["DESC"] == "Total (1)-Parental INPUT for the hour") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "Total (2)-Non-Parental INPUT for the hour") {
                        return { "class": "one" };
                    }
                    if (rd["DESC"] == "Total Drug Infusion for the hour(A):") {
                        return { "class": "rowbgcolor" };
                    }
                    if (rd["DESC"] == "Total Infusions for the hour(B):") {
                        return { "class": "rowbgcolor" };
                    }
                    if (rd["DESC"] == "Total Oral Intake for the hour(C):") {
                        return { "class": "rowbgcolor" };
                    }
                    if (rd["DESC"] == "Total Feeding Intake for the hour(D):") {
                        return { "class": "rowbgcolor" };
                    }
                    if (rd["DESC"] == "Total Blood Intake for the hour(E):") {
                        return { "class": "rowbgcolor" };
                    }
                    //if (rd["DESC"] == "Total Drain Output for the hour (D):") {
                    if (rd["DESC"] == "Total Drain Output for the hour (C):") {//modified by priyanka on 02/09/2025
                        return { "class": "rowbgcolor" };
                    }
                    //if (rd["DESC"] == "Total Other Output for the hour (G):") {
                    if (rd["DESC"] == "Total Other Output for the hour (F):") {//modified by priyanka on 02/09/2025
                        return { "class": "rowbgcolor" };
                    }
                    //if (rd["DESC"] == "Urine Output for the hour (B)") {
                    //    return { "class": "two" };
                    //}
                    //if (rd["DESC"] == "Total (b) URINE output UPTO the Hour:") {
                    //    return { "class": "two" };
                    //}

                    //added by vishal as on 6thJune 2018
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
                    //if (rd["INFUSNTYPE"].trim() == "RT" && rd["DESC"].trim() == "Urine Output for the hour (B)") {

                    //    return { "class": "outputbackcolor two" };
                    //}

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
                    //if (rd["INFUSNTYPE"].trim() == "TT" && rd["DESC"].trim() == "Total (b) URINE output UPTO the Hour:") {

                    //    return { "class": "outputbackcolor two" };
                    //}
                    if (rd["INFUSNTYPE"].trim() == "TT") {
                        return { "class": "outputbackcolor" };
                    }
                   
                },
            }).trigger('reloadGrid');
            $("#tblCriticalList2").jqGrid('destroyGroupHeader');
            $("#tblCriticalList2").jqGrid('setGroupHeaders', {
                useColSpanStyle: true,
                groupHeaders: [
                  { startColumnName: '8 AM', numberOfColumns: 16, titleText: dt1 },
                  { startColumnName: '12 AM', numberOfColumns: 8, titleText: dt2 },

                ]
            });
            $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
            $('.div').removeClass('ui-jqgrid-sdiv');
        }

        function BindRespiratoryGrid() {
            jQuery("#tblRespiratory").jqGrid({
                datatype: 'local',
                colNames: ['Time', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM', '7AM'],
                colModel: [
                    { name: 'DESC', index: 'DESC', width: 200, align: "left", frozen: true, sortable: false },

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
                    { name: '6 AM', index: '6 AM', width: 35, align: "right", sortable: false },
                    { name: '7 AM', index: '7 AM', width: 35, align: "right", sortable: false }

                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                sortorder: 'asc',
                gridview: true,
                width: 1185,
                height: 'auto',
                jsonReader: { cell: "" },

                loadComplete: {

                },
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
            }).trigger('reloadGrid');
            $("#tblRespiratory").jqGrid('destroyGroupHeader');
            $("#tblRespiratory").jqGrid('setGroupHeaders', {
                useColSpanStyle: true,
                groupHeaders: [
                  { startColumnName: '8 AM', numberOfColumns: 16, titleText: dt1 },
                  { startColumnName: '12 AM', numberOfColumns: 8, titleText: dt2 },

                ]
            });
            $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
            $('.div').removeClass('ui-jqgrid-sdiv');
        }
        function BindAssessmentOfLineGrid() {
            jQuery("#tblAssessmentOfLine").jqGrid({
                datatype: 'local',
                colNames: ['Line/Tubes', 'DOI', 'DOR', 'Days', 'Condition', 'Shift'],
                colModel: [
                     { name: 'AssmntOfLine', index: 'AssmntOfLine', width: 550, align: "left", hidden: false, sortable: false },
                    // { name: 'SIDE', index: 'SIDE', width: 30, align: "left", hidden: false, },
                     { name: 'DOI', index: 'DOI', width: 100, align: "center", hidden: false, },
                     { name: 'DOR', index: 'DOR', width: 100, align: "center", hidden: false, },
                     { name: 'DAYNO', index: 'DAYNO', width: 50, align: "center", hidden: false, },
                     { name: 'COND', index: 'COND', width: 150, align: "left", hidden: false, },
                     //{ name: 'IPNO', index: 'IPNO', width: 30, align: "left", hidden: true, },
                     { name: 'SHIFTTM', index: 'SHIFTTM', width: 100, align: "left", hidden: false, },
                     //{ name: 'TUBECD', index: 'TUBECD', width: 30, align: "left", hidden: true, },
                     //{ name: 'TUBETYPE', index: 'TUBETYPE', width: 30, align: "left", hidden: true, },

                     //{ name: 'OTHERTXT', index: 'OTHERTXT', width: 30, align: "left", hidden: true, },





                     //{ name: 'SHIFTDT', index: 'SHIFTDT', width: 30, align: "left", hidden: true, },

                     //{ name: 'OTHERLINES', index: 'OTHERLINES', width: 30, align: "left", hidden: true, },


                     //{ name: 'CREATEDBY', index: 'CREATEDBY', width: 30, align: "left", hidden: true, },
                     //{ name: 'CREATEDAT', index: 'CREATEDAT', width: 30, align: "left", hidden: true, },
                     //{ name: 'CREATEDON', index: 'CREATEDON', width: 30, align: "left", hidden: true, },
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
                sortname: 'COND',
                jsonReader: { cell: "" },
                grouping: true,
                groupingView: {
                    groupField: ['SHIFTTM'],
                    groupColumnShow: [false, false],
                },
                loadComplete: function () {
                    //added by vijeta on 19thjan19
                    var row_ids = jQuery("#tblAssessmentOfLine").getDataIDs();
                    jQuery.each(row_ids, function (i, row_id) {

                        var r = jQuery("#tblAssessmentOfLine").getRowData(row_id);

                        if (r["COND"] == "Discontinued") {
                            r["COND"] = "Lines Removed";
                            jQuery("#tblAssessmentOfLine").jqGrid('setRowData', row_id, r);

                        }
                    });
                },
                rowattr: function (rd) {
                    if (rd["COND"] == "Discontinued") {
                        return { "class": "CancelClass" };
                    }
                },
            }).trigger('reloadGrid');
            $('.div').removeClass('ui-jqgrid-sdiv');
        }

        /*Special Observation changes by vishal as on 14/081/2018*/
        function BindSpclObservationGrid() {
            jQuery("#tblSpclObsrv").jqGrid({
                datatype: 'local',
                colNames: ['IpNo.', 'Date', 'Time', 'Observation', 'Staff Name', 'INKCOLOR', 'VSTATUS', 'Verified By'],
                colModel: [
                     { name: 'IPNO', index: 'IPNO', width: 50, align: "left", hidden: true, sortable: false },
                     { name: 'OBSERVDT', index: 'OBSERVDT', width: 100, align: "center", hidden: false, },
                     { name: 'OBSERVTM', index: 'OBSERVTM', width: 100, align: "center", hidden: false, },
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
        }
        ///////////////////

        </script>
</head>
<body style ="background-color:white">
    
   <div style ="    width: 100%;    margin: auto;      position: fixed;    z-index: 1000;    background: inherit;">	
        <table style ="width:100%;margin-top:22px;">	
            <tr>	
                <td> <image src="../Images/nabh_accredited.jpg" style="height:50px; margin-left: 30px;" /><br /> 
                 <%--   <LABEL style="color: black;font-weight:bold">FORM/IP/CCFS-37/00</LABEL>--%>
                </td>
                <td style="text-align:center;">
                <image src="../Images/logo.jpg" style="height:50px;" />  <br />
                <LABEL style="color: black;font-weight:bold">Nursing Care Flow Sheet</LABEL>

                </td>
                <td>
                    <table style ="float:right;margin-left:5px;border:1px solid darkgrey;" cellPadding = "0px" cellspacing =" 0px;">
                        <tr>
                            <td class="header"><label style="width: 100px;margin-left: 10px;color:blue;">Name</label></td>
                            <td style="color:blue;">:</td>
                            <td><label style=""><%=Html.DisplayFor(x => Model.PatientName, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                            <td class="header"><label style="width: 100px;margin-left: 30px;color:blue;">MR No.</label></td>
                                 <td style="color:blue;">:</td>
                            <td><label><%=Html.DisplayFor(x => Model.MrNo, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                        </tr>
                        <tr>
                            <td class="header"><label style="width: 100px;margin-left: 10px;color:blue;">Consultant</label></td>
                            <td style="color:blue;">:</td>
                            <td>
                            <label>Dr. &nbsp;<%=Html.DisplayFor(x => Model.Consulatation, new { id="txtConsDr",@class = "TextBxFormat",@style="margin-left: 24px;"})%></label></td>
                            <td class="header"><label style="width: 100px;margin-left: 30px;color:blue;">IP No.</label></td>
                            <td style="color:blue;">:</td>
                            <td><label><%=Html.DisplayFor(x => Model.IPNO, new { id="txtIPNo",@class = "TextBxFormat",@style="margin-left:48px"})%></label></td>
                       </tr>  
                       <tr>
                            <td class="header"><label style="width: 100px;margin-left: 10px;color:blue;">Age/Gender</label></td>
                            <td style="color:blue;">:</td>
                            <td><label><%=Html.DisplayFor(x => Model.AgeGender, new { id="txtAge",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            <td class="header"><label style="width: 100px;margin-left: 30px;color:blue;">Admn. Dt/Tm</label></td>
                            <td style="color:blue;">:</td>
                            <td><label><%=Html.DisplayFor(x => Model.AdmnDateTime, new { id="txtAdmnDTTM",@class = "TextBxFormat",@style="margin-left: 10px"})%></label></td>
                         </tr>   
                         <tr>
                            <td class="header"><label style="width: 100px;margin-left: 10px;color:blue;">Date</label></td>
                              <td style="color:blue;">:</td>
                            <td><label><%=Html.DisplayFor(x => Model.Date, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                              <td class="header"><label style="width: 100px;margin-left: 30px;color:blue;">Ward/Bed No.</label></td>
                              <td style="color:blue;">:</td>
                            <td><label><%=Html.DisplayFor(x => Model.WardBedNo, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                       </tr>  
                    </table>

               </td>
        </tr>

       </table>
        <div>
            <table style="width:100%;border-bottom:none !important;" border ="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td><label>Post OP Days :</label></td><td><label style="color:red; "><%:Model.PostOPDays %></label></td>
                    <td><label>ICU Days :</label></td><td><label style="color:red; "><%:Model.ICUDays %></label></td>
                    <td><label>Diagnosis :</label></td><td><label style="color:red;"><%:Model.Diagnosis %></label></td>
                    <td><label>Operation :</label></td><td><label style="color:red; "><%:Model.SurgeryNm %></label></td>
                    <td><label>Weight(kg) :</label></td><td><label style="color:red; "><%:Model.Weight %></label></td>
                    <td><label>Height(cm) :</label></td><td><label style="color:red; "><%:Model.Height %></label></td>
                    <td><label>BMI (kg/m<sup>2</sup>) :</label></td><td><label style="color:red; "><%:Model.BMI %></label></td>
                     <%--   <td><label>EF :</label></td><td><label style="color:red; "><%:Model.EF %></label></td>--%>
                    <td><label>TempMax :</label></td><td><label style="color:red; "><%= Model.TempMax %></label></td>
                </tr>
            </table>
        </div>

        <div>
            <table style="width:100%;" border ="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="background-color:#f5f8a3"><label style="font-weight:bold;">INTAKE :</label></td><td><label>Non-Parental Input :</label></td><td><label style="color:red;font-weight:bold"><%:Model.NonParentamIP %></label></td><td><label>Parental Input :</label></td>
                    <td><label style="color:red;font-weight:bold"><%: Model.ParentalIP%></label></td>
                    <td><label>OT Input :</label></td><td><label style="color:red;font-weight:bold"><%:Model.OTIP %></label></td>
                    <td><label  style="font-weight:bold">Total :</label></td><td><label style="color:red;font-weight:bold"><%:Model.TotalIP %></label></td><td style="background-color:#f5f8a3"><label  style="font-weight:bold">OUTPUT :</label></td>
                    <td><label>UF :</label></td><td><label style="color:red;font-weight:bold"><%:Model.UFOP %></label></td>
                    <td><label>Urine :</label></td><td><label style="color:red;font-weight:bold"><%: Model.UrineOP %></label></td>
                    <td><label>Drain :</label></td><td><label style="color:red;font-weight:bold"><%:Model.DrainOP %></label></td><td><label>RT :</label></td><td><label style="color:red;font-weight:bold"><%:Model.RTOP %></label></td>
                   <td><label>Blood Collection :</label></td><td><label style="color:red;font-weight:bold"><%:Model.BloodOP %></label></td>
                    <td><label>OT :</label></td><td><label style="color:red;font-weight:bold"><%:Model.OTOP %></label></td>
                     <td><label style="font-weight:bold">Total : </label></td><td><label style="color:red;font-weight:bold"><%: Model.TotalOP %></label></td><td style="background-color:#f5f8a3"><label style="font-weight:bold;">Balance :</label></td><td><label style="color:red;font-weight:bold"><%: Model.Balance %></label></td>
                    <td style="background-color:#f5f8a3"><label style="font-weight:bold;">Cumulative Balance :</label></td><td><label style="color:red;font-weight:bold"><%: Model.CumulativeBal %></label></td>
                </tr>
            </table>
        </div>
    </div>
    
   <div style="width:100%;margin:auto;padding-top: 145px;">	
     <div id="TemperatureGraph" style="height: 410px;width:100%;"> </div>
     <div id="HeartRateGraph" style="height: 322px;width:100%;"> </div>
      <div style="text-align:center;"><label>Page 1/5</label></div>

     <div id="pressureGraph" style="height: 780px; width: 100%;margin-top:22px;"></div> 
      <div style="text-align:center;"><label>Page 2/5</label></div>
 </div>

     <div style="margin-top: 22px;text-align:center">
        <p> <label  style="font-weight:bold;font-size:16px !important;"> Critical Care Assessment </label><br />
            <label style="font-weight:bold;font-size:16px !important;">Dated on : <%: Model.Date%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Patient Name : <%: Model.PatientName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            IP No.: <%: Model.IPNO %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MR No.: <%: Model.MrNo %></label> </p>
         <table id="tblCriticalList"></table></div>
    <div style="text-align:center;"><label>Page 3/5</label></div>
     <div style="margin-top: 22px;text-align:center">
        <p ><label  style="font-weight:bold;font-size:16px !important;"> Intake And Output </label><br />
            <label  style="font-weight:bold;font-size:16px !important;"> Dated On : <%: Model.Date%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Patient Name : <%: Model.PatientName%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                IP No.: <%: Model.IPNO %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MR No.: <%: Model.MrNo %></label></p>
         <table id="tblCriticalList2"></table></div>
   <%-- <div style="text-align:center;"><label>Page 4/6</label></div>--%>
    <div style="text-align:center;"><label>Page 4/5</label></div>
     <div style="margin-top: 22px;text-align:center">
        <p ><label  style="font-weight:bold;font-size:16px !important;"> Respiratory & Neurology Assessment </label><br />
            <label  style="font-weight:bold;font-size:16px !important;">Patient Name : <%: Model.PatientName%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                IP No.: <%: Model.IPNO %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MR No.: <%: Model.MrNo %></label></p>             
         <table id="tblRespiratory"></table></div>
    <div style="text-align:center;"><label>Page 5/5</label></div>
     <div style="margin-top: 22px;text-align:center; display:none;">
        <p ><label  style="font-weight:bold;font-size:16px !important;"> Assessment Of Line as on : <%: Model.Date%> </label><br />
            <label  style="font-weight:bold;font-size:16px !important;">Patient Name : <%: Model.PatientName%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                IP No.: <%: Model.IPNO %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MR No.: <%: Model.MrNo %></label></p>             
         <table id="tblAssessmentOfLine"></table></div>

    <div style="margin-top: 22px;text-align:center; display:none;"">
        <p ><label  style="font-weight:bold;font-size:16px !important;"> Special Observation : <%: Model.Date%> </label><br />
            <label  style="font-weight:bold;font-size:16px !important;">Patient Name : <%: Model.PatientName%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                IP No.: <%: Model.IPNO %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MR No.: <%: Model.MrNo %></label></p>             
         <table id="tblSpclObsrv"></table></div>
</body>
</html>
