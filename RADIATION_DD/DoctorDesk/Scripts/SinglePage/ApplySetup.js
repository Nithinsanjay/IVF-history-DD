function OpenMasterApplySetup(HeaderNM, Section, MaxFlag) {
    startLoading("Loading");
    var MainDivID = "Hist_M_" + Section;
    var HeaderDivID = "Hist_H_" + Section;
    var MiniBtnID = "Hist_H_Min_" + Section;
    var MaxBtnID = "Hist_H_Max_" + Section;
    var CloseBtnID = "Hist_H_Close_" + Section;
    var ContentID = "Hist_C_" + Section;
    var MinDiv = "<div class='MaxMinpopup " + (MaxFlag == true ? 'maximized' : '') + "' id='" + MainDivID + "' style='display:none;'>{ALLPOPMAINCONTENT}</div>";
    var HeaderDiv = "<div class='MaxMinpopup-header' id='" + HeaderDivID + "'>{ALLPOPHEAD}</div>";
    var HeaderLbl = "<h5>" + HeaderNM + "</h5>";
    var MiniBtn = "<button id='" + MiniBtnID + "' class='btn btn-sm btn-light' onclick=\"minimizePopup('" + MainDivID + "')\" >—</button>";
    var MaxBtn = "<button id='" + MaxBtnID + "' class='btn btn-sm btn-light' onclick=\"maximizePopup('" + MainDivID + "')\" >⬜</button>";
    var CloseBtn = "<button id='" + CloseBtnID + "' class='btn btn-sm btn-danger' onclick=\"closeMaxMinPopup('" + MainDivID + "')\" >✕</button>";
    var ContentDiv = "<div class='MaxMinpopup-body' id='" + ContentID + "'>{ALLPOPCONTENT}</div>";
    var ApplySetupTabId = ("MasterApply_" + Section);
    var Content = ContentForMasterApplySetup(ApplySetupTabId);
    MiniBtn = "";
    MaxBtn = "";
    var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", (HeaderLbl + MiniBtn + MaxBtn + CloseBtn));
    var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", (Content));
    var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", (RplHeaderDiv + RplContentDiv));
    $("body").append(RplMinDiv);
    openMaxMinPopup(MainDivID);
    CreateTabulatorForApplySetupTable(ApplySetupTabId);
    stopLoading();
}
function ContentForMasterApplySetup(TableContentID) {
    var html = '<div id="' + TableContentID + '"></div>';
    html += '<button type="button" id="btnSave" onclick="SaveMasterApplySetupList(' + TableContentID + ')" class="btn btn-primary">Save</button>';
    return html;
}

function CreateTabulatorForApplySetupTable(ApplySetupTabId) {
    var ApplySetupTabultor = new Tabulator(("#" + ApplySetupTabId), {
        layout: "fitColumns",
        autoResize: true,
        cellVertAlign: "top",
        resizableColumns: true,
        height: "350",
        index: "code",
        columns: [
            {
                title: "",
                field: "CHECKYN",
                formatter: "tickCross",
                editor: true,
                hozAlign: "center",
                width: 100
            },
            { title: "Code", field: "code", visible: false },
            {
                title: "Name",
                field: "name",
                editor: false,
                formatter: "textarea",
                formatterParams: {
                    minHeight: "auto",
                },
                cssClass: "wrap-text"
            },
            {
                title: "Gender",
                field: "GENDER",
                editor: false,
                formatter: "textarea",
                formatterParams: {
                    minHeight: "auto",
                },
                cssClass: "wrap-text"
            },
            {
                title: "Age",
                field: "FROMTOAGE",
                editor: false,
                formatter: "textarea",
                formatterParams: {
                    minHeight: "auto",
                },
                cssClass: "wrap-text"
            }
        ]
    });
    ApplySetupTabultor.on("tableBuilt", function () {
        BindMasterApplySetupList(ApplySetupTabId);
    });
}

function BindMasterApplySetupList(ApplySetupTabId) {
    var Applytable = Tabulator.findTable("#" + ApplySetupTabId)[0];
    var GenCode = "";
    var AgeFormat = "";
    if (sessionStorage.getItem('PatAge').toUpperCase().includes("YEAR")) {
        var SplitAge = sessionStorage.getItem('PatAge').split(' ')
        AgeFormat = SplitAge[0] + ":00:00";
    }
    else if (sessionStorage.getItem('PatAge').toUpperCase().includes("MONTH")) {
        var SplitAge = sessionStorage.getItem('PatAge').split(' ')
        AgeFormat = "00:" + SplitAge[0] + ":00";
    }
    else if (sessionStorage.getItem('PatAge').toUpperCase().includes("DAY")) {
        var SplitAge = sessionStorage.getItem('PatAge').split(' ')
        AgeFormat = "00:00:" + SplitAge[0]
    }
    if (sessionStorage.getItem('PatGender') === "Female") {
        GenCode = "F";
    }
    else if (sessionStorage.getItem('PatGender') === "Male") {
        GenCode = "M";
    }
    else if (sessionStorage.getItem('PatGender') === "Other") {
        GenCode = "O";
    }
    $.ajax({
        type: "POST",
        url: "../Clinicalnotes/GetMasterSetUpList",
        data: { strAge: AgeFormat, strCimsYN: 'N', strGender: GenCode },
        asycn: true,
        success: function (response) {
            if (response != "" && response.toUpperCase() != "UNSUCCESSFULL") {
                var result = JSON.parse(response)
                var rows = "";
                for (i = 0; i < result.Table1.length; i++) {
                    if (result.Table1[i].STATUS != "I")
                    {
                        Applytable.addRow({
                            CHECKYN: false,
                            code: $.trim(result.Table1[i].CODE),
                            name: $.trim(result.Table1[i].NAME),
                            GENDER: $.trim(result.Table1[i].GENDER) == "M" ? "Male" : ($.trim(result.Table1[i].GENDER) == "M" ? "Female" : "Both"),
                            FROMTOAGE: $.trim(result.Table1[i].FROMAGE) + " - " + $.trim(result.Table1[i].TOAGE),
                        }).then(function (row) {
                            row.normalizeHeight();
                            adjustTableHeight(ApplySetupTabId);
                        });
                    }
                }
            }
        }
    });
}

//function ValidationForApplySetupList() {
//    var Applytable = Tabulator.findTable("#ApplySetupTable")[0];
//    if (Applytable.getData().filter(function (row) { return row.CHECKYN === true; }).length == 0) {
//        ToastMsg("Select Atleast One Apply Setup.", "warning");
//        return false;
//    }
//    return true;
//}

//function SaveMasterApplySetupList() {
//    if (ValidationForApplySetupList() = true) {
//        var Mrno = sessionStorage.getItem('PatMRNO');
//        var strTran = sessionStorage.getItem('PatTRANNO');
//        var strPatName = sessionStorage.getItem('PatName');
//        var strPatAge = sessionStorage.getItem('PatAge');
//        var strPatGender = sessionStorage.getItem('PatGender');
//        var strPatMobile = sessionStorage.getItem('OPDPatMobile');
//        var Applytable = Tabulator.findTable("#ApplySetupTable")[0];
//        var strSetUpCd = Applytable.getData()
//            .filter(function (row) {
//                return row.CHECKYN === true;
//            })
//            .map(function (row) {
//                return row.code;
//            })
//            .join(",");
//        $.ajax({
//            url: '../DoctorDesk/SavePerMasterSetUp',
//            data: { strTran: strTran, strMrNo: Mrno, strSetUpCd: strSetUpCd, strPatName: strPatName, strPatAge: strPatAge, strPatGender: strPatGender, strPatMobile: strPatMobile },
//            datatype: 'json',
//            type: 'post',
//            success: function (response) {
//                if (response.toUpperCase().indexOf("SUCCESSFUL") != -1) {
//                    ToastMsg("Set Up applied successfully", "success");
//                    window.location.reload();
//                }
//                else {
//                    ToastMsg("Set Up applied successfully", "error");
//                }
//            }
//        });
//    }
//}

function ValidationForApplySetupList(ApplySetupTabId) {
    var Applytable = Tabulator.findTable("#" + ApplySetupTabId)[0];
    if (Applytable.getData().filter(function (row) { return row.CHECKYN === true; }).length == 0) {
        ToastMsg("Select Atleast One Apply Setup.", "warning");
        return false;
    }
    return true;
}

function SaveMasterApplySetupList(ApplySetupTabId) {
    if (ValidationForApplySetupList(ApplySetupTabId.id) == true) {
        var Mrno = sessionStorage.getItem('PatMRNO');
        var strTran = sessionStorage.getItem('PatTRANNO');
        var strPatName = sessionStorage.getItem('PatName');
        var strPatAge = sessionStorage.getItem('PatAge');
        var strPatGender = sessionStorage.getItem('PatGender');
        var strPatMobile = sessionStorage.getItem('OPDPatMobile');
        var Applytable = Tabulator.findTable("#" + ApplySetupTabId.id)[0];
        var strSetUpCd = Applytable.getData()
            .filter(function (row) {
                return row.CHECKYN === true;
            })
            .map(function (row) {
                return row.code;
            })
            .join(",");
        $.ajax({
            url: '../DoctorDesk/SavePerMasterSetUp',
            data: { strTran: strTran, strMrNo: Mrno, strSetUpCd: strSetUpCd, strPatName: strPatName, strPatAge: strPatAge, strPatGender: strPatGender, strPatMobile: strPatMobile },
            datatype: 'json',
            type: 'post',
            success: function (response) {
                if (response.toUpperCase().indexOf("SUCCESSFUL") != -1) {
                    ToastMsg("Set Up applied successfully", "success");
                    window.location.reload();
                }
                else {
                    ToastMsg("Set Up applied successfully", "error");
                }
            }
        });
    }
}