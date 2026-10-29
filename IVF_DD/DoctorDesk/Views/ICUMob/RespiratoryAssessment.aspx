<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <div class="container-fluid">
  <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
       
     <div class="col-sm-6 col-md-8">
     <span id="DATE1" style="display: inline-block;width:70px;"> Date :</span> <input type="text" id="RptFrmDate" readonly />    
     <button class="btn btn-primary" id="btnSearch" style="background-color: #337ab7;border-color: #2e6da4;float:none !important;margin-top:auto;"><i class="fa fa-search" aria-hidden="true"></i></button><!--kavita-->
     </div>
       
       <div class="col-sm-6 col-md-4">
      
      </div>
   <%--  <div class="col-md-3">
     
      </div>--%>
                 
   </div>
         <h4 style="color: darkslategray; font-weight: bold">Respiratory Assessment</h4>
    <div class="row" style="margin-left: -20px !important;margin-right: 0px !important;width:100% !important" id="rowWidth">    
        
       
         
                      
                <table id="essmnet" style="" class="respiratoryData">
                </table>
             
                 
         
             <div class="col-md-12">                        
            <table id="tblNoDataFound" style="width:100%;line-height:2.5">                
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
         var dt1 = "Date1";
         var dt2 = "Date2";
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
            SetReportForRespiratoryAssessment();

            $("#btnSearch").click(function () {
                SetReportForRespiratoryAssessment()
            });

         });

         function SetReportForRespiratoryAssessment() {
             var gridHeight = winHeight - otherHeights;
             var strIPNO = $.session.get('ICUPatIPNO').toString();
             var strDate = $("#RptFrmDate").val();
             var strDate1 = "";
             var strTime = "";
             var rptType = "RESPIRATORY";

             $.ajax({
                 url: '../ICUMob/ICUPrint?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&ReportType=' + rptType + '&&strToDt=' + strDate1,
                 type: "POST",
                 dataType: "JSON",
                 success: function (response) {
                     //ajaxindicatorstop();
                  
                     $("#essmnet").empty();
                   

                     if (response == "No Data Found" || response == "") {
                         //$.messager.alert("Information", "No Data Found");
                         //$('.zui-wrapper').css('display', 'none'); comment by kavita
                         var emptyRow = "<tr style='background-color: #3c8dbc;color: white;height:40px;'><td>No Data Found</td></tr>";
                         $("#essmnet").append(emptyRow);//kavita 30-8-18

                     }
                     else {

                         

                         dt1 = $("#RptFrmDate").val();
                         DatePlus1DayIncrement();
                         colNames = ['Time', '7AM', '8AM', '9AM', '10AM', '11AM', '12PM', '1PM', '2PM', '3PM', '4PM', '5PM', '6PM', '7PM', '8PM', '9PM',
                    '10PM', '11PM', '12AM', '1AM', '2AM', '3AM', '4AM', '5AM', '6AM'];
                         colModel = [


                               { name: 'DESC', index: 'DESC', width: 120, align: "left", frozen: true, sortable: false, classes: 'colCellWrapTest_Name' },
                              { name: '7 AM', index: '7 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '8 AM', index: '8 AM', width: 35, sortable: false, align: "right", classes: 'colCellWrap' },
                             { name: '9 AM', index: '9 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '10 AM', index: '10 AM', width: 40, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '11 AM', index: '11 AM', width: 40, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '12 PM', index: '12 PM', width: 40, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '1 PM', index: '1 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '2 PM', index: '2 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '3 PM', index: '3 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '4 PM', index: '4 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '5 PM', index: '5 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '6 PM', index: '6 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '7 PM', index: '7 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '8 PM', index: '8 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '9 PM', index: '9 PM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '10 PM', index: '10 PM', width: 40, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '11 PM', index: '11 PM', width: 40, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '12 AM', index: '12 AM', width: 40, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '1 AM', index: '1 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '2 AM', index: '2 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '3 AM', index: '3 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '4 AM', index: '4 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '5 AM', index: '5 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' },
                             { name: '6 AM', index: '6 AM', width: 35, align: "right", sortable: false, classes: 'colCellWrap' }
                         ];
                         var res = JSON.parse(response);
                         if (res.length > 0) {
                             //var grdwidth = $('#rowWidth').width() - 250 + "px";
                             //$("#essmnet").jqGrid('setGridWidth', parseInt(grdwidth), false);
                             var winWidth = $(window).width() - $('#PatListPanelDiv').width() - 20;
                             var grdwidth = winWidth+"px";//$('#rowWidth').width() - 250 + "px";
                             $("#essmnet").jqGrid('GridUnload');
                             $grid = $("#essmnet"),
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
                             jQuery("#essmnet").jqGrid({
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
                                 //width: grdwidth,
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
                                     $("#essmnet").jqGrid('setGridParam', { data: res }).trigger("reloadGrid");
                                     $.loader.close();

                                     var gridName = "essmnet";
                                     //Merger(gridName, 'Date_Time');
                                     //$("#tblDiabeticChart input[id*='R']").parent().css("background-color", "#ffc0cbc2");

                                 },
                                 loadComplete: function () {
                                     if ($('#essmnet').jqGrid('getGridParam', 'reccount') == 0)
                                         $(".jqgfirstrow").css("height", "1px");
                                     //$(this).find(">tbody>tr").removeClass('ui-widget-content');
                                     $(this).find(">tbody>tr.jqgrowdd").addClass("AltRowClassEven");
                                     $(this).find(">tbody>tr.jqgrow:even").addClass("AltRowClassOdd");

                                 },
                             }).trigger('reloadGrid');
                             $("#essmnet").jqGrid('destroyGroupHeader');
                             $("#essmnet").jqGrid('setGroupHeaders', {
                                 useColSpanStyle: true,
                                 groupHeaders: [
                                   { startColumnName: '7 AM', numberOfColumns: 17, titleText: dt1 },
                                   { startColumnName: '12 AM', numberOfColumns: 7, titleText: dt2 },
                                 ]
                             });
                             $('.div').removeClass('ui-jqgrid-sdiv');
                             $("#gbox_essmnet,#gview_essmnet").css("width", grdwidth);
                             $("#gview_essmnet").children('.ui-jqgrid-hdiv').css("width", grdwidth);
                             $("#gview_essmnet").children('.ui-jqgrid-bdiv').css("width", grdwidth);
                             jQuery("#essmnet").jqGrid('setColProp', 'Time', { frozen: true });
                             ////var windowWidth = $(window).width();
                             ////var jqgridWidth = Number(windowWidth) - 50;
                             var windowWidth = $(window).width();
                             var jqgridWidth = Number(windowWidth)-30;

                             //if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
                             //{
                             //    //$("#gview_essmnet").children('.ui-jqgrid-bdiv').css("height", "590px");
                             //    $("#gbox_essmnet,#gview_essmnet").css("width", "875px");
                             //    $("#gview_essmnet").children('.ui-jqgrid-hdiv').css("width", "875px");
                             //    $("#gview_essmnet").children('.ui-jqgrid-bdiv').css("width", "875px");

                             //    jQuery("#essmnet").jqGrid('setColProp', 'Time', { frozen: true });


                             //}
                             //else if (windowWidth > 1300) { // for desktops

                             //    //$("#gview_essmnet").children('.ui-jqgrid-bdiv').css("height", "590px");
                             //    $("#gbox_essmnet,#gview_essmnet").css("width", "1035px");
                             //    $("#gview_essmnet").children('.ui-jqgrid-hdiv').css("width", "1035px");
                             //    $("#gview_essmnet").children('.ui-jqgrid-bdiv').css("width", "1035px");

                             //    jQuery("#essmnet").jqGrid('setColProp', 'Time', { frozen: true });

                             //}
                             if (windowWidth<576) { // for all mobile devices
                                 //$("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { width: 50});
                                 //$("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { width: 50 });
                                 //$("#tblInvestigationChart").jqGrid('setColProp', 'NORMRANGE', { width: 50 });
                                 jQuery("#essmnet").jqGrid('setColProp', 'Time', { frozen: true });
                                 //$("#tblDiabeticChart").hideCol("Date_Time");

                                 //$("#gview_essmnet").children('.ui-jqgrid-bdiv').css("height", "360px");
                                 $("#gbox_essmnet,#gview_essmnet").css("width", jqgridWidth);
                                 $("#gview_essmnet").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                                 $("#gview_essmnet").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);

                                 $("#gview_essmnet").children('.frozen-bdiv').css("width", jqgridWidth);
                                 $("#gview_essmnet").children('.frozen-div').css("width", jqgridWidth);

                                 //jQuery("#tblInvestigationChart").jqGrid('destroyFrozenColumns');
                                 //jQuery("#tblInvestigationChart").jqGrid('setColProp', 'TESTNAME', { width: 50 });
                                 //jQuery("#tblInvestigationChart").jqGrid('setColProp', 'INVESTDESC', { width: 50 });

                                 //jQuery("#tblDiabeticChart").jqGrid('setColProp', 'INVESTDESC', { frozen: true });

                                 jQuery("#essmnet").jqGrid('setFrozenColumns');
                             }
                             jQuery("#essmnet").jqGrid('setFrozenColumns');
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


                         
                        

                        

                        

                         /* comment by kavita
                         
                         var theadGroup = "<tr><th class='zui-sticky-col' style='height: 50px;background-color:#245a9c;'></th><th colspan=17 class='clsHeaderFix' style='text-align:center'>" + dt1 + "</th><th colspan=7 class='clsHeaderFix' style='text-align:center'>" + dt2 + "</th></tr>"//kavita bg-color zui-sticky
                         var thead = "<tr><th class='zui-sticky-col'style='background-color:#245a9c;' >Time</th><th class='clsHeaderFix'>7 AM</th><th class='clsHeaderFix'>8 AM</th><th class='clsHeaderFix'>9 AM</th><th class='clsHeaderFix'>10 AM </th><th class='clsHeaderFix'>11 AM</th><th class='clsHeaderFix'>12 PM</th><th class='clsHeaderFix'>1 PM</th><th class='clsHeaderFix'>2 PM</th><th class='clsHeaderFix'>3 PM</th><th class='clsHeaderFix'>4 PM</th><th class='clsHeaderFix'>5 PM</th><th class='clsHeaderFix'>6 PM</th><th class='clsHeaderFix'>7 PM</th><th class='clsHeaderFix'>8 PM</th><th class='clsHeaderFix'>9 PM</th><th class='clsHeaderFix'>10 PM</th><th class='clsHeaderFix'>11 PM</th><th class='clsHeaderFix'>12 AM</th><th class='clsHeaderFix'>1 AM</th><th class='clsHeaderFix'>2 AM</th><th class='clsHeaderFix'>3 AM</th><th class='clsHeaderFix'>4 AM</th><th class='clsHeaderFix'>5 AM</th><th class='clsHeaderFix'>6 AM</th> ";
                         $("#essmnet").append(theadGroup);
                         $("#essmnet").append(thead);
                         $("#essmnet").append('<tbody>');
                         $.each(data, function (key, value) {
                             var row = "<tr>"  +
                                 "</td><td class='zui-sticky-col'>" + value["DESC"] + "</td><td >" + value["7 AM"] + "</td><td >" + value["8 AM"] +
                                "</td><td>" + value["9 AM"] + "</td><td>" + value["10 AM"] +
                                  "</td><td >" + value["11 AM"] + "</td><td>" + value["12 PM"] +
                                  "</td><td >" + value["1 PM"] + "</td><td>" + value["2 PM"] +
                                  "</td><td>" + value["3 PM"] + "</td><td>" + value["4 PM"] +
                                   "</td><td>" + value["5 PM"] + "</td><td>" + value["6 PM"] +
                                    "</td><td>" + value["7 PM"] + "</td><td>" + value["8 PM"] +
                                     "</td><td>" + value["9 PM"] + "</td><td>" + value["10 PM"] +
                                      "</td><td>" + value["11 PM"] + "</td><td>" + value["12 AM"] +
                                       "</td><td>" + value["1 AM"] + "</td><td>" + value["2 AM"] +
                                        "</td><td>" + value["3 AM"] + "</td><td>" + value["4 AM"] +
                                       "</td><td>" + value["5 AM"] + "</td>" + "<td>"+value["6 AM"]+"</td>";

                           

                             $("#essmnet").append(row);
                             
                         });
                         $("#essmnet").append('</tbody>');
                         $("#essmnet tr td").each(function () {

                             //if ($("#essmnet tr td")[9].textContent == "") {
                             //    $(this).parent().hide();
                             //}

                             //var cellText = $.trim($(this).text());

                             //if (cellText.length == 0) {
                             //    $(this).parent().hide();
                             //}
                         })
                            */                  

                     
                 },
                 complete: function (data) {
                     //groupTable($('#essmnet tr:has(td)'), 0, 24);  // tr:has(td)
                     //$('#essmnet .deleted').remove();
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     sWaitForPrint = "";
                     MsgDia('An error occurred while processing your request.', "Error Information");
                 }
             });
         }

         function DatePlus1DayIncrement() {
             //var chngDate1 = dt1;
             // dt1 = chngDate1; //Meenakshi

             var chngDate2 = dt1;
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



         
         </script>
</asp:Content>
