<%--<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>--%>
<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.Clinicalnotes>" %>

<script type="text/javascript">
    var Global_OPDPatAllergy_History_Grid;
    //debugger;
     <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var AllergyTypeList = '<%:Html.Raw(Samp.Serialize(ViewBag.AllergyTypeLst))%>';
    AllergyTypeList = JSON.parse(AllergyTypeList);
    // Convert to Tabulator format
    var AllergyTypeLookup = AllergyTypeList.map(function (x) {
        return {
            value: x.Value,
            label: x.Text
        };
    });
    // Convert array to object for Tabulator formatter
    var AllergyTypeLookupMap = {};
    AllergyTypeLookup.forEach(function(x) {
        AllergyTypeLookupMap[x.value] = x.label;
    });

    var AllergyList = [];
    var AllergyListLookup;
    var GlobalDisease;

    $(document).ready(function () {
        GetAllergyList();
        OPDPatAllergyHistoryGridInit();
        $('#SaveOPDPatAllergyHistory').click(function () {
            saveOPDPatAllergyHistoryService();
        });
       
    });

    async function OPDPatAllergyHistoryGridInit() {
        //debugger;
        //GlobalDisease = await getLstDiagnosis();

        Global_OPDPatAllergy_History_Grid = new Tabulator('#OPDPatAllergyHistoryGrid', {
            layout: 'fitColumns',
            rowHeight: null,
            height: '350px',
            data: [],
            columns: [
                {
                    title: '',
                    field: "act",
                    hozAlign: 'center',
                    headerSort: false,
                    width: 40,

                    titleFormatter: function () {
                        return '<div style="display:flex; justify-content:center; align-items:center; width:100%; height:100%;padding: 5px;">' +
                               '<i class="fa fa-plus" style="color:white; cursor:pointer;" title="Add Row"></i>' +
                               '</div>';
                    },

                    headerClick: function (e, column) {
                        Global_OPDPatAllergy_History_Grid.addRow({
                            OPDPATALLERGYTYPE: "",
                            OPDPATALLERGYDESCCD: "",
                            OPDPATALLERGYDESC: "",
                            OPDPATALLERGYDURNO: "",
                            OPDPATALLERGYDURCATG: "",
                            OPDPATAllERGYREMARK: ""
                        }, false);

                        adjustTableHeight("OPDPatAllergyHistoryGrid");
                    },

                    formatter: function () {
                        return '<div style="display:flex; justify-content:center;">' +
                               '<i class="fa fa-trash" style="color:red; cursor:pointer;"></i>' +
                               '</div>';
                    },

                    cellClick: function (e, cell) {
                        cell.getRow().delete();
                    }
                },

                {
                    title: 'Allergy Type',
                    field: 'OPDPATALLERGYTYPE',
                    width: "10%",
                    //editable: false,
                    editor: 'list',
                    editorParams: {
                        autocomplete: true,
                        allowEmpty: true,
                        listOnEmpty: true,
                        valuesLookup: false,
                        values: AllergyTypeLookup
                    },
                    formatter: 'lookup',
                    formatterParams: AllergyTypeLookupMap,
                    cellEdited: function (cell) {
                        //debugger;
                        var row = cell.getRow();
                        row.update({
                            OPDPATALLERGYDESC: "",
                            OPDPATALLERGYDESCCD: ""
                        });
                    }
                },

                { title: "Allergy/Description Code", field: "OPDPATALLERGYDESCCD", visible: false },
                {
                    title: 'Allergies / Description',
                    field: 'OPDPATALLERGYDESC',
                    width: "20%",
                    editor: 'list',
                    editable: true,

                    editorParams: function (cell) {
                        //debugger;
                        var rowData = cell.getRow().getData();
                        var type = rowData.OPDPATALLERGYTYPE;

                        return {
                            autocomplete: true,
                            allowEmpty: true,
                            listOnEmpty: true,
                            values: getAllergiesByType(type)
                        };
                    },

                    formatter: function (cell) {
                        //debugger;
                        var code = cell.getRow().getData().OPDPATALLERGYDESCCD;
                        var item = AllergyList.find(x => x.CODE === code);
                        return item ? item.TEXT : "";
                    },

                    cellEdited: function (cell) {
                        //debugger;
                        var selectedCode = cell.getValue();
                        var row = cell.getRow();

                        var item = AllergyList.find(x => x.CODE === selectedCode);
                        if (item) {
                            row.update({
                                OPDPATALLERGYDESC: item.TEXT,
                                OPDPATALLERGYDESCCD: item.CODE
                            });
                        }
                    }
                },
               

                {
                    width: "14%",
                    title: 'Duration No.',
                    field: 'OPDPATALLERGYDURNO',
                    editor: 'list',
                    editorParams: {
                        autocomplete: true,
                        allowEmpty: true,
                        listOnEmpty: true,
                        valuesLookup: true,
                        values: getDuration(85)
                    },
                    cellEdited: function (cell) {

                        var row = cell.getRow().getData();

                        if (!validateDurationWithAge(
                            row.OPDPATALLERGYDURNO,
                            row.OPDPATALLERGYDURCATG
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");
                        }
                    }
                },
                {
                    width: "14%",
                    title: 'Duration Catgeory',
                    field: 'OPDPATALLERGYDURCATG',
                    editor: 'list',
                    editorParams: {
                        autocomplete: true,
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

                        if (!validateDurationWithAge(
                            row.OPDPATALLERGYDURNO,
                            row.OPDPATALLERGYDURCATG
                        )) {
                            ToastMsg("Duration cannot exceed patient age", "warning");
                            cell.setValue("");

                        }
                    }
                },
                {
                    title: "Remark / Reaction",
                    field: "OPDPATAllERGYREMARK",
                    formatter: "textarea",
                    editor: "textarea",
                    editorParams: {
                        elementAttributes: {
                            maxlength: "500",
                        },
                        verticalNavigation: "editor",
                        shiftEnterSubmit: true,
                    },
                    cssClass: "TabTextArea"
                },
            ]
        });
    
        adjustTableHeight("OPDPatAllergyHistoryGrid");
        SetDataForAllergy();
    }

    function validateDurationWithAge(duration, category) {

        //var ageStr = sessionStorage.getItem("MODULE_FLAG") == "IPD" ? sessionStorage.getItem("IPPatAge") : sessionStorage.getItem("PatAge");
        //var age = parseInt(ageStr) || 0;

        var OPPatage = sessionStorage.getItem("PatAge");
        var IPPatage = sessionStorage.getItem("IPPatAge");
        var PACPatage = sessionStorage.getItem("PACPatAge");

        var ageStr = OPPatage || IPPatage || PACPatage || "";
        var age = parseInt(ageStr, 10) || 0;
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
    function getDuration(maxDuration) {
        let OPDPatAllergy_durationContructor = {};
        for (let i = 0; i <= maxDuration; i++) {
            OPDPatAllergy_durationContructor[i] = [i];
        }
        return OPDPatAllergy_durationContructor;
    }

    function GetAllergyList() {
        //debugger;
        //startLoading("Loading", "loading-Personalhist-Search-List")
        $.ajax({
            type: "post",
            datatype: "json",
            async: false,
            url: "../Clinicalnotes/GetMainAllergyListdt",
            success: function (response) {
                
                if (response.length > 0) {
                    AllergyList = response;
                }
                else {
                    ToastMsg("No Data Found", "error");
                }
                //stopLoading("loading-Personalhist-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //stopLoading("loading-Personalhist-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }
    function getAllergiesByType(type) {
        //debugger;
        if (!type) return [];

        return AllergyList
            .filter(x => x.TYPE === type && x.STATUS === "A")
            .map(x => ({
                label: x.TEXT,
                value: x.CODE
            }));
    }

    function ContentForAddNewItemOPDPatAllergy() {

        var optionsHtml = AllergyTypeLookup.map(function (item) {
            return `<option value="${item.value}">${item.label}</option>`;
        }).join('');

        return `
        <div class="mb-3">
            <select id="ddlAllergyType" class="form-control" tabindex="3">
                <option value="">-- Select Allergy Type --</option>
        ${optionsHtml}
        </select>
    </div>
    <div class="mb-3">
        <textarea class="form-control mb-2 TextAreaBorder" id="txtOPDPatAllergy" name="OPDPatAllergy_Freetext" style="height: auto; overflow: hidden; resize: none;" placeholder="Enter Allergy"  oninput="autoResizeTextareaForSinglePage(this)"></textarea>
    </div>
    `;
    }

    //Footer Content For New Item Complaints
    function FooterContentForAddNewItemOPDPatAllergy() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForOPDPatAllergy('PersonalHistory')" tabindex="4">Save</button>
        `;
    }

    function ValidationForNewItemOPDPatAllergyHist() {
        if ($("#txtOPDPatAllergy").val().trim().length === 0) {
            ToastMsg("Enter Allergy", "warning");
            $("#txtOPDPatAllergy").focus();
            return false;
        }
        return true;
    }

    //Save New Item For OPD Patient Allergy History
    function SaveNewItemForOPDPatAllergy() {
        //debugger;
        if (ValidationForNewItemOPDPatAllergyHist() == true) {
            var allergy = $("#txtOPDPatAllergy").val().toString().trim().replace(/\s/g, ' ');
            var grpCode = "";
            var Type = $("#ddlAllergyType").val() 
            //startLoading("Loading", "loading-Personalhist-New-Item")
            $.ajax({
                type: "post",
                datatype: "json",
                url: "../clinicalnotes/AddAllergy",
                data: { strMedical: allergy, strGrpCode: grpCode, Type:Type},
                success: function (response) {
                    //debugger;
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        //debugger;
                        var OPDPatAllergyHistNewcode = (response.match(/code\s+(\d+)/i) || ["", ""])[1];
                        var OPDPatAllergyHistNewText = $("#txtOPDPatAllergy").val();
                        GetAllOPDPatAllergyList(OPDPatAllergyHistNewcode, OPDPatAllergyHistNewText,Type);
                        closeAddNewItemPopup('OPDPatAllergyHist');
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

    function GetAllOPDPatAllergyList(OPDPatAllergyHistNewcode, OPDPatAllergyHistNewText,Type) {
        //debugger;
        //startLoading("Loading", "loading-Personalhist-Search-List")
        $.ajax({
            type: "POST",
            url: "../Clinicalnotes/GetMainAllergyListdt",
            async: true,
            data: {},
            success: function (response) {
                AllergyList = [];
                if (response.length > 0) {
                    AllergyList = response;
                }
                else {
                    ToastMsg("No Data Found", "error");
                }

                FilterOPDPatAllergyHistoryData(AllergyList, OPDPatAllergyHistNewcode,Type);
                //stopLoading("loading-Personalhist-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //stopLoading("loading-Personalhist-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Personal History Data list */
    function FilterOPDPatAllergyHistoryData(AllergyList, OPDPatAllergyHistNewcode,Type) {
        //debugger;
        var FilterOPDPatAllergyHistList = AllergyList;
        if (OPDPatAllergyHistNewcode != "") {
            //FilterOPDPatAllergyHistList = AllergyList.filter(item => item.Value == OPDPatAllergyHistNewcode);
            FilterOPDPatAllergyHistList = AllergyList.filter(item =>
                item.CODE == OPDPatAllergyHistNewcode &&
                item.STATUS === "A" &&
                item.TYPE === Type
            );

        }
        BindtabulatorDataForOPDPatAllergy(FilterOPDPatAllergyHistList,Type);
    }


    function BindtabulatorDataForOPDPatAllergy(FilterOPDPatAllergyHistList,Type)
    {
        //debugger;
        Global_OPDPatAllergy_History_Grid.addRow({
            act: '<i class="fa fa-trash text-danger"></i>',
            OPDPATALLERGYTYPE: Type,
            OPDPATALLERGYDESCCD:FilterOPDPatAllergyHistList[0].CODE ,
            OPDPATALLERGYDESC:FilterOPDPatAllergyHistList[0].TEXT,
            OPDPATALLERGYDURNO: "",
            OPDPATALLERGYDURCATG: "",
            OPDPATAllERGYREMARK:""
        }).then(function (row) {
            row.normalizeHeight();
            adjustTableHeight("OPDPatAllergyHistoryGrid");
        });
    }

    function SetDataForAllergy() {
        //debugger;
        getOPDPatAllergyService().then(function (result) {
            if (!Array.isArray(result) || result.length === 0) return;

            //let gridRows = result[0] || [];
            //let remarkstext = result[1] || [];
            let gridRows = result || [];

            let tabulatorData = gridRows.map(function (row) {
                return {
                    OPDPATALLERGYTYPE: row.ALLERGYTYPE,
                    OPDPATALLERGYDESCCD: row.ALLERGYCD,
                    OPDPATALLERGYDESC: row.ALLERGYNM,
                    OPDPATALLERGYDURNO:  row.DURATION,
                    OPDPATALLERGYDURCATG:  row.DURTYPE,
                    OPDPATAllERGYREMARK: row.REMARK

                }
            });

            if (Global_OPDPatAllergy_History_Grid) {
                Global_OPDPatAllergy_History_Grid.setData(tabulatorData);
            }
        });
    }

    function getOPDPatAllergyService() {
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
            url: '../Clinicalnotes/SetDataForAllergy',
            success: function (response) {
                console.log('respopns', response);
                resolve(response[0]);
            },
            error: function (xhr, status, error) {
                reject(false);
            },
            complete: function () {

            }
        });
    })
}


    function saveOPDPatAllergyHistoryService() {
        //debugger;
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'POST',
                datatype: 'json',
                url: '../clinicalnotes/SaveAllergy',
                data: prepareOPDPatAllergyHistoryData(),
                success: function (response) {
                    // console.log('respoonse', response);
                    if (resolve && response.success === true && ("" + response.data).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg('saved successfully.', 'success');
                        PatHistoryTab();//priyanka 08/04/2026
                        if (sessionStorage.getItem("MODULE_FLAG") == "OPD") {
                            LoadAllergyCount();
                        }
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

    function prepareOPDPatAllergyHistoryData() {
        //debugger;
        let data = Global_OPDPatAllergy_History_Grid.getData();
        var tranNo = "";
        var mrNo = GetSessionMRNO();
        if (sessionStorage.getItem("MODULE_FLAG") === "OPD") {
            tranNo = sessionStorage.getItem('PatTRANNO');
        }
        //let remarksFreeText = $('#Remarks_Freetext').val();
        let dataToSend = [];
        for (let i = 0; i < data.length; i++) {

            if (
                !data[i]['OPDPATALLERGYTYPE'] &&
                !data[i]['OPDPATALLERGYDESCCD'] &&
                !data[i]['OPDPATALLERGYDURNO'] &&
                !data[i]['OPDPATALLERGYDURCATG']
            ) {
                continue; 
            }

           
            if (!data[i]['OPDPATALLERGYTYPE']) {
                ToastMsg("Select Allergy Type");
                return false;
            }

            if (!data[i]['OPDPATALLERGYDESCCD']) {
                ToastMsg("Select Allergy/Description");
                return false;
            }

            if (!data[i]['OPDPATALLERGYDURNO']) {
                ToastMsg("Enter Duration No");
                return false;
            }

            if (!data[i]['OPDPATALLERGYDURCATG']) {
                ToastMsg("Select Duration Category");
                return false;
            }
            if (!validateDurationWithAge(
                data[i]['OPDPATALLERGYDURNO'],
                data[i]['OPDPATALLERGYDURCATG']
            )) {
                ToastMsg("Duration cannot exceed patient age");
                return false; 
            }
            let obj = {
                MRNO:mrNo,
                ALLERGYTYPE: data[i]['OPDPATALLERGYTYPE'],
                ALLERGYCD:data[i]['OPDPATALLERGYDESCCD'],
                DURATION: data[i]['OPDPATALLERGYDURNO'],
                DURTYPE: data[i]['OPDPATALLERGYDURCATG'],
                REMARKS:data[i]['OPDPATAllERGYREMARK']
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
</script>

<div class="container-fluid" id="OPDPatAllergy">
  <%--  <div class="d-flex justify-content-between mb-3 align-items-start" id="PersonalHistory_RemarksSection">
         <h6 class="fw-bold me-5">Other Personal History</h6>
        <div class="position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
                <button class="btn btn btn-success fw-bold" id="SavePersonalHistory"><i class="fa fa-save" style="font-size: 15px;"></i><span style="padding: 0px 5px; font-size: 15px;">Save</span></button>
            </div>
        </div>
    </div>
    <textarea class="form-control mb-2" id="Remarks_Freetext" name="PersonalHistory_Freetext" style="height: auto; overflow: hidden; resize: none;"></textarea>
     --%>
   <div id="OPDPatAllergy_ListSection">

       <%-- Header Section --%>
       <div class="d-flex justify-content-between align-items-center mb-3">
           <!-- LEFT TITLE -->
           <h6 class="fw-bold mb-0">Allergy History List</h6>

           <!-- RIGHT BUTTONS -->
           <div class="d-flex gap-2">
               <!-- Added a gap between buttons -->
               <button class="btn btn-outline-success btn-sm"
                   id="OPDPatAllergyAdd"
                   onclick="OpenPopupForNewItem('Patient Allergy History', 'OPDPatAllergyHist')">
                   <i class="fa fa-plus"></i> Add New Allergy
               </button>
               <button class="btn btn-success btn-sm fw-bold" id="SaveOPDPatAllergyHistory">
                   <i class="fa fa-save" style="font-size: 15px;"></i>
                   <span style="padding: 0px 5px; font-size: 15px;">Save</span>
               </button>
           </div>
       </div>


        <%-- Grid Control --%>
        <div>
            <div id="OPDPatAllergyHistoryGrid"></div>
        </div>

   </div>

</div>
