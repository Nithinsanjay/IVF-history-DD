<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SinglePageIPD.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.OncologyModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="<%=ResolveUrl("~/js/fancybox/jquery.fancybox.pack2-0-5.js")%>"></script>
    <link href="../js/fancybox/jquery.fancybox2.0.5.css" rel="stylesheet" type="text/css" />

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
        input[type="file"]:not(:disabled)::-webkit-file-upload-button,
        input[type="date"]:not(:disabled)::-webkit-calendar-picker-indicator,
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
            margin-right: 17px;
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
            scroll-margin-top: 30px; /* Adjust based on your header height */
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

        .anchor-offset {
            scroll-margin-top: 140px;
        }

        /* --- NOTES STYLES (Prefix: .nt-) --- */
        .nt-wrapper {
            padding: 0px;
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
            padding: 5px;
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
            font-size: 12px;
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
    </style>
    <%-- Added By Roshan CIMS Info 20251208 --%>
    <style type="text/css">
        .CIMS-container {
            display: flex;
            flex-direction: column; /* stack header, body, footer */
            width: 100%;
            height: 70%;
            max-height: 82vh; /* limit dialog height to viewport */
            overflow: hidden; /* prevent container scroll */
        }

        .CIMS-body {
            flex: 1; /* take remaining space */
            overflow-y: auto; /* only this scrolls */
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
            z-index: 100001 !important; 
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
        const IS_DISPLAY_CIMS_FUNCTIONLITY = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("IS_DISPLAY_CIMS_INTEGRATION")%>';  // Added By Roshan - 12/10/2025
        function toggleInfoColumn() {
            if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                $(".th-info").show();
            } else {
                $(".th-info").hide();
            }
        }

        //Fixed Pass The id Tabulator for Medication And Chemo
        function preapreDataForCIMS(Table) {
            var MaterialCodes = [];
            var alldata = Table.getData();
            for (var i = 0; i < Table.getDataCount(); i++) {
                var rowData = alldata[i];
                MaterialCodes.push(rowData.DrugCode || rowData.GENERICID || "");
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
    <%-- End By Roshan CIMS Info 20251208 --%>

    <script type="text/javascript">
        <% var SampMainView = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var FormLinkRouteList = '<%:Html.Raw(SampMainView.Serialize(ViewBag.FormLinkRouteList))%>';
        var MedicalRights = false;
        var saveChemoYN = false;
        var PACRights = false;
        var SURRights = false;//priyanka 21/05/2026
var IsAdviceBind = false;
var gact = "N";

if (!sessionStorage.getItem("PatCompleted")) {
    sessionStorage.setItem("PatCompleted", "N");
}

        $(document).ready(function () {
            sessionStorage.removeItem('ConsultationDate');
            // Abhishesh || 20260714
            // Based on the Session Patient Complete or not , Also Patient Search
            EnableDisableContent();
            const scrollContainer = document.getElementById('OPDContentMainDiv');
            const sections = document.querySelectorAll('.opd-section-card');
            const tabBtns = document.querySelectorAll('.tab-btn');

           
            // 1. Smooth Scroll on Click with Scroll-Lock
            var isTabClickScrolling = false;
            var tabScrollTimer = null;

            $('.tab-btn').click(function (e) {
                e.preventDefault();

                var $clickedTab = $(this);
                var targetId = $clickedTab.attr('href');
                if (!targetId || !targetId.startsWith('#')) return;

                var targetElement = document.querySelector(targetId);
                if (!targetElement) return;

                // Immediately set active yellow box on clicked tab
                $('.tab-btn').removeClass('active');
                $clickedTab.addClass('active');

                // Lock the scroll listener so it does NOT steal the active box while animating
                isTabClickScrolling = true;
                clearTimeout(tabScrollTimer);

                // Calculate exact scroll target position inside the scrollable container
                var stickyTabsHeight = 60;
                var targetTop = targetElement.getBoundingClientRect().top
                    - scrollContainer.getBoundingClientRect().top
                    + scrollContainer.scrollTop
                    - stickyTabsHeight;

                scrollContainer.scrollTo({
                    top: Math.max(0, targetTop),
                    behavior: 'smooth'
                });

                // Unlock the scroll listener after smooth scroll finishes
                tabScrollTimer = setTimeout(function () {
                    isTabClickScrolling = false;
                }, 600);
            });


            // 2. Update Active Yellow Box smoothly on manual Mouse Scroll
            scrollContainer.addEventListener('scroll', () => {
                // If scroll was triggered by clicking a tab, don't interfere
                if (isTabClickScrolling) return;

                let currentSectionId = "";
                const containerRect = scrollContainer.getBoundingClientRect();

                document.querySelectorAll('.opd-section-card').forEach(section => {
                    const rect = section.getBoundingClientRect();
                    // 120px offset accounts for sticky header
                    if (rect.top <= containerRect.top + 120) {
                        currentSectionId = section.getAttribute('id');
                    }
                });

                if (currentSectionId) {
                    $('.tab-btn').removeClass('active');
                    $(`.tab-btn[href="#${currentSectionId}"]`).addClass('active');
                }
            });


            /* vandana 190226 Search Outside Click Event */
            $(document).on("click", function (e) {
                if (!$(e.target).closest("#InvstgSearch,#InvstgListMainDiv,#InvstgList").length) {
                    $("#InvstgSearch").val("");
                    $("#InvstgListMainDiv").hide();
                }
                if (!$(e.target).closest("#MedicineSearch,#MedicineListMainDiv,#MedicineList").length) {
                    $("#MedicineSearch").val("");
                    $("#MedicineListMainDiv").hide();
                }
                if (!$(e.target).closest("#MedicationSearch,#MedicationListMainDiv,#MedicationList").length) {
                    $("#MedicationSearch").val("");
                    $("#MedicationListMainDiv").hide();
                }

                //Uncoded Diagnosis priyanka 20/04/2026
                if (!$(e.target).closest("#UnCodedDiagonsisSearch,#UnCodedDiagonsisListMainDiv,#UnCodedDiagonsisList").length) {
                    $("#UnCodedDiagonsisSearch").val("");
                    $("#UnCodedDiagonsisListMainDiv").hide();
                }

                //ICD Diagnosis priyanka 20/04/2026
                if (!$(e.target).closest("#ICDDiagonsisSearch,#ICDDiagonsisListMainDiv,#ICDDiagonsisList").length) {
                    $("#ICDDiagonsisSearch").val("");
                    $("#ICDDiagonsisListMainDiv").hide();
                }
                //priyanka 20/04/2026
                $(".TopoHistSrchTxt").val("");
                $(".SiteTopoSrchTxt").val("");
                $(".SearchList").hide();
                //end
                stopLoading();
            });
            GetNotes("N"); // To show Notes Count priyankan 22/04/2026
            //priyanka 21/05/2026
            IPD_GetAllClincslist();
            if (PACRights === true) {
                $("#sec-PAC").removeClass("d-none");
                $("#IPD_PAC").removeClass("d-none");
            }
            else {
                $("#sec-PAC").addClass("d-none");
                $("#IPD_PAC").addClass("d-none");
            }


            // --- Feature Switching Based on Doctor Type ---
            if (SURRights === true && MedicalRights !== true && PACRights !== true) {
                // Only Surgical Oncology doctors get OT Booking (NOT PAC)
                $("#OTBookingRequestSec").removeClass("d-none");
                $("#sec-OTBookingRequest").removeClass("d-none");
                $("#sec-ChemoPlanning").addClass("d-none");
            }
            else if (MedicalRights === true && SURRights !== true) {
                // Medical Oncology doctors get Chemo Planning
                $("#sec-ChemoPlanning").removeClass("d-none");
                $("#OTBookingRequestSec").addClass("d-none");
                $("#sec-OTBookingRequest").addClass("d-none");
            }
            else if (MedicalRights === true && SURRights === true && PACRights !== true) {
                // Doctors with both rights (excluding PAC)
                $("#sec-ChemoPlanning").removeClass("d-none");
                $("#OTBookingRequestSec").removeClass("d-none");
                $("#sec-OTBookingRequest").removeClass("d-none");
            }
            else {
                // PAC doctors & Other doctors: HIDE OT Booking and Chemo Planning
                $("#OTBookingRequestSec").addClass("d-none");
                $("#sec-OTBookingRequest").addClass("d-none");
                $("#sec-ChemoPlanning").addClass("d-none");
            }


            // Intra-Operative Notes
            if (SURRights === true || PACRights === true) {
                $("#sec-IntraOperativeNotes").removeClass("d-none");
            } else {
                $("#sec-IntraOperativeNotes").addClass("d-none");
            }

            //end
        });
        function IPD_GetAllClincslist() { //priyanka 21/05/2026
            //debugger;
            $.ajax({
                type: "POST",
                url: "../Account/GetDctrAllClinic",
                data: {},
                async: false,
                success: function (result) {
                    var CList = [];
                    var SList = [];
                    var MList = [];
                    if (result.length > 0) {
                        CList = result.filter(function (item) {
                            return item.ClinicType === "P";
                        });

                        SList = result.filter(function (item) {
                            return item.ClinicType === "S";
                        });
                        MList = result.filter(function (item) {
                            return item.ClinicType == "M";
                        });


                        if (CList.length > 0 && CList[0]["ClinicType"] === "P") {
                            PACRights = true;
                        }
                        else {
                            PACRights = false;
                        }
                        if (SList.length > 0 && SList[0]["ClinicType"] === "S") {
                            SURRights = true;
                        }
                        else {
                            SURRights = false;
                        }
                        if (MList.length > 0 && MList[0]["ClinicType"] === "M") {
                            MedicalRights = true;
                        }
                        else {
                            MedicalRights = false;
                        }
                    }
                },
                complete: function (jqXHR, status) {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                }
            });
        }

        function ConfrmForICDDiagSave(ValidationDiagYes) {
            var Flag = true;
            if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CONFIRMFORICDYN")%>' == "Y" && '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEDIAGNOSISYN")%>' == "Y" && ValidationDiagYes != "Y") {
                if (ICDDiagListtable.getData().length == 0) {
                    var MessagePrompt = "No data found for <b>ICD Diagnosis.</b><br/>Do you want to continue saving ?"
                    openPopupDynamic("Confirmation", MessagePrompt, [
                        { text: "Yes", class: "btn btn-yes", action: "IPDCommonSave('Y')" },
                        { text: "No", class: "btn btn-no", action: "closePopup()" }
                    ]);
                    Flag = false;
                }
            }
            return Flag;
        }
function IPDCommonSave(ValidationDiagYes = "") {
    // 1. Confirmation for ICD Diagnosis (if applicable)
    if (typeof ConfrmForICDDiagSave === "function" && ConfrmForICDDiagSave(ValidationDiagYes) === false) {
        return false;
    }

    // 2. Run validations from each partial view FIRST
    if (typeof ValidationForHistoryExamIPD === "function" && !ValidationForHistoryExamIPD()) return false;
    if (typeof ValidationForUnCodedDiagonsis === "function" && !ValidationForUnCodedDiagonsis()) return false;
    if (typeof ValidationForICDDiagonsis === "function" && !ValidationForICDDiagonsis()) return false;
    if (typeof ValidationForICDODiagonsis === "function" && !ValidationForICDODiagonsis()) return false;
    if (typeof ValidationForProgressNotes === "function" && !ValidationForProgressNotes()) return false;
    if (typeof ValidationFoTrtmntOrderHeader === "function" && !ValidationFoTrtmntOrderHeader()) return false;
    if (typeof ValidationFoTrtmntOrderMedicine === "function" && !ValidationFoTrtmntOrderMedicine()) return false;
    if (typeof validationForTreatmentAntibiotic === "function" && !validationForTreatmentAntibiotic()) return false;
    if (typeof ValidationFoChemoTable === "function" && !ValidationFoChemoTable()) return false;
    if (typeof ValidationFoTrtmntOrderInfusion === "function" && !ValidationFoTrtmntOrderInfusion()) return false;
    if (typeof ValidationForOTBookingRequest === "function" && !ValidationForOTBookingRequest()) return false;

    // 3. Start batch saving
    startLoading("Saving...");

    var originalToastMsg = window.ToastMsg;
    var hasErrors = false;

    // Intercept toasts from partial saves
    window.ToastMsg = function (msg, type) {
        var strMsg = ("" + (msg || "")).toLowerCase();
        var isErrorOrWarning = type === "error" || type === "warning" ||
            strMsg.includes("cannot insert") ||
            strMsg.includes("error") ||
            strMsg.includes("failed") ||
            strMsg.includes("not inserted");

        if (isErrorOrWarning) {
            hasErrors = true;
            originalToastMsg(msg, type || "error");
        }
        // Intermediate "success" and "info" toasts are silenced
    };

    try {
        var IPDDataToSendForDraft = {};

        if (typeof SaveHistoryExamIPD === "function") SaveHistoryExamIPD(IPDDataToSendForDraft, true);
        if (typeof SaveForProgressNotes === "function") SaveForProgressNotes(IPDDataToSendForDraft);
        if (typeof SaveForOTBookingRequest === "function") SaveForOTBookingRequest(IPDDataToSendForDraft);
        if (typeof SaveDiagnosis === "function") SaveDiagnosis();

        if (typeof isTableHasData === "function") {
            if (typeof InfusionTable !== "undefined" && isTableHasData(InfusionTable)) {
                SaveInfusionData(IPDDataToSendForDraft);
            }
            if ((typeof TrmtntOrderMedicineTable !== "undefined" && isTableHasData(TrmtntOrderMedicineTable)) ||
                (typeof TrmtntOrderMedicationTable !== "undefined" && isTableHasData(TrmtntOrderMedicationTable))) {
                SaveTreatmentOrderMedicine(IPDDataToSendForDraft, "M");
                SaveTreatmentOrderMedicine(IPDDataToSendForDraft, "S");
            }
            if (typeof IVFluidTable !== "undefined" && isTableHasData(IVFluidTable)) {
                SaveIvFluid(IPDDataToSendForDraft);
            }
            if (typeof BloodProductTable !== "undefined" && isTableHasData(BloodProductTable)) {
                SaveBloodProduct(IPDDataToSendForDraft);
            }
            if ((typeof InvstgListtable !== "undefined" && isTableHasData(InvstgListtable)) ||
                $(".referral-row").length > 0 || $(".nutrit-row").length > 0) {
                SaveInvestigation(IPDDataToSendForDraft);
            }
            if (typeof ChemoListtable !== "undefined" && isTableHasData(ChemoListtable)) {
                SaveChemo(IPDDataToSendForDraft);
            }
        }
    } catch (err) {
        hasErrors = true;
        originalToastMsg("Error saving data: " + (err.message || err), "error");
    }

    // 4. Result Handling
    if (!hasErrors) {
        // Show only the single unified toast
        originalToastMsg("Record Saved Successfully.", "success");
        // Keep loading screen active until reload so user cannot click anything
        setTimeout(function () {
            window.location.reload();
        }, 1200);
    } else {
        // If there was an error, stop loading and restore ToastMsg so user can fix and retry
        stopLoading();
        window.ToastMsg = originalToastMsg;
    }
}



        // Based on the Session Patient
        function EnableDisableContent() {
            //if (sessionStorage.getItem("PatTRANNO") === "" || sessionStorage.getItem("PatTRANNO") === null) {
            //    $("#HeaderSection_OPDPatInfo").find("*").attr("disabled", true);
            //    $("#OPDContentMainDiv").find("*").attr("disabled", true);
            //    $("#OPDPatientDashboard_BackBtn").prop('disabled', false);
            //}
            //else {
            //    $("#HeaderSection_OPDPatInfo").find("*").attr("disabled", false);
            //    $("#OPDContentMainDiv").find("*").attr("disabled", false);
            //    $("#OPDPatientDashboard_BackBtn").prop('disabled', false);
            //}
        }

        //Adjust Tabulator Height Based on the Content
        //function adjustTableHeight(tabulatorGridId) {
        //    const instances = Tabulator.findTable("#" + tabulatorGridId);
        //    if (!instances || instances.length === 0) {
        //        ToastMsg("No Tabulator instance found for #" + tabulatorGridId, "warning");
        //        return false;
        //    }
        //    const table = instances[0];
        //    const rows = table.getRows();
        //    let totalHeight = 0;
        //    rows.forEach(row => {
        //        totalHeight += row.getElement().offsetHeight;
        //    });
        //    const headerEl = document.querySelector(`#${tabulatorGridId} .tabulator-header`);
        //    if (headerEl) {
        //        const headerHeight = headerEl.offsetHeight;
        //        const newHeight = totalHeight + headerHeight + 30;
        //        table.setHeight(newHeight);
        //    }
        //}


        function adjustTableHeight(tabulatorGridId) { //priyanka 02/04/2026

            const instances = Tabulator.findTable("#" + tabulatorGridId);
            if (!instances || instances.length === 0) return;

            const table = instances[0];

            // ✅ Save horizontal scroll position
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

                // ✅ Restore horizontal scroll AFTER redraw
                setTimeout(() => {
                    table.rowManager.element.scrollLeft = scrollLeft;
                }, 0);
            }
        }

        //Auto Height Set For Textarea
        function autoResizeTextareaForSinglePage(el) {
            const lines = el.value.split("\n").length;
            el.rows = lines;
        }
    </script>

    <script>
        function OpenIPDDischargeSummary() {
            var IPNo = sessionStorage.getItem('IPPatIPNO') || '';
            startLoading("Loading");
            $.ajax({
                type: "GET",
                url: "../SinglePage/GetExternalDischargeSummaryUrl",
                data: { IPNo: IPNo },
                async: true,
                success: function (response) {
                    stopLoading();
                    if (response.Status == "Success") {
                        window.location.href = response.Url;
                    }
                    else {
                        ToastMsg(response.Message, "error");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    stopLoading();
                    ToastMsg(textStatus, "error");
                }
            });
        }
    </script>
    <style>
        .IFrameEyeIcon {
            cursor: pointer;
            font-size: 18px;
            color: black;
            padding: 5px;
        }

        .GridEditIcon {
            cursor: pointer;
            font-size: 18px;
            color: black;
            padding: 5px;
        }

        .IFrameHistoryIcon {
            cursor: pointer;
            font-size: 18px;
            color: black;
            padding: 5px;
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
            display: none;
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

        .ModelContentDiv {
            padding: 5px 0px;
        }

        .ModelLbl {
            margin: 0px;
            width: 100px;
            padding: 5px 0px 5px 10px;
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

        table.tblpopupList {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-height: 112px;
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
                position: sticky;
                top: 0;
                z-index: 2;
                background: #314b81;
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

        .Tablewrapper {
            overflow-x: auto;
            width: 100%;
            max-height: 60vh;
            overflow-y: auto;
            overflow-x: auto;
        }
        #chemoPlanningModal .modal-dialog {
            width: 100vw;
            height: 100vh;
            margin: 0;
            padding: 0;
            max-width: 100%;
        }

        #chemoPlanningModal .modal-content {
            height: 100vh;
            border-radius: 0;
        }
#chemoPlanningContainer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: white;
    z-index: 1040;
    overflow: auto;
}
    </style>
    <script>


        function LoadPACHistory() {

            $.ajax({
                url: '../SinglePage/GetPACHistory',
                type: 'GET',
                data: {

                    MRNO: sessionStorage.getItem("IPPatMRNO")
                },
                success: function (response) {

                    PACHistList = response != null ? response : [];
                    OpenClosePACHistory();

                },
                error: function () {

                    PACHistList = [];

                }
            });

        }
        function OpenClosePACHistory() {
            BindPACHistoryList();
            document.getElementById("PACHistInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
        }

        function ClosePop(DivId) {
            document.getElementById(DivId).style.display = 'none';
            document.documentElement.style.overflow = '';
        }
        function BindPACHistoryList() {
            $("#TBodyPACHist").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCCONTENT}</td>";
            $.grep(PACHistList, function (a) {
                var RplIcon =
                    "<i class='fa fa-eye IFrameEyeIcon' title='Display'  onclick=\"openDisplayPAC('" + a.MRNO + "','" + a.PACCONSNO + "','" + a.PACFITDATE + "','" + a.PACFITTIME + "','" + a.STATUS + "')\"></i>" +
                    "<i class='fa fa-history IFrameHistoryIcon' title='Visit History' onclick=\"openVisitList('" + a.MRNO + "','" + a.PACCONSNO + "')\"></i>" +
                    (a.OTNOTESNO.trim() == "" ? ("<i class='fa fa-edit GridEditIcon' title='Edit' onclick=\"openEditPAC('" + a.MRNO + "','" + a.PACCONSNO + "','" + a.PACFITDATE + "','" + a.PACFITTIME + "','" + a.STATUS + "')\"></i>") : "");
                var RplIconTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", RplIcon);
                var RplTranNoTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACCONSNO);
                var RplRefDoctTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.DOCTNAME);
                var RplSurgAdvDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGADVDATE);
                var RplSurgeryTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGNMADVICE);
                var NatOfSurg = a.SURGADVTYPE == "R" ? "Elective" : (a.SURGADVTYPE == "E" ? "Emergency" : (a.SURGADVTYPE == "T" ? "Tentative" : ""))
                var RplNatOfSurgTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", NatOfSurg);
                var PacStatus = a.PACSTATUS === "F" ? "Fit" :
                    (a.PACSTATUS === "W" && a.ASARISKLEVEL === "") ? "Fit, with Accepted Risk" :
                        (a.PACSTATUS === "W" && a.ASARISKLEVEL !== "") ? "Fit, with Accepted Risk (" + a.ASARISKLEVEL + ")" :
                            (a.PACSTATUS === "U" ? "UnFit" : "Pending");

                var RplPacStatusTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", PacStatus);
                var RplPacStatusDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", (a.PACFITDATE.trim() == "" || a.PACFITDATE.trim() == "/  /" ? "" : (a.PACFITDATE + " " + a.PACFITTIME)));
                var RplCreatedByTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACDONEBY);
                var RplTr = Tr.replace("{TRCONTENT}", (RplIconTd + RplTranNoTd + RplRefDoctTd + RplSurgAdvDTTd + RplSurgeryTd + RplNatOfSurgTd + RplPacStatusTd + RplPacStatusDTTd + RplCreatedByTd));
                $("#TBodyPACHist").append(RplTr);
            });
        }

function openNewPAC() {
    var Mrno = sessionStorage.getItem("IPPatMRNO");
    startLoading("Loading");
    $.ajax({
        url: '../SinglePage/GetPendingSurgAdvList',
        type: 'post',
        dataType: 'json',
        data: { mrno: Mrno },
        success: function (list) {
            stopLoading();
            PendingPAC = { mrno: Mrno };
            // 1. Zero advices: Do NOT open form, just show the blue toast message
            if (!list || list.length === 0) {
                ToastMsg("There is currently no pending surgery advice for the selected patient.", "info");
                return;
            }
            // 2. Exactly 1 advice: Directly open form with that advice
            if (list.length === 1) {
                LoadPACForm(Mrno, list[0].TRANNO);
                return;
            }
            var $b = $("#SurgAdvPopupBody").empty();
            $.each(list, function (i, a) {
                var $tr = $("<tr/>");
                $tr.append($("<td/>").append($("<input type='radio' name='SurgAdvSel'/>").val(a.TRANNO).prop("checked", i === 0)));
                $tr.append($("<td/>").text(a.SURGADVDATE));
                $tr.append($("<td/>").text(a.SURGNMADVICE));
                $tr.append($("<td/>").text(a.DOCTNAME));
                $tr.append($("<td/>").text(a.SURGADVTYPE));
                $b.append($tr);
            });
            $("#SurgAdvPopup").css("display", "flex");
        },
        error: function (xhr, textStatus) { stopLoading(); ToastMsg(textStatus, "error"); }
    });
}

function CloseSurgAdvPopup() { $("#SurgAdvPopup").hide(); }

function ContinueSurgAdv() {
    var sel = $("input[name='SurgAdvSel']:checked").val();
    if (!sel) { ToastMsg("Please select a surgery advice.", "warning"); return; }
    CloseSurgAdvPopup();
    var p = PendingPAC;
    LoadPACForm(p.mrno, sel);
}

function LoadPACForm(Mrno, SurgAdvTranNo) {
           startLoading("Loading");
            var TranNo = "";
            var PacDT = "";
            var PacTM = "";
            var Status = "N";
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            document.getElementById('PACHistFrameLbl').innerText = TranNo + (PacDT.trim() == "" || PacDT.trim() == "/  /" ? "" : (" (" + PacDT.trim() + " " + PacTM.trim() + ")"));
            const iframe = document.createElement("iframe");
            iframe.id = "myIframe";
            iframe.src = "../SinglePage/PACIPD?PatMRNO=" + Mrno + "&PatTRANNO=" + TranNo + "&Gaction=" + "N" + "&MasterPage=" + "N" + "&IPDPACStatus=" + "N" +
                (SurgAdvTranNo ? '&SurgAdvTranNo=' + encodeURIComponent(SurgAdvTranNo) : '');
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.onload = function () {
                var code = gDoctCode;
                if (!code || code.trim() === "") {
                    document.getElementById("iframeContainer").style.display = "none";
                    window.location.href = "../Account/Login";
                    return;
                }
                const iframeDoc = iframe.contentWindow.document;
                const $secCont = $(iframeDoc).find("#secCont");
                const $iframeBody = $(iframeDoc).find("body, html");
                $(iframeDoc).find(".main-header").hide();
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
                ClosePop('PACHistInfoModal');
            };
            document.getElementById("iframeContainer").appendChild(iframe);
        }

        function openEditPAC(Mrno, TranNo, PacDT, PacTM, Status) {
            startLoading("Loading");
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            document.getElementById('PACHistFrameLbl').innerText = TranNo + (PacDT.trim() == "" || PacDT.trim() == "/  /" ? "" : (" (" + PacDT.trim() + " " + PacTM.trim() + ")"));
            const iframe = document.createElement("iframe");
            iframe.id = "myIframe";
            var Gaction = "V";
            var PACStatus = Status;
            iframe.src = "../SinglePage/PACIPD?PatMRNO=" + Mrno + "&PatTRANNO=" + TranNo + "&Gaction=" + Gaction + "&MasterPage=" + "N" + "&IPDPACStatus=" + PACStatus;
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.onload = function () {
                var code = gDoctCode;
                if (!code || code.trim() === "") {
                    document.getElementById("iframeContainer").style.display = "none";
                    window.location.href = "../Account/Login";
                    return;
                }
                const iframeDoc = iframe.contentWindow.document;
                const $secCont = $(iframeDoc).find("#secCont");
                const $iframeBody = $(iframeDoc).find("body, html");
                $(iframeDoc).find(".main-header").hide();
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
                ClosePop('PACHistInfoModal');
            };
            document.getElementById("iframeContainer").appendChild(iframe);
        }

        function openDisplayPAC(Mrno, TranNo, PacDT, PacTM, Status) {
            startLoading("Loading");
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            document.getElementById('PACHistFrameLbl').innerText = TranNo + (PacDT.trim() == "" || PacDT.trim() == "/  /" ? "" : (" (" + PacDT.trim() + " " + PacTM.trim() + ")"));
            var PACStatus = "D";
            const iframe = document.createElement("iframe");
            iframe.id = "myIframe";
            iframe.src = "../SinglePage/PACIPD?PatMRNO=" + Mrno + "&PatTRANNO=" + TranNo + "&Gaction=" + "D" + "&MasterPage=" + "N" + "&IPDPACStatus=" + PACStatus;
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            iframe.onload = function () {
                var code = gDoctCode;
                if (!code || code.trim() === "") {
                    document.getElementById("iframeContainer").style.display = "none";
                    window.location.href = "../Account/Login";
                    return;
                }
                const iframeDoc = iframe.contentWindow.document;
                const $secCont = $(iframeDoc).find("#secCont");
                const $iframeBody = $(iframeDoc).find("body, html");
                $(iframeDoc).find(".main-header").hide();
                if (Status == "V") {
                    $(iframeDoc).find("#BtnReview").hide();
                    $(iframeDoc).find("#PrintDiv").show();
                    $(iframeDoc).find("#BtnPrint").show();
                    $(iframeDoc).find("#BtnPrint").prop("disabled", false);
                }
                else
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
                ClosePop('PACHistInfoModal');
            };
            document.getElementById("iframeContainer").appendChild(iframe);
        }

        function openVisitList(mrno, tranno) {
            $.ajax({
                url: '../DoctorDesk/GetPACVisit',
                type: 'GET',
                data: { MRNO: mrno, TRANNO: tranno },
                dataType: 'json',
                success: function (data) {
                    if (!data || !data.Table) {
                        ToastMsg("No history found for this transaction.", "info");
                        return;
                    }
                    var tranNos = Object.values(data.AllTable).flat().map(x => x.TRANNO).filter(x => x);
                    var uniqueTranNos = [...new Set(tranNos)];
                    const rxList = data.Table6 || [];
                    const invList = data.Table3 || [];
                    const specList = data.Table || [];
                    const ConsLst = data.Table7 || [];
                    const SpecilityName = data.Table5 || [];
                    var html = "";
                    uniqueTranNos.forEach(tranNo => {
                        html += `<div id="fancybox-pac-content" style="width:100%; max-width:900px;">
                            <div class="pac-container">`;
                        const spec = specList.find(x => x.TRANNO === tranNo) || {};
                        const rxFiltered = rxList.filter(x => x.TRANNO === tranNo);
                        const invFiltered = invList.filter(x => x.TRANNO === tranNo);
                        const specilityRefrenceListFilter = SpecilityName.filter(x => x.TRANNO === tranNo)
                        const specilityRefrenceFilter = SpecilityName.filter(x => x.TRANNO === tranNo && x.REFNAME != '""').map(x => x.REFNAME);
                        const ConusltData = ConsLst.filter(x => x.TRANNO === tranNo);
                        if (ConusltData.length === 0) return;

                        const currentVisit = ConusltData[0];
                        var formattedDate = formatDate(currentVisit.TRANDATE);
                        var trantime = currentVisit.TRANTIME;
                        html += `
               <div class="pac-card" style="border: 1px solid #ddd; margin-bottom: 20px; border-radius: 4px;">
                   <div class="pac-header" style="background: #3c5a99; color: white; padding: 10px; display: flex; justify-content: space-between;">
                       <span>Dr. ${currentVisit.DOCTNAME || 'Consultant'}</span> 
                       <span>${formattedDate} - ${trantime}</span>
                   </div>
              
                   <div class="pac-body" style="padding: 15px;">
              
                   <div class="section-title" style="font-weight:bold; margin-top:10px; display:none; justify-content:space-between;">
                   <span>Rx</span>
                   </div>
              
                   <table class="pac-table" style="width:100%; font-size:12px;display:none;">
                             <thead style="background:#2c73b4; color:white;">
                         <tr>
                             <th style="padding:8px; border:1px solid #ddd;">Sr No</th>
                             <th style="padding:8px; border:1px solid #ddd;">Generic</th>
                             <th style="padding:8px; border:1px solid #ddd;">Frequency</th>
                             <th colspan="2" style="padding:8px; border:1px solid #ddd;">Duration</th>
                             <th style="padding:8px; border:1px solid #ddd;">Route</th>
                             <th style="padding:8px; border:1px solid #ddd;">Dosage</th>
                             <th style="padding:8px; border:1px solid #ddd;">Qty</th>
                             <th style="padding:8px; border:1px solid #ddd;">Remark</th>
                         </tr>
                     </thead>
                   <tbody>
              
                   ${rxFiltered.map((rx, index) => {
                            const durationType = rx.DURATION_UNIT || rx.DURATION;
                            let durationLabel = durationType;
                            if (durationType === 'W') durationLabel = 'Weeks';
                            else if (durationType === 'D') durationLabel = 'Days';
                            else if (durationType === 'M') durationLabel = 'Months';
                            return `
                           <tr>
                               <td>${index + 1}</td>
                               <td>${rx.GENERICNAME}</td>
                               <td>${rx.INTAKEDESC || rx.FREQUENCY}</td>
                               <td>${rx.DAYS}</td>
                               <td>${durationLabel}</td>
                               <td>${rx.ROUTE}</td>
                               <td>${rx.DOSSAGE}</td>
                               <td>${rx.QTY}</td>
                               <td>${rx.Remarks || 'As needed.'}</td>
                           </tr>`;
                        }).join('')
                            }
                   </tbody>
                   </table>
                   <div class="section-title" style="font-weight:bold; margin-top:10px; display:none; justify-content:space-between;">
                   <span>Investigation</span>
                   </div>
                   <div style="display:none;">              
                   ${invFiltered.length > 0 ? `
                           <ul>
                               ${invFiltered.map(inv => {
                                const durationPart = inv.DURATION && inv.DURATION != 0
                                    ? ` - ${inv.DURATION}` : '';
                                const remarkPart = inv.REMARK
                                    ? ` - ${inv.REMARK}` : '';
                                   return `<li>${inv.TESTNAME}${durationPart}${remarkPart.replace(/\\n/g, "\n") }</li>`;
                               }).join('')}
                           </ul>` : 'No investigations'}
                            </div>
                      <div class="section-title" style="font-weight:bold; margin-top:10px; display:none; justify-content:space-between;">
                        <span>Speciality Reference</span>
                      </div>
                      
                      <p style="display:none;">${specilityRefrenceFilter.length ? specilityRefrenceFilter.join(', ') : 'No Speciality Reference'}</p>
                      
                      
                      <div class="section-title" style="font-weight:bold; margin-top:10px; display:none; justify-content:space-between;">
                        <span>Speciality Others</span> 
                      </div>
                      
                      <p style="display:none;">${currentVisit.SPECIALITYREFERENCE && currentVisit.SPECIALITYREFERENCE != '""' ? currentVisit.SPECIALITYREFERENCE.replace(/\\n/g, "\n") : 'No Speciality Others'}</p>
                      
                      
                     <div class="section-title" style="font-weight:bold; margin-top:10px; display:flex; justify-content:space-between;">
                        <span>Anaesthesiologist Advice</span> 
                      </div>
                      
                      <p>${currentVisit.ANAESTADVICEOPERATIVEORDER && currentVisit.ANAESTADVICEOPERATIVEORDER != '""' ? currentVisit.ANAESTADVICEOPERATIVEORDER.replace(/\\n/g, "\n") : 'No Anaesthesiologist Advice'}</p>
                   </div>
               </div></div></div>
               `;
                    });
                    $.fancybox.open(html, {
                        beforeClose: function () {
                            OpenClosePACHistory();
                        }
                    });
                },
                error: function (xhr, status, error) {
                    ToastMsg("Failed to load data. Please check console for details.", "info");
                }
            });
            ClosePop('PACHistInfoModal');
        }

        function formatDate(dateStr) {
            if (!dateStr) return '';
            return dateStr.substring(6, 8) + "/" +
                dateStr.substring(4, 6) + "/" +
                dateStr.substring(0, 4);
        }       
        function openChemoPlanning(moduleFlag) {
            $("#chemoPlanningContainer").show();

            $("#chemoPlanningBody").load("../SinglePage/ChemoPlanning", function () {
                applyStickyHeader(moduleFlag);
            });
        }

        function closeChemoPlanning() {
            $("#chemoPlanningContainer").hide();
        }
        function ConvertArryListToTabulatorFormat(DataList, PropText, PropValue) {
            let lookup = {};
            lookup[""] = "";
            DataList.forEach(item => {
                lookup[item[PropValue]] = item[PropText];
            });
            return lookup;
        }

// --- Surgery Details Popup & Intra-Operative Notes Logic ---

function openIntraOperativeNotes() {
    var ipno = sessionStorage.getItem('IPPatIPNO') || $("#HeaderSection_PatDetails_ipNo").text().trim() || '';
    var mrno = sessionStorage.getItem('IPPatMRNO') || $("#HeaderSection_PatDetails_MRNO").text().trim() || '';

    // Check surgeries first before deciding to popup or bind directly
    $.ajax({
        type: 'POST',
        url: '../SinglePage/GetPatientOTBookings',
        data: { ipno: ipno, mrno: mrno },
        dataType: 'json',
        success: function(response) {
            // Save surgeries list in memory
            window.PatientSurgeriesList = response || [];

            // Case 0: No surgeries found -> Show formal notification on right side
            if (!response || response.length === 0) {
                if (typeof ToastMsg === "function") {
                    ToastMsg("No surgery records found for this patient", "warning");
                } else {
                    alert("No surgery records found for this patient");
                }
                return;
            }

            // Case 1: Exactly 1 surgery -> Directly open and bind without showing popup
            if (response.length === 1) {
                OpenSettingPopup('Intra-Operative Notes', 'OTNotes', true);
                addSurgeryListHeaderIcon();
                SelectSurgeryFromDoctorDesk(response[0].BOOKNO);
                return;
            }

            // Case > 1: Multiple surgeries -> Open notes in background & show popup to select
            OpenSettingPopup('Intra-Operative Notes', 'OTNotes', true);
            addSurgeryListHeaderIcon();
            populateSurgeryListTable(response);
            $("#DivPatientSurgeryListModal").css("display", "flex");
        },
        error: function(xhr, status, error) {
            if (typeof ToastMsg === "function") {
                ToastMsg("Error checking surgery records. Please try again.", "error");
            }
            console.error("AJAX Error: " + xhr.status + " - " + error);
        }
    });
}

// Populates the popup table with combined Date / Time
function populateSurgeryListTable(surgeries) {
    var tbody = $("#tblDoctorDeskSurgeryList tbody");
    tbody.empty();

    $.each(surgeries, function(i, item) {
        var dateTime = (item.SURDATE || '');
        if (item.SURFRM && item.SURFRM.trim() !== '') {
            dateTime += (dateTime ? ' / ' : '') + item.SURFRM.trim();
        }

        var row = '<tr>' +
            '<td style="text-align: center;">' +
            '<button type="button" class="btn btn-sm btn-primary" style="padding: 4px 8px; font-size: 12px; background:#3a6ea5; border-color:#3a6ea5;" title="Select Surgery" onclick="SelectSurgeryFromDoctorDesk(\'' + item.BOOKNO + '\')">' +
            '<i class="fa fa-pencil"></i>' +
            '</button>' +
            '</td>' +
            '<td style="text-align: center; white-space: nowrap;">' + dateTime + '</td>' +
            '<td style="text-align: center;">' + (item.SURGERY_DESC || '') + '</td>' +
            '<td style="text-align: center; font-weight: bold;">' + (item.BOOKNO || '') + '</td>' +
            '</tr>';
        tbody.append(row);
    });
}

// Selects surgery and loads it into the background iframe
function SelectSurgeryFromDoctorDesk(bookingNo) {
    $("#DivPatientSurgeryListModal").css("display", "none");
    var iframe = document.getElementById("iframeOTNotes");
    if (iframe) {
        var baseOtUrl = getOTUrl("/OT/OTNotesVersion");
        iframe.src = baseOtUrl + "&OTBookingNo=" + encodeURIComponent(bookingNo);
    }
}

// Opens the Surgery Details popup manually when clicking the header icon
function showSurgeryDetailsModal() {
    if (window.PatientSurgeriesList && window.PatientSurgeriesList.length > 0) {
        populateSurgeryListTable(window.PatientSurgeriesList);
        $("#DivPatientSurgeryListModal").css("display", "flex");
    } else {
        var ipno = sessionStorage.getItem('IPPatIPNO') || $("#HeaderSection_PatDetails_ipNo").text().trim() || '';
        var mrno = sessionStorage.getItem('IPPatMRNO') || $("#HeaderSection_PatDetails_MRNO").text().trim() || '';
        $.ajax({
            type: 'POST',
            url: '../SinglePage/GetPatientOTBookings',
            data: { ipno: ipno, mrno: mrno },
            dataType: 'json',
            success: function(response) {
                window.PatientSurgeriesList = response || [];
                if (response && response.length > 0) {
                    populateSurgeryListTable(response);
                    $("#DivPatientSurgeryListModal").css("display", "flex");
                } else {
                    if (typeof ToastMsg === "function") {
                        ToastMsg("No surgery records found for this patient.", "warning");
                    }
                }
            }
        });
    }
}

// Adds the surgery list button icon on the TOP RIGHT side next to the close button
function addSurgeryListHeaderIcon() {
    setTimeout(function() {
        if ($("#btnHeaderSurgeryListIcon").length === 0) {
            var iconBtn = '<button type="button" id="btnHeaderSurgeryListIcon" class="btn btn-sm" ' +
                'style="margin-left: auto; margin-right: 8px; background: rgba(255,255,255,0.25); border: 1px solid rgba(255,255,255,0.7); color: #fff; font-size: 11px; padding: 2px 9px; border-radius: 4px; cursor: pointer; display: inline-flex; align-items: center; gap: 5px;" ' +
                'title="View / Switch Surgery Details" onclick="showSurgeryDetailsModal()">' +
                '<i class="fa fa-list"></i> Surgeries' +
                '</button>';

            // Placed right before the '✕' close button on the top right
            $("#Hist_H_Close_OTNotes").before(iconBtn);
        }
            }, 150);
        }



//end
    </script>



    <div class="opd-main-container">
        <div id="HeaderSection_OPDPatInfo" class="patient-info-header">
            <% Html.RenderAction("PatientInfoIPD", "SinglePage"); %>
            <div id='loading-PatientInfo' class='loading-screen' style='display: none; opacity: 0;'></div>
        </div>


        <div class="scrollable-content-area" id="OPDContentMainDiv">

                     <div class="d-flex justify-content-between align-items-center mb-4 sticky-top bg-white pt-2 pb-2" style="z-index: 99;">
                <div class="nav-scroller">
                    
                   <a href="#sec-History" class="tab-btn active" id="IPD_HistoryTab">History</a>

<a href="#sec-exam" class="tab-btn" id="IPD_ExamTab">Examination</a>

<a href="#sec-Diagnosis" class="tab-btn" id="IPD_DiagnosisTab">Diagnosis</a>
<a href="#sec-ProgressNote" class="tab-btn" id="IPD_ProgressNoteTab">Progress Notes</a>
                    <a href="#sec-TreatmentOrder" class="tab-btn" id="IPD_TreatmentOrderTab">Treatment Order</a>
                    <a href="#sec-OTBookingRequest" class="tab-btn" id="OTBookingRequestSec">OT Booking Request</a>
                    <a href="#sec-ChemoPlanning" class="tab-btn d-none" id="sec-ChemoPlanning" onclick="openChemoPlanning('IPD')">Chemo Planning</a>
                    <a href="#sec-PAC" onclick="LoadPACHistory()" class="tab-btn d-none" id="IPD_PAC">PAC</a>
                    <a href="#sec-IntraOperativeNotes" class="tab-btn d-none" id="sec-IntraOperativeNotes" onclick="openIntraOperativeNotes()">Intra-Operative Notes</a>
                </div>
                <div>
                    <button class="btn btn-save-complete btn-sm" id="SinglePageOPD_CompltSave" onclick="IPDCommonSave('C');">Save</button>
                </div>
            </div>

           <% Html.RenderPartial("~/Views/SinglePage/HistoryExamIPD.ascx"); %>

<% Html.RenderAction("Diagnosis", "SinglePage"); %>

<% Html.RenderAction("ProgressNotes", "SinglePage"); %>

<% Html.RenderAction("TreatmentOrder", "SinglePage"); %>

<% Html.RenderAction("OTBookingRequest", "SinglePage"); %>

        </div>
    </div>

   <%-- added by aaryshree--%>
  
    <div id="chemoPlanningContainer" style="display: none;">
        <div id="chemoPlanningBody"></div>
    </div>

    <%-- Added by Roshan 20250812 => Dialog For CIMS Info --%>
    <div id="divCIMSInfo" style="display: none;">
        <div class="CIMS-container" style="height:90vh !important;">
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

    <div id="PACHistInfoModal" class="EModal" style="justify-content: center; align-items: center;">
        <div class="modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv ResultHeader">
                <label style="font-size: 20px;">PAC History List</label>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <button type="button" class="btn btn-success" style="padding: 2px 10px;" onclick="openNewPAC()">Add New PAC</button>
                    <span class="closeMdlBtn" onclick="ClosePop('PACHistInfoModal');">&times;</span>
                </div>
            </div>
            <div class="ModelContentDiv">
                <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                    <div class="Tablewrapper" style="font-size: 12px; background: white;">
                        <table class="tblpopupList" id="TblPACHistInfo">
                            <thead>
                                <tr>
                                    <th>Act</th>
                                    <th>PAC No.</th>
                                    <th>Ref. Doctor</th>
                                    <th>Surgery Advice Date</th>
                                    <th>Surgery Advice</th>
                                    <th>Nature of Surgery</th>
                                    <th>PAC Status</th>
                                    <th>PAC Status Date/Time</th>
                                    <th>PAC Done By</th>
                                </tr>
                            </thead>
                            <tbody id="TBodyPACHist">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
                <!-- Doctor Desk Small Surgery Selection Popup (floats on top of Intra-Operative Notes) -->
    <div id="DivPatientSurgeryListModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999999; justify-content: center; align-items: center;">
        <div style="background: #fff; border-radius: 6px; box-shadow: 0 0 25px rgba(0,0,0,0.5); width: 860px; max-width: 95%; border: 3px solid #3a6ea5; overflow: hidden; font-family: Verdana, Geneva, sans-serif;">
            <div style="background: #3a6ea5; color: #fff; font-weight: bold; padding: 10px 14px; display: flex; justify-content: space-between; align-items: center;">
                <span>Surgery Details</span>
                <span style="cursor: pointer; font-size: 20px; line-height: 1;" onclick="$('#DivPatientSurgeryListModal').css('display', 'none');">&times;</span>
            </div>
            <div style="padding: 15px; max-height: 400px; overflow-y: auto;">
                <table class="table table-bordered table-striped" id="tblDoctorDeskSurgeryList" style="margin-bottom: 0; font-size: 12px; width: 100%;">
                    <thead style="background-color:#3a6ea5; color: white;">
                        <tr>
                            <th style="text-align: center; width: 80px;">Action</th>
                            <th style="text-align: center; width: 190px;">Surgery Date / Time</th>
                            <th style="text-align: center;">Surgery Name</th>
                            <th style="text-align: center; width: 140px;">OT Booking No</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Surgery Advice Selection Modal for IPD PAC -->
    <div id="SurgAdvPopup" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,.5); z-index: 999999; align-items: center; justify-content: center;">
        <div class="bg-white rounded shadow" style="width: 80vw; max-width: 900px; max-height: 85vh; overflow: auto; border-radius: 6px;">
            <div class="d-flex justify-content-between p-2" style="background: #022548; color: #fff; align-items: center;">
                <b style="font-size: 15px;">Surgery Advice List</b>
                <span style="cursor: pointer; font-size: 20px; line-height: 1;" onclick="CloseSurgAdvPopup()">&times;</span>
            </div>
            <table class="table table-sm table-bordered mb-0 text-center" style="font-size: 13px;">
                <thead class="bg-light">
                    <tr>
                        <th style="width: 60px; text-align: center;">Action</th>
                        <th style="width: 140px; text-align: center;">Surgery Advice Date</th>
                        <th style="text-align: center;">Surgery Advice</th>
                        <th style="width: 150px; text-align: center;">Doctor</th>
                        <th style="width: 140px; text-align: center;">Nature of Surgery</th>
                    </tr>
                </thead>
                <tbody id="SurgAdvPopupBody"></tbody>
            </table>
            <div class="text-center p-2">
                <button type="button" class="btn btn-success" style="padding: 4px 20px;" onclick="ContinueSurgAdv()">Continue</button>
            </div>
        </div>
    </div>


</asp:Content>
