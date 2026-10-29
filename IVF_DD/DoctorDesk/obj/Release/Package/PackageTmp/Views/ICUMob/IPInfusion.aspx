<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.IPInfusion>" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <div class="container-fluid">
  <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
  
      <table style="width: 70%;margin: 1% 0 1% 0;" id="infotab"><!--kavita-->
                <tr>
                    <td colspan="2">
                        <label style=" display: inline-block;">Provisional Diagnosis</label>
                       
                        <%=Html.TextAreaFor(x => Model.ProvDiagno, new { id = "txtProvDiagno", @class = "TextBxFormat", maxlength = "1000", Style = "width:330px;height:30px;vertical-align: middle;",@rows = "5",@readonly="True"})%></td>
                    <td colspan="2">
                        <label style=" display: inline-block;">Allergies</label>
                        
                        <%: Html.TextAreaFor(x => Model.Allergies, new { id = "txtAllergies", @class = "TextBxFormat", maxlength = "1000", Style = "width:340px;height:30px;vertical-align: middle;",@rows = "5" ,@readonly="True"})%>
                    </td>
                  <%--  vishal 16th Nov--%>
                     <td>                    <input type="button" id="btnCancelShwHide" class="btn btn-primary" value ="" style="background-color: #337ab7; border-color: #2e6da4;"/>
                       
                         <%-- <button id="btnCancelShwHide1" class="btn btn-primary" style="background-color: #337ab7; border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>--%>
                    </td>
                </tr>
           <tr>
               <td colspan="5">
                                        <label style="width: 12.3%;display: inline-block;vertical-align: text-bottom;">Remark</label><%: Html.TextAreaFor(x => Model.DocRemarks, new { id = "txtDocRemarks", @class = "TextBxFormat", Style = "width: 78%;height:30px",maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                   
                                         </td>
          </tr>
            </table>
 
                 
   </div>
        
    <div class="row" style="margin-left: -10px !important;margin-right: 0px !important;width:100% !important" id="rowWidth">    
        
       
         
                      
               <%-- <table id="essmnet" style="" class="respiratoryData">
                </table>
             --%>
                   <div style="width: 100%; margin-top: 5px">
                            <table id="JqGridInfusion">
                            </table>
                     
                        </div>
        
         
             <div class="col-md-12">                        
            <table id="tblNoDataFound" style="width:100%;line-height:2.5">                
            </table>



        </div>
       
        </div>
     
    </div>
        <table style="width: 55%; background-color: #909d9044; border: 1px solid grey;">
            <tr style="line-height: 20px">
                <td style="width: 8%;">
                    <div class="tsStatus" style="background-color: #e02c0f !important;"></div>
                
                    <label class="LBLFormat" style="margin-left:5%">High Alert</label>
                </td>
                <td style="width: 10%;">
                    <div class="tsStatus PlanedOmitt"></div>
                
                    <label class="LBLFormat" style="margin-left:5%">Planned & Omitted</label>
                </td>
                <td style="width: 8%;">
                    <div class="tsStatus " style="background-color: #61f4235c !important;"></div>
               
                    <label class="LBLFormat" style="margin-left:5%">Omitted</label>
                </td>
                <td style="width: 8%;">
                    <div class="tsStatus" style="background-color: #f4d6f4c7 !important;"></div>
               
                    <label class="LBLFormat" style="margin-left:5%">Planned</label>
                </td>
                <td style="width: 8%;">
                    <div class="tsStatus cancellation"></div>
                
                    <label class="LBLFormat" style="margin-left:5%">Cancelled</label>
                </td>
               
            </tr>
        </table> 
     <div style="width:75%;">
             <label id="btnSave" style="background-color: transparent; border-color: transparent;margin-right: 10px;float:right;" title="Save" class="rightbtn">
                <img src="../Images/check-round.png" style="bottom: 0px; background-color: white; border-radius: 50%; position: fixed;margin-bottom: 5px; ">
            </label>
        </div>
   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
     <style type="text/css">
         @media only screen and (max-width : 1024px) {
             .content-wrapper {
                 margin-left: 0px !important;
             }
         }

         .tsStatus {
    width: 13px;
    height: 13px;
    float: left;
    margin-top: 3px;
    border: 1px solid #313131;
    margin-left: 3px;
    /* margin-top: -5px; */
    /* margin: 3px 3px 3px 5px; */
}
            .cancellation {
            /*background-image: linear-gradient(to left, #cef9f4, #c7f8f3, #c0f7f1, #b9f5f0, #b1f4ef);*/
            /*background-image: linear-gradient(to left top, #f9b596, #f9b292, #f9af8e, #f9ab8a, #f9a886);*/
            background-color: #f9b596;
             /*background : '#f9a886';*/
        } 
     </style>
    
     <link href="../../jqGrid/css/JQGTableStyle.css" rel="stylesheet" />
     <script src="../Scripts/ICUPatList.js"></script>
     <script type="text/javascript">
         var dt1 = "Date1";
         var dt2 = "Date2";
         var winHeight;
         var otherHeights;
         var gact = "N";
         var IsOnlyDisplay = false;
         var IsrolloverData = 'N';
         var globalInfusionData = "";
         var ServerTime = '<%=ViewBag.CurrServerTime %>';
         var ServerDate = '<%=ViewBag.CurrServerDate %>';
         $(document).ready(function () {
            
             winHeight = $(window).height();

             otherHeights = $('#mainHeaderHight').height() + 150;

             ActiveMenu("IPInfusion");
          //  SetDateTime();
            GetNursStationsNPAtients();
            $("#tabMenu").css("display", "block");

             if ($(window).width() >= 1025) {                                            //screen width size comparion
                 var menuL = document.getElementById('menuList');
                 menuL.style.display = "block";

                
                

             }
             SetPatientDtl();
             JQGridInfusion()

             $("#btnSearch").click(function () {
                 JQGridInfusion()
             });
             load_InfusionData();
             addButtInfusion();
             // BindAlreadySavedData();
             GetTreat();
             if (resultofal != null && resultofal != "") {
                 SetGridDataInfusion(resultofal);
                // fillheaderDetailsForNon(resultofal);
             }
             $("#btnSave").click(function () {
                 SaveAllIPInfusion("N");
                 
             });

         });
         jQuery(document).ready(function ($) {

             if (window.history && window.history.pushState) {

                 window.history.pushState('forward', null, './IPInfusion');

                 $(window).on('popstate', function () {

                     // $("#btnSave").trigger("click");
                     if (stopProp)
                     SaveAllIPInfusion("Y")
                 });

             }
         });
         //$(window).on("load", function () {
         //    var newWidth = $(window).width();
         //    $("#JqGridInfusion").jqGrid("setGridWidth", newWidth - $('#PatListPanelDiv').width() - 500, false);
         //    $("#JqGridInfusion").jqGrid("setGridHeight", winHeight - $('#mainHeaderHight').height() - 200, true);
         //});

         function SaveAllIPInfusion(st) {
             IpNo = '' + $.session.get('ICUPatIPNO');
             MrNo = '' + $.session.get('ICUPatMRNO');
             PatName = '' + $.session.get('ICUPatName');
             var currtabIndx = localStorage.getItem("CurrentTabIndex");

             for (l = 0; l < AllGrid.length; l++) {
                 var ids = jQuery("#" + AllGrid[l]).jqGrid('getDataIDs');
                 for (var i = 1; i <= ids.length; i++) {
                     $("#JqGridInfusion").jqGrid("editCell", 0, 0, false);
                 }
             }
             // AMPMConvert();

             var JqGridInfusionData = $("#JqGridInfusion").getRowData();

             JqGridInfusionFilterData = jQuery.grep(JqGridInfusionData, function (n, i) {
                 n.Infusion = n.Infusion.replace(/&/g, "%26");
                 return (n.Infusion != "");
             });

             if (JqGridInfusionFilterData.length > 0) {
                 for (var i = 0; i < JqGridInfusionFilterData.length; i++) {
                     if (gact == 'N') {
                         // JqGridInfusionFilterData[i].SQNumber = (i + 1);
                     }
                     if (JqGridInfusionFilterData[i].Infusion.trim() == "" || JqGridInfusionFilterData[i].InfusionRate.trim() == "") {
                         SetactiveTab(1, "Infusion");
                         return false;
                     }
                 }
             }
             var tableInfusionData = JSON.stringify(JqGridInfusionFilterData)


             if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
                 gact = "N";
             }
             else {
                 gact = "E";
             }

             formData = '&&action=' + gact + '&&tableData=' + tableInfusionData + '&&IpNo=' + IpNo + '&&MrNo=' + MrNo + '&&PatName=' + PatName + '&&TranctionId=' + $('#tractiondropdown').val() + '&&Prov=' + $('#txtProvDiagno').val() + '&&Allergy=' + $('#txtAllergies').val();
             //  ajaxindicatorstart('Saving data.. please wait..');
             $.ajax({
                 type: "POST",
                 url: "../ICUMob/SaveTreatmentIPInfu",
                 data: formData,
                 dataType: "json",
                 cache: false,
                 success: function (response) {

                   
                     if (response.indexOf('Successful') >= 0) {
                         var splitval = response.toString().split('.');
                         if (splitval.length == 2) {
                             var TranNum = splitval[1].toString().trim();
                             if (TranNum.length > 0) {
                                 TranNo = TranNum;
                                 gact = 'E';
                                 IsrolloverData = 'N';
                                 $('#btnSave').val('Update');
                                 $('#lblModeIndicator').text("Update");
                                 $('#getloginInfo').removeClass('hide');
                                 $('#btnPrint').show().removeClass('hide');
                                 $('#tractiondropdown').empty();
                                 $('#tractiondropdown').val(TranNum);

                             }
                         }

                         GetTreat();
                         if (resultofal != null && resultofal != "") {
                             SetGridDataInfusion(resultofal);
                             // fillheaderDetailsForNon(resultofal);
                         }

                         //var CurrTab = localStorage.getItem('CurrentTabIndex');
                         //if (Number(CurrTab) != 6) {
                         //    SetValidateTabIndex(Number(CurrTab) + 1);
                         //    tabseq = Number((tabseq) + 1);
                         //}


                         if (!resultofal.hasOwnProperty("jsonMedicineData") || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                             window.location.href = '../ICUMob/NonDrugOrder';
                         }
                         else if(st.toString().trim() != "Y")
                             MsgDia(response, "Information");
                     }
                     else {
                         MsgDia(response, "Error");
                         return false;
                     }

                 },
                 complete: function () {
                     // GetTreatmentSheetData('', gact, IpNo);            ///added by vishal as on 20th Sept 2018

                     ///Added by vishal as on 1st Oct 2018
                     //if (tabseq == 0) {
                     //    var antbio = $.grep($('#JqGridAntibiotics').jqGrid('getRowData'), function (e) { return e.DrugName != "" });
                     //    var medicat = $.grep($('#JqGridMedication').jqGrid('getRowData'), function (e) { return e.DrugName != "" });

                     //    if (antbio.length == 0 && medicat.length == 0) {
                     //        $('#btnRollOver').show();
                     //    }
                     //    else {
                     //        $('#btnRollOver').hide();
                     //    }
                     //}
                     //else if (tabseq == 1) {
                     //    var inf = $.grep($('#JqGridInfusion').jqGrid('getRowData'), function (e) { return e.Infusion != "" });
                     //    if (inf.length == 0) {
                     //        $('#btnRollOver').show();
                     //    }
                     //    else {
                     //        $('#btnRollOver').hide();
                     //    }
                     //}
                     //else if (tabseq == 2) {
                     //    $('#btnRollOver').hide();
                     //}
                     //else if (tabseq == 3) {
                     //    var SpclInst = $.grep($('#JqGridSpeciaInstructions').jqGrid('getRowData'), function (e) { return e.DrugName != "" });
                     //    var BldPrdct = $.grep($('#JqGridBloodProduct').jqGrid('getRowData'), function (e) { return e.DrugName != "" });
                     //    if (SpclInst.length == 0 && BldPrdct.length == 0) {
                     //        $('#btnRollOver').show();
                     //    }
                     //    else {
                     //        $('#btnRollOver').hide();
                     //    }
                     //}
                     //else if (tabseq == 4) {
                     //    $('#btnRollOver').hide();
                     //}
                     //else if (tabseq == 5) {
                     //    var invstg = $.grep($('#JqGridInvestigation').jqGrid('getRowData'), function (e) { return e.Test != "" });
                     //    var ref = $.grep($('#JqGridReferrals').jqGrid('getRowData'), function (e) { return e.Doctor != "" && e.SpecilizationName != "" });
                     //    if (invstg.length == 0 && ref.length == 0) {

                     //        $('#btnRollOver').show();
                     //    }
                     //    else {
                     //        $('#btnRollOver').hide();
                     //    }
                     //}
                 },
                 onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                     $.messager.alert("Information", textStatus);
                 }
             });
         }
         function SetGridDataInfusion(result) {
             if (ISRYN == "Y") {
                 for (var i = 0; i <= result.jsonInfusionData.length - 1; i++) {
                     result.jsonInfusionData[i]["ADMINYN"] = "";
                 }
             }
             grid = $("#" + AllGrid[4]);
             grid.jqGrid('clearGridData');
             var recordsCnt = grid.jqGrid('getGridParam', 'records');
             if (recordsCnt < result.jsonInfusionData.length) {
                 AddBlankRow(grid, recordsCnt, result.jsonInfusionData.length, AllGrid[4]);
             }

             for (var M = 0; M < result.jsonInfusionData.length; M++) {
                 var colno = 4
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Infusion', result.jsonInfusionData[M].Infusion);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Dose', result.jsonInfusionData[M].Dose);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'InfusionRate', result.jsonInfusionData[M].InfusionRate);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'StartTime', result.jsonInfusionData[M].StartTime);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'EndTime', result.jsonInfusionData[M].EndTime);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'TypeCode', result.jsonInfusionData[M].TypeCode);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Remark', result.jsonInfusionData[M].Remark);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedBy', result.jsonInfusionData[M].ORDERBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'HighAlert', result.jsonInfusionData[M].HighAlert);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Omit', result.jsonInfusionData[M].Omit);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedBy', result.jsonInfusionData[M].OMITBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedDate', result.jsonInfusionData[M].OMITDT);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedTime', result.jsonInfusionData[M].OMITTM);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'NOTIFYN', result.jsonInfusionData[M].NOTIFYN);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'STATUS', result.jsonInfusionData[M].STATUS);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'ADMINYN', result.jsonInfusionData[M].ADMINYN);



                 if (result.jsonInfusionData[M].Omit == "Y") {
                     $("#" + AllGrid[colno]).jqGrid('setRowData', (M + 1), false, 'Omited');// Assign CSS class to row
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).addClass('avoid-clicks');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(15) input').attr("disabled", true);

                 }
                 else {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(15)').removeClass('avoid-clicks');
                 }

                 if (result.jsonInfusionData[M].ADMINYN == "Y" || result.jsonInfusionData[M].STATUS == "C") {
                    // for (i = 1; i < 6; i++) {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).addClass('avoid-clicks');
                     //}
                 }
                 else {
                     //if (gact == "N") {
                     //    //AddDelButtonByNew(grid, (M + 1))
                     //}
                     if (gact == "E" && result.jsonInfusionData[M].Omit == "N") {
                         AddCancelBtn(grid, M);
                         for (i = 3; i < 6; i++) {
                             $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(' + i + ')').addClass('avoid-clicks');
                         }
                     }
                 }
                 if (result.jsonInfusionData[M].STATUS == "C") {
                     $("#" + AllGrid[colno]).jqGrid('setRowData', (M + 1), false, 'cancellation');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom').hide()
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Omit', false, 'avoid-clicks');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(14)').addClass('avoid-clicks');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(6)').addClass('avoid-clicks');
                 }


                 if (result.jsonInfusionData[M].HighAlert == "Y") {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td').addClass('HighAlertDrug');
                     //$("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(6)').addClass('avoid-clicks');
                 }
                 if (gact == 'N') {
                     strDate = $('#txtTransDate').val();
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedDate', strDate);
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedTime', SetServerTime());
                 }
                 else {
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedDate', result.jsonInfusionData[M].ORDDATE);
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedTime', result.jsonInfusionData[M].ORDTIME);
                 }

                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'SQNumber', result.jsonInfusionData[M].SEQNO);


             }
             AddBlankRowToTable(grid, AllGrid[4], 1);         //vishal 23rd Feb 2019
             if (gact == "E") {
                 $('#txtRemarks').val(result.jsonDetailsData[0].REMARK.toString().trim());
             }

         }
        
         function load_InfusionData() {
             var s;
             $.ajax({
                 url: '../ICUMob/GetInfusionData',
                 data: {},
                 type: 'get',
                 async: false,
                 success: function (data) {
                     globalInfusionData = data;
                 }
             });
         }
       

         function JQGridInfusion() {
             var grid = $("#JqGridInfusion");

             jQuery("#JqGridInfusion").jqGrid({
                 datatype: 'local',
                 colNames: ['', 'Intravenous Infusions', 'Dose / Dilution', 'Infusion Rate', 'High Alert', 'Start Time', 'End Time', 'TypeCode', 'Order By', 'Order Date', 'Order Time', 'Sequence No', 'RemarK',
                            'Omit', 'Omit / Cancel By', 'Omit / Cancel Date', 'Omit / Cancel Time', 'NotifyYN', 'Status', 'ADMINYN', 'INFCODE'],
                 colModel: [
                          {
                              name: 'action', index: 'action', width: 25, fixed: true, sortable: false, resize: false, search: false,
                              formatoptions: { editbutton: false, delbutton: false, keys: true },
                              formatter: 'actions', searchoptions: { clearSearch: false }
                          },

                       {
                           name: 'Infusion', index: 'Infusion', width: 300, sortable: false, align: 'left', editable: true, editoptions: {
                               size: 20,
                               dataInit: function (el) {

                                   $(el).autocomplete({
                                       source: $.map(globalInfusionData, function (item) {
                                           return { label: item.Text, value: item.Text, Code: item.Value, Dose: item.Dose, InfusionRate: item.InfusionRate, HighAlert: item.HighAlert };
                                       }),
                                       select: function (event, ui) {
                                           var rowId = grid.jqGrid('getGridParam', 'selrow');
                                           grid.jqGrid('setCell', rowId, 'Dose', ui.item.Dose);
                                           grid.jqGrid('setCell', rowId, 'INFCODE', ui.item.Code);
                                           grid.jqGrid('setCell', rowId, 'InfusionRate', ui.item.InfusionRate);
                                           if (ui.item.HighAlert == "Y") {
                                               var check = $("#JqGridInfusion").find("#" + Number(rowId) + " input[type=checkbox]");
                                               //check[0].attr('checked', 'checked');
                                               check[0].checked = true;
                                               $("#JqGridInfusion").find('tr#' + rowId).find('td').addClass('HighAlertDrug');
                                           }
                                           //console.log("Selected: " + ui.item.value + " aka " + ui.item.label + " Dose: " + ui.item.Dose);
                                       }
                                   });
                                   $(el).width(260);
                               }
                           },
                       },
                     {
                         name: 'Dose', index: 'Dose', width: 130, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 20, },
                     },
                       { name: 'InfusionRate', index: 'InfusionRate', width: 130, sortable: false, align: 'left', editable: true, editoptions: { maxlength: 50, }, },
                       {
                           name: 'HighAlert', index: 'HighAlert', align: "center", width: 58,
                           edittype: 'checkbox', editoptions: { value: "Y:N" },
                           formatter: "checkbox", formatoptions: { disabled: false }, sortable: false,
                       },
                        {
                            name: 'StartTime', index: 'StartTime', width: 100, sortable: false, align: 'left', editable: true, editoptions: { readonly: "readonly" }, hidden: true,
                            editoptions: {
                                size: 20,
                                dataInit: function (el) {
                                    $(el).timepicker({
                                        ampm: true,
                                        timeFormat: 'hh:mm TT',
                                    })
                                    $('.ui-datepicker-close').removeAttr('class');
                                }
                            },
                        },
                        {
                            name: 'EndTime', index: 'EndTime', width: 100, sortable: false, align: 'left', editable: true, hidden: true,
                            editoptions: {
                                size: 20,
                                dataInit: function (el) {
                                    $(el).timepicker({
                                        ampm: true,
                                        timeFormat: 'hh:mm TT',
                                    })
                                    $('.ui-datepicker-close').removeAttr('class');
                                }
                            },
                        },
                         { name: 'TypeCode', index: 'TypeCode', width: 10, sortable: false, align: 'right', hidden: true },
                                GetOrderedByColumn, GetOrderedDateColumn, GetOrderedTimeColumn, GetDrugSequenceNo(), GetRemakCol, GetOmitCol, getOmittedByColumn(), getOmittedDateColumn(), getOmittedTimeColumn(),
                    GetNotifyYN(), GetStatus(), GetADMINYN(),
                    { name: 'INFCODE', index: 'INFCODE', width: 10, sortable: false, align: 'right', hidden: true },

                 ],
                 sortname: 'id',
                // width: (TabBodyWidth + 5),
                 //footerrow: true,
               //  height: (Contentheight - 190),
                 viewrecords: true,
                 sortorder: "desc",
                 loadtext: 'Loading...',
                 loadonce: true,
                 rownumbers: true,
                 // toolbar: [true, "top"],
                 shrinkToFit: false,
                 cellEdit: true,
                 cellsubmit: 'clientArray',
                 ignoreCase: true,
                 scrollrows: true,
                 onCellSelect: function (rowid, iCol, cellcontent, e) {
                     var cm = jQuery('#JqGridInfusion').jqGrid("getGridParam", "colModel");

                     if (IsrolloverData == "Y") {
                         cm[iCol].editable = false;

                     }
                     else {
                         if (IsrolloverData = 'N') {
                             if (cm[iCol] == 1 || cm[iCol] == 6 || cm[iCol] == 7 || cm[iCol] == 8) {
                                 cm[iCol].editable = false;
                             }
                             else if (iCol == 2) {
                                 cm[iCol].editable = true;
                             }

                         }
                         else {

                         }
                     }

                 },
                 loadComplete: function () {
                     
                     jQuery("#JqGridInfusion").jqGrid('clearGridData');
                     var len = 1;
                     for (var i = 1; i <= len; i++) {
                         var adddata = {
                             Infusion: "", InfusionRate: "", StartTime: "", EndTime: "", TypeCode: "IN", OrderedBy: '', OrderedDate: '', OrderedTime: '', STATUS: "A", ADMINYN: "N",
                         }
                         $("#JqGridInfusion").jqGrid("addRowData", i, adddata);
                     }

                     var grid = $('#JqGridInfusion');
                     var iCol = getColumnIndexByName(grid, 'action');
                     $(this).find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 14) + ")").addClass('avoid-clicks');

                     $(this).find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 1) + ")")
                     .each(function () {
                         var tr = $(this).closest("tr.jqgrow");
                         l_orowId = $(tr).attr("id");
                         var rowData = grid.jqGrid('getRowData', l_orowId);
                         if (gact == "N") {                                           ///added by vishal on 21st Sept 2018
                             AddDelButtonByNew(grid, l_orowId);
                         }
                         //$("<div>", {
                         //    title: "Delete",
                         //    mouseover: function () {
                         //        $(this).addClass('ui-state-hover');
                         //    },
                         //    mouseout: function () {
                         //        $(this).removeClass('ui-state-hover');
                         //    },
                         //    click: function (e) {
                         //        l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                         //        grid.delRowData(l_orowId);
                         //    }
                         //}
                         //).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
                         //     .addClass("ui-pg-div ui-inline-custom")
                         //     .append('<span class="ui-icon ui-icon-trash"></span>')
                         //     .prependTo($(this).children("div"));

                         //if (gact == "E") {
                         //    $("<div>", {
                         //        title: "Cancel",
                         //        mouseover: function () {
                         //            $(this).addClass('ui-state-hover');
                         //        },
                         //        mouseout: function () {
                         //            $(this).removeClass('ui-state-hover');
                         //        },
                         //        click: function (e) {
                         //            rowObj = $(e.target).closest("tr.jqgrow")
                         //            l_orowId = rowObj.attr("id");
                         //            var rowData = grid.jqGrid('getRowData', l_orowId);
                         //            if (CheckINFAdministedData(rowData.SQNumber, "IN") === true) {
                         //                MsgDia("This Medicine is Administered.You can not cancel.Only Omitting is allowed.", "Information");
                         //            }
                         //            else {
                         //                custom_alertprint("Are you sure you want to cancel this record?", "Medicine Cancellation", rowData, grid, l_orowId, rowObj);
                         //            }
                         //        }
                         //    }
                         //    ).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
                         //         .addClass("ui-pg-div ui-inline-custom")
                         //         .append('<span class="ui-icon ui-icon-cancel"></span>')
                         //         .prependTo($(this).children("div"));
                         //}
                     });
                     if (IsOnlyDisplay) {
                         $(this).jqGrid('hideCol', ["action"]);
                     }
                     else {
                         $(this).jqGrid('showCol', ["action"]);
                     }

                     var gt = $("input[name='Infusion']");

                     $(gt).keyup(function () {
                         var a = e.currentTarget.value.trim().toUpperCase();
                         e.currentTarget.value = a;
                     });
                     //$("#JqGridInfusion").jqGrid('setColProp', 'Remark', { width: '200' });
                 },

                 afterEditCell: function (rowid, name, val, iRow, iCol) {
                     if (name == 'Infusion' || name == 'Dose' || name == 'InfusionRate' || name == 'Remark') {
                         $("#" + iRow + "_" + name).bind('keyup', function (e) {
                             var a = e.currentTarget.value.toUpperCase();
                             e.currentTarget.value = a;
                         });
                     }
                     $("#" + iRow + "_" + name).bind('blur', function () {
                         $('#JqGridInfusion').saveCell(iRow, iCol);
                     });
                 },
                 beforeSelectRow: function (rowid, e) {
                     var rowData = $('#JqGridInfusion').jqGrid('getRowData', rowid);
                     if (rowData['HighAlert'] == "Y") {
                         $("#JqGridInfusion").find('tr#' + rowid).find('td').addClass('HighAlertDrug');
                     }
                     else {
                         $("#JqGridInfusion").find('tr#' + rowid).find('td').removeClass('HighAlertDrug');
                     }

                     if (rowData['Omit'] == "Y") {
                         $($('#JqGridInfusion').find('tr#' + rowid).find('td:nth-child(2) div.ui-inline-custom')[0]).hide();
                         $('#JqGridInfusion').jqGrid('setCell', rowid, 'OmittedBy', userid);
                         $('#JqGridInfusion').jqGrid('setCell', rowid, 'OmittedDate', GetTodaysDate());
                         $('#JqGridInfusion').jqGrid('setCell', rowid, 'OmittedTime', GetTimewithAMPM());
                         $('#JqGridInfusion').find('tr#' + rowid).addClass('Omited');
                     }
                     else {
                         if (rowData['Omit'] == "N") {
                             $($('#JqGridInfusion').find('tr#' + rowid).find('td:nth-child(2) div.ui-inline-custom')[0]).show();
                             $('#JqGridInfusion').jqGrid('setCell', rowid, 'OmittedBy', null);
                             $('#JqGridInfusion').jqGrid('setCell', rowid, 'OmittedDate', null);
                             $('#JqGridInfusion').jqGrid('setCell', rowid, 'OmittedTime', null);
                             $('#JqGridInfusion').find('tr#' + rowid).removeClass('Omited');
                         }
                     }


                     return true; // allow selection
                 },



                 afterSaveCell: function (rowid, name, val, iRow, iCol) {
                     var MaxSEQNO = "";
                     var grid = $('#JqGridInfusion');
                     var rowData = $('#JqGridInfusion').getRowData();
                     var cuurenRow = $('#JqGridInfusion').getRowData(rowid);
                     var Typecode = GetTypeCode('JqGridInfusion');
                     GetItem = jQuery.grep(rowData, function (n, i) {
                         return (n["Infusion"] != "");
                     });
                     if (name == "Infusion" && val == "") {
                         grid.jqGrid('setCell', rowid, 'OrderedBy', null);
                         grid.jqGrid('setCell', rowid, 'OrderedDate', null);
                         grid.jqGrid('setCell', rowid, 'OrderedTime', null);
                         //   $('#JqGridInfusion').jqGrid('setCell', rowid, 'SQNumber', null);
                         grid.jqGrid('setCell', rowid, 'HighAlert', "N");
                     }
                     else if (name == "Infusion") {
                         grid.jqGrid('setCell', rowid, 'OrderedBy', userid);
                         grid.jqGrid('setCell', rowid, 'OrderedDate', GetTodaysDate());
                         grid.jqGrid('setCell', rowid, 'OrderedTime', GetTimewithAMPM());
                         grid.jqGrid('setCell', rowid, 'NOTIFYN', 'N');

                         AddDelButtonByNew(grid, rowid);
                         if (cuurenRow.SQNumber == "") {
                             MaxSEQNO = GetMaxSEQNO('JqGridInfusion');
                             if (MaxSEQNO.length > 0) {
                                 $('#JqGridInfusion').jqGrid('setCell', rowid, 'SQNumber', (Number(MaxSEQNO[0].Column1) + 1));
                                UpdateMaxSEQNOArray(Typecode, (Number(MaxSEQNO[0].Column1) + 1));
                             }
                             else {
                                 $('#JqGridInfusion').jqGrid('setCell', rowid, 'SQNumber', Number(GetItem.length));
                                 AddDataToMaxArray(Typecode, GetItem.length);
                             }
                         }

                         if (cuurenRow.HighAlert == "N")
                             custom_alertInfusion("Is this high alert Infusion ?", 'Confirmation', rowid);

                     }

                     if (name == 'Dose') {
                         if (cuurenRow.INFCODE != "")
                             MsgDia("Are you sure want to modify Dose", "Information");
                     }
                 },
                 gridComplete: function () {
                     var data = jQuery("#JqGridInfusion").jqGrid('getRowData');
                     if (data.length > 1) {
                         for (var c = 1; c < data.length; c++) {
                             if (data[c]["Omit"] == "N" && data[c]["ADMINYN"] == "N" && data[c]["NOTIFYN"] == "N") {
                                 var check = $("#JqGridInfusion").find("#" + Number(c + 1) + " input[type=checkbox]");
                                 check.attr('disabled', 'disabled');
                                 jQuery("#JqGridInfusion").jqGrid('setCell', Number(c + 1), 'Omit', '', 'not-editable-cell');
                             }
                             else {
                                 //$('#JqGridAntibiotics').find('tr#' + 4).find('input[type=checkbox]').attr('disabled', false);
                             }
                         }
                     }


                 }


             }).trigger("reloadGrid");
             //  $('.ui-jqgrid-bdiv').height(Contentheight);
         
             var winHeight = $(window).height();

             // otherHeights = $('#mainHeaderHight').height() + 150;
         
             var newWidth = $(window).width();
             $("#JqGridInfusion").jqGrid("setGridWidth", newWidth - $('#PatListPanelDiv').width() - 80, false);
             $("#JqGridInfusion").jqGrid("setGridHeight", winHeight - $('#mainHeaderHight').height() - 200, true);

         
         }
   

         function custom_alertInfusion(output_msg, title_msg, rowid) {
             if (!title_msg)
                 title_msg = 'Confirmation';
             if (!output_msg)
                 output_msg = 'No Message to Display.';
             $("#lblCustomAlert").text(output_msg);
             $("#Customalert").dialog({
                 title: title_msg,
                 resizable: false,
                 modal: true,
                 buttons: {
                     "Yes": function () {
                         $(this).dialog("close");
                         $('#JqGridInfusion').jqGrid('setCell', rowid, 'HighAlert', "Y");
                         $("#JqGridInfusion").find('tr#' + rowid).find('td').addClass('HighAlertDrug');
                     },
                     "No": function () {
                         $(this).dialog("close");
                         $('#JqGridInfusion').jqGrid('setCell', rowid, 'HighAlert', "N");
                         $("#JqGridInfusion").find('tr#' + rowid).find('td').removeClass('HighAlertDrug');
                     },
                 }
             });
         }

         </script>
</asp:Content>
