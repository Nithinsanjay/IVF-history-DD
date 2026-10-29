var RightMenuLoadType = "";
function openRightMenu(partialViewName, Type, RightType = "") {
    if (RightMenuLoadType == "" || RightMenuLoadType != RightType) {
        RightMenuLoadType = RightType;
        $("#RightMenuFormSlidePopup").empty();
        document.getElementById("popupOverlay").style.display = "block";
        document.getElementById("RightMenuFormSlidePopup").classList.add("active");
        $.ajax({
            url: partialViewName,
            type: 'GET',
            beforeSend: function () {
                $("#RightMenuFormSlidePopup").append("<div id='DivRightMenuload' class='loading-screen'></div>");
                startLoading("Loading", "DivRightMenuload");
            },
            success: function (data) {
                $("#RightMenuFormSlidePopup").html(data);
                if (Type != null && Type != "") {
                    HistoryDetails('T');
                }
            },
            error: function () {
                $("#RightMenuFormSlidePopup").html("<div class='ErrorDiv'><p class='ErrorP'>Error loading content.</p></div>");
            }
        });
    }
    else {
        document.getElementById("popupOverlay").style.display = "block";
        document.getElementById("RightMenuFormSlidePopup").classList.add("active");
    }
}

function closeRightMenu() {
    document.getElementById("RightMenuFormSlidePopup").classList.remove("active");
    //$("#RightMenuFormSlidePopup").empty();
    document.getElementById("popupOverlay").style.display = "none";
}




//function openRightMenu(partialViewName, Type) {
//    $("#RightMenuFormSlidePopup").empty();
//    document.getElementById("popupOverlay").style.display = "block";
//    document.getElementById("RightMenuFormSlidePopup").classList.add("active");
//    $.ajax({
//        url: partialViewName,
//        type: 'GET',
//        beforeSend: function () {
//            $("#RightMenuFormSlidePopup").append("<div id='DivRightMenuload' class='loading-screen'></div>");
//            startLoading("Loading", "DivRightMenuload");
//        },
//        success: function (data) {
//            $("#RightMenuFormSlidePopup").html(data);
//            if (Type != null && Type != "") {
//                HistoryDetails('T');
//            }
//        },
//        error: function () {
//            $("#RightMenuFormSlidePopup").html("<div class='ErrorDiv'><p class='ErrorP'>Error loading content.</p></div>");
//        },
//        complete: function () {
//            //stopLoading("DivRightMenuload");
//        }
//    });
//}

//function closeRightMenu() {
//    document.getElementById("RightMenuFormSlidePopup").classList.remove("active");
//    $("#RightMenuFormSlidePopup").empty();
//    document.getElementById("popupOverlay").style.display = "none";
//}
