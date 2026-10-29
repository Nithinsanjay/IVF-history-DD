<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style type="text/css">

       .custom-save-class{
           font-size: 14px;
           font-weight: 700;
       }  
</style>


<script type="text/javascript">

    var Global_Personal_History_Grid;
    var GlobalDisease;

    $(document).ready(function () {

        PersonalHistoryGridInit();

        //$('#addFreeTextFamilyBtn').click(function () {
        //    let value = $('#Remarks_Freetext').val();
        //    if (!value) {
        //        ToastMsg('Kindly Enter Remarks', 'warning');
        //    }
        //    else {
        //        AddFreeHistory(value, 'P');
        //    }
        //});

        $('#SavePersonalHistory').click(function () {
            //SaveOtherPersonalHistoryRemarks();
            savePersonalHistoryService();
        });
        


        $(document).off("click.PersonalHist", ".personalhist-row")
        .on("click.PersonalHist", ".personalhist-row", function () {
            //debugger;
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = Global_Personal_History_Grid.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].PersonalHistCode === code) {
                    ToastMsg("Personal history already added", "warning");
                    $("#PersonalHistoryListMainDiv").hide();
                    return;
                }
            }
            Global_Personal_History_Grid.addRow({
                act: '<i class="fa fa-trash text-danger"></i>',
                PersonalHistCode: code,
                PERSONALHISTORY: name,
                DURNO: "",
                DURCATG: ""
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("PersonalHistoryGrid");
            });
            $("#PersonalHistorySearch").val("");
            $("#PersonalHistoryListMainDiv").hide();
        });


    });

    async function PersonalHistoryGridInit() {

        GlobalDisease = await getLstDiagnosis();

        Global_Personal_History_Grid = new Tabulator('#PersonalHistoryGrid', {
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
                    editor: 'list',
                    editorParams: {
                        autocomplete: true,
                        allowEmpty: true,
                        listOnEmpty: true,
                        valuesLookup: false,
                        values: GlobalDisease
                    },
                    formatter: 'lookup',
                    formatterParams: GlobalDisease
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

                        if (!validateDurationWithAge(
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
                            'W': 'Weeks', //priyanka 09/04/2026
                            'M': 'Months',
                            'Y': 'Years'
                        }
                    },
                    formatter: 'lookup',
                    formatterParams: {
                        'D': 'Days',
                        'W': 'Weeks', //priyanka 09/04/2026
                        'M': 'Months',
                        'Y': 'Years'
                    },
                    cellEdited: function (cell) {

                        var row = cell.getRow().getData();

                        if (!validateDurationWithAge(
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
        //Global_Personal_History_Grid.on("cellEdited", function (cell) {
        //    cell.getRow().normalizeHeight();
        //    adjustTableHeight("PersonalHistoryGrid");
        //});

        //Global_Personal_History_Grid.on("rowAdded", function (row) {
        //    row.normalizeHeight();
        //    adjustTableHeight("PersonalHistoryGrid");
        //});

        //Global_Personal_History_Grid.on("rowDeleted", function (row) {
        //    adjustTableHeight("PersonalHistoryGrid");
        //});

        //Global_Personal_History_Grid.on("dataLoaded", function () {
        //    adjustTableHeight("PersonalHistoryGrid");
        //});

        //Global_Personal_History_Grid.on("tableBuilt", function () {
        //    adjustTableHeight("PersonalHistoryGrid");
        //});

        //Global_Personal_History_Grid.on("dataChanged", function () {
        //    adjustTableHeight("PersonalHistoryGrid");
        //});

        adjustTableHeight("PersonalHistoryGrid");
        SetDataForAddiction();
    }

    

    function validateDurationWithAge(duration, category) {

        var ageStr = sessionStorage.getItem("PatAge");
        var age = parseInt(ageStr) || 0;

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
                    console.log('response', response);
                    resolve(processDisea(response));
                },
                error: function (xhr, status, error) {

                },
                complete: function () {

                }
            })
        })
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

    function addNewRow() {
        Global_Personal_History_Grid.addRow()
    }


    // Setting 
    function SetDataForAddiction() {
        //debugger;
        getPersonalHistoryPatService().then(function (result) {
            if (!Array.isArray(result) || result.length === 0) return;

            let gridRows = result[0] || [];
            let remarkstext = result[1] || [];

            let tabulatorData = gridRows.map(function (row) {
                return {
                    PersonalHistCode:row.ADDICTCD,
                    PERSONALHISTORY: row.ADDICTCD,
                    DURNO: row.STOPAGE,
                    DURCATG: row.STARTAGE

                }
            });

            if (Global_Personal_History_Grid) {
                Global_Personal_History_Grid.setData(tabulatorData);
            }

            if (remarkstext.length > 0) {
                let remarks = remarkstext[0].PERSHIS || '';
                $('#Remarks_Freetext').val(remarks);
            }
        });
    }

    function getPersonalHistoryPatService() {
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO');
        }
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                data: { strTranNo: tranNo, strMrNo: mrNo },
                url: '../Clinicalnotes/SetDataForAddiction',
                success: function (response) {
                    console.log('respopns', response);
                    resolve(response);
                },
                error: function (xhr, status, error) {
                    reject(false);
                },
                complete: function () {

                }
            });
        })
    }


    function prepareFreeTextData(strText, strTran, strMrNo, strType) {
        return {
            strText: strText,
            strTran: strTran,
            strMrNo: strMrNo,
            strType: strType
        };
    }

    function AddFreeHistory(strText, strType) {
        return new Promise(function (resolve, reject) {
            var tranNo = "";
            var mrNo = GetSessionMRNO();
            if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
                tranNo = sessionStorage.getItem('PatTRANNO');
            }
            let dataToSend = prepareFreeTextData(strText, tranNo, mrNo, strType)
            startLoading('Loading');
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../Clinicalnotes/AddFreeHistory',
                data: dataToSend,
                success: function (response) {

                    if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                        ToastMsg(response, "info");
                        return false;
                    }
                    else {
                        PatHistoryTab();
                        ToastMsg("Saved Successfully", "success");
                        return true;
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

    function savePersonalHistoryService() {
        //debugger;
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../clinicalnotes/SaveAddiction',
                data: preparePersonalHistoryData(),
                success: function (response) {
                    // console.log('respoonse', response);
                    if (resolve && response === true) {
                        //ToastMsg('Data has been saved successfully.', 'success');
                        //PatHistoryTab();//priyanka 08/04/2026
                        SaveOtherPersonalHistoryRemarks();
                    } else {
                        ToastMsg('Unable to save the data. Please try again.', 'error');
                    }
                },
                error: function (xhr, status, error) {
                    ToastMsg("Error Processing", "error");
                },
                complete: function () {

                }
            });
        });
    }

    function preparePersonalHistoryData() {
        //debugger;
        let data = Global_Personal_History_Grid.getData();
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO');
        }
        let remarksFreeText = $('#Remarks_Freetext').val();
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
            if (!validateDurationWithAge(
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
        }
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
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('Complaints')" tabindex="3">Close</button>
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
            //startLoading("Loading", "loading-Personalhist-New-Item")
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
                    //stopLoading("loading-Personalhist-New-Item");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //stopLoading("loading-Personalhist-New-Item");
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }
    // Get List Data
    function GetFrequentPersonalHistoryList()
    {
        //debugger;
        startLoading("Loading", "loading-Personalhist-Search-List")
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMainAddicList",
            async: true,
            data: {},
            success: function (result) {
                var PersonalhistListData = [];
                if (result.length > 0) {
                    PersonalhistListData = result;
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                BindSearchListForPersonalHistory(PersonalhistListData);
                stopLoading("loading-Personalhist-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Personalhist-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    //List Binding Functionality
    function BindSearchListForPersonalHistory(PersonalhistListData) {
        var $list = $("#PersonalHistList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No personal history found</div>';
        if (PersonalhistListData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < PersonalhistListData.length; i++) {
                var item = PersonalhistListData[i];
                var ListOption = '<div class="list-group-item personalhist-row" data-code="' + item.DESCCD + '" data-name="' + item.DESC + '" style="cursor:pointer;">' + item.DESC + ' (' + item.DESCCD + ') </div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#PersonalHistList").append(AppendContentList);
        $("#PersonalHistoryListMainDiv").show();
    }

    function GetAllPersonalHistList(PersonalHistNewcode, PersonalHistNewText) {
        //debugger;
        startLoading("Loading", "loading-Personalhist-Search-List")
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMainAddicList",
            async: true,
            data: {},
            success: function (result) {
                var PersonalhistListData = [];
                if (result.length > 0) {
                    PersonalhistListData = result;
                }
                else {
                    ToastMsg(result.Result, "error");
                }

                FilterPersonalHistoryData(PersonalhistListData, PersonalHistNewcode);
                stopLoading("loading-Personalhist-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Personalhist-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Personal History Data list */
    function FilterPersonalHistoryData(PersonalhistListData, PersonalHistNewcode) {
        //debugger;
        var FilterPerHistList = PersonalhistListData;
        if (PersonalHistNewcode != "") {
            FilterPerHistList = PersonalhistListData.filter(item => item.DESCCD == PersonalHistNewcode);
        }
        BindSearchListForPersonalHistory(FilterPerHistList);
        if (PersonalHistNewcode && PersonalHistNewcode !== "") {
            var $first = $("#PersonalHistList .personalhist-row").first();
            if ($first.length) {
                $first.trigger("click");
                //if (HistoryObj != undefined && HistoryObj != null) {
                //    Global_Personal_History_Grid.updateRow(PersonalHistNewcode, {
                //        //code: HistoryObj.code, name: HistoryObj.name, no: HistoryObj.no,
                //        //type: HistoryObj.type, remark: HistoryObj.remark, SetUpYn: HistoryObj.SetUpYn
                //    });
                //}
            }
        }
    }

    //Filter in HTML Search
    function FilterBindedSearchListForPersonalHistory() {
        //debugger;
        var SearchTxt = $("#PersonalHistorySearch").val().toLowerCase();
        var FlagForCallAllPersonalHistList = true;
        if (SearchTxt.length >= 3) {
            $("#PersonalHistList .personalhist-row").each(function () {
                var name = $(this).data("name").toLowerCase();
                var code = $(this).data("code").toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    FlagForCallAllPersonalHistList = false;
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        //if (FlagForCallAllPersonalHistList == true)
        //    GetAllComplaintsList($("#complaintSearch").val(), "");
    }
    


    function SaveOtherPersonalHistoryRemarks()
    {
        let value = $('#Remarks_Freetext').val();
        //if (value) 
            AddFreeHistory(value, 'P');
    }
</script>


<div class="container-fluid" id="PersonalHistory">

    <%-- Free Text Div  --%>
   <%--<div class="container-fluid shadow-sm mb-2 py-2">
       <h6 class="fw-bold">Other Personal History</h6>
       <textarea class="form-control mb-2" id="Remarks_Freetext" name="PersonalHistory_Freetext" style="height: auto; overflow: hidden; resize: none;"></textarea>
       <div class="d-flex justify-content-end">
           <button id="addFreeTextFamilyBtn" class="btn btn-secondary cursor-pointer px-2 py-1 rounded text-white" type="button">Save Remarks</button>
       </div>
   </div>--%>

    <div class="d-flex justify-content-between mb-3 align-items-start" id="PersonalHistory_RemarksSection">
         <h6 class="fw-bold me-5">Other Personal History</h6>
        <div class="position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <button class="btn btn btn-success fw-bold" id="SavePersonalHistory"><i class="fa fa-save" style="font-size: 15px;"></i><span style="padding: 0px 5px; font-size: 15px;">Save</span></button>
            </div>
        </div>
    </div>
    <textarea class="form-control mb-2 TextAreaBorder" id="Remarks_Freetext" name="PersonalHistory_Freetext" style="height: auto; overflow: hidden; resize: none;"></textarea>
     
   <div id="PersonalHistory_ListSection">

       <%-- Header Section --%>
       <h6 class="fw-bold" style="padding: 15px 0px;">Personal History List</h6>
       <div class="d-flex justify-content-between mb-3 align-items-start">
          <%-- <button
               type="button"
               class="btn btn-sm btn-primary "
               onclick="addNewRow();">

               <i class="fa fa-solid fa-plus"></i>
               Add Row
           </button>--%>
           <div class="flex-grow-1 position-relative  ms-5">
               <div class="input-group input-group-sm w-100">
                   <input type="text" id="PersonalHistorySearch" class="form-control" placeholder="Search Addiction (Enter Atleast 3 Chars)" onclick="GetFrequentPersonalHistoryList()" oninput="FilterBindedSearchListForPersonalHistory()">
                   <button class="btn btn-outline-success" id="PersonalHistoryAdd" onclick="OpenPopupForNewItem('Personal History' , 'PersonalHistory')"><i class="fa fa-plus"></i></button>
               </div>
               <div id="PersonalHistoryListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                   <div id="PersonalHistList" class="list-group w-100"></div>
                   <div id='loading-Personalhist-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
               </div>
           </div>
       </div>

         <%-- Grid Control --%>
        <div>
            <div id="PersonalHistoryGrid"></div>
            <div class="d-none justify-content-center align-content-center pt-3">
                <button onclick="savePersonalHistoryService();" type="button" class="btn btn-success rounded px-4 py-1 custom-save-class d-none">Save</button>
            </div>
        </div>

   </div>

</div>


