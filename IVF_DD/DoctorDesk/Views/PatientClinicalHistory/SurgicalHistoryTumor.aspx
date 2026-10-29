<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0" />
    <title>Patient History</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="~/js/fancybox/jquery.fancybox2.0.5.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/braviStyle.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/style.css" rel="stylesheet" type="text/css" />
    <link href="~/js/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/jquery.multiselect.css" rel="stylesheet" />
    <link href="~/Content/Jquery-ui-Custom.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/select2-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/calenderextra.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/font-awesome.min.css" rel="stylesheet" />
    <link href="~/plugins/Freez/jquery.stickytable.min.css" rel="stylesheet" />
    <link href="~/bootstrap/css/bootstrap.css" rel="stylesheet" />
  <link href="<%=ResolveUrl("~/dist/css/AdminLTE.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/bootstrap/js/bootstrap.min.js")%>" rel="script" />
   
</head>
<body>
    <script src="<%=ResolveUrl("~/js/jquery-1-10-2.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/jquery-1-11-1-ui.js")%>"></script>
    <script src="<%=ResolveUrl("~/Scripts/GeneralJs.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/i18n/grid.locale-en.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.jqGrid.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/select2.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/maskedinput.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/loading.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/fancybox/jquery.fancybox.pack2-0-5.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.inputmask.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.inputmask.custom.extensions.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.inputmask.date.extensions.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.inputmask.extensions.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.inputmask.numeric.extensions.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/timejs/jquery.plugin.js")%>"></script>
    <script src="<%=ResolveUrl("~/js/timejs/jquery.timeentry.js")%>"></script>
    <script src="<%=ResolveUrl("~/Scripts/Validation.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/Freez/jquery.stickytable.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/Freez/jquery.stickytable.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/plugins/chartjs/chart.min.js")%>"></script>
    <script src="<%=ResolveUrl("~/bootstrap/js/bootstrap.min.js")%>"></script>
    <%--<script src="../plugins/chartjs/chart.min.js"></script>--%>
    <%--<script src="../plugins/Freez/jquery.stickytable.min.js"></script>--%>
<style>
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
    /* 🌿 Base grid */
    .ui-jqgrid {
        width: 100% !important;
        border: 1px solid #d9d9d9;
        background-color: #ffffff;
        font-family: "Segoe UI", Arial, sans-serif;
        font-size: 13px;
        color: #333;
        border-radius: 6px;
    }

    /* 🧾 Header — light gray background, no blue */
    .ui-jqgrid .ui-jqgrid-htable th {
        background: #f7f7f7;           /* very light gray */
        color: #333;
        font-weight: 600;
        text-align: center;
        border-right: 1px solid #e0e0e0;
        height: 30px;
    }

    /* Slight darker gray on hover */
    .ui-jqgrid .ui-jqgrid-htable th:hover {
        background-color: #efefef;
    }

    /* 🩶 Data rows */
    .ui-jqgrid tr.jqgrow td {
        background-color: #fff;
        border-color: #eee;
        padding: 6px 8px;
        text-align: center;
    }

    /* Alternate row shading */
    .ui-jqgrid .ui-widget-content .jqgrow:nth-child(even) {
        background-color: #fafafa;
    }

    /* Row hover effect */
    .ui-jqgrid .ui-widget-content .jqgrow:hover {
        background-color: #f4f4f4;
    }

    /* 📋 Pager */
    .ui-jqgrid .ui-pg-table {
        background-color: #f9f9f9;
        border-top: 1px solid #ddd;
        font-size: 12px;
    }

    /* 🔗 Links (light gray-blue tone) */
 
    /* Remove harsh borders */
    .ui-jqgrid .ui-jqgrid-view {
        border-radius: 6px;
        overflow: hidden;
    }

    /* Make caption light gray and subtle */
    .ui-jqgrid-titlebar {
        background: #f5f5f5;
        border-bottom: 1px solid #ddd;
        font-weight: 600;
        color: #333;
        padding: 4px 8px;
    }

    /* Remove blue focus outline */
    .ui-state-highlight,
    .ui-widget-content .ui-state-highlight,
    .ui-widget-header .ui-state-highlight {
        background: #e9e9e9 !important;
        color: #333 !important;
        border: 1px solid #ccc !important;
    }
</style>

     <style type="text/css">
        legend {
            background-color: #ffffff;
            padding: 2px;
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

    <style>
        .surgery-card {
            border: 1px solid #ccc;
            font-family: Arial, sans-serif;
            margin: 10px 0;
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
            padding: 10px;
            font-size: 14px;
        }

        .surgery-SurgeryName-info-box {
            background-color: #e6f0fa;
            border-left: 4px solid #507eb3;
            padding: 10px 12px;
            border-radius: 6px;
            margin: 10px 0;
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
            border: 1px solid #ccc;
            border-radius: 3px;
            padding: 4px;
            margin-top: 5px;
        }


        /*//adde new record*/
        .add-surgery-form {
            background: #f9f9f9;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 16px;
        }

        .form-row {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 8px;
        }

        .form-group {
            flex: 1;
            min-width: 180px;
            display: flex;
            flex-direction: column;
            margin-bottom: 8px;
        }

            .form-group label {
                font-weight: 600;
                font-size: 13px;
                margin-bottom: 4px;
            }

        .input-field {
            padding: 6px 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 13px;
            height: 32px;
        }

        textarea.input-field {
            height: auto;
            resize: vertical;
        }

        .btn-add {
            padding: 6px 14px;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            margin-top: 4px;
        }

            .btn-add:hover {
                background-color: #007bff;
            }

        .custom-modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            z-index: 999;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .custom-modal-box {
            background-color: white;
            padding: 20px;
            border-radius: 6px;
            width: 500px;
            position: relative;
        }

        .close-modal {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 20px;
            cursor: pointer;
            color: #aaa;
        }

            .close-modal:hover {
                color: black;
            }

        .form-group {
            margin-bottom: 12px;
        }

        .input-field {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

            .form-row .form-group {
                flex: 1;
            }

        #btnSaveSurgery {
            margin-left: 35%;
        }

        #txtNotes {
            width: 100%;
        }

        legend {
            color: #fff;
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

        .btn-Tabs {
            background: #e6f0fa;
            color: #333;
            border: 1px solid #ccc;
            padding: 10px 18px;
            border-radius: 6px 6px 0 0;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

            .btn-Tabs:hover {
                background: #d6d6d6;
            }

            .btn-Tabs.active {
                background: #507eb3;
                color: white;
                border-bottom: none;
                position: relative;
                top: 2px;
                z-index: 2;
            }
    </style>

    <script>
        var PATMRNO = '<%=ViewBag.PATMRNO%>';
        var PatName = '<%=ViewBag.PatName%>';
        var Gender = '<%=ViewBag.Gender%>';
        var Age = '<%=ViewBag.Age%>';
        var Type = '<%=ViewBag.Type %>';
        var message = '<%=ViewBag.Message %>';
        let surgeryDataList = [];
        var ExternalUrl = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ExternalUrl")%>';
        var SetExternalUrl = '<%:OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("SetExternalurl")%>';
        var ExternalBaseUrl = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ExternalBaseUrl")%>';
        var GUnitCode = '<%=ViewBag.UNITCODE%>';
        //var SetExternalUrl = "Y";

        $(document).ready(function () {
         

            $("#txtSurgeryDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });
            //if (Type != "I" || Type == "") {
            //    $('#iframeHeader').show();
            //    document.getElementById('PrevHistFrameLbl').innerText = PatName + " - " + Gender + " - " + Age + " - " + PATMRNO;
            //}
            if (Type == "E") {
                $('#divRecommendations').show();
                GetDoctorsRemark(PATMRNO, "S");
                $("#TabRemark").show();
            }
            else {
                $('#divRecommendations').hide();
                $("#TabRemark").hide();
            }
            if (message && $.trim(message) !== '') {

                // Hide all page content
                $('body').children().hide();

                // Show message full screen
                $('body').append(
                    '<div id="divMessage" ' +
                    'style="display:flex; justify-content:center; align-items:center; ' +
                    'height:100vh; font-size:18px; font-weight:bold; color:#b94a48; ' +
                    'text-align:center; background-color:#f8f9fa;">' +
                    message +
                    '</div>'
                );
            }

            $('#PalHist').hide();
            $('#txtSurgeryDate').datepicker('setDate', 'today');
            var mrno = '<%=ViewBag.PATMRNO%>';
            GetBindingData(mrno);
            $("#divSurgInfo").show();
            GetBindingData(mrno);
            $("#TabSurg").click(function () {
                $(".tab-panel").hide();
                $("#divSurgInfo").show();
                $("#divDignosisInfo").hide();
                $("#divRemarkInfo").hide();
                $("#btnAddRecord").css("visibility", "visible");
                GetBindingData('<%=ViewBag.PATMRNO%>');
            });
            $("#TabChemo").click(function () {
                $(".tab-panel").hide();
                $('#PalHist').hide();
                $("#divChemoInfo").show();
                $("#divDignosisInfo").hide();
                $("#divRemarkInfo").hide();
                $("#btnAddRecord").css("visibility", "hidden");
                PatMedicationHistory();
            });
            $("#TABHistory").click(function () {
                $(".tab-panel").hide();
                $('#PalHist').hide();
                $("#divHistoryInfo").show();
                $("#divDignosisInfo").hide();
                $("#divRemarkInfo").hide();
                $("#btnAddRecord").css("visibility", "hidden");
                PatHistory();
            });
            $("#TABInvestigation").click(function () {
                $(".tab-panel").hide();
                $('#PalHist').hide();;
                $("#divInvestigationInfo").show();
                $('li').removeClass('active'); // remove from all
                $('li:has(#Investigation)').addClass('active');
                $('.Investigation').trigger('click');
                $("#RadDept").hide();
                $("#divDignosisInfo").hide();
                $("#divRemarkInfo").hide();
                $('#divDates').hide();
                $("#btnAddRecord").css("visibility", "hidden");
                loadInvestigationReport('<%=ViewBag.PATMRNO%>');

            });
            $("#TabDiagnosis").click(function () {

                $(".tab-panel").hide();
                $('#PalHist').hide();
                $("#divInvestigationInfo").hide();
                $("#divDignosisInfo").show();
                $("#divRemarkInfo").hide();
                $("#RadDept").hide();
                $('#divDates').hide();
                $("#btnAddRecord").css("visibility", "hidden");
                GetICDDiagnosis('<%=ViewBag.PATMRNO%>');
                GetICDDOiagnosis('<%=ViewBag.PATMRNO%>');
            });
            $("#TabRemark").click(function () {

                $(".tab-panel").hide();
                $('#PalHist').hide();
                $("#divInvestigationInfo").hide();
                $("#divDignosisInfo").hide();
                $("#divRemarkInfo").hide();
                $("#RadDept").hide();
                $('#divDates').hide();
                $("#btnAddRecord").css("visibility", "hidden");
                GetDoctorsRemark(PATMRNO, "L");
            });

            $("#TabRadiation").click(function () {
                $(".tab-panel").hide();
                $('#PalHist').hide();
                $("#divRemarkInfo").hide();
                $("#divDignosisInfo").hide();
                $("#btnAddRecord").css("visibility", "hidden");
                $("#divRadiationInfo").show();
                GetRadtionReports('<%=ViewBag.PATMRNO%>');
            });
            $("#TabPAC").click(function () {
                $(".tab-panel").hide();
                $('#PalHist').hide();
                $("#divDignosisInfo").hide();
                $("#divRemarkInfo").hide();
                GetPACHistoryLst();
                $("#btnAddRecord").css("visibility", "hidden");
                $("#divPACInfo").show();
            });
            $("#TABClinical").click(function () {
                $(".tab-panel").hide();
                $('#PalHist').hide();
                $("#divDignosisInfo").hide();
                $("#divRemarkInfo").hide();
                $("#btnAddRecord").css("visibility", "hidden");
                $("#divHistInfo").show();
                openMedIframe();
            });
            //$("#TABPalliaitve").click(function () {
            //    $(".tab-panel").hide();
            //    $("#btnAddRecord").css("visibility", "hidden"); 
            //    $("#divHistInfo").empty();
            //    $("#divHistInfo").show();
            //    $("#divHistInfo").html(
            //         "<div style='font-size:20px; text-align:center; font-weight:bold; color:#555;'>Please select the date</div>"
            //     );
            //    $('#PalHist').show();
            //    GetPreviousRecordsDate();
            //    //openPallIframe();
            //});
            $(".btn-Tabs").click(function () {
                $(".btn-Tabs").removeClass("active");
                $(this).addClass("active");
            });
        });
        $(window).on("load", function () {
            var newWidth = $("#ContentDiv").width();
            $("#gvTest").jqGrid("setGridWidth", newWidth - 10, false);
            $("#gvTest").jqGrid("setGridHeight", $("#ContentDiv").height() - 225, true);
        }); 
        function GetICDDOiagnosis(Mrno) {
            var DataToSend = {
                MrNo: Mrno
            }
            $.ajax({
               
                url: GetApiUrl("DoctorDesk", "GetICDOHistoList") ,
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    ICDDiagnosis = "";
                    if (data.length > 0) {
                        //if (data[0] != null) {
                        //    //$.grep(data[1], function (a) {
                        //    //    ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                        //    //});
                        //    BindICDDiagnosisTable(data[0]);
                        //}
                        if (data[0] != null) {
                            //$.grep(data[0], function (a) {
                            //    ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                            //});
                            BindICDODiagnosisTable((data[0] != null ? data[0] : []), (data[1] != null ? data[1] : []));
                        }
                    }
                },
                complete: function () {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });

        } 
        function GetICDDiagnosis(Mrno) {
            var DataToSend = {
                MrNo: Mrno
            }
            $.ajax({
                url:  GetApiUrl("PatientClinicalHistory", "GetPatDiagVitalHistory"),    
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    ICDDiagnosis = "";
                    if (data.length > 0) {
                        if (data[0] != null) {
                            //$.grep(data[1], function (a) {
                            //    ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                            //});
                            BindICDDiagnosisTable(data[0]);
                        }
                        //if (data[0] != null) {
                        //    $.grep(data[0], function (a) {
                        //        ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                        //    });
                        //    BindICDODiagnosisTable((data[0] != null ? data[0] : []), (data[1] != null ? data[1] : []));
                        //}
                    }
                },
                complete: function () {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });

        }
        function BindICDDiagnosisTable(Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDTBody").empty();
            $.grep(Lst, function (a) {
                var Code = a.CODE;
                var Desc = a.DIAGNAME;
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                var RplTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd);
                $("#TableICDTBody").append(RplTr);
            });
        }

        function BindRemarksTable(Lst) {
            $("#TableRemarkBody").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDTBody").empty();
            $.grep(Lst, function (a) {
                var Code = a.CODE;
                var Desc = a.NAME;
                var Remark = a.DRREMARKS
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                var RemarkTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Remark);
                var RplTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd + RemarkTd);
                $("#TableRemarkBody").append(RplTr);
            });
        }
        function GetRadtionReports(Mrno) {
            var DataToSend = {
                Mrno: Mrno
            }
            $.ajax({
                url:   GetApiUrl("DoctorDesk", "GetFractionsStatus") ,
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    ICDDiagnosis = "";
                    if (data.length > 0) {
                        if (data[0] != null) {
                            BindRtTrackerTable(data[0]);
                        }
                    }
                },
                complete: function () {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });

        }

        function GetTBUrl(action) {
           
            if (SetExternalUrl == "Y") {
                return ExternalUrl + "/DoctorDesk/" + action;
            } else {
                return "../TumorBoard/" + action;
            }
        }
        function BindRtTrackerTable(Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            $("#TableRTTracker").empty();
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            let arr = [];
            arr.push(Lst);
            $.grep(arr, function (a) {
                var Code = a.MRNO;
                var RT = a.RTNO;
                var Desc = a.PATNAME;
                var Consultant = a.CONSULTANT;
                var Treatment = a.TREATMENT;
                var Dose = a.TOTALDOSE;
                var totalFrac = a.TOTALFR;
                var CompleteFrac = a.COMPLETEDFR;
                var PendingFrac = a.PENDINGFR;
                var StartDate = a.STARTDATE;

                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var RtTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", RT);
                var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                var ConsultantTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Consultant);
                var TreatmentTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Treatment);
                var DoseTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Dose);
                var totalFracTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", totalFrac);
                var CompleteFracTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", CompleteFrac);
                var PendingFracTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", PendingFrac);
                var StartDateTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", StartDate);
                var RplTr = Tr.replace("{TRCONTENT}", CodeTd + RtTd + DescTd + ConsultantTd + TreatmentTd + DoseTd + StartDateTd + totalFracTd + CompleteFracTd + PendingFracTd);
                $("#TableRTTracker").append(RplTr);
            });
        }
        function GetDoctorsRemark(Mrno, type) {
            const DataToSend = {
                MrNo: Mrno,
                type: type
            }
            $.ajax({
                url: '../TumorBoard/GetExternalDoctorRemark',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    if (type == "L") {
                        if (data.length > 0) {
                            if (data != null) {
                                $("#divRemarkInfo").show();
                                BindRemarksTable(data);
                            }
                        }
                    }
                    else {
                        if (data.length > 0) {
                            if (data[0]['DRREMARKS'] != "") {
                                $('#txtRecommendations').val(data[0]['DRREMARKS']);
                                $('#txtRecommendations').prop('disabled', true);
                                $('#btnSaveRecommendations').hide();
                                $('#btnEditRecommendations').show();
                            }
                            else {
                                $('#txtRecommendations').prop('disabled', false);
                                $('#btnSaveRecommendations').show();
                                $('#btnEditRecommendations').hide();
                            }
                        }
                    }
                },
                complete: function () {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });

        }
        //Bind ICD-O Diagnosis Table
        function BindICDODiagnosisTable(TopoLst, Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDOTBody").empty();
            $.each(Lst, function (_, item) {
                var matchedTopo = TopoLst.find(function (t) {
                    return t.TOPOCODE === item.TOPOCODE;
                });
                if (matchedTopo) {
                    var Code = item.TOPOCODE + item.HCODE + " " + item.HGRADE;
                    var Desc = item.TOPODESC + ", " + item.HDESC + ", " + item.GRADENAME;
                    var TNM = matchedTopo.TNMPREFIX + matchedTopo.T + matchedTopo.N + matchedTopo.M;
                    var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                    var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                    var TNMTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", TNM || '-');
                    var StageTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", matchedTopo.STAGE || '-');
                    var FinalTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd + TNMTd + StageTd);
                    $("#TableICDOTBody").append(FinalTr);
                }
            });
        }

        function openPallIframe(Tranno) {
            $("#divHistInfo").empty();
            if (!Tranno || Tranno === "---Select---") {
                $("#divHistInfo").html(
                    "<div style='font-size:20px; text-align:center; font-weight:bold; color:#555;'>Please select the date</div>"
                );
                return;
            }
            var PcNo = "";
            var RegDate = "";
            var IpNo = "";
            var MRNo = '<%=ViewBag.PATMRNO%>';
            var DrStatus = "";
            var Master = "true";
            const iframe = document.createElement("iframe");
            iframe.id = "myMedIframe";
            iframe.src = GetApiUrl("TumorBoard", "CallPalliativeCareList") + "?Act=D" + "&Id=" + PcNo + '&var_date=' + RegDate + '&var_TranNo=' + Tranno + '&var_Ipno=' + IpNo + '&var_Mrno=' + MRNo + '&var_DrStatus=' + DrStatus + '&Master=' + Master;
            ajaxindicatorstart('Processing....');
            iframe.style.width = "100%";
            iframe.style.height = "90vh";
            iframe.style.border = "none";
            iframe.onload = function () {
                $('#txtTranno').val();
                $('#MenuDiv').hide();
                ajaxindicatorstop();
            };
            document.getElementById("divHistInfo").appendChild(iframe);
        }

        function openMedIframe() {
            $("#divHistInfo").empty();
            var MRNo = '<%=ViewBag.PATMRNO%>';
            const iframe = document.createElement("iframe");
            iframe.id = "myMedIframe";
            iframe.src = GetApiUrl("PatientClinicalHistory", "MedicationHistory") + "?PatMrno=" + MRNo + '&PatName=' + PatName + '&Gender=' + Gender + '&Age=' + Age;
            iframe.style.width = "100%";
            iframe.style.height = "90vh";
            iframe.style.border = "none";
            iframe.onload = function () {
                $('#txtTranno').val();
            };
            document.getElementById("divHistInfo").appendChild(iframe);
        }

        function cleardata() {
            $("#txtUniqueID").val('');
            $("#txtDoctorName").val('');
            $("#txtSurgeryDate").val('');
            $("#txtSurgeryName").val('');
            $("#txtNotes").val('');
            $('#txtSurgeryDate').datepicker('setDate', 'today');
        }

        function GetBindingData(strMrNo) {
            $.ajax({
                type: "get",
                datatype: "json",
                url:   GetApiUrl("DoctorDesk", "GetSurgicalHistoryData"),   
                data: { strMrNo: strMrNo },
                success: function (response) {

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
                complete: function () { },
                error: function (XMLHttpRequest, textStatus, errorThrown) { }
            });
        }
        //function BindData(dataList) {
        //    var html = "";

        //    $.each(dataList, function (index, surgery) {
        //        var rawNotes = surgery.SurgeryNotes || '';
        //        var decodedNotes = decodeURIComponent(rawNotes).replace(/<[^>]*>/g, '');
        //        html += '<div class="surgery-card">';
        //        var headerStyle = (surgery.UniqueId == "0")
        //            ? ' style="background-color: #28666e;"'
        //            : '';
        //        var DateStyle = (surgery.UniqueId != "0")
        //            ? ' style="margin-left:-115px"'
        //            : '';
        //        html += '<div class="surgery-card-header"' + headerStyle + '>';
        //        html += '<div><strong>Doctor :</strong> ' + surgery.SurgeonDoctorName + '</div>';
        //        html += '<div' + DateStyle + '><strong>Date :</strong> ' + surgery.SurgeryDate + '</div>';
        //        html += '<div style="display:none"><strong>UniqueId:</strong> ' + surgery.UniqueId + '</div>';
        //        if (surgery.UniqueId != "0") {
        //            html += '<div style="cursor:pointer;" onclick="editSurgeryRecord(' + index + ')">';
        //            html += '<span title="Edit">&#9998;</span>';
        //            html += '</div>';
        //        }
        //        else {
        //            html += '<div><strong>Inhouse Surgery Done</strong></div>';
        //        }

        //        html += '</div>';
        //        html += '<div class="surgery-card-body">';
        //        html += '<div class="surgery-SurgeryName-info-box"><strong>Surgery Name : </strong> ' + surgery.SurgeryName + '</div>';
        //        html += '<div><label><strong>Notes: </strong></label><br>';
        //        html += '<textarea class="notes-textarea auto-expand" rows="3" readonly>' + decodedNotes + '</textarea></div>';
        //        html += '</div>';
        //        html += '</div>';
        //    });
        //     else {
        //        html = `<div style="font-size:20px; text-align:center; font-weight:bold; color:#555;">No History Found for this record</div>`;
        //    }
        //    $("#surgeryInfoContainer").html(html);
        //}

        function BindData(dataList) {
            var html = "";

            // CHECK: Does data exist and is the length greater than 0?
            if (dataList && Array.isArray(dataList) && dataList.length > 0) {

                $.each(dataList, function (index, surgery) {
                    var rawNotes = surgery.SurgeryNotes || '';
                    var decodedNotes = decodeURIComponent(rawNotes).replace(/<[^>]*>/g, '');

                    html += '<div class="surgery-card">';

                    var headerStyle = (surgery.UniqueId == "0")
                        ? ' style="background-color: #28666e;"'
                        : '';

                    var DateStyle = (surgery.UniqueId != "0")
                        ? ' style="margin-left:-115px"'
                        : '';

                    html += '<div class="surgery-card-header"' + headerStyle + '>';
                    html += '<div><strong>Doctor :</strong> ' + (surgery.SurgeonDoctorName || '') + '</div>';
                    html += '<div' + DateStyle + '><strong>Date :</strong> ' + (surgery.SurgeryDate || '') + '</div>';
                    html += '<div style="display:none"><strong>UniqueId:</strong> ' + surgery.UniqueId + '</div>';

                    if (surgery.UniqueId != "0") {
                        html += '<div style="cursor:pointer;" onclick="editSurgeryRecord(' + index + ')">';
                        html += '<span title="Edit">&#9998;</span>';
                        html += '</div>';
                    } else {
                        html += '<div><strong>Inhouse Surgery Done</strong></div>';
                    }

                    html += '</div>'; // End Header

                    html += '<div class="surgery-card-body">';
                    html += '<div class="surgery-SurgeryName-info-box"><strong>Surgery Name : </strong> ' + (surgery.SurgeryName || '') + '</div>';
                    html += '<div><label><strong>Notes: </strong></label><br>';
                    html += '<textarea class="notes-textarea auto-expand" rows="3" readonly>' + decodedNotes + '</textarea></div>';
                    html += '</div>'; // End Body
                    html += '</div>'; // End Card
                });

            } else {
                // ELSE: If dataList is empty, show this HTML
                html = `<div style="font-size:20px; text-align:center; font-weight:bold; color:#555; padding: 20px;">No History Found for this record</div>`;
            }

            $("#surgeryInfoContainer").html(html);
        }
        var editIndex = -1;
        function editSurgeryRecord(index) {
            $('#surgeryModal').fadeIn();
            const item = surgeryDataList[index];
            if (!item) return;
            $("#txtUniqueID").val(item.UniqueId);
            $("#txtDoctorName").val(item.SurgeonDoctorName);
            $("#txtSurgeryDate").val(item.SurgeryDate);
            $("#txtSurgeryName").val(item.SurgeryName);
            $("#txtNotes").val(decodeURIComponent(item.SurgeryNotes || ''));
            editIndex = index;
            $("#btnSaveSurgery").hide();
            $("#btnUpdateSurgery").show();
        }

        function autoResizeTextareas() {
            $(".auto-expand").each(function () {
                this.style.height = 'auto';
                this.style.height = Math.max(this.scrollHeight, 100) + 'px';
            });
        }

        function PatMedicationHistory() {
            var mrno = '<%=ViewBag.PATMRNO%>'; 
            $("#chemoInfoContainer").empty();

            $.ajax({
                type: "POST",
                url: GetApiUrl("DoctorDesk", "GetchemoHistory"),

                datatype: "json",
                data: { strMrNo: mrno },
                success: function (result) {
                    BindChemoData(result);
                },
                complete: function () { },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                }
            });
        }

        function BindChemoData(dataList) {
            var html = "";
            var result = dataList.data;
            var resultTbl = Array.isArray(dataList.data1) && dataList.data1.length > 0 ? dataList.data1 : [];

            if (Array.isArray(result) && result.length > 0) {
                var totalCycle = result.find(x => x.TOTALCYCLE && x.TOTALCYCLE.trim() !== "")?.TOTALCYCLE;
                var currentCycle = result.filter(x => x.CYCLENO && x.CYCLENO.trim() !== "").length;
                var pendingCycle = totalCycle - currentCycle;

                html += `
                    <div style='background-color: #28666e; color: white; padding: 10px; font-weight: bold; font-size: 14px; border-radius: 6px; margin-bottom: 10px; display: flex; justify-content: space-between;'>
                        <span>✅ Total Cycle(s): ${totalCycle}</span>
                        <span>✔️ Complete Cycle(s): ${currentCycle}</span>
                        <span>⏳ Pending Cycle(s): ${pendingCycle}</span>
                    </div>
                `;

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
                    html += `<div class="chemo-card" style="border:1px solid #ccc; border-radius:6px; margin-bottom:10px; overflow:hidden;">`;
                    html += `<div class="chemo-card-header" style="background-color:#28666e; color:white; padding:6px 10px; font-weight:bold; font-size:14px; display:flex; justify-content:space-between;">`;
                    if (item.CYCLENO && item.CYCLENO.trim() !== "") {
                        html += `<span style="color:#b9ffb1; font-size:1.2em;"><i class="fa fa-check"></i></span>
                                 <span>Plan No : ${item.PLANID} (IP VISIT)</span>
                                 <span>Date: ${formatDate(item.TRANDATE)} &nbsp;&nbsp; CycleNo : ${item.CYCLENO}</span>`;
                    } else {
                        html += `<span style="color:#b9ffb1; font-size:1.2em;"><i class="fa fa-check"></i></span>
                                 <span>Plan No : ${item.PLANID} (OP VISIT)</span>
                                 <span>Date: ${formatDate(item.TRANDATE)}</span>`;
                    }
                    html += `</div>`; // header
                    html += `<div class="chemo-card-body" style="background:#fff; padding:10px 15px; font-size:14px;">`;
                    if (item.CYCLENO && item.CYCLENO.trim() !== "") {
                        html += `<div class="surgery-SurgeryName-info-box">
                        Day: ${item.DAY} &nbsp;&nbsp; Start Date: ${formatDate(item.STARTDATE)} &nbsp;&nbsp; End Date: ${formatDate(item.ENDDATE)}
                        </div>
                        <div style="margin-bottom:10px;"><b>Chemotherapy Name:</b> ${item.NAME}</div>
                        <div><b>Protocol:</b><br>
                           <div style='border: 1px solid #ccc; padding: 10px; background-color: #f9f9f9; font-size: 13px; line-height: 1.6; white-space: pre-wrap; display:${DisplayProtocolTxt}'>
                               ${item.PROTOCOL}
                        </div>
                        <div id="${PContentTblId}" style="overflow-x: auto; padding: 0; display:${DisplayProtocolTbl}">
                            <table id="${PTableId}" class="table table-bordered" style="width:auto; min-width: fit-content; white-space: nowrap;"></table>
                        </div>
                     </div>`;
                    } else {
                        html += `<div><b>Modification During Treatment:</b><br>
                                    <div style="border:1px solid #ccc; padding:10px; background-color:#f9f9f9; font-size:13px; line-height:1.6; white-space:pre-wrap;">
                                        ${item.MODIFYMEDS}
                        </div>
                     </div>`;
                    }
                    html += `</div></div>`;
                    if (PTableId !== "") {
                        setTimeout(function () {
                            HistShowPlanCompleteLst(PTableId, PContentTblId);
                            $('#' + PTableId).jqGrid('setGridParam', {
                                data: FilterData
                            }).trigger("reloadGrid");
                        }, 50);
                    }
                });
            } else {
                html = `<div style="font-size:20px; text-align:center; font-weight:bold; color:#555;">No History Found for this record</div>`;
            }

            $("#chemoInfoContainer").html(html);
        }
        
        function PatHistory() {
            $('#tbldiv').empty();
            var mrNo = '<%=ViewBag.PATMRNO%>';

            $.ajax({
                type: "POST",
                url: GetApiUrl("DoctorDesk", "GetHistory"),
                datatype: "json",
                data: { strMrNo: mrNo },
                success: function (result) {

                    var hasHistory = false; // ✅ ADD THIS LINE

                    strPrintData = [];
                    var name = PatName;

                    var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
                    var gRelation = {
                        '01': 'Father', '02': 'Mother', '03': 'Wife',
                        '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
                        '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle',
                        '10': 'Paternal Uncle', '11': 'Paternal Aunt'
                    };

                    if (result != "") {

                        /* ================= FAMILY HISTORY ================= */
                        if (result.jsonFamily != "" || result.jsonFreeFamily != "") {
                            hasHistory = true; // ✅ ADD
                            strPrintData = [];
                            var tempData = "<div class='panel'><div style='text-align:center;font-size:14px;background:#24417c;color:white;padding:8px;'>Family History</div><div class='panel-body divBody'>";

                            if (result.jsonFamily != "") {
                                tempData += "<ul>";
                                for (var i = 0; i < result.jsonFamily.length; i++) {
                                    var dur = (result.jsonFamily[i].DURATION != "0"
                                        ? " since " + result.jsonFamily[i].DURATION + " " + gDurType[result.jsonFamily[i].DURTYPE] + "(s)" : "");
                                    tempData += "<li>" + gRelation[result.jsonFamily[i].RELATION] +
                                        " (" + result.jsonFamily[i].AGE + "yrs), suffering with <b>" +
                                        result.jsonFamily[i].DISEASES + "</b>" + dur + "</li>";
                                }
                                tempData += "</ul>";
                            }

                            if (result.jsonFreeFamily != "") {
                                tempData += "<table class='tblFree' style='width:90%;margin-left:22px;'>";
                                for (var i = 0; i < result.jsonFreeFamily.length; i++) {
                                    tempData += "<tr><td>" + result.jsonFreeFamily[i].TRANDATE +
                                        "</td><td>" + result.jsonFreeFamily[i].FAMHIST + "</td></tr>";
                                }
                                tempData += "</table>";
                            }

                            tempData += "</div></div>";
                            document.getElementById("tbldiv").innerHTML += tempData;
                        }

                        /* ================= PERSONAL HISTORY ================= */
                        if (result.jsonPersonal != "" || result.jsonFreePersonal != "") {
                            hasHistory = true; // ✅ ADD
                            strPrintData = [];
                            var tempData = "<div class='panel'><div style='text-align:center;font-size:14px;background:#24417c;color:white;padding:8px;'>Personal History</div><div class='panel-body divBody'>";

                            if (result.jsonPersonal != "") {
                                tempData += "<ul>";
                                for (var i = 0; i < result.jsonPersonal.length; i++) {
                                    tempData += "<li><b>" + result.jsonPersonal[i].NAME + "</b></li>";
                                }
                                tempData += "</ul>";
                            }

                            if (result.jsonFreePersonal != "") {
                                tempData += "<table class='tblFree' style='width:90%;margin-left:22px;'>";
                                for (var i = 0; i < result.jsonFreePersonal.length; i++) {
                                    tempData += "<tr><td>" + result.jsonFreePersonal[i].TRANDATE +
                                        "</td><td>" + result.jsonFreePersonal[i].PERSHIST + "</td></tr>";
                                }
                                tempData += "</table>";
                            }

                            tempData += "</div></div>";
                            document.getElementById("tbldiv").innerHTML += tempData;
                        }

                        /* ================= MEDICAL HISTORY ================= */
                        if (result.jsonMedical != "" || result.jsonFreeMedical != "") {
                            hasHistory = true; // ✅ ADD
                            strPrintData = [];
                            var tempData = "<div class='panel'><div style='text-align:center;font-size:14px;background:#24417c;color:white;padding:8px;'>Medical History</div><div class='panel-body divBody'>";

                            if (result.jsonMedical != "") {
                                tempData += "<ul>";
                                for (var i = 0; i < result.jsonMedical.length; i++) {
                                    tempData += "<li>Suffering with <b>" + result.jsonMedical[i].NAME + "</b></li>";
                                }
                                tempData += "</ul>";
                            }

                            if (result.jsonFreeMedical != "") {
                                tempData += "<table class='tblFree' style='width:90%;margin-left:22px;'>";
                                for (var i = 0; i < result.jsonFreeMedical.length; i++) {
                                    tempData += "<tr><td>" + result.jsonFreeMedical[i].TRANDATE +
                                        "</td><td>" + result.jsonFreeMedical[i].MEDHIST + "</td></tr>";
                                }
                                tempData += "</table>";
                            }

                            tempData += "</div></div>";
                            document.getElementById("tbldiv").innerHTML += tempData;
                        }

                        /* ================= ALLERGY ================= */
                        if (result.jsonAllergy != "") {
                            hasHistory = true; // ✅ ADD
                            strPrintData = [];
                            var tempData = "<div class='panel'><div style='text-align:center;font-size:14px;background:#24417c;color:white;padding:8px;'>Allergy</div><div class='panel-body divBody'><ul>";

                            for (var i = 0; i < result.jsonAllergy.length; i++) {
                                  //tempData += "<li>Allergy - <b>" + result.jsonAllergy[i].NAME + "</b></li>";
    // Added By Abhishesh || 20260414
    var dur = "";

    if (result.jsonAllergy[i].DURATION != "0" && result.jsonAllergy[i].DURATION != null) {
        dur = " since " +
            result.jsonAllergy[i].DURATION + " " +
            gDurType[result.jsonAllergy[i].DURTYPE] + "(s)";
    }

    tempData += "<li>Allergy - <b>" +
        result.jsonAllergy[i].NAME +
        "</b>" + dur + "</li>";
}
// End
}

                            tempData += "</ul></div></div>";
                            document.getElementById("tbldiv").innerHTML += tempData;
                        

                        /* ================= FINAL CHECK ================= */
                        if (!hasHistory) { // ✅ ADD
                            document.getElementById("tbldiv").innerHTML = `<div style="font-size:20px; text-align:center; font-weight:bold; color:#555;">No History Found for this record</div>`;
                           
                        }

                    } else {
                        document.getElementById("tbldiv").innerHTML = `<div style="font-size:20px; text-align:center; font-weight:bold; color:#555;">No History Found for this record</div>`;
                    }
                }
            });
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
            return day + "-" + month + "-" + year;
        }

    </script>

    <style>
        /*vijeta 9/5/19*/
        table {
            width: 100%;
        }

        .divHeads {
            padding-left: 2px !important;
            font-size: 13px !important;
            color: #ffffff !important;
            font-weight: bold !important;
            padding: 4px !important;
            background-color: #a9a9a9 !important;
            /*border-top: 3px solid #00a65a;*/
        }

        .panel-heading {
            background: #24417c !important;
            color: white !important;
            padding: 8px 12px !important;
            border-radius: 7px 7px 0 0 !important;
        }

            /* Responsive typography */
            .panel-heading h3 {
                margin: 0 !important;
                font-size: 1.3em !important;
            }

        .divBody {
            padding: 13px !important;
            background-color: white !important; /*rgba(128, 128, 128, 0.15);*/
            font-size: 14px !important; /*//*/
        }

        Label {
            margin-left: 5px;
        }

        .panel-body {
            width: auto !important;
            height: auto !important;
            -webkit-box-shadow: 0px 1px 2px 0px #878888;
        }

        .tblFree td {
            padding: 3px;
            border: 1px solid gray;
        }
    </style>

    <style>
        .tbldiv {
            margin-top: 10px;
            -webkit-box-shadow: 0px 1px 2px 0px #878888; /* Added by Dhananjay - 20240712*/
        }

        .divHeads {
            display: flex;
            justify-content: space-between; /*Added by Dhananjay - 20240712*/
            align-items: center;
            cursor: pointer;
        }

        .spanCls {
            font-size: 16px;
            transition: transform 0.3s ease; /* Added by Dhananjay - 20240712*/
        }

        .open .spanCls {
            transform: rotate(90deg); /* Added by Dhananjay - 20240712*/
        }

        .divHeads { /* Added by Dhananjay - 20240712*/
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        /* Style for the middle-side text */
        .middle-side {
            flex: 4; /* Takes up more space compared to left-side */
            text-align: center; /* Center the text */
        }


        /*added by vijeta on 24th July 2018*/
        .inputDates {
            width: 86px;
            height: 26px;
            margin-top: 4px;
        }

        /*added by vijeta on 24th July 2018*/
        #divDates {
            /*background-color: #f5dff5;*/
            border-radius: 8px 8px 8px 8px;
            margin-bottom: 0px !important;
            display: none;
            text-align: center;
            height: 34px;
        }

        #chartNote {
            height: 20px;
            font-size: 14px;
            font-weight: bold;
            background-color: #afe3f3;
        }

        .square {
            height: 10px;
            width: 10px;
            background-color: blue;
            float: left;
            margin-top: 6px;
            margin-left: 10px;
        }
        /*added by vijeta on 25th july 2018*/
        .btnTrend.btnTrend-primary {
            color: #fff;
            /*background-color: #9c27b0;*/
            border-color: #9c27b0;
            -webkit-box-shadow: 0 2px 2px 0 rgba(156,39,176,.14),0 3px 1px -2px rgba(156,39,176,.2),0 1px 5px 0 rgba(156,39,176,.12);
            box-shadow: 0 2px 2px 0 rgba(156,39,176,.14),0 3px 1px -2px rgba(156,39,176,.2),0 1px 5px 0 rgba(156,39,176,.12);
        }

            .btnTrend.btnTrend-primary.focus, .btnTrend.btnTrend-primary:focus, .btnTrend.btnTrend-primary:hover {
                color: #fff;
                background-color: #9124a3;
                border-color: #701c7e;
            }

        .btnTrend {
            position: relative;
            padding: 0px 0px;
            margin: .3125rem 1px;
            font-size: .75rem;
            font-weight: 400;
            line-height: 1;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 0;
            border: 0;
            border-radius: 1.5rem;
            outline: 0;
            -webkit-transition: background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
            transition: background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
            transition: box-shadow .2s cubic-bezier(.4,0,1,1),background-color .2s cubic-bezier(.4,0,.2,1);
            transition: box-shadow .2s cubic-bezier(.4,0,1,1),background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
        }

        .btnTrend-block {
            display: block;
        }

        .box-header {
            color: #fff;
            background: #afe3f3;
            background-color: #afe3f3;
            height: 36px;
        }
        /*------------------------------*/
        #ui-datepicker-div.ui-datepicker ui-widget {
            position: absolute;
            top: 92px;
            left: 343.656px;
            z-index: 1000;
            display: block;
            font-size: 14px;
            z-index: 1000;
        }

        .buttonstyle {
            background-color: transparent;
            margin-right: 2px;
            color: black;
            font-weight: bold;
            border-top: 1px solid transparent;
            border-right: 1px solid transparent;
            border-bottom: solid rgb(60, 141, 188);
            border-left: 1px solid transparent;
            border-image: initial;
            font-size: 10px;
            white-space: normal;
            outline: 0px;
        }

        .Y {
            background-color: #dd4b39 !important;
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 10px;
            font-weight: 600;
            color: #fff;
            line-height: 1;
            vertical-align: middle;
            text-align: center;
            border-radius: 10px;
        }

        .card-panel {
            transition: box-shadow .25s;
            padding: 20px;
            margin: 0.5rem 0 1rem 0;
            border-radius: 2px;
            background-color: #fff;
        }

        .card {
            position: relative;
            margin: 0.5rem 0 1rem 0;
            background-color: #fff;
            transition: box-shadow .25s;
            border-radius: 2px;
        }

            .card .card-title {
                font-size: 24px;
                font-weight: 300;
                color: #f6ea0a;
            }

            .card .card-content {
                padding: 10px 14px;
            }

        .teal.darken-2 {
            /*background-color: #00796b !important;*/
            background-color: #292727;
        }

        .white-text {
            color: #fff !important;
        }

        Label {
            margin-left: 5px;
        }

        /*.hide {
            display: none;
        }*/

        #tblInvestigationChart {
            /*font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;*/
            border-collapse: collapse;
            width: 100%;
            margin-left: 20px;
        }

            #tblInvestigationChart td, #tblInvestigationChart th {
                border: 1px solid #ddd;
                padding: 1px;
            }

            #tblInvestigationChart tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            #tblInvestigationChart tr:hover {
                background-color: #ddd;
            }

            #tblInvestigationChart th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #cdf5cb;
                color: black;
            }

        /*for increasing width of table from left and right side*/
        #fixedTable {
            margin-left: -20px;
            width: 368px;
        }

        /*first column test name wrapped*/
        #tblInvestigationChart tbody .testNameCls {
            word-wrap: break-word;
            white-space: pre-wrap;
            width: 20% !important;
        }

        @media only screen and (min-width : 992px) {
            #tblInvestigationChart td, #tblInvestigationChart th {
                border: 1px solid #ddd;
                padding: 6px;
            }

            #fixedTable {
                margin-left: -18px;
                width: 100%;
            }
        }

        #tblInvestigationChart tbody tr:nth-child(even) {
            background: #e8ba541c !important;
        }

        #tblInvestigationChart tbody tr:nth-child(odd) {
            background: #c5eff17a !important;
        }

        #tblInvestigationChart tbody tr:hover {
            background: #f4f4f4 !important;
            /*font-weight: bold !important;*/
            box-shadow: 1px 6px 13px 2px #a09d9da6;
        }

        /*@media only screen and (min-width: 992px) {
            .row {
                margin-right: -278px !important;
            }
        }*/

        @media only screen and (min-width: 1400px) {
            .row {
                margin-left: 0px;
            }
        }

        @media only screen and (min-width: 1366px) {
            .row {
                margin-left: 0px;
            }
        }

        @media only screen and (min-width: 1024px) {
            .row {
                margin-left: 0px;
            }
        }
    </style>
    <%-- PAC History --%>
    <script type="text/javascript">
        function GetPACHistoryLst() {
            var mrno = '<%=ViewBag.PATMRNO%>';
            var PACHistList = [];
            $.ajax({
                type: "POST",
                url: GetApiUrl("PatientClinicalHistory", "GetPACHistory"),
                datatype: "json",
                async: false,
                data: { Mrno: mrno },
                success: function (result) {
                    PACHistList = result == "" ? [] : result;
                },
                complete: function () { },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                }
            });
            BindPACHistoryList(PACHistList);
        }

        function BindPACHistoryList(PACHistList) {
            $("#TBodyPACHist").empty();
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCCONTENT}</td>";
            $.grep(PACHistList, function (a) {
                var RplIcon = "<i class='fa fa-eye IFrameEyeIcon' onclick=\"openIframe('" + a.MRNO + "','" + a.PACCONSNO + "','" + a.PACFITDATE + "','" + a.PACFITTIME + "')\"></i>";
                var RplIconTd = Td.replace("{STYLE}", "style='text-align:center;display:none'").replace("{TDCCONTENT}", RplIcon);
                var RplTranNoTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACCONSNO);
                var RplRefDoctTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.DOCTNAME);
                var RplSurgAdvDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGADVDATE);
                var RplSurgeryTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.SURGNMADVICE);
                var NatOfSurg = a.SURGADVTYPE == "R" ? "Regular" : (a.SURGADVTYPE == "E" ? "Emergency" : (a.SURGADVTYPE == "T" ? "Tentative" : ""))
                var RplNatOfSurgTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", NatOfSurg);
                var PacStatus = a.PACSTATUS == "F" ? "Fit" : (a.PACSTATUS == "W" ? "Fit, with Accepted Risk" : (a.PACSTATUS == "U" ? "UnFit" : "Pending"))
                var RplPacStatusTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", PacStatus);
                var RplPacStatusDTTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", (a.PACFITDATE + " " + a.PACFITTIME));
                var RplCreatedByTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCCONTENT}", a.PACDONEBY);
                var RplTr = Tr.replace("{TRCONTENT}", (RplIconTd + RplTranNoTd + RplRefDoctTd + RplSurgAdvDTTd + RplSurgeryTd + RplNatOfSurgTd + RplPacStatusTd + RplPacStatusDTTd + RplCreatedByTd));
                $("#TBodyPACHist").append(RplTr);
            });
        }

        function openIframe(Mrno, TranNo, PACDate, PACTime) {
            const iframeMain = document.getElementById('iframeMain');
            iframeMain.style.display = 'block';
            iframeMain.classList.remove('minimized');
            $("#iframeContainer").empty();
            document.getElementById('PACHistFrameLbl').innerText = TranNo + " (" + PACDate + " " + PACTime + ")";
            const iframe = document.createElement("iframe");
            iframe.id = "myIframe";
            iframe.src = "../TumorBoard/PAC?PatMRNO=" + Mrno + "&PatTRANNO=" + TranNo;
            iframe.style.width = "100%";
            iframe.style.height = "100%";
            iframe.style.border = "none";
            //iframe.onload = function () {
            //};
            document.getElementById("iframeContainer").appendChild(iframe);
        }

        function closeIframe() {
            document.getElementById('iframeMain').style.display = 'none';
        }

        function minimizeIframe() {
            const container = document.getElementById('iframeMain');
            container.classList.toggle('minimized');
        }
        function GetPreviousRecordsDate() {
            var Mrno = '<%=ViewBag.PATMRNO%>';
            $.ajax({
                url: '../TumorBoard/GetPerviousPCDet?Mrno=' + Mrno,
                type: 'POST',
                success: function (response) {
                    var $dropdown = $("#PrevDataDateTime");
                    $dropdown.empty(); // clear existing options
                    $dropdown.append('<option value="">---Select---</option>');
                    if (response && response.length > 0) {
                        $.each(response, function (index, item) {
                            var dateTime = item.DATE;

                            // Use TRANNO as the value (or whatever unique identifier you want)
                            $dropdown.append($('<option></option>').val(item.TRANNO).text(dateTime));
                        });
                    }
                    else {
                        $("#divHistInfo").html(
                            "<div style='font-size:20px; text-align:center; font-weight:bold; color:#555;'>No History Found for this record</div>"
                        );
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }
        function GetDept(type) {
            $.ajax({
                url:  GetApiUrl("PatientClinicalHistory", "GetDept") + '?Type=' + type,
                type: 'POST',
                success: function (response) {
                    console.log(response);
                    var $dropdown;
                    if (type == "L") {
                        $dropdown = $("#OthDept");
                    } else {
                        $dropdown = $("#LstDept");
                    }
                    $dropdown.empty(); // clear existing options
                    $dropdown.append('<option value="">---Select---</option>');
                    if (type == "L") {
                        if (response && response.length > 0) {
                            $.each(response, function (index, item) {
                                $dropdown.append($('<option></option>').val(item.Value).text(item.Text));
                            });
                        }
                        else {
                            $("#divHistInfo").html(
                                "<div style='font-size:20px; text-align:center; font-weight:bold; color:#555;'>No History Found for this record</div>"
                            );
                        }
                    }
                    else {
                        if (response && response.length > 0) {
                            $.each(response, function (index, item) {
                                $dropdown.append($('<option></option>').val(item.Value).text(item.Text));
                            });
                        }
                    }


                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }
    </script>

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

    <%-- Investigation Report--%>
    <style>
        .tbldiv {
            margin-top: 10px;
            -webkit-box-shadow: 0px 1px 2px 0px #878888; /* Added by Dhananjay - 20240712*/
        }

        .divHeads {
            display: flex;
            justify-content: space-between; /*Added by Dhananjay - 20240712*/
            align-items: center;
            cursor: pointer;
        }

        .spanCls {
            font-size: 16px;
            transition: transform 0.3s ease; /* Added by Dhananjay - 20240712*/
        }

        .open .spanCls {
            transform: rotate(90deg); /* Added by Dhananjay - 20240712*/
        }

        .divHeads { /* Added by Dhananjay - 20240712*/
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        /* Style for the middle-side text */
        .middle-side {
            flex: 4; /* Takes up more space compared to left-side */
            text-align: center; /* Center the text */
        }


        /*added by vijeta on 24th July 2018*/
        .inputDates {
            width: 86px;
            height: 26px;
            margin-top: 4px;
        }

        /*added by vijeta on 24th July 2018*/
        #divDates {
            /*background-color: #f5dff5;*/
            border-radius: 8px 8px 8px 8px;
            margin-bottom: 0px !important;
            display: none;
            text-align: center;
            height: 34px;
        }

        #chartNote {
            height: 20px;
            font-size: 14px;
            font-weight: bold;
            background-color: #afe3f3;
        }

        .square {
            height: 10px;
            width: 10px;
            background-color: blue;
            float: left;
            margin-top: 6px;
            margin-left: 10px;
        }
        /*added by vijeta on 25th july 2018*/
        .btnTrend.btnTrend-primary {
            color: #fff;
            /*background-color: #9c27b0;*/
            border-color: #9c27b0;
            -webkit-box-shadow: 0 2px 2px 0 rgba(156,39,176,.14),0 3px 1px -2px rgba(156,39,176,.2),0 1px 5px 0 rgba(156,39,176,.12);
            box-shadow: 0 2px 2px 0 rgba(156,39,176,.14),0 3px 1px -2px rgba(156,39,176,.2),0 1px 5px 0 rgba(156,39,176,.12);
        }

            .btnTrend.btnTrend-primary.focus, .btnTrend.btnTrend-primary:focus, .btnTrend.btnTrend-primary:hover {
                color: #fff;
                background-color: #9124a3;
                border-color: #701c7e;
            }

        .btnTrend {
            position: relative;
            padding: 0px 0px;
            margin: .3125rem 1px;
            font-size: .75rem;
            font-weight: 400;
            line-height: 1;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 0;
            border: 0;
            border-radius: 1.5rem;
            outline: 0;
            -webkit-transition: background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
            transition: background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
            transition: box-shadow .2s cubic-bezier(.4,0,1,1),background-color .2s cubic-bezier(.4,0,.2,1);
            transition: box-shadow .2s cubic-bezier(.4,0,1,1),background-color .2s cubic-bezier(.4,0,.2,1),-webkit-box-shadow .2s cubic-bezier(.4,0,1,1);
        }

        .btnTrend-block {
            display: block;
        }

        .box-header {
            color: #fff;
            background: #afe3f3;
            background-color: #afe3f3;
            height: 36px;
        }
        /*------------------------------*/
        #ui-datepicker-div.ui-datepicker ui-widget {
            position: absolute;
            top: 92px;
            left: 343.656px;
            z-index: 1000;
            display: block;
            font-size: 14px;
            z-index: 1000;
        }

        .buttonstyle {
            background-color: transparent;
            margin-right: 2px;
            color: black;
            font-weight: bold;
            border-top: 1px solid transparent;
            border-right: 1px solid transparent;
            border-bottom: solid rgb(60, 141, 188);
            border-left: 1px solid transparent;
            border-image: initial;
            font-size: 10px;
            white-space: normal;
            outline: 0px;
        }

        .Y {
            background-color: #dd4b39 !important;
            display: inline-block;
            min-width: 10px;
            padding: 3px 7px;
            font-size: 10px;
            font-weight: 600;
            color: #fff;
            line-height: 1;
            vertical-align: middle;
            text-align: center;
            border-radius: 10px;
        }

        .card-panel {
            transition: box-shadow .25s;
            padding: 20px;
            margin: 0.5rem 0 1rem 0;
            border-radius: 2px;
            background-color: #fff;
        }

        .card {
            position: relative;
            margin: 0.5rem 0 1rem 0;
            background-color: #fff;
            transition: box-shadow .25s;
            border-radius: 2px;
        }

            .card .card-title {
                font-size: 24px;
                font-weight: 300;
                color: #f6ea0a;
            }

            .card .card-content {
                padding: 10px 14px;
            }

        .teal.darken-2 {
            /*background-color: #00796b !important;*/
            background-color: #292727;
        }

        .white-text {
            color: #fff !important;
        }

        Label {
            margin-left: 5px;
        }

        /*.hide {
            display: none;
        }*/

        #tblInvestigationChart {
            /*font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;*/
            border-collapse: collapse;
            width: 100%;
            margin-left: 20px;
        }

            #tblInvestigationChart td, #tblInvestigationChart th {
                border: 1px solid #ddd;
                padding: 1px;
            }

            #tblInvestigationChart tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            #tblInvestigationChart tr:hover {
                background-color: #ddd;
            }

            #tblInvestigationChart th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #cdf5cb;
                color: black;
            }

        /*for increasing width of table from left and right side*/
        #fixedTable {
            margin-left: -20px;
            width: 368px;
        }

        /*first column test name wrapped*/
        #tblInvestigationChart tbody .testNameCls {
            word-wrap: break-word;
            white-space: pre-wrap;
            width: 20% !important;
        }

        @media only screen and (min-width : 992px) {
            #tblInvestigationChart td, #tblInvestigationChart th {
                border: 1px solid #ddd;
                padding: 6px;
            }

            #fixedTable {
                margin-left: -18px;
                width: 100%;
            }
        }

        #tblInvestigationChart tbody tr:nth-child(even) {
            background: #e8ba541c !important;
        }

        #tblInvestigationChart tbody tr:nth-child(odd) {
            background: #c5eff17a !important;
        }

        #tblInvestigationChart tbody tr:hover {
            background: #f4f4f4 !important;
            /*font-weight: bold !important;*/
            box-shadow: 1px 6px 13px 2px #a09d9da6;
        }

        /*@media only screen and (min-width: 992px) {
            .row {
                margin-right: -278px !important;
            }
        }*/

        @media only screen and (min-width: 1400px) {
            .row {
                margin-left: 0px;
            }
        }

        @media only screen and (min-width: 1366px) {
            .row {
                margin-left: 0px;
            }
        }

        @media only screen and (min-width: 1024px) {
            .row {
                margin-left: 0px;
            }
        }
    </style>
      <div id="iframeHeader" style="display:none">
       <label id="PrevHistFrameLbl"></label>
      <%-- <div class="iframe-controls">
           <i class="fa fa-minus-circle IFrameIcon" onclick="minimizeIframe()" aria-hidden="true"></i>
           <i class="fa fa-times-circle IFrameIcon" onclick="closeIframe()" aria-hidden="true"></i>
       </div>--%>
   </div>
    <div style="display: flex; justify-content: center; align-items: center; margin: 10px 0;">
        <div class="tab-container">
            <button type="button" id="TabSurg" class="btn-Tabs active">Surgical</button>
            <button type="button" id="TabChemo" class="btn-Tabs">Chemo</button>
            <button type="button" id="TabRadiation" class="btn-Tabs">Radiation</button>
            <button type="button" id="TabPAC" class="btn-Tabs">PAC</button>
            <button type="button" id="TABClinical" class="btn-Tabs">OPD History</button>
            <%--            <button type="button" id="TABPalliaitve" class="btn-Tabs">PalliativeCare History</button>--%>
            <button type="button" id="TABHistory" class="btn-Tabs">History</button>
            <button type="button" id="TABInvestigation" class="btn-Tabs" >Investigation</button>
            <button type="button" id="TabDiagnosis" class="btn-Tabs">Diagonsis</button>
            <button type="button" id="TabRemark" class="btn-Tabs">External Doctors Recommendations</button>
        </div>

        <!-- Add Surgery History Button (Right) -->
        <button type="button" id="btnAddRecord" style="display: none" class="btn-add">➕ Add Surgery History</button>
    </div>
    <div id="PalHist">
        <label>Select Previous History</label>
        <%: Html.DropDownList(
  "PrevDataDateTime",
  new List<SelectListItem>(),
  "---Select---",
  new { 
      id = "PrevDataDateTime", 
      @class = "ComboFormat", 
      style = "width: 200px;height: 26px;", 
      onchange = "openPallIframe(this.value)" 
  }) %>
    </div>


    <!-- Modal Overlay and Box -->
    <div id="surgeryModal" class="custom-modal-overlay" style="display: none;">
        <div class="custom-modal-box">
            <span class="close-modal" id="closeModal">&times;</span>
            <h4>Add Surgical History</h4>

            <div class="form-row">
                <div class="form-group">
                    <label for="txtDoctorName">Doctor Name:</label>
                    <input type="text" id="txtDoctorName" class="input-field" placeholder="Enter doctor name" />
                </div>
                <div class="form-group" style="display: none">
                    <label for="txtUniqueID">Unique ID:</label>
                    <input type="text" id="txtUniqueID" class="input-field" placeholder="Unique Id" />
                </div>
                <div class="form-group">
                    <label for="txtSurgeryDate">Surgery Date:</label>
                    <input type="text" id="txtSurgeryDate" class="input-field" readonly />
                </div>
            </div>

            <div class="form-group">
                <label for="txtSurgeryName">Surgery Name:</label>
                <input type="text" id="txtSurgeryName" class="input-field" placeholder="Enter surgery name" />
            </div>

            <div class="form-group">
                <label for="txtNotes">Notes:</label>
                <textarea id="txtNotes" class="input-field" rows="3" placeholder="Enter notes" maxlength="748"></textarea>
            </div>

            <%-- <button type="button" id="btnAddSurgery" class="btn-add">➕ Add</button>--%>
            <button type="button" id="btnSaveSurgery" class="btn-add">💾 Save</button>

            <button type="button" id="btnUpdateSurgery" class="btn-add" style="display: none;">🔁 Update</button>
        </div>
    </div>



    <%--<div id="surgeryInfoContainer"></div>--%>

    <div id="tabContent"  style="padding-bottom: 130px;">
        <div id="divSurgInfo" class="tab-panel" style="display: none;">
            <div id="surgeryInfoContainer"></div>
        </div>

        <div id="divChemoInfo" class="tab-panel" style="display: none;">
            <div id="chemoInfoContainer"></div>
        </div>

        <div id="divRadiationInfo" class="tab-panel" style="display: none;">
                             
                <div class="col-xs-12" style="margin-bottom: 15px;">
                    <fieldset style="background-color: white; padding-bottom: 10px;">
                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 2px;">Radition History </legend>
                        <div class="MedicineDiv table-responsive" style="width: 100%">
                            <table id="TableRad" class="table table-bordered table-striped MedicineTbl">
                                <thead>
                                    <tr>
                                        <th style="width: 100px">Mr No.</th>
                                        <th>Rt No.</th>
                                        <th>Patient Name</th>
                                        <th>Consultant</th> 
                                        <th>Treatment Technique</th> 
                                        <th>Total Dose (cGy)</th>
                                        <th>Start Date</th>
                                        <th>Total Fractions</th>
                                        <th>Completed Fractions</th>
                                        <th>Pending Fractions</th>
                                    </tr>
                                </thead>
                                <tbody id="TableRTTracker"></tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
               
            </div>

        <div id="divPACInfo" class="tab-panel" style="display: none;">
            <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                <div class="Tablewrapper" style="font-size: 12px; background: white;">
                    <table class="tblpopupList" id="TblPACHistInfo">
                        <thead>
                            <tr>
                                <th style="display: none">Act</th>
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

        <div id="divHistInfo" class="tab-panel" style="display: none;">
        </div>
        <%--For Personal ,Family,Medical History--%>
        <div id="divHistoryInfo" class="tab-panel" style="display: none;">
            <div id="tbldiv"></div>
        </div>
        <div id="divInvestigationInfo" class="tab-panel" style="display: none;">
            <div class="row" style="margin-left: 0px !important">
                <div class="">
                    <%-- added by vijeta on 23rd July 2018--%>
                    <div style="text-align: center; line-height: 1;">
                        <!-- parent container centers content -->
                        <div id="divDates" style="display: none; vertical-align: middle;">
                            <span id="DATE1" style="font-size: 13px; font-weight: bold; width: 50px;">From </span>
                            <input type="text" id="RptFrmDate" class="inputDates" readonly />
                            <span id="DATE2" style="font-size: 13px; font-weight: bold; width: 40px;">To </span>
                            <input type="text" id="RptToDate" class="inputDates" readonly />
                            <i class="fa fa-search" aria-hidden="true" id="btnSearch" style="font-size: 17px; margin-left: 4px"></i>
                        </div>

                        <div id="RadDept" style="display: none; vertical-align: middle; margin-left: 10px;">
                            <label>Department</label>
                                                      <%: Html.DropDownList("LstDept", new List<SelectListItem>(),"---Select---", new{id = "LstDept",@class = "ComboFormat",style = "width: 200px;height: 26px;",onchange = " GetRadTestList(this.value);"}) %>
                        </div>
                        <div id="OthDivDept" style="display: none; vertical-align: middle; margin-left: 10px;">
                            <label>Department</label>
                            <%: Html.DropDownList("LstDept", new List<SelectListItem>(),"---Select---", new{id = "OthDept",@class = "ComboFormat",style = "width: 200px;height: 26px;"}) %>
                        </div>
                    </div>
                    <div class="nav-tabs-custom" style="margin-bottom: 0px !important; margin-top: 15px; background-color: #f3d9dd">
                        <%--background-color: #f3d9dd"--%>
                        <ul class="nav nav-tabs" style="margin-left: 13%;">
                            <li class="active"><a id="Investigation" class="Investigation" data-toggle="tab" aria-expanded="true" style="font-size: 12px !important">Investigation Wise</a></li>
                            <li class=""><a href="#DateWise" class="DateWise" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Date Wise</a></li>
                            <li class=""><a href="#AbnormalValues" class="AbnormalValues" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Abnormal Values</a></li>
                            <li class=""><a href="#Trends" class="Trends" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Trends</a></li>
                            <li class=""><a href="#BiposyRpt" class="BiposyRpt" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Biposy Reports </a></li>
<%--                            <li class=""><a href="#OthRpt" class="OthRpt" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Other Reports</a></li>--%>
                            <li class=""><a href="#CultureRpt" class="CultureRpt" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Culture Report</a></li>
                            <%--Added by Dhanjay 20241012--%>
                            <li class=""><a href="#OutsideRpt" class="OutRpt" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Outside Reports <i id="outRptPresent" class="fa fa-info-circle" style="color: #37a0ee; font-size: 15px;" aria-hidden="true"></i></a></li>
                            <li class=""><a href="#RadiologyRpt" class="RadiologyRpt" data-toggle="tab" aria-expanded="false" style="font-size: 12px !important">Radiology And Nuclear Medicine Reports </a></li>

                        </ul>
                        <!-- /.tab-content -->
                    </div>

                    <div id="wrapper" style="overflow: hidden; width: 100%; overflow-x: hidden !important; overflow-y: hidden !important;">
                        <div class="tableDivInvestig" style="padding-top: 5px; display: none">
                            <div class="row" style="margin-left: 0px !important; margin-right: 0px !important">
                                <%--  <h4 style="color: darkslategray; font-weight: bold">Investigation Chart</h4>--%>
                                <div class="sticky-table sticky-headers sticky-ltr-cells" id="fixedTable">
                                    <table id="tblInvestigationChart" style="line-height: 1.5; width: 100%" class="table table-striped">
                                        <thead class="fixedHeader"></thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                                <!-- No Record Message -->
                                <div id="NoRecordInv" style="font-size: 20px; text-align: center; font-weight: bold; color: #555; margin-top: 25px; padding: 15px; background: #f9f9f9; #ddd; width: 100%; max-width: 1200px; margin-left: auto; margin-right: auto;">
                                    No Data Found for this Records
                                </div>
                                l
                            </div>
                        </div>
                        <div class="tableDivAbnormal" style="padding-top: 5px; display: none">
                            <div id="NoRecordAbnormal" style="font-size: 20px; text-align: center; font-weight: bold; color: #555; margin-top: 25px; padding: 15px; background: #f9f9f9; #ddd; width: 100%; max-width: 1200px; margin-left: auto; margin-right: auto;">
                                No Data Found for this Records
                            </div>
                        </div>
                        <div class="tableDivDateWise" style="padding-top: 5px; display: none">
                            <div id="NoRecordDateWise" style="font-size: 20px; text-align: center; font-weight: bold; color: #555; margin-top: 25px; padding: 15px; background: #f9f9f9; border: 1px solid #ddd; width: 100%; max-width: 1200px; margin-left: auto; margin-right: auto;">
                                No Data Found for this Records
                            </div>
                        </div>
                        <div class="tableTrends" style="padding-top: 5px; display: none">
                            <%--added by vijeta on 25th July 2018--%>
                            <div style="border: 1px solid #afe3f3">
                                <div class="col-md-12 box-header with-border" style="padding-left: 4px; padding-right: 4px;" id="TestListDivHead">
                                    <span class="box-title" style="font-size: 19px; font-weight: 400; color: black;">Tests</span>
                                    <b><span id="lblTestName" style="margin-left: 2px; font-size: 14px; color: black"></span></b>
                                    <!-- /.box-tools -->
                                </div>
                            </div>
                            <div>
                                <div class="col-md-12 col-xs-12" style="border: 1px solid #436d92" id="TestListDiv"></div>
                            </div>

                            <div>
                                <div class="col-md-12  col-xs-12" id="chartNote" style="display: none">
                                    <div style="float: left">Note-</div>
                                    <div class="square"></div>
                                    &nbsp;&nbsp;Result
                                </div>
                                <div class="col-md-12  col-xs-12 divSubList">
                                    <div id="divCharts"></div>
                                </div>
                            </div>
                            <div id="NoRecordTrend"
                                style="font-size: 20px; text-align: center; font-weight: bold; color: #555; margin-top: 25px; padding: 15px; background: #f9f9f9; border: 1px solid #ddd; width: 100%; max-width: 1200px; margin-left: auto; margin-right: auto; display: none;">
                                No Data Found for this Records
                            </div>
                        </div>
                        <div class="divPendingOrder" style="padding-top: 5px; display: none; width: 100%;">
                            <div class="divTestGrid" style="margin: 0 auto; width: 95%; max-width: 1200px;">
                                <table id="gvTest"></table>
                                <div id="gvTestPager"></div>
                            </div>
                        </div>
                        <div class="divBiopsyRpt" style="padding-top: 5px; display: none; width: 100%;">
                            <div class="col-xs-12" style="margin-bottom: 15px;">
                                <fieldset style="background-color: white; padding-bottom: 10px;">
                                    <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 2px;">Biposy Reports</legend>
                                    <div class="MedicineDiv table-responsive" style="width: 100%">
                                        <table id="TableBiposy" class="table table-bordered table-striped MedicineTbl">
                                            <thead>
                                                <tr>
                                                    <th style="width: 75px">Test Code</th>
                                                    <th>Test Name</th>
                                                    <th>Test Impression</th>
                                                    <th>Prescribing Doctor's Name</th>
                                                    <th>Test Reported By</th>
                                                    <th>Verified By</th>
                                                    <th>Result Date </th>
                                                    <th>Result No</th>
                                                </tr>
                                            </thead>
                                            <tbody id="TableBiposyBody"></tbody>
                                        </table>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                        <div class="tableOthTempRpt" style="padding-top: 5px; display: none">
                            <div id="NoRecordOthTemp" style="font-size: 20px; text-align: center; font-weight: bold; color: #555; margin-top: 25px; padding: 15px; background: #f9f9f9; #ddd; width: 100%; max-width: 1200px; margin-left: auto; margin-right: auto;">
                                No Data Found for this Records
                            </div>
                        </div>

                        <div class="tblOutRptAttachments" style="padding-top: 5px; display: none">
                            <div id="wrapper1" style="width: 100%">
                                <div class="tableDiv">
                                    <table id="tbl1" class="table" style="width: 100%">
                                        <tbody id="tblsort1"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <%--// Added by Dhananjay 20240712--%>
                        <div id="container"></div>

                    </div>
              <%--      <div class="alert alert-danger NoRecord">
                        <strong>
                            <i class="ace-icon fa fa-times"></i>
                            No Record Found
                        </strong>

                    </div>--%>

                </div>
            </div>

        </div>
        <div id="divDignosisInfo" class="tab-panel" style="display: none;">
                <div class="col-xs-12" style="margin-bottom: 15px;">
                    <fieldset style="background-color: white; padding-bottom: 10px;">
                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 2px;">ICD Diagnosis</legend>
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
                <div id="divRemarkInfo" class="tab-panel" style="display: none;">
                <div class="col-xs-12" style="margin-bottom: 15px;">
                    <fieldset style="background-color: white; padding-bottom: 10px;">
                        <legend class="InvstFieldSetLegend" style="background-color: #ffffff; padding: 2px;">External Doctors Recommendations</legend>
                        <div class="MedicineDiv table-responsive" style="width: 100%">
                            <table id="TableRemark" class="table table-bordered table-striped MedicineTbl">
                                <thead>
                                    <tr>
                                        <th style="width: 150px">Doctor Code</th>
                                        <th>Doctor Name</th>
                                        <th>Recommendations</th>
                                    </tr>
                                </thead>
                                <tbody id="TableRemarkBody"></tbody>
                            </table>
                        </div>
                    </fieldset>
                </div>
              </div>
    <!-- Fixed Recommendations Section -->
<!-- Fixed Recommendations Section -->
<div id="divRecommendations" style="position: fixed; bottom: 0; left: 0; width: 99%; background: #f9f9f9; border-top: 1px solid #ccc; padding: 10px 15px; box-shadow: 0 -2px 5px rgba(0,0,0,0.1); z-index: 999; display: flex; flex-direction: column;">
    <label for="txtRecommendations" style="font-weight: bold; font-size: 14px; margin-bottom: 5px;">
        Recommendations:
    </label>

                <textarea id="txtRecommendations" placeholder="Enter recommendations here..." style="width: 100%; min-height: 80px; resize: vertical; padding: 8px; font-size: 13px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; margin-bottom: 8px;"></textarea>

     <button type="button" id="btnSaveRecommendations"
     class="btn-add"
     style="align-self: center; padding: 5px 12px; font-size: 13px; border-radius: 6px; cursor: pointer;"
     onclick="saveRecommendations()">
     💾 Save
 </button>
   <button type="button" id="btnEditRecommendations" class="btn-add" style="align-self: center; padding: 5px 12px; font-size: 13px; border-radius: 6px; cursor: pointer; display: none;" onclick="EnableTextBox()">
    💾 Edit
</button>
</div>

        </div>
        <script type="text/javascript">
            var Mrno = '<%=ViewBag.PATMRNO%>';
            var InvestigateResultData = "";
            var InvestigateData = "";
            var InvestigateTrendsData = "";
       <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var LabFile = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.LabAttach))%>');
            var pathFrom = "";
            $(document).ready(function () {
                $(".tbldiv").css('display', 'none') // Added by Dhananjay 20240712
                $("#outRptPresent").hide();
                SetDateTime();
                localStorage.setItem('IsInvestigationData', false);

                showLabFiles(LabFile); //Meenakshi

                $('.Investigation').click(function () {
                    $('#LstDept').val('');
                    $('#RadDept').css('display', 'none');
                    $("#divDates").hide();
                    $("#container").css('display', 'none')
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'none');
                    var flag = localStorage.getItem("IsInvestigationData")
                    $(".tableDivInvestig").css('display', 'block')
                    $(".tableDivDateWise").css('display', 'none')
                    $(".tableDivAbnormal").css('display', 'none')
                    $('.tableOthTempRpt').css('display', 'none')
                    $(".tableTrends").css('display', 'none')
                    $(".tblOutRptAttachments").css('display', 'none')

                    //if (flag === 'false') {
                    //    loadInvestigationReport(Mrno);
                    //}
                });

                $('.AbnormalValues').click(function () {
                    $('#LstDept').val('');
                    $('#RadDept').css('display', 'none');
                    $("#divDates").show();
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'none');
                    $('.divTestGrid').css('display', 'none');
                    //var flag = localStorage.getItem("IsAbnoramlData")
                    $(".tableDivAbnormal").css('display', 'block');
                    $(".tableDivInvestig").css('display', 'none');
                    $(".tableDivDateWise").css('display', 'none');
                    $(".tableTrends").css('display', 'none');
                    $('.tableOthTempRpt').css('display', 'none')
                    $(".tblOutRptAttachments").css('display', 'none')
                    $("#container").css('display', 'none')

                    // if (flag === 'false') {
                    BindAbNormalData();
                    //}
                });

                $('.OthRpt').click(function () {
                    $('#LstDept').val('');
                    $('#RadDept').css('display', 'none');
                    $("#divDates").show();
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'none');
                    $('.divTestGrid').css('display', 'none');
                    $(".tableDivAbnormal").css('display', 'none');
                    $(".tableDivInvestig").css('display', 'none');
                    $(".tableDivDateWise").css('display', 'none');
                    $(".tableTrends").css('display', 'none');
                    $(".tableOthTempRpt").css('display', 'block');
                    $(".tblOutRptAttachments").css('display', 'none')
                    $("#container").css('display', 'none')
                    GetDept("L");
                    BindTemplRptData();
                });



                $('.OutRpt').click(function () {
                    $('#LstDept').val('');
                    $('#RadDept').css('display', 'none');
                    $("#divDates").hide();
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'none');
                    $('.divTestGrid').css('display', 'none');
                    $(".tableDivAbnormal").css('display', 'none');
                    $(".tableDivInvestig").css('display', 'none');
                    $(".tableDivDateWise").css('display', 'none');
                    $(".tableTrends").css('display', 'none');
                    $(".tableOthTempRpt").css('display', 'none');
                    $(".tableOthTempRpt").css('display', 'none');
                    $(".tblOutRptAttachments").css('display', 'block');
                    $("#container").css('display', 'none')
                    $('#NoRecord').hide();
                    getOutsideReportService();
                });
                $('.RadiologyRpt').click(function () {
                    $('#RadDept').css('display', 'inline-block');
                    $("#divDates").hide();
                    $('.divPendingOrder').css('display', 'block');
                    $('.divBiopsyRpt').css('display', 'none');
                    $('.divTestGrid').css('display', 'none');
                    $(".tableDivAbnormal").css('display', 'none');
                    $(".tableDivInvestig").css('display', 'none');
                    $(".tableDivDateWise").css('display', 'none');
                    $(".tableTrends").css('display', 'none');
                    $(".tableOthTempRpt").css('display', 'none');
                    $(".tableOthTempRpt").css('display', 'none');
                    GetDept();
                    $(".tblOutRptAttachments").css('display', 'none');
                    $("#container").css('display', 'block')
                    $('#NoRecord, #noDataMessage').remove();

                    // ✅ Show your "No Data Found" message
                    let html = `
                            <div id="noDataMessage" 
                                 style="font-size:20px; text-align:center; font-weight:bold; color:#555; 
                                        margin-top:25px; padding:15px; background:#f9f9f9; 
                                        border:1px solid #ddd; width:100%; 
                                        max-width:1200px; margin-left:auto; margin-right:auto;">
                               Select The Department
                            </div>`;

                    // Append message below the main container or relevant div
                    $(".divPendingOrder").prepend(html);
                });
                $('.BiposyRpt').click(function () {
                    $('#RadDept').css('display', 'none');
                    $("#divDates").hide();
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'block');
                    $('.divTestGrid').css('display', 'none');
                    $(".tableDivAbnormal").css('display', 'none');
                    $(".tableDivInvestig").css('display', 'none');
                    $(".tableDivDateWise").css('display', 'none');
                    $(".tableTrends").css('display', 'none');
                    $(".tableOthTempRpt").css('display', 'none');
                    $(".tableOthTempRpt").css('display', 'none');
                    GetBiposyReport();
                    $("#container").css('display', 'none')

                });

                $('.DateWise').click(function () {
                    $('#LstDept').val('');
                    $('#RadDept').css('display', 'none');
                    $("#divDates").show(); //added on 24th July 2018
                    //$("#btnSearch").addClass("btnSearchCSS");//added on 24th July 2018
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'none');
                    $('.divTestGrid').css('display', 'none');
                    $(".tableDivAbnormal").css('display', 'none')
                    $(".tableDivInvestig").css('display', 'none')
                    $(".tableDivDateWise").css('display', 'block')
                    $(".tableTrends").css('display', 'none')
                    $('.tableOthTempRpt').css('display', 'none')
                    //var flag = localStorage.getItem("IsDatewiseData")
                    //if (flag === 'false') {
                    BindDatewiseInvest();
                    //}
                    $(".tblOutRptAttachments").css('display', 'none')
                    $("#container").css('display', 'none')
                });

                $('.Trends').click(function () {
                    $('#LstDept').val('');
                    $('#RadDept').css('display', 'none');
                    $("#divDates").show(); //added on 24th July 2018
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'none');
                    $('.divTestGrid').css('display', 'none');
                    $(".tableDivInvestig").css('display', 'none')
                    $(".tableDivDateWise").css('display', 'none')
                    $(".tableDivAbnormal").css('display', 'none')
                    $(".tableTrends").css('display', 'block')
                    $('.tableOthTempRpt').css('display', 'none')
                    //var flag = localStorage.getItem("IstTrendsData")
                    //if (flag === 'false') {
                    GetTestList();//added on 25th july 2018
                    //GetTrendWiseData()
                    //}
                    $(".tblOutRptAttachments").css('display', 'none')
                    $("#container").css('display', 'none')
                });

                // Added by Dhananjay 20240712  -- 
                $('.CultureRpt').click(function () {
                    $('#LstDept').val('');
                    $('#RadDept').css('display', 'none');
                    $("#divDates").show();    // date display on top
                    $('#NoRecord').hide();     // hide no records alert
                    $('.divPendingOrder').css('display', 'none');
                    $('.divBiopsyRpt').css('display', 'none');
                    $('.divTestGrid').css('display', 'none');
                    $(".tableDivAbnormal").css('display', 'none');
                    $(".tableDivInvestig").css('display', 'none');
                    $(".tableDivDateWise").css('display', 'none');
                    $(".tableTrends").css('display', 'none');
                    $(".tblOutRptAttachments").css('display', 'none')
                    $('.tableOthTempRpt').css('display', 'none')       // Added by Dhananjay 20240730
                    $("#container").css('display', 'block') // display table 
                    getCultureResult();     // Added by Dhananjay 20240730
                });

                //added on 23rd July 2018
                $("#RptFrmDate,#RptToDate").click(function () {
                    $("#ui-datepicker-div.ui-widget").css("z-index", "1000");
                });

                //added on 24th July 2018
                $("#btnSearch").click(function () {

                    var frmDate = $("#RptFrmDate").val();
                    var toDate = $("#RptToDate").val();
                    var flgInvest = $(".tableDivInvestig").css('display');
                    var flagDateWise = $(".tableDivDateWise").css('display');
                    var flagAbnormal = $(".tableDivAbnormal").css('display');
                    var flagTrends = $(".tableTrends").css('display');
                    var flagTempRpt = $(".tableOthTempRpt").css('display');
                    var flagCultureRpt = $("#container").css('display');  // Added by Dhananjay 20240712s

                    if (flagDateWise == "block")
                        BindDatewiseInvest();

                    if (flagAbnormal == "block")
                        BindAbNormalData();

                    if (flagTrends == "block")
                        GetTestList();

                    if (flagTempRpt == "block")
                        BindTemplRptData();

                    if (flagCultureRpt == "block") {  // Added by Dhananjay 20240712 
                        $("#container").empty();
                        getCultureResult();
                    }
                });
                //added on 2th July 2018
                //$("#TestListDivHead").click(function () {
                //    tooglediv();
                //});
            });

            // Added by Dhananjay 20240712 
            function getCultureResult() {
                debugger;
                $("#container").empty();   // Added by Dhananjay 20240730
                var strMRNO = '<%=ViewBag.PATMRNO%>';
                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();

                $.ajax({
                    type: "GET",
                    url: GetApiUrl("DoctorDesk", "GetCultureResult"),
                       
                    data: {
                        MrnNo: strMRNO,
                        strFrmDate: frmDate,
                        strTodate: toDate
                    },
                    dataType: "json",
                    success: function (response) {
                        $('#NoRecord').hide();
                        var data = response == "" ? [] : (JSON.parse(response)).Results
                        for (let i = 0; i < data.length; i++) {
                            BindCultureRptData(data[i])
                        }
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        $('#NoRecord').show();
                    }
                });
            }
            function GetRadTestList(deptcode) {
                $("#container").empty();   // Added by Dhananjay 20240730
                var strMRNO = '<%=ViewBag.PATMRNO%>';
                var strLabType = deptcode;
                if (strLabType != "") {
                    $.ajax({
                        
                        type: "GET",
                        url: GetApiUrl("PatientClinicalHistory", "GetRadHistForTBD"),
                            
                        data: {
                            MrnNo: strMRNO,
                            strLabType: strLabType,
                            strUnit: GUnitCode
                        },
                        dataType: "json",
                        success: function (response) {
                            var data = response;
                            if (data && data.rows && data.rows.length > 0) {
                                $("#noDataMessage").remove();
                                $(".divTestGrid").show();
                                fillTest();
                                $('#gvTest').jqGrid('setGridParam', {
                                    data: data.rows,
                                    datatype: 'local'  // make sure datatype is local when setting data manually
                                }).trigger('reloadGrid');
                            } else {
                                // Clear and hide grid container
                                $('#gvTest').jqGrid('clearGridData');
                                $(".divTestGrid").hide();
                                $("#noDataMessage").remove();
                                // Append your professional message
                                let html = `
                                    <div id="noDataMessage" 
                                         style="font-size:20px; text-align:center; font-weight:bold; color:#555; 
                                                margin-top:25px; padding:15px; background:#f9f9f9; 
                                                #ddd; width:100%; 
                                                max-width:1200px; margin-left:auto; margin-right:auto;">
                                        No Data Found for this Department
                                    </div>`;

                                // Add it below your grid container
                                $(html).insertAfter(".divTestGrid");
                            }

                        },
                        error: function (xhr, textStatus, errorThrown) {

                        }
                    });
                } else {
                    $('#gvTest').jqGrid('clearGridData');
                    $(".divTestGrid").hide();
                    $("#noDataMessage").remove();
                    // Append your professional message
                    let html = `
                        <div id="noDataMessage" 
                             style="font-size:20px; text-align:center; font-weight:bold; color:#555; 
                                    margin-top:25px; padding:15px; background:#f9f9f9; 
                                    #ddd; width:100%; 
                                    max-width:1200px; margin-left:auto; margin-right:auto;">
                          Please Select The Department
                        </div>`;
                    // Add it below your grid container
                    $(html).insertAfter(".divTestGrid");
                }
            }
            //Added By Roshan 16-10-2025
            function fillTest() {
                $("#gvTest").jqGrid({
                    datatype: "local",
                    colModel: [
                        { label: 'Laboratory Code', name: 'LABTYPECD', hidden: true },
                        { label: 'Laboratory', name: 'LABDESC', width: 150, hidden: true  },
                        { label: 'Lab Name', name: 'LABTYPENM', width: 130 },
                        { label: 'Test Code.', name: 'TESTCODE', hidden: true },
                        { label: 'Test Description', name: 'TESTNAME', width: 200 },
                        { label: 'Result Date & Time', name: 'RESULTDATE', width: 150 },
                        { label: 'Result Time', name: 'RESULTTIME', width: 120, hidden: true },
                         { label: 'Accession No.', name: 'SAMLECOLNO', width: 130 },
                        //Below column Added by Murali on 24/02/2026
                        { label: 'Impression Details', name: 'IMPRESSIONDT', width: 650 
                            , cellattr: function () {
                                return 'style="white-space: normal; word-wrap: break-word;"';
                            }
                        },
                        {
                            label: 'PACs Link',
                            name: 'PACSURL',
                            width: 100,
                            formatter: function (cellValue) {
                                return cellValue ? `<a href="${cellValue}" target="_blank" style="color:#0078d7;text-decoration:none;">View</a>` : '';
                            }
                        },
                        { label: 'Order No.', name: 'ORDERNO', width: 150, hidden: true  },
                        { label: 'Result No.', name: 'RESULTNO', width: 130, hidden: true  },
                       
                    ],
                    hoverrows: false,
                    shrinkToFit: true,
                    rownumbers: true,
                    rowNum: 1000000000000,
                    cellEdit: false,
                    loadtext: "Loading...",
                    cellsubmit: "clientArray",
                    autowidth: true,
                    height: "auto",
                    pager: "#gvTestPager",
                    caption: "Test Results",
                    viewrecords: true

                });
                $(window).on('resize', function () {
                    var newWidth = $("#gvTest").closest(".ui-jqgrid").parent().width();
                    $("#gvTest").jqGrid("setGridWidth", newWidth, true);
                    //$("#gvTest").jqGrid("setGridWidth", 1500, true);
                }).trigger('resize');
            }


            // Added by Dhananjay 20240712 
            function BindCultureRptData(result) {

                if (result != null) {
                    $("#tblVitalHistory").empty();
                    $("#resultInfoDiv").remove(); // Remove existing resultInfoDiv if present
                    $("#footerInfoDiv").remove(); // Remove existing footerInfoDiv if present

                    // Create tbldiv container for each record with a unique ID
                    var $tbldiv = $('<div class="tbldiv" id="tbldiv_' + result.RESULTNO + '" style="overflow-x:auto;"></div>');

                    // Create divCaption with a toggle icon
                    var formattedDate = formatDate(result.RESULTDATE);
                    var resultNo = result.RESULTNO || '';
                    // var $divCaption = $('<div class="panel-heading divHeads" style="text-align:center;font-size:14px;background-color:rgba(107, 107, 107, 0.12941176470588237);"></div>');
                    var $divCaption = $('<div style="text-align:center;font-size:14px;background-color:rgba(107, 107, 107, 0.12941176470588237);color: white;padding: 8px 12px;border-radius: 7px 7px 0 0;background: #24417c;"></div>');
                    var leftText = "Result Date " + formattedDate;
                    var leftText1 = "Time " + ':' + result.RESULTTIME;
                    var middleText = "Result No : " + resultNo + " ";

                    //$divCaption.html('<div class="left-side" style="position:relative;padding:0;margin: 0; flex: 1;background:none;">' + leftText + '</div>' +
                    //                 '<div class="left-side" style="position:relative;padding:0;margin: 0; flex: 1;background:none;font-size:14px;">' + leftText1 + '</div>' +
                    //                 '<div class="middle-side" >' + middleText + '</div>' +
                    //                 '<i class="fa fa-caret-right spanCls"></i>'); // Add toggle icon

                    //$tbldiv.append($divCaption); // Append caption to tbldiv

                    $divCaption.html(
                        "<table style='width:100%;color:white;font-size:12px;'>" +
                        "<tr>" +
                        "<td style='width:24.90%;position:relative;padding:0;margin:0;'>" + leftText + "</td>" +
                        "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + leftText1 + "</td>" +
                        "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + '<span class="TestName">Test Name:</h4> <span>' + (result.TESTNAME || '') + '</span>' + "</td>" +
                        "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + middleText + "</td>" +
                        "<td style='width:auto;position:relative;padding:0;margin:0;'><i class='fa fa-caret-right spanCls'></i></td>" +
                        "</tr>" +
                        "</table>"
                    );

                    $tbldiv.append($divCaption);

                    // First row: Result Date and Result No
                    var $firstRow = $('<div class="first-row" style="display:flex;margin-bottom:10px;"></div>');
                    //  $firstRow.append('<h5 style="font-weight:bold;">Result Date/Time:</h5> <h5 style="margin-right: 57%;">' + (formattedDate + ' ' + result.RESULTTIME || '') + '</h5>');
                    $firstRow.append('');
                    $tbldiv.append($firstRow);

                    // Second row: Test Name
                    var $secondRow = $('<div class="second-row"></div>');
                    // $firstRow.append('<h4 class="TestName" style="font-weight:bold;font-size:16px;">Test Name:</h4> <h4 style="font-size:16px;">' + (result.TESTNAME || '') + '</h4>');
                    $tbldiv.append($secondRow);

                    var $tblVitalHistory = $('<table class="table" style="width: 95%; border-collapse: collapse; border: 1px solid #afadad; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);"></table>');

                    // Create table headers
                    var $th = "<thead><tr style='background-color:#e3f4fb;'><th>Antibiotics</th><th>MIC</th><th>Interpretation</th></tr></thead>";
                    $tblVitalHistory.append($th); // Append headers to tblVitalHistory
                    var $tbody = $("<tbody></tbody>"); // Create tbody for table data

                    // Add table rows with result details
                    var rows = "";
                    $.each(result.CultureResults, function (i, item) {
                        var cultypeStyle = (item.CULTYPE === "O") ? "font-size:15px; color:yellowgreen;" : "";
                        rows += "<tr>" +
                            "<td style='width:20%;" + cultypeStyle + "'>" + item.ANTIBIOTIC + "</td>" +
                            "<td style='width:20%;'>" + item.MICVALUE + "</td>" +
                            "<td style='width:20%;'>" + item.Column1 + "</td>" +
                            "</tr>";
                    });

                    $tbody.append(rows);
                    $tblVitalHistory.append($tbody); // Append tbody to tblVitalHistory

                    // Append tblVitalHistory to tbldiv
                    $tbldiv.append($tblVitalHistory);

                    var $footerInfoDiv = $('<div class="footerInfo" style="margin-top:0px;padding:5px;background-color:#f0f0f1;box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);"></div>');
                    //$footerInfoDiv.append('<div style="display:flex;margin-bottom:10px;">' +
                    //    '<h5 style="font-weight:bold;font-size:14px;">Verify Date/Time:</h5> <h5 style="margin-right: 58%;font-size:14px;">' + (formatDate(result.VERIFIEDON) + '  ' + result.VERIFIEDAT || '') + '</h5>' +
                    //    '<h5 style="font-weight:bold;font-size:14px;float:right;">Verify By:</h5> <h5 style="font-size:14px;">' + (result.VERIFIEDBY || '') + '</h5>' +
                    //    '</div>');
                    //$footerInfoDiv.append('<span style="font-weight:bold;font-size:14px;">Culture Comment:</span> <span style="font-size:14px;">' + result.CULTCOMMENT || '' + '</span>');

                    $footerInfoDiv.html(
                        "<table style='width:100%;color:black;'>" +
                        "<tr>" +
                        "<td style='width:33.33%;position:relative;padding:0;margin:0;font-size:12px;'>" + "<span style='font-weight:bold;font-size:14px;'>Verify Date/Time:</span>" + (formatDate(result.VERIFIEDON) + '  ' + result.VERIFIEDAT || '') + "</td>" +
                        "<td style='width:33.33%;position:relative;padding:0;margin:0;font-size:12px;'>" + "<span style='font-weight:bold;font-size:14px;'>Verify By:</span>" + (result.VERIFIEDBY || '') + "</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td colspan='2' style='position:relative;padding:0;margin:0;margin-top:5px;font-size:12px;'>" +
                        "<span style='font-weight:bold;font-size:14px;'>Culture Comment:</span> <span style='font-size:14px;'>" + (result.CULTCOMMENT || '') + "</span>" +
                        "</td>" +
                        "</tr>" +
                        "</table>"
                    );


                    $tbldiv.append($footerInfoDiv);

                    // Append footerInfoDiv to tbldiv - 
                    $tbldiv.append($footerInfoDiv);

                    // Append tbldiv to the parent container - 
                    $("#container").append($tbldiv);

                    $divCaption.click(function () {
                        var $tbldiv = $(this).closest('.tbldiv');
                        var $table = $tbldiv.find('.table');
                        var $firstRow = $tbldiv.find('.first-row');
                        var $footerInfoDiv = $tbldiv.find('.footerInfo');
                        var $icon = $(this).find('.spanCls');
                        var $secondrow = $(this).find('.second-row')

                        $table.toggle();
                        $firstRow.toggle();
                        $footerInfoDiv.toggle();
                        $secondrow.toggle();

                        // Rotate icon based on visibility 
                        $(this).toggleClass('open');
                    });

                    // Initially hide the table, firstRow, and footerInfoDiv content
                    $tbldiv.find('.table, .first-row, .second-row ,.footerInfo').hide();

                } else {
                    // Handle scenario when no data is found
                    $("#container").empty().append("<div>No data available</div>"); // Replace #container with your parent element ID or class
                }
            }

            // Added by Dhananjay 20240712 - 
            function formatDate(yyyymmdd) {
                var year = yyyymmdd.substring(0, 4);
                var month = parseInt(yyyymmdd.substring(4, 6), 10) - 1;
                var day = yyyymmdd.substring(6, 8);

                // Create a new Date object
                var date = new Date(year, month, day);

                var options = { year: 'numeric', month: 'long', day: 'numeric' };

                // Format the date using toLocaleDateString
                return date.toLocaleDateString('en-US', options);
            }
            
            function getOutsideReportService() {
                var strMRNO = '<%=ViewBag.PATMRNO%>';
                
                $.ajax({
                    type: 'GET',
                    url: GetApiUrl("DoctorDesk","GetLabAttachment"),
                    datatype: 'json',
                    data: { MRNO: strMRNO, strUnit: GUnitCode },
                    success: function (response) {
                        if (response && response.length > 0) {
                            showLabFiles(response);
                        } else {
                            $("#outRptPresent").hide();
                        }
                    },
                    error: function (xhr, status, error) {
                        $('#NoRecord').show();
                    },
                  
                });
            }
            function showLabFiles(File) {
                if (File != null) {
                    if (File.length >= 1) {
                        $('#tbl1 tbody').empty();
                        for (i = 0; i < File.length; i++) {
                            var rows = "<tr> <td class='disp' style='cursor:pointer' onclick='openLabNewWin(this)'><u>" + File[i] + "</u></td><tr>";
                            $('#tbl1 tbody').append(rows);
                        }
                        $("#outRptPresent").show();
                    }
                    else
                        $("#outRptPresent").hide();
                }
                else
                    $("#outRptPresent").hide();
            }
            function openLabNewWin(obj) {
                NAME = obj.innerText;
                var MRNO = '<%=ViewBag.PATMRNO%>';
                var url = GetApiUrl("DoctorDesk", "LabFileDownload") + "?MRNo=" + MRNO + "&&filename=" + NAME + "&&strUnit=" + GUnitCode
                window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
                //var Details = '<a href=' + url + ' id="imgdownload" download=' + NAME + '>Download file</a>';
                return Details;
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

            function loadInvestigationReport(Mrno) {
                checkNoRecordClass();
                $(".tableDivInvestig").css('display', 'block')
                $(".tableDivDateWise").css('display', 'none')
                $(".tableDivAbnormal").css('display', 'none')
                $(".tableTrends").css('display', 'none')
                $.ajax({
                    type: 'post',
                    url: GetApiUrl("DoctorDesk", "GetInvestigationResult"),
                   
                    cache: false,
                    dataType: "json",
                    data: { mrNo: Mrno },
                    async: false,
                    success: function (response) {

                        if (response != "Unsucessfull") {
                            $("#tblInvestigationChart").empty();

                            if (response == "No Data Found" || response == "") {
                                //$.messager.alert("Information", "No Data Found");
                                //  var emptyRow = "<tr style='background-color: #3c8dbc;color: white;'><td>No Data Found</td></tr>";
                                //$("#tblInvestigationChart").append(emptyRow);

                                $('#fixedTable').hide();
                                //var NorecordDiv = $('.NoRecord')
                                //if ($(NorecordDiv).hasClass('hide')) {
                                //    $(NorecordDiv).removeClass('hide')
                                //}
                                $('#NoRecordInv').show();
                            }
                            else {
                                $('#NoRecordInv').hide();
                                console.log(response);

                                result = JSON.parse(response);
                                localStorage.setItem('IsInvestigationData', true);
                                $("#tblInvestigationChart").append('<thead></thead><tbody></tbody>')
                                var strdynamicDate = "";
                                for (var H = 0; H < result.TblDate.length; H++) {
                                    strdynamicDate += "<th class='dateColumn'>" + result.TblDate[H].DATETIME + "</th>";
                                }

                                var thead = "<tr class='sticky-row'><th class='first sticky-cell'>Test Name</th><th class='second sticky-cell'>Investigation</th><th class='sticky-cell'>Normal Range</th>" + strdynamicDate + "</tr>";
                                $("#tblInvestigationChart thead").append(thead);
                                var row = '';
                                for (var D = 0; D < result.Investigate.length; D++) {
                                    var dateResult = "";
                                    for (var H = 0; H < result.TblDate.length; H++) {
                                        var DateOf = result.TblDate[H].DATETIME
                                        dateResult += "<td class='dateColumn'>" + (result.Investigate[D][DateOf] != null ? result.Investigate[D][DateOf] : "") + "</td>";
                                    }

                                    row += "<tr class='GridViewScrollItem'><td class='testNameCls first sticky-cell'>" + result.Investigate[D]["TESTNAME"].toString().trim() + "</td><td class='second sticky-cell'>" + result.Investigate[D]["INVESTDESC"].toString().trim() + "</td><td class='sticky-cell'>" + result.Investigate[D]["NORMRANGE"].toString().trim() + "</td>" + dateResult + "</tr>";
                                }
                                $("#tblInvestigationChart tbody").append(row);
                                $('#NoRecordInv').hide();
                            }
                        }
                    },
                    complete: function (data) {

                        groupTable($('#tblInvestigationChart tr:has(td)'), 0, 1);  // tr:has(td)
                        $('#tblInvestigationChart .deleted').remove();

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //$.messager.alert("Information", "An error occurred while processing your request.");

                    }
                });


            }
            function enhance() {
                gridViewScroll.enhance();
            }

            function groupTable($rows, startIndex, total) {
                if (total === 0) {
                    return;
                }
                var i, currentIndex = startIndex, count = 1, lst = [];
                var tds = $rows.find('td:eq(' + currentIndex + ')');
                var ctrl = $(tds[0]);
                lst.push($rows[0]);
                for (i = 1; i <= tds.length; i++) {
                    if (ctrl.text() == $(tds[i]).text()) {
                        count++;
                        $(tds[i]).addClass('deleted');
                        lst.push($rows[i]);
                    }
                    else {
                        if (count > 1) {
                            ctrl.attr('rowspan', count);
                            groupTable($(lst), startIndex + 1, total - 1)
                        }
                        count = 1;
                        lst = [];
                        ctrl = $(tds[i]);
                        lst.push($rows[i]);
                    }
                }
            }
            function checkNoRecordClass() {
                //var NorecordDiv = $('.NoRecord')
                //if (!$(NorecordDiv).hasClass('hide')) {
                //    $(NorecordDiv).addClass('hide')
                //}

            }
            function tablegeneration(result, datafilter, idval) {

                var finalFilterdata = jQuery.grep(result.Table, function (a, index) {
                    return (a.INVESTDESC == datafilter);
                });
                var selector = '#my_test_' + idval;
                var element = $(selector);
                element.append('<div class="box" style="margin-bottom:6px"><div class="box-body table-responsive no-padding"><table class="table table-hover" style="text-align:center;" id="table_' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

                var tableElementSelect = '#table_' + idval;
                var tableElement = $(tableElementSelect)
                var headerRow = $(tableElement).children('thead').children('tr:first')
                var BodyRow = $(tableElement).children('tbody').children('tr:first')

                $.each(finalFilterdata, function (Uniq, item) {
                    headerRow.append(
                        '<th style="text-align:center;padding:4px !important;">' + item.RESULTDATE + '</th>'
                    );
                });

                $.each(finalFilterdata, function (index, item) {
                    BodyRow.append(
                        '<td style="text-align:center;padding:4px !important;">' + '<span class="' + item.ABNORMAL + '">' + item.RESULTDT + '</span>' + '</td>'
                    );
                });
            }
            function tableGenteAbnormalData(result, datafilter, idval) {
                var AbnormFinalData = jQuery.grep(result.Table, function (j, k) {
                    return (j.INVESTDESC == datafilter && j.ABNORMAL == 'Y');
                });
                var selector = '#abnormal_' + idval;
                var element = $(selector);

                if (AbnormFinalData.length > 0) {
                    element.append('<div class="box"><div class="box-body table-responsive no-padding"><table class="table table-hover" id="table_Abn' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

                    var tableElementSelect = '#table_Abn' + idval;
                    var tableElement = $(tableElementSelect)
                    var headerRow = $(tableElement).children('thead').children('tr:first')
                    var BodyRow = $(tableElement).children('tbody').children('tr:first')

                    $.each(AbnormFinalData, function (j, item) {
                        headerRow.append(
                            '<th style="text-align:center;padding:4px !important;">' + $.trim(item.RESULTDATE) + '</th>'
                        );
                    });

                    $.each(AbnormFinalData, function (i, item) {
                        BodyRow.append(
                            '<td style="text-align:center;padding:4px !important;">' + '<span class="' + item.ABNORMAL + '">' + $.trim(item.RESULTDT) + '</span>' + '</td>'
                        );
                    });
                }
                else {
                    element.css('display', 'none')
                }
            }
            function tableGenteDatewiseData(result, datafilter, idval) {
                var DateWiseData = jQuery.grep(result.Table, function (j, k) {
                    return (j.RESULTDATE == datafilter);
                });
                var selector = '#DateWiseDiv_' + idval;
                var element = $(selector);
                element.append('<div class="box"><div class="box-body table-responsive no-padding"><table class="table table-hover" id="table_Datewise' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

                var tableElementSelect = '#table_Datewise' + idval;
                var tableElement = $(tableElementSelect)
                var headerRow = $(tableElement).children('thead').children('tr:first')
                var BodyRow = $(tableElement).children('tbody').children('tr:first')

                $.each(DateWiseData, function (j, item) {
                    headerRow.append(
                        '<th style="text-align:center;padding:4px !important;">' + $.trim(item.INVESTDESC) + '</th>'
                    );
                });

                $.each(DateWiseData, function (i, item) {
                    BodyRow.append(
                        '<td style="text-align:center;padding:4px !important;">' + '<span class="' + item.ABNORMAL + '">' + $.trim(item.RESULTDT) + '</span>' + '</td>'
                    );
                });
            }

            function tableTrendsLineData(result, datafilter, idval) {
                var finalFilterdata = jQuery.grep(result.Table, function (a, index) {
                    return (a.INVESTDESC == datafilter);
                });

                /*----------------------labeldata-------------------------------------------------------*/
                var lablelval = $(finalFilterdata).map(function (idex, val) {
                    return (val.RESULTDATE);
                }).get().join(',');

                var temp = new Array();
                temp = lablelval.split(",");

                /*----------------------labeldata-------------------------------------------------------*/

                /*----------------------Resultdata-------------------------------------------------------*/

                var actulD = $(finalFilterdata).map(function (idex, val) {
                    return $.trim(parseFloat(val.RESULTDT));
                }).get().join(',')

                var Actualdata = new Array();
                Actualdata = actulD.split(",");

                /*----------------------Resultdata-------------------------------------------------------*/

                var Norm1 = $(finalFilterdata).map(function (idex, val) {
                    return $.trim(parseFloat(val.NORMALVAL1));
                }).get().join(',')

                var normalData1 = new Array();
                normalData1 = Norm1.split(",");
                console.log(normalData1);

                var Normdata1 = new Array();
                for (var m = 0; m < finalFilterdata.length; m++) {
                    Normdata1.push(normalData1[0])
                }

                var Norm2 = $(finalFilterdata).map(function (idex, val) {
                    return $.trim(parseFloat(val.NORMALVAL2));
                }).get().join(',')

                var normalData2 = new Array();
                normalData2 = Norm2.split(",");

                var Normdata2 = new Array();
                for (var m = 0; m < finalFilterdata.length; m++) {
                    Normdata2.push(normalData2[0])
                }


                var selector = '#line-chart' + idval
                var lineChartData = {
                    labels: temp,
                    datasets: [
                        {
                            label: "My dataset",
                            fillColor: "rgba(255,255,255,0)",
                            strokeColor: "#120dd6",
                            pointColor: "#120dd6",
                            pointStrokeColor: "#120dd6",
                            pointHighlightFill: "#120dd6",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: Actualdata
                        },

                        {
                            label: "My dataset",
                            fillColor: "rgba(255,255,255,0)",
                            strokeColor: "#dd4b39",
                            pointColor: "#dd4b39 ",
                            pointStrokeColor: "#dd4b39",
                            pointHighlightFill: "#dd4b39",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: Normdata2
                        }, {
                            label: "My dataset",
                            fillColor: "rgba(255,255,255,0)",
                            strokeColor: "#f6ea0a",
                            pointColor: "#f6ea0a ",
                            pointStrokeColor: "#f6ea0a",
                            pointHighlightFill: "#f6ea0a",
                            pointHighlightStroke: "rgba(220,220,220,1)",
                            data: Normdata1
                        }
                    ]
                }


                var lineChart = $(selector).get(0).getContext("2d")

                window.lineChart = new Chart(lineChart).Line(lineChartData, {
                    scaleShowGridLines: false,
                    bezierCurve: false,
                    scaleFontSize: 11,
                    scaleFontStyle: "normal",
                    scaleFontColor: "#fff",
                    responsive: true,
                    pointDotRadius: 1,
                    pointDotStrokeWidth: 3,
                    pointLabelFontSize: 10,
                    tooltipFontSize: 10,
                    tooltipFontStyle: "normal",
                });

            }

            function BindAbNormalData() {
                checkNoRecordClass();
                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();
                $.ajax({
                    
                    type: 'post',
                    url: GetApiUrl("DoctorDesk", "GetInvestigation"),
                       
                    cache: false,
                    dataType: "json",
                    data: { mrNo: Mrno, strFrmDate: frmDate, strTodate: toDate },
                    async: false,
                    success: function (response) {
                        // Hide No Record initially
                        $('#NoRecordAbnormal').hide();

                        // Clear only dynamically appended abnormal divs
                        $('.tableDivAbnormal').find('div[id^="abnormal_"]').remove();

                        if (response != "Unsucessfull") {
                            var resultAbnormal = JSON.parse(response);
                            var mainAbNdiv = $('.tableDivAbnormal');
                            var filterAbnormal = '';
                            //localStorage.setItem('IsAbnoramlData', true);

                            $.each(resultAbnormal.INVESTDESC, function (i, v) {
                                mainAbNdiv.append('<div class="" id="abnormal_' + (i) + '">'
                                    + '<div style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.INVESTDESC + ' </label><div></div>');
                                filterAbnormal = v.INVESTDESC;
                                tableGenteAbnormalData(resultAbnormal, filterAbnormal, i);
                                filterAbnormal = ''
                            });

                            $('#NoRecordAbnormal').hide();
                        }
                        else {
                            //var NorecordDiv = $('.NoRecord')
                            //if ($(NorecordDiv).hasClass('hide')) {
                            //    $(NorecordDiv).removeClass('hide')
                            //}
                            $('.tableDivAbnormal').show();
                            $('#NoRecordAbnormal').show();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //$.messager.alert("Information", "An error occurred while processing your request.");

                    }
                });
            }

            function BindDatewiseInvest() {
                checkNoRecordClass();
                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();
                $.ajax({
                    
                    type: 'post',
                    url: GetApiUrl("DoctorDesk", "GetDateWiseInvestigation"),
                      
                    cache: false,
                    dataType: "json",
                    data: { mrNo: Mrno, strFrmDate: frmDate, strTodate: toDate },
                    async: false,
                    success: function (response) {
                        $('#NoRecordAbnormal').hide();
                        $('.tableDivDateWise').find('div[id^="DateWiseDiv_"]').remove();

                        if (response != "Unsucessfull") {

                            var resultDateWise = JSON.parse(response);   // ← CHANGE 1

                            var mainDateWisediv = $('.tableDivDateWise');
                            var filterAbnormal = '';

                            $.each(resultDateWise.RESULTDATE, function (i, v) {
                                mainDateWisediv.append('<div class="" id="DateWiseDiv_' + (i) + '">'
                                    + '<div style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label><div></div>');
                                filterAbnormal = v.RESULTDATE;
                                tableGenteDatewiseData(resultDateWise, filterAbnormal, i);
                                filterAbnormal = ''
                            });
                            $('#NoRecordDateWise').hide();
                        }

                        else {
                            $('.tableDivDateWise').show();
                            $('#NoRecordDateWise').show();
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //$.messager.alert("Information", "An error occurred while processing your request.");

                    }
                });
            }

            function BindTemplRptData() {
                checkNoRecordClass();
                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();
                $.ajax({
                    type: 'post', 
                    url: GetApiUrl("DoctorDesk", "GetTemplateResult"),
                       
                    cache: false,
                    dataType: "json",
                    data: { mrNo: Mrno, strFrmDate: frmDate, strTodate: toDate },
                    async: false,
                    success: function (response) {
                        $('#NoRecordOthTemp').hide();
                        $('.tableOthTempRpt').find('div[id^="TmpRptDtWise_"]').remove();
                        if (response != "Unsucessfull") {
                            var resultDateWise = JSON.parse(response);
                            var mainDateWisediv = $('.tableOthTempRpt');
                            $.each(resultDateWise.Table, function (i, v) {
                                mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label></div>');
                                mainDateWisediv.append('<div class="parent" id="TmpRptDtWise_' + (i) + '" onClick="selectText(this.id);" > ');
                                v.RESULTDT = v.RESULTDT.replace(/<link[^>]*href="data:text\/css[^"]*"[^>]*>/i, '');
                                $("#TmpRptDtWise_" + (i)).html(v.RESULTDT);
                                mainDateWisediv.append('</div><div style="font-size: 13px !important;"><div class="parent" id="TmpRptAmentDtWise_' + (i) + '">');
                                $("#TmpRptAmentDtWise_" + (i)).html(v.Ammendments);
                                mainDateWisediv.append('</div><div style="float:left;" class="" id="TmpRptVerifiedDtWise_' + (i) + '">');
                                $("#TmpRptVerifiedDtWise_" + (i)).html("<b>Verified By : " + v.VERIFIEDBY + "</b>");
                                mainDateWisediv.append('</div><div style="margin-left : 50px ;float:left;" class="" id="TmpRprtByDtWise_' + (i) + '">');
                                $("#TmpRprtByDtWise_" + (i)).html("<b>Reported By : " + v.CREATEDBY + "</b>");
                                mainDateWisediv.append('</div></div></br><hr>');
                            });
                            //    $('#NoRecordDateWise').hide();
                        }

                        else {
                            //var NorecordDiv = $('.NoRecord')
                            //if ($(NorecordDiv).hasClass('hide')) {
                            //    $(NorecordDiv).removeClass('hide')
                            //}
                            //    $('#NoRecordDateWise').show();
                            $('.tableOthTempRpt').show();
                            $('#NoRecordOthTemp').show();
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $.messager.alert("Information", "An error occurred while processing your request.");
                    }
                });
            }

            //added on 24th july 2018
            function addMonths(date, months) {
                date.setMonth(date.getMonth() + months);
                return date;
            }

            //added on 24th July 2018
            function SetDateTime() {
                var today = new Date();
                var prevDate = addMonths(new Date(), -6);
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();

                var dd1 = prevDate.getDate();
                var mm1 = prevDate.getMonth() + 1;
                var yyyy1 = prevDate.getFullYear();
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }

                if (dd1 < 10) {
                    dd1 = '0' + dd1
                }
                if (mm1 < 10) {
                    mm1 = '0' + mm1
                }
                today = dd + '/' + mm + '/' + yyyy;
                prevDate = dd1 + '/' + mm1 + '/' + yyyy1;
                $("#RptFrmDate").val(prevDate);
                $("#RptToDate").val(today);

                $("#RptFrmDate").datepicker(
                    {
                        showButtonPanel: true,
                        changeMonth: true,
                        yearRange: "c-150:c+99",
                        changeYear: true,
                        dateFormat: "dd/mm/yy",
                        maxDate: new Date(),
                        onSelect: function (selected) {
                            if (new Date($('#RptFrmDate').datepicker('getDate')) > new Date($('#RptToDate').datepicker('getDate'))) {
                                $.alert("From date should be less then or equal to todate.", "Validation");
                            }
                        }
                    })

                $("#RptToDate").datepicker(
                    {
                        showButtonPanel: true,
                        changeMonth: true,
                        yearRange: "c-150:c+99",
                        changeYear: true,
                        dateFormat: "dd/mm/yy",
                        maxDate: new Date(),
                        //minDate: admissiondate
                        onSelect: function (selected) {
                            if (new Date($('#RptToDate').datepicker('getDate')) < new Date($('#RptFrmDate').datepicker('getDate'))) {
                                $.alert("To date should be greater then or equal to from date.", "Validation");
                            }
                        }
                    });

            }

            //added on 25th July 2018
            function GetTestList() {
                var frmDate = ""; var toDate = ""; var TestList = "";
                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();
                var strmrno = '<%=ViewBag.PATMRNO%>';
                $.ajax({
                    
                    type: 'post',
                    url: GetApiUrl("DoctorDesk", "GetTrendsTestCode"),
                     
                    cache: false,
                    dataType: "json",
                    data: { mrNo: strmrno, FrmDate: frmDate, ToDate: toDate },
                    async: false,
                    success: function (response) {

                        if (response != "Unsucessfull") {
                            $('#NoRecord').hide();
                            $("#chartNote").hide();
                            $("#divCharts").empty();
                            $('#lblTestName').text('');
                            $("#TestListDivHead").show();
                            ParseResult = JSON.parse(response);
                            $('#TestListDiv').children().remove();

                            $.each(ParseResult, function (I, E) {
                                var color = getRandomColor();
                                var TestName = E.TESTNAME;
                                var More = "";
                                if (TestName.length > 20) {
                                    More = "....."
                                }
                                var SummaryTestName = TestName.substring(0, 20);
                                TestList += '<div class="col-md-2 col-xs-6"><button id="' + E.TESTCODE + '" style="outline:none;background-color:' + color
                                    + ';width:140px;height:28px;color:#252020;font-weight:bold;font-size:11px;" title="' + TestName.toString().trim() + '"  class="btnTrend btnTrend-primary btnTrend-block" onclick="GetTestTrends(this)">' + SummaryTestName + More + '</button></div>'

                            });


                            $('#TestListDiv').append(TestList);

                        }
                        else {

                            $('#NoRecordTrend').show();
                            $('#TestListDiv').children().remove();
                            $("#chartNote").hide();
                            $("#TestListDivHead").hide();
                            $("#divCharts").empty();

                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //$.messager.alert("Information", "An error occurred while processing your request.");
                        $.alert({
                            title: 'Alert!',
                            content: 'An error occurred while processing your request !',
                        });
                    }
                });
            }

            //added on 25th July 2018
            function getRandomColor() {
                color = "hsl(" + Math.random() * 12000 + ", 30%, 60%)";
                return color;
            }
            //added on 25th July 2018
            function GetTestTrends(obj) {
                $('#lblTestName').text('');
                var TestCode = $(obj).attr('id');
                var TestName = $(obj)[0].title;//$(obj).text();
                GetTrendWiseData(TestCode)
                $('#lblTestName').text(" [" + TestName.toString().trim() + "] ");

            }
            //added on 25th July 2018
            function GetTrendWiseData(TestCode) {

                var frmDate = ""; var toDate = "";
                var frmDate = $("#RptFrmDate").val();
                var toDate = $("#RptToDate").val();
                var strmrno = '<%=ViewBag.PATMRNO%>';

                checkNoRecordClass(); 
                $.ajax({
                    type: 'post',
                    url: GetTBUrl("GetTrendsInvestigation"),
                    cache: false,
                    dataType: "json",
                    data: { mrNo: strmrno, TestCode: TestCode, strFrmDate: frmDate, strTodate: toDate },
                    async: false,
                    success: function (response) {
                        $('#chartNote').show();
                        var maindiv = $('.divSubList');
                        if (response != "Unsucessfull") {
                            var result = JSON.parse(response);
                            innerMainDiv = $(maindiv).find('div');
                            $(innerMainDiv).find('div').remove();
                            var datafilter;
                            //localStorage.setItem('IstTrendsData', true);
                            $.each(result.INVESTDESC, function (i, v) {
                                $(innerMainDiv).append('<div class="col-md-6" style="padding:1px !important" id="my_test_' + (i) + '">'
                                    + '<div class="card"><div class="card-content  teal darken-2"><div class="line-chart-wrapper"><p class="margin white-text" style="font-weight:400;font-size:13px">'
                                    + v.INVESTDESC + '</p><canvas height="77" width="203" style="width: 203px; height: 77px;"id="line-chart' + (i) + '"></canvas></div></div></div>');
                                datafilter = v.INVESTDESC;
                                tableTrendsLineData(result, datafilter, i)
                            });

                            //tooglediv();
                            //ajaxindicatorstop();
                        }
                        else {
                            //ajaxindicatorstop();
                            //$(maindiv).find('div').remove();
                            $.alert({
                                title: 'Alert!',
                                content: 'No records founds !',
                            });

                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //ajaxindicatorstop();
                        //  $.messager.alert("Information", "An error occurred while processing your request.");
                        $.alert({
                            title: 'Alert!',
                            content: 'An error occurred while processing your request !',
                        });
                    }
                });
            }


            function GetApiUrl(controller, action) {
                if (SetExternalUrl == "Y") {
                    return ExternalBaseUrl + "/" + controller + "/" + action;
                    
                } else {
                    return "../" + controller + "/" + action;
                }
            }
            //added on 25th July 2018
            function tooglediv() {
                var header = $("#TestListDivHead")
                $("#TestListDiv").slideToggle("slow");
                $("i", header).toggleClass("fa-plus-circle fa-minus-circle");
            }

            function saveRecommendations() {
                var recomm = $('#txtRecommendations').val();
                $.ajax({
                    url: "../TumorBoard/SaveExternalDoct",
                    type: 'POST',
                    data: { Recomm: recomm },
                    datatype: "json",
                    success: function (response) {
                        if (response.status == "Success") {
                            $('#txtRecommendations').prop('disabled', true);
                            $('#btnSaveRecommendations').hide();
                            $('#btnEditRecommendations').show();
                        }
                        else {
                            $("#txtRecommendations").val('');
                            $('#txtRecommendations').prop('disabled', false);
                            $('#btnSaveRecommendations').show();
                            $('#btnEditRecommendations').hide();
                        }
                        showSessionWarning(response.message);
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000);

                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                    }
                });

            }
            function EnableTextBox() {
                $('#txtRecommendations').prop('disabled', false);
                document.getElementById('btnSaveRecommendations').innerHTML = "Update";
                $('#btnSaveRecommendations').show();
                $('#btnEditRecommendations').hide();
            }
            function showSessionWarning(msg) {
                let warningDiv = document.getElementById('sessionWarning');
                if (!warningDiv) {
                    warningDiv = document.createElement('div');
                    warningDiv.id = 'sessionWarning';
                    warningDiv.style.position = 'fixed';
                    warningDiv.style.top = '10px';
                    warningDiv.style.right = '10px';
                    warningDiv.style.padding = '12px 20px';
                    warningDiv.style.background = '#ffcc00';
                    warningDiv.style.color = '#333';
                    warningDiv.style.fontFamily = 'Segoe UI, Tahoma, Geneva, Verdana, sans-serif';
                    warningDiv.style.fontSize = '14px';
                    warningDiv.style.fontWeight = '500';
                    warningDiv.style.borderRadius = '6px';
                    warningDiv.style.boxShadow = '0 4px 6px rgba(0,0,0,0.1)';
                    warningDiv.style.zIndex = 9999;
                    document.body.appendChild(warningDiv);
                }
                warningDiv.innerText = msg;
                warningDiv.style.display = 'block';

                setTimeout(function () {
                    warningDiv.style.display = 'none';
                }, 2000);
            }
            //Added By Roshan on 20-11-2025
            function GetBiposyReport() {
                const DataToSend = {
                    MrNo: Mrno,
                }
                $.ajax({
                    url: GetApiUrl("PatientClinicalHistory", "GetBiposyReport"),
                      
                    type: 'post',
                    datatype: 'json',
                    data: DataToSend,
                    async: false,
                    success: function (data) {

                        if (data.length > 0) {
                            if (data != null) {
                                BindBiposyTable(data);
                            }
                        }
                        //else {
                        //    if (data.length > 0) {
                        //        if (data[0]['DRREMARKS'] != "") {
                        //            $('#txtRecommendations').val(data[0]['DRREMARKS']);
                        //            $('#txtRecommendations').prop('disabled', true);
                        //            $('#btnSaveRecommendations').hide();
                        //            $('#btnEditRecommendations').show();
                        //        }
                        //        else {
                        //            $('#txtRecommendations').prop('disabled', false);
                        //            $('#btnSaveRecommendations').show();
                        //            $('#btnEditRecommendations').hide();
                        //        }
                        //    }
                        //}
                    },
                    complete: function () {

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                    }
                });

            }
            //Bind ICD-O Diagnosis Table
            function BindBiposyTable(Lst) {
                var Tr = "<tr>{TRCONTENT}</tr>";
                var Td = "<td {STYLE}>{TDCONTENT}</td>";
                $("#TableBiposyBody").empty();
                $.grep(Lst, function (a) {
                    var Code = a.TESTCODE;
                    var Desc = a.TESTNAME;
                    var Impress = a.IMPRESSIONDT;
                    var DoctName = a.DOCTNAME;
                    var ReportedBy = a.REPORTEDBY;
                    var VerifiedBy = a.VERIFIEDBY;
                    var ResultDate = a.RESULTDATE;
                    var ResultNo = a.RESULTNO;
                    var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                    var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                    var ImpressTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Impress);
                    var DoctNameTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", DoctName);
                    var ReportedByTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", ReportedBy);
                    var VerifiedByTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", VerifiedBy);
                    var ResultDateTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", ResultDate);
                    var ResultNotd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", ResultNo);
                    var RplTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd + ImpressTd + DoctNameTd + ReportedByTd + VerifiedByTd + ResultDateTd + ResultNotd);
                    $("#TableBiposyBody").append(RplTr);
                });
            }
        </script>
  
</body>
</html>
