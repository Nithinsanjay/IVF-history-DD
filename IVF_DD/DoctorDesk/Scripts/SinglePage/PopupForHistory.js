//Open Popup
function HistoryPopupOpen(HeaderNM, Section, MaxFlag, GetData) {
    startLoading("Loading");
    var MainDivID = "Hist_M_" + Section;
    var HeaderDivID = "Hist_H_" + Section;
    var MiniBtnID = "Hist_H_Min_" + Section;
    var MaxBtnID = "Hist_H_Max_" + Section;
    var CloseBtnID = "Hist_H_Close_" + Section;
    var ContentID = "Hist_C_" + Section;
    var MinDiv = "<div class='MaxMinpopup " + (MaxFlag == true ? 'maximized' : '') + "' id='" + MainDivID + "' style='display:none;'>{ALLPOPMAINCONTENT}</div>";
    var HeaderDiv = "<div class='MaxMinpopup-header' id='" + HeaderDivID + "'>{ALLPOPHEAD}</div>";
    var HeaderLbl = "<h5>" + HeaderNM + "</h5>";
    var MiniBtn = "<button id='" + MiniBtnID + "' class='btn btn-sm btn-light' onclick=\"minimizePopup('" + MainDivID + "')\" >—</button>";
    var MaxBtn = "<button id='" + MaxBtnID + "' class='btn btn-sm btn-light' onclick=\"maximizePopup('" + MainDivID + "')\" >⬜</button>";
    var CloseBtn = "<button id='" + CloseBtnID + "' class='btn btn-sm btn-danger' onclick=\"closeMaxMinPopup('" + MainDivID + "')\" >✕</button>";
    var ContentDiv = "<div class='MaxMinpopup-body' id='" + ContentID + "'>{ALLPOPCONTENT}</div>";
    var Content = "";
    if (Section == "Complaints") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopComplaintsTemp(Data, ContentID);
        if (Content == "" || Content == '<div class="history-list-wrapper"></div>') {
            ToastMsg("No Data Found.", "info");
            stopLoading();
            return;
        }
    }
    else if (Section == "Examination") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopExaminationTemp(Data, ContentID);
        if (Content == "" || Content == '<div class="history-list-wrapper"></div>') {
            ToastMsg("No Data Found.", "info");
            stopLoading();
            return;
        }
    }
    else if (Section == "ClinicalNotes") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindClinicalNotesPrevHistory();
        if (IsClinicNotesFreeTxtVisible === "Y") {//priyanka 10/04/2026
            Content = HistPopClinicalHistoryTemp(Data, ContentID);
        }
        else {
            Content = HistPopHTMLClinicalHistoryTemp(Data, ContentID);
        }
        //end

        if (Content == "" || Content == '<div class="history-list-wrapper"></div>') {
            ToastMsg("No Data Found.", "info");
            stopLoading();
            return;
        }
    }
    else if (Section == "Instruction") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopInstructionTemp(Data, ContentID);
    }
    else if (Section == "RX") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopRxTemp(Data, ContentID);
    }
    else if (Section == "Investigations") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopInvestigationsTemp(Data, ContentID);
    }
    else if (Section == "UnCodedDiagnosis") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopUnCodedDiagonsisTemp(Data, ContentID);
    }
    else if (Section == "ICDDiagnosis") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopUnICDDiagonsisTemp(Data, ContentID);
    }
    else if (Section == "ICDODiagnosis" || Section == "ICDODFinaldiagnosis") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = Section == "ICDODFinaldiagnosis" ? GetICDOHist("Final") : GetICDOHist();
        Content = BindICDOHist(Data, ContentID);
        if (Content == "" || Content == '<div class="history-list - wrapper"></div></div>') {
            Section == "ICDODFinaldiagnosis" ? ToastMsg("For Final Diagnosis No Data Found.", "info") : ToastMsg("No Data Found.", "info");
            stopLoading();
            return;
        }
    }
    else if (Section == "PatientInfo") {
        MaxBtn = "";
        MiniBtn = "";
        var Response = GetBindPatandBillInfo();
        var Data = MapPatientData(Response);
        var Resoponse2 = GetBillInfo();
        var BillData = MapBillData(Resoponse2);
        if (Data)
            Content = HistPopPatientInfoTemp(Data, BillData);
    }
    else if (Section == "EditVitalsInfo") {
        MaxBtn = "";
        MiniBtn = "";
        var Response = GetVitalDetailsInfo();
        var Data = MapVitalsData(Response);
        Content = HistPopEditVitalDetailsTemp(Data, "");
    }
    else if (Section == "Notes") {
        MaxBtn = "";
        MiniBtn = "";
        Content = NotesTemp();
    }
    else if (Section == "Upload") {
        MaxBtn = "";
        MiniBtn = "";
        Content = UploadTemp();
    }
    else if (Section == "VisitHistory") {
        MaxBtn = "";
        MiniBtn = "";
        Content = VisitHistoryTemp();
    }
    else if (Section == "VitalHistory") {
        MaxBtn = "";
        MiniBtn = "";
        Content = PatientVitalsHistoryTemp();
    }
    else if (Section == "AllNotes") {
        MaxBtn = "";
        MiniBtn = "";
        Content = AllNotesTemp();
    }
    else if (Section == "ChemoSchemeInfo") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = GetSchemeInfo(GetData.code);
        Content = HistPopChemPlanSchemeInfo(Data);
    }
    else if (Section == "ChemoPlanningHist") {
        MaxBtn = "";
        MiniBtn = "";
        var ChemoPrevHistData = PatMedicationHistory();
        Content = HistPopChemoPlanPrevHistTemp(ChemoPrevHistData);
    }
    else if (Section == "FamilyHistory") {
        MaxBtn = "";
        MiniBtn = "";
        Content = getFamilyHistoryContent();
    }
    else if (Section == "PersonalHistory") {
        MaxBtn = "";
        MiniBtn = "";
        Content = getPersonalHistoryContent();
    }
    else if (Section == "PatientMedicalHistory") {
        MaxBtn = "";
        MiniBtn = "";
        Content = getPatientMedicalHistoryContent();
    }
    else if (Section == "MedicalHistory") {
        MaxBtn = "";
        MiniBtn = "";
        Content = getMedicalHistoryContent();
    }
    else if (Section == "AllergySection") {
        MaxBtn = "";
        MiniBtn = "";
        Content = getAllergyHistoryContent();
    }
    else if (Section == "AdviceSchemeInfo") {
        MaxBtn = "";
        MiniBtn = "";
        var Data = AdviceGetSchemeInfo(GetData.code);
        Content = HistPopAdviceSchemeInfo(Data);
    }
    else if (Section == "EMRRecordsView") {
        MaxBtn = "";
        MiniBtn = "";
        Content = getEMRRecordContent();
    }
    else if (Section == "AdviceHist") {
        var Data = GetBindPrevHistoryDtls();
        Content = HistPopAdviceHistTemp(Data, ContentID);
    }
    else if (Section == "PACPrint") { //Priyanka 20/02/2026
        MaxBtn = "";
        MiniBtn = "";
        Content = GetPACPrintView();
    }
    else if (Section == "SurgicalHistory") {

        MaxBtn = "";
        MiniBtn = "";
        Content = getSurgicalHistoryContent();
    }
    else if (Section == "OTBKList") { //priyanka 05/05/2026
        MaxBtn = "";
        MiniBtn = "";
        Content = GetOTBookingRequestList();
    }

    if (!hasHistoryData(Content)) {
        stopLoading();
        ToastMsg("No records found", "info");
        return; // This exits the function so the box never opens
    }

    var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", (HeaderLbl + MiniBtn + MaxBtn + CloseBtn));
    var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", (Content));
    var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", (RplHeaderDiv + RplContentDiv));
    $("body").append(RplMinDiv);
    openMaxMinPopup(MainDivID);

    if (Section === "Complaints") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncComplaints();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }

    if (Section === "Examination") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncExamination();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }

    if (Section === "ClinicalNotes") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncClinicalNotes();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }

    if (Section === "Notes") {
        MaxBtn = "";
        MiniBtn = "";
        GetNotes("Y");
    }

    if (Section === "Instruction") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncInstruction();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }
    if (Section === "Investigations") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncInvestigations();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }
    if (Section == "UnCodedDiagnosis") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncUnCodedDiagonsis();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }
    if (Section == "ICDDiagnosis") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncICDDiagonsis();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }

    if (Section == "ICDODiagnosis") {
        MaxBtn = "";
        MiniBtn = "";
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }

    if (Section === "EditVitalsInfo") {
        MaxBtn = "";
        MiniBtn = "";
        BindNutritionalData(Data);
        BindVitalsComboData(Data);
        PatCompletedDisableFields();
        SetWeightLoss();
    }

    if (Section == "VisitHistory") {
        BindPatientHistoryData(0); /*vandana 200226*/
    }

    if (Section === "RX") {
        MaxBtn = "";
        MiniBtn = "";
        CopyFuncRx();
        Content = (Content == "" || Content == '<div class="history-list-wrapper"></div>') ? NoDataFound("No Data Found.", ContentID, "NoDataFoundStyle2", "NoDataFoundStyle2h2") : Content;
    }

    if (Section == "OTBKList") { //priyanka 05/05/2026
        GetOTBookingRequestListGridData();
    }

    stopLoading();
}
//Get Previous History
function GetBindPrevHistoryDtls() {
    var Result = [];
    var MRno = GetSessionMRNO(); 
    $.ajax({
        type: "POST",
        url: '../DoctorDesk/GetMedicationtHistory',
        datatype: "json",
        async: false,
        data: { strMrNo: MRno, FromDate: "", ToDate: "", DoctCode: "" },
        success: function (Response) {
            Result = Response;
        }
    });
    return Result;
}

function ConvertTo12Hour(SType, FTime) {
    var FormatedTime = FTime;
    if (SType === "O") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    else if (SType === "P") {

    }
    else if (SType === "S") {
    }
    else if (SType === "C") {

    }
    else if (SType === "R") {

    }
    else if (SType === "N") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    else if (SType === "D") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    return FormatedTime;
}
function hasHistoryData(content) {
    if (!content) return false;

    // Remove whitespace and check if it's just an empty container
    var cleanContent = content.trim();
    var emptyWrapper = '<div class="history-list-wrapper"></div>';

    if (cleanContent === "" || cleanContent === emptyWrapper) {
        return false;
    }

    return true;
}