var inactivityDuration = (SESSIONTIMEOUT || 60) * 1000;
var warningStartTime = (SESSIONINFOTIME || 30) * 1000;
var serverPingInterval = (PINGSERVERTIME || 15) * 1000;

var lastActivityTime = Date.now();

var sessionCheckerTimer = null;
var serverPingTimer = null;

var hasTimedOut = false;
var popupVisible = false;


var isCheckingUnit = false;
var SkipUnitSession = false;
var ErrorType = "";


var activityEvents = [
    'mousedown',
    'mousemove',
    'keypress',
    'keydown',
    'scroll',
    'touchstart',
    'click',
    'input',
    'change'
];




$(document).ready(function () {
    StartSessionKeepAlive();
    //InitializeSessionTimeout();

});




function InitializeSessionTimeout() {


    activityEvents.forEach(function (eventName) {

        document.addEventListener(
            eventName,
            OnUserActivity,
            true
        );

    });


    StartInactivityChecker();

    StartSessionKeepAlive();

}




function OnUserActivity() {

    if (hasTimedOut)
        return;


    lastActivityTime = Date.now();


    if (popupVisible) {

        closeSessionPopup();

    }

}




function StartInactivityChecker() {

    sessionCheckerTimer = setInterval(function () {

        if (hasTimedOut)
            return;

        var inactiveTime = Date.now() - lastActivityTime;



        if (
            inactiveTime >= warningStartTime &&
            inactiveTime < inactivityDuration
        ) {

            if (!popupVisible) {

                ShowSessionWarningPopup();

            }

            UpdateCountdown();

        }


        if (inactiveTime >= inactivityDuration) {

            HandleSessionTimeout();

        }

    }, 1000);

}




function ShowSessionWarningPopup() {

    $("#sessionPopupBtn").hide();
    popupVisible = true;

    $("#sessionPopupOverlay")
        .css("display", "flex");

    UpdateCountdown();

}



function CloseSessionPopup() {

    popupVisible = false;

    $("#popupAlertOverlay").hide();

    $("#sessionWarningPopup").hide();
}



function UpdateCountdown() {

    var inactiveTime = Date.now() - lastActivityTime;

    var remainingSeconds = Math.ceil(
        (inactivityDuration - inactiveTime) / 1000
    );

    $("#sessionTimer").text(remainingSeconds);

    // LAST 10 SECONDS RED
    if (remainingSeconds <= 10) {

        $("#sessionTimer").css("color", "red");

    }
    else {

        $("#sessionTimer").css("color", "green");

    }

}

function closeSessionPopup() {

    $("#sessionPopupOverlay").hide();

    popupVisible = false;

}



function StartSessionKeepAlive() {

    serverPingTimer = setInterval(function () {

        if (hasTimedOut)
            return;

        PingServerToKeepSessionAlive();

    }, serverPingInterval);

}


function PingServerToKeepSessionAlive() {

    if (hasTimedOut)
        return;

    $.ajax({

        type: 'POST',

        url: '../Account/KeepSessionAlive',

        success: function (data) {

            if (data === "expired") {

                HandleSessionTimeout();

            }

        },

        error: function () {

            console.log("Session ping failed.");

        }

    });

}



function HandleSessionTimeout() {

    if (hasTimedOut)
        return;

    hasTimedOut = true;


    clearInterval(sessionCheckerTimer);

    clearInterval(serverPingTimer);


    activityEvents.forEach(function (eventName) {

        document.removeEventListener(
            eventName,
            OnUserActivity,
            true
        );

    });


    if (typeof clearAllSession === 'function') {

        clearAllSession();

    }
    else {

        sessionStorage.clear();

    }


    $.ajax({

        type: 'POST',

        url: '../Account/ClearServerSession',

        complete: function () {

            $("#sessionPopupMessage").html(
                "Session Timeout. Please Login Again"
            );

            $("#sessionTimer").hide();
            $("#sessionPopupBtn").show();

            $("#sessionPopupBtn")
                .attr("onclick", "RedirectToLogin()");


            $("#sessionPopupOverlay")
                .css("display", "flex");

        }

    });

}




function ShowFinalSessionExpiredPopup() {

    $("#popupAlertOverlay").show();

    $("#sessionWarningPopup").show();

    $(".session-popup-content").html(

        '<h3>Session Expired</h3>' +

        '<p style="margin-top:15px;">' +
        'Session expired. Please login again.' +
        '</p>' +

        '<button ' +
        'style="margin-top:20px;" ' +
        'onclick="RedirectToLogin()">' +
        'OK' +
        '</button>'

    );

}



function RedirectToLogin() {

    window.location.href = '../Account/Login';

}


function ResetSessionTimer() {

    if (hasTimedOut)
        return;

    lastActivityTime = Date.now();

}




$(document).ajaxSend(function (e, jqxhr, settings) {



    if (!isCheckingUnit && !SkipUnitSession) {

        isCheckingUnit = true;

        IsUnitCode(function (isValid) {

            isCheckingUnit = false;

            if (!isValid && !SkipUnitSession) {

                e.stopPropagation();

                if (ErrorType == "USER") {

                    openPopup(
                        "Information",
                        "Already Login in another Device. Please Login Again",
                        "Signout()",
                        ""
                    );

                }
                else {

                    openPopup(
                        "Information",
                        "Session Timeout. Please Login Again",
                        "Signout()",
                        ""
                    );

                }

                jqxhr.abort();

            }

        });

    }

});



function IsUnitCode(callback) {

    $.ajax({

        type: 'POST',

        url: '../Account/GetDoctCode',

        success: function (data) {

            if (data == "success") {

                callback(true);

            }
            else {

                ErrorType = data;

                callback(false);

            }

        },

        error: function () {

            callback(false);

        }

    });

}



function ForceSessionTimeout() {

    HandleSessionTimeout();

}

function KeepSessionAliveNow() {

    PingServerToKeepSessionAlive();

}