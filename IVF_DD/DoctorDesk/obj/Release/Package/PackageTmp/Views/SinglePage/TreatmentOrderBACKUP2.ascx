<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<%-- Global Declaration --%>
<script type="text/javascript">

    var IPNO = "9064";
    var MRno = "RH125001138";
    var PatName = "Suhan  Khan";

    var MandStyle = '<span style="color:red;">';
    var IsOnlyDisplay = false;
    var IsPastDate = false;
    var IsrolloverData = 'N';
    var ISRYN = '';
    var IS_DISPLAY_CIMS_FUNCTIONLITY = 'Y';
    var strGlobDilutionVol = { "10": "10", "20": "20", "50": "50" };
    var strGlobAdmnDuration = { "15min": "15min", "30min": "30min", "1hr": "1hr" };
    var MedicineRoutelLst = { "PO": "Oral", "IV": "Intravenous", "IM": "Intramuscular" };
    var MaxSEQ = "";
</script>
<%-- End Global Declaration --%>

<%-- Common Function --%>
<script type="text/javascript">
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
            title: "Action", field: "action", hozAlign: "center", formatter: function (cell) { return "<span class='ui-icon ui-icon-trash ui-inline-custom' title='Delete'></span>"; },
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
                mergeCellsBySetNo(TrmtntOrderMedicineTable);
            }
        }
    }

    // Day of Drug
    function getDayOfDrugColumn() {
        return {
            title: "Day Of Drug",
            field: "DayOfDrug",
            width: 45,
            hozAlign: "right",
            headerSort: false,
            editor: "input",
            editorParams: { maxLength: 70 }
        };
    }

    // Dose
    function getDoseColumn() {
        return {
            title: "Dose",
            field: "Dose",
            width: 100,
            hozAlign: "left",
            headerSort: false,
            editor: false
        };
    }

    // Route
    function getRouteColumn() {
        return {
            title: "Route",
            field: "Route",
            width: 150,
            hozAlign: "left",
            headerSort: false,
            editor: "select",
            editorParams: { values: MedicineRoutelLst }
        };
    }

    // Frequency
    function getFreqColumn() {
        return {
            title: "Freq",
            field: "Freq",
            width: 44,
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
            width: 40,
            hozAlign: "center",
            editor: "tickCross",
            formatter: "tickCross"
        };
    }

    // Remark
    function getRemarkColumn() {
        return {
            title: "Remark",
            field: "Remark",
            width: 150,
            hozAlign: "left",
            headerSort: false,
            editor: "input",
            editorParams: { maxLength: 150 }
        };
    }

    //Log Info
    function LogInfo(cellvalue, options, rowObject) {
        if (!rowObject.DrugName) {
            return '';
        }

        var rowId = options.rowId;
        return '<span class="ui-icon ui-icon-info holdlog-icon" ' +
            'data-tranno="' + rowObject.TranNo + '" ' +
            'data-sqno="' + rowObject.SQNumber + '" ' +
            'data-typecode="' + rowObject.TypeCode + '" ' +
            'data-drugcode="' + rowObject.DrugCode + '"' +
            'title="Get Hold Log" ' +
            'style="cursor:pointer;color:blue;"></span>';
    }

    // Omitted By/Date/Time
    function getOmittedByColumn() { return { title: "Omitted By", field: "OmittedBy", width: 110, visible: false }; }
    function getOmittedDateColumn() { return { title: "Omitted Date", field: "OmittedDate", width: 110, visible: false }; }
    function getOmittedTimeColumn() { return { title: "Omitted Time", field: "OmittedTime", width: 110, visible: false }; }

    // Ordered By/Date/Time
    function getOrderedByColumn() { return { title: "Ordered By", field: "OrderedBy", width: 100 }; }
    function getOrderedDateColumn() { return { title: "Ordered Date", field: "OrderedDate", width: 80, visible: false }; }
    function getOrderedTimeColumn() { return { title: "Ordered Time", field: "OrderedTime", width: 80, visible: false }; }

    // Sequence / Flags
    function GetDrugSequenceNo() { return { title: "SQNumber", field: "SQNumber", visible: false }; }
    function GetHighAlertDrug() { return { title: "HighAlert", field: "HighAlert", visible: false }; }
    function GetNotifyYN() { return { title: "NOTIFYN", field: "NOTIFYN", visible: false }; }
    function GetStatus() { return { title: "STATUS", field: "STATUS", visible: false }; }
    function GetADMINYN() { return { title: "ADMINYN", field: "ADMINYN", visible: false }; }
</script>
<%-- End Common Function --%>



<%-- Medicine Scrit --%>
<script type="text/javascript">
    var TrmtntOrderMedicineTable;
    $(document).ready(function () {
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
                getActionColumn(),
                getDayOfDrugColumn(),
                {
                    title: "Duration",
                    field: "Duration",
                    width: 60,
                    hozAlign: "right",
                    editor: "input",
                    validator: ["numeric"]
                },
                {
                    title: "Type",
                    field: "Type",
                    width: 40,
                    editor: "select",
                    editorParams: { values: GrdAnitibioticType() }
                },
                {
                    title: "Drug Name",
                    field: "DrugName",
                    width: 210,
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
                getRouteColumn(),
                getFreqColumn(),
                getRemarkColumn(),
                {
                    title: "Diluent",
                    field: "Diluent",
                    width: 50,
                    editor: "input",
                    editorParams: { maxLength: 100 }
                },
                {
                    title: "Dilution Volume",
                    field: "DilutionVolume",
                    width: 58,
                    editor: "select",
                    editorParams: { values: strGlobDilutionVol }
                },
                {
                    title: "Admin Duration",
                    field: "AdminstrDuration",
                    width: 90,
                    editor: "select",
                    editorParams: { values: strGlobAdmnDuration }
                },
                {
                    title: "Start Date",
                    field: "AntiBoDGSTARTDATE",
                    width: 76,
                    editor: "input",
                    editorParams: { elementAttributes: { type: "date" } }
                },
                getOmitColumn(),
                { title: "DrugCode", field: "DrugCode", visible: false },
                { title: "TypeCode", field: "TypeCode", visible: false },
                getOmittedByColumn(),
                getOmittedDateColumn(),
                getOmittedTimeColumn(),
                getOrderedByColumn(),
                getOrderedDateColumn(),
                getOrderedTimeColumn(),
                GetDrugSequenceNo(),
                GetHighAlertDrug(),
                GetNotifyYN(),
                GetStatus(),
                GetADMINYN(),
                { title: "MEDSTAT", field: "MEDSTAT", visible: false },
                { title: "HOLD", field: "HOLD", visible: false },
                {
                    title: "Hold Log",
                    field: "HoldLog",
                    width: 50,
                    formatter: LogInfo,
                    mutator: function () { return ""; }
                },
                { title: "ISSUEYN", field: "ISSUEYN", visible: false },
                { title: "INDENTYN", field: "INDENTYN", visible: false },
                { title: "IsRollOver", field: "IsRollOver", visible: false }
            ],

            // Row styling
            rowFormatter: function (row) {
                let data = row.getData();
                if (data.HighAlert === "Y") row.getElement().classList.add("HighAlertDrug");
                if (data.OMIT === "Y") row.getElement().classList.add("Omited");
                if (data.STATUS === "C") row.getElement().classList.add("cancellation");
                if (data.IsRollOver === "Y") {
                    row.getElement().style.backgroundColor = "yellow";
                    row.getElement().style.fontWeight = "bold";
                }
            },

            // Cell click logic
            cellClick: function (e, cell) {
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
                    if (IS_DISPLAY_CIMS_FUNCTIONLITY === "Y") {
                        AddCIMSInfoBtn(TrmtntOrderMedicineTable, row.SQNumber);
                    }
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
                    toogleButtons("TrmtntOrderMedicineTable", "A");
                }
            }
        });



        TrmtntOrderMedicineTable.on("cellEdited", function (cell) {
            cell.getRow().normalizeHeight();
            adjustTableHeight("TrmtntOrderMedicineTable");
        });

        TrmtntOrderMedicineTable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("TrmtntOrderMedicineTable");
        });

        TrmtntOrderMedicineTable.on("rowDeleted", function (row) {
            adjustTableHeight("TrmtntOrderMedicineTable");
        });

        TrmtntOrderMedicineTable.on("dataLoaded", function () {
            adjustTableHeight("TrmtntOrderMedicineTable");
        });

        TrmtntOrderMedicineTable.on("tableBuilt", function () {
            adjustTableHeight("TrmtntOrderMedicineTable");
        });

        TrmtntOrderMedicineTable.on("dataChanged", function () {
            adjustTableHeight("TrmtntOrderMedicineTable");
        });

        $(document).on("click", ".Medicine-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = TrmtntOrderMedicineTable.getData();
            //if (rows.some(row => row.DRUGCD === code)) {
            //    ToastMsg("Medicine already added", "warning");
            //    $("#MedicineListMainDiv").hide();
            //    return;
            //}
            $('#DSMedicineName').text(name + " (" + name + ")");
            $('#DSMedicineCode').text(code);
            $('#DSGenericName').text(name);
            $("#MedicineSearch").val("");
            $("#MedicineListMainDiv").hide();
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
        $(".btn-group > .btn").click(function () {
            $(".btn-group > .btn").removeClass("active");
            $(this).addClass("active");
        });
        BindTreatmentOrderData();
    });

    function BindTreatmentOrderData() {
        GetDBMaxSEQNO();
    }

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
                var ListOption = '<div class="list-group-item Medicine-row" data-code="' + item.CODE + '" data-name="' + item.NAME + '" style="cursor:pointer;">' + item.NAME + '</div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#MedicineList").append(AppendContentList);
        $("#MedicineListMainDiv").show();
    }

</script>

<%-- Dose Popup Only --%>
<style>
        .BtnInke {
            /*//width: 56px;*/
            width: 60px; /*///changes by vishal as on 22 Aug 2018 width before it was 56px;*/
            border-radius: 5px 5px 5px 5px;
            height: 28px;
            text-align: center;
            margin-right: 20px;
            background-color: rgba(76, 228, 76, 0.67);
            cursor: pointer;
            display: inline-block !important;
            max-width: 100%;
            margin-bottom: 5px !important;
        }


    /* Overlay */
.dose-popup-overlay {
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

/* Popup Container */
.dose-popup {
  background: #fff;
  border-radius: 12px;
  width: 600px;
  max-width: 90%;
  padding: 20px;
  box-shadow: 0 8px 25px rgba(0,0,0,0.3);
  animation: popupFade 0.3s ease-in-out;
}

/* Title */
.dose-title {
  font-size: 20px;
  font-weight: bold;
  color: #2c3e50;
  text-align: center;
  margin-bottom: 15px;
}

/* Row Layout */
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

/* Buttons */
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

/* Intake Controls */
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

/* Action Buttons */
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

.action-btn.primary { background: #3498db; color: #fff; }
.action-btn.secondary { background: #95a5a6; color: #fff; }
.action-btn.danger { background: #e74c3c; color: #fff; }

.action-btn:hover { opacity: 0.85; }

/* Animation */
@keyframes popupFade {
  from { transform: scale(0.9); opacity: 0; }
  to { transform: scale(1); opacity: 1; }
}

</style>

<script>
    // Function to open the popup
    function openDosePopup() {
        ClearDose();
        $("#btn2").click();
        document.getElementById("dosePopupOverlay").style.display = "flex";
    }

    // Function to close the popup
    function closeDosePopup() {
        $('#DSMedicineName').text("");
        $('#DSMedicineCode').text("");
        $('#DSGenericName').text("");
        document.getElementById("dosePopupOverlay").style.display = "none";
    }

    function ClearNewDrugdata() {
        $('#txtMedicineName').val("");
        $('#txtGenericName').val("");
        $('#txtBrandName').val("");
        $('#ChkHighAlt')[0].checked = false;
    }

    function RemoveIntakeSpan() {
        $('#btnCalulatedIntaKe label:last-child').remove();
    }

    function CallIntakeFreqChange(obj) {
        var freq = $(obj).val();
        if (freq != "Other") {
            $('.IntakeAdder').find('label').addClass('avoid-clicks');
            $('#btnCalulatedIntaKe label').remove();
            var NewSpan = '<label class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;">0</span></label>';
            $('#btnCalulatedIntaKe').append(NewSpan);
        }
        else {
            $('.IntakeAdder').find('label').removeClass('avoid-clicks');
        }
    }

    function CalculateDose(obj) {
        var IntakeVal = $('.btn-group').children('.active').val();
        var ChildSpan = $(obj).children();
        var resval = Number($(ChildSpan).text()) + Number(IntakeVal);           
        $(ChildSpan).text(Number(resval.toFixed(3)));
    }



    function DoseCombination() {

        if ($('#cmbFrequency').val() == "" || $('#cmbFrequency').val() == null)                            ///added by vishal as on 22nd Aug 2018 for Unit Validations
        {
            $('#cmbFrequency').css('border-color', 'red'); $('#cmbFrequency').css('border-width', '2px'); $('#cmbFrequency').focus();
            return false;
        }
        if ($('#cmbUnit').val() == "")                            ///added by vishal as on 22nd Aug 2018 for Unit Validations
        {
            $('#cmbUnit').css('border-color', 'red'); $('#cmbUnit').css('border-width', '2px'); $('#cmbUnit').focus();
            return false;
        }

        var AllbtnIntake = $('#btnCalulatedIntaKe').children();
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
        InitializeArray(arrCom);
        $.each(AllbtnIntake, function (Index, Element) {
            MediCode = $('#DSMedicineCode').text().trim().replace(/[^0-9a-zA-Z]/gi, '');
            MediName = $('#DSMedicineName').text().trim();
            MediGenNM = $('#DSGenericName').text().trim();
            MediBrndNM = $('#DSBrandName').text().trim();
            MediHighAlt = $('#DSHighAlt').text().trim();
            MediQOH = $('#DSQOH').text().trim();
            DrugForm = $('#DSDrugForm').text().trim();
            Dilution = $('#DSDilution').text().trim();
            var Dose = $(Element).children().text();
            if (Number(Dose) > 0) {
                arrCom[Index] = 1;
                flag = false;
                if (cmbFeq == "Other") {
                    CreateDoseRows(Index, Dose, arrCom, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, DrugForm, Dilution);
                }
                else {
                    CreateSingleRecord(Dose, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, cmbFeq, DrugForm, Dilution);
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

    function AddDefaultIntakeSpan() {

        $('#btnCalulatedIntaKe label').remove();

        for (i = 0; i < 3; i++) {
            var NewSpan = '<label class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;">0</span></label>';   ///changes by vishal as on 22 Aug 2018 font size before it was 18px;
            $('#btnCalulatedIntaKe').append(NewSpan);
        }

        $(".BtnInke").on('mousedown', function () {
            startTime = new Date().getTime();
        });

        $(".BtnInke").on('mouseup', function () {
            endTime = new Date().getTime();
            //longpress = (endTime - startTime > 100) ? true : false;
        });

        $("#cmbFrequency").change();
    }

    function AddIntakeSpan() {
        var NewSpan = '<label class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;">0</span></label>';     ///changes by vishal as on 22 Aug 2018 font size before it was 18px;
        $('#btnCalulatedIntaKe').append(NewSpan);

        $(".BtnInke").on('mousedown', function () {
            startTime = new Date().getTime();
        });

        $(".BtnInke").on('mouseup', function () {
            endTime = new Date().getTime();
            //longpress = (endTime - startTime > 500) ? true : false;
        });
    }

    function ClearDose() {                                 //vishal 14th Nov         
        //var obje = $("#AddMultiDose").find('.BtnInke')
        var ChildSpan = $("#AddMultiDose").find('label.BtnInke')[0];
        $(ChildSpan).text(0);
        var ChildSpan1 = $("#AddMultiDose").find('label.BtnInke')[1];
        $(ChildSpan1).text(0);
        var ChildSpan2 = $("#AddMultiDose").find('label.BtnInke')[2];
        $(ChildSpan2).text(0);
        AddDefaultIntakeSpan();
    }
    /*-----Function for Remove element from TblMultipleDose if Unselect Medicine--------------*/

    function RemoveMultiDose(MediCode) {
        $("#TblMultipleDose tbody").find('tr[name="' + MediCode + '"]').remove();
    }

    function CallIntakeFreqChange(obj) {
        var freq = $(obj).val();
        if (freq != "Other") {
            $('.IntakeAdder').find('label').addClass('avoid-clicks');
            $('#btnCalulatedIntaKe label').remove();
            var NewSpan = '<label class="BtnInke" onclick="CalculateDose(this)"><span style="font-size: 12px;">0</span></label>';
            $('#btnCalulatedIntaKe').append(NewSpan);
        }
        else {
            $('.IntakeAdder').find('label').removeClass('avoid-clicks');
        }
    }

    function CreateSingleRecord(Dose, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, feq, DrugForm, Dilution) {
        var Unit = "";
        var Unit = $('#cmbUnit').val().trim();
        if (Dose.toString().trim() == "") {
            Unit = ""; //If dose is 0 or empty then Unit should be empty
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
            + "<td class='Dilution'>" + Dilution + "</td>";
        +"</tr>"
        $("#TblMultipleDose tbody").append(tr);
    }

    function CreateDoseRows(Index, Dose, arrCom, MediCode, MediName, MediGenNM, MediBrndNM, MediHighAlt, MediQOH, DrugForm, Dilution) {
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
                + "<td class='Dilution'>" + Dilution + "</td>";
            +"</tr>"
            $("#TblMultipleDose tbody").append(tr);
        }
    }

    function AddItemToGrid() {
        var selectRows = $('#TblMultipleDose tbody tr').get();
        AddItemToTable(selectRows);
        closeDosePopup();
    }

    function AddItemToTable(obj) {
        var table = Tabulator.findTable("#TrmtntOrderMedicineTable")[0]; // get Tabulator instance
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

            var RowData = table.getData();
            var MaxSEQNO = GetMaxSEQNO("TrmtntOrderMedicineTable");

            GenericName = $(obj).find("td.GenriName").text();
            BrnadName = $(obj).find("td.BrandName").text();
            HighAlertVal = $(obj).find("td.HighAlert").text();
            Dose = $(obj).find("td.Dose").text();
            Fequency = $(obj).find("td.Feq").text();
            Unit = $(obj).find("td.Unit").text();
            Form = $(obj).find("td.DrugForm").text();
            Dilution = $(obj).find("td.Dilution").text();

            // Duplicate check
            var GetItem = RowData.filter(n => n["DrugCode"] != "");
            var AlredyAddItemChk = GetItem.filter(n => {
                var Doseval = n["Dose"].replace(/[^0-9\.]+/g, "").replace(/\./g, '_');
                var Duplicate = n["DrugCode"] + Doseval;
                return Duplicate == (MaterialCode + Dose.replace(/\./g, '_'));
            });

            $.each(AlredyAddItemChk, function (I, E) {
                if (E.hasOwnProperty('OMIT') || E.hasOwnProperty('cancellation')) {
                    Flag = (E.OMIT == "Y" || E.STATUS == "C");
                }
            });

            if (Flag) AlredyAddItemChk = {};

            if (AlredyAddItemChk.length > 0) {
                ToastMsg("This Record already Added In table", "warning");
            } else {
                var rowId = GetItem.length + 1;

                // Add new row if needed
                if (rowId == table.getData().length || table.getData().length == 0 || rowId > table.getData().length) {
                    var adddata = {};
                    adddata = {
                        action: "", Type: "", Medicine: "", DayOfDrug: "", Dose: "", Route: "", Freq: "",
                        OMIT: "", Remark: "", TypeCode: "AB", OmittedBy: '', OmittedDate: '', OmittedTime: '',
                        OrderedBy: '', OrderedDate: '', OrderedTime: '', STATUS: "A", MEDSTAT: "M", SQNumber: rowId
                    };
                    table.addRow(adddata, true);
                }

                // Update row values
                if (gCIMSYN == "Y") {
                    table.updateRow(rowId, {
                        ["DrugName"]: `<span class='fa fa-info-circle fa-1x medInfoSpan' style='font-size:1.5em' id="${MaterialCode}"></span> ${MaterialName} (${GenericName})`,
                        Type: Form,
                        ADMINYN: "N",
                        STATUS: "A",
                        Dose: Dose + " " + Unit,
                        Freq: Fequency,
                        Route: "Intra venous",
                        HighAlert: HighAlertVal
                    });
                    if (HighAlertVal == "Y") {
                        table.getRow(rowId).getElement().classList.add("HighAlertDrug");
                    }
                } else {
                    table.updateRow(rowId, {
                        ["DrugName"]: (BrnadName.toUpperCase().trim() != "" && BrnadName.toUpperCase().trim() != "NONE" && BrnadName.toUpperCase().trim() != "NA")
                            ? (BrnadName + " (" + GenericName + ")")
                            : MaterialName,
                        Type: Form,
                        ADMINYN: "N",
                        STATUS: "A",
                        Dose: Dose + " " + Unit,
                        Freq: Fequency,
                        Diluent: Dilution,
                        INDENTYN: "N",
                        ISSUEYN: "N",
                        IsRollOver: (ISRYN == "Y" ? "Y" : "N"),
                        Route: "Intra venous",
                        HighAlert: HighAlertVal
                    });
                    if (HighAlertVal == "Y") {
                        table.getRow(rowId).getElement().classList.add("HighAlertDrug");
                    }
                }

                // Common updates
                table.updateRow(rowId, {
                    ["DrugCode"]: MaterialCode,
                    OrderedBy: gDoctId,
                    OrderedDate: GetTodaysDate(),
                    OrderedTime: GetTimewithAMPM(),
                    NOTIFYN: "N",
                    HighAlert: HighAlertVal
                });
                SetStartDateColumn("TrmtntOrderMedicineTable", rowId);
                table.updateRow(rowId, { DayOfDrug: 1 });

                // Disable clicks on specific cell
                let row = table.getRow(rowId);
                let cell = row.getCell("AntiBoDGSTARTDATE");
                cell.getElement().classList.add("avoid-clicks");

                //AddDelButtonByNew(table, rowId);

                var data = table.getData();
                if (data.length > 0) {
                    for (var c = 0; c <= data.length - 1; c++) {
                        if (data[c]["OMIT"] == "N" && data[c]["ADMINYN"] == "N" && data[c]["NOTIFYN"] == "N") {
                            var rowEl = table.getRow(c + 1).getElement();
                            var check = rowEl.querySelector("input[type=checkbox]");
                            if (check) check.disabled = true;
                        } else if (data[c]["OMIT"] == "Y") {
                            table.updateRow(rowId, { OMIT: "N" });
                            var rowEl = table.getRow(c + 1).getElement();
                            var check = rowEl.querySelector("input[type=checkbox]");
                            if (check) check.disabled = true;
                        }
                    }
                }
                // Sequence number logic
                if (MaxSEQNO.length > 0) {
                    table.updateRow(rowId, { SQNumber: Number(MaxSEQNO[0].Column1) + 1 });
                    UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicineTable"), Number(MaxSEQNO[0].Column1) + 1);
                } else if (GetItem.length > 0) {
                    var lastSEQNum = GetItem[GetItem.length - 1].SQNumber;
                    table.updateRow(rowId, { SQNumber: Number(lastSEQNum) + 1 });
                    UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicineTable"), Number(lastSEQNum) + 1);
                } else {
                    table.updateRow(rowId, { SQNumber: GetItem.length + 1 });
                    UpdateMaxSEQNOArray(GetTypeCode("TrmtntOrderMedicineTable"), GetItem.length + 1);
                }
            }
        });
        MedicinColorIndications();
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

    function SetStartDateColumn(GridName, rowId) {
        TrmtntOrderMedicineTable.updateRow(rowId, {AntiBoDGSTARTDATE: GetTodaysDate()});
        //$("#" + GridName).jqGrid('setCell', rowId, 'AntiBoDGSTARTDATE', GetTodaysDate());
    }

    function GetTypeCode(selectorgrid) {
        var TypeValue = 'AB'
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
                mergeCellsBySetNo($grid);
            }
        })
            .css({ "margin-right": "5px", float: "left", cursor: "pointer" })
            .addClass("ui-pg-div ui-inline-custom")
            .append('<span class="ui-icon ui-icon-trash"></span>')
            .appendTo($td.children("div"));
    }


    function getColumnIndexByName(grid, columnName) {
        var cm = $("#JqGridMedication").jqGrid('getGridParam', 'colModel'), i, l = cm.length;
        for (i = 0; i < l; i++) {
            if (cm[i].name === columnName) {
                return i; // return the index
            }
        }
        return -1;
    }

    function MedicinColorIndications() {
        var Antibioticsdata = TrmtntOrderMedicineTable.getData().map(row => row.DrugCode);
        ArryMtrlCode = [];
        if (Antibioticsdata.length > 0) {
            for (var m = 0; m <= Antibioticsdata.length - 1; m++) {
                ArryMtrlCode.push(Antibioticsdata[m]);
            }
        }
        if (gCIMSYN == "Y")
            GetMaterialInteraction(ArryMtrlCode);
 
    }

    function mergeCellsBySetNo(grid) {
        var rowIds = grid.getDataIDs();
        var mergeCols = [
            'action', 'DayOfDrug', 'Duration', 'Route', 'Freq',
            'Diluent', 'DilutionVolume', 'AdminstrDuration',
            'AntiBoDGSTARTDATE', 'SetNo', 'AdministerSeq', 'DiluentGenericCode', "HOLD", "Hold Log", "OMIT"
        ];

        var setMap = {};
        rowIds.forEach(function (rid) {
            var rowData = grid.getRowData(rid);
            var setNo = rowData.SetNo;
            if (!setNo || setNo.trim() === "" || setNo === "0") return;
            if (!setMap[setNo]) setMap[setNo] = [];
            setMap[setNo].push(rid);
        });

        $.each(setMap, function (setNo, ids) {
            if (ids.length <= 1) return;

            mergeCols.forEach(function (col) {
                var firstCell = grid.find("tr#" + ids[0] + " td[aria-describedby='JqGridChemo_" + col + "']");
                var rowspan = 1;

                for (var i = 1; i < ids.length; i++) {
                    var nextCell = grid.find("tr#" + ids[i] + " td[aria-describedby='JqGridChemo_" + col + "']");
                    nextCell.hide();
                    rowspan++;
                }

                if (rowspan > 1) {
                    const style = {
                        "vertical-align": "middle",
                        "border": "1px solid #ccc"
                    };
                    if (col === 'SetNo') {
                        style["background-color"] = "#e6f4fa";
                        style["font-weight"] = "bold";
                    }
                    firstCell.attr("rowspan", rowspan).css(style);
                }
            });
        });
    }

    function InitializeArray(arrCom) {
        for (var i = 0; i < arrCom.length; i++) {
            arrCom[i] = 0;
        }
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
</script>

<%-- End Medicine Script --%>



<div id="sec-TreatmentOrder" class="opd-section-card anchor-offset">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h4 class="section-title me-5">Treatment Order</h4>
        <input type="text" id="txtTransDate" />
    </div>

    <%-- Medicine--%>
    <div class="d-flex justify-content-between mt-3 mb-3 align-items-center">
        <h6 class="fw-bold mb-0">Medicine</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="MedicineSearch" class="form-control" placeholder="Search Medicine" oninput="FilterBindedSearchListForMedicine()">
            </div>
            <div id="MedicineListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="MedicineList" class="list-group w-100"></div>
                <div id='loading-Medicine-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="TrmtntOrderMedicineTable" style="margin: 10px 10px;"></div>


<!-- Popup Overlay -->
<div class="dose-popup-overlay" id="dosePopupOverlay" style="display:none;">
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
          <option value="Other">Other</option>
        </select>

        <label class="dose-label">Drug Unit:</label>
        <select id="cmbUnit" class="dose-select">
          <option value="">---Select---</option>
          <option value="MG">MG</option>
          <option value="ML">ML</option>
          <option value="TAB">TAB</option>
          <option value="AMP">AMP</option>
          <option value="IU">IU</option>
        </select>
      </div>

      <!-- Quick Dose Buttons -->
            <div class="btn-group dose-buttons">
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





    <div id="divHoldLog" style="display: none;" class="ui-dialog-content ui-widget-content">
        <table id="tblHoldLog"></table>
        <div id="tblHoldLogPager"></div>
    </div>


    <div class="sticky-footer">
        <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
            <div class="tsStatus" style="background-color: #e02c0f !important;"></div>
            <label class="lblinfo">High Alert</label>

            <div class="tsStatus med-section" style="background-image: linear-gradient(#FEE188 0%, #ffafbd 0%, #FEE188 0%);"></div>
            <label class="lblinfo med-section">Planned & Omitted</label>

            <div class="tsStatus" style="background-color: #61f4235c !important;"></div>
            <label class="lblinfo">Omitted</label>

            <div class="tsStatus med-section" style="background-color: #f4d6f4c7 !important;"></div>
            <label class="lblinfo med-section">Planned</label>

            <div class="tsStatus medh-section" style="background-color: #65e5e1cf !important;"></div>
            <label class="lblinfo medh-section">Hold</label>

            <div class="tsStatus cancellation"></div>
            <label class="lblinfo">Cancelled</label>

            <div class="tsStatus TSDataColmn"></div>
            <label class="lblinfo  ">Administered</label>
            <div class="imgdiv">
                <img src="../Images/pills.png" alt="Indented" class="indentIconImage" />
                <label class="lblinfo2">Indented</label>
            </div>
            <div class="imgdivIss">
                <img src="../Images/check-round.png" alt="Issued" class="issuedIconImage" />
                <label class="lblinfo1">Issued</label>
            </div>

        </div>
    </div>
</div>
