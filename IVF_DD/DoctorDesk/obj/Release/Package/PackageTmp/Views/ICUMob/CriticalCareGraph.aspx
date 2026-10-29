<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.CriticalCareGraph>" %>

<!DOCTYPE html>

<html>

<head runat="server">
    <style>
        .ui-jqgrid tr.jqgrow td {
            white-space: normal !important;
        }

        .ui-widget-content {
            border: 1.5px solid black !important;
            color: black !important;
            font-weight: bold !important;
        }

            .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
                border-color: black !important;
                border-width: 1.5px !important;
                color: #06385d !important;
            }

        .ui-jqgrid .ui-jqgrid-view {
            font-weight: bold !important;
            font-size: 12px !important;
        }

        .ui-jqgrid .ui-jqgrid-htable {
            width: 1685px;
            zoom: 237%;
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

        .chartWrapper {
            position: relative;
            margin-left: 65px;
        }

            .chartWrapper > canvas {
                position: absolute;
                left: 0;
                top: 0;
                pointer-events: none;
            }

        .chartAreaWrapper {
            width: 1025px;
            overflow-x: scroll;
        }

        .tempGraph {
            height: 1000px;
            width: 4500px;
        }

        .pressGraph {
            height: 1000px;
            width: 2000px;
        }

        .tblCriticalCls {
            width: 1685px;
            zoom: 237%;
        }

        .tblCriticalLst2Cls {
            width: 1222px;
            zoom: 235%;
        }

        .lblHeading {
            font-weight: bolder;
            color: #6b2525;
            font-family: tahoma;
            font-Size: 26px;
            padding: 5px;
        }

        @media only screen and (min-width : 992px) {

            .tempGraph {
                height: 325px;
                width: 100%;
            }

            .pressGraph {
                height: 780px;
                width: 100%;
            }

            .ui-jqgrid .ui-jqgrid-htable {
                width: 1685px;
                zoom: 0%;
            }

            .tblCriticalCls {
                width: 1665px;
                zoom: 0%;
            }

            .tblCriticalLst2Cls {
                width: 1222px;
                zoom: 0%;
            }

            .chartWrapper {
                position: relative;
                margin-left: 0px;
            }

            .chartAreaWrapper {
                width: 100%;
                overflow-x: hidden;
            }
        }
    </style>
    <meta name="viewport" content="width=device-width" />
    <title>CriticalCareGraph</title>
    <link href="~/Content/braviStyle.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/style.css" rel="stylesheet" type="text/css" />
    <link href="~/js/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/Jquery-ui-Custom.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/select2-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/calenderextra.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/font-awesome.min.css" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/js/jquery-1-10-2.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/jquery-1-11-1-ui.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/i18n/grid.locale-en.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.jqGrid.js")%>"></script>
    <script src="../js/canvasjs.min.js"></script>
    <script>
        $(document).ready(function () {
            debugger
            //Temperature Graph();
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

            CreateTempChart(RectalTempData, OralTempData, periPheralTempData);

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

            BindCriticalAssmntListGrid();
            BindCriticalAssmntList2Grid();
            BindAssessmentOfLinesGrid();

            if ('<%= ViewData["OTHERDT"] %>' != null && '<%= ViewData["OTHERDT"] %>' != '') {
                var LISTDATA = '<%:Html.Raw(ViewData["OTHERDT"])%>';
                $('#tblCriticalList').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA)
                }).trigger("reloadGrid");
            }

            if ('<%= ViewData["GRIDDATA"] %>' != null && '<%= ViewData["GRIDDATA"] %>' != '') {
                var LISTDATA2 = '<%:Html.Raw(ViewData["GRIDDATA"])%>';
                $('#tblCriticalList2').jqGrid('setGridParam', {
                    data: JSON.parse(LISTDATA2)
                }).trigger("reloadGrid");
            }

            if ('<%= ViewData["ASSOFLINEDATA"] %>' != null && '<%= ViewData["ASSOFLINEDATA"] %>' != '') {
                var ASSOFLINELIST = '<%:Html.Raw(ViewData["ASSOFLINEDATA"])%>';
                $('#tblAssessmentOfLine').jqGrid('setGridParam', {
                    data: JSON.parse(ASSOFLINELIST)
                }).trigger("reloadGrid");
            }

            //}

        });

        function fnload(IPNO) {
            var IPNo = IPNO;
        }

        function CreateTempChart(periPheralTempData, RectalTempData, OralTempData, type) {
            var ChartHeading = "Temperature";
            var gDivNm = "";

            var chart = new CanvasJS.Chart("TemperatureGraph",
                {
                    animationEnabled: false,
                    animationDuration: 1500,
                    zoomEnabled: true,
                    panEnabled: true,
                    exportEnabled: false,
                    title: {
                        text: ChartHeading,
                        fontWeight: "bolder",
                        fontColor: "#008B8B",
                        fontfamily: "tahoma",
                        horizontalAlign: "left",
                        fontSize: 40,
                        padding: 15,
                        margin: 10,
                    },
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
                        labelFontSize: 15,
                        labelAngle: -20,
                        labelFontColor: "black",
                    },
                    legend: {
                        verticalAlign: "bottom",
                        horizontalAlign: "left"
                    },

                    data: [
                        { connectNullData: false, type: "line", dataPoints: [], showInLegend: true, legendText: "Oral", lineColor: "red", markerType: "triangle" },
                        { connectNullData: false, type: "line", dataPoints: [], showInLegend: true, legendText: "Peripheral", lineColor: "green", markerType: "cross" },
                        { connectNullData: false, type: "line", dataPoints: [], showInLegend: true, legendText: "Rectal", lineColor: "blue", markerType: "circle" }
                    ]
                });


            for (var i = 0; i <= periPheralTempData.length - 1 ; i++) {
                var value = periPheralTempData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[0].dataPoints.push({ y: null, label: periPheralTempData[i].TIME });
                else
                    chart.options.data[0].dataPoints.push({ y: parseFloat(value), label: periPheralTempData[i].TIME });
            }

            for (var i = 0; i <= OralTempData.length - 1 ; i++) {
                //var a = OralTempData[i].TIME;
                //var b = a.toString().replace("(", "").replace(")", "").split(",");
                //var year = parseInt(b[0]);
                //var month = parseInt(b[1]);
                //var date1 = parseInt(b[2]);
                //var hr = parseInt(b[3]);
                //chart.options.data[2].dataPoints.push({ x: new Date(Date.UTC(year, month, date1, hr)), y: parseInt(OralTempData[i].VALUE) });
                var value = OralTempData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[1].dataPoints.push({ y: null, label: OralTempData[i].TIME });
                else
                    chart.options.data[1].dataPoints.push({ y: parseFloat(value), label: OralTempData[i].TIME });
            }

            for (var i = 0; i <= RectalTempData.length - 1 ; i++) {
                var value = RectalTempData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[2].dataPoints.push({ y: null, label: RectalTempData[i].TIME });
                else
                    chart.options.data[2].dataPoints.push({ label: RectalTempData[i].TIME, y: parseFloat(RectalTempData[i].VALUE) });
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
                        horizontalAlign: "left",
                        fontSize: 30,
                        padding: 25
                    },
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
                        { type: "line", dataPoints: [], markerType: "circle", showInLegend: true, legendText: "Patient Rate", legendMarkerType: "circle", lineColor: "red" },
                        { type: "line", dataPoints: [], markerType: "cross", showInLegend: true, legendText: "Paced Rate ", legendMarkerType: "cross", lineColor: "green" },
                    ]
                });

            for (var i = 0; i <= PatRateData.length - 1 ; i++) {
                var value = PatRateData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[0].dataPoints.push({ y: null, label: PatRateData[i].TIME });
                else
                    chart.options.data[0].dataPoints.push({ y: parseFloat(PatRateData[i].VALUE), label: PatRateData[i].TIME });
            }

            for (var i = 0; i <= PaceRateData.length - 1 ; i++) {
                var value = PaceRateData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[1].dataPoints.push({ y: null, label: PaceRateData[i].TIME });
                else
                    chart.options.data[1].dataPoints.push({ y: parseFloat(PaceRateData[i].VALUE), label: PaceRateData[i].TIME });
            }
            chart.options.title.text = ChartHeading;
            chart.render();
        }

        function CreatePressureChart(NIABPData, IABPData, PAPData, CVPData, IBPData, RRData) {
            <%--var ChartHeading = "Pressure Chart Dated On (" + '<%: Model.Date%>' + ") of Patient " + '<%: Model.PatientName%>' + " having IP No.: " + ("" + '<%: Model.IPNO %>').toString().trim() + " and MR No.: " + ("" + '<%: Model.MrNo %>').toString().trim();--%>
            var ChartHeading = "Pressure Chart";
            var gDivNm = "";

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
                        fontColor: "#008B8B",
                        fontfamily: "tahoma",
                        horizontalAlign: "left",
                        fontSize: 30,
                        padding: 25
                    },

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
                        { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "NIBP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                         { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "IBP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                        { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "IABP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                        { type: "rangeColumn", dataPoints: [], showInLegend: true, legendText: "PAP", toolTipContent: "{label}: {y[0]} / {y[1]}" },
                        { type: "line", dataPoints: [], showInLegend: true, legendText: "CVP", markerType: "circle" },
                        { type: "line", dataPoints: [], showInLegend: true, legendText: "RR", markerType: "triangle" }
                    ]
                });

            for (var i = 0; i <= NIABPData.length - 1 ; i++) {
                chart.options.data[0].dataPoints.push({ y: [parseFloat(NIABPData[i].NIBPSYS), parseFloat(NIABPData[i].NIBPDIA)], label: NIABPData[i].TIME });
            }

            for (var i = 0; i <= IBPData.length - 1 ; i++) {
                chart.options.data[1].dataPoints.push({ y: [parseFloat(IBPData[i].IBPSYS), parseFloat(IBPData[i].IBPDIA)], label: IBPData[i].TIME });
            }

            for (var i = 0; i <= IABPData.length - 1 ; i++) {
                chart.options.data[2].dataPoints.push({ y: [parseFloat(IABPData[i].IABPSYS), parseFloat(IABPData[i].IABPDIA)], label: IABPData[i].TIME });
            }

            for (var i = 0; i <= PAPData.length - 1 ; i++) {
                chart.options.data[3].dataPoints.push({ y: [parseFloat(PAPData[i].PAPSYS), parseFloat(PAPData[i].PAPDIA)], label: PAPData[i].TIME });
            }

            for (var i = 0; i <= CVPData.length - 1 ; i++) {
                var value = CVPData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[4].dataPoints.push({ y: null, label: CVPData[i].TIME });
                else
                    chart.options.data[4].dataPoints.push({ y: parseFloat(value), label: CVPData[i].TIME });
            }
            for (var i = 0; i <= RRData.length - 1 ; i++) {
                var value = RRData[i].VALUE;
                if (("" + value).toString().trim() == "")
                    chart.options.data[5].dataPoints.push({ y: null, label: RRData[i].TIME });
                else
                    chart.options.data[5].dataPoints.push({ y: parseFloat(value), label: RRData[i].TIME });
            }

            chart.options.title.text = ChartHeading;
            chart.render();
        }

        function BindCriticalAssmntListGrid() {
            jQuery("#tblCriticalList").jqGrid({
                datatype: 'local',
                colNames: ['Time', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM'],
                colModel: [
                    { name: 'DESC', index: 'DESC', width: 200, align: "left", frozen: true, sortable: false },
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
                width: 1185,
                height: 720,
                jsonReader: { cell: "" },

                loadComplete: {

                }

            }).trigger('reloadGrid');
            $('.div').removeClass('ui-jqgrid-sdiv');
        }

        function BindCriticalAssmntList2Grid() {
            jQuery("#tblCriticalList2").jqGrid({
                datatype: 'local',
                colNames: ['Time', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM', 'Total'],
                colModel: [
                    { name: 'DESC', index: 'DESC', width: 200, align: "left", frozen: true, sortable: false, },
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
                width: 1238,
                height: 600,
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

                },
            }).trigger('reloadGrid');
            $('.div').removeClass('ui-jqgrid-sdiv');
        }


        function BindAssessmentOfLinesGrid() {
            jQuery("#tblAssessmentOfLine").jqGrid({
                datatype: 'local',
                colNames: ['Shift', 'Lines/Tubes', 'DOI', 'DOR', 'Days', 'Condition'],
                colModel: [
                    { name: 'Shift', index: 'Shift', width: 130, align: "left", sortable: false },
                    { name: 'LINES', index: 'LINES', width: 370, align: "left", frozen: true, sortable: false, },
                    { name: 'DOI', index: 'DOI', width: 130, align: "right", sortable: false },
                    { name: 'DOR', index: 'DOR', width: 130, sortable: false, align: "right" },
                    { name: 'Days', index: 'Days', width: 130, align: "right", sortable: false },
                    { name: 'Condition', index: 'Condition', width: 390, align: "left", sortable: false },
                ],
                shrinkToFit: false,
                forceFit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                ignoreCase: true,
                rowNum: 1000,
                sortorder: 'asc',
                gridview: true,
                width: 1238,
                height: 'auto',
                jsonReader: { cell: "" },
                rowattr: function (rd) {

                },
                grouping: true,
                groupingView: {
                    groupField: ["Shift", ],
                    groupColumnShow: [false],

                    groupOrder: ["asc"],
                    groupSummary: [true],
                    groupSummaryPos: ['header'],
                    groupCollapse: false
                }
            }).trigger('reloadGrid');
            $('.div').removeClass('ui-jqgrid-sdiv');
        }

    </script>
</head>
<body style="background-color: white">

    <%-- <div style="width: 100%; margin: auto; margin-top: 22px">--%>
    <%-- <table style="width: 100%;">
            <tr>--%>
    <%-- <td> <image src="../Images/nabh_accredited.jpg" style="height:50px; margin-left: 30px;" /><br />
                    <LABEL style="color: black;font-weight:bold">FORM/JH/IP/CCFS-37/00</LABEL>
                </td>--%>
    <%--   <td style="text-align: center;">--%>
    <%--    <image src="../Images/logo.jpg" style="height:50px;" />  <br />--%>
    <%--  <label style="color: black; font-weight: bold">CRITICAL CARE FLOW SHEET</label>--%>

    <%--  </td>--%>
    <%-- <td>--%>
    <%--  <table style="float: right; margin-left: 5px; border: 1px solid darkgrey; font-weight: bold" cellpadding="0px" cellspacing=" 0px;">--%>
    <%--  <tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;">Name</label></td>
                            <td>:</td>
                            <td>
                                <label style="font-weight: bold;"><%=Html.DisplayFor(x => Model.PatientName, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                            <td class="header">
                                <label style="width: 100px; margin-left: 30px; font-weight: bold;">MR No.</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.MrNo, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                        </tr>--%>
    <%--<tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;">Consultant</label></td>
                            <td>:</td>
                            <td>
                                <label>Dr. &nbsp;<%=Html.DisplayFor(x => Model.Consulatation, new { id="txtConsDr",@class = "TextBxFormat",@style="margin-left: 24px;"})%></label></td>
                            <td class="header">
                                <label style="width: 100px; margin-left: 30px; font-weight: bold;">IP No.</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.IPNO, new { id="txtIPNo",@class = "TextBxFormat",@style="margin-left:48px"})%></label></td>
                        </tr>--%>
    <%--    <tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;">Age/Gender</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.AgeGender, new { id="txtAge",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            <td class="header">
                                <label style="width: 100px; margin-left: 30px; font-weight: bold;">Admn. Dt/Tm</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.AdmnDateTime, new { id="txtAdmnDTTM",@class = "TextBxFormat",@style="margin-left: 10px"})%></label></td>
                        </tr>--%>
    <%-- <tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;">Date :</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.Date, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            <td class="header">
                                <label style="width: 100px; margin-left: 30px; font-weight: bold;">Ward/Bed No.</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.WardBedNo, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                        </tr>--%>
    <%--  </table>--%>

    <%--   </td>--%>
    <%--   </tr>

        </table>--%>
    <%--    <div>--%>
    <%--<table style="width: 100%; border-bottom: none !important;" border="1" cellspacing="0" cellpadding="0">
                <tr>--%>
    <%--<td>
                        <label>Post OP Days :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.PostOPDays %></label></td>
                    <td>
                        <label>ICU Days :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.ICUDays %></label></td>
                    <td>
                        <label>Diagnosis :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.Diagnosis %></label></td>
                    <td>
                        <label>Operation :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.SurgeryNm %></label></td>
                    <td>
                        <label>Weight :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.Weight %></label></td>
                    <td>
                        <label>Height :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.Height %></label></td>
                    <td>
                        <label>BMI :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.BMI %></label></td>
                    <td>
                        <label>EF :</label></td>
                    <td>
                        <label style="color: red; font-weight: bold"><%:Model.EF %></label></td>--%>
    <%--      </tr>
            </table>--%>
    <%--   </div>--%>

    <div>
        <%--  <table style="width:100%;" border ="1" cellspacing="0" cellpadding="0">
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
            </table>--%>
    </div>
    <%--   </div>--%>

    <div style="width: 100%; margin: auto">
        <%--  <label>Temperature</label>--%>

        <div id="heading">
            <div class="row">


                <label class="lblHeading">Date: '<%: Model.Date%>' </label>
                <label class="lblHeading">Patient Name:'<%: Model.PatientName%>' </label>
                <label class="lblHeading">IP NO: '<%: Model.IPNO %>'</label>
                <label class="lblHeading">MR NO: '<%: Model.MrNo %>'</label>
            </div>

        </div>

  
    <div class="chartWrapper">
        <div class="chartAreaWrapper">
            <div id="TemperatureGraph" class="tempGraph"></div>
        </div>
    </div>

    <div class="chartWrapper">
        <div class="chartAreaWrapper">
            <div id="HeartRateGraph" class="tempGraph"></div>
            <div style="text-align: center;">
                <label>Page 1/4</label>
            </div>
        </div>
    </div>


    <div class="chartWrapper">
        <div class="chartAreaWrapper">
            <div id="pressureGraph" class="pressGraph"></div>
            <div style="text-align: center;">
                <label>Page 2/4</label>
            </div>
        </div>
    </div>

  </div>
    <div style="margin-top: 22px;">
        
        <label style=" font-Weight: bolder;color: #008B8B;font-family: tahoma;font-Size: 30px;padding: 25px">Critical care assessment </label>
        <p></p>
        <table id="tblCriticalList" class="tblCriticalCls"></table>
    </div>
    <div style="text-align: center;">
        <label>Page 3/4</label>
    </div>
    <div style="margin-top: 22px; text-align: left">
       
            <label style=" font-Weight: bolder;color: #008B8B;font-family: tahoma;font-Size: 30px;padding: 25px">Intake And Output </label>
       
            <%--  <label style="font-weight: bold; font-size: 16px !important;">
                Dated On : <%: Model.Date%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Patient Name : <%: Model.PatientName%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                IP No.: <%: Model.IPNO %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MR No.: <%: Model.MrNo %></label>--%>
        <p></p>
        <table id="tblCriticalList2" class="tblCriticalLst2Cls"></table>
    </div>
    <div style="margin-top: 22px; text-align: left">
       <label style=" font-Weight: bolder;color: #008B8B;font-family: tahoma;font-Size: 30px;padding: 25px">Assessment Of Line </label>
        <p></p>
        <table id="tblAssessmentOfLine" class="tblCriticalLst2Cls"></table>
    </div>
    <div style="text-align: center;">
        <label>Page 4/4</label>
    </div>
</body>
</html>
