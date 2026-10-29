<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.AllergyModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <html>
    <head>
        <title></title>
    </head>
    <body>

        <div id="MainDiv">

            <%--	  <a href="#test1" style="font-size:10px;">Treatment Advice</a>--%>

            <div id="ContentHolderDiv">
                <form id="frmAllergy">
                    <div id="ContainerForAllPanel">

                        <div style="width: 100%" id="currentHistory" class='panel'>
                            <div class='panel-heading divHeads' data-toggle="collapse" data-target="#currentHistoryBody" data-parent="ContainerForAllPanel">Current History</div>
                            <div class='panel-body divBody collapse indent' id="currentHistoryBody">
                                Do you have any of the following Symptoms?
                            <div style="width: 100%;" id="divGrpChekboxLst">
                                 <%-- added by vijeta on 11th July 2018--%>
                                <%=Html.Hidden("hdnTranDate")%>
                                 <%=Html.Hidden("hdnTranTime")%>
                                 <%=Html.Hidden("hdnDoctName")%>
                                <div class="divCheckboxList">
                                    RESPIRATORY TRACT
                                <table id="tblRespiratory">
                                    <%for (int i = 0; i < Model.RespiratorySymptoms.Count; i++)
                                      { %>
                                    <tr>
                                        <td>
                                            <%=Html.HiddenFor(x => x.RespiratorySymptoms[i].Name)%>
                                            <%var id = Model.RespiratorySymptoms[i].Name + "_" + i;%>
                                            <%=Html.CheckBoxFor(x => x.RespiratorySymptoms[i].Checked, new { @id=id})%> 
                                        </td>
                                        <td><%=Model.RespiratorySymptoms[i].Name%></td>
                                    </tr>
                                    <%} %>
                                </table>
                                </div>
                                <div class="divCheckboxList">
                                    EYES
                            <table style="width: 100%" id="tblEyes">

                                <%for (int i = 0; i < Model.EyesSymptoms.Count; i++)
                                  { %>
                                <tr>
                                    <td>
                                        <%=Html.HiddenFor(x => x.EyesSymptoms[i].Name)%>
                                        <%=Html.CheckBoxFor(x => x.EyesSymptoms[i].Checked)%> 
                                    </td>
                                    <td><%=Model.EyesSymptoms[i].Name%></td>
                                </tr>
                                <%} %>
                            </table>
                                </div>
                                <div class="divCheckboxList">
                                    SKIN
                            <table style="width: 100%" id="tblSkin">

                                <%for (int i = 0; i < Model.SkinSymptoms.Count; i++)
                                  { %>
                                <tr>
                                    <td>
                                        <%=Html.HiddenFor(x => x.SkinSymptoms[i].Name)%>
                                        <%=Html.CheckBoxFor(x => x.SkinSymptoms[i].Checked)%> 
                                    </td>
                                    <td><%=Model.SkinSymptoms[i].Name%></td>
                                </tr>
                                <%} %>
                            </table>
                                </div>
                                <div class="divCheckboxList">
                                    GASTROINTESTINAL
                            <table style="width: 100%" id="tblGastroIntestinal">

                                <%for (int i = 0; i < Model.GastroIntestinalSymptoms.Count; i++)
                                  { %>
                                <tr>
                                    <td>
                                        <%=Html.HiddenFor(x => x.GastroIntestinalSymptoms[i].Name)%>
                                        <%=Html.CheckBoxFor(x => x.GastroIntestinalSymptoms[i].Checked)%> 
                                    </td>
                                    <td><%=Model.GastroIntestinalSymptoms[i].Name%></td>
                                </tr>
                                <%} %>
                            </table>
                                </div>
                            </div>
                                <hr />
                                <div style="width: 100%; height: 34px;">
                                    When do you suffer from allergic symptoms?
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <%=Html.RadioButtonFor(x => Model.AllergicPeriod, "S", new { @id = "radioSeasonal", @checked = "checked" })%>Seasonal                                                                                     
                                          <%--  <input type="radio" id="radioSeasonal" name="radioAllergicPeriod" value="S"/>Seasonal</td>--%>
                                        </td>
                                        <td>
                                            <%--<input type="radio" id="radioPerennial" name="radioAllergicPeriod" value="P"/>Perennial</td>--%>
                                            <%=Html.RadioButtonFor(x => Model.AllergicPeriod, "P", new { @id = "radioPerennial" })%>Perennial 
                                        </td>
                                        <td>
                                            <%-- <input type="radio" id="radioAllergicPeriodBoth" name="radioAllergicPeriod" value="B"/>Perennial with Seasonal Exacerbations--%>
                                            <%=Html.RadioButtonFor(x => Model.AllergicPeriod, "B", new { @id = "radioAllergicPeriodBoth" })%>Perennial with Seasonal Exacerbations 
                                        </td>
                                    </tr>
                                </table>

                                </div>
                                <hr />
                                <div style="width: 100%; height: 60px;">
                                    During which months do you get symptoms repeatedly?
                              
                                <table style="width: 100%;" id="tblMonths">
                                    <tr>
                                        <%for (int i = 0; i < 6; i++)
                                          { %>
                                        <td><%=Html.HiddenFor(x => x.SymptomsMonths[i].Name)%>
                                            <%=Html.CheckBoxFor(x => x.SymptomsMonths[i].Checked)%>
                                            <%=Model.SymptomsMonths[i].Name%></td>
                                        <%} %>
                                    </tr>
                                    <tr>
                                        <%for (int i = 6; i < 12; i++)
                                          { %>
                                        <td><%=Html.HiddenFor(x => x.SymptomsMonths[i].Name)%>
                                            <%=Html.CheckBoxFor(x => x.SymptomsMonths[i].Checked)%>
                                            <%=Model.SymptomsMonths[i].Name%></td>
                                        <%} %>
                                    </tr>
                                </table>

                                </div>
                                <hr />
                                <div style="width: 100%; height: 34px;">
                                    How long do your symptoms last
                                <table style="width: 100%;">
                                    <tr>
                                        <td>More than 4 days per week:  <%=Html.RadioButtonFor(x => Model.MoreThan4daysYN, "Y", new { @id = "radioMoreThan4DaysY" })%>Yes <%=Html.RadioButtonFor(x => Model.MoreThan4daysYN, "N", new { @id = "radioMoreThan4DaysN", @checked = "checked" })%>
                                        No                                           
                                        <td>More than 4 weeks as Stretch:  <%=Html.RadioButtonFor(x => Model.MoreThan4WeeksYN, "Y", new { @id = "radioMoreThan4Weeks" })%>Yes <%=Html.RadioButtonFor(x => Model.MoreThan4WeeksYN, "N", new { @id = "radioMoreThan4WeeksN", @checked = "checked" })%>No
                                            <%--More than 4 weeks as Stretch: <input type="radio" id="radioMoreThan4WeeksY" value="Y" name="radioMoreThan4Weeks"/>Yes <input type="radio" id="radioMoreThan4WeeksN" value="N" name="radioMoreThan4Weeks"/>No</td>--%>
                                    </tr>
                                </table>

                                </div>
                                <hr />
                                <div style="width: 100%; height: 34px;">
                                    Do your symptoms affects your day-day activities?
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <%=Html.RadioButtonFor(x => Model.SymptomsAffectActivities, "N", new { @id = "radioSymptomsAffectActivitiesN", @checked = "checked" })%>No
                                          <%-- <input type="radio" name="radioSymptomsAffectActivities" id="radioSymptomsAffectActivitiesN"/>No--%></td>
                                        <td>
                                            <%=Html.RadioButtonFor(x => Model.SymptomsAffectActivities, "L", new { @id = "radioSymptomsAffectActivitiesL" })%>A little
                                             <%--<input type="radio" name="radioSymptomsAffectActivities" id="radioSymptomsAffectActivitiesL"/>A little--%></td>
                                        <td>
                                            <%=Html.RadioButtonFor(x => Model.SymptomsAffectActivities, "M", new { @id = "radioSymptomsAffectActivitiesM" })%>Moderately
                                            <%-- <input type="radio" name="radioSymptomsAffectActivities" id="radioSymptomsAffectActivitiesM"/>Moderately--%></td>
                                        <td>
                                            <%=Html.RadioButtonFor(x => Model.SymptomsAffectActivities, "P", new { @id = "radioSymptomsAffectActivitiesP" })%>Prevents Normal Activities
                                            <%-- <input type="radio" name="radioSymptomsAffectActivities" id="radioSymptomsAffectActivitiesP" />Prevents Normal Activities--%></td>
                                    </tr>
                                </table>

                                </div>
                                <hr />
                                <div style="width: 100%; height: 34px;">

                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width:40%">Do your symptoms disturb your sleep?</td>

                                            <td>
                                                <%=Html.RadioButtonFor(x => Model.DisturbSleepYN, "Y", new { @id = "radioDisturbSleepY" })%>Yes <%=Html.RadioButtonFor(x => Model.DisturbSleepYN, "N", new { @id = "radioDisturbSleepN", @checked = "checked" })%>No
                                              <%--<input type="radio" id="radioDisturbSleepY" name="radioDisturbSleep" value="Y"/>Yes </td><td><input type="radio" id="radioDisturbSleepN" name="radioDisturbSleep" value="N"/>No--%></td>

                                        </tr>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div id="presiptating" class='panel'>
                            <div class='panel-heading divHeads' data-toggle="collapse" data-target="#presiptatingBody" data-parent="#ContainerForAllPanel">Presipitating Factors/Triggers</div>
                            <div class='panel-body divBody collapse indent' id="presiptatingBody">
                                <div style="width: 100%;">
                                    Are your symptoms worse in the following locations
                                <table style="width: 100%;" id="tblLocations">
                                    <tr>
                                        <%for (int i = 0; i < 4; i++)
                                          { %>
                                        <td>
                                            <%=Html.HiddenFor(x => x.WorseInLocations[i].Name)%>
                                            <%=Html.CheckBoxFor(x => x.WorseInLocations[i].Checked)%>
                                            <%=Model.WorseInLocations[i].Name%> 
                                        </td>
                                        <%} %>
                                    </tr>
                                    <tr>

                                        <%for (int i = 4; i < Model.WorseInLocations.Count; i++)
                                          { %>
                                        <td>
                                            <%=Html.HiddenFor(x => x.WorseInLocations[i].Name)%>
                                            <%=Html.CheckBoxFor(x => x.WorseInLocations[i].Checked)%>
                                            <%=Model.WorseInLocations[i].Name%> 
                                        </td>
                                        <%} %>
                                    </tr>
                                </table>

                                </div>
                                <hr />
                                <div style="width: 100%;">
                                    Are your symptoms worse at the following time
                                <table style="width: 100%;" id="tblWorseAtTime">
                                    <tr>
                                        <%for (int i = 0; i < Model.WorseAtTime.Count; i++)
                                          { %>
                                        <td>
                                            <%=Html.HiddenFor(x => x.WorseAtTime[i].Name)%>
                                            <%=Html.CheckBoxFor(x => x.WorseAtTime[i].Checked)%>
                                            <%=Model.WorseAtTime[i].Name%> 
                                        </td>
                                        <%} %>
                                    </tr>
                                </table>

                                </div>
                                <hr />
                                <div style="width: 100%;" id="tblTriggers">
                                    <div>Are your symptoms worsened by any of the following triggers?</div>
                            <div style="width: 29%; float: left">

                                <table style="width: 100%" >

                                    <%for (int i = 0; i < 4; i++)
                                      { %>
                                    <tr>
                                        <td>
                                            <%=Html.HiddenFor(x => x.WorsenedByTriggers[i].Name)%>
                                            <%=Html.CheckBoxFor(x => x.WorsenedByTriggers[i].Checked)%> 
                                        </td>
                                        <td><%=Model.WorsenedByTriggers[i].Name%></td>
                                    </tr>
                                    <%} %>
                                </table>
                            </div>
                                    <div style="width: 37%; float: left">

                                        <table style="width: 100%">

                                            <%for (int i = 4; i < 7; i++)
                                              { %>
                                            <tr>
                                                <td>
                                                    <%=Html.HiddenFor(x => x.WorsenedByTriggers[i].Name)%>
                                                    <%=Html.CheckBoxFor(x => x.WorsenedByTriggers[i].Checked)%> 
                                                </td>
                                                <td><%=Model.WorsenedByTriggers[i].Name%></td>
                                            </tr>
                                            <%} %>
                                        </table>
                                    </div>
                                    <div style="width: 34%; float: left">

                                        <table style="width: 100%">

                                            <%for (int i = 7; i < Model.WorsenedByTriggers.Count; i++)
                                              { %>
                                            <tr>
                                                <td>
                                                    <%=Html.HiddenFor(x => x.WorsenedByTriggers[i].Name)%>
                                                    <%=Html.CheckBoxFor(x => x.WorsenedByTriggers[i].Checked)%> 
                                                </td>
                                                <td><%=Model.WorsenedByTriggers[i].Name%></td>
                                            </tr>
                                            <%} %>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="pastHistory" class='panel'>
                            <div class='panel-heading divHeads' data-toggle="collapse" data-target="#pastHistoryBody" data-parent="#ContainerForAllPanel">Past History</div>
                            <div class='panel-body divBody collapse indent' id="pastHistoryBody">
                                <div style="width: 100%;">
                                    Have you been Hospitalized or had a severe(anaphylactic) reaction beacouse of your allergy/allergies?
                                 <%=Html.RadioButtonFor(x => Model.BeforeHospitalizedYN, "Y", new { @id = "raioHospitalisedY" })%>Yes 
                                  <%=Html.RadioButtonFor(x => Model.BeforeHospitalizedYN, "N", new { @id = "raioHospitalisedN", @checked = "checked" })%>No
                                  
                                </div>
                                <hr />
                                <div style="width: 100%;">
                                    Have you ever been skin tested or had a blood test for allergies?
                                 <%=Html.RadioButtonFor(x => Model.PastTestHistoryYN, "Y", new { @id = "radioPastTestHisYes" })%>Yes 
                                 <%=Html.RadioButtonFor(x => Model.PastTestHistoryYN, "N", new { @id = "radioPastTestHisNo", @checked = "checked" })%>No                                  
                                    <div id="pastHstorySubDiv" style="display: none">
                                        <table style="width: 100%" id="tblPastHistTest">
                                            <tr>
                                                <td style="width: 40%">Test Date: </td>
                                                <td>
                                                    <%=Html.TextBoxFor(x => Model.TestDate, new { @id = "txtTestDate", @readonly = "readonly" })%></td>
                                            </tr>
                                            <tr>
                                                <td>To which allergies did you test positive: </td>
                                                <td>
                                                    <%=Html.TextBoxFor(x => Model.PositiveTests, new { @id = "txtPositiveTest", style = "width:100%" })%></td>
                                            </tr>
                                        </table>

                                    </div>

                                </div>
                                <hr />
                                <div style="width: 100%;">
                                    Have you received allergen immunotherapy or allergy vaccine before?
                                 <%=Html.RadioButtonFor(x => Model.BeforeAllergyVaccineYN, "Y", new { @id = "radioAllergyVaccineYes" })%>Yes 
                                 <%=Html.RadioButtonFor(x => Model.BeforeAllergyVaccineYN, "N", new { @id = "radioAllergyVaccineNo", @checked = "checked" })%>No
                                  <%--<input type="radio" style="margin-left:10px" id="radioAllergyVaccineYes" name="radioAllergyVaccine" value="Y"/>Yes <input type="radio" name="radioAllergyVaccine" id="radioAllergyVaccineNo" value="N"/>No --%>
                                    <div id="pastHistSubDivVaccine" style="display: none">
                                        <table style="width: 100%" id="tblPastHistVaccine">
                                            <tr>
                                                <td style="width: 40%">Allergies: </td>
                                                <td>
                                                    <%=Html.TextBoxFor(x => x.VaccinatedAllergies, new { @id = "txtAllergies", style = "width:100%" ,@maxlength="100"})%></td>
                                            </tr>
                                            <tr>
                                                <td>Initiated Date: </td>
                                                <td>
                                                     <%=Html.TextBoxFor(x => x.VaccinatedDate, new { @id = "txtAllergyInitiatedDate", style = "width:100%", @readonly = "readonly" })%>
                                                   </td>
                                            </tr>
                                            <tr>
                                                <td>How many years: </td>
                                                <td>
                                                     <%=Html.TextBoxFor(x => x.VaccineYears, new { @id = "txtYears", style = "width:100%",@maxlength="50" })%>
                                                     </td>
                                            </tr>
                                        </table>
                                        <table style="width: 100%;">
                                            <tr>
                                                <td>Response to therapy</td>
                                                <td>
                                                   <%=Html.RadioButtonFor(x => x.ResponseToTherapy, "S", new { @id = "radioResponseToTherapyS" })%>Significant</td>
                                                <td>
                                                     <%=Html.RadioButtonFor(x => x.ResponseToTherapy, "G", new { @id = "radioResponseToTherapyGood" })%>Good</td>
                                                <td>
                                                    <%=Html.RadioButtonFor(x => x.ResponseToTherapy, "M", new { @id = "radioResponseToTherapyMild" })%>Mild</td>
                                                <td>
                                                   <%=Html.RadioButtonFor(x => x.ResponseToTherapy, "N", new { @id = "radioResponseToTherapyNone", @checked = "checked" })%>None</td>
                                            </tr>
                                        </table>
                                    </div>

                                </div>

                            </div>
                        </div>

                        <div id="familyHistory" class='panel'>
                            <div class='panel-heading divHeads' data-toggle="collapse" data-target="#familyHistoryBody" data-parent="#ContainerForAllPanel">Family History</div>
                            <div class='panel-body divBody collapse indent' id="familyHistoryBody">
                                Has any member of your family had any of the following allergies?
                            <table style="width: 100%">
                                <tr>
                                    <th></th>
                                    <th>Parents</th>
                                    <th>Siblings</th>
                                    <th>Children</th>
                                </tr>
                                <tr>
                                    <th>Asthma</th>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxParentAsthmaYN, new { @id = "chkBxParentsAsthma" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxSiblingAsthmaYN, new { @id = "chkBxSiblingAsthma" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxChildrenAsthmaYN, new { @id = "chkBxChildrenAsthma" })%></td>
                                </tr>
                                <tr>
                                    <th>Allergic Rhinitis</th>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxParentAllergicRhinitisYN, new { @id = "chkBxParentsAllergicRhinitis" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxSiblingAllergicRhinitisYN, new { @id = "chkBxSiblingAllergicRhinitis" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxChildrenAllergicRhinitisYN, new { @id = "chkBxChildrenAllergicRhinitis" })%></td>
                                </tr>
                                <tr>
                                    <th>Skin Allergy</th>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxParentSkinAllergyYN, new { @id = "chkBxParentSkinAllergy" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxSiblingSkinAllergyYN, new { @id = "chkBxSiblingSkinAllergy" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxChildrenSkinAllergyYN, new { @id = "chkBxChildrenSkinAllergy" })%></td>
                                </tr>
                                <tr>
                                    <th>Food Allergy</th>
                                    <td><%=Html.CheckBoxFor(x => x.CheckBoxParentFoodAllergyYN, new { @id = "chkBxParentsFoodAllergy" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxSiblingFoodAllergyYN, new { @id = "chkBxSiblingFoodAllergy" })%></td>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxChildenFoodAllergyYN, new { @id = "chkBxFoodAllergy" })%></td>
                                </tr>
                            </table>
                                <hr />
                                <table style="width: 100%" id="tblFamilyHist">
                                    <tr>
                                        <td>Number Of siblings</td>
                                        <td><%=Html.TextBoxFor(x => Model.NoOfSiblings, new { @id = "txtNoOfSiblings", onkeypress = "return isNumberKey(event)", @maxlength = "2",@style="width:95px;" })%></td>
                                        <td>Number Of Children</td>
                                        <td><%=Html.TextBoxFor(x => Model.NoOfChildren, new { @id = "txtNoOfChildren", onkeypress = "return isNumberKey(event)", @maxlength = "2" ,@style="width:95px;" })%></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <div id="medicationHistory" class='panel'>
                            <div class='panel-heading divHeads' data-toggle="collapse" data-target="#medicationHistoryBody" data-parent="#ContainerForAllPanel">Medication History</div>
                            <div class='panel-body divBody collapse indent' id="medicationHistoryBody">
                                What medication have you used to treat your allergy and/or asthma?
                            <table style="width: 98%" id="tblMedicationHis">
                                <tr>
                                    <th>Type</th>
                                    <th>Route</th>
                                    <th>Frequency</th>
                                </tr>
                                <tr>
                                    <th>H1 Anti</th>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxH1AntiOral, new { @id = "chkBxh1AntiOral" })%>Oral<%=Html.CheckBoxFor(x => Model.CheckBoxH1AntiNasal, new { @id = "chkBxh1AntiNasal" })%>Nasal<p></p>
                                        <%=Html.CheckBoxFor(x => Model.CheckBoxH1AntiOpthaimic, new { @id = "chkBxh1AntiOpthaimic" })%>Opthaimic</td>
                                    <td><%=Html.TextBoxFor(x => Model.H1AntiFrequency, new { @id="txtH1AntiFrequency", @maxlength="20",@style="width:105px;"})%></td>
                                </tr>
                                <tr>
                                    <th>Allergic Rhinitis</th>
                                    <td><%=Html.CheckBoxFor(x => Model.CheckBoxAllergicRhinitisOral, new { @id = "chkBxAllergicRhinitisOral" })%>Oral<%=Html.CheckBoxFor(x => Model.CheckBoxAllergicRhinitisNasal, new { @id = "chkBxAllergicRhinitisNasal" })%>Nasal<p></p>
                                        <%=Html.CheckBoxFor(x => Model.CheckBoxAllergicRhinitisInhaled, new { @id = "chkBxAllergicRhinitisInhaled" })%>Inhaled<%=Html.CheckBoxFor(x => Model.CheckBoxAllergicRhinitisTopical, new { @id = "chkBxAllergicRhinitisTopical" })%>Topical</td>
                                    <td><%=Html.TextBoxFor(x => Model.AllergicRhinitisFrequency, new { @id="txtAllergicRhinitisFrequency", @maxlength="20",@style="width:105px;"})%></td>
                                </tr>
                                <tr>
                                    <th>B2,agonists</th>
                                    <td><%=Html.TextBoxFor(x => Model.B2AgonistsRoute, new { @id="txtB2AgnosistsRoute", @maxlength="20", @style="width:105px;"})%></td>
                                    <td><%=Html.TextBoxFor(x => Model.B2AgonistsFrequency, new { @id="txtB2AgnosistsFrequency", @maxlength="20",@style="width:105px;"})%></td>
                                </tr>
                                <tr>
                                    <th>Other(plz specify)</th>
                                    <td><%=Html.TextBoxFor(x => Model.OtherRoute, new { @id="txtOtherRoute", @maxlength="50",@style="width:105px;"})%></td>
                                    <td><%=Html.TextBoxFor(x => Model.OtherFrequency, new { @id="txtOtherFrequency", @maxlength="50",@style="width:105px;"})%></td>
                                </tr>
                            </table>

                            </div>
                        </div>

                        <div id="smokingHistory" class='panel' data-toggle="collapse" data-target="#smokingHistoryBody" data-parent="#ContainerForAllPanel">
                            <div class='panel-heading divHeads'>Smoking History</div>
                            <div class='panel-body divBody collapse indent' id="smokingHistoryBody">
                                Are you a smoker?
                            <table style="width: 100%">
                                <tr>
                                    <td><%=Html.RadioButtonFor(x => Model.SmokerYN, "Y", new { @id = "smokerYes" })%>Yes</td>
                                    <td><%=Html.RadioButtonFor(x => Model.SmokerYN, "N", new { @id = "smokerNo", @checked = "checked" })%>No</td>
                                    <td><%=Html.RadioButtonFor(x => Model.SmokerYN, "P", new { @id = "smokerPast" })%>Past Smoker</td>
                                </tr>
                            </table>
                            </div>
                        </div>

                    </div>
                      <div id="divPrint" style="text-align:center;margin-top:4px">
                        <input type="button" id="btnPrintAllergy" value="Print" class="btnPrintCls" style="display:none" /><%--display:noneadded by vijeta on 13th july 2018--%>
                    </div>
                    <%-- <div>
                        <label id="btnPrintAllergy1" style="background-color: transparent; float: right; margin-right: 65px; border-color: transparent;" title="Print">
                            <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 55px; background-color: white; border-radius: 50%; position: fixed;">
                        </label>
                    </div>--%>
                    <div>
                        <label id="btnSaveAllergy" style="background-color: transparent; float: right; margin-right: 65px; border-color: transparent;" title="Save">
                            <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                        </label>
                    </div>
                </form>
            </div>
            <div id="mydiv"></div>
        </div>
    </body>
    </html>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style>
        .panel-body {
            width: auto !important;
            height: auto !important;
        }

        .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 14px;
            text-align: center;
            font-weight: bold;
        }

        .divBody {
            padding: 15px;
            background-color: white; /*rgba(128, 128, 128, 0.15);*/
            font-size: 13px;
            color: black;
            white-space: 2px;
        }

        .divCheckboxList {
            float: left;
            width: 25%;
        }

        .input-form-control {
            height: 24px !important;
        }

        .input-form-addon {
            padding: 5px 12px !important;
            font-size: 11px !important;
        }

        .input-form-label {
            padding-left: 40px !important;
            font-size: 13px !important;
        }

        Label {
            margin-left: 5px;
        }

        .input-group-addon {
            width: 50px;
        }

        #tblPastHistTest, #tblPastHistVaccine, #tblFamilyHist {
            border-collapse: separate;
        }

            #tblPastHistTest td, #tblPastHistVaccine td, #tblFamilyHist td {
                padding: 4px;
            }

        #tblMedicationHis th, #tblMedicationHis td {
            border-collapse: collapse;
            border: 1px solid black;
              padding:4px;
        }

        #tblMedicationHis th {
            text-align: center;
        }

        hr {
            border-top: 1px solid black;
        }

        #divGrpChekboxLst {
            height: 260px;
        }

        @media only screen and (min-width : 992px) {

            #divGrpChekboxLst {
                height: 160px;
            }
        }

        @media only screen and (min-width: 1024px) {
            #divGrpChekboxLst {
                height: 160px;
            }

            .content {
                width: 80%;
            }
        }

        @media only screen and (min-width: 1366px) {
            #divGrpChekboxLst {
                height: 160px;
            }
        }

        @media only screen and (min-width:1400px) {
            #divGrpChekboxLst {
                height: 160px;
            }
        }

        #btnPrintAllergy{
            width: 73px;
            height: 30px;
            font-size: 17px;
            border-radius: 8px 8px 8px 8px;
            background-color: #398ebd;
            color: white;
        }
    </style>

    <script src="../Scripts/PatList.js"></script>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic", "Account")%>";
        var prntMode="<%:ViewBag.PrintMode%>";
        AddClinics(urls);
        $(document).ready(function (e) {
            HoldOn.open();//
            SetPatientDtl();
            SetDataForAllergy();
            $("#txtTestDate").datepicker(
                       {
                           showButtonPanel: true,
                           changeMonth: true,
                           yearRange: "c-150:c+99",
                           changeYear: true,
                           dateFormat: "dd/mm/yy",
                           maxDate: new Date(),
                          
                       });
            $("#txtAllergyInitiatedDate").datepicker(
                       {
                           showButtonPanel: true,
                           changeMonth: true,
                           yearRange: "c-150:c+99",
                           changeYear: true,
                           dateFormat: "dd/mm/yy",
                           maxDate: new Date(),

                       });
            

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
                $("#slide_sdList").hide();

                //$("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018


            }




            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys

            //$("#txtNoOfSiblings").keyup(function (e) {
            //    var value=$("#txtNoOfSiblings").val();
            //    var reg = /^\d+$/;
            //    if (!reg.test(value))
            //        e.preventDefault();
            //});
            $("input[name='PastTestHistoryYN']").click(function () {
                if ($(this).val() == "Y")
                    $("#pastHstorySubDiv").show();
                else if ($(this).val() == "N") {
                    $("#pastHstorySubDiv").hide();
                    $("#txtTestDate").val("");
                    $("#txtPositiveTest").val("");
                }
            });

            $("input[name='BeforeAllergyVaccineYN']").click(function () {
                if ($(this).val() == "Y")
                    $("#pastHistSubDivVaccine").show();
                else if ($(this).val() == "N") {
                    $("#pastHistSubDivVaccine").hide();
                    $("#txtAllergies").val("");
                    $("#txtAllergyInitiatedDate").val("");
                    $("#txtYears").val("");
                    $("#radioResponseToTherapyNone").prop("checked", "checked");
                }
            });

            $("#btnSaveAllergy").click(function () {
                //alert('hi');
                HoldOn.open();
                var serializeddata = $("#frmAllergy").serialize();
                var mrNo = ($.session.get('PatMRNO'));
                var tranNo = ($.session.get('PatTRANNO'));
                var doctName = "<%:Session["gDoctName"]%>";//added on 11th July2018
                $.ajax({
                    url: '../DoctorDesk/SaveAllergyQuestionnair',
                    data: serializeddata + "&mrNo=" + mrNo + "&tranNo=" + tranNo + "&doctName=" + doctName,
                    datatype: 'json',
                    type: 'post',
                    success: function (response) {
                        if (response != "") {
                            $.messager.alert("Information", response);
                        }
                        if (response.indexOf("success") != -1) //added on 13th July 2018
                            SetDataForAllergy();
                    },
                    complete: function () {
                        HoldOn.close();//
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//

                });
            });

           
           

            $("#btnPrintAllergy").click(function () {              
                var $data = $('#ContainerForAllPanel').clone();
                var tranDt = $("#hdnTranDate").val();
                var tranTm = $("#hdnTranTime").val();
                var doctName = $("#hdnDoctName").val();
                PrintAllergyQuestionair(tranDt, tranTm, doctName);
            });

        });


        function PrintAllergyQuestionair(tranDt, tranTm, doctName) {
             //if (prntMode == "Y") {

             var strTranNo = $.session.get('PatTRANNO');
             var strMrNo = $.session.get('PatMRNO');
                var patName=$.session.get('PatName');
                var patAge=$.session.get('PatAge');
                var patGender=$.session.get('PatGender');
                var patMob=$.session.get('PatMobile');
                var patAge2=$.session.get('PatAge2');
                var clinicname = $.session.get("ClinicName");
             
                var $html = $("<html></html>");
                var $head = $("<head></head>");
                var $style = $("<style></style>");
                var styleCss = ".panel-body { width: auto !important;height: auto !important;} .divHeads { color:black;background-color: #3c8dbc; border-color: #ddd; box-shadow: none; font-size: 20px;text-align: center;font-weight: bold;}.divBody {  padding: 15px;background-color: white;font-size: 18px; color: black;white-space: 2px;}.divCheckboxList { float: left;width: 25%;font-size:14px;}#tblPastHistTest, #tblPastHistVaccine, #tblFamilyHist { border-collapse: separate;} #tblPastHistTest td, #tblPastHistVaccine td, #tblFamilyHist td { padding: 4px;}#tblMedicationHis th, #tblMedicationHis td { border-collapse: collapse;border: 1px solid black;padding:4px;} #tblMedicationHis th {text-align: center;}hr{border-top: 1px solid black;} #divGrpChekboxLst { height: 180px;}#tblTriggers{height:160px;}";
                   
                $style.append(document.createTextNode(styleCss));
                var $body = $("<body></body>");

                var $heading = $("<div style='text-align:center;margin-bottom:10px;font-size:20px;font-weight:bold;><label style='font-size:20px;font-weight:bold;'>Allergy Questionnair</label></div>");
                var $patInfoDiv = $("<div></div>");
                var $patInfoTbl = $("<table style='width:100%; font-family: Verdana, Geneva, sans-serif !important;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px'>"+
                    "<tr class='inHeight'><td class='HTextsize'>Name</td><td style='width:1%'>:</td><td class='HTextsize' style='font-weight:bold;line-height:14px;'>" + patName +
                    "<td class='HTextsize' style=''>Doctor Name</td><td>:</td>" +
                    "<td class='HTextsize' style='font-weight:bold;'>Dr. " + doctName + "</td></tr><tr class='HTextsize'><td class='HTextsize'>Age/Gender</td><td >:</td><td class='HTextsize' style=''>" + patAge + ' ' + " / " + patGender + "</td>" +
                    "<td class='HTextsize' style=''>Date / Time</td><td>:</td><td class='HTextsize'>" + tranDt + " " + tranTm + " </td>" +
                    "</tr><tr class='HTextsize''><td class='HTextsize' style='padding:3px;' >MR No.</td><td>:</td><td class='HTextsize' style='padding:3px;'>" + strMrNo + "</td>" +
                    "</td><td class='HTextsize' style='width=5%;'>Consultation No.</td><td class='HTextsize' style='width:1%'>:</td>"+
                    "<td width='35%' class='HTextsize'>" + strTranNo + "<td></tr>" +
                    "<tr><td>Clinic Name</td><td>:</td><td>" + clinicname + "</td></tr>" +
                    "</table>");
                  
                $patInfoDiv.append($patInfoTbl);
                var $data = $('#ContainerForAllPanel').clone();
                $html.append($head);
                $head.append($style);
                $html.append($body);

                $body.append($heading);
                $body.append($patInfoDiv);
                $body.append($data);
                openWin($html);
            }
           // else {
           // }
           // }

        function openWin(Html) {
            var myWindow = window.open('', '', '"<%=Server.MapPath("~/")%>"');
            //myWindow.document.write(Html);
            $(myWindow.document.body).html(Html);
             myWindow.document.close();
             myWindow.focus();
             setTimeout(function () {
                 myWindow.print();
                 myWindow.close();
             }, 100);
         }

        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './Allergy');

                $(window).on('popstate', function () {
                    SaveVitals();
                });

            }
        });


        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode != 46 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function SetDataForAllergy()
        {
            var strMrNo=$.session.get('PatMRNO');
            var strTranNo = $.session.get('PatTRANNO');
            var trnDt = "";
            var trntm = "";
            $.ajax({
                url: '../DoctorDesk/GetAllergies',
                data: { strMrNo: strMrNo, strTranNo: strTranNo },
                datatype:'json',
                success: function (response) {
                    if (response != "") {//added on13th july 2018
                        $("#btnPrintAllergy").show();//added on 13th July 2018
                        //Respiratory tract
                        var strRespirotorySymp = response[0].RESPIRATORYSYMPTOMS;
                        var arryRespiratorySymptoms = strRespirotorySymp.split(",");
                        if (arryRespiratorySymptoms.length > 0) {
                            $.each(arryRespiratorySymptoms, function (index, value) {
                                $("#tblRespiratory td:contains(" + value + ")").prev().children()[1].checked = true;
                            });
                        }

                        //Eyes
                        var strEyesSymp = response[0].EYESSYMPTOMS;
                        var arryEyesSymptoms = strEyesSymp.split(",");
                        if (arryEyesSymptoms.length > 0) {
                            $.each(arryEyesSymptoms, function (index, value) {
                                $("#tblEyes td:contains(" + value + ")").prev().children()[1].checked = true;
                            });
                        }

                        //Skin
                        var strSkinSymp = response[0].SKINSYMPTOMS;
                        var arrySkinSymptoms = strSkinSymp.split(",");
                        if (arrySkinSymptoms.length > 0) {
                            $.each(arrySkinSymptoms, function (index, value) {
                                $("#tblSkin td:contains(" + value + ")").prev().children()[1].checked = true;
                            });
                        }

                        //GastroIntenstinal
                        var strgastroIntestinalSymp = response[0].GASTROINTESTINALSYMPTOMS;
                        var arryGastroSymptoms = strgastroIntestinalSymp.split(",");
                        if (arryGastroSymptoms.length > 0) {
                            $.each(arryGastroSymptoms, function (index, value) {
                                $("#tblGastroIntestinal td:contains(" + value + ")").prev().children()[1].checked = true;
                            });
                        }

                        //when do u suffer frm allergic symptoms
                        if (response[0].ALLERGICSYMPTOMSYN == "S")
                            $("#radioSeasonal").prop("checked", "checked");
                        else if (response[0].ALLERGICSYMPTOMSYN == "P")
                            $("#radioPerennial").prop("checked", "checked");
                        else if (response[0].ALLERGICSYMPTOMSYN == "B")
                            $("#radioAllergicPeriodBoth").prop("checked", "checked");

                        // in which months do u get symptoms repeatedly
                        var strMonths = response[0].SYMPTOMSMONTHS;
                        var arryMonths = strMonths.split(",");
                        if (arryMonths.length > 0) {
                            $.each(arryMonths, function (index, value) {
                                $("#tblMonths td:contains(" + value + ")").children()[1].checked = true;
                            });
                        }

                        //how long do ur symptoms last
                        if (response[0].FOURDAYSPERWEEKYN == "Y") // more than four days per week
                            $("#radioMoreThan4DaysY").prop("checked", "checked");
                        else
                            $("#radioMoreThan4DaysN").prop("checked", "checked");


                        if (response[0].FOURWEEKSSTRETCHYN == "Y") // more than four weeks yes/no
                            $("#radioMoreThan4Weeks").prop("checked", "checked");
                        else
                            $("#radioMoreThan4WeeksN").prop("checked", "checked");

                        //do ur symptoms affect day to day activities
                        if (response[0].SYMPTOMSAFFECTYN == "N")
                            $("#radioSymptomsAffectActivitiesN").prop("checked", "checked");
                        else if (response[0].SYMPTOMSAFFECTYN == "L")
                            $("#radioSymptomsAffectActivitiesL").prop("checked", "checked");
                        else if (response[0].SYMPTOMSAFFECTYN == "M")
                            $("#radioSymptomsAffectActivitiesM").prop("checked", "checked");
                        else if (response[0].SYMPTOMSAFFECTYN == "P")
                            $("#radioSymptomsAffectActivitiesP").prop("checked", "checked");

                        //Do ur symptoms disturb ur sleep
                        if (response[0].DISTURBSLEEPYN == "Y")
                            $("#radioDisturbSleepY").prop("checked", "checked");
                        else
                            $("#radioDisturbSleepN").prop("checked", "checked");

                        //are ur symptoms worse in the following locations
                        var strlocations = response[0].WORSEINLOCATION;
                        var arryLocations = strlocations.split(",");
                        if (arryLocations.length > 0) {
                            $.each(arryLocations, function (index, value) {
                                $("#tblLocations td:contains(" + value + ")").children()[1].checked = true;
                            });
                        }

                        //are ur symptoms worse at the following time
                        var strTimes = response[0].WORSEATTIME;
                        var arryTimes = strTimes.split(",");
                        if (arryTimes.length > 0) {
                            $.each(arryTimes, function (index, value) {
                                $("#tblWorseAtTime td:contains(" + value + ")").children()[1].checked = true;
                            });
                        }

                        //are ur symptoms worsenedby following triggers
                        var strTriggers = response[0].WORSENEDBYTRIGGERS;
                        var arryTriggers = strTriggers.split(",");
                        if (arryTriggers.length > 0) {
                            $.each(arryTriggers, function (index, value) {
                                //$("#tblTriggers td:contains(" + value + ")").children()[1].checked = true;
                                $("#tblTriggers td:contains(" + value + ")").prev().children()[1].checked = true;
                            });
                        }

                        // have u been hospitalized
                        if (response[0].HOSPITALIZDBCZOFALLERGY == "Y")
                            $("#raioHospitalisedY").prop("checked", "checked");
                        else
                            $("#raioHospitalisedN").prop("checked", "checked");

                        //have u ever been skin tested
                        if (response[0].BLOODTEST == "Y") {
                            $("#radioPastTestHisYes").prop("checked", "checked");
                            $("#pastHstorySubDiv").show();
                        }
                        else {
                            $("#radioPastTestHisNo").prop("checked", "checked");
                            $("#pastHstorySubDiv").hide();
                        }

                        //have u received allergn immunothrapy
                        if (response[0].ALLERGYVACCINEBEFORE == "Y") {
                            $("#radioAllergyVaccineYes").prop("checked", "checked");
                            $("#pastHistSubDivVaccine").show();
                        }
                        else {
                            $("#radioAllergyVaccineNo").prop("checked", "checked");
                            $("#pastHistSubDivVaccine").hide();
                        }

                        //test date
                        $("#txtTestDate").val(response[0].TESTDATE);

                        //To which allergies did you test positive:
                        $("#txtPositiveTest").val(response[0].POSITIVETESTS);

                        //Vaccinated Allergies
                        $("#txtAllergies").val(response[0].VACCINATEDALLERGIES);

                        //vaccine initiated date
                        $("#txtAllergyInitiatedDate").val(response[0].VACCINEINITIATEDDATE);

                        //how many years
                        $("#txtYears").val(response[0].VACCINEYEARS);

                        //Response to therapy
                        if (response[0].RESPONSETOTHERAPY == "S")
                            $("#radioResponseToTherapyS").prop("checked", "checked");
                        else if (response[0].RESPONSETOTHERAPY == "G")
                            $("#radioResponseToTherapyGood").prop("checked", "checked");
                        else if (response[0].RESPONSETOTHERAPY == "M")
                            $("#radioResponseToTherapyMild").prop("checked", "checked");
                        else if (response[0].RESPONSETOTHERAPY == "N")
                            $("#radioResponseToTherapyNone").prop("checked", "checked");

                        if (response[0].PARENTASTHMA == "Y")
                            $("#chkBxParentsAsthma").prop("checked", "checked");
                        if (response[0].PARENTALLERGICRHINITIS == "Y")
                            $("#chkBxParentsAllergicRhinitis").prop("checked", "checked");
                        if (response[0].PARENTSKINALLERGY == "Y")
                            $("#chkBxParentSkinAllergy").prop("checked", "checked");
                        if (response[0].PARENTFOODALLERGY == "Y")
                            $("#chkBxParentsFoodAllergy").prop("checked", "checked");

                        if (response[0].SIBLINGASTHMA == "Y")
                            $("#chkBxSiblingAsthma").prop("checked", "checked");
                        if (response[0].SIBLINGALLERGICRHINITIS == "Y")
                            $("#chkBxSiblingAllergicRhinitis").prop("checked", "checked");
                        if (response[0].SIBLINGSKINALLERGY == "Y")
                            $("#chkBxSiblingSkinAllergy").prop("checked", "checked");
                        if (response[0].SIBLINGFOODALLERGY == "Y")
                            $("#chkBxSiblingFoodAllergy").prop("checked", "checked");

                        if (response[0].CHILDRENASTHMA == "Y")
                            $("#chkBxChildrenAsthma").prop("checked", "checked");
                        if (response[0].CHILDRENALLERGICRHINITIS == "Y")
                            $("#chkBxChildrenAllergicRhinitis").prop("checked", "checked");
                        if (response[0].CHILDRENSKINALLERGY == "Y")
                            $("#chkBxChildrenSkinAllergy").prop("checked", "checked");
                        if (response[0].CHILDRENFOODALLERGY == "Y")
                            $("#chkBxFoodAllergy").prop("checked", "checked");

                        $("#txtNoOfSiblings").val(response[0].NOOFSIBLINGS);
                        $("#txtNoOfChildren").val(response[0].NOOFCHILDREN);


                        if (response[0].H1ANTIORAL == "Y")
                            $("#chkBxh1AntiOral").prop("checked", "checked");
                        if (response[0].H1ANTINASAL == "Y")
                            $("#chkBxh1AntiNasal").prop("checked", "checked");
                        if (response[0].H1ANTIOPTHAIMIC == "Y")
                            $("#chkBxh1AntiOpthaimic").prop("checked", "checked");

                        if (response[0].ALLERGICRHINITISORAL == "Y")
                            $("#chkBxAllergicRhinitisOral").prop("checked", "checked");
                        if (response[0].ALLERGICRHINITISNASAL == "Y")
                            $("#chkBxAllergicRhinitisNasal").prop("checked", "checked");
                        if (response[0].ALLERGICRHINITISINHALED == "Y")
                            $("#chkBxAllergicRhinitisInhaled").prop("checked", "checked");
                        if (response[0].ALLERGICRHINITISTOPICAL == "Y")
                            $("#chkBxAllergicRhinitisTopical").prop("checked", "checked");

                        if (response[0].SMOKER == "Y")
                            $("#smokerYes").prop("checked", "checked");
                        else if (response[0].SMOKER == "N")
                            $("#smokerNo").prop("checked", "checked");
                        else if (response[0].SMOKER == "P")
                            $("#smokerPast").prop("checked", "checked");

                        $("#txtH1AntiFrequency").val(response[0].H1ANTIFREQUENCY);
                        $("#txtAllergicRhinitisFrequency").val(response[0].ALLERGICRHINITISFREQUENCY);
                        $("#txtB2AgnosistsRoute").val(response[0].B2AGONISTROUTE);
                        $("#txtB2AgnosistsFrequency").val(response[0].B2AGONISTFREQUENCY);
                        $("#txtOtherRoute").val(response[0].OTHERMEDICATIONROUTE);
                        $("#txtOtherFrequency").val(response[0].OTHERMEDICATIONFREQUENCY);

                        trnDt = response[0].TRANDT;
                        trntm = response[0].TRANTM;
                        $("#hdnTranDate").val(trnDt);
                        $("#hdnTranTime").val(trntm);
                        $("#hdnDoctName").val(response[0].DOCTNAME);
                    }
                    else {
                        $("#btnPrintAllergy").hide();//added on 13th July 2018
                    }
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
            })
        }
    </script>
</asp:Content>
