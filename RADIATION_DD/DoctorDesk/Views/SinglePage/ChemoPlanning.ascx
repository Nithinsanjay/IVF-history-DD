<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.ChemoPlanning>" %>
<style>
    .CompleteDate-disabled-textbox {
        background-color: #e9ecef !important;
        cursor: not-allowed;
    }

    .chemo-plan-group {
        margin-bottom: 16px;
        border: 1px solid #b9c3d9;
        border-radius: 6px;
        overflow: hidden;
    }
    .omit-box {
        width: 15px;
        height: 15px;
        background-color: #ff7070;
    }

    .scheme-info {
        font-size: 13px;
    }

    .info-row {
        margin-bottom: 6px;
        clear: both;
    }

    .colon {
        display: inline-block;
        width: 10px;
        vertical-align: top;
    }

    .value {
        display: inline-block;
        width: 65%;
        vertical-align: top;
        word-wrap: break-word;
    }

    .chemo-history-wrapper {
        max-height: calc(100vh - 180px);
        overflow-y: auto;
        padding-right: 6px;
    }

    .chemo-panel {
        border: 1px solid #ccc;
        margin-bottom: 10px;
    }

    .chemo-panel-head {
        background-color: #6c88c4;
        color: #fff;
        padding: 6px 10px;
        font-weight: bold;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
        cursor: pointer;
    }

    .chemo-panel-body {
        background: #fff;
        padding: 10px 15px;
        font-size: 14px;
        display: none;
    }

    .chemo-protocol-table {
        max-height: 260px;
        overflow-y: auto;
        border: 1px solid #ccc;
        margin-top: 8px;
    }

    .row-admitted {
        background-color: #ffe6e6 !important;
    }
    .make-sticky {
        position: sticky;
        top: 0;
        z-index: 1050;
        background: white;
    }
</style>

<%-- Global Declaration --%>
<script type="text/javascript">
    <% var ChemoPlanningSamp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var MedType = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.MedType))%>));
    var PHGenericNAmesLst = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.PHGenericNAmesLst))%>));
    var AdministrationDurations = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.AdministrationDurations))%>));
    var DilutionVolume = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.DilutionVolume))%>));
    var MedicalSetNo = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.MedicalSetNo))%>));
    var DoseCalculation = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.DoseCalculation))%>));
    var DrugType = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.DrugType))%>));
    var GlobalGetDiluentList = JSON.parse(JSON.stringify(<%:Html.Raw(ChemoPlanningSamp.Serialize(Model.DiluentList))%>));
    var ChemoPlangaction = '<%= Model.ChemoPlanTempGaction %>';
    var strCoMorbidities = "";
    var DataMigration = "N";
    var Chemoplantable = [];
    var PerformStatusList = [{ VALUE: "", TEXT: "---Select---" }, { VALUE: "0", TEXT: "0" }, { VALUE: "1", TEXT: "1" }, { VALUE: "2", TEXT: "2" }, { VALUE: "3", TEXT: "3" }, { VALUE: "4", TEXT: "4" }, { VALUE: "5", TEXT: "5" }];
    var totalCycle = "", completeycle = "", pendingCycle = "", currentCycle = "";
    var DataMigrationFlag = false;
    var RMOFlagChemoYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECHEMOPLANYN")%>' == "Y" ? "N" : "Y") : "N";
    var SessionCompChemo = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagChemoYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');
    var GlbProtocolType = "";
    var RList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
    var ProtoName = "";
    var s = "";
    var ProtoColDetails = "";
    var SavedProtoCol = "";
   <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var HrsLst = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(Model.HoursLst))%>));
    var moduleFlag = sessionStorage.getItem('MODULE_FLAG');
    var patCompletedCheck = (moduleFlag === "IPD") || sessionStorage.getItem("PatCompleted")?.toString() != "Y";
    var GlbPlanConsultNo = "";
    var ChemoMedIntakeList = '<%:Html.Raw(Samp.Serialize(ViewBag.RXIntake))%>';
    var EnaDisDILUENT = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ROUTECDFORDILUENT")%>';
    var PrevHist = [];
    var PrevHistFlag = false;
    //Added By Abhishesh || 20260720
    if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CHEMOPLANNINGEFAULTLETTER")%>' == "Y") {
        $("#chkheader").prop("checked", true);
    }
    //End
    var SearchValue = "";
    $(document).ready(function () {
        debugger;
        // if (sessionStorage.getItem("PatCompleted").toString() != "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y") {
        if (patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y") {
            $("#ChkSaveChemoPlan").prop('disabled', false);
            if (IsModifyPlanningEnabled) {
                $("#ChkSaveChemoPlan").prop('checked', ChemoPlanningEditYN == "Y");
            } else {
                $("#ChkSaveChemoPlan").prop('checked', false);
            }
        }
        else $("#ChkSaveChemoPlan").prop('disabled', true);
        EnDisAllChemoField();
        $("#ChemoPlan_txtCompleteCycle").prop('disabled', true);
        $("#ChemoPlan_txtcurrentCycle").prop('disabled', true);

        var prevValues = { ADMNNO: null, ONDAY: null };
        Chemoplantable = new Tabulator("#ChemoPlanning-Chemoplantable", {
            layout: "fitColumns",
            //popupContainer: document.body,   // renders popups outside table
            height: 400,
            dataLoaded: function (data) {
                var table = this;
                var cycle = $("#ChemoPlan_txtcurrentCycle").val().trim() === ""
                    ? $("#ChemoPlan_txtCompleteCycle").val()
                    : $("#ChemoPlan_txtcurrentCycle").val();
                var cycleValue = cycle;
                var rows = table.getRows();
                rows.forEach(function (row) {
                    var rowData = row.getData();
                    var AdmStatusYN = (cycleValue != rowData.CYCLENO)
                        ? ""
                        : rowData.ADMNSTATUS;
                    row.update({
                        CYCLENO: cycleValue,
                        ADMNSTATUS: AdmStatusYN,
                        DOCTCODE: gDoctCode
                    });
                    toggleDiluentFields(row);
                    if (AdmStatusYN.trim() === "Y") {
                        row.getElement().classList.add("row-admitted");
                    } else {
                        row.getElement().classList.remove("row-admitted");
                    }
                });

                if ($('#ddlChemoPlanConclStatus').val() === "01") {
                    rows.forEach(function (row) {
                        var rowData = row.getData();
                        if (rowData.ADMNSTATUS === "Y") {
                        }
                    });
                }

                if (rows.length <= 0) {
                    $('#btnSearch').removeClass('DisableButton');
                }

                if ($("#ChemoPlan_chkStructure").prop("checked")) {
                    ChemoPlan_CalculateDose();
                }
            },
            renderComplete: function () {
                var table = this;
                var protoColType = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                var isCompletePatYN = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagChemoYN == "Y" ? "N" : (sessionStorage.getItem("PatCompleted") || '');
                table.getRows().forEach(function (row) {
                    var rowData = row.getData();
                    updateCheckboxColor(row);
                });
                if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                    toogleButtons(Chemoplantable, "ChemoPlanningTable");
                }
                if (isCompletePatYN !== "Y" && protoColType && protoColType == "U") {
                    $('#RxSearchChemoPlanning').show().prop('disabled', false);
                    $("#AllowChemoFreeText").show();
                }
            },
            cellEditCheck: function (cell) {
                var field = cell.getField();
                var rowData = cell.getRow().getData();
                var row = cell.getRow();
                updateCheckboxColor(row);
                if ((field === "DOSE" || field === "REMARKS") &&
                    rowData.ADMNSTATUS === "Y") {
                    return false;
                }
                return true;
            },
            rowSelected: function (row) {
                var rowData = row.getData();
                updateCheckboxColor(row);
            },
            rowDeselected: function (row) {
                var rowData = row.getData();
                updateCheckboxColor(row);
            },
            cellEdited: function (cell) {
                var rowData = cell.getRow().getData();
                var row = cell.getRow();
                updateCheckboxColor(row);
            },
            groupBy: "ADMNNO",
            groupStartOpen: true,
            groupHeader: function (value, count, data, group) {
                return "Admission No.: " + value + " (" + count + " Medication(s))";
            },
            rowFormatter: function (row) {
                updateRowColor(row);
            },
            columns: [
                {
                    // Abhishesh || 20260911
                    headerSort: false,
                    title: "",
                    field: "act",
                    width: 20,
                    headerWordWrap: true, headerSort: false,
                    frozen: true,
                    editable: function (cell) {
                        return patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y" && $("#ChkSaveChemoPlan").prop("checked") == true;
                    },
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if (!patCompletedCheck && ((typeof SessionCompChemo !== 'undefined' && SessionCompChemo === "Y") || data.ShowDel != true)) {
                            return "";
                        }
                        return '<i class="fa fa-trash text-danger delete-row" title="Delete Medicine"></i>';
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        if ($(e.target).hasClass("delete-row")) {
                            row.delete();
                        }
                    }
                },
                {
                    // Abhishesh || 20260911
                    title: "CIMS",
                    field: "CIMS",
                    width: 45,
                    headerWordWrap: true, headerSort: false,
                    headerSort: false,
                    frozen: true,
                    hozAlign: "center",
                    formatter: function (cell) {
                        return "<i class='fa fa-info-circle' Title='CIMS Information' style='color:#2d70aa;font-size:20px;cursor:pointer'></i>";
                    },
                    cellClick: function (e, cell) {
                        if (!$(e.target).hasClass("fa fa-info-circle")) return;
                        var rowData = cell.getRow().getData();
                        var genericId = rowData.GENERICID;
                        if (genericId) {
                            getDrugInfo(genericId);
                        }
                    }
                },
                {
                    // Abhishesh || 20260911
                    title: "Drug Form",
                    field: "FORMNAME",
                    width: 70,
                    headerWordWrap: true, headerSort: false,
                    editor: "input",
                    frozen: true,
                    editable: function (cell) {
                        return false;
                    }
                },
                {
                    // Abhishesh || 20260911
                    title: "Generic Name",
                    field: "GENERICNM",
                    width: 200,
                    headerWordWrap: true, headerSort: false,
                    editor: "list",
                    editable: false,
                    frozen: true,
                    editorParams: {
                        values: GetPHGenericNameLst(),
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: GetPHGenericNameLst()
                },
                {
                    // Abhishesh || 20260911
                    title: "Dose",
                    field: "DOSE",
                    width: 55,
                    headerWordWrap: true, headerSort: false,
                    editable: function (cell) {
                        var data = cell.getRow().getData();
                        return canEditIfNotAdmitted(cell) && $("#ChkSaveChemoPlan").prop("checked") == true && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    editor: function (cell, onRendered, success, cancel) {
                        var input = document.createElement("input");
                        input.type = "text";
                        input.value = cell.getValue() || "";
                        input.style.width = "100%";
                        input.style.height = "100%";
                        input.addEventListener("input", function () {
                            this.value = this.value.replace(/[^0-9.]/g, '')
                                .replace(/(\..*)\./g, '$1');
                        });
                        input.addEventListener("blur", function () {
                            success(input.value);
                        });
                        input.addEventListener("keydown", function (e) {
                            if (e.key === "Enter") success(input.value);
                            if (e.key === "Escape") cancel();
                        });
                        onRendered(function () {
                            input.focus();
                        });
                        return input;
                    },
                    validator: "numeric"
                },
                <%--{
                    title: "Dose",
                    field: "DOSE",
                    editor: "input",
                    editable: function (cell) {
                        var data = cell.getRow().getData();
                        return canEditIfNotAdmitted(cell) && $("#ChkSaveChemoPlan").prop("checked") == true && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    validator: "numeric",
                    formatter: function (cell) {
                        var v = parseFloat(cell.getValue());
                        if (isNaN(v)) return "";
                        return (v % 1 === 0) ? v.toFixed(0) : v.toFixed(2);
                    }
                },--%>
                {
                    // Abhishesh || 20260911
                    title: "Dose Unit", field: "DOSEUNIT",
                    width: 55,
                    headerWordWrap: true, headerSort: false,
                    editor: "input",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                },
                {
                    // Abhishesh || 20260911
                    title: "Frequency",
                    field: "FREQUENCY",
                    width: 70,
                    headerWordWrap: true, headerSort: false,
                    editor: "input",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    }
                },
<%--                {
                    title: "Frequency",
                    field: "FREQUENCY",
                    editor: "list",
                    width: 100,
                    editorParams: {
                        values: GetIntakeListChemo("N"),
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: false
                    },

                    formatter: "lookup",
                    formatterParams: GetIntakeListChemo("N"),
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    cellEdited: function (cell) {
                        let val = cell.getValue();
                        if (val) {
                            cell.setValue(val.toUpperCase());
                        }
                    }
                },--%>
                {
                    // Abhishesh || 20260911
                    title: "Route",
                    field: "ROUTECD",
                    tooltip: true,
                    width: 100,
                    headerWordWrap: true, headerSort: false,
                    editor: "list",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    mutator: function (value, data) {
                        if (value) return value;
                        const routeList = GetRouteChemoList("N", ("" + data.DRUGFORM).trim());
                        const defaultItem = routeList.find(item => item.DEFAULTYN === "Y");
                        return defaultItem ? defaultItem.Value : "";
                    },
                    editorParams: function (cell) {
                        const rowData = cell.getRow().getData();
                        return {
                            values: GetRouteChemoList("Y", ("" + rowData.DRUGFORM).trim()),
                            autocomplete: true,
                            listOnEmpty: true,
                            allowEmpty: false
                        };
                    },
                    formatter: "lookup",
                    formatterParams: function (cell) {
                        const rowData = cell.getRow().getData();
                        return GetRouteChemoList("Y", ("" + rowData.DRUGFORM).trim());
                    },
                    //Pournima 16th July 2026
                    cellEdited: function (cell) {
                        toggleDiluentFields(cell.getRow());
                    }
                },
                {
                    // Abhishesh || 20260911
                    title: "Calculate On",
                    field: "CALCULATEON",
                    width: 65,
                    headerWordWrap: true, headerSort: false,
                    editor: "list",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    editorParams: {
                        values: GetDoseCalculation(),
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: GetDoseCalculation()
                },
                {
                    // Abhishesh || 20260911
                    title: "Omit",
                    field: "OMITDRUG",
                    width: 45,
                    headerWordWrap: true, headerSort: false,
                    hozAlign: "center",
                    //formatter: "tickCross",
                    //editor: "tickCross",
                    editable: function (cell) {
                        var data = cell.getRow().getData();
                        return canEditIfNotAdmitted(cell) && $("#ChkSaveChemoPlan").prop("checked") == true && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    formatter: function (cell) {
                        var value = cell.getValue();
                        var isChecked = (value === true || value === "Y");
                        var editableFn = cell.getColumn().getDefinition().editable;
                        var isEditable = typeof editableFn === "function" ? editableFn(cell) : true;

                        var input = document.createElement("input");
                        input.type = "checkbox";
                        input.checked = isChecked;
                        input.disabled = !isEditable;
                        input.style.cursor = isEditable ? "pointer" : "not-allowed";

                        input.addEventListener("click", function (e) {
                            e.stopPropagation();
                        });

                        input.addEventListener("change", function () {
                            cell.setValue(this.checked); 
                        });

                        return input;
                    },
                    cellEdited: function (cell) {
                        updateRowColor(cell.getRow());
                    }
                },
                {
                    // Abhishesh || 20260911
                    title: "Medicine Type", field: "MEDTYPE",
                    width: 90,
                    headerWordWrap: true, headerSort: false,
                    editor: "list",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    editorParams: {
                        values: GetMedicalType()
                    },
                    formatter: "lookup",
                    formatterParams: GetMedicalType()
                },
                {
                    // Abhishesh || 20260911
                    title: "Diluent",
                    field: "DILUENT",
                    width: 95,
                    headerWordWrap: true, headerSort: false,
                    formatter: "textarea",
                    editor: drugSearchEditor,
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        //return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && sessionStorage.getItem("PatCompleted").toString() != "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                        // Pournima 16th July 2026
                        var data = cell.getRow().getData();
                        if (("" + EnaDisDILUENT).trim() != "" && ("" + data.ROUTECD).trim() === ("" + EnaDisDILUENT).trim()) {
                            return false;
                        }                        
                        return $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                },
                {
                    // Abhishesh || 20260911
                    title: "Diluent Volume",
                    field: "VOLDILTN",
                    width: 70,
                    headerWordWrap: true, headerSort: false,  
                    editor: "list",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        //return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && sessionStorage.getItem("PatCompleted").toString() != "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                        // Pournima 16th July 2026
                        var data = cell.getRow().getData();
                        if (("" + EnaDisDILUENT).trim() != "" && ("" + data.ROUTECD).trim() === ("" + EnaDisDILUENT).trim()) {
                            return false;
                        }
                        // ***************************
                        return $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    editorParams: {
                        values: GetDilutionVolume()
                    },
                    formatter: "lookup",
                    formatterParams: GetDilutionVolume()
                },
                {
                    // Abhishesh || 20260911
                    title: "Duration",
                    field: "DURATION",
                    width: 90,
                    headerWordWrap: true, headerSort: false,
                    editor: "list",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        //return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && sessionStorage.getItem("PatCompleted").toString() != "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                        // Pournima 16th July 2026
                        var data = cell.getRow().getData();
                        if (("" + EnaDisDILUENT).trim() != "" && ("" + data.ROUTECD).trim() === ("" + EnaDisDILUENT).trim()) {
                            return false;
                        }
                        //************************************* 
                        return $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    editorParams: {
                        values: GetAdministrationDurations()
                    },
                    formatter: "lookup",
                    formatterParams: GetAdministrationDurations()
                },
                {
                    // Abhishesh || 20260911
                    title: "Remarks",
                    field: "REMARKS",
                    width: 130,
                    headerWordWrap: true, headerSort: false,
                    formatter: "textarea",
                    editor: "textarea",
                    editable: function (cell) {
                        var data = cell.getRow().getData();
                        return canEditIfNotAdmitted(cell) && $("#ChkSaveChemoPlan").prop("checked") == true && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                },
                {
                    // Abhishesh || 20260911
                    title: "Med. Set No.",
                    field: "MEDSETNO",
                    editor: "list",
                    width: 80,
                    headerWordWrap: true, headerSort: false,
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    editorParams: {
                        values: GetMedicalSetNo()
                    },
                    formatter: "lookup",
                    formatterParams: GetMedicalSetNo()
                },
                {
                    // Abhishesh || 20260911
                    title: "Administer Seq. No.",
                    field: "ADMINSEQNO",
                    width: 65,
                    headerWordWrap: true, headerSort: false,
                    editor: "list",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                    editorParams: {
                        values: GetMedicalSetNo()
                    },
                    formatter: "lookup",
                    formatterParams: GetMedicalSetNo()
                },
                { title: "Cycle", field: "CYCLENO", width: 45, headerWordWrap: true, headerSort: false, hozAlign: "center" }, // Abhishesh || 20260911
                {
                    // Abhishesh || 20260911
                    title: "Admission No.",
                    field: "ADMNNO",
                    width: 65,
                    headerWordWrap: true, headerSort: false,
                    hozAlign: "center",
                    editor: "list",
                    editorParams: function (cell) {
                        return { values: getAdmissionsNos() };
                    },
                    cellEdited: function (cell) {
                        let selectedValue = cell.getValue();
                        cell.getRow().update({
                            APLYTODAY: selectedValue
                        });
                        cell.getTable().setGroupBy("ADMNNO");
                    },
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                },
                {
                    // Abhishesh || 20260911
                    title: "Apply To Day", field: "APLYTODAY",
                    width: 65,
                    headerWordWrap: true, headerSort: false,
                    editor: "input",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                },
                {
                    title: "On Day", field: "ONDAY", width: 55, headerWordWrap: true, headerSort: false, hozAlign: "center", // Abhishesh || 20260911
                    editor: "input",
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                },
                {
                    // Abhishesh || 20260911
                    title: "Admission Required", field: "ADMNYN",
                    width: 65,
                    headerWordWrap: true, headerSort: false,
                    editor: 'input',
                    editable: function (cell) {
                        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                        var data = cell.getRow().getData();
                        return ProtoColtype == "U" && $("#ChkSaveChemoPlan").prop("checked") == true && canEditIfNotAdmitted(cell) && patCompletedCheck && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagChemoYN != "Y";
                    },
                },
                { title: "Original Dose", field: "ORIGINALDOSE", width: 70, headerWordWrap: true, headerSort: false, hozAlign: "right" }, // Abhishesh || 20260911
                { title: "Generic Code", field: "GENERICID", visible: false },
                {
                    title: "Drug Form Code",
                    field: "DRUGFORM",
                    editor: "input",
                    visible: false,
                    editable: function (cell) {
                        return false;
                    },
                },
                { title: "Diluent Generic Code", field: "DILNTGENCD", visible: false },
                { title: "Admission Status", field: "ADMNSTATUS", visible: false },
                { title: "Doctor Code", field: "DOCTCODE", visible: false }
            ]
        });

        Chemoplantable.on("cellEdited", function (cell) {
            if (cell.getField() === "OMITDRUG") {
                var row = cell.getRow();
                updateCheckboxColor(row);
            }
        });
        Chemoplantable.on('rowAdded', function (cell) {
            if (IS_DISPLAY_CIMS_FUNCTIONLITY == 'Y') {
                toogleButtons(Chemoplantable, "ChemoPlanningTable");
            }
        });

        Chemoplantable.on("rowDeleted", function (row) {
            if (IS_DISPLAY_CIMS_FUNCTIONLITY == 'Y') {
                toogleButtons(Chemoplantable, "ChemoPlanningTable");
            }
        });

        Chemoplantable.on("dataLoaded", function (row) {
            if (IS_DISPLAY_CIMS_FUNCTIONLITY == 'Y') {
                toogleButtons(Chemoplantable, "ChemoPlanningTable");
            }
        });

        document.getElementById("ChemoPlanning-Chemoplantable").style.display = "none";

        $("#ChemoStartDt").datepicker({
            howButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),
        });
        setDefaultChemoStartDate();
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0');
        var yyyy = today.getFullYear();
        var currentDate = yyyy + '-' + mm + '-' + dd;


        $("#ChemoPlan_txtTreatComplete").datepicker({
            howButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),
        });
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0');
        var yyyy = today.getFullYear();
        var currentDate = yyyy + '-' + mm + '-' + dd;
        $("#ChemoPlan_txtRepeatAfter").on('input', function () {
            let value = $(this).val();
            let regex = /^\d+(\d{0,0})?$/;
            if (!regex.test(value)) {
                $(this).val(value.slice(0, -1));
            }
        });


        $("#ddlChemoPlanTName").change(function () {
            GlbProtocolType = "";
            SavedProtoCol = "";
            GetProtocol("");
            GetProtocolTypeSU();
        });
        $("#ddlChemoPlanTCourse, #ddlChemoPlanTreatmentPlan, #ddlChemoPlanTName").change(function () {
            if ($(this).val() !== "" && $(this).val() !== null) {
                $(this).css("border", "");
            }
        });

        $("#ChemoPlan_txtCycles, #ChemoPlan_txtRepeatAfter, #ChemoPlanning_Freetext,#ChemoPlan_txtDurationDays").change(function () {
            if ($(this).val() !== "" && $(this).val() !== null) {
                $(this).css("border", "");
            }
        });

        $("#ChemoPlan_rbtnN").prop("checked", true).trigger('click');

        GetVitalData();
        GetMedOncoData();

        if (ChemoPlangaction == "N") {
            //$("#ChemoPlan_chkStructure").prop("checked", true);
            ChemoPlan_CalculateDose();
        }

        $('#ChemoPlan_chkStructure').click(function () {
            ChemoPlan_CalculateDose();
        });

        $("#ChemoPlan_rbtnN").click(function () {
            $('#ChemoPlan_lblPlanned').hide();
            $('#ddlChemoPlanConclStatus').hide();
            $('#ddlChemoPlanConclStatus').val('').trigger('change');
            $("#ChemoPlan_divCompleteDate").addClass('d-none');
            $('#ChemoPlan_txtTreatComplete').val('');
            $('#ChemoPlan_lblPlannedRemarks').hide();
            $('#ConclusionRemark').hide();
        })

        if ($('#ChemoPlan_rbtnY').is(':checked')) {
            $('#ChemoPlan_lblPlanned').show();
            $('#ChemoPlan_lblPlannedRemarks').show();
            $('#ConclusionRemark').show();
        }
        else {
            $('#ChemoPlan_lblPlanned').hide();
            $('#ddlChemoPlanConclStatus').hide();
            $('#ChemoPlan_lblPlannedRemarks').hide();
            $('#ConclusionRemark').hide();
        }

        $("#ChemoPlan_rbtnY").click(function () {
            if ($('#ChemoPlan_rbtnY').is(':checked')) {
                $('#ChemoPlan_lblPlanned').show();
                $('#ddlChemoPlanConclStatus').show();
                $('#ChemoPlan_lblPlannedRemarks').show();
                $('#ConclusionRemark').show();
            }
            else {
                $('#ChemoPlan_lblPlanned').hide();
                $('#ddlChemoPlanConclStatus').hide();
                $('#ChemoPlan_lblPlannedRemarks').hide();
                $('#ConclusionRemark').hide();
            }
        })

        if ($('#ddlChemoPlanConclStatus').val() == "01") {
            $("#ChemoPlan_divCompleteDate").removeClass('d-none');
            EDisableEventProcess(true);
            EditPreDisableFields(true);
        }
        else {
            $("#ChemoPlan_divCompleteDate").addClass('d-none');
            EditPreDisableFields(false);
        }
        $(document).ready(function () {
            if ($('#ChemoPlan_txtTRANID').val() == "") {
                $('#ChemoPlan_TreatConStatus').attr('style', 'display:none !important');
            }
            else {
                $('#ChemoPlan_TreatConStatus').attr('style', 'display:inline-block !important');
            }

        });
        if (!patCompletedCheck || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagChemoYN == "Y") {
            //$("#sec-ChemoPlanning *").attr("disabled", "disabled");
            $("#sec-ChemoPlanning *").prop("disabled", true);
            $("#ChemoPlanning_PrevHistory").removeAttr("disabled");
            $("#ChemoPlan_btnPrint").removeAttr("disabled");
            $("#Advice_TempFormat *").removeAttr("disabled");
        }
        else {
            $("#sec-advice *").removeAttr("disabled");
            $("#SelectListToPrintSection").addClass("d-none");
            EDisableEventProcess(true);

        }
        // Added by Dhananjay 20260310

        /* Click Event on the Compliant Search List */
        $(document).off("click", ".Rx-row-chemo-planning");
        $(document).on("click", ".Rx-row-chemo-planning", function () {
            var Mtrlcode = $(this).data("code");
            var Mtrlname = $(this).data("name");
            var Gencode = $(this).data("gencode");
            var Genname = $(this).data("genname");
            var FormCode = $(this).data("formcode");
            var Route = $(this).data("route");

            var AdmNo = GetNotAdmStatusAdmissionNo();
            var FilterLst = RList.filter(item => item.FORMCODE == FormCode);
            var FormName = FilterLst.length > 0 ? FilterLst[0].FORMNAME : "";
            Chemoplantable.addRow({
                MEDTYPE: 'P',
                CYCLENO: $('#ChemoPlan_txtcurrentCycle').val(),
                ADMNNO: AdmNo,
                ONDAY: "",
                APLYTODAY: AdmNo,
                MEDSETNO: "",
                GENERICID: Gencode,
                DRUGFORM: FormCode,
                FORMNAME: FormName,
                GENERICNM: Genname,
                DOSE: "",
                CALCULATEON: "",
                ROUTECD: "",
                FREQUENCY: "",
                DILNTGENCD: "",
                DILUENT: "",
                DURATION: "",
                OMITDRUG: "",
                VOLDILTN: "",  // Added by Dhananajay 20260331 
                ADMNYN: "Yes",
                REMARKS: "",
                ORIGINALDOSE: "",
                ADMNSTATUS: "",
                DOCTCODE: gDoctCode,
                isNew: true,
                ShowDel: true
            }).then(function (row) {
                Chemoplantable.showColumn("act");
                row.normalizeHeight();
                $("#RxSearchChemoPlanning").val("");
                $("#RxListMainDivChemoPlanning").hide();
            });

        });

        // on blue
        $('#RxSearchChemoPlanning').on('blur', function () {
            setTimeout(function () {
                if (!$('#RxListMainDivChemoPlanning:hover').length) {
                    $('#RxListMainDivChemoPlanning').hide();
                }
            }, 150);
        });
        if (moduleFlag == "IPD") {
            $("#ChemoPlan_DivChkSavePlan").hide();
            $("#ChkSaveChemoPlan").prop("checked", true);
            $("#ChemoPlan_SaveIPDBtn").show();
            $("#ChemoPlan_btnSaveChemoIPD").show();
            $("#ChemoPlan_btnCloseChemoIPD").show();
        }

        $(document).on("click", ".add-new-option", function () {
            SearchValue = $(this).data("value");
            OpenPopupForNewItem('Chemotherapy Protocol', 'ChemotherapyProtocol');
        });

        $("#ChemoPlan_txtCompleteCycle").on("keydown", function (e) {
            if (e.key === "-" || e.key === "Subtract") {
                e.preventDefault();
            }
        });
        $("#ChemoPlan_txtCycles").on("keydown", function (e) {
            if (e.key === "-" || e.key === "Subtract") {
                e.preventDefault();
            }
        });
        $("#ChemoPlan_txtRepeatAfter").on("keydown", function (e) {
            if (e.key === "-" || e.key === "Subtract") {
                e.preventDefault();
            }
        });
    });

    function EnDisAllChemoField(CheckYN) {
        if ($("#ChkSaveChemoPlan").prop("checked") == true) {
            let isAdmitted = false;
            if (Chemoplantable != undefined && Chemoplantable != null && typeof Chemoplantable.getRows == "function") {
                let rows = Chemoplantable.getRows();
                if ($("#ddlChemoPlanTName").val() == "")
                    isAdmitted = false;
                else if (rows.length === 0) {
                    isAdmitted = false;
                }
                else {
                    isAdmitted = rows.some(row => {
                        let status = row.getData().ADMNSTATUS;

                        status = (status || "")
                            .replace(/\u00a0/g, "")
                            .trim()
                            .toUpperCase();

                        if (status === "") {
                            status = "N";
                        }

                        return status === "Y";
                    });
                }
            }

            if ($("#ChemoPlan_txtTRANID").val() != undefined && $("#ChemoPlan_txtTRANID").val() != "" && $("#ChemoPlan_txtTRANID").val() != null && PrevHistFlag == false) {
                var MRNo = GetSessionMRNO();
                $.ajax({
                    url: '../DoctorDesk/GetchemoHistory',
                    data: { strMrNo: MRNo },
                    type: 'post',
                    async: false,
                    datatype: 'json',
                    success: function (response) {
                        if (response != "") {
                            PrevHist = response;
                        }
                    }
                });
                PrevHistFlag = true;
            }

            if (!isAdmitted && patCompletedCheck) { //priyanka 04/04/2026
                $("#ddlChemoPlanTCourse").prop('disabled', false);
                $("#ddlChemoPlanTreatmentPlan").prop('disabled', false);
                $("#ddlChemoPlanTName").prop('disabled', false);
                $("#ChemoPlan_txtCycles").prop('disabled', false);
                $("#ChemoPlan_txtRepeatAfter").prop('disabled', false);
                $("#ChemoStartDt").prop("disabled", false); //priyanka 17/04/2026
                $("#RxSearchChemoPlanning").attr("disabled", false);
                $("#ChemoProtocolAdd").attr("disabled", false); //Pournima 26th June 2026
            }
            else {
                $("#ChemoStartDt").prop("disabled", true); //priyanka 17/04/2026
                $("#RxSearchChemoPlanning").attr("disabled", true);
            }
            
            let currentTranNo = sessionStorage.getItem('PatTRANNO');
            $("#ChemoPlan_txtCompleteCycle").prop("disabled", true).addClass("disabled-textbox");
            if ($("#ChemoPlan_txtTRANID").val() != "" && $("#ChemoPlan_txtTRANID").val() != null) {
                var Flag = true;
                if (sessionStorage.getItem('MODULE_FLAG') == "OPD") {
                    if (GlbPlanConsultNo == "" && DataMigrationFlag == true) {
                        $("#ChemoPlan_txtCompleteCycle").prop('disabled', false);
                        $("#ChemoPlan_txtCompleteCycle").prop("disabled", false).removeClass("CompleteDate-disabled-textbox");
                        Flag = false;
                    }
                    else if (currentTranNo == GlbPlanConsultNo) {
                        Flag = false;
                        if (DataMigrationFlag) {
                            $("#ChemoPlan_txtCompleteCycle").prop('disabled', false);
                            $("#ChemoPlan_txtCompleteCycle").prop("disabled", false).removeClass("CompleteDate-disabled-textbox");
                        }
                    }
                }
                if (sessionStorage.getItem('MODULE_FLAG') == "IPD") {
                    if (DataMigrationFlag) {
                        Flag = false;
                        $("#ChemoPlan_txtCompleteCycle").prop('disabled', false);
                        $("#ChemoPlan_txtCompleteCycle").prop("disabled", false).removeClass("CompleteDate-disabled-textbox");
                    }
                }
                if (PrevHist && PrevHist.data1 && PrevHist.data1.length > 0 && $("#ChemoPlan_txtTRANID").val() != "") {
                    var FilterData = PrevHist.data1.filter(x => x.PLANID.trim() == $("#ChemoPlan_txtTRANID").val())
                    if (FilterData.length > 0)
                        isAdmitted = true;
                }

                if (Flag || isAdmitted) {
                    $("#ddlChemoPlanTCourse").prop('disabled', true);
                    $("#ddlChemoPlanTreatmentPlan").prop('disabled', true);
                    $("#ddlChemoPlanTName").prop('disabled', true);
                    $("#ChemoPlan_txtCycles").prop('disabled', true);
                    $("#ChemoPlan_txtRepeatAfter").prop('disabled', true);
                    $("#ChemoStartDt").prop("disabled", true);
                    $("#ChemoProtocolAdd").attr("disabled", true);
                    $("#ChemoPlan_Freetext").attr("disabled", true);
                    $("#ChemoPlanning_txtChemoTextArea").attr("disabled", true);
                }
                var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                if (ProtoColtype == "U") {
                    $("#ChemoPlan_Freetext").prop("checked", true);
                    $("#AllowChemoFreeText").show();
                    $("#ChemoPlanning_txtChemoTextArea").show();
                    autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
                    $("#ChemoPlanning_txtChemoTextArea").removeAttr("disabled", true);
                    $("#ChemoPlan_Freetext").prop("disabled", false); 
                    $('#RxSearchChemoPlanning').show().prop('disabled', false);
                }
                else {
                    $("#ChemoPlan_Freetext").prop("checked", false);
                    $("#ChemoPlanning_txtChemoTextArea").val("");
                    $("#AllowChemoFreeText").hide();
                    $("#ChemoPlanning_txtChemoTextArea").hide();
                    autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
                    $("#ChemoPlanning_txtChemoTextArea").attr("disabled", true);
                    $("#ChemoPlan_Freetext").prop("disabled", true);     
                    $('#RxSearchChemoPlanning').hide().prop('disabled', true);
                }
            }
            //if ($("#ChemoPlan_txtTRANID").val() != "" && $("#ChemoPlan_txtTRANID").val() != null) {
            //    $("#ddlChemoPlanTCourse").prop('disabled', true);
            //    $("#ddlChemoPlanTreatmentPlan").prop('disabled', true);
            //    $("#ddlChemoPlanTName").prop('disabled', true);
            //    $("#ChemoPlan_txtCycles").prop('disabled', true);
            //    $("#ChemoPlan_txtRepeatAfter").prop('disabled', true);
            //    $("#ChemoStartDt").prop("disabled", true);
            //    $("#ChemoProtocolAdd").attr("disabled", true);
            //    $("#ChemoPlan_Freetext").attr("disabled", true);
            //    $("#ChemoPlanning_txtChemoTextArea").attr("disabled", true);
            //}
            $("#ChemoPlanning_Freetext").prop("disabled", false);
            $("#ChemoConclusionRow *").removeAttr("disabled", "disabled");
        }
        else {
            if (CheckYN === "Y") {
                var YFunc = "YesReloadChemo()";
                var NFunc = "NoReloadChemo()";
                openPopupDynamic("Confirmation", "Do you want to reset the Chemo Planning ?", [
                           { text: "Yes", class: "btn btn-yes", action: YFunc },
                    { text: "No", class: "btn btn-no", action: NFunc }
                       ]);
            }
            $(".CompleteDisable input, .CompleteDisable select, .CompleteDisable textarea, .CompleteDisable button")
                .prop("disabled", true);
            $(".ChemoConclusionRow input, .ChemoConclusionRow select, .ChemoConclusionRow textarea, .ChemoConclusionRow button")
                .prop("disabled", true);
            $("#ChemoConclusionRow input, #ChemoConclusionRow select, #ChemoConclusionRow textarea, #ChemoConclusionRow button")
                .prop("disabled", true);
            $("#ChemoStartDt").prop("disabled", true); //priyanka 17/04/2026
            $("#RxSearchChemoPlanning").attr("disabled", true);
            $("#ChemoPlanning_Freetext").attr("disabled", true);
        }
    }
    function YesReloadChemo() {
        IsModifyPlanningEnabled = false;
        //startLoading("Loading");
        reloadChemoPlanning();
        //stopLoading();
    }
    function NoReloadChemo() {
        $("#ChkSaveChemoPlan").prop("checked", true);
        closePopup();
    }
    function NewAction() {
        ChemoPlangaction = "N";
        $("#ChemoConclusionRow").hide();
        disabled(1);
        //$("#ChemoPlan_chkStructure").prop("checked", true);
        ChemoPlan_CalculateDose();
        $('#ChemoPlan_btnPrint').hide();
        $('#ChemoPlan_TreatConStatus').hide();
        $('#ChemoPlan_ConStatus').hide();
        $("#ChemoPlan_DivOmitIndicator").addClass("d-none");
        //Chemoplantable.clearData();
        document.getElementById("ChemoPlanning-Chemoplantable").style.display = "none";
        $("#ChemoPlanning_txtChemoTextArea").val("");
        $("#ddlChemoPlanTCourse").val("");
        $("#ddlChemoPlanTreatmentPlan").val("");
        $("#ddlChemoPlanTName").val("");
        $("#ddlChemoPlanTName").val("").trigger('change.select2');
        $("#ChemoPlan_txtCycles").val("");
        $("#ChemoPlan_txtRepeatAfter").val("");
        $("#ChemoPlan_txtCompleteCycle").val(0);
        $('#ChemoPlan_txtcurrentCycle').val(1);
        $("#ChemoPlanning_Freetext").val("");
        $('#ChemoPlan_rbtnN').prop("checked", true);
        $("#ddlChemoPlanConclStatus").val("");
        $("#ChemoStartDt").val("");
        $("#ChemoPlan_txtTRANID").val("");
        document.getElementById('ChemoPlan_txtPlanNo').textContent = "";
        $("#ChemoPlan_PlanningNoDivId").addClass("d-none");
        $('#RxSearchChemoPlanning').hide();
        GetVitalData();
        autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
    }

    function GetNotAdmStatusAdmissionNo() {
        var table = Chemoplantable;
        var rows = table.getRows();
        var AdmNo = "";
        var gridData = Chemoplantable.getData();
        var gridAdmNos = [];
        gridData.forEach(function (item) {
            var admNo = Number(item.ADMNNO);
            if (admNo > 0 && item.ADMNSTATUS != "Y" && AdmNo == "") {
                AdmNo = admNo;
                return AdmNo;
            }
        });
        return AdmNo || 1;
    }

    function canEditIfNotAdmitted(cell) {
        var data = cell.getRow().getData();
        return data.ADMNSTATUS !== "Y";
    }

    var OMIT_EXCLUDE_COLS = {
        CYCLENO: true,
        ADMNNO: true,
        ONDAY: true,
        OMITDRUG: true
    };

    function updateRowColor(row) {
        var data = row.getData();
        var cells = row.getCells();
        var isOmit = (data.OMITDRUG === "Y" || data.OMITDRUG === true);

        for (var i = 0; i < cells.length; i++) {
            var cell = cells[i];
            var field = cell.getColumn().getField();

            if (!OMIT_EXCLUDE_COLS[field]) {
                cell.getElement().style.backgroundColor = isOmit ? "#ffcfcf" : "";
            }
        }
        if (data.ADMNSTATUS === "Y") {
            row.getElement().classList.add("row-admitted");
            Chemoplantable.hideColumn('act');
        }

    }

    function updateCheckboxColor(row) {
        var rowData = row.getData();
        var excludeColumns = ['CYCLENO', 'ADMNNO', 'ONDAY'];
        var chkCell = row.getCell("OMITDRUG");
        if (!chkCell) return;
        var isChecked = chkCell.getValue();
        var cells = row.getCells();
        for (var i = 0; i < cells.length; i++) {
            var cell = cells[i];
            var field = cell.getField();
            if (field !== "OMITDRUG" && excludeColumns.indexOf(field) === -1) {
                cell.getElement().style.backgroundColor = isChecked ? "#ffcfcf" : "";
            }
        }
    }

    function InfoBtnFormatter(cell, formatterParams, onRendered) {
        const rowData = cell.getData();
        const materialCode = rowData.GENERICID;
        const icon = document.createElement("span");
        icon.className = "fa fa-info-circle";
        icon.style.cursor = "pointer";
        icon.style.color = "#2d70aa";
        icon.title = "View Info";
        return icon;
    }

    function GetDrugForm() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(DrugType, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }

    function GetMedicalType() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(MedType, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }
    // Added by Dhananjay 
    function getAdmissionsNos() {
        //var tableData = [];
        //$.ajax({
        //    type: "POST",
        //    url: "../DoctorDesk/GetChemoMedicationMasterList?strProtocol=" + $('#ddlChemoPlanTName').val() + "&strType=D",
        //    datatype: 'json',
        //    async: false,
        //    success: function (data) {
        //        var masterData = JSON.parse(data);
        //        tableData = masterData;
        //        EnDisAllChemoField();
        //        //end
        //    }
        //});
        //var existingNos = [...new Set(tableData.map(o => Number(o.ADMNNO) || 0))];
        //var AdmissionNoList = [];
        //existingNos.forEach(no => {
        //    if (no > 0 && !AdmissionNoList.includes(no)) {
        //        AdmissionNoList.push(no);
        //    }
        //});
        //var options = {};
        //AdmissionNoList.sort((a, b) => a - b).forEach(no => {
        //    if (no > 0) options[no] = "Admission " + no;
        //});
        //return options;
        var selected_val = $('#ddlChemoPlanTName').val();
        var TotalAdmissionNo = 1;
        if (selected_val) {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetProtocol",
                dataType: "json",
                async: false,
                data: { id: selected_val },
                success: function (data) {
                    if (data && data.length > 4) {
                        TotalAdmissionNo = parseInt(data[4], 10) || 1;
                    }

                    EnDisAllChemoField();
                }
            });
        }
        var options = {};
        for (var i = 1; i <= TotalAdmissionNo; i++) {
            options[i] = "Admission " + i;
        }
        return options;
    }

    function GetDoseCalculation() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(DoseCalculation, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }

    function GetRouteList() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(RouteList, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }

    function GetRouteChemoList(TabulatorYN, DrugFormCode) {
        var s;
        var FilterRouteList = RList.filter(item => item.FORMCODE == DrugFormCode && item.Value != "");
        s = TabulatorYN == "Y" ? ConvertArryListToTabulatorFormat(FilterRouteList, "Text", "Value") : FilterRouteList;
        return s;
    }

    function GetDilutionVolume() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(DilutionVolume, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }

    function GetMedicalSetNo() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(MedicalSetNo, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }

    function GetAdministrationDurations() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(AdministrationDurations, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }

    function GetPHGenericNameLst() {
        var dropdownOptions = { "": "----Select-----" };
        $.each(PHGenericNAmesLst, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });
        return dropdownOptions;
    }

    function setDefaultChemoStartDate() {
        var now = new Date();
        var day = ("0" + now.getDate()).slice(-2);
        var month = ("0" + (now.getMonth() + 1)).slice(-2);
        //var today = now.getFullYear() + "-" + (month) + "-" + (day);
        var today = (day) + "/" + (month) + "/" + now.getFullYear();
        $("#ChemoStartDt").val(today);
    }
    function EDisableEventProcess(isDisable) {
        $('#ddlChemoPlanTCourse').prop('disabled', isDisable);
        $('#ddlChemoPlanTreatmentPlan').prop('disabled', isDisable);
        $('#ChemoPlan_txtRepeatAfter').prop('disabled', isDisable);
        $('#ChemoPlan_txtCycles').prop('disabled', isDisable);
        //$('#ChemoPlan_txtDurationDays').prop('disabled', isDisable);
        $('#ddlChemoPlanTName').prop('disabled', isDisable);
        $('#ChemoPlan_chkStructure').prop('disabled', isDisable);
        $('#ChemoPlanning_Freetext').prop('disabled', isDisable);
        $('#ChemoPlan_rbtnY').prop('disabled', isDisable);
        $('#ChemoPlan_rbtnN').prop('disabled', isDisable);
        $('#txtChemoStart').prop('disabled', isDisable);
        $('#ddlChemoPlanConclStatus').prop('disabled', isDisable);
        $('#ChemoPlan_txtTreatComplete').prop('disabled', isDisable);
        // Set Edit Flag 
        $('#isEditYN').val('N');
        if ($('#isEditYN').val() == 'N' && ChemoPlangaction == 'E') {

        }
        let totalCompletedCycle = Number($('#ChemoPlan_txtCompleteCycle').val())
        let totalNoCycle = Number($('#ChemoPlan_txtCycles').val())
        if (totalCompletedCycle == totalNoCycle) {
            NewAction();
        } else {
            document.getElementById("ChemoConclusionRow").style.display = "flex";
            //$(".CompleteDisable :input").prop("disabled", true);
            if (DataMigrationFlag)
                $('#ChemoStartDt').prop("disabled", false);
        }

        document.getElementById("ChemoPlanning-Chemoplantable").style.display = "block";
        EnDisAllChemoField();
    }

    function EditPreDisableFields(isDisable) {
        if (ChemoPlangaction === "E") {
            // ----- COLUMN HANDLING -----
            let colModel = Chemoplantable.getColumns();
            // ----- FORM ELEMENTS -----
            if ($('#ddlChemoPlanConclStatus').val() !== "") {
                $('#ChemoPlan_rbtnY').prop('disabled', isDisable);
                $('#ChemoPlan_rbtnN').prop('disabled', isDisable);
            } else {
                $('#ChemoPlan_rbtnY').prop('disabled', !isDisable);
                $('#ChemoPlan_rbtnN').prop('disabled', !isDisable);
                $('#ddlChemoPlanConclStatus').prop('disabled', !isDisable);
                $('#ChemoPlan_txtTreatComplete').prop('disabled', !isDisable);
            }
        }
        EnDisAllChemoField();
    }


    //Dose Calculation
    function ChemoPlan_CalculateDose() {
        var table = Chemoplantable; // Tabulator instance
        var weight = parseFloat($('#ChemoPlan_txtWeight').val()) || 0;
        var bsa = parseFloat($('#ChemoPlan_txtBSA').val()) || 0;

        var rows = table.getRows(); // get all rows instead of getDataIDs

        if ($("#ChemoPlan_chkStructure").prop("checked")) {
            rows.forEach(function (row) {
                var rowData = row.getData();

                // store ORIGINALDOSE if not already present
                if (!rowData.ORIGINALDOSE || rowData.ORIGINALDOSE === "") {
                    row.update({ ORIGINALDOSE: rowData.DOSE });
                }

                var oldDose = parseFloat(rowData.ORIGINALDOSE || rowData.DOSE) || 0;
                var newDose = oldDose;

                if (rowData.ADMNSTATUS !== "Y") {
                    if (rowData.CALCULATEON === "W") {
                        newDose = weight * oldDose;
                    } else if (rowData.CALCULATEON === "B") {
                        newDose = bsa * oldDose;
                    }
                    row.update({ DOSE: parseFloat(newDose) });
                }
            });
        } else {
            rows.forEach(function (row) {
                var rowData = row.getData();
                if (rowData.ORIGINALDOSE && rowData.ORIGINALDOSE !== "") {
                    row.update({ DOSE: rowData.ORIGINALDOSE });
                }
            });
        }
    }

    //Get Vitals Data
    function GetVitalData() {
        var moduleFlag = sessionStorage.getItem('MODULE_FLAG');
        if (moduleFlag == "OPD") {
            let tranNo = sessionStorage.getItem('PatTRANNO');
            let mrno = sessionStorage.getItem('PatMRNO');
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/SetDataForVitals',
                datatype: 'json',
                async: false,
                data: { strTranNo: tranNo, Type: "V", strMRNo: mrno },
                success: function (response) {
                    if (response != "") {
                        if (response.Weight > 0) {
                            $("#ChemoPlan_txtWeight").val(response.Weight);
                        }
                        else {
                            $("#ChemoPlan_txtWeight").val('0');
                        }
                        if (response.HEIGHT > 0) {
                            $("#ChemoPlan_txtHeight").val(response.HEIGHT);
                        }
                        else {
                            $("#ChemoPlan_txtHeight").val('0');
                        }
                        $("#ChemoPlan_txtBSA").val(response.BSA);
                    }
                    EnDisAllChemoField();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                },
                complete: function () {
                }
            });
        }
        else {
            var IpNo = sessionStorage.getItem('IPPatIPNO');
            $.ajax({
                type: 'post',
                datatype: 'json',
                async: true,
                url: '../SinglePage/GetPatientVitalInfo',
                data: { strIpNo: IpNo },
                success: function (data) {
                    if (data != "") {
                        SetDataForVitals(data);
                        $("#ChemoPlan_txtWeight").val(data["Weight"]);
                        $("#ChemoPlan_txtHeight").val(data["HEIGHT"]);
                        $("#ChemoPlan_txtBSA").val(data["BSA"]);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }

    //Get Medication data
    function GetMedOncoData() {
        InitChemoNameSelect2(); // Abhishesh || 20260713
        let TranNo = sessionStorage.getItem('PatTRANNO');
        //let ConsultNo = sessionStorage.getItem('ChemoConsultNo');
        let ConsultNo = "";
        let mrno = "";
        if (moduleFlag == "IPD") {
            mrno = sessionStorage.getItem('IPPatMRNO');
        }
        else {
            mrno = sessionStorage.getItem('PatMRNO');
        }
        if (!mrno) {
            ToastMsg("Please Select Patient.", "info");
            return false;
        }
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../DoctorDesk/GetMedOncoData',
            async: false,
            data: { strConsultNo: ConsultNo, MrNo: mrno, TranNo: TranNo },
            success: function (response) {
                var TempSchemeCode = "";
                var result = !response.data || response.data.length === 0 ? [] : response.data;
                var chemoplanmigrationdata = !response.migrationData || response.migrationData.length === 0 ? [] : response.migrationData;
                if (Array.isArray(result) && result.length > 0) {
                    if (result[0].PLANCOMPLETE != "Y") {
                        let chemoCourse = result[0].CHEMOCOURSE;
                        let treatmentPlan = result[0].TREATMENTPLAN;
                        let previousTreatment = result[0].PREVTREATMENT;
                        let chemoName = result[0].CHEMOTHERAPYNM;
                        let protocol = result[0].PROTOCOL;
                        let performanceStatus = result[0].PERFORMANCESTATUS;
                        let hpreport = result[0].HPREPORT;
                        let patcat = result[0].PATCAT;
                        let scheme = result[0].SCHEME;
                        let totalNocycle = result[0].TOTALCYCLE;
                        let repeateAfterCyle = result[0].REPEATAFTER;
                        let modification = result[0].MODIFICATION;
                        let morbidies = result[0].CLINICALFIND;
                        let hpreportremark = result[0].HPREPORTREMARK;
                        let tstage = result[0].T;
                        let nstage = result[0].N;
                        let mstage = result[0].M;
                        let weight = result[0].WEIGHT;
                        let height = result[0].HEIGHT;
                        let bsa = result[0].BSA;
                        let TranID = result[0].TRANID;
                        let ProtoColtype = result[0].PROTOCOLTYPE;
                        let Duration = result[0].DURATION;
                        strCoMorbidities = result[0].CLINICALFIND;
                        DataMigration = result[0].DATAMIGRATION
                        $("#ddlChemoPlanTCourse").val(chemoCourse);
                        $("#ddlChemoPlanTreatmentPlan").val(treatmentPlan);
                        $("#ChemoPlan_txtCycles").val(totalNocycle);
                        getCycleCount();
                        $("#ChemoPlan_txtRepeatAfter").val(repeateAfterCyle);
                        $("#ChemoPlanning_Freetext").val(modification);
                        autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_Freetext'));
                        $("#ChemoPlan_txtTstage").val(tstage);
                        $("#ChemoPlan_txtNstage").val(nstage);
                        $("#ChemoPlan_txtMstage").val(mstage);
                        $("#ChemoPlan_txtWeight").val(weight);
                        $("#ChemoPlan_txtHeight").val(height);
                        $("#ChemoPlan_txtBSA").val(bsa);
                        //$("#ddlChemoPlanTName").val(chemoName);
                        $("#ddlChemoPlanTName").val(chemoName).trigger('change.select2'); // Abhishesh || 20260713
                        $("#ChemoPlan_txtDurationDays").val(Duration);
                        $("#ChemoPlan_txtTRANID").val(TranID);
                        /*$("#ChemoPlan_txtPlanNo").val(TranID);*/
                        $("#ChemoPlan_txtPlanNo").text(TranID); //priyanka 08/03/2026
                        $("#ChemoPlan_PlanningNoDivId").removeClass("d-none");
                        //priyanka 02/03/2026
                        completeycle = result[0].COMPLETEDCYCLES == "" ? "0" : result[0].COMPLETEDCYCLES;
                        currentCycle = Number(completeycle) + 1; //priyanka 23/03/2026
                        pendingCycle = Number(totalNocycle) - Number(currentCycle);
                        $('#ChemoPlan_txtCompleteCycle').val(completeycle);
                        SavedProtoCol = protocol;
                        if (MedicalRights === true && TranID != null && TranID != "") { //priyanka 02/04/2026
                            $("#OPD_ChemoPlanning").removeClass("d-none");
                            $("#sec-ChemoPlanning").removeClass("d-none");
                        }
                        //end
                        if (ProtoColtype == "U") {
                            if (protocol != null && protocol != "") {
                                $("#AllowChemoFreeText").show();
                                $("#ChemoPlan_Freetext").prop("checked", true);
                                document.getElementById("ChemoPlanning_txtChemoTextArea").style.display = "block";
                                $("#ChemoPlanning_txtChemoTextArea").val(protocol);
                                autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
                            }
                            $('#ChemoPlan_chkStructure').prop("disabled", true);
                            $("#ChemoPlan_DivOmitIndicator").addClass("d-none");

                            //if (result[0].DATAMIGRATION == "Y" && chemoplanmigrationdata.length === 0) {
                            //    GetProtocol("Y");
                            //    totalCycle = totalNocycle;
                            //    $('#ChemoPlan_txtCompleteCycle').val(completeycle);
                            //    $('#ChemoPlan_txtcurrentCycle').val(currentCycle);
                            //    $("#RxSearchChemoPlanning").attr("disabled", false);
                            //    $("#ChemoPlan_DivOmitIndicator").removeClass("d-none");
                            //}
                            if (result[0].DATAMIGRATION == "Y") {
                                chemoplanmigrationdata = chemoplanmigrationdata.filter(x => x.TRANNO == result[0].TRANID);
                                if (chemoplanmigrationdata.length === 0) {
                                    GetProtocol("Y");
                                    totalCycle = totalNocycle;
                                    $('#ChemoPlan_txtCompleteCycle').val(completeycle);
                                    $('#ChemoPlan_txtcurrentCycle').val(currentCycle);
                                    EditPreDisableFields(false);
                                    $("#ChemoPlan_DivOmitIndicator").removeClass("d-none");
                                    $("#RxSearchChemoPlanning").attr("disabled", false);
                                }
                                else {
                                    //currentCycle = chemoplanmigrationdata[chemoplanmigrationdata.length - 1].CYCLENO;
                                    //chemoplanmigrationdata = chemoplanmigrationdata.filter(x => x.CYCLENO == chemoplanmigrationdata[chemoplanmigrationdata.length - 1].CYCLENO && x.TRANNO == result[0].TRANID);
                                    const maxCycleNo = chemoplanmigrationdata.reduce((max, item) => {
                                        const current = parseInt(item.CYCLENO, 10);
                                        return current > max ? current : max;
                                    }, -Infinity);
                                    chemoplanmigrationdata = chemoplanmigrationdata.filter(x => x.CYCLENO == maxCycleNo);
                                    var AdmFlag = chemoplanmigrationdata.filter(x => x.ADMNSTATUS == "");
                                    currentCycle = AdmFlag.length > 0 ? maxCycleNo : (Number(maxCycleNo) + 1);
                                    pendingCycle = Number(totalNocycle) - Number(currentCycle);
                                    completeycle = Number(currentCycle) - 1 < 0 ? 0 : Number(currentCycle) - 1;
                                    //chemoplanmigrationdata.forEach(x => x.CYCLENO = currentCycle);
                                    chemoplanmigrationdata.forEach(x => {
                                        x.CYCLENO = currentCycle;
                                        x.ADMNSTATUS = AdmFlag.length > 0 ? x.ADMNSTATUS : " ";
                                    });
                                    $('#ChemoPlan_txtCompleteCycle').val(completeycle);
                                    //GetProtocol("Y");
                                    totalCycle = totalNocycle;
                                    $('#ChemoPlan_txtcurrentCycle').val(currentCycle);
                                    EditPreDisableFields(false);
                                    $("#ChemoPlan_DivOmitIndicator").removeClass("d-none");
                                    $("#RxSearchChemoPlanning").attr("disabled", false);
                                }
                            }
                        }
                        else if (ProtoColtype == "S") {
                            $("#AllowChemoFreeText").hide();
                            document.getElementById("ChemoPlanning_txtChemoTextArea").style.display = "none";
                            //if (protocol != null && protocol != "") {
                            //    $("#AllowChemoFreeText").show();
                            //    $("#ChemoPlan_Freetext").prop("checked", true);
                            //    document.getElementById("ChemoPlanning_txtChemoTextArea").style.display = "none";
                            //    $("#ChemoPlanning_txtChemoTextArea").val(protocol);
                            //    autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
                            //} else {
                            //    $("#AllowChemoFreeText").hide();
                            //    document.getElementById("ChemoPlanning_txtChemoTextArea").style.display = "none";
                            //}
                            if (result[0].DATAMIGRATION == "Y") {
                                chemoplanmigrationdata = chemoplanmigrationdata.filter(x => x.TRANNO == result[0].TRANID);
                                if (chemoplanmigrationdata.length === 0) {
                                    GetProtocol("Y");
                                    totalCycle = totalNocycle;
                                    $('#ChemoPlan_txtCompleteCycle').val(completeycle);
                                    $('#ChemoPlan_txtcurrentCycle').val(currentCycle);
                                    EditPreDisableFields(false);
                                    $("#ChemoPlan_DivOmitIndicator").removeClass("d-none");
                                    $("#RxSearchChemoPlanning").attr("disabled", false);
                                }
                                else {
                                    //currentCycle = chemoplanmigrationdata[chemoplanmigrationdata.length - 1].CYCLENO;
                                    //chemoplanmigrationdata = chemoplanmigrationdata.filter(x => x.CYCLENO == chemoplanmigrationdata[chemoplanmigrationdata.length - 1].CYCLENO && x.TRANNO == result[0].TRANID);
                                    const maxCycleNo = chemoplanmigrationdata.reduce((max, item) => {
                                        const current = parseInt(item.CYCLENO, 10);
                                        return current > max ? current : max;
                                    }, -Infinity);
                                    chemoplanmigrationdata = chemoplanmigrationdata.filter(x => x.CYCLENO == maxCycleNo);
                                    var AdmFlag = chemoplanmigrationdata.filter(x => x.ADMNSTATUS == "");
                                    currentCycle = AdmFlag.length > 0 ? maxCycleNo : (Number(maxCycleNo) + 1);
                                    pendingCycle = Number(totalNocycle) - Number(currentCycle);
                                    completeycle = Number(currentCycle) - 1 < 0 ? 0 : Number(currentCycle) - 1;
                                    //chemoplanmigrationdata.forEach(x => x.CYCLENO = currentCycle);
                                    chemoplanmigrationdata.forEach(x => {
                                        x.CYCLENO = currentCycle;
                                        x.ADMNSTATUS = AdmFlag.length > 0 ? x.ADMNSTATUS : " ";
                                    });
                                    $('#ChemoPlan_txtCompleteCycle').val(completeycle);
                                    //GetProtocol("Y");
                                    totalCycle = totalNocycle;
                                    $('#ChemoPlan_txtcurrentCycle').val(currentCycle);
                                    EditPreDisableFields(false);
                                    $("#ChemoPlan_DivOmitIndicator").removeClass("d-none");
                                    $("#RxSearchChemoPlanning").attr("disabled", false);
                                }
                            }
                        }
                        if (result[0].PLANCOMPLETE == "Y") {
                            $("#ChemoPlan_rbtnY").prop("checked", true).trigger('click');
                            $("#ddlChemoPlanConclStatus").val(result[0].COMPLETESTATUS).trigger('change');
                            $('#ChemoPlan_txtTreatComplete').val(result[0].COMPLETEDATE);
                            $('#ConclusionRemark').val(result[0].CONCLUSIONREMARK);
                        }
                        else if (result[0].PLANCOMPLETE == "N") {
                            $("#ChemoPlan_rbtnN").prop("checked", true).trigger('click');
                        }
                        $('#ChemoStartDt').val(result[0].ADVSTARTDATE);
                        if (("" + result[0].SCHEMECODES).toString().trim() != "" && IsModifyPlanningEnabled) { //priyanka 03/04/2026
                            TempSchemeCode = ("" + result[0].SCHEMECODES).toString().trim();
                        }
                        ChemoPlangaction = "E";
                        $("#ChemoPlan_btnPrint").show();
                        //$(".CompleteDisable :input").prop("disabled", true);
                        if (DataMigrationFlag)
                            $('#ChemoStartDt').prop("disabled", false);
                        // Added by Dhananjay 20260317
                        if (result[0].DATAMIGRATION != "Y" && chemoplanmigrationdata.length === 0) {
                            GetchemoSMedication();
                        }
                        if (result[0].DATAMIGRATION == "Y" && chemoplanmigrationdata.length === 0) {
                            $('#ChemoStartDt').prop("disabled", false);
                            DataMigrationFlag = true;
                            $("#ChemoPlan_btnPrint").hide();
                        }
                        else {
                            DataMigrationFlag = false;
                        }
                        //PRIYANKA 12/05/2026
                        if (result[0].DATAMIGRATION == "Y" && chemoplanmigrationdata.length > 0) {
                            document.getElementById("ChemoPlanning-Chemoplantable").style.display = "block";
                            $("#ChemoPlanning-Chemoplantable").removeClass("d-none");
                            Chemoplantable.on("tableBuilt", function () {
                                chemoplanmigrationdata.forEach(function (item) {
                                    item.DOCTCODE = gDoctCode;
                                });
                                Chemoplantable.replaceData(chemoplanmigrationdata);
                                toogleButtons(Chemoplantable, "ChemoPlanningTable");
                            });
                        }
                        $("#PlanningType").text("Modify Planning"); //Pournima 16th june 2026
                        GlbPlanConsultNo = result[0].CONSULTNO;
                    }
                    else {
                        $("#ChemoPlan_btnPrint").hide();
                        getCycleCount();
                        $("#PlanningType").text("Enable Planning"); //Pournima 16th june 2026
                    }
                }
                else {
                    $("#ChemoPlan_btnPrint").hide();
                    getCycleCount();
                    $("#PlanningType").text("Enable Planning"); //Pournima 16th june 2026
                }
                if (MedicalRights === true) {
                    $("#OPD_ChemoPlanning").removeClass("d-none");
                    $("#sec-ChemoPlanning").removeClass("d-none");
                }
                EnDisAllChemoField();
                //Before Change Go through File Chemoplanning and SinglepageOPD
                //if (IsModifyPlanningEnabled) {
                //    IsChemoBind = true;
                //    MedSchemeCodesFrom = "A";// => Advice
                //    if (TempSchemeCode != "") {
                //        MedSchemeCodesFrom = "C"; // => Chemo
                //        MedSchemeCodes = TempSchemeCode;
                //    }
                //    if (IsAdviceBind == true && IsChemoBind == true && MedicalRights) {
                //        LoadMedicalScheme();
                //    }
                //}
                IsChemoBind = true;
                MedSchemeCodesFrom = "A";// => Advice
                if (TempSchemeCode != "") {
                    MedSchemeCodesFrom = "C"; // => Chemo
                    MedSchemeCodes = TempSchemeCode;
                }
                if (IsAdviceBind == true && IsChemoBind == true && MedicalRights && IsModifyPlanningEnabled) {
                    LoadMedicalScheme();
                }
                $("#ddlChemoPlanTName").select2({
                    width: 'auto', // or 'resolve' / '100%'
                    language: {
                        noResults: function () {
                            var searchText = $(".select2-search__field").val();
                            return '<div class="add-new-option" data-value="' + searchText + '">Add New "' + searchText + '"</div>';
                        }
                    },
                    escapeMarkup: function (markup) {
                        return markup;
                    }
                });
                stopLoading("loading-ChemoPlan-Section");
                //end
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading("loading-ChemoPlan-Section");
            },
            complete: function () {
            }
        });
    }

    function hasAnyAdmittedRow() {
        if (Chemoplantable != undefined && Chemoplantable != null && typeof Chemoplantable.getRows == "function") {
            let rows = Chemoplantable.getRows();
            if ($("#ddlChemoPlanTName").val() == null || $("#ddlChemoPlanTName").val() == "")
                return false;
            if (rows.length === 0) {
                return true;
            }

            return rows.some(row => {
                let status = row.getData().ADMNSTATUS;

                status = (status || "")
                    .replace(/\u00a0/g, "")
                    .trim()
                    .toUpperCase();

                if (status === "") status = "N";

                return status === "Y";
            });
        }
        return false;
    }
    function GetchemoSMedication() {
        var DataToSend = {
            //MRNo: sessionStorage.getItem("PatMRNO"),
            MRNo: moduleFlag === "IPD"
                ? sessionStorage.getItem("IPPatMRNO")
                : sessionStorage.getItem("PatMRNO"),
            PlanNo: $("#ChemoPlan_txtTRANID").val(),
            CycleNo: ($('#ChemoPlan_txtCompleteCycle').val().trim() === '' ?
                $('#ChemoPlan_txtcurrentCycle').val() :
                $('#ChemoPlan_txtCompleteCycle').val())
        };
        $.ajax({
            url: '../DoctorDesk/GetchemoSMedication',
            type: 'POST',
            async: true,
            data: DataToSend,
            success: function (response) {
                var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                var isCompletePatYN = sessionStorage.getItem('MODULE_FLAG') == "IPD" ? "N" : sessionStorage.getItem('PatCompleted');
                if (typeof Chemoplantable === "undefined" || Chemoplantable === null) {
                    if (isCompletePatYN !== "Y" && ProtoColtype && ProtoColtype == "U") {
                        EnableDisableSearchRxForChemo(true);
                        $("#AllowChemoFreeText").show();
                    }
                    return;
                }
                if (response && response.data && response.data.length > 0) {
                    //document.getElementById("ChemoPlanning_txtChemoTextArea").style.display = "none";
                    getCycleCount();
                    document.getElementById("ChemoPlanning-Chemoplantable").style.display = "block";
                    $("#ChemoPlanning-Chemoplantable").removeClass("d-none");
                    Chemoplantable.replaceData(response.data);
                    Chemoplantable.getRows().forEach(function (row) {
                        const data = row.getData();
                        if (data.OMITDRUG !== "Y") {
                            row.update({ OMITDRUG: false });
                        } else {
                            row.update({ OMITDRUG: true });
                        }
                        if (isCompletePatYN !== "Y" && ProtoColtype && ProtoColtype == "U") {
                            row.update({ isNew: true });
                            $("#AllowChemoFreeText").show();
                        }
                    });
                    if (Chemoplantable.options.dataLoaded) {
                        Chemoplantable.options.dataLoaded.call(Chemoplantable, Chemoplantable.getData());
                    }
                    if (Chemoplantable.options.renderComplete) {
                        Chemoplantable.options.renderComplete.call(Chemoplantable);
                    }
                    Chemoplantable.options.renderComplete = function () {
                        var table = this;
                        table.getRows().forEach(function (row) {
                            updateRowColor(row);
                        });
                    };
                    toogleButtons(Chemoplantable, "ChemoPlanningTable");
                }
                //else {
                //    Chemoplantable.clearData();
                //    //document.getElementById("ChemoPlanning-Chemoplantable").style.display = "none";
                //    //$("#ChemoPlan_btnPrint").hide();
                //}
                if ($("#ChemoPlan_txtTRANID").val() != "" && $("#ChemoPlan_txtTRANID").val() != null) {
                    $("#ChemoPlan_btnPrint").show();
                } else {
                    $("#ChemoPlan_btnPrint").hide();
                }
                //$(".CompleteDisable :input").prop("disabled", true);
                if (DataMigrationFlag)
                    $('#ChemoStartDt').prop("disabled", false);
                if (isCompletePatYN !== "Y" && ProtoColtype && ProtoColtype == "U") {
                    EnableDisableSearchRxForChemo(true);
                    $("#AllowChemoFreeText").show();
                } else {
                    EnableDisableSearchRxForChemo(false);
                    $("#AllowChemoFreeText").hide();
                }
                EnDisAllChemoField();
            },
            error: function (xhr, status, err) {
            }
        });
    }

    function getCycleCount() {
        var DataToSend = {
            MRNo: GetSessionMRNO(),//sessionStorage.getItem('PatMRNO'),
            StrProtocole: $('#ddlChemoPlanTName').find(":selected").attr('value')
        };
        $.ajax({
            url: '../DoctorDesk/GetCycleCount',
            data: DataToSend,
            type: 'POST',
            async: false,
            success: function (response) {
                response = response == "[]" || response == "" ? [] : response.data;
                if (Array.isArray(response) && response.length > 0) {
                    currentCycle = $('#ChemoPlan_txtCycles').val() == "" ? "0" : response[0].CYCLENO;
                    totalCycle = $('#ChemoPlan_txtCycles').val() == "" ? "0" : $('#ChemoPlan_txtCycles').val();
                    $('#ChemoPlan_txtCompleteCycle').val(currentCycle);
                    pendingCycle = parseInt(totalCycle) - (parseInt(currentCycle));
                    //$('#ChemoPlan_txtcurrentCycle').val(pendingCycle == 0 ? '' : parseInt(currentCycle) + 1);
                    //disabled(currentCycle);
                    //let isCycleIncrement = pendingCycle == 0 ? 'N' : 'Y';
                    //if (isCycleIncrement == 'Y') {
                    //    EnableDisableSearchRxForChemo(true);
                    //}
                    if (pendingCycle == 0) {
                        NewAction();
                        disabled(1);
                    }
                    else {
                        $('#ChemoPlan_txtcurrentCycle').val(pendingCycle == 0 ? '' : parseInt(currentCycle) + 1);
                        disabled(currentCycle);
                    }
                } else {
                    $('#ChemoPlan_txtcurrentCycle').val(1);
                    $('#ChemoPlan_txtCompleteCycle').val(0);
                    disabled(1);
                }
                EnDisAllChemoField();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
    }

    function disabled(CycleNo) {
        if (parseInt(CycleNo) > 1) {
            $('#ddlChemoPlanTCourse, #ddlChemoPlanTreatmentPlan, #ddlChemoPlanTName', '#ChemoPlan_txtCycles', '#ChemoPlan_txtRepeatAfter').attr("disabled", "disabled");
        }
    }

    function GetProtocolTypeSU() {
        let protoColTyp = GlbProtocolType;
        var selected_val = $('#ddlChemoPlanTName').find(":selected").attr('value');

        if (selected_val != "" && GlbProtocolType == "") {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetProtocol",
                datatype: 'json',
                async: false,
                data: { id: selected_val },
                success: function (data) {
                    if (data.length > 0) {
                        ProtoColDetails = data[0];
                        GlbProtocolType = data[3];
                        protoColTyp = data[3];
                    }
                    EnDisAllChemoField();
                    GetProtoType(ProtoColDetails);
                },
                error: function (xhr, status, error) {

                },
                complete: function () {

                }
            });
        }
        else if (GlbProtocolType == "U") {
            $("#ChemoPlan_Freetext").prop("checked", true);
            $("#ChemoPlanning_txtChemoTextArea").val(ProtoColDetails);
            $("#AllowChemoFreeText").show();
            $("#ChemoPlanning_txtChemoTextArea").show();
            autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
            $("#ChemoPlan_Freetext").prop("disabled", false);
            $("#ChemoPlanning_txtChemoTextArea").prop("disabled", false);
            EnDisAllChemoField();
        }
        return protoColTyp;
    }


    function GetProtocol(DataMigrationYN) {
        var selected_val = $('#ddlChemoPlanTName').find(":selected").attr('value');
        if (selected_val != "") {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetProtocol",
                datatype: 'json',
                async: false,
                data: { id: selected_val },
                success: function (data) {
                    if (data.length > 0) {
                        GlbProtocolType = data[3];
                        ProtoColDetails = data[0];
                        $('#ChemoPlan_txtDurationDays').val(data[2]);
                        document.getElementById("ChemoPlanning-Chemoplantable").style.display = "block";
                        //document.getElementById("ChemoPlanning_txtChemoTextArea").style.display = "none";
                        $('#ChemoPlan_chkStructure').prop("disabled", false);
                        if (data[3] !== "S") {
                            EnableDisableSearchRxForChemo(true);  // Added by Dhananjay 20260310  
                        } else {
                            EnableDisableSearchRxForChemo(false);   // Added by Dhananjay 20260310
                        }
                        if (DataMigrationYN === "Y") {
                            BindStructureandUnstrucMigrationData("Y");
                        } else {
                            GetStructureProtocol();
                        }
                    }
                    else {
                        $('#ChemoPlanning_txtChemoTextArea').val('');
                        autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
                    }
                    EnDisAllChemoField();
                    //end
                    GetProtoType(ProtoColDetails);
                }
            });
        }
        else {
            Chemoplantable.clearData();
            $('#ChemoPlanning_txtChemoTextArea').val('');
            $('#ChemoPlan_chkStructure').prop("disabled", true);
            autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
        }
    }

    function GetStructureProtocol() {
        var selected_val = $('#ddlChemoPlanTName').find(":selected").attr('value');
        if (selected_val != "") {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetChemoMedicationMasterList?strProtocol=" + selected_val + "&strType=" + "D",
                datatype: 'json',
                async: false,
                success: function (data) {
                    var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                    //var isCompletePatYN = sessionStorage.getItem('PatCompleted');
                    var isCompletePatYN = (moduleFlag === "IPD") || sessionStorage.getItem("PatCompleted")?.toString() != "Y";
                    var Grid = JSON.parse(data);
                    if (Grid.length > 0) {
                        document.getElementById("ChemoPlan_DivOmitIndicator").style.display = "flex";
                        document.getElementById("ChemoPlanning-Chemoplantable").style.display = "block";
                        Grid.forEach(row => {
                            row.isNew = true;
                            row.ShowDel = isCompletePatYN  && ProtoColtype && ProtoColtype == "U" ? true : false;
                        });
                        Chemoplantable.replaceData(Grid);
                        if (Chemoplantable.options.dataLoaded) {
                            Chemoplantable.options.dataLoaded.call(Chemoplantable, Chemoplantable.getData());
                        }
                        if (Chemoplantable.options.renderComplete) {
                            Chemoplantable.options.renderComplete.call(Chemoplantable);
                        }
                        if (isCompletePatYN && ProtoColtype && ProtoColtype == "U") {
                            Chemoplantable.showColumn("act");
                            $("#AllowChemoFreeText").show();
                        }
                        else {
                            Chemoplantable.hideColumn("act");
                            $("#AllowChemoFreeText").hide();
                        }
                    }
                    else {
                        Chemoplantable.clearData();
                    }
                    if (isCompletePatYN && ProtoColtype && ProtoColtype == "U") {
                        EnableDisableSearchRxForChemo(true);
                        $("#AllowChemoFreeText").show();
                    } else {
                        EnableDisableSearchRxForChemo(false);
                        $("#AllowChemoFreeText").hide();
                    }
                    EnDisAllChemoField();

                    //end
                }

            });
        }
        else {
            $('#ChemoPlanning_txtChemoTextArea').val('');
            autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
        }
    }

    function ValidateAddmissionProtocolWise() {
        var selected_val = $('#ddlChemoPlanTName').val();
        if (!selected_val) return true;
        var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
        if (ProtoColtype != "U") {
            return true;
        }
        var ValidationAdmNoFailed = true;
        var ValidationFreeFailed = true;

        if ($("#ChemoPlan_Freetext").prop("checked") == true) {
            if ($("#ChemoPlanning_txtChemoTextArea").val() == "") {
                ValidationFreeFailed = false;
            }
        }
        else {
            ValidationFreeFailed = false;
        }
        var Msg = "";
        var gridData = Chemoplantable.getData();
        if (gridData.length > 0) {
            var TotalAdmissionNo = 1;
            if (selected_val) {
                $.ajax({
                    type: "POST",
                    url: "../DoctorDesk/GetProtocol",
                    dataType: "json",
                    async: false,
                    data: { id: selected_val },
                    success: function (data) {
                        if (data && data.length > 4) {
                            TotalAdmissionNo = parseInt(data[4], 10) || 1;
                        }
                    }
                });
            }
            var missingAdmNos = [];
            for (var i = 1; i <= TotalAdmissionNo; i++) {
                var exists = gridData.some(function (row) {
                    return parseInt(row.ADMNNO, 10) === i;
                });
                if (!exists) {
                    missingAdmNos.push(i);
                }
            }
            if (missingAdmNos.length > 0) {
                Msg = "Select at least one medicine for Admission No: " + missingAdmNos.join(", ");
                ValidationAdmNoFailed = false;
            }
        }
        else {
            ValidationFreeFailed = false;
        }
        EnDisAllChemoField();
        if (ValidationFreeFailed == false && ValidationAdmNoFailed == false) {
            if (Msg == "")
                ToastMsg("Please Enter Description or Medicine", "warning");
            else
                ToastMsg(Msg, "warning");
            return false;
        }
        return true;
    }

    function BindStructureandUnstrucMigrationData(DataMigrationYN) {
        var selected_val = $('#ddlChemoPlanTName').find(":selected").attr('value');
        if (selected_val != "") {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetChemoMedicationMasterList?strProtocol=" + selected_val + "&strType=" + "D",
                datatype: 'json',
                async: true,
                success: function (data) {
                    // var isCompletePatYN = sessionStorage.getItem('PatCompleted');
                    var isCompletePatYN = (moduleFlag === "IPD") || sessionStorage.getItem("PatCompleted")?.toString() != "Y";
                    var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
                    var Grid = JSON.parse(data);
                    if (Grid.length > 0) {
                        const tableEl = document.getElementById("ChemoPlanning-Chemoplantable");
                        tableEl.style.display = "block";
                        var cycleValue = $("#ChemoPlan_txtcurrentCycle").val();
                        Grid.forEach(row => {
                            if (DataMigrationYN === "Y") {
                                row.CYCLENO = cycleValue;
                        row.DOCTCODE = gDoctCode;
                        row.ShowDel = isCompletePatYN && ProtoColtype && ProtoColtype == "U" ? true : false;
                    }
                        });
                        if (Chemoplantable) {
                            Chemoplantable.replaceData(Grid);
                            Chemoplantable.redraw(true);
                            if (ProtoColtype && ProtoColtype == "U") {
                                Chemoplantable.showColumn("act");
                                $("#AllowChemoFreeText").show();
                            }
                            else {
                                Chemoplantable.hideColumn("act");
                                $("#AllowChemoFreeText").hide();
                            }
                        }
                        document.getElementById("ChemoPlanning-Chemoplantable").style.display = "block";
                    }
                    else {
                        Chemoplantable.clearData();
                    }

                    if (isCompletePatYN && ProtoColtype && ProtoColtype == "U") {
                        EnableDisableSearchRxForChemo(true);
                    } else {
                        EnableDisableSearchRxForChemo(false);
                    }
                    EnDisAllChemoField();
                }

            });
        }
        else {
            $('#ChemoPlanning_txtChemoTextArea').val('');
            autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
        }
    }

    function GetIntakeListChemo(TabCoutYN) {
        var RxIntakeList = [];
        let raw = ChemoMedIntakeList.trim();
        if (raw.startsWith('"') && raw.endsWith('"')) {
            raw = raw.slice(1, -1);
        }
        raw = raw.replace(/\r\n/g, "");
        if (TabCoutYN == "Y") {
            var arry = ChemoMedIntakeList == "" || ChemoMedIntakeList == "null" || raw == "" || raw == null || raw == undefined ? [] : JSON.parse(raw).Intake;
            RxIntakeList = arry;
        }
        else {
            var arry = ChemoMedIntakeList == "" || ChemoMedIntakeList == "null" || raw == "" || raw == null || raw == undefined ? [] : JSON.parse(raw).Intake;
            RxIntakeList = ConvertArryListToTabulatorFormat(arry, "INTAKE", "CODE");
        }
        return RxIntakeList;
    }

    // Added by Dhananjay 20260310 | 
    function EnableDisableSearchRxForChemo(isEnableRxSearch) {
        if (isEnableRxSearch) {
            $('#RxSearchChemoPlanning').show().prop('disabled', false);
            //Chemoplantable.showColumn("act");
        }
        else {
            $('#RxSearchChemoPlanning').hide();
            Chemoplantable.hideColumn("act");
        }
    }

    //function drugSearchEditor(cell, onRendered, success, cancel, editorParams) {

    //    var container = document.createElement("div");
    //    container.style.position = "relative";

    //    var input = document.createElement("input");
    //    input.type = "text";
    //    input.style.width = "100%";

    //    var list = document.createElement("div");
    //    list.style.position = "fixed";
    //    list.style.background = "#fff";
    //    list.style.border = "1px solid #ccc";
    //    list.style.zIndex = "999999";
    //    list.style.maxHeight = "150px";
    //    list.style.overflowY = "auto";
    //    list.style.display = "none";
    //    list.style.boxSizing = "border-box";
    //    list.style.boxShadow = "0 2px 8px rgba(0,0,0,.2)";

    //    container.appendChild(input);
    //    document.body.appendChild(list);

    //    function positionList() {
    //        var rect = input.getBoundingClientRect();

    //        list.style.left = rect.left + "px";
    //        list.style.top = rect.bottom + "px";
    //        list.style.width = rect.width + "px";
    //    }

    //    onRendered(function () {
    //        input.focus();
    //        input.value = cell.getValue() || "";
    //        positionList();
    //    });

    //    window.addEventListener("scroll", positionList, true);
    //    window.addEventListener("resize", positionList);

    //    input.addEventListener("keyup", function () {

    //        positionList();

    //        var val = input.value.trim().toUpperCase();

    //        list.innerHTML = "";

    //        if (!val) {
    //            list.style.display = "none";
    //            return;
    //        }

    //        var results = GlobalGetDiluentList
    //            .filter(function (e) {
    //                return e.Text.toUpperCase().includes(val);
    //            })
    //            .slice(0, 10);

    //        results.forEach(function (item) {

    //            var option = document.createElement("div");

    //            option.innerText = item.Text;
    //            option.style.padding = "6px 10px";
    //            option.style.cursor = "pointer";

    //            option.onmouseenter = function () {
    //                option.style.background = "#f2f2f2";
    //            };

    //            option.onmouseleave = function () {
    //                option.style.background = "#fff";
    //            };

    //            option.onclick = function () {

    //                cell.getRow().update({
    //                    DILUENT: item.Text,
    //                    DILNTGENCD: item.Value
    //                });

    //                input.value = item.Text;

    //                list.style.display = "none";

    //                window.removeEventListener("scroll", positionList, true);
    //                window.removeEventListener("resize", positionList);

    //                list.remove();

    //                success(item.Text);
    //            };

    //            list.appendChild(option);
    //        });

    //        list.style.display = results.length ? "block" : "none";
    //    });

    //    input.addEventListener("keydown", function (e) {
    //        if (e.key === "Escape") {

    //            window.removeEventListener("scroll", positionList, true);
    //            window.removeEventListener("resize", positionList);

    //            list.remove();
    //            cancel();
    //        }
    //    });

    //    input.addEventListener("blur", function () {

    //        setTimeout(function () {

    //            window.removeEventListener("scroll", positionList, true);
    //            window.removeEventListener("resize", positionList);

    //            if (document.body.contains(list)) {
    //                list.remove();
    //            }

    //            if (input.value.trim() === "") {

    //                cell.getRow().update({
    //                    DILUENT: "",
    //                    DILNTGENCD: ""
    //                });
    //                success("");
    //            }
    //            else {
    //                cancel();
    //            }

    //        }, 200);

    //    });

    //    return container;
    //}

    function drugSearchEditor(cell, onRendered, success, cancel, editorParams) {

        var container = document.createElement("div");
        container.style.position = "relative";

        var input = document.createElement("input");
        input.type = "text";
        input.style.width = "100%";

        var list = document.createElement("div");
        list.style.position = "fixed";
        list.style.background = "#fff";
        list.style.border = "1px solid #ccc";
        list.style.zIndex = "999999";
        list.style.maxHeight = "150px";
        list.style.overflowY = "auto";
        list.style.display = "none";
        list.style.boxSizing = "border-box";
        list.style.boxShadow = "0 2px 8px rgba(0,0,0,.2)";

        container.appendChild(input);
        document.body.appendChild(list);

        var valueSelected = false;
        var editorClosed = false;

        function positionList() {
            if (editorClosed) return;

            var rect = input.getBoundingClientRect();
            list.style.left = rect.left + "px";
            list.style.top = rect.bottom + "px";
            list.style.width = rect.width + "px";
        }

        function cleanup() {

            if (editorClosed) return;

            editorClosed = true;

            window.removeEventListener("scroll", positionList, true);
            window.removeEventListener("resize", positionList);

            if (document.body.contains(list)) {
                list.remove();
            }
        }

        onRendered(function () {
            input.focus();
            input.value = cell.getValue() || "";
            positionList();
        });

        window.addEventListener("scroll", positionList, true);
        window.addEventListener("resize", positionList);

        input.addEventListener("keyup", function () {

            positionList();

            var val = input.value.trim().toUpperCase();

            list.innerHTML = "";

            if (!val) {
                list.style.display = "none";
                return;
            }

            var results = GlobalGetDiluentList
                .filter(function (e) {
                    return e.Text.toUpperCase().includes(val);
                })
                .slice(0, 10);

            results.forEach(function (item) {

                var option = document.createElement("div");

                option.innerText = item.Text;
                option.style.padding = "6px 10px";
                option.style.cursor = "pointer";

                option.onmouseenter = function () {
                    option.style.background = "#f2f2f2";
                };

                option.onmouseleave = function () {
                    option.style.background = "#fff";
                };

                option.onclick = function () {

                    valueSelected = true;

                    cell.getRow().update({
                        DILUENT: item.Text,
                        DILNTGENCD: item.Value
                    });

                    input.value = item.Text;

                    cleanup();

                    success(item.Text);
                };

                list.appendChild(option);
            });

            list.style.display = results.length ? "block" : "none";
        });

        input.addEventListener("keydown", function (e) {

            if (e.key === "Escape") {
                cleanup();
                cancel();
            }

        });

        input.addEventListener("blur", function () {

            setTimeout(function () {

                if (editorClosed) {
                    return;
                }

                cleanup();

                if (valueSelected) {
                    return;
                }

                if (input.value.trim() === "") {

                    cell.getRow().update({
                        DILUENT: "",
                        DILNTGENCD: ""
                    });

                    success("");
                }
                else {

                    cancel();
                }

            }, 200);

        });

        return container;
    }
    function GetProtoType(ProtoColDetails) {
        if (SavedProtoCol == "") {
            var ProtoColtype = GlbProtocolType == "" ? GetProtocolTypeSU() : GlbProtocolType;
            if (ProtoColtype == "U") {
                $("#ChemoPlan_Freetext").prop("checked", true);
                $("#ChemoPlanning_txtChemoTextArea").val(ProtoColDetails);
                $("#AllowChemoFreeText").show();
                $("#ChemoPlanning_txtChemoTextArea").show();
                autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
                $("#ChemoPlan_Freetext").prop("disabled", false);
                $("#ChemoPlanning_txtChemoTextArea").prop("disabled", false);
            }
            else {
                $("#ChemoPlan_Freetext").prop("checked", false);
                $("#ChemoPlanning_txtChemoTextArea").val("");
                $("#AllowChemoFreeText").hide();
                $("#ChemoPlanning_txtChemoTextArea").hide();
                autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
            }
        }
    }
    //Abhishesh || 20260713
    function InitChemoNameSelect2() {
        if (!$("#ddlChemoPlanTName").hasClass("select2-hidden-accessible")) {
            $("#ddlChemoPlanTName").select2({
                width: '100%',
                dropdownAutoWidth: false
            });
        }
    }
    // Pournima 16th July 2026
    function toggleDiluentFields(row) {
        var rowData = row.getData();
        var disableDiluent = ("" + EnaDisDILUENT).trim() != "" && (("" + rowData.ROUTECD).trim() === ("" + EnaDisDILUENT).trim());
        if (disableDiluent) {
            row.update({
                DILUENT: "",
                VOLDILTN: "",
                DURATION: ""
            });
        }
        row.getCell("DILUENT").getElement().style.pointerEvents = disableDiluent ? "none" : "";
        row.getCell("VOLDILTN").getElement().style.pointerEvents = disableDiluent ? "none" : "";
        row.getCell("DURATION").getElement().style.pointerEvents = disableDiluent ? "none" : "";

        row.getCell("DILUENT").getElement().style.opacity = disableDiluent ? "0.5" : "";
        row.getCell("VOLDILTN").getElement().style.opacity = disableDiluent ? "0.5" : "";
        row.getCell("DURATION").getElement().style.opacity = disableDiluent ? "0.5" : "";
    }
    //End
</script>

<script type="text/javascript">
    var AdmissionTable = null;
    $(document).ready(function () {
        // Pournima 24th June 2026
        $("#ChemoPlan_Freetext").on('change', function () {
            if ($(this).prop("checked")) {
                $("#ChemoPlanning_txtChemoTextArea").show();
            } else {
                $("#ChemoPlanning_txtChemoTextArea").hide();
                //$("#ChemoPlanning_txtChemoTextArea").val("");
            }
            autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
        });
        $("#txtDuration").on("input", function () {
            if ($(this).val().trim() !== "") {
                $(this).css("border-color", "");
            }
        });
        $("#txtNoOfAdmissions").on("input", function () {
            if ($(this).val().trim() !== "") {
                $(this).css("border-color", "");
            }
        });

     
        hideAdmissionTable();
    });
    //Print Start
    function PrintChemo() {
        //Added By Abhishesh || 20260720
        if ($("#chkheader").prop('checked') == true) {
            LetterHeaderYN = "Y";
        } else {
            LetterHeaderYN = "";
        }
        //End
        //var cycle = $("#ChemoPlan_txtcurrentCycle").val().trim() == "" ? $("#ChemoPlan_txtCompleteCycle").val() : $("#ChemoPlan_txtcurrentCycle").val();
        var cycle = $("#ChemoPlan_txtCompleteCycle").val().trim() == "" || $("#ChemoPlan_txtCompleteCycle").val().trim() == "0" ? "1" : "";
        var MRNO = sessionStorage.getItem('MODULE_FLAG') == "IPD" ? sessionStorage.getItem('IPPatMRNO') : sessionStorage.getItem('PatMRNO')
        var DataToSend = {
            MRNo: MRNO,
            ConsultNo: "", //sessionStorage.getItem('ChemoConsultNo'), --need to bind chemo consultation no.
            PlanNo: $("#ChemoPlan_txtTRANID").val(),
            CycleNo: cycle,
            StrProtocole: $('#ddlChemoPlanTName').find(":selected").attr('value'),
            LetterHeaderYN: LetterHeaderYN // Abhishesh || 20260720
        };
        startLoading("Loading", "loading-ChemoPlan-Section");
        $.ajax({
            url: '../DoctorDesk/PrintChemoPlanning',
            data: DataToSend,
            type: 'post',
            async: true,
            success: function (response) {
                var win = window.open('../DoctorDesk/DisplayPrintChemoPlan', "_blank", '', true);
                win.focus();
                stopLoading("loading-ChemoPlan-Section");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //$.messager.alert("Error", errorThrown);
                stopLoading("loading-ChemoPlan-Section");
            },
            complete: function () {
                stopLoading("loading-ChemoPlan-Section");
            }
        })
    }
    //End

    //Previous History
    function PatMedicationHistory() {
        var MRNo = GetSessionMRNO();
        var ChemoPlanPrevHistDtls = [];
        $.ajax({
            url: '../DoctorDesk/GetchemoHistory',
            data: { strMrNo: MRNo },
            type: 'post',
            async: false,
            datatype: 'json',
            success: function (response) {
                if (response != "") {
                    ChemoPlanPrevHistDtls = response;
                }
            }
        });
        return ChemoPlanPrevHistDtls;
    }

    function getChemoProtocolColumns() {
         return [
            { title: "Drug Form", field: "FORMNAME", frozen: true, width: 120 },
            { title: "Generic Name", field: "GENERICNM", frozen: true, width: 150 },
            { title: "Dose", field: "DOSE", width: 120, hozAlign: "right" },
            { title: "Dose Unit", field: "DOSEUNIT", width: 80 },
            { title: "Frequency", field: "FREQUENCY", width: 120 },
            { title: "Route", field: "ROUTECD", width: 120 },
            { title: "Calculate On", field: "CALCULATEON", width: 120 },
            {
                title: "Omit",
                field: "OMITDRUG",
                width: 60,
                hozAlign: "center",
                formatter: function (cell) {
                    return cell.getValue() === "Y"
                        ? "<input type='checkbox' checked disabled />"
                        : "<input type='checkbox' disabled />";
                }
            },
            { title: "Diluent", field: "DILUENT", width: 120 },
            { title: "Diluent Volume", field: "VOLDILTN", width: 150 },
            { title: "Duration", field: "DURATION", width: 140 },
            { title: "Remarks", field: "REMARKS", width: 200 },
            { title: "Admission Seq. No.", field: "ADMINSEQNO", width: 180 },
            { title: "Cycle No", field: "CYCLENO", width: 120 },
            { title: "Medicine Type", field: "MEDTYPE", width: 120, visible: false },
            { title: "On Day", field: "ONDAY", width: 100, hozAlign: "center" },
            { title: "Apply To Day", field: "APLYTODAY", width: 100, hozAlign: "center", visible: false },
            { title: "Original Dose", field: "ORIGINALDOSE", width: 120, hozAlign: "right" },
            { title: "Med. Set No.", field: "MEDSETNO", width: 100, visible: false },
            { title: "Generic Code", field: "GENERICID", width: 100, visible: false },
            { title: "Diluent Generic Code", field: "DILNTGENCD", width: 140, visible: false },
            
        ];
    }

    function formatDate(yyyymmdd) {
        if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd;
        var year = yyyymmdd.substring(0, 4);
        var month = yyyymmdd.substring(4, 6);
        var day = yyyymmdd.substring(6, 8);
        return day + "-" + month + "-" + year;
    }



    //function HistPopChemoPlanPrevHistTemp(ChemoPrevHistData) {
    //    var result = ChemoPrevHistData.data || [];
    //    var resultTbl = ChemoPrevHistData.data1 || [];
    //
    //    var html = "<div class='chemo-history-wrapper'>";
    //
    //    if (!result.length) {
    //        html += "<div style='text-align:center;font-size:18px;font-weight:bold;color:#555'>No History Found</div>";
    //        html += "</div>";
    //        return html;
    //    }
    //
    //    //Calculate Cycles
    //    var HTotalCycle = totalCycle;
    //    if (result.length == 1) {
    //        if (result[0].TOTALCYCLE == "")
    //            HTotalCycle = $("#ChemoPlan_txtCycles").val();
    //        else
    //            HTotalCycle = result[0].TOTALCYCLE;
    //    }
    //    var HCurCycle = currentCycle;
    //    if (result.length == 1) {
    //        HCurCycle = result[0].ENDDATE == "" ? "0" : "1";
    //    }
    //    var HPendCycle = pendingCycle;
    //    if (result.length == 1) {
    //        HPendCycle = result[0].ENDDATE == "" ? Number(HTotalCycle) : Number(HTotalCycle) - 1;
    //    }
    //
    //    // Header
    //    html += "<div style='background:#6c88c4;color:#fff;padding:10px;font-weight:bold;display:flex;flex-wrap:wrap;justify-content:space-between'>" +
    //        "<span>✅ Total No of Cycle(s): " + HTotalCycle + "</span>" +
    //        "<span>✔️ Completed Cycle(s): " + HCurCycle + "</span>" +
    //        "<span>⏳ Pending Cycle(s): " + HPendCycle + "</span>" +
    //        "</div>";
    //
    //    for (var i = 0; i < result.length; i++) {
    //        var row = result[i];
    //        html += "<div class='chemo-panel'>" +
    //            "<div class='chemo-panel-head' style='background:#6c88c4;color:#fff;padding:6px;display:flex;justify-content:space-between;cursor:pointer' data-panel='ChemoTab_" + i + "'>" +
    //            "<span>" + (row.ENDDATE ? "✔" : "") + " Plan No : " + row.PLANID + " " + (row.CYCLENO ? "(IP VISIT)" : "(OP VISIT)") + "</span>" +
    //            "<span>Date: " + formatDate(row.TRANDATE) + (row.CYCLENO ? " | Cycle: " + row.CYCLENO : "") + "</span>" +
    //            "</div>" +
    //            "<div class='chemo-panel-body' style='display:none;padding:10px;border:1px solid #ccc;margin-bottom:10px;'>";
    //
    //        if (row.CYCLENO) {
    //            html += "<div style='background:#e6e9eb;padding:6px;border:1px solid #c8c4c4;font-weight:bold;margin-bottom:10px'>" +
    //                "Start Date: " + formatDate(row.STARTDATE) + " | End Date: " + formatDate(row.ENDDATE) +
    //                "</div>" +
    //                "<div><b>Chemotherapy Name:</b> " + row.NAME + "</div>" +
    //                "<div id='ChemoTab_" + i + "' style='margin-top:10px;'></div>";
    //        } else {
    //            html += "<div><b>Modification During Treatment:</b></div>" +
    //                "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + row.MODIFYMEDS + "</div>";
    //        }
    //
    //        if (row.TREATMENTCOMPLETESTATUS != "" && row.TREATMENTCOMPLETESTATUS != undefined) {
    //            html += "<div><b>Treatment Conclusion Status:</b></div>" +
    //                "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + row.TREATMENTCOMPLETESTATUS + "</div>";
    //        }
    //        if (row.CONCLUSIONREMARK != "" && row.CONCLUSIONREMARK != undefined) {
    //            html += "<div><b>Conclusion Remarks:</b></div>" +
    //                "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + row.CONCLUSIONREMARK + "</div>";
    //        }
    //
    //
    //        html += "</div></div>"; // panel-body + panel
    //    }
    //
    //    html += "</div>"; // chemo-history-wrapper
    //
    //    // After HTML is inserted into DOM, initialize toggle + Tabulator
    //    setTimeout(function () {
    //        // Panel toggle
    //        document.querySelectorAll('.chemo-panel-head').forEach(function (header) {
    //            header.addEventListener('click', function () {
    //                var body = this.nextElementSibling;
    //                if (body.style.display === "none") {
    //                    body.style.display = "block";
    //                    var tabId = this.dataset.panel;
    //                    var tabDiv = document.getElementById(tabId);
    //                    if (tabDiv && !tabDiv.tabulator) {
    //                        var panelIndex = tabId.split("_")[1];
    //                        var rowData = result[panelIndex];
    //                        //var protocolData = resultTbl.filter(x => x.PLANID === rowData.PLANID && x.CYCLENO === rowData.CYCLENO);
    //                        var protocolData = resultTbl
    //                            .filter(x => x.PLANID === rowData.PLANID && x.CYCLENO === rowData.CYCLENO && x.OMITDRUG !== "Y")
    //                            .sort(function (a, b) {
    //                                if (a.CYCLENO != b.CYCLENO) return a.CYCLENO - b.CYCLENO;
    //                                if (a.ADMINSEQNO != b.ADMINSEQNO) return a.ADMINSEQNO - b.ADMINSEQNO;
    //                                if (a.ONDAY != b.ONDAY) return a.ONDAY - b.ONDAY;
    //                                return a.MEDSETNO - b.MEDSETNO;
    //                            });
    //                        new Tabulator("#" + tabId, {
    //                            data: protocolData,
    //                            layout: "fitDataStretch",
    //                            columns: getChemoProtocolColumns(),
    //                            placeholder: "No Protocol Data",
    //                            height: "240px"
    //                        });
    //                    }
    //                } else {
    //                    body.style.display = "none";
    //                }
    //            });
    //        });
    //    }, 50);
    //
    //    return html;
    //}

    function HistPopChemoPlanPrevHistTemp(ChemoPrevHistData) {
        var result = ChemoPrevHistData.data || [];
        var resultTbl = ChemoPrevHistData.data1 || [];

        var html = "<div class='chemo-history-wrapper'>";

        if (!result.length) {
            html += "<div style='text-align:center;font-size:18px;font-weight:bold;color:#555'>No History Found</div>";
            html += "</div>";
            return html;
        }

        // ---- Group rows by Plan No (PLANID), preserving original order ----
        var groupOrder = [];
        var groupMap = {};
        result.forEach(function (row, idx) {
            var planId = row.PLANID;
            if (!groupMap[planId]) {
                groupMap[planId] = [];
                groupOrder.push(planId);
            }
            groupMap[planId].push({ row: row, idx: idx });
        });

        groupOrder.forEach(function (planId) {
            var groupEntries = groupMap[planId];
            var groupRows = groupEntries.map(function (e) { return e.row; });
            var firstRow = groupRows[0];

            // ---- Per Plan-No header stats ----
            //var HTotalCycle = firstRow.TOTALCYCLE || totalCycle;
            //var completedCount = groupRows.filter(function (r) {
            //    return r.CYCLENO && r.ENDDATE;
            //}).length;
            //var HCurCycle = completedCount;
            //var HPendCycle = Number(HTotalCycle) - completedCount;

            var HTotalCycle = firstRow.TOTALCYCLE || totalCycle;
            var maxCycleNo = 0;
            groupRows.forEach(function (r) {
                var cyc = Number(r.CYCLENO) || 0;
                if (cyc > maxCycleNo) maxCycleNo = cyc;
            });
            var HCurCycle = maxCycleNo;
            var HPendCycle = Number(HTotalCycle) - maxCycleNo;
            if (isNaN(HPendCycle) || HPendCycle < 0) HPendCycle = 0;

            if (result.length == 1) {
                HTotalCycle = firstRow.TOTALCYCLE == "" ? $("#ChemoPlan_txtCycles").val() : firstRow.TOTALCYCLE;
                HCurCycle = firstRow.ENDDATE == "" ? "0" : "1";
                HPendCycle = firstRow.ENDDATE == "" ? Number(HTotalCycle) : Number(HTotalCycle) - 1;
            }

            // ---- Group wrapper (hardcoded inline style, no class) ----
            html += "<div style='border:1px solid #b9c3d9;border-radius:6px;overflow:hidden;margin-bottom:16px;'>";

            // ---- Header block (hardcoded inline style) ----
            html += "<div style='background:#6c88c4;color:#fff;padding:10px;font-weight:bold;display:flex;flex-wrap:wrap;justify-content:space-between'>" +
                "<span>✅ Total No of Cycle(s): " + HTotalCycle + "</span>" +
                "<span>✔️ Completed Cycle(s): " + HCurCycle + "</span>" +
                "<span>⏳ Pending Cycle(s): " + HPendCycle + "</span>" +
                "</div>";

            // ---- Panels for this Plan No only ----
            groupEntries.forEach(function (entry) {
                var row = entry.row;
                var i = entry.idx;

                html += "<div class='chemo-panel'>" +
                    "<div class='chemo-panel-head' style='background:#6c88c4;color:#fff;padding:6px;display:flex;justify-content:space-between;cursor:pointer' data-panel='ChemoTab_" + i + "'>" +
                    "<span>" + (row.ENDDATE ? "✔" : "") + " Plan No : " + row.PLANID + " " + (row.CYCLENO ? "(IP VISIT)" : "(OP VISIT)") + "</span>" +
                    "<span>Date: " + formatDate(row.TRANDATE) + (row.CYCLENO ? " | Cycle: " + row.CYCLENO : "") + "</span>" +
                (row.CYCLENO
                    ? "<span title='Print Chemoplanning'>" +
                    "<i onclick=\"PrintHistoChemo('" + row.CYCLENO + "','" + row.NAME + "','" + row.PLANID + "')\" class='fa fa-print PatClinicPrescPrint'></i>" +
                    "</span>"
                        : "") + 
                "</div>" +
                    "<div class='chemo-panel-body' style='display:none;padding:10px;border:1px solid #ccc;margin-bottom:10px;'>";

                if (row.CYCLENO) {
                    html += "<div style='background:#e6e9eb;padding:6px;border:1px solid #c8c4c4;font-weight:bold;margin-bottom:10px'>" +
                        "Start Date: " + formatDate(row.STARTDATE) + " | End Date: " + formatDate(row.ENDDATE) +
                        "</div>" +
                        "<div><b>Chemotherapy Name:</b> " + row.NAME + "</div>" +
                        (row.CHEMOFREETEXT ? "<div><b>Protocol:</b> <span style='white-space:pre-wrap'>" + row.CHEMOFREETEXT + "</span></div>" : "") +
                        "<div id='ChemoTab_" + i + "' style='margin-top:10px;'></div>";
                } else {
                    html += "<div><b>Modification During Treatment:</b></div>" +
                        "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + row.MODIFYMEDS + "</div>";
                }

                if (row.TREATMENTCOMPLETESTATUS != "" && row.TREATMENTCOMPLETESTATUS != undefined) {
                    html += "<div><b>Treatment Conclusion Status:</b></div>" +
                        "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + row.TREATMENTCOMPLETESTATUS + "</div>";
                }
                if (row.CONCLUSIONREMARK != "" && row.CONCLUSIONREMARK != undefined) {
                    html += "<div><b>Conclusion Remarks:</b></div>" +
                        "<div style='border:1px solid #ccc;padding:10px;background:#f9f9f9'>" + row.CONCLUSIONREMARK + "</div>";
                }

                html += "</div></div>"; // panel-body + panel
            });

            html += "</div>"; // group wrapper
        });

        html += "</div>"; // chemo-history-wrapper

        // ---- Toggle + Tabulator init (unchanged) ----
        setTimeout(function () {
            document.querySelectorAll('.chemo-panel-head').forEach(function (header) {
                header.addEventListener('click', function () {
                    var body = this.nextElementSibling;
                    if (body.style.display === "none") {
                        body.style.display = "block";
                        var tabId = this.dataset.panel;
                        var tabDiv = document.getElementById(tabId);
                        if (tabDiv && !tabDiv.tabulator) {
                            var panelIndex = tabId.split("_")[1];
                            var rowData = result[panelIndex];
                            var protocolData = resultTbl
                                .filter(x => x.PLANID === rowData.PLANID && x.CYCLENO === rowData.CYCLENO)
                                .sort(function (a, b) {
                                    if (a.CYCLENO != b.CYCLENO) return a.CYCLENO - b.CYCLENO;
                                    if (a.ADMINSEQNO != b.ADMINSEQNO) return a.ADMINSEQNO - b.ADMINSEQNO;
                                    if (a.ONDAY != b.ONDAY) return a.ONDAY - b.ONDAY;
                                    return a.MEDSETNO - b.MEDSETNO;
                                });
                            new Tabulator("#" + tabId, {
                                data: protocolData,
                                layout: "fitDataStretch",
                                columns: getChemoProtocolColumns(),
                                placeholder: "No Protocol Data",
                                height: "240px"
                            });
                        }
                    } else {
                        body.style.display = "none";
                    }
                });
            });
        }, 50);

        return html;
    }

    function PrintHistoChemo(HistoCycleNo, HistoProtoName, HistoPlanno) {
        if ($("#chkheader").prop('checked') == true) {
            LetterHeaderYN = "Y";
        } else {
            LetterHeaderYN = "";
        }
        var MRNO = sessionStorage.getItem('MODULE_FLAG') == "IPD" ? sessionStorage.getItem('IPPatMRNO') : sessionStorage.getItem('PatMRNO')
        var DataToSend = {
            MRNo: MRNO,
            ConsultNo: "",
            PlanNo: HistoPlanno,
            CycleNo: HistoCycleNo,
            StrProtocole: HistoProtoName,
            LetterHeaderYN: LetterHeaderYN
        };
        startLoading("Loading");
        $.ajax({
            url: '../DoctorDesk/PrintChemoPlanning',
            data: DataToSend,
            type: 'post',
            async: true,
            success: function (response) {
                var win = window.open('../DoctorDesk/DisplayPrintChemoPlan', "_blank", '', true);
                win.focus();
                stopLoading();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading();
            }
        })
    }
    
    //End

    function ReturnGenericName(GenericCode) {
        var GenName = "";
        PHGenericNAmesLst.forEach(function (item) {
            if ((item.Value || "").toLowerCase().trim() === (GenericCode || "").toLowerCase().trim()) {
                GenName = item.Text;
            }
        });
        return GenName;
    }

    function ValidationForChemoPlanning() {
        if ($("#ddlChemoPlanTName").val() == null || $("#ddlChemoPlanTName").val() == "") {
            $('#ddlChemoPlanTCourse').focus();
            ToastMsg("Please Select Chemotherapy Name/Protocol", "warning");
            return false;
        }
        if (!ValidationForCycle()) {
            return false;
        }
        if (!ValidateAddmissionProtocolWise()) {
            return false;
        }

        if ($("#ddlChemoPlanTCourse").val() == "") {
            $("#ddlChemoPlanTCourse").css("border", "2px solid red");
            $('#ddlChemoPlanTCourse').focus();
            ToastMsg("Please Select Chemotherapy Course", "warning");
            return false;
        } else {
            $("#ddlChemoPlanTCourse").css("border", "");
        }
        if ($("#ChemoPlan_txtCycles").val() == "") {
            $("#ChemoPlan_txtCycles").css("border", "2px solid red");
            $('#ChemoPlan_txtCycles').focus();
            ToastMsg("Please Enter Total Number Of Cycle(s).", "warning");
            return false;
        } else {
            $("#ChemoPlan_txtCycles").css("border", "");
        }
        if ($("#ChemoPlan_txtRepeatAfter").val() == "") {
            $("#ChemoPlan_txtRepeatAfter").css("border", "2px solid red");
            $('#ChemoPlan_txtRepeatAfter').focus();
            ToastMsg("Please Enter Repeat After Day(s).", "warning");
            return false;
        } else {
            $("#ChemoPlan_txtRepeatAfter").css("border", "");
        }

        if ($('#ddlChemoPlanConclStatus').val() != "") {
            if ($('#ConclusionRemark').val().trim() == "") {
                $('#ConclusionRemark').css("border", "2px solid red");
                $('#ConclusionRemark').focus();
                ToastMsg("Please Enter Conclusion Remark", "warning");
                return false;
            } else {
                $('#ConclusionRemark').css('border', "");
            }
        }
        var rows = Chemoplantable.getData();
        var invalidDoseRows = [];
        var invalidDrugFormRows = [];
        for (var r = 0; r < rows.length; r++) {
            var row = rows[r];
            var AdmissionNo = row.ADMNNO;
            var OnDay = parseFloat(row.ONDAY);
            var ApplyToDay = parseFloat(row.APLYTODAY);
            var MedType = row.MEDTYPE;
            var MedSetNo = row.MEDSETNO;
            var drugform = row.DRUGFORM;
            var dose = parseFloat(row.DOSE);
            var doseunit = row.DOSEUNIT;
            var Route = row.ROUTECD;
            var Frequency = row.FREQUENCY;
            var AdmSeqNo = row.ADMINSEQNO;

            if (!AdmissionNo) {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                msg = "In Chemoplanning, please select the Admission No. for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (isNaN(OnDay) || OnDay === 0 || row.ONDAY === "") {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                var msg = "In Chemoplanning, On Day cannot be zero or empty for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (isNaN(ApplyToDay) || ApplyToDay === 0 || row.APLYTODAY === "") {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                var msg = "In Chemoplanning, Apply To Day cannot be zero or empty for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (!MedType) {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                msg = "In Chemoplanning, please select the Medicine Type for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (!MedSetNo) {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                msg = "In Chemoplanning, please select the Med. Set No. for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (!drugform) {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                msg = "In Chemoplanning, please select the Drug Form for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (isNaN(dose) || dose === 0 || row.DOSE === "") {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                var msg = "In Chemoplanning, Dose cannot be zero or empty for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (!doseunit) {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                msg = "In Chemoplanning, please enter dose unit for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            //Calculate
            if (!Route) {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                msg = "In Chemoplanning, please select the Route for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (!Frequency) {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                msg = "In Chemoplanning, please enter the Frequency for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (isNaN(AdmSeqNo) || AdmSeqNo === 0 || row.ADMINSEQNO === "") {
                var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                var msg = "In Chemoplanning, Administer Seq. No. cannot be empty for the following:\n";
                msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                ToastMsg(msg, "warning");
                return false;
            }
            if (moduleFlag == "IPD") {
                if (row.OMITDRUG == false && row.ADMNSTATUS != "Y" && (row.VOLDILTN != "" || row.DILUENT != "") && row.DURATION == "") {
                    var genName = ReturnGenericName((row.GENERICID || "").toLowerCase().trim());
                    var msg = "In Chemoplanning, Duration cannot be empty for the following:\n";
                    msg += "Admission " + row.ADMNNO + " | Generic Name: " + genName + "\n";
                    ToastMsg(msg, "warning");
                    return false;
                }
            }
var seen = {};

for (var d = 0; d < rows.length; d++) {

    var rw = rows[d];

    if (rw.OMITDRUG === true || rw.OMITDRUG === "Y") continue; // ignore omitted drugs
 
    var key = ("" + rw.GENERICID).toLowerCase().trim() + "|" +

              parseFloat(rw.DOSE) + "|" +

              ("" + rw.MEDSETNO).trim() + "|" +

              ("" + rw.APLYTODAY).trim() + "|" +

              ("" + rw.ADMNNO).trim();
 
    if (seen[key]) {

        ToastMsg("In Chemoplanning, the same generic name with the same Dose, Med. Set No., Apply To Day and Admission No. already exists. Please change any one of them for the following:\n" +

            "Generic Name: " + ReturnGenericName(rw.GENERICID) + "\n" +

            "Dose: " + rw.DOSE + " | Med. Set No.: " + rw.MEDSETNO + " | Apply To Day: " + rw.APLYTODAY + " | Admission No.: " + rw.ADMNNO, "warning");

        return false;

    }

    seen[key] = true;

}
 
            

            return true;
        }
    }


    function autoResizeChemoProtocolTextarea(el) {
        if (!el) return;
        el.style.height = "auto";              // reset first so scrollHeight reflects only current content
        el.style.height = el.scrollHeight + "px";
        el.style.overflowY = "hidden";         // never show an internal scrollbar
    }
    function HASChemoPlanningData() {
        var ChemoTblData = Chemoplantable.getData();
        var ChemoFreeTxt = $("#ChemoPlanning_Freetext").val();
        var MedSchemeData = GetSelectedSchemeCodes("M");

        if (ChemoTblData.length === 0 && (ChemoFreeTxt === "" || ChemoFreeTxt === null) && MedSchemeData == "") {
            return false;
        }
        else {
            return true;
        }

    }
    function SaveForChemoPlanning(DataSaveObj, Type) {
        var DataSaveObj = {};//priyanka 07/03/2026
        let consultNo;
        if (moduleFlag == "IPD") {
             consultNo = "";
        }
        else {
             consultNo = sessionStorage.getItem('PatTRANNO');
        }
        var tranno = "";
        if (ChemoPlangaction === "E") { //PRIYANKA 08/03/2026
            tranno = $("#ChemoPlan_txtPlanNo").text();
        }
        else {
            tranno = "";
        }

        let mrno = "";
        if (moduleFlag == "IPD") {
            mrno = sessionStorage.getItem('IPPatMRNO');
        }
        else {
            mrno = sessionStorage.getItem('PatMRNO');
        }
        let chemoCourseName = $("#ddlChemoPlanTCourse").val();
        var drugTextArea = $("#ChemoPlanning_txtChemoTextArea").val();
        if (!$("#ChemoPlan_Freetext").is(":checked")) {
            $("#ChemoPlanning_txtChemoTextArea").val(""); 
            drugTextArea = "";  
            autoResizeTextareaForSinglePage(document.getElementById('ChemoPlanning_txtChemoTextArea'));
        }
        let chemoName = $('#ddlChemoPlanTName').find(":selected").attr('value');
        let noOfCyle = $("#ChemoPlan_txtCycles").val();
        let repeatAfterDays = $("#ChemoPlan_txtRepeatAfter").val();
        let prevTreatment = "";
        let treatmentPlanCode = $("#ddlChemoPlanTreatmentPlan").val();
        let tratmentModification = $("#ChemoPlanning_Freetext").val();
        let height = $("#ChemoPlan_txtHeight").val();
        let weight = $("#ChemoPlan_txtWeight").val();
        let bsa = $("#ChemoPlan_txtBSA").val();
        let hptReport = "";//$("#txtHPReport").val();
        let hptReportRemark = ""; //$("#txtHPReportRemark").val();
        let patCat = ""; //$("#LstPatCat").val();
        let performanceStatus = ""; //$("#cmbPerformanceStatus").val();
        let scheme = "";
        let t = $("#ChemoPlan_txtTstage").val();
        let n = $("#ChemoPlan_txtNstage").val();
        let m = $("#ChemoPlan_txtMstage").val();
        let prechemoFinding = ""; //$("#txtCoMorbiditiesTextArea").val();
        let entryDate = "";
        let m2 = "";
        let regime = "";
        let cancelRemarks = "";
        let schemeoth = "";
        let HrsDay = "";
        let DuraHrDay = $('#ChemoPlan_txtDurationDays').val();
        Chemoplantable.getRows().forEach(function (row) {
            var data = row.getData();

            // Map GENERICID to GENERICNM
            var genName = "";
            PHGenericNAmesLst.forEach(function (item) {
                if ((item.Value || "").toLowerCase().trim() === (data.GENERICID || "").toLowerCase().trim()) {
                    genName = item.Text;
                }
            });

            // Set OMITDRUG as N/Y based on value
            var omitDrug = (data.OMITDRUG === true || data.OMITDRUG === "Y") ? "Y" : "N";

            // Update the row
            row.update({
                GENERICNM: genName,
                OMITDRUG: omitDrug
            });
        });

        const tableData = Chemoplantable.getData();
        //PRIYANKA 12/05/2026
        var InTakLst = GetIntakeListChemo("Y");
        tableData.forEach(row => {
            row.ADMNSTATUS = row.ADMNSTATUS || "";
            //var Freq = "";
            //if (row.FREQUENCY != "") {
            //    var FilterLst = InTakLst.filter(x => x.CODE == row.FREQUENCY);
            //    if (FilterLst.length > 0) {
            //        Freq = FilterLst[0].INTAKE;
            //    }
            //}
            //row.FREQUENCY = Freq;
        });
        const gridChemo = JSON.stringify(tableData);
        let TreatmentDone = "";
        let ConclusionStatus, ConclusionRemark = "";
        if ($("#ChemoPlan_rbtnY").prop("checked") == true) {
            TreatmentDone = "Y";
            ConclusionStatus = $('#ddlChemoPlanConclStatus').val();
            ConclusionRemark = $('#ConclusionRemark').val();

        }
        else if ($("#ChemoPlan_rbtnN").prop("checked") == true) {
            TreatmentDone = "N";

        }
        let TreatmentDate = $('#ChemoPlan_txtTreatComplete').val();
        var ApplyScheme = "";
        if (typeof GetSelectedSchemeCodes === "function") {
            ApplyScheme = GetSelectedSchemeCodes("M");
        }

        let currentTranNo = sessionStorage.getItem('PatTRANNO');
        var DataMigrationYN = "N";
        var CompCycle = "";
        if ($("#ChemoPlan_txtTRANID").val() != "" && $("#ChemoPlan_txtTRANID").val() != null) {
            if (sessionStorage.getItem('MODULE_FLAG') == "OPD") {
                if (GlbPlanConsultNo == "" && DataMigrationFlag == true) {
                    DataMigrationYN = "Y";
                    CompCycle = $("#ChemoPlan_txtCompleteCycle").val();
                }
                else if (currentTranNo == GlbPlanConsultNo) {
                    Flag = false;
                    if (DataMigrationFlag) {
                        DataMigrationYN = "Y";
                        CompCycle = $("#ChemoPlan_txtCompleteCycle").val();
                    }
                }
            }
            if (sessionStorage.getItem('MODULE_FLAG') == "IPD") {
                if (DataMigrationFlag == true) {
                    DataMigrationYN = "Y";
                    CompCycle = $("#ChemoPlan_txtCompleteCycle").val();
                }
            }
        }
        if ($("#ChemoStartDt").val() == "") {
            DataMigrationYN = "Y";
            CompCycle = $("#ChemoPlan_txtCompleteCycle").val();
        }
        DataSaveObj.DataMigrationDataModificationYN = DataMigrationYN;
        DataSaveObj.CompletedCycles = CompCycle;
        DataSaveObj.ConsultNo = consultNo;
        DataSaveObj.MRNO = mrno;
        DataSaveObj.EntryDate = entryDate;
        DataSaveObj.T = t;
        DataSaveObj.N = n;
        DataSaveObj.M = m;
        DataSaveObj.ChemoCourse = chemoCourseName;
        DataSaveObj.HPReport = hptReport;
        DataSaveObj.PrevTreatment = prevTreatment;
        DataSaveObj.PreChemoFindings = prechemoFinding;
        DataSaveObj.Height = height;
        DataSaveObj.Weight = weight;
        DataSaveObj.BSA = bsa;
        DataSaveObj.PerformStatus = performanceStatus;
        DataSaveObj.M2 = m2;
        DataSaveObj.Regime = regime;
        DataSaveObj.ChemoName = chemoName;
        DataSaveObj.Protocol = drugTextArea;
        DataSaveObj.ToRepeat = repeatAfterDays;
        DataSaveObj.TreatmentPlan = treatmentPlanCode;
        DataSaveObj.TotalCycles = noOfCyle;
        DataSaveObj.TreatmentModification = tratmentModification;
        DataSaveObj.ICDYN = "Y";
        DataSaveObj.CancelRemarks = cancelRemarks;
        DataSaveObj.Scheme = scheme;
        DataSaveObj.SchemeOth = schemeoth;
        DataSaveObj.PatCatg = patCat;
        DataSaveObj.gact = ChemoPlangaction;
        DataSaveObj.TranNo = tranno;
        DataSaveObj.Duration = DuraHrDay;
        DataSaveObj.HourorDay = HrsDay;
        DataSaveObj.ReportRemark = hptReportRemark;
        DataSaveObj.gridChemo = gridChemo;
        DataSaveObj.TreatmentDone = TreatmentDone;
        DataSaveObj.ConclusionStatus = ConclusionStatus;
        DataSaveObj.TreatmentDate = TreatmentDate;
        DataSaveObj.SchemeCodes = ApplyScheme;
        DataSaveObj.ChemoAdvStart = $("#ChemoStartDt").val();
        DataSaveObj.ConclusionRemark = ConclusionRemark;
        ////
        startLoading("Loading", "loading-ChemoPlan-Section");
        $.ajax({
            type: 'POST',
            url: '../SinglePage/GetMedOncoSave',
            datatype: 'json',
            async: false,
            data: DataSaveObj,
            success: function (response) {
                stopLoading("loading-ChemoPlan-Section");
                if (ChemoPlangaction == "N") {
                    $("#ChemoPlan_txtTRANID").val(response.ConsultNo);
                }

                if (response.message.includes("Saved successfully")) {
                    ToastMsg("Chemo Planning Data Saved Successfully", "success");
                    if (moduleFlag == "IPD") {
                        closeChemoPlan();
                    }
                    return true;
                }
                else if (response.message.includes("Updation Successful")) {
                    if (moduleFlag == "IPD") {
                        closeChemoPlan();
                    }
                    ToastMsg("Chemo Planning Data Updated Successfully", "success");
                    return true;
                }
                else {
                    ToastMsg("Chemo Planning :" + response.message, "info");
                    return false;
                }
            },
            error: function (xhr, status, error) {
            },
            complete: function () {
            }
        });

    }



    // Added by Dhananjay 20260310 Start

    /* Search For Frequent Rx */
    function GetFrequentRxChemoPlanning() {
        var clinicCode = sessionStorage.getItem('ClinicCode');
        startLoading("Loading", "loading-Rx-Search-List")
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetFregqentMaterial",
            async: true,
            data: { ClinicCode: clinicCode },
            success: function (result) {
                var RxListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL") {
                        result = JSON.parse(result);
                        RxListData = result.Table;
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                BindSearchListForRxChemoPlanning(RxListData);
                stopLoading("loading-Rx-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Rx-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    //List Binding Functionality
    function BindSearchListForRxChemoPlanning(RxData) {
        var $list = $("#RxListChemoPlanning");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No Rx found</div>';
        if (RxData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < RxData.length; i++) {
                var item = RxData[i];
                var code = GeneralWiseYN == "Y" ? $.trim(item.GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : $.trim(item.MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                var name = GeneralWiseYN == "Y" ? $.trim(item.GENERICNAM) : $.trim(item.MTRLNAME);
                if (GeneralWiseYN != "Y") {
                    if ($.trim(item.GENERICNAM) != "")
                        name = name + " (" + $.trim(item.GENERICNAM) + ")";
                    if (item.QOH != undefined && $.trim(item.QOH) != "" && $.trim(item.QOH) > 0)
                        name = name + " [QOH - " + $.trim(item.QOH) + ", MRP - " + $.trim(item.LASTMRP) + "]";
                    else
                        name = name + " [MRP - " + $.trim(item.LASTMRP) + "]";
                }
                var FormCode = item.MTRLFORMID;
                var ListOption = '<div class="list-group-item Rx-row-chemo-planning" ' +
                    'data-GenCode="' + item.GENERICID + '" ' +
                    'data-GenName="' + item.GENERICNAM + '" ' +
                    'data-code="' + code + '" ' +
                    'data-name="' + name + '" ' +
                    'data-formcode="' + FormCode + '" ' +
                    //'style = "cursor:pointer;" > ' + name + '(' + code + ') </div > ';
                    'style = "cursor:pointer;" > ' + name + '</div > ';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#RxListChemoPlanning").append(AppendContentList);
        $("#RxListMainDivChemoPlanning").show();
    }


    //Filter in HTML Search
    function FilterBindedSearchListForRxChemoPlanning() {
        var SearchTxt = $("#RxSearchChemoPlanning").val().toLowerCase();
        var FlagForCallAllRxList = true;
        if (SearchTxt.length < 3) {
            $("#RxListChemoPlanning .Rx-row-chemo-planning").each(function () {
                var name = $(this).data("name").toLowerCase();
                var code = $(this).data("code").toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    FlagForCallAllRxList = false;
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        if (FlagForCallAllRxList == true)
            GetAllRxListChemoPlanning($("#RxSearchChemoPlanning").val(), "");
    }

    /* Search For All Rx */
    function GetAllRxListChemoPlanning(FilterRxText, FilterRxCode, HistoryObj) {
        startLoading("Loading", "loading-Rx-Search-List");
        $.ajax({
            type: "POST",
            async: true,
            url: "../DoctorDesk/GetNonFreqDrugLstFrRxDesktop",
            data: { NonFreqDrug: FilterRxText },
            success: function (result) {
                var RxListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL") {
                        result = JSON.parse(result);
                        RxListData = result.Table;
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                FilterRxDataChemoPlanning(RxListData, FilterRxCode, HistoryObj);
                stopLoading("loading-Rx-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Rx-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }


    function FilterRxDataChemoPlanning(RxListData, RxCode, HistoryObj) {
        //
        var FilterRxList = RxListData;
        if (RxCode != "") {
            FilterRxList = RxListData.filter(item => (GeneralWiseYN == "Y" ? (item.GENERICID == RxCode) : (item.CODE == RxCode)));
        }
        BindSearchListForRxChemoPlanning(FilterRxList);
        if (RxCode && RxCode !== "") {
            var $first = $("#RxListChemoPlanning .Rx-row-chemo-planning").first();
            if ($first.length) {
                $first.trigger("click");
                if (HistoryObj != undefined && HistoryObj != null) {

                    Chemoplantable.updateRow('', {
                        MEDTYPE: 'P', // Need to Verify 
                        CYCLENO: $('#ChemoPlan_txtcurrentCycle').val(),
                        ADMNNO: $('#ChemoPlan_txtcurrentCycle').val(),
                        ONDAY: "",
                        APLYTODAY: "",
                        MEDSETNO: "",
                        GENERICID: Gencode,
                        DRUGFORM: "",
                        GENERICNM: Genname,
                        DOSE: "",
                        CALCULATEON: "",
                        ROUTECD: "",
                        FREQUENCY: "",
                        DILNTGENCD: "",
                        DILUENT: "",
                        DURATION: "",
                        OMITDRUG: "",
                        ADMNYN: "",
                        REMARKS: "",
                        ORIGINALDOSE: "",
                        ADMNSTATUS: "",
                        DOCTCODE: "",
                    })
                }
            }
        }
    }

    // Added by Dhananjay 20260310 Ends

    //Chemotherapy Protocol Add
    function ContentForAddNewItemChemoProtocolSetup() {
        return `
    <div class="row mb-3">
        <div class="col-md-12">
            <input id="txtProtocolSetupNameCode" type="hidden" />
            <label class="form-label">Name</label>
            <input id="txtProtocolSetupName"
                   type="text"
                   class="form-control SetupName"
                   maxlength="250"
                   autocomplete="off"
                   placeholder="Enter Protocol" value="${SearchValue}" />
        </div>
    </div>

    <div class="row mb-3">
        <div class="col-md-12">
            <label class="form-label">Protocol</label>
            <textarea id="txtProtocol"
                      class="form-control"
                      rows="5"
                      maxlength="4000"></textarea>
        </div>
    </div>

    <div class="row mb-3" style="display:none;">
        <div class="col-md-12">
            <label class="form-label">Type</label><br />
            <label class="me-3">
                <input type="radio" name="rdType" value="S" />
                Structured
            </label>

            <label>
                <input type="radio" name="rdType" value="U" checked />
                Un-structured
            </label>
        </div>
    </div>
    <div class="row mb-3">
    <div class="col-md-12">
        <div class="d-flex align-items-center">
            <label class="form-label mb-0 me-3" style="min-width:240px;">
                Duration (for each cycle) Day(s)
            </label>

<input type="text"
       id="txtDuration"
       class="form-control Mandatory"
       maxlength="2"
       inputmode="numeric"
       pattern="[0-9]*"
       oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 2);"
       style="width:70px;" />

        </div>
    </div>
</div>

<div class="row mb-3">
    <div class="col-md-12">
        <div class="d-flex align-items-center">
            <label class="form-label mb-0 me-3" style="min-width:240px;">
                Admission Required
            </label>

            <label class="me-4 mb-0">
                <input type="radio"
                       name="rdAdmissionReq"
                       id="AdmissionReqY"
                       value="Y"
                       onchange="hideAdmissionTable()"/>
                Yes
            </label>

            <label class="mb-0">
                <input type="radio"
                       name="rdAdmissionReq"
                       id="AdmissionReqN"
                       value="N"
                       checked
                       onchange="hideAdmissionTable()"/>
                No
            </label>
        </div>
    </div>
</div>

<div class="row mb-3">
    <div class="col-md-12">
        <div class="d-flex align-items-center">
            <label class="form-label mb-0 me-3" style="min-width:240px;" id="addmissionNo">
                No. of Admissions
            </label>

<input type="text"
       id="txtNoOfAdmissions"
       class="form-control Mandatory"
       maxlength="2"
       inputmode="numeric"
       pattern="[0-9]*"
       oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 2);"
       onchange="GenerateAdmissionRows();"
       style="width:70px;" />

        </div>
    </div>
</div>

    <div class="row mt-3" id="divAdmissionsTable" style="display:none;">
    <div class="col-md-12">
        <div id="AdmissionGrid"></div>
    </div>
</div>

    <div class="row mt-3">
        <div class="col-md-12">
            <div id="ChemoProtocolSetupNew"></div>
        </div>
    </div>
`;
    }

    function FooterContentForAddNewItemChemoProtocolSetup() {
        return `
        <button class="btn btn-primary"
                onclick="SaveAction('')">
            Save
        </button>
    `;
    }

    function BindAdmissionGrid() {

        AdmissionTable = new Tabulator("#AdmissionGrid", {
            layout: "fitColumns",
          //  height: "250px",
            reactiveData: true,

            columns: [
                {
                    title: "Code",
                    field: "CODE",
                    visible: false
                },
                {
                    title: "Admission",
                    field: "ADMISSIONSET",
                    width: 120
                },
                {
                    title: "Day(s)",
                    field: "ADMISSIONDAYS",
                    editor: "input",
                    cellEdited: ValidateAdmissionDays
                },
                {
                    title: "Duration",
                    field: "DURATION",
                    editor: "list",
                    editable: function (cell) {

                        var val = cell.getRow().getData().ADMISSIONDAYS;

                        if (!val)
                            return true;

                        var arr = val.split(',')
                            .filter(x => x.trim() != '');

                        return arr.length <= 1;
                    },
                    editorParams: {
                        values: getDuration()
                    }
                }
            ]
        });
    }

    function GenerateAdmissionRows() {
        var count = parseInt($("#txtNoOfAdmissions").val()) || 0;

        if (count <= 0) {
            $("#divAdmissionsTable").hide();

            if (AdmissionTable)
                AdmissionTable.clearData();

            return;
        }

        $("#divAdmissionsTable").show();

        var data = [];

        for (var i = 1; i <= count; i++) {

            data.push({
                CODE: "",
                ADMISSIONSET: i,
                ADMISSIONDAYS: "",
                DURATION: ""
            });

        }

        AdmissionTable.setData(data);
    }

    function ValidateAdmissionDays(cell) {

        var value = (cell.getValue() || "").trim();

        if (!/^[\d,]*$/.test(value)) {
            ToastMsg("Only numbers and commas are allowed.", "info");
            cell.setValue(value.replace(/[^\d,]/g, ''), true);
            return;
        }

        var values = value.split(',')
            .map(x => parseInt(x.trim()))
            .filter(x => !isNaN(x));

        // Duplicate in same row
        if (new Set(values).size != values.length) {
            ToastMsg("Duplicate days are not allowed in the same row.", "info");
            cell.setValue("", true);
            return;
        }

        // Sequential
        for (var i = 1; i < values.length; i++) {

            if (values[i] != values[i - 1] + 1) {

                ToastMsg("Please enter days in sequential order (e.g., 1,2,3).", "info");
                cell.setValue("", true);
                return;
            }
        }

        // Duplicate across rows
        var duplicate = false;

        AdmissionTable.getRows().forEach(function (row) {

            if (row == cell.getRow())
                return;

            var other = row.getData().ADMISSIONDAYS;

            if (!other)
                return;

            var arr = other.split(',')
                .map(x => parseInt(x.trim()))
                .filter(x => !isNaN(x));

            if (values.some(x => arr.includes(x)))
                duplicate = true;

        });

        if (duplicate) {
            ToastMsg("One or more of these day numbers already exist in another row.", "info");
            cell.setValue("", true);
            return;
        }

        // Max duration validation
        var maxDays = parseInt($("#txtDuration").val()) || 0;

        if (values.some(x => x > maxDays)) {

            ToastMsg("Days cannot be entered more than " + maxDays, "info");
            cell.setValue("", true);
            return;
        }

        // Duration logic
        var row = cell.getRow();

        if (values.length > 1) {

            row.update({
                DURATION: "NA"
            });

        } else {

            if (row.getData().DURATION == "NA") {
                row.update({
                    DURATION: ""
                });
            }
        }
        row.reformat();
    }

    function NewChemotherapyValidate() {

    var l_blFocus = false;

    var admissionReq = $("input[name='rdAdmissionReq']:checked").val();

    if (admissionReq === "Y" && $("#txtNoOfAdmissions").val().trim().length === 0) {
        $("#txtNoOfAdmissions").css("border-color", "Red");

        if (!l_blFocus) {
            $("#txtNoOfAdmissions").focus();
            l_blFocus = true;
        }
    } else {
        $("#txtNoOfAdmissions").css("border-color", "");
    }

    if ($("#txtDuration").val().trim().length === 0) {
        $("#txtDuration").css("border-color", "Red");

        if (!l_blFocus) {
            $("#txtDuration").focus();
            l_blFocus = true;
        }
    } else {
        $("#txtDuration").css("border-color", "");
    }

    return !l_blFocus;
}
    function SaveAction() {
        if (NewChemotherapyValidate()) {
            if ($('#txtProtocolSetupName').val() == "") {
                ToastMsg("Please Enter Protocol Name.", "error");
                return;
            }
            if ($('#txtProtocol').val() == "") {
                ToastMsg("Please Enter Protocol.", "error");
                return;
            }
            var Protocol, Days, AdmissionYN, AdmissionNO = "";
            ProtoName = $('#txtProtocolSetupName').val();
            Protocol = $('#txtProtocol').val();
            Days = $("#txtDuration").val();
            AdmissionYN = $("#AdmissionReqY").prop("checked") == true ? "Y" : "N";
            AdmissionNO = $("#txtNoOfAdmissions").val();

            var AdmnDet = [];

            AdmissionTable.getData().forEach(function (row) {
                AdmnDet.push({
                    ADMISSIONSET: row.ADMISSIONSET,
                    ADMISSIONDAYS: row.ADMISSIONDAYS,
                    DURATION: row.DURATION
                });
            });

            var sendData = {
                AdmnDet: JSON.stringify(AdmnDet),
                Name: ProtoName,
                Protocol: Protocol,
                Days: Days,
                AdmissionYN: AdmissionYN,
                AdmissionNo: AdmissionNO,
                ProtocolType: "U"
            };
            $.ajax({
                type: "POST",
                url: '../SinglePage/SaveChemoPrMaster',
                data: sendData,
                dataType: "json",
                success: function (response) {
                    ToastMsg(response, "info");
                    if (response.toString().toUpperCase().includes("SUCCESS")) {
                        closeAddNewItemPopup('ChemotherapyProtocol');
                        UpdatedChemoProtocolList(ProtoName);
                    }
                },
                error: function (xhr, status, error) {
                    console.log(xhr.responseText);
                    ToastMsg(error, "error");
                }
            });
        }
    }

    function UpdatedChemoProtocolList(ProtoName) {
        $.ajax({
            type: "GET",
            url: '../SinglePage/ChemoProtocolList',
            dataType: "json",
            success: function (response) {
                console.log(response);
                var $ddl = $("#ddlChemoPlanTName");
                $ddl.empty();
                $ddl.append($("<option>", {
                    value: "",
                    text: "---Select---"
                }));
                $.each(response, function (i, item) {
                    $ddl.append($("<option>", {
                        value: item.Value,
                        text: item.Text
                    }));
                });
                var matched = false;

                $ddl.find("option").each(function () {
                    if ($(this).text().trim().toLowerCase() === ProtoName.trim().toLowerCase()) {
                        $(this).prop("selected", true);
                        matched = true;
                        return false;
                    }
                });
                $ddl.trigger("change");
            },
            error: function (xhr, status, error) {
                ToastMsg(error, "error");
            }
        });  
    }
    
    function getDuration() {
        var dropdownOptions = { "": "----Select-----" };


        $.each(HrsLst, function (index, item) {
            dropdownOptions[item.Value] = item.Text;
        });

        return dropdownOptions;
    }
    function SaveForIPDChemoPlanning() {
        if (ValidationForChemoPlanning() == true) {
            SaveForChemoPlanning();
        }
    }
    function closeChemoPlan() {
        $("#chemoPlanningContainer").hide();
    }
    function hideAdmissionTable() {
        var selectedValue = $("input[name='rdAdmissionReq']:checked").val();
        if (selectedValue === "N") {
            $("#addmissionNo").hide();
            $("#txtNoOfAdmissions").val("").hide();
            $("#divAdmissionsTable").hide();
        } else {
            $("#addmissionNo").show();
            $("#txtNoOfAdmissions").show();
        }
    }
    function applyStickyHeader(moduleFlag) {
        if (moduleFlag === 'IPD') {
            $(".ipdChemoPlan").addClass("make-sticky");
        } else {
            $(".ipdChemoPlan").removeClass("make-sticky");
        }
    }


    function ChemoautoResize(textarea) {
        textarea.style.height = "auto";              // Reset height
        textarea.style.height = textarea.scrollHeight + "px"; // Set to content height
    }

    function ValidationForCycle() {
        var CompCyc = $("#ChemoPlan_txtCompleteCycle").val();
        var TotCyc = $("#ChemoPlan_txtCycles").val();
        var CurCyc = $("#ChemoPlan_txtcurrentCycle").val();
        if (Number(CompCyc) >= Number(TotCyc)) {
            ToastMsg("Completed Cycle(s) should not greater than Total Cycle(s)", "warning");
            return false;
        }
        if (Number(TotCyc) <= Number(CompCyc)) {
            ToastMsg("Total Cycle(s) should not lesser than Completed Cycle(s)", "warning");
            return false;
        }
        return true;
    }

    function CycleCalCurrent() {
        if (ValidationForCycle() == true) {
            var CompCyc = $("#ChemoPlan_txtCompleteCycle").val();
            var CurCycle = (Number(CompCyc) + 1);
            $("#ChemoPlan_txtcurrentCycle").val(CurCycle);

            Chemoplantable.getRows().forEach(function (row) {
                row.update({ CYCLENO: CurCycle });
            });
        }
    }

</script>

    <div id="ChemoPlanningOverlay"></div>
    <div class="d-flex justify-content-between align-items-center mb-3 ipdChemoPlan">
        <!-- Section Title -->
        <h4 class="section-title me-5">Chemo Planning</h4>

        <!-- Planning No Container -->
        <div class="d-flex align-items-center gap-2">
            <!-- Planning Save CheckBox-->
            <div id="ChemoPlan_DivChkSavePlan">
                <input type="checkbox" class="Chkbox" onclick="EnDisAllChemoField('Y')" id="ChkSaveChemoPlan" style="vertical-align: middle;">
                <label for="ChemoPlan_txtPlanNo" class="fw-bold mb-0 text-dark" id="PlanningType"></label>
                <%--Enable Planning--%>  <%--Modified by Pournima 16th june 2026--%>
            </div>
            <div class="bg-light border rounded px-3 py-1 shadow-sm align-items-center gap-2" id="ChemoPlan_PlanningNoDivId">
                <label for="ChemoPlan_txtPlanNo" class="fw-bold mb-0 text-dark">
                    Planning No.:
                </label>
                <span id="ChemoPlan_txtPlanNo" class="fw-bold text-primary">
                    <!-- Planning number goes here -->
                </span>
                <input type="hidden" id="ChemoPlan_isEditYN" value="" />
            </div>

            <!-- History Button -->
            <button class="btn btn-outline-success btn-sm" id="ChemoPlanning_PrevHistory"
                onclick="HistoryPopupOpen('Chemo Planning History', 'ChemoPlanningHist', true)">
                <i class="fa fa-history"></i>
            </button>

            <!-- Print Button -->
            <div id="ChemoPlan_DivPrintBtn">
                <button class="btn btn-save-draft btn-sm me-2" id="ChemoPlan_btnPrint" style="display: none" onclick="PrintChemo();">Print</button>
                <%--Added By Abhishesh || 20260720--%>
                <label id="lblatterhead" style="margin-left: 25px; display: none">Print With LetterHead</label>
                <input type="checkbox" id="chkheader" style="margin-left: 9px; margin-right: 20px; display: none">
                <%--End--%>
            </div>
            <div id="ChemoPlan_SaveIPDBtn">
                <button class="btn btn-save-draft btn-sm me-2" id="ChemoPlan_btnSaveChemoIPD" style="display: none" onclick="SaveForIPDChemoPlanning();">Save</button>
            </div>
            <div id="ChemoPlan_CloseIPDBtn">
                 <button  class="btn btn-save-draft btn-sm me-2" id="ChemoPlan_btnCloseChemoIPD" style="display: none" onclick="closeChemoPlan();" data-dismiss="modal">&times;</button>
            </div>
        </div>
    </div>


    <div class="d-flex flex-wrap gap-3 mb-3 CompleteDisable">
        <!--Hidden Fields-->
        <input type="text" hidden="hidden" id="ChemoPlan_txtWeight" value="0" />
        <input type="text" hidden="hidden" id="ChemoPlan_txtHeight" value="0" />
        <input type="text" hidden="hidden" id="ChemoPlan_txtBSA" value="" />
        <input type="text" hidden="hidden" id="ChemoPlan_txtTstage" value="0" />
        <input type="text" hidden="hidden" id="ChemoPlan_txtNstage" value="0" />
        <input type="text" hidden="hidden" id="ChemoPlan_txtMstage" value="0" />
        <input type="text" hidden="hidden" id="ChemoPlan_txtTRANID" value="" />
        <!-- Dropdowns -->
        <div class="d-flex flex-column">
            <label class="fw-medium">Chemotherapy Course</label>
            <select class="form-select form-select-sm ddl_ChemoCourse" id="ddlChemoPlanTCourse">
                <% if (Model != null && Model.ChemoPlanLstCourse != null)
                    { %>
                <option value="">---Select---</option>
                <% foreach (var item in Model.ChemoPlanLstCourse)
                    { %>
                <option value="<%= item.Value %>"><%= item.Text %></option>
                <% } %>
                <% } %>
            </select>
        </div>

        <div class="d-flex flex-column">
            <label class="fw-medium">Intent Of The Treatment</label>
            <select class="form-select form-select-sm ddl_ChemoTreatmentPlan" id="ddlChemoPlanTreatmentPlan">
                <% if (Model != null && Model.ChemoPlanLstTreatPlan != null)
                    { %>
                <option value="">---Select---</option>
                <% foreach (var item in Model.ChemoPlanLstTreatPlan)
                    { %>
                <option value="<%= item.Value %>"><%= item.Text %></option>
                <% } %>
                <% } %>
            </select>
        </div>

        <div class="d-flex flex-column flex-grow-1">
            <label class="fw-medium">Chemotherapy Name/Protocol</label>
            <select class="form-select form-select-sm ddl_ChemoPlanTherapyName" id="ddlChemoPlanTName">
                <% if (Model != null && Model.ChemoPlanLstChemoName != null)
                    { %>
                <option value="">---Select---</option>
                <% foreach (var item in Model.ChemoPlanLstChemoName)
                    { %>
                <option value="<%= item.Value %>"><%= item.Text %></option>
                <% } %>
                <% } %>
            </select>
        </div>
        <div class="d-flex flex-column d-none" style="margin-top: 17px;">
            <button class="btn btn-outline-success" id="ChemoProtocolAdd" onclick="OpenPopupForNewItem('Chemotherapy Protocol' , 'ChemotherapyProtocol')"><i class="fa fa-plus"></i></button>
        </div>
    </div>

    <!-- Input fields -->
    <div class="d-flex flex-wrap gap-3 mb-3 mt-4 CompleteDisable">
        <div class="d-flex flex-column" style="width: auto; min-width: 120px; white-space: nowrap;">
            <label class="fw-medium text-truncate" style="white-space: nowrap;">Duration Of Each Cycle</label>
            <input type="number" class="form-control form-control-sm" id="ChemoPlan_txtDurationDays" readonly value="" style="background-color: #e9ecef; cursor: not-allowed;"><%-- priyanka 07/03/2026--%>
        </div>

        <div class="d-flex flex-column" style="width: auto; min-width: 150px; white-space: nowrap;">
            <label class="fw-medium text-truncate" style="white-space: nowrap;">Total Number Of Cycle(s)</label>
            <input type="number" class="form-control form-control-sm" id="ChemoPlan_txtCycles" value="" min="0" onblur="CycleCalCurrent()">
        </div>

        <div class="d-flex flex-column" style="width: auto; min-width: 150px; white-space: nowrap;">
            <label class="fw-medium text-truncate" style="white-space: nowrap;">To Repeat After Day(s)</label>
            <input type="number" class="form-control form-control-sm" id="ChemoPlan_txtRepeatAfter" value="">
        </div>

        <div class="d-flex flex-column" style="width: auto; min-width: 120px; white-space: nowrap;">
            <label class="fw-medium text-truncate" style="white-space: nowrap;">Completed Cycle(s)</label>
            <input type="number" class="form-control form-control-sm" id="ChemoPlan_txtCompleteCycle" value="" min="0" onblur="CycleCalCurrent()">
        </div>

        <div class="d-flex flex-column" style="width: auto; min-width: 120px; white-space: nowrap;">
            <label class="fw-medium text-truncate" style="white-space: nowrap;">Current Cycle</label>
            <input type="number" class="form-control form-control-sm" id="ChemoPlan_txtcurrentCycle" readonly value="1" style="background-color: #e9ecef; cursor: not-allowed;">
        </div>

        <div class="d-flex flex-column" style="width: auto; min-width: 120px; white-space: nowrap;">
            <label class="fw-medium text-truncate" style="white-space: nowrap;">Chemo Start Date</label>
            <input type="text" class="form-control form-control-sm date_Filter" id="ChemoStartDt" readonly>
        </div>

        <div id="AllowChemoFreeText" class="flex-column" style="margin-top: auto; display: none;">
            <input type="checkbox" id="ChemoPlan_Freetext" name="Structure" class="m-0" style="vertical-align: middle;" />
            <label class="fw-medium text-truncate" style="white-space: nowrap; vertical-align: middle;">Enable Free Text</label>
        </div>
    </div>

    <!--
     <div class="d-flex flex-wrap gap-3 mb-3 mt-4 CompleteDisable">
        <textarea class="form-control TextAreaBorder mb-2" id="ChemoPlanning_txtChemoTextArea" name="ChemoPlanning_txtChemoTextArea" placeholder="Enter Chemo Planning" oninput="autoResizeTextareaForSinglePage(this)"
            style="overflow-y: auto; resize: none;display:none" maxlength="1000"></textarea>
    </div>
     -->
     <div class="d-flex flex-wrap gap-3 mb-3 mt-4 CompleteDisable">
       <textarea class="form-control TextAreaBorder mb-2" id="ChemoPlanning_txtChemoTextArea"
       name="ChemoPlanning_txtChemoTextArea" placeholder="Enter Chemo Planning"
       oninput="autoResizeChemoProtocolTextarea(this)"
       style="overflow-y:hidden; height:auto; resize:none; display:none"
       ></textarea>
    </div>

    <!-- Dose Calculation -->
    <div class="align-items-center w-100 gap-3 mb-2 " id="ChemoPlan_DivDoseCal">
        <%-- removed class d-flex --%>
        <div class="d-flex align-items-center gap-2 CompleteDisable">
            <input type="checkbox" id="ChemoPlan_chkStructure" name="Structure" class="m-0" />
            <label for="ChemoPlan_chkStructure" class="fw-medium m-0">Dose Calculation</label>
        </div>

        <%-- Search | Added by Dhananjay 20260310  --%>
        <div class="input-group input-group-sm w-100 position-relative">

            <div class="d-flex w-100">

                <input type="text" id="RxSearchChemoPlanning" style="display: none;" class="form-control" placeholder="Search Rx" onclick="GetFrequentRxChemoPlanning()" oninput="FilterBindedSearchListForRxChemoPlanning()">

                <%--this div i want full right side--%>
                <div style="display: flex; width: 160px; margin-left: auto;">

                    <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("I"))
                        { %>

                    <button class="btn btn-outline-success" id="btnInformantChemoPlaning"
                        title="Drug Interaction"
                        style="float: right; margin-left: 5px; margin-right: 6px; display: none; padding: 5px; background: none !important;"
                        onclick="subscribeCIMSServices('I',Chemoplantable,'ChemoPlanningTable')">
                        <%--<img src="../Images/CIMS_Images/DrugInteraction.png" style="height: 20px; width: 20px;">--%>
                        <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                            <rect x="34" y="1.48619e-06" width="34" height="34" rx="4" transform="rotate(90 34 1.48619e-06)" fill="gray" />
                            <path d="M21.25 22.3125L21.25 28.6875L27.625 28.6875" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M21.2502 28.6875L25.0062 24.9316C27.1812 22.7564 28.4111 19.8115 28.429 16.7354C28.4469 13.6594 27.2514 10.7003 25.1018 8.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M12.75 11.6875L12.75 5.3125L6.375 5.3125" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M12.75 5.3125L8.99406 9.06844C6.81899 11.2436 5.58913 14.1886 5.57123 17.2646C5.55333 20.3406 6.74883 23.2997 8.89844 25.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>

                    <% } %>

                    <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("D"))
                        { %>

                    <button class="btn btn-outline-success" id="btnDuplicateChemoPlaning"
                        title="Drug Duplicate"
                        style="float: right; margin-right: 6px; display: none; padding: 5px; background: none !important;"
                        onclick="subscribeCIMSServices('D',Chemoplantable,'ChemoPlanningTable')">
                        <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                        <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                            <rect width="34" height="34" rx="4" fill="gray" />
                            <path d="M8.78261 10.9345V27.7606H22.087V14.8476L19.7391 10.781H8" stroke="white" stroke-width="1.56522" />
                            <path d="M11.9131 10.5434V6.23901H21.6957L26 10.5434V24.239H22.4783" stroke="white" stroke-width="1.56522" />
                            <path d="M16.0103 17.395L12.8951 20.5102C12.3528 21.0525 12.3528 21.9319 12.8951 22.4742L12.8953 22.4744C13.4377 23.0168 14.317 23.0168 14.8594 22.4744L17.9745 19.3593C18.5169 18.8169 18.5169 17.9376 17.9745 17.3952L17.9743 17.395C17.432 16.8527 16.5526 16.8527 16.0103 17.395Z" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M14.4526 18.9525L16.4169 20.9168" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M16.417 19.443L17.1536 18.7064" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </button>

                    <% } %>

                    <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("A"))
                        { %>

                    <button class="btn btn-outline-success" id="btnAllergyChemoPlaning"
                        title="Drug Allergy"
                        style="float: right; margin-right: 6px; display: none; padding: 5px; background: none !important;"
                        onclick="subscribeCIMSServices('A',Chemoplantable,'ChemoPlanningTable')">
                        <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 200 200" fill="none">
                            <rect width="200" height="200" rx="8" fill="gray" />
                            <path d="M138.5 174.5L103.686 139.686C100.686 136.686 96.616 135 92.3726 135H80.0342C76.7572 135 73.5593 133.994 70.8728 132.117L47.1549 115.553C44.8646 113.953 43.5 111.336 43.5 108.542V108.293C43.5 106.185 44.3377 104.162 45.8287 102.671C46.9193 101.581 48.3036 100.831 49.8128 100.513L50.9598 100.272C54.7468 99.4744 58.6849 100.569 61.5167 103.207L66.125 107.5L30.3385 70.4228C28.8384 68.8686 28 66.7928 28 64.6327C28 62.6132 28.733 60.6623 30.0629 59.1424L30.8934 58.1933C31.2972 57.7318 31.7366 57.3028 32.2077 56.9103L34.5 55C35.3766 54.4156 36.5413 54.5181 37.3024 55.2465L71 87.5L34.1423 50.1758C32.5068 48.5195 31.877 46.1176 32.4895 43.872C32.8226 42.6504 33.5039 41.5521 34.4502 40.7109L36.3999 38.9779C37.1226 38.3355 37.9899 37.8775 38.928 37.643C40.5661 37.2335 42.301 37.534 43.7059 38.4706L47.5 41M47.5 41L80 74M47.5 41L50.2581 38.2419C51.0835 37.4165 51.9969 36.6838 52.9818 36.0571L55.0563 34.7369C56.3257 33.9291 57.7992 33.5 59.3039 33.5C61.3541 33.5 63.3243 34.2959 64.7993 35.72L66.125 37M91.5 61.5L66.125 37M66.125 37L67.2143 34.9667C67.7363 33.9923 68.371 33.0826 69.1054 32.2564L70.0878 31.1512C71.3336 29.7497 72.9732 28.7567 74.7923 28.3019C78.0158 27.4961 81.4245 28.4677 83.7387 30.852L96.5 44M111.5 59.5L123.845 71.4339C125.592 73.1224 126.931 75.1866 127.762 77.4698L129.537 82.3509C130.174 84.1035 130.5 85.954 130.5 87.8188V96.8726C130.5 101.116 132.186 105.186 135.186 108.186L164 137" stroke="white" stroke-width="7" stroke-linecap="round" />
                            <circle cx="104.5" cy="51.5" r="4" fill="white" stroke="white" />
                            <circle cx="83.5" cy="90.5" r="3" fill="white" stroke="white" />
                            <circle cx="87.5" cy="113.5" r="8" fill="white" stroke="white" />
                            <circle cx="103.5" cy="81.5" r="8" fill="white" stroke="white" />
                            <circle cx="116" cy="106" r="2.5" fill="white" stroke="white" />
                            <circle cx="112" cy="127" r="2.5" fill="white" stroke="white" />
                            <circle cx="135" cy="130" r="6.5" fill="white" stroke="white" />
                            <circle cx="156.5" cy="164.5" r="7" fill="white" stroke="white" />
                            <circle cx="139" cy="152" r="2.5" fill="white" stroke="white" />
                            <circle cx="172" cy="145" r="2.5" fill="white" stroke="white" />
                        </svg>
                    </button>

                    <% } %>
                </div>

            </div>


            <div id="RxListMainDivChemoPlanning" class="list-group position-absolute w-50" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc; top: 30px;">
                <div id="RxListChemoPlanning" class="list-group w-100"></div>
                <div id='loading-Rx-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>

        </div>



    </div>

    <!-- Omit Indicator -->
    <div id="ChemoPlan_DivOmitIndicator" class="d-none d-flex align-items-center justify-content-end gap-2 w-100 p-1">
        <%--<div id="ChemoPlan_DivOmitIndicator" class="d-flex align-items-center justify-content-end gap-2 w-100 p-1">--%>
        <span class="border d-inline-block omit-box"></span>
        <label class="mb-0 fw-medium">Omitted</label>
    </div>


    <!-- Chemo Planning Table -->
    <div id="ChemoPlanning-Chemoplantable" class="mb-3"></div>

    <!-- Modification -->
    <h6 class="fw-bold">Modification During Treatment</h6>
    <textarea class="form-control TextAreaBorder CompleteDisableEntry" id="ChemoPlanning_Freetext" name="ChemoPlanning_Freetext" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none;"></textarea>

    <div class=" align-items-start gap-4" id="ChemoConclusionRow">


        <div class="d-flex align-items-start mb-2" style="column-gap: 100px;">


            <!-- Treatment Done Conclusion -->
            <div id="ChemoPlan_TreatConStatus" class="d-flex flex-column">
                <label class="mb-1">🧾 Treatment Done Conclusion</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio"
                            name="ChemoPlan_Conclusion"
                            id="ChemoPlan_rbtnY" value="Y">
                        <label class="form-check-label fw-bold text-success"
                            for="ChemoPlan_rbtnY">
                            Yes</label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio"
                            name="ChemoPlan_Conclusion"
                            id="ChemoPlan_rbtnN" value="N">
                        <label class="form-check-label fw-bold text-danger"
                            for="ChemoPlan_rbtnN">
                            No</label>
                    </div>
                </div>


            </div>

            <!-- Conclusion Status -->
            <div id="ChemoPlan_ConStatus" class="d-flex flex-column" style="min-width: 220px;">
                <label id="ChemoPlan_lblPlanned">📊 Conclusion Status</label>
                <select class="form-select form-select-sm ddl_ChemoPlanConclusionStatus"
                    id="ddlChemoPlanConclStatus">
                    <% if (Model != null && Model.ChemoPlanLstConStatus != null)
                        { %>
                    <option value="">---Select---</option>
                    <% foreach (var item in Model.ChemoPlanLstConStatus)
                        { %>
                    <option value="<%= item.Value %>"><%= item.Text %></option>
                    <% } %>
                    <% } %>
                </select>
            </div>
            <div class="d-flex flex-column" id="divChemoPlan_ConRemark" style="width: 400px;">
                <label id="ChemoPlan_lblPlannedRemarks">Conclusion Remarks</label>
                <input type="text" id="ConclusionRemark" class="form-control TextAreaBorder" placeholder="Enter Remark..">
            </div>
            <!-- Treatment Complete Date -->
            <div id="ChemoPlan_divCompleteDate" class="d-flex flex-column flex-grow-1">
                <label for="ChemoPlan_txtTreatComplete">📅 Treatment Complete Date</label>
                <input type="text" class="form-control form-control-sm date_Filter" id="ChemoPlan_txtTreatComplete" style="background-color: white; width: 210px;">
            </div>

        </div>

    </div>

    <div id='loading-ChemoPlan-Section' class='loading-screen' style='display: none; opacity: 0;'></div>
