function openPopup(Header, Message, YesFunc, NoFunc) {
    $("#popupAlertOverlay").empty();
    var AlertPopupTemp = '<div class="popup-box">' +
      '<h2 class="popup-title">' + Header + '</h2>' +
      '<p class="popup-message">' + Message + '</p>' +
      '<div class="popup-actions">' +
      '<button class="btn btn-yes" onclick="' + YesFunc + ';">' + (NoFunc == "" ? "Ok" : "Yes") + '</button>' +
        (NoFunc == "" ? '' : '<button class="btn btn-no" onclick="' + NoFunc + ';">No</button>') +
      '</div>' +
    '</div>';
    $("#popupAlertOverlay").append(AlertPopupTemp);
    document.getElementById("popupAlertOverlay").style.display = "flex";
}

function closePopup() {
    document.getElementById("popupAlertOverlay").style.display = "none";
    $("#popupAlertOverlay").empty();
}

function NoDataFound(Message, MessageDiv, DivMainClass, DivContClass) {
    var AlertPopupTemp = '<div class="' + (DivMainClass == undefined || DivMainClass == null || DivMainClass == "" ? "NoDataFound" : DivMainClass) + '"><h2 class="' + (DivContClass == undefined || DivContClass == null || DivContClass == "" ? "NoDataFoundh2" : DivContClass) + '">' + Message + '</h2></div>';
    $("#" + MessageDiv).append(AlertPopupTemp);
}

function openPopupDynamic(Header, Message, Buttons = []) {
    // Generate unique IDs
    const overlayId = 'overlay_' + Date.now() + '_' + Math.floor(Math.random() * 1000);
    const popupId = 'popup_' + Date.now() + '_' + Math.floor(Math.random() * 1000);

    // Create overlay
    const overlay = document.createElement('div');
    overlay.id = overlayId;
    overlay.className = 'popup-overlay';
    overlay.style.cssText = `
        position: fixed;
    top:0; left:0; right:0; bottom:0;
    background: rgba(0,0,0,0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 10000;
    `;

    // Create popup box
    const popup = document.createElement('div');
    popup.id = popupId;
    popup.className = 'popup-box';
    popup.style.position = 'relative'; // required for X icon

    // Add X icon for closing
    const closeX = document.createElement('span');
    closeX.innerHTML = '&times;'; // × character
    closeX.style.cssText = `
        position: absolute;
    top:  0px;
    right: 10px;
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
    color:white;
    `;
    closeX.onclick = () => document.body.removeChild(overlay);

    popup.appendChild(closeX);

    // Add header and message
    const headerEl = document.createElement('h2');
    headerEl.className = 'popup-title';
    headerEl.innerText = Header;

    const messageEl = document.createElement('div');
    messageEl.className = 'popup-message';
    messageEl.innerHTML  = Message;

    popup.appendChild(headerEl);
    popup.appendChild(messageEl);

    // Add buttons if provided
    if (Buttons.length > 0) {
        const buttonsContainer = document.createElement('div');
        buttonsContainer.className = 'popup-actions';

        Buttons.forEach(btn => {
            const button = document.createElement('button');
        button.className = btn.class || 'btn btn-yes';
        button.innerText = btn.text;
        button.onclick = () => {
            if (typeof btn.action === "function") {
                btn.action();
            } else if (typeof btn.action === "string" && btn.action) {
                new Function(btn.action)();
            }
        document.body.removeChild(overlay); // close popup
    };
    buttonsContainer.appendChild(button);
});

    popup.appendChild(buttonsContainer);
}

// Append popup to overlay, overlay to body
overlay.appendChild(popup);
document.body.appendChild(overlay);
}


