<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.AppSettingConfigMdl>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<style>
.appsetlabel
{
      font-family:Verdana,Geneva,sans-serif;
    font-size: 11.4px;
    padding-left:2px;
    text-shadow:0px 0px 0px #0c0c0c;
}
 .ComboFormat
 {
    font-size: 12px;
    height: 20px;
    text-shadow: 0.65px 0 0 #006d88;
    color: #025f76;
 }
 .canvas-container {
   position: relative;
   width: 90%;
   height: 350px;
   border: 1px solid #ccc;
   overflow: auto;
   margin-left: 5%;
}

.canvas-container canvas {
   position: absolute;
   display: block;
} 



</style>
     <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
<script>
    <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer() { MaxJsonLength = 2147483647 }; %>
    var ImageLst = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(ViewBag.varImgLst))%>));
    var ModuleLst = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(ViewBag.ModuleLst))%>));
        var Action = '';
        <%--  var ExcelYN = '<%:Model.ExcelYN%>';--%>
    var ExcelYN = '';
    $(document).ready(function () {
        var userId = '<%: ("" + Session["gOncoUserId"]).ToString().Trim()%>';
        if (userId.toUpperCase() == "SYSTEM") {
            $("#rbtnApp").prop("checked", true);
            DisplayInfoGrids();
            WebConfig();
            $('#btnExcel').click(function () {
                ////debugger;
                data = $("#GvWebConfig").jqGrid('getGridParam', 'data');
                if (data.length > 0) {
                    data = JSON.stringify(data);
                    var datatosend = { data: data };
                    PrintExcelCommon('../Account/PrintExcelWebConfigListData', datatosend, false, '../Account/DisplayExcelWebConfigList', true);
                }
                else {
                    $.messager.alert("No Data For Send To Excel.", "Information");
                }
            });
        }
        else {
            $.messager.alert("Invalid UserID", "Information");
            return false;
        }

        BindResolution();
        var cWidth = $(".content").width();
        var cHeight = $(".content").height();
        $("#GvWebConfig").jqGrid("setGridWidth", cWidth - 5, true);
        $("#GvWebConfig").jqGrid("setGridHeight", cHeight - 20, true);
        $("#btnTrandiv").fancybox({
            openEffect: 'elastic',
            openSpeed: 100,
            closeEffect: 'elastic',
            closeSpeed: 100,
            helpers: {
                overlay: { closeClick: false }
            },
            autoDimensions: false,
            cyclic: true,
            showNavArrows: true
        });
        ////debugger;
        $("#btnTrandiv1").fancybox({
            
            openEffect: 'elastic',
            openSpeed: 100,
            closeEffect: 'elastic',
            closeSpeed: 100,
            helpers: {
                overlay: { closeClick: false }
            },
            autoDimensions: false,
            cyclic: true,
            showNavArrows: true
        });
        $('#lnkNew').click(function (e) {
            BindRowData("N");
            $("a#btnTrandiv1").click();
        });
        $("#txtTime").timepicker({
            changeHour: true,
            changeMinute: true,
            changeSecond: true,
            timeFormat: "HH:mm",
        });
        $("#txtDate").datepicker({
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            maxDate: new Date()
        });

        
    });
    //AppSettingConfig section start
    function WebConfig() {
        ////debugger;
        document.getElementById("DivAllImageSetting").style.display = "none";
        document.getElementById("DivAllDBSetting").style.display = "none";
        document.getElementById("DivSave").style.display = "none";
        document.getElementById("DivAllWebConfig").style.display = "block";
        document.getElementById("btnExcel").style.display = "inline-block";
        document.getElementById("lnkNew").style.display = "inline-block";
        document.getElementById("getWebConfigInfo").style.display = "inline-block";
        DisplayInfoGrids();
        BindAppConfig();
    }
    function BindAppConfig() {
        ////debugger;
        $("#GvWebConfig  input[type='text']").val("");
        $.ajax({
            type: "Post",
            url: '../Account/GetWebConfig',
            async: false,
            success: function (response) {
                var Grid = JSON.parse(response);
                if (Grid.length > 0) {
                    $('#GvWebConfig').jqGrid('setGridParam', {
                        data: Grid
                    }).trigger("reloadGrid");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $.messager.alert(textStatus, "Error");
            }
        });
    }
    function BindResolution() {
        ////debugger;
        document.getElementById("lblFileRes").style.display = "none";
        if ($("#cmbImageList").val() != "") {
            var grepdata = $.grep(ImageLst, function (e) { return e.Value == $("#cmbImageList").val() });
            document.getElementById("lblFileRes").style.display = "inline-block";
            document.getElementById("lblFileRes").innerText = "* Suggested File Resolution " + grepdata[0].Resolution + (grepdata[0].FileName == "XML" ? "" : (" (" + grepdata[0].FileName + "." + grepdata[0].FileFormat + ")"));
        }
    }
    function DisplayInfoGrids() {
        colnames = ['Key', 'Description', 'Value', 'Module', 'Form Name', 'Previous Value', 'Created By', 'Created Date / Time'],
        $("#GvWebConfig").jqGrid('getGridParam');
        jQuery("#GvWebConfig").jqGrid({
            datatype: 'local',
            colNames: colnames,
            colModel: [
            {
                name: 'KEY',
                index: 'KEY',
                width: 200, editable: false
            },
                {
                    name: 'DESCRIPTION',
                    index: 'DESCRIPTION',
                    width: 400, editable: false
                },
             {
                 name: 'VALUE',
                 index: 'VALUE',
                 width: 200, editable: false
             },
             {
                 name: 'MODULE',
                 index: 'MODULE',
                 width: 150, editable: false
             },
             {
                 name: 'FORMNAME',
                 index: 'FORMNAME',
                 width: 150, editable: false
             },
             {
                 name: 'PREVVALUE',
                 index: 'PREVVALUE',
                 width: 200, editable: false, hidden: true
             },
             {
                 name: 'CREATEDBY',
                 index: 'CREATEDBY',
                 width: 150, editable: false
             },
             {
                 name: 'CREATEDONAT',
                 index: 'CREATEDONAT',
                 width: 180, editable: false
             }
            ],
            sortname: 'id',
            sortorder: "desc",
            shrinkToFit: false,
            cellEdit: true,
            cellsubmit: 'clientArray',
            loadonce: true,
            footerrow: false,
            rownumbers: true,
            rowNum: 99999999,
            ignoreCase: true,
            //scrollerbar: true,
            scroll:true,
            loadtext: 'Loading...',
            grouping: false,
            ondblClickRow: true,
            ondblClickRow: function (rowId) {
                var RowData = $('#GvWebConfig').jqGrid('getRowData', rowId);
                BindRowData("E", RowData);
                $("a#btnTrandiv1").click();
            },
            gridComplete: function () {
            },
            loadComplete: function () {
            }
        }).trigger("reloadGrid");
        var cWidth = $(".content").width();
        var cHeight = $(".content").height();
        $("#GvWebConfig").jqGrid('filterToolbar', {
            searchOnEnter: false,
            ignoreCase: true,
            searchOperators: false,
            defaultSearch: "cn",
            beforeSearch: function () { searchGDYN = "Y"; }
        });
        $("#GvWebConfig").jqGrid("setGridWidth", cWidth - 5, true);
        $("#GvWebConfig").jqGrid("setGridHeight", cHeight - 20, true);
    };
    function ClearFields() {
        $("#cmbModule").val("");
        $("#txtKey").val("");
        $("#txtValue").val("");
        $("#txtDesc").val("");
        $("#txtAddedBy").val("");
        $("#txtFormName").val("");
        $("#cmbModule").css("border-color", "");
        $("#txtKey").css("border-color", "");
        $("#txtFormName").css("border-color", "");
        $("#txtValue").css("border-color", "");
        $("#txtDesc").css("border-color", "");
        $("#txtAddedBy").css("border-color", "");
    }
    function BindRowData(Act, rowdata) {
        ////debugger;
        ClearFields();
        Action = Act;
        var textdesc = $("#txtDesc").val();
        document.getElementById("txtDesc").style.height = "150px";
        if (Act == "E") {
            document.getElementById('DivHeading').innerText = "Key - Edit";
            $("#cmbModule").val(GetModuleCode(rowdata.MODULE));
            $("#txtKey").val(rowdata.KEY);
            $("#txtValue").val(rowdata.VALUE);
            $("#txtDesc").val(rowdata.DESCRIPTION);
            $("#txtAddedBy").val(rowdata.CREATEDBY);
            $("#txtFormName").val(rowdata.FORMNAME);
            $('#txtKey').prop('readonly', true);
            if (rowdata.CREATEDBY == "")
                $('#txtAddedBy').prop('readonly', false);
            else
                $('#txtAddedBy').prop('readonly', true);

            $('#txtTime').prop('disabled', false);
            $('#txtDate').prop('disabled', false);
            $('#txtTime').timepicker('setTime', new Date());
            $('#txtTime').timepicker('hide');
            $('#txtDate').datepicker('setDate', 'today');
            $('#trDateTime').show();
            if (rowdata.CREATEDONAT.trim() != "") {
                var Splt = rowdata.CREATEDONAT.trim().split(' ');
                if (Splt.length > 1) {
                    $('#txtDate').val(Splt[0]);
                    $('#txtTime').val(Splt[1]);
                }
                $('#txtTime').prop('disabled', true);
                $('#txtDate').prop('disabled', true);
                $('#trDateTime').hide();
            }
        }
        else {
            document.getElementById('DivHeading').innerText = "Key - New";
            $('#txtKey').prop('readonly', false);
            $('#txtAddedBy').prop('readonly', false);
            $('#txtTime').prop('disabled', false);
            $('#txtDate').prop('disabled', false);
            $('#txtTime').timepicker('setTime', new Date());
            $('#txtTime').timepicker('hide');
            $('#txtDate').datepicker('setDate', 'today');
            $('#trDateTime').show();
        }
    }
    function MakeNormal(id) {
        if ($("#" + id).val() == "")
            $("#" + id).css("border-color", "Red");
        else
            $("#" + id).css("border-color", "");
    }
    function KeyValidation() {
        if ($("#cmbModule").val() == "") {
            $('#cmbModule').focus();
            $("#cmbModule").css("border-color", "Red");
            return false;
        }
        if ($("#txtFormName").val() == "") {
            $('#txtFormName').focus();
            $("#txtFormName").css("border-color", "Red");
            return false;
        }
        if ($("#txtKey").val() == "") {
            $('#txtKey').focus();
            $("#txtKey").css("border-color", "Red");
            return false;
        }
        //if ($("#txtValue").val() == "") {
        //    $('#txtValue').focus();
        //    $("#txtValue").css("border-color", "Red");
        //    return false;
        //}
        if ($("#txtAddedBy").val() == "") {
            $('#txtAddedBy').focus();
            $("#txtAddedBy").css("border-color", "Red");
            return false;
        }
        if ($("#txtDate").val() == "") {
            $('#txtDate').focus();
            $("#txtDate").css("border-color", "Red");
            return false;
        }
        if ($("#txtTime").val() == "") {
            $('#txtTime').focus();
            $("#txtTime").css("border-color", "Red");
            return false;
        }
        if ($("#txtDesc").val() == "") {
            $('#txtDesc').focus();
            $("#txtDesc").css("border-color", "Red");
            return false;
        }
        return true;
    }
    function SaveAction() {
        ////debugger;
        if (KeyValidation() == true) {
            var DataToSend = {
                Act: Action,
                Module: $("#cmbModule option:selected").text(),
                FormName: $("#txtFormName").val(),
                Key: $("#txtKey").val(),
                Value: $("#txtValue").val(),
                Description: $("#txtDesc").val(),
                CreatedBy: $("#txtAddedBy").val(),
                CreatedDtTm: $("#txtDate").val() + " " + $("#txtTime").val()
            }
            //ajaxindicatorstart('Processing..');
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: '../Account/SaveWebConfig',
                data: DataToSend,
                success: function (response) {
                    if (response == "Sucess") {
                        BindAppConfig();
                        jQuery.fancybox.close();
                    }
                    $.messager.alert(response, "information");
                    //ajaxindicatorstop();
                    HoldOn.close();//
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                    //ajaxindicatorstop();
                    HoldOn.close();//
                }
            });
        }
    }
    function RestrictSymbol() {
        var Values = $("#txtValue").val();
        Values = Values.replace(/!/g, '');
        $("#txtValue").val(Values);
    }
    function GetModuleCode(ModuleText) {
        var ModuleCode = "";
        $.grep(ModuleLst, function (e) {
            if (e.Text == ModuleText)
                ModuleCode = e.Value
        });
        return ModuleCode;
    }
    function GetWebConfigLogInfo() {
        ////debugger;
        $.ajax({
            type: "Post",
            url: '../Account/GetWebConfigLogInfo',
            async: false,
            success: function (response) {
                $("a#btnTrandiv").click();
                $("#txtLogInfo").val(response);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $.messager.alert(textStatus, "Error");
            }
        });
    }
    //AppSettingConfig Section End

    //Image Setting Section Start
    function ImageSetting() {
        ////debugger;
        document.getElementById("DivAllWebConfig").style.display = "none";
        document.getElementById("DivAllDBSetting").style.display = "none";
        document.getElementById("DivAllImageSetting").style.display = "block";
        document.getElementById("btnExcel").style.display = "none";
        document.getElementById("lnkNew").style.display = "none";
        document.getElementById("DivSave").style.display = "block";
        document.getElementById("getWebConfigInfo").style.display = "none";
    }

    function ChkImageType() {
        if ($("#cmbImageList").val() == "") {
            document.getElementById('txtFilePath').disabled = true;
        } else {
            $("#cmbImageList").css("border-color", "");
            document.getElementById('txtFilePath').value = "";
            document.getElementById('txtFilePath').disabled = false;
        }
    }
    function GetImage() {
        ////debugger;
        var FileName = "";
        if ($("#cmbImageList").val() != "") {
            var grepdata = $.grep(ImageLst, function (e) { return e.Value == $("#cmbImageList").val() });
            FileName = grepdata[0].FileName + "." + grepdata[0].FileFormat;
        }
        else {
            clearCanvas("SaveCanvas");
            clearCanvas("SaveCanvas");
            return false;
        }
        var DataToSend = {
            FileName: FileName
        };
        //ajaxindicatorstart('Processing..');
        HoldOn.open();
        $.ajax({
            type: "POST",
            url: '../Account/GetImage',
            data: DataToSend,
            success: function (data) {
                if (data.success) {
                    var imageDataUrl = data.imageDataUrl;
                    var canvas = document.getElementById('SaveCanvas');
                    var context = canvas.getContext('2d');
                    var img = new Image();
                    img.onload = function () {
                        // Set canvas size to image size
                        canvas.width = img.width;
                        canvas.height = img.height;
                        context.drawImage(img, 0, 0);
                    };
                    img.src = imageDataUrl;
                    clearCanvas("PrevCanvas");
                } else {
                    $.messager.alert(data.message, "Error");
                }
                HoldOn.close();
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $.messager.alert(textStatus, "Error");
                HoldOn.open();
            }
        });
    }
    function FileUploadType() {
        ////debugger;
        var greps = $.grep(ImageLst, function (e) { return e.Value == $("#cmbImageList").val() });
        var DefaultFileformat = greps[0].FileFormat;
        var InputFile = document.getElementById('txtFilePath');
        if (InputFile.files.length > 0) {
            var fileformat = InputFile.files[0].name.split('.').pop();
            if (fileformat != DefaultFileformat) {
                $.messager.alert("Please Select " + DefaultFileformat + " File Format", 'Information');
                document.getElementById('txtFilePath').value = "";
            }
        }
    }
    function ImageValidation() {
        if ($("#cmbImageList").val() == "") {
            $("#cmbImageList").css("border-color", "Red");
            return false;
        }
        if ($("#txtFilePath").val() == "") {
            $.messager.alert("Please Select File", 'Information');
            return false;
        }
        return true;
    }
    function PreviewImage() {
        ////debugger;
        var fileInput = document.getElementById('txtFilePath');
        var file = fileInput.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var img = new Image();
                img.onload = function () {
                    var canvas = document.getElementById('PrevCanvas');
                    var context = canvas.getContext('2d');
                    canvas.width = img.width;
                    canvas.height = img.height;
                    context.clearRect(0, 0, canvas.width, canvas.height);
                    context.drawImage(img, 0, 0);
                };
                img.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
    function clearCanvas(canvasId) {
        var canvas = document.getElementById(canvasId);
        var context = canvas.getContext('2d');
        context.clearRect(0, 0, canvas.width, canvas.height);
        canvas.width = "0";
        canvas.height = "0";
    }

    function SaveImageConfig() {
        var datatosend = {};
        var userId = '<%: ("" + Session["gOncoUserId"]).ToString().Trim()%>';
            var Urls = '';
            if (ImageValidation() == true) {
                var fileUpload = $("#txtFilePath").get(0);
                var files = fileUpload.files;
                var fileData = new FormData();
                var greps = $.grep(ImageLst, function (e) { return e.Value == $("#cmbImageList").val() });
                var DefaultFileName = greps[0].FileName + "." + greps[0].FileFormat;
                var datatosend = new FormData();
                datatosend.append(files[0].name, files[0])
                datatosend.append('ImageKeyCD', $("#cmbImageList").val());
                datatosend.append('Filepath', DefaultFileName);
                datatosend.append('RFileName', $("#txtFileName").val());
                if (userId.toUpperCase() == "SYSTEM") {
                    $.ajax({
                        type: "POST",
                        url: '../Account/SaveImageSetting',
                        contentType: false,
                        processData: false,
                        data: datatosend,
                        success: function (response) {
                            $.messager.alert(response, "information");
                            ClearAllImageField();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $.messager.alert(textStatus, "Error");
                        }
                    });
                }
                else {
                    $.messager.alert("Invalid UserID", "Information");
                    return false;
                }
            }
    }
    function ClearAllImageField() {
        $("#cmbImageList").val("");
        $("#txtFilePath").val("");
        document.getElementById("lblFileRes").innerText = "";
        clearCanvas("PrevCanvas");
        clearCanvas("SaveCanvas");
    }
    //Image Setting Section End
</script>
    <link href="../Content/jquery-ui-timepicker-addon.css" rel="stylesheet" />
    <script src="../js/jquery-ui-timepicker-addon.js"></script>
    <%--end--%><script src="../js/jquery-ui-timepicker-addon.js"></script>
    <script src="../Scripts/PatList.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="WebConfig" action="#" method="post">
        <div class="HeadDiv" style="border: 2px; width: 99.8%;">
        <span style="display: inline-block; line-height: 19px;" id="FormHeader">Application Setting</span> 
        <div class="seprateDiv" style="margin-right: 27px;"><a id="btnExcel" href="#"><div title="Send To Excel" class="btnExcel"></div></a></div>
        <div id="lnkNew" style="margin-right: 15px;margin-top: 2px;" title="New" class="btnNew"></div>
    </div>

    <div>
            <fieldset class="AppSettingfieldset">
                <table style="width:100%">
                    <tr>
                       <td style="width:15%">
                           <input id="rbtnApp" name="Status" type="radio" value="true" onclick="WebConfig()" />
                           <label>App Setting</label>
                       </td>
                       <td>
                           <input id="rbtnImg" name="Status" type="radio" value="False" onclick="ImageSetting()" />
                           <label>Image Setting</label>
                       </td>
                        <td>
                            <a href="#" id="getWebConfigInfo" onclick="GetWebConfigLogInfo()" style="margin-left: 70%;zoom: 1.5;" class="ui-icon ui-icon-info GetTansInfo" title="Get Web Config Info"></a>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>



    <div id="DivAllImageSetting" style="display:none;">
            <fieldset>
                <table style="width:100%">
                    <tr>
                        <td style="width:50%"> 
                <label style="margin-left: 10px;width: 80px;display: inline-block;"> Image List</label>
                           <%:Html.DropDownListFor(x => Model.ImageKeyCD, new SelectList(Model.ImageList, "Value", "Text"),"---Select---",  new { id = "cmbImageList", @class = "ComboFormat", style = "width:180px",onchange="BindResolution();ChkImageType();GetImage()"})%>
                <label id="lblFileRes" style="margin-left: 10px;display: inline-block;margin-right: 30px;width: auto;color: red;font-style: italic;">* Suggested File Resolution </label>
                        </td>
                        <td>
                <label style="margin-left: 10px;width: 80px;display: inline-block;"> File Path</label>
                          <input type="file" id="txtFilePath" style="margin-top: 5px; margin-bottom: 5px;margin-left:10px;width:350px;" accept="image/*" onchange="FileUploadType();PreviewImage()" disabled >

                        </td>
                    </tr>
                </table>
            </fieldset>
         <table style="width:100%">
             <tr>
                 <td style="width:50%">
                     <div class="panel-heading" style="text-align:center">
                         <span>Present</span>
                     </div>
                      <div class="canvas-container" style="overflow: auto;">
                         <canvas id="SaveCanvas"></canvas>
                      </div>
                 </td>
                 <td>
                     <div class="panel-heading" style="text-align:center">
                         <span>Preview</span>
                     </div>
                      <div class="canvas-container" style="overflow: auto;">
                         <canvas id="PrevCanvas" ></canvas>
                      </div>
                 </td>
             </tr>
         </table>
         <div style="width:100%;display:inline-block">

         </div>
        
     </div>

    <div id="DivAllWebConfig" style="display:block">
            <fieldset>
                <div id="divgrid">
                    <table id="GvWebConfig">
                    </table>
                </div>
            </fieldset>
     </div>

     <div id="DivAllDBSetting" style="display:none;">
            <fieldset>

            </fieldset>
     </div>

    <div style="text-align: center;margin-top:15px;" id="DivSave">
                    <input type="button" class="Nbutton"  id="btnSave" value="Save" style="background-color: rgb(57, 142, 189); height: 27px; width: 60px; border-radius: 10px 10px 10px 10px; font-weight: bold; font-size: 12px; color: white"onclick="SaveImageConfig()" />
    </div>

    <div id="divTran" style="display: none; width: 800px; height: 250px;">
        <a href="#divTran" id="btnTrandiv"></a>

        <div class="panel-heading">
            <label>WebConfig Log Info</label>
        </div>
        <div>
            <textarea id="txtLogInfo" disabled="disabled" style="width: 98%;height: 215px;"></textarea>
        </div>
    </div>

    <div id="divTran1" style="display: none; width: 400px; height: auto;">
        <a href="#divTran1" id="btnTrandiv1"></a>

        <div class="panel-heading">
            <label id="DivHeading">Key - New</label>
        </div>
        <div style="width:100%">
            <table style="width:100%">
                <tr>
                    <td style="width:20%">
                        <label>Module</label>
                    </td>
                    <td>
                       <%:Html.DropDownListFor(x => Model.ModuleCD, new SelectList(Model.Module, "Value", "Text"),"---Select---",  new { id = "cmbModule", @class = "ComboFormat Mandatory", style = "width:100%;margin-top:2%;",onchange="MakeNormal(this.id)"})%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Form Name</label>
                    </td>
                    <td>
                        <input type="text" id="txtFormName" class="Mandatory"  onchange="MakeNormal(this.id)" style="width:97%;border: 2px solid #c1c1c1;margin-top:1%;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Key</label>
                    </td>
                    <td>
                        <input type="text" id="txtKey" class="Mandatory"  onchange="MakeNormal(this.id)" style="width:97%;border: 2px solid #c1c1c1;margin-top:1%;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Value</label>
                    </td>
                    <td>
                        <input type="text" id="txtValue" onkeyup="RestrictSymbol()" class="Mandatory"  onchange="MakeNormal(this.id)" style="width:97%;border: 2px solid #c1c1c1;margin-top:1%;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Created By</label>
                    </td>
                    <td>
                        <input type="text" id="txtAddedBy" class="Mandatory"  onchange="MakeNormal(this.id)" style="width:97%;border: 2px solid #c1c1c1;margin-top:1%;" />
                    </td>
                </tr>
                <tr id="trDateTime">
                    <td>
                        <label>Date</label>
                    </td>
                    <td>
                        <input type="text" id="txtDate" class="Mandatory"  onchange="MakeNormal(this.id)" readonly="readonly" style="width:35%;border: 2px solid #c1c1c1;margin-top:1%;" />
                        <label style="width:10%;display:inline-block;margin-left:5%">Time</label>
                        <input type="text" id="txtTime" class="Mandatory" onchange="MakeNormal(this.id)" readonly="readonly" style="margin-left:5%;width:35%;border: 2px solid #c1c1c1;margin-top:1%;" />
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: super;">
                        <label>Description</label>
                    </td>
                    <td>
                        <textarea  id="txtDesc" class="Mandatory"  onchange="MakeNormal(this.id)" style="resize: vertical;height:150px;width:97%;border: 2px solid #c1c1c1;margin-top:1%;" ></textarea>
                    </td>
                </tr>
            </table>
            <div class="buttonDiv" align="center">
               <input type="button" id="btn" class="Nbutton" style="background-color: rgb(57, 142, 189); height: 27px; width: 80px; border-radius: 10px 10px 10px 10px; font-weight: bold; font-size: 12px; color: white" value="Save" onclick="SaveAction();" />
            </div>
        </div>
                </div>

    </form>
</asp:Content>
