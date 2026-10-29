/*
Description: $.messager
Author: Kris Zhang
require: 
  string.format.js
  $.fn.dialog
*/

$.messager = (function () {

    var alert = function (title, message, focusid) {
        var model = $.messager.model;

        if (arguments.length < 2) {
            message = title || "";
            title = "&nbsp;"
        }

        $("<div>" + message + "</div>").dialog({
            title: title
            // override destroy methods;
          , onClose: function () {
              $(this).dialog("destroy");
              if (focusid !== undefined || focusid === null) {
                  $('#'+focusid).focus();
              }
          }
          , buttons: [{
              text: model.ok.text
              , classed: model.ok.classed || "btn-success"
              , click: function () {
                  $(this).dialog("destroy");
                  if (focusid !== undefined || focusid === null) {
                      $('#'+focusid).focus();
                  }
              }
          }]
        });
    };

    var confirm = function (title, message, callback) {
        var model = $.messager.model;

        $("<div>" + message + "</div>").dialog({
            title: title
            // override destroy methods;
          , onClose: function () {
              $(this).dialog("destroy");
          }
          , buttons: [{
              text: model.ok.text
              , classed: model.ok.classed || "btn-success"
              , click: function () {
                  $(this).dialog("destroy");
                  callback && callback(true);
              }
          },
            {
                text: model.cancel.text
              , classed: model.cancel.classed || "btn-danger"
              , click: function () {
                  $(this).dialog("destroy");
                  callback(false);
              }
            }]
        });
    };

    /*
    * popup message
    */
    var msghtml
      = ''
      + '<div class="dialog modal fade msg-popup">'
      + '<div class="modal-dialog modal-sm">'
      + '<div class="modal-content">'
      + '<div class="modal-body text-center"></div>'
      + '</div>'
      + '</div>'
      + '</div>'
    ;

    var $msgbox;

    var popup = function (message) {
        if (!$msgbox) {
            $msgbox = $(msghtml);
            $('body').append($msgbox);
        }

        $msgbox.find(".modal-body").html(message);
        $msgbox.modal({ show: true, backdrop: false });

        setTimeout(function () {
            $msgbox.modal('hide');
        }, 1500);
    };

    return {
        alert: alert
      , popup: popup
      , confirm: confirm
    };

})();


$.messager.model = {
    ok: { text: "OK", classed: 'btn-success' },
    cancel: { text: "Cancel", classed: 'btn-danger' }
};
