var MultiTempData = [];
var SubTempData = [];
var SettingDataFlag = true;

//Bind Section List Combo
//function SectionCmbList(TestCd, LabCD) {
//    MultiTempData = [];
//    SubTempData = [];
//    $.ajax({
//        type: "POST",
//        url: '../LabTransaction/GetSectionTempList',
//        data: { testCode: TestCd, LabCode: LabCD },
//        async: false,
//        success: function (response) {
//            $("#cmbSection").empty();
//            $("#cmbSection").append($('<option></option>').val("").html("---Select---"));
//            var TData = [];
//            $.grep(response, function (e) {
//                if ($('#rbtnPending')[0].checked != true || ($('#rbtnPending')[0].checked == true && e.Status == "A"))
//                    TData.push(e);
//            })
//            if (TData.length > 0) {
//                $.each(TData, function () {
//                    $("#cmbSection").append(
//                        $('<option></option>').val(this.Value).html(this.Text));
//                });
//                $("#cmbSection").select2();
//                if (TData.length == 1) {
//                    $("#s2id_cmbSection").select2("val", TData[0].Value);
//                }
//            }
//            else {
//                MsgDia("No Template is Configurated for Test", "Information");
//                return false;
//            }
//        },
//        error: function (XMLHttpRequest, textStatus, errorThrown) {
//            MsgDia(textStatus, "Error Information");
//            ajaxindicatorstop();
//        }
//    });
//}

//Get Section Template
//function GetSectionTemp() {
//    if ($("#cmbSection").val() == "") {
//        MultiTempData = [];
//        SubTempData = [];
//        if (CKEDITOR.instances.HtmlTemplate != null)
//            CKEDITOR.instances.HtmlTemplate.setData("");
//        if (CKEDITOR.instances.HtmlImpressionTemplate != null)
//            CKEDITOR.instances.HtmlImpressionTemplate.setData("");
//        CreateDynamicCKEditor("MultiCKEContentDivs", MultiTempData, false);
//    }
//    else {
//        startLoading("Loading...");
//        var datatosend = {
//            SectionCd: $("#cmbSection").val()
//        }
//        $.ajax({
//            type: "POST",
//            url: '../LabTransaction/GetSectionTemplateDtls',
//            data: datatosend,
//            success: function (response) {
//                if (response[0] == "" && response[0] == "") {
//                    MsgDia("No Header is Configurated for Template", "Information");
//                }
//                MultiTempData = response[0] == "" ? [] : response[0];
//                SubTempData = response[1] == "" ? [] : response[1];
//                CreateDynamicCKEditor("MultiCKEContentDivs", MultiTempData, false);
//                stopLoading();
//            },
//            error: function (XMLHttpRequest, textStatus, errorThrown) {
//                MsgDia(textStatus, "Error Information");
//                stopLoading();
//            }
//        });
//    }
//}

//Dynamic CKEditor
function CreateDynamicCKEditor(MainDivId, MainData, DiasbleFlag) {
    $("#" + MainDivId).empty();
    for (let i = 0; i < MainData.length; i++) {
        var CKEditorID = "HtmlTemplate_" + (MainData[i].CODE);
        var MultiSelID = "HtmlTemplateMulti_" + (MainData[i].CODE);
        var MultiSelDivID = "HtmlTemplateMultiDiv_" + (MainData[i].CODE);
        var SMainDiv = "<div class='SMainDiv'>{SMAINDIVCONTENT}</div>";
        var SHeaderDiv = "<div class='SHeaderDiv'>{SHEADERDIVCONTENT}</div>";
        var SHeaderLbl = "<label class='SHeaderLbl'>{SHEADERLBL}</label>";
        var SHeaderMultiSel = "<select id='{MULTISELCOMBO}' style='margin-right: 10px;width:250px' onchange='OnClickSelOption(this)'></select>";
        var SCKEditorDiv = "<div class='SCKEditoeDiv'>{SCKEDITORDIV}</div>";
        var SCKEditor = "<textarea id='" + CKEditorID + "' name='" + CKEditorID + "' style='width:740px;' rows='15' cols='40'></textarea>";
        //Header Div
        var RplSHeaderLbl = SHeaderLbl.replace(/\{SHEADERLBL\}/g, (MainData[i].NAME));
        var RplSHeaderMultiSel = SHeaderMultiSel.replace(/\{SMULTISELTXTID\}/g, (MultiSelID)).replace(/\{MULTISELCOMBO\}/g, (MultiSelDivID));
        var RplSHeaderDiv = SHeaderDiv.replace(/\{SHEADERDIVCONTENT\}/g, (RplSHeaderLbl + RplSHeaderMultiSel));
        //CKEditor Div
        var RplSCKEditorDiv = SCKEditorDiv.replace(/\{SCKEDITORDIV\}/g, (SCKEditor));
        //Final Append Div
        var RplSMainDiv = SMainDiv.replace(/\{SMAINDIVCONTENT\}/g, (RplSHeaderDiv + RplSCKEditorDiv));
        $("#" + MainDivId).append(RplSMainDiv);
        BindMultiSelectDropDown(MainData[i].CODE);
        if ($('#rbtnPending')[0].checked != true || MainData[i].SUBDATAYN == "N")
            $("#" + MultiSelDivID).css('display', 'none');
        $("#" + MultiSelDivID).select2();
        CKEDITOR.replace(CKEditorID, {
            uiColor: '#CCEAEE',
            tool: 'full',
            filebrowserImageUploadUrl: 'UploadImage',
            uploadUrl: '../LabTransaction/DragUploadImage',
            extraPlugins: 'uploadimage,RNCTEMPLATETRAN,autogrow,customEventPlugin',
            font_defaultLabel: defckFontFamily, 
            fontSize_defaultLabel: defckFontSize,
            autoGrow_onStartup: true,
            autoGrow_minHeight: 10,
            allowedContent: true,
            title: (MainData[i].NAME + " Template"),
            removePlugins: 'elementspath,resize',
            indent: false,
            breakBeforeOpen: true,
            breakAfterOpen: false,
            breakBeforeClose: false,
            breakAfterClose: true,
            language: 'en',
            contentsCss: [
                CKEDITOR.basePath + 'contents.css',
                CKEDITOR.basePath + 'pastefromword.css',
                     'data:text/css;charset=utf-8,' + encodeURIComponent(
                      'body {font-family: ' + defckFontFamily + ' !important;font-size: ' + defckFontSize + ' !important;}' +
                      'p {font-family: ' + defckFontFamily + ' !important;font-size: ' + defckFontSize + ' !important;}'
                      )
            ],
            removeButtons: 'PageBreak,Source,CopyFormatting,Save,Print,Anchor,Smiley,ExportPdf,Form,Checkbox,Radio,TextField,Select,Textarea,Button,ImageButton,HiddenField,NewPage,CreateDiv,Flash,Iframe,About,ShowBlocks,Preview',
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
            maxLength: 12,
            resize_enabled: false,
            bodyClass: 'document-editor',
            on: {
                fileUploadResponse: function (evt) {
                    var fileLoader = evt.data.fileLoader;
                    var file = fileLoader.file;
                    if (file) {
                        var reader = new FileReader();
                        reader.onload = function (event) {
                            var base64Image = event.target.result;
                            var imgTag = '<img style="width:' + SetImgWidthInEditor + 'px;height:' + SetImgHeigthInEditor + 'px" src="' + base64Image + '" />';
                            evt.editor.insertHtml(imgTag);
                        };
                        reader.readAsDataURL(file);
                    } else {
                        console.log("No file found in fileLoader.");
                    }
                },
                instanceReady: function (evt) {
                    $('.cke_toolbox').css('display', 'none');
                    var editor = evt.editor;
                    editor.document.$.documentElement.style.overflow = 'hidden';
                    var CKEditorID = "HtmlTemplate_" + (MainData[i].CODE);
                    if ($('#rbtnPending')[0].checked == true) {
                        var ValueText = unescape(MainData[i].DEFVALUE);
                        var data = "";
                        if (MainData[i].ISRESULT == "Y") {
                            ValueText = BindMachineData(ValueText);
                        }
                        data = '<p style="font-family:  ' + defckFontFamily + '; font-size:  ' + defckFontSize + ';">' + ValueText + '</p>';
                        var htmlContent = data.replace(/\n/g, "<br>");
                        evt.editor.once('dataReady', function () {
                            var editor = evt.editor;
                            editor.document.$.documentElement.style.overflow = 'hidden';
                            var body = evt.editor.document.getBody();
                            if (body.hasClass('document-editor')) {
                            }
                            TemplateHelper(evt.editor);
                            HideShowToolbar(evt.editor, "");
                            ConcatSectionTemplateData();
                        });
                        CKEDITOR.instances[CKEditorID].setData(htmlContent);
                    }
                    else {
                        var data = MainData[i].VALUE == "" ? '<p style="font-family:  ' + defckFontFamily + '; font-size:  ' + defckFontSize + ';">&nbsp;</p>' : unescape(MainData[i].VALUE);
                        evt.editor.once('dataReady', function () {
                            SettingDataFlag = true;
                            var editor = evt.editor;
                            editor.document.$.documentElement.style.overflow = 'hidden';
                            var body = evt.editor.document.getBody();
                            if (body.hasClass('document-editor')) {
                            }
                            TemplateHelper(evt.editor);
                            HideShowToolbar(evt.editor, "");
                        });
                        CKEDITOR.instances[CKEditorID].setData(data, {
                            callback: function () {
                                SettingDataFlag = false;
                            }
                        });
                    }
                    evt.editor.pasteFilter.disabled = false;
                    EnableDisableMultiCKEditor(DiasbleFlag);
                    editor.setData('<p style="font-family:  ' + defckFontFamily + '; font-size:  ' + defckFontSize + ';">&nbsp;</p>');
                    // Optional: Enforce typing in styled block
                    editor.on('key', function () {
                        const selection = editor.getSelection();
                        const element = selection && selection.getStartElement();
                        if (element && element.getName() === 'p') {
                            element.setStyle('font-family', defckFontFamily);
                            element.setStyle('font-size', defckFontSize);
                        }
                    });
                    //end
                },
                change: function (evt) {
                    if (!SettingDataFlag) {
                        ConcatSectionTemplateData();
                    }
                }
            }
        });
        $('.cke_toolbox').css('display', 'none');
    }
}

//Show All Multi Selection Combo
function ShowMultiSelCombo() {
    for (var i = 0; i < MultiTempData.length; i++) {
        if (MultiTempData[i].SUBDATAYN == "Y") {
            var MultiSelDivID = "s2id_HtmlTemplateMultiDiv_" + (MultiTempData[i].CODE);
            $("#" + MultiSelDivID).css('display', '');
        }
    }
}

//Function To Event Trigger
function TriggerCKEditorEvent(editor) {
    var editable = editor.editable();
    ['click', 'keyup', 'focus', 'keypress', 'keydown'].forEach(function (eventType) {
        editable.attachListener(editable, eventType, function (evt) {
            if (
                document.getElementById('rbtnPending') &&
                document.getElementById('rbtnPending').checked === true ||
                (document.getElementById('rbtnPending') &&
                 document.getElementById('rbtnPending').checked !== true &&
                 document.getElementById('btnTSave') &&
                 document.getElementById('btnTSave').value !== 'Change')
            ) {
                var ckeToolboxElements = document.getElementsByClassName('cke_toolbox');
                for (var i = 0; i < ckeToolboxElements.length; i++) {
                    ckeToolboxElements[i].style.display = 'none';
                }
                var ckeToolboxCollapsers = document.getElementsByClassName('cke_toolbox_collapser');
                for (var j = 0; j < ckeToolboxCollapsers.length; j++) {
                    ckeToolboxCollapsers[j].style.display = 'none';
                }
                var toolBarDiv = editor.container.findOne('.cke_toolbox');
                if (toolBarDiv) {
                    document.getElementById(toolBarDiv.getId()).style.display = 'block';
                }
            }
            if (!editor.readOnly) {
                ConcatSectionTemplateData();
            }
        });
    });
}

//Hide Show Toolbar in CKEditor
function HideShowToolbar(editor, SelYN) {
    if (SelYN == "Y") {
        editor.on('contentDom', function () {
            TriggerCKEditorEvent(editor);
        });
    }
    else {
        TriggerCKEditorEvent(editor);
    }
    editor.on('change', function () {
        if (!SettingDataFlag) {
            ConcatSectionTemplateData();
        }
    });
}

//Hide Show Toolbar in CKEditor For the other ck editor General Ckeditor 
function HideShowToolbarForOtherEditors(editor) {
    var editable = editor.editable();
    ['click', 'paste', 'keyup', 'focus'].forEach(function (eventType) {
        editable.attachListener(editable, eventType, function () {
            $('.cke_toolbox').css('display', 'none');
            $(".cke_toolbox_collapser").css('display', 'none');
            var toolBarDiv = editor.container.findOne('.cke_toolbox');
            if (toolBarDiv) {
                document.getElementById(toolBarDiv.getId()).style.display = "block";
            }
        });
    });
}

//Show Multi Select DropDown
function BindMultiSelectDropDown(MCode) {
    var MultiSelDivID = "HtmlTemplateMultiDiv_" + (MCode);
    var FilterData = FilterDropDownData(MCode, "");
    var SOpt = "<option value='{OPTVALUE}'>{OPTLABEL}</option>";
    var AllOptions = "<option value=''>---Select---</option>";
    $("#" + MultiSelDivID).empty();
    $.grep(FilterData, function (e) {
        var ChkBoxId = "Sel_" + MCode + "_" + e.CODE;
        var RplSOpt = SOpt.replace(/\{OPTVALUE\}/g, (e.CODE)).replace(/\{OPTLABEL\}/g, (e.NAME));
        AllOptions = AllOptions + RplSOpt;
    })
    $("#" + MultiSelDivID).append(AllOptions);
}

//Filter MultiSelect DropDown
function FilterDropDownData(MainCode, SubCode) {
    var TempSubDT = JSON.parse(JSON.stringify(SubTempData));
    var TempDt = [];
    if (SubCode == "") {
        $.grep(TempSubDT, function (e) {
            if (e.MCODE == MainCode)
                TempDt.push(e);
        })
    }
    else {
        $.grep(TempSubDT, function (e) {
            if (e.CODE == SubCode && e.MCODE == MainCode)
                TempDt.push(e);
        })
    }
    return TempDt;
}

//Onclick Selection Event
function OnClickSelOption(Event) {
    SettingDataFlag = false;
    var Br = "<br>";
    var Id = Event.id;
    var MainCode = Id.split('_')[1];
    var SubCode = $("#" + Id).val();
    var FData = FilterDropDownData(MainCode, SubCode);
    var CKEditorID = "HtmlTemplate_" + (MainCode);
    var ExistsData = CKEDITOR.instances[CKEditorID].getData();
    var SelValue = unescape(FData[0].VALUE);
    var Content = ExistsData + SelValue;
    CKEDITOR.instances[CKEditorID].setData(Content);
    TemplateHelper(CKEDITOR.instances[CKEditorID]);
    HideShowToolbar(CKEDITOR.instances[CKEditorID], "Y");
    $('.cke_toolbox').css('display', 'none');
    var toolBarDiv = CKEDITOR.instances[CKEditorID].container.findOne('.cke_toolbox');
    if (toolBarDiv) {
        $(".cke_toolbox_collapser").css('display', 'none');
        document.getElementById(toolBarDiv.getId()).style.display = "block";
    }
    var MultiSelDivID = "s2id_" + Id;
    $("#" + MultiSelDivID).select2('val', '');
    $("#" + Id).val('');
}

//Enable Disable the Multi CKEditor
function EnableDisableMultiCKEditor(Flag) {
    $.grep(MultiTempData, function (e) {
        var CKEditorID = "HtmlTemplate_" + (e.CODE);
        CKEDITOR.instances[CKEditorID].setReadOnly(Flag);
    })
}

//For Concat All Section Data
function ConcatSectionTemplateData() {
    var Br = "<br>";
    var SiteData = "";
    var TConcatData = "";
    var IConcatData = ConcatImpValue();
    if ($("#chkSynoptic").prop("checked") == true) {
        TConcatData = "";
        IConcatData = "";
        SiteData = ConcatSiteData();
    }
    else {
        TConcatData = ConcatTempValue();
        SiteData = "";
    }
    var AllTempData = TConcatData == "" ? SiteData : TConcatData + (SiteData == "" ? "" : Br + SiteData);
    CKEDITOR.instances.HtmlTemplate.setData(AllTempData);
    CKEDITOR.instances.HtmlImpressionTemplate.setData(IConcatData);
}

function ConcatTempValue() {
    var TConcatData = "";
    var Br = "<p><br></p>";
    var PTag = ConfigFontSize == "" ? "<p><strong><u>{CONCATLABEL}</u></strong></p>" : "<p style='font-size:" + ConfigFontSize + "'><strong><u>{CONCATLABEL}</u></strong></p>";
    $.grep(MultiTempData, function (e) {
        var CKEditorID = "HtmlTemplate_" + (e.CODE);
        var SData = CKEDITOR.instances[CKEditorID].getData().trim();
        if (SData != "") {
            var RplConcatLbl = e.NAME.trim() == "" ? "" : PTag.replace(/\{CONCATLABEL\}/g, (e.NAME + " : "));
            TConcatData = TConcatData == "" ? (RplConcatLbl == "" ? SData : RplConcatLbl + Br + SData) : TConcatData + Br + RplConcatLbl + Br + SData;
        }
    });
    return TConcatData;
}

function ConcatImpValue() {
    var IConcatData = "";
    var Br = "<p><br></p>";
    var PTag = ConfigFontSize == "" ? "<p><strong><u>{CONCATLABEL}</u></strong></p>" : "<p style='font-size:" + ConfigFontSize + "'><strong><u>{CONCATLABEL}</u></strong></p>";
    $.grep(MultiTempData, function (e) {
        var CKEditorID = "HtmlTemplate_" + (e.CODE);
        var SData = CKEDITOR.instances[CKEditorID].getData().trim();
        if (SData != "") {
            var RplConcatLbl = e.NAME.trim() == "" ? "" : PTag.replace(/\{CONCATLABEL\}/g, (e.NAME + " : "));
            if (e.ISIMPRESSION == "Y") {
                IConcatData = IConcatData == "" ? (RplConcatLbl == "" ? SData : RplConcatLbl + Br + SData) : IConcatData + Br + RplConcatLbl + Br + SData;
            }
        }
    });
    return IConcatData;
}

//For Save Pass Multi CKEditor Values
function GetSaveDynamicCKEditorValue(postData) {
    var TempData = JSON.parse(JSON.stringify(MultiTempData));
    var MandMsg = "";
    $.grep(TempData, function (e) {
        var CKEditorID = "HtmlTemplate_" + (e.CODE);
        if (MandMsg == "") {
            if (e.MANDTYN == "Y" && CKEDITOR.instances[CKEditorID].getData().trim() == "") {
                MandMsg = "Please Enter Data for " + e.NAME;
            }
            else {
                e.VALUE = escape(CKEDITOR.instances[CKEditorID].getData());
                e.RESULTNO = $("#txtTResultNo").val();
            }
        }
    })
    if (MandMsg != "") {
        MsgDia(MandMsg, "Information");
        return false;
    }
    postData.push({ name: 'MultiTemplate', value: JSON.stringify(TempData) });
    if (TIsFileUploaded == false && $('#txtTMarkAsDone')[0].checked == false && (CKEDITOR.instances['HtmlTemplate'].getData().trim().replace(/<[^>]*>/gi, '').trim().length == 0 || CKEDITOR.instances.HtmlTemplate.getData().trim().length == 0)) {
        MsgDia("Template data is blank please wait or check the template tab data.", "Information");
        return false;
    }
    else {
        //postData.push({ name: 'TempData', value: encodeURIComponent(CKEDITOR.instances.HtmlTemplate.document.getDocumentElement().getHtml()) });
        postData.push({ name: 'TempData', value: CKEDITOR.instances.HtmlTemplate.getData().trim() != "" ? encodeURIComponent(CKEDITOR.instances.HtmlTemplate.document.getDocumentElement().getHtml()) : "" }); //Added by priyanka on 18/07/2025
    }
    postData.push({
        name: 'ImpressionData', value: CKEDITOR.instances.HtmlImpressionTemplate.getData().trim() != "" ?
            encodeURIComponent(CKEDITOR.instances.HtmlImpressionTemplate.document.getDocumentElement().getHtml()) : ""
    });

    return true;
}

//Added By Rajan - For Bind the Machine Data
function BindMachineData(DefaultValue) {
    var MachineGridIds = $('#tblMachineData').getDataIDs();
    var FValue = "";
    var PositiveFlag = false;
    $.grep(MachineGridIds, function (e) {
        var RowData = $('#tblMachineData').getRowData(e);
        if (!RowData.INVESTCODE.toUpperCase().trim().includes(CompareText)) {
            var InvstLbl = "<span style='font-weight: bold;font-size:" + ConfigFontSize + ";'>" + RowData.INVESTCODE.trim() + "</span>";
            var Separtor = "<span style='font-weight: bold;font-size:" + ConfigFontSize + ";'>&nbsp;:&nbsp;</span>";
            var ResultValue = "<span style='font-size:" + ConfigFontSize + ";'>" + RowData.RESULT.trim() + "</span>";
            if (RowData.RESULT.toUpperCase().toString().trim().includes("POSITIVE")) {
                PositiveFlag = true;
                ResultValue = "<span style='font-weight: bold;font-size:" + ConfigFontSize + ";'>" + RowData.RESULT.trim() + "</span>";
            }
            FValue = FValue + ("<p style='width:50%;display:inline-block;'>" + InvstLbl + Separtor + ResultValue + "</p>");
        }
    });
    var DefValue = "";
    if (DefaultValue.toUpperCase().trim().includes(CompareText)) {
        var SplitDef = DefaultValue.split(CompareText);
        var DetectOrNot = PositiveFlag == true ? "DETECTED" : "NOT DETECTED";
        var DefStyle = 'style="font-family:  ' + defckFontFamily + '; font-size:  ' + defckFontSize + ';"';
        var Detect = '<p ' + DefStyle + '><strong ' + DefStyle + '><u ' + DefStyle + '>' + CompareText + '</u> : </strong>&nbsp;&nbsp;&nbsp;<strong ' + DefStyle + '>' + DetectOrNot + '</strong></p>';
        var RemainValue = "";
        if (SplitDef.length > 1) {
            RemainValue = '<p ' + DefStyle + '><u ' + DefStyle + '>' + '<strong ' + DefStyle + '>' + SplitDef[1] + '</u></strong></p>';
        }
        DefValue = Detect + RemainValue;
    }
    else {
        DefValue = DefaultValue
    }
    FValue = DefValue + "<br>" + FValue;
    return FValue;
}