<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.BloodProduct>" %>

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
                       
                         <%-- <button id="btnSearch" class="btn btn-primary" style="background-color: #337ab7; border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>
                   --%>
                          <input type="button" id="btnCancelShwHide" class="btn btn-primary" value ="" style="background-color: #337ab7; border-color: #2e6da4;"/>
                       
                          </td>
                </tr>
            </table>
 
                 
   </div>
        
    <div class="row" style="margin-left: -10px !important;margin-right: 0px !important;width:100% !important" id="rowWidth">    
        
                   <div style="width: 100%; margin-top: 5px">
                            <table id="JqGridBloodProduct">
                            </table>
                        </div>
         
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
     
<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>--%>
   
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
         var gact = "N";
         var IsOnlyDisplay = false;
         var IsrolloverData = 'N';
         var ServerTime = '<%=ViewBag.CurrServerTime %>';
         var ServerDate = '<%=ViewBag.CurrServerDate %>';
         var BloodProductList = load_BooldProductlist();
         $(document).ready(function () {
             winHeight = $(window).height();
             addButtonSpecialInst();
            
             otherHeights = $('#mainHeaderHight').height() + 150;

             ActiveMenu("BloodProduct");
            // SetDateTime();
             GetNursStationsNPAtients();
             load_MedicineType();
             $("#tabMenu").css("display", "block");

             if ($(window).width() >= 1025) {                                            //screen width size comparion
                 var menuL = document.getElementById('menuList');
                 menuL.style.display = "block";




             }
             SetPatientDtl();
             JQGridGetBloodProduct()

             $("#btnSearch").click(function () {
                 JQGridGetBloodProduct()
             });
             addButtonForBloodProdt();


             $(document).on('focus.jqg', '.jqg-editor', function () {
                 // function newfuncCal() {


                 //  $(this).parents('td').nextAll('select.selenew').find('option').trigger('click');
                 var pos = $(this).offset(); // remember position
                 var len = $(this).find("option").length;
                 if (len > 20) {
                     len = 20;
                 }
                 $(this).parent().removeClass('jqg-editor');
                 $(this).css("position", "absolute");
                 $(this).css("z-index", 3000);
                 $(this).offset(pos);   // reset position
                 $(this).attr("size", len); // open dropdown

                 //$(this).unbind("focus", down);
                 // $(this).focus();
             });
             GetTreat();
             if (resultofal != "" && resultofal !=null)
             SetGridDataBloodProduct(resultofal);
             $("#btnSave").click(function () {

                 SaveBloodProduct("N");

             });
         });

         //$(window).on("load", function () {
         //    var grdwidth = $('#CotentSection').width() - 100;
         //    $("#essmnet").jqGrid('setGridWidth', parseInt(grdwidth), false);
         //});
         jQuery(document).ready(function ($) {

             if (window.history && window.history.pushState) {

                 window.history.pushState('forward', null, './BloodProduct');

                 $(window).on('popstate', function () {

                     if (stopProp)
                     SaveBloodProduct("Y");
                 });

             }
         });
         function SaveBloodProduct(st) {
               currtabIndx = "";
                 IpNo = '' + $.session.get('ICUPatIPNO');
             MrNo = '' + $.session.get('ICUPatMRNO');
             PatName = '' + $.session.get('ICUPatName');
             var currtabIndx = localStorage.getItem("CurrentTabIndex");

             for (l = 0; l < AllGrid.length; l++) {
                 var ids = jQuery("#" + AllGrid[l]).jqGrid('getDataIDs');
                 for (var i = 1; i <= ids.length; i++) {
                     $("#JqGridBloodProduct").jqGrid("editCell", 0, 0, false);
                 }
             }
               
               
             var JqGridBloodProductData = $("#JqGridBloodProduct").getRowData();


          



             
             JqGridBloodPodFilterData = jQuery.grep(JqGridBloodProductData, function (n, i) {
                 return (n.DrugName.trim() != "");
             });

             if (JqGridBloodPodFilterData.length > 0) {
                 for (var i = 0; i < JqGridBloodPodFilterData.length; i++) {
                     JqGridBloodPodFilterData[i].DrugName = JqGridBloodPodFilterData[i].DrugName.replace(/&/g, "%26");
                     if (gact == 'N') {
                         //    JqGridBloodPodFilterData[i].SQNumber = (i + 1);
                     }
                     if (JqGridBloodPodFilterData[i].DrugName.trim() == "") {  //vishal 23rd Feb 2019
                         //if (JqGridBloodPodFilterData[i].DrugName.trim() == "" || JqGridBloodPodFilterData[i].INFRATE.trim() == "") {
                         SetactiveTab(3, "Blood/Blood Product column in table : Blood Product, Transfusion rate which should not be empty");
                         return false;
                     }
                 }
             }


             //if (Number(currtabIndx) == 4) {
              
             //}


             ///Added by vishal as on 1st Oct 2018
             if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
                 gact = "N";
             }
             else {
                 gact = "E";
             }

               
             var tableBloodProductData = JSON.stringify(JqGridBloodPodFilterData)

      

             $("#TreatmentSheetForm").find(':input:disabled').removeAttr('disabled');
             formData = $("#TreatmentSheetForm").serialize() + '&&action=' + gact + '&&tableBloodProductData=' + tableBloodProductData + '&&IpNo=' + IpNo + '&&MrNo=' + MrNo + '&&PatName=' + PatName + '&&TranctionId=' + $('#tractiondropdown').val() + '&&Prov=' + $('#txtProvDiagno').val() + '&&Allergy=' + $('#txtAllergies').val()
             var SaveUrl = "../ICUMob/SaveTreatmentBloodProduct";
             jQuery('body').find('#resultLoading').remove();
             //  ajaxindicatorstart('Saving data.. please wait..');
             $.ajax({
                 type: "POST",
                 url: SaveUrl,
                 data: formData,
                 dataType: "json",
                 cache: false,
                 success: function (response) {
                     //  ajaxindicatorstop();
                //   MsgDia(response, "Information");
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

                                 // $('#tractiondropdown').append($("<option>").attr('value', TranNo).text(TranNo));
                             }
                         }
                         //var CurrTab = localStorage.getItem('CurrentTabIndex');
                         //if (Number(CurrTab) != 6) {
                         //    SetValidateTabIndex(Number(CurrTab) + 1);
                         //    tabseq = Number((tabseq) + 1);
                         //}

                         if (!resultofal.hasOwnProperty("jsonMedicineData") || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                             window.location.href = '../ICUMob/NonDrugOrder';
                         } else if (st.toString().trim() != "Y")
                             MsgDia(response, "Information");

                         GetTreat();
                         if (resultofal != "" && resultofal != null)
                             SetGridDataBloodProduct(resultofal);


                     } else {
                         MsgDia(response, "Error");
                         return false
                     }

                 },
                 complete: function () {
                     GetTreatmentSheetData('', gact, IpNo);            ///added by vishal as on 20th Sept 2018

                     ///Added by vishal as on 1st Oct 2018
                     if (tabseq == 0) {
                             
                         if (antbio.length == 0 && medicat.length == 0) {
                             $('#btnRollOver').show();
                         }
                         else {
                             $('#btnRollOver').hide();
                         }
                     }
                     else if (tabseq == 1) {
                         var inf = $.grep($('#JqGridInfusion').jqGrid('getRowData'), function (e) { return e.Infusion != "" });
                         if (inf.length == 0) {
                             $('#btnRollOver').show();
                         }
                         else {
                             $('#btnRollOver').hide();
                         }
                     }
                     else if (tabseq == 2) {
                         $('#btnRollOver').hide();
                     }
                     else if (tabseq == 3) {
                         var SpclInst = $.grep($('#JqGridSpeciaInstructions').jqGrid('getRowData'), function (e) { return e.DrugName != "" });
                         var BldPrdct = $.grep($('#JqGridBloodProduct').jqGrid('getRowData'), function (e) { return e.DrugName != "" });
                         if (SpclInst.length == 0 && BldPrdct.length == 0) {
                             $('#btnRollOver').show();
                         }
                         else {
                             $('#btnRollOver').hide();
                         }
                     }
                     else if (tabseq == 4) {
                         $('#btnRollOver').hide();
                     }
                     else if (tabseq == 5) {
                         var invstg = $.grep($('#JqGridInvestigation').jqGrid('getRowData'), function (e) { return e.Test != "" });
                         var ref = $.grep($('#JqGridReferrals').jqGrid('getRowData'), function (e) { return e.Doctor != "" && e.SpecilizationName != "" });
                         if (invstg.length == 0 && ref.length == 0) {

                             $('#btnRollOver').show();
                         }
                         else {
                             $('#btnRollOver').hide();
                         }
                     }
                 },
                 onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                     $.messager.alert("Information", textStatus);
                 }
             });

         }
         function SetGridDataBloodProduct(result) {
             if (ISRYN == "Y") {
                 for (var i = 0; i <= result.jsonBloodProductData.length - 1; i++) {
                     result.jsonBloodProductData[i]["ADMINYN"] = "";
                 }
             }
             grid = $("#" + AllGrid[9]);
             grid.jqGrid('clearGridData');
             var recordsCnt = grid.jqGrid('getGridParam', 'records');
             if (recordsCnt < result.jsonBloodProductData.length) {
                 AddBlankRow(grid, recordsCnt, result.jsonBloodProductData.length, AllGrid[9]);
             }

             for (var M = 0; M < result.jsonBloodProductData.length; M++) {
                 var colno = 9
                 if (DayofDurgsTodaysChk) {
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DayOfDrug', parseInt(result.jsonBloodProductData[M].DayOfDrug));
                 }
                 else {
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DayOfDrug', parseInt(result.jsonBloodProductData[M].DayOfDrug) + 1);
                 }
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Dose', result.jsonBloodProductData[M].Dose);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DrugCode', result.jsonBloodProductData[M].DrugCode);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DrugName', result.jsonBloodProductData[M].DrugName);
                 $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(3)').addClass('avoid-clicks')

                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Freq', result.jsonBloodProductData[M].Freq);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Omit', result.jsonBloodProductData[M].Omit);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Route', result.jsonBloodProductData[M].Route);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Type', result.jsonBloodProductData[M].Type);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'TypeCode', result.jsonBloodProductData[M].TypeCode);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Remark', result.jsonBloodProductData[M].Remark);

                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DilutionVolume', result.jsonBloodProductData[M].DILVOLUME);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'AdminstrDuration', result.jsonBloodProductData[M].ADMINDUR);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'BPSTARTDATE', result.jsonBloodProductData[M].STARTFRMDT);

                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedBy', result.jsonBloodProductData[M].ORDERBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedDate', result.jsonBloodProductData[M].ORDDATE);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OrderedTime', result.jsonBloodProductData[M].ORDTIME);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedBy', result.jsonBloodProductData[M].OMITBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedDate', result.jsonBloodProductData[M].OMITDT);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'OmittedTime', result.jsonBloodProductData[M].OMITTM);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'SQNumber', result.jsonBloodProductData[M].SEQNO);

                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'HighAlert', result.jsonBloodProductData[M].HighAlert);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'INFRATE', result.jsonBloodProductData[M].INFRATE);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'MACROSET', result.jsonBloodProductData[M].MACROSET);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'NOTIFYN', result.jsonBloodProductData[M].NOTIFYN);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'STATUS', result.jsonBloodProductData[M].STATUS);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'ADMINYN', result.jsonBloodProductData[M].ADMINYN);

                 if (result.jsonBloodProductData[M].ADMINYN == "Y" || result.jsonBloodProductData[M].STATUS == "C") {
                     //  $($("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom')[0]).hide()
                     //for (var a = 1; a <= 30; a++) {
                     //    $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(' + a + ')').addClass('avoid-clicks');
                     //}
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).addClass('avoid-clicks');
                 }
                 else {
                     if (gact == "N") {
                         AddDelButtonByNew(grid, (M + 1))
                     }
                     else if (gact == "E") {
                         AddCancelBtn(grid, M);
                     }
                 }

                 if (result.jsonBloodProductData[M].HighAlert == "Y") {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td').addClass('HighAlertDrug');
                 }
                 $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(4)').addClass('avoid-clicks')

                 if (result.jsonBloodProductData[M].Omit == "Y") {
                     $("#" + AllGrid[colno]).jqGrid('setRowData', (M + 1), false, 'Omited');// Assign CSS class to row
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).addClass('avoid-clicks');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(15) input').attr("disabled", true);
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom').hide();
                 }
                 else {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(15)').removeClass('avoid-clicks');
                 }

                 if (result.jsonBloodProductData[M].STATUS == "C") {
                     $("#" + AllGrid[colno]).jqGrid('setRowData', (M + 1), false, 'cancellation');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom').hide();
                     $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Omit', false, 'avoid-clicks');
                 }

                 $($("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom')[1]).hide()
                 if (IsPastDate) {
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(15) input').attr("disabled", true);
                 }

                 else {
                     if (result.jsonBloodProductData[M].Omit != "Y") {
                         $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(15) input').attr("disabled", false);
                     }
                 }




             }


             AddBlankRowToTable(grid, AllGrid[9], 1);         //vishal 23rd Feb 2019
         }

         function JQGridGetBloodProduct() {
             jQuery("#JqGridBloodProduct").jqGrid({
                 datatype: 'local',
                 colNames: ['', 'Duration', 'Type', 'Diluent', 'QTY', 'Blood / Blood Products', 'Day', 'Route', 'Freq', 'Remark', 'Volume / ml', 'Transfusion rate (ml/hr)', 'Dur.of Admn(hrs)', 'Drop rate(drops/mt)', 'Start Date', 'Omit', 'SpecialInstDrugsCode', 'TypeCode', 'Omit / Cancel By', 'Omit / Cancel Date', 'Omit / Cancel Time', 'Order By', 'Order Date', 'Order Time', 'Sequence No', 'HighAlertMed', 'NotifyYN', 'Status', 'ADMINYN'],
                 //colModel: GetSpeciaInstructionsColumn(),
                 colModel: [
                       {
                           name: 'action', index: 'action', width: 25, fixed: true, sortable: false, resize: false, search: false,
                           formatoptions: { editbutton: false, delbutton: false, keys: true },
                           formatter: 'actions', searchoptions: { clearSearch: false }
                       },
                       {
                           name: 'Duration', index: 'Duration', width: 50, sortable: false, align: 'left', editable: true, hidden: true,
                       },
                        {
                            name: 'Type', index: 'Type', width: 40, align: "left", sortable: true, editable: true, searchoptions: { clearSearch: false }, hidden: true,
                            edittype: 'select',
                            editoptions:
                                {
                                    value: MediciTypeLStr,
                                    dataInit: function (e) {
                                        $(e).css("width", "40")
                                    }
                                },

                        },
                         {
                             name: 'Diluent', index: 'Diluent', width: 50, sortable: false, align: 'left', editable: true, hidden: true,
                         },

                        {
                            name: 'Dose', index: 'Dose', width: 50, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 20, }, hidden: false,
                        },
                        
                       
                        {
                            name: 'DrugName', index: 'DrugName', width: 210, sortable: false, editable: true,
                            edittype: 'select',
                            editoptions:
                            {
                                class: 'jqg-editor',
                                value: BloodProductList,
                                dataInit: function (elem) {
                                    $(elem).width(200)
                                    //$(elem).select2({
                                    //    width: '240px !important'
                                    //})
                                },
                                dataEvents: [{
                                    type: 'change',
                                    fn: function (e) {
                                        var $select = $(e.target);
                                        var grid = $("#" + GridName);
                                        var data = $select.val();
                                        var Typecode = GetTypeCode('JqGridBloodProduct');
                                        var MaxSEQNO = "";
                                        var rowId = $("#JqGridBloodProduct").jqGrid('getGridParam', 'selrow');
                                        if (data != "") {
                                            $("#" + GridName).jqGrid('setCell', rowId, 'OrderedBy', userid);
                                            $("#" + GridName).jqGrid('setCell', rowId, 'OrderedDate', GetTodaysDate());
                                            $("#" + GridName).jqGrid('setCell', rowId, 'OrderedTime', GetTimewithAMPM());
                                            $("#" + GridName).jqGrid('setCell', rowId, 'BPSTARTDATE', GetTodaysDate());
                                            $("#" + GridName).jqGrid('setCell', rowId, 'DayOfDrug', 1);
                                            $("#" + GridName).jqGrid('setCell', rowId, 'HighAlert', 'Y');
                                            $("#" + GridName).find('tr#' + rowId).find('td').addClass('HighAlertDrug');
                                            AddDelButtonByNew(grid, rowId);
                                            /*-------------------------------------Set sequence Number------------------------------*/

                                            var rowData = $("#" + GridName).getRowData();

                                            GetItem = jQuery.grep(rowData, function (n, i) {
                                                return (n["DrugName"] != "");
                                            });

                                            rowdata = $("#" + GridName).jqGrid('getRowData', rowId);
                                            if (rowdata.SQNumber == "") {
                                                MaxSEQNO = GetMaxSEQNO('JqGridBloodProduct');
                                                if (MaxSEQNO.length > 0) {
                                                    $('#JqGridBloodProduct').jqGrid('setCell', rowId, 'SQNumber', (Number(MaxSEQNO[0].Column1) + 1));
                                                    UpdateMaxSEQNOArray(Typecode, (Number(MaxSEQNO[0].Column1) + 1));  //Updating max sequence number
                                                }
                                                else {
                                                    $('#JqGridBloodProduct').jqGrid('setCell', rowId, 'SQNumber', Number(GetItem.length));
                                                    AddDataToMaxArray(Typecode, GetItem.length); //Adding for New row for checking max sequence number
                                                }
                                            }
                                        }


                                        var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                        jQuery("#JqGridBloodProduct").jqGrid("editCell", Number(rowId), 10, true);
                                    }
                                }],
                               
                            }
                        },
                   //{
                   //    name: 'DrugName', index: 'DrugName', width: 210, sortable: false, editable: false
                   //},
                    {
                        name: 'DayOfDrug', index: 'DayOfDrug', width: 70, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }, hidden: true,
                    },
                    {
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
                        name: 'Remark', index: 'Remark', width: 150, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, },
                    },
                    
                      {
                          name: 'DilutionVolume', index: 'DilutionVolume', hidden: false, width: 75, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
                          // edittype: 'select',
                          editoptions:
                              {
                                  dataInit: function (el) {
                                      $(el).css("width", "70px")
                                      //$(el).change(function () {
                                      //    grid = $('#JqGridBloodProduct');
                                      //    if ($(el).val() != "") {

                                      //        var DilVol = $(el).val();
                                      //        alert(DilVol);
                                      //        var rowobject = $(el).parent('td').parent('tr');
                                      //        rowId = $(rowobject).attr('id');
                                      //        cuurenRow = grid.getRowData(rowId);
                                      //        var INFRate = cuurenRow.INFRATE
                                      //        if (INFRate != "" && DilVol != "" && DilVol != " " && INFRate > 0) {
                                      //            var Volume = Number(DilVol.replace(/[^0-9]+/ig, ""))
                                      //            var duration = Volume / Number(INFRate)
                                      //            grid.jqGrid('setCell', rowId, 'AdminstrDuration', Math.round(duration));

                                      //            /*------------------MA Droprate--------------------------*/

                                      //            var MADropRate = Number(Volume * 20) / Number(duration * 60);
                                      //            grid.jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));
                                      //        }
                                      //    }
                                      //})

                                      $(el).keypress(function (event) {
                                          //$(this).val($(this).val().toUpperCase());
                                          if ((event.which != 8 && isNaN(String.fromCharCode(event.which))) || (event.which == 32)) {
                                              event.preventDefault();
                                          }
                                      });

                                      $(el).keyup(function (event) {
                                          grid = $('#JqGridBloodProduct');
                                          var Volume = $(el).val();
                                          var rowobject = $(el).parent('td').parent('tr');
                                          rowId = $(rowobject).attr('id');
                                          cuurenRow = grid.getRowData(rowId);
                                          var INFRate = cuurenRow.INFRATE
                                          var AdmnDur = cuurenRow.AdminstrDuration
                                          if (INFRate != "" && Volume != "" && Volume != " " && INFRate > 0 && Volume > 0) {
                                              //var Volume = Number(DilVol.replace(/[^0-9]+/ig, ""))
                                              var duration = Volume / Number(INFRate)
                                              grid.jqGrid('setCell', rowId, 'AdminstrDuration', Math.round(duration));

                                              /*------------------MA Droprate--------------------------*/

                                              var MADropRate = Number(Volume * 20) / Number(duration * 60);
                                              grid.jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));
                                          }
                                          else if (AdmnDur != "" && Volume != "" && Volume != " " && AdmnDur > 0 && Volume > 0) {

                                              var InfRate = Volume / Number(AdmnDur)
                                              grid.jqGrid('setCell', rowId, 'INFRATE', Math.round(InfRate));

                                              /*------------------MA Droprate--------------------------*/

                                              var MADropRate = Number(Volume * 20) / Number(duration * 60);
                                              grid.jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));
                                          }
                                          else if (INFRate == 0 || Volume == 0) {
                                              grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                                              grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                          }
                                          else {
                                              grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                                              grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                          }
                                      });

                                  }
                              }
                      },

                      //Transfusion Rate column as INFRATE
                      {
                          name: 'INFRATE', index: 'INFRATE', width: 140, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 50, }, hidden: false,
                          editoptions: {
                              maxlength: 50, dataInit: function (el) {
                                  $(el).keypress(function (event) {
                                      //$(this).val($(this).val().toUpperCase());
                                      if ((event.which != 8 && isNaN(String.fromCharCode(event.which))) || (event.which == 32)) {
                                          event.preventDefault();
                                      }
                                  });

                                  $(el).keyup(function (event) {
                                      grid = $('#JqGridBloodProduct');
                                      if ($(el).val() != "") {
                                          var infRate = $(el).val();
                                          var rowobject = $(el).parent('td').parent('tr');
                                          rowId = $(rowobject).attr('id');
                                          cuurenRow = grid.getRowData(rowId);
                                          var dilVolum = cuurenRow.DilutionVolume
                                          if (dilVolum != "" && infRate != "" && dilVolum != " " && Number(infRate) > 0 && Number(dilVolum) > 0) {
                                              var Volume = Number(dilVolum.replace(/[^0-9]+/ig, ""))
                                              var duration = Volume / Number(infRate)
                                              grid.jqGrid('setCell', rowId, 'AdminstrDuration', Math.round(duration));
                                              /*------------------MA Droprate--------------------------*/

                                              var MADropRate = Number(Volume * 20) / Number(duration * 60);
                                              grid.jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));
                                          }
                                          else if (Number(dilVolum) == 0 || Number(infRate) == 0) {
                                              grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                                              grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                          }
                                          else {
                                              grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                                              grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                          }
                                      }
                                  });
                              },
                          },
                      },

                    {
                        name: 'AdminstrDuration', index: 'AdminstrDuration', hidden: false, width: 95, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
                        editoptions:
                            {
                                dataInit: function (el) {
                                    grid = $('#JqGridBloodProduct');
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

                                                var MADropRate = Number(Volume * 16) / Number(admindur * 60);
                                                grid.jqGrid('setCell', rowId, 'MACROSET', Math.round(MADropRate));
                                            }
                                            else {
                                                grid.jqGrid('setCell', rowId, 'INFRATE', null);
                                                grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                            }
                                        }
                                        else {
                                            grid.jqGrid('setCell', rowId, 'INFRATE', null);
                                            grid.jqGrid('setCell', rowId, 'MACROSET', null);
                                        }
                                    });
                                },

                            }
                    },
                     {
                         name: 'MACROSET', index: 'MACROSET', width: 120, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 20, }, hidden: false,
                     },

                    {
                        name: 'BPSTARTDATE', index: 'BPSTARTDATE', width: 85, sortable: false, align: 'left', editable: true,
                        editoptions: {

                            size: 20,
                            dataInit: function (el) {
                                $(el).css("width", "100%")
                                $(el).datepicker({
                                    dateFormat: "dd/mm/yy",
                                    changeMonth: true,
                                    changeYear: true,
                                    minDate: new Date(),
                                }).mask("99/99/9999");;
                            }
                        }
                    },

                    {
                        name: 'Omit', index: 'Omit', align: "center", width: 40, sortable: false, editable: true, hidden: false, edittype: 'checkbox', editoptions: { value: "Y:N" }, formatter: "checkbox", formatoptions: { disabled: false }
                    },

                   { name: 'DrugCode', index: 'DrugCode', width: 10, sortable: false, align: 'left', hidden: true },
                   { name: 'TypeCode', index: 'TypeCode', width: 10, sortable: false, align: 'right', hidden: true },
                            GetOmittedByColumn, GetOmittedDateColumn, GetOmittedTimeColumn, GetOrderedByColumn, GetOrderedDateColumn, GetOrderedTimeColumn,
                            GetDrugSequenceNo(), GetHighAlertDrug(), GetNotifyYN(), GetStatus(), GetADMINYN(),

                 ],

                 sortname: 'id',
               //  width: (TabBodyWidth - 5),
                 //footerrow: true,
                // height: 170,
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
                     var grid = $('#JqGridBloodProduct');
                     jQuery("#JqGridBloodProduct").jqGrid('clearGridData');
                     var len = 1;
                     for (var i = 1; i <= len; i++) {
                         var adddata = {
                             action: "", Type: "", SpeciaInstructions: "", DayOfDrug: "", Dose: "", Route: "", Freq: "", Omit: "", Remark: "", TypeCode: "BP", OmittedBy: '', OmittedDate: '', OmittedTime: '', OrderedBy: '', OrderedDate: '', OrderedTime: '', STATUS: "A",

                         }
                         $("#JqGridBloodProduct").jqGrid("addRowData", i, adddata);
                     }
                     var cm = grid.jqGrid("getGridParam", "colModel");
                     var iCol = getColumnIndexByName(grid, 'action');
                     $(this).find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 14) + ")").addClass('avoid-clicks');
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
                         //            var rowData = grid.jqGrid('getRowData', l_orowId);
                         //            RowObj = $(e.target).closest("tr.jqgrow");
                         //            if (rowData.DrugName != "") {
                         //                if (CheckIVBPData(rowData.SQNumber, "BP") === true) {
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
                     //NonEditableColumn(cm, iCol);
                 },
                 onCellSelect: function (rowid, iCol, cellcontent, e) {
                     GridName = 'JqGridBloodProduct'
                     var cm = jQuery('#' + GridName).jqGrid("getGridParam", "colModel");
                     var index = $('#JqGridBloodProduct').jqGrid('getInd', rowid);
                     if (IsrolloverData != "Y") {
                         if (iCol == 3) {
                             //$('#txtSearchMedicine').val('');
                             //$('#tblMedicine tbody').empty();//Empty the table row for adding new search list

                             //if (cellcontent == "&nbsp;") {
                             //    FancyDisplay(GridName);
                             //}
                             //MedilRowID = rowid
                             //ColName = 'DrugName'
                             //ColValue = 'DrugCode'
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

                 afterSaveCell: function (rowid, name, val, iRow, iCol) {
                     grid = $('#JqGridBloodProduct');

                     var cuurenRow = $(grid).getRowData(rowid);

                     if (name == "DrugName" && val == " ") {
                         $(grid).jqGrid('setCell', rowid, 'OrderedBy', null);
                         $(grid).jqGrid('setCell', rowid, 'OrderedDate', null);
                         $(grid).jqGrid('setCell', rowid, 'OrderedTime', null);
                         $(grid).jqGrid('setCell', rowid, 'SQNumber', null);
                         $(grid).jqGrid('setCell', rowid, 'BPSTARTDATE', null);
                         $(grid).jqGrid('setCell', rowid, 'DayOfDrug', null);
                     }
                     else if (name == "DrugName") {
                         $(grid).jqGrid('setCell', rowid, 'OrderedBy', userid);
                         $(grid).jqGrid('setCell', rowid, 'OrderedDate', GetTodaysDate());
                         $(grid).jqGrid('setCell', rowid, 'OrderedTime', GetTimewithAMPM());
                         $(grid).jqGrid('setCell', rowid, 'BPSTARTDATE', GetTodaysDate());
                         grid.jqGrid('setCell', rowid, 'NOTIFYN', 'N');
                     }

                     if (name === "INFRATE") {
                         var dilVolum = cuurenRow.DilutionVolume
                         if (dilVolum != "" && val != "" && dilVolum != " " && val > 0) {
                             var Volume = Number(dilVolum.replace(/[^0-9]+/ig, ""))
                             var duration = Volume / Number(val)
                             grid.jqGrid('setCell', rowid, 'AdminstrDuration', Math.round(duration));
                             /*------------------MA Droprate--------------------------*/

                             var MADropRate = Number(Volume * 20) / Number(duration * 60);
                             grid.jqGrid('setCell', rowid, 'MACROSET', Math.round(MADropRate));

                         }
                         else if (Number(dilVolum) == 0 || Number(val) == 0) {
                             grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                             grid.jqGrid('setCell', rowId, 'MACROSET', null);
                         }
                         else {
                             grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                             grid.jqGrid('setCell', rowId, 'MACROSET', null);
                         }
                     }

                     else if (name == "DilutionVolume") {
                         var INFRate = cuurenRow.INFRATE
                         if (INFRate != "" && val != "" && val != " " && val > 0) {
                             var Volume = Number(val.replace(/[^0-9]+/ig, ""))
                             var duration = Volume / Number(INFRate)
                             grid.jqGrid('setCell', rowid, 'AdminstrDuration', Math.round(duration));

                             /*------------------MA Droprate--------------------------*/

                             var MADropRate = Number(Volume * 20) / Number(duration * 60);
                             grid.jqGrid('setCell', rowid, 'MACROSET', Math.round(MADropRate));
                         }
                         else if (Number(INFRate) == 0 || Number(val) == 0) {
                             grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                             grid.jqGrid('setCell', rowId, 'MACROSET', null);
                         }
                         else {
                             grid.jqGrid('setCell', rowId, 'AdminstrDuration', null);
                             grid.jqGrid('setCell', rowId, 'MACROSET', null);
                         }
                     }
                 },

                 beforeSelectRow: function (rowid, e) {
                     var rowData = $('#JqGridBloodProduct').jqGrid('getRowData', rowid);
                     if (rowData['Omit'] == "Y") {
                         $($('#JqGridBloodProduct').find('tr#' + rowid).find('td:nth-child(2) div.ui-inline-custom')[0]).hide();
                         $('#JqGridBloodProduct').jqGrid('setCell', rowid, 'OmittedBy', userid);
                         $('#JqGridBloodProduct').jqGrid('setCell', rowid, 'OmittedDate', GetTodaysDate());
                         $('#JqGridBloodProduct').jqGrid('setCell', rowid, 'OmittedTime', GetTimewithAMPM());
                         $('#JqGridBloodProduct').find('tr#' + rowid).addClass('Omited');
                     }

                     else {
                         if (rowData['STATUS'] == "A") {
                             $($('#JqGridBloodProduct').find('tr#' + rowid).find('td:nth-child(2) div.ui-inline-custom')[0]).show()
                             $('#JqGridBloodProduct').jqGrid('setCell', rowid, 'OmittedBy', null);
                             $('#JqGridBloodProduct').jqGrid('setCell', rowid, 'OmittedDate', null);
                             $('#JqGridBloodProduct').jqGrid('setCell', rowid, 'OmittedTime', null);
                             $('#JqGridBloodProduct').find('tr#' + rowid).removeClass('Omited');
                         }
                     }

                     return true; // allow selection
                 },

                 afterEditCell: function (rowid, name, val, iRow, iCol) {
                     if (name == 'Remark' || name == 'DilutionVolume' || name == 'INFRATE' || name == 'AdminstrDuration') {   //vishal 7th Feb 2019
                         $("#" + iRow + "_" + name).bind('keyup', function (e) {
                             var a = e.currentTarget.value.toUpperCase();
                             e.currentTarget.value = a;
                         });
                     }
                 },
             }).trigger("reloadGrid");

             //  $('.ui-jqgrid-bdiv').height(HalfContentheight);


            // $('#Content_TabContainerTreatmentSheet_TabPanelIVFluid').height(Contentheight - 135);
            // $('#Content_TabContainerTreatmentSheet_TabPanelIVFluid').css('overflow-y', 'scroll');



             var winHeight = $(window).height();
             var newWidth = $(window).width();
             $("#JqGridBloodProduct").jqGrid("setGridWidth", newWidth - $('#PatListPanelDiv').width() - 50, false);
             $("#JqGridBloodProduct").jqGrid("setGridHeight", winHeight - $('#mainHeaderHight').height() - 250, true);
         }
           
            


             
         

         
         function load_BooldProductlist() {
             var s;
             var BPlist
             $.ajax({
                 url: '../ICUMob/GetBloodProductList',
                 data: {},
                 type: 'get',
                 async: false,
                 success: function (Response) {
                     BPlist = Response;
                     s = " : ;"; $.each(BPlist, function () {
                         s += this.Value + ":" + this.Text + ";";
                     });
                     s = s.substring(0, s.length - 1);
                 }
             });
             return s;
         }


         function load_MedicineType() {
             var s;
             var MediciTypeLst
             MediciTypeLStr
             $.ajax({
                 url: '../ICUMob/GetMedicineType',
                 data: {},
                 type: 'get',
                 async: false,
                 success: function (Response) {
                     MediciTypeLst = Response;
                     s = " : ;"; $.each(MediciTypeLst, function () {
                         s += this.Value + ":" + this.Text + ";";
                     });
                     s = s.substring(0, s.length - 2);
                 }
             });
             MediciTypeLStr = s;
             return s;
         }

       


         </script>
</asp:Content>
