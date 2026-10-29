<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.ErrorLogInfoMdl>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<style>
    #txtLogInfo
    {
        height:300px;
        width:836px;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        ////debugger;
        var userId = '<%: ("" + Session["gOncoUserId"]).ToString().Trim()%>';
            var cWidth = $(".content").width() - 50;
            var cHeight = $(".content").height() - 150;
            document.getElementById("txtLogInfo").style.width = cWidth + "px";
            document.getElementById("txtLogInfo").style.height = cHeight + "px";
            $("#rbtnService").prop("checked", true);
            GetErrorLog();
        });
        $(window).on("load", function () { });
        function GetErrorLog() {
            ////debugger;
            var Type = $("#rbtnService").prop("checked") == true ? "S" : "A";
            $.ajax({
                type: 'post',
                url: '../Account/GetErrolog?Type=' + Type,
                cache: false,
                dataType: "json",
                async: false,
                success: function (result) {
                    $("#txtLogInfo").val(result);
                    var textarea = document.getElementById('txtLogInfo');
                    textarea.scrollTop = textarea.scrollHeight;
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("An error occurred while processing your request.", "Error Information");
                    HoldOn.close();
                }
            });
        }
        function ClearErrorLog() {
            ////debugger;
            HoldOn.open();
            var Type = $("#rbtnService").prop("checked") == true ? "S" : "A";
            $.ajax({
                type: 'post',
                url: '../Account/ClearErrorLog?Type=' + Type,
                cache: false,
                dataType: "json",
                async: false,
                success: function (result) {
                    GetErrorLog();
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("An error occurred while processing your request.", "Error Information");
                    HoldOn.close();
                }
            });
        }
        function BackToHome() {
            window.location.href = "../Account/MenuList";
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="WebConfig" action="#" method="post">
    <div class="HeadDiv" style="border: 2px; width: 99.8%;">
        <span style="display: inline-block; line-height: 19px;" id="FormHeader">Service / Application Error Log</span> 
    </div>
     <div style="margin-left:15px;margin-bottom:10px">
         <input type="radio" id="rbtnService" name="ErrorLog" onclick="GetErrorLog()" /> <label style="display: inline-block; width: 140px;">Service Error Log</label>
         <input type="radio" id="rbtnApp" name="ErrorLog" onclick="GetErrorLog()"  /><label style="display: inline-block;margin-left: 10px;">Application Error Log</label>
     </div>
     <div style="display:block;text-align:center">
        <%:Html.TextAreaFor(x => Model.ErrorTxt, new { id="txtLogInfo",  @class="form-control" ,disabled = "disabled"})%>
        <input type="button" id="btnClear" class="Nbutton" style="background-color: rgb(57, 142, 189); height: 27px; width: 60px; border-radius: 10px 10px 10px 10px; font-weight: bold; font-size: 12px; color: white;margin-top: 2%;" value="Clear" onclick="ClearErrorLog()"/>
        <input type="button" id="btnBack" class="Nbutton" style="background-color: rgb(57, 142, 189); height: 27px; width: 60px; border-radius: 10px 10px 10px 10px; font-weight: bold; font-size: 12px; color: white;margin-top: 2%;" value="Back" onclick="BackToHome()"/>
     </div>

    </form>
</asp:Content>
