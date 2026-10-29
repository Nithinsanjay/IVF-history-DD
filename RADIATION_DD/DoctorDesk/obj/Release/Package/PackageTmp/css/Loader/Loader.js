function startLoading(MsgText, LoadContainer) {
    var MainDiv = "<div class='loader'><span></span><span></span><span></span><span></span></div>" + "<h2 class='loading-text' id='LblLoadingText'>" + MsgText + "</h2>";
    if (LoadContainer == undefined || LoadContainer == null || LoadContainer == "") {
        $("#Div-loading-screen").empty();
        $("#Div-loading-screen").append(MainDiv);
        const loadingScreen = document.getElementById("Div-loading-screen");
        if (loadingScreen) {
            const parentDiv = loadingScreen.parentElement;
            parentDiv.style.position = "relative";
            loadingScreen.style.display = "flex";
            loadingScreen.style.opacity = "1";
        }
    }
    else {
        $("#" + LoadContainer).empty();
        $("#" + LoadContainer).append(MainDiv);
        const loadingScreen = document.getElementById(LoadContainer);
        if (loadingScreen) {
            const parentDiv = loadingScreen.parentElement;
            parentDiv.style.position = "relative";
            loadingScreen.style.display = "flex";
            loadingScreen.style.opacity = "1";
        }
    }
}

function stopLoading(LoadContainer) {
    if (LoadContainer == undefined || LoadContainer == null || LoadContainer == "") {
        const loadingScreen = document.getElementById("Div-loading-screen");
        if (loadingScreen) {
            loadingScreen.style.opacity = "0";
            const parentDiv = loadingScreen.parentElement;
            parentDiv.style.position = "";
            setTimeout(function () {
                loadingScreen.style.display = "none";
                $("#Div-loading-screen").empty();
            }, 500);
        }
    }
    else {
        const loadingScreen = document.getElementById(LoadContainer);
        if (loadingScreen) {
            loadingScreen.style.opacity = "0";
            const parentDiv = loadingScreen.parentElement;
            parentDiv.style.position = "";
            setTimeout(function () {
                loadingScreen.style.display = "none";
                $("#" + LoadContainer).empty();
            }, 500);
        }
    }
}