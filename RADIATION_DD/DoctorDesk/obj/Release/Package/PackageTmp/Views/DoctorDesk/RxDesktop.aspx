<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="MainDiv">
        <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%; margin-top: 10px;">
            <div class="StuckInput" style="margin-top: -18px;">
                <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Add new Medicine">
                    <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
                </label>
                <input type="text" id="ComplaintInput" placeholder="" style="border-radius: 5px; margin-top: 2px; margin-left: 7px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); height: 28px; position: fixed;"
                    class="empty">
                <label id="RFillButton" style="background-color: transparent; float: right; border-color: transparent;" title="Refill Routine Medicines" class="fillBtn">
                    <button type="button" class="btn bg-olive margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px; margin-top: 3px;">Routine</button>
                </label>
                <label id="FillButton" style="background-color: transparent; float: right; border-color: transparent;" title="Refill Medicines" class="fillBtn">
                    <button type="button" class="btn bg-olive margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px; margin-top: 3px;">ReFill</button>
                </label>

                <label id="PersMedi" style="background-color: transparent; float: right; border-color: transparent;" title="Create Personalised list" onclick="CreatePersonalList()" class="PersBtn">
                    <button type="button" class="btn btn-info margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px; margin-top: 3px;">Pers...</button>
                </label>
                <img id="btnDuplicate" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServices('D')" />
                <img id="btnInformant" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServices('I')">

            </div>
            <label id="btnSave1" style="background-color: transparent; float: right; margin-right: 6%; border-color: transparent; display: none;" title="Save" class="rightbtn">
                <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
            </label>
            <div id="wrapper" style="overflow: hidden; width: 98.5%; margin-left: 16px; overflow-x: auto;" class="wrapperWidth">
                <div class="tableDiv" style="padding-top: 30px;">
                    <table class="HeadRxMainDiv">
                        <thead>
                            <tr style="font-size: 12px; background-color: #fffdc8">
  <th style="width: 4%;"class ="th-info">Info.</th>
                                <th style="width: 25%;" id="TblMedHead"></th>
                                <th style="width: 4%"></th>
                                <th style="width: 7%">Date</th>
                                <th style="width: 12.9%;">Frequency</th>
                                <th style="width: 10%; text-align: center" colspan="2">Duration</th>
                                <th style="width: 5%">Food</th>
                                <th style="width: 10%">Route</th>
                                <th style="width: 8%">Dosage</th>
                                <th style="width: 8.1%">Qty</th>
                                <th style="width: 16%">Remark</th>
                                <th style="width: 4%"></th>
                                <th style="width: 4.5%" id="EmptyHead"></th>
                                <th style="width: 8%" id="chkRoutineMed">Routine
                                    <input type='checkbox' id='chkRoutineMedAll' /></th>
                            </tr>
                        </thead>
                    </table>
                    <table id="tblMaterialList" class="table HeadRxMainDiv" style="width: 100%">
                        <tbody id="tblsort"></tbody>
                    </table>
                </div>
                <div style="margin-top: -20px;">
                    <table id="tblNonFreqMtrlList" style="display: none; width: 100%">
                        <tbody id="tblsort1"></tbody>
                    </table>
                </div>
            </div>
            <div id="layer-intake" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <a href="javascript:;" style="font-size: 14px">Intak1</a>
                <a href="javascript:; " style="font-size: 14px">Intak2</a>
                <a href="javascript:; " style="font-size: 14px">Intak3</a>
                <a href="javascript:;" style="font-size: 14px">Intak4</a>
            </div>
            <div id="layer-durationNum" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
            </div>
            <div id="layer-durationWords" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <a href="javascript:;" onclick="SetText('D')" style="font-size: 14px">Days</a>
                <a href="javascript:; " onclick="SetText('W')" style="font-size: 14px">Weeks</a>
                <a href="javascript:; " onclick="SetText('M')" style="font-size: 14px">Months</a>
                <a href="javascript:;" onclick="SetText('Y')" style="font-size: 14px">Years</a>
            </div>
            <div id="layer-Food" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
                <a href="javascript:; " onclick="SetText('-')" style="font-size: 14px">-</a>
                <a href="javascript:;" onclick="SetText('A')" style="font-size: 14px">After Food</a>
                <a href="javascript:; " onclick="SetText('B')" style="font-size: 14px">Before Food</a>
            </div>
            <div id="layer-Route" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
            </div>
            <div id="layer-Remark" class="po__layer list" onmouseover="document.body.style.overflow='hidden';" onmouseout="document.body.style.overflow='auto';">
            </div>
        </div>
    </div>

    <div style="position: fixed; bottom: 20px; left: 25%; right: 15%; text-align: center; z-index: 1000;">
        <button id="btnSave" onclick="SaveAllMedicines('SS');"
            style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
            onmouseover="this.style.backgroundColor='#218838'"
            onmouseout="this.style.backgroundColor='#28a745'">
            Save
        </button>
    </div>
    <%-- Added by Roshan 20250812 => Dialog For  CIMS Info --%>
    <div id="divCIMSInfo" style="display: none;">
        <div class="CIMS-container">
            <div class="CIMS-header" style="background: #2d70aa; margin-bottom: 4px;">
               

               <div style="display: inline-block; vertical-align: middle; margin-top: 4px; padding-left: 4px; height:33px">
                    <img src="../Images/CIMS_Images/Drug.png" />
                </div>
                <div style="display: inline-block; vertical-align: middle; margin-top: 7px;">
                    <h2 class="CIMS-header-child"></h2>
                </div>
                <div class="CIMS-close" onclick="$('#divCIMSInfo').dialog('close')" title="Close"><i class="fa fa-times"></i></div>
            </div>
            <div class="CIMS-body" id="CIMSBody"></div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>
 <%-- Added By Roshan CIMS Info 20251208 --%>
 <style type="text/css">
     .CIMS-container {
         display: flex;
         flex-direction: column; /* stack header, body, footer */
         width: 100%;
         max-height: 80vh; /* limit dialog height to viewport */
         overflow: hidden; /* prevent container scroll */
     }

     .CIMS-body {
         flex: 1; /* take remaining space */
         overflow-y: auto; /* only this scrolls */
         padding-right: 10px;
         font-size: 13px;
     }


     .CIMS-header img {
         height: 28px;
         width: 28px;
         vertical-align: middle;
         margin-right: 8px;
     }

     .CIMS-header h2 {
         color: white;
         margin: 0;
         font-size: 1.2em;
         flex: 1;
         word-break: break-word;
     }

     .CIMS-body {
         overflow-y: auto;
         overflow-x: hidden;
         padding-right: 10px;
         box-sizing: border-box;
     }
     /* Responsive tweaks for mobile */
     @media (max-width: 768px) {
         .CIMS-header h2 {
             font-size: 1em;
         }

         .CIMS-header img {
             height: 24px;
             width: 24px;
         }

         .CIMS-body {
             padding: 5px;
         }

         .CIMS-footer {
             height: auto;
             padding: 5px 0;
         }
     }

     @media (max-width: 480px) {
         .CIMS-header h2 {
             font-size: 0.9em;
         }

         .CIMS-header img {
             height: 20px;
             width: 20px;
         }
     }


     @keyframes professionalBlink {
         0% {
             opacity: 1;
             transform: scale(1);
         }

         25% {
             opacity: 0.6;
             transform: scale(1.05);
         }

         50% {
             opacity: 1;
             transform: scale(1);
         }

         75% {
             opacity: 0.6;
             transform: scale(1.05);
         }

         100% {
             opacity: 1;
             transform: scale(1);
         }
     }

     /* Class to apply blinking */
     .CIMS-blinking {
         animation: professionalBlink 1s infinite;
         transition: all 0.3s ease;
     }

     .ui-dialog[aria-describedby="divCIMSInfo"] .ui-dialog-titlebar {
         display: none !important;
     }

     .ui-dialog[aria-describedby="divCIMSInfo"] {
         padding-top: 0 !important;
         z-index: 10000;
     }

     .CIMS-close {
         position: absolute;
         top: 12px;
         right: 23px;
         color: #ffffff;
         font-size: 23px;
         font-weight: bold;
         cursor: pointer;
         line-height: 1;
     }

         .CIMS-close:hover {
             color: #ff4d4d;
         }

       #CIMSBody h3.ui-widget-header {
            height: auto !important; 
            padding: 12px 10px !important; 
            line-height: 1.4;
            text-align: center;
            background: #f7f7f7 !important; 
            border: 1px solid #dcdcdc;
            color: #555;
            font-size: 13px;
            font-weight: 600;
            box-sizing: border-box;
            margin: 10px;
       }

 </style>
 <script type="text/javascript">
     const IS_DISPLAY_CIMS_FUNCTIONLITY = '<%= OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("IS_DISPLAY_CIMS_INTEGRATION").ToString().Trim() %>';  // Added By Roshan For Taking  Value For CIMS Integration- 12/10/2025
     function toogleButtons(TableType) {
         var rowCount = $('#tblMaterialList > tbody > tr.active').get();
         if (rowCount.length >= 2) {
             $('#btnInformant,#btnDuplicate').show();
             subscribeCIMSServices("", TableType);
         } else {
             $('#btnInformant,#btnDuplicate').hide();
         }
     }
     function subscribeCIMSServices(type, TableType) {
         if (type == "I") {
             GetDrugInterationService(TableType).then(function (response) {
                 $('#CIMSBody').empty();
                 if (response && response == "0") {
                     $.messager.alert('Warning', 'Kindly Contact IT');
                 } else {
                     if (typeof response == 'object') {
                         if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                             // Append the HTML to #CIMSBody
                             $('#CIMSBody').html(response.HtmlText);
                             $('.CIMS-header-child').text("Drug Interaction");
                             $('#divCIMSInfo').dialog('open');
                         } else {
                             $.messager.alert("Information", response.Status);
                         }
                     }
                 }
             }).catch(function (error) {
                 $.messager.alert('Warning', 'Kindly Contact IT');
             });

         } else if (type == "D") {
             GetDrugDuplicateService(TableType).then(function (response) {
                 $('#CIMSBody').empty();
                 if (response && response == "0") {
                     $.messager.alert('Warning', 'Kindly Contact IT');
                 } else {
                     if (typeof response == 'object') {
                         if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                             // Append the HTML to #CIMSBody
                             $('#CIMSBody').html(response.HtmlText);
                             $('.CIMS-header-child').text("Drug Duplicate");
                             $('#divCIMSInfo').dialog('open');
                         } else {
                             $.messager.alert("Information", response.Status);
                         }
                     }
                 }
             }).catch(function (error) {
                 $.messager.alert('Warning', 'Kindly Contact IT');
             });

         } else {
             // Default: fetch both services to determine alert states and toggle buttons visually
             GetDrugInterationService(TableType).then(function (response) {
                 $('#CIMSBody').empty();
                 if (response && response == "0") {
                     // ignore
                 } else {
                     if (typeof response == 'object') {
                         if (response.AlertYN == true) {
                             Blink('#btnInformant');
                         } else {
                             stopBlink('#btnInformant');
                         }
                     }
                 }
             }).catch(function (error) {
                 $.messager.alert('Warning', 'Kindly Contact IT');
             });

             GetDrugDuplicateService(TableType).then(function (response) {
                 $('#CIMSBody').empty();
                 if (response && response == "0") {
                     // ignore
                 } else {
                     if (typeof response == 'object') {
                         if (response.AlertYN == true) {
                             Blink("#btnDuplicate");
                         } else {
                             stopBlink("#btnDuplicate");
                         }
                     }
                 }
             }).catch(function (error) {
                 $.messager.alert('Warning', 'Kindly Contact IT');
             });
         }
     }
     function preapreDataForCIMS() {
         var MaterialCodes = [];
         var rowCount = $('#tblMaterialList > tbody > tr.active').get();
         for (var i = 0; i < rowCount.length; i++) {
             var code = $(rowCount[i]).children('td.tdDrugCode')[0].innerText.trim();
             MaterialCodes.push(code);
         }
         var DataToSend = {
             DrugCodes: JSON.stringify(MaterialCodes),
             Type: "html"
         };
         return DataToSend;
     }
     function toggleInfoColumn() {
         if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {// Added By Roshan Condtion Based On WebConfigs to Show or Hide
             $(".th-info").show();
         } else {
             $(".th-info").hide();
         }
     }
 </script>
 <script src="../Scripts/_CimsCommon.js"></script>
 <%-- End By Roshan CIMS Info 20251208 --%>
    <style>
        table {
            width: 100%;
        }

        .mediAddspan {
            float: right;
            margin-right: 6px;
            margin-top: -28px;
            position: relative;
            z-index: 2;
            color: #3d7da3;
            cursor: pointer;
        }

        .intakeImageSpan {
            color: #4086bf;
            margin-top: -3px;
            pointer-events: auto;
            cursor: pointer;
        }

        .shadow {
            box-shadow: 2px 2px 2px 2px red;
        }

        .empty {
            width: 62%;
        }

        .OuterRoundWhiteRight {
            background-color: white;
            width: 46px;
            height: 22px;
            border-radius: 2px 12px 12px 2px;
            color: black;
            text-align: center;
            border-width: 1px;
        }

        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
        }

        .DaysNumber {
            width: 17%;
            height: 28px;
            font-size: 22px;
            cursor: pointer;
        }


        .DN1 {
            margin-top: 27px;
            margin-bottom: 10px;
        }

        .DN2 {
            margin-top: 10px;
            margin-bottom: 27px;
        }

        .BtnInke {
            width: 40px;
            border-radius: 20px 20px 20px 20px;
            height: 38px;
            text-align: center;
            margin-right: 20px;
            background-color: rgba(76, 228, 76, 0.67);
            cursor: pointer;
        }

        .borderC:first-child {
            border-radius: 16px 0px 0px 16px;
        }

        .borderC:last-child {
            border-radius: 0 16px 16px 0;
        }

        .NoBorder {
            border: none !important;
        }

        .ParentDivDN {
            background-color: #d4cfcf75;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 65px;
        }

        .selectedNumber {
            background: #2e312e7a !important;
            color: white;
            border-radius: 3px 3px 3px 3px;
            box-shadow: 3px 1px 4px 0px #3a3436;
        }

        .JsBtnPostion {
            text-align: center !important;
        }

        .delFont {
            font-size: 1.5em !important;
        }

        .triggerInputIntake {
            height: 27px;
            font-size: 14px;
        }

        td.MaterialName {
            padding: 5px !important;
            font-size: 12px;
            width: 28%;
        }

        td.tdNewMedSpan {
            width: 4%;
        }

        td.tdIntake {
            width: 15%;
        }

        td.durationNum {
            width: 5%;
        }

        td.MedDate {
            width: 5%;
        }

        td.durationWord {
            width: 5%;
        }

        td.tdBeforeAfter {
            width: 5%;
        }

        td.tdDosses {
            width: 10%;
            font-size: 14px;
        }

        td.tdRemark {
            width: 25%;
        }

        .triggerInputDosses {
            width: 100%;
            height: 27px;
        }

        .triggerInputQty {
            width: 100%;
            height: 27px;
        }

        td.sortTD1 {
            width: 4%;
        }

        td.sortTD2 {
            width: 4%;
        }

        td.tdRoutineMed {
            width: 8%;
        }

        td.tdStatus {
            width: 5%;
        }

        td.tdStatus {
            width: 5%;
        }

        .triggerRoutineMed {
            width: 100%;
            height: 27px;
        }

        tbody::after {
            content: '';
            display: block;
            page-break-after: always;
            page-break-inside: avoid;
            page-break-before: avoid;
        }

        @media only screen and (min-width : 992px) {

            .rightbtn {
                margin-right: 99px;
            }

            .divtblDisease {
                height: 400px !important;
                overflow-y: scroll !important;
            }

                .divtblDisease:hover {
                    overflow-y: scroll !important;
                }
        }


        @media only screen and (min-width : 992px) {
            .divtblDisease {
                height: 500px !important;
                overflow-y: hidden !important;
            }

                .divtblDisease:hover {
                    overflow-y: scroll !important;
                    transition-duration: 0.4s;
                    transition-timing-function: cubic-bezier(0.36, 0.55, 0.19, 1);
                    border-color: white;
                }
        }

        @media only screen and (min-width:1400px) {
            .empty {
                width: 47.2%;
            }

            .PersBtn {
                margin-right: -7.40% !important;
            }

            .fillBtn {
                margin-right: 15.6%;
            }


            .StuckInput button {
                margin-left: 1%;
            }
        }

        @media only screen and (min-width: 1366px) and (max-width: 1399px) {
            .fillBtn {
                margin-right: 17%;
            }

            .empty {
                width: 49.2%;
            }

            .PersBtn {
                margin-right: -7.40% !important;
            }
        }

        @media only screen and (min-width: 1024px) and (max-width: 1365px) {
            .empty {
                width: 46.2%;
            }

            .fillBtn {
                margin-right: 21%;
            }

            .PersBtn {
                margin-right: -10.4% !important;
            }

            #EmptyHead {
                width: 4.8% !important;
            }
        }

        .sortTD {
            width: 20px !important;
        }


        .JsBtnPostion {
            text-align: center !important;
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            font-size: 14px !important;
            text-decoration: inherit;
        }

        .tdDe {
            width: 5px !important;
        }

        .disable-clicks {
            pointer-events: none;
            color: red;
        }

        @media (min-width: 1200px) {
            .container {
            }
        }

        .divtblDisease {
            height: 300px;
            overflow-y: scroll !important;
        }

        div.divtblDisease::-webkit-scrollbar {
            width: 8px;
        }

        div.divtblDisease::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblDisease::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

        div.divtblDisease:hover {
            overflow-y: scroll;
        }

        #tblPersDiseaselist > tbody > tr > td {
            border-top: 1px solid rgba(234, 228, 228, 0.32) !important;
        }

        .ui-jqgrid tr.jqgrow td {
            word-wrap: break-word;
            white-space: pre-wrap;
            white-space: -moz-pre-wrap;
            white-space: -pre-wrap;
            white-space: -o-pre-wrap;
            overflow: hidden;
            height: auto;
            vertical-align: middle;
            padding-top: 3px;
            padding-bottom: 3px;
        }

        .RemarkSelc {
            -moz-appearance: none;
            text-indent: 1px;
            width: 77px;
            background-color: white;
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 26px;
            outline: 0;
        }

        #tblMaterialList tr td:not(:first-child) a {
            width: 100%;
            display: block;
        }

        @media (min-width: 992px) {
            .jconfirm-box-container {
                margin-left: 24.333333%;
            }
        }

        .jconfirm .jconfirm-scrollpane {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            overflow-y: scroll;
            -webkit-perspective: 500px;
            perspective: 500px;
            -webkit-perspective-origin: center;
            perspective-origin: center;
        }

        .jc-bs3-container {
        }

        .table > tbody > tr.active > td:not(.MaterialName):not(.tdRemark) {
            border-left: 1px solid #bbbbbb;
            padding-left: 0px;
            padding-right: 0px;
            padding-top: 3px;
            padding-bottom: 0px;
            text-align: center;
            vertical-align: middle;
        }

        .table > tbody > tr.active > td > a {
            width: 100%;
            display: table;
        }

        .HeadRxMainDiv {
            min-width: 500px;
        }

            .HeadRxMainDiv > thead,
            .HeadRxMainDiv > tbody > tr {
                display: table;
                width: 100%;
                table-layout: fixed;
            }

            .HeadRxMainDiv > tbody {
                display: block;
                max-height: 500px;
                overflow-x: hidden;
                overflow-y: scroll;
            }

                .HeadRxMainDiv > tbody > tr > td {
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

            .HeadRxMainDiv > thead > tr > th {
                text-align: center;
                border: 1px solid #ede4e4;
            }

            .HeadRxMainDiv > thead > tr,
            .HeadRxMainDiv > tbody > tr {
                width: 100%;
            }

        @media (min-width: 1400px) {
            .HeadRxMainDiv {
                min-width: 600px;
            }

                .HeadRxMainDiv > tbody {
                    display: block;
                    max-height: 600px;
                    overflow-x: hidden;
                    overflow-y: scroll;
                }
        }

        .has-feedback .form-control {
            padding-right: 27.5px;
        }

        .formintakecontrol {
            position: absolute;
            top: 4px;
            right: 0;
            z-index: 2;
            display: block;
            width: 27px;
            height: 25px;
            text-align: center;
            line-height: 28px !important;
            background: #ffebf6;
            border-radius: 0px 5px 5px 0px;
        }

        .JsBoxCss {
            width: 400px;
            height: 160px;
        }

        .JsBoxCssButtons {
            margin-top: 50px;
        }

        .ui-autocomplete {
            max-height: 500px;
            overflow-y: auto;
            overflow-x: hidden;
            z-index: 1000 !important;
        }

        @media only screen and (min-width: 1400px) {
            .ui-jqgrid-bdiv {
                max-height: 180px;
            }

            .jconfirm-box:hover {
                overflow-y: scroll !Important;
            }

            .jconfirm .jconfirm-scrollpane {
                overflow-y: scroll !Important;
            }
        }
    </style>
    <script>
        var stopProp = true;
        var ResponseCheck = '';
        var ResponseCheck1 = '';
        var srvcgrpname = "dblServiceHelpsrvcgrp";
        var IncrementalValue = '';
        var RalVal = '';
        var DaysRow1 = '';
        var DaysRow2 = '';
        var labelVal = '';
        var SelectedNumber = '';
        var SelectedDWM = '';
        var SelectedDWMText = '';
        var SelectedBAFood = ''
        var SelectedINTStemnt = ''
        var CalculatdIntake = '';
        var rowNoFrMedTaper = 0;
        var ItakesArray = [];
        var ItakesTabArray = [];
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
         GetSetUpList("RxDesk");
         var isPersSetupOtherMandatoryChkYn = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RXSetupFieldsMandatory")%>';
        var RemarkArray = "<%:ViewData["RemarkArray"] as System.Collections.Generic.List<object>%>";
         <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var RemarkArray = '<%:Html.Raw(Samp.Serialize(ViewBag.RemarkArray))%>';
        var MedRoute = '<%:Html.Raw(Samp.Serialize(ViewBag.MedRoute))%>';
        var CommonForRemark = [];
        var DoseMandatoryYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DoseMandatoryYN")%>';
         var ShowroutineFeature = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ShowRoutinefeature")%>';
        var strRoutine = "";
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
        var FreqUsedMatrlLst = [];

        $(document).ready(function () {
            BindIntakeCombination();
            toggleInfoColumn();//To Hide And Show The Info Column Added By Roshan 16/12/2025
            sessionStorage.setItem('activeTab', "");
             if (GeneralWiseYN == "Y") {
                 document.getElementById('ComplaintInput').placeholder = '\uf002  Search Generic';
                 document.getElementById("TblMedHead").innerText = "Generic";
             }
             else {
                 document.getElementById('ComplaintInput').placeholder = '\uf002  Search Medicines';
                 document.getElementById("TblMedHead").innerText = "Medicine";
             }
             if (ShowroutineFeature == "N" || ShowroutineFeature == "") {
                 $("#RFillButton").css("display", "none");
                 $("#chkRoutineMed").css("display", "none");
                 $("#chkRoutineMedAll").css("display", "none");
             }
             CommonForRemark = JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t")) == "" ? [] : JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
             HoldOn.open();
             LoadAllpopUps();
             SetPatientDtl();
             AddMedicines();
             //BindIntakeCombination();
             document.getElementById('ComplaintInput').focus();
             if ($(window).width() >= 996) {
                 $("#PatAdviceSetUpList").css("display", "block");
                 var menuL = document.getElementById('menuList');
                 menuL.style.display = "block";
                 var dispLst = document.getElementById('sideList');
                 $("#slide_sdList").click();
                 ActiveMenu("RxDesktop");
                 var tblheadHeight = $("#PatAdviceSetUpList").height();
                 var menulistheight = $("#menuList").height();
                 $('#divMenuList').css("height", (menulistheight - (tblheadHeight + 7)) + "px");
             }
             if ($(window).width() >= 1200)
                 $("#tabMenu").css("display", "block");

             $("#chkRoutineMedAll").click(function () {
                 var rows = $('#tblMaterialList > tbody > tr.active').get();
                 if ($("#chkRoutineMedAll").is(':checked')) {
                     for (var i = 0; i < rows.length; i++) {
                         $(rows[i]).children('td.tdRoutineMed').find('input')[0].checked = true;
                     }
                 }
                 else {
                     for (var i = 0; i < rows.length; i++) {
                         $(rows[i]).children('td.tdRoutineMed').find('input')[0].checked = false;
                     }
                 }

             });

             $("#FillButton").click(function () {
                 var Mrno = ($.session.get('PatMRNO'));
                 var strTran = ($.session.get('PatTRANNO'))
                 var RefillResult;
                 $.confirm({
                     title: 'Medicine Fill Confirmation',
                     content: 'Are you sure want to refill last prescribed Medicine ?',
                     buttons: {
                         confirm: function () {
                             $.ajax({
                                 type: "POST",
                                 url: "<%=Url.Action("RefillMedicine","DoctorDesk")%>",
                                 data: { strTranNO: strTran, strMRNo: Mrno, cimsYN: "N" },
                                 async: false,
                                 success: function (response) {
                                     RefillResult = response
                                 },
                                 complete: function () {
                                     if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                         GetSavedData();
                                     }
                                     else {
                                         $.alert('No medicine present to refill for current transaction');
                                     }
                                 },
                                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                                     HoldOn.close();
                                     $.messager.alert("Error", errorThrown);
                                 },
                             });
                         },
                         cancel: function () {
                             $.alert('Canceled!');
                         },
                     }
                 });
             });

             $("#RFillButton").click(function () {
                 FillSelectedRoutineMed();
             });

             $("#btnSave").click(function () {
                 SaveAllMedicines("N");
             });

             $(document).on("click", function () {
                 var arreay = [
                   "2 drops",
                   "5 drops",
                   "0.5 ml",
                   "1 ml",
                   "1.5 ml",
                   "2 ml",
                   "2.5 ml",
                   "3 ml",
                   "3.5 ml",
                   "4 ml",
                   "4.5 ml",
                   "5 ml",
                   "5.5 ml",
                   "6 ml",
                   "6.5 ml",
                   "7 ml",
                   "7.5 ml",
                   "8 ml",
                   "8.5 ml",
                   "9 ml",
                   "9.5 ml",
                   "10 ml"];
                 var len = $(".triggerInputDosses").closest("input[type='text']").prevObject.length;
                 for (var i = 0; i < len  ; i++) {
                     var text = $(".triggerInputDosses").closest("input[type='text']").prevObject[i];
                     var txtObj = $("#" + text.id);
                     txtObj.autocomplete({
                         source: arreay,
                         minLength: 0
                     }).focus(function () {
                         $(this).autocomplete("search", "");
                     });
                 }
             });

             $("#myAdd").click(function () {
                 $.confirm({
                     title: '',
                     boxWidth: '90%',
                     useBootstrap: false,
                     content: '' +
                         '<style>' +
                         '.custom-popup .jconfirm-box { min-width: 300px !important; }' +
                         '</style>' +
                     '<form action="" class="formName" style="height:120px">' +
                     '<div class="form-group">' +
                     '<label>' + (GeneralWiseYN == "Y" ? "Generic" : "Medicine") + '</label>' +
                      '<textarea  id="txtMedicine" maxlength="195"  placeholder="' + (GeneralWiseYN == "Y" ? "Generic" : "Medicine") + '" autofocus="autofocus" class="medicine form-control"   rows="4" required />' +//kavita
                     '</form>',
                     buttons: {
                         formSubmit: {
                             text: 'Save',
                             btnClass: 'btn-blue',
                             action: function () {
                                 var medicine = this.$content.find('.medicine').val().toString().trim().replace(/\s/g, ' ');
                                 var grpCode = "";
                                 if (medicine == "") {
                                     $.alert('Enter Medicine');
                                     return false;
                                 }
                                 if (medicine != "") {
                                     jQuery.expr[':'].contains = function (a, i, m) {
                                         return jQuery(a).text().toUpperCase()
                                             .indexOf(m[3].toUpperCase()) >= 0;
                                     };
                                     rowNoFrMedTaper = rowNoFrMedTaper + 1;
                                     var medCode = "NEW" + rowNoFrMedTaper;
                                     if ($('#tblMaterialList tr.display > td.MaterialName:contains(' + medicine + ')').length == 0) {//
                                         var row = "";
                                         row += "<tr class='' id='" + medCode + "'>" +
                                         (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y" ? "<td class='MedIcon' style='width:4%'>" + "<i class='fa fa-info-circle MedInfoIcon' style='font-size:18px; cursor:pointer;' aria-hidden='true' onclick=\"getDrugInfo('" + medCode + "')\"></i>" + "</td>" : "") +  // Added By Roshan Condtion Based On WebConfigs to Add The Row Or Not

                                         "<td class='MaterialName' style='padding:5px;font-size: 13px;width:25%'>" + medicine + "</td><td class='tdNewMedSpan' style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + "" + "</td><td class='GenricID' style='display:none'>" + "" + "</td>" +
                                         "<td class='MedDate' style='width:7%' ><a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + medCode + "' style='display:none;font-size:14px'>" + GetCurrentDate() + "</a></td>" +
                                         "<td class='tdIntake' style='width:12.9%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + medCode + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake'></span></div></td>" +//4/12/19
                                         "<td class='durationNum' style='width:5%' ><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + medCode + "' style='display:none;font-size:14px'>0</a></td>" +
                                         "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + medCode + "' style='display:none;font-size:14px'>D</a></td>" +
                                         "<td class='tdBeforeAfter'style='width:5%' ><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + medCode + "' style='display:none;font-size:14px'>-</a></td>" +
                                         "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + medCode + "' style='display:none;font-size:14px'>Per oral</a><input type='hidden' id='hdn" + medCode + "' value='09' /></td>" +//kavita 08-aug
                                         "<td class='tdDosses' style='width:8%'><input type='text'class='triggerInputDosses form-control' style='display:none;' placeholder='Dose' id='dossage" + medCode + "' /></td>" +
                                         "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control' style='display:none;' placeholder='Qty/Nos.' id='Qty" + medCode + "' /></td>" +
                                         "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + medCode + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + medCode + "' /></td>" +
                                         "<td class='tdDrugCode' style='display:none'>" + medCode + "</td>" +
                                         "<td class='setupyn' style='display:none'>N</td>" +
                                         "<td class='refillyn' style='display:none'>N</td>" +
                                         "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                                         "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>" +
                                         (ShowroutineFeature == "Y" ?
                                        "<td class='tdRoutineMed' style='width:8%'><input type='checkbox'  style='display:none;' id='chkRoutineMed" + medCode + "' /></td>" : "") +
                                         "<td class='tdStatus' style='display:none'>A</td>";
                                         row += "</tr>";
                                         $("#tblMaterialList tbody").append(row).closest('tr');
                                         $('#tblMaterialList tr#' + medCode).trigger('click');
                                         $("#tblMaterialList tr#" + medCode + " input.triggerInputIntake").autocomplete({
                                             source: ItakesArray,
                                             autoFocus: false,
                                             minLength: 0,
                                             select: function (event, ui) {
                                                 var txtval = ui.item.value;
                                                 var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                                                 var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();
                                                 var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();
                                                 var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();
                                                 var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;
                                                 var route = $(this).parents('td').siblings('.tdRoute').find('a').text();
                                                 var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();
                                                 var tableRow = $("#tblMaterialList tr").filter(function () {
                                                     return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim();
                                                 }).closest("tr");
                                                 if (tableRow.length > 0) {
                                                     $.messager.alert('Information', 'This medicine and Frequency already present');
                                                     $(this).val('');
                                                     $(this).focus();
                                                     return false;
                                                 }
                                                 else {
                                                     if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                                         $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                                                         $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                                                         $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                                         var TabCount = CalculateTabCount(txtval, 0, "D");
                                                         $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                                                         $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                                                     }
                                                     else {
                                                         var TabCount = CalculateTabCount(txtval, durationNum, durationWord);
                                                         $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                                                         $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                                         $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                                                     }
                                                 }
                                             }
                                         }).focus(function () {
                                             if ($("ul.ui-autocomplete").is(":hidden")) {
                                                 $(this).autocomplete('search', '');
                                             }
                                         });
                                         $("#tblMaterialList tr#" + medCode + "" + " input.triggerInputIntake").trigger("focus");
                                     }
                                     else {
                                         $.messager.alert("Information", "This Medicine already selected");
                                         $('#ComplaintInput').val(medicine);
                                         SearchComplaint();
                                     }
                                 }
                             }
                         },
                         cancel: function () {

                         },
                     },
                     onContentReady: function () {
                         $('#txtMedicine').focus();
                         var jc = this;
                         this.$content.find('form').on('submit', function (e) {
                             e.preventDefault();
                             jc.$$formSubmit.trigger('click');
                         });
                     }
                 });
             });

             $(".removeMedicine").click(function (e) {
                 e.stopPropagation();
                 var CurrenRow = ($(this)[0].closest('tr'));
                 var CurrenRowId = $(CurrenRow).attr('id');
                 var strTranNo = $.session.get("PatTRANNO");
                 RemoveMedicine(CurrenRowId, strTranNo);
             });

             $('.triggerIntake,.triggerNum,.triggerDays,.triggerFood,.triggerRemark,.triggerRoute').po({
                 alignment: 'center'
             });

             $("#layer-durationNum .NumDaysCls").click(function (e) {
                 var txt = $(this).text();
                 SetText(txt);
                 var txtval = $("#" + idOfPopUpAnchor).closest('tr').find('input.triggerInputIntake')[0].value;
                 var durationWord = $("#" + idOfPopUpAnchor).closest('tr').find('td.durationWord').text();
                 var TabCount = CalculateTabCount(txtval, txt, durationWord);
                 $("#" + idOfPopUpAnchor).closest('tr').find('input.triggerInputQty')[0].value = TabCount;
             });
             $("#layer-durationWords").click(function (e) {
                 var txtval = $("#" + idOfPopUpAnchor).closest('tr').find('input.triggerInputIntake')[0].value;
                 var durationNum = $("#" + idOfPopUpAnchor).closest('tr').find('td.durationNum').text();
                 var durationWord = $("#" + idOfPopUpAnchor).closest('tr').find('td.durationWord').text();
                 var TabCount = CalculateTabCount(txtval, durationNum, durationWord);
                 $("#" + idOfPopUpAnchor).closest('tr').find('input.triggerInputQty')[0].value = TabCount;
             });

             $("#layer-Food").click(function (e) {
             });

             $(document.body).on('click', '.triggerMedDate', function () {
                 let $this = $(this);
                 if ($this.next('input.dateInput').length === 0) {
                     let currentVal = $this.text().trim();
                     let $input = $('<input type="text" class="dateInput" style="width: 100px;" />').val(currentVal);
                     $this.hide();
                     $this.after($input);
                     $input.datepicker({
                         minDate: new Date(),
                         dateFormat: 'dd/mm/yy',
                         onClose: function (selectedDate) {
                             if (selectedDate) {
                                 $this.text(selectedDate);
                             }
                             $this.show();
                             $input.remove();
                         }
                     }).datepicker('show');
                 }
             });

             $(document.body).on('click', '#layer-Remark .anchorRemark', function (e) {
                 var txt = $(this).text();
                 var code = $(this)[0].id;
                 SetRemarkText(txt, code);
             });

             $(document.body).on('click', '#layer-Route .anchorRoute', function (e) {
                 var txt = $(this).text();
                 var code = $(this)[0].id;
                 SetRouteText(txt, code);
             });

             $(document.body).on('click', '.triggerIntake,.triggerNum,.triggerDays,.triggerFood,.triggerInputDosses,.triggerInputQty,.triggerInputIntake,.triggerRemark,.triggerRoute, .triggerNewIntake,.triggerPrepend,.triggerAppend, .triggerRoutineMed', function (e) {
                 e.stopPropagation();
                 idOfPopUpAnchor = $(this).attr("id");
                 if ($(this).is('.triggerPrepend')) {
                     var currntRow = $(this).closest('tr');
                     if (currntRow.hasClass('active')) {
                         if (currntRow.prev().length) {
                             if ($(currntRow.prev()).hasClass('active'))
                                 currntRow.prev().before(currntRow);
                         }
                     }
                     stopProp = false;
                 }
                 if ($(this).is('.triggerAppend')) {
                     var currntRow = $(this).closest('tr');
                     if (currntRow.next().length) {
                         if ($(currntRow.next()).hasClass('active'))
                             currntRow.next().after(currntRow);
                     }
                     stopProp = false;
                 }
                 $("#searchRemark").val("");
                 $("#searchRoute").val("");
                 searchRemark();
                 searchRoute();
             });

             $(document.body).on('click', '#tblMaterialList td a,#tblMaterialList td', function (e) {
                 var elm = $(this).parents("tr")[0].id;
                 var PhStatus = $("#tblMaterialList tr#" + elm + " .tdStatus")[0].innerText;
                 if (PhStatus != "A") {
                     $.messager.alert('Information', 'This medicine is already issued to the patient from pharmacy');
                     $('#' + $(this).data('layer-id')).addClass('is-active');
                     e.stopPropagation();
                 }
                 else {
                     $.each($("tr#" + elm + " td a"), function (i, val) {
                         var divId = $(this).attr("data-layer-id");
                         $("div#" + divId + "").css("display", "none");
                     });
                     $("div#" + $(this).attr("data-layer-id") + "").css("display", "block");
                     $('#' + $(this).data('layer-id')).removeClass('is-active');
                     if (!$(this).is('.MaterialName'))
                         e.stopPropagation();
                     if ($(this).is('.MaterialName')) {
                         var Code = GeneralWiseYN == "Y" ? $("#tblMaterialList tr#" + elm + " .GenricID")[0].innerText : $("#tblMaterialList tr#" + elm + " .tdDrugCode")[0].innerText;
                         GetDefaultRoute(Code);
                     }
                 }
             });

             $(document.body).on('click', '#tblMaterialList td.tdIntake span.intakeImageSpan', function (e) {
                 e.stopPropagation();
                 NewIntake("Out", e);
             });

             $(document.body).on('click', '#tblMaterialList td span.addMedFrDiffIntk', function (e) {
                 var drugCode = $(this).parents('td').siblings(".tdDrugCode")[0].innerText.trim();
                 var rowId = ($(this)[0].closest('tr').id).trim();
                 var mediName = $("#tblMaterialList tr#" + rowId + " .MaterialName")[0].innerText;
                 var genericId = $("#tblMaterialList tr#" + rowId + " .GenricID")[0].innerText;
                 var genericName = $("#tblMaterialList tr#" + rowId + " .GenriName")[0].innerText;
                 var routeNM = $("#tblMaterialList tr#" + rowId + " .tdRoute")[0].innerText;
                 var PhStatus = $("#tblMaterialList tr#" + rowId + " .tdStatus")[0].innerText;
                 var row = "";
                 var dt = new Date();
                 rowNoFrMedTaper = Number(rowNoFrMedTaper) + 1;
                 var newCode = rowId + "_T" + rowNoFrMedTaper;
                 var route = ""; var routeCD = "";
                 if ((mediName.toUpperCase().indexOf(" TAB") > -1 || mediName.toUpperCase().indexOf("TAB ") > -1 || mediName.toUpperCase().indexOf(" SYP") > -1 ||
                     mediName.toUpperCase().indexOf("SYP ") > -1 || mediName.toUpperCase().indexOf(" CAP") > -1 || mediName.toUpperCase().indexOf("CAP ") > -1 ||
                     mediName.toUpperCase().indexOf("TABLET") > -1 || mediName.toUpperCase().indexOf("CAPSULE") > -1 || mediName.toUpperCase().indexOf("SYRUP") > -1)
                     && routeNM == "Route") {
                     route = "Per Oral"; routeCD = "09";
                 }
                 else if (routeCD != "") {
                     route = routeNM;
                     routeCD = routeCD;
                 }
                 else {
                     route = "Route"; routeCD = "";
                 }
                 var PervDur = $(this).closest('tr').find(".triggerNum").text().trim() == "" ? 0 : Number($(this).closest('tr').find(".triggerNum").text().trim());
                 var PervDurType = $(this).closest('tr').find(".triggerDays").text().trim();
                 var PrevDate = $(this).closest('tr').find(".triggerMedDate").text().trim() == "" ? GetCurrentDate() : $(this).closest('tr').find(".triggerMedDate").text().trim();
                 var NextMedDate = CalcNextMedDate(PervDur, PervDurType, PrevDate);
                 row += "<tr class='' id='" + newCode + "'>" +
                           (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y" ? "<td class='MedIcon' style='width:4%'>" + "<i class='fa fa-info-circle MedInfoIcon' style='font-size:18px; cursor:pointer;' aria-hidden='true' onclick=\"getDrugInfo('" + drugCode + "')\"></i>" + "</td>" : "") +// Added By Roshan Condtion Based On WebConfigs to Add The Row Or Not
                          "<td class='MaterialName' style='width:25%'>" + mediName + "</td><td style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + genericName + "</td><td class='GenricID' style='display:none'>" + genericId + "</td>" +
                          "<td class='MedDate' style='width:7%' ><a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + newCode + "' style='display:none;font-size:14px'>" + NextMedDate + "</a></td>" +
                          "<td class='tdIntake' style='width:12.9%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + newCode + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake' ></span></div></td>" +//intake 4/12/19
                          "<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + newCode + "' style='display:none;font-size:14px'>0</a></td>" +
                          "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + newCode + "' style='display:none;font-size:14px'>D</a></td>" +
                          "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + newCode + "' style='display:none;font-size:14px'>-</a></td>" +//after food before food
                          "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route'  id='Route" + newCode + "' style='display:none;font-size:14px'>" + route + "</a><input type='hidden' id='hdn" + newCode + "' value='" + routeCD + "'/></td>" +
                         "<td class='tdDosses' style='width:8%'><input type='text'class='triggerInputDosses form-control'  style='display:none;' placeholder='Dose' id='dossage" + newCode + "' /></td>" + //dosses
                         "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' id='Qty" + newCode + "' /></td>" + //Total Qty
                         "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + newCode + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + newCode + "' /></td>" +//
                         "<td class='tdDrugCode' style='display:none'>" + drugCode + "</td>" +
                          "<td class='setupyn' style='display:none'>N</td>" +
                          "<td class='refillyn' style='display:none'>N</td>" +
                 "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                            "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>" +
                   (ShowroutineFeature == "Y" ? "<td class='tdRoutineMed' style='width:8%'><input type='checkbox'   style='display:none;' id='chkRoutineMed" + newCode + "' /></td>" : "") + //Total Qty;
                 "<td class='tdStatus' style='display:none'>A</td>";
                 row += "</tr>";
                 $(row).insertAfter($("#tblMaterialList tr#" + rowId));
                 $("#tblMaterialList tr#" + newCode + "").trigger("click");
                 $("#tblMaterialList tr#" + newCode + "").insertAfter($("#tblMaterialList tr#" + rowId));
                 $("#tblMaterialList tr#" + newCode + "" + " input.triggerInputIntake").autocomplete({
                     source: ItakesArray,
                     autoFocus: false,
                     minLength: 0,
                     select: function (event, ui) {
                         var txtval = ui.item.value;
                         var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                         var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();
                         var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();
                         var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();
                         var dossage = $(this).parents('td').siblings('.tdDosses').find('a').text();
                         var Qty = $(this).parents('td').siblings('.tdQty').find('a').text();
                         var route = $(this).parents('td').siblings('.tdRoute').find('a').text();
                         var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();
                         var tableRow = $("#tblMaterialList tr").filter(function () {
                             return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim();
                         }).closest("tr");
                         if (tableRow.length > 0) {
                             $.messager.alert('Information', 'This medicine and Frequency already present');
                             $(this).val('');
                             $(this).focus();
                             return false;
                         }
                         else {
                             if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                 $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                                 $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                                 var TabCount = CalculateTabCount(txtval, 0, "D");
                                 $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                                 $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                 $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                             }
                             else {
                                 var TabCount = CalculateTabCount(txtval, durationNum, durationWord);
                                 $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                                 $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                 $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                             }
                         }
                     }
                 }).focus(function () {
                     if ($("ul.ui-autocomplete").is(":hidden")) {
                         $(this).autocomplete('search', '');
                     }
                 });
                 $("#tblMaterialList tr#" + newCode + "" + " input.triggerInputIntake").trigger("focus");
                 $("#tblMedicineList tr#" + newCode + "").find("input.triggerInputIntake").trigger("keydown");
             });
             document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);
             var options = {
                 source: ItakesArray,
                 autoFocus: false,
                 minLength: 0,
                 select: function (event, ui) {
                     var txtval = ui.item.value;
                     idOfPopUpAnchor = $(this).parents('td').find('input')[0].id;
                     if (ValidateUniqueRow(txtval)) {
                         if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                             $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                             $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                             var TabCount = CalculateTabCount(txtval, 0, "D");
                             $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                             $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                             $(this).parents('td').siblings('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                         }
                         else {
                             var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();
                             var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();
                             var TabCount = CalculateTabCount(txtval, durationNum, durationWord);
                             $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                             $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                             $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                         }
                     }
                     else {
                         event.preventDefault();
                     }
                 },
                 open: function (event, ui) {
                     $(this).addClass("hasAutoComplete");
                 },
                 close: function (event, ui) {
                     $(this).removeClass("hasAutoComplete");
                 }
             };

             $(document).on('keydown.autocomplete ', '.triggerInputIntake', function () {
                 $(this).autocomplete(options);
             });

             $('.triggerInputIntake').autocomplete(options).focus(function () {
                 if ($("ul.ui-autocomplete").is(":hidden")) {
                     $(this).autocomplete('search', '');
                 }
             });

             $(".triggerInputIntake").blur(function () {
                 var keyEvent = $.Event("keydown");
                 keyEvent.keyCode = $.ui.keyCode.ENTER;
                 $(this).trigger(keyEvent);
                 var txtval = $(this).val();

             }).autocomplete(options);
             $(".triggerInputDosses").attr('maxlength', '15');
             $(".triggerInputQty").attr('maxlength', '15');
             $(".triggerRoutineMed").attr('checked', 'false');
             $(document.body).on("click", "#spanAddNewMedInSetUp", function (e) {
                 var LblHeader = GeneralWiseYN == "Y" ? "Generic" : "Medicine";
                 $.confirm({
                     title: '',
                     closeIcon: true,
                     offsetTop: 10,
                     type: 'orange',
                     backgroundDismissAnimation: 'glow',
                     theme: 'bootstrap',
                     content: '' +
                     '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New ' + LblHeader + '</label><br>' +
                     '<input  type="varchar" id="txtNewMed"  placeholder="Enter ' + LblHeader + '" autofocus="autofocus" class="setUp form-control" required />' +
                     '</div>' +
                     '</form>',
                     buttons: {
                         formSubmit: {
                             text: 'Save',
                             btnClass: 'btn-blue',
                             action: function () {
                                 var medName = $("#txtNewMed").val();
                                 var newRow = {
                                     act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                     CODE: "NEW",
                                     NAME: medName
                                 };
                                 if (GeneralWiseYN == "Y") {
                                     newRow = {
                                         act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                         CODE: "NEW",
                                         GENERICID: "NEW",
                                         NAME: medName,
                                         GENERICNAM: medName,
                                     };
                                 }
                                 $('#tblGrid').addRowData("NEW", newRow, 'last');
                                 $("#dblServiceHelpsrvcgrp").show();
                                 $("#divSrvcGrpGrid").show();
                             }
                         },
                         Closed: {
                             text: 'Cancel'
                         }
                     }
                 });
             });

             (function ($) {
                 $.fn.extend({
                     donetyping: function (callback, timeout) {
                         timeout = timeout || 1e3;
                         var timeoutReference,
                             doneTyping = function (el) {
                                 if (!timeoutReference) return;
                                 timeoutReference = null;
                                 callback.call(el);
                             };
                         return this.each(function (i, el) {
                             var $el = $(el);
                             $el.is(':input') && $el.on('keyup keypress paste', function (e) {
                                 if (e.type == 'keyup' && e.keyCode != 8) {
                                     if ($(this).val() != "")
                                         return;
                                 }
                                 if (timeoutReference) clearTimeout(timeoutReference);
                                 timeoutReference = setTimeout(function () {
                                     doneTyping(el);
                                 }, timeout);
                             }).on('blur', function () {
                                 doneTyping(el);
                             });
                         });
                     }
                 });
             })(jQuery);

             $('#ComplaintInput').donetyping(function () {
                 SearchComplaint();
                 $("#tblNonFreqMtrlList").hide();
             });

             $(document.body).on("keydown", ".triggerInputQty", function (e) {
                 if (e.which == 9) {
                     idOfPopUpAnchor = $(this)[0].id;
                     if (idOfPopUpAnchor.toUpperCase().indexOf("DOSSAGE") != -1)
                         $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRemark').find('a.triggerRemark').trigger('click');//vijeta 20/4/19
                 }
                 ValidateUniqueRow();
             });

             $(document.body).on('change', '.triggerRoutineMed', function () {
                 var _val = $(this).is(':checked') ? 'checked' : 'unchecked';
             });

             $(document.body).on("keydown", ".triggerInputIntake", function (e) {
                 if (e.shiftKey || e.ctrlKey || e.altKey) {
                     e.preventDefault();
                 } else {
                     var key = e.keyCode;
                     if (typeof key != "undefined") {
                         if ((key >= 48 && key <= 90) || (key >= 96 && key <= 105) || key == 109 || key == 189 || key == 8 || key == 110 || key == 190 || key == 191 || key == 111) {
                             return true;
                         }
                         else {
                             return false
                         }
                     }
                 }
             });
         });

         function ValidateUniqueRow(txtval) {
             var intakeVal = "";
             if (txtval != undefined)
                 intakeVal = txtval
             else
                 intakeVal = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdIntake')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdIntake').find('input')[0].value
             var mediName = $("#" + idOfPopUpAnchor).parents('td').prevAll('.MaterialName').text();
             var durationNum = ($("#" + idOfPopUpAnchor).parents('td').hasClass('durationNum')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.durationNum').find('a').text();
             var durationWord = ($("#" + idOfPopUpAnchor).parents('td').hasClass('durationWord')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.durationWord').find('a').text();
             var food = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdBeforeAfter')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdBeforeAfter').find('a').text();
             var dossage = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdDosses')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdDosses').find('input')[0].value;
             var route = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdRoute')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdRoute').find('a').text();
             var remark = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdRemark')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdRemark').find('a').text();
             var tableRow = $("#tblMaterialList tr").filter(function () {
                 return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (intakeVal).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim();
             }).closest("tr");
             if ((tableRow.length > 1 && txtval == undefined) || (tableRow.length > 0 && txtval != undefined)) {
                 $.messager.alert('Information', 'This medicine and frequency already present');
                 ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdIntake')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value = "" : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdIntake').find('input')[0].value = "";
                 return false;
             }
             return true;
         }

         function SaveAllMedicines(strPlusButton) {
             var mrno = ($.session.get('PatMRNO')).toString();
             var tranNo = ($.session.get('PatTRANNO')).toString();
             var medicineArr = [];
             var rows = $('#tblMaterialList > tbody > tr.active').get();
             for (var i = 0; i < rows.length; i++) {
                 var code = $(rows[i]).children('td.tdDrugCode')[0].innerText.trim();
                 var medGenName = $(rows[i]).children('td.MaterialName')[0].firstChild.textContent;
                 var MedicineName = $(rows[i]).children('td.MaterialName')[0].firstChild.textContent;
                 var MedicineName = "";
                 if (code.indexOf("NEW") < 0) {
                     MedicineName = medGenName.substr(0, medGenName.lastIndexOf("(")).trim();
                 }
                 if (MedicineName == "")
                     MedicineName = medGenName;
                 var Intake = $(rows[i]).children('td.tdIntake').find('input.triggerInputIntake')[0].value;
                 var Duration = $(rows[i]).children('td.durationWord')[0].innerText;
                 var Days = $(rows[i]).children('td.durationNum')[0].innerText;
                 var Food = $(rows[i]).children('td.tdBeforeAfter')[0].innerText;
                 var Dosses = $(rows[i]).children('td.tdDosses').find('input.triggerInputDosses')[0].value;
                 var Qty = $(rows[i]).children('td.tdQty').find('input.triggerInputQty')[0].value;
                 var Route = $(rows[i]).children('td.tdRoute').children('input')[0].value;
                 var Remark = $(rows[i]).children('td.tdRemark').children('input')[0].value;
                 var setupyn = $(rows[i]).children('td.setupyn')[0].innerText;
                 var refillyn = $(rows[i]).children('td.refillyn')[0].innerText;
                 var RoutineMed = ($(rows[i]).children('td.tdRoutineMed').find('input').is(':checked') ? "Y" : "N");
                 var PhStatus = $(rows[i]).children('td.tdStatus')[0].innerText.trim();
                 var MedDate = $(rows[i]).children('td.MedDate')[0].innerText.trim();
                 var fd = "";
                 if (Food.substring(0, 1) == "B")
                     fd = "E";
                 else if (Food.substring(0, 1) == "A")
                     fd = "A";
                 else if (Food.substring(0, 1) == "-")
                     fd = "-";
                 var a = {
                     DRUGNM: MedicineName,
                     DOSSAGE: Dosses,
                     DAYS: Days,
                     Remarks: Remark,
                     ROUTE: Route,
                     GENERICID: $(rows[i]).children('td.GenricID')[0].innerText,
                     GENERICNAME: $(rows[i]).children('td.GenriName')[0].innerText,
                     DRUGCD: code,
                     INTAKECD: '',
                     SOSYN: "N",
                     DURATION: Duration,
                     ABFOOD: fd,
                     DRUGFORM: "",
                     INTAKEDESC: Intake.toUpperCase(),
                     RESEQ: i + 1,
                     TAMPERING: rows[i].id.trim().includes("_T") ? "Y" : "N",
                     SETUPYN: setupyn,
                     REFILLYN: refillyn,
                     CIMSYN: "N",
                     QTY: Qty,
                     ROUTINEYN: RoutineMed,
                     PHSTATUS: PhStatus,
                     MEDSTARTDATE: ConvertDateFormatSave(MedDate)
                 };
                 medicineArr.push(a);
             }
             var strMsg = "";
             var flag = true;
             $.each(medicineArr, function () {
                 var intake = $(this)[0].INTAKEDESC.toUpperCase();
                 if ($(this)[0].INTAKEDESC == "") {
                     flag = false;
                     strMsg = "Please select frequency for all medicines";
                 }
                 else if ($(this)[0].ROUTE == "") {
                     flag = false;
                     strMsg = "Please select Route for all medicines";
                 }
                 else if ($(this)[0].DAYS == "0" && (intake != "SOS" && intake != "STAT" && intake != "CONTD." && intake != "CONTD" && intake != "CONT." && intake != "CONT")) {
                     flag = false;
                     strMsg = "Please select duration of selected medicine";
                 }
             });
             HoldOn.open();
             if (flag) {
                 $.ajax({
                     url: 'SaveRx',
                     type: 'POST',
                     datatype: 'json',
                     data: { strAdviceList: JSON.stringify(medicineArr), strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                     success: function (response) {
                         if (strPlusButton == 'SS') {
                             if (!result.toUpperCase().includes("SUCCESS"))
                                 $.messager.alert("Info", result);
                             //$.messager.alert("Info", response);
                         }
                         else {
                             if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                 if (strPlusButton == "N")
                                     window.location.href = 'PatientEntry';
                                 flag = true;
                             }
                             else if (("" + response).toUpperCase().indexOf("DUPLICATE") != -1) {
                                 $.alert("Duplicate entries not allowed.");
                             }
                             else {
                                 $.alert(response);
                             }
                         }
                     },
                     complete: function () { HoldOn.close(); },
                     error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
                 });
                 return true;
             }
             else {
                 $.alert(strMsg);
                 HoldOn.close();
                 return false;
             }
         }

         function BindIntakeCombination() {
             ItakesTabArray = [];
             HoldOn.open();
             $.ajax({
                 type: "get",
                 datatype: "json",
                 async: false,
                 url: 'GetMedicineInTake',
                 success: function (response) {
                     if (response != "Unsucessfull") {
                         IntakeREsult = JSON.parse(response);
                         for (i = 0; i < IntakeREsult.Intake.length; i++) {
                             ItakesArray.push(IntakeREsult.Intake[i].INTAKE);
                             var Clst = {
                                 ITake: IntakeREsult.Intake[i].INTAKE,
                                 TabCount: IntakeREsult.Intake[i].TABCOUNT
                             }
                             ItakesTabArray.push(Clst);
                         }
                     }
                 },
                 complete: function () { HoldOn.close(); },
                 error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
             });
         }

         function SetText(str) {
             $("#" + idOfPopUpAnchor).text(str);
             if (idOfPopUpAnchor.toUpperCase().indexOf("INTAKE") != -1)
                 $("#" + idOfPopUpAnchor).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
             else if (idOfPopUpAnchor.toUpperCase().indexOf("NUM") != -1)
                 $("#" + idOfPopUpAnchor).parents('td').nextAll('td.durationWord').find('a.triggerDays').trigger('click');
             else if (idOfPopUpAnchor.indexOf("Days") != -1)
                 $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
             ValidateUniqueRow();
         }

         function SetRemarkText(str, code) {
             $("#" + idOfPopUpAnchor).text(str);
             $("#" + idOfPopUpAnchor).siblings("input")[0].value = code;
             ValidateUniqueRow();
         }

         function SetRouteText(str, code) {
             $("#" + idOfPopUpAnchor).text(str);
             $("#" + idOfPopUpAnchor).siblings("input")[0].value = code;
             if (idOfPopUpAnchor.toUpperCase().indexOf("ROUTE") != -1)
                 $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdDosses').find('input').trigger('focus');
             ValidateUniqueRow();
         }

         function LoadAllpopUps() {
             for (var i = 0; i <= 30; i++) {
                 var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc' style='font-weight:500;font-size:16px'>" + i + "</a>";
                 $("#layer-durationNum").append(s);
             }
             GetRemarkList();
             GetRouteList();
         }

         function intakeDiv(obj) {
             var DurgIntakeCode = $(obj).attr('id')
             $('.Next').css("visibility", "visible");
             var label;
             $('.shadow').removeClass("shadow");
             $(obj).find('label').addClass("shadow")
         }

         function showInputDiv() {
         }

         function AddMedicines() {
             FreqUsedMatrlLst = [];
             $.ajax({
                 type: "POST",
                 url: "<%=Url.Action("GetFregqentMaterial","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    if (response != "" && response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        FreqUsedMatrlLst = result;
                        var rows = "";
                        $('#tblMaterialList tbody').empty();
                        for (i = 0; i < result.Table.length; i++) {
                            var DurgidASClass = ''
                            DurgidASClass = GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                            var code = GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : $.trim(result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                            var name = GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICNAM) : $.trim(result.Table[i].MTRLNAME);
                            var routeText = "";
                            if (GeneralWiseYN != "Y") {
                                if ($.trim(result.Table[i].GENERICNAM) != "")
                                    name = name + " (" + $.trim(result.Table[i].GENERICNAM) + ")";
                                if (result.Table[i].QOH != undefined && $.trim(result.Table[i].QOH) != "" && $.trim(result.Table[i].QOH) > 0)
                                    name = name + " [QOH - " + $.trim(result.Table[i].QOH) + ", MRP - " + $.trim(result.Table[i].LASTMRP) + "]";
                                else
                                    name = name + " [MRP - " + $.trim(result.Table[i].LASTMRP) + "]";
                            }
                            rows += "<tr class='" + DurgidASClass + "' id='" + DurgidASClass + "'>" +
       // Added By Roshan For Adding The Icon 12/12/2025
       (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y" ? "<td class='MedIcon' style='width:4%'>" + "<i class='fa fa-info-circle MedInfoIcon' style='font-size:18px; cursor:pointer;' aria-hidden='true' onclick=\"getDrugInfo('" + code + "')\"></i>" + "</td>" : "") +// Added By Roshan Condtion Based On WebConfigs to Add The Row Or Not
                                "<td class='MaterialName' style='width:25%'>" + name + "</td><td class='tdNewMedSpan' style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td><td class='GenricID' style='display:none'>" + $.trim(result.Table[i].GENERICID) + "</td>" +
                                "<td class='MedDate' style='width:7%' ><a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + code + "' style='display:none;font-size:14px'>" + GetCurrentDate() + "</a></td>" +
                                "<td class='tdIntake' style='width:12.9%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + code + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake' ></span></div></td>" +
                                "<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + code + "' style='display:none;font-size:16px'>0</a></td>" +
                                "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + code + "' style='display:none;font-size:14px'>D</a></td>" +
                                "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + code + "' style='display:none;font-size:14px'>-</a></td>";
                            if ((name.toUpperCase().indexOf(" TAB") > -1 || name.toUpperCase().indexOf("TAB ") > -1 || name.toUpperCase().indexOf(" SYP") > -1 || name.toUpperCase().indexOf("SYP ") > -1 || name.toUpperCase().indexOf(" CAP") > -1 || name.toUpperCase().indexOf("CAP ") > -1 || name.toUpperCase().indexOf("TABLET") > -1 || name.toUpperCase().indexOf("CAPSULE") > -1 || name.toUpperCase().indexOf("SYRUP") > -1) && $.trim(result.Table[i].ROUTENM) == "")
                                rows = rows + "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + code + "' style='display:none;font-size:14px'>Per oral</a><input type='hidden' id='hdn" + code + "' value='09' /></td>";
                            else if ($.trim(result.Table[i].ROUTENM) != "")
                                rows += "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + code + "' style='display:none;font-size:14px'>" + $.trim(result.Table[i].ROUTENM) + "</a><input type='hidden' id='hdn" + code + "' value='" + $.trim(result.Table[i].ROUTE) + "'/></td>";
                            else
                                rows = rows + "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + code + "' style='display:none;font-size:14px'>Route</a><input type='hidden' id='hdn" + code + "' /></td>";
                            rows += "<td class='tdDosses' style='width:8%'><input type='text' class='triggerInputDosses form-control'  style='display:none;' placeholder='Dose' id='dossage" + code + "'/></td>" +
                         "<td class='tdQty' style='width:8%'><input type='text' class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' id='Qty" + code + "'/></td>" +
                         "<td class='tdRemark' style='width:16%' ><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + code + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + code + "' /></td>" +
                         "<td class='tdDrugCode' style='display:none'>" + (GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICID).trim() : $.trim(result.Table[i].MTRLCODE).trim()) + "</td>" +
                          "<td class='setupyn' style='display:none'>" + "" + "</td>" +
                          "<td class='refillyn' style='display:none'>N</td>" +
                         "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                         "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>" +
                        (ShowroutineFeature == "Y" ? "<td class='tdRoutineMed' style='width:8%'><input type='checkbox'   style='display:none;'  id='chkRoutineMed" + code + "'/></td>" : "") + //Total Qty;
                            "<td class='tdStatus' style='display:none'>A</td>";
                            rows += "</tr>";
                        }
                        $('#tblMaterialList tbody').append(rows);
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    GetSavedData();
                },
            });
        }

        function GetRemarkList() {
            var response = CommonForRemark;
            var staticOther = "<div style='position: fixed;width: 14%;'><input type='text' id='searchRemark' onkeyup='searchRemark()' style='width: 100%;height: 27px;' placeholder='Search...'/><span class='fa fa-plus fa-2x' onclick='OtherRemarkClicked(this)'  id='divOther' title='Add new Remark' style=' position: absolute; width: 39px; height: 27px;text-align: center; background: #4086bf;border-radius: 0px 5px 5px 0px;color: #f9f9f9;'></span></div><div style='margin-top:37px;' id='Remarkid'></div>";
            $("#layer-Remark").width(250);
            $("#layer-Remark").append(staticOther);
            var s = "<a href='javascript:;' id='00' class='anchorRemark' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>-</a>";
            $("#layer-Remark").append(s);
            for (var i = 0; i < response.length; i++) {
                var s = "<a href='javascript:;' id='" + response[i].Value + "' class='anchorRemark' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>" + response[i].Text + "</a>";
                $("#layer-Remark").append(s);
            }
        }

        function searchRemark() {
            var input, filter, div, a, i;
            input = document.getElementById("searchRemark");
            filter = input.value.toUpperCase();
            div = document.getElementById("layer-Remark");
            a = div.getElementsByTagName("a");
            for (i = 0; i < a.length; i++) {
                if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }

        function OtherRouteClicked(newthis) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group"><textarea rows="4" cols="50" maxlength="100"  id="txtRoute"   placeholder="Route" autofocus="autofocus" class="complaint form-control"' +
                'required></textarea>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var strRoute = '' + $('#txtRoute').val();
                            if (strRoute != "") {
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'saveRoute',
                                    data: { strNewRoute: strRoute, },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            var strCode = "" + response.toString();
                                            strCode = strCode.substring(strCode.length - 2, strCode.length);
                                            var s = "<a href='javascript:;' id='" + strCode + "' class='anchorRoute' style='font-weight:500;font-size:14px;border-bottom: 1px solid #cecece'>" + strRoute + "</a>";
                                            $(s).insertAfter("#RouteID");
                                            if ($(newthis)[0].id.toString().trim() == "divRouteOther")
                                                $("#layer-Route a#" + strCode + "").trigger("click");
                                            CommonForRemark.push({
                                                Value: strCode,
                                                Text: strRoute
                                            });
                                            var selRowId = $('#tblGrid').jqGrid('getGridParam', 'selrow');
                                            jQuery("#tblGrid").setColProp("ROUTE", {
                                                editoptions: {
                                                    value: load_Route(),
                                                }
                                            }).trigger("reloadGrid");
                                            $('#tblGrid').setCell(selRowId, 'ROUTE', strCode);
                                        }
                                        else {
                                            $.alert(response, "Information");
                                        }
                                    },
                                });
                            }
                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    $('#1').focus();
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                }
            });
        }

        function GetRouteList() {
            var response = JSON.parse(MedRoute.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
            var staticOther = "<div style='position: fixed;width: 14%;'><input type='text' id='searchRoute' onkeyup='searchRoute()' style='width: 64%;  height: 27px;'" +
                "placeholder='Search...'/><span class='fa fa-plus fa-2x' onclick='OtherRouteClicked(this)'  id='divRouteOther' " +
            "title='Add new Remark' style=' position: absolute; width: 38px; height: 27px;text-align: center; background: #4086bf;border-radius: 0px 5px 5px 0px;color: #f9f9f9;'>" +
            "</span></div><div style='margin-top:37px;' id='RouteID'></div>";
            $("#layer-Route").width(162);
            $("#layer-Route").append(staticOther);
            for (var i = 0; i < response.length; i++) {
                var s = "<a href='javascript:;' id='" + response[i].Value + "' class='anchorRoute' style='font-weight:500;font-size:14px;border-bottom:1px solid #cecece;'>" + response[i].Text + "</a>";
                $("#layer-Route").append(s);
            }
        }

        function searchRoute() {
            var input, filter, div, a, i;
            input = document.getElementById("searchRoute");
            filter = input.value.toUpperCase();
            div = document.getElementById("layer-Route");
            a = div.getElementsByTagName("a");
            for (i = 0; i < a.length; i++) {
                if (a[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                    a[i].style.display = "";
                } else {
                    a[i].style.display = "none";
                }
            }
        }

        function OtherRemarkClicked(newthis) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group"><textarea rows="4" cols="50" maxlength="500"  id="txtRemark"   placeholder="Remark" autofocus="autofocus" class="complaint form-control" required></textarea>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var NewRemark = '' + $('#txtRemark').val();
                            if (NewRemark != "") {
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'saveIntakeRemark',
                                    data: { strNewRemark: NewRemark, },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            var strCode = "" + response.toString();
                                            strCode = strCode.substring(strCode.length - 5, strCode.length);
                                            var s = "<a href='javascript:;' id='" + strCode + "' class='anchorRemark' style='font-weight:500;font-size:16px'>" + NewRemark + "</a>";
                                            $(s).insertAfter("#Remarkid");
                                            if ($(newthis)[0].id.toString().trim() == "divOther")
                                                $("#layer-Remark a#" + strCode + "").trigger("click");
                                            CommonForRemark.push({
                                                Value: strCode,
                                                Text: NewRemark
                                            });
                                            var selRowId = $('#tblGrid').jqGrid('getGridParam', 'selrow');
                                            jQuery("#tblGrid").setColProp("REMARK", {
                                                editoptions: {
                                                    value: load_Remarks(),
                                                }
                                            }).trigger("reloadGrid");
                                            $('#tblGrid').setCell(selRowId, 'REMARK', strCode);
                                        }
                                        else {
                                            $.alert(response, "Information");
                                        }
                                    },
                                });
                            }
                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    $('#1').focus();
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                }
            });
        }

        function AddMedicineRemark(object, e) {
            e.stopPropagation();
            var RemarkText = $(object).parent().next().text();
            if (RemarkText != "" || RemarkText != "undefined") {
            }
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Medicine Remark</label>' +
                '<textarea rows="4" cols="50"  id="txtMedicineRemark" maxlength="200" placeholder="Enter Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' +//kavita
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            if (RemarkText != "" || RemarkText != "undefined") {
                                $(object).parent().next().remove();
                            }
                            var CurrentRow = $(object).parent().parent();
                            stringRemarkTd = "<td class='RemarkText' style='display:none'>" + $('#txtMedicineRemark').val() + "</td>";
                            var firstChildVal = $(CurrentRow).find('td:nth-child(1)').text().trim();
                            var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + $('#txtMedicineRemark').val() + '</span>'
                            $(CurrentRow).find('td:nth-child(1)').children().remove();
                            $(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark);
                            CurrentRow.append(stringRemarkTd);
                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    $('#txtMedicineRemark').focus();
                    if (RemarkText != "" || RemarkText != "undefined") {
                        $('#txtMedicineRemark').val(RemarkText);
                    }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                }
            });
        }

        function GetSavedData() {
            var consNo = $.session.get('PatTRANNO');
            var ReSeqCnt = 0;
            $.ajax({
                type: "POST",
                url: "GetSavedMediList",
                data: { strConsNo: consNo },
                datatype: "json",
                async: false,
                success: function (response) {
                    if (response != "") {
                        var result = JSON.parse(response);
                        var len = result.length;
                        ReSeqCnt = result[len - 1].RESEQ;
                        RxDesktopSetData(result);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }, complete: function () {
                    rowNoFrMedTaper = ReSeqCnt;
                    HoldOn.close();
                },
            });
        }

        function SearchComplaint() {
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("ComplaintInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblMaterialList");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.MaterialName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        if (!$(tr[i]).hasClass('display')) {
                            $(tr[i]).addClass('display')
                        }
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
            search = $(tr).hasClass('display');
            if ($(input).val().length >= 3) {
                gerDrugList(filter, tr);
            }
 if (IS_DISPLAY_CIMS_FUNCTIONLITY == "Y") {
             // Added By Roshan Condtion Based On WebConfigs
             toogleButtons();//For Show And Hide The Interaction and Duplicate Button Added By Roshan 12/12/2025
         }
        }

        function gerDrugList(filter, obj) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetNonFreqDrugLstFrRxDesktop","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response)
                        var checker = '';
                        $('#tblNonFreqMtrlList').show();
                        $('#tblNonFreqMtrlList tbody').empty();
                        if (result["Table"] != undefined) {
                            for (i = 0; i < result.Table.length; i++) {
                                var rows = "";
                                var DurgidASClass = '';
                                DurgidASClass = GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                                DurgidASClass = DurgidASClass.replace(/\//g, '');
                                var code = GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : $.trim(result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                                code = code.replace(/\//g, '');
                                var mediName = $.trim(result.Table[i].MTRLNAME);
                                if ($("#tblMaterialList tr#" + $.trim(code)).length == 0) {
                                    rows += "<tr  class='" + DurgidASClass + "' id='" + $.trim(code) + "'>";
                                      if (GeneralWiseYN == "Y") {
      if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") { // Added By Roshan Condtion Based On WebConfigs to Add The Row Or Not
          rows += "<td class='MedIcon' style='width:4%'>" +
                  "<i class='fa fa-info-circle MedInfoIcon' style='font-size:18px; cursor:pointer;' aria-hidden='true' onclick=\"getDrugInfo('" + code + "')\"></i>" +
                  "</td>";
      }
      rows += "<td class='MaterialName' style='width:25%'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
              "<td class='tdNewMedSpan' style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf'></span></td>" +
              "<td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
              "<td class='GenricID' style='display:none'>" + $.trim(result.Table[i].GENERICID) + "</td>";
  }
  else {
      if ($.trim(result.Table[i].QOH) > 0) {
          if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {// Added By Roshan Condtion Based On WebConfigs to Add The Row Or Not
              rows += "<td class='MedIcon' style='width:4%'>" +
                      "<i class='fa fa-info-circle MedInfoIcon' style='font-size:18px; cursor:pointer;' aria-hidden='true' onclick=\"getDrugInfo('" + code + "')\"></i>" +
                      "</td>";
          }

          rows += "<td class='MaterialName' style='width:26%'>" +
                  $.trim(result.Table[i].MTRLNAME) + " (" + $.trim(result.Table[i].GENERICNAM) + ") [QOH - " +
                  $.trim(result.Table[i].QOH) + ", MRP - " + $.trim(result.Table[i].LASTMRP) +
                  "]</td>" +
                  "<td class='tdNewMedSpan' style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf'></span></td>" +
                  "<td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
                  "<td class='GenricID' style='display:none'>" + $.trim(result.Table[i].GENERICID) + "</td>";

      }
      else {
          if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {// Added By Roshan Condtion Based On WebConfigs to Add The Row Or Not
              rows += "<td class='MedIcon' style='width:4%'>" +
                      "<i class='fa fa-info-circle MedInfoIcon' style='font-size:18px; cursor:pointer;' aria-hidden='true' onclick=\"getDrugInfo('" + code + "')\"></i>" +
                      "</td>";
          }

          rows += "<td class='MaterialName' style='width:25%'>" +
                  $.trim(result.Table[i].MTRLNAME) + "(" + $.trim(result.Table[i].GENERICNAM) +
                  ") [MRP - " + $.trim(result.Table[i].LASTMRP) +
                  "]</td>" +
                  "<td class='tdNewMedSpan' style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf'></span></td>" +
                  "<td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
                  "<td class='GenricID' style='display:none'>" + $.trim(result.Table[i].GENERICID) + "</td>";
      }
  }
                                    var route = ""; routeCD = "";
                                    if ((mediName.toUpperCase().indexOf(" TAB") > -1 || mediName.toUpperCase().indexOf("TAB ") > -1 || mediName.toUpperCase().indexOf(" SYP") > -1 ||
                                        mediName.toUpperCase().indexOf("SYP ") > -1 || mediName.toUpperCase().indexOf(" CAP") > -1 || mediName.toUpperCase().indexOf("CAP ") > -1 || mediName.toUpperCase().indexOf("TABLET") > -1 || mediName.toUpperCase().indexOf("CAPSULE") > -1 || mediName.toUpperCase().indexOf("SYRUP") > -1)
                                        && $.trim(result.Table[i].ROUTENM) == "") {
                                        route = "Per oral"; routeCD = "09";
                                    }
                                    else if ($.trim(result.Table[i].ROUTENM) != "") {
                                        route = $.trim(result.Table[i].ROUTENM); routeCD = $.trim(result.Table[i].ROUTE);
                                    }
                                    else {
                                        route = "Route"; routeCD = "";
                                    }
                                    rows += "<td class='MedDate' style='width:7%' ><a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + code + "' style='display:none;font-size:14px'>" + GetCurrentDate() + "</a></td>" +
                                        "<td class='tdIntake' style='width:12.9%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + code + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake' > </span></div></td>" +
                                         "<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + code + "' style='display:none;font-size:14px'>0</a></td>" +
                                         "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + code + "' style='display:none;font-size:14px'>D</a></td>" +
                                          "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + code + "' style='display:none;font-size:14px'>A</a></td>" +
                                        "<td class='tdRoute'  style='width:10%' ><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + code + "' style='display:none;font-size:14px'>" + route + "</a><input type='hidden' id='hdn" + code + "' value='" + routeCD + "'/></td>" +
                                        "<td class='tdDosses' style='width:8%'><input type='text' class='triggerInputDosses form-control' style='display:none;' placeholder='Dose' id='dossage" + code + "' /></td>" +
                                          "<td class='tdQty' style='width:8%'><input type='text' class='triggerInputQty form-control' style='display:none;' placeholder='Qty/Nos.' id='Qty" + code + "' /></td>" +
                                         "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + code + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + code + "' /></td>" +
                                         "<td class='tdDrugCode' style='display:none'>" + (GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICID).trim() : $.trim(result.Table[i].MTRLCODE).trim()) + "</td>" +
                                          "<td class='setupyn' style='display:none'>N</td>" +
                                          "<td class='refillyn' style='display:none'>N</td>" +
                                      "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                                         "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>" +
                                    (ShowroutineFeature == "Y" ? "<td class='tdRoutineMed' style='width:8%'><input type='checkbox'  style='display:none;'  id='chkRoutineMed" + code + "'/></td>" : "") +
                                    "<td class='tdStatus' style='display:none'>A</td>";
                                    rows += "</tr>";
                                    if (rows != "") {
                                        $('#tblNonFreqMtrlList tbody').append(rows).closest('tr');
                                        $("#tblNonFreqMtrlList tr#" + code + "" + " input.triggerInputIntake").autocomplete({
                                            source: ItakesArray,
                                            autoFocus: false,
                                            minLength: 0,
                                            select: function (event, ui) {
                                                var txtval = ui.item.value;
                                                var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                                                var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();
                                                var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();
                                                var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();
                                                var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;
                                                var route = $(this).parents('td').siblings('.tdRoute').find('a').text();
                                                var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();
                                                var tableRow = $("#tblMaterialList tr").filter(function () {
                                                    return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim();
                                                }).closest("tr");
                                                if (tableRow.length > 0) {
                                                    $.messager.alert('This medicine and frequency already present');
                                                    $(this).val('');
                                                    $(this).focus();
                                                    return false;
                                                }
                                                else {
                                                    if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                                        $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                                                        $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                                                        var TabCount = CalculateTabCount(txtval, 0, "D");
                                                        $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                                                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                                        $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                                                    }
                                                    else {
                                                        var TabCount = CalculateTabCount(txtval, durationNum, durationWord);
                                                        $(this).parents('td').siblings('td.tdQty').find('input.triggerInputQty')[0].value = TabCount;
                                                        $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                                                    }
                                                }
                                            }
                                        }).focus(function () {
                                            if ($("ul.ui-autocomplete").is(":hidden")) {
                                                $(this).autocomplete('search', '');
                                            }
                                        });
                                    }
                                }
                            }
                        }
                        ResponseCheck = result;
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        function GetpersonalisedList() {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersDiseaseList","DoctorDesk")%>",
                data: { CIMS: "N" },
                asycn: false,
                success: function (response) {
                    if (response != "" && response.toUpperCase() != "UNSUCESSFULL") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);'></td><td class='DiseaseName' style='padding:5px;font-size: 16px;vertical-align:middle' onclick='CheckedSetUp(this);'><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='SetUpAddEdit(this);'></i></span></td>";
                            rows += "</tr>";
                        }
                        $('#tblPersDiseaselist tbody').empty();
                        $('#tblPersDiseaselist tbody').prepend(rows).closest('tr');
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        function CreatePersonalList() {
            $.confirm({
                title: 'SetUp Disease',
                theme: 'supervan',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                content: '' +
                '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:50px"><label style="background-color: transparent; border-color: transparent;margin-left:0px" id="RxSetUpAdd"> <img src="../Images/add.png"  style="background-color: white;border-radius: 50%; "></label></td><td><input id="txtDisease" type="text" id="input-name" placeholder="Search Disease" class="form-control" onkeyup="SearchDiseases()"  style="margin-left:10px" ></td></tr></table></div>' +
                '<div id="divtblDisease" class="divtblDisease" style=""><table id="tblPersDiseaselist" style="width:100%;border-top:1px solid #29884bd6 !important;" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: '<i class="fa fa-check-circle-o"></i>',
                        btnClass: 'btn-default',
                        action: function () {
                            stringcode = '';
                            var row = $('#tblPersDiseaselist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    stringcode += "'" + $(row[r]).attr('id') + "'" + ','
                                }
                            }
                            var codeT = stringcode.slice(1)
                            var strCode = codeT.substr(0, codeT.length - 2);
                            SavePersDiseaseList(strCode);
                        }
                    },
                    Closed: {
                        text: '<i class="fa fa-close "></i>'
                    }
                },
                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    GetpersonalisedList()
                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-right', '10px');
                    })
                    $(defaultbtn[0]).attr('id', 'btnSubmit');
                    $(defaultbtn[0]).addClass('disable-clicks');
                    $('.jc-bs3-row').removeClass('row');
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1');
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    $('.jconfirm-bg').css('background-color', 'rgba(255, 255, 255, 0.62)');
                    $('.jconfirm-box').css('background-color', 'rgba(43, 43, 60, 0.98)');
                    $('.jconfirm-box').css('box-shadow', 'rgb(62, 62, 50) 0px -1px 14px 4px');
                }
            });
        }

        function SavePersDiseaseList(strCode) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: 'SavePersonDises',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            window.location.href = 'RxDesktop';
                        }
                        else if (("" + result).toUpperCase().indexOf("FAILED") != -1) {
                            $.alert({
                                title: 'Transaction Failed!',
                                animation: 'scale',
                                closeAnimation: 'scale',
                                buttons: {
                                    okay: {
                                        text: 'Okay',
                                        btnClass: 'btn-blue'
                                    }
                                }
                            });
                        }
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function handleChange(obj) {
            var parentRow = $(obj).parent().parent();
            $('#tblPersDiseaselist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus();
            CountCheckBoxChecked();
        }

        function CheckedSetUp(obj) {
            var CurrentChkBox = $(obj).prev().children();
            if (CurrentChkBox.prop("checked") == true)
                CurrentChkBox.prop('checked', false);
            else
                CurrentChkBox.prop('checked', true);
            CountCheckBoxChecked();
            var parentRow = $(obj).parent();
            $('#tblPersDiseaselist tbody').prepend(parentRow).closest('tr');
        }

        function CountCheckBoxChecked() {
            var CheckBoxCount = $('.chkPersDis:checked').size();
            if (CheckBoxCount > 0) {
                $('#btnSubmit').removeClass('disable-clicks');
            }
            else {
                $('#btnSubmit').addClass('disable-clicks');
            }
        }

        function RemoveMedicine(CurrenRowId, strTranNo) {
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/DeleteMedicine',
                type: 'POST',
                datatype: 'json',
                data: { strMaterialCode: CurrenRowId.toString().trim(), strTranNo: strTranNo },
                success: function (response) {
                    if (response.indexOf("successful") != -1) {
                        $("tr#" + CurrenRowId).removeClass('active');
                        $("tr#" + CurrenRowId).children('td').children('i').hide();
                        $("tr#" + CurrenRowId).children('td.sortTD').hide();
                    }
                },
                complete: function () {
                    HoldOn.close();
                }
            })
        }
        function SaveMedicineResequence(str) {
            HoldOn.open();
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var MaterlstArr = [];
            var rows = $('#tblMaterialList > tbody > tr.active').get();
            for (var i = 0; i < rows.length; i++) {
                var strDrugcode = rows[i].id
                if (strDrugcode.toString().trim().toUpperCase() != "NEW") {
                    var strResquence = i + 1;
                    var a = {
                        DRUGCD: strDrugcode,
                        RESEQ: strResquence,
                    };
                    MaterlstArr.push(a);
                }
            }
            $.ajax({
                type: "POST",
                url: 'SaveMedicineResequence',
                datatype: "json",
                data: { strMedicineList: JSON.stringify(MaterlstArr), strTranNO: tranNo, strMRNo: mrno },
                success: function (result) {
                    if (str != "Y")
                        window.location.href = '../DoctorDesk/PatientEntry';
                },
                complete: function () {
                    HoldOn.close();
                }
            });

        }
        function SearchDiseases() {
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtDisease");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersDiseaselist");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.DiseaseName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";

                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        $(document.body).on('click', '#RxSetUpAdd', function (e) {
            SetUpAddEdit(this);
        });

        $(document.body).on({
            'click': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
                $("#divSrvcGrpGrid").show();
            },
            'focus': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
                $("#divSrvcGrpGrid").show();
            },
        }, '#txtServiceGrpsearch');

        $(document.body).on('click', '#btnsrvgrp', function (e) {
            $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);

            $('#tblGrid').jqGrid('clearGridData');
        });

        function SerivceGrpData(srvcgrpname) {
            HoldOn.open();
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcgrpname);
            $newDiv.attr("name", srvcgrpname);
            $newDiv.addClass("searchdivclass");
            $newDiv.css('height', '200px');
            $newDiv.css('font-size', '12px');
            $newDiv.css('margin-left', '0px');
            $newDiv.css('overflow', 'auto');
            $newDiv.css('display', 'none');
            $newDiv.css('border-color', '#f47b02;')
            $newDiv.css(' border-style', 'solid');
            $newDiv.css('background', 'azure')
            var $newul = $('<ul>');
            $newul.attr("id", "SrvcGrpdata");
            $newul.addClass("searchlistclass");
            var options = "";
            var abc = "<a id=btnsrvgrp style=color:blue;cursor:pointer float:right;>ClearSelection</a>"
            var i = 0;
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetFregqentMaterial","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    if (response != "" && response.toUpperCase() != "UNSUCESSFULL") {
                        var result = JSON.parse(response);
                        for (i = 0; i < result.Table.length; i++) {
                            var title = GeneralWiseYN == "Y" ? result.Table[i].GENERICNAM : result.Table[i].MTRLNAME;
                            var idstring = GeneralWiseYN == "Y" ? result.Table[i].GENERICID : result.Table[i].MTRLCODE;
                            options += "<li><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + (GeneralWiseYN == "Y" ? result.Table[i].GENERICID : result.Table[i].MTRLCODE) + "' />" +
                                "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" +
                                result.Table[i].GENERICID + "</label><label id='genericName' style='display:none'>" + result.Table[i].GENERICNAM + "</label><li>";
                        }
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },

            });
            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divSrvcGrpSelect').append($newDiv);
        }

        function BindSelectedMedicineGrid() {
            function getColumnIndexByName(grid, columnName) {
                var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
                for (i = 0; i < l; i++) {
                    if (cm[i].name === columnName) {
                        return i;
                    }
                }
                return -1;
            }
            jQuery("#tblGrid").jqGrid({
                datatype: 'local',
                colNames: ['', 'Code', 'Medicine Name', 'Generic Name', 'Dose', 'Date', '<label>Frequency</label><span style="float:right;width: 22px;font-size: large;color: #3d7da3" title="Add Frequency" id="btnNewIntake" onclick="NewIntake()"> <i class="fa fa-plus"></i></span>', 'Intake Calculated', 'Days', 'Duration', 'Food', 'Route', '<label>Remark</label><span style="float:right;width: 22px;font-size: large;color: #3d7da3" title="Add Frequency" id="btnNewIntake" onclick="OtherRemarkClicked(this)"> <i class="fa fa-plus"></i></span>', 'Generic Id'],
                colModel: [
                    {
                        name: 'act',
                        name: 'act',
                        width: 25,
                        editable: false,
                        formatter: CancelImg
                    },
                     { name: 'CODE', index: 'CODE', width: 10, hidden: true, align: "right", sortable: false, searchoptions: { clearSearch: false } },
                  {
                      name: 'NAME', index: 'NAME', width: 100, align: "left", sortable: false, hidden: GeneralWiseYN == "Y" ? true : false, searchoptions: { clearSearch: false }//3/29/19 width chngd
                  },
                     {
                         name: 'GENERICNAM', index: 'GENERICNAM', width: 220, align: "left", sortable: false, hidden: false
                     },
                  {
                      name: 'DOSAGE', index: 'DOSAGE', width: 80, align: "left", sortable: false, hidden: false, editable: true
                  },
                  {
                      name: 'MEDSTARTDATE', index: 'MEDSTARTDATE', width: 80, align: "left", sortable: false, hidden: false, editable: true
                  },
                   {
                       name: 'INTAKE', index: 'INTAKE', width: 100, align: "left", sortable: false, searchoptions: { clearSearch: false }, edittype: 'select', editable: true,
                       editoptions: {
                           value: load_Intake(),
                           defaultvalue: "--select--",
                           style: "width:88px;font-size: 12px;",
                           dataInit: function (e) {
                               jQuery("#tblGrid").setColProp("INTAKE", {
                                   editoptions: {
                                       value: load_Intake(),
                                   }
                               });
                           },
                           dataEvents: [{
                               type: 'change',
                               fn: function (e) {
                                   var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                   jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 7, true);
                               }
                           }]
                       }
                   },
                    {
                        name: 'INTAKECALC', index: 'INTAKECALC', width: 100, align: "left", sortable: false, hidden: true
                    },
                     {
                         name: 'DAYS', index: 'DAYS', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false, edittype: 'select', editable: true,
                         editoptions: {
                             value: load_Days(),
                             defaultvalue: "--select--",
                             style: "width:50px;font-size: 12px;",
                             dataInit: function (e) {
                                 jQuery("#tblGrid").setColProp("DAYS", {
                                     editoptions: {
                                         value: load_Days(),
                                     }
                                 });
                             },
                             dataEvents: [
                                {
                                    type: 'change',
                                    fn: function (e) {
                                        var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                        jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 8, true);//3/29/19

                                    }
                                }
                             ]
                         }
                     },
                    {
                        name: 'DURATION', index: 'DURATION', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false, edittype: 'select', editable: true,
                        editoptions: {
                            value: load_Duration(),
                            defaultvalue: "--select--",
                            style: "width:57px;font-size: 12px;",
                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("DURATION", {
                                    editoptions: {
                                        value: load_Duration(),
                                    }
                                });
                            },
                            dataEvents: [
                               {
                                   type: 'change',
                                   fn: function (e) {
                                       var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                       jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 9, true);
                                   }
                               }
                            ]
                        }
                    },
                    {
                        name: 'FOOD', index: 'FOOD', width: 80, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true,
                        editoptions: {
                            value: load_Food(),
                            defaultvalue: "--select--",
                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("FOOD", {
                                    editoptions: {
                                        value: load_Food(),
                                    }
                                });
                            },
                            dataEvents: [
                              {
                                  type: 'change',
                                  fn: function (e) {
                                      var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                      jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 10, true);
                                  }
                              }
                            ]
                        }
                    },
                     {
                         name: 'ROUTE', index: 'ROUTE', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                         editoptions: {
                             value: load_Route(),
                             defaultvalue: "--select--",
                             style: "width:140px;font-size: 12px;",
                             dataInit: function (e) {
                                 jQuery("#tblGrid").setColProp("ROUTE", {
                                     editoptions: {
                                         value: load_Route(),
                                     }
                                 });
                             },
                             dataEvents: [{
                                 type: 'change',
                                 fn: function (e) {
                                     var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                     jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 11, true);
                                 }
                             }]
                         }
                     },
                    {
                        name: 'REMARK', index: 'REMARK', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                        editoptions: {
                            value: load_Remarks(),
                            defaultvalue: "--select--",
                            style: "width:140px;font-size: 12px;",
                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("REMARK", {
                                    editoptions: {
                                        value: load_Remarks(),
                                    }
                                });

                            },
                        }
                    },
                     {
                         name: 'GENERICID', index: 'GENERICID', width: 120, align: "left", sortable: false, hidden: true
                     }
                ],

                rowNum: 9999999999,
                sortname: 'id',
                viewrecords: true,
                sortorder: "desc",
                loadtext: 'Loading...',
                loadonce: true,
                rownumbers: true,
                shrinkToFit: false,
                cellEdit: true,
                ignoreCase: true,
                cellsubmit: 'clientArray',
                loadComplete: function () {
                    $("#tblGrid").css('font-size', '11.1px');
                },
                gridComplete: function () {
                    $("#tblGrid").css('font-size', '12px');
                },
                ondblClickRow: function (rowId) {
                    var rowdat = $('#tblGrid').getRowData(rowId);
                    var intakesList = IntakeREsult.Table == undefined ? IntakeREsult.Intake : IntakeREsult.Table;
                    var InTKNAME = rowdat["INTAKE"];
                    value = jQuery.grep(intakesList, function (n, i) {
                        return (n.INTAKE == InTKNAME);
                    });
                },
                onCellSelect: function (rowId, iCol, content, event) {
                    rows = $('#tblGrid')[0].rows;
                    var rowdat = $('#tblGrid').getRowData(rowId);
                    if (iCol == 1) {
                        $('#tblGrid').jqGrid('delRowData', rowId);
                        $("ul#SrvcGrpdata input[value='" + rowId + "']").prop('checked', false);
                    }
                },
            }).trigger("reloadGrid");
            $("#tblGrid").jqGrid('bindKeys');
            $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
            jQuery('#tblGrid').closest('.ui-jqgrid-view')
        .find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
        .find("input, select")
        .focus(function (e) {
            var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
                $body = $header.siblings('.ui-jqgrid-bdiv');
            setTimeout(function () {
                $body[0].scrollLeft = $header[0].scrollLeft;
            }, 0);
        });
            var cdiv = $('#ContentHolderDiv').width();
            $("#tblGrid").jqGrid("setGridHeight", "200", true);//
        }

        $(document.body).on('click', 'ul#SrvcGrpdata input', function (e) {
            if ($(this)[0].checked) {
                var newRow = {
                    act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                    CODE: $(this)[0].defaultValue,
                    NAME: $(this)[0].parentNode.innerText,
                    GENERICID: $(this).siblings('#genericId')[0].innerText,
                    GENERICNAM: $(this).siblings('#genericName')[0].innerText
                };
                var ids = jQuery("#tblGrid").jqGrid('getDataIDs');
                if ($.inArray($(this)[0].defaultValue, ids) == -1)
                    $('#tblGrid').addRowData($(this)[0].defaultValue, newRow, 'last');
            }
            else {
                $('#tblGrid').jqGrid('delRowData', $(this)[0].defaultValue);
            }
        });

        function load_Intake() {
            HoldOn.open();
            var s;
            $.ajax({
                url: '../DoctorDesk/GetMedicineInTake',
                data: {},
                type: 'get',
                datatype: 'json',
                async: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        IntakeREsult = JSON.parse(response);
                        s = ":--select--;";
                        for (i = 0; i < IntakeREsult.Intake.length; i++) {
                            s += IntakeREsult.Intake[i].CODE + ":" + IntakeREsult.Intake[i].INTAKE + ";";
                        }
                        s = s.substring(0, s.length - 1);
                    }
                }, complete: function () { HoldOn.close(); }
            });
            return s;
        }

        function load_Days() {
            var s;
            s = ":--select--;";
            for (i = 0; i <= 30; i++) {
                s += i + ":" + i + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }

        function load_Duration() {
            var s;
            s = ":--select--;";
            s += "Days:Days;";
            s += "Weeks:Weeks;";
            s += "Months:Months;";
            s += "Years:Years;";
            s = s.substring(0, s.length - 1);
            return s;
        }

        function load_Food() {
            var s;
            s = ":--select--;";
            s += "After:After;";
            s += "Before:Before;";
            s = s.substring(0, s.length - 1);
            return s;
        }

        function load_Remarks() {
            if (RemarkArray != "") {
                var arry = CommonForRemark;
                var s = "";
                for (i = 0; i < arry.length; i++) {
                    s += arry[i].Value + ":" + arry[i].Text + ";";
                }
                s = s.substring(0, s.length - 1);
                return s;
            }
        }

        function load_Route() {
            var arry = JSON.parse(MedRoute.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));//vijeta 13/4/19
            var s = "";
            for (i = 0; i < arry.length; i++) {
                s += arry[i].Value + ":" + arry[i].Text + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }

        function AddMedicineDetail(IntakeId, rowId) {
            var medicineData = $("#tblGrid").getRowData(rowId);
            IncrementalValue = '';
            RalVal = '';
            DaysRow1 = '';
            DaysRow2 = '';
            labelVal = '';
            SelectedNumber = '';
            SelectedDWM = '';
            CalculatdIntake = '';
            SelectedDWMText = '';
            SelectedINTStemnt = '';
            for (I = 1; I < 6; I++) {
                DaysRow1 += '<label id="D' + I + '" class="DaysNumber DN1" onclick="CallSelectedNumber(this)">' + I + '</label>'
            }
            for (I = 6; I < 11; I++) {
                DaysRow2 += '<label id="D' + I + '" class="DaysNumber DN2" onclick="CallSelectedNumber(this)">' + I + '</label>'
            }
            var Id = IntakeId;
            value = jQuery.grep(IntakeREsult.Table, function (n, i) {
                return (n.CODE == Id);
            });
            var InatkeCombi = value[0].INTAKE;
            strx = InatkeCombi.split('-');
            for (m = 0; m < strx.length; m++) {
                labelVal += '<label class="BtnInke"><span style="font-size: 27px;">' + strx[m] + '</span></label>'
            }
            var aftrfd = medicineData.FOOD == "After Food" ? "active" : "";
            var bfrfd = medicineData.FOOD == "Before Food" ? "active" : "";
            var activeDay = medicineData.DAYS;
            var dura = medicineData.DURATION
            $.confirm({
                theme: 'material',
                type: 'orange',
                columnClass: 'medium',
                closeIcon: true,
                title: '' + medicineData.NAME + '',
                content: '' +
                '<form action="" class="formName" style="text-align:center" id="formDetails">' +
                 '<div style="margin-bottom:15px;"><div class="btn-group groupCombi" data-toggle="buttons" style="padding-top: 6px" id="GropSeelect">' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="0.5" autocomplete="off" checked="">0.5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="1" autocomplete="off" checked="">1</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="5" autocomplete="off" checked="">5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="10" autocomplete="off" checked="">10</label>' +
                  '</div></div>' +
                '<div class="form-group" id="btnCalulatedIntaKe">' + labelVal + '</div>' +
                 '<div style="margin-bottom:15px;"><div class="btn-group Food" data-toggle="buttons" style="padding-top: 6px" id="foodIntake">' +
               '<label class="btn btn-default borderC ' + bfrfd + '" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="E" autocomplete="off" checked="">Befor Meal</label>' +
              '<label class="btn btn-default borderC ' + aftrfd + '" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="A" autocomplete="off" checked="">After Meal</label>' +
            '</div></div>' +
             '<div style="margin-bottom:15px;" class=""><div class="btn-group IntkeStatement" data-toggle="buttons" style="padding-top: 6px" id="IntkeStatement">' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraConti"><input type="radio" name="IntkeStatement" value="Contd" autocomplete="off" checked="">Contd</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraSOS"><input type="radio" name="IntkeStatement" value="SOS" autocomplete="off" checked="">SOS</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraStat"><input type="radio" name="IntkeStatement" value="STAT" autocomplete="off" checked="">STAT</label>' +
               '<label class="btn btn-default active" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraOther"><input type="radio" name="IntkeStatement" value="Other" autocomplete="off" checked="">Other</label>' +
            '</div></div>' +
            '<div class="ParentDivDN">' +
               '<div class=Drow1>' + DaysRow1 +
            '</div>' +
            '<div class=Drow2>' + DaysRow2 +
          '</div>' +
          '<div>' +
            '<div style="margin-bottom:15px;"><div class="btn-group btn-group-sm MedicineDays" data-toggle="buttons" style="padding-top: 6px;margin-bottom:30px" id="MedicineDays">' +
                '<label id="DAYS" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="D" autocomplete="off" checked="">DAYS</label>' +
                '<label id="WEEK" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="W" autocomplete="off" checked="">WEEK</label>' +
                '<label  id="MONTH" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="M" autocomplete="off" checked="">MONTH</label>' +
                '<label  id="YEAR" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="Y" autocomplete="off" checked="">YEAR</label>' +
           '</div>' +
         '</div>' +
          '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn btn-green',
                        action: function () {
                            bfFood = ''
                            var Chlength = $('#btnCalulatedIntaKe').children().children().length;
                            for (var c = 0; c < Chlength; c++) {
                                var childElement = $('#btnCalulatedIntaKe').children().children()[c];
                                CalculatdIntake += childElement.innerHTML + '-';
                            }
                            CalculatdIntake.slice(0, -1)
                            var medType = $("div.IntkeStatement label.active").children()[0].value;
                            if (medType == "Other") {
                                if (!($(".Drow1").children(".selectedNumber").length > 0 || $(".Drow2").children(".selectedNumber").length > 0) || ($('.MedicineDays').children('label.active').length == 0)) {
                                    $.alert("Please Select Duration.");
                                    return false;
                                }
                            }
                            AddMedicineRow(rowId);
                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    var jc = this;
                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });

                    $(".BtnInke").on('click', function () {
                        var child = $(this).children();
                        if (longpress) {
                            $(this).children().text(0);
                        }
                        else {
                            ChangeCombinationVal(child);
                        }
                    });

                    $(".BtnInke").on('mousedown', function () {
                        startTime = new Date().getTime();
                    });

                    $(".BtnInke").on('mouseup', function () {
                        endTime = new Date().getTime();
                        longpress = (endTime - startTime > 500) ? true : false;
                    });

                    $(".BtnInke").bind("taphold", function tapholdHandler(event) {
                        $(this).children().text(0);
                    });

                    if (activeDay != " ")
                        CallSelectedNumber($("#D" + activeDay)[0]);
                    if (dura == "Contd")
                        StoreINTStatementVal($("#lblDuraConti")[0]);
                    else if (dura == "SOS")
                        StoreINTStatementVal($("#lblDuraSOS")[0]);
                    else if (dura == "STAT")
                        StoreINTStatementVal($("#lblDuraStat")[0]);
                    else
                        StoreINTStatementVal($("#lblDuraOther")[0]);
                    if (dura == "DAYS")
                        StoreDaysValue($("#DAYS")[0]);
                    else if ((dura == "WEEK"))
                        StoreDaysValue($("#WEEK")[0]);
                    else if ((dura == "MONTH"))
                        StoreDaysValue($("#MONTH")[0]);
                    else if ((dura == "YEAR"))
                        StoreDaysValue($("#YEAR")[0]);
                }
            });
        }

        function CallSelectedNumber(obj) {
            var lblchild = obj.parentElement.children
            $('.Drow1').children().each(function () {
                if ($(this).hasClass('selectedNumber')) {
                    $(this).removeClass('selectedNumber')
                }
            });
            $('.Drow2').children().each(function () {
                if ($(this).hasClass('selectedNumber')) {
                    $(this).removeClass('selectedNumber')
                }
            });
            $(obj).addClass('selectedNumber');
            SelectedNumber = $(obj).text();
        }

        function ValueToStore(obj) {
            IncrementalValue = (obj).children[0].value;
            RalVal = (obj).children[0].value;
        }

        function StoreABFoodVal(obj) {
            SelectedBAFood = (obj).children[0].value;
        }

        function StoreINTStatementVal(obj) {
            SelectedINTStemnt = (obj).children[0].value;
            if (SelectedINTStemnt.length > 0) {
                $("#lblDuraOther").removeClass("active");
                obj.className = "btn btn-default active";
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    $('.ParentDivDN').addClass('disable-clicks')
                    $('.Drow1').children().each(function () {
                        if ($(this).hasClass('selectedNumber')) {
                            $(this).removeClass('selectedNumber')
                        }
                    });
                    $('.Drow2').children().each(function () {
                        if ($(this).hasClass('selectedNumber')) {
                            $(this).removeClass('selectedNumber')
                        }
                    });
                    $('.MedicineDays > .btn-default').removeClass('active');
                    SelectedNumber = "";
                }
                else {
                    $('.ParentDivDN').removeClass('disable-clicks')
                }
            }
        }

        function StoreDaysValue(obj) {
            obj.className = "btn btn-default NoBorder active";
            SelectedDWM = (obj).children[0].value;
            SelectedDWMText = $(obj).attr('id');
        }

        function AddMedicineRow(rowId) {
            var calIntk = "";
            if (CalculatdIntake.length > 0) {
                calIntk = CalculatdIntake.slice(0, -1);
            }
            else {
                calIntk = '';
            }
            var FoodStatus = ''
            if (SelectedBAFood == "A") {
                FoodStatus = "After Food";
            }
            else if (SelectedBAFood == "E") {
                FoodStatus = "Before Food";
            }
            var days = " ";
            days = SelectedNumber;
            var duration = "";
            if (SelectedINTStemnt.length > 0) {
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    duration = SelectedINTStemnt;
                    days = " ";
                }
                else {
                    duration = SelectedDWMText;
                }
            }
            else {
                duration = SelectedDWMText;
            }
            jQuery("#tblGrid").jqGrid('setCell', rowId, "INTAKECALC", calIntk);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DAYS", days);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DURATION", duration);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "FOOD", FoodStatus);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DOSAGE", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "ROUTE", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "REMARK", "");
        }

        function ChangeCombinationVal(obj) {
            obj.text(Number(obj.text()) + Number(RalVal))
        }

        function GetMedicineDetails(rowId) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:60px">' +
                '<div class="form-group">' +
                '<table style="width: 100%; margin-bottom: 5px; margin-left: 5px; font-size: 14px;" id="MediTbl">' +
                            '<tr>' +
                                '<th class="hide">Code</th>' +
                                '<th class="">Intake</th>' +
                                '<th class="">Duration</th>' +
                                '<th style="width: 18%">Food</th>' +
                            '</tr>' +
                        '</table>' +
                        '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'OK',
                        btnClass: 'btn-blue',
                        action: function () {
                        }
                    },
                },
                onContentReady: function () {
                    fillData(rowId);
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                }
            });
        }

        function fillData(rowId) {
            var table = $('#MediTbl');
            var rowCount = table[0].rows.length;
            var row = table[0].insertRow(rowCount);
            var data = $('#tblGrid').jqGrid('getRowData', rowId);
            var FoodStatus = '';
            var cell1 = row.insertCell(0);
            if (data["INTAKECALC"].length > 0) {
                cell1.innerHTML = data["INTAKECALC"].toString();
            }
            else {
                cell1.innerHTML = '';
            }
            var cell2 = row.insertCell(1);
            if (data["DURATION"].length > 0) {
                if (data["DAYS"] != "")
                    cell2.innerHTML = data["DAYS"] + " " + data["DURATION"];
                else
                    cell2.innerHTML = data["DURATION"];
            }
            var Cell3 = row.insertCell(2)
            Cell3.innerHTML = data["FOOD"].toString();
            Cell3.setAttribute('style', 'width:18%');
        }

        function CancelImg(value, options, rowObject) {
            var flag = false;
            var radioHtml = "";
            radioHtml = '<span class="ui-icon ui-icon-cancel">Remove</span>';
            return radioHtml;
        }

        function MedicineFilter() {
            input = document.getElementById("txtServiceGrpsearch");
            filter = input.value.toUpperCase();
            if (filter.length >= 3) {
                getNonFreqInChkBxList(filter);
                var elem = $("#SrvcGrpdata li");
                for (i = 0; i < elem.length; i++) {
                    $(elem[i]).removeClass('display');
                    label = elem[i].getElementsByTagName("input")[0];
                    if (label) {
                        if (label.title.toUpperCase().indexOf(filter) > -1) {
                            elem[i].style.display = "";
                            if (!$(elem[i]).hasClass('display')) {
                                $(elem[i]).addClass('display')
                            }
                        } else {
                            elem[i].style.display = "none";
                        }
                    }
                }
            }
        }

        function getNonFreqInChkBxList(filter) {
            HoldOn.open();
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetNonFregqentDrugList","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {
                    if (response != "" && response.toUpperCase() != "UNSUCESSFULL")
                    {
                        var result = JSON.parse(response)
                        var checker = '';
                        var rows = "";
                        var options = "";
                        for (i = 0; i < result.Table.length; i++) {
                            var title = GeneralWiseYN == "Y" ? result.Table[i].GENERICNAM : result.Table[i].MTRLNAME;
                            var idstring = GeneralWiseYN == "Y" ? result.Table[i].GENERICID : result.Table[i].MTRLCODE;
                            options += "<li><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + (GeneralWiseYN == "Y" ? result.Table[i].GENERICID : result.Table[i].MTRLCODE) + "' />" +
                                "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" +
                                result.Table[i].GENERICID + "</label><label id='genericName' style='display:none'>" + result.Table[i].GENERICNAM + "</label><li>";
                        }
                        $(options).insertAfter('a[id="btnsrvgrp"]');
                        ResponseCheck1 = result;
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SetUpAddEdit(obj) {
            $.confirm({
                title: (GeneralWiseYN == "Y" ? "Generic" : "Medicine") + ' SetUp',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<input  type="varchar" id="txtSetUp" maxlength="50" placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +
                '<input id="txtServiceGrpsearch" type="varchar" style="margin-top:1%;" placeholder="Search For ' + (GeneralWiseYN == "Y" ? "Generic" : "Medicines") + '" class="form-control" onkeyup="MedicineFilter()" /><span class="fa fa-plus fa-2x mediAddspan" title="Add new Medicine" id="spanAddNewMedInSetUp"></span>' + //vijeta 30/03/19
                '<div id="divSrvcGrpSelect" style="border:1px solid gray;"></div>' +
                '<div id="divSrvcGrpGrid"  style="display:none;margin-top:5px;overflow: auto;"><table id="tblGrid"></table></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var setUp = this.$content.find('.setUp').val();
                            var grpCode = "";
                            if (setUp == "") {
                                $.alert('Enter SetUp Name');
                                return false;
                            }
                            var chlBoxValLst = null;
                            chlBoxValLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxValLst.push($(this).attr('value'));
                            });
                            var strArry = chlBoxValLst.join(",");
                            var ids = jQuery("#tblGrid").jqGrid('getDataIDs');
                            myDataWithIds = $.map(ids, function (index, key) {
                                $('#tblGrid').jqGrid("editCell", 0, 0, false);
                                DRUGNM = $("#tblGrid").jqGrid('getCell', index, 'NAME');
                                if ($("#tblGrid").jqGrid('getCell', index, 'DAYS') != "--select--")
                                    DAYS = $("#tblGrid").jqGrid('getCell', index, 'DAYS');
                                else
                                    DAYS = '';
                                DRUGCD = $("#tblGrid").jqGrid('getCell', index, 'CODE');
                                if ($("#tblGrid").jqGrid('getCell', index, 'DURATION') != "--select--")
                                    DURATION = $("#tblGrid").jqGrid('getCell', index, 'DURATION');
                                else
                                    DURATION = '';
                                if ($("#tblGrid").jqGrid('getCell', index, 'FOOD') != "--select--")
                                    ABFOOD = $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "B" ? "E" : $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "A" ? "A" : "";
                                else
                                    ABFOOD = '';
                                if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")
                                    INTAKEDESC = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                                else
                                    INTAKEDESC = '';
                                if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")

                                    INTAKECD = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                                else
                                    INTAKECD = '';
                                SOSYN = $("#tblGrid").jqGrid('getCell', index, 'DURATION').substring(0, 1) == "S" ? "Y" : "N";
                                GENERICID = $("#tblGrid").jqGrid('getCell', index, 'GENERICID');
                                GENERICNAM = $("#tblGrid").jqGrid('getCell', index, 'GENERICNAM');
                                DOSSAGE = $("#tblGrid").jqGrid('getCell', index, 'DOSAGE');
                                ROUTE = $("#tblGrid").jqGrid('getCell', index, 'ROUTE');
                                REMARKS = $("#tblGrid").jqGrid('getCell', index, 'REMARK');
                                if (DURATION == "STAT")
                                    DURATION = "T";
                                return { DRUGNM: DRUGNM, DOSSAGE: DOSSAGE, DAYS: DAYS, Remarks: REMARKS, ROUTE: ROUTE, GENERICID: GENERICID, GENERICNAME: GENERICNAM, DRUGCD: DRUGCD, DRUGFORM: "", SOSYN: SOSYN, DURATION: DURATION, ABFOOD: ABFOOD, INTAKEDESC: INTAKEDESC, INTAKECD: "" };
                            });
                            var servData = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC == "" || e.INTAKEDESC == "--select--") });
                            var servicedt = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC != "" || e.INTAKEDESC != "--select--") });
                            var servDossage = $.grep(myDataWithIds, function (e) { return (e.DOSSAGE == "" || e.DOSSAGE == null) });//
                            var servRoute = $.grep(myDataWithIds, function (e) { return (e.ROUTE == "" || e.ROUTE == null) });//
                            var ServiceData = (JSON.stringify(servicedt));
                            if (isPersSetupOtherMandatoryChkYn == "Y") {
                                if (servData.length > 0) {
                                    $.alert('Please select frequency for all medicines.');
                                    return false;
                                }
                                if (servDossage.length > 0) {
                                    if (DoseMandatoryYN == "Y") {
                                        $.alert('Please select Dossage for all medicines');
                                        return false;
                                    }
                                }
                                else {
                                    var emptyDays = $.grep(myDataWithIds, function (e) { return ((e.DAYS == "" || e.DAYS == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                                    var emptyDuration = $.grep(myDataWithIds, function (e) { return ((e.DURATION == "" || e.DURATION == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                                    if (emptyDays.length > 0 || emptyDuration.length > 0) {
                                        $.alert('Please select duration for all medicines');
                                        return false;
                                    }
                                }
                            }
                            if (servRoute.length > 0) {
                                $.alert('Please select Route for all medicines');
                                return false;
                            }
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil"))
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            if (setUp != "" && ServiceData != "[]") {
   
                                $.ajax({
                                    type: "post",
                                    dataType: "json",
                                    url: '../DoctorDesk/AddMedicineSetUp',
                                    data: { strMedicineSetUpName: setUp, strMedicineLst: ServiceData.toString(), strSetUpCode: strSetUpCode, CIMSYN: "N" },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUp").val("");
                                            $.alert("Record inserted successfully");
                                            GetpersonalisedList();
                                            GetSetUpList("RxDesk");
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                                            $.alert("This Set Up is already Present.");
                                        }
                                        else {
                                            $.alert("Error!!Please Contact IT Dept");
                                        }
                                    },
                                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                                        HoldOn.close();
                                        $.messager.alert("Error", errorThrown);
                                    }
                                });
                            }

                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    $('#txtSetUp').focus();
                    if ($(obj).hasClass("fa fa-pencil")) {
                        $('#txtSetUp').val($(obj).parents('td').prev().text());
                        $("#dblServiceHelpsrvcgrp").show();
                        $("#divSrvcGrpGrid").show();
                    }

                    else
                        $('#txtSetUp').val("");
                    SerivceGrpData(srvcgrpname);
                    load_Intake();
                    BindSelectedMedicineGrid();
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsMedi($(obj).parents('tr')[0].id);
                    }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                }
            });
        }

        function FillSelectedSetUpsMedi(setUpId) {
            $.ajax({
                url: '../DoctorDesk/GetMedListBySetupCode',
                data: { strSetUpCode: setUpId },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {
                        $("#tblGrid").jqGrid('setGridParam', { data: response }).trigger("reloadGrid");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        function FillSelectedRoutineMed() {
            var Mrno = ($.session.get('PatMRNO'));
            $.ajax({
                url: '../DoctorDesk/RefillRoutineMedicine',
                data: { strMRNo: Mrno },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {
                        RxDesktopRoutineMed(response);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        jQuery(document).ready(function ($) {
            if (window.history && window.history.pushState) {
                window.history.pushState('forward', null, './RxDesktop');
                $(window).on('popstate', function () {
                    if (stopProp)
                        SaveAllMedicines("N");
                });
            }
        });

        function NewIntake(location, obj) {
            $.confirm({
                title: '',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                theme: 'bootstrap',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Intake</label><br>' +
                '<input  type="varchar" id="txtNewIntake"  placeholder="Enter Intake Combination" autofocus="autofocus" class="setUp form-control" required />' +
                '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            if ($("#txtNewIntake").val() == "" || $("#txtNewIntake").val() == null) {//
                                $('#txtNewIntake').css({ 'border-color': 'Red' });
                                return false;
                            } else {
                                $('#txtNewIntake').css({ 'border-color': '' });
                            }
                            var intake = $("#txtNewIntake").val();
                            $.ajax({
                                url: '../DoctorDesk/saveMedIntkCombintn',
                                type: 'post',
                                datatype: 'json',
                                data: { strMedIntkComb: intake },
                                success: function (response) {
                                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        $.alert("Intake added successfully", "Information");
                                        ItakesArray.push(intake);
                                        var selRowId = $('#tblGrid').jqGrid('getGridParam', 'selrow');
                                        $('#tblGrid').setCell(selRowId, 'INTAKE', intake);
                                        jQuery("#tblGrid").setColProp("INTAKE", {
                                            editoptions: {
                                                value: load_Intake(),
                                            }
                                        }).trigger("reloadGrid");
                                        if (location == "Out")
                                        {
                                            obj.currentTarget.previousSibling.value = intake;
                                        }
                                    }
                                    else {
                                        $.alert(response, "Information");
                                    }
                                }
                            });
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                    }
                },
                onOpen: function () {
                },
                onContentReady: function () {
                    var jc = this;
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('margin-top', '20px');
                    });
                }
            });
        }

        function GetDefaultRoute(Code) {
            var FrqLst = FreqUsedMatrlLst.toString() != [] && FreqUsedMatrlLst.Table.length > 0 ? FreqUsedMatrlLst.Table : [];
            var FilterRow =[];
            if (FrqLst.length > 0) {
                FilterRow = FrqLst.filter(function (F) {
                    if (GeneralWiseYN == "Y") {
                        return F.GENERICID.trim() == Code.trim();
                    }
                    if (GeneralWiseYN != "Y") {
                        return F.MTRLCODE.trim() == Code.trim();
                    }
                });
            }
            if (FilterRow.length > 0 && FilterRow[0].ROUTE != null) {
                var RouteCd = FilterRow[0].ROUTE.trim();
                var RouteLst = JSON.parse(MedRoute.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
                var FlstRouteLst = RouteLst.filter(function (F) { return F.Value.trim() == RouteCd; });
                if (FlstRouteLst.length > 0) {
                    document.getElementById(("Route" + Code.trim())).innerText = FlstRouteLst[0].Text;
                    $(("#hdn" + Code.trim())).val(RouteCd);
                }
            }
        }

        function CalculateTabCount(ITakeFrq, Day, Dur) {
            var MultiVal = 0
            if (Dur == "D")
                MultiVal = 1
            else if (Dur == "W")
                MultiVal = 7
            else if (Dur == "M")
                MultiVal = 30
            else if (Dur == "Y")
                MultiVal = 365
            var FilterR = ItakesTabArray.filter(function (F) { return F.ITake.trim() == ITakeFrq; });
            var TabCount = "";
            if (FilterR.length > 0) {
                TabCount = Number(FilterR[0].TabCount) * (MultiVal * Day);
            }
            return TabCount;
        }
        </script>
    </asp:Content>
