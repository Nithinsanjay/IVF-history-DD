var GetFreqCol = getFreqColumn();
var GetOmitCol = getOmitColumn();
var GetRemakCol = getRemarkColumn();
var GetActionColumn = getActionColumn();
var GetOmittedByColumn = getOmittedByColumn();
var GetOmittedDateColumn = getOmittedDateColumn();
var GetOmittedTimeColumn = getOmittedTimeColumn();
var GetOrderedByColumn = getOrderedByColumn();
var GetOrderedDateColumn = getOrderedDateColumn();
var GetOrderedTimeColumn = getOrderedTimeColumn();
var specilizationlist = '';
var ISRYN = "Y";
var resultofal = '';
var MaxSEQ = "";
var click = false;
var DayofDurgsTodaysChk = false;
var IsPastDate = false;// 
var Time = new Date();
var CuurentTime = Time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
var AllGrid = ['JqGridMedication', 'JqGridNebulization', 'JqGridSpeciaInstructions', 'JqGridSTATOrders', 'JqGridInfusion', 'JqGridInvestigation', 'JqGridReferrals', 'JqGridAntibiotics', 'JqGridSTATOrdersOnMedication', 'JqGridBloodProduct']

//................................................
$(window).load(function () {



});
$(document).ready(function () {
    var strIpNo = $.session.get('ICUPatIPNO');
    if (strIpNo != null)
        Get_CaseDetails(strIpNo);
    //if (NotifyTranNo.length > 0 && NotifyIPNo.length > 0) {
    //    GetTreatmentSheetData(NotifyTranNo, 'N', NotifyIPNo);
    //}
    //else {
    //    RetriveTreatmentData('', IsrolloverData);
    //}

    GetDBMaxSEQNO();
    setcurrentDate(CuurentTime);
    GetTranslstData();
    //load_InfusionData();
    $('#btnCancelShwHide').attr('value', 'Show');           ///vishal 16th Nov
    $('#btnCancelShwHide').click(function () {

        if ($('#btnCancelShwHide').prop("value") == "Show") {

            $('#btnCancelShwHide').attr('value', 'Hide');
            var antibio = $('#JqGridAntibiotics').jqGrid('getGridParam', 'colModel');
            if (typeof antibio != "undefined") {
                $('#JqGridAntibiotics').jqGrid('showCol', antibio[17].name);
                $('#JqGridAntibiotics').jqGrid('showCol', antibio[18].name);
                $('#JqGridAntibiotics').jqGrid('showCol', antibio[19].name);
                $('#JqGridAntibiotics').jqGrid('showCol', antibio[20].name);
                $('#JqGridAntibiotics').jqGrid('showCol', antibio[21].name);
                $('#JqGridAntibiotics').jqGrid('showCol', antibio[22].name);
            }

            var medica = $('#JqGridMedication').jqGrid('getGridParam', 'colModel');
            if (typeof medica != "undefined") {
                $('#JqGridMedication').jqGrid('showCol', medica[17].name);
                $('#JqGridMedication').jqGrid('showCol', medica[18].name);
                $('#JqGridMedication').jqGrid('showCol', medica[19].name);
                $('#JqGridMedication').jqGrid('showCol', medica[20].name);
                $('#JqGridMedication').jqGrid('showCol', medica[21].name);
                $('#JqGridMedication').jqGrid('showCol', medica[22].name);
            }

            var inf = $('#JqGridInfusion').jqGrid('getGridParam', 'colModel');
            if (typeof inf != "undefined") {
                $('#JqGridInfusion').jqGrid('showCol', inf[10].name);
                $('#JqGridInfusion').jqGrid('showCol', inf[11].name);
                $('#JqGridInfusion').jqGrid('showCol', inf[15].name);
                $('#JqGridInfusion').jqGrid('showCol', inf[16].name);
                $('#JqGridInfusion').jqGrid('showCol', inf[17].name);
            }
            var statord = $('#JqGridSTATOrders').jqGrid('getGridParam', 'colModel');
            if (typeof statord != "undefined") {
                $('#JqGridSTATOrders').jqGrid('showCol', statord[17].name);
                $('#JqGridSTATOrders').jqGrid('showCol', statord[18].name);
                $('#JqGridSTATOrders').jqGrid('showCol', statord[19].name);
                $('#JqGridSTATOrders').jqGrid('showCol', statord[20].name);
                $('#JqGridSTATOrders').jqGrid('showCol', statord[21].name);
                $('#JqGridSTATOrders').jqGrid('showCol', statord[22].name);
            }

            var statordmed = $('#JqGridSTATOrdersOnMedication').jqGrid('getGridParam', 'colModel');
            if (typeof statordmed != "undefined") {
                $('#JqGridSTATOrdersOnMedication').jqGrid('showCol', statordmed[17].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('showCol', statordmed[18].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('showCol', statordmed[19].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('showCol', statordmed[20].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('showCol', statordmed[21].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('showCol', statordmed[22].name);
            }

            var spclinst = $('#JqGridSpeciaInstructions').jqGrid('getGridParam', 'colModel');
            if (typeof spclinst != "undefined") {
                $('#JqGridSpeciaInstructions').jqGrid('showCol', spclinst[21].name);
                $('#JqGridSpeciaInstructions').jqGrid('showCol', spclinst[22].name);
                $('#JqGridSpeciaInstructions').jqGrid('showCol', spclinst[23].name);
                $('#JqGridSpeciaInstructions').jqGrid('showCol', spclinst[24].name);
                $('#JqGridSpeciaInstructions').jqGrid('showCol', spclinst[25].name);
                $('#JqGridSpeciaInstructions').jqGrid('showCol', spclinst[26].name);
            }

            var bldprdct = $('#JqGridBloodProduct').jqGrid('getGridParam', 'colModel');
            if (typeof bldprdct != "undefined") {
                $('#JqGridBloodProduct').jqGrid('showCol', bldprdct[19].name);
                $('#JqGridBloodProduct').jqGrid('showCol', bldprdct[20].name);
                $('#JqGridBloodProduct').jqGrid('showCol', bldprdct[21].name);
                $('#JqGridBloodProduct').jqGrid('showCol', bldprdct[22].name);
                $('#JqGridBloodProduct').jqGrid('showCol', bldprdct[23].name);
                $('#JqGridBloodProduct').jqGrid('showCol', bldprdct[24].name);
            }

            var invstg = $('#JqGridInvestigation').jqGrid('getGridParam', 'colModel');
            if (typeof invstg != "undefined") {
                $('#JqGridInvestigation').jqGrid('showCol', invstg[12].name);
                $('#JqGridInvestigation').jqGrid('showCol', invstg[13].name);
                $('#JqGridInvestigation').jqGrid('showCol', invstg[14].name);
                $('#JqGridInvestigation').jqGrid('showCol', invstg[15].name);
                $('#JqGridInvestigation').jqGrid('showCol', invstg[16].name);
                $('#JqGridInvestigation').jqGrid('showCol', invstg[17].name);
            }


            var doctref = $('#JqGridReferrals').jqGrid('getGridParam', 'colModel');
            if (typeof doctref != "undefined") {
                $('#JqGridReferrals').jqGrid('showCol', doctref[10].name);
                $('#JqGridReferrals').jqGrid('showCol', doctref[11].name);
                $('#JqGridReferrals').jqGrid('showCol', doctref[12].name);
            }
        }

        else {

            $('#btnCancelShwHide').attr('value', 'Show');
            var antibio = $('#JqGridAntibiotics').jqGrid('getGridParam', 'colModel');
            if (typeof antibio != "undefined") {
                $('#JqGridAntibiotics').jqGrid('hideCol', antibio[17].name);
                $('#JqGridAntibiotics').jqGrid('hideCol', antibio[18].name);
                $('#JqGridAntibiotics').jqGrid('hideCol', antibio[19].name);
                $('#JqGridAntibiotics').jqGrid('hideCol', antibio[20].name);
                $('#JqGridAntibiotics').jqGrid('hideCol', antibio[21].name);
                $('#JqGridAntibiotics').jqGrid('hideCol', antibio[22].name);
            }


            var medica = $('#JqGridMedication').jqGrid('getGridParam', 'colModel');
            if (typeof medica != "undefined") {
                $('#JqGridMedication').jqGrid('hideCol', medica[17].name);
                $('#JqGridMedication').jqGrid('hideCol', medica[18].name);
                $('#JqGridMedication').jqGrid('hideCol', medica[19].name);
                $('#JqGridMedication').jqGrid('hideCol', medica[20].name);
                $('#JqGridMedication').jqGrid('hideCol', medica[21].name);
                $('#JqGridMedication').jqGrid('hideCol', medica[22].name);
            }


            var inf = $('#JqGridInfusion').jqGrid('getGridParam', 'colModel');
            if (typeof inf != "undefined") {
                $('#JqGridInfusion').jqGrid('hideCol', inf[10].name);
                $('#JqGridInfusion').jqGrid('hideCol', inf[11].name);
                $('#JqGridInfusion').jqGrid('hideCol', inf[15].name);
                $('#JqGridInfusion').jqGrid('hideCol', inf[16].name);
                $('#JqGridInfusion').jqGrid('hideCol', inf[17].name);
            }

            var statord = $('#JqGridSTATOrders').jqGrid('getGridParam', 'colModel');
            if (typeof statord != "undefined") {
                $('#JqGridSTATOrders').jqGrid('hideCol', statord[17].name);
                $('#JqGridSTATOrders').jqGrid('hideCol', statord[18].name);
                $('#JqGridSTATOrders').jqGrid('hideCol', statord[19].name);
                $('#JqGridSTATOrders').jqGrid('hideCol', statord[20].name);
                $('#JqGridSTATOrders').jqGrid('hideCol', statord[21].name);
                $('#JqGridSTATOrders').jqGrid('hideCol', statord[22].name);
            }

            var statordmed = $('#JqGridSTATOrdersOnMedication').jqGrid('getGridParam', 'colModel');
            if (typeof statordmed != "undefined") {
                $('#JqGridSTATOrdersOnMedication').jqGrid('hideCol', statordmed[17].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('hideCol', statordmed[18].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('hideCol', statordmed[19].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('hideCol', statordmed[20].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('hideCol', statordmed[21].name);
                $('#JqGridSTATOrdersOnMedication').jqGrid('hideCol', statordmed[22].name);
            }

            var spclinst = $('#JqGridSpeciaInstructions').jqGrid('getGridParam', 'colModel');
            if (typeof spclinst != "undefined") {
                $('#JqGridSpeciaInstructions').jqGrid('hideCol', spclinst[21].name);
                $('#JqGridSpeciaInstructions').jqGrid('hideCol', spclinst[22].name);
                $('#JqGridSpeciaInstructions').jqGrid('hideCol', spclinst[23].name);
                $('#JqGridSpeciaInstructions').jqGrid('hideCol', spclinst[24].name);
                $('#JqGridSpeciaInstructions').jqGrid('hideCol', spclinst[25].name);
                $('#JqGridSpeciaInstructions').jqGrid('hideCol', spclinst[26].name);
            }

            var bldprdct = $('#JqGridBloodProduct').jqGrid('getGridParam', 'colModel');
            if (typeof bldprdct != "undefined") {
                $('#JqGridBloodProduct').jqGrid('hideCol', bldprdct[19].name);
                $('#JqGridBloodProduct').jqGrid('hideCol', bldprdct[20].name);
                $('#JqGridBloodProduct').jqGrid('hideCol', bldprdct[21].name);
                $('#JqGridBloodProduct').jqGrid('hideCol', bldprdct[22].name);
                $('#JqGridBloodProduct').jqGrid('hideCol', bldprdct[23].name);
                $('#JqGridBloodProduct').jqGrid('hideCol', bldprdct[24].name);
            }

            var invstg = $('#JqGridInvestigation').jqGrid('getGridParam', 'colModel');
            if (typeof invstg != "undefined") {
                $('#JqGridInvestigation').jqGrid('hideCol', invstg[12].name);
                $('#JqGridInvestigation').jqGrid('hideCol', invstg[13].name);
                $('#JqGridInvestigation').jqGrid('hideCol', invstg[14].name);
                $('#JqGridInvestigation').jqGrid('hideCol', invstg[15].name);
                $('#JqGridInvestigation').jqGrid('hideCol', invstg[16].name);
                $('#JqGridInvestigation').jqGrid('hideCol', invstg[17].name);
            }

            var doctref = $('#JqGridReferrals').jqGrid('getGridParam', 'colModel');
            if (typeof doctref != "undefined") {
                $('#JqGridReferrals').jqGrid('hideCol', doctref[10].name);
                $('#JqGridReferrals').jqGrid('hideCol', doctref[11].name);
                $('#JqGridReferrals').jqGrid('hideCol', doctref[12].name);
            }

        }


    });

    $("#tabMenuUl1 li").click(function (e) {
        SaveForAllShortCutMenusFromIcu(e);
    });

});
function BindCaseDetaislData(result) {
    if (result.JsonCaseDetailData.length > 0) {
        $("#txtProvDiagno").val(result.JsonCaseDetailData[0].PROVDIAGNO.toString().trim());
    }
    else {
        $("#txtProvDiagno").val('Not Known')
    }

    if (result.JsonAllergisData.length > 0) {
        var allerg = "";
        $.each(result.JsonAllergisData, function (Index, Element) {
            allerg += Element.ALLERGYDESC.toString().trim() + ',';
        })

        $("#txtAllergies").val(allerg.substring(0, allerg.length - 1)).css('color', 'red');
    }
    else {
        $("#txtAllergies").val('Not Known')
    }

}
function Get_CaseDetails(strIpNo) {
    var s;
    $.ajax({
        url: '../ICUMob/GetCaseDetails',
        data: { IPNo: strIpNo },
        type: 'get',
        async: false,
        success: function (data) {
            BindCaseDetaislData(data)
        }
    });
    return s;
}

function SetactiveTab(tabIndex, TabName) {

    switch (tabIndex) {
        case 0:
            //$find('<%=TabContainerTreatmentSheet.ClientID%>').set_activeTabIndex(tabIndex);
            if (TabName == "Antibiotic")
                MsgDia("Please check field Type,Day of Drug,Dose,Route,Frequency, Dilution Volu., Duration of administration should not be Empty in Table :" + TabName);
            else
                MsgDia("Please check field Type,Day of Drug,Dose,Route,Frequency should not be Empty in Table :" + TabName);
            break;
        case 1:
            //$find('<%=TabContainerTreatmentSheet.ClientID%>').set_activeTabIndex(tabIndex);
            if (TabName == "Infusion") {
                MsgDia("Please check field Infusion,Infusion Rate should not be Empty in Table :" + TabName);
            }
            else {
                MsgDia("Please check field Type,Day of Drug,Dose,Route,Frequency should not be Empty in Table :" + TabName);
            }
            break;
        case 2:
            //$find('<%=TabContainerTreatmentSheet.ClientID%>').set_activeTabIndex(tabIndex);
            if (TabName == "STAT Order Dilution")
                MsgDia("Please check field Type,Day of Drug,Dose,Route,Frequency, Dilution Volu., Duration of administration should not be Empty in Table :" + TabName);
            else
                MsgDia("Please check field Type,Day of Drug,Dose,Route,Frequency should not be Empty in Table :" + TabName);

            break;
        case 3:
            //$find('<%=TabContainerTreatmentSheet.ClientID%>').set_activeTabIndex(tabIndex);
            MsgDia("Please check " + TabName);
            break;
        case 5:
            //$find('<%=TabContainerTreatmentSheet.ClientID%>').set_activeTabIndex(tabIndex);
            if (TabName == "Investigation")
                MsgDia("Please check Test field which should not empty in table " + TabName);
            else if (TabName == "Referral") {
                MsgDia("Please check ReferralType field which should not empty in table " + TabName + " Doctor");
            }
            break;
        default:
            //$find('<%=TabContainerTreatmentSheet.ClientID%>').set_activeTabIndex(0);
            break;
    }
}
function setcurrentDate(CuurentTime) {
    var ct
    if (CuurentTime.indexOf('AM') > -1) {
        // ct = CuurentTime.toString().replace('AM', 'am')
        ct = CuurentTime.toString().replace('am', 'AM')
    }
    if (CuurentTime.indexOf('PM') > -1) {
        //ct = CuurentTime.toString().replace('PM', 'pm')
        ct = CuurentTime.toString().replace('pm', 'PM')
    }

    var valn = ct.toString().split(':')
    if (valn[0] <= 9) {
        $('#txtTransTime').val('0' + ct)
    }
    else {
        $('#txtTransTime').val(ct)
    }
}

function AMPMConvert() {
    var ct = ''
    var TimeCovet = $('#txtTransTime').val();

    if (TimeCovet.indexOf('am') > -1) {
        ct = TimeCovet.toString().replace('am', 'AM')
    }
    if (TimeCovet.indexOf('pm') > -1) {
        ct = TimeCovet.toString().replace('pm', 'PM')
    }

    if (ct.length > 0) {
        $('#txtTransTime').val(ct);
    }
    else {
        $('#txtTransTime').val(TimeCovet);
    }
    TsTime = $('#txtTransTime').val();
}
function GetTranslstData() {
    $('#tractiondropdown').find('option').remove();
    IpNo = '' + $.session.get('ICUPatIPNO');
    strdate = '' + $("#txtTransDate").val();


    var d = new Date();

    var month = d.getMonth() + 1;
    var day = d.getDate();

    var output = (day < 10 ? '0' : '') + day + '/' +
        (month < 10 ? '0' : '') + month + '/' + d.getFullYear();
    Url = '../ICUMob/GetTranslst?IpNo=' + IpNo + '&&strDate=' + output
    var s;
    $.ajax({
        url: Url,
        type: 'get',
        async: false,
        success: function (data) {
            // var sel = $('#tractiondropdown')
            //sel.append($("<option>").attr('value', '').text('----Select----'));
            $(data).each(function (index, value) {
                //  sel.append($("<option>").attr('value', this.Value).text(this.Text));
                $('#tractiondropdown').val(this.Value);
            });

            //if (data.length == 1) {
            //    IsRollover = 'N'

            //    $(sel).val(data[0].Value);
            //}
            //else {
            //    if (IsPastDate) {
            //        IsrolloverData = 'Y';
            //        $('#btnSave').val('Save').addClass('Visibility')
            //        MsgDia("No Record Present", "Information");
            //        ClearcontrolData();
            //        $('#txtRollverDate').val('').parent().hide();
            //        $('#lblModeIndicator').text("View")
            //        $('#getloginInfo').addClass('hide')


            //    }
            //    else {

            //    }
            //}

        }
    });
    return s;
}
function GetTreat() {
    IpNo = $.session.get('ICUPatIPNO');
    var NursCode = '' + $.session.get('ICUPatNurstCode');
    //var chngDate2 = "10/10/2019";
    //var year = chngDate2.substring(10, 6);
    //var month = chngDate2.substring(5, 3);
    //var day = chngDate2.substring(0, 2);
    //var setadmndate = year + ',' + month + ',' + day;
    //var actualDate = new Date(setadmndate); // convert to actual date

    //var nextDate = new Date(actualDate.getFullYear(), actualDate.getMonth(), actualDate.getDate() - 1);
    //var nextDate1 = new Date(nextDate);
    //var noday = nextDate1.getDate()+1;
    //var month = nextDate1.getMonth() + 1;
    //var year = nextDate1.getFullYear();
    //var noday = getFormattedPartTime(noday);
    //var month = getFormattedPartTime(month);
    //dt4 = noday + "/" + month + "/" + year;
    var d = new Date();

    var month = d.getMonth() + 1;
    var day = d.getDate();

    var output = (day < 10 ? '0' : '') + day + '/' +
        (month < 10 ? '0' : '') + month + '/' + d.getFullYear();

    TranNo = "";


    var rollYN = "N";
    //if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
    //    rollYN = "Y";
    //    $today = new Date();
    //    $yesterday = new Date($today);
    //    $yesterday.setDate($today.getDate() - 1);


    //    var $dd = $yesterday.getDate();
    //    var $mm = $yesterday.getMonth() + 1; //January is 0!

    //    var $yyyy = $yesterday.getFullYear();
    //    if ($dd < 10) { $dd = '0' + $dd } if ($mm < 10) { $mm = '0' + $mm } $yesterday = $dd + '/' + $mm + '/' + $yyyy;

    //    output = $yesterday;

    //}
    $.ajax({
        url: '../ICUMob/GetTreatmentSheetData',
        // data: { TranNo: "TS190926VP0001", IPNum: "150354", IsRollover: "Y", tsTime: "09:55 AM", tsDate: dt4 },
        data: { TranNo: "" + $('#tractiondropdown').val(), IPNum: $.session.get('ICUPatIPNO'), IsRollover: rollYN, tsTime: $('#txtTransTime').val(), tsDate: output, NurseCode: NursCode },
        type: 'get',
        async: false,
        dataType: "json",
        success: function (Respose) {

            //if (Respose.hasOwnProperty("jsonDetailsData")) {
            //if (Respose.jsonDetailsData[0]["TRANNO"] != "") {
            //    if (Respose.jsonDetailsData[0]["TRANDATE"] != "") {
            //        $('#txtRollverDate').val(Respose.jsonDetailsData[0]["TRANDATE"]);
            //    }
            //}
            //...........................
            var page = window.location.href;
            if (page.indexOf("IPMedication") != -1) {//stat order need to consider

                if ($('#tabMenuUl1').children('li.active')[0].id == "IPStatOrders") {

                    if (!Respose.hasOwnProperty("jsonStatOrderData") || Respose.jsonStatOrderData.length <= 0 || Respose == "" || Respose == null) {
                        GetTreaTmentRolloVer();
                    } else {
                        BindWithoutRolloVer(Respose);
                    }

                }
                else {
                    if (!Respose.hasOwnProperty("jsonMedicineData") || Respose.jsonMedicineData.length <= 0 || Respose == "" || Respose == null) {
                        GetTreaTmentRolloVer();
                    } else {
                        BindWithoutRolloVer(Respose);
                    }
                }
            }
            else if (page.indexOf("IPInfusion") != -1) {
                if (!Respose.hasOwnProperty("jsonInfusionData") || Respose.jsonInfusionData.length <= 0 || Respose == "" || Respose == null) {
                    GetTreaTmentRolloVer();
                } else {
                    BindWithoutRolloVer(Respose);
                }

            }
            else if (page.indexOf("IVsuplement") != -1) {
                if (!Respose.hasOwnProperty("jsonSpecilInstData") || Respose.jsonSpecilInstData.length <= 0 || Respose == "" || Respose == null) {
                    GetTreaTmentRolloVer();
                } else {
                    BindWithoutRolloVer(Respose);
                }
            }
            else if (page.indexOf("NonDrugOrder") != -1) {
                if (!Respose.hasOwnProperty("jsonDetailsData") || Respose.jsonDetailsData.length <= 0 || Respose == "" || Respose == null) {
                    GetTreaTmentRolloVer();
                } else {
                    BindWithoutRolloVer(Respose);
                }
            }
            else if (page.indexOf("IPInvestigation") != -1) {
                if (!Respose.hasOwnProperty("jsonTestData") || Respose.jsonTestData.length <= 0 || Respose == "" || Respose == null) {
                    GetTreaTmentRolloVer();
                } else {
                    BindWithoutRolloVer(Respose);
                }
            }
            else if (page.indexOf("IPReferrals") != -1) {
                if (!Respose.hasOwnProperty("jsonDoctorData") || Respose.jsonDoctorData.length <= 0 || Respose == "" || Respose == null) {
                    GetTreaTmentRolloVer();
                } else {
                    BindWithoutRolloVer(Respose);
                }
            }
            else if (page.indexOf("BloodProduct") != -1) {
                if (!Respose.hasOwnProperty("jsonBloodProductData") == undefined || Respose.jsonBloodProductData.length <= 0 || Respose == "" || Respose == null) {
                    GetTreaTmentRolloVer();
                } else {
                    BindWithoutRolloVer(Respose);
                }
            }

            //.....................................

            // }

            else {
                MsgDia("Roll Over Data Not Found", "Information");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //  ajaxindicatorstop();
            MsgDia(textStatus, "Error Information");
        }

    });
}
function BindWithoutRolloVer(Respose) {
    if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
        $('#lblModeIndicator').text("New");
        $('#btnSave').val('Save');
        fillFormDetailsSS('N', Respose);
    }
    else {
        fillFormDetailsSS('E', Respose);
        $('#lblModeIndicator').text("Update");
        $('#btnSave').val('Update');

    }
}

function GetTreaTmentRolloVer() {

    IpNo = $.session.get('ICUPatIPNO');
    var NursCode = '' + $.session.get('ICUPatNurstCode');


    TranNo = "";


    //var rollYN = "N";
    // if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
    var rollYN = "Y";
    $today = new Date();
    $yesterday = new Date($today);
    $yesterday.setDate($today.getDate() - 1);


    var $dd = $yesterday.getDate();
    var $mm = $yesterday.getMonth() + 1; //January is 0!

    var $yyyy = $yesterday.getFullYear();
    if ($dd < 10) { $dd = '0' + $dd } if ($mm < 10) { $mm = '0' + $mm } $yesterday = $dd + '/' + $mm + '/' + $yyyy;

    output = $yesterday;

    // }
    $.ajax({
        url: '../ICUMob/GetTreatmentSheetData',
        // data: { TranNo: "TS190926VP0001", IPNum: "150354", IsRollover: "Y", tsTime: "09:55 AM", tsDate: dt4 },
        data: { TranNo: "", IPNum: $.session.get('ICUPatIPNO'), IsRollover: rollYN, tsTime: $('#txtTransTime').val(), tsDate: output, NurseCode: NursCode },
        type: 'get',
        async: false,
        dataType: "json",
        success: function (Respose) {

            //if (Respose.hasOwnProperty("jsonDetailsData")) {
            //    if (Respose.jsonDetailsData[0]["TRANNO"] != "") {
            //        if (Respose.jsonDetailsData[0]["TRANDATE"] != "") {
            //            $('#txtRollverDate').val(Respose.jsonDetailsData[0]["TRANDATE"]);
            //        }
            //    }

            //   // if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
            //        $('#lblModeIndicator').text("New");
            //        $('#btnSave').val('Save');
            //        fillFormDetailsSS('N', Respose);
            //    //}
            //    //else {
            //    //    fillFormDetailsSS('E', Respose);
            //    //    $('#lblModeIndicator').text("Update");
            //    //    $('#btnSave').val('Update');

            //    //}
            //}

            //else {
            //    MsgDia("Roll Over Data Not Found", "Information");
            //}



            //...........................
            var page = window.location.href;
            if (page.indexOf("IPMedication") != -1) {//stat order need to consider

                if ($('#tabMenuUl1').children('li.active')[0].id == "IPStatOrders") {

                    if (!Respose.hasOwnProperty("jsonStatOrderData") || Respose.jsonStatOrderData.length <= 0 || Respose == "" || Respose == null) {
                        MsgDia("Roll Over Data Not Found", "Information");
                    } else {
                        //$('#lblModeIndicator').text("New");
                        $('#btnSave').val('Save');
                        fillFormDetailsSS('N', Respose);
                    }
                } else {

                    if (!Respose.hasOwnProperty("jsonMedicineData") || Respose.jsonMedicineData.length <= 0 || Respose == "" || Respose == null) {
                        MsgDia("Roll Over Data Not Found", "Information");
                    } else {
                        // $('#lblModeIndicator').text("New");
                        $('#btnSave').val('Save');
                        fillFormDetailsSS('N', Respose);
                    }
                }
            }
            else if (page.indexOf("IPInfusion") != -1) {
                if (!Respose.hasOwnProperty("jsonInfusionData") || Respose.jsonInfusionData.length <= 0 || Respose == "" || Respose == null) {
                    MsgDia("Roll Over Data Not Found", "Information");
                } else {
                    // $('#lblModeIndicator').text("New");
                    $('#btnSave').val('Save');
                    fillFormDetailsSS('N', Respose);
                }

            }
            else if (page.indexOf("IVsuplement") != -1) {
                if (!Respose.hasOwnProperty("jsonSpecilInstData") || Respose.jsonSpecilInstData.length <= 0 || Respose == "" || Respose == null) {
                    MsgDia("Roll Over Data Not Found", "Information");
                } else {
                    // $('#lblModeIndicator').text("New");
                    $('#btnSave').val('Save');
                    fillFormDetailsSS('N', Respose);
                }
            }
            else if (page.indexOf("NonDrugOrder") != -1) {
                if (!Respose.hasOwnProperty("jsonDetailsData") || Respose.jsonDetailsData.length <= 0 || Respose == "" || Respose == null) {
                    MsgDia("Roll Over Data Not Found", "Information");
                } else {
                    // $('#lblModeIndicator').text("New");
                    $('#btnSave').val('Save');
                    fillFormDetailsSS('N', Respose);
                }
            }
            else if (page.indexOf("IPInvestigation") != -1) {
                if (!Respose.hasOwnProperty("jsonTestData") || Respose.jsonTestData.length <= 0 || Respose == "" || Respose == null) {
                    MsgDia("Roll Over Data Not Found", "Information");
                } else {
                    //$('#lblModeIndicator').text("New");
                    $('#btnSave').val('Save');
                    fillFormDetailsSS('N', Respose);
                }
            }
            else if (page.indexOf("IPReferrals") != -1) {
                if (!Respose.hasOwnProperty("jsonDoctorData") || Respose.jsonDoctorData.length <= 0 || Respose == "" || Respose == null) {
                    MsgDia("Roll Over Data Not Found", "Information");
                } else {
                    // $('#lblModeIndicator').text("New");
                    $('#btnSave').val('Save');
                    fillFormDetailsSS('N', Respose);
                }
            }
            else if (page.indexOf("BloodProduct") != -1) {
                if (!Respose.hasOwnProperty("jsonBloodProductData") == undefined || Respose.jsonBloodProductData.length <= 0 || Respose == "" || Respose == null) {
                    MsgDia("Roll Over Data Not Found", "Information");
                } else {
                    //$('#lblModeIndicator').text("New");
                    $('#btnSave').val('Save');
                    fillFormDetailsSS('N', Respose);
                }
            }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //  ajaxindicatorstop();
            MsgDia(textStatus, "Error Information");
        }

    });


}
function getFormattedPartTime(partTime) {
    if (partTime < 10)
        return "0" + partTime;
    return partTime;
}

function fillFormDetailsSS(act, Respose) {

    gact = act;
    //ClearcontrolData();
    resultofal = Respose;
    //FillDetailData(resultofal)
    //ClearNewDrugdata();
    //  CreateMaxValTypeWise(resultofal);

    if (gact == "N") {
        resultofal.jsonMedicineData = $.grep(resultofal.jsonMedicineData, function (element, index) {
            element.NOTIFYN = 'N';
            return element.OMIT == 'N' && element.STATUS != "C";
        });

        resultofal.jsonAntibioticData = $.grep(resultofal.jsonAntibioticData, function (element, index) {
            element.NOTIFYN = 'N';
            return element.OMIT == 'N' && element.STATUS != "C";
        });

        resultofal.jsonSpecilInstData = $.grep(resultofal.jsonSpecilInstData, function (element, index) {
            element.NOTIFYN = 'N';
            return element.Omit == 'N' && element.STATUS != "C";
        });

        resultofal.jsonBloodProductData = $.grep(resultofal.jsonBloodProductData, function (element, index) {
            return element.Omit == 'N' && element.STATUS != "C";
        });

        resultofal.jsonStatOrderData = $.grep(resultofal.jsonStatOrderData, function (element, index) {
            return element.OMIT == 'N' && element.STATUS != "C";
        });

        resultofal.jsonStatOrderMediData = $.grep(resultofal.jsonStatOrderMediData, function (element, index) {
            element.NOTIFYN = 'N';
            return element.OMIT == 'N' && element.STATUS != "C";
        });

        resultofal.jsonNubellizationdata = $.grep(resultofal.jsonNubellizationdata, function (element, index) {
            element.NOTIFYN = 'N';
            return element.OMIT == 'N' && element.STATUS != "C";
        });

        resultofal.jsonInfusionData = $.grep(resultofal.jsonInfusionData, function (element, index) {
            element.NOTIFYN = 'N';
            return element.Omit == 'N' && element.STATUS != "C";
        });

        resultofal.jsonDoctorData = $.grep(resultofal.jsonDoctorData, function (element, index) {
            return element.STATUS != "C";
        });

        resultofal.jsonTestData = $.grep(resultofal.jsonTestData, function (element, index) {
            return element.STATUS != "C";
        });

        /*-----------Hide Print button on new Mode---------------------*/
        $('#btnPrint').addClass('hide');
    }
    else {
        $('#btnPrint').removeClass('hide');
    }
    //tab 1 
    //29th Sept
    //if (ISRYN == "Y") {
    //    if (tabseq == "0" || tabseq == 0) {
    //        if (resultofal.jsonAntibioticData.length > 0 || resultofal.jsonMedicineData.length > 0) {
    //            SetGridDataMedicine(resultofal)
    //            SetGridDataAntibiotic(resultofal)
    //        }
    //        else {
    //            MsgDia("Roll Over Data Not Found", "Validations");
    //        }

    //    }
    //    else if (tabseq == "1" || tabseq == 1) {
    //        if (resultofal.jsonInfusionData.length > 0) {
    //            SetGridDataInfusion(resultofal)

    //        }
    //        else {
    //            MsgDia("Roll Over Data Not Found", "Validations");
    //        }
    //        $('#txtRemarks').val(resultofal.jsonDetailsData[0].REMARK.toString().trim());
    //    }
    //    else if (tabseq == "2" || tabseq == 2) {
    //        //SetGridDataMedicine(resultofal)
    //        //SetGridDataAntibiotic(resultofal)

    //    }
    //    if (tabseq == "3" || tabseq == 3) {
    //        if (resultofal.jsonSpecilInstData.length > 0 || resultofal.jsonBloodProductData.length > 0) {
    //            SetGridDataSpecilInst(resultofal)
    //            SetGridDataBloodProduct(resultofal);
    //        }
    //        else {
    //            MsgDia("Roll Over Data Not Found", "Validations");
    //        }
    //    }
    //    if (tabseq == "4" || tabseq == 4) {
    //        //SetGridDataMedicine(resultofal)
    //        //SetGridDataAntibiotic(resultofal)
    //    }
    //    if (tabseq == "5" || tabseq == 5) {
    //        if (resultofal.jsonTestData.length > 0 || resultofal.jsonDoctorData.length > 0) {
    //            SetGridDataInvestigation(resultofal);
    //            SetGridDataRefrral(resultofal)
    //        }
    //        else {
    //            MsgDia("Roll Over Data Not Found", "Validations");
    //        }
    //        $('#txtDocRemarks').val(resultofal.jsonDetailsData[0].DOCREMARK.toString().trim())
    //        $('#cmbNutriIntake').select2("val", resultofal.jsonDetailsData[0].INTMNURT.toString().trim());
    //        $('#txtVolSupplmnt').val(resultofal.jsonDetailsData[0].VOLSUPL.toString().trim())
    //    }
    //}

}
function getTypeColumnAnitb() {
    var Type = {
        name: 'Type', index: 'Type', width: 40, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
        edittype: 'select',
        editoptions:
        {
            //value: MediciTypeLStr,
            value: GrdAnitibioticType,
            dataInit: function (el) {
                $(el).css("width", "40")

            }
        }
    }
    return Type;
}

function load_Specilizationlist() {
    var s;
    $.ajax({
        url: '../ICUMob/GetSpecilizationbyCode',
        type: 'get',
        async: false,
        success: function (data) {
            specilizationlist = data;
        }
    });
    return s;
}

function getTypeColumn() {
    var Type = {
        name: 'Type', index: 'Type', width: 40, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
        edittype: 'select',
        editoptions:
        {
            value: MediciTypeLStr,
            dataInit: function (el) {
                $(el).css("width", "40")

            }
        }
    }
    return Type;
}

function getActionColumn() {
    var action = {
        name: 'action', index: 'action', width: 30, fixed: true, sortable: false, resize: false, search: false,
        formatoptions: { editbutton: false, delbutton: false, keys: true },
        formatter: 'actions', searchoptions: { clearSearch: false }
    }
    return action;
}

function getDayOfDrugColumn() {
    var DayOfDrug = {
        name: 'DayOfDrug', index: 'DayOfDrug', width: 30, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return DayOfDrug
}

function getDoseColumn() {
    var Dose = {
        name: 'Dose', index: 'Dose', width: 45, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return Dose
}

function getRouteColumn() {
    MedicineRoutelLst = load_MedicineRote();
    var Route = {
        name: 'Route', index: 'Route', width: 70, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false },
        edittype: 'select',
        editoptions:
        {
            value: MedicineRoutelLst,
            dataInit: function (el) {
                $(el).width(150);
                $(el).select2({
                    width: '400px !important'
                })
            }
        },
    }
    return Route
}

function getFreqColumn() {
    var Freq = {
        name: 'Freq', index: 'Freq', width: 44, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return Freq
}

function getOmitColumn() {
    var Omit = {
        name: 'Omit', index: 'Omit', align: "center", width: 58,
        edittype: 'checkbox', editoptions: { value: "Y:N" }, sortable: false,
        formatter: "checkbox", formatoptions: { disabled: false }
    }
    return Omit
}

function getRemarkColumn() {
    var Remark = {
        name: 'Remark', index: 'Remark', width: 250, align: "left", sortable: false, editable: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return Remark
}

function getOmittedByColumn() {
    var OmittedBy = {
        name: 'OmittedBy', index: 'OmittedBy', width: 110, hidden: true, align: "left", sortable: false, editable: false, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return OmittedBy
}

function getOmittedDateColumn() {
    var OmittedDate = {
        name: 'OmittedDate', index: 'OmittedDate', width: 110, hidden: true, align: "left", sortable: false, editable: false, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return OmittedDate
}

function getOmittedTimeColumn() {
    var OmittedTime = {
        name: 'OmittedTime', index: 'OmittedTime', width: 110, hidden: true, align: "left", sortable: false, editable: false, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return OmittedTime
}

function getOrderedByColumn() {
    var OrderedBy = {
        name: 'OrderedBy', index: 'OrderedBy', width: 100, align: "left", sortable: false, editable: false, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: { maxlength: 60, }
    }
    return OrderedBy
}

function getOrderedDateColumn() {
    var OrderedDate = {
        name: 'OrderedDate', index: 'OrderedDate', width: 80, align: "left", sortable: false, editable: false, hidden: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: {
            size: 20,
            dataInit: function (el) {
                $(el).datepicker({
                    dateFormat: "dd/mm/yy",
                    changeMonth: true,
                    changeYear: true,
                });
            }
        },
    }
    return OrderedDate
}

function getOrderedTimeColumn() {
    var OrderedTime = {
        name: 'OrderedTime', index: 'OrderedTime', width: 80, align: "left", sortable: false, editable: false, hidden: true, searchoptions: { clearSearch: false }, formatoptions: { disabled: true }, editoptions: {
            maxlength: 60,
            size: 20,
            dataInit: function (el) {
                $(el).timepicker({
                    ampm: true,
                    timeFormat: 'hh:mm TT',
                })
                $('.ui-datepicker-close').removeAttr('class');
            }
        },
    }
    return OrderedTime
}

function GetDrugSequenceNo() {
    var sqNum = { name: 'SQNumber', index: 'SQNumber', width: 10, sortable: false, align: 'right', hidden: true };
    return sqNum;

}

function GetHighAlertDrug() {
    var highAlt = { name: 'HighAlert', index: 'HighAlert', width: 10, sortable: false, align: 'right', hidden: true };
    return highAlt;

}

function GetNotifyYN() {
    var Notify = { name: 'NOTIFYN', index: 'NOTIFYN', width: 10, sortable: false, align: 'right', hidden: true };
    return Notify;

}

function GetStatus() {
    var Notify = { name: 'STATUS', index: 'STATUS', width: 10, sortable: false, align: 'right', hidden: true };
    return Notify;

}

function GetADMINYN() {
    var ADMINYN = { name: 'ADMINYN', index: 'ADMINYN', width: 10, sortable: false, align: 'right', hidden: true };
    return ADMINYN;

}
function DatePlus1DayIncrement() {
    //var chngDate1 = dt1;
    // dt1 = chngDate1; //Meenakshi

    var chngDate2 = dt1;
    var year = chngDate2.substring(10, 6);
    var month = chngDate2.substring(5, 3);
    var day = chngDate2.substring(0, 2);
    var setadmndate = year + ',' + month + ',' + day;
    var actualDate = new Date(setadmndate); // convert to actual date

    var nextDate = new Date(actualDate.getFullYear(), actualDate.getMonth(), actualDate.getDate() + 1);
    var nextDate1 = new Date(nextDate);
    var noday = nextDate1.getDate();
    var month = nextDate1.getMonth() + 1;
    var monthname = GetMonthName(month);
    var year = nextDate1.getFullYear();

    dt2 = noday + " " + " " + monthname + " " + year;

}

function GetMonthName(monthNumber) {
    var months = ['January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'];
    return months[monthNumber - 1];
}

function groupTable($rows, startIndex, total) {
    if (total === 0) {
        return;
    }
    var i, currentIndex = startIndex, count = 1, lst = [];
    var tds = $rows.find('td:eq(' + currentIndex + ')');
    var ctrl = $(tds[0]);
    lst.push($rows[0]);
    for (i = 1; i <= tds.length; i++) {
        if (ctrl.text() == $(tds[i]).text()) {
            count++;
            $(tds[i]).addClass('deleted');
            lst.push($rows[i]);
        }
        else {
            if (count > 1) {
                ctrl.attr('rowspan', count);
                groupTable($(lst), startIndex + 1, total - 1)
            }
            count = 1;
            lst = [];
            ctrl = $(tds[i]);
            lst.push($rows[i]);
        }
    }
}


function getColumnIndexByName(grid, columnName) {
    // var cm = $("#JqGridMedication").jqGrid('getGridParam', 'colModel'), i, l = cm.length;
    var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
    for (i = 0; i < l; i++) {
        if (cm[i].name === columnName) {
            return i; // return the index
        }
    }
    return -1;
}

function AddDelButtonByNew(obj, len) {
    var grid = $(obj);
    var title = "";
    var iCol = getColumnIndexByName(grid, 'action');
    if (iCol == 1) {
        var M = grid.find('tr#' + len);
        var td = $(M).find("td:nth-child(" + (iCol + 1) + ")");
        var title = $(td).find('div[title=Delete]');
        if (title.length > 0) {
            //Do Nothing
        }
        else {
            $(td).each(function () {
                $("<div>", {
                    title: "Delete",
                    mouseover: function () {
                        $(this).addClass('ui-state-hover');
                    },
                    mouseout: function () {
                        $(this).removeClass('ui-state-hover');
                    },
                    click: function (e) {
                        var ids = grid.jqGrid('getDataIDs');
                        var rowData = grid.jqGrid('getRowData');              ///vishal 23rd Feb 2019
                        for (var i = 1; i <= ids.length; i++) {
                            grid.jqGrid("editCell", 0, 0, false);
                        }
                        l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                        grid.delRowData(l_orowId);
                    }
                }
                ).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
                    .addClass("ui-pg-div ui-inline-custom")
                    .append('<span class="ui-icon ui-icon-trash"></span>')
                    .appendTo($(this).children("div"));
            });
        }


    }
}
function GetMaxSEQNO(GridName) {
    row = "";
    if (MaxSEQ.hasOwnProperty("Table")) {
        var spliceVal = "";
        var seqrow = $.grep(MaxSEQ.Table, function (Ele, I) {
            if (Ele.TBLTYPE == GetTypeCode()) {
                spliceVal = I;
            }
            return Ele.TBLTYPE == GetTypeCode(GridName);
        })

        if (seqrow.length > 0) {
            row = seqrow
        }
        else {
            row = "";
        }
    }
    else {
        row = "";
    }


    return row;
}


function UpdateMaxSEQNOArray(tblType, SEQNO) {
    if (MaxSEQ.hasOwnProperty("Table")) {
        $.map(MaxSEQ.Table, function (element, Index) {
            if (element.TBLTYPE == tblType) {
                element.Column1 = SEQNO;
            }
        })
    }
}

function AddDataToMaxArray(TblType, SEQNO) {
    if (MaxSEQ.hasOwnProperty("Table")) {
        MaxSEQ.Table.push({ "TBLTYPE": TblType, "Column1": SEQNO })
    }
    else if (MaxSEQ.length >= 0) {
        var Table = [];
        Table.push({
            "TBLTYPE": TblType, "Column1": SEQNO
        })
        var t = { Table: Table };
        MaxSEQ = t;
    }
}
function NonEditableColumn(cm, iCol) {
    Name = cm[iCol].name;

    if (Name == "action" || Name == "MACROSET" || Name == "MICROSET" || Name == "OmittedBy" || Name == "OmittedDate"
        || Name == "OmittedTime" || Name == "OrderedBy" || Name == "OrderedDate" || Name == "OrderedTime") {
        cm[iCol].editable = false;
    }
    else {
        cm[iCol].editable = true;
    }

}
function load_Doctor() {
    var s;
    $.ajax({
        url: '../ICUMob/GetDoctorInfoNew',
        data: {},
        type: 'get',
        async: false,
        success: function (data) {
            globalDoclst = data;
            s = "----Select----:----select----;"; $.each(data, function () {
                s += this.Value + ":" + this.Text + ";";
            });
            s = s.substring(0, s.length - 2);
        }
    });
    globaldoctstring = s;
    return s;
}
function GetTypeCode(selectorgrid) {
    var TypeValue = 'MD'
    switch (selectorgrid) {
        case AllGrid[0]:
            TypeValue = 'MD'
            break;
        case AllGrid[1]:
            TypeValue = 'DL'
            break;
        case AllGrid[2]:
            TypeValue = 'IV'
            break;
        case AllGrid[3]:
            TypeValue = 'SO'
            break;
        case AllGrid[4]:
            TypeValue = 'IN'
            break;
        case AllGrid[5]:
            TypeValue = 'IG'
            break;
        case AllGrid[6]:
            TypeValue = 'DC'
            break;
        case AllGrid[7]:
            TypeValue = 'AB'
            break;
        case AllGrid[8]:
            TypeValue = 'SM'
            break;
        case AllGrid[9]:
            TypeValue = 'BP'
            break;
        default:
            TypeValue = 'MD'
            break;
    }
    return TypeValue;
}
function GetDoctSpecilization(docCode) {
    var specilization = '';

    var DocSpecilizationCode = $.grep(globalDoclst, function (element, value) {
        return (element.Value == docCode);
    })

    var Code = DocSpecilizationCode[0].Specialization
    var SpecilizationData = $.grep(specilizationlist, function (element, value) {
        return (element.Value == Code);
    })

    if (SpecilizationData.length > 0) {
        specilization = SpecilizationData[0].Text
    }
    return specilization;
}

function addButtonForMedi() {
    var grid = "'#JqGridMedication'"
    var selectorgrid = 'JqGridMedication'
    addToGrid(grid, selectorgrid);
}

function addButtonForNub() {
    var grid = "'#JqGridNebulization'"
    var selectorgrid = 'JqGridNebulization'
    addToGrid(grid, selectorgrid);
}


function addButtonForBloodProdt() {
    var grid = "'#JqGridBloodProduct'"
    var selectorgrid = 'JqGridBloodProduct'
    addToGrid(grid, selectorgrid);
}

function addButtonForAntibiotics() {
    var grid = "'#JqGridAntibiotics'"
    var selectorgrid = 'JqGridAntibiotics'
    addToGrid(grid, selectorgrid);
}

function addButtonSpecialInst() {
    var grid = "'#JqGridSpeciaInstructions'"
    var selectorgrid = 'JqGridSpeciaInstructions'
    addToGrid(grid, selectorgrid);

}

function addButtonStatOrder() {
    var grid = "'#JqGridSTATOrders'"
    var selectorgrid = 'JqGridSTATOrders'
    addToGrid(grid, selectorgrid);
}

function addButtInfusion() {
    var grid = "'#JqGridInfusion'"
    var selectorgrid = 'JqGridInfusion'
    addToGrid(grid, selectorgrid);
}

function addButtonInvestigation() {
    var grid = "'#JqGridInvestigation'"
    var selectorgrid = 'JqGridInvestigation'
    addToGrid(grid, selectorgrid);
}

function addButtonReferrals() {
    var grid = "'#JqGridReferrals'"
    var selectorgrid = 'JqGridReferrals'
    addToGrid(grid, selectorgrid);
}

function addToGrid(grid, selectorgrid) {
    var selGrid = "'" + selectorgrid + "'"
    var addButton = '<div class="ui-pg-div" style="cursor:pointer;padding-left:5px;" title="Add New Row" onclick="AddNewRowOn(' + grid + ',' + selGrid + ');"><span class="glyphicon glyphicon-plus"></span></div>'
    $('#jqgh_' + selectorgrid + '_rn').find('span').remove()
    $('#jqgh_' + selectorgrid + '_rn').append(addButton)

}


function addButtonJqGridStatOrdOnMedi() {
    var grid = "'#JqGridSTATOrdersOnMedication'"
    var selectorgrid = 'JqGridSTATOrdersOnMedication'
    addToGrid(grid, selectorgrid);
}

function AddNewRowOn(obj, selectorgrid) {
    var grid = $(obj);
    var rowdata = grid.jqGrid('getRowData');
    var rowdatas = "";
    var len = rowdata.length;

    var adddata = {
        TypeCode: GetTypeCode(selectorgrid),
    }
    var ids = grid.jqGrid('getDataIDs');
    var rowData = grid.jqGrid('getGridParam', 'data');              ///vishal 23rd Feb 2019
    for (var i = 1; i <= ids.length; i++) {
        grid.jqGrid("editCell", 0, 0, false);
    }
    var RowArr = new Array()
    var RowArr = grid.jqGrid('getDataIDs');
    if (RowArr.length > 0) {
        var MaxRwId = Math.max.apply(Math, RowArr);
        grid.jqGrid("addRowData", MaxRwId + 1, adddata);
        if (gact == "N")                                               ///vishal 23rd Feb 2019
        {
            AddDelButton(obj, MaxRwId + 1)
        }
    }
    else {
        grid.jqGrid("addRowData", len + 1, adddata);
        if (gact == "N")                                               ///vishal 23rd Feb 2019
        {
            AddDelButton(obj, len + 1)
        }
    }

    //grid.jqGrid("addRowData", len + 1, adddata);
    //if (gact == "N")                                               ///vishal 23rd Feb 2019
    //{
    //    AddDelButton(obj, len + 1)
    //}
    if (click == true && selectorgrid == 'JqGridAntibiotics')                     ///vishal 14th Nov
    {
        var len = $('#JqGridAntibiotics').jqGrid('getRowData').length;
        $('#JqGridAntibiotics').jqGrid('setSelection', len);
        click = false;
        $('#JqGridAntibiotics').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridMedication') {
        var len = $('#JqGridMedication').jqGrid('getRowData').length;
        $('#JqGridMedication').jqGrid('setSelection', len);
        click = false;
        $('#JqGridMedication').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridInfusion') {
        var len = $('#JqGridInfusion').jqGrid('getRowData').length;
        $('#JqGridInfusion').jqGrid('setSelection', len);
        click = false;
        $('#JqGridInfusion').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridSTATOrders') {
        var len = $('#JqGridSTATOrders').jqGrid('getRowData').length;
        $('#JqGridSTATOrders').jqGrid('setSelection', len);
        click = false;
        $('#JqGridSTATOrders').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridSTATOrdersOnMedication') {
        var len = $('#JqGridSTATOrdersOnMedication').jqGrid('getRowData').length;
        $('#JqGridSTATOrdersOnMedication').jqGrid('setSelection', len);
        click = false;
        $('#JqGridSTATOrdersOnMedication').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridSpeciaInstructions') {
        var len = $('#JqGridSpeciaInstructions').jqGrid('getRowData').length;
        $('#JqGridSpeciaInstructions').jqGrid('setSelection', len);
        click = false;
        $('#JqGridSpeciaInstructions').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridBloodProduct') {
        var len = $('#JqGridBloodProduct').jqGrid('getRowData').length;
        $('#JqGridBloodProduct').jqGrid('setSelection', len);
        click = false;
        $('#JqGridBloodProduct').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridInvestigation') {
        var len = $('#JqGridInvestigation').jqGrid('getRowData').length;
        $('#JqGridInvestigation').jqGrid('setSelection', len);
        click = false;
        $('#JqGridInvestigation').resetSelection();
    }
    else if (click == true && selectorgrid == 'JqGridReferrals') {
        var len = $('#JqGridReferrals').jqGrid('getRowData').length;
        $('#JqGridReferrals').jqGrid('setSelection', len);
        click = false;
        $('#JqGridReferrals').resetSelection();
    }
}
function AddDelButton(obj, len) {
    var grid = $(obj);
    var iCol = getColumnIndexByName(grid, 'action');
    if (iCol == 1) {
        var M = grid.find(">tbody>tr.jqgrow").filter(":last");
        $(M).find("td:nth-child(" + (iCol + 1) + ")")
            .each(function () {
                $("<div>", {
                    title: "Delete",
                    mouseover: function () {
                        $(this).addClass('ui-state-hover');
                    },
                    mouseout: function () {
                        $(this).removeClass('ui-state-hover');
                    },
                    click: function (e) {
                        var ids = grid.jqGrid('getDataIDs');
                        var rowData = grid.jqGrid('getRowData');              ///vishal 23rd Feb 2019
                        for (var i = 0; i <= ids.length - 1; i++) {
                            grid.jqGrid("editCell", 0, 0, false);
                        }
                        l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                        grid.delRowData(l_orowId);
                    }
                }
                ).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
                    .addClass("ui-pg-div ui-inline-custom")
                    .append('<span class="ui-icon ui-icon-trash"></span>')
                    .prependTo($(this).children("div"));

            });
    }
}
function GetTodaysDate() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    var today = dd + '/' + mm + '/' + yyyy;
    //var today = yyyy + '' + mm + '' + dd;
    return today;
}

function GetTimewithAMPM() {
    var today = new Date();
    var hours = today.getHours();
    var minutes = today.getMinutes();
    var ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0' + minutes : minutes;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    return strTime;
}
function GetDBMaxSEQNO() {
    MaxSEQ = "";
    var strIpNo = '' + $.session.get('ICUPatIPNO');
    var dataContainer = {
        IPNO: "" + strIpNo,
    }
    $.ajax({
        url: '../ICUMob/GetMaxSEQNO',
        data: dataContainer,
        type: 'get',
        async: false,
        success: function (Response) {
            if (Response != "UNSUCESSFULL") {
                MaxSEQ = JSON.parse(Response);
            }
            else {

            }
        }
    });
}
function AddBlankRowToTable(grid, selector, totalRow) {
    for (var i = 1; i <= totalRow; i++) {
        AddNewRowOn(grid, selector);
    }
}
function AddCancelBtn(obj, len) {
    var grid = $(obj);
    var iCol = getColumnIndexByName(grid, 'action');
    if (iCol == 1) {
        var M = grid.find('tr#' + (len + 1));
        $(M).find("td:nth-child(" + (iCol + 1) + ")")
            .each(function () {
                $("<div>", {
                    title: "Cancel",
                    mouseover: function () {
                        $(this).addClass('ui-state-hover');
                    },
                    mouseout: function () {
                        $(this).removeClass('ui-state-hover');
                    },
                    click: function (e) {
                        var ids = grid.jqGrid('getDataIDs');
                        var rowData = grid.jqGrid('getRowData');              ///vishal 23rd Feb 2019
                        for (var i = 0; i <= ids.length - 1; i++) {
                            grid.jqGrid("editCell", 0, 0, false);
                        }
                        l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                        RowObj = $(e.target).closest("tr.jqgrow");
                        var rowData = grid.jqGrid('getRowData', l_orowId);
                        if (rowData.TypeCode == "DC") {
                            custom_alertReferral("Are you sure you want to cancel this Referral Doctor?", "Cancellation", rowData, grid, l_orowId, RowObj);
                        }
                        else if (rowData.TypeCode == "IG")  //vishal 14th nov
                        {
                            custom_alertInvstgprint("Are you sure you want to cancel this Investigation?", "Cancellation", rowData, grid, l_orowId, RowObj);
                        }
                        else {
                            custom_alertprint("Are you sure you want to cancel this record?", "Medicine Cancellation", rowData, grid, l_orowId, RowObj);
                        }
                    }
                }).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
                    .addClass("ui-pg-div ui-inline-custom")
                    .append('<span class="ui-icon ui-icon-cancel"></span>')
                    .prependTo($(this).children("div"));

            });
    }
}
function AddBlankRow(grid, InitialCount, ResultCount, selector) {
    var len = Number(ResultCount) - Number(InitialCount);
    var rowNumber = Number(InitialCount) + 1;
    for (var i = 1; i <= len; i++) {
        AddNewRowOn(grid, selector);
        rowNumber++;
    }
}
function FillDetailData(result) {
    if (result.jsonDetailsData.length > 0) {
        if (IsRetrivedataByDate && IsPastDate) {
            IsOnlyDisplay = true;
            IsrolloverData = 'Y'
            $('#btnPrint').addClass('hide')
            fillheaderDetails();
            $('#lblModeIndicator').text("View");
            $('#getloginInfo').removeClass('hide');
            TranNo = result.jsonDetailsData[0].TRANNO;
            $('#txtRollverDate').parent().hide();

        }
        else if (IsRetrivedataByDate) {
            if (checkFutureDate(result.jsonDetailsData[0].TRANDATE)) {
                IsrolloverData = 'N'
                EnabledField();
                $('#btnSave').val('Update').removeClass('Visibility');
                gact = 'E';
                $('#getloginInfo').removeClass('hide')
                $('#lblModeIndicator').text("Update");
                $('#txtRollverDate').parent().hide();
                TranctionId = result.jsonDetailsData[0].TRANNO;
                TranNo = result.jsonDetailsData[0].TRANNO;
            }

            else {
                IsrolloverData = 'Y'
                TranctionId = result.jsonDetailsData[0].TRANNO;
                TranNo = result.jsonDetailsData[0].TRANNO;
                trDate = $('#txtTransDate').val();
                if (result.jsonDetailsData[0].TRANDATE == trDate) {
                    gact = 'E';
                    $('#btnSave').val('Update').removeClass('Visibility');
                    IsOnlyDisplay = false;
                    IsrolloverData = 'N'
                    $('#txtRollverDate').parent().hide();
                }
                else {
                    gact = 'N';
                    IsOnlyDisplay = false;
                }


            }

            IsOnlyDisplay = false;
            fillheaderDetails();
        }

        else {
            EditRecord();
            IsrolloverData = 'N'
            IsOnlyDisplay = false;
            //fillheaderDetails();
        }
    }

    else {

        ClearcontrolData();
    }
}

function SetServerTime() {
    var ssDate = (ServerTime).split(':')
    var hours = ssDate[0];
    var minutes = ssDate[1];
    var ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0' + minutes : minutes;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    return strTime;
}
function custom_alertprint(output_msg, title_msg, RowData, grid, rowId, rowObject) {
    if (!title_msg)
        title_msg = 'Confirmation';
    if (!output_msg)
        output_msg = 'No Message to Display.';
    $("#lblCustomAlert").text(output_msg);
    $("#Customalert").dialog({
        title: title_msg,
        resizable: false,
        modal: true,
        buttons: {
            "Yes": function () {
                if (gact == 'E') {
                    var CNFFlag = CancelledRequest($('#tractiondropdown').val().trim(), RowData.SQNumber, RowData.TypeCode);
                    if (CNFFlag) {
                        grid.jqGrid('setCell', rowId, 'STATUS', "C");
                        grid.jqGrid('setCell', rowId, 'OmittedBy', userid);
                        grid.jqGrid('setCell', rowId, 'OmittedDate', GetTodaysDate());
                        grid.jqGrid('setCell', rowId, 'OmittedTime', GetTimewithAMPM());
                        $(rowObject).addClass('avoid-clicks');
                        grid.jqGrid('setCell', rowId, 'Omit', '', 'avoid-clicks');
                        $(rowObject).removeClass('selected-row');
                        $(rowObject).removeClass('ui-state-hover');

                        $(rowObject).addClass('cancellation');


                        $(rowObject).find('td:nth-child(2) div.ui-inline-custom').hide()
                        $(this).dialog("close");
                    }
                    else {
                        $(this).dialog("close");
                        MsgDia("Cancellation Process Failed", "Error Information");
                    }
                }
            },
            "No": function () {
                $(this).dialog("close");
            },
        }
    });
}
function custom_alertReferral(output_msg, title_msg, RowData, grid, rowId, rowObject) {
    if (!title_msg)
        title_msg = 'Confirmation';
    if (!output_msg)
        output_msg = 'No Message to Display.';
    $("#lblCustomAlert").text(output_msg);
    $("#Customalert").dialog({
        title: title_msg,
        resizable: false,
        modal: true,
        buttons: {
            "Yes": function () {
                if (gact == 'E') {
                    var CNFFlag = CancelledRequest(TranNo, RowData.SQNumber, "DC");
                    if (CNFFlag) {
                        grid.jqGrid('setCell', rowId, 'STATUS', "C");
                        grid.jqGrid('setCell', rowId, 'CancelBY', userid);
                        grid.jqGrid('setCell', rowId, 'CancelDT', GetTodaysDate());
                        grid.jqGrid('setCell', rowId, 'CancelTM', GetTimewithAMPM());
                        $(rowObject).addClass('avoid-clicks');                                //vishal 6th Feb 2019                          
                        $(rowObject).css('background', '#f9a886');
                        $(rowObject).find('td:nth-child(2) div.ui-inline-custom').hide()
                        $(this).dialog("close");
                    }
                    else {
                        $(this).dialog("close");
                        MsgDia("Cancellation Process Failed", "Error Information");
                    }
                }
            },
            "No": function () {
                $(this).dialog("close");
            },
        }
    });
}
function custom_alertInvstgprint(output_msg, title_msg, RowData, grid, rowId, rowObject) {   //vishal 14th Nov
    if (!title_msg)
        title_msg = 'Confirmation';
    if (!output_msg)
        output_msg = 'No Message to Display.';
    $("#lblCustomAlert").text(output_msg);
    $("#Customalert").dialog({
        title: title_msg,
        resizable: false,
        modal: true,
        buttons: {
            "Yes": function () {
                if (gact == 'E') {
                    var CNFFlag = CancelledRequest(TranNo, RowData.SQNumber, "TS");
                    if (CNFFlag) {
                        grid.jqGrid('setCell', rowId, 'STATUS', "C");
                        grid.jqGrid('setCell', rowId, 'CancelBY', UserId);                      //vishal 6th Feb 2019
                        grid.jqGrid('setCell', rowId, 'CancelDT', GetTodaysDate());
                        grid.jqGrid('setCell', rowId, 'CancelTM', GetTimewithAMPM());
                        //grid.jqGrid('setCell', rowId, 'OmittedBy', UserId);
                        //grid.jqGrid('setCell', rowId, 'OmittedDate', GetTodaysDate());
                        //grid.jqGrid('setCell', rowId, 'OmittedTime', GetTimewithAMPM());
                        //grid.jqGrid('setCell', rowId, 'Omit', '', 'avoid-clicks');
                        $(rowObject).addClass('avoid-clicks');                                    //vishal 6th Feb 2019     
                        //$(rowObject).addClass('cancellation');
                        $(rowObject).css('background', '#f9a886');
                        $(rowObject).find('td:nth-child(2) div.ui-inline-custom').hide()
                        $(this).dialog("close");
                    }
                    else {
                        $(this).dialog("close");
                        MsgDia("Cancellation Process Failed", "Error Information");
                    }
                }
            },
            "No": function () {
                $(this).dialog("close");
            },
        }
    });
}
function CancelledRequest(strTranNo, strSeqNo, strType) {
    var flag = false;
    var dataContainer = {
        TBLTYPE: strType,
        TRANNO: $('#tractiondropdown').val().trim(),
        SEQNO: strSeqNo,
        CANTIME: SetServerTime()
    }
    $.ajax({
        url: '../ICUMob/ProcessCancellation',
        data: dataContainer,
        type: 'get',
        async: false,
        success: function (Response) {
            if (Response.toUpperCase().indexOf('SUCCESSFUL') >= 0) {
                flag = true;
                MsgDia("Cancellation Successfull", "Information");
            }
            else {
                flag = false;
            }
        }
    });
    return flag;
}
function UpdateMaxSEQNOArray(tblType, SEQNO) {
    if (MaxSEQ.hasOwnProperty("Table")) {
        $.map(MaxSEQ.Table, function (element, Index) {
            if (element.TBLTYPE == tblType) {
                element.Column1 = SEQNO;
            }
        })
    }
}
function AddDataToMaxArray(TblType, SEQNO) {
    if (MaxSEQ.hasOwnProperty("Table")) {
        MaxSEQ.Table.push({ "TBLTYPE": TblType, "Column1": SEQNO })
    }
    else if (MaxSEQ.length >= 0) {
        var Table = [];
        Table.push({
            "TBLTYPE": TblType, "Column1": SEQNO
        })
        var t = { Table: Table };
        MaxSEQ = t;
    }
}

function SaveForAllShortCutMenusFromIcu(e) {

    var page = window.location.href;
    if (page.indexOf("IVsuplement") != -1)
        SaveIVsuplement("Y");
    //else if (page.indexOf("Vitals") != -1) {
    //    if (!SaveVitals("Y")) {
    //        e.preventDefault();
    //    }
    //}
    else if (page.indexOf("IPInfusion") != -1)
        SaveAllIPInfusion("Y");
    else if (page.indexOf("IPInvestigation") != -1)
        SaveInvestigations("Y");
    else if (page.indexOf("IPReferrals") != -1)
        SaveIPReferrals("Y");
    //else if (page.indexOf("Advice") != -1)//commented by vijeta on 19th oct 2018
    //    SaveMedicineResequence("Y");
    else if (page.indexOf("IPMedication") != -1)   //by vijeta on 12th march 19
    {
        if (!SaveAllMedicines("Y")) {
            e.preventDefault();
        }
    }
    //else if (page.indexOf("RxNewSearch") != -1) {
    //    if (!SaveAllMedicines("Y")) {
    //        e.preventDefault();
    //    }
    //}
    else if (page.indexOf("NonDrugOrder") != -1)
        SaveNonDrugOrder("Y");

    else if (page.indexOf("BloodProduct") != -1)
        SaveBloodProduct("Y");

}

//end...............