<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>
<script type="text/javascript">
    var forignPatCheck = false;
    var companyPatYN = false;
    var timeOutFun;
    //var FormName = "";//------------sOMNATH------------
    $(document).ready(function () {
        $('#imgPatientdet').attr('src', '../Images/UpAero.png');
        $('#imgPatientdet').click(function () {
            if ($('#tdPatientdet')[0].style.display != "none") {
                $('#tdPatientdet').fadeOut("fast");
                $('#imgPatientdet').attr('src', '../Images/downAero.png');
            }
            else {
                $('#tdPatientdet').fadeIn("fast");
                $('#imgPatientdet').attr('src', '../Images/UpAero.png');
            }
        });
    });

    function fillUCdata(ROWDATA) {
       
        if (ROWDATA != "" && ROWDATA != null && ROWDATA != undefined) {
            $("#PatInfoCtrl #txtUCSalutation").val(ROWDATA['SALUTATION']);
            $("#PatInfoCtrl #txtUCPatname").val(ROWDATA['PATNAME']);
            $("#PatInfoCtrl #txtUCMrNo").val(ROWDATA['MRNO']);
            $("#PatInfoCtrl #txtUCGender").val(ROWDATA['GENDER']);
            $("#PatInfoCtrl #txtUCpatCatgCd").val(ROWDATA['PATIENTCAT']); 
            $("#PatInfoCtrl #txtUCCompNm").val(ROWDATA['COMPANY']);
            $("#PatInfoCtrl #txtUCstrDOB").val(ROWDATA['PATDOB']);
            $("#PatInfoCtrl #txtUCContactNo").val(ROWDATA['CONTACT']);
            $("#PatInfoCtrl #txtUCTariffCatg").val(ROWDATA['TARIFF']);
            $("#PatInfoCtrl #txtUCPayType").val(ROWDATA['PAYTYPE']);
            $("#PatInfoCtrl #txtUCExemptioncat").val(ROWDATA['COCANAME']);
            $("#PatInfoCtrl #txtEmpId").val(ROWDATA['EMPID']);
            if (ROWDATA['PATIENTCAT'] != "") {
                var url = '../DoctorDesk/checkpatcatSetupval?patcat=' + ROWDATA['PATIENTCAT'];
                //$.post(url, function (data) {
                //    checkdata(data, ROWDATA);
                //}, "json");
                $.ajax({
                    type: "POST",
                    url: url,
                    datatype: "json",
                    asyn: false,
                    success: function (data) {
                       // checkOPdataPatInfo(data, ROWDATA);// ---------change fun name 06/01/2017-----sOMNATH
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(textStatus + "       " + errorThrown + "\n" + XMLHttpRequest.responseText)
                        location.reload();
                    }
                });
            }

            $.ajax({                                                                   //vishal 20th Sept
                type: "POST",
                url: '../DoctorDesk/getAge?dateOB=' + ROWDATA['PATDOB'],
                dataType: "json",
                success: function (response) {
                    if (response == "") {
                        alert("Please update proper DOB and Age in Registration details first.");
                        PatInfoClearControl();
                    } else
                        $("#PatInfoCtrl #txtUCAge").val(response);
                },
                onerror: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('Error while calculating current age.', 'Error Information');
                }
            });
            //     $("#PatInfoCtrl #txtUCAge").val(ROWDATA['PATAGE']);
            $("#PatInfoCtrl #txtUCPriorityCode").val(ROWDATA['PRIORITY']);
            $("#PatInfoCtrl #txtUCPriority").val(ROWDATA['PRIODESC']);
            if (ROWDATA["PRIORITY"] == "H" || ROWDATA["PRIORITY"] == "V" || ROWDATA["PRIORITY"] == "I") {
                $("#PatInfoCtrl #txtUCPriority").val(ROWDATA['PRIODESC']);
                //refreshIntervalId = setInterval(function () { setColor() }, 500);
            }
            else {
                //stopColor();
                $("#PatInfoCtrl #txtUCPriority").val(ROWDATA['PRIODESC']);
            }
            clearTimeout(timeOutFun);
            setColor();

            //Meenakshi
            $("#PatInfoCtrl #txtUCScheme").val(ROWDATA['SCHEME']);
            $("#PatInfoCtrl #txtCapYN").val(ROWDATA['CAPYN']);
            $("#PatInfoCtrl #txtUCLimit").val(ROWDATA['CARDLIMIT']);
            $("#PatInfoCtrl #txtUCMemberID").val(ROWDATA['MEMBERID']);

            $("#PatInfoCtrl #txtUCEmpname").val(ROWDATA['EMPNAME']);

            if ($("#txtUCCompNm").val().toString().trim() != "") {
                $("#extraDet")[0].style.display = "";
            }
            else {
                $("#extraDet")[0].style.display = "none";
            }
            //Added by Murali on 29/07/2024
            //**************************************************************************************************
            if ($("#txtUCEmpname").val().toString().trim() != "") {
                $("#DepenDet")[0].style.display = "";
            }
            else {
                $("#DepenDet")[0].style.display = "none";
            }
            //**************************************************************************************************
        }
    }
   
    // This for redirecting back from another form
    function fillUCdatas(ROWDATA) {
        $("#PatInfoCtrl #txtUCSalutation").val(ROWDATA.rows[0].cell[13]);
        $("#PatInfoCtrl #txtUCPatname").val(ROWDATA.rows[0].cell[1]);
        $("#PatInfoCtrl #txtUCMrNo").val(ROWDATA.rows[0].cell[0]);
        $("#PatInfoCtrl #txtUCGender").val(ROWDATA.rows[0].cell[4]);
        $("#PatInfoCtrl #txtUCpatCatgCd").val(ROWDATA.rows[0].cell[8]);
        $("#txtEmpId").val(ROWDATA.rows[0].cell[33])
        if (ROWDATA.rows[0].cell[8] != "") {
            var url = '../DoctorDesk/checkpatcatSetupval?patcat=' + ROWDATA.rows[0].cell[8];
            $.ajax({
                type: "POST",
                url: url,
                datatype: "json",
                asyn: false,
                success: function (data) {
                //    checkdataPatInfos(data, ROWDATA);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    MsgDia('An error occurred while processing your request.', 'Error Information');
                }
            });
        }
        $("#PatInfoCtrl #txtUCCompNm").val(ROWDATA.rows[0].cell[11]);
        $("#PatInfoCtrl #txtUCstrDOB").val(ROWDATA.rows[0].cell[2]);
        $("#PatInfoCtrl #txtUCContactNo").val(ROWDATA.rows[0].cell[10]);
        $("#PatInfoCtrl #txtUCTariffCatg").val(ROWDATA.rows[0].cell[9]);
        $("#PatInfoCtrl #txtUCPayType").val(ROWDATA.rows[0].cell[12]);
        $("#PatInfoCtrl #txtUCAge").val(ROWDATA.rows[0].cell[3]);
        $("#PatInfoCtrl #txtUCPriority").val(ROWDATA.rows[0].cell[25]);
        $("#PatInfoCtrl #txtUCPriorityCode").val(ROWDATA.rows[0].cell[19]);
        if (ROWDATA.rows[0].cell[19] == "H" || ROWDATA.rows[0].cell[19] == "V" || ROWDATA.rows[0].cell[19] == "I") {
            $("#PatInfoCtrl #txtUCPriority").val(ROWDATA.rows[0].cell[25]);
        }
        else {
            $("#PatInfoCtrl #txtUCPriority").val(ROWDATA.rows[0].cell[25]);
        }
        //Admission Form Contact details  ---sOMNATH
        $("#txtCAdd1").val(ROWDATA.rows[0].cell[5]); $("#txtCAdd2").val(ROWDATA.rows[0].cell[6]); $("#txtCAdd3").val(ROWDATA.rows[0].cell[7]);// $("#cmbCCitySel").val(jsnPat.CCitySel);
        //$("#cmbCDistrictSel").val(ROWDATA.rows[0].cell[5]); $("#cmbCStateSel").val(ROWDATA.rows[0].cell[5]); $("#cmbCCountrySel").val(ROWDATA.rows[0].cell[5]); $("#txtCPinCode").val(ROWDATA.rows[0].cell[5]);
        $("#txtCMobile").val(ROWDATA.rows[0].cell[10]); //$("#txtCTelR").val(ROWDATA.rows[0].cell[5]); $("#txtCTelO").val(ROWDATA.rows[0].cell[5]);
        //end
        setColor();
        var PATMRNO = ROWDATA.rows[0].cell[0];
        var TARIFF = ROWDATA.rows[0].cell[9];
        var COMPANY = ROWDATA.rows[0].cell[11];
        var EXEMPTION = ROWDATA.rows[0].cell[16];
        //if (FormName == "Consultation")
        //    fillNewdata(PATMRNO, TARIFF, COMPANY, EXEMPTION);

        //Meenakshi
        $("#PatInfoCtrl #txtUCScheme").val(ROWDATA.rows[0].cell[38]);
        $("#PatInfoCtrl #txtCapYN").val(ROWDATA.rows[0].cell[39]);
        $("#PatInfoCtrl #txtUCLimit").val(ROWDATA.rows[0].cell[14]);
        $("#PatInfoCtrl #txtUCMemberID").val(ROWDATA.rows[0].cell[37]);
        //Added by Murali on 29/07/2024
        //**************************************************************************************************
        if (ROWDATA.rows[0].cell[33] !="")
            $("#PatInfoCtrl #txtUCEmpname").val(ROWDATA.rows[0].cell[41] + " - " + ROWDATA.rows[0].cell[33]);
        if ($("#txtUCEmpname").val().toString().trim() != "") {
            $("#DepenDet")[0].style.display = "";
        }
        else {
            $("#DepenDet")[0].style.display = "none";
        }
        //**************************************************************************************************
        if (ROWDATA.rows[0].cell[0] != "") {
            var url = '../DoctorDesk/GetBillInfo' ;
            $.ajax({
                type: "POST",
                url: url,
                datatype: "json",
                data : {strConsNo : ('' +sessionStorage.getItem('PatTRANNO')).toString().trim()},
                asyn: false,
                success: function (data) {
                    //checkdataPatInfos(data, ROWDATA);
                    if (data[0].TOTBillAmt != "") {
                        $("#txtBillAmt").val(data[0].TOTBillAmt); $("#txtAvailLimit").val(data[0].AvailLimit); $("#txtBalance").val(data[0].Balance);
                        $("#PatInfoCtrl #txtUCCompNm").val(data[0].CompName);
                        $("#PatInfoCtrl #txtUCpatCatgCd").val(data[0].PatCatgName);
                        $("#PatInfoCtrl #txtUCTariffCatg").val(data[0].TariffName);
                    }

                }, 
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    MsgDia('An error occurred while processing your request.', 'Error Information');
                }
            });
        }
    }

    function setColor() {
        var interval = 500;
        var colour1 = "white"
        var colour2 = "red";
        var x = document.getElementById("txtUCPriority");
        var code = $("#PatInfoCtrl #txtUCPriorityCode").val();
        if (code.trim() == "H" || code.trim() == "V" || code.trim() == "I") {
            //var element = document.getElementById("txtUCPriority");
            x.style.color = (x.style.color == colour1) ? colour2 : colour1;
            x.style.fontWeight = "Bold";
            timeOutFun=  setTimeout("setColor('txtUCPriority')", interval);
        }
        else {
            //var x = document.getElementById("txtUCPriority");
            x.style.color = "black";
            x.style.fontWeight = "";
        }
    }
   
    function PatInfoClearControl() {
        $("#PatInfoCtrl #txtUCSalutation").val("");
        $("#PatInfoCtrl #txtUCPatname").val("");
        $("#PatInfoCtrl #txtUCMrNo").val("");
        $("#PatInfoCtrl #txtUCGender").val("");
        $("#PatInfoCtrl #txtUCpatCatgCd").val("");
        $("#PatInfoCtrl #txtUCCompNm").val("");
        $("#PatInfoCtrl #txtUCstrDOB").val("");
        $("#PatInfoCtrl #txtUCContactNo").val("");
        $("#PatInfoCtrl #txtUCTariffCatg").val("");
        $("#PatInfoCtrl #txtUCPayType").val("");
        $("#PatInfoCtrl #txtUCAge").val("");
        $("#PatInfoCtrl #txtUCPriority").val("");
        $("#PatInfoCtrl #txtUCExemptioncat").val("");
    }

    function checkOPdataPatInfo(jsondata, ROWDATA) {     //---------change fun name 06/01/2017 sOMNATH-----checkdataPatInfo
        if (jsondata == "COMPANY") {
            companyPatYN = true;
            //$("#Combillamt")[0].readOnly = false;
            //$("#Patbillamt")[0].readOnly = false;
            document.getElementById("lblcompany").innerHTML = "Company";
            $("#txtUCCompNm")[0].style.display = "";
            $("#txtUCExemptioncat")[0].style.display = "none";
            //pradnya
            $("#txtEmpId")[0].style.display = "none";
            $("#lblEmpid")[0].style.display = "none";
            $("#PatInfoCtrl #txtUCCompNm").val(ROWDATA['COMPANY']);
            $("#PatInfoCtrl #txtUCExemptioncat").val("");
        }
        else {
            companyPatYN = false;
            //$("#Combillamt")[0].readOnly = true;
            //$("#Patbillamt")[0].readOnly = true;
            if ($("#txtUCExemptioncat").val() == "Staff" ) {
                document.getElementById("lblcompany").innerHTML = "Exem Cat";
                $("#txtUCCompNm")[0].style.display = "none";
                //pradnya
                $("#txtUCExemptioncat")[0].style.display = "";
                $("#txtEmpId")[0].style.display = "";
                $("#lblEmpid")[0].style.display = "";
                $("#txtUCExemptioncat")[0].style.width = "11.8%";
                $("#txtEmpId")[0].style.width = "8.2%";
                $("#PatInfoCtrl #txtUCCompNm").val("");
                $("#PatInfoCtrl #txtUCExemptioncat").val(ROWDATA['COCANAME']);
                //31/05/2019
                $("#PatInfoCtrl #txtEmpId").val(ROWDATA['EMPID']);
            }
            else {
                document.getElementById("lblcompany").innerHTML = "Exem Cat";
                $("#txtUCExemptioncat")[0].style.width = "192px";
                $("#txtUCExemptioncat")[0].style.display = "";
                $("#txtEmpId")[0].style.display = "none";
                $("#lblEmpid")[0].style.display = "none";
                $("#txtUCCompNm")[0].style.display = "none";
            }
        }


    }
</script>
<style type="text/css">
    .blink {
        color: #ff0000 !important;
        background: #FC79CE;
       }
    TextBxFormat{
        font-size: 14px !important;
    }
    
element.style {
}
.panel-heading {
    padding: 2px 5px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 7px;
    border-top-right-radius: 7px;
    background: #24417c;
    color: white;
}
</style>
<form id="PatInfoCtrl" action="./" runat="server">
    <div class="panel-heading">
        <span id="lblOPSearchHeader" style="font-size:14px;font-weight:bold;">Patient Info</span>
                     
    </div>
    <fieldset style="border-width: 1px;
    border: 1px solid #6192f7;
    padding: 5px;
    font-size: 12px;
    font-weight: 600;
    font-family: 'Droid Sans', sans-serif;">
        
        <table cellpadding="1" id="tdPatientdet" cellspacing="0" style="margin-bottom: 2px;padding: 5px;display: table;margin-top: 5px; scroll-behavior: auto;">
            <tr>
                <td>
                    <label class="LBLFormat">Name</label></td>
                <td><%: Html.TextBoxFor(m => Model.strSalutation, new { id = "txtUCSalutation", @class = "TextBxFormat", Style = "width:50px;margin-bottom:2px;", @readonly = "readonly" ,@tabindex = "-1" })%>
                    <%: Html.TextBoxFor(m => Model.strPatNm, new { id = "txtUCPatname", @class = "TextBxFormat", Style = "width:357px;", @readonly = "readonly", @tabindex = "-1" })%> </td>
                <td>
                    <label class="LBLFormat">MR</label></td>
                <td><%: Html.TextBoxFor(m => Model.strMrNo, new { id = "txtUCMrNo", @class = "TextBxFormat", Style = "width:90px;", @readonly = "readonly", @tabindex = "-1" })%></td>
                <td>
                    <label class="LBLFormat">Gender</label></td>
                <td><%: Html.TextBoxFor(m => Model.strGender, new { id = "txtUCGender", @class = "TextBxFormat", Style = "width:142px;", @readonly = "readonly", @tabindex = "-1" })%></td>
            </tr>
            <tr>
                <td>
                    <label class="LBLFormat">Category</label></td>
                <%--<td><%: Html.TextBoxFor(m => m.strpatCatgCd, new { id = "txtUCpatCatgCd", @class = "TextBxFormat", Style = "width:155px;background:white;color:Black;font-size: 13.5px;font-family: Calibri,Arial;", disabled = "disabled" })%>
    <label class="LBLFormat">Company</label>
    <%: Html.TextBoxFor(m => m.strCompNm, new { id = "txtUCCompNm", @class = "TextBxFormat", Style = "width:185px;background:white;color:Black;font-size: 13.5px;font-family: Calibri,Arial;", disabled = "disabled" })%>&nbsp;&nbsp;</td>--%>
                <td><%: Html.TextBoxFor(m => Model.strpatCatgCd, new { id = "txtUCpatCatgCd", @class = "TextBxFormat", Style = "width:155px;background: #e7e3e3; color: #eb0808;", @readonly = "readonly", @tabindex = "-1" })%>
                    <%if (Model.strCompNm != "")
                      {
                    %>
                    <%:Html.Label("Company",new {@class="LBLFormat",id="lblcompany"}) %>
                    <%: Html.TextBoxFor(m => Model.strCompNm, new { id = "txtUCCompNm", @class = "TextBxFormat", Style = "width:198px;", @readonly = "readonly", @tabindex = "-1" })%>
               
                    <%if (Model.strExemptioncat != "002" || Model.strExemptioncat != "004")
                      {
                    %>
                         <%: Html.TextBoxFor(m => Model.strExemptioncat, new { id = "txtUCExemptioncat", @readonly = true, @class = "TextBxFormat", Style = "width:12.5%;display:none;    width: 198px;", @tabindex = "-1" })%>
                      <span>
                          <%:Html.Label("EmpId",new {@class="LBLFormat",id="lblEmpid",style="font-weight:bold;color:#FF0000;display:none;" })%>
                          <%: Html.TextBoxFor(m => Model.strEmployeeId, new { id = "txtEmpId", @readonly = true,@class = "TextBxFormat",Style = "width:8.2%;display:none;", @tabindex = "-1" })%></span>
                    <%} %>
                       <%else
                      { %>
                         <%: Html.TextBoxFor(m => Model.strExemptioncat, new { id = "txtUCExemptioncat", @readonly = true, @class = "TextBxFormat", Style = "width:192px;display:none;", @tabindex = "-1" })%>
                      <%} %>
                     <%} %>
                    <%else
                      { %>
                    <%: Html.Label("ExemCat","Exem Cat",new{ @class="LBLFormat",id="lblcompany"}) %>
                    <%: Html.TextBoxFor(m => Model.strCompNm, new { id = "txtUCCompNm", @class = "TextBxFormat", Style = "width:185px;display:none;", @readonly = "readonly", @tabindex = "-1" })%>
                 
                      <%if (Model.strExemptioncat == "Staff" )
                      {
                    %>
                                        <%: Html.TextBoxFor(m => Model.strExemptioncat, new { id = "txtUCExemptioncat", @readonly = true, @class = "TextBxFormat", Style = "width:12.5%;", @tabindex = "-1" })%>
                       <span>
                          <%:Html.Label("EmpId",new {@class="LBLFormat",id="lblEmpid",style="font-weight:bold;color:#FF0000;background: #e7e3e3; color: #eb0808;"})%>
                          <%: Html.TextBoxFor(m => Model.strEmployeeId, new { id = "txtEmpId", @readonly = true, @class = "TextBxFormat", Style = "width:8.2%;", @tabindex = "-1" })%></span>
                    <%} %>
                     <%else
                      { %>
                                        <%: Html.TextBoxFor(m => Model.strExemptioncat, new { id = "txtUCExemptioncat", @readonly = true, @class = "TextBxFormat", Style = "width:192px;", @tabindex = "-1" })%>
                     <%} %>
                    <%} %> </td>
                <td>
                    <label class="LBLFormat">DOB</label></td>
                <td><%: Html.TextBoxFor(m => Model.strDOB, new { id = "txtUCstrDOB", @class = "TextBxFormat", Style = "width:90px;", @readonly = "readonly", @tabindex = "-1"  })%></td>
                <td>
                    <label class="LBLFormat">Contact</label></td>
                <td><%: Html.TextBoxFor(m => Model.strContactNo, new { id = "txtUCContactNo", @class = "TextBxFormat", Style = "width:142px;", @readonly = "readonly", @tabindex = "-1" })%></td>
            </tr>
            <tr>
                <td>
                    <label class="LBLFormat">Tariff</label></td>
                <td><%: Html.TextBoxFor(m => Model.strTariffCatg, new { id = "txtUCTariffCatg", @class = "TextBxFormat", Style = "width:155px;", @readonly = "readonly", @tabindex = "-1" })%>
                    <label class="LBLFormat" style="/*margin-left: -2px;*/">Pay Type</label>
                    <%: Html.TextBoxFor(m => Model.strPayType, new { id = "txtUCPayType", @class = "TextBxFormat", Style = "    width: 198px;  margin-left: 0.5%;", @readonly = "readonly", @tabindex = "-1"  })%>
                </td>
                <td>
                    <label class="LBLFormat">Age</label></td>
                <td><%: Html.TextBoxFor(m => Model.strAge, new { id = "txtUCAge", @class = "TextBxFormat", Style = "width:90px;", @readonly = "readonly", @tabindex = "-1"  })%></td>
                <td>
                    <label class="LBLFormat">Priority</label></td>
                <td><%: Html.TextBoxFor(m => Model.strPriority, new { id = "txtUCPriority", @class = "TextBxFormat", Style = "width:142px;", @readonly = "readonly", @tabindex = "-1"  })%>
                    <%: Html.TextBoxFor(m => Model.strPriorityCode, new { id = "txtUCPriorityCode", Style = "display:none;"})%>
                </td>
            </tr>
             <tr id="DepenDet" style="display:none;"> 
                <td>
                    <label class="LBLFormat">Emp.</label></td>
                <td>
                    <%: Html.TextBoxFor(m => Model.strEmpName, new { id = "txtUCEmpname", @class = "TextBxFormat", Style = "width:408px;", @readonly = "readonly", @tabindex = "-1" })%> 
                </td>
            </tr>
             <tr id="extraDet" style="display:none;"> 
                <td>
                    <label class="LBLFormat">Scheme</label></td>
                <td><%: Html.TextBoxFor(m => Model.strScheme, new { id = "txtUCScheme", @class = "TextBxFormat", Style = "width:301px;", @readonly = "readonly", @tabindex = "-1" })%>
                    <label class="LBLFormat">CAP</label>
                    <%: Html.TextBoxFor(m => Model.strCapYN, new {  id = "txtCapYN", @class = "TextBxFormat", Style = "width:75px; margin-left: 0.5%;", @readonly = "readonly", @tabindex = "-1"  })%>
                </td>
                <td>
                    <label class="LBLFormat">Limit</label></td>
                <td><%: Html.TextBoxFor(m => Model.strLimit, new { id = "txtUCLimit", @class = "TextBxFormat", Style = "width:90px;", @readonly = "readonly", @tabindex = "-1"  })%></td>
                <td>
                    <label class="LBLFormat">Member ID</label></td>
                <td><%: Html.TextBoxFor(m => Model.strMemberID, new { id = "txtUCMemberID", @class = "TextBxFormat", Style = "width:142px;", @readonly = "readonly", @tabindex = "-1"  })%>
                  
                </td>
            </tr>
            
        </table>

    </fieldset>


    <div id="divBillInfo" style="margin-top: 5px;">

<div class="panel-heading" >
        <span id="" style="font-size:14px;font-weight:bold;">Bill Info</span>
    </div>
    <fieldset style="border-width: 1px;
    border: 1px solid #6192f7;
    padding: 5px;
    font-size: 12px;
    font-weight: 600;
    font-family: 'Droid Sans', sans-serif;">
          <table style ="width:100%;" id="tblBillInfo">
            <tr> 
                <td>
                    <label class="LBLFormat">Bill Amount</label></td>
                <td>
                    <%: Html.TextBox("BillAmt","" , new { id = "txtBillAmt", @class = "TextBxFormat", Style = "", @readonly = "readonly"})%>
                </td>
                <td>
                    <label class="LBLFormat">Available Limit</label></td>
                <td><%: Html.TextBox("Limit","" ,new { id = "txtAvailLimit", @class = "TextBxFormat", Style = "width:90px;", @readonly = "readonly"  })%></td>
                <td>
                    <label class="LBLFormat">Balance </label></td>
                <td><%: Html.TextBox("Balance", "",new { id = "txtBalance", @class = "TextBxFormat", Style = "font-weight:bold;width:142px;background: #e7e3e3; color: #eb0808;", @readonly = "readonly"  })%>
                </td>
            </tr>
        </table>
        </fieldset>
    </div>
</form>
