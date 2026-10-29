<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style>
    #priorityRegular.form-check-input:checked {
    background-color: #2e72ad;
    border-color: #2e72ad;
    background-image: none;
}


#priorityRegular.form-check-input {
    width: 18px;
    height: 18px;
    border-radius: 50%;
    border: 2px solid #2e72ad;
    cursor: pointer;
}

#priorityEmergency.form-check-input:checked {
    background-color: #d71414;
    border-color: #d71414;
    background-image: none;
}


#priorityEmergency.form-check-input {
    width: 18px;
    height: 18px;
    border-radius: 50%;
    border: 2px solid #d71414;
    cursor: pointer;
}

</style>
<script type="text/javascript">
    var SurgeryTbl = [];
    var surgeryCategories = [];
    var surgeryDescriptions = [];
    var Time = new Date();
    var CuurentTime = Time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
    var OTBookingNo = ""; // sessionStorage.getItem('OTBookingNo');
    $(document).ready(function () {
        $('#txtAdvisedDT').datepicker({
            showButtonPanel: true,
            dateFormat: 'dd/mm/yy',
            yearRange: 'c-150:c+0',
            changeMonth: true,
            changeYear: true,
            minDate: new Date(),

        });
        /*$('#txtAdvisedDT').datepicker("setDate", new Date());*/
        fetchDropdownData();
        GetOTBookingRequestListGridData();
    });

    function fetchDropdownData() {
        var categoriesLoaded = false;
        var descriptionsLoaded = false;

        $.ajax({
            url: '../SinglePage/GetSurgryCatg',
            async:true,
            success: function (response) {
                surgeryCategories = typeof response === "string" ? JSON.parse(response) : response;
                categoriesLoaded = true;
                if (categoriesLoaded && descriptionsLoaded) initializeTable();
            }
        });

        $.ajax({
            url: '../SinglePage/GetSurgeryList',
            async: true,
            success: function (response) {
                surgeryDescriptions = typeof response === "string" ? JSON.parse(response) : response;
                descriptionsLoaded = true;
                if (categoriesLoaded && descriptionsLoaded) initializeTable();
            }
        });
    }

    function initializeTable() {
        SurgeryTbl = new Tabulator("#SurgeryTable", {
            layout: "fitColumns",
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            columns: [
                {
                    title: "<i class='fa fa-plus text-success' style='color: yellow !important; text-align: center;' onclick='AddNewRow()'></i>",
                    field: "action", width: 50, hozAlign: "center",
                    formatter: function (cell) { return "<i class='fa fa-trash text-danger'></i>"; },
                    cellClick: function (e, cell) { cell.getRow().delete(); }
                },
                {
                    title: "Surgery Category",
                    field: "SURGERYCATG",
                    editor: "list",
                    //editorParams: function (cell) {
                    //    let rowData = cell.getRow().getData();
                    //    if (rowData.SURGERYDESC) {
                    //        let surg = surgeryDescriptions.find(s => s.SURGERY_DESC.toUpperCase() === rowData.SURGERYDESC.toUpperCase());
                    //        if (surg) {
                    //            let cat = surgeryCategories.find(c => c.Value === surg.DISIPLINCD);
                    //            if (cat) return { values: [cat.Text] };
                    //        }
                    //    }
                    //    return { values: surgeryCategories.map(c => c.Text) };

                    //},
                    editorParams: function (cell) {
                        let rowData = cell.getRow().getData();

                        if (rowData.SURGERYDESC) {
                            let surg = surgeryDescriptions.find(
                                s => s.SURGERY_DESC.toUpperCase() === rowData.SURGERYDESC.toUpperCase()
                            );

                            if (surg) {
                                let cat = surgeryCategories.find(c => c.Value === surg.DISIPLINCD);

                                if (cat) {
                                    return {
                                        values: [cat.Text],
                                        autocomplete: true,
                                        listOnEmpty: true,
                                        filterRemote: false,
                                        allowEmpty: true,
                                        emptyGenericPlaceholder: false
                                    };
                                }
                            }
                        }

                        return {
                            values: surgeryCategories.map(c => c.Text),
                            autocomplete: true,
                            listOnEmpty: true,
                            filterRemote: false,
                            allowEmpty: true,
                            emptyGenericPlaceholder: false
                        };
                    },
                    cellEdited: function (cell) {
                        let val = cell.getValue();
                        let row = cell.getRow();
                        if (!val) {
                            row.update({ "SurgeryCatgCd": "" });
                            return;
                        }
                        /*let catObj = surgeryCategories.find(c => c.Text.toUpperCase() === val.toUpperCase());*/
                        let catObj = surgeryCategories.find(c => c.Text.toUpperCase() === val.toUpperCase());
                        if (catObj) {
                            row.update({ "SurgeryCatgCd": catObj.Value });
                        }
                    }
                },
                {
                    title: "Surgery Name",
                    field: "SURGERYDESC",
                    editor: "list",
                    editorParams: function (cell) {
                        let rowData = cell.getRow().getData();
                        let filtered = [...surgeryDescriptions];

                        if (rowData.SURGERYCATG) {
                            let catObj = surgeryCategories.find(
                                c => c.Text.toUpperCase() === rowData.SURGERYCATG.toUpperCase()
                            );

                            if (catObj) {
                                filtered = surgeryDescriptions.filter(
                                    s => s.DISIPLINCD === catObj.Value
                                );
                            }
                        }

                        return {
                            values: filtered.map(s => s.SURGERY_DESC),
                            autocomplete: true,
                            listOnEmpty: true,
                            filterRemote: false,
                            allowEmpty: true
                        };
                    },
                    //Pournima 4th July 2026
                    cellEdited: function (cell) {

                        let val = cell.getValue();
                        let row = cell.getRow();

                        if (!val) {
                            row.update({ "SurgeryDescCD": "" });
                            return;
                        }

                        setTimeout(function () {

                            let surgObj = surgeryDescriptions.find(s => s.SURGERY_DESC.toUpperCase() === val.toUpperCase());

                            if (!surgObj) return;
                            let duplicate = SurgeryTbl.getRows().some(function (r) {
                                return r !== row && r.getData().SurgeryDescCD === surgObj.SURGERY_CODE;
                            });

                            if (duplicate) {
                                ToastMsg("This Surgery Name has already been added.", "warning");
                                row.update({ SURGERYDESC: "", SurgeryDescCD: "", SURGERYCATG: "", SurgeryCatgCd: "" });
                                return;
                            }

                            var MsgPromptSurgy = "";
                            var ReqLstTblData = OTBookingReqLstTbl.getData() || [];
                            if (ReqLstTblData.length > 0) {
                                var FilterData = $.grep(ReqLstTblData, function (c) {
                                    return c.SURGERYCODES
                                        .split(',')
                                        .some(code => code.trim().toUpperCase() === surgObj.SURGERY_CODE.toUpperCase());
                                });
                                var hasP = $.grep(FilterData, function (c) {
                                    return c.STATUSCODE?.toUpperCase() === "P";
                                });

                                var hasA = $.grep(FilterData, function (c) {
                                    return c.STATUSCODE?.toUpperCase() === "A";
                                });
                                if (hasP.length > 0) {
                                    setTimeout(function () {
                                        row.update({
                                            SURGERYDESC: "",
                                            SurgeryDescCD: "",
                                            SURGERYCATG: "",
                                            SurgeryCatgCd: ""
                                        });
                                        ToastMsg("This Surgery already pending in booking request.", "warning");
                                    }, 0);

                                    return;
                                }
                                else if (hasA.length > 0) {
                                    var ReqDateTime = hasA.map(function (c) {
                                        return c.REQDATETIME;
                                    }).join(',');
                                    MsgPromptSurgy = "This Surgery is already booked on " + ReqDateTime + " . Do you want to continue ?"; 
                                    //var YFunc = "UpdateSurgeryConfrm('" + row + "','" + surgObj + "')";
                                    openPopupDynamic("Confirmation", MsgPromptSurgy, [
                                        {
                                            text: "Yes",
                                            class: "btn btn-yes",
                                            action: function () {
                                                UpdateSurgeryConfrm(row, surgObj);
                                            }
                                        },
                                        {
                                            text: "No",
                                            class: "btn btn-no",
                                            action: function () { }
                                        }
                                    ]);
                                    let updateData = {};
                                    updateData.SURGERYDESC = "";
                                    updateData.SurgeryDescCD = "";
                                    updateData.SURGERYCATG = "";
                                    updateData.SurgeryCatgCd = "";
                                    row.update(updateData);
                                    return;
                                }
                            }
                            let updateData = { SurgeryDescCD: surgObj.SURGERY_CODE };
                            let catObj = surgeryCategories.find(c => c.Value === surgObj.DISIPLINCD);

                            if (catObj) {
                                updateData.SURGERYCATG = catObj.Text;
                                updateData.SurgeryCatgCd = catObj.Value;
                            }
                            row.update(updateData);

                        }, 10);
                    }
                },
                { title: "Catg Code", field: "SurgeryCatgCd", visible: false },
                { title: "Desc Code", field: "SurgeryDescCD", visible: false }
            ],
            data: []
        });

        SurgeryTbl.on("cellEdited", function (cell) {  // priyanka 06/05/2026

            if (cell.getField() === "SURGERYDESC") {
                let val = cell.getValue();
                let div = document.getElementById("IPDBKReqDivAllSchemeMainDiv");

                if (val && val.trim() !== "") {
                    if (sessionStorage.getItem("IPDCompCode") != "" && sessionStorage.getItem("IPDCompCode") != null && sessionStorage.getItem("IPDCompCode") != undefined && AllIPDSchemeList.length != 0) {
                        div.classList.remove("d-none"); 
                    } else {
                        div.classList.add("d-none");
                    }
                } else {
                    div.classList.add("d-none");
                }
            }

        });
    }

    function UpdateSurgeryConfrm(row, surgObj) {
        let updateData = { SurgeryDescCD: surgObj.SURGERY_CODE };
        let catObj = surgeryCategories.find(c => c.Value === surgObj.DISIPLINCD);

        if (catObj) {
            updateData.SURGERYCATG = catObj.Text;
            updateData.SurgeryCatgCd = catObj.Value;
            updateData.SURGERYDESC = surgObj.SURGERY_DESC;
            updateData.SurgeryDescCD = surgObj.SURGERY_CODE;
        }
        row.update(updateData);
    }

    function AddNewRow() {
        SurgeryTbl.addRow({});
    }

    //Validation Functionality For Save OTBookingRequest
    function ValidationForOTBookingRequest(Type) {
        return true;
    }

    function SaveForOTBookingRequest() {

        var OTBook = [];
        var tableData = SurgeryTbl.getData();
        var selectedPriority = $("input[name='priority']:checked").val();
        var remark = $("#OTRemark").val();
        var surgeryRemark = $("#OTSurgeryRemark").val();
        var Side = $("#SideType").val();
        var ApplyScheme = ipdbkreqallschemesListtable.getData().map(row => row.code).join(',');//priyanka 04/05/2026
        if ((!tableData || tableData.length === 0) && surgeryRemark == "") {
            return;
        }
        for (var i = 0; i < tableData.length; i++) {
            var row = tableData[i];
            var obj = {
                CODE: row.SurgeryDescCD || "",
                DOCTOR: "",
                SIDE: Side || "",
                REMARK: remark || ""
            };
            OTBook.push(obj);
        }

        var datatosend = {
            Ipno: $('#txtstrUIPNo').val().trim(),
            Mrno: sessionStorage.getItem('IPPatMRNO'),
            NursStation: "",
            BedWardNo: sessionStorage.getItem('IPPatBedNo'),
            GridData: JSON.stringify(OTBook),
            GAction: "",
            ReqNo: "",
            SurgeryDate: $('#txtAdvisedDT').val(),
            SurgeryTime: CuurentTime,
            OTCathType: "",
            strPriority: selectedPriority,
            Remarks: remark,
            SurgeryRemarks: surgeryRemark,
            Diagnosis: "",
            SchemeCodes: ApplyScheme, //priyanka 04/05/2026
            Side: $("#SideType").val()
        };

        $.ajax({
            type: "POST",
            url: "../SinglePage/SaveOTCathReq",
            data: datatosend,
            dataType: "json",
            async: false,
            success: function (response) {
                if (response && response.includes("Booking No.")) {
                    var parts = response.split("Booking No.");
                    if (parts.length > 1) {
                        OTBookingNo = parts[1].trim();
                    }
                }
                ToastMsg(response, "success");
               // SetDataForOT();
            },
            error: function (xhr) {
                ToastMsg("Error while saving", "error");

            }
        });
    }

</script>

<%--Priyanka 04/05/2026--%>
<script>
    var ipdbkreqallschemesListtable;
    var AllIPDSchemeList = [];
    var IPDBKReqisBindingSchemes = false;
    $(document).ready(function () {
        ipdbkreqallschemesListtable = new Tabulator("#IPDBKReq_AllSchemeTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "50",
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
                    formatter: function (cell) {
                        return cell.getValue();
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var data = row.getData();

                        if ($(e.target).hasClass("info-row")) {
                            HistoryPopupOpen('IPD Booking Request Schemes Info', 'IPDBKReqSchemeInfo', true, data);
                        }

                        if ($(e.target).hasClass("delete-row")) {
                            row.delete();
                            adjustTableHeight("IPDBKReq_AllSchemeTable");
                        }
                    }

                },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    width: 900,
                    formatter: "textarea",
                    formatterParams: {
                        minHeight: "auto",
                    },
                    cssClass: "wrap-text"
                }
            ]
        });

        ipdbkreqallschemesListtable.on("cellEdited", function (cell) {
            cell.getRow().normalizeHeight();
            adjustTableHeight("IPDBKReq_AllSchemeTable");
        });

        ipdbkreqallschemesListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("IPDBKReq_AllSchemeTable");
        });

        ipdbkreqallschemesListtable.on("rowDeleted", function (row) {
            adjustTableHeight("IPDBKReq_AllSchemeTable");
            var code = row.getData().code;
            $(".scheme-checkbox[data-code='" + code + "']").prop("checked", false);
        });

        ipdbkreqallschemesListtable.on("dataLoaded", function () {
            adjustTableHeight("IPDBKReq_AllSchemeTable");
        });

        ipdbkreqallschemesListtable.on("tableBuilt", function () {
            adjustTableHeight("IPDBKReq_AllSchemeTable");
        });

        ipdbkreqallschemesListtable.on("dataChanged", function () {
            adjustTableHeight("IPDBKReq_AllSchemeTable");
        });

        $(document).on("change", ".ipdbkreqscheme-checkbox", function (e) {
            e.stopPropagation();
            var code = $(this).data("code");
            var name = $(this).data("name");
            var table = ipdbkreqallschemesListtable;
            if (this.checked) {
                var exists = table.getData().some(r => r.code === code);
                if (exists) {
                    ToastMsg("Scheme already added", "warning");
                    IPDBKReqisBindingSchemes = true;
                    $(this).prop("checked", false);
                    IPDBKReqisBindingSchemes = false;
                    return;
                }
                table.addRow({
                    act: '<i class="fa fa-info-circle text-primary info-row" ' +
                        'style="cursor:pointer; margin-right:8px;" title="View Info"></i>' +
                        '<i class="fa fa-trash text-danger delete-row" ' +
                        'style="cursor:pointer;" title="Delete"></i>',
                    code: code,
                    name: name
                }).then(function (row) {
                    row.normalizeHeight();
                    adjustTableHeight("IPDBKReq_AllSchemeTable");
                });

            } else {
                // Remove row if unchecked
                var row = table.getRow(code);
                if (row) {
                    row.delete();
                    adjustTableHeight("IPDBKReq_AllSchemeTable");
                }
            }
        });

        $(document).on("click", function (e) {
            if (!$(e.target).closest("#IPDBKReqSearchSchemeInputSearch, #IPDBKReq_DivSchemeSearchMainDiv").length) {
                $("#IPDBKReq_DivSchemeSearchMainDiv").hide();
                $("#IPDBKReqSearchSchemeInputSearch").val("");
            }
        });
        GetIPDOTBookReqSchemesList();
    });

    function IPDBKReqSchemePatList(callback) {
        if (SurgeryTbl.getRows().length >= 1) {
            var strMRNo = sessionStorage.getItem('IPPatMRNO');
            var strCompCode = sessionStorage.getItem('IPDCompCode');
            AllIPDSchemeList = [];
            $.ajax({
                url: '../DoctorDesk/GetSchemaList',
                data: { PatMRNO: strMRNo, Speciality: "S", strCompCode: strCompCode },
                type: 'post',
                async: true,
                datatype: 'json',
                success: function (response) {
                    if (response.length > 0) {
                        var IPDBKReq_AllSchemesData = response || [];
                        BindSearchListForIPDBKReqAllSchemes(IPDBKReq_AllSchemesData);
                        if (typeof callback === "function") {
                            callback();
                        }
                        AllIPDSchemeList = response;
                        if (sessionStorage.getItem("IPDCompCode") != "" && sessionStorage.getItem("IPDCompCode") != null && sessionStorage.getItem("IPDCompCode") != undefined && AllIPDSchemeList.length != 0) {
                            $("#IPDBKReqDivAllSchemeMainDiv").removeClass("d-none");
                        }
                    }
                    else {
                        $("#IPDBKReqDivAllSchemeMainDiv").addClass("d-none");
                    }
                }
            });
        }
    }

    function GetIPDOTBookReqSchemesList() { //priyanka 06/05/2026
        var strMRNo = sessionStorage.getItem('IPPatMRNO');
        var strCompCode = sessionStorage.getItem('IPDCompCode');
        AllIPDSchemeList = [];
        $.ajax({
            url: '../DoctorDesk/GetSchemaList',
            data: { PatMRNO: strMRNo, Speciality: "S", strCompCode: strCompCode },
            type: 'post',
            async: true,
            datatype: 'json',
            success: function (response) {
                if (response.length > 0) {
                    AllIPDSchemeList = response;
                }
            }
        });     
    }

    function BindSearchListForIPDBKReqAllSchemes(IPDBKReq_AllSchemesData) {
        var $list = $("#IPDBKReqAllSchemesList");
        $list.empty();

        var addedCodes = IPDBkReqgetAddedSchemeCodes();

        var AppendContentList = '<div class="list-group-item text-muted">No schemes found</div>';

        if (IPDBKReq_AllSchemesData.length > 0) {
            AppendContentList = "";

            for (var i = 0; i < IPDBKReq_AllSchemesData.length; i++) {
                var item = IPDBKReq_AllSchemesData[i];

                var isChecked = addedCodes.indexOf(item.Value) !== -1 ? "checked" : "";

                var ListOption =
                    '<div class="list-group-item ipdbkreqchemes-row">' +
                    '<input type="checkbox" class="ipdbkreqscheme-checkbox" ' +
                    'data-code="' + item.Value + '" ' +
                    'data-name="' + item.Text + '" ' +
                    'id="ipdbkreqscheme_' + i + '" ' + isChecked + ' />' +
                    '<label for="ipdbkreqscheme_' + i + '" style="margin-left:5px;">' +
                    item.Text + ' (' + item.Value + ')' +
                    '</label>' +
                    '</div>';

                AppendContentList += ListOption;
            }
        }

        $list.append(AppendContentList);
        $("#IPDBKReq_DivSchemeSearchMainDiv").show();
    }

    function IPDBkReqgetAddedSchemeCodes() {
        if (ipdbkreqallschemesListtable)
            return ipdbkreqallschemesListtable.getData().map(function (r) { return r.code; });
    }
    /* ===================== FILTER SCHEMES LIST ===================== */
    function FilterBindedSearchListForIPDBkReqSchemes() {
        var SearchTxt = $("#IPDBKReqSearchSchemeInputSearch").val().toLowerCase();
        $("#IPDBKReqAllSchemesList .ipdbkreqchemes-row").each(function () {
            var $chk = $(this).find(".ipdbkreqscheme-checkbox");
            var rawName = $chk.data("name");
            var rawCode = $chk.data("code");
            var name = rawName ? rawName.toString().toLowerCase() : "";
            var code = rawCode ? rawCode.toString().toLowerCase() : "";
            if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    function BindSavedSchemeAdvice(schemeCodes) {
        IPDBKReqisBindingSchemes = true;

        var codes = schemeCodes ? schemeCodes.split(",") : [];

        IPDBKReqSchemePatList(function () {
            $(".ipdbkreqscheme-checkbox").each(function () {
                var code = $(this).data("code");
                var name = $(this).data("name");

                if (codes.indexOf(code) !== -1) {
                    $(this).prop("checked", true);

                    ipdbkreqallschemesListtable.addRow({
                        act: '<i class="fa fa-info-circle text-primary info-row" ' +
                            'style="cursor:pointer; margin-right:8px;" title="View Info"></i>',
                        code: code,
                        name: name
                    }).then(function (row) {
                        row.normalizeHeight();
                        adjustTableHeight("IPDBKReq_AllSchemeTable");
                    });
                }
            });

            $("#IPDBKReq_DivSchemeSearchMainDiv").hide();
            IPDBKReqisBindingSchemes = false;
        });
    }
</script>

<%--priyanka 05/05/2026--%>
<script>
    var OTBookingReqLstTbl;
    function GetOTBookingRequestList() {
        const today = new Date().toISOString().split('T')[0];
        return `
        <div class="stat-wrapper">
        <div id="OTBookingRequestLstTable" class="stat-grid-container"></div>
        <div id="loading-OT-Booking-List" class="loading-screen" style="display: none; opacity: 0;"></div>
        </div>
        `;
    }
    function LoadOTBookingRequestListGrid(tableData) {
        
        OTBookingReqLstTbl = new Tabulator("#OTBookingRequestLstTable", {
            data: tableData,
            height: "auto",
            layout: "fitColumns",
            columns: [
                { title: "", formatter: "rownum", width: 50, hozAlign: "center", headerSort: false, visible: false },
                { title: "act", field: "act", width: 180, headerFilter: "input", tooltip: true, visible: false },
                { title: "REQ No.", field: "REQNO", width: 190, headerFilter: "input", tooltip: true },
                { title: "REQ Date / Time", field: "REQDATETIME", width: 168, headerFilter: "input", tooltip: true },
                { title: "OT Booking No.", field: "OTBOOKINGNO", width: 190, headerFilter: "input", tooltip: true },
                { title: "Surgery Date / Time", field: "SURGDTTM", width: 190, headerFilter: "input", tooltip: true },
                { title: "Surgery", field: "SURGERY", width: 209, headerFilter: "input", tooltip: true },
                { title: "Schemes", field: "SCHEMES", width: 209, headerFilter: "input", tooltip: true },
                { title: "Priority", field: "PRIORITY", width: 117, headerFilter: "input", tooltip: true },
                { title: "Remarks", field: "REMARKS", width: 190, headerFilter: "input", tooltip: true },
                { title: "Request Status", field: "STATUS", width: 190, headerFilter: "input", tooltip: true },
                { title: "Surgery Codes", field: "SURGERYCODES", width: 190, tooltip: true, visible: false },
                { title: "Status Codes", field: "STATUSCODE", width: 190, tooltip: true, visible: false },
                { title: "Surgery Description", field: "SURGADVICEOTHER", width: 190, headerFilter: "input", tooltip: true, visible: true },
                //{ title: "MR No", field: "MRNO", width: 146, hozAlign: "left", headerFilter: "input", tooltip: true },
                //{ title: "IP No", field: "IPNO", width: 140, hozAlign: "left", headerFilter: "input", tooltip: true },
                //{ title: "Patient Name", field: "PATIENTNAME", width: 200, hozAlign: "left", headerFilter: "input", tooltip: true, visible: true },
                //{ title: "Ward", field: "WARD", width: 300, hozAlign: "left", headerFilter: "input", tooltip: true },
                //{ title: "Bed No.", field: "BEDNO", width: 114, hozAlign: "left", headerFilter: "input", tooltip: true },
                //{ title: "Nursing Station", field: "NURST", width: 190, headerFilter: "input", tooltip: true },
                //{ title: "Patient Type", field: "PATTYPE", width: 190, headerFilter: "input", tooltip: true },
                //{ title: "OT Cath Type", field: "OTCATHTYPE", width: 190, headerFilter: "input", tooltip: true },
                //{ title: "Casual No.", field: "CASUALNO", width: 190, headerFilter: "input", tooltip: true },
                
            ],
        });
    }


    function GetOTBookingRequestListGridData() {
        var sfrom = "";
        var sto = "";
        var varAdmnDoct = "";
        var varStatus = "";
        var sipno = sessionStorage.getItem("IPPatIPNO");
        var smrno = sessionStorage.getItem("IPPatMRNO");
        var varNSstn = "";
        var varPriority = "";
        var strCrdtCompCode = sessionStorage.getItem("IPDCompCode");
        var Speciality = "S";

        var urlq = '../SinglePage/GetOTCathBookRequestList?DTFrm=' + sfrom + '&&DTto=' + sto + '&&ReqNo=' + varAdmnDoct + '&&OTCath=' + varStatus + '&&IPNO=' + sipno +
            '&&smrno=' + smrno + '&&SNURSESTN=' + varNSstn + '&&status=' + varPriority + '&&sType=' + varPriority + '&&PatName=' + "" + '&&ORDERTYPE=L' + '&&strCrdtCompCode=' + strCrdtCompCode +
            '&&Speciality=' + Speciality;

        startLoading("Loading", "loading-OT-Booking-List");
        $.ajax({
            type: "POST",
            url: urlq,
            async: true,
            success: function (result) {
                var res = [];
                if (result != null && result.length > 0) {
                    res = result;
                }
                LoadOTBookingRequestListGrid(res);
                stopLoading("loading-OT-Booking-List");
            },
            onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-OT-Booking-List");
                ToastMsg(textStatus, "error");
            }
        });
    }
</script>

<div id="sec-OTBookingRequest" class="opd-section-card anchor-offset container-fluid">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h4 class="section-title me-5">OT Booking Request</h4>
        <div style="display: none;">
            <button class="btn btn-outline-success btn-sm" id="OTBookingReq_List" onclick="HistoryPopupOpen('OT Booking Request List', 'OTBKList',true,'')" title="OT Booking Request List">List</button>
        </div>
    </div>
    <!-- Header Section -->
    <div class="d-flex flex-wrap align-items-center mb-3 gap-3">
        <!-- Priority -->
        <div class="d-flex align-items-center gap-2">
            <label class="mb-0 fw-bold">Priority</label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="priority" id="priorityRegular" value="R" checked="checked"> <%--Abhishesh || 20260806--%>
                <label class="form-check-label" for="priorityRegular" style="color: #2e72ad; font-weight: bold;">Elective</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="priority" id="priorityEmergency" value="E">
                <label class="form-check-label" for="priorityEmergency" style="color: #d71414; font-weight: bold;">Emergency</label>
            </div>
        </div>

        <!-- Side -->
        <div class="d-flex align-items-center gap-2">
    <label class="mb-0 fw-bold">Side</label>
    <select class="form-select form-select-sm" style="width: auto;" id="SideType">
                <option value="">--Select--</option> 
        <option value="B">Bilateral</option> 
        <option value="L">Left</option>
        <option value="R">Right</option>
         <option value="M">Midline</option>
         <option value="N">NA</option>
       <%-- <option value="B">Both</option>--%>
    </select>
</div>

        <!-- Advised Date -->
        <div class="d-flex align-items-center gap-2">
            <label class="mb-0 fw-bold">Advised Date</label>
            <input type="text" class="form-control form-control-sm" readonly id="txtAdvisedDT" style="width: 150px;">
        </div>
    </div>
    <!-- Remark -->
    <div class="d-flex align-items-center gap-2 mb-3 flex-grow-1">
        <label class="mb-0 fw-bold">Remark</label>
        <textarea class="form-control form-control-sm TextAreaBorder" id="OTRemark" placeholder="Enter Your Remark" rows="2"></textarea>
    </div>
    <%--    </div>--%>

   <!-- Surgery Table -->
   <div class="mb-3" id="SurgeryTable"></div>

    <div class="d-flex align-items-center gap-2 mb-3 flex-grow-1">
        <label class="mb-0 fw-bold" style="width: 12%;">Surgery Description</label>
        <textarea class="form-control form-control-sm TextAreaBorder" id="OTSurgeryRemark" placeholder="Enter Surgery Description" rows="2"></textarea>
    </div>

   <%-- Surgery Booking List --%>
   <label class="fw-bold mb-2">OT Booking Request List </label>
   <div class="stat-wrapper">
       <div id="OTBookingRequestLstTable" class="stat-grid-container"></div>
       <div id="loading-OT-Booking-List" class="loading-screen" style="display: none; opacity: 0;"></div>
   </div>

    <%-- Schemes --%>
    <div class="d-none" id="IPDBKReqDivAllSchemeMainDiv">
        <div class="d-flex justify-content-between mb-3 align-items-start" style="margin-top: 15px;">
            <h4 class="text-custom-black fw-semibold mb-0 me-5" style="font-size: 1.1rem;">Schemes</h4>
            <div class="flex-grow-1 position-relative  ms-5">
                <div class="input-group input-group-sm w-100">
                    <input type="text" id="IPDBKReqSearchSchemeInputSearch" class="form-control" placeholder="Search Scheme (Enter atleast 3 chars)" onclick="IPDBKReqSchemePatList()" oninput="FilterBindedSearchListForIPDBkReqSchemes()">
                </div>
                <div id="IPDBKReq_DivSchemeSearchMainDiv"
                    class="list-group position-absolute w-100"
                    style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                    <div id="IPDBKReqAllSchemesList" class="list-group w-100"></div>
                </div>
            </div>
        </div>
        <div id="IPDBKReq_AllSchemeTable"></div>
    </div>
</div>
