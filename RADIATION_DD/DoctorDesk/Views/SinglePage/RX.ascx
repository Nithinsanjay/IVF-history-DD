<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style>
    .tabulator-row .tabulator-cell.tabulator-row-handle .tabulator-row-handle-box{
        width:16px;
    }
</style>

<script type="text/javascript">
    <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var RXRemarkList = '<%:Html.Raw(Samp.Serialize(ViewBag.RXRemarkArray))%>';
<%--    var RXMedRouteList = '<%:Html.Raw(Samp.Serialize(ViewBag.RXMedRoute))%>';--%>
    var RXMedIntakeList = '<%:Html.Raw(Samp.Serialize(ViewBag.RXIntake))%>';
    var RxListtable;
    var rowNoFrMedTaper = 0;
    var RMOFlagRXYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVERXYN")%>' == "Y" ? "N" : "Y") : "N";
    var SessionCompRX = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagRXYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');
    var ShowRXSetup = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("SHOWRXSETUP")%>';
    $(document).ready(function () {
        if ('<%: Session["RMOYN"] ?? "" %>' != "Y" && sessionStorage.getItem('PatCompleted') != "Y" && ShowRXSetup == "Y") {
            $("#RX_Setup").removeClass("d-none");
        }

        /* Tabulator For Rx */
        RxListtable = new Tabulator("#RxTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "50",
            index: "DrugCode",
            movableRows: true,
            scrollToColumnIfVisible: false,
            variableHeight: true,
            rowHeader: {
                headerSort: false,
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    rowHandle: true,
                    formatter: "handle",
                    headerSort: false,
                    frozen: true,
                    width: 20,
                    hozAlign: "center"
                },
                {
                    title: "CIMS INFO",
                    field: "CIMS",
                    width: 75,
                    frozen: true,
                    headerSort: false,
                    visible: IS_DISPLAY_CIMS_FUNCTIONLITY ? IS_DISPLAY_CIMS_FUNCTIONLITY == "Y" : false,
                    hozAlign: "center",
                    formatter: function (cell) {
                        return "<i class='fa fa-info-circle' Title='CIMS Information' style='color:#2d70aa;font-size:20px;cursor:pointer'></i>";
                    },
                    cellClick: function (e, cell) {
                        if (!$(e.target).hasClass("fa fa-info-circle")) return;
                        var rowData = cell.getRow().getData();
                        var drugCode = rowData.DrugCode;
                        if (drugCode) {
                            getDrugInfo(drugCode);
                        }
                    }
                },
                {
                    headerSort: false,
                    title: "Action",
                    field: "act",
                    width: 80,
                    frozen: true,
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },
                    formatter: function (cell) {
                        if (typeof SessionCompRX !== 'undefined' && SessionCompRX === "Y") {
                            return "";
                        }
                        return '<i class="fa fa-trash text-danger delete-row" title="Delete Medicine"></i>' +
                            '<i class="fa fa-plus text-primary Add-row-Next-Date" title="Add Medicine For Next Date" style="cursor:pointer; margin-left:8px"></i>';
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y") {
                            var row = cell.getRow();
                            var data = row.getData();
                            if ($(e.target).hasClass("Add-row-Next-Date")) {
                                var newData = JSON.parse(JSON.stringify(data));
                                var MedDate = newData.MedDate;
                                var dt = luxon.DateTime.fromFormat(MedDate, "dd/MM/yyyy");
                                var nextDt = dt.plus({ days: 1 });
                                var NextDate = nextDt.toFormat("dd/MM/yyyy");
                                newData.MedDate = NextDate;
                                newData.TAMPERING = "Y";
                                row.getTable().addRow(newData, false, row).then(function (newRow) {
                                    newRow.normalizeHeight();
                                    adjustTableHeight("RxTable");
                                });
                            }

                            if ($(e.target).hasClass("delete-row")) {
                                if (data.PHSTATUS != "A") {
                                    ToastMsg('This medicine is already issued to the patient from pharmacy', "warning");
                                }
                                else {
                                    row.delete();
                                }
                            }
                        }

                    }
                },
                {
                    title: "Material Name",
                    field: "MaterialName",
                    editor: false,
                    width: 300,
                    frozen: true,
                    cssClass: "wrap-text",
                    visible: GeneralWiseYN == "Y" ? false : true
                },
                {
                    title: "Generic Name",
                    field: "GenericName",
                    editor: false,
                    width: 350,
                    frozen: true,
                    cssClass: "wrap-text",
                    visible: GeneralWiseYN == "Y" ? true : false
                },
                {
                    title: "DrugCode",
                    field: "DrugCode",
                    editor: false,
                    visible: false
                },
                {
                    title: "Generic ID",
                    field: "GenericID",
                    editor: false,
                    width: 300,
                    visible: false
                },
                //{
                //    title: "Drug Form",
                //    field: "FORMNAME",
                //    editor: false,
                //    width: 150,
                //    visible: true
                //},  
                {
                    title: "Drug Form",
                    field: "FORMNAME",
                    width: 150,
                    visible: true,
                    editor: "list",
                    editable: function (cell) {
                        var row = cell.getRow().getData();                 //Added by aaryshree 20260624
                        return row.IsNewRxAdded === true;
                    },
                    editorParams: function () {
                        return {
                            values: getDrugFormDropdown()
                        };
                    },
                    cellEdited: function (cell) {

                        var code = cell.getValue();

                        var RTList = JSON.parse(FormLinkRouteList || "[]");

                        var found = RTList.find(x => x.FORMCODE == code);
                        const routeList = RxGetRouteList("N", found.FORMCODE);

                        let selectedRoute = "";

                        if (routeList.length === 1) {
                            selectedRoute = routeList[0].Value;
                        } else {
                            const defaultItem = routeList.find(x => x.DEFAULTYN === "Y");
                            selectedRoute = defaultItem ? defaultItem.Value : "";
                        }
                        //if (found) {
                        //    cell.getRow().update({
                        //        FORMCODE: found.FORMCODE,
                        //        FORMNAME: found.FORMNAME,
                        //        Route: selectedRoute
                        //    });
                        //}
                        if (found) {
                            var qty = cell.getRow().getData().Qty;

                            if (found.QTYCALCFLAG == "D") {
                                qty = 1;
                            }
                            else if (found.QTYCALCFLAG == "E") {
                                qty = "";
                            }
                            // C -> keep existing value

                            cell.getRow().update({
                                FORMCODE: found.FORMCODE,
                                FORMNAME: found.FORMNAME,
                                Route: selectedRoute,
                                QTYCALCFLAG: found.QTYCALCFLAG
                            });
                        }
                    }

                },
                {
                    title: "Drug Form Code",
                    field: "FORMCODE",
                    editor: false,
                    width: 150,
                    visible: false
                },
                {
                    title: "For Date",
                    field: "MedDate",
                    sorter: "date",
                    width: 110,
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },
                    editor: function (cell, onRendered, success, cancel) {
                        let dt = luxon.DateTime.fromFormat(cell.getValue(), "dd/MM/yyyy");
                        let input = document.createElement("input");
                        input.type = "date";
                        input.style.padding = "4px";
                        input.style.width = "100%";
                        input.style.boxSizing = "border-box";
                        let today = luxon.DateTime.now().toFormat("yyyy-MM-dd");
                        input.min = today;
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
                    tooltip: true
                },
                {
                    title: "Intake",
                    field: "Intake",
                    editor: "list",
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },
                    headerSort: false,
                    width: 100,
                    editorParams: {
                        values: GetIntakeList("N"),
                        autocomplete: true,  
                        listOnEmpty: true,   
                        allowEmpty: false,
                        //freetext: true
                    },
                    formatter: "lookup",
                    formatterParams: GetIntakeList("N"),
                    titleFormatter: function () {
                        return '<i class="fa fa-plus intake-header-plus" ' +
                            'style="cursor:pointer; margin-left:6px;" title="Add Intake"></i> Intake ';
                    },
                    headerClick: function (e, column) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y") {
                            if ($(e.target).hasClass("intake-header-plus")) {
                                OpenPopupForNewItem('Intake', 'RxIntake');
                            }
                        }

                    }
                },
                {
                    title: "Duration No",
                    field: "DurNum",
                    tooltip: true,
                    width: 140,
                    editor: "list",
                    editorParams: function () {
                        let values = [
                            { label: "", value: "" }
                        ];
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
                        let values = {
                            "": ""
                        };
                        for (let i = 0; i <= 30; i++) {
                            values[i] = i.toString();
                        }
                        return values;
                    }),
                    mutator: function (value) {
                        return value === "" || value == null ? 0 : Number(value);
                    },
                    editable: function (cell) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y") {
                            let intake = cell.getRow().getData().Intake;
                            if (intake == "") {
                                return true;
                            }
                            var IntakeListArry = GetIntakeList("Y");
                            var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == intake; });
                            if (FilterIntakeListArry.length === 0) {
                                return true;
                            }
                            return !(FilterIntakeListArry[0].INTAKE.toUpperCase() === "SOS" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "STAT" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD." || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD");
                        }

                    },
                    cellRendered: function (cell) {
                        let intake = cell.getRow().getData().Intake;
                        if (intake != "") {
                            var IntakeListArry = GetIntakeList("Y");
                            var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == intake; });
                            if (FilterIntakeListArry[0].INTAKE.toUpperCase() === "SOS" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "STAT" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD." || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD") {
                                cell.getElement().style.backgroundColor = "#f0f0f0";
                                cell.getElement().style.color = "#999";
                            }
                        }
                    }
                },
                {
                    title: "Duration Category",
                    field: "DurType",
                    width: 140,
                    tooltip: true,
                    editor: "list",
                    editorParams: function () {
                        let values = [
                            { label: "Days", value: "D" },
                            { label: "Weeks", value: "W" },
                            { label: "Months", value: "M" },
                            { label: "Years", value: "Y" }
                        ];
                        return {
                            values: values,
                            autocomplete: true,   
                            listOnEmpty: true,    
                            allowEmpty: false     
                        };
                    },
                    formatter: "lookup",
                    formatterParams: (function () {
                        return { "D": "Days", "W": "Weeks", "M": "Months", "Y": "Years" };
                    }),
                    editable: function (cell) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y") {
                            let intake = cell.getRow().getData().Intake;
                            if (intake == "") {
                                return true;
                            }
                            var IntakeListArry = GetIntakeList("Y");
                            var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == intake; });
                            if (FilterIntakeListArry.length > 0) { //priyanka 25/06/2026
                                return !(FilterIntakeListArry[0].INTAKE.toUpperCase() === "SOS" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "STAT" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD." || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD");
                            }
                        }
                    },
                    cellRendered: function (cell) {
                        let intake = cell.getRow().getData().Intake;
                        if (intake != "") {
                            var IntakeListArry = GetIntakeList("Y");
                            var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == intake; });
                            if (FilterIntakeListArry[0].INTAKE.toUpperCase() === "SOS" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "STAT" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD." || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD") {
                                cell.getElement().style.backgroundColor = "#f0f0f0";
                                cell.getElement().style.color = "#999";
                            }
                        }
                    }
                },
                {
                    title: "Food",
                    field: "BeforeAfter",
                    tooltip: true,
                    width: 100,
                    editor: "list",
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },

                    editorParams: function () {
                        let values = [
                            { label: "", value: "" },
                            { label: "Before", value: "B" },
                            { label: "After", value: "A" }
                        ];
                        return {
                            values: values,
                            autocomplete: true,    
                            listOnEmpty: true,     
                            allowEmpty: false      
                        };
                    },
                    formatter: "lookup",
                    formatterParams: (function () {
                        return { "": "", "B": "Before", "A": "After" };
                    }),
                },
                {
                    title: "<span style='color:red'>Route</span>",
                    field: "Route",
                    tooltip: true,
                    editor: "list",
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },
                    width: 150,
                    mutator: function (value, data) {

                        // if already value exists then return it
                        if (value) return value;

                        const routeList = RxGetRouteList("N", ("" + data.FORMCODE).trim());

                        // If only one route exists -> bind directly
                        if (routeList.length === 1) {
                            return routeList[0].Value;
                        }

                        // Otherwise bind default route
                        const defaultItem = routeList.find(item => item.DEFAULTYN === "Y");

                        return defaultItem ? defaultItem.Value : "";
                    },
                    editorParams: function (cell) {
                        const rowData = cell.getRow().getData();
                        return {
                            values: RxGetRouteList("Y", ("" + rowData.FORMCODE).trim()),
                            autocomplete: true,
                            listOnEmpty: true,
                            allowEmpty: false
                        };
                    },
                    formatter: "lookup",
                    formatterParams: function (cell) {
                        const rowData = cell.getRow().getData();
                        return RxGetRouteList("Y", ("" + rowData.FORMCODE).trim());
                    }
                },
<%--                {
                    title: "<span style='color:red'>Doses</span>",
                    field: "Dosses",
                    tooltip: true,
                    width: 100,
                    editor: "list",
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },
                    editorParams: {
                        values: GetDossageList(),
                        autocomplete: true,   
                        listOnEmpty: true,    
                        allowEmpty: false,
                        freetext: true
                    },
                    formatter: "lookup",
                    formatterParams: GetDossageList()
                },--%>
                {
                    title: "Doses", //"<span style='color:red'>Doses</span>",
                    field: "Dosses",
                    editor: "input",
                    tooltip: true,
                    width: 80,
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    }
                },
                {
                    title: "<span style='color:red'>Qty</span>",
                    field: "Qty",
                    editor: "number",
                   <%-- editable: function (cell) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y") {
                            let intake = cell.getRow().getData().Intake;
                            if (intake == "") {
                                return true;
                            }
                            var IntakeListArry = GetIntakeList("Y");
                            var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == intake; });
                            if (FilterIntakeListArry.length === 0) {
                                return true;
                            }
                            return !(FilterIntakeListArry[0].INTAKE.toUpperCase() === "SOS" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "STAT" || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD." || FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD");
                        }
                    },--%>

                    editable: function (cell) {

                        var rowData = cell.getRow().getData();

                        // Check Intake first
                        var IntakeListArry = GetIntakeList("Y");
                        var FilterIntakeListArry = IntakeListArry.filter(function (F) {
                            return F.CODE.trim() == rowData.Intake;
                        });

                        if (FilterIntakeListArry.length > 0) {

                            var intake = FilterIntakeListArry[0].INTAKE.toUpperCase();
                            // Commented By Abhishesh || 20261013
                            //if (intake === "SOS" ||
                            //    intake === "STAT" ||
                            //    intake === "CONTD." ||
                            //    intake === "CONTD") {

                            //    // Always keep Qty = 0
                            //    if (Number(rowData.Qty) !== 0) {
                            //        cell.getRow().update({ Qty: 0 });
                            //    }

                            //    return false;
                            //}
                            //End
                        }

                        // Then apply QTYCALCFLAG logic
                        if (rowData.QTYCALCFLAG == "D")
                            return false;

                        if (rowData.QTYCALCFLAG == "E")
                            return true;

                        // Existing permission logic
                        return sessionStorage.getItem("PatCompleted") !== "Y"
                            && '<%: Session["AUTHYN"] ?? "" %>' != "Y"
                           && RMOFlagRXYN != "Y";
                   },

                    <%--editable: function (cell) {
                        var rowData = cell.getRow().getData();
                        if (rowData.QTYCALCFLAG == "D")
                            return false;
                        if (rowData.QTYCALCFLAG == "E")
                            return true;
                        if (sessionStorage.getItem("PatCompleted") !== "Y"
                            && '<%: Session["AUTHYN"] ?? "" %>' != "Y"
                           && RMOFlagRXYN != "Y") {

                           let intake = rowData.Intake;

                           if (intake == "") {
                               return true;
                           }

                           var IntakeListArry = GetIntakeList("Y");
                           var FilterIntakeListArry = IntakeListArry.filter(function (F) {
                               return F.CODE.trim() == intake;
                           });

                           if (FilterIntakeListArry.length === 0) {
                               return true;
                           }

                           return !(
                               FilterIntakeListArry[0].INTAKE.toUpperCase() === "SOS" ||
                               FilterIntakeListArry[0].INTAKE.toUpperCase() === "STAT" ||
                               FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD." ||
                               FilterIntakeListArry[0].INTAKE.toUpperCase() === "CONTD"
                           );
                       }
                       return false;
                   },--%>
                    width: 80,
                    editorParams: {
                        min: 0,
                        elementAttributes: {
                            maxlength: "10",
                        },
                    }
                },
                {
                    headerSort: false,
                    title: "Remark",
                    field: "Remark",
                    editor: "list",
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },
                    width: 350,
                    editorParams: {
                        values: GetRemarkList(),
                        autocomplete: true,   
                        listOnEmpty: true,    
                        allowEmpty: false,
                        freetext: true
                    },
                    formatter: "lookup",
                    formatterParams: GetRemarkList(),
                    titleFormatter: function () {
                        return '<i class="fa fa-plus Remark-header-plus" ' +
                            'style="cursor:pointer; margin-left:6px;" title="Add Remark"></i> Remark';
                    },
                    headerClick: function (e, column) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y") {
                            if ($(e.target).hasClass("Remark-header-plus")) {
                                OpenPopupForNewItem('Remark', 'RxRemark');
                            }
                        }

                    }
                },
                {
                    title: "Routine",
                    field: "ROUTINEYN",
                    width: 100,
                    hozAlign: "center",
                    tooltip: true,
                    editor: true,
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagRXYN != "Y";
                    },
                    formatter: "tickCross",
                    formatterParams: {
                        crossElement: false
                    },
                    visible: ShowroutineFeature == "Y" ? true : false
                },
                {
                    title: "SetUpYn",
                    field: "SetUpYn",
                    editor: false,
                    visible: false
                },
                {
                    title: "RefillYN",
                    field: "RefillYN",
                    editor: false,
                    visible: false
                },
                {
                    title: "PHSTATUS",
                    field: "PHSTATUS",
                    tooltip: true,
                    editor: "input",
                    width: 140,
                    visible: false
                },
                {
                    title: "TAMPERING",
                    field: "TAMPERING",
                    editor: false,
                    visible: false
                },
                {
                    title: "QTYCALCFLAG",
                    field: "QTYCALCFLAG",
                    editor: false,
                    visible: false
                },
            ]
        });

       //RxListtable.on("cellEdited", function (cell) {
       //    if (cell.getColumn().getField() === "Intake" || cell.getColumn().getField() === "DurNum" || cell.getColumn().getField() === "DurType") {
       //        var RowData = cell.getRow().getData();
       //        var IntakeListArry = GetIntakeList("Y");
       //        var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == RowData.Intake; });
       //        if (FilterIntakeListArry.length > 0) {
       //            if (FilterIntakeListArry[0].INTAKE.toUpperCase() == "SOS" || FilterIntakeListArry[0].INTAKE.toUpperCase() == "STAT" || FilterIntakeListArry[0].INTAKE.toUpperCase() == "CONTD." || FilterIntakeListArry[0].INTAKE.toUpperCase() == "CONTD") {
       //                cell.getRow().update({ DurNum: "0", DurType: "D" });
       //            }
       //        }
       //        var tabCountQty = RowData.Qty || 0;
       //        var MultiVal = 0
       //        if (RowData.DurType == "D")
       //            MultiVal = 1
       //        else if (RowData.DurType == "W")
       //            MultiVal = 7
       //        else if (RowData.DurType == "M")
       //            MultiVal = 30
       //        else if (RowData.DurType == "Y")
       //            MultiVal = 365
       //        if (FilterIntakeListArry.length > 0) {
       //            tabCountQty = Number(FilterIntakeListArry[0].TABCOUNT) * (MultiVal * Number(RowData.DurNum));
       //        }
       //        cell.getRow().update({ Qty: tabCountQty });
       //    }
       //    cell.getRow().normalizeHeight();
       //});
        RxListtable.on("cellEdited", function (cell) {

            if (cell.getColumn().getField() === "Intake" || cell.getColumn().getField() === "DurNum" || cell.getColumn().getField() === "DurType") {

                var RowData = cell.getRow().getData();
                var IntakeListArry = GetIntakeList("Y");
                var FilterIntakeListArry = IntakeListArry.filter(function (F) {
                    return F.CODE.trim() == RowData.Intake;
                });

                if (FilterIntakeListArry.length > 0) {
                    var intake = FilterIntakeListArry[0].INTAKE.toUpperCase();
                    if (intake == "SOS" || intake == "STAT" || intake == "CONTD." || intake == "CONTD") {
                        cell.getRow().update({ DurNum: "0",  DurType: "D",  Qty: 0 });
                        cell.getRow().normalizeHeight();
                        return;
                    }
                }

                if (RowData.QTYCALCFLAG == "D") {
                    cell.getRow().update({ Qty: 1 });
                    cell.getRow().normalizeHeight();
                    return;
                }

                if (RowData.QTYCALCFLAG == "E") {
                    cell.getRow().normalizeHeight();
                    return;
                }
                var tabCountQty = RowData.Qty || 0;
                var MultiVal = 0;

                if (RowData.DurType == "D")
                    MultiVal = 1;
                else if (RowData.DurType == "W")
                    MultiVal = 7;
                else if (RowData.DurType == "M")
                    MultiVal = 30;
                else if (RowData.DurType == "Y")
                    MultiVal = 365;

                if (FilterIntakeListArry.length > 0) {
                    tabCountQty = Number(FilterIntakeListArry[0].TABCOUNT) *
                        (MultiVal * Number(RowData.DurNum));
                }

                cell.getRow().update({ Qty: tabCountQty });
            }

            cell.getRow().normalizeHeight();
        });

        RxListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("RxTable");
            toogleButtons(RxListtable, "RxListtable");

            //if (!row.getData().Route) {
            //    row.update({ Route: RXSetDefaultRouteValue });
            //}
        });

        RxListtable.on("rowDeleted", function (row) {
            adjustTableHeight("RxTable");
            toogleButtons(RxListtable, "RxListtable");
        });

        RxListtable.on("tableBuilt", function () {
            adjustTableHeight("RxTable");
        });

        /* Click Event on the Compliant Search List */
        $(document).on("click", ".Rx-row", function () {
            var Mtrlcode = $(this).data("code");
            var Mtrlname = $(this).data("name");
            var Gencode = $(this).data("gencode");
            var Genname = $(this).data("genname");
            var Route = $(this).data("route");
            var FormCode = $(this).data("formcode");
            var rows = RxListtable.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].code === Mtrlcode) {
                    ToastMsg("Rx already added", "warning");
                    $("#RxListMainDiv").hide();
                    return;
                }
            }
            var RList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
            var FilterLst = RList.filter(item => ("" + item.FORMCODE).trim() == ("" + FormCode).trim());
            var FormName = FilterLst.length > 0 ? FilterLst[0].FORMNAME : "";
            var QtyClacflag = FilterLst.length > 0 ? FilterLst[0].QTYCALCFLAG : "";
            RxListtable.addRow({
                MaterialName: Mtrlname,
                DrugCode: Mtrlcode,
                GenericName: Genname,
                GenericID: Gencode,
                MedDate: getTodayDate(),//priyanka 08/04/2026
                FORMNAME: FormName,
                FORMCODE: FormCode,
                Intake: "",
                DurNum: "0",
                DurType: "D",
                BeforeAfter: "A",
                Route: Route,
                Dosses: "",
                Qty: "",
                Remark: "",
                SetUpYn: "N",
                RefillYN: "N",
                ROUTINEYN: "N",
                PHSTATUS: "A",
                TAMPERING: "N",
                QTYCALCFLAG: QtyClacflag,
            }).then(function (row) {
                adjustTableHeight("RxTable");
            });
            $("#Rxearch").val("");
            $("#RxListMainDiv").hide();
        });

        /* Bind Already Saved Rx */
        SetDataForRx();

        /* Adjust of Height Of Rx Table */
        adjustTableHeight("RxTable");

        if (sessionStorage.getItem("PatCompleted").toString() === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagRXYN == "Y") {
            $("#sec-Rx *").attr("disabled", "disabled");
            $("#Rx_PrevHistory").removeAttr("disabled");
            $("#btnInformantRx").removeAttr("disabled");
            $("#btnDuplicateRx").removeAttr("disabled");
            $("#btnAllergyRx").removeAttr("disabled");
        }
        else {
            $("#sec-Rx *").removeAttr("disabled");
        }

        $(document).on('input', '.onlyPositive', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        })
    });
    //Added by aaryshree 20260624
    function getDrugFormDropdown() {

        var RTList = JSON.parse(FormLinkRouteList || "[]");

        var values = {};
        var seen = new Set();

        RTList.forEach(function (item) {

            var code = ("" + item.FORMCODE).trim();
            var name = item.FORMNAME;
            var text = item.Text;
            var value = item.Value;
            var qtycalcflag = item.QTYCALCFLAG;

            if (!code || !name || name.trim() === "" || !text || text.trim() === "" || !value || value.trim() === "" || !qtycalcflag || qtycalcflag.trim() === "") {
                return;
            }
            if (seen.has(code)) {
                return;
            }

            seen.add(code);

            values[code] = name;
        });

       // console.log("Filtered Dropdown:", values);

        return values;
    }
    //End
    //Priyanka 08/04/2026
    function getTodayDate() {
        const today = new Date();
        const dd = String(today.getDate()).padStart(2, '0');
        const mm = String(today.getMonth() + 1).padStart(2, '0'); // January = 0
        const yyyy = today.getFullYear();

        return `${dd}/${mm}/${yyyy}`;
    }

    /* Search For Frequent Rx */
    function GetFrequentRx() {
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
                BindSearchListForRx(RxListData);
                stopLoading("loading-Rx-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Rx-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Search For All Rx */
    function GetAllRxList(FilterRxText = "", FilterRxCode = "", HistoryObj = "") { <%--// Modified Pournima 16th June 2026--%>
        startLoading("Loading", "loading-Rx-Search-List"); <%--// Modified Pournima 16th June 2026--%>
        FilterRxText = $("#RxSearch").val();
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
                FilterRxData(RxListData, FilterRxCode, HistoryObj);
                stopLoading("loading-Rx-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Rx-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Rx Data list */
    function FilterRxData(RxListData, RxCode, HistoryObj) {
        var FilterRxList = RxListData;
        if (RxCode != "") {
            FilterRxList = RxListData.filter(item => (GeneralWiseYN == "Y" ? (item.GENERICID == RxCode) : (item.CODE == RxCode)));
        }
        BindSearchListForRx(FilterRxList);
        if (RxCode && RxCode !== "") {
            var $first = $("#RxList .Rx-row").first();
            if ($first.length) {
                $first.trigger("click");
                if (HistoryObj != undefined && HistoryObj != null && HistoryObj != "") {
                    var RTList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
                    var FilterFormList = RTList.filter(item => ("" + item.FORMCODE).trim() == HistoryObj.DrugFormCD);
                    var FormCD = FilterFormList.length > 0 ? FilterFormList[0].FORMCODE : "";
                    var FormNM = FilterFormList.length > 0 ? FilterFormList[0].FORMNAME : "";
                    RxListtable.updateRow(HistoryObj.DrugCode || HistoryObj.code, {
                        MaterialName: HistoryObj.name,
                        GenericName: HistoryObj.name,
                        DrugCode: HistoryObj.code,
                        GenericID: HistoryObj.code,
                        MedDate: HistoryObj.fordate,
                        Intake: HistoryObj.Intake,
                        DurNum: HistoryObj.durationno,
                        DurType: HistoryObj.type,
                        BeforeAfter: HistoryObj.food,
                        Route: HistoryObj.Route,
                        Dosses: HistoryObj.Dosses,
                        Qty: HistoryObj.Qty,
                        Remark: HistoryObj.Remark,
                        SetUpYn: HistoryObj.SetUpYn,
                        FORMNAME: FormNM,
                        FORMCODE: FormCD
                    });
                }
            }
        }
    }

    //Filter in HTML Search
    function FilterBindedSearchListForRx() {
        var SearchTxt = $("#RxSearch").val().toLowerCase();
        var FlagForCallAllRxList = true;
        if (SearchTxt.length < 3) {
            $("#RxList .Rx-row").each(function () {
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
            GetAllRxList($("#RxSearch").val(), "");
    }

    //List Binding Functionality
    function BindSearchListForRx(RxData) {
        var $list = $("#RxList");
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
                var Route = item.ROUTE;
                if ((name.toUpperCase().indexOf(" TAB") > -1 || name.toUpperCase().indexOf("TAB ") > -1 || name.toUpperCase().indexOf(" SYP") > -1 || name.toUpperCase().indexOf("SYP ") > -1 || name.toUpperCase().indexOf(" CAP") > -1 || name.toUpperCase().indexOf("CAP ") > -1 || name.toUpperCase().indexOf("TABLET") > -1 || name.toUpperCase().indexOf("CAPSULE") > -1 || name.toUpperCase().indexOf("SYRUP") > -1)
                    && (GeneralWiseYN == "N" && $.trim(item.ROUTENM) == ""))
                    Route = "09";
                var Route = "";
                var ListOption = '<div class="list-group-item Rx-row" ' +
                    'data-GenCode="' + item.GENERICID + '" ' +
                    'data-GenName="' + item.GENERICNAM + '" ' +
                    'data-route="' + Route + '" ' +
                    'data-code="' + code + '" ' +
                    'data-name="' + name + '" ' +
                    'data-formcode="' + item.MTRLFORMID + '" ' +
                    //'style = "cursor:pointer;" > ' + name + '(' + code + ') </div > ';
                    'style = "cursor:pointer;" > ' + name + '</div > ';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#RxList").append(AppendContentList);
        $("#RxListMainDiv").show();
    }

    //Validation Functionality For Save Rx
    function ValidationForRx(Type) {
        var RxListtableData = RxListtable.getData();
        for (var i = 0; i < RxListtableData.length; i++) {
            if (!RxListtableData[i].FORMCODE || RxListtableData[i].FORMCODE == "") {
                ToastMsg("Drug Form for " + RxListtableData[i].GenericName + " is not config.", "warning");
                RxListtable.scrollToRow(i, 'start', true);
                return false;
            }
            if (RxListtableData[i].Intake == "") {
                ToastMsg("Please select frequency for all medicines in Rx.", "warning");
                RxListtable.scrollToRow(i, 'start', true);
                return false;
            }
            if (RxListtableData[i].Route == "") {
                ToastMsg("Please select Route for all medicines in Rx.", "warning");
                RxListtable.scrollToRow(i, 'center', true);
                return false;
            }
            //if (!RxListtableData[i].Dosses || RxListtableData[i].Dosses == "") {
            //    ToastMsg("Please enter Doses for all medicines in Rx.", "warning");
            //    RxListtable.scrollToRow(i, 'center', true);
            //    return false;
            //}
            //if (!RxListtableData[i].Qty || RxListtableData[i].Qty == "" || RxListtableData[i].Qty == "0") {
            //    ToastMsg("Please enter Quantity for all medicines in Rx.", "warning");
            //    RxListtable.scrollToRow(i, 'center', true);
            //    return false;
            //}
            if (Type == "C") {
                if (RxListtableData[i].Intake == "") {
                    ToastMsg("Please select frequency for all medicines in Rx.", "warning");
                    RxListtable.scrollToRow(i, 'start', true);
                    return false;
                }
                if (RxListtableData[i].Route == "") {
                    ToastMsg("Please select Route for all medicines in Rx.", "warning");
                    RxListtable.scrollToRow(i, 'center', true);
                    return false;
                }
                //if (!RxListtableData[i].Dose || RxListtableData[i].Dose == "" || RxListtableData[i].Dosses == "" || RxListtableData[i].DOSSAGE == "") {
                //    ToastMsg("Please enter Dose for all medicines in Rx.", "warning");
                //    RxListtable.scrollToRow(i, 'center', true);
                //    return false;
                //}
                //if (!RxListtableData[i].Qty || RxListtableData[i].Qty == "" || RxListtableData[i].Qty == "0") {
                //    ToastMsg("Please enter Quantity for all medicines in Rx.", "warning");
                //    RxListtable.scrollToRow(i, 'center', true);
                //    return false;
                //}
                var IntakeListArry = GetIntakeList("Y");
                var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == RxListtableData[i].Intake; });
                var InTakeDesc = FilterIntakeListArry.length > 0 ? FilterIntakeListArry[0].INTAKE.toUpperCase() : "";
                var SOSFlg = InTakeDesc == "SOS" || InTakeDesc == "STAT" || InTakeDesc == "CONTD." || InTakeDesc == "CONTD" || InTakeDesc == "CONT." || InTakeDesc == "CONT" ? true : false;
                if (SOSFlg == false && (RxListtableData[i].DurNum == "" || RxListtableData[i].DurNum == "0")) {
                    RxListtable.scrollToRow(i, 'center', true);
                    ToastMsg("Please select duration of selected medicine in Rx.", "warning");
                    return false;
                }
            }
        }
        let seen = new Map();
        let duplicates = [];
        var RxListtableData = RxListtable.getData();
        for (let item of RxListtableData) {
            let key = [
                item.Dose,
                item.Remark,
                item.GenericID,
                item.Intake,
                item.IntakeDesc,
                item.MedDate
            ].join('|');

            if (seen.has(key)) {
                duplicates.push(item);
            } else {
                seen.set(key, true);
            }
        }
        if (duplicates.length > 0) {
            ToastMsg("Generic Name : " + duplicates[0].GenericName + " is duplicate", "warning");
            return false;
        }

        return true;
    }
    function HASDataInRX() //priyanka 16/04/2026
    {
        var RXTblData = RxListtable.getData();
        if (RXTblData.length === 0) {
            return false;
        }
        else {
            return true;
        }
    }

    //Save Functionality For Rx
    function SaveForRx(DataSaveObj, Type) {
        var RxArr = [];
        var tableData = RxListtable.getData();
        var rows = tableData.map(function (row) {
            var newRow = {};
            for (var key in row) {
                if (row.hasOwnProperty(key) && key !== "act") {
                    newRow[key] = row[key];
                }
            }
            return newRow;
        });
        for (var i = 0; i < rows.length; i++) {
            var IntakeListArry = GetIntakeList("Y");
            var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == rows[i].Intake; });
            var SOSYN = FilterIntakeListArry.length > 0 ? (FilterIntakeListArry[0].INTAKE.toUpperCase() == "SOS" ? "Y" : "N") : "N";
            var a = {
                DRUGNM: rows[i].MaterialName.trim(),
                DOSSAGE: rows[i].Dosses.trim(),
                DAYS: rows[i].DurNum,
                Remarks: rows[i].Remark.trim(),
                ROUTE: rows[i].Route.trim(),
                GENERICID: rows[i].GenericID.trim(),
                GENERICNAME: rows[i].GenericName.trim(),
                DRUGCD: rows[i].DrugCode.trim(),
                INTAKECD: rows[i].Intake.trim(),
                SOSYN: SOSYN.trim(),
                DURATION: rows[i].DurType.trim(),
                ABFOOD: rows[i].BeforeAfter.trim(),
                DRUGFORM: ("" + rows[i].FORMCODE).trim(),
                INTAKEDESC: FilterIntakeListArry.length > 0 ? FilterIntakeListArry[0].INTAKE.toUpperCase() : "",
                RESEQ: i + 1,
                TAMPERING: rows[i].TAMPERING.trim(),
                SETUPYN: rows[i].SetUpYn.trim(), //Pending
                REFILLYN: rows[i].RefillYN.trim(), //Pending
                CIMSYN: "N", //Pending
                QTY: rows[i].Qty,
                ROUTINEYN: rows[i].ROUTINEYN.trim(),
                PHSTATUS: rows[i].PHSTATUS.trim(),
                MEDSTARTDATE: ConvertDateFormatSaveRX(rows[i].MedDate)
            };
            RxArr.push(a);
        }
        DataSaveObj.StrRX = JSON.stringify(RxArr);
    }

    function ConvertDateFormatSaveRX(DateStr) {
        if (!DateStr || DateStr.length !== 10) return '';
        const day = DateStr.substring(0, 2);
        const month = DateStr.substring(3, 5);
        const year = DateStr.substring(6, 10);
        return year + month + day;
    }

    //Binding Functionality For Rx
    function SetDataForRx() {
        var tranNo = sessionStorage.getItem('PatTRANNO');
        if (!tranNo) return;
        startLoading("Loading", "loading-Rx");
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetSavedMediList",
            datatype: "json",
            async: true,
            data: { strConsNo: tranNo },
            success: function (data) {
                rowNoFrMedTaper = 0;
                RxListtable.setData([]);
                if (data == "" || data == null) {
                    stopLoading("loading-Rx");
                    return;
                }
                var data = JSON.parse(data);
                if (data.length === 0) {
                    stopLoading("loading-Rx");
                    return;
                }
                rowNoFrMedTaper = data[data.length - 1].RESEQ;
                var RList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
                //var existingRows = RxListtable.getData();
                data.forEach(function (item) {
                    let dt = luxon.DateTime.fromFormat(item.MEDSTARTDATE, "yyyyMMdd");
                    item.MEDSTARTDATE = dt.isValid ? dt.toFormat("dd/MM/yyyy") : "";
                    if (ShowRXSetup == "Y" && item.DRUGFORM.trim() == "" && item.SETUPYN.trim() != "") {
                        var RxSearchSetup = GetSpecificRxData(item.DRUGNM.trim());
                        var FilterR = GeneralWiseYN == "Y" ? RxSearchSetup.filter(x => x.GENERICID == item.DRUGCD.trim()) : RxSearchSetup.filter(x => x.MTRLCODE == item.GENERICID.trim());
                        item.DRUGFORM = FilterR[0].MTRLFORMID;
                        item.MEDSTARTDATE = getTodayDate();
                        item.DAYS = "0";
                        item.DURATION = "D";
                        item.ABFOOD = "A";
                    }
                    var FilterLst = RList.filter(K => ("" + K.FORMCODE).trim() == item.DRUGFORM.trim() || ("" + K.FORMNAME).trim() == item.DRUGFORM.trim());
                    var FormName = FilterLst.length > 0 ? FilterLst[0].FORMNAME : "";
                    RxListtable.addRow({
                        MaterialName: item.DRUGNM.trim(),
                        DrugCode: item.DRUGCD.trim(),
                        GenericName: item.GENERICNAME.trim(),
                        GenericID: item.GENERICID.trim(),
                        MedDate: item.MEDSTARTDATE.trim(),
                        Intake: item.INTAKECD.trim(),
                        DurNum: item.DAYS.trim(),
                        DurType: item.DURATION.trim(),
                        BeforeAfter: item.ABFOOD.trim(),
                        Route: item.ROUTE.trim(),
                        Dosses: item.DOSSAGE.trim(),
                        Qty: item.QTY.trim(),
                        Remark: item.Remarks.trim(),
                        SetUpYn: item.SETUPYN.trim(),
                        RefillYN: item.REFILLYN.trim(),
                        ROUTINEYN: item.ROUTINEYN.trim(),
                        PHSTATUS: item.PHSTATUS.trim(),
                        TAMPERING: item.TAMPERYN.trim(),
                        FORMNAME: FormName,
                        FORMCODE: item.DRUGFORM,
                        QTYCALCFLAG: item.QTYCALCFLAG.trim(),
                    }).then(function (row) {
                        row.normalizeHeight();
                        adjustTableHeight("RxTable");
                    });
                });
                stopLoading("loading-Rx");
            },
            error: function (xhr, status) {
                ToastMsg(status, "error");
                stopLoading("loading-Rx");
            }
        });
    }

    function GetSpecificRxData(MedName) {
        startLoading("Loading", "loading-Rx-Search-List");
        var Result = [];
        $.ajax({
            type: "POST",
            async: false,
            url: "../DoctorDesk/GetNonFreqDrugLstFrRxDesktop",
            data: { NonFreqDrug: MedName },
            success: function (result) {
                var RxListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL") {
                        result = JSON.parse(result);
                        Result = result.Table;
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                stopLoading("loading-Rx-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Rx-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
        return Result;
    }

    //Get Intake List
    function GetIntakeList(TabCoutYN) {
        var RxIntakeList = [];
        let raw = RXMedIntakeList.trim();
        if (raw.startsWith('"') && raw.endsWith('"')) {
            raw = raw.slice(1, -1);
        }
        raw = raw.replace(/\r\n/g, "");
        if (TabCoutYN == "Y") {
            var arry = RXMedIntakeList == "" || RXMedIntakeList == "null" || raw == "" || raw == null || raw == undefined ? [] : JSON.parse(raw).Intake;
            RxIntakeList = arry;
        }
        else {
            var arry = RXMedIntakeList == "" || RXMedIntakeList == "null" || raw == "" || raw == null || raw == undefined ? [] : JSON.parse(raw).Intake;
            RxIntakeList = ConvertArryListToTabulatorFormat(arry, "INTAKE", "CODE");
        }
        return RxIntakeList;
    }

    //Get Route List
    function RxGetRouteList(TabulatorYN, DrugFormCode) {
        var s;
        var RTList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
        var FilterRouteList = RTList.filter(item => ("" + item.FORMCODE).trim() == DrugFormCode && item.Value != "");
        s = TabulatorYN == "Y" ? ConvertArryListToTabulatorFormat(FilterRouteList, "Text", "Value") : FilterRouteList;
        return s;
    }

    //Get Dossage List
    function GetDossageList() {
        var array = [
            "2 drops",
            "5 drops",
            "0.5 ml",
            "1 ml",
            "1.5 ml",
            "2 ml",
            "2.5 ml",
            "3 ml",
            "3.5 ml",
            "4 ml",
            "4.5 ml",
            "5 ml",
            "5.5 ml",
            "6 ml",
            "6.5 ml",
            "7 ml",
            "7.5 ml",
            "8 ml",
            "8.5 ml",
            "9 ml",
            "9.5 ml",
            "10 ml"
        ];
        let lookup = {};
        lookup[""] = "";
        array.forEach(val => {
            lookup[val] = val;
        });
        return lookup;
    }

    //Get Remark List
    function GetRemarkList() {
        var RxCovRemarkList = [];
        var RemarkArray = RXRemarkList == "" || RXRemarkList == "null" ? [] : (JSON.parse(RXRemarkList.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t")) == "" ? [] : JSON.parse(RXRemarkList.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t")));
        RxCovRemarkList = ConvertArryListToTabulatorFormat(RemarkArray, "Text", "Value");
        return RxCovRemarkList;
    }

    //Get All DropDown Master List For Rx
    function GetAllOtherMasterDataLoadForRx() {
        $.ajax({
            url: '../SinglePage/GetAllOtherMasterForRX',
            type: 'post',
            datatype: 'json',
            success: function (response) {
                RXRemarkList = JSON.stringify(response.RXRemarkArray);
                //RXMedRouteList = JSON.stringify(response.RXMedRoute);
                RXMedIntakeList = response.RXIntake;
                refreshDropdownColumns();
            }
        });
    }
    function refreshDropdownColumns() {
        RxListtable.updateColumnDefinition("Intake", {
            editorParams: { values: GetIntakeList("N"), allowEmpty: false },
            formatterParams: GetIntakeList("N")
        });
        RxListtable.updateColumnDefinition("Remark", {
            editorParams: { values: GetRemarkList(), allowEmpty: false },
            formatterParams: GetRemarkList()
        });
    }

</script>

<%-- Add New Item For Rx Intake--%>
<script type="text/javascript">
    //Body Content For New Item Rx Intake
    function ContentForAddNewItemRxIntake() {
        return `
             <div class="mb-3">
               <input id="txtRxIntake" type="text" class="form-control RxIntake" maxlength="250" autocomplete="off" placeholder="Enter Intake" tabindex="2" />
             </div>
        <div class="mb-3">
            <input id="txtTabCount" type="number" class="form-control TabCount onlyPositive" min="1" maxlength="3" value="1" autocomplete="off" placeholder="Enter Tab Count"  tabindex="3" />
        </div>
    `;
    }
    //Footer Content For New Item Rx Intake
    function FooterContentForAddNewItemRxIntake() {
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('RxIntake')" tabindex="3">Close</button>
        return `
            <button class="btn btn-primary" onclick="SaveNewItemForRxIntake('RxIntake')" tabindex="4">Save</button>
        `;
    }
    //Validation For New Item Rx Intake
    function ValidationForNewItemRxIntake() {
        if ($("#txtRxIntake").val().trim().length === 0) {
            ToastMsg("Enter Intake", "warning");
            $("#txtRxIntake").focus();
            return false;
        }

        if ($("#txtTabCount").val().trim() === "") {
            ToastMsg("Enter Tab Count", "warning");
            $("#txtTabCount").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Rx Intake
    function SaveNewItemForRxIntake() {
        if (ValidationForNewItemRxIntake() == true) {

            var intake = $("#txtRxIntake").val().trim();
            var tabCount = $("#txtTabCount").val().trim();
            $.ajax({
                url: '../DoctorDesk/saveMedIntkCombintn',
                type: 'post',
                datatype: 'json',
                data: {
                    strMedIntkComb: intake,
                    TabCount: tabCount
                },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg("Intake added successfully", "success");
                        closeAddNewItemPopup('RxIntake');
                        GetAllOtherMasterDataLoadForRx();
                    }
                    else {
                        ToastMsg(response, "warning");
                    }
                }
            });
        }
    }
</script>

<%-- Add New Item For Rx Route--%>
<script type="text/javascript">
    //Body Content For New Item Rx Route
    function ContentForAddNewItemRxRoute() {
        return `
             <div class="mb-3">
               <input id="txtRxRoute" type="text" class="form-control RxRoute" maxlength="250" autocomplete="off" placeholder="Enter Route" tabindex="2" />
             </div>
        `;
    }
    //Footer Content For New Item Rx Route
    function FooterContentForAddNewItemRxRoute() {
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('RxRoute')" tabindex="3">Close</button>
        return `
            <button class="btn btn-primary" onclick="SaveNewItemForRxRoute('RxRoute')" tabindex="4">Save</button>
        `;
    }
    //Validation For New Item Rx Route
    function ValidationForNewItemRxRoute() {
        if ($("#txtRxRoute").val().trim().length === 0) {
            ToastMsg("Enter Route", "warning");
            $("#txtRxRoute").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Rx Route
    function SaveNewItemForRxRoute() {
        if (ValidationForNewItemRxRoute() == true) {
            var strRoute = $("#txtRxRoute").val();
            $.ajax({
                type: "post",
                datatype: "json",
                url: '../DoctorDesk/saveRoute',
                data: { strNewRoute: strRoute, },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg("Intake added successfully", "success");
                        closeAddNewItemPopup('RxRoute');
                        GetAllOtherMasterDataLoadForRx();
                    }
                    else {
                        ToastMsg(response, "warning");
                    }
                },
            });
        }
    }
</script>

<%-- Add New Item For Rx Remark--%>
<script type="text/javascript">
    //Body Content For New Item Rx Remark
    function ContentForAddNewItemRxRemark() {
        return `
             <div class="mb-3">
               <input id="txtRxRemark" type="text" class="form-control RxRemark" maxlength="250" autocomplete="off" placeholder="Enter Remark" tabindex="2" />
             </div>
        `;
    }
    //Footer Content For New Item Rx Remark
    function FooterContentForAddNewItemRxRemark() {
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('Remark')" tabindex="3">Close</button>
        return `
            <button class="btn btn-primary" onclick="SaveNewItemForRxRemark('Remark')" tabindex="4">Save</button>
        `;
    }
    //Validation For New Item Rx Remark
    function ValidationForNewItemRxRemark() {
        if ($("#txtRxRemark").val().trim().length === 0) {
            ToastMsg("Enter Remark", "warning");
            $("#txtRxRemark").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Rx Remark
    function SaveNewItemForRxRemark() {
        if (ValidationForNewItemRxRemark() == true) {
            $.ajax({
                type: "post",
                datatype: "json",
                url: '../DoctorDesk/saveIntakeRemark',
                data: { strNewRemark: $('#txtRxRemark').val(), },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg("Intake added successfully", "success");
                        closeAddNewItemPopup('RxRemark');
                        GetAllOtherMasterDataLoadForRx();
                    }
                    else {
                        ToastMsg(response, "warning");
                    }
                },
            });
        }
    }
</script>

<%-- Add New Item For Rx --%>
<script type="text/javascript">
    //Body Content For New Item Rx
    function ContentForAddNewItemRx() {
        return `
             <div class="mb-3">
               <input id="txtRx" type="text" class="form-control Rx" maxlength="250" autocomplete="off" placeholder="Enter Rx" tabindex="2" />
             </div>
        `;
    }
    //Footer Content For New Item Rx
    function FooterContentForAddNewItemRx() {
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('Rx')" tabindex="3">Close</button>
        return `
            <button class="btn btn-primary" onclick="SaveNewItemForRx('Rx')" tabindex="4">Add</button>
        `;
    }
    //Validation For New Item Rx
    function ValidationForNewItemRx() {
        if ($("#txtRx").val().trim().length === 0) {
            ToastMsg("Enter Rx", "warning");
            $("#txtRx").focus();
            return false;
        }
        //Validation For All Drug Present in the Table or not
        var FilterRxListtable = RxListtable.getData().filter(function (F) { return F.MaterialName.trim() == $("#txtRx").val().trim() || F.GenericName.trim() == $("#txtRx").val().trim(); });
        if (FilterRxListtable.length > 0) {
            ToastMsg("This Medicine already selected", "warning");
            $("#txtRx").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Rx
    function SaveNewItemForRx() {
        if (ValidationForNewItemRx() == true) {
            var RxName = $("#txtRx").val();
            rowNoFrMedTaper = Number(rowNoFrMedTaper) + 1;
            var medCode = "NEW" + rowNoFrMedTaper;
            RxListtable.addRow({
                MaterialName: RxName,
                DrugCode: medCode,
                GenericName: RxName,
                GenericID: medCode,
                FORMCODE: "",
                FORMNAME:"",
                MedDate: getTodayDate(),
                Intake: "",
                DurNum: "0",
                DurType: "D",
                BeforeAfter: "A",
                Route: "",
                Dosses: "",
                Qty: "",
                Remark: "",
                SetUpYn: "N",
                RefillYN: "N",
                ROUTINEYN: "N",
                PHSTATUS: "A",
                TAMPERING: "N",
                IsNewRxAdded: true,  
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("RxTable");
                closeAddNewItemPopup('RX');
            });
        }
    }
</script>

<%-- History For Rx --%>
<script type="text/javascript">
    function HistPopRxTemp(AllHistoryData, ContentID) {
        var ConsultLst = AllHistoryData[0] || [];
        var RxLst = AllHistoryData[1] || [];
        var container = '<div class="history-list-wrapper">';
        var isVisitCompleted = (typeof SessionCompRX !== 'undefined' && SessionCompRX === "Y");
        for (var i = 0; i < ConsultLst.length; i++) {
            var consult = ConsultLst[i];
            var ConsultNo = consult.TRANNO;
            if (!ConsultNo || ConsultNo == sessionStorage.getItem("PatTRANNO")) continue;
            var filtered = RxLst.filter(c => c.TRANNO === ConsultNo);
            if (filtered.length === 0) continue;
            var existingRows = RxListtable.getData();
            var allCopied = filtered.every(c =>
                existingRows.some(r => r.DrugCode === c.DRUGCD)
            );
            if (allCopied) {
                copyAllBtnHtml =
                    '<button class="btn btn-sm btn-outline-success" style="background: #dbfdf8;" disabled>' +
                    '<i class="fa fa-check text-success"></i>' +
                    '</button>';
            } else {
                copyAllBtnHtml =
                    '<button class="btn btn-sm btn-outline-primary copy-all-btn" data-consult="' + ConsultNo + '">' +
                    '<i class="fa fa-copy"></i> Copy All' +
                    '</button>';
            }
            var docName = consult.DOCTNAME || "General Consultation";
            var specName = consult.SPECNAME ? " (" + consult.SPECNAME + ")" : "";
            var dateInfo = consult.TRANDATE + " " + ConvertTo12Hour("O", consult.TRANTIME);
            var sectionHtml =
                '<div class="History-section mb-3 shadow-sm border">' +
                '<div class="History-header d-flex justify-content-between align-items-center bg-light p-2 border-bottom">' +
                '<div style="line-height: 1.2;">' +
                '<div class="History-header-title font-weight-bold">Dr. ' + docName + specName + '</div>' +
                '<small>' + dateInfo + '</small>' +
                '</div>' +
                (isVisitCompleted ? '' : copyAllBtnHtml)
                //(isVisitCompleted ? '' : 
                //    '<button class="btn btn-sm btn-outline-primary copy-all-btn" data-consult="' + ConsultNo + '">' +
                //    '<i class="fa fa-copy"></i> Copy All' +
                //    '</button>'
                //)
                +
                '</div>' +
                '<div class="History-body">' +
                '<ul class="list-unstyled mb-0">';

            var RxSentence = "{RXNAME} - {INTAKE} - {DURNO} {DURCATG} - {ROUTE} - {QTY} - {DOSSAGE}";
            for (var k = 0; k < filtered.length; k++) {
                var itemText = GeneralWiseYN == "Y" ? filtered[k].GENERICNAM : filtered[k].MTRLNAME;
                var itemCode = GeneralWiseYN == "Y" ? filtered[k].GENERICID : filtered[k].MTRLCODE;
                var fordate = filtered[k].MEDSTARTDATE;
                var Intake = filtered[k].INTAKECD;
                var DurDays = parseDuration(filtered[k].DAYS);
                var durationNo = DurDays.number || "";
                var durationType = DurDays.unit || "";
                var food = filtered[k].ABFOOD || "";
                var route = filtered[k].ROUTE || "";
                var dossage = filtered[k].DOSSAGE || "";
                var qty = filtered[k].QTY || "";
                var remarks = (filtered[k].REMARKSCD || "").trim();
                var SetupYN = "";
                var IntakeListArry = GetIntakeList("Y");
                var FilterIntakeListArry = IntakeListArry.filter(function (F) { return F.CODE.trim() == Intake; });
                var InTakeText = FilterIntakeListArry.length > 0 ? FilterIntakeListArry[0].INTAKE : Intake;
                var DrugFormCD = filtered[k].DRUGFORM || "";
                var RplRxSentence = RxSentence.replace("{RXNAME}", itemText)
                    .replace("{INTAKE}", InTakeText)
                    .replace("{DURNO}", durationNo)
                    .replace("{DURCATG}", durationType)
                    .replace("{ROUTE}", route)
                    .replace("{QTY}", qty)
                    .replace("{DOSSAGE}", dossage);
                var actionBtn = "";
                var ExistingRow = RxListtable.getData().filter(function (F) {
                    return F.DrugCode.trim() == itemCode &&
                        F.Intake.trim() == Intake && 
                        F.MedDate.trim() == getTodayDate() && 
                        Number(F.DurNum) == Number(durationNo) && //priyanka 24/06/2026
                        F.DurType.trim() == durationType && 
                        F.Route.trim() == route && 
                        F.Dosses.trim() == dossage && 
                        F.Qty.trim() == qty
                    ;
                });
                if (ExistingRow.length > 0) {
                    /*actionBtn = `<i class="fa fa-check text-success" title="Already Added"></i>`;*/
                    actionBtn = `<span class="text-success mr-2" title="Already Added"><i class="fa fa-check-circle"></i></span>`
                }
                else if (isVisitCompleted) {
                    actionBtn = "";
                }
                else {
                    actionBtn = '<button class="btn btn-link btn-sm p-0 copy-row-btn" title="Copy to List">' +
                        '<i class="fa fa-clone text-primary"></i>' +
                        '</button>';
                }
                sectionHtml +=
                    '<li class="History-row d-flex justify-content-between align-items-center p-2 border-bottom">' +
                    '<span class="History-row-Alltext">' + RplRxSentence + '</span>' +
                    '<span class="History-row-text History-row-Hide">' + itemText + '</span>' +
                    '<span class="History-row-Code History-row-Hide">' + itemCode + '</span>' +
                    '<span class="History-row-ForDate History-row-Hide">' + fordate + '</span>' +
                    '<span class="History-row-Intake History-row-Hide">' + Intake + '</span>' +
                    '<span class="History-row-DurNo History-row-Hide">' + durationNo + '</span>' +
                    '<span class="History-row-DurType History-row-Hide">' + durationType + '</span>' +
                    '<span class="History-row-Food History-row-Hide">' + food + '</span>' +
                    '<span class="History-row-Route History-row-Hide">' + route + '</span>' +
                    '<span class="History-row-Dossage History-row-Hide">' + dossage + '</span>' +
                    '<span class="History-row-Qty History-row-Hide">' + qty + '</span>' +
                    '<span class="History-row-Remark History-row-Hide">' + remarks + '</span>' +
                    '<span class="History-row-SetupYN History-row-Hide">' + SetupYN + '</span>' +
                    '<span class="History-row-DrugFormCD History-row-Hide">' + DrugFormCD + '</span>' +
                    actionBtn +
                    '</li>';
            }
            sectionHtml +=
                '</ul>' +
                '</div>' +
                '</div>';
            container += sectionHtml;
        }
        return container + '</div>';
    }

    function CopyFuncRx() {
        //COPY ROW
        $(".copy-row-btn").off("click").on("click", function () {
            var $btn = $(this);
            var $li = $btn.closest("li");
            var $ul = $btn.closest("ul");
            var text = $(this).siblings(".History-row-text").text();
            var Code = $(this).siblings(".History-row-Code").text();
            var RxRowObj = {
                code: Code,
                name: text,
                fordate: $(this).siblings(".History-row-ForDate").text(),
                Intake: $(this).siblings(".History-row-Intake").text(),
                durationno: $(this).siblings(".History-row-DurNo").text(),
                type: $(this).siblings(".History-row-DurType").text(),
                food: $(this).siblings(".History-row-Food").text(),
                Route: $(this).siblings(".History-row-Route").text(),
                Dosses: $(this).siblings(".History-row-Dossage").text(),
                Qty: $(this).siblings(".History-row-Qty").text(),
                Remark: $(this).siblings(".History-row-Remark").text(),
                SetUpYn: $(this).siblings(".History-row-SetupYN").text(),
                DrugFormCD: $(this).siblings(".History-row-DrugFormCD").text(),
            };
            CopyBindToRXTable(RxRowObj);
            //GetAllRxList(text, Code, RxRowObj);
            $(".History-row-Code").each(function () {
                var FlagForDuplicate = false;
                if ($(this).text().trim() == RxRowObj.code &&
                    $(this).siblings(".History-row-Intake").text().trim() == RxRowObj.Intake &&
                    $(this).siblings(".History-row-DurNo").text().trim() == RxRowObj.durationno &&
                    $(this).siblings(".History-row-DurType").text().trim() == RxRowObj.type &&
                    $(this).siblings(".History-row-Route").text().trim() == RxRowObj.Route &&
                    $(this).siblings(".History-row-Dossage").text().trim() == RxRowObj.Dosses &&
                    $(this).siblings(".History-row-Qty").text().trim() == RxRowObj.Qty) {
                    FlagForDuplicate = true;
                }
                if (FlagForDuplicate) {
                    var $sameRow = $(this).closest("li");
                    var $sameBtn = $sameRow.find(".copy-row-btn");
                    if ($sameBtn.length > 0) {
                        $sameBtn.html('<i class="fa fa-check text-success"></i>')
                            .removeClass("copy-row-btn")
                            .prop("disabled", true);
                    }
                    var $parentUl = $sameRow.closest("ul");
                    if ($parentUl.find(".copy-row-btn").length === 0) {
                        var $copyAll = $parentUl.closest("div.History-body")
                            .siblings("div.History-header")
                            .find(".copy-all-btn");
                        if ($copyAll.length > 0) {
                            $copyAll.html('<i class="fa fa-check text-success" style="background:white;"></i>')
                                .removeClass("copy-all-btn")
                                .prop("disabled", true);
                        }
                    }
                }
            });
        });


        // COPY ALL
        $(".copy-all-btn").off("click").on("click", function () {
            var $section = $(this).closest(".History-section");
            var $rows = $section.find(".History-row-text");
            $rows.each(function () {
                var $li = $(this).closest("li");
                var text = $(this).text();
                var Code = (this).nextElementSibling.textContent;
                var RxRowObj = {
                    code: Code,
                    name: text,
                    fordate: $(this).siblings(".History-row-ForDate").text(),
                    Intake: $(this).siblings(".History-row-Intake").text(),
                    durationno: $(this).siblings(".History-row-DurNo").text(),
                    type: $(this).siblings(".History-row-DurType").text(),
                    food: $(this).siblings(".History-row-Food").text(),
                    Route: $(this).siblings(".History-row-Route").text(),
                    Dosses: $(this).siblings(".History-row-Dossage").text(),
                    Qty: $(this).siblings(".History-row-Qty").text(),
                    Remark: $(this).siblings(".History-row-Remark").text(),
                    SetUpYn: $(this).siblings(".History-row-SetupYN").text(),
                    DrugFormCD: $(this).siblings(".History-row-DrugFormCD").text()
                };
                CopyBindToRXTable(RxRowObj);
                //GetAllRxList(text, Code, RxRowObj);
                $(".History-row-Code").each(function () {
                    var FlagForDuplicate = false;
                    if ($(this).text().trim() == RxRowObj.code &&
                        $(this).siblings(".History-row-Intake").text().trim() == RxRowObj.Intake &&
                        $(this).siblings(".History-row-DurNo").text().trim() == RxRowObj.durationno &&
                        $(this).siblings(".History-row-DurType").text().trim() == RxRowObj.type &&
                        $(this).siblings(".History-row-Route").text().trim() == RxRowObj.Route &&
                        $(this).siblings(".History-row-Dossage").text().trim() == RxRowObj.Dosses &&
                        $(this).siblings(".History-row-Qty").text().trim() == RxRowObj.Qty ) {
                        FlagForDuplicate = true;
                    }
                    if (FlagForDuplicate) {
                        var $sameRow = $(this).closest("li");
                        var $sameBtn = $sameRow.find(".copy-row-btn");
                        if ($sameBtn.length > 0) {
                            $sameBtn.html('<i class="fa fa-check text-success"></i>')
                                .removeClass("copy-row-btn")
                                .prop("disabled", true);
                        }
                    }
                });
            });
            $(this).html('<i class="fa fa-check text-success" style="background:white;"></i>')
                .removeClass("copy-all-btn")
                .prop("disabled", true);

        });

    }
    function parseDuration(value) {
        var match = value.trim().match(/^(\d+)\s*(\w+)$/i);
        if (match) {
            return {
                number: parseInt(match[1], 10),
                unit: match[2]
            };
        } else {
            return { number: 0, unit: "" };
        }
    }

    function CopyBindToRXTable(HistoryObj) {
        var rows = RxListtable.getData();
        var CurDate = getTodayDate();
        for (var i = 0; i < rows.length; i++) {
            var FlagForDuplicate = false;
            var MedName = "";
            if (GeneralWiseYN == "Y") {
                if (rows[i].GenericID == HistoryObj.code && rows[i].MedDate == CurDate &&
                    rows[i].Intake == HistoryObj.Intake && rows[i].DurNum == HistoryObj.durationno &&
                    rows[i].DurType == HistoryObj.type && rows[i].Route == HistoryObj.Route &&
                    rows[i].Dosses == HistoryObj.Dosses && rows[i].Qty == HistoryObj.Qty) {
                    FlagForDuplicate = true;
                    MedName = rows[i].GenericName;
                }
            }
            else {
                if (rows[i].DrugCode == HistoryObj.code && rows[i].MedDate == CurDate &&
                    rows[i].Intake == HistoryObj.Intake && rows[i].DurNum == HistoryObj.durationno &&
                    rows[i].DurType == HistoryObj.type && rows[i].Route == HistoryObj.Route &&
                    rows[i].Dosses == HistoryObj.Dosses && rows[i].Qty == HistoryObj.Qty) {
                    FlagForDuplicate = true;
                    MedName = rows[i].MaterialName;
                }
            }
            if (FlagForDuplicate) {
                ToastMsg((MedName + " with same For Date,Intake,Duration,Route,Dose,Qty already added"), "warning");
                $("#RxListMainDiv").hide();
                return;
            }
        }
        var RTList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
        var FilterFormList = RTList.filter(item => ("" + item.FORMCODE).trim() == HistoryObj.DrugFormCD);
        var FormCD = FilterFormList.length > 0 ? ("" + FilterFormList[0].FORMCODE).trim() : "";
        var FormNM = FilterFormList.length > 0 ? FilterFormList[0].FORMNAME : "";
        RxListtable.addRow({
            MaterialName: HistoryObj.name,
            DrugCode: HistoryObj.code,
            GenericName: HistoryObj.name,
            GenericID: HistoryObj.code,
            MedDate: getTodayDate(),
            Intake: HistoryObj.Intake,
            DurNum: HistoryObj.durationno,
            DurType: HistoryObj.type,
            BeforeAfter: HistoryObj.food,
            Route: HistoryObj.Route,
            Dosses: HistoryObj.Dosses,
            Qty: HistoryObj.Qty,
            Remark: HistoryObj.Remark,
            SetUpYn: "N",
            RefillYN: "N",
            ROUTINEYN: "N",
            PHSTATUS: "A",
            TAMPERING: "N",
            FORMNAME: FormNM,
            FORMCODE: FormCD
        }).then(function (row) {
            adjustTableHeight("RxTable");
        });
    }
</script>

<%--Setup For RX--%>
<script type="text/javascript">
    function SetupPopupRXContent() {
        return `
        <div class="FilterClassDivPopup">
        <button class="btn btn-primary" onclick="ValidationForSetupRXBindTran('Setup_RX')"><i class="fa fa-save"></i> Apply</button>
        <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('RX', 'RXSetup')">
        </div>
        <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
        `;
    }

    function CreateTabulatorRXSetup(TabulatorSetupId) {
        var SetupRXListTable = new Tabulator(("#" + TabulatorSetupId), {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            index: "code",
            columns: [
                {
                    title: "Action",
                    field: "act",
                    width: 100,
                    headerSort: false,
                    hozAlign: "center",
                    formatter: function (cell, formatterParams, onRendered) {
                        return `
                        <div style="display: flex; gap: 15px; justify-content: center; align-items: center;">
                            <input type="checkbox" class="row-checkbox" style="cursor:pointer; width:16px; height:16px;">
                            <i class="fa fa-pencil text-primary edit-row" style="cursor:pointer; font-size: 16px;" title="Edit"></i>
                        </div>
        `;
                    },
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var target = e.target;
                        var rowData = cell.getRow().getData();
                        if (target.classList.contains("row-checkbox")) {
                            var isChecked = target.checked;
                            var newValue = isChecked ? "Y" : "N";
                            row.update({ CHECKYN: newValue });
                        }
                        if (target.classList.contains("edit-row")) {
                            OpenPopupForNewItem('RX', 'RXSetup');
                            BindRXEditSetup(rowData)
                        }
                    }
                },
                { title: "CHECKYN", field: "CHECKYN", visible: false },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    formatter: "textarea",
                    formatterParams: {
                        minHeight: "auto",
                    },
                    cssClass: "wrap-text"
                }
            ]
        });
        BindRXSetupList(TabulatorSetupId);
    }

    function BindRXSetupList(TabulatorSetupId) {
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetPersDiseaseList","DoctorDesk")%>",
            data: { CIMS: "N" },
            asycn: false,
            success: function (response) {
                if (response != "" && response.toUpperCase() != "UNSUCESSFULL") {
                    var result = JSON.parse(response);

                    if (result.Table1 && result.Table1.length > 0) {

                        var formattedData = result.Table1.map(function (row) {
                            return {
                                CHECKYN: "N",
                                code: row.CODE,
                                name: row.DESC
                            };
                        });
                        var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

                        if (table) {
                            table.setData(formattedData);
                        }
                    }
                }
            }
        });
    }

    function ValidationForSetupRXBindTran(TabulatorSetupId) {
        var SelCode = "";
        var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

        if (table) {
            var TableAllData = table.getData();
            SelCode = TableAllData
                .filter(function (row) {
                    return row.CHECKYN === "Y";
                })
                .map(function (row) {
                    return row.code;
                })
                .join(",");
            SetRXSetupToTran(SelCode);
            SetDataForRx();
        }
    }

    function SetRXSetupToTran(strCode) {
        $.ajax({
            url: '../DoctorDesk/SavePersonDises',
            data: { Code: strCode, strTranNO: sessionStorage.getItem("PatTRANNO"), strMRNo: sessionStorage.getItem("PatMRNO") },
            type: 'post',
            datatype: 'get',
            async: false,
            success: function (result) {
                if (result.length > 0) {
                    if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        //SetDataForRx();
                    }
                    else if (("" + result).toUpperCase().indexOf("FAILED") != -1) {
                        ToastMsg(result, "warning");
                    }
                    //SetDataForRx();
                }
                closeMaxMinPopup('Hist_M_RX');
            }
        })
    }

    function ContentForAddNewItemRXSetup() {
        return `
        <div class="mb-3">
                 <input id="txtSetupNameCode" type="text" class="form-control " style="display:none" />
               </div>
        <div class="mb-3">
          <input id="txtSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
        </div>
        <div class="mb-3">
              <div id="RXTableSetupNew"></div>
        </div>
    `;
    }

    function FooterContentForAddNewItemRXSetup() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForRXSetup('')" tabindex="4">Save</button>
        `;
    }

    function CreateRXSetupNewTabultor() {
        var RXSetupNewTabultor = new Tabulator(("#RXTableSetupNew"), {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "350",
            index: "code",
            columns: [
                {
                    title: "",
                    field: "CHECKYN",
                    formatter: "tickCross",
                    editor: true,
                    hozAlign: "center",
                    width: 100
                },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    formatter: "textarea",
                    formatterParams: {
                        minHeight: "auto",
                    },
                    cssClass: "wrap-text"
                }
            ]
        });
        RXSetupNewTabultor.on("tableBuilt", function () {
            BindRXSetupNewList();
        });
    }

    function BindRXSetupNewList() {
        var DataToSend = {
            ClinicCode: sessionStorage.getItem('ClinicCode')
        };
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetNonFreqDrugLstFrRxDesktop","DoctorDesk")%>",
            data: DataToSend,
            async: false,
            success: function (response) {
                if (response != "") {
                    response = JSON.parse(response);
                    if (response.Table != null && response.Table != undefined) {
                        var formattedData = response.Table.map(function (row) {
                            return {
                                CHECKYN: false,
                                code: GeneralWiseYN == "Y" ? row.GENERICID.trim() : row.MTRLCODE.trim(),
                                name: GeneralWiseYN == "Y" ? row.GENERICNAM.trim() : row.MTRLNAME.trim()
                            };
                        });
                        var table = Tabulator.findTable("#RXTableSetupNew")[0];
                        if (table) {
                            table.setData(formattedData);
                        }
                    }
                }
            }
        });
    }

    function BindRXEditSetup(RowData) {
        $.ajax({
            url: '../DoctorDesk/GetMedListBySetupCode',
            data: { strSetUpCode: RowData.code },
            type: 'post',
            datatype: 'get',
            success: function (response) {
                if (response != "") {
                    var codeMap = {};
                    $.each(response, function (i, val) {
                        var RespValue = GeneralWiseYN == "Y" ? val.GENERICID : val.CODE
                        if (RespValue) {
                            codeMap[RespValue] = true;
                        }
                    });
                    var table = Tabulator.findTable("#RXTableSetupNew")[0];
                    table.getRows().forEach(function (row) {
                        row.update({
                            CHECKYN: codeMap[row.getData().code]
                        });
                    });
                }
                $("#txtSetupNameCode").val(RowData.code);
                $("#txtSetupName").val(RowData.name);
            }
        })
    }

    function ValidationForNewItemRXSetup() {
        var table = Tabulator.findTable("#RXTableSetupNew")[0];
        if ($("#txtSetupName").val().trim().length === 0) {
            ToastMsg("Enter Setup Name", "warning");
            $("#txtSetupName").focus();
            return false;
        }
        if (table.getData().filter(function (row) { return row.CHECKYN === true; }).length == 0) {
            ToastMsg("Select Atleast One Rx.", "warning");
            return false;
        }
        return true;
    }

    function SaveNewItemForRXSetup() {
        if (ValidationForNewItemRXSetup() == true) {
            var table = Tabulator.findTable("#RXTableSetupNew")[0];
            var ServiceData = [];
            // var AllRowData = table.getData();
            var AllRowData = table.getData().filter(function (row) { return row.CHECKYN === true; });
            for (var i = 0; i < AllRowData.length; i++) {
                var NewData = {
                    ABFOOD: "A",
                    DAYS: "",
                    DOSSAGE: "",
                    DRUGCD: AllRowData[i].code,
                    DRUGFORM: "",
                    DRUGNM: AllRowData[i].name,
                    DURATION: "",
                    GENERICID: AllRowData[i].code,
                    GENERICNAME: AllRowData[i].name,
                    INTAKECD: "",
                    INTAKEDESC: "",
                    ROUTE: "",
                    Remarks: "",
                    SOSYN: "N",
                }
                ServiceData.push(NewData);
            }
            ServiceData = JSON.stringify(ServiceData);
            $.ajax({
                type: "post",
                datatype: "json",
                url: '../DoctorDesk/AddMedicineSetUp',
                data: { strMedicineSetUpName: $("#txtSetupName").val(), strMedicineLst: ServiceData.toString(), strSetUpCode: $("#txtSetupNameCode").val(), CIMSYN: "N" },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        BindRXSetupList('Setup_RX');
                        closeAddNewItemPopup('RXSetup');
                    }
                    else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                        ToastMsg("This Set Up is already Present.", "warning");
                    }
                    else {
                        ToastMsg("Error!!Please Contact IT Dept.", "error");
                    }
                },
            });
        }
    }

</script>

<div id="sec-Rx" class="opd-section-card anchor-offset">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h4 class="section-title me-5">Rx</h4>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="RxSearch" class="form-control" placeholder="Search Rx" onclick="GetFrequentRx()" oninput="GetAllRxList()">  <%--oninput="FilterBindedSearchListForRx()"--%>  <%--// Modified Pournima 16th June 2026--%>
                <button class="btn btn-outline-success" id="RxAdd" onclick="OpenPopupForNewItem('Rx' , 'RX')"><i class="fa fa-plus"></i></button>
                <button class="btn btn-outline-success" id="Rx_PrevHistory" onclick="HistoryPopupOpen('Rx', 'RX',true)"><i class="fa fa-history"></i></button>
                <button class="btn btn-outline-success btn-sm d-none"  id="RX_Setup" onclick="SetupPopupOpen('RX','RX',false)">Setup</button>
              
                <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("I")) { %>
                                
                    <button class="btn btn-outline-success" id="btnInformantRx" title="Drug Interaction" style="float: right; margin-left: 5px; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('I',RxListtable,'RxListtable')">
                        <%--<img src="../Images/CIMS_Images/DrugInteraction.png" style="height: 20px; width: 20px;">--%>
                          <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                              <rect x="34" y="1.48619e-06" width="34" height="34" rx="4" transform="rotate(90 34 1.48619e-06)" fill="gray"/>
                              <path d="M21.25 22.3125L21.25 28.6875L27.625 28.6875" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                              <path d="M21.2502 28.6875L25.0062 24.9316C27.1812 22.7564 28.4111 19.8115 28.429 16.7354C28.4469 13.6594 27.2514 10.7003 25.1018 8.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                              <path d="M12.75 11.6875L12.75 5.3125L6.375 5.3125" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                              <path d="M12.75 5.3125L8.99406 9.06844C6.81899 11.2436 5.58913 14.1886 5.57123 17.2646C5.55333 20.3406 6.74883 23.2997 8.89844 25.5" stroke="#FDFDFD" stroke-linecap="round" stroke-linejoin="round"/>
                          </svg>
                    </button>

                <% } %>
                
                <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("D")) { %>

                <button class="btn btn-outline-success" id="btnDuplicateRx" title="Drug Duplicate" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('D',RxListtable,'RxListtable')">
                    <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                      <svg width="24" height="24" viewBox="0 0 34 34" fill="none">
                        <rect width="34" height="34" rx="4" fill="gray"/>
                        <path d="M8.78261 10.9345V27.7606H22.087V14.8476L19.7391 10.781H8" stroke="white" stroke-width="1.56522"/>
                        <path d="M11.9131 10.5434V6.23901H21.6957L26 10.5434V24.239H22.4783" stroke="white" stroke-width="1.56522"/>
                        <path d="M16.0103 17.395L12.8951 20.5102C12.3528 21.0525 12.3528 21.9319 12.8951 22.4742L12.8953 22.4744C13.4377 23.0168 14.317 23.0168 14.8594 22.4744L17.9745 19.3593C18.5169 18.8169 18.5169 17.9376 17.9745 17.3952L17.9743 17.395C17.432 16.8527 16.5526 16.8527 16.0103 17.395Z" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M14.4526 18.9525L16.4169 20.9168" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M16.417 19.443L17.1536 18.7064" stroke="white" stroke-width="0.782609" stroke-linecap="round" stroke-linejoin="round"/>
                      </svg>
                </button>

                <% } %>

                <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("A")) { %>

                <button class="btn btn-outline-success" id="btnAllergyRx" title="Drug Allergy" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('A',RxListtable,'RxListtable')">
                    <%--<img src="../Images/CIMS_Images/duplicate.png" style="float: right; height: 20px; width: 20px;" />--%>
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 200 200" fill="none">
                          <rect width="200" height="200" rx="8" fill="gray"/>
                          <path d="M138.5 174.5L103.686 139.686C100.686 136.686 96.616 135 92.3726 135H80.0342C76.7572 135 73.5593 133.994 70.8728 132.117L47.1549 115.553C44.8646 113.953 43.5 111.336 43.5 108.542V108.293C43.5 106.185 44.3377 104.162 45.8287 102.671C46.9193 101.581 48.3036 100.831 49.8128 100.513L50.9598 100.272C54.7468 99.4744 58.6849 100.569 61.5167 103.207L66.125 107.5L30.3385 70.4228C28.8384 68.8686 28 66.7928 28 64.6327C28 62.6132 28.733 60.6623 30.0629 59.1424L30.8934 58.1933C31.2972 57.7318 31.7366 57.3028 32.2077 56.9103L34.5 55C35.3766 54.4156 36.5413 54.5181 37.3024 55.2465L71 87.5L34.1423 50.1758C32.5068 48.5195 31.877 46.1176 32.4895 43.872C32.8226 42.6504 33.5039 41.5521 34.4502 40.7109L36.3999 38.9779C37.1226 38.3355 37.9899 37.8775 38.928 37.643C40.5661 37.2335 42.301 37.534 43.7059 38.4706L47.5 41M47.5 41L80 74M47.5 41L50.2581 38.2419C51.0835 37.4165 51.9969 36.6838 52.9818 36.0571L55.0563 34.7369C56.3257 33.9291 57.7992 33.5 59.3039 33.5C61.3541 33.5 63.3243 34.2959 64.7993 35.72L66.125 37M91.5 61.5L66.125 37M66.125 37L67.2143 34.9667C67.7363 33.9923 68.371 33.0826 69.1054 32.2564L70.0878 31.1512C71.3336 29.7497 72.9732 28.7567 74.7923 28.3019C78.0158 27.4961 81.4245 28.4677 83.7387 30.852L96.5 44M111.5 59.5L123.845 71.4339C125.592 73.1224 126.931 75.1866 127.762 77.4698L129.537 82.3509C130.174 84.1035 130.5 85.954 130.5 87.8188V96.8726C130.5 101.116 132.186 105.186 135.186 108.186L164 137" stroke="white" stroke-width="7" stroke-linecap="round"/>
                          <circle cx="104.5" cy="51.5" r="4" fill="white" stroke="white"/>
                          <circle cx="83.5" cy="90.5" r="3" fill="white" stroke="white"/>
                          <circle cx="87.5" cy="113.5" r="8" fill="white" stroke="white"/>
                          <circle cx="103.5" cy="81.5" r="8" fill="white" stroke="white"/>
                          <circle cx="116" cy="106" r="2.5" fill="white" stroke="white"/>
                          <circle cx="112" cy="127" r="2.5" fill="white" stroke="white"/>
                          <circle cx="135" cy="130" r="6.5" fill="white" stroke="white"/>
                          <circle cx="156.5" cy="164.5" r="7" fill="white" stroke="white"/>
                          <circle cx="139" cy="152" r="2.5" fill="white" stroke="white"/>
                          <circle cx="172" cy="145" r="2.5" fill="white" stroke="white"/>
                     </svg>
                </button>
           
                <% } %>

            </div>
            <div id="RxListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="RxList" class="list-group w-100"></div>
                <div id='loading-Rx-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="RxTable"></div>
    <div id='loading-Rx' class='loading-screen' style='display: none; opacity: 0;'></div>
</div>
