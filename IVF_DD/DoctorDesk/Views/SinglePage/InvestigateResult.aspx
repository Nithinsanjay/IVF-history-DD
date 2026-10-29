<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.CriticalCareGraph>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Investigation Report</title>
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
    <style>
        /*added by vijeta on 4th August 2018*/
         .square {
            height: 12px;
            width: 12px;
            background-color: #ffc0cbc2;
            float: left;
            margin-top: 3px;
            margin-left: 10px;
        }

        /*.first {
            font-weight: 600;           
            width: 18.85em;
            left: 10px;
            top: auto;
            border-top-width: 1px;
            margin-top: -1px;
            border-bottom: 0px;
            background-color:#d4e9fa;
        }*/

        /*.second {
            font-weight: 600;
           
            width: 11.5em;
            left: 238px;
            top: auto;
            border-top-width: 1px;
            margin-top: -1px;
             border-bottom: 0px;
            background-color:#d4e9fa;
        }*/

         /*.other {
            font-weight: 600;
            position: absolute;
            width: 10.55em!important;
            left: 380px;
            top: auto;
            border-top-width: 1px;
            margin-top: -1px;
             border-bottom: 0px;
            background-color:#d4e9fa;
        }*/

        
        
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

      
        .ui-jqgrid tr.jqgrow td.colCellWrapInvest_Norm{
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
            background-color:#f9f1cb;
        }
        .ui-jqgrid tr.jqgrow td.colCellWrapTest_Name{
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
            background-color:#f9f1cb;
        }

         .ui-jqgrid .ui-jqgrid-htable th.ui-th-column-header{
                background-color:#187eb9;/*kavita*/
                color:#121314;
        }


         .ui-jqgrid .ui-jqgrid-htable th.ui-th-column {
            padding-top: 8px;
            padding-bottom: 8px;
            /*padding-right:3px;*/
            background-color:#187eb9;/*kavita*/
            color:#121314 !important;
            word-wrap: break-word; /* IE 5.5+ and CSS3 */
            white-space: pre-wrap; /* CSS3 */
            white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
            white-space: -pre-wrap; /* Opera 4-6 */
            white-space: -o-pre-wrap; /* Opera 7 */
            height: auto  !important;
            line-height: 15px;
        }
      

         .ui-jqgrid tr.jqgrow td {
            white-space: normal !important;
            height: auto;
            vertical-align: middle;
            padding-top: 6px !important;
            padding-bottom: 6px !important;
            font-size:12px;/*kavita*/
            font-weight:bold;
            color:#4a4949 !important;
        }

        .ui-jqgrid .ui-jqgrid-htable th.ui-th-column {
            padding-top: 2px;
            padding-bottom: 10px;
            /*padding-right:3px;*/
            background-color:#187eb9;/*kavita*/
            color:#121314 !important;
             font-size:12px;/*kavita*/
            
        }


     

        .ui-jqgrid .frozen-bdiv, .ui-jqgrid .frozen-div {
            overflow: hidden;
        }

         table.ui-jqgrid-btable {
            margin-top: 0px !important;
        }
         th.ui-th-column-header {
            text-align: center;
            font-weight: bold !important;
            font-size: 12px;
        }
             
        
          .ui-state-hover td{background-color:#ddf7cf !important;}
           .AltRowClassEven
        {
            background:#e8f7fc;
            color:black;
        }
         .AltRowClassOdd
        {
            background:#cbe0f3;
            /*background: linear-gradient(#fefefb 0%, #30302f 100%);*/
             color:black;
        }
    </style>

    <script>
        var fromdate = '<%= ViewBag.FromDate%>';
        var Todate = '<%= ViewBag.Todate%>';
        $(document).ready(function () {
            //winHeight = $(window).height();
            //otherHeights = $('#mainHeaderHight').height() + 150;

            if ('<%= ViewData["InvestReportData"] %>' != null && '<%= ViewData["InvestReportData"] %>' != '') {

                var InvestigateResult = '<%:Html.Raw(ViewData["InvestReportData"])%>';

                const rawJsonString = InvestigateResult;          // Changes by Dhananjay 20240909
                const sanitizedJsonString = sanitizeJsonString(rawJsonString);
                var data;

                try {
                    data = JSON.parse(sanitizedJsonString);
                } catch (e) {
                    console.error("Failed to parse JSON:", e);
                }

                $('#FromDateRange').text(" " + fromdate + "   To  " + Todate);

                BindInvestigationReportGrid(data);
                BindTemplRptData();
                //added by vijeta on 4th Aug 2018
                var str = "<div style='float: left'>Note-</div><div class='square'></div>&nbsp;&nbsp;Not Verified";
                $("#chartNote").show();
                $("#chartNote").empty();
                $("#chartNote").append(str);
                //---------------

                //var strdynamicDate = "";
                //for (var H = 0; H < result.TblDate.length; H++) {
                //    strdynamicDate += "<th style='width:15px !important;'>" + result.TblDate[H].DATETIME + "</th>";
                //}

                //var thead = "<tr style='background-color:#d6e9c6;'><th class='first' style='height:36px;position:absolute;background-color:#d6e9c6;'>Test Name</th><th class='second' style='height:36px;position:absolute;background-color:#d6e9c6;'>Investigation</th><th style=';white-space:nowrap !important;background-color:#d6e9c6;height:36px;' class='other'>Normal Range</th>" + strdynamicDate + "</tr>";
                //$("#tblInvestigationChart thead").append(thead);

                <%--var row = '';
                for (var D = 0; D < result.Investigate.length; D++) {
                    var dateResult = "";
                    for (var H = 0; H < result.TblDate.length; H++) {
                        var DateOf = result.TblDate[H].DATETIME
                        dateResult += "<td style='width:10px !important;text-align:center'>" + (result.Investigate[D][DateOf] != null ? result.Investigate[D][DateOf] : "") + "</td>";
                    }

                    row += "<tr><td class='testNameCls first'>" + result.Investigate[D]["TESTNAME"] + "</td><td class='second'>" + result.Investigate[D]["INVESTDESC"] + "</td><td class='other' style='white-space:nowrap !important'>" + result.Investigate[D]["NORMRANGE"] + "</td>" + dateResult + "</tr>";
                }
                $("#tblInvestigationChart tbody").append(row);
                $("#tblInvestigationChart input[id*='R']").parent().css("background-color", "#ffc0cbc2");//added by vijeta on 4th Aug 2018
            }
            groupTable($('#tblInvestigationChart tr:has(td)'), 0, 1);  // tr:has(td)
            $('#tblInvestigationChart .deleted').remove();

            var fromdate = '<%= ViewBag.FromDate%>';
            var Todate = '<%= ViewBag.Todate%>';
            $('#FromDateRange').text(" " + fromdate + "   To  " + Todate);


            var m = $('#tblInvestigationChart tbody td.other').get();--%>

                //$.each(m, function (index, element) {

                //    var otherHigt = $(this).next().height();
                //    $(this).height(otherHigt);

                //    var hit = $(this).height();
                //    var desc = $(this).prev().text();
                //    if (desc == "Erythrocytes") {
                //        $(this).height(otherHigt);
                //    }
                //    $(this).prev().css("position", "absolute");
                //    $(this).prev().css("height", (otherHigt + 1));
                //    //$(this).css("position", "absolute");
                //    //$(this).css("height", (hit+1));
                //})

                //NonSpanData();
            }
            else {
                //var noDataFound = "<div><label>No Data Found</label></div>"
                ////$(body).append(noDataFound);
                //var elem = document.createElement('div');
                //document.body.appendChild(noDataFound);
                $("#NodataFoundDiv").show();
            }
        });

        //function groupTable($rows, startIndex, total) {
        //    if (total === 0) {
        //        return;
        //    }
        //    var i, currentIndex = startIndex, count = 1, lst = [];
        //    var tds = $rows.find('td:eq(' + currentIndex + ')');
        //    var ctrl = $(tds[0]);
        //    //  $(ctrl).css("Height", cellHight);

        //    lst.push($rows[0]);
        //    for (i = 1; i <= tds.length; i++) {
        //        if (ctrl.text() == $(tds[i]).text()) {
        //            count++;
        //            $(tds[i]).addClass('deleted');
        //            lst.push($rows[i]);
        //        }
        //        else {
        //            if (count > 1) {
        //                ctrl.attr('rowspan', count);
        //                groupTable($(lst), startIndex + 1, total - 1)

        //                //var cellHight = $(ctrl).next().next().height();
        //                //$(ctrl).css("height", (cellHight * count));
        //            }
        //            count = 1;
        //            lst = [];
        //            ctrl = $(tds[i]);
        //            lst.push($rows[i]);
        //        }
        //    }

        //}

        //function NonSpanData() {
        //    var Frow = $('#tblInvestigationChart tr:has(td.first)');
        //    var tds = $(Frow).find('td:eq(' + 0 + ')');
        //    var nonspanRow = []

        //    //var cellHight = $(ctrl).next().next().height();
        //    //$(ctrl).css("height", (cellHight * count));


        //    //$.each(tds, function (i, e) {
        //    //       if (!$(this).attr('rowspan'))
        //    //       {
        //    //           var Hiht = $(this).next().height();
        //    //           $(this).css("height", Hiht);
        //    //       }
        //    //       else
        //    //       {
        //    //           var spanCount = $(this).attr('rowspan');
        //    //           var Hiht = $(this).height();
        //    //         //  TotalCount = Number(spanCount * Hiht) + Number(spanCount)
        //    //           $(this).css("position","absolute")
        //    //           // $(this).css("height", (Hiht * spanCount));
        //    //           $(this).css("height", Hiht);

        //    //           $()
        //    //       }
        //    //})

        //    $.each(tds, function (i, e) {

        //        var spanCount = $(this).attr('rowspan');
        //        var Hiht = $(this).height();
        //        TotalCount = Number(spanCount * Hiht) + Number(spanCount)
        //        $(this).css("position", "absolute")
        //        // $(this).css("height", (Hiht * spanCount));
        //        $(this).css("height", (Hiht + 1));

        //    })

        //}

        // Added by Dhananjay 20240909
        function sanitizeJsonString(jsonString) {
            return jsonString.replace(/[\x00-\x1F\x7F-\x9F]/g, '');
        }

        function BindInvestigationReportGrid(result) {
            var winHeight = $(window).height();
            var gridHeight = (winHeight - 160);
            colnames = [];
            colmodel = [];

            colnames = ['Test Name', 'Investigation', 'Normal Range'];
            colmodel = [
            {
                name: 'TESTNAME', index: 'TESTNAME', width: 220, align: "left", sortable: false, classes: 'colCellWrapTest_Name', cellattr: function (rowId, tv, rawObject, cm, rdata) {
                    return 'id=\'TESTNAME' + rowId + "\'";
                }
            },
            { name: 'INVESTDESC', index: 'INVESTDESC', width: 220, align: "left", sortable: false, classes: 'colCellWrapInvest_Norm' },
            { name: 'NORMRANGE', index: 'NORMRANGE', width: 150, sortable: false, align: "right", classes: 'colCellWrapInvest_Norm' },
            ];

            if (result != "") {
                if (result.TblDate != null) {
                    if (result.TblDate.length > 0) {
                        for (var i = 0; i < result.TblDate.length; i++) {
                            colnames.push(result.TblDate[i].DATETIME);
                            console.log(result.TblDate[i].DATETIME)
                            var ResColNm = result.TblDate[i].DATETIME;
                            var responColNM = {
                                name: ResColNm, index: ResColNm, width: 120, editable: false, sortable: true, classes: 'not-editable-cell', searchoptions: { clearSearch: false }, formatoptions: { defaultvalue: '0.00' }, classes: 'colCellWrap', align: "right",
                            }
                            colmodel.push(responColNM);
                            console.log(responColNM)
                        }

                    }
                }
            }

            if (result.Investigate.length > 0) {

                //var winWidth = $(window).width()  - 20;
                //var grdwidth = winWidth + "px";
                var str = "<div style='float: left;'>Note-</div><div class='square'></div>&nbsp;&nbsp;Not Verified";
                $("#chartNote").show();
                $("#chartNote").empty();
                $("#chartNote").append(str);

                $("#tblInvestigationChart").jqGrid('GridUnload');

                $grid = $("#tblInvestigationChart"),
                resizeColumnHeader = function () {
                    var rowHight, resizeSpanHeight,
                        // get the header row which contains
                        headerRow = $(this).closest("div.ui-jqgrid-view")
                            .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

                    // reset column height
                    headerRow.find("span.ui-jqgrid-resize").each(function () {
                        this.style.height = '';
                    });

                    //    // increase the height of the resizing span
                    resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
                    headerRow.find("span.ui-jqgrid-resize").each(function () {
                        this.style.cssText = resizeSpanHeight;
                    });

                    //    // set position of the dive with the column header text to the middle
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


                jQuery("#tblInvestigationChart").jqGrid({
                    datatype: 'local',
                    colNames: colnames,
                    colModel: colmodel,
                    shrinkToFit: false,
                    forceFit: false,
                    cellsubmit: 'clientArray',
                    loadonce: true,
                    ignoreCase: true,
                    rowNum: 1000,
                    sortorder: 'asc',
                    gridview: true,
                    //width: 1040,
                    height: gridHeight,
                    hover: true,
                    jsonReader: { cell: "" },
                    rowattr: function (rd) {

                    },
                    loadComplete: function (data) {
                        var gridScroll = $('div.ui-jqgrid-bdiv');
                        var header = $('.ui-jqgrid-hdiv');
                        gridScroll[0].scrollLeft = header[0].scrollLeft;

                        //20-11-17
                        fixPositionsOfFrozenDivs.call(this);
                        //end
                    },
                    gridComplete: function () {
                        $("#tblInvestigationChart").jqGrid('setGridParam', { data: result.Investigate }).trigger("reloadGrid");
                        //$.loader.close();

                        var gridName = "tblInvestigationChart";
                        Merger(gridName, 'TESTNAME');
                        $("#tblInvestigationChart input[id*='R']").parent().css("background-color", "#ffc0cbc2");

                    },
                    loadComplete: function () {
                        if ($('#tblInvestigationChart').jqGrid('getGridParam', 'reccount') == 0)
                            $(".jqgfirstrow").css("height", "1px");
                        $(this).find(">tbody>tr.jqgrowdd").addClass("AltRowClassEven");
                        $(this).find(">tbody>tr.jqgrow:even").addClass("AltRowClassOdd");

                        //$("div.ui-jqgrid-hbox table.ui-jqgrid-htable thead tr th:nth-child(4)").remove();
                        //$("div.ui-jqgrid-bdiv table#tblInvestigationChart tr td:nth-child(4)").remove();
                        //$("th#tblInvestigationChart_").remove();
                        //$("th [aria-describedby='tblInvestigationChart_']").remove();
                    },

                }).trigger('reloadGrid');
                $('.div').removeClass('ui-jqgrid-sdiv');

                var windowWidth = $(window).width();
                var jqgridWidth = Number(windowWidth) - 30;
                $("#gbox_tblInvestigationChart,#gview_tblInvestigationChart").css("width", jqgridWidth);
                $("#gview_tblInvestigationChart").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                $("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);

                jQuery("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { frozen: true });
                jQuery("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { frozen: true });
                jQuery("#tblInvestigationChart").jqGrid('setColProp', 'NORMRANGE', { frozen: true });
                //if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
                //{
                //    $("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("height", "590px");
                //    $("#gbox_tblInvestigationChart,#gview_tblInvestigationChart").css("width", "875px");
                //    $("#gview_tblInvestigationChart").children('.ui-jqgrid-hdiv').css("width", "875px");
                //    $("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("width", "875px");

                //    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { frozen: true });
                //    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { frozen: true });
                //    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'NORMRANGE', { frozen: true });
                //}
                //else if (windowWidth > 1300) { // for desktops

                //    $("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("height", "590px");
                //    $("#gbox_tblInvestigationChart,#gview_tblInvestigationChart").css("width", "1035px");
                //    $("#gview_tblInvestigationChart").children('.ui-jqgrid-hdiv').css("width", "1035px");
                //    $("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("width", "1035px");

                //    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { frozen: true });
                //    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { frozen: true });
                //    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'NORMRANGE', { frozen: true });
                //}
                if (windowWidth < 576) { // for all mobile devices
                    //$("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { width: 50});
                    //$("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { width: 50 });
                    //$("#tblInvestigationChart").jqGrid('setColProp', 'NORMRANGE', { width: 50 });
                    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { frozen: true });
                    $("#tblInvestigationChart").hideCol("TESTNAME");

                    //$("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("height", "400px");
                    $("#gbox_tblInvestigationChart,#gview_tblInvestigationChart").css("width", jqgridWidth);
                    $("#gview_tblInvestigationChart").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                    $("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);

                    $("#gview_tblInvestigationChart").children('.frozen-bdiv').css("width", jqgridWidth);
                    $("#gview_tblInvestigationChart").children('.frozen-div').css("width", jqgridWidth);

                    //jQuery("#tblInvestigationChart").jqGrid('destroyFrozenColumns');
                    //jQuery("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { width: 50 });
                    //jQuery("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { width: 50 });

                    jQuery("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { frozen: true });

                    jQuery("#tblInvestigationChart").jqGrid('setFrozenColumns');
                }

                $grid.jqGrid('gridResize', {
                    minWidth: 450,
                    stop: function () {
                        fixPositionsOfFrozenDivs.call(this);
                        //fixGboxHeight.call(this);
                    }
                });
                $grid.bind("jqGridResizeStop", function () {
                    resizeColumnHeader.call(this);
                    fixPositionsOfFrozenDivs.call(this);
                    //fixGboxHeight.call(this);
                });
                resizeColumnHeader.call($grid[0]);
                $grid.jqGrid('setFrozenColumns');
                $grid.triggerHandler("jqGridAfterGridComplete");
                fixPositionsOfFrozenDivs.call($grid[0]);

                //}
                //}
                //  }

                //});

            }
        }
        function Merger(gridName, CellName) {

            var mya = $("#" + gridName + "").getDataIDs();

            var length = mya.length;
            for (var i = 0; i < length; i++) {

                var before = $("#" + gridName + "").jqGrid('getRowData', mya[i]);

                var rowSpanTaxCount = 1;
                for (j = i + 1; j <= length; j++) {

                    var end = $("#" + gridName + "").jqGrid('getRowData', mya[j]);
                    if (before[CellName] == end[CellName]) {
                        rowSpanTaxCount++;
                        $("#" + gridName + "").setCell(mya[j], CellName, '', {
                            display: 'none'
                        });
                    } else {
                        rowSpanTaxCount = 1;
                        break;
                    }
                    $("#" + CellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                }
            }
        }

        function BindTemplRptData() {

            var frmDate = fromdate;
            var toDate = Todate;
            $.ajax({
                type: 'post',
                url: '../ICU/GetTemplateResult',
                cache: false,
                dataType: "json",
                data: { mrNo: '<%= Model.MrNo%>', strFrmDate: frmDate, strTodate: toDate },
                async: false,
                success: function (response) {
                    $('.tableOthTempRpt').empty();
                    if (response != "Unsucessfull") {
                        var resultDateWise = JSON.parse(response);
                        //alert(response);
                        var mainDateWisediv = $('.tableOthTempRpt');
                        $.each(resultDateWise.Table, function (i, v) {
                            mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label></div>');
                            mainDateWisediv.append('<div class="parent" id="TmpRptDtWise_' + (i) + '" onClick="selectText(this.id);" > ');
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


        </script>

    <%--    <script>
        $(document).ready(function () {
            $('tbody').scroll(function (e) { //detect a scroll event on the tbody
                /*
                Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
                of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain 			it's relative position at the left of the table.    
                */
                $('thead').css("left", -$("tbody").scrollLeft()); //fix the thead relative to the body scrolling
                $('thead th:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first cell of the header
                $('tbody td:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first column of tdbody
            });
        });
    </script>--%>
</head>
<body>
    <div style="overflow-y:auto;height:100%;" >
    
        <table style="width: 100%; border-bottom: 1px solid;">
            <tr>
                <td>
                    <image src="../Images/nabh_accredited.jpg" style="height: 50px; margin-left: 30px;" />
                    <br />
                    <%--<label style="color: black; font-weight: bold">FORM/IP/IOR-18/01</label>--%>
                </td>
                <td style="text-align: center;">
                    <image src="../Images/logo.jpg" style="height: 50px;" />
                    <br />
                    <label style="color: black; font-weight: bold">Investigation Report : </label>
                    <label style="color: black; font-weight: bold" id="FromDateRange"></label>

                </td>
                <td>
                    <table style="float: right; margin-left: 5px; border: 1px solid darkgrey;" cellpadding="0px" cellspacing=" 0px;">
                        <tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;color:blue;">Name</label></td>
                            <td>:</td>
                            <td>
                                <label style=""><%=Html.DisplayFor(x => Model.PatientName, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                            <td class="header">
                                <label style="width: 100px; margin-left: 30px; font-weight: bold;color:blue;">MR No.</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.MrNo, new { id="txtMRNo",@class = "TextBxFormat",@style="250px;margin-left: 44px "})%></label></td>
                        </tr>
                        <tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;color:blue;">Consultant</label></td>
                            <td>:</td>
                            <td>
                                <label>Dr. &nbsp;<%=Html.DisplayFor(x => Model.Consulatation, new { id="txtConsDr",@class = "TextBxFormat",@style="margin-left: 24px;"})%></label></td>
                            <td class="header">
                                <label style="width: 100px; margin-left: 30px; font-weight: bold;color:blue;">IP No.</label></td>
                            <td>:</td>
                            <td>
                                  <label><%=Html.DisplayFor(x => Model.IPNO, new { id="txtIPNo",@class = "TextBxFormat",@style="margin-left:48px"})%></label></td>
                            </tr>
                            <tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;color:blue;">Age/Gender</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.AgeGender, new { id="txtAge",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            <td class="header">
                                <label style="width: 100px; margin-left: 30px; font-weight: bold;color:blue;">Admn. Dt/Tm</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.AdmnDateTime, new { id="txtAdmnDTTM",@class = "TextBxFormat",@style="margin-left: 10px"})%></label></td>
                        </tr>
                        <tr>
                            <td class="header">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;color:blue;">Ward/Bed No.</label></td>
                            <td>:</td>
                            <td>
                                <label><%=Html.DisplayFor(x => Model.WardBedNo, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            <td class="header" style="visibility: hidden;">
                                <label style="width: 100px; margin-left: 10px; font-weight: bold;color:blue;">Date </label></td>
                            <td  style="visibility: hidden;">:</td>
                            <td  style="visibility: hidden;">
                                 <label><%=Html.DisplayFor(x => Model.Date, new { id="txtDate",@class = "TextBxFormat",@style="250px;margin-left: 16px"})%></label></td>
                            
                        </tr>
                    </table>

                </td>
            </tr>

        </table>
   
   
         <div class="row" style="margin-left: 5px !important; margin-right: 0px !important">
                <div  id='chartNote' style="display:none;font-size:14px;margin-top: 11px;margin-left: 28px;background-color: #ffff0061;width: 177px"></div> 
                <table id="tblInvestigationChart" class="table" border="1">
                </table>
                 <div class="tableOthTempRpt" style="padding-top: 5px;">
                </div>
            </div>
    </div>
    <div id="NodataFoundDiv" style="display:none;margin-left: 20px;width: 150px;background-color:rgba(255, 0, 0, 0.35);margin-top:16px;">
        <label style="font-size:large">No data Found</label>
    </div>
</body>
</html>
