<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.PatientSearch>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style ="text-align:center;color:#016594">
        <label>MR No :</label>
           <input type="text" id= "txtDispSelMRno" style ="width:150px;border:2px solid #e99d55 !important;font-family:Cambria;
                        font-size:13px;font-weight:600;padding:2px;margin-top: -5px;" readonly="readonly" />
        <label id="lblInvNotiCD" style="font-weight: bold !important;color: black; width: auto;webkit-animation: blink 1s step-end infinite;animation: blink 1s step-end infinite;
    background: rgb(251 244 44);padding: 5px;"></label>
       </div><br/>
     <div id="MainDiv" style="margin: auto;">
      
         <div class="row">
            <div class="col-xs-3 col-sm-3" id="anchorComplaints">
                <!-- Left column panels -->
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="CompPrim" title="Alt+C">
                    <div class="panel-body " id="complaints" style="min-height: 60px;">
                        <%--<a class="bgimg " href="#ContentHolderDiv" style="font-size:10px;">Complaints</a>--%>
                    </div>
                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+C"><u>C</u>omplaints</label>
            </div>
            <div class="col-xs-3 col-sm-3" id="anchorvitals">
                <!-- Right column panels -->
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="VitalsPrim" title="Alt+V">
                    <div class="panel-body" id="vitals" style="min-height: 60px;">
                        <%--  <a href="#test1" style="font-size:10px;">Vitals</a>--%>
                    </div>
                </div>
                <label style="text-align: center; font-size: 12px; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+V"><u>V</u>itals</label>
            </div>
            <div class="col-xs-3 col-sm-3" id="anchorexam">
                <!-- right column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="EXAMPrim" title="Alt+X">

                    <div class="panel-body" id="examtn" style="min-height: 60px;">
                        <%--	 <a href="#test1" style="font-size:10px;">On Examination</a>--%>
                    </div>
                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+X">E<u>x</u>amination</label>
            </div>

             <%-- clinicalHistory --%>
              <div class="col-xs-3 col-sm-3" id="cliniCalHistory">
                <!-- right column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="ClinicalHistory" title="Alt+L">

                    <div class="panel-body" id="clinicalHis" style="min-height: 60px;">
                        <%--	 <a href="#test1" style="font-size:10px;">On Examination</a>--%>
                    </div>
                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+L">C<u>l</u>inical Notes</label>
            </div>

            <div class="col-xs-3 col-sm-3" style="width: 100%; margin-bottom: 17px;">
            </div>

            <div class="col-xs-3 col-sm-3" id="anchordiagno">
                <!-- Left column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="DiagnosisPrim" title="Alt+S">

                    <div class="panel-body" id="diag" style="min-height: 60px;">
                        <%--  <a href="#test1" style="font-size:10px;" >Diagnosis</a>--%>
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+S">Diagno<u>s</u>is</label>
            </div>
            

            <div class="col-xs-3 col-sm-3" id="anchorInvestigation">
                <!-- Left column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="InvestPrim" title="Alt+I">

                    <div class="panel-body" id="investgtn" style="min-height: 60px;">
                        <%--		 <a href="#test1" style="font-size:10px;">Investigation</a>--%>
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+I"><u>I</u>nvestigation</label>
            </div>
            <div class="col-xs-3 col-sm-3" id="anchortreatment">
                <!-- right column panels -->
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="MedicinePrim" title="Alt+R">

                    <div class="panel-body" id="treatmnt" style="min-height: 60px;">
                        <%--	  <a href="#test1" style="font-size:10px;">Treatment Advice</a>--%>
                    </div>

                </div>
                <label style="font-size: 12px; margin-top: 6px; display: block; text-align: center; cursor: pointer; color: #025f76 !important;" title="Alt+R"><u>R</u>x</label>
            </div>

            <div class="col-xs-3 col-sm-3" id="anchorPatAdvice">


                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="PatAdvicePrim" title="Alt+A">

                    <div class="panel-body" id="PatAdvice" style="min-height: 60px;">
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; text-align: center; display: block; width: 100%; cursor: pointer; color: #025f76 !important;" title="Alt+A"><u>A</u>dvice</label>
            </div>
            <div class="col-xs-3 col-sm-3" style="width: 100%; margin-top: 10px; margin-bottom: 10px; border-top: none">
            </div>
             <%-- ChemoPlanning --%>
             <div class="col-xs-3 col-sm-3" id="ChemoPlanning">
                <!-- right column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="chemoplan" title="Alt+G">

                    <div class="panel-body" id="chemo" style="min-height: 60px;">
                        <%--	 <a href="#test1" style="font-size:10px;">On Examination</a>--%>
                    </div>
                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+G">Chemo Plannin<u>g</u></label>
            </div>

           <div class="col-xs-3 col-sm-3" id="anchorpresciptn">
                <!-- right column panels -->
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" title="Alt+P" id="Divprescriptn">

                    <div class="panel-body" id="prescriptn" style="min-height: 60px;">
                        <%--	  <a href="#test1" style="font-size:10px;">Treatment Advice</a>--%>
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+P"><u>P</u>rescription</label>

            </div>


            <%--<div class="col-xs-3 col-sm-3" id="anchorvitals">
                <!-- Right column panels -->
                <div class="panel panel-primary" style=" border-radius: 99em;" id="VitalsPrim" >
                  
				<div class="panel-body" id="vitals" style="min-height:60px;">
				 <%--  <a href="#test1" style="font-size:10px;">Vitals</a>--%>
            <%--</div>
  
                    </div>
                  <label style="font-size:10px;       margin-left: -6px; margin-top: -42px;  display: block;   padding: 25px; ">Vitals</label>
            </div>--%>

            <div class="col-xs-3 col-sm-3" style="width: 100%; margin-top: 10px; margin-bottom: 10px; border-top: none">
            </div>

            <div class="col-xs-3 col-sm-3" id="anchorPersonal">
                <!-- Left column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="PersonalPrim" title="Alt+O">

                    <div class="panel-body" id="Personal" style="min-height: 60px;">
                        <%--  <a href="#test1" style="font-size:10px;" >Diagnosis</a>--%>
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+O">Pers<u>o</u>nal History</label>
            </div>

            <div class="col-xs-3 col-sm-3" id="anchorMedical">
                <!-- right column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="MedicalPrim" title="Alt+M">

                    <div class="panel-body" id="Medical" style="min-height: 60px;">
                        <%--	 <a href="#test1" style="font-size:10px;">On Examination</a>--%>
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+M"><u>M</u>edical History</label>
            </div>
            <div class="col-xs-3 col-sm-3" id="anchorFamily">
                <!-- Left column panels -->
                <%--id defined by --%>
                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="FamilyPrim" title="Alt+H">

                    <div class="panel-body" id="Family" style="min-height: 60px;">
                        <%--		 <a href="#test1" style="font-size:10px;">Investigation</a>--%>
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+H">Family <u>H</u>istory</label>
            </div>

             <div class="col-xs-3 col-sm-3" id="anchorAllergy">

                <div class="panel panel-primary" style="margin: auto; border-radius: 2em; cursor: pointer" id="AllergyPrim" title="Alt+Y" >
                

                    <div class="panel-body" id="Allergy" style="min-height: 60px;">
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" >Allerg<u>y</u></label>
            </div>


            <div class="col-xs-3 col-sm-3" style="width: 100%; margin-bottom: 20px; margin-top: 10px; border-top: 2px double #fbd700;">
                </div>  
            <div class="col-lg-12 col-md-12  col-xs-12  col-sm-12 " >
                <div style="display: flex;flex: auto;flex-wrap: wrap;justify-content: space-around;flex-direction: row;">
                  <input type="button" class="" style="width: 150px;font-size: 13px; text-align: right; margin-top: -2%; display: block; cursor: pointer; color: white !important;float:left;background-color: #008bce;
    border-radius: 5px;
    background-image: url(../Images/upload5.png);
    background-repeat: no-repeat;
    background-position-x: 6px;border: 1px; border-radius: 5px;padding-right: 13px;background-position-y: 2px;padding-left: 29px;
    padding-top: 3px;
    padding-bottom: 3px;" id="anchorUpload" value="Upload Prescription" >
                    <input type="button" class="" style="width: 150px;font-size: 13px; text-align: right; margin-top: -2%; display: block; cursor: pointer; color: white !important;float:right;background-color: #008bce;
    border-radius: 5px;
    background-image: url(../Images/upload5.png);
    background-repeat: no-repeat;
    background-position-x: 6px;border: 1px; border-radius: 5px;padding-right: 13px;background-position-y: 2px;padding-left: 29px;
    padding-top: 3px;
    padding-bottom: 3px;" id="anchorUploadSign" value="Upload Signatory" >
                    <input type="button" class="" style="width: 150px;font-size: 13px; text-align: right; margin-top: -2%; display: none; cursor: pointer; color: white !important;float:right;background-color: #008bce;
    border-radius: 5px;
    background-image: url(../Images/upload5.png);
    background-repeat: no-repeat;
    background-position-x: 6px;border: 1px; border-radius: 5px;padding-right: 13px;background-position-y: 2px;padding-left: 29px;
    padding-top: 3px;
    padding-bottom: 3px;" id="Certificate" value="Certificate Issued" >
                </div>
             </div>  
             <%----%>
          <%--  <div class="col-xs-3 col-sm-3" id="anchorUpload">

                <div class="panel panel-primary" style="margin: auto; border-radius: 99em; cursor: pointer" id="UploadPrim" title="Alt+U">
                

                    <div class="panel-body" id="uploadPrescr" style="min-height: 60px;">
                    </div>

                </div>
                <label style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;" title="Alt+U"><u>U</u>pload Prescription</label>
            </div>--%>

            <div>
                <div class="col-xs-3 col-sm-3" style="width: 100%; margin-bottom: 14px; margin-top: 10px; border-top: 2px double #fbd700;">
                </div>
                <%-- <div class="col-xs-4 col-sm-4" style ="border-top: 2px solid #fbd700;
    padding: 20px;">--%>
                <table style="width: 90%; float: left; margin-bottom: 15px; margin-left: 25px;">
                    <tr>
                        <%--<td><%= Html.ActionLink("INVESTIGATION REPORTS", "Investigation", "DoctorDesk")%></td>--%>
                       <td><a href="#" id="InvestRpt">INVESTIGATION REPORTS </a></td>
                          <td><a href="#" style="display:none" id="costestimation">ESTIMATION </a></td>
                        <td><a href="#" id="previousPrep">DICOM</a></td>
                    </tr>
                </table>
                <%--</div>--%>


                <%--                <div class="col-xs-4 col-sm-4" style ="border-top: 2px solid #fbd700;
    padding: 20px;display:none;">
                        <a href="#" id="costestimation" >ESTIMATION </a>
               </div>

                <div class="col-xs-4 col-sm-4" style ="border-top: 2px solid #fbd700;
    padding: 20px;">
                      <a href="#" id="previousPrep">DICOM</a>
              </div>--%>
            </div>

            <div class="col-xs-12 text-center" style="color: rgb(240, 4, 4); background-color: rgb(250, 227, 240); font-weight: BOLD; line-height: 20px; 
                box-shadow: rgb(87 87 86) 2px 3px 4px 0px;" id="prevpresc">  PREVIOUS PRESCRIPTIONS
            </div>

            <div class="col-xs-12" style="margin-top: 27px;margin-left:1px !important;">
                <div class="carousel" id="myCarousel">
                </div>
            </div>

            <div class="col-xs-12 text-center" style="margin-top: 23px; color: rgb(255, 255, 255); background-color: #585b5d;" id="attachments">ATTACHMENTS</div>
            <div class="col-xs-12 col-md-offset-3" style="margin-top: 27px;margin-left:1px !important;">
                <div class="carousel slide" id="newCarousel">
                </div>
            </div>
      
            <%-- added by vijeta on 10th July 2018--%>
            <div class="col-xs-12 text-center" style="margin-top: 23px; color: rgb(240, 4, 4); background-color: rgb(250, 227, 240); font-weight: BOLD; line-height: 20px; box-shadow: rgb(87, 87, 86) 0px 0.5px 0px 2px;" id="prevSptReporting">PREVIOUS SPT REPORTING</div>
            <div class="col-xs-12" style="margin-top: 27px;margin-left:1px !important;">
                <div class="carousel" id="newCarouselSPT">
                </div>
            </div>

            <%--added by vijeta on 11th July 2018--%>
            <div class="col-xs-12 text-center" style="margin-top: 23px; color: rgb(240, 4, 4); background-color: rgb(250, 227, 240); font-weight: BOLD; line-height: 20px; box-shadow: rgb(87, 87, 86) 0px 0.5px 0px 2px;" id="prevAllergies">PREVIOUS ALLERGIES</div>
            <div class="col-xs-12" style="margin-top: 27px;margin-left:1px !important;">
                <div class="carousel" id="newCarouselAllergy">
                </div>
            </div>
        </div>
        <div style="display: none">
            <h2>Preview:</h2>
            <p>
                <input style="display: none" type="file" id="take-picture" accept="image/*" style="font-size: 12px; text-align: center; margin-top: 6px; display: block; cursor: pointer; color: #025f76 !important;">
                <img src="about:blank" alt="" style="height: 600px; width: 300px;" id="show-picture">
            </p>
        </div>
    </div>
    <input type="hidden" id="hdnGDoctCode" />
    <%--added by vijeta on 27th march 2018--%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        a {
            /*color: #3c8dbc;
    text-decoration: none;*/
            text-shadow: 1px 0px 1px;
            letter-spacing: 1px;
            /*font-size: 12px;*/
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

        .patNameCls {
            cursor: pointer;
        }

        .carousel-control.left, .carousel-control.right {
            margin-left: 15px;
            background-image: none;
        }

        .slide {
            margin-left : 0px;
            /*width: 50% !important;*/
        }

        #MainDiv {
            width: 100%;
        }

        @media only screen and (min-width : 640px) {

            #MainDiv {
                width: 60% !important;
            }
        }

        @media only screen and (min-width : 340px)and (max-width: 768px) {
            .slide {
                width: 75% !important;
            }
        }
       
    </style>
    <script src="../Scripts/PatList.js"></script>
    <%--<script src="alert.js"></script>--%>
    <script type="text/javascript">
        var globalLoginDoctCode = '<%:Session["gDoctCode"]%>';// added by vijeta on 20th sep 2018
        var CurrentDate = '<%:Model.CurDate%>';
        var btnID = "";
        var glbPatMRnt = "";
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";

        var patCompletedYN = "";
        var DisplayCertificateYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("CERTIFICATESHOWYN")%>';
        var Certificate2 = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("YARAFITNESSCERTIFICATE")%>';
        // AddClinics(urls);//commented vijeta 30/4/19
        BottomLine1 = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine1")%>';
        BottomLine2 = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine2")%>'
        var QMSCall = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("QMSENABLE")%>'; //Added By RAJAN
        var ISICDDiagReq = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("isICDDiagnoReq")%>'; //Added By Priyanka
        var ISDiagnoMandatory = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DiagnosisMandatory")%>';//Added By Priyanka
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
        var ShowVitalsInPrescPrintYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ShowVitalsExtraFieldsinPrescPrint")%>';//Priyanka 26/12/2025
        $(document).ready(function (e) {
            document.querySelectorAll('.content').forEach(function (element) {
                element.style.margin = "0";
            });
            HoldOn.open();// // Meenashi

            GetAllCounts(); //Meenakshi shifted this method on top as those green flag colors were displaying after one or two seconds

            Patpresc($.session.get('PatCompleted'));
            GetPrevoisSptReports(); //added on 10th July 2018
            GetPrevoisAllergies(); //added on 11th July 2018
            GetAttachments($.session.get('PatMRNO')); // 
            //meenakshi Photo Upload from camera
            $("#slide_sdList").hide();//kavita 12-aug-2019
            (function () {
                var takePicture = document.querySelector("#take-picture"),
                    showPicture = document.querySelector("#show-picture");

                if (takePicture && showPicture) {
                    // Set events
                    takePicture.onchange = function (event) {
                        // Get a reference to the taken picture or chosen file
                        var files = event.target.files,
                            file;
                        if (files && files.length > 0) {
                            file = files[0];
                            try {
                                // Get window.URL object
                                var URL = window.URL || window.webkitURL;

                                // Create ObjectURL
                                var imgURL = URL.createObjectURL(file);

                                // Set img src to ObjectURL
                                showPicture.src = imgURL;

                                //To convert image from blob to base 64...

                                //var reader = new FileReader();
                                //reader.readAsDataURL(file);


                                // Revoke ObjectURL after imagehas loaded
                                showPicture.onload = function () {
                                    // UploadPrescription(reader.result.toString());
                                    URL.revokeObjectURL(imgURL);
                                };
                            }
                            catch (e) {
                                try {
                                    // Fallback if createObjectURL is not supported
                                    var fileReader = new FileReader();
                                    fileReader.onload = function (event) {
                                        showPicture.src = event.target.result;
                                        var strbase64image = $('#show-picture').attr('src');
                                        //UploadPrescription(strbase64image);

                                    };
                                    fileReader.readAsDataURL(file);
                                }
                                catch (e) {
                                    // Display error message
                                    var error = document.querySelector("#error");
                                    if (error) {
                                        alert("Neither createObjectURL or FileReader are supported");
                                    }
                                }
                            }
                        }
                    };
                }

            })();

            $("#anchorUpload").click(function () {
                var Mrno = ("" + $.session.get('PatMRNO')).toString();
                if (Mrno != "" && Mrno != "undefined") {
                    $("#take-picture").trigger("click");//Family History
                }
                else {
                    $.messager.alert("Alert", "Please select patient!");
                }
            });

            $("#anchorUploadSign").click(function () {
                window.location.href = '../DoctorDesk/Signatory';

            });

            $("#Certificate").click(function () {
                var Mrno = ("" + $.session.get('PatMRNO')).toString();
                if (Mrno != "" && Mrno != "undefined") {
                    window.location.href = '../DoctorDesk/Certificate';
                }
                else {
                    $.messager.alert("Alert", "Please select patient!");
                }
            });
            $("#Certificate").click(function () {
                var Mrno = ("" + $.session.get('PatMRNO')).toString();
                if (Mrno != "" && Mrno != "undefined") {
                    if (Certificate2 == "Y") {
                        window.location.href = '../DoctorDesk/Certificate2';
                    }
                    else {
                        window.location.href = '../DoctorDesk/Certificate';
                    }
                }
                else {
                    $.messager.alert("Alert", "Please select patient!");
                }
            });

            $("#txtDispSelMRno").val($.session.get('PatMRNO'));

            $("#lblInvNotiCD").hide();

            // ''' Photo capture and upload on server
            <%--localStorage.setItem('DDUSERID', '<%:Session["gOncoUserId"]%>');
            localStorage.setItem('DDNAME', '<%:Session["gDoctName"]%>');--%>
            $("#hdnGDoctCode").val("" + '<%:Session["gDoctCode"]%>' + ""); //added on 27th march 2018
            //
            $.session.set('Pagefrom', "");

            document.getElementById("prevpresc").style.display = "none";
            document.getElementById("attachments").style.display = "none";
            document.getElementById("prevSptReporting").style.display = "none";//added on 10th July 2018
            document.getElementById("prevAllergies").style.display = "none";//added on 11th July 2018
            //end

            SetPatientDtl();

            //added on 25th april 2018
            GetPatNotes($.session.get('PatTRANNO'), $.session.get('PatMRNO'));


            document.getElementById("treatmnt").style.backgroundImage = "url( ../Images/pil.png)";
            //document.getElementById("treatmnt").style.backgroundSize = "cover";
            document.getElementById("treatmnt").style.backgroundRepeat = "no-repeat";
            document.getElementById("treatmnt").style.backgroundPosition = "center";

            document.getElementById("investgtn").style.backgroundImage = "url( ../Images/heart.png)";
            //document.getElementById("investgtn").style.backgroundSize = "cover";
            document.getElementById("investgtn").style.backgroundRepeat = "no-repeat";
            document.getElementById("investgtn").style.backgroundPosition = "center";

            document.getElementById("examtn").style.backgroundImage = "url( ../Images/examm.png)";
            //document.getElementById("examtn").style.backgroundSize = "cover";
            document.getElementById("examtn").style.backgroundRepeat = "no-repeat";
            document.getElementById("examtn").style.backgroundPosition = "center";

            document.getElementById("diag").style.backgroundImage = "url( ../Images/stethoscope.png)";
            //document.getElementById("diag").style.backgroundSize = "cover";
            document.getElementById("diag").style.backgroundRepeat = "no-repeat";
            document.getElementById("diag").style.backgroundPosition = "center";

            document.getElementById("vitals").style.backgroundImage = "url( ../Images/vit.png)";
            //document.getElementById("vitals").style.backgroundSize = "cover";
            document.getElementById("vitals").style.backgroundRepeat = "no-repeat";
            document.getElementById("vitals").style.backgroundPosition = "center";

            document.getElementById("complaints").style.backgroundImage = "url( ../Images/cmpltss.png)";
            //document.getElementById("complaints").style.backgroundSize = "cover";
            document.getElementById("complaints").style.backgroundRepeat = "no-repeat";
            document.getElementById("complaints").style.backgroundPosition = "center";

            document.getElementById("prescriptn").style.backgroundImage = "url( ../Images/prescrp.png)";
            //document.getElementById("prescriptn").style.backgroundSize = "cover";
            document.getElementById("prescriptn").style.backgroundRepeat = "no-repeat";
            document.getElementById("prescriptn").style.backgroundPosition = "center";

            document.getElementById("PatAdvice").style.backgroundImage = "url( ../Images/patadv.png)";
            document.getElementById("PatAdvice").style.backgroundRepeat = "no-repeat";
            document.getElementById("PatAdvice").style.backgroundPosition = "center";

            document.getElementById("Personal").style.backgroundImage = "url( ../Images/addictns.png)";
            //document.getElementById("treatmnt").style.backgroundSize = "cover";
            document.getElementById("Personal").style.backgroundRepeat = "no-repeat";
            document.getElementById("Personal").style.backgroundPosition = "center";

            document.getElementById("Medical").style.backgroundImage = "url( ../Images/medHis.png)";
            //document.getElementById("examtn").style.backgroundSize = "cover";
            document.getElementById("Medical").style.backgroundRepeat = "no-repeat";
            document.getElementById("Medical").style.backgroundPosition = "center";

            document.getElementById("Family").style.backgroundImage = "url( ../Images/fmlyHis.png)";
            //document.getElementById("investgtn").style.backgroundSize = "cover";
            document.getElementById("Family").style.backgroundRepeat = "no-repeat";
            document.getElementById("Family").style.backgroundPosition = "center";

            //document.getElementById("uploadPrescr").style.backgroundImage = "url( ../Images/Upload.png)";
            ////document.getElementById("investgtn").style.backgroundSize = "cover";
            //document.getElementById("uploadPrescr").style.backgroundRepeat = "no-repeat";
            //document.getElementById("uploadPrescr").style.backgroundPosition = "center";


            document.getElementById("Allergy").style.backgroundImage = "url( ../Images/allergyIcon.png)";
            //document.getElementById("investgtn").style.backgroundSize = "cover";
            document.getElementById("Allergy").style.backgroundRepeat = "no-repeat";
            document.getElementById("Allergy").style.backgroundPosition = "center";

            document.getElementById("clinicalHis").style.backgroundImage = "url( ../Images/examm.png)";
            //document.getElementById("examtn").style.backgroundSize = "cover";
            document.getElementById("clinicalHis").style.backgroundRepeat = "no-repeat";
            document.getElementById("clinicalHis").style.backgroundPosition = "center";

            document.getElementById("chemo").style.backgroundImage = "url( ../Images/chemoPlanning.png)";
            //document.getElementById("examtn").style.backgroundSize = "cover";
            document.getElementById("chemo").style.backgroundRepeat = "no-repeat";
            document.getElementById("chemo").style.backgroundPosition = "center";


            document.getElementById("previousPrep").style.marginLeft = "30px";
            document.getElementById("costestimation").style.marginLeft = "60px";//

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";


            }
            $("#divNotes").css("display", "block");// added by vijeta on 24th april 2018

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

            patCompletedYN = $.session.get('PatCompleted');

            $("#anchorComplaints").click(function () {

                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/Complaints';
                }
            });

            $("#anchorAllergy").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/AllergyHist';
                }
            });

            

            $("#anchorvitals").click(function () {
                //if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                //    $.messager.alert("Alert", "Please Select Patient");
                //}
                //else {//if (patCompletedYN == "N")
                //    if (CheckPatSessionNotEmpty())
                //        window.location.href = '../DoctorDesk/Vitals';
                //}
                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/Vitals';
                }
            });

            //added by roshan
            $("#chemoplan").click(function () {
                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/ChmoPlanning?PatMRNO=' + $.session.get('PatMRNO');
                }
            });
            // roshan
            $("#cliniCalHistory").click(function () {
                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/ClinicalNotes';
                }
            });

            $("#anchordiagno").click(function () {
                //if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                //    $.messager.alert("Alert", "Please Select Patient");
                //}
                //else {//if (patCompletedYN == "N")
                //    if (CheckPatSessionNotEmpty())
                //        window.location.href = '../DoctorDesk/Diagnosis';
                //}
                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/Diagnosis';
                }
            });

            $("#anchorexam").click(function () {

                //if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                //    $.messager.alert("Alert", "Please Select Patient");
                //}
                //else {//if (patCompletedYN == "N")
                //    if (CheckPatSessionNotEmpty())
                //        window.location.href = '../DoctorDesk/Examination';
                //}

                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/Examination';
                }
            });

            $("#anchorInvestigation").click(function () {
                //if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                //    $.messager.alert("Alert", "Please Select Patient");
                //}
                //else {//if (patCompletedYN == "N")
                //    if (CheckPatSessionNotEmpty())
                //        window.location.href = '../DoctorDesk/InvestigationTran';
                //}
                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/InvestigationTran';
                }
            });
            $("#anchortreatment").click(function () {
                <%--if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else
                {
                    if (CheckPatSessionNotEmpty())
                        if ($(window).width() >= 996) {//if condition added by vij on 19th oct
                            if ('<%:Session["CIMYN"]%>' == "Y")
                                window.location.href = '../DoctorDesk/RxNewSearch';
                            else
                                window.location.href = '../DoctorDesk/RxDesktop';
                        }
                        else {
                            if ('<%:Session["CIMYN"]%>' == "Y")
                                window.location.href = '../DoctorDesk/RxNewSearch';
                            else
                                window.location.href = '../DoctorDesk/RxDesktop';
                        }
                }--%>
                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        if ($(window).width() >= 996) {//if condition added by vij on 19th oct
                            if ('<%:Session["CIMYN"]%>' == "Y")
                                window.location.href = '../DoctorDesk/RxNewSearch';
                            else
                                window.location.href = '../DoctorDesk/RxDesktop';
                        }
                        else {
                            if ('<%:Session["CIMYN"]%>' == "Y")
                                window.location.href = '../DoctorDesk/RxNewSearch';
                            else
                                window.location.href = '../DoctorDesk/RxDesktop';
                        }
                }
            });

            $("#anchorpresciptn").click(function () {
                ////debugger;
                if (CheckMandatory()) {
                   <%-- if (('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("isICDDiagnoReq")%>') == "Y" && localStorage.getItem('ICDDiagSelYN') == "N")
                    {
                        $.messager.alert("Alert", "Please select ICD diagnosis.");
                        return false;
                    
                    }--%>
                    if (!CheckDiagnosisValidation(ISICDDiagReq, ISDiagnoMandatory))
                    {
                        return false;
                    }
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/PrescriptionPrint';
                }
            });

            $("#anchorprevinvest").click(function () {

                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/Investigation';
                }
            });

            $("#anchorPatAdvice").click(function () {

                if (CheckMandatory()) {
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/PatientAdvice';
                }
            });

            var pagefrom = '../DoctorDesk/PatientEntry';
            $.session.set('Pagefrom', pagefrom);

            $("#anchorPersonal").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/PersonalHist';
                }
                //if (patCompletedYN == "N") {
                //    if (CheckPatSessionNotEmpty())
                //        window.location.href = '../ClinicalNotes/PersonalHist';
                //}
                //else
                //    $.messager.alert("Information", "Please Select Patient");
            });

            $("#anchorMedical").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/MedicalHist';
                }
                //if (patCompletedYN == "N") {
                //    if (CheckPatSessionNotEmpty())
                //        window.location.href = '../ClinicalNotes/MedicalHist';
                //}
                //else
                //    $.messager.alert("Information", "Please Select Patient");
            });

            $("#anchorFamily").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../ClinicalNotes/FamilyHist';
                }
                //if (patCompletedYN == "N") {
                //    if (CheckPatSessionNotEmpty())
                //        window.location.href = '../ClinicalNotes/FamilyHist';
                //}
                //else
                //    $.messager.alert("Information", "Please Select Patient");
            });

            $("#previousPrep").click(function () {
                var Mrno = ($.session.get('PatMRNO')).toString();
                if (Mrno != "") {
                    HoldOn.open();
                    $.ajax({
                        type: 'POST',
                        url: '../DoctorDesk/RedirectToDicom',
                        data: { mrNo: Mrno },
                        success: function (data) {
                            HoldOn.close();
                            window.open(data);
                        },
                        error: function () {
                            HoldOn.close();
                        }
                    });
                }
            });

            $("#anchorcomplete").click(function () {
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
                                $.session.set('Pagefrom', "");

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
                    $.messager.alert("Alert", "Please Select Patient");
            });
            $("#costestimation").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {//if (patCompletedYN == "N")
                    if (CheckPatSessionNotEmpty())
                        window.location.href = '../DoctorDesk/CostEstimation';
                }
            });

            $("#InvestRpt").click(function () {
                if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {
                    if (CheckPatSessionNotEmpty())
                        var MRNO = $.session.get('PatMRNO');
                    window.location.href = '../DoctorDesk/Investigation?MRNO=' + $("#txtDispSelMRno").val();
                }
            });

            //end


            //$('#prescriptn').click(function (e) {
            //    if (CheckPatSessionNotEmpty())
            //        window.location.href = '../DoctorDesk/PrescriptionPrint';
            //    else
            //        $.messager.alert("Information", "Please Select Patient");
            //});

           
            // register the handler 
            document.addEventListener('keyup', doc_keyUp, false);// added by vijeta on 2nd April 2018 for shoetcut keys


            $('#take-picture').on('change', function (e) {
                var Mrno = ("" + $.session.get('PatMRNO')).toString();

                var files = e.target.files;
                //var myID = 3; //uncomment this to make sure the ajax URL works
                if (files.length > 0) {
                    HoldOn.open();
                    if (window.FormData !== undefined) {
                        var data = new FormData();
                        for (var x = 0; x < files.length; x++) {
                            data.append("file" + x, files[x]);
                        }
                        $.ajax({
                            type: "POST",
                            url: '../DoctorDesk/UploadPrescriptFile?mrno=' + Mrno,
                            contentType: false,
                            processData: false,
                            data: data,
                            success: function (result) {
                                HoldOn.close();
                                alert(result, "Information");
                                GetAttachments(Mrno);
                            },
                            error: function (xhr, status, p3, p4) {
                                HoldOn.close();
                                var err = "Error " + " " + status + " " + p3 + " " + p4;
                                if (xhr.responseText && xhr.responseText[0] == "{")
                                    err = JSON.parse(xhr.responseText).Message;
                                alert("Error", err);
                            }
                        });
                    } else {
                        $.messager.alert("This browser doesn't support HTML5 file uploads!");
                    }
                }

            });
            //28-11-2019 15:58
            var Mrno = ("" + $.session.get('PatMRNO')).toString();
            if (Mrno == "" || Mrno == "undefined") {
                if ($(window).width() < 992) {
                    $("#menuList").css("display", "block");
                    var menuList = document.getElementById('menuList');
                    menuList.style.display = "block";
                    var dispLst = document.getElementById('sideList');
                    dispLst.style.display = "block";
                    $('#menuBar').click();
                }
            }
            $('#menuBar').click(function (e) {
                var pg = '<%=System.Web.HttpContext.Current.Session["PageId"]%>';
                if (pg != "Menu") {
                    var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
                    AddClinics(urls, "Y");
                }
                else {
                    var patList = document.getElementById('patList');
                    patList.style.display = "none";
                    var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
                    AddClinics(urls, "Y");
                }
            });

            HoldOn.close(); // Meenashi

            if (DisplayCertificateYN == "Y")
                document.getElementById("Certificate").style.display = "block";
        });

        //function UploadPrescription(strbase64image) {

        //    var Mrno = $.session.get('PatMRNO').toString();
        //    var strTran = $.session.get('PatTRANNO').toString();
        //    if (Mrno != "") {
        //        HoldOn.open();
        //        //window.location.href = '../DoctorDesk/RedirectToDicom?mrNo=' + Mrno;// 
        //        $.ajax({
        //            type: 'POST',
        //            url: '../DoctorDesk/UploadPrescriptFile',
        //            data: { mrno: Mrno, strImageIn64Format: strbase64image, consNo: strTran },
        //            async: false,
        //            success: function (response) {
        //                HoldOn.close();
        //                alert(response);
        //            },
        //            error: function () {
        //                HoldOn.close();
        //                alert("Something went wrong please try again.");
        //            }
        //        });
        //    }
        //}

        //function CheckPatSessionNotEmpty() {
        //    var mrNo = $.session.get('PatMRNO');
        //    var tranno = $.session.get('PatTRANNO');
        //    if (tranno != null) {
        //        if (mrNo != "" && tranno != "")
        //            return true;
        //        else
        //            return false;
        //    }
        //    else
        //        return false;
        //}
        function CheckMandatory() {
            ////debugger;
            if (typeof patCompletedYN === "undefined" || patCompletedYN === null) {
                $.messager.alert("Alert", "Please Select Patient");
                return false;
            }
            if (('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("isHistReq")%>') == "Y") {

                  if ($("div#PersonalPrim")[0].style.backgroundColor != "rgb(203, 245, 203)") {
                      $.messager.alert("Alert", "Please enter personal history.");
                      return false;
                  }
                  else if ($("div#MedicalPrim")[0].style.backgroundColor != "rgb(203, 245, 203)") {
                      $.messager.alert("Alert", "Please enter Medical history.");
                      return false;
                  }
                  else if ($("div#AllergyPrim")[0].style.backgroundColor != "rgb(203, 245, 203)") {
                      $.messager.alert("Alert", "Please enter Allergy data.");
                      return false;
                  }
                  else
                      return true;
              }
            <%--else if (('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("isICDDiagnoReq")%>') == "Y") 
            {
                if ($("div#MedicalPrim")[0].style.backgroundColor != "rgb(203, 245, 203)") {
                    $.messager.alert("Alert", "Please enter ICD diagnosis data.");
                    return false;
                }
           }--%>
              else
                  return true;
          }

          function Validate() {
              try {

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

                  if (("" + $('#txtCONSDATE').val()).trim() != "") {
                      if (CurrentDate != $('#txtCONSDATE').val().trim() && ("" + $('#txtTRANNO').val()).trim() == "") {
                          $.messager.alert("Information", "Can not perform transaction on this records");
                          return false
                      }
                  }

                  if (count == 0) {

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
          function GetCopy(oldTranno) {
              $.confirm({
                  title: 'Confirmation',
                  content: 'Are you sure want to Copy privious transaction ?',
                  buttons: {
                      confirm: function () {
                          CopyPrescription(oldTranno);
                      },
                      cancel: function () {
                          $.alert('Canceled!');
                      },
                  }
              });
          }
          function CopyPrescription(oldTranno) {
              var mrno = ($.session.get('PatMRNO'));
              var tranNo = ($.session.get('PatTRANNO'));

              $.ajax({
                  type: "POST",
                  url: 'SaveCopy',
                  datatype: "json",
                  data: { PrevTranNo: oldTranno.title, strMRNO: mrno, strTranNo: tranNo },
                  success: function (result) {
                      //if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1)
                      //    $.messager.alert('Information', 'Copied Successfully');
                      GetAllCounts();
                  },
              });
          }

          //function GetAllCounts() {
          //    var strTranNo = $.session.get('PatTRANNO');
          //    if (strTranNo != undefined) {
          //        $.ajax({
          //            url: 'GetCounts',  //Pass URL here 
          //            type: "POST", //Also use GET method,
          //            datatype: "json",
          //            data: { strTranNo: strTranNo },
          //            success: function (data) {
          //                if (data != "") {
          //                    if (data["COMPLAINTS"] == "Y")
          //                        $("div#CompPrim")[0].style.backgroundColor = 'rgb(203, 245, 203)';
          //                    else
          //                        $("div#CompPrim")[0].style.backgroundColor = 'transparent';
          //                    //$("div#CompPrim")[0].css('background-color', 'blue')

          //                    if (data["VITALS"] == "Y")
          //                        $("div#VitalsPrim")[0].style.backgroundColor = "rgb(203, 245, 203)"
          //                    else
          //                        $("div#VitalsPrim")[0].style.backgroundColor = 'transparent';


          //                    if (data["DIAGNOSIS"] == "Y")
          //                        $("div#DiagnosisPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
          //                    else
          //                        $("div#DiagnosisPrim")[0].style.backgroundColor = 'transparent';


          //                    if (data["EXAMINATION"] == "Y")
          //                        $("div#EXAMPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
          //                    else
          //                        $("div#EXAMPrim")[0].style.backgroundColor = 'transparent';


          //                    if (data["INVESTIGATIONS"] == "Y")
          //                        $("div#InvestPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
          //                    else
          //                        $("div#InvestPrim")[0].style.backgroundColor = 'transparent';

          //                    if (data["MEDICINE"] == "Y")
          //                        $("div#MedicinePrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
          //                    else
          //                        $("div#MedicinePrim")[0].style.backgroundColor = 'transparent';

          //                    if (data["PATADVICE"] == "Y")
          //                        $("div#PatAdvicePrim")[0].style.backgroundColor = "rgb(203, 245, 203)"; //#d2d6de
          //                    else
          //                        $("div#PatAdvicePrim")[0].style.backgroundColor = 'transparent';

          //                    //added on 28th march 2018
          //                    if (data["ADDICTHISTORY"] == "Y")
          //                        $("div#PersonalPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
          //                    else
          //                        $("div#PersonalPrim")[0].style.backgroundColor = 'transparent';

          //                    if (data["MEDICINEHISTORY"] == "Y")
          //                        $("div#MedicalPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
          //                    else
          //                        $("div#MedicalPrim")[0].style.backgroundColor = 'transparent';

          //                    if (data["FAMILYHISTORY"] == "Y")
          //                        $("div#FamilyPrim")[0].style.backgroundColor = "rgb(203, 245, 203)";
          //                    else
          //                        $("div#FamilyPrim")[0].style.backgroundColor = 'transparent';
          //                    //------------------------------------

          //                }
          //            }
          //        });
          //    }
          //}

          // define a handler added by vijeta on 2nd April 2018 for shoetcut keys
          function doc_keyUp(e) {

              if (e.altKey && e.keyCode == 67) {// C
                  // call your function to do the thing
                  $("#anchorComplaints").trigger("click");// Complaints
              }
              else if (e.altKey && e.keyCode == 86)// alt+V
              {
                  $("#anchorvitals").trigger("click");//vitals
              }
              else if (e.altKey && e.keyCode == 83) {//S
                  $("#anchordiagno").trigger("click");//Diagnosis
              }
              else if (e.altKey && e.keyCode == 88) {//X
                  $("#anchorexam").trigger("click");//Examination
              }
              else if (e.altKey && e.keyCode == 73) {//I
                  $("#anchorInvestigation").trigger("click");//investigations
              }
              else if (e.altKey && e.keyCode == 82) { //R
                  $("#anchortreatment").trigger("click");//Rx advice
              }
              else if (e.altKey && e.keyCode == 65) { //A
                  $("#anchorPatAdvice").trigger("click");//Advice
              }
              else if (e.altKey && e.keyCode == 80) { //P
                  $("#anchorpresciptn").trigger("click");//Prescription
              }
              else if (e.altKey && e.keyCode == 79) { //O
                  $("#anchorPersonal").trigger("click");//Personal History
              }
              else if (e.altKey && e.keyCode == 77) { //M
                  $("#anchorMedical").trigger("click");//Medical History
              }
              else if (e.altKey && e.keyCode == 76) { //L
                  $("#cliniCalHistory").trigger("click");
              }
              else if (e.altKey && e.keyCode == 85) {//kavita 14-8-18
                  $("#anchorUpload").trigger("click");
              }
              else if (e.altKey && e.keyCode == 72) {//H
                  $("#anchorFamily").trigger("click");//Family History
              }//kavita 14-8-18
              else if (e.altKey && e.keyCode == 71) {//G
                  $("#chemoplan").trigger("click");
              }
              else if (e.altKey && e.keyCode == 89) {//Y
                  $("#AllergyPrim").trigger("click");
              }
          }
          function CallPatient() {

              var Mrno = $.session.get('PatMRNO').toString();
              var strPatName = $.session.get('PatName').toString();
              var ConsToken = $.session.get('TokenNo').toString();
              var ConsltnNo = $.session.get('ConsltnNo').toString();
              var DoctCode = '<%:Session["gDoctCode"]%>';

            if (Mrno != "") {
                HoldOn.open();
                //window.location.href = '../DoctorDesk/RedirectToDicom?mrNo=' + Mrno;// 
                $.ajax({
                    type: 'POST',
                    url: '../DoctorDesk/CallWaitPatSave',
                    data: { mrno: Mrno, consNo: ConsltnNo, TokenNo: ConsToken, Doctor: DoctCode, Patient: strPatName },
                    async: false,
                    success: function (response) {
                        HoldOn.close();
                        alert(response);
                    },
                    error: function () {
                        HoldOn.close();
                        alert("Something went wrong please try again.");
                    }
                });
            }
        }
    </script>
</asp:Content>
