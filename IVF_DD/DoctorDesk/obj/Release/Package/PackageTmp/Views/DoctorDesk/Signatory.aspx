<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.SignatoryMdl>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="MainDiv" style="margin: auto;">
        <% using (Html.BeginForm(null, null, FormMethod.Post, new { enctype = "multipart/form-data", id = "Signatory" }))
           { %>
        <div>



            <div>
                <div class="col-md-12">
                    <label style="font-size: 12px; margin-top: 0px; display: block; cursor: pointer; color: #025f76 !important;">Signatory 1</label>
                    <%= Html.TextAreaFor(x => Model.TextArea1, new { @class = "form-control input-sm",  style = "height: 150px;resize:none;", id = "txtTextArea1" , maxlength="500",@cols="50" , @row="30",onchange=""})%>
                </div>
                <div class="col-md-12">
                    <div>

                        <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer; color: #025f76 !important;">Digital Signature 1 </label>
                    </div>
                    <div>
                        <img id="imgSignatory1" alt="Signature Preview(Max Upload Size 30KB)" width="300" height="150" />
                    </div>

                    <div id="divUploadSignatory1">
                        <input style="display: inline-block; width: 200px;" class="form-control input-sm" type="file" name="Signatory1" accept="image/*" id="Signatory1" onchange="showSignatorypreview(this)" />
                        <input style="display: inline-block; width: 100px;" class="btn-primary input-sm" type="button" id="btnRemoveSignatory1" value="Remove File" onclick="clearFileInputField('divUploadSignatory1')" />
                    </div>
                    <div>
                        <label id="lblSignError1" style="color: red; display: none">Your upload Size is more than 30KB</label>
                    </div>


                </div>
            </div>


            <div>
                <div class="col-md-12">
                    <label style="font-size: 12px; margin-top: 20px; display: block; cursor: pointer; color: #025f76 !important;">Signatory 2</label>
                    <%= Html.TextAreaFor(x => Model.TextArea1, new { @class = "form-control input-sm",  style = "height: 150px;resize:none;", id = "txtTextArea2" , maxlength="500",@cols="50" , @row="30",onchange=""})%>
                </div>
                <div class="col-md-12">
                    <div>

                        <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer; color: #025f76 !important;">Digital Signature 2 </label>
                    </div>
                    <div>
                        <img src="" id="imgSignatory2" alt="Signature Preview(Max Upload Size 30KB)" width="300" height="150" />
                    </div>

                    <div id="divUploadSignatory2">
                        <input style="display: inline-block; width: 200px;" class="form-control input-sm" type="file" name="Signatory2" accept="image/*" id="Signatory2" onchange="showSignatorypreview(this)" />
                        <input style="display: inline-block; width: 100px;" class="btn-primary input-sm" type="button" id="btnRemoveSignatory2" value="Remove File" onclick="clearFileInputField('divUploadSignatory2')" />
                    </div>
                    <div>
                        <label id="lblSignError2" style="color: red; display: none">Your upload Size is more than 30KB</label>
                    </div>


                </div>
            </div>


            <div>
                <div class="col-md-12">
                    <label style="font-size: 12px; margin-top: 20px; display: block; cursor: pointer; color: #025f76 !important;">Signatory 3</label>
                    <%= Html.TextAreaFor(x => Model.TextArea1, new { @class = "form-control input-sm",  style = "height: 150px;resize:none;", id = "txtTextArea3" , maxlength="500",@cols="50" , @row="30",onchange=""})%>
                </div>
                <div class="col-md-12">
                    <div>

                        <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer; color: #025f76 !important;">Digital Signature 3 </label>
                    </div>
                    <div>
                        <img src="" id="imgSignatory3" alt="Signature Preview(Max Upload Size 30KB)" width="300" height="150" />
                    </div>

                    <div id="divUploadSignatory3">
                        <input style="display: inline-block; width: 200px;" class="form-control input-sm" type="file" name="Signatory3" accept="image/*" id="Signatory3" onchange="showSignatorypreview(this)" />
                        <input style="display: inline-block; width: 100px;" class="btn-primary input-sm" type="button" id="btnRemoveSignatory3" value="Remove File" onclick="clearFileInputField('divUploadSignatory3')" />
                    </div>
                    <div>
                        <label id="lblSignError3" style="color: red; display: none">Your upload Size is more than 30KB</label>
                    </div>


                </div>
            </div>
            <div>
                <label id="myBtn" style="background-color: transparent; float: right; margin-right: 25%; border-color: transparent;" title="Save">
                    <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                </label>
            </div>
        </div>

        <%}%>
    </div>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style>
    </style>

    <script type="text/javascript">

        var strdoctcode = '<%:ViewBag.strdoctcode %>';
        $(document).ready(function (e) {


            $("#myBtn").click(function () {
                SaveSignatory();
            });

            GetSignatory(strdoctcode);

        });

        function showSignatorypreview(input) {

            var id = input.id.substring(input.id.length, input.id.length - 1);
            if (input.files && input.files[0]) {
                if (input.files[0].size > 31744) {
                    $('#imgSignatory' + id).removeAttr('src');
                    $('#lblSignError' + id).show();
                    return false;
                }
                else $('#lblSignError' + id).hide();
                var filerdr = new FileReader();
                filerdr.onload = function (e) {
                    $('#imgSignatory' + id).attr('src', e.target.result);
                }
                filerdr.readAsDataURL(input.files[0]);
            }
            else {
                $('#lblSignError' + id).hide();
                $('#imgSignatory' + id).removeAttr('src');
            }
        }

        function clearFileInputField(tagId) {

            document.getElementById(tagId).innerHTML =

                document.getElementById(tagId).innerHTML;
            if (tagId == "divUploadSignatory1") {
                $('#imgSignatory1').removeAttr('src');
            }
            else if (tagId == "divUploadSignatory2") {
                $('#imgSignatory2').removeAttr('src');
            }
            else if (tagId == "divUploadSignatory3") {
                $('#imgSignatory3').removeAttr('src');
            }
        }

        function validationForNew() {
            if ($("#txtTextArea1").val().trim().length == 0) {
                $("#txtTextArea1").focus();
                return false;
            }
            else {
                $("#txtTextArea1").css("border-color", "");
                return true;
            }
        }

        function SaveSignatory() {
            var postData = new Array();

            var data = new FormData();
            if (validationForNew() == false)
                return false;

            var imgsrc1 = $('#imgSignatory1')[0].currentSrc;
            imgsrc1 = imgsrc1.substr(imgsrc1.indexOf(',') + 1);

            var imgsrc2 = $('#imgSignatory2')[0].currentSrc;
            imgsrc2 = imgsrc2.substr(imgsrc2.indexOf(',') + 1);

            var imgsrc3 = $('#imgSignatory3')[0].currentSrc;
            imgsrc3 = imgsrc3.substr(imgsrc3.indexOf(',') + 1);

            data.append("Signatory1", imgsrc1);
            data.append("Signatory2", imgsrc2);
            data.append("Signatory3", imgsrc3);

            data.append("TextArea1", $('#txtTextArea1').val());
            data.append("TextArea2", $('#txtTextArea2').val());
            data.append("TextArea3", $('#txtTextArea3').val());

            $.ajax({
                type: "POST",
                url: "SaveSignatory",
                data: data,
                dataType: "json",
                cache: false,
                contentType: false,
                processData: false,
                success: function (result) {

                    //clearFileInputField();
                    //$('#TextArea1').val("");
                    //$('#TextArea2').val("");
                    //$('#TextArea3').val("");
                    $.messager.alert("Information", result);
                },
                complete: function () { HoldOn.close(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }

        function GetSignatory() {

            var datatotosend = {
                strdoctcode: strdoctcode
            }
            $.ajax({
                type: "GET",
                url: "GetSignatory",
                data: datatotosend,
                cache: false,
                success: function (result) {
                    var data = JSON.parse(result);
                    $('#txtTextArea1').val("");
                    $('#txtTextArea2').val("");
                    $('#txtTextArea3').val("");

                    $('#imgSignatory1')[0].src = "";
                    $('#imgSignatory2')[0].src = "";
                    $('#imgSignatory3')[0].src = "";

                    $('#txtTextArea1').val(data[0]["SIGN"]);
                    $('#txtTextArea2').val(data[0]["SIGN2"]);
                    $('#txtTextArea3').val(data[0]["SIGN3"]);

                    $('#imgSignatory1')[0].src = "data:image/jpeg;base64," + data[0]["DIGSIGN1"];
                    $('#imgSignatory2')[0].src = "data:image/jpeg;base64," + data[0]["DIGSIGN2"];
                    $('#imgSignatory3')[0].src = "data:image/jpeg;base64," + data[0]["DIGSIGN3"];
                },
                complete: function () { HoldOn.close(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }

    </script>


</asp:Content>
