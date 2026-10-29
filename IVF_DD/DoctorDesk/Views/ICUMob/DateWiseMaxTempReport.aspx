<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

 <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
       
            
            <h5 style="color: darkslategray;font-weight:bold">MAX PERIPHERAL TEMPERATURE</h5>

            <div id="DateWiseResponsive">
            <table id="tblDateWiseMaxTemp"  class="tblDateTemp">
                

            </table>
            </div>
       

    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .ui-jqgrid .ui-jqgrid-htable th div
        {
            overflow: hidden;
            position: relative;
            height: auto; 
        }

    </style>
    <link href="../jqGrid/css/JQGTableStyle.css" rel="stylesheet" />
     <script src="../Scripts/ICUPatList.js"></script>
       <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    <script type="text/javascript">
        var winHeight;
        var otherHeights;
        $(document).ready(function () {
            winHeight = $(window).height();
            otherHeights = $('#mainHeaderHight').height() + 150;
            GetNursStationsNPAtients();


            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                //var dispLst = document.getElementById('sideList');
                //dispLst.style.display = "block";

            }
            SetPatientDtl();
            SetReportForDateWiseMaxTemp();

        });

        function SetReportForDateWiseMaxTemp()
        {
            var gridHeight = winHeight - otherHeights;
            var strIPNO = $.session.get('ICUPatIPNO').toString();           
            var strDate = getParameterByName('strDate');
            var strDate1 = getParameterByName('strDate');
            var strTime="";
            var rptType = "DATE WISE MAX TEMP";
            var windowWidth = $(window).width();
            if (windowWidth > 992)
                var jqgridWidth = Number(windowWidth) - ($("#menuList").width() + 50);
            else
                var jqgridWidth = Number(windowWidth)-20;

            $.ajax({
                url: '../ICUMob/ICUPrint?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&ReportType=' + rptType + '&&strToDt=' + strDate1,
                type: "POST",
                dataType: "JSON",
                success: function (response) {
                    //ajaxindicatorstop();
                    $("#tblDateWiseMaxTemp").empty();

                    if (response == "No Data Found" || response=="") {                     
                        //$.messager.alert("Information", "No Data Found");
                        var emptyRow = "<tr style='background-color: #3c8dbc;color: white;'><td>No Data Found</td></tr>";
                        $("#tblDateWiseMaxTemp").append(emptyRow);
                        
                    }
                    else {


                        colNames = ['Date', 'Max Temperature', 'No of Times > 98.6'];
                        colModel = [
                   { name: 'Date', index: 'Date', align: "left", sortable: false, classes: 'colCellWrapTest_Name' },
                   { name: 'MaxTemp', index: 'MaxTemp', align: "left", sortable: false, classes: 'not-editable-cell', classes: 'colCellWrap' },
                   { name: 'NoOfTimes', index: 'NoOfTimes', align: "left", sortable: false, classes: 'not-editable-cell', classes: 'colCellWrap' },
                        ];
                        if (response.length > 0) {
                            var winWidth = $(window).width() - $('#PatListPanelDiv').width() - 20;
                            var grdwidth = winWidth + "px";
                            $("#tblDateWiseMaxTemp").jqGrid('GridUnload');
                            $grid = $("#tblDateWiseMaxTemp"),
                           
                            jQuery("#tblDateWiseMaxTemp").jqGrid({
                                datatype: 'local',
                                colNames: colNames,
                                colModel: colModel,
                                shrinkToFit: true,
                                forceFit: true,
                                cellsubmit: 'clientArray',
                                loadonce: true,
                                ignoreCase: true,
                                rowNum: 9999,
                                sortorder: 'asc',
                                gridview: true,
                                hover: true,
                                height: gridHeight,
                                width:jqgridWidth,
                                jsonReader: { cell: "" },
                                rowattr: function (rd) {

                                },
                                loadComplete: function (data) {
                                    var gridScroll = $('div.ui-jqgrid-bdiv');
                                    var header = $('.ui-jqgrid-hdiv');
                                    gridScroll[0].scrollLeft = header[0].scrollLeft;
                                    $(this).find(">tbody>tr.jqgrowdd").addClass("AltRowClassEven");
                                    $(this).find(">tbody>tr.jqgrow:even").addClass("AltRowClassOdd");
                                },
                                gridComplete: function () {
                                    $("#tblDateWiseMaxTemp").jqGrid('setGridParam', { data: response }).trigger("reloadGrid");
                                    $.loader.close();
                                    var gridName = "tblDateWiseMaxTemp";
                                },
                                loadComplete: function () {
                                
                                },
                            }).trigger('reloadGrid');
                            $('.div').removeClass('ui-jqgrid-sdiv');
                            $("#gbox_tblDateWiseMaxTemp,#gview_tblDateWiseMaxTemp").css("width", grdwidth);
                            $("#gview_tblDateWiseMaxTemp").children('.ui-jqgrid-hdiv').css("width", grdwidth);
                            $("#gview_tblDateWiseMaxTemp").children('.ui-jqgrid-bdiv').css("width", grdwidth);
                            var windowWidth = $(window).width();
                            var jqgridWidth = Number(windowWidth) - 50;
                           

                            //if (windowWidth >= 1024 && windowWidth <= 1300)// for laptops
                            //{
                            //    $("#gview_tblDateWiseMaxTemp").children('.ui-jqgrid-bdiv').css("height", "590px");
                            //}
                            //else if (windowWidth > 1300) { // for desktops
                            //    $("#gview_tblDateWiseMaxTemp").children('.ui-jqgrid-bdiv').css("height", "590px");
                            //}
                            if(windowWidth<576) { 
                                $("#gbox_tblDateWiseMaxTemp,#gview_tblDateWiseMaxTemp").css("width", jqgridWidth);
                                $("#gview_tblDateWiseMaxTemp").children('.ui-jqgrid-hdiv').css("width", jqgridWidth);
                                $("#gview_tblDateWiseMaxTemp").children('.ui-jqgrid-bdiv').css("width", jqgridWidth);
                            }

                           
                          
                        }
                       
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    sWaitForPrint = "";
                    $.messager.alert("Error Information", "An error occurred while processing your request.");
                    //MsgDia('An error occurred while processing your request.', "Error Information");
                }
            });
        }
       
        
    </script>
</asp:Content>
