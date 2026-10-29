<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div class="row" style="height: 30px; border-color: #bce8f1; color: #d25a05; border: 1px solid transparent; text-align: center; font-size: 18px; display: none" id="divmail">
            <label id="P_Email"></label>
        </div>
        <div id="FilterDiv" style="margin-top: 0px; display: block;" class="row panel-body">
            <div class="col-xs-12 col-sm-8 col-md-12 col-lg-8" style="padding-bottom: 10px;">
                <div class="col-xs-12 col-sm-6" style="width: 45%;">
                    <label class="col-12 col-sm-4" style="font-weight: bold; font-size: 13px; margin-top: 10px; padding: 0;">From Date</label>
                    <div class="col-12 col-sm-7">
                        <input type="text" class="form-control" id="txtFromDate" onchange="$('#txtToDate').datepicker('option', 'minDate', $('#txtFromDate').val());" readonly="readonly">
                    </div>
                </div>

                <div class="col-xs-12 col-sm-6" style="width: 45%;">
                    <label class="col-12 col-sm-4" style="font-weight: bold; font-size: 13px; margin-top: 10px; padding: 0;">To Date</label>
                    <div class="col-12 col-sm-7">
                        <input type="text" class="form-control" id="txtToDate" readonly="readonly">
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-4 col-md-12 col-lg-4">
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-12 doctordiv">
                    <label class="col-12 col-sm-4" style="font-weight: bold; font-size: 13px; margin-top: 10px; padding: 0;">Doctor</label>
                    <div class="col-12 col-sm-7">
                        <select id="cmbDoctList" class="form-control" style="width: 100%;">
                            <option value="">---All---</option>
                        </select>
                    </div>
                </div>
                <div class="col-xs-2 searchdiv" style="text-align: end;">
                    <i class="fa fa-search searchIcon" aria-hidden="true" title="Search" onclick="SearchDetails()"></i>
<%--                    <i class="fa fa-refresh searchIcon" aria-hidden="true" title="Search" onclick="ClearDetails()"></i>--%>
                </div>
            </div>

            <div class="col-xs-12" style="display: flex; align-items: center;">
                <div class="col-xs-12">
                    <fieldset class="MainFilterSet" id="MainFiltersLst">
                        <legend class="LegendMainFilter" style="font-size: 13px; margin-bottom: 10px; font-weight: 900; margin-left: 5px;">Filters</legend>
                        <div class="MainRadioDiv" id="DivFilterOPDPresc" onclick="HistoryDetails('O')">
                            <input type="radio" name="FilterMainSrch" class="MainRadioBtn" id="FilterOPDPrescRbt" />
                            <label class="MainRadioLbl" id="FilterOPDPresc">OPD case summary</label>
                        </div>
                        <div class="MainRadioDiv" id="DivFilterPAC" onclick="HistoryDetails('P')">
                            <input type="radio" name="FilterMainSrch" class="MainRadioBtn" id="FilterPACRbt" />
                            <label class="MainRadioLbl" id="FilterPAC">PAC</label>
                        </div>
                        <div class="MainRadioDiv" id="DivFilterSurg" onclick="HistoryDetails('S')">
                            <input type="radio" name="FilterMainSrch" class="MainRadioBtn" id="FilterSurgRbt" />
                            <label class="MainRadioLbl" id="FilterSurg">Surgical</label>
                        </div>
                        <div class="MainRadioDiv" id="DivFilterChemo" onclick="HistoryDetails('C')">
                            <input type="radio" name="FilterMainSrch" class="MainRadioBtn" id="FilterChemoRbt" />
                            <label class="MainRadioLbl" id="FilterChemo">Chemo</label>
                        </div>
                        <div class="MainRadioDiv" id="DivFilterRadiat" onclick="HistoryDetails('R')">
                            <input type="radio" name="FilterMainSrch" class="MainRadioBtn" id="FilterRadiatRbt" />
                            <label class="MainRadioLbl" id="FilterRadiat">Radiation</label>
                        </div>
                        <div class="MainRadioDiv" id="DivFilterProgNote" onclick="HistoryDetails('N')">
                            <input type="radio" name="FilterMainSrch" class="MainRadioBtn" id="FilterProgNoteRbt" />
                            <label class="MainRadioLbl" id="FilterProgNote">Progress Note</label>
                        </div>
                        <div class="MainRadioDiv" id="DivFilterDischSumy" onclick="HistoryDetails('D')">
                            <input type="radio" name="FilterMainSrch" class="MainRadioBtn" id="FilterDischSumyRbt" />
                            <label class="MainRadioLbl" id="FilterDischSumy">Discharge Summary</label>
                        </div>
                    </fieldset>
                </div>
            </div>

            <div class="col-xs-12" id="FilterOPD" style="display: none; align-items: center;">
                <div class="col-xs-10">
                    <fieldset class="FilterFieldset" id="ChkFieldSet">
                        <legend style="font-size: 13px; margin-bottom: 10px; font-weight: bold; margin-left: 5px;">OPD case summary Filters </legend>
                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkSelectAll" onclick="SelectAllFilter();" />
                            <label class="ChkBoxLbl" onclick="SelectAllFilter()">Select All</label>
                        </div>
                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkCheifComp" onclick="FilterData('CheifCompDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkCheifComp');FilterData('CheifCompDispYN', 'chkCheifComp')">Chief Complaints</label>
                        </div>
                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkGeneralExam" onclick="FilterData('GenExamDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkGeneralExam');FilterData('GenExamDispYN', 'chkGeneralExam')">Vitals</label>
                        </div>
                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkHistory" onclick="FilterData('HistoryDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkHistory');FilterData('HistoryDispYN', 'chkHistory')">History</label>
                        </div>
                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkDiagnosis" onclick="FilterData('DiagnosisDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkDiagnosis');FilterData('DiagnosisDispYN', 'chkDiagnosis')">Diagnosis</label>
                        </div>

                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkOnExam" onclick="FilterData('OnExamDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkOnExam');FilterData('OnExamDispYN', 'chkOnExam')">Physical Examination</label>
                        </div>

                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkRx" onclick="FilterData('RxDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkRx');FilterData('RxDispYN', 'chkRx')">Rx</label>
                        </div>

                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkAdvInvst" onclick="FilterData('AdvInvstDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkAdvInvst');FilterData('AdvInvstDispYN', 'chkAdvInvst')">Advice for Investigations</label>
                        </div>

                        <div class="FCheckBoxDiv">
                            <input type="checkbox" name="AllCheck" class="Chkbox" id="chkRAdvice" onclick="FilterData('AdviceDispYN', this.id)" />
                            <label class="ChkBoxLbl" onclick="CheckedBox('chkRAdvice');FilterData('AdviceDispYN', 'chkRAdvice')">Other Advices</label>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>

        <div id="divOPDPrescInfo" style="display: none;margin: 0px -8px 0px -15px;">
            <div id="OPDPrescContentHolderDiv">
                <div id="tbldiv">
                </div>
            </div>
        </div>

        <div id="divPACInfo" style="display: none;margin: 0px -8px 0px -15px;">
            <div id="PACContentHolderDiv">
                <div id="tblPACdiv">
                </div>
            </div>
        </div>

        <div id="divSurgInfo" style="display: none;margin: 0px -8px 0px -15px;">
            <div id="SurgeryContentHolderDiv">
                <div id="tblSurgerydiv">
                </div>
            </div>
        </div>

        <div id="divChemoInfo" style="display: none;margin: 0px -8px 0px -15px;">
            <div id="ChemoContentHolderDiv">
                <div id="tblChemodiv">
                </div>
            </div>
        </div>

        <div id="divRadiationInfo" style="display: none;margin: 0px -8px 0px -15px;">
            <div id="RadiationContentHolderDiv">
                <div id="tblRadiationdiv">
                </div>
            </div>
        </div>

        <div id="divClinicInfo" style="display: none;margin: 0px -8px 0px -15px;">
            <div id="ClinicContentHolderDiv">
                <div id="tblClinicdiv">
                </div>
            </div>
        </div>

        <div id="divDiscSumyInfo" style="display: none;margin: 0px -8px 0px -15px;">
            <div id="DiscSumyContentHolderDiv">
                <div id="tblDiscSumydiv">
                </div>
            </div>
        </div>

    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <%-- Include Script --%>
    <script src="../Scripts/PatList.js"></script>

    <%-- Common Style --%>
    <style>
        .NoDataFound {
            overflow-x: auto;
            padding: 0;
            font-size: 14px;
            text-align: center;
            font-weight: bold;
            padding: 10px;
            background: #cfeeff;
            border-radius: 10px;
            border: 1px solid #005d80;
            margin-top: 5px;
        }

        .ui-jqgrid-bdiv td {
            white-space: normal !important;
            word-wrap: break-word !important;
        }
        table:not(#tbldiv) {
            width: 100%;
        }

        .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 13px;
            text-align: center;
            font-weight: bold;
        }

        .divBody {
            padding: 0px !important;
            background-color: white;
        }

        Label {
            margin-left: 5px;
        }

        .panel-body {
            width: auto !important;
            height: auto !important;
            -webkit-box-shadow: 0px 1px 2px 0px #878888;
        }

        .content {
            width: 98%;
        }

        .nopadding {
            padding: 0 !important;
            margin: 0 !important;
        }

        .leftHead {
            font-size: 13px;
            font-weight: bolder;
            background-color: antiquewhite;
        }

        .liClass {
            font-size: 13px;
            color: black;
        }

        .tblRx td, th {
            padding: 1px;
        }

        .panel-heading {
            padding: 2px 5px;
            border-radius: 0px !important;
            margin-bottom: 5px;
        }

        .panel{
                margin-bottom: 0px !important;
        }
        /*==============================*/
        :checked + label:before {
            content: "";
            background-color: #f5f8fa;
            transform: none;
        }

        :checked + label {
            border: none;
            border-color: #f5f8fa;
        }

        .FilterDiv {
            padding: 10px 0px;
            width: 100%;
            display: inline-block;
            border-radius: 15px;
            -webkit-box-shadow: 0px 0px 2px 0px #878888;
            margin-bottom: 10px;
        }

        .FilterFieldset {
            width: 100%;
            display: inline-block;
            border-radius: 15px;
            margin-top: 10px;
        }

        .FCheckBoxDiv {
            display: inline-block;
            padding: 0px 10px;
        }

        .Chkbox {
            vertical-align: text-bottom;
        }

        .ChkBoxLbl {
            font-size: 13px;
            margin-bottom: 0px;
        }

        .searchIcon {
            font-size: 30px;
            border: 1px solid;
            padding: 5px;
            border-radius: 10px;
            color: white;
            background: #6d9cf5;
            transition: background-color 0.2s;
            cursor: pointer;
        }

            .searchIcon:hover {
                background: #4985f7;
            }

        .CheifCompDispYN {
            display: block;
        }

        .GenExamDispYN {
            display: block;
        }

        .HistoryDispYN {
            display: block;
        }

        .DiagnosisDispYN {
            display: block;
        }

        .OnExamDispYN {
            display: block;
        }

        .RxDispYN {
            display: block;
        }

        .AdvInvstDispYN {
            display: block;
        }

        .AdviceDispYN {
            display: block;
        }
        /*Tablet Sizes Start*/
        @media only screen and (min-device-width : 600px) and (max-device-width : 768px) {
            .doctordiv {
                width: 70%;
            }

            .searchdiv {
                margin-top: 5%;
            }
        }

        @media only screen and (min-device-width : 768px) and (max-device-width : 991px) {
            .doctordiv {
                width: 100%;
                margin-left: -30%;
            }

            .searchdiv {
                margin-top: -0.5%;
            }
        }

        @media only screen and (min-device-width : 992px) and (max-device-width : 1024px) {
            .doctordiv {
                margin-left: 0%;
            }

            .select2-container--default .select2-selection--single {
                margin-left: -10%;
            }

            .searchdiv {
                margin-top: -0.5%;
            }
        }
        /*Tablet Size End*/

        /*Mobile Size Start*/
        @media only screen and (min-device-width : 320px) and (max-device-width : 474px) {
            .doctordiv {
                width: 70%;
            }

            .searchdiv {
                margin-top: 8.5%;
                margin-left: 3%;
            }
        }

        @media only screen and (min-device-width : 475px) and (max-device-width : 540px) {
            .doctordiv {
                width: 70%;
            }

            .searchdiv {
                margin-top: 7%;
                margin-left: 3%;
            }
        }
        /*Mobile Size End*/

        /*Desktop and Laptop Size Start*/
        @media only screen and (min-device-width : 1200px) and (max-device-width : 1366px) {
            .doctordiv {
                width: 100%;
                margin-left: -30%;
            }

            .searchdiv {
                margin-top: -2%;
            }
        }

        @media only screen and (min-device-width : 1366px) and (max-device-width : 1920px) {
            .doctordiv {
                width: 100%;
                margin-left: -30%;
            }

            .searchdiv {
                margin-top: -2%;
            }
        }
        /*Desktop and Laptop Size End*/
    </style>

    <%-- Filter Style --%>
    <style>
        .MainFilterSet {
            display: flex;
        }

        .MainRadioDiv {
            max-width: fit-content;
            background-color: #d5d5d5;
            border-radius: 5px;
            align-items: center;
            padding: 10px 10px;
            vertical-align: middle;
            margin-right: 20px;
        }

        .MainRadioDivSel {
            background-color: #44a9ff;
        }

        .MainRadionDivUnSel {
            background-color: #d5d5d5;
        }

        .MainRadioBtn {
            margin: 0px !important;
            vertical-align: middle;
        }

        .MainRadioLbl {
            margin: 0px;
            color: black;
            font-weight: bolder;
            padding-left: 5px;
            vertical-align: middle;
        }
    </style>

    <%-- Grouping --%>
    <style>
        .GroupHeaderDiv {
            padding: 10px 5px;
            background-color: #fef3e5;
            border: 3px solid #fe9102;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .GroupHeaderDivLbl {
            margin: 0px;
            font-size: 15px;
            font-weight: bold;
        }

        .GroupHeaderDivDArrow {
            font-size: 20px;
            color: #fe9102;
        }

        .GroupHeaderDivUArrow {
            font-size: 20px;
            color: #fe9102;
        }

        .GroupContentDiv {
            border: 3px solid #fe9102;
            border-top: none;
            margin-bottom: 5px;
        }
    </style>

    <%-- OPD Prescription Style --%>
    <style>
    </style>

    <%-- PAC Style --%>
    <style>
        .Tablewrapper {
            overflow-x: auto;
            width: 100%;
        }

        table.tblpopupList {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-height: 100px;
        }

            table.tblpopupList thead {
                background: #314b81;
                color: white;
                color: white;
                font-size: 12px;
            }

            table.tblpopupList th {
                padding: 5px 15px;
                border: none;
                border: 1px solid #e6e6e6;
                text-align: center;
            }

            table.tblpopupList tbody tr {
                background-color: #f9f9f9;
                transition: background-color 0.3s;
            }

                table.tblpopupList tbody tr:nth-child(even) {
                    background-color: #f1f1f1;
                }

                table.tblpopupList tbody tr:hover {
                    background-color: #f1f1f1;
                }

            table.tblpopupList tbody td {
                padding: 5px;
                border: 1px solid #e6e6e6;
            }

        .IFrameEyeIcon {
            cursor: pointer;
            font-size: 18px;
            color: black;
        }

        #iframeMain {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: white;
            z-index: 1000000;
            display: flex;
            flex-direction: column;
            border: 1px solid #aaa;
        }

        #iframeHeader {
            height: 40px;
            background-color: #3b5998;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 10px;
            font-weight: bold;
            flex-shrink: 0;
            border-bottom: 1px solid #ddd;
            color: white;
            font-size: 14px;
        }

        #myIframe {
            flex-grow: 1;
            width: 100%;
            border: none;
            height: 100%;
            visibility: hidden;
        }

        #iframeMain.minimized {
            height: 40px;
            width: auto;
            position: fixed;
            top: auto;
            bottom: 10px;
            right: 40px;
            left: auto;
        }

            #iframeMain.minimized #myIframe {
                display: none;
            }

        .IFrameIcon {
            padding: 0px 5px;
            font-size: 25px;
            cursor: pointer;
        }
    </style>

    <%-- Surgical Style --%>
    <style>
        .surgery-card {
            font-family: Arial, sans-serif;
            border-radius: 4px;
            overflow: hidden;
        }

        .surgery-card-header {
            background-color: #507eb3;
            color: white;
            padding: 10px 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
            font-size: 14px;
        }

        .surgery-card-body {
            font-size: 14px;
        }

        .surgery-SurgeryName-info-box {
            background-color: #e6f0fa;
            padding: 10px 12px;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            font-size: 14px;
            font-weight: 600;
            color: #003366;
        }

        .surgery-section-title {
            font-weight: bold;
            text-decoration: underline;
        }

        .surgery-list {
            margin-top: 5px;
            margin-bottom: 10px;
            padding-left: 20px;
        }

        .surgery-footer {
            background-color: #f5faff;
            text-align: right;
            padding: 5px 10px;
            font-weight: bold;
        }

        .notes-textarea {
            width: 100%;
            border: none;
            border-radius: 3px;
            padding: 4px;
            margin-top: 5px;
        }

        .notes-textarea {
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 3px;
            padding: 6px;
            resize: none;
            overflow: hidden;
            min-height: 100px;
            box-sizing: border-box;
            font-size: 13px;
        }
    </style>

    <%-- Chemo Style --%>
    <style>
    </style>

    <%-- Radiation Style --%>
    <style>
    </style>

    <%-- Progress Note Style --%>
    <style>
        .note-n {
    background-color: #ffe792 !important;
}
.note-r {
    background-color: #ffccc7 !important;
}
.note-d {
    background-color: #d3ffd5 !important;
}
    </style>

    <%-- Discharge Summary Style --%>
    <style>
        .DSMainHeaderDiv {
            color: black;
            font-weight: bold;
            text-decoration: underline;
            font-size: 14px;
        }

        .LeftLabel {
            width: 250px;
            text-align: left;
            padding-bottom: 10px;
            font-weight: bold;
        }

        .Colon {
            width: 20px;
            text-align: left;
            font-weight: bold;
            vertical-align: sub;
        }

        .TextFld {
            vertical-align: sub;
            font-weight: bold;
        }

        .FieldOnly {
            text-align: left;
            padding-left: 5px;
            font-weight: bold;
            font-size: 12px;
        }
        .GrdTableDiv {
            margin: 0px 15px;
            overflow: hidden;
        }

        .GrdTable {
            overflow: hidden;
        }
    </style>

    <%-- Global Decalaration --%>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var idOfDMY = "";
        var exam = "";
        var result = "";
        var DoctorList = '<%:Html.Raw(ViewBag.DoctorList)%>';
        var AllowMailBeforePrescriptionCompl = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("AllowMailBeforePrescriptionCompl")%>';
        var DispSrchCritInMedHistory = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DispSrchCritInMedHistory")%>';
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
    </script>

    <%-- Load Form --%>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $("#txtFromDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });
            $("#txtToDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                minDate: new Date(),
                maxDate: new Date()
            });
            $('#ChkFieldSet input[type="checkbox"]').prop('checked', true);
            BindDoctorList();
            var doctCode = $.session.get('DoctCode');
            var doctName = $.session.get('DoctName');
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');
            SetPatientDtl();
            AddClinics(urls);
            ToEmailID = $.session.get('PatEmail');
            if (ToEmailID != "" && ToEmailID != undefined) {
                $("#P_Email").html(ToEmailID);
            }
            else {
                $("#P_Email").html("Email ID is not registered.");
            }
            if ($(window).width() >= 996) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
                $("#slide_sdList").hide();
            }
            if (pathFrom != "") {
            }
            else {
                var doctCd = ('<%:Session["gDoctCode"]%>').toString();
                SearchFunction(doctCd);
                $("#DoctorInput").css("display", "none");
                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
            }
            var lst = document.getElementById('sideList');
            window.onclick = function (event) {
                if (event.target == document.getElementById('menuDots') && pathFrom != "") {
                    lst.style.display = "block";
                }
                else {
                    if ($(window).width() >= 996 && pathFrom != "") {
                        lst.style.display = "block";
                    }
                    else
                        lst.style.display = "none";
                }
            }
            $(document).on('click', '.copyHisCls', function (e) {
                var id = $(this)[0].id;
                $.confirm({
                    title: 'Confirmation',
                    content: 'Are you sure to copy/overwrite present prescription?',
                    buttons: {
                        confirm: function () {
                            GetCopy(id);
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        },
                    }
                });
            });
            $(document).on('click', '.sendEmail', function (e) {
                var completedYN = $(this).data('completedyn');
                var id = $(this).attr('id');
                if (AllowMailBeforePrescriptionCompl != 'Y') {
                    if (completedYN === "N") {
                        $.messager.alert("Information", "The prescription is not complete. You cannot send the mail before completion.");
                    } else {
                        SendMailAction(id);
                    }
                }
                else {
                    SendMailAction(id);
                }
            });
            $(window.document).on('mouseup touchend', function (event) {
                mouseDown = true;
            });
            $(document).on('click', '.ExColicon', function (e) {
                if ($(this).closest('tr').find('span.spanCls').length == 0) {
                    var prevRow = $(this).closest('tr')[0].previousElementSibling;
                    $(prevRow).find('span.spanCls').toggleClass('fa-caret-down fa-caret-right');
                }
                else {
                    $(this).closest('tr').find('span.spanCls').toggleClass('fa fa-caret-down fa fa-caret-right');
                }
                if ($(this).context.offsetParent.parentElement.nextElementSibling.style.display == "block")
                    $(this).context.offsetParent.parentElement.nextElementSibling.style.display = "none";
                else
                    $(this).context.offsetParent.parentElement.nextElementSibling.style.display = "block";
            });
            if (DispSrchCritInMedHistory == 'Y') {
                $('#FilterDiv').css('display', '');
            }
        });
    </script>

    <%-- Common Script --%>
    <script type="text/javascript">
        function ClearDetails() {
            $("#txtFromDate").val("");
            $("#txtToDate").val("");
            $("#cmbDoctList").val("");
            SearchDetails();
        }

        function SearchDetails() {
            if ($("#FilterOPDPrescRbt").prop("checked") == true)
                HistoryDetails("O");
            else if ($("#FilterPACRbt").prop("checked") == true)
                HistoryDetails("P");
            else if ($("#FilterSurgRbt").prop("checked") == true)
                HistoryDetails("S");
            else if ($("#FilterChemoRbt").prop("checked") == true)
                HistoryDetails("C");
            else if ($("#FilterRadiatRbt").prop("checked") == true)
                HistoryDetails("R");
            else if ($("#FilterProgNoteRbt").prop("checked") == true)
                HistoryDetails("N");
            else if ($("#FilterDischSumyRbt").prop("checked") == true)
                HistoryDetails("D");
            else
                $.messager.alert('Information', 'Please Select Atleast One Filter.');
        }

        function HistoryDetails(SType) {
            $("#tbldiv").empty();
            $("#tblPACdiv").empty();
            $('#MainFiltersLst .MainRadioDiv').removeClass('MainRadioDivSel');
            $('#MainFiltersLst .MainRadioDiv').addClass('MainRadioDivUnSel');
            $("input[name='FilterMainSrch']").prop("checked", false);
            if (SType === "O") {
                document.getElementById("divPACInfo").style.display = "none";
                document.getElementById("divSurgInfo").style.display = "none";
                document.getElementById("divChemoInfo").style.display = "none";
                document.getElementById("divRadiationInfo").style.display = "none";
                document.getElementById("divClinicInfo").style.display = "none";
                document.getElementById("divDiscSumyInfo").style.display = "none";
                document.getElementById("FilterOPD").style.display = "flex";
                document.getElementById("divOPDPrescInfo").style.display = "block";
                $("#FilterOPDPrescRbt").prop("checked", true);
                $('#DivFilterOPDPresc').addClass('MainRadioDivSel');
                GetPatMedicationHistory("");
            }
            else if (SType === "P") {
                document.getElementById("FilterOPD").style.display = "none";
                document.getElementById("divOPDPrescInfo").style.display = "none";
                document.getElementById("divSurgInfo").style.display = "none";
                document.getElementById("divChemoInfo").style.display = "none";
                document.getElementById("divRadiationInfo").style.display = "none";
                document.getElementById("divClinicInfo").style.display = "none";
                document.getElementById("divDiscSumyInfo").style.display = "none";
                document.getElementById("divPACInfo").style.display = "block";

                $("#FilterPACRbt").prop("checked", true);
                $('#DivFilterPAC').addClass('MainRadioDivSel');
                GetPACHistory()
            }
            else if (SType === "S") {
                document.getElementById("FilterOPD").style.display = "none";
                document.getElementById("divOPDPrescInfo").style.display = "none";
                document.getElementById("divPACInfo").style.display = "none";
                document.getElementById("divChemoInfo").style.display = "none";
                document.getElementById("divRadiationInfo").style.display = "none";
                document.getElementById("divClinicInfo").style.display = "none";
                document.getElementById("divDiscSumyInfo").style.display = "none";
                document.getElementById("divSurgInfo").style.display = "block";
                $("#FilterSurgRbt").prop("checked", true);
                $('#DivFilterSurg').addClass('MainRadioDivSel');
                GetBindingData();
            }
            else if (SType === "C") {
                document.getElementById("FilterOPD").style.display = "none";
                document.getElementById("divOPDPrescInfo").style.display = "none";
                document.getElementById("divPACInfo").style.display = "none";
                document.getElementById("divSurgInfo").style.display = "none";
                document.getElementById("divRadiationInfo").style.display = "none";
                document.getElementById("divClinicInfo").style.display = "none";
                document.getElementById("divDiscSumyInfo").style.display = "none";
                document.getElementById("divChemoInfo").style.display = "block";
                $("#FilterChemoRbt").prop("checked", true);
                $('#DivFilterChemo').addClass('MainRadioDivSel');
                GetMedicationHistory();
            }
            else if (SType === "R") {
                document.getElementById("FilterOPD").style.display = "none";
                document.getElementById("divOPDPrescInfo").style.display = "none";
                document.getElementById("divPACInfo").style.display = "none";
                document.getElementById("divSurgInfo").style.display = "none";
                document.getElementById("divChemoInfo").style.display = "none";
                document.getElementById("divClinicInfo").style.display = "none";
                document.getElementById("divDiscSumyInfo").style.display = "none";
                document.getElementById("divRadiationInfo").style.display = "block";
                $("#FilterRadiatRbt").prop("checked", true);
                $('#DivFilterRadiat').addClass('MainRadioDivSel');
                GetRadiationHistory();
            }
            else if (SType === "N") {
                document.getElementById("FilterOPD").style.display = "none";
                document.getElementById("divOPDPrescInfo").style.display = "none";
                document.getElementById("divPACInfo").style.display = "none";
                document.getElementById("divSurgInfo").style.display = "none";
                document.getElementById("divChemoInfo").style.display = "none";
                document.getElementById("divRadiationInfo").style.display = "none";
                document.getElementById("divDiscSumyInfo").style.display = "none";
                document.getElementById("divClinicInfo").style.display = "block";
                $("#FilterProgNoteRbt").prop("checked", true);
                $('#DivFilterProgNote').addClass('MainRadioDivSel');
                GetAdmissionLst();
            }
            else if (SType === "D") {
                document.getElementById("FilterOPD").style.display = "none";
                document.getElementById("divOPDPrescInfo").style.display = "none";
                document.getElementById("divPACInfo").style.display = "none";
                document.getElementById("divSurgInfo").style.display = "none";
                document.getElementById("divChemoInfo").style.display = "none";
                document.getElementById("divRadiationInfo").style.display = "none";
                document.getElementById("divClinicInfo").style.display = "none";
                document.getElementById("divDiscSumyInfo").style.display = "block";
                $("#FilterDischSumyRbt").prop("checked", true);
                $('#DivFilterDischSumy').addClass('MainRadioDivSel');
                GetDischrgLst();
            }
        }

        function selectText(node) {
            node = document.getElementById(node);
            if (document.body.createTextRange) {
                const range = document.body.createTextRange();
                range.moveToElementText(node);
                range.select();
            } else if (window.getSelection) {
                const selection = window.getSelection();
                const range = document.createRange();
                range.selectNodeContents(node);
                selection.removeAllRanges();
                selection.addRange(range);
            } else {
                console.warn("Could not select text in node: Unsupported browser.");
            }
        }

        function GetCopy(oldTranno) {
            HoldOn.open();
            var mrno = ($.session.get('PatMRNO'));
            var tranNo = ($.session.get('PatTRANNO'));
            $.ajax({
                type: "POST",
                url: 'SaveCopy',
                datatype: "json",
                data: { PrevTranNo: oldTranno, strMRNO: mrno, strTranNo: tranNo },
                success: function (result) {
                    if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        window.location.href = '../DoctorDesk/PatientEntry';
                        $.messager.alert('Information', 'Copied Successfully');
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }

        function CloseFancyBox() {
            $.fancybox.close();
        }

        function FilterDateFromToDate(SType, DataList) {
            var FlterData = JSON.parse(JSON.stringify(DataList));
            if ($("#txtFromDate").val() != "" && $("#txtToDate").val() != "") {
                var fromParts = $("#txtFromDate").val().split("/");
                var fromDate = new Date(fromParts[2], fromParts[1] - 1, fromParts[0]);
                var toParts = $("#txtToDate").val().split("/");
                var toDate = new Date(toParts[2], toParts[1] - 1, toParts[0]);
                if (SType == "S") {
                    FlterData = DataList.filter(function (item) {
                        const parts = item.SurgeryDate.split("/");
                        const day = parts[0];
                        const month = parts[1];
                        const year = parts[2];
                        const itemDate = new Date(year + "-" + month + "-" + day);
                        itemDate.setHours(0, 0, 0, 0);
                        return itemDate >= fromDate && itemDate <= toDate;
                    });
                }
                if (SType == "C") {
                    FlterData = DataList.filter(function (item) {
                        const day = item.TRANDATE.substring(6, 8);
                        const month = item.TRANDATE.substring(4, 6);
                        const year = item.TRANDATE.substring(0, 4);
                        const itemDate = new Date(year + "-" + month + "-" + day);
                        itemDate.setHours(0, 0, 0, 0);
                        return itemDate >= fromDate && itemDate <= toDate;
                    });
                }
                if (SType == "R") {
                    FlterData = DataList.filter(function (item) {
                        const parts = item.STARTDATE.split("/");
                        const day = parts[0];
                        const month = parts[1];
                        const year = parts[2];
                        const itemDate = new Date(year + "-" + month + "-" + day);
                        itemDate.setHours(0, 0, 0, 0);
                        return itemDate >= fromDate && itemDate <= toDate;
                    });
                }
            }
            if ($("#cmbDoctList").val() != "") {
                if (SType === "O") {
                    FlterData = FlterData.filter(function (x) { return $("#cmbDoctList option:selected").text() == x.DOCTNAME; })
                }
                else if (SType === "P") {
                    FlterData = FlterData.filter(function (x) { return $("#cmbDoctList option:selected").text() == x.PACDONEBY; })
                }
                else if (SType === "S") {
                    FlterData = FlterData.filter(function (x) { return $("#cmbDoctList option:selected").text() == x.SurgeonDoctorName; })
                }
                else if (SType === "C") {
                    FlterData = FlterData.filter(function (x) { return $("#cmbDoctList option:selected").text() == x.DOCTNAME; })
                }
                else if (SType === "R") {
                    FlterData = FlterData.filter(function (x) { return $("#cmbDoctList option:selected").text() == x.CONSULTANT; })
                }
                else if (SType === "N") {
                    FlterData = FlterData.filter(function (x) { return $("#cmbDoctList option:selected").text() == x.CONSDOCT; })
                }
                else if (SType === "D") {
                    FlterData = FlterData.filter(function (x) { return $("#cmbDoctList option:selected").text() == x.DOCTNAME; })
                }
            }
            return FlterData;
        }

        function FilterDateWise(SType, LstData) {
            var FilterDate = [];
            LstData = FilterDateFromToDate(SType, LstData);
            if (SType === "O") {
                var uniqueItems = [];
                var dateMap = {};
                for (var i = 0; i < LstData.length; i++) {
                    var d = LstData[i].TRANDATE;
                    if (!dateMap[d]) {
                        dateMap[d] = true;
                        uniqueItems.push(LstData[i].TRANDATE);
                    }
                }
                FilterDate = uniqueItems;
            }
            else if (SType === "P") {
                var uniqueItems = [];
                var dateMap = {};
                for (var i = 0; i < LstData.length; i++) {
                    var d = LstData[i].PACFITDATE;
                    if (!dateMap[d]) {
                        dateMap[d] = true;
                        uniqueItems.push(LstData[i].PACFITDATE);
                    }
                }
                FilterDate = uniqueItems;
            }
            else if (SType === "S") {
                var uniqueItems = [];
                var dateMap = {};
                for (var i = 0; i < LstData.length; i++) {
                    var d = LstData[i].SurgeryDate;
                    if (!dateMap[d]) {
                        dateMap[d] = true;
                        uniqueItems.push(LstData[i].SurgeryDate);
                    }
                }
                FilterDate = uniqueItems;
            }
            else if (SType === "C") {
                var uniqueItems = [];
                var keyMap = {};
                for (var i = 0; i < LstData.length; i++) {
                    var d = LstData[i].TRANDATE;
                    var p = LstData[i].PLANID;
                    var key = p;
                    if (!keyMap[key]) {
                        keyMap[key] = true;
                        uniqueItems.push(d);
                    }
                }
                FilterDate = uniqueItems;
            }
            else if (SType === "R") {
                var uniqueItems = [];
                var dateMap = {};
                for (var i = 0; i < LstData.length; i++) {
                    var d = LstData[i].STARTDATE;
                    if (!dateMap[d]) {
                        dateMap[d] = true;
                        uniqueItems.push(LstData[i].STARTDATE);
                    }
                }
                FilterDate = uniqueItems;
            }
            else if (SType === "N") {
                var uniqueItems = [];
                var dateMap = {};
                for (var i = 0; i < LstData.length; i++) {
                    var d = LstData[i].ADMNDATE;
                    if (!dateMap[d]) {
                        dateMap[d] = true;
                        uniqueItems.push(LstData[i].ADMNDATE);
                    }
                }
                FilterDate = uniqueItems;
            }
            else if (SType === "D") {
                var uniqueItems = [];
                var dateMap = {};
                for (var i = 0; i < LstData.length; i++) {
                    var d = LstData[i].CREATEDON;
                    if (!dateMap[d]) {
                        dateMap[d] = true;
                        uniqueItems.push(LstData[i].CREATEDON);
                    }
                }
                FilterDate = uniqueItems;
            }
            return FilterDate;
        }

        function FilterDateWiseData(SType, FDate, LstData) {
            var FilterData = [];
            if (SType === "O") {
                FilterData = LstData[0] == "" ? [] : LstData[0].filter(function (x) { return x.TRANDATE == FDate && ($("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.DOCTNAME); })
                LstData[0] = FilterData;
            }
            else if (SType === "P") {
                FilterData = LstData == "" ? [] : LstData.filter(function (x) { return x.PACFITDATE == FDate && ($("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.PACDONEBY); })
                LstData = FilterData;
            }
            else if (SType === "S") {
                FilterData = LstData == "" ? [] : LstData.filter(function (x) { return x.SurgeryDate == FDate && ($("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.SurgeonDoctorName); })
                LstData = FilterData;
            }
            else if (SType === "C") {
                var FilterData = [];
                if (LstData.data !== "") {
                    var planMap = {};
                    for (var i = 0; i < LstData.data.length; i++) {
                        var p = LstData.data[i].PLANID;
                        if (!planMap[p]) {
                            planMap[p] = true;
                            FilterData.push(LstData.data[i]);
                        }
                    }
                }
                LstData.data = FilterData.filter(function (x) { return $("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.DOCTNAME; });
            }
                //else if (SType === "C") {
                //    FilterData = LstData.data == "" ? [] : LstData.data.filter(function (x) { return x.TRANDATE == FDate; })
                //    LstData.data = FilterData;
                //}
            else if (SType === "R") {
                FilterData = LstData == "" ? [] : LstData.filter(function (x) { return x.STARTDATE == FDate && ($("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.CONSULTANT); })
                LstData = FilterData;
            }
            else if (SType === "N") {
                FilterData = LstData == "" ? [] : LstData.filter(function (x) { return x.ADMNDATE == FDate && ($("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.CONSDOCT); })
                LstData = FilterData; 
            }
            else if (SType === "D") {
                FilterData = LstData == "" ? [] : LstData.filter(function (x) { return x.CREATEDON == FDate && ($("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.DOCTNAME); })
                LstData = FilterData; 
            }
            return LstData;
        }

        function ShowDateConvert(FDate) {
            var parts = FDate.split("/");
            var day = parts[0];
            var month = parts[1];
            var year = parts[2];
            var monthNames = [
                "January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
            ];
            var monthIndex = parseInt(month, 10) - 1;
            return day + " " + monthNames[monthIndex] + ", " + year;
        }

        function AddGroupDiv(Id, Type, Label, MainDivId) {
            var HeaderId = "H_" + Id;
            var Div = "<div class='GroupHeaderDiv' id=" + HeaderId + ">{HEADER}</div><div class='GroupContentDiv' id='" + Id + "'></div>";
            var Lbl = "<label class='GroupHeaderDivLbl'>" + Label + "</label>";
            var DownArrowId = "O_" + Id;
            var UpArrowId = "C_" + Id;
            var DownArrow = "<i class='fa fa-chevron-circle-down GroupHeaderDivDArrow' style='display:none' aria-hidden='true' id=" + DownArrowId + " onclick=\"ShowHideGroupDiv('" + DownArrowId + "', '" + UpArrowId + "','O', '" + Id + "')\"></i>";
            var UpArrow = "<i class='fa fa-chevron-circle-up GroupHeaderDivUArrow' aria-hidden='true' id=" + UpArrowId + " onclick=\"ShowHideGroupDiv('" + UpArrowId + "', '" + DownArrowId + "','C', '" + Id + "')\"></i>";
            var DateGroupDiv = Div.replace("{HEADER}", (Lbl + DownArrow + UpArrow));
            $("#" + MainDivId).append(DateGroupDiv);
        }

        function ShowHideGroupDiv(HideIcon, ShowIcon, Type, Id) {
            var HeaderId = "H_" + Id;
            document.getElementById(HideIcon).style.display = 'none';
            document.getElementById(ShowIcon).style.display = 'block';
            document.getElementById(Id).style.display = Type == "O" ? 'block' : 'none';
            document.getElementById(HeaderId).style.marginBottom = Type == "O" ? '0px' : '5px';
        }

        function IdForGroupDiv(Date) {
            return Date.split('/').join('')
        }

        //function ConvertTo12Hour(SType, FTime) {
        //    var FormatedTime = FTime;
        //    if (SType === "O") {
        //        var parts = FTime.split(":");
        //        var hour = parseInt(parts[0], 10);
        //        var minute = parts[1];
        //        var ampm = hour >= 12 ? "PM" : "AM";
        //        hour = hour % 12 || 12;
        //        var hourStr = hour.toString().padStart(2, "0");
        //        var minuteStr = minute.toString().padStart(2, "0");
        //        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
        //    }
        //    else if (SType === "P") {

        //    }
        //    else if (SType === "S") {
        //    }
        //    else if (SType === "C") {

        //    }
        //    else if (SType === "R") {

        //    }
        //    else if (SType === "N") {
        //        var parts = FTime.split(":");
        //        var hour = parseInt(parts[0], 10);
        //        var minute = parts[1];
        //        var ampm = hour >= 12 ? "PM" : "AM";
        //        hour = hour % 12 || 12;
        //        var hourStr = hour.toString().padStart(2, "0");
        //        var minuteStr = minute.toString().padStart(2, "0");
        //        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
        //    }
        //    else if (SType === "D") {
        //        var parts = FTime.split(":");
        //        var hour = parseInt(parts[0], 10);
        //        var minute = parts[1];
        //        var ampm = hour >= 12 ? "PM" : "AM";
        //        hour = hour % 12 || 12;
        //        var hourStr = hour.toString().padStart(2, "0");
        //        var minuteStr = minute.toString().padStart(2, "0");
        //        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
        //    }
        //    return FormatedTime;
        //}
    </script>

    <%-- E-Mail --%>
    <script type="text/javascript">
        function validateEmail(Toemail) {
            var field;
            var RslValStr;
            var regex = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (Toemail.indexOf(",") > 0) {
                field = Toemail.split(",");
                for (num = 0; num < field.length; num++) {
                    var email = field[num].replace(/[\r\n]+/gm, "");;
                    RslValStr = (regex.test(email)) ? true : false;
                    if (RslValStr == false)
                        return RslValStr;
                }
            }
            else {
                field = Toemail;
                RslValStr = (regex.test(field)) ? true : false;
            }
            return RslValStr
        }

        function PopupForMail(strTranNo) {
            $.confirm({
                title: '',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                theme: 'bootstrap',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">Enter Email ID</label><br>' +
                '<textarea  type="varchar" id="txtemail"  placeholder="Enter email" autofocus="autofocus" rows="2" class="setUp form-control" required />' +
                '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Send',
                        btnClass: 'btn-blue',
                        action: function () {
                            tomail = $("#txtemail").val();
                            if ($("#txtemail").val() == "" || $("#txtemail").val() == null) {
                                $('#txtemail').css({ 'border-color': 'Red' });
                                $('#txtemail').val("");
                                return false;
                            } else {
                                if (validateEmail(tomail) == false) {
                                    alert("Invalid Email ID format.");
                                    return false;
                                }
                                else {
                                    $('#txtemail').css({ 'border-color': '' });
                                    Callajxmail(tomail, strTranNo);
                                }
                            }
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                    }
                },
                onContentReady: function () {
                    if (ToEmailID == "" || ToEmailID == null) {
                        $('#txtemail').val("");
                    }
                    else
                        $("#txtemail").val(ToEmailID);
                }
            });
        }

        function Callajxmail(tomail, TranNo) {
            HoldOn.open();
            var infotomail = "";
            var Mrno = ($.session.get('PatMRNO'));
            var datatosend = {
                tranno: TranNo,
                type: "NAME",
                MrNo: Mrno,
            }
            var Html = "";
            $.ajax({
                type: "Post",
                url: "../DoctorDesk/GetDoctorDeskData",
                data: datatosend,
                async: false,
                success: function (response) {
                    GridData = response;
                    digitsign1 = "";
                    digitsign2 = "";
                    digitsign3 = "";
                    sign1 = "";
                    sign2 = "";
                    sign3 = "";
                    if (GridData.jsonDoctorDetails.length > 0)
                        GetDoctSignature(GridData.jsonDoctorDetails[0].DOCTCODE);
                    infotomail = PrintData(TranNo, Mrno);
                    infotomail2 = PrintPatInfo();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    ajaxindicatorstop();
                    MsgDia(textStatus, "Error");
                    HoldOn.close();
                }
            });
            var datatosend1 = {
                printdata: encodeURIComponent(infotomail),
                TranNo: TranNo,
                ToMailId: tomail,
                Mrno: Mrno,
                printdataTop: encodeURIComponent(infotomail2),
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/SendMailAction",
                async: false,
                data: datatosend1,
                dataType: "json",
                success: function (response) {
                    HoldOn.close();
                    $.messager.alert("Information", response);
                },
                error: function () {
                    HoldOn.close();
                    alert('error');
                }
            });
        }

        function SendMailAction(strTranNo) {
            var id = strTranNo;
            $.confirm({
                title: 'Confirmation',
                content: 'Are you sure , you want to send an prescription over email?',
                buttons: {
                    confirm: function () {
                        var tomail = ($.session.get('PatEmail'));
                        if (tomail == "" || tomail == null) {
                            PopupForMail(id);
                        }
                        else {
                            Callajxmail(tomail, id)
                        }
                    },
                    cancel: function () {
                    },
                }
            });
        }
    </script>

    <%-- OPD Prescription --%>
    <script type="text/javascript">
        function GetPatMedicationHistory(Type) {
            var tranNo = ($.session.get('PatTRANNO'));
            var mrno = ($.session.get('PatMRNO'));
            if (Type == "S" && ($("#txtFromDate").val() == "" || $("#txtToDate").val() == "")) {
                $('#txtFromDate').datepicker('setDate', 'today');
                $('#txtToDate').datepicker('setDate', 'today');
            }
            var FromDate = $("#txtFromDate").val();
            var ToDate = $("#txtToDate").val();
            var DCode = $("#cmbDoctList").val() != "" ? $("#cmbDoctList option:selected").text() : "";
            $.ajax({
                type: "POST",
                url: 'GetMedicationtHistory',
                datatype: "json",
                data: { strMrNo: mrno, FromDate: FromDate, ToDate: ToDate, DoctCode: DCode },
                success: function (result) {
                    BindMedicationHistory(Type, FromDate, ToDate, DCode, mrno, tranNo, result);
                }
            });
        }

        function BindMedicationHistory(Type, FromDate, ToDate, DCode, mrno, tranNo, LstData) {
            if (LstData[0] != null && LstData[0].length > 0) {
                var DateList = FilterDateWise("O", LstData[0]);
                $.grep(DateList, function (a) {
                    var AllData = JSON.parse(JSON.stringify(LstData));
                    var OPDPresc = FilterDateWiseData("O", a, AllData);
                    var DateId = IdForGroupDiv(a);
                    var DivId = "O" + "_" + DateId;
                    var LabelShow = ShowDateConvert(a);
                    AddGroupDiv(DivId, "O", LabelShow, "tbldiv");
                    for (var i = 0; i < OPDPresc[0].length; i++) {
                        var $divPanel = $('<div>', { style: '', class: 'panel' });
                        var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
                        var patCompleteYn = $.session.get('PatCompleted');
                        var flg = (tranNo == OPDPresc[0][i].TRANNO.toString() || patCompleteYn != "N") ? false : true;
                        var flagHead = 0;
                        var flagRoute = 0;
                        var flagDrugForm = 0;
                        var flagFromCims = 0;
                        var flagNotFromCims = 0;
                        $.each(OPDPresc[1], function (key, value) {
                            if (OPDPresc[0][i].TRANNO.toString() == value.TRANNO) {
                                if (value.DOSSAGE != "") {
                                    flagHead = 1;
                                }
                                if (value.ROUTE != "") {
                                    flagRoute = 1;
                                }
                                if (value.DRUGFORM != "") {
                                    flagDrugForm = 1;
                                }
                                if (value.CIMSMEDYN == "Y") {
                                    flagFromCims = 1;
                                }
                                if (value.CIMSMEDYN == "N") {
                                    flagNotFromCims = 1;
                                }
                            }
                        });
                        if ((('<%:Session["CIMYN"]%>').toString() == "Y")) {
                            if ((flagNotFromCims == 0) && flg && CheckPatSessionNotEmpty())
                                flg = true;
                            else
                                flg = false;
                        }
                        else {
                            if ((flagFromCims == 0) && flg && CheckPatSessionNotEmpty())
                                flg = true;
                            else
                                flg = false;
                        }
                        var strTable = "<table style='width:100%'>" +
                            "<tr>" +
                            "<td class='ExColicon' style='width: 50%;text-align: left;padding-bottom: 10px;'>OPD case summary</td>" +
                            "<td class='ExColicon' style='text-align: right;'>" + (OPDPresc[0][i].DOCTNAME.toString() == "" ? "" : ("Dr." + OPDPresc[0][i].DOCTNAME.toString() + (OPDPresc[0][i].SPECNAME.toString() == "" ? "" : " (" + OPDPresc[0][i].SPECNAME.toString() + ")"))) + "</td>" +
                            "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td class='ExColicon' style='width: 50%;text-align: left;' class='ComplStatus' id='" + OPDPresc[0][i].TRANNO.toString() + "'>" + (OPDPresc[0][i].COMPLETEDYN.toString() === "Y" ? "<span style='width:20px;display:inline-block'><i class='fa fa-check fa-2x' aria-hidden='true' style='font-size: 1.0em; color: #b9ffb1; cursor:pointer' title='Completed Status'></i></span>" : "") + "Consultation No : " + OPDPresc[0][i].TRANNO.toString() + "</td>" +
                            "<td class='ExColicon' style='text-align: right;'>Time :" + /*ConvertTo12Hour*/("O", OPDPresc[0][i].TRANTIME) + "</td>" + // Abhishesh || 20260323
                            "</tr></table>";
                        $divPanelHead.append(strTable);
                        var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });
                        var patSex = "", agesx = "";
                        if (OPDPresc[0][i].PATSEX.toString() == "M") {
                            patSex = "Male"
                        } else if (OPDPresc[0][i].PATSEX.toString() == "F") {
                            patSex = "Female";
                        }
                        var PatAge = '';
                        if (OPDPresc[0][i].PATAGE.toString() != "" && OPDPresc[0][i].PATAGE.toString() != null) {
                            PatAge = OPDPresc[0][i].PATAGE.toString().replace(/\./g, ':');//
                            PatAge = PatAge.split(":");
                            if (PatAge[1] != "") {
                                PatAge = PatAge[0].replace(/^0+/, '') + " years," + PatAge[1].replace(/^0+/, '') + " months";
                            } else
                                PatAge = PatAge[0].replace(/^0+/, '') + " years";
                        }
                        if (OPDPresc[0][i].PATSEX.toString() == "" && OPDPresc[0][i].PATAGE.toString() == "")
                            agesx = "";
                        else if (OPDPresc[0][i].PATSEX.toString() == "" || OPDPresc[0][i].PATAGE.toString() == "") {
                            agesx = "&nbsp(&nbsp;" + PatAge + patSex + "&nbsp;)&nbsp;";
                        } else
                            agesx = "&nbsp(&nbsp;" + PatAge + "|" + patSex + "&nbsp;)&nbsp;";

                        var strTable1 = "<div class='col-md-12 col-sm-12' style='background: #e6e9eb;margin-top: -10px;border: 1px solid #c8c4c4;font-weight:bold'>"
                            + OPDPresc[0][i].PATNAME.toString() + agesx + "</div><br>";
                        $divPanelBody.append(strTable1);
                        var $divComplaintsNVitals = $('<div>', { class: 'row nopadding' });
                        if (OPDPresc[2].length > 0) {
                            var TranDateArryFrmResultTwo = [];
                            Object.keys(OPDPresc[2]).forEach(function (key) {
                                var val = OPDPresc[2][key]["TRANNO"];
                                TranDateArryFrmResultTwo.push(val);
                            });
                            var rs = TranDateArryFrmResultTwo.includes(OPDPresc[0][i].TRANNO);
                        }
                        if (OPDPresc[10].length > 0) {
                            var TranDateArryFrmResultTen = [];
                            Object.keys(OPDPresc[10]).forEach(function (key) {
                                var val = OPDPresc[10][key]["TRANNO"];
                                TranDateArryFrmResultTen.push(val);
                            });
                            var rs1 = TranDateArryFrmResultTen.includes(OPDPresc[0][i].TRANNO);
                        }
                        if (OPDPresc[4].length > 0 && ((OPDPresc[2].length > 0 && rs) || (OPDPresc[10].length > 0 && rs1)))
                            var strComplaintLst = "<div class='col-md-6 CheifCompDispYN' style='display:" + ($("#chkCheifComp").prop("checked") == true ? "block" : "none") + "'>";
                        else
                            var strComplaintLst = "<div class='col-md-12 CheifCompDispYN' style='display:" + ($("#chkCheifComp").prop("checked") == true ? "block" : "none") + "'>";
                        if ((OPDPresc[2].length > 0 && rs) || (OPDPresc[10].length > 0 && rs1)) {
                            strComplaintLst += "<label><u>Chief Complaints : </u></label>";//
                            strComplaintLst += "<ul class='liClass'>";
                        }
                        if (OPDPresc[2].length > 0) {
                            if (rs) {
                                for (var j = 0; j < OPDPresc[2].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[2][j].TRANNO) {
                                        var dash = (OPDPresc[2][j].REMARKS == "") ? "" : "-";
                                        var totalDurationString = Number(OPDPresc[2][j].DURATION) > 0 ? " since " + OPDPresc[2][j].DURATION + " " + OPDPresc[2][j].DURTYPE : "";
                                        strComplaintLst += "<li>" + OPDPresc[2][j].NAME + dash + OPDPresc[2][j].REMARKS + totalDurationString + "</li>"
                                    }
                                }
                            }
                        }
                        if (OPDPresc[10].length > 0) {
                            if (rs1) {
                                for (var j = 0; j < OPDPresc[10].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[10][j].TRANNO) {
                                        strComplaintLst += "<li>" + OPDPresc[10][j].FREECOMPLAINT + "</li>"
                                    }
                                }
                            }
                        }
                        if ((OPDPresc[2].length > 0 && rs) || (OPDPresc[10].length > 0 && rs1)) {
                            strComplaintLst += "</ul><br>";
                        }
                        strComplaintLst += "</div>";
                        $divComplaintsNVitals.append(strComplaintLst);
                        var strVitalsLst = '';
                        if (OPDPresc[4].length > 0 && ((OPDPresc[2].length > 0 && rs) || (OPDPresc[10].length > 0 && rs1)))
                            strVitalsLst = "</div><div class='col-md-6 GenExamDispYN' style='display:" + ($("#chkGeneralExam").prop("checked") == true ? "block" : "none") + "'>";
                        else
                            strVitalsLst = "</div><div class='col-md-12 GenExamDispYN' style='display:" + ($("#chkGeneralExam").prop("checked") == true ? "block" : "none") + "'>";
                        if (OPDPresc[4].length > 0) {
                            var TranDateArryFrmResultFour = [];
                            Object.keys(OPDPresc[4]).forEach(function (key) {
                                var val = OPDPresc[4][key]["TRANNO"];
                                TranDateArryFrmResultFour.push(val);
                            });
                            var rs = TranDateArryFrmResultFour.includes(OPDPresc[0][i].TRANNO);
                            if (rs) {
                                var flag = false;
                                var strLiVitalsLst = "";
                                for (var j = 0; j < OPDPresc[4].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[4][j].TRANNO) {
                                        if (OPDPresc[4][j].WEIGHT.toString() != "" && Number(OPDPresc[4][j].WEIGHT) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>Weight :&emsp; " + OPDPresc[4][j].WEIGHT + " Kg</li>";
                                        }

                                        if (OPDPresc[4][j].HEIGHT.toString() != "" && Number(OPDPresc[4][j].HEIGHT) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>Height:&emsp; " + OPDPresc[4][j].HEIGHT + " cm</li>";
                                        }

                                        if (OPDPresc[4][j].TEMP.toString() != "" && Number(OPDPresc[4][j].TEMP) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>Temperature:&emsp; " + OPDPresc[4][j].TEMP + " &#x2109;</li>";
                                        }

                                        if (OPDPresc[4][j].PULSE.toString() != "" && Number(OPDPresc[4][j].PULSE) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>Pulse:&emsp; " + OPDPresc[4][j].PULSE + " bpm</li>";
                                        }

                                        if (OPDPresc[4][j].RESP.toString() != "" && Number(OPDPresc[4][j].RESP) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>Resp:&emsp; " + OPDPresc[4][j].RESP + "</li>";
                                        }

                                        if (OPDPresc[4][j].BP.toString() != "" && Number(OPDPresc[4][j].BP) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>BP:&emsp; " + OPDPresc[4][j].BP + " mmhg</li>";//
                                        }

                                        if (OPDPresc[4][j].VOTHERS.toString() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>VOthers:&emsp; " + OPDPresc[4][j].VOTHERS + "</li>";
                                        }

                                        if (OPDPresc[4][j].SPO2.toString() != "" && Number(OPDPresc[4][j].SPO2) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>SpO2:&emsp; " + OPDPresc[4][j].SPO2 + "%</li>";//
                                        }
                                        if (OPDPresc[4][j].BMI.trim() != "" && Number(OPDPresc[4][j].BMI) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>BMI:&emsp; " + OPDPresc[4][j].BMI + "kg/(m²)</li>";
                                        }

                                        if (OPDPresc[4][j].HEADCIRCMF.trim() != "" && Number(OPDPresc[4][j].HEADCIRCMF) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>Head Circumference:&emsp; " + OPDPresc[4][j].SPO2 + "cm</li>";
                                        }

                                        if (OPDPresc[4][j].PEFR.trim() != "" && Number(OPDPresc[4][j].PEFR) != 0) {
                                            flag = true;
                                            strLiVitalsLst += "<li>PEFR:&emsp; " + OPDPresc[4][j].PEFR + " lit/min</li>";
                                        }

                                        if (OPDPresc[4][j].Technique.trim() != "" && OPDPresc[4][j].Technique != "N") {
                                            flag = true;
                                            if (OPDPresc[4][j].Technique == "G")
                                                OPDPresc[4][j].Technique = "Good";
                                            if (OPDPresc[4][j].Technique == "A")
                                                OPDPresc[4][j].Technique = "Average";
                                            if (OPDPresc[4][j].Technique == "L")
                                                OPDPresc[4][j].Technique = "Low";
                                            strLiVitalsLst += "<li>Technique:&emsp; " + OPDPresc[4][j].Technique + "</li>";
                                        }
                                        if (OPDPresc[4][j].Compliance.trim() != "" && OPDPresc[4][j].Compliance != "N") {
                                            flag = true;
                                            if (OPDPresc[4][j].Compliance == "G")
                                                OPDPresc[4][j].Compliance = "Good";
                                            if (OPDPresc[4][j].Compliance == "A")
                                                OPDPresc[4][j].Compliance = "Average";
                                            if (OPDPresc[4][j].Compliance == "L")
                                                OPDPresc[4][j].Compliance = "Low"
                                            strLiVitalsLst += "<li>Compliance:&emsp; " + OPDPresc[4][j].Compliance + "</li>";
                                        }
                                        if (OPDPresc[4][j].DIETYN.trim() != "" && OPDPresc[4][j].DIETYN != "N") {
                                            flag = true;

                                            strLiVitalsLst += "<li>Diet:&emsp; Yes</li>";
                                        }
                                        if (OPDPresc[4][j].REGMEDYN.trim() != "" && OPDPresc[4][j].REGMEDYN != "N") {
                                            flag = true;

                                            strLiVitalsLst += "<li>Regular Medicine:&emsp; Yes</li>";
                                        }
                                        if (OPDPresc[4][j].WALKYN.trim() != "" && OPDPresc[4][j].WALKYN != "N") {
                                            flag = true;

                                            strLiVitalsLst += "<li>Walking:&emsp; Yes</li>";
                                        }
                                        if (OPDPresc[4][j].PAINSCORE.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>Pain Score:&emsp; " + OPDPresc[4][j].PAINSCORE + " </li>";
                                        }
                                        if (OPDPresc[4][j].BSA.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>BSA:&emsp; " + OPDPresc[4][j].BSA + " m²</li>";
                                        }
                                        if (OPDPresc[4][j].RBS.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>RBS:&emsp; " + OPDPresc[4][j].RBS + " mg/dl</li>";
                                        }
                                        if (OPDPresc[4][j].KARNOFSKY.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>Karnofsky Score:&emsp; " + OPDPresc[4][j].KARNOFSKY + " %</li>";
                                        }
                                        if (OPDPresc[4][j].ECOG.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>ECOG Score:&emsp; " + OPDPresc[4][j].ECOG + " </li>";
                                        }

                                        //Added by Murali on 25/04/2024
                                        //*******************************************
                                        if (OPDPresc[4][j].IBW.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>IBW:&emsp; " + OPDPresc[4][j].IBW + " </li>";
                                        }
                                        if (OPDPresc[4][j].BWPERC.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>BW %:&emsp; " + OPDPresc[4][j].BWPERC + " </li>";
                                        }
                                        if (OPDPresc[4][j].WAISTCIRCUM.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>Waist Circumference:&emsp; " + OPDPresc[4][j].WAISTCIRCUM + " cm</li>";
                                        }
                                        if (OPDPresc[4][j].HIPCIRCUM.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>Hip Circumference:&emsp; " + OPDPresc[4][j].HIPCIRCUM + " cm</li>";
                                        }
                                        if (OPDPresc[4][j].WHR.trim() != "") {
                                            flag = true;
                                            strLiVitalsLst += "<li>WHR:&emsp; " + OPDPresc[4][j].WHR + " </li>";
                                        }
                                        //*******************************************

                                    }
                                }

                                if (flag) {
                                    strVitalsLst += "<label><u>Vitals : </u></label>";//
                                    strVitalsLst += "<ul class='liClass'>";
                                    strVitalsLst += strLiVitalsLst;
                                    strVitalsLst += "</ul>";
                                }
                                //strVitalsLst += "</ul>";
                            }

                        }
                        strVitalsLst += "</div>";
                        $divComplaintsNVitals.append(strVitalsLst);

                        //hISTORY ADDED BY MEENAKSHI
                        var $divPastHist = $('<div>', { class: 'row nopadding HistoryDispYN', style: ("display:" + ($("#chkHistory").prop("checked") == true ? "block" : "none")) });
                        var strPasterHIst = "<div class='col-md-12 HistoryDispYN' >";
                        for (var j = 0; j < OPDPresc[12].length; j++) {
                            if (OPDPresc[0][i].TRANNO == OPDPresc[12][j].TRANNO) {
                                if (OPDPresc[12][j]["PASTHIST"] != "") {
                                    strPasterHIst += "<label><u>History : </u></label>";

                                    strPasterHIst += "<p  id=H" + j + OPDPresc[12][j].TRANNO + " onClick='selectText(this.id);'>" + OPDPresc[12][j]["PASTHIST"].toString().replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p></ul>";
                                }
                            }
                        }
                        strPasterHIst += "</div>";
                        $divPastHist.append(strPasterHIst);
                        //Past History 

                        // Diagnosis
                        var $divDiagno = $('<div>', { class: 'row nopadding DiagnosisDispYN', style: ("display:" + ($("#chkDiagnosis").prop("checked") == true ? "block" : "none")) });
                        var strProvDiagnos = "<div class='col-md-12 '>";
                        //medicineList += "<div class='leftHead'>Rx</div>";

                        for (var j = 0; j < OPDPresc[8].length; j++) {
                            if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                if (OPDPresc[8][j]["PROVDIAG"] != "") {
                                    strProvDiagnos += "<label><u>Provisional Diagnosis : </u></label>";
                                    strProvDiagnos += "<ul class='liClass'>";
                                    strProvDiagnos += "<li>" + OPDPresc[8][j]["PROVDIAG"] + "</li></ul>";
                                }
                            }
                            if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                if (OPDPresc[8][j]["SITE"] != "") {
                                    strProvDiagnos += "<label><u>Site :</u></label>";
                                    //strProvDiagnos += "<label><u>Composit Staging :</u></label>";
                                    strProvDiagnos += "<ul class='liClass'>";
                                    strProvDiagnos += "<li>" + OPDPresc[8][j]["SITE"] + "</li></ul>";
                                }
                            }
                            if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                if (OPDPresc[8][j]["SUBSITE"] != "") {
                                    strProvDiagnos += "<label><u>Sub Site :</u></label>";
                                    //strProvDiagnos += "<label><u>Composit Staging :</u></label>";
                                    strProvDiagnos += "<ul class='liClass'>";
                                    strProvDiagnos += "<li>" + OPDPresc[8][j]["SUBSITE"] + "</li></ul>";
                                }
                            }
                            if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                if (OPDPresc[8][j]["TSTAGE"] != "") {
                                    strProvDiagnos += "<label><u>TNM :</u></label>";
                                    //strProvDiagnos += "<label><u>TNM Staging :</u></label>";
                                    strProvDiagnos += "<ul class='liClass'>";
                                    strProvDiagnos += "<li> T<sub>" + OPDPresc[8][j]["TSTAGE"] + "</sub>  N<sub>" + OPDPresc[8][j]["NSTAGE"] + "</sub>  M<sub>" + OPDPresc[8][j]["MSTAGE"] + "</sub></li></ul>";
                                }
                            }
                            if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                if (OPDPresc[8][j]["COMPOSTAG"] != "") {
                                    strProvDiagnos += "<label><u>Stage :</u></label>";
                                    //strProvDiagnos += "<label><u>Composit Staging :</u></label>";
                                    strProvDiagnos += "<ul class='liClass'>";
                                    strProvDiagnos += "<li>" + OPDPresc[8][j]["COMPOSTAG"] + "</li></ul>";
                                }
                            }

                            strProvDiagnos += "</ul></div>";
                        }
                        $divDiagno.append(strProvDiagnos);


                        if (OPDPresc[3].length > 0) {

                            // Array of trandates from OPDPresc[3] i. e Diagnosis
                            var TranDateArryFrmResultTHree = [];
                            //iterate through object keys
                            Object.keys(OPDPresc[3]).forEach(function (key) {
                                //get the value of name
                                var val = OPDPresc[3][key]["TRANNO"];
                                //push the name string in the array
                                TranDateArryFrmResultTHree.push(val);
                            });

                            var rs = TranDateArryFrmResultTHree.includes(OPDPresc[0][i].TRANNO);

                            if (rs) {
                                var strDiagnoLst = "<div class='col-md-12'>"
                                //medicineList += "<div class='leftHead'>Rx</div>";
                                strDiagnoLst += "<label><u>Diagnosis : </u></label>";
                                strDiagnoLst += "<ul class='liClass'>";
                                for (var j = 0; j < OPDPresc[3].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[3][j].TRANNO) {
                                        var dash = (OPDPresc[3][j].REMARKS == "") ? "" : "-";
                                        strDiagnoLst += "<li>" + OPDPresc[3][j].NAME + "&emsp; " + dash + "&emsp; " + OPDPresc[3][j].REMARKS + "</li>";
                                    }
                                }
                                strDiagnoLst += "</ul></div>";

                                $divDiagno.append(strDiagnoLst);
                            }
                        }

                        if (OPDPresc[9].length > 0) {
                            // Array of trandates from OPDPresc[3] i. e Diagnosis
                            var TranDateArryFrmResultTHree = [];
                            //iterate through object keys
                            Object.keys(OPDPresc[9]).forEach(function (key) {
                                //get the value of name
                                var val = OPDPresc[9][key]["TRANNO"];
                                //push the name string in the array
                                TranDateArryFrmResultTHree.push(val);
                            });

                            var rs = TranDateArryFrmResultTHree.includes(OPDPresc[0][i].TRANNO);

                            if (rs) {
                                var strDiagnoLst = "<div class='col-md-12'>"
                                //medicineList += "<div class='leftHead'>Rx</div>";
                                strDiagnoLst += "<label><u>ICD Diagnosis : </u></label>";
                                strDiagnoLst += "<ul class='liClass'>";
                                for (var j = 0; j < OPDPresc[9].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[9][j].TRANNO) {
                                        var dash = (OPDPresc[9][j].REMARKS == "") ? "" : "-";
                                        strDiagnoLst += "<li>" + OPDPresc[9][j].ICDCODE + "&emsp; " + OPDPresc[9][j].NAME + "</li>";
                                    }
                                }
                                strDiagnoLst += "</ul></div>";

                                $divDiagno.append(strDiagnoLst);
                            }

                        }

                        if (OPDPresc[13].length > 0) {
                            var TranDateArryFrmResultTHree = [];
                            Object.keys(OPDPresc[13]).forEach(function (key) {
                                var val = OPDPresc[13][key]["TRANNO"];
                                TranDateArryFrmResultTHree.push(val);
                            });
                            var rs = TranDateArryFrmResultTHree.includes(OPDPresc[0][i].TRANNO);
                            if (rs) {
                                var strDiagnoLst = "<div class='col-md-12'>"
                                strDiagnoLst += "<label><u>ICD-O Diagnosis : </u></label>";
                                strDiagnoLst += "<ul class='liClass'>";
                                for (var j = 0; j < OPDPresc[13].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[13][j].TRANNO) {
                                        var dash = (OPDPresc[13][j].REMARKS == "") ? "" : "-";
                                        strDiagnoLst += "<li>" + OPDPresc[13][j].ICDOCODE + "&emsp; " + OPDPresc[13][j].NAME + "</li>";
                                    }
                                }
                                strDiagnoLst += "</ul></div>";
                                $divDiagno.append(strDiagnoLst);
                            }
                        }

                        // Examination
                        var $divExamination = $('<div>', { class: 'row nopadding OnExamDispYN', style: ("display:" + ($("#chkOnExam").prop("checked") == true ? "block" : "none")) });
                        if (OPDPresc[5].length > 0) {

                            // Array of trandates from OPDPresc[5] i. e Examination
                            var TranDateArryFrmResultFive = [];
                            //iterate through object keys
                            Object.keys(OPDPresc[5]).forEach(function (key) {
                                //get the value of name
                                var val = OPDPresc[5][key]["TRANNO"];
                                //push the name string in the array
                                TranDateArryFrmResultFive.push(val);
                            });

                            var rs = TranDateArryFrmResultFive.includes(OPDPresc[0][i].TRANNO);

                            if (rs) {

                                var strExmLst = "<div class='col-md-12'>";

                                for (var j = 0; j < OPDPresc[5].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[5][j].TRANNO && OPDPresc[5][j].EXAM != "") {
                                        strExmLst += "<label><u>Physical Examination : </u></label>";//
                                        var id = "P" + j + OPDPresc[5][j].TRANNO;
                                        strExmLst += "<p id='" + id + "' onClick='selectText(this.id);' style='font-size:13px;font-weight:500'>&emsp;" + OPDPresc[5][j].EXAM.toString().replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p>";
                                    }
                                    strExmLst += "<table>";

                                    if (OPDPresc[0][i].TRANNO == OPDPresc[5][j].TRANNO) {

                                        datatosend = {
                                            MrNo: mrno,
                                            TranNo: OPDPresc[0][i].TRANNO
                                        }
                                        $.ajax({
                                            type: 'POST',
                                            url: 'RetriveExamImages',
                                            data: datatosend,
                                            async: false,
                                            success: function (ImageData) {
                                                var imageStr = ''
                                                $.each(ImageData, function (index, element) {
                                                    strExmLst += "<tr>";
                                                    var fileNo = element.split("|");
                                                    var strUrl = "data:[<media type>];charset=utf-8;base64," + fileNo[1];
                                                    imageStr += '<div class="col-md-6" style="background: #f5f5f5;">';
                                                    imageStr += '<div class="thumbnail" >';  //onclick="OpenImage(this,event)"
                                                    imageStr += '<img id=' + fileNo[0] + ' src="' + strUrl + '" alt="Lights" ></div></div>';  //style="width:100px;height:100px"

                                                })
                                                strExmLst += imageStr;
                                                strExmLst += "</tr>";
                                                strExmLst += "</table>";
                                                strExmLst += "</div>";
                                            },
                                            complete: function () {
                                                HoldOn.close();
                                            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                HoldOn.close();
                                            }
                                        });
                                    }
                                }
                            }
                            $divExamination.append(strExmLst);
                        }

                        // Advices 
                        var $divAdvices = $('<div>', { class: 'row nopadding' });
                        var medicineList = "";
                        if (OPDPresc[1].length > 0) {

                            // Array of trandates from OPDPresc[1] i. e Advices
                            var TranDateArryFrmResultOne = [];
                            //iterate through object keys
                            Object.keys(OPDPresc[1]).forEach(function (key) {
                                //get the value of name
                                var val = OPDPresc[1][key]["TRANNO"];
                                //push the name string in the array
                                TranDateArryFrmResultOne.push(val);
                            });

                            var rs = TranDateArryFrmResultOne.includes(OPDPresc[0][i].TRANNO);
                            if (rs) {
                                var flag = 0;
                                var flagRoute = 0;
                                var flagDrugForm = 0;
                                var flagFromCims = 0;
                                var flagNotFromCims = 0;
                                var FlagQty = 0; //Meenakshi
                                $.each(OPDPresc[1], function (key, value) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[1][key]["TRANNO"]) {
                                        if (value.DOSSAGE != "") {
                                            flag = 1;
                                            //return false;
                                        }
                                        if (value.QTY != "") {
                                            FlagQty = 1;
                                            //return false;
                                        }
                                        if (value.ROUTE != "") {//
                                            flagRoute = 1;
                                            // return false;
                                        }
                                        if (value.DRUGFORM != "") {//
                                            flagDrugForm = 1;
                                            // return false;
                                        }
                                        if (value.CIMSMEDYN == "Y") {
                                            flagFromCims = 1;
                                            // return false;

                                        }//
                                        if (value.CIMSMEDYN == "N") {
                                            flagNotFromCims = 1;
                                            // return false;
                                        }//

                                    }
                                });

                                if (('<%:Session["CIMYN"]%>').toString() == "Y") {
                                    if ((flagFromCims == 1) && flg)
                                        flg = true;
                                    else
                                        flg = false;
                                } else {
                                    if ((flagNotFromCims == 1) && flg)
                                        flg = true;
                                    else
                                        flg = false;
                                }
                                flg = false;
                                //..................end.........................
                                //$.each(OPDPresc[1], function (key, value) {

                                //});
                                //07-09-19
                                var concateComma = '';//3/28/19

                                medicineList = "<div class='col-md-12 RxDispYN' style='display:" + ($("#chkRx").prop("checked") == true ? "block" : "none") + "'>";
                                //medicineList += "<div class='leftHead'>Rx</div>";
                                medicineList += "<label><u>Rx : </u></label>";
                                if (flg)
                                    medicineList += "<button style='float:right;background-color: #f3d0b7;' onclick='RefillFuncRx(\"" + OPDPresc[0][i].TRANNO + "\",\"" + OPDPresc[0][i].TRANDATE + '-' + OPDPresc[0][i].TRANTIME + "\");'><b>Refill</b></button>";//4/6/19

                                medicineList += "<div class='table-responsive' style='display:block;overflow:auto;max-height:248px;'><table style='width:100%;border-collapse:collapse' border='1' class='tblRx'>";
                                // 27-04-20202 div added
                                var HeadRow = "<tr  style='background: #fdd283;color: #4e4e4e;'>";
                                var thHead = ""
                                thHead += "<th>Sr.No.</th>";
                                if (flagDrugForm == 1) {
                                    thHead += "<th style=''>Form</th><th>" + (GeneralWiseYN == "Y" ? "Generic" : "Medicine") + "</th><th>Date</th><th>Frequency</th>";// 27-04-2020
                                }
                                else
                                    thHead += "<th>" + (GeneralWiseYN == "Y" ? "Generic" : "Medicine") + "</th><th>Date</th><th>Frequency</th>";


                                if (flagHead == 1) {
                                    thHead = thHead + "<th>Dose</th>";
                                }

                                if (FlagQty == 1) {
                                    thHead = thHead + "<th>Qty</th><th>Duration</th>";
                                } else {
                                    thHead = thHead + "<th>Duration</th>";
                                }

                                if (flagRoute == 1) {
                                    thHead = thHead + "<th>Route</th><th>Remark</th></tr>";
                                }
                                else {
                                    thHead = thHead + "<th>Remark</th></tr>";
                                }

                                HeadRow = HeadRow + thHead;
                                medicineList += HeadRow;

                                var serialNumber = 1; //added by ashvini to reset the serial no on 15/10/2024
                                for (var j = 0; j < OPDPresc[1].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[1][j].TRANNO) {

                                        if (OPDPresc[1][j].ABFOOD != "" && OPDPresc[1][j].Remarks != "") {
                                            concateComma = ", "
                                        }
                                        if (OPDPresc[0][i].TRANDATE == OPDPresc[1][j].TRANDATE) {
                                            var days = (OPDPresc[1][j].DAYS.substr(0, 1) != "0" ? OPDPresc[1][j].DAYS : "-");
                                            var Newrow = "<tr>";
                                            var NewColumns = "";
                                            //Meenakshi Pass sr number column
                                            NewColumns += "<td style='width:5%;'>" + serialNumber + "</td>";  //added by ashvini to reset the serial no on 15/10/2024
                                            var DrugNm = GeneralWiseYN == "Y" ? OPDPresc[1][j].DRUGNM : OPDPresc[1][j].DRUGNM + "(" + OPDPresc[1][j].GENERICNAM + ")";
                                            if (flagDrugForm == 1)
                                                NewColumns += "<td>" + OPDPresc[1][j].DRUGFORM + "." + "</td><td style='width:25%;'>" + DrugNm + "</td><td style='width:7%;'>" + OPDPresc[1][j].MEDSTARTDATE + "</td><td style='width:10%;'>" + (OPDPresc[1][j].INTAKE).replace("0.5", "1,2") + "</td>";
                                            else
                                                NewColumns += "<td style='width:30%;'>" + DrugNm + "</td><td style='width:7%;'>" + OPDPresc[1][j].MEDSTARTDATE + "</td><td style='width:10%;'>" + (OPDPresc[1][j].INTAKE).replace("0.5", "1,2") + "</td>";

                                            if (flagHead == 1) {
                                                NewColumns += "<td style='width:10%;'>" + OPDPresc[1][j].DOSSAGE + "</td>";
                                            }

                                            if (FlagQty == 1) {//Meenakshi
                                                NewColumns += "<td style='width:10%;'>" + OPDPresc[1][j].QTY + "</td><td style='width:10%;'>" + days + "</td>";
                                            }
                                            else {
                                                NewColumns += "<td style='width:10%;'>" + days + "</td>";
                                            }

                                            if (flagRoute == 1) {
                                                NewColumns += "<td style='width:10%;'>" + OPDPresc[1][j].ROUTE + "</td><td style='width:28%'>" + OPDPresc[1][j].ABFOOD + concateComma + OPDPresc[1][j].Remarks + "</td></tr>"  //kavita 14-aug-2016
                                            }
                                            else
                                                NewColumns += "<td style='width:30%'>" + OPDPresc[1][j].ABFOOD + concateComma + OPDPresc[1][j].Remarks + "</td></tr>"  //kavita 14-aug-2016

                                            Newrow = Newrow + NewColumns;
                                            medicineList += Newrow;

                                            // Increment the serial number for the next entry
                                            serialNumber++;  //added by ashvini to reset the serial no on 15/10/2024
                                        }
                                    }
                                }
                            }
                            medicineList += "</table></div></div></div>";
                            $divAdvices.append(medicineList);
                            medicineList = "";
                        }

                        //Investigations                       
                        var $divInvestpatAdv = $('<div>', { class: 'row nopadding' });
                        //Investigations

                        var rs = "", rs1 = "";
                        if (OPDPresc[6].length > 0) {

                            // Array of trandates from OPDPresc[2] i. e complaints
                            var TranDateArryFrmResultSix = [];
                            //iterate through object keys
                            Object.keys(OPDPresc[6]).forEach(function (key) {
                                //get the value of name
                                var val = OPDPresc[6][key]["TRANNO"];
                                //push the name string in the array
                                TranDateArryFrmResultSix.push(val);
                            });

                            rs = TranDateArryFrmResultSix.includes(OPDPresc[0][i].TRANNO);
                        }

                        if (OPDPresc[11].length > 0) {
                            // Array of trandates from OPDPresc[2] i. e complaints
                            var TranDateArryFrmResultEleven = [];
                            //iterate through object keys
                            Object.keys(OPDPresc[11]).forEach(function (key) {
                                //get the value of name
                                var val = OPDPresc[11][key]["TRANNO"];
                                //push the name string in the array
                                TranDateArryFrmResultEleven.push(val);
                            });
                            rs1 = TranDateArryFrmResultEleven.includes(OPDPresc[0][i].TRANNO);
                        }
                        var strInvestigationLst = '';
                        if (((OPDPresc[6].length > 0 && rs) || (OPDPresc[11].length > 0 && rs1)) && OPDPresc[7].length > 0) {

                            strInvestigationLst = "<div class='col-md-6 AdvInvstDispYN' style='display:" + ($("#chkAdvInvst").prop("checked") == true ? "block" : "none") + "'>";

                        } else {
                            strInvestigationLst = "<div class='col-md-12 AdvInvstDispYN' style='display:" + ($("#chkAdvInvst").prop("checked") == true ? "block" : "none") + "'>";

                        }//
                        if ((OPDPresc[6].length > 0 && rs) || (OPDPresc[11].length > 0 && rs1)) {
                            strInvestigationLst += "<label><u>Advice for Investigations : </u></label>";//
                            strInvestigationLst += "<ul class='liClass'>";
                        }
                        if (OPDPresc[6].length > 0) {
                            if (rs) {

                                for (var j = 0; j < OPDPresc[6].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[6][j].TRANNO) {
                                        var TotalDuration = "";
                                        var dur = "" + OPDPresc[6][j].DURATION;
                                        var durtype = OPDPresc[6][j].DURTYPE;
                                        if (dur.length > 0) {
                                            if (Number(dur) > 0) {
                                                TotalDuration = "  perform after" + dur + " " + DurationTypeSelect(durtype, dur);
                                            }
                                        }
                                        //var dash = (OPDPresc[6][j].REMARKS == "") ? "" : "-";
                                        strInvestigationLst += "<li>" + OPDPresc[6][j].TESTNAME + " " + OPDPresc[6][j].REMARK + " " + TotalDuration + "</li>"
                                    }
                                }

                            }

                        }
                        //free investigation vijeta 22nd march 2019
                        if (OPDPresc[11].length > 0) {
                            if (rs1) {
                                for (var j = 0; j < OPDPresc[11].length; j++) {
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[11][j].TRANNO) {
                                        strInvestigationLst += "<li>" + OPDPresc[11][j].FREEINVESTIGATION + "</li>"
                                    }
                                }
                            }
                        }
                        if ((OPDPresc[6].length > 0 && rs) || (OPDPresc[11].length > 0 && rs1)) {
                            strInvestigationLst += "</ul>";
                        }
                        $divInvestpatAdv.append(strInvestigationLst);//

                        var strPatAdviceLst = '';
                        if (((OPDPresc[6].length > 0 && rs) || (OPDPresc[11].length > 0 && rs1)) && OPDPresc[7].length > 0) {
                            strPatAdviceLst += "</div><div class='col-md-6 AdviceDispYN' style='display:" + ($("#chkRAdvice").prop("checked") == true ? "block" : "none") + "'>";
                        }//
                        else {
                            strPatAdviceLst += "</div><div class='col-md-12 AdviceDispYN' style='display:" + ($("#chkRAdvice").prop("checked") == true ? "block" : "none") + "'>";
                        }

                        //Patient Advices
                        if (OPDPresc[14].length > 0 || OPDPresc[7].length > 0) {
                            var TranDateArryFrmResultSvn = [];
                            var TranDateArryFrmResultSvnFree = [];
                            Object.keys(OPDPresc[7]).forEach(function (key) {
                                var val = OPDPresc[7][key]["TRANNO"];
                                TranDateArryFrmResultSvn.push(val);
                            });
                            Object.keys(OPDPresc[14]).forEach(function (key) {
                                var val = OPDPresc[14][key]["TRANNO"];
                                TranDateArryFrmResultSvnFree.push(val);
                            });
                            var rs = TranDateArryFrmResultSvn.includes(OPDPresc[0][i].TRANNO);
                            var rsFree = TranDateArryFrmResultSvnFree.includes(OPDPresc[0][i].TRANNO);
                            if (rs || rsFree) {
                                strPatAdviceLst += "<label><u>Other Advices : </u></label>";
                                strPatAdviceLst += "<ul class='liClass'>";
                                if (rsFree) {
                                    for (var j = 0; j < OPDPresc[14].length; j++) {
                                        if (OPDPresc[0][i].TRANNO == OPDPresc[14][j].TRANNO) {
                                            strPatAdviceLst += "<li>" + OPDPresc[14][j].FREEADVICE + "</li>";
                                        }
                                    }
                                }
                                if (rs) {
                                    for (var j = 0; j < OPDPresc[7].length; j++) {
                                        if (OPDPresc[0][i].TRANNO == OPDPresc[7][j].TRANNO) {
                                            strPatAdviceLst += "<li>" + OPDPresc[7][j].NAME + "</li>";
                                        }
                                    }
                                }
                                strPatAdviceLst += "</ul>";
                            }
                        }
                        strPatAdviceLst += "</div>";
                        $divInvestpatAdv.append(strPatAdviceLst);//

                        //Follow up details
                        var $divFollowUps = $('<div>', { class: 'row nopadding' });

                        if (OPDPresc[8].length > 0) {

                            // Array of trandates from OPDPresc[8] i. e Follow up details
                            var TranDateArryFrmResultEight = [];
                            //iterate through object keys
                            Object.keys(OPDPresc[8]).forEach(function (key) {
                                //get the value of name
                                var val = OPDPresc[8][key]["TRANNO"];
                                //push the name string in the array
                                TranDateArryFrmResultEight.push(val);
                            });


                            var rs = TranDateArryFrmResultEight.includes(OPDPresc[0][i].TRANNO);

                            if (rs) {

                                for (var j = 0; j < OPDPresc[8].length; j++) {

                                    //surgery advice
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["SURGNMADVICE"] != "") {
                                        var surgAdviceDate = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        surgAdviceDate += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Adviced Date</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + OPDPresc[8][j]["SURGADVDATE"] + "</p></td></tr></table>"
                                        surgAdviceDate += "</div>";
                                        $divFollowUps.append(surgAdviceDate);
                                        var surgAdvice = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        surgAdvice += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Adviced</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + OPDPresc[8][j]["SURGNMADVICE"] + "</p></td></tr></table>"
                                        surgAdvice += "</div>";
                                        $divFollowUps.append(surgAdvice);
                                        var PACAdviceDate = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        PACAdviceDate += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>PAC Advice Date</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + OPDPresc[8][j]["PACADVDATE"] + "</p></td></tr></table>"
                                        PACAdviceDate += "</div>";

                                        $divFollowUps.append(PACAdviceDate);
                                    }//

                                    //Refferred doct
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["DOCTNAME"] != "") {

                                        var array = OPDPresc[8][j]["DOCTNAME"].split(',');

                                        var ReferredDoctLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        ReferredDoctLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Cross Reference to Other Oncologist</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' class='liClass' >";
                                        $.each(array, function (index, val) {
                                            if (val != "") {
                                                ReferredDoctLst += "&#9679; Dr. " + val + "&nbsp;&nbsp;&nbsp;&nbsp;";
                                            }

                                        });
                                        //ReferredDoctLst += " </label>";
                                        ReferredDoctLst += "</td></tr></table></div>";

                                        $divFollowUps.append(ReferredDoctLst);
                                    }//

                                    //Refferred specialisation
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["REFSPECIALIST"] != "") {
                                        var array = OPDPresc[8][j]["REFSPECIALIST"].split(',');
                                        var ReferredSpcLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        ReferredSpcLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Refer to Specialist</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' class='liClass'>";
                                        ReferredSpcLst += "<p id='refSpeciality'>"
                                        $.each(array, function (index, val) {
                                            if (val != "") {
                                                ReferredSpcLst += "&#9679; " + val + "&nbsp;&nbsp;";
                                            }
                                        });
                                        ReferredSpcLst += "</p>"
                                        ReferredSpcLst += "</td></tr></table>";
                                        ReferredSpcLst += "</div>";

                                        $divFollowUps.append(ReferredSpcLst);
                                    }//


                                    //plan Of treatment  // added by meenakshi 1st may
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["PLANOFTREAT"] != "") {

                                        var ReferredSpcLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        ReferredSpcLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Plan of Treatment</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' onClick='selectText(this.id);' id='planOfTreat" + j + "' class='liClass'>";

                                        ReferredSpcLst += OPDPresc[8][j]["PLANOFTREAT"] + "&nbsp;&nbsp;";

                                        ReferredSpcLst += "</td></tr></table>";
                                        ReferredSpcLst += "</div>";

                                        $divFollowUps.append(ReferredSpcLst);
                                    }

                                    //Prescription Remark
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["PRESCREMARK"] != "") {
                                        var array = OPDPresc[8][j]["PRESCREMARK"].split(',');

                                        var ReferredSpcLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        ReferredSpcLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Remark / Notes</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' onClick='selectText(this.id);' id='remarknote" + j + "' class='liClass'>";
                                        $.each(array, function (index, val) {
                                            if (val != "") {
                                                ReferredSpcLst += val + "&nbsp;&nbsp;";
                                            }
                                        });

                                        ReferredSpcLst += "</td></tr></table>";
                                        ReferredSpcLst += "</div>";

                                        $divFollowUps.append(ReferredSpcLst);
                                    }//
                                    //Follow up date
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["FOLLOWUPDT"] != "") {
                                        $divFollowUps.append("</br>");
                                        var ReferredSpcLst = "<div class='col-md-12' >";
                                        if (OPDPresc[8][j]["FOLLOWUPDT"] == "SOS") {
                                            ReferredSpcLst += "<label class='liClass'>Follow up : " + OPDPresc[8][j]["FOLLOWUPDT"] + " if any complaints</label>";      //vishal sos
                                        }
                                        else {
                                            if (OPDPresc[8][j]["APPMNTDT"] == "" && OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                                var TranDate = OPDPresc[0][i].TRANDATE;
                                                var dayNum = (OPDPresc[8][j]["FOLLOWUPDT"]).replace(/[^0-9]+/ig, "");
                                                var FollowUp = (OPDPresc[8][j]["FOLLOWUPDT"]).split(dayNum)[1];
                                                var DayNum = OPDPresc[8][j]["FOLLOWUPDT"].toLowerCase().replace(/s$/, '');
                                                var CalDate = CalculateAppointDate(TranDate, dayNum, FollowUp);
                                                ReferredSpcLst += "<label class='liClass'>Follow up on " + CalDate + " </label>";
                                            }
                                            else {
                                                ReferredSpcLst += "<label class='liClass'>Follow up after " + OPDPresc[8][j]["FOLLOWUPDT"] + " </label>";//
                                            }
                                        }
                                        ReferredSpcLst += "</div>";
                                        $divFollowUps.append(ReferredSpcLst);
                                    }

                                    if (OPDPresc[8][j]["APPMNTDT"] != "" && OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                        ReferredSpcLst = "<div class='col-md-12'>";
                                        ReferredSpcLst += "<label class='liClass'>Your Appointment is booked on " + OPDPresc[8][j]["APPMNTDT"] + " at " + OPDPresc[8][j]["APPMNTTM"] + " </label>";//
                                        ReferredSpcLst += "</div>";
                                        $divFollowUps.append(ReferredSpcLst);
                                    }

                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["ADMNADVYN"] == "Y") {
                                        $divFollowUps.append("</br>");
                                        var AdmAdv = "<div class='col-md-12' ><label class='liClass'>" + (("" + OPDPresc[8][j]["PROPADMNDT"]).trim() != "" ? ("Admission Adviced on " + ("" + OPDPresc[8][j]["PROPADMNDT"]).trim()) : "Admission Adviced") + ".</label></div>";
                                        $divFollowUps.append(AdmAdv);

                                    }
                                }
                            }
                            var $divDoctName = $('<div>', { class: 'row nopadding' });
                            if (OPDPresc[0][i].DOCTNAME != "") {
                                var strDoctName = "<div class='col-md-12' style='background-color:aliceblue;display: flex;flex-direction: column;'><label style='text-align:right;float:right;font-size:13px;'>Dr. " + OPDPresc[0][i].DOCTNAME + "</label><label style='text-align:right;float:right;font-size:12px;'>" + OPDPresc[0][i].DEPTNAME + "</label></div>";
                                $divDoctName.append(strDoctName);
                            }
                            $divPanelBody.append($divComplaintsNVitals);// append complaint n vitals div to panel body
                            $divPanelBody.append($divPastHist);
                            // $divPanelBody.append($divFreeCmplnt);// append free complaint div to panel body  
                            $divPanelBody.append($divDiagno);// append Diagno  div to panel body   
                            $divPanelBody.append($divExamination);// append Examination  div to panel body 
                            //$divPanelBody.append($divExaminationImages);// append Examination  div to panel body 
                            $divPanelBody.append($divAdvices);//append Rx div to panel body
                            $divPanelBody.append($divInvestpatAdv);//append investigations  div to panel body
                            // $divPanelBody.append($divPatAdvice);//append Pat advices  div to panel body  commntd
                            $divPanelBody.append($divFollowUps);//append follow up div to panel body
                            $divPanelBody.append($divDoctName);//append doctName div to panel body
                            //-------------------------
                            $divPanel.append($divPanelHead);
                            $divPanel.append($divPanelBody);


                            $("#" + DivId).append($divPanel)
                        }

                    }
                });
            }
            else {
                var html = '<div class="NoDataFound">No Data Found.</div>'
                $("#tbldiv").append(html);
            }
        }

        function DurationTypeSelect(type, duration) {
            strDay = "Day";
            puralString = "";
            if (Number(duration) > 1) {
                puralString = "s"
            }
            switch (type) {
                case "D":
                    strDay = "Day" + puralString
                    break;
                case "W":
                    strDay = "Week" + puralString;
                    break;
                case "M":
                    strDay = "Month" + puralString
                    break;
                case "Y":
                    strDay = "Year" + puralString
                    break;
                default:
                    strDay = "Day" + puralString
                    break;
            }
            return strDay;
        }

        function RefillFuncRx(ConsultNo, Date) {
            HoldOn.open();
            var splitcon = Date.split('-');
            var tranNo = ($.session.get('PatTRANNO'));
            var mrno = ($.session.get('PatMRNO'));
            var patName = $.session.get('PatName').toString();
            var patAge = ($.session.get('PatAge2') == undefined || $.session.get('PatAge2') == null) ? "" : $.session.get('PatAge2').toString();
            var patGender = ($.session.get('PatGender') == undefined || $.session.get('PatGender') == null) ? "" : $.session.get('PatGender').toString();
            $.ajax({
                type: "POST",
                url: 'RefillRxFromMedHist',
                datatype: "json",
                data: { strTranNo: tranNo, strConsultNo: ConsultNo, strMrno: mrno, strpatName: patName, strpatAge: patAge, strpatGender: patGender, strTranDate: splitcon[0], strTranTime: splitcon[1] },
                success: function (result) {
                    if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        $.messager.alert('Information', 'Copied Successfully');
                    }
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
            });
        }

        function FilterData(CName, ChkId) {
            const divs = document.querySelectorAll(('.' + CName));
            divs.forEach(function (div) {
                div.style.display = $(("#" + ChkId)).prop("checked") == true ? 'block' : 'none';
            });
        }

        function BindDoctorList() {
            var DoctorListData = JSON.parse(DoctorList);
            $("#cmbDoctList").select2();
            $("#cmbDoctList").empty();
            var Option = '<option value="{Value}">{TEXT}</option>';
            var DefaultOption = '<option value="">---All---</option>';
            $("#cmbDoctList").append(DefaultOption);
            for (var i = 0 ; i < DoctorListData.length; i++) {
                var Doctor = Option.replace("{Value}", DoctorListData[i].CODE).replace("{TEXT}", DoctorListData[i].NAME);
                $("#cmbDoctList").append(Doctor);
            }
        }

        function CheckedBox(Id) {
            if ($(("#") + Id).prop("checked") == true)
                $(("#") + Id).prop("checked", false);
            else
                $(("#") + Id).prop("checked", true);
        }

        function CalculateAppointDate(TranDate, Increase, IncreaseType) {
            var parts = TranDate.split('/');
            var dateObj = new Date(parts[2] + "-" + parts[1] + "-" + parts[0]);
            if (IncreaseType.trim().toUpperCase().includes("D")) {
                dateObj.setDate(dateObj.getDate() + Number(Increase));
            }
            else if (IncreaseType.trim().toUpperCase().includes("W")) {
                dateObj.setDate(dateObj.getDate() + (Number(Increase)) * 7);
            }
            else if (IncreaseType.trim().toUpperCase().includes("M")) {
                dateObj.setMonth(dateObj.getMonth() + Number(Increase));
            }
            else if (IncreaseType.trim().toUpperCase().includes("Y")) {
                dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
            }
            else {
                dateObj.setDate(dateObj.getDate() + Number(Increase));
            }
            //switch (IncreaseType) {
            //    case "day":
            //        dateObj.setDate(dateObj.getDate() + Number(Increase));
            //        break;
            //    case "week":
            //        dateObj.setDate(dateObj.getDate() + (Number(Increase)) * 7);
            //        break;
            //    case "month":
            //        dateObj.setMonth(dateObj.getMonth() + Number(Increase));
            //        break;
            //    case "year":
            //        dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
            //        break;
            //    default:
            //        dateObj.setDate(dateObj.getDate() + Number(Increase));
            //}
            var dd = String(dateObj.getDate()).padStart(2, '0');
            var mm = String(dateObj.getMonth() + 1).padStart(2, '0');
            var yyyy = dateObj.getFullYear();
            return (dd + "/" + mm + "/" + yyyy);
        }
    </script>

    <%-- PAC --%>
    <script type="text/javascript">
        function GetPACHistory() {
            var mrno = $.session.get('PatMRNO');
            HoldOn.open();
            var PACHistList = [];
            var FDate = $("#txtFromDate").val();
            var TDate = $("#txtToDate").val();
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/GetPACHistory',
                datatype: "json",
                async: false,
                data: { Mrno: mrno, FromDate: FDate, ToDate: TDate },
                success: function (result) {
                    PACHistList = result == "" ? [] : result;
                },
                complete: function () { HoldOn.close(); },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                    HoldOn.close();
                }
            });
            BindPACHistoryList(PACHistList);
            HoldOn.close();
        }

        function BindPACHistoryList(PACHistList) {
            $("#tblPACdiv").empty();
            if (PACHistList.length > 0) {
                var DateList = FilterDateWise("P", PACHistList);
                $.grep(DateList, function (a) {
                    var AllData = JSON.parse(JSON.stringify(PACHistList));
                    var PACRec = FilterDateWiseData("P", a, AllData);
                    var DateId = IdForGroupDiv(a);
                    var DivId = "P" + "_" + DateId;
                    var LabelShow = ShowDateConvert(a);
                    AddGroupDiv(DivId, "P", LabelShow, "tblPACdiv");
                    for (var i = 0; i < PACRec.length; i++) {
                        var $divPanel = $('<div>', { style: '', class: 'panel' });
                        var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
                        var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });
                        var NatOfSurg = PACRec[i].SURGADVTYPE == "R" ? "Regular" : (PACRec[i].SURGADVTYPE == "E" ? "Emergency" : (PACRec[i].SURGADVTYPE == "T" ? "Tentative" : ""))
                        var PacStatus = PACRec[i].PACSTATUS == "F" ? "Fit" : (PACRec[i].PACSTATUS == "W" ? "Fit, with Accepted Risk" : (PACRec[i].PACSTATUS == "U" ? "UnFit" : "Pending"))
                        var RplIcon = "<i class='fa fa-external-link' style='font-weight: bold;margin-left: 5px;color: black;' onclick=\"PrintPAC('" + PACRec[i].PACCONSNO + "')\"></i>";
                        var strTable = "<table style='width:100%'>" +
                            "<tr>" +
                            "<td style='width: 50%;text-align: left;padding-bottom: 10px;'>PAC</td>" +
                            "<td class='ExColicon' style='text-align: right;'>" + (PACRec[i].PACDONEBY.toString() == "" ? "" : ("Dr." + PACRec[i].PACDONEBY.toString() + (PACRec[i].PACDONESPEC.toString() == "" ? "" : " (" + PACRec[i].PACDONESPEC.toString() + ")"))) + "</td>" +
                            "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td class='ExColicon' style='width: 50%;text-align: left;'>" + PacStatus + "</td>" +
                            "<td class='ExColicon' style='text-align: right;'>Time:" + /*ConvertTo12Hour*/("P", PACRec[i].PACFITTIME) + "</td>" + // Abhishesh || 20260323
                            "</tr></table>";
                        $divPanelHead.append(strTable);
                        var strTableBody = "<table style='width:100%'>" +
                              "<tr>" +
                              "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>PAC Number</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + PACRec[i].PACCONSNO + " " + RplIcon + "</td>" +
                              "</tr>" +
                              "<tr>" +
                              "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Reference Doctor</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + PACRec[i].DOCTNAME + "</td>" +
                              "</tr>" +
                              "<tr>" +
                              "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Surgery Advice Date</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + PACRec[i].SURGADVDATE + "</td>" +
                              "</tr>" +
                              "<tr>" +
                              "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Surgery Advice</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + PACRec[i].SURGNMADVICE + "</td>" +
                              "</tr>" +
                              (NatOfSurg == "" ? "" :
                              "<tr>" +
                              "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Nature Of Surgery</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + NatOfSurg + "</td></tr>") +
                              "</table>";
                        $divPanel.append($divPanelHead);
                        $divPanelBody.append(strTableBody);
                        $divPanel.append($divPanelBody);
                        $("#" + DivId).append($divPanel)
                    }
                });
            }
            else {
                var html = '<div class="NoDataFound">No Data Found.</div>'
                $("#tblPACdiv").append(html);
            }
        }

        function PrintPAC(TranNo) {
            HoldOn.open();
            var DataToSend = {
                TranNo: TranNo,
                MRNo: $.session.get('PatMRNO'),
                SpecialityYN: "Y",
                AllOptionYN: "Y"
            }
            $.ajax({
                url: '../DoctorDesk/PrintPACDtls',
                data: DataToSend,
                type: 'post',
                async: false,
                success: function (response) {
                    var win = window.open('../DoctorDesk/DisplayPrintPAC', "_blank", '', true);
                    win.focus();
                    HoldOn.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                    HoldOn.close();
                },
                complete: function () {
                    HoldOn.close();
                }
            })
        }

        function openIframe(Mrno, TranNo, PACDate, PACTime) {
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            document.getElementById('PACHistFrameLbl').innerText = TranNo + " (" + PACDate + " " + PACTime + ")";
            const iframe = document.createElement("iframe");
            HoldOn.open();
            iframe.id = "myIframe";
            iframe.src = "../DoctorDesk/PAC?PatMRNO=" + Mrno + "&PatTRANNO=" + TranNo;
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.onload = function () {
                var code = iframe.contentWindow.gDoctCode;
                if (!code || code.trim() === "") {
                    document.getElementById("iframeContainer").style.display = "none";
                    window.location.href = "../Account/Login";
                    return;
                }
                const iframeDoc = iframe.contentWindow.document;
                const $secCont = $(iframeDoc).find("#secCont");
                const $iframeBody = $(iframeDoc).find("body, html");
                $(iframeDoc).find(".main-header").hide();
                $(iframeDoc).find("#MainDivBtnGrp").hide();
                $(iframeDoc).find("#InvestRpt").hide();
                $(iframeDoc).find("#content").css("padding", "0px");
                $secCont.attr("style", function (i, s) {
                    return (s || "") +
                      "min-height:0px !important;" +
                      "margin-left:0px !important;" +
                      "padding:0px !important;" +
                      "width:100% !important;";
                });
                $("#myIframe").css("visibility", "visible");
                HoldOn.close();
            };
            document.getElementById("iframeContainer").appendChild(iframe);
        }

        function closeIframe() {
            document.getElementById('iframeMain').style.display = 'none';
        }

        function minimizeIframe() {
            const container = document.getElementById('iframeMain');
            container.classList.toggle('minimized');
        }
    </script>

    <%-- Surgical --%>
    <script type="text/javascript">
        function GetBindingData() {
            var strMrNo = $.session.get('PatMRNO');
            HoldOn.open();
            $.ajax({
                type: "get",
                datatype: "json",
                url: 'GetSurgicalHistoryData',
                data: { strMrNo: strMrNo },
                success: function (response) {
                    var surgeryDataList = [];
                    if (Array.isArray(response)) {
                        surgeryDataList = $.map(response, function (item) {
                            item.IsNew = false;
                            return item;
                        });
                    } else {
                        response.IsNew = false;
                        surgeryDataList = [response];
                    }
                    BindData(surgeryDataList);
                    autoResizeTextareas();
                },
                complete: function () { HoldOn.close(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }

        function BindData(dataList) {
            $("#tblSurgerydiv").empty();
            if (dataList.length > 0) {
                var DateList = FilterDateWise("S", dataList);
                $.grep(DateList, function (a) {
                    var AllData = JSON.parse(JSON.stringify(dataList));
                    var SurgRec = FilterDateWiseData("S", a, AllData);
                    var DateId = IdForGroupDiv(a);
                    var DivId = "S" + "_" + DateId;
                    var LabelShow = ShowDateConvert(a);
                    AddGroupDiv(DivId, "S", LabelShow, "tblSurgerydiv");
                    for (var i = 0; i < SurgRec.length; i++) {
                        var $divPanel = $('<div>', { style: '', class: 'panel' });
                        var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
                        var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });
                        var Inhouse = SurgRec[i].UniqueId == "0" ? "<strong>Inhouse Surgery Done</strong>" : "<strong>Inhouse Surgery Not Done</strong>";
                        var DrInclude = SurgRec[i].SurgeonDoctorName.toString().includes('Dr.') == true ? "" : "Dr."
                        var strTable = "<table style='width:100%'>" +
                            "<tr>" +
                            "<td style='width: 50%;text-align: left;padding-bottom: 10px;'>Surgical</td>" +
                            "<td class='ExColicon' style='text-align: right;'>" + (SurgRec[i].SurgeonDoctorName.toString() == "" ? "" : DrInclude + SurgRec[i].SurgeonDoctorName.toString() + (SurgRec[i].DOCTSP.toString() == "" ? "" : " (" + SurgRec[i].DOCTSP.toString() + ")")) + "</td>" +
                            "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td class='ExColicon' style='width: 50%;text-align: left;'>" + Inhouse + "</td>" +
                            "<td class='ExColicon' style='text-align: right;'>" + (SurgRec[i].SURGTIME.trim() == "" ? "" : ("Time : " + SurgRec[i].SURGTIME)) + "</td>" +
                            "</tr></table>";
                        $divPanelHead.append(strTable);
                        var strBody = "";
                        var rawNotes = SurgRec[i].SurgeryNotes || '';
                        var decodedNotes = decodeURIComponent(rawNotes).replace(/<[^>]*>/g, '');
                        strBody += '<div class="surgery-card">';
                        strBody += '<div class="surgery-card-body">';
                        strBody += '<div class="surgery-SurgeryName-info-box"><strong>Surgery Name : </strong> ' + SurgRec[i].SurgeryName + '</div>';
                        strBody += '<div style="padding: 0px 15px;"><label style="margin: 0px;"><strong>Note: </strong></label><br>';
                        strBody += '<textarea class="notes-textarea auto-expand" rows="3" readonly>' + decodedNotes + '</textarea></div>';
                        strBody += '</div>';
                        strBody += '</div>';
                        $divPanel.append($divPanelHead);
                        $divPanelBody.append(strBody);
                        $divPanel.append($divPanelBody);
                        $("#" + DivId).append($divPanel)
                    }
                });
            }
            else {
                var html = '<div class="NoDataFound">No Data Found.</div>'
                $("#tblSurgerydiv").append(html);
            }
        }

        function autoResizeTextareas() {
            $(".auto-expand").each(function () {
                this.style.height = 'auto';
                this.style.height = Math.max(this.scrollHeight, 100) + 'px';
            });
        }
    </script>

    <%-- Chemo --%>
    <script type="text/javascript">
        function GetMedicationHistory() {
            var mrno = $.session.get('PatMRNO');
            $("#tblChemodiv").empty();
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: 'GetchemoHistory',
                datatype: "json",
                data: { strMrNo: mrno },
                success: function (result) {
                    BindChemoData(result);
                },
                complete: function () { HoldOn.close(); },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                    HoldOn.close();
                }
            });
        }

        function BindChemoData(dataList) {
            $("#tblChemodiv").empty();
            if (dataList.data.length > 0) {
                var DateList = FilterDateWise("C", dataList.data);
                $.grep(DateList, function (a) {
                    var AllData = JSON.parse(JSON.stringify(dataList));
                    var ChemoRec = FilterDateWiseData("C", a, AllData);
                    var DateId = IdForGroupDiv(a);
                    var DivId = "C" + "_" + DateId;
                    var LabelShow = ShowDateConvert(formatDate(a));
                    AddGroupDiv(DivId, "C", LabelShow, "tblChemodiv");
                    var result = ChemoRec.data;
                    for (var i = 0; i < ChemoRec.data.length; i++) {
                        var $divPanel = $('<div>', { style: '', class: 'panel' });
                        var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
                        var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });
                        var resultTbl = (Array.isArray(dataList.data1) && dataList.data1.length > 0) ? dataList.data1 : [];
                        var ChemoPlanNo = ChemoRec.data[i].PLANID;
                        var TotalCycle = "";
                        if (Array.isArray(result) && result.length > 0) {
                            var totalCycleObj = result.find(function (x) {
                                return x.TOTALCYCLE && x.TOTALCYCLE.trim() !== "";
                            });
                            TotalCycle = totalCycleObj ? totalCycleObj.TOTALCYCLE : "";
                            CurrentCycle = result.filter(function (x) { return x.CYCLENO && x.CYCLENO.trim() !== ""; }).length;
                            PendingCycle = TotalCycle - CurrentCycle;
                        }
                        var strTable = "<table style='width:100%'>" +
                            "<tr>" +
                            "<td style='width: 50%;text-align: left;padding-bottom: 10px;'><span style='color:#b9ffb1;font-size:1.2em;width: 20px;display:inline-block'><i class='fa fa-check'></i></span>Chemo Plan No : " + ChemoPlanNo + "</td>" +
                            "<td class='ExColicon' style='text-align: right;'>" + (ChemoRec.data[i].DOCTNAME.toString() == "" ? "" : ("Dr." + ChemoRec.data[i].DOCTNAME.toString() + (ChemoRec.data[i].DOCTSP.toString() == "" ? "" : " (" + ChemoRec.data[i].DOCTSP.toString() + ")"))) + "</td>" +
                            "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td class='ExColicon' style='width: 50%;text-align: left;'>Total Cycle No : " + TotalCycle + "</td>" +
                            "<td class='ExColicon' style='text-align: right;'></td>" +
                            "</tr></table>";
                        $divPanelHead.append(strTable);
                        var html = "";
                        var result = dataList.data;
                        var resultTbl = (Array.isArray(dataList.data1) && dataList.data1.length > 0) ? dataList.data1 : [];
                        if (Array.isArray(result) && result.length > 0) {
                            $.each(result, function (i, item) {
                                var PTableId = "";
                                var PContentTblId = "";
                                var FilterData = resultTbl.filter(function (A) {
                                    return A.PLANID == item.PLANID && A.CYCLENO == item.CYCLENO;
                                });
                                var DisplayProtocolTxt = "block";
                                var DisplayProtocolTbl = "none";
                                if (FilterData.length > 0) {
                                    DisplayProtocolTxt = "none";
                                    DisplayProtocolTbl = "block";
                                    PTableId = "HistoryChemo_Tbl_" + i;
                                    PContentTblId = "HistoryChemo_Cont_" + i;
                                }
                                html += '<div class="chemo-card-body" style="background:#fff;padding:10px 15px;font-size:14px;">';
                                if (item.CYCLENO && item.CYCLENO.trim() !== "") {
                                    html +=
                                        '<div class="surgery-SurgeryName-info-box">' +
                                        'Cycle: ' + item.CYCLENO.trim() +
                                        ' - Day: ' + item.DAY +
                                        ' &nbsp;&nbsp; Start Date: ' + formatDate(item.STARTDATE) +
                                        ' &nbsp;&nbsp; End Date: ' + formatDate(item.ENDDATE) +
                                        '</div>' +
                                        '<div style="margin-bottom:10px;"><b>Chemotherapy Name:</b> ' + item.NAME + '</div>' +
                                        '<div><b>Protocol:</b><br>' +
                                        '<div style="border:1px solid #ccc;padding:10px;background-color:#f9f9f9;font-size:13px;' +
                                        'line-height:1.6;white-space:pre-wrap;display:' + DisplayProtocolTxt + ';">' +
                                        item.PROTOCOL +
                                        '</div>' +
                                        '<div id="' + PContentTblId + '" style="overflow-x:auto;padding:0;display:' + DisplayProtocolTbl + ';">' +
                                        '<table id="' + PTableId + '" class="table table-bordered" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                                        '</div>' +
                                        '</div>';
                                } else {
                                    html +=
                                        '<div><b>Modification During Treatment:</b><br>' +
                                        '<div style="border:1px solid #ccc;padding:10px;background-color:#f9f9f9;font-size:13px;line-height:1.6;white-space:pre-wrap;">' +
                                        item.MODIFYMEDS +
                                        '</div>' +
                                        '</div>';
                                }
                                html += '</div></div>';
                                if (PTableId !== "") {
                                    setTimeout(function () {
                                        HistShowPlanCompleteLst(PTableId, PContentTblId);
                                        $('#' + PTableId).jqGrid('setGridParam', { data: FilterData }).trigger("reloadGrid");
                                    }, 50);
                                }
                            });
                        } else {
                            html = '<div class="NoDataFound">No Data Found.</div>';
                        }
                        $divPanel.append($divPanelHead);
                        $divPanelBody.append(html);
                        $divPanel.append($divPanelBody);
                        $("#" + DivId).append($divPanel)
                    }
                });
            }
            else {
                var html = '<div class="NoDataFound">No Data Found.</div>'
                $("#tblChemodiv").append(html);
            }
        }

        function HistShowPlanCompleteLst(GridId, ContentId) {
            $("#" + GridId).jqGrid("GridUnload");
            jQuery("#" + GridId).jqGrid({
                datatype: 'local',
                data: [],
                colModel: [
                    { label: 'Medicine Type', name: 'MEDTYPE', width: 120, editable: false, hidden: true },
                    { label: 'Apply To Day', name: 'APLYTODAY', width: 100, align: "center" },
                    { label: 'Med. Set No.', name: 'MEDSETNO', width: 100, editable: false, hidden: true },
                    { label: 'Generic Code', name: 'GENERICID', width: 100, hidden: true },
                    { label: 'Drug Form', name: 'DRUGFORM', width: 120, editable: false },
                    { label: 'Generic Name', name: 'GENERICNM', width: 150, editable: false },
                    { label: 'Dose', name: 'DOSE', width: 120, editable: false },
                    { label: 'Dose Unit', name: 'DOSEUNIT', width: 80, editable: false },
                    { label: 'Calculate On', name: 'CALCULATEON', width: 120, editable: false },
                    { label: 'Route', name: 'ROUTECD', width: 120, editable: false },
                    { label: 'Frequency', name: 'FREQUENCY', width: 120, editable: false },
                    { label: 'Diluent Generic Code', name: 'DILNTGENCD', width: 140, editable: false, hidden: true },
                    { label: 'Diluent', name: 'DILUENT', width: 120, editable: false },
                    { label: 'Diluent Volume', name: 'VOLDILTN', width: 150, editable: false },
                    { label: 'Duration', name: 'DURATION', width: 140, editable: false },
                    { label: 'Omit', name: "OMITDRUG", index: "OMITDRUG", width: 35, align: "center", editable: false, sortable: false, edittype: 'checkbox', editoptions: { value: "Y:N" }, formatter: "checkbox", formatoptions: { disabled: true } },
                    { label: 'Admission Seq. No.', name: 'ADMINSEQNO', width: 180, editable: false },
                    { label: 'Remarks', name: 'REMARKS', width: 200, editable: false },
                    { label: 'Original Dose', name: 'ORIGINALDOSE', width: 120, editable: false },
                    { label: 'Cycle No', name: 'CYCLENO', width: 120, editable: false },
                ],
                sortname: 'APLYTODAY',
                sortorder: 'asc',
                shrinkToFit: false,
                forceFit: false,
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadonce: true,
                rownumbers: true,
                rowNum: 99999999,
                hidegrid: false,
                height: 400,
                ignoreCase: true,
                scrollerbar: true,
                loadtext: 'Loading...',
                gridComplete: function () {
                    Merger(GridId, 'APLYTODAY');
                },
                loadComplete: function () {
                }
            }).trigger("reloadGrid");
            var newWidth = $("#" + ContentId).width();
            $("#" + GridId).jqGrid("setGridWidth", newWidth - 9, false);
            $("#" + GridId).jqGrid("setGridHeight", $("#" + ContentId).height() - 225, true);
            $(window).on("resize", function () {
                var newWidth = $("#" + ContentId).width();
                $("#" + GridId).jqGrid("setGridWidth", newWidth - 9, false);
            });
        }

        function Merger(gridName, CellName) {
            var mya = $("#" + gridName).getDataIDs();
            var length = mya.length;
            var currentValue = null;
            var rowspanStartRowId = null;
            var rowspanCount = 1;
            for (var i = 0; i < length; i++) {
                var rowId = mya[i];
                var rowData = $("#" + gridName).jqGrid('getRowData', rowId);
                var cellValue = rowData[CellName];
                if (cellValue === currentValue) {
                    rowspanCount++;
                    $("#" + gridName + " tr#" + rowId + " td[aria-describedby='" + gridName + "_" + CellName + "']").hide();
                } else {
                    if (rowspanCount > 1 && rowspanStartRowId !== null) {
                        $("#" + gridName + " tr#" + rowspanStartRowId + " td[aria-describedby='" + gridName + "_" + CellName + "']")
                            .attr("rowspan", rowspanCount)
                            .css("vertical-align", "middle");
                    }
                    currentValue = cellValue;
                    rowspanStartRowId = rowId;
                    rowspanCount = 1;
                }
            }
            if (rowspanCount > 1 && rowspanStartRowId !== null) {
                $("#" + gridName + " tr#" + rowspanStartRowId + " td[aria-describedby='" + gridName + "_" + CellName + "']")
                    .attr("rowspan", rowspanCount)
                    .css("vertical-align", "middle");
            }
        }

        function formatDate(yyyymmdd) {
            if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd;
            var year = yyyymmdd.substring(0, 4);
            var month = yyyymmdd.substring(4, 6);
            var day = yyyymmdd.substring(6, 8);
            return day + "/" + month + "/" + year;
        }

    </script>

    <%-- Radiation --%>
    <script type="text/javascript">
        function GetRadiationHistory() {
            $("#tblRadiationdiv").empty();
            var html = '<div class="NoDataFound">No Data Found.</div>'
            $("#tblRadiationdiv").append(html);
            var DataToSend = {
                Mrno: $.session.get('PatMRNO')
            }
            $.ajax({
                url: '../DoctorDesk/GetFractionsStatus',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    if (data.length > 0) {
                        if (data[0] != null) {
                            BindRadiationHistory(data);
                        }
                    }
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function BindRadiationHistory(Lst) {
            $("#tblRadiationdiv").empty()
            var DateList = FilterDateWise("R", Lst);
            $.grep(DateList, function (a) {
                var AllData = JSON.parse(JSON.stringify(Lst));
                var RadtRec = FilterDateWiseData("R", a, AllData);
                var DateId = IdForGroupDiv(a);
                var DivId = "R" + "_" + DateId;
                var LabelShow = ShowDateConvert(a);
                AddGroupDiv(DivId, "R", LabelShow, "tblRadiationdiv");
                for (var i = 0; i < RadtRec.length; i++) {
                    var $divPanel = $('<div>', { style: '', class: 'panel' });
                    var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
                    var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });
                    var strTable = "<table style='width:100%;margin: 0px 15px;'>" +
                        "<tr>" +
                        "<td style='width: 50%;text-align: left;padding-bottom: 10px;'>Radiation</td>" +
                        "<td class='ExColicon' style='text-align: right;'>Dr." + RadtRec[i].CONSULTANT.toString() + "</td>" +
                        "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='ExColicon' style='width: 50%;text-align: left;'>" + RadtRec[i].STATUS + "</td>" +
                        "<td class='ExColicon' style='text-align: right;'>" + (RadtRec[i].ONTIME == "" ? "" : ("Time : " + RadtRec[i].ONTIME)) + "</td>" +
                        "</tr></table>";
                    $divPanelHead.append(strTable);
                    var strTableBody = "<table style='width:100%'>" +
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>RT Plan Number</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].RTPLANNO + "</td>" +
                          "</tr>" +
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>RT Number</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].RTNO + "</td>" +
                          "</tr>" +

                          (RadtRec[i].TREATMENTSITE == "" ? "" :
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Site</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].TREATMENTSITE + "</td>" +
                          "</tr>") +
                          (RadtRec[i].STAGE == "" ? "" :
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Stage</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].STAGE + "</td>" +
                          "</tr>") +
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Treatment</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].TREATMENT + "</td>" +
                          "</tr>" +
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Start Date</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].STARTDATE + "</td>" +
                          "</tr>" +
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>End Date</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].ENDDATE + "</td>" +
                          "</tr>" +
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Pending Fractions</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].PENDINGFR + "</td>" +
                          "</tr>" +
                          "<tr>" +
                          "<td style='text-align: left;padding-bottom: 10px;vertical-align: top;width: 150px;'>Completed Fractions</td><td style='vertical-align: top;font-weight: bolder;'>:</td><td style='text-align: left;padding-bottom: 10px;'>" + RadtRec[i].COMPLETEDFR + "</td>" +
                          "</tr></table>";
                    $divPanel.append($divPanelHead);
                    $divPanelBody.append(strTableBody);
                    $divPanel.append($divPanelBody);
                    $("#" + DivId).append($divPanel)
                }
            });
        }
    </script>

    <%-- Progress Note --%>
    <script type="text/javascript">
        function GetAdmissionLst() {
            $("#tblClinicdiv").empty();
            var html = '<div class="NoDataFound">No Data Found.</div>'
            $("#tblClinicdiv").append(html);
            var DataToSend = {
                Mrno: $.session.get('PatMRNO')
            }
            $.ajax({
                url: '../DoctorDesk/GetAdmissionList',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    if (data.length > 0) {
                        BindAdmissionLst(data);
                    }
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function BindAdmissionLst(Lst) {
            $("#tblClinicdiv").empty();
            var DateList = FilterDateWise("N", Lst);
            $.grep(DateList, function (a) {
                var AllData = JSON.parse(JSON.stringify(Lst));
                var AdmRec = FilterDateWiseData("N", a, AllData);
                var DateId = IdForGroupDiv(a);
                var DivId = "N" + "_" + DateId;
                var LabelShow = ShowDateConvert(a);
                AddGroupDiv(DivId, "N", LabelShow, "tblClinicdiv");
                for (var i = 0; i < AdmRec.length; i++) {
                    $("#" + ContentId).empty();
                    var ContentId = 'N_' + AdmRec[i].IPNO;
                    var HeaderDiv = "<div class='' onclick=\"GetClinicNotes(this,'" + AdmRec[i].IPNO + "','" + AdmRec[i].ADMNDATE + "','" + AdmRec[i].ADMNTIME + "','" + ContentId + "')\">{CONTENT}</div>";
                    var strTable = "<div class='panel-heading divHeads'><table style='width:100%;margin: 0px 15px;'>" +
                        "<tr>" +
                        "<td style='width: 50%;text-align: left;padding-bottom: 10px;'>Progress Note</td>" +
                        "<td class='' style='text-align: right;'>" + (AdmRec[i].CONSDOCT.toString() == "" ? "" : ("Dr." + AdmRec[i].CONSDOCT.toString() + (AdmRec[i].CONSDOCTSPEC == "" ? "" : "(" + AdmRec[i].CONSDOCTSPEC + ")"))) + "</td>" +
                        "<td rowspan='2' class='' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='' style='width: 50%;text-align: left;'>IP Number : " + AdmRec[i].IPNO + "</td>" +
                        "<td class='' style='text-align: right;'>Time : " + /*ConvertTo12Hour*/("N", AdmRec[i].ADMNTIME) + "</td>" +   // Abhishesh || 20260323
                        "</tr></table></div>";
                    var ContentDiv = "<div id=" + ContentId + "></div>";
                    var RplHeaderDiv = HeaderDiv.replace("{CONTENT}", strTable);
                    var FinalDiv = RplHeaderDiv + ContentDiv;
                    $("#" + DivId).append(FinalDiv)
                }
            });
        }

        function GetClinicNotes(elm, Ipno, AdmDate, AdmnTime, Id) {
            var el = $("#" + Id);
            $(elm).find('span.spanCls').toggleClass('fa-caret-down fa-caret-right');
            if ($.trim(el.html()).length > 0) {
                el.empty();
            }
            else {
                $("#" + Id).empty();
                var CDate = new Date();
                var day = String(CDate.getDate()).padStart(2, '0');
                var month = String(CDate.getMonth() + 1).padStart(2, '0'); // Months are 0-based
                var year = CDate.getFullYear();
                var CurDate = $("#txtFromDate").val() == "" ? (day + "/" + month + "/" + year) : $("#txtFromDate").val();

                var now = new Date();
                var hours = String(now.getHours()).padStart(2, '0');
                var minutes = String(now.getMinutes()).padStart(2, '0');
                var seconds = String(now.getSeconds()).padStart(2, '0');
                var strToTime = hours + ":" + minutes + ":" + seconds;


                var DataToSend = {
                    strIPNo: Ipno,
                    AdmorFromDate: AdmDate,
                    CurorToDate: CurDate,
                    Doctor: $("#cmbDoctList").val(),
                    ToTime: strToTime,
                    FromTime: AdmnTime
                }
                $.ajax({
                    url: '../DoctorDesk/GetNotesList',
                    type: 'post',
                    datatype: 'json',
                    data: DataToSend,
                    async: false,
                    success: function (data) {
                        BindClinicNotes(data, Id, Ipno);
                    },
                    complete: function () {
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            }
        }

        function BindClinicNotes(Lst, DivId, Ipno) {
            var PTableId = "ProgressNote_Tbl_" + Ipno;
            var PContentTblId = "ProgressNote_Cont_" + Ipno;
            if (Lst.length > 0) {
                var html =
                    '<div id="' + PContentTblId + '" style="overflow-x:auto;padding:0;">' +
                    '<table id="' + PTableId + '" class="table table-bordered" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                    '</div>'
                $("#" + DivId).append(html)
                setTimeout(function () {
                    HistProgressNotesLst(PTableId, PContentTblId);
                    $('#' + PTableId).jqGrid('setGridParam', { data: Lst }).trigger("reloadGrid");
                }, 50);
            }
            else {
                var html = '<div id="' + PContentTblId + '" class="NoDataFound">No Data Found.</div>'
                $("#" + DivId).append(html);
            }
        }

        function HistProgressNotesLst(GridId, ContentId) {
            $("#" + GridId).jqGrid("GridUnload");
            jQuery("#" + GridId).jqGrid({
                datatype: "local",
                colNames: ["Date", "Time", "Added By", "Progress Notes", "NOTETYPE", "NoteNo"],
                sortname: "NOTEDT",
                sortorder: "desc",
                colModel: [
                    {
                        name: "NOTEDT", index: "NOTEDT", width: 160, align: "center",
                        formatter: function (cellValue) {
                            if (!cellValue) return "";
                            if (cellValue.length === 8) {
                                var year = cellValue.substring(0, 4);
                                var month = cellValue.substring(4, 6);
                                var day = cellValue.substring(6, 8);
                                return day + "/" + month + "/" + year;
                            }
                            return cellValue;
                        }
                    },
                    { name: "NOTETM", index: "NOTETM", width: 80, align: "center" },
                    {
                        name: "USERID", index: "USERID", width: 200, align: "center",
                        cellattr: function (rowId, cellValue, rowObject) {
                            if (rowObject.NOTETYPE === "N") {
                                return 'class="note-n"';
                            }
                            if (rowObject.NOTETYPE === "R") {
                                return 'class="note-r"';
                            }
                            if (rowObject.NOTETYPE === "D") {
                                return 'class="note-d"';
                            }
                            return "";
                        }
                    },
                    {
                        name: "NURSENOTES", index: "NURSENOTES", width: 550, align: "left", maxlength: "1000",
                        formatter: function (cellValue, options, rowObject) {
                            var color = rowObject.INKCOLOR === "R" ? "red" : "black";
                            return '<span style="color:' + color + ';width: 99%;display: inline-block;">' + cellValue + '</span>';
                        }
                    },
                    { name: "NOTETYPE", index: "NOTETYPE", hidden: true },
                    { name: "NoteNo", index: "NoteNo", hidden: true },
                ],
                sortname: 'DATE',
                sortorder: 'asc',
                shrinkToFit: true,
                autowidth: true,
                forceFit: true,
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadonce: true,
                rownumbers: true,
                rowNum: 99999999,
                hidegrid: false,
                height: "auto",
                ignoreCase: true,
                scrollerbar: true,
                loadtext: 'Loading...',
                gridComplete: function () {
                },
                loadComplete: function () {
                    $("#" + GridId).closest(".ui-jqgrid-bdiv").css("overflow-x", "hidden");
                }
            }).trigger("reloadGrid");
            var newWidth = $("#" + ContentId).width();
            $("#" + GridId).jqGrid("setGridWidth", newWidth - 9, false);
            $(window).on("resize", function () {
                var newWidth = $("#" + ContentId).width();
                $("#" + GridId).jqGrid("setGridWidth", newWidth - 9, false);
            });
        }
    </script>

    <%-- Discharge Summary --%>
    <script type="text/javascript">
        function GetDischrgLst() {
            $("#tblDiscSumydiv").empty();
            var html = '<div class="NoDataFound">No Data Found.</div>'
            $("#tblDiscSumydiv").append(html);
            var DataToSend = {
                Mrno: $.session.get('PatMRNO'),
                FromDate: $("#txtFromDate").val(),
                ToDate: $("#txtToDate").val()
            }
            $.ajax({
                url: '../DoctorDesk/GetDischargeList',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    if (data.length > 0) {
                        BindDischrgLst(data);
                    }
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }

        function BindDischrgLst(Lst) {
            $("#tblDiscSumydiv").empty();
            var DateList = FilterDateWise("D", Lst);
            $.grep(DateList, function (a) {
                var AllData = JSON.parse(JSON.stringify(Lst));
                var DisRec = FilterDateWiseData("D", a, AllData);
                var DateId = IdForGroupDiv(a);
                var DivId = "D" + "_" + DateId;
                var LabelShow = ShowDateConvert(a);
                AddGroupDiv(DivId, "D", LabelShow, "tblDiscSumydiv");
                for (var i = 0; i < DisRec.length; i++) {
                    $("#" + ContentId).empty();
                    var ContentId = 'D_' + DisRec[i].DISSUMNO;
                    var HeaderDiv = "<div class='' onclick=\"GetDischrgDtls(this,'" + DisRec[i].DISSUMNO + "','" + ContentId + "','" + DisRec[i].IPNO + "')\">{CONTENT}</div>";
                    var strTable = "<div class='panel-heading divHeads'><table style='width:100%;margin: 0px 15px;'>" +
                        "<tr>" +
                        "<td style='width: 50%;text-align: left;padding-bottom: 10px;'>Discharge Summary</td>" +
                        "<td class='' style='text-align: right;'>" + (DisRec[i].DOCTNAME.toString() == "" ? "" : ("Dr." + DisRec[i].DOCTNAME.toString() + (DisRec[i].DOCTNAMESPC.toString() == "" ? "" : ("(" + DisRec[i].DOCTNAMESPC.toString() + ")")))) + "</td>" +
                        "<td rowspan='2' class='' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='' style='width: 50%;text-align: left;'>IP No. / Discharge Summary Number : " + DisRec[i].IPNO + " / " + DisRec[i].DISSUMNO + " </td>" +
                        "<td class='' style='text-align: right;'>Time : " + /*ConvertTo12Hour*/("N", DisRec[i].CREATEDAT) + "</td>" +  // Abhishesh || 20260323
                        "</tr></table></div>";
                    var ContentDiv = "<div  id=" + ContentId + "></div>";
                    var RplHeaderDiv = HeaderDiv.replace("{CONTENT}", strTable);
                    var FinalDiv = RplHeaderDiv + ContentDiv;
                    $("#" + DivId).append(FinalDiv)
                }
            });
        }

        function GetDischrgDtls(elm, DischrgNo, Id, IPNo) {
            var el = $("#" + Id);
            $(elm).find('span.spanCls').toggleClass('fa-caret-down fa-caret-right');
            if ($.trim(el.html()).length > 0) {
                el.empty();
            }
            else {
                var DataToSend = {
                    DisSummryNo: DischrgNo,
                    Mrno: $.session.get('PatMRNO'),
                    IPNo: IPNo
                }
                $.ajax({
                    url: '../DoctorDesk/GetDischargeDetails',
                    type: 'post',
                    datatype: 'json',
                    data: DataToSend,
                    async: false,
                    success: function (data) {
                        BindDischrgDtls(data, DischrgNo, Id);
                    },
                    complete: function () {
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            }
        }

        function BindDischrgDtls(Lst, DischrgNo, DivId) {
            var DisSumDtls = JSON.parse(Lst);
            if (DisSumDtls.Table != null && DisSumDtls.Table != undefined && DisSumDtls.Table.length > 0) {
                var DiscTable = DisSumDtls.Table;
                //Present Complaints
                var PresentCompHTML = "";
                var strPresentCompFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                    "<tr>" +
                    "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Present Complaints</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td class='FieldOnly'>" + DiscTable[0].FINDINGS + "</td>" +
                    "</tr></table></div>";
                PresentCompHTML = strPresentCompFieldTable;
                $("#" + DivId).append(PresentCompHTML);
                //System Examinations
                var SysExamHTML = "";
                var SysExamDivContId = "DIV_SYSEXAM_" + DischrgNo;
                var SysExamTblContId = "TBL_SYSEXAM_" + DischrgNo;
                var SysExam = [
                    { label: "Vital Exam", name: "Text", index: "Text", width: 100, align: "left" },
                    { label: "Value(Admission) / Value(Discharge)", name: "Values", index: "Values", width: 80, align: "left" },
                ];
                var strSysExamFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                    "<tr>" +
                    "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Vitals & System Examination</td>" +
                    "</tr></table></div>";
                var strSysExamICDTable = "";
                var SysExamDtls = [];
                if (DisSumDtls.GENEXAM != null && DisSumDtls.GENEXAM != undefined && DisSumDtls.GENEXAM.length > 0) {
                    strSysExamTable =
                         '<div class="GrdTableDiv" id="' + SysExamDivContId + '" style="overflow-x:auto;padding:0;">' +
                         '<table id="' + SysExamTblContId + '" class="table table-bordered GrdTable" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                         '</div>';
                    SysExamDtls = DisSumDtls.GENEXAM;
                }
                SysExamHTML = strSysExamFieldTable + strSysExamTable;
                $("#" + DivId).append(SysExamHTML);
                setTimeout(function () {
                    if (ICDDtls.length > 0) {
                        jqTable(SysExamDivContId, SysExamTblContId, SysExam);
                        $('#' + SysExamTblContId).jqGrid('setGridParam', { data: SysExamDtls }).trigger("reloadGrid");
                    }
                }, 50);
                //Diagnosis 
                var DiagnosisHTML = "";
                var DiagnoDivContId = "DIV_ICD_" + DischrgNo;
                var DiagnoTblContId = "TBL_ICD_" + DischrgNo;
                var FinalIcdo = [
                    { label: "ICD Code", name: "ICDCODE", index: "ICDCODE", width: 10, align: "left" },
                    { label: "Name", name: "ICDNAME", index: "ICDNAME", width: 80, align: "left" },
                ];
                var strDiagFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                    "<tr>" +
                    "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Diagnosis</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td class='LeftLabel'>Final Diagnosis</td>" +
                    "<td class='Colon' style='width: 20px;text-align: left;'> : </td>" +
                    "<td class='TextFld' style=''>" + DiscTable[0].FINALDIAGNOSIS + "</td>" +
                    "</tr></table></div>";
                var strDiagICDTable = "";
                var ICDDtls = [];
                if (DisSumDtls.SECONDARY != null && DisSumDtls.SECONDARY != undefined && DisSumDtls.SECONDARY.length > 0) {
                    strDiagICDTable =
                         '<div class="GrdTableDiv" id="' + DiagnoDivContId + '" style="overflow-x:auto;padding:0;">' +
                         '<table id="' + DiagnoTblContId + '" class="table table-bordered GrdTable" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                         '</div>';
                    ICDDtls = DisSumDtls.SECONDARY;
                }
                DiagnosisHTML = strDiagFieldTable + strDiagICDTable;
                $("#" + DivId).append(DiagnosisHTML);
                setTimeout(function () {
                    if (ICDDtls.length > 0) {
                        jqTable(DiagnoDivContId, DiagnoTblContId, FinalIcdo);
                        $('#' + DiagnoTblContId).jqGrid('setGridParam', { data: ICDDtls }).trigger("reloadGrid");
                    }
                }, 50);
                //Reason For Admission
                var ReasonAdmHTML = "";
                var strDiagFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                    "<tr>" +
                    "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Reason For Admission</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td class='FieldOnly'>" + DiscTable[0].ADMNREASON + "</td>" +
                    "</tr></table></div>";
                ReasonAdmHTML = strDiagFieldTable + strDiagICDTable;
                $("#" + DivId).append(ReasonAdmHTML);
                //Past History, Co-Morbidities & Allergies (If Any)
                if (DiscTable[0].PASTHIST.trim() != "") {
                    var PastHistHTML = "";
                    var strPastHistFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Past History, Co-Morbidities & Allergies (If Any)</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].PASTHIST + "</td>" +
                        "</tr></table></div>";
                    PastHistHTML = strPastHistFieldTable;
                    $("#" + DivId).append(PastHistHTML);
                }
                //Family History
                if (DiscTable[0].FAMILYHISTORY.trim() != "") {
                    var FamHistHTML = "";
                    var strFamHistFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Family History</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].FAMILYHISTORY + "</td>" +
                        "</tr></table></div>";
                    FamHistHTML = strFamHistFieldTable;
                    $("#" + DivId).append(FamHistHTML);
                }
                //Personal History
                if (DisSumDtls.NEWPERSONALHIST != null && DisSumDtls.NEWPERSONALHIST != undefined && DisSumDtls.NEWPERSONALHIST.length > 0) {
                    var PrsHistHTML = "";
                    var PrsHistDivContId = "DIV_PrsHist_" + DischrgNo;
                    var PrsHistTblContId = "TBL_PrsHist_" + DischrgNo;
                    var PrsHist = [
                        { label: "Habit", name: "HABIT", index: "HABIT", width: 100, align: "left" },
                        { label: "Duration", name: "DURATION", index: "DURATION", width: 100, align: "center" },
                    ];
                    var strPrsHistFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Personal History</td>" +
                        "</tr></table></div>";
                    var strPrsHistTable = "";
                    var PrsHistDtls = [];
                    strPrsHistTable =
                         '<div class="GrdTableDiv" id="' + PrsHistDivContId + '" style="overflow-x:auto;padding:0;">' +
                         '<table id="' + PrsHistTblContId + '" class="table table-bordered GrdTable" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                         '</div>';
                    PrsHistDtls = DisSumDtls.NEWPERSONALHIST;
                    PrsHistHTML = strPrsHistFieldTable + strPrsHistTable;
                    $("#" + DivId).append(PrsHistHTML);
                    setTimeout(function () {
                        if (PrsHistDtls.length > 0) {
                            jqTable(PrsHistDivContId, PrsHistTblContId, PrsHist);
                            $('#' + PrsHistTblContId).jqGrid('setGridParam', { data: PrsHistDtls }).trigger("reloadGrid");
                        }
                    }, 50);
                }
                //Surgery Notes
                if (DiscTable[0].SURGNOTES.trim() != "") {
                    var SurgNoteHTML = "";
                    var strSurgNoteFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Surgery Notes</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].SURGNOTES + "</td>" +
                        "</tr></table></div>";
                    SurgNoteHTML = strSurgNoteFieldTable;
                    $("#" + DivId).append(SurgNoteHTML);
                }
                //Hospital Course
                if (DiscTable[0].HOSPCOURSE.trim() != "") {
                    var HospCourseHTML = "";
                    var strHospCourseFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Hospital Course</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].HOSPCOURSE + "</td>" +
                        "</tr></table></div>";
                    HospCourseHTML = strHospCourseFieldTable;
                    $("#" + DivId).append(HospCourseHTML);
                }
                //Tumor Board Decision
                if (DiscTable[0].TBDECISION.trim() != "") {
                    var TumBrdDisHTML = "";
                    var strTumBrdDisFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Tumor Board Decision</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].TBDECISION + "</td>" +
                        "</tr></table></div>";
                    TumBrdDisHTML = strTumBrdDisFieldTable;
                    $("#" + DivId).append(TumBrdDisHTML);
                }
                //Relevant Investigation - PENDING

                //Relevant Investigations & Results
                if (DiscTable[0].RELINVSTGTNS.trim() != "") {
                    var RelInvstHTML = "";
                    var strRelInvstFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Relevant Investigations & Results</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].RELINVSTGTNS + "</td>" +
                        "</tr></table></div>";
                    RelInvstHTML = strRelInvstFieldTable;
                    $("#" + DivId).append(RelInvstHTML);
                }
                //Treatment Given
                if (DisSumDtls.Table6 != null && DisSumDtls.Table6 != undefined && DisSumDtls.Table6.length > 0) {
                    var TreatmntHTML = "";
                    var DrugDivContId = "DIV_TRMTDRUG_" + DischrgNo;
                    var DrugTblContId = "TBL_TRMTDRUG_" + DischrgNo;
                    var Drugs = [
                        { label: "Drug Name", name: "DRUGNAME", index: "DRUGNAME", width: 100, align: "left" },
                        { label: "Dosage", name: "DOSE", index: "Values", width: 80, align: "center" },
                        { label: "Route", name: "ROUTE", index: "Values", width: 80, align: "center" },
                        { label: "Freq", name: "FREQ", index: "Values", width: 80, align: "center" },
                    ];
                    var strDrugFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Treatement During Hospitalization</td>" +
                        "</tr></table></div>";
                    var strTreatmntTable = "";
                    var TreatmntDtls = [];
                    strTreatmntTable =
                         '<div class="GrdTableDiv" id="' + DrugDivContId + '" style="overflow-x:auto;padding:0;">' +
                         '<table id="' + DrugTblContId + '" class="table table-bordered GrdTable" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                         '</div>';
                    TreatmntDtls = DisSumDtls.Table6;
                    TreatmntHTML = strDrugFieldTable + strTreatmntTable;
                    $("#" + DivId).append(TreatmntHTML);
                    setTimeout(function () {
                        if (TreatmntDtls.length > 0) {
                            jqTable(DrugDivContId, DrugTblContId, Drugs);
                            $('#' + DrugTblContId).jqGrid('setGridParam', { data: TreatmntDtls }).trigger("reloadGrid");
                        }
                    }, 50);
                }
                //Obtain Urgent Care
                if (DisSumDtls.EMGR != null && DisSumDtls.EMGR != undefined && DisSumDtls.EMGR.length > 0) {
                    var UrgCareHTML = "";
                    var UrgCareDivContId = "DIV_URGCARE_" + DischrgNo;
                    var UrgCareTblContId = "TBL_URGCARE_" + DischrgNo;
                    var UrgCare = [
                        { label: "Name", name: "TEXT", index: "TEXT", width: 100, align: "left" },
                        { label: "Remark", name: "REMARKS", index: "REMARKS", width: 100, align: "center" },
                    ];
                    var strUrgCareFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>When to Obtain Urgent Care</td>" +
                        "</tr></table></div>";
                    var strUrgCareTable = "";
                    var UrgCareDtls = [];
                    strUrgCareTable =
                         '<div class="GrdTableDiv" id="' + UrgCareDivContId + '" style="overflow-x:auto;padding:0;">' +
                         '<table id="' + UrgCareTblContId + '" class="table table-bordered GrdTable" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                         '</div>';
                    UrgCareDtls = DisSumDtls.EMGR;
                    UrgCareHTML = strUrgCareFieldTable + strUrgCareTable;
                    $("#" + DivId).append(UrgCareHTML);
                    setTimeout(function () {
                        if (UrgCareDtls.length > 0) {
                            jqTable(UrgCareDivContId, UrgCareTblContId, UrgCare);
                            $('#' + UrgCareTblContId).jqGrid('setGridParam', { data: UrgCareDtls }).trigger("reloadGrid");
                        }
                    }, 50);
                }
                //Patient Condition at the time of discharge
                if (DiscTable[0].PATCONDATDISCH.trim() != "") {
                    var PatCondDisHTML = "";
                    var strPatCondDisFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Patient Condition at the time of discharge</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].PATCONDATDISCH + "</td>" +
                        "</tr></table></div>";
                    PatCondDisHTML = strPatCondDisFieldTable;
                    $("#" + DivId).append(PatCondDisHTML);
                }
                //Preventive Care Guidelines
                if (DisSumDtls.NEWPREVENTIVE != null && DisSumDtls.NEWPREVENTIVE != undefined && DisSumDtls.NEWPREVENTIVE.length > 0) {
                    var PrevGuideHTML = "";
                    var PrevGuideDivContId = "DIV_PrevGuide_" + DischrgNo;
                    var PrevGuideTblContId = "TBL_PrevGuide_" + DischrgNo;
                    var PrevGuide = [
                        { label: "Name", name: "GUIDELNTEXT", index: "GUIDELNTEXT", width: 100, align: "left" }
                    ];
                    var strPrevGuideFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Preventive Care Guidelines</td>" +
                        "</tr></table></div>";
                    var strPrevGuideTable = "";
                    var PrevGuideDtls = [];
                    strPrevGuideTable =
                         '<div class="GrdTableDiv" id="' + PrevGuideDivContId + '" style="overflow-x:auto;padding:0;">' +
                         '<table id="' + PrevGuideTblContId + '" class="table table-bordered GrdTable" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                         '</div>';
                    PrevGuideDtls = DisSumDtls.NEWPREVENTIVE;
                    PrevGuideHTML = strPrevGuideFieldTable + strPrevGuideTable;
                    $("#" + DivId).append(PrevGuideHTML);
                    setTimeout(function () {
                        if (PrsHistDtls.length > 0) {
                            jqTable(PrevGuideDivContId, PrevGuideTblContId, PrevGuide);
                            $('#' + PrevGuideTblContId).jqGrid('setGridParam', { data: PrevGuideDtls }).trigger("reloadGrid");
                        }
                    }, 50);
                }
                //Medication on Discharge
                if (DisSumDtls.DRUG != null && DisSumDtls.DRUG != undefined && DisSumDtls.DRUG.length > 0) {
                    var MedDischHTML = "";
                    var MedDischDivContId = "DIV_MedDisch_" + DischrgNo;
                    var MedDischTblContId = "TBL_MedDisch_" + DischrgNo;
                    var MedDisch = [
                        { label: "Drug Name", name: "DRUGNAME", index: "DRUGNAME", width: 100, align: "left" },
                        { label: "Generic Name", name: "GENERICNM", index: "GENERICNM", width: 100, align: "center" },
                        { label: "Dosage", name: "DOSAGE", index: "DOSAGE", width: 70, align: "center" },
                        { label: "Frequency", name: "INTAKETIME", index: "INTAKETIME", width: 70, align: "center" },
                        { label: "No of Days", name: "NOOFDAYS", index: "NOOFDAYS", width: 70, align: "center" },
                        { label: "Remarks", name: "REMARKS", index: "REMARKS", width: 100, align: "center" },
                    ];
                    var strMedDischFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Medication on Discharge</td>" +
                        "</tr></table></div>";
                    var strMedDischTable = "";
                    var MedDischDtls = [];
                    strMedDischTable =
                         '<div class="GrdTableDiv" id="' + MedDischDivContId + '" style="overflow-x:auto;padding:0;">' +
                         '<table id="' + MedDischTblContId + '" class="table table-bordered GrdTable" style="width:auto;min-width:fit-content;white-space:nowrap;"></table>' +
                         '</div>';
                    MedDischDtls = DisSumDtls.DRUG;
                    MedDischHTML = strMedDischFieldTable + strMedDischTable;
                    $("#" + DivId).append(MedDischHTML);
                    setTimeout(function () {
                        if (PrsHistDtls.length > 0) {
                            jqTable(MedDischDivContId, MedDischTblContId, MedDisch);
                            $('#' + MedDischTblContId).jqGrid('setGridParam', { data: MedDischDtls }).trigger("reloadGrid");
                        }
                    }, 50);
                }
                //Advice on Discharge
                if (DiscTable[0].DRUGADVISE.trim() != "") {
                    var AdvDiscHTML = "";
                    var strAdvDiscFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Advice on Discharge</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].DRUGADVISE + "</td>" +
                        "</tr></table></div>";
                    AdvDiscHTML = strAdvDiscFieldTable;
                    $("#" + DivId).append(AdvDiscHTML);
                }
                //Followup
                if (DiscTable[0].FOLLOWUP.trim() != "") {
                    var FollowupHTML = "";
                    var strFollowupFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Followup</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].FOLLOWUP + "</td>" +
                        "</tr></table></div>";
                    FollowupHTML = strFollowupFieldTable;
                    $("#" + DivId).append(FollowupHTML);
                }
                //Hemodynamic Condition
                if (DiscTable[0].HEMOCONDITION.trim() != "") {
                    var HemoDynHTML = "";
                    var strHemoDynFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Hemodynamic Condition</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].HEMOCONDITION + "</td>" +
                        "</tr></table></div>";
                    HemoDynHTML = strHemoDynFieldTable;
                    $("#" + DivId).append(HemoDynHTML);
                }
                //Ambulatory
                if (DiscTable[0].AMBULATORY.trim() != "") {
                    var AmbuHTML = "";
                    var strAmbuFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Ambulatory</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].AMBULATORY + "</td>" +
                        "</tr></table></div>";
                    AmbuHTML = strAmbuFieldTable;
                    $("#" + DivId).append(AmbuHTML);
                }
                //Diet
                if (DiscTable[0].DIET.trim() != "") {
                    var DIETHTML = "";
                    var strDIETFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Diet</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].DIET + "</td>" +
                        "</tr></table></div>";
                    DIETHTML = strDIETFieldTable;
                    $("#" + DivId).append(DIETHTML);
                }
                //Physical activity
                if (DiscTable[0].PHYSICALACT.trim() != "") {
                    var PhyActHTML = "";
                    var strPhyActFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                        "<tr>" +
                        "<td class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Physical activity</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='FieldOnly'>" + DiscTable[0].PHYSICALACT + "</td>" +
                        "</tr></table></div>";
                    PhyActHTML = strPhyActFieldTable;
                    $("#" + DivId).append(PhyActHTML);
                }
            }
        }

        function jqTable(ContentId, GridId, ColLst) {
            var GID = GridId;
            $("#" + GridId).jqGrid("GridUnload");
            jQuery("#" + GridId).jqGrid({
                datatype: "local",
                colModel: ColLst,
                shrinkToFit: true,
                autowidth: true,
                forceFit: true,
                cellEdit: false,
                cellsubmit: 'clientArray',
                loadonce: true,
                rownumbers: true,
                rowNum: 99999999,
                hidegrid: false,
                height: "auto",
                ignoreCase: true,
                scrollerbar: true,
                loadtext: 'Loading...',
                scroll: false,
                gridComplete: function () {
                },
                loadComplete: function () {
                    $("#" + GridId).closest(".ui-jqgrid-bdiv").css("overflow-x", "hidden");
                }
            }).trigger("reloadGrid");
            var newWidth = $("#" + ContentId).width();
            $("#" + GridId).jqGrid("setGridWidth", newWidth - 9, true);
            $(window).on("resize", function () {
                var newWidth = $("#" + ContentId).width();
                $("#" + GridId).jqGrid("setGridWidth", newWidth - 9, true);
            });
        }

        function SelectAllFilter() {
            if ($("#chkSelectAll").prop("checked") == true) {
                $("#chkCheifComp").prop("checked", false);
                $("#chkGeneralExam").prop("checked", false);
                $("#chkHistory").prop("checked", false);
                $("#chkDiagnosis").prop("checked", false);
                $("#chkOnExam").prop("checked", false);
                $("#chkRx").prop("checked", false);
                $("#chkAdvInvst").prop("checked", false);
                $("#chkRAdvice").prop("checked", false);
            }
            else {
                $("#chkCheifComp").prop("checked", true);
                $("#chkGeneralExam").prop("checked", true);
                $("#chkHistory").prop("checked", true);
                $("#chkDiagnosis").prop("checked", true);
                $("#chkOnExam").prop("checked", true);
                $("#chkRx").prop("checked", true);
                $("#chkAdvInvst").prop("checked", true);
                $("#chkRAdvice").prop("checked", true);
            }
            $("#chkCheifComp").trigger('click');
            $("#chkGeneralExam").trigger('click');
            $("#chkHistory").trigger('click');
            $("#chkDiagnosis").trigger('click');
            $("#chkOnExam").trigger('click');
            $("#chkRx").trigger('click');
            $("#chkAdvInvst").trigger('click');
            $("#chkRAdvice").trigger('click');
        }
    </script>

</asp:Content>
