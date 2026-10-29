<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.NonDrugOrder>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <div class="container-fluid">
  <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
       
   
       
     
   <%--  <div class="col-md-3">
     
      </div>--%>
                 
   </div>
         <h4 style="color: darkslategray; font-weight: bold">Non Drug Order</h4>
    <div class="row" style="margin-left: -20px !important;margin-right: 0px !important;width:100% !important" id="rowWidth">    
        
       
         
             
                     <form id="TreatmentSheetForm" action="./" runat="server">
                        <div style="width: 100%; margin-top: 4px;margin-left:5%" class="TreatmentSheetFormdiv">
                            <table class="tblbottmargin" id="tblNondrugOrder">
                                <tr>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Vital Signs / Pedal Pulses</label><%: Html.TextAreaFor(x => Model.VitalSigns, new { id = "txtVitalPedalPulse", @class = "TextBxFormat Mandatory", Style = "width:245px;height:30px;" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">DVT Prophylaxis</label><%--<%: Html.TextAreaFor(x => Model.DVTProxy, new { id = "txtDVTProxy", @class = "TextBxFormat", Style = "width:278px;height:30px" ,maxlength="100"})%>--%>
                                         <%=Html.DropDownListFor(x => Model.DVTProphylaxis,new SelectList     (Model.DVTProphylaxisList, "Text", "Text"), "---Select---", new { id="cmbDVTProxy",@class = "ComboFormat", @style="width:278px; height:30px",onkeyup="this.value = this.value.toUpperCase();"})%>
                                   
                                       <%-- <%: Html.TextAreaFor(x => Model.DVTProphylaxis, new { id = "txtChangeOfPos", @class = "TextBxFormat", Style = "width:279px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    --%>
                                         </td>
                                </tr>
                            </table>

                            <table class="tblbottmargin">
                                <tr>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">HGT</label><%: Html.TextAreaFor(x => Model.HGT, new { id = "txtHGT", @class = "TextBxFormat Mandatory", Style = "width:245px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Change Of Position</label>
                                        <%: Html.TextAreaFor(x => Model.ChangeOfPos, new { id = "txtChangeOfPos", @class = "TextBxFormat", Style = "width:279px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    
                                    </td>

                                </tr>
                            </table>

                            <table class="tblbottmargin">
                                <tr>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Oxygen Administration</label><%: Html.TextAreaFor(x => Model.OxygenAdmin, new { id = "txtOxygenAdmin", @class = "TextBxFormat Mandatory", Style = "width:245px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Mobilisation / Ambulation</label><%: Html.TextAreaFor(x => Model.MobileAmbul, new { id = "txtMobileAmbul", @class = "TextBxFormat", Style = "width:279px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>

                                </tr>
                            </table>

                            <table class="tblbottmargin">
                                <tr>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Deep Breathing</label><%: Html.TextAreaFor(x => Model.DeepBreathing, new { id = "txtDeepBreathing", @class = "TextBxFormat", Style = "width:245px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Abdominal Girth</label><%: Html.TextAreaFor(x => Model.AbdominalGirth, new { id = "txtAbdominalGirth", @class = "TextBxFormat", Style = "width:279px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>

                                </tr>
                            </table>

                            <table class="tblbottmargin">
                                <tr>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Spirometry</label><%: Html.TextAreaFor(x => Model.Spirometry, new { id = "txtSpirometry", @class = "TextBxFormat", Style = "width:245px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">RT Aspiration</label><%: Html.TextAreaFor(x => Model.RTAspiration, new { id = "txtRTAspiration", @class = "TextBxFormat", Style = "width:279px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>

                                </tr>
                            </table>

                            <table class="tblbottmargin">
                                <tr>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Chest PT</label><%: Html.TextAreaFor(x => Model.ChestPT, new { id = "txtChestPT", @class = "TextBxFormat", Style = "width:245px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Other</label><%: Html.TextAreaFor(x => Model.NDOthers, new { id = "txtNDOthers", @class = "TextBxFormat", Style = "width:279px;height:30px" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>

                                </tr>

                                <tr>
                                </tr>
                            </table>

                            <table class="tblbottmargin">
                                <tr>
                                    <td rowspan="2">
                                        <label style="width: 145px; display: inline-block; vertical-align: text-bottom;">Steam Inhalation</label><%: Html.TextAreaFor(x => Model.SteamInhalation, new { id = "txtSteamInhalation", @class = "TextBxFormat", Style = "width:245px;height:30px" ,maxlength="",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    </td>
                                   
                                </tr>
                            </table>

                            <%-- <table class="tblbottmargin">
                                <tr>
                                   
                                </tr>
                            </table>--%>


                              <div style="width:75%;">
             <label id="btnSave" style="background-color: transparent; border-color: transparent;float:right;margin-right: 8%;" title="Save" class="rightbtn">
                <img src="../Images/check-round.png" style="bottom: 0px; background-color: white; border-radius: 50%; position: fixed;margin-bottom: 1%; ">
            </label>
        </div>

                        </div>
                   </form>
         
            
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


     </style>
     <script type="text/javascript">
         var dt1 = "Date1";
         var dt2 = "Date2";
         var winHeight;
         var otherHeights;

         $(document).ready(function () {
             winHeight = $(window).height();

             otherHeights = $('#mainHeaderHight').height() + 150;
             ActiveMenu("NonDrugOrder");

             //  SetDateTime();
             GetNursStationsNPAtients();
             $("#tabMenu").css("display", "block");

             if ($(window).width() >= 1025) {                                            //screen width size comparion
                 var menuL = document.getElementById('menuList');
                 menuL.style.display = "block";

                 //var dispLst = document.getElementById('sideList');
                 //dispLst.style.display = "block";

             }
             SetPatientDtl();
             
             GetTreat();
             fillheaderDetailsForNon(resultofal);
             $("#btnSearch").click(function () {
                 JQGridJqGridReferrals();
             });

             $("#btnSave").click(function () {
                 SaveNonDrugOrder("N");
              


             });


         });
         jQuery(document).ready(function ($) {

             if (window.history && window.history.pushState) {

                 window.history.pushState('forward', null, './NonDrugOrder');

                 $(window).on('popstate', function () {
                     if (stopProp)
                     SaveNonDrugOrder("Y");
                 });

             }
         });
         function SaveNonDrugOrder(st) {
             currtabIndx = "";
             IpNo = '' + $.session.get('ICUPatIPNO');
             MrNo = '' + $.session.get('ICUPatMRNO');
             PatName = '' + $.session.get('ICUPatName');
             var currtabIndx = localStorage.getItem("CurrentTabIndex");

             for (l = 0; l < AllGrid.length; l++) {
                 var ids = jQuery("#" + AllGrid[l]).jqGrid('getDataIDs');
                 for (var i = 1; i <= ids.length; i++) {
                     $("#" + AllGrid[l]).jqGrid("editCell", 0, 0, false);
                 }
             }

             //if (NonOrderTabValidation() == false) {
             //    return false;
             //}
             ///Added by vishal as on 1st Oct 2018
             if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
                 gact = "N";
             }
             else {
                 gact = "E";
             }



             $("#TreatmentSheetForm").find(':input:disabled').removeAttr('disabled');
             formData = $("#TreatmentSheetForm").serialize() + '&&action=' + gact + '&&IpNo=' + IpNo + '&&MrNo=' + MrNo + '&&PatName=' + PatName + '&&PatName=' + PatName + '&&TranctionId=' + $('#tractiondropdown').val()
             var SaveUrl = "../ICUMob/SaveTreatmentNoNDrug";
             jQuery('body').find('#resultLoading').remove();
             // ajaxindicatorstart('Saving data.. please wait..');

             //............................................
             var l_blFocus = false;
             var l_sErrorMessage = "";
           //  var str = "";
             if ($("#txtHGT").val().length == 0) {
                 $("#txtHGT").css("border-color", "Red");
                 if (!l_blFocus) {
                     l_blFocus = true;
                     
                 }
             }
             else { $("#txtHGT").css("border-color", ""); }

             if ($("#txtOxygenAdmin").val().length == 0) {
                 $("#txtOxygenAdmin").css("border-color", "Red");
                 if (!l_blFocus) {
                     l_blFocus = true;
                     //SetValidateTabIndex(4);
                    
                  
                 }
             }
             else { $("#txtOxygenAdmin").css("border-color", ""); }

             if ($("#txtVitalPedalPulse").val().length == "") {                    //vishal 14th Nov
                 $("#txtVitalPedalPulse").css("border-color", "Red");
                 if (!l_blFocus) {
                     l_blFocus = true;
                    
                    
                 }
             }
             else { $("#txtVitalPedalPulse").css("border-color", ""); }



             if (l_blFocus) {
                 return false;
             }
             //else {
             //    return true;
             //}


             //..................................
            // if (NonOrderTabValidation()) { 
             $.ajax({
                 type: "POST",
                 url: SaveUrl,
                 data: formData,
                 dataType: "json",
                 cache: false,
                 success: function (response) {
                     //ajaxindicatorstop();
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
                                 $('#tractiondropdown').append($("<option>").attr('value', TranNo).text(TranNo));
                             }
                         }



                         //var CurrTab = localStorage.getItem('CurrentTabIndex');
                         //if (Number(CurrTab) != 6) {
                         //    SetValidateTabIndex(Number(CurrTab) + 1);
                         //    tabseq = Number((tabseq) + 1);
                         //}
                         GetTreat();
                         if (resultofal != null && resultofal != "")
                         fillheaderDetailsForNon(resultofal);

                         if (st.toString().trim() != "Y")
                             MsgDia(response, "Information");
                     }

                 },
                 complete: function () {
                    // GetTreatmentSheetData('', gact, IpNo);            ///added by vishal as on 20th Sept 2018

                     ///Added by vishal as on 1st Oct 2018
                     if (tabseq == 0) {
                         var antbio = $.grep($('#JqGridAntibiotics').jqGrid('getRowData'), function (e) { return e.DrugName != "" });
                         var medicat = $.grep($('#JqGridMedication').jqGrid('getRowData'), function (e) { return e.DrugName != "" });

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

         //    }
         //    else {
         //        MsgDia("Enter Proper Data", "Error Information");
         //        return false;
         //}
         }
         function fillheaderDetailsForNon(result) {
             //if (result.jsonDetailsData[0].PROVDIAGNO.length > 0) {
             //    $("#txtProvDiagno").val(result.jsonDetailsData[0].PROVDIAGNO.toString().trim());
             //}
             //if (result.jsonDetailsData[0].ALLERGIES.length > 0) {
             //    $("#txtAllergies").val(result.jsonDetailsData[0].ALLERGIES.toString().trim());
             //}
             $("#txtChemoMedication").val(result.jsonDetailsData[0].CHEMOMED.toString().trim());

             $('#txtVitalPedalPulse').val(result.jsonDetailsData[0].VITALSIGNS.toString().trim());
             $('#cmbDVTProxy').val(result.jsonDetailsData[0].DVTPROPHY.toString().trim());
             $('#txtHGT').val(result.jsonDetailsData[0].HGT.toString().trim());
             $('#txtChangeOfPos').val(result.jsonDetailsData[0].CHANGEPOSI.toString().trim());
             $('#txtOxygenAdmin').val(result.jsonDetailsData[0].OXYGENADMIN.toString().trim());
             $('#txtDeepBreathing').val(result.jsonDetailsData[0].DEEPBREATH.toString().trim());
             $('#txtAbdominalGirth').val(result.jsonDetailsData[0].ABDOMINAL.toString().trim());
             $('#txtSpirometry').val(result.jsonDetailsData[0].SPIROMETRY.toString().trim());
             $('#txtRTAspiration').val(result.jsonDetailsData[0].RTASPIRATION.toString().trim());
             $('#txtChestPT').val(result.jsonDetailsData[0].CHESTPT.toString().trim());
             $('#txtNDOthers').val(result.jsonDetailsData[0].OTHER.toString().trim());
             $('#txtMobileAmbul').val(result.jsonDetailsData[0].MOBILI.toString().trim());
             $('#txtSteamInhalation').val(result.jsonDetailsData[0].STEAMINHAL.toString().trim());
             $('#txtDocRemarks').val(result.jsonDetailsData[0].DOCREMARK.toString().trim());
             $('#txtVolSupplmnt').val(result.jsonDetailsData[0].VOLSUPL.toString().trim());
             $('#cmbNutriIntake').val(result.jsonDetailsData[0].INTMNURT.toString().trim());
             
         }
         function NonOrderTabValidation() {
             var l_blFocus = false;
             var l_sErrorMessage = "";

             if ($("#txtHGT").val().length == 0) {
                 $("#txtHGT").css("border-color", "Red");
                 if (!l_blFocus) {
                     l_blFocus = true;
                     //SetValidateTabIndex(4)
                     $("#txtHGT").focus();
                     localStorage.setItem("CurrentTabIndex", 4);
                 }
             }
             else { $("#txtHGT").css("border-color", ""); }

             if ($("#txtOxygenAdmin").val().length == 0) {
                 $("#txtOxygenAdmin").css("border-color", "Red");
                 if (!l_blFocus) {
                     l_blFocus = true;
                     //SetValidateTabIndex(4);
                     $("#txtOxygenAdmin").focus();
                     localStorage.setItem("CurrentTabIndex", 4);
                 }
             }
             else { $("#txtOxygenAdmin").css("border-color", ""); }

             if ($("#txtVitalPedalPulse").val().length == "") {                    //vishal 14th Nov
                 $("#txtVitalPedalPulse").css("border-color", "Red");
                 if (!l_blFocus) {
                     l_blFocus = true;
                     //SetValidateTabIndex(4);
                     $("#txtVitalPedalPulse").focus();
                     localStorage.setItem("CurrentTabIndex", 4);
                 }
             }
             else { $("#txtVitalPedalPulse").css("border-color", ""); }



             if (l_blFocus) {
                 return false;
             }
             else {
                 return true;
             }
         }
         </script>
    <style>
        .TreatmentSheetFormdiv table{
            width:85%;
        }
    </style>
</asp:Content>
