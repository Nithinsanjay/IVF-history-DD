var CIMS_blinkIds = {
    TrmtntOrderMedicineTable: ['btnInformantMedicine', 'btnDuplicateMedicine', 'btnAllergyMedicine'],
    ChemoListtable: ['btnInformantChemo', 'btnDuplicateChemo', 'btnAllergyChemo'],
    RxListtable: ['btnInformantRx', 'btnDuplicateRx', 'btnAllergyRx'],
    ChemoPlanningTable: ['btnInformantChemoPlaning', 'btnDuplicateChemoPlaning', 'btnAllergyChemoPlaning'],
    TrmtntOrderMedicationTable: ['btnInformantMedication', 'btnDuplicateMedication', 'btnAllergyMedication']
}

$(document).ready(function () {
    // Initialize dialog
    //$('#divCIMSInfo').dialog({
    //    autoOpen: false,
    //    modal: true,
    //    width: '99vw',
    //    resizable: false,
    //    title: "",
    //    draggable: false,
    //    open: function () {
    //        $("body > *:not(.ui-dialog)").addClass("blurred");
    //        $("body").css("overflow", "hidden");
    //        $('#divCIMSInfo').css('height', '90% !important');
    //    },
    //    close: function () {
    //        $("body > *").removeClass("blurred");
    //        $("body").css("overflow", "");
    //    }
    //});

    //$('#divCIMSInfo').dialog({
    //    autoOpen: false,
    //    modal: true,
    //    width: '85vw',
    //    height: 600,
    //    resizable: false,
    //    title: "",
    //    draggable: false,
    //    position: {
    //        my: "center top",   // align dialog's top center
    //        at: "center top+60", // push 80px down from top
    //        of: window
    //    },
    //    open: function () {
    //        $("body > *:not(.ui-dialog)").addClass("blurred");
    //        $("body").css("overflow", "hidden");
    //    },
    //    close: function () {
    //        $("body > *").removeClass("blurred");
    //        $("body").css("overflow", "");
    //    }
    //});

    $('#divCIMSInfo').dialog({
        autoOpen: false,
        modal: true,
        width: '85vw',
        height: 600,
        resizable: false,
        title: "",
        draggable: false,
        open: function () {
            $("body > *:not(.ui-dialog)").addClass("blurred");
            $("body").css("overflow", "hidden");
        },
        close: function () {
            $("body > *").removeClass("blurred");
            $("body").css("overflow", "");
        }
    });

    $('#CIMSBody').on('click', 'a[href^="#"]', function (e) {
        e.preventDefault();
        const targetId = $(this).attr('href').substring(1);
        const $target = $('#CIMSBody').find('#' + targetId);

        if ($target.length) {
            const scrollTop = $target.position().top + $('#CIMSBody').scrollTop();
            $('#CIMSBody').animate({ scrollTop: scrollTop }, 300);
        }
    });
});

function getDrugInfo(mtrlCode) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '../DoctorDesk/GetDrugInformation',
            cache: false,
            data: { DrugCode: mtrlCode },
            success: function (response) {
                $('#CIMSBody').empty();
                if (response && response == "0") {
                    ToastMsg('Kindly Contact IT', 'info');
                    resolve(true);
                } else {
                    if (typeof response == 'object') {
                        if (response.HtmlText) {
                            // Append the HTML to #
                            var iframe = createResponsiveIframe(response.HtmlText);
                            $('#CIMSBody').html(iframe);
                            $('.CIMS-header-child').text("Drug Information");
                            $('#divCIMSInfo').dialog('open');
                        } else {
                            ToastMsg(response.Status, "info");
                        }
                    }
                    resolve(response);
                }
            },
            error: function (xhr, status, error) {
                reject(true);
            },
            complete: function () {
                //    ajaxindicatorstop();
            }
        });
    });
}
// Function to show/hide buttons based on Tabulator row count
function toogleButtons(Table, Tablename) {
    if (IS_DISPLAY_CIMS_FUNCTIONLITY && IS_DISPLAY_CIMS_FUNCTIONLITY != 'Y') return false; // CIMS != 'Y' THEN DON'T DO ANYTHING 
    var rowCount = 0;
    var alldata = Table.getData();
    for (var i = 0; i < Table.getDataCount(); i++) {
        //var rowData = alldata[i];
        //if (rowData.DrugCode) {
        rowCount++;
        /*}*/
    }
    if (rowCount >= 2) {
        $('#' + CIMS_blinkIds[Tablename][0] + ',' + '#' + CIMS_blinkIds[Tablename][1]).show();  // + ',' + '#' + CIMS_blinkIds[Tablename][2]
        subscribeCIMSServices("", Table, Tablename);
    } else {
        $('#' + CIMS_blinkIds[Tablename][0] + ',' + '#' + CIMS_blinkIds[Tablename][1]).hide(); // + ',' + '#' + CIMS_blinkIds[Tablename][2]
    }
}
function subscribeCIMSServices(type, Table, TableName) {
    if (type == "I") {
        GetDrugInterationService(Table).then(function (response) {
            $('#CIMSBody').empty();
            if (response && response == "0") {
                ToastMsg('Kindly Contact IT', 'info');
            } else {
                if (typeof response == 'object') {
                    if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                        // Append the HTML to #CIMSBody
                        try {
                            var iframe = createResponsiveIframe(response.HtmlText);
                            $('#CIMSBody').empty().append(iframe);
                            $('.CIMS-header-child').text("Drug Interaction");
                            $('#divCIMSInfo').dialog('open');
                        } catch (err) {
                            $('#divCIMSInfo').dialog('close');
                        }

                    } else {
                        ToastMsg(response.Status, 'info');
                    }
                }
            }
        }).catch(function (error) {
            ToastMsg('Kindly Contact IT');
        });

    } else if (type == "D") {
        GetDrugDuplicateService(Table).then(function (response) {
            $('#CIMSBody').empty();
            if (response && response == "0") {
                ToastMsg('Kindly Contact IT');
            } else {
                if (typeof response == 'object') {
                    if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                        // Append the HTML to #CIMSBody
                        try {
                            var iframe = createResponsiveIframe(response.HtmlText);
                            $('#CIMSBody').html(iframe);
                            $('.CIMS-header-child').text("Drug Duplicate");
                            $('#divCIMSInfo').dialog('open');
                        }
                        catch (err) {
                            $('#divCIMSInfo').dialog('close');
                        }

                    } else {
                        ToastMsg(response.Status);
                    }
                }
            }
        }).catch(function (error) {
            ToastMsg('Kindly Contact IT');
        });

    }
    else if (type == 'A') {

        GetDrugAllergyService(Table).then(function (response) {
            $('#CIMSBody').empty();
            if (response && response == "0") {
                ToastMsg('Kindly Contact IT');
            } else {
                if (typeof response == 'object') {
                    if (response.Status && response.Status.toUpperCase() == "SUCCESS") {
                        // Append the HTML to #CIMSBody
                        try {
                            var iframe = createResponsiveIframe(response.HtmlText);
                            $('#CIMSBody').html(iframe);
                            $('.CIMS-header-child').text("Drug Allergy");
                            $('#divCIMSInfo').dialog('open');
                        }
                        catch (err) {
                            $('#divCIMSInfo').dialog('close');
                        }

                    } else {
                        ToastMsg(response.Status);
                    }
                }
            }

        }).catch(function (error) {
            ToastMsg('Kindly Contact IT');
        });
    }
    else {
        let informantId = CIMS_blinkIds[TableName][0];
        let dublicateId = CIMS_blinkIds[TableName][1];
        let allergyId = CIMS_blinkIds[TableName][2];
        if (isCimsBlinkingEnabled(TableName)) {

            GetDrugInterationService(Table).then(function (response) {
                $('#CIMSBody').empty();
                if (response && response == "0") {

                }
                else {
                    if (typeof response == 'object') {
                        if (response.AlertYN == true) {
                            // Pass response.color
                            onBlinkColorModifications(informantId, response.ColorName, true);
                        } else {
                            onBlinkColorModifications(informantId, '', false);
                        }
                    }
                }
            }).catch(function (error) {
                ToastMsg('Kindly Contact IT');
            });

            GetDrugDuplicateService(Table).then(function (response) {
                $('#CIMSBody').empty();
                if (response && response == "0") {
                    // ignore
                } else {
                    if (typeof response == 'object') {
                        if (response.AlertYN == true) {
                            onBlinkColorModifications(dublicateId, response.ColorName, true);
                            //Blink("#" + dublicateId);
                            //response.colorName = 'red'; // Here From Service It Will Come | 
                            //$('#' + dublicateId).css({ 'background': response.colorName, 'border-radius': '5px' });
                        } else {
                            onBlinkColorModifications(dublicateId, '', false);
                            //stopBlink("#" + dublicateId);
                            //$('#' + dublicateId).css('background', '');
                        }
                    }
                }
            }).catch(function (error) {
                ToastMsg('Kindly Contact IT');
            });

            // Added by Dhananjay 20260223 | Allergy Service 
            GetDrugAllergyService(Table).then(function (response) {
                $('#CIMSBody').empty();
                if (response && response == "0") {

                } else {
                    if (typeof response == 'object') {
                        if (response.AlertYN == true) {
                            onBlinkColorModifications(allergyId, response.ColorName, true);
                        }
                        else {
                            onBlinkColorModifications(allergyId, '', false);
                        }
                    }
                }
            });
        }
    }
}

function GetDrugInterationService(gridId) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '../DoctorDesk/GetDrugInteration',
            data: preapreDataForCIMS(gridId),
            cache: false,
            success: function (response) {
                resolve(response);
            },
            error: function (xhr, status, error) {
                reject(true);
            },
            complete: function () {
            }
        });
    });
}

function GetDrugDuplicateService(gridId) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '../DoctorDesk/GetDrugDuplicate',
            data: preapreDataForCIMS(gridId),
            cache: false,
            success: function (response) {
                resolve(response);
            },
            error: function (xhr, status, error) {
                reject(true);
            },
            complete: function () {
            }
        });
    });
}

function GetDrugAllergyService(gridId) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../DoctorDesk/GetDrugAllergy',
            data: preapreDataForCIMS(gridId),
            cache: false,
            success: function (response) {
                resolve(response);
            },
            error: function (xhr, status, error) {
                reject(true);
            },
            complete: function () {

            }
        });
    });
}
function Blink(selector) {
    $(selector).addClass('CIMS-blinking').show(); // show and add blink effect
}

// Stop blink
function stopBlink(selector) {
    $(selector).removeClass('CIMS-blinking').css("opacity", "1"); // remove animation
}

function createResponsiveIframe(htmlText, height = "600px") {

    var iframe = document.createElement("iframe");
    iframe.style.width = "100%";
    iframe.style.height = '72vh';
    iframe.style.border = "none";
    iframe.style.display = "block"; // avoids gaps

    iframe.onload = function () {
        try {
            var doc = iframe.contentWindow.document;
            doc.open();
            doc.write(htmlText);
            doc.close();
        } catch (e) {
            console.error(e);
        }
    };

    iframe.src = "about:blank";

    return iframe;
}

function isCimsBlinkingEnabled(cims_current_tablename) {

    if (typeof CIMS_BLINKING_ENABLE_FORMS === 'undefined' || !CIMS_BLINKING_ENABLE_FORMS || !cims_current_tablename) {
        return false;
    }

    const rawValue = (CIMS_BLINKING_ENABLE_FORMS || '');
    const formList = rawValue
        .split(',')
        .map(f => f.trim())
        .filter(f => f);
    return formList.includes(cims_current_tablename);
}

// Added by Dhananjay 20260410 | 
function onBlinkColorModifications(id, colorName, isAlert) {
    var $btn = $("#" + id);

    if (!colorName || colorName.trim() === "") {
        colorName = "gray";
    };

    if (isAlert) {
        Blink("#" + id);
    } else {
        stopBlink("#" + id);
    }

    // Change SVG colors
    $btn.find("rect").attr("fill", colorName);   // background square
    $btn.find("path").attr("stroke", "#ffffff"); // keep icon white (or change if needed)
}


