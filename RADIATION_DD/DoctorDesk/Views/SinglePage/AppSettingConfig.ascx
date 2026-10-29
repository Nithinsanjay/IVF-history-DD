<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.AppSettingConfigMdl>" %>

<style>

    .panel-heading {
        background-color: #0b4f7d;
        color: white;
        padding: 10px 15px;
        border-top-left-radius: 5px;
        border-top-right-radius: 5px;
        font-weight: bold;
    }

    .EModal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        width: 100vw;
        height: 100vh;
        background-color: rgba(0,0,0,0.5);
        justify-content: center;
        align-items: center;
    }

    .modal-content {
        padding: 5px;
    }



    .EModal .modal-content {
        background-color: white;
        width: 710px;
        max-width: 90%;
        margin: auto;
        border-radius: 5px;
        overflow: hidden;
        padding: 5px;
    }
   
        .EModal1 {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        width: 100vw;
        height: 100vh;
        background-color: rgba(0,0,0,0.5);
        justify-content: center;
        align-items: center;
    }
    .modal-content1 {
        padding: 5px;
        height: 602px;
    }


    .EModal1 .modal-content1 {
        background-color: white;
        width: 898px;
        max-width: 90%;
        margin: auto;
        border-radius: 5px;
        overflow: hidden;
        padding: 5px;
    }
    

    .appsetlabel {
        font-family: Verdana,Geneva,sans-serif;
        font-size: 11.4px;
        padding-left: 2px;
        text-shadow: 0px 0px 0px #0c0c0c;
    }

    .ComboFormat {
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


<link href="../Content/jquery-ui-timepicker-addon.css" rel="stylesheet" />
<script src="../js/jquery-ui-timepicker-addon.js"></script>

<%--<script src="../Scripts/PatList.js"></script>--%>
<script>

      <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer() { MaxJsonLength = 2147483647 }; %>
    var ImageLst = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(ViewBag.varImgLst))%>));
    var ModuleLst = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(ViewBag.ModuleLst))%>));

    var GvWebConfigTable;
    $(document).ready(function () {
        WebConfig();
        document.getElementById("DivSave").style.display = "none";

        BindResolution();
        var cWidth = $(".content").width();
        var cHeight = $(".content").height();

        $('#lnkNew').click(function (e) {
            BindRowData("N");
            document.getElementById("divTran1").style.display = "flex";
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
        $("#GvWebConfig").empty();

        document.getElementById("DivAllImageSetting").style.display = "none";
        document.getElementById("DivAllDBSetting").style.display = "none";
        document.getElementById("DivSave").style.display = "none";
        document.getElementById("DivAllWebConfig").style.display = "block";
        document.getElementById("btnExcel").style.display = "inline-block";
        document.getElementById("lnkNew").style.display = "inline-block";
        document.getElementById("getWebConfigInfo").style.display = "inline-block";
       
        BindAppConfig();
    }
    function LoadDisplayInfoGrids(tableData) {
        if (GvWebConfigTable) {
            GvWebConfigTable.destroy();
            GvWebConfigTable = null;
        }
        GvWebConfigTable = new Tabulator("#GvWebConfig", {
            data: tableData,
            height: "500px",
            layout: "fitColumns",
            columns: [
                { title: "Key", field: "KEY", width: 200 },
                { title: "Description", field: "DESCRIPTION", width: 400 },
                { title: "Value", field: "VALUE", width: 200 },
                { title: "Module", field: "MODULE", width: 150 },
                { title: "Form Name", field: "FORMNAME", width: 150 },
                { title: "Previous Value", field: "PREVVALUE", visible: false },
                { title: "Created By", field: "CREATEDBY", width: 150 },
                { title: "Created Date / Time", field: "CREATEDONAT", width: 180 }
            ],
        });
        GvWebConfigTable.on("rowDblClick", function (e, row) {
            var RowData = row.getData(); // same as jqGrid getRowData

            BindRowData("E", RowData);
            document.getElementById("divTran1").style.display = "flex";
        });
    }


    function BindAppConfig() {
        $.ajax({
            type: "Post",
            url: '../Account/GetWebConfig',
            async: false,
            success: function (response) {
                var Grid = JSON.parse(response);
                if (Grid.length > 0) {
                    LoadDisplayInfoGrids(Grid);
                } else {
                    LoadDisplayInfoGrids([]);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                /* $.messager.alert(textStatus, "Error");*/
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

    function GetHeightOfSchemeApprovalStatusGrid() {

        var FilterHeadHeight = document.getElementById("DivAppsettingHeader").offsetHeight;
        var ContHeight = document.getElementById("Hist_M_AppSettingConfig").offsetHeight;
        var FHeight = ContHeight - FilterHeadHeight - 60;
        if (FHeight > 150) {
            return FHeight;
        }
        return 150;
    }

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
        if ($("#txtValue").val() == "") {
            $('#txtValue').focus();
            $("#txtValue").css("border-color", "Red");
            return false;
        }
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
        debugger;
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
            startLoading("Loading ", "loading-WebConfig");
            $.ajax({
                type: "POST",
                url: '../Account/SaveWebConfig',
                data: DataToSend,
                success: function (response) {
                    if (response == "Sucess") {
                        BindAppConfig();

                    }
                    $("#divTran1").hide();
                    /*   $.messager.alert(response, "information");*/
                    //ajaxindicatorstop();
                    stopLoading("loading-WebConfig");//
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    /*  $.messager.alert(textStatus, "Error");*/
                    //ajaxindicatorstop();
                    stopLoading("loading-WebConfig");//
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
                document.getElementById("divTran").style.display = "flex";
                $("#txtLogInfo").val(response);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                /*$.messager.alert(textStatus, "Error");*/
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
        startLoading("Loading Image", "loading-WebConfig");
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
                    /*  $.messager.alert(data.message, "Error");*/
                }
                stopLoading("loading-WebConfig");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                /*   $.messager.alert(textStatus, "Error");*/
                startLoading("Loading Image", "loading-WebConfig");
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
                /* $.messager.alert("Please Select " + DefaultFileformat + " File Format", 'Information');*/
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
            /*  $.messager.alert("Please Select File", 'Information');*/
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
                        /*  $.messager.alert(response, "information");*/
                        ClearAllImageField();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        /*$.messager.alert(textStatus, "Error");*/
                    }
                });
            }
            else {
                /* $.messager.alert("Invalid UserID", "Information");*/
                return false;
            }
        }
    }
    function ClearAllImageField() {
        $("#cmbImageList").val("");
        $("#txtFilePath").val("");
        document.getElementById("lblFileRes").innerText = "";
        clearCanvas("PrevCanvas");
        kCanvas("SaveCanvas");
    }




</script>



<form id="WebConfig" action="#" method="post">
    <div class="HeadDiv" style="border: 2px; width: 99.8%;">
       
        <div class="seprateDiv" style="margin-right: 27px;"><a id="btnExcel" href="#">
            <div title="Send To Excel" class="btnExcel"></div>
        </a></div>
        <%--<div id="lnkNew" style="margin-right: 15px; margin-top: 2px;" title="New" class="btnNew"></div>--%>
    </div>
    <div id="DivAppsettingHeader">
        <fieldset class="AppSettingfieldset">
            <table style="width: 100%">
                <tr>
                    <td style="width: 15%">
                        <input id="rbtnApp" name="Status" type="radio" value="true" onclick="WebConfig()" />
                        <label>App Setting</label>
                    </td>
                    <td>
                        <input id="rbtnImg" name="Status" type="radio" value="False" onclick="ImageSetting()" />
                        <label>Image Setting</label>
                    </td>
                    <td style="text-align: right;">

                        <input type="button" id="lnkNew" class="Nbutton"
                            style="background-color: rgb(57, 142, 189); height: 27px; width: 80px; border-radius: 10px; font-weight: bold; font-size: 12px; color: white; margin-right: 10px;"
                            value="New" />

                        <span style="display:inline-block"><a href="#" id="getWebConfigInfo"
                            onclick="GetWebConfigLogInfo()"
                            style="zoom: 1.5; margin-bottom: -4px;"
                            class="ui-icon ui-icon-info GetTansInfo"
                            title="Get Web Config Info"></a></span>

                    </td>
                </tr>
            </table>
        </fieldset>
    </div>

    <div id="DivAllImageSetting" style="display: none;">
        <fieldset>
            <table style="width: 100%">
                <tr>
                    <td style="width: 50%">
                        <label style="margin-left: 10px; width: 80px; display: inline-block;">Image List</label>
                        <%:Html.DropDownListFor(x => Model.ImageKeyCD, new SelectList(Model.ImageList, "Value", "Text"),"---Select---",  new { id = "cmbImageList", @class = "ComboFormat", style = "width:180px",onchange="BindResolution();ChkImageType();GetImage()"})%>
                        <label id="lblFileRes" style="margin-left: 10px; display: inline-block; margin-right: 30px; width: auto; color: red; font-style: italic;">* Suggested File Resolution </label>
                    </td>
                    <td>
                        <label style="margin-left: 10px; width: 80px; display: inline-block;">File Path</label>
                        <input type="file" id="txtFilePath" style="margin-top: 5px; margin-bottom: 5px; margin-left: 10px; width: 350px;" accept="image/*" onchange="FileUploadType();PreviewImage()" disabled>
                    </td>
                </tr>
            </table>
        </fieldset>
        <table style="width: 100%">
            <tr>
                <td style="width: 50%">
                    <div class="panel-heading" style="text-align: center">
                        <span>Present</span>
                    </div>
                    <div class="canvas-container" style="overflow: auto;">
                        <canvas id="SaveCanvas"></canvas>
                    </div>
                </td>
                <td>
                    <div class="panel-heading" style="text-align: center">
                        <span>Preview</span>
                    </div>
                    <div class="canvas-container" style="overflow: auto;">
                        <canvas id="PrevCanvas"></canvas>
                    </div>
                </td>
            </tr>
        </table>
        <div style="width: 100%; display: inline-block">
        </div>

    </div>
    <div id="DivAllWebConfig" style="display: block">
        <fieldset>
            <div id="divgrid">
                <div id="GvWebConfig"></div>
            </div>
        </fieldset>
    </div>

    <div id="DivAllDBSetting" style="display: none;">
        <fieldset>
        </fieldset>
    </div>


    <div style="text-align: center; margin-top: 15px;" id="DivSave">
        <input type="button" class="Nbutton" id="btnSave" value="Save" style="background-color: rgb(57, 142, 189); height: 27px; width: 60px; border-radius: 10px 10px 10px 10px; font-weight: bold; font-size: 12px; color: white" onclick="SaveImageConfig()" />
    </div>

    <div id="divTran" class="EModal1">

    <div class="modal-content1">

        <div class="panel-heading">
            <label>WebConfig Log Info</label>

            <span onclick="document.getElementById('divTran').style.display='none'"
                  style="float:right;cursor:pointer;font-size:20px;color:white;">×</span>
        </div>

        <div style="padding:15px;width:100%">
            <textarea id="txtLogInfo" disabled="disabled"
                      style="width:100%;height:464px;"></textarea>
        </div>

    </div>

</div>


 <div id="divTran1" class="EModal"> 

    <div class="modal-content">

        <div class="panel-heading">
            <label id="DivHeading">Key - New</label>

           
            <span onclick="document.getElementById('divTran1').style.display='none'"
                style="float: right; cursor: pointer; font-size: 20px; color: white;">×</span>
        </div>

        <div style="width: 100%">
            <table style="width: 100%">
                <tr>
                    <td style="width: 20%">
                        <label>Module</label>
                    </td>
                    <td>
                        <%:Html.DropDownListFor(x => Model.ModuleCD, new SelectList(Model.Module, "Value", "Text"),"---Select---",  new { id = "cmbModule", style = "width:97%;margin-top:2%;font-size: 18px;height: 31px;text-shadow: 0.65px 0 0 #006d88;color: #025f76", onchange="MakeNormal(this.id)"})%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Form Name</label>
                    </td>
                    <td>
                        <input type="text" id="txtFormName" class="Mandatory" onchange="MakeNormal(this.id)" style="width: 97%; border: 2px solid #c1c1c1; margin-top: 1%;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Key</label>
                    </td>
                    <td>
                        <input type="text" id="txtKey" class="Mandatory" onchange="MakeNormal(this.id)" style="width: 97%; border: 2px solid #c1c1c1; margin-top: 1%;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Value</label>
                    </td>
                    <td>
                        <input type="text" id="txtValue" onkeyup="RestrictSymbol()" class="Mandatory" onchange="MakeNormal(this.id)" style="width: 97%; border: 2px solid #c1c1c1; margin-top: 1%;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Created By</label>
                    </td>
                    <td>
                        <input type="text" id="txtAddedBy" class="Mandatory" onchange="MakeNormal(this.id)" style="width: 97%; border: 2px solid #c1c1c1; margin-top: 1%;" />
                    </td>
                </tr>
                <tr id="trDateTime">
                    <td>
                        <label>Date</label>
                    </td>
                    <td>
                        <input type="text" id="txtDate" class="Mandatory" onchange="MakeNormal(this.id)"style="width:35%;border: 2px solid #c1c1c1; margin-top: 1%;" />
                        <label style="width: 10%; display: inline-block; margin-left: 5%">Time</label>
                        <input type="text" id="txtTime" class="Mandatory" onchange="MakeNormal(this.id)"style="margin-left: 5%; width: 35%; border: 2px solid #c1c1c1; margin-top: 1%;" />
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: super;">
                        <label>Description</label>
                    </td>
                    <td>
                        <textarea id="txtDesc" class="Mandatory" onchange="MakeNormal(this.id)" style="resize: vertical; height: 150px; width: 97%; border: 2px solid #c1c1c1; margin-top: 1%;"></textarea>
                    </td>
                </tr>
            </table>

            <div class="buttonDiv" align="center">
                <input type="button" id="btn" class="Nbutton"
                       style="background-color: rgb(57, 142, 189); height: 27px; width: 80px; border-radius: 10px; font-weight: bold; font-size: 12px; color: white"
                       value="Save" onclick="SaveAction();" />
            </div>
        </div>

        <div id="loading-WebConfig" class="loading-screen" style="display: none;"></div>

    </div> 

</div>


</form>







