<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<style>
    .FilterDiv1 {
        background-color: #efefef;
    }
    .panel{
        margin-bottom:5px;
    }

    .FilterDiv2 {
        padding-top: 10px;
        background-color: #efefef;
    }

    .FilterDiv3 {
        background-color: #efefef;
    }

    .MainsDiv {
        flex-grow: 1;
        overflow-y: auto;
        padding: 10px;
        margin-bottom: 40px;
    }

    .FilterSubDiv2 {
        flex-wrap: wrap;
    }

    .RightMenuSearchIcon {
        font-size: 30px;
        border: 1px solid;
        padding: 5px;
        border-radius: 10px;
        color: white;
        background: #6d9cf5;
        transition: background-color 0.2s;
        cursor: pointer;
    }

    .RightMenuSearchDiv {
        display: flex;
        align-items: center;
        justify-content: flex-end;
    }

    .ShowAllDiv {
        width: 100%;
        padding-bottom: 5px;
        border-bottom: 1px solid #e9e9e9;
        margin-bottom: 5px;
        border-radius: 5px;
    }

    .FilterOtherOptions {
        display: flex;
        gap: 5px 5px;
        flex-wrap: wrap;
        padding-bottom: 5px;
    }

    .FCheckBoxDiv {
        display: flex;
        gap: 10px;
        align-items: center;
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
        padding: 15px;
        background-color: white;
    }

    .panel-body {
        width: auto !important;
        height: auto !important;
        -webkit-box-shadow: 0px 1px 2px 0px #878888;
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

    .AdvInvstDispYN {/* priyanka 15/04/2026*/
        display: block;
    }

    .AdviceDispYN {/* priyanka 15/04/2026*/
        display: block;
    }

    .OnClinicalNtDispYN {/* priyanka 15/04/2026*/
    display: block;
}

    .InstructDispYN {
    display: block;
}

    .ComplStatus {
        width: 50px;
    }

    .PatClinicPrescPrint {
        font-size: 20px;
        margin-left: 20px;
        border: 1px solid;
        border-radius: 5px;
        padding: 5px;
        cursor : pointer;
    }
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
    .as {
    }
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
    .as {
    }
</style>

<%-- Radiation Style --%>
<style>
    .as {
    }
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


<script type="text/javascript">
    <%-- Global Decalaration --%>
    var idOfDMY = "";
    var exam = "";
    var result = "";
    var DoctorList = '<%:Html.Raw(ViewBag.DoctorList)%>';
    <%-- Load Form --%>
    $(document).ready(function (e) {
        //debugger;
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
        debugger;
        $("#AllCheck").prop("checked", true);
        debugger;
        $('#FilterOPD input[name="AllCheck"]').prop('checked', true);
        BindDoctorList();
        var doctCode = sessionStorage.getItem("DoctCode");
        var doctName = sessionStorage.getItem("DoctName");
        ToEmailID = sessionStorage.getItem("PatEmail");
        if (ToEmailID != "" && ToEmailID != undefined) {
            $("#P_Email").html(ToEmailID);
        }
        else {
            $("#P_Email").html("Email ID is not registered.");
        }
        $(document).on('click', '.copyHisCls', function (e) {
            var id = $(this)[0].id;
            var YesFunc = " GetCopy('" + id + "')";
            openPopup("Confirmation", "Are you sure to copy/overwrite present prescription?", YesFunc, PopupNoFunc);
        });
        $(document).on('click', '.sendEmail', function (e) {
            var completedYN = $(this).data('completedyn');
            var id = $(this).attr('id');
            if (AllowMailBeforePrescriptionCompl != 'Y') {
                if (completedYN === "N") {
                    ToastMsg("The prescription is not complete. You cannot send the mail before completion.", "info");
                } else {
                    SendMailAction(id);
                }
            }
            else {
                SendMailAction(id);
            }
        });
        //Added By Rajan - For Twice It Calling (20260413)
        $(document).off('click', '.ExColicon').on('click', '.ExColicon', function (e) {
            e.stopPropagation();
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
        //$(document).on('click', '.PatClinicPrescPrint', function (e) {
        //    e.stopPropagation();
        //    var PrintTranNo = e.target.id;
        //    PrescriptionPrintForClinicHist(PrintTranNo.split('_')[1]);
        //});
        $(document)
            .off('click.PatClinicPrescPrint', '.PatClinicPrescPrint')
            .on('click.PatClinicPrescPrint', '.PatClinicPrescPrint', function (e) {
                e.preventDefault();
                e.stopImmediatePropagation();
                var $btn = $(this);
                if ($btn.data('printing')) {
                    return false;
                }
                $btn.data('printing', true);
                var PrintTranNo = this.id;
                PrescriptionPrintForClinicHist(PrintTranNo.split('_')[1]);
                $btn.data('printing', false);
                return false;
            });
    });

    function PrescriptionPrintForClinicHist(PrintTranNo) {
        debugger;
        startLoading("Loading...");
        var mrNo = GetSessionMRNO(); //sessionStorage.getItem('PatMRNO');
        var vartranno = PrintTranNo;
        var datatosend = {
            tranno: vartranno,
            language: "" + "NAME",
            type: 'L',
            MrNo: mrNo,
        }
        var Html = "", HtmlTopData = "";
        $.ajax({
            type: "Post",
            url: "../DoctorDesk/GetDoctorDeskData",
            data: datatosend,
            async: true,
            success: function (response) {
                startLoading("Loading...");
                infotomail = "", infotomail2 = "";
                GridData = response;
                if (GridData.jsonDoctorDetails.length > 0) {
                    /*GetDoctSignature1(GridData.jsonDoctorDetails[0].DOCTCODE, vartranno, mrNo);*/
                    GetDoctSignature(GridData.jsonDoctorDetails[0].DOCTCODE);
                }


                if (PrecriptionPrintTemp && PrecriptionPrintTemp.trim() === "1") {
                    Html = PrintData1("Y");
                } else {
                    Html = PrintData(vartranno, mrNo);
                }
                
                HtmlTopData = PrintPatInfo1(PrintTranNo);
                infotomail = Html;
                infotomail2 = HtmlTopData;
                openWin(Html, HtmlTopData);
                GridData = "";
                stopLoading();

            },
            error: function (jqXHR, textStatus, errorThrown) {
                ToastMsg("Error : " + textStatus + ".", "error");
                stopLoading();
            }
        });
    }


    function openWin(HTML, HtmlTopData) {
        Html = HTML;
        HtmlTop = HtmlTopData;
        PrintPresc();
    }


    function PrintPresc() {
        var Mrno = GetSessionMRNO();//sessionStorage.getItem('PatMRNO');
        var datatosend = {
            printdata: encodeURIComponent(Html),
            TranNo: sessionStorage.getItem('PatTRANNO'),
            Mrno: Mrno,
            printdataTop: encodeURIComponent(HtmlTop),
            printedBy: gDoctId //priyanka 21/04/2026
        };
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/PrintPrescription",
            async: false,
            data: datatosend,
            dataType: "json",
            success: function (response) {
                if (response == "Success") {
                    var url = '../DoctorDesk/DisplayPrintTemplate?FormName=' + sessionStorage.getItem('PatName').toString();
                    var win = window.open(url, '', 'width=1024, height=700');
                    win.document.close();
                    win.focus();
                }
            },
            error: function () {
            }
        });
    }
        <%-- Common Script --%>
    function SelectAllCheck() {
        if ($("#AllCheck").prop("checked") == true) {
            $('#FilterOPD input[name="AllCheck"]').prop('checked', false).trigger('click');
        }
        else {
            $('#FilterOPD input[name="AllCheck"]').prop('checked', true).trigger('click');
        }
    }
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
        else if ($("#FilterTumorBoardRbt").prop("checked") == true)
            HistoryDetails("T");
        else
            ToastMsg("Please Select Atleast One Filter.", "warning");
    }

    function HistoryDetails(SType) {
        debugger;
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
            document.getElementById("divTumorInfo").style.display = "none";
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
            document.getElementById("divTumorInfo").style.display = "none";
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
            document.getElementById("divTumorInfo").style.display = "none";
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
            document.getElementById("divTumorInfo").style.display = "none";
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
            document.getElementById("divTumorInfo").style.display = "none";
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
            document.getElementById("divTumorInfo").style.display = "none";
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
            document.getElementById("divTumorInfo").style.display = "none";
            document.getElementById("divDiscSumyInfo").style.display = "block";
            $("#FilterDischSumyRbt").prop("checked", true);
            $('#DivFilterDischSumy').addClass('MainRadioDivSel');
            GetDischrgLst();
        }
        else if (SType === "T") {
            document.getElementById("FilterOPD").style.display = "none";
            document.getElementById("divOPDPrescInfo").style.display = "none";
            document.getElementById("divPACInfo").style.display = "none";
            document.getElementById("divSurgInfo").style.display = "none";
            document.getElementById("divChemoInfo").style.display = "none";
            document.getElementById("divRadiationInfo").style.display = "none";
            document.getElementById("divClinicInfo").style.display = "none";
            document.getElementById("divDiscSumyInfo").style.display = "none";
            document.getElementById("divTumorInfo").style.display = "block";
            $("#FilterTumorBoardRbt").prop("checked", true);
            $('#DivFilterTumorBoard').addClass('MainRadioDivSel');
            GetTumorPatList();
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
        startLoading("Loading");
        var mrno = GetSessionMRNO();
        var tranNo = sessionStorage.getItem("PatTRANNO");
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/SaveCopy',
            datatype: "json",
            data: { PrevTranNo: oldTranno, strMRNO: mrno, strTranNo: tranNo },
            success: function (result) {
                if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                    window.location.href = '../SinglePage/SinglePageOPD';
                    ToastMsg("Copied Successfully", "success");
                }
            },
            complete: function () {
                stopLoading();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading();
            }
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
                if (d != "" && !dateMap[d]) {
                    dateMap[d] = true;
                    uniqueItems.push(LstData[i].SurgeryDate);
                }
            }
            FilterDate = uniqueItems;
        }
        //else if (SType === "C") {
        //    var uniqueItems = [];
        //    var keyMap = {};
        //    for (var i = 0; i < LstData.length; i++) {
        //        var d = LstData[i].TRANDATE;
        //        var p = LstData[i].PLANID;
        //        var key = p;
        //        if (d != "" && !keyMap[key]) {
        //            keyMap[key] = true;
        //            uniqueItems.push(d);
        //        }
        //    }
        //    FilterDate = uniqueItems;
        //}
        else if (SType === "C") {
            var uniqueItems = [];
            var dateMap = {};
            for (var i = 0; i < LstData.length; i++) {
                var d = LstData[i].TRANDATE;
                if (d != "" && !dateMap[d]) {
                    dateMap[d] = true;
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
                if (d != "" && !dateMap[d]) {
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
                if (d != "" &&!dateMap[d]) {
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
                if (d != "" &&!dateMap[d]) {
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
        //else if (SType === "C") {
        //    var FilterData = [];
        //    if (LstData.data !== "") {
        //        var planMap = {};
        //        for (var i = 0; i < LstData.data.length; i++) {
        //            var p = LstData.data[i].PLANID;
        //            if (!planMap[p]) {
        //                planMap[p] = true;
        //                FilterData.push(LstData.data[i]);
        //            }
        //        }
        //    }
        //    LstData.data = FilterData.filter(function (x) { return $("#cmbDoctList").val() == "" || $("#cmbDoctList option:selected").text() == x.DOCTNAME; });
        //}
 else if (SType === "C") {
     var FilterData = [];
     if (LstData.data !== "") {
         var planMap = {};
         for (var i = 0; i < LstData.data.length; i++) {
             if (LstData.data[i].TRANDATE == FDate) {   // ✅ only rows for this date
                 var p = LstData.data[i].PLANID;
                 if (!planMap[p]) {
                     planMap[p] = true;
                     FilterData.push(LstData.data[i]);
                 }
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
    <%-- E-Mail --%>
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
        var YesFunc = "PopupForMailYes('" + strTranNo + "')";
        $("#popupAlertOverlay").empty();
        var PopupTemp = '<div class="popup-box">' +
          '<h2 class="popup-title">Email</h2>' +
          '<div class="form-group"><label style="font-size:12px">Enter Email ID</label><br>' +
        '<textarea  type="varchar" id="txtemail"  placeholder="Enter email" autofocus="autofocus" rows="2" class="setUp form-control TextAreaBorder" required />' +
        '</div>' +
          '<div class="popup-actions">' +
          '<button class="btn btn-yes" onclick="' + YesFunc + '">Send</button>' +
            '<button class="btn btn-no" onclick="' + PopupNoFunc + '">Close</button>' +
          '</div>' +
        '</div>';
        $("#popupAlertOverlay").append(PopupTemp);
        document.getElementById("popupAlertOverlay").style.display = "flex";
        if (ToEmailID == "" || ToEmailID == null) {
            $('#txtemail').val("");
        }
        else
            $("#txtemail").val(ToEmailID);
    }

    function PopupForMailYes(strTranNo) {
        tomail = $("#txtemail").val();
        if ($("#txtemail").val() == "" || $("#txtemail").val() == null) {
            $('#txtemail').css({ 'border-color': 'Red' });
            $('#txtemail').val("");
            return false;
        } else {
            if (validateEmail(tomail) == false) {
                ToastMsg("Invalid Email ID format", "warning");
                return false;
            }
            else {
                $('#txtemail').css({ 'border-color': '' });
                Callajxmail(tomail, strTranNo);
                closePopup();
            }
        }
    }

    function Callajxmail(tomail, TranNo) {
        startLoading("Loading");
        var infotomail = "";
        var Mrno = GetSessionMRNO();
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
                ToastMsg(textStatus, "error");
                stopLoading();
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
                stopLoading();
                ToastMsg(response, "info");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                stopLoading();
                ToastMsg(textStatus, "error");
            }
        });
    }

    function SendMailAction(strTranNo) {
        var id = strTranNo;
        var YesFunc = "YesFuncSendMailAction('" + id + "')";
        openPopup("Confirmation", "Are you sure , you want to send an prescription over email?", YesFunc, PopupNoFunc);
    };

    function YesFuncSendMailAction(id) {
        var tomail = sessionStorage.getItem("PatEmail");
        if (tomail == "" || tomail == null) {
            PopupForMail(id);
        }
        else {
            Callajxmail(tomail, id)
            closePopup();
        }
    }
    <%-- OPD Prescription --%>
    function GetPatMedicationHistory(Type) {
        debugger;
        var tranNo = sessionStorage.getItem("PatTRANNO");
        var mrno = GetSessionMRNO();
        if (Type == "S" && ($("#txtFromDate").val() == "" || $("#txtToDate").val() == "")) {
            $('#txtFromDate').datepicker('setDate', 'today');
            $('#txtToDate').datepicker('setDate', 'today');
        }
        var FromDate = $("#txtFromDate").val();
        var ToDate = $("#txtToDate").val();
        var DCode = $("#cmbDoctList").val() != "" ? $("#cmbDoctList option:selected").text() : "";
        startLoading("Loading");
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GetMedicationtHistory',
            datatype: "json",
            async :false,
            data: { strMrNo: mrno, FromDate: FromDate, ToDate: ToDate, DoctCode: DCode },
            success: function (result) {
                BindMedicationHistory(Type, FromDate, ToDate, DCode, mrno, tranNo, result);
                stopLoading();
            }
        });
    }

    function BindMedicationHistory(Type, FromDate, ToDate, DCode, mrno, tranNo, LstData) {
        debugger;
        if (LstData[0] != null && LstData[0].length > 0) {
            var DateList = FilterDateWise("O", LstData[0]);
            if (DateList.length == 0) {
                NoDataFound("No Data Found.", "tbldiv");
                return;
            }
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
                    var patCompleteYn = sessionStorage.getItem("PatCompleted");
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
                    var strTable = "<table style='width:100%'>" +
                        "<tr>" +
                        "<td class='ExColicon' style='width: 50%;text-align: left;padding-bottom: 10px;'>OPD case summary</td>" +
                        "<td class='ExColicon' style='text-align: right;'>" + (OPDPresc[0][i].DOCTNAME.toString() == "" ? "" : ("Dr." + OPDPresc[0][i].DOCTNAME.toString() + (OPDPresc[0][i].SPECNAME.toString() == "" ? "" : " (" + OPDPresc[0][i].SPECNAME.toString() + ")"))) + "</td>" +
                        "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                        "</tr>" +
                        "<tr>" +
                         // Ongoing Added By Abhishesh
                        "<td class='ExColicon' style='width: 50%;text-align: left;' class='ComplStatus' id='" + OPDPresc[0][i].TRANNO.toString() + "'>" + (OPDPresc[0][i].COMPLETEDYN.toString() === "Y" ? "<span style='width:20px;display:inline-block'><i class='fa fa-check fa-2x' aria-hidden='true' style='font-size: 1.0em; color: #b9ffb1; cursor:pointer' title='Completed Status'></i></span>" : "<span style='color:orange; font-weight:bold; margin-right:5px;'>Ongoing</span>") + "Consultation No : " + OPDPresc[0][i].TRANNO.toString() +
                        //End
                        (OPDPresc[0][i].COMPLETEDYN.toString() === "Y" ? "<i id='PRES_" + OPDPresc[0][i].TRANNO.toString() + "' class='fa fa-print PatClinicPrescPrint'></i>" : "") +
                        "</td>" +
                        "<td class='ExColicon' style='text-align: right;'>Time :" + OPDPresc[0][i].TRANTIME + "</td>" +
                        "</tr></table>";
                    $divPanelHead.append(strTable);
                    var $divPanelBody = $('<div>', { style: 'font-size:13px;display:none', class: 'panel-body divBody' });
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
                        var strComplaintLst = "<div class='col-md-6 CheifCompDispYN' style='display:" + ($("#chkCheifCompPatClinHist").prop("checked") == true ? "block" : "none") + "'>";
                    else
                        var strComplaintLst = "<div class='col-md-12 CheifCompDispYN' style='display:" + ($("#chkCheifCompPatClinHist").prop("checked") == true ? "block" : "none") + "'>";
                    if ((OPDPresc[2].length > 0 && rs) || (OPDPresc[10].length > 0 && rs1)) {
                        strComplaintLst += "<label><u>Complaints : </u></label>";//
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
                        strVitalsLst = "</div><div class='col-md-6 GenExamDispYN' style='display:" + ($("#chkGeneralExamPatClinHist").prop("checked") == true ? "block" : "none") + "'>";
                    else
                        strVitalsLst = "</div><div class='col-md-12 GenExamDispYN' style='display:" + ($("#chkGeneralExamPatClinHist").prop("checked") == true ? "block" : "none") + "'>";
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
                                strVitalsLst += "<label><u>Vital Data : </u></label>";//
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
                    var $divPastHist = $('<div>', { class: 'row nopadding HistoryDispYN', style: ("display:" + ($("#chkHistoryPatClinHist").prop("checked") == true ? "block" : "none")) });
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
                    var $divDiagno = $('<div>', { class: 'row nopadding DiagnosisDispYN', style: ("display:" + ($("#chkDiagnosisPatClinHist").prop("checked") == true ? "block" : "none")) });
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
                    var $divExamination = $('<div>', { class: 'row nopadding OnExamDispYN', style: ("display:" + ($("#chkOnExamPatClinHist").prop("checked") == true ? "block" : "none")) });
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
                                    strExmLst += "<label><u>Examination : </u></label>";//
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
                                        url: '../DoctorDesk/RetriveExamImages',
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
                                            stopLoading();
                                        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                            stopLoading();
                                        }
                                    });
                                }
                            }
                        }
                        $divExamination.append(strExmLst);
                    }


                    //Clinical Notes priyanka 15/04/2026
                    var $divClinicalNotes = $('<div>', { class: 'row nopadding OnClinicalNtDispYN', style: ("display:" + ($("#chkClinicalNtPatClinHist").prop("checked") == true ? "block" : "none")) });
                    if (OPDPresc[15].length > 0) {
                        var TranDateArryFrmResultFive = [];
                        Object.keys(OPDPresc[5]).forEach(function (key) {
                            var val = OPDPresc[5][key]["TRANNO"];
                            TranDateArryFrmResultFive.push(val);
                        });

                        var rs = TranDateArryFrmResultFive.includes(OPDPresc[0][i].TRANNO);

                        var strClinicalNotesLst = "<div class='col-md-12'>";
                        if (rs) {
                            for (var j = 0; j < OPDPresc[15].length; j++) {
                                if (OPDPresc[0][i].TRANNO == OPDPresc[15][j].TRANNO && OPDPresc[15][j].CLINICALHIST != "") {
                                    strClinicalNotesLst += "<label><u>Clinical Notes : </u></label>";
                                    var id = "P" + j + OPDPresc[15][j].TRANNO;
                                    
                                    if (IsClinicNotesFreeTxtVisible === "Y") { 
                                        var ClinicalNotesData = OPDPresc[15][j].CLINICALHIST;
                                        strClinicalNotesLst += "<p id='" + id + "' onClick='selectText(this.id);' style='font-size:13px;font-weight:500'>&emsp;" + ClinicalNotesData.toString().replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p>";
                                    }
                                    else {
 
                                        var ClinicalData = OPDPresc[15][j].CLINICALHIST;

                                        try {
                                            ClinicalData = decodeURIComponent(ClinicalData);
                                        } catch (e) {
                                            //ClinicalData = unescape(ClinicalData);
                                        }

                                        ClinicalData = cleanCKEditorHtml(ClinicalData);

                                        ClinicalData = ClinicalData.replace(/<table[^>]*>/gi, function (match) {
                                            return "<table style='border-collapse:collapse; caption-side: top; width:100%; border:1px solid black'>";
                                        });

                                        ClinicalData = ClinicalData
                                            .replace(/<td[^>]*>/gi, "<td style='border:1px solid black;padding:6px'>")
                                            .replace(/<th[^>]*>/gi, "<th style='border:1px solid black;padding:6px'>");

                                        strClinicalNotesLst += "<div id='" + id + "' onClick='selectText(this.id);'>&emsp;"
                                            + ClinicalData +
                                            "</div>";
                                    }
                                }
                                strClinicalNotesLst += "<table>";

                            }

                        }
                        strClinicalNotesLst += "</div>";
                        $divClinicalNotes.append(strClinicalNotesLst);
                    }
                    //End



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

                                medicineList = "<div class='col-md-12 RxDispYN' style='display:" + ($("#chkMedRxPatClinHist").prop("checked") == true ? "block" : "none") + "'>";
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

                            strInvestigationLst = "<div class='col-md-6 AdvInvstDispYN' style='display:" + ($("#chkAdvInvstPatClinHist").prop("checked") == true ? "block" : "none") + "'>";

                        } else {
                            strInvestigationLst = "<div class='col-md-12 AdvInvstDispYN' style='display:" + ($("#chkAdvInvstPatClinHist").prop("checked") == true ? "block" : "none") + "'>";

                        }//
                        if ((OPDPresc[6].length > 0 && rs) || (OPDPresc[11].length > 0 && rs1)) {
                            strInvestigationLst += "<label><u>Investigations / Procedures : </u></label>";//
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
                            strPatAdviceLst += "</div><div class='col-md-6 InstructDispYN' style='display:" + ($("#chkRAdvicePatClinHist").prop("checked") == true ? "block" : "none") + "'>";
                        }//
                        else {
                            strPatAdviceLst += "</div><div class='col-md-12 InstructDispYN' style='display:" + ($("#chkRAdvicePatClinHist").prop("checked") == true ? "block" : "none") + "'>";
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
                                strPatAdviceLst += "<label><u>Instructions : </u></label>";
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
                    var AdviceList = "";
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


                            if ((OPDPresc[8].length > 0 && rs)) {

                                AdviceList += "<div class='col-md-6 AdviceDispYN' style='display:" + ($("#chkAdvicesPatClinHist").prop("checked") == true ? "block" : "none") + "'>";

                            } else {
                                AdviceList += "<div class='col-md-12 AdviceDispYN' style='display:" + ($("#chkAdvicesPatClinHist").prop("checked") == true ? "block" : "none") + "'>";

                            }

                            if ( //priyanka 15/04/2026
                                OPDPresc[8].length > 0 &&
                                OPDPresc[8][0]["ADMNADVYN"] !== "N" &&
                                Object.values(OPDPresc[8]).some(val => val && val.toString().trim() !== "" && val !== "N")
                            ) {
                                AdviceList += "<label><u>Advice : </u></label>";
                            }
                            //end
                            
                            if (rs) {

                                for (var j = 0; j < OPDPresc[8].length; j++) {

                                    //surgery advice
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["SURGNMADVICE"] != "") {
                                        // Surgery Adviced Date - only show if not empty
                                        if (OPDPresc[8][j]["SURGADVDATE"] != "") {
                                            var surgAdviceDate = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            surgAdviceDate += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Adviced Date</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + OPDPresc[8][j]["SURGADVDATE"] + "</p></td></tr></table>"
                                            surgAdviceDate += "</div>";
                                            AdviceList += surgAdviceDate;
                                        }

                                        // Surgery Adviced - names only, each on its own line
                                        var surgNamesOnly = OPDPresc[8][j]["SURGNMADVICE"].split(',').join('<br>');
                                        var surgAdvice = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        surgAdvice += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Adviced</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + surgNamesOnly + "</p></td></tr></table>"
                                        surgAdvice += "</div>";
                                        AdviceList += surgAdvice;

                                        // Surgery Description (free text) - separate label, only if not empty
                                        if (OPDPresc[8][j]["SURGADVICEOTHER"] != "") {
                                            var surgDesc = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            surgDesc += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Description</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + OPDPresc[8][j]["SURGADVICEOTHER"] + "</p></td></tr></table>"
                                            surgDesc += "</div>";
                                            AdviceList += surgDesc;
                                        }

                                        // PAC Advice Date - only show if not empty
                                        if (OPDPresc[8][j]["PACADVDATE"] != "") {
                                            var PACAdviceDate = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            PACAdviceDate += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>PAC Advice Date</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + OPDPresc[8][j]["PACADVDATE"] + "</p></td></tr></table>"
                                            PACAdviceDate += "</div>";
                                            AdviceList += PACAdviceDate;
                                        }
                                    }
                                    //end

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

                                        AdviceList += ReferredDoctLst;

                                        //$divFollowUps.append(ReferredDoctLst);
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

                                        //$divFollowUps.append(ReferredSpcLst);
                                        AdviceList += ReferredSpcLst;
                                    }//
                                    //Moved By Abhishesh || 20260820
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

                                        //$divFollowUps.append(ReferredSpcLst);
                                        AdviceList += ReferredSpcLst;
                                    }
                                    //End
                                    //plan Of treatment  // added by meenakshi 1st may
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["PLANOFTREAT"] != "") {

                                        var ReferredSpcLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                        ReferredSpcLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Plan of Treatment</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' onClick='selectText(this.id);' id='planOfTreat" + j + "' class='liClass'>";

                                        ReferredSpcLst += OPDPresc[8][j]["PLANOFTREAT"] + "&nbsp;&nbsp;";

                                        ReferredSpcLst += "</td></tr></table>";
                                        ReferredSpcLst += "</div>";

                                        //$divFollowUps.append(ReferredSpcLst);
                                        AdviceList += ReferredSpcLst;
                                    }


                                    //Follow up date
                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["FOLLOWUPDT"] != "") {
                                        //$divFollowUps.append("</br>");
                                        AdviceList += "</br>";
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
                                        //$divFollowUps.append(ReferredSpcLst);
                                        AdviceList += ReferredSpcLst;
                                    }

                                    if (OPDPresc[8][j]["APPMNTDT"] != "" && OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO) {
                                        ReferredSpcLst = "<div class='col-md-12'>";
                                        ReferredSpcLst += "<label class='liClass'>Your Appointment is booked on " + OPDPresc[8][j]["APPMNTDT"] + " at " + OPDPresc[8][j]["APPMNTTM"] + " </label>";//
                                        ReferredSpcLst += "</div>";
                                        //$divFollowUps.append(ReferredSpcLst);
                                        AdviceList += ReferredSpcLst;
                                    }

                                    if (OPDPresc[0][i].TRANNO == OPDPresc[8][j].TRANNO && OPDPresc[8][j]["ADMNADVYN"] == "Y") {
                                        //$divFollowUps.append("</br>");
                                        AdviceList += "</br>";
                                        var AdmAdv = "<div class='col-md-12' ><label class='liClass'>" + (("" + OPDPresc[8][j]["PROPADMNDT"]).trim() != "" ? ("Admission Adviced on " + ("" + OPDPresc[8][j]["PROPADMNDT"]).trim()) : "Admission Adviced") + ".</label></div>";
                                        //$divFollowUps.append(AdmAdv);
                                        AdviceList += AdmAdv;
                                    }
                                    
                                }
                                //priyanka 15/04/2026
                                AdviceList += "</div>";
                                $divFollowUps.append(AdviceList);
                                //end
                            }
                            var $divDoctName = $('<div>', { class: 'row nopadding' });
                            if (OPDPresc[0][i].DOCTNAME != "") {
                                var strDoctName = "<div class='col-md-12' style='background-color:aliceblue;display: flex;flex-direction: column;'><label style='text-align:right;float:right;font-size:13px;'>Dr. " + OPDPresc[0][i].DOCTNAME + "</label><label style='text-align:right;float:right;font-size:12px;'>" + OPDPresc[0][i].DEPTNAME + "</label></div>";
                                $divDoctName.append(strDoctName);
                            }
                            $divPanelBody.append($divComplaintsNVitals);
                            $divPanelBody.append($divPastHist);
                            $divPanelBody.append($divDiagno);
                            $divPanelBody.append($divExamination);
                            $divPanelBody.append($divClinicalNotes);//priyanka 15/04/2026
                            $divPanelBody.append($divAdvices);
                            $divPanelBody.append($divInvestpatAdv);
                            $divPanelBody.append($divFollowUps);
                            $divPanelBody.append($divDoctName);
                            $divPanel.append($divPanelHead);
                            $divPanel.append($divPanelBody);
                            $("#" + DivId).append($divPanel)
                        
                        }
                    }
            });
            }
            else {
                NoDataFound("No Data Found.", "tbldiv");
            }
    }

    function htmlToText(html) {
        debugger;
            var div = document.createElement("div");
            div.innerHTML = html;
            return div.textContent || div.innerText || "";
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
            startLoading("Loading");
            var splitcon = Date.split('-');
            var tranNo = sessionStorage.getItem("PatTRANNO");
            var mrno = GetSessionMRNO();
            var patName = sessionStorage.getItem("PatName");
            var patAge = (sessionStorage.getItem("PatAge2") == undefined || sessionStorage.getItem("PatAge2") == null) ? "" : sessionStorage.getItem("PatAge2");
            var patGender = (sessionStorage.getItem("PatGender") == undefined || sessionStorage.getItem("PatGender") == null) ? "" : sessionStorage.getItem("PatGender");
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/RefillRxFromMedHist',
                datatype: "json",
                data: { strTranNo: tranNo, strConsultNo: ConsultNo, strMrno: mrno, strpatName: patName, strpatAge: patAge, strpatGender: patGender, strTranDate: splitcon[0], strTranTime: splitcon[1] },
                success: function (result) {
                    if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg("Copied Successfully", "success");
                    }
                },
                complete: function () {
                    stopLoading();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    stopLoading();
                }
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
            $("#cmbDoctList").empty();
            var Option = '<option value="{Value}">{TEXT}</option>';
            var DefaultOption = '<option value="">---All---</option>';
            $("#cmbDoctList").append(DefaultOption);
            for (var i = 0; i < DoctorListData.length; i++) {
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
    <%-- PAC --%>
    function GetPACHistory() {
        var mrno = GetSessionMRNO();
        startLoading("Loading");
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
            complete: function () {
                stopLoading();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading();
            }
        });
        BindPACHistoryListData(PACHistList);
        stopLoading();
    }

    function BindPACHistoryListData(PACHistList) {
        $("#tblPACdiv").empty();
        if (PACHistList.length > 0) {
            var DateList = FilterDateWise("P", PACHistList);
            if (DateList.length == 0) {
                NoDataFound("No Data Found.", "tblPACdiv");
                return;
            }
            $.grep(DateList, function (a) {
                var AllData = JSON.parse(JSON.stringify(PACHistList));
                var PACRec = FilterDateWiseData("P", a, AllData);
                var DateId = IdForGroupDiv(a);
                var DivId = "P" + "_" + DateId;
                var LabelShow = ShowDateConvert(a);
                AddGroupDiv(DivId, "P", LabelShow, "tblPACdiv");
                for (var i = 0; i < PACRec.length; i++) {
                    var $divPanel = $('<div>', { style: '', class: 'panel' });
                    var $divPanelHead = $('<div>', { style: 'font-size:13px;margin- bottom: 10px;    ', class: 'panel-heading divHeads' });
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
                        "<td class='ExColicon' style='text-align: right;'>Time:" + /*ConvertTo12Hour*/("P", PACRec[i].PACFITTIME) + "</td>" +  // Abhishesh || 20260323
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
            NoDataFound("No Data Found.", "tblPACdiv");
        }
    }

    function PrintPAC(TranNo) {
        startLoading("Loading");

        var DataToSend = {
            TranNo: TranNo,
            MRNo: GetSessionMRNO(),
            SpecialityYN: "Y",
            AllOptionYN: "Y",
            LetterHeaderYN: '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PACDEFAULTLETTER")%>'
        }
        $.ajax({
            url: '../DoctorDesk/PrintPACDtls',
            data: DataToSend,
            type: 'post',
            async: true,
            success: function (response) {
                var win = window.open('../DoctorDesk/DisplayPrintPAC', "_blank", '', true);
                win.focus();
                stopLoading();
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading();
            },
            complete: function () {
                stopLoading();
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
        startLoading("Loading");
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
            stopLoading();
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
    <%-- Surgical --%>
    function GetBindingData() {
        var strMrNo = GetSessionMRNO();
        startLoading("Loading");
        $.ajax({
            type: "get",
            datatype: "json",
            url: '../DoctorDesk/GetSurgicalHistoryData',
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
            complete: function () {
                stopLoading();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading();
            }
        });
    }
    //function BindData(dataList) {
    //    $("#tblSurgerydiv").empty();
    //    if (dataList.length > 0) {
    //        var DateList = FilterDateWise("S", dataList);
    //        if (DateList.length == 0) {
    //            NoDataFound("No Data Found.", "tblSurgerydiv");
    //            return;
    //        }
    //        $.grep(DateList, function (a) {
    //            var AllData = JSON.parse(JSON.stringify(dataList));
    //            var SurgRec = FilterDateWiseData("S", a, AllData);
    //            var DateId = IdForGroupDiv(a);
    //            var DivId = "S" + "_" + DateId;
    //            var LabelShow = ShowDateConvert(a);
    //            AddGroupDiv(DivId, "S", LabelShow, "tblSurgerydiv");
    //            for (var i = 0; i < SurgRec.length; i++) {
    //                var $divPanel = $('<div>', { style: '', class: 'panel' });
    //                var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
    //                var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });
    //                var Inhouse = SurgRec[i].UniqueId == "0" ? "<strong>Inhouse Surgery Done</strong>" : "<strong>Inhouse Surgery Not Done</strong>";
    //                var DrInclude = SurgRec[i].SurgeonDoctorName.toString().includes('Dr.') == true ? "" : "Dr."
    //                var strTable = "<table style='width:100%'>" +
    //                    "<tr>" +
    //                    "<td style='width: 50%;text-align: left;padding-bottom: 10px;'>Surgical</td>" +
    //                    "<td class='ExColicon' style='text-align: right;'>" + (SurgRec[i].SurgeonDoctorName.toString() == "" ? "" : DrInclude + SurgRec[i].SurgeonDoctorName.toString() + (SurgRec[i].DOCTSP.toString() == "" ? "" : " (" + SurgRec[i].DOCTSP.toString() + ")")) + "</td>" +
    //                    "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
    //                    "</tr>" +
    //                    "<tr>" +
    //                    "<td class='ExColicon' style='width: 50%;text-align: left;'>" + Inhouse + "</td>" +
    //                    "<td class='ExColicon' style='text-align: right;'>" + (SurgRec[i].SURGTIME.trim() == "" ? "" : ("Time : " + SurgRec[i].SURGTIME)) + "</td>" +
    //                    "</tr></table>";
    //                $divPanelHead.append(strTable);
    //                var strBody = "";
    //                var rawNotes = SurgRec[i].SurgeryNotes || '';
    //                var decodedNotes = decodeURIComponent(rawNotes).replace(/<[^>]*>/g, '');
    //                strBody += '<div class="surgery-card">';
    //                strBody += '<div class="surgery-card-body">';
    //                strBody += '<div class="surgery-SurgeryName-info-box"><strong>Surgery Name : </strong> ' + SurgRec[i].SurgeryName + '</div>';
    //                strBody += '<div style="padding: 0px 15px;"><label style="margin: 0px;"><strong>Note: </strong></label><br>';
    //                strBody += '<textarea class="notes-textarea auto-expand TextAreaBorder" rows="3" readonly>' + decodedNotes + '</textarea></div>';
    //                strBody += '</div>';
    //                strBody += '</div>';
    //                $divPanel.append($divPanelHead);
    //                $divPanelBody.append(strBody);
    //                $divPanel.append($divPanelBody);
    //                $("#" + DivId).append($divPanel)
    //            }
    //        });
    //    }
    //    else {
    //        NoDataFound("No Data Found.", "tblSurgerydiv");
    //    }
    //}


    function BindData(dataList) {
        $("#tblSurgerydiv").empty();
        if (dataList.length > 0) {
            var DateList = FilterDateWise("S", dataList);
            if (DateList.length == 0) {
                NoDataFound("No Data Found.", "tblSurgerydiv");
                return;
            }
            $.grep(DateList, function (a) {
                var AllData = JSON.parse(JSON.stringify(dataList));
                var SurgRecForDate = FilterDateWiseData("S", a, AllData);
                var DateId = IdForGroupDiv(a);
                var DivId = "S" + "_" + DateId;
                var LabelShow = ShowDateConvert(a);
                AddGroupDiv(DivId, "S", LabelShow, "tblSurgerydiv");

                if (SurgRecForDate.length > 0) {

                      // Group records for this date by OTNotesNo (only when OTNotesNo is present/non-empty)
                    var otGroups = {};
                    var otOrder = [];
                    var ungroupedRecs = []; // records with no OTNotesNo - each rendered individually

                    for (var k = 0; k < SurgRecForDate.length; k++) {
                        var otNo = (SurgRecForDate[k].OTNotesNo || "").toString().trim();
                        if (otNo === "0") otNo = ""; // treat "0" as no OT note number

                        if (otNo != "") {
                            if (!otGroups[otNo]) {
                                otGroups[otNo] = [];
                                otOrder.push(otNo);
                            }
                            otGroups[otNo].push(SurgRecForDate[k]);
                        } else {
                            ungroupedRecs.push(SurgRecForDate[k]);
                        }
                    }

                    // Helper to render a single panel given an array of records (a "group")
                    function renderPanel(SurgRec) {
                        var $divPanel = $('<div>', { style: '', class: 'panel' });
                        var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
                        var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });

                        // Use first record of this group for header info (Doctor / Time / Inhouse status)
                        var firstRec = SurgRec[0];
                        var Inhouse = firstRec.UniqueId == "0" ? "<strong>Inhouse Surgery Done</strong>" : "<strong>Inhouse Surgery Not Done</strong>";
                        var DrInclude = firstRec.SurgeonDoctorName.toString().includes('Dr.') == true ? "" : "Dr."
                        var strTable = "<table style='width:100%'>" +
                            "<tr>" +
                            "<td style='width: 50%;text-align: left;padding-bottom: 10px;'>Surgical</td>" +
                            "<td class='ExColicon' style='text-align: right;'>" + (firstRec.SurgeonDoctorName.toString() == "" ? "" : DrInclude + firstRec.SurgeonDoctorName.toString() + (firstRec.DOCTSP.toString() == "" ? "" : " (" + firstRec.DOCTSP.toString() + ")")) + "</td>" +
                            "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td class='ExColicon' style='width: 50%;text-align: left;'>" + Inhouse + "</td>" +
                            "<td class='ExColicon' style='text-align: right;'>" + (firstRec.SURGTIME.trim() == "" ? "" : ("Time : " + firstRec.SURGTIME)) + "</td>" +
                            "</tr></table>";
                        $divPanelHead.append(strTable);

                        // Surgery Name header: numbered list of all surgeries in this group
                        var surgeryNames = [];
                        for (var i = 0; i < SurgRec.length; i++) {
                            if (SurgRec[i].SurgeryName && SurgRec[i].SurgeryName.trim() != "") {
                                surgeryNames.push((i + 1) + "." + SurgRec[i].SurgeryName);
                            }
                        }

                        // Notes section: only include notes for surgeries that actually have notes,
                        // each block prefixed with its own Surgery Name and separated by a divider line
                        var combinedNotes = "";
                        for (var j = 0; j < SurgRec.length; j++) {
                            var rawNotes = SurgRec[j].SurgeryNotes || '';
                            if (rawNotes.trim() != "") {
                                var decodedNotes = decodeURIComponent(rawNotes).replace(/<[^>]*>/g, '');
                                if (decodedNotes.trim() != "") {
                                    if (combinedNotes != "") {
                                        combinedNotes += "\n_________________________________________________________________________\n";
                                    }
                                    combinedNotes += "Surgery Name : " + SurgRec[j].SurgeryName + "\n" + decodedNotes;
                                }
                            }
                        }

                        var strBody = "";
                        strBody += '<div class="surgery-card">';
                        strBody += '<div class="surgery-card-body">';
                        strBody += '<div class="surgery-SurgeryName-info-box"><strong>Surgery Name : </strong> ' + surgeryNames.join(", ") + '</div>';
                        strBody += '<div style="padding: 0px 15px;"><label style="margin: 0px;"><strong>Note: </strong></label><br>';
                        strBody += '<textarea class="notes-textarea auto-expand TextAreaBorder" rows="3" readonly>' + combinedNotes + '</textarea></div>';
                        strBody += '</div>';
                        strBody += '</div>';

                        $divPanel.append($divPanelHead);
                        $divPanelBody.append(strBody);
                        $divPanel.append($divPanelBody);
                        $("#" + DivId).append($divPanel);
                    }

                    // Render OTNotesNo-grouped panels
                    for (var tIdx = 0; tIdx < otOrder.length; tIdx++) {
                        renderPanel(otGroups[otOrder[tIdx]]);
                    }

                    // Render each ungrouped record (no OTNotesNo) as its own individual panel
                    for (var u = 0; u < ungroupedRecs.length; u++) {
                        renderPanel([ungroupedRecs[u]]);
                    }
                }
            });
        }
        else {
            NoDataFound("No Data Found.", "tblSurgerydiv");
        }
    }

    function autoResizeTextareas() {
        $(".auto-expand").each(function () {
            this.style.height = 'auto';
            this.style.height = Math.max(this.scrollHeight, 100) + 'px';
        });
    }
    <%-- Chemo --%>
    function GetMedicationHistory() {
        var mrno = GetSessionMRNO();
        $("#tblChemodiv").empty();
        startLoading("Loading");
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GetchemoHistory',
            datatype: "json",
            data: { strMrNo: mrno },
            success: function (result) {
                BindChemoData(result);
            },
            complete: function () {
                stopLoading();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading();
            }
        });
    }

    //function BindChemoData(dataList) {
    //    $("#tblChemodiv").empty();
    //
    //    if (dataList.data.length > 0) {
    //        var DateList = FilterDateWise("C", dataList.data);
    //        if (DateList.length == 0) {
    //            NoDataFound("No Data Found.", "tblChemodiv");
    //            return;
    //        }
    //        $.grep(DateList, function (a) {
    //            var AllData = JSON.parse(JSON.stringify(dataList));
    //            var ChemoRec = FilterDateWiseData("C", a, AllData);
    //            var DateId = IdForGroupDiv(a);
    //            var DivId = "C" + "_" + DateId;
    //            var LabelShow = ShowDateConvert(formatDate(a));
    //
    //            AddGroupDiv(DivId, "C", LabelShow, "tblChemodiv");
    //
    //            //var result =ChemoRec.data;
    //            for (var i = 0; i < ChemoRec.data.length; i++) {
    //                var result = dataList.data.filter(function (A) {
    //                    return A.PLANID == ChemoRec.data[i].PLANID;
    //                }); 
    //                var $divPanel = $('<div>', { class: 'panel' });
    //                var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
    //                var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });
    //
    //                var ChemoPlanNo = ChemoRec.data[i].PLANID;
    //                var TotalCycle = "";
    //                var CurrentCycle = 0;
    //                var PendingCycle = 0;
    //
    //                if (Array.isArray(result) && result.length > 0) {
    //                    var totalCycleObj = result.find(function (x) {
    //                        return x.TOTALCYCLE && x.TOTALCYCLE.trim() !== "";
    //                    });
    //                    TotalCycle = totalCycleObj ? totalCycleObj.TOTALCYCLE : "";
    //                    CurrentCycle = result.filter(function (x) { return x.CYCLENO && x.CYCLENO.trim() !== ""; }).length;
    //                    PendingCycle = TotalCycle - CurrentCycle;
    //                }
    //
    //                var strTable = "<table style='width:100%'>" +
    //                    "<tr>" +
    //                    "<td style='width: 50%;text-align: left;padding-bottom: 10px;'><span style='color:#b9ffb1;font-size:1.2em;width: 20px;display:inline-block'><i class='fa fa-check'></i></span>Chemo Plan No : " + ChemoPlanNo + "</td>" +
    //                    "<td class='ExColicon' style='text-align: right;'>" + (ChemoRec.data[i].DOCTNAME.toString() == "" ? "" : ("Dr." + ChemoRec.data[i].DOCTNAME.toString() + (ChemoRec.data[i].DOCTSP.toString() == "" ? "" : " (" + ChemoRec.data[i].DOCTSP.toString() + ")"))) + "</td>" +
    //                    "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
    //                    "</tr>" +
    //                    "<tr>" +
    //                    "<td class='ExColicon' style='width: 50%;text-align: left;'>Total Cycle No : " + TotalCycle + "</td>" +
    //                    "<td class='ExColicon' style='text-align: right;'></td>" +
    //                    "</tr></table>";
    //
    //                $divPanelHead.append(strTable);
    //
    //
    //                var resultTbl = (Array.isArray(dataList.data1) && dataList.data1.length > 0) ? dataList.data1 : [];
    //
    //                if (Array.isArray(result) && result.length > 0) {
    //                    $.each(result, function (i, item) {
    //                        var html = "";
    //                        var PTableId = "HistoryChemo_Tbl_" + i;
    //                        var PContentTblId = "HistoryChemo_Cont_" + i;
    //
    //                        var FilterData = resultTbl.filter(function (A) {
    //                            return A.PLANID == item.PLANID && A.CYCLENO == item.CYCLENO;
    //                        });
    //
    //                        html += '<div class="chemo-card-body" style="background:#fff;padding:10px 15px;font-size:14px;">';
    //
    //                        if (item.CYCLENO && item.CYCLENO.trim() !== "") {
    //                            html +=
    //                                '<div class="surgery-SurgeryName-info-box">' +
    //                                'Cycle: ' + item.CYCLENO.trim() +
    //                                ' - Day: ' + item.DAY +
    //                                ' &nbsp;&nbsp; Start Date: ' + formatDate(item.STARTDATE) +
    //                                ' &nbsp;&nbsp; End Date: ' + formatDate(item.ENDDATE) +
    //                                '</div>' +
    //                                '<div style="margin-bottom:10px;"><b>Chemotherapy Name:</b> ' + item.NAME + '</div>' +
    //                                '<div><b>Protocol:</b><br>' +
    //                                '<div id="' + PContentTblId + '" style="overflow-x:auto;padding:0;">' +
    //                                '<div id="' + PTableId + '"></div>' +
    //                                '</div>' +
    //                                '</div>';
    //                        } else {
    //                            html +=
    //                                '<div><b>Modification During Treatment:</b><br>' +
    //                                '<div style="border:1px solid #ccc;padding:10px;background-color:#f9f9f9;font-size:13px;line-height:1.6;white-space:pre-wrap;">' +
    //                                item.MODIFYMEDS +
    //                                '</div>' +
    //                                '</div>';
    //                        }
    //
    //                        //priyanka 10/06/2026
    //                        if (item.TREATMENTCOMPLETESTATUS != "" && item.TREATMENTCOMPLETESTATUS != undefined) {
    //                            html += "<div><b>Treatment Conclusion Status:</b></div>" +
    //                                "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + item.TREATMENTCOMPLETESTATUS + "</div>";
    //                        }
    //                        if (item.CONCLUSIONREMARK != "" && item.CONCLUSIONREMARK != undefined) {
    //                            html += "<div><b>Conclusion Remarks:</b></div>" +
    //                                "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + item.CONCLUSIONREMARK + "</div>";
    //                        }
    //                        //end
    //
    //                        html += '</div>';
    //
    //                        $divPanelBody.append(html);
    //                        $divPanel.append($divPanelHead);
    //                        $divPanel.append($divPanelBody);
    //                        $("#" + DivId).append($divPanel);
    //
    //                        if (FilterData.length > 0) {
    //                            setTimeout(function () {
    //                                HistShowPlanCompleteLst(PTableId, PContentTblId, FilterData);
    //                            }, 50);
    //                        }
    //                    });
    //                } else {
    //                    html = '<div class="NoDataFound">No Data Found.</div>';
    //                    $divPanelBody.append(html);
    //                    $divPanel.append($divPanelHead);
    //                    $divPanel.append($divPanelBody);
    //                    $("#" + DivId).append($divPanel);
    //                }
    //            }
    //        });
    //    } else {
    //        NoDataFound("No Data Found.", "tblChemodiv");
    //    }
    //}



    function BindChemoData(dataList) {
        $("#tblChemodiv").empty();

        if (dataList.data.length > 0) {
            var DateList = FilterDateWise("C", dataList.data);
            if (DateList.length == 0) {
                NoDataFound("No Data Found.", "tblChemodiv");
                return;
            }
            $.grep(DateList, function (a) {
                var AllData = JSON.parse(JSON.stringify(dataList));
                var ChemoRec = FilterDateWiseData("C", a, AllData);
                var DateId = IdForGroupDiv(a);
                var DivId = "C" + "_" + DateId;
                var LabelShow = ShowDateConvert(formatDate(a));

                // ---- Date header (orange) unchanged ----
                AddGroupDiv(DivId, "C", LabelShow, "tblChemodiv");

                // ---- Group rows within this date by PLANID so each Plan No renders ONCE ----
                var planOrder = [];
                var planMap = {};
                for (var p = 0; p < ChemoRec.data.length; p++) {
                    var pid = ChemoRec.data[p].PLANID;
                    if (!planMap[pid]) {
                        planMap[pid] = ChemoRec.data[p];
                        planOrder.push(pid);
                    }
                }

                for (var i = 0; i < planOrder.length; i++) {
                    var planRow = planMap[planOrder[i]];
                    var result = dataList.data.filter(function (A) {
                        return A.PLANID == planRow.PLANID;
                    });

                    var $divPanel = $('<div>', { class: 'panel' });
                    var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });
                    var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });

                    var ChemoPlanNo = planRow.PLANID;
                    var TotalCycle = "";
                    var CurrentCycle = 0;
                    var PendingCycle = 0;

                    if (Array.isArray(result) && result.length > 0) {
                        var totalCycleObj = result.find(function (x) {
                            return x.TOTALCYCLE && x.TOTALCYCLE.trim() !== "";
                        });
                        TotalCycle = totalCycleObj ? totalCycleObj.TOTALCYCLE : "";
                        CurrentCycle = result.filter(function (x) { return x.CYCLENO && x.CYCLENO.trim() !== ""; }).length;
                        PendingCycle = TotalCycle - CurrentCycle;
                    }

                    // ---- Panel head (blue) — unchanged style, now rendered once per Plan No ----
                    var strTable = "<table style='width:100%'>" +
                        "<tr>" +
                        "<td style='width: 50%;text-align: left;padding-bottom: 10px;'><span style='color:#b9ffb1;font-size:1.2em;width: 20px;display:inline-block'><i class='fa fa-check'></i></span>Chemo Plan No : " + ChemoPlanNo + "</td>" +
                        "<td class='ExColicon' style='text-align: right;'>" + (planRow.DOCTNAME.toString() == "" ? "" : ("Dr." + planRow.DOCTNAME.toString() + (planRow.DOCTSP.toString() == "" ? "" : " (" + planRow.DOCTSP.toString() + ")"))) + "</td>" +
                        "<td rowspan='2' class='ExColicon' style='width: 30px;'><span class='fa fa-caret-down spanCls'></span></td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td class='ExColicon' style='width: 50%;text-align: left;'>Total Cycle No : " + TotalCycle + "</td>" +
                        "<td class='ExColicon' style='text-align: right;'></td>" +
                        "</tr></table>";

                    $divPanelHead.append(strTable);

                    var resultTbl = (Array.isArray(dataList.data1) && dataList.data1.length > 0) ? dataList.data1 : [];

                    if (Array.isArray(result) && result.length > 0) {
                        $.each(result, function (idx, item) {
                            var html = "";
                            var PTableId = "HistoryChemo_Tbl_" + ChemoPlanNo + "_" + idx;
                            var PContentTblId = "HistoryChemo_Cont_" + ChemoPlanNo + "_" + idx;

                            var FilterData = resultTbl.filter(function (A) {
                                return A.PLANID == item.PLANID && A.CYCLENO == item.CYCLENO;
                            });

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
                                    '<div id="' + PContentTblId + '" style="overflow-x:auto;padding:0;">' +
                                    '<div id="' + PTableId + '"></div>' +
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

                            if (item.TREATMENTCOMPLETESTATUS != "" && item.TREATMENTCOMPLETESTATUS != undefined) {
                                html += "<div><b>Treatment Conclusion Status:</b></div>" +
                                    "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + item.TREATMENTCOMPLETESTATUS + "</div>";
                            }
                            if (item.CONCLUSIONREMARK != "" && item.CONCLUSIONREMARK != undefined) {
                                html += "<div><b>Conclusion Remarks:</b></div>" +
                                    "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + item.CONCLUSIONREMARK + "</div>";
                            }

                            html += '</div>';

                            $divPanelBody.append(html);

                            if (FilterData.length > 0) {
                                (function (tId, cId, fData) {
                                    setTimeout(function () {
                                        HistShowPlanCompleteLst(tId, cId, fData);
                                    }, 50);
                                })(PTableId, PContentTblId, FilterData);
                            }
                        });
                    } else {
                        $divPanelBody.append('<div class="NoDataFound">No Data Found.</div>');
                    }

                    $divPanel.append($divPanelHead);
                    $divPanel.append($divPanelBody);
                    $("#" + DivId).append($divPanel);
                }
            });
        } else {
            NoDataFound("No Data Found.", "tblChemodiv");
        }
    }

    function HistShowPlanCompleteLst(GridId, ContentId, FilterData) {
        var tabulatorTables = {};
        if (tabulatorTables[GridId]) {
            tabulatorTables[GridId].destroy();
        }
        var table = new Tabulator("#" + GridId, {
            data: FilterData || [],
            layout: "fitDataStretch",
            height: "400px",
            groupBy: "APLYTODAY",
            columns: [
                { title: "Drug Form", field: "DRUGFORM", frozen: true, width: 120 },
                { title: "Generic Name", field: "GENERICNM", frozen: true, width: 150 },
                { title: "Dose", field: "DOSE", width: 120 },
                { title: "Dose Unit", field: "DOSEUNIT", width: 80 },
                { title: "Frequency", field: "FREQUENCY", width: 120 },
                { title: "Route", field: "ROUTECD", width: 120 },
                { title: "Calculate On", field: "CALCULATEON", width: 120 },
                { title: "Omit", field: "OMITDRUG", width: 60, formatter: "tickCross" },
                { title: "Diluent", field: "DILUENT", width: 120 },
                { title: "Diluent Volume", field: "VOLDILTN", width: 150 },
                { title: "Remarks", field: "REMARKS", width: 200 },
                { title: "Admission Seq. No.", field: "ADMINSEQNO", width: 180 },
                { title: "Cycle No", field: "CYCLENO", width: 120 },
                { title: "Apply To Day", field: "APLYTODAY", hozAlign: "center", width: 100 },
                { title: "Original Dose", field: "ORIGINALDOSE", width: 120 },
                { title: "Med. Set No.", field: "MEDSETNO", visible: false },
                { title: "Medicine Type", field: "MEDTYPE", visible: false },
                { title: "Generic Code", field: "GENERICID", visible: false },
                { title: "Diluent Generic Code", field: "DILNTGENCD", visible: false },
                { title: "Duration", field: "DURATION", width: 140 }, 
            ],
            initialSort: [
                { column: "APLYTODAY", dir: "asc" }
            ],
        });

        tabulatorTables[GridId] = table;

        window.addEventListener("resize", function () {
            table.redraw
            window.addEventListener("resize", function () {
                table.redraw(true);
            });
        });
    }

    function formatDate(yyyymmdd) {
        if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd;
        var year = yyyymmdd.substring(0, 4);
        var month = yyyymmdd.substring(4, 6);
        var day = yyyymmdd.substring(6, 8);
        return day + "/" + month + "/" + year;
    }

    <%-- Radiation --%>
    function GetRadiationHistory() {
        $("#tblRadiationdiv").empty();
        NoDataFound("No Data Found.", "tblRadiationdiv");
        var DataToSend = {
            Mrno: GetSessionMRNO()
        }
        startLoading("Loading");
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
                stopLoading();
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
        if (DateList.length == 0) {
            NoDataFound("No Data Found.", "tblRadiationdiv");
            return;
        }
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
    <%-- Progress Note --%>
    function GetAdmissionLst() {
        $("#tblClinicdiv").empty();
        NoDataFound("No Data Found.", "tblClinicdiv");
        var DataToSend = {
            Mrno: GetSessionMRNO()
        }
        startLoading("Loading");
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
                stopLoading();
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
        if (DateList.length == 0) {
            NoDataFound("No Data Found.", "tblClinicdiv");
            return;
        }
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
                    "<td class='' style='text-align: right;'>Time : " + /*ConvertTo12Hour*/("N", AdmRec[i].ADMNTIME) + "</td>" + // Abhishesh || 20260323
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
                '<div id="' + PTableId + '"></div>' +
                '</div>';

            $("#" + DivId).append(html);

            setTimeout(function () {
                HistProgressNotesLst(PTableId, PContentTblId, Lst);
            }, 50);
        } else {
            NoDataFound("No Data Found.", DivId);
        }
    }

    function HistProgressNotesLst(GridId, ContentId, Lst) {
        var tabulatorTables = {};
        if (tabulatorTables[GridId]) {
            tabulatorTables[GridId].destroy();
        }

        var table = new Tabulator("#" + GridId, {
            data: Lst || [],
            layout: "fitDataStretch",
            height: "auto",
            columns: [
                {
                    title: "Date", field: "NOTEDT", width: 160, hozAlign: "center",
                    formatter: function (cell) {
                        var val = cell.getValue();
                        if (!val) return "";
                        if (val.length === 8) {
                            var year = val.substring(0, 4);
                            var month = val.substring(4, 6);
                            var day = val.substring(6, 8);
                            return day + "/" + month + "/" + year;
                        }
                        return val;
                    }
                },
                { title: "Time", field: "NOTETM", width: 80, hozAlign: "center" },
                {
                    title: "Added By", field: "USERID", width: 200, hozAlign: "center",
                    formatter: function (cell) {
                        var row = cell.getRow().getData();
                        var val = cell.getValue();
                        var cls = "";
                        if (row.NOTETYPE === "N") cls = "note-n";
                        if (row.NOTETYPE === "R") cls = "note-r";
                        if (row.NOTETYPE === "D") cls = "note-d";
                        return "<span class='" + cls + "'>" + val + "</span>";
                    }
                },
                {
                    title: "Progress Notes", field: "NURSENOTES", width: 550, hozAlign: "left",
                    formatter: function (cell) {
                        var rowData = cell.getRow().getData();
                        var noteText = cell.getValue() || "";
                        var txtColor = (rowData.INKCOLOR === "R") ? "red" : "black";
                        return `
                                <div style="
                                    white-space: pre-wrap;
                                    word-wrap: break-word;
                                    color:${txtColor};
                                    max-height:150px;
                                    overflow-y:auto;
                                ">${noteText}</div>
                            `;
                    }
                },
                { title: "NOTETYPE", field: "NOTETYPE", visible: false },
                { title: "NoteNo", field: "NoteNo", visible: false },
            ],
            initialSort: [
                { column: "NOTEDT", dir: "desc" }
            ],
        });
        tabulatorTables[GridId] = table;
        window.addEventListener("resize", function () {
            table.redraw(true);
        });
    }

    <%-- Discharge Summary --%>
    function GetDischrgLst() {
        //debugger;
        $("#tblDiscSumydiv").empty();
        NoDataFound("No Data Found.", "tblDiscSumydiv");
        var DataToSend = {
            Mrno: GetSessionMRNO(),
            FromDate: $("#txtFromDate").val(),
            ToDate: $("#txtToDate").val()
        }
        startLoading("Loading");
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
                stopLoading();
            },
            complete: function () {
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    function BindDischrgLst(Lst) {
        //debugger;
        $("#tblDiscSumydiv").empty();
        var DateList = FilterDateWise("D", Lst);
        if (DateList.length == 0) {
            NoDataFound("No Data Found.", "tblDiscSumydiv");
            return;
        }
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
        //debugger;
        var el = $("#" + Id);
        $(elm).find('span.spanCls').toggleClass('fa-caret-down fa-caret-right');
        if ($.trim(el.html()).length > 0) {
            el.empty();
        }
        else {
            var DataToSend = {
                DisSummryNo: DischrgNo,
                Mrno: GetSessionMRNO(),
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
        //debugger;
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
                { label: "Vital Exam", name: "Text", index: "Text", width: 250, align: "left" },
                { label: "Value(Admission) / Value(Discharge)", name: "Values", index: "Values", width: 250, align: "left" },
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
                     '<div id="' + SysExamTblContId + '"></div>' + '</div>';
                SysExamDtls = DisSumDtls.GENEXAM;
            }
            SysExamHTML = strSysExamFieldTable + strSysExamTable;
            $("#" + DivId).append(SysExamHTML);
            setTimeout(function () {
                if (ICDDtls.length > 0) {
                    jqTable(SysExamDivContId, SysExamTblContId, SysExam, SysExamDtls);
                }
            }, 50);
            //Diagnosis 
            var DiagnosisHTML = "";
            var DiagnoDivContId = "DIV_ICD_" + DischrgNo;
            var DiagnoTblContId = "TBL_ICD_" + DischrgNo;
            var FinalIcdo = [
                { label: "ICD Code", name: "ICDCODE", index: "ICDCODE", width: 250, align: "left" },
                { label: "Name", name: "ICDNAME", index: "ICDNAME", width: 250, align: "left" },
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
                     '<div id="' + DiagnoTblContId + '"></div>' +
                     '</div>';
                ICDDtls = DisSumDtls.SECONDARY;
            }
            DiagnosisHTML = strDiagFieldTable + strDiagICDTable;
            $("#" + DivId).append(DiagnosisHTML);
            setTimeout(function () {
                if (ICDDtls.length > 0) {
                    jqTable(DiagnoDivContId, DiagnoTblContId, FinalIcdo, ICDDtls);
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
                    { label: "Habit", name: "HABIT", index: "HABIT", width: 250, align: "left" },
                    { label: "Duration", name: "DURATION", index: "DURATION", width: 250, align: "center" },
                ];
                var strPrsHistFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                    "<tr>" +
                    "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Personal History</td>" +
                    "</tr></table></div>";
                var strPrsHistTable = "";
                var PrsHistDtls = [];
                strPrsHistTable =
                     '<div class="GrdTableDiv" id="' + PrsHistDivContId + '" style="overflow-x:auto;padding:0;">' +
                     '<div id="' + PrsHistTblContId + '"></div>' +
                     '</div>';
                PrsHistDtls = DisSumDtls.NEWPERSONALHIST;
                PrsHistHTML = strPrsHistFieldTable + strPrsHistTable;
                $("#" + DivId).append(PrsHistHTML);
                setTimeout(function () {
                    if (PrsHistDtls.length > 0) {
                        jqTable(PrsHistDivContId, PrsHistTblContId, PrsHist, PrsHistDtls);
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
                    { label: "Drug Name", name: "DRUGNAME", index: "DRUGNAME", width: 250, align: "left" },
                    { label: "Dosage", name: "DOSE", index: "Values", width: 150, align: "center" },
                    { label: "Route", name: "ROUTE", index: "Values", width: 150, align: "center" },
                    { label: "Freq", name: "FREQ", index: "Values", width: 150, align: "center" },
                ];
                var strDrugFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                    "<tr>" +
                    "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>Treatement During Hospitalization</td>" +
                    "</tr></table></div>";
                var strTreatmntTable = "";
                var TreatmntDtls = [];
                strTreatmntTable =
                     '<div class="GrdTableDiv" id="' + DrugDivContId + '" style="overflow-x:auto;padding:0;">' +
                     '<div id="' + DrugTblContId + '"></div>' +
                     '</div>';
                TreatmntDtls = DisSumDtls.Table6;
                TreatmntHTML = strDrugFieldTable + strTreatmntTable;
                $("#" + DivId).append(TreatmntHTML);
                setTimeout(function () {
                    if (TreatmntDtls.length > 0) {
                        jqTable(DrugDivContId, DrugTblContId, Drugs, TreatmntDtls);
                    }
                }, 50);
            }
            //Obtain Urgent Care
            if (DisSumDtls.EMGR != null && DisSumDtls.EMGR != undefined && DisSumDtls.EMGR.length > 0) {
                var UrgCareHTML = "";
                var UrgCareDivContId = "DIV_URGCARE_" + DischrgNo;
                var UrgCareTblContId = "TBL_URGCARE_" + DischrgNo;
                var UrgCare = [
                    { label: "Name", name: "TEXT", index: "TEXT", width: 250, align: "left" },
                    { label: "Remark", name: "REMARKS", index: "REMARKS", width: 250, align: "center" },
                ];
                var strUrgCareFieldTable = "<div class=''><table style='width: auto !important;margin: 0px 15px 0px 15px;'>" +
                    "<tr>" +
                    "<td colspan='3' class='DSMainHeaderDiv' style='text-align: left;padding-bottom: 10px;'>When to Obtain Urgent Care</td>" +
                    "</tr></table></div>";
                var strUrgCareTable = "";
                var UrgCareDtls = [];
                strUrgCareTable =
                     '<div class="GrdTableDiv" id="' + UrgCareDivContId + '" style="overflow-x:auto;padding:0;">' +
                     '<div id="' + UrgCareTblContId + '"></div>' +
                     '</div>';
                UrgCareDtls = DisSumDtls.EMGR;
                UrgCareHTML = strUrgCareFieldTable + strUrgCareTable;
                $("#" + DivId).append(UrgCareHTML);
                setTimeout(function () {
                    if (UrgCareDtls.length > 0) {
                        jqTable(UrgCareDivContId, UrgCareTblContId, UrgCare, UrgCareDtls);
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
                     '<div id="' + PrevGuideTblContId + '"></div>' +
                     '</div>';
                PrevGuideDtls = DisSumDtls.NEWPREVENTIVE;
                PrevGuideHTML = strPrevGuideFieldTable + strPrevGuideTable;
                $("#" + DivId).append(PrevGuideHTML);
                setTimeout(function () {
                    if (PrsHistDtls.length > 0) {
                        jqTable(PrevGuideDivContId, PrevGuideTblContId, PrevGuide, PrevGuideDtls);
                    }
                }, 50);
            }
            //Medication on Discharge
            if (DisSumDtls.DRUG != null && DisSumDtls.DRUG != undefined && DisSumDtls.DRUG.length > 0) {
                var MedDischHTML = "";
                var MedDischDivContId = "DIV_MedDisch_" + DischrgNo;
                var MedDischTblContId = "TBL_MedDisch_" + DischrgNo;
                var MedDisch = [
                    { label: "Drug Name", name: "DRUGNAME", index: "DRUGNAME", width: 250, align: "left" },
                    { label: "Generic Name", name: "GENERICNM", index: "GENERICNM", width: 250, align: "center" },
                    { label: "Dosage", name: "DOSAGE", index: "DOSAGE", width: 150, align: "center" },
                    { label: "Frequency", name: "INTAKETIME", index: "INTAKETIME", width: 150, align: "center" },
                    { label: "No of Days", name: "NOOFDAYS", index: "NOOFDAYS", width: 150, align: "center" },
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
                     '<div id="' + MedDischTblContId + '"></div>' +
                     '</div>';
                MedDischDtls = DisSumDtls.DRUG;
                MedDischHTML = strMedDischFieldTable + strMedDischTable;
                $("#" + DivId).append(MedDischHTML);
                setTimeout(function () {
                    if (PrsHistDtls.length > 0) {
                        jqTable(MedDischDivContId, MedDischTblContId, MedDisch, MedDischDtls);
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

    function jqTable(ContentId, GridId, ColLst, Data) {
        //debugger;
        var tabulatorTables = {};
        if (tabulatorTables[GridId]) {
            tabulatorTables[GridId].destroy();
        }
        var columns = ColLst.map(function (col) {
            return {
                title: col.label || col.name,
                field: col.name,
                width: col.width || 150,
                hozAlign: col.align || "left",
                visible: col.hidden ? false : true,
            };
        });
        var table = new Tabulator("#" + GridId, {
            data: Data || [],
            layout: "fitColumns",
            height: "auto",
            columns: columns,
            placeholder: "No Data Found",
            rownumbers: true,
            responsiveLayout: "collapse",
        });
        tabulatorTables[GridId] = table;
        function resizeTable() {
            var newWidth = $("#" + ContentId).width();
            $("#" + GridId).css("width", (newWidth - 9) + "px");
            table.redraw(true);
        }
        resizeTable();
        $(window).on("resize", resizeTable);
    }

    function SelectAllFilter() {
        if ($("#chkSelectAll").prop("checked") == true) {
            $("#chkCheifCompPatClinHist").prop("checked", false);
            $("#chkGeneralExamPatClinHist").prop("checked", false);
            $("#chkHistoryPatClinHist").prop("checked", false);
            $("#chkDiagnosisPatClinHist").prop("checked", false);
            $("#chkOnExamPatClinHist").prop("checked", false);
            $("#chkMedRxPatClinHist").prop("checked", false);
            $("#chkAdvInvstPatClinHist").prop("checked", false);
            $("#chkRAdvicePatClinHist").prop("checked", false);
            $("#chkAdvicesPatClinHist").prop("checked", false);//priyanka 15/04/2026
            $("#chkClinicalNtPatClinHist").prop("checked", false);//priyanka 15/04/2026
        }
        else {
            $("#chkCheifCompPatClinHist").prop("checked", true);
            $("#chkGeneralExamPatClinHist").prop("checked", true);
            $("#chkHistoryPatClinHist").prop("checked", true);
            $("#chkDiagnosisPatClinHist").prop("checked", true);
            $("#chkOnExamPatClinHist").prop("checked", true);
            $("#chkMedRxPatClinHist").prop("checked", true);
            $("#chkAdvInvstPatClinHist").prop("checked", true);
            $("#chkRAdvicePatClinHist").prop("checked", true);
            $("#chkAdvicesPatClinHist").prop("checked", true);//priyanka 15/04/2026
            $("#chkClinicalNtPatClinHist").prop("checked", true);//priyanka 15/04/2026
        }
        $("#chkCheifCompPatClinHist").trigger('click');
        $("#chkGeneralExamPatClinHist").trigger('click');
        $("#chkHistoryPatClinHist").trigger('click');
        $("#chkDiagnosisPatClinHist").trigger('click');
        $("#chkOnExamPatClinHist").trigger('click');
        $("#chkMedRxPatClinHist").trigger('click');
        $("#chkAdvInvstPatClinHist").trigger('click');
        $("#chkRAdvicePatClinHist").trigger('click');
        $("#chkAdvicesPatClinHist").trigger('click');//priyanka 15/04/2026
        $("#chkClinicalNtPatClinHist").trigger('click');//priyanka 15/04/2026
    }

</script>
<style>
/*.ck-clean table {
    border-collapse: collapse;
    width: 100%;
}

.ck-clean table, 
.ck-clean th, 
.ck-clean td {
    border: 1px solid #000;
}

.ck-clean th, 
.ck-clean td {
    padding: 6px;
    text-align: left;
}

.ck-clean p {
    margin: 4px 0;
}

.ck-clean {
    display: block;
}*/
</style>
<script type="text/javascript">
    //Tumor Board
    function GetTumorPatList() {
        //debugger;
        $("#tblTumorBoard").empty();
        NoDataFound("No Data Found.", "tblTumorBoard");
        var mrno = GetSessionMRNO();
        var DataToSend = {
            sfrmdate: $("#txtFromDate").val(),
            stodate: $("#txtToDate").val(),
            spatname: sessionStorage.getItem("PatName").toString().trim(),//priyanka 09/04/2026
            smrno: GetSessionMRNO(),//priyanka 09/04/2026
            RefTumor: "Y",
            RefTumorStatus: "A",
        }
        startLoading("Loading");
        $.ajax({
            url: '../DoctorDesk/TumorBoardPatListBinding',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            async: true,
            success: function (data) {
                if (data.rows.length > 0) {
                    BindTumorPatList(data);
                }
                stopLoading();
            },
            complete: function () {
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    function BindTumorPatList(Lst) {
        $("#tblTumorBoard").empty();

        if (!Lst.rows || Lst.rows.length === 0) return;

        var uniqueDates = $.unique(Lst.rows.map(function (item) {
            return item.TBMSDATE.split(' ')[0];
        }));

        $.each(uniqueDates, function (index, dateVal) {
            var DateId = dateVal.replace(/\//g, "");
            var DivId = "D_" + DateId;

            AddGroupDiv(DivId, "D", dateVal, "tblTumorBoard");

            var recordsForDate = $.grep(Lst.rows, function (row) {
                return row.TBMSDATE.indexOf(dateVal) > -1;
            });
            for (var i = 0; i < recordsForDate.length; i++) {
                var item = recordsForDate[i];
                var ContentId = 'Details_' + item.TRANNO;
                var strTable = "<div class='panel-heading divHeads' style='padding: 10px 0;'>" +
                    "<table style='width:100%; table-layout: fixed;'>" +
                    "<tr>" +
                    "<td style='width:40%; text-align:left; padding-left:15px; font-weight:bold;'>" +
                    "MR No: " + item.MRNO +
                    "</td>" +
                    "<td style='width:55%; text-align:right; padding-right:20px;'>" +
                    (item.REFDOCTNM ? "Dr. " + item.REFDOCTNM : "") +
                    "</td>" +
                    "<td rowspan='2' style='width:5%; text-align:center;'>" +
                    "<span class='fa fa-caret-down spanCls'></span>" +
                    "</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td style='width: 40%;text-align: left;padding-left:15px; font-weight: bold;'>" +
                    "Trn No: " + item.TRANNO + " (" + (item.STATUS || "") + ")" +
                    "</td>" +
                    "<td style='text-align:right; padding-right:20px; font-weight:bold;'>" +
                    "Time: " + item.TBMSDATE.split(/\s+/).pop() +
                    "</td>" +
                    "</tr>" +
                    "</table>" +
                    "</div>";

                var rowHtml = "<div style='cursor:pointer;' onclick=\"GetTumorBoardDtls(this,'" + item.TRANNO + "','" + ContentId + "','" + item.MRNO + "')\">" +
                    strTable +
                    "</div><div id='" + ContentId + "'></div>";

                $("#" + DivId).append(rowHtml);
            }
        });
    }

    function GetTumorBoardDtls(elm, TranNo, Id, MrNo) {
        //debugger;
        var el = $("#" + Id);
        $(elm).find('span.spanCls').toggleClass('fa-caret-down fa-caret-right');

        if ($.trim(el.html()).length > 0) {
            el.empty();
        } else {
            var DataToSend = {
                TranNo: TranNo,
                Mrno: MrNo
            };
            $.ajax({
                url: '../DoctorDesk/GetTumorBoardDetails', // Adjust URL as per your controller
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                success: function (data) {
                    BindTumorBoardDtls(data, TranNo, Id);
                },
                error: function (err) { console.error("Error fetching details", err); }
            });
        }
    }



    //function cleanCKEditorHtml(html) {
    //    debugger;
    //    if (!html) return "";

    //    // Decode if needed
    //    try {
    //        html = decodeURIComponent(html);
    //    } catch (e) {
    //    }

    //    // Parse HTML safely
    //    var doc = new DOMParser().parseFromString(html, "text/html");

    //    // Remove CKEditor/system noise
    //    doc.querySelectorAll("head, style, link, meta, script").forEach(el => el.remove());

    //    // Remove CKEditor-specific attributes/classes (optional cleanup)
    //    doc.querySelectorAll("*").forEach(el => {
    //        el.removeAttribute("contenteditable");
    //        el.removeAttribute("data-cke-title");
    //        el.removeAttribute("data-cke-temp");
    //    });

    //    // Return clean HTML body
    //    return doc.body.innerHTML.trim();
    //}

    function cleanCKEditorHtml(html) {
        if (!html) return "";

        try {
            html = decodeURIComponent(html);
        } catch (e) { }

        var doc = new DOMParser().parseFromString(html, "text/html");

        // Remove unwanted tags
        doc.querySelectorAll("head, style, link, meta, script").forEach(el => el.remove());

        // Clean elements
        doc.querySelectorAll("*").forEach(el => {
            el.removeAttribute("contenteditable");
            el.removeAttribute("data-cke-title");
            el.removeAttribute("data-cke-temp");

            // 🔥 REMOVE unwanted table styles
            if (el.hasAttribute("style")) {
                let style = el.getAttribute("style");

                style = style
                    .replace(/border-width\s*:\s*0[^;]*;?/gi, "")
                    .replace(/border-collapse\s*:\s*none[^;]*;?/gi, "")
                    .replace(/caption-side\s*:[^;]*;?/gi, "");

                // clean empty style
                if (style.trim() === "") {
                    el.removeAttribute("style");
                } else {
                    el.setAttribute("style", style);
                }
            }
        });

        return doc.body.innerHTML.trim();
    }


    function BindTumorBoardDtls(Lst, TranNo, DivId) {
        var d = Lst;
        var main = (d.Table && d.Table.length > 0) ? d.Table[0] : {};

        $("#" + DivId).empty();

        // 1. ICD-O Diagnosis Table
        //var icdoHtml = "<div class='DSMainHeaderDiv' style='margin:10px 15px;'>ICD-O Diagnosis</div>" +
        //    "<div style='margin:0 15px;'><table class='table table-bordered' style='width:100%; border-collapse:collapse;'>" +
        //    "<thead style='background-color:#455a64; color:white;'><tr>" +
        //    "<th style='padding:8px; text-align:left;'>Code</th>" +
        //    "<th style='padding:8px; text-align:left;'>Topology</th>" +
        //    "<th style='padding:8px; text-align:left;'>Histology/Behaviour</th>" +
        //    "</tr></thead><tbody>";

        //if (d.ICDO && d.ICDO.length > 0) {
        //    $.each(d.ICDO, function (i, item) {
        //        icdoHtml += "<tr><td style='padding:8px; border:1px solid #ddd;'>" + (item.ICDCODE || "") + "</td>" +
        //            "<td style='padding:8px; border:1px solid #ddd;'>" + (item.TOPOLOGY || "") + "</td>" +
        //            "<td style='padding:8px; border:1px solid #ddd;'>" + (item.HISTOLOGY || "") + "</td></tr>";
        //    });
        //} else {
        //    icdoHtml += "<tr><td colspan='3' style='text-align:center; padding:8px;'>No Diagnosis Data</td></tr>";
        //}
        //icdoHtml += "</tbody></table></div>";
        //$("#" + DivId).append(icdoHtml);

        // 2. Info Rows (Site, TNM, Date)
        var infoHtml = "<table style='width: 100%; margin: 10px 15px;'>" +
            //"<tr><td class='LeftLabel' style='width:15%;'>Site</td><td class='Colon'>:</td><td class='TextFld' style='width:33%;'>" + (main.SITE || "") + "</td>" +
            //"<td class='LeftLabel' style='width:15%;'>Sub-Site</td><td class='Colon'>:</td><td class='TextFld'>" + (main.SUBSITE || "") + "</td></tr>" +
            //"<tr><td class='LeftLabel'>TNM</td><td class='Colon'>:</td><td class='TextFld'>" + (main.TNM || "") + "</td>" +
            //"<td class='LeftLabel'>Stage</td><td class='Colon'>:</td><td class='TextFld'>" + (main.STAGE || "") + "</td></tr>" +
            "<tr><td class='LeftLabel'>Tumor Board Date</td><td class='Colon'>:</td><td class='TextFld'>" + (main.TBDATE || "") + "</td>" +
            "<td class='LeftLabel'>Meeting Time</td><td class='Colon'>:</td><td class='TextFld'>" + (main.TBTIME || "") + "</td></tr>" +
            "</table>";
        $("#" + DivId).append(infoHtml);

        // 3. Treatment Table
        var treatHtml = "<div class='DSMainHeaderDiv' style='margin:10px 15px;'>Type Of Treatment</div>" +
            "<div style='margin:0 15px;'><table class='table table-bordered' style='width:100%; border-collapse:collapse;'>" +
            "<thead style='background-color:#455a64; color:white;'><tr>" +
            "<th style='padding:8px;'>Treatment Name</th><th style='padding:8px;'>Treatment Details</th>" +
            "<th style='padding:8px;'>Date</th><th style='padding:8px;'>Total Cycles</th><th style='padding:8px;'>Remarks</th>" +
            "</tr></thead><tbody>";

        if (d.TREATMENT && d.TREATMENT.length > 0) {
            $.each(d.TREATMENT, function (i, item) {
                treatHtml += "<tr><td style='padding:8px; border:1px solid #ddd;'>" + item.TREATNAME + "</td>" +
                    "<td style='padding:8px; border:1px solid #ddd;'>" + item.DETAILS + "</td>" +
                    "<td style='padding:8px; border:1px solid #ddd;'>" + item.TDATE + "</td>" +
                    "<td style='padding:8px; border:1px solid #ddd;'>" + item.CYCLES + "</td>" +
                    "<td style='padding:8px; border:1px solid #ddd;'>" + item.REMARKS + "</td></tr>";
            });
        } else {
            treatHtml += "<tr><td colspan='5' style='text-align:center; padding:8px;'>No Treatment Data</td></tr>";
        }
        treatHtml += "</tbody></table></div>";
        $("#" + DivId).append(treatHtml);

        // 4. Footer Info (Liability, Genetic, Recommendations)
        var footerHtml = "<table style='width: 100%; margin: 10px 15px;'>" +
            "<tr><td class='LeftLabel' style='width:20%;'>Liability Of Result</td><td class='Colon'>:</td><td class='TextFld' style='width:28%;'>" + (main.LIABILITY || "") + "</td>" +
            (main.LIABILITY == "YES" ?
                ("<td class='LeftLabel'>No Of Actionable genetic Alterations</td><td class='Colon'>:</td><td class='TextFld'>" + (main.ALT_COUNT || "") + "</td></tr>") :
                main.LIABILITY == "NO" ?
                    ("<td class='LeftLabel'>Reason For In-Appropriate</td><td class='Colon'>:</td><td class='TextFld'>" + (main.REASON || "") + "</td></tr>")
                    : ("<td class='LeftLabel'></td><td class='Colon'></td><td class='TextFld'></td></tr>"))
            +
            "<tr><td class='LeftLabel'>Actionable genetic Alterations</td><td class='Colon'>:</td><td class='TextFld'>" + (main.GENETIC_ALT || "") + "</td>" +
            "</table>" +
            "<div style='margin:10px 15px;'><div class='LeftLabel'>Recommendations:</div>" +
            "<div style='border:1px solid #ddd; padding:10px; background:#f9f9f9; min-height:40px;'>" + (main.RECOMMENDATIONS || "") + "</div></div>" +
            "<div style='margin:10px 15px;'><div class='LeftLabel'>Final Care Plan:</div>" +
            "<div style='border:1px solid #ddd; padding:10px; background:#f9f9f9; min-height:40px;'>" + (main.CAREPLAN || "") + "</div></div>";

        $("#" + DivId).append(footerHtml);
    }
</script>


<div class="container-fluid RightMenuSlideContainer">
    <%-- Header --%>
    <div class="row DivRightMenuHeader">
        <div class="DivRightMenuHeaderLbl col-10">
            <label class="LblRightMenuHeader">Patient Clinical History</label>
        </div>
        <div class="DivRightMenuBack col-2">
            <i class="fa fa-chevron-right RightMenuBackIcon" onclick="closeRightMenu();" title="Close" aria-hidden="true"></i>
        </div>
    </div>
    <%-- Filter Content --%>
    <div class="DivRightMenuContent">
        <%-- Filter Div 1  --%>
        <div class="row FilterDiv1">
            <div class="col-12 col-md-3 col-lg-3 col-xl-2 d-flex align-items-center">
                <label for="fromDate" class="col-4 form-label me-2 mb-0">From</label>
                <input type="text" id="txtFromDate" autocomplete="off" onchange="$('#txtToDate').datepicker('option', 'minDate', $('#txtFromDate').val());" readonly class="form-control" placeholder="From date">
            </div>
            <div class="col-12 col-md-3 col-lg-3 col-xl-2 d-flex align-items-center">
                <label for="toDate" class="col-4 form-label me-2 mb-0">To</label>
                <input type="text" id="txtToDate" autocomplete="off" readonly class="form-control" placeholder="To date">
            </div>
            <div class="col-12 col-md-5 col-lg-5 col-xl-5  d-flex align-items-center">
                <label for="doctorName" class="col-4 form-label me-2 mb-0">Doctor</label>
                <select class="form-select" id="cmbDoctList">
                    <option value="" selected>All Doctor</option>
                </select>
            </div>
            <div class="col-12 col-md-1 col-lg-1 col-xl-3 d-flex align-items-center RightMenuSearchDiv">
                <i class="fa fa-search RightMenuSearchIcon" aria-hidden="true" title="Search" onclick="SearchDetails()"></i>
            </div>
        </div>
        <%-- Filter Div 2 --%>
        <div class="row FilterDiv2" id="DivFilter">
            <div class="col-12 d-flex FilterSubDiv2">
                <div class="ShowAllDiv FCheckBoxDiv">
                    <label class="MainRadioLbl">Filter</label>
                </div>
          <div class="FilterOtherOptions" id="MainFiltersLst">
     <div class="MainRadioDiv" id="DivFilterOPDPresc" onclick="HistoryDetails('O')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterOPDPrescRbt" />           <%--/*vandana 200226*/--%>
         <label class="MainRadioLbl" id="FilterOPDPresc">OPD case summary</label>
     </div>
     <div class="MainRadioDiv" id="DivFilterPAC" onclick="HistoryDetails('P')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterPACRbt" />
         <label class="MainRadioLbl" id="FilterPAC">PAC</label>
     </div>
     <div class="MainRadioDiv" id="DivFilterSurg" onclick="HistoryDetails('S')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterSurgRbt" />
         <label class="MainRadioLbl" id="FilterSurg">Surgical</label>
     </div>
     <div class="MainRadioDiv" id="DivFilterChemo" onclick="HistoryDetails('C')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterChemoRbt" />
         <label class="MainRadioLbl" id="FilterChemo">Chemo</label>
     </div>
     <div class="MainRadioDiv" id="DivFilterRadiat" onclick="HistoryDetails('R')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterRadiatRbt" />
         <label class="MainRadioLbl" id="FilterRadiat">Radiation</label>
     </div>
     <div class="MainRadioDiv" id="DivFilterProgNote" onclick="HistoryDetails('N')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterProgNoteRbt" />
         <label class="MainRadioLbl" id="FilterProgNote">Progress Note</label>
     </div>
     <div class="MainRadioDiv" id="DivFilterDischSumy" onclick="HistoryDetails('D')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterDischSumyRbt" />
         <label class="MainRadioLbl" id="FilterDischSumy">Discharge Summary</label>
     </div>
     <div class="MainRadioDiv" id="DivFilterTumorBoard" onclick="HistoryDetails('T')">
         <input type="radio" name="FilterMainSrch" class="MainRadioBtn d-none" id="FilterTumorBoardRbt" />
         <label class="MainRadioLbl" id="FilterTumorBoard">Tumor Board</label>
     </div>
 </div>
            </div>
        </div>
        <%-- Filter Div 3  --%>
        <div class="row FilterDiv3" id="FilterOPD" style="display: none">
            <div class="col-12 d-flex FilterSubDiv2">
                <div class="ShowAllDiv FCheckBoxDiv">
                    <input type="checkbox" class="Chkbox" id="AllCheck" onclick="SelectAllCheck()" />
                    <label class="ChkBoxLbl">Show All</label>
                </div>
                <div class="FilterOtherOptions">
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkCheifCompPatClinHist" onclick="FilterData('CheifCompDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkCheifCompPatClinHist');FilterData('CheifCompDispYN', 'chkCheifCompPatClinHist')">Complaints</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkGeneralExamPatClinHist" onclick="FilterData('GenExamDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkGeneralExamPatClinHist');FilterData('GenExamDispYN', 'chkGeneralExamPatClinHist')">Vital Data</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkHistoryPatClinHist" onclick="FilterData('HistoryDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkHistoryPatClinHist');FilterData('HistoryDispYN', 'chkHistoryPatClinHist')">History</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkDiagnosisPatClinHist" onclick="FilterData('DiagnosisDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkDiagnosisPatClinHist');FilterData('DiagnosisDispYN', 'chkDiagnosisPatClinHist')">Diagnosis</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkOnExamPatClinHist" onclick="FilterData('OnExamDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkOnExamPatClinHist');FilterData('OnExamDispYN', 'chkOnExamPatClinHist')">Examination</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkMedRxPatClinHist" onclick="FilterData('RxDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkMedRxPatClinHist');FilterData('RxDispYN', 'chkMedRxPatClinHist')">Rx</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkAdvInvstPatClinHist" onclick="FilterData('AdvInvstDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkAdvInvstPatClinHist');FilterData('AdvInvstDispYN', 'chkAdvInvstPatClinHist')">Investigations / Procedures</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkRAdvicePatClinHist" onclick="FilterData('InstructDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkRAdvicePatClinHist');FilterData('InstructDispYN', 'chkRAdvicePatClinHist')">Instructions</label>
                    </div>
                    <%--priyanka 15/04/2026--%>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkAdvicesPatClinHist" onclick="FilterData('AdviceDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkAdvicesPatClinHist');FilterData('AdviceDispYN', 'chkAdvicesPatClinHist')">Advice</label>
                    </div>
                    <div class="FCheckBoxDiv">
                        <input type="checkbox" name="AllCheck" class="Chkbox" id="chkClinicalNtPatClinHist" onclick="FilterData('OnClinicalNtDispYN', this.id)" />
                        <label class="ChkBoxLbl" onclick="CheckedBox('chkClinicalNtPatClinHist');FilterData('OnClinicalNtDispYN', 'chkClinicalNtPatClinHist')">Clinical Notes</label>
                    </div>
                    <%--End--%>
                </div>
            </div>
        </div>
    </div>
    <%-- Content Data --%>
    <%--    <div id="MainDiv">
        <div id="tbldiv"></div>
    </div>--%>

    <div id="divOPDPrescInfo" class="MainsDiv" style="display: none;">
        <div id="OPDPrescContentHolderDiv">
            <div id="tbldiv">
            </div>
        </div>
    </div>

    <div id="divPACInfo" class="MainsDiv"  style="display: none;">
        <div id="PACContentHolderDiv">
            <div id="tblPACdiv">
            </div>
        </div>
    </div>

    <div id="divSurgInfo" class="MainsDiv"  style="display: none;">
        <div id="SurgeryContentHolderDiv">
            <div id="tblSurgerydiv">
            </div>
        </div>
    </div>

    <div id="divChemoInfo" class="MainsDiv"  style="display: none;">
        <div id="ChemoContentHolderDiv">
            <div id="tblChemodiv">
            </div>
        </div>
    </div>

    <div id="divRadiationInfo" class="MainsDiv"  style="display: none;">
        <div id="RadiationContentHolderDiv">
            <div id="tblRadiationdiv">
            </div>
        </div>
    </div>

    <div id="divClinicInfo"  class="MainsDiv" style="display: none;">
        <div id="ClinicContentHolderDiv">
            <div id="tblClinicdiv">
            </div>
        </div>
    </div>

    <div id="divDiscSumyInfo" class="MainsDiv"  style="display: none;">
        <div id="DiscSumyContentHolderDiv">
            <div id="tblDiscSumydiv">
            </div>
        </div>
    </div>
    <div id="divTumorInfo" class="MainsDiv"  style="display: none;">
    <div id="TumorContentHolderDiv">
        <div id="tblTumorBoard">
        </div>
    </div>
</div>

</div>
