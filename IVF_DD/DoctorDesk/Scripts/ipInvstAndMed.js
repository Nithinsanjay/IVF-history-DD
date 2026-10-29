var freeHandInvestigation = "";//vijeta 3/4/19
var flagCheckRowsCmplnt = false;//vijeta 26/4/19
var flagCheckRowsInvst = false;//vijeta 26/4/19





////suchita 18-02-2019
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
            success: function (result) {

                // $(document).ready(function () {
                if (result.length > 0) {
                    $("#btnsDiv").empty();
                    $.each(result, function (index, value) {


                        var $newDiv = $('<div>');
                        $newDiv.addClass("btn-group").css("width", "100%");

                        var test = $('<button/>',
                            {
                                text: result[index].Text,
                                id: result[index].Value,
                                style: ' background-color:transparent;margin-right: 2px;color: black;font-weight:bold;border: 1px solid transparent;font-size: 10px; white-space: normal;width: 100%; ',
                                class: 'btn btn-primary',
                                click: function () {
                                    SearchFunction(result[index].Value);
                                    $.session.set('ClinicCode', result[index].Value);
                                    $.session.set("ClinicName", result[index].Text);//added on 2nd july 2018
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
                // });
            },
            complete: function (jqXHR, status) {
                if (status == "success") {

                    if (jqXHR.responseJSON.length > 0) {

                        var clncCode = $.session.get('ClinicCode');
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

//suchita 18-02-2018 for collapsible div


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
    //  $('.trigger2').height(100);

    $("#trigger2").css({ top: '100px' });

    // var trigr1 = document.getElementById('layer-DMY');
    document.getElementById("layer-DMY").style.marginTop = "-10px";


});



//
function Patpresc(PatCompletedYN) {
    if (typeof PatCompletedYN == 'undefined' || PatCompletedYN == null) { HoldOn.close(); }//
    var mrno = ($.session.get('PatMRNO'));
    var dCode = globalLoginDoctCode;// added by vijeta on 20th sep 2018
    if ($.session.get('PatMRNO') != null) {
        $.ajax({
            type: "POST",
            url: 'GetPatPresc',
            datatype: "json",
            data: { strMRNO: mrno },
            success: function (result) {
                $(document).ready(function () {
                    strPrintData = [];
                    if (result.length == 0) {
                        document.getElementById("prevpresc").style.display = "none";
                        $('#myCarousel').empty();
                    }
                    else {
                        $('#myCarousel').empty();
                        if ($(window).width() <= 576)
                            $('.slide').css('width', '100%');//kavita
                        else
                            $('.slide').css('width', '45%');//kavita

                        var tempData = "<div class='carousel-inner' style='margin-left: 20px'>" +//kavita
                            "<div class='item active'>" +
                            "<div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                        var inactive = "";
                        for (var i = 0; i < result.length;) {
                            document.getElementById("prevpresc").style.display = "block";
                            var $this = $('#myCarousel');
                            if (i <= 2) {
                                var drName = ((result[i].DOCTNAME) != "") ? "<label style=''><b>(Dr. " + result[i].DOCTNAME + ")</b></label>" : "";
                                tempData = tempData + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer' id='" + result[i].TRANNO + "'  onclick='GetBindingData(this)' class='img-responsive'/><label id='lbl" +
                                    parseInt(i + 1) + "' style='margin-bottom:0px; ' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE + "</label>" + drName + "";

                                if (PatCompletedYN == "N") {// && result[i].DOCTCODE == dCode
                                    tempData = tempData + "<a id='hdn" + parseInt(i + 1) +
                                        "' style='cursor:pointer' title='" + result[i].TRANNO + "' onclick='GetCopy(this)'>Copy</a>"
                                }

                                tempData = tempData + "</div>";
                                i++;
                            }
                            else {
                                var drName = ((result[i].DOCTNAME) != "") ? "<label style=''><b>(Dr. " + result[i].DOCTNAME + ")</b></label>" : "";
                                inactive += "<div class='item'><div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                                for (j = 0; j < 4; j++) {
                                    if (i < result.length) {
                                        inactive = inactive + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;'><img src='../Images/prepDoc.png' style='cursor:pointer' id='" + result[i].TRANNO + "' onclick='GetBindingData(this)' class='img-responsive'/><label id='lbl" +
                                            parseInt(i + 1) + "' style='margin-bottom:0px; ' title='" + result[i].TRANNO + "'>" + result[i].TRANDATE + "</label>" + drName + "";

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
                });
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
            success: function (result) {
                $(document).ready(function () {
                    strPrintData = [];
                    if (result.length == 0) {
                        document.getElementById("attachments").style.display = "none";
                        $('#newCarousel').empty();
                    }
                    else {
                        $('#newCarousel').empty();
                        if ($(window).width() <= 576)
                            $('.slide').css('width', '100%');//kavita
                        else
                            $('.slide').css('width', '45%');//kavita
                        var tempData = "<div class='carousel-inner' style='margin-left: 20px'>" +
                            "<div class='item active'>" +//kavita
                            "<div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                        var inactive = "";
                        for (var i = 0; i < result.length;) {
                            document.getElementById("attachments").style.display = "block";
                            var $this = $('#newCarousel');
                            if (i <= 2) {//kavita
                                tempData = tempData + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4'  style='display: flex;flex-direction: column;align-items: flex-start;' onclick='openNewWin(this)' ><img src='../Images/prepDoc.png' style='cursor:pointer' class='img-responsive'/><label id='lbl" +
                                    parseInt(i + 1) + "' style='margin-bottom:0px; word-wrap: break-word;' title='" + result[i] + "'>" + result[i] + "</label>";

                                tempData = tempData + "</div>";
                                i++;
                            }
                            else {
                                inactive += "<div class='item'><div class='row' style='margin-left: 0px;width: 310px;height: 0px;'>";
                                for (j = 0; j < 4; j++) {
                                    if (i < result.length) {
                                        inactive = inactive + "<div id='img" + parseInt(i + 1) + "' class='col-xs-4' style='display: flex;flex-direction: column;align-items: flex-start;' onclick='openNewWin(this)'><img src='../Images/prepDoc.png' style='cursor:pointer'  class='img-responsive'/><label id='lbl" +
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
                });
            },
        });


    }

}

function openNewWin(obj) {
    NAME = obj.innerText;
    var MRNO = ($.session.get('PatMRNO'));
    var url = "../DoctorDesk/FileDownload?MRNo=" + MRNO + "&&filename=" + NAME
    window.open(url, 'Image', 'width=400px,height=500px,resizable=1');

}
//end
//added by kavita 29-8-18





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
    if ($(this).hasClass('active')) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
    }

    $("#DiagnosisInput").val("").trigger("keyup");//added on 28th sep 2018
});

$(document.body).on('click', '#tblICDdiagno tr', function (e) {

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {

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

    }

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
    })

    $("#ICDDiagnosisInput").val("").trigger("keyup");//added on 28th sep 2018
});

$(document.body).on('click', '#tblinvestigate tr', function (e) {

    var flagforCancel = 0;
    var flagactv = 0;

    if ($(this).children('td.tdStatus')[0].innerText == "C" && $(this).children('td.tdTempBind')[0].innerText == "Binding") {
        flagforCancel = 1;
    }
    else {
        // var i = 0 

        if ($(this).hasClass('active') && $(this).children('td.tdTempBind')[0].innerText == "Binding") {

            //....................................
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                (month < 10 ? '0' : '') + month + '-' + (day < 10 ? '0' : '') + day;

            var datefromreslt = $(this).children('td.OrderDate')[0].innerText.split('/');;

            var rolloverDate = datefromreslt[2] + '-' + datefromreslt[1] + '-' + datefromreslt[0];
            //....................................


            if (rolloverDate < output) {
                flagactv = 0;
                $(this).toggleClass('active');
            }
            else
                flagactv = 1;
        }

        else {
            $(this).toggleClass('active');
        }

    }


    if (flagforCancel == 1) {
        $(this).toggleClass('Canceled');
        if ($(this).hasClass('Canceled')) {
            OnSelectedOne(this);

        }
    } else {



        if ($(this).hasClass('active') && flagactv == 0) {
            OnSelectedOne(this);

        }
        else {



            if (flagactv == 0) {
                // $(this).toggleClass('active');

                OffSelectedOne(this);
            }
        }
    }



    if ($(this).children('td.tdStatus')[0].innerText == "C") {
        $(this).removeClass("active");
        $(this).addClass("Canceled");

    } else {
        if (flagactv == 1) {
            $(this).removeClass("Canceled");
            $(this).addClass("active");
        }
    }

    //sort unselected rows cnt wise
    var rows = $('#tblinvestigate tbody  tr:not(.active)').get();
    //var arr = $('#tblinvestigate tbody  tr:not(.active)').get()
    rows = jQuery.grep(rows, function (n, i) {
        return ($(n).children('td.tdStatus')[0].innerText !== "C");
    });
    rows.sort(function (a, b) {



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
    if ($(this).hasClass('active') && !flagCheckRowsInvst) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
        $(this).find('a.trigger1').trigger('click');

    }

    $("#InvestigationInput").val("").trigger("keyup");//added on 28th sep 2018


    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,



    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,


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
    if ($(this).hasClass('active')) {
        var id = $(this)[0].id;
        var elmnt = document.getElementById(id);
        elmnt.scrollIntoView({ block: "end" });
    }

    $("#PatAdviceInput").val("").trigger("keyup");//added on 28th sep 2018
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
//-------------------------------------------



// define a handler added by vijeta on 17th April 2018 for shoetcut keys
//  $(this).toggleClass('active');
function OnSelectedOne(this1) {
    // if ($(this).hasClass('active')) {
    $(this1).children('td').children('a').show();
    $(this1).children('td').children('input').show();
    $(this1).children('td').children('i').show();
    $(this1).children('td.OrderBy').show();

    if ($(this1).children('td.tdSequenceNo')[0].innerText == "" || $(this1).children('td.tdSequenceNo')[0].innerText == null) {
        var MaxSeqMedStat;
        if (MaxForInvestArray.length > 0) {
            MaxSeqMedStat = Math.max.apply(Math, MaxForInvestArray);

        } else {
            MaxSeqMedStat = 0;
        }
        MaxForInvestArray.push(MaxSeqMedStat + 1);
        $(this1).children('td.tdSequenceNo')[0].innerText = Number(MaxSeqMedStat + 1);
    }
    //$(this).children('td.tdSequenceNo')[0].innerText

    //tdTempBind


    var selRows = $('#tblinvestigate > tbody > tr.active').get(); //group of selected rows
    $(this1).children('td.tdSDate').find('input.triggerInputSDate').datepicker({ dateFormat: 'dd/mm/yy' });

    if (selRows.length == 0)
        $("#tblinvestigate tbody").prepend($(this1)).closest('tr');   // If this is first  selected row of table then moved to top  
    else {
        $('#tblinvestigate > tbody > tr').eq(selRows.length).after($(this1)); // selected row inserted after group of selected rows
    }
    $(this1).children('td.OrderBy')[0].innerText = userid;
    $(this1).children('td.tdStime').find('input.triggerInputStime').timeDropper({
        meridians: true,
    });
    // $(this).children('td.tdSDate').find('input.triggerInputSDate')[0].value = todayfor;

    //  $("#txtTimeOfError").val("");
    // selected rows moved to top  

}

function OffSelectedOne(this2) {
    MaxForInvestArray = jQuery.grep(MaxForInvestArray, function (value) {
        return value != Number($(this2).children('td.tdSequenceNo').text());
    });


    $(this2).children('td').children('a').hide();
    $(this2).children('td').children('input').hide();
    $(this2).children('td').children('i').hide();
    $(this2).children('td.OrderBy')[0].innerText = "";



    //...............................
    $(this2).children('td.tdSDate').find('input.triggerInputSDate')[0].value = "";
    $(this2).children('td.tdStime').find('input.triggerInputStime')[0].value = "";
    $(this2).children('td.tdOmit').find('input.triggerInputOmit').attr('checked', false);
    $(this2).children('td.investigationRemark').find('input.triggerInputRemark')[0].value = "";
    $(this2).children('td.tdTestCode')[0].innerText = "";
    $(this2).children('td.tdTypeCode')[0].innerText = "";
    $(this2).children('td.tdSequenceNo')[0].innerText = "";
    $(this2).children('td.tdStatus')[0].innerText = "A";
    $(this2).children('td.tdCancelBY')[0].innerText = "";
    $(this2).children('td.tdCancelDT')[0].innerText = "";
    $(this2).children('td.tdCancelTM')[0].innerText = "";
    $(this2).children('td.OrderDate')[0].innerText = "";
    $(this2).children('td.OrderTM')[0].innerText = "";
    $(this2).children('td.tdTempBind')[0].innerText = "";


    //.................................

}
function doc_keyUpForShortCutMenus(e) {
    var tag = e.target.tagName.toLowerCase();

    if (tag != 'input' && tag != 'textarea' && e.keyCode != 9 && e.keyCode < 112 && e.keyCode > 123) {  //keycode 9- prevent save on tab
        SaveForAllShortCutMenus();//added on 19th april 2018

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


//added on 19th april 2018





//added on 10th July 2018
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
                    var patName = $.session.get('PatName');
                    var patAge = $.session.get('PatAge');
                    var patGender = $.session.get('PatGender');
                    var patMob = $.session.get('PatMobile');
                    var patAge2 = $.session.get('PatAge2');

                    var clinicname = $.session.get("ClinicName");

                    var strPrintdata = [];
                    var Grid = JSON.parse(response[1]);

                    strPrintdata.push("<html><head><style>.AllrgenTypeCls{width: 100%; border-collapse: collapse; border: 1px solid black;}.AllrgenTypeCls td,th{  text-align: center; border-collapse: collapse;border: 1px solid black;}.AllrgenTypeCls td{ font-size: 14px;font-family: Verdana, Geneva, sans-serif !important;color:black;padding: 4px;}.AllrgenTypeCls th{ font-size: 16px;}.AllrgenTypeCls td:nth-child(2){ text-align: left;}</style></head><body>");
                    strPrintdata.push("<div id='divheads' style='text-align:center;margin-bottom:10px'><label style='font-size:20px;font-weight:bold;'>SPT Reporting</label></div>");
                    strPrintdata.push("<div><table style='width:100%; font-family: Verdana, Geneva, sans-serif !important;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px'>");
                    strPrintdata.push("<tr class='inHeight'><td class='HTextsize'>Name</td><td style='width:1%'>:</td><td class='HTextsize' style='font-weight:bold;line-height:14px;'>" + patName +
                        "<td class='HTextsize' style=''>Doctor Name</td><td>:</td>");
                    strPrintdata.push("<td class='HTextsize' style='font-weight:bold;'>Dr. " + Grid[0]["DoctName"] + "</td></tr><tr class='HTextsize'><td class='HTextsize'>Age/Gender</td><td >:</td><td class='HTextsize' style=''>" + patAge + ' ' + " / " + patGender + "</td>");

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

//added on 10th July 2018
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
//added on 10th July 2018
function GetPrevoisSptReports() {
    var mrno = ($.session.get('PatMRNO'));
    if ($.session.get('PatMRNO') != null) {
        $.ajax({
            type: "POST",
            url: 'GetPatientPrevSPTReports',
            datatype: "json",
            data: { strMRNO: mrno },
            success: function (result) {

                $(document).ready(function () {
                    strPrintData = [];
                    if (result.length == 0) {
                        document.getElementById("prevSptReporting").style.display = "none";
                        $('#newCarouselSPT').empty();
                    }
                    else {
                        $('#newCarouselSPT').empty();
                        if ($(window).width() <= 576)
                            $('.slide').css('width', '100%');//kavita
                        else
                            $('.slide').css('width', '45%');//kavita
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
                });
            },
        });
    }

}

//added on 10th July 2018l
function PrintPreviousSPT(tranno) {
    var mrNo = $.session.get('PatMRNO');
    PrintSPTReportingData(mrNo, tranno);
}

//added on 11th July 2018



//added on 29th sep 2018

//vijeta 4th oct 2018
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
            $(document).ready(function () {
                if (response != "Unsucessfull") {
                    var result = JSON.parse(response)
                    var rows = "";
                    for (i = 0; i < result.Table1.length; i++) {
                        rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>";


                        rows += "</tr>";
                    }
                    $('#tblPatAdviceStUps tbody').empty();
                    $('#tblPatAdviceStUps tbody').append(rows).closest('tr');
                }
            });

        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        },
        complete: function () {

        }
    });
}


//vijeta 4th oct 2018
//$(document.body).on('click', '#tblPatAdviceStUps tr', function (e) {
//    //var strUrl = "";
//    var strUrl = "../DoctorDesk/GetAdvicesBySetUpCode";
//    var page = window.location.href;
//    var tableId = "";
//    var strType = "";

//    if (page.indexOf("PatientAdvice") != -1) {
//        // strUrl = "../DoctorDesk/GetAdvicesBySetUpCode";
//        tableId = "tblpatadv";
//        strType = "P";
//    }

//    else if (page.indexOf("InvestigationTran") != -1) {
//        // strUrl = "../DoctorDesk/GetInvestigationsBySetUpCode";
//        tableId = "tblinvestigate";
//        strType = "I";
//    }

//    else if (page.indexOf("RxDesktop") != -1) {
//        //strUrl = "../DoctorDesk/GetMedicineAdvicesBySetUpCode";
//        tableId = "tblMaterialList";
//        strType = "A";
//    }

//    var activeFlag = true;
//    var strCode = $(this)[0].id;
//    $(this).toggleClass('active');

//    if ($(this).hasClass('active')) {
//        $(this)[0].bgColor = 'lightgray';

//    }
//    else {
//        $(this)[0].bgColor = '';
//        activeFlag = false;
//    }

//    var strSetUpCodeLst = [];
//    $.each($('#tblPatAdviceStUps tr.active'), function (i, val) {
//        strSetUpCodeLst.push($(this)[0].id);
//    });


//    if (strSetUpCodeLst.length > 0) {
//        $.ajax({
//            datatype: 'json',
//            type: 'post',
//            url: strUrl,
//            data: { strCode: strSetUpCodeLst.join(","), strType: strType },
//            success: function (response) {
//                if (response != "Something Went Wrong") {
//                    var result = JSON.parse(response);

//                    if (strType == "A") {
//                        //$("#tblMaterialList tr.active").trigger("click");
//                        RxDesktopSetData(result);
//                    }
//                    else {
//                        $.each($('#' + tableId + ' tr'), function (i, val) {
//                            $(this).removeClass("active");
//                            $(this).find("a").hide();
//                            $(this).find("input").hide();
//                        });


//                        $.each(result, function (i, val) {
//                            if (!$('#' + tableId + ' tr#' + val.CODE + '').hasClass("active"))// if advice already selected then dont select
//                                $('#' + tableId + ' tr#' + val.CODE + '').trigger("click");
//                        });
//                    }




//                }

//            }

//        });
//    }
//    else {
//        $.each($('#' + tableId + ' tr'), function (i, val) {
//            if ($(this).hasClass("active")) {
//                $(this).trigger("click");
//            }
//            //$(this).removeClass("active");
//            //$(this).find("a").hide();
//        });
//    }

//});

//vijeta 4th oct 2018
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
        $(this).children('td').children('span').show();//vijeta 1/4/19

        $('#tblMaterialList input.hasAutoComplete').autocomplete("close");
        $(this).find("input.triggerInputIntake").trigger("keydown"); //vijeta 24/4/19

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
        //  $(this).children('td.tdRemark').children('a')[0].innerText = "Remark";//remark anchor text
        $(this).children('td.tdRemark').children('input')[0].value = "";//remark dopdown value
        //-------------------

        $(this).children('td').children('a').hide();
        $(this).children('td').children('input').hide();
        $(this).children('td').children('select').hide();
        $(this).children('td').children('div').hide();
        $(this).children('td').children('span').hide();//vijeta 1/4/19

        $('#tblMaterialList input.hasAutoComplete').autocomplete("close");//vijeta 24/4/19

        var className = $(this).attr('class');
        if (className.length > 0) {
            var ClassId = className.substr(className.length - 4).trim();
            var advicedayNum = (ClassId).replace(/[^0-9]+/ig, "");
            var RowPos = $('.Tr' + (advicedayNum - 1).toString());
            RowPos.next().after(this);
        }
        //$.session.set($(this)[0].id, 'N');
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

    // $("#ComplaintInput").val("").trigger("keyup");//added on 28th sep 2018 //commented by vijeta 11/4/19
    $("#ComplaintInput").val("").trigger("donetyping");//added vijeta 11/4/19
    SearchComplaint();//added vijeta 11/4/19
});

//added on 17th oct 2018


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

    var freeText = ""; //vijeta 3/4/19

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
                                            if (CODE.trim() != "")
                                            {
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
                            if ($('#' + tableId + ' tr#' + DurgID + "").length > 0 && $('#' + tableId + ' tr#' + DurgID + "").hasClass("active")) {
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
//added on 16th nov 2018
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

function PatientSearchNotAppointed() {
    var strMrOrname = $("#txtPatSearchNotAppntd").val();
    HoldOn.open();
    $.ajax({
        url: '../DoctorDesk/SearchNotAppointedPatients',
        data: { strMrName: strMrOrname },
        type: 'post',
        datatype: 'json',
        success: function (data) {
            if (data != "") {
                $("#tblPatList").empty();
                $.each(data, function (i, val) {
                    var row = "<tr style='border-bottom:1px solid #dedada' id='" + val.MRNO + "'><td><label style='font-size:12px;font-weight:normal'>" + val.NAME + "</label><input type='hidden' class='ageCls' value='" + val.AGE + "' /><input type='hidden' class='genderCls' value='" + val.GENDER + "' /><input type='hidden' class='mobileCls' value='" + val.MOBILE + "' /></td></tr>";
                    $("#tblPatList").append(row);
                });
                HoldOn.close();
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
    var gender = $(this).find('input.genderCls')[0].value;
    var mrNo = $(this)[0].id;
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


    $.session.set('PatMRNO', mrNo);
    $.session.set('PatTRANNO', "");

    $.session.set('PatCompleted', "N");
    $.session.set('PatSelected', "NotAppointed");

    // patCompletedYN = $.session.get('PatCompleted');

    window.location.href = 'PatientEntry';
});

function CheckPatMRNotEmpty() {
    var mrNo = $.session.get('PatMRNO');
    if (mrNo != undefined) {
        return true;
    }

    else
        return false;
}

//added by vij on 22nd nov 2018

//suchita 
$(document).ready(function (e) {
    var urls = "../Account/GetDctrClinic";
    $("#lblAppToday").click(function (e) {
        // "<%=Url.Action("GetDctrClinic","Account")%>";
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

            $(document).ready(function () {
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
                                    $.session.set('ClinicCode', result[index].Value);
                                    $.session.set("ClinicName", result[index].Text);//added on 2nd july 2018
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
            });
        },
        complete: function (jqXHR, status) {
            if (status == "success") {

                if (jqXHR.responseJSON.length > 0) {

                    var clncCode = $.session.get('ClinicCode');
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

    var url = "../DoctorDesk/GetPatData";
    HoldOn.open();
    $.ajax({
        //  url: "<%=Url.Action("GetPatientList", "DoctorDesk")%>",
        url: url,
        type: 'post',
        dataType: 'json',
        data: { strClinicCode: clinicCode, appNsurType: appNsurType },
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


            var waitingCount = 0;//added on 12th april 2018
            var completedCount = 0;//added on 12th april 2018
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
                    var applyColor = "none";


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

                    if (compltdYn == "N" || compltdYn == " ") {
                        waitingCount++;
                        options1 += "<li class='patNameCls' id='PatName" + item.CONSNO + "'><label style='padding-left:5px;width:32px;font-size:12px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "</label><label style=' padding: 2px 7px;font-size: 12px; border-bottom: 1px solid #f4f4f4;' id='" + mrNo + "'> " + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input></li>";
                    }
                    else {
                        completedCount++;
                        options2 += "<li class='patNameCls' id='PatName" + item.CONSNO + "'><label style='padding-left:5px;width:32px;font-size:12px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "</label><label style=' padding: 2px 7px;font-size: 12px; border-bottom: 1px solid #f4f4f4;' id='" + mrNo + "'> " + patName + "</label><input type=hidden  id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input></li>";
                    }

                });
            }
            //$newul.append(options);
            //$newDiv.append($newul);
            var $newHeadngWait = $('<a>', { class: 'btn-group btn-group-justified', style: 'border: 1px solid #d8acc6;color: #8e0e5a;text-align: center;font-size:13px;border-radius: 2px; background-color: #f9ddedcc; text-decoration: none;' });
            if (appNsurType == "ATMW" || appNsurType == "ST" || appNsurType == "STMW") {
                if (waitingCount == 0)//added on 12th april 2018
                    $newHeadngWait.append('Total');

                else
                    $newHeadngWait.append('Total (' + waitingCount + ')');//added on 12th april 2018
            }
            else {
                if (waitingCount == 0)//added on 12th april 2018
                    $newHeadngWait.append('Total');

                else
                    $newHeadngWait.append('Total (' + waitingCount + ')');//added on 12th april 2018
            }
            $newul1.append(options1);
            $newDiv1.append($newul1);

            $newul2.append(options2);
            $newDiv2.append($newul2);

            var $newHeadng = $('<a>', { class: 'btn-group btn-group-justified', style: 'border: 1px solid #a9dca9;color: #118011;text-align: center;border-radius: 2px; font-size:13px;  background-color: #d6f7d5cf;  text-decoration: none;' });
            if (appNsurType == "ATMW" || appNsurType == "ST" || appNsurType == "STMW") {
                if (completedCount == 0)//added on 12th april 2018
                    $newHeadng.append('Total');

                else
                    $newHeadng.append('Total (' + completedCount + ')');//added on 12th april 2018
            }
            else {
                if (completedCount == 0)//added on 12th april 2018
                    $newHeadng.append('Total');
                else
                    $newHeadng.append('Total (' + completedCount + ')');//added on 12th april 2018
            }


            $newDiv3.append($newHeadng);

            //  //$newHeadng.attr("value", "Completed");

            $('#DivDPatGrid').empty();
            ////$('#DivPatGrid').append("<div><label>" + new Date() + "</label></div>");
            var $DivPatSearch; //, { style: 'height:35px;text-align:center;margin-top:56px' }); //suchita
            if ($(window).width() < 996) {  //screen width size comparion
                $DivPatSearch = '<div id="divPatBindGrid" style="height:35px;text-align:center;margin-top:10px">';
            }
            else {
                $DivPatSearch = '<div id="divPatBindGrid" style="height:35px;text-align:center;margin-top:56px">';
            }
            $DivPatSearch += "<div class='form-group has-feedback'><input type='text' style='height:30px;width:97%;margin-left:5px' class='form-control' id='txtDPatientSearch'  onkeyup='PatientDSearch()' placeholder='Search Patient'/><span class='fa fa-search fa-2x form-control-feedback'  style='color:#3c8dbc;line-height:30px;'></span></div>";
            $('#DivDPatGrid').append($DivPatSearch);
            //---------------

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
            var mrNo = $.session.get('PatMRNO');
            var tranno = $.session.get('PatTRANNO');
            if (tranno != null && mrNo != null) {
                //$("li#PatName" + tranno)[0].style.color = "#3c8dbc";
                $("li#PatName" + tranno).attr("style", "color:#3c8dbc;box-shadow:0px 3px 30px -3px");// added by vijeta on 31st march 2018
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
                        $a.attr("data-parent", "#PatListPanelDiv");

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
                                options += "<tr style='font-size:12px;font-weight: bold;cursor: pointer'><td style='width:15%' id='bedNo'>" + bedNo + "</td><td style='width:82%' id='patName'>" + patName + "</td><td id='gender'>" + gender.substr(0, 1) + "</td><td style='display:none' id='nurstCode'>" + nurstCode + "</td><td style='display:none' id='ipNo'>" + ipNo + "</td><td style='display:none' id='mrNo'>" + mrNo + "</td><td style='display:none' id='admndate'>" + admnDt + "</td><td style='display:none' id='age'>" + age + "</td><td style='display:none' id='salu'>" + salutation + "</td></tr>";// salutation td added by vijeta on30th may 2018
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
    var mrNo = $.session.get('PatMRNO');
    var tranno = $.session.get('PatTRANNO');
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

                //$("#DivPatGrid .moreless").toggleClass('fa-plus fa-minus');
                //$("#WaitingPats").removeClass('collapse in indent');
                //$("#WaitingPats").addClass('collapse out indent');
                //$("#VisitedPats").removeClass('collapse in indent');
                //$("#VisitedPats").addClass('collapse out indent');

                //Complaints Data
                var str = "<a data-toggle='collapse' data-target='#ComplaintInfo' id='comp'  class='btn-group btn-group-justified anchorHeadCls' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background-color:#bcdf94'><i class='moreless fa fa-minus'></i>Present Complaints<span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o removeRelation' style='font-size:20px;'></span></a>"
                str += "<div id='ComplaintInfo' name='ComplaintInfo' class='collapse in indent'>"//

                if (GridData.jsonComplaints != "" || GridData.jsonFreeComplaints != "") {
                    str += "<table class='tblMediNfo'>";
                    //complaints
                    $.each(GridData.jsonComplaints, function (i, value) {

                        var rmrk = (value.REMARKS != "") ? " - " + value.REMARKS : "";
                        str = str + "<tr><td style='width:80%;'>" + value.NAME + rmrk + "</td><td>" + value.DURATION + " </td><td>" + value.DURTYPE + "</td></tr>";
                    });

                    //free complaints
                    $.each(GridData.jsonFreeComplaints, function (i, value) {
                        str = str + "<tr><td style='width:80%;'>" + value.FREECOMPLAINT + "</td><td>" + "" + " </td><td>" + "" + "</td></tr>";
                    });

                    str = str + "</table>";
                }
                else {
                    str += "<table style='font-size:14px'>";
                    str += "<tr><td class='NoDataTD'> No Data </td></tr>";
                    str = str + "</table>";
                }
                str = str + "</div>";
                $("#MedicalInfo").append(str);

                //Vitals data
                var strVitals = "<a data-toggle='collapse' data-target='#VitalInfo'   class='btn-group btn-group-justified anchorHeadCls' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background-color:#ecf5f9'><i class='moreless fa fa-minus'></i>Present Vitals <span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o removeRelation' style='font-size:20px;'></span></a>"
                strVitals += "<div id='VitalInfo' name='VitalInfo' class='collapse in indent'>"//

                if (GridData.jsonVital != "") {
                    strVitals += "<table  class='tblMediNfo'>";
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

                        //vijeta 17th may 2019
                        if ((value.BMI) != "")
                            strVitals = strVitals + "<tr><td>" + "BMI  " + "</td><td> " + value.BMI + " kg/(m²)</td>" + "</tr>";

                        if ((value.HEAD_CIRCUMFERENCE) != "")
                            strVitals = strVitals + "<tr><td>" + "Head Circumference  " + "</td><td> " + value.HEAD_CIRCUMFERENCE + " cm</td>" + "</tr>";
                        //vijeta 17th may 2019

                        //vijeta 4th june 2019
                        if (value.PEFR != "")
                            strVitals = strVitals + "<tr><td>" + "PEFR  " + "</td><td> " + value.PEFR + " lit/min</td>" + "</tr>";

                        if (value.Technique != "N")
                            strVitals = strVitals + "<tr><td>" + "Technique  " + "</td><td> " + value.Technique + " </td>" + "</tr>";

                        if (value.Compliance != "N")
                            strVitals = strVitals + "<tr><td>" + "Compliance  " + "</td><td> " + value.Compliance + " </td>" + "</tr>";
                        //vijeta 4th june 2019

                        if (Number(value.WEIGHT) == 0 && Number(value.HEIGHT) == 0 && Number(value.TEMP) == 0 && value.PULSE == "" && value.BP == "" && value.RESP == "" && value.SPO2 == "" && value.VOTHERS == "" && value.BMI == "" && value.HEAD_CIRCUMFERENCE == "" && value.PEFR == "" && value.Technique == "N" && value.Compliance == "N") {
                            strVitals = strVitals + "<tr><td class='NoDataTD'> No Data </td></tr>";
                        }
                    });
                    strVitals += "</table>";
                }
                else {
                    strVitals += "<table style='font-size:14px'>";
                    strVitals = strVitals + "<tr><td class='NoDataTD'> No Data </td></tr>";
                    strVitals += "</table>";
                }
                strVitals = strVitals + "</div>";
                $("#MedicalInfo").append(strVitals);

                //Examination
                var strExam = "<a data-toggle='collapse' data-target='#ExamInfo'  class='btn-group btn-group-justified anchorHeadCls' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background-color:#bcdf94'><i class='moreless fa fa-minus'></i>On Examination<span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o removeRelation' style='font-size:20px;'></span></a>"
                strExam += "<div id='ExamInfo' name='ExamInfo' class='collapse in indent'>"
                //
                if (GridData.jsonExam != "") {
                    strExam += "<table class='tblMediNfo'>";
                    $.each(GridData.jsonExam, function (i, value) {
                        if (value.EXAM.trim() != "")
                            strExam += "<tr><td>" + value.EXAM + "</td></tr>";
                        else
                            strExam += "<tr><td class='NoDataTD' >No Data</td></tr>"
                    });
                    strExam += "</table>";
                }
                else {
                    strExam += "<table style='font-size:14px;'>";
                    strExam += "<tr><td class='NoDataTD'>No Data</td></tr>";
                    strExam += "</table>";
                }
                strExam += "</div>";
                $("#MedicalInfo").append(strExam);

                //Diagnosis
                var strDiagno = "<a data-toggle='collapse' data-target='#DiagnoInfo'  class='btn-group btn-group-justified anchorHeadCls' data-parent='#MedicalInfo' onclick='changeIcon(this)' style='background-color:#ecf5f9'><i class='moreless fa fa-minus'></i>Present Diagnosis<span style='float:right;' onclick='DeleteComplaintdata(this)'><i class='fa fa-trash-o removeRelation' style='font-size:20px;'></span></a>"
                strDiagno += "<div id='DiagnoInfo' name='DiagnoInfo' class='collapse in indent'>"

                if (GridData.jsonDiagnosis != "") {
                    strDiagno += "<table class='tblMediNfo'>";
                    $.each(GridData.jsonDiagnosis, function (i, value) {

                        var rmrk = (value.REMARKS != "") ? "-" + value.REMARKS : "";
                        strDiagno += "<tr><td>" + value.NAME + rmrk + "</td></tr>";
                    });
                    strDiagno += "</table>";
                }
                else {
                    strDiagno += "<table style='font-size:14px;'>";
                    strDiagno += "<tr><td class='NoDataTD'>No Data</td></tr>";
                    strDiagno += "</table>";
                }
                strDiagno += "</div>";
                $("#MedicalInfo").append(strDiagno);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                //ajaxindicatorstop();
                $.messager.alert("Information", textStatus);
                //MsgDia(textStatus, "Error");
            }
        });
    }
}

function DeleteComplaintdata(obj) {//5/6/19
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
        urll = '../DoctorDesk/SaveDiagnosis?strDiagnosis=' + JSON.stringify(cmpltArr) + '&&strICDDiagnosis=' + JSON.stringify(cmpltArr) + '&&strMRNO=' + mrno + '&&strTranNo=' + tranNo;
    }
    else if (headngOf.indexOf("EXAMINATION") > -1) {
        urll = '../DoctorDesk/SaveExam?strExam=' + examdata + '&&strMrNo=' + mrno + '&&strTranno=' + tranNo;
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
        var strSPO2 = " ";//added on 20th aug 2018


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
                window.location.href = "../DoctorDesk/Complaints";
            } else if (headngOf.indexOf("DIAGNOSIS") > -1) {

                window.location.href = "../DoctorDesk/Diagnosis";
            } else if (headngOf.indexOf("EXAMINATION") > -1) {

                window.location.href = "../DoctorDesk/Examination";
            } else if (headngOf.indexOf("VITALS") > -1) {

                window.location.href = "../DoctorDesk/Vitals";
            }
            window.location.reload()
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

    $('#tblMaterialList input.hasAutoComplete').autocomplete("close");
    $(this).find("input.triggerInputIntake").trigger("keydown");
    $('#tblNonFreqMtrlList').hide();

});



