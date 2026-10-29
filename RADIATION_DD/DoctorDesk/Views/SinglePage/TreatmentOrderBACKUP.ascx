<%--<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>--%>
<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style type="text/css">
    .tabulator-col-sorter {
        visibility: hidden;
    }

    .tabulator .tabulator-header .tabulator-col.tabulator-sortable .tabulator-col-title {
        padding-right: 0px !important;
    }
</style>

<%-- Investigations --%>
<script type="text/javascript">
    var InvstgListtable;
    var CIMS = '<%= Session["CIMSYN"] %>';
    var DoctCode = '<%= Session["DOCTCODE"] %>';
    var CIMSYN = ""; /* @Html.Raw(Json.Encode(Model.CIMS));*/ <%-- '<%= Model.CIMS %>';--%>

    $(document).ready(function () {
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
                        return "<i class='fa fa-trash text-danger' style='cursor:pointer'></i>";
                    },
                    editor: false,
                    cellClick: function (e, cell) {
                        cell.getRow().delete();
                    }
                },
                { title: "Code", field: "Code", editor: false, width: 300, visible: false },
                { title: "Test", field: "Test", editor: false, width: 300 },
                {
                    title: "Proposed Date",
                    field: "ProposedDate",
                    width: 140,
                    formatter: function (cell) {
                        return formatDateToDDMMYYYY(cell.getValue());
                    },
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

                        input.addEventListener("change", () => {
                            let val = parseInt(input.value);
                            if (!val || val <= 0) {
                                ToastMsg("Test Count should not be empty or less than 1", "Information");
                                input.value = 1;
                                val = 1;
                            }
                            success(val);
                            cell.getRow().update({ Pending: val });
                        });

                        input.addEventListener("blur", () => {
                            let val = parseInt(input.value);
                            if (!val || val <= 0) {
                                ToastMsg("Test Count should not be empty or less than 1", "Information");
                                input.value = 1;
                                val = 1;
                            }
                            success(val);
                            cell.getRow().update({ Pending: val });
                        });
                        return input;
                    },
                    formatter: "plaintext",
                    width: 120
                },
                { title: "Pending", field: "Pending", editor: false, width: 120 },
                { title: "Order Placed", field: "OrderPlaced", editor: false, width: 120 },
                {
                    title: "Remark",
                    field: "REMARK",
                    formatter: "textarea",
                    editor: "textarea",
                    editorParams: {
                        elementAttributes: {
                            maxlength: "500",
                        },
                        verticalNavigation: "editor",
                        shiftEnterSubmit: true,
                    },
                    width: 300,
                    cssClass: "TabTextArea"
                },

                { title: "Order by", field: "OrderBy", editor: false, width: 100 },
                { title: "Last Order No", field: "LastOrderNo", editor: false, width: 140 },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 100,
                    hozAlign: "center",
                    formatter: function (cell) {
                        const checked = cell.getValue() ? "checked" : "";
                        return `<input type="checkbox" disabled ${checked} />`;
                    },
                    editor: false
                }

            ]
        });

        $(document).on("click", ".Invstg-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = InvstgListtable.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].Code === code) {
                    ToastMsg("Investigation already added", "warning");
                    $("#InvstgListMainDiv").hide();
                    return;
                }
            }

            InvstgListtable.addRow({
                act: '<i class="fa fa-trash text-danger"></i>',
                Code: code,
                Test: name,
                // CHANGE THIS: Pass the raw date object, not the formatted string
                ProposedDate: new Date(),
                ProposedTime: getCurrentTime12Hour(),
                TestCount: 1,
                Pending: 1,
                OrderPlaced: 0,
                Remark: "",
                OrderBy: gDoctName,
                LastOrderNo: "",
                OMIT: false,
            }).then(function (row) {
                row.normalizeHeight();
            });
            $("#InvstgSearch").val("");
            $("#InvstgListMainDiv").hide();
        });

        //  SetDataForInvstg();
    });

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

<%-- Save and Binding Functionality --%>
<script type="text/javascript">
    var TranctionId = '';

    function ValidateSaveForInvstg(Type) {
        return true;
    }
    //Common Save Fuunction
    //function SaveForInvstg(DataSaveObj, Type) {
    //    var TreatmentArr = [];
    //    var tableData = InvstgListtable.getData();
    //    var rows = tableData.map(function (row) {
    //        var newRow = {};
    //        for (var key in row) {
    //            if (row.hasOwnProperty(key) && key !== "act") {
    //                newRow[key] = row[key];
    //            }
    //        }
    //        return newRow;
    //    });
    //    for (var i = 0; i < rows.length; i++) {
    //        var Code = rows[0].Code;
    //        var name = rows[0].name;
    //        var ProposedDate = rows[0].ProposedDate;
    //        var ProposedTime = rows[0].ProposedTime;
    //        var TestCount = rows[0].TestCount;
    //        var Pending = rows[0].Pending;
    //        var OrderPlaced = rows[0].OrderPlaced;
    //        var Remark = rows[0].Remark;
    //        var OrderBy = rows[0].OrderBy;
    //        var LastOrderNo = rows[0].LastOrderNo;
    //        var OMIT = rows[0].OMIT;
    //        var a = {
    //            CODE: Code,
    //            TEST: name,
    //            PROPOSEDDATE: ProposedDate,
    //            PROPOSEDTIME: ProposedTime,
    //            TESTCOUNT: TestCount,
    //            PENDING: Pending,
    //            ORDERPLACED: OrderPlaced,
    //            REMARK: Remark,
    //            ORDERBY: OrderBy,
    //            LASTORDERNO: LastOrderNo,
    //            OMIT: OMIT,
    //        };
    //        TreatmentArr.push(a);
    //    }
    //    DataSaveObj.push({ strInvstg: JSON.stringify(TreatmentArr), strMRNO: sessionStorage.getItem("PatMRNO"), strTranNo: sessionStorage.getItem("PatTRANNO") })
    //}

    function SaveAllTreatmentData() {
        const InvstgData = InvstgListtable ? InvstgListtable.getData() : [];
        const bloodData = BloodProductTable ? BloodProductTable.getData() : [];
        const ivFluidData = IVFluidTable ? IVFluidTable.getData() : [];
        const infusionData = InfusionTable ? InfusionTable.getData() : [];
        const antibioticData = MedicineListtable ? MedicineListtable.getData() : [];
        const ChemoMedData = ChemoListtable ? ChemoListtable.getData() : [];

        var postData = {
            TS: {
                // Populate necessary properties for the TreatmentSheet object here
                // Example: IpNo: $("#IpNo").val()
            },
            action: "N",
            tableBloodProductData: JSON.stringify(bloodData),
            tableInfusionData: JSON.stringify(infusionData),
            tableSpeciaInstructionsData: JSON.stringify(ivFluidData),
            tableInvestigationData: JSON.stringify(InvstgData),
            tableAntibioticData: JSON.stringify(antibioticData),
            tableChemoAMediData: JSON.stringify(ChemoMedData),

            tableNebulizationData: JSON.stringify([]),
            tableSTATOrdFilterData: JSON.stringify([]),
            tableMedicationData: JSON.stringify([]),
            tableReferralsFilterData: JSON.stringify([]),
            tableMeicationStatOrderData: JSON.stringify([]),
            tableChemoAntiData: JSON.stringify([]),

            IpNo: typeof IpNo !== 'undefined' ? IpNo : "",
            MrNo: typeof MrNo !== 'undefined' ? MrNo : "",
            PatName: typeof PatName !== 'undefined' ? PatName : "",
            TranctionId: typeof TranctionId !== 'undefined' ? TranctionId : "0",
            TypData: "TREATMENT",
            DrVerified: "N"
        };

        $.ajax({
            url: '../SinglePage/SaveTreatmentSheetTran',
            type: 'POST',
            data: JSON.stringify(postData),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                if (response) {
                    ToastMsg("Data saved successfully!", "information");
                }
            },
            error: function (err) {
                ToastMsg(err, "error");
            }
        });
    }

    // To bind saved investigations == "Display OR Edit Mode"
    //function SetDataForInvstg() {
    //    var tranNo = sessionStorage.getItem('PatTRANNO');
    //    if (!tranNo) return;
    //    startLoading("Loading", "loading-Invstg");
    //    $.ajax({
    //        type: "POST",
    //        url: "../DoctorDesk/SetDataForInvstg",
    //        datatype: "json",
    //        data: { strTranNo: tranNo },
    //        success: function (data) {
    //            if (!data || !data[0] || data[0].length === 0) return;
    //            var existingRows = InvstgListtable.getData();
    //            data[0].forEach(function (item) {
    //                var exists = existingRows.some(function (r) {
    //                    return r.code === item.DESCCD;
    //                });
    //                if (exists) return;
    //                InvstgListtable.addRow({
    //                    act: "",
    //                    code: item.DESCCD,
    //                    name: item.DESC,
    //                    type: item.DURTYPE || "",
    //                    no: item.DURATION || "",
    //                    REMARK: (item.REMARKS || "").trim(),
    //                    SetUpYn: item.SETUPYN || ""
    //                });
    //            });
    //            stopLoading("loading-Invstg");
    //        },
    //        error: function (xhr, status) {
    //            ToastMsg(status, "error");
    //            stopLoading("loading-Invstg");
    //        }
    //    });
    //}

    function GetTreatmentSheetData() {
        if (TranctionId == "") {
            IsRollover = "N";
        }
        var TsDate = getCurrentDate_DDMMYYYY();
        var TsTime = getCurrentTime_12H();
        var IpNo = "RH1IP0009247";

        $.ajax({
            url: '../SinglePage/GetTreatmentOrderData',
            data: { TranNo: TranctionId, IPNum: IpNo, IsRollover: IsRollover, tsTime: TsTime, tsDate: TsDate },
            type: 'get',
            async: true,
            dataType: "json",
            success: function (Response) {
                console.log(Response);
                /* ---------- HEADER / DETAILS ---------- */
                const details = normalizeArray(Response.jsonDetailsData);
                if (details.length > 0) {
                    bindTreatmentHeader(details[0]);
                }
                /* ---------- INVESTIGATIONS ---------- */
                var invData = Response.jsonTestData.map(x => ({
                    Code: x.Code || "",
                    Test: x.Test || "",
                    ProposedDate: x.ProposedDate || "",
                    ProposedTime: x.ProposedTime || "",
                    TestCount: x.TestCount || 1,
                    Pending: x.Pending || 1,
                    OrderPlaced: x.OrderPlaced || 0,
                    REMARK: x.REMARKS || "",
                    OrderBy: x.OrderBy || x.ORDERBY || "",
                    LastOrderNo: x.LastOrderNo || "",
                    OMIT: x.OMIT === "Y" ? true : false
                }));
                InvstgListtable.setData(invData);

                /* ---------- ANTIBIOTICS ---------- */
                const medArray = normalizeArray(Response.medicineList || Response.jsonAntibioticData || []);
                const medData = medArray.map(x => ({
                    DRUGCD: x.DrugCode || "",
                    DAY: x.DayOfDrug || x.DAY || "1",
                    DRUGFORM: x.Type || "",
                    VOLDILDRUG: x.DrugName || "",
                    DOSE: x.DOSE || x.Dose || "",
                    FREQ: x.FREQ || x.Freq || "",
                    ORDERBY: x.ORDERBY,
                    STARTDT: x.STARTFRMDT || formatDateToDDMMYYYY(new Date()),
                    REMARK: x.Remark || "",
                    OMIT: x.OMIT === "Y" ? true : false,
                    TYPECD: x.TypeCode || "",
                    DURATION_ADMN: x.ADMINDUR || "",
                    DILNVOL: x.DILVOLUME || "",
                    DILUENT: x.Diluent || "",
                    ROUTE: x.Route || "",
                    DURATION_DAY: x.Duration || "",
                    ADMINYN: x.ADMINYN || "",
                    MEDSTAT: x.MEDSTAT,
                    HOLD: x.HOLD || "",
                    ISSUEMED: x.ISSUEYN || "",
                    INDENTMED: x.INDENTYN || "",
                    IsRollOver: x.IsRollOver || ""
                }));
                MedicineListtable.setData(medData);

                /* ---------- CHEMO MEDICATION ---------- */
                var chemo = Response.jsonChemoAData.map(x => ({
                    DAY: x.DayOfDrug || "",
                    DRUGFORM: x.Type || "",
                    CHEMODRUGNAME: x.DrugName || "",
                    DOSE: x.Dose || "",
                    ROUTE: x.Route || "",
                    FREQ: x.Freq || "",
                    REMARK: x.Remark || "",
                    DILUENT: x.Diluent || "",
                    DURATION: x.Duration || "",
                    STARTDT: x.STARTFRMDT || "",
                    OMIT: x.OMIT === "Y" ? true : false,
                    ORDERBY: x.ORDERBY || "",
                    OGDOSE: x.ORGDOSE || "",
                    PRESCRIBEBY: x.PRESCRIBEBY || "",
                    DRUGCODE: x.DrugCode || "",
                    HighAlert: x.HighAlert || "N",
                }));
                ChemoListtable.setData(chemo);

                /* ---------- INFUSION ---------- */
                var infusion = Response.jsonInfusionData.map(x => ({
                    IntravenousInfusions: x.Infusion || "",
                    DoseDilution: x.Dose || "",
                    InfusionRate: x.InfusionRate || "",
                    OrderBy: x.ORDERBY || "",
                    Remark: x.Remark || "",
                    HighAlert: x.HighAlert || "N",
                    OMIT: x.OMIT === "Y" ? true : false,
                    isFromServer: true // <-- mark server rows
                }));
                InfusionTable.setData(infusion);
                /* ---------- SPECIAL INSTRUCTIONS / IV FLUID ---------- */
                var ivFluid = Response.jsonSpecilInstData.map(x => ({
                    DayOfDrug: x.DayOfDrug || "",
                    DrugName: x.DrugName || "",
                    Remark: x.Remark || "",
                    DilutionVolume: x.DILVOLUME || "",
                    INFRATE: x.INFRATE || "",
                    AdminstrDuration: x.ADMINDUR || "",
                    MACROSET: x.MACROSET || "",
                    MICROSET: x.MICROSET || "",
                    SpiDGSTARTDATE: x.STARTFRMDT || "",
                    ADMINYN: x.ADMINYN || "",
                    IsRollOver: x.IsRollOver || "",
                    OrderedBy: x.ORDERBY || "",
                    OrderedDate: x.ORDDATE || "",
                    OrderedTime: x.ORDTIME || "",
                    HighAlert: x.HighAlert || "N",
                    OMIT: x.OMIT === "Y" ? true : false,
                }));
                IVFluidTable.setData(ivFluid);
                /* ---------- BLOOD PRODUCTS ---------- */
                console.log(Response.jsonBloodProductData);
                var blood = Response.jsonBloodProductData.map(x => ({
                    Dose: x.Dose || "",
                    Duration: x.Duration || "",
                    Type: x.Type || "",
                    DrugName: x.DrugName || "",
                    DauOfDrug: x.DayOfDrug || "",
                    Route: x.Route || "",
                    Freq: x.Freq || "",
                    Remark: x.Remark || "",
                    Diluent: x.Diluent || "",
                    DilutionVolume: x.DilutionVolume || "",
                    INFRATE: x.INFRATE || "",
                    AdminstrDuration: x.ADMINDUR || "",
                    MACROSET: x.MACROSET || "",
                    BPSTARTDATE: x.STARTFRMDT || "",
                    OrderedBy: x.ORDERBY || "",
                    OrderedDate: x.OrderedDate || "",
                    OrderedTime: x.ORDTIME || "",
                    DrugCode: x.DrugCode || "",
                    TypeCode: x.TypeCode || "",
                    SQNumber: x.SQNumber || "",
                    NotifyYN: x.NOTIFYN || "",
                    Status: x.STATUS || "",
                    MEDSTAT: x.MEDSTAT || "",
                    ADMINYN: x.ADMINYN || "",
                    IsRollOver: x.IsRollOver || "",
                    HighAlert: x.HighAlert || "N",
                    OMIT: x.OMIT === "Y" ? true : false,
                }));
                BloodProductTable.setData(blood);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "Error Information");
            }
        });
    }


    function normalizeArray(data) {
        return Array.isArray(data) ? data : [];
    }

    function bindTreatmentHeader(data) {
        $("#txtHeight").val(data.HEIGHT);
        $("#txtWeight").val(data.WEIGHT);
        $("#txtBSA").val(data.BSA);
        $("#txtDiagnosis").val(data.DIAGNOSIS);
        $("#txtCycleNo").val(data.CycleNo);
        $("#txtCourse").val(data.COURSENM);
    }
    function getCurrentDate_DDMMYYYY() {
        const d = new Date();
        const day = String(d.getDate()).padStart(2, '0');
        const month = String(d.getMonth() + 1).padStart(2, '0');
        const year = d.getFullYear();
        return `${day}/${month}/${year}`;
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

</script>

<%-- Medicine Table --%>

<%-- Add New Item For Medicine --%>
<script type="text/javascript">
    function ContentForAddNewItemMedicine() {
        return `
        <div class="mb-3">
        <label>Medicine Name</label>
          <input id="txtMedicine" type="text" class="form-control Medicine" maxlength="250" autocomplete="off" placeholder="Enter Medicine Name" tabindex="2" />
        </div>
        <div class="mb-3">
          <label>Generic Name</label>
        <input id="txtGeneric" type="text" class="form-control Medicine" maxlength="250" autocomplete="off" placeholder="Enter Medicine Name" tabindex="2" />
        </div>
        <div class="mb-3">
          <label>Brand Name</label>
        <input id="txtBrand" type="text" class="form-control Medicine" maxlength="250" autocomplete="off" placeholder="Enter Medicine Name" tabindex="2" />
        </div>

        <div id='loading-Medicine' class='loading-screen' style='display: none; opacity: 0;'></div>

        `;
    }

    function FooterContentForAddNewItemMedicine() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForMedicine()" tabindex="4">Save</button>
        `;
    }

    function ValidationForNewItemMedicine() {
        if ($("#txtMedicine").val().trim().length === 0) {
            ToastMsg("Enter Medicine", "warning");
            $("#txtMedicine").focus();
            return false;
        }
        return true;
    }

    function SaveNewItemForMedicine() {
        if (!ValidationForNewItemMedicine()) return;
        tempMedicine = {
            MEDNAME: $("#txtMedicine").val().trim(),
            GENERIC: $("#txtGeneric").val().trim(),
            BRAND: $("#txtBrand").val().trim()
        };

        OpenDosePopup();
    }

    function DosePopupContent() {
        const presetDoses = [0.1, 0.25, 0.5, 1, 2, 3, 5, 10, 30, 50, 100, 200, 500, 1000, 2000];
        const createButtons = presetDoses.map(d =>
            `<button type="button" class="btn btn-outline-primary btn-sm m-1 presetDoseBtn" data-value="${d}">${d}</button>`
        ).join("");

        return `
        <div>
            <h6>${tempMedicine.MEDNAME}</h6>
            <div class="row mt-2">
                <div class="col-6">
                    <label>Frequency</label>
                    <select id="cmbFrequency" class="form-control">
                        <option value="OD">OD</option>
                        <option value="BD">BD</option>
                        <option value="TDS">TDS</option>
                        <option value="QID">QID</option>
                        <option value="Q2H">Q2H</option>
                        <option value="Q4H">Q4H</option>
                        <option value="Q8H">Q8H</option>
                        <option value="Q12H">Q12H</option>
                        <option value="HS">HS</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="col-6">
                    <label>Drug Unit</label>
                    <select id="cmbUnit" class="form-control"></select>
                </div>
            </div>

            <div class="text-center mt-3">
                <label>Preset Doses</label>
                <div>${createButtons}</div>
            </div>

            <div class="text-center mt-2">
                <button type="button" class="btn btn-dark btn-sm" id="btnAddFreq"> 
                  <i class="fa fa-plus"></i> 
                </button>
                <button type="button" class="btn btn-dark btn-sm ml-2" id="btnRemoveFreq"> 
                  <i class="fa fa-minus"></i> 
                </button>
           </div>
       
           <div id="freqContainer" class="d-flex flex-wrap justify-content-center mt-3"></div>

            <div class="text-center mt-4">
                <button class="btn btn-success" onclick="ConfirmDose()">OK</button>
                <button class="btn btn-danger" onclick="ClosePopup()">Cancel</button>
                <button class="btn btn-warning" onclick="ClearDoseFields()">Clear Dose</button>
            </div>
        </div>
    `;
    }

    function OpenDosePopup() {
        frequencyDoses = [0];
        activeFreqIndex = 0;
        OpenCommonPopup("Add Dose", DosePopupContent());
        setTimeout(function () {
            bindUnitDropdown();
            renderFrequencyBoxes();
            $("#btnAddFreq, #btnRemoveFreq").hide();
        }, 200);
    }

    function OpenCommonPopup(title, contentHtml) {
        closeAddNewItemPopup('Medicine');
        $("#commonPopupTitle").text(title);
        $("#commonPopupBody").html(contentHtml);

        var modalEl = document.getElementById("commonPopupModal");
        var modal = new bootstrap.Modal(modalEl);
        modal.show();

    }

    function ClosePopup() {
        var modalEl = document.getElementById("commonPopupModal");
        var modal = bootstrap.Modal.getInstance(modalEl);
        if (modal) modal.hide();
    }

    function ClearDoseFields() {
        if (activeFreqIndex !== -1) {
            frequencyDoses[activeFreqIndex] = 0;
            renderFrequencyBoxes();
        } else {
            ToastMsg("Select a dose box to clear", "info");
        }
    }

    function ConfirmDose() {
        let freq = $("#cmbFrequency").val();
        let unit = $("#cmbUnit").val();

        if (!unit) {
            ToastMsg("Select Drug Unit", "warning");
            return;
        }

        if (frequencyDoses.length === 0 || frequencyDoses[0] === 0) {
            ToastMsg("Please enter a valid dose amount", "warning");
            return;
        }

        // Add only the first dose box as a single row to the table
        MedicineListtable.addRow({
            DRUGCD: tempMedicine.DRUGCD,
            DAY: "1",
            DRUGFORM: "INJ",
            VOLDILDRUG: tempMedicine.MEDNAME,
            DOSE: frequencyDoses[0] + " " + unit,
            FREQ: freq,
            ORDERBY: gDoctName,
            STARTDT: formatDateToDDMMYYYY(new Date()),
            OMIT: false,
            TYPECD: "INJ"
        }).then(function (row) {
            row.normalizeHeight();
        });

        ClosePopup();
        // Reset state
        frequencyDoses = [];
        activeFreqIndex = -1;
    }

    function bindUnitDropdown() {
        $.ajax({
            type: "POST",
            url: "../SinglePage/GetUnitList",
            dataType: "json",
            success: function (result) {
                if (!result || result.length === 0) return;

                let options = `<option value="">--Select Unit--</option>`;
                $.each(result, function (i, row) {
                    options += `<option value="${row.Value}">${row.Text}</option>`;
                });
                $("#cmbUnit").empty().append(options);
            },
            error: function (err) {
                ToastMsg(err, "error");
            }
        });
    }
</script>

<style type="text/css">
    .freq-box {
        background: #7CFC90;
        padding: 8px 16px;
        margin: 6px;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
    }

        .freq-box.active {
            border: 2px solid #000;
        }
</style>

<script type="text/javascript">
    var MedicineListtable;
    var CIMS = '<%= Session["CIMSYN"] %>';
    var DoctCode = '<%= Session["DOCTCODE"] %>';
    var CIMSYN = "";
    var tempMedicine = null;
    var frequencyDoses = [];
    var activeFreqIndex = -1;
    let n = 5;

    $(document).ready(function () {

        var routeData = load_MedicineRote();
        var diluData = load_DiluVolume();
        var adminDurData = load_AdminDurData();

        MedicineListtable = new Tabulator("#MedicineTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            /* height: "50",*/
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
                    width: 60,
                    hozAlign: "center",
                    formatter: function (cell) {
                        return "<i class='fa fa-trash text-danger' style='cursor:pointer'></i>";
                    },
                    editor: false,
                    cellClick: function (e, cell) {
                        cell.getRow().delete();
                    }
                },
                { title: "Day", field: "DAY", editor: false, width: 80 },
                { title: "Duration of Days", field: "DURATION_DAY", editor: false, headerWordWrap: true, width: 150 },
                {
                    title: "Drug Form",
                    field: "DRUGFORM",
                    headerWordWrap: true,
                    width: 120,
                    headerHozAlign: "center",
                    editor: "list",
                    editorParams: {
                        values: GrdAnitibioticType(), // Use the pre-loaded array
                        autocomplete: true,
                        listOnEmpty: true,       // Shows all options when you click the empty cell
                        filterRemote: false,      // Important: tells Tabulator the data is local
                        allowEmpty: true,
                        emptyGenericPlaceholder: false
                    },
                },
                { title: "Volume / Dilution Drugs", field: "VOLDILDRUG", headerWordWrap: true, editor: false, width: 120 },
                { title: "Dose", field: "DOSE", editor: false, width: 120 },
                {
                    title: "Route",
                    field: "ROUTE",
                    width: 120,
                    formatter: "lookup", // This shows the Text instead of Code
                    formatterParams: routeData, // Use the object: { "Code": "Text" }
                    editor: "list",
                    editorParams: {
                        values: routeData,
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: true
                    }
                },
                { title: "Frequency", field: "FREQ", editor: false, headerWordWrap: true, width: 120 },
                {
                    title: "Remark",
                    field: "REMARK",
                    formatter: "textarea",
                    editor: "textarea",
                    editorParams: {
                        elementAttributes: {
                            maxlength: "500",
                        },
                        verticalNavigation: "editor",
                        shiftEnterSubmit: true,
                    },
                    width: 200,
                    cssClass: "TabTextArea"
                },
                { title: "Diluent", field: "DILUENT", editor: true, width: 90 },
                {
                    title: "Dil<sup>n</sup> / Vol.",
                    field: "DILNVOL",
                    width: 120,
                    formatter: "lookup",
                    formatterParams: diluData,
                    editor: "list",
                    editorParams: {
                        values: diluData,
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: true
                    }
                },
                {
                    title: "Dur. of Admn.",
                    field: "DURATION_ADMN",
                    width: 120,
                    formatter: "lookup",
                    formatterParams: adminDurData,
                    editor: "list",
                    editorParams: {
                        values: adminDurData,
                        autocomplete: true,
                        listOnEmpty: true,
                        allowEmpty: true
                    }
                },
                { title: "StartDate", field: "STARTDT", editor: false, headerWordWrap: true, width: 120 },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 90,
                    hozAlign: "center",
                    formatter: function (cell) {
                        const checked = cell.getValue() ? "checked" : "";
                        return `<input type="checkbox" disabled ${checked} />`;
                    },
                    editor: false
                },
                { title: "DrugCode", field: "DRUGCD", editor: false, width: 120, visible: false },
                { title: "TypeCode", field: "TYPECD", editor: false, width: 120, visible: false },
                { title: "OMIT/ Cancel By", field: "OMITCANCELBY", editor: false, width: 120, visible: false },
                { title: "OMIT / Cancel Date", field: "OMITCANCELDT", editor: false, width: 120, visible: false },
                { title: "Order By", field: "ORDERBY", editor: false, width: 120 },
                { title: "Admitted", field: "ADMINYN", editor: false, width: 100, visible: false },
                { title: "Medicine Start", field: "MEDSTAT", editor: false, width: 140, visible: false },
                { title: "Hold", field: "HOLD", editor: false, width: 120, visible: false },
                { title: "Hold Log", field: "HOLDLOG", editor: false, width: 120, visible: false },
                { title: "Issue Medicine", field: "ISSUEMED", editor: false, width: 120, visible: false },
                { title: "Indent Medicine", field: "INDENTMED", editor: false, width: 120, visible: false },
                { title: "Roll Over", field: "IsRollOver", editor: false, width: 100, visible: false },

            ]
        });

        $(document).on("click", ".Medicine-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");

            // Check if already in Tabulator
            var rows = MedicineListtable.getData();
            if (rows.some(row => row.DRUGCD === code)) {
                ToastMsg("Medicine already added", "warning");
                $("#MedicineListMainDiv").hide();
                return;
            }

            // Set tempMedicine data so OpenDosePopup knows what to display
            tempMedicine = {
                MEDNAME: name,
                DRUGCD: code,
                GENERIC: "", // Or fetch if available
                BRAND: ""
            };

            $("#MedicineSearch").val("");
            $("#MedicineListMainDiv").hide();

            // Open the Modal
            OpenDosePopup();
        });

        $(document).on("keypress", ".doseInput", function (e) {
            const char = String.fromCharCode(e.which);
            if (!/[0-9.]/.test(char)) {
                e.preventDefault();
            }
        });

        $(document).on("click", ".presetDoseBtn", function () {
            const val = parseFloat($(this).data("value"));

            if (activeFreqIndex === -1) {
                ToastMsg("Select a frequency box first", "information");
                return;
            }

            let current = parseFloat(frequencyDoses[activeFreqIndex]) || 0;
            frequencyDoses[activeFreqIndex] = +(current + val).toFixed(3);

            renderFrequencyBoxes();
        });

        $(document).on("click", ".freq-box", function () {
            activeFreqIndex = parseInt($(this).data("index"));
            renderFrequencyBoxes();
        });

        $(document).on("click", "#btnAddFreq", function () {
            frequencyDoses.push(0);
            activeFreqIndex = frequencyDoses.length - 1;
            renderFrequencyBoxes();
        });

        $(document).on("click", "#btnRemoveFreq", function () {

            if (activeFreqIndex === -1) {
                ToastMsg("Select a frequency box to remove", "information");
                return;
            }

            frequencyDoses.splice(activeFreqIndex, 1);

            activeFreqIndex = frequencyDoses.length
                ? frequencyDoses.length - 1
                : -1;

            renderFrequencyBoxes();
        });
    });

    function GetAllMedicineList(FilterMedicineText, FilterMedicineCode) {
        startLoading("Loading", "loading-Medicine-Search-List");
        var strChecmoMedYN = "N";
        var Type = "INJ";
        $.ajax({
            type: "POST",
            async: true,
            url: "../SinglePage/GetDruglst",
            data: { searchstring: FilterMedicineText, Type: Type, strChecmoMedYN: strChecmoMedYN },
            success: function (result) {
                var MedicineListData = [];
                if (result && result.rows && result.rows.length > 0) {
                    MedicineListData = result.rows.map(item => ({
                        NAME: item.NAME,
                        CODE: item.CODE
                    }));
                    BindSearchListForMedicine(MedicineListData);

                } else {
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

    function FilterMedicineData(MedicineListData, MedicineCode) {
        var FilterComplList = MedicineListData;
        if (MedicineCode != "") {
            FilterComplList = MedicineListData.filter(item => item.CODE == MedicineCode);
        }
        BindSearchListForMedicine(FilterComplList);
        if (MedicineCode && MedicineCode !== "") {
            var $first = $("#MedicineList .Medicine-row").first();
            if ($first.length) {
                $first.trigger("click");
            }
        }
    }

    function FilterBindedSearchListForMedicine() {
        var SearchTxt = $("#MedicineSearch").val().toLowerCase();
        var FlagForCallAllComplList = true;
        if (SearchTxt.length >= 3) {
            if (FlagForCallAllComplList == true)
                GetAllMedicineList($("#MedicineSearch").val(), "");
        }
    }

    function BindSearchListForMedicine(MedicineData) {
        var $list = $("#MedicineList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No Medicine found</div>';
        if (MedicineData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < MedicineData.length; i++) {
                var item = MedicineData[i];
                var ListOption = '<div class="list-group-item Medicine-row" data-code="' + item.CODE + '" data-name="' + item.NAME + '" style="cursor:pointer;">' + item.NAME + ' (' + item.CODE + ') </div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#MedicineList").append(AppendContentList);
        $("#MedicineListMainDiv").show();
    }

    function getCurrentTime12Hour() {
        const d = new Date();
        let hour = d.getHours();
        const minute = String(d.getMinutes()).padStart(2, "0");
        const ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        return `${String(hour).padStart(2, "0")}:${minute} ${ampm}`;
    }

    function renderFrequencyBoxes() {
        let html = "";

        frequencyDoses.forEach((dose, i) => {
            html += `
            <div class="freq-box ${i === activeFreqIndex ? 'active' : ''}"
                 data-index="${i}">
                ${dose}
    </div>`;
        });

        $("#freqContainer").html(html);
    }

    function GrdAnitibioticType() {
        var AntibioticsType = {
            '': '', 'INJ': 'INJ', 'IV': 'IV', 'POWD FOR INJ': 'POWD FOR INJ', 'SUSP FOR INJ': 'SUSP FOR INJ'
        }
        return AntibioticsType;
    }

    function load_MedicineRote() {
        var routeObj = { "": "" }; // Default empty option
        $.ajax({
            url: '../SinglePage/GetMedicineRoute',
            type: 'get',
            async: false,
            success: function (Response) {
                $.each(Response, function () {
                    routeObj[this.Value] = this.Text;
                });
            }
        });
        return routeObj;
    }

    function load_DiluVolume() {
        var diluObj = { "": "" };
        $.ajax({
            url: '../SinglePage/GetDilutionVolumList',
            type: 'get',
            async: false,
            success: function (Response) {
                $.each(Response, function () {
                    diluObj[this.Value] = this.Text;
                });
            }
        });
        return diluObj;
    }

    function load_AdminDurData() {
        var durObj = { "": "" };
        $.ajax({
            url: '../SinglePage/GetAdminiStrDur',
            type: 'get',
            async: false,
            success: function (Response) {
                $.each(Response, function () {
                    durObj[this.Value] = this.Text;
                });
            }
        });
        return durObj;
    }
</script>

<%-- Infusion --%>
<script type="text/javascript">
    var InfusionTabl = [];
    $("#document").ready(function () {
        InfusionTable = new Tabulator("#InfusionTable", {
            layout: "fitColumns",
            autoResize: false, // keep column width stable
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
                //{
                //    title: "<i class='fa fa-plus text-success' style='cursor:pointer; color: yellow !important;' onclick='AddInfusionRow()'></i>",
                //    field: "action",
                //    width: 50,
                //    hozAlign: "center",
                //    headerHozAlign: "center",
                //    formatter: function (cell) {
                //        let data = cell.getRow().getData();
                //        return data.Omit ? "" : "<i class='fa fa-trash text-danger' style='cursor:pointer'></i>";
                //    },
                //    editor: false,
                //    cellClick: function (e, cell) {
                //        let data = cell.getRow().getData();
                //        if (!data.Omit) cell.getRow().delete();
                //    }
                //},
                {
                    title: "<i class='fa fa-plus text-success' style='cursor:pointer; color: yellow !important;' onclick='AddInfusionRow()'></i>",
                    field: "action",
                    width: 50,
                    hozAlign: "center",
                    formatter: function (cell) {
                        let data = cell.getRow().getData();
                        return data.Omit || data.isFromServer ? "" : "<i class='fa fa-trash text-danger' style='cursor:pointer'></i>";
                    },
                    cellClick: function (e, cell) {
                        let data = cell.getRow().getData();
                        if (!data.Omit && !data.isFromServer) cell.getRow().delete();
                    }
                },
                {
                    title: "Intravenous Infusions",
                    field: "IntravenousInfusions",
                    headerHozAlign: "center",
                    editor: function (cell) {
                        let data = cell.getRow().getData();
                        return data.isFromServer ? false : "input";
                    },
                    cellEdited: function (cell) {
                        let val = cell.getValue();
                        if (val) cell.setValue(val.toUpperCase(), true);
                    }
                },
                {
                    title: "Dose / Dilution",
                    field: "DoseDilution",
                    headerHozAlign: "center",
                    editor: function (cell) {
                        let data = cell.getRow().getData();
                        return data.isFromServer ? false : "input";
                    },
                    cellEdited: function (cell) {
                        let val = cell.getValue();
                        if (val) cell.setValue(val.toUpperCase(), true);
                    }
                },
                {
                    title: "<span style='color:red'>Infusion Rate</span>",
                    field: "InfusionRate",
                    headerHozAlign: "center",
                    editor: function (cell) {
                        let data = cell.getRow().getData();
                        return data.isFromServer ? false : "input"; // read-only if from server
                    },
                    headerSort: false,
                    cellEdited: function (cell) {
                        let val = cell.getValue();
                        if (val) cell.setValue(val.toUpperCase(), true);
                    }
                },
                {
                    title: "High Alert",
                    field: "HighAlert",
                    width: 100,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function (cell) {
                        const data = cell.getRow().getData();
                        const checked = cell.getValue() ? "checked" : "";
                        const disabled = data.isFromServer ? "disabled" : "";
                        return `<input type="checkbox" ${checked} ${disabled} />`;
                    },
                    cellClick: function (e, cell) {
                        // Only allow if not from server
                        if (cell.getRow().getData().isFromServer) return;

                        const checkbox = e.target;
                        let newVal;
                        if (checkbox.tagName === "INPUT") {
                            newVal = checkbox.checked;
                        } else {
                            newVal = !cell.getValue();
                        }
                        cell.setValue(newVal);

                        // Optional: change row color
                        cell.getRow().getElement().style.color = newVal ? "red" : "black";
                    }
                },
                {
                    title: "Order By",
                    field: "OrderBy",
                    headerHozAlign: "center",
                    editor: function (cell) {
                        let data = cell.getRow().getData();
                        return data.isFromServer ? false : "input"; // read-only if from server
                    },
                    cellEdited: function (cell) {
                        let val = cell.getValue();
                        if (val) cell.setValue(val.toUpperCase(), true);
                    }
                },
                {
                    title: "Remark",
                    field: "Remark",
                    headerHozAlign: "center",
                    editor: function (cell) {
                        let data = cell.getRow().getData();
                        return data.isFromServer ? false : "textarea"; // read-only if from server
                    },
                    editorParams: { elementAttributes: { maxlength: 500 } },
                    width: 250,
                    cellEdited: function (cell) {
                        let val = cell.getValue();
                        if (val) cell.setValue(val.toUpperCase(), true);
                    },
                    cssClass: "TabTextArea"
                },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 100,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function (cell) {
                        const data = cell.getRow().getData();
                        const checked = cell.getValue() ? "checked" : "";
                        const disabled = data.isFromServer ? "disabled" : "";
                        return `<input type="checkbox" ${checked} ${disabled} />`;
                    },
                    cellClick: function (e, cell) {
                        // Only allow if not from server
                        if (cell.getRow().getData().isFromServer) return;

                        const checkbox = e.target;
                        let newVal;

                        if (checkbox.tagName === "INPUT") {
                            newVal = checkbox.checked;
                        } else {
                            newVal = !cell.getValue();
                        }
                        cell.setValue(newVal);

                        // Show/hide delete icon
                        const actionCell = cell.getRow().getCell("action");
                        const icon = actionCell.getElement().querySelector("i.fa-trash");
                        if (icon) icon.style.display = newVal ? "none" : "";

                        if (checkbox.tagName !== "INPUT") {
                            const input = cell.getElement().querySelector("input");
                            if (input) input.checked = newVal;
                        }
                    }
                }
            ],
            rowFormatter: function (row) {
                let data = row.getData();
                row.getElement().style.color = !!data.HighAlert ? "red" : "black";
                let deleteCell = row.getCell("action");
                deleteCell.getElement().style.display = data.Omit ? "none" : "";
            },
            data: []
        });

    });
    function AddInfusionRow() {
        var firstRow = InfusionTable.getData()[0];
        if (firstRow) {
            var requiredFields = ["IntravenousInfusions", "DoseDilution", "InfusionRate", "HighAlert", "OrderBy", "Remark"];
            var isEmpty = requiredFields.every(f => !firstRow[f] || firstRow[f].trim() === "");
            if (isEmpty) {
                ToastMsg("Please fill the first row before adding a new row.", "information");
                return;
            }
        }
        InfusionTable.addRow({});
    }
</script>

<%-- IV Fluids --%>
<script type="text/javascript">
    var IVFluidTable;
    $(document).ready(function () {

        IVFluidTable = new Tabulator("#IVFluidTable", {
            layout: "fitColumns",
            autoResize: false, // keep column width stable
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
                    title: "<i class='fa fa-plus text-success' style='color: yellow!important' onclick='AddIVFluidRow()'></i>",
                    field: "action",
                    width: 50,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function (cell) {
                        return cell.getRow().getData().OMIT === "Y"
                            ? ""
                            : "<i class='fa fa-trash text-danger'></i>";
                    },
                    cellClick: function (e, cell) {
                        if (cell.getRow().getData().OMIT !== "Y") {
                            cell.getRow().delete();
                        }
                    }
                },
                { title: "Day", field: "DayOfDrug", headerHozAlign: "center", visible: false },
                {
                    title: "IV Fluids / TPN",
                    field: "DrugName",
                    headerHozAlign: "center",
                    editor: "input",
                    editable: cell => cell.getRow().getData().ADMINYN !== "Y",
                    cellEdited: cell => {
                        if (cell.getValue())
                            cell.setValue(cell.getValue().toUpperCase(), true);
                    }
                },
                {
                    title: "Remark",
                    field: "Remark",
                    headerHozAlign: "center",
                    editor: "textarea",
                    editable: cell => cell.getRow().getData().OMIT !== "Y",
                    cellEdited: cell => {
                        if (cell.getValue())
                            cell.setValue(cell.getValue().toUpperCase(), true);
                    },
                    cssClass: "TabTextArea"
                },
                {
                    title: "<span style='color:red'>Volume (ml)</span>",
                    field: "DilutionVolume",
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    editable: cell => cell.getRow().getData().ADMINYN !== "Y",
                    cellEdited: calculateIVFluid
                },
                {
                    title: "<span style='color:red'>Infusion Rate (ml/hr)</span>",
                    field: "INFRATE",
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    editable: cell => cell.getRow().getData().ADMINYN !== "Y",
                    cellEdited: calculateIVFluid
                },
                {
                    title: "Dur. of Admn (hrs)",
                    field: "AdminstrDuration",
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    editable: cell => cell.getRow().getData().ADMINYN !== "Y",
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
                    formatter: function (cell) {
                        return cell.getValue() || "";
                    }
                },
                {
                    title: "High Alert",
                    field: "HighAlert",
                    width: 100,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    editable: false,
                    formatter: function (cell) {
                        const checked = cell.getValue() === "Y" ? "checked" : "";
                        return `<input type="checkbox" ${checked} />`;
                    },
                    cellClick: function (e, cell) {

                        const isChecked = cell.getValue() === "Y";
                        const newVal = isChecked ? "N" : "Y";
                        cell.setValue(newVal);

                        const rowEl = cell.getRow().getElement();
                        if (newVal === "Y") {
                            rowEl.style.color = "red";
                        } else {
                            rowEl.style.color = "black";
                        }
                        const input = cell.getElement().querySelector("input");
                        if (input) input.checked = newVal === "Y";
                    }
                },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 100,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    editable: false,
                    formatter: function (cell) {
                        const checked = cell.getValue() === "Y" ? "checked" : "";
                        return `<input type="checkbox" ${checked} />`;
                    },
                    cellClick: function (e, cell) {

                        let newVal = cell.getValue() === "Y" ? "N" : "Y";
                        cell.setValue(newVal);
                        const icon = cell.getRow()
                            .getCell("action")
                            ?.getElement()
                            ?.querySelector("i.fa-trash");

                        if (icon) icon.style.display = newVal === "Y" ? "none" : "";

                        const input = cell.getElement().querySelector("input");
                        if (input) input.checked = newVal === "Y";
                    }
                },
                { title: "ADMINYN", field: "ADMINYN", headerHozAlign: "center", visible: false },
                { title: "IsRollOver", field: "IsRollOver", headerHozAlign: "center", visible: false },
                { title: "Order By", field: "OrderedBy", headerHozAlign: "center", editable: false },
                { title: "OrderedDate", field: "OrderedDate", headerHozAlign: "center", visible: false },
                { title: "OrderedTime", field: "OrderedTime", headerHozAlign: "center", visible: false }
            ],
            rowFormatter: function (row) {
                const d = row.getData();
                row.getElement().classList.toggle("Omited", d.OMIT === "Y");
            },

            data: []
        });

    });

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
            SpiDGSTARTDATE: GetToday_DDMMYYYY()
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

        input.addEventListener("keypress", function (e) {
            if (!/[0-9]/.test(e.key)) {
                e.preventDefault();
            }
        });

        input.addEventListener("blur", function () {
            success(input.value);
        });

        return input;
    }
</script>

<%-- Blood Product --%>
<script type="text/javascript">
    var BloodProductTable;
    var MediciTypeLStr = '';
    var BloodProductList = [];
    var IsOnlyDisplay = false;

    load_BloodProductList();

    $(document).ready(function () {
        BloodProductTable = new Tabulator("#BloodProductTable", {
            layout: "fitColumns",
            autoResize: false, // keep column width stable
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
                    title: "<i class='fa fa-plus text-success' style='color: yellow!important'  onclick='AddBloodProductRow()'></i>",
                    field: "action",
                    width: 50,
                    hozAlign: "center",
                    headerHozAlign: "center",
                    formatter: function (cell) {
                        return cell.getRow().getData().OMIT === "Y"
                            ? ""
                            : "<i class='fa fa-trash text-danger'></i>";
                    },
                    cellClick: function (e, cell) {
                        if (cell.getRow().getData().OMIT !== "Y") {
                            cell.getRow().delete();
                        }
                    }
                },
                { title: "QTY", field: "Dose", headerHozAlign: "center", editor: "input" },
                { title: "Duration", field: "Duration", headerHozAlign: "center", editor: "input", visible: false },
                { title: "Type", field: "Type", headerHozAlign: "center", editor: "select", editorParams: { values: MediciTypeLStr }, visible: false },
                {
                    title: "Blood / Blood Products",
                    field: "DrugName",
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
                                DayOfDrug: 1,
                                HighAlertMed: ""
                            });
                            row.getElement().classList.add("HighAlertDrug");
                        }
                    }
                },
                { title: "Day", field: "DayOfDrug", headerHozAlign: "center", visible: false },
                { title: "Route", field: "Route", headerHozAlign: "center", editor: "select", visible: false },
                { title: "Freq", field: "Freq", headerHozAlign: "center", editor: "input", visible: false },
                { title: "Remark", field: "Remark", headerHozAlign: "center", editor: "textarea" },
                { title: "Diluent", field: "Diluent", headerHozAlign: "center", editor: "input", visible: false },
                {
                    title: "<span style='color:red'>Volume / ml</span>",
                    field: "DilutionVolume",
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    cellEdited: calculateBloodProduct
                },
                {
                    title: "<span style='color:red'>Transfusion rate (ml/hr)</span>",
                    field: "INFRATE",
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    cellEdited: calculateBloodProduct
                },
                {
                    title: "Dur.of Admn(hrs)",
                    field: "AdminstrDuration",
                    headerHozAlign: "center",
                    editor: numericOnlyEditor,
                    cellEdited: calculateBloodProduct
                },
                { title: "Drop rate(drops/mt)", field: "MACROSET", headerHozAlign: "center", editable: false },
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
                    hozAlign: "center",
                    headerHozAlign: "center",
                    width: 100,
                    formatter: function (cell) {
                        const checked = cell.getValue() === "Y" ? "checked" : "";
                        return `<input type="checkbox" ${checked}/>`;
                    },
                    cellClick: function (e, cell) {
                        let newVal = cell.getValue() === "Y" ? "N" : "Y";
                        cell.setValue(newVal);
                        const icon = cell.getRow().getCell("action")?.getElement()?.querySelector("i.fa-trash");
                        if (icon) icon.style.display = newVal === "Y" ? "none" : "";
                    }
                },
                { title: "Order By", field: "OrderedBy", headerHozAlign: "center", editable: false },
                { field: "OrderedDate", visible: false },
                { field: "OrderedTime", visible: false },
                { field: "DrugCode", visible: false },
                { field: "TypeCode", visible: false },
                { field: "SQNumber", visible: false },
                { field: "HighAlert", visible: false },
                { field: "NotifyYN", visible: false },
                { field: "Status", visible: false },
                { field: "MEDSTAT", visible: false },
                { field: "ADMINYN", visible: false },
                { field: "IsRollOver", visible: false }
            ],

            rowFormatter: function (row) {
                const d = row.getData();
                row.getElement().classList.toggle("Omited", d.OMIT === "Y");
            },

            data: [] // Start with one initial row
        });

        if (IsOnlyDisplay) {
            BloodProductTable.hideColumn("action");
        }
    });

    function load_BloodProductList() {
        $.ajax({
            url: 'GetBloodProductList',
            type: 'GET',
            async: false, // Maintain sync for initial variable population
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
        const volume = Number(d.DilutionVolume || 0);
        let rate = Number(d.INFRATE || 0);
        let duration = Number(d.AdminstrDuration || 0);

        if (volume > 0 && rate > 0) {
            duration = volume / rate;
        } else if (volume > 0 && duration > 0) {
            rate = volume / duration;
        } else {
            row.update({ INFRATE: null, AdminstrDuration: null, MACROSET: null });
            return;
        }

        row.update({
            INFRATE: Math.round(rate),
            AdminstrDuration: Math.round(duration),
            MACROSET: Math.round((volume * 20) / (duration * 60))
        });
    }

    function AddBloodProductRow() {
        const rows = BloodProductTable.getData();
        if (rows.length > 0 && !rows[rows.length - 1].DrugName) {
            if (typeof ToastMsg === 'function') ToastMsg("Please fill first Blood Product row before adding new row.", "information");
            return;
        }
        BloodProductTable.addRow({
            BPSTARTDATE: GetToday_DDMMYYYY()
        });
    }

    function numericOnlyEditor(cell, onRendered, success, cancel) {
        let input = document.createElement("input");
        input.type = "text";
        input.value = cell.getValue() || "";
        input.style.width = "100%";
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
            //columns: [
            //    {
            //        title: "Action",
            //        field: "action",
            //        width: 60,
            //        headerSort: false,
            //        hozAlign: "center",
            //        formatter: function (cell) {
            //            const data = cell.getRow().getData();
            //            if (data.OMIT === "Y") return "";

            //            return "<i class='fa fa-info-circle' style='color:green;font-size:16px;cursor:pointer'></i>";
            //        }
            //    },
            //    { title: "Day", field: "DayOfDrug", editor: "input", width: 60 },
            //    { title: "Drug Form", field: "Type", editor: "list" },
            //    {
            //        title: "Chemo Medication",
            //        field: "DrugName",
            //        formatter: function (cell) {
            //            let row = cell.getData();
            //            let val = cell.getValue() || "";
            //            let icons = "";
            //            if (row.ISSUEYN === "Y") icons += " <img src='../Images/Check.png' />";
            //            if (row.INDENTYN === "Y") icons += " <img src='../Images/pills.png' />";
            //            return val + icons;
            //        }
            //    },
            //    { title: "Dose", field: "Dose", editor: "input" },
            //    { title: "Route", field: "Route" },
            //    { title: "Frequency", field: "Freq" },
            //    { title: "Remark", field: "Remark", editor: "textarea" },
            //    { title: "Diluent", field: "Diluent" },
            //    { title: "Dur. of Admn.", field: "Duration" },
            //    {
            //        title: "Start Date",
            //        field: "StartDate",
            //        editor: "input",
            //        editorParams: { elementAttributes: { type: "date" } }
            //    },
            //    {
            //        title: "OMIT",
            //        field: "OMIT",
            //        width: 60,
            //        headerSort: false,
            //        hozAlign: "center",
            //        formatter: function (cell) {
            //            const isChecked = cell.getValue() === "Y" ? "checked" : "";
            //            return `<input type="checkbox" ${isChecked} style="cursor:pointer;" />`;
            //        },
            //        cellClick: function (e, cell) {
            //            const newVal = cell.getValue() === "Y" ? "N" : "Y";
            //            const row = cell.getRow();
            //            row.update({ OMIT: newVal }).then(() => {
            //                row.reformat();
            //            });
            //        }
            //    },
            //    { title: "Order By", field: "OrderBy" },
            //    { title: "Original Dose Form", field: "OriginalDose" },
            //    {
            //        title: "Hold Log",
            //        field: "HoldLog",
            //        width: 75,
            //        headerSort: false,
            //        hozAlign: "center",
            //        formatter: function (cell) {
            //            return "<i class='fa fa-info-circle' style='color:#555;font-size:16px;cursor:pointer'></i>";
            //        }
            //    },
            //    { title: "Prescribe By", field: "PrescribeBy" },
            //    { title: "DrugCode", field: "DrugCode", visible: false }
            //],
            columns: [
                {
                    title: "Action",
                    field: "action",
                    width: 60,
                    headerSort: false,
                    hozAlign: "center",
                    formatter: function (cell) {
                        const data = cell.getRow().getData();
                        if (data.OMIT === "Y") return "";

                        return "<i class='fa fa-info-circle' style='color:green;font-size:16px;cursor:pointer'></i>";
                    }
                },
                { title: "Day", field: "DAY", editor: "input", width: 60 },
                { title: "Drug Form", field: "DRUGFORM", editor: "list" },
                {
                    title: "Chemo Medication",
                    field: "CHEMODRUGNAME",
                    formatter: function (cell) {
                        let row = cell.getData();
                        let val = cell.getValue() || "";
                        let icons = "";
                        if (row.ISSUEYN === "Y") icons += " <img src='../Images/Check.png' />";
                        if (row.INDENTYN === "Y") icons += " <img src='../Images/pills.png' />";
                        return val + icons;
                    }
                },
                { title: "Dose", field: "DOSE", editor: "input" },
                { title: "Route", field: "ROUTE" },
                { title: "Frequency", field: "FREQ" },
                {
                    title: "Remark", field: "REMARK", editor: "textarea",
                    cssClass: "TabTextArea"
                },
                { title: "Diluent", field: "DILUENT" },
                { title: "Dur. of Admn.", field: "DURATION" },
                {
                    title: "Start Date",
                    field: "STARTDT",
                    editor: "input",
                    editorParams: { elementAttributes: { type: "date" } }
                },
                {
                    title: "OMIT",
                    field: "OMIT",
                    width: 60,
                    headerSort: false,
                    hozAlign: "center",
                    formatter: function (cell) {
                        const isChecked = cell.getValue() === "Y" ? "checked" : "";
                        return `<input type="checkbox" ${isChecked} style="cursor:pointer;" />`;
                    },
                    cellClick: function (e, cell) {
                        const newVal = cell.getValue() === "Y" ? "N" : "Y";
                        const row = cell.getRow();
                        row.update({ OMIT: newVal }).then(() => {
                            row.reformat();
                        });
                    }
                },
                { title: "Order By", field: "ORDERBY" },
                { title: "Original Dose Form", field: "OGDOSE" },
                {
                    title: "Hold Log",
                    field: "HOLDLOG",
                    width: 75,
                    headerSort: false,
                    hozAlign: "center",
                    formatter: function (cell) {
                        return "<i class='fa fa-info-circle' style='color:#555;font-size:16px;cursor:pointer'></i>";
                    }
                },
                { title: "Prescribe By", field: "PRESCRIBEBY" },
                { title: "DrugCode", field: "DRUGCODE", visible: false },
                {
                    title: "HighAlert", field: "HighAlert", visible: false,
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
            }
        });
    }

    function ProcessChemoData() {
        var params = {
            strPrtocolCD: "084", //$("#ddlProtocol").val(),
            MRNO: "", // $("#txtMRNO").val() || "",  //88541
            HEIGHT: "130", //$("#txtHeight").val() || "",
            WEIGHT: "50", //$("#txtWeight").val() || "",
            BSA: "1.34", //$("#txtBSA").val() || "",
            DayNo: "1",
            calcDose: true,
            CycleNo: $(".text-center.fw-bold").val(),
        };
        $.ajax({
            type: "GET",
            url: "../SinglePage/BindChemoData",
            data: params,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response?.DilutionY?.length > 0) {
                    ChemoListtable.setData(response.DilutionY);
                    console.log(ChemoListtable);
                    var modalElement = document.getElementById('commonPopupModal');
                    var modal = bootstrap.Modal.getInstance(modalElement);
                    modal.hide();
                    ToastMsg("Data Loaded Successfully", "success");
                } else {
                    ToastMsg("No data found for this protocol", "warning");
                }
            },
            error: function (err) {
                ToastMsg(err, "error");
            }
        });
    }

    $(document).ready(function () {
        TabulatorGetChemo();
        $("#btnChemoMed").click(function () {
            var chemoContent = $("#ChemoProtocolTemplate").html();
            $("#commonPopupBody").html(chemoContent);
            $("#commonPopupTitle").text("Chemo Protocol Details");
            var myModal = new bootstrap.Modal(document.getElementById('commonPopupModal'));
            myModal.show();
            GetProtocolCode();
        });
    });

    function formatDate(str) {
        if (!str || str.length !== 8) return str;
        return `${str.substring(6, 8)}/${str.substring(4, 6)}/${str.substring(0, 4)}`;
    }

    function GetProtocolCode() {
        var MRNO = "RH125001415"; // $("#txtstrUMrNo").val();
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

    function bindProtocolData(data) {
        if (data.rows && data.rows.length > 0) {
            const item = data.rows[0];
            const container = $("#commonPopupBody");
            container.find('#ddlProtocol').html(`<option value="${item.CODE}">${item.PROTONAME}</option>`);
            container.find('#txtPlanNo').val(item.PlanID);
            container.find('#txtPlanDate').val(formatDate(item.PlanDate));
            container.find('#txtCourse').val(item.COURSENM);
            container.find('#txtTotalCycles').val(item.TotalCycle);
            container.find('#txtCurrentCycle').val(item.CycleNo);
            container.find('#txtStartDate').val(formatDate(item.STARTDATE));
        }
    }
</script>

<div id="sec-Invstg" class="opd-section-card anchor-offset">
    <h4 class="section-title me-5">Treatment Order</h4>

    <%-- Investigations --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Investigation</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="InvstgSearch" class="form-control" placeholder="Search In" oninput="FilterBindedSearchListForInvstg()">
                <button class="btn btn-outline-success" id="Invstg_PrevHistory" onclick="HistoryPopupOpen('Invstg History', 'Invstg',true)"><i class="fa fa-history"></i></button>
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
        <h6 class="fw-bold">Medicine</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="MedicineSearch" class="form-control" placeholder="Search In" oninput="FilterBindedSearchListForMedicine()">
                <button class="btn btn-outline-success" id="" onclick="OpenPopupForNewItem('Medicine' , 'Medicine')">
                    <i class="fa fa-plus"></i>
                </button>
                <button class="btn btn-outline-success" id="Medicine_PrevHistory" onclick="HistoryPopupOpen('Medicine History', 'Medicine',true)"><i class="fa fa-history"></i></button>
            </div>
            <div id="MedicineListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="MedicineList" class="list-group w-100"></div>
                <div id='loading-Medicine-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="MedicineTable"></div>
    <hr class="my-3">

    <%-- Chemo --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Chemo</h6>
        <div class="flex-grow-1 position-relative ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="ChemoSearch" class="form-control" placeholder="Search In" oninput="FilterBindedSearchListForChemo()" style="visibility: collapse">
                <%-- <button class="btn btn-outline-success" id="btnChemoMed"><i class="fa fa-plus"></i></button>--%>
                <button type="button" class="btn btn-save-draft btn-sm me-2" id="btnChemoMed">Chemo Medication</button>
                <button class="btn btn-outline-success" onclick="HistoryPopupOpen('Chemo History', 'Chemo',true)"><i class="fa fa-history"></i></button>
            </div>
            <div id="ChemoListMainDiv" class="list-group position-absolute w-100" style="z-index: 1050; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="ChemoList" class="list-group w-100"></div>
            </div>
        </div>
    </div>

    <div id="ChemoTable"></div>
    <div id="ChemoProtocolTemplate" style="display: none;">
        <div class="container-fluid py-3 border rounded" style="background-color: #f8f9fa;">
            <div class="row mb-3 g-2 align-items-center">
                <div class="col-md-auto">
                    <label class="fw-bold small">Protocol:</label>
                </div>
                <div class="col-md-4">
                    <select class="form-select form-select-sm border-start border-danger border-3" id="ddlProtocol">
                    </select>
                </div>
                <div class="col-md-auto ms-auto">
                    <label class="fw-bold small">Plan&nbsp;No.</label>
                </div>
                <div class="col-md-2">
                    <input type="text" id="txtPlanNo" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
                <div class="col-md-auto">
                    <label class="fw-bold small">Plan&nbsp;Date</label>
                </div>
                <div class="col-md-2">
                    <input type="text" id="txtPlanDate" class="form-control form-control-sm bg-light text-center" readonly>
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
                    <input type="text" id="txtCurrentCycle" class="form-control form-control-sm text-center fw-bold" style="background-color: #ffff00;">
                </div>
                <div class="col-md-auto">
                    <label class="fw-bold small">Start Date</label>
                </div>
                <div class="col-md-2">
                    <input type="text" id="txtStartDate" class="form-control form-control-sm bg-light text-center" readonly>
                </div>
            </div>
            <div class="row">
                <div class="col-12 text-center">
                    <button type="button" class="btn text-white" style="background-color: #ff5722; border-radius: 8px;" onclick="ProcessChemoData();">Continue</button>
                </div>
            </div>
        </div>
    </div>
    <hr class="my-3">

    <%-- Infusion --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Infusion</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
            </div>
            <div id="InfusionListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="InfusionList" class="list-group w-100"></div>
                <div id='loading-Infusion-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="InfusionTable"></div>
    <div class="input-group input-group-sm w-100" style="margin: 15px 0px;">
        <h6 class="fw-bold" style="padding: 15px 0px;">Remark</h6>
        <textarea class="form-control mb-4" id="Infusion_Freetext" name="Infusion_Freetext" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none; margin: 0px 10px;"></textarea>
    </div>
    <div id='loading-Infusion' class='loading-screen' style='display: none; opacity: 0;'></div>

    <hr class="my-3">

    <%-- IV Supplements --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">IV Supplements</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
            </div>
            <div id="IVSUPListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id='loading-IVSUP-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="IVFluidTable"></div>
    <hr class="my-3">

    <%-- Blood Products --%>
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h6 class="fw-bold">Blood Product</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
            </div>
            <div id="BloodProductMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id='loading-BloodProduct-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="BloodProductTable"></div>
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

