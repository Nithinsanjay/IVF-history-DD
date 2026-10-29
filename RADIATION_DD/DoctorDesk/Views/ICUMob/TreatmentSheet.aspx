<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TreatmentSheet>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12" id="DivTreaSheetlink">
        <div class="col-xs-3 col-sm-3" id="anchorMedication" onclick="GetMedicinelst(this,'MD')" style="cursor:pointer">
            <!-- Left column panels -->
            <div class="panel panel-primary" style="border-radius: 50%;" id="MedicationPrimary">
                <div class="panel-body " id="Medication" style="min-height: 60px;">
                </div>
            </div>
            <label style="font-size: 10px; padding: 25px; text-align: center; margin-left: -21px; margin-top: -42px; display: block;">Medication</label>
        </div>

        <div class="col-xs-3 col-sm-3" id="anchorNebulization" onclick="GetMedicinelst(this,'NB')" style="cursor:pointer">
            <!-- Right column panels -->
            <div class="panel panel-primary" style="border-radius: 50%;" id="NebulizationPrim">

                <div class="panel-body" id="Nebulization" style="min-height: 60px;cursor:pointer"">
                    <%--  <a href="#test1" style="font-size:10px;">Vitals</a>--%>
                </div>

            </div>
            <label style="font-size: 10px; margin-left: -6px; margin-top: -42px; display: block; padding: 25px;">Nebulization</label>
        </div>

        <div class="col-xs-3 col-sm-3" id="anchorSpecialInst" onclick="GetMedicinelst(this,'SI')" style="cursor:pointer">
            <!-- Left column panels -->
            <%--id defined by --%>
            <div class="panel panel-primary" style="border-radius: 50%;" id="SpecialInstPrim">

                <div class="panel-body" id="SpecialInstuct" style="min-height: 60px;">
                    <%--  <a href="#test1" style="font-size:10px;" >Diagnosis</a>--%>
                </div>

            </div>
            <label style="font-size: 10px; text-align: center; margin-top: -42px; margin-left: -17px; display: block; padding: 25px;">S.I.Drug</label>
        </div>

        <div class="col-xs-3 col-sm-3" id="anchorstatOrder" onclick="GetMedicinelst(this,'SO')" style="cursor:pointer">
            <!-- right column panels -->
            <%--id defined by --%>
            <div class="panel panel-primary" style="border-radius: 50%;" id="EXAMPrim">

                <div class="panel-body" id="StatOrders" style="min-height: 60px;">
                    <%--	 <a href="#test1" style="font-size:10px;">On Examination</a>--%>
                </div>

            </div>
            <label style="font-size: 10px; text-align: center; margin-top: -42px; margin-left: -21px; display: block; padding: 25px;">STATOrders</label>
        </div>
        <div class="col-xs-3 col-sm-3" id="anchorInfusion" onclick="GetInfusionList(this,'IN')">
            <!-- Left column panels -->
            <div class="panel panel-primary" style="border-radius: 50%;" id="InfusionPrim">

                <div class="panel-body" id="Infusion" style="min-height: 60px;">
                    <%--		 <a href="#test1" style="font-size:10px;">Investigation</a>--%>
                </div>

            </div>
            <label style="font-size: 10px; text-align: center; margin-top: -42px; margin-left: -21px; display: block; padding: 25px;">Infusion</label>
        </div>

        <div class="col-xs-3 col-sm-3" id="anchorInvestigation" onclick="GetTestList(this,'IG')">


            <div class="panel panel-primary" style="border-radius: 50%;" id="InvestigationPrim">

                <div class="panel-body" id="Investigation" style="min-height: 60px;">
                </div>

            </div>
            <label style="font-size: 10px; /* text-align: center; */margin-top: -15px; /* margin-left: -21px; */display: block; /* padding: 25px; */width: 100%;">Investigation</label>
        </div>

        <div class="col-xs-3 col-sm-3" id="anchorReferrals" onclick="GetDoctorList(this,'RF')">
            <!-- right column panels -->
            <div class="panel panel-primary" style="border-radius: 50%;" id="ReferralsPrim">

                <div class="panel-body" id="Referrals" style="min-height: 60px;">
                </div>

            </div>
            <label style="font-size: 10px; text-align: center; margin-top: -42px; margin-left: -21px; display: block; padding: 25px;">Referrals</label>
        </div>


    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .RegisteredClass {
            background-color: #f1fff8;
            font-weight: bold !important;
            font-size: 12px;
            color: #077107 !important;
        }
       

        .hide {
            display: none !important;
        }

        .SearchDiv .Date {
            width: 90px !important;
        }

        .SearchDiv input {
            margin-top: 2px;
        }

        .required label:after {
            color: red;
            content: '*';
        }

        .clsMarginRight {
            margin-right: 5px;
        }

        Label {
            margin-left: 5px;
        }

        .Searchinfo {
            margin: 3px;
            border-bottom: 1px solid #f4f4f4;
        }

        .no-pad-Right {
            padding-right: 0px !important;
        }

        .no-pad-Left {
            padding-right: 0px !important;
        }

        .pad2 {
            padding: 2px !important;
        }

        .padTop2 {
            padding-top: 2px !important;
        }

        .padLeft2 {
            padding-left: 2px !important;
        }

        .ErrorClass {
            border-color: #a94442;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        }

        .ui-jqgrid .ui-state-highlight {
            background-color: #ffff99;
        }

        #modall {
            display: none;
            width: 100px;
            height: 100px;
            margin: 0 auto;
            position: relative;
            top: 100px;
        }
    </style>

    <script>
        GetNursStationsNPAtients();
        SetPatientDtl();

        if ($(window).width() >= 996) {                                            //screen width size comparion
            var menuL = document.getElementById('menuList');
            menuL.style.display = "block";

        }

        var TreatmentType = '';
        $(document).ready(function () {
            $('#DivTreaSheetlink').show();
            $('#DivMedicinList').hide()
            document.getElementById("Medication").style.backgroundImage = "url( ../Images/pil.png)";
            document.getElementById("Medication").style.backgroundRepeat = "no-repeat";
            document.getElementById("Medication").style.backgroundPosition = "center";

            document.getElementById("Infusion").style.backgroundImage = "url( ../Images/Infusion.png)";
            document.getElementById("Infusion").style.backgroundRepeat = "no-repeat";
            document.getElementById("Infusion").style.backgroundPosition = "center";

            document.getElementById("Nebulization").style.backgroundImage = "url( ../Images/Nubilization1.png)";
            document.getElementById("Nebulization").style.backgroundRepeat = "no-repeat";
            document.getElementById("Nebulization").style.backgroundPosition = "center";


            document.getElementById("Investigation").style.backgroundImage = "url( ../Images/Investi.png)";
            document.getElementById("Investigation").style.backgroundRepeat = "no-repeat";
            document.getElementById("Investigation").style.backgroundPosition = "center";

            document.getElementById("SpecialInstuct").style.backgroundImage = "url( ../Images/SpecialInstuction.png)";
            document.getElementById("SpecialInstuct").style.backgroundRepeat = "no-repeat";
            document.getElementById("SpecialInstuct").style.backgroundPosition = "center";

            document.getElementById("Referrals").style.backgroundImage = "url( ../Images/ReferralDoc.png)";
            document.getElementById("Referrals").style.backgroundRepeat = "no-repeat";
            document.getElementById("Referrals").style.backgroundPosition = "center";


            document.getElementById("StatOrders").style.backgroundImage = "url( ../Images/StatOrder.png)";
            document.getElementById("StatOrders").style.backgroundRepeat = "no-repeat";
            document.getElementById("StatOrders").style.backgroundPosition = "center";


        })

       
        function GetMedicinelst(obj,type) {
            window.location.href = '../ICUMob/TreatmentSheetList?TreatsheetType=' + type
        }


        function GetTestList(obj, type) {
            window.location.href = '../ICUMob/TreatmentSheetTestList?TreatsheetType=' + type
        }


        function GetDoctorList(obj, type) {
            window.location.href = '../ICUMob/TSDoctorList?TreatsheetType=' + type
        }
        

        function GetInfusionList(obj, type) {
            window.location.href = '../ICUMob/TSInfusion?TreatsheetType=' + type
        }
        

    </script>


</asp:Content>
