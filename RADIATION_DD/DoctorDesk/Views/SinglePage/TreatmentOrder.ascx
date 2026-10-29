  <%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.TreatmentOrder>" %>
    <script type="text/javascript"
        src="<%= Url.Content("~/Scripts/SinglePage/TreatmentOrder.js") %>?v=<%= System.IO.File.GetLastWriteTime(Server.MapPath("~/Scripts/SinglePage/TreatmentOrder.js")).Ticks %>">
    </script>

<%-- Dose Popup Only --%>
<style>
    .dose-hide{
        display:none;
    }
    .dose-medicine-name{
        font-weight:bold;
    }
    .BtnInke {
        width: 60px;
        border-radius: 5px 5px 5px 5px;
        height: 28px;
        text-align: center;
        margin-right: 20px;
        /*background-color: rgba(76, 228, 76, 0.67);*/
        background-color: #ffffff;
        cursor: pointer;
        display: inline-block !important;
        max-width: 100%;
        margin-bottom: 5px !important;
    }

    .HighAlertDrug {
        background-color: #ffcccc !important;
    }

    .tabulator-col-sorter {
        visibility: hidden;
    }

    .tabulator .tabulator-header .tabulator-col.tabulator-sortable .tabulator-col-title {
        padding-right: 0px !important;
    }

    .HighAlertDrug .tabulator-cell {
        background-color: #ffcccc !important;
    }

    .Omited {
        /*opacity: 0.6 !important;*/
        text-decoration: line-through !important;
    }

    .tabulator-col[field="action"] {
        background-color: #f8f8f8 !important;
        border-right: 2px solid #ccc !important;
    }

    .tabulator-col[field="OMIT"] {
        background-color: #f8f8f8 !important;
        border-right: 2px solid #ccc !important;
    }

    .TabTextArea {
        white-space: pre-wrap !important;
        word-wrap: break-word !important;
        overflow-wrap: break-word !important;
        min-height: 40px;
        max-height: none !important;
    }

    .tabulator-cell {
        overflow: visible !important;
    }

    .dose-popup-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.6);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
    }

    .dose-popup {
        background: #fff;
        border-radius: 12px;
        width: 600px;
        max-width: 90%;
        padding: 20px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        animation: popupFade 0.3s ease-in-out;
    }

    .dose-title {
        font-size: 20px;
        font-weight: bold;
        color: #ffffff;
        text-align: center;
        margin-bottom: 15px;
        background-color: #003a6f;
    }

    .dose-row {
        display: flex;
        align-items: center;
        margin: 10px 0;
    }

    .dose-label {
        font-weight: 600;
        margin-right: 10px;
    }

    .dose-select {
        padding: 5px 10px;
        border-radius: 6px;
        border: 1px solid #ccc;
        margin-right: 20px;
    }

    .dose-buttons {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        justify-content: center;
        margin: 15px 0;
    }

    .dose-btn {
        background: #f5f5f5;
        border: 1px solid #ddd;
        border-radius: 6px;
        padding: 8px 12px;
        cursor: pointer;
        transition: all 0.2s;
    }

        .dose-btn:hover {
            background: #3498db;
            color: #fff;
        }

    .dose-intake-controls {
        text-align: center;
        margin: 15px 0;
    }

    .icon-btn {
        font-size: 24px;
        color: #3498db;
        cursor: pointer;
        margin: 0 10px;
    }

        .icon-btn:hover {
            color: #2ecc71;
        }

    .dose-actions {
        text-align: center;
        margin-top: 20px;
    }

    .action-btn {
        padding: 8px 16px;
        border-radius: 6px;
        border: none;
        margin: 0 8px;
        cursor: pointer;
        transition: all 0.2s;
    }

        .action-btn.primary {
            background: #3498db;
            color: #fff;
        }

        .action-btn.secondary {
            background: #95a5a6;
            color: #fff;
        }

        .action-btn.danger {
            background: #e74c3c;
            color: #fff;
        }

        .action-btn:hover {
            opacity: 0.85;
        }

    @keyframes popupFade {
        from {
            transform: scale(0.9);
            opacity: 0;
        }

        to {
            transform: scale(1);
            opacity: 1;
        }
    }

    .IndicatorDiv {
        display: flex;
        align-items: center;
        gap: 25px;
        flex-wrap: wrap;
        flex-direction: row-reverse;
        padding-top: 5px;
    }

    .indentIconImage {
        width: 25px;
        height: 25px;
    }

    .imgdiv {
        display: flex;
        align-items: center;
        gap: 5px;
    }
</style>

<style>
    .HeaderSearchList {
        background-color: #284c72;
        color: white;
        text-align: center;
        padding: 5px;
    }
    .HeaderSearchList-Border {
            border-right: 2px solid;
    }

    .GroupOption {
        display: flex;
    }

    .AntiMed-row-Mtrl:hover {
        background-color: #ebebeb;
    }

    .AntiMed-row-Gen:hover {
        background-color: #ebebeb;
    }

    .AntiMed-row-Mtrl:hover {
        background-color: #ebebeb;
    }

    .Medication-row-Gen:hover {
        background-color: #ebebeb;
    }

    .SearchHeaderMainDiv {
        display: flex;
        position: sticky;
        top: 0;
        background: white;
        z-index: 10;
        border-bottom: 1px solid #ccc;
    }
</style>
<style>
    #ProtocolInfoSection {
    background: #f8f9fa;
    border: 1px solid #d6d6d6;
    border-radius: 4px;
}

#ProtocolInfoSection label {
    font-size: 14px;
    font-weight: 600;
}

#ProtocolInfoSection span {
    font-size: 14px;
    font-weight: 500;
    color: #212529;
}
#chemoPlanNo span,
#chemoPlanDt span {
    font-size: 14px;
    font-weight: 500;
    color: #212529;
    }

    .IndicatorDiv {
        display: flex;
        align-items: center;
        gap: 18px;
    }

    .imgdiv,
    .imgdivIss,
    .legendItem {
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .legendColor {
        width: 18px;
        height: 18px;
        border-radius: 3px;
        display: inline-block;
    }

    .planned {
        background-color: #f4d6f4c7 !important;
    }
    .plannedOmitted
    {
         background-color: #fee188 !important;
    }
    .hold {
        background-color: #65e5e1cf !important;
    }

    .omitted {
        background-color: #b3e3bf !important;
    }

    .cancelled {
        background-image: linear-gradient( to left top, #f9b596, #f9b292, #f9af8e, #f9ab8a, #f9a886 );
    }

    .administered {
        background: linear-gradient( to left, #ebd0b75e, #ffc837 ) !important;
    }
    .rollOverData
    {
        background-color: yellow !important;
        border:1px solid black;
    }
    .statsosMed{
         background-color: #b89eeacf !important;
    }
    .legendItem {
        display: flex;
        align-items: center;
        white-space: nowrap;
        flex-shrink: 0;
    }

    #divInnerHeader {
        flex-shrink: 0;
    }
    .avoid-clicks {
    pointer-events: none;
   /* opacity: 0.6;*/
}

/*.avoid-clicks .tabulator-cell[tabulator-field="action"],
.avoid-clicks .tabulator-cell[tabulator-field="CIMS"],
.avoid-clicks .tabulator-cell[tabulator-field="OMIT"],
.avoid-clicks .tabulator-cell[tabulator-field="Remark"]{
    pointer-events: auto;*/
    /*opacity: 1;*/
/*}*/

    .disable-cell {
        pointer-events: none;
       /* opacity: 0.6;*/
}
</style>
<%--Abhishesh || 20261006--%>
<%-- ===== SinglePageIPD > Treatment Order (06-Oct-2026) ===== --%>
<style>
    #btnMainRollOver,
    #btnRollOver,
    .btnRollOver,
    #btnRollBack,
    .btnRollBack,
    #divRollOverLegend,
    #lblRoll,
    #txtRollverDate {
        display: none !important;
    }
</style>
<%--End--%>
<%--Added by aaryshree 20260625--%>
<style>

.NewDrug {
    padding: 0 !important;
}

/*.custom-popup {
    width: 100%;
    overflow: hidden;
}
*/
.popup-header {
    background: #1976d2;
    color: #fff;
    padding: 15px 20px;
    font-size: 26px;
    font-weight: 500;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.popup-body {
    padding: 15px;
}

/*.form-control {
    width: 100%;
    height: 40px;
    border: 1px solid #1976d2;
    border-radius: 4px;
    padding: 0 12px;
    box-sizing: border-box;
   
}*/

.popup-footer {
    padding: 15px;
    text-align: right;
}
    .ui-dialog .ui-dialog-titlebar {
    background: #1976d2;
    color: white;
    border: none;
}

.ui-dialog {
    border-radius: 8px;
    overflow: hidden;
}
.close-btn {
    cursor: pointer;
    font-size: 24px;
}

.popup-body {
    padding: 15px;
}

.form-control:focus {
    border-color: #1976d2;
    outline: none;
    box-shadow: 0 0 5px rgba(25,118,210,.3);
}

.checkbox-label {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
}


.save-btn {
    background: #1976d2;
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 10px 22px;
    cursor: pointer;
    font-size: 14px;
}

.save-btn:hover {
    background: #1565c0;
}
    .NewDrug .ui-dialog-titlebar {
        background: #1976d2 !important;
        color: #fff !important;
        border: none !important;
        font-size: 14px;
    }
  /*  .Mandatory {
    border-right: 3px solid red;
}*/
    .rollover-cell {
        background-color: yellow !important;
        color: #000 !important;
    }

    .Planed {
        background-color: #f4d6f4c7 !important;
    }

    .PlanedOmitt {
        background-color: #fee188 !important;
    }
</style>
<%--End--%>

<%-- Global Declaration and Form Load --%>
<script type="text/javascript">
    var IPNO = sessionStorage.getItem("IPPatIPNO");
    var MRno = sessionStorage.getItem("IPPatMRNO");
    var PatName = sessionStorage.getItem("IPPatName");
    var GAction = "N";
    var TreatmentOrderTranNo = "";
    var MandStyle = '<span style="color:red;">';
    var IsOnlyDisplay = false;
    var IsPastDate = false;
    var PlanData = '';
    var IsPlanMData = false;
    var IsPlanAData = false;
    var IsrolloverData = 'N';
    var ISRYN = '';
    //var IS_DISPLAY_CIMS_FUNCTIONLITY = 'Y';
    var MaxSEQ = "";
    var UserId = '<%: Session["gOncoUserId"] ?? "" %>';
    //var Time = new Date();
    //var CuurentTime = Time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
    var Gbl_TranNo = "";
    var TrmtntOrderMedicineTable;
    var TrmtntOrderMedicationTable;
     <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var NutritionList = '<%:Html.Raw(Samp.Serialize(ViewBag.NutritionList))%>';
    var DefaultRouteValue = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("SetDefaultRouteValueText")%>';
    var medicineTypeMap = load_MedicineType();
    var medicationTable = ""; 
    var GenericWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
    var globalDoclst = "";
    var specilizationlist = "";
    var isNewMedcine = false;
    var CurrentPlan = {};
    var admitDateIPD = sessionStorage.getItem("IPDADMNDATE");
    var ServerTime = '<%= ViewBag.CurrServerTime %>';
    var ServerDate = '<%= ViewBag.CurrServerDate %>';
    var DropRate = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("BloodProductDropFactor")%>';
    let IVFluidNextSeq = null;
    $(document).ready(function () {
        /* Common On Load Form Call Start*/
        //Abhishesh || 20260731
        if (GenericWiseYN == "Y") {
            $(".list-group-LHead").hide();
            $(".list-group-RHead").hide();
        }
        //End
        $(".btn-group > .btn").click(function () {
            $(".btn-group > .btn").removeClass("active");
            $(this).addClass("active");
        });
        $("#txtMedicineName").on("input", function () {
            if ($(this).val().trim() !== "") {
                $(this).css("border-color", "");
            }
        });

        $("#txtGenericName").on("input", function () {
            if ($(this).val().trim() !== "") {
                $(this).css("border-color", "");
            }
        });

        $("#txtBrandName").on("input", function () {
            if ($(this).val().trim() !== "") {
                $(this).css("border-color", "");
            }
        });
        $("#txtTransDate").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            autoClose: true,
        })
       //    .on("change", function () {
       //    //ClearcontrolData();
       //    var ChangeDate = $(this).val();
       //    IsRetrivedataByDate = true;
       //    LoadOnDateChange(ChangeDate);
       //    $('#tractiondropdown').find('option').remove();
       //    GetTranslstData();
       //    if (IsPastDate) {
       //        DisabledGrid();
       //    }
       //    var selectedDate = $('#txtTransDate').datepicker('getDate');
       //    var now = new Date();
       //    now.setHours(0, 0, 0, 0);
       //    if (selectedDate < now) {
       //        $('#lblModeIndicator').text("View");
       //        $('#btnRollOver').hide();
       //    }
       //    else {
       //        if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
       //            $('#btnSave').removeClass('Visibility')
       //            $('#btnSave').val('Save');
       //        }
       //        else {
       //        }
       //    }
       //});
        SetMinMaxOptions();
        $("#txtTransDate").datepicker('setDate', 'today');
        $('#txtTransTime').timepicker({
            timeFormat: 'hh:mm TT',
            timeInput: true,
        })
        $('#txtTransTime').change(function () {
            AMPMConvert();
        });

        load_Specilizationlist();
        load_Doctor();

        $('#btnAddOncologist').click(function () {
            $("#OncologistContainer").show();
            addReferralRow();
        });

        //Pournima 25th Feb 2026
        $('#btnAddNutriIntake').click(function () {
            $("#NutriContainer").show();
            addNutriRow();
        });

        $(document).on('click', '.btnRemoveReferral', function () {
            $(this).closest('.referral-row').remove();
        });
        // Referral Doctor: Cancel icon (shown only for saved referrals) || 20261006
        $(document).on('click', '.btnCancelReferral', function () {
            CancelReferralRow($(this).closest('.referral-row'));
        });
        //End
        $(document).on("click", ".btnRollOver", function () {

            var tabType = $(this).data("tabtype");
            ISRYN = "Y";
            startLoading("Loading");
            GetTreat(tabType);
            ISRYN = "N";
            stopLoading();
        });
        $("#btnMainRollOver").on("click", function () {

            $(".btnRollOver").each(function () {
                $(this).trigger("click");
            });

        });
        setcurrentDate(ServerTime);
        AMPMConvert();
        /* Medicine Tabulator and Other*/
        TrmtntOrderMedicineTable = new Tabulator("#TrmtntOrderMedicineTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            index: "SQNumber",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "CIMS INFO",
                    field: "CIMS",
                    width: 90,
                    headerSort: false,
                    hozAlign: "center",
                    visible: IS_DISPLAY_CIMS_FUNCTIONLITY ? IS_DISPLAY_CIMS_FUNCTIONLITY == "Y" : false,
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if (data.OMIT === "Y" && !data.isSavedOmit) {
                            return "";
                        }
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
                //getActionColumn(),
                {
                    title: "Action",
                    field: "action",
                    width: 72,
                    hozAlign: "center",
                    //formatter: function (cell) {
                    //    return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    //},
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if (data.OMIT === "Y" || data.OMIT === true) {
                            return "";
                        }
                        if (data.STATUS === "C") return "";

                        var html = '<div class="action-container">';

                        var holdStatus = (data.HOLD || "N").toString().toUpperCase();

                        if (data.isFromServer) {
                            if (holdStatus === "Y") {

                                html += '<i class="fa fa-play text-success action-btn" data-action="resume" title="Resume/Unhold"></i>';
                            } else {
                                html += '<i class="fa fa-pause text-info action-btn" data-action="hold" title="Hold"></i>';

                                if (data.ADMINYN !== "Y" && data.IsRollOver !== "Y") {
                                    html += '<i class="fa fa-ban text-warning action-btn" data-action="cancel" title="Cancel"></i>';
                                }
                            }
                        }
                        if (!data.isFromServer) {
                            html += '<i class="fa fa-trash text-danger action-btn" data-action="delete" style="cursor:pointer; margin-right: 5px;" title="Delete"></i>';
                        }

                        html += '</div>';
                        return html;
                    },
                    cellClick: function (e, cell) {
                        e.stopPropagation();
                        var target = e.target;
                        if (!target.classList.contains('action-btn')) return;

                        var row = cell.getRow();
                        var data = row.getData();
                        var actionType = target.getAttribute('data-action');
   
                        if (target.classList.contains('fa-trash')) { //priyanka 06/03/2026
                            if (!data.isFromServer) {
                                TrmtntOrderMedicineTable.deleteRow(row);
                            }
                        }


                        // Hold Logic
                        if (actionType === "hold") {
                            openHoldModal(function (reason) {
                                if (!reason || reason.trim() === "") {
                                    ToastMsg("Please enter the reason for hold", "info");
                                    return false; //  modal open
                                }
                                // If reason exists, process hold
                                processHoldUpdate(row, "Y", reason, "Process Hold Successful");
                                return true;
                            });
                        }

                        // Resume 
                        else if (actionType === "resume") {
                            if (confirm("Are you sure you want to Unhold this record?")) {
                                processHoldUpdate(row, "N", "", "Process Unhold Successful");
                            }
                        }
                        //Cancel and Delete
                        else if (actionType === "cancel") {
                            handleCancelRow(row);
                        }
                        else if (actionType === "delete") {
                            TrmtntOrderMedicineTable.deleteRow(row);
                            if (IS_DISPLAY_CIMS_FUNCTIONLITY == "Y") {
                                // Added By Roshan Condtion Based On WebConfigs
                                toogleButtons(TrmtntOrderMedicineTable, 'TrmtntOrderMedicineTable');//For Show And Hide The Interaction and Duplicate Button Added By Roshan 12/12/2025
                            }
                        }
                    }

                },

                getDayOfDrugColumn(),
                {
                    title: "<span style='color:red'>Duration of Days</span>",
                    field: "Duration",
                    width: 160,
                    hozAlign: "center",
                    editor: "input",
                    editorParams: {
                        elementAttributes: {
                            maxlength: 5,
                            oninput: "this.value=this.value.replace(/\\D/g,'')"
                        }
                    },
                    formatter: function (cell) {
                        const rowData = cell.getRow().getData();

                        if (rowData.IsRollOver === "Y") {
                            cell.getElement().classList.add("rollover-cell");
                        } else {
                            cell.getElement().classList.remove("rollover-cell");
                        }

                        return cell.getValue();
                    },
                    cellEdited: function (cell) {
                        const row = cell.getRow();
                        const data = row.getData();

                        row.update({
                            ENDDATE: calculateEndDate(
                                data.AntiBoDGSTARTDATE,
                                data.Duration
                            )
                        });
                    }
                    //validator: ["numeric"]
                },
                //{
                //    title: `<span style="color:red;">Drug Form</span>`,
                //    field: "Type",
                //    tooltip: true,
                //    editor: "list",
                //    width: 90,
                //    editorParams: {
                //        values: GrdAnitibioticType(),
                //        autocomplete: true,
                //        listOnEmpty: true,
                //        allowEmpty: false
                //    },
                //    formatter: "lookup",
                //    formatterParams: GrdAnitibioticType()
                //},
                //{
                //    title: '<span style="color:red;">Drug Form</span>',
                //    field: "FormName",
                //    editor: "input",
                //    width: 90,
                //    visible: true,
                //    editable: false,
                //},
                {
                    title: '<span style="color:red;">Drug Form</span>',
                    field: "FormName",
                    width: 90,
                    visible: true,
                    editor: "list",
                    editable: function (cell) {
                        var row = cell.getRow().getData();                 //Added by aaryshree 20260624
                        return row.IsNewDrug === "true";
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
                        const routeList = GetRouteList("N", found.FORMCODE);

                        let selectedRoute = "";
                        let selectedRouteCode = code;
                        if (routeList.length === 1) {
                            selectedRoute = routeList[0].Text;
                        } else {
                            const defaultItem = routeList.find(x => x.DEFAULTYN === "Y");
                            selectedRoute = defaultItem ? defaultItem.Text : "";
                            selectedRouteCode = defaultItem ? defaultItem.Value : "";
                        }
                        if (found) {
                            cell.getRow().update({
                                FormCode: found.FORMCODE,
                                FormName: found.FORMNAME,
                                Route: selectedRoute,
                                RoutCode: selectedRouteCode
                            });
                        }
                    }

                },
                {
                    title: '<span style="color:red;">Drug Form Code</span>',
                    field: "FormCode",
                    editor: "input",
                    visible: false,
                    editable: false,
                },
                {
                    title: "Drug Name",
                    field: "DrugName",
                    width: 300,
                    formatter: function (cell) {
                        let value = cell.getValue();
                        let data = cell.getRow().getData();
                        let icons = "";
                        if (data.ISSUEYN === "Y") {
                            icons += "<img src='../Images/Check.png' style='width:16px;height:16px;margin-left:5px;float:right;' title='Issued' />";
                        }
                        if (data.INDENTYN === "Y") {
                            icons += "<img src='../Images/pills.png' style='width:16px;height:16px;margin-left:5px;float:right;' title='Indented' />";
                        }
                        return value ? value + icons : "";
                    }
                },
                getDoseColumn(),
                getRouteColumn(true, "TrmtntOrderMedicineTable"),
                getFreqColumn(),
                {
                    title: "<span style='color:red'>Diluent<span>",
                    field: "Diluent",
                    width: 170,
                    editor: "input",
                    editorParams: { maxLength: 100 }
                },
                {
                    title: "<span style='color:red'>Dilution Volume</span>",
                    field: "DilutionVolume",
                    tooltip: true,
                    editor: "list",
                    width: 120,
                    editorParams: {
                        values: Get_DiluVolume(),
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: Get_DiluVolume()
                },
                {
                    title: "<span style='color:red'>Admin Duration</span>",
                    field: "AdminstrDuration",
                    tooltip: true,
                    editor: "list",
                    width: 115,
                    editorParams: {
                        values: Get_AdminDurData(),
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: Get_AdminDurData()
                },
                getRemarkColumn("TrmtntOrderMedicineTable"),//priyanka 06/03/2026
                {
                    title: "Start Date",
                    field: "AntiBoDGSTARTDATE",
                    width: 100,
                    editor: "input",
                    editable: false,
                    editorParams: { elementAttributes: { type: "date" } }
                },
                {
                    title: "End Date",
                    field: "ENDDATE",
                    width: 100,
                    editable: false
                },
                // getOmitColumn(),
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 53,
                    hozAlign: "center",

                    formatter: function (cell) {
                        let value = cell.getValue();
                        let isChecked = (value === true || value === "Y");

                        let input = document.createElement("input");
                        input.type = "checkbox";
                        input.checked = isChecked;

                        input.addEventListener("click", function (e) {
                            e.stopPropagation();
                        });

                        // input.addEventListener("change", function () {
                        //     cell.setValue(this.checked);
                        // });
                        input.addEventListener("change", function () {

                            cell.setValue(this.checked ? "Y" : "N");

                            var row = cell.getRow();
                            row.update({
                                OMIT: this.checked ? "Y" : "N",
                                isSavedOmit: false
                            });
                            row.getCell("CIMS").getElement().innerHTML =
                                row.getCell("CIMS").getColumn().getDefinition().formatter(row.getCell("CIMS"));

                            row.getCell("action").getElement().innerHTML =
                                row.getCell("action").getColumn().getDefinition().formatter(row.getCell("action"));
                        });

                        return input;
                    },

                    cellEdited: function (cell) {
                        updateRowColor(cell.getRow());
                    }
                },

                { title: "DrugCode", field: "DrugCode", visible: false },
                { title: "TypeCode", field: "TypeCode", visible: false },
                getOmittedByColumn(),
                getOmittedByNameColumn(),
                getOmittedDateColumn(),
                getOmittedTimeColumn(),
                getOrderedByColumn(),
                getOrderedByNameColumn(),
                getOrderedDateColumn(),
                getOrderedTimeColumn(),
                GetDrugSequenceNo(),
                GetHighAlertDrug(),
                GetNotifyYN(),
                GetStatus(),
                GetADMINYN(),
                { title: "MEDSTAT", field: "MEDSTAT", visible: false },
                { title: "ISSUEYN", field: "ISSUEYN", visible: false },
                { title: "INDENTYN", field: "INDENTYN", visible: false },
                { title: "IsRollOver", field: "IsRollOver", visible: false },
                { title: "CALCULATEON", field: "CALCULATEON", visible: false },
                { title: "HOLD", field: "HOLD", visible: false },

                {
                    title: "Hold Log",
                    field: "HoldLog",
                    width: 105,
                    formatter: LogInfo,
                    cellClick: function (e, cell) {
                        var d = cell.getData();

                        showHoldLog(d.TranNo, d.SQNumber, d.TypeCode, d.DrugCode);
                        console.log("Log info clicked for row:", cell.getData());
                    }
                }

            ],
            rowFormatter: function (row) {
                const data = row.getData();
                const element = row.getElement();
                var dayCell = row.getCell("DayOfDrug").getElement();

                if (data.OMIT === "Y") {
                    element.style.backgroundColor = "#d4edda";
                    dayCell.style.pointerEvents = "none";
                    dayCell.style.cursor = "not-allowed";
                } else {
                    element.style.backgroundColor = "";
                    dayCell.style.pointerEvents = "";
                    dayCell.style.cursor = "";
                }
                if (data.HighAlert === "Y") {
                    element.style.color = "#db0000";
                    element.style.fontWeight = "bold";
                } else {
                    element.style.color = "";
                    element.style.fontWeight = "";
                }

                if (data.HOLD === "Y") {
                    dayCell.style.backgroundColor = "#65e5e1cf ";
                    dayCell.style.fontWeight = "bold";
                } else {
                    dayCell.style.backgroundColor = "";
                    dayCell.style.fontWeight = "";
                }
                if (data.Freq !== "STAT" && data.Freq !== "SOS" && data.TypeCode !=="SO") {
                    if (PlanData.hasOwnProperty("TRETMEDICINE") &&
                        PlanData.TRETMEDICINE.length > 0 &&
                        CheckPlanData(data.SQNumber, "AB")) {
                        IsPlanAData = true;
                        row.getElement().classList.add(
                            data.OMIT === "Y" ? "PlanedOmitt" : "Planed"
                        );
                    }
                }
                let freqCell = row.getCell("Freq").getElement();
                if (data.Freq == "STAT"  || data.Freq == "SOS") {
                    row.getElement().classList.remove("Planed");
                    row.getElement().classList.remove("PlanedOmitt");
                    freqCell.style.backgroundColor = "#b89eeacf";
                    freqCell.style.fontWeight = "bold"
                }
                else {
                    freqCell.style.backgroundColor = "";
                    freqCell.style.fontWeight = "";
                }
                let cimsCell = row.getCell("CIMS").getElement();
                if (data.ADMINYN == "Y") {
                    cimsCell.style.background = "linear-gradient(to left, #ebd0b75e, #ffc837)";
                    row.getElement().classList.add("avoid-clicks");
                }
                else {
                    cimsCell.style.background = "";
                }
                let isPlanned = false;

                if (data.TypeCode !== "SO" && PlanData &&
                    Array.isArray(PlanData.TRETMEDICINE) &&
                    PlanData.TRETMEDICINE.length > 0) {

                    isPlanned = CheckPlanData(data.SQNumber, "AB");
                }

                let cellOMIT = row.getCell("OMIT");
                let checkbox = cellOMIT.getElement().querySelector("input[type='checkbox']");
                const enableOMIT = isPlanned || data.IsRollOver == "Y"
                if (checkbox) {
                    checkbox.disabled = !(enableOMIT);
                }

                if (isPlanned && data.OMIT === "Y" && data.isSavedOmit === true) {

                    row.getCells().forEach(function (cell) {

                        let field = cell.getColumn().getField();

                        if (!["CIMS","HoldLog"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });

                }
                else if (isPlanned && data.isSavedOmit === false) {
                    row.getCells().forEach(function(cell) {

                        let field = cell.getColumn().getField();

                        if (!["action", "CIMS", "Remark", "OMIT","HoldLog"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });
                }
                if (data.IsRollOver == "Y") {
                    row.getCells().forEach(function (cell) {
                        let fileds = cell.getColumn().getField();
                        if (!["action", "CIMS", "Duration", "HoldLog", "OMIT"].includes(fileds)) {
                            cell.getElement().classList.add("disable-cell");
                        }
                    });
                }
                if (!isEndDateSameAsServerDate(data)) {
                    row.getElement().classList.add("avoid-clicks");
                } else {
                    row.getElement().classList.remove("avoid-clicks");
                }
                row.getCells().forEach(cell => {
                    const field = cell.getColumn().getField();

                    if (field === "CIMS" || field === "HoldLog") {
                        cell.getElement().classList.remove("avoid-clicks");
                    } else if (!isEndDateSameAsServerDate(data)) {
                        cell.getElement().classList.add("avoid-clicks");
                    } else {
                        cell.getElement().classList.remove("avoid-clicks");
                    }
                });
               
                if (data.STATUS === "C" || (isPlanned && data.STATUS === "C")) {
                    row.getElement().classList.remove("Planed");
                    element.style.backgroundColor = "#f8d7da";
                    //element.style.color = "#721c24";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "none";
                }
            },
            // Cell click logic
            cellClick: function (e, cell) {
                var rowData = cell.getRow().getData();
                let field = cell.getColumn().getField();
                if (field === "DrugName") {
                    if (gCIMSYN === "Y") {
                        $('#lblMode').text('Generic Medicine (CMIS)');
                        $('#txtSearchMedicine').attr("placeholder", "Search By Medicine Name");
                    } else {
                        $('#lblMode').text('Generic Medicine');
                        $('#txtSearchMedicine').attr("placeholder", "Search By Generic Name & Medicine Name");
                        FancyDisplay("TrmtntOrderMedicineTable");
                    }
                }
                if (rowData.ADMINYN === "Y") {
                    if (field !== "action" && field !== "CIMS" && field !== "OMIT") {
                        e.stopPropagation();
                        return false;
                    }
                }
            },

            // Edit restrictions
            cellEditing: function (cell) {
                let field = cell.getColumn().getField();
                let data = cell.getRow().getData();
                // replicate JQGrid beforeEditCell: only allow editing OMIT if rollover
                if (data.IsRollOver === "Y" && field !== "OMIT") {
                    return false; // block editing
                }
                return true;
            },

            cellEdited: function (cell) {
                let data = cell.getRow().getData();
                if (data.OMIT === "Y") {
                    cell.getRow().getElement().classList.add("Omited");
                }
            },

            // replicate loadComplete logic
            dataLoaded: function (data) {
                data.forEach(row => {
                    if (row.OMIT === "Y") {
                        TrmtntOrderMedicineTable.updateRow(row.SQNumber, { Remark: null });
                    }
                    if (CheckAdministedData(row.SQNumber, "AB") && IsrolloverData != "Y") {
                        // disable editing certain cells if administered
                        let rowObj = TrmtntOrderMedicineTable.getRow(row.SQNumber);
                        if (rowObj) {
                            rowObj.getElement().classList.add("avoid-clicks");
                        }
                    }
                    //if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                    //    AddCIMSInfoBtn(TrmtntOrderMedicineTable, row.SQNumber);
                    //}
                });
            },

            // replicate gridComplete logic
            renderComplete: function () {
                let data = TrmtntOrderMedicineTable.getData();
                data.forEach(row => {
                    if (row.IsRollOver !== "Y" && row.OMIT === "N" && row.ADMINYN === "N" && row.NOTIFYN === "N") {
                        let cell = TrmtntOrderMedicineTable.getCell(row.SQNumber, "OMIT");
                        if (cell) {
                            let checkbox = cell.getElement().querySelector("input[type=checkbox]");
                            if (checkbox) checkbox.disabled = true;
                        }
                    } else if (row.IsRollOver === "Y") {
                        let cell = TrmtntOrderMedicineTable.getCell(row.SQNumber, "OMIT");
                        if (cell) {
                            let checkbox = cell.getElement().querySelector("input[type=checkbox]");
                            if (checkbox) checkbox.removeAttribute("disabled");
                        }
                    }
                });
                if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                    toogleButtons(TrmtntOrderMedicineTable, 'TrmtntOrderMedicineTable');
                }
                adjustTableHeight("TrmtntOrderMedicineTable");
            }


        });

        ////TrmtntOrderMedicineTable.on("cellEdited", function (cell) {
        ////    cell.getRow().normalizeHeight();
        ////    adjustTableHeight("TrmtntOrderMedicineTable");
        ////});

        TrmtntOrderMedicineTable.on("rowAdded", function (row) {
            //row.normalizeHeight();
            //adjustTableHeight("TrmtntOrderMedicineTable");
            toogleButtons(TrmtntOrderMedicineTable, "TrmtntOrderMedicineTable");
        });

        TrmtntOrderMedicineTable.on("rowDeleted", function (row) {
            //adjustTableHeight("TrmtntOrderMedicineTable");
            toogleButtons(TrmtntOrderMedicineTable, "TrmtntOrderMedicineTable");

        });

        //TrmtntOrderMedicineTable.on("dataLoaded", function () {
        //    adjustTableHeight("TrmtntOrderMedicineTable");
        //});

        TrmtntOrderMedicationTable = new Tabulator("#TrmtntOrderMedicationTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            index: "SQNumber",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "CIMS INFO",
                    field: "CIMS",
                    width: 90,
                    headerSort: false,
                    hozAlign: "center",
                    visible: IS_DISPLAY_CIMS_FUNCTIONLITY ? IS_DISPLAY_CIMS_FUNCTIONLITY == "Y" : false,
                    formatter: function(cell) {
                        var data = cell.getRow().getData();
                        if (data.OMIT === "Y" && !data.isSavedOmit) {
                            return "";
                        }
                        return "<i class='fa fa-info-circle' Title='CIMS Information' style='color:#2d70aa;font-size:20px;cursor:pointer'></i>";
                    },
                    cellClick: function(e, cell) {
                        if (!$(e.target).hasClass("fa fa-info-circle")) return;
                        if (!$(e.target).hasClass("fa-info-circle")) return;
                        var rowData = cell.getRow().getData();
                        var drugCode = rowData.DrugCode;
                        if (drugCode) {
                            getDrugInfo(drugCode);
                        }
                    }
                },
                //getActionColumn(),
                {
                    title: "Action",
                    field: "action",
                    width: 72,
                    hozAlign: "center",
                    //formatter: function (cell) {
                    //    return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    //},
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if (data.OMIT == "Y" || data.OMIT == true) {
                            return "";
                        }
                        if (data.STATUS === "C") return "";

                        var html = '<div class="action-container">';

                        var holdStatus = (data.HOLD || "N").toString().toUpperCase();

                        if (data.isFromServer) {
                            if (holdStatus === "Y") {

                                html += '<i class="fa fa-play text-success action-btn" data-action="resume" title="Resume/Unhold"></i>';
                            } else {
                                html += '<i class="fa fa-pause text-info action-btn" data-action="hold" title="Hold"></i>';

                                if (data.ADMINYN !== "Y" && data.IsRollOver !=="Y") {
                                    html += '<i class="fa fa-ban text-warning action-btn" data-action="cancel" title="Cancel"></i>';
                                }
                            }
                        }
                        if (!data.isFromServer) {
                            html += '<i class="fa fa-trash text-danger action-btn" data-action="delete" style="cursor:pointer; margin-right: 5px;" title="Delete"></i>';
                        }

                        html += '</div>';
                        return html;
                    },
                    cellClick: function (e, cell) {
                        e.stopPropagation();
                        var target = e.target;
                        if (!target.classList.contains('action-btn')) return;

                        var row = cell.getRow();
                        var data = row.getData();
                        var actionType = target.getAttribute('data-action');

                        if (target.classList.contains("fa-trash")) { //priyanka 06/03/2026
                            if (!data.isfromserver) {
                                TrmtntOrderMedicationTable.deleteRow(row);
                            }
                        }


                        // Hold Logic
                        if (actionType === "hold") {
                            openHoldModal(function (reason) {
                                if (!reason || reason.trim() === "") {
                                    ToastMsg("Please enter the reason for hold", "info");
                                    return false; //  modal open
                                }
                                // If reason exists, process hold
                                processHoldUpdate(row, "Y", reason, "Process Hold Successful");
                                return true;
                            });
                        }

                        // Resume 
                        else if (actionType === "resume") {
                            if (confirm("Are you sure you want to Unhold this record?")) {
                                processHoldUpdate(row, "N", "", "Process Unhold Successful");
                            }
                        }
                        //Cancel and Delete
                        else if (actionType === "cancel") {
                            handleCancelRow(row);
                        }
                        else if (actionType === "delete") {
                            //TrmtntOrderMedicationTable.delRowData(row);
                            if (IS_DISPLAY_CIMS_FUNCTIONLITY == "Y") {
                                // Added By Roshan Condtion Based On WebConfigs
                                toogleButtons(TrmtntOrderMedicationTable, 'TrmtntOrderMedicationTable');//For Show And Hide The Interaction and Duplicate Button Added By Roshan 12/12/2025
                            }
                        }
                    }

                },

                getDayOfDrugColumn(),
                {
                    title: "<span style='color:red'>Duration of Days</span>",
                    field: "Duration",
                    width: 160,
                    hozAlign: "center",
                    editor: "input",
                    editorParams: {
                        elementAttributes: {
                            maxlength: 5,
                            oninput: "this.value=this.value.replace(/\\D/g,'')"
                        }
                    },
                    formatter: function (cell) {
                        const rowData = cell.getRow().getData();

                        if (rowData.IsRollOver === "Y") {
                            cell.getElement().classList.add("rollover-cell");
                        } else {
                            cell.getElement().classList.remove("rollover-cell");
                        }

                        return cell.getValue();
                    },
                    cellEdited: function (cell) {
                        const row = cell.getRow();
                        const data = row.getData();

                        row.update({
                            ENDDATE: calculateEndDate(
                                data.MediDGSTARTDATE,
                                data.Duration
                            )
                        });
                    },
                    validator: ["numeric"]
                },
                //{
                //    title: '<span style="color:red;">Drug Form</span>',
                //    field: "Type",
                //    tooltip: true,
                //    editor: "list",
                //    width: 90,
                //    editorParams: {
                //        values: medicineTypeMap,
                //        autocomplete: true,
                //        listOnEmpty: true,
                //        allowEmpty: false
                //    },
                //    formatter: "lookup",
                //    formatterParams: medicineTypeMap
                //},
                //{
                //    title: '<span style="color:red;">Drug Form</span>',
                //    field: "FormName",
                //    editor: "input",
                //    width: 90,
                //    visible: true,
                //    editable: false,
                //},
                {
                    title: '<span style="color:red;">Drug Form</span>',
                    field: "FormName",
                    width: 90,
                    visible: true,
                    editor: "list",
                    editable: function (cell) {
                        var row = cell.getRow().getData();                 //Added by aaryshree 20260624
                        return row.IsNewDrug == "true";
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
                        const routeList = GetRouteList("N", found.FORMCODE);

                        let selectedRoute = "";
                        let selectedRouteCode = code;
                        if (routeList.length === 1) {
                            selectedRoute = routeList[0].Text;
                        } else {
                            const defaultItem = routeList.find(x => x.DEFAULTYN === "Y");
                            selectedRoute = defaultItem ? defaultItem.Text : "";
                            selectedRouteCode = defaultItem ? defaultItem.Value : "";
                        }
                        if (found) {
                            cell.getRow().update({
                                FormCode: found.FORMCODE,
                                FormName: found.FORMNAME,
                                Route: selectedRoute,
                                RoutCode: selectedRouteCode
                            });
                        }
                    }

                },
                {
                    title: '<span style="color:red;">Drug Form Code</span>',
                    field: "FormCode",
                    editor: "input",
                    visible: false,
                    editable: false,
                },
                {
                    title: "Drug Name",
                    field: "DrugName",
                    width: 300,
                    formatter: function (cell) {
                        let value = cell.getValue();
                        let data = cell.getRow().getData();
                        let icons = "";
                        if (data.ISSUEYN === "Y") {
                            icons += "<img src='../Images/Check.png' style='width:16px;height:16px;margin-left:5px;float:right;' title='Issued' />";
                        }
                        if (data.INDENTYN === "Y") {
                            icons += "<img src='../Images/pills.png' style='width:16px;height:16px;margin-left:5px;float:right;' title='Indented' />";
                        }
                        return value ? value + icons : "";
                    }
                },
                getDoseColumn(),
                getRouteColumn(true,"TrmtntOrderMedicationTable"),
                getFreqColumn(),
                getRemarkColumn("TrmtntOrderMedicationTable"),//priyanka 06/03/2026
                {
                    title: "<span style='color:red'>Diluent<span>",
                    field: "Diluent",
                    width: 170,
                    editor: "input",
                    editorParams: { maxLength: 100 },
                    visible: false 
                },
                {
                    title: "<span style='color:red'>Dilution Volume</span>",
                    field: "DilutionVolume",
                    tooltip: true,
                    editor: "list",
                    width: 120,
                    editorParams: {
                        values: Get_DiluVolume(),
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: Get_DiluVolume(),
                    visible: false 
                },
                {
                    title: "<span style='color:red'>Admin Duration</span>",
                    field: "AdminstrDuration",
                    tooltip: true,
                    editor: "list",
                    width: 115,
                    editorParams: {
                        values: Get_AdminDurData(),
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: false
                    },
                    formatter: "lookup",
                    formatterParams: Get_AdminDurData(),
                    visible: false 
                },
                {
                    title: "Start Date",
                    field: "MediDGSTARTDATE",
                    width: 100,
                    editor: "input",
                    editable: false,
                    editorParams: { elementAttributes: { type: "date" } }
                },
                {
                    title: "End Date",
                    field: "ENDDATE",
                    width: 100,
                    editor: "input",
                    editable: false,
                   
                },
                // getOmitColumn(),
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 53,
                    hozAlign: "center",

                    formatter: function(cell) {
                        let value = cell.getValue();
                        let isChecked = (value === true || value === "Y");

                        let input = document.createElement("input");
                        input.type = "checkbox";
                        input.checked = isChecked;

                        input.addEventListener("click", function(e) {
                            e.stopPropagation();
                        });
                        input.addEventListener("change", function () {
                            cell.setValue(this.checked ? "Y" : "N");
                            var row = cell.getRow();
                            row.update({
                                OMIT: this.checked ? "Y" : "N",
                                isSavedOmit: false
                            });
                            row.getCell("CIMS").getElement().innerHTML =
                                row.getCell("CIMS").getColumn().getDefinition().formatter(row.getCell("CIMS"));

                            row.getCell("action").getElement().innerHTML =
                                row.getCell("action").getColumn().getDefinition().formatter(row.getCell("action"));
                        });
                        return input;
                    },

                    cellEdited: function(cell) {
                        updateRowColor(cell.getRow());
                    }
                },
                { title: "DrugCode", field: "DrugCode", visible: false },
                { title: "TypeCode", field: "TypeCode", visible: false },
                getOmittedByColumn(),
                getOmittedByNameColumn(),
                getOmittedDateColumn(),
                getOmittedTimeColumn(),
                getOrderedByColumn(),
                getOrderedByNameColumn(),
                getOrderedDateColumn(),
                getOrderedTimeColumn(),
                GetDrugSequenceNo(),
                GetHighAlertDrug(),
                GetNotifyYN(),
                GetStatus(),
                GetADMINYN(),
                { title: "MEDSTAT", field: "MEDSTAT", visible: false },
                { title: "ISSUEYN", field: "ISSUEYN", visible: false },
                { title: "INDENTYN", field: "INDENTYN", visible: false },
                { title: "IsRollOver", field: "IsRollOver", visible: false },
                { title: "CALCULATEON", field: "CALCULATEON", visible: false },
                { title: "HOLD", field: "HOLD", visible: false },

                {
                    title: "Hold Log",
                    field: "HoldLog",
                    width: 105,
                    formatter: LogInfo,
                    cellClick: function (e, cell) {
                        var d = cell.getData();

                        showHoldLog(d.TranNo, d.SQNumber, d.TypeCode, d.DrugCode);
                        console.log("Log info clicked for row:", cell.getData());
                    }
                }

            ],
            rowFormatter: function (row) {
                const data = row.getData();
                const element = row.getElement();
                if (data.OMIT === "Y") {
                    element.style.backgroundColor = "#d4edda";
                } else {
                    element.style.backgroundColor = "";
                }
                if (data.HighAlert === "Y") {
                    element.style.color = "#db0000";
                    element.style.fontWeight = "bold";
                } else {
                    element.style.color = "";
                    element.style.fontWeight = "";
                }

                let dayCell = row.getCell("DayOfDrug").getElement();
                if (data.HOLD === "Y") {
                    dayCell.style.backgroundColor = "#65e5e1cf";
                    dayCell.style.fontWeight = "bold";
                } else {
                    dayCell.style.backgroundColor = "";
                    dayCell.style.fontWeight = "";
                }
                if (data.Freq !== "STAT" && data.Freq !== "SOS" && data.TypeCode !== "SM") {
                    if (PlanData.hasOwnProperty("TRETMEDICINE") &&
                        PlanData.TRETMEDICINE.length > 0 &&
                        CheckPlanData(data.SQNumber, "MD")) {
                        IsPlanMData = true;
                        row.getElement().classList.add(
                            data.OMIT === "Y" ? "PlanedOmitt" : "Planed"
                        );
                    }
                }
                let freqCell = row.getCell("Freq").getElement();
                if (data.Freq == "STAT"  || data.Freq == "SOS" ) {
                    row.getElement().classList.remove("Planed");
                    row.getElement().classList.remove("PlanedOmitt");
                    freqCell.style.backgroundColor = "#b89eeacf";
                    freqCell.style.fontWeight = "bold"
                }
                else {
                    freqCell.style.backgroundColor = "";
                    freqCell.style.fontWeight = "";
                }

                let cimsCell = row.getCell("CIMS").getElement();
                if (data.ADMINYN == "Y") {
                    cimsCell.style.background = "linear-gradient(to left, #ebd0b75e, #ffc837)";
                    row.getElement().classList.add("avoid-clicks");
                }
                else {
                    cimsCell.style.background = "";
                }
                let isPlanned = false;

                if (data.TypeCode !== "SM" && PlanData &&
                    Array.isArray(PlanData.TRETMEDICINE) &&
                    PlanData.TRETMEDICINE.length > 0) {

                    isPlanned = CheckPlanData(data.SQNumber, "MD");
                }

                let cellOMIT = row.getCell("OMIT");
                let checkbox = cellOMIT.getElement().querySelector("input[type='checkbox']");
                const enableOMIT = isPlanned || data.IsRollOver === "Y"
                if (checkbox) {
                    checkbox.disabled = !(enableOMIT);
                }
                if (isPlanned && data.OMIT === "Y" && data.isSavedOmit === true) {

                    row.getCells().forEach(function(cell) {

                        let field = cell.getColumn().getField();

                        if (!["CIMS", "HoldLog"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });

                }
                else if (isPlanned && data.isSavedOmit === false) {
                    row.getCells().forEach(function(cell) {

                        let field = cell.getColumn().getField();

                        if (!["action", "CIMS", "Remark", "OMIT","HoldLog"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });
                }
                if (data.IsRollOver == "Y") {
                    row.getCells().forEach(function (cell) {
                        let fileds = cell.getColumn().getField();
                        if (!["action", "CIMS", "Duration", "HoldLog", "OMIT"].includes(fileds)){
                            cell.getElement().classList.add("disable-cell");
                        }
                    })
                }
                if (!isEndDateSameAsServerDate(data)) {
                    row.getElement().classList.add("avoid-clicks");
                } else {
                    row.getElement().classList.remove("avoid-clicks");
                }
                row.getCells().forEach(cell => {
                    const field = cell.getColumn().getField();

                    if (field === "CIMS" || field === "HoldLog") {
                        cell.getElement().classList.remove("avoid-clicks");
                    } else if (!isEndDateSameAsServerDate(data)) {
                        cell.getElement().classList.add("avoid-clicks");
                    } else {
                        cell.getElement().classList.remove("avoid-clicks");
                    }
                });
               
                if (data.STATUS === "C" || (isPlanned && data.STATUS === "C")) {
                    row.getElement().classList.remove("Planed");
                    element.style.backgroundColor = "#f8d7da";
                    //element.style.color = "#721c24";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "none";
                }
            },
            // Cell click logic
            cellClick: function (e, cell) {
                let field = cell.getColumn().getField();
                let rowData = cell.getRow().getData();
                if (field === "DrugName") {
                    if (gCIMSYN === "Y") {
                        $('#lblMode').text('Generic Medicine (CMIS)');
                        $('#txtSearchMedicine').attr("placeholder", "Search By Medicine Name");
                    } else {
                        $('#lblMode').text('Generic Medicine');
                        $('#txtSearchMedicine').attr("placeholder", "Search By Generic Name & Medicine Name");
                        FancyDisplay("TrmtntOrderMedicationTable");
                    }
                }
                if (rowData.ADMINYN === "Y") {
                    if (field !== "action" && field !== "CIMS" && field !== "OMIT") {
                        e.stopPropagation();
                        return false;
                    }
                }
            },

            // Edit restrictions
            cellEditing: function (cell) {
                let field = cell.getColumn().getField();
                let data = cell.getRow().getData();
                // replicate JQGrid beforeEditCell: only allow editing OMIT if rollover
                if (data.IsRollOver === "Y" && field !== "OMIT") {
                    return false; // block editing
                }
                return true;
            },

            cellEdited: function (cell) {
                let data = cell.getRow().getData();
                if (data.OMIT === "Y") {
                    cell.getRow().getElement().classList.add("Omited");
                }
            },

            // replicate loadComplete logic
            dataLoaded: function (data) {
                data.forEach(row => {
                    if (row.OMIT === "Y") {
                        TrmtntOrderMedicationTable.updateRow(row.SQNumber, { Remark: null });
                    }
                    if (CheckAdministedData(row.SQNumber, "MD") && IsrolloverData != "Y") {
                        // disable editing certain cells if administered
                        let rowObj = TrmtntOrderMedicationTable.getRow(row.SQNumber);
                        if (rowObj) {
                            rowObj.getElement().classList.add("avoid-clicks");
                        }
                    }
                    //if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                    //    AddCIMSInfoBtn(TrmtntOrderMedicineTable, row.SQNumber);
                    //}
                });
            },

            // replicate gridComplete logic
            renderComplete: function () {
                let data = TrmtntOrderMedicationTable.getData();
                data.forEach(row => {
                    if (row.IsRollOver !== "Y" && row.OMIT === "N" && row.ADMINYN === "N" && row.NOTIFYN === "N") {
                        let cell = TrmtntOrderMedicationTable.getCell(row.SQNumber, "OMIT");
                        if (cell) {
                            let checkbox = cell.getElement().querySelector("input[type=checkbox]");
                            if (checkbox) checkbox.disabled = true;
                        }
                    } else if (row.IsRollOver === "Y") {
                        let cell = TrmtntOrderMedicationTable.getCell(row.SQNumber, "OMIT");
                        if (cell) {
                            let checkbox = cell.getElement().querySelector("input[type=checkbox]");
                            if (checkbox) checkbox.removeAttribute("disabled");
                        }
                    }
                });
                if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                    toogleButtons(TrmtntOrderMedicationTable, 'TrmtntOrderMedicationTable');
                }
                adjustTableHeight("TrmtntOrderMedicationTable");
            }


        });

        ////TrmtntOrderMedicineTable.on("cellEdited", function (cell) {
        ////    cell.getRow().normalizeHeight();
        ////    adjustTableHeight("TrmtntOrderMedicineTable");
        ////});

        TrmtntOrderMedicationTable.on("rowAdded", function (row) {
            //row.normalizeHeight();
            //adjustTableHeight("TrmtntOrderMedicineTable");
            if (IS_DISPLAY_CIMS_FUNCTIONLITY == 'Y') {
                toogleButtons(TrmtntOrderMedicationTable, "TrmtntOrderMedicationTable");
            } 
        });

        TrmtntOrderMedicationTable.on("rowDeleted", function (row) {
            //adjustTableHeight("TrmtntOrderMedicineTable");
            if (IS_DISPLAY_CIMS_FUNCTIONLITY == 'Y') {
                toogleButtons(TrmtntOrderMedicationTable, "TrmtntOrderMedicationTable");
            }
        });
        $(document).on("click", ".AntiMed-row-Gen", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var FormCD = $(this).data("formcode");
            var FormNM = $(this).data("formname");
            var isNewDrug = $(this).data("isnewdrug");
            var HighAlert = $(this).data("highalert");

            console.log(isNewDrug);
            $('#DSMedicineName').text(name + " (" + FormNM + ")");
            $('#DSMedicineCode').text(code);
            $('#DSGenericName').text(name);
            $("#DSFormName").val(FormNM);
            $("#DSFormCode").val(FormCD);
            $("#DSIsFromNew").val(isNewDrug);
            $("#DSHighAlt").val(HighAlert);
            $("#MedicineSearch").val("");
            $("#MedicineListMainDiv").hide();
            $("#MedicationSearch").val("");
            $("#MedicationListMainDiv").hide();
            openDosePopup();
        });
        $(document).on("click", ".AntiMed-row-Mtrl", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var FormCD = $(this).data("formcode");
            var FormNM = $(this).data("formname");
            var isNewDrug = $(this).data("isnewdrug");
            var HighAlert = $(this).data("highalert");
            $('#DSMedicineName').text(name + " (" + FormNM + ")");
            $('#DSMedicineCode').text(code);
            $('#DSGenericName').text(name);
            $("#DSFormName").val(FormNM);
            $("#DSFormCode").val(FormCD);
            $("#DSIsFromNew").val(isNewDrug);
            $("#DSHighAlt").val(HighAlert);
            $("#MedicineSearch").val("");
            $("#MedicineListMainDiv").hide();
            $("#MedicationSearch").val("");
            $("#MedicationListMainDiv").hide();
            openDosePopup();
        });

        $(document).on("click", ".Medication-row-Gen", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var FormCD = $(this).data("formcode");
            var FormNM = $(this).data("formname");
            var isNewDrug = $(this).data("isnewdrug");
            var HighAlert = $(this).data("highalert");
            $('#DSMedicineName').text(name + " (" + FormNM + ")");
            $('#DSMedicineCode').text(code);
            $('#DSGenericName').text(name);
            $("#DSFormName").val(FormNM);
            $("#DSFormCode").val(FormCD);
            $("#DSIsFromNew").val(isNewDrug);
            $("#DSHighAlt").val(HighAlert);
            $("#MedicineSearch").val("");
            $("#MedicineListMainDiv").hide();
            $("#MedicationSearch").val("");
            $("#MedicationListMainDiv").hide();
            openDosePopup();
        });
        $(document).on("click", ".Medication-row-Mtrl", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var FormCD = $(this).data("formcode");
            var FormNM = $(this).data("formname");
            var isNewDrug = $(this).data("isnewdrug");
            var HighAlert = $(this).data("highalert");
            $("#DSIsFromNew").val(isNewDrug);
            $('#DSMedicineName').text(name + " (" + FormNM + ")");
            $('#DSMedicineCode').text(code);
            $('#DSGenericName').text(name);
            $("#DSFormName").val(FormNM);
            $("#DSFormCode").val(FormCD);
            $("#DSHighAlt").val(HighAlert);
            $("#MedicineSearch").val("");
            $("#MedicineListMainDiv").hide();
            $("#MedicationSearch").val("");
            $("#MedicationListMainDiv").hide();
            openDosePopup();
        });

        $('#cmbFrequency').change(function (e) {
            if ($('#cmbFrequency').val() != "Other") {
                $('#cadd').hide();
                $('#cminus').hide();
            }
            else {
                $('#cadd').show();
                $('#cminus').show();
            }
        });
        sessionStorage.setItem('TreatmentTranNo', ''); 
        /* Infusion Tabulator and Other*/
    });
    //Changes on 20260324 By Aaryshree
    $(document).on('keypress', '.BtnInke', function (e) {
        if ((e.which < 48 || e.which > 57) && e.which !== 46) {
            return false;
        }
        if (e.which === 46 && $(this).val().includes('.')) {
            return false;
        }
    });
//ENd
function isEndDateSameAsServerDate(data) {
    var endDate = toParseDate(getRowEndDate(data));
    var startDate = toParseDate(data.MediDGSTARTDATE || data.STARTFRMDT || data.AntiBoDGSTARTDATE )
    var serverDate = toParseDate(ServerDate);

    if (!endDate || !serverDate) {
        return false;
    }

    return endDate.getTime() >= serverDate.getTime();
}

    function getAdmissionDatePart() {
        var date = admitDateIPD;
        var temp = date ? date.substring(0, date.indexOf("/") + 8) : null;
        return temp;
    }
    function SetMinMaxOptions() {
        var minDateValue = getAdmissionDatePart();
        if (minDateValue) {
            $("#txtTransDate").datepicker("option", "minDate", minDateValue);
        }
        $("#txtTransDate").datepicker("option", "maxDate", ServerDate);
    }
    function addReferralRow(data = null) {
        var uniqueId = Date.now() + Math.floor(Math.random() * 100);

        if (!window.globaldoctstring || globaldoctstring === "") {
            load_Doctor();
        }

        var docOptions = globaldoctstring.split(';');
        var selectHtml = `<select id="ddlDoc_${uniqueId}" class="form-select form-select-sm doctor-dropdown ref-input">`;

        docOptions.forEach(opt => {
            if (opt && opt.includes(':')) {

                    var valText = opt.split(':');
                    var val = valText[0].trim();
                    var text = valText[1].trim();

                    // Hide logged-in doctor from dropdown
                       if (val == gDoctCode) {
                            return;
                         }

                     var isSelected = (data && (data.DoctorCode == val || data.Doctor == text))
                         ? "selected"
                         : "";

                    selectHtml += `<option value="${val}" ${isSelected}>${text}</option>`;
                }
        });
        selectHtml += `</select>`;
        //Abhishesh || 20261006
        var html = `
    <div class="referral-row border rounded p-2 mb-2 bg-white shadow-sm" data-id="${uniqueId}">
        <div class="row gx-2" style=" align-items: flex-start;">
            <div class="col-md-4" >
                <label class="small fw-bold mb-1 text-muted">Referral Doctor</label>
                ${selectHtml}
            </div>
            <div class="col-md-7">
        <div style="display:flex; justify-content:space-between; align-items:center;">
        <label class="small fw-bold mb-1 text-muted">Reason/Instruction</label>
            <span class="referral-cancel-info small fw-bold text-danger" style="display:none;"></span>
        </div>
                <textarea class="form-control form-control-sm reason-textarea ref-input ref-input-textarea" rows="1 TextAreaBorder" maxlength="200" oninput="autoResizeTextareaForSinglePageIPD(this)" style="resize: none;">${data ? data.REASON : ""}</textarea>
            </div>
            <div class="col-md-1 text-end">
                <button type="button" class="btn btn-outline-danger btn-sm btnRemoveReferral" title="Delete">
                    <i class="fa fa-trash"></i>
                </button>
<button type="button" class="btn btn-outline-warning btn-sm btnCancelReferral" title="Cancel Referral" style="display:none;">
    <i class="fa fa-ban"></i>
</button>
            </div>
        </div>
    </div>`;
        var $row = $(html);
        $('#OncologistContainer').append($row);
        if (data) {
            $row.find('.doctor-dropdown').prop("disabled", true);
            $row.find('.reason-textarea').prop("disabled", true);
            $row.find('.btnRemoveReferral').hide();
            // Saved referral: keep server values on the row, show Cancel icon (or the "cancelled" indicator)
            $row.attr('data-seqno', data.SEQNO || '')
                .attr('data-status', data.STATUS || 'A')
                .attr('data-cancelby', data.CancelBY || '')
                .attr('data-canceldt', data.CancelDT || '')
                .attr('data-canceltm', data.CancelTM || '');
            setReferralRowCancelUI($row);
        }
        //End

        else {
            $row.find('.btnRemoveReferral').show();
        }
        autoResizeTextareaForSinglePageIPD($row.find('.ref-input-textarea')[0]);
    }
    //Abhishesh || 20261006 
    // Referral Doctor: show Cancel icon for active saved rows, "cancelled" indicator for cancelled rows
    function setReferralRowCancelUI($row) {
        var isCancelled = ($row.attr('data-status') || 'A') === 'C';
        var $info = $row.find('.referral-cancel-info');
        if (isCancelled) {
            $row.addClass('referral-cancelled');
            $row.find('.btnCancelReferral').hide();
            $info.text('This referral doctor is cancelled').show();
        } else {
            $row.removeClass('referral-cancelled');
            $row.find('.btnCancelReferral').show();
            $info.hide().text('');
        }
    }
    // Referral Doctor: cancel a SAVED referral
    function CancelReferralRow($row) {
        var seqNo = $row.attr('data-seqno');
        var tranNo = $('#tractiondropdown').val() || Gbl_TranNo;
        if (!seqNo || !tranNo) {
            ToastMsg("Please save the referral before cancelling it.", "warning");
            return;
        }
        if (!confirm("Are you sure you want to cancel this referral doctor?")) {
            return;
        }
        if (CancelledRequest(tranNo, seqNo, "DC")) {
            $row.attr('data-status', 'C')
                .attr('data-cancelby', UserId)
                .attr('data-canceldt', GetToday_DDMMYYYY())
                .attr('data-canceltm', GetTimewithAMPM());
            setReferralRowCancelUI($row);
        }
    }
    //End
    function autoResizeTextareaForSinglePageIPD(el) {
        el.style.height = 'auto';
        el.style.height = (el.scrollHeight + 20)+ 'px'; 
    }

    function toggleDeleteButton($row) {
        var doctorVal = $row.find('.doctor-dropdown').val();
        var reasonVal = $row.find('.reason-textarea').val().trim();

        if (doctorVal !== "----select----" && reasonVal !== "") {
            $row.find('.btnRemoveReferral').fadeOut(200);
        } else {
            $row.find('.btnRemoveReferral').fadeIn(200);
        }
    }
    function BindMedicationData(jsonAntibioticData) {
        if (TrmtntOrderMedicineTable) {

            const mappedData = mapMedicationData(jsonAntibioticData);
            TrmtntOrderMedicineTable.setData(mappedData);
            toogleButtons(TrmtntOrderMedicineTable, "TrmtntOrderMedicineTable");
        }
    }
    function mapMedicationData(dataArray) {
        if (!dataArray) return [];
        return dataArray.map(item => {
            var endDate = parseDate(item.ENDDATE);
            var serverDate = parseDate(ServerDate);
            return {
                // Include basic fields that don't change
                action: item.action || "",
              //  DayOfDrug: item.DayOfDrug || "",
                  //DayOfDrug: /* (item.STARTFRMDT || item.AntiBoDGSTARTDATE || item.MediDGSTARTDATE) || */ item.DayOfDrug || "", // Abhishesh || 20261006
                DayOfDrug: endDate < serverDate ? "" : toCalcDayOfDrug(
                    item.STARTFRMDT || item.AntiBoDGSTARTDATE || item.MediDGSTARTDATE,
                    item.Duration || item.DURATION
                ),

                FormName: item.FormName || "",
                FormCode: item.FormCode || "",
                DrugName: item.DrugName || "",
                Dose: item.Dose || "",
                RoutCode: item.RoutCode || item.ROUTCODE || "",
                MtrFormCode: item.MtrFormCode || item.DRUGFROMCD || "",
                Route: item.Route || "",
                Freq: item.Freq || "",
                Remark: item.Remark || "",
                Diluent: item.Diluent || "",
                DrugCode: item.DrugCode || item.DRUGCD || "",
                HighAlert: item.HighAlert || "N",
                STATUS: item.STATUS || "A",
                //SetNo: item.SETNO || item.SetNo || "",
                TypeCode: item.TypeCode || "",
                // Map the "Double" fields to your preferred standard keys ONLY
                DilutionVolume: item.DILVOLUME || item.DilutionVolume || "",
                AdminstrDuration: item.ADMINDUR || item.AdminstrDuration || "",
                AntiBoDGSTARTDATE: item.STARTFRMDT || item.AntiBoDGSTARTDATE || "",
                OrderedBy: item.ORDERBY || item.OrderedBy || "",
                OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
                OrderedDate: item.ORDDATE || item.OrderedDate || "",
                OrderedTime: item.ORDTIME || item.OrderedTime || "",
                //DOCNAME: item.DOCNAME || "",
                CALCULATEON: item.CALCULATEON || "",
                SQNumber: item.SQNumber || item.SEQNO || "",
                NOTIFYN: item.NOTIFYN || "",
                ADMINYN: item.ADMINYN || "",
                MEDSTAT: item.MEDSTAT || "",
                MEDTYPE: item.MEDTYPE || "",
                ISSUEYN: item.ISSUEYN || "",
                INDENTYN: item.INDENTYN || "",
                Duration: item.Duration || "" || item.DURATION,

                // Omit Logic
                OmittedBy: item.OMITBY || item.OmittedBy || "",
                OmittedByName: item.OMITBYNAME || item.OmittedByName || "",
                OmittedDate: item.OMITDT || item.OmittedDate || "",
                OmittedTime: item.OMITTM || item.OmittedTime || "",
                OMIT: (item.OMIT === "Y") ? "Y" : "N",
                HOLD: item.HOLDYN || item.HOLD || item.Hold || "",
                IsRollOver: item.IsRollOver || "",
                isFromServer: true,
                ENDDATE: calculateEndDate(item.STARTFRMDT || item.AntiBoDGSTARTDATE || item.MediDGSTARTDATE, item.Duration || item.DURATION),
                isSavedOmit: item.OMIT === "Y"
              
            };
        });
    }

    //20260324
    function BindMedicineData(jsonMedicineData) {
        if (TrmtntOrderMedicationTable) {

            const mappedData = mapMedicineData(jsonMedicineData);
            TrmtntOrderMedicationTable.setData(mappedData);
            toogleButtons(TrmtntOrderMedicationTable, "TrmtntOrderMedicationTable");
        }
    }
    function mapMedicineData(dataArray) {
        if (!dataArray) return [];
        return dataArray.map(item => {
            var endDate = parseDate(item.ENDDATE);
            var serverDate = parseDate(ServerDate);
            return {
                // Include basic fields that don't change
                action: item.action || "",
                //DayOfDrug: item.DayOfDrug || "",
           //      DayOfDrug: /* (item.STARTFRMDT || item.AntiBoDGSTARTDATE || item.MediDGSTARTDATE) || */ item.DayOfDrug || "",  // Abhishesh || 20261006
                DayOfDrug: endDate < serverDate ? "" : toCalcDayOfDrug(
                    item.STARTFRMDT || item.AntiBoDGSTARTDATE || item.MediDGSTARTDATE,
                    item.Duration || item.DURATION
                ),

                FormName: item.FormName || "",
                FormCode: item.FormCode || "",
                DrugName: item.DrugName || "",
                Dose: item.Dose || "",
                Route: item.Route || "",
                RoutCode: item.RoutCode || item.ROUTCODE || "",
                MtrFormCode: item.MtrFormCode || item.DRUGFROMCD || "",
                Freq: item.Freq || "",
                Remark: item.Remark || "",
                Diluent: item.Diluent || "",
                DrugCode: item.DrugCode || item.DRUGCD || "",
                HighAlert: item.HighAlert || "N",
                STATUS: item.STATUS || "A",
                //SetNo: item.SETNO || item.SetNo || "",
                TypeCode: item.TypeCode || "",
                // Map the "Double" fields to your preferred standard keys ONLY
                DilutionVolume: item.DILVOLUME || item.DilutionVolume || "",
                AdminstrDuration: item.ADMINDUR || item.AdminstrDuration || "",
                MediDGSTARTDATE: item.STARTFRMDT || item.MediDGSTARTDATE || "",
                OrderedBy: item.ORDERBY || item.OrderedBy || "",
                OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
                OrderedDate: item.ORDDATE || item.OrderedDate || "",
                OrderedTime: item.ORDTIME || item.OrderedTime || "",
                //DOCNAME: item.DOCNAME || "",
                CALCULATEON: item.CALCULATEON || "",
                SQNumber: item.SQNumber || item.SEQNO || "",
                NOTIFYN: item.NOTIFYN || "",
                ADMINYN: item.ADMINYN || "",
                MEDSTAT: item.MEDSTAT || "",
                MEDTYPE: item.MEDTYPE || "",
                ISSUEYN: item.ISSUEYN || "",
                INDENTYN: item.INDENTYN || "",
                Duration: item.Duration || "" || item.DURATION,

                // Omit Logic
                OmittedBy: item.OMITBY || item.OmittedBy || "",
                OmittedByName: item.OMITBYNAME || item.OmittedByName || "",
                OmittedDate: item.OMITDT || item.OmittedDate || "",
                OmittedTime: item.OMITTM || item.OmittedTime || "",
                OMIT: (item.OMIT === "Y") ? "Y" : "N",
                HOLD: item.HOLDYN || item.HOLD || item.Hold || "",
                IsRollOver: item.IsRollOver || "",
                ENDDATE: calculateEndDate(item.STARTFRMDT || item.AntiBoDGSTARTDATE || item.MediDGSTARTDATE, item.Duration || item.DURATION),

               // IsNewDrug: true,
                isFromServer: true,
                isSavedOmit: item.OMIT === "Y"
            };
        });
    }

    //End
    function BindChemoData(jsonChemoAData) {
        if (ChemoListtable) {

            const mappedData = mapChemoData(jsonChemoAData);
            ChemoListtable.setData(mappedData);
        }
    }
    function LoadOnDateChange(chageDate) {
        if (checkPriviousDate(chageDate)) {
        }
    }

    function callTreatmentdata(TranctionId, IsRollover) {
        IpNo = sessionStorage.getItem('IPPatIPNO');
        if (IsRollover == "Y") {
            GetTreatmentSheetData(TranctionId, IsRollover, IpNo)
        }
        else {
            GetTreatmentSheetData(TranctionId, IsRollover, IpNo)
        }
    }
    function GetCurrentTime() {
        //var CuurentTime = Time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
        //return CuurentTime;
        var parts = serverTime.split(':');
        var date = new Date();
        date.setHours(
            parseInt(parts[0], 10),
            parseInt(parts[1], 10),
            parseInt(parts[2] || 0, 10)
        );
        return date.toLocaleString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });
    }

    function setcurrentDate(currentTime) {
        if (!currentTime) {
            return;
        }
        var parts = currentTime.toString().split(':');
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var second = parts[2];
        var ampm = hour >= 12 ? 'PM' : 'AM';
        hour = hour % 12;
        hour = hour === 0 ? 12 : hour;
        hour = ('0' + hour).slice(-2);
        var formattedTime = hour + ':' + minute + ' ' + ampm;
        $('#txtTransTime').val(formattedTime);
    }
    //function setcurrentDate(CuurentTime) {
    //    var ct
    //    if (CuurentTime.indexOf('AM') > -1) {
    //        ct = CuurentTime.toString().replace('AM', 'am')
    //    }
    //    if (CuurentTime.indexOf('PM') > -1) {
    //        ct = CuurentTime.toString().replace('PM', 'pm')
    //    }

    //    var valn = ct.toString().split(':')
    //    if (valn[0] <= 9) {
    //        $('#txtTransTime').val('0' + ct)
    //    }
    //    else {
    //        $('#txtTransTime').val(ct)
    //    }
    //}

    function AMPMConvert() {
        var ct = '';
        var TimeCovet = $('#txtTransTime').val();

        if (TimeCovet.indexOf('am') > -1) {
            ct = TimeCovet.toString().replace('am', 'AM')
        }
        if (TimeCovet.indexOf('pm') > -1) {
            ct = TimeCovet.toString().replace('pm', 'PM')
        }

        if (ct.length > 0) {
            $('#txtTransTime').val(ct);
        }
        else {
            $('#txtTransTime').val(TimeCovet);
        }
        TsTime = $('#txtTransTime').val();
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

    function RetriveTreatmentData(obj, IsRollover) {
        if ($('#tractiondropdown').val() != "") {
            TranctionId = $('#tractiondropdown').val();
        }
        else {
            TranctionId = "";
        }

        if (IsRollover == "N") {
            IsrolloverData = 'N';
            callTreatmentdata(TranctionId, IsRollover);
        }
        else {
            TranctionId = '';
            callTreatmentdata(TranctionId, IsRollover);
        }
    }
    function clearTabulator(table) {
        if (table && typeof table.clearData === "function") {
            table.clearData();
        }
    }

    function ClearcontrolData() {
        $('.nutri-dropdown').val("");
        $('.VolSuppl-textarea').val("");
        $('.reason-textarea').val("");
        $('.doctor-dropdown').val("");
        $('#txtOthers').val("");
        $("#txtNutriRemark").val("");

        clearTabulator(InvstgListtable);
        clearTabulator(TrmtntOrderMedicineTable);
        clearTabulator(TrmtntOrderMedicationTable);
        clearTabulator(ChemoListtable);
        clearTabulator(InfusionTable);
        clearTabulator(IVFluidTable);
        clearTabulator(BloodProductTable);
    }
    function GetTreat(tabType) {
        IpNo = $('#txtstrUIPNo').val();
        var chngDate2 = $('#txtTransDate').val();
        var year = chngDate2.substring(10, 6);
        var month = chngDate2.substring(5, 3);
        var day = chngDate2.substring(0, 2);
        var setadmndate = year + ',' + month + ',' + day;
        var actualDate = new Date(setadmndate); // convert to actual date
        //var rowChemoCount = $('#JqGridChemo').jqGrid('getGridParam', 'records');
        var nextDate = new Date(actualDate.getFullYear(), actualDate.getMonth(), actualDate.getDate());
        var nextDate1 = new Date(nextDate);
        var noday = nextDate1.getDate();
        var month = nextDate1.getMonth() + 1;
        var year = nextDate1.getFullYear();
        var noday = getFormattedPartTime(noday);
        var month = getFormattedPartTime(month);
        dt4 = noday + "/" + month + "/" + year;
        TranNo = "";
        TranctionId = $("#tractiondropdown").val();

        $.ajax({
            url: '../SinglePage/GetTreatmentOrderData',
            data: { TranNo: TranctionId, IPNum: IpNo, IsRollover: "Y", tsTime: $('#txtTransTime').val(), tsDate: dt4 },
            type: 'get',
            async: false,
            dataType: "json",
            success: function (Respose) {
                if (Respose.hasOwnProperty("jsonDetailsData") && Respose.jsonDetailsData != "") {


                    if (Respose.jsonDetailsData[0]["TRANNO"] != "") {
                        if (Respose.jsonDetailsData[0]["TRANDATE"] != "") {
                            $('#txtRollverDate').val(Respose.jsonDetailsData[0]["TRANDATE"]);
                        }
                    }
                    // if (tabType == "Antibiotic" && ISRYN == "Y") {
                    //     var FData = [];

                    //     if (Respose.jsonAntibioticData && Respose.jsonAntibioticData.length > 0) {
                    //         Respose.jsonAntibioticData.forEach(function (item) {
                    //             item.IsRollOver = "Y";
                    //             item.DayOfDrug = Number(item.DayOfDrug) + 1;
                    //         });
                    //         FData.concat(Respose.jsonAntibioticData);
                    //     }
                    //     if (Respose.jsonStatOrderData && Respose.jsonStatOrderData.length > 0) {
                    //         Respose.jsonStatOrderData.forEach(function (item) {
                    //             item.IsRollOver = "Y";
                    //             item.DayOfDrug = Number(item.DayOfDrug) + 1;
                    //         });
                    //         FData.concat(Respose.jsonStatOrderData);
                    //     }
                    //     if (FData.length > 0) {
                    //         BindMedicationData(FData);
                    //         $("#btnRollOverAntibiotic").hide();
                    //     }
                    //     else {
                    //         ToastMsg("Antibiotics  rollover data not found.", "warning");
                    //     }
                    // }
                    if (tabType == "Antibiotic" && ISRYN == "Y") {

                        var FData = [];

                        if (Respose.jsonAntibioticData && Respose.jsonAntibioticData.length > 0) {
                            var antibioticData = Respose.jsonAntibioticData.filter(function (item) {
                                var nextDay = Number(item.DayOfDrug) + 1;
                                return item.OMIT != "Y" && item.STATUS != "C" && nextDay <= Number(item.Duration);
                            });

                            antibioticData.forEach(function(item) {
                                console.log("Before rollover:", item.IsRollOver, item.ADMINYN, item.DrugName);
                                if (item.ADMINYN == "Y") {
                                    item.ADMINYN = "N"
                                }
                                item.IsRollOver = "Y";
                                item.DayOfDrug = Number(item.DayOfDrug) + 1;
                                item.isSavedOmit = false;
                                item.INDENTYN = "N";
                                item.ISSUEYN = "N";
                            });
                            FData = FData.concat(antibioticData);
                            // FData.push(...Respose.jsonAntibioticData);
                        }

                        if (Respose.jsonStatOrderData && Respose.jsonStatOrderData.length > 0) {
                            var statOrderData = Respose.jsonStatOrderData.filter(function (item) {
                                var nextDay = Number(item.DayOfDrug) + 1;
                                return item.OMIT != "Y" && item.STATUS != "C" && nextDay <= Number(item.Duration);
                            });

                            statOrderData.forEach(function (item) {
                                if (item.ADMINYN == "Y") {
                                    item.ADMINYN = "N"
                                }
                                item.IsRollOver = "Y";
                                item.DayOfDrug = Number(item.DayOfDrug) + 1;
                                item.isSavedOmit = false;
                                item.INDENTYN = "N";
                                item.ISSUEYN = "N";
                            });
                            FData = FData.concat(statOrderData);
                            //  FData.push(...Respose.jsonStatOrderData);
                        }

                        if (FData.length > 0) {
                            BindMedicationData(FData);
                            $("#btnRollOverAntibiotic").hide();
                        }
                        else {
                            ToastMsg("Antibiotics rollover data not found.", "warning");
                        }
                    }
                    else if (tabType == "Medication" && ISRYN == "Y") {
                        //if (Respose.jsonMedicineData && Respose.jsonMedicineData.length > 0) {
                        //    Respose.jsonMedicineData.forEach(function (item) {
                        //        item.IsRollOver = "Y";
                        //        item.DayOfDrug = Number(item.DayOfDrug) + 1;
                        //    });
                        //    BindMedicineData(Respose.jsonMedicineData);
                        //    $("#btnRollOverMedication").hide();
                        //}
                        var FData = [];
                        if (Respose.jsonMedicineData && Respose.jsonMedicineData.length > 0) {
                            var medicationData = Respose.jsonMedicineData.filter(function (item) {
                                var nextDay = Number(item.DayOfDrug) + 1;

                                return item.OMIT != "Y"
                                    && item.STATUS != "C"
                                    && nextDay <= Number(item.Duration);
                            });

                            medicationData.forEach(function (item) {
                                if (item.ADMINYN == "Y") {
                                    item.ADMINYN = "N"
                                }
                                item.IsRollOver = "Y";
                                item.DayOfDrug = Number(item.DayOfDrug) + 1;
                                item.isSavedOmit = false;
                                item.INDENTYN = "N";
                                item.ISSUEYN = "N";
                            });
                            FData = FData.concat(medicationData);
                            // FData.push(...Respose.jsonMedicineData);
                        }
                        if (Respose.jsonStatOrderMediData && Respose.jsonStatOrderMediData.length > 0) {
                            var statMedData = Respose.jsonStatOrderMediData.filter(function (item) {
                                var nextDay = Number(item.DayOfDrug) + 1;
                                return item.OMIT != "Y" && item.STATUS != "C" && nextDay <= Number(item.Duration);;
                            });
                                statMedData.forEach(function (item) {
                                    if (item.ADMINYN == "Y") {
                                        item.ADMINYN = "N"
                                    }
                                    item.IsRollOver = "Y";
                                    item.DayOfDrug = Number(item.DayOfDrug) + 1;
                                    item.isSavedOmit = false;
                                    item.INDENTYN = "N";
                                    item.ISSUEYN = "N";
                                });
                                FData = FData.concat(statMedData);
                                //FData.push(...Respose.jsonStatOrderMediData);
                            }
                            if (FData.length > 0) {
                                BindMedicineData(FData);                               //Changes on 20260801
                                $("#btnRollOverMedication").hide();
                            }
                            else {
                                ToastMsg("Medication rollover data not found.", "warning");
                            }
                        }
                        else if (tabType == "Infusion" && ISRYN == "Y") {
                            if (Respose.jsonInfusionData && Respose.jsonInfusionData.length > 0) {
                                var InfusionData = Respose.jsonInfusionData.filter(function (item) {
                                    return item.OMIT != "Y" && item.STATUS != "C";
                                });

                                InfusionData.forEach(function (item) {
                                    if (item.ADMINYN == "Y") {
                                        item.ADMINYN = "N" 
                                    }
                                    item.IsRollOver = "Y";
                                    item.isSavedOmit = false;
                                });

                                BindInfusionData(InfusionData);
                                $("#btnRollOverInfusion").hide();
                            }
                            else {
                                ToastMsg("Infusion rollover data not found.", "warning");
                            }

                        }
                        else if (tabType == "IVSupplement" && ISRYN == "Y") {
                            if (Respose.jsonSpecilInstData && Respose.jsonSpecilInstData.length > 0) {
                                var SpecilInstData = Respose.jsonSpecilInstData.filter(function (item) {
                                    let currentStatus = item.STATUS || "N";
                                    let adminYn = item.ADMINYN || "N";
                                    if (currentStatus === "N" && adminYn === "C") {
                                        currentStatus = "C";
                                        adminYn = "N";
                                    }
                                    item.STATUS = currentStatus;
                                    return item.OMIT != "Y" && item.STATUS != "C";
                                });

                                SpecilInstData.forEach(function (item) {
                                    if (item.ADMINYN == "Y") {
                                        item.ADMINYN = "N"
                                    }
                                    item.IsRollOver = "Y";
                                    item.isSavedOmit = false
                                });

                                BindIVSuplementData(SpecilInstData);
                                $("#btnRollOverIVSupplement").hide();
                            }
                            else {
                                ToastMsg("IV Supplements rollover data not found.", "warning");
                            }
                        }
                        else if (tabType == "BloodProduct" && ISRYN == "Y") {
                            if (Respose.jsonBloodProductData && Respose.jsonBloodProductData.length > 0) {
                                var BloodProductData = Respose.jsonBloodProductData.filter(function (item) {
                                    let currentStatus = item.STATUS || "N";
                                    let adminYn = item.ADMINYN || "N";
                                    if (currentStatus === "N" && adminYn === "C") {
                                        currentStatus = "C";
                                        adminYn = "N";
                                    }
                                    item.STATUS = currentStatus;
                                    return item.OMIT != "Y" && item.STATUS != "C";
                                });

                                BloodProductData.forEach(function (item) {
                                    if (item.ADMINYN == "Y") {
                                        item.ADMINYN = "N"
                                    }
                                    item.IsRollOver = "Y";
                                    item.isSavedOmit = false
                                });

                                BindBloodProductData(BloodProductData);
                                $("#btnRollOverBloodProduct").hide();
                            }
                            else {
                                ToastMsg("Blood Product rollover data not found.", "warning");
                            }


                        }

                        else if (tabType == "Investigation" && ISRYN == "Y") {

                            if (Respose.jsonTestData && Respose.jsonTestData.length > 0) {
                                var TestData = Respose.jsonTestData.filter(function(item) {
                                    return item.OMIT != "Y" && item.STATUS != "C" && parseInt(item.Pending) > 0 ;
                                });
                                TestData.forEach(function (item) {
                                    if (item.ADMINYN == "Y") {
                                        item.ADMINYN = "N"
                                    }
                                    item.IsRollOver = "Y";
                                    item.ProposedDate = ServerDate;
                                    item.OrderDate = ServerDate;
                                    item.ProposedTime = formatTimeTo12Hour(ServerTime);
                                    item.OrderTime = formatTimeTo12Hour(ServerTime);
                                });

                                BindInvestigationData(TestData);
                                $("#btnRollOverInvestigation").hide();
                            }
                            else {
                                ToastMsg("Investigation rollover data not found.", "warning");
                            }

                        }

                        // if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
                        //   //  $('#lblModeIndicator').text("New");
                        //     $('#btnSave').val('Save');

                        // }
                    }
                    else {
                        ToastMsg("Rollover Data Not Found", "warning");
                    }
                    //updateVitalFieldsReadonlyStatus();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ajaxindicatorstop();
                MsgDia(textStatus, "Error Information");
            }
        });
        TranctionId = "";
    }
   
    function getFormattedPartTime(partTime) {
        if (partTime < 10)
            return "0" + partTime;
        return partTime;
    }

    function DisabledGrid() {
        TrmtntOrderMedicineTable.getColumns().forEach(function (column) {
            column.updateDefinition({
                editable: false
            });
        });

        TrmtntOrderMedicineTable.redraw(true);

        TrmtntOrderMedicationTable.getColumns().forEach(function (column) {
            column.updateDefinition({
                editable: false
            });
        });
        TrmtntOrderMedicationTable.redraw(true);
    }

</script>
<%-- End Global Declaration  and Form Load --%>



<%-- Binding ,Valiation and Save Treatment Order --%>
<script type="text/javascript">
    /* List Of Transaction Number Will Get*/
    function GetTranslstData() {
        $('#tractiondropdown').find('option').remove();
        IpNo = sessionStorage.getItem('IPPatIPNO')
        strdate = '' + $("#txtTransDate").val();
        Url = '../SinglePage/GetTranslst?IpNo=' + IpNo + '&strDate=' + strdate
        var s;
        $.ajax({
            url: Url,
            type: 'get',
            async: false,
            success: function (data) {
                var sel = $('#tractiondropdown')
                $(data).each(function (index, value) {
                    sel.append($("<option>").attr('value', this.Value).text(this.Text));
                });

                Gbl_TranNo = $('#tractiondropdown').val();

                if (data.length == 1) {
                    IsRollover = 'N'
                    GetTreatmentSheetData(data[0].Value, IsRollover, IpNo);
                    $(sel).val(data[0].Value);
                }
                else {
                    if (IsPastDate) {
                      
                        IsrolloverData = 'Y';
                        // $('#btnSave').val('Save').addClass('Visibility');
                          
                        ToastMsg("No Record Present", "warning");
                        ClearcontrolData();
                        GetTreatmentSheetData($("#tractiondropdown").val(), "", IpNo);
                        $("#btnRollOverInvestigation").hide();
                        $("#btnRollOverInfusion").hide();
                        $("#btnRollOverBloodProduct").hide();
                        $("#btnRollOverIVSupplement").hide();
                        $("#btnRollOverAntibiotic").hide();
                        $("#btnRollOverMedication").hide();
                        
                    }
                    else {
                        RetriveTreatmentData("", "Y");
                        $("#btnRollOverInvestigation").show();
                        $("#btnRollOverInfusion").show();
                        $("#btnRollOverBloodProduct").show();
                        $("#btnRollOverIVSupplement").show();
                        $("#btnRollOverAntibiotic").show();
                        $("#btnRollOverMedication").show();

                    }
                }

            }
        });
        if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
            gact = "N";
        }
        else {
            gact = "E";
        }
        return s;
    }
    function getReferralData() {
        var referralArray = [];
        //Abhishesh || 20261006
        var maxSeq = 0;
        $('#OncologistContainer .referral-row').each(function () {
            var s = parseInt($(this).attr('data-seqno'), 10);
            if (!isNaN(s) && s > maxSeq) maxSeq = s;
        });
        //End
        $('#OncologistContainer .referral-row').each(function (index, element) {
            var $row = $(element);
            var docVal = $row.find('.doctor-dropdown').val();
            // Only push if a doctor is selected
            if (docVal !== "----select----") {
                var doctorspecialization = GetDoctSpecilization(docVal);
                referralArray.push({
                    "Doctor": $row.find('.doctor-dropdown option:selected').text() +
                        " (" + doctorspecialization + ")",
                    "SpecilizationName": doctorspecialization,
                    "SUGESTBY": "",
                    "DoctorCode": docVal,
                    "ReferralType": "Daily follow up",
                    "REASON": $row.find('.reason-textarea').val() || "",
                    "TypeCode": "DC",
                    "ReferralTypeCode": "Daily follow up",
                    "SQNumber": (function () {
                        var saved = parseInt($row.attr('data-seqno'), 10);
                        return (!isNaN(saved) ? saved : ++maxSeq).toString();
                    })(),
                    //Abhishesh || 20261006
                    "STATUS": $row.attr('data-status') || "A",
                    "CREATEDBY": gDoctCode,
                    "CancelBY": $row.attr('data-cancelby') || "",
                    "CancelDT": $row.attr('data-canceldt') || "",
                    "CancelTM": $row.attr('data-canceltm') || "",
                    "ADMINYN": "",
                    "IsRollOver": ""
                });
                //End
            }
        });
        return referralArray;
    }
    function BindReferralData(dataList) {
        $('#OncologistContainer').empty();
        dataList.forEach(item => {
            addReferralRow(item);
        });
    }

    function GetTreatmentSheetData(TranctionId, IsRollover, IpNo) {
        if (TranctionId == "") {
            IsRollover = "N";
            ClearcontrolData();
           // CheckChemoStartDate();
           // showNutitionReferDoc();
        }
       // if (TranctionId != "" && !IsPastDate) {
       //     ClearcontrolData();
       // }
        var TsDate = $("#txtTransDate").val();//getCurrentDate_DDMMYYYY();
        var TsTime = $("#txtTransTime").val();//getCurrentTime_12H();
        var IpNo = sessionStorage.getItem('IPPatIPNO');



        $.ajax({
            url: '../SinglePage/GetTreatmentOrderData',
            data: { TranNo: TranctionId, IPNum: IpNo, IsRollover: IsRollover, tsTime: TsTime, tsDate: TsDate },
            type: 'get',
            async: true,
            dataType: "json",
            success: function (Response) {
                if (Response.jsonDetailsData && Response.jsonDetailsData.length > 0 && Response.jsonDetailsData[0].TRANNO.length > 0) {
                    TranctionId = Response.jsonDetailsData[0].TRANNO;
                    if ($("#tractiondropdown option[value='" + TranctionId + "']").length == 0)
                        $('#tractiondropdown').append($("<option>").attr('value', TranctionId).text(TranctionId));
                    $("#txtTransDate").val(Response.jsonDetailsData[0].TRANDATE);
                    $("#txtTransTime").val(Response.jsonDetailsData[0].TRANTIME);
                    Gbl_TranNo = Response.jsonDetailsData[0].TRANNO;
                }
                /* ---------- HEADER / DETAILS ---------- */
                const details = normalizeArray(Response.jsonDetailsData);
                if (!IsPastDate) {
                    GetMedicinePlanData();
                    GetDBMaxSEQNO();
                }
                else {
                    PlanData = '';
                }
                if (details.length > 0) {
                    bindTreatmentHeader(details[0]);
                    $("#txtPlanNo").val(details[0].PlanID);   //20260706
                }
                if (Response.jsonTestData && Response.jsonTestData.length > 0) {
                    BindInvestigationData(Response.jsonTestData); // Bind the data to Tabulator
                    $("#btnRollOverInvestigation").hide();
                }
                if (Response.jsonInfusionData && Response.jsonInfusionData.length > 0) {
                    BindInfusionData(Response.jsonInfusionData);
                    $("#btnRollOverInfusion").hide();
                
                }
                if (Response.jsonBloodProductData && Response.jsonBloodProductData.length > 0) {
                    BindBloodProductData(Response.jsonBloodProductData);
                    $("#btnRollOverBloodProduct").hide();
                }
                if (Response.jsonSpecilInstData && Response.jsonSpecilInstData.length > 0) {
                    BindIVSuplementData(Response.jsonSpecilInstData);
                    $("#btnRollOverIVSupplement").hide();
                }
                if (Response.jsonChemoAData && Response.jsonChemoAData.length > 0) {
                    BindChemoData(Response.jsonChemoAData);
                }
                //if (Response.jsonAntibioticData && Response.jsonAntibioticData.length > 0) {
                //    BindMedicationData(Response.jsonAntibioticData);
                //    $("#btnRollOverAntibiotic").hide();
                //}
                //if (Response.jsonMedicineData && Response.jsonMedicineData.length > 0) {
                //    BindMedicineData(Response.jsonMedicineData);
                //    $("#btnRollOverMedication").hide();
                //}
                var FAntiData = [];
                if (Response.jsonAntibioticData && Response.jsonAntibioticData.length > 0) {
                    FAntiData = FAntiData.concat(Response.jsonAntibioticData);
                }
                if (Response.jsonStatOrderData && Response.jsonStatOrderData.length > 0) {
                    FAntiData = FAntiData.concat(Response.jsonStatOrderData);
                }
                if (FAntiData.length > 0) {
                    BindMedicationData(FAntiData);
                    $("#btnRollOverAntibiotic").hide();
                }
                var FMediData = [];
                if (Response.jsonMedicineData && Response.jsonMedicineData.length > 0) {
                    FMediData = FMediData.concat(Response.jsonMedicineData);
                }
                if (Response.jsonStatOrderMediData && Response.jsonStatOrderMediData.length > 0) {
                    FMediData = FMediData.concat(Response.jsonStatOrderMediData);
                }
                if (FMediData.length > 0) {
                    BindMedicineData(FMediData);
                    $("#btnRollOverMedication").hide();
                }
                if (Response.jsonDoctorData && Response.jsonDoctorData.length > 0) {
                    BindReferralData(Response.jsonDoctorData);
                    $("#OncologistContainer").show();
                }
                if (Response.jsonNutriData && Response.jsonNutriData.length > 0) {
                    BindNutritionData(Response.jsonNutriData);
                    $("#NutriContainer").show();
                }
                if ((Response.jsonDoctorData == "" || Response.jsonDoctorData.length == 0) && ($("#tractiondropdown").val() == "" || $('#tractiondropdown').val() == null)) {
                    $('.reason-textarea').prop("disabled", false);
                    $('.doctor-dropdown').prop("disabled", false);
                    $("#OncologistContainer").empty().hide();
                }
                else if ((Response.jsonDoctorData == "" || Response.jsonDoctorData.length == 0) && ($("#tractiondropdown").val() != "" || $('#tractiondropdown').val() != null)) {
                    $('.reason-textarea').prop("disabled", false); 
                    $('.doctor-dropdown').prop("disabled", false);
                    $("#OncologistContainer").empty().hide();
                }
                if ((Response.jsonNutriData.length == 0 || Response.jsonNutriData == "") && ($("#tractiondropdown").val() == "" || $('#tractiondropdown').val() == null)) {
                    $("#NutriContainer").empty().hide();
                }
                else if ((Response.jsonNutriData.length == 0 || Response.jsonNutriData == "") && ($("#tractiondropdown").val() != "" || $('#tractiondropdown').val() != null)) {
                    $("#NutriContainer").empty().hide();
                }

                //if ((ChemoListtable.getRows().length > 0) && gact == "E") {
                //    $("#btnSaveChemo").hide();
                //    $("#txtCPlanNo").text(details[0].PlanID);
/*              //      $("#txtCPlanDate").text(details[0].PlanDate);*/
                //    $("#txtCCourse").text(details[0].COURSENM);
                //    $("#txtTotalPlannedCycle").text(details[0].TotalCycle);
                //    $("#txtCCurrentCycle").text(details[0].CycleNo);
                //    $("#txtProtocolStartDate").text(details[0].STARTDATE);
                //    $("#txtProtocolName").text(details[0].ProtocolID);
                //    GetProtocolCode();
                //}
                //if ((ChemoListtable.getRows().length > 0) && gact == "E") {
                if ((ChemoListtable.getRows().length > 0)) {
                   // $("#btnSaveChemo").hide();            //COMMENTED ON 20261008
                    var protocolName = $("#ddlProtocol option[value='" + details[0].ProtocolID + "']").text().trim();
                    protocolName = protocolName.replace(/(.+)\1$/, "$1");

                    $("#txtCPlanNo").text(details[0].PlanID);
                    $("#txtCPlanDate").text(details[0].PlanDate);
                    $("#txtCCourse").text(details[0].COURSENM);
                    $("#txtTotalPlannedCycle").text(details[0].TotalCycle);
                    $("#txtCCurrentCycle").text(details[0].CycleNo);
                    $("#txtProtocolStartDate").text(details[0].STARTDATE);
                    $("#txtProtocolName").text(protocolName);
                    
                    // GetProtocolCode();

                }
                else {
                    //$("#btnSaveChemo").show();
                }
                if (details.length > 0 && details[0].PlanID) {
                    if (
                        details[0].PlanID !== undefined &&
                        details[0].PlanID !== null &&
                        details[0].PlanID !== "" &&
                        details[0].PlanID !== "undefined"
                    ) {
                        $("#ProtocolInfoSection").show();
                        $("#chemoPlanNo").show();
                        $("#chemoPlanDt").show();
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
    }
   
    /* Bind Header Section Of Few Details*/
   //function bindTreatmentHeader(data) {
   //    $("#txtHeight").val(data.HEIGHT);
   //    $("#txtWeight").val(data.WEIGHT);
   //    $("#txtBSA").val(data.BSA);
   //    $("#txtDiagnosis").val(data.DIAGNOSIS);
   //    $("#txtCycleNo").val(data.CycleNo);
   //    $("#txtCourse").val(data.COURSENM);
   //    $("#txtRemark").val(data.REMARK);
   //    $("#txtOthers").val(data.OTHER);
   //    $("#txtNutriRemark").val(data.DOCREMARK);
   //    window.PatientClinicalData = {
   //        height: data.HEIGHT,
   //        weight: data.WEIGHT,
   //        bsa: data.BSA
   //    };
   //}
    function bindTreatmentHeader(data) {
        const container = $("#commonPopupBody");
        var protocolName = $("#ddlProtocol option[value='" + data.ProtocolID + "']").text().trim();
        protocolName = protocolName.replace(/(.+)\1$/, "$1");

       // var Popup = $("#commonPopupBody");
        $("#txtHeight").val(data.HEIGHT);
        $("#txtWeight").val(data.WEIGHT);
        $("#txtBSA").val(data.BSA);
        $("#txtDiagnosis").val(data.DIAGNOSIS);
        //$("#txtCycleNo").val(data.CycleNo);
        //20260706
        CurrentPlan = {
            PlanID: data.PlanID,
            PlanDate: formatDate(data.PlanDate),
            TotCycleNo: data.TotalCycle,
            CycleNo: data.CycleNo,
            ProtocolData: data.ProtocolData,
            ProtocolID: data.ProtocolID,
            DayofCycle: data.Day,
            ProtocolType: data.ProtocolType,
            COURSENM: data.COURSENM,
            STARTDATE: formatDate(data.STARTDATE)
           
        };
        container.find("#txtCurrentCycle").val(data.CycleNo);
        container.find("#txtCourse").val(data.COURSENM);
        container.find("#txtTotalCycles").val(data.TotalCycle);
        container.find("#txtPlanDate").val(formatDate(data.PlanDate));
        container.find("#txtStartDate").val(formatDate(data.STARTDATE));
        container.find("#txtDayField").val(data.Day);
        container.find("#txtPlanNo").val(data.PlanID);
        container.find('#txtProtocoltye').val(data.ProtocolType);
        container.find('#txtProtocolCode').val(data.ProtocolID);
        container.find('#chemoData').val(data.ProtocolData);
        container.find("#ProtocolNM").text(protocolName);
       
        //End
        $("#txtRemark").val(data.REMARK);
        $("#txtOthers").val(data.OTHER);
        $("#txtNutriRemark").val(data.DOCREMARK);
        window.CurrentPlanID = data.PlanID; //20260706
        window.PatientClinicalData = {
            height: data.HEIGHT,
            weight: data.WEIGHT,
            bsa: data.BSA
        };
    }

    //Added By Aaryshree 20260317  for chaceking the weathre table has the data or not --> Chceking for save.
    function isTableHasData(tableInstance) {
        if (!tableInstance) return false;
        var rowData = tableInstance.getData();
        return rowData && rowData.length > 0;
    }

    function ValidationFoTrtmntOrderHeader() {
        if ($("#txtTransDate").val() == "") {
            ToastMsg("Please Select Date.", "warning");
            return false;
        }
        if ($("#txtTransTime").val() == "") {
            ToastMsg("Please Select Time.", "warning");
            return false;
        }
        return true
    }

    function sendToMainSave(specificData, typeLetter) {
        var PatName = sessionStorage.getItem('IPPatName');
        var IpNo = sessionStorage.getItem('IPPatIPNO') || "";
        var TreatmntSheetTranTm = $("#txtTransTime").val();
        var TreatmntSheetTranDt = $("#txtTransDate").val();
        var Remarks = $("#txtRemark").val();
        var NDOthers = $("#txtOthers").val();
        var DocRemarks = $("#txtNutriRemark").val();
        var BSA = parseFloat($("#VitalsDetails_txtBSA").text().trim());
        var Height = parseFloat($("#VitalsDetails_txtHeight").text().trim());
        var Weight = parseFloat($("#VitalsDetails_txtWeight").text().trim());
        var Allergies = $("#txtAllergies").val();
        var ProvDiagno = $("#txtProvDiagno").val();
        // var gact = ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) ? "N" : "E";


        var savedTranNo = Gbl_TranNo == "" ? sessionStorage.getItem('TreatmentTranNo') : Gbl_TranNo;


        var gact = Gbl_TranNo != "" || Gbl_TranNo != null ? "E" : "N"; //savedTranNo && ($('#tractiondropdown').val() != "" || $('#tractiondropdown').val() != null) ? "E" : "N";
        var treatTran = savedTranNo ? savedTranNo : $('#tractiondropdown').val();
        if (Gbl_TranNo == null || Gbl_TranNo == "") {
            gact = "N"
        }
        // var treatTran = $('#tractiondropdown').val();

        // var gact = treatTran != null ? "E" : "N";
        const container = $("#commonPopupBody");
        var planObj = {
            PlanID: CurrentPlan.PlanID || "",
            PlanDate: CurrentPlan.PlanDate || "",
            TotCycleNo: CurrentPlan.TotCycleNo || "",
            CycleNo: CurrentPlan.CycleNo || "",
            ProtocolData: CurrentPlan.ProtocolData || "",
            ProtocolID: CurrentPlan.ProtocolID || "",
            DayofCycle: CurrentPlan.DayofCycle || "",
            ProtocolType: CurrentPlan.ProtocolType || "",
            COURSENM: CurrentPlan.COURSENM || "",
            STARTDATE: CurrentPlan.STARTDATE || ""
        };
        //var planObj = {
        //    PlanID: ("" + container.find("#txtPlanNo").val()).trim(),
        //    PlanDate: ("" + container.find("#txtPlanDate").val()).trim(),
        //    TotCycleNo: ("" + container.find("#txtTotalCycles").val()).trim(),
        //    CycleNo: ("" + container.find("#txtCurrentCycle").val()).trim(),
        //    ProtocolData: ("" + container.find("#chemoData").val()).trim(),
        //    //ProtocolID: ("" + container.find("#ChemoProtocolTemplate").val()).trim(),
        //    ProtocolID: ("" + container.find('#txtProtocolCode').val()).trim(),
        //    DayofCycle: ("" + container.find("#txtDayField").val()).trim(),
        //    ProtocolType: ("" + container.find("#txtProtocoltye").val()).trim(),
        //    COURSENM: ("" + container.find("#txtCourse").val()).trim(),
        //    STARTDATE: ("" + container.find("#txtStartDate").val()).trim()
        //};
        // Initialize the payload with empty strings/arrays for all tables
        var finalData = {
            TS: {
                JsonChemoDet: JSON.stringify([planObj]),
                PatName: PatName,
                TreatmntSheetTranDt: TreatmntSheetTranDt,
                TreatmntSheetTranTm: TreatmntSheetTranTm,
                Remarks: Remarks,
                NDOthers: NDOthers,
                DocRemarks: DocRemarks,
                ProvDiagno: ProvDiagno,
                Allergies: Allergies,
                Weight: Weight,
                Height: Height,
                BSA: BSA

            },
            action: gact,
            IpNo: IpNo,
            MrNo: sessionStorage.getItem('IPPatMRNO') || "",
            PatName: PatName,
            //TranctionId: $("#tractiondropdown").val(),
            TranctionId: treatTran || "",
            TypData: typeLetter,
            DrVerified: gDoctCode,
            tableMedicationData: "[]",
            tableNebulizationData: "[]",
            tableSTATOrdFilterData: "[]",
            tableSpeciaInstructionsData: "[]",
            tableBloodProductData: "[]",
            tableInfusionData: "[]",
            tableInvestigationData: "[]",
            tableReferralsFilterData: "[]",
            tableAntibioticData: "[]",
            tableMeicationStatOrderData: "[]",
            tableChemoAntiData: "[]",
            tableChemoAMediData: "[]",
            tableNutriIntake : "[]"
        };
        switch (typeLetter) {
            case "I":
                if (typeof InfusionTable !== 'undefined')
                    finalData.tableInfusionData = JSON.stringify(mapInfusionData(InfusionTable.getData()));
                break;
            case "IV":
                if (typeof IVFluidTable !== 'undefined')
                    finalData.tableSpeciaInstructionsData = JSON.stringify(IVFluidTable.getData());
                if (typeof BloodProductTable !== 'undefined')
                    finalData.tableBloodProductData = JSON.stringify(BloodProductTable.getData());
                break;
            case "IR":
                if (typeof InvstgListtable !== 'undefined')
                    finalData.tableInvestigationData = JSON.stringify(mapTestData(InvstgListtable.getData()));

                var referralData = getReferralData();   
                finalData.tableReferralsFilterData = JSON.stringify(referralData);

                var NutritionData = getNutritionData();
                finalData.tableNutriIntake = JSON.stringify(NutritionData);
                break;
            case "C":
                if (typeof ChemoListtable !== 'undefined')
                    finalData.tableChemoAntiData = JSON.stringify(mapChemoData(ChemoListtable.getData()));
                break;
        }


        Object.assign(finalData, specificData);



        $.ajax({
            url: '../SinglePage/SaveTreatmentSheetTran',
            type: 'POST',
            async: false,
            data: JSON.stringify(finalData),
            contentType: 'application/json; charset=utf-8',
            success: function (response) {
                ToastMsg(response, "info");
                var tranNoMatch = response.match(/Transaction No\.\s*(\S+)/);
                if (tranNoMatch && tranNoMatch[1]) {
                    var tranNo = tranNoMatch[1];
                    Gbl_TranNo = tranNo;
                    sessionStorage.setItem('TreatmentTranNo', tranNo);
                }
            },
            error: function (err) {
                ToastMsg("Error saving " + typeLetter + ", please try again", "error");
                console.error(err);
            }
        });
    }

    /*Medicine Save and Validation*/
    function SaveTreatmentOrderMedicine({ },Type) {
        if (!validateMedicationTable()) return;
        var antibioticData = TrmtntOrderMedicineTable ? TrmtntOrderMedicineTable.getData() : [];
        var medicationData = TrmtntOrderMedicationTable ? TrmtntOrderMedicationTable.getData() : [];
        var FAntiMedData = Type == "S" ? antibioticData.filter(X => X.Freq == "SOS" || X.Freq == "STAT") : antibioticData.filter(X => X.Freq != "SOS" && X.Freq != "STAT");
        var FMedData = Type == "S" ? medicationData.filter(X => X.Freq == "SOS" || X.Freq == "STAT") : medicationData.filter(X => X.Freq != "SOS" && X.Freq != "STAT");
        var MedRouteList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
        FAntiMedData.forEach(row => {
            if (!row.HighAlert || row.HighAlert === "") {
                row.HighAlert = "N";
            }
            // row.OMIT = row.OMIT == "Y" ? "Y" : "N";
            row.OMIT = (row.OMIT === true || row.OMIT === "Y") ? "Y" : "N";
            row.isSavedOmit = true;
            var routeObj = MedRouteList.find(x => x.Value == row.Route);
            if (routeObj) {
                row.Route = routeObj.Text;
                row.RoutCode = routeObj.Value;
            }
            var FormObj = MedRouteList.find(x => x.FORMCODE == row.FormCode);
            if (FormObj) {
                row.Type = FormObj.FORMNAME;
                row.MtrFormCode = FormObj.FORMCODE;
            }
            row.DayOfDrug = row.DayOfDrug.toString();
            row.SQNumber = row.SQNumber.toString();
            row.Duration = row.Duration.toString();
            row.Diluent = row.Diluent.toString();
            row.TypeCode = row.Freq == "SOS" || row.Freq == "STAT" ? "SO" : row.TypeCode;
        });

        FMedData.forEach(row => {
            if (!row.HighAlert || row.HighAlert === "") {
                row.HighAlert = "N";
            }
            //row.OMIT = row.OMIT == true ? "Y" : "N";
            row.OMIT = (row.OMIT === true || row.OMIT === "Y") ? "Y" : "N";
            row.isSavedOmit = true;
            row.DilutionVolume = row.DilutionVolume ?? "";
            row.AdminstrDuration = row.AdminstrDuration ?? "";
            var routeObj = MedRouteList.find(x => x.Value == row.Route);
            if (routeObj) {
                row.Route = routeObj.Text;
                row.RoutCode = routeObj.Value;
            }
            var FormObj = MedRouteList.find(x => x.FORMCODE == row.FormCode);
            if (FormObj) {
                row.Type = FormObj.FORMNAME;
                row.MtrFormCode = FormObj.FORMCODE;
            }
            row.DayOfDrug = row.DayOfDrug.toString();
            row.SQNumber = row.SQNumber.toString();
            row.Duration = row.Duration.toString();
            row.Diluent = "";// row.Diluent.toString();
            row.TypeCode = row.Freq == "SOS" || row.Freq == "STAT" ? "SM" : row.TypeCode;
        });
        // var SeqMedData = ReSeqNoData(FMedData);
        // var SeqAntiData = ReSeqNoData(FAntiMedData);
        // sendToMainSave({ tableMedicationData: JSON.stringify(SeqMedData), tableAntibioticData: JSON.stringify(SeqAntiData) }, Type);
        sendToMainSave({
            tableMedicationData: JSON.stringify(FMedData),
            tableAntibioticData: JSON.stringify(FAntiMedData)
        }, Type);
        //sendToMainSave({ tableMedicationData: JSON.stringify(medicationData), tableAntibioticData: JSON.stringify(antibioticData) }, Type);
    }


    function ReSeqNoData(dataList) {

        dataList.sort(function (a, b) {
            return parseInt(a.SQNumber, 10) - parseInt(b.SQNumber, 10);
        });
        for (var i = 0; i < dataList.length; i++) {
            dataList[i].SQNumber = (i + 1).toString();
        }
        return dataList;
    }
    //function ReSeqNoData(DataList) {
    //    var DLst = DataList;
    //    var Ind = 1;
    //    for (var i = 0; i < DLst.length; i++) {
    //        DLst[i].SQNumber = (Ind++).toString();
    //    }
    //    return DLst;
    //}

    function validateMedicationTable() {
        if (!TrmtntOrderMedicineTable) return true;

        var data = TrmtntOrderMedicineTable.getData();
        var missingRows = [];

        data.forEach((row, index) => {
            if (
                !row.FormName || row.FormName.trim() === "" ||

                !row.Dose || row.Dose.trim() === "" ||
                !row.Route || row.Route.trim() === "" ||
                !row.Freq || row.Freq.trim() === "" ||
                !row.Diluent || row.Diluent.trim() === "" ||
                !row.DilutionVolume || row.DilutionVolume.trim() === "" ||
                !row.AdminstrDuration || row.AdminstrDuration.trim() === ""
            ) {
                missingRows.push(index + 1);
            }
        });

        if (missingRows.length > 0) {
            ToastMsg(
                "Please check fields Type, Day of Drug, Dose, Route, Frequency, Diluent, Dilution Volume, Duration of administration. They should not be empty in Table: Medicine.",
                "error"
            );
            return false;
        }

        return true;
    }
    function ValidationFoTrtmntOrderMedicine() {
        return validateMedicationTable();
    }
    function validateChemoTable() {
        if (!ChemoListtable) return true;

        var data = ChemoListtable.getData();
        var missingRows = [];

        data.forEach((row, index) => {

            if (row.Diluent && row.Diluent.trim() !== "") {
                if (!row.AdminstrDuration || row.AdminstrDuration.trim() === "" ||
                    !row.DilutionVolume || row.DilutionVolume.trim() === "") {
                    missingRows.push(index + 1);
                }
            }
        });

        if (missingRows.length > 0) {
            ToastMsg(
                "For rows where Diluent is specified, AdminstrDuration and Dilution Volume must not be empty in Table: Chemo.",
                "error"
            );
            return false;
        }

        return true;
    }


    function ValidationFoChemoTable() {
        return validateChemoTable();
    }

    function ValidateIVSuppTable() {
        if (!IVFluidTable) return false;

        var data = IVFluidTable.getData();
        var missingRows = [];

        data.forEach((row, index) => {
            var infusionRate = row.INFRATE != null ? String(row.INFRATE).trim() : "";
            var dilutionVol = row.DilutionVolume != null ? String(row.DilutionVolume).trim() : "";

            if (dilutionVol === "" || infusionRate === "") {
                missingRows.push(index + 1);
            }
        });

        if (missingRows.length > 0) {
            ToastMsg(
                "IV Supplement: Volume and Infusion Rate must not be empty.",
                "error"
            );
            return false;
        }

        return true;
    }
    function ValidateBloodProductTable() {
        if (!BloodProductTable) return false;

        var data = BloodProductTable.getData();
        var missingRows = [];

        data.forEach((row, index) => {
            var infusionRate = row.INFRATE != null ? String(row.INFRATE).trim() : "";
            var dilutionVol = row.DilutionVolume != null ? String(row.DilutionVolume).trim() : "";

            if (dilutionVol === "" || infusionRate === "") {
                missingRows.push(index + 1);
            }
        });

        if (missingRows.length > 0) {
            ToastMsg(
                "BloodProduct: Volume and Transfusion Rate must not be empty.",
                "error"
            );
            return false;
        }

        return true;
    }

    function ValidationForAntibiotic() {
        if (!TrmtntOrderMedicationTable) return true;

        var data = TrmtntOrderMedicationTable.getData();
        var missingRows = [];

        data.forEach((row, index) => {
            if (
                !row.FormName || row.FormName.trim() === "" ||

                !row.Dose || row.Dose.trim() === "" ||
                !row.Route || row.Route.trim() === "" ||
                !row.Freq || row.Freq.trim() === ""

            ) {
                missingRows.push(index + 1);
            }
        });

        if (missingRows.length > 0) {
            ToastMsg(
                "Please check fields Type, Day of Drug, Dose, Route, Frequency. They should not be empty in Table: Medicine.",
                "error"
            );
            return false;
        }

        return true;
    }

    function validationForTreatmentAntibiotic() {
        return ValidationForAntibiotic();
    }

    function validateIVsupplement() {
        return ValidateIVSuppTable();
    }

    function validateBloodProduct() {
        return ValidateBloodProductTable();
    }
    function SaveInfusionData() {
        sendToMainSave({}, "I");
    }

    function SaveIvFluid() {
        if (!ValidateIVSuppTable()) return;
        sendToMainSave({}, "IV");
    }

    function SaveBloodProduct() {
        if (!ValidateBloodProductTable()) return;
        sendToMainSave({}, "IV");
    }

    function SaveInvestigation() {
        sendToMainSave({}, "IR");
    }

    function SaveChemo() {
        if (!validateChemoTable()) return;
        sendToMainSave({}, "C");
    }
    function ValidationFoTrtmntOrderInfusion() { //priyanka 15/06/2026

        if (!isTableHasData(InfusionTable)) {
            return true;
        }

        const infusionData = InfusionTable.getData();

        const invalidRow = infusionData.find(row =>
            row.Infusion?.trim() &&
            (
                !row.InfusionRate?.toString().trim() ||
                !row.Dose?.toString().trim()
            )
        );

        if (invalidRow) {
            ToastMsg(
                `Dose and Infusion Rate are mandatory for Infusion: ${invalidRow.Infusion}`,
                "error"
            );
            return false;
        }

        return true;
    }
    function GetMedicinePlanData() {
        IpNo = sessionStorage.getItem('IPPatIPNO');
        transDate = '' + $("#txtTransDate").val();
        gblNurscode = '' + $("#HeaderSection_PatDetails_nurseCode").text();
        $.ajax({
            url: '../SinglePage/GetTSPlandList',
            data: { IPNum: IpNo, TsDate: transDate, RecordType: "P", IsRollver: "N", gblNurscode: gblNurscode },
            type: 'get',
            async: false,
            dataType: "json",
            success: function (ResposeResult) {
                if (ResposeResult != "Unsucessfull") {
                    PlanData = JSON.parse(ResposeResult);
                }

                else {
                    PlanData = "";
                }

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //MsgDia(textStatus, "Error Information");
                ToastMsg(textStatus, "error");
            }

        });
    }
    function CheckPlanData(SEQNUM, tbltype) {

        records = $.grep(PlanData.TRETMEDICINE, function (element, Index) {
            return (element.SEQNO == SEQNUM && element.RECTYPE == "P" && element.TBLTYPE == tbltype);
        })
        if (records.length > 0) {
            return true;
        }
        else {
            return false;
        }
    }


</script>


<%-- Medicine Script --%>
<script type="text/javascript">

    function BindTreatmentOrderData() {
        GetDBMaxSEQNO();
    }

    function GetAllMedicineList(FilterMedicineText, FilterMedicineCode) {
        $("#MedicineListMainDiv").show();
        startLoading("Loading", "loading-Medicine-Search-List");
        var strChecmoMedYN = "N";
        var Type = "";
        var IPNO = sessionStorage.getItem('IPPatIPNO');
        $.ajax({
            type: "POST",
            async: true,
            url: "../SinglePage/GetDruglst",
            data: { searchstring: FilterMedicineText, Type: Type, strChecmoMedYN: strChecmoMedYN, IPNO: IPNO },
            success: function (result) {
                var MedicineListData = [];
                if (result && result.rows && result.rows.length > 0) {
                    MedicineListData = result.rows; //.filter(item => item.ANTIBIOYN === "Y");
                   // MedicineListData = AddedMedicineList.concat(MedicineListData);
                    MedicineListData = MedicineList.concat(MedicineListData);
                    BindSearchListForMedicine(MedicineListData);

                } else {
                    $("#MedicineListMainDiv").hide();
                    ToastMsg("No data found", "info");
                    $("#MedicineList").empty();
                }

                stopLoading("loading-Medicine-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Medicine-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }
    function GetAllMedicationList(FilterMedicineText, FilterMedicineCode) {
        $("#MedicationListMainDiv").show();
        startLoading("Loading", "loading-Medication-Search-List");
        var strChecmoMedYN = "";
        var Type = "";
        var IPNO = sessionStorage.getItem('IPPatIPNO');
        $.ajax({
            type: "POST",
            async: true,
            url: "../SinglePage/GetDruglst",
            data: { searchstring: FilterMedicineText, Type: Type, strChecmoMedYN: strChecmoMedYN,IPNO:IPNO },
            success: function (result) {
                var MedicationListData = [];
                if (result && result.rows && result.rows.length > 0) {
                    MedicationListData = result.rows.filter(item => item.ANTIBIOYN === "N");
                    MedicationListData = MedicationList.concat(MedicationListData);
                    BindSearchListForMedication(MedicationListData);

                } else {
                    $("#MedicationListMainDiv").hide();
                    ToastMsg("No data found", "info");
                    $("#MedicationList").empty();
                }
                stopLoading("loading-Medication-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Medication-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function FilterBindedSearchListForMedicine() {
        medicationTable = "TrmtntOrderMedicineTable";
        var SearchTxt = $("#MedicineSearch").val().toLowerCase();
        var FlagForCallAllComplList = true;
        if (SearchTxt.length >= 3) {
            if (FlagForCallAllComplList == true)
                GetAllMedicineList($("#MedicineSearch").val(), "");
        }
        else {
            $("#MedicineListMainDiv").hide();
        }
    }
    function FilterBindedSearchListForMedication() {
        medicationTable = "TrmtntOrderMedicationTable";
        var SearchTxt = $("#MedicationSearch").val().toLowerCase();
        var FlagForCallAllComplList = true;
        if (SearchTxt.length >= 3) {
            if (FlagForCallAllComplList == true)
                GetAllMedicationList($("#MedicationSearch").val(), "");
        }
        else {
            $("#MedicationListMainDiv").hide();
        }
    }
    function BindSearchListForMedicine(MedicineData) {
        $("#MedicineListMainDiv").show();
        var $list = $("#MedicineList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">Not found</div>';
        if (MedicineData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < MedicineData.length; i++) {
                var item = MedicineData[i];
                var FormCode = GenericWiseYN == "Y" ? item.GENMTRLFORMCODE : item.MTRLFORMCODE;
                var FormNm = GenericWiseYN == "Y" ? item.GENMTRLFORM : item.MTRLFORM;
                var GenericDetails = 'data-FormCode="' + item.GENMTRLFORMCODE + '" data-FormName="' + item.GENMTRLFORM + '"';
                var MrtlDetails = 'data-FormCode="' + item.MTRLFORMCODE + '" data-FormName="' + item.MTRLFORM + '"';
                var GenListOption = '<div class="list-group-item w-50 AntiMed-row-Gen" ' + GenericDetails + ' data-code="' + item.GENERICID + '" data-name="' + item.GENERICNAM + '" data-isnewdrug="' + item.IsNewDrug + '" data-highalert="' + item.HighAlert + '" style="cursor:pointer;">' + item.GENERICNAM + '</div>';
                var MtrlListOption = '<div class="list-group-item w-50 AntiMed-row-Mtrl" ' + MrtlDetails + ' data-code="' + item.CODE + '" data-isnewdrug="' + item.IsNewDrug + '" data-name="' + item.NAME + '" data-highalert="' + item.HighAlert + '" style="cursor:pointer;">' + item.NAME + '</div>';
                //var CombinedOpt = '<div class="GroupOption">' + MtrlListOption + GenListOption + '</div>';
                // Abhishesh || 20260731
                var CombinedOpt = (GenericWiseYN == "Y")
                    ? '<div class="GroupOption">' + GenListOption.replace("w-50", "w-100") + '</div>'
                    : '<div class="GroupOption">' + MtrlListOption + GenListOption + '</div>';
                    //End
                AppendContentList = AppendContentList + CombinedOpt;
            }
          
            
            $("#MedicineList").append(AppendContentList);
            $("#MedicineListMainDiv").show();
        }
        else {
            $("#MedicineList").append(AppendContentList);
            $("#MedicineListMainDiv").hide();
        }
    }

    function BindSearchListForMedication(MedicineData) {
        var $list = $("#MedicationList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">Not found</div>';
        if (MedicineData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < MedicineData.length; i++) {
                var item = MedicineData[i];
                var FormCode = GenericWiseYN == "Y" ? item.GENMTRLFORMCODE : item.MTRLFORMCODE;
                var FormNm = GenericWiseYN == "Y" ? item.GENMTRLFORM : item.MTRLFORM;
                var GenericDetails = 'data-FormCode="' + item.GENMTRLFORMCODE + '" data-FormName="' + item.GENMTRLFORM + '"';
                var MrtlDetails = 'data-FormCode="' + item.MTRLFORMCODE + '" data-FormName="' + item.MTRLFORM + '"';
                var GenListOption = '<div class="list-group-item w-50 Medication-row-Gen" ' + GenericDetails + ' data-code="' + item.GENERICID + '" data-name="' + item.GENERICNAM + '" data-highalert="' + item.HighAlert + '" data-isnewdrug="' + item.IsNewDrug  + '" style="cursor:pointer;">' + item.GENERICNAM + '</div>';
                var MtrlListOption = '<div class="list-group-item w-50 Medication-row-Mtrl" ' + MrtlDetails + ' data-code="' + item.CODE + '" data-isnewdrug="' + item.IsNewDrug + '" data-highalert="' + item.HighAlert + '" data-name="' + item.NAME +  '" style="cursor:pointer;">' + item.NAME + '</div>';
                //var CombinedOpt = '<div class="GroupOption">' + MtrlListOption + GenListOption + '</div>';
                // Abhishesh || 20260731
                var CombinedOpt = (GenericWiseYN == "Y")
                    ? '<div class="GroupOption">' + GenListOption.replace("w-50", "w-100") + '</div>'
                    : '<div class="GroupOption">' + MtrlListOption + GenListOption + '</div>';
                    //End
                AppendContentList = AppendContentList + CombinedOpt;
            }
            $("#MedicationList").append(AppendContentList);
            $("#MedicationListMainDiv").show();
        }
        else {
            $("#MedicineList").append(AppendContentList);
            $("#MedicationListMainDiv").hide();
        }

    }

    function openDosePopup() {
        ClearDose();
        $("#btn2").click();
        document.getElementById("dosePopupOverlay").style.display = "flex";
    }
    //changed on 20290801
    function closeDosePopup() {
        $('#DSMedicineName').text("");
        $('#DSMedicineCode').text("");
        $('#DSGenericName').text("");
        $('#cmbUnit').val("");                    
        $('#cmbFrequency').val("");
        $('#TblMultipleDose tbody').empty();
        document.getElementById("dosePopupOverlay").style.display = "none";
    }
    //End

    function ClearNewDrugdata() {
        $('#txtMedicineName').val("");
        $('#txtGenericName').val("");
        $('#txtBrandName').val("");
        $('#ChkHighAlt')[0].checked = false;
    }

    //function RemoveIntakeSpan() {
    //    $('#btnCalulatedIntaKe input:last-child').remove();
    //}
    //Changes on 20260324 By Aaryshree
    function RemoveIntakeSpan() {
        $('#btnCalulatedIntaKe .BtnInke').last().remove();
    }
    function CallIntakeFreqChange(obj) {
        var freq = $(obj).val();
        if (freq != "Other") {
            $('.IntakeAdder').find('input').addClass('avoid-clicks');
            $('#btnCalulatedIntaKe input').remove();
            var NewSpan = '<input type="text"  maxlength="10" class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;"></span></input>';
            $('#btnCalulatedIntaKe').append(NewSpan);
        }
        else {
            $('.IntakeAdder').find('input').removeClass('avoid-clicks');
        }
    }

    function CalculateDose(obj) {
        var IntakeVal = $('.btn-group').children('.active').val();
        var ChildSpan = $(obj).children();
        var resval = Number($(ChildSpan).text()) + Number(IntakeVal);
        $(ChildSpan).text(Number(resval.toFixed(3)));
    }

    function DoseCombination() {

        if ($('#cmbFrequency').val() == "" || $('#cmbFrequency').val() == null) {
            $('#cmbFrequency').css('border-color', 'red'); $('#cmbFrequency').css('border-width', '2px'); $('#cmbFrequency').focus();
            return false;
        }
        if ($('#cmbUnit').val() == "") {
            $('#cmbUnit').css('border-color', 'red'); $('#cmbUnit').css('border-width', '2px'); $('#cmbUnit').focus();
            return false;
        }
        //var AllbtnIntake = $('#btnCalulatedIntaKe').children();
        var AllbtnIntake = $('#btnCalulatedIntaKe .BtnInke');  //Changes on 20260324 By Aaryshree
        var IntakeTime = AllbtnIntake.length;
        var arrCom = new Array(IntakeTime);
        var flag = true;
        var MediCode = "";
        var MediName = "";
        var MediGenNM = "";
        var MediBrndNM = "";
        var MediHighAlt = "";
        var MediQOH = "";
        var cmbFeq = $('#cmbFrequency').val();
        var DrugForm = "";
        var DrugFormNM = "";
        var IsNewDrug = "";
        InitializeArray(arrCom);
        $.each(AllbtnIntake, function (Index, Element) {
            MediCode = $('#DSMedicineCode').text().trim().replace(/[^0-9a-zA-Z]/gi, '');
            MediName = $('#DSMedicineName').text().trim();
            MediGenNM = $('#DSGenericName').text().trim();
            MediBrndNM = $('#DSBrandName').text().trim();
            MediHighAlt = $('#DSHighAlt').val().trim();
            MediQOH = $('#DSQOH').text().trim();
            DrugForm = $('#DSFormCode').val().trim();
            DrugFormNM = $('#DSFormName').val().trim();
            Dilution = $('#DSDilution').text().trim();
            IsNewDrug = "" + $("#DSIsFromNew").val();
            if (IsNewDrug == "undefined") {
                IsNewDrug = IsNewDrug == "undefined" ? "N" : ""
            }
            if (MediHighAlt == "undefined") {
                MediHighAlt = MediHighAlt == "undefined" ? "N" : ""
            }
            // var Dose = $(Element).children().text();
            var Dose = $(Element).val();     //Changes on 20260324 By Aaryshree
            if (Number(Dose) > 0) {
                arrCom[Index] = 1;
                flag = false;
                if (cmbFeq == "Other") {
                    CreateDoseRows(Index, Dose, arrCom, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, DrugForm, DrugFormNM, Dilution, IsNewDrug);
                }
                else {
                    CreateSingleRecord(Dose, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, cmbFeq, DrugForm, DrugFormNM, Dilution, IsNewDrug);
                }
            }
            InitializeArray(arrCom);
        })

        if (flag) {
            $('#btnCalulatedIntaKe .BtnInke').css({
                'border': '2px solid red',
                'box-shadow': '0 0 5px red',
                'border-radius': '4px'
            });

            ToastMsg("Please select at least one intake dose before proceeding.", "warning");
            return false;
        }
        AddItemToGrid();
        closeDosePopup();
       
    }

    function clearMutiDoseData() {
        $('#DSMedicineName').text("");
        $('#DSMedicineCode').text("");
        $('#DSGenericName').text("");
        $('#DSBrandName').text("");
        $('#DSHighAlt').text("");
        $('#DSQOH').text("");
        $('#DSDilution').text("");
        $('#cmbUnit').val("");
        $('#btnCalulatedIntaKe').children().each(function (index, element) {
            $(element).children().text(0);
        })
        $(".btn-group > .btn").removeClass("active");
        $($(".btn-group > .btn")[0]).addClass("active");
        $('#cmbFrequency').val('Other');
    }

    function clearMutiDoseData() {
        $('#DSMedicineName').text("");
        $('#DSMedicineCode').text("");
        $('#DSGenericName').text("");
        $('#DSBrandName').text("");
        $('#DSHighAlt').text("");
        $('#DSQOH').text("");
        $('#DSDilution').text("");
        $('#cmbUnit').val("");

        $('#btnCalulatedIntaKe').children().each(function (index, element) {
            $(element).children().text(0);
        })


        $(".btn-group > .btn").removeClass("active");
        $($(".btn-group > .btn")[0]).addClass("active");

        $('#cmbFrequency').val('Other');
    }
    //Changes on 20260324 By Aaryshree
    function AddDefaultIntakeSpan() {

        $('#btnCalulatedIntaKe input').remove();

        for (i = 0; i < 3; i++) {
            var NewSpan = '<input type="text" maxlength="10" class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;"></span></input>';
            $('#btnCalulatedIntaKe').append(NewSpan);
        }

        $(".BtnInke").on('mousedown', function () {
            startTime = new Date().getTime();
        });

        $(".BtnInke").on('mouseup', function () {
            endTime = new Date().getTime();
        });

        $("#cmbFrequency").change();
    }

    function AddIntakeSpan() {
        var NewSpan = '<input type="text"  maxlength="10"  class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;"></span></input>';
        $('#btnCalulatedIntaKe').append(NewSpan);

        $(".BtnInke").on('mousedown', function () {
            startTime = new Date().getTime();
        });

        $(".BtnInke").on('mouseup', function () {
            endTime = new Date().getTime();
        });
    }
    //Changes on 20260324 By Aaryshree
    function ClearDose() {                                 //vishal 14th Nov         
        //var obje = $("#AddMultiDose").find('.BtnInke')
        var ChildSpan = $("#AddMultiDose").find('input.BtnInke')[0];
        $(ChildSpan).text(0);
        var ChildSpan1 = $("#AddMultiDose").find('input.BtnInke')[1];
        $(ChildSpan1).text(0);
        var ChildSpan2 = $("#AddMultiDose").find('input.BtnInke')[2];
        $(ChildSpan2).text(0);
        AddDefaultIntakeSpan();
    }

    function RemoveMultiDose(MediCode) {
        $("#TblMultipleDose tbody").find('tr[name="' + MediCode + '"]').remove();
    }

    function CallIntakeFreqChange(obj) {
        var freq = $(obj).val();
        if (freq != "Other") {
            $('.IntakeAdder').find('input').addClass('avoid-clicks');
            $('#btnCalulatedIntaKe input').remove();
            var NewSpan = '<input type="text"  maxlength="10"  class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;"></span></input>';
            $('#btnCalulatedIntaKe').append(NewSpan);
        }
        else {
            $('.IntakeAdder').find('input').removeClass('avoid-clicks');
        }
    }

    function CreateSingleRecord(Dose, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, feq, DrugForm, DrugFormNM, Dilution, IsNewDrug) {
        var Unit = "";
        var Unit = $('#cmbUnit').val().trim();
        if (Dose.toString().trim() == "") {
            Unit = "";
        }
        var tr = "<tr class='" + MediCode + "' name='" + MediCode + "' id='" + MediCode + "'>"
            + "<td class='MediCD'>" + MediCode + "</td>"
            + "<td class='MediNM'>" + MediName + "</td>"
            + "<td class='GenriName'>" + MediGenNM + "</td>"
            + "<td class='BrandName'>" + MediBrndNM + "</td>"
            + "<td class='HighAlert'>" + MediHighAlt + "</td>"
            + "<td class='QOH'>" + MediQOH + "</td>"
            + "<td class='Dose'>" + Dose + "</td>"
            + "<td class='Feq'>" + feq + "</td>"
            + "<td class='Unit'>" + Unit + "</td>"
            + "<td class='DrugForm'>" + DrugForm + "</td>"
            + "<td class='DrugFormNM'>" + DrugFormNM + "</td>"
            + "<td class='Dilution'>" + Dilution + "</td>" 
            + "<td class='IsNewDrug'>" + IsNewDrug + "</td>"
            +"</tr>"
        $("#TblMultipleDose tbody").append(tr);
    }

    function CreateDoseRows(Index, Dose, arrCom, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, DrugForm, DrugFormNM, Dilution, IsNewDrug) {
        var rowChk = $("#TblMultipleDose tbody").find('tr.' + Dose.replace('.', '_') + "_" + MediCode);
        var Unit = $('#cmbUnit').val().trim();
        if (rowChk.length > 0) {
            var Fequency = $(rowChk).find('td.Feq').text();
            var FeqArr = Fequency.split('-');
            FeqArr[Index] = 1;
            $(rowChk).find('td.Feq').text(FeqArr.join('-'));
        }
        else {

            var tr = "<tr class='" + Dose.replace('.', '_') + "_" + MediCode + "' name='" + MediCode + "'>"
                + "<td class='MediCD'>" + MediCode + "</td>"
                + "<td class='MediNM'>" + MediName + "</td>"
                + "<td class='GenriName'>" + MediGenNM + "</td>"
                + "<td class='BrandName'>" + MediBrndNM + "</td>"
                + "<td class='HighAlert'>" + MediHighAlt + "</td>"
                + "<td class='QOH'>" + MediQOH + "</td>"
                + "<td class='Dose'>" + Dose + "</td>"
                + "<td class='Feq'>" + arrCom.join('-') + "</td>"
                + "<td class='Unit'>" + Unit + "</td>"
                + "<td class='DrugForm'>" + DrugForm + "</td>"
                + "<td class='DrugFormNM'>" + DrugFormNM + "</td>"
                + "<td class='Dilution'>" + Dilution + "</td>" 
                + "<td class='IsNewDrug'>" + IsNewDrug + "</td>"
            +"</tr>"
            $("#TblMultipleDose tbody").append(tr);
        }
    }

    //
    function GetFinalTypeCode(gridName, frequency) {

        if (gridName === "TrmtntOrderMedicineTable") {

            if (frequency === "STAT" || frequency === "SOS") {
                return "SO";
            }

            return "AB";
        }

        if (gridName === "TrmtntOrderMedicationTable") {

            if (frequency === "STAT" || frequency === "SOS") {
                return "SM";
            }

            return "MD";
        }

        return "MD";
    }
    function RecalculateMaxSEQNOForType(tblType) {

        var gridMax = 0;

        var data = TrmtntOrderMedicineTable.getData();

        $.each(data, function (index, item) {

            if (item.TypeCode == tblType &&
                item.SQNumber != null &&
                item.SQNumber !== "") {

                var seq = Number(item.SQNumber);

                if (!isNaN(seq) && seq > gridMax) {
                    gridMax = seq;
                }
            }
        });

        // Get existing cached/backend maximum
        var maxData = GetMaxSEQNOByType(tblType);

        var backendMax = 0;

        if (maxData && maxData.length > 0) {
            backendMax = Number(maxData[0].Column1) || 0;
        }

        // NEVER decrease the sequence after delete
        var finalMax = Math.max(backendMax, gridMax);

        UpdateMaxSEQNOArray(tblType, finalMax);

        return finalMax;
    }

    function GetNextSequence(typeCode) {

        var backendMax = 0;
        var gridMax = 0;
        var maxData = GetMaxSEQNOByType(typeCode);

        if (maxData && maxData.length > 0) {
            backendMax = Number(maxData[0].Column1) || 0;
        }
        var gridData = TrmtntOrderMedicineTable.getData();

        $.each(gridData, function (index, item) {

            if (item.TypeCode === typeCode &&
                item.SQNumber != null &&
                item.SQNumber !== "") {

                var seq = Number(item.SQNumber);

                if (!isNaN(seq) && seq > gridMax) {
                    gridMax = seq;
                }
            }
        });

        var nextSEQ = Math.max(backendMax, gridMax) + 1;
        return nextSEQ;
    }

    function AddItemToGrid() {
        var selectRows = $('#TblMultipleDose tbody tr').get();
        if (medicationTable == "TrmtntOrderMedicineTable") {
            AddItemToTable(selectRows);
        }
        else if (medicationTable == "TrmtntOrderMedicationTable") {
            AddItemToMedicationTable(selectRows);
        }
        $('#TblMultipleDose tbody').empty();
        closeDosePopup();
    }

    function AddItemToTable(obj) {
        var TrmtntOrderMedicineTbl = TrmtntOrderMedicineTable;
        var Flag = false;
        var GenericName = '';
        var BrnadName = '';
        var HighAlertVal = '';
        var Dose = '';
        var Fequency = '';
        var Unit = '';
        //var IsNewDrug = '';

        TodaysDate = $('#txtTransDate').val();

        $.each(obj, function (i, obj) {
            var DrugCode = $(obj).find('td.QOH').text();
            var MaterialCode = $(obj).find('td.MediCD').text();
            var MaterialName = $(obj).find("td.MediNM").text();

            if (!MaterialName) {
                ToastMsg("Generic name cannot be empty. Please select a valid medicine.", "warning");
                return;
            }

            var RowData = TrmtntOrderMedicineTbl.getData();
            //var MaxSEQNO = GetMaxSEQNO("TrmtntOrderMedicineTable");

            GenericName = $(obj).find("td.GenriName").text();
            BrnadName = $(obj).find("td.BrandName").text();
            HighAlertVal = $(obj).find("td.HighAlert").text() || "N";
            Dose = $(obj).find("td.Dose").text();
            Fequency = $(obj).find("td.Feq").text();
            Unit = $(obj).find("td.Unit").text();
            Form = $(obj).find("td.DrugForm").text(); 
            FormNm = $(obj).find("td.DrugFormNM").text(); 
            Dilution = $(obj).find("td.Dilution").text();
            IsNewDrug = $(obj).find("td.IsNewDrug").text();
            
            var finalTypeCode = GetFinalTypeCode(
                "TrmtntOrderMedicineTable",
                Fequency
            );

            // Now get sequence for SO or AB
            var MaxSEQNO = GetMaxSEQNOByType(finalTypeCode);
            // Duplicate check
            var GetItem = RowData.filter(n => n["DrugCode"] != "");
            var AlredyAddItemChk = GetItem.filter(n => {
                var Doseval = n["Dose"].replace(/[^0-9\.]+/g, "").replace(/\./g, '_');
                var Duplicate = n["DrugCode"] + Doseval;
                return Duplicate == (MaterialCode + Dose.replace(/\./g, '_'));
            });

            // $.each(AlredyAddItemChk, function (I, E) {
            //     var endDate = parseDate(E.ENDDATE);
            //     var serverDate = parseDate(ServerDate);
            //     var isDayComp = endDate < serverDate;

            //     if (E.hasOwnProperty('OMIT') || E.hasOwnProperty('cancellation')) {
            //         Flag = (E.OMIT == "Y" || E.STATUS == "C" || isDayComp);
            //     }
            // });

            // if (Flag) AlredyAddItemChk = {};

            // if (AlredyAddItemChk.length > 0) {
            //     ToastMsg("This Record already Added In table", "warning");

            // }
            var Flag = AlredyAddItemChk.some(E => {

                if (E.STATUS == "C" || E.OMIT == "Y") {
                    return false;
                }

                var endDate = parseDate(E.ENDDATE);
                var serverDate = parseDate(ServerDate);

                var isDayComp = endDate < serverDate;

                return !isDayComp;
            });

            if (Flag) {
                ToastMsg("This Record already Added In table", "warning");
            }
            else {
                var rowId = GetItem.length + 1;

                // Add new row if needed
                if (rowId == TrmtntOrderMedicineTbl.getData().length || TrmtntOrderMedicineTbl.getData().length == 0 || rowId > TrmtntOrderMedicineTbl.getData().length) {
                    var adddata = {};
                    adddata = {
                        action: "", FormName: "", Medicine: "", DayOfDrug: "", Dose: "", Route: "", Freq: "", Duration: "1",
                        OMIT: "", Remark: "", TypeCode: finalTypeCode, OmittedBy: '', OmittedByName: "", OmittedDate: '', OmittedTime: '',
                        OrderedBy: '', OrderedDate: '', OrderedTime: '', STATUS: "A", MEDSTAT: "M", SQNumber: rowId, HOLD: ""
                    };
                    TrmtntOrderMedicineTbl.addRow(adddata, true);
                }

                // Update row values
                if (gCIMSYN == "Y") {
                    TrmtntOrderMedicineTbl.updateRow(rowId, {
                        //["DrugName"]: `<span class='fa fa-info-circle fa-1x medInfoSpan' style='font-size:1.5em' id="${MaterialCode}"></span> ${MaterialName} (${GenericName})`,
                        ["DrugName"]: `${MaterialName} (${GenericName})`,
                        FormName: FormNm,
                        FormCode: Form,
                        ADMINYN: "N",
                        STATUS: "A",
                        Dose: Dose + " " + Unit,
                        Freq: Fequency,
                        Route: "",
                        HighAlert: HighAlertVal,
                        IsNewDrug: IsNewDrug
                    });
                    if (HighAlertVal == "Y") {
                        TrmtntOrderMedicineTbl.getRow(rowId).getElement().classList.add("HighAlertDrug");
                    }
                } else {
                    TrmtntOrderMedicineTbl.updateRow(rowId, {
                        ["DrugName"]: (BrnadName.toUpperCase().trim() != "" && BrnadName.toUpperCase().trim() != "NONE" && BrnadName.toUpperCase().trim() != "NA")
                            ? (BrnadName + " (" + GenericName + ")")
                            : MaterialName,
                        FormName: FormNm,
                        FormCode: Form,
                        ADMINYN: "N",
                        STATUS: "A",
                        Dose: Dose + " " + Unit,
                        Freq: Fequency,
                        Diluent: Dilution,
                        INDENTYN: "N",
                        ISSUEYN: "N",
                        IsRollOver: (ISRYN == "Y" ? "Y" : "N"),
                        Route: "",
                        HighAlert: HighAlertVal,
                        IsNewDrug: IsNewDrug
                    });
                    if (HighAlertVal == "Y") {
                        TrmtntOrderMedicineTbl.getRow(rowId).getElement().classList.add("HighAlertDrug");
                    }
                }

                // Common updates
                 TrmtntOrderMedicineTbl.updateRow(rowId, {
                    ["DrugCode"]: MaterialCode,
                    OrderedBy: gDoctId,
                    OrderedByName: gDoctName,
                    OrderedDate: GetTodaysDate(),
                    OrderedTime: GetTimewithAMPM(),
                    NOTIFYN: "N",
                    HighAlert: HighAlertVal
                });
                SetStartDateColumn("TrmtntOrderMedicineTable", rowId);
                TrmtntOrderMedicineTbl.updateRow(rowId, { DayOfDrug: 1 });
                let row = TrmtntOrderMedicineTbl.getRow(rowId);
                let cell = row.getCell("AntiBoDGSTARTDATE");
                cell.getElement().classList.add("avoid-clicks");
                var data = TrmtntOrderMedicineTbl.getData();
                var rows = TrmtntOrderMedicineTbl.getRows();
     
                // if (MaxSEQNO.length > 0) {
                //     TrmtntOrderMedicineTbl.updateRow(rowId, { SQNumber: Number(MaxSEQNO[0].Column1) + 1 });
                //     UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicineTable"), Number(MaxSEQNO[0].Column1) + 1);
                // } else if (GetItem.length > 0) {
                //     var lastSEQNum = GetItem[GetItem.length - 1].SQNumber;
                //     TrmtntOrderMedicineTbl.updateRow(rowId, { SQNumber: Number(lastSEQNum) + 1 });
                //     UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicineTable"), Number(lastSEQNum) + 1);
                // } else {
                //     TrmtntOrderMedicineTbl.updateRow(rowId, { SQNumber: GetItem.length + 1 });
                //     UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicineTable"), GetItem.length + 1);
                // }
                
                var typeCode = finalTypeCode;

                // Get backend max for this TypeCode
                var MaxSEQNO = GetMaxSEQNOByType(typeCode);

                var backendMax = 0;

                if (MaxSEQNO &&
                    MaxSEQNO.length > 0 &&
                    MaxSEQNO[0].Column1 != null &&
                    MaxSEQNO[0].Column1 !== "") {

                    backendMax = Number(MaxSEQNO[0].Column1) || 0;
                }

                var nextSEQ = 1;

                if ((Fequency === "STAT" || Fequency === "SOS") &&
                    typeCode === "SO") {

                    if (backendMax > 0) {
                        nextSEQ = backendMax + 1;

                    } else {
                        var smCount = 0;

                        $.each(TrmtntOrderMedicineTbl.getData(), function(index, item) {

                            if (index + 1 === rowId) {
                                return;
                            }

                            if (item.TypeCode === "SO" &&
                                item.SQNumber != null &&
                                item.SQNumber !== "") {

                                smCount++;
                            }
                        });

                        nextSEQ = smCount + 1;
                    }

                }
                else if (typeCode === "AB") {

                    if (backendMax > 0) {
                        nextSEQ = backendMax + 1;
                    } else {

                        var mdMax = 0;

                        $.each(TrmtntOrderMedicineTbl.getData(), function(index, item) {

                            if (index + 1 === rowId) {
                                return;
                            }

                            if (item.TypeCode === "AB" &&
                                item.SQNumber != null &&
                                item.SQNumber !== "") {

                                var currentSEQ = Number(item.SQNumber) || 0;

                                if (currentSEQ > mdMax) {
                                    mdMax = currentSEQ;
                                }
                            }
                        });

                        nextSEQ = mdMax + 1;
                    }

                }
                else {
                    nextSEQ = backendMax + 1;
                }
                TrmtntOrderMedicineTbl.updateRow(rowId, {
                    SQNumber: nextSEQ,
                    TypeCode: typeCode
                });

                UpdateMaxSEQNOArray(typeCode, nextSEQ);
                var data = TrmtntOrderMedicineTbl.getData();
                var rows = TrmtntOrderMedicineTbl.getRows();

                if (data.length > 0) {
                    for (var c = 0; c < data.length; c++) {
                        var rowEl = rows[c].getElement();
                        var check = rowEl.querySelector("input[type=checkbox]");

                        if (data[c]["OMIT"] == "N" &&
                            data[c]["ADMINYN"] == "N" &&
                            data[c]["NOTIFYN"] == "N") {
                            if (check) check.disabled = true;
                        } else if (data[c]["OMIT"] == "Y") {
                            TrmtntOrderMedicineTbl.updateRow(c + 1, { OMIT: "N" });
                            if (check) check.disabled = true;
                        }
                    }
                }
                // if (data.length > 0) {
                //     for (var c = 0; c <= data.length - 1; c++) {
                //         if (data[c]["OMIT"] == "N" && data[c]["ADMINYN"] == "N" && data[c]["NOTIFYN"] == "N") {
                //             var rowEl = TrmtntOrderMedicineTbl.getRow(c + 1).getElement();
                //             var check = rowEl.querySelector("input[type=checkbox]");
                //             if (check) check.disabled = true;
                //         } else if (data[c]["OMIT"] == "Y") {
                //             TrmtntOrderMedicineTbl.updateRow(rowId, { OMIT: "N" });
                //             var rowEl = TrmtntOrderMedicineTbl.getRow(c + 1).getElement();
                //             var check = rowEl.querySelector("input[type=checkbox]");
                //             if (check) check.disabled = true;
                //         }
                //     }
                // }
            }
        });
        MedicinColorIndications();
    }
    function AddItemToMedicationTable(obj) {
        var TrmtntOrderMedicationTbl = TrmtntOrderMedicationTable;
        var Flag = false;
        var GenericName = '';
        var BrnadName = '';
        var HighAlertVal = '';
        var Dose = '';
        var Fequency = '';
        var Unit = '';

        TodaysDate = $('#txtTransDate').val();

        $.each(obj, function (i, obj) {
            var DrugCode = $(obj).find('td.QOH').text();
            var MaterialCode = $(obj).find('td.MediCD').text();
            var MaterialName = $(obj).find("td.MediNM").text();

            if (!MaterialName) {
                ToastMsg("Generic name cannot be empty. Please select a valid medicine.", "warning");
                return;
            }

            var RowData = TrmtntOrderMedicationTbl.getData();
            //var MaxSEQNO = GetMaxSEQNO("TrmtntOrderMedicationTable");

            GenericName = $(obj).find("td.GenriName").text();
            BrnadName = $(obj).find("td.BrandName").text();
            HighAlertVal = $(obj).find("td.HighAlert").text() || "N";
            Dose = $(obj).find("td.Dose").text();
            Fequency = $(obj).find("td.Feq").text();
            Unit = $(obj).find("td.Unit").text();
            Form = $(obj).find("td.DrugForm").text();
            FormNm = $(obj).find("td.DrugFormNM").text(); 
            Dilution = $(obj).find("td.Dilution").text();
            IsNewDrug = $(obj).find("td.IsNewDrug").text();

            var finalTypeCode = GetFinalTypeCode(
                "TrmtntOrderMedicationTable",
                Fequency
            );

            var MaxSEQNO = GetMaxSEQNOByType(finalTypeCode);
            // Duplicate check
            var GetItem = RowData.filter(n => n["DrugCode"] != "");
            var AlredyAddItemChk = GetItem.filter(n => {
                var Doseval = n["Dose"].replace(/[^0-9\.]+/g, "").replace(/\./g, '_');
                var Duplicate = n["DrugCode"] + Doseval;
                return Duplicate == (MaterialCode + Dose.replace(/\./g, '_'));
            });

            $.each(AlredyAddItemChk, function (I, E) {
                var endDate = parseDate(E.ENDDATE);
                var serverDate = parseDate(ServerDate);
                var isEndDayComp = endDate < serverDate;
                if (E.hasOwnProperty('OMIT') || E.hasOwnProperty('cancellation')) {
                    Flag = (E.OMIT == "Y" || E.STATUS == "C" || isEndDayComp);
                }
            });

            if (Flag) AlredyAddItemChk = {};

            if (AlredyAddItemChk.length > 0) {
                ToastMsg("This Record already Added In table", "warning");

            } else {
                var rowId = GetItem.length + 1;

                // Add new row if needed
                if (rowId == TrmtntOrderMedicationTbl.getData().length || TrmtntOrderMedicationTbl.getData().length == 0 || rowId > TrmtntOrderMedicationTbl.getData().length) {
                    var adddata = {};
                    adddata = {
                        action: "", FormName: "", Medicine: "", DayOfDrug: "", Dose: "", Route: "", Freq: "", Duration: "1", // Abhishesh || 20260801
                        OMIT: "", Remark: "", TypeCode: finalTypeCode, OmittedBy: '', OmittedByName: "", OmittedDate: '', OmittedTime: '',
                        OrderedBy: '', OrderedDate: '', OrderedTime: '', STATUS: "A", MEDSTAT: "M", SQNumber: rowId, HOLD: ""
                    };
                    TrmtntOrderMedicationTbl.addRow(adddata, true);
                }

                // Update row values
                if (gCIMSYN == "Y") {
                    TrmtntOrderMedicationTbl.updateRow(rowId, {
                        //["DrugName"]: `<span class='fa fa-info-circle fa-1x medInfoSpan' style='font-size:1.5em' id="${MaterialCode}"></span> ${MaterialName} (${GenericName})`,
                        ["DrugName"]: `${MaterialName} (${GenericName})`,
                        FormName: FormNm,
                        FormCode: Form,
                        ADMINYN: "N",
                        STATUS: "A",
                        Dose: Dose + " " + Unit,
                        Freq: Fequency,
                        Route: "",
                        HighAlert: HighAlertVal,
                        IsNewDrug: IsNewDrug
                    });
                    if (HighAlertVal == "Y") {
                        TrmtntOrderMedicationTbl.getRow(rowId).getElement().classList.add("HighAlertDrug");
                    }
                } else {
                    TrmtntOrderMedicationTbl.updateRow(rowId, {
                        ["DrugName"]: (BrnadName.toUpperCase().trim() != "" && BrnadName.toUpperCase().trim() != "NONE" && BrnadName.toUpperCase().trim() != "NA")
                            ? (BrnadName + " (" + GenericName + ")")
                            : MaterialName,
                        FormName: FormNm,
                        FormCode: Form,
                        ADMINYN: "N",
                        STATUS: "A",
                        Dose: Dose + " " + Unit,
                        Freq: Fequency,
                        Diluent: Dilution,
                        INDENTYN: "N",
                        ISSUEYN: "N",
                        IsRollOver: (ISRYN == "Y" ? "Y" : "N"),
                        Route: "",
                        HighAlert: HighAlertVal,
                        IsNewDrug: IsNewDrug
                    });
                    if (HighAlertVal == "Y") {
                        TrmtntOrderMedicationTbl.getRow(rowId).getElement().classList.add("HighAlertDrug");
                    }
                }

                // Common updates
                TrmtntOrderMedicationTbl.updateRow(rowId, {
                    ["DrugCode"]: MaterialCode,
                    OrderedBy: gDoctId,
                    OrderedByName: gDoctName,
                    OrderedDate: GetTodaysDate(),
                    OrderedTime: GetTimewithAMPM(),
                    NOTIFYN: "N",
                    HighAlert: HighAlertVal
                });
                SetStartDateMColumn("TrmtntOrderMedicationTable", rowId);
                TrmtntOrderMedicationTbl.updateRow(rowId, { DayOfDrug: 1 });

                // Disable clicks on specific cell
                let row = TrmtntOrderMedicationTbl.getRow(rowId);
                let cell = row.getCell("MediDGSTARTDATE");
                cell.getElement().classList.add("avoid-clicks");

                //AddDelButtonByNew(TrmtntOrderMedicineTbl, rowId);

                var data = TrmtntOrderMedicationTbl.getData();
                // Sequence number logic
                // if (MaxSEQNO.length > 0) {
                //     TrmtntOrderMedicationTbl.updateRow(rowId, { SQNumber: Number(MaxSEQNO[0].Column1) + 1 });
                //     UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicationTable"), Number(MaxSEQNO[0].Column1) + 1);
                // } else if (GetItem.length > 0) {
                //     var lastSEQNum = GetItem[GetItem.length - 1].SQNumber;
                //     TrmtntOrderMedicationTbl.updateRow(rowId, { SQNumber: Number(lastSEQNum) + 1 });
                //     UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicationTable"), Number(lastSEQNum) + 1);
                // } else {
                //     TrmtntOrderMedicationTbl.updateRow(rowId, { SQNumber: GetItem.length + 1 });
                //     UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicationTable"), GetItem.length + 1);
                // }

                var typeCode = finalTypeCode;

                // Get backend max for this TypeCode
                var MaxSEQNO = GetMaxSEQNOByType(typeCode);

                var backendMax = 0;

                if (MaxSEQNO &&
                    MaxSEQNO.length > 0 &&
                    MaxSEQNO[0].Column1 != null &&
                    MaxSEQNO[0].Column1 !== "") {

                    backendMax = Number(MaxSEQNO[0].Column1) || 0;
                }

                var nextSEQ = 1;

                if ((Fequency === "STAT" || Fequency === "SOS") &&
                    typeCode === "SM") {

                    if (backendMax > 0) {
                        nextSEQ = backendMax + 1;

                    } else {
                        var smCount = 0;

                        $.each(TrmtntOrderMedicationTbl.getData(), function(index, item) {

                            if (index + 1 === rowId) {
                                return;
                            }

                            if (item.TypeCode === "SM" &&
                                item.SQNumber != null &&
                                item.SQNumber !== "") {

                                smCount++;
                            }
                        });

                        nextSEQ = smCount + 1;
                    }

                }
                else if (typeCode === "MD") {

                    // ONLY MD fallback logic
                    if (backendMax > 0) {
                        nextSEQ = backendMax + 1;
                    } else {

                        var mdMax = 0;

                        $.each(TrmtntOrderMedicationTbl.getData(), function(index, item) {

                            if (index + 1 === rowId) {
                                return;
                            }

                            if (item.TypeCode === "MD" &&
                                item.SQNumber != null &&
                                item.SQNumber !== "") {

                                var currentSEQ = Number(item.SQNumber) || 0;

                                if (currentSEQ > mdMax) {
                                    mdMax = currentSEQ;
                                }
                            }
                        });

                        nextSEQ = mdMax + 1;
                    }

                }
                else {
                    nextSEQ = backendMax + 1;
                }
                TrmtntOrderMedicationTbl.updateRow(rowId, {
                    SQNumber: nextSEQ,
                    TypeCode: typeCode
                });

                UpdateMaxSEQNOArray(typeCode, nextSEQ);
                // if (data.length > 0) {
                //     for (var c = 0; c <= data.length - 1; c++) {
                //         if (data[c]["OMIT"] == "N" && data[c]["ADMINYN"] == "N" && data[c]["NOTIFYN"] == "N") {
                //             var rowEl = TrmtntOrderMedicationTbl.getRow(c + 1).getElement();
                //             var check = rowEl.querySelector("input[type=checkbox]");
                //             if (check) check.disabled = true;
                //         } else if (data[c]["OMIT"] == "Y") {
                //             TrmtntOrderMedicationTbl.updateRow(rowId, { OMIT: "N" });
                //             var rowEl = TrmtntOrderMedicationTbl.getRow(c + 1).getElement();
                //             var check = rowEl.querySelector("input[type=checkbox]");
                //             if (check) check.disabled = true;
                //         }
                //     }
                // }
                var rows = TrmtntOrderMedicationTbl.getRows();

                if (data.length > 0) {
                    for (var c = 0; c < data.length; c++) {
                        var rowEl = rows[c].getElement();
                        var check = rowEl.querySelector("input[type=checkbox]");

                        if (data[c]["OMIT"] == "N" &&
                            data[c]["ADMINYN"] == "N" &&
                            data[c]["NOTIFYN"] == "N") {
                            if (check) check.disabled = true;
                        } else if (data[c]["OMIT"] == "Y") {
                            TrmtntOrderMedicationTbl.updateRow(c + 1, { OMIT: "N" });
                            if (check) check.disabled = true;
                        }
                    }
                }
            }
        });
        MedicationColorIndications();
    }
    function UpdateMaxSEQNOArray(tblType, SEQNO) {
        if (MaxSEQ.hasOwnProperty("Table")) {
            $.map(MaxSEQ.Table, function (element, Index) {
                if (element.TBLTYPE == tblType) {
                    element.Column1 = SEQNO;
                }
            })
        }
    }

    function GetTimewithAMPM() {
        var today = new Date();
        var hours = today.getHours();
        var minutes = today.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        hours = hours < 10 ? '0' + hours : hours;
        minutes = minutes < 10 ? '0' + minutes : minutes;
        var strTime = hours + ':' + minutes + ' ' + ampm;
        return strTime;
    }

    function GetTodaysDate() {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1;
        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        var today = dd + '/' + mm + '/' + yyyy;
        return today;
    }
    // function SetStartDateColumn(GridName, rowId) {
    //    TrmtntOrderMedicineTable.updateRow(rowId, { AntiBoDGSTARTDATE: GetTodaysDate() });
//}
function SetStartDateColumn(GridName, rowId) {
    const table = TrmtntOrderMedicineTable;
    const startDate = GetTodaysDate();

    table.updateRow(rowId, {
        AntiBoDGSTARTDATE: startDate,
        ENDDATE: calculateEndDate(startDate, 1)
    });
}
function SetStartDateMColumn(GridName, rowId) {
    const table = TrmtntOrderMedicationTable;
    const startDate = GetTodaysDate();

    table.updateRow(rowId, {
        MediDGSTARTDATE: startDate,
        ENDDATE: calculateEndDate(startDate, 1)
    });
}
    
    function GetTypeCode(selectorgrid) {
        var TypeValue = '';

        if (selectorgrid === "TrmtntOrderMedicineTable") {
            TypeValue = "AB";
        } else if (selectorgrid === "TrmtntOrderMedicationTable") {
            TypeValue = "MD";
        }

        return TypeValue;
    }

    function AddDelButtonByNew(grid, rowId) {
        var $grid = $(grid);
        var iCol = getColumnIndexByName($grid, "action");
        var $row = $grid.find("tr#" + rowId);
        var $td = $row.find("td:nth-child(" + (iCol + 1) + ")");

        $td.find(".ui-inline-custom").remove();

        $("<div>", {
            title: "Delete",
            click: function (e) {
                var ids = $grid.jqGrid("getDataIDs");
                ids.forEach(function (id) {
                    $grid.jqGrid("editCell", 0, 0, false);
                });

                var l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                var rowData = $grid.jqGrid("getRowData", l_orowId);
                var setNo = rowData.SetNo;

                if (setNo && setNo !== "0") {
                    ids.forEach(function (id) {
                        var rData = $grid.jqGrid("getRowData", id);
                        if (rData.SetNo === setNo) {
                            $grid.delRowData(id);
                        }
                    });
                } else {
                    $grid.delRowData(l_orowId);
                }

                MedicinColorIndications();
            }
        })
            .css({ "margin-right": "5px", float: "left", cursor: "pointer" })
            .addClass("ui-pg-div ui-inline-custom")
            .append('<span class="ui-icon ui-icon-trash"></span>')
            .appendTo($td.children("div"));
    }

    function MedicinColorIndications() {
        var Antibioticsdata = TrmtntOrderMedicineTable.getData().map(row => row.DrugCode);
        ArryMtrlCode = [];
        if (Antibioticsdata.length > 0) {
            for (var m = 0; m <= Antibioticsdata.length - 1; m++) {
                ArryMtrlCode.push(Antibioticsdata[m]);
            }
        }
        //if (gCIMSYN == "Y")
        //    GetMaterialInteraction(ArryMtrlCode);
    }
    function MedicationColorIndications() {
        var Mrdicationdata = TrmtntOrderMedicationTable.getData().map(row => row.DrugCode);
        ArryMtrlCode = [];
        if (Mrdicationdata.length > 0) {
            for (var m = 0; m <= Mrdicationdata.length - 1; m++) {
                ArryMtrlCode.push(Mrdicationdata[m]);
            }
        }
        //if (gCIMSYN == "Y")
        //    GetMaterialInteraction(ArryMtrlCode);
    }
</script>


<%-- Infusion Script --%>
<script type="text/javascript">
    var InfusionTable = null;
    var globalInfusionData = [];
    var MandStyle = '';
    var gact = '';
    var MaxSEQ = '';
    var UserId = '<%: Session["gOncoUserId"] ?? "" %>';
    var DoctorCode = '<%:Session["IPPatAdmnDoctCode"]%>';
    var PatName = $("#txtstrPatName").val(sessionStorage.getItem('IPPatName'));
    var currentEditingCell = null;

    $(document).ready(function () {
        load_InfusionData();
        initInfusionTable();
        InfusionTable.on("tableBuilt", function () {
            GetTreatmentSheetData($("#tractiondropdown").val(), "", sessionStorage.getItem('IPPatIPNO'));
        });
        $("#ProtocolInfoSection").hide();
        $("#chemoPlanNo").hide();
        $("#chemoPlanDt").hide();
    });


    function load_InfusionData() {
        $.ajax({
            url: '../SinglePage/GetInfusionData',
            data: {},
            type: 'get',
            async: false,
            success: function (data) {
                if (data) {
                    globalInfusionData = Array.isArray(data) ? data : [];
                    console.log('Loaded infusion data:', globalInfusionData.length);
                }
            },
            error: function () {
                console.error('Failed to load infusion data');
                globalInfusionData = [];
            }
        });
    }

    function GetDBMaxSEQNO() {
        var strIpNo = sessionStorage.getItem('IPPatIPNO');
        var dataContainer = { IPNO: strIpNo };

        $.ajax({
            url: '../SinglePage/GetMaxSEQNO',
            data: dataContainer,
            type: 'get',
            async: false,
            success: function (Response) {
                if (Response && Response != "UNSUCESSFULL") {
                    MaxSEQ = JSON.parse(Response);
                }
            }
        });
    }

    function GetTimewithAMPM() {
        var today = new Date();
        var hours = today.getHours();
        var minutes = today.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        hours = hours < 10 ? '0' + hours : hours;
        minutes = minutes < 10 ? '0' + minutes : minutes;
        return hours + ':' + minutes + ' ' + ampm;
    }

    function GetMaxSEQNO(GridName) {
        if (MaxSEQ && MaxSEQ.Table) {
            var typeCode = GetTypeCode(GridName);
            return MaxSEQ.Table.filter(function (item) {
                return item.TBLTYPE === typeCode;
            });
        }
        return [];
    }
    function GetMaxSEQNOByType(typeCode) {
        if (MaxSEQ && MaxSEQ.Table) {
            return MaxSEQ.Table.filter(function (item) {
                return item.TBLTYPE === typeCode;
            });
        }

        return [];
    }
    function GetTypeCode(gridName) {
        var typeMap = {
            'MedicineTable': 'MD',
            'DietTable': 'DL',
            'IVFluidTable': 'IV',
            'SkinObservationTable': 'SO',
            'InfusionTable': 'IN',
            'InvstgListtable': 'IG',
            'DoctorCareTable': 'DC',
            'AirwayBreathingTable': 'AB',
            'SuctionManagementTable': 'SM',
            'BloodProductTable': 'BP',
            'GraphicOutputTable': 'CO',
            'ConsentMasterTable': 'CM'
        };

        if (typeof gridName === 'string') {
            var cleanName = gridName.replace('#', '').replace('.', '');
            return typeMap[cleanName] || 'MD';
        }
        return 'MD';
    }

    function GetTodaysDate() {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1;
        var yyyy = today.getFullYear();

        if (dd < 10) dd = '0' + dd;
        if (mm < 10) mm = '0' + mm;

        return dd + '/' + mm + '/' + yyyy;
    }

    function AddDataToMaxArray(TblType, SEQNO) {
        if (!MaxSEQ) MaxSEQ = { Table: [] };
        if (!MaxSEQ.Table) MaxSEQ.Table = [];

        MaxSEQ.Table.push({ "TBLTYPE": TblType, "Column1": SEQNO });
    }

    function UpdateMaxSEQNOArray(tblType, SEQNO) {
        if (MaxSEQ && MaxSEQ.Table) {
            for (var i = 0; i < MaxSEQ.Table.length; i++) {
                if (MaxSEQ.Table[i].TBLTYPE === tblType) {
                    MaxSEQ.Table[i].Column1 = SEQNO;
                    break;
                }
            }
        }
    }
    function initInfusionTable() {

        if (InfusionTable) {
            InfusionTable.destroy();
        }

        var container = document.getElementById("InfusionTable");
        if (!container) {
            console.error('InfusionTable container not found');
            return;
        }

        container.innerHTML = '';

        InfusionTable = new Tabulator("#InfusionTable", {
            layout: "fitColumns",
            autoResize: false,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                // Action column
                {
                    title: "<i class='fa fa-plus text-success' style='color: yellow!important;cursor:pointer;' title='Add New Row'></i>",
                    field: "action",
                    width: 70,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    frozen: false,
                    headerClick: function (e, column) {
                        addInfusionRow();
                    },
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if ((data.STATUS === "C" || data.IsRollOver === "Y") || (data.OMIT === "Y" && !data.isSavedOmit)) {
                            return "";
                        }

                        var html = '';
                        if (!data.isFromServer) {
                            html += '<i class="fa fa-trash text-danger" style="cursor:pointer; margin-right: 5px;" title="Delete"></i>';
                        }


                        if (data.isFromServer && data.ADMINYN !== "Y") {
                            html += '<i class="fa fa-ban text-warning" style="cursor:pointer;" title="Cancel"></i>';
                        }

                        return html;
                    },
                    cellClick: function (e, cell) {
                        e.stopPropagation();
                        var target = e.target;
                        var row = cell.getRow();
                        var data = row.getData();

                        if (target.classList.contains('fa-trash')) {
                            if (!data.isFromServer) {
                                InfusionTable.deleteRow(row);
                            }
                        }
                        else if (target.classList.contains('fa-ban')) {

                            if (data.isFromServer && data.STATUS !== "C") {
                                handleCancelRow(row);
                            }
                        }
                    }
                },

                {
                    title: "Intravenous Infusions",
                    field: "Infusion",
                    width: 280,
                    headerHozAlign: "center",
                    editor: "input",
                    formatter: function (cell) {
                        const rowData = cell.getRow().getData();

                        if (rowData.IsRollOver === "Y") {
                            cell.getElement().classList.add("rollover-cell");
                        } else {
                            cell.getElement().classList.remove("rollover-cell");
                        }

                        return cell.getValue();
                    },
                    editable: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer;
                    },
                    cellEdited: function (cell) {
                        var value = cell.getValue();
                        var row = cell.getRow();
                        var data = row.getData();

                        if (!value || value.trim() === "") {
                            // Clear related fields if infusion is empty
                            data.Dose = "";
                            data.InfusionRate = "";
                            data.HighAlert = false;
                            data.OrderedBy = "";
                            data.OrderedDate = "";
                            data.OrderedTime = "";
                            data.SQNumber = "";
                            row.update(data);
                        }
                        adjustTableHeight("InfusionTable");
                    },
                    cellClick: function (e, cell) {
                        initAutocompleteForCell(cell);
                    }
                },
                 {
                    title: "Dose / Dilution",
                    field: "Dose",
                    width: 221,
                    headerHozAlign: "center",
                    editor: "input",
                    editorParams: { maxLength: 100 },
                    //editor: function (cell) {
                    //    var data = cell.getRow().getData();
                    //    return !data.isFromServer ? "input" : false;
                    //},
                    cellEdited: function (cell) {
                        var value = cell.getValue();
                        if (value) {
                            cell.setValue(value.toUpperCase());
                        }

                        var data = cell.getRow().getData();
                        if (data.INFCODE && data.INFCODE !== "") {
                            ToastMsg("Are you sure want to modify Dose", "info");
                        }
                    }
                },
                {
                    title: "<span style='color:red'>Infusion Rate</span>",
                    field: "InfusionRate",
                    width: 145,
                    headerHozAlign: "center",
                    editor: "input",
                    editorParams: { maxLength: 100 },
                    cellEdited: function (cell) {
                        var value = cell.getValue();
                        if (value) {
                            cell.setValue(value.toUpperCase());
                        }
                    }
                },
                {
                    title: "High Alert",
                    field: "HighAlert",
                    width: 195,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function (cell, formatterParams) {
                        var data = cell.getRow().getData();
                        var checked = data.HighAlert ? "checked" : "";
                        //var disabled = (data.isFromServer) ? "disabled" : "";
                        return `<input type="checkbox" ${checked} />`;
                    },
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var data = row.getData();

                       // if (data.isFromServer) return;      //commented on 20260813

                        var checkbox = e.target;
                        var newValue;

                        if (checkbox.tagName === "INPUT") {
                            newValue = checkbox.checked;
                        } else {
                            newValue = !cell.getValue();
                        }

                        cell.setValue(newValue);
                        updateRowStyling(row);
                    }
                },
                {
                    title: "StartTime",
                    field: "StartTime",
                    width: 100,
                    headerSort: false,
                    hozAlign: "left",
                    visible: false,
                    editable: true

                },
                {
                    title: "EndTime",
                    field: "EndTime",
                    width: 100,
                    headerSort: false,
                    hozAlign: "left",
                    visible: false,
                    editable: true

                },

                {
                    title: "Ordered By",
                    field: "OrderedBy",
                    width: 100,
                    headerHozAlign: "center",
                    visible: false,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },

                {
                    title: "Ordered By",
                    field: "OrderedByName",
                    width: 100,
                    headerHozAlign: "center",
                    visible: false,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },
                {
                    title: "Ordered Date",
                    field: "OrderedDate",
                    width: 100,
                    headerHozAlign: "center",
                    visible: false,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },
                {
                    title: "Ordered Time",
                    field: "OrderedTime",
                    width: 100,
                    headerHozAlign: "center",
                    visible: false,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },

                {
                    title: "Sequence No",
                    field: "SQNumber",
                    width: 100,
                    headerHozAlign: "center",
                    visible: false,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },

                {
                    title: "Remark",
                    field: "Remark",
                    width:300,
                    headerHozAlign: "center",
                    editor: "textarea",
                    editable: true, /* cell => cell.getRow().getData().OMIT !== "Y" */
                    cssClass: "TabTextArea",
                    cellEdited: cell => {
                        if (cell.getValue())
                            cell.setValue(cell.getValue().toUpperCase(), true);

                        //adjustTableHeight("InfusionTable");
                    }
                },

               {
                   title: "OMIT",
                   field: "OMIT",
                   width: 60,
                   hozAlign: "center",
                   headerHozAlign: "center",
                   // formatter: function (cell) {
                   //     var data = cell.getRow().getData();
                   //     var checked = data.OMIT === "Y" ? "checked" : "";
                   //     // var disabled = data.isFromServer ? "disabled" : "";
                   //     return `<input type="checkbox" ${checked} />`;
                   // },
                   formatter: function(cell) {
                       let value = cell.getValue();
                       let isChecked = (value === true || value === "Y");

                       let input = document.createElement("input");
                       input.type = "checkbox";
                       input.checked = isChecked;

                       input.addEventListener("click", function(e) {
                           e.stopPropagation();
                       });
                       input.addEventListener("change", function() {
                           cell.setValue(this.checked ? "Y" : "N");
                           var row = cell.getRow();
                           handleOmitChange(row, this.checked);
                           row.update({
                               OMIT: this.checked ? "Y" : "N",
                               isSavedOmit: false
                           });
                       });
                       return input;
                   },
                  cellClick: function (e, cell) {
                      var row = cell.getRow();
                      var data = row.getData();
                      let field = cell.getColumn().getField();
                      // if (data.isFromServer) return;

                      // var isChecked;
                      // if (e.target.tagName === "INPUT") {
                      //     isChecked = e.target.checked;
                      // } else {
                      //     isChecked = data.OMIT !== "Y";
                      // }

                      // var newValue = isChecked ? "Y" : "N";

                      // cell.setValue(newValue);
                    //  handleOmitChange(row, newValue === "Y");

                      if (data.ADMINYN == "Y") {
                          if (field != "action" && field != "OMIT") {
                              e.stopPropagation();
                              return false;
                          }
                      }
                  }

              },
                {
                    title: "Omitted By",
                    field: "OmittedBy",
                    width: 110,
                    headerHozAlign: "center",
                    visible: false,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },
                //{
                //    title: "Omitted By",
                //    field: "OmittedByName",
                //    width: 110,
                //    headerHozAlign: "center",
                //    visible: true,
                //    editor: function (cell) {
                //        var data = cell.getRow().getData();
                //        return !data.isFromServer ? "input" : false;
                //    }
                //},
                //Abhihsesh || 20260714
                {
                    title: "Omitted By",
                    field: "OmittedByName",
                    width: 110,
                    headerHozAlign: "center",
                    visible: true,
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        var name = data.OmittedByName || "";
                        var userId = data.OmittedBy || "";
                        return userId ? name + " (" + userId + ")" : name;
                    },
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },
                //End
                {
                    title: "Omitted Date",
                    field: "OmittedDate",
                    width: 110,
                    headerHozAlign: "center",
                    visible: true,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },
                {
                    title: "Omitted Time",
                    field: "OmittedTime",
                    width: 110,
                    headerHozAlign: "center",
                    visible: true,
                    editor: function (cell) {
                        var data = cell.getRow().getData();
                        return !data.isFromServer ? "input" : false;
                    }
                },
                {
                    title: "INFCODE",
                    field: "INFCODE",
                    visible: false
                },
                {
                    title: "IsRollOver",
                    field: "IsRollOver",
                    visible: false
                },
                {
                    title: "ADMINYN",
                    field: "ADMINYN",
                    visible: false
                },
                {
                    title: "STATUS",
                    field: "STATUS",
                    visible: false
                },
                {
                    title: "NOTIFYN",
                    field: "NOTIFYN",
                    visible: false
                },
                {
                    title: "TypeCode",
                    field: "TypeCode",
                    visible: false
                }
            ],
            // Inside your Tabulator constructor...
            rowFormatter: function (row) {
                var data = row.getData();
                var element = row.getElement();
                element.style.backgroundColor = "";
                element.style.color = "";
                element.style.textDecoration = "";
                element.style.pointerEvents = "auto";

                if (data.STATUS === "C") {
                    element.style.backgroundColor = "#f8d7da";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "none";
                    return;
                }

                if (data.OMIT === "Y") {
                    element.style.backgroundColor = "#d4edda";
                    element.style.textDecoration = "line-through";

                }

                if (data.HighAlert == "Y" || data.HighAlert === true) {
                    element.style.color = "#db0000";
                }
                let actionCell = row.getCell("action").getElement();
                if (data.ADMINYN == "Y") {
                    actionCell.style.background = "linear-gradient(to left, #ebd0b75e, #ffc837)";
                    row.getElement().classList.add("avoid-clicks");
                }
                else {
                    actionCell.style.background = "";
                    row.getElement().classList.remove("avoid-clicks");
                }
                if (data.IsRollOver == "Y") {

                    row.getCells().forEach(function(cell) {

                        let field = cell.getColumn().getField();

                        if (!["OMIT"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });

                }
                if (data.isSavedOmit === false) {
                    row.getCells().forEach(function (cell) {

                        let field = cell.getColumn().getField();

                        if (!["action", "OMIT", "HighAlert", "Infusion", "InfusionRate", "Dose","Remark"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });
                }
                else if (data.isSavedOmit === true) {
                    row.getCells().forEach(function(cell) {
                            cell.getElement().classList.add("disable-cell");

                    });
                }
            }

        });
        //priyanka 02/04/2026


        //addInitialRow();
    }

    function BindInfusionData(jsonInfusionData) {
        if (InfusionTable) {
            const mappedData = mapInfusionData(jsonInfusionData);
            InfusionTable.setData(mappedData);
        }
    }
    function mapInfusionData(dataArray) {
        if (!dataArray) return [];
        return dataArray.map(item => {
            var currentStatus = item.STATUS || "A";
            console.log(`Mapping Row ${item.SEQNO}: Status is ${item.STATUS}`);
            return {
                action: item.action || "",
                Infusion: item.Infusion || "",
                Dose: item.Dose || "",
                Remark: item.Remark || "",
                InfusionRate: item.InfusionRate || "",
                HighAlert: item.HighAlert || "",
                STATUS: currentStatus,
                TypeCode: item.TypeCode || "",
                OrderedBy: item.ORDERBY || item.OrderedBy || "",
                OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
                OrderedDate: item.ORDDATE || item.OrderedDate || "",
                OrderedTime: item.ORDTIME || item.OrderedTime || "",
                SQNumber: item.SQNumber || item.SEQNO || "",
                NOTIFYN: item.NOTIFYN || "",
                ADMINYN: item.ADMINYN || "",
                INFCODE: item.INFCODE || "",
                EndTime: item.EndTime || "",
                StartTime: item.StartTime || "",
                isFromServer: true,
                // Omit Logic
                OmittedBy: item.OMITBY || item.OmittedBy || "",
                OmittedByName: item.OMITBYNAME || item.OmittedByName || "",
                OmittedDate: item.OMITDT || item.OmittedDate || "",
                OmittedTime: item.OMITTM || item.OmittedTime || "",
                OMIT: (item.OMIT === "Y") ? "Y" : "N",
                IsRollOver: item.IsRollOver || "",
                isSavedOmit: item.OMIT === "Y" ? true : false


            };
        });
    }

    function addInitialRow() {
        if (!InfusionTable) return;

        var initialData = {
            Infusion: "",
            Dose: "",
            InfusionRate: "",
            HighAlert: "",
            StartTime: "",
            EndTime: "",
            OrderedBy: "",
            OrderedDate: "",
            OrderedTime: "",
            SQNumber: "",
            INFCODE: "",
            OMIT: "N",
            OmittedBy: "",
            OmittedByName: "",
            OmittedDate: "",
            OmittedTime: "",
            ADMINYN: "N",
            TypeCode: "IN",
            NOTIFYN: "N",
            STATUS: "A",
            IsRollOver: "N"
        };

        InfusionTable.addRow(initialData);
    }

    function addInfusionRow() {
        if (!InfusionTable) return;
        var rows = InfusionTable.getData();
        if (rows.length > 0) {
            var firstRow = rows[0];
            if ((!firstRow.Infusion || firstRow.Infusion.trim() === "") && firstRow.STATUS !=="C") {
                ToastMsg("Please fill the first row before adding a new row.", "info");
                return;
            }
        }

        var newRow = {
            Infusion: "",
            Dose: "",
            InfusionRate: "",
            HighAlert: "",
            StartTime: "",
            EndTime: "",
            OrderedBy: "",
            OrderedDate: "",
            OrderedTime: "",
            SQNumber: "",
            INFCODE: "",
            OMIT: "N",
            OmittedBy: "",
            OmittedByName: "",
            OmittedDate: "",
            OmittedTime: "",
            ADMINYN: "N",
            TypeCode: "IN",
            NOTIFYN: "N",
            STATUS: "A",
            IsRollOver: "N"
        };

        InfusionTable.addRow(newRow);
    }

    function handleOmitChange(row, isOmitted) {
        var data = row.getData();

        data.OMIT = isOmitted ? "Y" : "N";

        if (isOmitted) {
            data.OmittedBy = UserId || "";
            data.OmittedByName = gDoctName || "";
            data.OmittedDate = GetTodaysDate();
            data.OmittedTime = GetTimewithAMPM();
        } else {
            data.OmittedBy = "";
            data.OmittedByName = "";
            data.OmittedDate = "";
            data.OmittedTime = "";
        }

        row.update(data);
        row.reformat();
    }

    function initAutocompleteForCell(cell) {
        if (!cell || !cell.getElement) return;

        var input = cell.getElement().querySelector('input');
        if (!input) {

            cell.edit();
            setTimeout(function () {
                var editInput = cell.getElement().querySelector('input');
                if (editInput) {
                    setupAutocomplete(editInput, cell);
                }
            }, 100);
        } else {
            setupAutocomplete(input, cell);
        }
    }

    function setupAutocomplete(inputElement, cell) {
        if (!inputElement || inputElement.hasAttribute('data-autocomplete-setup')) {
            return;
        }

        $(inputElement).autocomplete({
            source: function (request, response) {
                var term = request.term.toLowerCase();
                var filtered = $.map(globalInfusionData, function (item) {
                    if (item.Text && item.Text.toLowerCase().indexOf(term) >= 0) {
                        return {
                            label: item.Text,
                            value: item.Text,
                            Code: item.Value,
                            Dose: item.Dose || "",
                            InfusionRate: item.InfusionRate || "",
                            HighAlert: item.HighAlert || "N"
                        };
                    }
                    return null;
                }).filter(function (item) { return item !== null; });

                response(filtered);
            },
            minLength: 1,
            select: function (event, ui) {
                event.preventDefault();

                var row = cell.getRow();
                var data = row.getData();
                setTimeout(function () {
                    data.Infusion = ui.item.value;
                    data.Dose = ui.item.Dose || "";
                    data.InfusionRate = ui.item.InfusionRate || "";
                    data.INFCODE = ui.item.Code || "";

                    if (data.Infusion && data.Infusion.trim() !== "") {

                        data.OrderedBy = UserId || "";
                        data.OrderedDate = GetTodaysDate();
                        data.OrderedTime = GetTimewithAMPM();
                        data.NOTIFYN = 'N';

                        var maxSeq = GetMaxSEQNO('InfusionTable');
                        var lastSeq = 0;

                        if (maxSeq && maxSeq.length > 0 && maxSeq[0].Column1 != null) {
                            lastSeq = parseInt(maxSeq[0].Column1, 10);
                        }
                        else {
                            GetDBMaxSEQNO();
                            maxSeq = GetMaxSEQNO('InfusionTable');

                            if (maxSeq && maxSeq.length > 0 && maxSeq[0].Column1 != null) {
                                lastSeq = parseInt(maxSeq[0].Column1, 10);
                            }
                        }
                        if (isNaN(lastSeq)) {
                            var allRows = InfusionTable.getData();
                            lastSeq = allRows.filter(r => r.Infusion && r.Infusion.trim() !== "").length;
                        }

                        var nextSeq = lastSeq + 1;

                        data.SQNumber = nextSeq.toString();
                        UpdateMaxSEQNOArray('IN', nextSeq);
                    }

                    if (ui.item.HighAlert === "Y") {
                        data.HighAlert = "Y";

                        custom_alertInfusion("Is this high alert Infusion?", 'Confirmation', row.getIndex());
                        $("#customAlertDialog").dialog('close');               //changes on 20260801
                    } else {
                        data.HighAlert = "N";
                    }

                    row.update(data);
                    cell.navigateRight();

                }, 100);
            },
            focus: function (event, ui) {
                event.preventDefault();
                $(this).val(ui.item.label);
                return false;
            }
        }).attr('data-autocomplete-setup', 'true');

        $(inputElement).css('width', '280px');

        setTimeout(function () {
            inputElement.focus();
        }, 50);
    }
    function custom_alertInfusion(output_msg, title_msg, rowIndex) {
        if (!title_msg) title_msg = 'Confirmation';
        if (!output_msg) output_msg = 'No Message to Display.';

        if (!$("#customAlertDialog").length) {
            $('body').append(`
                <div id="customAlertDialog" title="${title_msg}" style="display:none;">
                    <p id="lblCustomAlert">${output_msg}</p>
                </div>
            `);
        }

        $("#lblCustomAlert").text(output_msg);

        $("#customAlertDialog").dialog({
            modal: true,
            width: 400,
            buttons: {
                "Yes": function () {
                    $(this).dialog("close");
                    var row = InfusionTable.getRowFromPosition(rowIndex, true);
                    if (row) {
                        var data = row.getData();
                        data.HighAlert = true;
                        row.update(data);
                    }
                },
                "No": function () {
                    $(this).dialog("close");
                    var row = InfusionTable.getRowFromPosition(rowIndex, true);
                    if (row) {
                        var data = row.getData();
                        data.HighAlert = false;
                        row.update(data);
                    }
                }
            }
        });
    }
    function handleCancelRow(row) {
        var data = row.getData();
        var strTranNo = $("#tractiondropdown").val();

        if (confirm("Are you sure you want to cancel this record?")) {
            var isSuccess = CancelledRequest(strTranNo, data.SQNumber, data.TypeCode);

            if (isSuccess) {
                row.update({
                    STATUS: "C",
                    ADMINYN: "N",
                    OMIT: "N"
                }).then(function () {

                    row.reformat();
                    ToastMsg("Cancelled Successfully", "info");
                });
            } else {
                ToastMsg("Cancellation failed on server.", "error");
            }
        }
    }
    function updateRowStyling(row) {
        if (row && row.reformat) {
            row.reformat();
        }
    }

    function handleCancelRowForInest(row) {
        var data = row.getData();
        var strTranNo = $("#tractiondropdown").val();

        if (confirm("Are you sure you want to cancel this record?")) {
            var isSuccess = CancelledRequest(strTranNo, data.SQNumber, "TS");

            if (isSuccess) {
                row.update({
                    STATUS: "C",
                    //OMIT: "Y"
                }).then(function () {

                    row.reformat();
                    ToastMsg("Cancelled Successfully");
                });
            } else {
                ToastMsg("Cancellation failed on server.");
            }
        }
    }
    function GetInfusionTableData() {
        return InfusionTable ? InfusionTable.getData() : [];
    }

    function ClearInfusionTable() {
        if (InfusionTable) {
            InfusionTable.clearData();
            addInitialRow();
        }
    }
    function LoadInfusionData(data) {
        if (!InfusionTable) return;

        if (data && Array.isArray(data) && data.length > 0) {
            data = data.map(function (item, index) {
                item.isFromServer = true;
                return item;
            });
            InfusionTable.setData(data);
        } else {
            ClearInfusionTable();
        }
    }
</script>

<script type="text/javascript">
    var InvstgListtable;
    var CIMS = '<%= Session["CIMSYN"] %>';
    var DoctCode = '<%= Session["DOCTCODE"] %>';
    var CIMSYN = ""; /* @Html.Raw(Json.Encode(Model.CIMS));*/ <%-- '<%= Model.CIMS %>';--%>

    $(document).ready(function () {

        $("#txtstrUIPNo").val(sessionStorage.getItem('IPPatIPNO'));
        $("#txtstrUMRNO").val(sessionStorage.getItem('IPPatMRNO'));
        InvstgListtable = new Tabulator("#InvstgTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "Action",
                    field: "delete",
                    width: 80,
                    hozAlign: "center",
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if (data.STATUS === "C" || data.IsRollOver === "Y" || data.OMIT == "Y" || data.Pending == "0" || isInvstgRowLocked(data)) { // Abhishesh || 20261006
                            return "";
                        }

                        var html = '';
                        if (!data.isFromServer) {
                            html += '<i class="fa fa-trash text-danger" style="cursor:pointer; margin-right: 5px;" title="Delete"></i>';
                        }


                        if (data.isFromServer && data.ADMINYN !== "Y") {
                            html += '<i class="fa fa-ban text-warning" style="cursor:pointer;" title="Cancel"></i>';
                        }

                        return html;
                    },
                    cellClick: function (e, cell) {
                        e.stopPropagation();
                        var target = e.target;
                        var row = cell.getRow();
                        var data = row.getData();

                        if (target.classList.contains('fa-trash')) {
                            if (!data.isFromServer) {
                                InvstgListtable.deleteRow(row);
                            }
                        }
                        else if (target.classList.contains('fa-ban')) {

                            if (data.isFromServer && data.STATUS !== "C") {
                                handleCancelRowForInest(row);
                            }
                        }
                    }

                },

                { title: "Code", field: "TestCode", editor: false, width: 300, visible: false },
                {
                    title: "Test", field: "Test", editor: false, width: 300,
                    formatter: function (cell) {
                        const rowData = cell.getRow().getData();

                        if (rowData.IsRollOver === "Y") {
                            cell.getElement().classList.add("rollover-cell");
                        } else {
                            cell.getElement().classList.remove("rollover-cell");
                        }

                        return cell.getValue();
                    }
                },
                {
                    title: "Proposed Date",
                    field: "ProposedDate",
                    width: 140,
                    editable: false,  
                    editor: function (cell, onRendered, success, cancel) {
                        const input = document.createElement("input");
                        input.type = "date";
                        input.className = "form-control form-control-sm";

                        let val = cell.getValue();
                        let htmlDate = "";

                        if (val instanceof Date) {
                            htmlDate = val.toISOString().split('T')[0];
                        }
                        else if (typeof val === "string" && val.includes("/")) {
                            const parts = val.split("/");
                            htmlDate = `${parts[2]}-${parts[1]}-${parts[0]}`;
                        }

                        input.value = htmlDate;

                        onRendered(() => { input.focus(); });

                        input.addEventListener("change", () => {
                            if (!input.value) return success("");
                            const [y, m, d] = input.value.split("-");
                            success(`${d}/${m}/${y}`); // Return string format to table
                        });

                        input.addEventListener("blur", () => { success(cell.getValue()); });

                        return input;
                    }
                },
                {
                    title: "Proposed Time",
                    field: "ProposedTime",
                    width: 140,
                    editable: false, 
                    formatter: function (cell) {
                        return formatTimeTo12Hour(cell.getValue());
                    },
                    editor: function (cell, onRendered, success, cancel) {
                        const input = document.createElement("input");
                        input.type = "time";
                        input.className = "form-control form-control-sm";

                        let val = cell.getValue();
                        if (val) {
                            let [time, ampm] = val.split(" ");
                            let [hh, mm] = time.split(":").map(Number);
                            if (ampm === "PM" && hh < 12) hh += 12;
                            if (ampm === "AM" && hh === 12) hh = 0;
                            val = `${String(hh).padStart(2, "0")}:${String(mm).padStart(2, "0")}`;
                        }
                        input.value = val || "";

                        onRendered(() => { input.focus(); input.select(); });

                        input.addEventListener("change", () => {
                            success(formatTimeTo12Hour(input.value));
                        });

                        input.addEventListener("blur", () => {
                            success(formatTimeTo12Hour(input.value));
                        });
                        return input;
                    }
                },
                {
                    title: "Test Count",
                    field: "TestCount",
                    editable: isInvstgCellEditable, // Abhishesh || 20261006
                    editor: function (cell, onRendered, success, cancel) {
                        const input = document.createElement("input");
                        input.type = "number";
                        input.min = 1;
                        input.className = "form-control form-control-sm";
                        input.value = cell.getValue() || 1;
                        input.style.MozAppearance = "textfield";
                        input.style.WebkitAppearance = "none";
                        input.style.margin = 0;

                        onRendered(() => {
                            input.focus();
                            input.select();
                        });

                        const validateAndSuccess = () => {
                            let val = parseInt(input.value);
                            //Abhishesh || 20261006
                            const orderPlaced = parseInt(cell.getRow().getData().OrderPlaced) || 0;
                            if (!val || val <= 0) {
                                if (orderPlaced > 0) {
                                    val = 0; 
                                } else {
                                ToastMsg("Test Count should not be empty or less than 1", "Information");
                                input.value = 1;
                                val = 1;
                            }
                            }
                            // Test Count must always be greater than Order Placed
                            if (orderPlaced > 0 && val <= orderPlaced) {
                                ToastMsg("Test Count must be greater than Order Placed (" + orderPlaced + ")", "Information");
                                var prev = parseInt(cell.getValue());
                                val = (prev > orderPlaced) ? prev : orderPlaced + 1;
                                input.value = val;
                            }
                            success(val);
                            cell.getRow().update({ Pending: val - orderPlaced });
                        };
                        //End

                        input.addEventListener("change", validateAndSuccess);
                        input.addEventListener("blur", validateAndSuccess);

                        return input;
                    },
                    formatter: "plaintext",
                    width: 120,
                    cellEdited: function (cell) {
                        const row = cell.getRow();
                        const rowData = row.getData();
                        const val = cell.getValue();
                        if (val) {
                            cell.setValue(val.toString().toUpperCase(), true);
                        }


                        if (!val) {
                            row.update({
                                OrderedBy: null,
                                OrderedDate: null,
                                OrderedTime: null,

                            });
                            return;
                        }
                        row.update({
                            OrderedBy: UserId,
                            OrderedDate: GetTodaysDate(),
                            OrderedTime: GetTimewithAMPM(),
                            NOTIFYN: "N"
                        });

                        // if (!rowData.SQNumber || rowData.SQNumber === "") {
                        //     const typeCode = GetTypeCode("InvstgTable");
                        //     const maxSeqArr = GetMaxSEQNO("InvstgTable");

                        //     if (maxSeqArr.length > 0) {
                        //         const nextSeq = Number(maxSeqArr[0].Column1) + 1;
                        //         row.update({ SQNumber: nextSeq });
                        //         UpdateMaxSEQNOArray(typeCode, nextSeq);
                        //     } else {
                        //         const validRows = InvstgListtable.getData().filter(r => r.Test && r.Test !== "");
                        //         const seq = validRows.length;
                        //         row.update({ SQNumber: seq });
                        //         AddDataToMaxArray(typeCode, seq);
                        //     }
                        // }
                    }
                },

                { title: "Pending", field: "Pending", editor: false, width: 120 },
                { title: "Order Placed", field: "OrderPlaced", editor: false, width: 120 },
                lockInvstgColumn(getRemarkColumn("InvstgTable")), // Abhishesh || 20261006
                { title: "TypeCode", field: "TypeCode", editor: false, width: 120, visible: false },
                { title: "SQNumber", field: "SQNumber", editor: false, width: 120, visible: false },
                { title: "STATUS", field: "STATUS", editor: false, width: 120, visible: false },
                { title: "ADMINYN", field: "ADMINYN", editor: false, width: 120, visible: false },
                { title: "Last Order No", field: "ORDERNO", editor: false, width: 100 },
                { title: "Order by", field: "OrderedBy", editor: false, width: 100, visible: false },
                //{ title: "Order by", field: "OrderedByName", editor: false, width: 100 },
                //Abhishesh || 20260714
                {
                    title: "Order by",
                    field: "OrderedByName",
                    editor: false,
                    width: 100,
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        var name = data.OrderedByName || "";
                        var userId = data.OrderedBy || "";
                        return userId ? name + " (" + userId + ")" : name;
                    }
                },
                //End
                { title: "OrderTime", field: "OrderTime", editor: false, width: 120, visible: false },
                { title: "OrderDate", field: "OrderDate", editor: false, width: 120, visible: false },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 60,
                    hozAlign: "center",
                    headerHozAlign: "center",

                    formatter: function(cell) {
                        let value = cell.getValue();
                        let isChecked = (value === true || value === "Y");

                        // Get current row data
                        let rowData = cell.getRow().getData();

                        // Checkbox editable condition
                        let isEditable =
                            (parseInt(rowData.OrderPlaced) > 0) &&
                            (parseInt(rowData.Pending) > 0);

                        let input = document.createElement("input");
                        input.type = "checkbox";
                        input.checked = isChecked;

                        // Disable checkbox if condition is false
                        input.disabled = !isEditable;

                        input.addEventListener("click", function(e) {
                            e.stopPropagation();
                        });

                        input.addEventListener("change", function() {
                            if (!isEditable) {
                                return;
                            }

                            cell.setValue(this.checked ? "Y" : "N");

                            var row = cell.getRow();

                            handleOmitChange(row, this.checked);

                            row.update({
                                OMIT: this.checked ? "Y" : "N",
                                isSavedOmit: false
                            });
                        });

                        return input;
                    },

                    cellClick: function(e, cell) {
                        var row = cell.getRow();
                        var data = row.getData();

                        if (data.isFromServer || !(data.ORDERNO && data.ORDERNO.trim() !== "")) {
                            return;
                        }
                    }
                },
                { title: "OmittedBy", field: "OmittedBy", editor: false, width: 120, visible: false },
                { title: "OmittedByName", field: "OmittedByName", editor: false, width: 120, visible: false },
                { title: "OmittedDate", field: "OmittedDate", editor: false, width: 120, visible: false },
                { title: "OmittedTime", field: "OmittedTime", editor: false, width: 120, visible: false },
                { title: "NotifYN", field: "NotifYN", editor: false, width: 120, visible: false },
                { title: "IsRollOver", field: "IsRollOver", editor: false, width: 120, visible: false },
                { title: "CancelBY", field: "CancelBY", editor: false, width: 120, visible: false },
                { title: "CancelTM", field: "CancelTM", editor: false, width: 120, visible: false },
                { title: "CancelDT", field: "CancelDT", editor: false, width: 120, visible: false },
                { title: "LastOrderTM", field: "LastOrderTM", editor: false, width: 120, visible: false },
                { title: "LastOrderDT", field: "LastOrderDT", editor: false, width: 120, visible: false },
                {
                    title: "Select",
                    field: "select",
                    width: 20,
                    visible: false,
                    hozAlign: "center",
                    formatter: function (cell, formatterParams) {
                        return `<input type="checkbox" ${cell.getValue() === "Y" ? "checked" : ""}>`;
                    },
                    cellClick: function (e, cell) {
                        let current = cell.getValue();
                        cell.setValue(current === "Y" ? "N" : "Y");
                    }
                }

            ],
            rowFormatter: function (row) {
                var data = row.getData();
                var element = row.getElement();
                element.style.backgroundColor = "";
                element.style.color = "";
                element.style.textDecoration = "";
                element.style.pointerEvents = "auto";


                if (data.STATUS === "C") {
                    element.style.backgroundColor = "#f8d7da";
                    //element.style.color = "#721c24";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "none";
                }
                 if (data.HighAlert == "Y") {
                    element.style.color = "#db0000";
                }

                if (data.OMIT === "Y") {
                    element.style.backgroundColor = "#d4edda";

                }
                if (data.isSavedOmit === false) {
                    row.getCells().forEach(function(cell) {
                        cell.getElement().classList.remove("disable-cell");
                    });
                }
                else if (data.isSavedOmit === true) {
                    row.getCells().forEach(function(cell) {
                        cell.getElement().classList.add("disable-cell");
                    });
                }
                // Treatment Order: Pending = 0 (or Test Count <= Order Placed) => whole row locked
                applyInvstgRowLock(row); // Abhishesh || 20261006
            }


        });

        $(document).on("click", ".Invstg-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = InvstgListtable.getData();
            var MsgForConfrm = "";
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].TestCode === code) {
                    if (rows[i].Pending != "0" && rows[i].STATUS !="C" && rows[i].OMIT !="Y") {
                        ToastMsg("Cannot add this test because the same test is already present and pending!", "warning");
                        $("#InvstgListMainDiv").hide();
                        return;
                    }
                    else {
                        MsgForConfrm = "This investigation has already been ordered by " + rows[i].OrderedByName + " on " + rows[i].ProposedDate +". Do you want to continue?";
                        $("#InvstgListMainDiv").hide();
                    }
                }
            }
            if (MsgForConfrm == "")
                AddRowInvestigationTbl(code, name, rows);
            else {
                openPopupDynamic("Confirmation", MsgForConfrm, [
                    {
                        text: "Yes",
                        class: "btn btn-yes",
                        action: function () {
                            AddRowInvestigationTbl(code, name, rows);
                        }
                    },
                    {
                        text: "No",
                        class: "btn btn-no",
                        action: function () { }
                    }
                ]);
            }
            $("#InvstgSearch").val("");
            $("#InvstgListMainDiv").hide();
        });
    });
    function getNextInvestigationSeq() {

        let rows = InvstgListtable.getData();

        let usedSeq = rows
            .map(r => parseInt(r.SQNumber))
            .filter(n => !isNaN(n) && n > 0);

        let maxSeq = usedSeq.length > 0 ? Math.max(...usedSeq) : 0;

        return maxSeq + 1;
    }
    function AddRowInvestigationTbl(code, name, rows) {
        InvstgListtable.addRow({
            act: '<i class="fa fa-trash text-danger"></i>',
            TestCode: code,
            Test: name,
            ProposedDate: GetTodaysDate(),
            ProposedTime: getCurrentTime12Hour(),
            TestCount: 1,
            Pending: 1,
            OrderPlaced: 0,
            Remark: "",
            OrderedBy: gDoctId,
            OrderedByName: gDoctName,
            ORDERNO: "",
            OMIT: "N",
            OmittedDate: "",
            OmittedTime: "",
            OmittedBy: "",
            OmittedByName: "",
            OrderTime: GetTimewithAMPM(),
            OrderDate: GetTodaysDate(),
            CancelBY: "",
            CancelDT: "",
            CancelTM: "",
            LastOrderTM: "",
            LastOrderDT: "",
            NotifYN: "N",
            IsRollOver: "N",
            STATUS: "A",
            TypeCode: "IG",
            SQNumber: getNextInvestigationSeq(),
            Select: "N",
        }).then(function (row) {
            row.normalizeHeight();
        });
    }

    function mapTestData(dataArray) {
        if (!dataArray) return [];
        return dataArray.map(item => {
            return {
                action: item.action || "",
                Test: item.Test || "",
                Select: item.Select || "N",
                TestCode: item.TestCode || "",
                //HighAlert: item.HighAlert || "N",
                STATUS: item.STATUS || "A",
                ProposedDate: item.ProposedDate || item.PROPOSEDT || "",
                ProposedTime: item.ProposedTime || "",
                TestCount: item.TestCount || "",
                Pending: item.Pending || "",
                OrderPlaced: item.OrderPlaced || 0,
                IsRollOver: item.IsRollOver || "",
                TypeCode: item.TypeCode || "",
                Remark: item.REMARKS || item.Remark || "",
                ORDERNO: item.ORDERNO || "",
                OrderedBy: item.ORDERBY || item.OrderedBy || "",
                OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
                OrderDate: item.ORDDATE || item.OrderedDate || item.OrderDate ||item.ORDERDATE || "",
                OrderTime: item.ORDTIME || item.OrderedTime || item.OrderTime || item.ORDERTIME || "",
                SQNumber: item.SQNumber || item.SEQNO || "",
                ADMINYN: item.ADMINYN || "",
                NotifYN: item.NotifYN || "",
                CancelBY: item.CancelBY || "",
                CancelTM: item.CancelTM || "",
                CancelDT: item.CancelDT || "",
                LastOrderDT: item.LastOrderDT || "",
                LastOrderTM: item.LastOrderTM || "",
                OmittedBy: item.OMITBY || item.OmittedBy || "",
                OmittedByName: item.OMITBYNAME || item.OmittedByName || "",
                OmittedDate: item.OMITON || item.OMITON || "",
                OmittedTime: item.OMITAT || item.OMITAT || "",
                isFromServer: true,
                OMIT: (item.OMIT === "Y") ? "Y" : "N",
                IsRollOver: item.IsRollOver || "",
                isSavedOmit: item.OMIT === "Y" ? true : false
            };
        });
    }

    function BindInvestigationData(jsonTestData) {
        if (InvstgListtable) {
            const mappedData = mapTestData(jsonTestData);
            InvstgListtable.setData(mappedData);
        }
    }
    function handleOmitChange(row, isOmitted) {
        var data = row.getData();

        data.OMIT = isOmitted ? "Y" : "N";

        if (isOmitted) {
            data.OmittedBy = UserId || "";
            data.OmittedByName = gDoctName || "";
            data.OmittedDate = GetTodaysDate();
            data.OmittedTime = GetTimewithAMPM();
        } else {
            data.OmittedBy = "";
            data.OmittedByName = "";
            data.OmittedDate = "";
            data.OmittedTime = "";
        }

        row.update(data);
        row.reformat();
    }
    function GetAllInvstgList(FilterInvstgText, FilterInvstgCode) {
        startLoading("Loading", "loading-Invstg-Search-List")

        $.ajax({
            type: "POST",
            async: true,
            url: "../SinglePage/GetInvetiLst",
            data: { strMtrl: FilterInvstgText },
            success: function (result) {
                var InvstgListData = [];
                if (result && result.rows && result.rows.length > 0) {
                    InvstgListData = result.rows.map(item => ({
                        NAME: item.NAME,
                        CODE: item.CODE
                    }));
                    BindSearchListForInvstg(InvstgListData);

                } else {
                    ToastMsg("No data found", "info");
                    $("#InvstgList").empty();
                }

                stopLoading("loading-Invstg-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Invstg-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function FilterInvstgData(InvstgListData, InvstgCode) {
        var FilterComplList = InvstgListData;
        if (InvstgCode != "") {
            FilterComplList = InvstgListData.filter(item => item.CODE == InvstgCode);
        }
        BindSearchListForInvstg(FilterComplList);
        if (InvstgCode && InvstgCode !== "") {
            var $first = $("#InvstgList .Invstg-row").first();
            if ($first.length) {
                $first.trigger("click");
            }
        }
    }

    function FilterBindedSearchListForInvstg() {
        var SearchTxt = $("#InvstgSearch").val().toLowerCase();
        var FlagForCallAllComplList = true;
        if (SearchTxt.length >= 3) {
            if (FlagForCallAllComplList == true)
                GetAllInvstgList($("#InvstgSearch").val(), "");
        }
    }

    function BindSearchListForInvstg(InvstgData) {
        var $list = $("#InvstgList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No Invstg found</div>';
        if (InvstgData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < InvstgData.length; i++) {
                var item = InvstgData[i];
                var ListOption = '<div class="list-group-item Invstg-row" data-code="' + item.CODE + '" data-name="' + item.NAME + '" style="cursor:pointer;">' + item.NAME + ' (' + item.CODE + ') </div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#InvstgList").append(AppendContentList);
        $("#InvstgListMainDiv").show();
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

</script>

<%-- IV Fluids --%>
<script type="text/javascript">
    var IVFluidTable = null;
    var globalInfusionData = [];
    var UserId = '<%: Session["gOncoUserId"] ?? "" %>';

    $(document).ready(function () {

        IVFluidTable = new Tabulator("#IVFluidTable", {
            layout: "fitColumns",
            autoResize: false,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "<i class='fa fa-plus text-success' style='color: yellow!important'></i>",
                    field: "action",
                    width: 50,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    headerClick: function (e, column) {
                        AddIVFluidRow();
                    },
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if ((data.STATUS === "C" || data.IsRollOver === "Y") || (data.OMIT === "Y" && !data.isSavedOmit)) {
                            return "";
                        }
                        var html = '';
                        if (!data.isFromServer) {
                            html += '<i class="fa fa-trash text-danger" style="cursor:pointer; margin-right: 5px;" title="Delete"></i>';
                        }


                        if (data.isFromServer && data.ADMINYN !== "Y" && data.IsRollOver !== "Y") {
                            html += '<i class="fa fa-ban text-warning" style="cursor:pointer;" title="Cancel"></i>';
                        }

                        return html;
                    },
                    cellClick: function (e, cell) {
                        e.stopPropagation();
                        var target = e.target;
                        var row = cell.getRow();
                        var data = row.getData();

                        if (target.classList.contains('fa-trash')) {
                            if (!data.isFromServer) {
                                IVFluidTable.deleteRow(row);
                            }
                        }
                        else if (target.classList.contains('fa-ban')) {

                            if (data.isFromServer && data.STATUS !== "C") {
                                handleCancelRow(row);
                            }
                        }
                    }
                },
                { title: "Day", field: "DayOfDrug", headerHozAlign: "center", visible: false , 
                  editorParams: {
                        min: 0
                    }
                },
                { title: "Freq", field: "Dose", headerHozAlign: "center", visible: false },
                { title: "Route", field: "Route", headerHozAlign: "center", visible: false },
                { title: "Type", field: "Type", headerHozAlign: "center", visible: false },
                { title: "Diluent", field: "Diluent", headerHozAlign: "center", visible: false },
                {
                    title: "IV Fluids / TPN",
                    field: "DrugName",
                    width:355,
                    headerHozAlign: "center",
                    editor: "input",
                    editable: cell => cell.getRow().getData().ADMINYN !== "Y",
                    formatter: function (cell) {
                        const rowData = cell.getRow().getData();

                        if (rowData.IsRollOver === "Y") {
                            cell.getElement().classList.add("rollover-cell");
                        } else {
                            cell.getElement().classList.remove("rollover-cell");
                        }

                        return cell.getValue();
                    },
                    cellEdited: function (cell) {
                        const row = cell.getRow();
                        const rowData = row.getData();
                        const val = cell.getValue();

                        if (val) {
                            cell.setValue(val.toUpperCase(), true);
                        }
                        if (!val) {
                            row.update({
                                OrderedBy: "",
                                OrderedDate: "",
                                OrderedTime: null,
                                SpiDGSTARTDATE: null,
                                DayOfDrug: ""
                            });
                            return;
                        }
                        row.update({
                            OrderedBy: UserId,
                            OrderedDate: GetTodaysDate(),
                            OrderedTime: GetTimewithAMPM(),
                            SpiDGSTARTDATE: GetTodaysDate(),
                            DayOfDrug: "1",
                            NOTIFYN: "N"
                        });
                        // if (!rowData.SQNumber || rowData.SQNumber === "") {
                        //     const typeCode = GetTypeCode("IVFluidTable");
                        //     const maxSeqArr = GetMaxSEQNO("IVFluidTable");
                        //     if (maxSeqArr && maxSeqArr.length > 0) {
                        //         const nextSeq = Number(maxSeqArr[0].Column1) + 1;
                        //         row.update({ SQNumber: nextSeq });
                        //     } else {
                        //         const validRows = IVFluidTable.getData().filter(r => r.DrugName && r.DrugName !== "");
                        //         const seq = validRows.length;
                        //         row.update({ SQNumber: seq });
                        //     }
                        // }
                        if (!rowData.SQNumber || rowData.SQNumber === "" || rowData.SQNumber === 0) {

                            if (IVFluidNextSeq === null) {

                                const maxSeqArr = GetMaxSEQNO("IVFluidTable");

                                if (maxSeqArr && maxSeqArr.length > 0) {
                                    IVFluidNextSeq = Number(maxSeqArr[0].Column1);
                                } else {
                                    const validRows = IVFluidTable.getData()
                                        .filter(r => r.DrugName && r.DrugName !== "");

                                    IVFluidNextSeq = validRows.length;
                                }
                            }

                            IVFluidNextSeq++;

                            row.update({
                                SQNumber: IVFluidNextSeq
                            });
                        }
                    }
                },
                {
                    title: "Remark",
                    field: "Remark",
                    width:355,
                    headerHozAlign: "center",
                    editor: "textarea",
                    editable:true, /* cell => cell.getRow().getData().OMIT !== "Y" */
                    cellEdited: cell => {
                        if (cell.getValue()) {
                            cell.setValue(cell.getValue().toUpperCase(), true);
                        }
                       /* adjustTableHeight("IVFluidTable");*/
                    },
                    cssClass: "TabTextArea"
                },
                {
                    title: "<span style='color:red'>Volume (ml)</span>",
                    field: "DilutionVolume",
                    width:126,
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    editable: cell => cell.getRow().getData().ADMINYN !== "Y",
                    cellEdited: calculateIVFluid
                },
                {
                    title: "<span style='color:red'>Infusion Rate (ml/hr)</span>",
                    field: "INFRATE",
                    width:172,
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    editable: cell => cell.getRow().getData().ADMINYN !== "Y",
                    cellEdited: calculateIVFluid
                },
                {
                    title: "Dur. of Admn (hrs)",
                    field: "AdminstrDuration",
                    width:178,
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    // editable: cell => cell.getRow().getData().ADMINYN !== "Y",
                    editable: false,
                    cellEdited: calculateIVFluid
                },
                {
                    title: "Drop Rate / MI",
                    headerHozAlign: "center",
                    columns: [
                        { title: "Macro Set", field: "MACROSET", headerHozAlign: "center", editable: false, width: 100, },
                        { title: "Micro Set", field: "MICROSET", headerHozAlign: "center", editable: false, width: 100, }
                    ]
                },
                {
                    title: "Start Date",
                    field: "SpiDGSTARTDATE",
                    width: 120,
                    headerHozAlign: "center",
                    editable: false,
                    formatter: function (cell) { return cell.getValue() || ""; }
                },
                {
                    title: "High Alert",
                    field: "HighAlert",
                    width: 100,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function (cell) {
                        const checked = cell.getValue() === "Y" ? "checked" : "";
                        return `<input type="checkbox" ${checked} />`;
                    },
                    cellClick: function (e, cell) {
                        const isChecked = cell.getValue() === "Y";
                        const newVal = isChecked ? "N" : "Y";
                        cell.setValue(newVal);
                        const rowEl = cell.getRow().getElement();
                        rowEl.style.color = (newVal === "Y") ? "red" : "black";
                    }
                },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 60,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function(cell) {
                        let value = cell.getValue();
                        let isChecked = (value === true || value === "Y");

                        let input = document.createElement("input");
                        input.type = "checkbox";
                        input.checked = isChecked;

                        input.addEventListener("click", function(e) {
                            e.stopPropagation();
                        });
                        input.addEventListener("change", function() {
                            cell.setValue(this.checked ? "Y" : "N");
                            var row = cell.getRow();
                            handleOmitChange(row, this.checked);
                            row.update({
                                OMIT: this.checked ? "Y" : "N",
                                isSavedOmit: false
                            });
                        });
                        return input;
                    },
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var data = row.getData();
                        if (data.STATUS === "C") return;

                        // var isChecked = (e.target.tagName === "INPUT") ? e.target.checked : (data.OMIT !== "Y");
                        // var newValue = isChecked ? "Y" : "N";

                        // cell.setValue(newValue);
                       // handleOmitChange(row, newValue === "Y");
                    }
                },
                { title: "ADMINYN", field: "ADMINYN", visible: false },
                { title: "Order By", field: "OrderedBy", width: 100, editable: false, visible: false },
                //{ title: "Order By", field: "OrderedByName", width:100, editable: false },
                //Abhihsesh || 20260714
                {
                    title: "Order By",
                    field: "OrderedByName",
                    width: 100,
                    editable: false,
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        var name = data.OrderedByName || "";
                        var userId = data.OrderedBy || "";
                        return userId ? name + " (" + userId + ")" : name;
                    }
                },
                //End
                { title: "OrderedDate", field: "OrderedDate", visible: false },
                { title: "OrderedTime", field: "OrderedTime", visible: false },
                { title: "TypeCode", field: "TypeCode", visible: false },
                { title: "STATUS", field: "STATUS", visible: false },

                /* FIXED: Converted legacy properties to Tabulator 5+ syntax */
                { title: 'MEDSTAT', field: 'MEDSTAT', width: 10, headerSort: false, hozAlign: 'right', visible: false },
                { title: 'ISSUEYN', field: 'ISSUEYN', width: 50, headerSort: false, hozAlign: 'right', visible: false },
                { title: 'INDENTYN', field: 'INDENTYN', width: 50, headerSort: false, hozAlign: 'right', visible: false },
                { title: 'IsRollOver', field: 'IsRollOver', width: 50, headerSort: false, hozAlign: 'right', visible: false },
                //  { title: 'AdministerSeq', field: 'AdministerSeq', width: 50, headerSort: false, hozAlign: 'right', visible: false },
                // { title: 'CHADMINSEQ', field: 'CHADMINSEQ', width: 50, headerSort: false, hozAlign: 'right', visible: false },


                { title: 'SetNo', field: 'SetNo', width: 50, headerSort: false, hozAlign: 'right', visible: false },
                { title: 'ORGDOSE', field: 'ORGDOSE', width: 50, headerSort: false, hozAlign: 'right', visible: false },

                { title: "Prescribe By", field: "DOCNAME", visible: false },
                { title: "DiluentGenericCode", field: "DiluentGenericCode", visible: false },
                {
                    title: "End Date",
                    field: "ENDDATE",
                    width: 90,
                    editable: false, visible: false
                },
            ],
            //rowFormatter: function (row) {
            //    const d = row.getData();
            //    row.getElement().classList.toggle("Omited", d.OMIT === "Y");
            //}
            rowFormatter: function (row) {
                var data = row.getData();
                var element = row.getElement();

                element.style.backgroundColor = "";
                element.style.color = "";
                element.style.textDecoration = "";
                element.style.pointerEvents = "auto";
                const d = row.getData();
                row.getElement().classList.toggle("Omited", d.OMIT === "Y");

                if (data.STATUS === "C") {
                    element.style.backgroundColor = "#f8d7da";
                    //element.style.color = "#721c24";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "none";
                }
                else if (data.HighAlert == "Y") {
                    element.style.color = "#db0000";
                }
                 if (data.OMIT === "Y") {
                    element.style.backgroundColor = "#d4edda";
                    //element.style.color = "";
                    element.style.textDecoration = "line-through";

                }
                let actionCell = row.getCell("action").getElement();
                if (data.ADMINYN == "Y") {
                    actionCell.style.background = "linear-gradient(to left, #ebd0b75e, #ffc837)";
                    row.getElement().classList.add("avoid-clicks");
                }
                else {
                    actionCell.style.background = "";
                    row.getElement().classList.remove("avoid-clicks");
                }
                
                if (data.isSavedOmit === false) {
                    row.getCells().forEach(function(cell) {
                            cell.getElement().classList.remove("disable-cell");     
                    });
                }
                else if (data.isSavedOmit === true) {
                    row.getCells().forEach(function(cell) {
                        cell.getElement().classList.add("disable-cell");
                    });
                }
                if (data.IsRollOver == "Y") {

                    row.getCells().forEach(function(cell) {

                        let field = cell.getColumn().getField();

                        if (!["OMIT"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });

                }

            },
            // Cell click logic
            cellClick: function (e, cell) {
                var rowData = cell.getRow().getData();
                let field = cell.getColumn().getField();
                if (rowData.ADMINYN === "Y") {
                    if (field !== "action" && field !== "OMIT") {
                        e.stopPropagation();
                        return false;
                    }
                }
            }
        });
    });
    function handleOmitChange(row, isOmitted) {
        var data = row.getData();

        data.OMIT = isOmitted ? "Y" : "N";

        if (isOmitted) {
            data.OmittedBy = UserId || "";
            data.OmittedByName = gDoctName || "";
            data.OmittedDate = GetTodaysDate();
            data.OmittedTime = GetTimewithAMPM();
        } else {
            data.OmittedBy = "";
            data.OmittedByName = "";
            data.OmittedDate = "";
            data.OmittedTime = "";
        }

        row.update(data);
        row.reformat();
    }
    function calculateIVFluid(cell) {
        const row = cell.getRow();
        const d = row.getData();

        const volume = Number(d.DilutionVolume || 0);
        let rate = Number(d.INFRATE || 0);
        let duration = Number(d.AdminstrDuration || 0);

        if (volume > 0 && rate > 0) {
            duration = volume / rate;
        }
        else if (volume > 0 && duration > 0) {
            rate = volume / duration;
        }
        else {
            row.update({
                INFRATE: null,
                AdminstrDuration: null,
                MACROSET: null,
                MICROSET: null
            });
            return;
        }
        row.update({
            INFRATE: Math.round(rate),
            AdminstrDuration: Math.round(duration),
            MACROSET: Math.round((volume * 20) / (duration * 60)),
            MICROSET: Math.round((volume * 60) / (duration * 60))
        });
    }

    function AddIVFluidRow() {
        const rows = IVFluidTable.getData();
        if (rows.length > 0 && !rows[rows.length - 1].DrugName) {
            ToastMsg("Please fill first IV Fluid row before adding new row.", "information");
            return;
        }
        IVFluidTable.addRow({
            DayOfDrug: "1",
            Duration: "0",
            DrugName: "",
            Dose: "",
            MICROSET: "",
            MACROSET: "",
            INFRATE: "",
            Diluent: "",
            Route: "",
            Freq: "",
            Type: "",
            Remark: "",
            HighAlert: "N",
            OrderedDate: GetToday_DDMMYYYY(),
            OrderedTime: GetTimewithAMPM(),
            SQNumber: 0,
            INFCODE: "",
            DrugCode: "",
            OMIT: "N",
            OmittedBy: "",
            OmittedByName : "",
            OmittedDate: "",
            OmittedTime: "",
            ADMINYN: "N",
            AdminstrDuration: "",
            TypeCode: "IV",
            NOTIFYN: "N",
            STATUS: "A",
            INDENTYN: "",
            ISSUEYN: "",
            IsRollOver: "N",
            SpiDGSTARTDATE: GetToday_DDMMYYYY(),
            OrderedBy: UserId || "",
            OrderedByName: gDoctName,
            MEDSTAT: "",
            SetNo: "",
            ENDDATE: "",
          
        });
    }

    function numericOnlyEditor(cell, onRendered, success, cancel) {
        if (!cell.getColumn().isVisible()) {
            cancel();
            return;
        }

        let input = document.createElement("input");
        input.type = "text";
        input.value = cell.getValue() || "";
        input.maxLength = 10;

        input.addEventListener("keypress", function (e) {
            if (!/[0-9]/.test(e.key)) {
                e.preventDefault();
            }
        });

        input.addEventListener("blur", function () {
            success(input.value);
        });
        onRendered(function () {
            input.focus();
            input.select();
        });
        return input;
    }
    function BindIVSuplementData(jsonSpecilInstData) {
        if (IVFluidTable && IVFluidTable.initialized) {
            const mappedData = mapIVSpplementData(jsonSpecilInstData);
            IVFluidTable.setData(mappedData);
        }
    }
    function mapIVSpplementData(dataArray) {
        if (!dataArray) return [];
        return dataArray.map(item => {
            let currentStatus = item.STATUS || "N";
            let adminYn = item.ADMINYN || "N";
            if (currentStatus === "N" && adminYn === "C") {
                currentStatus = "C";
                adminYn = "N";
            }
            return {
                action: item.action || "",
                DayOfDrug: String(item.DayOfDrug || item.DAYOFDRUG || "1"),
                Type: item.Type || "",
                DrugName: item.DrugName || "",
                Dose: item.Dose || "",
                Route: item.Route || item.ROUTE || "",
                Freq: item.Freq || item.FREQ || "",
                DrugCode: item.DrugCode || item.CODE || "",
                Remark: item.Remark || "",
                Diluent: item.Diluent || item.DILUENT || "",
                HighAlert: item.HighAlert || "N",
                TypeCode: item.TypeCode || "",
                DilutionVolume: item.DILVOLUME || item.DilutionVolume || "",
                // AdminstrDuration: item.ADMINDUR || "",
                AdminstrDuration: item.ADMINDUR ? Number(item.ADMINDUR) : 0,
                SpiDGSTARTDATE: item.STARTFRMDT || item.SpiDGSTARTDATE || "",
                OrderedBy: item.ORDERBY || item.OrderedBy || "",
                OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
                OrderedDate: item.ORDDATE || item.OrderedDate || "",
                OrderedTime: item.ORDTIME || item.OrderedTime || "",
                SQNumber: (item.SQNumber || item.SEQNO) ? Number(item.SQNumber || item.SEQNO) : 0,
                NOTIFYN: item.NOTIFYN || "",
                STATUS: currentStatus,
                ADMINYN: adminYn,
                MEDSTAT: item.MEDSTAT || "",
                ISSUEYN: item.ISSUEYN || "",
                INDENTYN: item.INDENTYN || "",
                MICROSET: (item.MICROSET && item.MICROSET !== "") ? Number(item.MICROSET) : null,
                MACROSET: item.MACROSET !== "" ? Number(item.MACROSET) : null,
                INFRATE: item.INFRATE !== "" ? Number(item.INFRATE) : null,
                Duration: item.DURATION || "0",
                DOCNAME: item.DOCNAME || "",
                DiluentGenericCode: item.DiluentGenericCode || "",
                OmittedBy: item.OMITBY || item.OmittedBy || "",
                OmittedByName: item.OMITBYNAME || item.OmittedByName || "",
                OmittedDate: item.OMITDT || item.OmittedDate || "",
                OmittedTime: item.OMITTM || item.OmittedTime || "",
                OMIT: (item.OMIT === "Y") ? "Y" : "N",
                IsRollOver: item.IsRollOver || "",
                ENDDATE: item.ENDDATE || "",
                isFromServer: true,
                isSavedOmit:item.OMIT == "Y" ? true :false
            };
        });
    }

</script>

<%-- Blood Product --%>
<script type="text/javascript">
    var BloodProductTable;
    var MediciTypeLStr = '';
    var BloodProductList = [];
    var IsOnlyDisplay = false;
    var UserId = '<%: Session["gOncoUserId"] ?? "" %>';

    load_BloodProductList();

    $(document).ready(function () {
        BloodProductTable = new Tabulator("#BloodProductTable", {
            layout: "fitColumns",
            autoResize: false,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "<i class='fa fa-plus text-success' style='color: yellow!important'></i>",
                    field: "action",
                    width: 50,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    headerClick: function (e, column) {
                        AddBloodProductRow();
                    },
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if ((data.STATUS === "C" || data.IsRollOver === "Y") || (data.OMIT === "Y" && !data.isSavedOmit)) {
                            return "";
                        }
                        var html = '';

                        if (!data.isFromServer) {
                            html += '<i class="fa fa-trash text-danger" style="cursor:pointer; margin-right: 5px;" title="Delete"></i>';
                        }

                        if (data.isFromServer && data.ADMINYN !== "Y" && data.OMIT !== "Y" && data.IsRollOver !== "Y") {
                            html += '<i class="fa fa-ban text-warning" style="cursor:pointer;" title="Cancel"></i>';
                        }

                        return html;
                    },
                    cellClick: function (e, cell) {
                        e.stopPropagation();
                        var target = e.target;
                        var row = cell.getRow();
                        var data = row.getData();

                        if (target.classList.contains('fa-trash')) {
                            if (!data.isFromServer) {
                                BloodProductTable.deleteRow(row);
                            }
                        }
                        else if (target.classList.contains('fa-ban')) {

                            if (data.isFromServer && data.STATUS !== "C") {
                                handleCancelRow(row);
                            }
                        }
                    }
                },
                {
                    title: "QTY",
                    field: "Dose",
                    width:105,
                    headerHozAlign: "center",
                    editor: "input",
                    editorParams: {
                        elementAttributes: {
                            maxlength: 5,
                            oninput: "this.value=this.value.replace(/\\D/g,'')"
                        }
                    },
                    formatter: function (cell) {
                        const rowData = cell.getRow().getData();

                        if (rowData.IsRollOver === "Y") {
                            cell.getElement().classList.add("rollover-cell");
                        } else {
                            cell.getElement().classList.remove("rollover-cell");
                        }

                        return cell.getValue();
                    }
                },       
                { title: "Duration", field: "Duration", headerHozAlign: "center", editor: "input", visible: false },
                { title: "Type", field: "Type", headerHozAlign: "center", editor: "select", editorParams: { values: MediciTypeLStr }, visible: false },
                {
                    title: "Blood / Blood Products",
                    field: "DrugName",
                    width: 300,
                    headerHozAlign: "center",
                    editor: "list",
                    editorParams: {
                        values: BloodProductList, // Use the pre-loaded array
                        autocomplete: true,
                        listOnEmpty: true,       // Shows all options when you click the empty cell
                        filterRemote: false,      // Important: tells Tabulator the data is local
                        allowEmpty: true,
                        emptyGenericPlaceholder: false
                    },
                    cellEdited: function (cell) {
                        const row = cell.getRow();
                        const d = row.getData();

                        if (d.DrugName) {
                            row.update({
                                OrderedBy: typeof UserId !== 'undefined' ? UserId : "",
                                OrderedDate: typeof GetTodaysDate === 'function' ? GetTodaysDate() : "",
                                OrderedTime: typeof GetTimewithAMPM === 'function' ? GetTimewithAMPM() : "",
                                BPSTARTDATE: GetToday_DDMMYYYY(),
                                DayOfDrug: "1",
                                /*HighAlertMed: ""*/
                                HighAlert: "Y",
                                NOTIFYN: ""
                            });
                            // row.getElement().classList.add("HighAlertDrug");
                        }
                        if (!d.SQNumber || d.SQNumber === "") {

                            const typeCode = GetTypeCode("BloodProductTable");
                            const maxSeqArr = GetMaxSEQNO("BloodProductTable");

                            if (maxSeqArr.length > 0) {
                                const nextSeq = Number(maxSeqArr[0].Column1) + 1;

                                row.update({ SQNumber: nextSeq });
                                UpdateMaxSEQNOArray(typeCode, nextSeq);
                            }
                            else {
                                // count only rows having DrugName
                                const validRows = BloodProductTable.getData()
                                    .filter(r => r.DrugName && r.DrugName !== "");

                                const seq = validRows.length;

                                row.update({ SQNumber: seq });
                                AddDataToMaxArray(typeCode, seq);
                            }
                        }
                    }
                },
                { title: "Day", field: "DayOfDrug", headerHozAlign: "center", visible: false,
 editorParams: {
                        min: 0
                    }
 },
                { title: "Route", field: "Route", headerHozAlign: "center", editor: "select", visible: false },
                { title: "Freq", field: "Freq", headerHozAlign: "center", editor: "input", visible: false },
                {
                    title: "Remark",
                    field: "Remark",
                    width: 300,
                    headerHozAlign: "center",
                    editor: "textarea",
                    cssClass: "TabTextArea",
                    cellEdited: function (cell) {
                        //adjustTableHeight("BloodProductTable");
                    }

                }, 
                { title: "Diluent", field: "Diluent", headerHozAlign: "center", editor: "input", visible: false },
                {
                    title: "<span style='color:red'>Volume / ml</span>",
                    field: "DilutionVolume",
                    width:138,
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    cellEdited: calculateBloodProduct
                },
                {
                    title: "<span style='color:red'>Transfusion rate (ml/hr)</span>",
                    field: "INFRATE",
                    width:170,
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    cellEdited: calculateBloodProduct
                },
                {
                    title: "Dur.of Admn(hrs)",
                    field: "AdminstrDuration",
                    width:138,
                    headerHozAlign: "center",
                    editable: true,
                    editor: numericOnlyEditor,
                    cellEdited: calculateBloodProduct
                },
                { title: "Drop rate(drops/mt)", field: "MACROSET", width:155, headerHozAlign: "center", editable: false },
                {
                    title: "Start Date",
                    field: "BPSTARTDATE",
                    headerHozAlign: "center",
                    width: 120,
                    editable: false,
                    formatter: function (cell) {
                        return cell.getValue() || "";
                    }
                },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 60,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function(cell) {
                        let value = cell.getValue();
                        let isChecked = (value === true || value === "Y");

                        let input = document.createElement("input");
                        input.type = "checkbox";
                        input.checked = isChecked;

                        input.addEventListener("click", function(e) {
                            e.stopPropagation();
                        });
                        input.addEventListener("change", function() {
                            cell.setValue(this.checked ? "Y" : "N");
                            var row = cell.getRow();
                            handleOmitChange(row, this.checked);
                            row.update({
                                OMIT: this.checked ? "Y" : "N",
                                isSavedOmit: false
                            });
                        });
                        return input;
                    },
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var data = row.getData();

                        if (data.STATUS === "C") return;

                        // var isChecked = (e.target.tagName === "INPUT") ? e.target.checked : (data.OMIT !== "Y");
                        // var newValue = isChecked ? "Y" : "N";

                        // cell.setValue(newValue);
                       // handleOmitChange(row, newValue === "Y");
                    }
                },
                { title: "Order By", field: "OrderedBy", width: 120, headerHozAlign: "center", editable: false, visible: false },
                //{ title: "Order By", field: "OrderedByName", width: 120, headerHozAlign: "center", editable: false },
                //Abhishesh || 20260714
                {
                    title: "Order By",
                    field: "OrderedByName",
                    width: 120,
                    headerHozAlign: "center",
                    editable: false,
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        var name = data.OrderedByName || "";
                        var userId = data.OrderedBy || "";
                        return userId ? name + " (" + userId + ")" : name;
                    }
                },
                //End
                { field: "OrderedDate", visible: false },
                { field: "OrderedTime", visible: false },
                { field: "DrugCode", visible: false },
                { field: "TypeCode", visible: false },
                { field: "SQNumber", visible: false },
                { field: "HighAlert", visible: false },
                { field: "STATUS", visible: false },
                { field: "MEDSTAT", visible: false },
                { field: "ADMINYN", visible: false },
                { field: "IsRollOver", visible: false },

                {
                    title: "NOTIFYN",
                    field: "NOTIFYN",
                    visible: false
                },
                {
                    title: "End Date",
                    field: "ENDDATE",
                    width: 90,
                    editable: false,
                    visible: false
                },
            ],
            rowFormatter: function (row) {
                var data = row.getData();
                var element = row.getElement();

                element.style.backgroundColor = "";
                element.style.color = "";
                element.style.textDecoration = "";
                element.style.pointerEvents = "auto";

                if (data.STATUS === "C") {
                    element.style.backgroundColor = "#f8d7da";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "none";
                }
                else if (data.HighAlert == "Y") {
                    element.style.color = "#db0000";
                }
                if (data.OMIT === "Y") {
                    row.getElement().classList.remove("HighAlertDrug");
                    element.style.backgroundColor = "#d4edda";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "auto";
                }

                let actionCell = row.getCell("action").getElement();
                if (data.ADMINYN == "Y") {
                    actionCell.style.background = "linear-gradient(to left, #ebd0b75e, #ffc837)";
                }
                else {
                    actionCell.style.background = "";
                }
               
                if (data.isSavedOmit === false) {
                    row.getCells().forEach(function(cell) {
                        cell.getElement().classList.remove("disable-cell");
                    });
                }
                else if (data.isSavedOmit === true) {
                    row.getCells().forEach(function(cell) {
                        cell.getElement().classList.add("disable-cell");
                    });
                }
                if (data.IsRollOver == "Y") {

                    row.getCells().forEach(function(cell) {

                        let field = cell.getColumn().getField();

                        if (!["OMIT"].includes(field)) {
                            cell.getElement().classList.add("disable-cell");
                        }

                    });

                }
            },
            cellClick: function (e, cell) {
                var rowData = cell.getRow().getData();
                let field = cell.getColumn().getField();
                if (rowData.ADMINYN === "Y") {
                    if (field !== "action" && field !== "OMIT") {
                        e.stopPropagation();
                        return false;
                    }
                }
            }

        });
        if (IsOnlyDisplay) {
            BloodProductTable.hideColumn("action");
        }
    });


    function AddBloodProductRow() {
        const rows = BloodProductTable.getData();
        if (rows.length > 0 && !rows[rows.length - 1].DrugName) {
            if (typeof ToastMsg === 'function') ToastMsg("Please fill first Blood Product row before adding new row.", "information");
            return;
        }
        BloodProductTable.addRow({
            BPSTARTDATE: GetToday_DDMMYYYY(),
            OrderedBy: UserId || "",
            OrderedByName: gDoctName || "",
            Dose: "",
            Duration: "0",
            Type: "",
            DrugName: "",
            DayOfDrug: "1",
            Route: "",
            Freq: "",
            Remark: "",
            Diluent: "",
            DilutionVolume: "",
            INFRATE: "",
            AdminstrDuration: "",
            MACROSET: "",
            DrugCode: "",
            TypeCode: "BP",
            OrderedDate: GetToday_DDMMYYYY(),
            OrderedTime: GetTimewithAMPM(),
            OMIT: "N",
            OmittedBy: "",
            OmittedByName : "",
            OmittedDate: "",
            OmittedTime: "",
            SQNumber: "",
            STATUS: "A",
            ADMINYN: "N",
            MEDSTAT: "",
            IsRollOver: "",
            HighAlert: "Y",
            NOTIFYN: "N",
            ENDDATE: "",
            isFromServer: false


        });
    }
    function BindBloodProductData(jsonBloodProductData) {
        if (BloodProductTable) {
            const mappedData = mapBloodProdData(jsonBloodProductData);
            BloodProductTable.setData(mappedData);

        }
    }

    function mapBloodProdData(dataArray) {
        if (!dataArray) return [];
        return dataArray.map(item => {
            let currentStatus = item.STATUS || "N";
            let adminYn = item.ADMINYN || "N";
            if (currentStatus === "N" && adminYn === "C") {
                currentStatus = "C";
                adminYn = "N";
            }
            return {
                action: item.action || "",
                DayOfDrug: item.DayOfDrug || "",
                DrugName: item.DrugName || "",
                Dose: item.Dose || "",
                Remark: item.Remark || "",
                Type: item.Type || "",
                Diluent: item.DILUENT !== undefined ? item.DILUENT : "",
                DilutionVolume: item.DILVOLUME || "",
                DrugCode: item.DrugCode || item.CODE || "",
                Route: item.Route || item.ROUTE || "",
                Freq: item.Freq || item.FREQ || "",
                Duration: item.DURATION || "0",
                HighAlert: item.HighAlert || "N",
                //STATUS: currentStatus || "A",
                TypeCode: item.TypeCode,
                BPSTARTDATE: item.STARTFRMDT || "",
                OrderedBy: item.ORDERBY || item.OrderedBy || "",
                OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
                OrderedDate: item.ORDERDATE || item.OrderedDate || item.ORDDATE || "",
                OrderedTime: item.ORDERTIME || item.OrderedTime || item.ORDTIME || "",
                SQNumber: (item.SQNumber || item.SEQNO) ? Number(item.SQNumber || item.SEQNO) : 0,
                STATUS: currentStatus,
                ADMINYN: adminYn,
                MACROSET: item.MACROSET !== "" ? Number(item.MACROSET) : null,
                INFRATE: item.INFRATE !== "" ? Number(item.INFRATE) : null,

                NOTIFYN: item.NOTIFYN || "N",
                // AdminstrDuration: item.ADMINDUR || "",
                AdminstrDuration: item.ADMINDUR ? Number(item.ADMINDUR) : 0,
                isFromServer: true,
                // Omit Logic
                OmittedBy: item.OMIT === "Y" ? (item.OMITBY || item.OmittedBy || "") : "",
                OmittedByName: item.OMIT === "Y" ? (item.OMITBYNAME || item.OmittedByName || "") : "",
                OmittedDate: item.OMIT === "Y" ? (item.OMITDT || item.OmittedDate || "") : "",
                OmittedTime: item.OMIT === "Y" ? (item.OMITTM || item.OmittedTime || "") : "",
                OMIT: (item.OMIT === "Y") ? "Y" : "N",
                IsRollOver: item.IsRollOver || "",
                ENDDATE: item.ENDDATE || "",
                isSavedOmit :item.OMIT === "Y" ? true : false

            };
        });
    }

    function handleOmitChange(row, isOmitted) {
        var data = row.getData();

        data.OMIT = isOmitted ? "Y" : "N";

        if (isOmitted) {
            data.OmittedBy = UserId || "";
            data.OmittedByName = gDoctName || "";
            data.OmittedDate = GetTodaysDate();
            data.OmittedTime = GetTimewithAMPM();
        } else {
            data.OmittedBy = "";
            data.OmittedByName = "";
            data.OmittedDate = "";
            data.OmittedTime = "";
        }

        row.update(data);
        row.reformat();
    }
    function load_BloodProductList() {
        $.ajax({
            url: '../SinglePage/GetBloodProductList',
            type: 'GET',
            async: false,
            success: function (response) {
                if (!Array.isArray(response)) {
                    return;
                }
                BloodProductList = response.map(item => ({
                    label: (item.Text || "").toString().trim(),
                    value: (item.Value || "").toString().trim()
                }));
            },
            error: function (err) {
                ToastMsg(err, "error");
            }
        });
    }

    function calculateBloodProduct(cell) {
        const row = cell.getRow();
        const d = row.getData();
        if (d.STATUS === "C" || d.OMIT === "Y") {
            return;
        }
        const volume = Number(d.DilutionVolume || 0);
        let rate = Number(d.INFRATE || 0);
        let duration = Number(d.AdminstrDuration || 0);

        if (volume > 0 && rate > 0) {
            duration = volume / rate * 60;
        } else if (volume > 0 && duration > 0) {
            rate = volume * 60 / duration;
        } else {
            row.update({ INFRATE: null, AdminstrDuration: null, MACROSET: null });
            return;
        }

        row.update({
            INFRATE: Math.round(rate),
            AdminstrDuration: Math.round(duration),
            // MACROSET: Math.round((volume * 20) / (duration * 60))
            MACROSET: Math.round(((rate) * DropRate) /  60)
        });
    }



    function numericOnlyEditor(cell, onRendered, success, cancel) {
        let input = document.createElement("input");
        input.type = "text";
        input.value = cell.getValue() || "";
        input.style.width = "100%";
        input.maxLength = 10;
        onRendered(function () {
            input.focus();
        });
        input.addEventListener("keypress", function (e) {
            if (!/[0-9]/.test(e.key)) { e.preventDefault(); }
        });
        input.addEventListener("blur", function () { success(input.value); });
        input.addEventListener("keydown", function (e) { if (e.keyCode == 13) success(input.value); if (e.keyCode == 27) cancel(); });
        return input;
    }

    function GetToday_DDMMYYYY() {
        const d = new Date();
        const dd = String(d.getDate()).padStart(2, '0');
        const mm = String(d.getMonth() + 1).padStart(2, '0');
        const yyyy = d.getFullYear();
        return dd + "/" + mm + "/" + yyyy;
    }
</script>

<%-- CHEMO --%>
<script type="text/javascript">
    var ChemoListtable;
var isChemoContinuePending = false;
    function TabulatorGetChemo() {
        ChemoListtable = new Tabulator("#ChemoTable", {
            data: [],
            layout: "fitColumns",
            height: "auto",
            resizableColumnFit: true,
            index: "DRUGCD",
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            groupBy: "SetNo",
            groupStartOpen: true,
            groupHeader: function (value, count, data, group) {
                const holdRows = data.filter(row => (row.HOLD || "N").toUpperCase() === "Y");
                const holdStatus = holdRows.length > 0 ? "Y" : "N";

                let html = `<span>Set No: ${value} (${count})</span>`;
                html += holdStatus === "Y"
                    ? ` <i class="fa fa-play text-success group-action-btn" data-action="resume" title="Resume/Unhold" style="cursor:pointer; margin-left:10px;"></i>`
                    : ` <i class="fa fa-pause text-info group-action-btn" data-action="hold" title="Hold" style="cursor:pointer; margin-left:10px;"></i>`;
                setTimeout(() => {

                    let el = group.getElement();


                    if (el instanceof jQuery) { el = el[0]; }


                    if (!el || typeof el.querySelector !== "function") return;

                    const btn = el.querySelector(".group-action-btn");
                    if (!btn) return;

                    btn.onclick = function (e) {
                        e.preventDefault();
                        e.stopPropagation();

                        const actionType = btn.getAttribute("data-action");
                        const rows = group.getRows();

                        const applyHold = (reason) => {
                            if (actionType === "hold") {
                                btn.className = "fa fa-play text-success group-action-btn";
                                btn.setAttribute("data-action", "resume");
                                btn.setAttribute("title", "Resume/Unhold");
                            } else {
                                btn.className = "fa fa-pause text-info group-action-btn";
                                btn.setAttribute("data-action", "hold");
                                btn.setAttribute("title", "Hold");
                            }

                            const newVal = (actionType === "hold") ? "Y" : "N";
                            const msg = (actionType === "hold") ? "Process Hold Successful" : "Process Unhold Successful";

                            let updatePromises = rows.map(row => {
                                processHoldUpdate(row, newVal, reason || "", msg);
                                return row.update({ HOLD: newVal });
                            });
                            Promise.all(updatePromises).then(() => {
                                setTimeout(() => {
                                    ChemoListtable.redraw(true);
                                }, 50);
                            });
                        };

                        if (actionType === "hold") {
                            openHoldModal(function (reason) {
                                if (!reason || reason.trim() === "") {
                                    ToastMsg("Please enter the reason for hold", "warning");
                                    return false;
                                }
                                applyHold(reason);
                                return true;
                            });
                        } else {
                            if (confirm("Are you sure you want to Unhold this set?")) {
                                applyHold("");
                            }
                        }
                    };
                }, 50);

                return html;
            },
            columns: [
                {
                    title: "CIMS INFO",
                    field: "CIMS",
                    width: 138,
                    headerSort: false,
                    hozAlign: "center",
                    visible: IS_DISPLAY_CIMS_FUNCTIONLITY ? IS_DISPLAY_CIMS_FUNCTIONLITY == "Y" : false,
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
                    title: "Action",
                    field: "action",
                    width: 60,
                    headerSort: false,
                    hozAlign: "center",
                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        if (data.STATUS === "C" || data.OMIT == "Y") {
                            return "";
                        }
                        var html = '';
                        if (!data.isFromServer) {
                            html += '<i class="fa fa-trash text-danger" style="cursor:pointer; margin-right: 5px;" title="Delete"></i>';
                        }
                        if (data.isFromServer) {
                            if (data.ADMINYN !== "Y") {
                                html += '<i class="fa fa-ban text-warning action-btn" data-action="cancel" title="Cancel"></i>';
                            }
                        }
                        return html;
                    },
                    cellClick: function (e, cell) {
                        e.stopPropagation();
                        var target = e.target;
                        var row = cell.getRow();
                        var data = row.getData();

                        if (target.classList.contains('fa-trash')) {
                            if (!data.isFromServer) {
                                ChemoListtable.deleteRow(row);
                            }
                        }
                        else if (target.classList.contains('fa-ban')) {

                            if (data.isFromServer && data.STATUS !== "C") {
                                handleCancelRow(row);
                            }
                        }
                    }
                },

                {
                    title: "<span style='color:red'>Day</span>",
                    field: "DayOfDrug", editor: "input", width: 95,
                    editor: "input",
                    editorParams: {
                        elementAttributes: {
                            maxlength: 5,
                            oninput: "this.value=this.value.replace(/\\D/g,'')"
                        }
                    },
                    editable: false
                },
                //{
                //    title: "<span style='color:red'>Drug Form</span>",
                //    field: "Type",
                //    tooltip: true,
                //    editor: "list",
                //    editable: false,
                //    width: 165,
                //    editorParams: {
                //        values: GrdChemoAnitibioticType(),
                //        autocomplete: true,
                //        listOnEmpty: true,       // Shows all options when you click the empty cell
                //        filterRemote: false,      // Important: tells Tabulator the data is local
                //        allowEmpty: false,
                //    },
                //    formatter: "lookup",
                //    formatterParams: GrdChemoAnitibioticType()
                //},
                {
                    title: '<span style="color:red;">Drug Form</span>',
                    field: "Type",
                    editor: "input",
                    width: 90,
                    visible: true,
                    editable: false,
                },
                // {
                //     title: '<span style="color:red;">Drug Form Code</span>',
                //     field: "DRUGFROMCD",
                //     editor: "input",
                //     visible: false,
                //     editable: false,
                // },
                {
                    title: "Chemo Medication",
                    field: "DrugName",
                    width: 290,
                    editable: false,
                    formatter: function (cell) {
                        let row = cell.getData();
                        let val = cell.getValue() || "";
                        let icons = "";
                        if (row.ISSUEYN === "Y") icons += "<img src='../Images/Check.png' style='width:16px;height:16px;margin-left:5px;float:right;' title='Issued' />";
                        if (row.INDENTYN === "Y") icons += "<img src='../Images/pills.png' style='width:16px;height:16px;margin-left:5px;float:right;' title='Indented' />";
                        return val + icons;
                    }
                },
                {
                    title: "<span style='color:red'>Dose</span>",
                    field: "Dose",
                    width: 120,
                    editable: true, //canEditDose, As per Shubham 
                    editor: "input",

                    validator: function(cell, value) {
                        const validPattern = /^\d+(\.\d{1,2})?\s+[A-Za-z]+/;

                        if (!validPattern.test(value.trim())) {
                            ToastMsg("Invalid dose format.Use space between number and unit(e.g., 175.00 mg/m²).", "error");
                            return false;
                        }

                        return true;
                    }
                },
                getRouteColumn(canEdit, "ChemoTable"),
                { title: "<span style='color:red'>Frequency</span>", field: "Freq", editable: false, width: 120},
                {
                    title: "Remark",
                    field: "Remark",
                    width:250,
                    editor: "textarea",
                    cssClass: "TabTextArea",
                    editable: canEdit,
                    cellEdited: function (cell) {
                        adjustTableHeight("ChemoTable");
                    }
                },
                { title: "<span style='color:red'>Diluent</span>", field: "Diluent", editor: "input", editable: canEdit, width: 90},
                {
                    title: "<span style='color:red'>Dilution Volume</span>",
                    field: "DilutionVolume",
                    width: 90,
                    tooltip: true,
                    editor: "list",
                    width: 120,
                    editable: canEdit,
                    editorParams: {
                        values: Get_DiluVolume(),
                        autocomplete: true,
                        listOnEmpty: true,       // Shows all options when you click the empty cell
                        filterRemote: false,      // Important: tells Tabulator the data is local
                        allowEmpty: false,
                    },
                    formatter: "lookup",
                    formatterParams: Get_DiluVolume()
                },
                {
                    title: "<span style='color:red'>Dur. of Admn.</span>",
                    field: "AdminstrDuration",
                    width: 120,
                    tooltip: true,
                    editor: "list",
                    editable: canEdit,
                    width: 100,
                    editorParams: {
                        values: Get_AdminDurData(),
                        autocomplete: true,
                        listOnEmpty: true,       // Shows all options when you click the empty cell
                        filterRemote: false,      // Important: tells Tabulator the data is local
                        allowEmpty: false,
                    },
                    formatter: "lookup",
                    formatterParams: Get_AdminDurData()
                },
                {
                    title: "Start Date",
                    field: "AntiBoDGSTARTDATE",
                    width: 90,
                    editable: false,
                },
                {
                    title: "End Date",
                    field: "ENDDATE",
                    width: 90,
                    editable: false,
                },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 60,
                    hozAlign: "center",
                    headerSort: false,

                    formatter: function (cell) {
                        var data = cell.getRow().getData();
                        var checked = data.OMIT === "Y" ? "checked" : "";
                        var Disabled = data.ISSUEYN === "Y" || data.INDENTYN === "Y" ? "disabled" : ""; 
                        return `<input type="checkbox" ${checked}  ${Disabled}/>`;
                    },

                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var data = row.getData();

                        var isChecked;

                        if (e.target.tagName === "INPUT") {
                            isChecked = e.target.checked;
                        } else {
                            isChecked = data.OMIT !== "Y";
                        }

                        var newValue = isChecked ? "Y" : "N";

                        cell.setValue(newValue);

                        handleChemoOmitChange(row, newValue === "Y");
                    }
                },
                getOmittedByColumn(),
                getOmittedByNameColumn(),
                getOmittedDateColumn(),
                getOmittedTimeColumn(),
                getOrderedByColumn(),
                getOrderedByNameColumn(),
                getOrderedDateColumn(),
                getOrderedTimeColumn(),
                GetDrugSequenceNo(),
                { title: "AdministerSeq", field: "AdministerSeq", visible: false },
                { title: "Original Dose Form", field: "ORGDOSE", visible: false },

                { title: "Prescribe By Code", field: "PRESCRIBEBY", width: 120, visible:false },
                { title: "Prescribe By", field: "DOCNAME", width: 120, visible: true },
                { title: "DrugCode", field: "DrugCode", visible: false },
                {
                    title: "HighAlert", field: "HighAlert", visible: false,
                },
                { title: "TypeCode", field: "TypeCode", visible: false },
                { title: "NOTIFYN", field: "NOTIFYN", visible: false },
                { title: "STATUS", field: "STATUS", visible: false },
                { title: "ADMINYN", field: "ADMINYN", visible: false },
                { title: "MEDSTAT", field: "MEDSTAT", visible: false },
                { title: "MEDTYPE", field: "MEDTYPE", visible: false },
                { title: "ISSUEYN", field: "ISSUEYN", visible: false },
                { title: "INDENTYN", field: "INDENTYN", visible: false },
                { title: "SetNo", field: "SetNo", visible: false },
                { title: "HOLD", field: "HOLD", visible: false },
                { title: "FormCode", field: "MtrFormCode", visible: false },
                { title: "RoutCode", field: "RoutCode", visible: false },
                { title: "CALCULATEON", field: "CALCULATEON", visible: false },
                { title: "APLYTODAY", field: "APLYTODAY", visible: true },
                { title: "CycleNo", field: "CycleNo", visible: true },
                {
                    title: "Hold Log",
                    field: "HoldLog",
                    width:90,
                    formatter: LogInfo,
                    cellClick: function (e, cell) {
                        var d = cell.getData();

                        showHoldLog(d.TranNo, d.SQNumber, d.TypeCode, d.DrugCode);
                        console.log("Log info clicked for row:", cell.getData());
                    }
                }
            ],
            rowFormatter: function (row) {
                //console.log("Row formatter executed:", row.getData());
                // var loginUserID = sessionStorage.getItem('IPPatAdmnDoctCode');
                var logginUserID = ('<%:Session["gDoctCode"]%>').toString();
                const data = row.getData();
                const element = row.getElement();
                if (data.OMIT === "Y") {
                    element.style.backgroundColor = "#d4edda";
                } else {
                    element.style.backgroundColor = "";
                }

                if (data.STATUS === "C") {
                    element.style.backgroundColor = "#f8d7da";
                    //element.style.color = "#721c24";
                    element.style.textDecoration = "line-through";
                    element.style.pointerEvents = "none";
                }
                if (data.HighAlert === "Y") {
                    element.style.color = "#db0000";
                    element.style.fontWeight = "bold";
                } else {
                    element.style.color = "";
                    element.style.fontWeight = "";
                }

                let dayCell = row.getCell("DayOfDrug").getElement();
                if (data.HOLD === "Y") {
                    dayCell.style.backgroundColor = "#65e5e1cf ";
                    dayCell.style.fontWeight = "bold";
                } else {
                    dayCell.style.backgroundColor = "";
                    dayCell.style.fontWeight = "";
                }

                let cimsCell = row.getCell("CIMS").getElement();
                if (data.ADMINYN == "Y") {
                    cimsCell.style.background = "linear-gradient(to left, #ebd0b75e, #ffc837)";
                }
                else {
                    cimsCell.style.background = "";
                }
               

                let doseCell = row.getCell("Dose").getElement()
                if (data.Dose.trim() !== data.ORGDOSE.trim()) {
                    doseCell.style.backgroundColor = "#D1ECF1";
                }
                else {
                    doseCell.style.backgroundColor = "";
                }               
            }

        });

        // Added by Dhananjay 20260414 
        ChemoListtable.on('rowAdded', function (row) {
            toogleButtons(ChemoListtable, 'ChemoListtable');
        });
    }
    function canEdit(cell) {
        const loginUserID = ('<%:Session["gDoctCode"]%>').toString(); /* sessionStorage.getItem("IPPatAdmnDoctCode") */;
        const data = cell.getRow().getData();

        const field = cell.getField();

        if ([
            "DayOfDrug",
            "Type",
            "DrugName",
            "Freq",
            "AntiBoDGSTARTDATE",
            "DOCNAME",
            "OrderedByName"
        ].includes(field)) {
            return false;
        }

        return loginUserID == data.PRESCRIBEBY;
    }
    function canEditDose(cell) {
        const loginUserID = ('<%:Session["gDoctCode"]%>').toString(); /* sessionStorage.getItem("IPPatAdmnDoctCode"); */
        const data = cell.getRow().getData();

        const field = cell.getField();
        const isCalDose = data.CALCULATEON === "B" || data.CALCULATEON === "W" ? true : false;

        if (isCalDose && (loginUserID == data.PRESCRIBEBY)) {
            if ([
                "Dose"
            ].includes(field)) {
                return true;
            }
        }

    }
 
        function handleChemoOmitChange(row, isOmitted) {

            var data = row.getData();

            data.OMIT = isOmitted ? "Y" : "N";

            if (isOmitted) {
                data.OmittedBy = UserId || "";
                data.OmittedByName = gDoctName || "";
                data.OmittedDate = GetTodaysDate();
                data.OmittedTime = GetTimewithAMPM();
            }
            else {
                data.OmittedBy = "";
                data.OmittedByName = "";
                data.OmittedDate = "";
                data.OmittedTime = "";
            }

            row.update(data);
            row.reformat();
        }      
function mapChemoData(dataArray) {
    if (!dataArray) return [];
    var MedRouteList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);

    return dataArray.map(item => {
        var routeObj = MedRouteList.find(x => x.Text == item.Route);
        if (routeObj) {
            item.Route = routeObj.Text;
            item.RoutCode = routeObj.Value;
        }
        var FormObj = MedRouteList.find(x => x.FORMCODE == item.FormCode);
        if (FormObj) {
            item.Type = FormObj.FORMNAME;
            item.MtrFormCode = FormObj.FORMCODE;
        }
        return {
            // Include basic fields that don't change
            action: item.action || "",
            DayOfDrug: item.DayOfDrug || "",
            Type: item.Type || "",
            DrugName: item.DrugName || "",
            Dose: item.Dose || "",
            Route: item.Route || "",
            RoutCode: item.ROUTCODE || item.RoutCode || "",
            Freq: item.Freq || "",
            Remark: item.Remark || "",
            Diluent: item.Diluent || "",
            DrugCode: item.DrugCode || item.DRUGCD || "",
            HighAlert: item.HighAlert || "N",
            STATUS: item.STATUS || "A",
            SetNo: item.SETNO || item.SetNo || "",
            TypeCode: item.TypeCode || "",
            DilutionVolume: item.DILVOLUME || item.DilutionVolume || "",
            AdminstrDuration: item.ADMINDUR || item.AdminstrDuration || "",
            AntiBoDGSTARTDATE: item.STARTFRMDT || item.AntiBoDGSTARTDATE || "",
            OrderedBy: item.ORDERBY || item.OrderedBy || "",
            OrderedByName: item.ORDERBYNAME || item.OrderedByName || "",
            OrderedDate: item.ORDDATE || item.OrderedDate || "",
            OrderedTime: item.ORDTIME || item.OrderedTime || "",
            DOCNAME: item.DOCNAME || "",
            PRESCRIBEBY: item.PRESCRIBEBY || "",
            CALCULATEON: item.CALCULATEON || "",
            SQNumber: item.SQNumber || item.SEQNO || "",
            NOTIFYN: item.NOTIFYN || "",
            ADMINYN: item.ADMINYN || "",
            MEDSTAT: item.MEDSTAT || "",
            MEDTYPE: item.MEDTYPE || "",
            ISSUEYN: item.ISSUEYN || "",
            INDENTYN: item.INDENTYN || "",
            Duration: item.Duration || "" || item.DURATION,
            HOLD: item.HOLDYN || item.HOLD || item.Hold || "",
            OmittedBy: item.OMITBY || item.OmittedBy || "",
            OmittedByName: item.OMITBYNAME || item.OmittedByName || "",
            OmittedDate: item.OMITDT || item.OmittedDate || "",
            OmittedTime: item.OMITTM || item.OmittedTime || "",
            OMIT: (item.OMIT === "Y") ? "Y" : "N",
            ORGDOSE: item.ORGDOSE || "",
            AdministerSeq: item.AdministerSeq || item.CHADMINSEQ || item.ADMINSEQNO || "",
            MtrFormCode: item.DRUGFROMCD || item.FormCode || item.MtrFormCode || "", 
            APLYTODAY: item.APLYTODAY || item.APPLYTODAY || "",
            CycleNo: item.CycleNo || item.CYCLENO || "",
            ENDDATE: item.ENDDATE || "",
            isFromServer: true
        };
    });
}
    function BindChemoData(jsonChemoAData) {
        if (ChemoListtable) {

            const mappedData = mapChemoData(jsonChemoAData);
            ChemoListtable.setData(mappedData);
        }
    }
    function ProcessChemoData() {
        const container = $("#commonPopupBody");
        const clinical = window.PatientClinicalData || {};

        var params = {
            strPrtocolCD: container.find("#ddlProtocol").val(),
            MRNO: sessionStorage.getItem('IPPatMRNO'),
            HEIGHT: clinical.height || $("#txtHeight").val() || "",
            WEIGHT: clinical.weight || $("#txtWeight").val() || "",
            BSA: clinical.bsa || $("#txtBSA").val() || "",
            DayNo: container.find("#txtDayField").val() || "",
            STARTDATE: container.find("#txtStartDate").val() || "",
            calcDose: true,
            CycleNo: container.find("#txtCurrentCycle").val() || "",
        };
        $.ajax({
            type: "GET",
            url: "../SinglePage/BindChemoData",
            data: params,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response && response.DilutionY && response.DilutionY.length > 0) {
                    var MedRouteList = FormLinkRouteList == "" || FormLinkRouteList == "null" ? [] : JSON.parse(FormLinkRouteList);
                    // 1. Process the data to set default values for OMIT columns
                    const initializedData = response.DilutionY.map(item => {
                        var routeObj = MedRouteList.find(x => x.Text.trim() == item.Route.trim());
                        if (routeObj) {
                            item.Route = routeObj.Text;
                            // item.ROUTCODE = routeObj.Value;
                            item.RoutCode = routeObj.Value;
                        }
                        var FormObj = MedRouteList.find(x => x.FORMCODE == item.Type);
                        if (FormObj) {
                            // item.DRUGFROMCD = FormObj.FORMCODE;
                            item.MtrFormCode = FormObj.FORMCODE;
                            item.Type = FormObj.FORMNAME;
                        }
                        return {
                            ...item,
                            OrderedByName: gDoctName,
                            // If OMIT is null/empty, set to "N", otherwise keep server value
                            OMIT: (item.OMIT === "Y") ? "Y" : "N",

                            // Initialize hidden fields as empty strings if they don't exist
                            OmittedBy: item.OmittedBy || "",
                            OmittedByName: gDoctName,
                            OmittedDate: item.OmittedDate || "",
                            OmittedTime: item.OmittedTime || ""

                        };
                    });

                    // 2. Bind the processed data to Tabulator
                    //  ChemoListtable.setData(initializedData);

                    //ChemoListtable.addData(initializedData, false);
                    
                    const existingData = ChemoListtable.getData();

                    const currentCycle = String(
                        $("#commonPopupBody").find("#txtCurrentCycle").val() || ""
                    ).trim();

                    const currentDay = String(
                        $("#commonPopupBody").find("#txtDayField").val() || ""
                    ).trim();

                    const serverDate = String(ServerDate || "").trim();
                    const alreadyExists = existingData.some(function (row) {
                        return String(row.AntiBoDGSTARTDATE || "").trim() === serverDate   
                    });

                    if (alreadyExists) {
                        ToastMsg(
                            `Medicines for Cycle ${currentCycle}, and for dates ${serverDate} are already present.`,
                            "warning"
                        );
                        return;
                    }

                    // const cycleDayExists = existingData.some(function (row) {
                    //     return String(row.CycleNo || "").trim() === currentCycle &&
                    //         String(row.APLYTODAY || "").trim() === currentDay;
                    // });

                    // if (cycleDayExists) {
                    //     ToastMsg(
                    //         `Cycle ${currentCycle} and Day ${currentDay} already exist in the table. Cannot add again.`,
                    //         "warning"
                    //     );
                    //     return;
                    // }

                    const newData = initializedData.map(function (item) {
                        return {
                            ...item,
                            CycleNo: currentCycle,
                            APLYTODAY: currentDay
                        };
                    });

                    if (newData.length > 0) {
                        ChemoListtable.addData(newData, false);

                        isChemoContinuePending = true;
                    } else {
                        return;
                    }

                    // 3. Close Modal
                    var modalElement = document.getElementById('commonPopupModal');
                    var modal = bootstrap.Modal.getInstance(modalElement);
                    if (modal) {
                        modal.hide();
                    }

                    toogleButtons(ChemoListtable, 'ChemoListtable');
                    ToastMsg("Data Loaded Successfully", "success");
                    $("#ProtocolInfoSection").show();
                    $("#chemoPlanNo").show();
                    $("#txtCPlanNo").text($("#commonPopupBody").find("#txtPlanNo").val());
/*                    $("#txtCPlanDate").text($("#commonPopupBody").find("#txtStartDate").val());*/
                    $("#txtCCourse").text($("#commonPopupBody").find("#txtCourse").val());
                    $("#txtTotalPlannedCycle").text($("#commonPopupBody").find("#txtTotalCycles").val());
                    $("#txtCCurrentCycle").text($("#commonPopupBody").find("#txtCurrentCycle").val());
                    $("#txtProtocolStartDate").text($("#commonPopupBody").find("#txtStartDate").val());
                    $("#txtProtocolName").text($("#commonPopupBody").find("#ProtocolNM").text());
                } else {
                    ToastMsg("No data found for this protocol", "warning");
                    //ChemoListtable.setData([]);
                }
            },
            error: function (err) {
                ToastMsg("Error: Could not retrieve chemo data.", "error");
            }
        });
    }

    //$(document).ready(function () {
    //    TabulatorGetChemo();
    //    $("#btnChemoMed").click(function () {
    //        var chemoContent = $("#ChemoProtocolTemplate").html();
    //        $("#commonPopupBody").html(chemoContent);
    //        $("#commonPopupTitle").text("Chemo Protocol Details");
    //        var myModal = new bootstrap.Modal(document.getElementById('commonPopupModal'));
    //        myModal.show();
    //        GetProtocolCode();
    //    });
    //    GetTranslstData();
    //    //GetTreatmentSheetData($("#tractiondropdown").val(), "", sessionStorage.getItem('IPPatIPNO'));
    //});
    $(document).ready(function () {
        TabulatorGetChemo();
        $("#btnChemoMed").click(function () {
            var chemoContent = $("#ChemoProtocolTemplate").html();
            $("#commonPopupBody").empty().html(chemoContent);
            $("#commonPopupTitle").text("Chemo Protocol Details");
            var myModal = new bootstrap.Modal(document.getElementById('commonPopupModal'));
            myModal.show();
            var rowCountChemo = ChemoListtable.getRows().length;
            var IpNo = sessionStorage.getItem('IPPatIPNO');
            var TranctionId = $('#tractiondropdown').val();
            var PlanID = window.CurrentPlanID;
            // if (gact === "E" && PlanID && rowCountChemo > 0) {
            //     GetTreatmentSheetData(TranctionId, '', IpNo);
            // } else {
            CheckChemoContinueButton();
                GetProtocolCode();
            //}

        });
        GetTranslstData();
        GetTreatmentSheetData($("#tractiondropdown").val(), "", sessionStorage.getItem('IPPatIPNO'));
    });
function CheckChemoContinueButton() {
    var btnContinue = $("#commonPopupBody").find("#btnSaveChemo");
    var chemoTabLength = ChemoListtable.getData().length;
    // if (isChemoContinuePending && chemoTabLength == 0 ) {
    //     btnContinue.show();
    // }
    // else
    if (isChemoContinuePending)
    { 
        btnContinue.hide();
    }
    else {
        btnContinue.show();
    }
}
// function CheckChemoStartDate() {

//     var rows = ChemoListtable.getData();
//     var serverDate = String(ServerDate || "").trim();

//     var isDateMatched = rows.some(function (row) {
//         return String(row.AntiBoDGSTARTDATE || "").trim() === serverDate ;
//     });

//     if (isDateMatched) {
//         $("#commonPopupBody").find("#btnSaveChemo").hide();
//     } else {
//         $("#commonPopupBody").find("#btnSaveChemo").show();
//     }
// }
    function formatDate(str) {
        if (!str || str.length !== 8) return str;
        return `${str.substring(6, 8)}/${str.substring(4, 6)}/${str.substring(0, 4)}`;
    }

    function GetProtocolCode() {
        var MRNO = sessionStorage.getItem('IPPatMRNO');/*"RH125001415";*/ // $("#txtstrUMrNo").val();
        var datatosend = { MRNO: MRNO };
        $.ajax({
            url: '../SinglePage/GetProtocolCode',
            type: 'GET',
            dataType: 'json',
            data: datatosend,
            success: function (response) {
                if (response && response.rows && response.rows.length > 0) {
                    bindProtocolData(response);
                } else {
                    ToastMsg("No Protocol found for this Patient", "warning");
                }
            },
            error: function (xhr, status, error) {
                ToastMsg(error, "error");
            }
        });
    }

   //function bindProtocolData(data) {
   //    if (data.rows && data.rows.length > 0) {
   //        const item = data.rows[0];
   //        const container = $("#commonPopupBody");
   //        container.find('#ddlProtocol').html(`<option value="${item.CODE}">${item.PROTONAME}</option>`);
   //        container.find('#txtPlanNo').val(item.PlanID);
   //        container.find('#txtPlanDate').val(formatDate(item.PlanDate));
   //        container.find('#txtCourse').val(item.COURSENM);
   //        container.find('#txtTotalCycles').val(item.TotalCycle);
   //        container.find('#txtCurrentCycle').val(item.CycleNo);
   //        container.find('#txtStartDate').val(formatDate(item.STARTDATE));
   //        container.find('#txtDayField').val(item.DAY);
   //        container.find('#txtProtocoltye').val(item.PROTOCOLTYPE);
   //        container.find('#chemoData').val(item.MODIFICATION);
   //        container.find('#ProtocolNM').text(item.PROTONAME); //Pournima 15th June 2026
   //        container.find('#txtProtocolCode').val(item.CODE);
   //        $("#txtProtocolName").text(item.PROTONAME);
   //    }
   //}
    function bindProtocolData(data) {
        if (data.rows && data.rows.length > 0) {

            //currentProtocol = data.rows[0]   

            const item = data.rows[0];
            const container = $("#commonPopupBody");
          
            CurrentPlan = {
                PlanID: item.PlanID,
                PlanDate: formatDate(item.PlanDate),
                TotCycleNo: item.TotalCycle,
                CycleNo: item.CycleNo,
                ProtocolData: item.MODIFICATION,
                ProtocolID: item.CODE,
                DayofCycle: item.DAY,
                ProtocolType: item.PROTOCOLTYPE,
                COURSENM: item.COURSENM,
                STARTDATE: formatDate(item.STARTDATE)
            };
            container.find('#ddlProtocol').html(`<option value="${item.CODE}">${item.PROTONAME}</option>`);
            container.find('#txtPlanNo').val(item.PlanID);
            container.find('#txtPlanDate').val(formatDate(item.PlanDate));
            container.find('#txtCourse').val(item.COURSENM);
            container.find('#txtTotalCycles').val(item.TotalCycle);
            container.find('#txtCurrentCycle').val(item.CycleNo);
            container.find('#txtStartDate').val(formatDate(item.STARTDATE));
            container.find('#txtDayField').val(item.DAY);
            container.find('#txtProtocoltye').val(item.PROTOCOLTYPE);
            container.find('#chemoData').val(item.MODIFICATION);
            container.find('#ProtocolNM').text(item.PROTONAME); //Pournima 15th June 2026
            container.find('#txtProtocolCode').val(item.CODE);
          
          /*  $("#txtProtocolName").text(item.PROTONAME);*/
           
        }
    }
</script>

<%-- Nutrition Intake --%>
<script type="text/javascript">

    function BindNutritionData(dataList) {
        console.log("Length:", dataList.length);
        const $container = $('#NutriContainer');
        $container.empty();

        let allRowsHtml = '';
        dataList.forEach((item, index) => {
            // We pass 'true' to tell the function to just return the string
            allRowsHtml += addNutriRow(item, null, true);
        });

        $container.append(allRowsHtml);
    }

    function addNutriRow(data = null, providedId = null, returnStringOnly = false) {
        // 1. Generate ID if not provided
        var uniqueId = providedId || "nutri_" + Date.now() + "_" + Math.random().toString(36).substr(2, 5);

        let NutriList = [];
        try {
            NutriList = (typeof NutritionList === "string") ? JSON.parse(NutritionList) : NutritionList;
        } catch (e) {
            console.error("Error parsing NutritionList", e);
        }

        var selectHtml = `<select id="ddlNutri_${uniqueId}" class="form-select form-select-sm nutri-dropdown Nutri-Input">`;
        selectHtml += `<option value="">---Select---</option>`;

        NutriList.forEach(opt => {
            var isSelected = (data && (data.NUTRIINTAKE == opt.Value || data.NUTRIINTAKE == opt.Text)) ? "selected" : "";
            selectHtml += `<option value="${opt.Value}" ${isSelected}>${opt.Text}</option>`;
        });
        selectHtml += `</select>`;

        var html = `
    <div class="referral-row nutrit-row border rounded p-2 mb-2 bg-white shadow-sm" data-id="${uniqueId}">
        <div class="row gx-2 align-items-end">
            <div class="col-md-3">
                <label class="small fw-bold mb-1 text-muted">Nutrition / Intake</label>
                ${selectHtml}
            </div>
            <div class="col-md-7">
                <label class="small fw-bold mb-1 text-muted">Volume / Supplements</label>
                <textarea class="form-control form-control-sm VolSuppl-textarea Nutri-Input" rows="1" style="resize: none;">${data ? data.VOLSUP : ""}</textarea>
            </div>
            <div class="col-md-1 text-end">
                <button type="button" class="btn btn-outline-danger btn-sm btnRemoveReferral" title="Delete">
                    <i class="fa fa-trash"></i>
                </button>
<button type="button" class="btn btn-outline-warning btn-sm btnCancelReferral" title="Cancel Referral" style="display:none;">
    <i class="fa fa-ban"></i>
</button>
            </div>
        </div>
    </div>`;

        // 2. Logic to either return the string or append it directly
        if (returnStringOnly) {
            return html;
        } else {
            var $row = $(html);
            $('#NutriContainer').append($row);
            //toggleDeleteButton($row);
        }
    }

    function getNutritionData() {
        var NutritionArray = [];
        var date = GetToday_DDMMYYYY();
        var time = GetTimewithAMPM();
        $('#NutriContainer .referral-row').each(function (index, element) {
            var $row = $(element);
            var val = $row.find('.nutri-dropdown').val();
            if (val !== "----select----") {
                NutritionArray.push({
                    //"NUTRIINTAKE": $row.find('.nutri-dropdown option:selected').text(),
                    "NUTRIINTAKE": $row.find('.nutri-dropdown option:selected').val(),
                    "VOLSUP": $row.find('.VolSuppl-textarea').val() || "",
                    "CREATEDBY": "",
                    "CREATEDON": date,
                    "CREATEDAT": time,
                });
            }
        });
        return NutritionArray;
    }
</script>

<div id="sec-TreatmentOrder" class="opd-section-card anchor-offset">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="section-title mb-0">Treatment Order</h4>
        <div class="d-flex align-items-center">

                        <div class="legendItem me-3" id="divRollOverLegend"> <%--Abhishesh || 20261006--%>
                <span class="legendColor rollOverData"></span>
                <label class="mb-0">RollOver Data</label>
            </div>
        <div id="divInnerHeader" style="background: #f8f9fa; padding: 10px; border-radius: 5px; border: 1px solid #dee2e6;">
            <table>
                <tr>

                    <td>
                        <div class="input-group input-group-sm ms-2">
                            <span class="input-group-text" id="lblTrn">PRN No:</span>
                            <select name="dropdown" id="tractiondropdown" onchange="RetriveTreatmentData(this,'N')" class="form-select" style="width: auto" disabled="disabled"></select> <%--Abhishesh || 20261006--%>
                        </div>
                    </td>
                    <td>
                        <div class="input-group input-group-sm ms-2">
                            <span class="input-group-text" id="lblDate">Date:</span>
                            <%: Html.TextBoxFor(x => Model.TreatmntSheetTranDt, new { id = "txtTransDate", @class = "form-control form-control-sm", Style = "width:100px;" ,maxlength="100",@readonly="True",@disabled="true"})%>
                        </div>
                    </td>
                    <td>
                        <div class="input-group input-group-sm ms-2">
                            <span class="input-group-text" id="lblTime">Time:</span>
                            <%: Html.TextBoxFor(x => Model.TreatmntSheetTranTm, new { id = "txtTransTime", @class = "form-control form-control-sm", Style = "width:70px;" ,maxlength="100" , @readonly="True",@disabled="true"})%>
                            <button type="button"
                                id="btnMainRollOver"
                                class="btn btn-sm btn-outline-primary ms-2">
                                <i class="fa fa-undo"></i>Rollover
       
                            </button>
                            <input type="hidden" id="time" />
                        </div>
                    </td>
                    <td>
                            <label style=" margin-left: 3px;" class="d-none" id="lblRoll" >Rollover Date:</label>
                            <input class="TextBxFormat d-none" id="txtRollverDate" style="width: 100px;"  type="text" value="" readonly="readonly">
                        </td>
                    <%--<td>
                        <button id="btnRollOver" class="btn btn-sm btn-outline-secondary d-none" title="Rollover last entry">
                            <i class="fa fa-undo" aria-hidden="true"></i>Rollover
                        </button>
                    </td>--%>
                </tr>
            </table>
        </div>
        </div>
    </div>

    <%-- Investigations --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Investigation</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="InvstgSearch" class="form-control" placeholder="Search In" oninput="FilterBindedSearchListForInvstg()">
                        <button id="btnRollOverInvestigation" class="btn btn-sm btn-outline-secondary btnRollOver d-none" data-tabtype="Investigation" title="Rollover last entry">
    <i class="fa fa-undo"></i>Rollover
</button>
<%--                <button class="btn btn-outline-success" id="Invstg_PrevHistory" onclick="HistoryPopupOpen('Invstg History', 'Invstg')"><i class="fa fa-history"></i></button>--%>
            </div>
            <div id="InvstgListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="InvstgList" class="list-group w-100"></div>
                <div id='loading-Invstg-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="InvstgTable" style="margin: 10px 0px;"></div>
    <hr class="my-3">

    <%-- Medicine --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Medication with Volume/Dilution as reffered by EMR</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="MedicineSearch" class="form-control" placeholder="Search In" oninput="FilterBindedSearchListForMedicine()">
                 <button class="btn btn-outline-success" id="img_srch" onclick="AddNewDrug('Medicine')"><i class="fa fa-plus"></i></button>  <%--//added by aaryshree 202606025--%>
                <button id="btnRollOverAntibiotic" class="btn btn-sm btn-outline-secondary btnRollOver d-none" data-tabtype="Antibiotic" title="Rollover last entry">
                    <i class="fa fa-undo"></i>Rollover
                </button>
<%--                <button class="btn btn-outline-success" id="Medicine_PrevHistory" onclick="HistoryPopupOpen('Medicine History', 'Medicine')"><i class="fa fa-history"></i></button>--%>

               
               <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("I")) { %>

                <button class="btn btn-outline-success" id="btnInformantMedicine" title="Drug Interaction" style="float: right; margin-left: 5px; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('I',TrmtntOrderMedicineTable,'TrmtntOrderMedicineTable')">
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

                <button class="btn btn-outline-success" id="btnDuplicateMedicine" title="Drug Duplicate" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('D',TrmtntOrderMedicineTable,'TrmtntOrderMedicineTable')">
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

                <button class="btn btn-outline-success" id="btnAllergyMedicine" title="Drug Allergy" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('A',TrmtntOrderMedicineTable,'TrmtntOrderMedicineTable')">
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
            <div id="MedicineListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div class="w-100 SearchHeaderMainDiv" style="display: flex;">
                    <div class="list-group-LHead w-50 HeaderSearchList HeaderSearchList-Border">Material Name</div>
                    <div class="list-group-RHead w-50 HeaderSearchList">Generic Name</div>
                </div>
                <div id="MedicineList" class="list-group w-100"></div>
                <div id='loading-Medicine-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="TrmtntOrderMedicineTable"></div>
    <div class="sticky-footer">
        <div class="IndicatorDiv">

            <div class="imgdiv">
                <img src="../Images/pills.png" alt="Indented" class="indentIconImage" />
                <label class="lblinfo2">Indented</label>
            </div>

            <div class="imgdivIss">
                <img src="../Images/Check.png" alt="Issued" class="issuedIconImage" style="width: 21px" />
                <label class="lblinfo1">Issued</label>
            </div>

            <!-- Planned -->
            <div class="legendItem">
                <span class="legendColor planned"></span>
                <label>Planned</label>
            </div>
            <!-- Planned & Omitted -->
            <div class="legendItem">
                <span class="legendColor plannedOmitted"></span>
                <label>Planned & Omitted</label>
            </div>
            <!-- Hold -->
            <div class="legendItem">
                <span class="legendColor hold"></span>
                <label>Hold</label>
            </div>

            <!-- Omitted -->
            <div class="legendItem">
                <span class="legendColor omitted"></span>
                <label>Omitted</label>
            </div>

            <!-- Cancelled -->
            <div class="legendItem">
                <span class="legendColor cancelled"></span>
                <label>Cancelled</label>
            </div>

            <!-- Administered -->
            <div class="legendItem">
                <span class="legendColor administered"></span>
                <label>Administered</label>
            </div>
            <div class="legendItem">
                <span class="legendColor statsosMed"></span>
                <label>STAT/SOS Orders</label>
            </div>
        </div>
    </div>

    <!-- Popup Overlay -->
    <div class="dose-popup-overlay" id="dosePopupOverlay" style="display: none;">
        <!-- Popup Container -->
        <div class="dose-popup">
            <fieldset class="dose-fieldset">
                <legend class="dose-title">Add Multiple Dose</legend>

                <!-- Medicine Info -->
                <div class="dose-medicine-info">
                    <label id="DSMedicineName" class="dose-medicine-name"></label>
                    <label id="DSMedicineCode" class="dose-hide"></label>
                    <label id="DSGenericName" class="dose-hide"></label>
                    <label id="DSBrandName" class="dose-hide"></label>
                    <label id="DSFormName" class="dose-hide"></label>
                    <label id="DSFormCode" class="dose-hide"></label>
                    <label id="DSIsFromNew" class="dose-hide"></label>
                    <label id="DSHighAlt" class="dose-hide"></label>
                </div>

                <!-- Frequency & Unit -->
                <div class="dose-row">
                    <label class="dose-label">Frequency:</label>
                    <select id="cmbFrequency" class="dose-select" onchange="CallIntakeFreqChange(this)">
                        <option value="OD">OD</option>
                        <option value="BD">BD</option>
                        <option value="TDS">TDS</option>
                        <option value="QID">QID</option>
                        <option value="Q2H">Q2H</option>
                        <option value="Q4H">Q4H</option>
                        <option value="Q8H">Q8H</option>
                        <option value="Q12H">Q12H</option>
                        <option value="HS">HS</option>
                        <option value="SOS">SOS</option>
                        <option value="STAT">STAT</option>
                        <option value="Other">Other</option>
                    </select>

                    <label class="dose-label">Drug Unit:</label>
                    <select id="cmbUnit" class="dose-select">
                        <option value="">---Select---</option>
                        <option value="CM">CM</option>
                        <option value="CC">CC</option>
                        <option value="G">G</option>
                        <option value="KCAL">KCAL</option>
                        <option value="KG">KG</option>
                        <option value="L">L</option>
                        <option value="MG">MG</option>
                        <option value="ML">ML</option>
                        <option value="MM">MM</option>
                        <option value="MMOL">MMOL</option>
                        <option value="MEQ">MEQ</option>
                        <option value="MCG">MCG</option>
                        <option value="OZ">OZ</option>
                        <option value="IU">IU</option>
                        <option value="TAB">TAB</option>
                        <option value="AMP">AMP</option>
                        <option value="TBLSP">TBLSP</option>
                        <option value="TSP">TSP</option>
                        <option value="RESP">RESP</option>
                        <option value="QS">QS</option>
                    </select>
                </div>

                <!-- Quick Dose Buttons -->
                <div class="btn-group dose-buttons" style="display:none;">
                    <button type="button" class="active btn btn-default dose-btn" id="btn15" value="0.1">0.1</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn0" value="0.25">0.25</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn12" value="0.025">0.025</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn1" value="0.5">0.5</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn2" value="1">1</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn13" value="2">2</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn14" value="3">3</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn3" value="5">5</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn4" value="10">10</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn5" value="30">30</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn6" value="50">50</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn7" value="100">100</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn8" value="200">200</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn9" value="500">500</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn10" value="1000">1000</button>
                    <button type="button" class="btn btn-default dose-btn" id="btn11" value="2000">2000</button>

                </div>

                <!-- Intake Controls -->
                <div class="dose-intake-controls">
                    <span class="icon-btn" id="cadd" onclick="AddIntakeSpan()"><i class="fa fa-plus-circle"></i></span>
                    <span class="icon-btn" id="cminus" onclick="RemoveIntakeSpan()"><i class="fa fa-minus-circle"></i></span>
                    <div id="btnCalulatedIntaKe" class="dose-intake-display"></div>
                </div>

                <!-- Action Buttons -->
                <div class="dose-actions">
                    <button id="btnAddDose" class="action-btn primary" onclick="DoseCombination()">OK</button>
                    <button id="btnCancelDose" class="action-btn secondary" onclick="closeDosePopup()">Cancel</button>
                    <button id="btnClear" class="action-btn danger" onclick="ClearDose()">Clear Dose</button>
                </div>
            </fieldset>
        </div>
    </div>

    <div id="DivTempMultipleDose" style="display: none">
        <table id="TblMultipleDose">
            <tbody>
            </tbody>
        </table>
    </div>

    <hr class="my-3">
        <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Medication</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="MedicationSearch" class="form-control" placeholder="Search In" oninput="FilterBindedSearchListForMedication()">
                <button class="btn btn-outline-success" id="" onclick="AddNewDrug('Medication')"><i class="fa fa-plus"></i></button> <%--added by aaryshree 20260625--%>
                <button id="btnRollOverMedication" class="btn btn-sm btn-outline-secondary btnRollOver d-none" data-tabtype="Medication" title="Rollover last entry">
                    <i class="fa fa-undo"></i>Rollover
                </button>
<%--                <button class="btn btn-outline-success" id="Medication_PrevHistory" onclick="HistoryPopupOpen('Medicine History', 'Medication')"><i class="fa fa-history"></i></button>--%>
                
               <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("I")) { %>

                <button class="btn btn-outline-success" id="btnInformantMedication" title="Drug Interaction" style="float: right; margin-left: 5px; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('I',TrmtntOrderMedicationTable,'TrmtntOrderMedicationTable')">
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

                <button class="btn btn-outline-success" id="btnDuplicateMedication" title="Drug Duplicate" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('D',TrmtntOrderMedicationTable,'TrmtntOrderMedicationTable')">
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

                <button class="btn btn-outline-success" id="btnAllergyMedication" title="Drug Allergy" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('A',TrmtntOrderMedicationTable,'TrmtntOrderMedicationTable')">
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
                </button>'

               <% } %>

            </div>
            <div id="MedicationListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div class="w-100 SearchHeaderMainDiv" style="display: flex;">
                    <div class="list-group-LHead w-50 HeaderSearchList HeaderSearchList-Border">Material Name</div>
                    <div class="list-group-RHead w-50 HeaderSearchList">Generic Name</div>
                </div>
                <div id="MedicationList" class="list-group w-100"></div>
                <div id='loading-Medication-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="TrmtntOrderMedicationTable"></div>
    <div class="sticky-footer">
        <div class="IndicatorDiv">

            <div class="imgdiv">
                <img src="../Images/pills.png" alt="Indented" class="indentIconImage" />
                <label class="lblinfo2">Indented</label>
            </div>

            <div class="imgdivIss">
                <img src="../Images/Check.png" alt="Issued" class="issuedIconImage" style="width: 21px" />
                <label class="lblinfo1">Issued</label>
            </div>

            <!-- Planned -->
            <div class="legendItem">
                <span class="legendColor planned"></span>
                <label>Planned</label>
            </div>
            <!-- Planned & Omitted -->
            <div class="legendItem">
                <span class="legendColor plannedOmitted"></span>
                <label>Planned & Omitted</label>
            </div>
            <!-- Hold -->
            <div class="legendItem">
                <span class="legendColor hold"></span>
                <label>Hold</label>
            </div>

            <!-- Omitted -->
            <div class="legendItem">
                <span class="legendColor omitted"></span>
                <label>Omitted</label>
            </div>

            <!-- Cancelled -->
            <div class="legendItem">
                <span class="legendColor cancelled"></span>
                <label>Cancelled</label>
            </div>

            <!-- Administered -->
            <div class="legendItem">
                <span class="legendColor administered"></span>
                <label>Administered</label>
            </div>
            <div class="legendItem">
                <span class="legendColor statsosMed"></span>
                <label>STAT/SOS Orders</label>
            </div>
        </div>
    </div>
     <hr class="my-3">
    <%-- Chemo --%> 
    <div class="d-flex justify-content-between mb-2 align-items-start">
        <h6 class="fw-bold">Chemo</h6>
        <div class="flex-grow-1 position-relative ms-4">
            <div class="input-group input-group-sm w-100">
                
                <input type="text" id="ChemoSearch" class="form-control" placeholder="Search In" oninput="FilterBindedSearchListForChemo()" style="visibility: collapse">
                <%-- <button class="btn btn-outline-success" id="btnChemoMed"><i class="fa fa-plus"></i></button>--%>
                <div class="d-flex align-items-center me-3 ">

                    <div class="me-4" id="chemoPlanNo">
                        <label class="fw-bold">Plan No :</label>
                        <span id="txtCPlanNo" class="ms-1"></span>
                    </div>

<%--                    <div class="me-3" id="chemoPlanDt">
                        <label class="fw-bold">Plan Date :</label>
                        <span id="txtCPlanDate" class="ms-1"></span>
                    </div>--%>

                </div>
                <button type="button" class="btn btn-save-draft btn-sm me-2" id="btnChemoMed">Chemo Medication</button>
<%--                <button class="btn btn-outline-success" onclick="HistoryPopupOpen('Chemo History', 'Chemo')"><i class="fa fa-history"></i></button>--%>
               
               <% if(@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CIMS_VISIBLE_ICONS").Contains("I")) { %>
                
                <button class="btn btn-outline-success" id="btnInformantChemo" title="Drug Interaction" style="float: right; margin-left: 5px; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('I',ChemoListtable,'ChemoListtable')">
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

                <button class="btn btn-outline-success" id="btnDuplicateChemo" title="Drug Duplicate" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('D',ChemoListtable,'ChemoListtable')">
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

                <button class="btn btn-outline-success" id="btnAllergyChemo" title="Drug Allergy" style="float: right; margin-right: 6px; display: none; padding: 5px;background:none !important;" onclick="subscribeCIMSServices('A',ChemoListtable,'ChemoListtable')">
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
            <div id="ChemoListMainDiv" class="list-group position-absolute w-100" style="z-index: 1050; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="ChemoList" class="list-group w-100"></div>
            </div>
        </div>
    </div>

    <div class="card border mb-2" id="ProtocolInfoSection">
        <div class="card-body py-2">

            <div class="row mb-2">
                <div class="col-md-12">
                    <label class="fw-bold">Protocol Name :</label>
                    <span id="txtProtocolName" class="ms-2 fw-semibold"></span>
                </div>
            </div>

            <div class="row">

                <div class="col-md-2">
                    <label class="fw-bold">Course :</label>
                    <span id="txtCCourse" class="ms-1"></span>
                </div>

                <div class="col-md-2">
                    <label class="fw-bold">Total Planned Cycle(s) :</label>
                    <span id="txtTotalPlannedCycle" class="ms-1"></span>
                </div>

                <div class="col-md-2">
                    <label class="fw-bold">Current Cycle :</label>
                    <span id="txtCCurrentCycle" class="ms-1"></span>
                </div>

                <div class="col-md-2">
                    <label class="fw-bold">Start Date :</label>
                    <span id="txtProtocolStartDate" class="ms-1"></span>
                </div>

            </div>

        </div>
    </div>

    <div id="ChemoTable"></div>


    <div class="sticky-footer">
        <div class="IndicatorDiv">
            <div class="imgdiv">
                <img src="../Images/pills.png" alt="Indented" class="indentIconImage" />
                <label class="lblinfo2">Indented</label>
            </div>
            <div class="imgdivIss">
                <img src="../Images/Check.png" alt="Issued" class="issuedIconImage" style="width: 21px" />
                <label class="lblinfo1">Issued</label>
            </div>
            <!-- Hold -->
            <div class="legendItem">
                <span class="legendColor hold"></span>
                <label>Hold</label>
            </div>

            <!-- Omitted -->
            <div class="legendItem">
                <span class="legendColor omitted"></span>
                <label>Omitted</label>
            </div>

            <!-- Cancelled -->
            <div class="legendItem">
                <span class="legendColor cancelled"></span>
                <label>Cancelled</label>
            </div>

            <!-- Administered -->
            <div class="legendItem">
                <span class="legendColor administered"></span>
                <label>Administered</label>
            </div>
        </div>
    </div>

    <div id="ChemoProtocolTemplate" style="display: none;">
        <div class="container-fluid py-3 border rounded" style="background-color: #f8f9fa;">
            <div class=" mb-2"> <%-- Pournima 15th June 2026--%>
                <label class="fw-bold small">Protocol : </label>
                <label class="fw-bold small" id="ProtocolNM"></label>
            </div>
            <div class="row mb-3 g-2 align-items-center">   <%-- Pournima commented on 15th June 2026--%>
                <div class="col-md-auto"> <%--  ms-auto--%>
                    <label class="fw-bold small">Plan&nbsp;No.</label>
                </div>
                <div class="col-md-auto">
                    <input type="text" id="txtPlanNo" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="col-md-auto">
                    <label class="fw-bold small">Plan&nbsp;Date</label>
                </div>
                <div class="col-md-2">
                    <input type="text" id="txtPlanDate" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="d-none">  <%-- Pournima added on 15th June 2026--%>
                    <label class="fw-bold small">Protocol:</label>
                </div>
                <div class="d-none">
                    <%-- Pournima added on 15th June 2026--%>
                    <label class="fw-bold small">Protocol Code:</label>
                    <input type="text" id="txtProtocolCode" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <%--<div class="d-none">
                    <select class="form-select form-select-sm border-start border-danger border-3" id="ddlProtocol">
                    </select>
                </div>--%>
                <div class="d-none"> <%= Html.DropDownListFor(x => x.ProtocolID, new SelectList(Model.ChemoTemplateLst, "Value", "Text"), "---Select---",
               new { 
                  @id = "ddlProtocol",
                 @class = "form-select form-select-sm border-start border-danger border-3"
                })
                    %>
                </div>
            </div>

            <div class="row mb-4 g-2 align-items-center">
                <div class="col-md-auto">
                    <label class="fw-bold small">Course</label>
                </div>
                <div class="col-md-1">
                    <input type="text" id="txtCourse" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="col-md-auto ms-auto">
                    <label class="fw-bold small">Total Planned Cycle(s)</label>
                </div>
                <div class="col-md-1">
                    <input type="text" id="txtTotalCycles" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="col-md-auto">
                    <label class="fw-bold small">Current Cycle</label>
                </div>
                <div class="col-md-1">
                    <input type="text" id="txtCurrentCycle" class="form-control form-control-sm text-center fw-bold" readonly style="background-color: #ffff00;">
                </div>
                <div class="col-md-auto">
                    <label class="fw-bold small">Start Date</label>
                </div>
                <div class="col-md-2">
                    <input type="text" id="txtStartDate" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="col-md-auto" <%--style="display: none"--%>>
                    <label class="fw-bold small">Current Day</label>
                </div>
                <div class="col-md-2" <%--style="display: none"--%>>
                    <input type="text" id="txtDayField" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="col-md-auto" style="display: none">
                    <label class="fw-bold small">ProtocolType</label>
                </div>
                <div class="col-md-2" style="display: none">
                    <input type="text" id="txtProtocoltye" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="col-md-auto" style="display: none">
                    <label class="fw-bold small">Protocol Data</label>
                </div>
                <div class="col-md-2" style="display: none">
                    <input type="text" id="chemoData" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
            </div>
            <div class="row">
                <div class="col-12 text-center">
                    <button type="button" id="btnSaveChemo" class="btn text-white" style="background-color: #ff5722; border-radius: 8px;" onclick="ProcessChemoData();">Continue</button>
                </div>
            </div>
        </div>
    </div>
    <hr class="my-3">

    <div id="HiddenFields" style="display: none">
        <input type="text" id="txtstrUIPNo" />
        <input type="text" id="txtstrUAdmDtTm" />
        <input type="text" id="txtstrPatName" />
    </div>
    <%-- Infusion --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Infusion</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100" style="display: flex;flex-direction: row-reverse;">
            <button id="btnRollOverInfusion" class="btn btn-sm btn-outline-secondary btnRollOver  d-none" data-tabtype="Infusion" title="Rollover last entry">
                <i class="fa fa-undo"></i>Rollover
            </button>
            </div>
            <div id="InfusionListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="InfusionList" class="list-group w-100"></div>
                <div id='loading-Infusion-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="InfusionTable"></div>
    <div class="sticky-footer">
        <div class="IndicatorDiv">
            <!-- Omitted -->
            <div class="legendItem">
                <span class="legendColor omitted"></span>
                <label>Omitted</label>
            </div>

            <!-- Cancelled -->
            <div class="legendItem">
                <span class="legendColor cancelled"></span>
                <label>Cancelled</label>
            </div>

            <!-- Administered -->
            <div class="legendItem">
                <span class="legendColor administered"></span>
                <label>Administered</label>
            </div>

        </div>
    </div>
    <div class="input-group input-group-sm w-100" style="margin: 15px 0px; display: none">
        <h6 class="fw-bold" style="padding: 5px 8px;">Remark</h6>
        <%: Html.TextBoxFor(x => Model.Remarks, new { id = "txtRemark", @class = "form-control mb-4 TextAreaBorder", Style = "width:100px;" ,maxlength="100"})%>
    </div>
    <div id='loading-Infusion' class='loading-screen' style='display: none; opacity: 0;'></div>

    <hr class="my-3">

    <%-- IV Supplements --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">IV Supplements</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100" style="display: flex;flex-direction: row-reverse;">
            <button id="btnRollOverIVSupplement" class="btn btn-sm btn-outline-secondary btnRollOver  d-none" data-tabtype="IVSupplement" title="Rollover last entry">
                <i class="fa fa-undo"></i>Rollover
            </button>
            </div>
            <div id="IVSUPListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id='loading-IVSUP-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="IVFluidTable"></div>
    <div class="sticky-footer">
        <div class="IndicatorDiv">
            <!-- Omitted -->
            <div class="legendItem">
                <span class="legendColor omitted"></span>
                <label>Omitted</label>
            </div>

            <!-- Cancelled -->
            <div class="legendItem">
                <span class="legendColor cancelled"></span>
                <label>Cancelled</label>
            </div>

            <!-- Administered -->
            <div class="legendItem">
                <span class="legendColor administered"></span>
                <label>Administered</label>
            </div>
           
        </div>
    </div>
    <hr class="my-3">

    <%-- Blood Products --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Blood Product</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100" style="display: flex;flex-direction: row-reverse;">
            <button id="btnRollOverBloodProduct" class="btn btn-sm btn-outline-secondary btnRollOver  d-none" data-tabtype="BloodProduct" title="Rollover last entry">
                <i class="fa fa-undo"></i>Rollover
            </button>
            </div>
            <div id="BloodProductMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id='loading-BloodProduct-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="BloodProductTable"></div>
    <div class="sticky-footer">
        <div class="IndicatorDiv">
                    <div style="margin-top: 3px; font-size: 13px;">
            <span style="font-weight: bold; color: #000;">Note : </span>
            <span style="color: #000;">Drop Factor used here to calculate the drop rate is
   
        <strong><%: OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("BloodProductDropFactor") %></strong>.
</span>
        </div>
            <!-- Omitted -->
            <div class="legendItem">
                <span class="legendColor omitted"></span>
                <label>Omitted</label>
            </div>

            <!-- Cancelled -->
            <div class="legendItem">
                <span class="legendColor cancelled"></span>
                <label>Cancelled</label>
            </div>

            <!-- Administered -->
            <div class="legendItem">
                <span class="legendColor administered"></span>
                <label>Administered</label>
            </div>

        </div>
    </div>

    <!--NutriIntake  -->
    <div class="mt-4 border-top pt-3">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h6 class="fw-bold mb-0">Nutrition / Intake</h6>
            <button type="button" class="btn btn-outline-success btn-sm" id="btnAddNutriIntake">
                <i class="fa fa-plus" style="margin-right: 5px;"></i>Nutrition / Intake
            </button>
        </div>
        <div id="NutriContainer"></div>
    </div>
    <div class="input-group input-group-sm w-100" style="margin: 15px 0px;">
        <h6 class="fw-bold" style="padding: 5px 8px;">Remarks</h6>
        <%: Html.TextBoxFor(x => Model.DocRemarks, new { id = "txtNutriRemark", @class = "form-control mb-4", Style = "width:100px;" ,maxlength="100"})%>
    </div>

    <!--Refer Doctor -->
    <div class="mt-4 border-top pt-3">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h6 class="fw-bold mb-0">Referral Doctor</h6>
            <button type="button" class="btn btn-outline-success btn-sm" id="btnAddOncologist">
                <i class="fa fa-plus" style="margin-right: 5px;"></i>Add Referral Doctor
            </button>
        </div>

        <div id="OncologistContainer"></div>
    </div>
    <div class="input-group input-group-sm w-100" style="margin: 15px 0px;">
        <h6 class="fw-bold" style="padding: 5px 8px;">Non drug order remark</h6>
        <%: Html.TextBoxFor(x => Model.NDOthers, new { id = "txtOthers", @class = "form-control mb-4", Style = "width:100px;" ,maxlength="100"})%>
    </div>
</div>

<!-- Common Modal -->
<div class="modal fade" id="commonPopupModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="commonPopupTitle"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="commonPopupBody"></div>
        </div>
    </div>
</div>

<div id="holdReasonModal" style="display: none; position: fixed; top: 30%; left: 40%; width: 20%; background: white; border: 1px solid #ccc; padding: 20px; z-index: 9999; box-shadow: 2px 2px 10px rgba(0,0,0,0.5);">
    <h6>Hold Reason</h6>
    <textarea id="txtHoldReason" class="TextAreaBorder" rows="4" style="width: 100%;" placeholder="Enter reason here..."></textarea><br>
    <br>
    <button id="btnHoldContinue" class="btn btn-primary">Continue</button>
    <button id="btnHoldCancel" class="btn btn-default">Cancel</button>
</div>

<div id="divHoldLog" style="display: none;">
    <div id="tblHoldLog"></div>
</div>
<%--added by aaryshree 20260625--%>
<div id="AddMedicineNew"  title="Add New Drug"  class="custom-popup" style="display:none;">
    
    <div class="popup-body">
        <input type="text" id="txtMedicineName"
                class="form-control Mandatory"
               placeholder="Enter Medicine Name" maxlength="60" />

        <input type="text" id="txtGenericName"
               class="form-control Mandatory"
               placeholder="Enter Generic Name" maxlength="60" />

        <input type="text" id="txtBrandName"
               class="form-control Mandatory"
               placeholder="Enter Brand Name" maxlength="60" />

        <label class="checkbox-label">
            <input type="checkbox" id="ChkHighAlt" />
            High Alert
        </label>
    </div>

    <div class="popup-footer">
        <button type="button"  id="btnDrug" class="save-btn" onclick="SaveNewDrug()">Add</button>
        
    </div>
</div>
<%--End--%>