<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.UnitSelectionModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<style>

</style>
<script type="text/javascript">
    var UnitCd = '<%: Session["UNITCODE"] ?? "" %>';
    var UnitRightLstCd = '<%: Session["UNITRIGHTS"] ?? "" %>';
    var UnitRightsLst = [];
    $(document).ready(function () {
        $("#btnHospUnitDiv").fancybox({
            helpers: {
                overlay: { closeClick: false }
            },
            autoDimensions: false,
            width: 230,
            height: 130,
            modal: true,
            closeBtn: false,
            autoSize: false,
            beforeShow: function () {
                this.closeBtn = false
                $("#cmbHospUnit").val(UnitCd);
            }
        });
        $("a#btnHospUnitDiv").click();
        
    });
    function BindUnitLst() {
        var UnitRightLst = '<%: Session["UNITRIGHTS"] ?? "" %>';
        var SpltUnitRightLst = UnitRightLst.split('|');
        $("#cmbHospUnit").empty();
        var Option = "<option value='{OPTVALUE}'>{OPTEXT}</option>"
        $.grep(SpltUnitRightLst, function (a) {
            var Rpl = Option.replace("{OPTVALUE}", a).replace("{OPTEXT}", a);
        });
    }
    function SetHospital() {
        if ($("#cmbHospUnit").val() == "") {
            $("#cmbHospUnit").css("border-color", "red");
            $("#cmbHospUnit").focus();
            return false;
        }
        var datatosend = {
            HospUnit: $("#cmbHospUnit").val()
        }
        $.loader.open();
        $.ajax({
            type: "POST",
            url: '../Account/ChangeUnitSel',
            data: datatosend,
            async: false,
            success: function (response) {
                $.loader.close();
                if (response == "doctor") {
                    window.location.replace("<%=Url.Action("MenuList", "Account",new { pageId = "Menu" })%>");
                }
                else if (response == "staff") {
                    window.location.replace("<%=Url.Action("ClinicEntry", "ClinicalNotes")%>");
                }
                else if (response == "unit") {
                    window.location.replace("<%=Url.Action("UnitSelection", "Account")%>");
                }
                else {
                    closeWaitingDialog();
                    $.messager.alert("Information", response);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.messager.alert("Information", textStatus);
            }
        });
    }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <div id="HospUnitDiv" style="display: none;height:100%;width:99%">
            <a href="#HospUnitDiv" id="btnHospUnitDiv"></a>
            <div style="display: flex;flex-direction: column;align-items: center;justify-content: space-between;padding: 10px;border: 1px solid;border-radius: 5px;">
                <div>
                    <label style="font-size: 16px;font-weight: bold;">Select Unit</label>
                </div>
                <div style="width: 100%;margin-bottom: 10px;">
                    <%=Html.DropDownListFor(x => Model.HospUnit, new SelectList(Model.HospUnitList, "Value", "Text"), "---Select---", new { id="cmbHospUnit", @class = "ComboFormat  Mandatory",style="width: 100%;text-align: center;height: 30px;border-radius: 5px;"})%>
                </div>
                <div>
                    <input type="button" id="btnHospOk" class="btn btn-primary" value="Continue" style="padding: 5px;width: 70px;" onclick="SetHospital()" />
                </div>
            </div>
        </div>
</asp:Content>
