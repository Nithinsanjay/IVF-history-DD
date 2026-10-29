<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>

<style>
    textarea {
    box-sizing: border-box;
 }
</style>

<script type="text/javascript">
    var InstructionListtable;
    var RMOFlagInstructYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEINSTRUCTIONYN")%>' == "Y" ? "N" : "Y") : "N";
    var SessionCompInst = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagInstructYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');

    $(document).ready(function () {
        // Added By Abhishesh || 20260321
        $("#btninnsfitTocontent").on("click", function () {
            fitToContent('Complaints_Freetext');
        });
        $("#btninssetmaxheight").on("click", function () {
            setMaxHeight('Complaints_Freetext');
        });
        // End
        InstructionListtable = new Tabulator("#InstructionTable", {
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
                    headerSort: false,
                    editable: function(cell) {
                        return sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagInstructYN != "Y";
                    },
                    formatter: function (cell) {
// Hide delete icon if patient visit is completed
                        if (typeof SessionCompInst !== 'undefined' && SessionCompInst === "Y") {
    return "";
}
                        return "<i class='fa fa-trash text-danger delete-row' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    //cellClick: function (e, cell) {
                    //    cell.getRow().delete();
                    //}
                    cellClick: function (e, cell) {
                        if (sessionStorage.getItem("PatCompleted") !== "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" && RMOFlagInstructYN != "Y") {
                            cell.getRow().delete();
                        }
                    }
                },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    formatter: "textarea",
                    cssClass: "wrap-text"
                }
            ]
        });

        InstructionListtable.on("cellEdited", function (cell) {
            cell.getRow().normalizeHeight();
            adjustTableHeight("InstructionTable");
        });

        InstructionListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("InstructionTable");
        });

        InstructionListtable.on("rowDeleted", function (row) {
            adjustTableHeight("InstructionTable");
        });

        InstructionListtable.on("dataLoaded", function () {
            adjustTableHeight("InstructionTable");
        });

        InstructionListtable.on("tableBuilt", function () {
            adjustTableHeight("InstructionTable");
        });

        InstructionListtable.on("dataChanged", function () {
            adjustTableHeight("InstructionTable");
        });

        /* Click Event on the Instruction Search List */
        $(document).on("click", ".instruction-row", function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var rows = InstructionListtable.getData();
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].code === code) {
                    ToastMsg("Instruction already added", "warning");
                    $("#instructionListMainDiv").hide();
                    return;
                }
            }
            InstructionListtable.addRow({
                act: '<i class="fa fa-trash text-danger"></i>',
                code: code,
                name: name,
                SetUpYn: ""
            }).then(function (row) {
                row.normalizeHeight();
                adjustTableHeight("InstructionTable");
            });
            $("#instructionSearch").val("");
            $("#instructionListMainDiv").hide();
        });

        /* Bind Already Saved Instruction */
        SetDataForInstructions();

        /* Adjust of Height Of Instruction Table */
        adjustTableHeight("InstructionTable");


        if (sessionStorage.getItem("PatCompleted").toString() === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagInstructYN == "Y"){
            $("#sec-Instructions *").attr("disabled","disabled");
            $("#instruction_PrevHistory").removeAttr("disabled");
        }
        else
        {
            $("#sec-Instructions *").removeAttr("disabled");
        }

    });

    /* Search For Frequent Instruction */
    function GetFrequentInstruction() {
        var clinicCode = sessionStorage.getItem('ClinicCode');
        startLoading("Loading", "loading-Instruction-Search-List")
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetPatAdvList",
            async: true,
            data: { ClinicCode: clinicCode },
            success: function (result) {
                var InstructionListData = [];
                if (result.Result) {
                    ToastMsg(result.Result, "error");
                }
                else {
                    InstructionListData = result || [];
                }
                BindSearchListForInstruction(InstructionListData);
                stopLoading("loading-Instruction-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Instruction-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Search For All Instruction */
    function GetAllInstructionList(FilterInstructionText = "", FilterInstructionCode = "", HistoryObj = "") { <%--// Modified Pournima 16th June 2026--%>
        var clinicCode = sessionStorage.getItem('ClinicCode');
        FilterInstructionText = $("#instructionSearch").val(); <%--// Modified Pournima 16th June 2026--%>
        startLoading("Loading", "loading-Instruction-Search-List")
        $.ajax({
            type: "POST",
            async: true,
            url: "../DoctorDesk/GetDBPatientAdvice",
            data: { PatAdvice: FilterInstructionText, ClinicCode: clinicCode },
            success: function (result) {
                var InstructionListData = [];
                if (typeof result === "string") {
                    if (result.toUpperCase() != "UNSUCESSFULL") {
                        result = JSON.parse(result);
                        InstructionListData = result.Table1;
                        InstructionListData = InstructionListData.filter(function (item) { //priyanka 27/04/2026
                            return item.STATUS === "A";
                        });
                    }
                }
                else {
                    ToastMsg(result.Result, "error");
                }
                FilterInstructionData(InstructionListData, FilterInstructionCode, HistoryObj);
                stopLoading("loading-Instruction-Search-List");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Instruction-Search-List");
                ToastMsg(textStatus, "error");
            }
        });
    }

    /* Filter Compliants Data list */
    function FilterInstructionData(InstructionListData, FilterInstructionCode, HistoryObj) {
        var FilterInstructionList = InstructionListData;
        if (FilterInstructionCode != "") {
            FilterInstructionList = InstructionListData.filter(item => item.CODE == FilterInstructionCode);
        }
        BindSearchListForInstruction(FilterInstructionList);
        if (FilterInstructionCode && FilterInstructionCode !== "") {
            var $first = $("#instructionList .instruction-row").first();
            if ($first.length) {
                $first.trigger("click");
                if (HistoryObj != undefined && HistoryObj != null && HistoryObj != "") {
                    InstructionListtable.updateRow(FilterInstructionCode, {
                        code: HistoryObj.code, name: HistoryObj.name, no: HistoryObj.no,
                        type: HistoryObj.type, remark: HistoryObj.remark, SetUpYn: HistoryObj.SetUpYn
                    });
                }
            }
        }
    }

    //Filter in HTML Search
    function FilterBindedSearchListForInstruction() {
        var SearchTxt = $("#instructionSearch").val().toLowerCase();
        var FlagForCallAllInstList = true;
        if (SearchTxt.length < 3) {
            $("#instructionList .instruction-row").each(function () {
                var name = $(this).data("name").toLowerCase();
                var code = $(this).data("code").toLowerCase();
                if (name.indexOf(SearchTxt) !== -1 || code.indexOf(SearchTxt) !== -1) {
                    FlagForCallAllComplList = false;
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
        if (FlagForCallAllInstList == true)
            GetAllInstructionList($("#instructionSearch").val(), "");
    }

    //List Binding Functionality
    function BindSearchListForInstruction(InstructionData) {
        var $list = $("#instructionList");
        $list.empty();
        var AppendContentList = '<div class="list-group-item text-muted">No instruction found</div>';
        if (InstructionData.length > 0) {
            AppendContentList = "";
            for (var i = 0; i < InstructionData.length; i++) {
                var itemCode = InstructionData[i].DESCCD ? InstructionData[i].DESCCD.trim() : InstructionData[i].CODE.trim();
                var itemName = InstructionData[i].DESC ? InstructionData[i].DESC.trim() : InstructionData[i].NAME.trim();
                //var ListOption = '<div class="list-group-item instruction-row" data-code="' + itemCode + '" data-name="' + itemName + '" style="cursor:pointer;">' + itemName + ' (' + itemCode + ') </div>';
                var ListOption = '<div class="list-group-item instruction-row" data-code="' + itemCode + '" data-name="' + itemName + '" style="cursor:pointer;">' + itemName + '</div>';
                AppendContentList = AppendContentList + ListOption;
            }
        }
        $("#instructionList").append(AppendContentList);
        $("#instructionListMainDiv").show();
    }

    //Validation Functionality For Save Instruction
    function ValidationForInstruction(Type) {
        return true;
    }

    function HASDataInInstruction() {//priyanka 16/04/2026
        var InstructTblData = InstructionListtable.getData();
        var InstructFreeText = $("#Instructions_Freetext").val();
        if (((InstructTblData.length === 0) && (InstructFreeText === "" || InstructFreeText === null)) === true) {
            return false;
        }
        else {
            return true;
        }
    }
    //Save Functionality For Instruction
    function SaveForInstruction(DataSaveObj, Type) {
        var InstructionArr = [];
        var tableData = InstructionListtable.getData();
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
                SETUPYN: rows[i].SetUpYn, //Pending
            };
            InstructionArr.push(a);
        }
        DataSaveObj.StrInstruction = JSON.stringify(InstructionArr);
        DataSaveObj.FreeAdvice = $("#Instructions_Freetext").val();
    }


    //Binding Functionality For Instruction
    function SetDataForInstructions() {
        var tranNo = sessionStorage.getItem('PatTRANNO');
        if (!tranNo) return;
        startLoading("Loading", "loading-Instruction");
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/SetDataForPatAdv",
            datatype: "json",
            data: { strTranNo: tranNo },
            success: function (data) {
                if (!data || !data[0] || data[0].length === 0) {
                    stopLoading("loading-Instruction");
                }
                else {
                    var existingRows = InstructionListtable.getData();
                    data[0].forEach(function (item) {
                        var exists = existingRows.some(function (r) {
                            return r.code === item.DESCCD;
                        });
                        if (exists) return;
                        InstructionListtable.addRow({
                            act: "",
                            code: item.DESCCD,
                            name: item.DESC,
                            SetUpYn: item.SETUPYN || ""
                        });
                    });
                }
                if (data && data[1] && data[1][0] && data[1][0].FreePatAdvice) {
                    $("#Instructions_Freetext").val(data[1][0].FreePatAdvice);
                    fitToContent('Instructions_Freetext');
                    $("#btninnsfitTocontent").hide();
                    $("#btninssetmaxheight").show();
                }
                stopLoading("loading-Instruction");
            },
            error: function (xhr, status) {
                ToastMsg("Data is not saved for Instruction. "+status, "error");
                stopLoading("loading-Instruction");
            }
        });
    }
</script>


<%-- Add New Item For Instruction --%>
<script type="text/javascript">
    //Body Content For New Item Instruction
    function ContentForAddNewItemInstruction() {
        return `
             <div class="mb-3">
               <input id="txtInstruction" type="text" class="form-control Instructions" maxlength="250" autocomplete="off" placeholder="Enter Instruction" tabindex="2" />
             </div>
        `;
    }
    //Footer Content For New Item Instruction
    function FooterContentForAddNewItemInstruction() {
        //<button class="btn btn-secondary" onclick="closeAddNewItemPopup('Instruction')" tabindex="3">Close</button>
        return `
            <button class="btn btn-primary" onclick="SaveNewItemForInstruction('Instruction')" tabindex="4">Save</button>
        `;
    }
    //Validation For New Item Instruction
    function ValidationForNewItemInstruction() {
        if ($("#txtInstruction").val().trim().length === 0) {
            ToastMsg("Enter Instruction", "warning");
            $("#txtInstruction").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Instruction
    function SaveNewItemForInstruction() {
        if (ValidationForNewItemInstruction() == true) {
            startLoading("Loading", "loading-Complaints-New-Item");
            $.ajax({
                type: "post",
                datatype: "json",
                url: "../DoctorDesk/AddPatAdvice",
                data: { strPatAdv: $("#txtInstruction").val().trim() },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESS") !== -1) {
                        ToastMsg(response, "success");
                        var InstructionNewcode = response.split(' ').pop().trim();
                        var InstructionNewText = $("#txtInstruction").val();
                        GetAllInstructionList(InstructionNewText, InstructionNewcode);
                        closeAddNewItemPopup('Instruction');
                    }
                    else {
                        ToastMsg(response, "warning");
                    }
                    stopLoading("loading-Complaints-New-Item");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    stopLoading("loading-Complaints-New-Item");
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }
</script>

<%-- History For Instruction --%>
<script type="text/javascript">

 function HistPopInstructionTemp(AllHistoryData, ContentID) {
     var existingRows = InstructionListtable.getData();
     var ConsultLst = AllHistoryData[0] || [];
     var InstructionLst = AllHistoryData[7] || [];
     var FreeAdviceLst = AllHistoryData[14] || [];

     var isVisitCompleted =
         (typeof SessionCompInst !== 'undefined' &&
             SessionCompInst === "Y");

     var instructionFreeText =
         $("#Instructions_Freetext").val() || "";

     var $container =
         $('<div class="history-list-wrapper"></div>');

     for (var i = 0; i < ConsultLst.length; i++) {

         var consult = ConsultLst[i];

         var ConsultNo = consult.TRANNO;

         if (!ConsultNo ||
             ConsultNo == sessionStorage.getItem("PatTRANNO"))
             continue;
         var filtered =
             InstructionLst.filter(c => c.TRANNO === ConsultNo);

         var filteredFreeAdvice =
             FreeAdviceLst.filter(f => f.TRANNO === ConsultNo);

         if (filtered.length === 0 &&
             filteredFreeAdvice.length === 0)
             continue;
         var allCopied = filtered.every(c =>
             existingRows.some(r => r.code === c.DESCCD)
         );

         var allFreeAdviceCopied =
             filteredFreeAdvice.every(f =>
                 instructionFreeText.includes(
                     f.FREEADVICE || ""
                 )
             );

         

         var docName = consult.DOCTNAME || "";

         var specName =
             consult.SPECNAME
                 ? " (" + consult.SPECNAME + ")"
                 : "";

         var dateInfo =
             consult.TRANDATE + " " +
             ConvertTo12Hour("O", consult.TRANTIME);

       

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
                 (filteredFreeAdvice.length === 0 || allFreeAdviceCopied)
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

             var instructionHtml = `

             <div class="History-section">

                 <label>
                     <b>Instructions</b>
                 </label>

                 <ul class="list-unstyled mb-0">
         `;

             for (var k = 0; k < filtered.length; k++) {

                 var itemText =
                     filtered[k].NAME || "";

                 var itemCode =
                     filtered[k].DESCCD || "";

                 var exists =
                     existingRows.some(
                         r => r.code === itemCode
                     );

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

                 instructionHtml += `

                 <li class="History-row
                            d-flex
                            justify-content-between
                            align-items-center
                            p-2
                            border-bottom">

                     <div class="flex-grow-1">

                         ${itemText}

                         <span class="History-row-text History-row-Hide">
                             ${itemText}
                         </span>

                         <span class="History-row-Code History-row-Hide">
                             ${itemCode}
                         </span>

                     </div>

                     ${actionBtn}

                 </li>
             `;
             }

             instructionHtml += `

                 </ul>

             </div>
         `;

             $panelBody.append(instructionHtml);
         }

     

         if (filteredFreeAdvice.length > 0) {

             var freeHtml = `

             <hr style="margin:0;">

             <div class="History-section mt-2">

                 <label>
                     <b>Other Instructions</b>
                 </label>

                 <ul class="list-unstyled mb-0">
         `;

             for (var j = 0; j < filteredFreeAdvice.length; j++) {

                 var freeAdviceText =
                     filteredFreeAdvice[j]
                         .FREEADVICE || "";

                 var freeAdviceExists =
                     instructionFreeText.includes(
                         freeAdviceText
                     );

                 var freeActionBtn = "";

                 if (freeAdviceExists) {

                     freeActionBtn = `
                     <span class="text-success mr-2"
                           title="Already Added">

                         <i class="fa fa-check-circle"></i>

                     </span>
                 `;
                 }
                 else if (!isVisitCompleted) {

                     freeActionBtn = `
                     <button class="btn btn-link btn-sm p-0 copy-freeinstruction-btn"
                             title="Copy to List">

                         <i class="fa fa-clone text-primary"></i>

                     </button>
                 `;
                 }

                 freeHtml += `

                 <li class="History-FreeInstructionRow
                            d-flex
                            justify-content-between
                            align-items-center
                            p-2
                            border-bottom">

                     <div class="History-FreeInstructionText flex-grow-1">

                         ${freeAdviceText}

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

 function CopyFuncInstruction() {
     $(".copy-row-btn").off("click").on("click", function () {

         var $btn = $(this);

         var $li = $btn.closest("li");

         var text =
             $li.find(".History-row-text")
                 .text()
                 .trim();

         var Code =
             $li.find(".History-row-Code")
                 .text()
                 .trim();

         var InstructionRowObj = {

             code: Code,

             name: text,

             SetUpYn: ""
         };

         InstructionListtable.addRow({
             act: '<i class="fa fa-trash text-danger"></i>',
             code: Code,
             name: text,
             SetUpYn: ""
         }).then(function (row) {
             row.normalizeHeight();
             adjustTableHeight("InstructionTable");
         });

         $btn.html('<i class="fa fa-check text-success"></i>')
             .removeClass("copy-row-btn")
             .prop("disabled", true);

         var $panel = $btn.closest(".History-panel");

         var remainingButtons =
             $panel.find(".copy-row-btn").length +
             $panel.find(".copy-freeinstruction-btn").length;

         if (remainingButtons === 0) {

             var $copyAll =
                 $panel.find(".copy-all-btn");

             if ($copyAll.length > 0) {

                 $copyAll.html(
                     '<i class="fa fa-check text-success" style="background:#dbfdf8;"></i>'
                 )
                     .removeClass("copy-all-btn")
                     .prop("disabled", true);
             }
         }
     });

   

     $(".copy-freeinstruction-btn")
         .off("click")
         .on("click", function () {

             var $btn = $(this);

             var text = $btn
                 .closest(".History-FreeInstructionRow")
                 .find(".History-FreeInstructionText")
                 .text()
                 .trim();

             var existingText =
                 $("#Instructions_Freetext").val().trim();

             if (existingText !== "") {

                 if (!existingText.includes(text)) {

                     $("#Instructions_Freetext").val(
                         existingText + "\n" + text
                     );
                 }
             }
             else {

                 $("#Instructions_Freetext").val(text);
             }

             fitToContent('Instructions_Freetext');

             $btn.html('<i class="fa fa-check text-success"></i>')
                 .removeClass("copy-freeinstruction-btn")
                 .prop("disabled", true);

             CheckAndUpdateCopyAllButtonInstruction(
                 $btn.closest(".History-section")
             );
         });

 

     $(".copy-all-btn").off("click").on("click", function () {

         var $btn = $(this);

         var $section =
             $btn.closest('.History-panel');

    

         var $rows =
             $section.find('.History-row');

         $rows.each(function () {

             var $row = $(this);

             var text =
                 $row.find(".History-row-text")
                     .text()
                     .trim();

             var Code =
                 $row.find(".History-row-Code")
                     .text()
                     .trim();
             var rows = InstructionListtable.getData();

             var exists = rows.some(r => r.code === Code);
             if (exists)
             {
                 ToastMsg((text + " is already added."), "warning");
             }
             else {
                 var InstructionRowObj = {
                     code: Code,
                     name: text,
                     SetUpYn: ""
                 };
                 InstructionListtable.addRow({
                     act: '<i class="fa fa-trash text-danger"></i>',
                     code: Code,
                     name: text,
                     SetUpYn: ""
                 }).then(function (row) {
                     row.normalizeHeight();
                     adjustTableHeight("InstructionTable");
                 });
             }
         });

       

         var existingText =
             $("#Instructions_Freetext")
                 .val()
                 .trim();

         $section.find(".History-FreeInstructionText")
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

         $("#Instructions_Freetext")
             .val(existingText);

         fitToContent('Instructions_Freetext');


         $section.find(".copy-row-btn")
             .each(function () {

                 $(this)
                     .html('<i class="fa fa-check text-success"></i>')
                     .removeClass("copy-row-btn")
                     .prop("disabled", true);
             });

      

         $section.find(".copy-freeinstruction-btn")
             .each(function () {

                 $(this)
                     .html('<i class="fa fa-check text-success"></i>')
                     .removeClass("copy-freeinstruction-btn")
                     .prop("disabled", true);
             });

       

         $btn.html(
             '<i class="fa fa-check text-success" style="background:#dbfdf8;"></i>'
         )
             .removeClass("copy-all-btn")
             .prop("disabled", true);
     });
 }

 function CheckAndUpdateCopyAllButtonInstruction($section) {

     var $panel =
         $section.closest(".History-panel");

     var remainingButtons =
         $panel.find(".copy-row-btn").length +
         $panel.find(".copy-freeinstruction-btn").length;

     if (remainingButtons === 0) {

         var $copyAll =
             $panel.find(".copy-all-btn");

         $copyAll.html(
             '<i class="fa fa-check text-success" style="background:#dbfdf8;"></i>'
         )
             .removeClass("copy-all-btn")
             .prop("disabled", true);
     }
 }

</script>

<%--Setup For Instruction--%>
<script type="text/javascript">
    function SetupPopupInstructionContent() {
        return `
        <div class="FilterClassDivPopup">
        <button class="btn btn-primary" onclick="ValidationForSetupInstructionBindTran('Setup_Instruction')"><i class="fa fa-save"></i> Apply</button>
        <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('Instruction', 'InstructionSetup')">
        </div>
        <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
        `;
    }

    function CreateTabulatorInstructionSetup(TabulatorSetupId) {
        var SetupInstructionListTable = new Tabulator(("#" + TabulatorSetupId), {
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
                            OpenPopupForNewItem('Instruction', 'InstructionSetup');
                            BindInstructionEditSetup(rowData)
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
        BindInstructionSetupList(TabulatorSetupId);
    }

    function BindInstructionSetupList(TabulatorSetupId) {
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetPersPatientAdviceList","DoctorDesk")%>",
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

    function ValidationForSetupInstructionBindTran(TabulatorSetupId) {
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
            SetInstructionSetupToTran(SelCode);
        }
    }

    function SetInstructionSetupToTran(strCode) {
        $.ajax({
            url: '../DoctorDesk/SavePersonalizedAdvces',
            data: { Code: strCode, strTranNO: sessionStorage.getItem("PatTRANNO"), strMRNo: sessionStorage.getItem("PatMRNO") },
            type: 'post',
            datatype: 'get',
            success: function (result) {
                if (result.length > 0) {
                    if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        SetDataForInstructions();
                    }
                    else if (("" + result).toUpperCase().indexOf("FAILED") != -1) {
                        ToastMsg(result, "warning");
                    }

                }
                closeMaxMinPopup('Hist_M_Instruction');
            }
        })
    }

    function ContentForAddNewItemInstructionSetup() {
        return `
        <div class="mb-3">
                 <input id="txtSetupNameCode" type="text" class="form-control " style="display:none" />
               </div>
        <div class="mb-3">
          <input id="txtSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
        </div>
        <div class="mb-3">
              <div id="InstructionTableSetupNew"></div>
        </div>
    `;
    }

    function FooterContentForAddNewItemInstructionSetup() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForInstructionSetup('')" tabindex="4">Save</button>
        `;
    }

    function CreateInstructionSetupNewTabultor(){
        var InstructionSetupNewTabultor = new Tabulator(("#InstructionTableSetupNew"), {
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
        InstructionSetupNewTabultor.on("tableBuilt", function () {
            BindInstructionSetupNewList();
        });
    }

    function BindInstructionSetupNewList(){
        var DataToSend = {
            ClinicCode: sessionStorage.getItem('ClinicCode')
        };
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetPatAdvList","DoctorDesk")%>",
            data: DataToSend,
            async: false,
            success: function (response) {
                if (response != "") {
                    var formattedData = response.map(function (row) {
                        return {
                            CHECKYN: false,
                            code: row.DESCCD,
                            name: row.DESC
                        };
                    });
                    var table = Tabulator.findTable("#InstructionTableSetupNew")[0];
                    if (table) {
                        table.setData(formattedData);
                    }
                }
            }
        });
    }

    function BindInstructionEditSetup(RowData) {
        $.ajax({
            url: '../DoctorDesk/GetPatAdvcListBySetupCode',
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
                    var table = Tabulator.findTable("#InstructionTableSetupNew")[0];
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

    function ValidationForNewItemInstructionSetup() {
        var table = Tabulator.findTable("#InstructionTableSetupNew")[0];
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

    function SaveNewItemForInstructionSetup() {
        if (ValidationForNewItemInstructionSetup() == true) {
            var table = Tabulator.findTable("#InstructionTableSetupNew")[0];

            // collect checked CODEs
            var strInstArry = table.getData()
                .filter(function (row) {
                    return row.CHECKYN === true;
                })
                .map(function (row) {
                    return row.code;
                })
                .join(",");
            var strInstArry2 = table.getData()
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
                url: '../DoctorDesk/AddPatAdviceSetUp',
                data: { strPatAdviceSetUpName: $("#txtSetupName").val(), strAdviceLst: strInstArry, strNameLst: strInstArry2, strSetUpCode: $("#txtSetupNameCode").val() },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        BindInstructionSetupList('Setup_Instruction');
                        closeAddNewItemPopup('InstructionSetup');
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
         if (!textArea) return;

  textArea.style.height = "400px";
  textArea.style.overflowY = "auto";
    }

</script>


<div id="sec-Instructions" class="opd-section-card anchor-offset">
    <div class="d-flex justify-content-between mb-3 align-items-start">
    <h4 class="section-title me-5">Instructions</h4>
    <div class="flex-grow-1 position-relative  ms-5">
        <div class="input-group input-group-sm w-100">
            <input type="text" id="instructionSearch" class="form-control" placeholder="Search Instruction" onclick="GetFrequentInstruction()" oninput="GetAllInstructionList()">  <%-- oninput="FilterBindedSearchListForInstruction()"--%> <%--// Modified Pournima 16th June 2026--%>
            <button class="btn btn-outline-success" id="instructionAdd" onclick="OpenPopupForNewItem('Instruction' , 'Instruction')"><i class="fa fa-plus"></i></button>
            <button class="btn btn-outline-success" id="instruction_PrevHistory" onclick="HistoryPopupOpen('Instruction History', 'Instruction',true)"><i class="fa fa-history"></i></button>
            <button class="btn btn-outline-success btn-sm" id="Instruction_Setup" onclick="SetupPopupOpen('Instruction','Instruction',false)">Setup</button>
        </div>
        <div id="instructionListMainDiv" class="list-group position-absolute w-100" style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">
            <div id="instructionList" class="list-group w-100"></div>
            <div id='loading-Instruction-Search-List' class='loading-screen' style='display: none; opacity: 0;'></div>
        </div>
    </div>
</div>
  <div id="InstructionTable"></div>
  <h6 class="fw-bold" style="padding: 15px 0px;"><%--Other Instructions--%></h6>
  <textarea class="form-control TextAreaBorder" id="Instructions_Freetext" name="Instructions_Freetext" placeholder="Enter Other Instructions" oninput="autoResizeTextareaForSinglePage(this)" 
          style="height: 80px; overflow-y: auto; resize: none; display: block;"></textarea>
     <%--Abhishesh || 20260321--%>
       <div class="text-end">
    <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btninnsfitTocontent" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;"onclick="fitToContent('Instructions_Freetext')" />
    <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btninssetmaxheight" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer;"onclick="setMaxHeight('Instructions_Freetext')" />
</div>
<%--end--%>
  <div id='loading-Instruction' class='loading-screen' style='display: none; opacity: 0;'></div>
</div>