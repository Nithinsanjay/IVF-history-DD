<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style type="text/css">
    .history-exam-section {
        margin-bottom: 20px;
    }
    .history-textarea {
        width: 100%;
        min-height: 80px;
        resize: vertical;
        box-sizing: border-box;
    }



</style>

<div id="sec-History" class="opd-section-card anchor-offset history-exam-section">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="section-title mb-0">History</h4>
        
    </div>

    <!-- 1. Presenting complaint -->
    <div class="mb-3">
        <h6 class="fw-bold mb-1">Present Complaint</h6>
       <textarea class="form-control TextAreaBorder" id="txtPresentingComplaint" 
          name="txtPresentingComplaint" maxlength="3000" placeholder="Enter Presenting complaint..."
          oninput="autoResizeTextareaForSinglePage(this);" 
          style="height: 100px; overflow-y: auto; resize: none;"></textarea>
                <div class="text-end mt-1">
    <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" onclick="toggleTextareaHeight(this, 'txtPresentingComplaint')" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
</div>



    </div>

    <!-- 2. History of present illness -->
    <div class="mb-3">
        <h6 class="fw-bold mb-1">History of Present Illness</h6>
        <textarea class="form-control TextAreaBorder" id="txtHistoryPresentIllness" 
          name="txtHistoryPresentIllness" maxlength="3000" placeholder="Enter History of present illness..."
          oninput="autoResizeTextareaForSinglePage(this);" 
          style="height: 100px; overflow-y: auto; resize: none;"></textarea>
                <div class="text-end mt-1">
    <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" onclick="toggleTextareaHeight(this, 'txtHistoryPresentIllness')" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
</div>



    </div>

    <!-- 3. Past history. Comorbidities & allergies (if any) -->
    <div class="mb-3">
        <h6 class="fw-bold mb-1">Past History. Comorbidities & Allergies (if any)</h6>
        <textarea class="form-control TextAreaBorder" id="txtPastHistoryComorbidities" 
          name="txtPastHistoryComorbidities" maxlength="3000" placeholder="Enter Past history, comorbidities & allergies..."
          oninput="autoResizeTextareaForSinglePage(this);" 
          style="height: 100px; overflow-y: auto; resize: none;"></textarea>
               <div class="text-end mt-1">
    <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" onclick="toggleTextareaHeight(this, 'txtPastHistoryComorbidities')" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
</div>



    </div>

    
    <!-- Personal History -->
<div class="mb-3">
    <% Html.RenderPartial("~/Views/SinglePage/PersonalHistory.ascx", new ViewDataDictionary { { "Type", "IPD" } }); %>
</div>


       <!-- Family History Grid Only -->
    <div class="mb-3">
       <% Html.RenderPartial("~/Views/SinglePage/FamilyHistory.ascx", new ViewDataDictionary { { "Type", "IPD" } }); %>

    </div>
</div>

<!-- ================= EXAMINATION ================= -->
<div id="sec-exam" class="opd-section-card anchor-offset history-exam-section mt-3">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="section-title mb-0">Examination</h4>
        </div>

        <!-- ECOG Score -->
        <div class="mb-3">
            <h6 class="fw-bold mb-2">ECOG Score</h6>
            <div class="d-flex align-items-center gap-4 pt-1">
                <label class="d-flex align-items-center gap-1 cursor-pointer fw-semibold">
                    <input type="radio" name="rbtnECOGScore" value="0" style="accent-color: green;" /> 0
                </label>
                <label class="d-flex align-items-center gap-1 cursor-pointer fw-semibold">
                    <input type="radio" name="rbtnECOGScore" value="1" style="accent-color: green;" /> 1
                </label>
                <label class="d-flex align-items-center gap-1 cursor-pointer fw-semibold">
                    <input type="radio" name="rbtnECOGScore" value="2" style="accent-color: green;" /> 2
                </label>
                <label class="d-flex align-items-center gap-1 cursor-pointer fw-semibold">
                    <input type="radio" name="rbtnECOGScore" value="3" style="accent-color: green;" /> 3
                </label>
                <label class="d-flex align-items-center gap-1 cursor-pointer fw-semibold">
                    <input type="radio" name="rbtnECOGScore" value="4" style="accent-color: green;" /> 4
                </label>
                <label class="d-flex align-items-center gap-1 cursor-pointer fw-semibold">
                    <input type="radio" name="rbtnECOGScore" value="5" style="accent-color: green;" /> 5
                </label>
            </div>
        </div>

        <!-- General Examination -->
        <div class="mb-3">
            <h6 class="fw-bold mb-1">General Examination</h6>
           <textarea class="form-control TextAreaBorder" id="txtGeneralExamination" 
          name="txtGeneralExamination" maxlength="3000" placeholder="Enter General Examination..."
          oninput="autoResizeTextareaForSinglePage(this);" 
          style="height: 100px; overflow-y: auto; resize: none;"></textarea>

                    <div class="text-end mt-1">
    <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" onclick="toggleTextareaHeight(this, 'txtGeneralExamination')" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
</div>


        </div>

        <!-- Local examination -->
        <div class="mb-3">
            <h6 class="fw-bold mb-1">Local Examination</h6>
            <textarea class="form-control TextAreaBorder" id="txtLocalExamination" 
          name="txtLocalExamination" maxlength="3000" placeholder="Enter Local examination..."
          oninput="autoResizeTextareaForSinglePage(this);" 
          style="height: 100px; overflow-y: auto; resize: none;"></textarea>

                            <div class="text-end mt-1">
            <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" onclick="toggleTextareaHeight(this, 'txtLocalExamination')" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
        </div>
    </div>
</div>


<script type="text/javascript">


$(document).ready(function () {
    GetHistoryExamIPD();
});

function ValidationForHistoryExamIPD() {
    // 1. Check Personal History Grid directly
    if (typeof ValidationForPersonalHistory_IPD === "function") {
        if (!ValidationForPersonalHistory_IPD()) {
            return false;
        }
    } else if (typeof preparePersonalHistoryData_IPD === "function") {
        if (preparePersonalHistoryData_IPD() === false) {
            return false;
        }
    }

    // 2. Check Family History Grid directly
    if (typeof ValidationForFamilyHistory_IPD === "function") {
        if (!ValidationForFamilyHistory_IPD()) {
            return false;
        }
    }

    return true;
}


// Save function called by IPDCommonSave()
function SaveHistoryExamIPD(IPDDataToSendForDraft, isCommonSave = true) {
    if (!ValidationForHistoryExamIPD()) return false;

    var mrNo = GetSessionMRNO();
    var ipNo = sessionStorage.getItem("IPPatIPNO") || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";

    var model = {
        MRNO: mrNo,
        IPNO: ipNo,
        FreeComplaint: ($("#txtPresentingComplaint").val() || "").trim(),
        PresentIllness: ($("#txtHistoryPresentIllness").val() || "").trim(),
        PastHist: ($("#txtPastHistoryComorbidities").val() || "").trim(),
        ecog: $("input[name='rbtnECOGScore']:checked").val() || "",
        GeneralExam: ($("#txtGeneralExamination").val() || "").trim(),
        LocalExam: ($("#txtLocalExamination").val() || "").trim(),
        ProviDiagnosis: ($("#Diagnosis_Freetext").val() || "").trim() 
    };

    // 1. Save Textareas & ECOG
    $.ajax({
        type: "POST",
        url: "../SinglePage/SaveHistoryExamIPD",
        data: JSON.stringify({ model: model }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (res) {
            // Success response
        },
        error: function (xhr, status) {
            ToastMsg("Error saving History & Examination", "error");
        }
    });

    // 2. Automatically Save Personal History (Grid + Remarks)
    if (typeof savePersonalHistoryService_IPD === "function") {
        savePersonalHistoryService_IPD(isCommonSave);
    }

    // 3. Automatically Save Family History (Grid + Remarks)
    if (typeof SaveForFamilyHistory_IPD === "function") {
        SaveForFamilyHistory_IPD(isCommonSave);
    }
}


// Fetch and bind saved values when opening the patient
function GetHistoryExamIPD() {
    var mrNo = GetSessionMRNO();
    var ipNo = sessionStorage.getItem("IPPatIPNO") || $("#HeaderSection_PatDetails_ipNo").text().trim() || "";

    if (!mrNo) return;

    $.ajax({
        type: "POST",
        url: "../SinglePage/GetHistoryExamIPD",
        data: { ipno: ipNo, mrno: mrNo },
        dataType: "json",
        success: function (res) {
            if (res && res.success && res.data) {
                var d = res.data;
                if (d.FreeComplaint) { $("#txtPresentingComplaint").val(d.FreeComplaint); }
                if (d.PresentIllness) { $("#txtHistoryPresentIllness").val(d.PresentIllness); }
                if (d.PastHist) { $("#txtPastHistoryComorbidities").val(d.PastHist); }
                if (d.ecog) { $("input[name='rbtnECOGScore'][value='" + d.ecog + "']").prop("checked", true); }
                if (d.GeneralExam) { $("#txtGeneralExamination").val(d.GeneralExam); }
                if (d.LocalExam) { $("#txtLocalExamination").val(d.LocalExam); }

                if (d.ProviDiagnosis) { $("#Diagnosis_Freetext").val(d.ProviDiagnosis);  }


            }
        }
    });
}


function toggleTextareaHeight(btn, id) {
    var el = document.getElementById(id);
    if (!el) return;
    var $btn = $(btn);
    var src = $btn.attr("src") || "";

    if (src.indexOf("SortAscending") !== -1) {
        // Expand: Fit to content
        el.style.height = 'auto';
        var newHeight = Math.ceil(el.scrollHeight);
        el.style.height = (newHeight > 100 ? newHeight : 100) + 'px';
        el.style.overflowY = 'hidden';
        $btn.attr("src", src.replace("SortAscending", "SortDescending")).attr("title", "Set Default Height");
    } else {
        // Collapse: Reset to 100px standard height
        el.style.height = '100px';
        el.style.overflowY = 'auto';
        $btn.attr("src", src.replace("SortDescending", "SortAscending")).attr("title", "Fit to Content");
    }
}

</script>

