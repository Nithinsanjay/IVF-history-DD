var severityLevel = 1;
var medicineInterStr = "";

$(document.body).on('click', '#tblMtrlNewSearch tr', function (e) {

    $("#ComplaintInput").val("").trigger("donetyping");
    SearchComplaint();
    var mtrlCode = $(this).children('td.mtrlCode')[0].innerText;
    var mtrlName = $(this).children('td.mtrlName')[0].innerText;

    GetListInfoWhileClicking(mtrlCode, "Y", mtrlName);
});

function GetinfoForFreqnt() {
    $.ajax({

        url: '../DoctorDesk/GetMaterialInfo',
        data: { mtrlCode: result.Table[i].MTRLCODE.toString().trim() },
        type: 'post',
        datatype: 'json',

        success: function (response) {

            var result = {
                MTRLCODE: response.CODE,
                MTRLNAME: response.NAME,
                GENERICNAM: response.Generic,
                GENERICID: response.GenericCode,
                DRUGFORM: response.Form,
                Strength: response.Strength,
                StrengthUnit: response.StrengthUnit
            };

            var rows = MedicinesRow(result, true);
            $('#tblMedicineList tbody').append(rows);
        }, complete: function () {
            // GetMaterialInteraction(mtrlCode);
            // $(this).parents('td').siblings('.tdIntake').find("input.triggerInputIntake")[0].trigger("keydown");
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $.messager.alert("Error", errorThrown);
        }
    });
}

$(document.body).on('click', '.medInfoSpan', function (e) {
    HoldOn.open();
    var refCode = "";
    if ($(this).hasClass('FromGrid')) {
        refCode = $("#tblGrid").jqGrid('getCell', $(this).parent().parent()[0].id, 'CODE');
    }
    else {
        refCode = $(this).parents('td').siblings('.tdDrugCode')[0].innerText;
    }

    $.ajax({
        url: '../DoctorDesk/GetMonographInfo',
        data: { refCode: refCode },
        type: 'Get',
        cache: false,
        contentType: 'application/html; charset=utf-8',
        datatype: 'html',
        success: function (response) {
            if (response != "") {
                var d = window.open();
                d.document.open()
                d.document.write(response)
                d.document.close()
            }
            HoldOn.close();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            HoldOn.close();
            $.messager.alert("Error", errorThrown);
        }
    });
})

$(document.body).on('click', '#tblMedicineList tr', function (e) {

    var flag = 0;

    $(this).toggleClass('active');

    if ($(this).hasClass('active')) {

        var selRows = $('#tblMedicineList > tbody > tr.active').get(); //group of selected rows

        if (selRows.length == 0)
            $("#tblMedicineList tbody").prepend($(this)).closest('tr');   // If this is first  selected row of table then moved to top  
        else {
            $('#tblMedicineList > tbody > tr').eq(selRows.length).after($(this)); // selected row inserted after group of selected rows
            //$('#tblMedicineList > tbody > tr').eq(selRows.length).after($(this));
            //$("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRoute').find('a.triggerRoute').trigger('click')
        }

        //.................................................

        //MTRLCODE: response.CODE,
        //MTRLNAME: response.NAME,
        //GENERICNAM: response.Generic,
        //GENERICID: response.GenericCode,
        //DRUGFORM: response.Form,
        //Strength: response.Strength,
        //StrengthUnit: response.StrengthUnit

        if ($.session.get('ADDButton') == "") {
            if ($(this).children('td.GenricID').text() == "" || $(this).children('td.GenricID').text() == undefined || $(this).children('td.GenricID').text() == null || $(this).children('td.tdDrugForm').text() == "" || $(this).children('td.tdDrugForm').text() == undefined) {
                var mtrlCode = $(this).children('td.tdDrugCode').text();
                var mtrlName = $(this).children('td.MaterialName').text();

                $(this).remove();
                GetListInfoWhileClicking(mtrlCode, "N", mtrlName);

                flag = 1;
            }
        }
        else {
            $.session.set('ADDButton', "");
        }
        //.............................................


        $(this).children('td').children('a').show();
        $(this).children('td').children('input').show();
        $(this).children('td').children('select').show();
        $(this).children('td').children('div').show();
        $(this).children('td').children('span').show();

        $('#tblMedicineList input.hasAutoComplete').autocomplete("close");
        var rows = $('#tblMedicineList tbody  tr:not(.active)').get();
        $.each(rows, function (index, row) {
            $('#tblMedicineList').children('tbody').append(row);
        });
        if (RxNewSetDataflag == 0) {
            $(this).find("input.triggerInputIntake").trigger("focus");
            $(this).find("input.triggerInputIntake").trigger("keydown");
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

        var id = $(this).children('.tdDrugCode')[0].innerText;
    }
    else {
        if ($(this).children('td.GenricID').text() == "" || $(this).children('td.GenricID').text() == undefined || $(this).children('td.GenricID').text() == null
            || $(this).children('td.tdDrugForm').text() == "" || $(this).children('td.tdDrugForm').text() == undefined) {
            $.session.set('ADDButton', "Click");
        }
        else {
            $.session.set('ADDButton', "")
        }
        $(this).children('td.tdIntake').find('input.triggerInputIntake')[0].value = ""; //intake input
        $(this).children('td.durationWord').children('a')[0].innerText = "D";
        $(this).children('td.durationNum').children('a')[0].innerText = "0";
        $(this).children('td.tdBeforeAfter').children('a')[0].innerText = "-"
        $(this).children('td.tdDosses').find('input.triggerInputDosses')[0].value = "";//dose
        $(this).children('td.tdRemark').children('a')[0].innerText = "Remark";//remark anchor text
        $(this).children('td.tdRemark').children('input')[0].value = "";//remark dopdown value
        $(this).children('td.tdRoute').children('a')[0].innerText = "Route";//remark anchor text
        $(this).children('td.tdRoute').children('input')[0].value = "";//remark dopdown value
        $(this).children('td.setupyn')[0].innerText = "N";
        $(this).children('td.refillyn')[0].innerText = "N";

        $(this).children('td').children('a').hide();
        $(this).children('td').children('input').hide();
        $(this).children('td').children('select').hide();
        $(this).children('td').children('div').hide();
        $(this).children('td').children('span').hide();//vijeta 1/4/19

        var className = $(this).attr('class');
        if (className.length > 0) {
            var ClassId = className.substr(className.length - 4).trim();
            var advicedayNum = (ClassId).replace(/[^0-9]+/ig, "");
            var RowPos = $('.Tr' + (advicedayNum - 1).toString());
            RowPos.next().after(this);
        }
    }

    var rows = $('#tblMedicineList tbody  tr:not(.active)').get();

    $.each(rows, function (index, row) {
        $('#tblMedicineList').children('tbody').append(row);
    });             //sorted unselected rows

    // $("#ComplaintInput").val("").trigger("keyup");//added on 28th sep 2018 //commented by vijeta 11/4/19
    $("#ComplaintInput").val("").trigger("donetyping");//added vijeta 11/4/19
    if (flag == 0) {
        SearchComplaint();
        flagforConfirmChckbox = 0;
        // GetMaterialInteraction(id); Meenaskhi on 19/11/2019 getting slow so temporary commented - told by Sir
    }

});

$(document).ready(function () {
    $('#MonographMaterail').dialog({
        title: 'Medicine Info',
        autoOpen: false,
        position: { my: 'center', at: 'center', of: '#MainDiv', },
        width: 720,
        height: 750,
        draggable: false,

        close: function () {
            $("#MonographMaterail").empty();
        },
        open: function (event, ui) {
            $(".ui-dialog-content:not(#MonographMaterail)").dialog("close");
            $(event.target).parent().css('position', 'fixed');
            $(".ui-dialog-title").css({ 'color': 'red' });
            $(".ui-widget-content").css({ 'z-index': '10000' });
        },
        //for mobile phones and tablets
        //resizable:false,
    });

    $("#btnInteraction").click(function (e) {// 18-12-19

        GetMaterialInteraction("");//


        var win = window.open("Interaction_Window", "_blank");
        win.onload = function () {
            win.document.open();
            win.document.write(medicineInterStr);
            win.document.write('<title>Medicine | Interaction</title>');
            win.document.close();
        }
    });
});

function GetListInfoWhileClicking(mtrlCode, clicknot, mtrlName) {

    $.ajax({

        url: '../DoctorDesk/GetMaterialInfo',
        data: { mtrlCode: mtrlCode },
        type: 'post',
        datatype: 'json',

        success: function (response) {
            var Routecode = ""
            if (response.Form == "SYP" || response.Form == "TAB" || response.Form == "CAP" || response.Form == "FILM-COATE") {
                Routecode = "09"
            } else if (response.Form == "INJ" || response.Form == "IV" || response.Form == "CAP" || response.Form == "FILM-COATE") {
                Routecode = "02"
            }
            var result = "";
            var drugcode = "";

            if (response.CODE == "" || response.GenericCode == "" || response.Form == "" || response.CODE == null || response.GenericCode == null || response.Form == null) {
                $.session.set('ADDButton', "Click");
                result = {
                    MTRLCODE: mtrlCode,
                    MTRLNAME: mtrlName,

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
                    ROUTE: Routecode.toString().trim()
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

            if (selRows.length == 0)
                $("#tblMedicineList tbody").prepend(rows).closest('tr');   // If this is first  selected row of table then moved to top  
            else {
                $('#tblMedicineList > tbody > tr').eq(selRows.length - 1).after(rows); // selected row inserted after group of selected rows
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
        code = $.trim(response.MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '') + "_T" + response.RESEQ;

    var mtrlName = $.trim(response.MTRLNAME);
    var genericName = $.trim(response.GENERICNAM);
    var genericId = $.trim(response.GENERICID);
    var intake = "";
    var days = "0";
    var duration = "D";
    var food = "-";
    var dossage = "";
    var remarkText = "Remark";
    var remarkCode = "";
    var routeText = "Route";//
    var routeCode = ""; //
    var drugForm = "";
    var setupyn = "N";
    var refillyn = "N";
    var strnth = "";
    var strnthUn = "";
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
    if (typeof (response.FOOD) !== "undefined") {
        food = $.trim(response.FOOD);
    }
    if (typeof (response.DOSSAGE) !== "undefined") {
        dossage = $.trim(response.DOSSAGE);
    }

    //kavita 08-aug
    if (typeof (response.ROUTE) !== "undefined") {
        if (response.ROUTE.toString().trim() != "") {
            if ($("div#layer-Route").children('a#' + response.ROUTE).length > 0) {
                routeText = $("div#layer-Route").children('a#' + response.ROUTE).text()//$("div#layer-Route #" + response.ROUTE + "").text();
                routeCode = $.trim(response.ROUTE);
            }
        }
    }
    //kavita 08-aug
    if (typeof (response.REMARK) !== "undefined") {

        if (response.REMARK.toString().trim() != "") {
            if ($("div#layer-Remark #" + response.REMARK + "").length > 0) {
                remarkText = $("div#layer-Remark #" + response.REMARK + "").text();
                remarkCode = $.trim(response.REMARK);
            }

        }
    }

    if (typeof (response.DRUGFORM) !== "undefined") {
        drugForm = "" + $.trim(response.DRUGFORM);
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
    if (drugForm != "") {
        var druGFrmInitial = drugForm.length > 2 ? drugForm.substr(0, 3).toString().trim() : drugForm.toString().trim();
    } else {
        druGFrmInitial = "";
    }

    var medicineName = mtrlName;
    if (flag) {
        if (genericName != "")
            medicineName = medicineName + " (" + genericName + ")";
    }

    rows = "<tr class='" + code + "' id='" + code + "'>" +

        "<td class='MaterialInfo' style='width:2%;vertical-align: initial'><span class='fa fa-info-circle fa-2x medInfoSpan' title='Medicine info' style='display:none;color:#4086bf' ></span></td>" +
        "<td class='MaterialName' style='width:26%;vertical-align: initial'>" + medicineName + "<span style='float:right;display:none;font-weight:bold;color:crimson;font-size: 11px;'>" + druGFrmInitial + "</span></td>" +
        "<td class='tdNewMedSpan'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td>" +
        "<td class='GenriName' style='display:none'>" + genericName + "</td>" +
        "<td class='GenricID' style='display:none'>" + genericId + "</td>" +
        "<td class='tdIntake' style='width:12%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' value='" + intake + "' id='intake" + code + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake' ></span></div></td>" +
        "<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + code + "' style='display:none;font-size:14px'>" + days + "</a></td>" +
        "<td class='durationWord' style='width:5%' ><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + code + "' style='display:none;font-size:14px'>" + duration + "</a></td>" +
        "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + code + "' style='display:none;font-size:14px'>" + food + "</a></td>" +//after food before food
        //kavita 08-aug
        "<td class='tdRoute' style='width:10%'><a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + code + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + code + "' value='" + routeCode + "' /></td>" +

        "<td class='tdDosses' style='width:10%'><input type='text'class='triggerInputDosses form-control'   style='display:none;' placeholder='Dosage' value='" + dossage + "' id='dossage" + code + "' /></td>" + //dosses


        "<td class='tdRemark' style='width:19%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + code + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + code + "' value='" + remarkCode + "' /></td>" +

        "<td class='tdDrugCode' style='display:none'>" + drugCode + "</td>" +
        "<td class='tdDrugForm' style='display:none'>" + drugForm + "</td>" +

        "<td class='setupyn' style='display:none'>" + setupyn + "</td>" +
        "<td class='refillyn' style='display:none'>" + refillyn + "</td>" +

        "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
        "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
    rows += "</tr>";

    return rows;
}

function GetMaterialInteraction(mtrlCode) {
    var arr = [];
    if (flagforConfirmChckbox == 1) {
        var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

        $.each(ids, function (i, val) {
            var id = $("#tblGrid").jqGrid('getCell', val, 'CODE');
            //var id = $(this).children('td.tdDrugCode')[0].innerText;
            arr.push(id);
        });

    } else {
        var selRows = $('#tblMedicineList > tbody > tr.active').get();
        // var arr = [];
        $.each(selRows, function (i, val) {
            var id = $(this).children('td.tdDrugCode')[0].innerText;
            arr.push(id);
        });
    }
    HoldOn.open();
    $.ajax({
        url: '../DoctorDesk/GetMaterialInteraction',
        data: { refCodeArry: JSON.stringify(arr) },
        type: 'Get',
        async: false,//27-11-19
        //datatype: 'json',
        success: function (response) {
            if (response[0] != null && response[1] != null) {
                //based on severity change color of button

                medicineInterStr = response[1];
                if (response[0] != "0") {
                    //$("#btnInteraction").show();
                    severityLevel = 1;

                    if (Number(response[0]) > severityLevel) {
                        severityLevel = response[0];
                    }
                    if (severityLevel == 1) {
                        if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "green"); } else
                            $("#btnInteraction").css("background-color", "green");
                    }
                    else if (severityLevel == 2) {
                        if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "greenyellow"); } else
                            $("#btnInteraction").css("background-color", "greenyellow");
                    }
                    else if (severityLevel == 3) {
                        if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "yellow"); } else
                            $("#btnInteraction").css("background-color", "yellow");
                    }
                    else if (severityLevel == 4) {
                        if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "orange"); } else
                            $("#btnInteraction").css("background-color", "orange");
                    }
                    else if (severityLevel == 5) {
                        if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "red"); } else
                            $("#btnInteraction").css("background-color", "red");
                    }
                }
                else {
                    if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "green"); }
                    else
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

function RxNewSetData(result) {
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

        var tamperYn = (result[i]["TAMPERYN"]).toString();
        RxNewSetDataflag = 1;

        if ((result[i]["GENERICNAME"]).trim() == "" || result[i]["DRUGFORM"].trim() == "") {
            $.session.set('ADDButton', "Click");
        }

        if ($('#tblMedicineList tr#' + DurgID + "").length > 0 && !$('#tblMedicineList tr#' + DurgID + "").hasClass("active") && tamperYn == "N") {
            //if (((result[i]["SETUPYN"]).toString() != "N" && (result[i]["SETUPYN"]).toString() != "") && !$('#tblMedicineList tr#' + DurgID + "").hasClass("active") && tamperYn == "N") {

            var Matinfo = "";


            if ((result[i]["GENERICID"]).trim() == "")
                // $('#tblMedicineList tr#' + DurgID + ' td.MaterialName')[0].innerText = (result[i]["DRUGNM"]).trim();

                Matinfo = (result[i]["DRUGNM"]).trim();
            else
                //$('#tblMedicineList tr#' + DurgID + ' td.MaterialName')[0].innerText = (result[i]["DRUGNM"]).trim() + "(" + (result[i]["GENERICNAME"]).trim() + ")";
                Matinfo = (result[i]["DRUGNM"]).trim() + "(" + (result[i]["GENERICNAME"]).trim() + ")";

            if (result[i]["DRUGFORM"].trim() != "" && result[i]["DRUGFORM"].trim() != null) {
                var drugForm = result[i]["DRUGFORM"].trim();

                if (drugForm != "") {
                    druGFrmInitial = drugForm.length > 2 ? drugForm.substr(0, 3).toString().trim() : drugForm.toString().trim();
                } else {
                    druGFrmInitial = "";
                }
                $('#tblMedicineList tr#' + DurgID + ' td.MaterialName')[0].innerHTML = Matinfo + "<span style='float:right;display:none;font-weight:bold;color:crimson;font-size: 11px;'>" + druGFrmInitial + "</span>"

            } else {
                $('#tblMedicineList tr#' + DurgID + ' td.MaterialName')[0].innerText = Matinfo;
            }

            $('#tblMedicineList tr#' + DurgID + ' td.GenriName')[0].innerHTML = result[i]["GENERICNAME"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.GenricID')[0].innerHTML = result[i]["GENERICID"].trim();

            $('#tblMedicineList tr#' + DurgID + ' td.tdIntake')[0].innerHTML = "<div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Intake' value='" + result[i]["INTAKEDESC"].trim() + "' id='intake" + DurgID + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake'></span></div>";//intake 
            // $('#tblMedicineList tr#' + DurgID + ' td.AddNewIntake')[0].innerHTML = "<a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/add.png'  class='intakeImage'></a>";
            $('#tblMedicineList tr#' + DurgID + ' td.durationNum')[0].innerHTML = "<a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DAYS"] + "</a>";
            $('#tblMedicineList tr#' + DurgID + ' td.durationWord')[0].innerHTML = "<a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + DurgID + "' style='display:none;font-size:14px'>" + result[i]["DURATION"] + "</a>";
            $('#tblMedicineList tr#' + DurgID + ' td.tdBeforeAfter')[0].innerHTML = "<a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + DurgID + "' style='display:none;font-size:14px'>" + food + "</a>";

            //kavita 08-aug-2019
            if (result[i]["ROUTE"].toString().trim() != "") {
                var routeText = "Route";
                if ($("div#layer-Route").children('a#' + result[i]["ROUTE"].toString().trim()).length > 0)
                    routeText = $("div#layer-Route").children('a#' + result[i]["ROUTE"].toString().trim()).text();//$("div#layer-Route #" + result[i]["ROUTE"].toString().trim() + "").text();
                $('#tblMedicineList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>" + routeText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["ROUTE"].toString().trim() + "' />";
            }
            else {
                $('#tblMedicineList tr#' + DurgID + ' td.tdRoute')[0].innerHTML = "<a class='triggerRoute' href='javascript:;' data-layer-id='layer-Route' id='Route" + DurgID + "' style='display:none;font-size:14px'>Route</a><input type='hidden' id='hdn" + DurgID + "'  />";
            }


            $('#tblMedicineList tr#' + DurgID + ' td.tdDosses')[0].innerHTML = "<input type='text' class='triggerInputDosses form-control'  style='display:none;' placeholder='Dosage' value='" + result[i]["DOSSAGE"].trim() + "' id='dossage" + DurgID + "' />";


            if (result[i]["Remarks"].toString().trim() != "") {

                var remarkText = "Remark";

                if ($("div#layer-Remark #" + result[i]["Remarks"] + "").length > 0)
                    remarkText = $("div#layer-Remark #" + result[i]["Remarks"] + "").text();

                $('#tblMedicineList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>" + remarkText + "</a><input type='hidden' id='hdn" + DurgID + "' value='" + result[i]["Remarks"] + "' />";
            }
            else {
                $('#tblMedicineList tr#' + DurgID + ' td.tdRemark')[0].innerHTML = "<a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + DurgID + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + DurgID + "'  />";
            }

            $('#tblMedicineList tr#' + DurgID + ' td.tdDrugCode')[0].innerText = (result[i]["DRUGCD"]).trim(); //vijeta 4/5/19

            $('#tblMedicineList tr#' + DurgID + ' td.tdDrugForm')[0].innerHTML = result[i]["DRUGFORM"].trim();

            //added 29/6/19
            $('#tblMedicineList tr#' + DurgID + ' td.setupyn')[0].innerHTML = result[i]["SETUPYN"].trim();
            $('#tblMedicineList tr#' + DurgID + ' td.refillyn')[0].innerHTML = result[i]["REFILLYN"].trim();

            $('#tblMedicineList tr#' + DurgID + ' td.sortTD1')[0].innerHTML = "<a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a>";
            $('#tblMedicineList tr#' + DurgID + ' td.sortTD2')[0].innerHTML = "<a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a>";



            $('#tblMedicineList tr#' + DurgID).trigger('click');
        }
        else if (tamperYn == "Y") {
            DurgID = DurgID.replace(/\//g, '');
            DurgID = DurgID + "_T" + result[i].RESEQ;

            var result1 = {
                MTRLCODE: $.trim(result[i]["DRUGCD"]),
                MTRLNAME: $.trim(result[i].DRUGNM),
                GENERICNAM: $.trim(result[i].GENERICNAME),
                GENERICID: $.trim(result[i].GENERICID),
                INTAKE: result[i]["INTAKEDESC"].trim(),
                DAYS: result[i]["DAYS"],
                DURATION: result[i]["DURATION"],
                FOOD: food,
                DOSSAGE: result[i]["DOSSAGE"].trim(),
                ROUTE: result[i]["ROUTE"].trim(),//kavita 08-aug
                REMARK: result[i]["Remarks"],
                RESEQ: result[i].RESEQ,
                DRUGFORM: result[i]["DRUGFORM"].trim(),
            };

            NonFrqRows = MedicinesRow(result1, true, "Y");

            $('#tblMedicineList tbody').prepend(NonFrqRows).closest('tr');
            $('#tblMedicineList tr#' + DurgID).trigger('click');
        }
        else {

            if ($('#tblMedicineList tr#' + DurgID + "").length == 0 && tamperYn == "N") {
                DurgID = DurgID.replace(/\//g, '');

                var result2 = {
                    MTRLCODE: $.trim(result[i]["DRUGCD"]),
                    MTRLNAME: $.trim(result[i].DRUGNM),
                    GENERICNAM: $.trim(result[i].GENERICNAME),
                    GENERICID: $.trim(result[i].GENERICID),
                    INTAKE: result[i]["INTAKEDESC"].trim(),
                    DAYS: result[i]["DAYS"],
                    DURATION: result[i]["DURATION"],
                    FOOD: food,
                    DOSSAGE: result[i]["DOSSAGE"].trim(),
                    ROUTE: result[i]["ROUTE"],//kavita 08-aug
                    REMARK: result[i]["Remarks"],
                    RESEQ: result[i].RESEQ,
                    SETUPYN: result[i]["SETUPYN"].trim(),
                    DRUGFORM: result[i]["DRUGFORM"].trim(),
                };

                NonFrqRows = MedicinesRow(result2, true);

                $('#tblMedicineList tbody').prepend(NonFrqRows).closest('tr');
                $('#tblMedicineList tr#' + DurgID).trigger('click');
            }

        }

    }

}