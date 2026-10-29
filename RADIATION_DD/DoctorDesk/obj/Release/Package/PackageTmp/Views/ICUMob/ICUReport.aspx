<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.ICUMobModels>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="MainDiv" ><%-- style="text-align:center;"--%> <%--Meenakshi--%>

        <span id="DATE" style="display: none; line-height: 19px; margin-left: 12px;">Date :</span><%=Html.TextBoxFor(x => Model.strDate, new { id="Rptdate",@class = "TextBxFormat",@style="width:90px; readonly :true;     margin-top: 6px; margin-left: 20px;display:none", @readonly=true })%>
        <%-- <button class="btn btn-primary"
            id="btnIpPrescriptions" type="submit" style="background-color: #154158; outline: 0; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px;">
            Prescriptions
        </button> --%>

         <button class="btn btn-primary"
            id="btnCriticalCareGraph" type="submit" style="background-color: #154158; outline: 0; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px;">
            Critical Care Flow Sheet
        </button>

        <button class="btn btn-primary" id="btnRespiratoryAssessment" type="submit" style="background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Respiratory Assessment
        </button>

        <button class="btn btn-primary" id="DateWiseMaxTempReport"
            type="submit" style="background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Max Temperature Report        
        </button>

        <button class="btn btn-primary" id="btnInvestigationChart" type="submit" style="background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Investigation Chart      
        </button>

         <button class="btn btn-primary" id="btnDiabeticChart" type="submit" style="background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Diabetic Chart       
        </button>
  	    <button class="btn btn-primary" id="btnDiacomImages" type="submit" style="background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Dicom Images
        </button>
        <button class="btn btn-primary" id="btnTreatmentSheet" type="submit" style="display:none;background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Treatment Sheet
        </button>
        <button class="btn btn-primary" id="btnInvestigationReport" type="submit" style="background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Investigation Report
        </button>
        <%--  done by --%>
        <button class="btn btn-primary" id="btnDocuments" type="submit" style="background-color: #154158; box-shadow: #a1b4c7 1px 2px 2px 2px; margin-top: 15px; width: 61%; margin-left: 10px; border-bottom-left-radius: 46px; border-top-right-radius: 46px; outline: 0;">
            Documents
        </button>
       <%-- end--%>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .panel-body
        {
            height:auto !important;
            width:auto !important;
        }

          /*added by vijeta on 9th Aug 2018*/
        .expanded {
            display:block;
        }
    </style>

    <script src="../Scripts/ICUPatList.js"></script>
    <script type="text/javascript">
        var DMSURL = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("LOCALDMSURL")%>'; //meenakshi 
        $(document).ready(function (e) {

            GetNursStationsNPAtients();
            SetPatientDtl();
            SetDateTime();

            if (DMSURL == "")
                $("#btnDocuments").hide();

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                //var dispLst = document.getElementById('sideList');
                //dispLst.style.display = "block";
            }

            $('#btnsDiv').click(function () {
                $("#cmbNursLst").select2("val", gblNurscode);
            });

            $('#btnCriticalCareGraph').click(function (e) {
                if (CheckPatSessionNotEmpty()) {
                    var strDate = $("#Rptdate").val();
                    var strIPNO = $.session.get('ICUPatIPNO');
                    window.location.href = '../ICUMob/CriticalCareGraph1?strIPNO=' + strIPNO + '&&strDate=' + strDate;
                    //var strDate = $("#Rptdate").val();
                 
                    //$.ajax({
                    //    url: '../ICUMob/SetCritCareGraphDate?strDate=' + strDate + '&&strIPNo=' + strIPNO,
                    //    type: "POST",
                    //    dataType: "JSON",
                    //    success: function (response) {
                     
                    //        window.location.href = "../ICUMob/CriticalCareGraph";
                          
                    //    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //        // MsgDia('An error occurred while processing your request.', "Error Information");
                    //    }
                    //});
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });
           
            $("#DateWiseMaxTempReport").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    var strDate = $("#Rptdate").val();
                    window.location.href = 'DateWiseMaxTempReport?strDate=' + strDate;
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });
            $("#btnInvestigationChart").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    var strDate = $("#Rptdate").val();
                    window.location.href = 'InvestigationChart?strDate=' + strDate;
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });

            $("#btnRespiratoryAssessment").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    var strDate = $("#Rptdate").val();
                    window.location.href = 'RespiratoryAssessment?strDate=' + strDate;
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });

            $("#btnDiabeticChart").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    var strDate = $("#Rptdate").val();
                    window.location.href = 'DiabeticChart?strDate=' + strDate;
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });

            $("#btnTreatmentSheet").click(function () {

                if (CheckPatSessionNotEmpty()) {
                    var Mrno = ($.session.get('ICUPatMRNO')).toString();
                    if (Mrno != "") {
                        window.location.href = '../ICUMob/TreatmentSheet'
                        // window.location.reload();
                    }
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });
            $("#btnDiacomImages").click(function () {
                $.loader.open();
                if (CheckPatSessionNotEmpty()) {
                    var Mrno = ($.session.get('ICUPatMRNO')).toString();
                    if (Mrno != "") {
                      
                        $.ajax({
                            type: 'POST',
                            url: '../DoctorDesk/RedirectToDicom',
                            data: { mrNo: Mrno },
                            success: function (data) {
                                $.loader.close();
                                window.open(data, '_blank');   
                            },
                            error: function () {
                                $.loader.close();
                            },
                        });
                    }
                }
                else
                    $.messager.alert("Information", "Please Select Patient");

                $.loader.close();
            });

            $("#btnInvestigationReport").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    var strDate = $("#Rptdate").val();
                    window.location.href = '../ICUMob/InvestigationReport';
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });

            //done by 
            $("#btnDocuments").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    var MRNO = $.session.get('ICUPatMRNO');
                    window.location.href = "http://117.239.203.115/WebDMS/DMS/calPatWiseDoc?strMrNo=" + MRNO.toString().trim() + "&&strLocation=T";
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });
            //end



            //done by 
            $("#btnIpPrescriptions").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    $.session.set('IPStatOrdersflag', "");
                   // GetTreat();
                    //alert("xdfdf");
                    var strDate = $("#Rptdate").val();
                    window.location.href = '../ICUMob/IPMedication';
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });
            $('#menuBar').click(function (e) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                GetNursStationsNPAtients("Y");
            });
            //28-11-2019  19:15
            var MRNO = $.session.get('ICUPatMRNO');
            if (MRNO == "" || MRNO == undefined) {
                if ($(window).width() < 992) {
                    $("#menuList").css("display", "block");
                    var menuList = document.getElementById('menuList');
                    menuList.style.display = "block";
                    var dispLst = document.getElementById('sideList');
                    dispLst.style.display = "block";
                    $('#menuBar').click();
                }
            }

            //end



          
        });
       
        //28-11-2019  19:15
        function SetDateTime() {
            var admissiondate = $.session.get('ICUPatAdmnDate');
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1;
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }
            today = dd + '/' + mm + '/' + yyyy;
            $("#Rptdate").val(today);

            $("#Rptdate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            maxDate: new Date(),
 			                minDate: admissiondate
                        });

            //   MinDate();

        }
    </script>
</asp:Content>
