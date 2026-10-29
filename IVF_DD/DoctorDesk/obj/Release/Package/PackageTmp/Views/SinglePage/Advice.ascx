<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>


<style>
    /* Orange urgency pill */
    .urgency-pill {
        background-color: #f58220;
        color: #fff;
        border: none;
        width: 110px;
    }

        .urgency-pill option {
            color: #000;
        }

    /* Book Appointment button */
    .book-btn {
        height: 34px;
        padding: 0 16px;
        border-radius: 8px;
        border: 1px solid #28a745;
        background-color: transparent;
        color: #1c7c36;
        font-weight: 600;
        font-size: 14px;
        cursor: pointer;
    }
    /* Exact Colors from Screenshot */
    .text-custom-blue {
        color: #3b5998 !important;
    }

    .border-custom-blue {
        border-color: #3b5998 !important;
    }

    .text-custom-orange {
        color: #d97706 !important;
    }

    .bg-custom-orange {
        background-color: #d97706 !important;
    }

    .section-title {
        color: #1e5631;
        font-weight: bold;
    }

    /* Circular Blue Checkbox Style for Admission Advice */
    #AdmissionAdvice.form-check-input {
        width: 18px;
        height: 18px;
        border-radius: 50%;
        border: 2px solid #3b5998;
        cursor: pointer;
    }

        #AdmissionAdvice.form-check-input:checked {
            background-color: #3b5998;
            border-color: #3b5998;
            background-image: none; /* Solid dot look */
        }

    /* Orange Dropdown Styling */
    .urgency-select {
        background-color: #d97706 !important;
        color: white !important;
        font-weight: bold;
        border: none;
        border-radius: 4px;
        padding: 2px 30px 2px 12px;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='white' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 8px center;
        background-size: 12px;
        appearance: none;
    }

    .mb-20px {
        margin-bottom: 20px !important;
    }

    .fa-trash {
        color: #dc3545; /* Bootstrap Red */
        transition: transform 0.2s;
    }

        .fa-trash:hover {
            transform: scale(1.1);
            color: #a71d2a;
        }

    #Advice_txtAdviceSurgery[readonly] {
        background-color: #e9ecef; /* light gray */
        cursor: not-allowed;
    }

    #Advice_rbtnNatSurgR.form-check-input:checked {
        background-color: #ce9504;
        border-color: #ce9504;
        background-image: none;
    }

    #Advice_rbtnNatSurgR.form-check-input {
        width: 18px;
        height: 18px;
        border-radius: 50%;
        border: 2px solid #ce9504;
        cursor: pointer;
    }

    #Advice_rbtnNatSurgE.form-check-input:checked {
        background-color: #ff0b0b;
        border-color: #ff0b0b;
        background-image: none;
    }

    #Advice_rbtnNatSurgE.form-check-input {
        width: 18px;
        height: 18px;
        border-radius: 50%;
        border: 2px solid #ff0b0b;
        cursor: pointer;
    }

    textarea {
        box-sizing: border-box;
    }
</style>

<script>
    <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var CareTypeLst = JSON.parse('<%:Html.Raw(Samp.Serialize(ViewBag.CareTypeList))%>');
    var DoctList = [];
    var NoteList = [];
    var SavedList = [];
    var surgeryDescriptions = [];
    var RMOFlagAdviceYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEADVICEYN")%>' == "Y" ? "N" : "Y") : "N";
    var IsLevelOfUrgencyMandatory = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("IsLevelOfUrgencyMandatory")%>';
    var ShowSOSYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("SHOWSOSYN")%>';
    var SessionCompAdvice = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagAdviceYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');
    var advicesurgerylisttable;
    var CrystalRptPrintFunction = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CRYSTALRPTPRINTFILENAME")%>';
    var HideTimeAndBookAppointment = '<%: OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("HidePrefTimeAndBookAppoinment") %>';


    function ShowTempPresciptionPrint() {
        if (ShowTempPrescPrint === "Temp1") {

        }
    }

    function SetPACOnOrBeforeDate() {
        //var TDate = $("#Advice_txtSurgeryAdvDate").val();
        //var parts = TDate.split("/");
        //var dateObj = new Date(parts[2], parts[1] - 1, parts[0]);
        //var dd = ("0" + dateObj.getDate()).slice(-2);
        //var mm = ("0" + (dateObj.getMonth() + 1)).slice(-2);
        //var yyyy = dateObj.getFullYear();
        //var formattedDate = dd + "/" + mm + "/" + yyyy;
        //HandlePACAdvDate(formattedDate);
        var TDate = $("#Advice_txtSurgeryAdvDate").val();
        if (TDate) {
            var parts = TDate.split("/");
            var maxDate = new Date(parts[2], parts[1] - 1, parts[0]);
            $("#Advice_txtPACobDate").datepicker("option", "maxDate", maxDate);
        } else {
            $("#Advice_txtPACobDate").datepicker("option", "maxDate", null);
        }
    }

    //History Popup
    function HistPopAdviceHistTemp(AllHistoryData) {
        var ConsultLst = AllHistoryData[0] || [];
        var AdviceData = AllHistoryData[8] || [];
        var container = '<div class="history-list-wrapper">';
        function createRow(label, value) {
            if (!value) return "";
            return '<div style="display:flex;margin-bottom:4px;">' +
                '<div style="width:160px;font-weight:600;">' + label + '</div>' +
                '<div style="margin-right:6px;">:</div>' +
                '<div style="flex:1;">' + value + '</div>' +
                '</div>';
        }

        for (var i = 0; i < ConsultLst.length; i++) {

            var consult = ConsultLst[i];
            var ConsultNo = consult.TRANNO;
            if (!ConsultNo) continue;

            var filtered = AdviceData.filter(function (a) {
                return a.TRANNO === ConsultNo;
            });

            if (filtered.length === 0) continue;

            var docName = consult.DOCTNAME || "General Consultation";
            var specName = consult.SPECNAME ? " (" + consult.SPECNAME + ")" : "";
            var dateInfo = consult.TRANDATE + " " + ConvertTo12Hour("O", consult.TRANTIME);

            container +=
                '<div class="History-section mb-3 shadow-sm border">' +
                '<div class="History-header bg-light p-2 border-bottom">' +
                '<div style="line-height:1.2;">' +
                '<div class="History-header-title font-weight-bold">' +
                'Dr. ' + docName + specName +
                '</div>' +
                '<small>' + dateInfo + '</small>' +
                '</div>' +
                '</div>' +
                '<div class="History-body p-2">';

            for (var j = 0; j < filtered.length; j++) {

                var adv = filtered[j];

                container +=
                    '<div style="border:1px solid #ccc;padding:10px;border-radius:6px;background:#fafafa;margin-bottom:10px;">' +
                    createRow("Transaction No.", adv.TRANNO) +
                    createRow("Transaction Date", adv.TRANDATE) +
                    createRow("Transaction Time", adv.TRANTIME) +
                    createRow("Doctor Name", adv.DOCTNAME) +

                    createRow("Follow-up Date", adv.FOLLOWUPDT) +
                    createRow("Surgery Advice", adv.SURGNMADVICE) +
                    createRow("Surgery Description", adv.SURGADVICEOTHER) + // Abhishesh || 20260819
                    createRow("Refer To Specialist", adv.REFSPECIALIST) +
                    createRow("Prescription Remarks", adv.PRESCREMARK) +
                    createRow("Plan of Treatment", adv.PLANOFTREAT) +

                    createRow("Admission Advised", adv.ADMNADVYN === "Y" ? "Yes" : "No") +
                    createRow("Proposed Admission Date", adv.PROPADMNDT) +

                    createRow("Appointment Date", adv.APPMNTDT) +
                    createRow("Appointment Time", adv.APPMNTTM) +

                    createRow("Refer to Tumor Board", adv.TBDREFYN === "Y" ? "Yes" : "No") +
                    createRow("Surgery Advice Date", adv.SURGADVDATE) +
                    createRow("PAC Advice Date", adv.PACADVDATE) +

                    '</div>';
            }
            container += '</div>' + '</div>';
        }
        return container + '</div>';
    }

    function GetBindingDataForSelectedPrint(RedrtToWaitLst = "") {
        var isAnyChecked =
            $("#chkComplaint").prop("checked") ||
            $("#chkDiagnosis").prop("checked") ||
            $("#chkExamin").prop("checked") ||
            $("#chkClinicalNotes").prop("checked") ||
            $("#chkVital").prop("checked") ||
            $("#chkPlanOfTreatmnt").prop("checked") ||
            $("#chkRemark").prop("checked") ||
            $("#chkInvest").prop("checked") ||
            $("#chkRx").prop("checked") ||
            $("#chkAdvice").prop("checked") ||
            $("#chkPersHist").prop("checked") ||
            $("#chkMedHist").prop("checked") ||
            $("#chkFamHist").prop("checked") ||
            $("#chkallergy").prop("checked") ||
            $("#chkInstru").prop("checked")

        if (!isAnyChecked) {
            ToastMsg("Please select at least one option to print.", "warning");
            return false;
        }
        if (CrystalRptPrintFunction && CrystalRptPrintFunction.trim() !== "") {
            GetBindingDataForCrystalPrint(RedrtToWaitLst);
        }
        else {
            startLoading("Loading", "loading-SelectListForPrint");
            var mrNo = sessionStorage.getItem('PatMRNO');
            var vartranno = sessionStorage.getItem('PatTRANNO');
            var datatosend = {
                tranno: vartranno,
                language: "" + "NAME",
                type: 'L',
                MrNo: mrNo,
            }
            digitsign1 = "";
            digitsign2 = "";
            digitsign3 = "";
            sign1 = "";
            sign2 = "";
            sign3 = "";
            var Html = "", HtmlTopData = "";
            $.ajax({
                type: "Post",
                url: "../DoctorDesk/GetDoctorDeskData",
                data: datatosend,
                async: true,
                success: function (response) {
                    infotomail = "", infotomail2 = "";
<%--                    var PresDoctCode = '<%:Session["gDoctCode"]%>';
                    GetDoctSignature(PresDoctCode);--%>
                    GridData = response;
                    if (GridData.jsonDoctorDetails.length > 0)
                        GetDoctSignature(GridData.jsonDoctorDetails[0].DOCTCODE);
                    if (PrecriptionPrintTemp && PrecriptionPrintTemp.trim() === "1") {
                        Html = PrintData1("");
                    } else {
                        Html = PrintData(vartranno, mrNo);
                    }
                    HtmlTopData = PrintPatInfo1(vartranno);
                    infotomail = Html;
                    infotomail2 = HtmlTopData;
                    $("#Advice_btnAdvicePrint").attr('disabled', true);
                    openWin(Html, HtmlTopData);
                    GridData = "";
                    stopLoading("loading-SelectListForPrint");
                    if (RedrtToWaitLst == "Y")
                    {
                        window.location.href = "../SinglePage/WaitingListOPD";
                    }

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    ToastMsg("Error : " + textStatus + ".", "error");
                    stopLoading("loading-SelectListForPrint");
                }
            });
        }
    }
    function GetBindingDataForCrystalPrint(RedrtToWaitLst) {
        startLoading("Loading", "loading-SelectListForPrint");
        var mrNo = sessionStorage.getItem('PatMRNO');
        var tranNo = sessionStorage.getItem('PatTRANNO');
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/PrintPrescriptionNew",
            data: {
                TranNo: tranNo,
                MrNo: mrNo,
                VitalsYN: $("#chkVital").prop("checked") ? "Y" : "N",
                DiagnosisYN: $("#chkDiagnosis").prop("checked") ? "Y" : "N",
                ComplaintYN: $("#chkComplaint").prop("checked") ? "Y" : "N",
                InvestigationYN: $("#chkInvest").prop("checked") ? "Y" : "N",
                RxYN: $("#chkRx").prop("checked") ? "Y" : "N",
                AdviceYN: $("#chkAdvice").prop("checked") ? "Y" : "N"
            },
            success: function (response) {
                if (response == "success") {
                    window.open(
                        "../DoctorDesk/DisplayPrescription",
                        "_blank"
                    );
                }
                if (RedrtToWaitLst == "Y") {
                    window.location.href = "../SinglePage/WaitingListOPD";
                }
                stopLoading("loading-SelectListForPrint");
            },
            error: function () {
                stopLoading("loading-SelectListForPrint");
                ToastMsg("Error while generating report.", "error");
            }
        });
    }


    //function GetDoctSignature(StrDoctCode) {
        
    //    var datatosend = {
    //        strdoctcode: StrDoctCode
    //    }
    //    $.ajax({
    //        type: "Post",
    //        url: "../DoctorDesk/GetSignatory",
    //        data: datatosend,
    //        async: false,
    //        success: function (response) {
    //            var data = JSON.parse(response);
    //            if (data.length > 0) {
    //                if (data[0]["SIGN"] != "") {
    //                    sign1 = "" + data[0]["SIGN"];
    //                }
    //                if (data[0]["DIGSIGN1"] != "") {
    //                    digitsign1 = "data:image/jpeg;base64," + data[0]["DIGSIGN1"];
    //                }
    //                if (data[0]["SIGN2"] != "") {
    //                    sign2 = "" + data[0]["SIGN2"];
    //                }
    //                if (data[0]["DIGSIGN2"] != "") {
    //                    digitsign2 = "data:image/jpeg;base64," + data[0]["DIGSIGN2"];
    //                }
    //                if (data[0]["SIGN3"] != "") {
    //                    sign3 = "" + data[0]["SIGN3"];
    //                }
    //                if (data[0]["DIGSIGN3"] != "") {
    //                    digitsign3 = "data:image/jpeg;base64," + data[0]["DIGSIGN3"];
    //                }
    //            }

    //        },
    //        error: function (jqXHR, textStatus, errorThrown) {
    //        }
    //    });
    //}

    function openWin(HTML, HtmlTopData) {
        Html = HTML;
        HtmlTop = HtmlTopData;
        OKbutton();
    }


    function OKbutton() {
        var Mrno = sessionStorage.getItem('PatMRNO');
        var datatosend = {
            printdata: encodeURIComponent(Html),
            TranNo: sessionStorage.getItem('PatTRANNO'),
            Mrno: Mrno,
            printdataTop: encodeURIComponent(HtmlTop)
        };
        startLoading("Loading", "loading-SelectListForPrint");
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/PrintPrescription",
            async: true,
            data: datatosend,
            dataType: "json",
            success: function (response) {
                if (response == "Success") {
                    $("#Advice_btnAdvicePrint").removeAttr('disabled');
                    var url = '../DoctorDesk/DisplayPrintTemplate?FormName=' + sessionStorage.getItem('PatName').toString();
                    var win = window.open(url, '', 'width=' + screen.availWidth + ',height=' + screen.availHeight);  //'width=1024, height=700');  //Pournima changed default width and height to screen.avail on 4th july 2026
                    win.document.close();
                    win.focus();
                    stopLoading("loading-SelectListForPrint");
                }
            },
            error: function () {
                stopLoading("loading-SelectListForPrint");
            }
        });
    }

    function NotOKbutton() {
        window.location.href = '../DoctorDesk/RxNewSearch';
    }

    function fitToContent(id) {
        var textArea = document.getElementById(id);
        textArea.style.height = 'auto';
        var newHeight = Math.ceil(textArea.scrollHeight);
        textArea.style.height = Number(newHeight) < 100 ? '100px' : (newHeight + 'px');
        textArea.style.overflow = 'hidden';
    }

    function setMaxHeight(id) {
        var textArea = document.getElementById(id);
        textArea.style.height = '400px';
        textArea.style.overflowY = 'auto';
    }

    function fetchDropdownData() {
        $.ajax({
            url: '../SinglePage/GetSurgryCatg',
            method: 'GET',
            async: true,
            success: function (response) {
                var data = typeof response === "string"
                    ? JSON.parse(response)
                    : response;

                var $ddl = $("#SurgeryCatgList");
                $ddl.empty();
                $ddl.append('<option value="">-- All Categories --</option>');

                if (Array.isArray(data)) {
                    data.forEach(function (item) {
                        $ddl.append(
                            '<option value="' + item.Value + '">' +
                            item.Text +
                            '</option>'
                        );
                    });
                }
            }
        });
    }

    function GetAllSurgeryList() {
        $.ajax({
            url: '../SinglePage/GetSurgeryList',
            async: true,
            success: function (response) {
                surgeryDescriptions = typeof response === "string" ? JSON.parse(response) : response;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
    }

</script>

<script>
    $(document).ready(function () {
        if (HideTimeAndBookAppointment === "Y") {
            $("#Advice_txtAppointmntTime").hide();
            $("#Advice_anchorBookAppmnt").hide();
            $("#Advice_Preferredtimelabel").hide();
        }
        else {
            $("#Advice_txtAppointmntTime").show();
            $("#Advice_anchorBookAppmnt").show();
            $("#Advice_Preferredtimelabel").show();
        } 
        var isVisitCompleted = (typeof SessionCompAdvice !== 'undefined' && SessionCompAdvice === "Y");
        advicesurgerylisttable = new Tabulator("#Advice_SurgeryAdvTbl", {
            layout: "fitColumns",
            scrollToRowPosition: "nearest",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            //height: "400",
            index: "code",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "Action",
                    field: "act",
                    width: 80,
                    headerSort: false,
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagAdviceYN != "Y";
                    },
                    formatter: function (cell) {
                        if (typeof SessionCompAdvice !== 'undefined' && SessionCompAdvice === "Y") {
                            return "";
                        }
                        return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagAdviceYN != "Y") {
                            cell.getRow().delete();
                            //adjustTableHeight("Advice_SurgeryAdvTbl");
                        }
                    }
                },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    width: 1206,
                    formatter: "textarea",
                    formatterParams: {
                        minHeight: "auto",
                    },
                    cssClass: "wrap-text"
                }
            ]
        });

        advicesurgerylisttable.on("rowAdded", function (row) {
            //row.normalizeHeight();
            //adjustTableHeight("Advice_SurgeryAdvTbl");
            $("#Advice_NatureOfSurgeDivMain").removeClass("d-none");
            $("#SurgAdvice_FreetextDivMain").removeClass("d-none");
        });

        advicesurgerylisttable.on("rowDeleted", function (row) {
            //adjustTableHeight("Advice_SurgeryAdvTbl");
            if (advicesurgerylisttable.getRows().length === 0) {
                $("#Advice_txtSurgeryAdvDate").val("");
                $("#Advice_txtPACobDate").val("");
                $("input[name='NatureOfSurgery']").prop("checked", false);
                $("#Advice_NatureOfSurgeDivMain").addClass("d-none");
                $("#SurgAdvice_FreetextDivMain").addClass("d-none");
                $("#SurgAdvice_Freetext").val("");
            }
        });

        advicesurgerylisttable.on("dataLoaded", function () {
            //adjustTableHeight("Advice_SurgeryAdvTbl");
        });

        advicesurgerylisttable.on("tableBuilt", function () {
            //adjustTableHeight("Advice_SurgeryAdvTbl");
        });

        advicesurgerylisttable.on("dataChanged", function () {
            //adjustTableHeight("Advice_SurgeryAdvTbl");
        });

    });

    function getSelectedSurgeryData() {
        var rows = advicesurgerylisttable.getData();
        var codes = rows.map(function (row) { return row.code; }).join(',');
        var names = rows.map(function (row) { return row.name; }).join('\n');
        return {
            codes: codes,
            names: names
        };
    }

    function BindSavedAdviceSurgeryData(data) {
        advicesurgerylisttable.clearData();
        var codes = data["SURGNMADVICECODE"] ? data["SURGNMADVICECODE"].split(',') : [];
        var names = data["SURGNMADVICE"] ? data["SURGNMADVICE"].split('\n') : [];
        for (var i = 0; i < codes.length; i++) {
            var code = codes[i].trim();
            var name = names[i] ? names[i].trim() : "";
            if (code && name) {
                advicesurgerylisttable.addRow({
                    act: '<i class="fa fa-trash text-danger"></i>',
                    code: code,
                    name: name
                }).then(function (row) {
                    row.normalizeHeight();
                    //adjustTableHeight("Advice_SurgeryAdvTbl");
                });
            }
        }
        if ($("#AdviceSurgeryList").length > 0) {
            $(".SurgAdv-checkbox").each(function () {
                var checkbox = $(this);
                var c = checkbox.data("code");
                if (codes.includes(c)) {
                    checkbox.prop("checked", true);
                }
            });
        }
    }

</script>

<script type="text/javascript">
    var DefaultPrintOption = '<%: OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DEFAULTPRINTOPTION") %>';
    $(document).ready(function () {

        $("input[name='PrintOption']").prop("checked", false);

        if (!DefaultPrintOption || $.trim(DefaultPrintOption) === "") {
            return;
        }


        $.each(DefaultPrintOption.split(','), function (i, value) {
            value = $.trim(value);

            if (value !== "") {
                $("input[name='PrintOption'][value='" + value + "']").prop("checked", true);
            }
        });

    });
</script>


<script type="text/javascript">
    $(document).ready(function () {
        $("input[type='text']").attr("autocomplete", "off");
        if (ShowSOSYN == "Y") {
            $("#SOSDivMain").show();
        }
        if (RaditionRights) {
            $("#TreatAdvTypeRDiv").removeClass("d-none");
        }
        if (MedicalRights) {
            $("#RbtnTreatAdvTypeR").prop("checked", false);
            $("#RbtnTreatAdvTypeP").prop("checked", false);
            $("#RbtnTreatAdvTypeM").prop("checked", true);
        }
        $("#btnADVRemarkFittoContent2").on("click", function () {
            fitToContent('Advice_txtPrescriptionRemark');
        });
        $("#btnADVRemarkSetMaxHeight2").on("click", function () {
            setMaxHeight('Advice_txtPrescriptionRemark');
        });

        $("#btnADVPlanTreatFittoContent2").on("click", function () {
            fitToContent('Advice_PlanOfTreatmnt');
        });
        $("#btnADVPlanTreatSetMaxHeight2").on("click", function () {
            setMaxHeight('Advice_PlanOfTreatmnt');
        });

        //Pournima 18th Aug 2026  
        $("#btnADVSurgeryFittoContent2").on("click", function () {
            fitToContent('SurgAdvice_Freetext');
        });
        $("#btnADVSurgerySetMaxHeight2").on("click", function () {
            setMaxHeight('SurgAdvice_Freetext');
        });
        if (sessionStorage.getItem("PatCompleted").toString() === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagAdviceYN == "Y") {
            $("#sec-advice *").attr("disabled", "disabled");
            $("#Advice_AddOncologistMainDiv *").attr("disabled", "disabled");
            $("#Advice_HistIcon").removeAttr("disabled");
            if (sessionStorage.getItem("PatCompleted").toString() === "Y") {
                $("#SelectListToPrintSection *").removeAttr("disabled");
                $("#SelectListToPrintSection").removeClass("d-none");
            }
            else {
                $("#SelectListToPrintSection").addClass("d-none");
            }
        }
        else {
            $("#sec-advice *").removeAttr("disabled");
            $("#SelectListToPrintSection").addClass("d-none");
        }

        //var $ddl = $("#ddlAdviceNumber");
        //for (var i = 0; i <= 30; i++) {
        //    $ddl.append($("<option></option>").val(i).text(i));
        //}
        //$ddl.val(0);
        $("#ddlAdviceNumber").val("0");

        $("#Advice_txtAppointmntDate").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),
        });
        $("#Advice_txtPACobDate").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),   // today
        });
        $("#Advice_txtSurgeryAdvDate").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),
        });

        $("#Advice_txtProposeAdmnDT").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),
        });

        $("#Advice_txtAppointmntDate").change(function () {
            var strDate = $("#Advice_txtAppointmntDate").val();
            var NumWeekday = new Date().getDay() + 1;
            var varclicniccode = "";
            var vardoctorcode = '<%:Session["gDoctCode"]%>';
            var getSearchDate = strDate;
            var SearchDate = getSearchDate.substring(10, 6) + getSearchDate.substring(5, 3) + getSearchDate.substring(0, 2);
            if (vardoctorcode != "") {
                $.ajax({
                    async: false,
                    url: '../DoctorDesk/GetDoctorAval',
                    data: { CLINICCODE: varclicniccode, DOCTORCODE: vardoctorcode, SEARCHDATE: SearchDate, NumWeekday: NumWeekday, Searchwise: "DAY" },
                    dataType: "json",
                    success: function (response) {
                        if (response > 0) {
                            ToastMsg("Doctor not available today as per schedule or on leave.", "info");
                            $("#Advice_txtAppointmntDate").val("");
                            $("#Advice_txtAppointmntTime").empty();
                            $('#Advice_txtAppointmntTime').append($("<option>--Preferred Time--</option>"));
                        }
                        else {
                            $.ajax({
                                url: '../DoctorDesk/GetAppointmnentSlots',
                                type: "post",
                                datatype: "json",
                                data: { strDate: $("#Advice_txtAppointmntDate").val() },
                                success: function (response) {
                                    $("#Advice_txtAppointmntTime").empty();
                                    if (response != "") {
                                        $('#Advice_txtAppointmntTime')
                                            .append($("<option>--Preferred Time--</option>"));
                                        $.each(response, function (key, value) {
                                            $('#Advice_txtAppointmntTime')
                                                .append($("<option></option>")
                                                    .attr("value", value.SLOTNO)
                                                    .text(value.Slot));
                                            $('#Advice_txtAppointmntTime').css('border', '2px solid green');
                                        });
                                    }
                                    else {
                                        $('#Advice_txtAppointmntTime').append($("<option>--Preferred Time--</option>"));
                                        $('#Advice_txtAppointmntTime').css('border', '2px solid red');
                                    }
                                }
                            });
                        }
                    }
                });
            }
            ReverseCalculateDays(strDate);
        });

        $(document).on("change", ".RefToSpcl-checkbox", function () {
            var textarea = $("#Advice_txtReferToSpcl");
            var labelText = $(this).data("name");
            var currentItems = textarea.val().trim() ? textarea.val().split(/\s*,\s*/) : [];
            if ($(this).is(":checked")) {
                if (currentItems.indexOf(labelText) === -1) {
                    currentItems.push(labelText);
                }
            } else {
                currentItems = currentItems.filter(function (item) {
                    return item !== labelText;
                });
            }
            textarea.val(currentItems.join(", "));
            autoResizeTextareaForSinglePage(textarea[0]);
        });

        $(document).on("change", ".SurgAdv-checkbox", function () {
            var checkbox = $(this);
            var code = checkbox.data("code");
            var name = checkbox.data("name");
            if (checkbox.is(":checked")) {
                if (!advicesurgerylisttable.getData().some(r => r.code === code)) {
                    advicesurgerylisttable.addRow({
                        act: '<i class="fa fa-trash text-danger"></i>',
                        code: code,
                        name: name
                    }).then(function (row) {
                        row.normalizeHeight();
                        //adjustTableHeight("Advice_SurgeryAdvTbl");
                    });
                } else {
                    ToastMsg("Surgery Advice already added", "warning");
                    checkbox.prop("checked", true);
                }
            } else {
                var row = advicesurgerylisttable.getRows().find(r => r.getData().code === code);
                if (row) {
                    row.delete();
                }
            }
            if (advicesurgerylisttable.getRows().length >= 1) {
                $("#Advice_NatureOfSurgeDivMain").removeClass("d-none");
                $("#SurgAdvice_FreetextDivMain").removeClass("d-none");
                //Abhishesh || 20260820
                if ($("input[name='NatureOfSurgery']:checked").length === 0) {
                    $("#Advice_rbtnNatSurgR").prop("checked", true);
                }
                //End
            }
            else {
                $("#Advice_rbtnNatSurgR").prop("checked", false);
                $("#Advice_rbtnNatSurgE").prop("checked", false);
                $("#Advice_NatureOfSurgeDivMain").addClass("d-none");
                $("#Advice_txtSurgeryAdvDate").val("");
                $("#Advice_txtPACobDate").val("");
                $("input[name='NatureOfSurgery']").prop("checked", false);
                $("#SurgAdvice_FreetextDivMain").addClass("d-none");
                $("#SurgAdvice_Freetext").val("");
            }
        });

        $(document).on("change", ".CrossRefDoctor-checkbox", function () {
            var textarea = $("#Advice_txtAdviceCrossRefDoct");
            var labelText = $(this).data("name");
            var currentItems = textarea.val().trim() ? textarea.val().split(/\s*,\s*/) : [];
            if ($(this).is(":checked")) {
                if (currentItems.indexOf(labelText) === -1) {
                    currentItems.push(labelText);
                }
            } else {
                currentItems = currentItems.filter(function (item) {
                    return item !== labelText;
                });
            }
            textarea.val(currentItems.join(", "));
            autoResizeTextareaForSinglePage(textarea[0]);
        });

        $("#Advice_anchorBookAppmnt").click(function () {
            var strApptmntDate = $("#Advice_txtAppointmntDate").val();
            var strSlotNo = $("#Advice_txtAppointmntTime").val();
            var strApptmntTime = $("#Advice_txtAppointmntTime option:selected").text();
            var patName = sessionStorage.getItem('PatName').split('(')[0].trim()
            var patAge = sessionStorage.getItem('PatAge');
            var patGender = sessionStorage.getItem('PatGender');
            var patMobile = sessionStorage.getItem('OPDPatMobile');
            var mrNo = sessionStorage.getItem('PatMRNO');
            var tranno = sessionStorage.getItem('PatTRANNO');
            var numberofdays = $("#ddlAdviceNumber").val();
            var daySelected = $("#Advice_DaySelect").val();
            var surgeryData = getSelectedSurgeryData();
            if (strApptmntDate == "" || strApptmntTime == "--Preferred Time--") {
                ToastMsg("Please select Appointment Date and Time", "info");
                return;
            }
            var refDoctName = $("#Advice_txtAdviceCrossRefDoct").val();
            var strRefClinicName = $("#Advice_txtReferToSpcl").val();
            var strSurgAdvice = surgeryData.names;
            $.ajax({
                url: '../DoctorDesk/BookAppoinment',
                data: {
                    AppmntDate: strApptmntDate, AppmntTime: strApptmntTime, strSlotNo: strSlotNo, patName: patName, patAge: patAge, patGender: patGender,
                    patMobile: patMobile, mrNo: mrNo, tranno: tranno, refDoctName: refDoctName, SurgyAdvice: strSurgAdvice, RefCliniName: strRefClinicName,
                    Number: numberofdays, DaySelected: daySelected
                },
                type: 'post',
                datatype: 'json',
                async: false,
                success: function (response) {
                    ToastMsg(response, "info");
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        $("#Advice_appnmtDiv *").attr("disabled", "disabled");
                        $("#Advice_anchorBookAppmnt").off('click');
                        $("#Advice_appnmtShowDiv").removeClass("d-none");
                        $("#Advice_appnmtShowDiv").addClass("d-flex");
                        $("#Advice_appmntStringDisplay").text("Your appointment is booked on " + strApptmntDate + " at " + strApptmntTime);
                        if (strApptmntDate != "" && strApptmntTime != "") {
                            $("#SOSDivMain").css('margin-left', '10px');
                        }
                        $("#Advice_appnmtDiv").addClass("d-none");
                        $("#Advice_lblFollowupDiv").addClass("d-none");
                        $("#Advice_Number").addClass("d-none");
                        $("#Advice_DaySelectDiv").addClass("d-none");
                    }
                    else {
                        $("#Advice_txtAppointmntDate").removeAttr("disabled", "disabled");
                        $("#Advice_txtAppointmntTime").removeAttr("disabled", "disabled");
                    }
                },
                complete: function () { },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                }
            })
        });

        $("#SurgeryCatgList").change(function () {
            GetSurgeryList();
        });

        $(document).on("click", "#btnClearSurgeryDate", function () {
            $("#Advice_txtSurgeryAdvDate").val("");
        });

        $(document).on("click", "#btnClearPACDate", function () {
            $("#Advice_txtPACobDate").val("");
            $("#Advice_txtPACobDate").datepicker("option", "maxDate", null);
        });

        $("#btnSelectAll").on("click", function () {
            $("#SelectListToPrintSection input[type='checkbox']")
                .prop("checked", true);
        });

        $("#btnClearAll").on("click", function () {
            $("#SelectListToPrintSection input[type='checkbox']")
                .prop("checked", false);
        });

        GetAllSurgeryList();
        fetchDropdownData();

        if (SurgicalRights || RaditionRights) {
            LoadSchemePartialView(function () {
                SetDataForPrescriptionPrint();
            });
        }
        else {
            SetDataForPrescriptionPrint();
        }
    });

    function HideUnHideSurgDiv(strSurCodes) {
        if (ShowAdvSurgerySection == "Y" || SurgicalRights) {
            $("#SurgeryAdviceDivMain").removeClass("d-none");
            $("#SurgAdvice_FreetextDivMain").removeClass("d-none");
        }
        else {
            $("#SurgeryAdviceDivMain").addClass("d-none");
            $("#SurgAdvice_FreetextDivMain").addClass("d-none");
            $("#SurgAdvice_Freetext").val("");
        }
        if (strSurCodes == "") {
            $("#Advice_NatureOfSurgeDivMain").addClass("d-none");
            $("#Advice_rbtnNatSurgR").prop("checked", false);
            $("#Advice_rbtnNatSurgE").prop("checked", false);
            $("#Advice_txtSurgeryAdvDate").val("");
            $("#Advice_txtPACobDate").val("");
            $("input[name='NatureOfSurgery']").prop("checked", false);
            $("#SurgAdvice_FreetextDivMain").addClass("d-none");
            $("#SurgAdvice_Freetext").val("");
        }
    }

    function SetDataForPrescriptionPrint() {
        var patcompletedyn = sessionStorage.getItem("PatCompleted").toString();
        var tranNo = sessionStorage.getItem("PatTRANNO");
        $.ajax({
            url: '../DoctorDesk/SetDataForPrescriptionPrint',
            type: 'post',
            async: true,
            datatype: 'json',
            data: { strTranNo: tranNo },
            success: function (data) {
                var TempAdvScheme = "";
                if (data) {
                    $("#Advice_txtAdviceCrossRefDoct").val(data["REFDOCTNAME"].toString());
                    $("#ddlAdviceNumber").val(Number(data["DURATION"]));
                    $("#Advice_DaySelect").val(data["DURATIONTYPE"].toString());
                    $("#hdnDoctCode").val(data["REFDOCTNAME"].toString());
                    if (data["DURATIONTYPE"].toString() == "SOS") {
                        $('#lblSOS').css("background-color", "green");
                        $("#ddlAdviceNumber").val(0);
                        $("#Advice_DaySelect").val("Days");
                    }
                    else {
                        $('#lblSOS').css("background-color", "#5bc0de");
                        $('#ddlAdviceNumber').val(Number(data["DURATION"]));
                        $('#Advice_DaySelect').val(data["DURATIONTYPE"].toString());
                    }
                    $("#Advice_DaySelect option").prop("disabled", false);
                    ShowPrefrredTimeSlot();
                    BindSavedAdviceSurgeryData(data);
                    $("#Advice_hdnSurgeryCode").val(data["SURGNMADVICECODE"].toString());
                    if (data["ADVICEDATE"] && data["ADVICEDATE"].toString() != "") {
                        $("#Advice_txtSurgeryAdvDate").val(data["ADVICEDATE"].toString());
                        $("#Advice_txtPACobDate").val(data["PACADVICEDATE"].toString());
                    }
                    else {
                        $("#Advice_txtSurgeryAdvDate").val("");
                        $("#Advice_txtPACobDate").val("");
                    }
                    var NatOfSurgy = data["NATUREOFSURGY"].toString();
                    if (NatOfSurgy != "")
                        $("#Advice_rbtnNatSurg" + NatOfSurgy).prop("checked", true);
                    $("#Advice_txtReferToSpcl").val(data["REFSPECIALIST"].toString());
                    autoResizeTextareaForSinglePage(document.getElementById('Advice_txtReferToSpcl'));
                    if (data["APPMNTDT"].toString() != "" && data["APPMNTTM"].toString() != "") {
                        $("#Advice_txtAppointmntDate").val(data["APPMNTDT"].toString());
                        $("#Advice_txtAppointmntTime").empty();
                        $("#Advice_txtAppointmntTime").append($("<option>" + data["APPMNTTM"].toString() + "</option>"));
                        $("#Advice_appnmtDiv *").attr("disabled", "disabled");
                        $("#Advice_anchorBookAppmnt").off('click');
                        $("#Advice_appnmtShowDiv").removeClass("d-none");
                        $("#Advice_appmntStringDisplay").text("Your appointment is booked on " + data["APPMNTDT"].toString() + " " + data["APPMNTTM"].toString());//added 16th march 19    
                        if (data["APPMNTDT"].toString() != "" && data["APPMNTTM"].toString() != "") {
                            $("#SOSDivMain").css('margin-left', '10px');
                        }
                        $("#Advice_appnmtDiv").addClass("d-none");
                        $("#Advice_lblFollowupDiv").addClass("d-none");
                        $("#Advice_Number").addClass("d-none");
                        $("#Advice_DaySelectDiv").addClass("d-none");
                    }
                    $("#Advice_txtPrescriptionRemark").val(data["REMARK"].toString().trim());
                    fitToContent('Advice_txtPrescriptionRemark');
                    //Pournima 18th Aug 2026
                    $("#SurgAdvice_Freetext").val(data["SURGADVICEOTHER"].toString().trim());
                    fitToContent('SurgAdvice_Freetext');
                    $("#btnADVRemarkFittoContent2").show();
                    $("#btnADVRemarkSetMaxHeight2").show();
                    $("#btnADVSurgeryFittoContent2").show();
                    $("#btnADVSurgerySetMaxHeight2").show();
                    $("#Advice_PlanOfTreatmnt").val(data["PLANOFTREAT"].toString().trim());
                    fitToContent('Advice_PlanOfTreatmnt');
                    $("#btnADVPlanTreatFittoContent2").show();
                    $("#btnADVPlanTreatSetMaxHeight2").show();
                    $("#txtAdvice_PreAdmissionRemark").val(data["ADMADVREMARK"].toString().trim());
                    autoResizeTextareaForSinglePage(document.getElementById('txtAdvice_PreAdmissionRemark'));
                    if (data["ADMADVYN"].toString().trim() == "Y") {
                        $("#AdmissionAdvice")[0].checked = true;
                        //$("#Advice_ddlCareType").val(data["CARETYPE"].toString());
                    }
                    $("#ReferTumorBoard").prop("checked", false)
                    if (data["TBDREFYN"] != undefined && data["TBDREFYN"].toString().trim() == "Y")
                        $("#ReferTumorBoard").prop("checked", true)
                    $("#Advice_txtProposeAdmnDT").val(data["PROPADMNDT"].toString());
                    if (NotesWiseDoct == "Y") {
                        SavedList = data["NOTELIST"].toString().trim() == "" ? [] : JSON.parse(data["NOTELIST"].toString().trim());
                    }
                    if (MedicalRights)
                        TempAdvScheme = ("" + data["SCHEMECODE"]).toString().trim();
                    else {
                        if (typeof BindSavedNewReqSchemeList === "function") {
                            if (SurgicalRights)
                                BindSavedNewReqSchemeList(("" + data["SCHEMECODE"]).toString().trim(), "S");
                            if (RaditionRights)
                                BindSavedNewReqSchemeList(("" + data["SCHEMECODE"]).toString().trim(), "R");
                        }
                    }

                    $("#Advice_cmbLevelOfUrg").val(("" + data["LEVELOFURGENCY"]).toString().trim());
                }
                else {
                    var TDate = new Date();
                    var PACTDate = new Date();
                    TDate.setDate(TDate.getDate() + 1);
                    $("#Advice_txtSurgeryAdvDate").datepicker("setDate", TDate);
                    var dd = ("0" + TDate.getDate()).slice(-2);
                    var mm = ("0" + (TDate.getMonth() + 1)).slice(-2);
                    var yyyy = TDate.getFullYear();
                    var formattedDate = dd + "/" + mm + "/" + yyyy;
                    HandlePACAdvDate(formattedDate);
                }
                LoadFormDoctNote();
                HideUnHideSurgDiv($("#Advice_hdnSurgeryCode").val());
                ShowCareType();
                if (data && data["ADMADVYN"].toString().trim() == "Y") {
                    $("#Advice_ddlCareType").val(data["CARETYPE"].toString());
                }

                //Before Change Go through File Chemoplanning and SinglepageOPD
                IsAdviceBind = true;
                MedSchemeCodesFrom = "A"; // => Advice
                if (IsChemoBind) {
                    if (MedSchemeCodes != "") {
                        MedSchemeCodesFrom = "C"; // => Chemo
                    }
                }
                MedSchemeCodes = TempAdvScheme;
                if (IsAdviceBind == true && IsChemoBind == true && MedicalRights) {
                    LoadMedicalScheme();
                }
                ReqSchemeCompCode = data["REQSCHEMECOMPCODE"].toString().trim();
                ReqSchemeCompName = data["REQSCHEMECOMPNM"].toString().trim();
            },
            complete: function () {
            }
        });
    }

    function HandlePACAdvDate(selectedDate) {
        var parts = selectedDate.split("/");
        var day = parseInt(parts[0], 10);
        var month = parseInt(parts[1], 10) - 1;
        var year = parseInt(parts[2], 10);
        var date = new Date(year, month, day);
        date.setDate(date.getDate() - 1);
        var today = new Date();
        today.setHours(0, 0, 0, 0);
        if (date < today) {
            date = new Date();
        }
        var dd = ("0" + date.getDate()).slice(-2);
        var mm = ("0" + (date.getMonth() + 1)).slice(-2);
        var yy = date.getFullYear().toString();
        var newDate = dd + "/" + mm + "/" + yy;
        $("#Advice_txtPACobDate").val(newDate);
    }

    function LoadFormDoctNote() {
        $("#DoctContNoteDiv").empty();
        GetDoctForNotes();
    }

    function GetDoctForNotes() {
        $.ajax({
            url: '../DoctorDesk/GetDoctors',
            type: 'post',
            datatype: 'json',
            data: { DoctName: "", Type: "P" },
            async: true,
            success: function (data) {
                DoctList = data == "" ? [] : data;
                BindRefDoctNote();
            }
        });
    }

    function BindRefDoctNote() {
        $.grep(SavedList, function (a) {
            AddRefDoctNote();
            var Ind = NoteList[NoteList.length - 1].IND;
            var DoctComboId = "DOCT_NOTE_C_" + Ind;
            var NoteTxtId = "DOCT_NOTE_T_" + Ind;
            $("#" + DoctComboId).val(a.REFDOCTCODE);
            $("#" + NoteTxtId).val(a.NOTE);
            $("#" + NoteTxtId).trigger("change");
        });
    }

    function ShowPrefrredTimeSlot() {
        if ($("#Advice_appnmtDiv").hasClass('d-none')) {
            $("#Advice_txtAppointmntDate").val("");
            $("#Advice_txtAppointmntTime").val("")
        }
        else {
            if ($('#ddlAdviceNumber').val() == "0") {
                $("#Advice_DaySelect").val("Days");
                $("#Advice_txtAppointmntDate").val("");
                $("#Advice_txtAppointmntTime").val("");
                $("#Advice_txtAppointmntTime").empty();
            }
            else {
                SetAppointmentDateTime();
            }
        }
    }

    function SetAppointmentDateTime() {
        var numberofdays = $('#ddlAdviceNumber').val();
        var daySelected = $('#Advice_DaySelect').val();
        if (numberofdays !== "" && numberofdays !== null) {
            if (daySelected == "Days") {
                //date = new Date();
                //var ConsultDt = sessionStorage.getItem("ConsultationDate") || CurDateWithSeparator();
                var ConsultDt = CurDateWithSeparator();
                var parts = ConsultDt.split("/");
                date = new Date(parts[2], parts[1] - 1, parts[0]);
                date.setDate(date.getDate() + parseInt(numberofdays));
                var dateEnd = ("0" + (date.getDate())).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
                document.getElementById('Advice_txtAppointmntDate').value = dateEnd;
                $('#Advice_txtAppointmntDate').datepicker('option', 'minDate', new Date())
            }
            else if (daySelected == "Months") {
                //date = new Date();
                //var ConsultDt = sessionStorage.getItem("ConsultationDate") || CurDateWithSeparator();
                var ConsultDt = CurDateWithSeparator();
                var parts = ConsultDt.split("/");
                date = new Date(parts[2], parts[1] - 1, parts[0]);
                date.setMonth(date.getMonth() + Number(numberofdays));
                var dateEnd = ("0" + (date.getDate())).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
                document.getElementById('Advice_txtAppointmntDate').value = dateEnd;
                $('#Advice_txtAppointmntDate').datepicker('option', 'minDate', new Date())
            }
            else if (daySelected == "Weeks") {
                //date = new Date();
                //var ConsultDt = sessionStorage.getItem("ConsultationDate") || CurDateWithSeparator();
                var ConsultDt = CurDateWithSeparator();
                var parts = ConsultDt.split("/");
                date = new Date(parts[2], parts[1] - 1, parts[0]);
                date.setDate(date.getDate() + (Number(numberofdays) * 7));
                var dateEnd = ("0" + (date.getDate())).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
                document.getElementById('Advice_txtAppointmntDate').value = dateEnd;
                $('#Advice_txtAppointmntDate').datepicker('option', 'minDate', new Date());
            }
            else if (daySelected == "Years") {
                //date = new Date();
                //var ConsultDt = sessionStorage.getItem("ConsultationDate") || CurDateWithSeparator();
                var ConsultDt = CurDateWithSeparator();
                var parts = ConsultDt.split("/");
                date = new Date(parts[2], parts[1] - 1, parts[0]);
                if (Number(numberofdays) <= 0) {
                    date.setFullYear(date.getFullYear());
                } else {
                    date.setFullYear(date.getFullYear() + Number(numberofdays));
                }
                var day = ("0" + date.getDate()).slice(-2);
                var month = ("0" + (date.getMonth() + 1)).slice(-2);
                var year = date.getFullYear();
                var dateEnd = day + '/' + month + '/' + year;
                document.getElementById('Advice_txtAppointmntDate').value = dateEnd;
                $('#Advice_txtAppointmntDate').datepicker('option', 'minDate', new Date());
                if (/^\d{2}\/\d{1}\/\d{4}$/i.test(str)) {
                    var parts = str.split("/");
                    var day = parts[0] && parseInt(parts[0], 10);
                    var month = parts[1] && parseInt(parts[1], 10);
                    var year = parts[2] && parseInt(parts[2], 10);
                    var duration = parseInt(numberofdays, 10);
                    if (day <= 31 && day >= 1 && month <= 12 && month >= 1) {
                        var expiryDate = new Date(year, month - 1, day);
                        expiryDate.setFullYear(expiryDate.getFullYear() + duration);
                        var day = ('0' + expiryDate.getDate()).slice(-2);
                        var month = ('0' + (expiryDate.getMonth() + 1)).slice(-2);
                        var year = expiryDate.getFullYear();
                        $("#Advice_txtAppointmntDate").val(day + "/" + month + "/" + year);
                        $('#Advice_txtAppointmntDate').datepicker('option', 'minDate', new Date(expiryDate))
                    }
                }
            }
            //$("#Advice_txtAppointmntDate").trigger("change");
        }
    }

    function ShowCareType() {
        // Care Type
        if ($("#AdmissionAdvice").prop("checked") === true && CareTypeShowYN && CareTypeShowYN !== "N") {
            $("#Advice_DivCareType")
                .removeClass("d-none")
                .addClass("d-flex");

            AppendPatCareType();
        } else {
            $("#Advice_DivCareType").removeClass("d-flex").addClass("d-none");
        }

        // Level Of Urgency
        if ($("#AdmissionAdvice").prop("checked") === true) {
            $("#Advice_DivLevelOfUrg")
                .removeClass("d-none")
                .addClass("d-flex");
        } else {
            $("#Advice_DivLevelOfUrg").removeClass("d-flex").addClass("d-none");

            $("#Advice_cmbLevelOfUrg").val("");
        }

        //Admission Date
        if ($("#AdmissionAdvice").prop("checked") === true) {
            $("#Advice_AdmissionDateDiv")
                .removeClass("d-none")
                .addClass("d-flex");
        } else {
            $("#Advice_AdmissionDateDiv")
                .removeClass("d-flex")
                .addClass("d-none");
            $("#Advice_txtProposeAdmnDT").val("");
        }

        //Pre - Admission Remark
        if ($("#AdmissionAdvice").prop("checked") === true) {
            $("#DivMainPreAdmRmk")
                .removeClass("d-none")
                .addClass("d-flex");
        } else {
            $("#DivMainPreAdmRmk")
                .removeClass("d-flex")
                .addClass("d-none");
            $("#txtAdvice_PreAdmissionRemark").val("");
        }
    }

    function AppendPatCareType() {
        var Option = '<option value="{VALUE}">{TEXT}</option>';
        $("#Advice_ddlCareType").empty();
        var Options = Option.replace("{VALUE}", "").replace("{TEXT}", "---Select---");
        jQuery.grep(CareTypeLst, function (e) {
            if (e.Status == "A")
                Options = Options + Option.replace("{VALUE}", e.Value).replace("{TEXT}", e.Text);
        });
        $("#Advice_ddlCareType").append(Options);
    }

    //Refert To Specialist
    function GetReferToSpecialistList() {
        $.ajax({
            url: '../DoctorDesk/GetClinic',
            type: 'post',
            datatype: 'json',
            data: {},
            success: function (data) {
                if (data.length > 0) {
                    var Advice_RefToSpeclData = data || [];
                    BindReferToSpecialistLstDtls(Advice_RefToSpeclData);
                }
            },
            complete: function () {
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");

            }
        });
    }

    function BindReferToSpecialistLstDtls(Advice_RefToSpeclData) {
        var $list = $("#ReferToSpclList");
        $list.empty();
        var textarea = $("#Advice_txtReferToSpcl");
        var existingText = textarea.val().trim();
        var existingItems = existingText ? existingText.split(/\s*,\s*/) : [];
        var AppendContentList = '<div class="list-group-item text-muted">No data found</div>';
        if (Advice_RefToSpeclData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < Advice_RefToSpeclData.length; i++) {
                var item = Advice_RefToSpeclData[i];
                var labelText = item.ClinicName;
                var isChecked = existingItems.indexOf(labelText) !== -1 ? "checked" : "";
                AppendContentList +=
                    '<div class="list-group-item RefToSpecl-row">' +
                    '<input type="checkbox" class="RefToSpcl-checkbox" ' +
                    'data-code="' + item.ClinicCode + '" ' +
                    'data-name="' + item.ClinicName + '" ' +
                    'id="Reftospcl' + i + '" ' + isChecked + ' />' +
                    '<label for="Reftospcl' + i + '" style="margin-left:5px;">' +
                    labelText +
                    '</label>' +
                    '</div>';
            }
        }
        $list.append(AppendContentList);
        $("#Advice_DivReferToSpclSearchMainDiv").show();
    }

    //Add Oncologist
    function AddRefDoctNote() {
        var Ind = NoteList.length > 0 ? (NoteList[NoteList.length - 1].IND + 1) : 1;
        var MainDiv = "<div id='{MAINDIVID}' class='row g-2 mb-2 align-items-start REFDOCTDIV'>{MAINCONTENTDIV}</div>";
        var DelIcon = "<div class='col-auto mb-20px me-3'>" +
            "<i class='fa fa-trash text-danger' style='cursor:pointer; font-size:1.2rem;' aria-hidden='true' onclick=\"UpdateDoctNote('R','" + Ind + "')\"></i>" +
            "</div>";
        var DoctCombo = "<div class='col-auto mb-20px'><label class='fw-semibold mb-0' style='font-size: 1rem;'>Doctor Name</label></div>" +
            "<div class='col-md-3 mb-20px'><select class='form-select form-select-sm border-custom-blue' id='{COMBOID}' onchange=\"UpdateDoctNote('U','" + Ind + "')\"></select></div>";
        var NoteTxt = "<div class='col'><textarea class='form-control form-control-sm TextAreaBorder' id='{NOTETEXTAREAID}' rows='2' onchange=\"UpdateDoctNote('U','" + Ind + "'); autoResizeTextareaForSinglePage(this);\" oninput='autoResizeTextareaForSinglePage(this);'  oninput='autoResizeTextareaForSinglePage(this);' placeholder='Enter Notes' style='resize:none;'></textarea></div>";
        var MainDivId = "DOCT_NOTE_M_" + Ind;
        var DoctComboId = "DOCT_NOTE_C_" + Ind;
        var NoteTxtId = "DOCT_NOTE_T_" + Ind;
        var RplDoctCombo = DoctCombo.replace("{COMBOID}", DoctComboId);
        var RplNoteTxt = NoteTxt.replace("{NOTETEXTAREAID}", NoteTxtId);
        var AllDiv = MainDiv.replace("{MAINDIVID}", MainDivId).replace("{MAINCONTENTDIV}", (DelIcon + RplDoctCombo + RplNoteTxt));
        $("#DoctContNoteDiv").append(AllDiv);
        AddDoctlst(DoctComboId);
        $("#" + DoctComboId).val("");
        $("#" + NoteTxtId).val("");
        UpdateDoctNote("N", Ind);
        if (sessionStorage.getItem("PatCompleted") == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagAdviceYN == "Y") {
            document.querySelectorAll('#' + MainDivId + ' select, #' + MainDivId + ' textarea').forEach(el => {
                el.disabled = true;
            });
            document.querySelector('#' + MainDivId + ' .fa-trash').style.pointerEvents = "none";
            document.querySelector('#' + MainDivId + ' .fa-trash').style.opacity = "0.5";
        }
    }

    function AddDoctlst(CmbDoctId) {
        var StrDoctCode = '<%:Session["gDoctCode"]%>';
        var DOption = "<option value='{OPTVALUE}'>{OPTTEXT}</option>";
        var RplDefOption = DOption.replace("{OPTVALUE}", "").replace("{OPTTEXT}", "---Select---");
        $.grep(DoctList, function (a) {
            var FilterNotes = NoteList.filter(function (A) { return A.REFDOCTCODE == a.DoctCode; });
            if (FilterNotes.length == 0) {
                if (StrDoctCode != a.DoctCode) {
                    var RplDOption = DOption.replace("{OPTVALUE}", a.DoctCode).replace("{OPTTEXT}", a.DoctName);
                    RplDefOption = RplDefOption + RplDOption;
                }
            }
        });
        $(("#" + CmbDoctId)).empty();
        $(("#" + CmbDoctId)).append(RplDefOption);
    }

    function UpdateDoctNote(ActType, Ind) {
        var DoctComboId = "DOCT_NOTE_C_" + Ind;
        var NoteTxtId = "DOCT_NOTE_T_" + Ind;
        var DoctorCD = $("#" + DoctComboId).val();
        var DoctorNM = $('#' + DoctComboId + ' option:selected').text();
        var NoteTXT = $("#" + NoteTxtId).val();
        if (ActType == "N") {
            var NewLst = {
                REFDOCTCODE: DoctorCD,
                DOCTNAME: DoctorNM,
                NOTE: NoteTXT,
                IND: Ind
            }
            NoteList.push(NewLst);
        }
        else if (ActType == "U") {
            $.grep(NoteList, function (a) {
                if (a.IND == Ind) {
                    a.REFDOCTCODE = DoctorCD;
                    a.DOCTNAME = DoctorNM;
                    a.NOTE = NoteTXT;
                }
            });
        }
        else if (ActType == "R") {
            var MainDivId = "DOCT_NOTE_M_" + Ind;
            if (document.getElementById(MainDivId)) {
                document.getElementById(MainDivId).remove();
            }
            var TData = JSON.parse(JSON.stringify(NoteList));
            var FData = TData.filter(function (c) { return c.IND != Ind; });
            NoteList = FData;
        }
    }

    //Surgery Advice
    function GetSurgeryList() {
        var searchText = $("#AdviceSurgeryInputSearch").val().toUpperCase();
        var selectedCategory = $("#SurgeryCatgList").val();
        var filtered = [...surgeryDescriptions];
        if (selectedCategory) {
            filtered = filtered.filter(s => s.DISIPLINCD === selectedCategory);
        }
        if (searchText.length > 2) {
            filtered = filtered.filter(s =>
                s.SURGERY_DESC.toUpperCase().includes(searchText)
            );
        }
        var formattedData = filtered.map(function (item) {
            return {
                SurgName: item.SURGERY_DESC,
                SurgCode: item.SURGERY_CODE
            };
        });
        if (formattedData.length > 0) {
            BindSurgeryDtls(formattedData);
        } else {
            $("#AdviceSurgeryList").html(
                '<div class="list-group-item text-muted">No data found</div>'
            );
            $("#Advice_DivSurgerySearchMainDiv").show();
        }
    }

    function BindSurgeryDtls(Advice_SurgeryData) {
        var $list = $("#AdviceSurgeryList");
        $list.empty();
        var rows = advicesurgerylisttable.getData();
        var existingItems = rows.map(function (row) { return row.name; });
        var AppendContentList = '<div class="list-group-item text-muted">No data found</div>';
        if (Advice_SurgeryData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < Advice_SurgeryData.length; i++) {
                var item = Advice_SurgeryData[i];
                var labelText = item.SurgName;
                var isChecked = existingItems.indexOf(labelText) !== -1 ? "checked" : "";
                AppendContentList +=
                    '<div class="list-group-item surgeryadv-row">' +
                    '<input type="checkbox" class="SurgAdv-checkbox" ' +
                    'data-code="' + item.SurgCode + '" ' +
                    'data-name="' + item.SurgName + '" ' +
                    'id="SurgAdv' + i + '" ' + isChecked + ' />' +
                    '<label for="SurgAdv' + i + '" style="margin-left:5px;">' +
                    labelText +
                    '</label>' +
                    '</div>';
            }
        }
        $list.html(AppendContentList);
        $("#Advice_DivSurgerySearchMainDiv").show();
    }

    //Cross Refer Doct added from Search
    function GetRefDoctList() {
        var DoctName = $("#AdviceSearchDoctInputSearch").val();
        if (DoctName.length > 2) {
            $.ajax({
                url: '../DoctorDesk/GetDoctors',
                type: 'post',
                datatype: 'json',
                async: true,
                data: { DoctName: DoctName },
                success: function (data) {
                    if (data.length > 0) {
                        var Advice_RefDoctData = data || [];
                        BindRefDoctDtls(Advice_RefDoctData);
                    }
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");

                }
            });
        }
    }

    function BindRefDoctDtls(Advice_RefDoctData) {
        var $list = $("#AdviceCrossRefDoctList");
        $list.empty();
        var textarea = $("#Advice_txtAdviceCrossRefDoct");
        var existingText = textarea.val().trim();
        var existingItems = existingText ? existingText.split(/\s*,\s*/) : [];
        var AppendContentList = '<div class="list-group-item text-muted">No data found</div>';
        if (Advice_RefDoctData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < Advice_RefDoctData.length; i++) {
                var item = Advice_RefDoctData[i];
                var labelText = item.DoctName;
                var isChecked = existingItems.indexOf(labelText) !== -1 ? "checked" : "";
                AppendContentList +=
                    '<div class="list-group-item crossrefdoct-row">' +
                    '<input type="checkbox" class="CrossRefDoctor-checkbox" ' +
                    'data-code="' + item.DoctCode + '" ' +
                    'data-name="' + item.DoctName + '" ' +
                    'id="CrossRefDoct' + i + '" ' + isChecked + ' />' +
                    '<label for="CrossRefDoct' + i + '" style="margin-left:5px;">' +
                    labelText +
                    '</label>' +
                    '</div>';
            }
        }
        $list.append(AppendContentList);
        $("#Advice_DivDoctorSearchMainDiv").show();
    }
    //End

    function FilterBindedSearchListForSpecialist() {
        var SearchTxt = $("#AdviceReferToSpclSearch").val().toLowerCase();
        if (SearchTxt.length > 2) {
            $("#ReferToSpclList .RefToSpecl-row").each(function () {
                var $che = $(this).find(".RefToSpcl-checkbox");
                var name = $che.data("name").toLowerCase();
                var code = $che.data("code").toLowerCase();
                if (SearchTxt == "" || name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    }

    function ValidationForAdvice(Type) {
        var vallevelofurgency = $("#Advice_cmbLevelOfUrg").val();
        if ($("#AdmissionAdvice").prop("checked") === true && IsLevelOfUrgencyMandatory === "Y" && vallevelofurgency === "") {
            ToastMsg("Please select level of urgency", "warning");
            return false;
        }
        else {
            return true;
        }
    }

    function HASDataInAdvice() {
        var AdviceNoOfDays = $("#ddlAdviceNumber").val();
        var AdviceAppmntDays = $("#Advice_DaySelect").val();
        var AdviceApmntBookingDt = $("#Advice_txtAppointmntDate").val();
        var AdviceApmntTime = $("#Advice_txtAppointmntTime").val();
        var IsAdviceChecked = $("#AdmissionAdvice").prop('checked');
        var LevlOfUrgency = $("#Advice_cmbLevelOfUrg").val();
        var AdmissionDt = $("#Advice_txtProposeAdmnDT").val();
        var PreAdmRemark = $("#txtAdvice_PreAdmissionRemark").val();
        var RefToSpcl = $("#Advice_txtReferToSpcl").val();
        var AdviceRmk = $("#Advice_txtPrescriptionRemark").val();
        var AdvicePlanOfTreat = $("#Advice_PlanOfTreatmnt").val();
        var SurgFlag = true;
        var RadiatFlag = true;
        var SurgAdvice = $("#SurgAdvice_Freetext").val(); // Pournima 18th Aug 2026

        if (SurgicalRights) {
            var SurgTbl = advicesurgerylisttable ? advicesurgerylisttable.getData() : [];
            if (SurgTbl.length == 0)
                SurgFlag = false;
        }

        if (RaditionRights) {
            
        }

        if ($("#AdmissionAdvice").prop('checked') === true) {
            if ((PreAdmRemark === "" || PreAdmRemark === null) &&
                (RefToSpcl === "" || RefToSpcl === null) &&
                (AdviceRmk === "" || AdviceRmk === null) &&
                (AdvicePlanOfTreat === "" || AdvicePlanOfTreat === null) &&
                (LevlOfUrgency === "" || LevlOfUrgency === null) &&
                (AdmissionDt === "" || AdmissionDt === null) &&
                (SurgAdvice === "" || SurgAdvice === null) &&
                SurgFlag == false && RadiatFlag == false
            ) {
                return false;
            } else {
                return true;
            }
        }
        else {
            if ((PreAdmRemark === "" || PreAdmRemark === null) &&
                (RefToSpcl === "" || RefToSpcl === null) &&
                (AdviceRmk === "" || AdviceRmk === null) &&
                (AdvicePlanOfTreat === "" || AdvicePlanOfTreat === null) &&
                (SurgAdvice === "" || SurgAdvice === null) &&
                SurgFlag == false && RadiatFlag == false
            ) {
                return false;
            } else {
                return true;
            }
        }
    }

    function SaveForAdvice(DataSaveObj, Type) {
        var numberofdays = $("#ddlAdviceNumber").val();
        var daySelected = $("#Advice_DaySelect").val();
        var TBRefYN = $("#ReferTumorBoard").prop("checked") ? "Y" : "N";
        var AdviceAdmYN = $("#AdmissionAdvice").prop("checked") ? "Y" : "N";
        var SurgyAdvCode = "";
        var SurgAdvDate = "";
        var PACAdvDate = "";
        var SurgAdvType = "";
        var RadOnco = $("#RbtnTreatAdvTypeR").prop("checked") == true ? "Y" : "N";
        var MedOnco = $("#RbtnTreatAdvTypeM").prop("checked") == true ? "Y" : "N";
        var Palliative = $("#RbtnTreatAdvTypeP").prop("checked") == true ? "Y" : "N";
        var surgeryData = getSelectedSurgeryData();

        if ($('#lblSOS').prop("checked") == true) {
            daySelected = "";
            numberofdays = "SOS";
        }
        if (surgeryData.codes != "") {
            SurgyAdvCode = surgeryData.codes;
            SurgAdvDate = $("#Advice_txtSurgeryAdvDate").val();
            PACAdvDate = $("#Advice_txtPACobDate").val();
            SurgAdvType = $("#Advice_rbtnNatSurgR").prop("checked") ? "R" :
                ($("#Advice_rbtnNatSurgE").prop("checked") ? "E" : "");
        }
        var SchemeCodes = ""; var ReqSchemeCompCD = "";
        if (typeof GetSelectedSchemeCodes === "function") {
            var result;
            if (SurgicalRights) {
                result = GetSelectedSchemeCodes("S");
                SchemeCodes = result.SchemeCodes; // GetSelectedSchemeCodes("S");
                ReqSchemeCompCD = result.ReqSchemeCompCode;
            }
            if (RaditionRights) {
                result = GetSelectedSchemeCodes("R");
                SchemeCodes = result.SchemeCodes; // GetSelectedSchemeCodes("R");
                ReqSchemeCompCD = result.ReqSchemeCompCode;
            }
            if (MedicalRights) {
                result = GetSelectedSchemeCodes("M");
                SchemeCodes = result.SchemeCodes; // GetSelectedSchemeCodes("M");
                ReqSchemeCompCD = result.ReqSchemeCompCode;
            }
        }
        var SurgAdvName = surgeryData.names;
        if (SurgAdvName != "" && SurgyAdvCode == "") {
            SurgAdvDate = $("#Advice_txtSurgeryAdvDate").val();
            PACAdvDate = $("#Advice_txtPACobDate").val();
            SurgAdvType = $("#Advice_rbtnNatSurgR").prop("checked") ? "R" : ($("#Advice_rbtnNatSurgE").prop("checked") ? "E" : "");
            var AllSurgeryLst = [];
            $.ajax({
                url: '../SinglePage/GetSurgeryList',
                async: false,
                success: function (response) {
                    AllSurgeryLst = typeof response === "string" ? JSON.parse(response) : response;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                }
            });
            var namesArray = surgeryData.names.split('\n');
            namesArray.forEach(function (name) {
                var FilterRow = AllSurgeryLst.filter(X => X.SURGERY_DESC.trim() == name.trim())
                if (FilterRow.length > 0) {
                    SurgyAdvCode = SurgyAdvCode + (SurgyAdvCode == "" ? FilterRow[0].SURGERY_CODE : ("," + FilterRow[0].SURGERY_CODE));
                }
            });
        }
        DataSaveObj.StrNotesList = JSON.stringify(FilterNonEmptyRefNoteList());
        DataSaveObj.StrFollowUpNo = numberofdays;
        DataSaveObj.StrFollowUpDays = daySelected;
        DataSaveObj.SurgHist = SurgAdvName;
        DataSaveObj.TOthers = $("#Advice_txtReferToSpcl").val();
        DataSaveObj.RefDoctCode = "";
        DataSaveObj.CallDoneYN = "N";
        DataSaveObj.ApmntDate = $("#Advice_txtAppointmntDate").val();
        DataSaveObj.ApmntTime = $("#Advice_txtAppointmntTime option:selected").text();
        DataSaveObj.PrescRemark = $("#Advice_txtPrescriptionRemark").val();
        DataSaveObj.PlanOfTreatmnt = $("#Advice_PlanOfTreatmnt").val();
        DataSaveObj.AdvAdmnYN = AdviceAdmYN;
        DataSaveObj.TBRefYN = TBRefYN;
        DataSaveObj.ProposeAdmnDt = $("#Advice_txtProposeAdmnDT").val();
        DataSaveObj.PatCareTypeAdviced = $("#Advice_ddlCareType").val();
        DataSaveObj.SurgeryCodeAdviced = SurgyAdvCode;
        DataSaveObj.SurgAdvicedDate = SurgAdvDate;
        DataSaveObj.PACAdvicedDate = PACAdvDate;
        DataSaveObj.SurgeryAdviceType = SurgAdvType;
        DataSaveObj.SchemeCodes = SchemeCodes;
        DataSaveObj.AdmnUrgencyLevel = $("#Advice_cmbLevelOfUrg").val();
        DataSaveObj.strSlotNo = $("#Advice_txtAppointmntTime").val();
        DataSaveObj.StrPreAdmissionRemark = $("#txtAdvice_PreAdmissionRemark").val();
        DataSaveObj.RadiationOncoYN = RadOnco;
        DataSaveObj.MedcialOncoYN = MedOnco;
        DataSaveObj.PalliativeCareYN = Palliative;
        DataSaveObj.SurgeryAdviceOther = $("#SurgAdvice_Freetext").val();
        DataSaveObj.ReqSchemeCompCode = ReqSchemeCompCD;
    }

    function FilterNonEmptyRefNoteList() {
        var FilterLst = [];
        FilterLst = NoteList.filter(s => s.REFDOCTCODE != "");
        return FilterLst;
    }

    function GetTumorPatListforvalidation(callback) {
        var mrno = GetSessionMRNO();
        var DataToSend = {
            sfrmdate: $("#txtFromDate").val(),
            stodate: $("#txtToDate").val(),
            spatname: GetSessionPatName(),
            smrno: mrno,
            RefTumor: "Y",
            RefTumorStatus: "A",
        };
        $.ajax({
            url: '../DoctorDesk/TumorBoardPatListBinding',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            async: true,
            success: function (data) {
                if (typeof callback === "function") {
                    callback(data);
                }
            },
            error: function () {
                if (typeof callback === "function") {
                    callback(null);
                }
            }
        });
    }

    $(document).on("change", "#ReferTumorBoard", function () {
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            GetTumorPatListforvalidation(function (data) {
                if (data && data.rows && data.rows.length > 0) {
                    ToastMsg("Patient already referred to Tumor Board.", "warning");
                    checkbox.prop("checked", false);
                }
            });
        }
    });

    function ReverseCalculateDays(datestr) {
        var ConsultDt =  CurDateWithSeparator();
        var consultDate = ConvertToDate(ConsultDt);
        var inputDate = ConvertToDate(datestr);
        var difference = inputDate - consultDate;
        var daysDifference = Math.floor(difference / (1000 * 60 * 60 * 24));
        $("#ddlAdviceNumber").val(daysDifference);
        $("#Advice_DaySelect").val("Days");
        //if (daysDifference == 0) {
        //    $("#ddlAdviceNumber").val("0");
        //    $("#Advice_DaySelect").val("Days");
        //    $("#Advice_txtAppointmntDate").val("");
        //}
        //else if (daysDifference % 365 == 0) {
        //    $("#ddlAdviceNumber").val(daysDifference / 365);
        //    $("#Advice_DaySelect").val("Years");
        //}
        //else if (daysDifference % 30 == 0) {
        //    $("#ddlAdviceNumber").val(daysDifference / 30);
        //    $("#Advice_DaySelect").val("Months");
        //}
        //else if (daysDifference % 7 == 0) {
        //    $("#ddlAdviceNumber").val(daysDifference / 7);
        //    $("#Advice_DaySelect").val("Weeks");
        //}
        //else {
        //    $("#ddlAdviceNumber").val(daysDifference);
        //    $("#Advice_DaySelect").val("Days");
        //}
    }

    function ConvertToDate(dateString) {
        var parts = dateString.split("/");
        return new Date(parts[2], parts[1] - 1, parts[0]);
    }


    function CurDateWithSeparator() {
        var CDate = new Date();
        var day = String(CDate.getDate()).padStart(2, '0');
        var month = String(CDate.getMonth() + 1).padStart(2, '0');
        var year = CDate.getFullYear();
        return day + "/" + month + "/" + year;
    }
</script>

<div id="sec-advice" class="opd-section-card anchor-offset p-3 bg-white">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="section-title mb-0">Advice</h4>
        <button class="btn btn-outline-success btn-sm" style="height: 30px;" id="Advice_HistIcon" onclick="HistoryPopupOpen('Advice History', 'AdviceHist')">
            <i class="fa fa-history"></i>
        </button>
    </div>

    <%--Follow Up After--%>
    <div class="row g-3 align-items-center mb-2">
        <div class="col-auto" id="Advice_lblFollowupDiv">
            <label class="fw-bold mb-0">Follow Up After :</label>
        </div>

        <div class="col-auto" id="Advice_Number">
            <input type="text"
                class="form-control border-custom-blue text-custom-blue py-1"
                style="width: 75px;"
                id="ddlAdviceNumber"
                maxlength="4"
                placeholder="0"
                inputmode="numeric"
                oninput="this.value = this.value.replace(/[^0-9]/g, '');"
                onchange="ShowPrefrredTimeSlot();" />
        </div>

        <div class="col-auto" id="Advice_DaySelectDiv">
            <select class="form-select border-custom-blue text-custom-blue py-1" id="Advice_DaySelect" onchange="ShowPrefrredTimeSlot();">
                <option value="Days">Days</option>
                <option value="Weeks">Weeks</option>
                <option value="Months">Months</option>
                <option value="Years">Years</option>
            </select>
        </div>

        <div class="col d-flex align-items-center justify-content-between" id="Advice_appnmtDiv">
            <div class="d-flex align-items-center">
                <label class="mb-0 mx-2">Date</label>
                <div class="input-group w-auto">
                    <input type="text" id="Advice_txtAppointmntDate" placeholder="Appointment Date"
                        class="form-control border-custom-blue text-custom-blue py-1" style="width: 160px;" readonly>
                    <label for="Advice_txtAppointmntDate" class="input-group-text border-custom-blue bg-white">
                        <i class="fa fa-calendar text-custom-blue"></i>
                    </label>
                </div>

                <label class="mb-0 mx-2 ms-4" id="Advice_Preferredtimelabel">Preferred Time</label>
                <select class="form-select border-custom-blue text-custom-blue py-1 w-auto" id="Advice_txtAppointmntTime">
                    <option value="" selected disabled>Preferred Time</option>
                </select>
            </div>

            <button class="btn btn-outline-success px-3 py-1" id="Advice_anchorBookAppmnt" title="Save Appointment">Book Appointment</button>
        </div>


        <div class="col d-none align-items-center justify-content-between" id="Advice_appnmtShowDiv">
            <div class="d-flex align-items-center">
                <label class="mb-0 mx-2" style="color: #337ab7; font-size: 16px; font-weight: bold;" id="Advice_appmntStringDisplay"></label>
            </div>
        </div>


    </div>

    <%--SOS--%>
    <div class="row mb-3">
        <div class="col-auto" style="margin-left: 145px; display: none" id="SOSDivMain">
            <div class="form-check d-flex align-items-center">
                <input class="form-check-input border-custom-blue me-2" type="checkbox" id="lblSOS">
                <label class="form-check-label text-custom-blue fw-bold" for="lblSOS">SOS</label>
            </div>
        </div>
    </div>



    <%--Treatment Advice--%>

    <div class="row g-3 align-items-center pb-2" id="Advice_TreatmentAdviceDiv">
        <hr class="my-4 opacity-50">
        <div class="col-auto d-flex align-items-center">
            <div class="col-auto" id="Advice_lblTreatMentAdvDiv">
                <label class="fw-bold mb-0">Treatment Advice :</label>
            </div>
        </div>
        <div class="col-auto" id="Advice_TreatmentAdviceMainDiv">
            <div style="display: flex; align-items: center; gap: 15px;" id="Adivce_TreatAdvOptDiv">
                <div class="d-none" id="TreatAdvTypeRDiv">
                    <input type="checkbox" class="Chkbox" name="TreatmentAdvType" value="R" id="RbtnTreatAdvTypeR" style="vertical-align: middle;">
                    <label for="RbtnTreatAdvTypeR" style="vertical-align: middle;">Radiation Oncology</label>
                </div>
                  <div class="d-none">
                    <input type="checkbox" class="Chkbox" name="TreatmentAdvType" value="M" id="RbtnTreatAdvTypeM" style="vertical-align: middle;">
                    <label for="RbtnTreatAdvTypeM" style="vertical-align: middle;">Medical Oncology</label>
                 </div>
                <div id="TreatAdvTypePDiv">
                    <input type="checkbox" class="Chkbox" name="TreatmentAdvType" value="P" id="RbtnTreatAdvTypeP" style="vertical-align: middle;">
                    <label for="RbtnTreatAdvTypeP" style="vertical-align: middle;">Palliative Care</label>
                </div>
            </div>
        </div>
    </div>

      <div class="AllAdvicePreAuthSchemeSect" id="AllAdvicePreAuthSchemeSect_R"></div>

    <hr class="my-4 opacity-50">

    <%--Admission Advice--%>

    <div class="row g-3 align-items-center pb-2">
        <div class="col-auto d-flex align-items-center">
            <input class="form-check-input me-2" type="checkbox" id="AdmissionAdvice" onclick="ShowCareType()">
            <label class="form-check-label text-custom-blue fw-bold mb-0" for="AdmissionAdvice">Admission Advice</label>
        </div>

        <div class="col-auto ms-md-5 d-flex align-items-center" id="Advice_DivLevelOfUrg">
            <span class="text-custom-orange fw-bold me-2">Level Of Urgency</span>
            <select class="form-select bg-custom-orange urgency-select shadow-sm w-auto" id="Advice_cmbLevelOfUrg">
                <option value="">Select</option>
                <option value="E">Emergent</option>
                <option value="U">Urgent</option>
                <option value="L">Less urgent</option>
            </select>
        </div>

        <div class="col-auto ms-md-5 d-flex align-items-center" id="Advice_AdmissionDateDiv">
            <label class="fw-bold me-2 mb-0">Admission Date</label>
            <%--<input type="date" class="form-control d-inline-block py-1 w-auto" value="2025-12-13" style="border-color: #ccc !important;">--%>
            <div class="input-group w-auto">
                <input type="text" id="Advice_txtProposeAdmnDT" placeholder="Admission Date"
                    class="form-control d-inline-block py-1 w-auto" style="border-color: #ccc !important;">
                <label for="Advice_txtProposeAdmnDT" class="input-group-text  bg-white">
                    <i class="fa fa-calendar text-custom-blue"></i>
                </label>
            </div>
        </div>

        <div class="col-auto d-none" id="Advice_DivCareType">
            <label class="mb-0 mx-2 ms-4">Care Type</label>
            <select class="form-select border-custom-blue text-custom-blue py-1 w-auto" id="Advice_ddlCareType">
                <option value="" selected disabled>Select</option>
            </select>
        </div>
    </div>

    <div class="row g-3 align-items-center pb-2 mt-0 d-none" id="DivMainPreAdmRmk">
        <div class="col-auto">
            <label class="form-check-label text-dark fw-bold mb-0">
                Pre-Admission Remark
            </label>
        </div>

        <div class="col">
            <textarea
                class="form-control TextAreaBorder"
                id="txtAdvice_PreAdmissionRemark"
                name="Advice_PreAdmissionRemark"
                rows="1"
                oninput="autoResizeTextareaForSinglePage(this)"
                style="height: auto; overflow: hidden; resize: none;"
                maxlength="150"
                placeholder="Enter remarks here..."></textarea>
        </div>
    </div>

    <hr class="my-4 opacity-50">

    <%-- Tumar Board --%>
    <div class="row g-3 align-items-center pb-2">
        <div class="col-auto d-flex align-items-center">
            <input class="form-check-input border-custom-blue me-2" type="checkbox" id="ReferTumorBoard" style="width: 20px; height: 20px;">
            <label class="form-check-label text-custom-blue fw-bold mb-0" for="ReferTumorBoard" style="font-size: 1.1rem;">
                Refer To Tumor Board
            </label>
        </div>
    </div>

    <hr class="my-4 opacity-50">

    <%-- Refer To Specialist --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h4 class="text-custom-black fw-bold mb-0 me-5" style="font-size: 1.1rem;">Refer To Specialist</h4>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="AdviceReferToSpclSearch" class="form-control" placeholder="Search Specialist" onclick="GetReferToSpecialistList()" oninput="FilterBindedSearchListForSpecialist()">
            </div>
            <div id="Advice_DivReferToSpclSearchMainDiv"
                class="list-group position-absolute w-100"
                style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="ReferToSpclList" class="list-group w-100"></div>
            </div>
        </div>
    </div>
    <textarea class="form-control TextAreaBorder" id="Advice_txtReferToSpcl" name="Advice_txtReferToSpcl" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none;" maxlength="150"></textarea>

    <hr class="my-4 opacity-50">

    <%-- Cross Reference to Other Oncologist Add Button --%>
    <div class="oncologist-referral-wrapper" id="Advice_AddOncologistMainDiv">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="text-custom-black fw-bold mb-0" style="font-size: 1.1rem;">Cross Reference To Other Doctors</h4>
            <button type="button" class="btn btn-outline-success btn-sm" id="Advice_btnAddRef" onclick="AddRefDoctNote()">
                <i class="fa fa-plus"></i>
                Add Oncologist
            </button>
        </div>
        <div id="DoctContNoteDiv" class="w-100"></div>

    </div>
    <hr class="my-4 opacity-50">


    <%-- Cross Reference To Other Oncologist Doctor Add From Search List --%>
    <div class="oncologist-referral-wrapper d-none" id="Advice_ReferToDrHosp">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="text-custom-black fw-bold mb-0" style="font-size: 1.1rem;">Cross Reference To Other Oncologist</h4>
        </div>
        <div class="d-flex justify-content-between mb-3 align-items-start">
            <h4 class="text-custom-black fw-semibold mb-0 me-5" style="font-size: 1.1rem;">Ref Doctor</h4>
            <div class="flex-grow-1 position-relative  ms-5">
                <div class="input-group input-group-sm w-100">
                    <input type="text" id="AdviceSearchDoctInputSearch" class="form-control" placeholder="Search Doctor (Enter atleast 3 chars)" oninput="GetRefDoctList()">
                </div>
                <div id="Advice_DivDoctorSearchMainDiv"
                    class="list-group position-absolute w-100"
                    style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                    <div id="AdviceCrossRefDoctList" class="list-group w-100"></div>
                </div>
            </div>
        </div>
        <textarea class="form-control TextAreaBorder" id="Advice_txtAdviceCrossRefDoct" name="Advice_txtAdviceCrossRefDoct" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none;" maxlength="150"></textarea>
    </div>


    <%-- Surgery Advice --%>
    <div class="d-none" id="SurgeryAdviceDivMain">
        <div class="d-flex justify-content-between mb-3 align-items-start" id="Advice_SurgeryAdviceDivMain">
            <h4 class="text-custom-black fw-semibold mb-0 me-5" style="font-size: 1.1rem;">Surgery Advice</h4>
            <div class="flex-grow-1 ms-5">
                <div class="input-group input-group-sm w-100">
                    <div class="text-end" style="display: inline-block; vertical-align: top;">
                        <select class="form-select form-select-sm d-inline-block w-auto" id="SurgeryCatgList">
                        </select>
                    </div>
                    <div class="position-relative flex-grow-1" style="margin-left: 10px;">
                        <input type="text" id="AdviceSurgeryInputSearch" class="form-control" placeholder="Search Surgery (Enter atleast 3 chars)" oninput="GetSurgeryList()" />
                        <div id="Advice_DivSurgerySearchMainDiv"
                            class="list-group position-absolute w-100"
                            style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                            <div id="AdviceSurgeryList" class="list-group w-100"></div>
                            <input id="Advice_hdnSurgeryCode" type="hidden" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="d-flex justify-content-between mb-3 align-items-start" id="Advice_SurgeryAdvTbDivMain">
            <div id="Advice_SurgeryAdvTbl" style="margin-bottom: 20px;"></div>
        </div>
        <div  class="mb-4"  id="SurgAdvice_FreetextDivMain">
            <textarea class="form-control TextAreaBorder" id="SurgAdvice_Freetext" name="SurgAdvice_Freetext" placeholder="Enter Surgery Description" oninput="autoResizeTextareaForSinglePage(this)"
                style="height: 100px; overflow-y: auto; resize: none;" maxlength="500"></textarea>
            <div class="text-end mb-4">
                <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnADVSurgeryFittoContent2" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
                <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnADVSurgerySetMaxHeight2" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer;display:none;" />
            </div>
        </div>
        <div class="row g-3 mb-4" id="Advice_NatureOfSurgeDivMain">
            <div class="col-12 col-md-auto">
                <div class="d-flex align-items-center">
                    <label class="mb-0 me-2 fw-semibold" style="min-width: 40px;">Surgery Advice Date</label>
                    <div class="input-group" style="max-width: 200px;">
                        <input type="text" id="Advice_txtSurgeryAdvDate" placeholder="DD-MM-YYYY" class="form-control border-custom-blue py-1" onchange="SetPACOnOrBeforeDate();" readonly>
                        <label for="Advice_txtSurgeryAdvDate" class="input-group-text border-custom-blue bg-white">
                            <i class="fa fa-calendar text-custom-blue"></i>
                        </label>
                    </div>

                    <button type="button" id="btnClearSurgeryDate" class="btn btn-link text-secondary" style="z-index: 5;" title="Clear Surgery Date">
                        <i class="fa fa-refresh"></i>
                    </button>
                </div>
            </div>
            <div class="col-12 col-md-auto">
                <div class="d-flex align-items-center" style="margin-left: 30px;">
                    <label class="mb-0 me-2 fw-semibold" style="min-width: 40px;">PAC Advice Date</label>
                    <div class="input-group" style="max-width: 200px;">
                        <input type="text"
                            id="Advice_txtPACobDate"
                            placeholder="DD-MM-YYYY"
                            class="form-control border-custom-blue py-1"
                            readonly>
                        <label for="Advice_txtPACobDate" class="input-group-text border-custom-blue bg-white">
                            <i class="fa fa-calendar text-custom-blue"></i>
                        </label>
                    </div>
                    <button type="button" id="btnClearPACDate" class="btn btn-link text-secondary" style="z-index: 5;" title="Clear PAC Date">
                        <i class="fa fa-refresh"></i>
                    </button>
                </div>
            </div>
            <div class="col-12">
                <div class="d-flex flex-wrap align-items-center">
                    <label class="text-custom-black fw-bold mb-2 mb-sm-0 me-3">Nature Of The Surgery</label>

                    <div class="d-flex align-items-center me-4 mb-2 mb-sm-0">
                        <input class="form-check-input border-warning me-2" type="radio" name="NatureOfSurgery" id="Advice_rbtnNatSurgR" value="Elective" checked style="cursor: pointer;">
                        <label class="form-check-label fw-bold" for="Advice_rbtnNatSurgR" style="color: #ce9504; cursor: pointer;">Elective</label>
                    </div>

                    <div class="d-flex align-items-center mb-2 mb-sm-0">
                        <input class="form-check-input border-danger me-2" type="radio" name="NatureOfSurgery" id="Advice_rbtnNatSurgE" value="Emergency" style="cursor: pointer;">
                        <label class="form-check-label fw-bold" for="Advice_rbtnNatSurgE" style="color: #ff0b0b; cursor: pointer;">Emergency</label>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <%-- Remarks Section --%>
    <div id="Advice_PrescriptionRemarkDivMain" class="mb-4">
        <h4 class="text-custom-black mb-3 fw-semibold" style="font-size: 1.1rem;">Remarks</h4>
        <textarea class="form-control TextAreaBorder" id="Advice_txtPrescriptionRemark" name="Advice_txtPrescriptionRemark" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none;" maxlength="1000" placeholder="Enter Remarks"></textarea>
        <div class="text-end mb-4">
            <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnADVRemarkFittoContent2" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
            <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnADVRemarkSetMaxHeight2" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer; display: none;" />
        </div>
    </div>

    <%-- Plan of Treatment Section --%>
    <div id="Advice_PlanOfTreatmntDivMain" class="mb-3">
        <h4 class="text-custom-black mb-3 fw-semibold" style="font-size: 1.1rem;">Plan Of Treatment</h4>
        <textarea class="form-control TextAreaBorder" id="Advice_PlanOfTreatmnt" name="Advice_PlanOfTreatmnt" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none;" maxlength="800" placeholder="Enter Treatment Plan"></textarea>
        <div class="text-end mb-4">
            <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnADVPlanTreatFittoContent2" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
            <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnADVPlanTreatSetMaxHeight2" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer; display: none;" />
        </div>
    </div>

    <div class="AllAdvicePreAuthSchemeSect" id="AllAdvicePreAuthSchemeSect_S"></div>
    <div class="AllAdvicePreAuthSchemeSect" id="AllAdvicePreAuthSchemeSect_R"></div>


    <%--Selected List To Print Section--%>
    <div class="container mt-4" id="SelectListToPrintSection">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="text-custom-black fw-bold mb-0 me-5" style="font-size: 1.1rem;">Select list to print</h4>
            <div class="btn-group btn-group-sm">
                <button type="button" class="btn btn-outline-secondary px-3" id="btnSelectAll">Select All</button>
                <button type="button" class="btn btn-outline-secondary px-3" id="btnClearAll">Clear</button>
            </div>
        </div>

        <div class="row row-cols-2 row-cols-md-5 g-3 mb-4">
         
            <div class="col d-flex align-items-center">
                <input type="checkbox" id="chkComplaint" name="PrintOption" class="form-check-input me-2 TextAreaBorder " value="100">
                <label class="form-check-label" for="chkComplaint">Complaints</label>

            </div>


            <div class="col d-flex align-items-center">
                <input type="checkbox" id="chkDiagnosis" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="101">
                <label class="form-check-label" for="chkDiagnosis">Diagnosis</label>
            </div>
            <div class="col d-flex align-items-center">
                <input type="checkbox" id="chkExamin" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="102">
                <label class="form-check-label" for="chkExamin">Examination</label>
            </div>
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkClinicalNotes" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="103">
            <label class="form-check-label" for="chkClinicalNotes">Clinical Notes</label>
        </div>

        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkVital" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="104"> 
            <label class="form-check-label" for="chkVital">Vital Data</label>
        </div>
     
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkInvest" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="105"> 
            <label class="form-check-label" for="chkInvest">Investigations/Procedures</label>
        </div>
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkInstru" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="106">
            <label class="form-check-label" for="chkInstru">Instructions</label>
        </div>
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkRx" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="107"> 
            <label class="form-check-label" for="chkRx">Rx</label>
        </div>

        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkAdvice" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="108"> 
            <label class="form-check-label" for="chkAdvice">Advice</label>
        </div>
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkPersHist" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="109"> 
            <label class="form-check-label" for="chkPersHist">Personal History</label>
        </div>
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkMedHist" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="110"> 
            <label class="form-check-label" for="chkMedHist">Medical History</label>
        </div>
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkFamHist" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="111"> 
            <label class="form-check-label" for="chkFamHist">Family History</label>
        </div>
        <div class="col d-flex align-items-center">
            <input type="checkbox" id="chkallergy" name="PrintOption"  class="form-check-input me-2 TextAreaBorder" value="112"> 
            <label class="form-check-label" for="chkallergy"">Allergy</label>
        </div>
    </div>
        <div class="d-flex justify-content-center mb-0">
            <button type="button" class="btn btn-outline-success px-4" id="Advice_btnAdvicePrint" style="border-radius: 5px !important; min-width: 250px; font-weight: 500;" onclick="GetBindingDataForSelectedPrint();">
                Print
            </button>
        </div>
        <hr class="mb-4 opacity-50">
        <div id='loading-SelectListForPrint' class='loading-screen' style='display: none; opacity: 0;'></div>
    </div>
</div>








