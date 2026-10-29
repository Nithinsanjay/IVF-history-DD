<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script src="<%=ResolveUrl("~/Scripts/fullcalendar-6.1.17/dist/index.global.min.js")%>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/daygrid/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/timegrid/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/list/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/interaction/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/bootstrap5/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/js/jquery-ui-timepicker-addon.js") %>"></script>

<style type="text/css">
    #Hist_C_TumorBoardSchedule{
          height : 100%
    }
    /* ================= FULLCALENDAR OVERRIDES ================= */
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

    /* Responsive Calendar Toolbar */
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

        .fc-toolbar-title {
            font-size: 1.2em !important;
        }
        
        /* Adjust cell size on mobile */
        .fc-col-header-cell-cushion {
            font-size: 14px !important;
        }
    }

    /* ================= LEGEND STYLES (NEW) ================= */
    .leg-wrapper {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        padding: 12px 15px;
        margin-top: 10px;
        background-color: #fff;
        border-top: 1px solid #e0e0e0;
        border-bottom: 1px solid #e0e0e0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 13px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
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
        color: #444;
        font-weight: 500;
        cursor: default;
    }

    .leg-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        display: inline-block;
        flex-shrink: 0;
        box-shadow: 0 1px 2px rgba(0,0,0,0.15);
    }

    /* Color Utilities for Legend */
    .leg-bg-blue { background-color: #2364b5; }
    .leg-bg-orange { background-color: #f37b00; }
    .leg-bg-red { background-color: #dc3545; }
    .leg-bg-yellow { background-color: #ffc107; }
    .leg-bg-green { background-color: #28a745; }

    /* Mobile adjustments for legend */
    @media only screen and (max-width: 650px) {
        .leg-wrapper {
            justify-content: center;
            flex-direction: column;
        }
        .leg-group {
            justify-content: center;
        }
    }

    /* ================= MODAL STYLES ================= */
    .SchemeModal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(2px);
    }

    .SchemeModal .Scheme-modal-content {
        background-color: white;
        margin: 5vh auto; /* Center vertically slightly */
        width: 90%;
        max-width: 800px; /* Max width for large screens */
        border-radius: 8px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        max-height: 90vh;
        display: flex;
        flex-direction: column;
        overflow: hidden; /* Prevent double scrollbars */
    }

    .ModelHeaderDiv {
        background-color: #004b87; /* Updated to match new theme */
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 15px;
        font-size: 15px;
        font-weight: 600;
        flex-shrink: 0; /* Keep header fixed height */
    }

    .closeMdlBtn {
        cursor: pointer;
        font-size: 24px;
        line-height: 1;
        color: #fff;
        opacity: 0.8;
        transition: opacity 0.2s;
    }
    .closeMdlBtn:hover { opacity: 1; }

    /* Scrollable content area inside modal */
    .Scheme-modal-body {
        padding: 15px;
        overflow-y: auto;
        flex-grow: 1;
    }

    /* ================= TABLE STYLES ================= */
    .table-responsive {
        overflow-x: auto;
        margin-bottom: 15px;
        border: 1px solid #e0e0e0;
        border-radius: 4px;
    }

    .MedicineTbl {
        width: 100%;
        border-collapse: collapse;
        font-family: 'Segoe UI', sans-serif;
        font-size: 13px;
        color: #333;
        min-width: 500px; /* Ensures table doesn't squash too much */
    }

    .MedicineTbl th, .MedicineTbl td {
        border: 1px solid #dee2e6;
        padding: 10px;
        vertical-align: middle;
    }

    .MedicineTbl thead th {
        background-color: #f8f9fa;
        color: #333;
        font-weight: 600;
        text-align: center;
        position: sticky;
        top: 0;
    }
    
    .MedicineTbl tbody tr:nth-child(even) { background-color: #f9f9f9; }
    .MedicineTbl tbody tr:hover { background-color: #f1f1f1; }

    /* ================= PRINT BUTTON ================= */
    #btnPrint {
        width: 100%;
        max-width: 200px;
        margin: 10px auto 0 auto;
        padding: 10px;
        background: linear-gradient(145deg, #0d6efd, #0b5ed7);
        color: white !important;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: transform 0.1s;
        display: block; /* Center logic handled by margin auto */
    }
    #btnPrint:hover {
        background: linear-gradient(145deg, #0b5ed7, #0a58ca);
        transform: translateY(-1px);
    }
    .fc-list-event-dot {/*vandana 180226 hide bz it is showing by default confusing clor for tumor */
    display: none !important;
        }
</style>

<script type="text/javascript">
    var calendar;
    var AllEventDtls = [];
    var SDocName = 'Dr. ' + gDoctName;
    var mrno = "";
    var tranno = "";

    function initializeCalendar() {
        // //debugger;
        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            selectable: true,
            editable: false,
            selectable: true,
            eventDurationEditable: false,
            contentHeight: '90%', // or use fixed height
            height: '90%', // optional
            events: AllEventDtls,
            datesSet: function (info) {
                const fromDate = info.startStr.includes('T') ? info.startStr.split('T')[0] : info.startStr;
                const toDate = info.endStr.includes('T') ? info.endStr.split('T')[0] : info.endStr;
                GetCalenderData();
            },
            headerToolbar: {
                left: 'dayGridMonth,dayGridWeek,listWeek',
                center: 'title',
                right: 'prev,next today' // added today for convenience
            },
            buttonText: {
                today: 'Today',
                month: 'Month',
                week: 'Week',
                list: 'List'
            },
            eventClick: function (info) {
                var event = info.event;

                if (event.extendedProps) {
                    mrno = event.extendedProps.MRNO;
                    tranno = event.extendedProps.TRANNO;
                    var Name = event.extendedProps.PATNAME;
                    var tbmsDate = event.extendedProps.TBMSDATE;
                    var TBMSTIME = event.extendedProps.TBMSTIME;
                    var tbmsStatus = event.extendedProps.STATUS;
                    var tbmsTumorRef = event.extendedProps.TUMOR_REFER;

                    // Call your function
                    OpenPopInfoScheme(mrno, tranno, Name);

                    if (((tbmsStatus == "V" && tbmsTumorRef == "Y") || (tbmsStatus == "O" && tbmsTumorRef == "N"))) {
                        document.getElementById("btnPrint").style.display = "block"; // show
                    } else {
                        document.getElementById("btnPrint").style.display = "none"; // hide
                    }
                }
            },
            eventContent: function (arg) {
                const event = arg.event;
                const viewType = arg.view.type;

                // Circle for color code
                const circle = document.createElement('span');
                circle.style.display = 'inline-block';
                circle.style.width = '10px';
                circle.style.height = '10px';
                circle.style.borderRadius = '50%';
                circle.style.marginRight = '5px';
                circle.style.flexShrink = '0';

                if (event.extendedProps && event.extendedProps.TBMSDATE) {
                    if (event.extendedProps.STATUS === "S") {
                        circle.style.backgroundColor = '#dc3545'; // Schedule
                    } else if (event.extendedProps.STATUS === "V") {
                        circle.style.backgroundColor = '#28a745'; // Verified
                    }
                    else if ((event.extendedProps.STATUS === "O" && event.extendedProps.TUMOR_REFER === "Y") || (event.extendedProps.STATUS === "O" && event.extendedProps.TUMOR_REFER === "N")) {
                        circle.style.backgroundColor = '#ffc107'; // Completed
                    }
                }

                // Title
                const title = document.createElement('span');
                title.style.color = 'white';
                title.style.overflow = 'hidden';
                title.style.textOverflow = 'ellipsis';
                title.style.whiteSpace = 'nowrap';
                title.style.flexGrow = '1';
                title.style.fontSize = '12px';
                title.style.fontWeight = '500';

                let displayText = event.title;
                if (viewType !== 'listWeek' && event.extendedProps && event.extendedProps.TBMSTIME) {
                    var timeParts = event.extendedProps.TBMSTIME.split(':');
                    var hour = parseInt(timeParts[0], 10);
                    var minutes = timeParts[1];
                    if (minutes.length < 2) minutes = '0' + minutes;

                    var ampm = (hour >= 12) ? 'PM' : 'AM';
                    hour = hour % 12;
                    if (hour === 0) hour = 12;

                    displayText += ' - ' + hour + ':' + minutes + ' ' + ampm;
                }
                title.innerText = displayText;

                // Container
                const container = document.createElement('div');
                container.style.display = 'flex';
                container.style.alignItems = 'center';
                container.style.overflow = 'hidden';
                container.style.width = '100%';
                container.style.borderRadius = '3px';
                container.style.padding = '2px 4px';
                container.style.color = 'white';

                if (event.extendedProps) {
                    var tbmsTumorRef = event.extendedProps.TUMOR_REFER;
                    if (tbmsTumorRef === "Y") {
                        container.style.backgroundColor = "#2364b5"; // Blue
                    } else if (tbmsTumorRef === "N") {
                        container.style.backgroundColor = "#f37b00"; // Orange
                    }
                }

                // Tooltip
                if (event.extendedProps) {
                    const tooltipLines = [];
                    const props = event.extendedProps;
                    tooltipLines.push('Name : ' + (props.PATNAME || ''));
                    tooltipLines.push('MR No : ' + (props.MRNO || ''));
                    tooltipLines.push('Age : ' + (props.PATAGE || ''));
                    tooltipLines.push('Schedule Date : ' + (props.TBMSDATE || ''));
                    if (props.TBMSTIME) {
                        tooltipLines.push('Time : ' + props.TBMSTIME);
                    }
                    container.title = tooltipLines.join('\n');
                }

                container.appendChild(circle);
                container.appendChild(title);

                return { domNodes: [container] };
            }
        });

        calendar.render();
    }


    function GetCalenderData() {
        var DataToSend = {
            strDoctCode: gDoctCode,
            type: "C"
        };
        startLoading("Loading", "loading-Tumor-Board-Schedule");
        $.ajax({
            url: '../DoctorDesk/GetDoctorsMeetingDet',
            type: 'post',
            datatype: 'json',
            async:true,
            data: DataToSend,
            success: function (data) {
                data = data == "" ? [] : data.filter(function (item) {
                    return item.PATNAME && item.TBMSDATE && item.TBMSTIME;
                });

                AllEventDtls = [];
                AllEventDtls = AllEventDtls.concat(data);
                $.grep(AllEventDtls, function (a) {
                    a.id = a.TRANNO;

                    let datePart = a.TBMSDATE;
                    let timePart = a.TBMSTIME;
                    let parts = datePart.split('/');
                    a.start = parts[2] + '-' + parts[1] + '-' + parts[0] + 'T' + timePart;
                    a.title = (a.PATNAME ? a.PATNAME.trim() : '');
                });

                calendar.removeAllEvents();
                calendar.addEventSource(AllEventDtls);
                stopLoading("loading-Tumor-Board-Schedule");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Tumor-Board-Schedule");
                ToastMsg(textStatus, "error");
            }
        });
    }

    //For Popup Diagnosis And ICD-O
    function OpenPopInfoScheme(Mrno, Tranno, Name) {
        document.getElementById("InfoHeadLabel").innerText = "Diagnosis Info" + " (" + Name + ")";
        GetICDDiagnosis(Mrno, Tranno);
        document.getElementById("POPUPInfoModal").style.display = "block";
        document.documentElement.style.overflow = 'hidden';
    }

    //Close Popup Div
    function ClosePop(DivId) {
        document.getElementById(DivId).style.display = 'none';
        document.documentElement.style.overflow = '';
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
        var Td = "<td {STYLE}>{TDCONTENT}</td>";
        $("#TableICDOTBody").empty();
        $.each(Lst, function (_, item) {
            var matchedTopo = TopoLst.find(function (t) {
                return t.TOPOCODE === item.TOPOCODE;
            });
            if (matchedTopo) {
                var Code = item.TOPOCODE + item.HCODE + " " + item.HGRADE;
                var Desc = item.TOPODESC + ", " + item.HDESC + ", " + item.GRADENAME;
                var TNM = (matchedTopo.TNMPREFIX || '') + (matchedTopo.T || '') + (matchedTopo.N || '') + (matchedTopo.M || '');
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                var TNMTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", TNM || '-');
                var StageTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", matchedTopo.STAGE || '-');
                var FinalTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd + TNMTd + StageTd);
                $("#TableICDOTBody").append(FinalTr);
            }
        });
    }
    function GetICDDiagnosis(Mrno, Tranno) {

        var DataToSend = {
            strTranNo: Tranno,
            strMRNO: Mrno
        }
        $.ajax({
            url: '../DoctorDesk/SetDataForDiagnosis',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            async: true,
            success: function (data) {
                ICDDiagnosis = "";
                $("#TableICDOTBody").empty();
                $("#TableICDTBody").empty();
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
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    //Print for Tumor Board
    function PrintService(Mrno, tranNo) {
        if (!tranNo) {
            ToastMsg("Transaction No Missing", "warning");
        }

        let dataToSend = {
            MrNo: Mrno,
            TranNo: tranNo
        }
        startLoading("Loading", "loading-Tumor-Board-Schedule");
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../DoctorDesk/PrintTumorBrdDisc',
            data: dataToSend,
            success: function (response) {
                stopLoading("loading-Tumor-Board-Schedule");
                if (response == "sucess") {
                    let a = document.createElement('a');
                    a.href = '../DoctorDesk/PrintTumorTransactionAction';
                    a.target = '_blank';
                    a.click();
                }
                else {
                    ToastMsg("Please try again", "warning");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Tumor-Board-Schedule");
                ToastMsg(textStatus, "error");
            }
        });
    }
</script>

<div id="calendar" style="margin-bottom: 15px;"></div>

<div class="leg-wrapper">
    <div class="leg-group">
        <div class="leg-item">
            <span class="leg-dot leg-bg-blue"></span>
            <span>Refer To Tumor Board</span>
        </div>
        <div class="leg-item">
            <span class="leg-dot leg-bg-orange"></span>
            <span>Not Refer To Tumor Board</span>
        </div>
    </div>

    <div class="leg-group">
        <div class="leg-item">
            <span class="leg-dot leg-bg-red"></span>
            <span>Schedule</span>
        </div>
        <div class="leg-item">
            <span class="leg-dot leg-bg-yellow"></span>
            <span>Completed</span>
        </div>
        <div class="leg-item">
            <span class="leg-dot leg-bg-green"></span>
            <span>Verified</span>
        </div>
    </div>
</div>

<div id="POPUPInfoModal" class="SchemeModal">
    <div class="Scheme-modal-content">
        <div class="ModelHeaderDiv">
            <label id="InfoHeadLabel" style="margin:0;"></label>
            <span class="closeMdlBtn" onclick="ClosePop('POPUPInfoModal');">&times;</span>
        </div>
        
        <div class="Scheme-modal-body">
            <div class="table-responsive">
                <table id="TableICD" class="MedicineTbl">
                    <thead>
                        <tr>
                            <th style="width: 150px">Code</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody id="TableICDTBody"></tbody>
                </table>
            </div>

            <div class="table-responsive">
                <table id="TableICDO" class="MedicineTbl">
                    <thead>
                        <tr>
                            <th style="width: 150px">Code</th>
                            <th>Description</th>
                            <th style="width: 100px">TNM</th>
                            <th style="width: 100px">Stage</th>
                        </tr>
                    </thead>
                    <tbody id="TableICDOTBody"></tbody>
                </table>
            </div>
            
            <input type="button" onclick="PrintService(mrno,tranno)" id="btnPrint" value="Print" style="display:none;" />
        </div>
    </div>
</div>

<div id="loading-Tumor-Board-Schedule" class="loading-screen" style="display: none; opacity: 0;"></div>
