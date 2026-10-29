/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

/**
 * @fileOverview Print Plugin
 */

CKEDITOR.plugins.add('RNCTEMPLATE', {
    // jscs:disable maximumLineLength
    lang: 'af,ar,bg,bn,bs,ca,cs,cy,da,de,el,en,en-au,en-ca,en-gb,eo,es,et,eu,fa,fi,fo,fr,fr-ca,gl,gu,he,hi,hr,hu,id,is,it,ja,ka,km,ko,ku,lt,lv,mk,mn,ms,nb,nl,no,pl,pt,pt-br,ro,ru,si,sk,sl,sq,sr,sr-latn,sv,th,tr,tt,ug,uk,vi,zh,zh-cn', // %REMOVE_LINE_CORE%
    // jscs:enable maximumLineLength
    icons: 'FullLayout,', // %REMOVE_LINE_CORE%
    hidpi: true, // %REMOVE_LINE_CORE%
    init: function (editor) {
        // Print plugin isn't available in inline mode yet.
        if (editor.elementMode == CKEDITOR.ELEMENT_MODE_INLINE)
            return;

        var pluginName = 'FullLayout';

        // Register the command.
        editor.addCommand(pluginName, test);

        // Register the toolbar button.
        editor.ui.addButton && editor.ui.addButton('FullLayout', {
            label: "Preview",
            command: pluginName,
            toolbar: 'document,50'
        });
    }
});

test = {
    exec: function (editor) {
      
        startLoading("Loading...");
        $.ajax({
            type: "Post",
            url: "PrintRNCTemplate",
            data: {
                TemplateName: $("#txtName").val(), Status: $("#ddlStatus").val(),
                Template: escape(CKEDITOR.instances.HtmlTemplate.document.getDocumentElement().getHtml()),
                StudyName:"",
                PrintType: "Preview"
            },

            success: function (response) {
                stopLoading();
                if (response == "Success") {
                    var a = document.createElement('a');
                    a.href = 'DisplayRNCPrintTemplate';
                    a.target = '_blank';
                    a.id = "Sample";
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                }
                else
                    ToastMsg(response, "Information");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // display an error message in any way
                stopLoading();
                ToastMsg(textStatus, "Error");
            }
        });

    }
};
