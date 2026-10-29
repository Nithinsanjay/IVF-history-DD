

var HeaderLang = [];

var EnglishHeader = ["Complaints", "Vital Data", "Diagnosis", "Instructions", "Investigations / Procedures", "Treatment Advice",
    "Medicine Name", "Generic Name", "Follow Up After", "Chemo Planning", "Examination", "Cross Reference to Other Oncologist", "Personal History", "Medical History", "Family History",
    "Refer to Specialist", "Remark", "Complaint", "Plan Of Treatment", "Provisional Diagnosis", "Examination History", "Chemo Planning"]
var DaysContainer = [];
var EnglishDays = ["Day", "Week", "Month", "Year"];
var HindiDays = ["दिन", "सप्ताह", "महीने", "साल"];
var MarathiDays = ["दिवस", "आठवडा", "महिना", "वर्ष"];
var GujaratDays = ["દિવસ", "સપ્તાહ", "મહિનો", "વર્ષ"];
var languageWise = "";
var IntakeLanguage = "";
var BeforFoodData = "";
var AfterFoodData = "";
var language = "NAME";
var digitsign1 = "";
var digitsign2 = "";
var digitsign3 = "";
var sign1 = "";
var sign2 = "";
var sign3 = "";
var BottomLine1 = "";
var BottomLine2 = "";
var hindiHeader = ["मुख्य शिकायतें", "सामान्य परीक्षाएं", "निदान", "सलाह", "जांच के लिए सलाह", "उपचार सलाह", "दवाई", "सामान्य नाम", "अगला चेक अप", "बाद", "जांच के बाद", "रेफ़रल चिकित्सक", "व्यक्तिगत इतिहास", "चिकित्सा का इतिहास", "परिवार के इतिहास", 'टिप्पणी', 'नि: शुल्क शिकायत', 'इतिहास'] //विगत इतिहास
var marathiHeader = ["मुख्य तक्रारी", "सामान्य परीक्षा", "निदान", "सल्ला", "तपासणीसाठी सल्ला", "उपचार सल्ला", "औषधे", "सामान्य नाव", "पुढील तपासणी", "नंतर", "तपासणी नंतर", "संदर्भित डॉक्टर", "वैयक्तिक इतिहास", "वैद्यकीय इतिहास", "कौटुंबिक इतिहास", "टिप्पणी", "विनामूल्य तक्रार", 'इतिहास'] //भूतकाळ इतिहास
var gujaratiHeader = ["મુખ્ય ફરિયાદો", "સામાન્ય પરીક્ષાઓ", "નિદાન", "સલાહ", "તપાસ માટે સલાહ", "સારવાર સલાહ", "દવાઓ", "સામાન્ય નામ", "આગામી ચેકઅપ", "પછી", "ચેકઅપ પછી", "સંદર્ભિત ડોક્ટર", "વ્યક્તિગત ઇતિહાસ", "તબીબી ઇતિહાસ", "પારિવારિક ઇતિહાસ", "ટિપ્પણી", "નિઃશુલ્ક ફરિયાદ", 'ઇતિહાસ']//ભૂતકાળ ઇતિહાસ
var AfterFood = [" After Food", " भोजन के बाद", " अन्न नंतर", " ભોજન પછી"];
var BeforFood = [" Before Food", " भोजन से पहले", " अन्न करण्यापूर्वी", " ફૂડ પહેલાં"];
var ContinueVisitLanguge = ["Continue till next visit", "अगले जांच तक जारी रखें", "पुढील तपासणी पर्यंत सुरू ठेवा", "આગામી મુલાકાત સુધી ચાલુ રાખો"];
var SOSLanguge = ["SOS", "आवश्यकतानुसार", "आवश्यकतेनुसार", "જરૂરી મુજબ"];

var strReferralDocts = "";
var strReferralDoctCodes = "";
var strReferralClinics = "";
var strReferralClinicCodes = "";
var SurgryAdvice = ""; // added by vijeta on 15th march 2018
var PersonalHistory = ""; // added by vijeta on 15th march 2018
var medicalHistory = "";// added by vijeta on 15th march 2018
var familyHistory = "";// added by vijeta on 15th march 2018
var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' }; // added by vijeta on 15th march 2018
var gRelation = {
    '01': 'Father', '02': 'Mother', '03': 'Wife',
    '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
    '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
    '11': 'Paternal Aunt' //Added the options from 8 - 11 by Murali on 11/04/2024 as per client request. (Ticket : 2528)
};
var NotesWiseDoct = "Y";
var printWithHistory = "Y";

switch ("NAME") {
    case "NAME":
        HeaderLang = EnglishHeader;
        BeforFoodData = BeforFood[0];
        AfterFoodData = AfterFood[0];
        break;
    case "HINDI":
        HeaderLang = hindiHeader;
        BeforFoodData = BeforFood[1];
        AfterFoodData = AfterFood[1];
        break;
    case "MARATHI":
        HeaderLang = marathiHeader;
        BeforFoodData = BeforFood[2];
        AfterFoodData = AfterFood[2];
        break;
    case "GUJRATI":
        HeaderLang = gujaratiHeader;
        BeforFoodData = BeforFood[3];
        AfterFoodData = AfterFood[3];
        break;
    default:
        HeaderLang = EnglishHeader;
        BeforFoodData = BeforFood[0];
        AfterFoodData = AfterFood[0];
        break;
}

function checkInTakeStatement(IntakeIndicator, language) {
    var intakestate = '';

    switch (language) {
        case "NAME":
            if (IntakeIndicator == "C")
                intakestate = ContinueVisitLanguge[0]
            else
                intakestate = SOSLanguge[0]
            break;
        case "HINDI":
            if (IntakeIndicator == "C")
                intakestate = ContinueVisitLanguge[1]
            else
                intakestate = SOSLanguge[1]
            break;
        case "MARATHI":
            if (IntakeIndicator == "C")
                intakestate = ContinueVisitLanguge[2]
            else
                intakestate = SOSLanguge[2]
            break;
        case "GUJRATI":
            if (IntakeIndicator == "C")
                intakestate = ContinueVisitLanguge[3]
            else
                intakestate = SOSLanguge[3]
            break;
        default:
            if (IntakeIndicator == "C")
                intakestate = ContinueVisitLanguge[0]
            else
                intakestate = SOSLanguge[0]
            break;
    }
    return intakestate;
}


function checkFollowUplanguge(FollowUp, language, type) {

    switch (language) {
        case "NAME":
            laguagewiseselect(FollowUp, EnglishDays, type)
            break;
        case "HINDI":
            laguagewiseselect(FollowUp, HindiDays, type)
            break;
        case "MARATHI":
            laguagewiseselect(FollowUp, MarathiDays, type)
            break;
        case "GUJRATI":
            laguagewiseselect(FollowUp, GujaratDays, type)
            break;
        default:
            laguagewiseselect(FollowUp, EnglishDays, type)
            break;
    }
}

function laguagewiseselect(FollowUp, daysof, type) {
    var Follupdata
    if (FollowUp[1] != "" || FollowUp[1] != "undefined") {
        Follupdata = FollowUp[1]
    }

    switch (Follupdata.toString().trim()) {

        case "Days":
            if (type == 'F')
                languageWise = daysof[0];
            else
                IntakeLanguage = daysof[0];
            break;
        case "Weeks":
            if (type == 'F')
                languageWise = daysof[1];
            else
                IntakeLanguage = daysof[1];
            break;
        case "Months":
            if (type == 'F')
                languageWise = daysof[2];
            else
                IntakeLanguage = daysof[2];
            break;
        case "Years":
            if (type == 'F')
                languageWise = daysof[3];
            else
                IntakeLanguage = daysof[3];
            break;
        default:
            if (type == 'F')
                languageWise = daysof[0];
            else
                IntakeLanguage = daysof[0];
            break;
    }

}

function GetDoctSignature(StrDoctCode) {
    // var StrDoctCode = '<%:Session["gDoctCode"]%>';
    var datatosend = {
        strdoctcode: StrDoctCode
    }
    $.ajax({
        type: "Post",
        url: "../DoctorDesk/GetSignatory",
        data: datatosend,
        async: false,
        success: function (response) {

            var data = JSON.parse(response);
            if (data.length > 0) {
                if (data[0]["SIGN"] != "") {
                    sign1 = "" + data[0]["SIGN"];
                }
                if (data[0]["DIGSIGN1"] != "") {
                    digitsign1 = "data:image/jpeg;base64," + data[0]["DIGSIGN1"];
                }
                if (data[0]["SIGN2"] != "") {
                    sign2 = "" + data[0]["SIGN2"];
                }
                if (data[0]["DIGSIGN2"] != "") {
                    digitsign2 = "data:image/jpeg;base64," + data[0]["DIGSIGN2"];
                }
                if (data[0]["SIGN3"] != "") {
                    sign3 = "" + data[0]["SIGN3"];
                }
                if (data[0]["DIGSIGN3"] != "") {
                    digitsign3 = "data:image/jpeg;base64," + data[0]["DIGSIGN3"];
                }
            }

        },
        complete: function () {
            //SendMailAction(Html);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //ajaxindicatorstop();
            $.messager.alert(textStatus, "Error");
        }
    });
}



//added on 29th aug 2018
function isEqualZero(currentValue) {
    return currentValue == 0;
}

function IntakeFunction(intake) {
    intakeArray = intake.split("-");
    var chkInitialIntk = intakeArray.every(isEqualZero);
    if (chkInitialIntk)
        intake = "-";

    return intake;
}
var intake = "";
//----------------------------

//Meenakshi created common function to display a rx table and called from all three template function 
function RxTable() {
    var Medicine = "";
    var medTbl1 = "";
    var flag = 0;
    var flagDura = 0;
    var flagQty = 0;
    //var flagRoute = 1;
    var CheckForRemarkFlag = 0;  // "CheckForRemarkFlag",this flag is used to check remark column and food ,if both are not present it will not display both column on Print pdf,added by ajinkya 2-12-2019
    $.each(GridData.jsonAdvice, function (key, value) {
        if (value.DOSSAGE != "") {
            flag = 1;
            return false;
        }
    });

    $.each(GridData.jsonAdvice, function (key, value) {
        if (value.QTY != "") {
            flagQty = 1;
            return false;
        }
    });
    $.each(GridData.jsonAdvice, function (key, value) {
        if (value.REMARKS != "" || value.ABFOOD != "-") {
            CheckForRemarkFlag = 1;
            return false;
        }
    });
    medTbl1 = "<br><table style='width:100%;empty-cells: hide;border-collapse:collapse;page-break-inside:avoid' border='1'>";


    for (var i = 0; i < GridData.jsonAdvice.length; i++) {
        var dosage = '';
        var advicesplitVal = [];
        var advicedayNum = '';
        var IntakeRemark = '';
        var Route = ''; QTY = '';
        Food = "";
        var strConS = '';
        var concateComma = '';
        var MDate = '';
        var genericNm = GeneralWiseYN == "Y" ? "" : GridData.jsonAdvice[i]["GENERICNAME"].toString() != "" ? "(" + GridData.jsonAdvice[i]["GENERICNAME"].toString().replace(/^\d+\.\s*/, '') + ")" : ""; //priyanka 10/06/2026
        MDate = (GridData.jsonAdvice[i]["MEDSTARTDATE"] == "" || GridData.jsonAdvice[i]["MEDSTARTDATE"] == "undefined") ? "" : GridData.jsonAdvice[i]["MEDSTARTDATE"];
        dosage = (GridData.jsonAdvice[i]["DOSSAGE"] == "" || GridData.jsonAdvice[i]["DOSSAGE"] == "undefined") ? "" : GridData.jsonAdvice[i]["DOSSAGE"]//
        Route = (GridData.jsonAdvice[i]["ROUTE"] == "" || GridData.jsonAdvice[i]["ROUTE"] == "undefined") ? "" : GridData.jsonAdvice[i]["ROUTE"]
        QTY = (GridData.jsonAdvice[i]["QTY"] == "" || GridData.jsonAdvice[i]["QTY"] == "undefined") ? "" : GridData.jsonAdvice[i]["QTY"]
        intake = (GridData.jsonAdvice[i]["INTAKE"] == "" || GridData.jsonAdvice[i]["INTAKE"] == "undefined") ? "" : GridData.jsonAdvice[i]["INTAKE"].replace(/0.5/g, "1/2")
        remark = (GridData.jsonAdvice[i]["REMARKS"] == "" || GridData.jsonAdvice[i]["REMARKS"] == "undefined") ? "" : "<br />" + GridData.jsonAdvice[i]["REMARKS"]
        //added on 29th aug 2018
        intake = IntakeFunction(intake);
        //--------------------------------

        if (GridData.jsonAdvice[i]["ABFOOD"] == "A") {
            Food = AfterFoodData;
        }
        else if (GridData.jsonAdvice[i]["ABFOOD"] == "B") {
            Food = BeforFoodData;
        }

        if (Food != "" && remark != "") {
            concateComma = ", "
        }
        if (GridData.jsonAdvice[i]["DAYS"].length > 0) {
            if (GridData.jsonAdvice[i]["DAYS"] == "C" || GridData.jsonAdvice[i]["DAYS"] == "S") {
                if (GridData.jsonAdvice[i]["DAYS"] == "C") {
                    IntakeIndicator = GridData.jsonAdvice[i]["DAYS"];
                    IntakeRemark = checkInTakeStatement(IntakeIndicator, language)
                }
                else if (GridData.jsonAdvice[i]["DAYS"] == "S") {
                    IntakeIndicator = GridData.jsonAdvice[i]["DAYS"];
                    IntakeRemark = checkInTakeStatement(IntakeIndicator, language)
                }
                flagDura = flagDura + 1;
            }
            else if (GridData.jsonAdvice[i]["INTAKE"] == "SOS" || GridData.jsonAdvice[i]["INTAKE"] == "CONTD" || GridData.jsonAdvice[i]["INTAKE"] == "STAT") {
                advicedayNum = ''; IntakeLanguage = ''; strConS = ''
            }
            else {
                day = (GridData.jsonAdvice[i]["DAYS"] == "" || GridData.jsonAdvice[i]["DAYS"] == "undefined") ? "" : "for " + GridData.jsonAdvice[i]["DAYS"]
                if (day != "" || day != "undefined") {
                    flagDura = flagDura + 1;
                    advicedayNum = (day).replace(/[^0-9]+/ig, "");// taking Numeric value from alphanumeric
                    advicedayNum = advicedayNum == 0 ? "-" : advicedayNum;// taking Numeric value from alphanumeric //4/11/19 
                    advicesplitVal = (day).split((day).replace(/[^0-9]+/ig, ""));// spliting alphanumeric based on dayGridData.jsonAdvice[i]["GENERICNAME"]//4/11/19 
                    //advicesplitVal = (day).split(advicedayNum);// spliting alphanumeric based on dayGridData.jsonAdvice[i]["GENERICNAME"]//4/11/19
                    checkFollowUplanguge(advicesplitVal, language, 'I')
                    if (advicedayNum == '-')//4/11/19
                        IntakeLanguage = "";
                    if (language == "NAME" && advicedayNum.length > 0) {
                        if (Number(advicedayNum) > 1)
                            strConS = 's'
                    }
                }
            }
        }
        else {
            advicedayNum = "";
            IntakeLanguage = "";
            strConS = "";
        }
        if (flagQty == 1 && flag == 1)
            Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:20px !important;;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"].replace(/^\d+\.\s*/, '') + "</label>" + "<label style='font-size:20px !important;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + QTY + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
        else if (flagQty == 1 && flag == 0)
            Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:20px !important;;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"].replace(/^\d+\.\s*/, '') + "</label>" + "<label style='font-size:20px !important;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + QTY + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
        else if (flagQty == 0 && flag == 1)
            Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:20px !important;;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"].replace(/^\d+\.\s*/, '') + "</label>" + "<label style='font-size:20px !important;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
        if (flagQty == 0 && flag == 0)
            Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:20px !important;;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"].replace(/^\d+\.\s*/, '') + "</label>" + "<label style='font-size:20px !important;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
    }

    var MedHeadLbl = GeneralWiseYN == "Y" ? "Generic Name" : "Medicine Name";
    if (flagQty == 1 && flag == 1)
        medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:24%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Fordate</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Intake</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Qty</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
    else if (flagQty == 1 && flag == 0)
        medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:24%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Fordate</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Intake</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Qty</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
    else if (flagQty == 0 && flag == 1)
        medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:24%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Fordate</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Intake</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
    if (flagQty == 0 && flag == 0)
        medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:24%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;font-size:20px; width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Fordate</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Intake</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:20px !important;;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:20px !important;;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";

    return (medTbl1 + "</table>");
}



function PrintPatInfo() {    // Changes by Dhananjay 20240724 - 
    var strPrindData = [];
    var Mrno = sessionStorage.getItem("PatMRNO");
    var strTran = sessionStorage.getItem("PatTRANNO");
    var patName = sessionStorage.getItem("PatName");
    var userDetails = GridData.jsonUserdtls[0];
    var patAgeComponents = userDetails.PATAGE.split(":");
    var strAge = Number(patAgeComponents[0]) > 0 ? Number(patAgeComponents[0]) + " Years" : Number(patAgeComponents[1]) > 0 ? Number(patAgeComponents[1]) + " Months" : Number(patAgeComponents[2]) + " Days";
    var gender = userDetails.PATSEX == 'M' ? 'Male' : 'Female';

    strPrindData.push("<table style='width:100%;margin-bottom:5px;border-collapse:collapse;font-family:cambria !important;font-size: 30px !important;' id='tblPatInfo'>");
    strPrindData.push("<tr><td style='font-weight:bold'>Name</td><td style='font-weight:bold'>:</td><td>" + userDetails.PATNAME + "</td>");
    strPrindData.push("<td style='font-weight:bold'>Age/Gender</td><td style='font-weight:bold'>:</td><td>" + strAge + " / " + gender + "</td></tr>");
    strPrindData.push("<tr><td style='font-weight:bold'>MR No.</td><td style='font-weight:bold'>:</td><td>" + Mrno + "</td>");
    strPrindData.push("<td style='font-weight:bold'>Date/Time</td><td style='font-weight:bold'>:</td><td>" + userDetails.TRANDATE + "</td></tr>");
    strPrindData.push("<tr><td style='font-weight:bold'>Dr. Name</td><td style='font-weight:bold'>:</td><td>Dr. " + userDetails.DOCTNAME + "</td>");
    strPrindData.push("<td style='font-weight:bold'>Consultation No.</td><td style='font-weight:bold'>:</td><td>" + strTran + "</td></tr>");
    //priyanka on 07/11/2025
    if (GridData.jsonUserdtls[0].PATMOBILE.toString().trim() != "") {
        strPrindData.push("<td style='font-weight:bold'>Mobile No.</td><td style='font-weight:bold'>:</td>");
        strPrindData.push("<td>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>");
    }
    if (GridData.jsonUserdtls[0].PATEMAIL.toString().trim() != "") {
        strPrindData.push("<td style='font-weight:bold'>Email</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].PATEMAIL + "</td></tr>");
    }
    if (GridData.jsonUserdtls[0].PATADDRESS.toString().trim() != "") {
        strPrindData.push("<tr><td style='font-weight:bold'>Address</td><td style='font-weight:bold'>:</td><td colspan='4'>" + GridData.jsonUserdtls[0].PATADDRESS + "</td></tr>");
    }
    //end
    if (userDetails.COCANAME != "") {
        strPrindData.push("<tr><td style='font-weight:bold'>Exemp Catg.</td><td style='font-weight:bold'>:</td><td>" + userDetails.COCANAME + "</td>");
        if (userDetails.EMPID != "") {
            strPrindData.push("<td style='font-weight:bold'>Employee ID</td><td style='font-weight:bold'>:</td><td>" + userDetails.EMPID + "-" + userDetails.EMPDEPNDCD + "</td></tr>");
        } else {
            strPrindData.push("<td style='font-weight:bold'>Exemp Proof</td><td style='font-weight:bold'>:</td><td>" + userDetails.CONSCATPROOF + "</td></tr>");
        }
    }

    strPrindData.push("</table>");
    return strPrindData.join("");
}

//priyanka 10/04/2026
function cleanCkEditorHtmlKeepImages(html) {
    if (!html) return "";

    var div = document.createElement("div");
    div.innerHTML = html;

    div.querySelectorAll("head, style, link, title, script").forEach(e => e.remove());

    return div.innerHTML;
}
function getClinicalNotesData() {
    var editor = CKEDITOR.instances['ClinicalNotes_HtmlEditor'];

    if (!editor) return "";

    return editor.getData();
}
function fixImageUrls(html) {
    var baseUrl = window.location.origin;

    var div = document.createElement("div");
    div.innerHTML = html;

    var images = div.querySelectorAll("img");

    images.forEach(function (img) {

        var src = img.getAttribute("src");

        if (src) {

            if (src.startsWith("data:")) return;

            if (!src.startsWith("http")) {
                img.src = baseUrl + src;
            }
        }

        img.style.width = "350px";
        img.style.height = "300px";
        img.style.margin = "4px";
        img.style.objectFit = "contain";
        img.style.border = "1px solid #ccc";
    });

    return div.innerHTML;
}
//End
function PrintData(strTran, Mrno) {
    var language = "NAME";
    // ---- end ----//

    if (language == "NAME") {
        HeaderLang = EnglishHeader;
        WAfter = " After"
    }
    var FollowUp = [];
    var Medicine = '';

    var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
    var gRelation = {
        '01': 'Father', '02': 'Mother', '03': 'Wife',
        '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
        '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
        '11': 'Paternal Aunt' //Added the options from 8 - 11 by Murali on 11/04/2024 as per client request. (Ticket : 2528)
    };

    var strPrindData = [];      // Change by Dhananjay 20240722
    strPrindData.push("<html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'/>");
    strPrindData.push(" <style>.cltable {border-collapse: collapse;font-family:cambria !important;} table.cltable td, th {border: 1px solid #ddd;text-align: left;font-family:cambria !important;} .HTextsize{font-size: 20px !important ;padding:3px;font-family:cambria !important;} .DTextsize{font-size: 20px !important;font-family:cambria !important;} .inHeight{line-height:20px !important;font-family:cambria !important;}  @page {margin-top: 4cm;margin-bottom: 3cm; } @media print {body {margin-top: 0mm; margin-bottom: 0mm;  margin-left: 0mm; margin-right: 0mm } #footer{display: block;page-break-after: always; bottom:0;margin-top: 25pt; } } #tblPatInfo td{padding: 1px; white-space:nowrap;font-family:cambria !important;} table { page-break-inside:auto;font-family:cambria !important; } tfoot { display:table-footer-group } p{margin:0 !important;padding:0 !important;line-height:1.4 !important;} h1,h2,h3,h4,h5,h6{margin:1px 0 !important;padding:0 !important;line-height:1.3 !important;} ul,ol{margin:2px 0 !important;} li{margin:0 !important;line-height:1.4 !important;} </style></head>"); strPrindData.push("<body style='margin-left:25;font-family:cambria !important;font-size: 20px !important'>");
    var label = "Patient Category";
    //Vitals start       
    if (GridData.jsonVital.length > 0) {

        //strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align=top'><u>" + HeaderLang[1] + " </u>: </label>")

        var flag = false;
        var stopAfterBMI = false;//Priyanka 26/12/2025
        $.each(GridData.jsonVital[0], function (i, val) {

            if (i == "WEIGHT" && Number(val) > 0)
                flag = true;
            if (i == "HEIGHT" && Number(val) > 0)
                flag = true;
            if (i == "TEMP" && Number(val) > 0)
                flag = true;
            if (i == "PULSE" && Number(val) > 0)
                flag = true;
            if (i == "RESP" && val.length > 0)
                flag = true;
            if (i == "BP" && val.length > 0)
                flag = true;
            if (i == "SPO2" && val.length > 0)
                flag = true;

            if (i == "BMI" && val.length > 0)
                flag = true;
            if (i == "HEADCIRCMF" && val.length > 0)
                flag = true;
            if (i == "PEFR" && val.length > 0)
                flag = true;
            if (i == "Technique" && val != "N")
                flag = true;
            if (i == "Compliance" && val != "N")
                flag = true;
            if (i == "BSA" && val != "")
                flag = true;
            if (i == "RBS" && val != "")
                flag = true;
            if (i == "KARNOFSKY" && val != "")
                flag = true;
            if (i == "ECOG" && val != "")
                flag = true;
            if (i == "IBW" && val.length > 0)
                flag = true;
            if (i == "BWPERC" && val.length > 0)
                flag = true;
            if (i == "WAISTCIRCUM" && val.length > 0)
                flag = true;
            if (i == "HIPCIRCUM" && val.length > 0)
                flag = true;
            if (i == "WHR" && val.length > 0)
                flag = true;
        });

        //Did changes for sequnce arrangement - Pournima 16th June 2026
        if (flag) {
            strPrindData.push("<div class='col-md-6'>");
            strPrindData.push("<table class='DTextsize' style='border-collapse: separate; border-spacing: 3px;width:100%;'>")
            strPrindData.push("<tr  class='inHeight'>")
            strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align:top'><u>" + HeaderLang[1] + " </u>: </label>");
        }

        if (GridData.jsonVital[0].hasOwnProperty("WEIGHT")) {
            if (Number(GridData.jsonVital[0]["WEIGHT"]) > 0)//GridData.jsonVital[0]["WEIGHT"].length
                strPrindData.push("<td class='DTextsize'>Weight: " + GridData.jsonVital[0]["WEIGHT"] + " kg</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("HEIGHT")) {
            if (Number(GridData.jsonVital[0]["HEIGHT"]) > 0)//GridData.jsonVital[0]["HEIGHT"].length
                strPrindData.push("<td class='DTextsize'>Height : " + GridData.jsonVital[0]["HEIGHT"] + " cm</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("TEMP")) {
            if (Number(GridData.jsonVital[0]["TEMP"]) > 0)//GridData.jsonVital[0]["TEMP"].length 
            {
                var temp = String(GridData.jsonVital[0]["TEMP"]);
                if (temp.indexOf('.') !== -1) {
                    temp = temp.split('.')[0] + '.' + (temp.split('.')[1] + '0').charAt(0);
                } else {
                    temp = temp + '.0';
                }
                strPrindData.push("<td class='DTextsize'>Temperature : " + temp + " °f</td>")
            }
 
        }
        strPrindData.push("</tr>")

        strPrindData.push("<tr class='inHeight'>")
        if (GridData.jsonVital[0].hasOwnProperty("PULSE")) {
            if (Number(GridData.jsonVital[0]["PULSE"]) > 0) {
                strPrindData.push("<td class='DTextsize'>Pulse : " + GridData.jsonVital[0]["PULSE"] + " bpm");
            }
            strPrindData.push("</td>");

        }

        if (GridData.jsonVital[0].hasOwnProperty("RESP")) {
            if (Number(GridData.jsonVital[0]["RESP"]) > 0)//GridData.jsonVital[0]["RESP"].length
                strPrindData.push("<td class='DTextsize'>RR : " + GridData.jsonVital[0]["RESP"] + " Breaths/Minutes</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("BP")) {
            if (GridData.jsonVital[0]["BP"].length > 0)//
                strPrindData.push("<td class='DTextsize'>BP : " + GridData.jsonVital[0]["BP"] + " mmHg</td>")
        }
        strPrindData.push("</tr>")

        strPrindData.push("<tr class='inHeight'>")
        if (GridData.jsonVital[0].hasOwnProperty("SPO2")) {
            if (GridData.jsonVital[0]["SPO2"].length > 0)
                strPrindData.push("<td class='DTextsize'>SpO2 : " + GridData.jsonVital[0]["SPO2"] + " %</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("PAINSCORE")) {
            var painLabels = [
                "No Pain",
                "Very Mild",
                "Hurts Little Bit",
                "Tolerable",
                "Hurts Little More",
                "Very Distressing",
                "Hurts Even More",
                "Very Intense",
                "Hurts Whole Lot",
                "Unbearable",
                "Hurts Worst"
            ];
            var painScore = GridData.jsonVital[0]["PAINSCORE"];
            if (painScore != null && painScore !== "") {
                var score = parseInt(painScore, 10);
                var painText = painLabels[score] || "";
                strPrindData.push(
                    "<td class='DTextsize'>Pain Score : " + (score == 0 ? "No Pain" : score) + "</td>"
                    //score + " (" + painText + ")</td>"
                );
            }
        }

        if (GridData.jsonVital[0].hasOwnProperty("BMI")) {
            if (GridData.jsonVital[0]["BMI"].length > 0)
                strPrindData.push("<td class='DTextsize'>BMI : " + GridData.jsonVital[0]["BMI"] + " kg/m²</td>");
        }
        strPrindData.push("</tr>")

        strPrindData.push("<tr class='inHeight'>")
        if (GridData.jsonVital[0].hasOwnProperty("BSA")) {
            if (GridData.jsonVital[0]["BSA"].length > 0)//
                strPrindData.push("<td class='DTextsize'>BSA : " + GridData.jsonVital[0]["BSA"] + " m²</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("RBS")) {
            if (GridData.jsonVital[0]["RBS"].length > 0)//
                strPrindData.push("<td class='DTextsize'>RBS : " + GridData.jsonVital[0]["RBS"] + " mg/dl</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("KARNOFSKY")) {
            if (GridData.jsonVital[0]["KARNOFSKY"].length > 0)
                strPrindData.push("<td class='DTextsize'>Karnofsky Score : " + GridData.jsonVital[0]["KARNOFSKY"] + "  %</td>")
        }
        strPrindData.push("</tr>")

        strPrindData.push("<tr class='inHeight'>")
        if (GridData.jsonVital[0].hasOwnProperty("IBW")) {
            if (GridData.jsonVital[0]["IBW"].length > 0)//
                strPrindData.push("<td class='DTextsize'>IBW : " + GridData.jsonVital[0]["IBW"] + "  </td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("BWPERC")) {
            if (GridData.jsonVital[0]["BWPERC"].length > 0)
                strPrindData.push("<td class='DTextsize'>BW % : " + GridData.jsonVital[0]["BWPERC"] + " </td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("WAISTCIRCUM")) {
            if (GridData.jsonVital[0]["WAISTCIRCUM"].length > 0)
                strPrindData.push("<td class='DTextsize'>Waist Circumference : " + GridData.jsonVital[0]["WAISTCIRCUM"] + " cm</td>")
        }
        strPrindData.push("</tr>")

        strPrindData.push("<tr class='inHeight'>")
        if (GridData.jsonVital[0].hasOwnProperty("HIPCIRCUM")) {
            if (GridData.jsonVital[0]["HIPCIRCUM"].length > 0)
                strPrindData.push("<td class='DTextsize'>Hip Circumference : " + GridData.jsonVital[0]["HIPCIRCUM"] + " cm</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("WHR")) {
            if (GridData.jsonVital[0]["WHR"].length > 0)//
                strPrindData.push("<td class='DTextsize'>WHR : " + GridData.jsonVital[0]["WHR"] + "  </td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("ECOG")) {
            if (GridData.jsonVital[0]["ECOG"].length > 0)//
                strPrindData.push("<td class='DTextsize'>ECOG Score : " + GridData.jsonVital[0]["ECOG"] + "  </td>")
        }
        strPrindData.push("</tr>")

        strPrindData.push("<tr class='inHeight'>")
        if (GridData.jsonVital[0].hasOwnProperty("PEFR")) {
            if (GridData.jsonVital[0]["PEFR"].length > 0)
                strPrindData.push("<td class='DTextsize'>PEFR : " + GridData.jsonVital[0]["PEFR"] + " li/min</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("Technique")) {
            if (GridData.jsonVital[0]["Technique"] != 'N')
                strPrindData.push("<td class='DTextsize'>Technique : " + GridData.jsonVital[0]["Technique"] + "</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("Compliance")) {
            if (GridData.jsonVital[0]["Compliance"] != 'N')
                strPrindData.push("<td class='DTextsize'>Compliance : " + GridData.jsonVital[0]["Compliance"] + " </td>")
        }
        strPrindData.push("</tr>")

        strPrindData.push("<tr class='inHeight'>")
        if (GridData.jsonVital[0].hasOwnProperty("VOTHERS")) {
            if (GridData.jsonVital[0]["VOTHERS"].length > 0)
                strPrindData.push("<td class='DTextsize'>VOTHERS : " + GridData.jsonVital[0]["VOTHERS"] + "</td>")
        }

        if (GridData.jsonVital[0].hasOwnProperty("HEAD_CIRCUMFERENCE")) {
            if (GridData.jsonVital[0]["HEAD_CIRCUMFERENCE"].length > 0)
                strPrindData.push("<td class='DTextsize'>Head Circumference : " + GridData.jsonVital[0]["HEAD_CIRCUMFERENCE"] + " cm</td>")
        }
        strPrindData.push("<td class='DTextsize'></td>")

        strPrindData.push("</tr></table>");
        strPrindData.push("</div>")
    }
    strPrindData.push("</div>");
    //Vitals End

    //History priyanka 11/03/2026
    if (printWithHistory == "Y") {
        if ($("#chkMedHist").prop("checked") || $("#chkHistoryPatClinHist").prop("checked")) {

            if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {
                strPrindData.push("<div style='width:100%' id='divMedicalHist'>");
            }

            if (GridData.jsonMedicineHist.length > 0) {

                strPrindData.push("<table id='medicalHistTable' style='border-collapse:collapse;width:100%;font-size:20px !important'>");
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>"
                    + HeaderLang[13] + " :</u></caption>");

                for (var i = 0; i < GridData.jsonMedicineHist.length; i++) {

                    strPrindData.push("<tr><td><li>" + GridData.jsonMedicineHist[i].NAME);

                    if (GridData.jsonMedicineHist[i].DURATION != "" && GridData.jsonMedicineHist[i].DURATION != 0)
                        strPrindData.push(" since "
                            + GridData.jsonMedicineHist[i].DURATION + " "
                            + gDurType[GridData.jsonMedicineHist[i].DURTYPE] + "(s)");

                    strPrindData.push("</li></td></tr>");
                }

                strPrindData.push("</table>");
            }

            if (GridData.jsonFreeMedical.length > 0) {

                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important' class='tblFree'>");

                if (GridData.jsonMedicineHist.length == 0)
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>"
                        + HeaderLang[13] + " :</u></caption>");

                for (var i = 0; i < GridData.jsonFreeMedical.length; i++) {

                    strPrindData.push("<tr><td><li>"
                        + GridData.jsonFreeMedical[i].MEDHIST.replace(/\n/g, '<br />')
                        + "</li></td></tr>");
                }

                strPrindData.push("</table>");
            }

            if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0)
                strPrindData.push("</div>");
        }



        if ($("#chkFamHist").prop("checked") || $("#chkHistoryPatClinHist").prop("checked")) {

            if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0)
                strPrindData.push("<div id='familyHistDiv'>");

            if (GridData.jsonFamilyHist.length > 0) {

                strPrindData.push("<table id='familyHistTable' style='width:100%;border-collapse:collapse;' class='DTextsize'>");
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>"
                    + HeaderLang[14] + " :</u></caption>");

                for (var i = 0; i < GridData.jsonFamilyHist.length; i++) {

                    var DiseaseStatus = GridData.jsonFamilyHist[i].DISEASESTATUS != ""
                        ? (" - " + GridData.jsonFamilyHist[i].DISEASESTATUS.trim()) : "";

                    var DiagDate = GridData.jsonFamilyHist[i].DIAGNOSEDDATE != ""
                        ? (" (" + GridData.jsonFamilyHist[i].DIAGNOSEDDATE.trim() + ")") : "";

                    strPrindData.push("<tr><td><li>"
                        + GridData.jsonUserdtls[0].PATNAME + "'s "
                        + gRelation[GridData.jsonFamilyHist[i].RELATION]
                        + ", suffering with "
                        + GridData.jsonFamilyHist[i].DISEASES
                        + DiseaseStatus + DiagDate
                        + "</li></td></tr>");
                }

                strPrindData.push("</table>");
            }

            if (GridData.jsonFreeFamily.length > 0) {

                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;' class='tblFree'>");

                if (GridData.jsonFamilyHist.length == 0)
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>"
                        + HeaderLang[14] + " :</u></caption>");

                for (var i = 0; i < GridData.jsonFreeFamily.length; i++) {

                    strPrindData.push("<tr><td class='DTextsize'><li>"
                        + GridData.jsonFreeFamily[i].FAMHIST.replace(/\n/g, '<br />')
                        + "</li></td></tr>");
                }

                strPrindData.push("</table>");
            }

            if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0)
                strPrindData.push("</div>");
        }


        if ($("#chkPersHist").prop("checked") || $("#chkHistoryPatClinHist").prop("checked")) {
            strPrindData.push("<div id='personalNMediDiv'>");
            if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                strPrindData.push("<div style='width:100%' id='divPersonalHist'>");
            }

            if (GridData.jsonPersonalHist.length > 0) {
                strPrindData.push("<table id='personalHistTable' style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'>");// border color added by vijeta on 19th march 2018
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                for (var i = 0; i < GridData.jsonPersonalHist.length; i++) {
                    strPrindData.push("<tr><td ><li>" + GridData.jsonPersonalHist[i].NAME);
                    var type = GridData.jsonPersonalHist[i].STARTAGE;   // M / D / Y
                    var value = GridData.jsonPersonalHist[i].STOPAGE;   // 1 / 2

                    if (value && gDurType[type]) {
                        strPrindData.push(" from " + value + " " + gDurType[type] + (value > 1 ? "s" : ""));
                    }
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table>");
            }

            //free personal history
            if (GridData.jsonFreePersonal != "") {
                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;' class='tblFree'>");
                if (GridData.jsonPersonalHist.length == 0) {
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                }
                for (var i = 0; i < GridData.jsonFreePersonal.length; i++) {

                    strPrindData.push("<tr><td><li>" + GridData.jsonFreePersonal[i].PERSHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                strPrindData.push("</div>");
            }
        }

        //allergy      
        debugger;
        if ($("#chkallergy").prop("checked")) { //priyanka 08/06/2026
            if (GridData.jsonAllergy.length > 0) {
                strPrindData.push("<table id='AllergyTable'>");
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>Allergy</u>:</caption>");
                for (var i = 0; i < GridData.jsonAllergy.length; i++) {
                    var AllgryDurType = GridData.jsonAllergy[i].DURTYPE == "D" ? "Days" : (GridData.jsonAllergy[i].DURTYPE == "W" ? "Week" : GridData.jsonAllergy[i].DURTYPE == "M" ? "Month" : GridData.jsonAllergy[i].DURTYPE == "Y" ? "Year" : "")
                    var AllgryDur = GridData.jsonAllergy[i].DURATION != "" && Number(GridData.jsonAllergy[i].DURATION) > 0 ? GridData.jsonAllergy[i].DURATION : "";
                    //strPrindData.push("<tr><td><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");
                    strPrindData.push("<tr><td class='DTextsize'><li>" + GridData.jsonAllergy[i].ALLERGYTYPE + " Allergy - " + GridData.jsonAllergy[i].NAME + (AllgryDur != "" ? (" For " + AllgryDur + " " + AllgryDurType) : ""));
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
        }

    }
    //end

    //Chief Complaints
    strPrindData.push("<div class='row'>")
    if ($("#chkComplaint").prop("checked") || $("#chkCheifCompPatClinHist").prop("checked")) {
        //Chief Complaints

        if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
            strPrindData.push("<div class='col-md-6'>")
            strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[0] + " </u>: </label>");
            strPrindData.push("<table>");
        }

        if (GridData.jsonComplaints.length > 0) {
            for (var i = 0; i < GridData.jsonComplaints.length; i++) {
                var TotalDuration = "";
                var dur = "" + GridData.jsonComplaints[i].DURATION
                var durtype = GridData.jsonComplaints[i].DURTYPE
                if (dur.length > 0) {
                    if (Number(dur) > 0) {
                        TotalDuration = "  since " + dur + " " + DurationTypeSelect(durtype, dur)
                    }
                }

                //added on 6th april 2018
                var rmrk = "";
                if (GridData.jsonComplaints[i].REMARKS != "") {
                    rmrk = " " + GridData.jsonComplaints[i].REMARKS + "";
                }
                //------------------------------------------

                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonComplaints[i].NAME + " " + TotalDuration + " " + rmrk.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                //

            }
        }

        //free complaint vijeta 20th march 19
        if (GridData.jsonFreeComplaints.length > 0) {
            if (GridData.jsonFreeComplaints[0].hasOwnProperty("FREECOMPLAINT")) {
                /*    strPrindData.push("<tr><td class='HTextsize' style='font-weight:bold;padding-top:10px;'><u>Other Complaints :</u></td></tr>");*/
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeComplaints[0].FREECOMPLAINT.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
            }
        }

        if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
            strPrindData.push("</table>");
            strPrindData.push("</div>")
        }
    }
    //COMPLAINT END


    if (($("#chkExamin").prop("checked") || $("#chkOnExamPatClinHist").prop("checked")) && (GridData.jsonExam[0]["EXAM"] !== "" || GridData.ExamImagePath.length > 0) ) {

        //strPrindData.push("<br>");
        strPrindData.push("<table style='width:100%;'><tr>");
        var HeaderFlag = true;
        /* ---------------- LEFT COLUMN : EXAMINATION ---------------- */
        if (GridData.jsonExam[0]["EXAM"] !== "") {
            strPrindData.push("<td style='width:50%;vertical-align:top;'>");
            strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>"+ HeaderLang[10] + "</u> :</label>");
            strPrindData.push("<p class='DTextsize' style='padding:5px!important;word-wrap:break-word;'>"
                + GridData.jsonExam[0]["EXAM"].replace(/\n/g, '<br />')
                + "</p>");
            strPrindData.push("</td>");
            HeaderFlag = false;
        }
        /* ---------------- RIGHT COLUMN : EXAM IMAGES ---------------- */
        if (GridData.ExamImagePath.length > 0) {
            strPrindData.push("<td style='width:50%;vertical-align:top;'>");
            if (HeaderFlag)
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[10] + "</u> :</label>");
            strPrindData.push("<table>");
            var strmrno = sessionStorage.getItem("PatMRNO");
            var strtranNo = sessionStorage.getItem("PatTRANNO");

            datatosend = {
                MrNo: strmrno,
                TranNo: strtranNo
            };

            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/RetriveExamImages',
                data: datatosend,
                async: false,
                success: function (ImageData) {

                    if (ImageData.length > 0) {

                        $.each(ImageData, function (index, element) {

                            var fileNo = element.split("|");
                            var strUrl = "data:image/png;base64," + fileNo[1];

                            strPrindData.push("<tr>");
                            strPrindData.push("<td>");
                            strPrindData.push("<img src='" + strUrl + "' style='width:350px;height:300px;margin:4px;'>");
                            strPrindData.push("</td>");
                            strPrindData.push("</tr>");

                        });
                    }

                }
            });

            strPrindData.push("</table>");
            strPrindData.push("</td>");
        }

        strPrindData.push("</tr></table>");
    }



    /* ---------------- PAST HISTORY BELOW EXAMINATION ---------------- */

    if (printWithHistory == "Y") {

        if ($("#chkExamin").prop("checked") || $("#chkOnExamPatClinHist").prop("checked")) {

            if (GridData.jsonPastHist && GridData.jsonPastHist.length > 0) {

                if (GridData.jsonPastHist[0]["PASTHIST"] !== "") {

                    //strPrindData.push("<br>");
                    strPrindData.push("<table style='width:100%;'>");

                    if (HeaderLang[20] != "") {

                        strPrindData.push("<tr>");
                        strPrindData.push("<td>");
                        strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>"
                            + HeaderLang[20] + "</u> :</label>");
                        strPrindData.push("</td>");
                        strPrindData.push("</tr>");

                    }

                    strPrindData.push("<tr>");
                    strPrindData.push("<td>");
                    strPrindData.push("<label class='DTextsize' style='padding:5px!important;'>"
                        + GridData.jsonPastHist[0]["PASTHIST"].replace(/\n/g, '<br />')
                        + "</label>");
                    strPrindData.push("</td>");
                    strPrindData.push("</tr>");

                    strPrindData.push("</table>");
                }
            }
        }
    }
    //Exam end


    //Diagnosis start
    if ($("#chkDiagnosis").prop("checked") || $("#chkDiagnosisPatClinHist").prop("checked")) {
        //if (GridData.jsonDiagnosis.length > 0) {

        //    if (GridData.jsonFollowUp[0]["PROVDIAG"].toString().trim() != "")
        //        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[19] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;'>" + GridData.jsonFollowUp[0]["PROVDIAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

        //    strPrindData.push("<table style='width:100%;margin-top:10px;'>");

        //    if (GridData.jsonFollowUp[0]["SITE"].toString().trim() != "") {
        //        strPrindData.push(
        //            "<tr style='line-height:19px;'>" +
        //            "<td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Site</u></label></td>" +
        //            "<td style='width:3%;vertical-align:top;'><b>:</b></td>" +
        //            "<td><label class='HTextsize' style='font-size:20px !important;'>" +
        //            GridData.jsonFollowUp[0]["SITE"].toString() +
        //            "</label></td></tr>"
        //        );
        //    }

        //    if (GridData.jsonFollowUp[0]["SUBSITE"].toString().trim() != "") {
        //        strPrindData.push(
        //            "<tr style='line-height:19px;'>" +
        //            "<td style='vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Sub Site</u></label></td>" +
        //            "<td style='vertical-align:top;'><b>:</b></td>" +
        //            "<td><label class='HTextsize' style='font-size:20px !important;'>" +
        //            GridData.jsonFollowUp[0]["SUBSITE"].toString() +
        //            "</label></td></tr>"
        //        );
        //    }

        //    if (GridData.jsonFollowUp[0]["TSTAGE"].toString().trim() != "") {
        //        strPrindData.push(
        //            "<tr style='line-height:19px;'>" +
        //            "<td style='vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>TNM</u></label></td>" +
        //            "<td style='vertical-align:top;'><b>:</b></td>" +
        //            "<td>" +
        //            "<label class='HTextsize' style='font-size:20px !important;'>T : " + GridData.jsonFollowUp[0]["TSTAGE"].toString() + "</label><br/>" +
        //            "<label class='HTextsize' style='font-size:20px !important;'>N : " + GridData.jsonFollowUp[0]["NSTAGE"].toString() + "</label><br/>" +
        //            "<label class='HTextsize' style='font-size:20px !important;'>M : " + GridData.jsonFollowUp[0]["MSTAGE"].toString() + "</label>" +
        //            "</td></tr>"
        //        );
        //    }

        //    strPrindData.push("</table>");

        //    if (GridData.jsonFollowUp[0]["COMPOSTAG"].toString().trim() != "")
        //        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Stage</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

        //    if (GridData.jsonDiagnosis.length > 0) {
        //        if (GridData.jsonICDiagnosis.length <= 0) {
        //            strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Diagnosis</u>: </label></td></tr>")
        //        } else {
        //            strPrindData.push("<table style='width:50%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Diagnosis</u>: </label></td></tr>")
        //        }

        //        for (var i = 0; i < GridData.jsonDiagnosis.length; i++) {
        //            if (GridData.jsonDiagnosis[i].NAME.trim() != "") {
        //                var DiagRemark = "";
        //                if (GridData.jsonDiagnosis[i].REMARKS != "") {
        //                    DiagRemark = " " + " - " + GridData.jsonDiagnosis[i].REMARKS.toString()
        //                }
        //                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
        //            }
        //        }
        //        strPrindData.push("</table>");
        //    }


        //    //ICDiagnosis..................................
        //    if (GridData.jsonICDiagnosis.length > 0) {


        //        if (GridData.jsonDiagnosis.length <= 0) {
        //            strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")

        //        } else {
        //            strPrindData.push("<table style='width:50%;float:right'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")

        //        }

        //        for (var i = 0; i < GridData.jsonICDiagnosis.length; i++) {
        //            var DiagRemark = "";
        //            strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDiagnosis[i].NAME + "</li></td></tr>");
        //            //
        //        }
        //        strPrindData.push("</table>");
        //        //strPrindData.push("<br>");//3/27/19 commntd
        //    }
        //}

        //UnCoded Diagnosis
        if (GridData.jsonDiagnosis.length > 0 || (GridData.jsonProvDiagnosis && GridData.jsonProvDiagnosis.length > 0)) {
            if (GridData.jsonICDiagnosis.length <= 0) {
                strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Diagnosis</u>: </label></td></tr>")
            } else {
                strPrindData.push("<table style='width:50%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Diagnosis</u>: </label></td></tr>")
            }
            for (var i = 0; i < GridData.jsonDiagnosis.length; i++) {
                if (GridData.jsonDiagnosis[i].NAME.trim() != "") {
                    var DiagRemark = "";
                    if (GridData.jsonDiagnosis[i].REMARKS != "") {
                        DiagRemark = " " + " - " + GridData.jsonDiagnosis[i].REMARKS.toString()
                    }
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
            }
            if ((GridData.jsonProvDiagnosis && GridData.jsonProvDiagnosis.length > 0)) {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonProvDiagnosis[0].PROVDIAG.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
            }
            strPrindData.push("</table>");
        }

        //ICD Diagnosis
        if (GridData.jsonICDiagnosis.length > 0) {
            if (GridData.jsonDiagnosis.length <= 0) {
                strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")
            } else {
                strPrindData.push("<table style='width:50%;float:right'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")
            }
            for (var i = 0; i < GridData.jsonICDiagnosis.length; i++) {
                var DiagRemark = "";
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDiagnosis[i].NAME + "</li></td></tr>");
            }
            strPrindData.push("</table>");
        }

        //ICD-O Diagnosis
        if (GridData.jsonICDODiagnosis.length > 0) {
            strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD-O Diagnosis</u>: </label></td></tr>")
            for (var i = 0; i < GridData.jsonICDODiagnosis.length; i++) {
                var DiagRemark = "";
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDODiagnosis[i].NAME + "</li></td></tr>");
            }
            strPrindData.push("</table>");
        }

        if (GridData.jsonICDOTopology.length > 0) {
            var ICDOTbl = ICDOTable(GridData.jsonICDOTopology, GridData.jsonICDOHistology);
            strPrindData.push(ICDOTbl);
        }
    }
    //Diagnosis End


    //allergy      
    if ($("#chkAllergy").prop("checked") || $("#chkHistoryPatClinHist").prop("checked")) {
        if (GridData.jsonAllergy.length > 0) {
            strPrindData.push("<table id='AllergyTable'>");
            strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>Allergy</u>:</caption>");
            for (var i = 0; i < GridData.jsonAllergy.length; i++) {
                var AllgryDurType = GridData.jsonAllergy[i].DURTYPE == "D" ? "Days" : (GridData.jsonAllergy[i].DURTYPE == "W" ? "Week" : GridData.jsonAllergy[i].DURTYPE == "M" ? "Month" : GridData.jsonAllergy[i].DURTYPE == "Y" ? "Year" : "")
                var AllgryDur = GridData.jsonAllergy[i].DURATION != "" && Number(GridData.jsonAllergy[i].DURATION) > 0 ? GridData.jsonAllergy[i].DURATION : "";
                //strPrindData.push("<tr><td><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");
                strPrindData.push("<tr><td><li>" + GridData.jsonAllergy[i].ALLERGYTYPE + " Allergy - " + GridData.jsonAllergy[i].NAME + (AllgryDur != "" ? (" For " + AllgryDur + " " + AllgryDurType) : ""));
                strPrindData.push("</li></td></tr>");
            }
            strPrindData.push("</table>");
        }
    }
    //end of allergy


    //Clinical Notes start
    if ($("#chkClinicalNotes").prop("checked") || $("#chkClinicalNtPatClinHist").prop("checked")) {

        //priyanka 10/04/2026
        if (IsClinicNotesFreeTxtVisible === "Y") {
            if (GridData.jsonClinicalHist.length > 0 || GridData.jsonClinicalHist.length > 0) {
                strPrindData.push("<div style='clear:both'></div>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>Clinical Notes </u>: </label>")
                strPrindData.push("<table>");
                if (GridData.jsonClinicalHist.length > 0) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'>" + GridData.jsonClinicalHist[0].CLINICALHIST.toString().replace(/\n/g, '<br />') + "</td></tr>");
                }
                strPrindData.push("</table>")
            }
        }
        else {

            if (GridData.jsonClinicalHist && GridData.jsonClinicalHist.length > 0) {

                var html = GridData.jsonClinicalHist[0].CLINICALHIST || "";

                // Fix encoding issue
                html = decodeURIComponent(html.replace(/%(?![0-9A-Fa-f]{2})/g, '%25'));

                // Remove CKEditor head section (CSS, title, links, etc.)
                html = html.replace(/<head[\s\S]*?<\/head>/gi, '');

                // Check whether actual content exists
                var div = document.createElement("div");
                div.innerHTML = html;

                var textOnly = (div.textContent || div.innerText || "")
                    .replace(/\u00A0/g, '')
                    .trim();

                // Skip printing if editor is empty
                if (textOnly !== "") {

                    strPrindData.push("<div style='clear:both'></div>");
                    //strPrindData.push("<br>");
                    strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>Clinical Notes</u> :</label>");
                    strPrindData.push("<table style='width:100%;'>");

                    //html = cleanCkEditorHtmlKeepImages(html);
                    //html = fixImageUrls(html);
                    //html = convertCkEditorToCompactHtml(html);
                    html = html.replace(
                        /<pre\b([^>]*)>/gi,
                        "<pre$1 style='white-space:pre-wrap; overflow-wrap:anywhere; word-break:break-word; max-width:100%;'>"
                    );
                    strPrindData.push(
                        "<tr>" +
                        "<td class='DTextsize' style='padding:2px;'>" +
                        html +
                        "</td>" +
                        "</tr>"
                    );

                    strPrindData.push("</table>");
                }
            }
        }
        //end
    }
    //Clinical Notes End




    //Investigation start   
    if ($("#chkInvest").prop("checked") || $("#chkAdvInvstPatClinHist").prop("checked")) {

        if (GridData.jsonInvstg.length > 0 || GridData.jsonFreeInvestigation.length > 0) {
            strPrindData.push("<table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[4] + "</u>: </label><td></tr>")
            //4/16/19 table tag added
        }

        if (GridData.jsonInvstg.length > 0) {
            var IvestigationStrg = "";
            for (var i = 0; i < GridData.jsonInvstg.length; i++) {
                //added on 6th april 2018
                var TotalDuration = "";
                var dur = "" + GridData.jsonInvstg[i].DURATION
                var durtype = GridData.jsonInvstg[i].DURTYPE
                if (dur.length > 0) {
                    if (Number(dur) > 0) {
                        TotalDuration = "  perform after" + dur + " " + DurationTypeSelect(durtype, dur)
                    }
                }

                if (GridData.jsonInvstg[i].REMARK.toString() != "") {

                    IvestigationStrg = IvestigationStrg + (IvestigationStrg == "" ?
                        ("<label class='DTextsize' style='padding:2px;line-height:20px;'>" + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />').trim()
                            + "(" + GridData.jsonInvstg[i].REMARK.toString().trim() + ")")
                        : ("<label class='DTextsize' style='padding:2px;line-height:20px;'>, " + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />').trim()
                            + "(" + GridData.jsonInvstg[i].REMARK.toString().trim() + ")"));
                }
                else {
                    IvestigationStrg = IvestigationStrg + (IvestigationStrg == "" ?
                        ("<label class='DTextsize' style='padding:2px;line-height:20px;'>" + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />'))
                        : ("<label class='DTextsize' style='padding:2px;line-height:20px;'>, " + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />')));
                }   
                //------------------------------------------
                //if (GridData.jsonInvstg[i].REMARK.toString() != "") {
                //    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>"
                //        + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />') + " - " + GridData.jsonInvstg[i].REMARK.toString() + " " +
                //        TotalDuration + "</li></td></tr>");
                //}
                //else {
                //    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>"
                //        + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />') + " " +
                //        TotalDuration + "</li></td></tr>");
                //}
            }
            if (IvestigationStrg != "") {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'> " + IvestigationStrg + "</td></tr>");
            }
        }

        //vijeta 20th march 19
        if (GridData.jsonFreeInvestigation.length > 0) {
            /*strPrindData.push("<tr><td class='HTextsize' style='font-weight:bold;padding-top:10px;'><u>Other Investigations / Procedures :</u></td></tr>");*/
            strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonFreeInvestigation[0].FREEINVESTIGATION.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
        }
        strPrindData.push("</table>")
    }

    //Investigation end

    //Patient Advice start
    if ($("#chkInstru").prop("checked") || $("#chkRAdvicePatClinHist").prop("checked")) {

        if (GridData.jsonPatientAdvice.length > 0 || GridData.jsonFreeAdvice.length > 0) {
            strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[3] + " </u>: </label>")
            strPrindData.push("<table>");

            for (var i = 0; i < GridData.jsonPatientAdvice.length; i++) {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonPatientAdvice[i].NAME.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
            }

        }

        if (GridData.jsonFreeAdvice.length > 0) {
            /*strPrindData.push("<tr><td class='HTextsize' style='font-weight:bold;padding-top:10px;'><u>Other Instructions :</u></td></tr>");*/
            strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeAdvice[0].FREEADVICE.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
        }
        strPrindData.push("</table>")
    }

    //Patient Advice end


    if ($("#chkAdvice").prop('checked') || $("#chkAdvicesPatClinHist").prop("checked")) {
        if (GridData.ChemoPlan.length > 0 && GridData.ChemoPlan[0].PLANCOMPLETE == "N") {
            strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'>");
            strPrindData.push("<tr><td class='HTextsize'><label style='font-weight:bold'><u>" + HeaderLang[21] + "</u>:</label></td></tr>");
            //strPrindData.push("<tr><td width='25%'><label>Planning No.</label></td><td style='width:1px;'>:</td><td>" + GridData.ChemoPlan[0].PLANNO + "</td></tr>");
            strPrindData.push("<tr><td width='25%'><label>Chemotherapy Name</label></td><td style='width:1px;'>:</td><td>" + GridData.ChemoPlan[0].CHEMONAME + "</td></tr>");
            strPrindData.push("<tr><td width='25%'><label>Total Number of Cycle</label></td><td style='width:1px;'>:</td><td>" + GridData.ChemoPlan[0].TOTALCYCLE + "</td></tr>");
            strPrindData.push("<tr><td width='25%'><label>Chemo Start Date</label></td><td style='width:1px;'>:</td><td>" + (GridData.ChemoPlan[0].ADVSTARTDATE || "-") + "</td></tr>");
            strPrindData.push("</table>");
        }
    }
    // ChemoPlanning end


    // Medicine advice start 
    if ($("#chkRx").prop("checked") || $("#chkMedRxPatClinHist").prop("checked")) {
        if (GridData.jsonAdvice.length > 0) {

            // Rx label
            strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>Rx</u> :</label>");

            // Rx table
            if (GridData.jsonAdvice.length > 0) {
                var medRxTbl = RxTable();
                strPrindData.push(medRxTbl);
            }
        }
    }

    //folowup start   
    if ($("#chkAdvice").prop('checked') || $("#chkAdvicesPatClinHist").prop("checked")) {

        var dt = "", refDoct = "", AdmAdvDate = "";
        if (GridData.jsonFollowUp.length > 0) {

            var dayNum = "", constString = "";
            refDoct = GridData.jsonFollowUp[0]["REFDOCT"];
            refSpecilist = GridData.jsonFollowUp[0]["REFSPECIALIST"];
            AdmAdvDate = GridData.jsonFollowUp[0]["PROPADMNDT"].toString();
            if ( //priyanka 14/04/2026
                GridData.jsonFollowUp.length > 0 &&
                GridData.jsonFollowUp[0]["ADMNADVYN"] !== "N" &&
                Object.values(GridData.jsonFollowUp[0]).some(val => val && val.toString().trim() !== "" && val !== "N")
            ) {
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>Advice</u>: </label>");
            }
            //end
            for (var e = 0; e < GridData.jsonFollowUp.length; e++) {
                if (GridData.jsonFollowUp[0]["SURGNMADVICE"] != "") {

                    // Surgery Adviced Date - only show if not empty
                    if (GridData.jsonFollowUp[0]["SURGADVDATE"] != "") {
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Adviced Date</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;'>" + GridData.jsonFollowUp[0]["SURGADVDATE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
                    }

                    // Surgery Adviced - names only (comma-split), correct label
                    var surgNamesForPrint = GridData.jsonFollowUp[0]["SURGNMADVICE"].toString().split(/[\n,]/).map(function (s) { return s.trim(); }).filter(function (s) { return s !== ""; }).join('<br />');
                    strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Adviced</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;'>" + surgNamesForPrint + "</label></td></tr></table>");

                    // Surgery Description - free text field, only if not empty (FIXED: now uses SURGADVICEOTHER)
                    if (GridData.jsonFollowUp[0]["SURGADVICEOTHER"] != "") {
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Description</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;'>" + GridData.jsonFollowUp[0]["SURGADVICEOTHER"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
                    }

                    // PAC Advice Date - only show if not empty (FIXED: now checks PACADVDATE, not SURGADVDATE)
                    if (GridData.jsonFollowUp[0]["PACADVDATE"] != "") {
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>PAC Advice Date</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;'>" + GridData.jsonFollowUp[0]["PACADVDATE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
                    }
                }
            //End
                if (NotesWiseDoct != "Y") {
                    if (refDoct.length > 0) {
                        var array = refDoct.split(',');
                        if (GridData.jsonFollowUp[0].FOLLOWUPDT.length >= 0) {
                            strPrindData.push("<table style='width:100%;margin-top:15px'><tr>")
                        }
                        strPrindData.push("<td style='width:25%;margin-top:0px;padding:1px;align:left;vertical-align:top;'><label style='font-weight:bold' class='HTextsize'><u>" + HeaderLang[11].toString() + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><ul style='margin-left:-30px'>");
                        $.each(array, function (index, val) {
                            if (val != "")
                                strPrindData.push("&#9679;<li style='display: inline;font-size:px !important;list-style:circle'>Dr. " + val.replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                        });
                        strPrindData.push("</ul></td>");
                        strPrindData.push("</tr></table>")
                    }
                }
            }

            if ($("#chkAdvice").prop('checked') || $("#chkAdvicesPatClinHist").prop("checked")) {
                if (refSpecilist.length > 0) {
                    var arraySpec = refSpecilist.split(',');

                    if (GridData.jsonFollowUp[0].FOLLOWUPDT.length >= 0) {
                        strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'><tr>");
                    }

                    strPrindData.push("<td style='width:33%;vertical-align:top;'>"
                        + "<label style='font-weight:bold' class='HTextsize'><u>" + HeaderLang[15] + "</u></label></td>"
                        + "<td style='vertical-align:top;width:3% font-size:20px !important;;'><b>:</b></td>"
                        + "<td style='text-align:left;'>"
                        //+ "<ul style='padding-left:0; margin-left:0; list-style:none; font-size:20px !important;font-family:cambria !important;'>"
                    );
                    var SpecStrg = "";
                    $.each(arraySpec, function (index, val) {
                        if (val != "")
                            SpecStrg = SpecStrg + (SpecStrg == "" ? val.replace(/\n/g, '<br />') : (", " + val.replace(/\n/g, '<br />')));
                    });

                    if (SpecStrg != "") {
                        strPrindData.push("<label class='DTextsize' style='padding:2px;line-height:20px;'>" + SpecStrg.trim() + "</label>");
                    }

                    strPrindData.push("</td>");
                    strPrindData.push("</tr></table>");
                }

                if (NotesWiseDoct == "Y" && GridData.jsonRefDoctNote && GridData.jsonRefDoctNote.length > 0) {
                    if (GridData.jsonRefDoctNote.length > 0 || GridData.jsonRefDoctNote.length > 0) {
                        strPrindData.push("<table style='width:100%;'><tr><td style='width:33%;vertical-align:top;'>" +
                            "<label style='font-weight:bold' class='HTextsize'><u>" + HeaderLang[11] + "</u> </label></td>"
                            + "<td style='vertical-align:top;width:3% font-size:20px !important;;'><b>:</b></td><td>")
                    }
                    var RefDoctStrg = "";
                    for (var i = 0; i < GridData.jsonRefDoctNote.length; i++) {
                        if (GridData.jsonRefDoctNote[i].NOTE.toString() != "") {
                            RefDoctStrg = RefDoctStrg + (RefDoctStrg == "" ?
                                ("<label class='DTextsize' style='padding:2px;line-height:20px;'>" + GridData.jsonRefDoctNote[i].REFDOCTNAME.toString().replace(/\n/g, '<br />').trim()
                                    + "(" + GridData.jsonRefDoctNote[i].NOTE.toString().trim() + ")")
                                : ("<label class='DTextsize' style='padding:2px;line-height:20px;'>, " + GridData.jsonRefDoctNote[i].REFDOCTNAME.toString().replace(/\n/g, '<br />').trim()
                                    + "(" + GridData.jsonRefDoctNote[i].NOTE.toString().trim() + ")"));
                        }
                        else {
                            RefDoctStrg = RefDoctStrg + (RefDoctStrg == "" ?
                                ("<label class='DTextsize' style='padding:2px;line-height:20px;'>" + GridData.jsonRefDoctNote[i].REFDOCTNAME.toString().replace(/\n/g, '<br />'))
                                : ("<label class='DTextsize' style='padding:2px;line-height:20px;'>, " + GridData.jsonRefDoctNote[i].REFDOCTNAME.toString().replace(/\n/g, '<br />')));
                        }
                    }
                    if (RefDoctStrg != "") {
                        strPrindData.push(" " + RefDoctStrg + "</td></tr>");
                    }
                }
            }


            //if (GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().trim() != "" && ($("#chkAdvice").prop("checked") || $("#chkAdvicesPatClinHist").prop('checked')))
            //    strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'><tr style='line-height:19px;'><td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold;font-size:20px !important;font-family:cambria !important;'><u>" + HeaderLang[18] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;font-family:cambria !important;'>" + GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            //var SchemeData = GridData.jsonScheme;
            //if (SchemeData && SchemeData.length> 0 && ($("#chkAdvice").prop("checked") || $("#chkAdvicesPatClinHist").prop('checked'))) {
            //    var schemeArr = SchemeData.split('<br/>');
            //    strPrindData.push("<table style='width:100%;margin-top:10px;font-size:20px !important;font-family:cambria !important;'><tr style='line-height:19px;'>");
            //    strPrindData.push("<td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold;font-size:20px !important;font-family:cambria !important;'><u>Scheme</u></label></td>");
            //    strPrindData.push("<td style='vertical-align:top;width:3%'><b>:</b></td>");
            //    strPrindData.push("<td style='vertical-align:top;'>");
            //    for (var i = 0; i < SchemeData.length; i++) {
            //        if (SchemeData[i].SCHEMENAME && SchemeData[i].SCHEMENAME != "") {
            //            strPrindData.push(
            //                "<span class='DTextsize' style='display:block;'>"
            //                + (i < SchemeData.length - 1 ? " margin-bottom:5px;" : "") + "'>" + SchemeData[i].SCHEMENAME +
            //                "</span>"
            //            );
            //        }
            //    }
            //    strPrindData.push("</td></tr></table>");
            //}

            var SchemeData = GridData.jsonScheme;

            if (SchemeData && SchemeData.length > 0 &&
                ($("#chkAdvice").prop("checked") ||
                    $("#chkAdvicesPatClinHist").prop("checked"))) {

                strPrindData.push(
                    "<table style='width:100%;margin-top:10px;font-size:20px !important;font-family:cambria !important;'>" +
                    "<tr style='line-height:19px;'>"
                );

                strPrindData.push(
                    "<td style='width:33%;vertical-align:top;'>" +
                    "<label class='HTextsize' style='font-weight:bold;font-size:20px !important;font-family:cambria !important;'>" +
                    "<u>Scheme</u>" +
                    "</label>" +
                    "</td>"
                );

                strPrindData.push(
                    "<td style='vertical-align:top;width:3%'><b>:</b></td>"
                );

                strPrindData.push(
                    "<td style='vertical-align:top;'>"
                );

                for (var i = 0; i < SchemeData.length; i++) {

                    if (SchemeData[i].SCHEMENAME &&
                        SchemeData[i].SCHEMENAME.trim() !== "") {

                        strPrindData.push(
                            "<span class='DTextsize' style='display:block;" +
                            (i < SchemeData.length - 1 ? "margin-bottom:5px;" : "") +
                            "'>" +
                            SchemeData[i].SCHEMENAME +
                            "</span>"
                        );
                    }
                }

                strPrindData.push(
                    "</td></tr></table>"
                );
            }

            //added on 13th march 19 for prescription remark
            var remark = GridData.jsonFollowUp[0]["REMARK"];
            if (remark != "" && ($("#chkAdvice").prop("checked") || $("#chkAdvicesPatClinHist").prop('checked')))
                strPrindData.push("<table style='width:100%;margin-top:10px;font-size:20px !important;font-family:cambria !important;'><tr style='line-height:19px;'><td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold;font-size:20px !important;font-family:cambria !important;'><u>" + HeaderLang[16] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'> <label class='HTextsize' style='left-margin:10px;font-size:20px !important;font-family:cambria !important;'>" + GridData.jsonFollowUp[0]["REMARK"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
            //Moved By Abhishesh || 20260819
            if (GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().trim() != "" && ($("#chkAdvice").prop("checked") || $("#chkAdvicesPatClinHist").prop('checked')))
                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'><tr style='line-height:19px;'><td style='width:33%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold;font-size:20px !important;font-family:cambria !important;'><u>" + HeaderLang[18] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:20px !important;font-family:cambria !important;'>" + GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
            //End
            if (GridData.jsonFollowUp[0]["ADMNADVYN"].toString() == "Y") {
                var CareType = GridData.jsonFollowUp[0]["PATCARETYPEADVICE"].toString().trim();
                var Sentence = (AdmAdvDate != "" ? ("Admission Adviced on " + AdmAdvDate) : "Admission Adviced");
                Sentence = Sentence + (CareType == "" ? "." : ("(" + CareType + ")."));
                strPrindData.push("<span class='HTextsize'  style='font-size:20px !important;font-weight:bold'>" + Sentence + "</span>");
            }
            var adviceInv = "";
            if (GridData.jsonFollowUp[0].FOLLOWUPDT.length > 0) {
                dayNum = (GridData.jsonFollowUp[0].FOLLOWUPDT).replace(/[^0-9]+/ig, "");
                FollowUp = (GridData.jsonFollowUp[0].FOLLOWUPDT).split(dayNum);
                checkFollowUplanguge(FollowUp, language, 'F')

                if (dayNum.length > 0) {
                    if (Number(dayNum) > 1) {
                        constString = "s"
                    }
                }

                if (GridData.jsonInvstg.length > 0)
                    adviceInv = "with Advised Investigation Reports if any.";
            }

            //vijeta 16th march 19
            if (GridData.jsonFollowUp[0].FOLLOWUPDT == "SOS") {
                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'>");
                strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style='font-weight:bold'>Follow Up :&nbsp;SOS if any complaints " + constString + " " + adviceInv + "</td></tr></table>");
            }
            else {
                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'>");

                if (dayNum != "" && dayNum != "0") {
                    var TranDate = GridData.jsonUserdtls[0].TRANDATE.split(' ')[0];
                    var CalDate = CalculateAppointDate(TranDate, dayNum, languageWise);

                    strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style='font-weight:bold'>Follow Up on "
                        + dayNum + " " + languageWise + constString
                        + " (" + CalDate + "), "
                        + FollowUpPrintText +
                        "</td></tr></table>");
                }
                else {
                    strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style='font-weight:bold'>Follow Up "
                        + FollowUpPrintText +
                        "</td></tr></table>");
                }
            }

            if (GridData.jsonFollowUp[0].APPMNTDT != "" && GridData.jsonFollowUp[0].APPMNTTM != "") {
                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'>");
                strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:20px !important;font-family:cambria !important;'><tr class='inHeight'><td><label class='HTextsize' style='font-weight:bold'>Your Appointment is booked on "
                    + GridData.jsonFollowUp[0].APPMNTDT
                    + " at "
                    + GridData.jsonFollowUp[0].APPMNTTM
                    + " "
                    + adviceInv
                    + "</td></table><br>");
            }

        }
    }



    var StrDoctCode = '<%:Session["gDoctCode"]%>';
    //priyanka 14/04/2026
    strPrindData.push("<div style='clear:both; width:100%; page-break-inside:avoid;'>");
    strPrindData.push("<div style=' margin-left:auto;'>");
    strPrindData.push("<table style='font-family:cambria !important; font-size:20px !important; width:100%; border-collapse:collapse; border-spacing:0; text-align:left;' id='tblDoctInfo'>");

    // ================= SIGNATURE IMAGE =================
    if (digitsign1 != "" || digitsign2 != "" || digitsign3 != "") {

        strPrindData.push("<tr>");

        let imgSrc = "";
        if (digitsign1 != "") imgSrc = digitsign1;
        else if (digitsign2 != "") imgSrc = digitsign2;
        else if (digitsign3 != "") imgSrc = digitsign3;

        //strPrindData.push(
        //    "<td colspan='3' style='padding:0; line-height:0; text-align:right;'>\
        //    <img src='" + imgSrc + "' style='display:block; margin-left:auto; height:50px; object-fit:contain;' />\
        //</td>"
        //);
        //strPrindData.push(
        //    "<tr>\
        //<td style='padding:0 0 0px 0; float:right;'>\
        //    <img src='" + imgSrc + "' style='display:block; width:140px; height:90px; object-fit:contain;' />\
        //</td>\
        // </tr>"
        //);
        strPrindData.push(
            "<tr>\
               <td colspan='3' style='padding:0; text-align:right;'>\
                   <img src='" + imgSrc + "' style='display:block; margin-left:auto; width:140px; height:90px; object-fit:contain;' />\
               </td>\
           </tr>"
        );

        strPrindData.push("</tr>");
    }

    // ================= DOCTOR NAME =================
    strPrindData.push(
        "<tr>\
        <td colspan='2' style='padding-top:4px; line-height:1.2; text-align:right;'>\
            <b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</b>\
        </td>\
    </tr>"
    );

    // ================= DETAILS =================
    if (GridData.jsonDoctorDetails[0].SIGN == "") {

        strPrindData.push(
            "<tr>\
            <td colspan='2' style='padding:2px 0; line-height:1.2; text-align:right; white-space:normal; word-break:break-word; overflow-wrap:anywhere;'>\
                " + GridData.jsonDoctorDetails[0].SPECIALIZATION + "\
            </td>\
        </tr>"
        );

        strPrindData.push(
            "<tr>\
            <td colspan='2' style='padding:2px 0; line-height:1.2; text-align:right; white-space:normal; word-break:break-word; overflow-wrap:anywhere;'>\
                " + GridData.jsonDoctorDetails[0].QUALI + "\
            </td>\
        </tr>"
        );

        strPrindData.push(
            "<tr>\
            <td colspan='2' style='padding:2px 0; line-height:1.2; text-align:right;'>\
                Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "\
            </td>\
        </tr>"
        );

    } else {

        strPrindData.push("<tr>");

        let signText = "";
        if (sign1 != "") signText = sign1;
        else if (sign2 != "") signText = sign2;
        else if (sign3 != "") signText = sign3;

        strPrindData.push(
            "<td colspan='3' style='padding:2px 0; line-height:1.2; text-align:right;'>\
            " + signText.replace(/\n/g, "<br />") + "\
        </td>"
        );

        strPrindData.push("</tr>");
    }

    strPrindData.push("</table>");
    strPrindData.push("</div>");
    strPrindData.push("</div>");
    strPrindData.push("<div style='bottom: 0px;font-size: 11px !important;' class='DTextsize'>");
    strPrindData.push("<hr/>");
    //strPrindData.push("<p>" + BottomLine1 + "</P>");//commented by priyanka on 15/04/2026
    //strPrindData.push("<p>" + BottomLine2 + "</P>");//commented by priyanka on 15/04/2026
    strPrindData.push("</div>");
    strPrindData.push("</body></html>");
    return strPrindData.join("");
}

function GetBindingData(obj) {
    var TransNo = $(obj).attr('id')
    var mrNo = sessionStorage.getItem("PatMRNO");
    var datatosend = {
        tranno: TransNo,
        type: "NAME",
        MrNo: mrNo,
    }

    var Html = "", HtmlTop = "";   // Added by Dhananjay 20240724
    $.ajax({
        type: "Post",
        url: "../DoctorDesk/GetDoctorDeskData",
        data: datatosend,
        async: false,
        success: function (response) {
            GridData = response;
            digitsign1 = "";
            digitsign2 = "";
            digitsign3 = "";
            sign1 = "";
            sign2 = "";
            sign3 = "";
            if (GridData.jsonDoctorDetails.length > 0)
                GetDoctSignature(GridData.jsonDoctorDetails[0].DOCTCODE);
            HtmlTop = PrintPatInfo();            // Changed by Dhananjay 20240724
            Html = PrintData(TransNo, mrNo)
            openWin1WithLetterHead(Html, HtmlTop, mrNo, TransNo, patName)
            GridData = "";
        },
        error: function (jqXHR, textStatus, errorThrown) {
            $.messager.alert("Information", textStatus);
        }
    });
}

function openWin1WithLetterHead(Html, HtmlTop, mrNo, TransNo, patName) {   // Added by Dhananjay 20240724
    var patName = sessionStorage.getItem('PatName');

    var Mrno = mrNo;
    var datatosend = {
        printdata: encodeURIComponent(Html),
        printdataTop: encodeURIComponent(HtmlTop),
        TranNo: TransNo,
        Mrno: Mrno,
        printedBy: patName
    };
    $.ajax({
        type: "POST",
        url: "../DoctorDesk/PrintPrescription",
        async: false,
        data: datatosend,
        dataType: "json",
        success: function (response) {
            if (response == "Success") {
                var url = 'DisplayPrintTemplate?FormName=DocPresc';
                var ind = Html.toString().trim().indexOf("Imagedata");
                if (ind > 0) {
                    setTimeout(function () {
                        var win = window.open(url, '', 'width=1024, height=700');
                        win.document.close();
                        win.focus();
                    }, 600);
                }
                else {
                    var win = window.open(url, '', 'width=1024, height=700');
                    win.document.close();
                    win.focus();
                }
            }
            else
                $.messager.alert("Information", response);
        },
        error: function () {

            alert('error');
        }
    });
}

function DurationTypeSelect(type, duration) {

    strDay = "Day";
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

function CalculateAppointDate(TranDate, Increase, IncreaseType) {
    var parts = TranDate.split('/');
    var dateObj = new Date(parts[2] + "-" + parts[1] + "-" + parts[0]);
    if (IncreaseType.trim().toUpperCase().includes("D")) {
        dateObj.setDate(dateObj.getDate() + Number(Increase));
    }
    else if (IncreaseType.trim().toUpperCase().includes("W")) {
        dateObj.setDate(dateObj.getDate() + (Number(Increase)) * 7);
    }
    else if (IncreaseType.trim().toUpperCase().includes("M")) {
        dateObj.setMonth(dateObj.getMonth() + Number(Increase));
    }
    else if (IncreaseType.trim().toUpperCase().includes("Y")) {
        dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
    }
    else {
        dateObj.setDate(dateObj.getDate() + Number(Increase));
    }
    //switch (IncreaseType) {
    //    case "Day":
    //        dateObj.setDate(dateObj.getDate() + Number(Increase));
    //        break;
    //    case "Week":
    //        dateObj.setDate(dateObj.getDate() + Number(Increase) * 7);
    //        break;
    //    case "Month":
    //        dateObj.setMonth(dateObj.getMonth() + Number(Increase));
    //        break;
    //    case "Year":
    //        dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
    //        break;
    //    default:
    //        console.warn("Invalid IncreaseType");
    //}
    var dd = String(dateObj.getDate()).padStart(2, '0');
    var mm = String(dateObj.getMonth() + 1).padStart(2, '0');
    var yyyy = dateObj.getFullYear();
    return (dd + "/" + mm + "/" + yyyy);
}


function ICDOTable(TopologyLst, HistologyLst) {
    TopologyLst = TopologyLst == "" ? [] : TopologyLst;
    HistologyLst = HistologyLst == "" ? [] : HistologyLst;
    var ICDOTbl = "<table style='width:99%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;font-family:cambria !important;'><u>ICD-O Diagnosis</u>: </label></td></tr></table>";
    var MainDiv = '<div id="MainDiv" style="width:99.9%;float:left;border: 1px solid #9d9d9d;margin-bottom:10px;font-family:cambria !important;">{MAINDIVCONTENT}</div>';
    var TopoHeader = '<div style="width:100%;float:left;font-weight:bold;padding: 5px 0px;"><label class="HTextsize" style="font-weight:bold;font-family:cambria !important;">Topography - {TOPOLOGYNAME}</label></div>';
    var HistoTbl = ' <table style="width:100%;float:left;empty-cells: hide;border-collapse: collapse;border: 1px solid #9d9d9d;font-family:cambria !important;">{HISTOTABLECONTENT} </table>';
    var HistoTblHead = '<thead style="border: 1px solid #9d9d9d;"><tr><td style="border: 1px solid #9d9d9d;width:120px;font-family:cambria !important;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Code Generated</label></td><td style="border: 1px solid #9d9d9d;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Description</label></td></tr></thead>';
    var HistoTblBody = '<tbody style="page-break-inside:auto;">{HISTOBODYCONTENT}</tbody>';
    var Tr = '<tr style="border: 1px solid #9d9d9d;font-family:cambria !important;break-inside:avoid;page-break-inside:avoid;">{TRCONTENT}</tr>';
    var Td = '<td style="border: 1px solid #9d9d9d;text-align:center;page-break-inside:avoid;"><label class="DTextsize" style="font-family:cambria !important;">{TDCONTENT}</label></td>';
    var TNMDiv = '<div style="width:100%;float:left;font-family:cambria !important;">{TNMCONTENT}</div>';
    var TNMTbl = '<table style="width:100%;float:left;font-family:cambria !important;">{TNMTABLECONTENT}</table>';
    //var TNMFirstRow = '<tr><td><label class="HTextsize"><span style="font-weight:bold;width:80px;display: inline-block;">Site</span><span style="font-weight:bold;display: inline-block;;padding-right:5px"> : </span>{SITENAME}</label></td><td><label class="HTextsize"><span style="font-weight:bold;width:80px;display: inline-block;">Sub-Site</span><span style="font-weight:bold;display: inline-block;padding-right:5px;"> : </span>{SUBSITENAME}</label></td>' +
    //    '<td><label class="HTextsize" style="display:inline-block;"><span style="font-weight:bold;width:80px;display:inline-block;">TNM</span><span style="font-weight:bold;display:inline-block;padding-right:5px"> : </span>{TNMLABEL}{PREFIX}{TNM}</label></td</tr>'

    var TNMFirstRow =
        '<tr>' +
        '<td colspan="3">' +
        '<label class="HTextsize">' +
        '<span style="font-weight:bold;width:90px;display:inline-block;">Site</span>' +
        '<span style="font-weight:bold;"> : </span>{SITENAME}' +
        '</label>' +
        '</td>' +
        '</tr>' +

        '<tr>' +
        '<td colspan="3">' +
        '<label class="HTextsize">' +
        '<span style="font-weight:bold;width:90px;display:inline-block;">Sub-Site</span>' +
        '<span style="font-weight:bold;"> : </span>{SUBSITENAME}' +
        '</label>' +
        '</td>' +
        '</tr>' +

        '<tr>' +
        '<td colspan="3">' +
        '<label class="HTextsize">' +
        '<span style="font-weight:bold;width:90px;display:inline-block;">TNM</span>' +
        '<span style="font-weight:bold;"> : </span>{TNMLABEL}{PREFIX}{TNM}' +
        '</label>' +
        '</td>' +
        '</tr>';
    var StageRow =
        '<tr>' +
        '<td colspan="3">' +
        '<label class="HTextsize">' +
        '<span style="font-weight:bold;width:90px;display:inline-block;">Stage</span>' +
        '<span style="font-weight:bold;"> : </span>{STAGE}' +
        '</label>' +
        '</td>' +
        '</tr>';

    for (var i = 0; i < TopologyLst.length; i++) {
        var RplTopoHeader = TopoHeader.replace("{TOPOLOGYNAME}", (TopologyLst[i].TOPOCODE + " - " + TopologyLst[i].TOPONAME));
        var FilterHisto = HistologyLst.filter(function (a) {
            return a.TOPOCODE.toString().trim() == TopologyLst[i].TOPOCODE.toString().trim() && a.TOPONAME.toString().trim() == TopologyLst[i].TOPONAME.toString().trim();
        });
        var HistBody = "";
        jQuery.grep(FilterHisto, function (e) {
            var GenCode = e.TOPOCODE.toString().trim() + e.HISTOCODE.toString().trim() + " " + e.GRADE.toString().trim();
            var GenCodeTd = Td.replace("{TDCONTENT}", GenCode);
            var DescTd = '<td class="DTextsize" style="border: 1px solid #9d9d9d;font-family:cambria !important;"><label>' + (e.TOPONAME.toString().trim() + ", " + e.HISTONAME.toString().trim() + ", " + e.GRADENAME.toString().trim()) + '</label></td>';
            var RplTr = Tr.replace("{TRCONTENT}", (GenCodeTd + DescTd));
            HistBody = HistBody + RplTr;
        });
        var RplHistoTblBody = HistoTblBody.replace("{HISTOBODYCONTENT}", HistBody);
        var RplHistoTbl = HistBody == "" ? "" : HistoTbl.replace("{HISTOTABLECONTENT}", (HistoTblHead + RplHistoTblBody));
        var TNMVal = TopologyLst[i].T + TopologyLst[i].N + TopologyLst[i].M;
        var isAdjuvant = TopologyLst[i].ADJUVANT?.trim().toUpperCase() === "Y";
        var isRecurrent = TopologyLst[i].RECCURENT?.trim().toUpperCase() === "Y";
        var tnmLabel = isAdjuvant && isRecurrent ? "yr" : isAdjuvant ? "y" : isRecurrent ? "r" : "";
        var RplTNMFirstRow = TNMFirstRow.replace("{TNMLABEL}", tnmLabel).replace("{SITENAME}", TopologyLst[i].SITE).replace("{SUBSITENAME}", TopologyLst[i].SUBSITE).replace("{PREFIX}", TopologyLst[i].PREFIX).replace("{TNM}", TNMVal);
        //var RplTNMSecondRow = TNMSecondRow.replace("{PREFIX}", TopologyLst[i].PREFIX).replace("{TNM}", TNMVal).replace("{STAGE}", TopologyLst[i].STAGE);
        //var RplTNMSecondRow = TNMSecondRow.replace("{PREFIX}", TopologyLst[i].PREFIX).replace("{TNM}", TNMVal).replace("{STAGE}", TopologyLst[i].STAGE);
        var RplRemRow = OtherFieldICDO(TopologyLst[i]);
        var RplStageRow = StageRow.replace("{STAGE}", TopologyLst[i].STAGE);
        var RplTNMTbl = TNMTbl.replace("{TNMTABLECONTENT}", (RplTNMFirstRow + RplRemRow + RplStageRow));
        var RplTNM = TNMDiv.replace("{TNMCONTENT}", RplTNMTbl);
        var RplMainDiv = MainDiv.replace("{MAINDIVCONTENT}", (RplTopoHeader + RplHistoTbl + RplTNM));
        ICDOTbl = ICDOTbl + RplMainDiv;
    }
    return ICDOTbl;
}

function OtherFieldICDO(OtherDtls) {
    var OtherFieldList = [
        { ID: "GEOGRAPHIC", LABEL: "Grade" },
        { ID: "LOCATION", LABEL: "Location" },
        { ID: "MITOTIC", LABEL: "Mitotic" },
        { ID: "PSA", LABEL: "PSA" },
        { ID: "SERUMMARKERS", LABEL: "Serum Markers" },
        { ID: "HERITABLETRAIT", LABEL: "Heritable Trait" },
        { ID: "HER2", LABEL: "HER2" },
        { ID: "ER", LABEL: "ER" },
        { ID: "PR", LABEL: "PR" },
        { ID: "BLOODINVL", LABEL: "Blood invl." },
    ];
    var TR = '<tr>{TRCONTENT}</tr>';
    var TD = '<td><label class="HTextsize"><span style="font-weight:bold;width:95px;display: inline-block;">{LABEL}</span><span style="font-weight:bold;display: inline-block;;padding-right:5px"> : </span>{CONTENT}</label></td>';
    //var TD = '<td><label class="HTextsize"><span style="font-weight:bold;width:90px;display: inline-block;">{LABEL}</span><span style="font-weight:bold;display: inline-block;;padding-right:5px"> : </span>{CONTENT}</label></td>';
    var MaxCount = 3;
    var html = '';
    var rowContent = '';
    var count = 0;
    for (var i = 0; i < OtherFieldList.length; i++) {
        var item = OtherFieldList[i];
        var value = (OtherDtls && OtherDtls[item.ID] && OtherDtls[item.ID].toString().trim() !== '') ? OtherDtls[item.ID] : null;
        if (value === null) continue;
        var tdHTML = TD.replace('{LABEL}', item.LABEL).replace('{CONTENT}', OtherDtls[item.ID]);
        rowContent += tdHTML;
        count++;
        if (count % MaxCount === 0) {
            html += TR.replace('{TRCONTENT}', rowContent);
            rowContent = '';
        }
    }
    if (rowContent !== '') {
        html += TR.replace('{TRCONTENT}', rowContent);
    }
    return html;
}


function GetDoctSignature1(StrDoctCode, PrintTranNo, mrNo) {
    var datatosend = {
        strdoctcode: StrDoctCode
    }
    startLoading("Loading...");
    $.ajax({
        type: "Post",
        url: "../DoctorDesk/GetSignatory",
        data: datatosend,
        async: true,
        success: function (response) {
            var data = JSON.parse(response);
            if (data.length > 0) {
                if (data[0]["SIGN"] != "") {
                    sign1 = "" + data[0]["SIGN"];
                }
                if (data[0]["DIGSIGN1"] != "") {
                    digitsign1 = "data:image/jpeg;base64," + data[0]["DIGSIGN1"];
                }
                if (data[0]["SIGN2"] != "") {
                    sign2 = "" + data[0]["SIGN2"];
                }
                if (data[0]["DIGSIGN2"] != "") {
                    digitsign2 = "data:image/jpeg;base64," + data[0]["DIGSIGN2"];
                }
                if (data[0]["SIGN3"] != "") {
                    sign3 = "" + data[0]["SIGN3"];
                }
                if (data[0]["DIGSIGN3"] != "") {
                    digitsign3 = "data:image/jpeg;base64," + data[0]["DIGSIGN3"];
                }
            }
            //if (PrecriptionPrintTemp && PrecriptionPrintTemp.trim() === "1") {
            //    Html = PrintData1("Y");
            //} else {
            //    Html = PrintData(PrintTranNo, mrNo);
            //}
            //HtmlTopData = PrintPatInfo1(PrintTranNo);
            //infotomail = Html;
            //infotomail2 = HtmlTopData;
            //openWin(Html, HtmlTopData);
            //GridData = "";
            stopLoading();
        },
        error: function (jqXHR, textStatus, errorThrown) {
        }
    });
}


function PrintPatInfo1(TranNo) {
    //debugger;
    var strPrindData = [];
    var Mrno = GetSessionMRNO();//sessionStorage.getItem('PatMRNO');
    var strTran = TranNo;// sessionStorage.getItem('PatTRANNO');
    var patName = sessionStorage.getItem('PatName');
    var strAge = Number(GridData.jsonUserdtls[0].PATAGE.split(":")[0]) > 0 ? Number(GridData.jsonUserdtls[0].PATAGE.split(":")[0]) +
        " Years" : Number(GridData.jsonUserdtls[0].PATAGE.split(":")[1]) > 0 ? Number(GridData.jsonUserdtls[0].PATAGE.split(":")[1]) +
            " Months" : Number(GridData.jsonUserdtls[0].PATAGE.split(":")[2]) + " Days"
    strPrindData.push("<table style='width:100%;margin-bottom:5px;border-collapse:collapse;font-family:cambria !important;font-size:20px !important;' id='tblPatInfo'>");
    strPrindData.push("<tr><td style='font-weight:bold; font-size:28px'>Name</td><td style='font-weight:bold; font-size:28px'>:</td><td style='font-size:28px'>" + GridData.jsonUserdtls[0].PATNAME + "</td>");
    strPrindData.push("<td style='font-weight:bold; font-size:28px'>Age/Gender</td><td style='font-weight:bold; font-size:28px'>:</td>");
    strPrindData.push("<td style='font-size:28px'>" + strAge + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr>");
    strPrindData.push("<tr><td style='font-weight:bold; font-size:28px'>MR No.</td><td style='font-weight:bold; font-size:28px'>:</td><td style='font-size:28px'>" + Mrno + "</td>");
    strPrindData.push("<td style='font-weight:bold; font-size:28px'>Date/Time</td><td style='font-weight:bold; font-size:28px'>:</td><td style='font-size:28px'>" + GridData.jsonUserdtls[0].TRANDATE + " </td>");
    strPrindData.push("</tr><tr><td style='font-weight:bold; font-size:28px'>Doctor</td><td style='font-weight:bold; font-size:28px'>:</td><td style='font-size:28px'>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");
    strPrindData.push("<td style='font-weight:bold; font-size:28px'>Consultation No.</td><td style='font-weight:bold; font-size:28px'>:</td>");
    strPrindData.push("<td style='font-size:28px'>" + strTran + "</td></tr>");
    if (GridData.jsonUserdtls[0].PATMOBILE.toString().trim() != "") {
        strPrindData.push("<td style='font-weight:bold; font-size:28px'>Mobile No.</td><td style='font-weight:bold; font-size:28px'>:</td>");
        strPrindData.push("<td style='font-size:28px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>");
    }
    if (GridData.jsonUserdtls[0].PATEMAIL.toString().trim() != "") {
        strPrindData.push("<td style='font-weight:bold; font-size:28px'>Email</td><td style='font-weight:bold; font-size:28px'>:</td><td style='font-size:28px'>" + GridData.jsonUserdtls[0].PATEMAIL + "</td></tr>");
    }
    if (GridData.jsonUserdtls[0].PATADDRESS.toString().trim() != "") {
        strPrindData.push("<tr><td style='font-weight:bold; font-size:28px'>Address</td><td style='font-weight:bold; font-size:28px'>:</td><td style='font-size:28px' colspan='4'>" + GridData.jsonUserdtls[0].PATADDRESS + "</td></tr>");
    }
    if (GridData.jsonUserdtls[0].COCANAME != "") {
        strPrindData.push("<tr><td style='font-weight:bold; font-size:28px'>Exemp Catg.</td><td style='font-weight:bold; font-size:28px'>:</td><td style='font-size:28px'>" + GridData.jsonUserdtls[0].COCANAME + "</td>");
        if (GridData.jsonUserdtls[0].EMPID != "") {
            strPrindData.push("<td style='font-weight:bold; font-size:28px'>Employee ID</td><td style='font-weight:bold; font-size:28px'>:</td>");
            strPrindData.push("<td style='font-size:28px'>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "</td></tr>");
        } else {
            strPrindData.push("<td style='font-weight:bold; font-size:28px'>Exemp Proof</td><td style='font-weight:bold; font-size:28px'>:</td>");
            strPrindData.push("<td style='font-size:28px'>" + GridData.jsonUserdtls[0].CONSCATPROOF + "</td></tr>");
        }
    }
    strPrindData.push("</table>");
    return strPrindData.join("");
}



function convertCkEditorToCompactHtml(html) {
    if (!html) return "";

    var div = document.createElement("div");
    div.innerHTML = html;

    function processNode(node, output) {
        if (node.nodeType === 3) {
            var text = node.textContent;
            if (text) output.push(text);
            return;
        }
        if (node.nodeType !== 1) return;

        var tag = node.tagName.toLowerCase();

        // Images - keep as-is
        if (tag === "img") {
            output.push(node.outerHTML);
            return;
        }

        // BR
        if (tag === "br") {
            output.push("<br/>");
            return;
        }

        // Tables - keep structure, force inline styles
        if (tag === "table") {
            output.push("<table style='border-collapse:collapse;width:100%;margin:2px 0;'>");
            node.childNodes.forEach(function (c) { processNode(c, output); });
            output.push("</table>");
            return;
        }
        if (tag === "thead" || tag === "tbody" || tag === "tfoot") {
            node.childNodes.forEach(function (c) { processNode(c, output); });
            return;
        }
        if (tag === "tr") {
            output.push("<tr>");
            node.childNodes.forEach(function (c) { processNode(c, output); });
            output.push("</tr>");
            return;
        }
        if (tag === "td" || tag === "th") {
            var isHeader = tag === "th";
            output.push("<" + tag + " style='border:1px solid #999;padding:3px 5px;margin:0;" + (isHeader ? "font-weight:bold;background:#f2f2f2;" : "") + "'>");
            node.childNodes.forEach(function (c) { processNode(c, output); });
            output.push("</" + tag + ">");
            return;
        }

        // UL - bullet list
        if (tag === "ul") {
            node.childNodes.forEach(function (child) {
                if (child.nodeType === 1 && child.tagName.toLowerCase() === "li") {
                    var liContent = [];
                    child.childNodes.forEach(function (c) { processNode(c, liContent); });
                    var liText = liContent.join("").trim();
                    if (liText) {
                        output.push("<div style='margin:0;padding:0;line-height:1.4;'>&bull;&nbsp;" + liText + "</div>");
                    }
                }
            });
            return;
        }

        // OL - numbered list
        if (tag === "ol") {
            var idx = 1;
            node.childNodes.forEach(function (child) {
                if (child.nodeType === 1 && child.tagName.toLowerCase() === "li") {
                    var liContent = [];
                    child.childNodes.forEach(function (c) { processNode(c, liContent); });
                    var liText = liContent.join("").trim();
                    if (liText) {
                        output.push("<div style='margin:0;padding:0;line-height:1.4;'>" + idx + ".&nbsp;" + liText + "</div>");
                        idx++;
                    }
                }
            });
            return;
        }

        // Headings h1-h6
        if (/^h[1-6]$/.test(tag)) {
            var hContent = [];
            node.childNodes.forEach(function (c) { processNode(c, hContent); });
            var hText = hContent.join("").trim();
            if (hText) {
                output.push("<div style='margin:0;padding:0;line-height:1.4;font-weight:bold;'>" + hText + "</div>");
            }
            return;
        }

        // Paragraph
        if (tag === "p") {
            var pContent = [];
            node.childNodes.forEach(function (c) { processNode(c, pContent); });
            var pText = pContent.join("").trim()
                .replace(/^(<br\/>)+/, "")
                .replace(/(<br\/>)+$/, "");
            if (pText && pText.replace(/&nbsp;/gi, "").trim()) {
                output.push("<div style='margin:0;padding:0;line-height:1.4;'>" + pText + "</div>");
            }
            return;
        }

        // Div
        if (tag === "div") {
            var dContent = [];
            node.childNodes.forEach(function (c) { processNode(c, dContent); });
            var dText = dContent.join("").trim();
            if (dText) {
                output.push("<div style='margin:0;padding:0;line-height:1.4;'>" + dText + "</div>");
            }
            return;
        }

        // Bold
        if (tag === "strong" || tag === "b") {
            var bOut = [];
            node.childNodes.forEach(function (c) { processNode(c, bOut); });
            output.push("<strong>" + bOut.join("") + "</strong>");
            return;
        }

        // Italic
        if (tag === "em" || tag === "i") {
            var iOut = [];
            node.childNodes.forEach(function (c) { processNode(c, iOut); });
            output.push("<em>" + iOut.join("") + "</em>");
            return;
        }

        // Underline
        if (tag === "u") {
            var uOut = [];
            node.childNodes.forEach(function (c) { processNode(c, uOut); });
            output.push("<u>" + uOut.join("") + "</u>");
            return;
        }

        // Span - strip style, keep content
        // Span - keep highlight/text colour only, strip everything else (font-family/size etc.)
        if (tag === "span") {
            var spOut = [];
            node.childNodes.forEach(function (c) { processNode(c, spOut); });
            var content = spOut.join("");
            var bg = node.style && node.style.backgroundColor;
            var col = node.style && node.style.color;
            var styleParts = [];
            if (bg) styleParts.push("background-color:" + bg);
            if (col) styleParts.push("color:" + col);
            output.push(styleParts.length ? ("<span style='" + styleParts.join(";") + "'>" + content + "</span>") : content);
            return;
        }
        // Default - process children
        node.childNodes.forEach(function (c) { processNode(c, output); });
    }

    var result = [];
    div.childNodes.forEach(function (node) {
        processNode(node, result);
    });

    return result.join("");
}
function stripCkEditorSpacing(html) {
    if (!html) return "";

    // Remove empty paragraphs: <p></p>, <p> </p>, <p>&nbsp;</p>, <p><br></p>
    html = html.replace(/<p[^>]*>(\s|&nbsp;|<br\s*\/?>)*<\/p>/gi, "");

    // Remove margin/padding from paragraph inline styles
    html = html.replace(/<p([^>]*)style\s*=\s*["']([^"']*)["']([^>]*)>/gi, function (match, before, style, after) {
        style = style.replace(/margin[^;]*;?/gi, "");
        style = style.replace(/padding[^;]*;?/gi, "");
        style = style.trim().replace(/;+$/, "");
        return "<p" + before + (style ? " style='" + style + "'" : "") + after + ">";
    });

    // Remove margin/padding from heading inline styles  
    html = html.replace(/<h([1-6])([^>]*)style\s*=\s*["']([^"']*)["']([^>]*)>/gi, function (match, level, before, style, after) {
        style = style.replace(/margin[^;]*;?/gi, "");
        style = style.replace(/padding[^;]*;?/gi, "");
        style = style.trim().replace(/;+$/, "");
        return "<h" + level + before + (style ? " style='" + style + "'" : "") + after + ">";
    });

    // Collapse 3+ consecutive <br> into max 1
    html = html.replace(/(<br\s*\/?>[\s]*){3,}/gi, "<br/>");

    return html;
}