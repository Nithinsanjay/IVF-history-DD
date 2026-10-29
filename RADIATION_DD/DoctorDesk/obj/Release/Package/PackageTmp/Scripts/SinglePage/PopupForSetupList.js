//Open Popup For Setup List
function OpenPopupForExaminationSetupList() {
    return `
       <div id="OverlaySetup"></div>
       <div class="SetupPopup">
         <div class="SetupPopup-Header">
            <h5 class="SetupPopup-Header-Lbl">Setup Examination</h5>
            <button class="btn btn-sm btn-danger SetupPopup-Header-Close">✕</button>
         </div>
         <div class="SetupPopup-Content">
            <div class="TabulatorTableSetupList" id="SetupList"></div>
         </div>
         <div class="SetupPopup-Footer">
            <button class="btn btn-sm btn-Success SetupPopup-Footer-Save">Apply</button>
         </div>
       </div>
    `;
}




function OpenPopupForSetupList(HeaderNM, Section) {
    startLoading("Loading");
    var MainDivID = "Setup_M_" + Section;
    var MinDiv = "<div class='Setuppopup' id='" + MainDivID + "' style='display:none;'>{ALLPOPMAINCONTENT}</div>";
    var HeaderDivID = "Setup_H_" + Section;
    var CloseBtnID = "Setup_H_Close_" + Section;
    var ContentID = "Setup_C_" + Section;
    var HeaderDiv = "<div class='SetupPopup-header' id='" + HeaderDivID + "'>{ALLPOPHEAD}</div>";
    var HeaderLbl = "<h5>" + HeaderNM + "</h5>";
    var CloseBtn = "<button id='" + CloseBtnID + "' class='btn btn-sm btn-danger' onclick=\"closeSetupPopup('" + MainDivID + "')\" >✕</button>";
    var ContentDiv = "<div class='SetupPopup-body' id='" + ContentID + "'>{ALLPOPCONTENT}</div>";
    var Content = "";
    if (Section == "Examination") {
        var Data = GetSetupListForExamination();
        Content = OpenPopupForExaminationSetupList(Data, ContentID);
    }
    var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", (HeaderLbl + CloseBtn));
    var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", (Content));
    var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", (RplHeaderDiv + RplContentDiv));
    $("body").append(RplMinDiv);
    stopLoading();
}

//Close Popup For Setup List
function closeSetupPopup(MainDivID) {
    $("#" + MainDivID).remove();
}

//Examination Popup Data
function GetSetupListForExamination() {
    return [];
}
//Examination Popup Template
function HistPopExaminationTemp(Data, ContentID) {
    return `
      <div class="SetupPopup-Top-Div">
          <input type="text" class="form-control" id="txtSearchExaminSetup" />
          <button class="btn btn-outline-success" id="SetupExamAdd" onclick="OpenPopupForSetupNewItem('Examination Template Setup' , 'ExaminationSetup')"><i class="fa fa-plus"></i></button>
      </div>
      <div class="Setup-List" id="ExaminationSetupTable"></div>;
    `;
}

function SetupPopupOpen(HeaderNM, Section, MaxFlag, GetData)
{
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
    var TabulatorSetupId = "Setup_" + Section;
    var ContentDiv = "<div class='MaxMinpopup-body' id='" + ContentID + "'>{ALLPOPCONTENT}<div id=" + TabulatorSetupId + "></div></div>";
    var Content = "";
    if (Section == "Examination") {
        MaxBtn = "";
        MiniBtn = "";
        Content = SetupPopupExaminationContent();
    }
    else if (Section == "UnCodedDiag") {
        MaxBtn = "";
        MiniBtn = "";
        Content = SetupPopupUnCodedDiagContent();
    }
    else if (Section == "ICDDiag") {
        MaxBtn = "";
        MiniBtn = "";
        Content = SetupPopupICDDiagContent();
    }
    else if (Section == "ClinicalNotes") {
        MaxBtn = "";
        MiniBtn = "";
        Content = SetupPopupClinicalNotesContent();
    }
    else if (Section == "Investigation") {
        MaxBtn = "";
        MiniBtn = "";
        Content = SetupPopupInvestigationContent();
    }
    else if (Section == "Instruction") {
        MaxBtn = "";
        MiniBtn = "";
        Content = SetupPopupInstructionContent();
    }
    else if (Section == "RX") {
        MaxBtn = "";
        MiniBtn = "";
        Content = SetupPopupRXContent();
    }
    else if (Section == "PACInvestigation") {//priyanka 20/02/2026
            MaxBtn = "";
            MiniBtn = "";
            Content = SetupPopupPACInvestigationContent();
        }

    var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", (HeaderLbl + MiniBtn + MaxBtn + CloseBtn));
    var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", (Content));
    var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", (RplHeaderDiv + RplContentDiv));
    $("body").append(RplMinDiv);
    openMaxMinPopup(MainDivID);
    if (Section == "Examination") {
        CreateTabulatorExamSetup(TabulatorSetupId);
        BindExaminationSetupList(TabulatorSetupId);
    }
    else if (Section == "UnCodedDiag") {
        CreateTabulatorUnCodedDiagSetup(TabulatorSetupId);
        BindUnCodedDiagSetupList(TabulatorSetupId);
    }
    else if (Section == "ICDDiag") {
        CreateTabulatorICDDiagSetup(TabulatorSetupId);
        BindICDDiagSetupList(TabulatorSetupId);
    }
    else if (Section == "ClinicalNotes") {
        CreateTabulatorClinicNotesSetup(TabulatorSetupId);
        BindClinicNotesSetupList(TabulatorSetupId);
    }
    else if (Section == "Investigation") {
        CreateTabulatorInvestigationSetup(TabulatorSetupId);
        BindInvestigationSetupList(TabulatorSetupId);
    }
    else if (Section == "Instruction") {
        CreateTabulatorInstructionSetup(TabulatorSetupId);
        BindInstructionSetupList(TabulatorSetupId);
    }
    else if (Section == "RX") {
        CreateTabulatorRXSetup(TabulatorSetupId);
        BindRXSetupList(TabulatorSetupId);
    }
    else if (Section == "PACInvestigation") {//priyanka 20/02/2026
        CreateTabulatorPACInvestigationSetup(TabulatorSetupId);
        BindPACInvestigationSetupList(TabulatorSetupId);
    }
    stopLoading();
}