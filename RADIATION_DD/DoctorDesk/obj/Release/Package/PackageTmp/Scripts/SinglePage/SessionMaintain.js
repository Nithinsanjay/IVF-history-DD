/*************************************************
 * PATIENT DATA CONTRACT
 * 
 * NOTE:
 * - Keys defined here MUST be used everywhere
 * - Developers must follow this structure
 *************************************************/
const PATIENT_DATA_KEYS = {
    PATIENT_NAME: "PATIENT_NAME",
    MRNO: "MRNO",
    CONSULTATION_NO: "CONSULTATION_NO",
    DOCTOR_ID: "DOCTOR_ID"
};
//PRIYANKA 06/01/2026
const PATIENT_INFO_KEYS = {
    PatEmail: "PatEmail",
    PatMRNO: "PatMRNO",
    PatTRANNO: "PatTRANNO",
    PatCompleted: "PatCompleted",
    PatAge: "PatAge",
    PatGender: "PatGender",
    PatName: "PatName",
    PatContokNo: "PatContokNo",
    OPDPatImgURL: "OPDPatImgURL",
    OPDPatMobile: "OPDPatMobile",
    OPDCompCode: "OPDCompCode",
    OPDCompNM: "OPDCompNM",
    PAGEFROM: "PageFrom",
    ConsultDoctorName: "ConsultDoctorName",
    ConsultDoctorCode: "ConsultDoctorCode",
};

const IPD_PATIENT_INFO_KEYS = {
    IPPatName: "IPPatName",
    IPPatIPNO: "IPPatIPNO",
    IPPatAge: "IPPatAge",
    IPPatGender: "IPPatGender",
    IPPatMRNO: "IPPatMRNO",
    IPPatNurstaionNM: "IPPatNurstaionNM",
    IPPatWard: "IPPatWard",
    IPPatBedNo: "IPPatBedNo",
    IPPatAdmnDoctCode: "IPPatAdmnDoctCode",
    IPPatCaseTypeID: "IPPatCaseTypeID",
    IPDPatImgURL: "IPDPatImgURL",
    IPDADMNDATETIME: "IPDADMNDATETIME",
    IPDADMNDATE: "IPDADMNDATE",
    IPDCompCode: "IPDCompCode", /*priyanka 04/05/2026*/
    IPDCompNM: "IPDCompNM" /*priyanka 04/05/2026*/
};

const SHOW_ALL_PATIENTS = {
    SrchByDoctYN: "SrchByDoctYN"
}

const PAC_SHOW_ALL_PATIENTS = { //priyanka 23/02/2026
    PACSrchByDoctYN: "PACSrchByDoctYN"
}

//CLINIC SELECTION
const CLINIC_DTLS = {
    ClinicCode: "ClinicCode",
    ClinicName: "ClinicName",
    ClinicType: "ClinicType"
}

const PAC_PATIENT_INFO_KEYS = {
    PACTOKENNO: "PACTOKENNO",
    PACConsltNo: "PACConsltNo",
    PACAdvConsltNo: "PACAdvConsltNo",
    PACSTATUS: "PACSTATUS",
    PACPatMRNO: "PACPatMRNO",
    PACPatName: "PACPatName",
    PACPatAge: "PACPatAge",
    PACPatGender: "PACPatGender",
    PACRefDoctor: "PACRefDoctor",
    PACSurgName: "PACSurgName",
    PACNatureSurg: "PACNatureSurg",
    PACDPatImgURL: "PACDPatImgURL",
    PACRefPACTranNo: "PACRefPACTranNo", //priyanka 19/02/2026
    ConsultDoctorName: "ConsultDoctorName"
};

const PAC_SEARCH_KEYS = {
    PACClinicWise: "PACClinicWise",
    PACConsultDate: "PACConsultDate"
};


const IPD_SEARCH_INFO_KEYS = {
    IPCmbDoct: "IPCmbDoct",
    IPAllPat: "IPAllPat",
    IPMyPat: "IPMyPat",
    IPRefPat: "IPRefPat",
    IPSearchTxt: "IPSearchTxt",       // Abhishesh || 20260902
    IPNursStation: "IPNursStation"    // Abhishesh || 20260902
};

/*************************************************
 * CLEAR ALL SESSION
 *************************************************/
function clearAllSession() {
    sessionStorage.clear();
}

/*************************************************
 * SET / REMOVE MODULE FLAG (OPD / IPD / PAC)
 *************************************************/
function setModuleSession(isModuleAdd, moduleFlag) {
    if (isModuleAdd) {
        sessionStorage.setItem("MODULE_FLAG", moduleFlag);
    } else {
        sessionStorage.removeItem("MODULE_FLAG");
    }
}

/*************************************************
 * OPD PATIENT CLICK HANDLER
 *************************************************/
function SetOPDPatInfoClick(isSessionAdd, dataObject)
{
    setModuleSession(true, "OPD");
    if (isSessionAdd) {
        sessionStorage.setItem(PATIENT_INFO_KEYS.PatEmail, dataObject.PatEmail);
        sessionStorage.setItem(
            PATIENT_INFO_KEYS.PatMRNO,
            dataObject.PatMRNO
        );
        sessionStorage.setItem(PATIENT_INFO_KEYS.PatTRANNO, dataObject.PatTRANNO);
        sessionStorage.setItem(PATIENT_INFO_KEYS.PatCompleted, dataObject.PatCompleted);
        sessionStorage.setItem(PATIENT_INFO_KEYS.PatAge, dataObject.PatAge);
        sessionStorage.setItem(PATIENT_INFO_KEYS.PatGender, dataObject.PatGender);
        sessionStorage.setItem(PATIENT_INFO_KEYS.PatName, dataObject.PatName);
        sessionStorage.setItem(PATIENT_INFO_KEYS.PatContokNo, dataObject.PatContokNo);
        sessionStorage.setItem(PATIENT_INFO_KEYS.OPDPatImgURL, dataObject.OPDPatImgURL);
        sessionStorage.setItem(PATIENT_INFO_KEYS.OPDPatMobile, dataObject.OPDPatMobile);
        sessionStorage.setItem(PATIENT_INFO_KEYS.OPDCompCode, dataObject.OPDCompCode);
        sessionStorage.setItem(PATIENT_INFO_KEYS.OPDCompNM, dataObject.OPDCompNM);
        sessionStorage.setItem(PATIENT_INFO_KEYS.PAGEFROM, dataObject.PAGEFROM);
        sessionStorage.setItem(PATIENT_INFO_KEYS.ConsultDoctorName, dataObject.ConsultDoctorName);
        sessionStorage.setItem(PATIENT_INFO_KEYS.ConsultDoctorCode, dataObject.ConsultDoctorCode);
    }
    else {
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatEmail);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatMRNO);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatTRANNO);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatCompleted);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatAge);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatGender);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatName);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PatContokNo);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.OPDPatImgURL);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.OPDPatMobile);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.OPDCompCode);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.OPDCompNM);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.PAGEFROM);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.ConsultDoctorName);
        sessionStorage.removeItem(PATIENT_INFO_KEYS.ConsultDoctorCode);
    }
}

function SetShowAllPatList(isSessionAdd, dataObject) {
    if (isSessionAdd)
    {
        sessionStorage.setItem(SHOW_ALL_PATIENTS.SrchByDoctYN, dataObject.SrchByDoctYN);
    }
    else
    {
        sessionStorage.removeItem(SHOW_ALL_PATIENTS.SrchByDoctYN);
    }
   
}

function SetShowAllPACPatList(isSessionAdd, dataObject) {
    if (isSessionAdd) {
        sessionStorage.setItem(PAC_SHOW_ALL_PATIENTS.PACSrchByDoctYN, dataObject.PACSrchByDoctYN);
    }
    else {
        sessionStorage.removeItem(PAC_SHOW_ALL_PATIENTS.PACSrchByDoctYN);
    }

}

/*************************************************
 * IPD PATIENT CLICK HANDLER
 *************************************************/
function SetIPDPatSearch(isSessionAdd, dataObject) {
    if (isSessionAdd) {
        sessionStorage.setItem(IPD_SEARCH_INFO_KEYS.IPCmbDoct, dataObject.IPCmbDoct);
        sessionStorage.setItem(IPD_SEARCH_INFO_KEYS.IPAllPat, dataObject.IPAllPat);
        sessionStorage.setItem(IPD_SEARCH_INFO_KEYS.IPMyPat, dataObject.IPMyPat);
        sessionStorage.setItem(IPD_SEARCH_INFO_KEYS.IPRefPat, dataObject.IPRefPat);
        sessionStorage.setItem(IPD_SEARCH_INFO_KEYS.IPSearchTxt, dataObject.IPSearchTxt);       //Abhishesh || 20260902
        sessionStorage.setItem(IPD_SEARCH_INFO_KEYS.IPNursStation, dataObject.IPNursStation);   //Abhishesh || 20260902
    }
    else {
        sessionStorage.removeItem(IPD_SEARCH_INFO_KEYS.IPCmbDoct);
        sessionStorage.removeItem(IPD_SEARCH_INFO_KEYS.IPAllPat);
        sessionStorage.removeItem(IPD_SEARCH_INFO_KEYS.IPMyPat);
        sessionStorage.removeItem(IPD_SEARCH_INFO_KEYS.IPRefPat);
        sessionStorage.removeItem(IPD_SEARCH_INFO_KEYS.IPSearchTxt);    //Abhishesh || 20260902
        sessionStorage.removeItem(IPD_SEARCH_INFO_KEYS.IPNursStation); //Abhishesh || 20260902
    }
}

function SetIPDPatInfoClick(isSessionAdd, dataObject)//Priyanka 07/01/2026  
{
    setModuleSession(true, "IPD");

    if (isSessionAdd) {
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatName, dataObject.IPPatName);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatIPNO, dataObject.IPPatIPNO);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatAge, dataObject.IPPatAge);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatMRNO, dataObject.IPPatMRNO);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatGender, dataObject.IPPatGender);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatWard, dataObject.IPPatWard); 
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatBedNo, dataObject.IPPatBedNo);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatAdmnDoctCode, dataObject.IPPatAdmnDoctCode);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatCaseTypeID, dataObject.IPPatCaseTypeID);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPDPatImgURL, dataObject.IPDPatImgURL);
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPPatNurstaionNM, dataObject.IPPatNurstaionNM); 
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPDADMNDATETIME, dataObject.IPDADMNDATETIME); 
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPDADMNDATE, dataObject.IPDADMNDATE); 
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPDCompCode, dataObject.IPDCompCode); //priyanka 04/05/2026
        sessionStorage.setItem(IPD_PATIENT_INFO_KEYS.IPDCompNM, dataObject.IPDCompNM); //priyanka 04/05/2026
    }
    else {
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatName);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatIPNO);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatAge);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatMRNO);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatGender);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatWard);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatBedNo);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatAdmnDoctCode);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatCaseTypeID);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPDPatImgURL);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPPatNurstaionNM);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPDADMNDATETIME);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPDADMNDATE);
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPDCompCode); //priyanka 04/05/2026
        sessionStorage.removeItem(IPD_PATIENT_INFO_KEYS.IPDCompNM); //priyanka 04/05/2026
    }
}



/*************************************************
 * PAC PATIENT CLICK HANDLER
 *************************************************/
function SetPACPatInfoClick(isSessionAdd, dataObject) {
    setModuleSession(true, "PAC");

    if (isSessionAdd) {
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACTOKENNO, dataObject.PACTOKENNO);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACConsltNo, dataObject.PACConsltNo);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACAdvConsltNo, dataObject.PACAdvConsltNo);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACSTATUS, dataObject.PACSTATUS);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACPatMRNO, dataObject.PACPatMRNO);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACPatName, dataObject.PACPatName);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACPatAge, dataObject.PACPatAge);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACPatGender, dataObject.PACPatGender);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACRefDoctor, dataObject.PACRefDoctor);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACSurgName, dataObject.PACSurgName);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACNatureSurg, dataObject.PACNatureSurg);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACDPatImgURL, dataObject.IPDPatImgURL);
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.PACRefPACTranNo, dataObject.PACRefPACTranNo);//priyanka 19/02/2026
        sessionStorage.setItem(PAC_PATIENT_INFO_KEYS.ConsultDoctorName, dataObject.ConsultDoctorName);
    }
    else {
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACTOKENNO);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACConsltNo);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACAdvConsltNo);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACSTATUS);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACPatMRNO);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACPatName);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACPatAge);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACPatGender);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACRefDoctor);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACSurgName);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACNatureSurg);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACDPatImgURL);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.PACRefPACTranNo);
        sessionStorage.removeItem(PAC_PATIENT_INFO_KEYS.ConsultDoctorName);
    }
}

function SetPACSearchFilter(isSessionAdd, dataObject) {
    setModuleSession(true, "PAC");
    if (isSessionAdd) {
        sessionStorage.setItem(PAC_SEARCH_KEYS.PACClinicWise, dataObject.PACClinicWise);
        sessionStorage.setItem(PAC_SEARCH_KEYS.PACConsultDate, dataObject.PACConsultDate);
    }
    else {
        sessionStorage.removeItem(PAC_SEARCH_KEYS.PACClinicWise);
        sessionStorage.removeItem(PAC_SEARCH_KEYS.PACConsultDate);
    }
}
/*************************************************
 * CLINIC CLICK
 *************************************************/
function handleClinicClick(isSessionAdd, dataObject) {
    if (isSessionAdd) {
        sessionStorage.setItem(CLINIC_DTLS.ClinicCode, dataObject.ClinicCode);
        sessionStorage.setItem(CLINIC_DTLS.ClinicName, dataObject.ClinicName);
        sessionStorage.setItem(CLINIC_DTLS.ClinicType, dataObject.ClinicType);
    } else {
        sessionStorage.removeItem(CLINIC_DTLS.ClinicCode);
        sessionStorage.removeItem(CLINIC_DTLS.ClinicName);
        sessionStorage.removeItem(CLINIC_DTLS.ClinicType);
    }
}

function GetSessionMRNO() {
    if (sessionStorage.getItem("MODULE_FLAG") == "OPD")
        return sessionStorage.getItem("PatMRNO");
    if (sessionStorage.getItem("MODULE_FLAG") == "IPD")
        return sessionStorage.getItem("IPPatMRNO");
    if (sessionStorage.getItem("MODULE_FLAG") == "PAC")
        return sessionStorage.getItem("PACPatMRNO");
}

function GetSessionPatName() {
    if (sessionStorage.getItem("MODULE_FLAG") == "OPD")
        return sessionStorage.getItem("PatName");
    if (sessionStorage.getItem("MODULE_FLAG") == "IPD")
        return sessionStorage.getItem("IPPatName");
    if (sessionStorage.getItem("MODULE_FLAG") == "PAC")
        return sessionStorage.getItem("PACPatName");
}

function RedirectToDICOM() { //priyanka 14/03/2026
    if (sessionStorage.getItem("MODULE_FLAG") == "OPD")
        return OPDLocalDicomURL;
    if (sessionStorage.getItem("MODULE_FLAG") == "IPD")
        return IPDLocalDicomURL;
    if (sessionStorage.getItem("MODULE_FLAG") == "PAC")
        return PACLocalDicomURL;
}

function Signout() {
    SetOPDPatInfoClick(false, "");
    handleClinicClick(false, "");
    SetShowAllPatList(false, "");
    SetShowAllPACPatList(false, "");
    SetIPDPatInfoClick(false, "");
    SetPACPatInfoClick(false, "");
    SetPACSearchFilter(false, "");
    setModuleSession(false, "");
    SetIPDPatSearch(false, "");
    if (RedirectToDD === "Y") {
        window.location.href = "../Account/Login";
    }
    else {
        GoToHome("Login");
    }
}