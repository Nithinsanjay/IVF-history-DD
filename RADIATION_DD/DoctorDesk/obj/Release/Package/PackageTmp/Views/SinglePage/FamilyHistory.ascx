<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style>
    #FamilyHistory_Freetext {
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

    var FamilyHistoryListtable;
    $(document).ready(function () {
        //debugger;
        /* Tabulator For FamilyHistory */
        FamilyHistoryListtable = new Tabulator("#FamilyHistoryTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "50",
            index: "code",
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
                    },
                    titleFormatter: function () {
                        return '<i class="fa fa-plus Add-New-FamilyHistory-plus" ' +
                            'style="cursor:pointer; margin-left:6px;" title="Add Row"></i> ';
                    },
                    headerClick: function (e, column) {
                        if ($(e.target).hasClass("Add-New-FamilyHistory-plus")) {
                            FamilyHistoryListtable.addRow({
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
                                row.normalizeHeight();
                                adjustTableHeight("FamilyHistoryTable");
                            });
                        }
                    }
                },
                {
                    title: "Relation",
                    field: "NAME",
                    editor: "list",
                    headerSort: false,
                    width: 150,
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
                    width: 80,
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
                    width: 110,
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
                    width: 130,
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
                    width: 130,
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
                    width: 140,
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
                    width: 80,
                    formatter: "tickCross",
                    editor: true
                },
                {
                    title: "Death Date",
                    field: "DATEOFDEATH",
                    sorter: "date",
                    width: 110,
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

        FamilyHistoryListtable.on("cellEdited", function (cell) {
            var RowData = cell.getRow().getData();
            if (RowData.ALIVEYN == true) {
                cell.getRow().update({ DATEOFDEATH: "", CAUSEOFDEATH: "" });
            }

            cell.getRow().normalizeHeight();
            adjustTableHeight("FamilyHistoryTable");
        });

        FamilyHistoryListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("FamilyHistoryTable");
        });

        FamilyHistoryListtable.on("rowDeleted", function (row) {
            adjustTableHeight("FamilyHistoryTable");
        });

        FamilyHistoryListtable.on("dataLoaded", function () {
            adjustTableHeight("FamilyHistoryTable");
        });

        FamilyHistoryListtable.on("tableBuilt", function () {
            adjustTableHeight("FamilyHistoryTable");
        });

        FamilyHistoryListtable.on("dataChanged", function () {
            adjustTableHeight("FamilyHistoryTable");
        });

        /* Bind Already Saved FamilyHistory */
        SetDataForFamilyHistory();

        /* Adjust of Height Of FamilyHistory Table */
        adjustTableHeight("FamilyHistoryTable");




        $('#SaveFamilyHistory').click(function () {
            //SaveOtherFamilyHistoryRemarks();
            SaveForFamilyHistory();
        });

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
    function ValidationForFamilyHistory() {
        var tableDataHistFaml = FamilyHistoryListtable.getData();
        if (FamilyHistoryMandatoryYN == "Y") {
            for (var i = 0; i < tableDataHistFaml.length; i++) {
                if (tableDataHistFaml[i].NAME == "") {
                    ToastMsg("Please select Relation", "warning");
                    return false;
                }
                if (tableDataHistFaml[i].DISEASES == "") {
                    ToastMsg("Please select Diseases For " + tableDataHistFaml[i].NAME, "warning");
                    return false;
                }
                if (tableDataHistFaml[i].AGE == "" || tableDataHistFaml[i].AGE == "0") {
                    ToastMsg("Please select Age For " + tableDataHistFaml[i].NAME, "warning");
                    return false;
                }
                if (tableDataHistFaml[i].DURATION == "" || tableDataHistFaml[i].DURATION == "0") {
                    ToastMsg("Please select Duration For " + tableDataHistFaml[i].NAME, "warning");
                    return false;
                }
                if (tableDataHistFaml[i].DIAGNOSEDDATE == "") {
                    ToastMsg("Please select Diagnosed Date For " + tableDataHistFaml[i].NAME, "warning");
                    return false;
                }
                if (tableDataHistFaml[i].DISEASESTATUS == "") {
                    ToastMsg("Please select Disease Status For " + tableDataHistFaml[i].NAME, "warning");
                    return false;
                }
                if (tableDataHistFaml[i].ALIVEYN == false) {
                    if (tableDataHistFaml[i].DATEOFDEATH == "") {
                        ToastMsg("Please select Death Date For " + FHRelationNameList[tableDataHistFaml[i].NAME], "warning");
                        return false;
                    }
                    if (tableDataHistFaml[i].CAUSEOFDEATH == "") {
                        ToastMsg("Please Enter Cause of Death For " + FHRelationNameList[tableDataHistFaml[i].NAME], "warning");
                        return false;
                    }
                }
            }
        }
        return true;
    }

    //Save Functionality For FamilyHistory 
    function SaveForFamilyHistory() {
        if (ValidationForFamilyHistory() == true) {
            var familyArr = [];
            var tranNo = "";
            var mrNo = GetSessionMRNO();
            if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
                tranNo = sessionStorage.getItem('PatTRANNO');
            }
            var tableData = FamilyHistoryListtable.getData();
            for (var i = 0; i < tableData.length; i++) {

                if (!tableData[i]['DURATION']) {
                    ToastMsg("Select Duration ");
                    return false;
                }

                if (!tableData[i]['DURTYPE']) {
                    ToastMsg("Select Duration Category");
                    return false;
                }

                if (!validateDiagnosedDateWithAge(
                    tableData[i]['DIAGNOSEDDATE'],
                    tableData[i]['AGE']
                   
                )) {
                    ToastMsg("Diagnosed date should be within patient's age");
                    return false;
                }

                if (!validateDurationWithAge(
                    tableData[i]['DURATION'],
                    tableData[i]['DURTYPE'],
                    tableData[i]['AGE']
                )) {
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
                    //REMARKS:$("#FamilyHistory_Freetext").val(),
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
                        //ToastMsg('Data has been saved successfully.', 'success');
                        //PatHistoryTab();//priyanka 08/04/2026
                        SaveOtherFamilyHistoryRemarks();
                    }
                    else {
                        ToastMsg('Unable to save the data. Please try again.', 'error');
                    }

                }
            });
        }
    }

    function SaveOtherFamilyHistoryRemarks() {
        let value = $('#FamilyHistory_Freetext').val();
        //if (value)
            AddFreeFamilyHistory(value, 'F');
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
    function AddFreeFamilyHistory(strText, strType) {
        return new Promise(function (resolve, reject) {
            //let mrNo = sessionStorage.getItem('PatMRNO');
            //let tranNo = sessionStorage.getItem('PatTRANNO');

            var tranNo = "";
            var mrNo = GetSessionMRNO();
            if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
                tranNo = sessionStorage.getItem('PatTRANNO');
            }

            let dataToSend = PerFamilyHist_prepareFreeTextData(strText, tranNo, mrNo, strType)
            startLoading('Loading');
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../Clinicalnotes/AddFreeHistory',
                data: dataToSend,
                success: function (response) {

                    if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                        ToastMsg(response, "info");
                    }
                    else {
                        PatHistoryTab();
                        ToastMsg("Saved successfully", "success");
                    }
                },
                error: function (xhr, status, err) {
                    ToastMsg("Error Processing", "error");
                },
                complete: function () {
                    stopLoading();
                }
            })
        })
    }
    //Binding Functionality For FamilyHistory 
    function SetDataForFamilyHistory() {
        //debugger;
        //var tranNo = sessionStorage.getItem('PatTRANNO');
        //var mrNo = sessionStorage.getItem('PatMRNO');
        //priyanka 14/03/2026
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO');
        }

        startLoading("Loading", "loading-FamilyHistory");
        $.ajax({
            type: 'post',
            datatype: 'json',
            data: { strTranNo: tranNo, strMrNo: mrNo },
            url: "../Clinicalnotes/SetDataForFamily",
            success: function (data) {
                if (!data || (!data[0] || data[0].length === 0) && (!data[1] || data[1].length === 0)) {
                    stopLoading("loading-FamilyHistory");
                    return;
                }
                if (!(!data[0] || data[0].length === 0)) {
                    var existingRows = FamilyHistoryListtable.getData();
                    var AllDiseaseListBind = GetAllDiseaseList("N");
                    data[0].forEach(function (item) {
                        var exists = existingRows.some(function (r) {
                            return r.code === item.DESCCD;
                        });
                        if (exists) return;
                        var DiseaseCode = "";
                        AllDiseaseListBind.filter(function (F) {
                            if (F.DESC.trim() == item["DISEASES"])
                                DiseaseCode = F.DESCCD.trim();
                        });
                        FamilyHistoryListtable.addRow({
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
                }
                if (!(!data[1] || data[1].length === 0)) {
                    if (data[1][0]["FAMHIST"] != "") {
                        $("#FamilyHistory_Freetext").val(data[1][0]["FAMHIST"].toString());
                        autoResizeTextareaForSinglePage(document.getElementById('FamilyHistory_Freetext'));
                    }
                }
                stopLoading("loading-FamilyHistory");
            },
            error: function (xhr, status) {
                ToastMsg(status, "error");
                stopLoading("loading-FamilyHistory");
            }
        });
    }
</script>


<div id="FamilyHistory">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold me-5">Other Family History</h6>
        <div class="position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <button class="btn btn btn-success fw-bold" id="SaveFamilyHistory"><i class="fa fa-save" style="font-size: 15px;"></i><span style="padding: 0px 5px; font-size: 15px;">Save</span></button>
            </div>
        </div>
    </div>
    <textarea class="form-control mb-2 TextAreaBorder" id="FamilyHistory_Freetext" name="FamilyHistory_Freetext" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none;"></textarea>
    <h6 class="fw-bold" style="padding: 15px 0px;">Family History List</h6>
    <div id="FamilyHistoryTable"></div>
    <div id='loading-FamilyHistory' class='loading-screen' style='display: none; opacity: 0;'></div>
</div>
