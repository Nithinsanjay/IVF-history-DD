<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Planning>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        legend {
            background-color: #ffffff;
            padding: 5px;
            font-size: 11px;
            font-family: 'Droid Sans', sans-serif !important;
            font-size: 11px !important;
            line-height: 1.42857143 !important;
            color: #333 !important;
            display: inline-block;
            max-width: 100%;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .ui-jqgrid .ui-jqgrid-view{
                font-size: 12px !important;
        }
        #gridChemo {
            width: auto;
            white-space: nowrap;
            font-family: Droid Sans, sans-serif !important;
            font-size: 14px;
        }
        [id^="HistoryChemo_Tbl_"] {
            font-family: "Droid Sans", sans-serif !important;
            font-size: 12px;
        }

        .ui-dialog {
            z-index: 100000;
        }

        .InvstFieldSetLegend {
            margin-bottom: 10px;
            border-bottom: 1px solid #009300;
            color: black;
            font-size: 15px;
        }

        .TextBxFormat {
            font-size: 15px;
            line-height: 1.5;
            color: #333;
            font-family: 'Segoe UI', 'Arial', sans-serif;
        }

            .TextBxFormat::placeholder {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                font-size: 14px;
                color: #888;
                font-style: italic;
            }

        .form-control::placeholder {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 14px;
            color: #888;
            font-style: italic;
        }

        .form-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            max-width: 100%;
            margin: 0 auto;
        }

        .form-row {
            display: flex;
            flex-direction: column;
            margin-bottom: 16px;
        }

        .clschemo {
            flex-direction: column;
            margin-bottom: 12px;
            flex: 1;
            padding: 5px;
            overflow: auto;
        }

            .clschemo .panel-heading {
                width: 99.3% !important;
            }

        .form-duo {
            display: flex;
            flex-direction: column;
            margin-bottom: 12px;
            flex: 1;
            padding: 5px;
            overflow: auto;
        }

        @media (min-width: 1050px) {

            .form-row.horizontal-3 {
                flex-direction: row;
                gap: 10px;
            }

            .form-row.horizontal-2 {
                flex-direction: row;
                gap: 10px;
            }

            .form-duo {
                margin-bottom: 0;
            }
        }

        .custom-dropdown {
            position: relative;
            display: inline-block;
            width: 99%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
            color: #333;
            overflow: visible;
        }

            .custom-dropdown select {
                width: 100%;
                padding: 6px 40px 6px 12px;
                border-radius: 6px;
                border: 1.5px solid #ced4da;
                background-color: #fff;
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                cursor: pointer;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                box-sizing: border-box;
                font-size: 15px;
            }

                .custom-dropdown select:focus {
                    border-color: #4a90e2;
                    box-shadow: 0 0 6px #4a90e2aa;
                    outline: none;
                }

            .custom-dropdown::after {
                content: "";
                position: absolute;
                top: 50%;
                right: 16px;
                width: 0;
                height: 0;
                pointer-events: none;
                border-left: 6px solid transparent;
                border-right: 6px solid transparent;
                border-top: 6px solid #4a90e2;
                transform: translateY(-50%);
            }

            .custom-dropdown select:hover {
                border-color: #a9c4f2;
            }

            .custom-dropdown select:disabled {
                background-color: #f0f0f0;
                color: #999;
                cursor: not-allowed;
                border-color: #ddd;
            }

        .form-input {
            padding: 10px 14px;
            font-size: 15px;
            border: 1.5px solid #ccc;
            border-radius: 6px;
            background-color: #fff;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

            .form-input:focus {
                border-color: #4a90e2;
                box-shadow: 0 0 5px rgba(74, 144, 226, 0.4);
                outline: none;
            }

        .info-icon {
            display: inline-block;
            width: 20px;
            height: 20px;
            background-color: #007bff;
            color: white;
            border-radius: 50%;
            text-align: center;
            font-size: 16px;
            font-family: Arial, sans-serif;
            line-height: 22px;
            font-weight: bold;
            cursor: help;
        }

        body {
            font-family: 'Droid Sans', sans-serif !important;
            font-size: 11px !important;
            line-height: 1.42857143 !important;
            color: #333 !important;
        }

        .SearchListDiv {
            max-width: 100%;
            display: block;
            margin-top: 0px;
            z-index: 100000;
            position: absolute;
            background-color: rgb(251, 251, 251);
            border: 1px solid black;
            padding: 0px 5px;
            overflow: auto;
            height: -webkit-fill-available;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .MedicineTbl td,
        .MedicineTbl th {
            text-align: center;
            vertical-align: middle !important;
        }

        .MedicineTbl {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: #333;
        }

            .MedicineTbl th, .MedicineTbl td {
                border: 1px solid #ccc;
                padding: 8px 10px;
                text-align: center;
            }

            .MedicineTbl thead {
                font-weight: bold;
                background-color: #6380bb !important;
                color: white;
            }

            .MedicineTbl tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

        .tdCombo {
            padding: 8px 0px !important;
            text-align: center;
        }

        .tdtxt {
            padding: 0px !important;
            text-align: center;
        }

        .editable-text {
            width: 100%;
            border: none;
            background: transparent;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding: 0;
            margin: 0;
            font: inherit;
            color: inherit;
            cursor: pointer;
            text-align: center;
            resize: none;
        }

            .editable-text:focus {
                outline: none;
            }

        .editable-select {
            width: 100%;
            border: none;
            background: transparent;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding: 0;
            margin: 0;
            font: inherit;
            color: inherit;
            cursor: pointer;
            text-align: center;
        }

            .editable-select:focus {
                outline: none;
            }

        .MedDelIcon {
            font-size: 20px;
            color: #c70000;
            cursor: pointer;
        }

        .ADMSTATUSY {
            background-color: #f1f1f1 !important;
        }

    </style>
    <script type="text/javascript">
        var gaction = '<%= Model.TempGaction %>';
        var PerformStatusList = [{ VALUE: "", TEXT: "---Select---" }, { VALUE: "0", TEXT: "0" }, { VALUE: "1", TEXT: "1" }, { VALUE: "2", TEXT: "2" }, { VALUE: "3", TEXT: "3" }, { VALUE: "4", TEXT: "4" }, { VALUE: "5", TEXT: "5" }];
        var totalCycle = "", completeycle = "", pendingCycle = "", currentCycle = "";
        var HPData = '<%= Model.HPReportTextArea %>';
        var HPResultDate = '<%= Model.HPReportResultDate %>';
        <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var MedType = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.MedType))%>));
        var PHGenericNAmesLst = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.PHGenericNAmesLst))%>));
        var AdministrationDurations = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.AdministrationDurations))%>));
        var DilutionVolume = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.DilutionVolume))%>));
        var MedicalSetNo = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.MedicalSetNo))%>));
        var DoseCalculation = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.DoseCalculation))%>));
        var RouteList = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.RouteList))%>));
        var DrugType = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.DrugType))%>));
        var strCoMorbidities = "";
        var DoctorCode = '<%:Session["gDoctCode"]%>';
        var DataMigration = "N";
        const IS_DISPLAY_CIMS_FUNCTIONLITY = '<%= OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("IS_DISPLAY_CIMS_INTEGRATION").ToString().Trim() %>';  // Added By Roshan For Taking  Value For CIMS Integration- 12/10/2025
        $(document).ready(function () {
            SchemePatList();
            if ($(window).width() >= 996) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                $('#heading').hide();
                $("#slide_sdList").click();
                setPOtherDetail();
                SetPatientDtl();
                $("#PatAdviceSetUpList").css("display", "block");
                ActiveMenu("PresChemo");
                var tblheadHeight = $("#PatAdviceSetUpList").height();
                var menulistheight = $("#menuList").height();
                $('#divMenuList').css("height", (menulistheight - (tblheadHeight + 7)) + "px");
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }

            $("#txtRepeatAfter").on('input', function () {
                let value = $(this).val();
                let regex = /^\d+(\d{0,0})?$/;
                if (!regex.test(value)) {
                    $(this).val(value.slice(0, -1));
                }
            });

            $("#txtCycles").on('input', function () {
                let value = $(this).val();
                if (Number(value) > 1)
                {

                    $("#txtRepeatAfter").prop('disabled', false);
                }
                else {
                    $("#txtRepeatAfter").val("0");
                    $("#txtRepeatAfter").prop('disabled', true);
                }
                let regex = /^\d+(\d{0,0})?$/;
                if (!regex.test(value)) {
                    $(this).val(value.slice(0, -1));
                }
            });

            $("#LstChemoTName").change(function () {
                GetProtocol();

            });

            $("#myBtn,#btnSave").click(function () {

                if ($('#isEditYN').val() == 'N') {
                    $('#isEditYN').val('Y');
                    EditChemoProcessFn();
                    document.getElementById('btnSave').textContent = 'Update';
                    $("#btnPrint").hide();
                    return false;
                }

                let validateAction = ValidateBeforeSave();
                if (validateAction) {
                    let prepDt = prepSaveData();
                    if (prepDt) {
                        SaveService(prepDt);
                    }
                }
            });
            $("#txtTreatComplete").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });

            $("#txtChemoStart").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                minDate: new Date(),
            });

            $("#LstChemoCourse, #LstTreatmentPlan, #LstChemoTName ,#LstScheme, #LstPatCat").change(function () {
                if ($(this).val() !== "" && $(this).val() !== null) {
                    $(this).css("border", "");
                }
            });

            $("#txtPrevTreatTextArea, #txtCycles, #txtRepeatAfter, #txtModificationTextArea, #cmbPerformanceStatus, #txtCoMorbiditiesTextArea,#txtDurationDays").change(function () {
                if ($(this).val() !== "" && $(this).val() !== null) {
                    $(this).css("border", "");
                }
            });
            $("#rbtnPlannedNo").prop("checked", true).trigger('click');
            GetVitalData();

            GetMedOncoData();
            GetMedHistory();

            $("#btnPlanning").fancybox({
                openEffect: 'elastic',
                openSpeed: 100,
                closeEffect: 'elastic',
                closeSpeed: 100,
                helpers: {
                    overlay: { closeClick: false }
                },
                autoDimensions: false,
                width: '80%',
                height: '80%%',
                fitToView: true,
                aspectRatio: false,
                cyclic: true,
                showNavArrows: true,
                autoSize: false,
                scrolling: 'auto'
            });

            if (gaction == "N") {//Priyanka 20/11/2025
                $("#chkStructure").prop("checked", true);
                CalculateDose();
            }

            $('#chkStructure').click(function () {
                CalculateDose();
            });

            GetICDDiagnosis();
            PatMedicationHistory();
            if ($('#rbtnPlannedYes').is(':checked')) {
                $('#lblPlanned').show();
                $('#CmbStatus').show();
            }
            else {
                $('#lblPlanned').hide();
                $('#CmbStatus').hide();
            }

            $("#rbtnPlannedYes").click(function () {
                if ($('#rbtnPlannedYes').is(':checked')) {
                    $('#lblPlanned').show();
                    $('#CmbStatus').show();
                }
                else {
                    $('#lblPlanned').hide();
                    $('#CmbStatus').hide();
                }
            })
            $("#rbtnPlannedNo").click(function () {
                $('#lblPlanned').hide();
                $('#CmbStatus').hide();
                $('#cmbConStatus').val('').trigger('change');
                $('#divCompleteDate').hide();
                $('#txtTreatComplete').val('');


            })

            if ($('#cmbConStatus').val() == "01") {
                $("#divCompleteDate").show();
                $('#btnSave').hide();
                //$("#LstChemoCourse").css("pointer-events", "none");
                //$("#LstTreatmentPlan").css("pointer-events", "none");
                //$("#Duration").css("pointer-events", "none");
                //$("#ConStatus").css("pointer-events", "none");
                //$('#LstChemoTName').prop("disabled", true);
                //$('#chkStructure').prop("disabled", true);
                //$('#txtTreatComplete').prop('disabled', 'true')
                //$("#gridChemo").jqGrid('setGridParam', { cellEdit: false });
                //$("#gridChemo .ui-jqgrid-bdiv input[type=checkbox]").prop("disabled", true);
                //$('#txtChemoTextArea').prop("disabled", true);
                //$('#txtModificationTextArea').prop("disabled", true);
                //$('#rbtnPlannedYes').prop("disabled", true);
                //$('#rbtnPlannedNo').prop("disabled", true);
                EDisableEventProcess(true);
                EditPreDisableFields(true);
            }
            else {
                $("#divCompleteDate").hide();
                EditPreDisableFields(false);
            }

            window.onclick = function (event) {
                var SchemTbl = document.getElementById('tblScheme');
                var SchemIn = document.getElementById('SchemeInput');
                var SchemeNodes = Array.prototype.slice.call(SchemTbl.querySelectorAll("*"), 0);
                if (event.target != SchemTbl && event.target != SchemIn && $.inArray(event.target, SchemeNodes) == -1) {
                    $("#tblScheme tr").hide();
                    $("#SchemeInput").val("");
                }
            }

            // Added by Dhananjay 20250924
            document.getElementById('txtPlanNo').textContent = $('#txtTRANID').val() || $('#PlanningNoDivId').hide();
            if ($('#txtTRANID').val() == "")
                $('#TreatConStatus').hide();
            else
                $('#TreatConStatus').show();

            if (gaction == "E") {
                EDisableEventProcess(true);
            }
            $('#myBtn').hide();

            //EditPreDisableFields(true);
            if (gaction == "N") {
                $("#btnPrint").hide();
            }
            var PatCompYN = sessionStorage.getItem('PatCompleted');
            if (PatCompYN == "Y")
                $('#LstChemoCourse,#LstTreatmentPlan,#txtCoMorbiditiesTextArea,#txtHPReport,#txtHPReportRemark,#LstChemoTName,#txtChemoTextArea,#txtDurationHrs,#txtCycles,#txtRepeatAfter,#txtDurationDays,#txtModificationTextArea,#chkStructure').prop("disabled", true);
        });
        //end ready
        function CalculateDose() {
            var ids = $("#gridChemo").jqGrid('getDataIDs');
            var weight = parseFloat($('#txtWeight').val()) || 0;
            var bsa = parseFloat($('#txtBSA').val()) || 0;
            if ($("#chkStructure").prop("checked")) {
                ids.forEach(function (id) {
                    var row = $("#gridChemo").jqGrid('getRowData', id);
                    if (!row.ORIGINALDOSE || row.ORIGINALDOSE === "") {
                        $("#gridChemo").jqGrid('setCell', id, 'ORIGINALDOSE', row.DOSE);
                    }
                    var oldDose = parseFloat(row.ORIGINALDOSE || row.DOSE) || 0;
                    var newDose = oldDose;

                    if (row.ADMNSTATUS != "Y") {
                        if (row.CALCULATEON === "W") {
                            newDose = weight * oldDose;
                        } else if (row.CALCULATEON === "B") {
                            newDose = bsa * oldDose;
                        }
                        newDose = parseFloat(newDose);
                        $("#gridChemo").jqGrid('setCell', id, 'DOSE', newDose);
                    }
                });
            }
            else {
                ids.forEach(function (id) {
                    var row = $("#gridChemo").jqGrid('getRowData', id);
                    if (row.ORIGINALDOSE && row.ORIGINALDOSE !== "") {
                        $("#gridChemo").jqGrid('setCell', id, 'DOSE', row.ORIGINALDOSE);
                    }
                });
            }
        }

        function toggleCompleteDate(dropdown) {
            var selectedValue = dropdown.value;
            if (selectedValue === "01") {
                $("#divCompleteDate").show();
            } else {
                $("#divCompleteDate").hide();
                $('#txtTreatComplete').val('');
            }
        }
        function GetICDDiagnosis() {
            if ($.session.get("PatTRANNO") != "") {
                var DataToSend = {
                    strTranNo: $.session.get("PatTRANNO"),
                    strMRNO: $.session.get('PatMRNO')
                }
                $.ajax({
                    url: 'SetDataForDiagnosis',
                    type: 'post',
                    datatype: 'json',
                    data: DataToSend,
                    async: false,
                    success: function (data) {
                        ICDDiagnosis = "";
                        if (data.length > 0) {
                            if (data[1] != null) {
                                $.grep(data[1], function (a) {
                                    ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                                });
                                BindICDDiagnosisTable(data[1]);
                            }
                            else if (data[0] != null) {
                                $.grep(data[0], function (a) {
                                    ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                                });
                            }
                            BindICDODiagnosisTable((data[4] != null ? data[4] : []), (data[5] != null ? data[5] : []));
                        }
                    },
                    complete: function () {
                        HoldOn.close();
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        HoldOn.close();
                    }
                });
            }
        }

        function BindICDDiagnosisTable(Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDTBody").empty();
            $.grep(Lst, function (a) {
                var Code = a.ICDCODE;
                var Desc = a.NAME;
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                var RplTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd);
                $("#TableICDTBody").append(RplTr);
            });
        }

        //Bind ICD-O Diagnosis Table
        function BindICDODiagnosisTable(TopoLst, Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {ROWSPAN} {STYLE}>{TDCONTENT}</td>";
            $("#TableICDOTBody").empty();
            $.grep(TopoLst, function (item) {
                var FilterHisto = Lst.filter(function (t) { return t.TOPOCODE === item.TOPOCODE; });
                var Ind = 0;
                var FinalTr = "";
                var TNM = (item.TNMPREFIX || '') + (item.T || '') + (item.N || '') + (item.M || '');
                var TopoCodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", item.TOPOCODE).replace("{ROWSPAN}", ("Rowspan='" + FilterHisto.length + "'"));
                var TopoNameTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", item.TOPODESC).replace("{ROWSPAN}", ("Rowspan='" + FilterHisto.length + "'"));
                var TNMTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", TNM).replace("{ROWSPAN}", ("Rowspan='" + FilterHisto.length + "'"));
                var StageTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", item.STAGE || '').replace("{ROWSPAN}", ("Rowspan='" + FilterHisto.length + "'"));
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", '').replace("{ROWSPAN}", "");
                var DescTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", '').replace("{ROWSPAN}", "");
                if (FilterHisto.length > 0) {
                    $.grep(FilterHisto, function (H) {
                        var Code = item.TOPOCODE + H.HCODE + " " + H.HGRADE;
                        var Desc = item.TOPODESC + ", " + H.HDESC + ", " + H.GRADENAME;
                        CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code).replace("{ROWSPAN}", "");
                        DescTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Desc).replace("{ROWSPAN}", "");
                        FinalTr = Tr.replace("{TRCONTENT}", (Ind == 0 ? TopoCodeTd + TopoNameTd + CodeTd + DescTd + TNMTd + StageTd : CodeTd + DescTd));
                        $("#TableICDOTBody").append(FinalTr);
                        Ind++;
                    });
                }
                else {
                    FinalTr = Tr.replace("{TRCONTENT}", TopoCodeTd + TopoNameTd + CodeTd + DescTd + TNMTd + StageTd);
                    $("#TableICDOTBody").append(FinalTr);
                }
            });
        }

        function ShowPlanCompleteLst() {
            $("#gridChemo").jqGrid("GridUnload");
            jQuery("#gridChemo").jqGrid({
                datatype: 'local',
                data: [],
                colModel: [
                    {
                        label: 'Medicine Type', name: 'MEDTYPE', width: 120, sortable: false, hidden: true,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetMedicalType(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },
                     { label: 'Info.', name: 'CIMSINFO', width: 55, editable: false, formatter: InfoBtnFormatter,hidden:IS_DISPLAY_CIMS_FUNCTIONLITY == "Y" ? false : true },
                     { label: 'Cycle', name: 'CYCLENO', align: "center", width: 50, editable: false, hidden: false },
                     { label: 'Admission No.', name: 'ADMNNO', align: "center", width: 100, editable: false },
                    { label: 'On Day', name: 'ONDAY', align: "center", width: 50, editable: false, hidden: false },
                    {
                        label: 'Apply To Day', name: 'APLYTODAY', width: 80, align: "center", sortable: true, sorttype: "int", hidden: true
                    },
                    {
                        label: 'Med. Set No.', name: 'MEDSETNO', width: 100, sortable: false, hidden: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetMedicalSetNo(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },
                    { label: 'Generic Code', name: 'GENERICID', width: 100, hidden: true },
                    {
                        label: 'Drug Form', name: 'DRUGFORM', width: 70, sortable: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetDrugForm(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },
                    {
                        label: 'Generic Name', name: 'GENERICNM', width: 150, sortable: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetPHGenericNameLst(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                                $(element).on('change', function () {
                                    const selectedValue = $(this).val();
                                    const rowId = $(element).closest('tr.jqgrow').attr('id');
                                    $("#gridChemo").jqGrid('setCell', rowId, 'GENERICID', selectedValue, '', '', true);
                                });
                            }
                        }
                    },
                    {
                        label: 'Dose', name: 'DOSE', width: 70, editable: true, align: "left", editrules: { number: true },
                        editoptions: {
                            dataInit: function (elem) {
                                $(elem).on("input", function () {
                                    let value = this.value;
                                    value = value.replace(/[^0-9.]/g, "");
                                    const parts = value.split('.');
                                    if (parts.length > 2) {
                                        value = parts[0] + '.' + parts.slice(1).join('');
                                    }
                                    this.value = value;
                                });
                            }
                        },

                        formatter: function (cellValue) {
                            if (cellValue == null || cellValue === "") return "";
                            var num = parseFloat(cellValue);
                            if (isNaN(num)) return cellValue;
                            return (num % 1 === 0) ? num.toFixed(0) : num.toFixed(2);
                        }
                    },
                    { label: 'Dose Unit', name: 'DOSEUNIT', width: 80, editable: false },
                    {
                        label: 'Calculate On', name: 'CALCULATEON', width: 100, sortable: false, hidden: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetDoseCalculation(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },
                    {
                        label: 'Route', name: 'ROUTECD', width: 90, sortable: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetRouteList(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },
                    { label: 'Frequency', name: 'FREQUENCY', width: 70, editable: false },
                    { label: 'Diluent Generic Code', name: 'DILNTGENCD', width: 140, editable: false, hidden: true },
                    { label: 'Diluent', name: 'DILUENT', width: 120, editable: true },
                    {
                        label: 'Diluent Volume', name: 'VOLDILTN', width: 120, sortable: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetDilutionVolume(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },
                    {
                        label: 'Duration', name: 'DURATION', width: 140, sortable: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetAdministrationDurations(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },
                    {
                        label: 'Omit',
                        name: "OMITDRUG",
                        index: "OMITDRUG",
                        width: 35,
                        align: "center",
                        editable: (gaction == 'N'),
                        sortable: false,
                        edittype: 'checkbox',
                        editoptions: { value: "Y:N" },
                        formatter: "checkbox",
                        formatoptions: { disabled: false }
                    },
                     { label: 'Admission Required', name: 'ADMNYN', width: 140, editable: false },

                    {
                        label: 'Administer Seq. No.', name: 'ADMINSEQNO', width: 120, hidden: false,
                        editable: false,
                        edittype: 'select',
                        formatter: 'select',
                        editoptions: {
                            value: GetMedicalSetNo(),
                            dataInit: function (element) {
                                $(element).css({ "margin-top": "5px", "margin-bottom": "3px", "margin-left": "2px", "width": "99%", "height": "19px" });
                            }
                        }
                    },

                    { label: 'Remarks', name: 'REMARKS', width: 200, editable: true },
                    { label: 'Original Dose', name: 'ORIGINALDOSE', width: 120, editable: false, align: "right" },

                    { label: 'Admission Status', name: 'ADMNSTATUS', align: "center", width: 120, editable: false, hidden: true },
                    { label: 'Doctor Code', name: 'DOCTCODE', align: "center", width: 120, editable: false, hidden: true },
                ],
                sortname: 'ADMNNO',
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
                rowattr: function (rd) {
                    if (rd.ADMNSTATUS === "Y") {
                        return {
                            "class": "ADMSTATUSY"
                        };
                    }
                },
                beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
                    updateCheckboxColor(rowid);
                    var rowData = $("#gridChemo").jqGrid('getRowData', rowid);
                    if ((cellname === "DOSE" || cellname === "REMARKS") && rowData.ADMNSTATUS === "Y") {
                        return false;
                    }
                    return true;
                },
                gridComplete: function () {
                    var ids = $("#gridChemo").jqGrid('getDataIDs');
                    ids.forEach(function (id) {
                        updateCheckboxColor(id);
                    });

                    Merger('gridChemo', 'ADMNNO');
                    Merger('gridChemo', 'ONDAY');
                    if (DataMigration == "Y")
                        $('#gridChemo').find('input[type="checkbox"]').prop('disabled', true);
                    if (IS_DISPLAY_CIMS_FUNCTIONLITY == "Y") {
                        toogleButtons("gridChemo");//ForHide and Show For Interaction and Duplicate Button Added By Roshan 12/12/2025
                    }
                },
                //gridComplete: function () {
                //    Merger('gridChemo', 'ADMNNO');
                //    //Merger('gridChemo', 'APLYTODAY');
                //    Merger('gridChemo', 'ONDAY');
                //},
                afterEditCell: function (rowid, cellname, value, iRow, iCol) {
                    setTimeout(function () {
                        var $input = $("#" + iRow + "_" + cellname);
                        var rowData = $("#gridChemo").jqGrid('getRowData', rowid);
                        if ((cellname === "DOSE" || cellname === "REMARKS") && rowData.ADMNSTATUS === "Y") {
                            $input.prop('disabled', true);
                        }
                        $input.off('blur').on('blur', function () {
                            $('#gridChemo').saveCell(iRow, iCol);
                            updateCheckboxColor(rowid);
                        });
                    }, 100);
                    updateCheckboxColor(rowid);
                },
                onCellSelect: function (rowid, iCol, cellcontent, e) {
                    updateCheckboxColor(rowid);
                },
                onSelectRow: function (rowid, status, e) {
                    updateCheckboxColor(rowid);
                },
                afterSaveCell: function (rowid, name, val, iRow, iCol) {
                    updateCheckboxColor(rowid);
                    $("#" + iRow + "_" + name).bind('blur', function (e) {
                        $('#gridChemo').saveCell(iRow, iCol);
                        updateCheckboxColor(rowid);
                    });
                },
                loadComplete: function () {
                    var cycle = $("#txtcurrentCycle").val().trim() == "" ? $("#txtCompleteCycle").val() : $("#txtcurrentCycle").val(); // added by roshan 14/08/2025
                    var cycleValue = cycle;
                    var ids = $("#gridChemo").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        //Added By rajan - For Change the Cycle
                        var rowData = $("#gridChemo").jqGrid('getRowData', ids[i]);
                        var AdmStatusYN = cycleValue != rowData.CYCLENO ? " " : rowData.ADMNSTATUS;
                        $("#gridChemo").jqGrid('setCell', ids[i], 'CYCLENO', cycleValue);
                        $("#gridChemo").jqGrid('setCell', ids[i], 'ADMNSTATUS', AdmStatusYN);
                        if (AdmStatusYN.trim() == "Y")
                            $("#" + ids[i]).addClass("ADMSTATUSY");
                        else
                            $("#" + ids[i]).removeClass("ADMSTATUSY");


                        //**************************///
                        // $("#gridChemo").jqGrid('setCell', ids[i], 'CYCLENO', cycleValue);
                        $("#gridChemo").jqGrid('setCell', ids[i], 'DOCTCODE', DoctorCode);
                    }
                    var grid = $(this);

                    if ($('#cmbConStatus').val() == "01") {
                        ids.forEach(function (rowId) {
                            var rowData = $("#gridChemo").jqGrid('getRowData', rowId);
                            if (rowData.ADMNSTATUS === "Y") {
                            }
                        });
                    }


                    ids.forEach(function (rowId) {
                        var rowData = $("#gridChemo").jqGrid('getRowData', rowId);
                        if (rowData.ADMNSTATUS === "Y") {
                        }
                    });
                    var ids = $("#gridChemo").jqGrid('getDataIDs');
                    if (ids.length <= 0) {
                        $('#btnSearch').removeClass('DisableButton');
                    }
                    if ($("#chkStructure").prop("checked")) {
                        CalculateDose();
                    }
                }


            }).trigger("reloadGrid");
            var newWidth = $("#ContentDiv").width();
            $("#gridChemo").jqGrid("setGridWidth", newWidth - 9, false);
            $("#gridChemo").jqGrid("setGridHeight", $("#ContentDiv").height() - 225, true);
            $(window).on("resize", function () {
                var newWidth = $("#ContentDiv").width();
                $("#gridChemo").jqGrid("setGridWidth", newWidth - 9, false);
            });
        }

        function updateCheckboxColor(rowId) {
            var $row = $("#" + rowId);
            var excludeColumns = ['CYCLENO', 'ADMNNO', 'ONDAY'];
            var $chk = $row.find("td[aria-describedby='gridChemo_OMITDRUG'] input[type='checkbox']");
            $row.find("td[aria-describedby^='gridChemo_']").each(function () {
                var colName = $(this).attr("aria-describedby").replace("gridChemo_", "");
                if (colName !== "OMITDRUG" && !excludeColumns.includes(colName)) {
                    $(this).css("background-color", $chk.is(":checked") ? "#ffcfcf" : "");
                }
            });
            $chk.off('click').on('click', function () {
                updateCheckboxColor(rowId);
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

        function GetDrugForm() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(DrugType, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }

        function GetMedicalType() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(MedType, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }

        function GetDoseCalculation() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(DoseCalculation, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }

        function GetRouteList() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(RouteList, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }

        function GetDilutionVolume() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(DilutionVolume, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }

        function GetMedicalSetNo() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(MedicalSetNo, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }

        function GetAdministrationDurations() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(AdministrationDurations, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }

        function GetPHGenericNameLst() {
            var dropdownOptions = { "": "----Select-----" };
            $.each(PHGenericNAmesLst, function (index, item) {
                dropdownOptions[item.Value] = item.Text;
            });
            return dropdownOptions;
        }
        function GetProtocol() {
            var selected_val = $('#LstChemoTName').find(":selected").attr('value');
            if (selected_val != "") {
                $.ajax({
                    type: "POST",
                    url: "../DoctorDesk/GetProtocol",
                    datatype: 'json',
                    async: false,
                    data: { id: selected_val },
                    success: function (data) {
                        if (data.length > 0) {
                            $('#txtDurationDays').val(data[2]);
                            if (data[3] === "S") {
                                $('#heading').show();

                                ShowPlanCompleteLst();
                                GetStructureProtocol();
                                document.getElementById("DivChemoArea").style.display = "none";
                                $('#txtChemoTextArea').hide().val('');
                                ChemoautoResize(document.getElementById("txtChemoTextArea"));
                                $('#chkStructure').prop("disabled", false);
                            }
                            else {
                                document.getElementById("DivChemoArea").style.display = "flex";
                                $('#txtChemoTextArea').show();
                                $('#txtChemoTextArea').val(data[0]);
                                ChemoautoResize(document.getElementById("txtChemoTextArea"));
                                $('#chkStructure').prop("disabled", true);
                                $('#heading').hide();
                                $("#gridChemo").jqGrid("clearGridData", true);
                                $('#gridChemo').closest(".ui-jqgrid").hide();
                            }
                        }
                        else {
                            $('#txtChemoTextArea').val('');
                            ChemoautoResize(document.getElementById("txtChemoTextArea"));
                        }
                    }
                });
            }
            else {
                $("#gridChemo").jqGrid("clearGridData", true);
                $('#txtChemoTextArea').val('');
                ChemoautoResize(document.getElementById("txtChemoTextArea"));
                $('#chkStructure').prop("disabled", true);
            }
        }

        function GetStructureProtocol() {
            var selected_val = $('#LstChemoTName').find(":selected").attr('value');
            if (selected_val != "") {
                $.ajax({
                    type: "POST",
                    url: "../DoctorDesk/GetChemoMedicationMasterList?strProtocol=" + selected_val + "&strType=" + "D",
                    datatype: 'json',
                    success: function (data) {
                        var Grid = JSON.parse(data);
                        if (Grid.length > 0) {
                            $('#heading').show();
                            document.getElementById("DivOmitIndicator").style.display = "flex";
                            $('#gridChemo').closest(".ui-jqgrid").show();
                            $('#gridChemo').jqGrid('setGridParam', {
                                data: Grid
                            }).trigger("reloadGrid");
                        }
                        else {
                            document.getElementById("DivOmitIndicator").style.display = "none";
                            $('#heading').hide();
                            $("#gridChemo").jqGrid("clearGridData", true);
                            $('#gridChemo').closest(".ui-jqgrid").hide();
                        }
                    }
                });
            }
            else {
                $('#txtChemoTextArea').val('');
                ChemoautoResize(document.getElementById("txtChemoTextArea"));

            }
        }

        function GetMedHistory() {
            let mrno = $.session.get('PatMRNO');
            let tranNo = $.session.get('PatTRANNO');
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetMedHistory",
                async: false,
                datatype: 'json',
                data: { strMRNo: mrno, strTranNo: tranNo },
                success: function (data) {
                    $('#txtCoMorbiditiesTextArea').val('');
                    if (data != "" && data.Comorbidities.length > 0) {
                        $('#txtCoMorbiditiesTextArea').val(data.Comorbidities);
                    }
                    else
                        $('#txtCoMorbiditiesTextArea').val(strCoMorbidities);
                }
            });
        }

        function ValidateBeforeSave() {
            HoldOn.open();
            let i = 0
            if ($('#TableICDOTBody tr').length == 0) {
                $.messager.alert("Alert", "Diagnosis is Mandatory");
                HoldOn.close();
                return false;
            }
            if ($("#LstChemoCourse").val() == "") {
                $("#LstChemoCourse").css("border", "2px solid red");
                i = 1;
            } else {
                $("#LstChemoCourse").css("border", "");
            }
            if ($("#LstTreatmentPlan").val() == "") {
                $("#LstTreatmentPlan").css("border", "2px solid red");
                i = 1;
            } else {
                $("#LstTreatmentPlan").css("border", "");
            }
            if ($("#txtPrevTreatTextArea").val() == "") {
                $("#txtPrevTreatTextArea").css("border", "2px solid red");
                i = 1;
            } else {
                $("#txtPrevTreatTextArea").css("border", "");
            }
            if ($("#txtCycles").val() == "") {
                $("#txtCycles").css("border", "2px solid red");
                i = 1;
            } else {
                $("#txtCycles").css("border", "");
            }
            if ($("#txtDurationDays").val() == "") {
                $("#txtDurationDays").css("border", "2px solid red");
                i = 1;
            } else {
                $("#txtDurationDays").css("border", "");
            }
            if ($("#txtRepeatAfter").val() == "") {
                $("#txtRepeatAfter").css("border", "2px solid red");
                i = 1;
            } else {
                $("#txtRepeatAfter").css("border", "");
            }




            //if ($("#txtChemoStart").val() == "") {
            //    $("#txtChemoStart").css("border", "2px solid red");
            //    i = 1;
            //}
            //else {
            //    $("#txtRepeatAfter").css("border", "");
            //}

            var FilterNoDoseRow = $("#gridChemo").jqGrid("getRowData").filter(function (A) { return A.DOSE == "" || Number(A.DOSE) == 0; });
            if (FilterNoDoseRow.length > 0) {
                HoldOn.close();
                var GenName = PHGenericNAmesLst.filter(function (item) { return item.Value.trim() == FilterNoDoseRow[0].GENERICNM.trim(); });
                var Msg = "Please Enter Dose For Cycle No. :" + FilterNoDoseRow[0].CYCLENO + " | Admission No. : " + FilterNoDoseRow[0].ADMNNO + " | Generic Name : " + GenName[0].Text.trim();
                $.messager.alert("Information", Msg);
                return false;
            }

            // JavaScript: Open dialog on your condition
            if ($('#cmbConStatus').val() != '') {
                if ($('#txtCompleteCycle').val() != $('#txtCycles').val()) {
                    HoldOn.close();

                    $('#customDialog').dialog({
                        title: 'Confirmation',
                        width: 400,
                        modal: true,
                        closed: false,
                        buttons: {
                            "Yes": function () {
                                $('#customDialog').dialog('close');
                                let prepDt = prepSaveData();
                                if (prepDt) {
                                    SaveService(prepDt);
                                }

                            },
                            "No": function () {
                                $('#customDialog').dialog('close');
                                $('#cmbConStatus').focus();
                            }
                        }

                    });

                    return false; // Prevent default further action until user clicks
                } else {
                    return true; // treatment complete, proceed normally
                }
            }

            if (i == 1) {
                HoldOn.close();
                $.messager.alert("Alert", "Please fill required Details");
                return false;
            } else {
                HoldOn.close();
                return true;
            }
        }

        function prepSaveData() {
            let consultNo = $.session.get("PatTRANNO");
            let tranno = $("#txtTRANID").val() || "";
            let mrno = $.session.get('PatMRNO');
            let chemoCourseName = $("#LstChemoCourse").val();
            let drugTextArea = $("#txtChemoTextArea").val();
            let chemoName = $("#LstChemoTName").val();
            let noOfCyle = $("#txtCycles").val();
            let repeatAfterDays = $("#txtRepeatAfter").val();
            let prevTreatment = $("#txtPrevTreatTextArea").val();
            let treatmentPlanCode = $("#LstTreatmentPlan").val();
            let tratmentModification = $("#txtModificationTextArea").val();
            let height = $("#txtHeight").val();
            let weight = $("#txtWeight").val();
            let bsa = $("#txtBSA").val();
            let hptReport = $("#txtHPReport").val();
            let hptReportRemark = $("#txtHPReportRemark").val();
            let patCat = $("#LstPatCat").val();
            let performanceStatus = $("#cmbPerformanceStatus").val();
            let scheme = $("#LstScheme").val();
            let t = $("#txtTstage").val();
            let n = $("#txtNstage").val();
            let m = $("#txtMstage").val();
            let prechemoFinding = $("#txtCoMorbiditiesTextArea").val();
            let entryDate = "";
            let m2 = "";
            let regime = "";
            let cancelRemarks = "";
            let schemeoth = "";
            let HrsDay = "";
            let DuraHrDay = $('#txtDurationDays').val();
            if ($("#ChkHours").prop("checked") == true) {
                HrsDay = "H";
                DuraHrDay = $("#txtDurationHrs").val();
            }
            else if ($("#ChkDay").prop("checked") == true) {
                HrsDay = "D";
                DuraHrDay = $("#txtDurationDays").val() == "" ? "0" : $("#txtDurationDays").val();
            }
            var gridChemo = $("#gridChemo").jqGrid('getRowData');
            $.grep(gridChemo, function (a) {
 delete a.CIMSINFO;
                var FilterGenNMLst = PHGenericNAmesLst.filter(function (item) { return item.Value.toLowerCase().trim() == a.GENERICID.toLowerCase().trim(); });
                var GenName = "";
                if (FilterGenNMLst.length > 0)
                    GenName = FilterGenNMLst[0].Text
                a.GENERICNM = GenName;
            });
            gridChemo = JSON.stringify(gridChemo);
            let TreatmentDone = "";
            let ConclusionStatus = "";
            if ($("#rbtnPlannedYes").prop("checked") == true) {
                TreatmentDone = "Y";
                ConclusionStatus = $('#cmbConStatus').val();
            }
            else if ($("#rbtnPlannedNo").prop("checked") == true) {
                TreatmentDone = "N";

            }
            let TreatmentDate = $('#txtTreatComplete').val();
            var ApplyScheme = SchemeListForSave.join(',');
            const dataToSend = {
                ConsultNo: consultNo,
                MRNO: mrno,
                EntryDate: entryDate,
                T: t,
                N: n,
                M: m,
                ChemoCourse: chemoCourseName,
                HPReport: hptReport,
                PrevTreatment: prevTreatment,
                PreChemoFindings: prechemoFinding,
                Height: height,
                Weight: weight,
                BSA: bsa,
                PerformStatus: performanceStatus,
                M2: m2,
                Regime: regime,
                ChemoName: chemoName,
                Protocol: drugTextArea,
                ToRepeat: repeatAfterDays,
                TreatmentPlan: treatmentPlanCode,
                TotalCycles: noOfCyle,
                TreatmentModification: tratmentModification,
                ICDYN: "Y",
                CancelRemarks: cancelRemarks,
                Scheme: scheme,
                SchemeOth: schemeoth,
                PatCatg: patCat,
                gact: gaction,
                TranNo: tranno,
                Duration: DuraHrDay,
                HourorDay: HrsDay,
                ReportRemark: hptReportRemark,
                gridChemo: gridChemo,
                TreatmentDone: TreatmentDone,
                ConclusionStatus: ConclusionStatus,
                TreatmentDate: TreatmentDate,
                SchemeCodes: ApplyScheme,
                ChemoStartDate: $('#txtChemoStart').val(),
            }
            return dataToSend;
        }

        function SaveService(dataToSend) {
            HoldOn.open();
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/GetMedOncoSave',
                datatype: 'json',
                data: dataToSend,
                success: function (response) {
                    if (gaction == "N")
                        $("#txtTRANID").val(response.ConsultNo);
                    if ($("#rbtnPlannedYes").prop("checked"))
                        $.messager.alert("Alert", "Saved Successfully.");
                    else
                        $.messager.alert("Alert", response.message);
                    if (response.success) {
                        $("#btnSave").text(' Update');
                        gaction = "E";
                        if ($("#rbtnPlannedYes").prop("checked") != true)
                            PrintChemo();
                        window.location.reload();
                    }
                    else {

                    }
                },
                error: function (xhr, status, error) {
                    console.log("error =>", status);
                },
                complete: function () {
                    HoldOn.close()
                }
            });
        }

        function GetVitalData() {
            let tranNo = $.session.get('PatTRANNO');
            let mrno = $.session.get('PatMRNO');
            HoldOn.open();
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/SetDataForVitals',
                datatype: 'json',
                data: { strTranNo: tranNo, Type: "V", strMRNo: mrno },
                success: function (response) {
                    if (response != "") {
                        if (response.Weight > 0) {
                            $("#txtWeight").val(response.Weight);
                        }
                        else {
                            $("#txtWeight").val('0');
                        }

                        if (response.HEIGHT > 0) {
                            $("#txtHeight").val(response.HEIGHT);
                        }
                        else {
                            $("#txtHeight").val('0');
                        }

                        $("#txtBSA").val(response.BSA);
                    }
                },
                error: function (xhr, status, error) {
                    console.log("error =>", status);
                },
                complete: function () {
                    HoldOn.close()
                }
            });
        }

        function GetDiagnosisData() {
            let tranNo = $.session.get('PatTRANNO');
            HoldOn.open();
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/SetDataForDiagnosis',
                datatype: 'json',
                data: { strTranNo: tranNo },
                success: function (response) {
                    if (response != "") {
                        let tstage = response[2][0].TSTAGE || "";
                        let nstage = response[2][0].NSTAGE || "";
                        let mstage = response[2][0].MSTAGE || "";
                        $("#txtTstage").val(tstage);
                        $("#txtNstage").val(nstage);
                        $("#txtMstage").val(mstage);
                    }
                },
                error: function (xhr, status, error) {
                    console.log("error =>", status);
                },
                complete: function () {
                    HoldOn.close()
                }
            });
        }

        function GetMedOncoData() {
            let TranNo = $.session.get('PatTRANNO');
            let ConsultNo = $.session.get('ChemoConsultNo');
            let mrno = $.session.get('PatMRNO');
            if (!mrno) {
                $.messager.alert("Alert", "Please Select Patient.");
                return false;
            }
            HoldOn.open();
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../DoctorDesk/GetMedOncoData',
                async: false,
                data: { strConsultNo: ConsultNo, MrNo: mrno, TranNo: TranNo },
                success: function (response) {
                    response = response.data;
                    if (Array.isArray(response) && response.length > 0) {
                        if (response[0].PLANCOMPLETE != "Y") {
                            let chemoCourse = response[0].CHEMOCOURSE;
                            let treatmentPlan = response[0].TREATMENTPLAN;
                            let previousTreatment = response[0].PREVTREATMENT;
                            let chemoName = response[0].CHEMOTHERAPYNM;
                            let protocol = response[0].PROTOCOL;
                            let performanceStatus = response[0].PERFORMANCESTATUS;
                            let hpreport = response[0].HPREPORT;
                            let patcat = response[0].PATCAT;
                            let scheme = response[0].SCHEME;
                            let totalNocycle = response[0].TOTALCYCLE;
                            let repeateAfterCyle = response[0].REPEATAFTER;
                            let modification = response[0].MODIFICATION;
                            let morbidies = response[0].CLINICALFIND;
                            let hpreportremark = response[0].HPREPORTREMARK;
                            let tstage = response[0].T;
                            let nstage = response[0].N;
                            let mstage = response[0].M;
                            let weight = response[0].WEIGHT;
                            let height = response[0].HEIGHT;
                            let bsa = response[0].BSA;
                            let TranID = response[0].TRANID;
                            let ProtoColtype = response[0].PROTOCOLTYPE;
                            strCoMorbidities = response[0].CLINICALFIND;
                            DataMigration = response[0].DATAMIGRATION
                            $("#LstChemoCourse").val(chemoCourse);
                            $("#LstTreatmentPlan").val(treatmentPlan);
                            $("#txtPrevTreatTextArea").val(previousTreatment);

                            $("#cmbPerformanceStatus").val(performanceStatus);
                            $("#txtHPReportRemark").val(hpreportremark);
                            $("#txtCoMorbiditiesTextArea").val("");
                            $("#LstPatCat").val(patcat);
                            $("#LstScheme").val(scheme);
                            $("#txtCycles").val(totalNocycle);
                            getCycleCount();
                            $("#txtRepeatAfter").val(repeateAfterCyle);
                            $("#txtModificationTextArea").val(modification);
                            $("#txtCoMorbiditiesTextArea").val(morbidies);
                            $("#txtTstage").val(tstage);
                            $("#txtNstage").val(nstage);
                            $("#txtMstage").val(mstage);
                            $("#txtWeight").val(weight);
                            $("#txtHeight").val(height);
                            $("#txtBSA").val(bsa);
                            $("#LstChemoTName").val(chemoName);
                            $("#txtDurationDays").val(response[0].DURATION);
                            $("#txtTRANID").val(TranID);
                            if (ProtoColtype == "U") {
                                $("#txtChemoTextArea").val(protocol);
                                $('#chkStructure').prop("disabled", true);
                                document.getElementById("DivOmitIndicator").style.display = "none";
                                ChemoautoResize(document.getElementById("txtChemoTextArea"));
                            }
                            else if (ProtoColtype == "S") {
                                if (response[0].DATAMIGRATION == "Y" && response[0].MIGRATIONPLANNEDYN != "Y") {
                                    GetProtocol();
                                    totalCycle = totalNocycle;
                                    completeycle = response[0].COMPLETEDCYCLES;
                                    currentCycle = Number(totalNocycle) - Number(completeycle);
                                    pendingCycle = Number(totalNocycle) - Number(currentCycle);
                                    $('#txtCompleteCycle').val(completeycle);
                                    $('#txtcurrentCycle').val(currentCycle);
                                    EditPreDisableFields(false);
                                    $('#gridChemo').find('input[type="checkbox"]').prop('disabled', true);
                                }
                                else {
                                    GetchemoSMedication();
                                }
                                document.getElementById("DivOmitIndicator").style.display = "flex";
                            }
                            if (response[0].PLANCOMPLETE == "Y") {
                                $("#rbtnPlannedYes").prop("checked", true).trigger('click');
                                $("#cmbConStatus").val(response[0].COMPLETESTATUS).trigger('change');
                                $('#txtTreatComplete').val(response[0].COMPLETEDATE);
                            }
                            else if (response[0].PLANCOMPLETE == "N") {
                                $("#rbtnPlannedNo").prop("checked", true).trigger('click');
                            }
                            if (response[0].HRSORDAY == "H") {
                                $("#ChkHours").prop("checked", true);
                                $("#txtDurationHrs").val(response[0].DURATION);
                            }
                            else if (response[0].HRSORDAY == "D") {
                                $("#ChkDay").prop("checked", true);
                            }
                            else {
                                $("#ChkHours").prop("checked", false);
                                $("#ChkDay").prop("checked", false);
                            }
                            $('#txtChemoStart').val(response[0].ADVSTARTDATE);
                            BindSavedScheme(("" + response[0].SCHEMECODES).toString().trim());
                            gaction = "E";
                            $("#btnSave").text(' Update');
                            $("#btnPrint").show();
                        }
                        else {
                            $("#btnPrint").hide();
                            getCycleCount();
                        }
                    }
                    else {
                        $("#btnPrint").hide();
                        getCycleCount();
                    }
                },
                error: function (xhr, status, error) {
                    console.log("error =>", status);
                },
                complete: function () {
                    HoldOn.close();
                }
            })
        }

        function DurationShowHide() {
            if ($("#ChkHours").prop("checked") == true) {
                document.getElementById("DaysDiv").style.display = "none";
                document.getElementById("HourDiv").style.display = "flex";
                $("#txtDurationDays").val("");
            }
            else if ($("#ChkDay").prop("checked") == true) {
                document.getElementById("HourDiv").style.display = "none";
                document.getElementById("DaysDiv").style.display = "flex";
                $("#txtDurationHrs").val("");
            }
            else {
                document.getElementById("HourDiv").style.display = "none";
                document.getElementById("DaysDiv").style.display = "none";
                $("#txtDurationDays").val("");
                $("#txtDurationHrs").val("");
            }
        }

        function AppendPerformStatus() {
            $("#cmbPerformanceStatus").empty();
            var Option = "<option value='{OPTVALUE}'>{OPTTEXT}</>"
            $.grep(PerformStatusList, function (a) {
                var RplOption = Option.replace("{OPTVALUE}", a.VALUE).replace("{OPTTEXT}", a.TEXT);
                $("#cmbPerformanceStatus").append(RplOption);
            });
        }

        function disabled(CycleNo) {
            if (parseInt(CycleNo) > 1) {
                $('#LstChemoCourse, #LstTreatmentPlan, #txtCoMorbiditiesTextArea, #txtHPReport, #txtHPReportRemark, #LstChemoTName, #txtChemoTextArea', '#txtDurationHrs', '#txtCycles', '#txtRepeatAfter', '#txtDurationDays')
                    .attr("disabled", true);
            } else {
                $('#LstChemoCourse, #LstTreatmentPlan, #txtCoMorbiditiesTextArea, #txtHPReport, #txtHPReportRemark, #LstChemoTName, #txtChemoTextArea', '#txtDurationHrs', '#txtCycles', '#txtRepeatAfter', '#txtDurationDays')
                    .attr("disabled", false);
            }
        }

        function GetchemoSMedication() {
            var DataToSend = {
                MRNo: $.session.get('PatMRNO'),
                PlanNo: $("#txtTRANID").val(),
                CycleNo: $('#txtCompleteCycle').val().trim() === '' ? $('#txtcurrentCycle').val() : $('#txtCompleteCycle').val()
            };
            $.ajax({
                url: '../DoctorDesk/GetchemoSMedication',
                data: DataToSend,
                type: 'POST',
                async: false,
                success: function (response) {
                    if (response.data && response.data.length > 0) {
                        document.getElementById("DivChemoArea").style.display = "none";
                        $('#txtChemoTextArea').hide();
                        $('#heading').show();
                        getCycleCount();
                        ShowPlanCompleteLst();
                        $('#gridChemo').jqGrid('setGridParam', {
                            data: response.data
                        }).trigger("reloadGrid");
                        ChemoautoResize(document.getElementById("txtChemoTextArea"));
                    } else {
                        $('#heading').hide();
                        $("#gridChemo").jqGrid("clearGridData", true);
                        $('#gridChemo').closest(".ui-jqgrid").hide();
                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                    HoldOn.close();
                }
            });
        }

        function getCycleCount() {
            var DataToSend = {
                MRNo: $.session.get('PatMRNO'),
                StrProtocole: $('#LstChemoTName').val()
            };
            $.ajax({
                url: '../DoctorDesk/GetCycleCount',
                data: DataToSend,
                type: 'POST',
                async: false,
                success: function (response) {
                    response = response.data;
                    if (Array.isArray(response) && response.length > 0) {
                        currentCycle = $('#txtCycles').val() == "" ? "0" : response[0].CYCLENO;
                        totalCycle = $('#txtCycles').val() == "" ? "0" : $('#txtCycles').val();
                        $('#txtCompleteCycle').val(currentCycle);
                        pendingCycle = parseInt(totalCycle) - (parseInt(currentCycle));
                        $('#txtcurrentCycle').val(pendingCycle == 0 ? '' : parseInt(currentCycle) + 1);
                        disabled(currentCycle);

                    } else {
                        $('#txtcurrentCycle').val(1);

                        disabled(1);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                    HoldOn.close();
                }
            });
        }

        function PrintChemo() {
            HoldOn.open();
            var cycle = $("#txtcurrentCycle").val().trim() == "" ? $("#txtCompleteCycle").val() : $("#txtcurrentCycle").val();
            var DataToSend = {
                MRNo: $.session.get('PatMRNO'),
                ConsultNo: $.session.get('ChemoConsultNo'),
                PlanNo: $("#txtTRANID").val(),
                CycleNo: cycle,
                StrProtocole: $('#LstChemoTName').val()
            };
            $.ajax({
                url: '../DoctorDesk/PrintChemoPlanning',
                data: DataToSend,
                type: 'post',
                async: false,
                success: function (response) {
                    var win = window.open('../DoctorDesk/DisplayPrintChemoPlan', "_blank", '', true);
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

        function PatMedicationHistory() {
            var mrno = $.session.get('PatMRNO');
            $("#tbldiv").empty();
            $.ajax({
                type: "POST",
                url: 'GetchemoHistory',
                datatype: "json",
                data: { strMrNo: mrno },
                async : false,
                success: function (Response) {
                    var result = Response.data;
                    var resultTbl = Array.isArray(Response.data1) && Response.data1.length > 0 ? Response.data1 : [];
                    if (Array.isArray(result) && result.length > 0) {
                        var HTotalCycle = totalCycle;
                        if (result.length == 1) {
                            if (result[0].TOTALCYCLE == "")
                                HTotalCycle = $("#txtCycles").val();
                            else
                                HTotalCycle = result[0].TOTALCYCLE;
                        }
                        var HCurCycle = currentCycle;
                        if (result.length == 1) {
                            HCurCycle = result[0].ENDDATE == "" ? "0" : "1";
                        }
                        var HPendCycle = pendingCycle;
                        if (result.length == 1) {
                            HPendCycle = result[0].ENDDATE == "" ? Number(HTotalCycle) : Number(HTotalCycle) - 1;
                        }
                        var Header =
                            "<div style='background-color: #6c88c4; color: white; padding: 10px; font-weight: bold; font-size: 14px; margin-bottom: 10px; display: flex; justify-content: space-between;'>" +
                                "<span>✅ Total No of Cycle(s) : " + HTotalCycle + "</span>" +
                                "<span>✔️ Completed Cycle(s) : " + HCurCycle + "</span>" +
                                "<span>⏳ Pending Cycle(s) : " + HPendCycle + "</span>" +
                            "</div>";
                        $("#tbldiv").append(Header);
                        for (var i = 0; i < result.length; i++) {
                            var $divPanel = $("<div style='border: 1px solid #ccc;margin-bottom: 10px; overflow: hidden;'></div>");
                            var $divPanelHead = $("<div style='background-color: #6c88c4; color: white; padding: 6px 10px; font-weight: bold; display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; font-size: 14px; cursor: pointer;'></div>");
                            var strTable = "";
                            if (result[i].CYCLENO && result[i].CYCLENO.trim() !== "") {
                                strTable =
                                    (result[i].ENDDATE == "" ? "" : "<span style='color: #b9ffb1; font-size: 1.2em;'><i class='fa fa-check' aria-hidden='true'></i></span>") +
                                    "<span style='margin-left: 5px;'>Plan No : " + result[i].PLANID + " (IP VISIT)</span>" +
                                    "<span style='margin-left: auto; display: flex; align-items: center;'>" +
                                    "Date : " + formatDate(result[i].TRANDATE) +
                                    "&nbsp;&nbsp;Cycle  : " + result[i].CYCLENO +
                                    "</span>";
                            } else {
                                strTable =
                                    (result[i].ENDDATE == "" ? "" : "<span style='color: #b9ffb1; font-size: 1.2em;'><i class='fa fa-check' aria-hidden='true'></i></span>") +
                                    "<span style='margin-left: 5px;'>Plan No : " + result[i].PLANID + " (OP VISIT)</span>" +
                                    "<span style='margin-left: auto; display: flex; align-items: center;'>" +
                                    "Date : " + formatDate(result[i].TRANDATE) +
                                    "</span>";
                            }
                            $divPanelHead.html(strTable);
                            var $divPanelBody = $("<div style='background: #fff; padding: 10px 15px; font-size: 14px; border-top: none;'></div>");
                            var strTable1 = "";
                            var PTableId = "";
                            var PContentTblId = "";
                            var FilterData = resultTbl.filter(function (A) { return A.PLANID == result[i].PLANID && A.CYCLENO == result[i].CYCLENO;; });
                            var DisplayProtocolTxt = "block";
                            var DisplayProtocolTbl = "none";
                            if (FilterData.length > 0) {
                                DisplayProtocolTxt = "none";
                                DisplayProtocolTbl = "block";
                                PTableId = "HistoryChemo_Tbl_" + i;
                                PContentTblId = "HistoryChemo_Cont_" + i;
                            }
                            if (result[i].CYCLENO && result[i].CYCLENO.trim() !== "") {
                                strTable1 =
                                    "<div style='background-color: #e6e9eb; padding: 6px 10px; border: 1px solid #c8c4c4; font-weight: bold; margin-bottom: 10px; font-size: 14px;'>" +
                                        "&nbsp;&nbsp; Start Date: " + formatDate(result[i].STARTDATE) +
                                        "&nbsp;&nbsp; End Date: " + formatDate(result[i].ENDDATE) +
                                    "</div>" +
                                    "<div style='margin-bottom: 10px;'><b>Chemotherapy Name:</b> " + result[i].NAME + "</div>" +
                                    "<div style='margin-top: 10px;'><b>Protocol:</b><br>" +
                                        "<div style='border: 1px solid #ccc; padding: 10px; background-color: #f9f9f9; font-size: 13px; line-height: 1.6; white-space: pre-wrap; display:" + DisplayProtocolTxt + "'>" +
                                            result[i].PROTOCOL +
                                        "</div>" +
                                        "<div id='" + PContentTblId + "' class='col-12' style='overflow-x: auto; padding: 0; display:" + DisplayProtocolTbl + "'>" +
                                            "<table id='" + PTableId + "' class='table table-bordered' style='width: auto; min-width: fit-content; white-space: nowrap;'></table>" +
                                        "</div>" +
                                    "</div>";
                            } else {
                                strTable1 =
                                    "<div style='margin-top: 10px;'><b>Modification During Treatment:</b><br>" +
                                        "<div style='border: 1px solid #ccc; padding: 10px; background-color: #f9f9f9; font-size: 13px; line-height: 1.6; white-space: pre-wrap;'>" +
                                            result[i].MODIFYMEDS +
                                        "</div>" +
                                    "</div>";
                            }
                            $divPanelBody.html(strTable1);
                            $divPanelHead.on('click', function () {
                                $(this).next().slideToggle();
                            });
                            $divPanel.append($divPanelHead).append($divPanelBody);
                            $("#tbldiv").append($divPanel);
                            $divPanelHead.trigger('click');
                            if (PTableId != "") {
                                HistShowPlanCompleteLst(PTableId, PContentTblId);
                                $('#' + PTableId).jqGrid('setGridParam', {
                                    data: FilterData
                                }).trigger("reloadGrid");
                            }
                        }
                    } else {
                        $("#tbldiv").html(
                            "<div class='panel'>" +
                                "<div class='panel-body divBody' style=\"font-size:20px; text-align:center;height: auto;width: auto; font-weight:bold; color:#555; white-space:nowrap;\">" +
                                    "No History Found For This Record" +
                                "</div>" +
                            "</div>"
                        );
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                    HoldOn.close();
                }
            });
        }

        function formatDate(yyyymmdd) {
            if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd;
            var year = yyyymmdd.substring(0, 4);
            var month = yyyymmdd.substring(4, 6);
            var day = yyyymmdd.substring(6, 8);
            return day + "-" + month + "-" + year;
        }

        function HistShowPlanCompleteLst(GridId, ContentId) {
            $("#" + GridId).jqGrid("GridUnload");
            jQuery("#" + GridId).jqGrid({
                datatype: 'local',
                data: [],
                colModel: [
                    { label: 'Medicine Type', name: 'MEDTYPE', width: 120, editable: false, hidden: true },
                    { label: 'Apply To Day', name: 'APLYTODAY', width: 100, align: "center", hidden: true },
                    { label: 'On Day', name: 'ONDAY', width: 100, align: "center" },
                    { label: 'Med. Set No.', name: 'MEDSETNO', width: 100, editable: false, hidden: true },
                    { label: 'Generic Code', name: 'GENERICID', width: 100, hidden: true },
                    { label: 'Drug Form', name: 'DRUGFORM', width: 120, editable: false },
                    { label: 'Generic Name', name: 'GENERICNM', width: 150, editable: false },
                    { label: 'Dose', name: 'DOSE', width: 120, editable: false, align: "right" },
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
                    { label: 'Original Dose', name: 'ORIGINALDOSE', width: 120, editable: false, align: "right" },
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

        // Added by Dhananjay 202500924
        function EditPreDisableFields(isDisable) {
            if (gaction == "E") {
                let colModel = $('#gridChemo').jqGrid('getGridParam', 'colModel');
                if (colModel) {
                    var findDose = colModel.find(function (x) {
                        return x.name == "DOSE";
                    });

                    var omitDrug = colModel.find(function (x) {
                        return x.name == "OMITDRUG";
                    });

                    var dilute = colModel.find(function (x) {
                        return x.name == "DILUENT";
                    });

                    if (dilute && typeof dilute == 'object') {
                        dilute.editable = false;
                    }

                    if (omitDrug && typeof omitDrug == 'object') {
                        omitDrug.editable = false;
                    }

                    if (findDose && typeof findDose == 'object') {
                        findDose.editable = isDisable;
                    }

                    if (isDisable) {
                        var ids = $("#gridChemo").jqGrid('getDataIDs');
                        ids.forEach(function (rowId) {
                            var rowData = $("#gridChemo").jqGrid('getRowData', rowId);
                            var shouldDisable = (rowData.ADMNSTATUS == 'Y');
                            $('#' + rowId).find('input[type="checkbox"]').prop('disabled', shouldDisable);
                        });
                    }
                    else {
                        $('#gridChemo').find('input[type="checkbox"]').prop('disabled', true);
                    }
                }
                if ($('#cmbConStatus').val() != "") {
                    $('#rbtnPlannedYes').prop('disabled', isDisable);
                    $('#rbtnPlannedNo').prop('disabled', isDisable);
                    $('#btnSave').hide();
                    if (isDisable) {
                        $('#SchemeInput').show();
                        $(".REMOVESCHICON").show();
                        $('#SchemeInput').prop('disabled', true);
                    }
                }
                else {
                    $('#rbtnPlannedYes').prop('disabled', !isDisable);
                    $('#rbtnPlannedNo').prop('disabled', !isDisable);
                    $('#cmbConStatus').prop('disabled', !isDisable);
                    $('#txtTreatComplete').prop('disabled', !isDisable);
                    if (isDisable) {
                        $('#SchemeInput').show();
                        $(".REMOVESCHICON").show();
                        $('#SchemeInput').prop('disabled', false);
                    }
                }
            }
            else {
                $('#ChemoEditProcessId').hide();
            }

            $('#myBtn').hide();
        }

        function EDisableEventProcess(isDisable) {
            $('#LstChemoCourse').prop('disabled', isDisable);
            $('#LstTreatmentPlan').prop('disabled', isDisable);
            $('#txtRepeatAfter').prop('disabled', isDisable);
            $('#txtCycles').prop('disabled', isDisable);
            $('#txtDurationDays').prop('disabled', isDisable);
            $('#LstChemoTName').prop('disabled', isDisable);
            $('#LstChemoTName').prop('disabled', isDisable);
            $('#chkStructure').prop('disabled', isDisable);
            $('#txtModificationTextArea').prop('disabled', isDisable);
            $('#rbtnPlannedYes').prop('disabled', isDisable);
            $('#rbtnPlannedNo').prop('disabled', isDisable);
            $('#txtChemoStart').prop('disabled', isDisable);
            $('#cmbConStatus').prop('disabled', isDisable);
            $('#txtTreatComplete').prop('disabled', isDisable);
            // Set Edit Flag 
            $('#isEditYN').val('N');
            if ($('#isEditYN').val() == 'N' && gaction == 'E') {
                document.getElementById('btnSave').textContent = 'Edit';
            }
            $('#SchemeInput').prop('disabled', isDisable);
            if (isDisable) {
                $('#SchemeInput').hide();
                $(".REMOVESCHICON").hide();
            }
            else {
                $('#SchemeInput').show();
                $(".REMOVESCHICON").show();
            }

            let totalCompletedCycle = Number($('#txtCompleteCycle').val())
            let totalNoCycle = Number($('#txtCycles').val())
            if (totalCompletedCycle == totalNoCycle) {
                NewAction();
            } else {
                $('#btnSave').show();
            }
        }

        function NewAction() {
            gaction = "N";
            disabled(1);
            document.getElementById('btnSave').textContent = 'Save';
            $("#chkStructure").prop("checked", true);
            CalculateDose();
            $('#btnSave').show();
            $('#btnPrint').hide();
            $('#TreatConStatus').hide();
            $('#ConStatus').hide();
            document.getElementById("DivOmitIndicator").style.display = "none";
            $('#heading').hide();
            $('#gridChemo').closest(".ui-jqgrid").hide();
            $("#gridChemo").jqGrid("clearGridData", true);
            $("#txtChemoTextArea").val("");
            $('#LstChemoCourse,#LstTreatmentPlan,#txtCoMorbiditiesTextArea,#txtHPReport,#txtHPReportRemark,#LstChemoTName,#txtChemoTextArea,#txtDurationHrs,#txtCycles,#txtRepeatAfter,#txtDurationDays,#txtModificationTextArea,#chkStructure,#txtChemoStart').prop("disabled", false);
            $("#LstChemoCourse").val("");
            $("#LstTreatmentPlan").val("");
            $("#LstChemoTName").val("");
            $("#txtDurationDays").val("");
            $("#txtCycles").val("");
            $("#txtRepeatAfter").val("");
            $("#txtCompleteCycle").val("");
            $('#txtcurrentCycle').val(1);
            $("#txtModificationTextArea").val("");
            $('#rbtnPlannedNo').prop("checked", true);
            $("#cmbConStatus").val("");
            $("#txtChemoStart").val("");
            $("#txtTRANID").val("");
            document.getElementById('txtPlanNo').textContent = "";
            $('#PlanningNoDivId').hide();
            GetMedHistory();
            GetVitalData();
            ChemoautoResize(document.getElementById("txtChemoTextArea"));
        }

        function EditChemoProcessFn() {
            HoldOn.open();
            EditPreDisableFields(true);
            HoldOn.close();
        }
    </script>

    <%-- Scheme --%>
    <script type="text/javascript">
        var SchemeListForSave = [];
        var AllSchemeList = [];
        function SearchScheme() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("SchemeInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblScheme");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if ((filter.length > 2 && td.innerHTML.toUpperCase().indexOf(filter) > -1) || filter.length < 2) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function SchemePatList() {
            var strMRNo = $.session.get('PatMRNO');
            var strCompCode = $.session.get('ComCode');
            AllSchemeList = [];
            $.ajax({
                url: '../DoctorDesk/GetSchemaList',
                data: { PatMRNO: strMRNo, Speciality: "M", strCompCode: strCompCode },
                type: 'post',
                async: true,
                datatype: 'json',
                success: function (response) {
                    if (response.length > 0) {
                        $('#tblScheme').empty();
                        $.each(response, function (i, item) {
                            var rows = "<tr id=TR_'" + item.Value + "' style='display:none'>" + "<td style='width: 20px'> <input type='checkbox' onclick='UpdateSchemeDataForSave(this.id)' id='" + item.Value + "' value='" + item.Text + "' /> </td>" + "<td>" + item.Text + "</td>" + "</tr>";
                            $('#tblScheme').append(rows);
                        });
                        AllSchemeList = response;
                    }
                    else {
                        document.getElementById("SchemeMainDiv").style.display = "none";
                    }
                }
            });
        }

        function UpdateSchemeDataForSave(ChckId) {
            var CheckedYN = $("#" + ChckId).prop("checked");
            var FilterScheme = AllSchemeList.filter(function (item) { return item.Value.trim() == ChckId.trim(); });
            var TList = SchemeListForSave.filter(function (item) { return item != ChckId.trim(); });
            if (CheckedYN == true) {
                AddSchemeData(FilterScheme[0].Value.trim(), FilterScheme[0].Text.trim());
                TList.push(FilterScheme[0].Value.trim());
            }
            else {
                RemoveSchemeData(ChckId);
            }
            SchemeListForSave = TList;
        }

        function AddSchemeData(SchemeCode, SchemeName) {
            var Tr = "<tr id='{TRID}'>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            var TRID = "TR_SCH_" + SchemeCode;
            var RemIcon = "<i class='fa fa-trash REMOVESCHICON' style='font-size: 18px;' aria-hidden='true' onclick=\"$('#{SCHEMECODE}').trigger('click');\"></i>";
            var InfoIcon = "<i class='fa fa-info-circle INFOSCHICON' style='font-size: 18px;' aria-hidden='true' onclick=\"OpenPopInfoScheme('{SCHEMECODE}')\"></i>";
            var ActDiv = "<div style='display: flex;align-items: center;justify-content: center;gap: 20px;'>{DIVCONTENT}</div>";
            var RplRemIcon = RemIcon.replace("{SCHEMECODE}", SchemeCode);
            var RplInfoIcon = InfoIcon.replace("{SCHEMECODE}", SchemeCode);
            var RplActDiv = ActDiv.replace("{DIVCONTENT}", (RplRemIcon + RplInfoIcon));
            var ActTd = Td.replace("{STYLE}", "").replace("{TDCONTENT}", RplActDiv);
            var NameTd = Td.replace("{STYLE}", "text-align: left;").replace("{TDCONTENT}", SchemeName);
            var RplTR = Tr.replace("{TRID}", TRID).replace("{TRCONTENT}", (ActTd + NameTd));
            $("#TableSchemeTBody").append(RplTR);
        }

        function RemoveSchemeData(SchemeCode) {
            var TRID = "TR_SCH_" + SchemeCode;
            if (document.getElementById(TRID)) {
                document.getElementById(TRID).remove();
            }
        }

        function GetSchemeInfo(SchemeCode) {
            var SchemeInfoDtls = [];
            $.ajax({
                url: '../DoctorDesk/GetSchemaInfo',
                data: { SchemeCode: SchemeCode },
                type: 'post',
                async: false,
                datatype: 'json',
                success: function (response) {
                    if (response != "") {
                        SchemeInfoDtls = response;
                    }
                }
            });
            return SchemeInfoDtls;
        }

        function BindSchemeInfo(SchemeCode) {
            var Dtls = GetSchemeInfo(SchemeCode);
            document.getElementById("SchemeLbl").innerText = Dtls[0][0].SCHEMENAME;
            document.getElementById("PreReqLbl").innerText = Dtls[0][0].PREADVICE;
            document.getElementById("AdvRmksLbl").innerText = Dtls[0][0].POSTADVICE;
            if (Dtls[1] != null && Dtls[1].length > 0) {
                var PreData = "";
                var PostData = "";
                $.grep(Dtls[1], function (e) {
                    if (e.LINKTYPE == "P")
                        PreData = PreData + (PreData == "" ? e.SERVNAME : ("," + e.SERVNAME));
                    if (e.LINKTYPE == "O")
                        PostData = PostData + (PostData == "" ? e.SERVNAME : ("," + e.SERVNAME));
                });
                document.getElementById("PreInvstLbl").innerText = PreData;
                document.getElementById("PostInvstLbl").innerText = PostData;
            }
        }

        function BindSavedScheme(CodeLst) {
            var SpltCodeLst = CodeLst.split(',');
            $.grep(SpltCodeLst, function (e) {
                if (e.trim() != "" && document.querySelector('#tblScheme input[type="checkbox"][id="' + e.trim() + '"]')) {
                    document.querySelector('#tblScheme input[type="checkbox"][id="' + e.trim() + '"]').click();
                }
            });
        }

        //Open Popup Div
        function OpenPopInfoScheme(SchemeCode) {
            document.getElementById("InfoHeadLabel").innerText = "Scheme Info";
            BindSchemeInfo(SchemeCode);
            document.getElementById("POPUPInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
        }

        //Close Popup Div
        function ClosePop(DivId) {
            document.getElementById(DivId).style.display = 'none';
            document.documentElement.style.overflow = '';
        }
    </script>
    <style>
        #tblSchemeWrapper {
            max-height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
            border-radius: 5px;
            margin-top: 5px;
            position: absolute;
            width: 100%;
            z-index: 100000000000000;
        }

        #tblScheme {
            margin-bottom: 10px !important;
            background-color: #fbe3e3;
            font-size: 12px;
            box-shadow: 1px 0px 4px 0px #344;
        }

        @media only screen and (min-width : 992px) {
            #tblScheme {
                margin-left: 60px;
            }
        }   

        .SchemeModal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

            .SchemeModal .Scheme-modal-content {
                background-color: white;
                margin: 10% auto;
                width: auto;
                max-width: 95vw;
                border-radius: 5px;
                bottom: auto !important;
                max-height: 95vh;
                overflow: auto;
            }

        .ModelHeaderDiv {
            background-color: #003f74;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 5px;
            font-size: 13px;
        }

        .SchemeHeader {
            background: #043362 !important;
            border-radius: 0px;
        }

        .closeMdlBtn {
            cursor: pointer;
            font-weight: bold;
            font-size: 25px;
            width: 35px;
            height: 25px;
            position: relative;
            top: -5px;
            text-align: center;
        }

        .ModelContentDiv {
            padding: 5px 0px;
        }
    </style>
    <%-- Added By Roshan CIMS Info 20251208 --%>
      <style type="text/css">
  .CIMS-container {
    display: flex;
    flex-direction: column;  /* stack header, body, footer */
    width: 100%;
    max-height: 80vh;        /* limit dialog height to viewport */
    overflow: hidden;        /* prevent container scroll */
}

.CIMS-body {
    flex: 1;                 /* take remaining space */
    overflow-y: auto;        /* only this scrolls */
    padding-right: 10px;
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
    }

</style>
  <script type="text/javascript">
      function InfoBtnFormatter(cellvalue, options, rowObject) {
          // rowObject contains all the row data, so rowObject.MTRLCODE is the material code
          var materialCode = rowObject.GENERICID;

          var buttonset = '<span class="fa fa-info-circle" ' +
              'style="cursor:pointer; color:#2d70aa;" ' +
              'onclick="getDrugInfo(\'' + materialCode + '\')">' +
              '</span>';
          return buttonset;
      }
          function subscribeCIMSServices(type, gridId) {
              if (type == "I") {
                  GetDrugInterationService(gridId).then(function (response) {
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
                                  $.messager.alert( "Information",response.Status);
                              }
                          }
                      }
                  }).catch(function (error) {
                      $.messager.alert('Warning', 'Kindly Contact IT');
                  });

              } else if (type == "D") {
                  GetDrugDuplicateService(gridId).then(function (response) {
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
                  GetDrugInterationService(gridId).then(function (response) {
                      $('#CIMSBody').empty();
                      if (response && response == "0") {
                          // ignore
                      } else {
                          if (typeof response == 'object') {
                              if (response.AlertYN == true) {
                                  Blink("#btnInformant");
                              } else {
                                  stopBlink("#btnInformant");
                              }
                          }
                      }
                  }).catch(function (error) {
                      $.messager.alert('Warning', 'Kindly Contact IT');
                  });

                  GetDrugDuplicateService(gridId).then(function (response) {
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
          function toogleButtons(id) {
              var rowCount = $('#' + id).jqGrid('getGridParam', 'reccount');
              if (rowCount >= 2) {
                  $('#btnInformant,#btnDuplicate').show();
                  subscribeCIMSServices("", id);
              } else {
                  $('#btnInformant,#btnDuplicate').stop(true, true).hide();
              }
          }

          function preapreDataForCIMS(gridId) {
              var rowIds = $('#' + gridId).jqGrid('getDataIDs');
              var MaterialCodes = [];
              for (var i = 0; i < rowIds.length; i++) {
                  var rowData = $('#' + gridId).jqGrid('getRowData', rowIds[i]);
                  MaterialCodes.push(rowData.GENERICID);
              }
              var DataToSend = {
                  DrugCodes: JSON.stringify(MaterialCodes),
                  Type: "html"
              };
              return DataToSend;
          }

      function ChemoautoResize(textarea) {
          textarea.style.height = "auto";              // Reset height
          textarea.style.height = textarea.scrollHeight + "px"; // Set to content height
      }

      
  </script>
  <script src="../Scripts/_CimsCommon.js"></script>
  <%-- End By Roshan CIMS Info 20251208 --%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="" style="text-align: center; padding: 15px; display: none">
        <h3 class="panel-title" style="margin: 0; font-weight: bold; font-size: 1.8em; display: flex; align-items: center; justify-content: center; gap: 10px;">
            <span>Planning <small style="font-weight: normal; font-size: 0.6em; color: #666;">(Chemotherapy Planning)</small></span>
        </h3>
    </div>
    <label id="myBtn" style="background-color: transparent; float: right; margin-right: 25%; border-color: transparent;display:none;" title="Save">
        <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed; z-index: 10000000000000;">
    </label>
    <div class="form-container">
        <div class="row" style="margin: 0;">
             <%-- Added by Dhananjay 20250924 --%>
             <div id="PlanningNoDivId" style="display: flex; flex-wrap: wrap; justify-content: flex-end; width: 100%; font-family: Arial, sans-serif;">
                    <div style="display: flex; background-color: #f9f9f9; padding: 8px 16px; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); border-radius: 6px; font-family: Arial, sans-serif; gap: 10px;border-bottom:4px solid gray;">
                        <label for="txtPlanNo" style="font-weight: bold; color: #333; white-space: nowrap;">
                            Planning No.:
                        </label>
                        <span id="txtPlanNo" style="color: #1a1a1a; font-weight: bolder; word-break: break-word;">
                            <!-- Planning number goes here -->
                        </span>

                        <input type="hidden" id="isEditYN" value="" />
                    </div>
             </div>
        </div>
        
        <div class="row" style="margin: 0;">
            <div class="col-12 col-sm-12" style="padding: 0;">
                <div class="form-duo">
                    <label for="txtCoMorbiditiesTextArea">⚠️ Co-morbidities</label>
                    <div style="display: flex; align-items: center; gap: 20px; padding: 10px; background: #f9f9f9;">
                        <%= Html.TextAreaFor(x => Model.CoMorbiditiesTextArea, new {id = "txtCoMorbiditiesTextArea",@class = "TextBxFormat TextAreaBorder", @disabled = true,rows = "2",style = "width: 100%; resize: none; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;"}) %>
                    </div>
                </div>
                <div class="col-xs-12">
                    <fieldset style="background-color: white; padding-bottom: 10px;">
                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 5px;">ICD Diagnosis</legend>
                        <div class="MedicineDiv table-responsive" style="width: 100%">
                            <table id="TableICD" class="table table-bordered table-striped MedicineTbl">
                                <thead>
                                    <tr>
                                        <th style="width: 150px">Code</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody id="TableICDTBody"></tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
                <div class="col-xs-12">
                    <fieldset style="background-color: white; padding-bottom: 10px;">
                        <legend class="InvstFieldSetLegend">ICD-O Diagnosis</legend>
                        <div class="MedicineDiv table-responsive" style="width: 100%">
                            <table id="TableICDO" class="table table-bordered table-striped MedicineTbl">
                                <thead>
                                    <tr>
                                        <th style="width: 150px">Topography Code</th>
                                        <th style="width: 150px">Topography</th>
                                        <th style="width: 150px">Code</th>
                                        <th>Description</th>
                                        <th>TNM</th>
                                        <th>Stage</th>
                                    </tr>
                                </thead>
                                <tbody id="TableICDOTBody"></tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
        <div class="row" style="margin: 0px;">
             <div class="form-row horizontal-3">
                    <input type="text" hidden="hidden" id="txtWeight" value="0" />
                    <input type="text" hidden="hidden" id="txtHeight" value="0" />
                    <input type="text" hidden="hidden" id="txtBSA" value="" />
                    <input type="text" hidden="hidden" id="txtTstage" value="0" />
                    <input type="text" hidden="hidden" id="txtNstage" value="0" />
                    <input type="text" hidden="hidden" id="txtMstage" value="0" />
                    <input type="text" hidden="hidden" id="txtTRANID" value="" />
                    <div class="form-duo">
                        <label for="LstChemoCourse">💊 Chemotherapy Course</label>
                        <div class="custom-dropdown" style="padding: 10px;">
                            <%: Html.DropDownListFor(x => x.CouseName,new SelectList((IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem>)Model.LstCourse,"Value", "Text"),"--Select--",new { @id = "LstChemoCourse" }) %>
                        </div>
                    </div>
                    <div class="form-duo">
                        <label for="LstTreatmentPlan">🎯 Intent of Treatment</label>
                        <div class="custom-dropdown" style="padding: 10px;">
                            <%: Html.DropDownListFor(x => x.TreatmentName,new SelectList((IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem>)Model.LstTreatPlan,"Value", "Text"),"--Select--",new { @id = "LstTreatmentPlan" }) %>
                        </div>
                    </div>
                </div>
        </div>
        <div class="row" style="margin: 0px;">
            <div class="form-duo">
                <label for="LstChemoTName">💉 Chemotherapy Name / Protocol </label>
                <div style="display: flex; align-items: center; padding: 0px 15px; gap: 20px; width: 100%;">
                    <div class="custom-dropdown" style="width: 100%;">
                        <%: Html.DropDownListFor(x => x.ChemotherapyName,new SelectList((IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem>)Model.LstChemoName, "Value", "Text"),"--Select--",new { @id = "LstChemoTName", style = "width:100%;" }) %>
                    </div>
                </div>
            </div>
        </div>

        <div style="display: flex; flex-wrap: wrap; gap: 20px; padding: 10px 20px; width: 100%;" id="Duration">

            <div style="display: flex; align-items: center; flex: 1 1 calc(33.33% - 20px); min-width: 300px;">
                <label style="margin-right: 10px; width: 160px; white-space: nowrap;">Duration of Each Cycle</label>
                <div id="DaysDiv" style="display: flex; align-items: center;">
                    <%= Html.TextBoxFor(x => Model.Duration, new {
                        id = "txtDurationDays",
                        @class = "form-control",
                        style = "width: 100px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;",
                        type = "number",
                        maxlength = "3",
                        max = "999",
                        min = "0",
                    }) %>
                    <label style="margin-left: 10px;">Day(s)</label>
                </div>
            </div>

            <div style="display: flex; align-items: center; flex: 1 1 calc(33.33% - 20px); min-width: 300px;">
                <label for="txtCycles" style="margin-right: 10px; width: 160px;">🔁 Total No of Cycle(s)</label>
                <input type="text" class="form-control" id="txtCycles"
                    style="width: 100px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" maxlength="2" />
            </div>


            <div style="display: flex; align-items: center; flex: 1 1 calc(33.33% - 20px); min-width: 300px;">
                <label for="txtRepeatAfter" style="margin-right: 10px; width: 160px;">📅 To Repeat After Day(s)</label>
                <input type="text" class="form-control" id="txtRepeatAfter"
                    style="width: 100px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" />
            </div>


            <div style="display: flex; align-items: center; flex: 1 1 calc(33.33% - 20px); min-width: 300px;">
                <label for="txtCompleteCycle" style="margin-right: 10px; width: 160px;">✅ Completed Cycle(s)</label>
                <input type="text" class="form-control" id="txtCompleteCycle"
                    style="width: 100px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" readonly />
            </div>


            <div style="display: flex; align-items: center; flex: 1 1 calc(66.66% - 20px); min-width: 300px;">
                <label for="txtcurrentCycle" style="margin-right: 10px; width: 156px;">📍 Current Cycle</label>
                <input type="text" class="form-control" id="txtcurrentCycle"
                    style="width: 100px; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" readonly />
            </div>

        </div>
        <div class="form-row" style="margin-bottom: 0px;">
            <div class="clschemo" id="ChemoProtocol">

                <div style="display: flex; align-items: center; padding: 0px 15px; gap: 20px; width: 100%;">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <input type="checkbox" id="chkStructure" name="Structure" style="margin: 0px;" />
                        <label for="chkStructure" style="margin: 0px;">Dose Calculation</label>
                    </div>
                </div>

                <div id="DivOmitIndicator" style="display: none; align-items: center; gap: 10px; padding: 10px 15px; width: 100%;justify-content: flex-end;">
                    <span style="width: 15px;height: 15px;background-color: #ff7070;border: 1px solid black;"></span>
                    <label style="margin: 0px;">Omitted</label>
                </div>

                <div id="DivChemoArea" style="display: none; align-items: center; gap: 10px; padding: 10px 15px; width: 100%;">
<%= Html.TextAreaFor(x => x.ChemoTextArea, new
{
    id = "txtChemoTextArea",
    @class = "TextBxFormat TextAreaBorder",
    rows = "3",
    style = "width:100%; resize:none; overflow:hidden; min-height:60px; padding:5px; border:1px solid #ccc; border-radius:4px;",
    oninput = "ChemoautoResize(this)"
}) %>                </div>

                <div class="container-fluid">
                    <div class="row" style="margin-right: 8px; margin-left: -1px;">
                        <div class="panel-heading divHeads" style=" margin-bottom: -2px;" id="heading">
                            Chemo Protocol
     <img id="btnDuplicate" src="../Images/CIMS_Images/duplicate.png" title="Drug Duplicate" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none;" onclick="subscribeCIMSServices('D','gridChemo')" />
                 <img id="btnInformant" src="../Images/CIMS_Images/DrugInteraction.png" title="Drug Interaction" style="float: right; height: 20px; width: 28px; cursor: pointer; display: none; margin-right: 10px;" onclick="subscribeCIMSServices('I','gridChemo')">
                        </div>
                        <div id="ContentDiv" class="col-12" style="overflow-x: auto; padding: 0;">
                            <table id="gridChemo" class="table table-bordered"
                                style="width: auto; min-width: fit-content; white-space: nowrap;">
                            </table>
                        </div>
                    </div>
                </div>
                <div class="form-row" style="margin-bottom: 0px;">
                    <div class="form-duo" id="Treatment">
                        <label for="txtModificationTextArea">🛠️ Modification During Treatment </label>
                        <div style="padding: 10px 15px;">
                            <%= Html.TextAreaFor(x => Model.ModifttreatTextArea, new { id = "txtModificationTextArea", @class = "TextBxFormat TextAreaBorder", rows = "2", style = "width: 99%; resize: none; min-height: 40%; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" ,}) %>
                        </div>
                    </div>
                </div>

                <div class="form-row horizontal-3">

                    <div class="form-duo" id="TreatConStatus">
                        <label for="txtModificationTextArea">🧾 Treatment Done Conclusion </label>
                        <div style="padding: 10px 15px;">

                            <div style="display:flex; align-items: center;">
                                <input style="margin: 0;" type="radio" name="Treatment" id="rbtnPlannedYes"  />
                                <label style="margin: 0; padding-left: 10px; padding-right: 10px;" for="Treatment">Yes</label>
                                <input style="margin: 0;" type="radio" name="Treatment" id="rbtnPlannedNo"  />
                                <label style="margin: 0; padding-left: 10px; padding-right: 10px;" for="Treatment">No</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-duo" id="ConStatus">
                        <label id="lblPlanned" >📊 Conclusion Status</label>
                        <div class="custom-dropdown" style="padding: 1px;" id="CmbStatus">
                            <%: Html.DropDownListFor(x => x.PlanStatus ,new SelectList(Model.LstConStatus,"Value", "Text"),"--Select--",new { @id = "cmbConStatus", onchange = "toggleCompleteDate(this)"  }) %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-row" style="margin-bottom: 0px;">
                    <div class="form-duo" id="divCompleteDate">
                        <label for="txtModificationTextArea">📅 Treatment Complete Date </label>
                        <div style="padding: 10px 15px;">
                        <%= Html.TextBoxFor(x => Model.Duration, new { id = "txtTreatComplete", @class = "form-control",style="width: 150px;",}) %>
                    </div>
                </div>
    </div>
        <div class="row" style="margin: 0px;">
            <div style="padding: 10px 15px;display: flex;align-items: center;gap: 20px;">
                <label for="">📅 Chemo Start Date </label>
                <input type="text" id="txtChemoStart" class="form-control" readonly style="width: 150px" />
            </div>
        </div>
        <div class="row" style="margin: 0px;" id="SchemeMainDiv">
            <div class="col-md-6 col-sm-12">
                <label style="width:115px;">📋 Scheme</label>
                <input type="text" id="SchemeInput" onkeyup="SearchScheme()" onclick="SearchScheme()" placeholder="&#xF002; Search Scheme.." style="font-family: FontAwesome !important; font-size: 12px; margin-left: 10px; width: 250px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                <div class="row" style="text-align: center;">
                    <div id="tblSchemeWrapper">
                        <table id="tblScheme" class="table">
                        </table>
                    </div>
                </div>
                <div class="MedicineDiv table-responsive" style="width: 100%;height: 150px;overflow: auto;">
                    <table id="TableScheme" class="table table-bordered table-striped MedicineTbl">
                        <thead>
                            <tr>
                                <th style="width: 90px">Action</th>
                                <th>Scheme</th>
                            </tr>
                        </thead>
                        <tbody id="TableSchemeTBody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    <div style="text-align: center; margin-top: 20px;">
        <button id="btnPrint" onclick="PrintChemo()"
            style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 10px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
            onmouseover="this.style.backgroundColor='#218838'"
            onmouseout="this.style.backgroundColor='#28a745'">
             Print
        </button>
        
        <button id="btnSave"
            style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
            onmouseover="this.style.backgroundColor='#218838'"
            onmouseout="this.style.backgroundColor='#28a745'">
             Save
        </button>
    </div>
    <hr />
    <div>
        <div style="background-color: #6380bb !important; padding: 5px 5px; color: white; font-size: 14px;">
            <label style="margin: 0px;">Previous Chemo History</label>
        </div>
        <div style="position: relative; overflow: hidden; border: 1px solid; padding-top: 5px;" id="divPlanning">
            <div id="tbldiv">
            </div>
        </div>
    </div>
        </div>

    <div id="POPUPInfoModal" class="SchemeModal" style="justify-content: center; align-items: center;">
        <div class="Scheme-modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv SchemeHeader">
                <label id="InfoHeadLabel"></label>
                <span class="closeMdlBtn"  onclick="ClosePop('POPUPInfoModal');">&times;</span>
            </div>
            <div class="ModelContentDiv">
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Scheme Name</label>
                    <label>:</label>
                    <label id="SchemeLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Pre-requisites</label>
                    <label>:</label>
                    <label id="PreReqLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Advice/Remarks</label>
                    <label>:</label>
                    <label id="AdvRmksLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Pre-Investigations</label>
                    <label>:</label>
                    <label id="PreInvstLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Post-Op/Treatment Inv.</label>
                    <label>:</label>
                    <label id="PostInvstLbl"style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
            </div>
        </div>
    </div>
    <div id="customDialog" style="display:none;">
    <p>Do you want to save?</p>
</div>
         <%-- Added by Roshan 20250812 => Dialog For  CIMS Info --%>
   <div id="divCIMSInfo" style="display: none;">
       <div class="CIMS-container">
           <div class="CIMS-header" style="background: #2d70aa; margin-bottom: 4px;">
               <div style="display: inline-block; vertical-align: middle; margin-top: 4px; padding-left: 4px; height: 33px">
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
<%--  --%>