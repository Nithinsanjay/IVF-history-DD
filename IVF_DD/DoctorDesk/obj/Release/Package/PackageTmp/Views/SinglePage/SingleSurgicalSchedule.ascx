<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script src="<%=ResolveUrl("~/Scripts/fullcalendar-6.1.17/dist/index.global.min.js")%>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/daygrid/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/timegrid/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/list/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/interaction/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/bootstrap5/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/js/jquery-ui-timepicker-addon.js") %>"></script>

<style type="text/css">
    #DivOverlay {
        height: 100%;
        width: 100%;
        position: fixed;
        top: 0;
        left:0;
        background-color: #80808085;
        z-index: 10000000000000000000000000000000000000;
        justify-content: center;
        align-items: center;
    }

        .MainDivAlertSave {
            background-color: white;
            max-width: 90vw;
            min-width: auto;
        }

        .MainDivHeaderAlert {
            background-color: #003b79;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            font-size: 14px;
            padding: 5px 0px;
        }

        .MainAlertHeadLbl {
            margin: 0;
            padding-left: 5px;
        }

        .MainAlertCloseIcon {
            padding-right: 5px;
            font-size: 20px;
            color: red;
            cursor:pointer;
        }
            .MainAlertCloseIcon:hover {
                color: white;
            }

        .MainDivContentAlert {
            padding: 10px;
            max-height: 70vh; /* You can adjust this as needed */
            overflow-y: auto;
        }

        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .fancy-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

            .fancy-table thead {
                background: #4CAF50;
                color: white;
            }

            .fancy-table th, .fancy-table td {
                padding: 12px 15px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                border-right: 1px solid #ddd;
            }

            .fancy-table tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .fancy-table tbody tr:hover {
                background-color: #f1f1f1;
                transition: 0.3s ease-in-out;
            }

        /* Responsive tweaks */
        @media screen and (max-width: 600px) {
            .fancy-table th, .fancy-table td {
                padding: 10px;
                font-size: 14px;
            }
        }

        .MainDivFooterAlert {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 7px;
            border-top: 1px solid #d3d3d3;
        }

    #Hist_C_SurgicalSchedule{
        height : 100%
    }

    /* Global Settings */
    :root {
        --primary-blue: #004b87;
        --light-blue: #eef3ff;
        --border-color: #d1d9e6;
        --text-color: #333;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* FullCalendar Overrides */
    .fc-col-header-cell-cushion {
        font-size: 18px !important;
        color: white !important;
        text-decoration: none !important;
    }

    .fc-col-header-cell {
        background-color: #2c3e50;
    }

    .fc-daygrid-day-number {
        color: #333;
        font-size: 15px;
        font-weight: 600;
        text-decoration: none !important;
    }

    .fc-event-main {
        font-size: 12px !important;
    }

    /* Mobile Calendar Fixes */
    @media (max-width: 768px) {
        .fc-header-toolbar {
            flex-direction: column;
            gap: 10px;
        }
        .fc-toolbar-chunk {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 5px;
        }
        .fc-toolbar-title { font-size: 1.2em !important; }
        .fc-col-header-cell-cushion { font-size: 14px !important; }
    }

    /* ================= MODAL STYLES ================= */
    .EModal, .AEModal {
        display: none; /* Toggled by JS */
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        background-color: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(2px);
        justify-content: center;
        align-items: center;
        align-items: center;
        height: 100%;
        width: 100%;
    }

    /* Modal Content Box */
    .modal-content, .Amodal-content {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        display: flex;
        flex-direction: column;
        overflow: hidden;
        margin: auto;
        position: relative;
    }

    .modal-content{
            max-width: 600px;
    }

    .EModal {
        width: 100%;
        height: 100%;
    }

    /* Approval List Modal Specifics - Make it wider and taller */
    .Amodal-content {
        width: 100%;
        height: 100%;
    }

    .ModelHeaderDiv {
        background-color: var(--primary-blue);
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 15px;
        font-size: 16px;
        font-weight: 600;
        flex-shrink: 0; /* Header never shrinks */
    }

    .ModelContentDiv {
        padding: 15px;
        display: flex;
        flex-direction: column;
        flex-grow: 1; /* Fills remaining space */
        overflow: hidden; /* Prevent double scrollbars, let inner wrapper scroll */
    }

    /* CLOSE ICON FIX */
    #closeModalBtn, #closeAModalBtn, .CloseIcon {
        cursor: pointer;
        font-size: 24px;
        color: white !important; /* Ensure white color */
        opacity: 0.9;
        transition: 0.2s;
        min-width: 24px; /* Prevent crushing on mobile */
        text-align: right;
    }
    #closeModalBtn:hover, .CloseIcon:hover { opacity: 1; transform: scale(1.1); }

    /* ================= SCROLLABLE TABLE STYLES ================= */
    
    /* 1. The Wrapper: Handles scrollbars */
    .table-scroll-wrapper {
        flex-grow: 1; /* Expand to fill space between header and footer */
        overflow: auto; /* Enables BOTH horizontal and vertical scrolling */
        border: 1px solid #dcdcdc;
        border-radius: 4px;
        background: #fff;
        margin-bottom: 10px;
    }

    /* 2. The Table: Forced Width for Horizontal Scroll */
    table.tblAdviceList {
        width: 100%;
        min-width: 1300px; /* FORCE HORIZONTAL SCROLL: Ensure table is wide enough */
        border-collapse: separate; /* Required for sticky header borders */
        border-spacing: 0;
        font-size: 13px;
    }

    /* 3. Sticky Header: Stays fixed while scrolling vertically */
    table.tblAdviceList thead th {
        position: sticky;
        top: 0;
        z-index: 10;
        background-color: #2c3e50;
        color: white;
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #ddd;
        white-space: nowrap;
    }

    /* 4. Cells */
    table.tblAdviceList td {
        padding: 8px 10px;
        border-bottom: 1px solid #e0e0e0;
        border-right: 1px solid #e0e0e0;
        vertical-align: middle;
        background-color: #fff;
    }

    table.tblAdviceList tbody tr:nth-child(even) td { background-color: #f8f9fa; }
    table.tblAdviceList tbody tr:hover td { background-color: #eef3ff; }

    /* ================= FORM & INPUTS ================= */
    .ModelLbl {
        font-weight: 600;
        color: #444;
        font-size: 13px;
    }
    
    input[type="text"], textarea, .form-control {
        width: 100%;
        padding: 6px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 13px;
    }

    .form-row {
        display: flex;
        margin-bottom: 10px;
        align-items: center;
        flex-wrap: wrap;
    }
    .form-col-label { width: 140px; flex-shrink: 0; }
    .form-col-input { flex-grow: 1; min-width: 200px; }

    /* ================= LEGEND & FOOTER ================= */
    .leg-wrapper {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        padding: 12px 15px;
        background-color: #fff;
        border-top: 1px solid #e0e0e0;
        border-bottom: 1px solid #e0e0e0;
        margin: 10px 0;
    }
    
    .leg-group {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }

    .leg-item {
        display: flex;
        align-items: center;
        gap: 6px;
        white-space: nowrap;
        font-size: 13px;
        font-weight: 500;
        color: #444;
    }

    .leg-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        flex-shrink: 0;
    }
    
    /* Buttons */
    .btn-action {
        padding: 8px 20px;
        border: none;
        border-radius: 6px;
        color: white !important;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.1s;
        min-width: 100px;
    }
    .btn-action:hover { transform: translateY(-1px); }
    .btn-blue { background: #008bce; }
    .btn-red { background: #dc3545; }
    
    /* Status Icons */
    .AcceptStatus { color: #28a745; font-size: 16px; }
    .CancelStatus { color: #dc3545; font-size: 16px; }

    /* Badges */
    .verified-badge {
        display: inline-block; width: 14px; height: 14px; background: #009aff; border-radius: 50%;
        position: relative;
    }
    .verified-badge::before {
        content: ""; position: absolute; top: 3px; left: 4px; width: 6px; height: 9px;
        border: solid white; border-width: 0 2px 2px 0; transform: rotate(45deg);
    }
    
    .not-verified-badge {
        display: inline-block; width: 14px; height: 14px; background: #19a502; border-radius: 50%;
        position: relative;
    }
    .not-verified-badge::before, .not-verified-badge::after {
        content: ""; position: absolute; top: 6px; left: 3px; width: 8px; height: 2px; background: white;
    }
    .not-verified-badge::before { transform: rotate(45deg); }
    .not-verified-badge::after { transform: rotate(-45deg); }

    .Fit { color: #28a745; font-weight: bold; }
    .FitRisk { color: #b16d00; font-weight: bold; }
    .UnFit { color: #dc3545; font-weight: bold; }

    /* Mobile specific adjustments */
    @media (max-width: 600px) {
        .leg-wrapper { flex-direction: column-reverse; align-items: stretch; }
        .leg-group { justify-content: center; margin-bottom: 10px; }
        .btn-action { width: 100%; }
        .form-row { flex-direction: column; align-items: flex-start; }
        .form-col-label { margin-bottom: 4px; }
        .form-col-input { width: 100%; }
        
        /* Modal Footer on Mobile */
        #DivApproSaveBtn { flex-direction: column; gap: 10px; }
        #DivApproSaveBtn input { width: 100% !important; }
        #DivApproSaveBtn div { justify-content: center; }
    }
   .fc-list-event-dot {/*vandana 180226 hide bz it is showing by default confusing clor for tumor in calendar list */
display: none !important;
    }
    /*Abhishesh || 20260820*/
    .nsurgery {
        display: flex;
        width: 100%;
        justify-content: space-between;
    }


    
    /*Abhishesh || 20260821 - keep toggle pinned right regardless of filter row visibility; strip shared stat-filter-row box styling*/
    .nsurgery .btn-group {
        margin-left: auto;
    }

    .nsurgery .stat-filter-row {
        border: none !important;
        box-shadow: none !important;
        background: transparent !important;
        padding: 0 !important;
        margin: 0 !important;
    }
    /*End*/
    .Surgical {
        flex: 0 0 auto;
        width: auto;
        margin-top: -23px;
    }

    #SurgicalUnallocatedPatTable {
        max-height: 500px;
        overflow-y: auto; 
    }
    /*End*/
</style>


<script type="text/javascript">
    var calendar;
    var AllEventDtls = [];
    var FData = [];
    var ApprovelList = [];
    var SDocName = 'Dr. ' + gDoctName;
    var AllDoctLeaveDtls = [];
    var DoctInfoFlag = false;
    var surgicalunallocatedpatlisttable;
    $(document).ready(function () {
        $("#SurgicalUnallocatedPatDataDiv").hide();
        $(".SurgicalUnallocatedSrchPatDataDiv").hide();
        $('input[name="PatType"]').on("change", function () {
            //debugger;
            var isUnallocatedChecked = $('input[name="PatType"][value="U"]').is(":checked");

            if (isUnallocatedChecked) {
                $("#leg-wrapper_Div").addClass("d-none");
                $("#calendar").addClass("d-none");
                $("#SurgicalUnallocatedPatDataDiv").show();
                $(".SurgicalUnallocatedSrchPatDataDiv").show();
            } else {
                $("#leg-wrapper_Div").removeClass("d-none");
                $("#calendar").removeClass("d-none");
                $("#SurgicalUnallocatedPatDataDiv").hide();
                $(".SurgicalUnallocatedSrchPatDataDiv").hide();
            }
        });

        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0');
        var yyyy = today.getFullYear();
        var currentDate = yyyy + '-' + mm + '-' + dd;
  $('#SurgicalFromDt').val(currentDate);
  $('#SurgicalToDt').val(currentDate);
        //$("#SurgicalFromDt").attr("max", currentDate);
        //$("#SurgicalToDt").attr("max", currentDate);

        surgicalunallocatedpatlisttable = new Tabulator("#SurgicalUnallocatedPatTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "450", // Abhishesh || 20260819
            index: "code",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "Act",
                    field: "act",
                    width: 40,
                    headerSort: false,
                    formatter: function (cell) {
                        return "<i class='fa fa-edit text-primary edit-row' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        var rowData = cell.getRow().getData();
                        OpenPopupUnAllocatedPatient(rowData);
                    }
                },
                { title: "MR No", field: "MRNO", width: 100, headerFilter: "input" },
                { title: "Patient Name", field: "PATNAME", width: 250, formatter: "textarea", cssClass: "wrap-text", headerFilter: "input" },
                { title: "Patient Category", field: "PATCATGNM", width: 250, formatter: "textarea", cssClass: "wrap-text", headerFilter: "input" },//PRIYANKA 04/04/2026
                { title: "Surgery", field: "SURGERY", width: 300, headerFilter: "input" },
                { title: "Doctor Code", field: "DOCTCODE", width: 120, visible: false, headerFilter: "input" },
                { title: "Doctor Name", field: "DOCTNAME", width: 200, headerFilter: "input" },
                { title: "Doctor Approved", field: "DOCTORAPPROVAEDYN", width: 130, headerFilter: "input" },
                { title: "OT Book Y/N", field: "OTBOOKYN", width: 130, visible: false, headerFilter: "input" },
                { title: "OT Notes No", field: "OTNOTESNO", width: 120, visible: false, headerFilter: "input" },
                { title: "PAC Surg Adv Date", field: "PACSURGADVDATE", width: 150, visible: false, headerFilter: "input" },
                { title: "PAC Y/N", field: "PACYN", width: 100, headerFilter: "input" },
                { title: "Pre Auth Y/N", field: "PREAUTHYN", width: 120, headerFilter: "input" },
                { title: "Previous Surg Adv Date", field: "PREVSURGADVDATE", width: 150, visible: false, headerFilter: "input" },
                { title: "Scheme Codes", field: "SCHEMECODES", width: 150, visible: false, headerFilter: "input" },
                { title: "Surgery Adv Date", field: "SURGADVDATE", width: 150, visible: false, headerFilter: "input" },
                { title: "Surgery DateTime", field: "SURGYDATETIME", width: 150, visible: false, headerFilter: "input" },
                { title: "Transaction No", field: "TRANNO", width: 150, visible: false, headerFilter: "input" },
                { title: "Asterisk Level", field: "ASARISKLEVEL", width: 130, headerFilter: "input" },
                { title: "ACT", field: "ACT", width: 80, visible: false, headerFilter: "input" },
            ]

        });

        document.getElementById('SurgicalFromDt').addEventListener('change', function () {
            const fromDateValue = this.value;
            const toDateInput = document.getElementById('SurgicalToDt');

            toDateInput.min = fromDateValue;

            if (toDateInput.value && toDateInput.value < fromDateValue) {
                toDateInput.value = "";
            }
        });
        $('#chkDateSearch').on('change', function () {
            ToggleDateSearchMode();
        }).trigger('change');
    });

    function ToggleDateSearchMode() {
        var isChecked = $('#chkDateSearch').is(':checked');
        $('#SurgicalFromDt, #SurgicalToDt').prop('disabled', !isChecked);
        $('#lblSurgicalPatName').html(isChecked ? 'Patient Name' : 'Patient Name <span style="color:red;">*</span>');
    }
    function initializeCalendar() {
        CalenderActionType = "Y";
        //debugger;
        document.getElementById("btnContinueCalender").style.display = CalenderActionType == "Y" ? "none" : "inline-block";
        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            selectable: true,
            editable: true,
            eventDurationEditable: false,
            contentHeight: '90%', // or use fixed height
            height: '90%', // optional
            events: AllEventDtls,
            datesSet: function (info) {
                const fromDate = info.startStr.includes('T') ? info.startStr.split('T')[0] : info.startStr;
                const toDate = info.endStr.includes('T') ? info.endStr.split('T')[0] : info.endStr;
                GetCalenderData(fromDate, toDate);
            },
            headerToolbar: {
                left: 'dayGridMonth,dayGridWeek,listWeek',//,customListView', //timeGridDay
                center: 'title',
                right: 'prev,next'
            },
            //views: {
            //    customList: {
            //        type: 'list',
            //        buttonText: 'Custom List',
            //        content: function (arg) {
            //            return buildCustomListHtml(arg);
            //        }
            //    }
            //},
            buttonText: {
                today: 'Today',
                month: 'Month',
                week: 'Week',
                //day: 'Day',
                list: 'List'
            },
            eventContent: function (arg) {
                var tooltipLines = [];
                const event = arg.event;
                const Circle = document.createElement('span');
                Circle.style.display = 'inline-block';
                Circle.style.width = '10px';
                Circle.style.height = '10px';
                Circle.style.borderRadius = '50%';
                Circle.style.marginRight = '5px';
                Circle.style.flexShrink = '0';

                if (event.extendedProps) {
                    const props = event.extendedProps;
                    //var PACContent = props.PACYN == "F" ? "Fit" : (props.PACYN == "W" ? "Fit, with Accepted Risk" : (props.PACYN == "U" ? "Unfit" : ""));
                    var PACContent = props.PACYN == "F" ? "Fit" :
                        (props.PACYN == "W" && props.ASARISKLEVEL != "" ? "Fit, with Accepted Risk (" + props.ASARISKLEVEL + ")" :
                            (props.PACYN == "W" && props.ASARISKLEVEL == "" ? "Fit, with Accepted Risk" :
                                (props.PACYN == "U" ? "Unfit" : "")));//priyanka 20/11/2025
                    var PACTd = props.PACYN == "P" ? "❌" : (PACContent != "" ? PACContent : "✔️")

                    if (props.PACYN != "P" && (props.PREAUTHYN === "A" || (props.PREAUTHYN === "N" && props.SCHEMECODES == "")) && props.OTBOOKYN !== "P" && props.DOCTORAPPROVAEDYN === "Y") {
                        Circle.style.backgroundColor = '#00ff00';
                    } else if (props.PACYN != "P" || props.PREAUTHYN === "A" || props.OTBOOKYN !== "P" || props.DOCTORAPPROVAEDYN === "Y") {
                        Circle.style.backgroundColor = 'yellow';
                    } else {
                        Circle.style.backgroundColor = 'red';
                    }
                    tooltipLines.push(('Name : ') + (props.PATNAME));            /*vandana 160226*/
                    tooltipLines.push(('Pat Catg : ') + (props.PATCATG));   
                    tooltipLines.push(('Surgery Name : ') + (props.SURGERY));
                    if (props.SURGYDATETIME) {
                        tooltipLines.push('Surgery Date : ' + props.SURGYDATETIME);
                    }
                    tooltipLines.push(
                        ('PAC : ') + (PACTd),
                        ('Pre-Auth : ') + (props.SCHEMECODES == "" ? "NA" : (props.PREAUTHYN == "A" ? "✔️" : "❌")),
                        ('OT Booking : ') + (props.OTBOOKYN !== "P" ? "✔️" : "❌"),
                        ('Doctor Approved : ') + (props.DOCTORAPPROVAEDYN == "Y" ? "✔️" : "❌")
                    );
                }
                const title = document.createElement('span');
                title.innerText = event.title;
                title.style.overflow = 'hidden';
                title.style.textOverflow = 'ellipsis';
                title.style.whiteSpace = 'nowrap';
                title.style.flexGrow = '1';
                title.style.minWidth = '0';
                const container = document.createElement('div');
                container.style.display = 'flex';
                container.style.alignItems = 'center';
                container.style.overflow = 'hidden';
                container.style.width = '100%';
                container.title = tooltipLines.join('\n');
                container.appendChild(Circle);
                container.appendChild(title);
                return { domNodes: [container] };
            },
            dateClick: function (info) {
                if (DoctInfoFlag == false) {
                    var clickedDate = info.date;
                    GetAdvPatList(clickedDate);
                }
            },
            eventClick: function (info) {
                if (DoctInfoFlag == false) {
                    var event = info.event;
                    openEventModal(event.id, event.start);
                }
            },
            eventAllow: function (dropInfo, draggedEvent) {
                var now = new Date();
                now.setHours(0, 0, 0, 0);
                var draggedStart = new Date(draggedEvent.start);
                draggedStart.setHours(0, 0, 0, 0);
                var newStart = new Date(dropInfo.start);
                newStart.setHours(0, 0, 0, 0);
                var Flag = true;
                if (draggedStart < now || newStart < now) {
                    return false;
                }
                var eventId = draggedEvent.id;
                //if (CalenderActionType == "Y") {
                //    $.grep(AllEventDtls, function (a) {
                //        if (a.TRANNO == eventId && a.ACT != "N") {
                //            Flag = false;
                //        }
                //    });
                //}
                $.grep(AllEventDtls, function (a) {
                    if (a.TRANNO == eventId && a.OTBOOKYN != "P") {
                        Flag = false;
                    }
                });
                return Flag;
            },
            eventDrop: function (info) {
                const updatedDate = info.event.start.toLocaleDateString('en-CA');
                UpdateDataSendToSave(info.event.id, updatedDate, "");
            }
        });
        calendar.render();
    }

    function SetSurgyAdv() {
        var SpltDate = $("#txtAdviceDate").val().split('/');
        var start = SpltDate[2] + "-" + SpltDate[1] + "-" + SpltDate[0];
        UpdateDataSendToSave(sessionStorage.getItem("PatTRANNO"), start, $("#txtSurgeryAdvice").val(),
            sessionStorage.getItem("PatMRNO"), sessionStorage.getItem("PatName"), StrDocCode, SDocName.toString().trim());
    }

    function openEventModal(id, start) {
        $('#eventId').val(id);
        $('#eventStartDate').val(ConvertDateToFormat(start, false));
        $('#eventStartDate').prop('disabled', true);
        $('#eventTitle').prop('readonly', true);
        $('#tdPAC').empty();
        $('#tdPreAuth').empty();
        $('#tdOTBook').empty();
        $('#tdDoctAppr').empty();
        var AcceptIcon = "<i class='fa fa-check AcceptStatus' aria-hidden='true'></i>";
        var CancelIcon = "<i class='fa fa-times CancelStatus' aria-hidden='true'></i>";
        var NAIcon = "<label style='font-weight: bold;color: black;'>NA</label>";
        $.grep(AllEventDtls, function (e) {
            if (e.TRANNO == id) {
                var PACContent = e.PACYN == "F" ? "<label class='Fit'>Fit</label>" :
                    (e.PACYN == "W" ? "<label class='FitRisk'>Fit, with Accepted Risk (" + e.ASARISKLEVEL + ")</label>" :
                        (e.PACYN === "W") && (e.ASARISKLEVEL === "") ? "<label class='FitRisk'>Fit, with Accepted Risk</label>" :
                            (e.PACYN == "U" ? "<label class='UnFit'>Unfit</label>" : ""));
                var PACTd = e.PACYN == "P" ? CancelIcon : (PACContent != "" ? PACContent : AcceptIcon)
                $('#eventMRNO').val(e.MRNO);
                $('#eventPatName').val(e.PATNAME);
                $('#eventDoctor').val(e.DOCTNAME);
                $('#eventPACDate').val(e.PACSURGADVDATE == "" ? "" : ConvertDateToFormat(start, true));
                $('#eventTitle').val(e.SURGERY);
                $('#eventPatCatg').val(e.PATCATG);//priyanka 04/04/2026
                $('#tdPAC').append(PACTd);
                if (e.SCHEMECODES == "") {
                    $('#tdPreAuth').append(NAIcon);
                }
                else {
                    if (e.PREAUTHYN == "A")
                        $('#tdPreAuth').append(AcceptIcon);
                    else
                        $('#tdPreAuth').append(CancelIcon);
                }
                if (e.OTBOOKYN != "P")
                    $('#tdOTBook').append(AcceptIcon);
                else
                    $('#tdOTBook').append(CancelIcon);
                if (e.DOCTORAPPROVAEDYN == "Y")
                    $('#tdDoctAppr').append(AcceptIcon);
                else
                    $('#tdDoctAppr').append(CancelIcon);
            }
        });
        document.getElementById("tblAdviceListCont").style.display = "block";
        document.getElementById("SaveUnallactePat").style.display = "none";
        document.getElementById('eventModal').style.display = 'flex';
    }

    function ConvertDateToFormat(start, MinusFlag) {
        if (MinusFlag)
            start.setDate(start.getDate() - 1);
        var day = start.getDate();
        var month = start.getMonth() + 1;
        var year = start.getFullYear();
        day = day < 10 ? '0' + day : day;
        month = month < 10 ? '0' + month : month;
        var formattedDate = day + '/' + month + '/' + year;
        return formattedDate;
    }

    function ConvertStrDateToFormat(dateStr) {
        var start = new Date(dateStr);
        var day = start.getDate();
        var month = start.getMonth() + 1;
        var year = start.getFullYear();
        day = day < 10 ? '0' + day : day;
        month = month < 10 ? '0' + month : month;
        var formattedDate = day + '/' + month + '/' + year;
        return formattedDate;
    }

    function getPreviousDate(dateStr) {
        var date = new Date(dateStr);
        date.setDate(date.getDate() - 1);
        var year = date.getFullYear();
        var month = String(date.getMonth() + 1).padStart(2, '0');
        var day = String(date.getDate()).padStart(2, '0');
        return day + "/" + month + "/" + year;
    }

    function UpdateDataSendToSave(Id, Date, Title, Mrno, PatName, DoctCode, DoctName) {
        var Flag = false;
        $.grep(SendEventToSave, function (a) {
            if (a.TRANNO == Id) {
                a.SURGADVDATE = Date;
                Flag = true;
            }
        });
        if (Flag == false) {
            var Act = "N";
            var PrevDate = "";
            $.grep(AllEventDtls, function (e) {
                if (e.TRANNO == Id) {
                    Act = e.ACT;
                    Title = e.SURGERY;
                    Mrno = e.MRNO;
                    PatName = e.PATNAME;
                    DoctCode = e.DOCTCODE;
                    DoctName = e.DOCTNAME;
                    PrevDate = e.PREVSURGADVDATE;
                }
            });
            var NewEvent = {
                ACT: Act,
                TRANNO: Id,
                SURGADVDATE: Date,
                SURGERY: Title,
                MRNO: Mrno,
                PATNAME: PatName,
                DOCTCODE: DoctCode,
                DOCTNAME: DoctName,
                PREVSURGADVDATE: PrevDate
            }
            SendEventToSave.push(NewEvent);
        }
        FData = SendEventToSave.filter(function (item) { return item.ACT === 'N'; });
        //if (CalenderActionType == "Y") {
        //    $("#txtAdviceDate").val(ConvertStrDateToFormat(Date));
        //    $("#txtPACAdviceDate").val(getPreviousDate(Date));
        //}
    }

    function GetCalenderData(FromDate, ToDate) {
        var PatName = $("#SurgicalPatName").val() ? $("#SurgicalPatName").val().trim() : ""; // Added By Abhishesh || 20260820
        var DataToSend = {
            FDate: FromDate,
            TDate: ToDate,
            PatName: PatName // Added By Abhishesh || 20260820

        };
        $.ajax({
            url: '../DoctorDesk/GetScheduleCalenderDtls',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            success: function (Response) {
                var data = Response[0] == "" || Response[0] == null ? [] : Response[0].filter(function (item) { return item.SURGERY != "" && item.SURGERY != null; });
                var LData = Response[1] == "" || Response[1] == null ? [] : Response[1];
                DoctorLeaveInfoDtlsList(LData);
                AllEventDtls = [];
                //if ($("#txtSurgeryAdvice").val() != "" && CalenderActionType == "Y") {
                //    var TNo = sessionStorage.getItem("PatTRANNO");
                //    data = data.filter(function (item) { return item.TRANNO != TNo });
                //    SetSurgyAdv();
                //    FData = SendEventToSave.filter(function (item) { return item.ACT === 'N'; });
                //}
                AllEventDtls = AllEventDtls.concat(data);
                if (SendEventToSave.length > 0) {
                    const sendEventIds = SendEventToSave.map(function (a) { return a.TRANNO; });
                    const filteredAllEventDtls = AllEventDtls.filter(function (k) { return !sendEventIds.includes(k.TRANNO); });
                    AllEventDtls = filteredAllEventDtls.concat(SendEventToSave);
                }
                $.grep(AllEventDtls, function (a) {
                    a.id = a.TRANNO;
                    a.start = a.SURGADVDATE;
                    a.title = a.PATNAME;/*a.title = a.SURGERY;            vandana 160226*/ 
                    if (a.ACT == "N") {
                        a.DOCTORAPPROVAEDYN = "N";
                        a.OTBOOKYN = "P";
                        a.PACYN = "P";
                        a.PREAUTHYN = "N";
                        a.SURGYDATETIME = "";
                        a.backgroundColor = '#ffc107';
                        a.borderColor = '#ff9800';
                        a.textColor = '#000000';
                    }
                });
                calendar.removeAllEvents();
                calendar.addEventSource(AllEventDtls);
                calendar.render();
                applyDoctorLeaveIcons();
            },
            complete: function () {
            }
        });
    }

    function SaveCalenderData() {
        var CalenderData = SendEventToSave.map(function (item) {
            return {
                TRANNO: item.TRANNO,
                SURGADVDATE: item.SURGADVDATE,
                PACADVDATE: getPreviousDate(item.SURGADVDATE)
            };
        });
        var DataToSend = {
            Calender: JSON.stringify(CalenderData)
        }
        $.ajax({
            url: '../DoctorDesk/SaveScheduleCalender',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            success: function (data) {
                ToastMsg("Updated Successfully", "success");
                AllEventDtls = [];
                FData = [];
                ApprovelList = [];
                AllDoctLeaveDtls = [];
                DoctInfoFlag = false;
            },
            complete: function () {
            }
        });
    }

    function BeforeCloseValidation() {
        if (SendEventToSave.length > 0) {
            openPopup('Confirmation', 'Do You Want To Close ?', 'BeforeCloseValidationYes()', 'BeforeCloseValidationNo()')
        } else {
            BeforeCloseValidationNo()
        }
    }

    function BeforeCloseValidationYes() {

    }

    function BeforeCloseValidationNo() {

    }

    function OpenCloseAlert(Type, ID) {
        if (Type == "O") {
            document.getElementById("DivOverlay").style.display = "flex";
            document.getElementById(ID).style.display = "block";
        }
        else {
            document.getElementById("DivOverlay").style.display = "none";
            document.getElementById(ID).style.display = "none";
        }
    }

    function BeforeSaveAlert() {
        if (SendEventToSave.length > 0) {
            OpenCloseAlert("O", 'DivAlertSave');
            BindChangedEvent();
        } else {
            ToastMsg("No Data Found To Save", "warning");
        }
    }

    function ChangeFormatYYYYMMDDToUIFormat(StrDate) {
        if (StrDate.length !== 8) return "";
        var year = StrDate.substring(0, 4);
        var month = StrDate.substring(4, 6);
        var day = StrDate.substring(6, 8);
        var FormatDate = day + "/" + month + "/" + year;
        return FormatDate;
    }

    function BindChangedEvent() {
        $("#TblSummarybody").empty();
        $.grep(SendEventToSave, function (a) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {TDSTYLE}>{TDCONTENT}</td>";
            var MRNOTd = Td.replace("{TDCONTENT}", a.MRNO).replace("{TDSTYLE}", "");
            var PatNameTd = Td.replace("{TDCONTENT}", a.PATNAME).replace("{TDSTYLE}", "");
            var SurgeryTd = Td.replace("{TDCONTENT}", a.SURGERY).replace("{TDSTYLE}", "Style='text-align:left;'");
            var PrevSurgeryDateTd = Td.replace("{TDCONTENT}", ChangeFormatYYYYMMDDToUIFormat(a.PREVSURGADVDATE)).replace("{TDSTYLE}", "");
            var SurgeryDateTd = Td.replace("{TDCONTENT}", ConvertStrDateToFormat(a.SURGADVDATE)).replace("{TDSTYLE}", "");
            var AllTd = MRNOTd + PatNameTd + SurgeryTd + PrevSurgeryDateTd + SurgeryDateTd;
            var FinalAppendTr = Tr.replace("{TRCONTENT}", AllTd);
            $("#TblSummarybody").append(FinalAppendTr);
        });
    }

    function GetAdvPatList(Date) {
        //debugger;
        var convertDate = ConvertDateToFormat(Date, false);
        var DataToSend = {
            FDate: convertDate
        }
        $.ajax({
            url: '../DoctorDesk/GetAdvPatScheduleList',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            success: function (data) {
                ApprovelList = data == "" ? [] : data;
                $("#tblAdviceListBody").empty();
                if (ApprovelList.length > 0) {
                    OpenAdviceListPopup();
                    $("#txtCALSELDATE").val(convertDate);
                }
                else {
                    $("#txtCALSELDATE").val("");
                    ToastMsg("No Data Found", "warning");
                }
            },
            complete: function () {
            }
        });
    }
    function OpenAdviceListPopup() {
        BindAdviceList();
        document.getElementById('AdviceModal').style.display = 'flex';
    }
    function CloseAdviceListPopup() {
        ApprovelList = [];
        $("#tblAdviceListBody").empty();
        $("#txtScheduleRemarks").val("");
        document.getElementById('AdviceModal').style.display = 'none';
    }
    function BindAdviceList() {
        var Tr = "<tr id='{TRID}'>{TRCONTENT}</tr>";
        var Td = "<td {TDSTYLE}>{TDCONTENT}</td>";
        var Accept = "<i class='fa fa-check AcceptStatus' aria-hidden='true'></i>";
        var Cancel = "<i class='fa fa-times CancelStatus' aria-hidden='true'></i>";
        var NAIcon = "<label style='font-weight: bold;color: black;'>NA</label>";
        var Action = "";// "<input type='checkbox' onclick='UpdateApproveList(this.id);' class='AdvListChckbox' id='{CHECKBOXID}' {DISABLED} />";
        $.grep(ApprovelList, function (a) {
            var PACValidate = "";
            if (a.PACSTATUS != "" && a.PACSTATUS != "P") {
                var PACDate = a.PACFITDATE;
                var PACTime = a.PACFITTIME;
                var SurgDate = a.SURGDATE;
                var SurgTime = a.SURGTIME;
                if (a.PACFITDATE != "" && a.PACFITTIME != "") {
                    var pacParts = PACDate.split("/");
                    var pacDay = parseInt(pacParts[0]);
                    var pacMonth = parseInt(pacParts[1]) - 1;
                    var pacYear = parseInt(pacParts[2]);
                    var pacTime = new Date(pacYear, pacMonth, pacDay);
                    var pacHourMin = new Date("1970-01-01T" + convertTo12Hour(PACTime) + ":00");
                    pacTime.setHours(pacHourMin.getHours(), pacHourMin.getMinutes(), 0, 0);
                    var surgParts = SurgDate.split("/");
                    var surgDay = parseInt(surgParts[0]);
                    var surgMonth = parseInt(surgParts[1]) - 1;
                    var surgYear = parseInt(surgParts[2]);
                    var surgTime = new Date(surgYear, surgMonth, surgDay);
                    var surgHourMin = SurgTime.split(":");
                    surgTime.setHours(parseInt(surgHourMin[0]), parseInt(surgHourMin[1]), 0, 0);
                    var diffMs = surgTime - pacTime;
                    var diffHours = diffMs / (1000 * 60 * 60);
                    if (diffHours > 24 || diffHours < 0) {
                        PACValidate = "N";
                    } else {
                        PACValidate = "Y";
                    }
                } else {
                    PACValidate = "N";
                }
            }
            var PACValidContent = PACValidate == "" ? "" : (PACValidate == "Y" ? "<span class='verified-badge'></span>" : "<span class='not-verified-badge'></span>");
            //var PACContent = a.PACSTATUS == "F" ? "<label class='Fit'>Fit</label>" : (a.PACSTATUS == "W" ? "<label class='FitRisk'>Fit, with Accepted Risk</label>" : (a.PACSTATUS == "U" ? "<label class='UnFit'>Unfit</label>" : ""));
            var PACContent = (a.PACSTATUS === "F") ? "<label class='Fit'>Fit</label>" : //priyanka 20/11/2025
                (a.PACSTATUS === "W") && (a.ASARISKLEVEL != "") ? "<label class='FitRisk'>Fit, with Accepted Risk (" + a.ASARISKLEVEL + ")</label>" :
                    (a.PACSTATUS === "W") && (a.ASARISKLEVEL === "") ? "<label class='FitRisk'>Fit, with Accepted Risk</label>" :
                        (a.PACSTATUS === "U") ? "<label class='UnFit'>Unfit</label>" : "";
            var Disabled = a.OTBOOKSTATUS == "P" || a.PACSTATUS == "P" || (a.SCHEMECODES != "" && a.PREAUTHSTATUS != "A") ? "disabled" : "";
            var AdvType = a.SURGADVTYPE == "R" ? "Regular" : (a.SURGADVTYPE == "E" ? "Emergency" : (a.SURGADVTYPE == "T" ? "Tentative" : ""));
            var ActionTd = Td.replace("{TDCONTENT}", (Action.replace("{CHECKBOXID}", ("ADVCHK_" + a.CONSNO)).replace("{DISABLED}", Disabled))).replace("{TDSTYLE}", "style='text-align:center;display:none'");
            var ConsNoTd = Td.replace("{TDCONTENT}", a.CONSNO).replace("{TDSTYLE}", "");
            var MrnoTd = Td.replace("{TDCONTENT}", a.MRNO).replace("{TDSTYLE}", "");
            var PatNameTd = Td.replace("{TDCONTENT}", a.PATNAME).replace("{TDSTYLE}", "");
            var PatCatgTd = Td.replace("{TDCONTENT}", a.PATCATGNM).replace("{TDSTYLE}", ""); //priyanka 04/04/2026
            var SurgyDateTimeTd = Td.replace("{TDCONTENT}", a.SURGYDATETIME).replace("{TDSTYLE}", "");
            var AdvDateTd = Td.replace("{TDCONTENT}", a.SURGADVDATE).replace("{TDSTYLE}", "");
            var AdvCodeTd = Td.replace("{TDCONTENT}", a.SURGADVCODES).replace("{TDSTYLE}", "style='display:none;'");
            var AdvNameTd = Td.replace("{TDCONTENT}", a.SURGNMADVICE).replace("{TDSTYLE}", "");
            var AdvTypeTd = Td.replace("{TDCONTENT}", AdvType).replace("{TDSTYLE}", "");
            var DoctCodeTd = Td.replace("{TDCONTENT}", a.DOCTCODE).replace("{TDSTYLE}", "style='display:none;'");
            var DoctNameTd = Td.replace("{TDCONTENT}", a.DOCTNAME).replace("{TDSTYLE}", "");
            var PACTd = Td.replace("{TDCONTENT}", (a.PACSTATUS == "P" ? Cancel : (PACContent != "" ? PACContent : Accept)) + PACValidContent).replace("{TDSTYLE}", "style='text-align:center;position: relative;width: 90px;'");
            var PreAuthTd = Td.replace("{TDCONTENT}", (a.SCHEMECODES == "" ? NAIcon : (a.PREAUTHSTATUS == "A" ? Accept : Cancel))).replace("{TDSTYLE}", "style='text-align:center;'");
            var OTBookTd = Td.replace("{TDCONTENT}", (a.OTBOOKSTATUS == "P" ? Cancel : Accept)).replace("{TDSTYLE}", "style='text-align:center;'");
            var DoctApprvlTd = Td.replace("{TDCONTENT}", (a.DRAPPROVEDYN == "Y" ? Accept : Cancel)).replace("{TDSTYLE}", "style='text-align:center;'");
            var SurgeryStatusTd = Td.replace("{TDCONTENT}", (a.OTNOTESNO == "P" || a.OTNOTESNO == "" ? Cancel : Accept)).replace("{TDSTYLE}", "style='text-align:center;'");
            var AllTd = ActionTd + ConsNoTd + MrnoTd + PatNameTd + PatCatgTd + SurgyDateTimeTd + AdvDateTd + AdvNameTd + AdvTypeTd + DoctCodeTd + DoctNameTd + PACTd + PreAuthTd + OTBookTd + DoctApprvlTd + SurgeryStatusTd ; //priyanka 04/04/2026
            var FinalAppendTr = Tr.replace("{TRCONTENT}", AllTd).replace("{TRID}", ("TR_" + a.CONSNO));
            $("#tblAdviceListBody").append(FinalAppendTr);
        });
    }

    function ValidationForApprovel(Type) {
        var FilterList = ApprovelList.filter(function (item) { return item.CHECKED == 'Y' && item.OTBOOKSTATUS != "P"; });
        if (FilterList.length == 0) {
            ToastMsg("No Data Found To Save", "warning");
            return false;
        }
        if (Type == "R") {
            if ($("#txtScheduleRemarks").val() == "") {
                $("#txtScheduleRemarks").focus();
                $("#txtScheduleRemarks").css("border-color", "red");
                return false;
            }
        }
        return true;
    }

    function MakeNormal(Id) {
        $("#" + Id).css("border-color", "");
    }

    function SaveApproveList(Type) {
        if (ValidationForApprovel(Type)) {
            var FilterList = ApprovelList.filter(function (item) { return item.CHECKED === 'Y' && item.OTBOOKSTATUS !== "P"; }).map(function (item) { return { BOOKINGNO: item.OTBOOKSTATUS }; });
            var DataToSend = {
                ApprovelList: JSON.stringify(FilterList),
                Remarks: $("#txtScheduleRemarks").val(),
                ApprovalStatus: Type
            }
            $.ajax({
                url: '../DoctorDesk/SaveApprovelList',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                success: function (data) {
                    ToastMsg(data, "success");
                    CloseAdviceListPopup();
                    GetAdvPatList($("#txtCALSELDATE").val());
                },
                complete: function () {
                }
            });
        }
    }
    function UpdateApproveList(CheckBoxId) {
        var ConsNo = CheckBoxId.split('_')[1];
        $.grep(ApprovelList, function (a) {
            if (a.CONSNO == ConsNo) {
                a.CHECKED = $("#" + CheckBoxId).prop("checked") == true ? "Y" : "N";
            }
        });
    }

    function convertTo12Hour(time24) {
        var time = time24.split(":");
        var hours = parseInt(time[0]);
        var minutes = time[1];
        var period = "AM";
        if (hours >= 12) {
            period = "PM";
        }
        if (hours > 12) {
            hours = hours - 12;
        }
        if (hours === 0) {
            hours = 12;
        }
        if (parseInt(minutes) < 10) {
            minutes = "0" + parseInt(minutes);
        }
        if (hours < 10) {
            hours = "0" + hours;
        }
        return hours + ":" + minutes + " " + period;
    }

    function applyDoctorLeaveIcons() {
        if (!calendar) return;
        const currentView = calendar.view.type;
        if (currentView == 'dayGridMonth') {
            document.querySelectorAll('.fc-daygrid-day').forEach(function (cell) {
                var cellDate = cell.getAttribute('data-date');
                var FilterData = AllDoctLeaveDtls.filter(function (item) {
                    return item.LDate === cellDate && (item.LDoctAnestist === "Y" || item.LDoctSurg === "Y");
                });
                if (FilterData.length > 0) {
                    if (!cell.querySelector('.leave-icon')) {
                        const icon = document.createElement('span');
                        icon.classList.add('leave-icon');
                        icon.innerHTML = '⚕️';
                        icon.style.position = 'absolute';
                        icon.style.top = '3px';
                        icon.style.left = '3px';
                        icon.style.fontSize = '20px';
                        icon.style.opacity = '0.8';
                        icon.style.pointerEvents = 'auto';
                        icon.style.zIndex = '9999';
                        icon.style.cursor = "pointer";
                        cell.style.position = 'relative';
                        cell.appendChild(icon);
                        icon.addEventListener('click', function (e) {
                            OpenCloseInfoPopup("O", cell.getAttribute('data-date'));
                        });
                    }
                }
            });
        }
        else {
            document.querySelectorAll('.leave-icon').forEach(function (icon) {
                icon.remove();
            });
        }
    }

    function DoctorLeaveInfoDtlsList(Lst) {
        AllDoctLeaveDtls = [];
        $.grep(Lst, function (L) {
            var FDate = L.FROMDATE;
            var TDate = L.TODATE;
            var DateLst = GetDateDiffList(FDate, TDate);
            $.grep(DateLst, function (D) {
                var NewDoctLeave = {
                    LDate: D,
                    LDoctCode: L.DOCTCODE,
                    LDoctName: L.DOCTNAME,
                    LDoctSurg: L.SURGEONYN,
                    LDoctAnestist: L.ANESTISTYN
                }
                AllDoctLeaveDtls.push(NewDoctLeave);
            });
        });
    }

    function GetDateDiffList(LFDate, LTDate) {
        var partsStart = LFDate.split('/');
        var partsEnd = LTDate.split('/');
        var start = new Date(partsStart[2], partsStart[1] - 1, partsStart[0]);
        var end = new Date(partsEnd[2], partsEnd[1] - 1, partsEnd[0]);
        var dateList = [];
        while (start <= end) {
            var yyyy = start.getFullYear();
            var mm = (start.getMonth() + 1).toString().padStart(2, '0');
            var dd = start.getDate().toString().padStart(2, '0');
            var DT = yyyy + "-" + mm + "-" + dd;
            dateList.push(DT);
            start.setDate(start.getDate() + 1);
        }
        return dateList;
    }

    function OpenCloseInfoPopup(Type, Date) {
        if (Type == "C") {
            document.getElementById("DoctLeaveModal").style.display = "none";
            DoctInfoFlag = false;
        }
        else {
            BindDoctorLeaveLst(Date);
            DoctInfoFlag = true;
            document.getElementById("DoctLeaveModal").style.display = "flex";
        }
    }

    function BindDoctorLeaveLst(ForDate) {
        $("#tblDoctLeave").empty();
        var FilterDT = AllDoctLeaveDtls.filter(function (item) { return item.LDate === ForDate && (item.LDoctAnestist === "Y" || item.LDoctSurg === "Y"); });
        var TR = "<tr>{TRCONTENT}</tr>";
        var TD = "<td {TDSTYLE}>{TDCONTENT}</td>";
        var Indx = 1;
        $.grep(FilterDT, function (L) {
            var SINOTD = TD.replace("{TDCONTENT}", Indx).replace("{TDSTYLE}", "style='text-align:center;font-size: 12px;font-weight: bold;'");
            var DoctTD = TD.replace("{TDCONTENT}", ("Dr." + L.LDoctName)).replace("{TDSTYLE}", "style='font-size: 12px;font-weight: bold;'");
            var RplTR = TR.replace("{TRCONTENT}", (SINOTD + DoctTD));
            $("#tblDoctLeave").append(RplTR);
            Indx++;
        });
        var ForDTSplt = ForDate.split('-');
        var FDate = ForDTSplt[2] + "/" + ForDTSplt[1] + "/" + ForDTSplt[0];
        document.getElementById("LblHeadDoctLeave").innerText = "Doctor Leave Information - " + FDate
    }



    function GetUnallocPatData() {
        debugger;
        var FromDate = $("#SurgicalFromDt").val();
        var ToDate = $("#SurgicalToDt").val();
        var PatName = $("#SurgicalPatName").val() ? $("#SurgicalPatName").val().trim() : "";
        var isDateSearch = $('#chkDateSearch').is(':checked');

        if (isDateSearch) {
        if (!FromDate || !ToDate) {
            ToastMsg("Please select both From and To dates.", "info");
            return;
        }
        if (new Date(FromDate) > new Date(ToDate)) {
            ToastMsg("Invalid Range: 'To Date' cannot be earlier than 'From Date'.", "info");
            document.getElementById('SurgicalToDt').classList.add('is-invalid');
            return;
        }
        else {
            document.getElementById('SurgicalToDt').classList.remove('is-invalid');
            }
        }
        else {
            if (!PatName) {
                ToastMsg("Please select Patient Name.", "info");
                return;
            }
            FromDate = "";
            ToDate = "";
        }

        var DataToSend = {
            FDate: FromDate,
            TDate: ToDate,
            PatName: PatName
        };
        surgicalunallocatedpatlisttable.clearData();
        $.ajax({
            url: '../DoctorDesk/GetScheduleUnallocatedPatDtls',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            success: function (Response) {
                var data = Response[0] || [];
                if (data.length > 0) {
                    surgicalunallocatedpatlisttable.setData(data);
                }
                else {
                    surgicalunallocatedpatlisttable.clearData();
                    ToastMsg("No Data Found", "info");
                }
            },
            complete: function () {
            }
        });
    }

    function OpenPopupUnAllocatedPatient(UnAllocateRowData) {
        $('#eventId').val(UnAllocateRowData.TRANNO);
        $('#eventMRNO').val(UnAllocateRowData.MRNO);
        $('#eventPatName').val(UnAllocateRowData.PATNAME);
        $('#eventDoctor').val(UnAllocateRowData.DOCTNAME);
        $('#eventTitle').val(UnAllocateRowData.SURGERY);
        $('#eventPatCatg').val(UnAllocateRowData.PATCATGNM);//priyanka 04/04/2026
        $('#eventStartDate').val("");
        $('#eventPACDate').val("");
        $('#eventStartDate').prop('disabled', false);
        $('#eventStartDate').prop('readonly', true);
        $('#eventTitle').prop('readonly', true);
        $("#eventStartDate").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),
            onSelect: function (dateText, inst) {
                SetPACOnOrBeforeDateUnallocated();
            }
        });
        document.getElementById("SaveUnallactePat").style.display = "flex";
        document.getElementById("tblAdviceListCont").style.display = "none";
        $('#tdPAC').empty();
        $('#tdPreAuth').empty();
        $('#tdOTBook').empty();
        $('#tdDoctAppr').empty();
        document.getElementById('eventModal').style.display = 'flex';
    }

    function SetPACOnOrBeforeDateUnallocated() {
        var TDate = $("#eventStartDate").val();
        var parts = TDate.split("/");
        var dateObj = new Date(parts[2], parts[1] - 1, parts[0]);
        var dd = ("0" + dateObj.getDate()).slice(-2);
        var mm = ("0" + (dateObj.getMonth() + 1)).slice(-2);
        var yyyy = dateObj.getFullYear();
        var formattedDate = dd + "/" + mm + "/" + yyyy;
        HandlePACAdvDateUnallocated(formattedDate);
    }

    function HandlePACAdvDateUnallocated(selectedDate) {
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
        $("#eventPACDate").val(newDate);
    }

    function ValidationForUnallocatedPat() {
        if ($('#eventStartDate').val() == "") {
            ToastMsg("Please Select Surgery Advice Date.", "warning");
            return false;
        }
        return true;
    }

    function SaveUnAllocatedPatient() {
        if (ValidationForUnallocatedPat() == true) {
            var UnAllocatData = [];
            var CalenderData = {
                TRANNO: $('#eventId').val(),
                SURGADVDATE: $('#eventStartDate').val(),
                PACADVDATE: $('#eventPACDate').val()
            }
            UnAllocatData.push(CalenderData)
            var DataToSend = {
                Calender: JSON.stringify(UnAllocatData)
            }
            $.ajax({
                url: '../DoctorDesk/SaveScheduleCalender',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                success: function (data) {
                    ToastMsg("Updated Successfully", "success");
                    document.getElementById('eventModal').style.display = 'none';
                    GetUnallocPatData();
                },
                complete: function () {
                }
            });
        }
    }
</script>
<div class="container-fluid p-0">
    <%--Abhishesh || 20260820--%>
    <div class="row mb-3">
        <div class="col-12 nsurgery">
            <%--Abhishesh || 20260820--%>
            <div class="stat-filter-row Surgical SurgicalUnallocatedSrchPatDataDiv" id="divSurgicalSearchFilter">
                <div class="stat-form-group">
                    <input type="checkbox" id="chkDateSearch" class="Chkbox" checked />
                    <label class="stat-label" for="chkDateSearch">Date</label>
                </div>
                <div class="stat-form-group">
                    <span class="stat-label">From</span>
                    <input type="date" class="stat-input" id="SurgicalFromDt" />
                </div>
                <div class="stat-form-group">
                    <span class="stat-label">To</span>
                    <input type="date" class="stat-input" id="SurgicalToDt" />
                </div>
                <div class="stat-form-group">
                    <span class="stat-label" id="lblSurgicalPatName">Patient Name</span>
                    <input type="text" class="stat-input" id="SurgicalPatName" style="width: 200px;" placeholder="Search Patient Name" maxlength="100" />
                </div>
                <div class="stat-form-group">
                    <button class="btn-action btn-blue" id="btnSearch" onclick="GetUnallocPatData();" style="min-width: auto; padding: 6px 16px;">
                        <i class="fa fa-search"></i>Search
                    </button>
                </div>
            </div>

            <div class="btn-group btn-group-sm" role="group" style="align-items: center;" aria-label="User Allocation Toggle">
                <input type="radio" class="btn-check" name="PatType" value="A" id="rbtnPatTypeA" autocomplete="off" checked>
                <label class="btn btn-outline-primary px-4" for="rbtnPatTypeA">Allocated Patients</label>

                <input type="radio" class="btn-check" name="PatType" value="U" id="rbtnPatTypeU" autocomplete="off">
                <label class="btn btn-outline-primary px-4" for="rbtnPatTypeU">Unallocated Patients</label>
            </div>
        </div>
    </div>
    <%--Abhishesh || 20260820--%>
    <hr class="my-1 opacity-25">

    <div class="row g-3 align-items-end Surgical" id="SurgicalUnallocatedPatDataDiv">
        <div class="mt-4">
            <div class="">
                <div id="SurgicalUnallocatedPatTable">
                </div>
            </div>
        </div>
    </div>
</div>


<div id="calendar" style="margin-bottom: 10px;"></div>

<div class="leg-wrapper" id="leg-wrapper_Div">
    <div>
        <input type="button" onclick="BeforeSaveAlert()" id="btnContinueCalender" class="btn-action btn-blue" value="Continue">
    </div>
    
    <div class="leg-group">
        <div class="leg-item">
            <span class="leg-icon-symbol">⚕️</span>
            <span>Doctor Leave</span>
        </div>
        <div class="leg-item">
            <span class="leg-dot" style="background-color: red;"></span>
            <span>Pending</span>
        </div>
        <div class="leg-item">
            <span class="leg-dot" style="background-color: yellow;"></span>
            <span>Partial Pending</span>
        </div>
        <div class="leg-item">
            <span class="leg-dot" style="background-color: rgb(0, 255, 0);"></span>
            <span>Completed</span>
        </div>
    </div>
</div>

<div id="eventModal" class="EModal">
    <div class="modal-content">
        <input type="hidden" id="eventId" />
        <div class="ModelHeaderDiv">
            <label>Surgery Advice Information</label>
            <span id="closeModalBtn" onclick="document.getElementById('eventModal').style.display = 'none';">&times;</span>
        </div>
        <div class="ModelContentDiv">
            <div class="form-row">
                <div class="form-col-label"><label class="ModelLbl">MR No.</label></div>
                <div class="form-col-input"><input type="text" id="eventMRNO" readonly /></div>
            </div>
            <div class="form-row">
                <div class="form-col-label"><label class="ModelLbl">Patient Name</label></div>
                <div class="form-col-input"><input type="text" id="eventPatName" readonly /></div>
            </div>
            <div class="form-row"> <%--Priyanka 04/04/2026--%>
                <div class="form-col-label">
                    <label class="ModelLbl">Patient Category</label></div>
                <div class="form-col-input">
                    <input type="text" id="eventPatCatg" readonly /></div>
            </div>
            <div class="form-row">
                <div class="form-col-label"><label class="ModelLbl">Doctor</label></div>
                <div class="form-col-input"><input type="text" id="eventDoctor" readonly /></div>
            </div>
            <div class="form-row">
                <div class="form-col-label"><label class="ModelLbl">Surgery Adviced Date</label></div>
                <div class="form-col-input"><input type="text" id="eventStartDate" readonly /></div>
            </div>
            <div class="form-row">
                <div class="form-col-label"><label class="ModelLbl">PAC Advice Date</label></div>
                <div class="form-col-input"><input type="text" id="eventPACDate" readonly /></div>
            </div>
            <div class="form-row">
                <div class="form-col-label"><label class="ModelLbl">Surgery name</label></div>
                <div class="form-col-input"><textarea class=" TextAreaBorder" id="eventTitle" style="height: 60px;"></textarea></div>
            </div>
            <div class="form-row" id="SaveUnallactePat" style="display:none;    align-self: center;">
                        <input type="button" onclick="SaveUnAllocatedPatient()" class="btn-action btn-blue" value="Save">
            </div>

            <div class="table-scroll-wrapper" style="max-height: 150px;">
                <table class="tblAdviceList" style="min-width: 500px;" id="tblAdviceListCont">
                    <thead>
                        <tr>
                            <th>PAC</th>
                            <th>Pre-Auth</th>
                            <th>OT Booking</th>
                            <th>Doctor Approved</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="text-align: center;" id="tdPAC"><i class='fa fa-times CancelStatus'></i></td>
                            <td style="text-align: center;" id="tdPreAuth"><i class='fa fa-times CancelStatus'></i></td>
                            <td style="text-align: center;" id="tdOTBook"><i class='fa fa-times CancelStatus'></i></td>
                            <td style="text-align: center;" id="tdDoctAppr"><i class='fa fa-times CancelStatus'></i></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="loading-Single-Surgical-Schedule-Surgy-Advice-Dtls" class="loading-screen" style="display: none; opacity: 0;"></div>
        </div>
    </div>
</div>

<div id="AdviceModal" class="AEModal">
    <div class="Amodal-content">
        <div class="ModelHeaderDiv">
            <label>Approval List</label>
            <i id="closeAModalBtn" class='fa fa-times CloseIcon' onclick="CloseAdviceListPopup()"></i>
        </div>

        <div class="ModelContentDiv">
            <input type="text" id="txtCALSELDATE" style="display:none" />
            
            <div class="table-scroll-wrapper">
                <table id="tblAdviceList" class="tblAdviceList">
                    <thead>
                        <tr>
                            <th style="min-width: 60px;display:none">Action</th>
                            <th style="min-width: 140px;">Consultation No.</th>
                            <th style="min-width: 110px;">MR No.</th>
                            <th style="min-width: 160px;">Patient Name</th>
                            <th style="min-width: 160px;">Patient Category</th> <%--Priyanka 04/04/2026--%>
                            <th style="min-width: 140px;">Surgery Date Time</th>
                            <th style="min-width: 120px;">Adviced for Date</th>
                            <th style="min-width: 180px;">Surgery Adviced Name</th>
                            <th style="min-width: 130px;">Nature of Surgery</th>
                            <th style="min-width: 150px;">Doctor Name</th>
                            <th style="min-width: 80px;">PAC</th>
                            <th style="min-width: 80px;">Pre-Auth</th>
                            <th style="min-width: 100px;">OT Booking</th>
                            <th style="min-width: 120px;">Doctor Approved</th>
                            <th style="min-width: 80px;">Surgery</th>
                        </tr>
                    </thead>
                    <tbody id="tblAdviceListBody"></tbody>
                </table>
            </div>

            <div style="margin-top: 15px; border-top: 1px solid #eee; padding-top: 10px;">
                <div style="display: none; align-items: center; margin-bottom: 10px;">
                    <label style="margin-right: 15px; font-weight:600;">Remark</label>
                    <textarea id="txtScheduleRemarks" class="form-control TextAreaBorder" onchange="MakeNormal(this.id);" style="height: 40px; resize: none;"></textarea>
                </div>
                
                <div id="DivApproSaveBtn" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap;">
                    <div style="display:none; gap: 10px;">
                        <input type="button" onclick="SaveApproveList('Y')" class="btn-action btn-blue" value="Approve">
                        <input type="button" onclick="SaveApproveList('R')" class="btn-action btn-red" value="Reject">
                    </div>

                    <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap; margin-top: 5px;">
                         <div class="leg-item"><i class="fa fa-check AcceptStatus"></i> Action Completed</div>
                         <div class="leg-item"><i class="fa fa-times CancelStatus"></i> Action Pending</div>
                         <div class="leg-item"><span class="verified-badge"></span> PAC Valid</div>
                         <div class="leg-item"><span class="not-verified-badge"></span> PAC Not Valid</div>
                    </div>
                </div>
            </div>
            <div id="loading-Single-Surgical-Schedule-AdviceList" class="loading-screen" style="display: none; opacity: 0;"></div>
        </div>
    </div>
</div>

<div id="DoctLeaveModal" class="EModal">
    <div class="modal-content" style="max-width: 400px;">
        <div class="ModelHeaderDiv">
            <label id="LblHeadDoctLeave">Doctor Leave Information</label>
            <i class='fa fa-times CloseIcon' onclick="OpenCloseInfoPopup('C')"></i>
        </div>
        <div class="ModelContentDiv">
            <div class="table-scroll-wrapper">
                <table class="tblAdviceList" style="min-width: 300px;">
                    <thead>
                        <tr>
                            <th>SI.NO</th>
                            <th>Doctor Name</th>
                        </tr>
                    </thead>
                    <tbody id="tblDoctLeave"></tbody>
                </table>
            </div>
            <div id="loading-Single-Surgical-Schedule-Doct-Leave" class="loading-screen" style="display: none; opacity: 0;"></div>
        </div>
    </div>
</div>

    <div id="DivOverlay" style="display: none;">
        <div id="DivAlertSave" class="MainDivAlertSave" style="display:none">
            <div id="DivHeaderAlert" class="MainDivHeaderAlert">
                <label id="AlertHeadLbl" class="MainAlertHeadLbl">Confirmation</label>
                <i class="fa fa-times-circle MainAlertCloseIcon" aria-hidden="true" id="AlertCloseIcon" onclick="OpenCloseAlert('C','DivAlertSave')"></i>
            </div>
            <div id="DivContentAlert" class="MainDivContentAlert">
                <div class="table-responsive">
                    <table class="fancy-table"  id="TblSummary">
                        <thead>
                            <tr>
                                <th>MRNO</th>
                                <th>Patient Name</th>
                                <th>Surgery</th>
                                <th>Prev. Advice Date</th>
                                <th>Advice Date</th>
                            </tr>
                        </thead>
                        <tbody id="TblSummarybody"></tbody>
                    </table>
                </div>
            </div>
            <div id="DivFooterAlert" class="MainDivFooterAlert">
                <input type="button" onclick="SaveCalenderData()" class="" style="width: 100px; font-size: 13px; text-align: center; display: block; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" id="btnSaveCalender" value="Save">
            </div>
        </div>
        <div id="DivPerformStat" class="MainDivAlertSave" style="display:none">
            <div id="DivHeaderPerformStat" class="MainDivHeaderAlert">
                <label id="PerformStatHeadLbl" class="MainAlertHeadLbl">Performance Status Info</label>
                <i class="fa fa-times-circle MainAlertCloseIcon" aria-hidden="true" id="PerformStatCloseIcon" onclick="OpenCloseAlert('C','DivPerformStat')"></i>
            </div>
            <div id="DivContentPrfStatus" class="MainDivContentAlert">
              <img src="../Images/PerformanceStatus.png" />
            </div>
        </div>
    </div>

<div id="loading-Single-Surgical-Schedule" class="loading-screen" style="display: none; opacity: 0;"></div>