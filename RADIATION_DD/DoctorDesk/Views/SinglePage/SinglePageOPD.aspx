<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SinglePageOPD.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!--Added By devendra-->
    <style>
        button:not(:disabled),
        input[type="button"]:not(:disabled),
        input[type="submit"]:not(:disabled),
        input[type="reset"]:not(:disabled),
        input[type="radio"]:not(:disabled),
        input[type="checkbox"]:not(:disabled),
        img,
        .fa,
        .fas,
        .far,
        .fab,
        .glyphicon,
        select:not(:disabled),
        input[type="file"]:not(:disabled),
input[type="file"]:not(:disabled)::-webkit-file-upload-button ,
     input[type="date"]:not(:disabled)::-webkit-calendar-picker-indicator ,
        a {
            cursor: pointer !important;
        }
    </style>

    <style>
        /* --- LAYOUT CONTAINER --- */
        .opd-main-container {
            height: calc(100vh - 60px);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            background-color: #f8f9fa;
        }

        /* --- 1. FIXED PATIENT INFO SECTION --- */
        .patient-info-header {
            background-color: #fff;
            border-bottom: 1px solid #dee2e6;
            flex-shrink: 0;
            padding: 15px 20px 0 20px;
        }

        /* Patient Name & Details */
        .patient-name-large {
            font-size: 1.2rem;
            font-weight: 700;
            color: #000;
        }

        .patient-meta {
            color: #666;
            font-size: 0.9rem;
            margin-top: 4px;
        }

        .tag-chemo {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            background: none;
            margin-left: 5px;
        }

        .individual-tag {
            background-color: #FFC107;
            color: #000;
            padding: 2px 10px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 12px;
            display: inline-block;
            white-space: nowrap;
        }

        .code-red {
            color: #dc3545;
            font-weight: 600;
        }

        /* Header Buttons */
        .btn-header {
            background: #fff;
            border: 1px solid #dee2e6;
            color: #333;
            font-size: 0.9rem;
            margin-left: 8px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            white-space: nowrap;
        }

        .btn-visit-history {
            background: #fff0e6;
            border: 1px solid #ffccaa;
            color: #d65b00;
            white-space: nowrap;
        }

        /* Vitals Strip */
        .vitals-strip {
            display: flex;
            align-items: center;
            flex-wrap: wrap; /* Allows wrapping on smaller screens */
            background-color: #f8f9fa;
            margin-top: 15px;
            padding: 10px 15px;
            border-radius: 6px;
            font-size: 0.85rem;
            gap: 10px;
            /* Note: Removed transition property here to ensure jQuery slideUp works smoothly */
        }

        .vital-group {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
        }

        .vital-box {
            display: flex;
            flex-direction: row;
            align-items: baseline;
            margin-right: 0;
        }

            .vital-box span.label {
                color: #555;
                font-size: 0.95rem;
                font-weight: 600;
                margin-bottom: 0;
                margin-right: 5px;
            }

                .vital-box span.label::after {
                    content: ":";
                }

            .vital-box span.val {
                font-weight: 700;
                color: #000;
                font-size: 0.95rem;
            }

        .val-alert {
            color: #dc3545 !important;
        }

        /* The Vertical Divider Pipe */
        .vital-separator {
            display: inline-block;
            width: 1px;
            height: 14px;
            background-color: #ccc;
            margin: 0 10px;
        }

        /* Edit Vitals Buttons Wrapper */
        .vital-actions {
            margin-left: auto;
            display: flex;
            align-items: center;
        }

        .btn-edit-vitals {
            background: #fff;
            border: 1px solid #ced4da;
            padding: 4px 10px;
            font-size: 0.85rem;
        }


        /* --- 2. SCROLLABLE CONTENT SECTION --- */
        .scrollable-content-area {
            flex-grow: 1;
            overflow-y: auto;
            padding: 0px 20px 20px 20px;
            scroll-behavior: smooth;
        }

        /* Navigation Tabs */
        .section-tabs {
            background: #fff;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            margin-bottom: 20px;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .tab-btn {
            background: none;
            border: none;
            padding: 8px 15px;
            font-weight: 600;
            color: #555;
            font-size: 0.95rem;
            cursor: pointer;
            white-space: nowrap;
        }

            .tab-btn.active {
                color: #d65b00;
                border: 1px solid #d65b00;
                border-radius: 4px;
                background-color: #fff5eb;
            }

        /* Action Buttons (Save) */
        .btn-save-draft {
            background-color: #a5d6a7;
            color: #1b5e20;
            border: none;
            font-weight: 600;
        }

        .btn-save-complete {
            background-color: #81c784;
            color: #1b5e20;
            border: none;
            font-weight: 600;
        }

        /* Section Cards */
        .opd-section-card {
            background: #fff;
            border-left: 5px solid #28a745;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 25px;
            position: relative;
        }

        .section-title {
            color: #155724;
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 15px;
        }

        /* Input Styles */
        .input-box-grey {
            background-color: #f1f3f4;
            border: 1px solid #e0e0e0;
            padding: 15px;
            border-radius: 6px;
            width: 100%;
            min-height: 50px;
            position: relative;
        }

        /* --- NOTES STYLES (Prefix: .nt-) --- */
        .nt-wrapper {
            padding:0px;
            font-family: 'Segoe UI', sans-serif;
        }

        .nt-textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            resize: none;
            margin-bottom: 10px;
        }

        .nt-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-top: -10px;
        }

        .nt-radio-group {
            display: flex;
            gap: 15px;
            font-size: 14px;
            align-items: center;
            cursor: pointer;
        }

        .nt-btn-group {
            display: flex;
            gap: 10px;
        }

        .nt-btn-update {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
        }

        .nt-btn-clear {
            background-color: #e7e7e7;
            color: black;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
        }

        .nt-list-container {
            max-height: 250px;
            overflow-y: auto;
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 5px;
            padding: 5px;
        }

        .nt-note-item {
            padding: 10px;
            margin: 5px;
            background: #fff;
            border-radius: 4px;
            border-left: 4px solid #0d6efd; /* Blue Private */
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .nt-note-public {
            background-color: #fff5f5;
            border-left: 4px solid #dc3545 !important; /* Red Public */
        }

        .nt-note-text {
            font-size: 13px;
            color: #333;
            margin-bottom: 4px;
            white-space: pre-wrap;
        }

        .nt-note-meta {
            font-size: 11px;
            color: #888;
            text-align: right;
            font-style: italic;
        }

        .nt-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-top: 1px solid #e0e0e0;
            background-color: #fff;
            font-family: 'Segoe UI', sans-serif;
            font-size: 13px;
        }

        .nt-btn-Notes {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 25px;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
        }

            .nt-btn-Notes:hover {
                background-color: #0056b3;
            }

        .nt-legend-wrapper {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nt-legend-item {
            display: flex;
            align-items: center;
            color: #333;
            font-weight: 500;
        }

        .nt-dot {
            height: 12px;
            width: 12px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }

        .nt-pending {
            background-color: #dc3545;
        }


        /* --- ALL NOTES POPUP STYLES (Prefix: aln-) --- */
        .aln-wrapper {
            padding: 0;
            max-height: 400px;
            overflow-y: auto;
            background-color: #f4f6f9;
        }

        .aln-header {
            padding: 0px;
            background: #fff;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
            color: #333;
        }

        .aln-list {
            padding: 3px;
        }

        /* Reusing nt-item inside aln */
        .aln-wrapper .nt-note-item {
            border: 1px solid #e0e0e0;
            margin-bottom: 10px;
        }


        /* --- UPLOAD STYLES --- */
        .upl-wrapper {
            padding: 15px;
        }

        .upl-header-box {
            background: #eef2f7;
            padding: 15px;
            border-radius: 4px;
            border: 1px solid #d1d9e6;
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .upl-btn-upload {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
        }

        .upl-section {
            margin-bottom: 20px;
            border: 1px solid #dae0e5;
            border-radius: 4px;
            overflow: hidden;
        }

        .upl-title {
            background: #f1f3f4;
            padding: 8px 15px;
            font-weight: 700;
            color: #003f74;
            border-bottom: 1px solid #dae0e5;
            font-size: 14px;
        }

        .upl-list {
            background: #fff;
            min-height: 50px;
        }

        .upl-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 15px;
            border-bottom: 1px solid #eee;
        }

        .upl-link {
            color: #0d6efd;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
        }

            .upl-link:hover {
                text-decoration: underline;
            }

        .upl-btn-delete {
            background-color: #e7e7e7;
            color: black;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
        }

        /* --- VISIT HISTORY STYLES --- */
        .vh-wrapper {
            padding: 0;
        }

        .vh-header {
            padding: 10px 15px;
            background: #fff;
            border-bottom: 1px solid #ccc;
        }

        .vh-radios {
            margin-bottom: 10px;
            display: flex;
            gap: 15px;
            font-size: 13px;
        }

        .vh-tabs {
            display: flex;
            gap: 5px;
        }

        .vh-tab-btn {
            border: 1px solid #ced4da;
            background: #fff;
            padding: 6px 15px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
            color: #555;
        }

            .vh-tab-btn.active {
                background-color: #fd7e14;
                color: white;
                border-color: #fd7e14;
            }

        .vh-list-container {
            height: 350px;
            overflow-y: auto;
            padding: 10px;
        }

        .vh-item {
            padding: 12px;
            border-bottom: 1px solid #444;
            font-size: 13px;
            display: flex;
        }

        .vh-date {
            color: #fd7e14;
            font-weight: bold;
            margin-right: 8px;
            white-space: nowrap;
        }

        .vh-details {
            color: #000;
            line-height: 1.4;
        }

        .profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e0e0e0;
            background-color: #f5f5f5;
        }


        /* =================================================================
           RESPONSIVE MEDIA QUERIES
           ================================================================= */
        @media (max-width: 991px) {
            .patient-info-header {
                padding: 10px;
            }

            .patient-name-large {
                font-size: 1.1rem;
            }

            .profile-pic {
                width: 80px;
                height: 80px;
            }

            /* Wrap buttons on tablet/small laptop */
            .patient-info-header .d-flex.justify-content-between {
                flex-wrap: wrap;
            }
        }

        @media (max-width: 768px) {
            /* STACK Header Info */
            .patient-info-header > .d-flex {
                flex-direction: column;
                width: 100%;
            }

            /* Adjust Profile Pic Section */
            .patient-info-header .d-flex.align-items-center {
                width: 100%;
                margin-bottom: 10px;
            }

            /* Stack Buttons Row */
            .patient-info-header .d-flex:last-child {
                width: 100%;
                flex-wrap: wrap;
                gap: 5px;
                justify-content: flex-start;
            }

            .btn-header, .btn-visit-history {
                margin-left: 0;
                margin-right: 5px;
                margin-bottom: 5px;
                flex-grow: 1; /* Make buttons grow to fill width */
                text-align: center;
            }

            /* Adjust Vitals */
            .vitals-strip {
                flex-direction: row;
                align-items: flex-start;
                gap: 5px;
            }

            .vital-group {
                display: flex;
                flex-wrap: wrap;
                width: 100%;
                gap: 8px;
            }

            /* Hide separators on mobile to prevent weird wrapping artifacts */
            .vital-separator {
                display: none;
            }

            /* Ensure boxes have spacing since separators are gone */
            .vital-box {
                margin-right: 10px;
                background: #fff;
                padding: 4px 8px;
                border-radius: 4px;
                border: 1px solid #eee;
            }

            .vital-actions {
                width: 100%;
                justify-content: flex-end;
                margin-top: 5px;
            }

            .nav-scroller {
                overflow-x: auto;
                white-space: nowrap;
                padding-bottom: 5px;
                width: 100%;
            }
        }

        .TextAreaBorder {
            border: 1px solid #9f9292;
        }

        .EModal .modal-content {
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

        .EModal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

    </style>

    <script type="text/javascript">
        var MedicalRights = false;
        var MedSchemeCodes = "";
        var MedSchemeCodesFrom = "";
        var IsAdviceBind = false;
        var IsChemoBind = false;
        var SurgicalRights = false;
        var RaditionRights = false;
        <% var SampMainView = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var FormLinkRouteList = '<%:Html.Raw(SampMainView.Serialize(ViewBag.FormLinkRouteList))%>';
        var PrescpPrintYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONPRINTYN")%>';
        var GlbRMOFlagEditHistoryYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOHISTORYYN")%>' == "Y" ? "Y" : "N") : "N"; 
        var ShowAdvSurgerySection = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ShowAdvSurgerySection")%>';
        var ReqSchemeCompCode = "";
        var ReqSchemeCompName = "";
        $(document).ready(function () {
            LoadAllergyCount();
            MedicalSurgicalRadtFormRights();
            EnableDisableContent();
            $('.tab-btn').click(function () {
                $('.tab-btn').removeClass('active');
                $(this).addClass('active');
            });
            $(document).on("click", function (e) {
                if (!$(e.target).closest("#complaintSearch,#complaintListMainDiv,#complaintList").length) {
                    $("#complaintSearch").val("");
                    $("#complaintListMainDiv").hide();
                }
                if (!$(e.target).closest("#InvestigationSearch,#InvestigationList").length) {
                    $("#InvestigationSearch").val("");
                    $("#InvestigationListMainDiv").hide();
                }
                if (!$(e.target).closest("#instructionSearch,#instructionListMainDiv,#instructionList").length) {
                    $("#instructionSearch").val("");
                    $("#instructionListMainDiv").hide();
                }
                if (!$(e.target).closest("#UnCodedDiagonsisSearch,#UnCodedDiagonsisListMainDiv,#UnCodedDiagonsisList").length) {
                    $("#UnCodedDiagonsisSearch").val("");
                    $("#UnCodedDiagonsisListMainDiv").hide();
                }
                if (!$(e.target).closest("#ICDDiagonsisSearch,#ICDDiagonsisListMainDiv,#ICDDiagonsisList").length) {
                    $("#ICDDiagonsisSearch").val("");
                    $("#ICDDiagonsisListMainDiv").hide();
                }
                if (!$(e.target).closest("#RxSearch,#RxListMainDiv,#RxList").length) {
                    $("#RxSearch").val("");
                    $("#RxListMainDiv").hide();
                }
                if (!$(e.target).closest("#PersonalHistorySearch,#PersonalHistoryListMainDiv,#PersonalHistList").length) {
                    $("#PersonalHistorySearch").val("");
                    $("#PersonalHistoryListMainDiv").hide();
                }
                if (!$(e.target).closest("#PersonalMedicalHistSearch,#PersonalMedicalHistoryListMainDiv,#PersonalMedicalHistList").length) {
                    $("#PersonalMedicalHistSearch").val("");
                    $("#PersonalMedicalHistoryListMainDiv").hide();
                }
                if (!$(e.target).closest("#AdviceReferToSpclSearch, #Advice_DivReferToSpclSearchMainDiv").length) {
                    $("#Advice_DivReferToSpclSearchMainDiv").hide();
                    $("#AdviceReferToSpclSearch").val("");
                }
                if (!$(e.target).closest("#AdviceSurgeryInputSearch, #Advice_DivSurgerySearchMainDiv").length) {
                    $("#Advice_DivSurgerySearchMainDiv").hide();
                    $("#AdviceSurgeryInputSearch").val("");
                }
                if (!$(e.target).closest("#AdviceSearchDoctInputSearch, #Advice_DivDoctorSearchMainDiv").length) {
                    $("#Advice_DivDoctorSearchMainDiv").hide();
                    $("#AdviceSearchDoctInputSearch").val("");
                }
                $(".TopoHistSrchTxt").val("");
                $(".SiteTopoSrchTxt").val("");
                $(".SearchList").hide();
                stopLoading();
            });

            document.getElementById('OPDContentMainDiv').addEventListener('scroll', () => {
                let currentSectionId = "";
                document.querySelectorAll('.opd-section-card').forEach(section => {
                    const sectionTop = section.offsetTop - document.getElementById('OPDContentMainDiv').offsetTop;
                    const sectionHeight = section.offsetHeight;

                    if (document.getElementById('OPDContentMainDiv').scrollTop >= sectionTop - 50 &&
                        document.getElementById('OPDContentMainDiv').scrollTop < sectionTop + sectionHeight - 50) {
                        currentSectionId = section.getAttribute('id');
                    }
                });
                if (currentSectionId) {
                    document.querySelectorAll('.tab-btn').forEach(link => {
                        link.classList.remove('active');
                        if (link.getAttribute('href') === `#${currentSectionId}`) {
                            link.classList.add('active');
                        }
                    });
                }
            });
            GetNotes("N");
            GetTumorPatList();
            $("#TumorBoardCount").click(function () {
                openRightMenu('../SinglePage/PatientClinicalHistory', "T","");
            });
            if (MedicalRights) {
                reloadChemoPlanning();
            }
        });
    </script>

    <%-- Common Functionality --%>
    <script type="text/javascript">
        function MedicalSurgicalRadtFormRights() {
            var ClinicType = sessionStorage.getItem("ClinicType");
            if (ClinicType == "S") {
                SurgicalRights = true;
            }
            else if (ClinicType == "M") {
                MedicalRights = true;
            }
            else if (ClinicType == "R") {
                RaditionRights = true;
            }
            toggleClass("SurgicalSetting", ShowAdvSurgerySection == "Y" ? true : SurgicalRights, "inline-block");
        }

        function toggleClass(elementId, isVisible, displayClass) {
            var el = document.getElementById(elementId);
            if (el) {
                if (isVisible) {
                    el.classList.remove("d-none");
                    el.classList.add(displayClass);
                } else {
                    el.classList.remove(displayClass);
                    el.classList.add("d-none");
                }
            }
        }

        function EnableDisableContent() {
            if (sessionStorage.getItem("PatTRANNO") === "" || sessionStorage.getItem("PatTRANNO") === null) {
                $("#HeaderSection_OPDPatInfo").find("*").attr("disabled", true);
                $("#OPDContentMainDiv").find("*").attr("disabled", true);
                $("#OPDPatientDashboard_BackBtn").prop('disabled', false);
                $("#SinglePageOPD_DraftSave").hide();
                $("#SinglePageOPD_CompltSave").hide();
            }
            else if (sessionStorage.getItem("PatCompleted") == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y") {
                $('#ddlClinicalNtTemplate').prop('disabled', true);
                $('#ClinicalNotes_Freetext').prop('disabled', true);
                $('#ClinicalNote_Setup').prop('disabled', true);
                $('#Exam_Freetext').prop('disabled', true);
                $('#Exam_HistoryFreetext').prop('disabled', true);
                $('#DivExaminationImages').prop('disabled', true);
                $('#ddlHistoryTemplate').prop('disabled', true);
                $('#ddlExamTemplate').prop('disabled', true);
                $('#DivExaminationImages .jconfirm-closeIcon').hide();
                $('#imgOpenExaminationImageEditorPopup').prop('disabled', true);
                $('#Exam_Emplate').prop('disabled', true);
                $('#Complaints_Freetext').prop('disabled', true);
                $('#complaintAdd').prop('disabled', true);
                $('#complaintSearch').prop('disabled', true);
                $("#RbtnGovScheme").prop('disabled', true); // Pournima 7th Sept 2026

                if (typeof complaintsListtable !== "undefined" && complaintsListtable) {
                    complaintsListtable.getColumns().forEach(function (column) {
                        column.updateDefinition({ editable: false });
                    });
                    let actionColumn = complaintsListtable.getColumn("act");
                    if (actionColumn) {
                        actionColumn.updateDefinition({
                            cellClick: null
                        });
                    }
                }

                if (typeof InvestigationListtable !== "undefined" && InvestigationListtable) {
                    InvestigationListtable.getColumns().forEach(function (column) {
                        column.updateDefinition({ editable: false });
                    });
                    let actionColumn = InvestigationListtable.getColumn("act");
                    if (actionColumn) {
                        actionColumn.updateDefinition({
                            cellClick: null
                        });
                    }
                }
                $('input[name="TreatmentAdvType"]').prop('disabled', true);
                $('#1_Srch_Topo_Histo_C20.9_Rectum, NOS').prop('disabled', true);
                $('#DoctContNoteDiv').find("*").attr('disabled', true);
                $("#SinglePageOPD_DraftSave").hide();
                $("#SinglePageOPD_CompltSave").hide();
                document.querySelectorAll('.btn-outline-success').forEach(function (btn) {
                    if (btn.textContent.trim() === 'Fit to Content') {
                        btn.removeAttribute('disabled');
                    }
                    if (btn.textContent.trim() === 'Set Max Height') {
                        btn.removeAttribute('disabled');
                    }
                });
            }
            else {
                if ('<%: Session["RMOYN"] ?? "" %>' == "Y") {
                    $("#OPDContentMainDiv").find("*").attr("disabled", true);
                    $("#SinglePageOPD_CompltSave").hide();
                    $("#SinglePageOPD_DraftSave").hide();
                    if (sessionStorage.getItem("PatCompleted") != "Y") {
                        if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEADVICEYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVERXYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECHEMOPLANYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINSTRUCTIONYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINVESTIGATIONYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECLINICNOTESYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEDIAGNOSISYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEEXAMYN")%>' == "Y" ||
                            '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECOMPLAINTSYN")%>' == "Y"
                        ) {
                            $("#SinglePageOPD_DraftSave").show();
                        }
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECOMPLAINTSYN")%>' == "Y") {
                        $("#sec-complaints").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEEXAMYN")%>' == "Y") {
                        $("#sec-exam").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEDIAGNOSISYN")%>' == "Y") {
                        $("#sec-Diagnosis").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECLINICNOTESYN")%>' == "Y") {
                        $("#sec-clinical").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINVESTIGATIONYN")%>' == "Y") {
                        $("#sec-Investigations").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINSTRUCTIONYN")%>' == "Y") {
                        $("#sec-Instructions").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECHEMOPLANYN")%>' == "Y") {
                        $("#sec-ChemoPlanning").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVERXYN")%>' == "Y") {
                        $("#sec-Rx").find("*").attr("disabled", false);
                    }
                    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEADVICEYN")%>' == "Y") {
                        $("#sec-advice").find("*").attr("disabled", false);
                    }
                    document.querySelectorAll('.btn-outline-success').forEach(function (btn) {
                        if (btn.textContent.trim() === 'Fit to Content') {
                            btn.removeAttribute('disabled');
                        }
                        if (btn.textContent.trim() === 'Set Max Height') {
                            btn.removeAttribute('disabled');
                        }
                        if (btn.textContent.trim() === 'Setup') {
                            btn.setAttribute('disabled', 'disabled');
                        }
                    });
                }
                else {
                    $("#HeaderSection_OPDPatInfo").find("*").attr("disabled", false);
                    $("#OPDContentMainDiv").find("*").attr("disabled", false);
                    $("#OPDPatientDashboard_BackBtn").prop('disabled', false);
                    $("#SinglePageOPD_DraftSave").hide();
                    $("#SinglePageOPD_CompltSave").hide();
                    if (sessionStorage.getItem("PatCompleted") != "Y") {
                        $("#SinglePageOPD_CompltSave").show();
                        $("#SinglePageOPD_DraftSave").show();
                    }
                }
            }
        }

        function adjustTableHeight(tabulatorGridId) {
            const instances = Tabulator.findTable("#" + tabulatorGridId);
            if (!instances || instances.length === 0) return;
            const table = instances[0];
            const scrollLeft = table.rowManager.element.scrollLeft;
            const rows = table.getRows();
            let totalHeight = 0;
            rows.forEach(row => {
                totalHeight += row.getElement().offsetHeight;
            });
            const headerEl = document.querySelector(`#${tabulatorGridId} .tabulator-header`);
            if (headerEl) {
                const headerHeight = headerEl.offsetHeight;
                const newHeight = totalHeight + headerHeight + 30;
                table.setHeight(newHeight);
                setTimeout(() => {
                    table.rowManager.element.scrollLeft = scrollLeft;
                }, 0);
            }
        }

        function autoResizeTextareaForSinglePage(el) {
            const lines = el.value.split("\n").length;
            el.rows = lines;
            if (el.style.overflow === 'hidden') {
                el.style.overflow = 'auto';
            }
        }

        function RedirectToDicom() {
            var Mrno = sessionStorage.getItem('PatMRNO');
            if (Mrno != "") {
                $.ajax({
                    type: 'POST',
                    url: '../DoctorDesk/RedirectToDicom',
                    data: { mrNo: Mrno },
                    success: function (data) {
                        window.open(data);
                    },
                    error: function () {
                    }
                });
            }
        }

        function ConvertArryListToTabulatorFormat(DataList, PropText, PropValue) {
            let lookup = {};
            lookup[""] = "";
            DataList.forEach(item => {
                lookup[item[PropValue]] = item[PropText];
            });
            return lookup;
        }

        function LoadAllergyCount() {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: "../DoctorDesk/GetHistory",
                async: true,
                data: {
                    strMrNo: sessionStorage.getItem("PatMRNO")
                },
                success: function (response) {
                    if (response && response.jsonAllergy) {
                        $("#allergyCountBadge").text(response.jsonAllergy.length);
                    }
                    else {
                        $("#allergyCountBadge").text("0");
                    }
                },
                error: function (xhr, status, error) {
                    $("#allergyCountBadge").text("0");
                }
            });
        }

        function AdviceGetSchemeInfo(SchemeCode) {
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

        function HistPopAdviceSchemeInfo(Data) {
            if (!Data || Data.length === 0) {
                return "";
            }

            var scheme = Data[0][0];
            var PreInvst = "";
            var PostInvst = "";

            if (Data[1] && Data[1].length > 0) {
                $.each(Data[1], function (i, e) {
                    if (e.LINKTYPE == "P") {
                        PreInvst += (PreInvst === "" ? e.SERVNAME : ", " + e.SERVNAME);
                    }
                    if (e.LINKTYPE == "O") {
                        PostInvst += (PostInvst === "" ? e.SERVNAME : ", " + e.SERVNAME);
                    }
                });
            }

            var html = "";
            html += "<div class='scheme-info' style='display:flex; flex-direction:column; gap:8px; width:100%; box-sizing:border-box;'>";

            function createRow(label, value) {
                return "<div class='info-row' style='display:flex; flex-wrap:wrap; align-items:flex-start; gap:4px;'>" +
                    "<div class='label' style='flex:0 0 150px; font-weight:bold; min-width:100px;'>" + label + "</div>" +
                    "<div class='colon' style='flex:0 0 auto;'>:</div>" +
                    "<div class='value' style='flex:1 1 0;'>" + (value || "") + "</div>" +
                    "</div>";
            }

            html += createRow("Scheme Name", scheme.SCHEMENAME);
            html += createRow("Pre-requisites", scheme.PREADVICE);
            html += createRow("Advice / Remarks", scheme.POSTADVICE);
            html += createRow("Pre-Investigations", PreInvst);
            html += createRow("Post-Op / Treatment Inv.", PostInvst);

            html += "</div>";

            return html;
        }

        function LoadSchemePartialView(callback) {
            var strCompCode = sessionStorage.getItem('OPDCompCode');
            $('.AllAdvicePreAuthSchemeSect').empty();
            let target = null;
            let clinicType = "";
            if (SurgicalRights) {
                target = "#AllAdvicePreAuthSchemeSect_S";
                clinicType = "S";
            }
            else if (MedicalRights) {
                target = "#AllAdvicePreAuthSchemeSect_M";
                clinicType = "M";
            }
            else if (RaditionRights) {
                target = "#AllAdvicePreAuthSchemeSect_R";
                clinicType = "R";
            }
            if (target) { // && strCompCode
                $(target).load("../SinglePage/SchemeAdvice",
                    { ClinicType: clinicType },
                    function () {
                        if (typeof callback === "function") callback();
                    }
                );
            }
            else {
                if (typeof callback === "function") callback();
            }
        }

        function LoadAdviceSection(callback) {
            $("#AdviceContainer").empty();
            $("#AdviceContainer").load("../SinglePage/Advice", function () {
                if (typeof callback === "function") {
                    callback();
                }
            });
        }

        function reloadChemoPlanning(callback) {
            $("#chemoPlanningContainer").empty();
            $("#chemoPlanningContainer").load("../SinglePage/ChemoPlanning", function () {
                startLoading("Loading", "loading-chemoPlanning");
                if (typeof callback === "function") {
                    callback();
                }
                stopLoading("loading-chemoPlanning");
            });
        }

        function LoadMedicalScheme() {
            LoadSchemePartialView();
        }
    </script>

    <%-- Save and Validation Functionality --%>
    <script type="text/javascript">
        //Validation For RMO
        function ConfrmForRMOSave(Type, ValidationYes, ValidationDiagYes) {
            var Flag = true;
            if (GlbRMOFlagEditHistoryYN == "Y") {
                if (ValidationYes != "Y") {
                    var MissingHistoryLst = CheckHistoryAndContinue();
                    var SpltComma = MissingHistoryLst.split(',');
                    if (MissingHistoryLst != "" && SpltComma.length == 4) {
                        ToastMsg("Please Enter Atleast one history.", "warning");
                        //var MessagePrompt = "No data entered  for <b>" + MissingHistoryLst + "</b><br/><br/>Do you want to continue saving ?"
                        //var MessagePrompt = "No data entered  for <b>" + MissingHistoryLst + "</b><br/><br/>Do you want to continue saving ?"
                        //openPopupDynamic("Confirmation", MessagePrompt, [
                        //    { text: "Yes", class: "btn btn-yes", action: "OPDSaveAsDraft('" + Type + "', 'Y')" },
                        //    { text: "No", class: "btn btn-no", action: "closePopup()" }
                        //]);
                        Flag = false;
                    }
                }
            }
            return Flag;
        }
        //Validation For RMO History
        function CheckHistoryAndContinue() {
            var MissingHistLst = "";
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: "../DoctorDesk/GetHistory",
                async: false,
                data: {
                    strMrNo: sessionStorage.getItem("PatMRNO")
                },
                success: function (response) {
                    var missing = [];
                    if ((!response.jsonFamily || response.jsonFamily.length == 0) && (!response.jsonFreeFamily || response.jsonFreeFamily.length == 0))
                        missing.push("Family History");
                    if ((!response.jsonPersonal || response.jsonPersonal.length == 0) && (!response.jsonFreePersonal || response.jsonFreePersonal.length == 0))
                        missing.push("Personal History");
                    if ((!response.jsonMedical || response.jsonMedical.length == 0) && (!response.jsonMedical || response.jsonMedical.length == 0))
                        missing.push("Medical History");
                    if (!response.jsonAllergy || response.jsonAllergy.length == 0)
                        missing.push("Allergy History");
                    if (missing.length > 0) {
                        MissingHistLst = missing.join(", ");
                    }
                }
            });
            return MissingHistLst;
        }

        //ValidationForDiagnosis
        function ConfrmForICDDiagSave(Type, ValidationYes, ValidationDiagYes) {
            var Flag = true;
            if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CONFIRMFORICDYN")%>' == "Y" && '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEDIAGNOSISYN")%>' == "Y" && ValidationDiagYes != "Y") {
                if (ICDDiagListtable.getData().length == 0) {
                    var MessagePrompt = "No data found for <b>ICD Diagnosis.</b><br/>Do you want to continue saving ?"
                    openPopupDynamic("Confirmation", MessagePrompt, [
                        { text: "Yes", class: "btn btn-yes", action: "OPDSaveAsDraft('" + Type + "', '" + ValidationYes +"', 'Y')" },
                        { text: "No", class: "btn btn-no", action: "closePopup()" }
                    ]);
                    Flag = false;
                }
            }
            return Flag;
        }

        //D -> Save As Draft , C -> Save Complete
        function OPDSaveAsDraft(Type, ValidationYes = "", ValidationDiagYes = "") {
            if ('<%: Session["RMOYN"] ?? "" %>' == "Y") {
                var SaveFlag = false;
                var OPDDataToSendForDraft = {
                    MRNO: sessionStorage.getItem("PatMRNO"),
                    TRANNO: sessionStorage.getItem("PatTRANNO"),
                    PatName: sessionStorage.getItem("PatName"),
                    Age: sessionStorage.getItem("PatAge"),
                    Gender: sessionStorage.getItem("PatGender"),
                    MobileNo: sessionStorage.getItem("PatTRANNO"),
                    Redirect: Type == "C" ? "M" : "SS"
                };

                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECLINICNOTESYN")%>' == "Y") {
                    var ClinicalNoteData = "";
                    if (IsClinicNotesFreeTxtVisible === "Y") {
                        ClinicalNoteData = $("#ClinicalNotes_Freetext").val();
                    }
                    else {
                        ClinicalNoteData = encodeURIComponent(CKEDITOR.instances.ClinicalNotes_HtmlEditor.document.getDocumentElement().getHtml());
                    }

                    if (ClinicalNoteData == "") {
                        ToastMsg("Please Enter Clinical Notes", "warning");
                        Flag = false;
                    }
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECHEMOPLANYN")%>' == "Y") {
                    if (MedicalRights && $("#ChkSaveChemoPlan").prop("checked") == true) {
                        if (ValidationForChemoPlanning(Type) == false)
                            return false;
                    }
                }
                if (ConfrmForRMOSave(Type, ValidationYes, ValidationDiagYes) == false)
                    return false;
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECOMPLAINTSYN")%>' == "Y") {
                    SaveForComplaints(OPDDataToSendForDraft, Type);
                    SaveFlag = true;
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEEXAMYN")%>' == "Y") {
                    SaveForExaminations(OPDDataToSendForDraft, Type);
                    SaveFlag = true;
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEDIAGNOSISYN")%>' == "Y") {
                    if (ValidationForICDODiagonsis()) {
                        SaveForUnCodedDiagonsis(OPDDataToSendForDraft, Type);
                        SaveForICDDiagonsis(OPDDataToSendForDraft, Type);
                        SaveICDODiagnosis(OPDDataToSendForDraft, Type);
                    }
                    else {
                        return false;
                    }
                    SaveFlag = true;
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECLINICNOTESYN")%>' == "Y") {
                    SaveForClinicalNotes(OPDDataToSendForDraft, Type);
                    SaveFlag = true;
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINVESTIGATIONYN")%>' == "Y") {
                    SaveForInvestigations(OPDDataToSendForDraft, Type);
                    SaveFlag = true;
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINSTRUCTIONYN")%>' == "Y") {
                    SaveForInstruction(OPDDataToSendForDraft, Type);
                    SaveFlag = true;
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVERXYN")%>' == "Y") {
                    SaveForRx(OPDDataToSendForDraft, Type);
                    SaveFlag = true;
                }
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEADVICEYN")%>' == "Y") {
                    SaveForAdvice(OPDDataToSendForDraft, Type);
                    SaveFlag = true;
                }
                if (ConfrmForICDDiagSave(Type, ValidationYes, ValidationDiagYes) == false)
                    return false;
                if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECHEMOPLANYN")%>' == "Y") {
                    if (MedicalRights && $("#ChkSaveChemoPlan").prop("checked") == true) {
                        SaveForChemoPlanning(OPDDataToSendForDraft, Type);
                        SaveFlag = true;
                    }
                }

                if (SaveFlag == false) {
                    ToastMsg("Save Config not Done. Please Contact IT.", "info");
                    return false;
                }
                startLoading("Loading");
                $("#SinglePageOPD_DraftSave, #SinglePageOPD_CompltSave").prop("disabled", true);
                $.ajax({
                    type: "Post",
                    url: "../SinglePage/SaveFollowUpData",
                    data: OPDDataToSendForDraft,
                    async: true,
                    success: function (Result) {
                        if (Result == "Presription Saved Successful" || Result == "Draft Saved Successful") {
                            ToastMsg(Result, "info");
                            if (Type == "C") {
                                if (PrescpPrintYN == "Y") {
                                    GetBindingDataForSelectedPrint("Y");
                                    //Need to Call the Print Function
                                }
                                else {
                                    window.location.href = "../SinglePage/WaitingListOPD";
                                }
                            }
                            else {
                                if (MedicalRights) {
                                    // reset shared binding state before reloading either section
                                    IsChemoBind = false;
                                    IsAdviceBind = false;
                                    MedSchemeCodes = "";
                                    MedSchemeCodesFrom = "";

                                    reloadChemoPlanning(function () {
                                        //LoadAdviceSection();
                                    });
                                }
                            }
                        }
                        else {
                            ToastMsg(Result, "info");
                        }
                        $("#SinglePageOPD_DraftSave, #SinglePageOPD_CompltSave").prop("disabled", false);
                        stopLoading();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        ToastMsg(textStatus, "error");
                        stopLoading();
                        $("#SinglePageOPD_DraftSave, #SinglePageOPD_CompltSave").prop("disabled", false);
                    }
                });
            }
            else {
                if (ValidationForComplaints(Type) == true && ValidationForExamination(Type) == true
                    && ValidationForUnCodedDiagonsis(Type) == true && ValidationForICDDiagonsis() == true && ValidationForICDODiagonsis() == true
                    && ValidationForClinicalNotes(Type) == true && ValidationForInvestigations(Type) == true
                    && ValidationForRx(Type) == true && ValidationForInstruction(Type) == true && ValidationForAdvice(Type) == true

                ) {
                    if (MedicalRights && $("#ChkSaveChemoPlan").prop("checked") == true) {
                        if (ValidationForChemoPlanning(Type) == false)
                            return false;
                    }
                    if ((HASDataInComplaints() == false && HASDataInDiagnosis() == false
                        && HASDataInInvestigation() == false && HASDataInInstruction() == false && HASDataInRX() == false
                        && HASDataInExamination() == false && HASDataInClinicalNotes() == false
                        && HASDataInAdvice() == false)) {
                        if (MedicalRights && $("#ChkSaveChemoPlan").prop("checked") == true) {
                            if (HASChemoPlanningData() == false) {
                                ToastMsg("Please Enter Details Atleast In One Section", "info");
                                return false;
                            }
                        }
                        else {
                            ToastMsg("Please Enter Details Atleast In One Section", "info");
                            return false;
                        }

                    }
                    if (ConfrmForICDDiagSave(Type, ValidationYes, ValidationDiagYes) == false)
                        return false;
                    var OPDDataToSendForDraft = {
                        MRNO: sessionStorage.getItem("PatMRNO"),
                        TRANNO: sessionStorage.getItem("PatTRANNO"),
                        PatName: sessionStorage.getItem("PatName"),
                        Age: sessionStorage.getItem("PatAge"),
                        Gender: sessionStorage.getItem("PatGender"),
                        MobileNo: sessionStorage.getItem("PatTRANNO"),
                        Redirect: Type == "C" ? "M" : "SS"
                    };

                    SaveForComplaints(OPDDataToSendForDraft, Type);
                    SaveForExaminations(OPDDataToSendForDraft, Type);
                    SaveForUnCodedDiagonsis(OPDDataToSendForDraft, Type);
                    SaveForICDDiagonsis(OPDDataToSendForDraft, Type);
                    SaveICDODiagnosis(OPDDataToSendForDraft, Type);
                    SaveForClinicalNotes(OPDDataToSendForDraft, Type);
                    SaveForInvestigations(OPDDataToSendForDraft, Type);
                    SaveForRx(OPDDataToSendForDraft, Type);
                    SaveForInstruction(OPDDataToSendForDraft, Type);
                    $("#SinglePageOPD_DraftSave, #SinglePageOPD_CompltSave").prop("disabled", true);
                    if (MedicalRights && $("#ChkSaveChemoPlan").prop("checked") == true) {
                        SaveForChemoPlanning(OPDDataToSendForDraft, Type);
                    }
                    SaveForAdvice(OPDDataToSendForDraft, Type);
                    var strCompCode = sessionStorage.getItem('OPDCompCode');

                    if ((MedicalRights || SurgicalRights || RaditionRights)) { // && strCompCode
                        SaveForReqScheme(OPDDataToSendForDraft, Type);
                    }
                    startLoading("Loading");
                    $.ajax({
                        type: "Post",
                        url: "../SinglePage/SaveFollowUpData",
                        data: OPDDataToSendForDraft,
                        async: true,
                        success: function (Result) {
                            if (Result == "Presription Saved Successful" || Result == "Draft Saved Successful") {
                                ToastMsg(Result, "info");
                                if (Type == "C") {
                                    if (PrescpPrintYN == "Y") {
                                        //Need to Call the Print Function
                                        GetBindingDataForSelectedPrint("Y");
                                    }
                                    else {
                                        window.location.href = "../SinglePage/WaitingListOPD";
                                    }
                                }
                                else {
                                    if (MedicalRights) {
                                        // reset shared binding state before reloading either section
                                        IsChemoBind = false;
                                        IsAdviceBind = false;
                                        MedSchemeCodes = "";
                                        MedSchemeCodesFrom = "";

                                        reloadChemoPlanning(function () {
                                            //LoadAdviceSection();
                                        });
                                    }
                                }
                            }
                            else {
                                ToastMsg(Result, "info");
                            }
                            stopLoading();
                            $("#SinglePageOPD_DraftSave, #SinglePageOPD_CompltSave").prop("disabled", false);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            ToastMsg(textStatus, "error");
                            stopLoading();
                            $("#SinglePageOPD_DraftSave, #SinglePageOPD_CompltSave").prop("disabled", false);
                        }
                    });
                }
            }
        }
    </script>

    <%-- Prescription Print --%>
    <script type="text/javascript">
        function PrescriptionPrintReport() {

        }
    </script>

    <%-- Tumor Board --%>
    <script type="text/javascript">
        function GetTumorPatList() {
            $("#tblTumorBoard").empty();
            NoDataFound("No Data Found.", "tblTumorBoard");
            var mrno = GetSessionMRNO(); 
            var DataToSend = {
                sfrmdate: $("#txtFromDate").val(),
                stodate: $("#txtToDate").val(),
                spatname: sessionStorage.getItem("PatName").toString().trim(),
                smrno: GetSessionMRNO(),
                RefTumor: "Y",
                RefTumorStatus: "A",
            }
            $.ajax({
                url: '../DoctorDesk/TumorBoardPatListBinding',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: true,
                success: function (data) {
                    if (data.rows.length > 0) {
                        $("#RedirectToTumor").show();
                    } else {
                        $("#RedirectToTumor").hide();
                    }
                },
                complete: function () {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }
    </script>

    <%-- Added By Roshan CIMS Info 20251208 --%>
    <style type="text/css">

          .CIMS-container {
              padding: 10px 0px;
              background-color: #f8fbff;
              border-radius: 8px;
              box-shadow: 0 4px 10px rgba(0,0,0,0.1);
              font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
              position: relative;
          }

          .CIMS-header {
              margin-top: 0;
              margin-bottom: 5px;
              color: #003366;
              padding-bottom: 5px;
              font-size: 1em;
              font-weight: 700;
              background-color: #0d2b46;
              text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
              letter-spacing: 0.5px;
              border-bottom: 1px solid gray;
          }

          .CIMS-footer {
              padding: 5px;
              background-color: #f9f9f9;
          }

          .CIMS-footer button {
               margin-left: 10px;
          }

          .CIMS-footer {
              text-align: center;
              position: absolute;
              bottom: 0;
              height: 7%;
              width: 95%;
          }

          .CIMS-body {
              max-height: 86%;
              height: 86%;
              width:100%;
              overflow-y: auto;
              overflow-x: hidden; 
              padding-right: 10px;
              box-sizing: border-box;
              font-size:14px;
      
          }
          #CIMSBody::-webkit-scrollbar {
              width: 8px;   
              display:none !important;
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

          .CIMS-blinking {
              animation: professionalBlink 1s infinite;
              transition: all 0.3s ease;
          }

          .ui-dialog[aria-describedby="divCIMSInfo"] .ui-dialog-titlebar {
              display: none !important;
          }

        /* Added By Abhishesh || 20261016 - CIMS popup was opening behind the Chemo Planning table */
        .ui-dialog[aria-describedby="divCIMSInfo"] {
            padding-top: 0 !important;
            z-index: 100001 !important; 
        }
        .ui-widget-overlay.ui-front {
            z-index: 100000;
        }
        /* END*/

          .CIMS-close {
             position: absolute;
             top: 15px;
             right: 25px;
             color: #ffffff;
             font-size: 25px;
             font-weight: bold;
             cursor: pointer;
             line-height: 1;
          }

          .CIMS-close:hover {
             color: #ff4d4d;
          }

          
        /* Tablet */
        @media (max-width: 768px) {
            .ui-dialog[aria-describedby="divCIMSInfo"] {
                width: 95vw !important;
                height: 90vh !important;
                max-height: 90vh !important;
            }
        }

        /* Mobile */
        @media (max-width: 480px) {
            .ui-dialog[aria-describedby="divCIMSInfo"] {
                width: 100vw !important;
                height: 100vh !important;
                max-height: 100vh !important;
                top: 0 !important;
                left: 0 !important;
                border-radius: 0 !important;
            }
        }
        </style>

    <script type="text/javascript">
        const IS_DISPLAY_CIMS_FUNCTIONLITY = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("IS_DISPLAY_CIMS_INTEGRATION")%>';
        function toggleInfoColumn() {
            if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                $(".th-info").show();
            } else {
                $(".th-info").hide();
            }
        }

        function preapreDataForCIMS(Table) {
            var MaterialCodes = [];
            var alldata = Table.getData();
            for (var i = 0; i < Table.getDataCount(); i++) {
                var rowData = alldata[i];
                MaterialCodes.push(rowData.DrugCode || rowData.GENERICID);
            }

            let mrno = '';
            let ipno = '';
            let moduleFlag = sessionStorage.getItem('MODULE_FLAG') || '';
            if (moduleFlag && moduleFlag == 'IPD') {
                mrno = sessionStorage.getItem('IPPatMRNO') || ' ';
                ipno = sessionStorage.getItem('IPPatIPNO') || ' ';
            }
            else if (moduleFlag && moduleFlag == 'OPD') {
                mrno = sessionStorage.getItem('PatMRNO') || ''
                ipno = '';
            }
            else if (moduleFlag && moduleFlag == 'PAC') {
                mrno = sessionStorage.getItem('PACPatMRNO') || ''
                ipno = '';
            }

            var DataToSend = {
                DrugCodes: JSON.stringify(MaterialCodes),
                Type: "html",
                Mrno: mrno,
                Ipno: ipno
            };
            return DataToSend;
        }

    </script>

    <script src="../Scripts/_CimsCommon.js"></script>

    <div class="opd-main-container">
        <div id="HeaderSection_OPDPatInfo" class="patient-info-header">
            <% Html.RenderAction("PatientInfoOPD", "SinglePage"); %>
            <div id='loading-PatientInfo' class='loading-screen' style='display: none; opacity: 0;'></div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4 sticky-top bg-white pt-2 pb-2" style="z-index: 99;">
            <div class="nav-scroller">
                <a href="#sec-complaints" class="tab-btn active">Complaints</a>
                <a href="#sec-exam" class="tab-btn">Examination</a>
                <a href="#sec-Diagnosis" class="tab-btn">Diagnosis</a>
                <a href="#sec-clinical" class="tab-btn">Clinical Notes</a>
                <a href="#sec-Investigations" class="tab-btn">Investigations</a>
                <a href="#sec-Instructions" class="tab-btn">Instructions</a>
                <a href="#sec-ChemoPlanning" class="tab-btn d-none" id="OPD_ChemoPlanning">Chemo Planning</a>
                <a href="#sec-Rx" class="tab-btn">Rx</a>
                <a href="#sec-advice" class="tab-btn">Advice</a>
            </div>
            <div>
                <button class="btn btn-save-draft btn-sm me-2" style="display:none;" id="SinglePageOPD_DraftSave" onclick="OPDSaveAsDraft('R');">Save As Draft</button>
                <button class="btn btn-save-complete btn-sm" style="display:none;"  id="SinglePageOPD_CompltSave" onclick="OPDSaveAsDraft('C');">Save And Complete</button>
            </div>
        </div>
        <div class="scrollable-content-area" id="OPDContentMainDiv">

            <% Html.RenderAction("Complaints", "SinglePage"); %>

            <% Html.RenderAction("Examination", "SinglePage"); %>

            <% Html.RenderAction("Diagnosis", "SinglePage"); %>

            <% Html.RenderAction("ClinicalNotes", "SinglePage"); %>

            <% Html.RenderAction("Investigation", "SinglePage"); %>

            <% Html.RenderAction("Instruction", "SinglePage"); %>

            <div id="sec-ChemoPlanning" class="opd-section-card anchor-offset d-none">
                <div id="chemoPlanningContainer"></div>
                <div class="AllAdvicePreAuthSchemeSect" id="AllAdvicePreAuthSchemeSect_M"></div>
                <div id="loading-chemoPlanning" class="loading-screen" style="display: none; opacity: 0;"></div>
            </div>
            <% Html.RenderAction("RX", "SinglePage"); %>

            <div id="AdviceContainer"></div>

        </div>
    </div>

    <div id="divCIMSInfo" style="display: none;">
        <div class="CIMS-container" style="height:90vh !important;">
            <div class="CIMS-header">
                <div style="display: inline-block; vertical-align: middle; margin-top: 7px; padding-left: 4px;">
                    <img src="../Images/CIMS_Images/Drug.png" style="height: 28px; width: 28px; vertical-align: middle;" />
                </div>
                <div style="display: inline-block; vertical-align: middle; margin-top: 7px;">
                    <h2 class="CIMS-header-child" style="color: white; margin: 0; vertical-align: middle; font-size: 19px;"></h2>
                </div>
                <div class="CIMS-close" onclick="$('#divCIMSInfo').dialog('close')" title="Close"><i class="fa fa-times"></i></div>
            </div>
            <div class="CIMS-body" id="CIMSBody"></div>
        </div>
    </div>
</asp:Content>
