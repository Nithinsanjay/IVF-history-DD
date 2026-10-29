<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script type="text/javascript">
    var Global_Personal_MedicalHistory_Grid;
    var GlobalDiseaseList;

    $(document).ready(function () {
        PersonalMedicalHistoryGridInit();


        $('#SavePersonalMedicalHistory').click(function () {
            SaveOtherPersonalMedicalHistoryRemarks();
            savePersonalMedicalHistoryService();
        });

        $(document).off("click.personalMedicalHist", ".personalmedicalhist-row")
            .on("click.personalMedicalHist", ".personalmedicalhist-row", function () {
            //debugger;
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = Global_Personal_MedicalHistory_Grid.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].PersonalMedicalHistCode === code) {
                    ToastMsg("Medical history already added", "warning");
                    $("#PersonalMedicalHistoryListMainDiv").hide();
                    return;
                }
            }
            Global_Personal_MedicalHistory_Grid.addRow({
                act: '<i class="fa fa-trash text-danger"></i>',
                PersonalMedicalHistCode: code,
                PERSONALMEDHISTORY: name,
                PERMEDHISTDURNO: "",
                PERMEDHISTDURCATG: ""
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("PersonalMedicalHistoryGrid");
            });
            $("#PersonalMedicalHistSearch").val("");
            $("#PersonalMedicalHistoryListMainDiv").hide();
        });
    });
    async function PersonalMedicalHistoryGridInit() {

        GlobalDiseaseList = await PersMedicalHist_getLstDiagnosis();

        Global_Personal_MedicalHistory_Grid = new Tabulator('#PersonalMedicalHistoryGrid', {
            layout: 'fitColumns',
            rowHeight: null,
            height: '350px',
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
                { title: "PersonalMedicalHistoryCode", field: "PersonalMedicalHistCode", visible: false },
                {
                    title: 'Medical History',
                    field: 'PERSONALMEDHISTORY',
                    width: "68%",
                    editable: false,
                    editor: 'list',
                    editorParams: {
                        autocomplete: true,
                        allowEmpty: true,
                        listOnEmpty: true,
                        valuesLookup: false,
                        values: GlobalDiseaseList
                    },
                    formatter: 'lookup',
                    formatterParams: GlobalDiseaseList
                },
                {
                    width: "14%",
                    title: 'Duration No.',
                    field: 'PERMEDHISTDURNO',
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
                            row.PERMEDHISTDURNO,
                            row.PERMEDHISTDURCATG
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");
                        }
                    }
                },
                {
                    width: "14%",
                    title: 'Duration Catgeory',
                    field: 'PERMEDHISTDURCATG',
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
                            row.PERMEDHISTDURNO,
                            row.PERMEDHISTDURCATG
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");

                        }
                    }
                }
            ]
        });

        adjustTableHeight("PersonalMedicalHistoryGrid");
        SetDataForMedicalHist();
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
    //Set data for medical history
    function SetDataForMedicalHist() {
        //debugger;
        getPersonalMedicalHistoryPatService().then(function (result) {
            if (!Array.isArray(result) || result.length === 0) return;

            let gridRows = result[0] || [];
            let remarkstext = result[1] || [];

            let tabulatorData = gridRows.map(function (row) {
                return {
                    PersonalMedicalHistCode:row.MEDCD,
                    PERSONALMEDHISTORY: row.MEDCD,
                    PERMEDHISTDURNO: row.DURATION,
                    PERMEDHISTDURCATG: row.DURTYPE

                }
            });

            if (Global_Personal_MedicalHistory_Grid) {
                Global_Personal_MedicalHistory_Grid.setData(tabulatorData);
            }

            if (remarkstext.length > 0) {
                let remarks = remarkstext[0].MEDHIST || '';
                $('#PersonalMedicalHistRemarks_Freetext').val(remarks);
            }
        });
    }

    //Retrive Saved Data
    function getPersonalMedicalHistoryPatService() {
        //debugger;
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO');
        }
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                data: { strTranNo: tranNo, strMrNo: mrNo  },
                url: '../Clinicalnotes/SetDataForMedical',
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

    //Get List
    function PersMedicalHist_getLstDiagnosis() {
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../Clinicalnotes/GetMainMedicList',
                data: {},
                success: function (response) {
                    console.log('response', response);
                    resolve(PerMedicalprocessDisea(response));
                },
                error: function (xhr, status, error) {

                },
                complete: function () {

                }
            })
        })
    }

    function PerMedicalprocessDisea(response) {
        if (!response || !Array.isArray(response) || response.length === 0) return {};
        let PerMedicalhist_diseaseConstructor = {};
        for (let i = 0; i < response.length; i++) {
            PerMedicalhist_diseaseConstructor[response[i]['DESCCD']] = response[i]['DESC'];
        }
        return PerMedicalhist_diseaseConstructor;
    }

    function getDuration(maxDuration) {
        let PerMedicalhist_durationContructor = {};
        for (let i = 0; i <= maxDuration; i++) {
            PerMedicalhist_durationContructor[i] = [i];
        }
        return PerMedicalhist_durationContructor;
    }

    //TextArea Remarks Section
    function PerMedicalHist_prepareFreeTextData(strText, strTran, strMrNo, strType) {
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
            let dataToSend = PerMedicalHist_prepareFreeTextData(strText, tranNo, mrNo, strType)
            startLoading('Loading');
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../Clinicalnotes/AddFreeHistory',
                data: dataToSend,
                success: function (response) {

                    if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                        ToastMsg("Record Not Inserted.", "info");
                    }
                    else {
                        ToastMsg("Record inserted successfully", "success");
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
    function SaveOtherPersonalMedicalHistoryRemarks()
    {
        let value = $('#PersonalMedicalHistRemarks_Freetext').val();
        if (value) 
            AddFreeHistory(value, 'M');
    }
    //End


    //Medical history list start
    //Get List Data
    function GetFrequentPersonalMedicalHistoryList()
    {
        //debugger;
        //startLoading("Loading", "loading-Personalhist-Search-List")
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMainMedicList",
            async: true,
            data: {},
            success: function (result) {
                var PersonalMedicalhistListData = [];
                if (result.length > 0) {
                    PersonalMedicalhistListData = result;
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                BindSearchListForPersonalMedicalHistory(PersonalMedicalhistListData);
                //stopLoading("loading-Personalhist-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //stopLoading("loading-Personalhist-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    //List Binding Functionality
    function BindSearchListForPersonalMedicalHistory(PersonalMedicalhistListData) {
        var $list = $("#PersonalMedicalHistList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No personal history found</div>';
        if (PersonalMedicalhistListData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < PersonalMedicalhistListData.length; i++) {
                var item = PersonalMedicalhistListData[i];
                var ListOption = '<div class="list-group-item personalmedicalhist-row" data-code="' + item.DESCCD + '" data-name="' + item.DESC + '" style="cursor:pointer;">' + item.DESC + ' (' + item.DESCCD + ') </div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#PersonalMedicalHistList").append(AppendContentList);
        $("#PersonalMedicalHistoryListMainDiv").show();
    }

    //Filter item from list
    //Filter in HTML Search
    function FilterBindedSearchListForPersonalMedicalHistory() {
        //debugger;
        var SearchTxt = $("#PersonalMedicalHistSearch").val().toLowerCase();
        var FlagForCallAllPersonalMedicalHistList = true;
        if (SearchTxt.length >= 2) {
            $("#PersonalMedicalHistList .personalmedicalhist-row").each(function () {
                var name = $(this).data("name").toLowerCase();
                var code = $(this).data("code").toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    FlagForCallAllPersonalMedicalHistList = false;
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        //if (FlagForCallAllPersonalHistList == true)
        //    GetAllComplaintsList($("#complaintSearch").val(), "");
    }

    //Medical history list end
</script>

<script type="text/javascript">
    function ContentForAddNewItemPersonalMedicalHistory() {
        return `
        <div class="mb-3">
          <input id="txtPersonalMedicalHistory" type="text" class="form-control" maxlength="250" autocomplete="off" placeholder="Enter Diseases" tabindex="2" />
        </div>
        `;
    }
    //Footer Content For New Item Complaints
    function FooterContentForAddNewItemPersonalMedicalHistory() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForPersonalMedicalHistory('PersonalMedicalHistory')" tabindex="4">Save</button>
        `;
    }

    //Validation For New Item Personal Medical History
    function ValidationForNewItemPersonalMedicalHist() {
        if ($("#txtPersonalMedicalHistory").val().trim().length === 0) {
            ToastMsg("Enter Diseases", "warning");
            $("#txtPersonalMedicalHistory").focus();
            return false;
        }
        return true;
    }

    //Save New Item For Personal History
    function SaveNewItemForPersonalMedicalHistory() {
        if (ValidationForNewItemPersonalMedicalHist() == true) {
            var medic = $("#txtPersonalMedicalHistory").val().toString().trim().replace(/\s/g, ' ');
            var grpCode = "";
            //startLoading("Loading", "loading-Personalhist-New-Item")
            $.ajax({
                type: "post",
                datatype: "json",
                url: "../clinicalnotes/AddMedical",
                data: { strMedical: medic, strGrpCode: grpCode },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        var PersonalMedicalHistNewcode = (response.match(/code\s+(\d+)/i) || ["", ""])[1];
                        var PersonalMedicalHistNewText = $("#txtPersonalMedicalHistory").val();
                        GetAllPersonalMedicalHistList(PersonalMedicalHistNewcode, PersonalMedicalHistNewText);
                        closeAddNewItemPopup('PersonalMedicalHistory');
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

    function GetAllPersonalMedicalHistList(PersonalMedicalHistNewcode, PersonalMedicalHistNewText) {
        //debugger;
        //startLoading("Loading", "loading-Personalhist-Search-List")
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMainMedicList",
            async: true,
            data: {},
            success: function (result) {
                var PersonalMedicalhistListData = [];
                if (result.length > 0) {
                    PersonalMedicalhistListData = result;
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                FilterPersonalMedicalHistoryData(PersonalMedicalhistListData, PersonalMedicalHistNewcode);
                //stopLoading("loading-Personalhist-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //stopLoading("loading-Personalhist-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Personal Medical History Data list */
    function FilterPersonalMedicalHistoryData(PersonalMedicalhistListData, PersonalMedicalHistNewcode) {
        //debugger;
        var FilterPerMedicalHistList = PersonalMedicalhistListData;
        if (PersonalMedicalHistNewcode != "") {
            FilterPerMedicalHistList = PersonalMedicalhistListData.filter(item => item.DESCCD == PersonalMedicalHistNewcode);
        }
        BindSearchListForPersonalMedicalHistory(FilterPerMedicalHistList);
        if (PersonalMedicalHistNewcode && PersonalMedicalHistNewcode !== "") {
            var $first = $("#PersonalMedicalHistList .personalmedicalhist-row").first();
            if ($first.length) {
                $first.trigger("click");
                //if (HistoryObj != undefined && HistoryObj != null) {
                //    Global_Personal_MedicalHistory_Grid.updateRow(PersonalMedicalHistNewcode, {
                //        //code: HistoryObj.code, name: HistoryObj.name, no: HistoryObj.no,
                //        //type: HistoryObj.type, remark: HistoryObj.remark, SetUpYn: HistoryObj.SetUpYn
                //    });
                //}
            }
        }
    }

    //Save All Personal Medical History Data
    function savePersonalMedicalHistoryService() {
        //debugger;
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../clinicalnotes/SaveMedical',
                data: preparePersonalMedicalHistoryData(),
                success: function (response) {
                    // console.log('respoonse', response);
                    if (resolve && response === true) {
                        ToastMsg('Data has been saved successfully.', 'success');
                        PatHistoryTab();//priyanka 08/04/2026
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

    function preparePersonalMedicalHistoryData() {
        //debugger;
        let data = Global_Personal_MedicalHistory_Grid.getData();
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO');
        }
        let remarksFreeText = $('#PersonalMedicalHistRemarks_Freetext').val();
        let dataToSend = [];
        for (let i = 0; i < data.length; i++) {

            if (!data[i]['PERMEDHISTDURNO']) {
                ToastMsg("Select Duration  ");
                return false;
            }

            if (!data[i]['PERMEDHISTDURCATG']) {
                ToastMsg("Select Duration Category");
                return false;
            }
            if (!validateDurationWithAge(
                data[i]['PERMEDHISTDURNO'],
                data[i]['PERMEDHISTDURCATG']
            )) {
                ToastMsg("Duration cannot exceed patient age");
                return false;
            }

            let obj = {
                MRNO:mrNo,
                MEDCD: data[i]['PersonalMedicalHistCode'],
                DURATION: data[i]['PERMEDHISTDURNO'],
                DURTYPE: data[i]['PERMEDHISTDURCATG']
            };
            dataToSend.push(obj);
        }
        let finalDataToSend = {
            strMedic: JSON.stringify(dataToSend),
            strMRNO: mrNo,
            strTranNo: tranNo
        }
        return finalDataToSend;
    }
    //End
</script>

<div class="container-fluid" id="PersonalHistory">
    <div class="d-flex justify-content-between mb-3 align-items-start" id="PersonalMedicalHistory_RemarksSection">
         <h6 class="fw-bold me-5">Other Medical History</h6>
        <div class="position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <button class="btn btn btn-success fw-bold" id="SavePersonalMedicalHistory"><i class="fa fa-save" style="font-size: 15px;"></i><span style="padding: 0px 5px; font-size: 15px;">Save</span></button>
            </div>
        </div>
    </div>
    <textarea class="form-control mb-2 TextAreaBorder" id="PersonalMedicalHistRemarks_Freetext" name="PersonalMedicalHistory_Freetext" style="height: auto; overflow: hidden; resize: none;"></textarea>
     
   <div id="PersonalMedicalHistory_ListSection">

       <%-- Header Section --%>
       <h6 class="fw-bold" style="padding: 15px 0px;">Medical History List</h6>
       <div class="d-flex justify-content-between mb-3 align-items-start">
           <div class="flex-grow-1 position-relative  ms-5">
               <div class="input-group input-group-sm w-100">
                   <input type="text" id="PersonalMedicalHistSearch" class="form-control" placeholder="Search Diseases" onclick="GetFrequentPersonalMedicalHistoryList()" oninput="FilterBindedSearchListForPersonalMedicalHistory()">
                   <button class="btn btn-outline-success" id="PersonalMedicalHistoryAdd" onclick="OpenPopupForNewItem('Medical History' , 'PersonalMedicalHistory')"><i class="fa fa-plus"></i></button>
               </div>
               <div id="PersonalMedicalHistoryListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                   <div id="PersonalMedicalHistList" class="list-group w-100"></div>
                   <div id='loading-PersonalMedicalhist-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
               </div>
           </div>
       </div>

         <%-- Grid Control --%>
        <div>
            <div id="PersonalMedicalHistoryGrid"></div>
        </div>

   </div>

</div>
