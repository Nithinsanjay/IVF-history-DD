<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>

<style type="text/css">

    .DivRightMenuFormSlidePopup.active.history  {
        width: 45vw;
    }

    .medical-history-wrapper{

    }

    .custom-med-hist-header{
         border-bottom:4px solid orange;
    }   

    .text-primary-custom {
        color: #1c66ec;
        font-weight:600;
        font-family: system-ui !important;
    }

</style>

<script type="text/javascript">
    var RMOFlagEditHistoryYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOHISTORYYN")%>' == "Y" ? "N" : "Y") : "N"; //priyanka 11/04/2026
    var AuthYN = '<%: Session["AUTHYN"] ?? "" %>';//priyanka 11/04/2026
    $(document).ready(function () {
        //debugger;
        resizeMedicalHistoryPopup();
        PatHistoryTab();
        getSurgicalHistory();

        //Priyanka 11/06/2026
        if (AuthYN == "Y" || RMOFlagEditHistoryYN == "Y") {
            document.getElementById("editIconFamilyHistory").style.display = "none";
            document.getElementById("editIconPersonalHist").style.display = "none";
            document.getElementById("editIconMedicalHist").style.display = "none";
            document.getElementById("editIconAllergyHist").style.display = "none";
            document.getElementById("editIconSurgicalHist").style.display = "none";
        }
        else {
            document.getElementById("editIconFamilyHistory").style.display = "inline-block";
            document.getElementById("editIconPersonalHist").style.display = "inline-block";
            document.getElementById("editIconMedicalHist").style.display = "inline-block";
            document.getElementById("editIconAllergyHist").style.display = "inline-block";
            document.getElementById("editIconSurgicalHist").style.display = "inline-block";
        }
        //End
    });

    function resizeMedicalHistoryPopup() {
    }

    // Family History
    function modifyFamilyHistory() {
        HistoryPopupOpen("Family History", "FamilyHistory", true);
    }

    // Procces Family History Content 
    function getFamilyHistoryContent() {
        startLoading('Loading');
        let result = "";
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../SinglePage/FamilyHistory',
            async: false,
            success: function (response) {
                result = response;
            },
            error: function (xhr, status, error) {
                ToastMsg("Error loading Family History", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
        return result;
    }

    // Personal History
    function modifyPersonalHistory() {
        HistoryPopupOpen("Personal History", "PersonalHistory", true)
    }

    // Procces Personal History Content 
    function getPersonalHistoryContent() {
        startLoading('Loading');
        let result = "";
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../SinglePage/PersonalHistory',
            async: false,
            success: function (response) {
                result = response;
            },
            error: function (xhr, status, error) {
                ToastMsg("Error loading Personal History", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
        return result;
    }

    // Medical History 
    function modifyMedicalHistory() {
        HistoryPopupOpen("Medical History", "MedicalHistory", true)
    }

    // Procces Personal History Content 
    function getMedicalHistoryContent() {
        startLoading('Loading');
        let result = "";
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../SinglePage/MedicalHistory',
            async: false,
            success: function (response) {
                result = response;
            },
            error: function (xhr, status, error) {
                ToastMsg("Error loading Medical History", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
        return result;
    }


    // Patient Medical History Section
    function modifyPatientMedicalHistory() {
        HistoryPopupOpen("Patient Medical History", "PatientMedicalHistory", true);
    }

    function getPatientMedicalHistoryContent() {
        startLoading('Loading');
        let result = "";
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../SinglePage/PatientMedicalHistory',
            async: false,
            success: function (response) {
                result = response;
            },
            error: function (xhr, status, error) {
                ToastMsg("Error loading Medical History", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
        return result;
    }

    // Allergy Section 
    function modifyAllergy() {
        HistoryPopupOpen("Allergy", "AllergySection", true)
    }

    function getAllergyHistoryContent() {
        startLoading('Loading');
        let result = "";
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../SinglePage/AllergyHistory',
            async: false,
            success: function (response) {
                result = response;
            },
            error: function (xhr, status, error) {
                ToastMsg("Error loading Allergy History", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
        return result;
    }
    function PatHistoryTab() {

        //var mrNo = sessionStorage.getItem('PatMRNO');
        var mrNo = GetSessionMRNO();
        if (!mrNo) return;

        var gDurTypeHis = { 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };

        var gRelation = {
            '01': 'Father', '02': 'Mother', '03': 'Wife',
            '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
            '07': 'Grand Mother', '08': 'Maternal Aunt',
            '09': 'Maternal Uncle', '10': 'Paternal Uncle',
            '11': 'Paternal Aunt'
        };

        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetHistory",
            data: { strMrNo: mrNo },
            dataType: "json",
            success: function (result) {

                /* ================= FAMILY HISTORY ================= */
                var familyHtml = "";

                if (result.jsonFamily && result.jsonFamily.length > 0) {
                    familyHtml += "<ul>";
                    for (var i = 0; i < result.jsonFamily.length; i++) {

                        var dur = result.jsonFamily[i].DURATION != "0"
                            ? " since " + result.jsonFamily[i].DURATION + " " +
                              gDurTypeHis[result.jsonFamily[i].DURTYPE] + "(s)"
                            : "";

                        familyHtml += "<li>" +
                            gRelation[result.jsonFamily[i].RELATION] +
                            " (" + result.jsonFamily[i].AGE + " Years), suffering from " +
                            "<b>" + result.jsonFamily[i].DISEASES + "</b>" + dur +
                            "</li>";
                    }
                    familyHtml += "</ul>";
                }

                if (result.jsonFreeFamily && result.jsonFreeFamily.length > 0) {
                    familyHtml += "<ul>";
                    for (var i = 0; i < result.jsonFreeFamily.length; i++) {
                        familyHtml += "<li>" + result.jsonFreeFamily[i].FAMHIST + "</li>";
                        //familyHtml +=
                        //    "<div class='mt-2 p-2 border rounded bg-light'>" +
                        //    "<small class='text-muted'>" +
                        //    result.jsonFreeFamily[i].TRANDATE +
                        //    "</small><br/>" +
                        //    result.jsonFreeFamily[i].FAMHIST +
                        //    "</div>";
                    }
                    familyHtml += "</ul>";
                }

                $("#familyHistoryContent").html(
                    familyHtml || "<span class='text-muted'>No Family History Found</span>"
                );

                /* ================= PERSONAL HISTORY ================= */
                var personalHtml = "";

                if (result.jsonPersonal && result.jsonPersonal.length > 0) {
                    personalHtml += "<ul>";
                    for (var i = 0; i < result.jsonPersonal.length; i++) {

                        var dur = result.jsonPersonal[i].STOPAGE != "0"
                            ? " from "
                            //+ result.jsonPersonal[i].STOPAGE + " " + result.jsonPersonal[i].STARTAGE
                            //: "";
                            + result.jsonPersonal[i].STOPAGE + " " + result.jsonPersonal[i].STARTAGE.replace(/s$/, "(s)") //priyanka 09/04/2026
                            : "";

                        personalHtml += "<li><b>" +
                            result.jsonPersonal[i].NAME +
                            "</b>" + dur + "</li>";
                    }
                    personalHtml += "</ul>";
                }

                if (result.jsonFreePersonal && result.jsonFreePersonal.length > 0) {
                    personalHtml += "<ul>";
                    for (var i = 0; i < result.jsonFreePersonal.length; i++) {
                        personalHtml += "<li>" + result.jsonFreePersonal[i].PERSHIST + "</li>";
                        //personalHtml +=
                        //    "<div class='mt-2 p-2 border rounded bg-light d-none'>" +
                        //    "<small class='text-muted'>" +
                        //    result.jsonFreePersonal[i].TRANDATE +
                        //    "</small><br/>" +
                        //    result.jsonFreePersonal[i].PERSHIST +
                        //    "</div>";
                    }
                    personalHtml += "</ul>";
                }

                $("#personalHistoryContent").html(
                    personalHtml || "<span class='text-muted'>No Personal History Found</span>"
                );

                /* ================= MEDICAL HISTORY ================= */
                var medicalHtml = "";

                if (result.jsonMedical && result.jsonMedical.length > 0) {
                    medicalHtml += "<ul>";
                    for (var i = 0; i < result.jsonMedical.length; i++) {

                        var dur = result.jsonMedical[i].DURATION != "0"
                            ? " since " + result.jsonMedical[i].DURATION + " " +
                              gDurTypeHis[result.jsonMedical[i].DURTYPE] + "(s)"
                            : "";

                        medicalHtml += "<li><b>" +
                            result.jsonMedical[i].NAME +
                            "</b>" + dur + "</li>";
                    }
                    medicalHtml += "</ul>";
                }

                if (result.jsonFreeMedical && result.jsonFreeMedical.length > 0) {
                    medicalHtml += "<ul>";
                    for (var i = 0; i < result.jsonFreeMedical.length; i++) {
                        medicalHtml += "<li>" + result.jsonFreeMedical[i].MEDHIST + "</li>";
                        //medicalHtml +=
                        //    "<div class='mt-2 p-2 border rounded bg-light d-none'>" +
                        //    "<small class='text-muted'>" +
                        //    result.jsonFreeMedical[i].TRANDATE +
                        //    "</small><br/>" +
                        //    result.jsonFreeMedical[i].MEDHIST +
                        //    "</div>";
                    }
                    medicalHtml += "</ul>";
                }

                $("#medicalHistoryContent").html(
                    medicalHtml || "<span class='text-muted'>No Medical History Found</span>"
                );

                /* ================= ALLERGY ================= */
                var allergyHtml = "";

                if (result.jsonAllergy && result.jsonAllergy.length > 0) {
                    allergyHtml += "<ul>";
                    for (var i = 0; i < result.jsonAllergy.length; i++) {

                        var dur = result.jsonAllergy[i].DURATION != "0"
                            ? " since " + result.jsonAllergy[i].DURATION + " " +
                              gDurTypeHis[result.jsonAllergy[i].DURTYPE] + "(s)"
                            : "";

                        var rem = result.jsonAllergy[i].REMARKS
                            ? " (" + result.jsonAllergy[i].REMARKS + ")"
                            : "";

                        allergyHtml += "<li>Allergy - <b>" +
                            result.jsonAllergy[i].NAME +
                            "</b>" + dur + rem + "</li>";
                    }
                    allergyHtml += "</ul>";
                }

                $("#allergyContent").html(
                    allergyHtml || "<span class='text-muted'>No Allergy Found</span>"
                );
            },
            complete: function () {

            },
            error: function () {

            }
        });
    }
//Added By Roshan Surgical History 20/2/2026
function modifySurgicalHistory() {
    //debugger;
    HistoryPopupOpen("Surgical History", "SurgicalHistory", true);
}
function getSurgicalHistoryContent() {
    //debugger;
    startLoading('Loading');
    let result = "";
    $.ajax({
        type: 'POST',
        datatype: 'json',
        url: '../SinglePage/SurgicalHistory',
        async: false,
        success: function (response) {
            result = response;
        },
        error: function (xhr, status, error) {
            ToastMsg("Error loading Allergy History", "error");
        },
        complete: function () {
            stopLoading();
        }
    });
    return result;
}
function getSurgicalHistory() {
    var mrNo = GetSessionMRNO();
    if (!mrNo) return;

    $.ajax({
        type: "GET",
        dataType: "json",
        url: '../DoctorDesk/GetSurgicalHistoryData',
        data: { strMrNo: mrNo },
        success: function (response) {
            var surgHtml = "";
            if (response && response.length > 0) {
                surgHtml += "<ul>";
                for (var i = 0; i < response.length; i++) {
                    var item = response[i];
                    surgHtml += "<li>" +
                        "<b>" + item.SurgeryName + "</b>" +
                        " by " + item.SurgeonDoctorName +
                        " on " + item.SurgeryDate +
                        "</li>";
                }
                surgHtml += "</ul>";
            } else {
                surgHtml = "<span class='text-muted'>No Surgical History Found</span>";
            }
            $("#SurgicalContent").html(surgHtml);
        },
        error: function (xhr, status, error) {
            console.error("Error fetching surgical history:", error);
            $("#SurgicalContent").html("<span class='text-muted'>Error loading data</span>");
        }
    });
}
//end By Roshan
</script>
<div id="medicalhistory" class="container-fluid medical-history-wrapper">

    <%-- Header Section --%>
    <div class="d-flex justify-content-between align-items-center py-2 shadow-sm custom-med-hist-header">
        
        <div class="d-flex align-items-center flex-grow-1 p-2">
             <img src="../Images/SinglePage/medical-history.PNG" class="me-2" style="height:30px; width:auto;" alt="Medical History Icon" />
             <h2 class="text-secondary m-0 fs-5 fs-md-4 fs-lg-3">
                Medical History Report
             </h2>
        </div>

        <div class="p-2">
             <i class="fa fa-chevron-right fs-4 RightMenuBackIcon" 
                 onclick="closeRightMenu();" 
                 title="Close" 
                 aria-hidden="true"></i>
        </div>

    </div>

    <%-- Body Section --%>
    <div class="container-fluid py-2 px-0">
        
        <div class="d-flex flex-column px-1 gap-3">

           <div class="d-flex flex-column gap-1 border-bottom-secondary shadow-sm pb-2 px-1">
               <div class="gap-3" style="display:flex;">
                   <h3 class="fs-6 text-primary-custom">
                       Family History 
                   </h3>  
                   <i class="fa fa-pencil fs-4" id="editIconFamilyHistory"
                         onclick="modifyFamilyHistory();"
                         title="Edit"
                         aria-hidden="true">
                   </i>
               </div>
               <div class="mb-2" id="familyHistoryContent"></div>
           </div>

           <div class="d-flex flex-column gap-1 border-bottom-secondary shadow-sm pb-2 px-1">
               <div class="gap-3" style="display:flex;">
                   <h3 class="fs-6 text-primary-custom">Personal History </h3>
                   <i class="fa fa-pencil fs-4" id="editIconPersonalHist"
                         onclick="modifyPersonalHistory();"
                         title="Edit"
                         aria-hidden="true">
                   </i>
               </div>
               <div  id="personalHistoryContent"></div>
           </div>

            <div class="d-flex flex-column gap-1 border-bottom-secondary shadow-sm pb-2 px-1">
                <div class="gap-3" style="display:flex;">
                    <h3 class="fs-6 text-primary-custom">Medical History </h3>
                     <i class="fa fa-pencil fs-4" id="editIconMedicalHist"
                           onclick="modifyPatientMedicalHistory();"
                           title="Edit"
                           aria-hidden="true">
                     </i>
                </div>
                <div  id="medicalHistoryContent"></div>
            </div>

            <div class="d-flex flex-column gap-1 border-bottom-secondary shadow-sm pb-2 px-1">
                <div class="gap-3" style="display:flex;">
                    <h3 class="fs-6 text-primary-custom">Allergy</h3>
                    <i class="fa fa-pencil fs-4" id="editIconAllergyHist"
                            onclick="modifyAllergy();"
                            title="Edit"
                            aria-hidden="true">
                    </i>
                </div>
                <div  id="allergyContent"></div>
            </div>
 <%--Added By Roshan 20/2/2026--%>
 <div class="d-flex flex-column gap-1 border-bottom-secondary shadow-sm pb-2 px-1">
     <div class="gap-3" style="display:flex;">
         <h3 class="fs-6 text-primary-custom">Surgical History</h3>
         <i class="fa fa-pencil fs-4" id="editIconSurgicalHist"
                 onclick="modifySurgicalHistory()"
                 title="Edit"
                 aria-hidden="true">
         </i>
     </div>
     <div  id="SurgicalContent"></div>
 </div>
 <%--end Roshan--%>
        </div>

    </div>

 </div>
