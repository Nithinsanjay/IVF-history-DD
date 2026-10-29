<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Patient>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div style="width:100%;text-align:center" id="divBack">
    <a class="button1 button1-green" id="divForBack"  style="margin-bottom: 1.5%;" onclick="SetpageDirctn()">
    <i class="fa fa-arrow-left"></i>
    <strong>Back</strong>
</a>
</div>
  <div>
            <% Html.RenderPartial("PatientInfoSearch", new OncologyEMR.Models.UserControlModel { }); %>
        </div>

     <div style="position: relative; overflow: hidden;">
            <% Html.RenderPartial("PatientInfoControl", new OncologyEMR.Models.UserControlModel { }); %>
        </div>
    <div style="text-align:center;margin-top:5px;">
        <input type="button" id="btnAdd" class="button1 button1-green" value="Add" />
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    
    <style>

        .panel-heading {
    padding: 5px 15px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
    background: #24417c;
    color: white;
}
    </style>

    <link href="<%=ResolveUrl("~/jqGrid/css/ui.jqgrid.css")%>" rel="stylesheet" />
    <link href="<%=ResolveUrl("~/Styles/jqGrid.bootstrap.css")%>" rel="stylesheet" />

    <script src="<%=ResolveUrl("~/jqGrid/js/i18n/grid.locale-en.js")%>"></script>
    <script src="<%=ResolveUrl("~/jqGrid/js/jquery.jqGrid.min.js")%>"></script>
    <script>

        var TraiageYN = '<%=(string)ViewBag.strTraige%>'; //Added by Murali on 23/05/2024
        var pathFrom = ""; //Added by Murali on 23/05/2024

        function BtnSearchEnt() {
            if (event.keyCode == 13) { $('#btnSearch').trigger('click'); $('#btnSearch').focus(); }
        }

        function filldata(rowData) {

        }

        function SaveAction() {
            HoldOn.open();
            var ConMrno = $('#txtUCMrNo').val();
            var STREMPID = $('#txtEmpId').val();

            if (ConMrno == "") {
                MsgDia("Please select the patient.", "Validations");
                return false;
            }

            if (ConMrno.trim() != "") {
                //var CONmodel1 = $("#PatConsultationForm").serialize();
                var CONmodel1 = $("#PatInfoCtrl").serialize() + "&Gaction=1" + '&Tranno=' + '&STREMPID=' + STREMPID + '&PAYOLSTATUS=' + 'N' + '&strClinicCD=' + $.session.get('ClinicCode') + '&strTraigeYN=' + TraiageYN; //Added TriageYN by Murali on 23/05/2024
                var urls = '../DoctorDesk/GetConsultSave';
                $('#btnAdd').addClass('DisableButton');
                $.ajax({
                    type: "POST",
                    url: urls,
                    data: CONmodel1,
                    //async: false,
                    dataType: "json",
                    success: function (response) {
                        HoldOn.close();
                        var conYN = response[0].toUpperCase().search("SUCCESS");
                        if (conYN != -1) {

                            var age = $("#txtUCAge").val();
                            var strAge = Number(age.split(":")[0]) > 0 ? Number(age.split(":")[0]) + " Yrs" : Number(age.split(":")[1]) > 0 ? Number(age.split(":")[1]) + " Months" : Number(age.split(":")[2]) + " Days"
                            //var strAge = (age.charAt(0) == "0") ? age.toString().substr(1, 2) + "Yrs" : age.toString().substr(0, 3) + "Yrs";

                            $.session.set('PatName', $("#txtUCSalutation").val().substring(0, $("#txtUCSalutation").val().indexOf("  ")) + " " + $("#txtUCPatname").val());
                            $.session.set('PatAge', strAge);
                            $.session.set('PatGender', $("#txtUCGender").val());
                            $.session.set('PatMobile', $("#txtUCContactNo").val());
                            $.session.set('PatAge2', $("#txtUCAge").val());

                            $.session.set('PatMRNO', $("#txtUCMrNo").val());
                            $.session.set('PatTRANNO', response[0].substring(response[0].indexOf("<OPCONSNO>") + 10, response[0].indexOf("</OPCONSNO>")));
                            $.session.set('PatDOB', $("#txtUCstrDOB").val());
                            $.session.set('onlpaySTAT', "N");
                            $.session.set('PatEmail', "");
                            glbPatMRNo = $("#txtUCMrNo").val();
                            $.session.set('OutRefDrNm', "");
                            $.session.set('OutRefDrContact', "");
                            $.session.set('PatCompleted', "N");
                            $.session.set('PatSelected', "Appointed");
                            alert("Patient added");
                            SetPatientDtl();
                            //Below condition Added By Murali on 23/05/2024
                            //**************************************
                            if (TraiageYN == "" || TraiageYN == "N")
                                window.location.href = '../DoctorDesk/PatientEntry';
                            else if (TraiageYN == "Y")
                                window.location.href = '../ClinicalNotes/ClinicEntry';
                            //**************************************
                        } else {
                            alert(response, 'Error Information');
                            $('#btnSave').removeClass('DisableButton');
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert('An error occurred while processing your request.', "Error Information");
                        HoldOn.close();
                        $('#btnSave').removeClass('DisableButton');
                    }
                });
            }

            HoldOn.close();
        }

        $(document).ready(function () {
            //Below Code Added By Murali on 23/05/2024
            //**************************************
            if (TraiageYN == "Y")
                $("#divBack").show();
            else if (TraiageYN == "N")
                $("#divBack").hide();
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');
            //**************************************
            $("#btnAdd").click(function (e) {
                SaveAction();
            });

            $("#divBillInfo").hide();
            $("#divNotification").hide();
        });
        //Below Code Added By Murali on 23/05/2024
        //**************************************
        function SetpageDirctn() {
            if (pathFrom == "") {
                window.location.href = '../ClinicalNotes/ClinicEntry';
            } else
                window.location.href = '../DoctorDesk/PatientEntry';
        }
        //**************************************
    </script>
    
   

</asp:Content>
