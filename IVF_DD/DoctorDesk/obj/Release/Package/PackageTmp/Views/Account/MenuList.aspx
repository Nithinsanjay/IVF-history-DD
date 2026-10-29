<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% OncologyEMR.Models.formrights frmRights = new OncologyEMR.Models.formrights(); %>
    <div id="MainDiv" style="margin-top: 60px;">

        <div>
            <%  if (frmRights.FormRightsCheck("DDConsultation"))
                {  %>
            <div class="col-xs-12 col-sm-12" style="text-align: center;">
                <div class="panel panel-primary" style="border-radius: 52%; margin: auto; cursor: pointer" id="consultting">
                    <div class="panel-body " id="Consultation" style="border-radius: 52%; height: 133px">
                        <%--<a class="bgimg " href="#ContentHolderDiv" style="font-size:10px;">Complaints</a>--%>
                    </div>
                </div>
                <label class="lable_style" id="anchorConsulation">Consultation</label><!--  changed by kavita 30-->
            </div>
            <%} %>

            <%  if (frmRights.FormRightsCheck("DDAdmission"))
                {  %>
            <div class="col-xs-12 col-sm-12" style="text-align: center;">
                <div class="panel panel-primary" style="border-radius: 52%; margin: auto; cursor: pointer" id="addmitting">
                    <div class="panel-body " id="admittingPat" style="border-radius: 52%; height: 133px">
                        <%--<a class="bgimg " href="#ContentHolderDiv" style="font-size:10px;">Complaints</a>--%>
                    </div>
                </div>
                <label class="lable_style" id="anchorAdmission">Admission</label><!--  changed by kavita-->
            </div>
            <%} %>

            <%  if (frmRights.FormRightsCheck("DDInvestigation"))
                {  %>
            <div class="col-xs-12 col-sm-12" style="text-align: center;">
                <div class="panel panel-primary" style="border-radius: 52%; margin: auto; cursor: pointer" id="rptverify">
                    <div class="panel-body " id="PatRptVerify" style="border-radius: 52%; height: 133px">
                    </div>
                </div>
                <label class="lable_style" id="anchorRptVerify">Investigations Verification</label><!--  changed by kavita-->
            </div>
            <%} %>

            <%  if (frmRights.FormRightsCheck("DDPAC"))
                {  %>
            <div class="col-xs-12 col-sm-12" style="text-align: center;">
                <div class="panel panel-primary" style="border-radius: 52%; margin: auto; cursor: pointer" id="rptPAC">
                    <div class="panel-body " id="PAC" style="border-radius: 52%; height: 133px">
                    </div>
                </div>
                <label class="lable_style" id="anchorPAC">Pre-Anesthetic Checkup</label>
            </div>
            <%} %>
        </div>
    </div>

    <div id="HospUnitDiv" style="display: none; height: 100%; width: 99%">
        <a href="#HospUnitDiv" id="btnHospUnitDiv"></a>
        <div style="display: flex; flex-direction: column; align-items: center; justify-content: space-between; padding: 10px; border: 1px solid; border-radius: 5px;">
            <div>
                <label style="font-size: 16px; font-weight: bold;">Select Unit</label>
            </div>
            <div style="width: 100%; margin-bottom: 10px;">
                <select id="cmbHospUnit" class="form-control Mandatory" style="width: 100%; text-align: center; height: 30px; border-radius: 5px;"></select>
            </div>
            <div>
                <input type="button" id="btnHospOk" class="btn btn-primary ContinueBtn"  value="Continue" style="padding: 5px; width: 70px;" onclick="SetHospital()" />
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
      <style type="text/css">
          .ContinueBtn{
              color: #fff !important;background-color: #337ab7 !important;
          }
         .col-xs-12 {
    width: 51%;
    margin: auto;
      float: none !important;
}
         .content-wrapper {
             margin: auto !important;
         }
         .content {
             margin: auto !important;
         }
	 /*added by kavita*/
         .lable_style{
             font-size:14px;
             padding-top: 25px;
             padding-bottom:25px; 
             color: #337ab7;
             display: block;
             cursor:pointer; 
             width: 70%;
             margin-left: 18%;
         }

         @media only screen and (min-width: 992px)
         {
             .panel-primary {
                width: 10vw;
                height: 10vw;
              }

              .panel-body  {
                width: 10vw;
                height: 10vw;
              }

                      .col-xs-12 {
                 width: 100%;
                  margin: auto;
                
	}
	  /*added by kavita*/         
             .lable_style{
             font-size:14px;
             padding-top: 25px;
             padding-bottom:25px; 
             color: #337ab7;
             display: block;
             cursor:pointer; 
             width: 15%;
             margin-left: 43%;
         }

         }

          @media only screen and (max-width: 732px) and (orientation: landscape)
         {
             

                      .col-xs-12 {
                 width: 26%;
                  margin: auto;
                
        }
	 /*added by kavita*/
         .lable_style{
             font-size:14px;
             padding-top: 25px;
             padding-bottom:25px; 
             color: #337ab7;
             display: block;
             cursor:pointer; 
             width: 70%;
             margin-left: 18%;
         }
         }

  
         </style>

    <script type="text/javascript">
        <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var RightUnitList = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(ViewBag.RightUnitList))%>));
        var UnitCd = '<%: Session["UNITCODE"] ?? "" %>';
        $(document).ready(function (e) {
            if (localStorage.getItem('DDUSERID') != null && localStorage.getItem('DDUSERID') != '') {
                localStorage.setItem('DDNAME', '<%:Session["gDoctName"]%>');
                localStorage.removeItem("TEMPUSERID");
            }
            $("#divNotification").hide();
            if (document.getElementById("Consultation") != null) {
                document.getElementById("Consultation").style.backgroundImage = "url( ../Images/consult.png)";
                document.getElementById("Consultation").style.backgroundRepeat = "no-repeat";
                document.getElementById("Consultation").style.backgroundPosition = "center";
            }
            if (document.getElementById("admittingPat") != null) {
                document.getElementById("admittingPat").style.backgroundImage = "url( ../Images/clinicConsult.png)";
                document.getElementById("admittingPat").style.backgroundRepeat = "no-repeat";
                document.getElementById("admittingPat").style.backgroundPosition = "center";
            }
            if (document.getElementById("PatRptVerify") != null) {
                document.getElementById("PatRptVerify").style.backgroundImage = "url( ../Images/LabInvVerify1.png)";
                document.getElementById("PatRptVerify").style.backgroundRepeat = "no-repeat";
                document.getElementById("PatRptVerify").style.backgroundPosition = "center";
            }
            if (document.getElementById("PAC") != null) {
                document.getElementById("PAC").style.backgroundImage = "url( ../Images/LabInvVerify1.png)";
                document.getElementById("PAC").style.backgroundRepeat = "no-repeat";
                document.getElementById("PAC").style.backgroundPosition = "center";
            }
            //added by kavita 30-8-18
            $("#Consultation").click(function () { //anchor name changed by kavita 30-8-18

                //window.location.href = '../ICUMob/ICUReport';
                window.location.href = '../DoctorDesk/PatientEntry';
                //window.location.replace("<%=Url.Action("PatientEntry", "DoctorDesk")%>");
            });


            //added by kavita 30-8-18
            $("#anchorConsulation").click(function () { //anchor name changed by kavita 30-8-18

                //window.location.href = '../ICUMob/ICUReport';
                window.location.href = '../DoctorDesk/PatientEntry';
                //window.location.replace("<%=Url.Action("PatientEntry", "DoctorDesk")%>");
            });


            $("#admittingPat").click(function () { //anchor name changed by kavita 30-8-18

                window.location.href = '../ICUMob/ICUReport';

            });

            $("#anchorAdmission").click(function () { //anchor name changed by kavita 30-8-18

                window.location.href = '../ICUMob/ICUReport';

            });


            $("#PatRptVerify").click(function () { //anchor name changed by kavita 30-8-18

                window.location.href = '../Clinicalnotes/InvestigationVerify';
                <%--//window.location.replace("<%=Url.Action("PatientEntry", "DoctorDesk")%>");--%>
            });

        	$("#anchorRptVerify").click(function () { //anchor name changed by kavita 30-8-18
        		window.location.href = '../Clinicalnotes/InvestigationVerify';
        		<%--//window.location.replace("<%=Url.Action("PatientEntry", "DoctorDesk")%>");--%>
        	});

            $("#PAC").click(function () {
                window.location.href = '../DoctorDesk/PAC';
            });

            $("#anchorPAC").click(function () {
                window.location.href = '../DoctorDesk/PAC';
        	});
            //suchita
            $("#divtabs").show();
            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuList = document.getElementById('menuList');
                menuList.style.display = "block";
                var patList = document.getElementById('patList');
                //suchita
                if ($('#divtabs').css('display') != 'none') {
                    //$("#patList").show(); commented temporarily
                    patList.style.display = "none"; //remove afterward
                }
                else {
                    patList.style.display = "none";
                }
                var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
                AddClinics(urls);
            }

            // added by vijeta on 7th april 2018
            //changed by suchita     07-03-2019
            var lst = document.getElementById('sideList');
            if ($('#divtabs').css('display') != 'none') {
                lst.style.display = "block";
                $("div#sideList ul").hide();
                $("#NewAddNotes").hide();
                $("#SearchPatients").hide();
                // var lst1 = document.getElementById('divAdmSideList');
                // lst1.style.display = "block";
                if ($(window).width() < 996)//added by suchita 
                {
                    //  $("#sideList").css({ "width": "18%" });
                    $("#sideList").css({ "width": "75%" });
                    $("#menuDots").show();
                    lst.style.display = "none";
                    $("#divAdmSideList").hide(); //suchita
                }
                else {
                    $("#sideList").css({ "width": "18%" });
                    $("#menuDots").hide();
                    $("#divAdmSideList").show();
                }
                GetNursStationsNPat();
            }
            else {
                window.onclick = function (event) {
                    lst.style.display = "none";
                }
            }
            BindUnitLst();
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
                    if (UnitCd == "") {
                        this.closeBtn = false;
                    }
                    else {
                        this.closeBtn = true;
                    }
                    $("#cmbHospUnit").val(UnitCd);
                }
            });
            if (UnitCd == "") {
                $("a#btnHospUnitDiv").click();
            }
        });


        ////disable browser back button
        //function noBack() { window.history.forward() }
        ////noBack();
        //window.onload = noBack;
        ////window.onpageshow = function (evt) { if (evt.persisted) noBack() }
        ////window.onunload = function () { void (0) }


        function BindUnitLst() {
            $("#cmbHospUnit").empty();
            var Option = "<option value='{OPTVALUE}'>{OPTEXT}</option>";
            var DefRplOption = Option.replace("{OPTVALUE}", "").replace("{OPTEXT}","---Select---");
            $("#cmbHospUnit").append(DefRplOption);
            $.grep(RightUnitList, function (a) {
                var RplOption = Option.replace("{OPTVALUE}", a.Value).replace("{OPTEXT}", a.Text);
                $("#cmbHospUnit").append(RplOption);
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
                    else {
                        closeWaitingDialog();
                        $.messager.alert("Information", response);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Information", textStatus);
                }
            });
        }
    </script>
    </asp:Content>
