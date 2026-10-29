<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script src="<%=ResolveUrl("~/Scripts/fullcalendar-6.1.17/dist/index.global.min.js")%>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/daygrid/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/timegrid/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/list/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/interaction/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/fullcalendar-6.1.17/packages/bootstrap5/index.global.min.js") %>"></script>
<script src="<%= ResolveUrl("~/js/jquery-ui-timepicker-addon.js") %>"></script>
<style type="text/css">
    .fc-col-header-cell-cushion {
        font-size: 20px !important;
        color: white !important;
    }

    .fc-col-header-cell{
            background-color: #2c3e50;
    }

    .fc-daygrid-day-number {
        color: black;
        font-size: 16px;
    }

    .EModal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        width: 100vw;
        height: 100vh;
        background-color: rgba(0,0,0,0.5);
    }

        .EModal .modal-content {
            background-color: white;
            margin: 10% auto;
            min-width: 350px;
            border-radius: 5px;
            bottom: auto !important;
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
        width: 140px;
        padding:  5px 0px 5px 10px;
    }

    #closeModalBtn {
        cursor: pointer;
        font-weight: bold;
        font-size: 25px;
        width: 35px;
        height: 25px;
        position: relative;
        top: -5px;
        text-align: center;
    }

    .fc-event-main{
        font-size: 12px !important;
    }

    .ui-dialog {
        z-index: 100000000000000000000000000000;
    }
</style>

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
    <%-- Advice List --%>
<style>
    .AEModal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        width: 100vw;
        height: 100vh;
        background-color: rgba(0,0,0,0.5);
    }

        .AEModal .Amodal-content {
            background-color: white;
            margin: 10% auto;
            width: auto;
            max-width: 90%;
            border-radius: 5px;
            bottom: auto !important;
            overflow: auto;
            max-height: 95%;
        }

    table.tblAdviceList {
        border-collapse: separate;
        border-spacing: 0;
        width: 100%;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        min-height: 100px;
    }

        table.tblAdviceList thead {
            /*background: #4CAF50;*/
            background: #003f74;
            color: white;
            font-size: 12px;
        }

        table.tblAdviceList th,
        table.tblAdviceList td {
            padding: 5px 5px;
            border: none;
            text-align: left;
            border: 1px solid #c9c9c9;
        }
        table.tblAdviceList th {
            text-align: center;
        }

        table.tblAdviceList tbody tr {
            background-color: #f9f9f9;
            transition: background-color 0.3s;
        }

            table.tblAdviceList tbody tr:nth-child(even) {
                background-color: #f1f1f1;
            }

            table.tblAdviceList tbody tr:hover {
                background-color: #f1f1f1;
            }

    .PendingStatus {
        font-weight: bold;
        color: #e98300;
        font-size: 18px;
    }

    .CancelStatus {
        font-weight: bold;
        color: #e90000;
        font-size: 18px;
    }

    .AcceptStatus {
        font-weight: bold;
        color: #19a502;
        font-size: 18px;
    }

    .CloseIcon {
        font-size: 23px;
        margin-right: 10px;
        color: #ff0000;
        cursor: pointer;
    }

    .Fit {
        /*color: white;
        padding: 0px 2px;
        background-color: #007d05;*/
        color: #007d05;
        padding: 0px 2px;
        font-weight: 900;
    }

    .FitRisk {
        color: #b16d00;
        padding: 0px 2px;
        /*color: black;
        padding: 0px 2px;
        background-color: orange;*/
    }

    .UnFit{
        color: #ff3131;
        padding: 0px 2px;
    }


    .verified-badge {
        display: inline-block;
        position: absolute;
        float: right;
        top: 1px;
        right: 1px;
        width: 14px;
        height: 14px;
        background-color: #009aff;
        border-radius: 50%;
        color: white;
        font-size: 10px;
        text-align: center;
        line-height: 16px;
    }

        .verified-badge::before {
            content: "";
            position: absolute;
            top: 3px;
            left: 2px;
            width: 10px;
            height: 6px;
            border-left: 3px solid #fff;
            border-bottom: 3px solid #fff;
            transform: rotate(-45deg);
        }

    .not-verified-badge {
        display: inline-block;
        position: absolute;
        top: 1px;
        right: 1px;
        width: 14px;
        height: 14px;
        background-color: #19a502;
        border-radius: 50%;
        color: white;
        font-size: 10px;
        text-align: center;
        line-height: 16px;
    }

        .not-verified-badge::before {
            content: "";
            position: absolute;
            top: 4px;
            left: 4px;
            width: 8px;
            height: 8px;
        }

        .not-verified-badge::before,
        .not-verified-badge::after {
            content: "";
            position: absolute;
            top: 6px;
            left: 2px;
            width: 10px;
            height: 2px;
            background-color: white;
        }

        .not-verified-badge::before {
            transform: rotate(45deg);
        }

        .not-verified-badge::after {
            transform: rotate(-45deg);
        }

</style>
<style>
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
</style>


<script type="text/javascript">
    var calendar;
    var AllEventDtls = [];
    var SDocName = 'Dr. ' + '<%:Session["gDoctName"]%>';
    var mrno = "";
    var tranno = "";

    function initializeCalendar() {
        //debugger;
        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            selectable: true,
            editable: false,
            selectable: true,
            eventDurationEditable: false,
            contentHeight: '90%',
            height: '95%',
            events: AllEventDtls,
            datesSet: function (info) {
                const fromDate = info.startStr.includes('T') ? info.startStr.split('T')[0] : info.startStr;
                const toDate = info.endStr.includes('T') ? info.endStr.split('T')[0] : info.endStr;
                GetCalenderData();
            },
            headerToolbar: {
                left: 'dayGridMonth,dayGridWeek,listWeek',
                center: 'title',
                right: 'prev,next'
            },
            buttonText: {
                today: 'Today',
                month: 'Month',
                week: 'Week',
                list: 'List'
            },
            eventClick: function(info) {
                var event = info.event;

                if (event.extendedProps) {
                     mrno = event.extendedProps.MRNO;
                     tranno = event.extendedProps.TRANNO;
                    var Name = event.extendedProps.PATNAME;
                    var tbmsDate = event.extendedProps.TBMSDATE; // "dd/mm/yyyy"
                    var tbmsDate = event.extendedProps.TBMSTIME; 
                    var tbmsStatus = event.extendedProps.STATUS;
                    var tbmsTumorRef = event.extendedProps.TUMOR_REFER;
                    // Call your function
                    OpenPopInfoScheme(mrno, tranno, Name);

                    //// Parse event date
                    //var dateParts = tbmsDate.split('/');
                    //var eventDate = new Date(parseInt(dateParts[2], 10), parseInt(dateParts[1], 10) - 1, parseInt(dateParts[0], 10));
                    //var today = new Date();
                    //today.setHours(0,0,0,0); // normalize time
                    //eventDate.setHours(0,0,0,0);

                    //// Show/Hide Print button
                    //if (eventDate <= today) {
                    //    document.getElementById("btnPrint").style.display = "block"; // show
                    //} else {
                    //    document.getElementById("btnPrint").style.display = "none"; // hide
                    //}
                    if (((tbmsStatus =="V" && tbmsTumorRef=="Y") ||(tbmsStatus =="O" && tbmsTumorRef=="N"))){
                        document.getElementById("btnPrint").style.display = "block"; // show
                    } else {
                        document.getElementById("btnPrint").style.display = "none"; // hide
                    }
                }
            },
            eventContent: function(arg) {
                const event = arg.event;
                const viewType = arg.view.type;
                // Circle for today logic
                const circle = document.createElement('span');
                circle.style.display = 'inline-block';
                circle.style.width = '10px';
                circle.style.height = '10px';
                circle.style.borderRadius = '50%';
                circle.style.marginRight = '5px';
                circle.style.flexShrink = '0';
                //circle.style.backgroundColor = '#dc3545';
                if (event.extendedProps && event.extendedProps.TBMSDATE) {
                    var today = new Date();
                    var dateParts = event.extendedProps.TBMSDATE.split('/'); // ["dd","mm","yyyy"]
                    var dd = parseInt(dateParts[0], 10);
                    var mm = parseInt(dateParts[1], 10);
                    var yyyy = parseInt(dateParts[2], 10);

                    if (event.extendedProps && event.extendedProps.TBMSDATE) {
                        var today = new Date();
                        var dateParts = event.extendedProps.TBMSDATE.split('/'); // ["dd","mm","yyyy"]
                        var dd = parseInt(dateParts[0], 10);
                        var mm = parseInt(dateParts[1], 10) - 1; // JS months 0-11
                        var yyyy = parseInt(dateParts[2], 10);

                        var eventDate = new Date(yyyy, mm, dd);

                        // Compare event date with today
                        if (event.extendedProps.STATUS ==="S") {
                            circle.style.backgroundColor = '#dc3545'; //For Schedule  Records
                        } else if (event.extendedProps.STATUS === "V" ) {
                            circle.style.backgroundColor = '#28a745'; //For Verified Records
                        }
                        else if ((event.extendedProps.STATUS === "O" && event.extendedProps.TUMOR_REFER === "Y") || (event.extendedProps.STATUS === "O" && event.extendedProps.TUMOR_REFER === "N")) {
                            circle.style.backgroundColor = '#ffc107'; // for Completed Records
                        }
                    }

                }
                // Event text: Name + Time only visually
                const title = document.createElement('span');
                title.style.color = 'white';
                title.style.overflow = 'hidden';
                title.style.textOverflow = 'ellipsis';
                title.style.whiteSpace = 'nowrap';
                title.style.flexGrow = '1';
                title.style.minWidth = '0';
                title.style.fontSize = '12px';
                title.style.fontWeight = '500';

                let displayText = event.title; // Name only
                if (viewType !== 'listWeek' && event.extendedProps && event.extendedProps.TBMSTIME) {
                    var timeParts = event.extendedProps.TBMSTIME.split(':');
                    var hour = parseInt(timeParts[0], 10);
                    var minutes = timeParts[1];
                    if (minutes.length < 2) minutes = '0' + minutes;

                    var ampm = (hour >= 12) ? 'PM' : 'AM';
                    hour = hour % 12;
                    if (hour === 0) hour = 12;

                    displayText += ' - ' + hour + ':' + minutes + ' ' + ampm; // Name – Time visually
                }
                title.innerText = displayText;

                // Container
                const container = document.createElement('div');
                container.style.display = 'flex';
                container.style.alignItems = 'center';
                container.style.overflow = 'hidden';
                container.style.width = '100%';
                //container.style.backgroundColor = '#007bff';
                container.style.borderRadius = '4px';
                container.style.padding = '2px 6px';
                container.style.color = 'white';
                if (event.extendedProps) {
                    var tbmsStatus = event.extendedProps.STATUS;
                    var tbmsTumorRef = event.extendedProps.TUMOR_REFER;

                    if ( tbmsTumorRef === "Y") {
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
                    tooltipLines.push('DOB : ' + (props.PATDOB || ''));
                    tooltipLines.push('Schedule Date : ' + (props.TBMSDATE || ''));
                    if (props.TBMSTIME) {
                        var timeParts = props.TBMSTIME.split(':');
                        var hour = parseInt(timeParts[0], 10);
                        var minutes = timeParts[1];
                        if (minutes.length < 2) minutes = '0' + minutes;
                        var ampm = (hour >= 12) ? 'PM' : 'AM';
                        hour = hour % 12;
                        if (hour === 0) hour = 12;
                        tooltipLines.push('Schedule Time : ' + hour + ':' + minutes + ' ' + ampm);
                    } else {
                        tooltipLines.push('Schedule Time : ');
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
        var gDoctCode = '<%: Session["gDoctCode"] ?? "" %>';
        var DataToSend = {
            strDoctCode: gDoctCode,
            type: "C"
        };

        $.ajax({
            url: '../DoctorDesk/GetDoctorsMeetingDet',
            type: 'post',
            datatype: 'json',
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
                        //+ " - " + (a.TBMSTIME ? a.TBMSTIME.trim() : '');

                   
                });

                calendar.removeAllEvents();
                calendar.addEventSource(AllEventDtls);
            },
            complete: function () {
                HoldOn.close();
            }
        });
    }

    //For Popup Diagnosis And ICD-O
    function OpenPopInfoScheme(Mrno, Tranno,Name) {
        document.getElementById("InfoHeadLabel").innerText = "        Diagnosis Info"+" ("+Name+")";
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
            url: 'SetDataForDiagnosis',
            type: 'post',
            datatype: 'json',
            data: DataToSend,
            async: false,
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
                HoldOn.close();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                HoldOn.close();
            }
        });
    }

    //Print for Tumor Board
    function PrintService(Mrno, tranNo) {
        //let tranNo = $("#txtTranno").val();
        //let Mrno = $("#txtUCMrNo").val();

        if (!tranNo) {
            $.messager.alert("Transaction No Missing", "Information");
        }

        let dataToSend = {
            MrNo: Mrno,
            TranNo: tranNo

        }
        HoldOn.open();
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: 'PrintTumorBrdDisc',
            data: dataToSend,
            success: function (response) {
                console.log("response =>", response);
                if (response == "sucess") {
                    let a = document.createElement('a');
                    a.href = 'PrintTumorTransactionAction';
                    a.target = '_blank';
                    a.click();
                }
                else {
                    $.messager.alert("Please try again", "Information");
                }

            },
            error: function (xhr, status, error) {

            },
            complete: function () {
                HoldOn.close();
            }
        });
    }
</script>



<div id="calendar"></div>
<div style="display: block;text-align: center; align-items: center; justify-content: center; margin: 10px 0px;" id="DivSaveBtn">
     <div style="display: inline-block;float:left">
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%;  flex-shrink: 0; background-color: #2364b5;"></span>
        <label style="margin-right:15px">Refer To Tumor Board</label>
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%;  flex-shrink: 0; background-color: #f37b00;"></span>
        <label style="margin-right:15px">Not Refer To Tumor Board</label>
    </div>
    <div style="display: inline-block;float: right;margin-right: 20px;">
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%;  flex-shrink: 0; background-color: red;"></span>
        <label style="margin-right:15px">Schedule</label>
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%;  flex-shrink: 0; background-color: #ffc107;"></span>
        <label style="margin-right:15px">Completed</label>
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%;  flex-shrink: 0; background-color: rgb(0, 255, 0);"></span>
        <label >Verified</label>
    </div>
</div>
     <div id="POPUPInfoModal" class="SchemeModal" style="justify-content: center; align-items: center ; display:none;">
        <div class="Scheme-modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv SchemeHeader">
                <label id="InfoHeadLabel"></label>
                <span class="closeMdlBtn"  onclick="ClosePop('POPUPInfoModal');">&times;</span>
            </div>
            
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
        <input type="button" onclick="PrintService(mrno,tranno)" class="" style="width: 100px; font-size: 13px; text-align: center; display: none; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px; margin-left: 50%; " id="btnPrint"   value="Print">
        </div>

    </div>


