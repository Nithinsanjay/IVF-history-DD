var freeHandInvestigation = "";//vijeta 3/4/19
var flagCheckRowsCmplnt = false;//vijeta 26/4/19
var flagCheckRowsInvst = false;//vijeta 26/4/19
var DispAddPatient = false;

var FlagForSelPat = true;
var priorityTitle = "";
$(document.body).on('click', '#WaitingPats .patNameCls,#VisitedPats .patNameCls,#PACPendingPat .patNameCls', function (e) {
    if (FlagForSelPat == false) {
        FlagForSelPat = true;
        return false;
    }
    glbPatMRNo = e.currentTarget.children[0].id;
    flagCheckRowsInvst =
        e.currentTarget.children[1].style.color = "#3c8dbc"; // set color of selected patient to blue

    var name = e.currentTarget.children[1].innerText;
    var age = e.currentTarget.children[3].defaultValue;
    var gender = e.currentTarget.children[4].defaultValue;
    var mrNo = e.currentTarget.children[5].defaultValue;
    var tranNo = e.currentTarget.children[6].defaultValue;
    var strMobile = e.currentTarget.children[7].defaultValue;
    var dob = e.currentTarget.children[8].defaultValue;
    var onlpaystat = e.currentTarget.children[9].defaultValue;
    var PatEmail = e.currentTarget.children[10].defaultValue;

    var OutRefDrNM = e.currentTarget.children[11].defaultValue;
    var OutRefDrCpntact = e.currentTarget.children[12].defaultValue;
    //var ComCode = e.currentTarget.children[14].defaultValue;//added by priyanka on 08/10/2025
    //var CompName = e.currentTarget.children[15].defaultValue;//added by priyanka on 08/10/2025
    var ComCode = e.currentTarget.querySelector('#CompCode').value.trim();//added by priyanka on 08/10/2025
    var CompName = e.currentTarget.querySelector('#CompName').value.trim();//added by priyanka on 08/10/2025

    var strAge = "";
    var strGender = "";

    strAge = Number(age.split(":")[0]) > 0 ? Number(age.split(":")[0]) + " Yrs" : Number(age.split(":")[1]) > 0 ? Number(age.split(":")[1]) + " Months" : Number(age.split(":")[2]) + " Days"
    // strAge = (age.charAt(0) == "0") ? e.currentTarget.children[3].defaultValue.toString().substr(1, 2) + "Yrs" : e.currentTarget.children[3].defaultValue.toString().substr(0, 3) + "Yrs";
    strGender = (gender == "M") ? "Male" : "Female";

    sessionStorage.setItem('PatName', name);
    sessionStorage.setItem('PatAge', strAge);
    sessionStorage.setItem('PatGender', strGender);
    sessionStorage.setItem('PatMobile', strMobile);
    sessionStorage.setItem('PatAge2', age);

    sessionStorage.setItem('PatMRNO', mrNo);
    sessionStorage.setItem('PatTRANNO', tranNo);
    sessionStorage.setItem('PatDOB', dob);
    sessionStorage.setItem('onlpaySTAT', onlpaystat);
    sessionStorage.setItem('PatEmail', PatEmail);

    sessionStorage.setItem('OutRefDrNm', OutRefDrNM);
    sessionStorage.setItem('OutRefDrContact', OutRefDrCpntact);
    //added by priyanka on 08/10/2025
    sessionStorage.setItem('ComCode', ComCode);
    sessionStorage.setItem('CompName', CompName);
    //end

    if ($(this).is('#WaitingPats .patNameCls')) {
        sessionStorage.setItem('PatCompleted', "N");
        sessionStorage.setItem('SHOWNOTES', "Y");
    } else if ($(this).is('#VisitedPats .patNameCls')) {
        sessionStorage.setItem('PatCompleted', "Y");
    } else if ($(this).is('#PACPendingPat .patNameCls')) {
        sessionStorage.setItem('PatCompleted', "W");
    }
    if (e.currentTarget.children[13] != undefined) {
        var strToken = e.currentTarget.children[13].defaultValue;
        sessionStorage.setItem('TokenNo', strToken);
    }
    sessionStorage.setItem('ConsltnNo', tranNo);

    SetPatientDtl();

    if (window.location.href.includes("PAC"))
        window.location.href = '../DoctorDesk/PAC?PatMRNO=' + mrNo + '&PatTRANNO=' + tranNo;
    else
        window.location.href = 'PatientEntry';

    //var page = window.location.href;
    //if (page.indexOf("PatientEntry") == -1) {
    //    window.location.href = 'PatientEntry';
    //}
    //else {
    //    var urls = "../Account/GetDctrClinic";
    //    AddClinics(urls);
    //    Patpresc($.session.get('PatCompleted'));
    //    GetPrevoisSptReports();
    //    GetPrevoisAllergies();
    //    GetAttachments($.session.get('PatMRNO'));
    //    GetPatNotes($.session.get('PatTRANNO'),sessionStorage.getItem('PatMRNO'));
    //    GetAllCounts();
    //}
    //}

    sessionStorage.setItem('PatSelected', "Appointed");//added on 22nd nov 2018
});
$(document.body).on('click', '#tblCmplts tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {

        var selRows = $('#tblCmplts > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tblCmplts tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tblCmplts > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }

        $(this).children('td').children('a').show();

        //
        // selected rows moved to top  
        Sortable.create(
            $('#tblsort')[0], {
            animation: 150,
            scroll: true,
            handle: '.clickable-row',
        })


        //End
        // selected rows moved to top  
        //sessionStorage.setItem($(this)[0].id , 'Y');
    }
    else {
        $(this).children('td').children('a').hide();
        var className = $(this).attr('class');
        if (className.length > 0) {
            var ClassId = className.substr(className.length - 4).trim();
            var advicedayNum = (ClassId).replace(/[^0-9]+/ig, "");
            var RowPos = $('.Tr' + (advicedayNum - 1).toString());
            RowPos.next().after(this);
        }
        //sessionStorage.setItem($(this)[0].id, 'N');
    }


    var rows = $('#tblCmplts tbody  tr:not(.active)').get();


    $.each(rows, function (index, row) {
        $('#tblCmplts').children('tbody').append(row);
    });             //sorted unselected rows

    //vijeta 26/4/19
    $("#ComplaintInput").val("").trigger("keyup");
    if ($(this).hasClass('active') && !flagCheckRowsCmplnt) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        $(this).find('a.trigger1').trigger('click');

    }

    //added on 28th sep 2018
});

//$(document).ready(function (e) {

//    $('#DivPatGrid').on('hidden.bs.collapse', toggleIconsofDivTab);
//    $('#DivPatGrid').on('shown.bs.collapse', toggleIconsofDivTab);
//});


function toggleIconsofDivTab(e) {
    $(e.target)
        .prev('.btn-group-justified')
        .find(".moreless")
        .toggleClass('fa-plus fa-minus');
    $(document).find("[href='#" + $(e.target).attr('id') + "']")
}


function AddClinics(urls, flag) {
    if (typeof flag === "undefined" || flag === null) {
        flag = "N";
    }
    if (($(window).width() >= 996) || ($(window).width() < 996 && flag == "Y")) {                                            //screen width size comparion

        $.ajax({
            type: "POST",
            url: urls,
            data: {},
            async: false,
            success: function (result) {
                if (result.length > 0) {
                    $("#btnsDiv").empty();
                    $.each(result, function (index, value) {
                        var $newDiv = $('<div>');
                        $newDiv.addClass("btn-group").css("width", "100%");

                        var test = $('<button/>',
                            {
                                text: result[index].Text,
                                id: result[index].Value,
                                style: 'background-color:transparent;margin-right: 2px;color: #1c3e5c;font-weight:bold;border: 1px solid transparent;font-size: 10px; white-space: normal;border-bottom:solid #f59319 !important;width: 100%; ',
                                class: 'btn btn-primary',
                                click: function () {
                                    SearchFunction(result[index].Value);
                                    sessionStorage.setItem('ClinicCode', result[index].Value);
                                    sessionStorage.setItem("ClinicName", result[index].Text);
                                    btnclk(this);
                                }
                            });

                        $newDiv.append(test);
                        $("#btnsDiv").append($newDiv);
                        $("#btnsDiv").css({ "margin-top": "-10px" });
                        //$("#btnsDiv").append(test);
                        btnID = result[index].Value;
                    });
                }
                else {
                    $('#DivPatGrid').empty();
                    var $NoPatientsDiv = $('<div>', { style: ' text-align: center;font-size:14px;background-color: #d2d6de;margin-top:19px;' });
                    var $lbl = $('<label>', { style: 'margin-top: 2px;' }).html('No Patients');
                    $NoPatientsDiv.append($lbl);
                    $('#DivPatGrid').append($NoPatientsDiv);
                }
                // $('#btnsDiv').css("background", "#378000");
                //});
            },
            complete: function (jqXHR, status) {
                if (status == "success") {

                    if (jqXHR.responseJSON.length > 0) {

                        var clncCode = sessionStorage.getItem('ClinicCode');
                        if (clncCode == null || clncCode == "")
                            $("#" + jqXHR.responseJSON[0].Value).trigger('click');
                        else
                            $("#" + clncCode).trigger('click');
                    }
                }

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.messager.alert("Error", errorThrown);
            }
        });
    }
}


function SearchFunction(clinicCode, SrchByDoctYN, CustomeDate) {
    //$('#grid').clearGridData();
    //priyanka 14/11/2025
    var VisitTypeCD = "";
    var VisitType = "";
    var RRYN = "";
    var ApmntNo = "";
    var ConsulDate = "";
    var Prioritype = "";
    var VisitTypeColor = "";
    if ($.session.get('SrchByDoctYN') != undefined)
        SrchByDoctYN = sessionStorage.getItem('SrchByDoctYN');

    if ($("#rbtnYesterday").length > 0 && $("#rbtnYesterday")[0].checked == true)
        dayType = "Y";
    else if ($("#rbtnDayBefYest").length > 0 && $("#rbtnDayBefYest")[0].checked == true)
        dayType = "B";
    else if ($("#rbtnDayCustom").length > 0 && $("#rbtnDayCustom")[0].checked == true)
        dayType = "D"
    else
        dayType = "T";

    var url = "../DoctorDesk/GetPatientList";
    //HoldOn.open();

    var FormType = "";
    if (window.location.href.includes("PAC")) {
        FormType = "PAC";
    }


    $.ajax({
        url: url,
        type: 'post',
        dataType: 'json',
        data: { strClinicCode: clinicCode, strSrchByDoctYN: SrchByDoctYN, DateType: dayType, CustomeDate: CustomeDate, Type: FormType },

        success: function (result) {
            var $newDiv1 = $('<div>');
            $newDiv1.attr("id", "WaitingPats");
            $newDiv1.attr("name", "WaitingPats");
            $newDiv1.attr("class", "collapse in indent");
            var $newul1 = $('<ul>', { style: 'list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:20px;letter-spacing: 0.5px;color:#515151' });
            $newul1.attr("id", "WaitingPatsdata");

            var $newDiv2 = $('<div>');
            $newDiv2.attr("id", "VisitedPats");
            $newDiv2.attr("name", "VisitedPats");
            $newDiv2.attr("class", "collapse in indent");
            var $newul2 = $('<ul>', { style: ' list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:24px;;lettter-spacing:1px' });
            $newul2.attr("id", "VisitedPatsdata");

            var $newDiv3 = $('<div>');
            $newDiv3.attr("id", "completedPat");
            $newDiv3.attr("name", "completedPat");
            $newDiv3.attr("class", "collapse in indent");

            var $newDiv4 = $('<div>');
            $newDiv4.attr("id", "PACPendingPat");
            $newDiv4.attr("name", "PACPendingPat");
            $newDiv4.attr("class", "collapse in indent");
            var $newul4 = $('<ul>', { style: ' list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:24px;;lettter-spacing:1px' });
            $newul4.attr("id", "PACPendingPatsdata");

            var options1 = "";
            var options2 = "";
            var options4 = "";

            var waitingCount = 0;
            var completedCount = 0;
            var waitingApprovelCount = 0;
            if (result.Result != "Something Went Wrong.") {
                $.each(result.Result, function (i, item) {
                    var patName = item.PatName;
                    var ApptTm = item.APPTTM;
                    var mrNo = item.MRNO;
                    var consNo = item.CONSNO;
                    var timeDiff = item.DIFFTM;
                    var age = item.Age;
                    var dob = item.DOB;
                    var gender = item.Gender;
                    var compltdYn = item.CompletedYN;

                    var ConsDate1 = item.ConsDate.split("/");
                    var ConsDate = ConsDate1[0] + "/" + ConsDate1[1];
                    ConsulDate = item.ConsDate.toString().trim();//priyanka 14/11/2025
                    var tranNo = (item.TRANNO).toString().trim();

                    var chkSign = Math.sign(timeDiff);
                    var onlpaystat = (item.OnlyPayStat).toString().trim();
                    var PatEmail = (item.PatEmail).toString().trim();
                    var applyColor = "none";
                    var coloronlpay = "none";

                    var OutRefDoct = item.OutRefDrName;

                    var OutRefDoctContact = item.OutRefDrContact;
                    var TokenNo = item.CONTOKNO;
                    //added by priyanka on 08/10/2025
                    var CompCode = item.ComCode;
                    var CompName = item.CompName;
                    if (chkSign == 1) {
                        if (timeDiff > 30) {
                            applyColor = "red";
                        }
                        else
                            applyColor = "#e49f21;";
                    }
                    else if (chkSign == -1) {
                        applyColor = "green";
                    }
                    else if (chkSign == NaN) {
                    }

                    //Priyanka 16/11/2025
                    if (FormType != "PAC" || FormType === "") {
                        //priyanka 14/11/2025
                        VisitTypeCD = item.VisitType;
                        RRYN = item.ReviewRYN;
                        ApmntNo = item.Appmntno;
                        Prioritype = item.PriorityType;
                        priorityTitle = getPriorityTitle(Prioritype);

                        //Priyanka 14/11/2025
                        if (VisitTypeCD == "NW" && RRYN == "N") {
                            VisitType = "<u>NW</u>"
                        }
                        else if (VisitTypeCD == "NW" && RRYN == "Y") {
                            VisitType = "<u>RR</u>"
                        }
                        else if (VisitTypeCD == "FU" && RRYN == "N") {
                            VisitType = "<u>FU</u>"
                        }
                        else if (VisitTypeCD == "FU" && RRYN == "Y") {
                            VisitType = "<u>RR</u>"
                        }
                        else if ((VisitTypeCD != "NW" && VisitTypeCD != "FU") && RRYN == "N") {
                            VisitType = "";
                        }
                        else if ((VisitTypeCD != "NW" && VisitTypeCD != "FU") && RRYN == "Y") {
                            VisitType = "<u>RR</u>";
                        }
                        //end


                        if (ApmntNo === "" || ApmntNo === null) {
                            VisitTypeColor = "#2bb582";
                        }
                        else {
                            VisitTypeColor = "#3aa4e3";
                        }
                    }
                    if (onlpaystat == "Y") {
                        coloronlpay = "border: 2px solid #f3d106;background: #75dec1;border-bottom-left-radius: 15px; border-top-right-radius: 15px;";
                    }
                    if (compltdYn == "N" || compltdYn == " ") {
                        waitingCount++;

                        if (FormType === "PAC") {
                            options1 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' onClick='CallPat(\"PatName" + item.CONSNO + "\",\"M\")'><label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "-" + ConsDate + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='TokenNo' value='" + TokenNo + "' /><input type=hidden id='CompCode' value='" + CompCode + "' /> <input type=hidden id='CompName' value='" + CompName + "' /><input type=hidden id='ConsultDT' value='" + item.ConsDate + "' />";
                        }
                        else {
                            options1 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' onClick='CallPat(\"PatName" + item.CONSNO + "\",\"M\")'><label style='padding-left:2px;width:70px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + "<span style='color:" + VisitTypeColor + "'>" + VisitType + "</span> " + ApptTm + "<span title='" + getPriorityTitle(Prioritype) + "'>" + Prioritype + "</span>" + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='TokenNo' value='" + TokenNo + "' /><input type=hidden id='CompCode' value='" + CompCode + "' /> <input type=hidden id='CompName' value='" + CompName + "' /><input type=hidden id='ConsultDT' value='" + item.ConsDate + "' />";
                        }

                        //if (dayType == "T" && QMSCall != "")
                        //    options1 += "<label  title='Call Patient'><img style='width:20px; height:20px;' onClick='CallPat(\"PatName" + item.CONSNO + "\",\"M\")' class='lblImage1' src='../Images/notificationnew.png' /></label>";
                        if (dayType == "T" && QMSCall != "")
                            options1 += "<label  title='Call Patient'><img style='width:15px; height:15px;' class='lblImage1' src='../Images/notificationnew.png' /></label>";
                        options1 += "</li>"
                    }
                    else if (compltdYn == "A") {
                        waitingApprovelCount++;

                        if (FormType === "PAC") {
                            options4 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' onClick='CallPat(\"PatName" + item.CONSNO + "\",\"M\")'><label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "-" + ConsDate + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='TokenNo' value='" + TokenNo + "' /><input type=hidden id='CompCode' value='" + CompCode + "' /> <input type=hidden id='CompName' value='" + CompName + "' /><input type=hidden id='ConsultDT' value='" + item.ConsDate + "' />";
                        }
                        else {
                            options4 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' onClick='CallPat(\"PatName" + item.CONSNO + "\",\"M\")'><label style='padding-left:2px;width:70px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + "<span style='color:" + VisitTypeColor + "'>" + VisitType + "</span> " + ApptTm + "<span title='" + getPriorityTitle(Prioritype) + "'>" + Prioritype + "</span>" + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='TokenNo' value='" + TokenNo + "' /><input type=hidden id='CompCode' value='" + CompCode + "' /> <input type=hidden id='CompName' value='" + CompName + "' /><input type=hidden id='ConsultDT' value='" + item.ConsDate + "' />";
                        }
                        //if (dayType == "T" && QMSCall != "")
                        //    options4 += "<label  title='Call Patient'><img style='width:20px; height:20px;' onClick='CallPat(\"PatName" + item.CONSNO + "\",\"M\")' class='lblImage1' src='../Images/notificationnew.png' /></label>";
                        if (dayType == "T" && QMSCall != "")
                            options4 += "<label  title='Call Patient'><img style='width:15px; height:15px;' class='lblImage1' src='../Images/notificationnew.png' /></label>";
                        options4 += "</li>"
                    }
                    else {
                        applyColor = "black";
                        completedCount++;
                        if (FormType === "PAC") {
                            options2 += "<li class='patNameCls' id='PatName" + item.CONSNO + "'><label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "-" + ConsDate + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'> " + patName + "</label><input type=hidden  id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='CompCode' value='" + CompCode + "' /> <input type=hidden id='CompName' value='" + CompName + "' /><input type=hidden id='ConsultDT' value='" + item.ConsDate + "' /></li>";
                        }
                        else {
                            options2 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' onClick='CallPat(\"PatName" + item.CONSNO + "\",\"M\")'><label style='padding-left:2px;width:70px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + "<span style='color:" + VisitTypeColor + "'>" + VisitType + "</span> " + ApptTm + "<span title='" + getPriorityTitle(Prioritype) + "'>" + Prioritype + "</span>" + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='TokenNo' value='" + TokenNo + "' /><input type=hidden id='CompCode' value='" + CompCode + "' /> <input type=hidden id='CompName' value='" + CompName + "' /><input type=hidden id='ConsultDT' value='" + item.ConsDate + "' /></li>";
                        }
                    }
                });
            }
            //Added By Priyanka
            if (FormType != "PAC" || FormType === "") {
                var $newdateandcoldindc = $('<div>').css({
                    'display': 'flex',
                    'justify-content': 'space-between',
                    'align-items': 'center',
                    'margin-top': '5px'
                });
                var $aspancolindc = $('<label>')
                    .text(ConsulDate)
                    .css({
                        'color': '#99460b',
                        'font-size': '13px',
                        'text-decoration': 'none',
                        'margin-left': '-38px',
                        'margin-bottom': '0px',
                    });
                $newdateandcoldindc.append($aspancolindc);
                var $parentDiv = $('<div>')
                    .css({
                        'display': 'flex',
                        'align-items': 'center',
                        'margin-right': '-40px'
                    });
                var divcolindc = $('<div>')
                    .css({
                        'display': 'inline-block',
                        'min-width': '13px',
                        'min-height': '13px',
                        'background-color': '#3aa4e3',
                        'vertical-align': 'middle'
                    });
                var $colindcator = $('<label>')
                    .attr({
                        'data-target': '#WaitingPatsDtColIndc',
                        'data-parent': '#DivPatGrid'
                    })
                    .css({
                        'color': '#99460b',
                        'font-size': '13px',
                        'margin-left': '5px',
                        'vertical-align': 'middle',
                        'margin-bottom': '0px',
                    })
                    .text("Appointment");
                $parentDiv.append(divcolindc);
                $parentDiv.append($colindcator);
                $newdateandcoldindc.append($parentDiv);
            }
            //End By Priyanka


            var $newHeadngWait = $('<a>');
            $newHeadngWait.attr("data-toggle", "collapse");
            $newHeadngWait.attr("data-target", "#WaitingPats");
            $newHeadngWait.attr("style", "border: 1px solid #d8acc6;color: #8e0e5a;text-align:left;font-size:13px;border-radius: 2px; background-color: #f9ddedcc; text-decoration: none;margin-left:4px width:99%");
            $newHeadngWait.attr("class", "btn-group btn-group-justified");
            $newHeadngWait.attr("data-parent", "#DivPatGrid");



            var $aspan = $('<i class="moreless fa fa-minus"></i>');
            $newHeadngWait.append($aspan);
            var WaitLbl = FormType == "PAC" ? "New" : "Waiting";

            if (waitingCount == 0)
                $newHeadngWait.append(WaitLbl);
            else
                $newHeadngWait.append(WaitLbl + ' (' + waitingCount + ')');

            $newul1.append(options1);
            $newDiv1.append($newul1);

            $newul2.append(options2);
            $newDiv2.append($newul2);

            $newul4.append(options4);
            $newDiv4.append($newul4);

            var $newHeadng = $('<a>');
            $newHeadng.attr("data-toggle", "collapse");
            $newHeadng.attr("data-target", "#VisitedPats");
            $newHeadng.attr("style", "border: 1px solid #a9dca9;color: #118011;text-align: left;border-radius: 2px; font-size:13px;  background-color: #d6f7d5cf;  text-decoration: none;margin-left:1px; width:99%");//
            $newHeadng.attr("class", "btn-group btn-group-justified")
            $newHeadng.attr("data-parent", "#DivPatGrid");

            var $aspan1 = $('<i class="moreless fa fa-minus"></i>');
            $newHeadng.append($aspan1);

            var CompleteLbl = FormType == "PAC" ? "Approved" : "Completed";
            if (completedCount == 0)
                $newHeadng.append(CompleteLbl);
            else
                $newHeadng.append(CompleteLbl + ' (' + completedCount + ')');

            $newDiv3.append($newHeadng);

            var $newPACHeadng = $('<a>');
            $newPACHeadng.attr("data-toggle", "collapse");
            $newPACHeadng.attr("data-target", "#PACPendingPat");
            $newPACHeadng.attr("style", "border: 1px solid #cfcc6dcf;color: #636a00;text-align: left;border-radius: 2px; font-size:13px;  background-color: #fffdc4cf;  text-decoration: none;margin-left:1px; width:99%");//
            $newPACHeadng.attr("class", "btn-group btn-group-justified")
            $newPACHeadng.attr("data-parent", "#DivPatGrid");
            var $aspan1 = $('<i class="moreless fa fa-minus"></i>');
            $newPACHeadng.append($aspan1);

            if (waitingApprovelCount == 0)
                $newPACHeadng.append('Waiting For Approval');
            else
                $newPACHeadng.append('Waiting For Approval (' + waitingApprovelCount + ')');

            $('#DivPatGrid').empty();
            var $DivPatSearch;
            if ($('#divtabs').css('display') != 'none') {
                $DivPatSearch = "<div id='divBindPat' style='height:35px;text-align:center;margin-top:56px'>";
            }
            else {
                $DivPatSearch = "<div id='divBindPat' style='height:35px;text-align:center;margin-top:9px'>";
            }

            $DivPatSearch += "<div class='form-group has-feedback' id='divPatientSearch'>";
            $DivPatSearch += "<div  style='float:left;margin-top: -2px;padding-left: 3px;'  id='divChkAllPatLst'><input type='checkbox' style='display: none;' id='chkAllPatLst'  /><label class='lblImg' id='lblSelect' title='Show all patient' for='chkAllPatLst'><img class='lblImage' src='../Images/patient.png' /></label></div>";
            $DivPatSearch += "<input type='text' style='width:75%;margin-left:46px;' class='form-control' onkeyup='PatientSearch()' placeholder='Search MR, Name' id='InputSearchDiv' /><input type='text' style='height:0px;margin-left:5px;-webkit-text-fill-color:white;border:none'/><span class='fa fa-search fa-2x form-control-feedback' style='color:#3c8dbc;line-height:30px;right: 20%;' id='InputSearchDivIcon'>";

            if (DispAddPatient == true) {
                $DivPatSearch += "</span><div style='float:right;margin-top: -37px;padding-left: 3px;margin-right:5px;' id='divAddPat'><label  title='Add Patient'><img onClick='RedirectToAddPatient()' class='lblImage1' src='../Images/patient2.png' /></label></div></div>";
            }
            $('#DivPatGrid').append($DivPatSearch);
            $('#DivPatGrid').append($newdateandcoldindc);
            if (options1 != "") {
                //if (FormType === "PAC") {
                //    $('#DivPatGrid').append($newdateandcoldindc);//priyanka 14/11/2025
                //}

                $('#DivPatGrid').append($newHeadngWait);
                $('#DivPatGrid').append($newDiv1);
            }
            if (FormType == "PAC" && options4 != "") {
                $('#DivPatGrid').append($newPACHeadng);
                $('#DivPatGrid').append($newDiv4);
            }
            if (options2 != "") {
                $('#DivPatGrid').append($newHeadng);
                $('#DivPatGrid').append($newDiv2);

            }
            if (result.Result.length == 0) {
                var $NoPatientsDiv = $('<div>', { style: ' text-align: center;font-size:14px;background-color: #d2d6de;margin-top: 13px;' });
                var $lbl = $('<label>', { style: 'margin-top: 2px;' }).html('No Patients');
                $NoPatientsDiv.append($lbl);

                $('#DivPatGrid').append($NoPatientsDiv);
            }

            // Added by Dhananjay 20240828
            if (HideCheckPatInfoIcon == "N") {
                $('#divChkAllPatLst').css("display", "none");
                $('#InputSearchDiv').css({
                    'width': '77%',
                    'margin-left': '10px'
                })
                $('#InputSearchDivIcon').css({
                    'right': '23%'
                })
            }
            MedicalSurgicalFormRights(result.ClinicSpeciality);
        },
        complete: function () {
            var mrNo = sessionStorage.getItem('PatMRNO');
            var tranno = sessionStorage.getItem('PatTRANNO');
            if (tranno != null && mrNo != null) {
                $("li#PatName" + tranno).attr("style", "color:#3c8dbc;box-shadow:-5px 1px 7px 3px #636367;");
            }

            if ($.session.get('SrchByDoctYN') == "N") {
                $('.lblImage').click();
                $('#chkAllPatLst')[0].checked = true;
            }
            else {
                $('#chkAllPatLst')[0].checked = false;

            }

        },
        error: function (xhr, textStatus, errorThrown) {
            HoldOn.close();
        }

    });

}

$(document.body).on('click', '#chkAllPatLst', function (e) {
    if ($('#chkAllPatLst')[0].checked == true) {
        sessionStorage.setItem('SrchByDoctYN', 'N');
        SearchFunction($.session.get('ClinicCode'));
    }
    else {
        sessionStorage.setItem('SrchByDoctYN', 'Y');
        SearchFunction($.session.get('ClinicCode'));
    }
});

function btnclk(btn) {
    var classname = document.getElementsByClassName("btn btn-primary");
    for (var i = 0; i < classname.length; i++) {
        classname.item(i).style.backgroundColor = 'transparent';
        classname.item(i).style.borderBottomColor = 'transparent';
        classname.item(i).style.color = 'rgb(28, 62, 92)';
    }
    btn.style.backgroundColor = "transparent";
    btn.style.borderBottom = "solid";
    btn.style.borderBottomColor = "#3c8dbc";
    btn.style.outline = "0";
    btn.style.color = "rgb(222, 74, 4)";
    var parentDiv = btn.closest('.btn-group');
    if (parentDiv) {
        var container = document.getElementById('btnsDiv');
        container.prepend(parentDiv);
    }
}

$(document.body).on('click', '.trigger1,.trigger2', function (e) {
    e.stopPropagation();
    idOfDMY = $(this).attr("id");
    $("#trigger2").css({ top: '100px' });
    document.getElementById("layer-DMY").style.marginTop = "-10px";
    if (document.getElementById("layer-demo") != null)
        document.getElementById("layer-demo").style.marginTop = "-10px";
});

function Patpresc(PatCompletedYN) {
    if (typeof PatCompletedYN == 'undefined' || PatCompletedYN == null) { HoldOn.close(); }//
    var mrno = ($.session.get('PatMRNO'));
    var dCode = globalLoginDoctCode;
    if ($.session.get('PatMRNO') != null) {
        $.ajax({
            type: "POST",
            url: 'GetPatPresc',
            datatype: "json",
            data: { strMRNO: mrno },
            success: function (result) {

                strPrintData = [];
                if (result.length == 0) {
                    document.getElementById("prevpresc").style.display = "none";
                    $('#myCarousel').empty();
                }
                else {
                    $('#myCarousel').empty();
                    if ($(window).width() <= 576)
                        $('.slide').css('width', '100%');
                    else
                        $('.slide').css('width', '45%');

                    var tempData = "<div class='carousel-inner' style='margin-left: 20px'>" +
                        "<div class='item active'>" +
                        "<div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                    var inactive = "";
                    var drName = "";
                    for (var i = 0; i < result.length;) {
                        document.getElementById("prevpresc").style.display = "block";
                        var $this = $('#myCarousel');
                        if (i <= 2) {
                            //drName = "";
                            // drName = ((result[i].DOCTNAME) != "") ? "<label style='margin-left:-6px;'><b>(Dr. " + result[i].DOCTNAME + ")</b></label>" : "";
                            tempData = tempData + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer;width:40px;height:40px;' id='" + result[i].TRANNO + "'  onclick='GetBindingData(this)' class='img-responsive'/><label id='lbl" +
                                parseInt(i + 1) + "' style='margin-bottom:0px; ' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE + "</label><label style=''><b>(Dr. " + result[i].DOCTNAME + ")</b></label>";

                            if (PatCompletedYN == "N") {// && result[i].DOCTCODE == dCode
                                tempData = tempData + "<a id='hdn" + parseInt(i + 1) +
                                    "' style='cursor:pointer' title='" + result[i].TRANNO + "' onclick='GetCopy(this)'>Copy</a>"
                            }
                            tempData = tempData + "</div>";
                            i++;
                        }
                        else {
                            //  drName = "";
                            drName = ((result[i].DOCTNAME) != "") ? "<label style=''><b>(Dr. " + result[i].DOCTNAME + ")</b></label>" : "";
                            inactive += "<div class='item'><div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                            for (j = 0; j < 4; j++) {
                                if (i < result.length) {
                                    inactive = inactive + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer;width:40px;height:40px;' id='" + result[i].TRANNO + "' onclick='GetBindingData(this)' class='img-responsive'/><label id='lbl" +
                                        parseInt(i + 1) + "' style='margin-bottom:0px; ' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE +
                                        "</label><label style=''><b>(Dr. " + result[i].DOCTNAME + ")</b></label>";

                                    if (PatCompletedYN == "N") { //&& result[i].DOCTCODE == dCode
                                        inactive = inactive + "<a id='hdn" + parseInt(i + 1) +
                                            "' style='cursor:pointer' title='" + result[i].TRANNO + "' onclick='GetCopy(this)'>Copy</a>";
                                    }

                                    inactive = inactive + "</div>";
                                    i++;
                                }
                            }
                            inactive = inactive + "</div></div>";
                        }
                    }
                    tempData = tempData + "</div></div>" + inactive + "</div><a class='left carousel-control' href='#myCarousel' data-slide='prev' style='width: 15px;'>" +
                        "<i class='fa fa-angle-left custom' style='margin-left: -15px;color:#3c8dbc;'></i></a><a class='right carousel-control' href='#myCarousel' data-slide='next' style='width: 15px;'>" +
                        "<i class='fa fa-angle-right custom' style='margin-left: -15px;color:#3c8dbc;'></i></a>";
                    strPrintData.push(tempData);
                    document.getElementById("myCarousel").innerHTML += strPrintData[0];

                    var itemCount = $("#myCarousel div").length;
                    if (itemCount <= 7) {
                        $('#myCarousel').children('.right.carousel-control, .left.carousel-control').hide();
                    }
                    else {
                        $('#myCarousel').children('.right.carousel-control, .left.carousel-control').show();
                    }
                }
                //});//
            },
            complete: function () {
                HoldOn.close();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                HoldOn.close();

            },
        });

    }

}

function GetAttachments(MRNO) {
    if (MRNO != null) {
        $.ajax({
            type: "POST",
            url: 'GetAttachment',
            datatype: "json",
            data: { MRNO: MRNO },
            async: true,
            success: function (result) {

                strPrintData = [];
                if (result.length == 0) {
                    document.getElementById("attachments").style.display = "none";
                    $('#newCarousel').empty();
                }
                else {
                    $('#newCarousel').empty();
                    if ($(window).width() <= 576)
                        $('.slide').css('width', '100%');
                    else
                        $('.slide').css('width', '45%');
                    var tempData = "<div class='carousel-inner' style='margin-left: 20px'>" +
                        "<div class='item active'>" +
                        "<div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                    var inactive = "";
                    for (var i = 0; i < result.length;) {
                        document.getElementById("attachments").style.display = "block";
                        var $this = $('#newCarousel');
                        if (i <= 2) {
                            tempData = tempData + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4'  style='display: flex;flex-direction: column;align-items: flex-start;'  onclick='openNewWin(this)' ><img src='../Images/prepDoc.png' style='cursor:pointer' class='img-responsive'/><label id='lbl" +
                                parseInt(i + 1) + "' style='margin-bottom:0px; word-wrap: break-word;' title='" + result[i] + "'>" + result[i] + "</label>";

                            tempData = tempData + "</div>";
                            i++;
                        }
                        else {
                            inactive += "<div class='item'><div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                            for (j = 0; j < 4; j++) {
                                if (i < result.length) {
                                    inactive = inactive + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4'  style='display: flex;flex-direction: column;align-items: flex-start;'  onclick='openNewWin(this)'><img src='../Images/prepDoc.png' style='cursor:pointer'  class='img-responsive'/><label id='lbl" +
                                        parseInt(i + 1) + "' style='margin-bottom:0px; word-wrap: break-word;' title='" + result[i] + "'>" + result[i] + "</label>";

                                    inactive = inactive + "</div>";
                                    i++;
                                }
                            }
                            inactive = inactive + "</div></div>";
                        }
                    }
                    tempData = tempData + "</div></div>" + inactive + "</div><a class='left carousel-control' href='#newCarousel' data-slide='prev' style='width: 15px;'><i class='fa fa-angle-left custom' style='margin-left: -15px;color:#3c8dbc;'></i></a><a class='right carousel-control' href='#newCarousel' data-slide='next' style='width: 15px;'><i class='fa fa-angle-right custom' style='margin-left:-15px;color:#3c8dbc;'></i></a>";
                    strPrintData.push(tempData);
                    document.getElementById("newCarousel").innerHTML += strPrintData[0];

                    var itemCount = $("#newCarousel div").length;
                    if (itemCount <= 7) {
                        $('#newCarousel').children('.right.carousel-control, .left.carousel-control').hide();
                    }
                    else {
                        $('#newCarousel').children('.right.carousel-control, .left.carousel-control').show();
                    }
                }
            },
        });
    }
}

function openNewWin(obj) {
    NAME = obj.innerText;
    var MRNO = ($.session.get('PatMRNO'));
    var url = "../DoctorDesk/FileDownload?MRNo=" + MRNO + "&&filename=" + NAME
    window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
    //return Details;
}

function setPOtherDetail() {
    if ($.session.get('PatAge') != "")
        $("#DivpatDtls i").show();
    else
        $("#DivpatDtls i").hide();

    var gen = "";
    $("#DivpatDtls label#lblAge").text($.session.get('PatAge'));

    //if ($.session.get('PatMobile') != undefined) {
    //    gen =sessionStorage.getItem('PatMobile').toString().concat(" | ");
    //    gen = gen +sessionStorage.getItem('PatGender').toString().concat(" |");
    //}
    //else {
    //    gen = gen +sessionStorage.getItem('PatGender').toString().concat(" |");	
    //}
    gen = sessionStorage.getItem('PatMRNO').concat(" |") + sessionStorage.getItem('PatGender').toString().concat(" |");

    $("#DivpatDtls label#lblGender").text(gen);

    if ($.session.get('onlpaySTAT') == "Y") {
        $("#btnwhtsup").addClass("fa fa-whatsapp");
    }
    else {
        $("#btnwhtsup").removeClass("fa fa-whatsapp");
    }

    //added by priyanka on 08/10/2025
    var CompanyNM = sessionStorage.getItem('CompName');
    var CompanyCD = sessionStorage.getItem('ComCode');
    if ((CompanyNM != "" && CompanyNM != null && CompanyNM != undefined) && (CompanyCD != "" && CompanyCD != null && CompanyCD != undefined)) {
        $("#DivpatDtls label#CompanyNM").text(CompanyNM);
        $("#DivpatDtls label#CompanyNM").css('color', 'gold');
        $("#compnmspan").css('display', 'block');
    }
    else {
        $("#DivpatDtls label#CompanyNM").text("Self Paying Patient");
        $("#DivpatDtls label#CompanyCD").css('color', '#ffffff');
        $("#compnmspan").css('display', 'block');
    }


    if (window.location.pathname.toUpperCase().includes("PATIENTENTRY")) {
        $("#PatImgDiv").css('display', 'inline-block');
        //$("#sideList").css('margin-top', '71px');
        $('#Patimage').removeAttr('src');
        $.ajax({
            url: '../DoctorDesk/getphoto?mrno=' + sessionStorage.getItem('PatMRNO').toString().trim(),
            type: "POST",
            datatyp: 'json',
            async: false,
            success: function (response) {
                if (response != "") {
                    $('#Patimage').show();
                    $('#Patimage').attr('src', response);
                }
                else {
                    $('#Patimage').hide();
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                MsgDia('An error occurred while processing your request.', "Error Information");
            }
        });
    }
    else {
        $("#PatImgDiv").css('display', 'none');
    }
}

function SetPatientDtl() {
    if ($.session.get('PatName') != null && sessionStorage.getItem('PatAge') != null && sessionStorage.getItem('PatGender') != null) {

        var P_name_val = sessionStorage.getItem('PatName');
        if (P_name_val.indexOf('(') > -1) {
            P_name_val = P_name_val.substr(0, P_name_val.lastIndexOf("(")).trim();
        }
        if ($(window).width() < 996) {
            if (P_name_val.length > 30) {
                var P_New_Val = P_name_val.substr(0, 30);
                P_New_Val = P_New_Val.substr(0, P_New_Val.lastIndexOf("(")).trim();
                $("#DivpatDtls h5").text(P_New_Val);
                setPOtherDetail();
            }
            else {
                $("#DivpatDtls h5").text(P_name_val);
                setPOtherDetail();
            }
        }
        else {

            $("#DivpatDtls h5").text(P_name_val);
            setPOtherDetail();
        }
        sessionStorage.setItem('PatName', P_name_val);
    }


    //  $("#DivpatDtls h5").text($.session.get('PatName'));
    //  if ($.session.get('PatAge')!="")
    //      $("#DivpatDtls i").show();
    //  else
    //      $("#DivpatDtls i").hide();

    //  $("#DivpatDtls label#lblAge").text($.session.get('PatAge'));
    //var gen =sessionStorage.getItem('PatGender').toString().concat(" |");
    //  $("#DivpatDtls label#lblGender").text(gen);

}

$(document.body).on('click', '#tbldiagno tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {
        var selRows = $('#tbldiagno > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tbldiagno tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tbldiagno > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }

        $(this).children('td').children('a').show();
        // selected rows moved to top  
    }
    else {
        $(this).children('td').children('a').hide();
        sessionStorage.setItem('Diag', "N");// Added by Murali on 07/08/2024
    }

    var rows = $('#tbldiagno tbody  tr:not(.active)').get();

    rows.sort(function (a, b) {
        var A = $(a).children('td').eq(0).text().toUpperCase();
        var B = $(b).children('td').eq(0).text().toUpperCase();

        if (A < B) {
            return -1;
        }

        if (A > B) {
            return 1;
        }

        return 0;
    });

    $.each(rows, function (index, row) {
        $('#tbldiagno').children('tbody').append(row);
    });             //sorted unselected rows

    //vijeta 19/4/19
    Sortable.create(
        $('#tblsort')[0], {
        animation: 150,
        scroll: true,
        handle: '.clickable-row',
    })

    //vijeta 9/5/19
    $("#DiagnosisInput").val("").trigger("keyup");//added on 28th sep 2018
    if ($(this).hasClass('active')) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
    }
});

$(document.body).on('click', '#tblICDdiagno tr', function (e) {

    $(this).toggleClass('active');
    var Sel = "Y";
    if ($(this).hasClass('active')) {
        var fixHelperModified = function (e, tr) {
            var $originals = tr.children();
            var $helper = tr.clone();
            $helper.children().each(function (index) {
                $(this).width($originals.eq(index).width())
            });
            return $helper;
        };
        var updateIndex = function (e, ui) {
            $('td.index', ui.item.parent()).each(function (i) {
                $(this).html(i + 1);
            });
        };

        $("#tblICDdiagno tbody").prepend($(this)).closest('tr');
        $(this).children('td').children('a').show();
        // selected rows moved to top  
        $('#tblICDdiagno tbody').sortable({
            items: '.clickable-row.active',
            connectWith: 'table',
            cursor: 'move',
            delay: 150,
            revert: 0,
            helper: fixHelperModified,
            stop: updateIndex,
        }).disableSelection();
    }
    else {
        $(this).children('td').children('a').hide();
        sessionStorage.setItem('Diag', "N");// Added by Murali on 07/08/2024
        Sel = "N";
    }
    RemoveAddICDO(this.id, Sel);

    var rows = $('#tblICDdiagno tbody  tr:not(.active)').get();

    rows.sort(function (a, b) {

        var A = $(a).children('td').eq(0).text().toUpperCase();
        var B = $(b).children('td').eq(0).text().toUpperCase();

        if (A < B) {
            return -1;
        }

        if (A > B) {
            return 1;
        }

        return 0;
    });

    $.each(rows, function (index, row) {
        $('#tblICDdiagno').children('tbody').append(row);
    });             //sorted unselected rows

    //vijeta 19/4/19
    Sortable.create(
        $('#tblsort1')[0], {
        animation: 150,
        scroll: true,
        handle: '.clickable-row',
    });

    $("#ICDDiagnosisInput").val("").trigger("keyup");//added on 28th sep 2018
});

$(document.body).on('click', '#tblICDdiagnoO tr', function (e) {
    $(this).toggleClass('active');
    if ($(this).hasClass('active')) {
        var fixHelperModified = function (e, tr) {
            var $originals = tr.children();
            var $helper = tr.clone();
            $helper.children().each(function (index) {
                $(this).width($originals.eq(index).width())
            });
            return $helper;
        };
        var updateIndex = function (e, ui) {
            $('td.index', ui.item.parent()).each(function (i) {
                $(this).html(i + 1);
            });
        };
        $("#tblICDdiagnoO tbody").prepend($(this)).closest('tr');
        $(this).children('td').children('a').show();
        $('#tblICDdiagnoO tbody').sortable({
            items: '.clickable-row.active',
            connectWith: 'table',
            cursor: 'move',
            delay: 150,
            revert: 0,
            helper: fixHelperModified,
            stop: updateIndex,
        }).disableSelection();
    }
    else {
        $(this).children('td').children('a').hide();
        sessionStorage.setItem('Diag', "N");

    }
    var rows = $('#tblICDdiagnoO tbody  tr:not(.active)').get();
    rows.sort(function (a, b) {
        var A = $(a).children('td').eq(0).text().toUpperCase();
        var B = $(b).children('td').eq(0).text().toUpperCase();
        if (A < B) {
            return -1;
        }
        if (A > B) {
            return 1;
        }
        return 0;
    });
    $.each(rows, function (index, row) {
        $('#tblICDdiagnoO').children('tbody').append(row);
    });
    Sortable.create(
        $('#tblsort2')[0], {
        animation: 150,
        scroll: true,
        handle: '.clickable-row',
    });
    $("#ICDDiagnosisOInput").val("");
});

$(document.body).on('click', '#tblinvestigate tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {

        var selRows = $('#tblinvestigate > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tblinvestigate tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tblinvestigate > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }

        $(this).children('td').children('a').show();
        // selected rows moved to top  

    }
    else {
        $(this).children('td').children('a').hide();

    }

    //sort unselected rows cnt wise
    var rows = $('#tblinvestigate tbody  tr:not(.active)').get();

    rows.sort(function (a, b) {

        //var A = $(a).children('td').children('input[type=hidden]')[0].value;
        //var B = $(b).children('td').children('input[type=hidden]')[0].value;

        var A = Number($(a).children('td').eq(3).text());
        var B = Number($(b).children('td').eq(3).text());

        if (A > B) {
            return -1;
        }

        if (A < B) {
            return 1;
        }

        return 0;
    });

    $.each(rows, function (index, row) {
        $('#tblinvestigate').children('tbody').append(row);
    });             //sorted unselected rows

    //vijeta 19/4/19
    Sortable.create(
        $('#tblsort')[0], {
        animation: 150,
        scroll: true,
        handle: '.clickable-row',
    })

    //vijeta 26/4/19
    $("#InvestigationInput").val("").trigger("keyup");//added on 28th sep 2018
    if ($(this).hasClass('active') && !flagCheckRowsInvst) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        //$(this).find('a.trigger1').trigger('click');

    }


});
$(document.body).on('click', '#tblpatadv tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {

        var selRows = $('#tblpatadv > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tblpatadv tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tblpatadv > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }

        $(this).children('td').children('a').show();
        // selected rows moved to top  

    }
    else {
        $(this).children('td').children('a').hide();

    }
    var rows = $('#tblpatadv tbody  tr:not(.active)').get();

    rows.sort(function (a, b) {

        var A = $(a).children('td').eq(0).text().toUpperCase();
        var B = $(b).children('td').eq(0).text().toUpperCase();

        if (A < B) {
            return -1;
        }

        if (A > B) {
            return 1;
        }

        return 0;
    });

    $.each(rows, function (index, row) {
        $('#tblpatadv').children('tbody').append(row);
    });             //sorted unselected rows

    //vijeta 19/4/19
    Sortable.create(
        $('#tblsort')[0], {
        animation: 150,
        scroll: true,
        handle: '.clickable-row',
    });

    //vijeta 9/5/19
    $("#PatAdviceInput").val("").trigger("keyup");//added on 28th sep 2018
    if ($(this).hasClass('active')) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
    }
});

$(document.body).on('click', 'td.day-td a,td.day-td', function () {

    document.getElementById('layer-demo').style.display = "none";
    document.getElementById('layer-DMY').style.display = "block";
    $('#' + $(this).data('layer-id')).removeClass('is-active');

});

$(document.body).on('click', 'td.duration a,td.duration', function () {
    document.getElementById('layer-DMY').style.display = "none";
    document.getElementById('layer-demo').style.display = "block";
    $('#' + $(this).data('layer-id')).removeClass('is-active');
});

function CheckPatSessionNotEmpty() {
    var mrNo = sessionStorage.getItem('PatMRNO');
    var tranno = sessionStorage.getItem('PatTRANNO');
    if (mrNo != undefined) {
        if ($.session.get('PatSelected') == "Appointed")
            return true;
    }
    else
        return false;
}

function doc_keyUpForShortCutMenus(e) {
    var tag = e.target.tagName.toLowerCase();

    if (tag != 'input' && tag != 'textarea' && e.keyCode != 9 && e.keyCode < 112 && e.keyCode > 123) {  //keycode 9- prevent save on tab
        SaveForAllShortCutMenus();

        if (e.altKey && e.keyCode == 67) {// C
            // call your function to do the thing
            $("#ShortCutComplaint").trigger("click");// Complaints
        }
        else if (e.altKey && e.keyCode == 86)// alt+V
        {
            $("#ShortCutVitals").trigger("click");//vitals
        }
        else if (e.altKey && e.keyCode == 83) {//S
            $("#ShortCutDiagnosis").trigger("click");//Diagnosis
        }
        else if (e.altKey && e.keyCode == 88) {//X
            $("#ShortCutExamination").trigger("click");//Examination
        }
        else if (e.altKey && e.keyCode == 73) {//I
            $("#ShortCutInvestigation").trigger("click");//investigations
        }
        else if (e.altKey && e.keyCode == 82) { //R
            $("#ShortCutMedicineAdvice").trigger("click");//Rx advice
        }
        else if (e.altKey && e.keyCode == 65) { //A
            $("#ShortCutPatientAdvice").trigger("click");//Advice
        }
        else if (e.altKey && e.keyCode == 80) { //P
            $("#ShortCutPrescription").trigger("click");//Prescription
        }
    }
}

function SaveForAllShortCutMenus(e) {

    var page = window.location.href;
    if (page.indexOf("Complaints") != -1)
        SaveAllComplaints("Y");
    else if (page.indexOf("Vitals") != -1) {
        if (!SaveVitals("Y")) {
            e.preventDefault();
        }
    }
    else if (page.indexOf("Examination") != -1)
        SaveExamination("Y");
    else if (page.indexOf("Diagnosis") != -1)
        SaveDiagnosis("Y");
    else if (page.indexOf("Patient") != -1)
        SavePatientAdvice("Y");
    //else if (page.indexOf("Advice") != -1)//commented by vijeta on 19th oct 2018
    //    SaveMedicineResequence("Y");
    else if (page.indexOf("RxDesktop") != -1)   //by vijeta on 12th march 19
    {
        if (!SaveAllMedicines("Y")) {
            e.preventDefault();
        } else {
            SaveAllMedicines("Y");
        }
    }
    else if (page.indexOf("RxNewSearch") != -1) {
        if (!SaveAllMedicines("Y")) {
            e.preventDefault();
        } else {
            SaveAllMedicines("Y");
        }
    }
    else if (page.indexOf("InvestigationTran") != -1)
        SaveInvestigations("Y");
    else if (page.indexOf("ClinicalNotes") != -1)
        Save("Y");
    else if (page.indexOf("PrescriptionPrint") != -1) {
        if (autoComplete == "Y")
            SaveFollowUpPrint("", "M");
        else
            SaveFollowUpPrint("", "N");
    }
}

function PrintSPTReportingData(strMrNo, strTranNo) {
    $.ajax({
        url: '../DoctorDesk/GetSptReportingDataFrPrint',
        type: 'POST',
        datatype: 'json',
        data: { strTranNo: strTranNo, strmrNo: strMrNo },
        success: function (response) {

            var Html = "";
            var allrgnTypeEnum = {
                '01': 'Control', '02': 'Mites', '03': 'Moulds',
                '04': 'Grass Pollen', '05': 'Weed Pollen', '06': 'Tree pollen',
                '07': 'Mountaineous Tree Pllen', '08': 'Animal Epithelia', '09': 'Insects', '10': 'Additional Allergen', '11': 'Milk/Egg',
                '12': 'Flours and Seeds', '13': 'Meat', '14': 'Sea Food', '15': 'Nuts', '16': 'Fruits',
                '17': 'Vegetables', '18': 'Spices and Pulses'
            };// added by vijeta on 15th march 2018

            if (response[0] != null) {

                if (response[0].length > 0) {
                    var patName = sessionStorage.getItem('PatName');
                    var patAge = sessionStorage.getItem('PatAge');
                    var patGender = sessionStorage.getItem('PatGender');
                    var patMob = sessionStorage.getItem('PatMobile');
                    var patAge2 = sessionStorage.getItem('PatAge2');

                    var clinicname = sessionStorage.getItem("ClinicName");

                    var strPrintdata = [];
                    var Grid = JSON.parse(response[1]);

                    strPrintdata.push("<html><head><style>.AllrgenTypeCls{width: 100%; border-collapse: collapse; border: 1px solid black;}.AllrgenTypeCls td,th{  text-align: center; border-collapse: collapse;border: 1px solid black;}.AllrgenTypeCls td{ font-size: 14px;font-family: Verdana, Geneva, sans-serif !important;color:black;padding: 4px;}.AllrgenTypeCls th{ font-size: 16px;}.AllrgenTypeCls td:nth-child(2){ text-align: left;}</style></head><body>");
                    strPrintdata.push("<div id='divheads' style='text-align:center;margin-bottom:10px'><label style='font-size:20px;font-weight:bold;'>SPT Reporting</label></div>");
                    strPrintdata.push("<div><table style='width:100%; font-family: Verdana, Geneva, sans-serif !important;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px'>");
                    strPrintdata.push("<tr class='inHeight'><td class='HTextsize'>Name</td><td style='width:1%'>:</td><td class='HTextsize' style='font-weight:bold;line-height:14px;'>" + patName +
                        "<td class='HTextsize' style=''>Doctor Name</td><td>:</td>");
                    strPrintdata.push("<td class='HTextsize' style='font-weight:bold;'>Dr. " + Grid[0]["DOCTNAME"] + "</td></tr><tr class='HTextsize'><td class='HTextsize'>Age/Gender</td><td >:</td><td class='HTextsize' style=''>" + patAge + ' ' + " / " + patGender + "</td>");

                    strPrintdata.push("<td class='HTextsize' style=''>Date / Time</td><td>:</td><td class='HTextsize'>" + Grid[0]["TranDate"] + " " + Grid[0]["TranTime"] + " </td>");
                    strPrintdata.push("</tr><tr class='HTextsize''><td class='HTextsize' style='padding:3px;' >MR No.</td><td>:</td><td class='HTextsize' style='padding:3px;'>" + strMrNo + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>

                    strPrintdata.push("</td><td class='HTextsize' style='width=5%;'>Consultation No.</td><td class='HTextsize' style='width:1%'>:</td>");
                    strPrintdata.push("<td width='35%' class='HTextsize'>" + strTranNo + "<td></tr>");//<td class='HTextsize'>Doctor Name</td>
                    strPrintdata.push("<tr><td>Clinic Name</td><td>:</td><td>" + clinicname + "</td></tr>")
                    strPrintdata.push("</table></div>");//<td>:</td><td style='color:blue;font-size:12px'> Dr." + GridData.jsonUserdtls[0].DOCTNAME + "</td>



                    $.each(response[0], function (index, value) {
                        strPrintdata.push("<div style='margin-top:12px;'><table class='AllrgenTypeCls'><tr><th colspan='4'>" + allrgnTypeEnum[value] + "</th></tr>");
                        strPrintdata.push("<tr><th>Sr No</th><th>Allergen</th><th>Wheel Diameter</th><th>Result</th></tr>");

                        $.each(Grid, function (ind, val) {
                            if (val["Type"] == value) {
                                strPrintdata.push("<tr><td>" + (Number(ind) + 1) + "</td><td style='width:60%'>" + val["Allergen"] + "</td><td style='width:20%'>" + val["WheelDiameter"] + "mm" + "</td>");

                                var result = val["WheelDiameter"] >= 3 ? "positive" : "Negative";
                                strPrintdata.push("<td>" + result + "</td>");
                                strPrintdata.push("</tr>");
                            }

                        });


                        strPrintdata.push("</table></div>");
                    });

                    strPrintdata.push("</body></html>");

                    Html = strPrintdata.join("");
                    openWin(Html);
                }
            }

        }
    });
}

function openWin(Html) {
    var myWindow = window.open('', '', '"<%=Server.MapPath("~/")%>"');
    //myWindow.document.write(Html);
    $(myWindow.document.body).html(Html);
    myWindow.document.close();
    myWindow.focus();
    setTimeout(function () {
        myWindow.print();
        myWindow.close();
    }, 100);
}

function GetPrevoisSptReports() {
    var mrno = ($.session.get('PatMRNO'));
    if ($.session.get('PatMRNO') != null) {
        $.ajax({
            type: "POST",
            url: 'GetPatientPrevSPTReports',
            datatype: "json",
            data: { strMRNO: mrno },
            success: function (result) {

                //$(document).ready(function () {//
                strPrintData = [];
                if (result.length == 0) {
                    document.getElementById("prevSptReporting").style.display = "none";
                    $('#newCarouselSPT').empty();
                }
                else {
                    $('#newCarouselSPT').empty();
                    if ($(window).width() <= 576)
                        $('.slide').css('width', '100%');
                    else
                        $('.slide').css('width', '45%');
                    var tempData = "<div class='carousel-inner' style='margin-left: 20px;'>" +
                        "<div class='item active'>" +
                        "<div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                    var inactive = "";
                    for (var i = 0; i < result.length;) {
                        document.getElementById("prevSptReporting").style.display = "block";
                        var $this = $('#newCarouselSPT');
                        if (i <= 2) {
                            tempData = tempData + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer;width: 40px;height: 40px;' id='" + result[i].TRANNO + "'  onclick='PrintPreviousSPT(\"" + result[i].TRANNO + "\");' class='img-responsive'/><label id='lbl" +
                                parseInt(i + 1) + "' style='margin-bottom:0px; ' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE + "</label>";

                            //if (PatCompletedYN == "N") {
                            //    tempData = tempData + "<a id='hdn" + parseInt(i + 1) +
                            //    "' style='margin-left:10px;cursor:pointer' title='" + result[i].TRANNO + "' onclick='GetCopy(this)'>Copy</a>"
                            //}

                            tempData = tempData + "</div>";
                            i++;
                        }
                        else {
                            inactive += "<div class='item' ><div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                            for (j = 0; j < 4; j++) {
                                if (i < result.length) {
                                    inactive = inactive + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer' id='" + result[i].TRANNO + "' onclick='PrintPreviousSPT()' class='img-responsive'/><label id='lbl" +
                                        parseInt(i + 1) + "' style='margin-bottom:0px; ' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE + "</label>";

                                    //if (PatCompletedYN == "N") {
                                    //    tempData = tempData + "<a id='hdn" + parseInt(i + 1) +
                                    //    "' style='margin-left:10px;cursor:pointer' title='" + result[i].TRANNO + "' onclick='GetCopy(this)'>Copy</a>";
                                    //}

                                    inactive = inactive + "</div>";
                                    i++;
                                }
                            }
                            inactive = inactive + "</div></div>";
                        }

                    }
                    tempData = tempData + "</div></div>" + inactive + "</div><a class='left carousel-control' href='#newCarouselSPT' data-slide='prev' style='width: 15px;'>" +
                        "<i class='fa fa-angle-left custom' style='margin-left: -15px;color:#3c8dbc;'></i></a><a class='right carousel-control' href='#newCarouselSPT' data-slide='next' style='width: 15px;'>" +
                        "<i class='fa fa-angle-right custom' style='margin-left: -15px;color:#3c8dbc;'></i></a>";
                    strPrintData.push(tempData);
                    document.getElementById("newCarouselSPT").innerHTML += strPrintData[0];

                    var itemCount = $("#newCarouselSPT div").length;
                    if (itemCount <= 7) {
                        $('#newCarouselSPT').children('.right.carousel-control, .left.carousel-control').hide();
                    }
                    else {
                        $('#newCarouselSPT').children('.right.carousel-control, .left.carousel-control').show();
                    }
                }
                // });
            },
        });
    }

}

function PrintPreviousSPT(tranno) {
    var mrNo = sessionStorage.getItem('PatMRNO');
    PrintSPTReportingData(mrNo, tranno);
}

function GetPrevoisAllergies() {
    var mrno = ($.session.get('PatMRNO'));
    if ($.session.get('PatMRNO') != null) {
        $.ajax({
            type: "POST",
            url: 'GetPatientPrevAllergies',
            datatype: "json",
            data: { strMRNO: mrno },
            success: function (result) {

                strPrintData = [];
                if (result.length == 0) {
                    document.getElementById("prevAllergies").style.display = "none";
                    $('#newCarouselAllergy').empty();
                }
                else {
                    $('#newCarouselAllergy').empty();
                    if ($(window).width() <= 576)
                        $('.slide').css('width', '100%');
                    else
                        $('.slide').css('width', '45%');
                    var tempData = "<div class='carousel-inner'  style='margin-left: 20px;'>" +
                        "<div class='item active' >" +
                        "<div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                    var inactive = "";
                    for (var i = 0; i < result.length;) {
                        document.getElementById("prevAllergies").style.display = "block";
                        var $this = $('#newCarouselAllergy');
                        if (i <= 2) {
                            tempData = tempData + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer;width: 40px;height: 40px;' id='" + result[i].TRANNO + "'  onclick='PrintPreviousAllergy(\"" + result[i].TRANNO + "\");' class='img-responsive'/><label id='lbl" +
                                parseInt(i + 1) + "' style='margin-bottom:0px;' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE + "</label>";

                            //if (PatCompletedYN == "N") {
                            //    tempData = tempData + "<a id='hdn" + parseInt(i + 1) +
                            //    "' style='margin-left:10px;cursor:pointer' title='" + result[i].TRANNO + "' onclick='GetCopy(this)'>Copy</a>"
                            //}

                            tempData = tempData + "</div>";
                            i++;
                        }
                        else {
                            inactive += "<div class='item'><div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                            for (j = 0; j < 4; j++) {
                                if (i < result.length) {
                                    inactive = inactive + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer' id='" + result[i].TRANNO + "' onclick='PrintPreviousAllergy()' class='img-responsive'/><label id='lbl" +
                                        parseInt(i + 1) + "' style='margin-bottom:0px;' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE + "</label>";

                                    //if (PatCompletedYN == "N") {
                                    //    tempData = tempData + "<a id='hdn" + parseInt(i + 1) +
                                    //    "' style='margin-left:10px;cursor:pointer' title='" + result[i].TRANNO + "' onclick='GetCopy(this)'>Copy</a>";
                                    //}

                                    inactive = inactive + "</div>";
                                    i++;
                                }
                            }
                            inactive = inactive + "</div></div>";
                        }

                    }
                    tempData = tempData + "</div></div>" + inactive + "</div><a class='left carousel-control' href='#newCarouselSPT' data-slide='prev' style='width: 15px;'>" +
                        "<i class='fa fa-angle-left custom' style='margin-left: -15px;color:#3c8dbc;'></i></a><a class='right carousel-control' href='#newCarouselSPT' data-slide='next' style='width: 15px;'>" +
                        "<i class='fa fa-angle-right custom' style='margin-left: -15px;color:#3c8dbc;'></i></a>";
                    strPrintData.push(tempData);
                    document.getElementById("newCarouselAllergy").innerHTML += strPrintData[0];

                    var itemCount = $("#newCarouselAllergy div").length;
                    if (itemCount <= 7) {
                        $('#newCarouselAllergy').children('.right.carousel-control, .left.carousel-control').hide();
                    }
                    else {
                        $('#newCarouselAllergy').children('.right.carousel-control, .left.carousel-control').show();
                    }
                }
                // });
            },
        });
    }

}

function PrintPreviousAllergy(tranno) {
    var strMrNo = sessionStorage.getItem('PatMRNO');

    $.get('../DoctorDesk/Allergy', null, function (text) {
        //alert($(text).find('#tblRespiratory'));
        $.ajax({
            url: '../DoctorDesk/GetAllergies',
            data: { strMrNo: strMrNo, strTranNo: tranno },
            datatype: 'json',
            success: function (response) {

                var $data = $(text).find('#ContainerForAllPanel').clone();

                //Respiratory tract
                var strRespirotorySymp = response[0].RESPIRATORYSYMPTOMS;
                var arryRespiratorySymptoms = strRespirotorySymp.split(",");
                if (arryRespiratorySymptoms.length > 0) {
                    $.each(arryRespiratorySymptoms, function (index, value) {
                        $data.find("#tblRespiratory td:contains(" + value + ")").prev().children()[1].checked = true;

                    });
                }

                //Eyes
                var strEyesSymp = response[0].EYESSYMPTOMS;
                var arryEyesSymptoms = strEyesSymp.split(",");
                if (arryEyesSymptoms.length > 0) {
                    $.each(arryEyesSymptoms, function (index, value) {
                        $data.find("#tblEyes td:contains(" + value + ")").prev().children()[1].checked = true;
                    });
                }

                //Skin
                var strSkinSymp = response[0].SKINSYMPTOMS;
                var arrySkinSymptoms = strSkinSymp.split(",");
                if (arrySkinSymptoms.length > 0) {
                    $.each(arrySkinSymptoms, function (index, value) {
                        $data.find("#tblSkin td:contains(" + value + ")").prev().children()[1].checked = true;
                    });
                }

                //GastroIntenstinal
                var strgastroIntestinalSymp = response[0].GASTROINTESTINALSYMPTOMS;
                var arryGastroSymptoms = strgastroIntestinalSymp.split(",");
                if (arryGastroSymptoms.length > 0) {
                    $.each(arryGastroSymptoms, function (index, value) {
                        $data.find("#tblGastroIntestinal td:contains(" + value + ")").prev().children()[1].checked = true;
                    });
                }

                //when do u suffer frm allergic symptoms
                if (response[0].ALLERGICSYMPTOMSYN == "S")
                    $data.find("#radioSeasonal").prop("checked", "checked");
                else if (response[0].ALLERGICSYMPTOMSYN == "P")
                    $data.find("#radioPerennial").prop("checked", "checked");
                else if (response[0].ALLERGICSYMPTOMSYN == "B")
                    $data.find("#radioAllergicPeriodBoth").prop("checked", "checked");

                // in which months do u get symptoms repeatedly
                var strMonths = response[0].SYMPTOMSMONTHS;
                var arryMonths = strMonths.split(",");
                if (arryMonths.length > 0) {
                    $.each(arryMonths, function (index, value) {
                        $data.find("#tblMonths td:contains(" + value + ")").children()[1].checked = true;
                    });
                }

                //how long do ur symptoms last
                if (response[0].FOURDAYSPERWEEKYN == "Y") // more than four days per week
                    $data.find("#radioMoreThan4DaysY").prop("checked", "checked");
                else
                    $data.find("#radioMoreThan4DaysN").prop("checked", "checked");


                if (response[0].FOURWEEKSSTRETCHYN == "Y") // more than four weeks yes/no
                    $data.find("#radioMoreThan4Weeks").prop("checked", "checked");
                else
                    $data.find("#radioMoreThan4WeeksN").prop("checked", "checked");

                //do ur symptoms affect day to day activities
                if (response[0].SYMPTOMSAFFECTYN == "N")
                    $data.find("#radioSymptomsAffectActivitiesN").prop("checked", "checked");
                else if (response[0].SYMPTOMSAFFECTYN == "L")
                    $data.find("#radioSymptomsAffectActivitiesL").prop("checked", "checked");
                else if (response[0].SYMPTOMSAFFECTYN == "M")
                    $data.find("#radioSymptomsAffectActivitiesM").prop("checked", "checked");
                else if (response[0].SYMPTOMSAFFECTYN == "P")
                    $data.find("#radioSymptomsAffectActivitiesP").prop("checked", "checked");


                //Do ur symptoms disturb ur sleep
                if (response[0].DISTURBSLEEPYN == "Y")
                    $data.find("#radioDisturbSleepY").prop("checked", "checked");
                else
                    $data.find("#radioDisturbSleepN").prop("checked", "checked");

                //are ur symptoms worse in the following locations
                var strlocations = response[0].WORSEINLOCATION;
                var arryLocations = strlocations.split(",");
                if (arryLocations.length > 0) {
                    $.each(arryLocations, function (index, value) {
                        $data.find("#tblLocations td:contains(" + value + ")").children()[1].checked = true;
                    });
                }

                //are ur symptoms worse at the following time
                var strTimes = response[0].WORSEATTIME;
                var arryTimes = strTimes.split(",");
                if (arryTimes.length > 0) {
                    $.each(arryTimes, function (index, value) {
                        $data.find("#tblWorseAtTime td:contains(" + value + ")").children()[1].checked = true;
                    });
                }

                //are ur symptoms worsenedby following triggers
                var strTriggers = response[0].WORSENEDBYTRIGGERS;
                var arryTriggers = strTriggers.split(",");
                if (arryTriggers.length > 0) {
                    $.each(arryTriggers, function (index, value) {
                        //$("#tblTriggers td:contains(" + value + ")").children()[1].checked = true;
                        $data.find("#tblTriggers td:contains(" + value + ")").prev().children()[1].checked = true;
                    });
                }

                // have u been hospitalized
                if (response[0].HOSPITALIZDBCZOFALLERGY == "Y")
                    $data.find("#raioHospitalisedY").prop("checked", "checked");
                else
                    $data.find("#raioHospitalisedN").prop("checked", "checked");

                //have u ever been skin tested
                if (response[0].BLOODTEST == "Y") {
                    $data.find("#radioPastTestHisYes").prop("checked", "checked");
                    $data.find("#pastHstorySubDiv").show();
                }
                else {
                    $data.find("#radioPastTestHisNo").prop("checked", "checked");
                    $data.find("#pastHstorySubDiv").hide();
                }

                //have u received allergn immunothrapy
                if (response[0].ALLERGYVACCINEBEFORE == "Y") {
                    $data.find("#radioAllergyVaccineYes").prop("checked", "checked");
                    $data.find("#pastHistSubDivVaccine").show();
                }
                else {
                    $data.find("#radioAllergyVaccineNo").prop("checked", "checked");
                    $data.find("#pastHistSubDivVaccine").hide();
                }

                //test date
                $data.find("#txtTestDate").val(response[0].TESTDATE);

                //To which allergies did you test positive:
                $data.find("#txtPositiveTest").val(response[0].POSITIVETESTS);

                //Vaccinated Allergies
                $data.find("#txtAllergies").val(response[0].VACCINATEDALLERGIES);

                //vaccine initiated date
                $data.find("#txtAllergyInitiatedDate").val(response[0].VACCINEINITIATEDDATE);

                //how many years
                $data.find("#txtYears").val(response[0].VACCINEYEARS);

                //Response to therapy
                if (response[0].RESPONSETOTHERAPY == "S")
                    $data.find("#radioResponseToTherapyS").prop("checked", "checked");
                else if (response[0].RESPONSETOTHERAPY == "G")
                    $data.find("#radioResponseToTherapyGood").prop("checked", "checked");
                else if (response[0].RESPONSETOTHERAPY == "M")
                    $data.find("#radioResponseToTherapyMild").prop("checked", "checked");
                else if (response[0].RESPONSETOTHERAPY == "N")
                    $data.find("#radioResponseToTherapyNone").prop("checked", "checked");

                if (response[0].PARENTASTHMA == "Y")
                    $data.find("#chkBxParentsAsthma").prop("checked", "checked");
                if (response[0].PARENTALLERGICRHINITIS == "Y")
                    $data.find("#chkBxParentsAllergicRhinitis").prop("checked", "checked");
                if (response[0].PARENTSKINALLERGY == "Y")
                    $data.find("#chkBxParentSkinAllergy").prop("checked", "checked");
                if (response[0].PARENTFOODALLERGY == "Y")
                    $data.find("#chkBxParentsFoodAllergy").prop("checked", "checked");

                if (response[0].SIBLINGASTHMA == "Y")
                    $data.find("#chkBxSiblingAsthma").prop("checked", "checked");
                if (response[0].SIBLINGALLERGICRHINITIS == "Y")
                    $data.find("#chkBxSiblingAllergicRhinitis").prop("checked", "checked");
                if (response[0].SIBLINGSKINALLERGY == "Y")
                    $data.find("#chkBxSiblingSkinAllergy").prop("checked", "checked");
                if (response[0].SIBLINGFOODALLERGY == "Y")
                    $data.find("#chkBxSiblingFoodAllergy").prop("checked", "checked");

                if (response[0].CHILDRENASTHMA == "Y")
                    $data.find("#chkBxChildrenAsthma").prop("checked", "checked");
                if (response[0].CHILDRENALLERGICRHINITIS == "Y")
                    $data.find("#chkBxChildrenAllergicRhinitis").prop("checked", "checked");
                if (response[0].CHILDRENSKINALLERGY == "Y")
                    $data.find("#chkBxChildrenSkinAllergy").prop("checked", "checked");
                if (response[0].CHILDRENFOODALLERGY == "Y")
                    $data.find("#chkBxFoodAllergy").prop("checked", "checked");

                $data.find("#txtNoOfSiblings").val(response[0].NOOFSIBLINGS);
                $data.find("#txtNoOfChildren").val(response[0].NOOFCHILDREN);


                if (response[0].H1ANTIORAL == "Y")
                    $data.find("#chkBxh1AntiOral").prop("checked", "checked");
                if (response[0].H1ANTINASAL == "Y")
                    $data.find("#chkBxh1AntiNasal").prop("checked", "checked");
                if (response[0].H1ANTIOPTHAIMIC == "Y")
                    $data.find("#chkBxh1AntiOpthaimic").prop("checked", "checked");

                if (response[0].ALLERGICRHINITISORAL == "Y")
                    $data.find("#chkBxAllergicRhinitisOral").prop("checked", "checked");
                if (response[0].ALLERGICRHINITISNASAL == "Y")
                    $data.find("#chkBxAllergicRhinitisNasal").prop("checked", "checked");
                if (response[0].ALLERGICRHINITISINHALED == "Y")
                    $data.find("#chkBxAllergicRhinitisInhaled").prop("checked", "checked");
                if (response[0].ALLERGICRHINITISTOPICAL == "Y")
                    $data.find("#chkBxAllergicRhinitisTopical").prop("checked", "checked");

                if (response[0].SMOKER == "Y")
                    $data.find("#smokerYes").prop("checked", "checked");
                else if (response[0].SMOKER == "N")
                    $data.find("#smokerNo").prop("checked", "checked");
                else if (response[0].SMOKER == "P")
                    $data.find("#smokerPast").prop("checked", "checked");

                $data.find("#txtH1AntiFrequency").val(response[0].H1ANTIFREQUENCY);
                $data.find("#txtAllergicRhinitisFrequency").val(response[0].ALLERGICRHINITISFREQUENCY);
                $data.find("#txtB2AgnosistsRoute").val(response[0].B2AGONISTROUTE);
                $data.find("#txtB2AgnosistsFrequency").val(response[0].B2AGONISTFREQUENCY);
                $data.find("#txtOtherRoute").val(response[0].OTHERMEDICATIONROUTE);
                $data.find("#txtOtherFrequency").val(response[0].OTHERMEDICATIONFREQUENCY);

                trnDt = response[0].TRANDT;
                trntm = response[0].TRANTM;
                doctName = response[0].DOCTNAME;
                PrintAllergyQuestionair($data, trnDt, trntm, doctName)
                //openWin($data);
            },

        })
    });
}

function PrintAllergyQuestionair($data, tranDt, tranTm, doctName) {
    //if (prntMode == "Y") {
    var strTranNo = sessionStorage.getItem('PatTRANNO');
    var strMrNo = sessionStorage.getItem('PatMRNO');
    var patName = sessionStorage.getItem('PatName');
    var patAge = sessionStorage.getItem('PatAge');
    var patGender = sessionStorage.getItem('PatGender');
    var patMob = sessionStorage.getItem('PatMobile');
    var patAge2 = sessionStorage.getItem('PatAge2');
    var clinicname = sessionStorage.getItem("ClinicName");

    var $html = $("<html></html>");
    var $head = $("<head></head>");
    var $style = $("<style></style>");
    var styleCss = ".panel-body { width: auto !important;height: auto !important;} .divHeads { color:black;background-color: #3c8dbc; border-color: #ddd; box-shadow: none; font-size: 20px;text-align: center;font-weight: bold;}.divBody {  padding: 15px;background-color: white;font-size: 18px; color: black;white-space: 2px;}.divCheckboxList { float: left;width: 25%;font-size:14px;}#tblPastHistTest, #tblPastHistVaccine, #tblFamilyHist { border-collapse: separate;} #tblPastHistTest td, #tblPastHistVaccine td, #tblFamilyHist td { padding: 4px;}#tblMedicationHis th, #tblMedicationHis td { border-collapse: collapse;border: 1px solid black;padding:4px;} #tblMedicationHis th {text-align: center;}hr{border-top: 1px solid black;} #divGrpChekboxLst { height: 180px;}#tblTriggers{height:160px;}";

    $style.append(document.createTextNode(styleCss));
    var $body = $("<body></body>");

    var $heading = $("<div style='text-align:center;margin-bottom:10px;font-size:20px;font-weight:bold;><label style='font-size:20px;font-weight:bold;'>Allergy Questionnair</label></div>");
    var $patInfoDiv = $("<div></div>");
    var $patInfoTbl = $("<table style='width:100%; font-family: Verdana, Geneva, sans-serif !important;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px'>" +
        "<tr class='inHeight'><td class='HTextsize'>Name</td><td style='width:1%'>:</td><td class='HTextsize' style='font-weight:bold;line-height:14px;'>" + patName +
        "<td class='HTextsize' style=''>Doctor Name</td><td>:</td>" +
        "<td class='HTextsize' style='font-weight:bold;'>Dr. " + doctName + "</td></tr><tr class='HTextsize'><td class='HTextsize'>Age/Gender</td><td >:</td><td class='HTextsize' style=''>" + patAge + ' ' + " / " + patGender + "</td>" +
        "<td class='HTextsize' style=''>Date / Time</td><td>:</td><td class='HTextsize'>" + tranDt + " " + tranTm + " </td>" +
        "</tr><tr class='HTextsize''><td class='HTextsize' style='padding:3px;' >MR No.</td><td>:</td><td class='HTextsize' style='padding:3px;'>" + strMrNo + "</td>" +
        "</td><td class='HTextsize' style='width=5%;'>Consultation No.</td><td class='HTextsize' style='width:1%'>:</td>" +
        "<td width='35%' class='HTextsize'>" + strTranNo + "<td></tr>" +
        "<tr><td>Clinic Name</td><td>:</td><td>" + clinicname + "</td></tr>" +
        "</table>");

    $patInfoDiv.append($patInfoTbl);
    //var $data = $('#ContainerForAllPanel').clone();
    $html.append($head);
    $head.append($style);
    $html.append($body);

    $body.append($heading);
    $body.append($patInfoDiv);
    $body.append($data);
    openWin($html);
}

function ActiveMenu(liObject) {

    $('#tabMenuUl').children().each(function () {
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
        }
    });
    $("#tabMenuUl li#" + liObject + "").addClass("active");
    //if (document.getElementById("tabMenu").style.display == "none") {
    //    document.getElementById("secCont").style.paddingTop = "50px";
    //} else {
    //    if (window.innerWidth >= 767 && window.innerWidth <= 1508) {
    //        document.querySelectorAll('.fixed .content-wrapper, .fixed .right-side').forEach(function (el) {
    //            el.style.paddingTop = '90px';
    //        });
    //    }
    //}
}

function GetSetUpList(page) {
    var strUrl = "";
    if (page.indexOf("Advice") != -1) {
        strUrl = "../DoctorDesk/GetPersPatientAdviceList";
    }
    else if (page.indexOf("Investigation") != -1) {
        strUrl = "../DoctorDesk/GetPersInvestigationList";
    }
    else if (page.indexOf("RxNew") != -1) {
        strUrl = "../DoctorDesk/GetPersDiseaseList?CIMS=Y";
    }
    else if (page.indexOf("RxDesk") != -1) {
        strUrl = "../DoctorDesk/GetPersDiseaseList?CIMS=N";
    }
    $.ajax({
        type: "POST",
        url: strUrl,
        data: {},
        asycn: false,
        success: function (response) {
            if (response != "Unsucessfull" && response != "UNSUCCESSFULL") {
                var result = JSON.parse(response)
                var rows = "";
                for (i = 0; i < result.Table1.length; i++) {
                    rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>";
                    rows += "</tr>";
                }
                $('#tblPatAdviceStUps tbody').empty();
                $('#tblPatAdviceStUps tbody').append(rows).closest('tr');
            }
            // });

        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        },
        complete: function () {

        }
    });
}

$(document.body).on('click', '#tblMaterialList tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {

        var selRows = $('#tblMaterialList > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tblMaterialList tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tblMaterialList > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }



        $(this).children('td').children('a').show();
        $(this).children('td').children('input').show();
        $(this).children('td').children('select').show();
        $(this).children('td').children('div').show();
        $(this).children('td').children('span').show();
        //$(this).children('td.MedDate').children('a')[0].innerText = $(this).children('td.MedDate').children('a')[0].innerText == "" ? GetCurrentDate() : $(this).children('td.MedDate').children('a')[0].innerText;
        var Day = $(this).children('td.durationNum').find('a')[0].innerText;
        var Dur = $(this).children('td.durationWord').find('a')[0].innerText;
        var ITake = $(this).children('td.tdIntake').find('input')[0].value;
        $(this).children('td.tdQty').find('input')[0].value = $(this).children('td.tdQty').find('input')[0].value == "" ? CalculateTabCount(ITake, Day, Dur) : $(this).children('td.tdQty').find('input')[0].value;
        //$(this).find('a.triggerMedDate').text(GetCurrentDate());

        $('#tblMaterialList input.hasAutoComplete').autocomplete("close");
        $(this).find("input.triggerInputIntake").trigger("keydown");

        // selected rows moved to top  
        Sortable.create(
            $('#tblsort')[0], {
            animation: 150,
            scroll: true,

            handle: '.clickable-row',
        })

        //var Remarkelement = document.createElement("Select");      
        //Remarkelement.className = "RemarkSelc"
        //var blankRemark = document.createElement("option");
        //Remarkelement.add(blankRemark, null);
        //for (p = 0 ; p < RemarkArray.length; p++) {
        //    var remark = document.createElement("option");
        //    remark.text = RemarkArray[p].Text;
        //    remark.value = RemarkArray[p].Value;
        //    Remarkelement.add(remark, null);
        //}

        //Remarkelement.setAttribute('style', 'text-align:center;')     
        //$(this).find("td:last-child").append(Remarkelement);


    }
    else {

        //vijeta 12/4/19
        $(this).children('td.tdIntake').find('input.triggerInputIntake')[0].value = ""; //intake input
        $(this).children('td.durationWord').children('a')[0].innerText = "D";
        $(this).children('td.durationNum').children('a')[0].innerText = "0";
        $(this).children('td.tdBeforeAfter').children('a')[0].innerText = "-"
        $(this).children('td.tdDosses').find('input.triggerInputDosses')[0].value = "";//dose
        $(this).children('td.tdRemark').children('a')[0].innerText = "Remark";//remark anchor text
        $(this).children('td.tdRemark').children('input')[0].value = "";//remark dopdown value
        $(this).children('td.MedDate').children('a')[0].innerText = GetCurrentDate();//Added By Rajan - For MedDate
        //-------------------

        $(this).children('td').children('a').hide();
        $(this).children('td').children('input').hide();
        $(this).children('td').children('select').hide();
        $(this).children('td').children('div').hide();
        $(this).children('td').children('span').hide();

        $('#tblMaterialList input.hasAutoComplete').autocomplete("close");

        var className = $(this).attr('class');
        if (className.length > 0) {
            var ClassId = className.substr(className.length - 4).trim();
            var advicedayNum = (ClassId).replace(/[^0-9]+/ig, "");
            var RowPos = $('.Tr' + (advicedayNum - 1).toString());
            RowPos.next().after(this);
        }
        //sessionStorage.setItem($(this)[0].id, 'N');
    }

    var rows = $('#tblMaterialList tbody  tr:not(.active)').get();

    $.each(rows, function (index, row) {
        $('#tblMaterialList').children('tbody').append(row);
    });             //sorted unselected rows

    //vijeta 9/5/19
    if ($(this).hasClass('active')) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
    }

    // $("#ComplaintInput").val("").trigger("keyup");
    $("#ComplaintInput").val("").trigger("donetyping");
    SearchComplaint();
});


//added on 17th oct 2018
function RxDesktopSetData(result) {
    for (var i = 0; i < result.length; i++) {
        var NonFrqRows = '';
        var DurgID = (result[i]["DRUGCD"]).replace(/[^0-9a-zA-Z]/gi, '');
        //Added by Tejashri 26/12/2018
        var food = '';
        if (result[i]["ABFOOD"] == "E")
            food = "B";
        else if (result[i]["ABFOOD"] == "-")
            food = "-";
        else
            food = "A";
        //End
        var NonFrqRows = '';

        var tamperYn = (result[i]["TAMPERYN"]).toString();//vijeta 12/4/19
        var SDate = result[i]["MEDSTARTDATE"] == "" || result[i]["MEDSTARTDATE"] == undefined ? "-" : ConvertDateFormat(result[i]["MEDSTARTDATE"]);
        if ($('#tblMaterialList tr#' + DurgID + "").length > 0 && !$('#tblMaterialList tr#' + DurgID + "").hasClass("active") && tamperYn == "N") {

            $('#tblMaterialList tr#' + DurgID + ' td.tdIntake')[0].innerHTML = "<div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' value='" + result[i]["INTAKEDESC"].trim() + "' id='intake" + DurgID + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake'></span></div>";//intake 
            // $('#tblMaterialList tr#' + DurgID + ' td.AddNewIntake')[0].innerHTML = "<a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/add.png'  class='intakeImage'></a>";
            $('#tblMaterialList tr#' + DurgID + ' td.durationNum')[0].innerHTML = "<a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DAYS"] + "</a>";
            $('#tblMaterialList tr#' + DurgID + ' td.durationWord')[0].innerHTML = "<a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DURATION"] + "</a>";
            $('#tblMaterialList tr#' + DurgID + ' td.tdBeforeAfter')[0].innerHTML = "<a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + DurgID + "' style='display:none;font-size:14px'>" + food + "</a>";
            $('#tblMaterialList tr#' + DurgID + ' td.tdDosses')[0].innerHTML = "<input type='text' class='triggerInputDosses form-control' style='display:none;' placeholder='Dose' value='" + result[i]["DOSSAGE"].trim() + "' id='dossage" + DurgID + "' />";
            $('#tblMaterialList tr#' + DurgID + ' td.MedDate')[0].innerHTML = "<a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + DurgID + "' style='display:none;font-size:14px'>" + SDate + "</a>";//Added By Rajan - For MedDate

            if (result[i]["QTY"] != undefined && result[i]["QTY"] != null) {
                $('#tblMaterialList tr#' + DurgID + ' td.tdQty')[0].innerHTML = "<input type='text' class='triggerInputQty form-control' style='display:none;' placeholder='Qty' value='" + result[i]["QTY"].trim() + "' id='Qty" + DurgID + "' />";
            }
            else {
                var qty = "";
                $('#tblMaterialList tr#' + DurgID + ' td.tdQty')[0].innerHTML = "<input type='text' class='triggerInputQty form-control' style='display:none;' placeholder='Qty' value='" + qty + "' id='Qty" + DurgID + "' />";
            }
            if (result[i]["ROUTE"].toString().trim() != "" && result[i]["ROUTE"].toString().trim() != null) {

                var routeText = "Route";

                if ($("#layer-Route #" + result[i]["ROUTE"] + "").length > 0)
                    routeText = $("#layer-Route #" + result[i]["ROUTE"] + "").text();

                $('#tblMaterialList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["ROUTE"] + "' />";
            }
            else {
                $('#tblMaterialList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>Per oral</a><input type='hidden' id='hdn" + DurgID + "' value ='09' />";
            }

            if (result[i]["Remarks"].toString().trim() != "") {

                var remarkText = "Remark";

                if ($("#layer-Remark #" + result[i]["Remarks"] + "").length > 0)
                    remarkText = $("#layer-Remark #" + result[i]["Remarks"] + "").text();

                $('#tblMaterialList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["Remarks"] + "' />";//4/12/19
            }
            else {
                $('#tblMaterialList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + DurgID + "'  />";//4/12/19
            }

            $('#tblMaterialList tr#' + DurgID + ' td.tdDrugCode')[0].innerText = (result[i]["DRUGCD"]).trim(); //vijeta 4/5/19

            //added 29/6/19
            $('#tblMaterialList tr#' + DurgID + ' td.setupyn')[0].innerHTML = result[i]["SETUPYN"].trim();
            $('#tblMaterialList tr#' + DurgID + ' td.refillyn')[0].innerHTML = result[i]["REFILLYN"].trim();

            $('#tblMaterialList tr#' + DurgID + ' td.sortTD1')[0].innerHTML = "<a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a>";
            $('#tblMaterialList tr#' + DurgID + ' td.sortTD2')[0].innerHTML = "<a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a>";

            if (result[i]["ROUTINEYN"] != "" && result[i]["ROUTINEYN"] != null && ShowroutineFeature == "Y") {
                var RoutineMed;
                if (result[i]["ROUTINEYN"].toString() == "Y")
                    RoutineMed = "true";
                else
                    RoutineMed = "false";
                $('#tblMaterialList tr#' + DurgID + ' td.tdRoutineMed')[0].innerHTML = "<input type='checkbox'  style='display:none;'  checked='" + RoutineMed + "' id='chkRoutineMed" + DurgID + "' />";
            }
            else if (ShowroutineFeature == "Y") {
                $('#tblMaterialList tr#' + DurgID + ' td.tdRoutineMed')[0].innerHTML = "<input type='checkbox' style='display:none;' id='chkRoutineMed" + DurgID + "' />";
            }

            //$('#tblMaterialList tr#' + DurgID + ' td.tdStatus')[0].innerText = result[i]["PHSTATUS"]; //Added by Murali on 17/06/2024
            if (result[i]["SETUPYN"].trim() == "N")
                $('#tblMaterialList tr#' + DurgID + ' td.tdStatus')[0].innerText = "A"; //Added by Murali on 17/06/2024
            else {
                if (result[i]["PHSTATUS"] == undefined)
                    $('#tblMaterialList tr#' + DurgID + ' td.tdStatus')[0].innerText = "A"; //Added by Murali on 17/06/2024
                else
                    $('#tblMaterialList tr#' + DurgID + ' td.tdStatus')[0].innerText = result[i]["PHSTATUS"]; //Added by Murali on 17/06/2024
            }


            $('#tblMaterialList tr#' + DurgID).trigger('click');
            ShowroutineFeature == "Y" ? $("#chkRoutineMed" + DurgID)[0].checked = (result[i]["ROUTINEYN"] == undefined ? false : (result[i]["ROUTINEYN"].toString() == "Y" ? true : false)) : "";
        }
        else if (tamperYn == "Y") {
            DurgID = DurgID.replace(/\//g, '');
            DurgID = DurgID + "_T" + result[i].RESEQ;
            var medname = $.trim(result[i].DRUGNM);
            if ($.trim(result[i].DRUGNM) != "") {
                medname = $.trim(result[i].DRUGNM) + " (" + $.trim(result[i].GENERICNAME) + ")";
            }
            NonFrqRows += "<tr  class='" + DurgID + "' id='" + $.trim(DurgID) + "'>" +

                "<td class='MaterialName' style='width:25%'>" + medname + "</td><td class='GenriName' style='display:none'>" + $.trim(result[i].GENERICNAME) + "</td><td class='GenricID' style='display:none'>" + $.trim(result[i].GENERICID) + "</td>" +//
                "<td style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td>" +
                "<td class='MedDate' style='width:7%' ><a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + DurgID + "' style='display:none;font-size:14px'>" + SDate + "</a></td>" + //Added By Rajan - For MedDate
                "<td class='tdIntake' style='width:12.9%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' value='" + result[i]["INTAKEDESC"].trim() + "' id='intake" + DurgID + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake'></span></div></td>" +//intake
                "<td class='durationNum' style='width:5%' ><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DAYS"] + "</a></td>" +
                "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DURATION"] + "</a></td>" +
                "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + DurgID + "' style='display:none;font-size:14px'>" + food + "</a></td>";

            if (result[i]["ROUTE"].toString().trim() != "") {

                if ($("div#layer-Route #" + result[i]["ROUTE"] + "").length > 0)
                    routeText = $("div#layer-Route #" + result[i]["ROUTE"] + "").text();

                NonFrqRows += "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["ROUTE"].toString().trim() + "'/></td>";
            }
            else {
                NonFrqRows += "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>Per oral</a><input type='hidden' id='hdn" + DurgID + "' value='09' /></td>";
            }

            NonFrqRows += "<td class='tdDosses' style='width:8%'><input type='text'class='triggerInputDosses form-control'  style='display:none;' placeholder='Dose' value='" + result[i]["DOSSAGE"].trim() + "' id='dossage" + DurgID + "' /></td>"; //dosses

            if (result[i]["QTY"] != undefined && result[i]["QTY"] != null) {
                NonFrqRows += "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' value='" + result[i]["DOSSAGE"].trim() + "' id='dossage" + DurgID + "' /></td>";
            }
            else {
                var qty = "";
                NonFrqRows += "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' value='" + qty + "' id='Qty" + DurgID + "' /></td>";
            }

            if (result[i]["Remarks"].toString().trim() != "") {

                if ($("div#layer-Remark #" + result[i]["Remarks"] + "").length > 0)
                    remarkText = $("div#layer-Remark #" + result[i]["Remarks"] + "").text();

                NonFrqRows += "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["Remarks"].toString().trim() + "'/></td>";
            }
            else {
                NonFrqRows += "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + DurgID + "' /></td>";
            }

            NonFrqRows += "<td class='tdDrugCode' style='display:none'>" + (result[i]["DRUGCD"]) + "</td>";//vijeta 4/5/19


            NonFrqRows += "<td class='setupyn' style='display:none'>" + result[i]["SETUPYN"].trim() + "</td>";
            NonFrqRows += "<td class='refillyn' style='display:none'>" + result[i]["REFILLYN"].trim() + "</td>";

            NonFrqRows += "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>";
            NonFrqRows += "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

            if (result[i]["ROUTINEYN"] != "" && result[i]["ROUTINEYN"] != null && ShowroutineFeature == "Y") {
                var RoutineMed;
                if (result[i]["ROUTINEYN"].toString() == "Y")
                    RoutineMed = true;
                else
                    RoutineMed = false;
                NonFrqRows += "<td class='tdRoutineMed' style='width:8%'><input type='checkbox'  style='display:none;'  checked='" + RoutineMed + "' id='chkRoutineMed" + DurgID + "' /></td>";
            }
            else if (ShowroutineFeature == "Y") {
                NonFrqRows += "<td class='tdRoutineMed' style='width:8%'><input type='checkbox' style='display:none;' id='chkRoutineMed" + DurgID + "' /></td>";
            }

            if (result[i]["SETUPYN"].trim() == "N")
                NonFrqRows += "<td class='tdStatus' style='display:none'>A</td>"; //Added by Murali on 17/06/2024
            else {
                if (result[i]["PHSTATUS"] == undefined)
                    NonFrqRows += "<td class='tdStatus' style='display:none'>A</td>"; //Added by Murali on 17/06/2024
                else
                    NonFrqRows += "<td class='tdStatus' style='display:none'>" + result[i]["PHSTATUS"].trim() + "</td>"; //Added by Murali on 17/06/2024
            }

            NonFrqRows += "</tr>";
            $('#tblMaterialList tbody').prepend(NonFrqRows).closest('tr');
            $('#tblMaterialList tr#' + DurgID).trigger('click');
            ShowroutineFeature == "Y" ? $("#chkRoutineMed" + DurgID)[0].checked = (result[i]["ROUTINEYN"] == undefined ? false : (result[i]["ROUTINEYN"].toString() == "Y" ? true : false)) : "";
        }
        else {
            if ($('#tblMaterialList tr#' + DurgID + "").length == 0 && tamperYn == "N") {
                var medname = $.trim(result[i].DRUGNM);
                if ($.trim(result[i].DRUGNM) != "") {
                    medname = $.trim(result[i].DRUGNM) + " (" + $.trim(result[i].GENERICNAME) + ")";
                }
                DurgID = DurgID.replace(/\//g, '');
                NonFrqRows += "<tr  class='" + DurgID + "' id='" + $.trim(DurgID) + "'>" +

                    "<td class='MaterialName' style='width:25%'>" + medname + "</td><td class='GenriName' style='display:none'>" + $.trim(result[i].GENERICNAME) + "</td><td class='GenricID' style='display:none'>" + $.trim(result[i].GENERICID) + "</td>" +
                    "<td style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td>" +
                    "<td class='MedDate' style='width:7%' ><a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + DurgID + "' style='display:none;font-size:14px'>" + SDate + "</a></td>" + //Added By Rajan - For MedDate
                    "<td class='tdIntake' style='width:12.9%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' value='" + result[i]["INTAKEDESC"].trim() + "' id='intake" + DurgID + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake'></span></div></td>" +//intake
                    "<td class='durationNum' style='width:5%' ><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DAYS"] + "</a></td>" +
                    "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DURATION"] + "</a></td>" +
                    "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + DurgID + "' style='display:none;font-size:14px'>" + food + "</a></td>";

                if (result[i]["ROUTE"].toString().trim() != "") {

                    var routeText = "Route";
                    if ($("div#layer-Route #" + result[i]["ROUTE"] + "").length > 0)
                        routeText = $("div#layer-Route #" + result[i]["ROUTE"] + "").text();

                    NonFrqRows += "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["ROUTE"].toString().trim() + "'/></td>";
                }
                else {
                    NonFrqRows += "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>Per oral</a><input type='hidden' id='hdn" + DurgID + "' value='09'/></td>";
                }

                NonFrqRows += "<td class='tdDosses' style='width:8%'><input type='text'class='triggerInputDosses form-control'  style='display:none;' placeholder='Dose' value='" + result[i]["DOSSAGE"].trim() + "' id='dossage" + DurgID + "' /></td>"; //dosses

                if (result[i]["QTY"] != undefined && result[i]["QTY"] != null) {
                    NonFrqRows += "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' value='" + result[i]["QTY"].trim() + "' id='Qty" + DurgID + "' /></td>";
                }
                else {
                    var qty = "";
                    NonFrqRows += "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' value='" + qty + "' id='Qty" + DurgID + "' /></td>";
                }

                if (result[i]["Remarks"].toString().trim() != "") {

                    var remarkTex = "Remark";
                    if ($("div#layer-Remark #" + result[i]["Remarks"] + "").length > 0)
                        remarkText = $("div#layer-Remark #" + result[i]["Remarks"] + "").text();

                    NonFrqRows += "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["Remarks"].toString().trim() + "'/></td>";
                }
                else {
                    NonFrqRows += "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + DurgID + "' /></td>";
                }

                NonFrqRows += "<td class='tdDrugCode' style='display:none'>" + (result[i]["DRUGCD"]).trim() + "</td>";//vijeta 4/5/19

                NonFrqRows += "<td class='setupyn' style='display:none'>" + result[i]["SETUPYN"].trim() + "</td>";
                NonFrqRows += "<td class='refillyn' style='display:none'>" + result[i]["REFILLYN"].trim() + "</td>";

                NonFrqRows += "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>";
                NonFrqRows += "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                if (result[i]["ROUTINEYN"] != "" && result[i]["ROUTINEYN"] != null && ShowroutineFeature == "Y") {
                    var RoutineMed;
                    if (result[i]["ROUTINEYN"].toString() == "Y")
                        RoutineMed = true;
                    else
                        RoutineMed = false;
                    NonFrqRows += "<td class='tdRoutineMed' style='width:8%'><input type='checkbox'  style='display:none;'  checked='" + RoutineMed + "' id='chkRoutineMed" + DurgID + "' /></td>";
                }
                else if (ShowroutineFeature == "Y") {
                    NonFrqRows += "<td class='tdRoutineMed' style='width:8%'><input type='checkbox' style='display:none;' id='chkRoutineMed" + DurgID + "' /></td>";
                }

                if (result[i]["SETUPYN"].trim() == "N")
                    NonFrqRows += "<td class='tdStatus' style='display:none'>A</td>"; //Added by Murali on 17/06/2024
                else {
                    if (result[i]["PHSTATUS"] == undefined)
                        NonFrqRows += "<td class='tdStatus' style='display:none'>A</td>"; //Added by Murali on 17/06/2024
                    else
                        NonFrqRows += "<td class='tdStatus' style='display:none'>" + result[i]["PHSTATUS"].trim() + "</td>"; //Added by Murali on 17/06/2024
                }

                NonFrqRows += "</tr>";
                $('#tblMaterialList tbody').prepend(NonFrqRows).closest('tr');
                $('#tblMaterialList tr#' + DurgID).trigger('click');
                ShowroutineFeature == "Y" ? $("#chkRoutineMed" + DurgID)[0].checked = (result[i]["ROUTINEYN"] == undefined ? false : (result[i]["ROUTINEYN"].toString() == "Y" ? true : false)) : "";
            }
        }
    }
}

//Added on 13/03/2024 by Murali
function RxDesktopRoutineMed(result) {
    for (var i = 0; i < result.length; i++) {
        var NonFrqRows = '';
        var DurgID = (result[i]["CODE"]).replace(/[^0-9a-zA-Z]/gi, '');
        //Added by Tejashri 26/12/2018
        var food = '';
        if (result[i]["FOOD"] == "E")
            food = "B";
        else if (result[i]["FOOD"] == "-")
            food = "-";
        else
            food = "A";
        //End
        var NonFrqRows = '';

        //var tamperYn = (result[i]["TAMPERYN"]).toString();//vijeta 12/4/19
        var SDate = result[i]["MEDSTARTDATE"] == "" || result[i]["MEDSTARTDATE"] == undefined ? "-" : ConvertDateFormat(result[i]["MEDSTARTDATE"]);
        if ($('#tblMaterialList tr#' + DurgID + "").length > 0 && !$('#tblMaterialList tr#' + DurgID + "").hasClass("active")) { //&& tamperYn == "N"

            $('#tblMaterialList tr#' + DurgID + ' td.tdIntake')[0].innerHTML = "<div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' value='" + result[i]["INTAKE"].trim() + "' id='intake" + DurgID + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake'></span></div>";//intake 
            $('#tblMaterialList tr#' + DurgID + ' td.durationNum')[0].innerHTML = "<a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DAYS"] + "</a>";
            $('#tblMaterialList tr#' + DurgID + ' td.durationWord')[0].innerHTML = "<a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DURATION"] + "</a>";
            $('#tblMaterialList tr#' + DurgID + ' td.tdBeforeAfter')[0].innerHTML = "<a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + DurgID + "' style='display:none;font-size:14px'>" + food + "</a>";
            $('#tblMaterialList tr#' + DurgID + ' td.tdDosses')[0].innerHTML = "<input type='text' class='triggerInputDosses form-control' style='display:none;' placeholder='Dose' value='" + result[i]["DOSAGE"].trim() + "' id='dossage" + DurgID + "' />";
            $('#tblMaterialList tr#' + DurgID + ' td.MedDate')[0].innerHTML = "<a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + DurgID + "' style='display:none;font-size:14px'>" + SDate + "</a>";//Added By Rajan - For MedDate


            if (result[i]["QTY"] != undefined && result[i]["QTY"] != null) {
                $('#tblMaterialList tr#' + DurgID + ' td.tdQty')[0].innerHTML = "<input type='text' class='triggerInputQty form-control' style='display:none;' placeholder='Qty' value='" + result[i]["QTY"].trim() + "' id='Qty" + DurgID + "' />";
            }
            else {
                var qty = "";
                $('#tblMaterialList tr#' + DurgID + ' td.tdQty')[0].innerHTML = "<input type='text' class='triggerInputQty form-control' style='display:none;' placeholder='Qty' value='" + qty + "' id='Qty" + DurgID + "' />";
            }
            if (result[i]["ROUTE"].toString().trim() != "" && result[i]["ROUTE"].toString().trim() != null) {

                var routeText = "Route";

                if ($("#layer-Route #" + result[i]["ROUTE"] + "").length > 0)
                    routeText = $("#layer-Route #" + result[i]["ROUTE"] + "").text();

                $('#tblMaterialList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["ROUTE"] + "' />";
            }
            else {
                $('#tblMaterialList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>Per oral</a><input type='hidden' id='hdn" + DurgID + "' value ='09' />";
            }

            if (result[i]["REMARK"].toString().trim() != "") {

                var remarkText = "Remark";

                if ($("#layer-Remark #" + result[i]["REMARK"] + "").length > 0)
                    remarkText = $("#layer-Remark #" + result[i]["REMARK"] + "").text();

                $('#tblMaterialList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["REMARK"] + "' />";//4/12/19
            }
            else {
                $('#tblMaterialList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + DurgID + "'  />";//4/12/19
            }

            $('#tblMaterialList tr#' + DurgID + ' td.tdDrugCode')[0].innerText = (result[i]["CODE"]).trim(); //vijeta 4/5/19

            //added 29/6/19
            //$('#tblMaterialList tr#' + DurgID + ' td.setupyn')[0].innerHTML = result[i]["SETUPYN"].trim();
            //$('#tblMaterialList tr#' + DurgID + ' td.refillyn')[0].innerHTML = result[i]["REFILLYN"].trim();

            $('#tblMaterialList tr#' + DurgID + ' td.sortTD1')[0].innerHTML = "<a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a>";
            $('#tblMaterialList tr#' + DurgID + ' td.sortTD2')[0].innerHTML = "<a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a>";

            if (result[i]["ROUTINEYN"] != "" && result[i]["ROUTINEYN"] != null) {
                var RoutineMed;
                if (result[i]["ROUTINEYN"].toString() == "Y")
                    RoutineMed = true;
                else
                    RoutineMed = false;
                ShowroutineFeature == "Y" ? $('#tblMaterialList tr#' + DurgID + ' td.tdRoutineMed')[0].innerHTML = "<input type='checkbox'  style='display:none;'  checked='" + RoutineMed + "' id='chkRoutineMed" + DurgID + "' />" : "";
            }
            else {
                $('#tblMaterialList tr#' + DurgID + ' td.tdQty')[0].innerHTML = "<input type='checkbox' style='display:none;' id='chkRoutineMed" + DurgID + "' />";
            }

            //$('#tblMaterialList tr#' + DurgID + ' td.tdStatus')[0].innerText = (result[i]["PHSTATUS"]).trim(); //Added by Murali on 17/06/2024
            $('#tblMaterialList tr#' + DurgID + ' td.tdStatus')[0].innerText = "A"; //Added by Murali on 19/06/2024

            $('#tblMaterialList tr#' + DurgID).trigger('click');
        }
        else {
            if ($('#tblMaterialList tr#' + DurgID + "").length == 0 && tamperYn == "N") {
                var medname = $.trim(result[i].NAME);
                if ($.trim(result[i].NAME) != "") {
                    medname = $.trim(result[i].NAME) + " (" + $.trim(result[i].GENERICNAM) + ")";
                }
                DurgID = DurgID.replace(/\//g, '');
                NonFrqRows += "<tr  class='" + DurgID + "' id='" + $.trim(DurgID) + "'>" +

                    "<td class='MaterialName' style='width:25%'>" + medname + "</td><td class='GenriName' style='display:none'>" + $.trim(result[i].GENERICNAM) + "</td><td class='GenricID' style='display:none'>" + $.trim(result[i].GENERICID) + "</td>" +//
                    "<td style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td>" +
                    "<td class='MedDate' style='width:7%' ><a class='triggerMedDate' href='javascript:;' data-layer-id='layer-MedDate' id='MedDate" + DurgID + "' style='display:none;font-size:14px'>" + SDate + "</a></td>" + //Added By Rajan - For MedDate
                    "<td class='tdIntake' style='width:12.9%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' value='" + result[i]["INTAKE"].trim() + "' id='intake" + DurgID + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake'></span></div></td>" +//intake
                    "<td class='durationNum' style='width:5%' ><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DAYS"] + "</a></td>" +
                    "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DURATION"] + "</a></td>" +
                    "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + DurgID + "' style='display:none;font-size:14px'>" + food + "</a></td>";

                if (result[i]["ROUTE"].toString().trim() != "") {

                    var routeText = "Route";
                    if ($("div#layer-Route #" + result[i]["ROUTE"] + "").length > 0)
                        routeText = $("div#layer-Route #" + result[i]["ROUTE"] + "").text();

                    NonFrqRows += "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["ROUTE"].toString().trim() + "'/></td>";
                }
                else {
                    NonFrqRows += "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>Per oral</a><input type='hidden' id='hdn" + DurgID + "' value='09'/></td>";
                }

                NonFrqRows += "<td class='tdDosses' style='width:8%'><input type='text'class='triggerInputDosses form-control'  style='display:none;' placeholder='Dose' value='" + result[i]["DOSAGE"].trim() + "' id='dossage" + DurgID + "' /></td>"; //dosses

                if (result[i]["QTY"] != undefined && result[i]["QTY"] != null) {
                    NonFrqRows += "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' value='" + result[i]["QTY"].trim() + "' id='Qty" + DurgID + "' /></td>";
                }
                else {
                    var qty = "";
                    NonFrqRows += "<td class='tdQty' style='width:8%'><input type='text'class='triggerInputQty form-control'  style='display:none;' placeholder='Qty/Nos.' value='" + qty + "' id='Qty" + DurgID + "' /></td>";
                }

                if (result[i]["REMARK"].toString().trim() != "") {

                    var remarkTex = "Remark";
                    if ($("div#layer-Remark #" + result[i]["REMARK"] + "").length > 0)
                        remarkText = $("div#layer-Remark #" + result[i]["REMARK"] + "").text();

                    NonFrqRows += "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["REMARK"].toString().trim() + "'/></td>";
                }
                else {
                    NonFrqRows += "<td class='tdRemark' style='width:16%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + DurgID + "' /></td>";
                }

                NonFrqRows += "<td class='tdDrugCode' style='display:none'>" + (result[i]["CODE"]).trim() + "</td>";//vijeta 4/5/19

                //NonFrqRows += "<td class='setupyn' style='display:none'>" + result[i]["SETUPYN"].trim() + "</td>";
                //NonFrqRows += "<td class='refillyn' style='display:none'>" + result[i]["REFILLYN"].trim() + "</td>";

                NonFrqRows += "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>";
                NonFrqRows += "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                if (result[i]["ROUTINEYN"] != "" && result[i]["ROUTINEYN"] != null) {
                    var RoutineMed;
                    if (result[i]["ROUTINEYN"].toString() == "Y")
                        RoutineMed = true;
                    else
                        RoutineMed = false;
                    NonFrqRows += "<td class='tdRoutineMed' style='width:8%'><input type='checkbox'  style='display:none;'  checked='" + RoutineMed + "' id='chkRoutineMed" + DurgID + "' /></td>";
                }
                else {
                    NonFrqRows += "<td class='tdRoutineMed' style='width:8%'><input type='checkbox' style='display:none;' id='chkRoutineMed" + DurgID + "' /></td>";
                }

                //NonFrqRows += "<td class='tdStatus' style='display:none'>" + (result[i]["PHSTATUS"]).trim() + "</td>";//Added By Murali on 17/06/2024
                NonFrqRows += "<td class='tdStatus' style='display:none'>A</td>";//Added By Murali on 19/06/2024

                NonFrqRows += "</tr>";
                $('#tblMaterialList tbody').prepend(NonFrqRows).closest('tr');
                $('#tblMaterialList tr#' + DurgID).trigger('click');
            }
        }
    }
}

$(document.body).on('click', '#tblPatAdviceStUps tr', function (e) {
    //var strUrl = "";
    var strUrl = "../DoctorDesk/GetAdvicesBySetUpCode";
    var page = window.location.href;
    var tableId = "";
    var strType = "";

    if (page.indexOf("PatientAdvice") != -1) {

        tableId = "tblpatadv";
        strType = "P";
    }

    else if (page.indexOf("InvestigationTran") != -1) {

        tableId = "tblinvestigate";
        strType = "I";
    }

    else if (page.indexOf("RxDesktop") != -1) {

        tableId = "tblMaterialList";
        strType = "A";
    }
    else if (page.indexOf("RxNewSearch") != -1) {

        tableId = "tblMedicineList";
        strType = "A";
    }

    var activeFlag = true;
    var strCode = $(this)[0].id;

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {
        $(this)[0].bgColor = 'lightgray';

    }
    else {
        $(this)[0].bgColor = '';
        activeFlag = false;
    }

    var strSetUpCodeLst = [];
    $.each($('#tblPatAdviceStUps tr.active'), function (i, val) {
        strSetUpCodeLst.push($(this)[0].id);
    });

    var freeText = "";

    if (strSetUpCodeLst.length > 0) {
        $.ajax({
            datatype: 'json',
            type: 'post',
            url: strUrl,
            data: { strCode: strSetUpCodeLst.join(","), strType: strType },
            success: function (response) {
                if (response != "Unsucessfull") {
                    var result = JSON.parse(response);

                    if (strType == "A") {
                        if (!activeFlag) {
                            $.ajax({
                                datatype: 'json',
                                type: 'post',
                                url: strUrl,
                                data: { strCode: strCode, strType: strType },
                                success: function (response) {
                                    if (response != "Unsucessfull") {
                                        var result1 = JSON.parse(response);


                                        for (var i = 0; i < result1.length; i++) {
                                            var DurgID = (result1[i]["DRUGCD"]).replace(/[^0-9a-zA-Z]/gi, '');
                                            if ($('#' + tableId + ' tr#' + DurgID + "").length > 0 && $('#' + tableId + ' tr#' + DurgID + "").hasClass("active")) {
                                                $('#' + tableId + ' tr#' + DurgID).trigger('click');
                                            }
                                            else if ($('#' + tableId + ' tr#' + DurgID + "").length == 0 && $('#' + tableId + ' tr#' + DurgID + "").hasClass("active")) {

                                            }
                                        }
                                    }

                                },
                                complete: function () {
                                    if (page.indexOf("RxDesktop") != -1) {
                                        RxDesktopSetData(result);
                                    } else if (page.indexOf("RxNewSearch") != -1) {

                                        RxNewSetData(result);
                                    }
                                }
                            });
                        }

                        if (page.indexOf("RxDesktop") != -1) {
                            RxDesktopSetData(result);
                        } else if (page.indexOf("RxNewSearch") != -1) {

                            RxNewSetData(result);
                        }

                    }
                    else {

                        if (!activeFlag) {
                            $.ajax({
                                datatype: 'json',
                                type: 'post',
                                url: strUrl,
                                data: { strCode: strCode, strType: strType },
                                success: function (response) {
                                    if (response != "Unsucessfull") {
                                        var result1 = JSON.parse(response);


                                        for (var i = 0; i < result1.length; i++) {
                                            var CODE = (result1[i]["CODE"]).replace(/[^0-9a-zA-Z]/gi, '');
                                            if (CODE.trim() != "") {
                                                if ($('#' + tableId + ' tr#' + CODE + "").length > 0 && $('#' + tableId + ' tr#' + CODE + "").hasClass("active")) {
                                                    $('#' + tableId + ' tr#' + CODE).trigger('click');
                                                }
                                                else if ($('#' + tableId + ' tr#' + CODE + "").length == 0 && $('#' + tableId + ' tr#' + CODE + "").hasClass("active")) {

                                                }
                                            }
                                            else {
                                                if (strType == "I") {
                                                    freeText = freeText + result1[i]["NAME"].trim() + ", ";
                                                }

                                            }

                                        }
                                        freeHandInvestigation = (freeHandInvestigation != "") ? freeHandInvestigation + ", " + freeText.slice(0, -2) : freeText.slice(0, -2);
                                        if (freeHandInvestigation != "") {
                                            CallFreeHandBtn();
                                        }
                                    }

                                },
                                complete: function () {
                                    $.each(result, function (i, val) {
                                        if ((val.CODE).trim() != "") {
                                            if (!$('#' + tableId + ' tr#' + val.CODE + '').hasClass("active"))
                                                $('#' + tableId + ' tr#' + val.CODE + '').trigger("click");
                                        }
                                        if (strType == "I") {
                                            freeText = freeText + (val.NAME).trim() + ", ";
                                        }
                                    });
                                    freeHandInvestigation = (freeHandInvestigation != "") ? freeHandInvestigation + ", " + freeText.slice(0, -2) : freeText.slice(0, -2);
                                    if (freeHandInvestigation != "") {
                                        CallFreeHandBtn();
                                    }
                                }
                            });
                        }
                        $.each(result, function (i, val) {
                            if ((val.CODE).trim() != "") {
                                if (!$('#' + tableId + ' tr#' + val.CODE + '').hasClass("active"))
                                    $('#' + tableId + ' tr#' + val.CODE + '').trigger("click");
                            }
                            else {
                                if (strType == "I") {
                                    freeText = freeText + (val.NAME).trim() + ", ";
                                }
                            }
                        });

                        freeHandInvestigation = (freeHandInvestigation != "") ? freeHandInvestigation + ", " + freeText.slice(0, -2) : freeText.slice(0, -2);
                        if (freeHandInvestigation != "") {
                            CallFreeHandBtn();
                        }
                    }
                }
            }
        });
    }
    else {

        if (strType == "A") {

            $.ajax({
                datatype: 'json',
                type: 'post',
                url: strUrl,
                data: { strCode: strCode, strType: strType },
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        for (var i = 0; i < result.length; i++) {
                            var DurgID = (result[i]["DRUGCD"]).replace(/[^0-9a-zA-Z]/gi, '');
                            if ($('#' + tableId + ' tr#' + DurgID + "").length > 0 && $('#' + tableId + ' tr#' + DurgID + "").hasClass("active")
                                && $('#' + tableId + ' tr#' + DurgID + " .tdStatus")[0].innerText == "A") {
                                $('#' + tableId + ' tr#' + DurgID).trigger('click');
                            }
                            else if ($('#' + tableId + ' tr#' + DurgID + "").length == 0 && $('#' + tableId + 'tr#' + DurgID + "").hasClass("active")) {
                            }
                        }
                    }
                }
            });
        }
        else {

            $.ajax({
                datatype: 'json',
                type: 'post',
                url: strUrl,
                data: { strCode: strCode, strType: strType },
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);


                        for (var i = 0; i < result.length; i++) {
                            var CODE = (result[i]["CODE"]).replace(/[^0-9a-zA-Z]/gi, '');
                            if (CODE.trim() != "") {
                                if ($('#' + tableId + ' tr#' + CODE + "").length > 0 && $('#' + tableId + ' tr#' + CODE + "").hasClass("active")) {
                                    $('#' + tableId + ' tr#' + CODE).trigger('click');
                                }
                                else if ($('#' + tableId + ' tr#' + CODE + "").length == 0 && $('#' + tableId + ' tr#' + CODE + "").hasClass("active")) {

                                }
                            }
                            else {
                                if (strType == "I") {
                                    freeText = freeText + (result[i]["NAME"]).trim() + ", ";
                                }
                            }
                        }
                        freeHandInvestigation = freeText;
                        if (freeHandInvestigation != "") {
                            CallFreeHandBtn();
                        }
                    }

                }
            });
        }
    }

});

function CallFreeHandBtn() {
    $("#freeHandBtn").trigger("click");
    $("#freeHandBtn").css("background-color", "green");
}

function RedirectToAddPatient() {
    window.location.href = "../DoctorDesk/AddPatient?FromTriage=N"; //Added FromTriage condition by Murali on 23/05/2024
}

function PatientSearch() {
    // Declare variables 
    var input, filter, table, tr, td, i;
    // input = document.getElementById("txtPatientSearch");
    // filter = input.value.toUpperCase();
    filter = $('#divPatientSearch input[type="text"]').val().toUpperCase();
    table = document.getElementById("DivPatGrid");
    tr = table.getElementsByTagName("li");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        $(tr[i]).removeClass('display');
        td = tr[i].getElementsByTagName("label")[1];
        if (td) {
            if (td.innerHTML.toUpperCase().indexOf(filter) > -1 || tr[i].childNodes[1].id == filter) {
                tr[i].style.display = "";
                if (!$(tr[i]).hasClass('display')) {
                    $(tr[i]).addClass('display')
                }
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function PatientSearchNotAppointed() {
    var strMrOrname = $("#txtPatSearchNotAppntd").val();
    HoldOn.open();
    $.ajax({
        url: '../DoctorDesk/SearchNotAppointedPatients',
        data: { strMrName: strMrOrname },
        type: 'post',
        datatype: 'json',
        success: function (data) {
            $("#tblPatList").empty();
            $("#tblRefDoctor").empty(); $("#ReferDrPanel").css('display', 'none');
            if (data != "") {

                $.each(data, function (i, val) {
                    var row = "<tr style='border-bottom:1px solid #dedada' id='" + val.MRNO + "'>" +
                        "<td><label style='font-size:12px;font-weight:normal'>" + val.NAME + "</label>" +
                        "<input type='hidden' class='dobCls' value='" + val.PATDOB + "' />" +   // DOB Added by Murali on 02/08/2024
                        "<input type='hidden' class='ageCls' value='" + val.AGE + "' /><input type='hidden' class='genderCls' value='" + val.GENDER + "' />" +
                        "<input type='hidden' class='mobileCls' value='" + val.MOBILE + "' /><input type='hidden' class='emailCls' value='" + val.EMAIL + "' />" +
                        "<input type='hidden' class='tokenCls' value='" + val.CONTOKNO + "' /><input type='hidden' class='consNoCls' value='" + val.CONSNO + "' />" +
                        "<input type='hidden' class='refDoctCls' value='" + val.REFDOCTNM + "' /><input type='hidden' class='refcontactNoCls' value='" + val.REFDOCTCONTACT + "' />" +
                        "</td></tr>";
                    $("#tblPatList").append(row);
                });
                HoldOn.close();
            }
            else {
                $("#tblPatList").empty();
                $("#lblmsg").css('display', 'block');
            }
            HoldOn.close();
        },
        error: function () {
            HoldOn.close();
        },
    })
}

$(document.body).on('click', '#tblPatList tr', function (e) {
    var name = $(this).find('label')[0].innerText;
    var age = $(this).find('input.ageCls')[0].value;
    var Dob = $(this).find('input.dobCls')[0].value;//Added by Murali on 02/08/2024
    var gender = $(this).find('input.genderCls')[0].value;
    var mrNo = $(this)[0].id;
    //var tranNo = e.currentTarget.children[6].defaultValue;
    var strMobile = $(this).find('input.mobileCls')[0].value;

    var strAge = "";
    var strGender = "";
    var strPatEmail = $(this).find('input.emailCls')[0].value;

    var refDoctNm = $(this).find('input.refDoctCls')[0].value;
    var refDoctContactNo = $(this).find('input.refcontactNoCls')[0].value;

    strAge = Number(age.split(":")[0]) > 0 ? Number(age.split(":")[0]) + " Yrs" : Number(age.split(":")[1]) > 0 ? Number(age.split(":")[1]) + " Months" : Number(age.split(":")[2]) + " Days"
    //strAge = (age.charAt(0) == "0") ? $(this).find('input.ageCls')[0].value.toString().substr(1, 2) + "Yrs" : $(this).find('input.ageCls')[0].value.toString().substr(0, 3) + "Yrs";
    strGender = (gender == "M") ? "Male" : "Female";
    sessionStorage.setItem('PatName', name);
    sessionStorage.setItem('PatAge', strAge);
    sessionStorage.setItem('PatGender', strGender);
    sessionStorage.setItem('PatMobile', strMobile);
    sessionStorage.setItem('PatAge2', age);
    sessionStorage.setItem('PatDOB', Dob); //Added by Murali on 02/08/2024
    sessionStorage.setItem('PatMRNO', mrNo);
    sessionStorage.setItem('PatTRANNO', "");
    sessionStorage.setItem('PatCompleted', "N");
    sessionStorage.setItem('PatSelected', "NotAppointed");
    sessionStorage.setItem('OutRefDrNm', refDoctNm);
    sessionStorage.setItem('OutRefDrContact', refDoctContactNo);
    sessionStorage.setItem('PatEmail', strPatEmail);
    //sessionStorage.setItem('ManDiag', 0);
    //sessionStorage.setItem('ICDDiag', 0);
    //sessionStorage.setItem('ProvDiag', 0);
    var strToken = $(this).find('input.tokenCls')[0].value;
    sessionStorage.setItem('TokenNo', strToken);
    var strConsNo = $(this).find('input.consNoCls')[0].value;
    sessionStorage.setItem('ConsltnNo', strConsNo);

    SetPatientDtl();


    if ($.session.get('OutRefDrNm') != "" && sessionStorage.getItem('OutRefDrNm') != undefined) {
        $("#ReferDrPanel").css('display', 'block');
    } else {
        $("#ReferDrPanel").css('display', 'none');
    }

    if (window.location.href.includes("PAC"))
        window.location.href = '../DoctorDesk/PAC?PatMRNO=' + mrNo + '&PatTRANNO=' + strConsNo;
    else
        window.location.href = 'PatientEntry';
});

function CheckPatMRNotEmpty() {
    var mrNo = sessionStorage.getItem('PatMRNO');
    //var patDob =sessionStorage.getItem('PatDOB');
    if (mrNo != undefined) {
        return true;
    }
    //else if (patDob != undefined) {
    //    return true;
    //}
    else
        return false;
}

$("#tabMenuUl li").click(function (e) {
    var page = window.location.href;
    var ActiveTab = sessionStorage.getItem('activeTab');
    if (page.indexOf("Diagnosis") != -1 && ActiveTab == "ICDDiagO") {
        if (EditICDOFlag == true) {
            ValidationForICDODiag();
            if (AllowSaveDiagnosis != true) {
                e.preventDefault();
                return;
            }
            SaveForAllShortCutMenus(e);
        }
    }
    else {
        SaveForAllShortCutMenus(e);

    }
});

$(document).ready(function (e) {
    var urls = "../Account/GetDctrClinic";
    $("#lblAppToday").click(function (e) {
        addremovecss("lblAppToday");
        AddClinics(urls);
        $("#patList").show();
        $("#patDList").hide();
    });

    $("#lblAppTommorow").click(function (e) {
        clearData();
        addremovecss("lblAppTommorow");
        AddClincCode(urls, null, "ATMW");
    });

    $("#lblSurToday").click(function (e) {
        clearData();
        addremovecss("lblSurToday");
        AddClincCode(urls, null, "ST");
    });

    $("#lblSurTommorow").click(function (e) {
        clearData();
        addremovecss("lblSurTommorow");
        AddClincCode(urls, null, "STMW");
    });
    if ($(window).width() < 996) {  //screen width size comparion
        $("#divPatBindGrid").css({ "margin-top": "10px", "height": "35px", "text-align": "center" });
    }
    else {
        $("#divPatBindGrid").css({ "margin-top": "56px", "height": "35px", "text-align": "center" });
    }
    function toggleIcon(e) {
        $(e.target)
            .prev('.panel-heading')
            .find(".more-less")
            .toggleClass('fa-plus fa-minus');
        $(document).find("[href='#" + $(e.target).attr('id') + "']")
    }
    $('#PatListPanelDiv').on('hidden.bs.collapse', toggleIcon);
    $('#PatListPanelDiv').on('shown.bs.collapse', toggleIcon);
});
var prev = "lblAppToday"; var flg = 0;
function addremovecss(lblids) {
    var header = document.getElementById("divtabs");
    var btns = header.getElementsByClassName("lbls");
    for (var i = 0; i < btns.length; i++) {
        //  btns[i].addEventListener("click", function() {
        if (btns[i].id == lblids) {
            $("#" + lblids).addClass("lblActive");
        }
    }
    if ((prev != "")) {
        $("#" + prev).removeClass("lblActive");
    }
    prev = lblids;
    // flg = 1;
}

function clearData() {
    //  $("#patDList").empty();
    $("#patDList").show();
    //  $("#patList").empty();
    $("#patList").hide();
}

function AddClincCode(urls, flag, appNsurType) {
    if (typeof flag === "undefined" || flag === null) {
        flag = "N";
    }
    // style = 'height:35px;text-align:center'

    $.ajax({
        type: "POST",
        url: urls,
        data: {},
        success: function (result) {

            if (result.length > 0) {
                $("#btnsDiv").empty();
                $.each(result, function (index, value) {
                    var $newDiv = $('<div>');
                    $newDiv.addClass("btn-group");

                    var test = $('<button/>',
                        {
                            text: result[index].Text,
                            id: result[index].Value,
                            style: ' background-color:transparent;margin-right: 2px;color: black;font-weight:bold;border: 1px solid transparent;font-size: 10px; white-space: normal;width: 100%; ',
                            class: 'btn btn-primary',
                            click: function () {
                                PatLstFunction(result[index].Value, appNsurType);
                                sessionStorage.setItem('ClinicCode', result[index].Value);
                                sessionStorage.setItem("ClinicName", result[index].Text);
                                btnclk(this);
                            }
                        });
                    $newDiv.append(test);
                    $("#btnsDiv").append($newDiv);
                    //$("#btnsDiv").append(test);

                    btnID = result[index].Value;
                });
            }
            else {
                $('#DivDPatGrid').empty();
                var $NoPatientsDiv = $('<div>', { style: ' text-align: center;font-size:14px;background-color: #d2d6de;margin-top:19px;' });
                var $lbl = $('<label>', { style: 'margin-top: 2px;' }).html('No Patients');
                $NoPatientsDiv.append($lbl);
                $('#DivDPatGrid').append($NoPatientsDiv);
            }
            // $('#btnsDiv').css("background", "#378000");
            //});
        },
        complete: function (jqXHR, status) {
            if (status == "success") {

                if (jqXHR.responseJSON.length > 0) {

                    var clncCode = sessionStorage.getItem('ClinicCode');
                    if (clncCode == null || clncCode == "")
                        $("#" + jqXHR.responseJSON[0].Value).trigger('click');
                    else
                        $("#" + clncCode).trigger('click');
                }
            }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        }
    });
    // }
}

var AppTom = {
    Result: [
        { CONSNO: "12C190215JU0002", MRNO: "123", ConsDate: "16/02/2019", ConsTime: "10:16:54", PatName: "Mrs.Jigna  Upadhyay", DOB: "20/06/1981", Age: "035:10:02", Gender: "F", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0003", MRNO: "456", ConsDate: "16/02/2019", ConsTime: "11:10:00", PatName: "Mr.Sushil Shendge", DOB: "18/04/1991", Age: "035:10:02", Gender: "M", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0004", MRNO: "789", ConsDate: "16/02/2019", ConsTime: "01:15:00", PatName: "Miss.Kavita", DOB: "24/05/1995", Age: "035:10:02", Gender: "F", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0005", MRNO: "987", ConsDate: "16/02/2019", ConsTime: "12:20:00", PatName: "Mrs.Aditya Thakkar", DOB: "02/07/1981", Age: "035:10:02", Gender: "F", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0006", MRNO: "654", ConsDate: "16/02/2019", ConsTime: "02:16:00", PatName: "Mr.Jignesh", DOB: "10/01/1986", Age: "035:10:02", Gender: "M", APPTTM: "", MobileNo: "8160422789", DIFFTM: "-1", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0007", MRNO: "321", ConsDate: "16/02/2019", ConsTime: "03:20:00", PatName: "Mr.Kartik Kumar", DOB: "20/09/1971", Age: "035:10:02", Gender: "M", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
    ]
};
var SurToday = {
    Result: [
        { CONSNO: "12C190215JU0002", MRNO: "123", ConsDate: "15/02/2019", ConsTime: "10:16 AM", SurgeryNm: "Appendictis", PatName: "Mr.Tushar Kadam", DOB: "20/06/1981", Age: "035:10:02", Gender: "F", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0005", MRNO: "987", ConsDate: "15/02/2019", ConsTime: "12:20 AM", SurgeryNm: "AngioPlasty", PatName: "Mrs.Sayali Mate", DOB: "02/07/1981", Age: "035:10:02", Gender: "F", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0006", MRNO: "654", ConsDate: "15/02/2019", ConsTime: "02:16 PM", SurgeryNm: "CAG PTCA", PatName: "Mr.Mayur Sagale", DOB: "10/01/1986", Age: "035:10:02", Gender: "M", APPTTM: "", MobileNo: "8160422789", DIFFTM: "-1", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0007", MRNO: "321", ConsDate: "15/02/2019", ConsTime: "06:20 PM", SurgeryNm: "Angiography", PatName: "Mr.Anil Chauhan", DOB: "20/09/1971", Age: "035:10:02", Gender: "M", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
    ]
};
var SurTom = {
    Result: [
        { CONSNO: "12C190215JU0002", MRNO: "123", ConsDate: "16/02/2019", ConsTime: "07:30 AM", SurgeryNm: "AngioGraphy", PatName: "Mrs.Rekha  Patil", DOB: "20/06/1981", Age: "035:10:02", Gender: "F", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0005", MRNO: "987", ConsDate: "16/02/2019", ConsTime: "01:20 PM", SurgeryNm: "Hernia Repair", PatName: "Mrs.Anita Nikkam", DOB: "02/07/1981", Age: "035:10:02", Gender: "F", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
        { CONSNO: "12C190215JU0007", MRNO: "321", ConsDate: "16/02/2019", ConsTime: "03:20 PM", SurgeryNm: "Appendectomy", PatName: "Mr.Aditya Suri", DOB: "20/09/1971", Age: "035:10:02", Gender: "M", APPTTM: "", MobileNo: "8160422789", DIFFTM: "0", TRANNO: "", CompletedYN: "N", },
    ]
};


function PatLstFunction(clinicCode, appNsurType) {
    var dayType = "";
    if ($("#rbtnYesterday")[0].checked == true)
        dayType = "Y";
    else if ($("#rbtnDayBefYest")[0].checked == true)
        dayType = "B";
    else
        dayType = "T";
    var url = "../DoctorDesk/GetPatData";
    HoldOn.open();
    $.ajax({
        //  url: "<%=Url.Action("GetPatientList", "DoctorDesk")%>",
        url: url,
        type: 'post',
        dataType: 'json',
        data: { strClinicCode: clinicCode, appNsurType: appNsurType, strDayType: dayType },
        success: function (result) {
            var $newDiv1 = $('<div>');
            $newDiv1.attr("id", "WaitingPats");
            $newDiv1.attr("name", "WaitingPats");
            var $newul1 = $('<ul>', { style: ' list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:20px;letter-spacing: 0.5px;color:#515151' });
            $newul1.attr("id", "WaitingPatsdata");

            var $newDiv2 = $('<div>');
            $newDiv2.attr("id", "VisitedPats");
            $newDiv2.attr("name", "VisitedPats");
            var $newul2 = $('<ul>', { style: ' list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:24px;;lettter-spacing:1px' });
            $newul2.attr("id", "VisitedPatsdata");

            var $newDiv3 = $('<div>');
            $newDiv3.attr("id", "completedPat");
            $newDiv3.attr("name", "completedPat");


            var options1 = "";
            var options2 = "";


            var waitingCount = 0;
            var completedCount = 0;
            if (result.Result != "Something Went Wrong.") {
                $.each(result.Result, function (i, item) {
                    var patName = "";
                    if (appNsurType == "ST" || appNsurType == "STMW") {
                        patName = item.ConsTime + "--" + item.PatName + "--[" + item.SurgeryNm + "]";
                    }
                    else {
                        patName = item.PatName;
                    }
                    var ApptTm = item.APPTTM;
                    var mrNo = item.MRNO;
                    var consNo = item.CONSNO;
                    var timeDiff = item.DIFFTM;
                    var age = item.Age;
                    var gender = item.Gender;
                    var compltdYn = item.CompletedYN;

                    var tranNo = (item.TRANNO).toString().trim();

                    var chkSign = Math.sign(timeDiff);
                    var onlpaystat = (item.OnlyPayStat).toString().trim();
                    var applyColor = "none";
                    var coloronlpay = "none";

                    if (chkSign == 1) {
                        if (timeDiff > 30) {
                            //red color
                            applyColor = "red";
                        }
                        else
                            applyColor = "#e49f21;";
                        //alert("positive");yellow
                    }
                    else if (chkSign == -1) {
                        applyColor = "green";
                        //alert("negative"); green
                    }
                    else if (chkSign == NaN) {
                        //alert("No time");
                    }
                    if (onlpaystat == "Y") {
                        coloronlpay = "#b7f1c8";
                    }
                    if (compltdYn == "N" || compltdYn == " ") {
                        waitingCount++;
                        options1 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' style='background:" + coloronlpay + "'><label style='padding-left:5px;width:32px;font-size:12px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "</label><label style=' padding: 2px 7px;font-size: 12px; border-bottom: 1px solid #f4f4f4;' id='" + mrNo + "'> " + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input></li>";
                    }
                    else {
                        completedCount++;
                        options2 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' style='background:" + coloronlpay + "'><label style='padding-left:5px;width:32px;font-size:12px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "</label><label style=' padding: 2px 7px;font-size: 12px; border-bottom: 1px solid #f4f4f4;' id='" + mrNo + "'> " + patName + "</label><input type=hidden  id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input></li>";
                    }
                });
            }
            //$newul.append(options);
            //$newDiv.append($newul);
            var $newHeadngWait = $('<a>', { class: 'btn-group btn-group-justified', style: 'border: 1px solid #d8acc6;color: #8e0e5a;text-align: center;font-size:13px;border-radius: 2px; background-color: #f9ddedcc; text-decoration: none;' });
            if (appNsurType == "ATMW" || appNsurType == "ST" || appNsurType == "STMW") {
                if (waitingCount == 0)
                    $newHeadngWait.append('Total');

                else
                    $newHeadngWait.append('Total (' + waitingCount + ')');
            }
            else {
                if (waitingCount == 0)
                    $newHeadngWait.append('Total');

                else
                    $newHeadngWait.append('Total (' + waitingCount + ')');
            }
            $newul1.append(options1);
            $newDiv1.append($newul1);

            $newul2.append(options2);
            $newDiv2.append($newul2);

            var $newHeadng = $('<a>', { class: 'btn-group btn-group-justified', style: 'border: 1px solid #a9dca9;color: #118011;text-align: center;border-radius: 2px; font-size:13px;  background-color: #d6f7d5cf;  text-decoration: none;' });
            if (appNsurType == "ATMW" || appNsurType == "ST" || appNsurType == "STMW") {
                if (completedCount == 0)
                    $newHeadng.append('Total');

                else
                    $newHeadng.append('Total (' + completedCount + ')');
            }
            else {
                if (completedCount == 0)
                    $newHeadng.append('Total');
                else
                    $newHeadng.append('Total (' + completedCount + ')');
            }

            $newDiv3.append($newHeadng);

            ////$newHeadng.attr("value", "Completed");

            $('#DivDPatGrid').empty();
            ////$('#DivPatGrid').append("<div><label>" + new Date() + "</label></div>");
            var $DivPatSearch; //, { style: 'height:35px;text-align:center;margin-top:56px' }); //suchita
            if ($(window).width() < 996) {  //screen width size comparion
                $DivPatSearch = '<div id="divPatBindGrid" style="height:35px;text-align:center;margin-top:10px">';
            }
            else {
                $DivPatSearch = '<div id="divPatBindGrid" style="height:35px;text-align:center;margin-top:56px">';
            }

            $DivPatSearch += "<div class='form-group has-feedback' id='divPatientSearch'>";
            $DivPatSearch += "<div  style='float:left;margin-top: -2px;padding-left: 3px;'><input type='checkbox' style='display: none;' id='chkAllPatLst'  /><label class='lblImg' id='lblSelect' title='Show all patient' for='chkAllPatLst'><img class='lblImage' src='../Images/patient.png' /></label></div>";
            $DivPatSearch += "<input type='text' style='height:37px;width:79%;margin-left:5px;float:right;' class='form-control'  onkeyup='PatientSearch()' placeholder='Search Patient'/><input type='text' style='height:0px;margin-left:5px;-webkit-text-fill-color:white;border:none'/><span class='fa fa-search fa-2x form-control-feedback'  style='color:#3c8dbc;line-height:30px;'></span></div>";

            if (options1 != "") {
                $('#DivDPatGrid').append($newHeadngWait);
                $('#DivDPatGrid').append($newDiv1);
            }


            if (options2 != "") {
                $('#DivDPatGrid').append($newDiv3);
                $('#DivDPatGrid').append($newDiv2);

            }
            if (result.Result.length == 0) {
                $('#DivDPatGrid').empty();
                var $NoPatientsDiv = $('<div>', { style: ' text-align: center;font-size:14px;background-color: #d2d6de' });
                var $lbl = $('<label>', { style: 'margin-top: 2px;' }).html('No Patients');
                $NoPatientsDiv.append($lbl);
                $('#DivDPatGrid').append($NoPatientsDiv);
            }
            HoldOn.close();
        },
        complete: function () {
            var mrNo = sessionStorage.getItem('PatMRNO');
            var tranno = sessionStorage.getItem('PatTRANNO');
            //Changes For Patient Select after Bell Icon Click
            if (tranno != null && tranno != "" && mrNo != null && mrNo != "") {
                //$("li#PatName" + tranno)[0].style.color = "#3c8dbc";
                $("li#PatName" + tranno).attr("style", "color:#3c8dbc;box-shadow:-5px 1px 7px 3px #636367;");
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            HoldOn.close();
        }
    });

    //}
}

function PatientDSearch() {
    // Declare variables 
    var input, filter, table, tr, td, i;
    input = document.getElementById("txtDPatientSearch");
    filter = input.value.toUpperCase();
    table = document.getElementById("DivDPatGrid");
    tr = table.getElementsByTagName("li");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        $(tr[i]).removeClass('display');
        td = tr[i].getElementsByTagName("label")[1];
        if (td) {
            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
                if (!$(tr[i]).hasClass('display')) {
                    $(tr[i]).addClass('display')
                }
            } else {
                tr[i].style.display = "none";
            }
        }
    }

}

function GetNursStationsNPat(flag) {
    if (typeof flag === "undefined" || flag === null) {
        flag = "N";
    }

    // if (($(window).width() >= 996) || ($(window).width() < 996 && flag == "Y")) {                                            //screen width size comparion
    $.ajax({
        url: '../ICUMob/GetNursStationsNPAtients',
        type: 'post',
        datatype: 'json',
        data: {},
        success: function (data) {

            if (data.length > 0) {
                //for each nusing station bind patientList in separate ul
                $("#lblheadAdm").html("Admission" + " " + "(" + data[1].length + ")");
                if (data[0].length > 0) //data[0] contains Nursing Station list
                {
                    $("#PatListPanelDiv").empty();

                    $.each(data[0], function (key, value) {

                        var $NurstDiv = $('<div>');
                        $NurstDiv.attr("id", "NurstDiv" + value.Value);
                        $NurstDiv.attr("class", "panel contact_item");
                        $NurstDiv.attr("style", "background:#ffffff");

                        var $NursDivHead = $('<div>');
                        $NursDivHead.attr("class", "panel-heading divHeads");
                        $NursDivHead.attr("style", "height:25px;padding-top:5px;background: #c4d1d8;");


                        var $a = $('<a>');
                        $a.attr("data-toggle", "collapse");
                        $a.attr("data-target", "#CollapseDiv" + value.Value);
                        $a.attr("href", "#CollapseDiv" + value.Value);
                        $a.attr("style", "color:white;text-shadow: 0px 0px 0px;");
                        $NursDivHead.append($a);
                        //$a.attr("data-parent", "#PatListPanelDiv");

                        var $divInAnchor = $('<div>');
                        $divInAnchor.attr("style", "width:100%;margin-left:7%");

                        var $aspan = $('<i class="more-less fa fa-minus"></i>');
                        $a.append($divInAnchor);
                        $a.append($aspan);

                        var $NurseDivBody = $('<div>');
                        $NurseDivBody.attr("class", "collapse in indent");
                        $NurseDivBody.attr("id", "CollapseDiv" + value.Value);
                        $NurseDivBody.attr("style", "margin-left:4%");


                        var options = "";
                        var $PatListTbl = $('<table>', { style: 'line-height:2.5' });
                        $PatListTbl.attr("id", "tblPatientLst");

                        $.each(data[1], function (i, item) {
                            var patName = item.PatName;
                            var patFname = item.PatFName;
                            var patLname = item.PatLName;
                            var nurstCode = item.NurstCode;
                            var mrNo = item.MRNO;
                            var ipNo = item.IPNO;
                            var gender = item.PatGender;
                            var bedNo = (item.BedNo).trim().substr(-3);
                            var admnDt = item.AdmnDt;
                            var age = item.PatAge;
                            var salutation = item.Salutation;// added by vijeta on 30th amy 2018
                            if (value.Value == nurstCode)
                                options += "<tr style='font-size:12px;font-weight: bold;cursor: pointer;border-top: 2px solid #e4e9e4;'><td style='width:15%' id='bedNo'>" + bedNo + "</td><td style='width:82%;line-height:1.5em;' id='patName'>" + salutation + " " + patName + "</br>" + " ( " + mrNo + " / " + ipNo + " )" + "</td><td id='gender'>" + gender.substr(0, 1) + "</td><td style='display:none' id='nurstCode'>" + nurstCode + "</td><td style='display:none' id='ipNo'>" + ipNo + "</td><td style='display:none' id='mrNo'>" + mrNo + "</td><td style='display:none' id='admndate'>" + admnDt + "</td><td style='display:none' id='age'>" + age + "</td><td style='display:none' id='salu'>" + salutation + "</td></tr>";// salutation td added by vijeta on30th may 2018
                            //options += "<li class='patNameCls' id='Pat" + mrNo + "'><label style='padding-left:5px;width:34px;font-size:12px;margin-top: 3px;'>" + bedNo + "</label><label style=' padding: 1px 3px;    font-size: 12px; border-bottom: 1px solid #f4f4f4;width:180px;'>" + patName + "</label><label>" + gender.substr(0, 1) + "</label></li>";

                        });
                        $PatListTbl.append(options);
                        $NurseDivBody.append($PatListTbl);



                        $divInAnchor.append(value.Text);

                        $NurstDiv.append($NursDivHead);
                        $NurstDiv.append($NurseDivBody);


                        $("#PatListPanelDiv").append($NurstDiv);
                    });



                }
                else {

                    $("#PatListPanelDiv").empty();
                    var $NoPatientsDiv = $('<div>', { style: ' text-align: center;font-size:14px;background-color: #d2d6de' });
                    var $lbl = $('<label>', { style: 'margin-top: 2px;' }).html('No Patients');
                    $NoPatientsDiv.append($lbl);
                    $("#PatListPanelDiv").append($NoPatientsDiv);

                }

            }
        }
    });
    //}
}

function SetPatPrimaryMedicalInfo() {
    var mrNo = sessionStorage.getItem('PatMRNO');
    var tranno = sessionStorage.getItem('PatTRANNO');
    var datatosend = {
        tranno: tranno,//"06C170704NR0001"
        type: "LeftMenu",
        MrNo: mrNo,
    }

    var page = window.location.href;
    if (page.indexOf("PatientEntry") == -1 && page.indexOf("MenuList") == -1) {
        $.ajax({
            type: "Post",
            url: "../DoctorDesk/GetDoctorDeskData",
            data: datatosend,
            async: false,
            success: function (response) {
                GridData = response;
                if (jQuery.isEmptyObject(GridData))
                    return false;
                //complaints
                if (GridData.jsonComplaints != "" || GridData.jsonFreeComplaints != "") {
                    //var str = "<a data-toggle='collapse' data-target='#ComplaintInfo' id='comp'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #6cd4f9 0%, #006698 100%);'><i class='moreless fa fa-minus'></i>Present Complaints<span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o' style='font-size:16px;text-shadow: none !important;'></span></a>"
                    var str = "<a data-toggle='collapse' data-target='#ComplaintInfo' id='comp'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #6cd4f9 0%, #006698 100%);'><i class='moreless fa fa-minus'></i>Present Complaints<span style='float:right;' ></a>"
                    str += "<div id='ComplaintInfo' name='ComplaintInfo' class='collapse in indent'>"
                    str += "<table id='tblComplaints' class='tblMediNfo' style='border:none'>";

                    for (var i = 0; i < GridData.jsonComplaints.length; i++) {
                        var TotalDuration = "";
                        var dur = "" + GridData.jsonComplaints[i].DURATION
                        var durtype = GridData.jsonComplaints[i].DURTYPE
                        if (dur.length > 0) {
                            if (Number(dur) > 0) {
                                TotalDuration = "  since " + dur + " " + DurationTypeSelect(durtype, dur)
                            }
                        }
                        var rmrk = "";
                        if (GridData.jsonComplaints[i].REMARKS != "") {
                            rmrk = " (" + GridData.jsonComplaints[i].REMARKS + ")";
                        }
                        str = str + "<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonComplaints[i].NAME + " " + TotalDuration + " " + rmrk.toString().replace(/\n/g, '<br />') + "</li></td></tr>"
                    }
                    //free complaints
                    $.each(GridData.jsonFreeComplaints, function (i, value) {
                        str = str + "<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeComplaints[0].FREECOMPLAINT.toString().replace(/\n/g, '<br />') + "</li></td></tr>";
                    });
                    str = str + "</table>";
                    str = str + "</div>";
                    $("#MedicalInfo").append(str);
                }

                //Vitals data
                if (GridData.jsonVital != "") {
                    var flag = 0;
                    //  var strVitals = "<a data-toggle='collapse' data-target='#VitalInfo' id='vitl'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #f5c368 0%, #de5200 100%);'><i class='moreless fa fa-minus'></i>Present Vitals <span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o removeRelation' style='text-shadow: none !important;font-size:16px;text-shadow: none !important;'></span></a>"
                    var strVitals = "<a data-toggle='collapse' data-target='#VitalInfo' id='vitl'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #f5c368 0%, #de5200 100%);'><i class='moreless fa fa-minus'></i>Present Vitals <span style='float:right;' ></a>"
                    strVitals += "<div id='VitalInfo' name='VitalInfo' class='collapse in indent'>"
                    strVitals += "<table id='tblVitals'  class='tblMediNfo' width='100%'>";
                    $.each(GridData.jsonVital, function (i, value) {
                        if (Number(value.WEIGHT) != 0)
                            strVitals = strVitals + "<tr><td>" + "Weight  " + "</td><td> " + value.WEIGHT + " Kg</td>" + "</tr>";

                        if (Number(value.HEIGHT) != 0)
                            strVitals = strVitals + "<tr><td>" + "HEIGHT " + "</td><td> " + value.HEIGHT + " cm</td>" + "</tr>";

                        if (Number(value.TEMP) != 0)
                            strVitals = strVitals + "<tr><td>" + "Temperature  " + "</td><td> " + value.TEMP + " °F</td>" + "</tr>";

                        if ((value.PULSE) != "")
                            strVitals = strVitals + "<tr><td>" + "Pulse  " + "</td><td> " + value.PULSE + " bpm</td>" + "</tr>";

                        if ((value.BP) != "")
                            strVitals = strVitals + "<tr><td>" + "BP " + "</td><td> " + value.BP + " mmHg</td>" + "</tr>";

                        if ((value.RESP) != "")
                            strVitals = strVitals + "<tr><td>" + "Respiratory  " + "</td><td> " + value.RESP + " </td>" + "</tr>";

                        if ((value.SPO2) != "")
                            strVitals = strVitals + "<tr><td>" + "SpO2 : " + "</td><td> " + value.SPO2 + " %</td>" + "</tr>";

                        if ((value.VOTHERS) != "")
                            strVitals = strVitals + "<tr><td>" + "VOTHERS : " + "</td><td> " + value.VOTHERS + " </td>" + "</tr>";

                        if ((value.BMI) != "")
                            strVitals = strVitals + "<tr><td>" + "BMI  " + "</td><td> " + value.BMI + " kg/(m²)</td>" + "</tr>";

                        if ((value.HEAD_CIRCUMFERENCE) != "")
                            strVitals = strVitals + "<tr><td>" + "Head Circumference  " + "</td><td> " + value.HEAD_CIRCUMFERENCE + " cm</td>" + "</tr>";

                        if (value.BSA != "")
                            strVitals = strVitals + "<tr><td>" + "BSA  " + "</td><td> " + value.BSA + " m²</td>" + "</tr>";

                        if (value.RBS != "")
                            strVitals = strVitals + "<tr><td>" + "RBS  " + "</td><td> " + value.RBS + " mg/dl</td>" + "</tr>";

                        if (value.KARNOFSKY != "")
                            strVitals = strVitals + "<tr><td>" + "karnofsky Score  " + "</td><td> " + value.KARNOFSKY + " </td>" + "</tr>";

                        if (value.ECOG != "")
                            strVitals = strVitals + "<tr><td>" + "ECOG Score  " + "</td><td> " + value.ECOG + " </td>" + "</tr>";

                        if (value.PEFR != "")
                            strVitals = strVitals + "<tr><td>" + "PEFR  " + "</td><td> " + value.PEFR + " lit/min</td>" + "</tr>";

                        if (value.Technique != "N")
                            strVitals = strVitals + "<tr><td>" + "Technique  " + "</td><td> " + value.Technique + " </td>" + "</tr>";

                        if (value.Compliance != "N")
                            strVitals = strVitals + "<tr><td>" + "Compliance  " + "</td><td> " + value.Compliance + " </td>" + "</tr>";

                        if (Number(value.WEIGHT) == 0 && Number(value.HEIGHT) == 0 && Number(value.TEMP) == 0 && value.PULSE == "" && value.BP == "" && value.RESP == "" && value.SPO2 == "" && value.VOTHERS == "" && value.BMI == "" && value.HEAD_CIRCUMFERENCE == "" && value.PEFR == "" && value.Technique == "N" && value.Compliance == "N") {
                            strVitals = strVitals + "<tr><td class='NoDataTD'> No Data </td></tr>";
                            flag = 1;
                        }
                    });
                    strVitals += "</table>";
                    strVitals = strVitals + "</div>";
                    if (flag == 0)
                        $("#MedicalInfo").append(strVitals);
                }

                //Advice
                if (GridData.jsonPatientAdvice.length > 0) {
                    var flag = 0;
                    var strjsonAdvice = "<a data-toggle='collapse' data-target='#AdviceInfo' id='Advice'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #dede40 0%, #7d8106 100%);'><i class='moreless fa fa-minus'></i>Advice</a>"
                    strjsonAdvice += "<div id='AdviceInfo' name='AdviceInfo' class='collapse in indent'>"
                    strjsonAdvice += "<table id='tblAdvice' class='tblMediNfo'>";
                    $.each(GridData.jsonPatientAdvice, function (i, value) {
                        if (value.NAME.trim() != "") {
                            strjsonAdvice += "<tr><td>" + value.NAME + "</td></tr>";
                            flag = 1;
                        }
                    });
                    strjsonAdvice += "</table>";
                    strjsonAdvice += "</div>";
                    if (flag == 1)
                        $("#MedicalInfo").append(strjsonAdvice);
                }

                //Examination
                if (GridData.jsonExam != "") {
                    var flag = 0;
                    //var strExam = "<a data-toggle='collapse' data-target='#ExamInfo' id='exm'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #94de40 0%, #407700 100%);'><i class='moreless fa fa-minus'></i>On Examination<span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o removeRelation' style='font-size:16px;text-shadow: none !important;'></span></a>"
                    var strExam = "<a data-toggle='collapse' data-target='#ExamInfo' id='exm'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #94de40 0%, #407700 100%);'><i class='moreless fa fa-minus'></i>On Examination<span style='float:right;' ></a>"
                    strExam += "<div id='ExamInfo' name='ExamInfo' class='collapse in indent'>"
                    //
                    strExam += "<table id='tblExam' class='tblMediNfo'>";
                    $.each(GridData.jsonExam, function (i, value) {
                        if (value.EXAM.trim() != "")
                            strExam += "<tr><td>" + value.EXAM + "</td></tr>";
                        else {
                            strExam += "<tr><td class='NoDataTD' >No Data</td></tr>"
                            flag = 1;
                        }
                    });
                    strExam += "</table>";
                    strExam += "</div>";
                    if (flag == 0)
                        $("#MedicalInfo").append(strExam);
                }
                else {
                    strExam += "<table style='font-size:14px;'>";
                    strExam += "<tr><td class='NoDataTD'>No Data</td></tr>";
                    strExam += "</table>";
                }

                //Past History
                if (GridData.jsonPastHist.length > 0) {
                    var flag = 0;
                    var strPHist = "<a data-toggle='collapse' data-target='#PHistInfo' id='PHist'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #dede40 0%, #7d8106 100%);'><i class='moreless fa fa-minus'></i>Past History</a>"
                    strPHist += "<div id='PHistInfo' name='PHistInfo' class='collapse in indent'>"
                    strPHist += "<table id='tblPHist' class='tblMediNfo'>";
                    $.each(GridData.jsonPastHist, function (i, value) {
                        if (value.PASTHIST.trim() != "")
                            strPHist += "<tr><td>" + value.PASTHIST + "</td></tr>";
                        else {
                            strPHist += "<tr><td class='NoDataTD' >No Data</td></tr>"
                            flag = 1;
                        }
                    });
                    strPHist += "</table>";
                    strPHist += "</div>";
                    if (flag == 0)
                        $("#MedicalInfo").append(strPHist);
                }
                else {
                    strPHist += "<table style='font-size:14px;'>";
                    strPHist += "<tr><td class='NoDataTD'>No Data</td></tr>";
                    strPHist += "</table>";
                }

                //Diagnosis
                if (GridData.jsonDiagnosis != "") {
                    //var strDiagno = "<a data-toggle='collapse' data-target='#DiagnoInfo' id='dig'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #9a989c 0%, #282b25 100%);'><i class='moreless fa fa-minus'></i>Present Diagnosis<span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o removeRelation' style='font-size:16px;text-shadow: none !important;'></span></a>"
                    var strDiagno = "<a data-toggle='collapse' data-target='#DiagnoInfo' id='dig'  class='btn-group btn-group-justified MedicalInfo' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background: linear-gradient(to bottom, #9a989c 0%, #282b25 100%);'><i class='moreless fa fa-minus'></i>Present Diagnosis<span style='float:right;' ></a>"
                    strDiagno += "<div id='DiagnoInfo' name='DiagnoInfo' class='collapse in indent'>"

                    strDiagno += "<table id='tblDiagnosis' class='tblMediNfo'>";
                    $.each(GridData.jsonDiagnosis, function (i, value) {

                        var rmrk = (value.REMARKS != "") ? "-" + value.REMARKS : "";
                        strDiagno += "<tr><td><li>" + value.NAME + rmrk + "</li></td></tr>";
                    });
                    strDiagno += "</table>";
                    strDiagno += "</div>";
                    $("#MedicalInfo").append(strDiagno);
                }
                else {
                    strDiagno += "<table style='font-size:14px;'>";
                    strDiagno += "<tr><td class='NoDataTD'>No Data</td></tr>";
                    strDiagno += "</table>";
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $.messager.alert("Information", textStatus);
            }
        });
    }

    PatHistoryTab();
    PatTumorTreatmentDet();
}

function DeleteComplaintdata(obj) {
    var headngOf = obj.parentNode.innerText.toUpperCase();
    var mrno = ($.session.get('PatMRNO')).toString();
    var tranNo = ($.session.get('PatTRANNO')).toString();
    var urll = '';
    var cmpltArr = [];
    var examdata = '';
    //var url = "../DoctorDesk/SaveComplaints";
    if (headngOf.indexOf("COMPLAINTS") > -1) {
        urll = '../DoctorDesk/SaveComplaints?strComplaints=' + JSON.stringify(cmpltArr) + '&&strMRNO=' + mrno + '&&strTranNo=' + tranNo;
    }
    else if (headngOf.indexOf("DIAGNOSIS") > -1) {
        urll = '../DoctorDesk/SaveDiagnosis?strDiagnosis=' + JSON.stringify(cmpltArr) + '&&strICDDiagnosis=' + JSON.stringify(cmpltArr) + '&&strMRNO=' + mrno + '&&strTranNo=' + tranNo + '&&ICDOTopoList=' + JSON.stringify(cmpltArr) + '&&ICDOHistoList=' + JSON.stringify(cmpltArr);
    }
    else if (headngOf.indexOf("EXAMINATION") > -1) {
        urll = '../DoctorDesk/SaveExam?strExam=' + examdata + '&&strMrNo=' + mrno + '&&strTranno=' + tranNo + "&&PassHistYN=" + (GridData.jsonPastHist.length > 0 ? "Y" : "N");
    }
    else if (headngOf.indexOf("VITALS") > -1) {
        var strWt = 0.00;
        var strHt = 0.00;
        var strTp = 0.00;
        var strPu = "";

        //var strBp = "" + $('#txtBP').val();
        var strSystolicVal = '';
        var strDiastolicVal = '';
        var strBp = "/";

        var strRp = "";
        // var strOt = "" + $('#txtOthr').val();
        var strPrev = 0.00;
        var strTran = ($.session.get('PatTRANNO')).toString();
        var strMr = ($.session.get('PatMRNO')).toString();
        var strWalkngYN = "N";
        var strDietYN = "N";
        var strMedicineYN = "N";
        var strWalkDur = 0;
        var strWalkDurType = "D";
        var strSPO2 = " ";


        urll = '../DoctorDesk/SaveVitals?strWeight=' + strWt + '&&strHeight=' + strHt + '&&strTemp=' + strTp + '&&strPulse=' + strPu + '&&strBlood=' + strBp
            + '&&strResp=' + strRp + '&&strOther=' + examdata + '&&strPrevWt=' + strPrev + '&&strTranno=' + strTran + '&&strMrNo=' + strMr + '&&strWalkngYN=' + strWalkngYN
            + '&&strDietYN=' + strDietYN + '&&strMedicineYN=' + strMedicineYN + '&&strWalkDur=' + strWalkDur + '&&strWalkDurType=' + strWalkDurType + '&&strSPO2=' + strSPO2;
    }
    $.ajax({
        type: "POST",
        url: urll,
        datatype: "json",
        data: { strComplaints: JSON.stringify(cmpltArr), strMRNO: mrno, strTranNo: tranNo },
        success: function (result) {
            if (headngOf.indexOf("COMPLAINTS") > -1) {
                $('#comp').remove();
                $('#ComplaintInfo').remove();
                //window.location.href = "../DoctorDesk/Complaints";
            } else if (headngOf.indexOf("DIAGNOSIS") > -1) {
                $('#dig').remove();
                $('#DiagnoInfo').remove();
                // window.location.href = "../DoctorDesk/Diagnosis";
            } else if (headngOf.indexOf("EXAMINATION") > -1) {
                $('#exm').remove();
                $('#ExamInfo').remove();
                //window.location.href = "../DoctorDesk/Examination";
            } else if (headngOf.indexOf("VITALS") > -1) {
                $('#vitl').remove();
                $('#VitalInfo').remove();
                //window.location.href = "../DoctorDesk/Vitals";
            }
            //window.location.reload()
            //if (strPlusBtn == "N")
            //    window.location.href = 'PatientEntry';
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        }
    });


}
function changeIcon(obj) {//
    if (obj.firstElementChild.className == "moreless fa fa-minus") {
        // $('#comp').html('<i class="moreless fa fa-plus"></i>');
        obj.firstElementChild.className = "moreless fa fa-plus";
    }
    else {
        obj.firstElementChild.className = "moreless fa fa-minus";
        // $('#comp').html('<i class="moreless fa fa-minus"></i>');
    }
}

//vijeta 9/5/14
$(document.body).on('click', '#tblNonFreqMtrlList tr', function (e) {

    $("#ComplaintInput").val("").trigger("donetyping");
    SearchComplaint();

    var selRows = $('#tblMaterialList > tbody > tr.active').get(); //group of selected rows

    if (selRows.length == 0)
        $("#tblMaterialList tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
    else {
        $('#tblMaterialList > tbody > tr').eq(selRows.length - 1).after($(this)); // selected row inserted after group of selected rows
    }

    $(this).addClass('active')
    $('#tblNonFreqMtrlList').hide();

    $(this).children('td').children('a').show();
    $(this).children('td').children('input').show();
    $(this).children('td').children('select').show();
    $(this).children('td').children('div').show();
    $(this).children('td').children('span').show();
    if (IS_DISPLAY_CIMS_FUNCTIONLITY == "Y") {// Added By Roshan Condtion Based On WebConfigs to Add The Row Or Not
        // Added By Roshan Condtion Based On WebConfigs
        toogleButtons();//For Show And Hide The Interaction and Duplicate Button Added By Roshan 12/12/2025
    }
    if ($(this).hasClass('active')) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        if (elmnt.children[0].innerHTML.toUpperCase().indexOf("QOH") == -1 && elmnt.children.length > 19) {
            elmnt.children[19].children[elmnt.children[19].children[0].id].checked = true;
        }
    }

    $('#tblMaterialList input.hasAutoComplete').autocomplete("close");
    $(this).find("input.triggerInputIntake").trigger("keydown");
    $('#tblNonFreqMtrlList').hide();

});

function CallPat(DivId, Type) {
    var MRNO = "";
    var CONSULTDT = "";
    var PATNAME = "";
    if (Type == "R") {
        MRNO = sessionStorage.getItem('NPatMRNO');
        CONSULTDT = sessionStorage.getItem('NConsltnDT');
        PATNAME = sessionStorage.getItem('NPatName');
    }
    else {
        var patientElement = document.getElementById(DivId);
        var patientData = {};
        var inputs = patientElement.getElementsByTagName('input');
        for (var i = 0; i < inputs.length; i++) {
            var input = inputs[i];
            patientData[input.id] = input.value;
        }
        MRNO = patientData.mrNo;
        CONSULTDT = patientData.ConsultDT;
        PATNAME = document.getElementById(patientData.mrNo).innerText;
    }
    var Flg = CheckPatOnConsult(MRNO, CONSULTDT, PATNAME);
    if (Flg == true) {
        if (Type == "R") {
            sessionStorage.setItem('TokenNo', sessionStorage.getItem('NTokenNo'));
            sessionStorage.setItem('PatMRNO', sessionStorage.getItem('NPatMRNO'));
            sessionStorage.setItem('PatName', sessionStorage.getItem('NPatName'));
            sessionStorage.setItem('ConsltnNo', sessionStorage.getItem('NConsltnNo'));
            sessionStorage.setItem('PatTRANNO', sessionStorage.getItem('NPatTRANNO'));
            sessionStorage.setItem('PatAge', sessionStorage.getItem('NPatAge'));
            sessionStorage.setItem('PatGender', sessionStorage.getItem('NPatGender'));
            sessionStorage.setItem('PatMobile', sessionStorage.getItem('NPatMobile'));
            sessionStorage.setItem('PatAge2', sessionStorage.getItem('NPatAge2'));
            sessionStorage.setItem('PatDOB', sessionStorage.getItem('NPatDOB'));
            sessionStorage.setItem('onlpaySTAT', sessionStorage.getItem('NonlpaySTAT'));
            sessionStorage.setItem('PatEmail', sessionStorage.getItem('NPatEmail'));
            sessionStorage.setItem('OutRefDrNm', sessionStorage.getItem('NOutRefDrNm'));
            sessionStorage.setItem('OutRefDrContact', sessionStorage.getItem('NOutRefDrContact'));
        }
        else {
            var patientElement = document.getElementById(DivId);
            var patientData = {};
            var inputs = patientElement.getElementsByTagName('input');
            for (var i = 0; i < inputs.length; i++) {
                var input = inputs[i];
                patientData[input.id] = input.value;
            }
            var PatName = document.getElementById(patientData.mrNo).innerText;
            var strAge = Number(patientData.age.split(":")[0]) > 0 ? Number(patientData.age.split(":")[0]) + " Yrs" : Number(patientData.age.split(":")[1]) > 0 ? Number(patientData.age.split(":")[1]) + " Months" : Number(patientData.age.split(":")[2]) + " Days"
            sessionStorage.setItem('TokenNo', patientData.TokenNo);
            sessionStorage.setItem('PatMRNO', patientData.mrNo);
            sessionStorage.setItem('PatName', PatName);
            sessionStorage.setItem('ConsltnNo', patientData.tranNo);
            sessionStorage.setItem('PatTRANNO', patientData.tranNo);
            sessionStorage.setItem('PatAge', strAge);
            sessionStorage.setItem('PatGender', patientData.gender);
            sessionStorage.setItem('PatMobile', patientData.mobNO);
            sessionStorage.setItem('PatAge2', patientData.age);
            sessionStorage.setItem('PatDOB', patientData.dob);
            sessionStorage.setItem('onlpaySTAT', patientData.onlpaystat);
            sessionStorage.setItem('PatEmail', patientData.PatEmail);
            sessionStorage.setItem('OutRefDrNm', patientData.OutRefDrName);
            sessionStorage.setItem('OutRefDrContact', patientData.OutRefDrContact);
            var PatCompYN = $("#VisitedPats").find("#" + DivId).length > 0 ? "Y" : "N";
            sessionStorage.setItem('PatCompleted', PatCompYN);
        }
        var Mrno = sessionStorage.getItem('PatMRNO');
        var strPatName = sessionStorage.getItem('PatName');
        var ConsToken = sessionStorage.getItem('TokenNo');
        var ConsltnNo = sessionStorage.getItem('ConsltnNo');
        if (Mrno != "") {
            HoldOn.open();
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/CallWaitPatSave',
                data: { mrno: Mrno, consNo: ConsltnNo, TokenNo: ConsToken, Patient: strPatName, ConsDate: CONSULTDT },
                async: false,
                success: function (response) {
                    HoldOn.close();
                    if (window.location.href.includes("PAC"))
                        window.location.href = '../DoctorDesk/PAC?PatMRNO=' + Mrno + '&PatTRANNO=' + ConsltnNo;
                    else
                        window.location.href = 'PatientEntry';
                },
                error: function () {
                    HoldOn.close();
                    alert("Something went wrong please try again.");
                }
            });
        }
    }
}

function CheckPatOnConsult(MRNO, CONSULTDT, PATNAME) {
    HoldOn.open();
    $.ajax({
        type: 'POST',
        url: '../DoctorDesk/CheckPatConsult',
        data: { mrno: MRNO, ConsDate: CONSULTDT },
        async: false,
        success: function (response) {
            HoldOn.close();
            if (response == "") {
                FlagForSelPat = true;
            }
            else {
                FlagForSelPat = false;
                var Msg = "Patient Name : " + PATNAME + "is currently being seen by Dr." + response;
                alert(Msg);
            }
        },
        error: function () {
            HoldOn.close();
            alert("Something went wrong please try again.");
        }
    });
    return FlagForSelPat;
}


//Added By Priyanka On 29/01/2025
//To Set Session values as per conditions Start
function CheckDiagnosisValidation(ISICDDiagReq, ISDiagnoMandatory) {
    //debugger;

    let valueoficddiag = localStorage.getItem('ICDDiagSelYN');
    let valueofdiag = localStorage.getItem("DiagnosisSelYN");
    if ((ISICDDiagReq == "N" && ISDiagnoMandatory == "N")) {//modified by priyanka on 24/02/2025
        return true;
    }
    else if (ISDiagnoMandatory == "N" && ISICDDiagReq == "Y" && (localStorage.getItem('ICDDiagSelYN') == "N" || localStorage.getItem('ICDDiagSelYN') == null || localStorage.getItem('ICDDiagSelYN').length === null || localStorage.getItem('ICDDiagSelYN').length === 0)) {
        $.messager.alert("Alert", "Please select ICD diagnosis.");
        return false;
    }
    else if (ISDiagnoMandatory == "Y" && ISICDDiagReq == "N" && (localStorage.getItem('DiagnosisSelYN') == "N" || localStorage.getItem('DiagnosisSelYN').length === null || localStorage.getItem('DiagnosisSelYN').length === 0)) {
        $.messager.alert("Alert", "Please select Diagnosis");
        return false;
    }
    else if (ISDiagnoMandatory == "Y" && ISICDDiagReq == "Y") {
        if (valueoficddiag === null || valueoficddiag.length === 0 || valueofdiag === null || localStorage.getItem('DiagnosisSelYN').length === 0) {
            $.messager.alert("Alert", "Please Select Diagnosis")
            return false;
        }
        else if ((localStorage.getItem('DiagnosisSelYN') == "N" || localStorage.getItem('DiagnosisSelYN') == null) && (localStorage.getItem('ICDDiagSelYN') == "Y")) {
            $.messager.alert("Alert", "Please select Diagnosis");
            return false;
        }
        else if (localStorage.getItem('DiagnosisSelYN') == "Y" && (localStorage.getItem('ICDDiagSelYN') == "N" || localStorage.getItem('ICDDiagSelYN') == null)) {
            $.messager.alert("Alert", "Please select ICD diagnosis");
            return false;
        }
        else {
            return true;
        }
    }
    else {
        return true;
    }

}
//Added By Priyanka on 30/01/2025
function SetDiagnosisFlaging(DIAGNOSIS, ICDDIAGNOSIS) {

    if (DIAGNOSIS == "Y" && ICDDIAGNOSIS == "N") {
        localStorage.setItem('DiagnosisSelYN', "Y");
        localStorage.setItem('ICDDiagSelYN', "N");
    }
    else if (DIAGNOSIS == "N" && ICDDIAGNOSIS == "Y") {
        localStorage.setItem('DiagnosisSelYN', "N");
        localStorage.setItem('ICDDiagSelYN', "Y");
    }
    else if (DIAGNOSIS == "Y" && ICDDIAGNOSIS == "Y") {
        localStorage.setItem('DiagnosisSelYN', "Y");
        localStorage.setItem('ICDDiagSelYN', "Y");
    }
    else if (DIAGNOSIS == "N" && ICDDIAGNOSIS == "N") {
        localStorage.setItem('DiagnosisSelYN', "N");
        localStorage.setItem('ICDDiagSelYN', "N");
    }
}
//End
//Added By Priyanka on 01/02/2025
function PrintExcelCommon(Url, data, async, DisplayURL, flagExcel) {

    $.ajax({
        type: 'POST',
        data: data,
        url: Url,
        cache: false,
        dataType: "json",
        async: async,
        success: function (result) {
            if (flagExcel == true) {
                $('#btnExcel').attr('href', DisplayURL);
                // window.open(DisplayURL);
                HolOn.close();
            }
            else {
                var win = window.open(DisplayURL, "_blank", '', true);
                win.focus();
                HoldOn.close();
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $.messager.alert('An error occurred while processing your request.', "Error Information");
            HoldOn.close();
        }
    });
}


function AddICDDiagnosisCheck(ICDOCODE) {

}

function GetICDDiagnosisO(ICDCODE) {
    HoldOn.open();
    $.ajax({
        type: "POST",
        url: "../DoctorDesk/GetNonFregqentICDOList",
        data: { NonFreqICDO: "", ICDCode: ICDCODE },
        asycn: false,
        success: function (response) {
            if (response != "") {
                var result = JSON.parse(response);
                AppendICDDiagnosisO(result, ICDCODE);
            }
        },
        complete: function () { HoldOn.close(); },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        }
    });
}

function AppendICDDiagnosisO(DATA, ICDCODE) {
    var rows = "";
    jQuery.grep(DATA, function (e) {
        var rowId = ICDCODE + "_" + e.Value.trim();
        var row = $('#tblICDdiagnoO tr#' + CSS.escape(rowId)).get();
        if (row.length <= 0) {
            rows = rows + "<tr class='clickable-row display'  id='" + (ICDCODE + "_" + e.Value.trim()) + "'>" + "<td style='padding:5px;width:100%; text-align:left;font-size: 13px;'>" + e.Text + "</td>" + "</tr>";
        }
    });
    if (rows != "") {
        $('#tblICDdiagnoO tbody').prepend(rows);
    }
}

function RemoveICDO(ICDCode) {
    $('#tblICDdiagnoO tbody tr').each(function () {
        //$(this).remove();
        var rowId = $(this).attr('id').split('_')[0];
        if (rowId.trim() == ICDCode) {
            $(this).remove();
        }
    });
}

function RemoveAddICDO(ICDCode, SelectYN) {
    if (SelectYN == "Y") {
        GetICDDiagnosisO(ICDCode);
    }
    else {
        RemoveICDO(ICDCode);
    }
}

function GetCurrentDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    return day + "/" + month + "/" + year;
}

function ConvertDateFormat(DateStr) {
    if (!DateStr || DateStr.length !== 8) return '';
    const year = DateStr.substring(0, 4);
    const month = DateStr.substring(4, 6);
    const day = DateStr.substring(6, 8);
    return day + "/" + month + "/" + year;
}

function ConvertDateFormatSave(DateStr) {
    if (!DateStr || DateStr.length !== 10) return '';
    const day = DateStr.substring(0, 2);
    const month = DateStr.substring(3, 5);
    const year = DateStr.substring(6, 10);
    return year + month + day;
}

function CalcNextMedDate(PervDur, PervDurType, PrevDate) {
    if (!PervDurType || !PrevDate) return GetCurrentDate();
    const parts = PrevDate.split('/');
    if (parts.length !== 3) return '';
    const day = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10) - 1;
    const year = parseInt(parts[2], 10);
    const date = new Date(year, month, day);
    switch (PervDurType.toUpperCase()) {
        case 'D':
            date.setDate(date.getDate() + parseInt(PervDur));
            break;
        case 'W':
            date.setDate(date.getDate() + parseInt(PervDur) * 7);
            break;
        case 'M':
            date.setMonth(date.getMonth() + parseInt(PervDur));
            break;
        case 'Y':
            date.setFullYear(date.getFullYear() + parseInt(PervDur));
            break;
        default:
            return '';
    }
    date.setDate(date.getDate() + 1);
    const nextDay = String(date.getDate()).padStart(2, '0');
    const nextMonth = String(date.getMonth() + 1).padStart(2, '0');
    const nextYear = date.getFullYear();
    return nextDay + "/" + nextMonth + "/" + nextYear;
}

//Pournima 4th Dec 2025
function getPriorityTitle(priority) {
    switch (priority) {
        case "-V": return "VIP";
        case "-H": return "Handle with care";
        case "-I": return "International";
        default: return "";
    }
}

function MedicalSurgicalFormRights(ClinicSpeciality) {
    var MedicalListId = [];//[{ ID: "ChemoPlanning", DISPLAYTYPE: "block" }, { ID: "PresChemo", DISPLAYTYPE: "block" }];
    var SurgicalListId = [];//[{ ID: "lisOncoSchedule", DISPLAYTYPE: "block" }, { ID: "SurgyAdvDiv1", DISPLAYTYPE: "block" }, { ID: "SurgyAdvDiv2", DISPLAYTYPE: "block" }, { ID: "SurgyAdvDiv3", DISPLAYTYPE: "block" }, { ID: "SurgyAdvDiv4", DISPLAYTYPE: "block" }];
    var RaditionListId = [];
    var MedicalRights = false;
    var SurgicalRights = false;
    var RaditionRights = false;
    var CurClinic = sessionStorage.getItem('ClinicCode');
    ClinicSpeciality = ClinicSpeciality == "" || ClinicSpeciality == "[]" ? [] : JSON.parse(ClinicSpeciality);
    jQuery.grep(ClinicSpeciality, function (e) {
        if (CurClinic == e.CLINICCODE) {
            if (e.SPECIALITY == "M") {
                MedicalRights = true;
            }
            if (e.SPECIALITY == "S") {
                SurgicalRights = true;
            }
            if (e.SPECIALITY == "R") {
                RaditionRights = true;
            }
        }
    });
    jQuery.grep(MedicalListId, function (e) {
        if (document.getElementById(e.ID)) {
            document.getElementById(e.ID).style.display = MedicalRights == true ? e.DISPLAYTYPE : "none";
        }
    });
    jQuery.grep(SurgicalListId, function (e) {
        if (document.getElementById(e.ID)) {
            document.getElementById(e.ID).style.display = SurgicalRights == true ? e.DISPLAYTYPE : "none";
        }
    });
    jQuery.grep(RaditionListId, function (e) {
        if (document.getElementById(e)) {
            document.getElementById(e).style.display = RaditionRights == true ? document.getElementById(e).style.display : "none";
        }
    });


    //Priyanka 23/01/2026
    // Show/Hide Surgery Advice section and textarea

    // Function to toggle Bootstrap display classes
    function toggleClass(elementId, isVisible, displayClass) {
        var el = document.getElementById(elementId);
        if (el) {
            if (isVisible) {
                el.classList.remove("d-none");
                el.classList.add(displayClass);
            } else {
                el.classList.remove(displayClass);
                el.classList.add("d-none");
            }
        }
    }
    function toggleClassForAdviceSurgery(elementId, isVisible, displayClass) {
        var el = document.getElementById(elementId);
        if (el) {
            if (isVisible && (sessionStorage.getItem("OPDCompCode") != "" && sessionStorage.getItem("OPDCompCode") != null && sessionStorage.getItem("OPDCompCode") != undefined)) {
                el.classList.remove("d-none");
                el.classList.add(displayClass);
            } else {
                el.classList.remove(displayClass);
                el.classList.add("d-none");
            }
        }
    }
    toggleClass("Advice_SurgeryAdviceDivMain", SurgicalRights, "d-flex"); // flex container
    toggleClass("Advice_SurgeryAdvTbDivMain", SurgicalRights, "d-flex");
    //priyanka 01/04/2026
    //toggleClassForAdviceSurgery("Advice_SurgeryAdviceDivMain", SurgicalRights, "d-flex");
    //toggleClassForAdviceSurgery("Advice_SurgeryAdvTbDivMain", SurgicalRights, "d-flex");
    //end
    //End
}