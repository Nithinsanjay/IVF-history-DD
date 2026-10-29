$(document.body).on('click', '#tblPatientLst tr', function () {

    var name = $(this).children('td#salu')[0].innerText + " " + $(this).children('td#patName')[0].innerText;
    var gender = $(this).children('td#gender')[0].innerText;
    var ipNo = $(this).children('td#ipNo')[0].innerText;
    var mrNo = $(this).children('td#mrNo')[0].innerText;
    var bedNo = $(this).children('td#bedNo')[0].innerText;
    var admnDt = $(this).children('td#admndate')[0].innerText;
    var age = $(this).children('td#age')[0].innerText;
    var NurstCode = $(this).children('td#nurstCode')[0].innerText;
    var strAge = "";
    //strAge = (age.charAt(0) == "0") ? $(this).children('td#age')[0].innerText.toString().substr(0, 2) + "Yrs" : $(this).children('td#age')[0].innerText.toString().substr(0, 2) + "Yrs";
    //strAge = $(this).children('td#age')[0].innerText.toString().substr(0, 2) + "Yrs";//commented by vijeta on 30t may 2018
    strAge = SetAgeString(age);

    //var strGender = "";//commented by vijeta on 30t may 2018
    //strGender = gender == "M" ? "Male" : "Female";//commented by vijeta on 30t may 2018

    $.session.set('ICUPatName', name);
    //$.session.set('ICUPatGender', strGender);//commented by vijeta on 30t may 2018
    $.session.set('ICUPatGender', gender);//added on 30t may 2018
    $.session.set('ICUPatIPNO', ipNo);
    $.session.set('ICUPatMRNO', mrNo);
    $.session.set('ICUPatBedNo', bedNo.trim().substr(-3));
    $.session.set('ICUPatAdmnDate', admnDt);
    $.session.set('ICUPatAge', strAge);
    $.session.set('ICUPatNurstCode', NurstCode);


    SetPatientDtl();
    window.location.href = 'ICUReport';
});

//added on 30th may 2018
function SetAgeString(age) {
    var arr;
    if (age.indexOf(".") !== -1)
        arr = age.split(".");
    else if (age.indexOf(":") !== -1)
        arr = age.split(":");
    var yearVal = Number(arr[0]);
    var monthVal = Number(arr[1]);
    var strToReturn = ((yearVal != 0) ? yearVal.toString() + " " + "Yrs" : "") + ((yearVal != 0) ? " " : "") + ((monthVal != 0) ? monthVal.toString() + " " + "Months" : "");
    return strToReturn;
}

//added by kavita 28-8-18
function setPOtherDetail() {
    if ($.session.get('ICUPatBedNo') != "")
        $("#DivpatDtls .lblVerticalLine").show();
    else
        $("#DivpatDtls .lblVerticalLine").hide();
    //kavita
    var bedno = $.session.get('ICUPatBedNo').toString().concat(" |");
    $("#DivpatDtls label#lblBedNo").text("Bed " + bedno);
    //var gender = $.session.get('ICUPatGender').toString().concat(" |");
    var gender = $.session.get('ICUPatMRNO').concat(" |") + $.session.get('ICUPatGender').toString().concat(" |");
    $("#DivpatDtls label#lblGender").text(gender);
    $("#DivpatDtls label#lblAge").text($.session.get('ICUPatAge'));
}

function SetPatientDtl() {

    if ($.session.get('ICUPatName') != null && $.session.get('ICUPatIPNO') != null && $.session.get('ICUPatMRNO') != null && $.session.get('ICUPatBedNo') != null && $.session.get('ICUPatGender') != null) {

        //added by kavita 28-8-18
        var IP_name_val = $.session.get('ICUPatName');
        if ($(window).width() < 996) {
            if (IP_name_val.length > 30) {
                var IP_New_Val = IP_name_val.substr(0, 30);
                $("#DivpatDtls h5").text(IP_New_Val);
                setPOtherDetail();
            }
            else {
                $("#DivpatDtls h5").text($.session.get('ICUPatName'));
                setPOtherDetail();
            }
        }
        else {
            $("#DivpatDtls h5").text($.session.get('ICUPatName'));
            setPOtherDetail();
            //if ($.session.get('ICUPatBedNo') != "")
            //    $("#DivpatDtls .lblVerticalLine").show();
            //else
            //    $("#DivpatDtls .lblVerticalLine").hide();
            ////kavita
            //var bedno = $.session.get('ICUPatBedNo').toString().concat(" |");
            //$("#DivpatDtls label#lblBedNo").text("Bed " + bedno);
            //var gender = $.session.get('ICUPatGender').toString().concat(" |");
            //$("#DivpatDtls label#lblGender").text(gender);
            //$("#DivpatDtls label#lblAge").text($.session.get('ICUPatAge'));
        }
        //kavita
    }

}

function GetNursStationsNPAtients(flag) {
    if (typeof flag === "undefined" || flag === null) {
        flag = "N";
    }

    if (($(window).width() >= 996) || ($(window).width() < 996 && flag == "Y")) {                                            //screen width size comparion
        $.ajax({
            url: 'GetNursStationsNPAtients',
            type: 'post',
            datatype: 'json',
            data: {},
            success: function (data) {

                if (data.length > 0) {
                    //for each nusing station bind patientList in separate ul

                    if (data[0].length > 0) //data[0] contains Nursing Station list
                    {
                        $("#PatListPanelDiv").empty();

                        $.each(data[0], function (key, value) {

                            var $NurstDiv = $('<div>');
                            $NurstDiv.attr("id", "NurstDiv" + value.Value);
                            //$NurstDiv.attr("class", "panel contact_item");
                            $NurstDiv.attr("class", "contact_item");
                            $NurstDiv.attr("style", "margin-bottom: 4px;");

                            var $NursDivHead = $('<div>');
                            $NursDivHead.attr("class", "panel-heading divHeads");
                            $NursDivHead.attr("style", "height:25px;padding-top:5px;");

                            var $a = $('<a>');
                            $a.attr("data-toggle", "collapse");
                            $a.attr("data-target", "#CollapseDiv" + value.Value);
                            $a.attr("href", "#CollapseDiv" + value.Value);
                            $NursDivHead.append($a);
                            $a.attr("data-parent", "#PatListPanelDiv");

                            //added on 13th aug 2018
                            var $divInAnchor = $('<div>');
                            $divInAnchor.attr("style", "width:100%");
                            $a.append($divInAnchor);

                            var $NurseDivBody = $('<div>');
                            $NurseDivBody.attr("class", "collapse indent");
                            $NurseDivBody.attr("id", "CollapseDiv" + value.Value);


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
                                    options += "<tr style='font-size:12px;font-weight: bold;cursor: pointer'><td style='width:15%' id='bedNo'>" + bedNo + "</td><td style='width:82%' id='patName'>" + patName + "</td><td id='gender'>" + gender.substr(0, 1) + "</td><td style='display:none' id='nurstCode'>" + nurstCode + "</td><td style='display:none' id='ipNo'>" + ipNo + "</td><td style='display:none' id='mrNo'>" + mrNo + "</td><td style='display:none' id='admndate'>" + admnDt + "</td><td style='display:none' id='age'>" + age + "</td><td style='display:none' id='salu'>" + salutation + "</td></tr>";// salutation td added by vijeta on30th may 2018
                                //options += "<li class='patNameCls' id='Pat" + mrNo + "'><label style='padding-left:5px;width:34px;font-size:12px;margin-top: 3px;'>" + bedNo + "</label><label style=' padding: 1px 3px;    font-size: 12px; border-bottom: 1px solid #f4f4f4;width:180px;'>" + patName + "</label><label>" + gender.substr(0, 1) + "</label></li>";

                            });
                            $PatListTbl.append(options);
                            $NurseDivBody.append($PatListTbl);



                            //$a.append(value.Text);//commented by vijeta on 13th Aug 2018
                            $divInAnchor.append(value.Text);//added on 13th Aug 2018

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
    }
}

function CheckPatSessionNotEmpty() {
    var mrNo = $.session.get('ICUPatMRNO');
    var ipNo = $.session.get('ICUPatIPNO');
    var name = $.session.get('ICUPatName');
    var bedNo = $.session.get('ICUPatBedNo');

    if (mrNo != null && mrNo != "")
        return true;
    else
        return false;

}

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}




//added on 9th Aug 2018
//$(document.body).on('click', '.contact_item .head', function (e) {

//    if ($(this).parent('div').hasClass('expanded')) {
//        $(this).parent('div').toggleClass('expanded');
//        $(this).next('div').slideUp();
//    }
//    else {
//        $('.contact_item.expanded .head').next('div').slideUp();
//        $('.contact_item.expanded').removeClass('expanded');
//        $(this).parent('div').toggleClass('expanded');
//        $(this).next('div').slideDown();
//    }

//});