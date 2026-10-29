<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>
<%-- Added By Priyanka - For Multiple CKEditor --%>
<script src="<%=ResolveUrl("~/Scripts/ckeditor/ckeditor.js")%>"></script>
<style>
    textarea {
        box-sizing: border-box;
    }
 .History-textarea table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

.History-textarea th,
.History-textarea td {
    border: 1px solid #999;
    padding: 6px;
    text-align: left;
}

.History-textarea th {
    background-color: #f2f2f2;
    font-weight: bold;
}

/*Pournima 17th june 2026*/
.cke_combo__font {
    display: none !important;
}
</style>

<script type="text/javascript">
    var RMOFlagClinicNoteYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVECLINICNOTESYN")%>' == "Y" ? "N" : "Y") : "N";
    var SessionCompClinicNote = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagClinicNoteYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');
    var defckFontFamily = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CkEditorDefFontfamily")%>';
    var defckFontSize = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CkEditorDefFontSize")%>';
    $(document).ready(function () {

        if (!defckFontFamily || defckFontFamily.trim() === "") {
            defckFontFamily = "Arial";
        }
        // Added By Abhishesh || 20260321
        $("#btnCNfitTocontent").on("click", function () {

            fitToContent('ClinicalNotes_Freetext');

            $(this).hide();
            $("#btnCNsetmaxheight").show();
        });
        $("#btnCNsetmaxheight").on("click", function () {

            setMaxHeight('ClinicalNotes_Freetext');

            $(this).hide();
            $("#btnCNfitTocontent").show();
        });
        // End
        //Abhishesh || 20260910
        $("#btnCKfitTocontent").on("click", function () {
            fitToContentCKEditor('ClinicalNotes_HtmlEditor');
        });
        $("#btnCKsetmaxheight").on("click", function () {
            setMaxHeightCKEditor('ClinicalNotes_HtmlEditor');
        });
        //End
        $("#ddlClinicalNtTemplate").on("change", function () {
            var SelectedTemp = $("#ddlClinicalNtTemplate").val();
            if (SelectedTemp === "SYS") {
                ClinicalNtloadSystemicExaminations();
            }
            else if (SelectedTemp === "RHEU") {
                ClinicalNtloadRheumatology();
            }
            else if (SelectedTemp === "OP1") {
                ClinicalNtloadOpthal1();
            }
            else if (SelectedTemp === "OP2") {
                ClinicalNtloadOpthal2();
            }
            else if (SelectedTemp === "OP3") {
                ClinicalNtloadOpthal3();
            }
            else if (SelectedTemp === "RESP") {
                ClinicalNtloadRespiratoryMedicine();
            }
        });

        $("#ClinicalNotes_Freetext").on("input", function () {
            autoResizeTextareaForSinglePage(this);
        });

        //priyanka 10/04/2026
        if (IsClinicNotesFreeTxtVisible === "Y") {
            $("#sec-clinical_textarea_content").css('display', 'block');
            $("#DivClinicalNtDropDown").css('display', 'inline-block');
            $("#sec-clinical_CKEditor_content").css('display', 'none');
        }
        else {
            $("#sec-clinical_textarea_content").css('display', 'none');
            $("#DivClinicalNtDropDown").css('display', 'none');
            $("#sec-clinical_CKEditor_content").css('display', 'inline-block');
        }

        CKEDITOR.replace('ClinicalNotes_HtmlEditor', {
            uiColor: '#CCEAEE',
            tool: 'full',
            filebrowserImageUploadUrl: 'UploadImage',
            uploadUrl: '../SinglePage/DragUploadImage',//Added by Rajan -For Drag and Drop the Image
            /*extraPlugins: 'uploadimage,RNCTEMPLATETRAN,customEventPlugin',//Added by Rajan -For Drag and Drop the Image*/
            extraPlugins: 'uploadimage,customEventPlugin',//Added by Rajan -For Drag and Drop the Image
            allowedContent: true,
            height: ['8.1cm'], //['50vh'], // Pournima 8th Aug 2026
            title: "",
            removePlugins: 'elementspath',
            indent: false,
            breakBeforeOpen: true,
            breakAfterOpen: false,
            breakBeforeClose: false,
            breakAfterClose: true,
            language: 'en',
            font_defaultLabel: defckFontFamily,
            fontSize_defaultLabel: defckFontSize,
            // An array of stylesheets to style the WYSIWYG area.
            // Note: it is recommended to keep your own styles in a separate file in order to make future updates painless.
            font_names: defckFontFamily + ';' + CKEDITOR.config.font_names,
            fontSize_sizes: defckFontSize.replace('px', '') + '/' + defckFontSize + ';' + CKEDITOR.config.fontSize_sizes,

          //Abhishesh || 20260910
            contentsCss: [
                CKEDITOR.basePath + 'contents.css',
                CKEDITOR.basePath + 'pastefromword.css',
                'data:text/css;charset=utf-8,' + encodeURIComponent(
                    '.document-editor, .document-editor * { font-family: ' + defckFontFamily + ' !important; font-size: ' + defckFontSize + ' !important; } html, body.document-editor { overflow-y: auto !important; overflow-x: hidden !important; margin:0 !important; }'
                )
            ],
            //End
            // Remove buttons irrelevant for pasting from external sources.
            removeButtons: 'PageBreak,Source,CopyFormatting,Save,Print,Anchor,Smiley,ExportPdf,Form,Checkbox,Radio,TextField,Select,Textarea,Button,ImageButton,HiddenField,NewPage,CreateDiv,Flash,Iframe,About,ShowBlocks,Preview',
            // Fit toolbar buttons inside 3 rows.
            // Fit toolbar buttons inside 3 rows.
            toolbarGroups: [
                { name: 'document', groups: ['mode', 'document', 'doctools'] },
                { name: 'clipboard', groups: ['clipboard', 'undo'] },
                { name: 'editing', groups: ['find', 'selection', 'spellchecker', 'editing'] },
                { name: 'forms', groups: ['forms'] },
                { name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] },
                { name: 'links', groups: ['links'] },
                { name: 'insert', groups: ['insert'] },
                { name: 'basicstyles', groups: ['basicstyles', 'cleanup'] },
                { name: 'colors', groups: ['colors'] },
                { name: 'tools', groups: ['tools'] },
                { name: 'others', groups: ['others'] },
                { name: 'about', groups: ['about'] },
                { name: 'styles', groups: ['styles'] }
            ],
            resize_enabled: false,
            // This is optional, but will let us define multiple different styles for multiple editors using the same CSS file.
            bodyClass: 'document-editor',
            //Added By Rajan - For TemplateHelper
            on: {
                instanceReady: function (evt) {
                    const editor = evt.editor;
                    $('.cke_toolbox').css('display', 'block');
                    //Abhishesh || 20260910 - allow native scrollbar inside the editor iframe
                    $(editor.container.$).find('iframe').attr('scrolling', 'auto');
                }
            }
            //End - For TemplateHelper
        });

        CKEDITOR.instances['ClinicalNotes_HtmlEditor'].on('paste', function (evt) {
            evt.data.dataValue = stripFontStylingForDefault(evt.data.dataValue);
        });

        function stripFontStylingForDefault(html) {
            var temp = document.createElement('div');
            temp.innerHTML = html;

            // 0. Remove any embedded <style> blocks Word pastes along with the content
            //    (these define classes like .Bauhaus93Char { font-family:"Bauhaus 93"; })
            var styleTags = temp.getElementsByTagName('style');
            while (styleTags.length > 0) {
                styleTags[0].parentNode.removeChild(styleTags[0]);
            }

            // 1. Convert legacy <font> tags into plain <span>
            var fontTags = temp.getElementsByTagName('font');
            while (fontTags.length > 0) {
                var f = fontTags[0];
                var span = document.createElement('span');
                while (f.firstChild) span.appendChild(f.firstChild);
                f.parentNode.replaceChild(span, f);
            }

            // 2. Walk every element and strip font-related styling + ALL classes
            var all = temp.getElementsByTagName('*');
            for (var i = 0; i < all.length; i++) {
                var el = all[i];

                el.removeAttribute('face');
                el.removeAttribute('size');
                el.removeAttribute('color');

                // Remove ALL classes (not just Mso*) — a class is how Word's
                // custom font names like "Bauhaus93Char" get applied
                el.removeAttribute('class');

                if (el.style) {
                    el.style.removeProperty('font-family');
                    el.style.removeProperty('font-size');
                    el.style.removeProperty('font');        // shorthand property
                    el.style.removeProperty('line-height');
                    if (el.getAttribute('style') === '') {
                        el.removeAttribute('style');
                    }
                }
            }

            return temp.innerHTML;
        }

        CKEDITOR.instances['ClinicalNotes_HtmlEditor'].on('getData', function (evt) {
            evt.data.dataValue = evt.data.dataValue
                .replace(/<title>.*?<\/title>/gi, '')
                .replace(/<head>[\s\S]*?<\/head>/gi, '');
        });
        BindClinicalNotesData();

       if (sessionStorage.getItem("PatCompleted") === "Y") {//priyanka 10/04/2026
           if (CKEDITOR.instances.ClinicalNotes_HtmlEditor) {
               let editor = CKEDITOR.instances.ClinicalNotes_HtmlEditor;
               if (editor.status === "ready") {
                   CKEDITOR.instances['ClinicalNotes_HtmlEditor'].setReadOnly(true);
               } else {
                   editor.on('instanceReady', function () {
                       CKEDITOR.instances['ClinicalNotes_HtmlEditor'].setReadOnly(true);
                   });
               }
           }
       }
       else {
           if (CKEDITOR.instances.ClinicalNotes_HtmlEditor) {
               let editor = CKEDITOR.instances.ClinicalNotes_HtmlEditor;
               if (editor.status === "ready") {
                   CKEDITOR.instances['ClinicalNotes_HtmlEditor'].setReadOnly(false);
               } else {
                   editor.on('instanceReady', function () {
                       CKEDITOR.instances['ClinicalNotes_HtmlEditor'].setReadOnly(false);
                   });
               }
           }
        }
        if (sessionStorage.getItem("PatCompleted").toString() === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagClinicNoteYN == "Y") {
            $("#sec-clinical *").attr("disabled", "disabled");
            $("#ClinicalNote_PrevHistory").removeAttr("disabled");
        }
        else {
            $("#sec-clinical *").removeAttr("disabled");
        }
   });

    function ClinicalNtloadSystemicExaminations() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push(" General Examination		:	NAD \n\n");
        strPrindData.push("  Systemic Examination\n");
        strPrindData.push("\t\t 1.  Cardiovascular System		:	NAD\n");
        strPrindData.push("\t\t 2.  Central Nervous System		:	NAD\n");
        strPrindData.push("\t\t 3.  Respiratory System		        :	NAD\n");
        strPrindData.push("\t\t 4.  Per Abdomen			        :	NAD\n\n");
        strPrindData.push("  Local Examination			            :	Not Applicable\n");
        if (HideECGRow == "Y")
            strPrindData.push("  ECG                             :   Done / Not Done - Within Normal Limits\n");
        appendToClinicalNotesText(strPrindData, "");
    }

    function appendToClinicalNotesText(linesArray, Type) {
        var txt = "";
        txt = $("#ClinicalNotes_Freetext");
        txt.val(txt.val() + linesArray.join(""));
        autoResizeTextareaForSinglePage(txt[0]);
    }

    function ClinicalNtloadRheumatology() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("  \n Synovitis \n");
        strPrindData.push("  Deformities \n");
        strPrindData.push("  Phalen's Test \n");
        strPrindData.push("  Finkelstein's Test \n\n");
        strPrindData.push(" 	\n");
        strPrindData.push(" Power - Upper Limb 	:	\n");
        strPrindData.push(" \t     - Lower Limb	:	\n");
        strPrindData.push(" Neck  Flexors	:	\n\n");
        var strPrindData1 = [];
        strPrindData1.push(" SLR :  \n");
        appendToClinicalNotesText(strPrindData, "");
        appendToClinicalNotesText(strPrindData1, "");
    }

    function ClinicalNtloadOpthal1() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push(".                    Right Eye                          Left  Eye	\n");
        strPrindData.push("Vision    :                                       \n");
        strPrindData.push("--------------------------------------------------------------------------\n");
        strPrindData.push("Tension  :                                                  \n");
        strPrindData.push("--------------------------------------------------------------------------\n");
        strPrindData.push("Cornea   :                                                  \n");
        strPrindData.push("--------------------------------------------------------------------------\n");
        strPrindData.push("Lens       :                                                  \n");
        var strPrindData1 = [];
        strPrindData1.push("--------------------------------------------------------------------------\n");
        strPrindData1.push("Retina    :                                                  \n");
        appendToClinicalNotesText(strPrindData, "");
        appendToClinicalNotesText(strPrindData1, "");
    }

    function ClinicalNtloadOpthal2() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("\n  EOM   :  \n");
        strPrindData.push("   Lid   :  \n");
        strPrindData.push("   Cornea   :  \n");
        strPrindData.push("   Pupil   :  \n");
        strPrindData.push("   Lens   :  \n");
        strPrindData.push("   Anterior Segment   :  \n");
        strPrindData.push("   Fundus   CDR:   :  \n");
        strPrindData.push("   FR    :  \n");
        var strPrindData1 = [];
        strPrindData1.push("\n  Vision <   :  \n");
        strPrindData1.push("   Refraction <   :             AR <  :           \n");
        strPrindData1.push("   Vision with glass <   :  \n");
        strPrindData1.push("   IOP <   :  \n");
        strPrindData1.push("   Dilated AR <   :  \n");
        strPrindData1.push("   Dilated Retraction <   :  \n");
        strPrindData1.push("   Fogging <   :  \n");
        strPrindData1.push("   FR    :  \n");
        appendToClinicalNotesText(strPrindData, "");
        appendToClinicalNotesText(strPrindData1, "");
    }

    function ClinicalNtloadOpthal3() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("\n   DISTANCE VISION - WITH / WITHOUT GLASS    \n");
        strPrindData.push("   RIGHT EYE - 6/6     \n");
        strPrindData.push("   LEFT EYE - 6/6     \n\n");
        strPrindData.push("   NEAR VISION - WITH / WITHOUT GLASS     \n");
        strPrindData.push("   RIGHT EYE - N6     \n");
        strPrindData.push("   LEFT EYE - N6     \n\n");
        strPrindData.push("   INTRAOCULAR PRESSURE   \n");
        strPrindData.push("   RIGHT EYE - 16      \n");
        var strPrindData1 = [];
        strPrindData1.push("   LEFT EYE - 16 <     \n\n");
        strPrindData1.push("   ANTERIOR SEGMENT                     \n");
        strPrindData1.push("   RIGHT EYE - NORMAL     \n");
        strPrindData1.push("   LEFT EYE - NORMAL    \n\n");
        strPrindData1.push("   POSTERIOR SEGMENT   \n");
        strPrindData1.push("   RIGHT EYE - NORMAL     \n");
        strPrindData1.push("   LEFT EYE - NORMAL   \n\n");
        strPrindData1.push("   VISION ACCEPTANCE     \n\n");
        var strPrindData2 = [];
        strPrindData2.push("   RE :  \n\n");
        strPrindData2.push("   LE :  \n\n");
        strPrindData2.push("   ADD:  \n\n");
        strPrindData2.push("   OTHER OBSERVATIONS : \n\n");
        appendToClinicalNotesText(strPrindData, "");
        appendToClinicalNotesText(strPrindData1, "");
        appendToClinicalNotesText(strPrindData2, "");
    }

    function ClinicalNtloadRespiratoryMedicine() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("\n   Chief Complaints : \n");
        strPrindData.push("   C/o breathlessness since \n");
        strPrindData.push("   C/o cough with expectoration since \n");
        strPrindData.push("   C/o fever since     \n");
        strPrindData.push("   C/o chest pain since \n");
        strPrindData.push("   Symptomatically better \n\n");
        strPrindData.push("   Past History :   \n\n\n");
        strPrindData.push("   On Examination :      \n");
        var strPrindData1 = [];
        strPrindData1.push("   P - /min \n"); strPrindData1.push("   BP - / mmHg \n"); strPrindData1.push("   SpO2 - % \n"); strPrindData1.push("   Chest - % \n\n");
        strPrindData1.push("   Plan – Start empirical ATT     \n  The rationale for starting empirical ATT, along with the possible duration and side effects \n");
        strPrindData1.push("   explained to the patient and her relative. \n\n");
        strPrindData1.push("    Advice - \n");
        var strPrindData2 = [];
        strPrindData2.push("   Follow Up  - \n");
        strPrindData2.push("   Refer To    - \n");
        appendToClinicalNotesText(strPrindData, "");
        appendToClinicalNotesText(strPrindData1, "");
        appendToClinicalNotesText(strPrindData2, "");
    }

    function ValidationForClinicalNotes(Type) {
        return true;
    }

    function SaveForClinicalNotes(DataSaveObj, Type) {//priyanka 10/04/2026
        if (IsClinicNotesFreeTxtVisible === "Y") {
            DataSaveObj.ClinicalNotes = $("#ClinicalNotes_Freetext").val();
        }
        else
        {
            DataSaveObj.ClinicalNotes = encodeURIComponent(CKEDITOR.instances.ClinicalNotes_HtmlEditor.getData());
        }
       
    }

    function BindClinicalNotesData() {
        var strTran = sessionStorage.getItem('PatTRANNO');
        var strtype = "1";
        startLoading("Loading", "loading-ClinicalNotes");
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GetChemoNotes',
            data: {
                Tran: strTran,
                Type: strtype
            },
            async: false,
            success: function (result) {
                $('#ClinicalNotes_Freetext').empty();
                if (result != "") {

                    if (IsClinicNotesFreeTxtVisible === "Y") { //priyanka 10/04/2026
                        $('#ClinicalNotes_Freetext').val(result[0].CLINICALHIST);
                        fitToContent('ClinicalNotes_Freetext');
                        $("#btnCNfitTocontent").hide();
                        $("#btnCNsetmaxheight").show();
                    }
                    else {
                        var data = result[0].CLINICALHIST;
                        data = decodeURIComponent(data.replace(/%(?![0-9A-Fa-f]{2})/g, '%25'));
                        var headStart = data.indexOf("<head>");
                        var headEnd = data.indexOf("</head>");
                        if (headStart !== -1 && headEnd !== -1) {
                            var textToRemove = data.substring(headStart, headEnd + 7);
                            data = data.replace(textToRemove, " ");
                        }
                        if (CKEDITOR.instances.ClinicalNotes_HtmlEditor) {
                            let editor = CKEDITOR.instances.ClinicalNotes_HtmlEditor;
                            if (editor.status === "ready") {
                                editor.setData(data);
                            } else {
                                editor.on('instanceReady', function () {
                                    editor.setData(data);
                                });
                            }
                        }
                    }
                    
                }
                stopLoading("loading-ClinicalNotes");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-ClinicalNotes");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function HASDataInClinicalNotes() { //priyanka 16/04/2026
        var ClinicalnotesFreeTxt = $("#ClinicalNotes_Freetext").val();
        var ClinicalNotesCKETxt = CKEDITOR.instances['ClinicalNotes_HtmlEditor'].getData().trim().replace(/<[^>]*>/gi, '').trim();
        if (IsClinicNotesFreeTxtVisible === "Y") {
            if (ClinicalnotesFreeTxt === "" || ClinicalnotesFreeTxt === null) {
                return false;
            }
            else {
                return true;
            }
        }
        else {
            if (ClinicalNotesCKETxt === "" || ClinicalNotesCKETxt === null) {
                return false;
            }
            else {
                return true;
            }
        }
    }

</script>

<%-- Clinical History --%>
<script type="text/javascript">
    //Get Previous History Clinical Notes
    function GetBindClinicalNotesPrevHistory() {
        var Result = [];
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GetPreviousNotes',
            datatype: "json",
            async: false,
            data: { strMrNo: sessionStorage.getItem("PatMRNO") },
            success: function (Response) {
                Result = Response;
            }
        });
        return Result;
    }

    function HistPopClinicalHistoryTemp(AllHistoryData, ContentID) {
        var $container = $('<div class="history-list-wrapper"></div>');
        for (var i = 0; i < AllHistoryData.length; i++) {
            var row = AllHistoryData[i];
            /*if (!row.PLANID || row.CLINICALHIST == "") continue;       vandana 050226*/
            if (!row.PLANID || row.PLANID == sessionStorage.getItem("PatTRANNO") || row.CLINICALHIST == "") continue;
            // Panel wrapper
            var $panel = $('<div class="History-panel mb-3" style="border-radius:6px; overflow:hidden; box-shadow:0 1px 4px rgba(0,0,0,0.1);"></div>');

            var $panelHead = $('<div class="History-header d-flex justify-content-between align-items-center p-3" style="background-color:#17968a; color:#fff;"></div>');

            var isVisitCompleted = (typeof SessionCompClinicNote !== 'undefined' && SessionCompClinicNote === "Y");

            var $leftDiv = $('<div class="d-flex align-items-center flex-grow-1"></div>');

            var $docDiv = $('<div style="font-weight:bold; font-size:14px; color:#fff;"></div>')
                .text("Consultation No.: " + row.PLANID);

            var $dateDiv = $('<div style="font-size:13px; color:#e0f2f1;font-weight:bold; margin-top:2px;"></div>')
                .text(row.TRANDATE || "");

            $leftDiv.append($('<div></div>').append($docDiv, $dateDiv));

            var $rightDiv = $('<div class="d-flex align-items-center"></div>');

            var $copyDiv = $();
            if (!isVisitCompleted) {
                $copyDiv = $('<button class="btn btn-sm copyHisCls" style="background:transparent; border:1px solid #fff; color:#fff;" title="Copy"></button>')
                    .data("ClinicalHist", row.CLINICALHIST)
                    .html('<i class="fa fa-copy"></i> Copy All');
            }

            $rightDiv.append($copyDiv);
            $panelHead.append($leftDiv, $rightDiv);
            // Body
            var $panelBody = $('<div class="History-body p-3"></div>');
            $panelBody.append(
                '<div class="History-section">' +
                '<textarea class="History-textarea" readonly>' +
                row.CLINICALHIST +
                '</textarea>' +
                '</div>'
                    );
        $panel.append($panelHead, $panelBody);
        $container.append($panel);
    }
    if (ContentID) {
        $('#' + ContentID).html($container);
    }
    return $container.html();
}  
function HistPopHTMLClinicalHistoryTemp(AllHistoryData, ContentID) {

      var $container = $('<div class="history-list-wrapper"></div>');

      for (var i = 0; i < AllHistoryData.length; i++) {
          var row = AllHistoryData[i];

          // Skip conditions
          if (!row.PLANID || row.PLANID == sessionStorage.getItem("PatTRANNO") || row.CLINICALHIST == "") continue;

          // 🔹 STEP 1: Get data
          var data = row.CLINICALHIST || "";

          try {
              data = decodeURIComponent(data);
          } catch (e) { }

          // 🔹 STEP 3: Proper HTML parsing (fix table issue)
          //var parser = new DOMParser();
          //var doc = parser.parseFromString(data, "text/html");

          // Extract ONLY body content
          //data = data.body ? data.body.innerHTML : data;

          // 🔹 Panel wrapper
          var $panel = $('<div class="History-panel mb-3" style="border-radius:6px; overflow:hidden; box-shadow:0 1px 4px rgba(0,0,0,0.1);"></div>');

          var $panelHead = $('<div class="History-header d-flex justify-content-between align-items-center p-3" style="background-color:#17968a; color:#fff;"></div>');

          var isVisitCompleted = (typeof SessionCompClinicNote !== 'undefined' && SessionCompClinicNote === "Y");

          var $leftDiv = $('<div class="d-flex align-items-center flex-grow-1"></div>');

          var $docDiv = $('<div style="font-weight:bold; font-size:14px; color:#fff;"></div>')
              .text("Consultation No.: " + row.PLANID);

          var $dateDiv = $('<div style="font-size:13px; color:#e0f2f1; font-weight: bold; margin-top:2px;"></div>')
              .text(row.TRANDATE || "");

          $leftDiv.append($('<div></div>').append($docDiv, $dateDiv));

          var $rightDiv = $('<div class="d-flex align-items-center"></div>');

          var $copyDiv = $();
          if (!isVisitCompleted) {
              $copyDiv = $('<button class="btn btn-sm copyHisCls" style="background:transparent; border:1px solid #fff; color:#fff;" title="Copy"></button>')
                  .attr("data-clinicalhist", encodeURIComponent(data))
                  .html('<i class="fa fa-copy"></i> Copy All');
          }

          $rightDiv.append($copyDiv);
          $panelHead.append($leftDiv, $rightDiv);


          var $panelBody = $('<div class="History-body p-3"></div>');

          $panelBody.append(
              '<div class="History-section">' +
              '<div class="History-textarea">' + data + '</div>' +
              '</div>'
          );

          $panel.append($panelHead, $panelBody);
          $container.append($panel);
      }

      // 🔹 Bind to container
      if (ContentID) {
          $('#' + ContentID).html($container);
      }

      return $container.html();
  }

    function CopyFuncClinicalNotes() {
        $(".History-textarea").each(function () {
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        });
        if (IsClinicNotesFreeTxtVisible === "Y") { //priyanka 10/04/2026
            $(document).off("click", ".copyHisCls").on("click", ".copyHisCls", function () {
                var $panel = $(this).closest(".History-panel");
                var ClinicalNoteHistText = $panel.find(".History-textarea").val() || "";
                $("#ClinicalNotes_Freetext").val(ClinicalNoteHistText);
                autoResizeTextareaForSinglePage(document.getElementById("ClinicalNotes_Freetext"));
            });
        }
        else {
            $(document).off("click", ".copyHisCls").on("click", ".copyHisCls", function () {

                var data = $(this).attr("data-clinicalhist");

                // Decode back
                try {
                    data = decodeURIComponent(data);
                } catch (e) { }

                if (CKEDITOR.instances["ClinicalNotes_HtmlEditor"]) {

                    CKEDITOR.instances["ClinicalNotes_HtmlEditor"].setData(data, function () {
                        this.focus();
                    });

                } else {
                    console.error("CKEditor instance not found");
                }

            });
        }
    }
</script>


<%--Setup Popup--%>
<script type="text/javascript">
    function SetupPopupClinicalNotesContent() {
        return `
         <div class="FilterClassDivPopup">
         <button class="btn btn-primary" onclick="ValidationForSetupCNotesBindTran('Setup_Examination')"><i class="fa fa-save"></i> Apply</button>
         <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('Examination', 'ExaminationSetup')">
         </div>
         <div id="SetupMainListTable"></div>
         <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
        `;
    }

    function CreateTabulatorClinicNotesSetup(TabulatorSetupId) {
        var SetupExamListTable = new Tabulator(("#" + TabulatorSetupId), {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            index: "code",
            columns: [
                {
                    title: "Action",
                    field: "act",
                    width: 100,
                    headerSort: false,
                    hozAlign: "center",
                    // This allows the column to contain HTML
                    formatter: function (cell, formatterParams, onRendered) {
                        return `
            <div style="display: flex; gap: 15px; justify-content: center; align-items: center;">
                <input type="checkbox" class="row-checkbox" style="cursor:pointer; width:16px; height:16px;">
                <i class="fa fa-pencil text-primary edit-row" style="cursor:pointer; font-size: 16px;" title="Edit"></i>
            </div>
        `;
                    },
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var target = e.target;
                        var rowData = cell.getRow().getData();
                        if (target.classList.contains("row-checkbox")) {
                            var isChecked = target.checked;
                            var newValue = isChecked ? "Y" : "N";
                            row.update({ CHECKYN: newValue });
                        }
                        if (target.classList.contains("edit-row")) {
                            OpenPopupForNewItem('Examination', 'ExaminationSetup');
                            BindExaminationEditSetup(rowData)
                        }
                    }
                },
                { title: "CHECKYN", field: "CHECKYN", visible: false },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    formatter: "textarea",
                    formatterParams: {
                        minHeight: "auto",
                    },
                    cssClass: "wrap-text"
                }
            ]
        });
        BindClinicNotesSetupList(TabulatorSetupId);
    }

    function BindClinicNotesSetupList(TabulatorSetupId) {
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetExamSetupList","DoctorDesk")%>",
            data: {},
            asycn: true,
            success: function (response) {
                if (response != "Unsucessfull") {
                    var result = JSON.parse(response);

                    if (result.Table1 && result.Table1.length > 0) {

                        var formattedData = result.Table1.map(function (row) {
                            return {
                                CHECKYN: "N",
                                code: row.CODE,
                                name: row.DESC
                            };
                        });
                        var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

                        if (table) {
                            table.setData(formattedData);
                        }
                    }
                }
            }
        });
    }

    function ValidationForSetupCNotesBindTran(TabulatorSetupId) {
        var SelCode = "";
        var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

        if (table) {
            // 1. Get all current data from the table
            var TableAllData = table.getData();
            SelCode = TableAllData
                .filter(function (row) {
                    return row.CHECKYN === "Y";
                })
                .map(function (row) {
                    return row.code;
                })
                .join(",");
            SetClinicalNotesSetupToTxtExam(SelCode);
        }
    }

    function SetClinicalNotesSetupToTxtExam(strCode) {
        $.ajax({
            url: '../DoctorDesk/GetExamSetupDataByCode',
            data: { strSetUpCode: strCode },
            type: 'post',
            async: true,
            datatype: 'get',
            success: function (response) {
                if (response != "") {
                    for (i = 0; i < response.length; i++) {
                        if ($("#Exam_Freetext").val() == "") {
                            $("#Exam_Freetext").val($("#Exam_Freetext").val() + '\n' + response[i]);
                        }
                        else {
                            $("#Exam_Freetext").val($("#Exam_Freetext").val() + '\n\n' + response[i]);
                        }
                    }
                    autoResizeTextareaForSinglePage(document.getElementById('Exam_Freetext'));
                    closeMaxMinPopup('Hist_M_Examination');
                }
            }
        })
    }

    function ContentForAddNewItemExaminatonSetup() {
        return `
        <div class="mb-3">
                 <input id="txtSetupNameCode" type="text" class="form-control " style="display:none" />
               </div>
        <div class="mb-3">
          <input id="txtSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
        </div>
        <div class="mb-3">
          <textarea id="txtExamSetup" type="text" class="form-control ExaminationSetup"  autocomplete="off" placeholder="Enter Examination" tabindex="2" > </textarea>
        </div>
    `;
    }

    function FooterContentForAddNewItemExaminatonSetup() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForExaminationSetup('Complaints')" tabindex="4">Save</button>
        `;
    }

    function BindExaminationEditSetup(RowData) {
        $.ajax({
            url: '../DoctorDesk/GetExamSetupDataByCode',
            data: { strSetUpCode: RowData.code },
            type: 'post',
            async: true,
            datatype: 'get',
            success: function (response) {
                if (response != "") {
                    $("#txtSetupNameCode").val(RowData.code);
                    $("#txtSetupName").val(RowData.name);
                    $("#txtExamSetup").val(response);
                }
            }
        });
    }

    //Validation For New Item Complaints
    function ValidationForNewItemExaminationSetup() {
        if ($("#txtSetupName").val().trim().length === 0) {
            ToastMsg("Enter Setup Name", "warning");
            $("#txtSetupName").focus();
            return false;
        }
        if ($("#txtExamSetup").val().trim().length === 0) {
            ToastMsg("Enter Examination Setup", "warning");
            $("#txtExamSetup").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Complaints
    function SaveNewItemForExaminationSetup() {
        if (ValidationForNewItemExaminationSetup() == true) {
            $.ajax({
                type: "post",
                datatype: "json",
                url: '../DoctorDesk/AddExaminationSetUp',
                data: { strSetUpName: $("#txtSetupName").val(), strExamSetupTempData: $("#txtExamSetup").val(), strSetUpCode: $("#txtSetupNameCode").val() },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        BindExaminationSetupList('Setup_Examination');
                        closeAddNewItemPopup('ExaminationSetup');
                    }
                    else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                        ToastMsg("This Set Up is already Present.", "warning");
                    }
                    else {
                        ToastMsg("Error!!Please Contact IT Dept.", "error");
                    }
                }
            });
        }
    }

    function fitToContent(id) {
        var textArea = document.getElementById(id);
        textArea.style.height = 'auto';
        var newHeight = Math.ceil(textArea.scrollHeight);

        textArea.style.height = newHeight + 'px';
        textArea.style.overflow = 'hidden';
    }

    function setMaxHeight(id) {
        var textArea = document.getElementById(id);
        textArea.style.height = "400px";
        textArea.style.overflowY = "auto";
    }
    //Abhishesh || 20260910
    function fitToContentCKEditor(editorId) {
        var editor = CKEDITOR.instances[editorId];
        if (!editor || editor.status !== "ready") return;
        var body = editor.document.$.body;
        editor.resize('100%', 1, true);
        var newHeight = Math.ceil(body.scrollHeight);
        editor.resize('100%', newHeight, true);
    }

    function setMaxHeightCKEditor(editorId) {
        var editor = CKEDITOR.instances[editorId];
        if (!editor || editor.status !== "ready") return;
        editor.resize('100%', 400, true);
    }
    //End
</script>


<div id="sec-clinical" class="opd-section-card anchor-offset sec-clinicalmaindiv">
    <div class="d-flex justify-content-between mb-3">
        <h4 class="section-title">Clinical Note</h4>
        <div>
            <div class="text-end mb-2" style="display: inline-block; vertical-align: top;" id="DivClinicalNtDropDown">
                <select class="form-select form-select-sm d-inline-block w-auto" id="ddlClinicalNtTemplate">
                    <option value="">---Select---</option>
                    <option value="SYS">Systemic Examinations</option>
                    <option value="RHEU">Rheumatoloy</option>
                    <option value="OP1">Opthal_1</option>
                    <option value="OP2">Opthal_2</option>
                    <option value="OP3">Opthal_3</option>
                    <option value="RESP">Respiratory Medicine</option>
                </select>
            </div>
            <div style="display: inline-block;">
                <button class="btn btn-outline-success btn-sm" id="ClinicalNote_PrevHistory" onclick="HistoryPopupOpen('Clinical Notes History', 'ClinicalNotes',true,'')"><i class="fa fa-history"></i></button>
                <button class="btn btn-outline-success btn-sm d-none" id="ClinicalNote_Setup">Setup</button>
            </div>
        </div>
    </div>
    <div id="sec_clinical_textarea_MainDiv">
        <div id="sec-clinical_textarea_content" style="display:none;">
            <textarea class="form-control TextAreaBorder" id="ClinicalNotes_Freetext" name="ClinicalNotes_Freetext" style="height: 80px; overflow: hidden; resize: none;"></textarea>
            <%--Abhishesh || 20260321--%>
            <div class="text-end">
                <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnCNfitTocontent" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
                <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnCNsetmaxheight" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer; display: none;" />
            </div>
            <%--end--%>
        </div>
        <%--Abhishesh || 20260910--%>
        <div id="sec-clinical_CKEditor_content" style="display: none; width: 100%;">
            <%--Pournima Added width 17th June 2026--%>
            <textarea class="form-control TextAreaBorder" id="ClinicalNotes_HtmlEditor" name="ClinicalNotes_HtmlEditor" style="height: 80px; overflow: hidden; resize: none;"></textarea>
            <div class="text-end">
                <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnCKfitTocontent" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
                <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnCKsetmaxheight" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer;" />
            </div>
        </div>
        <%--End--%>
    </div>
    <div id="loading-ClinicalNotes" class="loading-screen" style="display: none; opacity: 0;"></div>
</div>
