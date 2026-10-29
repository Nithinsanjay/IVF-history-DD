var flagCheckRowsPerHist = false;//vijeta 27/4/19
var flagCheckRowsMedHist = false;//vijeta 27/4/19
var flagCheckRowsFamiHist = false;//vijeta 27/4/19
var flagCheckRowsAllergyHist = false;//vijeta 27/4/19
var DispAddPatient = false; // Added by Murali on 22/05/2024
var doctCode = "";
var ArrivalRequire = true; // 🔴 CONTROL FLAG
$(document.body).on('click', '#WaitingPats .patNameCls, #VisitedPats .patNameCls', function (e) {

    if (ArrivalRequire == true) {
        // 1. Highlight the selected row
        $("li.patNameCls").attr("style", ""); // Clear style from others
        $(this).attr("style", "color:#0770a9; box-shadow:inset -1px -1px 3px 1px;");

        //var name = $(this).find('label')[1].innerText;
        var name = $(this).find("#PatNameOnly").val();
        var mrNo = $(this).find('#mrNo').val();
        var tranNo = $(this).find('#tranNo').val();
        var age = $(this).find('#age').val();
        var gender = $(this).find('#gender').val();
        var mobile = $(this).find('#mobNO').val();
        var dob = $(this).find('#dob').val();
        var groupType = $(this).attr('data-group'); // From the new logic

        // 2. Format Age/Gender (Matching your logic in PatientSearchNotAppointed)
        var strAge = "";
        if (age.includes(":")) {
            var parts = age.split(":");
            strAge = Number(parts[0]) > 0 ? Number(parts[0]) + " Yrs" :
                Number(parts[1]) > 0 ? Number(parts[1]) + " Months" :
                    Number(parts[2]) + " Days";
        } else {
            strAge = age;
        }
        var strGender = (gender == "M" || gender == "Male") ? "Male" : "Female";

        // 3. Set Sessions
        $.session.set('PatName', name);
        $.session.set('PatAge', strAge);
        $.session.set('PatGender', strGender);
        $.session.set('PatMRNO', mrNo);
        $.session.set('PatTRANNO', tranNo);
        $.session.set('PatMobile', mobile);
        $.session.set('PatDOB', dob);
        $.session.set('PatAge2', age);

        // Determine if completed based on the group
        $.session.set('PatCompleted', groupType === "Completed" ? "Y" : "N");
        $.session.set('PatSelected', "Appointed");

        // 4. Highlight the selected row
        $("li.patNameCls").attr("style", ""); // Clear others
        $(this).attr("style", "color:#0770a9; box-shadow:inset -1px -1px 3px 1px;");

        //// 5. Call Binding Functions
        //if (typeof SetPatientDtl === "function") {
        //    SetPatientDtl();
        //}
        //if (typeof SetCountsForHistory === "function") {
        //    SetCountsForHistory(mrNo);
        //}

        //// 6. Redirect if necessary (Optional - check if your app requires redirect on click)
        //window.location.href = 'ClinicEntry';


        // 4. Handle UI Visibility based on Group
        var btn = $(".btn-save-patstatus");

        if (groupType === "NotArrived") {
            // Step 1: Patient is just an appointment
            $("#MainDiv").hide();
            btn.text("Mark as arrived").attr("data-type", "A").parent().show();
        }
        else if (groupType === "Arrived") {
            // Step 2: Patient is at the desk, show clinical components
            $("#MainDiv").show();
            btn.text("Post to Consultant").attr("data-type", "P").parent().show();
        }
        else if (groupType === "Waiting" || groupType === "Completed") {
            // Step 3: Waiting or Completed, just show data, hide the status button
            $("#MainDiv").show();
            btn.parent().hide();
        }
        // 5. Trigger your existing binding functions
        if (typeof SetPatientDtl === "function") {
            SetPatientDtl();
        }
        if (typeof SetCountsForHistory === "function") {
            SetCountsForHistory(mrNo);
        }
    }
    else {

        glbPatMRNo = e.currentTarget.children[0].id;

        $("#panelClose").trigger("click");

        //var compltdPatLst = $("#VisitedPats .patNameCls").get();  //Change color of names of all patients to black
        //$.each(compltdPatLst, function (index, value) {
        // compltdPatLst[index].children[1].style.color = "black";
        //  });

        e.currentTarget.children[1].style.color = "#3c8dbc"; // set color of selected patient to blue
        var name = e.currentTarget.children[1].innerText;
        var age = e.currentTarget.children[3].defaultValue;
        var gender = e.currentTarget.children[4].defaultValue;
        var mrNo = e.currentTarget.children[5].defaultValue;
        var tranNo = e.currentTarget.children[6].defaultValue;
        // var dob = e.currentTarget.children[7].defaultValue;
        var strMobile = e.currentTarget.children[7].defaultValue;
        var dob = e.currentTarget.children[8].defaultValue;
        var onlpaystat = e.currentTarget.children[9].defaultValue;
        var PatEmail = e.currentTarget.children[10].defaultValue;
        var strAge = "";
        var strGender = "";
        strAge = Number(age.split(":")[0]) > 0 ? Number(age.split(":")[0]) + " Yrs" : Number(age.split(":")[1]) > 0 ? Number(age.split(":")[1]) + " Months" : Number(age.split(":")[2]) + " Days"
        //strAge = (age.charAt(0) == "0") ? e.currentTarget.children[3].defaultValue.toString().substr(1, 2) + "Yrs" : e.currentTarget.children[3].defaultValue.toString().substr(0, 3) + "Yrs";
        strGender = (gender == "M") ? "Male" : "Female";

        $.session.set('PatName', name);
        $.session.set('PatAge', strAge);
        $.session.set('PatGender', strGender);
        $.session.set('PatMobile', strMobile);//

        $.session.set('PatMRNO', mrNo);
        $.session.set('PatTRANNO', tranNo);
        $.session.set('PatDOB', dob);
        $.session.set('onlpaySTAT', onlpaystat);
        $.session.set('PatEmail', PatEmail);

        if ($(this).is('#WaitingPats .patNameCls')) {
            $.session.set('PatCompleted', "N");
        } else if ($(this).is('#VisitedPats .patNameCls')) {
            $.session.set('PatCompleted', "Y");
        }

        SetPatientDtl();
        window.location.href = 'ClinicEntry';
    }
    // }
});

$(document.body).on('click', '#tblDoctors tr', function (e) {

    var doctName = $(this)[0].innerText.toString();
    doctCode = $(this)[0].id;
    $.session.set('DoctName', doctName);
    $.session.set('DoctCode', doctCode);
    $("#DoctorInput").val(doctName);
    $("#tblDoctors tr").hide();
    $("#hdnDoctCode").val(doctCode);
    $.ajax({
        url: '../Clinicalnotes/SetDoctSession',
        data: { strDoctCd: doctCode, strDoctNm: doctName },
        type: 'get',
        datatype: 'json',
        success: function (result) {
        }
    });
    SearchFunction(doctCode);
});
function SearchDoctors() {
    // Declare variables 
    var input, filter, table, tr, td, i;
    input = document.getElementById("DoctorInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("tblDoctors");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    var arr = filter.split(" ");//vijeta 14th may 2019
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            var name = td.innerHTML.toUpperCase();    //vijeta 14th may 2019
            var flagArr = [];//vijeta 14th may 2019
            $.each(arr, function (i, val) {//vijeta 14th may 2019
                if (name.indexOf(val) > -1) {
                    flagArr.push(true);;
                }
                else {
                    flagArr.push(false);;
                }
            });
            if ($.inArray(false, flagArr) == -1 && filter.length > 2) { //td.innerHTML.toUpperCase().indexOf(filter) > -1
                tr[i].style.display = "";

            } else {
                tr[i].style.display = "none";

            }
        }
    }
    $("#DivPatGrid").empty();//vijeta 14th may 2019
    $("#divPrevPrescriptions").empty();//vijeta 14th may 2019
    if (filter == "") {
        SearchFunction("");
    }
}
function GetDoctors() {
    $.ajax({
        url: 'GetDoctors',
        type: 'post',
        datatype: 'json',
        data: {},
        success: function (data) {
            if (data.length > 0) {
                $('#tblDoctors').empty();

                $.each(data, function (i, item) {

                    var rows = "<tr id='" + item.DoctCode + "' style='display:none'>" + "<td>" + item.DoctName + "</td>" + "</tr>";

                    $('#tblDoctors').append(rows);

                });
            }
        }

    });
}

//function SearchFunction(doctCode) {
//    // Pournima 25th Oct 2025
//    if ($("#rbtnYesterday").length > 0 && $("#rbtnYesterday")[0].checked == true)
//        dayType = "Y";
//    else if ($("#rbtnDayBefYest").length > 0 && $("#rbtnDayBefYest")[0].checked == true)
//        dayType = "B";
//    else
//        dayType = "T";
//    //******************************************
//    //$('#grid').clearGridData();
//    var url = "../Clinicalnotes/GetPatientList";
//    //$.loader.open();
//    $.ajax({
//        //url: "<%=Url.Action("GetPatientList", "DoctorDesk")%>",
//        url: url,
//        type: 'post',
//        dataType: 'json',
//        data: {
//            strdoctCode: doctCode,
//            dayType: dayType // Pournima 25th Oct 2025
//        },
//        success: function (result) {
//            var $newDiv1 = $('<div>');
//            $newDiv1.attr("id", "WaitingPats");
//            $newDiv1.attr("name", "WaitingPats");
//            $newDiv1.attr("class", "collapse in indent");
//            var $newul1 = $('<ul>', { style: ' list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:20px;letter-spacing: 0.5px;color:#515151' });
//            $newul1.attr("id", "WaitingPatsdata");

//            var $newDiv2 = $('<div>');
//            $newDiv2.attr("id", "VisitedPats");
//            $newDiv2.attr("name", "VisitedPats");
//            $newDiv2.attr("class", "collapse in indent");
//            var $newul2 = $('<ul>', { style: ' list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:24px;;lettter-spacing:1px' });
//            $newul2.attr("id", "VisitedPatsdata");

//            var $newDiv3 = $('<div>');
//            $newDiv3.attr("id", "completedPat");
//            $newDiv3.attr("name", "completedPat");
//            $newDiv3.attr("class", "collapse in indent");

//            var options1 = "";
//            var options2 = "";

//            var waitingCount = 0;
//            var completedCount = 0;
//            if (result.Result != "Something Went Wrong.") {
//                $.each(result.Result, function (i, item) {
//                    var patName = item.PatName;
//                    var ApptTm = item.APPTTM;
//                    var mrNo = item.MRNO;
//                    var consNo = item.CONSNO;
//                    var timeDiff = item.DIFFTM;
//                    var age = item.Age;
//                    var gender = item.Gender;
//                    var compltdYn = item.CompletedYN;
//                    var ConsDate1 = item.ConsDate.split("/");
//                    var ConsDate = ConsDate1[0] + "/" + ConsDate1[1];
//                    var dob = item.DOB;
//                    var tranNo = (item.TRANNO).toString().trim();
//                    var onlpaystat = (item.OnlyPayStat).toString().trim();
//                    var PatEmail = (item.PatEmail).toString().trim();
//                    var chkSign = Math.sign(timeDiff);
//                    var applyColor = "none";
//                    var coloronlpay = "none";
//                    if (chkSign == 1) {
//                        if (timeDiff > 30) {
//                            //red color
//                            applyColor = "red";
//                        }
//                        else
//                            applyColor = "#e49f21;";
//                        //alert("positive");yellow
//                    }
//                    else if (chkSign == -1) {
//                        applyColor = "green";
//                        //alert("negative"); green
//                    }
//                    else if (chkSign == NaN) {
//                        //alert("No time");
//                    }
//                    if (onlpaystat == "Y") {
//                        coloronlpay = "border: 2px solid #f3d106;background: #75dec1;border-bottom-left-radius: 15px; border-top-right-radius: 15px;";
//                    }
//                    // Meenakshi 14/04/2020
//                    if (compltdYn == "N" || compltdYn.toString().trim() == "") {
//                        waitingCount++;

//                        options1 += "<li class='patNameCls' id='PatName" + item.CONSNO + "' ><label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + " " + ConsDate + "</label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' ></input><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /></li>";
//                    }
//                    else {
//                        completedCount++;
//                        options2 += "<li class='patNameCls' id='PatName" + item.CONSNO + "'><label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + " " + ConsDate + "</label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden  id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' ></input><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /></li>";
//                    }

//                });
//            }
//            //$newul.append(options);
//            //$newDiv.append($newul);
//            var $newHeadngWait = $('<a>');
//            $newHeadngWait.attr("data-toggle", "collapse");
//            $newHeadngWait.attr("data-target", "#WaitingPats");
//            //$newHeadngWait.attr("href", "#WaitingPats");//commented vijeta 2/5/19
//            $newHeadngWait.attr("style", "border: 1px solid #d8acc6;color: #8e0e5a;text-align:left;font-size:13px;border-radius: 2px; background-color: #f9ddedcc; text-decoration: none;margin-left:4px width:99%");
//            $newHeadngWait.attr("class", "btn-group btn-group-justified")
//            $newHeadngWait.attr("data-parent", "#DivPatGrid");

//            var $aspan = $('<i class="moreless fa fa-minus"></i>');
//            $newHeadngWait.append($aspan);
//            //   var $newHeadngWait = $('<a>', {class: 'btn-group btn-group-justified', style: 'border: 1px solid #d8acc6;color: #8e0e5a;text-align: center;font-size:13px;border-radius: 2px; background-color: #f9ddedcc; text-decoration: none;' });
//            if (waitingCount == 0)//added on 12th april 2018
//                $newHeadngWait.append('Waiting');
//            else
//                $newHeadngWait.append('Waiting (' + waitingCount + ')');//added on 12th april 2018

//            $newul1.append(options1);
//            $newDiv1.append($newul1);

//            $newul2.append(options2);
//            $newDiv2.append($newul2);

//            var $newHeadng = $('<a>');
//            $newHeadng.attr("data-toggle", "collapse");
//            $newHeadng.attr("data-target", "#VisitedPats");
//            // $newHeadng.attr("href", "#VisitedPats");//commented vijeta 2/5/19
//            $newHeadng.attr("style", "border: 1px solid #a9dca9;color: #118011;text-align: left;border-radius: 2px; font-size:13px;  background-color: #d6f7d5cf;  text-decoration: none;margin-left:4px; width:99%");//
//            $newHeadng.attr("class", "btn-group btn-group-justified")
//            $newHeadng.attr("data-parent", "#DivPatGrid");

//            var $aspan1 = $('<i class="moreless fa fa-minus"></i>');
//            $newHeadng.append($aspan1);

//            //  var $newHeadng = $('<a>', { class: 'btn-group btn-group-justified', style: 'border: 1px solid #a9dca9;color: #118011;text-align: center;border-radius: 2px; font-size:13px;  background-color: #d6f7d5cf;  text-decoration: none;' });
//            if (completedCount == 0)//added on 12th april 2018
//                $newHeadng.append('Completed');
//            else
//                $newHeadng.append('Completed (' + completedCount + ')');//added on 12th april 2018

//            $newDiv3.append($newHeadng);

//            //$newHeadng.attr("value", "Completed");

//            $('#DivPatGrid').empty();
//            //$('#DivPatGrid').append("<div><label>" + new Date() + "</label></div>");

//            var $DivPatSearch;
//            var $AddPatient;   // Added by Dhananjay 20240702
//            if ($('#divtabs').css('display') != 'none') {
//                $DivPatSearch = "<div id='divBindPat' style='height:35px;text-align:center;'>";
//                //  $('<div>', { style: 'height:35px;text-align:center;margin-left:74px' }); //suchita
//            }
//            else {
//                $DivPatSearch = "<div id='divBindPat' style='height:35px;text-align:center;margin-top:9px'>";
//                //  $('<div>', { style: 'height:35px;text-align:center;margin-left:9px' }); //suchita
//            }

//            $DivPatSearch += "<div class='form-group has-feedback' id='divPatientSearch'><input type='text' style='width:81%; float: left;' class='form-control'  onkeyup='PatientSearch()' placeholder='Search Patient'/><input type='text' style='height:0px;margin-left:5px;-webkit-text-fill-color:white;border:none'/>";
//            $DivPatSearch += "<span class='fa fa-search fa-2x form-control-feedback'  style='color:#3c8dbc;line-height:30px;right: 20%;margin-top:35px;'></span>";

//            //Added by Murali on 22/05/2024
//            //****************************************************************
//            if (DispAddPatient == true) {
//                // $AddPatient = "<div style='float:right;margin-top: 0px;padding-left: 3px;margin-right:5px;' id='divAddPat'><label  title='Add Patient'><img onClick='RedirectToAddPatient()' class='lblImage1' style='height: 40px; width: 40px;' src='../Images/patient2.png' /></label></div></div>";
//                $AddPatient = "<div style='float:right;margin-top: 0px;margin-right:5px;' id='divAddPat'><label  title='Add Patient'><img onClick='RedirectToAddPatient()' class='lblImage1' style='height: 40px; width: 40px;' src='../Images/patient2.png' /></label></div></div>";    // Added by Dhananjay 20240702
//            }
//            //****************************************************************
//            $('#DivPatGrid').append($DivPatSearch);
//            $('#divAddPat').remove();
//            // $('#loggedInfo').append($AddPatient);    // Added by Dhananjay 20240702
//            $('#SubDoctPanel').append($AddPatient);   // Added by Dhananjay 20240702

//            //---------------

//            if (options1 != "") {
//                $('#DivPatGrid').append($newHeadngWait);
//                $('#DivPatGrid').append($newDiv1);
//            }


//            if (options2 != "") {
//                $('#DivPatGrid').append($newHeadng);
//                $('#DivPatGrid').append($newDiv2)
//            }
//            if (result.Result.length == 0) {
//                $('#DivPatGrid').empty();
//                var $NoPatientsDiv = $('<div>', { style: ' text-align: center;font-size:14px;background-color: #d2d6de' });
//                var $lbl = $('<label>', { style: 'margin-top: 2px;' }).html('No Patients');
//                $NoPatientsDiv.append($lbl);
//                $('#DivPatGrid').append($NoPatientsDiv);
//            }
//            $("#tblDoctors tr").hide();
//        },

//        complete: function () {
//            var mrNo = $.session.get('PatMRNO');
//            var tranno = $.session.get('PatTRANNO');
//            if (tranno != null && mrNo != null) {
//                //$("li#PatName" + tranno)[0].style.color = "#3c8dbc";
//                $("li#PatName" + tranno).attr("style", "color:#0770a9;box-shadow:inset -1px -1px 3px 1px;");// added by vijeta on 31st march 2018
//            }
//        },
//        error: function (xhr, textStatus, errorThrown) {

//            $.loader.close();
//        }

//    });
//}

function SearchFunction(doctCode) {//priyanka 01/03/2026
    var dayType = "T";
    if ($("#rbtnYesterday").length > 0 && $("#rbtnYesterday")[0].checked == true)
        dayType = "Y";
    else if ($("#rbtnDayBefYest").length > 0 && $("#rbtnDayBefYest")[0].checked == true)
        dayType = "B";

    var url = "../Clinicalnotes/GetPatientList";

    $.ajax({
        url: url,
        type: 'post',
        dataType: 'json',
        data: {
            strClinicCode: sessionStorage.getItem('ClinicCode'),
            strdoctCode: doctCode,
            dayType: dayType,
            CustomeDate: 0,
            Type:""
        },
        success: function (result) {
            var optionsNotArrived = "", optionsArrived = "", optionsWaiting = "", optionsCompleted = "";
            var countNotArrived = 0, countArrived = 0, countWaiting = 0, countCompleted = 0;

            if (result.Result != "Something Went Wrong.") {
                $.each(result.Result, function (i, item) {
                    var compltdYn = (item.CompletedYN || "").toString().trim();
                    var arrivedYn = (item.ARRIVEDYN || "").toString().trim();
                    var postToConsYn = (item.POSTTOCONSYN || "").toString().trim();

                    var ConsDate1 = item.ConsDate.split("/");
                    var ConsDate = ConsDate1[0] + "/" + ConsDate1[1];
                    var chkSign = Math.sign(item.DIFFTM);
                    var applyColor = "none";

                    //priyanka 05/03/2026
                    var VisitTypeCD = item.VisitType;
                    var RRYN = item.ReviewRYN;
                    var ApmntNo = item.Appmntno;
                    if (ApmntNo === "" || ApmntNo === null) {
                        VisitTypeColor = "#2bb582";
                    }
                    else {
                        VisitTypeColor = "#3aa4e3";
                    }

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

                    if (chkSign == 1) {
                        applyColor = item.DIFFTM > 30 ? "red" : "#e49f21;";
                    } else if (chkSign == -1) {
                        applyColor = "green";
                    }

                    var coloronlpay = (item.OnlyPayStat || "").toString().trim() == "Y"
                        ? "border: 2px solid #f3d106;background: #75dec1;border-bottom-left-radius: 15px; border-top-right-radius: 15px;"
                        : "none";

                    var groupType = "";
                    if (compltdYn === "Y") groupType = "Completed";
                    else if (postToConsYn === "Y") groupType = "Waiting";
                    else if (arrivedYn === "Y") groupType = "Arrived";
                    else groupType = "NotArrived";

                    // var liHtml = "<li class='patNameCls' id='PatName" + item.CONSNO + "' >" +
                    var liHtml = "<li class='patNameCls' data-group='" + groupType + "' id='PatName" + item.CONSNO + "' >" +
                        //"<label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + item.APPTTM + " " + ConsDate + "</label>" +
                        "<label style='padding-left:2px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" //priyanka 05/03/2026
                        + item.APPTTM + " " + ConsDate
                        + "<span style='color:" + VisitTypeColor + " ;margin-left:5px;'>" + VisitType + "</span> "
                        + "</label>" +

                        "<label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + item.MRNO + "'>" +
                        item.PatName +
                        " <span style='font-weight:bold;'>(" + item.MRNO + ")</span>" +
                        "</label>" +

                        "<input type='hidden' id='PatNameOnly' value='" + item.PatName + "' />" +

                        "<input type='hidden' id='wtngTm' value='" + item.DIFFTM + "' ></input>" +
                        "<input type=hidden id='age' value='" + item.Age + "' ></input>" +
                        "<input type=hidden id='gender' value='" + item.Gender + "' ></input>" +
                        "<input type=hidden id='mrNo' value='" + item.MRNO + "' ></input>" +
                        "<input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input>" +
                        "<input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input>" +
                        "<input type=hidden id='dob' value='" + item.DOB + "' ></input>" +
                        "<input type=hidden id='onlpaystat' value='" + item.OnlyPayStat + "' />" +
                        "<input type=hidden id='PatEmail' value='" + item.PatEmail + "' />" +
                        "<input type=hidden id='Visittype' value='" + item.VisitType + "' />" +
                        "<input type=hidden id='ReviewRptYN' value='" + item.ReviewRYN + "' />" +
                        "<input type=hidden id='CompanyName' value='" + item.CompName + "' />" +
                        "<input type=hidden id='DoctorName' value='" + item.DoctorName + "' /></li > ";

                    if (typeof ArrivalRequire !== 'undefined' && ArrivalRequire === true) {
                        if (compltdYn === "Y") {
                            optionsCompleted += liHtml;
                            countCompleted++;
                        } else if (postToConsYn === "Y") {
                            optionsWaiting += liHtml;
                            countWaiting++;
                        } else if (arrivedYn === "Y") {
                            optionsArrived += liHtml;
                            countArrived++;
                        } else {
                            optionsNotArrived += liHtml;
                            countNotArrived++;
                        }
                    } else {
                        if (compltdYn === "N" || compltdYn === "") {
                            optionsWaiting += liHtml;
                            countWaiting++;
                        } else {
                            optionsCompleted += liHtml;
                            countCompleted++;
                        }
                    }
                });
            }
            $('#DivPatGrid').empty();

            var searchHtml = "<div id='divBindPat' style='height:35px;text-align:center;" + ($('#divtabs').css('display') != 'none' ? "" : "margin-top:9px") + "'>";
            searchHtml += "<div class='form-group has-feedback' id='divPatientSearch'><input type='text' style='width:98%;margin-bottom: 10px; margin-left: 2px;float: left;' class='form-control' onkeyup='PatientSearch()' placeholder='Search Patient'/><input type='text' style='height:0px;margin-left:5px;-webkit-text-fill-color:white;border:none'/>";
            searchHtml += "<span class='fa fa-search fa-2x form-control-feedback' style='color:#3c8dbc;line-height:30px;right: 0%;margin-top:35px;'></span></div>";
            $('#DivPatGrid').append(searchHtml);

            if (typeof DispAddPatient !== 'undefined' && DispAddPatient == true) {
                $('#divAddPat').remove();
                var addPatHtml = "<div style='float:right;margin-top: 0px;margin-right:5px;' id='divAddPat'><label title='Add Patient'><img onClick='RedirectToAddPatient()' class='lblImage1' style='height: 40px; width: 40px;' src='../Images/patient2.png' /></label></div>";
                $('#SubDoctPanel').append(addPatHtml);
            }

            // 1. Not Arrived (Yellowish)
            if (optionsNotArrived !== "") {
                appendSectionHtml("Not Arrived", "NotArrived", optionsNotArrived, countNotArrived, "#fcf8e3", "#8a6d3b");
            }
            // 2. Arrived (Greenish)
            if (optionsArrived !== "") {
                appendSectionHtml("Arrived", "ArrivedPats", optionsArrived, countArrived, "#dff0d8", "#3c763d");
            }
            // 3. Waiting (Your existing Pink/Purple)
            if (optionsWaiting !== "") {
                appendSectionHtml("Waiting", "WaitingPats", optionsWaiting, countWaiting, "#f9ddedcc", "#8e0e5a");
            }
            // 4. Completed (Your existing Light Green)
            if (optionsCompleted !== "") {
                appendSectionHtml("Completed", "VisitedPats", optionsCompleted, countCompleted, "#d6f7d5cf", "#118011");
            }
            if (result.Result.length == 0) {
                $('#DivPatGrid').append("<div style='text-align:center;font-size:14px;background-color:#d2d6de'><label style='margin-top:2px;'>No Patients</label></div>");
            }

            $("#tblDoctors tr").hide();
        },
        complete: function () {
            var tranno = $.session.get('PatTRANNO');
            //priyanka 05/03/2026
            var tranno = sessionStorage.getItem("PatTRANNO");
            if (tranno != null) {
                $("li#PatName" + tranno).attr("style", "color:#0770a9;box-shadow:inset -1px -1px 3px 1px;");
                var id = "#PatName" + tranno;
                $(id).trigger("click");
            }
            //end
        },
        error: function () { $.loader.close(); }
    });
}
function appendSectionHtml(title, id, options, count, bgColor, borderColor) {
    var header = "<div data-toggle='collapse' data-target='#" + id + "' style='border: 1px solid " + borderColor + ";color: " + borderColor + ";text-align:left;font-size:13px;border-radius: 2px; background-color: " + bgColor + "; text-decoration: none;margin-left:4px; width:98%' class='btn-group btn-group-justified'><i class='moreless fa fa-minus'></i> " + title + " (" + count + ")</div>";
    var content = "<div id='" + id + "' class='collapse in indent'><ul id='" + id + "data' style='list-style: none; float: left;font-size: 11px; margin-left: -35px;line-height:20px;letter-spacing: 0.5px;color:#515151'>" + options + "</ul></div>";
    $('#DivPatGrid').append(header).append(content);
}

function RedirectToAddPatient() {
    window.location.href = "../DoctorDesk/AddPatient?FromTriage=Y";
}
//**************************************

function setPOtherDetail() {
    if ($.session.get('PatAge') != "")
        $("#DivpatDtls i").show();
    else
        $("#DivpatDtls i").hide();
    //kavita

    $("#DivpatDtls label#lblAge").text($.session.get('PatAge'));
    var gen = $.session.get('PatGender').toString().concat(" |");//kavita
    gen = $.session.get('PatMRNO').concat(" |") + $.session.get('PatGender').toString().concat(" |");
    $("#DivpatDtls label#lblGender").text(gen);//kavita

    if ($.session.get('onlpaySTAT') == "Y")
        $("#btnwhtsup").addClass("fa fa-whatsapp");
    else
        $("#btnwhtsup").removeClass("fa fa-whatsapp");
    $("#CompanyNM").hide()
    if ($.session.get('PatCompyName') != null && $.session.get('PatCompyName').toString().trim() != "") {
        $("#CompanyNM").text((" | " + $.session.get('PatCompyName').toString().trim()));
        $("#CompanyNM").show();
    }
    if ($.session.get('PatDoctorName')) {
        if (document.getElementById("divSelectedDoctorHdr"))
            document.getElementById("divSelectedDoctorHdr").style.display = "block";
        $("#lblSelectedDoctorName").text("Dr. " + $.session.get('PatDoctorName'));
    }
    else {
        if (document.getElementById("divSelectedDoctorHdr"))
            document.getElementById("divSelectedDoctorHdr").style.display = "none";
        $("#lblSelectedDoctorName").text("");
    }

}

function SetPatientDtl() {
    if ($.session.get('PatName') != null && $.session.get('PatAge') != null && $.session.get('PatGender') != null) {
        // added by kavita 29-8-18
        var P_name_val = $.session.get('PatName');
        if ($(window).width() < 996) {
            if (P_name_val.length > 30) {
                var P_New_Val = P_name_val.substr(0, 30);
                $("#DivpatDtls h5").text(P_New_Val);
                setPOtherDetail();
            }
            else {
                $("#DivpatDtls h5").text($.session.get('PatName'));
                setPOtherDetail();
            }
        }
        else {
            $("#DivpatDtls h5").text($.session.get('PatName'));
            setPOtherDetail();
        }
    }




}

$(document.body).on('click', '#tbladdict tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {


        //..........................
        var selRows = $('#tbladdict > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tbladdict tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tbladdict > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }

        //...end...............


        $(this).children('td').children('a').show();


    }
    else {
        $(this).children('td').children('a').hide();

    }

    var rows = $('#tbladdict tbody  tr:not(.active)').get();

    $.each(rows, function (index, row) {
        $('#tbladdict').children('tbody').append(row);
    });
    //vijeta 27/4/19
    $("#AddictionInput").val("").trigger("keyup");// 19-12-19
    if ($(this).hasClass('active') && !flagCheckRowsPerHist) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        $(this).find('a.trigger1').trigger('click');
    }


});
$(document.body).on('click', '#tblmedical tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {

        //..........................
        var selRows = $('#tblmedical > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tblmedical tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tblmedical > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }
        //...........end.................

        $(this).children('td').children('a').show();
        // selected rows moved to top  

    }
    else {
        $(this).children('td').children('a').hide();

    }

    //vijeta 27/4/19

    var rows = $('#tblmedical tbody  tr:not(.active)').get();

    $.each(rows, function (index, row) {
        $('#tblmedical').children('tbody').append(row);
    });
    $("#MedicalInput").val("").trigger("keyup");// 19-12-19
    if ($(this).hasClass('active') && !flagCheckRowsMedHist) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        $(this).find('a.trigger1').trigger('click');
    }

});

//kavita 20-sep-2019
$(document.body).on('click', '#tblAllergy tr', function (e) {
    $(this).toggleClass('active');
    if ($(this).hasClass('active')) {
        //$("#tblAllergy tbody").prepend($(this)).closest('tr');

        //..........................
        var selRows = $('#tblAllergy > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tblAllergy tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tblAllergy > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
        }
        //end........................
        $(this).children('td').children('a').show();
        //$(this).children('td').children('input').show();
        // selected rows moved to top  
    }
    else {
        $(this).children('td').children('a').hide();
        //$(this).children('td.remark').find('input.triggerInputRemark')[0].value = "";//dose
        //$(this).children('td').children('input').hide();
    }

    //.....................
    var rows = $('#tblAllergy tbody  tr:not(.active)').get();

    $.each(rows, function (index, row) {
        $('#tblAllergy').children('tbody').append(row);
    });

    //end........................
    $("#AllergyInput").val("").trigger("keyup");// 19-12-19
    if ($(this).hasClass('active') && !flagCheckRowsAllergyHist) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        $(this).find('a.trigger1').trigger('click');
    }
});
//kavita 20-sep-2019
$(document.body).on('click', '#tblfamily tbody tr', function (e) {

    $(this).addClass('active');

    if ($(this).hasClass('active')) {

        //$("#tblfamily tbody").prepend($(this)).closest('tr');

        $(this).children('td').children('a').show();
        $(this).children('td').children('i').show();
        // selected rows moved to top  

    }
    else {
        $(this).children('td').children('a').hide();
        $(this).children('td').children('i').hide();
    }

    //vijeta 27/4/19
    if ($(this).hasClass('active') && !flagCheckRowsFamiHist) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        $(this).find('a.trigger1').trigger('click');
    }
});

$(document.body).on('click', '.removeRelation', function (e) {
    e.stopPropagation();

    $(this).closest('tr').remove();

    var i = $("#tblfamily tbody tr").length + 1;

    var row = "<tr class='clickable-row' id='" + i + "'>" +
        "<td class='rel' style='width:12%;'>" +
        "<a class='trigger1' href='javascript:;' data-layer-id='layer-Rel' id='Rel" + i + "' style='display:none;font-weight:800;font-size:16px;'>None</a>" +
        "</td>" +
        "<td class='age' style='width:5%;'>" +
        "<a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Age" + i + "' style='display:none;font-weight:800;font-size:16px;'>0</a>" +
        "</td>" +
        "<td class='dis' style='width:15%;'>" +
        "<a class='trigger3' href='javascript:;' data-layer-id='layer-Dis' id='Dis" + i + "' style='display:none;font-weight:800;font-size:16px;'>None</a>" +
        "</td>" +
        "<td class='duration' style='width:4%;'>" +
        "<a class='trigger5' href='javascript:;' data-layer-id='layer-days' id='Num" + i + "' style='display:none;font-weight:800;font-size:16px;'>0</a>" +
        "</td>" +
        "<td class='day-td' style='width:4%;'>" +
        "<a class='trigger4' href='javascript:;' data-layer-id='layer-DMY' id='Days" + i + "' style='display:none;font-weight:800;font-size:16px;'>D</a>" +
        "</td>" +
        "<td class='DiaDate' style='width:10%; padding: 0px 2px;'>" +
        "<input type='text' id='DiaDate" + i + "' class='form-control form-control-sm DatePick trigger6' data-layer-id='layer-DiaDate' style='display:none;' readonly />" +
        "</td>" +
        "<td class='DisStatus' style='width:10%;'>" +
        "<a class='trigger7' href='javascript:;' data-layer-id='layer-DisStatus' id='DisStatus" + i + "' style='display:none;font-weight:800;font-size:16px;'>-</a>" +
        "</td>" +
        "<td class='Alive' style='width:5%; text-align:center;'>" +
        "<input type='checkbox' id='Alive" + i + "' class='trigger8' data-layer-id='layer-Alive' style='display:none;' />" +
        "</td>" +
        "<td class='DeathDate' style='width:10%;'>" +
        "<input type='text' id='DeathDate" + i + "' class='form-control form-control-sm DatePick trigger9' data-layer-id='layer-DeathDate' style='display:none;' readonly />" +
        "</td>" +
        "<td class='CauseDeath' style='width:15%;'>" +
        "<input type='text' id='CauseDeath" + i + "' class='form-control form-control-sm trigger10' data-layer-id='layer-CauseDeath' placeholder='Cause of death' style='display:none;' />" +
        "</td>" +
        "<td style='width:5%; text-align:center; vertical-align:middle;'>" +
        "<i class='fa fa-trash-o removeRelation' style='cursor:pointer;'></i>" +
        "</td>" +
        "</tr>";

    $('#tblfamily tbody').append(row);

    document.getElementById('layer-demo').style.display = "none";
    document.getElementById('layer-Dis').style.display = "none";
    document.getElementById('layer-days').style.display = "none";
    document.getElementById('layer-DMY').style.display = "none";
    document.getElementById('layer-DiaDate').style.display = "none";
    document.getElementById('layer-DisStatus').style.display = "none";
    document.getElementById('layer-Alive').style.display = "none";
    document.getElementById('layer-DeathDate').style.display = "none";
    document.getElementById('layer-CauseDeath').style.display = "none";
    document.getElementById('layer-Rel').style.display = "none";
});

//added on 28th march 2018
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
//------------------------------

$(document.body).on('click', '.trigger1,.trigger2,.trigger3,.trigger4,.trigger5,.trigger6,.trigger7,.trigger8,.trigger9,.trigger10', function (e) {
    e.stopPropagation();
    idOfDMY = $(this).attr("id");
    //  $('.trigger2').height(100);

    $("#trigger2").css({ top: '100px' });

    // var trigr1 = document.getElementById('layer-DMY');
    document.getElementById("layer-DMY").style.marginTop = "-10px";


});

//function CheckPatSessionNotEmpty() {
//    var mrNo = $.session.get('PatMRNO');
//    var tranno = $.session.get('PatTRANNO');
//    if (mrNo != undefined) {
//        if ($.session.get('PatSelected') == "Appointed")
//            return true;
//    }

//    else
//        return false;
//}

function CheckPatSessionNotEmpty() {
    var mrNo = $.session.get('PatMRNO');
    var tranno = $.session.get('PatTRANNO');

    if (tranno != null && mrNo != null) {

        if (mrNo != "" && tranno != "") {
            if ($.session.get('PatSelected') == "Appointed")
                return true;
        }
        else
            return false;
    }
    else {
        if (Vaccineflag == 1) {

            if (mrNo != "" && mrNo != null)
                return true;
            else
                return false;
        }
        else
            return false;
    }
}

//vijeta 10/5/19
function CheckPatMRNotEmpty() {
    var mrNo = $.session.get('PatMRNO');
    if (mrNo != undefined) {
        return true;
    }

    else
        return false;
}

function AddFreeHistory(type) {
    var Mrno = ($.session.get('PatMRNO'));
    var strTran = ($.session.get('PatTRANNO'))
    $.confirm({
        title: '',
        content: '' +
            '<form action="" class="formFreeText" >' +
            '<div class="form-group">' +
            '<label>Free Text</label>' +
            '<textarea id="txtFreeHistory" maxlength="500"  placeholder="Enter free text" autofocus="autofocus" class="complaint form-control" required rows="5" cols="30" />' +
            '</form>',
        buttons: {
            formSubmit: {
                text: 'Save',
                btnClass: 'btn-blue',
                action: function () {
                    var txt = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');;
                    if ($("#freeHandBtn").css("background-color") != "rgb(0, 128, 0)") {  //27-11-2019 12:16
                        if (txt.length == 0) {
                            $.alert('Enter Complient');
                            this.$content.find('.complaint').val(""); //added by 10/12/2019 12:37
                            return false;
                        }
                    }
                    $.ajax({
                        type: "post",
                        datatype: "json",
                        url: '../Clinicalnotes/AddFreeHistory',
                        data: { strText: txt, strTran: strTran, strMrNo: Mrno, strType: type },
                        success: function (response) {


                            if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                                $.messager.alert("Information", "Record Not Inserted.");
                            }
                            else {
                                $("#txtFreeHistory").val(txt);
                                freeHandHistory = txt;

                                if (txt != "") {
                                    $.messager.alert("Information", "Record inserted successfully");
                                    $("#freeHandBtn").css("background-color", "green");
                                }
                                else {
                                    //  $.messager.alert("Information", "History removed");
                                    $("#freeHandBtn").css("background-color", "#398ebd");
                                    return false;
                                }

                            }
                        },

                    });
                    // }

                }
            },
            Remove: function () {
                $("#txtFreeHistory").val("");
                $('.formFreeText').submit();
            },
            close: function () {
                //close
                //$('.FoodItems input:checked').focus();
            },


        },
        onContentReady: function () {
            $('#txtFreeHistory').focus();
            $('#txtFreeHistory').val(freeHandHistory);
            // bind to events
            var jc = this;
            this.$content.find('form').on('submit', function (e) {
                // if the user submits the form by pressing enter in the field.
                e.preventDefault();
                jc.$$formSubmit.trigger('click'); // reference the button and click it
            });
            //29-11-2019  18:37
            if ($('#txtFreeHistory').val() == "") {
                jc.$$Remove.attr("style", "display:none")
            }
        }
    });
}

//vijeta 10/5/19
function GetPreviousPrescriptions() {
    var strMrNo = $.session.get('PatMRNO');
    $.ajax({
        type: 'get',
        datatype: 'json',
        data: { strMrNo: strMrNo },
        url: '../DoctorDesk/GetPatPresc',
        success: function (response) {
            $("#divPrevPrescriptions").empty();
            if (response != null) {
                var tempData = "";
                tempData = tempData + "<div class='row'>"
                $.each(response, function (i, item) {
                    var drName = ((item.DOCTNAME) != "") ? "<label style='margin-left:-2px;'><b>(Dr. " + item.DOCTNAME + ")</b></label>" : "";

                    tempData = tempData + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer;caption-side: bottom' id='" + item.TRANNO + "'  onclick='GetBindingData(this)' class='img-responsive'/>" +
                        "<label id='lbl" + parseInt(i + 1) + "' style='font-size:12px;color:#4541ea;margin-top:3px;margin-bottom:0px;' title='" + item.TRANNO + "'>" + item.TRANDATE + "</label>" + drName + "";
                    tempData = tempData + "</div>";
                });
                tempData = tempData + "</div>";

                //$("#divPrevPrescriptions").innerHTML(tempData);
                $("#divPrevPrescriptions").append(tempData);
            }
        }
    });
}

function PatientSearchNotAppointed() {
    var strMrOrname = $("#txtPatSearchNotAppntd").val();
    $.loader.open();
    $.ajax({
        url: '../DoctorDesk/SearchNotAppointedPatients',
        data: { strMrName: strMrOrname },
        type: 'post',
        datatype: 'json',
        success: function (data) {
            if (data != "") {
                $("#tblPatList").empty();
                $.each(data, function (i, val) {
                    var row = "<tr style='border-bottom:1px solid #dedada' id='" + val.MRNO + "'><td><label style='font-size:12px;font-weight:normal'>" + val.NAME + "</label><input type='hidden' class='ageCls' value='" + val.AGE + "' /><input type='hidden' class='dobCls' value='" + val.PATDOB + "' /><input type='hidden' class='genderCls' value='" + val.GENDER + "' /><input type='hidden' class='mobileCls' value='" + val.MOBILE + "' /></td></tr>";
                    $("#tblPatList").append(row);
                });
                $.loader.close();
            }
            $.loader.close();
        },
        error: function () {
            $.loader.close();
        },
    })
}
$(document.body).on('click', '#tblPatList tr', function (e) {
    var name = $(this).find('label')[0].innerText;
    var age = $(this).find('input.ageCls')[0].value;
    var gender = $(this).find('input.genderCls')[0].value;
    var mrNo = $(this)[0].id;
    var dob = $(this).find('input.dobCls')[0].value;
    //var tranNo = e.currentTarget.children[6].defaultValue;
    var strMobile = $(this).find('input.mobileCls')[0].value;

    var strAge = "";
    var strGender = "";
    strAge = Number(age.split(":")[0]) > 0 ? Number(age.split(":")[0]) + " Yrs" : Number(age.split(":")[1]) > 0 ? Number(age.split(":")[1]) + " Months" : Number(age.split(":")[2]) + " Days"
    //strAge = (age.charAt(0) == "0") ? $(this).find('input.ageCls')[0].value.toString().substr(1, 2) + "Yrs" : $(this).find('input.ageCls')[0].value.toString().substr(0, 3) + "Yrs";
    strGender = (gender == "M") ? "Male" : "Female";

    $.session.set('PatName', name);
    $.session.set('PatAge', strAge);
    $.session.set('PatGender', strGender);
    $.session.set('PatMobile', strMobile);
    $.session.set('PatAge2', age);
    $.session.set('PatDOB', dob)


    $.session.set('PatMRNO', mrNo);
    $.session.set('PatTRANNO', "");

    $.session.set('PatCompleted', "N");
    $.session.set('PatSelected', "NotAppointed");

    // patCompletedYN = $.session.get('PatCompleted');
    SetPatientDtl();
    SetCountsForHistory(mrNo)
    window.location.href = 'ClinicEntry';
});

//vijeta 14th may 2019
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


function SavePatientArrival(Type) {
    $.ajax({
        url: "../DoctorDesk/SavePatientConsltStatus",
        type: 'POST',
        data: {
            ConsNo: $.session.get('PatTRANNO'),
            markStatus: Type,
        },
        success: function (response) {
            if (response.Success || response === "Success") {
                alert("Status updated successfully.");
                $("#MainDiv").hide();
                $(".btn-save-patstatus").parent().hide();
                SearchFunction(doctCode);  //
            } else {
                alert(response.Message, "error");
            }
        },
        error: function () {
            alert("Error occurred while saving status.", "error");
        },
    });
}


$(document.body).on('click', 'li.patNameCls', function () {
    // 1. Highlight the selected row
    $("li.patNameCls").attr("style", ""); // Clear style from others
    $(this).attr("style", "color:#0770a9; box-shadow:inset -1px -1px 3px 1px;");

    //var name = $(this).find('label')[1].innerText;
    var name = $(this).find("#PatNameOnly").val();
    var mrNo = $(this).find('#mrNo').val();
    var tranNo = $(this).find('#tranNo').val();
    var age = $(this).find('#age').val();
    var gender = $(this).find('#gender').val();
    var mobile = $(this).find('#mobNO').val();
    var dob = $(this).find('#dob').val();
    var groupType = $(this).attr('data-group'); // From the new logic
    var CompanyNM = $(this).find('#CompanyName').val();
    var DoctorNM = $(this).find('#DoctorName').val(); 
    // 2. Format Age/Gender (Matching your logic in PatientSearchNotAppointed)
    var strAge = "";
    if (age.includes(":")) {
        var parts = age.split(":");
        strAge = Number(parts[0]) > 0 ? Number(parts[0]) + " Yrs" :
            Number(parts[1]) > 0 ? Number(parts[1]) + " Months" :
                Number(parts[2]) + " Days";
    } else {
        strAge = age;
    }
    var strGender = (gender == "M" || gender == "Male") ? "Male" : "Female";

    // 3. Set Sessions
    $.session.set('PatName', name);
    $.session.set('PatAge', strAge);
    $.session.set('PatGender', strGender);
    $.session.set('PatMRNO', mrNo);
    $.session.set('PatTRANNO', tranNo);
    $.session.set('PatMobile', mobile);
    $.session.set('PatDOB', dob);
    $.session.set('PatAge2', age);
    $.session.set('PatCompyName', CompanyNM);
    $.session.set('PatDoctorName', DoctorNM);
    if (DoctorNM) {
        if (document.getElementById("divSelectedDoctorHdr"))
            document.getElementById("divSelectedDoctorHdr").style.display = "block";
        $("#lblSelectedDoctorName").text("Dr. " + DoctorNM);
    }
    else {
        if (document.getElementById("divSelectedDoctorHdr"))
            document.getElementById("divSelectedDoctorHdr").style.display = "none";
        $("#lblSelectedDoctorName").text("");
    }

    // Determine if completed based on the group
    $.session.set('PatCompleted', groupType === "Completed" ? "Y" : "N");
    $.session.set('PatSelected', "Appointed");

    // 4. Highlight the selected row
    $("li.patNameCls").attr("style", ""); // Clear others
    $(this).attr("style", "color:#0770a9; box-shadow:inset -1px -1px 3px 1px;");

    //// 5. Call Binding Functions
    //if (typeof SetPatientDtl === "function") {
    //    SetPatientDtl();
    //}
    //if (typeof SetCountsForHistory === "function") {
    //    SetCountsForHistory(mrNo);
    //}

    //// 6. Redirect if necessary (Optional - check if your app requires redirect on click)
    //window.location.href = 'ClinicEntry';


    // 4. Handle UI Visibility based on Group
    GetAllCounts();//priyanka 12/03/2026
    var btn = $(".btn-save-patstatus");

    if (groupType === "NotArrived") {
        // Step 1: Patient is just an appointment
        $("#MainDiv").hide();
        btn.text("Mark as arrived").attr("data-type", "A").parent().show();
    }
    else if (groupType === "Arrived") {
        // Step 2: Patient is at the desk, show clinical components
        $("#MainDiv").show();
        //btn.text("Post to Consultant").attr("data-type", "P").parent().show();

        btn.text("Post to Consultant");
        if (isVitalsCompleted.trim() === "Y") {
            btn.attr("onclick", "SavePatientArrival('P')");
        }
        else {
            btn.removeAttr("onclick");
            if (showVitalsAlert == "Y") {
                btn.attr("onclick", "ValidationForPostConslt()");
            }
            else {
                btn.attr("onclick", "SavePatientArrival('P')");
            }
            //btn.attr("onclick", /*"SavePatientArrival('P')"*/);  // SavePatientArrival Comment By Abhishesh
        }
    }
    else if (groupType === "Waiting" || groupType === "Completed") {
        // Step 3: Waiting or Completed, just show data, hide the status button
        $("#MainDiv").show();
        btn.parent().hide();
    }
    // 5. Trigger your existing binding functions
    if (typeof SetPatientDtl === "function") {
        SetPatientDtl();
    }
    if (typeof SetCountsForHistory === "function") {
        SetCountsForHistory(mrNo);
    }
});

//function ValidationForPostConslt() {
//    if (isVitalsCompleted == "N") {
//        alert("Please Enter Vitals", "Information");
//        return false;
//    }
//}

function ValidationForPostConslt() {
    alert("Please Enter Vitals", "Information");
    return false;
}