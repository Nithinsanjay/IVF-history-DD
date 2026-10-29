<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Clinicalnotes>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
         <div id="divSelectedDoctorHdr" style="display:none;margin-bottom:5px; font-weight:bold; font-size:14px; color:#0770a9; padding:6px 0; min-height:20px;">
    <label>Consultant :&nbsp;</label><span id="lblSelectedDoctorName"></span>
</div>
    <div id="MainDiv" style="display: none;">
        <div id="MainComponents">
            <div class="row">
                <div class="col-xs-3 col-sm-3" id="anchorvitals" style="text-align: center;">
                    <!-- Right column panels -->
                    <div class="panel panel-primary" style="border-radius: 99em; margin: auto; cursor: pointer" id="VitalsPrim" title="Alt+V">

                        <div class="panel-body" id="vitals" style="min-height: 60px;">
                            <%--  <a href="#test1" style="font-size:10px;">Vitals</a>--%>
                        </div>

                    </div>
                    <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer" title="Alt+V"><u>V</u>itals</label>
                </div>

                <div class="col-xs-3 col-sm-3" id="anchorPersonal" style="text-align: center; display: none">
                    <!-- Left column panels -->
                    <%--id defined by --%>
                    <div class="panel panel-primary" style="border-radius: 99em; margin: auto; cursor: pointer" id="PersonalPrim" title="Alt+O">

                        <div class="panel-body" id="diag" style="min-height: 60px;">
                            <%--  <a href="#test1" style="font-size:10px;" >Diagnosis</a>--%>
                        </div>

                    </div>
                    <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer" title="Alt+O">Pers<u>o</u>nal History</label>
                </div>

                <%-- //kavita 20-sep-2019--%>
                <div class="col-xs-3 col-sm-3" id="anchorAllergy" style="text-align: center;">
                    <!-- Left column panels -->
                    <%--id defined by --%>
                    <div class="panel panel-primary" style="border-radius: 99em; margin: auto; cursor: pointer" id="AllergyPrim" title="">

                        <div class="panel-body" id="Allergygtn" style="min-height: 60px;">
                        </div>

                    </div>
                    <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer">Allergy</label>
                </div>
                <%-- //kavita 20-sep-2019--%>

                <div class="col-xs-3 col-sm-3" id="anchorMedical" style="text-align: center; display: none">
                    <!-- right column panels -->
                    <%--id defined by --%>
                    <div class="panel panel-primary" style="border-radius: 99em; margin: auto; cursor: pointer" id="MedicalPrim" title="Alt+M">

                        <div class="panel-body" id="examtn" style="min-height: 60px;">
                            <%--	 <a href="#test1" style="font-size:10px;">On Examination</a>--%>
                        </div>

                    </div>
                    <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer" title="Alt+M"><u>M</u>edical History</label>
                </div>
                <div class="col-xs-3 col-sm-3" id="anchorFamily" style="text-align: center; display: none">
                    <!-- Left column panels -->
                    <%--id defined by --%>
                    <div class="panel panel-primary" style="border-radius: 99em; margin: auto; cursor: pointer" id="FamilyPrim" title="Alt+L">

                        <div class="panel-body" id="investgtn" style="min-height: 60px;">
                            <%--		 <a href="#test1" style="font-size:10px;">Investigation</a>--%>
                        </div>

                    </div>
                    <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer" title="Alt+L">Fami<u>l</u>y History</label>
                </div>


                <% if (("" + Session["gOncoUserId"].ToString().Trim()) == "ADMIN")
                    {%>
                <div class="col-xs-3 col-sm-3" id="anchorLanguage" style="text-align: center; display: none">
                    <!-- right column panels -->
                    <%--id defined by --%>
                    <div class="panel panel-primary" style="border-radius: 99em; margin: auto; cursor: pointer" id="LANGPrim" title="Alt+U">

                        <div class="panel-body" id="langtn" style="min-height: 60px;">
                            <%--	 <a href="#test1" style="font-size:10px;">On Examination</a>--%>
                        </div>

                    </div>
                    <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer" title="Alt+U">Lang<u>u</u>age Entry</label>
                </div>
                <%} %>
            </div>
            <div class="row">
                <div class="col-xs-3 col-sm-3" id="anchorComplaints" style="display: none">
                    <!-- Left column panels -->
                    <div class="panel panel-primary" style="margin: auto; border-radius: 99em; cursor: pointer" id="CompPrim" title="Alt+C">
                        <div class="panel-body " id="complaints" style="min-height: 60px;">
                        </div>
                    </div>
                    <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+C">
                        <u>C</u>omplaints</label>
                </div>

                <div class="col-xs-3 col-sm-3" id="anchorVaccination" style="text-align: center; display: none">
                    <!-- Left column panels -->
                    <%--id defined by --%>
                    <div class="panel panel-primary" style="border-radius: 99em; margin: auto; cursor: pointer" id="VaccinationPrim" title="">

                        <div class="panel-body" id="Vaccinationgtn" style="min-height: 60px;">
                        </div>

                    </div>
                    <label style="font-size: 12px; margin-top: 10px; display: block; cursor: pointer">Vaccination</label>
                </div>
            </div>

        </div>
        <div style="text-align: center; font-weight: 800; font-size: 13px; background: #e3d9d9; padding: 4px;">
            <a href="#" id="InvestRpt">INVESTIGATION REPORTS </a>
        </div>

        <% if (("" + Session["SHOWPRESYN"].ToString().Trim()) == "Y")
            {%>
        <div id="seperator" style="height: 22px; width: 97%; background-color: #ff00001f; margin-top: 35px; border: 1px solid black; font-size: 15px; text-align: center">Previous Prescriptions</div>
        <div id="divPrevPrescriptions" style="margin-top: 20px; margin-left: 10px;">
        </div>
        <%} %>
    </div>

    <div>
        <label class="container" style="display: none;">
            <button class="btn btn-save-patstatus">Mark as arrived</button>
        </label>
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
                <input type="button" id="btnHospOk" class="btn btn-primary ContinueBtn" value="Continue" style="padding: 5px; width: 70px;" onclick="SetHospital()" />
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .content {
            width: 80%;
            margin: auto;
        }

        .RegisteredClass {
            background-color: #f1fff8;
            font-weight: bold !important;
            font-size: 12px;
            color: #077107 !important;
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
        /*kavita*/
        .col-xs-3 {
            width: 33% !important;
        }

        @media only screen and (min-width : 320px) {
            .col-xs-3 {
                width: 42% !important;
            }
        }

        @media only screen and (min-width : 375px) {
            .col-xs-3 {
                width: 33% !important;
            }
        }

        @media only screen and (min-width : 360px) {
            .col-xs-3 {
                width: 35% !important;
            }
        }

        @media only screen and (min-width : 600px) {
            .col-xs-3 {
                width: 22% !important;
            }
        }

        @media only screen and (min-width : 768px) {
            .col-xs-3 {
                width: 17% !important;
            }
        }
        /*kavita*/

        .row {
            margin-left: 0px;
        }

        .btn-save-patstatus {
            background-color: #a5d6a7;
            color: #1b5e20;
            border: none;
            font-weight: 600;
        }

        .indent ul li {
            position: relative;
            z-index: 5;
        }
    </style>

    <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    <script src="../Scripts/Doctorlist.js"></script>
    <script src="../Scripts/PrescriptionPrint.js"></script>

    <script type="text/javascript">

        //var CurrentDate = '26/10/2017';
        var btnID = "";
        var Vaccineflag = 0;
        var glbPatMRnt = "";
        var showPresc = '<%:Session["SHOWPRESYN"]%>';// added by vijeta on 10/5/19
        <%--var urls = "<%=Url.Action("GetDctrClinic","Account")%>";--%>
        var patCompletedYNNew = sessionStorage.getItem("PatCompleted"); // $.session.get('PatCompleted');   //27-11-2019 16:07
        <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var RightUnitList = JSON.parse(JSON.stringify(<%:Html.Raw(Samp.Serialize(ViewBag.RightUnitList))%>));
        var UnitCd = '<%: Session["UNITCODE"] ?? "" %>';
        var showVitalsAlert = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ShowVitalsAlert")%>';
        $(document).ready(function (e) {

            if (showPresc == "Y") {
                GetPreviousPrescriptions();//vijeta 24/4/19
            }
            $.session.set('Pagefrom', "");
            var doctCode = $.session.get('DoctCode');
            var doctName = $.session.get('DoctName');

            SetPatientDtl();

            document.getElementById("vitals").style.backgroundImage = "url( ../Images/vit.png)";
            //document.getElementById("vitals").style.backgroundSize = "cover";
            document.getElementById("vitals").style.backgroundRepeat = "no-repeat";
            document.getElementById("vitals").style.backgroundPosition = "center";

            document.getElementById("diag").style.backgroundImage = "url( ../Images/addictns.png)";
            //document.getElementById("treatmnt").style.backgroundSize = "cover";
            document.getElementById("diag").style.backgroundRepeat = "no-repeat";
            document.getElementById("diag").style.backgroundPosition = "center";

            document.getElementById("examtn").style.backgroundImage = "url( ../Images/medHis.png)";
            //document.getElementById("examtn").style.backgroundSize = "cover";
            document.getElementById("examtn").style.backgroundRepeat = "no-repeat";
            document.getElementById("examtn").style.backgroundPosition = "center";

            document.getElementById("investgtn").style.backgroundImage = "url( ../Images/fmlyHis.png)";
            //document.getElementById("investgtn").style.backgroundSize = "cover";
            document.getElementById("investgtn").style.backgroundRepeat = "no-repeat";
            document.getElementById("investgtn").style.backgroundPosition = "center";

            if (("" + '<%: Session["gOncoUserId"]%>').toString().trim() == "ADMIN") {
                document.getElementById("langtn").style.backgroundImage = "url( ../Images/vit.png)";
                //document.getElementById("langtn").style.backgroundSize = "cover";
                document.getElementById("langtn").style.backgroundRepeat = "no-repeat";
                document.getElementById("langtn").style.backgroundPosition = "center";
            }

            document.getElementById("Vaccinationgtn").style.backgroundImage = "url( ../Images/vaccine.png)";
            document.getElementById("Vaccinationgtn").style.backgroundRepeat = "no-repeat";
            document.getElementById("Vaccinationgtn").style.backgroundPosition = "center";

            document.getElementById("complaints").style.backgroundImage = "url( ../Images/cmpltss.png)";
            //document.getElementById("complaints").style.backgroundSize = "cover";
            document.getElementById("complaints").style.backgroundRepeat = "no-repeat";
            document.getElementById("complaints").style.backgroundPosition = "center";

            //kavita 20-sep-2019
            document.getElementById("Allergygtn").style.backgroundImage = "url( ../Images/allergyIcon.png)";
            document.getElementById("Allergygtn").style.backgroundRepeat = "no-repeat";
            document.getElementById("Allergygtn").style.backgroundPosition = "center";
            //kavita 20-sep-2019

            //document.getElementById("diag").style.backgroundImage = "url( ../Images/stethoscope.png)";
            ////document.getElementById("diag").style.backgroundSize = "cover";
            //document.getElementById("diag").style.backgroundRepeat = "no-repeat";
            //document.getElementById("diag").style.backgroundPosition = "center";



            //document.getElementById("complaints").style.backgroundImage = "url( ../Images/cmpltss.png)";
            ////document.getElementById("complaints").style.backgroundSize = "cover";
            //document.getElementById("complaints").style.backgroundRepeat = "no-repeat";
            //document.getElementById("complaints").style.backgroundPosition = "center";

            //document.getElementById("prescriptn").style.backgroundImage = "url( ../Images/prescrp.png)";
            ////document.getElementById("prescriptn").style.backgroundSize = "cover";
            //document.getElementById("prescriptn").style.backgroundRepeat = "no-repeat";
            //document.getElementById("prescriptn").style.backgroundPosition = "center";

            ////document.getElementById("Check").style.backgroundImage = "url( ../Images/chck.png)";
            //////document.getElementById("Check").style.backgroundSize = "cover";
            ////document.getElementById("Check").style.backgroundRepeat = "no-repeat";
            ////document.getElementById("Check").style.backgroundPosition = "center";

            //document.getElementById("PatAdvice").style.backgroundImage = "url( ../Images/patadv.png)";
            //document.getElementById("PatAdvice").style.backgroundRepeat = "no-repeat";
            //document.getElementById("PatAdvice").style.backgroundPosition = "center";

            //document.getElementById("previousPrep").style.marginLeft = "25px";


            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
            }

            $(".Date").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
                onSelect: function (e) {
                    var arrDate = $(this).val().split('/');
                    var frmDate = arrDate[1] + "/" + arrDate[0] + "/" + arrDate[2]
                    var age = getAge(frmDate);
                    $('#txtAge').val(age);
                }
            }).inputmask('dd/mm/yyyy', {
                "clearIncomplete": true,
                oncomplete: function () {
                    var arrDate = $(this).val().split('/');
                    var frmDate = arrDate[1] + "/" + arrDate[0] + "/" + arrDate[2]
                    var age = getAge(frmDate);
                    $('#txtAge').val(age);
                }
            });
            $('#txtMobileNo').inputmask({ mask: '9', 'repeat': 10, 'greedy': false }).change(function (e) {
                if ($(this).val().trim().length < 10) {
                    // $.messager.alert("Information", "Mobile Number should be 10 digit.", 'txtMobileNo');
                }
            });
            $('#txtContactNo').inputmask({ mask: '9', 'repeat': 10, 'greedy': false })


            $('#txtPatName ,#txtDoctName').inputmask("Regex", { regex: "[a-z A-Z]*" });

            $('#txtAge').inputmask("age", {
                placeholder: '0',
                removeMaskOnSubmit: false
            });

            $('#btnFile').change(function (e) {
                UploadAction();
            });

            $('#btnSearch').click(function (e) {

                try {
                    SearchFunction();

                } catch (e) {
                    alert(e.message);
                }
            });

            $('.required input').change(function (e) {
                if (this.value.trim() != "") {
                    $(this).removeClass("ErrorClass");
                }

            });
            $('.required select').change(function (e) {
                if (this.value.trim() != "") {
                    $(this).removeClass("ErrorClass");
                }
            });
            $('#btnSave').click(function (e) {


            });
            CreatePatientList();

            $("#anchorvitals").click(function () {

                //if (typeof patCompletedYNNew === "undefined" || patCompletedYNNew === null) {
                if (typeof sessionStorage.getItem("PatCompleted") == "undefined" || sessionStorage.getItem("PatCompleted") == null) { 
                    $.messager.alert("Information", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/Vitals';
                }
            });

            $("#anchorComplaints").click(function () {
                if (('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("isHistReq")%>') == "Y") {
                    if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                        $.messager.alert("Alert", "Please Select Patient");
                    }
                    else if ($("div#PersonalPrim")[0].style.backgroundColor != "rgb(203, 245, 203)") {
                        $.messager.alert("Alert", "Please enter personal history.");
                    }
                    else if ($("div#MedicalPrim")[0].style.backgroundColor != "rgb(203, 245, 203)") {
                        $.messager.alert("Alert", "Please enter Medical history.");
                    }
                    else if ($("div#AllergyPrim")[0].style.backgroundColor != "rgb(203, 245, 203)") {
                        $.messager.alert("Alert", "Please enter Allergy data.");
                    }
                    else {//if (patCompletedYN == "N")
                        if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                            $.messager.alert("Information", "Please Select Patient");
                        }
                        else {//if (patCompletedYN == "N")
                            if (CheckPatSessionNotEmpty())
                                window.location.href = '../DoctorDesk/Complaints';
                        }
                    }
                }
                else {
                    if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                        $.messager.alert("Information", "Please Select Patient");
                    }
                    else {//if (patCompletedYN == "N")
                        if (CheckPatSessionNotEmpty())
                            window.location.href = '../DoctorDesk/Complaints';
                    }
                }

            });

            //Meenakshi
            //$("#rbtnYesterday").change(function (e) {
            //    SearchFunction($.session.get('ClinicCode'));
            //});

            //$("#rbtnToday").change(function (e) {
            //    SearchFunction($.session.get('ClinicCode'));
            //});

            //$("#rbtnDayBefYest").change(function (e) {
            //    SearchFunction($.session.get('ClinicCode'));
            //});


            $("input[name='dateType']").on("change", function () {
                SearchFunction($.session.get('ClinicCode'));
            });

            //Added by Murali on 22/05/2024
            //*******************************************************************************************
            if (("<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DispAddPatientYN")%>") == "Y") {
                DispAddPatient = true;
            }
            else {
                DispAddPatient = false;
            }
            //*******************************************************************************************           

            $("#anchorPersonal").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Information", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    Vaccineflag = 1;
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/PersonalHist';
                }

            });

            $("#anchorMedical").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Information", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    Vaccineflag = 1;
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/MedicalHist';
                }
                //if (CheckPatSessionNotEmpty())
                //    window.location.href = '../ClinicalNotes/MedicalHist';
                //else
                //    $.messager.alert("Information", "Please Select Patient");
            });

            $("#anchorFamily").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Information", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    Vaccineflag = 1;
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/FamilyHist';
                }
                //if (CheckPatSessionNotEmpty())
                //    window.location.href = '../ClinicalNotes/FamilyHist';
                //else
                //    $.messager.alert("Information", "Please Select Patient");
            });

            $("#anchorVaccination").click(function () {
                Vaccineflag = 1;
                if (CheckPatSessionNotEmpty()) {
                    Vaccineflag = 0;
                    window.location.href = '../ClinicalNotes/Vaccination';
                }
                else
                    $.messager.alert("Information", "Please Select Patient");//
            });

            //kavita 20-sep-2019
            $("#anchorAllergy").click(function () {
                //  if (typeof patCompletedYNNew === "undefined" || patCompletedYNNew === null) {
                if (typeof sessionStorage.getItem("PatCompleted") == "undefined" || sessionStorage.getItem("PatCompleted") == null) { 
                    $.messager.alert("Information", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    Vaccineflag = 1;
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/AllergyHist';//nitesh changed from DoctorDesk to ClinicalNotes
                }

                //if (CheckPatSessionNotEmpty()) {

                //    window.location.href = '../ClinicalNotes/AllergyHist';
                //}
                //else
                //    $.messager.alert("Information", "Please Select Patient");  //uncomment after finish
            });
            //27-11-2019 19:06
            //kavita 20-sep-2019
            $("#anchorLanguage").click(function () {

                window.location.href = '../ClinicalNotes/LanguageEntry';
            });
            //anchorPatAdvice

            //$("#anchorPatAdvice").click(function () {

            //    if (CheckPatSessionNotEmpty())
            //        window.location.href = '../DoctorDesk/PatientAdvice';
            //    else
            //        $.messager.alert("Information", "Please Select Patient");
            //});
            //$("#previousPrep").click(function () {
            //    var Mrno = ($.session.get('PatMRNO')).toString();
            //    if (Mrno != "") {
            //        //window.location.href = '../DoctorDesk/RedirectToDicom?mrNo=' + Mrno;// 'http://103.59.215.74:8081/SampleViewer/index?mrno=' + Mrno;
            //        $.ajax({
            //            type: 'POST',
            //            url: '../DoctorDesk/RedirectToDicom',
            //            data: { mrNo: Mrno },
            //            success: function (data) {
            //                window.location = data;
            //            }
            //        });
            //    }
            //});

            <%--$("#anchorcomplete").click(function () {
                if (CheckPatSessionNotEmpty()) {
                    var strTran = ($.session.get('PatTRANNO')).toString();
                    //var strMr = ($.session.get('PatMRNO')).toString();             

                    $.ajax({
                        type: "POST",
                        url: 'SaveComplete',
                        datatype: "json",
                        data: { strTranno: strTran },
                        success: function (result) {
                            if (result.includes("success")) {
                                $.session.set('PatTRANNO', "");
                                $.session.set('PatMRNO', "");
                                $.session.set('PatName', "");
                                $.session.set('PatAge', "");
                                $.session.set('PatGender', "");

                                $.messager.alert("Information", "Saved Successfully");
                                SetPatientDtl();
                                var StrClinicCode = '<%:Session["ClinicCode"]%>'
                                SearchFunction(StrClinicCode)
                                //window.location.href = 'PatientEntry';
                            }
                            else {
                                //$.alert("Please fill all data", {
                                //    type: 'info',
                                //});

                                $.messager.alert("Information", "Please fill all data");
                            }
                            //window.location.href = 'PatientEntry';
                        },
                    });
                }
                else
                    $.messager.alert("Information", "Please Select Patient");
            });--%>
            //end


            <%-- function AddClinics() {
                var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
            $.ajax({
                type: "POST",
                url: urls,
                data: {},
                success: function (result) {

                    var clncLegth = result.length;

                    $.each(result, function (index, value) {

                        if (clncLegth > 1) {
                            // $("#btnsDiv").length = $("#btnsDiv").length / clncLegth;

                            var a = $("#btnsDiv").css("width");

                        }

                        var $newDiv = $('<div>');
                        $newDiv.addClass("btn-group");

                        var test = $('<button/>',
                            {
                                text: result[index].Text,
                                id: result[index].Value,
                                style: ' background-color:transparent;margin-right: 2px;color: black;font-weight:bold;border: 1px solid transparent;font-size: 10px;    white-space: normal; ',
                                class: 'btn btn-primary',
                                click: function () {
                                    SearchFunction(result[index].Value);
                                    btnclk(this);
                                }

                            });

                        $newDiv.append(test);
                        $("#btnsDiv").append($newDiv);
                        //$("#btnsDiv").append(test);

                        btnID = result[index].Value;
                    });

                    

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }--%>

            $('#prescriptn').click(function (e) {

                //var tranno = $.session.get('PatTRANNO');
                //GetBindingData(tranno);
                if (CheckPatSessionNotEmpty())
                    window.location.href = '../DoctorDesk/PrescriptionPrint';

                else
                    $.messager.alert("Information", "Please Select Patient");
            });

            $("#InvestRpt").click(function () {
                //if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                //    $.messager.alert("Alert", "Please Select Patient");
                //}
                //else {
                //    if (CheckPatSessionNotEmpty())
                //        var MRNO =sessionStorage.getItem('PatMRNO');
                //    window.location.href = '../DoctorDesk/Investigation?MRNO=' + MRNO;
                //}
                if (CheckPatSessionNotEmpty())
                    window.location.href = '../DoctorDesk/Investigation?MRNO=' + sessionStorage.getItem('PatMRNO');
                else
                    $.messager.alert("Information", "Please Select Patient");
            });

            //GetAllCounts(); // added by vijeta on 29th march 2018

            // register the handler 
            document.addEventListener('keyup', doc_keyUp, false);// added by vijeta on 7th April 2018 for shoetcut keys

            // added by vijeta on 7th april 2018
            var lst = document.getElementById('sideList');
            window.onclick = function (event) {


                if (event.target == document.getElementById('menuDots')) {
                    //lst.style.display = "block"; kavita 29-8-18
                }
                else {
                    if ($(window).width() >= 996) {
                        lst.style.display = "block";
                    }
                    else
                        lst.style.display = "none";
                }

            }

            // Added by Dhananjay 20240703
            var Mrno = sessionStorage.getItem("PatMRNO")
            SetCountsForHistory(Mrno);
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


            const checkboxValues = {
                'PatientDashboard_ChkNew': '01',
                'PatientDashboard_ChkFollowUp': '02',
                'PatientDashboard_ChkReview': 'Y'
            };

            $(document).on('change', '#PatientDashboard_ChkNew, #PatientDashboard_ChkFollowUp, #PatientDashboard_ChkReview', function () {
                //console.log('Checkbox changed:', this.id, 'Checked:', $(this).is(':checked'));
                //PatientWaitingList_FilterRecords();
            });

        });

       <%-- function GetBindingData(vartranno) {
            var datatosend = {
                tranno: vartranno,//"06C170704NR0001"
                type: "L"
            }
            //PrintExcelAJAXCommon('../DoctorDesk/GetDoctorDeskData', datatosend, false, '../DoctorDesk/DisplayDoctorDeskData', true)

            var Html = "";
            $.ajax({
                type: "Post",
                url: "../DoctorDesk/GetDoctorDeskData",
                data: datatosend,
                async: false,
                success: function (response) {

                    GridData = response;
                    //Html = PrintData();
                    //Html = PrintData1();
                    //Html = PrintData2();
                    Html = PrintData3();
                    PrintListAJAXCommon('<%:Url.Action("PrintPatientReport","DoctorDesk")%>', { strHtml: Html }, "ABDSKFLSDF", "");
                    // ajaxindicatorstop();
                    GridData = "";
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    ajaxindicatorstop();
                    MsgDia(textStatus, "Error");
                }
            });
        }--%>


        //filter Patient Waiting List

       function PatientWaitingList_FilterRecords() {
           var showNew = $('#PatientDashboard_ChkNew').is(':checked');
           var showFollowUp = $('#PatientDashboard_ChkFollowUp').is(':checked');
           var showReview = $('#PatientDashboard_ChkReview').is(':checked');

           $("#NotArriveddata li, #ArrivedPatsdata li, #WaitingPatsdata li, #VisitedPatsdata li").each(function () {
               var visitType = $(this).find("#Visittype").val();  // "01", "02", "03"
               var reviewYN = $(this).find("#ReviewRptYN").val(); // "Y" or "N"

               var show = false;

               // Case: No checkboxes selected → show all
               if (!showNew && !showFollowUp && !showReview) {
                   show = true;
               } else {
                   // Case: New only
                   if (showNew && visitType === "01" && !showFollowUp && !showReview) show = true;

                   // Case: Follow-Up only
                   if (showFollowUp && visitType === "02" && reviewYN === "N" && !showReview && !showNew) show = true;

                   // Case: Review only
                   if (showReview && reviewYN === "Y" && !showNew && !showFollowUp ) show = true;

                   // Case: New + Follow-Up + Review
                   if (showNew && showFollowUp && (visitType === "01" || visitType === "02" ) && !showReview && reviewYN === "N") show = true;
                   if (showNew && showFollowUp && (visitType === "01" || visitType === "02") && showReview && reviewYN === "Y") show = true;


                   // Case: New + Review
                   if (showNew && !showReview && visitType === "01" && reviewYN === "N") show = true;
                   if (showNew && showReview && visitType === "01" && reviewYN === "Y") show = true;

                   // Case: Follow-Up + Review
                   if (showFollowUp && !showReview && visitType === "02" && reviewYN === "N") show = true;
                   if (showFollowUp && showReview && visitType === "02" && reviewYN === "Y") show = true;

                   // Case: All three selected
                   //if (showNew && showFollowUp && showReview) {
                   //    if (visitType === "01") show = true;
                   //    if (visitType === "02" && reviewYN === "N") show = true;
                   //    if (visitType === "03" && reviewYN === "Y") show = true;
                   //}
               }

               if (show) $(this).show();
               else $(this).hide();
           });
       }


       function PrintData3() {
            var strPrindData = [];
            strPrindData.push("<html><body>");
            strPrindData.push(" <style>.cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;text-align: left;}</style>");
            var label = "Patient Category";
            // var Patcatg = $('#spPatcatgnm')[0].textContent;
            var Patcatg = "";
            var doctName = "";
            ////User Details/////
            strPrindData.push("<div style='text-align: center;'><label style='font-weight:bold;font-size: 23px;'></label></div><table style='width:100%;font-family:Times New Roman;border-bottom:solid 1px black;border-top:solid 1px black'>");
            strPrindData.push("<tr><td style='color:blue'>Name</td><td style='width:1%'>:</td><td style='font-weight:bold;'>" + GridData.jsonUserdtls[0].PATNAME + "</td><td style='color:blue;width=5%'>Tran No.</td><td style='width:1%'>:</td>");
            strPrindData.push("<td width='35%'>" + GridData.jsonUserdtls[0].TRANNO + "</td></tr><tr><td style='color:blue'>Age/Gender</td><td >:</td><td>" + GridData.jsonUserdtls[0].PATAGE + " / " + GridData.jsonUserdtls[0].PATSEX + "</td>");
            strPrindData.push("<td style='color:blue;'>Date / Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + "  " + GridData.jsonUserdtls[0].TRANTIME + " </td>");
            strPrindData.push("</tr>  <tr><td style='color:blue'>Mobile No.</td><td >:</td><td>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>");
            strPrindData.push("<td style='color:blue'>MR No.</td><td>:</td>");
            strPrindData.push("<td>" + GridData.jsonUserdtls[0].MRNO + "</tr>  <tr><td style='color:blue'>Doctor Name</td>");
            strPrindData.push("<td>:</td><td> Dr." + GridData.jsonUserdtls[0].DOCTNAME + "</td><td style='color:blue;'>Patient Category</td>");
            strPrindData.push("<td >:</td><td>" + GridData.jsonUserdtls[0].PATCATG + "</td></tr></table></div>");
            strPrindData.push("<div style='width:100%;position:absolute;border-bottom:solid 1px black;'>");
            strPrindData.push("<table style='float: left;width: 30%;'><tr><td><table><tr><td><label style='color:black;font-weight:bold;'>Chief Complaints :</label>");
            strPrindData.push("</td></tr><tr><td><lable style='line-height:20px;'>>Headache</lable></td></tr><tr><td><lable style='line-height:20px;'>>Body Pain</lable></td>");
            strPrindData.push("</tr><tr><td><lable style='line-height:20px;'>>Fever</lable></td></tr></table><tr><td><label style='color:black;font-weight:bold;'>General Examinations :</label>");
            strPrindData.push("</td><tr><td><table><tr><td> Pulse  </td><td>: 75 </td></tr><tr><td> B/P  </td><td>: 120/80</td></tr><tr><td> Resp </td><td>: 100</td></table></td></tr>");
            strPrindData.push("<tr><td><table><tr><td ><label style='color:black;font-weight:bold;'>Diagnosis:</label></td></tr><tr><td style='line-height:20px;'>> Maleria</td></tr></table>");
            strPrindData.push("</td></tr> </table><table style='float:right;width:70%;display: inline-block;'><tr><td width=2% style='border-left:thin solid;'></td><td style='vertical-align:top'>");
            strPrindData.push("<table><tr><td style='width: 611px'><label style='color:black;font-weight:bold;'>Medicine :</label></td></tr><tr><td style='width: 611px'><table><tr><td>");
            strPrindData.push("> TAB -- Crocin -- *Crocin -- 1-0-1-1 -- 1 Tab -- After Food <br> SYP -- Bynadryl -- *Bynadryl -- 1-0-1-0 -- 1 Spoon -- After Food <br>");
            strPrindData.push("> TAB -- Dolo -- *Dolo -- 1-1-1-1 -- 1 Tab -- After Food <br> CAP -- Paracytomal -- *Paracytomal -- 1-0-1-0 -- After Food <br>");
            strPrindData.push("</td></tr></table></td></tr><tr><td style='width: 611px'><label style='color:black;font-weight:bold;'>Advice :</label></td></tr><tr><td style='width: 611px'>");
            strPrindData.push("<table><tr><td>> Walk Daily for 30 min.</td></tr><tr><td>> Take rest for atleast 2 days.</td></tr><tr><td>> Eat green vegitables.</td><td></td><tr><table></td></tr>");
            strPrindData.push("<tr><td><table><tr><td ><label style='color:black;font-weight:bold;'>Advice for Investigations :</label></td></tr><tr><td style='line-height:20px;'>> ");
            strPrindData.push("Typhoid Profile<br>> M.R.I. Contrast Charges -Paediatric<br>>STRESS ECHO WITH CONTRAST<br>> 2D Echo with contrast</td></tr></table></td></tr>");
            strPrindData.push("<tr><td style='width: 611px'><table><tr><td><label style='color:black;font-weight:bold;'>Follow Up :</label></td></tr><tr><td><label>After one week</label>");
            strPrindData.push("</td></tr></table></td></tr></table></td></tr></table></table></div><div style='bottom:0;position:absolute'>")
            strPrindData.push("<label style='font-style:Arial;font-size:12px;font-weight:bold;'>Note : * Indicates Generic Name</label>");
            strPrindData.push("</div><body></html>");
            return strPrindData;//.join("");

        }
        function PrintListAJAXCommon(Url, data, fileName, dispurl) {
            // mapForm.submit()
            //$.loader.open();
            var oReq = new XMLHttpRequest();
            oReq.open("post", Url, true);
            oReq.responseType = "blob";
            oReq.onload = function (oEvent) {
                var blob = oReq.response;
                var imgSrc = URL.createObjectURL(blob);
                var isfrem = document.getElementById("myIframe");
                if (isfrem != null) {
                    isfrem.parentNode.removeChild(isfrem);
                }
                var $iframe = $('<iframe id="myIframe"   name="myIframe" src=' + imgSrc + '#page=2" style=width:100%;height:100%></iframe>')
                $('#iframe').append($iframe);
                $("#myIframe").load(function () {
                    window.frames["myIframe"].focus();
                    window.frames["myIframe"].print();
                    $('#mdPrint').modal('show')
                    //$.loader.close();
                });
            };
            var fdata = new FormData();
            fdata.append('strHtml', data.strHtml);
            oReq.send(fdata);

        }


   <%-- function SearchFunction(clinicCode) {
        //$('#grid').clearGridData();

        //$.loader.open();
        $.ajax({
            url: "<%=Url.Action("GetPatientList", "DoctorDesk")%>",
                type: 'post',
                dataType: 'json',
                data: { strClinicCode: clinicCode },
                success: function (result) {
                    var $newDiv1 = $('<div>');
                    $newDiv1.attr("id", "WaitingPats");
                    $newDiv1.attr("name", "WaitingPats");
                    var $newul1 = $('<ul>', { style: ' list-style: none; float: left;font-size: 12px; margin-left: -35px;' });
                    $newul1.attr("id", "WaitingPatsdata");

                    var $newDiv2 = $('<div>');
                    $newDiv2.attr("id", "VisitedPats");
                    $newDiv2.attr("name", "VisitedPats");
                    var $newul2 = $('<ul>', { style: ' list-style: none; float: left;font-size: 12px; margin-left: -35px;' });
                    $newul2.attr("id", "VisitedPatsdata");

                    var $newDiv3 = $('<div>');
                    $newDiv3.attr("id", "completedPat");
                    $newDiv3.attr("name", "completedPat");


                    var options1 = "";
                    var options2 = "";

                    //--unnati   style 


                    $.each(result.Result, function (i, item) {
                        var patName = item.PatName;
                        var ApptTm = item.APPTTM;
                        var mrNo = item.MRNO;
                        var consNo = item.CONSNO;
                        var timeDiff = item.DIFFTM;
                        var age = item.Age;
                        var gender = item.Gender;

                        var tranNo = (item.TRANNO).toString().trim();

                        var chkSign = Math.sign(timeDiff);
                        var applyColor = "none";

                        if (chkSign == 1) {
                            if (timeDiff > 30) {
                                //red color
                                applyColor = "red";
                            }
                            else
                                applyColor = "yellow";
                            //alert("positive");yellow
                        }
                        else if (chkSign == -1) {
                            applyColor = "green";
                            //alert("negative"); green
                        }
                        else if (chkSign == NaN) {
                            //alert("No time");
                        }

                        if (tranNo == "")
                            options1 += "<li class='myCls'><label style=' padding: 1px 3px;    font-size: 10px; border-bottom: 1px solid #f4f4f4;' id='" + mrNo + "'> " + patName + "</label><label style='padding-left:5px;font-size:10px;margin-top: 3px;float:right;color:" + applyColor + "'>" + ApptTm + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input></li>";
                        else
                            options2 += "<li class='myCls'><label style=' padding: 1px 3px;    font-size: 10px; border-bottom: 1px solid #f4f4f4;' id='" + mrNo + "'> " + patName + "</label><label style='padding-left:5px;font-size:10px;margin-top: 3px;float:right;color:" + applyColor + "'>" + ApptTm + "</label><input type=hidden  id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input></li>";

                    });
                    //$newul.append(options);
                    //$newDiv.append($newul);
                    var $newHeadngWait = $('<a>', { class: 'btn-group btn-group-justified', style: 'text-align: center;font-size:12px;border-radius: 2px;color: black;  background-color: #d2d6de;  text-decoration: none;' });
                    $newHeadngWait.append('Waiting');

                    $newul1.append(options1);
                    $newDiv1.append($newul1);

                    $newul2.append(options2);
                    $newDiv2.append($newul2);

                    var $newHeadng = $('<a>', { class: 'btn-group btn-group-justified', style: 'text-align: center;border-radius: 2px;color: black;font-size:12px;  background-color: #d2d6de;  text-decoration: none;' });
                    $newHeadng.append('Completed');
                    $newDiv3.append($newHeadng);

                    //$newHeadng.attr("value", "Completed");

                    $('#DivPatGrid').empty();
                    if (options1 != "") {
                        $('#DivPatGrid').append($newHeadngWait);
                        $('#DivPatGrid').append($newDiv1);
                    }


                    if (options2 != "") {
                        $('#DivPatGrid').append($newDiv3);
                        $('#DivPatGrid').append($newDiv2);


                    }

                    //$.loader.close();
                    //if (result.Status == "Failed") {
                    //    $.messager.alert("Information", result.Result);
                    //}
                    //else {
                    //    if (result.Result.length === 0) {
                    //        $.messager.alert("Information", 'No Data Found.');
                    //    }
                    //    else {
                    //        $('#grid').show();
                    //        $('#grid').setGridParam({ data: result.Result }).trigger('reloadGrid');
                    //    }

                    //}
                },
                error: function (xhr, textStatus, errorThrown) {

                    $.loader.close();
                }

            });


        }--%>

        //function SearchComplaint() {
        //    // Declare variables 
        //    var input, filter, table, tr, td, i;
        //    input = document.getElementById("ComplaintInput");
        //    filter = input.value.toUpperCase();
        //    table = document.getElementById("tblCmplts");
        //    tr = table.getElementsByTagName("tr");

        //    // Loop through all table rows, and hide those who don't match the search query
        //    for (i = 0; i < tr.length; i++) {
        //        td = tr[i].getElementsByTagName("td")[0];
        //        if (td) {
        //            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        //                tr[i].style.display = "";
        //            } else {
        //                tr[i].style.display = "none";
        //            }
        //        }
        //    }
        //}

        // var count = 1;
        //function btnclk(btn) {
        //    // btn.style.backgroundColor = "rgb(255, 0, 0)";

        //    // $("#btnsDiv .btn btn-primary:not(#btnID)").css('backgroundColor',  'pink');

        //    var classname = document.getElementsByClassName("btn btn-primary");

        //    for (var i = 0 ; i < classname.length ; i++) {
        //        classname.item(i).style.backgroundColor = 'transparent';
        //        classname.item(i).style.borderBottomColor = 'transparent';

        //    }
        //    btn.style.backgroundColor = "transparent";

        //    btn.style.borderBottom = "solid";
        //    btn.style.borderBottomColor = "#3c8dbc";
        //    btn.style.outline = "0";
        //}

        function CheckPatSessionNotEmpty() {
              var mrNo =sessionStorage.getItem('PatMRNO');
   var tranno =sessionStorage.getItem('PatTRANNO');



            if (tranno != null && mrNo != null) {

                if (mrNo != "" && tranno != "")
                    return true;
                else
                    return false;
            }
            else {
                if (Vaccineflag == 1) {

                    if (mrNo != "" && mrNo != null)
                        return true;
                    else
                        return false;
                }
                else
                    return false;
            }
        }

        function SearchFunc(e) {
            try {
                if (event.keyCode == 13)
                    SearchFunction();
                //e.preventDefault();
            } catch (e) {
                alert(e.message);
            }
        }
        function UploadAction() {

            var photos = $("#btnFile")[0];
            if (photos.files.length > 0) {
                var file = photos.files[0];
                if (file.size < 32000) {

                    var reader = new FileReader();

                    reader.addEventListener("load", function () {
                        $('#PatPhoto').attr('src', reader.result);
                        //  preview.src = reader.result;
                    }, false);

                    if (file) {
                        reader.readAsDataURL(file);
                    }
                    //  var url = inputToURL(document.getElementById('photo'));

                }
                else {
                    $('#PatPhoto').attr('src', "<%=ResolveUrl("~/Images/NoPreview.png")%>");
                    $('#btnFile').val("");
                    $.messager.alert('Validation', 'Please Select Photo Less Than 30 KB');
                }
            }
            else {
                if ($('#PatPhoto')[0].src == "" || $('#PatPhoto')[0].src == window.location.href)
                    $('#PatPhoto').attr('src', "<%=ResolveUrl("~/Images/NoPreview.png")%>");
            }
        }
        function validEmail(e) {
            var filter = /^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/;
            return String(e).search(filter) != -1;
        }
        function ContiueToEdit() {
            try {
                if (!Validate()) {
                    return;
                }

                $.loader.open();
                $.ajax({
                    url: '../DoctorDesk/GotoPatientEntry',
                    type: 'post',
                    dataType: 'json',
                    data: 'strConsNo=' + $('#txtCONSNO').val() + '&StrTranNo=' + $('#txtTRANNO').val() + '&StrConsDT=' + $('#txtCONSDATE').val(),

                    success: function (result) {
                        $.loader.close();

                        if (result.Status == "Failed") {
                            $.messager.alert("Information", result.Message);
                        }
                        else {
                            window.location.href = result.Message;
                        }
                    },
                    error: function (xhr, textStatus, errorThrown) {

                        $.loader.close();
                    }

                });




            } catch (e) {
                alert(e.message);
            }
        }
        function checkNumber(input, min, max, msg) {
            msg = msg + " field has invalid data: " + input;

            var str = input;
            for (var i = 0; i < str.length; i++) {
                var ch = str.substring(i, i + 1)
                if ((ch < "0" || "9" < ch) && ch != '.') {
                    alert(msg);
                    return false;
                }
            }
            var num = 0 + str;
            if (num < min || max < num) {
                alert(msg + " not in range [" + min + ".." + max + "]");
                return false;
            }
            input = str;
            return true;
        }
        //function DateOfBirth(Year, Month, Days, CurDate) {
        //    //   var ml={31,28,31,30,31,30,31,31,30,31,30,31};
        //    var arrCurDate = CurDate.split('/');
        //    var CurYear = arrCurDate[2];
        //    var CurMonth = arrCurDate[1];
        //    var CurDay = arrCurDate[0];
        //    var BirthDay,
        //        BirthMonth,
        //        BirthYear;

        //    if ((CurYear == null || CurYear.length == 0) ||
        //        //       form.md.selectedIndex== null ||
        //        (CurDay == null || CurDay.length == 0) ||
        //        (Year == null || Year.length == 0) ||
        //        (Month == null || Month.length == 0) ||
        //        (Days == null || Days.length == 0)) {
        //        return;
        //    }

        //    if (
        //        !checkNumber(Days, 0, 31, "Days aged") ||
        //        !checkNumber(Month, 0, 12, "Months aged")) {
        //        $('#txtAge').focus();
        //        return;
        //    }

        //    var yb = CurYear - Year;
        //    var mb = CurMonth - Month;
        //    var db = CurDay - Days;

        //    if (mb < 1) {
        //        yb--;
        //        mb = 12 + mb;
        //    }

        //    if (db < 1) {
        //        mb--;
        //        if (mb < 1) {
        //            yb--;
        //            mb = 12 + mb;
        //        }
        //        var mon = mb - 1;

        //        if (mon == 0 || mon == 2 || mon == 4 || mon == 6 || mon == 7 || mon == 9 || mon == 11)
        //        { ml = 31; }
        //        else {
        //            if (mon == 1) { ml = 28; }
        //            else
        //            { ml = 30; }
        //        }
        //        db += ml + (((mb == 2) && (!(yb % 4) && (yb % 100 || !(yb % 400)))) ? 1 : 0);
        //    }
        //    BirthDay = db;
        //    BirthMonth = mb;
        //    BirthYear = yb;
        //    $('#txtDOB').val(BirthDay + "/" + BirthMonth + "/" + BirthYear);

        //}
        function getAge(fromdate, todate) {
            if (todate) todate = new Date(todate);
            else todate = new Date();

            var age = [], fromdate = new Date(fromdate),
                y = [todate.getFullYear(), fromdate.getFullYear()],
                ydiff = y[0] - y[1],
                m = [todate.getMonth(), fromdate.getMonth()],
                mdiff = m[0] - m[1],
                d = [todate.getDate(), fromdate.getDate()],
                ddiff = d[0] - d[1];

            if (mdiff < 0 || (mdiff === 0 && ddiff < 0)) --ydiff;
            if (mdiff < 0) mdiff += 12;
            if (ddiff < 0) {
                fromdate.setMonth(m[1] + 1, 0);
                ddiff = fromdate.getDate() - d[1] + d[0];
                --mdiff;
            }
            if (ydiff > 0) {
                age.push("000" + ydiff);
            }
            else {
                age.push("000");
            }

            if (mdiff > 0) {
                age.push("00" + mdiff);
            } else {
                age.push("00" + mdiff);
            }
            if (ddiff > 0) {
                age.push("00" + ddiff);
            }
            else {
                age.push("00" + ddiff);
            }
            age[0] = age[0].substr(age[0].length - 3);
            age[1] = age[1].substr(age[1].length - 2);
            age[2] = age[2].substr(age[2].length - 2);
            // if (age.length > 1) age.splice(age.length - 1, 0, ' and ');

            return age.join(':');
        }
        function Validate() {
            try {
                //  $('.required input').removeClass('ErrorClass');
                //  $('.required select').removeClass('ErrorClass');

                var count = 0;
                for (var i = 0; i < $('.required input[type=text]').length; i++) {
                    if ($('.required input')[i].value.trim() === "") {
                        $($('.required input')[i]).addClass('ErrorClass');
                        count += 1;
                    }

                }
                for (var i = 0; i < $('.required select').length; i++) {
                    if ($('.required select')[i].value.trim() === "") {
                        $($('.required select')[i]).addClass('ErrorClass');
                        count += 1;
                    }

                }
                //if ($('#cmdPatGcd').val().trim() === "02") {
                //    if ($('#txtCompanyNm').val().trim() === "") {

                //        $('#txtCompanyNm').addClass('ErrorClass');
                //        count += 1;
                //    }
                //}

                if (("" + $('#txtCONSDATE').val()).trim() != "") {
                    //if (CurrentDate != $('#txtCONSDATE').val().trim() && ("" + $('#txtTRANNO').val()).trim() == "") {
                    //    $.messager.alert("Information", "Can not perform transaction on this records");
                    //return false
                    //}
                }

                if (count == 0) {
                    //if ($('#txtMobileNo').val().trim().length < 10) {
                    //    $.messager.alert("Information", "Mobile Number should be 10 digit.", 'txtMobileNo');
                    //    return false;
                    //}
                    if ($('#txtEmail').val().trim() !== "") {
                        if (!validEmail($('#txtEmail').val())) {
                            $.messager.alert("Information", "Invalid Email.", 'txtEmail');
                            return false;
                        }
                    }
                    return true
                }
                else {
                    return false;
                }
            } catch (e) {
                alert(e.message);
                return false;
            }
        }
        function SetDateFunc() {
            //var curdate = new Date();
            //var s = "";
            //var noWdate = $.datepicker.formatDate("dd/mm/yy", curdate);
            //$('.Date').val(CurrentDate);
        }
        function CreatePatientList() {
            var ColName = new Array();
            var ColModel = new Array();
            var increment = 0;
            ColName.push("Consult No.");
            ColModel.push({ name: "CONSNO", index: "CONSNO", key: true, hidden: true, width: 110, editable: false, sortable: false })
            ColName.push("MR No.");
            ColModel.push({ name: "MRNO", index: "MRNO", width: 100, editable: false, sortable: false, hidden: true, })
            //ColName.push("Cons Date");
            //ColModel.push({ name: "ConsDate", index: "ConsDate", width: 80, editable: false, sortable: true })
            //ColName.push("Cons Time");
            //ColModel.push({ name: "ConsTime", index: "ConsTime", width: 80, editable: false, sortable: true })
            ColName.push("Patient Name");
            ColModel.push({ name: "PatName", index: "PatName", width: 200, editable: false, sortable: true })
            ColName.push("Gender");
            ColModel.push({
                name: "Gender", index: "Gender", width: 70, editable: false, sortable: true, edittype: 'select',
                formatter: 'select',
                editoptions: {
                    value: { 'M': 'Male', 'F': 'Female', 'U': 'Others' }
                }
            })
            //ColName.push("Date Of Birth");
            //ColModel.push({ name: "DOB", index: "DOB", width: 100, editable: false, sortable: true })
            ColName.push("Age");
            ColModel.push({ name: "Age", index: "Age", width: 60, editable: false, sortable: true });
            ColName.push("Appointment");
            ColModel.push({ name: "AppTm", index: "AppTm", width: 60, hidden: false, editable: false, sortable: true })
            //ColName.push("Address");
            //ColModel.push({ name: "PatAdd", index: "PatAdd", width: 250, hidden: true, editable: false, sortable: true });
            //ColName.push("Patient Category");
            //ColModel.push({ name: "PatCatg", index: "PatCatg", width: 120, editable: false, sortable: true });
            //ColName.push("Doctor Name");
            //ColModel.push({ name: "DoctorName", index: "DoctorName", width: 180, editable: false, sortable: true })
            //ColName.push("Company Name");
            //ColModel.push({ name: "CompName", index: "CompName", width: 200, hidden: true, editable: false, sortable: true })


            //ColName.push("Mobile Number");
            //ColModel.push({ name: "MobileNo", index: "MobileNo", width: 120, editable: false, sortable: true })
            //ColName.push("Contact No");
            //ColModel.push({ name: "ContactNo", index: "ContactNo", width: 100, hidden: true, editable: false, sortable: true })
            //ColName.push("Email");
            //ColModel.push({ name: "Email", index: "Email", width: 150, editable: false, sortable: true })
            //ColName.push("Imgsrc");
            //ColModel.push({ name: "Imgsrc", index: "Imgsrc", hidden: true, width: 150, editable: false, sortable: true })
            //ColName.push("Tran No");
            //ColModel.push({ name: "TRANNO", index: "TRANNO", hidden: false, width: 150, editable: false, sortable: true })

            //ColName.push("Created By");
            //ColModel.push({ name: "CREATEDBY", index: "CREATEDBY", hidden: false, width: 150, editable: false, sortable: true })
            //ColName.push("Edited By");
            //ColModel.push({ name: "EDITEDBY", index: "EDITEDBY", hidden: false, width: 150, editable: false, sortable: true })
            $('#grid').jqGrid({
                datatype: 'local',
                colNames: ColName,
                colModel: ColModel,
                loadtext: "Loading...",
                cellEdit: false,
                shrinkToFit: false,
                rowNum: 999999999999,
                autowidth: true,
                height: 280,//100
                gridComplete: function () { //set first row cursor point
                    var top_rowid = $('#grid tr:nth-child(2)').attr('id');
                    $("#grid").setSelection(top_rowid, true).focus();
                },//end
                loadComplete: function (rowid) {
                    if (rowid.rows.length > 0) {
                        var ids = jQuery("#grid").jqGrid('getDataIDs');
                        var iCol = 1;//getColumnIndexByName($("#gridR"), 'act');
                        var inc = 0;
                        for (i = 0; i < ids.length; i++) {
                            var rowData = jQuery("#grid").getRowData(ids[i]);
                            if (rowData.TRANNO != "")
                                jQuery("#grid").jqGrid('setRowData', ids[i], false, 'RegisteredClass');
                        }
                    }
                },
                onSelectRow: function (rowid, status, e) {
                    $('#divUpload').hide();
                    $('#frmPatReg input').removeClass('ErrorClass');
                    $('#frmPatReg select').removeClass('ErrorClass');
                    BindPatientInfo(rowid);
                },
                ondblClickRow: function (rowid, status, e) {
                    ContiueToEdit();

                }
            }).trigger("reloadGrid");
            jQuery("#grid").jqGrid('bindKeys');//key -up down
            $("#grid").bind('keydown', function (e) {   //on enter display records
                if (e.keyCode == 13) {
                    e.preventDefault();
                    var rowId = $("#grid").jqGrid("getGridParam", "selrow")
                    var rowData = jQuery("#grid").getRowData(rowId);
                    // document.getElementById('grid').style.display = 'none';
                    var doc = document.getElementById('grid');
                    if (doc !== null) {
                        ContiueToEdit();
                    }
                    ContiueToEdit();
                }
            });
            //end
        }
        function BindPatientInfo(rowId) {
            var Row = $('#grid').getRowData(rowId);
            $('#txtPatName').val(Row.PatName);
            $('#txtDOB').val(Row.DOB);
            $('#txtAge').val(Row.Age);
            $("#txtCONSNO").val(Row.CONSNO);
            $("#txtCONSDATE").val(Row.ConsDate)
            $('#txtMRNO').val(Row.MRNO);
            $('#txtGender').val(Row.Gender);
            $('#txtMobileNo').val(Row.MobileNo);
            $('#txtEmail').val(Row.Email);
            $('#txtContactNo').val(Row.ContactNo);
            $('#txtDoctName').val(Row.DoctorName);
            $('#txtAddress').val(Row.PatAdd);
            $('#txtPatCatg').val(Row.PatCatg);
            //$('#cmdPatGcd').val(Row.PatCatg);
            $('#txtCompanyNm').val(Row.CompName);
    <%--        if (Row.Imgsrc.trim() === "") {
                $('#PatPhoto').attr('src', "<%=ResolveUrl("~/Images/NoPreview.png")%>");
            }
            else {
                $('#PatPhoto').attr('src', "data:image/png;base64," + Row.Imgsrc);
            }--%>
            $('#txtTRANNO').val(Row.TRANNO);


        }

        function PrintData2() {
            var strPrindData = [];
            strPrindData.push("<html><body>");
            strPrindData.push(" <style>.cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;"
                + "text-align: left;}</style>"
            );
            var label = "Patient Category";
            // var Patcatg = $('#spPatcatgnm')[0].textContent;
            var Patcatg = "";
            var doctName = "";

            doctName = GridData.jsonUserdtls[0].DOCTNAME;
            strPrindData.push("<div style='text-align: center;'>" +
                "<label style='font-weight:bold;font-size: 23px;'></label>" +
                "</div><hr color=black>" +
                "<table style='width:100%;font-family:Times New Roman'>" +
                "<tr>" +
                "<td style=color:blue>Name</td>" +
                "<td style='width:1%'>:</td>" +
                "<td style=font-weight:bold;width:40%>" + GridData.jsonUserdtls[0].PATNAME + "</td>" +
                "<td style=color:blue;width=5% >Tran No</td><td style='width:1%'>:</td>" +
                "<td width=35%>" + GridData.jsonComplaints[0].TRANNO + "</td>" +
                "</tr>" +
                "<tr>" +
                "<td style=color:blue >Age / Gender</td><td >:</td><td>" + GridData.jsonUserdtls[0].PATAGE + " / " + GridData.jsonUserdtls[0].PATSEX + "</td>" +
                "<td style=color:blue;>Tran Date / Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + "</td>" +
                "</tr>  <tr><td style=color:blue>Mobile No.</td><td >:</td><td>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>" +
                "<td style=color:blue>MR No.</td><td>:</td>" +
                "<td>" + GridData.jsonComplaints[0].MRNO + "</tr>  <tr><td style=color:blue>Doctor Name</td>" +
                "<td>:</td>" +
                "<td>" + GridData.jsonUserdtls[0].DOCTNAME + "</td><td style=color:blue;>Patient Category</td>" +
                "<td >:</td><td>" + GridData.jsonUserdtls[0].PATCATG + "</td>" +
                "</tr>" +
                "</table>")
            strPrindData.push("</div><hr color=black>")



            strPrindData.push("<table>" +
                "<tr>" +
                "<td style=width50%>" +
                "<table>")

            strPrindData.push("<tr>")
            if (GridData.jsonExam[0].EXAM !== "") {
                strPrindData.push("<td>" +
                    "<label style=color:blue;font-weight:bold;><u>On Examinations</u>: </label>" +
                    +GridData.jsonExam[0].EXAM + "<br></br>" + "</td>")
            }
            strPrindData.push("</tr>")

            strPrindData.push("<tr>")

            if (GridData.jsonInvstg.length > 0) {
                strPrindData.push("<td>" +
                    "<label style=color:blue;font-weight:bold><u>Investigations </u>: </label>")
                //"<li>Typhoid Profile</li><li>Clotting typa</li>" +
                //"<li>Spirometry Test ( Pre  Post )</li><li>Spirometry (Pre)</li>" +
                //"<li>M.R.I. Contrast Charges -Paediatric</li><li>STRESS ECHO WITH CONTRAST</li>" +
                //"<li>2D Echo with contrast</li>" +
                for (var i = 0; i < GridData.jsonInvstg.length; i++) {
                    strPrindData.push("<li>" + GridData.jsonInvstg[i].TESTNAME + "</li>");
                }
                strPrindData.push("</td>")

                strPrindData.push("</tr>" +

                    "</table>" +
                    "</td>")
            }

            if (GridData.jsonVital.length > 0) {
                strPrindData.push("</td>" +
                    "<td width=2% style='border-left:thin solid';></td>" +
                    "<td style='vertical-align:top'>")
            }
            else {

            }


            if (GridData.jsonVital.length > 0) {
                strPrindData.push("<label style=color:blue;font-weight:bold;vertical-align=top><u>Vitals </u>: </label>")
            }
            else {
                strPrindData.push("<label style=color:blue;font-weight:bold;vertical-align=top><u></u></label>")
            }
            strPrindData.push("<table width=100%>" +
                "<tr>")
            if (GridData.jsonVital.length > 0) {

                strPrindData.push("<td style=font-weight:bold;width=30% >Weight: </td>" + "<td>" + GridData.jsonVital[0]["WEIGHT"] + "</td></tr><tr><td style=font-weight:bold>Height: </td>")
                strPrindData.push("<td>" + GridData.jsonVital[0]["HEIGHT"] + "</td>" +
                    "</tr>" +
                    "<tr><td style=font-weight:bold>  Temp : </td><td>" + GridData.jsonVital[0]["TEMP"] + "</td>" +
                    "</tr><tr><td style=font-weight:bold> Pulse : </td>" +
                    "<td>" + GridData.jsonVital[0]["PULSE"] + "</td></tr><tr><td style=font-weight:bold> Resp : </td>" +
                    "<td>" + GridData.jsonVital[0]["RESP"] + "</td></tr><tr><td style=font-weight:bold> Bp : </td>" +
                    "<td>" + GridData.jsonVital[0]["BP"] + "</td></tr><tr><td colspan=2>jkjhkjhkhujk</td>" +
                    "</tr>" +
                    "</table>" +
                    //"<td width=2% style='border-left:thin solid';></td>" +

                    "</td>")
            }
            else {
                strPrindData.push("<td style=font-weight:bold;width=30% ></td>" + "<td>" + "" + "</td></tr><tr><td style=font-weight:bold></td>")
                strPrindData.push("<td>" + "" + "</td>" +
                    "</tr>" +
                    "<tr><td style=font-weight:bold></td><td>" + "" + "</td>" +
                    "</tr><tr><td style=font-weight:bold></td>" +
                    "<td>" + "" + "</td></tr><tr><td style=font-weight:bold></td>" +
                    "<td>" + "" + "</td></tr><tr><td style=font-weight:bold></td>" +
                    "<td>" + "" + "</td></tr><tr><td colspan=2></td>" +
                    "</tr>" +
                    "</table>" +
                    //"<td width=2% style='border-left:thin solid';></td>" +

                    "</td>")
            }


            strPrindData.push("</tr>" +
                "<tr>" +
                "<td>")

            if (GridData.jsonAdvice.length > 0) {
                strPrindData.push("<table style='width: 125%'>" +
                    "<tr rowspan=1>" +
                    "<td colspan=14>" +
                    "<label style=color:blue;font-weight:bold;>" +
                    "<u>Treatment Advice </u>: </label>" +
                    "</td>" +
                    "</tr><tr>" +
                    "<td><label style=color:black;font-weight:bold;>Form &nbsp;</label>" +
                    "</td><td>" +
                    "<label style=color:black;font-weight:bold;>Generic* &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td><td><label style=color:black;font-weight:bold;>Drug Name** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>" +
                    "</td><td>" +
                    "<label style=color:black;font-weight:bold;>Dose &nbsp;&nbsp;&nbsp;&nbsp;</label></td><td><label style=color:black;font-weight:bold;>Route &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td><td><label style=color:black;font-weight:bold;>Days&nbsp</label>" +
                    "</td><td>" +
                    "<label style=color:black;font-weight:bold;>Intake &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>" +
                    "</td><td width=15%>" +
                    "<label style=color:black;font-weight:bold;>Remark &nbsp;&nbsp;</label>")

                for (var i = 0; i < GridData.jsonAdvice.length; i++) {

                    //var strTake1 = (GridData.jsonAdvice[i].INT1 == "N") ? "0 " : "1 ";
                    //var strTake2 = (GridData.jsonAdvice[i].INT2 == "N") ? "- 0 " : "- 1 ";
                    //var strTake3 = (GridData.jsonAdvice[i].INT3 == "N") ? "- 0 " : "- 1 ";
                    //var strTake4 = (GridData.jsonAdvice[i].INT4 == "N") ? "- 0 " : "- 1 ";
                    var strTake1 = "";
                    var strTake2 = "";
                    var strTake3 = "";
                    var strTake4 = "";

                    var Durgfrm = "";
                    var Route = "";
                    if (GridData.jsonAdvice[i].DRUGFORM == "S") { Durgfrm = "SYP" }
                    else if (GridData.jsonAdvice[i].DRUGFORM == "T") { Durgfrm = "TAB" }
                    else if (GridData.jsonAdvice[i].DRUGFORM == "I") { Durgfrm = "INJ" }
                    else if (GridData.jsonAdvice[i].DRUGFORM == "C") { Durgfrm = "CAP" }

                    if (GridData.jsonAdvice[i].ROUTE == "O") { Route = "ORAL" }
                    else if (GridData.jsonAdvice[i].ROUTE == "M") { Route = "IM" }
                    else if (GridData.jsonAdvice[i].ROUTE == "V") { Route = "IV" }
                    else if (GridData.jsonAdvice[i].ROUTE == "L") { Route = "L/A" }
                    //var strTake5 = (Advice[i].INT5 == "N") ? " 0" : " 1";   //<td>" + Advice[i].DRUGFORM + "</td><td>" + Advice[i].GENERICNAME + "</td>
                    //strPrindData.push("<tr><td>" + Durgfrm + "</td><td>" + GridData.jsonData5[i].GENERICNAME + "</td><td>" + GridData.jsonData5[i].DRUGNM + "</td><td>" + GridData.jsonData5[i].DOSSAGE + "</td><td>" + Route + "</td><td>" + "&nbsp;&nbsp;&nbsp;&nbsp;" + GridData.jsonData5[i].DAYS
                    //    + "</td><td>" + strTake1 + strTake2 + strTake3 + strTake4 + "</td><td>" + GridData.jsonData5[i].Remarks +//<td>" + Advice[i].ROUTE + "</td>
                    //       "</td></tr>");//strTake5 +

                    strPrindData.push("</td></tr>" +
                        "<tr>" +
                        "<td colspan=14><hr color=black></td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>" + Durgfrm + "</td>" +
                        "<td>" + GridData.jsonAdvice[i].GENERICNAME + "</td>" +
                        "<td>" + GridData.jsonAdvice[i].DRUGNM + "</td>" +
                        "<td>" + GridData.jsonAdvice[i].DOSSAGE + "</td>" +
                        "<td>" + Route + "</td><td>" + "&nbsp;&nbsp;&nbsp;&nbsp;" + GridData.jsonAdvice[i].DAYS
                        + "</td>" +
                        "<td>" + strTake1 + strTake2 + strTake3 + strTake4 + "</td><td>" + GridData.jsonAdvice[i].Remarks + "</td></tr></table>" +
                        "</td>" +
                        "</tr>")


                }
            }
            strPrindData.push("<tr>")
            strPrindData.push("<td>")
            strPrindData.push("<label style='color:blue;font-weight:bold;'><u>Follow-up Doctor</u></label>")
            strPrindData.push("</td>")
            strPrindData.push("</tr>")
            strPrindData.push("<tr>")
            strPrindData.push("<td>")
            strPrindData.push("</td>")
            strPrindData.push("</tr>")
            strPrindData.push("</table> ")

            strPrindData.push("<body></html>");
            return strPrindData.join("");
        }


        //        function PrintData1() {
        //            var strPrindData = [];
        //            strPrindData.push("<html><body>");
        //            strPrindData.push(" <style>.cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;"
        //           + "text-align: left;}</style>"
        //                );
        //            var label = "Patient Category";
        //            // var Patcatg = $('#spPatcatgnm')[0].textContent;
        //            var Patcatg = "";
        //            var doctName = "";

        //            doctName = GridData.jsonUserdtls[0].DOCTNAME;
        //            strPrindData.push("<div style='text-align: center;'>" +
        //"<label style='font-weight:bold;font-size: 23px;'></label>" +
        //"</div><hr color=black>" +
        //"<table style='width:100%;font-family:Times New Roman'>" +
        //"<tr>" +
        //"<td style=color:blue>Name</td>" +
        //"<td style='width:1%'>:</td>" +
        //"<td style=font-weight:bold;width:40%>" + GridData.jsonUserdtls[0].PATNAME + "</td>" +
        //"<td style=color:blue;width=5% >Tran No</td><td style='width:1%'>:</td>" +
        //"<td width=35%>" + GridData.jsonComplaints[0].TRANNO + "</td>" +
        //"</tr>" +
        //"<tr>" +
        //"<td style=color:blue >Age / Gender</td><td >:</td><td>" + GridData.jsonUserdtls[0].PATAGE + " / " + GridData.jsonUserdtls[0].PATSEX + "</td>" +
        //"<td style=color:blue;>Tran Date / Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + "</td>" +
        //"</tr>  <tr><td style=color:blue>Mobile No.</td><td >:</td><td>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>" +
        //"<td style=color:blue>MR No.</td><td>:</td>" +
        //"<td>" + GridData.jsonComplaints[0].MRNO + "</tr>  <tr><td style=color:blue>Doctor Name</td>" +
        //"<td>:</td>" +
        //"<td>" + GridData.jsonUserdtls[0].DOCTNAME + "</td><td style=color:blue;>Patient Category</td>" +
        //"<td >:</td><td>" + GridData.jsonUserdtls[0].PATCATG + "</td>" +
        //"</tr>" +
        //"</table>")
        //            strPrindData.push("</div><hr color=black>")


        //            strPrindData.push("<table>")
        //            if (GridData.jsonVital.length > 0) {
        //                strPrindData.push("<tr>")
        //                strPrindData.push("<label style=color:blue;font-weight:bold;vertical-align=top><u>Vitals </u>: </label>")
        //                strPrindData.push("<td style=font-weight:bold;width=30% >Weight: </td>" + "<td>" + GridData.jsonVital[0]["WEIGHT"] + "</td></tr><tr><td style=font-weight:bold>Height: </td>")
        //                strPrindData.push("<td>" + GridData.jsonVital[0]["HEIGHT"] + "</td>" +
        //        "</tr>" +
        //        "<tr><td style=font-weight:bold>  Temp : </td><td>" + GridData.jsonVital[0]["TEMP"] + "</td>" +
        //        "</tr><tr><td style=font-weight:bold> Pulse : </td>" +
        //        "<td>" + GridData.jsonVital[0]["PULSE"] + "</td></tr><tr><td style=font-weight:bold> Resp : </td>" +
        //        "<td>" + GridData.jsonVital[0]["RESP"] + "</td></tr><tr><td style=font-weight:bold> Bp : </td>" +
        //        "<td>" + GridData.jsonVital[0]["BP"] + "</td></tr><tr><td colspan=2>jkjhkjhkhujk</td>" +
        //        "</tr>" +
        //        "</table>" +


        //                            "</td>" + "<br></br>")
        //                strPrindData.push("</tr>")
        //            }

        //            strPrindData.push("<tr>" +
        //             "<td style=width50%>" +
        //                 "<table>")

        //            strPrindData.push("<tr>")
        //            if (GridData.jsonExam[0].EXAM !== "") {
        //                strPrindData.push("<td>" +
        //                           "<label style=color:blue;font-weight:bold><u>On Examinations</u>: </label>" +
        //                            +GridData.jsonExam[0].EXAM + "<br></br>" + "</td>")
        //            }
        //            strPrindData.push("</tr>")

        //            strPrindData.push("<tr>")

        //            if (GridData.jsonInvstg.length > 0) {
        //                strPrindData.push("<td>" +
        //                   "<label style=color:blue;font-weight:bold><u>Investigations </u>: </label>")
        //                //"<li>Typhoid Profile</li><li>Clotting typa</li>" +
        //                //"<li>Spirometry Test ( Pre  Post )</li><li>Spirometry (Pre)</li>" +
        //                //"<li>M.R.I. Contrast Charges -Paediatric</li><li>STRESS ECHO WITH CONTRAST</li>" +
        //                //"<li>2D Echo with contrast</li>" +
        //                for (var i = 0; i < GridData.jsonInvstg.length; i++) {
        //                    strPrindData.push("<li>" + GridData.jsonInvstg[i].TESTNAME + "</li>");
        //                }
        //                strPrindData.push("</td>")

        //                strPrindData.push("</tr>" +

        //            "</table>" +
        //        "</td>")
        //            }


        //            strPrindData.push("</td>" +



        //        "<table width=100%>" +
        //        "<tr>")



        //            strPrindData.push("</tr>" +
        //                        "<tr>" +
        //                            "<td>")
        //            if (GridData.jsonAdvice.length > 0) {
        //                strPrindData.push("<table style='width: 125%'>" +
        //                "<tr rowspan=1>" +
        //                "<td colspan=14>" +
        //                "<label style=color:blue;font-weight:bold;>" +
        //                "<u>Treatment Advice </u>: </label>" +
        //                "</td>" +
        //                "</tr><tr>" +
        //                "<td><label style=color:black;font-weight:bold;>Form &nbsp;</label>" +
        //                "</td><td>" +
        //                "<label style=color:black;font-weight:bold;>Generic* &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td><td><label style=color:black;font-weight:bold;>Drug Name** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>" +
        //                    "</td><td>" +
        //                    "<label style=color:black;font-weight:bold;>Dose &nbsp;&nbsp;&nbsp;&nbsp;</label></td><td><label style=color:black;font-weight:bold;>Route &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td><td><label style=color:black;font-weight:bold;>Days&nbsp</label>" +
        //                    "</td><td>" +
        //                    "<label style=color:black;font-weight:bold;>Intake &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>" +
        //                    "</td><td width=15%>" +
        //                    "<label style=color:black;font-weight:bold;>Remark &nbsp;&nbsp;</label>")

        //                for (var i = 0; i < GridData.jsonAdvice.length; i++) {

        //                    //var strTake1 = (GridData.jsonAdvice[i].INT1 == "N") ? "0 " : "1 ";
        //                    //var strTake2 = (GridData.jsonAdvice[i].INT2 == "N") ? "- 0 " : "- 1 ";
        //                    //var strTake3 = (GridData.jsonAdvice[i].INT3 == "N") ? "- 0 " : "- 1 ";
        //                    //var strTake4 = (GridData.jsonAdvice[i].INT4 == "N") ? "- 0 " : "- 1 ";
        //                    var strTake1 = "";
        //                    var strTake2 = "";
        //                    var strTake3 = "";
        //                    var strTake4 = "";

        //                    var Durgfrm = "";
        //                    var Route = "";
        //                    if (GridData.jsonAdvice[i].DRUGFORM == "S") { Durgfrm = "SYP" }
        //                    else if (GridData.jsonAdvice[i].DRUGFORM == "T") { Durgfrm = "TAB" }
        //                    else if (GridData.jsonAdvice[i].DRUGFORM == "I") { Durgfrm = "INJ" }
        //                    else if (GridData.jsonAdvice[i].DRUGFORM == "C") { Durgfrm = "CAP" }

        //                    if (GridData.jsonAdvice[i].ROUTE == "O") { Route = "ORAL" }
        //                    else if (GridData.jsonAdvice[i].ROUTE == "M") { Route = "IM" }
        //                    else if (GridData.jsonAdvice[i].ROUTE == "V") { Route = "IV" }
        //                    else if (GridData.jsonAdvice[i].ROUTE == "L") { Route = "L/A" }
        //                    //var strTake5 = (Advice[i].INT5 == "N") ? " 0" : " 1";   //<td>" + Advice[i].DRUGFORM + "</td><td>" + Advice[i].GENERICNAME + "</td>
        //                    //strPrindData.push("<tr><td>" + Durgfrm + "</td><td>" + GridData.jsonData5[i].GENERICNAME + "</td><td>" + GridData.jsonData5[i].DRUGNM + "</td><td>" + GridData.jsonData5[i].DOSSAGE + "</td><td>" + Route + "</td><td>" + "&nbsp;&nbsp;&nbsp;&nbsp;" + GridData.jsonData5[i].DAYS
        //                    //    + "</td><td>" + strTake1 + strTake2 + strTake3 + strTake4 + "</td><td>" + GridData.jsonData5[i].Remarks +//<td>" + Advice[i].ROUTE + "</td>
        //                    //       "</td></tr>");//strTake5 +

        //                    strPrindData.push("</td></tr>" +
        //                   "<tr>" +
        //                   "<td colspan=14><hr color=black></td>" +
        //                   "</tr>" +
        //                   "<tr>" +
        //                   "<td>" + Durgfrm + "</td>" +
        //                   "<td>" + GridData.jsonAdvice[i].GENERICNAME + "</td>" +
        //                   "<td>" + GridData.jsonAdvice[i].DRUGNM + "</td>" +
        //                   "<td>" + GridData.jsonAdvice[i].DOSSAGE + "</td>" +
        //                   "<td>" + Route + "</td><td>" + "&nbsp;&nbsp;&nbsp;&nbsp;" + GridData.jsonAdvice[i].DAYS
        //                        + "</td>" +
        //                   "<td>" + strTake1 + strTake2 + strTake3 + strTake4 + "</td><td>" + GridData.jsonAdvice[i].Remarks + "</td></tr></table>" +
        //                                       "</td>" +
        //                                   "</tr>")


        //                }
        //            }
        //            strPrindData.push("<tr>")
        //            strPrindData.push("<td>")
        //            strPrindData.push("<label style='color:blue;font-weight:bold;'><u>Follow-up Doctor</u></label>")
        //            strPrindData.push("</td>")
        //            strPrindData.push("</tr>")
        //            strPrindData.push("<tr>")
        //            strPrindData.push("<td>")
        //            strPrindData.push("</td>")
        //            strPrindData.push("</tr>")
        //            strPrindData.push("</table> ")



        //            strPrindData.push("<body></html>");
        //            return strPrindData.join("");
        //        }
        // 
        function PrevPriscriptions(oldTranno) {
            GetBindingData(oldTranno.parentElement.children[1].title);
        }
        function GetCopy(oldTranno) {

            var mrno = ($.session.get('PatMRNO'));
            var tranNo = ($.session.get('PatTRANNO'));

            $.ajax({
                type: "POST",
                url: 'SaveCopy',
                datatype: "json",
                data: { PrevTranNo: oldTranno.title, strMRNO: mrno, strTranNo: tranNo },
                success: function (result) {
                    $.messager.alert("Information", "Copied Successfully");

                },
            });
        }
        //end
        function CallAdviceView() {
            if ('<%:Session["CIMYN"]%>' == "Y")
                window.location.href = '../DoctorDesk/RxNewSearch';
            else
                window.location.href = '../DoctorDesk/RxDesktop';
       }
       //Added By Abhishesh || 20260311
       function ResetCountsUI() {
           $("#VitalsPrim").css("background-color", "transparent");
           $("#PersonalPrim").css("background-color", "transparent");
           $("#MedicalPrim").css("background-color", "transparent");
           $("#FamilyPrim").css("background-color", "transparent");
           $("#CompPrim").css("background-color", "transparent");
           $("#VaccinationPrim").css("background-color", "transparent");
           $("#AllergyPrim").css("background-color", "transparent");
       }
       //End

        function GetAllCounts() {
              var strTranNo =sessionStorage.getItem('PatTRANNO');
            var mrno = sessionStorage.getItem('PatMRNO');
            $("div#VitalsPrim")[0].style.backgroundColor = "transparent";
            $("div#PersonalPrim")[0].style.backgroundColor = "transparent";
            $("div#MedicalPrim")[0].style.backgroundColor = "transparent";
            $("div#FamilyPrim")[0].style.backgroundColor = "transparent";
            $("div#CompPrim")[0].style.backgroundColor = "transparent";
            $("div#VaccinationPrim")[0].style.backgroundColor = "transparent";
            $("div#AllergyPrim")[0].style.backgroundColor = "transparent";
            isVitalsCompleted = "N";
            $.ajax({
                url: '../DoctorDesk/GetCounts',  //Pass URL here 
                type: "POST", //Also use GET method,
                datatype: "json",
                // data: { strTranNo: strTranNo },
                data: { strTranNo: strTranNo, strMrno: mrno },
                async: false,
                success: function (data) {
                    if (data != "") {//
                        if (data["VITALS"].toString().trim() === "Y") {
                            $("div#VitalsPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
                            isVitalsCompleted = "Y";
                        } else {
                            $("div#VitalsPrim")[0].style.backgroundColor = 'transparent';
                            isVitalsCompleted = "N";
                        }

                        //added on 28th march 2018
                        if (data["ADDICTHISTORY"] == "Y")
                            $("div#PersonalPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
                        else
                            $("div#PersonalPrim")[0].style.backgroundColor = 'transparent';

                        if (data["MEDICINEHISTORY"] == "Y")
                            $("div#MedicalPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
                        else
                            $("div#MedicalPrim")[0].style.backgroundColor = 'transparent';

                        if (data["FAMILYHISTORY"] == "Y")
                            $("div#FamilyPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
                        else
                            $("div#FamilyPrim")[0].style.backgroundColor = 'transparent';
                        //------------------------------------

                        if (data["COMPLAINTS"] == "Y")     // Highlighting Purpose - Added by Dhananjay 20240702
                            $("div#CompPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
                        else
                            $("div#CompPrim")[0].style.backgroundColor = 'transparent';

                        if (data["VACCINATION"] == "Y")
                            $("div#VaccinationPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
                        else
                            $("div#VaccinationPrim")[0].style.backgroundColor = 'transparent';

                        if (data["ALLERGY"] == "Y")
                            $("div#AllergyPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
                        else
                            $("div#AllergyPrim")[0].style.backgroundColor = 'transparent';
                    }
                }
            });

        }

        // define a handler added by vijeta on 7th April 2018 for shoetcut keys
        function doc_keyUp(e) {



            if (e.altKey && e.keyCode == 86)// alt+V
            {
                $("#anchorvitals").trigger("click");//vitals
            }
            else if (e.altKey && e.keyCode == 79) { //O
                $("#anchorPersonal").trigger("click");//Personal History
            }
            else if (e.altKey && e.keyCode == 77) { //M
                $("#anchorMedical").trigger("click");//Medical History
            }
            else if (e.altKey && e.keyCode == 76) { //L
                $("#anchorFamily").trigger("click");//Family History
            }
            else if (e.altKey && e.keyCode == 85) { //alt+U
                $("#LANGPrim").trigger("click");//Language entry
            }
        }

        function BindUnitLst() {
            $("#cmbHospUnit").empty();
            var Option = "<option value='{OPTVALUE}'>{OPTEXT}</option>";
            var DefRplOption = Option.replace("{OPTVALUE}", "").replace("{OPTEXT}", "---Select---");
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

