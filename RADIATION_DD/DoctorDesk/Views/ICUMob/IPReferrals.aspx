<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.IPReferrals>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <div class="container-fluid">
  <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
       
   
      
     
  
      <table style="width: 85.5%;margin: 1% 0 1% 0;" id="infotab"><!--kavita-->
                <tr>
                    <td colspan="2" style="width:50%">
                        <label style="width: 21.5%; display: inline-block;">Provisional Diagnosis</label>
                       
                        <%=Html.TextAreaFor(x => Model.ProvDiagno, new { id = "txtProvDiagno", @class = "TextBxFormat", maxlength = "1000", Style = "width: 65%;height:30px;vertical-align: middle;",@rows = "5",@readonly="True"})%></td>
                    <td colspan="2">
                        <label style=" display: inline-block;width: 30%;">Allergies</label>
                        
                        <%: Html.TextAreaFor(x => Model.Allergies, new { id = "txtAllergies", @class = "TextBxFormat", maxlength = "1000", Style = "width: 62%;height:30px;vertical-align: middle;",@rows = "5" ,@readonly="True"})%>
                    </td>
                  <%--  vishal 16th Nov--%>
                     <td>                    <%--<input type="button" id="btnCancelShwHide" class="Nbutton" value ="" />--%>
                       
                         <%-- <button id="btnSearch" class="btn btn-primary" style="background-color: #337ab7; border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>
                   --%>
                          <input type="button" id="btnCancelShwHide" class="btn btn-primary" value ="" style="background-color: #337ab7; border-color: #2e6da4;"/>
                       
                          </td>
                </tr>
         <%-- ---------------------------------------------------------------------%>

          <%-- <tr>
                    <td colspan="2">
                                        <label style="width: 22%; display: inline-block;">Nurtrition / Intake</label><%: Html.DropDownListFor(x => Model.NutriIntake,new SelectList(Model.NutritionList, "Value", "Text"),"-----Select-----", new { id = "cmbNutriIntake", @class = "TextBxFormat Mandatory", Style = "width: 65%;height:30px;border-right: 3px solid #ed1001;" ,maxlength="100"})%>
                                   
                                         </td>
                                    <td colspan="3">
                                         <label style="width: 23%; display: inline-block;vertical-align: text-bottom;">Volume / Supplements</label><%: Html.TextAreaFor(x => Model.VolSupplmnt, new { id = "txtVolSupplmnt", @class = "TextBxFormat Mandatory", Style = "width: 47%;height:30px;border-right: 3px solid #ed1001;" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    
                                         </td>
                </tr>
          <tr>
               <td colspan="5">
                                        <label style="width: 11%;display: inline-block;vertical-align: text-bottom;">Remark</label><%: Html.TextAreaFor(x => Model.DocRemarks, new { id = "txtDocRemarks", @class = "TextBxFormat", Style = "width: 74%;height:30px",maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                   
                                         </td>
          </tr>--%>
          <%-----------------------------------------------------------------------------%>



            </table>
        </div>
                 
  
       
    <div class="row" style="margin-left: -10px !important;margin-right: 0px !important;width:100% !important" id="rowWidth">    
        
       
          
                      
                <table id="JqGridReferrals" style="" class="respiratoryData">
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
         var gact = "N";
         var globaldoctstring = '';
        // var specilizationlist = '';
         var IsOnlyDisplay = false;
         var ServerTime = '<%=ViewBag.CurrServerTime %>';
         var ServerDate = '<%=ViewBag.CurrServerDate %>';

         var RefralType = " : ;Daily follow up:Daily follow up;Fitness evaluation:Fitness evaluation;Opinion:Opinion;stat:stat"
         $(document).ready(function () {
           
             ActiveMenu("Referrals");
             load_Doctor();
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
             JQGridJqGridReferrals();

             $("#btnSearch").click(function () {
                 JQGridJqGridReferrals();
             });
             addButtonReferrals();
             load_Specilizationlist();
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
                 $(this).css("zIndex", 9999);
                 $(this).offset(pos);   // reset position
                 $(this).attr("size", len); // open dropdown

                 //$(this).unbind("focus", down);
                 // $(this).focus();


                 // alert("hai");
                 //}

                 if ($(this)[0].id == "1_REMARK" && newflag != 0) {

                     //$(this).css("position", "static");
                     //$(this).attr("size", "1");
                     // newflag = 0;
                 }
             });
             GetTreat();
             if (resultofal != null && resultofal != "")
             SetGridDataRefrral(resultofal);
             $("#btnSave").click(function () {
                 SaveIPReferrals("N");

             });
         });

         //$(window).on("load", function () {
         //    var grdwidth = $('#CotentSection').width() - 100;
         //    $("#essmnet").jqGrid('setGridWidth', parseInt(grdwidth), false);
         //});
         jQuery(document).ready(function ($) {

             if (window.history && window.history.pushState) {

                 window.history.pushState('forward', null, './IPReferrals');

                 $(window).on('popstate', function () {
                     if (stopProp)
                     SaveIPReferrals("Y");
                 });

             }
         });
         function SaveIPReferrals(st) {
             //......................
             
                 var l_blFocus = false;
                 var l_sErrorMessage = "";

                 if ($("#cmbNutriIntake").val().length == 0 || $("#cmbNutriIntake").val() == "") {
                     $("#cmbNutriIntake").css("border-color", "Red");
                    // if (!l_blFocus) {
                         l_blFocus = true;
                         //SetValidateTabIndex(5)
                         $("#cmbNutriIntake").focus();
                        // localStorage.setItem("CurrentTabIndex", 5);
                    // }
                 }
                 else { $("#cmbNutriIntake").css("border-color", ""); }


                 if ($("#txtVolSupplmnt").val().length == 0 || $("#txtVolSupplmnt").val() == "") {
                     $("#txtVolSupplmnt").css("border-color", "Red");
                     // if (!l_blFocus) {
                     l_blFocus = true;
                     //SetValidateTabIndex(5)
                     $("#txtVolSupplmnt").focus();
                     // localStorage.setItem("CurrentTabIndex", 5);
                     // }
                 }
                 else { $("#txtVolSupplmnt").css("border-color", ""); }

                 if (l_blFocus) {
                     return false;
                 }
                
             //......................
             currtabIndx = "";
             IpNo = '' + $.session.get('ICUPatIPNO');
             MrNo = '' + $.session.get('ICUPatMRNO');
             PatName = '' + $.session.get('ICUPatName');
             var currtabIndx = localStorage.getItem("CurrentTabIndex");

             for (l = 0; l < AllGrid.length; l++) {
                 var ids = jQuery("#JqGridReferrals").jqGrid('getDataIDs');
                 for (var i = 1; i <= ids.length; i++) {
                     $("#JqGridReferrals").jqGrid("editCell", 0, 0, false);
                 }
             }

             var JqGridReferralsData = $("#JqGridReferrals").getRowData();


             JqGridReferralsFilterData = jQuery.grep(JqGridReferralsData, function (n, i) {
                 return (n.DoctorCode != "");
             });

             if (JqGridReferralsFilterData.length > 0) {
                 for (var i = 0; i < JqGridReferralsFilterData.length; i++) {
                     JqGridReferralsFilterData[i].SpecilizationName = JqGridReferralsFilterData[i].SpecilizationName.replace(/&/g, "%26");
                     if (gact == 'N') {
                         //  JqGridReferralsFilterData[i].SQNumber = (i + 1);
                     }

                     if (JqGridReferralsFilterData[i].ReferralType == "") {
                         SetactiveTab(5, "Referral");
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


             var tableReferralsFilterData = JSON.stringify(JqGridReferralsFilterData)




             $("#TreatmentSheetForm").find(':input:disabled').removeAttr('disabled');
             formData = $("#TreatmentSheetForm").serialize() + '&&action=' + gact + '&&tableReferralsFilterData=' + tableReferralsFilterData + '&&IpNo=' + IpNo + '&&MrNo=' + MrNo + '&&PatName=' + PatName + '&&TranctionId=' + $('#tractiondropdown').val() + '&&Prov=' + $('#txtProvDiagno').val() + '&&Allergy=' + $('#txtAllergies').val();
             var SaveUrl = "../ICUMob/SaveTreatmentReferral";
             jQuery('body').find('#resultLoading').remove();
             //   ajaxindicatorstart('Saving data.. please wait..');
             $.ajax({
                 type: "POST",
                 url: SaveUrl,
                 data: formData,
                 dataType: "json",
                 cache: false,
                 success: function (response) {
                     //  ajaxindicatorstop();
                   //  MsgDia(response, "Information");
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
                         //var CurrTab = localStorage.getItem('CurrentTabIndex');
                         //if (Number(CurrTab) != 6) {
                         //    SetValidateTabIndex(Number(CurrTab) + 1);
                         //    tabseq = Number((tabseq) + 1);
                         //}
                         if (!resultofal.hasOwnProperty("jsonMedicineData") || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                             window.location.href = '../ICUMob/NonDrugOrder';
                         }
                         else if (st != "Y")
                             MsgDia(response, "Information");


                         GetTreat();
                         if (resultofal != null && resultofal != "")
                             SetGridDataRefrral(resultofal);
                        
                     } else {
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
                     //if (typeof resultofal.jsonDetailsData == "undefined" || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                     //    window.location.href = '../ICUMob/NonDrugOrder';
                     //}
                 },
                 onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                     $.messager.alert("Information", textStatus);
                 }
             });
         }
         function SetGridDataRefrral(result) {

             grid = $("#" + AllGrid[6]);
             grid.jqGrid('clearGridData');
             var recordsCnt = grid.jqGrid('getGridParam', 'records');
             if (recordsCnt < result.jsonDoctorData.length) {
                 AddBlankRow(grid, recordsCnt, result.jsonDoctorData.length, AllGrid[6]);
             }

             for (var M = 0; M < result.jsonDoctorData.length; M++) {
                 var colno = 6
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'Doctor', result.jsonDoctorData[M].Doctor);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'DoctorCode', result.jsonDoctorData[M].DoctorCode);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'ReferralType', result.jsonDoctorData[M].ReferralType);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'ReferralTypeCode', result.jsonDoctorData[M].ReferralType);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'TypeCode', result.jsonDoctorData[M].TypeCode);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'SQNumber', result.jsonDoctorData[M].SEQNO);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'SpecilizationName', result.jsonDoctorData[M].SpecilizationName);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'STATUS', result.jsonDoctorData[M].STATUS);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'CancelBY', result.jsonDoctorData[M].CancelBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'CancelDT', result.jsonDoctorData[M].CancelDT);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'CancelTM', result.jsonDoctorData[M].CancelTM);


                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'SUGESTBY', result.jsonDoctorData[M].SUGESTBY);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'REASON', result.jsonDoctorData[M].REASON);
                 $("#" + AllGrid[colno]).jqGrid('setCell', (M + 1), 'CREATEDBY', result.jsonDoctorData[M].CREATEDBY);
                 if (gact == "N") {
                     AddDelButtonByNew(grid, (M + 1))
                 }
                 else if (gact == "E") {
                     AddCancelBtn(grid, M);
                 }

                 if (gact == 'E') {
                     $($("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom')[1]).hide();
                     //$("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2)').addClass('avoid-clicks');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(3)').addClass('avoid-clicks');
                     $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(4)').addClass('avoid-clicks');
                     if (result.jsonDoctorData[M].STATUS == "C") {
                         $($("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(2) div.ui-inline-custom')[0]).hide()
                         $($("#" + AllGrid[colno]).find('tr#' + (M + 1))).css('background', '#f9a886');

                         $($("#" + AllGrid[colno]).find('tr#' + (M + 1))).addClass('avoid-clicks');

                         $("#" + AllGrid[colno]).find('tr#' + (M + 1)).addClass('avoid-clicks');
                         //for (var a = 1; a <= 12; a++) {
                         //    $("#" + AllGrid[colno]).find('tr#' + (M + 1)).find('td:nth-child(' + a + ')').addClass('avoid-clicks');
                         //}
                     }
                 }

             }
             AddBlankRowToTable(grid, AllGrid[6], 1);         //vishal 23rd Feb 2019
         }
         function JQGridJqGridReferrals() {
             jQuery("#JqGridReferrals").jqGrid({
                 datatype: 'local',
                 colNames: ['', 'Doctor Name', 'Specialization', 'Referral Type', 'Reason For Reference', 'Suggested By', 'DoctorCode', 'ReferralTypeCode', 'TypeCode', 'Cancel By', 'Cancel Date', 'Cancel Time', 'Sequence No', 'Status', 'Created By', 'ADMINYN'],
                 colModel: [
                     {
                         name: 'action', index: 'action', width: 25, fixed: true, sortable: false, resize: false, search: false,
                         formatoptions: { editbutton: false, delbutton: false, keys: true },
                         formatter: 'actions', searchoptions: { clearSearch: false }
                     },
                       {
                           name: 'Doctor', index: 'Doctor', width: 250, sortable: false, editable: true,
                           edittype: 'select',
                           editoptions:
                           {
                               value: globaldoctstring,
                              
                               dataInit: function (elem) {
                                   $(elem).width(230)
                                  
                               },
                               dataEvents: [{
                                   type: 'change',
                                   fn: function (e) {
                                       var FlagDoc = true;
                                       var $select = $(e.target);
                                       var data = $select.val();
                                       var MaxSEQNO = "";
                                       var grid = $("#JqGridReferrals");
                                       var Typecode = GetTypeCode('JqGridReferrals');
                                       var rowData = $("#JqGridReferrals").getRowData();
                                       var rowId = $("#JqGridReferrals").jqGrid('getGridParam', 'selrow');
                                       $.each(rowData, function (index, element) {
                                           if (element.DoctorCode == data) {
                                               FlagDoc = false;
                                           }
                                       });
                                      
                                       if (FlagDoc) {
                                           if (data != "-------------Select-------------") {
                                               $("#JqGridReferrals").jqGrid('setCell', rowId, 'DoctorCode', data); GetDoctSpecilization
                                               $("#JqGridReferrals").jqGrid('setCell', rowId, 'ReferralType', 'Daily follow up');
                                               $("#JqGridReferrals").jqGrid('setCell', rowId, 'ReferralTypeCode', 'Daily follow up');
                                               $("#JqGridReferrals").jqGrid('setCell', rowId, 'SpecilizationName', GetDoctSpecilization(data));
                                               $("#JqGridReferrals").jqGrid('setCell', rowId, 'SUGESTBY', userid);
                                              

                                               AddDelButtonByNew(grid, rowId);
                                               GetItem = jQuery.grep(rowData, function (n, i) {
                                                   return (n["Doctor"] != "");
                                               });
                                               rowdata = $("#JqGridReferrals").jqGrid('getRowData', rowId);

                                               if (rowdata.SQNumber == "") {
                                                   MaxSEQNO = GetMaxSEQNO('JqGridReferrals');
                                                   if (MaxSEQNO.length > 0) {
                                                       $('#JqGridReferrals').jqGrid('setCell', rowId, 'SQNumber', (Number(MaxSEQNO[0].Column1) + 1));
                                                       UpdateMaxSEQNOArray(Typecode, (Number(MaxSEQNO[0].Column1) + 1));  //Updating max sequence number
                                                   }
                                                   else {
                                                       $('#JqGridReferrals').jqGrid('setCell', rowId, 'SQNumber', Number(GetItem.length));
                                                       AddDataToMaxArray(Typecode, GetItem.length); //Adding for New row for checking max sequence number
                                                   }
                                               }
                                           }
                                       }

                                       else {
                                           MsgDia("This Referral doctor already added.")
                                           $("#JqGridReferrals").jqGrid('setCell', rowId, 'Doctor', null);
                                       }
                                       jQuery("#JqGridReferrals").jqGrid("editCell", Number(rowId), 4, true).focus();
                                   }
                               }]
                           }
                       },
                       {
                           name: 'SpecilizationName', index: 'SpecilizationName', width: 250, sortable: false, editable: false,
                       },
                        {
                            name: 'ReferralType', index: 'ReferralType', width: 200, sortable: false, align: 'left', editable: true,
                            edittype: 'select',
                            editoptions:
                            {
                                class: 'jqg-editor',
                                value: RefralType,
                                dataInit: function (elem) {
                                    $(elem).width(150)
                                },
                                dataEvents: [{
                                    type: 'change',
                                    fn: function (e) {
                                        var $select = $(e.target);
                                        var data = $select.val();
                                        var rowId = $("#JqGridReferrals").jqGrid('getGridParam', 'selrow');
                                        if (data != "----Select----") {
                                            $("#JqGridReferrals").jqGrid('setCell', rowId, 'ReferralTypeCode', data);
                                            jQuery("#JqGridReferrals").jqGrid("editCell", Number(rowId), 5, true).focus()
                                        }
                                    },
                                      
                                }]
                            }
                        },
                        
                         {
                             name: 'REASON', index: 'REASON', width: 250, sortable: false, editable: true,editoptions: {
                                 maxlength: 200
                             },

                         },
                         {
                             name: 'SUGESTBY', index: 'SUGESTBY', width: 200, sortable: false,hidden:true, editable: true, editoptions: {
                                 maxlength: 100
                             },
                         },
                        { name: 'DoctorCode', index: 'DoctorCode', width: 150, sortable: false, align: 'right', hidden: true },
                        { name: 'ReferralTypeCode', index: 'ReferralTypeCode', width: 150, sortable: false, hidden: true },
                         { name: 'TypeCode', index: 'TypeCode', width: 10, sortable: false, align: 'right', hidden: true },
                         { name: 'CancelBY', index: 'CancelBY', width: 100, align: "left", hidden: true, sortable: false, editable: false },
                         { name: 'CancelDT', index: 'CancelDT', width: 80, align: "left", hidden: true, sortable: false, editable: false },
                         { name: 'CancelTM', index: 'CancelTM', width: 80, align: "left", hidden: true, sortable: false, editable: false },
                         GetDrugSequenceNo(), GetStatus(),
                         { name: 'CREATEDBY', index: 'CREATEDBY', width: 80, align: "left", hidden: true, sortable: false, editable: false },

                         
                         GetADMINYN(),
                 ],
                 sortname: 'id',
                // width: (TabBodyWidth + 5),
                 //footerrow: true,
                 //height: 85,
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
                     grid = $('#JqGridReferrals');
                     var cm = grid.jqGrid("getGridParam", "colModel");

                     var rowData = grid.jqGrid('getRowData', rowid);

                     if (cm[iCol].name == "action" || cm[iCol].name == "CancelBY" || cm[iCol].name == "CancelDT" || cm[iCol].name == "CancelTM") {
                         cm[iCol].editable = false;
                     }
                     else if (rowData.STATUS == "C") {
                         cm[iCol].editable = false;
                     }
                     else {
                         cm[iCol].editable = true;
                     }



                 },

                 afterSaveCell: function (rowid, name, val, iRow, iCol) {
                     var grid = $('#JqGridReferrals');
                     var cuurenRow = grid.getRowData(rowid);
                     if (name == "Doctor" && val == "") {
                      grid.jqGrid('setCell', rowid, 'CREATEDBY', null);
            
         }
                     else if (name == "Doctor") {
             grid.jqGrid('setCell', rowid, 'CREATEDBY', userid);
            

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

             //if (cuurenRow.HighAlert == "N")
             //    custom_alertInfusion("Is this high alert Infusion ?", 'Confirmation', rowid);

         }
                 },

                 loadComplete: function () {
                     jQuery("#JqGridReferrals").jqGrid('clearGridData');
                     var len = 1;
                     for (var i = 1; i <= len; i++) {
                         var adddata = {
                             Test: "", OrderDate: "", OrderTime: "", TypeCode: 'DC', STATUS: "A",
                         }
                         $("#JqGridReferrals").jqGrid("addRowData", i, adddata);
                     }
                     var grid = $('#JqGridReferrals');
                     var iCol = getColumnIndexByName(grid, 'action');
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
                         //            rowObj = $(e.target).closest("tr.jqgrow");
                         //            l_orowId = $(rowObj).attr("id");
                         //            var rowData = grid.jqGrid('getRowData', l_orowId);
                         //            if (rowData.DoctorCode != "") {
                         //                custom_alertReferral("Are you sure you want to cancel this Referral Doctor?", "Cancellation", rowData, grid, l_orowId, rowObj);
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
                 },

             }).trigger("reloadGrid");

           //  jQuery("#JqGridReferrals").parent().parent().height(HalfContentheight - 85);
             var winHeight = $(window).height();
             var newWidth = $(window).width();
             $("#JqGridReferrals").jqGrid("setGridWidth", newWidth - $('#PatListPanelDiv').width() - 50, false);
             $("#JqGridReferrals").jqGrid("setGridHeight", winHeight - $('#mainHeaderHight').height()-280, true);
         }






         </script>
</asp:Content>
