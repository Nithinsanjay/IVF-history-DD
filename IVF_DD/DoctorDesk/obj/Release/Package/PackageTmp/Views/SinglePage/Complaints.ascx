<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style>
textarea {
    box-sizing: border-box;
 }
</style>

<%-- Complaints Form --%>
<script type="text/javascript">
    var RMOFlagCompltYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECOMPLAINTSYN")%>' == "Y" ? "N" : "Y") : "N";
    var SessionCompComplaint = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagCompltYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');

    //changes done by Haritha on 25/02/2026
    var complaintsListtable;
    $(document).ready(function () {
        // Added By Abhishesh || 20260321
        $("#btnFitToContent").on("click", function () {

            fitToContent('Complaints_Freetext');

        });
        $("#btnSetMaxHeight").on("click", function () {

            setMaxHeight('Complaints_Freetext');

        });
        // End
        /* Tabulator For Complaints */
        var isVisitCompleted = (typeof SessionCompComplaint !== 'undefined' && SessionCompComplaint === "Y");
        complaintsListtable = new Tabulator("#ComplaintsTable", {
            layout: "fitColumns",
            scrollToRowPosition: "nearest",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "100px",
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
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y";
                    },
                    formatter: function (cell) {
                        if (typeof SessionCompComplaint !== 'undefined' && SessionCompComplaint === "Y") {
                            return "";
                        }
                        return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y") {
                            cell.getRow().delete();
                            adjustTableHeight("ComplaintsTable");
                        }
                    }
                },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    width: 300,
                    formatter: "textarea",
                    formatterParams: {
                        minHeight: "auto",
                    },
                    cssClass: "wrap-text"
                },
                {
                    title: "Duration No",
                    field: "no",
                    width: 120,
                    tooltip: true,
                    editor: isVisitCompleted ? false : "list",
                    editorParams: function () {
                        let values = [];
                        for (let i = 0; i <= 30; i++) {
                            values.push({ label: i.toString(), value: i });
                        }

                        return {
                            values: values,
                            autocomplete: true,   
                            listOnEmpty: true,   
                            allowEmpty: false,
                        };
                    },
                    formatter: "lookup",
                    formatterParams: (function () {
                        let values = {};
                        for (let i = 0; i <= 30; i++) {
                            values[i] = i.toString();
                        }
                        return values;
                    })()
                },
                {
                    title: "Duration Category",
                    field: "type",
                    tooltip: true,
                    editor: isVisitCompleted ? false : "list",
                    width: 150,
                    editorParams: {
                        values: { "D": "Days", "W": "Weeks", "M": "Months", "Y": "Years" },
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: { "D": "Days", "W": "Weeks", "M": "Months", "Y": "Years" }
                },
                {
                    title: "Remark",
                    field: "remark",
                    formatter: "textarea",
                    editor: isVisitCompleted ? false : "textarea",
                    editorParams: {
                        elementAttributes: {
                            maxlength: "500",
                        },
                        verticalNavigation: "editor",
                        shiftEnterSubmit: true,
                    },
                    cssClass: "TabTextArea",
                    cellEdited: function (cell) {
                        adjustTableHeight("ComplaintsTable");
                    }
                },
                {
                    title: "SetUpYn",
                    field: "SetUpYn",
                    editor: false,
                    visible: false
                }
            ]
        });

        complaintsListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("ComplaintsTable");
        });

        complaintsListtable.on("rowDeleted", function (row) {
            adjustTableHeight("ComplaintsTable");
        });

        complaintsListtable.on("dataLoaded", function () {
            adjustTableHeight("ComplaintsTable");
        });

        complaintsListtable.on("tableBuilt", function () {
            adjustTableHeight("ComplaintsTable");
        });

        complaintsListtable.on("dataChanged", function () {
            adjustTableHeight("ComplaintsTable");
        });

        complaintsListtable.on("dataLoaded", function () {
            adjustTableHeight("ComplaintsTable");
        });

        /* Click Event on the Compliant Search List */
        $(document).on("click", ".complaint-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = complaintsListtable.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].code === code) {
                    ToastMsg("Complaint already added", "warning");
                    $("#complaintListMainDiv").hide();
                    return;
                }
            }
            complaintsListtable.addRow({
                act: '<i class="fa fa-trash text-danger"></i>',
                code: code,
                name: name,
                type: "",
                no: "",
                remark: "",
                SetUpYn: ""
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("ComplaintsTable");
            });
            $("#complaintSearch").val("");
            $("#complaintListMainDiv").hide();
        });

        /* Bind Already Saved Complaints */
        SetDataForComplaints();

        /* Adjust of Height Of Complaints Table */
        adjustTableHeight("ComplaintsTable");
        if (sessionStorage.getItem("PatCompleted").toString() === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagCompltYN == "Y") {
            $("#sec-complaints *").attr("disabled", "disabled");
            $("#Complaints_PrevHistory").removeAttr("disabled");
        }
        else {
            $("#sec-complaints *").removeAttr("disabled");
        }
    });

    /* Search For Frequent Complaints */
    function GetFrequentComplaints() {
        var clinicCode = sessionStorage.getItem('ClinicCode');
        startLoading("Loading", "loading-Complaints-Search-List")
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetMainCompList",
            async: true,
            data: { ClinicCode: clinicCode },
            success: function (result) {
                var complaintsListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL") {
                        result = JSON.parse(result);
                        complaintsListData = result.Table1;
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                BindSearchListForComplaint(complaintsListData);
                stopLoading("loading-Complaints-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Complaints-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Search For All Complaints */
    function GetAllComplaintsList(FilterComplaintText = "", FilterComplaintCode = "", HistoryObj = "") {   //Pournima 16th June 2026
        var clinicCode = sessionStorage.getItem('ClinicCode');
        FilterComplaintText = $("#complaintSearch").val(); //Pournima 16th June 2026
        startLoading("Loading", "loading-Complaints-Search-List")
        $.ajax({
            type: "POST",
            async: true,
            url: "../DoctorDesk/GetDBComplainList",
            data: { complainName: FilterComplaintText, ClinicCode: clinicCode },
            success: function (result) {
                var complaintsListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL") {
                        result = JSON.parse(result);
                        complaintsListData = result.Table1;
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                FilterComplaintsData(complaintsListData, FilterComplaintCode, HistoryObj);
                stopLoading("loading-Complaints-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Complaints-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Compliants Data list */
    function FilterComplaintsData(complaintsListData, complaintsCode, HistoryObj) {
        var FilterComplList = complaintsListData;
        if (complaintsCode != "") {
            FilterComplList = complaintsListData.filter(item => item.CODE == complaintsCode);
        }
        BindSearchListForComplaint(FilterComplList);
        if (complaintsCode && complaintsCode !== "") {
            var $first = $("#complaintList .complaint-row").first();
            if ($first.length) {
                $first.trigger("click");
                if (HistoryObj != undefined && HistoryObj != null && HistoryObj != "") {
                    complaintsListtable.updateRow(complaintsCode, {
                        code: HistoryObj.code, name: HistoryObj.name, no: HistoryObj.no,
                        type: HistoryObj.type, remark: HistoryObj.remark, SetUpYn: HistoryObj.SetUpYn
                    });
                }
            }
        }
    }

    //Filter in HTML Search
    function FilterBindedSearchListForComplaint() {
        var SearchTxt = $("#complaintSearch").val().toLowerCase();
        var FlagForCallAllComplList = true;
        if (SearchTxt.length < 3) {
            $("#complaintList .complaint-row").each(function () {
                var name = $(this).data("name").toLowerCase();
                var code = $(this).data("code").toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    FlagForCallAllComplList = false;
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        if (FlagForCallAllComplList == true)
            GetAllComplaintsList($("#complaintSearch").val(), "");
    }

    //List Binding Functionality
    function BindSearchListForComplaint(complaintsData) {
        var $list = $("#complaintList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No complaints found</div>';
        if (complaintsData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < complaintsData.length; i++) {
                var item = complaintsData[i];
                /* var ListOption = '<div class="list-group-item complaint-row" data-code="' + item.CODE + '" data-name="' + item.NAME + '" style="cursor:pointer;">' + item.NAME + ' (' + item.CODE + ') </div>';*/
                var ListOption = '<div class="list-group-item complaint-row" data-code="' + item.CODE + '" data-name="' + item.NAME + '" style="cursor:pointer;">' + item.NAME + ' </div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#complaintList").append(AppendContentList);
        $("#complaintListMainDiv").show();
    }

    //Validation Functionality For Save Complaints
    function ValidationForComplaints(Type) {
        if (Type == "C") {
            var tableDataCompl = complaintsListtable.getData();
            for (var i = 0; i < tableDataCompl.length; i++) {
                 if (tableDataCompl[i].no == "" || tableDataCompl[i].no == "0") {
      
     const table = document.querySelector("#ComplaintsTable");
     if (table) {
         table.scrollIntoView({ behavior: "smooth", block: "start" });
     }
     ToastMsg("Select Duration No for " + tableDataCompl[i].name +" in Complaints.", "warning");
     return false;
 }
 if (tableDataCompl[i].durType == "") {
     const table = document.querySelector("#ComplaintsTable");
     if (table) {
         table.scrollIntoView({ behavior: "smooth", block: "start" });
     }
     ToastMsg("Select Duration Category for " + tableDataCompl[i].name + " in Complaints.", "warning");
     return false;
 }
            }
            return true;
        }
        return true;
    }

    function HASDataInComplaints() { //priyanka 16/04/2026
        var ComplaintTblData = complaintsListtable.getData();
        var ComplaintFreeText = $("#Complaints_Freetext").val();
        if (ComplaintTblData.length === 0 && (ComplaintFreeText === "" || ComplaintFreeText === null)) {
            return false;
        }
        else {
            return true;
        }
    }

    //Save Functionality For Complaints 
    function SaveForComplaints(DataSaveObj, Type) {
        var cmpltArr = [];
        var tableData = complaintsListtable.getData();
        var rows = tableData.map(function (row) {
            var newRow = {};
            for (var key in row) {
                if (row.hasOwnProperty(key) && key !== "act") {
                    newRow[key] = row[key];
                }
            }
            return newRow;
        });
        var FreeTextCompl = $("#Complaints_Freetext").val();
        for (var i = 0; i < rows.length; i++) {
            var code = rows[i].code;
            var durType = rows[i].type;
            var dur = rows[i].no;
            var ComplainRemark = rows[i].remark;
            var SetupYN = rows[i].SetUpYn;
            var a = {
                DESCCD: code,
                DURTYPE: durType,
                DURATION: dur,
                REMARKS: "" + ComplainRemark,
                GRPCD: "",
                SETUPYN: SetupYN, //Pending
            };
            cmpltArr.push(a);
        }
        DataSaveObj.strComplaints = JSON.stringify(cmpltArr);
        DataSaveObj.FreeComplaint = FreeTextCompl;
    }

    //Binding Functionality For Complaints 
    function SetDataForComplaints() {
        var tranNo = sessionStorage.getItem('PatTRANNO');
        if (!tranNo) return;
        startLoading("Loading", "loading-Complaints");
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/SetDataForComplaints",
            datatype: "json",
            data: { strTranNo: tranNo },
            success: function (data) {
                if (!data || !data[0] || data[0].length === 0) {
                    stopLoading("loading-Complaints");
                }
                else {
                    var existingRows = complaintsListtable.getData();
                    data[0].forEach(function (item) {
                        var exists = existingRows.some(function (r) {
                            return r.code === item.DESCCD;
                        });
                        if (exists) return;
                        complaintsListtable.addRow({
                            act: "",
                            code: item.DESCCD,
                            name: item.DESC,
                            type: item.DURTYPE || "",
                            no: item.DURATION || "",
                            remark: (item.REMARKS || "").trim(),
                            SetUpYn: item.SETUPYN || ""
                        });
                    });
                }
                if (data && data[1] && data[1][0] && data[1][0].FreeComplaint) {
                    $("#Complaints_Freetext").val(data[1][0].FreeComplaint);
                    fitToContent('Complaints_Freetext');
                    $("#btnFitToContent").hide();
                    $("#btnSetMaxHeight").show();
                }
                stopLoading("loading-Complaints");
            },
            error: function (xhr, status) {
                ToastMsg(status, "error");
                stopLoading("loading-Complaints");
            }
        });
    }

</script>

<%-- Add New Item For Complaints --%>
<script type="text/javascript">
    //Body Content For New Item Complaints
    function ContentForAddNewItemComplaints() {
        return `
             <div class="mb-3">
               <input id="txtComplaint" type="text" class="form-control complaint" maxlength="250" autocomplete="off" placeholder="Enter complaint" tabindex="2" />
             </div>
        `;
    }
    //Footer Content For New Item Complaints
    function FooterContentForAddNewItemComplaints() {
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('Complaints')" tabindex="3">Close</button>
        return `
            <button class="btn btn-primary" onclick="SaveNewItemForComplaints('Complaints')" tabindex="4">Save</button>
        `;
    }
    //Validation For New Item Complaints
    function ValidationForNewItemComplaits() {
        if ($("#txtComplaint").val().trim().length === 0) {
            ToastMsg("Enter Complaint", "warning");
            $("#txtComplaint").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Complaints
    function SaveNewItemForComplaints() {
        if (ValidationForNewItemComplaits() == true) {
            startLoading("Loading", "loading-Complaints-New-Item");
            $.ajax({
                type: "post",
                datatype: "json",
                url: "../DoctorDesk/AddComplaint",
                data: { strComplaint: $("#txtComplaint").val().trim(), strGrpCode: "" },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESS") !== -1) {
                        ToastMsg(response, "success");
                        var ComplaintNewcode = (response.match(/code\s+(\d+)/i) || ["", ""])[1];
                        var ComplaintNewText = $("#txtComplaint").val();
                        GetAllComplaintsList(ComplaintNewText, ComplaintNewcode);
                        closeAddNewItemPopup('Complaints');
                    }
                    else {
                        ToastMsg(response, "warning");
                    }
                    stopLoading("loading-Complaints-New-Item");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    stopLoading("loading-Complaints-New-Item");
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }
</script>

<%-- History For Complaints --%>
<script type="text/javascript">
     //function HistPopComplaintsTemp(AllHistoryData, ContentID) {
 //    var existingRows = complaintsListtable.getData();
 //    var ConsultLst = AllHistoryData[0] || [];
 //    var CompliantLst = AllHistoryData[2] || [];
 //    var container = '<div class="history-list-wrapper">';

 //    for (var i = 0; i < ConsultLst.length; i++) {
 //        var consult = ConsultLst[i];
 //        var ConsultNo = consult.TRANNO;
 //        if (!ConsultNo || ConsultNo == sessionStorage.getItem("PatTRANNO")) continue;/*Vandana if (!ConsultNo) continue;*/
 //        var filtered = CompliantLst.filter(c => c.TRANNO === ConsultNo);
 //        if (filtered.length === 0) continue;
 //        var docName = consult.DOCTNAME || "General Consultation";
 //        var specName = consult.SPECNAME ? " (" + consult.SPECNAME + ")" : "";
 //        var dateInfo = consult.TRANDATE + " " + ConvertTo12Hour("O", consult.TRANTIME);
 //        var sectionHtml = `
 //        <div class="History-section mb-3 shadow-sm border">
 //            <div class="History-header d-flex justify-content-between align-items-center bg-light p-2 border-bottom">
 //                <div style="line-height: 1.2;">
 //                    <div class="History-header-title font-weight-bold">
 //                        Dr. ${docName}${specName}
 //                    </div>
 //                    <small>${dateInfo}</small>
 //                </div>
 //                <button class="btn btn-sm btn-outline-primary copy-all-btn" data-consult="${ConsultNo}">
 //                    <i class="fa fa-copy"></i> Copy All
 //                </button>
 //            </div>
 //            <div class="History-body">
 //                <ul class="list-unstyled mb-0">
 //    `;

 //        var ComplaintsSentence = "{COMPLAINTSNAME} {DURATION} {REMARK}";
 //        var ComplaintsDurSentence = "since {DURATIONNO} {DURATIONTYPE}";
 //        for (var k = 0; k < filtered.length; k++) {
 //            var itemText = filtered[k].NAME;
 //            var itemCode = filtered[k].DESCCD;
 //            var durationNo = filtered[k].DURATION || "";
 //            var durationType = filtered[k].DURTYPE || "";
 //            var remarks = (filtered[k].REMARKS || "").trim();
 //            var SetupYN = filtered[k].SETUPYN || ""
 //            var RplComplaintsDurSentence = "";
 //            var exists = existingRows.some(function (r) {
 //                return r.code === itemCode;
 //            });
 //            if (durationNo && durationNo !== "" && durationType && durationType !== "") {
 //                RplComplaintsDurSentence = ComplaintsDurSentence.replace("{DURATIONNO}", durationNo).replace("{DURATIONTYPE}", ComplaintsDurationTypeSelect(durationType, durationNo));
 //            }
 //            var RplComplaintsSentence = ComplaintsSentence.replace("{COMPLAINTSNAME}", itemText).replace("{DURATION}", RplComplaintsDurSentence).replace("{REMARK}", remarks);
 //            sectionHtml += `
 //            <li class="History-row d-flex justify-content-between align-items-center p-2 border-bottom">
 //                <span class="History-row-Alltext">${RplComplaintsSentence}</span>
 //                <span class="History-row-text History-row-Hide">${itemText}</span>
 //                <span class="History-row-Code History-row-Hide">${itemCode}</span>
 //                <span class="History-row-DurNo History-row-Hide">${durationNo}</span>
 //                <span class="History-row-DurType History-row-Hide">${durationType}</span>
 //                <span class="History-row-Remark History-row-Hide">${remarks}</span>
 //                     <span class="History-row-SetupYN History-row-Hide">${SetupYN}</span>
 //                    ${exists ? `<i class="fa fa-check text-success"></i>` :
 //                    `<button class="btn btn-link btn-sm p-0 copy-row-btn" title="Copy to List">
 //                    <i class="fa fa-clone text-primary"></i>
 //                </button>`
 //                }
 //            </li>
 //        `;
 //        }
 //        sectionHtml += `
 //                </ul>
 //            </div>
 //        </div>
 //    `;
 //        container += sectionHtml;
 //    }
 //    return container + '</div>';
 //}
  

    function HistPopComplaintsTemp(AllHistoryData, ContentID) {

        debugger;

        var existingRows = complaintsListtable.getData();

        var ConsultLst = AllHistoryData[0] || [];
        var CompliantLst = AllHistoryData[2] || [];
        var FreeComplaintLst = AllHistoryData[10] || [];

        var isVisitCompleted =
            (typeof SessionCompComplaint !== 'undefined' &&
                SessionCompComplaint === "Y");

        var $container =
            $('<div class="history-list-wrapper"></div>');

        for (var i = 0; i < ConsultLst.length; i++) {

            var consult = ConsultLst[i];

            var ConsultNo = consult.TRANNO;

            if (!ConsultNo ||
                ConsultNo == sessionStorage.getItem("PatTRANNO"))
                continue;

            var filtered =
                CompliantLst.filter(c => c.TRANNO === ConsultNo);

            var filteredFreeComplaint =
                FreeComplaintLst.filter(f => f.TRANNO === ConsultNo);

            if (filtered.length === 0 &&
                filteredFreeComplaint.length === 0)
                continue;


            var allCopied = filtered.every(c =>
                existingRows.some(r => r.code === c.DESCCD)
            );

            var allFreeComplaintsCopied = filteredFreeComplaint.every(f =>
                $("#Complaints_Freetext")
                    .val()
                    .includes(f.FREECOMPLAINT || "")
            );

            var docName = consult.DOCTNAME || "";

            var specName =
                consult.SPECNAME
                    ? " (" + consult.SPECNAME + ")"
                    : "";

            var dateInfo =
                consult.TRANDATE + " " +
                ConvertTo12Hour("O", consult.TRANTIME);

            var $panel =
                $('<div class="History-panel mb-3"></div>');


            var $panelHead =
                $('<div class="History-header d-flex justify-content-between align-items-center p-3"></div>');


            var $leftDiv =
                $('<div class="d-flex align-items-center flex-grow-1"></div>');

            var docText =
                (docName ? "Dr. " + docName : "") +
                specName;

            var $docDiv =
                $('<div class="History-doctor"></div>')
                    .text(docText);

            var $dateDiv =
                $('<div class="History-date mt-1"></div>')
                    .text(dateInfo);

            $leftDiv.append(
                $('<div></div>').append(
                    $docDiv,
                    $dateDiv
                )
            );

            var $rightDiv =
                $('<div class="d-flex align-items-center"></div>');


            var $copyDiv = $();

         if (!isVisitCompleted) {

          if (
        (filtered.length === 0 || allCopied) &&
        (filteredFreeComplaint.length === 0 || allFreeComplaintsCopied)
    ) {

        $copyDiv = $(`
        <button class="btn btn-sm btn-outline-success"
                style="background: #dbfdf8;"
                disabled>

            <i class="fa fa-check text-success"></i>

        </button>
    `);

    } else {

        $copyDiv = $(`
        <button class="btn btn-sm btn-outline-primary copy-all-btn"
                data-consult="${ConsultNo}">

            <i class="fa fa-copy"></i> Copy All

        </button>
    `);
    }
}

$rightDiv.append($copyDiv);

$panelHead.append(
    $leftDiv,
    $rightDiv
);

var $panelBody =
    $('<div class="History-body p-2"></div>');


if (filtered.length > 0) {

    var complaintHtml = `

    <div class="History-section">

        <label>
            <b>Complaints</b>
        </label>

        <ul class="list-unstyled mb-0">
`;

    var ComplaintsSentence =
        "{COMPLAINTSNAME} {DURATION} {REMARK}";

    var ComplaintsDurSentence =
        "since {DURATIONNO} {DURATIONTYPE}";

         for (var k = 0; k < filtered.length; k++) {

             var itemText = filtered[k].NAME;

                    var itemCode =
                    filtered[k].DESCCD;

                var durationNo =
                    filtered[k].DURATION || "";

                var durationType =
                    filtered[k].DURTYPE || "";

                var remarks =
                    (filtered[k].REMARKS || "").trim();

                var SetupYN =
                    filtered[k].SETUPYN || "";

                var exists =
                    existingRows.some(
                        r => r.code === itemCode
                    );

                var durationText = "";

                if (durationNo && durationType) {

                    durationText =
                        ComplaintsDurSentence
                            .replace(
                                "{DURATIONNO}",
                                durationNo
                            )
                            .replace(
                                "{DURATIONTYPE}",
                                ComplaintsDurationTypeSelect(
                                    durationType,
                                    durationNo
                                )
                            );
                }

                var finalText =
                    ComplaintsSentence
                        .replace(
                            "{COMPLAINTSNAME}",
                            itemText
                        )
                        .replace(
                            "{DURATION}",
                            durationText
                        )
                        .replace(
                            "{REMARK}",
                            remarks
                        );


                var actionBtn = "";

                if (exists) {

                    actionBtn = `
                    <span class="text-success mr-2"
                          title="Already Added">

                        <i class="fa fa-check-circle"></i>

                    </span>
                `;
                }
                else if (!isVisitCompleted) {

                    actionBtn = `
                    <button class="btn btn-link btn-sm p-0 copy-row-btn"
                            title="Copy to List">

                        <i class="fa fa-clone text-primary"></i>

                    </button>
                `;
                }

                complaintHtml += `

                <li class="History-row d-flex justify-content-between align-items-center p-2 border-bottom">

                    <div class="flex-grow-1">

                        ${finalText}

                        <span class="History-row-text History-row-Hide">
                            ${itemText}
                        </span>

                        <span class="History-row-Code History-row-Hide">
                            ${itemCode}
                        </span>

                        <span class="History-row-DurNo History-row-Hide">
                            ${durationNo}
                        </span>

                        <span class="History-row-DurType History-row-Hide">
                            ${durationType}
                        </span>

                        <span class="History-row-Remark History-row-Hide">
                            ${remarks}
                        </span>

                        <span class="History-row-SetupYN History-row-Hide">
                            ${SetupYN}
                        </span>

                    </div>

                    ${actionBtn}

                </li>
            `;
            }

            complaintHtml += `
                </ul>

            </div>
        `;

            $panelBody.append(complaintHtml);
        }


        if (filteredFreeComplaint.length > 0) {

            var freeHtml = `

            <hr style="margin:0;">

            <div class="History-section mt-2">

                <label>
                    <b>Other Complaints</b>
                </label>

                <ul class="list-unstyled mb-0">
        `;

            for (var j = 0; j < filteredFreeComplaint.length; j++) {

                var freeComplaintText =
                    filteredFreeComplaint[j]
                        .FREECOMPLAINT || "";

                var freeComplaintExists =
                    $("#Complaints_Freetext")
                        .val()
                        .includes(freeComplaintText);

                var freeActionBtn = "";

                if (freeComplaintExists) {

                    freeActionBtn = `
                    <span class="text-success mr-2"
                          title="Already Added">

                        <i class="fa fa-check-circle"></i>

                    </span>
                `;
                }
                else if (!isVisitCompleted) {

                    freeActionBtn = `
                    <button class="btn btn-link btn-sm p-0 copy-freecomplaint-btn"
                            title="Copy to List">

                        <i class="fa fa-clone text-primary"></i>

                    </button>
                `;
                }

                freeHtml += `

                <li class="History-FreeComplaintRow
                           d-flex justify-content-between
                           align-items-center
                           p-2 border-bottom">

                    <div class="History-FreeComplaintText flex-grow-1">

                        ${freeComplaintText}

                    </div>

                    ${freeActionBtn}

                </li>
            `;
            }

            freeHtml += `

                </ul>

            </div>
        `;

            $panelBody.append(freeHtml);
        }


        $panel.append(
            $panelHead,
            $panelBody
        );

        $container.append($panel);
    }

    if (ContentID) {

        $('#' + ContentID).html($container);
    }

    return $container.html();
}
    function CopyFuncComplaints() {
    $(".copy-row-btn").off("click").on("click", function () {

        debugger;

        var $btn = $(this);
        var $li = $btn.closest("li");
        var $ul = $btn.closest("ul");
        var text =
            $li.find(".History-row-text")
                .text()
                .trim();

        var Code =
            $li.find(".History-row-Code")
                .text()
                .trim();

        var ComplaintsRowObj = {

            code: Code,

            name: text,

            no: $li.find(".History-row-DurNo")
                .text()
                .trim(),

            type: $li.find(".History-row-DurType")
                .text()
                .trim(),

            remark: $li.find(".History-row-Remark")
                .text()
                .trim(),

            SetUpYn: $li.find(".History-row-SetupYN")
                .text()
                .trim()
        };
        GetAllComplaintsList(text, Code, ComplaintsRowObj);

        $btn.html('<i class="fa fa-check text-success"></i>')
            .removeClass("copy-row-btn")
            .prop("disabled", true);

        var $panel = $btn.closest(".History-panel");

        var remainingButtons =
            $panel.find(".copy-row-btn").length +
            $panel.find(".copy-freecomplaint-btn").length;

        if (remainingButtons === 0) {

            var $copyAll =
                $panel.find(".copy-all-btn");

            if ($copyAll.length > 0) {

                $copyAll.html(
                    '<i class="fa fa-check text-success" style="background: white;"></i>'
                )
                    .removeClass("copy-all-btn")
                    .prop("disabled", true);
            }
        }
    });


    $(".copy-freecomplaint-btn")
        .off("click")
        .on("click", function () {

            var $btn = $(this);

            var text = $btn
                .closest(".History-FreeComplaintRow")
                .find(".History-FreeComplaintText")
                .text()
                .trim();

            var existingText =
                $("#Complaints_Freetext").val().trim();

            if (existingText !== "") {

                if (!existingText.includes(text)) {

                    $("#Complaints_Freetext").val(
                        existingText + "\n" + text
                    );
                }
            }
            else {

                $("#Complaints_Freetext").val(text);
            }

            fitToContent('Complaints_Freetext');

            $btn.html('<i class="fa fa-check text-success"></i>')
                .removeClass("copy-freecomplaint-btn")
                .prop("disabled", true);

            CheckAndUpdateCopyAllButton(
                $btn.closest(".History-section")
            );
        });



    $(".copy-all-btn").off("click").on("click", function () {

        var $btn = $(this);
        var $section =
            $btn.closest('.History-panel');


        var $rows = $section.find('.History-row');

        $rows.each(function () {

            var $row = $(this);

            var text =
                $row.find(".History-row-text").text().trim();

            var Code =
                $row.find(".History-row-Code").text().trim();

            var ComplaintsRowObj = {

                code: Code,

                name: text,

                no: $row
                    .find(".History-row-DurNo")
                    .text()
                    .trim(),

                type: $row
                    .find(".History-row-DurType")
                    .text()
                    .trim(),

                remark: $row
                    .find(".History-row-Remark")
                    .text()
                    .trim(),

                SetUpYn: $row
                    .find(".History-row-SetupYN")
                    .text()
                    .trim()
            };

            GetAllComplaintsList(
                text,
                Code,
                ComplaintsRowObj
            );
        });


        var existingText =
            $("#Complaints_Freetext").val().trim();

        $section.find(".History-FreeComplaintText")
            .each(function () {

                var freeText =
                    $(this).text().trim();

                if (freeText !== "") {

                    if (
                        existingText === "" ||
                        !existingText.includes(freeText)
                    ) {

                        if (existingText !== "") {

                            existingText += "\n";
                        }

                        existingText += freeText;
                    }
                }
            });

        $("#Complaints_Freetext")
            .val(existingText);

        fitToContent('Complaints_Freetext');

        $section.find(".copy-row-btn")
            .each(function () {

                $(this)
                    .html('<i class="fa fa-check text-success"></i>')
                    .removeClass("copy-row-btn")
                    .prop("disabled", true);
            });


        $section.find(".copy-freecomplaint-btn")
            .each(function () {

                $(this)
                    .html('<i class="fa fa-check text-success"></i>')
                    .removeClass("copy-freecomplaint-btn")
                    .prop("disabled", true);
            });


        $btn.html(
            '<i class="fa fa-check text-success" style="background: #dbfdf8;"></i>'
        )
            .removeClass("copy-all-btn")
            .prop("disabled", true);
    });
}


    function CheckAndUpdateCopyAllButton($section) {

        var $panel = $section.closest(".History-panel");

        var remainingButtons =
            $panel.find(".copy-row-btn").length +
            $panel.find(".copy-freecomplaint-btn").length;

        if (remainingButtons === 0) {

            var $copyAll =
                $panel.find(".copy-all-btn");

            $copyAll.html(
                '<i class="fa fa-check text-success" style="background: #dbfdf8;"></i>'
            )
                .removeClass("copy-all-btn")
                .prop("disabled", true);
        }
    }
    function ComplaintsDurationTypeSelect(type, duration) {
        var strDay = "Day";
        puralString = "";
        if (Number(duration) > 1) {
            puralString = "s"
        }

        switch (type) {

            case "D":
                strDay = "Day" + puralString
                break;
            case "W":
                strDay = "Week" + puralString;
                break;
            case "M":
                strDay = "Month" + puralString
                break;
            case "Y":
                strDay = "Year" + puralString
                break;
            default:
                strDay = "Day" + puralString
                break;
        }

        return strDay;

    }

    function fitToContent(id) {
        var textArea = document.getElementById(id);
        textArea.style.height = 'auto';
        var newHeight = Math.ceil(textArea.scrollHeight);

        textArea.style.height = newHeight + 'px';
        textArea.style.overflow = 'hidden';
    }

    function setMaxHeight(id) {
        var textArea = document.getElementById(id);
        if (!textArea) return;

        textArea.style.height = "400px";
        textArea.style.overflowY = "auto";
    }
</script>

<div id="sec-complaints" class="opd-section-card anchor-offset">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h4 class="section-title me-5">Complaints</h4>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="complaintSearch" class="form-control" placeholder="Search Complaints" onclick="GetFrequentComplaints()" oninput="GetAllComplaintsList()"> <%--  oninput="FilterBindedSearchListForComplaint()"--%>  <%--// Modified Pournima 16th June 2026--%>
                <button class="btn btn-outline-success" id="complaintAdd" onclick="OpenPopupForNewItem('Complaints' , 'Complaints')"><i class="fa fa-plus"></i></button>
                <button class="btn btn-outline-success" id="Complaints_PrevHistory" onclick="HistoryPopupOpen('Complaint History', 'Complaints',true,'')"><i class="fa fa-history"></i></button>
            </div>
            <div id="complaintListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="complaintList" class="list-group w-100"></div>
                <div id='loading-Complaints-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
        <div id="ComplaintsTable"></div>
    <h6 class="fw-bold" style="padding: 15px 0px;"><%--Other Complaints--%></h6>
    <textarea class="form-control TextAreaBorder" id="Complaints_Freetext" name="Complaints_Freetext" placeholder="Enter Other Complaints" oninput="autoResizeTextareaForSinglePage(this)"
        style="height: 100px; overflow-y: auto; resize: none;" maxlength="1000"></textarea>
    <%--Added By Abhishesh || 20260321--%>
 <div class="text-end">
    <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>"id="btnFitToContent"title="Fit to Content"style="width:35px; height:30px; cursor:pointer;" />
    <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>"id="btnSetMaxHeight"title="Set Max Height"style="width:35px; height:30px; cursor:pointer;" />
</div>
    <%--End--%>

    <div id='loading-Complaints' class='loading-screen' style='display: none; opacity: 0;'></div>
</div>

