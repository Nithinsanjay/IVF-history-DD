<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>

<style>
    textarea {
        box-sizing: border-box;
    }
</style>

<%-- Investigations Form --%>
<script type="text/javascript">
    var InvestigationListtable;
    var RMOFlagInvestYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINVESTIGATIONYN")%>' == "Y" ? "N" : "Y") : "N";
    var SessionCompInvst = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagInvestYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');
    var selectedInvestigations = [];     //Pournima 15th June 2026
    var Days = 1;    //Pournima 15th June 2026
    $(document).ready(function () {
        $("#btnInvstfitTocontent").on("click", function () {

            fitToContent('Complaints_Freetext');
        });
        $("#btnInvstsetmaxheight").on("click", function () {

            setMaxHeight('Complaints_Freetext');
        });
        // End
        /* Tabulator For Investigations */
        let isPatCompleted = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagInvestYN == "Y" ? true : sessionStorage.getItem("PatCompleted") === "Y";
        InvestigationListtable = new Tabulator("#InvestigationTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "50",
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
                    headerSort: false,
                    editable: function (cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagInvestYN != "Y";
                        },
                        formatter: function (cell) {
                            // Hide delete icon if patient visit is completed
                            if (typeof SessionCompInvst !== 'undefined' && SessionCompInvst === "Y") {
                                return "";
                            }
                            return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                        },
                        hozAlign: "center",
                        cellClick: function (e, cell) {
                            if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagInvestYN != "Y") {
                                cell.getRow().delete();
                            }
                        }
                    },
                    { title: "Code", field: "code", visible: false },
                    {
                        title: "Name",
                        field: "name",
                        editor: false,
                        width: 300,
                        formatter: "textarea",
                        formatterParams: {
                            minHeight: "auto",
                        },
                        cssClass: "wrap-text"
                    },
                    {
                        title: "Duration No",
                        field: "no",
                        width: 120,
                        visible: false,
                        tooltip: true,
                        editor: "list",
                        editable: function (cell) {
                            return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagInvestYN != "Y";
                        },
                        editorParams: function () {
                            let values = [];
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
                            let values = {};
                            for (let i = 0; i <= 30; i++) {
                                values[i] = i.toString();
                            }
                            return values;
                        })
                    },
                    {
                        title: "Duration Category",
                        field: "type",
                        tooltip: true,
                        visible:false,
                        editor: "list",
                        width: 140,
                        editable: function (cell) {
                            // Return true only if PatCompleted is NOT "Y"
                            return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagInvestYN != "Y";
                        },
                        editorParams: function () {
                            let values = [
                                { label: "Days", value: "D" },
                                { label: "Weeks", value: "W" },
                                { label: "Months", value: "M" },
                                { label: "Years", value: "Y" }
                            ];
                            return {
                                values: values,
                                autocomplete: true,    // enable type-ahead search
                                listOnEmpty: true,     // show all options if input empty
                                allowEmpty: false      // prevent empty selection
                            };
                        },
                        formatter: "lookup",
                        formatterParams: (function () {
                            return { "D": "Days", "W": "Weeks", "M": "Months", "Y": "Years" };
                        })
                    },

                    {
                        title: "Remark",
                        field: "remark",
                        formatter: "textarea",
                        editor: "textarea",
                        editable: function (cell) {
                            return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagInvestYN != "Y";
                    },
                    editorParams: {
                        elementAttributes: {
                            maxlength: "500",
                        },
                        verticalNavigation: "editor",
                        shiftEnterSubmit: true,
                    },
                    cssClass: "TabTextArea"
                },
                {
                    title: "SetUpYn",
                    field: "SetUpYn",
                    editor: false,
                    visible: false
                }
            ]
        });

        InvestigationListtable.on("cellEdited", function (cell) {
            cell.getRow().normalizeHeight();
            adjustTableHeight("InvestigationTable");
        });

        InvestigationListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("InvestigationTable");
        });

        InvestigationListtable.on("rowDeleted", function (row) {
            adjustTableHeight("InvestigationTable");
        });

        InvestigationListtable.on("dataLoaded", function () {
            adjustTableHeight("InvestigationTable");
        });

        InvestigationListtable.on("tableBuilt", function () {
            adjustTableHeight("InvestigationTable");
        });

        InvestigationListtable.on("dataChanged", function () {
            adjustTableHeight("InvestigationTable");
        });

        /* Click Event on the Compliant Search List */
        $(document).on("click", ".Investigation-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            PreviousAdvisedInvestigations(code, name);     //Pournima 16th June 2026
        });

        /* Bind Already Saved Investigations */
        SetDataForInvestigations();

        /* Adjust of Height Of Investigations Table */
        adjustTableHeight("InvestigationTable");

        if (sessionStorage.getItem("PatCompleted").toString() === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagInvestYN == "Y") {
            $("#sec-Investigations *").attr("disabled", "disabled");
            $("#Investigations_PrevHistory").removeAttr("disabled");
        }
        else {
            $("#sec-Investigations *").removeAttr("disabled");
        }
    });

    /* Search For Frequent Investigations */
    function GetFrequentInvestigations() {
        var clinicCode = sessionStorage.getItem('ClinicCode');
        startLoading("Loading", "loading-Complaints-Search-List")
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetInvestigationList",
            async: true,
            data: { strTranNo: sessionStorage.getItem("PatTRANNO") },
            success: function (result) {
                var InvestigationsListData = [];
                if (result.Result) {
                    ToastMsg(result.Result, "error");
                }
                else {
                    InvestigationsListData = result || [];
                }
                FilterInvestigationsData(InvestigationsListData, "", "", "");
                stopLoading("loading-Investigations-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Complaints-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }
    /* Search For All Investigations */
    function GetAllInvestigationsList(FilterInvestigationText = "", FilterInvestigationCode = "", HistoryObj = "") {  <%--// Modified Pournima 16th June 2026--%>
        var clinicCode = sessionStorage.getItem('ClinicCode');
        startLoading("Loading", "loading-Investigations-Search-List")
        $.ajax({
            type: "POST",
            async: true,
            url: "../DoctorDesk/GetTestList",
            //data: { testname: FilterInvestigationText, strTranNo: sessionStorage.getItem("PatTRANNO") },
            data: { testname: "", strTranNo: "" }, <%--// Modified Pournima 16th June 2026--%>
            success: function (result) {
                var InvestigationsListData = result || [];
                FilterInvestigationsData(InvestigationsListData, FilterInvestigationText, FilterInvestigationCode, HistoryObj);
                stopLoading("loading-Investigations-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Investigations-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Investigation Data list */
    function FilterInvestigationsData(InvestigationsListData, InvestigationsText, InvestigationsCode, HistoryObj) {
        startLoading("Loading", "loading-Investigations-Search-List")
        var FilterComplList = InvestigationsListData;
        if (InvestigationsCode != "") {
            FilterComplList = InvestigationsListData.filter(item => item.TESTCODE == InvestigationsCode);
        }
        if (InvestigationsText != "") {
            FilterComplList = FilterComplList.filter(item => item.TESTNAME == InvestigationsText);
        }
        if ($("#InvestigationSearch").val() != "") {
            FilterComplList = FilterComplList.filter(item => item.TESTNAME.toLowerCase().indexOf($("#InvestigationSearch").val().toLowerCase()) !== -1);
        }
        BindSearchListForInvestigation(FilterComplList);
        if (InvestigationsCode && InvestigationsCode !== "") {
            var $first = $("#InvestigationList .Investigation-row").first();
            if ($first.length) {
                $first.trigger("click");
                if (HistoryObj != undefined && HistoryObj != null && HistoryObj != "") {
                    InvestigationListtable.updateRow(InvestigationsCode, {
                        code: HistoryObj.code, name: HistoryObj.name, no: HistoryObj.no,
                        type: HistoryObj.type, remark: HistoryObj.remark, SetUpYn: HistoryObj.SetUpYn
                    });
                }
            }
        }
        stopLoading("loading-Investigations-Search-List");
    }

    //Filter in HTML Search
    function FilterBindedSearchListForInvestigation() {
        var FlagForCallAllInvestList = true;
        var SearchTxt = $("#InvestigationSearch").val().toLowerCase();
        $("#InvestigationList .Investigation-row").each(function () {
            var name = $(this).data("name").toLowerCase();
            var code = $(this).data("code").toLowerCase();
            if (SearchTxt == "" || name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                FlagForCallAllInvestList = false;
                $(this).show();
            } else {
                $(this).hide();
            }
        });
        if (FlagForCallAllInvestList == true)
            GetAllInvestigationsList("", "", "");
    }


    //List Binding Functionality
    function BindSearchListForInvestigation(InvestigationsData) {
        var $list = $("#InvestigationList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No Investigations found</div>';
        if (InvestigationsData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < InvestigationsData.length; i++) {
                var item = InvestigationsData[i];
                var ListOption = '<div class="list-group-item Investigation-row" data-code="' + item.TESTCODE + '" data-name="' + item.TESTNAME + '" style="cursor:pointer;">' + item.TESTNAME + '</div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#InvestigationList").append(AppendContentList);
        $("#InvestigationList").show();
        $("#InvestigationListMainDiv").show();
    }

    //Validation Functionality For Save Investigations
    function ValidationForInvestigations(Type) {
        if (Type == "C") {
            var tableData = InvestigationListtable.getData();
            for (var i = 0; i < tableData.length; i++) {
            }
            return true;
        }
        return true;
    }

    function HASDataInInvestigation() {//priyanka 16/04/2026
        var InvestTblData = InvestigationListtable.getData();
        var InvestFreeText = $("#Investigations_Freetext").val();
        if (((InvestTblData.length === 0) && (InvestFreeText === "" || InvestFreeText === null))) {
            return false;
        }
        else {
            return true;
        }
    }

    //Save Functionality For Investigations 
    function SaveForInvestigations(DataSaveObj, Type) {
        var InvestArr = [];
        var tableData = InvestigationListtable.getData();
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
                TESTCODE: rows[i].code,
                TESTNAME: rows[i].name,
                DURATION: rows[i].no,
                DURTYPE: rows[i].type,
                REMARKS: "" + rows[i].remark,
                SETUPYN: rows[i].SetUpYn, //Pending
            };
            InvestArr.push(a);
        }
        DataSaveObj.StrInvestigation = JSON.stringify(InvestArr);
        DataSaveObj.FreeInvestigation = $("#Investigations_Freetext").val();
    }

    //Binding Functionality For Investigations 
    function SetDataForInvestigations() {
        var tranNo = sessionStorage.getItem('PatTRANNO');
        if (!tranNo) return;
        startLoading("Loading", "loading-Investigations");
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/SetDataForInvestigation",
            datatype: "json",
            data: { strTranNo: tranNo },
            success: function (data) {
                if (!data || !data[0] || data[0].length === 0) {
                    stopLoading("loading-Investigations");
                }
                else {
                    var existingRows = InvestigationListtable.getData();
                    data[0].forEach(function (item) {
                        var exists = existingRows.some(function (r) {
                            return r.code === item.DESCCD;
                        });
                        if (exists) return;
                        InvestigationListtable.addRow({
                            act: "",
                            code: item.TESTCODE,
                            name: item.TESTNAME,
                            no: item.DURATION || "",
                            type: item.DURTYPE || "",
                            remark: (item.REMARKS || "").trim(),
                            SetUpYn: item.SETUPYN || ""
                        });
                    });
                }

                if (data && data[1] && data[1][0] && data[1][0].FreeInvestigation) {
                    $("#Investigations_Freetext").val(data[1][0].FreeInvestigation);
                    autoResizeTextareaForSinglePage(document.getElementById('Investigations_Freetext'));
                }
                stopLoading("loading-Investigations");
            },
            error: function (xhr, status) {
                ToastMsg(status, "error");
                stopLoading("loading-Investigations");
            }
        });
   }


   //Pournima 15th June 2026
   function GetInvestigationAdviceOrderStatus(mrnNo, frmDate, toDate, doctCode, callback) {
       $.ajax({
           type: "GET",
           url: "../DoctorDesk/GetInvestigationAdviceOrderStatus",
           data: {
               MrnNo: mrnNo,
               FrmDate: frmDate,
               ToDate: toDate,
               DoctCode: doctCode
           },
           dataType: "json",
           success: function (response) {
               if (typeof callback === "function") {
                   callback(response);
               }
           },
           error: function (xhr) {
               ToastMsg("Error fetching investigation status", "error");
           }
       });
   }


   function getDynamicDateRange(daysBack) {
       var today = new Date();
       var fromDate = new Date();
       fromDate.setDate(today.getDate() - daysBack);
       function formatDDMMYYYY(d) {
           var day = ("0" + d.getDate()).slice(-2);
           var month = ("0" + (d.getMonth() + 1)).slice(-2);
           var year = d.getFullYear();

           return day + "/" + month + "/" + year;
       }
       return {
           fromDate: formatDDMMYYYY(fromDate),
           toDate: formatDDMMYYYY(today)
       };
   }

   //Pournima 16th June 2026
   function PreviousAdvisedInvestigations(testCode, testName) {

       var mrnNo = sessionStorage.getItem('PatMRNO');
       var doctCode = "";<%--  '<%:Session["gDoctCode"]%>';--%>

       var range = getDynamicDateRange(Days);
       var frmDate = range.fromDate;
       var toDate = range.toDate;

       if (selectedInvestigations.includes(testCode)) {
           ToastMsg("This test is already selected", "info");
           return;
       }

       GetInvestigationAdviceOrderStatus(mrnNo, frmDate, toDate, doctCode, function (data) {

           if (!Array.isArray(data)) {
               selectedInvestigations.push(testCode);
               AddInvestigationToGrid(testCode, testName);
               return;
           }

           var match = data.find(function (x) {
               return x.TESTNAME === testName;
           });

           if (match) {

               if (match.TESTSTATUS === "V") {

                   selectedInvestigations.push(testCode);
                   AddInvestigationToGrid(testCode, testName);

               }
               else {

                   var msg = "";

                   if (match.TESTSTATUS != "") {
                       msg = "This test is already in " + match.TESTSTATUS + " stage. Do you want to continue?";
                   }
                   else {
                       msg = "This test is already advised. Do you want to continue?";
                   }
                   if (msg != "") {
                       var YFunc = "YesAddinvestigation('" + testCode + "','" + testName +"')";
                       openPopupDynamic("Confirmation", msg, [
                           { text: "Yes", class: "btn btn-yes", action: YFunc },
                           { text: "No", class: "btn btn-no", action: "closePopup()" }
                       ]);
                   }
                   //if (confirm(msg)) {
                   //    selectedInvestigations.push(testCode);
                   //    AddInvestigationToGrid(testCode, testName);
                   //}
               }
           }
           else {

               selectedInvestigations.push(testCode);
               AddInvestigationToGrid(testCode, testName);

           }
       });
    }

    function YesAddinvestigation(testCode, testName) {
        selectedInvestigations.push(testCode);
        AddInvestigationToGrid(testCode, testName);
    }

   function AddInvestigationToGrid(code, name) {

       var rows = InvestigationListtable.getData();

       for (var i = 0; i < rows.length; i++) {

           if (rows[i].code === code) {

               ToastMsg("Investigation already added", "warning");
               $("#InvestigationListMainDiv").hide();
               return;
           }
       }

       InvestigationListtable.addRow({
           act: '<i class="fa fa-trash text-danger"></i>',
           code: code,
           name: name,
           no: 0,
           type: "D",
           remark: "",
           SetUpYn: ""
       }).then(function (row) {

           row.normalizeHeight();
           adjustTableHeight("InvestigationTable");

       });
       selectedInvestigations = [];
       $("#InvestigationSearch").val("");
       $("#InvestigationListMainDiv").hide();
   }
   // *****************************************************
</script>

<%-- History For Investigations --%>
<script type="text/javascript">


 function InvestigationDurationTypeSelect(type, duration) {
     var strDay = "Day";
     puralString = "";
     if (Number(duration) > 1) {
         puralString = "s"
     }

     switch (type) {

         case "D":
             strDay = "Day" + puralString
             break;
         case "W":
             strDay = "Week" + puralString;
             break;
         case "M":
             strDay = "Month" + puralString
             break;
         case "Y":
             strDay = "Year" + puralString
             break;
         default:
             strDay = "Day" + puralString
             break;
     }
     return strDay;
 }

function HistPopInvestigationsTemp(AllHistoryData, ContentID) {

    var existingRows =
        InvestigationListtable.getData();

    var ConsultLst =
        AllHistoryData[0] || [];

    var InvestigationLst =
        AllHistoryData[6] || [];

    var FreeInvestigationLst =
        AllHistoryData[11] || [];

    var isVisitCompleted =
        (typeof SessionCompInvst !== 'undefined' &&
            SessionCompInvst === "Y");

    var investigationFreeText =
        $("#Investigations_Freetext").val() || "";

    var $container =
        $('<div class="history-list-wrapper"></div>');

    for (var i = 0; i < ConsultLst.length; i++) {

        var consult = ConsultLst[i];

        var ConsultNo =
            consult.TRANNO;

        if (!ConsultNo ||
            ConsultNo == sessionStorage.getItem("PatTRANNO"))
            continue;


        var filtered =
            InvestigationLst.filter(
                c => c.TRANNO === ConsultNo
            );

        var filteredFreeInvestigation =
            FreeInvestigationLst.filter(
                f => f.TRANNO === ConsultNo
            );

        if (
            filtered.length === 0 &&
            filteredFreeInvestigation.length === 0
        )
            continue;


        var allCopied =
            filtered.every(c =>
                existingRows.some(
                    r => r.code === c.TESTCODE
                )
            );

        var allFreeInvestigationCopied =
            filteredFreeInvestigation.every(f =>
                investigationFreeText.includes(
                    f.FREEINVESTIGATION || ""
                )
            );



        var docName =
            consult.DOCTNAME || "";

        var specName =
            consult.SPECNAME
                ? " (" + consult.SPECNAME + ")"
                : "";

        var dateInfo =
            consult.TRANDATE + " " +
            ConvertTo12Hour(
                "O",
                consult.TRANTIME
            );



        var $panel =
            $('<div class="History-panel mb-3"></div>');


        var $panelHead =
            $('<div class="History-header d-flex justify-content-between align-items-center p-3"></div>');

        var $leftDiv =
            $('<div class="d-flex align-items-center flex-grow-1"></div>');

        var docText =
            (docName ? "Dr. " + docName : "") +
            specName;

        var $docDiv =
            $('<div class="History-doctor"></div>')
                .text(docText);

        var $dateDiv =
            $('<div class="History-date mt-1"></div>')
                .text(dateInfo);

        $leftDiv.append(
            $('<div></div>').append(
                $docDiv,
                $dateDiv
            )
        );


        var $rightDiv =
            $('<div class="d-flex align-items-center"></div>');

        var $copyDiv = $();

        if (!isVisitCompleted) {

            if (
                (filtered.length === 0 || allCopied) &&
                (filteredFreeInvestigation.length === 0 || allFreeInvestigationCopied)
            ) {

                $copyDiv = $(`
                <button class="btn btn-sm btn-outline-success"
                        style="background:#dbfdf8;"
                        disabled>

                    <i class="fa fa-check text-success"></i>

                </button>
            `);

            } else {

                $copyDiv = $(`
                <button class="btn btn-sm btn-outline-primary copy-all-btn"
                        data-consult="${ConsultNo}">

                    <i class="fa fa-copy"></i> Copy All

                </button>
            `);
            }
        }

        $rightDiv.append($copyDiv);

        $panelHead.append(
            $leftDiv,
            $rightDiv
        );


        var $panelBody =
            $('<div class="History-body p-2"></div>');


        if (filtered.length > 0) {

            var investigationHtml = `

            <div class="History-section">

                <label>
                    <b>Investigations</b>
                </label>

                <ul class="list-unstyled mb-0">
        `;

            for (var k = 0; k < filtered.length; k++) {

                var itemText =
                    filtered[k].TESTNAME;

                var itemCode =
                    filtered[k].TESTCODE;

                var remarks =
                    (filtered[k].REMARK || "").trim();

                var SetupYN =
                    filtered[k].SETUPYN || "";

                var exists =
                    existingRows.some(
                        r => r.code === itemCode
                    );

                var sentence =
                    itemText;

                if (remarks !== "") {

                    sentence += " - " + remarks;
                }

                var actionBtn = "";

                if (exists) {

                    actionBtn = `
                    <span class="text-success mr-2"
                          title="Already Added">

                        <i class="fa fa-check-circle"></i>

                    </span>
                `;
                }
                else if (!isVisitCompleted) {

                    actionBtn = `
                    <button class="btn btn-link btn-sm p-0 copy-row-btn"
                            title="Copy to List">

                        <i class="fa fa-clone text-primary"></i>

                    </button>
                `;
                }

                investigationHtml += `

                <li class="History-row
                           d-flex
                           justify-content-between
                           align-items-center
                           p-2
                           border-bottom">

                    <div class="flex-grow-1">

                        ${sentence}

                        <span class="History-row-text History-row-Hide">
                            ${itemText}
                        </span>

                        <span class="History-row-Code History-row-Hide">
                            ${itemCode}
                        </span>

                        <span class="History-row-Remark History-row-Hide">
                            ${remarks}
                        </span>

                        <span class="History-row-SetupYN History-row-Hide">
                            ${SetupYN}
                        </span>

                    </div>

                    ${actionBtn}

                </li>
            `;
            }

            investigationHtml += `
                </ul>
            </div>
        `;

            $panelBody.append(investigationHtml);
        }


        if (filteredFreeInvestigation.length > 0) {

            var freeHtml = `

            <hr style="margin:0;">

            <div class="History-section mt-2">

                <label>
                    <b>Other Investigations</b>
                </label>

                <ul class="list-unstyled mb-0">
        `;

            for (var j = 0; j < filteredFreeInvestigation.length; j++) {

                var freeText =
                    filteredFreeInvestigation[j]
                        .FREEINVESTIGATION || "";

                var freeExists =
                    investigationFreeText.includes(
                        freeText
                    );

                var freeActionBtn = "";

                if (freeExists) {

                    freeActionBtn = `
                    <span class="text-success mr-2"
                          title="Already Added">

                        <i class="fa fa-check-circle"></i>

                    </span>
                `;
                }
                else if (!isVisitCompleted) {

                    freeActionBtn = `
                    <button class="btn btn-link btn-sm p-0 copy-freeinvestigation-btn"
                            title="Copy">

                        <i class="fa fa-clone text-primary"></i>

                    </button>
                `;
                }

                freeHtml += `

                <li class="History-FreeInvestigationRow
                           d-flex
                           justify-content-between
                           align-items-center
                           p-2
                           border-bottom">

                    <div class="History-FreeInvestigationText flex-grow-1">

                        ${freeText}

                    </div>

                    ${freeActionBtn}

                </li>
            `;
            }

            freeHtml += `
                </ul>
            </div>
        `;

            $panelBody.append(freeHtml);
        }

    

        $panel.append(
            $panelHead,
            $panelBody
        );

        $container.append($panel);
    }

    if (ContentID) {

        $('#' + ContentID).html($container);
    }

    return $container.html();
}

function CopyFuncInvestigations() {

    $(".copy-row-btn")
        .off("click")
        .on("click", function () {

            var $btn = $(this);

            var $li =
                $btn.closest("li");

            var text =
                $li.find(".History-row-text")
                    .text()
                    .trim();

            var Code =
                $li.find(".History-row-Code")
                    .text()
                    .trim();

            var alreadyExists =
                InvestigationListtable.getData()
                    .some(r => r.code === Code);

            if (alreadyExists) {

                $btn.html(
                    '<i class="fa fa-check text-success"></i>'
                )
                    .removeClass("copy-row-btn")
                    .prop("disabled", true);

                return;
            }

            InvestigationListtable.addRow({
                act: "",
                code: Code,
                name: text,
                no: "0",
                type: "D",
                remark: $li.find(".History-row-Remark")
                    .text()
                    .trim(),
                SetUpYn: $li.find(".History-row-SetupYN")
                    .text()
                    .trim()
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("InvestigationTable");
            });

            $(".History-row-Code").each(function () {

                if ($(this).text().trim() === Code) {

                    var $sameRow =
                        $(this).closest("li");

                    var $sameBtn =
                        $sameRow.find(".copy-row-btn");

                    if ($sameBtn.length > 0) {

                        $sameBtn.html(
                            '<i class="fa fa-check text-success"></i>'
                        )
                            .removeClass("copy-row-btn")
                            .prop("disabled", true);
                    }
                }
            });

            CheckAndUpdateCopyAllButtonInvestigation(
                $btn.closest(".History-panel")
            );
        });


    $(".copy-freeinvestigation-btn")
        .off("click")
        .on("click", function () {

            var $btn = $(this);

            var text =
                $btn.closest(".History-FreeInvestigationRow")
                    .find(".History-FreeInvestigationText")
                    .text()
                    .trim();

            var existingText =
                ($("#Investigations_Freetext").val() || "")
                    .trim();


            if (existingText !== "") {

                if (!existingText.includes(text)) {

                    $("#Investigations_Freetext")
                        .val(existingText + "\n" + text);
                }
            }
            else {

                $("#Investigations_Freetext")
                    .val(text);
            }


            if (typeof fitToContent === "function") {

                fitToContent(
                    'Investigations_Freetext'
                );
            }

            $btn.html(
                '<i class="fa fa-check text-success"></i>'
            )
                .removeClass("copy-freeinvestigation-btn")
                .prop("disabled", true);


            CheckAndUpdateCopyAllButtonInvestigation(
                $btn.closest(".History-panel")
            );
        });



    $(".copy-all-btn")
        .off("click")
        .on("click", function () {

            var $btn = $(this);

            var $panel =
                $btn.closest('.History-panel');
 

            $panel.find(".History-row").each(function () {

                var $li = $(this);

                var text =
                    $li.find(".History-row-text")
                        .text()
                        .trim();

                var Code =
                    $li.find(".History-row-Code")
                        .text()
                        .trim();

                if (text === "" || Code === "")
                    return true;

                var alreadyExists =
                    InvestigationListtable.getData()
                        .some(r => r.code === Code);

                if (alreadyExists)
                    return true;


                InvestigationListtable.addRow({

                    act: "",

                    code: Code,

                    name: text,

                    no: "0",
                    
                    type:"D",

                    remark: $li.find(".History-row-Remark")
                        .text()
                        .trim(),

                    SetUpYn: $li.find(".History-row-SetupYN")
                        .text()
                        .trim()

                }).then(function (row) {

                    row.normalizeHeight();

                    adjustTableHeight("InvestigationTable");
                });
            });


            var existingText =
                ($("#Investigations_Freetext").val() || "")
                    .trim();

            $panel.find(".History-FreeInvestigationText")
                .each(function () {

                    var freeText =
                        $(this).text().trim();

                    if (freeText !== "") {

                        if (
                            existingText === "" ||
                            !existingText.includes(freeText)
                        ) {

                            if (existingText !== "") {

                                existingText += "\n";
                            }

                            existingText += freeText;
                        }
                    }
                });

            $("#Investigations_Freetext")
                .val(existingText);


            if (typeof fitToContent === "function") {

                fitToContent(
                    'Investigations_Freetext'
                );
            }


            $panel.find(".copy-row-btn")
                .each(function () {

                    $(this)
                        .html(
                            '<i class="fa fa-check text-success"></i>'
                        )
                        .removeClass("copy-row-btn")
                        .prop("disabled", true);
                });



            $panel.find(".copy-freeinvestigation-btn")
                .each(function () {

                    $(this)
                        .html(
                            '<i class="fa fa-check text-success"></i>'
                        )
                        .removeClass("copy-freeinvestigation-btn")
                        .prop("disabled", true);
                });


            $btn.html(
                '<i class="fa fa-check text-success"></i>'
            )
                .removeClass("copy-all-btn")
                .prop("disabled", true);
        });
}


    function CheckAndUpdateCopyAllButtonInvestigation($section) {

        var $panel =
            $section.closest(".History-panel");

        var remainingButtons =
            $panel.find(".copy-row-btn").length +
            $panel.find(".copy-freeinvestigation-btn").length;

        if (remainingButtons === 0) {

            var $copyAll =
                $panel.find(".copy-all-btn");

            $copyAll.html(
                '<i class="fa fa-check text-success"></i>'
            )
                .removeClass("copy-all-btn")
                .prop("disabled", true);
        }
    }
</script>

<%--Setup For Investigation--%>
<script type="text/javascript">
    function SetupPopupInvestigationContent() {
        return `
        <div class="FilterClassDivPopup">
        <button class="btn btn-primary" onclick="ValidationForSetupInvestigationBindTran('Setup_Investigation')"><i class="fa fa-save"></i> Apply</button>
        <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('Investigation', 'InvestigationSetup')">
        </div>
        <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
        `;
    }

    function CreateTabulatorInvestigationSetup(TabulatorSetupId) {
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
                            OpenPopupForNewItem('Investigation', 'InvestigationSetup');
                            BindInvestigationEditSetup(rowData)
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
        BindInvestigationSetupList(TabulatorSetupId);
    }

    function BindInvestigationSetupList(TabulatorSetupId) {
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetPersInvestigationList","DoctorDesk")%>",
            data: {},
            asycn: false,
            success: function (response) {
                if (response && response.toUpperCase() !== "UNSUCCESSFULL") {//priyanka 14/03/2026

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

    function ValidationForSetupInvestigationBindTran(TabulatorSetupId) {
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
            SetInvestigationSetupToTran(SelCode);
        }
    }

    function SetInvestigationSetupToTran(strCode) {
        $.ajax({
            url: '../DoctorDesk/GetAdvicesBySetUpCode',
            data: { strCode: strCode, strType: "I" },
            type: 'post',
            datatype: 'get',
            success: function (response) {
                if (response != "" && response != "Unsucessfull") {
                    startLoading("Loading", "loading-Investigations");
                    response = JSON.parse(response);
                    for (i = 0; i < response.length; i++) {
                        var rows = InvestigationListtable.getData();
                        var Flag = true;
                        for (var j = 0; j < rows.length; j++) {
                            if (rows[j].code.trim() === response[i].CODE.trim()) {
                                ToastMsg("Investigation : " + rows[j].name + " already added", "warning");
                                Flag = false;
                            }
                        }
                        if (Flag) {
                            InvestigationListtable.addRow({
                                code: response[i].CODE.trim(),
                                name: response[i].NAME.trim(),
                                no: "0",
                                type: "D",
                                remark: "",
                                SetUpYn: "Y"
                            }).then(function (row) {
                                row.normalizeHeight();
                                adjustTableHeight("InvestigationTable");
                            });
                        }
                    }
                    stopLoading("loading-Investigations");
                    closeMaxMinPopup('Hist_M_Investigation');
                }
            }
        })
    }

    function ContentForAddNewItemInvestigationSetup() {
        return `
        <div class="mb-3">
                 <input id="txtSetupNameCode" type="text" class="form-control " style="display:none" />
               </div>
        <div class="mb-3">
          <input id="txtSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
        </div>
        <div class="mb-3">
              <div id="InvestigationTableSetupNew"></div>
        </div>
    `;
    }

    function FooterContentForAddNewItemInvestigationSetup() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForInvestigationSetup('')" tabindex="4">Save</button>
        `;
    }

    function CreateInvestigationSetupNewTabultor() {
        var InvestigationSetupNewTabultor = new Tabulator(("#InvestigationTableSetupNew"), {
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
        InvestigationSetupNewTabultor.on("tableBuilt", function () {
            BindInvestigationSetupNewList();
        });
    }

    function BindInvestigationSetupNewList() {
        var DataToSend = {
            ClinicCode: sessionStorage.getItem('ClinicCode')
        };
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetInvestigationList","DoctorDesk")%>",
            data: DataToSend,
            async: false,
            success: function (response) {
                if (response != "") {
                    var formattedData = response.map(function (row) {
                        return {
                            CHECKYN: false,
                            code: row.TESTCODE,
                            name: row.TESTNAME
                        };
                    });
                    var table = Tabulator.findTable("#InvestigationTableSetupNew")[0];
                    if (table) {
                        table.setData(formattedData);
                    }
                }
            }
        });
    }

    function BindInvestigationEditSetup(RowData) {
        $.ajax({
            url: '../DoctorDesk/GetInvstListBySetupCode',
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
                    var table = Tabulator.findTable("#InvestigationTableSetupNew")[0];
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

    function ValidationForNewItemInvestigationSetup() {
        var table = Tabulator.findTable("#InvestigationTableSetupNew")[0];
        if ($("#txtSetupName").val().trim().length === 0) {
            ToastMsg("Enter Setup Name", "warning");
            $("#txtSetupName").focus();
            return false;
        }
        if (table.getData().filter(function (row) { return row.CHECKYN === true; }).length == 0) {
            ToastMsg("Select Atleast One UnCoded Diagnosis.", "warning");
            return false;
        }
        return true;
    }

    function SaveNewItemForInvestigationSetup() {
        if (ValidationForNewItemInvestigationSetup() == true) {
            var table = Tabulator.findTable("#InvestigationTableSetupNew")[0];

            // collect checked CODEs
            var strInvstArry = table.getData()
                .filter(function (row) {
                    return row.CHECKYN === true;
                })
                .map(function (row) {
                    return row.code;
                })
                .join(",");
            var strInvstArry2 = table.getData()
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
                url: '../DoctorDesk/AddInvestnSetUp',
                data: { strInvestSetUpName: $("#txtSetupName").val(), strInvestigationLst: strInvstArry, strNameLst: strInvstArry2, strSetUpCode: $("#txtSetupNameCode").val() },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        BindInvestigationSetupList('Setup_Investigation');
                        closeAddNewItemPopup('InvestigationSetup');
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


    function fitToContent(id) {
        var textArea = document.getElementById(id);
        textArea.style.height = 'auto';
        var newHeight = Math.ceil(textArea.scrollHeight);

        textArea.style.height = newHeight + 'px';
        textArea.style.overflow = 'hidden';
    }

    function setMaxHeight(id) {
        var textArea = document.getElementById(id);

        textArea.style.height = '400px';

        textArea.style.overflowY = 'auto';
    }

    function InvstgSearchTxt() {
        if ($("#InvestigationSearch").val() != null && $("#InvestigationSearch").val() != "") {
            GetAllInvestigationsList();
        } else {
            GetFrequentInvestigations();
        }
    }
</script>

<div id="sec-Investigations" class="opd-section-card anchor-offset">
    <div class="d-flex justify-content-between mb-3 align-items-start">
        <h4 class="section-title me-5">Investigation</h4>
        <div class="flex-grow-1 position-relative  ms-5">
            <div class="input-group input-group-sm w-100">
<input type="text" id="InvestigationSearch" class="form-control" placeholder="Search Investigations,Procedure,Package,Service." onclick="GetFrequentInvestigations()" oninput="InvstgSearchTxt()">
<%--                <input type="text" id="InvestigationSearch" class="form-control" placeholder="Search Investigations,Procedure,Package,Service." onclick="GetFrequentInvestigations()" oninput="GetAllInvestigationsList()">  <%--oninput="FilterBindedSearchListForInvestigation()"--%> <%--// Modified Pournima 16th June 2026--%>
                <%-- onclick="FilterBindedSearchListForInvestigation()"--%> <%--// Modified Pournima 16th June 2026--%>
                <button class="btn btn-outline-success" id="Investigations_PrevHistory" onclick="HistoryPopupOpen('Investigation History', 'Investigations',true)"><i class="fa fa-history"></i></button>
                <button class="btn btn-outline-success btn-sm" id="Investigation_Setup" onclick="SetupPopupOpen('Investigation','Investigation',false)">Setup</button>
            </div>
            <div id="InvestigationListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
                <div id="InvestigationList" class="list-group w-100"></div>
                <div id='loading-Investigations-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
            </div>
        </div>
    </div>
    <div id="InvestigationTable"></div>
    <h6 class="fw-bold" style="padding: 15px 0px;"><%--Other Investigations/Procedures--%></h6>
    <textarea class="form-control TextAreaBorder" id="Investigations_Freetext" name="Investigations_Freetext" placeholder="Enter Other Investigations/Procedures"  oninput  ="autoResizeTextareaForSinglePage(this)"
        style="height: 80px; overflow-y: auto; resize: none; display: block;" maxlength="1000"></textarea>
    <%--Abhishesh || 20260321--%>
    <div class="text-end">
        <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnInvstfitTocontent" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" onclick="fitToContent('Investigations_Freetext')" />
        <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnInvstsetmaxheight" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer; " onclick="setMaxHeight('Investigations_Freetext')" />
    </div>
    <%--end--%>
    <div id='loading-Investigations' class='loading-screen' style='display: none; opacity: 0;'></div>
</div>
