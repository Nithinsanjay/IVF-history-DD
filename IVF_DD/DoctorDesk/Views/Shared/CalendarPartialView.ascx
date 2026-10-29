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



<script type="text/javascript">
    var calendar;
    var AllEventDtls = [];
    var FData = [];
    var ApprovelList = [];
    var SDocName = 'Dr. ' + '<%:Session["gDoctName"]%>';
    var AllDoctLeaveDtls = [];
    var DoctInfoFlag = false;
    function initializeCalendar() {
        //debugger;
        document.getElementById("btnContinueCalender").style.display = CalenderActionType == "Y" ? "none" : "inline-block";
        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            //customButtons: {
            //    customListView: {
            //        text: 'Custom List',
            //        click: function () {
            //            calendar.changeView('customList');
            //        }
            //    }
            //},
            selectable: true,
            editable: true,
            eventDurationEditable: false,
            contentHeight: '90%', // or use fixed height
            height: '95%', // optional
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

                    if (props.PACYN != "P" && props.PREAUTHYN === "A" && props.OTBOOKYN !== "P" && props.DOCTORAPPROVAEDYN === "Y") {
                        Circle.style.backgroundColor = '#00ff00';
                    } else if (props.PACYN != "P" || props.PREAUTHYN === "A" || props.OTBOOKYN !== "P" || props.DOCTORAPPROVAEDYN === "Y") {
                        Circle.style.backgroundColor = 'yellow';
                    } else {
                        Circle.style.backgroundColor = 'red';
                    }
                    tooltipLines.push(('Name : ') + (props.PATNAME));
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
                if (CalenderActionType == "Y") {
                    $.grep(AllEventDtls, function (a) {
                        if (a.TRANNO == eventId && a.ACT != "N") {
                            Flag = false;
                        }
                    });
                }
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
        //calendar.addEvent({
        //    id: Id,
        //    title: TitleContent,
        //    start: start,
        //    backgroundColor: '#ffc107', 
        //    borderColor: '#ff9800',     
        //    textColor: '#000000'        
        //});
        UpdateDataSendToSave($.session.get('PatTRANNO'), start, $("#txtSurgeryAdvice").val(), sessionStorage.getItem('PatMRNO'), sessionStorage.getItem('PatName'), StrDocCode, SDocName.toString().trim());
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
                               (e.PACYN == "U" ? "<label class='UnFit'>Unfit</label>" : ""));//priyanka 20/11/2025
                var PACTd = e.PACYN == "P" ? CancelIcon : (PACContent != "" ? PACContent : AcceptIcon)
                $('#eventMRNO').val(e.MRNO);
                $('#eventPatName').val(e.PATNAME);
                $('#eventDoctor').val(e.DOCTNAME);
                $('#eventPACDate').val(e.PACSURGADVDATE == "" ? "" : ConvertDateToFormat(start, true));
                $('#eventTitle').val(e.SURGERY);
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
        if (CalenderActionType == "Y") {
            $("#txtAdviceDate").val(ConvertStrDateToFormat(Date));
            $("#txtPACAdviceDate").val(getPreviousDate(Date));
        }
    }

    function GetCalenderData(FromDate, ToDate) {
        //debugger;
        var DataToSend = {
            FDate: FromDate,
            TDate: ToDate
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
                if ($("#txtSurgeryAdvice").val() != "" && CalenderActionType == "Y") {
                    var TNo =sessionStorage.getItem('PatTRANNO');
                    data = data.filter(function (item) { return item.TRANNO != TNo });
                    SetSurgyAdv();
                    FData = SendEventToSave.filter(function (item) { return item.ACT === 'N'; });
                }
                AllEventDtls = AllEventDtls.concat(data);
                if (SendEventToSave.length > 0) {
                    const sendEventIds = SendEventToSave.map(function (a) { return a.TRANNO; });
                    const filteredAllEventDtls = AllEventDtls.filter(function (k) { return !sendEventIds.includes(k.TRANNO); });
                    AllEventDtls = filteredAllEventDtls.concat(SendEventToSave);
                }
                $.grep(AllEventDtls, function (a) {
                    a.id = a.TRANNO;
                    a.start = a.SURGADVDATE;
                    a.title = a.SURGERY;
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
                HoldOn.close();
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
                $.messager.confirm("Confirmation", "Updated Successfully", function (result) {
                    CalenderFancyClose = true;
                    if (result) {
                        window.location.reload();
                    }
                    else {
                        window.location.reload();
                    }
                });
                $(".ui-dialog-titlebar-close").hide();
                $('.ui-dialog-buttonset button').each(function () {
                    if ($(this).text().trim() === 'Cancel') {
                        $(this).hide();
                    }
                });
            },
            complete: function () {
                HoldOn.close();
            }
        });
    }

    function BeforeCloseValidation() {
        if (SendEventToSave.length > 0) {
            $.messager.confirm("Confirmation", "Do You Want To Close ?", function (result) {
                if (result) {
                    $.fancybox.close();
                }
            });
        } else {
            $.fancybox.close();
        }
    }

    function BeforeSaveAlert() {
        if (SendEventToSave.length > 0) {
            CalenderFancyClose = false;
            OpenCloseAlert("O", 'DivAlertSave');
            BindChangedEvent();
        } else {
            CalenderFancyClose = true;
            $.fancybox.close();
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
                    $.messager.alert("Information", "No Data Found");
                }
            },
            complete: function () {
                HoldOn.close();
            }
        });
    }
    function OpenAdviceListPopup() {
        //debugger;
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
        //debugger;
        var Tr = "<tr id='{TRID}'>{TRCONTENT}</tr>";
        var Td = "<td {TDSTYLE}>{TDCONTENT}</td>";
        var Accept = "<i class='fa fa-check AcceptStatus' aria-hidden='true'></i>";
        var Cancel = "<i class='fa fa-times CancelStatus' aria-hidden='true'></i>";
        var NAIcon = "<label style='font-weight: bold;color: black;'>NA</label>";
        var Action = "<input type='checkbox' onclick='UpdateApproveList(this.id);' class='AdvListChckbox' id='{CHECKBOXID}' {DISABLED} />";
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
            var ActionTd = Td.replace("{TDCONTENT}", (Action.replace("{CHECKBOXID}", ("ADVCHK_" + a.CONSNO)).replace("{DISABLED}", Disabled))).replace("{TDSTYLE}", "style='text-align:center;'");
            var ConsNoTd = Td.replace("{TDCONTENT}", a.CONSNO).replace("{TDSTYLE}", "");
            var MrnoTd = Td.replace("{TDCONTENT}", a.MRNO).replace("{TDSTYLE}", "");
            var PatNameTd = Td.replace("{TDCONTENT}", a.PATNAME).replace("{TDSTYLE}", "");
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
            var AllTd = ActionTd + ConsNoTd + MrnoTd + PatNameTd + SurgyDateTimeTd + AdvDateTd + AdvNameTd + AdvTypeTd + DoctCodeTd + DoctNameTd + PACTd + PreAuthTd + OTBookTd + DoctApprvlTd + SurgeryStatusTd;
            var FinalAppendTr = Tr.replace("{TRCONTENT}", AllTd).replace("{TRID}", ("TR_" + a.CONSNO));
            $("#tblAdviceListBody").append(FinalAppendTr);
        });
    }

    function ValidationForApprovel(Type) {
        var FilterList = ApprovelList.filter(function (item) { return item.CHECKED == 'Y' && item.OTBOOKSTATUS != "P"; });
        if (FilterList.length == 0) {
            $.messager.alert("Information", "No Data Found To Save");
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
                    $.messager.alert("Information", data);
                    CloseAdviceListPopup();
                    GetAdvPatList($("#txtCALSELDATE").val());
                },
                complete: function () {
                    HoldOn.close();
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


    //function buildCustomListHtml(arg) {
    //    let events = calendar.getEvents();   // all events shown in calendar
    //    let html = `
    //        <div style="padding:10px;">
    //            <h3>Custom Surgery / Patient List</h3>
    //            <table class="table table-bordered table-striped">
    //                <thead>
    //                    <tr>
    //                        <th>Date</th>
    //                        <th>Patient</th>
    //                        <th>PAC</th>
    //                        <th>Pre-Auth</th>
    //                        <th>OT Booking</th>
    //                        <th>Doctor Approved</th>
    //                    </tr>
    //                </thead>
    //                <tbody>
    //    `;
    //    events.forEach(ev => {
    //        const props = ev.extendedProps;
    //    html += `
    //        <tr>
    //            <td>${ev.start.toLocaleDateString()}</td>
    //            <td>${props.PATNAME || ''}</td>
    //            <td>${props.PACYN || ''}</td>
    //            <td>${props.PREAUTHYN || ''}</td>
    //            <td>${props.OTBOOKYN || ''}</td>
    //            <td>${props.DOCTORAPPROVAEDYN || ''}</td>
    //        </tr>
    //        `;
    //});
    //html += `
    //            </tbody>
    //        </table>
    //    </div>
    //`;
    //return { html: html };
    //}

</script>


<div id="calendar"></div>
<div style="display: block;text-align: center; align-items: center; justify-content: center; margin: 10px 0px;" id="DivSaveBtn">
    <input type="button" onclick="BeforeSaveAlert()" class="" style="display: inline-block;width: 100px; font-size: 13px; text-align: center; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" id="btnContinueCalender" value="Continue">
    <div style="display: inline-block;float: right;margin-right: 20px;">
        <span style="display: inline-block;">⚕️</span>
        <label>Doctor Leave</label>
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; margin-right: 5px; flex-shrink: 0; background-color: red;"></span>
        <label>Pending</label>
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; margin-right: 5px; flex-shrink: 0; background-color: yellow;"></span>
        <label>Partial Pending</label>
        <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; margin-right: 5px; flex-shrink: 0; background-color: rgb(0, 255, 0);"></span>
        <label>Completed</label>
    </div>
</div>

<div id="eventModal" class="EModal" style="justify-content: center; align-items: center;">
    <div class="modal-content">
        <input type="hidden" id="eventId" />
        <div class="ModelHeaderDiv">
            <label>Surgery Advice Information</label>
            <span id="closeModalBtn" onclick="document.getElementById('eventModal').style.display = 'none';">&times;</span>
        </div>
        <div class="ModelContentDiv">
            <table>
                <tr>
                    <td style="vertical-align: top;">
                        <div style="padding: 5px 0px 5px 0px;">
                            <label class="ModelLbl">MR No.</label>
                        </div>
                    </td>
                    <td>
                        <div style="padding: 5px 0px 5px 0px;">
                            <input type="text" id="eventMRNO" style="width: 200px;" readonly />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;">
                        <div style="padding: 5px 0px 5px 0px;">
                            <label class="ModelLbl">Patient Name</label>
                        </div>
                    </td>
                    <td>
                        <div style="padding: 5px 0px 5px 0px;">
                            <input type="text" id="eventPatName" style="width: 200px;" readonly />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;">
                        <div style="padding: 5px 0px 5px 0px;">
                            <label class="ModelLbl">Doctor</label>
                        </div>
                    </td>
                    <td>
                        <div style="padding: 5px 0px 5px 0px;">
                            <input type="text" id="eventDoctor" style="width: 200px;" readonly />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;">
                        <div style="padding: 5px 0px 5px 0px;">
                            <label class="ModelLbl">Surgery Adviced Date</label>
                        </div>
                    </td>
                    <td>
                        <div style="padding: 5px 0px 5px 0px;">
                            <input type="text" id="eventStartDate" style="width: 200px;" readonly />
                        </div>
                    </td>
                </tr>


                <tr>
                    <td style="vertical-align: top;">
                        <div style="padding: 5px 0px 5px 0px;">
                            <label class="ModelLbl">PAC Advice Date</label>
                        </div>
                    </td>
                    <td>
                        <div style="padding: 5px 0px 5px 0px;">
                            <input type="text" id="eventPACDate" style="width: 200px;" readonly />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;">
                        <div style="padding: 5px 0px 5px 0px;">
                            <label class="ModelLbl">Surgery name</label>
                        </div>
                    </td>
                    <td>
                        <div style="padding: 5px 0px 5px 0px;">
                            <textarea id="eventTitle" style="width: 200px; height: 60px;"></textarea>
                        </div>
                    </td>
                </tr>
            </table>

            <table class="tblAdviceList" style="min-height:auto !important">
                <thead>
                    <tr>
                        <td style="text-align: center;">PAC</td>
                        <td style="text-align: center;">Pre-Auth</td>
                        <td style="text-align: center;">OT Booking</td>
                        <td style="text-align: center;">Doctor Approved</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="text-align: center;" id="tdPAC"><i class='fa fa-times CancelStatus' aria-hidden='true'></i></td>
                        <td style="text-align: center;" id="tdPreAuth"><i class='fa fa-times CancelStatus' aria-hidden='true'></i></td>
                        <td style="text-align: center;" id="tdOTBook"><i class='fa fa-times CancelStatus' aria-hidden='true'></i></td>
                        <td style="text-align: center;" id="tdDoctAppr"><i class='fa fa-times CancelStatus' aria-hidden='true'></i></td>
                    </tr>
                </tbody>
            </table>


        </div>
    </div>
</div>

<div id="AdviceModal" class="AEModal" style="justify-content: center; align-items: center;">
    <div class="Amodal-content">
        <div class="ModelHeaderDiv">
            <label>Approval List</label>
            <i id="closeAModalBtn" class='fa fa-times CloseIcon' style="font-size: 23px;margin-right: 10px;color: #ff0000;" aria-hidden='true' onclick="CloseAdviceListPopup()"></i>
        </div>
        <div class="ModelContentDiv">
            <input type="text" id="txtCALSELDATE" style="display:none" />
            <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888;overflow: auto;margin: 0px 10px;">
                <div class="Tablewrapper" style="font-size: 12px; background: white;">
                    <table id="tblAdviceList" class="tblAdviceList">
                        <thead>
                            <tr>
                                <th>Action</th>
                                <th style="min-width: 150px;">Consultation No.</th>
                                <th style="min-width: 100px;">MR No.</th>
                                <th style="min-width: 150px;">Patient Name</th>
                                <th style="min-width: 120px;">Surgery Date Time</th>
                                <th style="min-width: 110px;">Adviced for Date</th>
                                <th style="min-width: 150px;display:none">Adviced Code</th>
                                <th style="min-width: 180px;">Surgery Adviced Name</th>
                                <th style="min-width: 115px;">Nature of Surgery</th>
                                <th style="min-width: 150px;display:none">Doctor Code</th>
                                <th style="min-width: 150px;">Doctor Name</th>
                                <th style="min-width: 65px;">PAC</th>
                                <th style="min-width: 65px;">Pre-Auth</th>
                                <th style="min-width: 80px;">OT Booking</th>
                                <th style="min-width: 110px;">Doctor Approved</th>
                                <th style="min-width: 60px;">Surgery</th>
                            </tr>
                        </thead>
                        <tbody id="tblAdviceListBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div style="display: flex; align-items: center; justify-content: center; margin: 10px 10px;">
                <label style="padding-right: 20px;">Remark</label>
                <textarea id="txtScheduleRemarks" class="form-control" onchange="MakeNormal(this.id);"></textarea>
            </div>
            <div style="margin: 10px 0px;text-align: center;width: 100%;" id="DivApproSaveBtn">
                <input type="button" onclick="SaveApproveList('Y')" class="" style="display: inline-block;width: 100px; font-size: 13px; text-align: center; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" value="Approve">
                <input type="button" onclick="SaveApproveList('R')" class="" style="display: inline-block;width: 100px; font-size: 13px; text-align: center; cursor: pointer; color: white !important; margin-left: 10px;background-color: #f93c3c; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" value="Reject">
                <div style="float: right;padding-right: 20px;display: flex;align-items: center;margin-top: 7px;">
                    <i class="fa fa-check AcceptStatus" style="padding-right: 5px;" aria-hidden="true"></i>
                    <label style="margin: 0px;padding-right: 15px;">Action Completed</label>
                    <i class="fa fa-times CancelStatus" style="padding-right: 5px;" aria-hidden="true"></i>
                    <label style="margin: 0px;padding-right: 15px;">Action Pending</label>
                    <span class="verified-badge" style="position: relative;right: 5px;top: 0px;float: none;"></span>
                    <label style="margin: 0px;padding-right: 15px;">PAC Valid</label>
                    <span class="not-verified-badge" style="position: relative;right: 5px;top: 0px;float: none;"></span>
                    <label style="margin: 0px;">PAC Not Valid</label>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="DoctLeaveModal" class="EModal" style="justify-content: center; align-items: center;">
    <div class="modal-content">
        <div class="ModelHeaderDiv">
            <label id="LblHeadDoctLeave">Doctor Leave Information</label>
            <i class='fa fa-times CloseIcon' style="font-size: 23px;margin-right: 10px;color: #ff0000;" aria-hidden='true' onclick="OpenCloseInfoPopup('C')"></i>
        </div>
        <div class="ModelContentDiv">
            <table class="tblAdviceList" style="min-height:auto !important">
                <thead>
                    <tr>
                        <td style="text-align: center;">SI.NO</td>
                        <td style="text-align: center;">Doctor Name</td>
                    </tr>
                </thead>
                <tbody id="tblDoctLeave">
                </tbody>
            </table>
        </div>
    </div>
</div>
