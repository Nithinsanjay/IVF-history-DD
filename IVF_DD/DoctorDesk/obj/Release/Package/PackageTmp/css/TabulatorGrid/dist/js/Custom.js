var dateEditor = function (cell, onRendered, success, cancel) {
    var input = document.createElement("input");
    input.type = "text";
    input.value = cell.getValue();
    onRendered(function () {
        $(input).datepicker({
            dateFormat: "dd/mm/yy",
            changeMonth: true,   
            changeYear: true,   
            yearRange: "1900:3000", 
            onSelect: function (dateText) {
                success(dateText);
            }
        });

        $(input).datepicker("show");
    });

    return input;
};


function select2Editor(optionsList) {
    return function (cell, onRendered, success, cancel) {
        var input = document.createElement("select");
        input.style.width = "100%";
        optionsList.forEach(function (opt) {
            var option = document.createElement("option");
            option.value = opt.id;
            option.text = opt.text;
            if (cell.getValue() === opt.id) {
                option.selected = true;
            }
            input.appendChild(option);
        });
        onRendered(function () {
            $(input).select2({
                dropdownParent: document.body,
                width: 'resolve'
            })
            .on("select2:select", function (e) {
                success(e.params.data.id);
            })
            .on("select2:close", function () {
                cancel();
            });
            $(input).select2("open");
        });
        return input;
    };
}
