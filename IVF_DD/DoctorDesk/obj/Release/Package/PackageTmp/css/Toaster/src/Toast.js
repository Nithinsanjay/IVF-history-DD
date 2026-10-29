function ToastMsg(Message, Type) {
    var Options = { duration: 5000 };
    var toast = new Toast(Message, Type, Options);
    document.getElementById("ToasterContainer").style.display = "block";
    document.getElementById("ToasterContainer").appendChild(toast.toastElement);
    toast.show();
}


function Toast(content, type, options) {
    type = type || "default";
    options = options || {};

    this.id = options.id || this.generateId();
    this.content = content;
    this.type = type;
    this.allowHtml = options.allowHtml || false;
    this.autoClose =
      options.autoClose === false
        ? false
        : this.type === "loading"
        ? false
        : true;
    this.duration = options.duration || 5000;
    this.dismissTimeout = null;
    this.onClose = options.onClose || null;

    this.createToastElement(this.content, this.type, this.duration);
    this.setCustomStyles(options.styles);
}

Toast.prototype.createToastElement = function (content, type, duration) {
    this.toastElement = document.createElement("div");
    this.toastElement.className = "toaster-ui-lib toaster-ui-lib-" + type;
    this.toastElement.style.setProperty("--timer", duration + "ms");
    this.toastElement.style.setProperty(
      "--display",
      this.autoClose ? "block" : "none"
    );

    if (this.type === "loading") {
        var loadingElement = document.createElement("div");
        loadingElement.className = "toaster-ui-lib-loader";
        this.toastElement.appendChild(loadingElement);
    }

    var textElement = document.createElement("span");
    textElement.className = "toaster-ui-lib-text";
    if (this.allowHtml) {
        textElement.innerHTML = "<span>" + content + "</span>";
    } else {
        textElement.innerText = content;
    }
    this.toastElement.appendChild(textElement);

    var closeButton = document.createElement("span");
    closeButton.className = "toaster-ui-lib-close";
    closeButton.innerHTML = "&times;";
    var self = this;
    closeButton.addEventListener("click", function () {
        self.close();
    });
    this.toastElement.appendChild(closeButton);
};

Toast.prototype.generateId = function () {
    return (
      Date.now().toString(36) +
      Math.random().toString(36).substr(2, 5)
    );
};

Toast.prototype.update = function (content, type, options, existingToastElement) {
    options = options || {};
    this.content = content;
    this.type = type || existingToastElement.type;
    this.allowHtml = options.allowHtml || existingToastElement.allowHtml;
    this.autoClose =
      options.autoClose !== undefined
        ? options.autoClose !== false
        : existingToastElement.type === "loading"
        ? true
        : existingToastElement.autoClose;
    this.onClose = options.onClose || existingToastElement.onClose;
    this.duration = options.duration || existingToastElement.duration;
    this.setCustomStyles(options.styles || existingToastElement.styles);

    if (this.toastElement) {
        this.toastElement.className =
          "toaster-ui-lib toaster-ui-lib-" + this.type;
        this.toastElement.style.setProperty("--timer", this.duration + "ms");
        this.toastElement.style.setProperty(
          "--display",
          this.autoClose ? "block" : "none"
        );
    }
    this.toastElement.innerHTML = "";

    if (this.type === "loading") {
        var loadingElement = document.createElement("div");
        loadingElement.className = "toaster-ui-lib-loader";
        this.toastElement.appendChild(loadingElement);
    }

    var textElement = document.createElement("span");
    textElement.className = "toaster-ui-lib-text";
    if (this.allowHtml) {
        textElement.innerHTML = "<span>" + this.content + "</span>";
    } else {
        textElement.innerText = this.content;
    }
    this.toastElement.appendChild(textElement);

    var closeButton = document.createElement("span");
    closeButton.className = "toaster-ui-lib-close";
    closeButton.innerHTML = "&times;";
    var self = this;
    closeButton.addEventListener("click", function () {
        self.close();
    });
    this.toastElement.appendChild(closeButton);

    if (this.autoClose === true) {
        this.startDismissTimeout();
    }
};

Toast.prototype.setCustomStyles = function (styles) {
    if (styles && typeof styles === "object") {
        for (var key in styles) {
            if (styles.hasOwnProperty(key)) {
                this.toastElement.style[key] = styles[key];
            }
        }
    }
};

Toast.prototype.setDuration = function (duration) {
    this.duration = duration;
};

Toast.prototype.show = function () {
    this.toastElement.style.opacity = "0";
    if (this.autoClose === true) {
        this.startDismissTimeout();
    }
};

Toast.prototype.startDismissTimeout = function () {
    var self = this;
    this.dismissTimeout = setTimeout(function () {
        self.close();
    }, this.duration);
};

Toast.prototype.close = function () {
    if (typeof this.onClose === "function") {
        this.onClose();
    }

    this.toastElement.style.animation =
      "toaster-ui-lib-slide-out-blurred-right 0.6s cubic-bezier(0.445, 0.05, 0.55, 0.95) both";

    var self = this;
    this.toastElement.addEventListener("animationend", function () {
        clearTimeout(self.dismissTimeout);
        if (self.toastElement.parentNode) {
            self.toastElement.parentNode.removeChild(self.toastElement);
            var container = document.getElementById("ToasterContainer");
            if (container && container.children.length === 0) {
                container.style.display = "none";
            }
        }
    });
};

// For Node/CommonJS
if (typeof module !== "undefined" && module.exports) {
    module.exports = Toast;
}
