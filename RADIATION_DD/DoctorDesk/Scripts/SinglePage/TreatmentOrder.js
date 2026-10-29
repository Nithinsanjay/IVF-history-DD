
var holdLogTable = null;
var globaldoctstring = '';
var MediciTypeLStr = '';         //Added on 20260324
var AddedMedicineList = [];
var currentDrugContext = "";
var MedicationList = [];
var MedicineList = [];
function normalizeArray(data) {
    return Array.isArray(data) ? data : [];
}

function checkPriviousDate(chageDate) {
    var dsplit = chageDate.split("/");
    var converteddate = new Date(dsplit[2], dsplit[1] - 1, dsplit[0]);

    if (converteddate.setHours(0, 0, 0, 0) < new Date().setHours(0, 0, 0, 0)) {
        IsPastDate = true;
    }

    else {
        IsPastDate = false;
    }
    return IsPastDate;
}

function checkFutureDate(chageDate) {
    var dsplit = chageDate.split("/");
    var converteddate = new Date(dsplit[2], dsplit[1] - 1, dsplit[0]);

    if (converteddate.setHours(0, 0, 0, 0) > new Date().setHours(0, 0, 0, 0)) {
        IsFutureDate = true;
    }
    else {
        IsFutureDate = false;
    }
    return IsFutureDate;
}

function getCurrentDate_DDMMYYYY() {
    const d = new Date();
    const day = String(d.getDate()).padStart(2, '0');
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const year = d.getFullYear();
    return `${day}/${month}/${year}`;
}
function formatTimeTo12Hour(timeStr) {
    if (!timeStr) return "";
    if (timeStr.includes("AM") || timeStr.includes("PM")) {
        return timeStr;
    }
    const [hourStr, minStr] = timeStr.split(":");
    let hour = parseInt(hourStr, 10);
    const minute = minStr;
    const ampm = hour >= 12 ? "PM" : "AM";
    hour = hour % 12 || 12;
    return `${String(hour).padStart(2, "0")}:${minute} ${ampm}`;
}

function getCurrentTime12Hour() {
    const d = new Date();
    let hour = d.getHours();
    const minute = String(d.getMinutes()).padStart(2, "0");
    const ampm = hour >= 12 ? "PM" : "AM";
    hour = hour % 12 || 12;
    return `${String(hour).padStart(2, "0")}:${minute} ${ampm}`;
}
function getCurrentTime_12H() {
    const d = new Date();
    let hours = d.getHours();
    const minutes = String(d.getMinutes()).padStart(2, '0');
    const ampm = hours >= 12 ? 'PM' : 'AM';

    hours = hours % 12;
    hours = hours ? hours : 12; // 0 → 12
    hours = String(hours).padStart(2, '0');

    return `${hours}:${minutes} ${ampm}`;
}


function formatDateToDDMMYYYY(val) {
    if (!val) return "";

    if (typeof val === "string") {
        // If already in DD/MM/YYYY format
        if (/^\d{2}\/\d{2}\/\d{4}$/.test(val)) return val;

        // Try parsing YYYY-MM-DD or ISO format
        const parts = val.split("-");
        if (parts.length === 3) return `${parts[2]}/${parts[1]}/${parts[0]}`;
    }

    if (val instanceof Date) {
        const day = String(val.getDate()).padStart(2, "0");
        const month = String(val.getMonth() + 1).padStart(2, "0");
        const year = val.getFullYear();
        return `${day}/${month}/${year}`;
    }

    return "";
}

function load_Doctor() {
    var s;
    $.ajax({
        url: 'GetDoctorInfo',
        data: {},
        type: 'get',
        async: false,
        success: function (data) {
            globalDoclst = data;
            s = "----Select----:----select----;"; $.each(data, function () {
                s += this.Value + ":" + this.Text + ";";
            });
            s = s.substring(0, s.length - 2);
        }
    });
    globaldoctstring = s;
    return s;
}

function load_Specilizationlist() {
    var s;
    $.ajax({
        url: '../ICUMob/GetSpecilizationbyCode',
        type: 'get',
        async: false,
        success: function (data) {
            specilizationlist = data;
        }
    });
    return s;
}

function GetDoctSpecilization(docVal) {
    var specilization = '';

    var DocSpecilizationCode = $.grep(globalDoclst, function (element, value) {
        return (element.Value == docVal);
    })

    var Code = DocSpecilizationCode[0].Specialization
    var SpecilizationData = $.grep(specilizationlist, function (element, value) {
        return (element.Value == Code);
    })

    if (SpecilizationData.length > 0) {
        specilization = SpecilizationData[0].Text
    }
    return specilization;
}

function GrdAnitibioticType() {
    return {
        "": "",
        "INJ": "INJ",
        "IV": "IV",
        "POWD FOR INJ": "POWD FOR INJ",
        "SUSP FOR INJ": "SUSP FOR INJ"
    };
}

// Chemo Antibiotic Type options
function GrdChemoAnitibioticType() {
    return {
        "": "",
        "INJ": "INJ",
        "IV": "IV",
        "POWD FOR INJ": "POWD FOR INJ",
        "SUSP FOR INJ": "SUSP FOR INJ",
        "CAP": "CAP",
        "TAB": "TAB"
    };
}

// Action column
function getActionColumn() {
    return {
        title: "Action",
        field: "action",
        width: 50,
        formatter: function (cell) {
            return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
        },
        hozAlign: "center",
        cellClick: function (e, cell) {
            let row = cell.getRow();
            let rowData = row.getData();
            let setNo = rowData.SetNo;
            if (setNo && setNo !== "0") {
                TrmtntOrderMedicineTable.getRows().forEach(r => { if (r.getData().SetNo === setNo) { r.delete(); } });
            }
            else {
                row.delete();
            }
            MedicinColorIndications();
        }
    }
}

// Day of Drug
function getDayOfDrugColumn() {
    return {
        title: "<span style='color:red'>Days</span>",
        field: "DayOfDrug",
        width: 53,
        hozAlign: "center",
        headerSort: false,
        editor: "input",
        editable: false,
        editorParams: {
            elementAttributes: {
                maxlength: 5,
                oninput: "this.value=this.value.replace(/\\D/g,'')"
            }
        }
    };
}

// Dose
function getDoseColumn() {
    return {
        title: "<span style='color:red'>Dose</span>",
        field: "Dose",
        width: 100,
        hozAlign: "left",
        headerSort: false,
        editor: false
    };
}

// Route
function getRouteColumn(EditFlag, tblname) {
    return {
        title: "<span style='color:red'>Route<span>",
        field: "Route",
        tooltip: true,
        editor: "list",
        editable: EditFlag,
        width: 90,
        mutator: function (value, data) {
            if (value) return value;
            // const routeList = Get_MedicineRote("N", data.FormCode);
            const routeList = tblname == "ChemoTable"
                ? Get_MedicineRote("N", data.MtrFormCode)
                : Get_MedicineRote("N", data.FormCode);
            const defaultItem = routeList.find(item => item.DEFAULTYN === "Y");
            return defaultItem ? defaultItem.Value : DefaultRouteValue;
        },
        editorParams: function (cell) {
            const rowData = cell.getRow().getData();
            return {
                values: tblname == "ChemoTable"
                    ? Get_MedicineRote("Y", rowData.MtrFormCode)
                    : Get_MedicineRote("Y", rowData.FormCode),
                autocomplete: true,
                listOnEmpty: true,
                allowEmpty: false
            };
        },
        formatter: "lookup",
        formatterParams: function (cell) {
            const rowData = cell.getRow().getData();
            if (tblname == "ChemoTable") {
                return Get_MedicineRote("Y", rowData.MtrFormCode);
            }
            else {
                return Get_MedicineRote("Y", rowData.FormCode);
            }

        },
        cellEdited: function (cell) {

            if (tblname == "ChemoTable") {

                let row = cell.getRow();
                let data = row.getData();

                let routeList = Get_MedicineRote("Y", data.MtrFormCode);

                let selectedCode = Object.keys(routeList).find(
                    key => key === cell.getValue()
                );

                if (selectedCode) {
                    row.update({
                        Route: routeList[selectedCode],   // Text
                        RoutCode: selectedCode,           // Code


                    });
                }
            }

            adjustTableHeight(tblname);
        }

    };
}

// Frequency
function getFreqColumn() {
    return {
        title: "<span style='color:red'>Freq</span>",
        field: "Freq",
        width: 51,
        hozAlign: "left",
        headerSort: false,
        editor: false
    };
}

// Omit
function getOmitColumn() {
    return {
        title: "OMIT",
        field: "OMIT",
        width: 53,
        hozAlign: "center",
        editor: "tickCross",
        formatter: "tickCross"
    };
}
function updateRowColor(row) {

    let data = row.getData();
    let element = row.getElement();
    element.classList.remove("Planed", "PlanedOmitt");
    let isOmit = (data.OMIT === "Y" || data.OMIT === true);
    if (PlanData.hasOwnProperty("TRETMEDICINE") &&
        PlanData.TRETMEDICINE.length > 0 &&
        CheckPlanData(data.SQNumber, "AB")) {

        element.classList.add(
            isOmit ? "PlanedOmitt" : "Planed"
        );

    }
    else if (PlanData.hasOwnProperty("TRETMEDICINE") &&
        PlanData.TRETMEDICINE.length > 0 &&
        CheckPlanData(data.SQNumber, "MD")) {

        element.classList.add(
            isOmit ? "PlanedOmitt" : "Planed"
        );

    }
    else {
        element.style.backgroundColor = isOmit ? "#d4edda" : "";
    }
}
// Remark
function getRemarkColumn(tblname) {
    return {
        title: "Remark",
        field: "Remark",
        width: 250,
        formatter: "textarea",
        editor: "textarea",
        editorParams: {
            elementAttributes: {
                maxlength: "500",
            },
            verticalNavigation: "editor",
            shiftEnterSubmit: true,
        },
        cssClass: "TabTextArea",
        cellEdited: function (cell) {
            /*adjustTableHeight("ComplaintsTable");*/
            adjustTableHeight(tblname);//priyanka 06/03/2026
        }
    };
}

function LogInfo(cell, formatterParams, onRendered) {
    var data = cell.getData();
    if (!data.DrugName) {
        return '';
    }
    return '<span class="ui-icon ui-icon-info holdlog-icon" ' +
        'data-tranno="' + data.TranNo + '" ' +
        'data-sqno="' + data.SQNumber + '" ' +
        'data-typecode="' + data.TypeCode + '" ' +
        'data-drugcode="' + data.DrugCode + '" ' +
        'title="Get Hold Log" ' +
        'style="cursor:pointer; color:blue; display:inline-block; width:16px; height:16px;"></span>';
}

function openHoldModal(callback) {
    $("#txtHoldReason").val("");
    $("#holdReasonModal").show();

    $("#btnHoldContinue").off("click").on("click", function () {
        var reason = $("#txtHoldReason").val();
        if (callback(reason)) {
            $("#holdReasonModal").hide();
        }
    });

    $("#btnHoldCancel").off("click").on("click", function () {
        $("#holdReasonModal").hide();
    });
}
function processHoldUpdate(row, holdValue, reason, successMsg) {
    var d = row.getData();
    var finalTranNo = d.TranNo || $("#tractiondropdown").val();

    $.ajax({
        url: '../SinglePage/ProcessHoldUnhold',
        type: 'POST',
        data: {
            TRANNO: finalTranNo || "",
            SEQNO: d.SQNumber || "",
            TBLTYPE: d.TypeCode || "",
            strHoldYN: holdValue || "",
            strHoldReason: reason || "",
            strDrugCode: d.DrugCode || "",
            strDrugName: d.DrugName || "",
            strSetNo: d.SetNo || ""
        },
        success: function (response) {
            ToastMsg(successMsg, "info");

            row.update({ HOLD: holdValue.toUpperCase() }).then(function () {

                row.reformat();
            });

            if (typeof MedicinColorIndications === "function") {
                MedicinColorIndications();
            }
        }
    });
}
// Omitted By/Date/Time
function getOmittedByColumn() { return { title: "Omitted By", field: "OmittedBy", width: 110, visible: false }; }
//function getOmittedByNameColumn() { return { title: "Omitted By", field: "OmittedByName", width: 110, visible: false }; }
//Abhishesh || 20260714
function getOmittedByNameColumn() {
    return {
        title: "Omitted By",
        field: "OmittedByName",
        width: 110,
        visible: false,
        formatter: function (cell) {
            var data = cell.getRow().getData();
            var name = data.OmittedByName || "";
            var userId = data.OmittedBy || "";
            return userId ? name + " (" + userId + ")" : name;
        }
    };
}
//End
function getOmittedDateColumn() { return { title: "Omitted Date", field: "OmittedDate", width: 110, visible: false }; }
function getOmittedTimeColumn() { return { title: "Omitted Time", field: "OmittedTime", width: 110, visible: false }; }

// Ordered By/Date/Time
function getOrderedByColumn() { return { title: "Ordered By", field: "OrderedBy", width: 120, visible: false }; }
//function getOrderedByNameColumn() { return { title: "Ordered By", field: "OrderedByName", width: 120 }; }
//Added By Abhishesh || 20260714
function getOrderedByNameColumn() {
    return {
        title: "Ordered By",
        field: "OrderedByName",
        width: 120,
        formatter: function (cell) {
            var data = cell.getRow().getData();
            var name = data.OrderedByName || "";
            var userId = data.OrderedBy || "";
            return userId ? name + " (" + userId + ")" : name;
        }
    };
}
//End
function getOrderedDateColumn() { return { title: "Ordered Date", field: "OrderedDate", width: 80, visible: false }; }
function getOrderedTimeColumn() { return { title: "Ordered Time", field: "OrderedTime", width: 80, visible: false }; }

// Sequence / Flags
function GetDrugSequenceNo() { return { title: "SQNumber", field: "SQNumber", visible: false }; }
function GetHighAlertDrug() { return { title: "HighAlert", field: "HighAlert", visible: false }; }
function GetNotifyYN() { return { title: "NOTIFYN", field: "NOTIFYN", visible: false }; }
function GetStatus() { return { title: "STATUS", field: "STATUS", visible: false }; }
function GetADMINYN() { return { title: "ADMINYN", field: "ADMINYN", visible: false }; }

function ConvertArryListToTabulatorFormatForTreatmentOrder(DataList, PropText, PropValue) {
    let lookup = {};
    lookup[""] = "";
    DataList.forEach(item => {
        lookup[item[PropValue].trim()] = item[PropText];
    });
    return lookup;
}

//function Get_MedicineRote(TabulatorYN) {
//    var s;
//    var MediciRouteLtr
//    $.ajax({
//        url: '../SinglePage/GetMedicineRoute',
//        data: {},
//        type: 'get',
//        async: false,
//        success: function (Response) {
//            MediciRouteLtr = Response;
//            s = TabulatorYN == "Y" ? ConvertArryListToTabulatorFormatForTreatmentOrder(MediciRouteLtr, "Text", "Value") : MediciRouteLtr;
//        }
//    });
//    return s;
//}

function Get_MedicineRote(TabulatorYN, DrugFormCode) {
    var s;
    var RList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
    var FilterRouteList = RList.filter(item => item.FORMCODE == DrugFormCode && item.Value != "");
    s = TabulatorYN == "Y" ? ConvertArryListToTabulatorFormatForTreatmentOrder(FilterRouteList, "Text", "Value") : FilterRouteList;
    return s;
}

function Get_DiluVolume() {
    var s;
    var DiluVolumeTypelst
    var DiluVolumelst
    $.ajax({
        url: '../SinglePage/GetDilutionVolumList',
        data: {},
        type: 'get',
        async: false,
        success: function (Response) {
            DiluVolumelst = Response;
            s = ConvertArryListToTabulatorFormatForTreatmentOrder(DiluVolumelst, "Text", "Value");
        }
    });
    return s;
}

function Get_AdminDurData() {
    var s;
    var AdminDurDatalst
    $.ajax({
        url: '../SinglePage/GetAdminiStrDur',
        data: {},
        type: 'get',
        async: false,
        success: function (Response) {
            AdminDurDatalst = Response;
            s = ConvertArryListToTabulatorFormatForTreatmentOrder(AdminDurDatalst, "Text", "Value");
        }
    });
    return s;
}

function GetDBMaxSEQNO() {
    MaxSEQ = "";
    var strIpNo = IPNO;
    var dataContainer = {
        IPNO: "" + strIpNo,
    }
    $.ajax({
        url: '../SinglePage/GetMaxSEQNO',
        data: dataContainer,
        type: 'get',
        async: false,
        success: function (Response) {
            if (Response != "UNSUCESSFULL") {
                MaxSEQ = JSON.parse(Response);
            }
            else {

            }
        }
    });
}
function GetMaxSEQNO(GridName) {
    row = "";
    if (MaxSEQ.hasOwnProperty("Table")) {
        var spliceVal = "";
        var seqrow = $.grep(MaxSEQ.Table, function (Ele, I) {
            if (Ele.TBLTYPE == GetTypeCode()) {
                spliceVal = I;
            }
            return Ele.TBLTYPE == GetTypeCode(GridName);
        })

        if (seqrow.length > 0) {
            row = seqrow
        }
        else {
            row = "";
        }
    }
    else {
        row = "";
    }


    return row;
}


function InitializeArray(arrCom) {
    for (var i = 0; i < arrCom.length; i++) {
        arrCom[i] = 0;
    }
}

function getColumnIndexByName(grid, columnName) {
    var cm = $("#JqGridMedication").jqGrid('getGridParam', 'colModel'), i, l = cm.length;
    for (i = 0; i < l; i++) {
        if (cm[i].name === columnName) {
            return i;
        }
    }
    return -1;
}


function CancelledRequest(strTranNo, strSeqNo, strType) {
    var flag = false;
    var dataContainer = {
        TBLTYPE: strType,
        TRANNO: strTranNo,
        SEQNO: strSeqNo,
        CANTIME: GetTimewithAMPM()
    };
    $.ajax({
        url: 'ProcessCancellation',
        data: dataContainer,
        type: 'get',
        async: false,
        success: function (Response) {
            if (Response.toUpperCase().indexOf('SUCCESSFUL') >= 0) {
                flag = true;
                ToastMsg("Cancellation Successful", "info");
            } else {
                flag = false;
                ToastMsg("Cancellation Process Failed", "error");
            }
        }
    });
    return flag;
}

function showHoldLog(strTranNo, strSeqNo, strType, strDrugCode) {
    var finalTranNo = strTranNo || $("#tractiondropdown").val();

    console.log("Fetching Log for:", { finalTranNo, strSeqNo, strType, strDrugCode });

    var url = 'GetHoldUnholdLogs?TRANNO=' + finalTranNo +
        '&SEQNO=' + strSeqNo +
        '&TBLTYPE=' + strType +
        '&strDrugCode=' + strDrugCode;

    $("#divHoldLog").dialog({
        title: "Hold / Resume History",
        modal: true,
        width: 700,
        height: 400,
        resizable: false,
        open: function () {
            $(".ui-dialog-titlebar-close").show();
            $(this).parent().find(".ui-dialog-titlebar-close").html("<span style='font-size:13px;font-weight:bold;'>✖</span>"); // Added By Abhishesh || 20260316
            if (holdLogTable) {
                holdLogTable.setData(url);
            } else {
                holdLogTable = new Tabulator("#tblHoldLog", {
                    ajaxURL: url,
                    ajaxConfig: "GET",
                    ajaxResponse: function (url, params, response) {
                        return response.rows;
                    },
                    layout: "fitColumns",
                    height: "300px",
                    placeholder: "No log data found",
                    columns: [
                        { title: "Date", field: "TRANDATE", width: 110 },
                        { title: "Time", field: "TRANTIME", width: 90 },
                        {
                            title: "Action", field: "HOLDYN", width: 100, hozAlign: "center",
                            formatter: function (cell) {
                                var val = cell.getValue();
                                return val === "Y" ? "<span class='label label-danger'>Hold</span>" :
                                    val === "N" ? "<span class='label label-success'>Resume</span>" : "";
                            }
                        },
                        { title: "Reason", field: "REASON", width: 200, tooltip: true },
                        { title: "By", field: "USERID", width: 150 }
                    ]
                });
            }
        }
    });
}

//20263024
function getTypeColumn() {
    var Type = {
        name: 'Type', index: 'Type', width: 40, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
        edittype: 'select',
        editoptions:
        {
            value: MediciTypeLStr,
            dataInit: function (el) {
                $(el).css("width", "40")

            }
        }
    }
    return Type;
}

function load_MedicineType() {
    var result = {};

    $.ajax({
        url: '../ICUMob/GetMedicineType',
        type: 'get',
        async: false,
        success: function (response) {
            $.each(response, function () {
                result[this.Value] = this.Text;
            });
        }
    });

    return result;
}

//Added by aaryshree 20260625
function NewDrugValidate() {
    var l_blFocus = false;
    var l_sErrorMessage = "";
    if ($("#txtMedicineName").val().length == 0) {
        $("#txtMedicineName").css("border-color", "Red");
        if (!l_blFocus) {
            $("#txtMedicineName").focus();
            l_blFocus = true;
        }
    }
    else { $("#txtMedicineName").css("border-color", ""); }


    if ($("#txtGenericName").val().length == 0) {
        $("#txtGenericName").css("border-color", "Red");
        if (!l_blFocus) {
            $("#txtGenericName").focus();
            l_blFocus = true;
        }
    }
    else { $("#txtGenericName").css("border-color", ""); }

    if ($("#txtBrandName").val().length == 0) {
        $("#txtBrandName").css("border-color", "Red");
        if (!l_blFocus) {
            $("#txtBrandName").focus();
            l_blFocus = true;
        }
    }
    else { $("#txtBrandName").css("border-color", ""); }

    if (l_blFocus) {
        return false;
    }
    else {
        return true;
    }

}

function CloseDrug() {
    $('#AddMedicineNew').dialog('close');

}

function ClearNewDrugdata() {
    $('#txtMedicineName').val("");
    $('#txtGenericName').val("");
    $('#txtBrandName').val("");
    $('#ChkHighAlt')[0].checked = false;
}
$(function () {
    $("#AddMedicineNew").dialog({
        autoOpen: false,
        modal: true,
        width: 420,
        height: "auto",
        dialogClass: "NewDrug",
        open: function () {
            $(".ui-dialog-titlebar-close").show();
            $(this).parent()
                .find(".ui-dialog-titlebar-close")
                .html("<span style='font-size:14px;font-weight:bold;text-align:center'>✖</span>");
        }
    });
});
function AddNewDrug(type) {
    currentDrugContext = type;
    ClearNewDrugdata();
    $("#AddMedicineNew").dialog("open");
}
function SaveNewDrug() {

    if (NewDrugValidate()) {

        var strMedicineName = $('#txtMedicineName').val().toUpperCase();
        var strGenericName = $('#txtGenericName').val().toUpperCase();
        var strBrandName = $('#txtBrandName').val().toUpperCase();

        var HighAlt = $('#ChkHighAlt').is(":checked") ? "Y" : "N";

        var lastNum = strGenericName.trim().substring(0, 3);
        var DRGCODE = "DRGTEMP" + IpNo + "123" + lastNum;

        var newMedicine = {
            CODE: DRGCODE,
            GENERICID: DRGCODE,
            NAME: strMedicineName,
            GENERICNAM: strGenericName,
            BRANDNAME: strBrandName,
            HighAlert: HighAlt,
            ANTIBIOYN: "Y",
            GENMTRLFORMCODE: "",
            GENMTRLFORM: "",
            MTRLFORMCODE: "",
            MTRLFORM: "",
            IsNewDrug: true
        };

        if (currentDrugContext === "Medicine") {

            MedicineList.unshift(newMedicine);

            BindSearchListForMedicine(MedicineList);
            $("#MedicineListMainDiv").show();
            $("#AddMedicineNew").dialog('close');
            medicationTable = "TrmtntOrderMedicineTable";

            var $first = $("#MedicineList .AntiMed-row-Gen").first();
            if ($first.length) {
                $first.trigger("click");
            }
        }
        else if (currentDrugContext === "Medication") {

            MedicationList.unshift(newMedicine);

            BindSearchListForMedication(MedicationList);
            $("#MedicationListMainDiv").show();
            $("#AddMedicineNew").dialog('close');
            medicationTable = "TrmtntOrderMedicationTable";

            var $first = $("#MedicationList .Medication-row-Gen").first();
            if ($first.length) {
                $first.trigger("click");
            }
        }


    }
}

function getDrugFormDropdown() {

    var RTList = JSON.parse(FormLinkRouteList || "[]");

    var values = {};
    var seen = new Set();

    RTList.forEach(function (item) {

        var code = item.FORMCODE;
        var name = item.FORMNAME;
        var text = item.Text;
        var value = item.Value;


        if (!code || !name || name.trim() === "" || !text || text.trim() === "" || !value || value.trim() === "") {
            return;
        }
        if (seen.has(code)) {
            return;
        }

        seen.add(code);

        values[code] = name;
    });

    return values;
}

function GetRouteList(TabulatorYN, DrugFormCode) {
    var s;
    var RTList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
    var FilterRouteList = RTList.filter(item => item.FORMCODE == DrugFormCode && item.Value != "");
    s = TabulatorYN == "Y" ? ConvertArryListToTabulatorFormat(FilterRouteList, "Text", "Value") : FilterRouteList;
    console.log(s);
    return s;
}
// Investigation row lock
function toInvstgNum(v) { var n = parseInt(v, 10); return isNaN(n) ? null : n; }
function isInvstgRowLocked(data) {
    if (!data) return false;
    var pending = toInvstgNum(data.Pending), placed = toInvstgNum(data.OrderPlaced), count = toInvstgNum(data.TestCount);
    if (pending === 0) return true;
    return placed !== null && placed > 0 && count !== null && count <= placed;
}
function isInvstgCellEditable(cell) { return !isInvstgRowLocked(cell.getRow().getData()); }
function lockInvstgColumn(col) {
    var orig = col.editable;
    col.editable = function (cell) {
        if (isInvstgRowLocked(cell.getRow().getData())) return false;
        return typeof orig === "function" ? orig(cell) : (orig === undefined ? true : orig);
    };
    return col;
}
function applyInvstgRowLock(row) {
    if (!isInvstgRowLocked(row.getData())) return;
    row.getCells().forEach(function (cell) { cell.getElement().classList.add("disable-cell"); });
}
function calculateEndDate(startDate, duration) {
    if (!startDate || !duration) return "";

    const [day, month, year] = startDate.split("/").map(Number);
    const date = new Date(year, month - 1, day);

    date.setDate(date.getDate() + Number(duration) - 1);

    const dd = String(date.getDate()).padStart(2, "0");
    const mm = String(date.getMonth() + 1).padStart(2, "0");

    return `${dd}/${mm}/${date.getFullYear()}`;
}
function toGetRowStartDate(data) { return (data && (data.AntiBoDGSTARTDATE || data.MediDGSTARTDATE)) || ""; }
function getRowEndDate(data) {
    return calculateEndDate(
        toGetRowStartDate(data),
        data ? data.Duration : ""
    );
}
function parseDate(dateString) {
    return toParseDate(dateString);
}
function toParseDate(dateString) {
    if (!dateString) return null;

    var parts = dateString.split("/");

    if (parts.length !== 3) return null;

    var day = parseInt(parts[0], 10);
    var month = parseInt(parts[1], 10) - 1;
    var year = parseInt(parts[2], 10);

    var date = new Date(year, month, day);

    // Validate the date
    if (
        date.getDate() !== day ||
        date.getMonth() !== month ||
        date.getFullYear() !== year
    ) {
        return null;
    }

    return date;
}
function parseDate(dateString) {
    if (!dateString) return null;

    const parts = dateString.split("/");

    if (parts.length !== 3) return null;

    const day = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10) - 1;
    const year = parseInt(parts[2], 10);

    return new Date(year, month, day);
}
function toCalcDayOfDrug(startVal, duration) {

    var startDate = toParseDate(startVal);
    var durationDays = parseInt(duration, 10);

    if (!startDate || isNaN(durationDays) || durationDays <= 0) {
        return "";
    }
    var serverDate = toParseDate(ServerDate);

    if (!serverDate) {
        return "";
    }
    var diffDays = Math.floor(
        (serverDate.getTime() - startDate.getTime()) / 86400000
    );

    var dayOfDrug = diffDays + 1;
    dayOfDrug = Math.min(dayOfDrug, durationDays);
    dayOfDrug = Math.max(dayOfDrug, 1);

    return dayOfDrug;
}
//End