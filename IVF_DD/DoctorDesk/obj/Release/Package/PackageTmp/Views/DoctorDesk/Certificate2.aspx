<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.CertificateMdl2>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div>
            <input style="width: 100%; background-color: #f7fcff; margin-left: -17px; margin-top: -22px; position: fixed; border: none;display:none" class="empty" disabled>
        </div>
        <div id="MainDiv">
          <div style="width: 100%;display: flex;text-align: center;flex-wrap: nowrap;justify-content: center;align-items: center;">
           <a class="button1 button1-green" id="divForBack"  style="margin-bottom: 2.5%;" onclick="SetpageDirctn()"><i class="fa fa-arrow-left"></i><strong>Back</strong></a>
           <a class="button1 button1-green" id="divAdd"  style="margin-bottom: 2.5%;margin-left: 20px;" onclick="CertificateAdd('','New')"><i class="fa fa-plus"></i><strong>Add</strong></a>
          </div>
          <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%">
                <div id="wrapper" style="overflow: hidden; width: 100%">
                    <div class="tableDiv" style="padding-top: 12px;width:100%">
                        <table class="HeadPatTab" style="text-align: center;width:100%">
                           <thead>
                                <tr style="background-color: #fffdc8; font-size: 12px">
                                    <th style="width: 10%;text-align: center;">SI No.</th>
                                    <th style="width: 30%;text-align: center;">Certificate No.</th>
                                    <th style="width: 50%;text-align: center;">Subject</th>
                                    <th style="width: 40%;text-align: center;">Doctor Name</th>
                                    <th style="width: 25%;text-align: center;">Issued Date</th>
                                    <th style="width: 50%;text-align: center;">Rest From And To Date</th>
                                    <th style="width: 30%;text-align: center;">Attended Date</th>
                                    <th style="width: 25%;text-align: center;display:none">Created By</th>
                                    <th style="width: 30%;text-align: center;display:none">Created Date / Time</th>
                                    <th style="width: 25%;text-align: center;display:none">DOCTCODE</th>
                                    <th style="width: 25%;text-align: center;display:none">STATUS</th>
                                    <th style="width: 25%;text-align: center;display:none">Details</th>
                                    <th style="width: 30%;text-align: center;">Action</th>
                                </tr>
                            </thead>
                        </table>
                     <table id="tblCertificate" class="table HeadPatTab" style="width: 100%">
                        <tbody style="height:100%">
                                                        
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .Mandatory { border-right: 3px solid #e22d04  !important}
        .Nbutton:hover {
            cursor: pointer;
        }
        .Nbutton {
            width: 80px;
            border: none;
            border-radius: 4px;
            color: white;
            font-weight: bold;
            background: #ff5722;
            padding: 4px;
            height: 25px;
            -webkit-box-shadow: 0 2px 5px 0 rgb(0 0 0 / 20%), 0 2px 10px 0 rgb(0 0 0 / 10%);
            box-shadow: 0 2px 5px 0 rgb(0 0 0 / 20%), 0 2px 10px 0 rgb(0 0 0 / 10%);
            background: #164eff;
        }
        .input[type=text], textarea {
            font-family: Verdana,Geneva,sans-serif;
            font-size: 11.5px;
            height: 16px;
            color: #2e2c2c;
            background: white;
            text-shadow: 0.5px 0px 0 #707273;
            border: 2px solid #c1c1c1;
        }
    </style>

    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/Doctorlist.js"></script>
    <script type="text/javascript">
        var GridData = "";
        var sign1 = "";
        var sign2 = "";
        var sign3 = "";
        var digitsign1 = "";
        var digitsign2 = "";
        var digitsign3 = "";
        var TempTemplate = "";
        $(document).ready(function (e) {
            GetDoctSignature();
            BindCertificateDataList();
        });
        function SetpageDirctn() {
            window.location.href = '../DoctorDesk/PatientEntry';
        }
        function EditBtn() {
            $("#btnEdit").css("background-color", "#ff5722");
            $("#txtTemplate").removeAttr("disabled", "disabled");
            $("#txtIssuesDT").attr("disabled", "disabled");
            $("#txtRRFromDT").attr("disabled", "disabled");
            $("#txtRRToDT").attr("disabled", "disabled");
            $("#txtAttendDT").attr("disabled", "disabled");
        }
        function ClearBtn() {
            $("#btnEdit").css("background-color", "#164eff");
            $("#txtTemplate").attr("disabled", "disabled");
            $("#txtIssuesDT").removeAttr("disabled", "disabled");
            $("#txtRRFromDT").removeAttr("disabled", "disabled");
            $("#txtRRToDT").removeAttr("disabled", "disabled");
            $("#txtAttendDT").removeAttr("disabled", "disabled");
            BindCertificateNewData();
        }
        //Template
        function Template() {
            var Space = "\t\t\t";
            TempCont = "This is to certify that {#SALUTATION} {#PATIENTNAME}, Age {#AGE} Yrs. Sex {#GENDER}, {#RELATION} {#EMPNAME} R/O {#ADDRESS} ";
            TempCont = TempCont + "has been examined by me on {#EXAMDATE}.";
            TempCont = TempCont + "\n{#HESHE} is/was suffering from {#FINALDIAGNOSIS} and is/was under my treatment with effect from {#ISSUESDATE}.";
            TempCont = TempCont + "\nIn my opinion {#heshe} requires/required rest for a period of {#DAYS} days, from {#FROMDATE} to {#TODATE} for restoration of {#hisher} health.";
            TempCont = TempCont + "\n{#HESHE} is fit to attend duties/school with effect from {#ATTENDDATE}."
            TempCont = TempCont + "\n\nIdentification Marks: {#IDENTIFICATION}";
            return TempCont;
        }
        //Template Binding Content
        function TemplateContent(AllData) {
            var PatInfo = AllData[0]; var OtherInfo = AllData[1];
            var TempCont = ""; var EmptyArea = "_______________";
            var PatSalu = PatInfo == "" || PatInfo[0].SALUNAME.trim() == "" ? EmptyArea : PatInfo[0].SALUNAME.trim();
            var PatName = PatInfo == "" || PatInfo[0].PATNAME.trim() == "" ? EmptyArea + EmptyArea : PatInfo[0].PATNAME.trim();
            var PatRel = ""; var EmpName = "";
            if (PatInfo[0].Relation.trim() == "SELF" && PatInfo[0].FATHERNAME.trim() != "") {
                PatRel = (PatInfo[0].Gender.trim() == "Male" ? "Son" : PatInfo[0].Gender.trim() == "Female" ? "Daughter" : "Son/Daughter") + " of";
                EmpName = PatInfo[0].FATHERNAME.trim();
            }
            else if (PatInfo[0].Relation.trim() != "SELF") {
                var PatRel = (PatInfo[0].Relation.trim() == "" ? EmptyArea : PatInfo[0].Relation.trim()) + " of";
                var EmpName = PatInfo[0].EMPNAME.trim() == "" ? EmptyArea + EmptyArea : PatInfo[0].EMPNAME.trim();
            }
            var PatAge = PatInfo == "" || PatInfo[0].PATAGE.trim() == "" ? EmptyArea : Number(PatInfo[0].PATAGE.trim());
            var PatGen = PatInfo == "" || PatInfo[0].Gender.trim() == "" ? EmptyArea : PatInfo[0].Gender.trim();
            var IdMarks = "";
            var Address = PatInfo == "" ? EmptyArea + EmptyArea + EmptyArea : PatInfo[0].PATPADDR1.trim() == "" && PatInfo[0].PATPADDR1.trim() == "" && PatInfo[0].PATPADDR1.trim() == "" ? EmptyArea + EmptyArea + EmptyArea : ((PatInfo[0].PATPADDR1.trim() == "" ? "" : PatInfo[0].PATPADDR1.trim()) + (PatInfo[0].PATPADDR2.trim() == "" ? "" : "," + PatInfo[0].PATPADDR2.trim()) + (PatInfo[0].PATPADDR3.trim() == "" ? "" : "," + PatInfo[0].PATPADDR3.trim()))
            var ExaminDT = OtherInfo == "" || OtherInfo[0].TRANDATE.trim() == "" ? EmptyArea : OtherInfo[0].TRANDATE.trim();
            var FinalDiag = OtherInfo == "" || OtherInfo[0].FINALDIAGNOSIS.trim() == "" ? EmptyArea : OtherInfo[0].FINALDIAGNOSIS.trim();
            var GenHeShe = PatInfo == "" ? "He/She" : (PatInfo[0].Gender.trim() == "Male" ? "He" : PatInfo[0].Gender.trim() == "Female" ? "She" : "He/She");
            var GenHisHer = PatInfo == "" ? "His/Her" : (PatInfo[0].Gender.trim() == "Male" ? "His" : PatInfo[0].Gender.trim() == "Female" ? "Her" : "His/Her");
            //Start
            var TempCont = Template().replace(/{#SALUTATION}/g, PatSalu)
                .replace(/{#PATIENTNAME}/g, PatName)
                .replace(/{#RELATION}/g, PatRel)
                .replace(/{#EMPNAME}/g, EmpName)
                .replace(/{#AGE}/g, PatAge)
                .replace(/{#GENDER}/g, PatGen)
                .replace(/{#IDENTIFICATION}/g, IdMarks)
                .replace(/{#ADDRESS}/g, Address)
                .replace(/{#EXAMDATE}/g, ExaminDT)
                .replace(/{#FINALDIAGNOSIS}/g, FinalDiag)
                .replace(/{#HESHE}/g, GenHeShe)
                .replace(/{#HISHER}/g, GenHisHer)
                .replace(/{#heshe}/g, GenHeShe.toLowerCase())
                .replace(/{#hisher}/g, GenHisHer.toLowerCase());
            document.getElementById("txtTemplate").value = TempCont;
            TempTemplate = TempCont;
        }
        //Template Change
        function TempContentChange() {
            var TemplateData = TempTemplate;
            if ($("#txtRRToDT").val() == "") {
                $("#txtRRToDT").datepicker('setDate', 'today');
            }
            var dateString1 = $("#txtRRFromDT").val(); var dateString2 = $("#txtRRToDT").val();
            var date1Parts = dateString1.split("/"); var date2Parts = dateString2.split("/");
            var date1 = new Date(date1Parts[2], date1Parts[1] - 1, date1Parts[0]); var date2 = new Date(date2Parts[2], date2Parts[1] - 1, date2Parts[0]);
            var difference = date1.getTime() - date2.getTime();
            var daysDifference = Math.abs(Math.floor(difference / (1000 * 60 * 60 * 24))) + 1;
            TemplateData = TemplateData.replace(/{#ISSUESDATE}/g, $("#txtIssuesDT").val())
                .replace(/{#ATTENDDATE}/g, $("#txtAttendDT").val())
                .replace(/{#DAYS}/g, daysDifference)
                .replace(/{#FROMDATE}/g, dateString1)
                .replace(/{#TODATE}/g, dateString2)
            document.getElementById("txtTemplate").value = TemplateData;
        }
        //Popup Fancy Box
        function CertificateAdd(CertificateNo, Action) {
            $.confirm({
                title: '',
                content: '' +
                    '<form action="" class="formName" id="CertificateFrm" style="height:auto">' +
                    '<div class="form-group">' +
                    '<label style="font-size: 20px;display: flex;flex-wrap: nowrap;justify-content: center;">Certificate -' + Action + '</label> <br>' +
                    '<input type="text" id="txtTranNo" class="TranNo" style="display:none" />' + '<table>' +
                    '<tr><td> <label style="width: 80px">Subject</label><input type="text" id="txtSubject" class="form-control Mandatory" style="width:270px;display: inline-block;" onkeyup = "checkTextOnBlur(this);" /></div></td>' +
                    '<td><label style="width: 80px">Issued Date</label><input type="text" id="txtIssuesDT" readonly="readonly" onchange="TempContentChange()" class="DateClass form-control" style="width:100px;display: inline-block;" /></div></td></tr>' +
                    '<tr><td style="width:360px"><div style="margin-top: 10px;"><label style="width: 80px">Rest Range</label><label style="width: 33px;"> From </label><input type="text" id="txtRRFromDT" readonly="readonly" class="DateClass form-control" style="width:100px;display: inline-block;" onchange="ValidateDataRange();TempContentChange()" /> ' +
                    '<label style="width: 32px;text-align: center;"> To </label> <input type="text" id="txtRRToDT" readonly="readonly" class="DateClass form-control" style="width:100px;display: inline-block;" onchange="ValidateDataRange();TempContentChange()" /></div></td>' +
                    '<td><div style="margin-top: 10px;"><label style="width: 76px">Fit to Attend</label> <input type="text" id="txtAttendDT" readonly="readonly" class="DateClass form-control" onchange="TempContentChange()" style="width:100px;display: inline-block;" /></div></td></tr>' +
                    '<tr><td colspan="2"><div style="margin-top: 10px;"> <input type="button" class="Nbutton" id="btnEdit" onclick="EditBtn()" value="Edit" style="margin-left: 10px;" />  <input type="button" class="Nbutton" id="btnRest" onclick="ClearBtn()" value="Reset" style="margin-left: 10px;display :none" /></div></td></tr>' +
                    '<tr><td colspan="2"><div style="margin-top: 10px"> <label style="font-size:14px"> Template </label></div></td></tr>' +
                    '<tr><td colspan="2"><div style="margin-top: 5px;"><textarea maxlength="1000" class="TextBxFormat Mandatory" cols="20" id="txtTemplate" name="Template" style="width: 100%;height: 250px;font-size: 12px;text-align: justify;"></textarea>' +
                    '</tr>' +
                    '</table></form>',
                buttons: {
                    formSubmit: {
                        text: Action == "New" ? 'Save' : Action == "Edit" ? "Update" : "Cancel",
                        btnClass: 'btn-blue',
                        action: function () {
                            if (CheckFieldValidation()) {
                                var Act = Action == "Edit" ? "E" : Action == "Cancel" ? "C" : "N";
                                var TranNo = $("#txtTranNo").val();
                                var Mrno = $.session.get('PatMRNO');
                                var Subject = $("#txtSubject").val();
                                var AttendDate = $("#txtAttendDT").val();
                                var BodyTemplate = $("#txtTemplate").val();
                                var RestFromDate = $("#txtRRFromDT").val();
                                var RestToDate = $("#txtRRToDT").val();
                                var IssueDate = $("#txtIssuesDT").val();
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'SaveCertificate2',
                                    data: { Act: Act, TranNo: TranNo, Mrno: Mrno, Subject: Subject, AttendDate: AttendDate, BodyTemplate: JSON.stringify(BodyTemplate), RestFromDate: RestFromDate, RestToDate: RestToDate, IssueDate: IssueDate },
                                    success: function (response) {
                                        $.alert(response);
                                        BindCertificateDataList();
                                    },
                                });
                            } else {
                                return false;
                            }
                        }
                    },
                    close: function () {

                    },
                },
                onContentReady: function () {
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    $('#CertificateFrm').find("*").removeAttr('disabled', 'disabled');
                    ClearField();
                    $('.DateClass').datepicker({
                        showButtonPanel: true,
                        dateFormat: 'dd/mm/yy',
                        yearRange: '-150:+0',
                        changeMonth: true,
                        changeYear: true,
                    });
                    if (Action == "New") {
                        if ($.session.get('PatName') == null || $.session.get('PatName') == "") {
                            $.alert("Please Select the Patient.");
                            this.close();
                            SetpageDirctn();
                        } else {
                            $("#txtTranNo").val("");
                            $("#txtIssuesDT").val("");
                            $("#txtSubject").val("SICKNESS / FITNESS CERTIFICATE");
                            $(".DateClass").datepicker('setDate', 'today');
                            BindCertificateNewData();
                            $("#txtTemplate").attr("disabled", "disabled");
                            $("#btnRest").show();
                        }
                    }
                    else {
                        $("#btnRest").hide();
                        BindCertificateDataDtls(CertificateNo);
                        EditBtn();
                        if (Action == "Cancel") {
                            $("#btnEdit").css("background-color", "#164eff");
                            $('#CertificateFrm').find("*").attr('disabled', 'disabled');
                        }
                    }

                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1');
                    $('.jconfirm-box-container').removeClass('col-md-offset-4');
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    $(".jconfirm-box-container").last().css('width', '600px');
                }
            });

        }
        //Binding New Action Data in Fancy Box
        function BindCertificateNewData() {
            var Mrno = $.session.get('PatMRNO');
            $.ajax({
                type: "post",
                datatype: "json",
                url: 'BindCertificateDtls2',
                data: { Mrno: Mrno },
                success: function (response) {
                    TemplateContent(response);
                    TempContentChange();
                },
            });
        }

        //Binding List Data
        function BindCertificateDataList() {
            var Mrno = $.session.get('PatMRNO');
            $.ajax({
                type: "post",
                datatype: "json",
                url: 'BindCertificateList2',
                data: { Mrno: Mrno, TranNo: "" },
                success: function (response) {
                    $('#tblCertificate tbody').empty();
                    for (var i = 0; i < response.length; i++) {
                        var Rows = "<tr class='clickable-row' id='" + response[i].TRANNO + "'>" +
                            "<td class='SINO' style='width:10%'> " + (i + 1) + "</td>" +
                            "<td class='TRANNO' style='width:30%'> " + response[i].TRANNO + "</td>" +
                            "<td class='CERTFSUB' style='width:50%'> " + response[i].CERTFSUB + "</td>" +
                            "<td class='ISSUEDOCTNM' style='width:40%'> " + response[i].ISSUEDOCTCDNM + "</td>" +
                            "<td class='ISSUEDT' style='width:25%'> " + response[i].ISSUEDT + "</td>" +
                            "<td class='RESTFROMTODT' style='width:50%'> " + response[i].RESTFROMDT + " - " + response[i].RESTTODT + "</td>" +
                            "<td class='ATTENDDT' style='width:30%'> " + response[i].ATTENDDT + "</td>" +
                            "<td class='CREATEDBY' style='width:40%;display:none'> " + response[i].CREATEDBY + "</td>" +
                            "<td class='CREATEDSTTM' style='width:30%;display:none'> " + response[i].CREATEDDTTM + "</td>" +
                            "<td class='ISSUEDOCTCD' style='width:25%;display:none'> " + response[i].ISSUEDOCTCD + "</td>" +
                            "<td class='STATUS' style='width:25%;display:none'> " + response[i].STATUS + "</td>" +
                            "<td class='CERTFBODY' style='width:25%;display:none'> " + response[i].CERTFBODY + "</td>" +
                            "<td class='Action' style='width:30%'>" +
                            "<a href='javascript:;' style='font-size: 20px;' onclick='CertificateAdd(\"" + response[i].TRANNO + "\",\"Edit\");'><i class='fa fa-pencil' aria-hidden='true'></i></a> " +
                            "<a href='javascript:;' style='font-size: 20px;margin-left: 10px;' onclick='CertificateAdd(\"" + response[i].TRANNO + "\",\"Cancel\");'><i class='fa fa-trash' aria-hidden='true'></i></i></a> " +
                            "<a href='javascript:;' style='font-size: 20px;margin-left: 10px;' onclick='PrintData(\"" + response[i].TRANNO + "\",);'><i class='fa fa-print' aria-hidden='true'></i></a> " +
                            "</td>" +
                            "</tr>";
                        $('#tblCertificate tbody').append(Rows);
                    }
                },
            });
        }

        //Binding Edit Data
        function BindCertificateDataDtls(TranNo) {
            var Mrno = $.session.get('PatMRNO');
            $.ajax({
                type: "post",
                datatype: "json",
                url: 'BindCertificateList2',
                data: { Mrno: Mrno, TranNo: TranNo },
                success: function (response) {
                    ClearField();
                    $("#txtTranNo").val(response[0].TRANNO);
                    $("#txtSubject").val(response[0].CERTFSUB);
                    $("#txtIssuesDT").val(response[0].ISSUEDT);
                    $("#txtRRFromDT").val(response[0].RESTFROMDT);
                    $("#txtRRToDT").val(response[0].RESTTODT);
                    $("#txtAttendDT").val(response[0].ATTENDDT);
                    $("#txtTemplate").val(JSON.parse(response[0].CERTFBODY));
                },
            });
        }
        function ValidateDataRange() {
            if (new Date($('#txtRRFromDT').datepicker('getDate')) > new Date($('#txtRRToDT').datepicker('getDate')) && $('#txtRRFromDT').val() != "" && $('#txtRRToDT').val() != "") {
                $.alert("Rest Range From date should be less then or equal to Rest Range to date.", "Validation");
                $('#txtRRToDT').val($('#txtRRFromDT').val());
            }
            else if (new Date($('#txtRRToDT').datepicker('getDate')) < new Date($('#txtRRFromDT').datepicker('getDate')) && $('#txtRRFromDT').val() != "" && $('#txtRRToDT').val() != "") {
                $.alert("Rest Range To date should be greater then or equal to Rest Range from date.", "Validation");
                $('#txtRRFromDT').val($('#txtRRToDT').val());
            }
            var dObj = new Date($('#txtRRToDT').datepicker('getDate'));
            dObj.setDate(dObj.getDate() + 1);
            var Sunday = dObj.getDay();
            if (Sunday === 0) {
                dObj.setDate(dObj.getDate() + 1);
            }
            $('#txtAttendDT').datepicker('setDate', dObj);
        }
        function ClearField() {
            $("#txtTranNo").val("");
            $("#txtSubject").val("");
            $("#txtIssuesDT").val("");
            $("#txtRRFromDT").val("");
            $("#txtRRToDT").val("");
            $("#txtAttendDT").val("");
        }
        function checkTextOnBlur(obj) {
            if ($("#" + obj.id).val() == "") {
                $("#" + obj.id).css("border-color", "red");
            }
            else {
                $("#" + obj.id).css("border-color", "");
            }
        }
        function CheckFieldValidation() {
            if ($("#txtSubject").val().trim() == "") {
                $("#txtSubject").css("border-color", "red");
                return false;
            }
            return true;
        }
        function GetDoctSignature() {
            var StrDoctCode = '<%:Session["gDoctCode"]%>';
            var datatosend = {
                strdoctcode: StrDoctCode
            }
            $.ajax({
                type: "Post",
                url: "../DoctorDesk/GetSignatory",
                data: datatosend,
                async: false,
                success: function (response) {
                    var data = JSON.parse(response);
                    if (data.length > 0) {
                        if (data[0]["SIGN"] != "") {
                            sign1 = "" + data[0]["SIGN"];
                        }
                        if (data[0]["DIGSIGN1"] != "") {
                            digitsign1 = "data:image/jpeg;base64," + data[0]["DIGSIGN1"];
                        }
                        if (data[0]["SIGN2"] != "") {
                            sign2 = "" + data[0]["SIGN2"];
                        }
                        if (data[0]["DIGSIGN2"] != "") {
                            digitsign2 = "data:image/jpeg;base64," + data[0]["DIGSIGN2"];
                        }
                        if (data[0]["SIGN3"] != "") {
                            sign3 = "" + data[0]["SIGN3"];
                        }
                        if (data[0]["DIGSIGN3"] != "") {
                            digitsign3 = "data:image/jpeg;base64," + data[0]["DIGSIGN3"];
                        }
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $.messager.alert(textStatus, "Error");
                }
            });
        }

        function PrintData(CertificateNo) {
            var Mrno = ($.session.get('PatMRNO'));
            var selectedRow = $('#tblCertificate tbody').find('#' + CertificateNo);
            var strPrintData = [];
            var selSubj = selectedRow.find('.' + "CERTFSUB").text().toString();
            var selTemp = JSON.parse(selectedRow.find('.' + "CERTFBODY").text());
            var IssueDT = selectedRow.find('.' + "ISSUEDT").text().toString();
            //Sign
            strPrintData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
            strPrintData.push("<div id='footerL' style='width:50%;float:left!important;'>");
            strPrintData.push("<div id='PatSign' style='width:60%;border:1px solid black;margin-left: 25px;margin-top: 50px;height: 90px;'></div>");
            strPrintData.push("<table style='float:left!important;font-family:Verdana, sans-serif !important;font-size: 12px !important;margin-top: 10px;'  id='tblPatSignInfo'>");
            strPrintData.push("<tr><td>Verified signature of the Patient's/ Lt. Thumb impression</td></tr>");
            strPrintData.push("</table>");
            strPrintData.push("</div>");
            strPrintData.push("<div id='footerR' style='width:50%;float:right!important;'>");
            strPrintData.push("<table style='float:right!important;font-family:Verdana, sans-serif !important;font-size: 12px !important;'  id='tblDoctInfo'>");
            if (digitsign1 != "")
                strPrintData.push("<tr><td><b><img src=" + digitsign1 + "  /></b></td>");
            if (digitsign2 != "")
                strPrintData.push("<td><b><img src=" + digitsign2 + "  /></b></td>");
            if (digitsign3 != "")
                strPrintData.push("<td><b><img src=" + digitsign3 + "  /></b></td></tr>");
            strPrintData.push("<tr><td><b>Dr. " + selectedRow.find('.' + "ISSUEDOCTNM").text().toString().trim() + "</b></td></tr>");
            if (sign1 != "")
                strPrintData.push("<tr><td><p>" + sign1.replace(/\n/g, "<br />") + "</P></td></tr>");
            else if (sign2 != "")
                strPrintData.push("<tr><td><p>" + sign2.replace(/\n/g, "<br />") + "<p/></td></tr>");
            else if (sign3 != "")
                strPrintData.push("<tr><td><p>" + sign3.replace(/\n/g, "<br />") + "</p></td></tr>");
            strPrintData.push("</table>");
            strPrintData.push("</div></div>");
            strPrintData = strPrintData.join("");
            var datatosend = {
                DoctSignData: encodeURIComponent(strPrintData),
                Tempdata: selTemp,
                Subject: selSubj,
                IssueDT: IssueDT
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/PrintCertificate2",
                async: false,
                data: datatosend,
                dataType: "json",
                success: function (response) {
                    if (response == "Success") {
                        var url = 'DisplayPrintCertifcate2?FormName=' + ($.session.get('PatName').toString() + "-" + selSubj);
                        var win = window.open(url, '', 'width=1024, height=700');
                        win.document.close();
                        win.focus();
                    }
                    else
                        $.messager.alert("Information", response);

                    HoldOn.close();
                },
                error: function () {
                    HoldOn.close();
                    alert('error');
                }
            });
        }
    </script>
</asp:Content>
