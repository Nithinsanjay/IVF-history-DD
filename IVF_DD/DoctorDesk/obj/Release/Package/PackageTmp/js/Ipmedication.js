var severityLevel = 1;
var medicineInterStr = "";

$(document.body).on('click', '#tblMtrlNewSearch tr', function (e) {

    $("#ComplaintInput").val("").trigger("donetyping");
    SearchComplaint();
    var mtrlCode = $(this).children('td.mtrlCode')[0].innerText;
    var mtrlName = $(this).children('td.mtrlName')[0].innerText;

    GetListInfoWhileClicking(mtrlCode, "Y", mtrlName);

    //$.ajax({

    //    url: '../DoctorDesk/GetMaterialInfo',
    //    data: { mtrlCode: mtrlCode },
    //    type: 'post',
    //    datatype: 'json',
    //    success: function (response) {

    //        var result = {
    //            MTRLCODE: response.CODE,
    //            MTRLNAME: response.NAME,
    //            GENERICNAM: response.Generic,
    //            GENERICID: response.GenericCode,
    //            DRUGFORM: response.Form,
    //            Strength: response.Strength,
    //            StrengthUnit: response.StrengthUnit
    //        };

    //        var rows = MedicinesRow(result, true);

    //        var selRows = $('#tblMedicineList > tbody > tr.active').get(); //group of selected rows

    //        if (selRows.length == 0)
    //            $("#tblMedicineList tbody").prepend(rows).closest('tr');   // If this is first  selected row of table then moved to top  
    //        else {
    //            $('#tblMedicineList > tbody > tr').eq(selRows.length - 1).after(rows); // selected row inserted after group of selected rows
    //        }

    //        $('#tblMedicineList tr#' + response.CODE.replace(/[^0-9a-zA-Z]/gi, '')).trigger('click');

    //        $('#tblMtrlNewSearch').hide();
    //        //$('#tblMedicineList input.hasAutoComplete').autocomplete("close");
    //        $("#tblMedicineList tr#" + response.CODE.replace(/[^0-9a-zA-Z]/gi, '') + "" + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
    //            source: ItakesArray,
    //            autoFocus: false,
    //            minLength: 0,
    //            select: function (event, ui) {

    //                var txtval = ui.item.value;
    //                var mediName = $(this).parents('td').prevAll('.MaterialName').text();
    //                var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();
    //                var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();
    //               // var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();
    //                var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;
    //                var route = $(this).parents('td').siblings('.tdRoute').find('a').text();//kavita 08-aug
    //                var remark =  $(this).parents('td').siblings('.tdRemark').find('input')[0].value;
    //                var Type = $(this).parents('td').siblings('.tdType').find('a').text();
    //                var Vol = $(this).parents('td').siblings('.tdVol').find('a').text();
    //                var ADur = $(this).parents('td').siblings('.tdADur').find('a').text();
    //                var Diltn = $(this).parents('td').siblings('.tdDiltn').find('input')[0].value;
    //                var SDate = $(this).parents('td').siblings('.tdSDate').find('input')[0].value;
    //                var OrderBy = $(this).parents('td').prevAll('.OrderBy').text();

    //                var DrugCode = $(this).parents('td').prevAll('.tdDrugCode').text();
    //                var TypeCode = $(this).parents('td').prevAll('.tdTypeCode').text();
    //                var OmittedBy = $(this).parents('td').prevAll('.tdOmittedBy').text();
    //                var OmittedDate = $(this).parents('td').prevAll('.tdOmittedDate').text();
    //                var OmittedTime = $(this).parents('td').prevAll('.tdOmittedTime').text();
    //                var OrderedDate = $(this).parents('td').prevAll('.tdOrderedDate').text();
    //                var OrderedTime = $(this).parents('td').prevAll('.tdOrderedTime').text();
    //                var DrugSequenceNo = $(this).parents('td').prevAll('.tdDrugSequenceNo').text();
    //                var HighAlertDrug = $(this).parents('td').prevAll('.tdHighAlertDrug').text();
    //                var NotifyYN = $(this).parents('td').prevAll('.tdNotifyYN').text();
    //                var Status = $(this).parents('td').prevAll('.tdStatus').text();
    //                var ADMINYN = $(this).parents('td').prevAll('.tdADMINYN').text();

    //                // var omit = $(this).parents('td').siblings('.tdomit').find('input')[0].value;


    //                var tableRow = $("#tblMedicineList tr").filter(function () {

    //                    return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdType a').text().trim() == Type.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim() && $(this).find('td.tdVol a').text().trim() == Vol.trim() && $(this).find('td.tdVol a').text().trim() == Vol.trim() && $(this).find('td.tdADur a').text().trim() == Vol.trim() && ($(this).find('td.tdDiltn input')[0].value).toUpperCase().trim() == Diltn.toUpperCase().trim() && ($(this).find('td.tdSDate input')[0].value).trim() == SDate.trim() && $(this).find('td.OrderBy').text().trim() == OrderBy.trim()
    //                        && $(this).find('td.tdDrugCode').text().trim() == DrugCode.trim() && $(this).find('td.tdTypeCode').text().trim() == TypeCode.trim() && $(this).find('td.tdOmittedBy').text().trim() == OmittedBy.trim() && $(this).find('td.tdOmittedDate').text().trim() == OmittedDate.trim() && $(this).find('td.tdOmittedTime').text().trim() == OmittedTime.trim() && $(this).find('td.tdOrderedDate').text().trim() == OrderedDate.trim() && $(this).find('td.tdOrderedTime').text().trim() == OrderedTime.trim() && $(this).find('td.tdDrugSequenceNo').text().trim() == DrugSequenceNo.trim()   //kavita 08-aug
    //                     && $(this).find('td.tdHighAlertDrug').text().trim() == HighAlertDrug.trim() && $(this).find('td.tdNotifyYN').text().trim() == NotifyYN.trim() && $(this).find('td.tdADMINYN').text().trim() == ADMINYN.trim();
    //                }).closest("tr");

    //                if (tableRow.length > 0) {
    //                    $.messager.alert('This medicine and frequency already present');
    //                    $(this).val('');
    //                    $(this).focus();
    //                    return false;
    //                }
    //                else {
    //                    if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
    //                        $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
    //                        $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "0";
    //                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
    //                        // $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
    //                        //$(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerType').trigger('click');
    //                    }
    //                    else {
    //                        //$(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
    //                        $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
    //                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
    //                    }
    //                }


    //            }
    //        }).focus(function () {
    //            /* Only search if the autocomplete menu is hidden: */
    //            if ($("ul.ui-autocomplete").is(":hidden")) {
    //                $(this).autocomplete('search', '');
    //            }
    //        });
    //    },
    //    complete: function () {
    //        // GetMaterialInteraction(mtrlCode);
    //    },
    //    error: function (XMLHttpRequest, textStatus, errorThrown) {
    //        $.messager.alert("Error", errorThrown);
    //    }
    //});

});

$(document.body).on('click', '.medInfoSpan', function (e) {
    HoldOn.open();
    var refCode = $(this).parents('td').siblings('.tdDrugCode')[0].innerText;

    $.ajax({
        url: '../DoctorDesk/GetMonographInfo',
        data: { refCode: refCode },
        type: 'Get',
        cache: false,
        contentType: 'application/html; charset=utf-8',
        datatype: 'html',
        success: function (response) {
            if (response != "") {
                //var d = window.open('', '', '"<%=Server.MapPath("~/")%>"');
                var d = window.open();
                d.document.open()
                d.document.write(response)
                d.document.close()
                //if (!$("#MonographMaterail").dialog("isOpen")) {
                //    $("#MonographMaterail").dialog("open");
                //} else {
                //    $("#MonographMaterail").dialog("close");
                //}
                //$("#MonographMaterail").html(response);              
            }
            HoldOn.close();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        }
    });
})
function OnSelectedOne(this1) {
    $(this1).children('td.tdSDate').find('input.triggerInputSDate').datepicker(
        {
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            maxDate: new Date(),
            // minDate: admissiondate
        });




    $(this1).children('td.OrderBy')[0].innerText = userid;

    //.....................................................................................

    var selRows = $('#tblMedicineList > tbody > tr.active').get(); //group of selected rows
    var selRowsOmit = $('#tblMedicineList > tbody > tr.Omited').get();
    var selRowsPlan = $('#tblMedicineList > tbody > tr.planclass').get();
    var selRowsCancl = $('#tblMedicineList > tbody > tr.Canceled').get();
    var selRowsPlnOmt = $('#tblMedicineList > tbody > tr.plannedAndOmitted').get();

    var totallen = selRows.length + selRowsOmit.length + selRowsPlan.length + selRowsCancl.length + selRowsPlnOmt.length;


    if (flagactv == 0 && flagforomit == 0 && flagforplanng == 0 && flagforpalnAndOmit == 0 && flagforCancel == 0) {
        if (totallen == 0)
            $("#tblMedicineList tbody").prepend($(this1)).closest('tr');   // If this1 is first  selected row of table then moved to top  
        else {
            $('#tblMedicineList > tbody > tr').eq(totallen - 1).after($(this1)); // selected row inserted after group of selected rows
            //$('#tblMedicineList > tbody > tr').eq(selRows.length).after($(this1));
            //$("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRoute').find('a.triggerRoute').trigger('click')

        }
    }

    //.................................................




    if ($.session.get('ADDButton') == "") {
        if ($(this1).children('td.tdDrugForm').text() == "" || $(this1).children('td.tdDrugForm').text() == undefined) {


            var mtrlCode = $(this1).children('td.tdDrugCode').text();
            var mtrlName = $(this1).children('td.MaterialName').text();

            $(this1).remove();
            GetListInfoWhileClicking(mtrlCode, "N", mtrlName);

            flag = 1;
        }
    } else {
        $.session.set('ADDButton', "");
    }



    $(this1).children('td').children('a').show();
    $(this1).children('td').children('input').show();
    $(this1).children('td').children('select').show();
    $(this1).children('td').children('div').show();
    $(this1).children('td').children('span').show();

    if ($(this1).children('td.tdDrugForm').text() == "" || typeof $(this1).children('td.tdDrugForm').text() == "undefined") {

        $(this1).find('a.triggerType').css('pointer-events', 'auto');
    }
    else
        $(this1).find('a.triggerType').css('pointer-events', 'none');


    $('#tblMedicineList input.hasAutoComplete').autocomplete("close");
    //var rows = $('#tblMedicineList tbody  tr:not(.active)').get();
    //$.each(rows, function (index, row) {
    //    $('#tblMedicineList').children('tbody').append(row);
    //});
    if (RxNewSetDataflag == 0) {
        $(this1).find("input.triggerInputIntake").trigger("focus");
        $(this1).find("input.triggerInputIntake").trigger("keydown");
    } else {
        RxNewSetDataflag = 0;
    }
    // selected rows moved to top  
    Sortable.create(
        $('#tblsort')[0], {
        animation: 150,
        scroll: true,
        handle: '.clickable-row',
    });

    var id = $(this1).children('.tdDrugCode')[0].innerText;
    $("#ComplaintInput").val("").trigger("donetyping");//added vijeta 11/4/19
    // SearchComplaint();//added vijeta 11/4/19
    GetMaterialInteraction(id);
}

function OffSelectedOne(this2) {


    //var MaxSeqMedStat;
    //if (MaxForMedStat.length > 0) {
    //    MaxSeqMedStat = Math.max.apply(Math, MaxForMedStat);

    //} else {
    //    MaxSeqMedStat = 0;
    //}
    MaxForMedStat = jQuery.grep(MaxForMedStat, function (value) {
        return value != Number($(this2).children('td.tdDrugSequenceNo').text());
    });

    //MaxForMedStat.push(MaxSeqMedStat - 1);



    // $(this2).prop("disabled", true);
    if ($(this2).children('td.tdtableType1')[0].innerText != "" && $(this2).children('td.tdtableType1')[0].innerText != null && typeof $(this2).children('td.tdtableType1')[0].innerText != "undefined") {
        $(this2).toggleClass('active');
    }
    else {
        // $(this2).prop("disabled", false);
        if ($(this2).children('td.GenricID').text() == "" || $(this2).children('td.tdDrugForm').text() == "" ||
            typeof $(this2).children('td.GenricID').text() == null || typeof $(this2).children('td.tdDrugForm').text() == null) {

            $.session.set('ADDButton', "Click");
        }
        else {
            $.session.set('ADDButton', "")
        }
        $(this2).children('td.tdIntake').find('input.triggerInputIntake')[0].value = ""; //intake input
        $(this2).children('td.durationWord').children('a')[0].innerText = "0";
        $(this2).children('td.durationNum').children('a')[0].innerText = "0";
        // $(this2).children('td.tdBeforeAfter').children('a')[0].innerText = "-"
        $(this2).children('td.tdDosses').find('input.triggerInputDosses')[0].value = "";//dose
        //   $(this2).children('td.tdRemark').children('a')[0].innerText = "Remark";//remark anchor text



        $(this2).children('td.tdRemark').children('input')[0].value = "";

        $(this2).children('td.tdVol').children('a')[0].innerText = "Dil Volume";
        $(this2).children('td.tdVol').children('input')[0].value = "";
        $(this2).children('td.tdADur').children('a')[0].innerText = "Admin Duration";
        $(this2).children('td.tdADur').children('input')[0].value = "";
        $(this2).children('td.tdRoute').children('a')[0].innerText = "Route";
        $(this2).children('td.tdRoute').children('input')[0].value = "Route";

        $(this2).children('td.tdType').children('a')[0].innerText = "Type";
        $(this2).children('td.tdType').children('input')[0].value = "";
        $(this2).children('td.setupyn')[0].innerText = "N";
        $(this2).children('td.refillyn')[0].innerText = "N";
        $(this2).children('td.tdDiltn').find('input.triggerInputDiltn')[0].value = "";
        $(this2).children('td.tdSDate').find('input.triggerInputSDate')[0].value = todayfor;

        // $(this2).children('td.OrderBy')[0].innerText = "";
        //   $(this2).children('td.tdDrugCode')[0].innerText = "";
        // $(this2).children('td.tdTypeCode')[0].innerText = "";
        $(this2).children('td.tdOmittedBy')[0].innerText = "";
        $(this2).children('td.tdOmittedDate')[0].innerText = "";
        $(this2).children('td.tdOmittedTime')[0].innerText = "";
        //  $(this2).children('td.tdOrderedDate')[0].innerText = "";
        // $(this2).children('td.tdOrderedTime')[0].innerText = "";
        $(this2).children('td.tdDrugSequenceNo')[0].innerText = "";
        $(this2).children('td.tdHighAlertDrug')[0].innerText = "";
        $(this2).children('td.tdNotifyYN')[0].innerText = "";
        $(this2).children('td.tdStatus')[0].innerText = "A";
        // $(this2).children('td.tdADMINYN')[0].innerText = "";

        $(this2).children('td').children('a').hide();
        $(this2).children('td').children('input').hide();
        $(this2).children('td').children('select').hide();
        $(this2).children('td').children('div').hide();
        $(this2).children('td').children('span').hide();//vijeta 1/4/19

        var className = $(this2).attr('class');
        if (className.length > 0) {
            var ClassId = className.substr(className.length - 4).trim();
            var advicedayNum = (ClassId).replace(/[^0-9]+/ig, "");
            var RowPos = $('.Tr' + (advicedayNum - 1).toString());
            RowPos.next().after(this2);
        }
        //var rows = $('#tblMedicineList tbody  tr:not(.active)').get();
        //$.each(rows, function (index, row) {
        //    $('#tblMedicineList').children('tbody').append(row);
        //});
    }
    $("#ComplaintInput").val("").trigger("donetyping");//added vijeta 11/4/19
    // SearchComplaint();//added vijeta 11/4/19
    //GetMaterialInteraction(id);
}
$(document.body).on('click', '#tblMedicineList tr', function (e) {


    $(this).children('td').children('a.triggerNum').prop('disabled', true);
    //grid.jqGrid('setCell', rowid, 'OrderedBy', null);
    //$(this).children('td.OrderBy')[0].innerText = null;
    flagforpalnAndOmit = 0;
    flagforplanng = 0;
    flagforomit = 0;
    flagforCancel = 0;
    flagactv = 0;

    if ($(this).children('td.tdOmitYN')[0].innerText == "Y" && $(this).children('td.tdPlannedYN')[0].innerText == "Y" && $(this).children('td.tdtableType1')[0].innerText == "Binding") {
        flagforpalnAndOmit = 1;
    }


    else if ($(this).children('td.tdPlannedYN')[0].innerText == "Y" && $(this).children('td.tdtableType1')[0].innerText == "Binding" && $(this).children('td.tdStatus')[0].innerText != "C") {
        flagforplanng = 1;
    }
    else if ($(this).children('td.tdOmitYN')[0].innerText == "Y" && $(this).children('td.tdtableType1')[0].innerText == "Binding" && $(this).children('td.tdStatus')[0].innerText != "C") {
        flagforomit = 1;
    }
    else if ($(this).children('td.tdStatus')[0].innerText == "C" && $(this).children('td.tdtableType1')[0].innerText == "Binding") {
        flagforCancel = 1;
    }
    else {
        // var i = 0 

        if ($(this).hasClass('active') && $(this).children('td.tdtableType1')[0].innerText == "Binding") {

            //if (i == 0)
            //    $(this).toggleClass('active');

            // i++;

            flagactv = 1;
        } else {
            $(this).toggleClass('active');
        }

    }


    //................................................
    if (flagforpalnAndOmit == 1) {
        $(this).toggleClass('plannedAndOmitted');
        if ($(this).hasClass('plannedAndOmitted')) {
            OnSelectedOne(this);

        }
    }
    else if (flagforomit == 1) {
        $(this).toggleClass('Omited');
        if ($(this).hasClass('Omited')) {
            OnSelectedOne(this);

        }
    }
    else if (flagforplanng == 1) {
        $(this).toggleClass('planclass');
        if ($(this).hasClass('planclass')) {
            OnSelectedOne(this);

        }
    }

    else if (flagforCancel == 1) {
        $(this).toggleClass('Canceled');
        if ($(this).hasClass('Canceled')) {
            OnSelectedOne(this);

        }
    } else {

        //$(this).toggleClass('active');

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



    //............................................
    // $(this).children('td').children('span').show();//vijeta 1/4/19
    $(this).children('td').children('input').prop('disabled', false);
    $(this).children('td').children('a').prop('disabled', false);
    $(this).children('td').children('span').prop('disabled', false);
    $(this).children('td').children('select').prop('disabled', false);
    $(this).children('td').children('div').prop('disabled', false);
    $(this).children('td').children('div span').prop('disabled', false);

    //$(this).children('td.tdIntake').;
    //tdIntake
    //<span class="fa fa-plus fa-2x form-control-feedback intakeImageSpan" title="Add new intake"></span>
    if ($(this).children('td.tdHighAlertDrug')[0].innerText == "Y") {

        $(this).find('td').css("color", "red");
        $(this).find('td a').css("color", "red");
        $(this).find('td input').css("color", "red");
    } else {

        $(this).find('td').css("color", "black");
        $(this).find('td a').css("color", "black");
        $(this).find('td input').css("color", "black");

    }
    if ($(this).children('td.tdOmitYN')[0].innerText == "Y" || $(this).children('td.tdStatus')[0].innerText == "C") {


        //$(this).children('td').children('input').prop('disabled', true);
        //$(this).children('td').children('a').prop('disabled', true);
        //$(this).children('td').children('div').prop('disabled', true);
        //$(this).children('td').children('span').prop('disabled', true);
        //$(this).children('td').children('select').prop('disabled', true);

        //$(this).children('td.tdIntake').find('span').remove();
        //$(this).children('td').children('input').prop('disabled', true);
        //$(this).children('td.tdIntake').find('div input').prop('disabled', true);
        disableAll(this);

        $(this).removeClass("active");
        if ($(this).children('td.tdStatus')[0].innerText == "C") {


            // $(this).children('td.tdOmit').find('input.triggerInputOmit')[0].innerText = "";
            $(this).children('td.tdOmit')[0].innerText = "";
            $(this).addClass("Canceled");

        }
        else if ($(this).children('td.tdOmitYN')[0].innerText == "Y") {
            var mtrlCode = $(this).id;
            $(this).children('td.tdOmit')[0].innerText = "";
            $(this).children('td.tdOmit')[0].innerHTML = "<input type='checkbox'  style='display:none;'  id='Omit" + mtrlCode + "' value='N' class='triggerInputOmit checkboxomit'  />";
            $(this).children('td.tdOmit').find('input.triggerInputOmit').attr('checked', true);

            if ($(this).children('td.tdPlannedYN')[0].innerText == "Y") {

                //$(this).children('td').children('input').prop('disabled', true);
                //$(this).children('td').children('a').prop('disabled', true);
                //$(this).children('td').children('div').prop('disabled', true);
                //$(this).children('td').children('span').prop('disabled', true);
                //$(this).children('td').children('select').prop('disabled', true);

                //$(this).children('td.tdIntake').find('span').remove();
                //$(this).children('td').children('input').prop('disabled', true);
                //$(this).children('td.tdIntake').find('div input').prop('disabled', true);
                disableAll(this);
                $(this).removeClass("Omited");
                $(this).removeClass("active");
                $(this).addClass("plannedAndOmitted");


            }
            else {
                $(this).addClass("Omited");
            }
        }




        //$(this).children('td.tdOmittedBy')[0].innerText = userid;
        //$(this).children('td.tdOmittedDate')[0].innerText = GetTodaysDate();
        //$(this).children('td.tdOmittedTime')[0].innerText = GetTimewithAMPM();
        //  $(this).parents('td').siblings('td.durationNum')[0].innerText = "";
    }
    else {
        $(this).children('td.tdOmit').find('input.triggerInputOmit').attr('checked', false);


        if ($(this).children('td.tdPlannedYN')[0].innerText == "Y") {

            $(this).removeClass("Omited");
            $(this).removeClass("active");
            // if ($(this).children('td.tdADMINYN')[0].innerText == "Y") {
            disableAll(this);

            $(this).children('td.tdOmit').find('input.triggerInputOmit').prop('disabled', false);
            // }
            $(this).addClass("planclass")
        }
        else {
            if (flagactv == 1) {
                $(this).removeClass("Omited");
                $(this).addClass("active");
            }
        }

    }
    //var rows = $('#tblMedicineList tbody  tr:not(.active)').get();

    //sorted unselected rows

    // $("#ComplaintInput").val("").trigger("keyup");//added on 28th sep 2018 //commented by vijeta 11/4/19



});

$(document).ready(function () {
    $('#MonographMaterail').dialog({
        title: 'Medicine Info',
        autoOpen: false,
        position: { my: 'center', at: 'center', of: '#MainDiv', },
        width: 720,
        height: 750,
        draggable: false,
        //show: {
        //    effect: "slide",
        //    duration: 800
        //},
        //hide: {
        //    effect: "fade",
        //    duration: 1000
        //},
        close: function () {
            $("#MonographMaterail").empty();
        },
        open: function (event, ui) {
            $(".ui-dialog-content:not(#MonographMaterail)").dialog("close");
            $(event.target).parent().css('position', 'fixed');
            $(".ui-dialog-title").css({ 'color': 'red' });
            $(".ui-widget-content").css({ 'z-index': '10000' });
            //$(this).load('../DoctorDesk/CreateMaterialInfoPartial');
            //$(this).load("@Url.Action('CreateMaterialInfoPartial)");
            //$("#showSearchedList").height($("#MonographMaterail").height() - 100);//13th nov 
        },
        //for mobile phones and tablets
        //resizable:false,
    });

    $("#btnInteraction").click(function (e) {

        //if (!$("#MonographMaterail").dialog("isOpen")) {
        //    $("#MonographMaterail").dialog("open");
        //} else {
        //    $("#MonographMaterail").dialog("close");
        //}
        //$("#MonographMaterail").empty();

        //$("#MonographMaterail").html(medicineInterStr);


        var frog = window.open();
        frog.document.open()
        frog.document.write(medicineInterStr)
        frog.document.close()
    });
});
function disableAll(New) {
    $(New).children('td').children('a').prop('disabled', true);
    $(New).children('td').children('div').prop('disabled', true);
    $(New).children('td').children('span').prop('disabled', true);
    $(New).children('td').children('select').prop('disabled', true);
    //$(this).children('td').children('select').prop('disabled', true);

    $(New).children('td.tdIntake').find('span').remove();
    $(New).children('td.tdIntake').find('div input').prop('disabled', true);
    $(New).children('td').children('input').prop('disabled', true);

}
function GetListInfoWhileClicking(mtrlCode, clicknot, mtrlName) {

    $.ajax({

        url: '../DoctorDesk/GetMaterialInfo',
        data: { mtrlCode: mtrlCode },
        type: 'post',
        datatype: 'json',

        success: function (response) {
            var Routecode = "Route"
            if (response.Form == "SYP" || response.Form == "TAB" || response.Form == "CAP" || response.Form == "FILM-COATE") {
                Routecode = "Per oral"
            } else if (response.Form == "INJ" || response.Form == "IV" || response.Form == "CAP" || response.Form == "FILM-COATE") {
                Routecode = "Intra venous"
            }
            var result = "";
            var drugcode = "";

            var MaxSeqMedStat;
            if (MaxForMedStat.length > 0) {
                MaxSeqMedStat = Math.max.apply(Math, MaxForMedStat);

            } else {
                MaxSeqMedStat = 0;
            }

            MaxForMedStat.push(MaxSeqMedStat + 1);


            if (response.CODE == "" || response.GenericCode == "" || response.Form == "" || response.CODE == null || response.GenericCode == null || response.Form == null) {
                $.session.set('ADDButton', "Click");
                result = {
                    MTRLCODE: mtrlCode,
                    MTRLNAME: mtrlName,
                    OrderBy: userid,
                    OrderedDate: GetTodaysDate(),
                    OrderedTime: GetTimewithAMPM(),
                    RESEQ: MaxSeqMedStat + 1


                };
                drugcode = mtrlCode;

            } else {


                $.session.set('ADDButton', "");
                result = {
                    MTRLCODE: response.CODE,
                    MTRLNAME: response.NAME,
                    GENERICNAM: response.Generic,
                    GENERICID: response.GenericCode,
                    DRUGFORM: response.Form,
                    Strength: response.Strength,
                    StrengthUnit: response.StrengthUnit,
                    ROUTE: Routecode.toString().trim(),
                    TYPE: response.Form,
                    OrderBy: userid,
                    OrderedDate: GetTodaysDate(),
                    OrderedTime: GetTimewithAMPM(),
                    RESEQ: MaxSeqMedStat + 1
                };
                drugcode = response.CODE;
            }
            //var result = {
            //    MTRLCODE: response.CODE,
            //    MTRLNAME: response.NAME,
            //    GENERICNAM: response.Generic,
            //    GENERICID: response.GenericCode,
            //    DRUGFORM: response.Form,
            //    Strength: response.Strength,
            //    StrengthUnit: response.StrengthUnit,
            //    ROUTE: Routecode.toString().trim()
            //};

            var rows = MedicinesRow(result, true);

            var selRows = $('#tblMedicineList > tbody > tr.active').get(); //group of selected rows
            // var selRows = $('#tblMedicineList > tbody > tr.active').get(); //group of selected rows
            var selRowsOmit = $('#tblMedicineList > tbody > tr.Omited').get();
            var selRowsPlan = $('#tblMedicineList > tbody > tr.planclass').get();
            var selRowsCancl = $('#tblMedicineList > tbody > tr.Canceled').get();
            var selRowsPlnOmt = $('#tblMedicineList > tbody > tr.plannedAndOmitted').get();

            var totallen = selRows.length + selRowsOmit.length + selRowsPlan.length + selRowsCancl.length + selRowsPlnOmt.length

            if (totallen == 0)
                $("#tblMedicineList tbody").prepend(rows).closest('tr');   // If this is first  selected row of table then moved to top  
            else {
                $('#tblMedicineList > tbody > tr').eq(totallen - 1).after(rows); // selected row inserted after group of selected rows
            }
            //if (clicknot == "Y")

            $('#tblMedicineList tr#' + drugcode.replace(/[^0-9a-zA-Z]/gi, '')).trigger('click');




            $('#tblMtrlNewSearch').hide();
            //$('#tblMedicineList input.hasAutoComplete').autocomplete("close");
            $("#tblMedicineList tr#" + drugcode.replace(/[^0-9a-zA-Z]/gi, '') + "" + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
                source: ItakesArray,
                autoFocus: false,
                minLength: 0,
                select: function (event, ui) {

                    var txtval = ui.item.value;
                    var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                    var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();
                    var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();
                    var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();
                    var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;
                    var route = $(this).parents('td').siblings('.tdRoute').find('a').text();//kavita 08-aug
                    var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();
                    var tableRow = $("#tblMedicineList tr").filter(function () {

                        return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim() && $(this).find('td.tdRoute a').text().trim() == route.trim();  //kavita 08-aug
                    }).closest("tr");

                    if (tableRow.length > 0) {
                        $.messager.alert('This medicine and frequency already present');
                        $(this).val('');
                        $(this).focus();
                        return false;
                    }
                    else {
                        if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                            $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                            $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                            // $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                            $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                        }
                        else {
                            //$(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                            $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                        }
                    }


                }
            }).focus(function () {
                /* Only search if the autocomplete menu is hidden: */
                if ($("ul.ui-autocomplete").is(":hidden")) {
                    $(this).autocomplete('search', '');
                }
            });
            //if (clicknot == "Y") {
            $('#tblMedicineList input.hasAutoComplete').autocomplete("close");
            $("#tblMedicineList tr#" + drugcode.replace(/[^0-9a-zA-Z]/gi, '')).find("input.triggerInputIntake").trigger("keydown");
            //}
            //  $(this).parents('td').siblings('.tdRoute').find("input.triggerInputIntake").trigger("keydown");
            //$(this).parents('td').siblings('.tdIntake').find("input")[0].trigger("keydown");

        },
        complete: function () {
            // GetMaterialInteraction(mtrlCode);
            // $(this).parents('td').siblings('.tdIntake').find("input.triggerInputIntake")[0].trigger("keydown");
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $.messager.alert("Error", errorThrown);
        }
    });

}
function MedicinesRow(response, flag, tamperYN) {
    var code = $.trim(response.MTRLCODE);
    var drugCode = $.trim(response.MTRLCODE).trim();
    if (flag)
        code = $.trim(response.MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
    if (tamperYN == "Y")
        code = $.trim(response.MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '') + "_" + response.RESEQ;


    var mtrlName = $.trim(response.MTRLNAME);
    var genericName = $.trim(response.GENERICNAM);
    var genericId = $.trim(response.GENERICID);
    var intake = "";
    var days = "1";
    var duration = "90";
    var food = "-";
    var dossage = "";
    var remarkText = "";
    var remarkCode = "";
    var TypeText = "";
    var TypeCode = "";
    var VolText = "Dil Vol";
    var VolCode = "";
    var ADurText = "Admin Dur";
    var ADurCode = "";
    var routeText = "Route";
    var routeCode = "Route";
    var drugForm = "";
    var setupyn = "N";
    var refillyn = "N";
    var strnth = "";
    var strnthUn = "";
    var OrderBy = '';
    var dil = "";
    var sdate = "";
    var sqno = "";

    var tabletype = "";
    var tabletypetemp = "";
    var TypeCode = "";
    var OmittedBy = "";
    var OmittedDate = "";
    var OmittedTime = "";
    var OrderedDate = "";
    var OrderedTime = "";
    var DrugSequenceNo = "";
    var HighAlertDrug = "";
    var NotifyYN = "N";
    var Status = "A";
    var ADMINYN = "N";
    var omitorcancel = "";
    var omityn = "N";
    var plannedyn = "N";
    if (typeof (response.DRUGCODE) !== "undefined") {
        drugCode = $.trim(response.DRUGCODE);
    }
    if (typeof (response.INTAKE) !== "undefined") {
        intake = $.trim(response.INTAKE);
    }
    if (typeof (response.DAYS) !== "undefined") {
        days = $.trim(response.DAYS);
    }
    if (typeof (response.DURATION) !== "undefined") {
        duration = $.trim(response.DURATION);
    }
    //if (typeof (response.FOOD) !== "undefined") {
    //    food = $.trim(response.FOOD);
    //}
    if (typeof (response.DOSSAGE) !== "undefined") {
        dossage = $.trim(response.DOSSAGE);
    }
    if (typeof (response.DIL) !== "undefined") {
        dil = $.trim(response.DIL);
    }
    if (typeof (response.SDATE) !== "undefined") {
        sdate = $.trim(todayfor);
    }
    if (typeof (response.DrugCode) !== "undefined") {
        DrugCode = $.trim(response.DrugCode);
    }
    if (typeof (response.TypeCode) !== "undefined") {
        TypeCode = $.trim(response.TypeCode);

    }
    if (typeof (response.OmittedBy) !== "undefined") {
        OmittedBy = $.trim(response.OmittedBy);
    }
    if (typeof (response.OmittedDate) !== "undefined") {
        OmittedDate = $.trim(response.OmittedDate);
    }
    if (typeof (response.OmittedTime) !== "undefined") {
        OmittedTime = $.trim(response.OmittedTime);
    }

    if (typeof (response.OrderBy) !== "undefined") {
        OrderBy = $.trim(response.OrderBy);
    }
    if (typeof (response.OrderedDate) !== "undefined") {
        OrderedDate = $.trim(response.OrderedDate);
    }
    if (typeof (response.OrderedTime) !== "undefined") {
        OrderedTime = $.trim(response.OrderedTime);
    }
    if (typeof (response.DrugSequenceNo) !== "undefined") {
        DrugSequenceNo = $.trim(response.DrugSequenceNo);
    }
    if (typeof (response.HighAlertDrug) !== "undefined") {
        HighAlertDrug = $.trim(response.HighAlertDrug);
    }
    if (typeof (response.NotifyYN) !== "undefined") {
        NotifyYN = $.trim(response.NotifyYN);
    }

    if (typeof (response.ADMINYN) !== "undefined") {
        ADMINYN = $.trim(response.ADMINYN);

        if (ADMINYN == "Y")
            omitorcancel = "<input type='checkbox'  style='display:none;'  id='Omit" + code + "' value='N' class='triggerInputOmit checkboxomit'  />"
        else if (ADMINYN != "Y")
            omitorcancel = "<input type='checkbox'  style='display:none;'  id='Omit" + code + "' value='N' class='triggerInputOmit checkboxomit'/><span class='ui-icon ui-icon-cancel' style='margin-left: 40%;' onclick = 'CancellFun(this)'></span>"
    }
    if (typeof (response.OMIT) !== "undefined") {
        omityn = $.trim(response.OMIT);
        if (omityn == "Y") {
            omitorcancel = "<input type='checkbox'  style='display:none;'  id='Omit" + code + "' value='N' class='triggerInputOmit checkboxomit'  />"
        }
        //if (typeof (response.ADMINYN) !== "undefined") {
        //    if (ADMINYN == "N" && omityn == "Y") {



        //    }

        //}
        //omityn
        //if (ADMINYN == "N")
        //    omitorcancel = "<input type='checkbox'  style='display:none;'  id='Omit" + code + "' value='N' class='triggerInputOmit checkboxomit'  />"
        //else if (ADMINYN == "Y")
        //    omitorcancel = "<span class='ui-icon ui-icon-cancel' style='margin-left: 40%;' onclick = 'CancellFun()'></span>"
    }

    if (typeof (response.Status) !== "undefined") {
        Status = $.trim(response.Status);
        if (Status == "C") {
            omitorcancel = "<span class='ui-icon ui-icon-cancel' style='margin-left: 40%;' onclick = 'CancellFun(this)'></span>"
        }
    }

    if (typeof (response.IsPlanData) != "undefined") {
        // if (response.IsPlanData == true)
        plannedyn = response.IsPlanData.toString().trim();
        //else {
        //    plannedyn = "N";
        //}
    }
    if (typeof (response.ROUTE) !== "undefined") {
        if (response.ROUTE.toString().trim() != "") {
            if ($("div#layer-Route #" + response.ROUTE.replace(/[^0-9a-zA-Z]/gi, '')).length > 0) {
                routeText = $("div#layer-Route #" + response.ROUTE.replace(/[^0-9a-zA-Z]/gi, '')).text();
                routeCode = $.trim(response.ROUTE);
            }
        }
    }

    if (typeof (response.REMARK) !== "undefined") {

        remarkText = $.trim(response.REMARK);

        //if (response.REMARK.toString().trim() != "") {
        //    if ($("div#layer-Remark #" + response.REMARK + "").length > 0) {
        //        remarkText = $("div#layer-Remark #" + response.REMARK + "").text();
        //        remarkCode = $.trim(response.REMARK);
        //    }

        //}
    }
    if (typeof (response.TYPE) !== "undefined") {

        if (response.TYPE.toString().trim() != "") {
            var id = response.TYPE.split(".")
            if ($("div#layer-Type #" + id[0] + "").length > 0) {
                TypeText = $("div#layer-Type #" + id[0] + "").text();
                TypeCode = $.trim(response.TYPE);
            }

        }
    }
    if (typeof (response.ADUR) !== "undefined") {

        if (response.ADUR.toString().trim() != "") {
            if ($("div#layer-ADur #" + response.ADUR.replace(/[^0-9a-zA-Z]/gi, '') + "").length > 0) {
                ADurText = $("div#layer-ADur #" + response.ADUR.replace(/[^0-9a-zA-Z]/gi, ''))[0].innerHTML;
                ADurCode = $.trim(response.ADUR.replace(/[^0-9a-zA-Z]/gi, ''));
            }

        }
    }
    if (typeof (response.TBLTYPE) !== "undefined") {

        tabletype = response.TBLTYPE.toString().trim();
    }

    if (typeof (response.TBLTYPETEMP) !== "undefined") {

        tabletypetemp = response.TBLTYPETEMP.toString().trim();
    }
    if (typeof (response.DVOL) !== "undefined") {

        if (response.DVOL.toString().trim() != "") {
            if ($("div#layer-Vol #" + response.DVOL.replace(/[^0-9a-zA-Z]/gi, '') + "").length > 0) {
                VolText = $("div#layer-Vol #" + response.DVOL.replace(/[^0-9a-zA-Z]/gi, ''))[0].innerHTML;
                VolCode = $.trim(response.DVOL);
            }

        }
    }

    if (typeof (response.DRUGFORM) !== "undefined") {
        drugForm = $.trim(response.DRUGFORM);
    }
    if (typeof (response.SETUPYN) !== "undefined") {
        //setupyn = "Y";
        setupyn = response.SETUPYN//
    }
    if (typeof (response.REFILLYN) !== "undefined") {
        refillyn = "Y";
    }
    if (typeof (response.Strength) !== "undefined") {
        dossage += response.Strength;
    }
    if (typeof (response.StrengthUnit) !== "undefined") {
        dossage += " " + response.StrengthUnit;
    }
    if (typeof response.RESEQ != "undefined") {
        sqno = response.RESEQ;
    }
    var druGFrmInitial = "";
    if (drugForm != "") {
        druGFrmInitial = drugForm.length > 2 ? drugForm.substr(0, 3).toString().trim() : drugForm.toString().trim();
    } else {
        druGFrmInitial = "";
    }
    var medicineName = mtrlName;
    if (flag) {
        if (genericName != "")
            medicineName = medicineName + " (" + genericName + ")";
    }


    // if (OMIT == "N")


    rows = "<tr class='" + code + "' id='" + code + "'>" +

        "<td class='MaterialInfo' style='width:2%;vertical-align: initial'><span class='fa fa-info-circle fa-2x medInfoSpan' title='Medicine info' style='display:none;color:#4086bf' ></span></td>" +
        "<td class='MaterialName' style='width:15%;vertical-align: initial'>" + medicineName + "<span style='float:right;display:none;font-weight:bold;color:crimson'>" + druGFrmInitial + "</span></td>" +
        "<td class='tdNewMedSpan'  style='width:3%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td>" +
        "<td class='GenriName' style='display:none'>" + genericName + "</td>" +
        "<td class='GenricID' style='display:none'>" + genericId + "</td>" +
        "<td class='tdIntake' style='width:8%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' value='" + intake + "' id='intake" + code + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake' ></span></div></td>" +
        "<td class='durationNum' style='width:4%'><a class='triggerNum' data-layer-id='' id='Num" + code + "' style='display:none;font-size:14px'>" + days + "</a></td>" +
        "<td class='durationWord' style='width:4%' ><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + code + "' style='display:none;font-size:14px'>" + duration + "</a></td>"
        //if (response.DRUGFORM == "" || typeof response.DRUGFORM == "undefined" || response.DRUGFORM == null)
        + "<td class='tdType' style='width:4%;display:none'><a class='triggerType' href='javascript:;' data-layer-id='layer-Type' id='Type" + code + "' style='display:none;font-size:14px'>" + TypeText + "</a><input type='hidden' id='hdn" + code + "' value='" + TypeCode + "' /></td>"
        // else {
        //  +"<td class='tdType' style='width:4%'><a class='triggerType disabled' href='javascript:;' data-layer-id='layer-Type' id='Type" + code + "' style='display:none;font-size:14px'>" + TypeText + "</a><input type='hidden' id='hdn" + code + "' value='" + TypeCode + "' /></td>"

        //}

        + "<td class='tdRoute' style='width:9%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + code + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + code + "' value='" + routeText.replace(/[^0-9a-zA-Z]/gi, '') + "' /></td>" +

        "<td class='tdDosses' style='width:5%'><input type='text'class='triggerInputDosses form-control'   style='display:none;' placeholder='Dosage' value='" + dossage + "' id='dossage" + code + "' /></td>" + //dosses


        //"<td class='tdRemark' style='width:10%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + code + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + code + "' value='" + remarkCode + "' /></td>" +
        "<td class='tdRemark' style='width:10%'><input type='text'class='triggerRemark form-control'   style='display:none;font-size: 12px' placeholder='Remark'  id='Remark" + code + "'  value= '" + remarkText + "' /></td>" +
        "<td class='tdDrugCode' style='display:none'>" + drugCode + "</td>" +
        "<td class='tdDrugForm' style='display:none'>" + drugForm + "</td>" +

        "<td class='setupyn' style='display:none'>" + setupyn + "</td>" +
        "<td class='refillyn' style='display:none'>" + refillyn + "</td>" +

        //
        "<td class='tdDiltn' style='width:6%'><input type='text'class='triggerInputDiltn form-control'   style='display:none;' placeholder='Diluent' value='" + dil + "' id='Diltn" + code + "' /></td>" +
        "<td class='tdVol' style='width:6%'><a class='triggerVol' href='javascript:;' data-layer-id='layer-Vol' id='Vol" + code + "' style='display:none;font-size:14px'>" + VolText + "</a><input type='hidden' id='Vol" + code + "' value='" + VolCode.replace(/[^0-9a-zA-Z]/gi, '') + "' /></td>" +
        "<td class='tdADur' style='width:6%'><a class='triggerADur' href='javascript:;' data-layer-id='layer-ADur' id='ADur" + code + "' style='display:none;font-size:14px'>" + ADurText + "</a><input type='hidden' id='ADur" + code + "' value='" + ADurCode.replace(/[^0-9a-zA-Z]/gi, '') + "' /></td>" +
        "<td class='tdSDate' style='width:8%'><input type='text'class='triggerInputSDate form-control'   style='display:none;font-size: 12px'  id='SDate" + code + "'  value= '" + sdate + "' /></td>" +

        "<td class='tdPlannedYN' style='width:8%;display:none'>" + plannedyn + "</td>" +
        "<td class='tdOmit' style='width:8%'>" + omitorcancel + "</td>" +
        "<td class='tdOmitYN' style='width:8%;display:none'>" + omityn + "</td>" +
        "<td class='OrderBy' style='width:6%;vertical-align: initial;color: #337ab7;'>" + OrderBy + "</td>"
        + "<td class='tdTypeCode' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + TypeCode + "</td>"
        + "<td class='tdOmittedBy' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + OmittedBy + "</td>"
        + "<td class='tdOmittedDate' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + OmittedDate + "</td>"
        + "<td class='tdOmittedTime' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + OmittedTime + "</td>"
        + "<td class='tdOrderedDate' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + OrderedDate + "</td>"
        + "<td class='tdOrderedTime' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + OrderedTime + "</td>"
        + "<td class='tdDrugSequenceNo' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + sqno + "</td>"
        + "<td class='tdHighAlertDrug' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + HighAlertDrug + "</td>"
        + "<td class='tdNotifyYN' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + NotifyYN + "</td>"
        + "<td class='tdStatus' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + Status + "</td>"
        + "<td class='tdADMINYN' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + ADMINYN + "</td>"
        + "<td class='tdtableType' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + tabletype + "</td>"
        + "<td class='tdtableType1' style='width:6%;vertical-align: initial;color: #337ab7;display:none'>" + tabletypetemp + "</td>"


    //end
    //"<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
    //"<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";


    rows += "</tr>";

    return rows;
}

function GetMaterialInteraction(mtrlCode) {
    var selRows = $('#tblMedicineList > tbody > tr.active').get();
    var arr = [];
    $.each(selRows, function (i, val) {
        var id = $(this).children('td.tdDrugCode')[0].innerText;
        arr.push(id);
    });
    HoldOn.open();
    $.ajax({
        url: '../DoctorDesk/GetMaterialInteraction',
        data: { refCodeArry: JSON.stringify(arr) },
        type: 'Get',
        //datatype: 'json',
        success: function (response) {
            if (response[0] != null && response[1] != null) {
                //based on severity change color of button

                medicineInterStr = response[1];
                if (response[0] != "0") {
                    //$("#btnInteraction").show();

                    if (Number(response[0]) > severityLevel) {
                        severityLevel = response[0];
                    }
                    if (severityLevel == 1)
                        $("#btnInteraction").css("background-color", "green");
                    else if (severityLevel == 2)
                        $("#btnInteraction").css("background-color", "greenyellow");
                    else if (severityLevel == 3)
                        $("#btnInteraction").css("background-color", "yellow");
                    else if (severityLevel == 4)
                        $("#btnInteraction").css("background-color", "orange");
                    else if (severityLevel == 5)
                        $("#btnInteraction").css("background-color", "red");

                }
                else {
                    $("#btnInteraction").css("background-color", "green");
                }


            }
            HoldOn.close();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        }
    });
}
function SetGridDataMedicine(result) {

    grid = $("#" + AllGrid[0]);
    grid.jqGrid('clearGridData');

    if (result.jsonMedicineData.length > 0) {
        if (ISRYN == "Y") {
            for (var i = 0; i <= result.jsonMedicineData.length - 1; i++) {
                result.jsonMedicineData[i]["ADMINYN"] = "";
                result.jsonMedicineData[i]["DayOfDrug"] = Number(result.jsonMedicineData[i]["DayOfDrug"]) + 1;   //5th Mar 2019
            }
            var resultjsonMedicineData = $.grep(result.jsonMedicineData, function (e) { return e.DayOfDrug != e.Duration });
        }
        SetGridPropByResult(result.jsonMedicineData);
        MediDefault = false;
        if (ISRYN == "Y") {
            grid.jqGrid('setGridParam', { data: resultjsonMedicineData }).trigger("reloadGrid");
        }
        else {
            grid.jqGrid('setGridParam', { data: result.jsonMedicineData }).trigger("reloadGrid");
        }
        //grid.jqGrid('setGridParam', { data: result.jsonMedicineData }).trigger("reloadGrid");
        // AddBlankRowToTable(grid, AllGrid[0], 50);
        var totlen = grid.jqGrid('getRowData');                                              ///added by vishal as on 20th Sept 2018
        var curlen = $.grep(totlen, function (e) { return e.DrugCode != "" });
        var remlen = Number(totlen) - Number(curlen.length);
        AddBlankRowToTable(grid, AllGrid[0], 1);
    }
    else {
        AddBlankRowToTable(grid, AllGrid[0], 1);
    }
}
function RxNewSetData(result) {
    var result1 = "";
    $("#tblMedicineList tr").remove();


    if (result.hasOwnProperty("jsonStatOrderData")) {
        if ($.session.get('IPStatOrdersflag') == "Stat")
            var result1 = result.jsonStatOrderData;
        else
            var result1 = result.jsonMedicineData;

        // GetMedicinePlanData();
        if (result1.length > 0) {
            result1.sort(function (a, b) {
                return parseFloat(b.SEQNO) - parseFloat(a.SEQNO);
            });
        }
    }

    for (var i = 0; i < result1.length; i++) {

        var NonFrqRows = '';
        var DurgID = $.trim(result1[i]["CODE"]).replace(/[^0-9a-zA-Z]/gi, '');
        //Added by Tejashri 26/12/2018
        var food = '';
        //if (result1[i]["TYPE"] == "E")
        food = result1[i]["TYPE"].toString().trim();

        //else if (result1[i]["ABFOOD"] == "-")
        //    food = "-";
        //else
        //    food = "A";
        //End
        var NonFrqRows = '';
        RxNewSetDataflag = 1;


        MaxForMedStat.push(Number(result1[i].SEQNO));


        if ((typeof result1[i]["GENERICNAME"]).trim() == 'undefined' || (result1[i]["GENERICNAME"]).trim() == '') {
            $.session.set('ADDButton', "Click");
        }

        var tamperYn = 'N'//(result1[i]["TAMPERYN"]).toString();
        var temp = "Y";
        // //if (PlanData.TRETMEDICINE != "" && PlanData.TRETMEDICINE != null)
        // var IsPlanData = CheckPlanData(result1[i]["CODE"].trim(), "AB");


        if ($('#tblMedicineList tr#' + DurgID + "").length > 0 && !$('#tblMedicineList tr#' + DurgID + "").hasClass("active") && tamperYn == "N" && temp == "N") {
            //if (((result1[i]["SETUPYN"]).toString() != "N" && (result1[i]["SETUPYN"]).toString() != "") && !$('#tblMedicineList tr#' + DurgID + "").hasClass("active") && tamperYn == "N") {

            $('#tblMedicineList tr#' + DurgID + ' td.tdIntake')[0].innerHTML = "<div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Intake' value='" + result1[i]["FREQ"].trim() + "' id='intake" + DurgID + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake'></span></div>";//intake 
            // $('#tblMedicineList tr#' + DurgID + ' td.AddNewIntake')[0].innerHTML = "<a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/add.png'  class='intakeImage'></a>";
            $('#tblMedicineList tr#' + DurgID + ' td.durationNum')[0].innerHTML = "<a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + DurgID + "' style='display:none;font-size:14px'>" + result1[i]["DAYOFDRUG"] + "</a>";
            $('#tblMedicineList tr#' + DurgID + ' td.durationWord')[0].innerHTML = "<a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + DurgID + "' style='display:none;font-size:14px'>" + result1[i]["DURATION"] + "</a>";
            // $('#tblMedicineList tr#' + DurgID + ' td.tdBeforeAfter')[0].innerHTML = "<a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + DurgID + "' style='display:none;font-size:14px'>" + food + "</a>";

            //kavita 08-aug-2019
            if (result1[i]["ROUTE"].toString().trim() != "") {
                var routeText = "Route";
                if ($("div#layer-Route #" + result1[i]["ROUTE"].replace(/[^0-9a-zA-Z]/gi, '') + "").length > 0)

                    routeText = $("div#layer-Route #" + result1[i]["ROUTE"].replace(/[^0-9a-zA-Z]/gi, '') + "").text();
                $('#tblMedicineList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result1[i]["ROUTE"].replace(/[^0-9a-zA-Z]/gi, '') + "' />";
            }
            else {
                $('#tblMedicineList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>Route</a><input type='hidden' id='hdn" + DurgID + "'  />";
            }


            $('#tblMedicineList tr#' + DurgID + ' td.tdDosses')[0].innerHTML = "<input type='text' class='triggerInputDosses form-control'  style='display:none;' placeholder='Dosage' value='" + result1[i]["DOSE"].trim() + "' id='dossage" + DurgID + "' />";
            $('#tblMedicineList tr#' + DurgID + ' td.tdDiltn')[0].innerHTML = "<input type='text' class='triggerInputDiltn form-control'  style='display:none;' placeholder='Dosage' value='" + result1[i]["DILUENT"].trim() + "' id='Diltn" + DurgID + "' />";
            $('#tblMedicineList tr#' + DurgID + ' td.tdSDate')[0].innerHTML = "<input type='text' class='triggerInputSDate form-control'  style='display:none;' value='" + result1[i]["STARTFRMDT"].trim() + "' id='SDate" + DurgID + "' />";

            var remarkText = "";
            if (result1[i]["REMARK"].toString().trim() != "") {

                remarkText = result1[i]["REMARK"];

                //if ($("div#layer-Remark #" + result1[i]["REMARK"] + "").length > 0)
                //   remarkText = $("div#layer-Remark #" + result1[i]["REMARK"] + "").text();

                $('#tblMedicineList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<input type='text' class='triggerRemark form-control' laceholder='Remark' style='display:none;' value='" + remarkText + "' id='Remark" + DurgID + "' />";
            }
            else {

                $('#tblMedicineList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<input type='text' class='triggerRemark form-control' laceholder='Remark' style='display:none;' value='" + remarkText + "' id='Remark" + DurgID + "' />";
            }
            if (result1[i]["TYPE"].toString().trim() != "") {

                var TypeText = "Type";

                if ($("div#layer-Type #" + result1[i]["TYPE"].split(".")[0] + "").length > 0)
                    TypeText = $("div#layer-Type #" + result1[i]["TYPE"].split(".")[0] + "").text();

                $('#tblMedicineList tr#' + DurgID + ' td.tdType')[0].innerHTML = "<a class='triggerType' href='javascript:;' data-layer-id='layer-Type' id='Type" + DurgID + "' style='display:none;font-size:14px'>" + TypeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result1[i]["TYPE"] + "' />";
            }
            else {
                $('#tblMedicineList tr#' + DurgID + ' td.tdType')[0].innerHTML = "<a class='triggerType' href='javascript:;' data-layer-id='layer-Type' id='Type" + DurgID + "' style='display:none;font-size:14px'>Type</a><input type='hidden' id='hdn" + DurgID + "'  />";
            }
            if (result1[i]["DILVOLUME"].toString().trim() != "") {
                //if (result1[i]["DVol"].toString().trim() != "") {

                var VolText = "Dil Vol";

                if ($("div#layer-Vol #" + result1[i]["DILVOLUME"] + "").length > 0)
                    VolText = $("div#layer-Vol #" + result1[i]["DILVOLUME"] + "")[0].innerText = "";

                $('#tblMedicineList tr#' + DurgID + ' td.tdVol')[0].innerHTML = "<a class='triggerVol' href='javascript:;' data-layer-id='layer-Vol' id='Vol" + DurgID + "' style='display:none;font-size:14px'>" + VolText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result1[i]["DILVOLUME"] + "' />";
            }
            else {
                $('#tblMedicineList tr#' + DurgID + ' td.tdVol')[0].innerHTML = "<a class='triggerVol' href='javascript:;' data-layer-id='layer-Vol' id='Vol" + DurgID + "' style='display:none;font-size:14px'>Dil Vol</a><input type='hidden' id='hdn" + DurgID + "'  />";
            }
            if (result1[i]["ADMINDUR"].toString().trim() != "") {

                var ADurText = "Admin Dur";

                if ($("div#layer-ADur #" + result1[i]["ADMINDUR"] + "").length > 0)
                    ADurText = $("div#layer-ADur #" + result1[i]["ADMINDUR"] + "")[0].innerText = "";

                $('#tblMedicineList tr#' + DurgID + ' td.tdADur')[0].innerHTML = "<a class='triggerADur' href='javascript:;' data-layer-id='layer-ADur' id='ADur" + DurgID + "' style='display:none;font-size:14px'>" + ADurText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result1[i]["ADMINDUR"] + "' />";
            }
            else {
                $('#tblMedicineList tr#' + DurgID + ' td.tdADur')[0].innerHTML = "<a class='triggerADur' href='javascript:;' data-layer-id='layer-ADur' id='ADur" + DurgID + "' style='display:none;font-size:14px'>Admn Dur</a><input type='hidden' id='hdn" + DurgID + "'  />";
            }

            $('#tblMedicineList tr#' + DurgID + ' td.tdDrugCode')[0].innerText = (result1[i]["CODE"]).trim(); //vijeta 4/5/19

            $('#tblMedicineList tr#' + DurgID + ' td.tdDrugForm')[0].innerHTML = result1[i]["TYPE"].trim();

            //added 29/6/19
            // $('#tblMedicineList tr#' + DurgID + ' td.setupyn')[0].innerHTML = result1[i]["SETUPYN"].trim();
            // $('#tblMedicineList tr#' + DurgID + ' td.refillyn')[0].innerHTML = result1[i]["REFILLYN"].trim();

            //$('#tblMedicineList tr#' + DurgID + ' td.sortTD1')[0].innerHTML = "<a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a>";
            //$('#tblMedicineList tr#' + DurgID + ' td.sortTD2')[0].innerHTML = "<a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a>";

            $('#tblMedicineList tr#' + DurgID + ' td.tdTypeCode')[0].innerHTML = result1[i]["TBLTYPE"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdOmittedBy')[0].innerHTML = result1[i]["OMITBY"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdOmittedDate')[0].innerHTML = result1[i]["OMITDT"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdOmittedTime')[0].innerHTML = result1[i]["OMITTM"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdOrderedDate')[0].innerHTML = result1[i]["ORDDATE"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdOrderedTime')[0].innerHTML = result1[i]["ORDTIME"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdDrugSequenceNo')[0].innerHTML = result1[i]["SEQNO"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdHighAlertDrug')[0].innerHTML = result1[i]["ALERTYN"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdNotifyYN')[0].innerHTML = result1[i]["NOTIFYN"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdStatus')[0].innerHTML = result1[i]["STATUS"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.tdADMINYN')[0].innerHTML = result1[i]["ADMINYN"].trim();


            $('#tblMedicineList tr#' + DurgID).trigger('click');
        }
        else
            if ($('#tblMedicineList tr#' + DurgID + "").length > 0) {
                DurgID = DurgID.replace(/\//g, '');
                DurgID = DurgID + "_" + result1[i].SEQNO;
                // new


                var result3 = {
                    MTRLCODE: $.trim(result1[i]["CODE"]),
                    MTRLNAME: $.trim(result1[i]["DRUGNAME"]),
                    GENERICNAM: $.trim(result1[i].GENERICNAME),
                    GENERICID: $.trim(result1[i].GENERICID),
                    INTAKE: result1[i]["FREQ"].trim(),
                    DAYS: result1[i]["DAYOFDRUG"],
                    DURATION: result1[i]["DURATION"],
                    OMIT: result1[i]["OMIT"],
                    OmittedBy: result1[i]["OMITBY"],
                    OmittedDate: result1[i]["OMITDT"],
                    OmittedTime: result1[i]["OMITTM"],
                    DOSSAGE: result1[i]["DOSE"].trim(),
                    DIL: result1[i]["DILUENT"].trim(),
                    SDATE: result1[i]["STARTFRMDT"].trim(),
                    ROUTE: result1[i]["ROUTE"].trim(),//kavita 08-aug
                    REMARK: result1[i]["REMARK"],
                    TYPE: result1[i]["TYPE"],
                    DVOL: result1[i]["DILVOLUME"],
                    ADUR: result1[i]["ADMINDUR"],
                    RESEQ: result1[i]["SEQNO"],
                    DRUGFORM: result1[i]["TYPE"].trim(),
                    TBLTYPETEMP: "Binding",
                    TBLTYPE: result1[i]["TBLTYPE"].trim(),
                    ADMINYN: result1[i]["ADMINYN"].trim(),
                    Status: result1[i]["STATUS"].trim(),
                    IsPlanData: result1[i]["PL"].trim(),
                    HighAlertDrug: result1[i]["ALERTYN"].trim(),
                    NotifyYN: result1[i]["NOTIFYN"].trim(),
                    OrderBy: result1[i]["ORDERBY"].trim(),
                    OrderedDate: result1[i]["ORDDATE"].trim(),
                    OrderedTime: result1[i]["ORDTIME"].trim()
                };

                NonFrqRows = MedicinesRow(result3, true, "Y");


                $('#tblMedicineList tbody').prepend(NonFrqRows).closest('tr');
                $('#tblMedicineList tr#' + DurgID).trigger('click');
            }
            else {

                if ($('#tblMedicineList tr#' + DurgID + "").length == 0 && tamperYn == "N") {
                    DurgID = DurgID.replace(/\//g, '');


                    var result2 = {
                        MTRLCODE: $.trim(result1[i]["CODE"]),
                        MTRLNAME: $.trim(result1[i].DRUGNAME),
                        //GENERICNAM: $.trim(result1[i].GENERICNAME),
                        //GENERICID: $.trim(result1[i].GENERICID),
                        // GENERICNAM: "dfdfddfd",
                        // GENERICID: "546656",
                        OMIT: result1[i]["OMIT"],
                        OmittedBy: result1[i]["OMITBY"],
                        OmittedDate: result1[i]["OMITDT"],
                        OmittedTime: result1[i]["OMITTM"],
                        INTAKE: result1[i]["FREQ"].trim(),
                        DAYS: result1[i]["DAYOFDRUG"],
                        DURATION: result1[i]["DURATION"],
                        //FOOD: food,
                        DOSSAGE: result1[i]["DOSE"].trim(),
                        DIL: result1[i]["DILUENT"].trim(),
                        SDATE: result1[i]["STARTFRMDT"].trim(),
                        ROUTE: result1[i]["ROUTE"].trim(),//kavita 08-aug
                        REMARK: result1[i]["REMARK"],
                        TYPE: result1[i]["TYPE"],
                        DVOL: result1[i]["DILVOLUME"],
                        ADUR: result1[i]["ADMINDUR"],
                        RESEQ: result1[i]["SEQNO"],
                        DRUGFORM: result1[i]["TYPE"].trim(),
                        TBLTYPETEMP: "Binding",
                        TBLTYPE: result1[i]["TBLTYPE"].trim(),
                        ADMINYN: result1[i]["ADMINYN"].trim(),
                        Status: result1[i]["STATUS"].trim(),
                        IsPlanData: result1[i]["PL"].trim(),
                        HighAlertDrug: result1[i]["ALERTYN"].trim(),
                        NotifyYN: result1[i]["NOTIFYN"].trim(),
                        OrderBy: result1[i]["ORDERBY"].trim(),
                        OrderedDate: result1[i]["ORDDATE"].trim(),
                        OrderedTime: result1[i]["ORDTIME"].trim(),


                    };

                    NonFrqRows = MedicinesRow(result2, true);


                    $('#tblMedicineList tbody').prepend(NonFrqRows).closest('tr');
                    $('#tblMedicineList tr#' + DurgID).trigger('click');
                }


            }

    }

}
function GetMedicinePlanData() {

    var d = new Date();

    var month = d.getMonth() + 1;
    var day = d.getDate();

    var output = (day < 10 ? '0' : '') + day + '/' +
        (month < 10 ? '0' : '') + month + '/' + d.getFullYear();
    IpNo = '' + $.session.get('ICUPatIPNO');
    transDate = '' + $("#txtTransDate").val();
    var NursCode = '' + $.session.get('ICUPatNurstCode');
    $.ajax({
        url: '../ICUMob/GetTSPlandList',
        // url: 'GetTSPlandList',
        data: { IPNum: IpNo, TsDate: output, RecordType: "P", IsRollver: "N", NurseCode: NursCode },
        type: 'get',
        async: false,
        dataType: "json",
        success: function (ResposeResult) {
            if (ResposeResult != "Unsucessfull") {
                PlanData = JSON.parse(ResposeResult);
            }

            else {
                PlanData = "";
            }

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // ajaxindicatorstop();
            MsgDia(textStatus, "Error Information");
        }

    });
}
function CheckPlanData(SEQNUM, tbltype) {

    records = $.grep(PlanData.TRETMEDICINE, function (element, Index) {
        return (element.SEQNO == SEQNUM && element.RECTYPE == "P");
    })
    if (records.length > 0) {
        return true;
    }
    else {
        return false;
    }
}