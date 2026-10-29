<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.IVsupplement>" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <div class="container-fluid">
  <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
       
   
    
     
 <table style="width: 70%;margin: 1% 0 1% 0;" id="infotab"><!--kavita-->
                <tr>
                    <td rowspan="2">
                        <label style=" display: inline-block;">Provisional Diagnosis</label>
                       
                        <%=Html.TextAreaFor(x => Model.ProvDiagno, new { id = "txtProvDiagno", @class = "TextBxFormat", maxlength = "1000", Style = "width:330px;height:30px;vertical-align: middle;",@rows = "5",@readonly="True"})%></td>
                    <td rowspan="2">
                        <label style=" display: inline-block;">Allergies</label>
                        
                        <%: Html.TextAreaFor(x => Model.Allergies, new { id = "txtAllergies", @class = "TextBxFormat", maxlength = "1000", Style = "width:340px;height:30px;vertical-align: middle;",@rows = "5" ,@readonly="True"})%>
                    </td>
                  <%--  vishal 16th Nov--%>
                     <td>                    <%--<input type="button" id="btnCancelShwHide" class="Nbutton" value ="" />--%>
                       
                         <%-- <button id="btnSearch" class="btn btn-primary" style="background-color: #337ab7; border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>--%>
                   <input type="button" id="btnCancelShwHide" class="btn btn-primary" value ="" style="background-color: #337ab7; border-color: #2e6da4;"/>
                       
                           </td>
                </tr>
            </table>
   </div>
        
    <div class="row" style="margin-left: -10px !important;margin-right: 0px !important;width:100% !important" id="rowWidth">    
        
       
         
                      
                <table id="JqGridSpeciaInstructions" style="" class="respiratoryData">
                </table>
             
                 
         
             <div class="col-md-12">                        
            <table id="tblNoDataFound" style="width:100%;line-height:2.5">                
            </table>
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
        </div>
     
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
   
     <link href="../../jqGrid/css/JQGTableStyle.css" rel="stylesheet" />
     <script src="../Scripts/ICUPatList.js"></script>
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

     </style>
     <script type="text/javascript">
         var dt1 = "Date1";
         var dt2 = "Date2";
         var winHeight;
         var otherHeights;
         var MediciTypeLStr = '';
         var IsOnlyDisplay = false;
         var Groupcolumn = false;
         var IsrolloverData = 'N';
         var gact = "N";
         var ServerTime = '<%=ViewBag.CurrServerTime %>';
         var ServerDate = '<%=ViewBag.CurrServerDate %>';
         $(document).ready(function () {
             winHeight = $(window).height();

             otherHeights = $('#mainHeaderHight').height() + 150;
             ActiveMenu("IVsuplement");

           //  SetDateTime();
             GetNursStationsNPAtients();
             $("#tabMenu").css("display", "block");

             if ($(window).width() >= 1025) {                                            //screen width size comparion
                 var menuL = document.getElementById('menuList');
                 menuL.style.display = "block";




             }
             SetPatientDtl();
             JQGridGetSpecialInst();

             $("#btnSearch").click(function () {
                 JQGridGetSpecialInst();
             });
             addButtonSpecialInst();

             GetTreat();
             if (resultofal != null && resultofal != "")
                 SetGridDataSpecilInst(resultofal);

            
             $("#btnSave").click(function () {
                 SaveIVsuplement("N");
             

             
             });
             jQuery(document).ready(function ($) {

                 if (window.history && window.history.pushState) {

                     window.history.pushState('forward', null, './IVsuplement');

                     $(window).on('popstate', function () {

                         // $("#btnSave").trigger("click");
                         if (stopProp)
                             SaveIVsuplement("Y");
                     });

                 }
             });
         });

         $(window).on("load", function () {
             var newWidth = $(window).width();
             $("#JqGridSpeciaInstructions").jqGrid("setGridWidth", newWidth - $('#PatListPanelDiv').width() - 50, false);
             $("#JqGridSpeciaInstructions").jqGrid("setGridHeight", winHeight - $('#mainHeaderHight').height() - 260, true);
         });
         function SaveIVsuplement(st) {
             currtabIndx = "";
             IpNo = '' + $.session.get('ICUPatIPNO');
             MrNo = '' + $.session.get('ICUPatMRNO');
             PatName = '' + $.session.get('ICUPatName');
             var currtabIndx = localStorage.getItem("CurrentTabIndex");

             for (l = 0; l < AllGrid.length; l++) {
                 var ids = jQuery("#" + AllGrid[l]).jqGrid('getDataIDs');
                 for (var i = 1; i <= ids.length; i++) {
                     $("#JqGridSpeciaInstructions").jqGrid("editCell", 0, 0, false);
                 }
             }
             // AMPMConvert();

             var JqGridSpeciaInstructionsData = $("#JqGridSpeciaInstructions").getRowData();



             JqGridSpeciaInsFilterData = jQuery.grep(JqGridSpeciaInstructionsData, function (n, i) {
                 return (n.DrugName != "");
             });

             if (JqGridSpeciaInsFilterData.length > 0) {
                 for (var i = 0; i < JqGridSpeciaInsFilterData.length; i++) {
                     if (gact == 'N') {
                         // JqGridSpeciaInsFilterData[i].SQNumber = (i + 1);
                     }
                     JqGridSpeciaInsFilterData[i].DrugName = JqGridSpeciaInsFilterData[i].DrugName.replace(/&/g, "%26");
                     if (JqGridSpeciaInsFilterData[i].DrugName.trim() == "" || JqGridSpeciaInsFilterData[i].DilutionVolume.trim() == "" || JqGridSpeciaInsFilterData[i].INFRATE.trim() == "") {
                         SetactiveTab(3, "IV Fuid/TPN column in table : IV Suplement,Volume and Infusion rate which should not be empty");
                         return false;
                     }
                 }
             }




             ///Added by vishal as on 1st Oct 2018
             if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
                 gact = "N";
             }
             else {
                 gact = "E";
             }


             var tableSpeciaInstructionsData = JSON.stringify(JqGridSpeciaInsFilterData)


             $("#TreatmentSheetForm").find(':input:disabled').removeAttr('disabled');
             formData = $("#TreatmentSheetForm").serialize() + '&&action=' + gact + '&&tableSpeciaInstructionsData=' + tableSpeciaInstructionsData + '&&IpNo=' + IpNo + '&&MrNo=' + MrNo + '&&PatName=' + PatName + '&&TranctionId=' + $('#tractiondropdown').val() + '&&Prov=' + $('#txtProvDiagno').val() + '&&Allergy=' + $('#txtAllergies').val()
             var SaveUrl = "../ICUMob/SaveTreatmentIVSuplmnt";
             jQuery('body').find('#resultLoading').remove();
             //  ajaxindicatorstart('Saving data.. please wait..');
             $.ajax({
                 type: "POST",
                 url: SaveUrl,
                 data: formData,
                 dataType: "json",
                 cache: false,
                 success: function (response) {
                     // ajaxindicatorstop();
                    // MsgDia(response, "Information");
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
                                 $('#tractiondropdown').val(TranNo);
                             }
                         }
                        // var CurrTab = localStorage.getItem('CurrentTabIndex');
                         //if (Number(CurrTab) != 6) {
                         //    SetValidateTabIndex(Number(CurrTab) + 1);
                         //    tabseq = Number((tabseq) + 1);
                         //}
                         GetTreat();
                         if (resultofal != null && resultofal != "")
                             SetGridDataSpecilInst(resultofal);


                         if (!resultofal.hasOwnProperty("jsonMedicineData") || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                             window.location.href = '../ICUMob/NonDrugOrder';
                         } else if (st.toString().trim() != "Y")
                             MsgDia(response, "Information");



                     } else {
                         MsgDia(response, "Error");
                         return false
                     }
                     //if (typeof resultofal.jsonDetailsData == "undefined" || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == null || resultofal.jsonDetailsData[0].HGT.toString().trim() == null || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == null) {

                     //    window.location.href = '../ICUMob/NonDrugOrder';
                     //}

                 },
                 complete: function () {
                     //  GetTreatmentSheetData('', gact, IpNo);            ///added by vishal as on 20th Sept 2018

                    

                    

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
         //IV Fluid Grid

         function SetGridDataSpecilInst(result) {
             if (ISRYN == "Y") {
                 for (var i = 0; i <= result.jsonSpecilInstData.length - 1; i++) {
                     result.jsonSpecilInstData[i]["ADMINYN"] = "";
                 }
             }
             grid = $("#" + AllGrid[2]);
             grid.jqGrid('clearGridData');
             var recordsCnt = grid.jqGrid('getGridParam', 'records');
             if (recordsCnt < result.jsonSpecilInstData.length) {
                 AddBlankRow(grid, recordsCnt, result.jsonSpecilInstData.length, AllGrid[2]);
             }

             for (var M = 0; M < result.jsonSpecilInstData.length; M++) {
                 var colno = 2
                 if (DayofDurgsTodaysChk) {
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DayOfDrug', parseInt(result.jsonSpecilInstData[M].DayOfDrug));
                 }
                 else {
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DayOfDrug', parseInt(result.jsonSpecilInstData[M].DayOfDrug) + 1);
                 }
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Dose', result.jsonSpecilInstData[M].Dose);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DrugCode', result.jsonSpecilInstData[M].DrugCode);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DrugName', result.jsonSpecilInstData[M].DrugName);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Freq', result.jsonSpecilInstData[M].Freq);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Omit', result.jsonSpecilInstData[M].Omit);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Route', result.jsonSpecilInstData[M].Route);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Type', result.jsonSpecilInstData[M].Type);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'TypeCode', result.jsonSpecilInstData[M].TypeCode);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Remark', result.jsonSpecilInstData[M].Remark);

                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DilutionVolume', result.jsonSpecilInstData[M].DILVOLUME);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'AdminstrDuration', result.jsonSpecilInstData[M].ADMINDUR);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'SpiDGSTARTDATE', result.jsonSpecilInstData[M].STARTFRMDT);

                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedBy', result.jsonSpecilInstData[M].ORDERBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedDate', result.jsonSpecilInstData[M].ORDDATE);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedTime', result.jsonSpecilInstData[M].ORDTIME);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedBy', result.jsonSpecilInstData[M].OMITBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedDate', result.jsonSpecilInstData[M].OMITDT);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedTime', result.jsonSpecilInstData[M].OMITTM);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'SQNumber', result.jsonSpecilInstData[M].SEQNO);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'HighAlert', result.jsonSpecilInstData[M].HighAlert);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'INFRATE', result.jsonSpecilInstData[M].INFRATE);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'MACROSET', result.jsonSpecilInstData[M].MACROSET);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'MICROSET', result.jsonSpecilInstData[M].MICROSET);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'NOTIFYN', result.jsonSpecilInstData[M].NOTIFYN);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'STATUS', result.jsonSpecilInstData[M].STATUS);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'ADMINYN', result.jsonSpecilInstData[M].ADMINYN);

                 if (result.jsonSpecilInstData[M].HighAlert == "Y") {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td').addClass('HighAlertDrug');
                 }


                 if (result.jsonSpecilInstData[M].Omit == "Y") {
                     $("#" + AllGrid[colno]).jqGrid('setRowData', (M + 1), false, 'Omited');// Assign CSS class to row
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).addClass('avoid-clicks');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(17) input').attr("disabled", true);
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom').hide();
                 }
                 else {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(17)').removeClass('avoid-clicks');
                 }

                 /*--------------------IF RECORD IS ADDMINISTERED THEN lOCK THE EDITING----------------------------------------------*/

                 if (result.jsonSpecilInstData[M].ADMINYN == "Y" || result.jsonSpecilInstData[M].STATUS == "C") {
                     $($("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom')[0]).hide()

                    // for (var a = 1; a <= 28; a++) {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).addClass('avoid-clicks');
                     //}
                 }
                 else {
                     if (gact == "N") {
                         AddDelButtonByNew(grid, (M + 1)) //ADDING DELETE BUTTON ON NEW MODE ONLY WHEN THE RECORD IS NOT ADDMINISTED
                     }
                     else if (gact == "E") {
                         AddCancelBtn(grid, M);       //ADDING CANCEL BUTTON ON EDIT MODE ONLY WHEN THE RECORD IS NOT ADDMINISTED
                     }
                 }

                 if (result.jsonSpecilInstData[M].STATUS == "C") {
                     $("#" + AllGrid[colno]).jqGrid('setRowData', (M + 1), false, 'cancellation');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom').hide()
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Omit', false, 'avoid-clicks');
                 }

                 if (gact == "E") {
                     $($("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom')[1]).hide()
                 }
                 if (IsPastDate) {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(17) input').attr("disabled", true);
                 }

                 else {
                     if (result.jsonSpecilInstData[M].Omit != "Y") {
                         $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(17) input').attr("disabled", false);
                     }
                 }
                 if (gact == "N") {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(15)').addClass('avoid-clicks');
                 }
                 //for (var a = 1; a <= 28; a++) {
                 //    $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(' + a + ')').addClass('avoid-clicks');
                 //}
             }
             AddBlankRowToTable(grid, AllGrid[2], 1);         //vishal 23rd Feb 2019
         }
         function JQGridGetSpecialInst() {
             jQuery("#JqGridSpeciaInstructions").jqGrid({
                 datatype: 'local',
                 colNames: ['', 'Day', 'Duration', 'Type', 'Dose', 'Route', 'Freq', 'Diluent', 'IV Fluids / TPN', 'Remark', 'Vol / ml', 'INFUSION RATE (ml/hr)', 'Dur.of Admn(hrs)', 'MACRO SET', 'MICRO SET', 'Start Date', 'High Alert', 'Omit', 'SpecialInstDrugsCode', 'TypeCode', 'Omit / Cancel By', 'Omit / Cancel Date', 'Omit / Cancel Time', 'Order By', 'Order Date', 'Order Time', 'Sequence No', 'NotifyYN', 'Status', 'ADMINYN'],
                 //colModel: GetSpeciaInstructionsColumn(),
                 colModel: [
                       {
                           name: 'action', index: 'action', width: 25, fixed: true, sortable: false, resize: false, search: false,
                           formatoptions: { editbutton: false, delbutton: false, keys: true },
                           formatter: 'actions', searchoptions: { clearSearch: false }
                       },
                       {
                           name: 'DayOfDrug', index: 'DayOfDrug', width: 70, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }, hidden: true,
                       },
                       {
                           name: 'Duration', index: 'Duration', width: 50, sortable: false, editable: true, hidden: true,
                       },
                        {
                            name: 'Type', index: 'Type', width: 40, align: "left", sortable: true, editable: true, searchoptions: { clearSearch: false }, hidden: true,
                            edittype: 'select',
                            editoptions:
                                {
                                    value: MediciTypeLStr,
                                    dataInit: function (el) {
                                        $(el).css("width", "40")
                                    }
                                }
                        },
                          {
                              name: 'Dose', index: 'Dose', width: 50, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 20, }, hidden: true,
                          }, {
                              name: 'Route', index: 'Route', width: 60, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, edittype: 'select', hidden: true,
                              editoptions:
                              {
                                  value: '',
                                  dataInit: function (el) {
                                      $(el).css("width", "60")
                                  }
                              }
                          },
                    {
                        name: 'Freq', index: 'Freq', width: 50, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }, hidden: true,
                    },
                     {
                         name: 'Diluent', index: 'Diluent', width: 50, sortable: false, editable: false, hidden: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, },
                     },
                   {
                       name: 'DrugName', index: 'DrugName', width: 210, sortable: false, editable: true
                   },

                  
                    {
                        name: 'Remark', index: 'Remark', width: 160, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: {
                            maxlength: 60,
                            dataInit: function (elem) { $(elem).focus(function () { this.select(); }) },
                            dataEvents: [
                                                {
                                                    type: 'keydown',
                                                    fn: function (e) {
                                                        var key = e.charCode || e.keyCode;
                                                        if (key == 9)   // tab
                                                        {
                                                            var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                                            jQuery("#JqGridSpeciaInstructions").jqGrid("editCell", Number(rowId), 7, true).focus();
                                                        }

                                                    }
                                                },
                          
                            ]
                        },
                    },
                   
                      {
                          name: 'DilutionVolume', index: 'DilutionVolume', width: 60, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
                          //edittype: 'select',
                          //editoptions:
                          //    {
                          //        value: strGlobDilutionVol,
                          //        dataInit: function (el) {
                          //            $(el).css("width", "70px")
                          //            $(el).change(function () {
                          //                var DilVol = $(el).val();
                          //                var rowobject = $(el).parent('td').parent('tr');
                          //                rowId = $(rowobject).attr('id');
                          //                cuurenRow = $('#JqGridSpeciaInstructions').getRowData(rowId);

                          //                var INFRate = cuurenRow.INFRATE
                          //                var AdminDur = cuurenRow.AdminstrDuration
                          //                var Volume = Number(DilVol.replace(/[^0-9]+/ig, ""))
                          //                if (INFRate != "" && Volume != "" && Volume != " ") {
                          //                    var duration = Volume / Number(INFRate)
                          //                    $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'AdminstrDuration', Math.round(duration));

                          //                    /*------------------MA Droprate--------------------------*/

                          //                    var MADropRate = Number(Volume * 20) / Number(duration * 60);
                          //                    $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));

                          //                    /*------------------MI Droprate--------------------------*/

                          //                    var MIDropRate = Number(Volume * 60) / Number(duration * 60);
                          //                    $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'MICROSET', Math.round(MIDropRate));
                          //                }
                          //                else if (AdminDur != "" && Volume != "" && Volume != " " && AdminDur > 0) {

                          //                    var InfRate = Volume / Number(AdminDur)
                          //                    $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'INFRATE', Math.round(InfRate));

                          //                    /*------------------MA Droprate--------------------------*/

                          //                    var MADropRate = Number(Volume * 20) / Number(AdminDur * 60);
                          //                    $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));

                          //                    /*------------------MI Droprate--------------------------*/

                          //                    var MIDropRate = Number(Volume * 60) / Number(AdminDur * 60);
                          //                    $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'MICROSET', Math.round(MIDropRate));
                          //                }
                          //            })
                          //        }
                          //    }
                          editoptions:
                             {
                                 dataInit: function (el) {
                                     $(el).css("width", "70px")
                                     $(el).keypress(function (event) {
                                         //$(this).val($(this).val().toUpperCase());
                                         if ((event.which != 8 && isNaN(String.fromCharCode(event.which))) || (event.which == 32)) {
                                             event.preventDefault();
                                         }
                                     });

                                 }
                                
                             },
                      },
                       {
                           name: 'INFRATE', index: 'INFRATE', width: 100, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: {
                               maxlength: 50, dataInit: function (el) {
                                   $(el).keypress(function (event) {
                                       //$(this).val($(this).val().toUpperCase());
                                       if (event.which != 8 && isNaN(String.fromCharCode(event.which))) {
                                           event.preventDefault();
                                       }
                                       if (event.which == 32) {
                                           event.preventDefault();
                                       }
                                   });

                                   $(el).keyup(function (event) {
                                       if ($(el).val() != "") {
                                           var infRate = $(el).val();
                                           var rowobject = $(el).parent('td').parent('tr');
                                           rowId = $(rowobject).attr('id');
                                           cuurenRow = $('#JqGridSpeciaInstructions').getRowData(rowId);
                                           var dilVolum = cuurenRow.DilutionVolume
                                           if (dilVolum != "" && infRate != "" && dilVolum != " ") {
                                               var Volume = Number(dilVolum.replace(/[^0-9]+/ig, ""))
                                               var duration = Volume / Number(infRate)
                                               $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'AdminstrDuration', Math.round(duration));
                                               /*------------------MA Droprate--------------------------*/

                                               var MADropRate = Number(Volume * 20) / Number(duration * 60);
                                               $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));

                                               /*------------------MI Droprate--------------------------*/

                                               var MIDropRate = Number(Volume * 60) / Number(duration * 60);
                                               $('#JqGridSpeciaInstructions').jqGrid('setCell', rowId, 'MICROSET', Math.round(MIDropRate));
                                           }
                                       }
                                   });
                               },
                           }, hidden: false,
                       },
                    {
                        name: 'AdminstrDuration', index: 'AdminstrDuration', hidden: false, width: 95, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
                        editoptions:
                            {
                                dataInit: function (el) {
                                    grid = $('#JqGridSpeciaInstructions')
                                    $(el).keypress(function (event) {
                                        ////$(this).val($(this).val().toUpperCase());
                                        //if (event.which != 8 && isNaN(String.fromCharCode(event.which))) {
                                        //    event.preventDefault();
                                        //}
                                        //if (event.which == 32) {
                                        //    event.preventDefault();
                                        //}
                                        if (((event.which != 46 || (event.which == 46 && $(this).val() == '')) ||
                                           $(this).val().indexOf('.') != -1) && (event.which < 48 || event.which > 57)) {
                                            event.preventDefault();
                                        }
                                    });

                                    $(el).keyup(function (event) {
                                        if ($(el).val() != "") {
                                            var admindur = $(el).val();
                                            var rowobject = $(el).parent('td').parent('tr');
                                            rowId = $(rowobject).attr('id');
                                            cuurenRow = grid.getRowData(rowId);
                                            var dilVolum = cuurenRow.DilutionVolume
                                            var Volume = Number(dilVolum.replace(/[^0-9]+/ig, ""))
                                            if (Volume != "" && admindur != "" && Volume != " " && Volume > 0 && admindur > 0) {
                                                var InfRate = Volume / Number(admindur)
                                                grid.jqGrid('setCell', rowId, 'INFRATE', Math.round(InfRate));
                                                /*------------------MA Droprate--------------------------*/

                                                var MADropRate = Number(Volume * 20) / Number(admindur * 60);
                                                grid.jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));

                                                /*------------------MI Droprate--------------------------*/

                                                var MIDropRate = Number(Volume * 60) / Number(admindur * 60);
                                                grid.jqGrid('setCell', rowId, 'MICROSET', Math.round(MIDropRate));
                                            }
                                            else {
                                                grid.jqGrid('setCell', rowId, 'INFRATE', null);
                                                grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                                grid.jqGrid('setCell', rowId, 'MICROSET', null);
                                            }
                                        }
                                        else {
                                            grid.jqGrid('setCell', rowId, 'INFRATE', null);
                                            grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                            grid.jqGrid('setCell', rowId, 'MICROSET', null);
                                        }
                                    });
                                },
                            }
                    },

                    {
                        name: 'MACROSET', index: 'MACROSET', width: 90, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 20, }, hidden: false,
                    },
                      {
                          name: 'MICROSET', index: 'MACROSET', width: 90, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 20, }, hidden: false,
                      },

                    {
                        name: 'SpiDGSTARTDATE', index: 'SpiDGSTARTDATE', width: 80, sortable: false, align: 'left', editable: true, formatter: 'date', formatoptions: { newformat: 'd/m/Y' },
                        editoptions: {
                            size: 20,
                            dataInit: function (el) {
                                $(el).datepicker({
                                    dateFormat: "dd/mm/yy",
                                    changeMonth: true,
                                    changeYear: true,
                                    minDate: new Date(),
                                }).mask("99/99/9999");
                            }
                        }
                    },
                     {
                         name: 'HighAlert', index: 'HighAlert', align: "center", width: 55,
                         edittype: 'checkbox', editoptions: { value: "Y:N" },
                         formatter: "checkbox", formatoptions: { disabled: false }, sortable: false,
                     },
                    {
                        name: 'Omit', index: 'Omit', align: "center", width: 40, sortable: false, editable: true, hidden: false, edittype: 'checkbox', editoptions: { value: "Y:N" }, formatter: "checkbox", formatoptions: { disabled: false }
                    },

                   { name: 'DrugCode', index: 'DrugCode', width: 10, sortable: false, align: 'left', hidden: true },
                   { name: 'TypeCode', index: 'TypeCode', width: 10, sortable: false, align: 'right', hidden: true },
                            GetOmittedByColumn, GetOmittedDateColumn, GetOmittedTimeColumn, GetOrderedByColumn, GetOrderedDateColumn, GetOrderedTimeColumn, GetDrugSequenceNo(), GetNotifyYN(), GetStatus(), GetADMINYN(),
                 ],


                 sortname: 'id',
               //  width: (TabBodyWidth - 5),
                 //footerrow: true,
                 //height: 170,
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
                 loadComplete: function () {
                     var grid = $('#JqGridSpeciaInstructions');
                     jQuery("#JqGridSpeciaInstructions").jqGrid('clearGridData');
                     var len = 1;
                     for (var i = 1; i <= len; i++) {
                         var adddata = {
                             action: "", Type: "", SpeciaInstructions: "", DayOfDrug: "", Dose: "", Route: "", Freq: "", Omit: "", Remark: "", TypeCode: "IV", OmittedBy: '', OmittedDate: '', OmittedTime: '', OrderedBy: '', OrderedDate: '', OrderedTime: '', STATUS: "A",

                         }
                         $("#JqGridSpeciaInstructions").jqGrid("addRowData", i, adddata);
                     }
                     var cm = grid.jqGrid("getGridParam", "colModel");
                     var iCol = getColumnIndexByName(grid, 'action');
                     $(this).find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 16) + ")").addClass('avoid-clicks');
                     $(this).find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 1) + ")")
                     .each(function () {
                         var tr = $(this).closest("tr.jqgrow");
                         l_orowId = $(tr).attr("id");
                         var rowData = grid.jqGrid('getRowData', l_orowId);
                         if (gact == "N") {
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
                         //            l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                         //            RowObj = $(e.target).closest("tr.jqgrow");
                         //            var rowData = grid.jqGrid('getRowData', l_orowId);
                         //            if (rowData.DrugName != "&nbsp;") {
                         //                if (CheckIVBPData(rowData.SQNumber, "IV") === true) {
                         //                    MsgDia("This Medicine is Administered.You can not cancel.Only Omitting is allowed.", "Information");
                         //                }
                         //                else {
                         //                    custom_alertprint("Are you sure you want to cancel this record?", "Medicine Cancellation", rowData, grid, l_orowId, RowObj);
                         //                }
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


                     for (var m = 1; m <= cm.length - 1; m++) {
                         NonEditableColumn(cm, iCol);
                         iCol++
                     }
                 },
                 onCellSelect: function (rowid, iCol, cellcontent, e) {
                     GridName = 'JqGridSpeciaInstructions'
                     var cm = jQuery('#' + GridName).jqGrid("getGridParam", "colModel");
                     var index = $('#JqGridSpeciaInstructions').jqGrid('getInd', rowid);
                     if (IsrolloverData != "Y") {
                         if (iCol == 4) {
                             $('#txtSearchMedicine').val('');
                             $('#tblMedicine tbody').empty();//Empty the table row for adding new search list

                             if (cellcontent == "&nbsp;") {
                                 //  FancyDisplay(GridName);
                                 ValidationTabwise(3);
                                 if (rowValidate == 0) {
                                     ValidationTabwise(3);

                                 }
                             }
                             MedilRowID = rowid
                             ColName = 'DrugName'
                             ColValue = 'DrugCode'
                         }
                         else {
                             NonEditableColumn(cm, iCol);
                         }
                         if (iCol == 6) {
                             //GetRoutvalues(GridName)
                         }
                     }
                     else {
                         cm[iCol].editable = false;
                     }
                 },
                 beforeSelectRow: function (rowid, e) {
                     var rowData = $('#JqGridSpeciaInstructions').jqGrid('getRowData', rowid);
                     if (rowData['Omit'] == "Y") {
                         $($('#JqGridSpeciaInstructions').find('tr#' + rowid).find('td:nth-child(2) div.ui-inline-custom')[0]).hide()
                         $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'OmittedBy', userid);
                         $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'OmittedDate', GetTodaysDate());
                         $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'OmittedTime', GetTimewithAMPM());
                         $('#JqGridSpeciaInstructions').find('tr#' + rowid).addClass('Omited');
                     }

                     else {
                       //  if (rowData['STATUS'] == "A") {
                             $($('#JqGridSpeciaInstructions').find('tr#' + rowid).find('td:nth-child(2) div.ui-inline-custom')[0]).show()
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'OmittedBy', null);
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'OmittedDate', null);
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'OmittedTime', null);
                             $('#JqGridSpeciaInstructions').find('tr#' + rowid).removeClass('Omited');
                        // }
                     }

                     if (rowData['HighAlert'] == "Y") {
                         $("#JqGridSpeciaInstructions").find('tr#' + rowid).find('td').addClass('HighAlertDrug');
                     }
                     else {
                         $("#JqGridSpeciaInstructions").find('tr#' + rowid).find('td').removeClass('HighAlertDrug');
                     }

                     return true; // allow selection
                 },

                 afterSaveCell: function (rowid, name, val, iRow, iCol) {
                     var MaxSEQNO = "";
                     var grid = $('#JqGridSpeciaInstructions');
                     var rowData = grid.getRowData();
                     var cuurenRow = grid.getRowData(rowid);
                     var Typecode = GetTypeCode('JqGridSpeciaInstructions');
                     GetItem = jQuery.grep(rowData, function (n, i) {
                         return (n["DrugName"] != "");
                     });

                     if (name == "DrugName" && val == "") {
                         grid.jqGrid('setCell', rowid, 'OrderedBy', null);
                         grid.jqGrid('setCell', rowid, 'OrderedDate', null);
                         grid.jqGrid('setCell', rowid, 'OrderedTime', null);
                         grid.jqGrid('setCell', rowid, 'SpiDGSTARTDATE', null);
                         grid.jqGrid('setCell', rowid, 'DayOfDrug', null);
                     }
                     else if (name == "DrugName") {
                         grid.jqGrid('setCell', rowid, 'OrderedBy', userid);
                         grid.jqGrid('setCell', rowid, 'OrderedDate', GetTodaysDate());
                         grid.jqGrid('setCell', rowid, 'OrderedTime', GetTimewithAMPM());
                         grid.jqGrid('setCell', rowid, 'SpiDGSTARTDATE', GetTodaysDate());
                         grid.jqGrid('setCell', rowid, 'DayOfDrug', 1);
                         grid.jqGrid('setCell', rowid, 'NOTIFYN', 'N');
                         AddDelButtonByNew(grid, rowid);
                         if (cuurenRow.SQNumber == "") {
                             MaxSEQNO = GetMaxSEQNO('JqGridSpeciaInstructions');
                             if (MaxSEQNO.length > 0) {
                                 grid.jqGrid('setCell', rowid, 'SQNumber', (Number(MaxSEQNO[0].Column1) + 1));
                                 UpdateMaxSEQNOArray(Typecode, (Number(MaxSEQNO[0].Column1) + 1));  //Updating max sequence number
                             }
                             else {
                                 grid.jqGrid('setCell', rowid, 'SQNumber', Number(GetItem.length));
                                 AddDataToMaxArray(Typecode, GetItem.length); //Adding for New row for checking max sequence number
                             }
                         }

                     }


                     if (name === "INFRATE") {
                         var dilVolum = cuurenRow.DilutionVolume
                         if (dilVolum != "" && val != "" && dilVolum != " ") {
                             var Volume = Number(dilVolum.replace(/[^0-9]+/ig, ""))
                             var duration = Volume / Number(val)
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'AdminstrDuration', Math.round(duration));
                             /*------------------MA Droprate--------------------------*/

                             var MADropRate = Number(Volume * 20) / Number(duration * 60);
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'MACROSET', Math.round(MADropRate));

                             /*------------------MI Droprate--------------------------*/

                             var MIDropRate = Number(Volume * 60) / Number(duration * 60);
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'MICROSET', Math.round(MIDropRate));
                         }
                     }

                     else if (name == "DilutionVolume") {
                         var INFRate = cuurenRow.INFRATE
                         if (INFRate != "" && val != "" && val != " ") {
                             var Volume = Number(val.replace(/[^0-9]+/ig, ""))
                             var duration = Volume / Number(INFRate)
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'AdminstrDuration', Math.round(duration));

                             /*------------------MA Droprate--------------------------*/

                             var MADropRate = Number(Volume * 20) / Number(duration * 60);
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'MACROSET', Math.round(MADropRate));

                             /*------------------MI Droprate--------------------------*/

                             var MIDropRate = Number(Volume * 60) / Number(duration * 60);
                             $('#JqGridSpeciaInstructions').jqGrid('setCell', rowid, 'MICROSET', Math.round(MIDropRate));
                         }
                     }

                 },

                 afterEditCell: function (rowid, name, val, iRow, iCol) {
                     if (name == 'DrugName' || name == 'Remark' || name == 'DilutionVolume' || name == 'INFRATE' || name == 'AdminstrDuration') {   //vishal 7th Feb 2019
                         $("#" + iRow + "_" + name).bind('keyup', function (e) {
                             var a = e.currentTarget.value.toUpperCase();
                             e.currentTarget.value = a;
                         });
                     }
                 },

             }).trigger("reloadGrid");

             // $('.ui-jqgrid-bdiv').height(HalfContentheight);
             if (Groupcolumn == false) {
                 $("#JqGridSpeciaInstructions").jqGrid('setGroupHeaders', {
                     useColSpanStyle: true,
                     groupHeaders: [
                       { "startColumnName": 'MACROSET', "numberOfColumns": 2, "titleText": 'Drop Rate / MI' },
                     ]
                 });
                 Groupcolumn = true;
             }
         
             var newWidth = $(window).width();
             $("#JqGridSpeciaInstructions").jqGrid("setGridWidth", newWidth - $('#PatListPanelDiv').width() - 50, false);
             $("#JqGridSpeciaInstructions").jqGrid("setGridHeight", winHeight - $('#mainHeaderHight').height() - 260, true);
         }

        
        



         </script>
</asp:Content>
