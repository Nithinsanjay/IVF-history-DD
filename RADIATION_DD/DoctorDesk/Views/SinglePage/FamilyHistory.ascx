<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%
    string pageType = Convert.ToString(ViewData["Type"] ?? "");
    if (string.IsNullOrEmpty(pageType)) { pageType = "Popup"; }
%>

<style>
    #FamilyHistory_Freetext,
    #FamilyHistory_Freetext_<%= pageType %> {
        min-height: 80px;
    }
</style>


<%-- FamilyHistory Form --%>
<script type="text/javascript">
    var FHRelationNameList = {
        '': '',
        '01': 'Father', '02': 'Mother', '03': 'Wife',
        '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
        '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
        '11': 'Paternal Aunt'
    };

    var FHDieseasesStatusList = {
        '': '', 'R': 'Recovered', 'O': 'Ongoing'
    };

window.FamilyHistoryListtable = window.FamilyHistoryListtable || {};

$(document).ready(function () {
    /* Tabulator For FamilyHistory */

    FamilyHistoryListtable['<%= pageType %>'] = new Tabulator("#FamilyHistoryTable_<%= pageType %>", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            rowHeader: {
                headerSort: false,
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 40
            },
            columns: [
                {
                    headerSort: false,
                    title: "",
                    field: "act",
                    width: 40,
                    formatter: function (cell) {
                        return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        cell.getRow().delete();
                        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
                    },
                    titleFormatter: function () {
                        return '<i class="fa fa-plus Add-New-FamilyHistory-plus" ' +
                            'style="cursor:pointer; margin-left:6px;" title="Add Row"></i> ';
                    },
                    headerClick: function (e, column) {
                        if ($(e.target).hasClass("Add-New-FamilyHistory-plus")) {
                            var tbl = column.getTable();
                            tbl.addRow({
                                NAME: "",
                                AGE: "",
                                STATUS: "",
                                DISEASES: "",
                                DURATION: "0",
                                DURTYPE: "D",
                                DIAGNOSEDDATE: "",
                                DISEASESTATUS: "",
                                ALIVEYN: true,
                                DATEOFDEATH: "",
                                CAUSEOFDEATH: ""
                            }).then(function (row) {
                                if (row && typeof row.normalizeHeight === "function") {
                                    row.normalizeHeight();
                                }
                                adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
                            });
                        }
                    }
                },
                {
                    title: "Relation",
                    field: "NAME",
                    editor: "list",
                    headerSort: false,
                    width: 120,
                    editorParams: {
                        values: FHRelationNameList,
                        autocomplete: true,   // enable typing filter
                        listOnEmpty: true,    // show list when empty
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: FHRelationNameList
                },
                {
                    title: "Age",
                    field: "AGE",
                    width: 60,
                    tooltip: true,
                    editor: "list",
                    editorParams: function () {
                        //let values = {};
                        //for (let i = 0; i <= 100; i++) {
                        //    values[i] = i.toString();
                        //}
                        //return { values: values, allowEmpty: false };
                        let values = [];
                        for (let i = 0; i <= 100; i++) {
                            values.push({ label: i.toString(), value: i });
                        }
                        //return { values: values, allowEmpty: false };
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
                        for (let i = 0; i <= 100; i++) {
                            values[i] = i.toString();
                        }
                        return values;
                    })()
                },
                {
                    title: "STATUS",
                    field: "STATUS",
                    editor: false,
                    visible: false
                },
                {
                    title: "Diseases",
                    field: "DISEASES",
                    editor: "list",
                    headerSort: false,
                    width: 200,
                    editorParams: {
                        values: GetAllDiseaseList("Y"),
                        autocomplete: true,   // enable typing filter
                        listOnEmpty: true,    // show list when empty
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: GetAllDiseaseList("Y")
                },
                {
                    title: "Duration No",
                    field: "DURATION",
                    width: 100,
                    tooltip: true,
                    editor: "list",
                    editorParams: {
                        autocomplete: 'true',
                        allowEmpty: true,
                        listOnEmpty: true,
                        valuesLookup: true,
                        values: getDuration(85)
                    },
                    cellEdited: function (cell) {

                        var row = cell.getRow().getData();

                        if (!validateDurationWithAge(
                            row.DURATION,
                            row.DURTYPE,
                            row.AGE
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");
                        }
                    }
                },
                {
                    title: "Duration Category",
                    field: "DURTYPE",
                    tooltip: true,
                    editor: "list",
                    width: 140,
                    editorParams: {
                        autocomplete: 'true',
                        allowEmpty: true,
                        listOnEmpty: true,
                        values: {
                            'D': 'Days',
                            'W': 'Weeks', 
                            'M': 'Months',
                            'Y': 'Years'
                        }
                    },
                    formatter: 'lookup',
                    formatterParams: {
                        'D': 'Days',
                        'W': 'Weeks', 
                        'M': 'Months',
                        'Y': 'Years'
                    },
                    cellEdited: function (cell) {

                        var row = cell.getRow().getData();

                        if (!validateDurationWithAge(
                            row.DURATION,
                            row.DURTYPE,
                            row.AGE
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");

                        }
                    }
                },
                {
                    title: "Diagnosed Date",
                    field: "DIAGNOSEDDATE",
                    sorter: "date",
                    width: 150,
                    editor: function (cell, onRendered, success, cancel) {
                        var row = cell.getRow().getData(); // Pournima 8th July 2026
                        let dt = luxon.DateTime.fromFormat(cell.getValue(), "dd/MM/yyyy");
                        let input = document.createElement("input");
                        input.type = "date";
                        input.style.padding = "4px";
                        input.style.width = "100%";
                        input.style.boxSizing = "border-box";
                        if (dt.isValid) {
                            input.value = dt.toFormat("yyyy-MM-dd");
                        }
                        onRendered(() => input.focus());
                        function onChange() {
                            if (input.value) {

                                let newDt = luxon.DateTime.fromISO(input.value);
                                let formattedDate = newDt.toFormat("dd/MM/yyyy");

                           
                                if (!validateDiagnosedDateWithAge(formattedDate, row.AGE)) {
                                    ToastMsg("Diagnosed date should be within patient's age", "warning");
                                   
                                    cancel();
                                    return;
                                }

                                success(formattedDate);
                            } else {
                                cancel();
                            }
                        }
                        input.addEventListener("blur", onChange);
                        input.addEventListener("keydown", e => {
                            if (e.keyCode === 13) onChange();
                            if (e.keyCode === 27) cancel();
                        });
                        return input;
                    },
                    formatter: "datetime",
                    formatterParams: {
                        inputFormat: "dd/MM/yyyy",
                        outputFormat: "dd/MM/yyyy",
                    },
                    tooltip: true
                },
                {
                    title: "Diseases Status",
                    field: "DISEASESTATUS",
                    tooltip: true,
                    editor: "list",
                    width: 120,
                    editorParams: {
                        values: FHDieseasesStatusList,
                        autocomplete: true,   // enable typing filter
                        listOnEmpty: true,    // show list when empty
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: FHDieseasesStatusList
                },
                {
                    title: "Alive",
                    field: "ALIVEYN",
                    hozAlign: "center",
                    width: 60,
                    formatter: "tickCross",
                    editor: true
                },
                {
                    title: "Death Date",
                    field: "DATEOFDEATH",
                    sorter: "date",
                    width: 95,
                    editor: function (cell, onRendered, success, cancel) {
                        let dt = luxon.DateTime.fromFormat(cell.getValue(), "dd/MM/yyyy");
                        let input = document.createElement("input");
                        input.type = "date";
                        input.style.padding = "4px";
                        input.style.width = "100%";
                        input.style.boxSizing = "border-box";
                        if (dt.isValid) {
                            input.value = dt.toFormat("yyyy-MM-dd");
                        }
                        onRendered(() => input.focus());
                        function onChange() {
                            if (input.value) {
                                let newDt = luxon.DateTime.fromISO(input.value);
                                success(newDt.toFormat("dd/MM/yyyy"));
                            } else {
                                cancel();
                            }
                        }
                        input.addEventListener("blur", onChange);
                        input.addEventListener("keydown", e => {
                            if (e.keyCode === 13) onChange();
                            if (e.keyCode === 27) cancel();
                        });
                        return input;
                    },
                    formatter: "datetime",
                    formatterParams: {
                        inputFormat: "dd/MM/yyyy",
                        outputFormat: "dd/MM/yyyy",
                    },
                    tooltip: true,
                    editable: function (cell) {
                        let ALIVEYN = cell.getRow().getData().ALIVEYN;
                        return !cell.getRow().getData().ALIVEYN;
                    }
                },
                {
                    title: "Cause Death",
                    field: "CAUSEOFDEATH",
                    width: 150,
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
                    editable: function (cell) {
                        let ALIVEYN = cell.getRow().getData().ALIVEYN;
                        return !cell.getRow().getData().ALIVEYN;
                    }
                }
            ]
        });

    FamilyHistoryListtable['<%= pageType %>'].on("cellEdited", function (cell) {
        var RowData = cell.getRow().getData();
        if (RowData.ALIVEYN == true) {
            cell.getRow().update({ DATEOFDEATH: "", CAUSEOFDEATH: "" });
        }

        cell.getRow().normalizeHeight();
        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
    });

    FamilyHistoryListtable['<%= pageType %>'].on("rowAdded", function (row) {
        row.normalizeHeight();
        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
    });

    FamilyHistoryListtable['<%= pageType %>'].on("rowDeleted", function (row) {
        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
    });

    FamilyHistoryListtable['<%= pageType %>'].on("dataLoaded", function () {
        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
    });

    FamilyHistoryListtable['<%= pageType %>'].on("tableBuilt", function () {
        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
    });

    FamilyHistoryListtable['<%= pageType %>'].on("dataChanged", function () {
        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
    });

    /* Bind Already Saved FamilyHistory */
    SetDataForFamilyHistory_<%= pageType %>();

    /* Adjust Height */
    adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
});


    function validateDiagnosedDateWithAge(dateStr, age) {

        if (!dateStr) return true;

       //var ageStr = sessionStorage.getItem("PatAge");
       //var age = parseInt(ageStr) || 0;

        if (!age) return true;

        
        var parts = dateStr.split("/");
        var diagnosedDate = new Date(parts[2], parts[1] - 1, parts[0]);

       
        var today = new Date();

       
        var dob = new Date(today.getFullYear() - age, today.getMonth(), today.getDate());

        if (diagnosedDate < dob) return false;   
        if (diagnosedDate > today) return false;

        return true; 
    }
    function getDuration(maxDuration) {
        let durationContructor = {};
        for (let i = 0; i <= maxDuration; i++) {
            durationContructor[i] = [i];
        }
        return durationContructor;
    }
    function validateDurationWithAge(duration, category, Patage) {

        //var ageStr = sessionStorage.getItem("PatAge");
        //var age = parseInt(ageStr) || 0;

        duration = parseInt(duration) || 0;

        if (!category) return true;

        var durationInYears = 0;

        switch (category) {
            case "D": durationInYears = duration / 365; break;
            case "W": durationInYears = duration / 52; break;
            case "M": durationInYears = duration / 12; break;
            case "Y": durationInYears = duration; break;
            default: return true;
        }

        return durationInYears <= Patage;
    }
    //Convert Array to List For Tabulator Format
    function ConvertArryListToTabulatorFormat(DataList, PropText, PropValue) {
        let lookup = {};
        lookup[""] = "";
        DataList.forEach(item => {
            lookup[item[PropValue]] = item[PropText];
        });
        return lookup;
    }

    //Get All Diesease list
    function GetAllDiseaseList(TabYN) {
        var ListOfDisease = [];
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetDiseaseList",
            async: false,
            data: {},
            success: function (result) {
                if (result.length > 0) {
                    ListOfDisease = TabYN == "Y" ? ConvertArryListToTabulatorFormat(result, "DESC", "DESCCD") : result;
                }
            }
        });
        return ListOfDisease;
    }


//Validation Functionality For Save Family History
function ValidationForFamilyHistory_<%= pageType %>() {
    debugger;
    var activeTable = FamilyHistoryListtable['<%= pageType %>'];
    var tableDataHistFaml = activeTable ? activeTable.getData() : [];

    for (var i = 0; i < tableDataHistFaml.length; i++) {
        var row = tableDataHistFaml[i];
        if (!row.NAME || row.NAME.toString().trim() === "") {
            ToastMsg("Please select Relation");
            return false;
        }
        if (!row.DISEASES || row.DISEASES.toString().trim() === "") {
            ToastMsg("Please select Diseases");
            return false;
        }
        if (!row.DURATION || row.DURATION.toString().trim() === "" || row.DURATION === "0") {
            ToastMsg("Select Duration ");
            return false;
        }
        if (!row.DURTYPE || row.DURTYPE.toString().trim() === "") {
            ToastMsg("Select Duration Category");
            return false;
        }
        if (row.AGE && !validateDurationWithAge(row.DURATION, row.DURTYPE, row.AGE)) {
            ToastMsg("Duration cannot exceed patient age");
            return false;
        }
        if (row.DIAGNOSEDDATE && !validateDiagnosedDateWithAge(row.DIAGNOSEDDATE, row.AGE)) {
            ToastMsg("Diagnosed date should be within patient's age");
            return false;
        }
        if (row.ALIVEYN === false) {
            if (!row.DATEOFDEATH || row.DATEOFDEATH.toString().trim() === "") {
                ToastMsg("Please select Death Date");
                return false;
            }
            if (!row.CAUSEOFDEATH || row.CAUSEOFDEATH.toString().trim() === "") {
                ToastMsg("Please Enter Cause of Death");
                return false;
            }
        }
    }

   
    return true;
}


    


//Save Functionality For FamilyHistory 
function SaveForFamilyHistory_<%= pageType %>(isCommonSave) {
    if (ValidationForFamilyHistory_<%= pageType %>() == true) {
        var familyArr = [];
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO') || "";
        } else {
            tranNo = sessionStorage.getItem('IPPatIPNO') || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";
        }


        var activeTable = FamilyHistoryListtable['<%= pageType %>'];
        var tableData = activeTable ? activeTable.getData() : [];

        for (var i = 0; i < tableData.length; i++) {
            if (!tableData[i]['DURATION']) {
                ToastMsg("Select Duration ");
                return false;
            }
            if (!tableData[i]['DURTYPE']) {
                ToastMsg("Select Duration Category");
                return false;
            }
            if (!validateDiagnosedDateWithAge(tableData[i]['DIAGNOSEDDATE'], tableData[i]['AGE'])) {
                ToastMsg("Diagnosed date should be within patient's age");
                return false;
            }
            if (!validateDurationWithAge(tableData[i]['DURATION'], tableData[i]['DURTYPE'], tableData[i]['AGE'])) {
                ToastMsg("Duration cannot exceed patient age");
                return false;
            }
            var a = {
                MRNO: mrNo,
                NAME: FHRelationNameList[tableData[i].NAME],
                AGE: tableData[i].AGE,
                RELATION: tableData[i].NAME,
                STATUS: "",
                DISEASES: tableData[i].DISEASES,
                DURATION: tableData[i].DURATION,
                DURTYPE: tableData[i].DURTYPE,
                REMARKS: "",
                DIAGNOSEDDATE: tableData[i].DIAGNOSEDDATE,
                DISEASESTATUS: tableData[i].DISEASESTATUS,
                ALIVEYN: tableData[i].ALIVEYN == true ? "Y" : "N",
                DATEOFDEATH: tableData[i].DATEOFDEATH,
                CAUSEOFDEATH: tableData[i].CAUSEOFDEATH
            };
            familyArr.push(a);
        }
        $.ajax({
            type: "POST",
            url: '../Clinicalnotes/SaveFamily',
            async: false,
            datatype: "json",
            data: { strMedic: JSON.stringify(familyArr), strMRNO: mrNo, strTranNo: tranNo },
            success: function (result) {
                if (result === true) {
                    SaveOtherFamilyHistoryRemarks_<%= pageType %>(isCommonSave);
                } else {
                    ToastMsg('Unable to save the data. Please try again.', 'error');
                }
            }
        });
    }
}

function SaveOtherFamilyHistoryRemarks_<%= pageType %>(isCommonSave) {
    let value = $('#FamilyHistory_Freetext_<%= pageType %>').val();
    AddFreeFamilyHistory_<%= pageType %>(value, 'F', isCommonSave);
}

    //TextArea Remarks Section
function PerFamilyHist_prepareFreeTextData(strText, strTran, strMrNo, strType) {
    return {
        strText: strText,
        strTran: strTran,
        strMrNo: strMrNo,
        strType: strType
    };
}
function AddFreeFamilyHistory_<%= pageType %>(strText, strType, isCommonSave) {
    return new Promise(function (resolve, reject) {
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO') || "";
        } else {
            tranNo = sessionStorage.getItem('IPPatIPNO') || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";
        }


        let dataToSend = PerFamilyHist_prepareFreeTextData(strText, tranNo, mrNo, strType);
        startLoading('Loading');
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../Clinicalnotes/AddFreeHistory',
            data: dataToSend,
            success: function (response) {
                if (("" + response).toUpperCase().indexOf("NOT INSERTED") != -1 && sessionStorage.getItem("MODULE_FLAG") !== "IPD") {
                    ToastMsg(response, "info");
                } else {
                    if (typeof PatHistoryTab === "function") {
                        PatHistoryTab();
                    }
                    // Re-bind both IPD and Popup so changes replicate immediately on both!
                    if (typeof SetDataForFamilyHistory_IPD === "function") {
                        SetDataForFamilyHistory_IPD();
                    }
                    if (typeof SetDataForFamilyHistory_Popup === "function") {
                        SetDataForFamilyHistory_Popup();
                    }
                    if (!isCommonSave) {
                        ToastMsg('saved successfully.', 'success');
                    }
                }
                stopLoading();
                resolve(true);
            },
            error: function (xhr, status, error) {
                ToastMsg("Error saving remarks", "error");
                stopLoading();
            }
        });
    });
}


//Binding Functionality For FamilyHistory 
function SetDataForFamilyHistory_<%= pageType %>() {
    var tranNo = "";
    var mrNo = GetSessionMRNO();
    if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
        tranNo = sessionStorage.getItem('PatTRANNO') || "";
    } else {
        tranNo = sessionStorage.getItem('IPPatIPNO') || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";
    }


    startLoading("Loading", "loading-FamilyHistory_<%= pageType %>");
    $.ajax({
        type: 'post',
        datatype: 'json',
        data: { strTranNo: tranNo, strMrNo: mrNo },
        url: "../Clinicalnotes/SetDataForFamily",
        success: function (data) {
            if (!data || (!data[0] || data[0].length === 0) && (!data[1] || data[1].length === 0)) {
                stopLoading("loading-FamilyHistory_<%= pageType %>");
                return;
            }
            if (!(!data[0] || data[0].length === 0)) {
                var rowsToBind = [];
                var AllDiseaseListBind = GetAllDiseaseList("N");
                data[0].forEach(function (item) {
                    var DiseaseCode = "";
                    AllDiseaseListBind.filter(function (F) {
                        if (F.DESC.trim() == (item["DISEASES"] || "").trim())
                            DiseaseCode = F.DESCCD.trim();
                    });
                    rowsToBind.push({
                        NAME: item["RELATION"],
                        AGE: item["AGE"],
                        STATUS: "",
                        DISEASES: DiseaseCode,
                        DURATION: item["DURATION"],
                        DURTYPE: item["DURTYPE"],
                        DIAGNOSEDDATE: item["DIAGNOSEDDATE"],
                        DISEASESTATUS: item["DISEASESTATUS"],
                        ALIVEYN: item["ALIVEYN"] == "Y" ? true : false,
                        DATEOFDEATH: item["DATEOFDEATH"],
                        CAUSEOFDEATH: item["CAUSEOFDEATH"]
                    });
                });

                var activeTable = FamilyHistoryListtable['<%= pageType %>'];
                if (activeTable) {
                    activeTable.setData(rowsToBind).then(function () {
                        adjustTableHeight("FamilyHistoryTable_<%= pageType %>");
                    });
                }
            }
            if (!(!data[1] || data[1].length === 0)) {
                if (data[1][0]["FAMHIST"] != "") {
                    var $remark = $('#FamilyHistory_Freetext_<%= pageType %>');
                    $remark.val(data[1][0]["FAMHIST"].toString());
                    autoResizeTextareaForSinglePage($remark[0]);
                }
            }
            stopLoading("loading-FamilyHistory_<%= pageType %>");
        },
        error: function (xhr, status) {
            ToastMsg(status, "error");
            stopLoading("loading-FamilyHistory_<%= pageType %>");
        }
    });
}

</script>


<div id="FamilyHistory_<%= pageType %>">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold me-5">Other Family History</h6>
        <div class="position-relative ms-5">
            <div class="input-group input-group-sm w-100">
               <button class="btn btn-success fw-bold" id="SaveFamilyHistory_<%= pageType %>" onclick="SaveForFamilyHistory_<%= pageType %>()" style='<%= pageType == "IPD" ? "display: none;" : "" %>'>
                    <i class="fa fa-save" style="font-size: 15px;"></i><span style="padding: 0px 5px; font-size: 15px;">Save</span>
                </button>
            </div>
        </div>
    </div>
        <textarea class="form-control mb-2 TextAreaBorder fh-freetext-<%= pageType %>" id="FamilyHistory_Freetext_<%= pageType %>" name="FamilyHistory_Freetext_<%= pageType %>" oninput="autoResizeTextareaForSinglePage(this)" style="height: 100px; overflow-y: auto; resize: none;"></textarea>
      <div class="text-end mt-1">
        <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" onclick="toggleTextareaHeight(this, 'FamilyHistory_Freetext_<%= pageType %>')" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
    </div>
    <h6 class="fw-bold" style="padding: 15px 0px;">Family History List</h6>
    <div id="FamilyHistoryTable_<%= pageType %>"></div>
    <div id='loading-FamilyHistory_<%= pageType %>' class='loading-screen' style='display: none; opacity: 0;'></div>
</div>


