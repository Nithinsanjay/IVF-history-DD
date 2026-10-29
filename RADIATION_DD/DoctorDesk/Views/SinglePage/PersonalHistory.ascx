<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%
    string pageType = Convert.ToString(ViewData["Type"] ?? "");
    if (string.IsNullOrEmpty(pageType)) { pageType = "Popup"; }
%>

<style type="text/css">
    .custom-save-class {
        font-size: 14px;
        font-weight: 700;
    }  
    .tabulator-edit-list {
        z-index: 100000 !important;
    }
    #Remarks_Freetext_<%= pageType %> {
        min-height: 80px;
    }
</style>

<script type="text/javascript">

    window.Global_Personal_History_Grid = window.Global_Personal_History_Grid || {};
    var GlobalDisease;

    $(document).ready(function () {

        PersonalHistoryGridInit_<%= pageType %>();

        $('#SavePersonalHistory_<%= pageType %>').off('click').on('click', function () {
            savePersonalHistoryService_<%= pageType %>();
        });

        $(document).off("click.PersonalHist_<%= pageType %>", ".personalhist-row-<%= pageType %>")
            .on("click.PersonalHist_<%= pageType %>", ".personalhist-row-<%= pageType %>", function () {
                var code = $(this).data("code");
                var name = $(this).data("name");
                var activeTable = Global_Personal_History_Grid['<%= pageType %>'];
                if (!activeTable) return;

                var rows = activeTable.getData();
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].PersonalHistCode == code) {
                        ToastMsg("Personal history already added", "warning");
                        $("#PersonalHistoryListMainDiv_<%= pageType %>").hide();
                        return;
                    }
                }
                activeTable.addRow({
                    act: '<i class="fa fa-trash text-danger" style="cursor:pointer;"></i>',
                    PersonalHistCode: code,
                    PersonalHistName: name,
                    PERSONALHISTORY: name,
                    DURNO: "",
                    DURCATG: ""
                }).then(function (row) {
                    if (row && typeof row.normalizeHeight === "function") {
                        row.normalizeHeight();
                    }
                    adjustTableHeight("PersonalHistoryGrid_<%= pageType %>");
                });
                $("#PersonalHistorySearch_<%= pageType %>").val("");
                $("#PersonalHistoryListMainDiv_<%= pageType %>").hide();
            });
               

        // Close search dropdown on click outside
        $(document).off("click.PersonalHistClose_<%= pageType %>").on("click.PersonalHistClose_<%= pageType %>", function (e) {
            if (!$(e.target).closest("#PersonalHistorySearch_<%= pageType %>, #PersonalHistoryListMainDiv_<%= pageType %>").length) {
                $("#PersonalHistoryListMainDiv_<%= pageType %>").hide();
            }
        });

    });

    async function PersonalHistoryGridInit_<%= pageType %>() {

        GlobalDisease = await getLstDiagnosis();

        Global_Personal_History_Grid['<%= pageType %>'] = new Tabulator('#PersonalHistoryGrid_<%= pageType %>', {
            layout: 'fitColumns',
            rowHeight: null,
            height: '300px',
            data: [],
            columns: [
                {
                    title: '',
                    field: "act",
                    hozAlign: 'center',
                    formatter: 'buttonCross',
                    width: 40,
                    formatter: function (cell, formatterParams) {
                        return '<i class="fa fa-trash" style="color:red; cursor:pointer;"></i>';
                    },
                    cellClick: function (e, cell) {
                        cell.getRow().delete();
                    }
                },
                { title: "PersonalHistoryCode", field: "PersonalHistCode", visible: false },
                {
                    title: 'Personal History',
                    field: 'PERSONALHISTORY',
                    width: "68%",
                    editable: false,
                    formatter: function (cell) {
                        var val = cell.getValue();
                        if (GlobalDisease && GlobalDisease[val]) {
                            return GlobalDisease[val];
                        }
                        var row = cell.getRow().getData();
                        return row.PersonalHistName || val || "";
                    }
                },
                {
                    width: "14%",
                    title: 'Duration No.',
                    field: 'DURNO',
                    editor: 'list',
                    editorParams: {
                        autocomplete: 'true',
                        allowEmpty: true,
                        listOnEmpty: true,
                        valuesLookup: true,
                        values: getDuration(85)
                    },
                    cellEdited: function (cell) {
                        var row = cell.getRow().getData();
                        if (!validatePersonalHistoryDurationWithAge(
                            row.DURNO,
                            row.DURCATG
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");
                        }
                    }
                },
                {
                    width: "14%",
                    title: 'Duration Catgeory',
                    field: 'DURCATG',
                    editor: 'list',
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
                        if (!validatePersonalHistoryDurationWithAge(
                            row.DURNO,
                            row.DURCATG
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");
                        }
                    }
                },
            ]
        });

        adjustTableHeight("PersonalHistoryGrid_<%= pageType %>");
        SetDataForAddiction_<%= pageType %>();
    }

function validatePersonalHistoryDurationWithAge(duration, category) {
    duration = parseInt(duration) || 0;
    if (!category || duration <= 0) return true;

    var ageStr = sessionStorage.getItem("IPPatAge")
        || sessionStorage.getItem("PatAge")
        || $("#HeaderSection_PatDetails_AGE").text()
        || "";

    var match = ageStr.toString().match(/\d+/);
    var age = match ? parseInt(match[0]) : 0;

    if (age <= 0) return true;

    var durationInYears = 0;
    var cat = category.toString().trim().toUpperCase().charAt(0);

    switch (cat) {
        case "D": durationInYears = duration / 365; break;
        case "W": durationInYears = duration / 52; break;
        case "M": durationInYears = duration / 12; break;
        case "Y": durationInYears = duration; break;
        default: return true;
    }

    return durationInYears <= age;
}



    function getLstDiagnosis() {
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../Clinicalnotes/GetMainAddicList',
                data: {},
                success: function (response) {
                    resolve(processDisea(response));
                },
                error: function (xhr, status, error) {
                    resolve({});
                }
            });
        });
    }

    function processDisea(response) {
        if (!response || !Array.isArray(response) || response.length === 0) return {};
        let diseaseConstructor = {};
        for (let i = 0; i < response.length; i++) {
            diseaseConstructor[response[i]['DESCCD']] = response[i]['DESC'];
        }
        return diseaseConstructor;
    }

    function getDuration(maxDuration) {
        let durationContructor = {};
        for (let i = 0; i <= maxDuration; i++) {
            durationContructor[i] = [i];
        }
        return durationContructor;
    }

    function addNewRow_<%= pageType %>() {
        if (Global_Personal_History_Grid['<%= pageType %>']) {
            Global_Personal_History_Grid['<%= pageType %>'].addRow();
        }
    }

    // Setting Data
    function SetDataForAddiction_<%= pageType %>() {
        getPersonalHistoryPatService().then(function (result) {
            if (!Array.isArray(result) || result.length === 0) return;

            let gridRows = result[0] || [];
            let remarkstext = result[1] || [];

            let tabulatorData = gridRows.map(function (row) {
                return {
                    act: '<i class="fa fa-trash text-danger" style="cursor:pointer;"></i>',
                    PersonalHistCode: row.ADDICTCD,
                    PERSONALHISTORY: row.ADDICTCD,
                    DURNO: row.STOPAGE,
                    DURCATG: row.STARTAGE
                };
            });

            var activeTable = Global_Personal_History_Grid['<%= pageType %>'];
            if (activeTable) {
                activeTable.setData(tabulatorData).then(function () {
                    adjustTableHeight("PersonalHistoryGrid_<%= pageType %>");
                });
            }

            if (remarkstext.length > 0) {
                let remarks = remarkstext[0].PERSHIS || '';
                var $rem = $('#Remarks_Freetext_<%= pageType %>');
                $rem.val(remarks);
                if (typeof autoResizeTextareaForSinglePage === 'function' && $rem.length) {
                    autoResizeTextareaForSinglePage($rem[0]);
                }
            }
        });
    }

    function getPersonalHistoryPatService() {
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO') || "";
        } else {
            tranNo = sessionStorage.getItem('IPPatIPNO') || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";
        }

        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                data: { strTranNo: tranNo, strMrNo: mrNo },
                url: '../Clinicalnotes/SetDataForAddiction',
                success: function (response) {
                    resolve(response);
                },
                error: function (xhr, status, error) {
                    reject(false);
                }
            });
        });
    }

    function prepareFreeTextData(strText, strTran, strMrNo, strType) {
        return {
            strText: strText,
            strTran: strTran,
            strMrNo: strMrNo,
            strType: strType
        };
    }

function AddFreeHistory_<%= pageType %>(strText, strType, isCommonSave) {
    return new Promise(function (resolve, reject) {
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO') || "";
        } else {
            tranNo = sessionStorage.getItem('IPPatIPNO') || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";
        }

        let dataToSend = prepareFreeTextData(strText, tranNo, mrNo, strType);
        startLoading('Loading');
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../Clinicalnotes/AddFreeHistory',
            data: dataToSend,
            success: function (response) {
                if (("" + response).toUpperCase().indexOf("NOT INSERTED") != -1 && sessionStorage.getItem("MODULE_FLAG") !== "IPD") {
                    ToastMsg(response, "info");
                    resolve(false);
                }
                else {
                    if (typeof PatHistoryTab === "function") {
                        PatHistoryTab();
                    }
                    // Re-bind both IPD and Popup so changes replicate immediately on both!
                    if (typeof SetDataForAddiction_IPD === "function") {
                        SetDataForAddiction_IPD();
                    }
                    if (typeof SetDataForAddiction_Popup === "function") {
                        SetDataForAddiction_Popup();
                    }
                    if (!isCommonSave) {
                        ToastMsg("Saved Successfully", "success");
                    }
                    resolve(true);
                }
            },
            error: function (xhr, status, err) {
                ToastMsg("Error Processing", "error");
                reject(err);
            },
            complete: function () {
                stopLoading();
            }
        });
    });
}


function ValidationForPersonalHistory_<%= pageType %>() {
    var activeTable = Global_Personal_History_Grid['<%= pageType %>'];
    let data = activeTable ? activeTable.getData() : [];
    for (let i = 0; i < data.length; i++) {
        if (!data[i]['DURNO']) {
            ToastMsg("Select Duration ");
            return false;
        }
        if (!data[i]['DURCATG']) {
            ToastMsg("Select Duration Category");
            return false;
        }
        if (!validatePersonalHistoryDurationWithAge(data[i]['DURNO'], data[i]['DURCATG'])) {
            ToastMsg("Duration cannot exceed patient age");
            return false;
        }
    }
    return true;
}


    function savePersonalHistoryService_<%= pageType %>(isCommonSave) {
        return new Promise(function (resolve, reject) {
            var postData = preparePersonalHistoryData_<%= pageType %>();
            if (!postData || postData === false) {
                return;
            }
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../clinicalnotes/SaveAddiction',
                data: postData,
                async: isCommonSave ? false : true,
                success: function (response) {
                    if (response === true) {
                        SaveOtherPersonalHistoryRemarks_<%= pageType %>(isCommonSave);
                    } else {
                        ToastMsg('Unable to save the data. Please try again.', 'error');
                    }
                    resolve(response);
                },
                error: function (xhr, status, error) {
                    ToastMsg("Error Processing", "error");
                    reject(error);
                }
            });
        });
    }

function preparePersonalHistoryData_<%= pageType %>() {
        debugger;
        var activeTable = Global_Personal_History_Grid['<%= pageType %>'];
        let data = activeTable ? activeTable.getData() : [];
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO') || "";
        }

        let dataToSend = [];
        for (let i = 0; i < data.length; i++) {

            if (!data[i]['DURNO']) {
                ToastMsg("Select Duration ");
                return false;
            }

            if (!data[i]['DURCATG']) {
                ToastMsg("Select Duration Category");
                return false;
            }
            if (!validatePersonalHistoryDurationWithAge(
                data[i]['DURNO'],
                data[i]['DURCATG']
            )) {
                ToastMsg("Duration cannot exceed patient age");
                return false;
            }
            let obj = {
                ADDICTCD: data[i]['PersonalHistCode'],
                STARTAGE: data[i]['DURCATG'],
                STOPAGE: data[i]['DURNO']
            };
            dataToSend.push(obj);
        }
        let finalDataToSend = {
            strAddict: JSON.stringify(dataToSend),
            strMRNO: mrNo,
            strTranNo: tranNo
        };
        return finalDataToSend;
    }

    function ContentForAddNewItemPersonalHistory() {
        return `
        <div class="mb-3">
          <input id="txtPersonalHistory" type="text" class="form-control" maxlength="250" autocomplete="off" placeholder="Enter Addiction" tabindex="2" />
        </div>
        `;
    }

    //Footer Content For New Item Complaints
    function FooterContentForAddNewItemPersonalHistory() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForPersonalHistory('PersonalHistory')" tabindex="4">Save</button>
        `;
    }

    //Validation For New Item Complaints
    function ValidationForNewItemPersonalHist() {
        if ($("#txtPersonalHistory").val().trim().length === 0) {
            ToastMsg("Enter Addiction", "warning");
            $("#txtPersonalHistory").focus();
            return false;
        }
        return true;
    }

    //Save New Item For Personal History
    function SaveNewItemForPersonalHistory() {
        if (ValidationForNewItemPersonalHist() == true) {
            var addict = $("#txtPersonalHistory").val().toString().trim().replace(/\s/g, ' ');
            var grpCode = "";
            $.ajax({
                type: "post",
                datatype: "json",
                url: "../clinicalnotes/AddAddiction",
                data: { strAddict: addict, strGrpCode: grpCode },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        var PersonalHistNewcode = (response.match(/code\s+(\d+)/i) || ["", ""])[1];
                        var PersonalHistNewText = $("#txtPersonalHistory").val();
                        GetAllPersonalHistList(PersonalHistNewcode, PersonalHistNewText);
                        closeAddNewItemPopup('PersonalHistory');
                    }
                    else {
                        ToastMsg(response, "warning");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }

    // Get List Data
    function GetFrequentPersonalHistoryList_<%= pageType %>() {
        startLoading("Loading", "loading-Personalhist-Search-List_<%= pageType %>");
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMainAddicList",
            async: true,
            data: {},
            success: function (result) {
                var PersonalhistListData = [];
                if (result && result.length > 0) {
                    PersonalhistListData = result;
                }
                else if (result && result.Result) {
                    ToastMsg(result.Result, "error");
                }
                BindSearchListForPersonalHistory_<%= pageType %>(PersonalhistListData);
                stopLoading("loading-Personalhist-Search-List_<%= pageType %>");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Personalhist-Search-List_<%= pageType %>");
                ToastMsg(textStatus, "error");
            }
        });
    }

    //List Binding Functionality
    function BindSearchListForPersonalHistory_<%= pageType %>(PersonalhistListData) {
        var $list = $("#PersonalHistList_<%= pageType %>");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No personal history found</div>';
        if (PersonalhistListData && PersonalhistListData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < PersonalhistListData.length; i++) {
                var item = PersonalhistListData[i];
                var ListOption = '<div class="list-group-item personalhist-row-<%= pageType %>" data-code="' + item.DESCCD + '" data-name="' + item.DESC + '" style="cursor:pointer;">' + item.DESC + ' (' + item.DESCCD + ') </div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $list.append(AppendContentList);
        $("#PersonalHistoryListMainDiv_<%= pageType %>").show();
    }

    function GetAllPersonalHistList(PersonalHistNewcode, PersonalHistNewText) {
        startLoading("Loading", "loading-Personalhist-Search-List_<%= pageType %>");
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMainAddicList",
            async: true,
            data: {},
            success: function (result) {
                var PersonalhistListData = [];
                if (result && result.length > 0) {
                    PersonalhistListData = result;
                }
                else if (result && result.Result) {
                    ToastMsg(result.Result, "error");
                }

                FilterPersonalHistoryData_<%= pageType %>(PersonalhistListData, PersonalHistNewcode);
                stopLoading("loading-Personalhist-Search-List_<%= pageType %>");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Personalhist-Search-List_<%= pageType %>");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Personal History Data list */
    function FilterPersonalHistoryData_<%= pageType %>(PersonalhistListData, PersonalHistNewcode) {
        var FilterPerHistList = PersonalhistListData;
        if (PersonalHistNewcode != "") {
            FilterPerHistList = PersonalhistListData.filter(item => item.DESCCD == PersonalHistNewcode);
        }
        BindSearchListForPersonalHistory_<%= pageType %>(FilterPerHistList);
        if (PersonalHistNewcode && PersonalHistNewcode !== "") {
            var $first = $("#PersonalHistList_<%= pageType %> .personalhist-row-<%= pageType %>").first();
            if ($first.length) {
                $first.trigger("click");
            }
        }
    }

    //Filter in HTML Search
    function FilterBindedSearchListForPersonalHistory_<%= pageType %>() {
        var SearchTxt = $("#PersonalHistorySearch_<%= pageType %>").val().toLowerCase();
        if ($("#PersonalHistList_<%= pageType %>").children().length === 0) {
            GetFrequentPersonalHistoryList_<%= pageType %>();
            return;
        }
        if (SearchTxt.length >= 3) {
            $("#PersonalHistList_<%= pageType %> .personalhist-row-<%= pageType %>").each(function () {
                var name = ($(this).data("name") || "").toString().toLowerCase();
                var code = ($(this).data("code") || "").toString().toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
            $("#PersonalHistoryListMainDiv_<%= pageType %>").show();
        } else {
            $("#PersonalHistList_<%= pageType %> .personalhist-row-<%= pageType %>").show();
        }
    }

    function SaveOtherPersonalHistoryRemarks_<%= pageType %>(isCommonSave) {
        let value = $('#Remarks_Freetext_<%= pageType %>').val();
        AddFreeHistory_<%= pageType %>(value, 'P', isCommonSave);
    }

    // Backward compatibility helper
    function savePersonalHistoryService() {
        return savePersonalHistoryService_<%= pageType %>();
    }

    function SetDataForAddiction() {
        return SetDataForAddiction_<%= pageType %>();
    }

</script>

<div class="container-fluid px-0" id="PersonalHistory_<%= pageType %>">


    <div class="d-flex justify-content-between mb-3 align-items-start" id="PersonalHistory_RemarksSection_<%= pageType %>">
        <h6 class="fw-bold me-5">Other Personal History</h6>
        <div class="position-relative ms-5">
            <div class="input-group input-group-sm w-100">
              <button class="btn btn-success fw-bold" id="SavePersonalHistory_<%= pageType %>" onclick="savePersonalHistoryService_<%= pageType %>()" style='<%= pageType == "IPD" ? "display: none;" : "" %>'>
                    <i class="fa fa-save" style="font-size: 15px;"></i><span style="padding: 0px 5px; font-size: 15px;">Save</span>
                </button>
            </div>
        </div>
    </div>
        <textarea class="form-control mb-2 TextAreaBorder" id="Remarks_Freetext_<%= pageType %>" name="PersonalHistory_Freetext_<%= pageType %>" oninput="if(typeof autoResizeTextareaForSinglePage === 'function') autoResizeTextareaForSinglePage(this);" style="height: 100px; overflow-y: auto; resize: none;"></textarea>
    <div class="text-end mt-1">
        <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" onclick="toggleTextareaHeight(this, 'Remarks_Freetext_<%= pageType %>')" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
    </div>
     
    <div id="PersonalHistory_ListSection_<%= pageType %>">


        <%-- Header Section --%>
        <h6 class="fw-bold" style="padding: 15px 0px;">Personal History List</h6>
        <div class="d-flex justify-content-between mb-3 align-items-start">
            <div class="flex-grow-1 position-relative ms-0">
                <div class="input-group input-group-sm w-100">
                    <input type="text" id="PersonalHistorySearch_<%= pageType %>" class="form-control" placeholder="Search Addiction (Enter Atleast 3 Chars)" onclick="GetFrequentPersonalHistoryList_<%= pageType %>()" oninput="FilterBindedSearchListForPersonalHistory_<%= pageType %>()" autocomplete="off">
                    <button class="btn btn-outline-success" id="PersonalHistoryAdd_<%= pageType %>" onclick="OpenPopupForNewItem('Personal History', 'PersonalHistory')"><i class="fa fa-plus"></i></button>
                </div>
                <div id="PersonalHistoryListMainDiv_<%= pageType %>" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                    <div id="PersonalHistList_<%= pageType %>" class="list-group w-100"></div>
                    <div id='loading-Personalhist-Search-List_<%= pageType %>' class='loading-screen' style='display: none; opacity: 0;'></div>
                </div>
            </div>
        </div>

        <%-- Grid Control --%>
        <div>
            <div id="PersonalHistoryGrid_<%= pageType %>"></div>
            <div class="d-none justify-content-center align-content-center pt-3">
                <button onclick="savePersonalHistoryService_<%= pageType %>();" type="button" class="btn btn-success rounded px-4 py-1 custom-save-class d-none">Save</button>
            </div>
        </div>

    </div>

</div>
