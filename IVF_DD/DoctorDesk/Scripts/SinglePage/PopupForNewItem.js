//Open Popup For Add New Item
function OpenPopupForNewItem(HeaderNM, Section) {
    closeAddNewItemPopup(Section);
    var MainDivID = "AdItem_M_" + Section;
    var HeaderDivID = "AdItem_H_" + Section;
    var CloseBtnID = "AdItem_H_Close_" + Section;
    var ContentID = "AdItem_C_" + Section;
    if (MainDivID === "AdItem_M_PersonalHistory" || MainDivID === "AdItem_M_PersonalMedicalHistory" || MainDivID === "AdItem_M_OPDPatAllergyHist") {
        var MinDiv = "<div id='" + MainDivID + "' class='AddNewItempopup AddCustomStyle'>{ALLPOPMAINCONTENT}</div>";
    }
    else {
        var MinDiv = "<div class='AddNewItempopup' id='" + MainDivID + "'>{ALLPOPMAINCONTENT}</div>";
    }
    var HeaderDiv = "<div class='AddNewItempopup-header' id='" + HeaderDivID + "'>{ALLPOPHEAD}</div>";
    if (HeaderNM === "Edit PAC Investigation") {
        var HeaderLbl = "<h5>" + HeaderNM + "</h5>";
    }
    else {
        var HeaderLbl = "<h5>Add New " + HeaderNM + "</h5>";
    }
    
    var CloseBtn = "<button id='" + CloseBtnID + "' class='btn btn-sm btn-danger' onclick=\"closeAddNewItemPopup('" + Section + "')\" tabindex='1' >✕</button>";
    var ContentDiv = "<div class='AddNewItempopup-body' id='" + ContentID + "'>{ALLPOPCONTENT}</div>";
    var FooterDiv = "<div class='AddNewItempopup-footer' id='" + ContentID + "'>{ALLPOPFOOTER}</div>";
    var Content = "";
    var FooterContent = "";
    if (Section == "Complaints") {
        Content = ContentForAddNewItemComplaints();
        FooterContent = FooterContentForAddNewItemComplaints();
    }
    if (Section == "Instruction") {
        Content = ContentForAddNewItemInstruction();
        FooterContent = FooterContentForAddNewItemInstruction();
    }
    if (Section == "UnCodedDiagnosis") {
        Content = ContentForAddNewItemUnCodedDiag();
        FooterContent = FooterContentForAddNewItemUnCodedDiag();
    }
    if (Section == "Medicine") {
        Content = ContentForAddNewItemMedicine();
        FooterContent = FooterContentForAddNewItemMedicine();
    }
    if (Section == "RX") {
        Content = ContentForAddNewItemRx();
        FooterContent = FooterContentForAddNewItemRx();
    }
    if (Section == "RxIntake") {
        Content = ContentForAddNewItemRxIntake();
        FooterContent = FooterContentForAddNewItemRxIntake();
    }
    if (Section == "RxRoute") {
        Content = ContentForAddNewItemRxRoute();
        FooterContent = FooterContentForAddNewItemRxRoute();
    }
    if (Section == "RxRemark") {
        Content = ContentForAddNewItemRxRemark();
        FooterContent = FooterContentForAddNewItemRxRemark();
    }
    if (Section == "PersonalHistory") {
        Content = ContentForAddNewItemPersonalHistory();
        FooterContent = FooterContentForAddNewItemPersonalHistory();
    }
    if (Section == "PersonalMedicalHistory") {
        Content = ContentForAddNewItemPersonalMedicalHistory();
        FooterContent = FooterContentForAddNewItemPersonalMedicalHistory();
    }

    if (Section == "OPDPatAllergyHist") {
        Content = ContentForAddNewItemOPDPatAllergy();
        FooterContent = FooterContentForAddNewItemOPDPatAllergy();
    }

    if (Section == "ExaminationSetup") {
        Content = ContentForAddNewItemExaminatonSetup();
        FooterContent = FooterContentForAddNewItemExaminatonSetup();
    }

    if (Section == "UnCodedDiagSetup") {
        Content = ContentForAddNewItemUnCodedDiagSetup();
        FooterContent = FooterContentForAddNewItemUnCodedDiagSetup();
    }

    if (Section == "InvestigationSetup") {
        Content = ContentForAddNewItemInvestigationSetup();
        FooterContent = FooterContentForAddNewItemInvestigationSetup();
    }

    if (Section == "InstructionSetup") {
        Content = ContentForAddNewItemInstructionSetup();
        FooterContent = FooterContentForAddNewItemInstructionSetup();
    }

    if (Section == "RXSetup") {
        Content = ContentForAddNewItemRXSetup();
        FooterContent = FooterContentForAddNewItemRXSetup();
    }

    if (Section == "ICDDiagSetup") {
        Content = ContentForAddNewItemICDDiagSetup();
        FooterContent = FooterContentForAddNewItemICDDiagSetup();
    }

    if (Section == "PACInvestigationSetup") { //priyanka 20/02/2026
        Content = ContentForAddNewItemPACInvestigationSetup();
        if (HeaderNM === "Edit PAC Investigation") {
            FooterContent = FooterContentForAddNewItemPACInvestigationSetup("Update");
        }
        else {
            FooterContent = FooterContentForAddNewItemPACInvestigationSetup("Save");
        }
    }
    if (Section == "ChemotherapyProtocol") {
        Content = ContentForAddNewItemChemoProtocolSetup();
        FooterContent = FooterContentForAddNewItemChemoProtocolSetup();
    }
    var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", (HeaderLbl + CloseBtn));
    var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", (Content));
    var RplFooterDiv = FooterDiv.replace("{ALLPOPFOOTER}", (FooterContent));
    var AddNewItemLoader = "<div id='loading-Complaints-New-Item' class='loading-screen' style='display: none; opacity: 0;'></div>";
    var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", (RplHeaderDiv + RplContentDiv + RplFooterDiv + AddNewItemLoader));
    $("body").append(RplMinDiv);
    if (Section == "ChemotherapyProtocol") {   //added by aaryshree 20260702
        $("#addmissionNo").hide();
        $("#txtNoOfAdmissions").val("").hide();
        $("#txtDuration").on("input", function () {
            if ($(this).val().trim() !== "") {
                $(this).css("border-color", "");
            }
        });

        $("#txtNoOfAdmissions").on("input", function () {
            if ($(this).val().trim() !== "") {
                $(this).css("border-color", "");
            }
        });
    }
    document.getElementById("popupOverlay").style.display = "block";
    if (Section == "Complaints") {
        $("#txtComplaint").focus();
    }
    if (Section == "Complaints") {
        $("#txtInstruction").focus();
    }
    if (Section == "UnCodedDiagnosis") {
        $("#txtUnCodedDiag").focus();
    }
    if (Section == "Medicine") {
        $("#txtMedicine").focus();
        $("#txtGeneric").focus();
        $("#txtBrand").focus();
    }
    if (Section == "RX") {
        $("#txtRx").focus();
    }
    if (Section == "RxIntake") {
        $("#txtRxIntake").focus();
    }
    if (Section == "RxRoute") {
        $("#txtRxRoute").focus();
    }
    if (Section == "RxRemark") {
        $("#txtRxRemark").focus();
    }
    if (Section == "PersonalHistory") {
        $("#txtPersonalHistory").focus();
    }

    if (Section == "PersonalMedicalHistory") {
        $("#txtPersonalMedicalHistory").focus();
    }
    if (Section == "UnCodedDiagSetup") {
        CreateUnicodedDiagSetupNewTabultor();
    }
    if (Section == "InvestigationSetup") {
        CreateInvestigationSetupNewTabultor();
    }
    if (Section == "InstructionSetup") {
        CreateInstructionSetupNewTabultor();
    }
    if (Section == "RXSetup") {
        CreateRXSetupNewTabultor();
    }
    if (Section == "ICDDiagSetup") {
        CreateICDDiagSetupNewTabultor();
    }
    if (Section == "PACInvestigationSetup") {//priyanka 20/02/2026
        CreatePACInvestigationSetupNewTabultor();
    }
    if (Section == "ChemotherapyProtocol") {
        BindAdmissionGrid();
    }
}

//Close Popup For Add New Item
function closeAddNewItemPopup(Section) {
    var MainDivID = "AdItem_M_" + Section;
    document.getElementById("popupOverlay").style.display = "none";
    if (document.getElementById(MainDivID)) {
        document.getElementById(MainDivID).style.display = "none";
        document.getElementById(MainDivID).remove();
    }
}
