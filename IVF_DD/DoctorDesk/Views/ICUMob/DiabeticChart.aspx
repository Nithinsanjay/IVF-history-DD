<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

 <div class="container-fluid">

  <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
       
       <div class="col-sm-6 col-md-8">
      <span id="DATE1" style="display: inline-block;">From :</span> <input type="text" id="RptFrmDate" style="width:86px" readonly />
      <span id="DATE2" style="display: inline-block;">To :</span><input type="text" id="RptToDate" style="width:86px" readonly />
      <button id="btnSearch" class="btn btn-primary" style="background-color: #337ab7;border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>
      </div>
      <div class="col-sm-6 col-md-4">
      
      </div>
  
   </div>

    <div class="row" style="margin-left: -20px !important;margin-right: 0px !important""> 
         
        <h4 style="color: darkslategray; font-weight: bold">Diabetic Chart</h4>   
               
                <table id="tblDiabeticChart" class="DiabeticData">
                </table>
             
               <div class="col-md-9">   <!--kavita-->                     
            <table id="tblNoDataFound" style="width:100%;">    <!--kavita line height-->             
            </table>
        </div>
        </div>

     </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
       <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
     <link href="../jqGrid/css/JQGTableStyle.css" rel="stylesheet" />
     <script src="../Scripts/ICUPatList.js"></script>
    <script type="text/javascript">
        var winHeight;
        var otherHeights;
        $(document).ready(function () {
            //kavita 25-8-18
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
            SetReportForDiabeticChart();
            $("#btnSearch").click(function () {
                SetReportForDiabeticChart()
            });

        });

        function SetReportForDiabeticChart() {
            var gridHeight = winHeight - otherHeights;
            var strIPNO = $.session.get('ICUPatIPNO').toString();
            var strDate = $("#RptFrmDate").val();
            var strDate1 = $("#RptToDate").val();
            var strTime = "";
            var rptType = "DIABETIC";

            $.ajax({
                url: '../ICUMob/ICUPrint?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&ReportType=' + rptType + '&&strToDt=' + strDate1,
                type: "POST",
                dataType: "JSON",
                success: function (response) {
                    //ajaxindicatorstop();
                    $("#tblDiabeticChart").empty();

                    if (response == "No Data Found" || response == "") {
                        //$.messager.alert("Information", "No Data Found");
                        $('.zui-wrapper').css('display', 'none');
                        var emptyRow = "<tr style='background-color: #3c8dbc;color: white;height:40px;'><td>No Data Found</td></tr>";
                        $("#tblDiabeticChart").append(emptyRow); //kavita 30-8-18

                    }
                    else {

                        //result = JSON.parse(response);

                        colNames = ['Date - Time', 'GRBS mg/dl', 'US', 'UK', 'Medication Administered', 'Staff Name'];
               colModel = [
                   { name: 'Date_Time', index: 'Date_Time', width: 120, align: "left", sortable: false, classes: 'colCellWrapTest_Name' },
                   { name: 'HGT', index: 'HGT', width: 120, align: "left", sortable: false, classes: 'not-editable-cell', classes: 'colCellWrap' },
                   { name: 'US', index: 'US', width: 120, align: "left", sortable: false, classes: 'not-editable-cell', classes: 'colCellWrap' },
                   { name: 'UK', index: 'UK', width: 120, align: "left", sortable: false, classes: 'not-editable-cell',classes: 'colCellWrap' },
                   { name: 'HGTMEDADMN', index: 'HGTMEDADMN', width: 160, align: "left", sortable: false, classes: 'not-editable-cell', classes: 'colCellWrap' },
                   { name: 'USERNAME', index: 'USERNAME', width: 120, align: "left", sortable: false, classes: 'not-editable-cell', classes: 'colCellWrap' },

               ];

                        if (response.length > 0) {
                            var winWidth = $(window).width() - $('#PatListPanelDiv').width() - 20;
                            var grdwidth = winWidth + "px";
                            $("#tblDiabeticChart").jqGrid('GridUnload');
                            $grid = $("#tblDiabeticChart"),
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
                            jQuery("#tblDiabeticChart").jqGrid({
                                datatype: 'local',
                                colNames: colNames,
                                colModel: colModel,
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
                                    $("#tblDiabeticChart").jqGrid('setGridParam', { data: response }).trigger("reloadGrid");
                                    $.loader.close();

                                    var gridName = "tblDiabeticChart";
                                    //Merger(gridName, 'Date_Time');
                                    //$("#tblDiabeticChart input[id*='R']").parent().css("background-color", "#ffc0cbc2");

                                },
                                loadComplete: function () {
                                    if ($('#tblDiabeticChart').jqGrid('getGridParam', 'reccount') == 0)
                                        $(".jqgfirstrow").css("height", "1px");
                                    //$(this).find(">tbody>tr").removeClass('ui-widget-content');
                                    $(this).find(">tbody>tr.jqgrowdd").addClass("AltRowClassEven");
                                    $(this).find(">tbody>tr.jqgrow:even").addClass("AltRowClassOdd");
                                },
                            }).trigger('reloadGrid');
                            $('.div').removeClass('ui-jqgrid-sdiv');

                            $("#gbox_tblDiabeticChart,#gview_tblDiabeticChart").css("width", grdwidth);
                            $("#gview_tblDiabeticChart").children('.ui-jqgrid-hdiv').css("width", grdwidth);
                            $("#gview_tblDiabeticChart").children('.ui-jqgrid-bdiv').css("width", grdwidth);

                            jQuery("#tblDiabeticChart").jqGrid('setColProp', 'Date_Time', { frozen: true });
                            //var windowWidth = $(window).width();
                            //var jqgridWidth = Number(windowWidth) - 50;
                            var windowWidth = $(window).width();
                            var jqgridWidth = Number(windowWidth) - 30;

                            //if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
                            //{
                            //    $("#gview_tblDiabeticChart").children('.ui-jqgrid-bdiv').css("height", "590px");
                            //    $("#gbox_tblDiabeticChart,#gview_tblDiabeticChart").css("width", "875px");
                            //    $("#gview_tblDiabeticChart").children('.ui-jqgrid-hdiv').css("width", "875px");
                            //    $("#gview_tblDiabeticChart").children('.ui-jqgrid-bdiv').css("width", "875px");

                            //    jQuery("#tblDiabeticChart").jqGrid('setColProp', 'Date_Time', { frozen: true });
                               
                             
                            //}
                            //else if (windowWidth > 1300) { // for desktops

                            //    $("#gview_tblDiabeticChart").children('.ui-jqgrid-bdiv').css("height", "590px");
                            //    $("#gbox_tblDiabeticChart,#gview_tblDiabeticChart").css("width", "1035px");
                            //    $("#gview_tblDiabeticChart").children('.ui-jqgrid-hdiv').css("width", "1035px");
                            //    $("#gview_tblDiabeticChart").children('.ui-jqgrid-bdiv').css("width", "1035px");

                            //    jQuery("#tblDiabeticChart").jqGrid('setColProp', 'Date_Time', { frozen: true });
                                
                            //}
                            if(windowWidth<576) { // for all mobile devices
                                //$("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { width: 50});
                                //$("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { width: 50 });
                                //$("#tblInvestigationChart").jqGrid('setColProp', 'NORMRANGE', { width: 50 });
                                jQuery("#tblDiabeticChart").jqGrid('setColProp', 'Date_Time', { frozen: true });
                                //$("#tblDiabeticChart").hideCol("Date_Time");

                                //$("#gview_tblDiabeticChart").children('.ui-jqgrid-bdiv').css("height", "360px");
                                $("#gbox_tblDiabeticChart,#gview_tblDiabeticChart").css("width", jqgridWidth);
                                $("#gview_tblDiabeticChart").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                                $("#gview_tblDiabeticChart").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);

                                $("#gview_tblDiabeticChart").children('.frozen-bdiv').css("width", jqgridWidth);
                                $("#gview_tblDiabeticChart").children('.frozen-div').css("width", jqgridWidth);

                                //jQuery("#tblInvestigationChart").jqGrid('destroyFrozenColumns');
                                //jQuery("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { width: 50 });
                                //jQuery("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { width: 50 });

                                //jQuery("#tblDiabeticChart").jqGrid('setColProp', 'INVESTDESC', { frozen: true });

                                jQuery("#tblDiabeticChart").jqGrid('setFrozenColumns');
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
                        //var thead = "<tr><th class='zui-sticky-col' style='height: 53px;background-color:#245a9c;'>Date - Time</th><th>HGT mg/dl</th><th>US</th><th>UK</th><th>Medication Administered</th><th>Staff Name</th></tr>";//kavita height 53px
                       
                        //$("#tblDiabeticChart").append(thead);
                        //$.each(response, function (key, value) {
                        //    var row = "<tr><td class='zui-sticky-col' >" + value["CADATE"] + " - " + value["CATIME"] + "</td><td>" + value["HGT"] + "</td><td>" + value["US"] + "</td><td>" + value["UK"] + "</td><td>" + value["HGTMEDADMN"] + "</td><td>" + value["USERNAME"] + "</td></tr>";
                        //    $("#tblDiabeticChart").append(row);
                        //});
                    
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    sWaitForPrint = "";
                    MsgDia('An error occurred while processing your request.', "Error Information");
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
                            minDate: admissiondate,
                            onSelect: function () {            //vishal 27th Nov 2019
                                if (new Date($('#RptFrmDate').datepicker('getDate')) > new Date($('#RptToDate').datepicker('getDate'))) {
                                    $.messager.alert("Validation", "From date should be less then or equal to todate.");
                                    $('#RptToDate').datepicker('setDate', 'today');
                                }

                            }
                        });

            $("#RptToDate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            maxDate: new Date(),
                            minDate: admissiondate,
                            onSelect: function () {
                                if (new Date($('#RptToDate').datepicker('getDate')) < new Date($('#RptFrmDate').datepicker('getDate'))) {
                                    $.messager.alert("Validation", "To date should be greater then or equal to from date.");
                                    $('#RptToDate').datepicker('setDate', 'today');
                                }

                            }
                        });
          
        }
    </script>
</asp:Content>
