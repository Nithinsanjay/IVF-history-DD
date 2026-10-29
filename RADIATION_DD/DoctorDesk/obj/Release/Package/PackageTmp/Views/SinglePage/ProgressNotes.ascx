<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.NursingNotes>" %>

<script type="text/javascript">
    var ProgressNotesListtable;
    var IsAuthorizedUser = '<%:  ("" + Session["ICUAUTHYN"]).ToString().Trim() %>';
    var serverdate = '<%:Model.shifttodayDate%>';
    var servertime = '<%:Model.todaystime%>';
    var proKeyList = [];
    var LoginType = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? "R" : "D";
    $(document).ready(function () {
        fitToContent('ProgressNotes_Freetext');  // Abhishesh || 20260321
        $("#iconFitToContent").show();
        $("#iconSetMaxHeight").hide();
        startLoading("Loading", "loading-ProgressNotes");
        $("#txtstrUIPNo").val(sessionStorage.getItem("IPPatIPNO"));
        $("#txtstrUAdmDtTm").val(sessionStorage.getItem("IPDADMNDATETIME"));

        /* Tabulator For Progress Notes */
        ProgressNotesListtable = new Tabulator("#ProgressNotesTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            variableHeight: true,
            height: "400",
            index: "code",
            columnDefaults: {
                headerSort: false
            },
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 50
            },
            columns: [
                {
                    title: "",
                    field: "act",
                    width: 40,
                    formatter: function (cell) {
                        return "<i class='fa fa-files-o CopyProgressnote' style='cursor:pointer' aria-hidden='true'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        var rowData = cell.getRow().getData();
                        var noteText = rowData.NURSENOTES.replace(/\/n/g, "\n").replace(/\\n/g, "\n");
                        var allNotes = $("#ProgressNotes_Freetext").val();
                        if (allNotes) allNotes += "\n";
                        allNotes += noteText;
                        var checkLength = allNotes.length;
                        //if (checkLength > 1000) {
                        //    ToastMsg("Cant exceed 1000 character.", "Information");
                        //    return;
                        //}
                        $("#ProgressNotes_Freetext").val(allNotes);
                        handleFitToContent();
                        autoResizeTextareaForSinglePage($("#ProgressNotes_Freetext")[0]);
                    }
                },
                { title: "Date", field: "NOTEDT", headerFilter: "input", width: 90, visible: true },
                { title: "Time", field: "NOTETM", headerFilter: "input", width: 90, visible: true },
                {
                    title: "Added By",
                    field: "USERID",
                    width: 200,
                    hozAlign: "center",
                    headerFilter: "input",
                    formatter: function (cell) {
                        var rowData = cell.getRow().getData();
                        var el = cell.getElement();
                        if (rowData.NOTETYPE === "N") el.style.background = "#ffe792";
                        else if (rowData.NOTETYPE === "R") el.style.background = "#ffccc7";
                        else if (rowData.NOTETYPE === "D") el.style.background = "#d3ffd5";
                        return "<div style='white-space:normal; word-wrap:break-word;'>" + cell.getValue() + "</div>";
                    }
                },
                //Abhishesh || 20260801
                //{
                //    title: "Progress Notes", field: "NURSENOTES", visible: true, headerFilter: "input",
                //    formatter: function (cell) {
                //        var rowData = cell.getRow().getData();
                //        var noteText = cell.getValue();
                //        var txtColor = (rowData.INKCOLOR === "R") ? "red" : "black";
                //        return "<div style='white-space:pre-wrap; word-wrap:break-word; color:" + txtColor + ";'>" + noteText + "</div>";
                //    }
                //},
                //End
                {
                    title: "Progress Notes",
                    field: "NURSENOTES",
                    visible: true,
                    headerFilter: "input",
                    formatter: function (cell) {
                        var rowData = cell.getRow().getData();
                        var noteText = cell.getValue() || "";
                        var txtColor = (rowData.INKCOLOR === "R") ? "red" : "black";
                        return `
                                <div style="
                                    white-space: pre-wrap;
                                    word-wrap: break-word;
                                    color:${txtColor};
                                    max-height:150px;
                                    overflow-y:auto;
                                ">${noteText}</div>
                            `;
                    }
                },
                { title: "Note Type", field: "NOTETYPE", visible: false },
                { title: "Note No", field: "NoteNo", visible: false }
            ]
        });

        $("#ProgressNotesFilter .filter-btn").on('click', function () {
            $("#ProgressNotesFilter .filter-btn").removeClass("active");
            $(this).addClass("active");

            var type = $(this).data("type");

            if (type === "ALL") {
                ProgressNotesListtable.clearFilter();
            } else {
                ProgressNotesListtable.setFilter("NOTETYPE", "=", type);
            }
        });

        $('#btnClearNotes').on('click', function () {
            if (confirm("Are you sure you want to clear these notes?")) {
                $('#ProgressNotes_Freetext').val('');
                autoResizeTextareaForSinglePage($("#ProgressNotes_Freetext")[0]);
            }
        });
        $('#cmbInkColor').change(function () {
            colorset();
        });

        $('#txtNotesDate').datepicker({
            showButtonPanel: true,
            dateFormat: 'dd/mm/yy',
            yearRange: 'c-150:c+0',
            changeMonth: true,
            changeYear: true,
            maxDate: new Date(),

        });

        $('#NursgTime').timepicker({
            timeFormat: 'hh:mm TT',
            onClose: function () {
                colorsetauthorised();
                var srvrdate = serverdate;
                var Time = new Date();
                var CuurentTime = Time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
                var date = $('#txtNotesDate').val();
                var time = $('#NursgTime').val();
                date = date.split("/");
                srvrdate = srvrdate.split("/");
                var fromdt = srvrdate[2] + '/' + srvrdate[1] + '/' + srvrdate[0] + " " + CuurentTime;
                var todt = date[2] + '/' + date[1] + '/' + date[0] + " " + time;
                var from = new Date(Date.parse(fromdt));
                var currto = new Date(Date.parse(todt));
                if (serverdate == $('#txtNotesDate').val()) {
                    if (currto > from) {
                        ToastMsg("Invalid Time", "warning");
                        $('#NursgTime').val("");
                        return false;
                    }
                    colorset();
                }
                colorset();
            }
        });

        $('#NursgTime').change(function () {
            if ($('#NursgTime').val() != "") {
                $('#NursgTime').css('border-color', "");
            }
        });

        $.ajax({
            url: '../SinglePage/GetThreefieldGridData',
            type: 'GET',
            async: true,
            data: { MasterLabel: 'ProKey Helper Master' },
            success: function (response) {
                if (response && response.length > 0) {
                    proKeyList = response.map(function (x) { return x.NAME; });
                }
            },
            error: function (xhr, status) {
                ToastMsg(status, "error");
            }
        });

        $('#ProgressNotes_Freetext').on('keyup', function (e) {
            var $textarea = $(this);
            var originalText = $textarea.val();
            var cursorPos = $textarea.prop('selectionStart');
            var textBeforeCursor = originalText.substring(0, cursorPos);
            var match = textBeforeCursor.match(/\$[a-zA-Z0-9_]*$/);

            if (match) {
                var currentWord = match[0].substring(1);
                var suggestions = proKeyList.filter(function (name) {
                    return name.toLowerCase().startsWith(currentWord.toLowerCase());
                });

                if (suggestions.length > 0) {
                    $textarea.autocomplete({
                        source: suggestions,
                        minLength: 1,
                        select: function (event, ui) {
                            var updatedText = originalText.substring(0, cursorPos - match[0].length)
                                + '$' + ui.item.value
                                + originalText.substring(cursorPos);
                            $textarea.val(updatedText);
                            var newPos = cursorPos - match[0].length + ui.item.value.length + 1;
                            $textarea.prop('selectionStart', newPos);
                            $textarea.prop('selectionEnd', newPos);
                            autoResizeTextareaForProgessNotePaste($textarea[0]);
                            return false;
                        }
                    }).autocomplete("search", currentWord);
                }
            }
            var matches = originalText.match(/\$[a-zA-Z0-9_]+/g);
            if (matches) {
                matches.forEach(function (fullMatch) {
                    var keyword = fullMatch.substring(1);
                    $.ajax({
                        url: '../SinglePage/GetProKeyDescription',
                        type: 'POST',
                        data: { ProKeyName: keyword },
                        success: function (response) {
                            if (response && response.rows && response.rows.length > 0) {
                                var description = response.rows[0].PRONAME;
                                var updatedText = $textarea.val().replace(fullMatch, description);
                                $textarea.val(updatedText);
                            }
                        },
                        error: function () {
                            console.error("Error for keyword:", keyword);
                        }
                    });
                });
            }
        });

        $("#ProgressNotes_Freetext").val("");

        setCurrentTimeInNursgTime();
        setInterval(setCurrentTimeInNursgTime, 60000);
        GetProgressNoteslist();
        colorsetauthorised();
        colorset();
        stopLoading("loading-ProgressNotes");
    });

    function GetProgressNoteslist() {
        var strIPNo = $('#txtstrUIPNo').val().trim();
        var fullStr = $("#txtstrUAdmDtTm").val().trim();
        var strFromDate = "";
        var strTime = "";
        var userid = gDoctId;
        var strToDate = "";
        var strToTime = "";
        if (fullStr) {
            var lastSlashIndex = fullStr.lastIndexOf('/');
            strFromDate = fullStr.substring(0, lastSlashIndex).trim();
            strTime = fullStr.substring(lastSlashIndex + 1).trim();
        }
        var now = new Date();
        var day = String(now.getDate()).padStart(2, '0');
        var month = String(now.getMonth() + 1).padStart(2, '0');
        var year = now.getFullYear();
        strToDate = day + "/" + month + "/" + year;
        var hours = String(now.getHours()).padStart(2, '0');
        var minutes = String(now.getMinutes()).padStart(2, '0');
        var seconds = String(now.getSeconds()).padStart(2, '0');
        strToTime = hours + ":" + minutes + ":" + seconds;
        startLoading("Loading", "loading-ProgressNotes");
        $.ajax({
            url: '../SinglePage/GetICUProgressNotes',
            type: 'GET',
            async: true,
            data: {
                strIPNo: strIPNo,
                strFromDate: strFromDate,
                strToDate: strToDate,
                strTime: strTime,
                strToTime: strToTime,
                userid: userid,
                NoteType: "N",
            },
            success: function (data) {
                ProgressNotesListtable.setData(data.Notes.rows).then(function () {
                    ProgressNotesListtable.getRows().forEach(function (row) {
                        row.normalizeHeight();
                    });
                });
                BindCaseDetaislData(data);
                stopLoading("loading-ProgressNotes");
            },
            error: function (xhr, status) {
                ToastMsg(status, "error");
                stopLoading("loading-ProgressNotes");
            }
        });
    }

    function autoResizeTextareaForProgessNotePaste(el) {
        el.style.height = "auto";
        el.style.height = (el.scrollHeight) + "px";
    }

    //function BindCaseDetaislData(result) {
    //    if (result.JsonCaseDetailData && result.JsonCaseDetailData.length > 0) {
    //        $("#txtProvDiagno").val(result.JsonCaseDetailData[0].DIAGNOSIS.toString().trim());
    //    } else {
    //        $("#txtProvDiagno").val('');
    //    }

    //    if (result.JsonAllergisData && result.JsonAllergisData.length > 0) {
    //        var allerg = "";
    //        $.each(result.JsonAllergisData, function (Index, Element) {
    //            allerg += Element.ALLERGYDESC.toString().trim() + ',';
    //        });
    //        $("#txtAllergies").val(allerg.slice(0, -1)).css('color', '');
    //    } else {
    //        $("#txtAllergies").val('');
    //    }
    //}

    function colorset() {
        if ($('#cmbInkColor').val() == "R") {
            $('#ProgressNotes_Freetext').css('color', 'red');
        }
        else if ($('#cmbInkColor').val() == "B") {
            $('#ProgressNotes_Freetext').css('color', 'black');
        }
    }

    function colorsetauthorised() {
        if (IsAuthorizedUser == "Y") {
            $('#cmbInkColor').attr('disabled', false);
            $('#cmbInkColor').val("R");
            $('#cmbInkColor').attr('disabled', true);
        }
        else {
            $('#cmbInkColor').attr('disabled', false);
            $('#cmbInkColor').val("B");
            $('#cmbInkColor').attr('disabled', true);
        }
    }

    function ValidationForProgressNotes() {
        var notes = $('#ProgressNotes_Freetext').val().trim();
        if (notes != "") {
            if ($('#NursgTime').val() == "") {
                $('#NursgTime').focus();
                ToastMsg("Please Select the Time", "warning");
                return false;
            }
            var srvrdate = serverdate;
            var Time = new Date();
            var CuurentTime = Time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
            var date = $('#txtNotesDate').val();
            var time = $('#NursgTime').val();
            date = date.split("/");
            srvrdate = srvrdate.split("/");
            var fromdt = srvrdate[2] + '/' + srvrdate[1] + '/' + srvrdate[0] + " " + CuurentTime;
            var todt = date[2] + '/' + date[1] + '/' + date[0] + " " + time;
            var from = new Date(Date.parse(fromdt));
            var currto = new Date(Date.parse(todt));
            if (currto > from) {
                ToastMsg("Invalid Time", "warning");
                $('#NursgTime').val("");
                $('#NursgTime').focus();
                return false;
            }
            var fromdt1 = srvrdate[2] + '/' + srvrdate[1] + '/' + srvrdate[0];
            var todt1 = date[2] + '/' + date[1] + '/' + date[0];
            var from1 = new Date(Date.parse(fromdt1));
            var currto1 = new Date(Date.parse(todt1));
            if (currto1 > from1) {
                ToastMsg("Invalid Date", "warning");
                $('#txtNotesDate').focus();
                return false;
            }
            return true;
        }
        return true;
    }

    function SaveForProgressNotes(SaveDataObj) {
        var notes = $('#ProgressNotes_Freetext').val().trim();
        if (notes != "") {
            startLoading("Loading", "loading-ProgressNotes");
            $('#cmbInkColor').attr("disabled", false);
            //setCurrentTimeInNursgTime(); //commented by priyanka 20/04/2026
            var NursgNotesData = $('#ProgressNotes_Freetext').val();
            var ipno = $('#txtstrUIPNo').val().trim();
            var inkColor = $('#cmbInkColor').val();
            var AuthYn = IsAuthorizedUser;
            var NSType = LoginType;
            var datatosend = {
                ipno: ipno,
                NursgNotesData: NursgNotesData,
                Notedate: $('#txtNotesDate').val(),
                Notetime: $('#NursgTime').val(),
                userid: gDoctId,
                strInkColor: inkColor,
                nmode: "S",
                AuthYn: AuthYn,
                NoteType: NSType
            };
            $.ajax({
                type: "POST",
                data: datatosend,
                url: "../SinglePage/SaveNursgAdditionalNotes",
                dataType: "json",
                async: false,
                success: function (response) {
                    $('#cmbInkColor').val('B');
                    $('#ProgressNotes_Freetext').css('color', 'black');
                    $('#ProgressNotes_Freetext').val('').trigger('change');
                    GetProgressNoteslist();
                    ToastMsg("Progress Note saved successfully.", "success");
                    stopLoading("loading-ProgressNotes");
                },
                error: function (xhr, status) {
                    ToastMsg(status, "error");
                    stopLoading("loading-ProgressNotes");
                }
            });
        }
    }

    function setCurrentTimeInNursgTime() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        hours = hours < 10 ? '0' + hours : hours;
        minutes = minutes < 10 ? '0' + minutes : minutes;
        var currentTime = hours + ':' + minutes + ' ' + ampm;
        $('#NursgTime').val(currentTime);
        $('#txtNotesDate').datepicker("setDate", new Date());
    }
    //Added By Abhishesh|| 20260316
    function fitToContent(textareaId) {
        var el = document.getElementById(textareaId);
        el.style.maxHeight = "none";
        el.style.overflowY = "hidden";
        el.style.height = 'auto';
        el.style.height = el.scrollHeight + 'px';
    }

    function setMaxHeight(textareaId) {
        var el = document.getElementById(textareaId);
        el.style.maxHeight = '200px';
        el.style.overflowY = 'auto';
    }
    function handleFitToContent() {
        fitToContent('ProgressNotes_Freetext');

        $("#iconFitToContent").hide();
        $("#iconSetMaxHeight").show();
    }

    function handleSetMaxHeight() {
        setMaxHeight('ProgressNotes_Freetext');

        $("#iconSetMaxHeight").hide();
        $("#iconFitToContent").show();
    }
    //End
</script>


<style>
    .ProgramNoteFieldDiv {
        display: flex;
        align-items: center;
        gap: 20px;
    }
    /* Added By Abhishesh || 20260316*/
    #ProgressNotesFilter .filter-btn {
        padding: 5px 10px;
        cursor: pointer;
        border: 2px solid transparent;
        border-radius: 4px;
    }

        #ProgressNotesFilter .filter-btn.active {
            border: 2px solid red;
        }
    /*End*/
    .ProgramNoteInkLbl {
        width: 110px;
        display: flex;
        align-content: center;
        flex-wrap: wrap;
    }

    .ProgramNoteLbl{
            padding-top: 20px;
    }

    .ProgressNote-Ind{

    }

    .Nurse-ProgressNote-Ind{

    }

    .RMO-ProgressNote-Ind{

    }

    .Consult-ProgressNote-Ind {
    }
</style>

<div id="sec-ProgressNote" class="opd-section-card anchor-offset container-fluid">
    <div class="row mb-3">
        <div class="col">
            <h4 class="section-title">Progress Notes</h4>
        </div>
    </div>

    <div id="HiddenFields" style="display:none">
        <input type="text" id="txtstrUIPNo" />
        <input type="text" id="txtstrUAdmDtTm" />
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-12 mb-3 w-100">
            <textarea class="form-control TextAreaBorder" id="ProgressNotes_Freetext" name="ProgressNotes_Freetext" oninput="autoResizeTextareaForSinglePage(this)" style="height: auto; overflow: hidden; resize: none;"></textarea>
           <%--  Added By Abhishesh|| 20260316--%>      
            <div class="d-flex gap-2 mb-2 justify-content-end align-items-center">
                <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>"id="iconFitToContent"style="cursor: pointer; width: 35px; height: 30px;"title="Fit To Content"onclick="handleFitToContent()" />
                <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>"id="iconSetMaxHeight"style="cursor: pointer; width: 35px; height: 30px; display: none;"title="Set Max Height"onclick="handleSetMaxHeight()" />
            </div>
            <%--End--%>
            <div class="row g-2">
                <div class="col-sm-6 ProgramNoteFieldDiv">
                    <%=Html.TextBoxFor(x => Model.NursgNotesDate, new { id="txtNotesDate",@readonly=true,@class="form-control",@disabled="disabled"})%>
                    <input type="text" id="NursgTime" class="form-control" readonly disabled />
                </div>
                <div class="col-sm-6 ProgramNoteFieldDiv">
                    <label class="ProgramNoteInkLbl">Ink Color</label>
                    <%=Html.DropDownList("InkColorLst",new SelectList(Model.InkColorLst, "Value", "Text"), new { id="cmbInkColor",@class="form-control" })%>
                  <%--  <i class="fa fa-eraser" aria-hidden="true"></i>--%>
                    <i class="fa fa-eraser"
                        id="btnClearNotes"
                        title="Clear Notes"
                        ></i>
                </div>
                <div id="divUsrType" style="display: none">
                    Note By :
                    <input type="checkbox" id="chkUsrNurse" value="N" name="UserType" disabled="disabled"><label for="chkUsrNurse"> Nurse</label>
                    <input type="checkbox" id="chkUsrRMO" value="R" name="UserType" disabled="disabled"><label for="chkUsrRMO"> GDMO/RMO</label>
                    <input type="checkbox" id="chkUsrDoct" value="D" name="UserType" disabled="disabled"><label for="chkUsrDoct"> Consultant</label>
                </div> 
            </div>
            <div class="row g-2">
                <label class="ProgramNoteLbl"><b>Note :</b> To access the features of the Quick Text, simply use the variable $QuickText_name.</label>
            </div>
        </div>
    </div>
    <div class="row">
       <div class="col-lg-6 col-md-12 w-100">
            <div id="ProgressNotesTable"></div>
            <div class="mt-2 d-flex flex-wrap gap-3 justify-content-start" id="ProgressNotesFilter">
                <span class="filter-btn" style="background: #ffe792; padding: 5px; cursor: pointer;" data-type="N">Nurse</span>
                <span class="filter-btn" style="background: #ffccc7; padding: 5px; cursor: pointer;" data-type="R">GDMO/RMO</span>
                <span class="filter-btn" style="background: #d3ffd5; padding: 5px; cursor: pointer;" data-type="D">Consultant</span>
                <span class="filter-btn" style="background: #cce5ff; padding: 5px; cursor: pointer;" data-type="ALL">All Record</span>
            </div>
        </div>
    </div>

    <!-- Loading Overlay -->
    <div id='loading-ProgressNotes' class='loading-screen' style='display: none; opacity: 0;'></div>
</div>
