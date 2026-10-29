var AllHistoryData = [];

function OpenCloseHistoryInfo(Type) {
    if (Type == "O") {
        $("#btnPrevHistoryInfo").fancybox({
            openEffect: 'elastic',
            openSpeed: 100,
            closeEffect: 'elastic',
            closeSpeed: 100,
            helpers: {
                overlay: { closeClick: false }
            },
            autoDimensions: false,
            cyclic: true,
            showNavArrows: true,
            beforeShow: function () {
            },
            afterShow: function () {
                $(document).on('click', '.ExColicon', function (e) {
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
                $("#DivPrevHistContent").empty();
                GetBindPrevHistoryDtls();
            }
        });
        $("a#btnPrevHistoryInfo").click();
    }
    else {

    }
}

function GetBindPrevHistoryDtls() {
    var page = window.location.href;
    var mrno = ($.session.get('PatMRNO'));
    if ($("#txtFromDate").val() == "" || $("#txtToDate").val() == "") {
        $.messager.alert("Information", "Please Select Date");
    }
    var FromDate = $("#txtFromDate").val();
    var ToDate = $("#txtToDate").val();
    $.ajax({
        type: "POST",
        url: 'GetMedicationtHistory',
        datatype: "json",
        data: { strMrNo: mrno, FromDate: FromDate, ToDate: ToDate, DoctCode: "" },
        success: function (result) {
            AllHistoryData = result;
            BindPrevHistoryDtls();
        }
    });
}

function BindPrevHistoryDtls() {
    var page = window.location.href;
    if (page.toUpperCase().includes("COMPLAINTS")) {
        ComplaintsHistoryInfo();
    }
    if (page.toUpperCase().includes("EXAMINATION")) {
        ExaminationHistoryInfo();
    }
}

function ConvertTo12Hour(SType, FTime) {
    var FormatedTime = FTime;
    if (SType === "O") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    else if (SType === "P") {

    }
    else if (SType === "S") {
    }
    else if (SType === "C") {

    }
    else if (SType === "R") {

    }
    else if (SType === "N") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    else if (SType === "D") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    return FormatedTime;
}

function CopyHistory(FullTranYN , TranID , SpecificCode) {
    var page = window.location.href;
    if (page.toUpperCase().includes("COMPLAINTS")) {
        CopyComplaintsHistory(FullTranYN, TranID, SpecificCode);
        CopyMessage();
    }
    if (page.toUpperCase().includes("EXAMINATION")) {
        CopyExaminationHistory(FullTranYN, TranID, SpecificCode);
        CopyMessage();
    }
}

function CopyMessage() {
    $("#GlobalCopyToast")
         .text("Copied successfully!")
         .fadeIn(200);

    setTimeout(function () {
        $("#GlobalCopyToast").fadeOut(300);
    }, 2000);
}

//#region Complaint
function ComplaintsHistoryInfo() {
    var ConsultLst = AllHistoryData[0];
    var CompliantLst = AllHistoryData[2];
    var $divPanel = $('<div>', { style: '', class: 'panel' });
    for (var i = 0; i < ConsultLst.length; i++) {
        var ConsultNo = ConsultLst[i].TRANNO;
        if (ConsultNo != ($.session.get('PatTRANNO'))) {
            var ConsultCompltFilterDT = CompliantLst.filter(function (x) { return x.TRANNO == ConsultNo });
            if (ConsultCompltFilterDT.length > 0) {
                var $divPanelHead = $('<div>', { style: 'font-size:13px;margin: 10px 0px;border-radius: 0px;', class: 'panel-heading divHeads' });
                var strTable = "<table style='width:100%'>" +
                    "<tr>" +
                    (sessionStorage.getItem('PatCompleted') == "Y" ? "" : "<td class='copyHisCls'><span><i class='fa fa-clone'  aria-hidden='true' style='font-weight:700;cursor:pointer'onclick=\"CopyHistory('Y', '" + ConsultLst[i].TRANNO.toString() + "','')\" title='Copy' ></i></span></td>") +
                "<td class='ExColicon' style='text-align: right;'>" + (ConsultLst[i].DOCTNAME.toString() == "" ? "" : ("Dr." + ConsultLst[i].DOCTNAME.toString() + (ConsultLst[i].SPECNAME.toString() == "" ? "" : " (" + ConsultLst[i].SPECNAME.toString() + ")"))) + "</td>" +
                "<td class='ExColicon' style='text-align: right;'>" + ConsultLst[i].TRANDATE + " " + ConvertTo12Hour("O", ConsultLst[i].TRANTIME) + "</td>" +
                "<td rowspan='2' class='ExColicon' style='width: 30px;text-align: center;'><span class='fa fa-caret-down spanCls'></span></td>" +
                "</tr></table>";
                $divPanelHead.append(strTable);
                var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block;width: 100%;height: auto;padding: 0px;', class: 'panel-body divBody' });
                var Complt = "<ul class='liClass'>";
                $.grep(ConsultCompltFilterDT, function (a) {
                    var dash = (a.REMARKS == "") ? "" : "-";
                    var CopyIcon = sessionStorage.getItem('PatCompleted') == "Y" ? "" : "<span style='width: 25px;display: inline-block;'><i class='fa fa-clone'  aria-hidden='true' style='font-weight:700;cursor:pointer'onclick=\"CopyHistory('N', '" + ConsultLst[i].TRANNO.toString() + "','" + a.DESCCD + "')\" title='Copy' ></i></span>";
                    var totalDurationString = Number(a.DURATION) > 0 ? " since " + a.DURATION + " " + a.DURTYPE : "";
                    Complt += "<li>" + CopyIcon + a.NAME + dash + a.REMARKS + totalDurationString + "</li>";
                });
                Complt += "</ul>";
                $divPanelBody.append(Complt);
                $divPanel.append($divPanelHead);
                $divPanel.append($divPanelBody);
                $("#DivPrevHistContent").append($divPanel);
            }
        }
    }
}

function CopyComplaintsHistory(FullTranYN, TranID, SpecificCode) {
    if (FullTranYN == "Y") {
        var FilterRows = AllHistoryData[2].filter(function (x) { return x.TRANNO == TranID });
        $.grep(FilterRows, function (a) {
            var row = $("#tblCmplts tr[id*='" + a.DESCCD + "']");
            if (row.length > 0)
                ComplaintsPresentTable(a);
            else
                ComplaintsNotPresentTable(a);
        });
    }
    else {
        var FilterRows = AllHistoryData[2].filter(function (x) { return x.TRANNO == TranID && x.DESCCD == SpecificCode });
        var row = $("#tblCmplts tr[id*='" + SpecificCode + "']");
        if (row.length > 0)
            ComplaintsPresentTable(FilterRows[0]);
        else
            ComplaintsNotPresentTable(FilterRows[0]);
    }
}

function ComplaintsPresentTable(Lst) {
    $("#" + Lst.DESCCD).prependTo("#tblCmplts tbody");
    if (!$("#tblCmplts tr[id*='" + Lst.DESCCD + "']").hasClass("active")) {
        $("#" + Lst.DESCCD).addClass("active");
    }
    $("#Days" + Lst.DESCCD).text(Lst.DURTYPE.substring(0, 1).toLocaleUpperCase());
    $("#Num" + Lst.DESCCD).text(Lst.DURATION);
    $(".tdSetUpYn").text("N");
    $("#" + Lst.DESCCD).find(".trigger3").show();
    $("#Days" + Lst.DESCCD).show();
    $("#Num" + Lst.DESCCD).show();
    if (Lst.REMARKS != "") {
        $("#" + Lst.DESCCD).find(".CmplntNm").empty();
        $("#" + Lst.DESCCD).find(".CmplntNm").append(Lst.NAME + '<strong><span style="font-size:14px;">   -  </span></strong>' + Lst.REMARKS);
        $("#" + Lst.DESCCD).find(".RemarkText").text(Lst.REMARKS);
    }
}

function ComplaintsNotPresentTable(Lst) {
    var Complt = Lst.REMARKS != "" ? (Lst.NAME + '<strong><span style="font-size:14px;">   -  </span></strong>' + Lst.REMARKS) : Lst.NAME;
    var rows = "<tr class='clickable-row" + ' Tr' + (Lst.DESCCD) + " active'  id='" + Lst.DESCCD.trim() + "'>" + "<td style='padding:5px;text-align:left; font-size: 14px;text-align:left;width:65%' class='CmplntNm'>" + Complt.trim() + "</td>" +
     "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + Lst.DESCCD.trim() + "' style='font-weight:800;font-size:16px'>" + Lst.DURTYPE.substring(0, 1).toLocaleUpperCase() + "</a></td>" +
     "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + Lst.DESCCD.trim() + "' style='font-weight:800;font-size:16px'>" + Lst.DURATION + "</a></td>" +
     "<td class='complainRemark' style='width:15%'><a class='trigger3' href='javascript:;' onclick='AddComplainRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
     "<td class='tdSetUpYn' style='display:none;'>N</td>" + 
     "<td class='RemarkText' style='display:none;'>" + Lst.REMARKS.trim() + "</td>" +
     "</tr>";
    $('#tblCmplts tbody').prepend(rows);
}
//#endregion

//#region Examination
function ExaminationHistoryInfo() {
    var ConsultLst = AllHistoryData[0];
    var ExaminationLst = AllHistoryData[5];
    var $divPanel = $('<div>', { style: '', class: 'panel' });
    for (var i = 0; i < ConsultLst.length; i++) {
        var ConsultNo = ConsultLst[i].TRANNO;
        if (ConsultNo != ($.session.get('PatTRANNO'))) {
            var ConsultExamFilterDT = ExaminationLst.filter(function (x) { return x.TRANNO == ConsultNo && x.EXAM != "" });
            if (ConsultExamFilterDT.length > 0) {
                var $divPanelHead = $('<div>', { style: 'font-size:13px;margin: 10px 0px;border-radius: 0px;', class: 'panel-heading divHeads' });
                var strTable = "<table style='width:100%'>" +
                    "<tr>" +
                    (sessionStorage.getItem('PatCompleted') == "Y" ? "" : "<td class='copyHisCls'><span><i class='fa fa-clone'  aria-hidden='true' style='font-weight:700;cursor:pointer'onclick=\"CopyHistory('Y', '" + ConsultLst[i].TRANNO.toString() + "','')\" title='Copy' ></i></span></td>") +
                "<td class='ExColicon' style='text-align: right;'>" + (ConsultLst[i].DOCTNAME.toString() == "" ? "" : ("Dr." + ConsultLst[i].DOCTNAME.toString() + (ConsultLst[i].SPECNAME.toString() == "" ? "" : " (" + ConsultLst[i].SPECNAME.toString() + ")"))) + "</td>" +
                "<td class='ExColicon' style='text-align: right;'>" + ConsultLst[i].TRANDATE + " " + ConvertTo12Hour("O", ConsultLst[i].TRANTIME) + "</td>" +
                "<td rowspan='2' class='ExColicon' style='width: 30px;text-align: center;'><span class='fa fa-caret-down spanCls'></span></td>" +
                "</tr></table>";
                $divPanelHead.append(strTable);
                var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block;width: 100%;height: auto;padding: 0px;', class: 'panel-body divBody' });
                var ExamDtls = "<p style='font-size:13px;font-weight:500;padding: 0px 10px;width:99%'>" + ConsultExamFilterDT[0].EXAM.toString().replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p>";
                $divPanelBody.append(ExamDtls);
                $divPanel.append($divPanelHead);
                $divPanel.append($divPanelBody);
                $("#DivPrevHistContent").append($divPanel);
            }
        }
    }
}

function CopyExaminationHistory(FullTranYN, TranID, SpecificCode) {
    var FilterRows = AllHistoryData[5].filter(function (x) { return x.TRANNO == TranID });
    var prevText = $("#txtexam").val().trim();
    if (prevText.length > 0) {
        $("#txtexam").val(prevText + "\n" + FilterRows[0].EXAM);
    } else {
        $("#txtexam").val(FilterRows[0].EXAM);
    }
}

//#endregion