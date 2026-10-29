<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style>
    .auto-wrap-cell {
        white-space: pre-wrap !important;
        word-break: break-word;
        overflow: visible !important;
    }

    .tabulator-cell {
        overflow: visible !important;
    }

    .Diagnosis-row:hover {
        background-color: #f0f8ff;
    }
</style>

<%-- UnCoded Diagnosis --%>
<script type="text/javascript">
    var UnCodedDiagListtable;
    var gact = "N";
    var RMOFlagDiagYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEDIAGNOSISYN")%>'
    var isOPD = sessionStorage.getItem("MODULE_FLAG") === "OPD";
    var isRMO = '<%: Session["RMOYN"] ?? "" %>' == "Y";
    var isAuth = '<%: Session["AUTHYN"] ?? "" %>' == "Y";
    var isCompleted = sessionStorage.getItem("PatCompleted") == "Y";
    var SessionCompDiag = "N";
    if (isOPD) {
        if (isCompleted || isAuth) {
            SessionCompDiag = "N";
        }
        else if (isRMO) {
            SessionCompDiag = (RMOFlagDiagYN == "Y") ? "Y" : "N";
        }
        else {
            SessionCompDiag = "Y";
        }
    }
    else {
        SessionCompDiag = "Y";
    }
    var EmptyLst = [{ Value: "" }];
    $(document).ready(function () {

        $("#btnFitToContentDiag").on("click", function () {
            fitToContent('Diagnosis_Freetext');
        });
        $("#btnSetMaxHeightDiag").on("click", function () {
            setMaxHeight('Diagnosis_Freetext');
        });

        // Disable freetext same way individual diagnosis controls are disabled
        if (SessionCompDiag != "Y") {
            $("#Diagnosis_Freetext").prop("disabled", true);
        }
        else {
            $("#Diagnosis_Freetext").prop("disabled", false);
        }

        $("#Diagnosis_Freetext").show();
        $("#Diagnosis_Freetext_Icon").show();

        var isIPDPage = (sessionStorage.getItem("MODULE_FLAG") === "IPD") || (window.location.href.toLowerCase().indexOf("singlepageipd") !== -1);
        if (isIPDPage) {
            $("#btnSetMaxHeightDiag").hide();
            $("#btnFitToContentDiag").off("click").on("click", function () {
                toggleTextareaHeight(this, 'Diagnosis_Freetext');
            });
        }


        /* Tabulator For UnCoded Diagnosis */
        UnCodedDiagListtable = new Tabulator("#UnCodedDiagonsisTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
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
                    formatter: function () {
                        // Hide delete icon if patient visit is completed
                        if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                            return "";
                        }
                        return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        // Prevent deletion if patient visit is completed
                        if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                            return false;
                        }
                        cell.getRow().delete();
                        adjustTableHeight("UnCodedDiagonsisTable");
                    }
                },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    formatter: "textarea",
                    formatterParams: { minHeight: "auto" },
                    cssClass: "wrap-text",
                    widthGrow: sessionStorage.getItem("MODULE_FLAG") === "IPD" ? 2 : 1
                
                },
                {
                    title: "Remark",
                    field: "remark",
                    formatter: "textarea",
                    editor: "textarea",
                    visible: sessionStorage.getItem("MODULE_FLAG") !== "IPD",
                    editable: function (cell) {//priyanka 02/04/2026
                        return (SessionCompDiag != "Y");
                    },
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
                    },
                    visible: false
                },
                {
                    title: "SetUpYn",
                    field: "SetUpYn",
                    editor: false,
                    visible: false
                }
            ]
        });

        UnCodedDiagListtable.on("dataChanged", function () {
            adjustTableHeight("UnCodedDiagonsisTable");
        });

        /* Click Event on the UnCoded Diagonsis Search List */
        $(document).on("click", ".UnCodedDiagonsis-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = UnCodedDiagListtable.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].code === code) {
                    ToastMsg("Diagnosis already added", "warning");
                    $("#UnCodedDiagonsisListMainDiv").hide();
                    return;
                }
            }
            UnCodedDiagListtable.addRow({
                act: '<i class="fa fa-trash text-danger"></i>',
                code: code,
                name: name,
                remark: "",
                SetUpYn: "N"
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("UnCodedDiagonsisTable");
            });
            $("#UnCodedDiagonsisSearch").val("");
            $("#UnCodedDiagonsisListMainDiv").hide();
        });

        /* Adjust of Height Of UnCoded Diagnosis Table */
        adjustTableHeight("UnCodedDiagonsisTable");

        LoadICDO();
        if (SessionCompDiag == "Y") {
            $("#ICDDiagn_Setup").prop("disabled", false);
            $("#btnFinalDiagnosis").prop("disabled", false);
            $("#DiagnosisAdd").prop("disabled", false);
            $("#Diagnosis_PrevHistory").prop("disabled", false).removeClass("disabled");
            $("#ICDDiagnosis_PrevHistory").prop("disabled", false).removeClass("disabled");
            $("#ICDODiagnosis_PrevHistory").prop("disabled", false).removeClass("disabled");
        }
        else {
            $("#ICDDiagn_Setup").prop("disabled", true);
            $("#btnFinalDiagnosis").prop("disabled", false);
            $("#DiagnosisAdd").prop("disabled", true);
            $("#Diagnosis_PrevHistory").prop("disabled", false).removeClass("disabled");
            $("#ICDDiagnosis_PrevHistory").prop("disabled", false).removeClass("disabled");
            $("#ICDODiagnosis_PrevHistory").prop("disabled", false).removeClass("disabled");
        }
    });


    /* Search For Frequent UnCoded Diagnosis */
    function GetFrequentUnCodedDiagnosis() {
        var clinicCode = sessionStorage.getItem('ClinicCode');
        startLoading("Loading", "loading-UnCodedDiagnosis-Search-List")
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetMainDiagnoList",
            async: true,
            data: { ClinicCode: clinicCode },
            success: function (result) {
                var UnCodedDiagnosisListData = [];
                if (result.Result) {
                    ToastMsg(result.Result, "error");
                }
                else {
                    UnCodedDiagnosisListData = result || [];
                }
                BindSearchListForUnCodedDiagonsis(UnCodedDiagnosisListData);
                stopLoading("loading-UnCodedDiagnosis-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-UnCodedDiagnosis-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Search For All UnCoded Diagonsis */
    function GetAllUnCodedDiagonsisList(FilterUnCodedDiagonsisText = "", FilterUnCodedDiagonsisCode = "", HistoryObj = "") { <%--// Modified Pournima 16th June 2026--%>
        var clinicCode = sessionStorage.getItem('ClinicCode');
        FilterUnCodedDiagonsisText = FilterUnCodedDiagonsisText == "" ? $("#UnCodedDiagonsisSearch").val() : FilterUnCodedDiagonsisText; <%--// Modified Pournima 16th June 2026--%>
        startLoading("Loading", "loading-UnCodedDiagnosis-Search-List")
        $.ajax({
            type: "POST",
            async: true,
            url: "../DoctorDesk/GetNonFregqentDiagnoList",
            data: { NonFreqDiagno: FilterUnCodedDiagonsisText, ClinicCode: clinicCode },
            success: function (result) {
                var UnCodedDiagonsisListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL" && result.trim() != "") {
                        result = JSON.parse(result);
                        UnCodedDiagonsisListData = result.Table1;
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                FilterUnCodedDiagonsisData(UnCodedDiagonsisListData, FilterUnCodedDiagonsisCode, HistoryObj);
                stopLoading("loading-UnCodedDiagnosis-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-UnCodedDiagnosis-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }
    function FilterUnCodedDiagonsisData(UnCodedDiagonsisListData, FilterUnCodedDiagonsisCode, HistoryObj) {
        var FilterUnCodedDiagList = UnCodedDiagonsisListData;
        if (FilterUnCodedDiagonsisCode != "") {
            FilterUnCodedDiagList = UnCodedDiagonsisListData.filter(item => item.CODE == FilterUnCodedDiagonsisCode);
        }
        BindSearchListForUnCodedDiagonsis(FilterUnCodedDiagList);
        if (FilterUnCodedDiagonsisCode && FilterUnCodedDiagonsisCode !== "") {
            var $first = $("#UnCodedDiagonsisList .UnCodedDiagonsis-row").first();
            if ($first.length) {
                $first.trigger("click");
                if (HistoryObj != undefined && HistoryObj != null && HistoryObj != "") {
                    UnCodedDiagListtable.updateRow(FilterUnCodedDiagonsisCode, {
                        code: HistoryObj.code, name: HistoryObj.name, remark: HistoryObj.remark, SetUpYn: HistoryObj.SetUpYn
                    });
                }
            }
        }
    }

    //Filter in HTML Search
    function FilterBindedSearchListForUnCodedDiagonsis() {
        var SearchTxt = $("#UnCodedDiagonsisSearch").val().toLowerCase();
        var FlagForCallAllUnCodedDiagList = true;
        if (SearchTxt.length < 3) {
            $("#UnCodedDiagonsisList.UnCodedDiagonsis - row").each(function () {
                var name = $(this).data("name").toLowerCase();
                var code = $(this).data("code").toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    FlagForCallAllUnCodedDiagList = false;
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        if (FlagForCallAllUnCodedDiagList == true)
            GetAllUnCodedDiagonsisList($("#UnCodedDiagonsisSearch").val(), "");
    }

    //List Binding Functionality For UnCoded Diagonsis
    function BindSearchListForUnCodedDiagonsis(UnCodedDiagonsisData) {
        var $list = $("#UnCodedDiagonsisList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No Diagnosis found</div>';
        if (UnCodedDiagonsisData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < UnCodedDiagonsisData.length; i++) {
                var itemCode = UnCodedDiagonsisData[i].DESCCD ? UnCodedDiagonsisData[i].DESCCD.trim() : UnCodedDiagonsisData[i].CODE.trim();
                var itemName = UnCodedDiagonsisData[i].DESC ? UnCodedDiagonsisData[i].DESC.trim() : UnCodedDiagonsisData[i].NAME.trim();
                //var ListOption = '<div class="list-group-item UnCodedDiagonsis-row" data-code="' + itemCode + '" data-name="' + itemName + '" style="cursor:pointer;">' + itemName + ' (' + itemCode + ') </div>';
                var ListOption = '<div class="list-group-item UnCodedDiagonsis-row" data-code="' + itemCode + '" data-name="' + itemName + '" style="cursor:pointer;">' + itemName + '</div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#UnCodedDiagonsisList").append(AppendContentList);
        $("#UnCodedDiagonsisListMainDiv").show();
    }

    //Validation Functionality For Save UnCoded Diagonsis
    function ValidationForUnCodedDiagonsis(Type) {
        return true;
    }

    //Save Functionality For UnCoded Diagonsis
    function SaveForUnCodedDiagonsis(DataSaveObj, Type) {
        var UnCodedDiagArr = [];
        var tableData = UnCodedDiagListtable.getData();
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
            var a = {
                DESCCD: rows[i].code,
                REMARKS: "" + rows[i].remark,
                SETUPYN: "" + rows[i].SetUpYn, //Pending
            };
            UnCodedDiagArr.push(a);
        }
        DataSaveObj.StrDiagnosis = JSON.stringify(UnCodedDiagArr);
        DataSaveObj.ProviDiagnosis = $("#Diagnosis_Freetext").val();
    }

    //IPD Uncoded Diagnosis
    function SaveForIPDUnCodedDiagonsis(DataSaveObj, Type) {
        var UnCodedDiagArr = [];
        var tableData = UnCodedDiagListtable.getData();
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
            var a = {
                ICDCODE: rows[i].code,
                ICDNAME: "" + rows[i].name,
                ICDTYPE: "" //Pending
            };
            UnCodedDiagArr.push(a);
        }
        return UnCodedDiagArr;
    }

    //IPD Icd Diagnosis
    function SaveForIPDICDDiagonsis(DataSaveObj, Type) {
        var ICDDiagArr = [];
        var tableData = ICDDiagListtable.getData();
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
            var code = rows[i].code;
            var name = rows[i].name;
            var ICDDiagRemark = rows[i].remark;
            var a = {
                ICDCODE: code,
                ICDNAME: name,
                ICDTYPE: ""
            };
            ICDDiagArr.push(a);
        }
        return ICDDiagArr;
    }
</script>

<%-- Add New Item For UnCoded Diagonsis --%>
<script type="text/javascript">
    //Body Content For New Item UnCoded Diagonsis
    function ContentForAddNewItemUnCodedDiag() {
        return `
        <div class="mb-3">
          <input id="txtUnCodedDiag" type="text" class="form-control UnCodedDiag" maxlength="250" autocomplete="off" placeholder="Enter Diagnosis" tabindex="2" />
        </div>
        `;
    }
    //Footer Content For New Item UnCoded Diagonsis
    function FooterContentForAddNewItemUnCodedDiag() {
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('UnCodedDiag')" tabindex="3">Close</button>
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForUnCodedDiag('UnCodedDiag')" tabindex="4">Save</button>
        `;
    }
    //Validation For New Item UnCoded Diagonsis
    function ValidationForNewItemUnCodedDiag() {
        if ($("#txtUnCodedDiag").val().trim().length === 0) {
            ToastMsg("Enter Diagnosis", "warning");
            $("#txtUnCodedDiag").focus();
            return false;
        }
        return true;
    }
    //Save For New Item UnCoded Diagonsis
    function SaveNewItemForUnCodedDiag() {
        if (ValidationForNewItemUnCodedDiag() == true) {
            //startLoading("Loading", "loading-UnCodedDiag-New-Item");
            startLoading("Loading", "loading-Complaints-New-Item");
            $.ajax({
                type: "post",
                datatype: "json",
                url: "../DoctorDesk/AddDiagnosis",
                data: { strDiagnosis: $("#txtUnCodedDiag").val().trim() },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESS") !== -1) {
                        ToastMsg(response, "success");
                        var UnCodedDiagNewcode = (response.match(/code\s+(\d+)/i) || ["", ""])[1];
                        var UnCodedDiagNewText = $("#txtUnCodedDiag").val();
                        GetAllUnCodedDiagonsisList(UnCodedDiagNewText, UnCodedDiagNewcode);
                        closeAddNewItemPopup('UnCodedDiagnosis'); //priyanka 01/04/2026
                    }
                    else {
                        ToastMsg(response, "warning");
                    }
                    //stopLoading("loading-UnCodedDiag-New-Item");
                    stopLoading("loading-Complaints-New-Item");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //stopLoading("loading-UnCodedDiag-New-Item");
                    stopLoading("loading-Complaints-New-Item");
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }
</script>

<%-- History For UnCoded Diagonsis --%>
<script type="text/javascript">
    function HistPopUnCodedDiagonsisTemp(AllHistoryData, ContentID) {
        var ConsultLst = AllHistoryData[0] || [];
        var UnCodedDiagonsisLst = AllHistoryData[3] || [];

        // Get current codes from the Tabulator table to check for duplicates
        var existingCodes = UnCodedDiagListtable.getData().map(row => row.code.toString().trim());
        var existingRows = UnCodedDiagListtable.getData();//priyanka 16/04/2026
        var container = '<div class="history-list-wrapper">';

        for (var i = 0; i < ConsultLst.length; i++) {
            var consult = ConsultLst[i];
            var ConsultNo = consult.TRANNO;
            if (!ConsultNo) continue;
            var filtered = UnCodedDiagonsisLst.filter(c => c.TRANNO === ConsultNo);
            if (filtered.length === 0) continue;
            var allCopied = filtered.every(c =>
                existingRows.some(r => r.code === c.DESCCD)
            );
            var docName = consult.DOCTNAME || "General Consultation";
            var specName = consult.SPECNAME ? " (" + consult.SPECNAME + ")" : "";
            var dateInfo = consult.TRANDATE + " " + ConvertTo12Hour("O", consult.TRANTIME);

            // --- Logic: Hide "Copy All" button if PatCompleted is "Y" ---
            var copyAllBtnHtml = "";
            //priyanka 16/04/2026
            if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                copyAllBtnHtml = ""; 
            }
            else {
                if (allCopied) {
                    copyAllBtnHtml = `
                   <button class="btn btn-sm btn-outline-success" style="background: #dbfdf8;" disabled>
                       <i class="fa fa-check text-success"></i>
                   </button>`;
                }

                else {
                    copyAllBtnHtml = `
                    <button class="btn btn-sm btn-outline-primary copy-all-btn" data-consult="${ConsultNo}">
                        <i class="fa fa-copy"></i> Copy All
                    </button>`;
                }
            }
            //End

            var sectionHtml = `
        <div class="History-section mb-3 shadow-sm border">
            <div class="History-header d-flex justify-content-between align-items-center bg-light p-2 border-bottom">
                <div style="line-height: 1.2;">
                    <div class="History-header-title font-weight-bold">
                        Dr. ${docName}${specName}
            </div>
            <small>${dateInfo}</small>
        </div>
            ${copyAllBtnHtml}
            </div>
            <div class="History-body">
                <ul class="list-unstyled mb-0">`;

            var UnCodedDiagonsisSentence = "{UNCODEDDIAGNOSISNAME} {-} {REMARK}";
            for (var k = 0; k < filtered.length; k++) {
                var itemText = filtered[k].NAME;
                var itemCode = (filtered[k].DESCCD || "").toString().trim();
                var remarks = (filtered[k].REMARKS || "").trim();
                var SetupYN = filtered[k].SETUPYN || "";

                // Logic to check if already added
                var isAlreadyAdded = existingCodes.includes(itemCode);
                var actionBtn = "";

                if (isAlreadyAdded) {
                    // Show checked icon if duplicate
                    actionBtn = `<span class="text-success mr-2" title="Already Added"><i class="fa fa-check-circle"></i></span>`;
                }
                    // --- Logic: Hide individual copy icon if PatCompleted is "Y" ---
                else if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                    actionBtn = ""; // Hide icon
                }
                else {
                    // Show copy icon if new and visit not completed
                    actionBtn = `
                <button class="btn btn-link btn-sm p-0 copy-row-btn" title="Copy to List">
                    <i class="fa fa-clone text-primary"></i>
                </button>`;
                }

                var RplUnCodedDiagonsisSentence = UnCodedDiagonsisSentence
                    .replace("{UNCODEDDIAGNOSISNAME}", itemText)
                    .replace("{-}", (remarks == "" ? "" : "-"))
                    .replace("{REMARK}", remarks);

                sectionHtml += `
            <li class="History-row d-flex justify-content-between align-items-center p-2 border-bottom">
                <span class="History-row-Alltext">${RplUnCodedDiagonsisSentence}</span>
                <span class="History-row-text History-row-Hide">${itemText}</span>
                <span class="History-row-Code History-row-Hide">${itemCode}</span>
                <span class="History-row-Remark History-row-Hide">${remarks}</span>
                <span class="History-row-SetupYN History-row-Hide">${SetupYN}</span>
                ${actionBtn}
                </li>`;
            }
            sectionHtml += `</ul></div></div>`;
            container += sectionHtml;
        }
        return container + '</div>';
    }

    function CopyFuncUnCodedDiagonsis() {

        //COPY ROW
        $(".copy-row-btn").off("click").on("click", function () {

            var $btn = $(this);
            var $li = $btn.closest("li");
            var $ul = $btn.closest("ul");

            var text = $(this).siblings(".History-row-text").text();
            var Code = $(this).siblings(".History-row-Code").text();
            var UnCodedDiagonsisRowObj = {
                code: Code,
                name: text,
                remark: $(this).siblings(".History-row-Remark").text(),
                SetUpYn: $(this).siblings(".History-row-SetupYN").text()
            };   
            $("#UnCodedDiagonsisSearch").val(text);//priyanka 24/06/2026
            GetAllUnCodedDiagonsisList(text, Code, UnCodedDiagonsisRowObj);


            $(".History-row-Code").each(function () {

                if ($(this).text().trim() === Code) {

                    var $sameRow = $(this).closest("li");
                    var $sameBtn = $sameRow.find(".copy-row-btn");

                    if ($sameBtn.length > 0) {
                        $sameBtn.html('<i class="fa fa-check text-success"></i>')
                            .removeClass("copy-row-btn")
                            .prop("disabled", true);
                    }

                    // If no more copy-row-btn inside that UL → mark copy-all
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
                var UnCodedDiagonsisRowObj = {
                    code: Code,
                    name: text,
                    remark: $(this).siblings(".History-row-Remark").text(),
                    SetUpYn: $(this).siblings(".History-row-SetupYN").text()
                };       

                $("#UnCodedDiagonsisSearch").val(text);//priyanka 24/06/2026
                GetAllUnCodedDiagonsisList(text, Code, UnCodedDiagonsisRowObj);

                $(".History-row-Code").each(function () {

                    if ($(this).text().trim() === Code) {

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
</script>

<%--Setup For UnCoded Diagonsis--%>
<script type="text/javascript">
    function SetupPopupUnCodedDiagContent() {
        return `
        <div class="FilterClassDivPopup">
        <button class="btn btn-primary" onclick="ValidationForSetupUnCodedDiagBindTran('Setup_UnCodedDiag')"><i class="fa fa-save"></i> Apply</button>
        <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('Diagnosis', 'UnCodedDiagSetup')">
        </div>
        <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
        `;
    }

    function CreateTabulatorUnCodedDiagSetup(TabulatorSetupId) {
        var SetupExamListTable = new Tabulator(("#" + TabulatorSetupId), {
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
                    // This allows the column to contain HTML
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
                            OpenPopupForNewItem('UnCoded Diagnosis', 'UnCodedDiagSetup');
                            BindUnCodedDiagEditSetup(rowData)
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
        BindUnCodedDiagSetupList(TabulatorSetupId);
    }

    function BindUnCodedDiagSetupList(TabulatorSetupId) {
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetPersDiagnoList","DoctorDesk")%>",
            data: {},
            asycn: false,
            success: function (response) {
                if (response != "Unsucessfull") {
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

    function ValidationForSetupUnCodedDiagBindTran(TabulatorSetupId) {
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
            SetUnCodedDiagSetupToTran(SelCode);
        }
    }

    function SetUnCodedDiagSetupToTran(strCode) {
        $.ajax({
            url: '../DoctorDesk/GetDiagnosisListBySetupCode',
            data: { strSetUpCode: strCode },
            type: 'post',
            datatype: 'get',
            success: function (response) {
                if (response != "") {
                    for (i = 0; i < response.length; i++) {
                        var UnCodedDiagonsisRowObj = {
                            code:response[i].CODE,
                            name:response[i].NAME,
                            remark: "",
                            SetUpYn:"Y"
                        };
                        GetAllUnCodedDiagonsisList(response[i].NAME, response[i].CODE, UnCodedDiagonsisRowObj);
                    }
                    closeMaxMinPopup('Hist_M_UnCodedDiag');
                }
            }
        })
    }

    function ContentForAddNewItemUnCodedDiagSetup() {
        return `
        <div class="mb-3">
                 <input id="txtSetupNameCode" type="text" class="form-control " style="display:none" />
               </div>
        <div class="mb-3">
          <input id="txtSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
        </div>
        <div class="mb-3">
              <div id="UncodedDiagTableSetupNew"></div>
        </div>
    `;
    }

    function FooterContentForAddNewItemUnCodedDiagSetup() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForUnCodedDiagSetup('')" tabindex="4">Save</button>
        `;
    }

    function CreateUnicodedDiagSetupNewTabultor(){
        var UnicodedDiagSetupNewTabultor = new Tabulator(("#UncodedDiagTableSetupNew"), {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "350",
            index: "code",
            columns: [
               {
                   title: "CHECKYN",
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
        UnicodedDiagSetupNewTabultor.on("tableBuilt", function () {
            BindUnicodedDiagSetupNewList();
        });
    }

    function BindUnicodedDiagSetupNewList(){
        var DataToSend = {
            ClinicCode: sessionStorage.getItem('ClinicCode')
        };
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetMainDiagnoList","DoctorDesk")%>",
            data: DataToSend,
            async: true,
            success: function (response) {
                if (response != "") {
                    var formattedData = response.map(function (row) {
                        return {
                            CHECKYN: false,           
                            code: row.DESCCD,         
                            name: row.DESC          
                        };
                    });
                    var table = Tabulator.findTable("#UncodedDiagTableSetupNew")[0];
                    if (table) {
                        table.setData(formattedData);
                    }
                }
            }
        });
    }

    function BindUnCodedDiagEditSetup(RowData){
        $.ajax({
            url: '../DoctorDesk/GetDiagnosisListBySetupCode',
            data: { strSetUpCode: RowData.code },
            type: 'post',
            datatype: 'get',
            success: function (response) {
                if (response != "") {
                    var codeMap = {};
                    $.each(response, function (i, val) {
                        if (val.CODE) {
                            codeMap[val.CODE] = true;
                        }
                    });
                    var table = Tabulator.findTable("#UncodedDiagTableSetupNew")[0];
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

    function ValidationForNewItemUnCodedDiagSetup() {
        var table = Tabulator.findTable("#UncodedDiagTableSetupNew")[0];
        if ($("#txtSetupName").val().trim().length === 0) {
            ToastMsg("Enter Setup Name", "warning");
            $("#txtSetupName").focus();
            return false;
        }
        if( table.getData().filter(function (row) {return row.CHECKYN === true;}).length == 0 ){
            ToastMsg("Select Atleast One UnCoded Diagnosis.", "warning");
            return false;
        }
        return true;
    }

    function SaveNewItemForUnCodedDiagSetup() {
        if (ValidationForNewItemUnCodedDiagSetup() == true) {
            var table = Tabulator.findTable("#UncodedDiagTableSetupNew")[0];

            // collect checked CODEs
            var strDiagArry = table.getData()
                .filter(function (row) {
                    return row.CHECKYN === true;
                })
                .map(function (row) {
                    return row.code;
                })
                .join(",");
            var strDiagArry2 = table.getData()
                  .filter(function (row) {
                      return row.CHECKYN === true;
                  })
                  .map(function (row) {
                      return row.name;
                  })
                  .join(",");

            $.ajax({
                type: "post",
                datatype: "json",
                url: '../DoctorDesk/AddDiagnosisSetUp',
                data: { strDiagnSetUpName: $("#txtSetupName").val(), strDiagnLst: strDiagArry, strDiagNameLst: strDiagArry2, strDiagSetUpCode: $("#txtSetupNameCode").val() },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        BindUnCodedDiagSetupList('Setup_UnCodedDiag');
                        closeAddNewItemPopup('UnCodedDiagSetup');
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

<%-- ICD Diagnosis --%>
<script type="text/javascript">
    var ICDDiagListtable;
    $(document).ready(function () {
        /* Tabulator For ICD Diagnosis */
        ICDDiagListtable = new Tabulator("#ICDDiagonsisTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
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
                    formatter: function () {
                        // Hide delete icon if patient visit is completed
                        if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                            return "";
                        }
                        return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        // Prevent deletion if patient visit is completed
                        if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                            return false;
                        }
                        cell.getRow().delete();
                    }
                },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    formatter: "textarea",
                    formatterParams: { minHeight: "auto" },
                    cssClass: "wrap-text"
                }
            ]
        });

        ICDDiagListtable.on("cellEdited", function (cell) {
            cell.getRow().normalizeHeight();
            adjustTableHeight("ICDDiagonsisTable");
        });

        ICDDiagListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("ICDDiagonsisTable");
        });

        ICDDiagListtable.on("rowDeleted", function (row) {
            adjustTableHeight("ICDDiagonsisTable");
        });

        ICDDiagListtable.on("dataLoaded", function () {
            adjustTableHeight("ICDDiagonsisTable");
        });

        ICDDiagListtable.on("tableBuilt", function () {
            adjustTableHeight("ICDDiagonsisTable");
        });

        ICDDiagListtable.on("dataChanged", function () {
            adjustTableHeight("ICDDiagonsisTable");
        });

        /* Click Event on the ICD Diagonsis Search List */
        $(document).on("click", ".ICDDiagonsis-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = ICDDiagListtable.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].code === code) {
                    ToastMsg("ICD Diagnosis already added", "warning");
                    $("#ICDDiagonsisListMainDiv").hide();
                    return;
                }
            }
            ICDDiagListtable.addRow({
                act: '<i class="fa fa-trash text-danger"></i>',
                code: code,
                name: name
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("ICDDiagonsisTable");
            });
            $("#ICDDiagonsisSearch").val("");
            $("#ICDDiagonsisListMainDiv").hide();
        });

        /* Adjust of Height Of ICD Diagnosis Table */
        adjustTableHeight("ICDDiagonsisTable");

        if (sessionStorage.getItem("MODULE_FLAG") == "IPD") {
            SetDataForIPDDiagnosis("Y");//priyanka 02/03/2026
        }
        else
        {
            LoadAdviceSection(function () {
                SetDataForDiagnosis("Y");
            });
        }
    });


    /* Search For Frequent ICDDiagnosis */
    function GetFrequentICDDiagnosis() {
        var clinicCode = sessionStorage.getItem('ClinicCode');
        startLoading("Loading", "loading-ICDDiagnosis-Search-List")
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetICDDiagnoList",
            async: true,
            data: { ClinicCode: clinicCode },
            success: function (result) {
                var ICDDiagnosisListData = [];
                if (result.Result) {
                    ToastMsg(result.Result, "error");
                }
                else {
                    ICDDiagnosisListData = result || [];
                }
                BindSearchListForICDDiagonsis(ICDDiagnosisListData);
                stopLoading("loading-ICDDiagnosis-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-ICDDiagnosis-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Search For All ICD Diagonsis */
    function GetAllICDDiagonsisList(FilterICDDiagonsisText = "", FilterICDDiagonsisCode = "", HistoryObj = "") { <%--// Modified Pournima 16th June 2026--%>
        var clinicCode = sessionStorage.getItem('ClinicCode');
        FilterICDDiagonsisText = $("#ICDDiagonsisSearch").val(); <%--// Modified Pournima 16th June 2026--%>
        startLoading("Loading", "loading-ICDDiagnosis-Search-List")
        $.ajax({
            type: "POST",
            async: true,
            url: "../DoctorDesk/GetNonFregqentICDList",
            data: { NonFreqICD: FilterICDDiagonsisText, ClinicCode: clinicCode },
            success: function (result) {
                var ICDDiagonsisListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL" && result.trim() != "") {
                        result = JSON.parse(result);
                        ICDDiagonsisListData = result.Table;
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                FilterICDDiagonsisData(ICDDiagonsisListData, FilterICDDiagonsisCode, HistoryObj);
                stopLoading("loading-ICDDiagnosis-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-ICDDiagnosis-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter ICD Diagonsis Data list */
    function FilterICDDiagonsisData(ICDDiagonsisListData, FilterICDDiagonsisCode, HistoryObj) {
        var FilterICDDiagList = ICDDiagonsisListData;
        if (FilterICDDiagonsisCode != "") {
            FilterICDDiagList = ICDDiagonsisListData.filter(item => item.CODE.trim() == FilterICDDiagonsisCode.trim());
        }
        BindSearchListForICDDiagonsis(FilterICDDiagList);
        if (FilterICDDiagonsisCode && FilterICDDiagonsisCode !== "") {
            var $first = $("#ICDDiagonsisList .ICDDiagonsis-row").first();
            if ($first.length) {
                $first.trigger("click");
                if (HistoryObj != undefined && HistoryObj != null && HistoryObj != "") {
                    ICDDiagListtable.updateRow(FilterICDDiagonsisCode.trim(), {
                        code: HistoryObj.code.trim(), name: HistoryObj.name, remark: HistoryObj.remark, SetUpYn: HistoryObj.SetUpYn
                    });
                }
            }
        }
    }

    //Filter in HTML Search
    function FilterBindedSearchListForICDDiagonsis() {
        var SearchTxt = $("#ICDDiagonsisSearch").val().toLowerCase();
        var FlagForCallAllICDDiagList = true;
        if (SearchTxt.length < 3) {
            $("#ICDDiagonsisList.ICDDiagonsis - row").each(function () {
                var name = $(this).data("name").toLowerCase();
                var code = $(this).data("code").toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    FlagForCallAllICDDiagList = false;
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        if (FlagForCallAllICDDiagList == true)
            GetAllICDDiagonsisList($("#ICDDiagonsisSearch").val(), "");
    }

    //List Binding Functionality For ICD Diagonsis
    function BindSearchListForICDDiagonsis(ICDDiagonsisData) {
        var $list = $("#ICDDiagonsisList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No ICD Diagnosis found</div>';
        if (ICDDiagonsisData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < ICDDiagonsisData.length; i++) {
                var itemCode = ICDDiagonsisData[i].DESCCD ? ICDDiagonsisData[i].DESCCD.trim() : ICDDiagonsisData[i].CODE.trim();
                var itemName = ICDDiagonsisData[i].DESC ? ICDDiagonsisData[i].DESC.trim() : ICDDiagonsisData[i].NAME.trim();
                var ListOption = '<div class="list-group-item ICDDiagonsis-row" data-code="' + itemCode + '" data-name="' + itemName + '" style="cursor:pointer;">' + itemName + '</div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#ICDDiagonsisList").append(AppendContentList);
        $("#ICDDiagonsisListMainDiv").show();
    }

    //Validation Functionality For Save ICD Diagonsis
    function ValidationForICDDiagonsis(Type) {
        return true;
    }

    //Save Functionality For ICD Diagonsis
    function SaveForICDDiagonsis(DataSaveObj, Type) {
        var ICDDiagArr = [];
        var tableData = ICDDiagListtable.getData();
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
            var code = rows[i].code;
            var ICDDiagRemark = rows[i].remark;
            var a = {
                DESCCD: code,
            };
            ICDDiagArr.push(a);
        }
        DataSaveObj.StrICDDiagnosis = JSON.stringify(ICDDiagArr);
    }
</script>

<%-- History For ICD Diagonsis --%>
<script type="text/javascript">

    function HistPopUnICDDiagonsisTemp(AllHistoryData, ContentID) {
        var ConsultLst = AllHistoryData[0] || [];
        var ICDDiagonsisLst = AllHistoryData[9] || [];

        // Get current ICD codes from your active Tabulator table
        var existingICDCodes = ICDDiagListtable.getData().map(row => row.code.toString().trim());
        var existingRows = ICDDiagListtable.getData();//priyanka 16/04/2026
        var container = '<div class="history-list-wrapper">';

        for (var i = 0; i < ConsultLst.length; i++) {
            var consult = ConsultLst[i];
            var ConsultNo = consult.TRANNO;
            if (!ConsultNo) continue;
            var filtered = ICDDiagonsisLst.filter(c => c.TRANNO === ConsultNo);
            if (filtered.length === 0) continue;

            //priyanka 16/04/2026
            var allCopied = filtered.every(c =>
                existingRows.some(r => r.code === c.ICDCODE)
            );
            //End
            var docName = consult.DOCTNAME || "General Consultation";
            var specName = consult.SPECNAME ? " (" + consult.SPECNAME + ")" : "";
            var dateInfo = consult.TRANDATE + " " + ConvertTo12Hour("O", consult.TRANTIME);

            // --- Logic: Hide "Copy All" button if SessionStatus is "Y" ---
            var copyAllBtnHtml = "";

            //Priyanka 16/06/2026
            if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                copyAllBtnHtml = "";
            }
            else {
                if (allCopied) {
                    copyAllBtnHtml = `
                    <button class="btn btn-sm btn-outline-success" style="background: #dbfdf8;" disabled>
                        <i class="fa fa-check text-success"></i>
                    </button>`;
                }
                else {
                    copyAllBtnHtml = `
                     <button class="btn btn-sm btn-outline-primary copy-all-btn" data-consult="${ConsultNo}">
                         <i class="fa fa-copy"></i> Copy All
                     </button>`;
                }
            }
            //End

            var sectionHtml = `
        <div class="History-section mb-3 shadow-sm border">
            <div class="History-header d-flex justify-content-between align-items-center bg-light p-2 border-bottom">
                <div style="line-height: 1.2;">
                    <div class="History-header-title font-weight-bold">
                        Dr. ${docName}${specName}
            </div>
            <small>${dateInfo}</small>
        </div>
            ${copyAllBtnHtml}
            </div>
            <div class="History-body">
                <ul class="list-unstyled mb-0">`;

            var ICDDiagonsisSentence = "{ICDDIAGNOSISNAME}";
            for (var k = 0; k < filtered.length; k++) {
                var itemTextCode = filtered[k].NAME.split('-');
                var itemText = itemTextCode.slice(1).join('').trim();
                var itemCode = (filtered[k].ICDCODE || "").toString().trim();

                // Check if this code already exists in the main table
                var isAlreadyAdded = existingICDCodes.includes(itemCode);
                var actionBtn = "";

                if (isAlreadyAdded) {
                    // Show checked icon for duplicates
                    actionBtn = `<span class="text-success mr-2" title="Already Added"><i class="fa fa-check-circle"></i></span>`;
                }
                    // --- Logic: Hide individual copy icon if SessionStatus is "Y" ---
                else if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag != "Y") {
                    actionBtn = "";
                }
                else {
                    // Show standard copy icon if session is active
                    actionBtn = `
                <button class="btn btn-link btn-sm p-0 copy-row-btn" title="Copy to List">
                    <i class="fa fa-clone text-primary"></i>
                </button>`;
                }

                var RplICDDiagonsisSentence = ICDDiagonsisSentence.replace("{ICDDIAGNOSISNAME}", itemText);

                sectionHtml += `
            <li class="History-row d-flex justify-content-between align-items-center p-2 border-bottom">
                <span class="History-row-Alltext">${RplICDDiagonsisSentence}</span>
                <span class="History-row-text History-row-Hide">${itemText}</span>
                <span class="History-row-Code History-row-Hide">${itemCode}</span>
                ${actionBtn}
                </li>`;
            }
            sectionHtml += `</ul></div></div>`;
            container += sectionHtml;
        }
        return container + '</div>';
    }
    function CopyFuncICDDiagonsis() {
        //COPY ROW
        $(".copy-row-btn").off("click").on("click", function () {

            var $btn = $(this);
            var $li = $btn.closest("li");
            var $ul = $btn.closest("ul");

            var text = $(this).siblings(".History-row-text").text();
            var Code = $(this).siblings(".History-row-Code").text();
            var UnCodedDiagonsisRowObj = {
                code: Code,
                name: text
            };   
            $("#ICDDiagonsisSearch").val(text);//priyanka 24/06/2026
            GetAllICDDiagonsisList(text, Code, UnCodedDiagonsisRowObj);


            $(".History-row-Code").each(function () {

                if ($(this).text().trim() === Code) {

                    var $sameRow = $(this).closest("li");
                    var $sameBtn = $sameRow.find(".copy-row-btn");

                    if ($sameBtn.length > 0) {
                        $sameBtn.html('<i class="fa fa-check text-success"></i>')
                            .removeClass("copy-row-btn")
                            .prop("disabled", true);
                    }

                    // If no more copy-row-btn inside that UL → mark copy-all
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
                var UnCodedDiagonsisRowObj = {
                    code: Code,
                    name: text,
                };       
                $("#ICDDiagonsisSearch").val(text);//priyanka 24/06/2026
                GetAllICDDiagonsisList(text, Code, UnCodedDiagonsisRowObj);

                // Mark same test everywhere
                $(".History-row-Code").each(function () {

                    if ($(this).text().trim() === Code) {

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

            // Mark current copy-all button
            $(this).html('<i class="fa fa-check text-success" style="background:white;"></i>')
                .removeClass("copy-all-btn")
                .prop("disabled", true);

        });



    }
</script>


<%--Setup For ICD Diagonsis--%>
<script type="text/javascript">
    function SetupPopupICDDiagContent() {
        return `
        <div class="FilterClassDivPopup">
        <button class="btn btn-primary" onclick="ValidationForSetupICDDiagBindTran('Setup_ICDDiag')"><i class="fa fa-save"></i> Apply</button>
        <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('ICD Diagnosis', 'ICDDiagSetup')">
        </div>
        <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
        `;
    }

    function CreateTabulatorICDDiagSetup(TabulatorSetupId) {
        var SetupExamListTable = new Tabulator(("#" + TabulatorSetupId), {
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
                    // This allows the column to contain HTML
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
                            OpenPopupForNewItem('ICD Diagnosis', 'ICDDiagSetup');
                            BindICDDiagEditSetup(rowData)
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
        BindICDDiagSetupList(TabulatorSetupId);
    }

    function BindICDDiagSetupList(TabulatorSetupId) {
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetPersICDDiagnoList","DoctorDesk")%>", // GetPersDiagnoList
            data: {},
            asycn: false,
            success: function (response) {
                if (response && response.toUpperCase() !== "UNSUCCESSFULL") //priyanka 14/03/2026
                { 
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

    function ValidationForSetupICDDiagBindTran(TabulatorSetupId) {
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
            SetICDDiagSetupToTran(SelCode);
        }
    }

    function SetICDDiagSetupToTran(strCode) {
        $.ajax({
            url: '../DoctorDesk/GetICDDiagnoListBySetupCode',
            data: { strSetUpCode: strCode },
            type: 'post',
            datatype: 'get',
            success: function (response) {
                if (response != "") {
                    for (i = 0; i < response.length; i++) {
                        var ICDDiagonsisRowObj = {
                            code:response[i].CODE,
                            name:response[i].NAME,
                            remark: "",
                            SetUpYn:"Y"
                        };
                        GetAllICDDiagonsisList(response[i].NAME, response[i].CODE, ICDDiagonsisRowObj);
                    }
                    closeMaxMinPopup('Hist_M_ICDDiag');
                }
            }
        })
    }

    function ContentForAddNewItemICDDiagSetup() {
        return `
        <div class="mb-3">
                 <input id="txtICDSetupNameCode" type="text" class="form-control " style="display:none" />
               </div>
        <div class="mb-3">
          <input id="txtICDSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
        </div>
        <div class="mb-3">
              <div id="ICDDiagTableSetupNew"></div>
        </div>
    `;
    }

    function FooterContentForAddNewItemICDDiagSetup() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForICDDiagSetup('')" tabindex="4">Save</button>
        `;
    }

    function CreateICDDiagSetupNewTabultor(){
        var ICDDiagSetupNewTabultor = new Tabulator(("#ICDDiagTableSetupNew"), {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "350",
            index: "code",
            columns: [
               {
                   title: "Select",
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
        ICDDiagSetupNewTabultor.on("tableBuilt", function () {
            BindICDDiagSetupNewList();
        });
    }

    function BindICDDiagSetupNewList(){
        var DataToSend = {
            NonFreqICD: "", //sessionStorage.getItem('ClinicCode')
        };
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetNonFregqentICDDiagnosisList","DoctorDesk")%>",    // GetMainDiagnoList
            data: DataToSend,
            async: true,
            success: function (response) {
                if (response != "") {
                    var formattedData = response.map(function (row) {
                        return {
                            CHECKYN: false,
                            code: row.CODE,
                            name: row.NAME
                        };
                    });
                    var table = Tabulator.findTable("#ICDDiagTableSetupNew")[0];
                    if (table) {
                        table.setData(formattedData);
                    }
                }
            }
        });
    }

    function BindICDDiagEditSetup(RowData) {
        $.ajax({
            url: '../DoctorDesk/GetICDDiagnoListBySetupCode',   //GetDiagnosisListBySetupCode',
            data: { strSetUpCode: RowData.code },
            type: 'post',
            datatype: 'get',
            success: function (response) {
                if (response != "") {
                    var codeMap = {};
                    $.each(response, function (i, val) {
                        if (val.CODE) {
                            codeMap[val.CODE] = true;
                        }
                    });
                    var table = Tabulator.findTable("#ICDDiagTableSetupNew")[0];

                    table.getRows().forEach(function (row) {
                        var rowCode = row.getData().code.toUpperCase(); // normalize
                        row.update({
                            CHECKYN: codeMap[rowCode] === true // ensures boolean
                        });
                    });
                }
                $("#txtICDSetupNameCode").val(RowData.code);
                $("#txtICDSetupName").val(RowData.name);
            }
        })
    }

    function ValidationForNewItemICDDiagSetup() {
        var table = Tabulator.findTable("#ICDDiagTableSetupNew")[0];
        if ($("#txtICDSetupName").val().trim().length === 0) {
            ToastMsg("Enter Setup Name", "warning");
            $("#txtICDSetupName").focus();
            return false;
        }
        if (table.getData().filter(function (row) { return row.CHECKYN === true; }).length == 0) {
            ToastMsg("Select Atleast One ICD Diagnosis.", "warning");
            return false;
        }
        return true;
    }

    function SaveNewItemForICDDiagSetup() {
        if (ValidationForNewItemICDDiagSetup() == true) {
            var table = Tabulator.findTable("#ICDDiagTableSetupNew")[0];

            // collect checked CODEs
            var strDiagArry = table.getData()
                .filter(function (row) {
                    return row.CHECKYN === true;
                })
                .map(function (row) {
                    return row.code;
                })
                .join(",");
            var strDiagArry2 = table.getData()
                .filter(function (row) {
                    return row.CHECKYN === true;
                })
                .map(function (row) {
                    return row.name;
                })
                .join(",");

            $.ajax({
                type: "post",
                datatype: "json",
                url: '../DoctorDesk/AddICDDiagnosisSetUp', //AddDiagnosisSetUp',
                data: {
                    strICDDiagnSetUpName: $("#txtICDSetupName").val(), strICDDiagnLst: strDiagArry, strICDDiagNameLst: strDiagArry2, strICDDiagSetUpCode: $("#txtICDSetupNameCode").val()
                },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        BindICDDiagSetupList('Setup_ICDDiag');
                        closeAddNewItemPopup('ICDDiagSetup');
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

<%-- Common Functions --%>
<script type="text/javascript">
    function SetDataForDiagnosis(FormLoadYN) {
        var tranNo = sessionStorage.getItem('PatTRANNO') != null ? sessionStorage.getItem('PatTRANNO') : "";
        var MRNo = GetSessionMRNO();
        $.ajax({
            type: 'post',
            datatype: 'json',
            data: { strTranNo: tranNo, strMRNO: MRNo },
            url: '../DoctorDesk/SetDataForDiagnosis',
            async: true,
            success: function (data) {
                if (data != "") {
                    if (FormLoadYN == "Y") {
                        if (data[0] != null) {
                            if (!(!data || !data[0] || data[0].length === 0)) {
                                var existingRows = UnCodedDiagListtable.getData();

                                data[0].forEach(function (item) {
                                    var exists = existingRows.some(function (r) {
                                        return r.code === item.DESCCD;
                                    });
                                    if (exists) return;
                                    UnCodedDiagListtable.addRow({
                                        act: "",
                                        code: item.DESCCD,
                                        name: item.NAME,
                                        remark: (item.REMARKS || "").trim(),
                                        SetUpYn: item.SETUPYN
                                    });
                                });
                            }
                        }
                        if (data[1] != null) {
                            if (!(!data || !data[1] || data[1].length === 0)) {
                                var existingRows = ICDDiagListtable.getData();
                                data[1].forEach(function (item) {
                                    var exists = existingRows.some(function (r) {
                                        return r.code === item.ICDCODE;
                                    });
                                    if (exists) return;
                                    ICDDiagListtable.addRow({
                                        act: "",
                                        code: item.ICDCODE,
                                        name: item.NAME,
                                    });
                                });
                            }

                        }
                    }
                    if (data[4] != null) {
                        BindDataTopoList = data[4];
                    }
                    if (data[5] != null) {
                        BindDataHistoList = data[5];
                    }
                    BindICDODtls();
                    EnableDisableTopography();//priyanka 07/03/2026
                    $("#RbtnCancerN").prop("checked", true);
                    if (data[2] != null) {
                        $("#Diagnosis_Freetext").val((data[2][0]["PROVDIAGNOS"] || "").toString());
                        if (data[2][0]["CANCERYN"].toString() == "Y" || BindDataTopoList.length > 0) {
                            $("#RbtnCancerY").prop("checked", true);
                            $("#RbtnTreatAdvTypeR").prop("checked", data[2][0]["RADIATIONONCOYN"].toString() == "Y" ? true : false);
                            $("#RbtnTreatAdvTypeM").prop("checked", data[2][0]["MEDICALONCOYN"].toString() == "Y" ? true : false);
                            $("#RbtnTreatAdvTypeP").prop("checked", data[2][0]["PALLIATIVECAREYN"].toString() == "Y" ? true : false);
                        }
                    }
                    else if (BindDataTopoList.length > 0) {
                        $("#RbtnCancerY").prop("checked", true);
                    }

                }
                EnDisCancer();
                if (BindDataTopoList.length == 0) {
                    EditICDOFlag = false;
                    document.getElementById("Remark").style.display = "none";
                    $("#ICDORemark").val("");
                }
                else {
                    EditICDOFlag = true;//priyanka 20/04/2026
                    document.getElementById("Remark").style.display = "block";
                }
                if (data[6] != null) {
                    $("#ICDORemark").val(data[6][0].REMARKS);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
    }



    function SetDataForIPDDiagnosis(FormLoadYN) {
        var tranNo = "";
        var IPNO = sessionStorage.getItem("IPPatIPNO") != null ? sessionStorage.getItem("IPPatIPNO") : "";
        var MRNo = sessionStorage.getItem('IPPatMRNO') != null ? sessionStorage.getItem('IPPatMRNO') : "";
        $.ajax({
            type: 'post',
            datatype: 'json',
            data: { strTranNo: tranNo, strMRNO: MRNo, strIpNo: IPNO },
            url: '../SinglePage/SetDataForIPDDiagnosis',
            async: true,
            success: function (data) {
                if (data != "") {

                    if (FormLoadYN == "Y") {
                        if (data[0] != null) {
                            if (!(!data || !data[0] || data[0].length === 0)) {
                                var existingRows = UnCodedDiagListtable.getData();
                                gact = "E"
                                data[0].forEach(function (item) {
                                    var exists = existingRows.some(function (r) {
                                        return r.code === item.DESCCD;
                                    });
                                    if (exists) return;
                                    UnCodedDiagListtable.addRow({
                                        act: "",
                                        code: item.DESCCD,
                                        name: item.NAME,
                                        remark: (item.REMARKS || "").trim(),
                                        SetUpYn: item.SETUPYN
                                    });
                                });
                            }
                        }
                        if (data[1] != null) {
                            if (!(!data || !data[1] || data[1].length === 0)) {
                                var existingRows = ICDDiagListtable.getData();
                                gact = "E";
                                data[1].forEach(function (item) {
                                    var exists = existingRows.some(function (r) {
                                        return r.code === item.ICDCODE;
                                    });
                                    if (exists) return;
                                    ICDDiagListtable.addRow({
                                        act: "",
                                        code: item.ICDCODE,
                                        name: item.NAME,
                                    });
                                });
                            }
                        }
                    }
                    if (data[4] != null) {
                        BindDataTopoList = data[4];
                    }
                    if (data[5] != null) {
                        BindDataHistoList = data[5];
                    }
                    BindICDODtls();
                    $("#RbtnCancerN").prop("checked", true);
                    if (data[2] != null) {
                        if (data[2][0]["CANCERYN"].toString() == "Y" || BindDataTopoList.length > 0) {
                            $("#RbtnCancerY").prop("checked", true);
                            $("#RbtnTreatAdvTypeR").prop("checked", data[2][0]["RADIATIONONCOYN"].toString() == "Y" ? true : false);
                            $("#RbtnTreatAdvTypeM").prop("checked", data[2][0]["MEDICALONCOYN"].toString() == "Y" ? true : false);
                            $("#RbtnTreatAdvTypeP").prop("checked", data[2][0]["PALLIATIVECAREYN"].toString() == "Y" ? true : false);
                        }
                    }
                    else if (BindDataTopoList.length > 0) {
                        $("#RbtnCancerY").prop("checked", true);
                    }
                }
                EnDisCancer();
                if (BindDataTopoList.length == 0) {
                    EditICDOFlag = false;
                    document.getElementById("Remark").style.display = "none";
                    $("#ICDORemark").val("");
                }
                else {
                    EditICDOFlag = true;
                    document.getElementById("Remark").style.display = "block";
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
    }

    function SaveDiagnosis() {
        var mrno = GetSessionMRNO();
        var ipno = sessionStorage.getItem("IPPatIPNO");
        var tranNo = "";
        var Gact = "";
        if (ICDOTopoList.length > 0) {
            jQuery.grep(ICDOTopoList, function (e) {
                e.REMARKS = $("#ICDORemark").val();
            });
            $.each(ICDOTopoList, function (_, item) {
                $.each(item, function (key, value) {
                    if (value == null) { 
                        item[key] = "";
                    }
                });
            });
        }
        var DPrimary = SaveForIPDUnCodedDiagonsis(IPDDataToSendForDraft, "C");
        var DSecondary = SaveForIPDICDDiagonsis(IPDDataToSendForDraft, "C");
        var IPDDataToSendForDraft = {
            strMRNO: mrno,
            strIPNO: ipno,
            strTranNo: tranNo,
            ICDOTopoList: JSON.stringify(ICDOTopoList),
            ICDOHistoList: JSON.stringify(ICDOHistoList),
            DiagPrimary: JSON.stringify(DPrimary),
            DiagSecondary: JSON.stringify(DSecondary),
            Gact: gact
        }
        if (ICDOTopoList.length > 0 || ICDOHistoList.length > 0 || DPrimary.length > 0 || DSecondary.length > 0) {
            $.ajax({
                type: "POST",
                url: '../SinglePage/SaveDiagnosis',
                datatype: "json",
                data: IPDDataToSendForDraft,
                async : false,
                success: function (result) {
                    ToastMsg(result, "info");
                    gact = "E";
                    SetDataForIPDDiagnosis("N");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }
</script>

<%-- ICD O Style --%>
<style>
    .SiteHeaderDiv {
        padding: 0px;
        background-color: #034c7d;
        color: white;
    }

    .SiteHeaderLbl {
        margin: 0;
        padding: 5px 5px;
        font-size: 15px;
    }

    .SiteContentDiv {
        padding: 0px;
        display: block;
        height: -webkit-fill-available;
        margin-bottom: 10px;
    }

    .SiteTopoSrchDiv {
        padding: 0px;
        background-color: #ffffff;
        position: relative;
    }

    .SiteTopoSrchTxt {
        margin-bottom: 10px;
        float: left;
        height: 28px;
        border-radius: 5px;
        border-color: rgba(51, 122, 183, 0.55);
        -webkit-box-shadow: 0 8px 6px -6px black;
        -moz-box-shadow: 0 8px 6px -6px black;
        box-shadow: 0 7px 4px -6px rgb(181, 181, 181);
        margin-top: 4px;
        width: 100%;
    }

    .TopoContentDiv {
    }

    .MainHistoTNMDiv {
        padding: 0px;
        background-color: #ffffff;
        border: 1px solid #719b76;
        display: flex;
        flex-direction: column;
        margin-top: 10px;
    }

    .TopoHistHeaderDiv {
        padding: 5px;
        background-color: #95cf9b;
        color: black;
        font-size: 13px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .TopoHistHeaderLbl {
        margin: 0px;
    }

    .DelTopoIcon {
        font-size: 20px;
        margin-right: 10px;
        cursor: pointer;
        color: #b30000;
    }

.DelTopoIcon[disabled] {
    pointer-events: none;
    opacity: 0.5;
    cursor: not-allowed;
}

    .TNMInfoIcon {
        font-size: 20px;
        margin-right: 10px;
        cursor: pointer;
        color: #0059ff;
    }

    .MainHistoContentTNMDiv {
        padding: 0px;
        margin: 0;
    }

    .TopoHistSrchDiv {
        padding: 0px;
        position: relative;
    }

    .TopoHistSrchTxt {
        margin-bottom: 10px;
        float: left;
        height: 28px;
        border-radius: 5px;
        border-color: rgba(51, 122, 183, 0.55);
        -webkit-box-shadow: 0 8px 6px -6px black;
        -moz-box-shadow: 0 8px 6px -6px black;
        box-shadow: 0 7px 4px -6px rgb(181, 181, 181);
        margin-top: 4px;
        width: 100%;
    }

    .MainHistoContent {
        padding: 5px;
        background-color: #ffffff;
        border-right: 2px solid #b9b9b940;
    }

    .HistoTbl {
        width: max-content;
        border-collapse: collapse;
        font-family: Arial, sans-serif;
        font-size: 14px;
        background-color: #fff;
        min-width: 100%;
    }

        .HistoTbl thead {
            position: sticky;
            top: 0;
        }

            .HistoTbl thead td {
                text-align: center;
                background-color: #3b5998;
                color: white;
                font-weight: bold;
                padding: 10px;
                border: 1px solid #d5d5d5;
            }

        .HistoTbl tbody td {
            padding: 10px;
            border: 1px solid #d5d5d5;
            color: #333;
        }

        .HistoTbl tr:hover {
            background-color: #f9f9f9;
        }

    .HistoTbl-scroll-container {
        max-height: 300px;
        overflow-y: auto;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .TMNMainDiv {
        padding: 5px;
        display: flex;
        align-items: flex-start;
        min-width: 250px;
        flex-direction: column;
    }

    .TMNDiv {
        display: flex;
        align-items: center;
        /*width: 100%;*/
        padding: 10px 0px;
    }

    .TMNLabel {
        min-width: 80px;   /*Pournima changed width 100px to 80px;*/
        padding-right: 10px;
        text-align: right !important;
         text-align: center;
    }


    .SearchList {
        width: 100%;
        display: block;
        position: absolute;
        z-index: 2147483647;
        top: 32px;
        background-color: rgb(255 255 255);
        border: 1px solid;
        max-height: 250px;
        overflow: auto;
    }

    .SearchListItem {
        padding: 5px;
        cursor: pointer;
        border-bottom: 1px solid;
    }

        .SearchListItem:hover {
            background-color: #eee;
        }

.DelHisto {
    font-size: 20px;
}

.DelHisto[disabled] {
    pointer-events: none;
    opacity: 0.5;
    cursor: not-allowed;
}

    .PrimaryClass {
        font-weight: 800;
    }

    .ToggleUpDownIcon {
        float: right;
        color: black;
        font-size: 20px;
        cursor: pointer;
    }
</style>

<%-- ICD O --%>
<script type="text/javascript">  
    var ICDOTopoList = [];
    var ICDOHistoList = [];
    var SrchTopologyList = [];
    var SrchHistoList = [];
    var GradeOptList = [];
    var PrefixOpt = "";
    var BindDataTopoList = [];
    var BindDataHistoList = [];
    var DefTListOption = [{ T: "TX" }, { T: "T0" }];
    var DefNListOption = [{ N: "NX" }];
    var DefMListOption = [];
    var AllowSaveDiagnosis = false;
    var EditICDOFlag = false;
    var DefValueYN = "N";
    var TNMNotFilter = "N";
    var OtherFieldList = [
        { ID: "GEOGRAPHIC", LABEL: "Grade", CenterStyle: "N" },
        { ID: "LOCATION", LABEL: "Location", CenterStyle: "Y" },
        { ID: "MITOTIC", LABEL: "Mitotic", CenterStyle: "Y" },
        { ID: "PSA", LABEL: "PSA", CenterStyle: "Y" },
        { ID: "SERUMMARKERS", LABEL: "Serum Markers", CenterStyle: "N" },
        { ID: "HERITABLETRAIT", LABEL: "Heritable Trait", CenterStyle: "Y" },
        { ID: "HER2", LABEL: "HER2", CenterStyle: "Y" },
        { ID: "ER", LABEL: "ER", CenterStyle: "Y" },
        { ID: "PR", LABEL: "PR", CenterStyle: "Y" },
        { ID: "BLOODINVL", LABEL: "Blood invl.", CenterStyle: "N" },
    ];
    //Form Load
    function LoadICDO() {
        GetDiagLoadList();
    }

    //Disable All the ICD-O Field
    function EditICDODetails(FlagYN) {
        if (FlagYN != "Y") {
            if (document.getElementById("ICDOEdit").innerText == "Edit") {
                document.getElementById("ICDOEdit").innerText = "Cancel";
                FlagYN = "N";
                $("#btnSave").show();
            }
            else {
                if (sessionStorage.getItem("MODULE_FLAG") == "IPD") {
                    SetDataForIPDDiagnosis("N");//priyanka 02/03/2026
                }
                else
                {
                    SetDataForDiagnosis("N");
                }
                document.getElementById("ICDOEdit").innerText = "Edit";
                FlagYN = "Y";
                $("#btnSave").hide();
            }
        }
        var div = document.getElementById('MAIN_ICDO');
        var fields = div.querySelectorAll('input, textarea, select, button');
        fields.forEach(function (field) {
            field.disabled = FlagYN == "Y" ? true : false;
        });
        var icon = div.querySelectorAll('.DelTopoIcon');
        jQuery.grep(icon, function (e) {
            e.style.pointerEvents = FlagYN == "Y" ? 'none' : 'auto';
            e.style.opacity = FlagYN == "Y" ? '0.5' : '1';
        });
        var icons = div.querySelectorAll('.DelHisto');
        jQuery.grep(icons, function (e) {
            e.style.pointerEvents = FlagYN == "Y" ? 'none' : 'auto';
            e.style.opacity = FlagYN == "Y" ? '0.5' : '1';
        });

        if (BindDataTopoList.length == 0) {
            document.getElementById("Remark").style.display = "none";
            $("#ICDORemark").val("");
        }
        else {
            document.getElementById("Remark").style.display = "block";
        }

        div = document.getElementById('CancerOptDiv');
        fields = div.querySelectorAll('input, textarea, select, button');
        fields.forEach(function (field) {
            field.disabled = false;
        });
    }
    //Set Grade Options
    function GetGradeString(ListData) {
        var Option = '<option value="{VALUE}">{TEXT}</option>';
        var AllOption = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
        jQuery.grep(ListData, function (e) {
            var Options = Option.replace("{VALUE}", e.Value.trim()).replace("{TEXT}", e.Text.trim());
            AllOption = AllOption + Options;
        });
        return AllOption;
    }
    //Set Prefix Options
    function GetPrefixString(ListData) {
        var Option = '<option value="{VALUE}">{TEXT}</option>';
        var AllOption = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
        jQuery.grep(ListData, function (e) {
            var Options = Option.replace("{VALUE}", e.Value.trim()).replace("{TEXT}", e.Text.trim());
            AllOption = AllOption + Options;
        });
        return AllOption;
    }
    //Get List of Topology ,Histology , Grade , Prefix
    function GetDiagLoadList() {
        $.ajax({
            type: 'post',
            datatype: 'json',
            url: '../DoctorDesk/GetToplogyHistoDefList',
            async: true,
            success: function (data) {
                SrchTopologyList = data[0];
                SrchHistoList = data[1];
                GradeOptList = data[2];
                PrefixOpt = GetPrefixString(data[3]);
            }
        });
    }

    //Enable and Disable Topography
    function EnableDisableTopography() {
        if (typeof SessionCompDiag !== 'undefined' && SessionCompDiag === "Y") {
            $('[id="1_Main_Topo_Div_C62.1_Descended testis"]')
                .css("pointer-events", "none");
        }
    }

    //Bind Saved Data
    function BindICDODtls() {
        $("#Search_Topo_Content_1").empty();
        $("#Search_Topo_Content_2").empty();
        jQuery.grep(BindDataTopoList, function (e) {
            BindTopGraphy(e.TOPOCODE.trim(), e.TOPODESC.trim(), e.SITELEVEL, e.TOPOTYPE.trim());
            AddRemoveTopoGraphy("A", e.TOPOCODE.trim(), e.TOPODESC.trim(), e.SITELEVEL, e.TOPOTYPE.trim());
            $('[id="' + e.SITELEVEL + '_CmbSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.TNMSITECODE);
            $('[id="' + e.SITELEVEL + '_CmbSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_CmbSubSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.TNMSUBSITECODE);
            $('[id="' + e.SITELEVEL + '_CmbSubSiteList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');

            $('[id="' + e.SITELEVEL + '_CmbPrefixList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.TNMPREFIX);
            $('[id="' + e.SITELEVEL + '_CmbPrefixList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
          
            $('[id="' + e.SITELEVEL + '_FINALCHK_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').prop('checked',e.FINALDIAGYN);
            $('[id="' + e.SITELEVEL + '_FINALCHK_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');

            $('[id="' + e.SITELEVEL + '_Chk_ReOccur_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').prop('checked', e.RECCURENT === "Y");
            $('[id="' + e.SITELEVEL + '_Chk_ReOccur_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');

            $('[id="' + e.SITELEVEL + '_Chk_Adjuvant_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').prop('checked', e.ADJUVANT === "Y");
            $('[id="' + e.SITELEVEL + '_Chk_Adjuvant_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');

            $('[id="' + e.SITELEVEL + '_ICDTList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.T);
            $('[id="' + e.SITELEVEL + '_ICDTList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_ICDNList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.N);
            $('[id="' + e.SITELEVEL + '_ICDNList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_ICDMList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.M);
            $('[id="' + e.SITELEVEL + '_ICDMList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');

            $('[id="' + e.SITELEVEL + '_GEOGRAPHIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.GEOGRAPHIC);
            $('[id="' + e.SITELEVEL + '_GEOGRAPHIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_LOCATION_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.LOCATION);
            $('[id="' + e.SITELEVEL + '_LOCATION_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_MITOTIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.MITOTIC);
            $('[id="' + e.SITELEVEL + '_MITOTIC_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_PSA_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.PSA);
            $('[id="' + e.SITELEVEL + '_PSA_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_SERUMMARKERS_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.SERUMMARKERS);
            $('[id="' + e.SITELEVEL + '_SERUMMARKERS_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_HERITABLETRAIT_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.HERITABLETRAIT);
            $('[id="' + e.SITELEVEL + '_HERITABLETRAIT_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_HER2_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.HER2);
            $('[id="' + e.SITELEVEL + '_HER2_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_ER_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.ER);
            $('[id="' + e.SITELEVEL + '_ER_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_PR_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.PR);
            $('[id="' + e.SITELEVEL + '_PR_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_BLOODINVL_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.BLOODINVL);
            $('[id="' + e.SITELEVEL + '_BLOODINVL_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
            $('[id="' + e.SITELEVEL + '_CmbStageList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').val(e.STAGE);
            $('[id="' + e.SITELEVEL + '_CmbStageList_' + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + '"]').trigger('change');
        });
        jQuery.grep(BindDataHistoList, function (e) {
            BindHistologyTbl(e.TOPOCODE.trim(), e.TOPODESC.trim(), e.HCODE.trim(), e.HDESC.trim(), e.SITELEVEL, e.HISTOGRADETYPE);
            AddRemoveHisto("A", e.TOPOCODE.trim(), e.TOPODESC.trim(), e.HCODE.trim(), e.HDESC.trim(), e.SITELEVEL, e.HTYPE, e.TOPOTYPE);
            var GradeId = e.SITELEVEL + "_CmbGrade_" + e.TOPOCODE.trim() + "_" + e.TOPODESC.trim() + "_" + e.HCODE.trim();
            $('[id="' + GradeId + '"]').val(e.HGRADE);
            $('[id="' + GradeId + '"]').trigger('change');
        });
        if (SessionCompDiag != "Y") {
            $("#MAIN_ICDO input[type='checkbox'], #MAIN_ICDO select").prop("disabled", true);
        }
    }
    //Search For Topology
    function SearchTopoGraphy(Id, SiteLevel) {
        var input = document.getElementById(Id).value.toLowerCase();
        var filteredList = SrchTopologyList.filter(function (item) {
            var FiltExists = ICDOTopoList.filter(function (e) { return e.SITELEVEL.trim() == SiteLevel && e.TOPOCODE.trim().toLowerCase().includes(item.Value.trim().toLowerCase()) && e.TOPODESC.trim().toLowerCase().includes(item.Text.trim().toLowerCase()); });
            if (FiltExists.length == 0)
                return item.Value.trim().toLowerCase().includes(input) || item.Text.trim().toLowerCase().includes(input);
        });
        BindSrchTopoList(filteredList, SiteLevel);
    }
    //Bind Search Topology to List
    function BindSrchTopoList(lst, SiteLevel) {
        var container = document.getElementById('TopographySrchLst_' + SiteLevel);
        container.innerHTML = "";
        if (lst.length === 0) {
            container.innerHTML = "<div style='font-size: 14px;padding: 5px;'>No results found.</div>";
            container.style.display = "block";
            return;
        }
        lst.forEach(function (item) {
            var div = document.createElement('div');
            div.textContent = item.Value.trim() + " - " + item.Text.trim();
            div.className = "SearchListItem " + (item.Type == "P" ? "PrimaryClass" : "");
            div.onclick = function () {
                BindTopGraphy(item.Value.trim(), item.Text.trim(), SiteLevel, item.Type);
                AddRemoveTopoGraphy("A", item.Value.trim(), item.Text.trim(), SiteLevel, item.Type);
                          SearchTopoGraphyscroll(); // Added By Abhishesh || 20260316
 };
            container.appendChild(div);
        });
        container.style.display = "block";
    }
    //Bind Selected Topology 
    function BindTopGraphy(TopoCode, TopoName, SiteLevel, TopoType) {
        var MainDiv = '<div id="{MAINDIVID}" class="col-xs-12 MainHistoTNMDiv">{MAINDIVCONTENT}</div>';
        var TopoHeadDiv = '<div id="{TOPOHEADDIVID}" class="col-xs-12 TopoHistHeaderDiv"><label class="TopoHistHeaderLbl">Topography - {TOPOLOGYCODE} - {TOPOLOGYNAME}</label><input type="text" id="{TOPOCODETXTID}" style="display: none;" /><div><input type="checkbox" id="{FINALCHKID}" onclick=\'SelectOneOnly("{SITELEVEL}", "{TOPOCODE}", "{TOPONAME}");\' onchange=\'UpdateTNM("{SITELEVEL}", "{TOPOCODE}", "{TOPONAME}");\' style="margin-right:4px; vertical-align: middle;" /><label for="{FINALCHKID}" style="margin-right:10px;color: #1b5e20; font-weight: bold; margin-right: 10px; vertical-align: text-top;">Final Diagnosis</label><i class="fa fa-trash DelTopoIcon {hide}" onclick=\'RemoveTopoGraphy("{TOPOCODE}","{TOPONAME}","{SITELEVEL}");\' aria-hidden="true"></i>{ARROWCONTENT}</div></div>';
        var ArrowContent = '<i class="fa fa-chevron-circle-down DownUpTopoIcon" style="display:none" id="{DOWNARROWID}" onclick=\'ToggleHistologyContent("D","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i><i id="{UPARROWID}" class="fa fa-chevron-circle-up DownUpTopoIcon" onclick=\'ToggleHistologyContent("U","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i>';
        var TNMArrowContent = '<i class="fa fa-chevron-circle-down DownUpTopoIcon" style="display:none" id="{DOWNARROWID}" onclick=\'ToggleTNMAllContent("D","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i><i id="{UPARROWID}" class="fa fa-chevron-circle-up DownUpTopoIcon" onclick=\'ToggleTNMAllContent("U","{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' ></i>';
        var HistoTNMContDiv = '<div class="row MainHistoContentTNMDiv" id="{HISTOMAINCONTENTID}">{HISTOTNMCONTENTDIV}</div>';
        var HistoContDiv = '<div class="col-xs-12 col-xl-7 MainHistoContent">{HISTCONTENTDIV}</div>';
        var HistoSrchDiv = '<div class="col-xs-12 TopoHistSrchDiv"><input type="text" id="{HISTOSRCHTXTID}" onkeyup=\'SearchHistology("{TOPOCODE}","{TOPONAME}","{TOPOTYPE}","{SITELEVEL}")\' autocomplete="off" placeholder="Search Histology/Behaviour..." class="TopoHistSrchTxt" {disable}><div class="SearchList" style="display:none;" id="{HISTOSRCHLISTID}"></div></div>';
        var HistoTable = '<div class="table-responsive HistoTbl-scroll-container"><table id="{HISTOTBLID}" class="HistoTbl"><thead><tr><td style="width: 40px">Act</td><td style="width: 100px">Code</td><td style="width: 120px">Histo/Behaviour</td><td>Description</td><td style="width: 200px;">Grade</td></tr></thead><tbody id="{HISTOTBLBODYID}"></tbody></table></div>';
        var TNMDesc = '<div class="col-xs-12 col-xl-5 TMNMainDiv"><div class="TNMHeaderDiv col-xs-12"><label style="margin: 0px;" id="{TNMDESCHEADLBL}"></label><div style="display: inline-block;float: right;">{ARROWTNM}</div></div>{TNMDESC}</div>';
        var TDesc = '<div class="TNMDescDiv" style="padding: 0px;" id="{TDESCMAINDIV}"><div class="table-responsive custom-scroll-container"><table id="{TDESCTBL}" class="table custom-table"><thead><tr><td colspan="2">Primary Tumor(T) {DOWNUPICON}</td></tr></thead><tbody id="{TBODYID}"></tbody></table></div></div>';
        var NDesc = '<div class="TNMDescDiv" style="padding: 0px;" id="{NDESCMAINDIV}"><div class="table-responsive custom-scroll-container"><table id="{NDESCTBL}" class="table custom-table"><thead><tr><td colspan="2">Regional Lymph Nodes(N) {DOWNUPICON}</td></tr></thead><tbody id="{NBODYID}"></tbody></table></div></div>';
        var MDesc = '<div class="TNMDescDiv" style="padding: 0px;" id="{MDESCMAINDIV}"><div class="table-responsive custom-scroll-container"><table id="{MDESCTBL}" class="table custom-table"><thead><tr><td colspan="2">Distant Metastasis(M) {DOWNUPICON}</td></tr></thead><tbody id="{MBODYID}"></tbody></table></div></div>';
        var TNMDiv = '<div class="row" style="padding: 0px 10px;">{TNMCONTENT}</div>';
        var SiteDiv = '<div class="TMNDiv col-xs-12 col-md-12 col-lg-6"><label class="TMNLabel">Site</label><select id="{SITECMBID}" onchange=\'GetSubSiteList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control" {disable}></select></div>';
        var SubSiteDiv = '<div class="TMNDiv col-xs-12 col-md-12 col-lg-6"><label class="TMNLabel">Sub-Site</label><select id="{SUBSITECMBID}" onchange=\'GetTNMList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}");\' class="form-control"  {disable}></select></div>';
        var ReOcurrenceDiv = '<div class="TMNDiv col-xs-12 col-md-12 col-lg-6">' +
            '<span style="white-space: nowrap;">' +
            '<input type="checkbox" id="{REOCCURID}" name="{REOCCURNAME}" onchange=\'UpdateTNM("{SITELEVEL}", "{TOPOCODE}", "{TOPONAME}");\' value="Y" style="vertical-align: text-bottom; margin-right: 3px; cursor: pointer;">' +
            '<label for="{REOCCURID}" class="TMNLabel" style="margin-bottom: 0px; cursor: pointer; font-weight: normal;">Recurrent</label>' +
            '</span>' +
            '</div>';
        var AdjuvantDiv = '<div class="TMNDiv col-xs-12 col-md-12 col-lg-6">' +
            '<span style="white-space: nowrap;">' +
            '<input type="checkbox" id="{ADJUVANTID}" name="{ADJUVANTNAME}" onchange=\'UpdateTNM("{SITELEVEL}", "{TOPOCODE}", "{TOPONAME}");\' value="Y" style="vertical-align: text-bottom;margin-left: 97px; margin-right: 6px; cursor: pointer;">' +
            '<label for="{ADJUVANTID}" class="TMNLabel" style="margin-bottom: 0px; cursor: pointer; font-weight: normal;">Neo adjuvant treatment</label>' +
            '</span>' +
            '</div>';
            //End
 var LineBreakDiv = '<div class="col-xs-12"></div>';
  // End By Roshan 17/2/2027
  var PrefixDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label class="TMNLabel"><span id="{PREFIXLABELID}">Prefix</span><i class="fa fa-question-circle" style="font-size: 14px;margin-right: 10px;color: #000000;cursor: pointer;padding-left: 5px;" id="PopPrefix" title="Prefix Information" onclick=\'OpenPopInfoGuide("P")\' aria-hidden="true"></i></label><select id="{PREFIXCMBID}" onchange=\'FilterTList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}");\' class="form-control"></select></div>';
        var TDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label style="text-align: center;" class="TMNLabel">T</label><select id="{TCMBID}" onchange=\'FilterNList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
        var NDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label style="text-align: center;" class="TMNLabel">N</label><select id="{NCMBID}" onchange=\'FilterMList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
        var MDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label style="text-align: center;" class="TMNLabel">M</label><select id="{MCMBID}" onchange=\'FilterOthrList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
        var OthrDiv = '<div id="{OTHERDIVID}" style="width:100%;display: flex;flex-wrap: wrap;"class="TMNDiv col-xs-12 col-md-6 col-lg-3"></div>';
        var StageDiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label class="TMNLabel">Stage</label><select id="{STAGECMBID}" onchange=\'UpdateTNM("{SITELEVEL}","{TOPOCODE}","{TOPONAME}")\' class="form-control"></select></div>';
        var DownUpIcon = '<i class="fa fa-chevron-circle-down ToggleUpDownIcon" id="{DOWNID}" onclick=\'ToggleTNM("D",this.id,"{BODYID}","{UPID}")\' style="float:right;display:none;" aria-hidden="true"></i><i class="fa fa-chevron-circle-up ToggleUpDownIcon" id="{UPID}" onclick=\'ToggleTNM("U",this.id,"{BODYID}","{DOWNID}")\' aria-hidden="true"></i>';
        var MainDivId = SiteLevel + "_Main_Topo_Div_" + TopoCode + "_" + TopoName;
        var TopoHeadDivId = SiteLevel + "_Topo_Header_" + TopoCode + "_" + TopoName;
        var TopoCodeTxtId = SiteLevel + "_txtTopo_" + TopoCode + "_" + TopoName;
        var HistoSrchid = SiteLevel + "_Srch_Topo_Histo_" + TopoCode + "_" + TopoName;
        var HistoSrchListid = SiteLevel + "_Srch_Topo_Histo_List_" + TopoCode + "_" + TopoName;
        var HistoTblId = SiteLevel + "_Hist_Tbl_" + TopoCode + "_" + TopoName;
        var HistoTblBodyId = SiteLevel + "_Hist_Tbl_Body_" + TopoCode + "_" + TopoName;
        var SiteComboId = SiteLevel + "_CmbSiteList_" + TopoCode + "_" + TopoName;
        var SubSiteComboId = SiteLevel + "_CmbSubSiteList_" + TopoCode + "_" + TopoName;
  //Added By Roshan 17/2/2026
        var ReOccurName = SiteLevel + "_Chk_ReOccurName_" + TopoCode + "_" + TopoName;
        var ReOccurId = SiteLevel + "_Chk_ReOccur_" + TopoCode + "_" + TopoName;
        var PrefixLabelId = SiteLevel + "_LblPrefixTxt_" + TopoCode;

        var AdjuvantName = SiteLevel + "_Radio_AdjuvantName_" + TopoCode + "_" + TopoName;
        var AdjuvantId = SiteLevel + "_Chk_Adjuvant_" + TopoCode + "_" + TopoName;
  //End By Roshan 17/2/2027
        var PrefixComboId = SiteLevel + "_CmbPrefixList_" + TopoCode + "_" + TopoName;
        var TComboId = SiteLevel + "_ICDTList_" + TopoCode + "_" + TopoName;
        var NComboId = SiteLevel + "_ICDNList_" + TopoCode + "_" + TopoName;
        var MComboId = SiteLevel + "_ICDMList_" + TopoCode + "_" + TopoName;
        var OtherDivId = SiteLevel + "_OTHRDIVID_" + TopoCode + "_" + TopoName;
        var StageComboId = SiteLevel + "_CmbStageList_" + TopoCode + "_" + TopoName;
        var TNMHeaderLblId = SiteLevel + "_TNM_HEADER_LBL_" + TopoCode + "_" + TopoName;
        var TDescTbl = SiteLevel + "_TDescTbl_" + TopoCode + "_" + TopoName;
        var NDescTbl = SiteLevel + "_NDescTbl_" + TopoCode + "_" + TopoName;
        var MDescTbl = SiteLevel + "_MDescTbl_" + TopoCode + "_" + TopoName;
        var TBodyId = SiteLevel + "_TTBody_" + TopoCode + "_" + TopoName;
        var NBodyId = SiteLevel + "_NTBody_" + TopoCode + "_" + TopoName;
        var MBodyId = SiteLevel + "_MTBody_" + TopoCode + "_" + TopoName;
        var TDownId = SiteLevel + "_TDOWN_" + TopoCode + "_" + TopoName;
        var TUpId = SiteLevel + "_TUP_" + TopoCode + "_" + TopoName;
        var NDownId = SiteLevel + "_NDOWN_" + TopoCode + "_" + TopoName;
        var NUpId = SiteLevel + "_NUP_" + TopoCode + "_" + TopoName;
        var MDownId = SiteLevel + "_MDOWN_" + TopoCode + "_" + TopoName;
        var MUpId = SiteLevel + "_MUP_" + TopoCode + "_" + TopoName;
        var MainContentId = SiteLevel + "_MAINCONTENT_" + TopoCode + "_" + TopoName;
        var DownArrowID = SiteLevel + "_DOWNARROW_" + TopoCode + "_" + TopoName;
        var UpArrowID = SiteLevel + "_UPARROW_" + TopoCode + "_" + TopoName;
        var FinalChkId = SiteLevel + "_FINALCHK_" + TopoCode + "_" + TopoName;
        var RplArrowContent = ArrowContent.replace("{DOWNARROWID}", DownArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
            .replace("{UPARROWID}", UpArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
        var RplTDownUpIcon = DownUpIcon.replace("{DOWNID}", TDownId).replace("{BODYID}", TBodyId).replace("{UPID}", TUpId)
            .replace("{UPID}", TUpId).replace("{BODYID}", TBodyId).replace("{DOWNID}", TDownId);
        var RplNDownUpIcon = DownUpIcon.replace("{DOWNID}", NDownId).replace("{BODYID}", NBodyId).replace("{UPID}", NUpId)
            .replace("{UPID}", NUpId).replace("{BODYID}", NBodyId).replace("{DOWNID}", NDownId);
        var RplMDownUpIcon = DownUpIcon.replace("{DOWNID}", MDownId).replace("{BODYID}", MBodyId).replace("{UPID}", MUpId)
            .replace("{UPID}", MUpId).replace("{BODYID}", MBodyId).replace("{DOWNID}", MDownId);
        var RplTopoHeadDiv = TopoHeadDiv.replace("{TOPOHEADDIVID}", TopoHeadDivId).replace("{TOPOLOGYCODE}", TopoCode).replace("{TOPOLOGYNAME}", TopoName).replace("{TOPOCODETXTID}", TopoCodeTxtId).replace("{FINALCHKID}", FinalChkId)
            .replace(/{TOPOCODE}/g, TopoCode)
            .replace(/{TOPONAME}/g, TopoName)
            .replace(/{SITELEVEL}/g, SiteLevel)
            .replace("{ARROWCONTENT}", RplArrowContent)
            .replace("{hide}", SessionCompDiag != "Y" ? "d-none" : "");
        var RplHistoSrchDiv = HistoSrchDiv.replace("{HISTOSRCHTXTID}", HistoSrchid).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{TOPOTYPE}", TopoType).replace("{HISTOSRCHLISTID}", HistoSrchListid).replace("{SITELEVEL}", SiteLevel).replace('{disable}', SessionCompDiag != "Y" ? "disabled" : "");
        var RplHistoTable = HistoTable.replace("{HISTOTBLID}", HistoTblId).replace("{HISTOTBLBODYID}", HistoTblBodyId);
        var RplSiteDiv = SiteDiv.replace("{SITECMBID}", SiteComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
            .replace('{disable}', SessionCompDiag != "Y" ? "disabled" : "");
        var RplSubSiteDiv = SubSiteDiv.replace("{SUBSITECMBID}", SubSiteComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel).replace("{SITELEVEL}", SiteLevel)
            .replace('{disable}', SessionCompDiag != "Y" ? "disabled" : "");      
   //Added By Roshan 17/2/2026
  var RplReOcurrenceDiv = ReOcurrenceDiv.replace(/{REOCCURNAME}/g, ReOccurName)
      .replace(/{ADJUVANTNAME}/g, AdjuvantName)
      .replace(/{REOCCURID}/g, ReOccurId) // Replaces the single ID
      .replace(/{PREFIXLABELID}/g, PrefixLabelId)
      .replace(/{SITELEVEL}/g, SiteLevel)
      .replace(/{TOPOCODE}/g, TopoCode)
      .replace(/{TOPONAME}/g, TopoName);
  var RplAdjuvantDiv = AdjuvantDiv.replace(/{ADJUVANTNAME}/g, AdjuvantName)
      .replace(/{REOCCURNAME}/g, ReOccurName)
      .replace(/{ADJUVANTID}/g, AdjuvantId) // Replaces the single ID
      .replace(/{PREFIXLABELID}/g, PrefixLabelId)
      .replace(/{SITELEVEL}/g, SiteLevel)
      .replace(/{TOPOCODE}/g, TopoCode)
      .replace(/{TOPONAME}/g, TopoName);
 var RplPrefixDiv = PrefixDiv.replace("{PREFIXCMBID}", PrefixComboId).replace("{PREFIXLABELID}", PrefixLabelId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
 //End By Roshan 17/2/2026
var RplTDiv = TDiv.replace("{TCMBID}", TComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
        var RplNDiv = NDiv.replace("{NCMBID}", NComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
        var RplMDiv = MDiv.replace("{MCMBID}", MComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
        var RplOthrDiv = OthrDiv.replace("{OTHERDIVID}", OtherDivId);
        var RplStageDiv = StageDiv.replace("{STAGECMBID}", StageComboId).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
        var RplTNMDiv = TNMDiv.replace("{TNMCONTENT}", (RplSiteDiv + RplSubSiteDiv+ RplAdjuvantDiv + RplReOcurrenceDiv + LineBreakDiv + RplPrefixDiv + RplTDiv + RplNDiv + RplMDiv + RplOthrDiv + RplStageDiv));        var RplHistoContDiv = HistoContDiv.replace("{HISTCONTENTDIV}", (RplHistoSrchDiv + RplHistoTable + RplTNMDiv));
        var TDescMainDivId = SiteLevel + "_TDESCDIV_" + TopoCode + "_" + TopoName;
        var NDescMainDivId = SiteLevel + "_NDESCDIV_" + TopoCode + "_" + TopoName;
        var MDescMainDivId = SiteLevel + "_MDESCDIV_" + TopoCode + "_" + TopoName;
        var TNMDownArrowID = SiteLevel + "_TNMDOWNARROW_" + TopoCode + "_" + TopoName;
        var TNMUpArrowID = SiteLevel + "_TNMUPARROW_" + TopoCode + "_" + TopoName;
        var RplTDesc = TDesc.replace("{TDESCTBL}", TDescTbl).replace("{TBODYID}", TBodyId).replace("{DOWNUPICON}", RplTDownUpIcon).replace("{TDESCMAINDIV}", TDescMainDivId);
        var RplNDesc = NDesc.replace("{NDESCTBL}", NDescTbl).replace("{NBODYID}", NBodyId).replace("{DOWNUPICON}", RplNDownUpIcon).replace("{NDESCMAINDIV}", NDescMainDivId);
        var RplMDesc = MDesc.replace("{MDESCTBL}", MDescTbl).replace("{MBODYID}", MBodyId).replace("{DOWNUPICON}", RplMDownUpIcon).replace("{MDESCMAINDIV}", MDescMainDivId);
        var RplArrowTNMContent = TNMArrowContent.replace("{DOWNARROWID}", TNMDownArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel)
            .replace("{UPARROWID}", TNMUpArrowID).replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{SITELEVEL}", SiteLevel);
        var RplTNMDesc = TNMDesc.replace("{TNMDESCHEADLBL}", TNMHeaderLblId).replace("{TNMDESC}", (RplTDesc + RplNDesc + RplMDesc)).replace("{ARROWTNM}", (RplArrowTNMContent));
        var RplHistoTNMContDiv = HistoTNMContDiv.replace("{HISTOMAINCONTENTID}", MainContentId).replace("{HISTOTNMCONTENTDIV}", (RplHistoContDiv + RplTNMDesc))
        var AllContent = RplTopoHeadDiv + RplHistoTNMContDiv;
        var RplMainDiv = MainDiv.replace("{MAINDIVID}", MainDivId).replace("{MAINDIVCONTENT}", AllContent)
        $("#Search_Topo_Content_" + SiteLevel).append(RplMainDiv);
        LoadNewTNM(SiteLevel, TopoCode, TopoName);
    }
    function OpenPopInfoGuide(Type) {
        if (Type == "P") {
            document.getElementById("InfoHeadLabel").innerText = "Prefix Info";
            $("#TblPrefixInfo").show();
        }
        document.getElementById("POPUPInfoModal").style.display = "flex";
        document.documentElement.style.overflow = 'hidden';
    }
    //Added By Roshan 17/2/2026
     //function UpdatePrefix(reoccurName, adjuvantName, labelId) {
 //    var rVal = $('input[name="' + reoccurName + '"]:checked').val();
 //    var aVal = $('input[name="' + adjuvantName + '"]:checked').val();
 //    var prefixStr = "";
 //    if (rVal === "Y" || rVal === "Yes") {
 //        prefixStr += "r";
 //    }
 //    if (aVal === "Y" || aVal === "Yes") {
 //        prefixStr += "y";
 //    }
 //    var lbl = document.getElementById(labelId);
 //    if (lbl) {
 //        lbl.innerText = prefixStr + "Prefix";
 //    } 
 //}
    function SelectOneOnly(SiteLevel, TopoCode, TopoName) {
        var checkboxToCheck = '#' + CSS.escape(SiteLevel + '_FINALCHK_' + TopoCode + '_' + TopoName);
        $('input[type="checkbox"][id*="_FINALCHK_"]').prop('checked', false);
        $(checkboxToCheck).prop('checked', true);
        UpdateTNM(SiteLevel, TopoCode, TopoName);
    }
    //End By Roshan 17/2/2026

    //Toggle Histology
    function ToggleHistologyContent(Type, TopoCode, TopoName, SiteLevel) {
        var MainContentId = SiteLevel + "_MAINCONTENT_" + TopoCode + "_" + TopoName;
        var DownArrowID = SiteLevel + "_DOWNARROW_" + TopoCode + "_" + TopoName;
        var UpArrowID = SiteLevel + "_UPARROW_" + TopoCode + "_" + TopoName;
        if (Type == "D") {
            document.getElementById(MainContentId).style.display = "flex";
            document.getElementById(DownArrowID).style.display = "none";
            document.getElementById(UpArrowID).style.display = "inline-block";
        }
        else {
            document.getElementById(MainContentId).style.display = "none";
            document.getElementById(UpArrowID).style.display = "none";
            document.getElementById(DownArrowID).style.display = "inline-block";
        }
    }
    //Toggle TNM Whole Content
    function ToggleTNMAllContent(Type, TopoCode, TopoName, SiteLevel) {
        var TDescMainDivId = SiteLevel + "_TDESCDIV_" + TopoCode + "_" + TopoName;
        var NDescMainDivId = SiteLevel + "_NDESCDIV_" + TopoCode + "_" + TopoName;
        var MDescMainDivId = SiteLevel + "_MDESCDIV_" + TopoCode + "_" + TopoName;
        var DownArrowID = SiteLevel + "_TNMDOWNARROW_" + TopoCode + "_" + TopoName;
        var UpArrowID = SiteLevel + "_TNMUPARROW_" + TopoCode + "_" + TopoName;
        if (Type == "D") {
            document.getElementById(TDescMainDivId).style.display = "block";
            document.getElementById(NDescMainDivId).style.display = "block";
            document.getElementById(MDescMainDivId).style.display = "block";
            document.getElementById(DownArrowID).style.display = "none";
            document.getElementById(UpArrowID).style.display = "inline-block";
        }
        else {
            document.getElementById(TDescMainDivId).style.display = "none";
            document.getElementById(NDescMainDivId).style.display = "none";
            document.getElementById(MDescMainDivId).style.display = "none";
            document.getElementById(UpArrowID).style.display = "none";
            document.getElementById(DownArrowID).style.display = "inline-block";
        }
    }
    //Remove Topology
    function RemoveTopoGraphy(TopoCode, TopoName, SiteLevel) {
        var DivId = SiteLevel + "_Main_Topo_Div_" + TopoCode + "_" + TopoName;
        var elem = document.getElementById(DivId);
        if (elem) {
            elem.remove();
        }
        AddRemoveTopoGraphy("R", TopoCode, "", SiteLevel, "");
    }
    //Add or Remove Topology in the Array
    function AddRemoveTopoGraphy(Type, TopoCode, TopoName, SiteLevel, PType) {
        if (Type == "A") {
            var NewD = {
                SITELEVEL: SiteLevel,
                TOPOCODE: TopoCode.trim(),
                TOPODESC: TopoName.trim(),
                TOPOTYPE: PType,
                TNMSITECODE: "",
                TNMSUBSITECODE: "",
                TNMPREFIX: "",
                T: "",
                N: "",
                M: "",
                STAGE: ""
            }
            ICDOTopoList.push(NewD);
        }
        else {
            var TempD = ICDOTopoList.filter(function (e) { return e.SITELEVEL.toString().trim() != SiteLevel && e.TOPOCODE.toString().trim() != TopoCode && e.TOPODESC.toString().trim() != TopoName; });
            ICDOTopoList = JSON.parse(JSON.stringify(TempD));
            var TempDO = ICDOHistoList.filter(function (e) { return e.SITELEVEL.toString().trim() != SiteLevel && e.TOPOCODE.toString().trim() != TopoCode && e.TOPODESC.toString().trim() != TopoName; });
            ICDOHistoList = JSON.parse(JSON.stringify(TempDO));
        }
    }
    //Search Histology
    function SearchHistology(TopoCode, TopoName, TopoType, SiteLevel) {
        var SrchTxtId = SiteLevel + "_Srch_Topo_Histo_" + TopoCode + "_" + TopoName;
        var input = $('[id="' + SrchTxtId + '"]').val().toLowerCase();
        var filteredList = SrchHistoList.filter(function (item) {
            var FiltExists = ICDOHistoList.filter(function (e) {
                if (TopoCode == e.TOPOCODE && TopoName == e.TOPODESC && SiteLevel == e.SITELEVEL) {
                    if (e.HCODE && e.HDESC) {
                        return e.HCODE.trim() == item.Value.trim() && e.HDESC.trim() == item.Text.trim();
                    }
                    return false;
                }
                return false;
            });
            if (FiltExists.length == 0) {
                return item.Value.toLowerCase().includes(input) || item.Text.toLowerCase().includes(input);
            }
        });
        BindSrchHistoList(filteredList, TopoCode, TopoName, TopoType, SiteLevel);
    }
    //Added By Abhishesh || 20260316
    function SearchTopoGraphyscroll() {
        var container = $('#Search_Topo_Content_1').children().last()[0];
        if (container) {
            container.scrollIntoView({ behavior: "smooth", block: "start" });
        }
    }
    //End
    //Bind Search Histology in List
    function BindSrchHistoList(lst, TopoCode, TopoName, TopoType, SiteLevel) {
        var HistSrchListId = SiteLevel + "_Srch_Topo_Histo_List_" + TopoCode + "_" + TopoName;
        var container = document.getElementById(HistSrchListId);
        container.innerHTML = "";
        if (lst.length === 0) {
            container.innerHTML = "<div style='font-size: 14px;padding: 5px;'>No results found.</div>";
            container.style.display = "block";
            return;
        }
        lst.forEach(function (item) {
            var div = document.createElement('div');
            div.textContent = item.Value + " - " + item.Text;
            div.className = "SearchListItem " + (item.Type == "P" ? "PrimaryClass" : "");
            div.onclick = function () {
                BindHistologyTbl(TopoCode, TopoName, item.Value, item.Text, SiteLevel, item.GradeType);
                AddRemoveHisto("A", TopoCode, TopoName, item.Value, item.Text, SiteLevel, item.Type, TopoType);
            };
            container.appendChild(div);
        });
        container.style.display = "block";
    }
    //Bind Selected Histology
    function BindHistologyTbl(TopoCode, TopoName, HistoCode, HistoName, SiteLevel, HistoGradeType) {
        var FiltGrade = GradeOptList.filter(function (e) { return e.GradeType.toString().trim() == HistoGradeType; });
        var GradeOpt = GetGradeString(FiltGrade);
        var TblBodyId = SiteLevel + "_Hist_Tbl_Body_" + TopoCode + "_" + TopoName;
        var TrId = SiteLevel + "_TR_Histo_" + TopoCode + "_" + TopoName + "_" + HistoCode;
        var GradeId = SiteLevel + "_CmbGrade_" + TopoCode + "_" + TopoName + "_" + HistoCode;
        var GenCodeLblId = SiteLevel + "_GenCode_" + TopoCode + "_" + TopoName + "_" + HistoCode;
        var hide = SessionCompDiag != "Y" ? "d-none" : "";
        var ActTd = '<td style="text-align: center;"><i class="fa fa-trash DelHisto ' + hide+'" aria-hidden="true" onclick=\'RemoveHistology("{TOPOCODE}","{TOPONAME}","{HCODE}","{SITELEVEL}")\'></i></td>';
        var GenCodeTd = '<td style="padding: 0px;"><label id="{GENCODEID}">' + (TopoCode.trim() + HistoCode.trim()) + '</label></td>';
        var CodeTd = '<td style="text-align: center;padding: 0px;">' + HistoCode + '</td>';
        var DescTd = '<td style="padding: 0px;padding-left: 5px;">' + HistoName + '</td>';
        var GradeTd = '<td style="padding: 0px;"><select id="' + GradeId + '" class="form-control" style="padding: 0px;" onchange=\'ChangeGrade("{TOPOCODE}","{TOPONAME}","{HCODE}","{SITELEVEL}")\' >{GRADEOPT}</select></td>';
        var RplActTd = ActTd.replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{HCODE}", HistoCode).replace("{SITELEVEL}", SiteLevel);
        var RplGenCodeTd = GenCodeTd.replace("{GENCODEID}", GenCodeLblId);
        var RplGradeTd = GradeTd.replace("{TOPOCODE}", TopoCode).replace("{TOPONAME}", TopoName).replace("{HCODE}", HistoCode).replace("{GRADEOPT}", GradeOpt).replace("{SITELEVEL}", SiteLevel);
        var AllTd = RplActTd + RplGenCodeTd + CodeTd + DescTd + RplGradeTd;
        var TR = "<tr id='" + TrId + "'>" + AllTd + "</tr>";
        $('[id="' + TblBodyId + '"]').append(TR);
    }
    //Update List While Change the Grade
    function ChangeGrade(TopoCode, TopoName, HistoCode, SiteLevel) {
        var GradeId = SiteLevel + "_CmbGrade_" + TopoCode + "_" + TopoName + "_" + HistoCode;
        jQuery.grep(ICDOHistoList, function (e) {
            if (e.SITELEVEL == SiteLevel && e.TOPOCODE == TopoCode && e.TOPODESC == TopoName && e.HCODE == HistoCode) {
                e.HGRADE = $('[id="' + GradeId + '"]').val() == null ? "" : $('[id="' + GradeId + '"]').val();
                var GenCodeLblId = SiteLevel + "_GenCode_" + TopoCode + "_" + TopoName + "_" + HistoCode;
                document.getElementById(GenCodeLblId).innerText = (TopoCode.trim() + HistoCode.trim() + " " + e.HGRADE.trim());
            }

        });
        bindFinalDiagnosis();
    }
    function bindFinalDiagnosis() {
        if (!ICDOHistoList || ICDOHistoList.length === 0) return;

        let maxGrade = -Infinity;
        let checkboxToCheck = null;

        // Single loop to find the item with the largest HGRADE
        ICDOHistoList.forEach(function (item) {
            var grade = parseInt(item.HGRADE, 10);
            if (isNaN(grade)) return;
            if (grade > maxGrade) {
                maxGrade = grade;
                checkboxToCheck = '#' + CSS.escape(item.SITELEVEL + '_FINALCHK_' + item.TOPOCODE + '_' + item.TOPODESC);
            }
        });

        if (checkboxToCheck) {
            $('input[type="checkbox"][id*="_FINALCHK_"]').prop('checked', false);//for Uncheck All the Checkbox
            $(checkboxToCheck).prop('checked', true).trigger('change');
        }
    }
    //Remove Histology
    function RemoveHistology(TopoCode, TopoName, HistoCode, SiteLevel) {
        var RowId = SiteLevel + "_TR_Histo_" + TopoCode + "_" + TopoName + "_" + HistoCode;
        var elem = document.getElementById(RowId);
        if (elem) {
            elem.remove();
        }
        AddRemoveHisto("R", TopoCode, TopoName, HistoCode, "", SiteLevel, "", "");
    }
    //Add or Remove Histology From the Array
    function AddRemoveHisto(Type, TopoCode, TopoName, HistoCode, HistoName, SiteLevel, HType, TopoType) {
        if (Type == "A") {
            var NewD = {
                SITELEVEL: SiteLevel,
                TOPOCODE: TopoCode,
                TOPODESC: TopoName,
                TOPOTYPE: TopoType,
                HCODE: HistoCode,
                HDESC: HistoName,
                HGRADE: "",
                HTYPE: HType
            }
            ICDOHistoList.push(NewD);
        }
        else {
            var TempD = ICDOHistoList.filter(function (e) { return e.SITELEVEL.toString().trim() != SiteLevel || e.TOPOCODE.toString().trim() != TopoCode || e.TOPODESC.toString().trim() != TopoName || e.HCODE.toString().trim() != HistoCode; });
            ICDOHistoList = JSON.parse(JSON.stringify(TempD));
        }
    }

     function ValidationForICDODiagonsis() { 

        if ($("#RbtnCancerY").prop("checked")) {
            if (!ICDOTopoList || ICDOTopoList.length < 1) {
                ToastMsg("Please enter at least one Topography record.", "warning");
                return false;
            }
        }
        const isSameData = BindDataTopoList.every((item, index) => {
            const icdoItem = ICDOTopoList[index] || {};
            return Object.keys(item).every(key => {
                let val1 = item[key] ?? "";
                let val2 = icdoItem[key] ?? "";
                if (key === "FINALDIAGYN") {
                    val1 = val1 === true || val1 === "Y";
                    val2 = val2 === true || val2 === "Y";
                }
                if (key === "M" || key === "N" || key === "STAGE" || key === "T") { //priyanka 24/06/2026
                    val1 = val1 === "NA" || val1 === "";
                    val2 = val2 === "NA" || val2 === "";
                }
                return val1 === val2;
            });
        });
         return true;
        //end
        //const isRemarkEmpty = $("#ICDORemark").val().trim() === "";
        //if (EditICDOFlag == true) {
        //    if (isSameData && isRemarkEmpty) {
        //        return true;
        //    }
        //    else if (isRemarkEmpty && !isSameData) {
        //        $("#ICDORemark").focus();
        //        ToastMsg("Please Enter Remark For ICDO-Diagnosis.", "warning");
        //        return false;
        //    }
        //    else {
        //        return true;
        //    }
        //}
        //else {
        //    return true;
        //}
    }

    function EnDisCancer() {
        if ($("#RbtnCancerY").prop("checked") == true) {
            $("#CancerOptDiv *").removeAttr("disabled");
            $("#Advice_TreatmentAdviceDiv").show();
            $("#CancerOptMainDiv").remove();
            $("#SITE_1").show();
            $("#CancerOptMainDiv").show();
        } else {
            $("#Advice_TreatmentAdviceDiv").hide();
            $("#CancerOptDiv *").attr("disabled", "disabled");
            $("#RbtnTreatAdvTypeR, #RbtnTreatAdvTypeM, #RbtnTreatAdvTypeP").prop("checked", false);
            $("#CancerOptMainDiv, #SITE_1").hide();
            $("#ICDORemark").val('');
            $("#Search_Topo_Content_1, #Search_Topo_Content_2").empty();
            $("#SrchICDOTopography_1, #SrchICDOTopography_2").val('');
        }
    }

    function SaveICDODiagnosis(DataSaveObj) {
        var CancerYN = $("#RbtnCancerY").prop("checked") == true ? "Y" : "N";
        if (ICDOTopoList.length > 0) {
            jQuery.grep(ICDOTopoList, function (e) {
                e.REMARKS = $("#ICDORemark").val();
            });
            $.each(ICDOTopoList, function (_, item) {
                $.each(item, function (key, value) {
                    if (value == null) {
                        item[key] = "";
                    }
                });
            });
        }
        DataSaveObj.StrICDODiagnosis = JSON.stringify(ICDOTopoList);
        DataSaveObj.StrICDHDiagnosis = JSON.stringify(ICDOHistoList);

        if (sessionStorage.getItem("MODULE_FLAG") != "IPD") {
            DataSaveObj.CancerCaseYN = CancerYN;
            DataSaveObj.RadiationOncoYN = $("#RbtnTreatAdvTypeR").prop("checked") == true ? "Y" : "N"
            DataSaveObj.MedcialOncoYN = $("#RbtnTreatAdvTypeM").prop("checked") == true ? "Y" : "N"
            DataSaveObj.PalliativeCareYN = $("#RbtnTreatAdvTypeP").prop("checked") == true ? "Y" : "N"
        }
    }

</script>

<%-- TNM Info Style --%>
<style>
    .custom-table {
        width: 100%;
        border-collapse: collapse;
        font-family: Arial, sans-serif;
        font-size: 14px;
        background-color: #fff;
        margin: 0px;
    }

        .custom-table thead {
            position: sticky;
            top: 0;
        }

            .custom-table thead td {
                text-align: center;
                background-color: #95cf9b;
                color: white;
                font-weight: bold;
                padding: 10px;
                border-bottom: 2px solid #ddd;
            }

        .custom-table tbody td {
            padding: 10px;
            border-bottom: 1px solid #eee;
            color: #333;
        }

        .custom-table tr:hover {
            background-color: #f9f9f9;
        }

    .custom-scroll-container {
        max-height: 300px;
        overflow-y: auto;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .FirstTDClass {
        width: 60px;
    }

    .TNMHeaderDiv {
        background-color: #3b5998;
        color: white;
        padding: 5px 5px;
        font-size: 15px;
        width: 100%;
    }

    .DownUpTopoIcon {
        font-size: 20px;
        padding: 0px 10px;
        cursor: pointer;
    }
</style>

<%-- TNM --%>
<script type="text/javascript">
    var AllStageList = [];
    var AllDescList = [];

    function LoadNewTNM(SiteLevel, TopoCode, TopoName) {
        var TopoId = TopoCode + "_" + TopoName;
        ClearTNMFields(SiteLevel, TopoId);
        GetSiteList(SiteLevel, TopoId, TopoName);
        DisableTNM(SiteLevel, TopoId);
        UpdateTNM(SiteLevel, TopoCode, TopoName);
    }

    function GetSiteList(SiteLevel, TopoCode, TopoName) {
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetSiteSubSiteList",
            data: {},
            async: false,
            success: function (response) {
                BindComboList((SiteLevel + '_CmbSiteList_' + TopoCode), response, "Value", "Text");
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(errorThrown, "error");
            }
        });
    }

    function GetSubSiteList(TopoCode, TopoName, SiteLevel) {
        if ($('[id="' + (SiteLevel + "_CmbSiteList_" + TopoCode + "_" + TopoName) + '"]').val() != "") {
            var DataToSend = {
                SiteCd: $('[id="' + (SiteLevel + "_CmbSiteList_" + TopoCode + "_" + TopoName) + '"]').val()
            }
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetSiteSubSiteList",
                data: DataToSend,
                async: false,
                success: function (response) {
                    BindComboList((SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName), response, "Value", "Text");
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(errorThrown, "error");
                }
            });
        }
        else {
            BindComboList((SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName), [], "");
        }
        DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        UpdateTNM(SiteLevel, TopoCode, TopoName);
        BindDescriptionList(TopoCode, TopoName, SiteLevel);
        $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoCode + "_" + TopoName + '"]').empty();
    }

    function ClearTNMFields(SiteLevel, TopoId) {
        BindComboList((SiteLevel + '_CmbSiteList_' + TopoId), [], "", "");
        BindComboList((SiteLevel + '_CmbSubSiteList_' + TopoId), [], "", "");
        BindComboList((SiteLevel + '_ICDTList_' + TopoId), [], "", "");
        BindComboList((SiteLevel + '_ICDNList_' + TopoId), [], "", "");
        BindComboList((SiteLevel + '_ICDMList_' + TopoId), [], "", "");
        BindComboList((SiteLevel + '_CmbStageList_' + TopoId), [], "", "");
        DisableTNM(SiteLevel, TopoId);
    }

    function DisableTNM(SiteLevel, TopoId) {
        var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoId + '"]').val();
        var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoId + '"]').val();
        var Prefix = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').val();
        var t = $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').val();
        var n = $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').val();
        var m = $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').val();
        if (site == "" || subsite == "") {
            $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
            BindComboList(SiteLevel + '_CmbPrefixList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_ICDTList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_ICDNList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
        }
        else if (Prefix == "") {
            $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
            BindComboList(SiteLevel + '_ICDTList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_ICDNList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
        }
        else if (TNMNotFilter == "Y") {
            $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", false);
        }
        else if (t == "") {
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
            BindComboList(SiteLevel + '_ICDNList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
        } else if (n == "") {
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
            BindComboList(SiteLevel + '_ICDMList_' + TopoId, [], "", "");
            BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
        } else if (m == "") {
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
            BindComboList(SiteLevel + '_CmbStageList_' + TopoId, [], "", "");
            $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
        } else {
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", false);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", false);
        }

        if (Prefix == "NA" || t == "NA" || n == "NA" || m == "NA") {
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
        }

    }

    function FilterPrefixList(TopoCode, TopoName, SiteLevel) {
        if (TNMNotFilter != "Y") {
            var FilterLst = [];
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            if (site != "" && subsite != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() === site &&
                        e.SUBSITE.toString().trim() === subsite &&
                        !uniqueMap.has(e.PC)
                    ) {
                        uniqueMap.set(e.PC, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());
            }
            BindComboList(SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName, FilterLst, "PC", "PC");
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        }
        else {
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        }
        UpdateTNM(SiteLevel, TopoCode, TopoName);
    }

    function GetTNMList(TopoCode, TopoName, SiteLevel) {
        var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var FlagSetDef = false;
        if (site != "" && subsite != "") {
            var FilterDT = AllStageList.filter(function (a) { return a.SITE.toString().trim() == site && a.SUBSITE.toString().trim() == subsite; });
            if (FilterDT.length == 0) {
                var DataToSend = {
                    SiteCode: site,
                    SubSiteCode: subsite
                }
                $.ajax({
                    type: "POST",
                    url: "../DoctorDesk/GetStagingList",
                    data: DataToSend,
                    async: false,
                    success: function (response) {
                        if (response[0] != null && response[0].length > 0) {
                            AllStageList = AllStageList.concat(response[0]);
                        }
                        else {
                            FlagSetDef = true;
                        }
                        if (response[1] != null) {
                            AllDescList = AllDescList.concat(response[1]);
                        }
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                        ToastMsg(errorThrown, "error");
                    }
                });
            } else {
                BindComboList(SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName, [], "", "");
                BindComboList(SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName, [], "", "");
                BindComboList(SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName, [], "", "");
                BindComboList(SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName, [], "", "");
                BindComboList(SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName, [], "", "");
            }
        }
        UpdateTNM(SiteLevel, TopoCode, TopoName);
        if (FlagSetDef)
            SetDataForDefTNM(TopoCode, TopoName, SiteLevel);
        else
            FilterPrefixList(TopoCode, TopoName, SiteLevel)
    }

    function SetDataForDefTNM(TopoCode, TopoName, SiteLevel) {
        var TopoId = TopoCode + "_" + TopoName;
        var CmbPrefixList = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]');
        if (CmbPrefixList.find("option").length === 0) {
            BindComboList(SiteLevel + '_CmbPrefixList_' + TopoId, EmptyLst, "Value", "Value");
            $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').val(EmptyLst[0].Value);
        }
        var ICDTList = $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]');
        if (ICDTList.find("option").length === 0) {
            BindComboList(SiteLevel + '_ICDTList_' + TopoId, EmptyLst, "Value", "Value");
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').val(EmptyLst[0].Value);
        }
        var ICDNList = $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]');
        if (ICDNList.find("option").length === 0) {
            BindComboList(SiteLevel + '_ICDNList_' + TopoId, EmptyLst, "Value", "Value");
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').val(EmptyLst[0].Value);
        }
        var ICDMList = $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]');
        if (ICDMList.find("option").length === 0) {
            BindComboList(SiteLevel + '_ICDMList_' + TopoId, EmptyLst, "Value", "Value");
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').val(EmptyLst[0].Value);
        }
        var CmbStageList = $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]');
        if (CmbStageList.find("option").length === 0) {
            BindComboList(SiteLevel + '_CmbStageList_' + TopoId, EmptyLst, "Value", "Value");
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
            $('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').val(EmptyLst[0].Value);
        }
        $('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
        UpdateTNM(SiteLevel, TopoCode, TopoName);

        //BindComboList(SiteLevel + '_CmbPrefixList_' + TopoId, EmptyLst, "Value", "Value");
        //BindComboList(SiteLevel + '_ICDTList_' + TopoId, EmptyLst, "Value", "Value");
        //BindComboList(SiteLevel + '_ICDNList_' + TopoId, EmptyLst, "Value", "Value");
        //BindComboList(SiteLevel + '_ICDMList_' + TopoId, EmptyLst, "Value", "Value");
        //BindComboList(SiteLevel + '_CmbStageList_' + TopoId, EmptyLst, "Value", "Value");
        //$('[id="' + SiteLevel + '_OTHRDIVID_' + TopoId + '"]').empty();
        //UpdateTNM(SiteLevel, TopoCode, TopoName);
        //$('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').prop("disabled", true);
        //$('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').prop("disabled", true);
        //$('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').prop("disabled", true);
        //$('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').prop("disabled", true);
        //$('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').prop("disabled", true);
        //$('[id="' + SiteLevel + '_CmbPrefixList_' + TopoId + '"]').val(EmptyLst[0].Value);
        //$('[id="' + SiteLevel + '_ICDTList_' + TopoId + '"]').val(EmptyLst[0].Value);
        //$('[id="' + SiteLevel + '_ICDNList_' + TopoId + '"]').val(EmptyLst[0].Value);
        //$('[id="' + SiteLevel + '_ICDMList_' + TopoId + '"]').val(EmptyLst[0].Value);
        //$('[id="' + SiteLevel + '_CmbStageList_' + TopoId + '"]').val(EmptyLst[0].Value);
    }

    function FilterTList(TopoCode, TopoName, SiteLevel) {
        if (TNMNotFilter != "Y") {
            var FilterLst = [];
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            if (site != "" && subsite != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() === site &&
                        e.SUBSITE.toString().trim() === subsite &&
                        !uniqueMap.has(e.T)
                    ) {
                        uniqueMap.set(e.T, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());
            }
            var FList = FilterLst;
            if (DefValueYN == "Y") {
                jQuery.grep(DefTListOption, function (e) {
                    var FilterDefT = FilterLst.filter(function (a) { return a.T.toString().trim() == e.T.toString().trim(); });
                    if (FilterDefT.length == 0) {
                        FList.push(e);
                    }
                });
            }
            FList.sort(function (a, b) {
                return a.T.toString().trim().localeCompare(
                    b.T.toString().trim()
                );
            });
            BindComboList(SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName, FList, "T", "T");
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        }
        else {
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        }
        UpdateTNM(SiteLevel, TopoCode, TopoName);
        BindDescriptionList(TopoCode, TopoName, SiteLevel);
    }

    function FilterNList(TopoCode, TopoName, SiteLevel) {
        if (TNMNotFilter != "Y") {
            var FilterLst = [];
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var t = "" + $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
            if (site != "" && subsite != "" && t != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.T.toString().trim() == t &&
                        !uniqueMap.has(e.N)
                    ) {
                        uniqueMap.set(e.N, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());
            }
            var FList = FilterLst;
            if (DefValueYN == "Y") {
                jQuery.grep(DefNListOption, function (e) {
                    var FilterDefN = FilterLst.filter(function (a) { return a.N.toString().trim() == e.N.toString().trim(); });
                    if (FilterDefN.length == 0) {
                        FList.push(e);
                    }
                });
            }
            FList.sort(function (a, b) {
                return a.N.toString().trim().localeCompare(
                    b.N.toString().trim()
                );
            });
            if (FList.length == 0)
                SetDataForDefTNM(TopoCode, TopoName, SiteLevel);
            else
                BindComboList(SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName, FList, "N", "N");
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            if (DefTListOption.filter(function (a) { return a.T.toString().trim() == t.toString().trim(); }).length > 0)
                FilterStageList(TopoCode, TopoName, SiteLevel)
        }
        else {
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        }
        UpdateTNM(SiteLevel, TopoCode, TopoName);
    }

    function FilterMList(TopoCode, TopoName, SiteLevel) {
        if (TNMNotFilter != "Y") {
            var FilterLst = [];
            var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
            var t = "" + $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
            var n = "" + $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
            if (site != "" && subsite != "" && t != "" && n != "") {
                let uniqueMap = new Map();
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.T.toString().trim() == t &&
                        e.N.toString().trim() == n &&
                        !uniqueMap.has(e.M)
                    ) {
                        uniqueMap.set(e.M, e);
                    }
                });
                FilterLst = Array.from(uniqueMap.values());
            }
            var FList = FilterLst;
            if (DefValueYN == "Y") {
                jQuery.grep(DefMListOption, function (e) {
                    var FilterDefM = FilterLst.filter(function (a) { return a.M.toString().trim() == e.M.toString().trim(); });
                    if (FilterDefM.length == 0) {
                        FList.push(e);
                    }
                });
            }
            FList.sort(function (a, b) {
                return a.M.toString().trim().localeCompare(
                    b.M.toString().trim()
                );
            });
            if (FList.length == 0)
                SetDataForDefTNM(TopoCode, TopoName, SiteLevel);
            else
                BindComboList(SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName, FList, "M", "M");
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
            if (DefNListOption.filter(function (a) { return a.N.toString().trim() == n.toString().trim(); }).length > 0)
                FilterStageList(TopoCode, TopoName, SiteLevel)
        }
        else {
            DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        }
        UpdateTNM(SiteLevel, TopoCode, TopoName);
    }

    function BindOtherDivContent(Label, Id, TopoCd, TopoNM, SiteLvl, Lst, MainDivId, PropID, CenterStyle) {
        var ODiv = '<div class="TMNDiv col-xs-12 col-md-6 col-lg-3"><label ' + CenterStyle + ' class="TMNLabel">{OTHRLABEL}</label><select id="{OTHRCMBID}" onchange=\'FilterStageList("{TOPOCODE}","{TOPONAME}","{SITELEVEL}")\' class="form-control"></select></div>';
        var RplODiv = ODiv.replace("{OTHRLABEL}", Label).replace("{OTHRCMBID}", Id).replace("{TOPOCODE}", TopoCd).replace("{TOPONAME}", TopoNM).replace("{SITELEVEL}", SiteLvl);
        $('[id="' + Id + '"]').remove();
        $('[id="' + MainDivId + '"]').append(RplODiv);
        if (Lst.length == 0)
            SetDataForDefTNM(TopoCode, TopoName, SiteLevel);
        else
            BindComboList(SiteLvl + '_' + PropID + '_' + TopoCd + "_" + TopoNM, Lst, PropID, PropID);
    }

    function FilterOthrList(TopoCode, TopoName, SiteLevel) {
        var TopoId = TopoCode + "_" + TopoName;
        var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var prefix = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
        var t = $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
        var n = $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
        var m = $('[id="' + SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName + '"]').val();
        var FilterLst = AllStageList.filter(function (a) {
            return a.SITE.toString().trim() == site && a.SUBSITE.toString().trim() == subsite && a.PC.toString().trim() == prefix
                && a.T.toString().trim() == t && a.N.toString().trim() == n && a.M.toString().trim() == m;
        });
        var MainDID = SiteLevel + '_OTHRDIVID_' + TopoCode + "_" + TopoName;
        $('[id="' + MainDID + '"]').empty();
        if (FilterLst.length > 0) {
            jQuery.grep(OtherFieldList, function (I) {
                var uniqueMap = new Map();
                FilterLst.forEach(function (e) {
                    if (e[I.ID].toString().trim() != "" && e[I.ID].toString().trim() != "-" && !uniqueMap.has(e[I.ID])) {
                        uniqueMap.set(e[I.ID], e);
                    }
                });
                var FiltLst = Array.from(uniqueMap.values());
                if (FiltLst.length > 0) {
                    var CMBID = SiteLevel + '_' + I.ID + '_' + TopoId;
                    var StyleCode = "";// I.CenterStyle == "N" ? 'style="text-align: justify;"' : 'style="text-align: center;"';
                    BindOtherDivContent(I.LABEL, CMBID, TopoCode, TopoName, SiteLevel, FiltLst, MainDID, I.ID, StyleCode);
                }
            });
        }
        DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        FilterStageList(TopoCode, TopoName, SiteLevel);
        UpdateTNM(SiteLevel, TopoCode, TopoName);
    }

    function FilterStageList(TopoCode, TopoName, SiteLevel, FlagN) {
        var FilterLst = [];
        var AllFilterLst = [];
        var site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var subsite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var prefix = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
        var t = $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
        var n = $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
        var m = $('[id="' + SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName + '"]').val();
        var Geographic = $('[id="' + SiteLevel + '_GEOGRAPHIC_' + TopoCode + "_" + TopoName + '"]').val();
        var Location = $('[id="' + SiteLevel + '_LOCATION_' + TopoCode + "_" + TopoName + '"]').val();
        var Mitotic = $('[id="' + SiteLevel + '_MITOTIC_' + TopoCode + "_" + TopoName + '"]').val();
        var PSA = $('[id="' + SiteLevel + '_PSA_' + TopoCode + "_" + TopoName + '"]').val();
        var SerumMarkers = $('[id="' + SiteLevel + '_SERUMMARKERS_' + TopoCode + "_" + TopoName + '"]').val();
        var HeritableTrait = $('[id="' + SiteLevel + '_HERITABLETRAIT_' + TopoCode + "_" + TopoName + '"]').val();
        var HER2 = $('[id="' + SiteLevel + '_HER2_' + TopoCode + "_" + TopoName + '"]').val();
        var ER = $('[id="' + SiteLevel + '_ER_' + TopoCode + "_" + TopoName + '"]').val();
        var PR = $('[id="' + SiteLevel + '_PR_' + TopoCode + "_" + TopoName + '"]').val();
        var Bloodinvl = $('[id="' + SiteLevel + '_BLOODINVL_' + TopoCode + "_" + TopoName + '"]').val();
        var SVal = "";
        let uniqueMap = new Map();
        var FiltLst = [];
        if (site != "" && subsite != "" && prefix != "" && t != "" && n != "" && m != "") {
            if (TNMNotFilter != "Y") {
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.PC.toString().trim() == prefix &&
                        e.T.toString().trim() == t &&
                        e.N.toString().trim() == n &&
                        e.M.toString().trim() == m &&
                        !uniqueMap.has(e.STAGE)
                    ) {
                        uniqueMap.set(e.STAGE, e);
                    }
                    if (e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.PC.toString().trim() == prefix &&
                        e.T.toString().trim() == t &&
                        e.N.toString().trim() == n &&
                        e.M.toString().trim() == m)
                        FiltLst.push(e);
                });
                //FilterLst = Array.from(uniqueMap.values());
                FilterLst = FiltLst;
                AllFilterLst = Array.from(uniqueMap.values());
            }
            else {
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.PC.toString().trim() == prefix &&
                        !uniqueMap.has(e.STAGE)
                    ) {
                        uniqueMap.set(e.STAGE, e);
                    }
                    if (
                        e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.PC.toString().trim() == prefix
                    )
                        FiltLst.push(e);
                });
            }
            //FilterLst = Array.from(uniqueMap.values());
            FilterLst = FiltLst;
            AllFilterLst = Array.from(uniqueMap.values());
        }
        else {
            if (TNMNotFilter == "Y") {
                AllStageList.forEach(function (e) {
                    if (
                        e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.PC.toString().trim() == prefix &&
                        !uniqueMap.has(e.STAGE)
                    ) {
                        uniqueMap.set(e.STAGE, e);
                    }
                    if (
                        e.SITE.toString().trim() == site &&
                        e.SUBSITE.toString().trim() == subsite &&
                        e.PC.toString().trim() == prefix
                    )
                        FiltLst.push(e);
                });
                //FilterLst = Array.from(uniqueMap.values());
                FilterLst = FiltLst;
                AllFilterLst = Array.from(uniqueMap.values());
            }
        }
        var FRows = FilterLst.filter(function (a) {
            return (Geographic == undefined || Geographic == "" || Geographic == "-" || a.GEOGRAPHIC.toString().trim() == Geographic)
                && (Location == undefined || Location == "" || Location == "-" || a.LOCATION.toString().trim() == Location)
                && (Mitotic == undefined || Mitotic == "" || Mitotic == "-" || a.MITOTIC.toString().trim() == Mitotic)
                && (PSA == undefined || PSA == "" || PSA == "-" || a.PSA.toString().trim() == PSA)
                && (SerumMarkers == undefined || SerumMarkers == "" || SerumMarkers == "-" || a.SERUMMARKERS.toString().trim() == SerumMarkers)
                && (HeritableTrait == undefined || HeritableTrait == "" || HeritableTrait == "-" || a.HERITABLETRAIT.toString().trim() == HeritableTrait)
                && (HER2 == undefined || HER2 == "" || HER2 == "-" || a.HER2.toString().trim() == HER2)
                && (ER == undefined || ER == "" || ER == "-" || a.ER.toString().trim() == ER)
                && (PR == undefined || PR == "" || PR == "-" || a.PR.toString().trim() == PR)
                && (Bloodinvl == undefined || Bloodinvl == "" || Bloodinvl == "-" || a.BLOODINVL.toString().trim() == Bloodinvl);
        });
        var Flag = false;
        if (FRows.length == 1) {
            SVal = FRows[0].STAGE;
        }
        else if (FRows.length == 0) {
            FRows = AllFilterLst;
            //var DefOpt = {
            //    STAGE: "Cannot be Assessed",
            //    CODE: "-"
            //}
            //Flag = true;
            //FilterLst.push(DefOpt);
            //SVal = FilterLst[0].CODE;
        }
        else if (FRows.length != AllFilterLst.length) {
            let uniqueRMap = new Map();
            FRows.forEach(function (e) {
                if (
                    !uniqueRMap.has(e.STAGE)) {
                    uniqueRMap.set(e.STAGE, e);
                }
            });
            FRows = Array.from(uniqueRMap.values());
        }
        else {
            FRows = AllFilterLst;
        }
        DisableTNM(SiteLevel, TopoCode + "_" + TopoName);
        if (TNMNotFilter != "Y") {
            if (FRows.length == 0)
                SetDataForDefTNM(TopoCode, TopoName, SiteLevel);
            else {
                BindComboList(SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName, FRows, (Flag == true ? "CODE" : "STAGE"), "STAGE");
                $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val(SVal);
            }
        }
        else {
            if (FlagN == "Y") {
                if (FRows.length == 0)
                    SetDataForDefTNM(TopoCode, TopoName, SiteLevel);
                else {
                    BindComboList(SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName, FRows, (Flag == true ? "CODE" : "STAGE"), "STAGE");
                    $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val(SVal);
                }
            }
        }

        UpdateTNM(SiteLevel, TopoCode, TopoName);
    }

    function BindComboList(ComboId, ListData, PropVal, PropText) {
        $('[id="' + ComboId + '"]').empty();
        var Option = '<option value="{VALUE}">{TEXT}</option>';
        var DefSel = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
        $('[id="' + ComboId + '"]').append(DefSel);
        jQuery.grep(ListData, function (e) {
            var Options = Option.replace("{VALUE}", e[PropVal]).replace("{TEXT}", e[PropText]);
            $('[id="' + ComboId + '"]').append(Options);
        });
        $('[id="' + ComboId + '"]').val("");
    }

    function BindDescriptionList(TopoCode, TopoName, SiteLevel) {
        var TNMHeaderLblId = SiteLevel + "_TNM_HEADER_LBL_" + TopoCode + "_" + TopoName;
        var TBodyId = SiteLevel + "_TTBody_" + TopoCode + "_" + TopoName;
        var NBodyId = SiteLevel + "_NTBody_" + TopoCode + "_" + TopoName;
        var MBodyId = SiteLevel + "_MTBody_" + TopoCode + "_" + TopoName;
        $('[id="' + TBodyId + '"]').empty();
        $('[id="' + NBodyId + '"]').empty();
        $('[id="' + MBodyId + '"]').empty();
        var siteVal = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var subSiteVal = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var PrefixVal = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
        document.getElementById(TNMHeaderLblId).innerText = "";
        if (siteVal == "" || subSiteVal == "" || PrefixVal == "") {
            return false;
        }
        document.getElementById(TNMHeaderLblId).innerText = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"] option:selected').text() + " - " + $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"] option:selected').text();
        var FilterTListDesc = AllDescList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal && e.PC.toString().trim() == PrefixVal && e.TNM.toString().trim().includes("T"); });
        var FilterNListDesc = AllDescList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal && e.PC.toString().trim() == PrefixVal && e.TNM.toString().trim().includes("N"); });
        var FilterMListDesc = AllDescList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal && e.PC.toString().trim() == PrefixVal && e.TNM.toString().trim().includes("M"); });
        var TR = "<tr>{TRCONTENT}</tr>";
        var TD = "<td {CLASS}>{TDCONTENT}</td>";
        jQuery.grep(FilterTListDesc, function (e) {
            var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
            var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim()).replace("{CLASS}", "");
            var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
            $('[id="' + TBodyId + '"]').append(RplTR);
        });
        jQuery.grep(FilterNListDesc, function (e) {
            var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
            var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim()).replace("{CLASS}", "");
            var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
            $('[id="' + NBodyId + '"]').append(RplTR);
        });
        jQuery.grep(FilterMListDesc, function (e) {
            var TNMName = TD.replace("{TDCONTENT}", e.TNM.toString().trim()).replace("{CLASS}", "class='FirstTDClass'");
            var Desc = TD.replace("{TDCONTENT}", e.DESCRIPTION.toString().trim()).replace("{CLASS}", "");
            var RplTR = TR.replace("{TRCONTENT}", (TNMName + Desc));
            $('[id="' + MBodyId + '"]').append(RplTR);
        });
        var P = SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName;
        var t = SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName;
        var n = SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName;
        var m = SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName;
        var Stage = SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName;
        if (TNMNotFilter == "Y") {
            var FilterPrefix = AllStageList.filter(function (e) { return e.SITE.toString().trim() == siteVal && e.SUBSITE.toString().trim() == subSiteVal; });
            BindComboList(P, FilterPrefix, "PC", "PC");
            BindComboList(t, FilterTListDesc, "TNM", "TNM");
            BindComboList(n, FilterNListDesc, "TNM", "TNM");
            BindComboList(m, FilterMListDesc, "TNM", "TNM");
            FilterStageList(TopoCode, TopoName, SiteLevel, "Y");
        }
    }

    function AppendListToCombo(ComboId, ListData) {
        var Option = '<option value="{VALUE}">{TEXT}</option>';
        var DefSel = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
        $('[id="' + ComboId + '"]').append(DefSel);
        jQuery.grep(ListData, function (e) {
            var Options = Option.replace("{VALUE}", e.Value).replace("{TEXT}", e.Text);
            $('[id="' + ComboId + '"]').append(Options);
        });
    }

    function ValidationTNM(MsgYN, TopoCode, TopoName, SiteLevel) {
        var Site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var SubSite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var Stage = $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val();

        if (Site != "") {
            if (SubSite == "") {
                $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').focus().css("border-color", "red");
                return false;
            }
            if (Stage == "") {
                if (MsgYN == "Y")
                    ToastMsg("Please Select T , N , M.", "info");
                return false;
            }
        }
        return true;
    }

    function UpdateTNM(SiteLevel, TopoCode, TopoName) {
        var Site = $('[id="' + SiteLevel + '_CmbSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        var SubSite = $('[id="' + SiteLevel + '_CmbSubSiteList_' + TopoCode + "_" + TopoName + '"]').val();
        //Added By Roshan 17/2/2026
         var Recurrent = $('[id="' + SiteLevel + '_Chk_ReOccur_' + TopoCode + "_" + TopoName + '"]').is(':checked');/*$('input[name="' + SiteLevel + "_RadioName_" + TopoCode + "_" + TopoName + '"]:checked').val();*/
 var Adjuvant = $('[id="' + SiteLevel + '_Chk_Adjuvant_' + TopoCode + "_" + TopoName + '"]').is(':checked');/*$('input[name="' + SiteLevel + "_Radio_AdjuvantName_" + TopoCode + "_" + TopoName + '"]:checked').val();*/
        //End By Roshan 17/2/2026
var FinalDiagnosis = $('[id="' + SiteLevel + '_FINALCHK_' + TopoCode + "_" + TopoName + '"]').is(':checked');
        var T = $('[id="' + SiteLevel + '_ICDTList_' + TopoCode + "_" + TopoName + '"]').val();
        var N = $('[id="' + SiteLevel + '_ICDNList_' + TopoCode + "_" + TopoName + '"]').val();
        var M = $('[id="' + SiteLevel + '_ICDMList_' + TopoCode + "_" + TopoName + '"]').val();
        var Stage = $('[id="' + SiteLevel + '_CmbStageList_' + TopoCode + "_" + TopoName + '"]').val();
        var PrefixComboId = $('[id="' + SiteLevel + '_CmbPrefixList_' + TopoCode + "_" + TopoName + '"]').val();
        var Geographic = $('[id="' + SiteLevel + '_GEOGRAPHIC_' + TopoCode + "_" + TopoName + '"]').val();
        var Location = $('[id="' + SiteLevel + '_LOCATION_' + TopoCode + "_" + TopoName + '"]').val();
        var Mitotic = $('[id="' + SiteLevel + '_MITOTIC_' + TopoCode + "_" + TopoName + '"]').val();
        var PSA = $('[id="' + SiteLevel + '_PSA_' + TopoCode + "_" + TopoName + '"]').val();
        var SerumMarkers = $('[id="' + SiteLevel + '_SERUMMARKERS_' + TopoCode + "_" + TopoName + '"]').val();
        var HeritableTrait = $('[id="' + SiteLevel + '_HERITABLETRAIT_' + TopoCode + "_" + TopoName + '"]').val();
        var HER2 = $('[id="' + SiteLevel + '_HER2_' + TopoCode + "_" + TopoName + '"]').val();
        var ER = $('[id="' + SiteLevel + '_ER_' + TopoCode + "_" + TopoName + '"]').val();
        var PR = $('[id="' + SiteLevel + '_PR_' + TopoCode + "_" + TopoName + '"]').val();
        var Bloodinvl = $('[id="' + SiteLevel + '_BLOODINVL_' + TopoCode + "_" + TopoName + '"]').val();
        jQuery.grep(ICDOTopoList, function (e) {
            if (e.SITELEVEL == SiteLevel && e.TOPOCODE == TopoCode && e.TOPODESC == TopoName) {
                e.TNMSITECODE = Site;
                e.TNMSUBSITECODE = SubSite;
                e.RECCURENT = Recurrent == undefined || Recurrent == null ? "" : Recurrent == true ? "Y" : "N";//Added By Roshan 17/2/2025
                e.ADJUVANT = Adjuvant == undefined || Adjuvant == null ? "" : Adjuvant == true ? "Y" : "N";//Added By Roshan 17/2/2025
                e.TNMPREFIX = PrefixComboId == undefined || PrefixComboId == null ? "" : PrefixComboId;
                e.T = T;
                e.N = N;
                e.M = M;
                e.STAGE = Stage;
                e.GEOGRAPHIC = Geographic == undefined || Geographic == null ? "" : Geographic;
                e.LOCATION = Location == undefined || Location == null ? "" : Location;
                e.MITOTIC = Mitotic == undefined || Mitotic == null ? "" : Mitotic;
                e.PSA = PSA == undefined || PSA == null ? "" : PSA;
                e.SERUMMARKERS = SerumMarkers == undefined || SerumMarkers == null ? "" : SerumMarkers;
                e.HERITABLETRAIT = HeritableTrait == undefined || HeritableTrait == null ? "" : HeritableTrait;
                e.HER2 = HER2 == undefined || HER2 == null ? "" : HER2;
                e.ER = ER == undefined || ER == null ? "" : ER;
                e.PR = PR == undefined || PR == null ? "" : PR;
                e.BLOODINVL = Bloodinvl == undefined || Bloodinvl == null ? "" : Bloodinvl;
                e.FINALDIAGYN = FinalDiagnosis == undefined || FinalDiagnosis == null ? "": FinalDiagnosis == true ? "Y" : "N";//Added By Roshan 17/2/2026
            }
        });
    }

    function ToggleTNM(ToggleType, HideId, BodyId, ShowId) {
        document.getElementById(HideId).style.display = "none";
        document.getElementById(BodyId).style.display = ToggleType == "D" ? "table-row-group" : "none";
        document.getElementById(ShowId).style.display = "inline-block";
    }
</script>

<style>
    #TNMInfoPopup {
        display: none;
        position: fixed;
        z-index: 1050;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        background: white;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        width: 80%;
        max-width: 800px;
        padding: 20px;
        animation: fadeIn 0.3s ease-in-out;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translate(-50%, -45%);
        }

        to {
            opacity: 1;
            transform: translate(-50%, -50%);
        }
    }

    .TNMDescDiv {
        width: 100%;
    }

    .TNMHeadDiv {
        background-color: #005289;
        color: white;
        font-size: 16px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .TNMHeadLbl {
        margin: 0px;
        padding: 5px;
    }

    .TNMCloseIcon {
        color: white;
        padding-right: 5px;
        font-size: 25px;
        cursor: pointer;
    }

        .TNMCloseIcon:hover {
            color: red;
        }
</style>

<%-- ICD-O History --%>
<style>
     .ModelHeaderDiv {
     background-color: #003f74;
     color: white;
     display: flex;
     justify-content: space-between;
     align-items: center;
     padding: 5px 5px;
     font-size: 13px;
     position: sticky;
     top: 0;
     z-index: 10;
 }

 .ModelContentDiv {
     padding: 5px 0px;
 }

 .ModelLbl {
     margin: 0px;
     width: 100px;
     padding: 5px 0px 5px 10px;
 }

 .closeMdlBtn {
     cursor: pointer;
     font-weight: bold;
     font-size: 25px;
     width: 35px;
     height: 25px;
     position: relative;
     top: -5px;
     text-align: center;
 }
 table.tblpopupList {
     border-collapse: separate;
     border-spacing: 0;
     width: 100%;
     font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
     box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
     overflow: hidden;
     min-height: 30px;
 }

     table.tblpopupList thead {
         background: #314b81;
         color: white;
         font-size: 12px;
     }

     table.tblpopupList th {
         padding: 5px 15px;
         border: none;
         border: 1px solid #999999;
         text-align: center;
     }

     table.tblpopupList tbody tr {
         background-color: #f9f9f9;
         transition: background-color 0.3s;
     }

         table.tblpopupList tbody tr:nth-child(even) {
             background-color: #f1f1f1;
         }

         table.tblpopupList tbody tr:hover {
             background-color: #f1f1f1;
         }

         table.tblpopupList tbody td{
             padding:5px;
             border: 1px solid #d7d7d7;
         }
</style>


<script type="text/javascript">
    function OpenCloseICDOHistory() {
        GetICDOHist();
        document.getElementById("POPUPHISTOInfoModal").style.display = "flex";
        document.documentElement.style.overflow = 'hidden';
    }

    function GetICDOHist(type) {
        var HistList = [];
        var MODULE_FLAG = sessionStorage.getItem("MODULE_FLAG");
        var mrno = GetSessionMRNO();//MODULE_FLAG == "IPD" ? sessionStorage.getItem('IPPatMRNO') : sessionStorage.getItem('PatMRNO');
        var DataToSend = {
            MRNo: mrno,
            Type: type
        }
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetICDOHistoList",
            data: DataToSend,
            async: false,
            success: function (response) {
                if (response[0] != null) {
                    HistList = response
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
        return HistList;
    }

    function BindICDOHist(HistoryLst) {
        var AllHistoryContent = '<div class="history-list - wrapper"></div>';
        var FDiv = '<div class="SepMainHistory">{FINALCONTENT}</div>';
        var SepMainHeaderLbl = '<label class="SepMainHeaderLbl">Consultation No.: {CONSULTNO} </label>';
        var ArrowDiv = '<div><i class="fa fa-chevron-circle-down DownUpHistoryIcon" style="display:none" id="{DOWNARROWID}"  onclick=\'ToggleHistoryContent("D","{INDEX}")\' ></i><i id="{UPARROWID}" class="fa fa-chevron-circle-up DownUpHistoryIcon" onclick=\'ToggleHistoryContent("U","{INDEX}")\' ></i></div>';
        var HeaderDiv = '<div class="SepMainHeaderDiv">{HEADERDIVCONT}</div>';
        var ContentDiv = '<div class="SepMainContentDiv" id="{CONTENTDIVID}">{CONTENTDIVCONT}</div>';
        var TopologyDiv = '<div class="SepTopoDiv"> <label class="SepTopoLbl">Topography - {HEADERTOPOCODE} - {HEADERTOPODESC}</label></div>';
        var HistoTblDiv = '<div class="SepHistoDiv"><div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto;"><div class="Tablewrapper" style="font-size: 12px; background: white;">{HISTOTABLECONTENT}</div></div></div>';
        var HistoTbl = '<table class="tblpopupList"><thead><tr><th>Code</th><th>Histo/Behaviour</th><th>Description</th><th>Grade</th></tr></thead><tbody>{HISTOTBODYCONTENT}</tbody></table>';
        var SiteSubSiteDiv = '<div class="SepSitSubMainDiv">{SITESUBSITECONTENT}</div>';
        var SiteDiv = '<div class="SepSitSubDiv"><label class="SepHistLbl">Site</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{SITECONTENT}</label></div>';
        var SubSiteDiv = '<div class="SepSitSubDiv"><label class="SepHistLbl">Sub-Site</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{SUBSITECONTENT}</label></div>';
        var PTNMDiv = '<div class="SepPTNMMainDiv">{PTNMMAINDIV}</div>';
        var PDiv = '<div class="SepPDiv"><label class="SepHistLbl">Prefix</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{PREFIX}</label></div>';
        var TDiv = '<div class="SepTDiv"><label class="SepTHistLbl">T</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{TCONTENT}</label></div>';
        var NDiv = '<div class="SepNDiv"><label class="SepTHistLbl">N</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{NCONTENT}</label></div>';
        var MDiv = '<div class="SepMDiv"><label class="SepTHistLbl">M</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{MCONTENT}</label></div>';
        var StageMainDiv = '<div class="SepStageMainDiv">{STAGEMAINCONTENT}</div>';
        var StageDiv = '<div class="SepStageDiv"><label class="SepHistLbl">Stage</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{STAGECONTENT}</label></div>';
        var DotHr = '<hr style="border-top: 2px dotted black;" />';
        var LineHr = '<hr style="border-top: 1px solid black;margin: 0px;" />';
        var HistoryTList = HistoryLst[0];
        var HistoryHList = HistoryLst[1] == null ? [] : HistoryLst[1];
        var HistoryCList = HistoryLst[2];
        var Ind = 1;
        jQuery.grep(HistoryCList, function (C) {
            var FilterHistoryTList = HistoryTList.filter(function (a) {
                return a.REFTRANNO.toString().trim() == C.REFTRANNO.toString().trim();
            });
            var AllData = "";
            var DownArrowId = "HIST_DOWNID_" + Ind;
            var UpArrowId = "HIST_UPID_" + Ind;
            var ContentId = "HIST_CONTENT_" + Ind;
            var ConsultInfo = C.REFTRANNO + " - " + C.CREATEDBY + " (" + C.CREATEDON + " - " + C.CREATEDAT + ")";
            var RplSepMainHeaderLbl = SepMainHeaderLbl.replace("{CONSULTNO}", ConsultInfo);
            var RplArrowDiv = ArrowDiv.replace("{DOWNARROWID}", DownArrowId).replace("{INDEX}", Ind).replace("{UPARROWID}", UpArrowId).replace("{INDEX}", Ind);
            var RplHeaderDiv = HeaderDiv.replace("{HEADERDIVCONT}", (RplSepMainHeaderLbl + RplArrowDiv));
            jQuery.grep(FilterHistoryTList, function (e) {
                var RplTopologyDiv = TopologyDiv.replace("{HEADERTOPOCODE}", (e.TOPOCODE)).replace("{HEADERTOPODESC}", (e.TOPODESC));
                var FilterHisto = HistoryHList.filter(function (h) {
                    return e.MRNO.toString().trim() == h.MRNO.toString().trim() && e.SITELEVEL.toString().trim() == h.SITELEVEL.toString().trim()
                        && e.TOPOCODE.toString().trim() == h.TOPOCODE.toString().trim() && e.TOPOTYPE.toString().trim() == h.TOPOTYPE.toString().trim() && e.REFTRANNO.toString().trim() == h.REFTRANNO.toString().trim();
                });
                var HistoDtls = "";
                var Tr = '<tr><td style="text-align: center;">{ICDOCODE}</td><td style="text-align: center;">{HISTOCODE}</td><td>{HISTODESC}</td><td>{HISTOGRADE}</td></tr>';
                jQuery.grep(FilterHisto, function (k) {
                    var ICDOCode = k.TOPOCODE + k.HCODE + " " + k.HGRADE;
                    var RplTr = Tr.replace("{ICDOCODE}", (ICDOCode)).replace("{HISTOCODE}", (k.HCODE)).replace("{HISTODESC}", (k.HDESC)).replace("{HISTOGRADE}", (k.GRADENAME));
                    HistoDtls = HistoDtls + RplTr;
                });
                var RplHistoTblDiv = "";
                if (HistoDtls != "") {
                    var RplHistoTbl = HistoTbl.replace("{HISTOTBODYCONTENT}", (HistoDtls));
                    RplHistoTblDiv = HistoTblDiv.replace("{HISTOTABLECONTENT}", (RplHistoTbl));
                }
                var RplSiteDiv = SiteDiv.replace("{SITECONTENT}", (e.TNMSITE));
                var RplSubSiteDiv = SubSiteDiv.replace("{SUBSITECONTENT}", (e.TNMSUBSITE));
                var RplSiteSubSiteDiv = SiteSubSiteDiv.replace("{SITESUBSITECONTENT}", (RplSiteDiv + RplSubSiteDiv));
                var RplPDiv = PDiv.replace("{PREFIX}", (e.TNMPREFIX));
                var RplTDiv = TDiv.replace("{TCONTENT}", (e.T));
                var RplNDiv = NDiv.replace("{NCONTENT}", (e.N));
                var RplMDiv = MDiv.replace("{MCONTENT}", (e.M));
                var RplPTNMDiv = PTNMDiv.replace("{PTNMMAINDIV}", (RplPDiv + RplTDiv + RplNDiv + RplMDiv));
                var RplOthrDiv = BindotherFieldHistory(e);
                var RplStageDiv = StageDiv.replace("{STAGECONTENT}", (e.STAGE));
                var RplStageMainDiv = StageMainDiv.replace("{STAGEMAINCONTENT}", RplStageDiv);
                AllData = AllData + (AllData == "" ? "" : DotHr) + RplTopologyDiv + RplHistoTblDiv + RplSiteSubSiteDiv + RplPTNMDiv + RplOthrDiv + RplStageMainDiv;
            });
            var RemarkDiv = '<div class="SepStageMainDiv"><div class="SepRemarkDiv"><label class="SepRemarkLbl">Remark</label><label class="SeparateHistory">:</label><label class="SepRemarkTxt">{REMARKCONTENT}</label></div></div>'
            var RplRemarkDiv = LineHr + RemarkDiv.replace("{REMARKCONTENT}", (C.REMARKS));
            AllData = AllData + RplRemarkDiv;
            var RplContentDiv = ContentDiv.replace("{CONTENTDIVID}", (ContentId)).replace("{CONTENTDIVCONT}", (AllData));
            var RplFDiv = FDiv.replace("{FINALCONTENT}", (RplHeaderDiv + RplContentDiv));
            AllHistoryContent = AllHistoryContent + RplFDiv;
            Ind++;
        });
        return (AllHistoryContent + "</div>");
    }

    function BindotherFieldHistory(OtherFLst) {
        var Div = '<div class="SepODiv" {STYLE}><label class="SepHistLbl">{LABEL}</label><label class="SeparateHistory">:</label><label class="SepHistTxt">{CONTENT}</label></div>';
        var Count = 0;
        var MaxCount = 4;
        var filledList = [];
        var emptyList = [];
        $.each(OtherFieldList, function (i, O) {
            var val = OtherFLst[O.ID];
            if (val != undefined && val != null && val.toString().trim() != "" && val.toString().trim() != "-") {
                filledList.push(O);
            } else {
                emptyList.push(O);
            }
        });
        var AllCont = "";
        var orderedList = filledList.concat(emptyList);
        var groupContent = "";
        var hasVisibleItem = false;
        $.each(orderedList, function (i, O) {
            var val = OtherFLst[O.ID];
            var isFilled = (val != undefined && val != null && val.toString().trim() != "" && val.toString().trim() != "-");
            if (Count === 0) {
                groupContent = "";
                hasVisibleItem = false;
            }
            var content = isFilled ? val : "";
            var StyleCode = "";//O.CenterStyle == "N" ? 'style="text-align: justify;"' : 'style="text-align: center;"';
            var visibility = isFilled ? StyleCode : (StyleCode);// + 'visibility:hidden;');
            var RplCont = Div.replace("{LABEL}", O.LABEL)
                .replace("{CONTENT}", content)
                .replace("{STYLE}", visibility);
            groupContent += RplCont;
            if (isFilled) hasVisibleItem = true;
            Count++;
            if (Count === MaxCount || i === orderedList.length - 1) {
                if (hasVisibleItem) {
                    AllCont += '<div class="SepPTNMMainDiv">' + groupContent + '</div>';
                }
                Count = 0;
            }
        });
        return AllCont;
    }

    function ToggleHistoryContent(Type, Ind) {
        var ContentId = "HIST_CONTENT_" + Ind;
        var DownArrowId = "HIST_DOWNID_" + Ind;
        var UpArrowId = "HIST_UPID_" + Ind;
        document.getElementById(ContentId).style.display = Type == "U" ? "none" : "block";
        document.getElementById(DownArrowId).style.display = Type == "U" ? "inline-block" : "none";
        document.getElementById(UpArrowId).style.display = Type == "U" ? "none" : "inline-block";
    }
</script>

<style>
    .SepMainHistory {
        margin: 0px 5px 10px 5px;
    }

    .SepMainHeaderDiv {
        background-color: #006015;
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 5px;
        border: 1px solid #686868;
    }

    .SepMainHeaderLbl {
        margin: 0px;
        font-size: 14px;
    }

    .DownUpHistoryIcon {
        font-size: 16px;
    }

    .SepMainContentDiv {
        border: 1px solid #898989;
    }

    .SepTopoDiv {
        padding: 5px;
        font-size: 12px;
        font-weight: bold;
    }

    .SepTopoLbl {
        margin: 0px;
    }

    .SepHistoDiv {
        padding: 5px;
    }

    .SepSitSubMainDiv {
        display: flex;
        padding: 5px;
        font-size: 12px;
        justify-content: space-between;
        flex-wrap: wrap;
    }

    .SepHistLbl {
        margin: 0px;
        width: 90px;
        font-weight: bold;
    }

    .SepTHistLbl {
        margin: 0px;
        width: 15px;   /* Pournima changed width 90 to 15*/
        font-weight: bold;
    }

    .SepHistTxt {
        margin: 0px;
        min-width: 60px;
        font-weight: bold;
    }

    .SeparateHistory {
        margin: 0px;
        padding: 0px 5px;
        font-weight: bold;
    }

    .SepPTNMMainDiv {
        display: flex;
        padding: 5px;
        font-size: 12px;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 10px;
    }

    .SepStageMainDiv {
        display: flex;
        padding: 5px;
        font-size: 12px;
        justify-content: space-between;
        flex-wrap: wrap;
    }

    .SepRemarkDiv {
        display: flex;
    }

    .SepRemarkLbl {
        margin: 0px;
        width: 50px;
    }

    .SepRemarkTxt {
        text-wrap-mode: wrap;
    }
</style>

<script>
    function HASDataInDiagnosis() { //priyanka 16/04/2026
        var DiagFreeText = $("#Diagnosis_Freetext").val();
        let i = 0;
        var UncodedDiagData = UnCodedDiagListtable.getData();
        var ICDDiagData = ICDDiagListtable.getData();
        if ($("#RbtnCancerY").prop("checked") === true) {
            if (
                UnCodedDiagListtable.getData().length === 0 &&
                ICDDiagListtable.getData().length === 0 &&
                ICDOTopoList.length === 0 &&
                ICDOHistoList.length === 0 &&
                (DiagFreeText === "" || DiagFreeText === null)
            ) {
                return false;
            } else {
                return true;
            }
        }
        else {
            if (
                UnCodedDiagListtable.getData().length === 0 &&
                ICDDiagListtable.getData().length === 0 &&
                (DiagFreeText === "" || DiagFreeText === null)
) {
                return false;
            } else {
                return true;
            }
        }
    }
</script>

<div id="sec-Diagnosis" class="opd-section-card anchor-offset container-fluid">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h4 class="section-title me-5">Diagnosis</h4>
    </div>


   
    <%--<h6 class="fw-bold" style="padding: 15px 0px;">Other Diagnosis</h6>--%>
<textarea class="form-control TextAreaBorder" id="Diagnosis_Freetext" name="Diagnosis_Freetext" placeholder="Enter Diagnosis" oninput="autoResizeTextareaForSinglePage(this)"
    style="height: 100px; overflow-y: auto; resize: none;display:none" maxlength="1000"></textarea>
<div class="text-end" id="Diagnosis_Freetext_Icon" style="display:none">
    <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnFitToContentDiag" title="Fit to Content" style="width:35px; height:30px; cursor:pointer;" />
    <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnSetMaxHeightDiag" title="Set Max Height" style="width:35px; height:30px; cursor:pointer;" />
</div>



    <%-- Un-Coded Diagnosis --%>
    <div class="d-flex justify-content-between mt-3 mb-3 align-items-center">
        <h6 class="fw-bold mb-0">Diagnosis</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="UnCodedDiagonsisSearch" class="form-control" placeholder="Search Diagnosis" onclick="GetFrequentUnCodedDiagnosis()" oninput="GetAllUnCodedDiagonsisList()"> <%-- oninput="FilterBindedSearchListForUnCodedDiagonsis()"--%>  <%--// Modified Pournima 16th June 2026--%>
                <button class="btn btn-outline-success" id="DiagnosisAdd" onclick="OpenPopupForNewItem('Diagnosis' , 'UnCodedDiagnosis')"><i class="fa fa-plus"></i></button>
                <button class="btn btn-outline-success" id="Diagnosis_PrevHistory" onclick="HistoryPopupOpen('Diagnosis History', 'UnCodedDiagnosis', true,'')"><i class="fa fa-history"></i></button>
                <button class="btn btn-outline-success btn-sm" id="UnCodedDiagn_Setup" onclick="SetupPopupOpen('Diagnosis','UnCodedDiag',false)">Setup</button>
            </div>
            <div id="UnCodedDiagonsisListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="UnCodedDiagonsisList" class="list-group w-100"></div>
                <div id='loading-UnCodedDiagnosis-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="UnCodedDiagonsisTable" style="margin: 10px 10px;"></div>

    <%-- ICD Diagnosis --%>
    <div class="d-flex justify-content-between mt-3 mb-3 align-items-center">
        <h6 class="fw-bold mb-0">ICD Diagnosis</h6>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <input type="text" id="ICDDiagonsisSearch" class="form-control" placeholder="Search ICD Diagnosis" onclick="GetFrequentICDDiagnosis()" oninput="GetAllICDDiagonsisList()">   <%--oninput="FilterBindedSearchListForICDDiagonsis()"--%> <%--// Modified Pournima 16th June 2026--%>
                <button class="btn btn-outline-success" id="ICDDiagnosis_PrevHistory" onclick="HistoryPopupOpen('ICD Diagnosis History', 'ICDDiagnosis', true, '')"><i class="fa fa-history"></i></button>
                <button class="btn btn-outline-success btn-sm" id="ICDDiagn_Setup" onclick="SetupPopupOpen('ICD Diagnosis','ICDDiag',false)">Setup</button>
            </div>
            <div id="ICDDiagonsisListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="ICDDiagonsisList" class="list-group w-100"></div>
                <div id='loading-ICDDiagnosis-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="ICDDiagonsisTable" style="margin: 10px 10px;"></div>


    <%-- ICD-O Diagnosis --%>
    <div id="MAIN_ICDO" class="flex-column" style="display: flex;">
        <div class="d-flex justify-content-between mt-2 mb-2 align-items-center">
            <h6 class="fw-bold mb-0">ICD-O Diagnosis</h6>
     <div>
      <button type="button" class="btn btn-sm btn-outline-success me-1" id="btnFinalDiagnosis" onclick="HistoryPopupOpen('Final Diagnosis', 'ICDODFinaldiagnosis', true, '')">FinalDiagnosis</button>
      <button class="btn btn-outline-success btn-sm" id="ICDODiagnosis_PrevHistory" onclick="HistoryPopupOpen('ICDO Diagnosis History', 'ICDODiagnosis', true, '')"><i class="fa fa-history"></i></button>
         </div>  
</div>        
        <div class="flex-grow-1" id="Cancer" style="padding: 0px 10px;">
            <div class="col-xs-12">
                <div style="display: inline-block;">
                    <label class="TopoHistHeaderLbl" style="display: inline-block; font-size: 16px; width: 180px;">Diagnosed with Cancer</label>
                    <div style="display: inline-block;">
                        <div style="display: flex; align-items: center; padding-left: 20px;">
                            <input style="margin: 0;" name="CANCER" type="radio" id="RbtnCancerY" onclick="EnDisCancer()" />
                            <label style="margin: 0; padding: 0px 10px;" for="RbtnCancerY">Yes</label>
                            <input style="margin: 0;" name="CANCER" type="radio" id="RbtnCancerN" onclick="EnDisCancer()" />
                            <label style="margin: 0; padding: 0px 10px;" for="RbtnCancerN">No</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="Remark" style="margin-top: 10px; padding: 0px 10px;">
            <div class="col-xs-12" style="vertical-align: top; display: flex;">
                <label class="TopoHistHeaderLbl" style="display: inline-block; font-size: 16px; width: 240px;">Remark</label>
                <textarea id="ICDORemark" class="form-control TextAreaBorder" maxlength="100" onkeyup="$('#ICDORemark').css('border-color', '');"></textarea>
            </div>
        </div>
        <button type="button" id="ICDOEdit" style="display: none" onclick="EditICDODetails('N')">Edit</button>
        <div id="SITE_1" style="display: none; padding: 0px 10px;">
            <div id="Site_Header_1" class="col-xs-12 SiteHeaderDiv" style="display: none;">
                <label class="SiteHeaderLbl">Primary Site</label>
            </div>
            <div id="Site_Content_1" class="col-xs-12 SiteContentDiv">
                <div id="Search_Topo_Div_1" class="col-xs-12 SiteTopoSrchDiv">
                    <input type="text" id="SrchICDOTopography_1" placeholder="Search Topography..." autocomplete="off" class="SiteTopoSrchTxt" onclick="" onkeyup="SearchTopoGraphy(this.id,'1')">
                    <div class="SearchList" id="TopographySrchLst_1" style="top: 32px; display: none; z-index: 999999;"></div>
                </div>
                <div id="Search_Topo_Content_1" class="TopoContentDiv"></div>
            </div>
        </div>

        <div id="SITE_2" style="margin-top: 10px; display: none; padding: 0px 10px;">
            <div id="Site_Header_2" class="col-xs-12 SiteHeaderDiv" style="margin-top: 10px;">
                <label class="SiteHeaderLbl">Secondary Site</label>
            </div>

            <div id="Site_Content_2" class="col-xs-12 SiteContentDiv">
                <div id="Search_Topo_Div_2" class="col-xs-12 SiteTopoSrchDiv">
                    <input type="text" id="SrchICDOTopography_2" placeholder="Search Topography..." autocomplete="off" class="SiteTopoSrchTxt" onkeyup="SearchTopoGraphy(this.id,'2')">
                    <div class="SearchList" id="TopographySrchLst_2" style="display: none"></div>
                </div>
                <div id="Search_Topo_Content_2" class="TopoContentDiv"></div>
            </div>
        </div>
        <div id="POPUPInfoModal" class="EModal" style="justify-content: center; align-items: center;display:none">
            <div class="modal-content" style="min-width: 300px;">
                <div class="ModelHeaderDiv ResultHeader">
                    <label id="InfoHeadLabel"></label>
                    <span id="closeARISCATBtn" class="closeMdlBtn" onclick="document.getElementById('POPUPInfoModal').style.display = 'none'; document.documentElement.style.overflow = '';">&times;</span>
                </div>
                <div class="ModelContentDiv">
                    <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                        <div class="Tablewrapper" style="font-size: 12px; background: white;">
                            <table class="tblpopupList" id="TblPrefixInfo">
                                <thead>
                                    <tr>
                                        <th>Value</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="text-align: center;">c</td>
                                        <td>Clinical</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">p</td>
                                        <td>Pathological</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">yc</td>
                                        <td>Post-treatment Clinical</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">yp</td>
                                        <td>Post-treatment Pathological</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">r</td>
                                        <td>Recurrent</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
