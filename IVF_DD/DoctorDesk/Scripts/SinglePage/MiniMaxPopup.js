function openMaxMinPopup(id) {
    document.getElementById(id).style.display = "flex";
    document.getElementById("popupOverlay").style.display = "block";
}

function closeMaxMinPopup(id) {
    document.getElementById(id).style.display = "none";
    var selector = ".minimized-bar[data-popup='" + id + "']";
    var bar = document.querySelector(selector);
    if (bar) {
        bar.remove();
    }
    document.getElementById(id).remove();
    var barList = document.querySelector('.minimized-bar');
    if (!barList) {
        document.getElementById("minimizedContainer").style.display = "none";
    }
    document.getElementById("popupOverlay").style.display = "none";
}

function minimizePopup(id) {
    document.getElementById("popupOverlay").style.display = "none";
    document.getElementById("minimizedContainer").style.display = "flex";
    var popup = document.getElementById(id);
    popup.style.display = "none";
    var selector = ".minimized-bar[data-popup='" + id + "']";
    if (!document.querySelector(selector)) {
        var bar = document.createElement("div");
        bar.className = "minimized-bar";
        bar.setAttribute("data-popup", id);
        var title = popup.querySelector(".MaxMinpopup-header h5").innerText;
        var h5 = document.createElement("h5");
        h5.innerText = title;
        bar.appendChild(h5);
        var maxBtn = document.createElement("button");
        maxBtn.className = "btn btn-sm btn-light";
        maxBtn.innerText = "⬜";
        maxBtn.onclick = function () {
            restorePopup(id);
            bar.remove();
        };
        bar.appendChild(maxBtn);
        var closeBtn = document.createElement("button");
        closeBtn.className = "btn btn-sm btn-danger";
        closeBtn.innerText = "✕";
        closeBtn.onclick = function () {
            closeMaxMinPopup(id);
            bar.remove();
        };
        bar.appendChild(closeBtn);
        var minimizedContainer = document.getElementById("minimizedContainer");
        minimizedContainer.appendChild(bar);
    }
}

function restorePopup(id) {
    document.getElementById("popupOverlay").style.display = "block";
    var popup = document.getElementById(id);
    popup.style.display = "flex";
    popup.classList.remove("maximized");
}

function maximizePopup(id) {
    document.getElementById("popupOverlay").style.display = "block";
    var popup = document.getElementById(id);
    popup.classList.toggle("maximized");
}
