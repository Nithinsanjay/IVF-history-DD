<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.CertificateMdl>" %>

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
            <label id="P_Email"></label>
          <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%">
                <div id="wrapper" style="overflow: hidden; width: 100%">
                    <div class="tableDiv" style="padding-top: 12px;width:100%">
                        <table class="HeadPatTab" style="text-align: center;width:100%">
                           <thead>
                                <tr style="background-color: #fffdc8; font-size: 12px">
                                    <th style="width: 10%;text-align: center;">SI No.</th>
                                    <th style="width: 25%;text-align: center;">Certificate No.</th>
                                    <th style="width: 40%;text-align: center;">Patient Name</th>
                                    <th style="width: 40%;text-align: center;">Subject</th>
                                    <th style="width: 30%;text-align: center;">Doctor Name</th>
                                    <th style="width: 30%;text-align: center;">Created Date / Time</th>
                                    <th style="width: 25%;text-align: center;display:none">MRNO</th>
                                    <th style="width: 25%;text-align: center;display:none">PARA1</th>
                                    <th style="width: 25%;text-align: center;display:none">PARA2</th>
                                    <th style="width: 25%;text-align: center;display:none">PARA3</th>
                                    <th style="width: 25%;text-align: center;display:none">ISSUEDTDET</th>
                                    <th style="width: 25%;text-align: center;display:none">DOCTCODE</th>
                                    <th style="width: 25%;text-align: center;display:none">STATUS</th>
                                    <th style="width: 25%;text-align: center;display:none">CREATEDBY</th>
                                    <th style="width: 35%;text-align: center;">Action</th>
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
        var infotomail = "", infotomail2 = "";
        var strPrintData = [];
        $(document).ready(function (e) {
            BindCertificateGridData();
            GetDoctSignature("");
            $("#P_Email").html( "Registered Email : " + $.session.get('PatEmail')); 
        });
        function SetpageDirctn() {
            window.location.href = '../DoctorDesk/PatientEntry';
        }

        function CertificateAdd(CertificateNo, Action) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" id="CertificateFrm" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size: 20px;display: flex;flex-wrap: nowrap;justify-content: center;">Certificate -' + Action + '</label> <br>' +
                '<input type="text" id="txtTranNo" class="TranNo" style="display:none" />' +
                '<div ><label style="font-size:13px;width:25%">Issued Date</label>' + '<input type="text" style="width:75%;display:inline-block;" id="txtIssueDT" placeholder="Enter Issued Date" maxlength="50" class="IDate form-control Mandatory" onkeyup = "checkTextOnBlur(this);"/></div>' +
                '<div style="margin-top: 5px;"><label style="font-size:13px;width:25%">Subject</label>' + '<input type="text" style="width:75%;display:inline-block;" id="txtSubject" placeholder="Enter Subject" maxlength="250" class="IDate form-control Mandatory" onkeyup = "checkTextOnBlur(this);"/></div> ' +

                '<div style="margin-top: 5px;"><label style="font-size: 13px;width: 25%;vertical-align: top;margin-top: 5px;">Paragraph 1 </label>' + '<textarea  style="width:75%;display:inline-block" id="txtPara1" autocomplete="off" type="varchar" rows="5"  style="" placeholder="Enter Paragraph 1" class="form-control Mandatory"  /></div> ' +
                '<div style="margin-top: 5px;"><label style="font-size: 13px;width: 25%;vertical-align: top;margin-top: 5px;">Paragraph 2 </label>' + '<textarea  style="width:75%;display:inline-block" id="txtPara2" autocomplete="off" type="varchar" rows="5"  style="" placeholder="Enter Paragraph 2" class="form-control"  /></div> ' +
                '<div style="margin-top: 5px;"><label style="font-size: 13px;width: 25%;vertical-align: top;margin-top: 5px;">Paragraph 3 </label>' + '<textarea  style="width:75%;display:inline-block" id="txtPara3" autocomplete="off" type="varchar" rows="5"  style="" placeholder="Enter Paragraph 3" class="form-control"  /></div> ' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: Action == "New" ? 'Save' : Action == "Edit" ? "Update" : "Cancel",
                        btnClass: 'btn-blue',
                        action: function () {
                            if (CheckFieldValidation()) {
                                var IssueDate = $("#txtIssueDT").val();
                                var Subject = $("#txtSubject").val();
                                var Para1 = $("#txtPara1").val();
                                var Para2 = $("#txtPara2").val();
                                var Para3 = $("#txtPara3").val();
                                var TranNo = $("#txtTranNo").val();
                                var Act = Action == "Edit" ? "E" : Action == "Cancel" ? "C" : "N";
                                var Mrno = $.session.get('PatMRNO');
                                var PatName = $.session.get('PatName');
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'SaveCertificate',
                                    data: { Act: Act, TranNo: TranNo, Mrno: Mrno, PatName: PatName, IssueDate: IssueDate, Subject: Subject, Para1: Para1, Para2: Para2, Para3: Para3 },
                                    success: function (response) {
                                        BindCertificateGridData();
                                        $.alert(response);
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
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                    $('#CertificateFrm').find("*").removeAttr('disabled', 'disabled');
                    ClearField();
                    if (Action == "New") {
                        if ($.session.get('PatName') == null || $.session.get('PatName') == "") {
                            $.alert("Please Select the Patient.");
                            this.close();
                            SetpageDirctn();
                        } else {
                            var currentDt = new Date();
                            var strDate = currentDt.getDate() + "/" + (currentDt.getMonth() + 1) + "/" + currentDt.getFullYear();
                            $("#txtTranNo").val("");
                            $("#txtIssueDT").val(currentDt.getDate() + " " + new Date().toLocaleString('en-us', { month: 'short', year: 'numeric' }));
                            $("#txtSubject").val("Fitness Certificate");
                            $("#txtPara1").val(($.session.get('PatName') + " examined by me on ") + strDate);
                            var hisHer = $.session.get('PatGender') == "Male" ? "His" : $.session.get('PatGender') == "Female" ? "Her" : "His/Her";
                            var heShe = $.session.get('PatGender') == "Male" ? "He" : $.session.get('PatGender') == "Female" ? "She" : "He/She"
                            $("#txtPara2").val("All " + hisHer + " Reports are within acceptable limits.");
                            $("#txtPara3").val(heShe + " is found to be fit for employement");
                        }
                    } else {
                        var selectedRow = $('#tblCertificate tbody').find('#' + CertificateNo);
                        $("#txtTranNo").val(CertificateNo);
                        $("#txtIssueDT").val(selectedRow.find('.' + "ISSUEDTDET").text().toString().trim());
                        $("#txtSubject").val(selectedRow.find('.' + "Subject").text().toString().trim());
                        $("#txtPara1").val(selectedRow.find('.' + "CERTFBODY1").text().toString().trim());
                        $("#txtPara2").val(selectedRow.find('.' + "CERTFBODY2").text().toString().trim());
                        $("#txtPara3").val(selectedRow.find('.' + "CERTFBODY3").text().toString().trim());
                        if (Action == "Cancel") {
                            $('#CertificateFrm').find("*").attr('disabled', 'disabled');
                        }
                    }
                    $(".jconfirm-box-container").last().css('width', '480px');
                }
            });

        }

        function ClearField() {
            $("#txtTranNo").val("");
            $("#txtIssueDT").val("");
            $("#txtSubject").val("");
            $("#txtPara1").val("");
            $("#txtPara2").val("");
            $("#txtPara3").val("");
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
            if ($("#txtIssueDT").val().trim() == "") {
                $("#txtIssueDT").css("border-color", "red");
                $("#txtIssueDT").focus();
                return false;
            }
            if ($("#txtSubject").val().trim() == "") {
                $("#txtSubject").css("border-color", "red");
                $("#txtSubject").focus();
                return false;
            }
            if ($("#txtPara1").val().trim() == "" && $("#txtPara2").val().trim() == "" && $("#txtPara3").val().trim() == "") {
                $("#txtPara1").css("border-color", "red");
                $("#txtPara1").focus();
                return false;
            }
            return true;
        }
        function BindCertificateGridData() {
            var Mrno = $.session.get('PatMRNO');
            var tomail = ($.session.get('PatEmail'));
            $.ajax({
                type: "post",
                datatype: "json",
                url: 'BindCertificateList',
                data: { Mrno: Mrno },
                success: function (response) {
                    $('#tblCertificate tbody').empty();
                    for (var i = 0; i < response.length; i++) {
                        var Rows = "<tr class='clickable-row' id='" + response[i].CertificateNo + "'>" +
                            "<td class='SINO' style='width:10%'> " + (i + 1) + "</td>" +
                            "<td class='CertificateNo' style='width:25%'> " + response[i].CertificateNo + "</td>" +
                            "<td class='PatientName' style='width:40%'> " + response[i].PatientName + "</td>" +
                            "<td class='Subject' style='width:40%'> " + response[i].Subject + "</td>" +
                            "<td class='DoctorName' style='width:30%'> " + response[i].DoctorName + "</td>" +
                            "<td class='CreatedDTTM' style='width:30%'> " + response[i].CreatedDTTM + "</td>" +
                            "<td class='MRNO' style='width:30%;display:none'> " + response[i].MRNO + "</td>" +
                            "<td class='CERTFBODY1' style='width:30%;display:none'> " + response[i].CERTFBODY1 + "</td>" +
                            "<td class='CERTFBODY2' style='width:30%;display:none'> " + response[i].CERTFBODY2 + "</td>" +
                            "<td class='CERTFBODY3' style='width:30%;display:none'> " + response[i].CERTFBODY3 + "</td>" +
                            "<td class='ISSUEDTDET' style='width:30%;display:none'> " + response[i].ISSUEDTDET + "</td>" +
                            "<td class='DOCTCODE' style='width:30%;display:none'> " + response[i].DOCTCODE + "</td>" +
                            "<td class='STATUS' style='width:30%;display:none'> " + response[i].STATUS + "</td>" +
                            "<td class='CREATEDBY' style='width:30%;display:none'> " + response[i].CREATEDBY + "</td>" +
                            "<td class='Action' style='width:35%'>" +
                            "<a href='javascript:;' style='font-size: 20px;' onclick='CertificateAdd(\"" + response[i].CertificateNo + "\",\"Edit\");'><i class='fa fa-pencil' aria-hidden='true'></i></a> " +
                            "<a href='javascript:;' style='font-size: 20px;margin-left: 10px;' onclick='CertificateAdd(\"" + response[i].CertificateNo + "\",\"Cancel\");'><i class='fa fa-trash' aria-hidden='true'></i></i></a> " +
                            "<a href='javascript:;' style='font-size: 20px;margin-left: 10px;' onclick='PrintData(\"" + response[i].CertificateNo + "\",);'><i class='fa fa-print' aria-hidden='true'></i></a> " +
                            (tomail != "" && tomail != null ? "<a href='javascript:;' style='font-size: 20px;margin-left: 10px;' onclick='SendMailAction(\"" + response[i].CertificateNo + "\",);'><i class='fa fa-envelope' aria-hidden='true'></i></a> " : "") +
                            "</td>" +
                            "</tr>";
                        $('#tblCertificate tbody').append(Rows);
                    }
                },
            });
        }
        function GetDoctSignature(StrDoctCode) {
            //var StrDoctCode = '<%:Session["gDoctCode"]%>';
            if (StrDoctCode != "") {
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
        }
        function PrintBind(CertificateNo) {
            var Mrno = ($.session.get('PatMRNO'));
            var selectedRow = $('#tblCertificate tbody').find('#' + CertificateNo);
            strPrintData = [];
            var selSubj = selectedRow.find('.' + "Subject").text().toString().trim();
            var DoctCode = selectedRow.find('.' + "DOCTCODE").text().toString().trim();

            GetDoctSignature(DoctCode);

            strPrintData.push("<html><body>");
            strPrintData.push("<style>.IssDate{width:100%;float:left} .Header{text-align:center;font-size:30px;text-decoration: underline;font-weight: bold;} .Paragraph{font-size : 18px}</style>");
            strPrintData.push("<div class='IssDate'>" + selectedRow.find('.' + "ISSUEDTDET").text().toString().trim() + "</div><br><br><br>");
            strPrintData.push("<div class='Header'>" + selectedRow.find('.' + "Subject").text().toString().trim() + "</div><br><br>");
            if (selectedRow.find('.' + "CERTFBODY1").text().toString().trim() != "")
                strPrintData.push("<div class='Paragraph'>" + selectedRow.find('.' + "CERTFBODY1").text().toString().trim() + "</div><br><br>");
            if (selectedRow.find('.' + "CERTFBODY2").text().toString().trim() != "")
                strPrintData.push("<div class='Paragraph'>" + selectedRow.find('.' + "CERTFBODY2").text().toString().trim() + "</div><br><br><br>");
            if (selectedRow.find('.' + "CERTFBODY3").text().toString().trim() != "")
                strPrintData.push("<div class='Paragraph'>" + selectedRow.find('.' + "CERTFBODY3").text().toString().trim() + "</div>");
            //Sign
            strPrintData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
            strPrintData.push("<table style='float:right!important;font-family:Verdana, sans-serif !important;font-size: 12px !important;'  id='tblDoctInfo'>");
            if (digitsign1 != "")
                strPrintData.push("<tr><td><b><img src=" + digitsign1 + "  /></b></td>");
            if (digitsign2 != "")
                strPrintData.push("<td><b><img src=" + digitsign2 + "  /></b></td>");
            if (digitsign3 != "")
                strPrintData.push("<td><b><img src=" + digitsign3 + "  /></b></td></tr>");
            strPrintData.push("<tr><td><b>Dr. " + selectedRow.find('.' + "DoctorName").text().toString().trim() + "</b></td></tr>");
            if (sign1 != "")
                strPrintData.push("<tr><td><p>" + sign1.replace(/\n/g, "<br />") + "</P></td></tr>");
            else if (sign2 != "")
                strPrintData.push("<tr><td><p>" + sign2.replace(/\n/g, "<br />") + "<p/></td></tr>");
            else if (sign3 != "")
                strPrintData.push("<tr><td><p>" + sign3.replace(/\n/g, "<br />") + "</p></td></tr>");
            strPrintData.push("</table>");
            strPrintData.push("</div>");
            strPrintData.push("</body></html>");
            strPrintData = strPrintData.join("");
            return strPrintData;
        }
        function PrintData(CertificateNo) {
            var Mrno = ($.session.get('PatMRNO'));
            var selectedRow = $('#tblCertificate tbody').find('#' + CertificateNo);
            var selSubj = selectedRow.find('.' + "Subject").text().toString().trim();
            var DoctCode = selectedRow.find('.' + "DOCTCODE").text().toString().trim();
            strPrintData = [];
            PrintBind(CertificateNo);
            var datatosend = {
                printdata: encodeURIComponent(strPrintData),
                DoctCode: DoctCode,
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/PrintCertificate",
                async: false,
                data: datatosend,
                dataType: "json",
                success: function (response) {
                    if (response == "Success") {
                        var url = 'DisplayPrintCertifcate?FormName=' + ($.session.get('PatName').toString() + "-" + selSubj);
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

        function SendMailAction(CertificateNo) {
            strPrintData = [];
            PrintBind(CertificateNo);
            if (strPrintData == "") {
                $.messager.alert("Information", "Please Select Certificate to send Email");
                return false;
            }
            var tomail = ($.session.get('PatEmail'));
            if (tomail != "" && tomail != null) {
                Callajxmail(tomail, CertificateNo)
            } else {
                $.messager.alert("Information", "Email ID is not registered.");
                return false;
            }
        }
        function Callajxmail(tomail, CertificateNo) {
            HoldOn.open();
            var Mrno = ($.session.get('PatMRNO'));
            var selectedRow = $('#tblCertificate tbody').find('#' + CertificateNo);
            var selSubj = selectedRow.find('.' + "Subject").text().toString().trim();
            var DoctCode = selectedRow.find('.' + "DOCTCODE").text().toString().trim();
            var datatosend = {
                printdata: encodeURIComponent(strPrintData),
                TranNo: ($.session.get('PatTRANNO')),
                ToMailId: tomail,
                Mrno: Mrno,
                printdataTop: "",
                Subject: selSubj,
                DoctorCode: DoctCode
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/SendMailAction",
                async: false,
                data: datatosend,
                dataType: "json",
                success: function (response) {
                    $.messager.alert("Information", response);
                    HoldOn.close();
                },
                error: function () {
                    alert('error');
                    HoldOn.close();
                }
            });

        }

    </script>
</asp:Content>
