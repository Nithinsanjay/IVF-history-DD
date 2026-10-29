<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!DOCTYPE html>
    <div class="container-fluid">
        <div class="row" style="margin-left: 0px !important; margin-right: 0px !important">

            <div class="col-sm-6 col-md-8">
                <span id="DATE1" style="display: inline-block;">From :</span>
                <input type="text" id="RptFrmDate" style="width: 86px" readonly />
                <span id="DATE2" style="display: inline-block;">To :</span><input type="text" id="RptToDate" style="width: 86px" readonly />
                <button id="btnSearch" class="btn btn-primary" style="background-color: #337ab7; border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>
            </div>
            <div class="col-sm-6 col-md-4">
            </div>

        </div>

        <div class="row" style="margin-left: -20px !important; margin-right: 0px !important">
            <h4 style="color: darkslategray; font-weight: bold">Investigation Report</h4>

            <div  id='chartNote' style="display: none; font-size: 14px;"></div>
            <%--added by vijeta on 4th Aug 2018--%>
         <%--   <div class="wrapperDiv">--%>
                <div id="tblResponsiveDiv">

                    <table id="tblInvestigationChart" class="tblInvestigationCls">
                     <%--   <thead></thead>
                        <tbody></tbody>--%>
                    </table>
                </div>
           <%-- </div>--%>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        /*added by vijeta on 4th August 2018*/
        .square {
            height: 12px;
            width: 12px;
            background-color:#ffc0cbc2;
            float: left;
            margin-top: 4px;
            margin-left: 10px;
        }

       


      
        
         /*.tblInvestigationCls {
            width: 900px;
        }
        


        @media only screen and (min-width : 992px) {
             .tblInvestigationCls {
                width: 900px;
                /*height:800px;*/
            /*}

             .ui-jqgrid-view#gview_tblInvestigationChart {
                width: auto;
            }

            .ui-jqgrid-view#gview_tblInvestigationChart {
                height: auto;
            }
        }*/
    </style>
    <link href="../../jqGrid/css/JQGTableStyle.css" rel="stylesheet" />
    <script src="../Scripts/ICUPatList.js"></script>

    <script type="text/javascript">
        var winHeight;
        var otherHeights;
        $(document).ready(function () {
            winHeight = $(window).height();
            otherHeights = $('#mainHeaderHight').height() + 150;
            SetDateTime();
            GetNursStationsNPAtients();


            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                //var dispLst = document.getElementById('sideList');
                //dispLst.style.display = "block";

            }
            SetPatientDtl();
            //SetReportForInvestigationChart();

            $("#btnSearch").click(function () {
                BindInvestigationReportGrid();
            });

            //added on 9th Aug 2018
            $("#RptFrmDate,#RptToDate").click(function () {
                $("#ui-datepicker-div.ui-widget").css("z-index", "1000");
            });

            BindInvestigationReportGrid(); //added on 9th Aug 2018
        });

      


        function SetDateTime() {
            var admissiondate = $.session.get('ICUPatAdmnDate');
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1;
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }
            today = dd + '/' + mm + '/' + yyyy;
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
                            minDate: admissiondate
                        });

            $("#RptToDate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            maxDate: new Date(),
                            minDate: admissiondate
                        });
        }

        function BindInvestigationReportGrid() {
                var gridHeight = winHeight - otherHeights;
                var strIPNO = $.session.get('ICUPatIPNO').toString();
                var strDate = $("#RptFrmDate").val();
                var strDate1 = $("#RptToDate").val();
                var strTime = "";
                var rptType = "INVESTIGATION";
                $.ajax({
                    url: '../ICUMob/GetInvestReportData?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strToDt=' + strDate1,
                    type: "POST",
                    dataType: "JSON",
                    success: function (response) {
                        $("#tblInvestigationChart").empty();//kavita 30-8-18
                        if (response == "No Data Found" || response == "") {
                            //$.messager.alert("Information", "No Data Found");
                            var emptyRow = "<tr style='background-color: #3c8dbc;color: white;height:40px;'><td>No Data Found</td></tr>";
                            $("#tblInvestigationChart").append(emptyRow);//30-8-8

                        }
                        else {
                            result = JSON.parse(response);


                            colnames = [];
                            colmodel = [];

                            colnames = ['Test Name', 'Investigation', 'Normal Range'];
                            colmodel = [
                            {
                                name: 'TESTNAME', index: 'TESTNAME', width: 120, align: "left", sortable: false, classes: 'colCellWrapTest_Name', cellattr: function (rowId, tv, rawObject, cm, rdata) {
                                    return 'id=\'TESTNAME' + rowId + "\'";
                                }
                            },
                            { name: 'INVESTDESC', index: 'INVESTDESC', width: 120, align: "left", sortable: false, classes: 'colCellWrapInvest_Norm' },
                            { name: 'NORMRANGE', index: 'NORMRANGE', width: 90, sortable: false, align: "right", classes: 'colCellWrapInvest_Norm' },
                            ];

                            if (result != "") {
                                if (result.TblDate != null) {
                                    if (result.TblDate.length > 0) {
                                        for (var i = 0; i < result.TblDate.length; i++) {
                                            colnames.push(result.TblDate[i].DATETIME);
                                            var ResColNm = result.TblDate[i].DATETIME;
                                            var responColNM = {
                                                name: ResColNm, index: ResColNm, width: 120, editable: false, sortable: true, classes: 'not-editable-cell', searchoptions: { clearSearch: false }, formatoptions: { defaultvalue: '0.00' }, classes: 'colCellWrap', align: "right",
                                            }
                                            colmodel.push(responColNM);
                                        }

                                    }
                                }
                            }

                            if (result.Investigate.length > 0) {

                                var winWidth = $(window).width() - $('#PatListPanelDiv').width() - 20;
                                var grdwidth = winWidth + "px";
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
                                //fixGboxHeight = function () {
                                //    var gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight(),
                                //        pagerHeight = $(this.p.pager).outerHeight();

                                //    $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
                                //    gviewHeight = $("#gview_" + $.jgrid.jqID(this.id)).outerHeight();
                                //    pagerHeight = $(this.p.pager).outerHeight();
                                //    $("#gbox_" + $.jgrid.jqID(this.id)).height(gviewHeight + pagerHeight);
                                //};


                                //end

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
                                        $.loader.close();

                                        var gridName = "tblInvestigationChart";
                                        Merger(gridName, 'TESTNAME');
                                        $("#tblInvestigationChart input[id*='R']").parent().css("background-color", "#ffc0cbc2");

                                    },
                                    loadComplete: function () {
                                        if ($('#tblInvestigationChart').jqGrid('getGridParam', 'reccount') == 0)
                                            $(".jqgfirstrow").css("height", "1px");
                                        $(this).find(">tbody>tr.jqgrowdd").addClass("AltRowClassEven");
                                        $(this).find(">tbody>tr.jqgrow:even").addClass("AltRowClassOdd");
                                    },

                                }).trigger('reloadGrid');
                                $('.div').removeClass('ui-jqgrid-sdiv');

                                var windowWidth = $(window).width();
                                var jqgridWidth = Number(windowWidth) - 30;
                                $("#gbox_tblInvestigationChart,#gview_tblInvestigationChart").css("width", grdwidth);
                                $("#gview_tblInvestigationChart").children('.ui-jqgrid-hdiv').css("width", grdwidth);
                                $("#gview_tblInvestigationChart").children('.ui-jqgrid-bdiv').css("width", grdwidth);

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
                                if (windowWidth<576) { // for all mobile devices
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

                            }
                        }
                    }

                });
           
            
            
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
    </script>
</asp:Content>
