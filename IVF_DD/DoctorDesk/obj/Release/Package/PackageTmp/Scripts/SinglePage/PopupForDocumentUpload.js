//Open Popup
//function openCenterPopup(partialViewName, title = "Upload Document") {

//    $("#CustomCenterPopup").remove();
//    $("#CustomOverlay").remove();

//    // Overlay
//    $("body").append("<div id='CustomOverlay' class='custom-overlay'></div>");

//    // Popup HTML
//    var popup = `
//        <div id="CustomCenterPopup" class="custom-popup">

//            <div class="custom-popup-header">
//                <span>${title}</span>
//                <button class="custom-close-btn" onclick="closeCenterPopup()">✕</button>
//            </div>

//            <div id="CustomPopupBody" class="custom-popup-body">
//                <div id="centerLoader"></div>
//            </div>

//        </div>
//    `;

//    $("body").append(popup);

//    $.ajax({
//        url: partialViewName,
//        type: "GET",
//        beforeSend: function () {
//            startLoading("Loading", "centerLoader");
//        },
//        success: function (data) {
//            $("#CustomPopupBody").html(data);
//        },
//        error: function () {
//            $("#CustomPopupBody").html("<div>Error loading content</div>");
//        }
//    });

//    $("#CustomOverlay").click(function () {
//        closeCenterPopup();
//    });
//}
//function closeCenterPopup() {
//    $("#CustomCenterPopup").remove();
//    $("#CustomOverlay").remove();
//}

function OpenCenterPopup(HeaderNM, Section, partialViewName, MaxFlag) {
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
    var Content = ContentForCenterPopup(ContentID, partialViewName);
    MiniBtn = "";
    MaxBtn = "";
    var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", (HeaderLbl + MiniBtn + MaxBtn + CloseBtn));
    var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", (Content));
    var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", (RplHeaderDiv + RplContentDiv));
    $("body").append(RplMinDiv);
    openMaxMinPopup(MainDivID);
    stopLoading();
}

function ContentForCenterPopup(ContentID, partialViewName) {
    // Start with loader
    var html = "<div id='loader_" + ContentID + "'></div>";

    // Load partial view via AJAX
    $.ajax({
        url: partialViewName,
        type: "GET",
        beforeSend: function () {
            startLoading("Loading", "loader_" + ContentID);
        },
        success: function (data) {
            $("#" + ContentID).html(data);
        },
        error: function () {
            $("#" + ContentID).html("<div>Error loading content</div>");
        },
        complete: function () {
            stopLoading();
        }
    });

    return html;
}



//function closeMaxMinPopup(MainDivID) {
//    $("#" + MainDivID).remove();
//}

function ConvertTo12Hour(SType, FTime) {
    var FormatedTime = FTime;
    if (SType === "O") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    else if (SType === "P") {

    }
    else if (SType === "S") {
    }
    else if (SType === "C") {

    }
    else if (SType === "R") {

    }
    else if (SType === "N") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    else if (SType === "D") {
        var parts = FTime.split(":");
        var hour = parseInt(parts[0], 10);
        var minute = parts[1];
        var ampm = hour >= 12 ? "PM" : "AM";
        hour = hour % 12 || 12;
        var hourStr = hour.toString().padStart(2, "0");
        var minuteStr = minute.toString().padStart(2, "0");
        FormatedTime = hourStr + ":" + minuteStr + " " + ampm;
    }
    return FormatedTime;
}
function hasHistoryData(content) {
    if (!content) return false;

    // Remove whitespace and check if it's just an empty container
    var cleanContent = content.trim();
    var emptyWrapper = '<div class="history-list-wrapper"></div>';

    if (cleanContent === "" || cleanContent === emptyWrapper) {
        return false;
    }

    return true;
}