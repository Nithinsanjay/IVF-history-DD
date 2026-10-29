<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" style="text-align: center">
        <div>
            <h3>Follow Up after</h3>
        </div>
    </div>
   
    <div class="row" style="padding-bottom: 5px; text-align: center;" id="followUpDiv">
       <table>
            <tr>
                <td style="width:57%">
                      <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MarkCompleteBottomYN") == "N")
                                        { %>
                    <div style="text-align:right">
                          <%} %>
                        <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MarkCompleteBottomYN") == "Y")
                                        { %>
                    <div style="text-align:center">
                          <%} %>

            <label id="lblSOS" class="btn btn-info tempprint">
                SOS
            </label>

        <span id="spanumber" data-toggle="tooltip" title="" class="badge bg-aqua" style="width: 51px; height: 33px; padding-top: 10px">
            <a class="trigger2" href="javascript:;" data-layer-id="layer-Numbers" id="Numbers" style="font-weight:800;font-size:16px;color: white;display: inline-block;position: relative; z-index: 1;padding: 1em;margin: -2em;">0</a>
        </span>
        <input id="hdnNumber" name="hdnNumberselect" type="hidden" value="0" />

        <div id="layer-Numbers" class="po__layer list">
        </div>
        <span data-toggle="tooltip" title="" class="badge bg-aqua" data-original-title="3 New Messages" style="width: 107px; height: 33px; padding-top: 10px">
            <a class="trigger1" href="javascript:;" data-layer-id="layer-DMY" id="DaySelect" style="font-weight:800;font-size:16px;color: white;display: inline-block;position: relative; z-index: 1;padding: 1em;margin: -2em;">Days</a>
        </span>
        <input id="hdnDayselect" name="hdnDayselect" type="hidden" value="Days" />
        <div id="layer-DMY" class="po__layer list">
            <a href="javascript:;" style="text-decoration: none;font-weight:800;font-size:16px" onclick="SetText(this,'Days')">Days</a>
            <a href="javascript:;" style="text-decoration: none; font-weight:800;font-size:16px" onclick="SetText(this,'Weeks')">Weeks</a>
            <a href="javascript:; " style="text-decoration: none;font-weight:800;font-size:16px" onclick="SetText(this,'Months')">Months</a>
            <a href="javascript:;" style="text-decoration: none;font-weight:800;font-size:16px" onclick="SetText(this,'Years')">Years</a>
        </div>
                    </div>
                </td>
                  <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MarkCompleteBottomYN") == "N")
                                        { %>
                <td>
                    <div style="text-align:center" id="divMarkComplete">
                        <a class="btn btn-app" id="MarkComplete">
                            <i class="fa  fa-check-circle fa-4x" style="font-size: 50px"></i>
                        </a>
                    </div>
                </td>
                   <%} %>
            </tr>
        </table>
       
        <span><i class="fa fa-calendar-check-o fa-2x" aria-hidden="true" style="margin-left:8px;cursor:pointer;display:none;" title="Book Appointment" id="btnTakeAppointMent"></i></span>
  
        <%--Changed by Dhananjay 20241005--%>
        <div style="display: inline; align-items: center;">
    <h3 style="display: block; margin-bottom: 10px;">
        <input type="checkbox" style="height: 22px; width: 26px; vertical-align: text-bottom;" value="" id="chkAdmnAdvice"  onclick="ShowCareType()"/>
        <span>Admission Advice</span> <span><input type="text" id="txtProposeAdmnDT"  style="height:30px;border-radius:5px;font-size:13px;width:150px;"  
            placeholder="Admission Date" readonly/></span>
    </h3>

    <h3 style="display: none; margin-bottom: 10px;" id="DivLevelOfUrg">
            <span style="margin-left:25px">Level of Urgency</span>
            <select id="cmbLevelOfUrg" class="form-control" style="width: 150px;display: inline-block;margin-left:15px">
                <option value="">Select</option>
                <option value="E">Emergent</option>
                <option value="U">Urgent</option>
                <option value="L">Less urgent</option>
            </select>
    </h3>

    <h3 style="display: none; margin-bottom: 10px;" id="showTBRef">
        <input type="checkbox" style="height: 22px; width: 26px; vertical-align: text-bottom;margin-left: 36px;" value="" id="chkTBRef" />
        <span>Refer To Tumor Board</span>
    </h3>
        
     </div>

        <table id="TblCareType" style="display:none;">
            <tr>
                <td style="width: 57%">
                    <div style="text-align: center">
                        <h3 style="display: inline-block;"><span style="padding-right: 15px;">Care Type</span></h3>
                        <select id="CmbCareType" style="font-size: 14px;height: 30px;border-radius: 5px;"><option>--Select--</option></select>
                    </div>
                </td>
            </tr>
        </table>
     </div>
 
    <hr style="height:2px;border-width:0;color: grey;background-color: #fbea23;width: 100%;">
     <div class="row hide" style="text-align: center;font-size:13px;margin-top:10px;" id="appnmtDiv">
        <input type="text" id="txtAppointmntDate"  style="height:30px;border-radius:5px;"  placeholder="Appointment Date" readonly/>
        <select id="txtAppointmntTime" style="height:30px;border-radius:5px;">
            <option>--Preferred Time-</option>
        </select>
        <Label style="font-size:16px;margin-left:10px;border: 1px solid #333;
            border-radius: 16px;
            padding-left: 8px;
            padding-right: 8px;
            background: #fde7e7;" id="anchorBookAppmnt" title="Save Appointment">Book</Label>  
    </div>
    
     <%-- added by vijeta on 16th march 19--%>
     <div class="row hide" style="text-align: center; font-size: 13px; margin-top: 10px;" id="appnmtShowDiv">
        <label id="appmntStringDisplay" style="color:#337ab7;font-size:16px;"></label>
    </div>

      <div class="row hide" style="text-align: center" id="divCallDone">
        <div>
             <label style="vertical-align: text-bottom;font-size:13px;">Call Done</label>&nbsp;&nbsp;
            <input type="checkbox" id="chkCallDoneYN" style="height: 23px;width: 18px;" name="chkCall" value ="Y"/>
        </div>
    </div>

    <div id="Cancer" style="display:none">
        <div class="row" style="text-align: center">
            <div>
                <h3 style="display: inline-block;">Cancer</h3>
                <div style="display: inline-block;">
                    <div style="display: flex;align-items: center;padding-left: 20px;">
                        <input style="margin: 0;" name="CANCER" type="radio" id="RbtnCancerY" onclick="EnDisCancer()" />
                        <label style="margin: 0;padding: 0px 10px;" for="RbtnCancerY">Yes</label>
                        <input style="margin: 0;" name="CANCER" type="radio" id="RbtnCancerN"  onclick="EnDisCancer()"  />
                        <label style="margin: 0;padding: 0px 10px;" for="RbtnCancerN">No</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="text-align: center;">
            <div style="display: flex;align-items: center;justify-content: center;" id="CancerOptDiv">
                <input style="margin: 0;" name="CANCERTYPE" type="checkbox" id="RbtnCancerTypeR" />
                <label style="margin: 0;padding: 0px 10px;" for="RbtnCancerTypeR">Radiation Oncology</label>
                <input style="margin: 0;" name="CANCERTYPE" type="checkbox" id="RbtnCancerTypeM" />
                <label style="margin: 0;padding: 0px 10px;" for="RbtnCancerTypeM">Medical Oncology</label>
                <input style="margin: 0;" name="CANCERTYPE" type="checkbox" id="RbtnCancerTypeP" />
                <label style="margin: 0;padding: 0px 10px;" for="RbtnCancerTypeP">Palliative Care</label>
            </div>
        </div>
    </div>

    <div class="row" id="SurgyAdvDiv1" style="text-align: center;">
        <div>
            <h3>Surgery Advice</h3>
        </div>
    </div>
     
     <%-- added by vijeta on 13th march 19--%>
     <div class="row" id="SurgyAdvDiv2" style="text-align: center;">
        <input type="text" id="SurgeryInput" onkeyup="SearchSurgery()" placeholder="&#xF002; Search Surgery (Enter atleast 3 chars)" style="font-family: FontAwesome !important; font-size: 16px; height: 31px; margin-left: 19px; width: 70%; background-color: #fdf1f8; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
      </div>
    <div class="row" id="SurgyAdvDiv3">
        <div>
            <table id="tblSurgery" style="z-index:1000;" class="table" >
            </table>
        </div>
        <input id="hdnSurgeryCode" type="hidden" />
    </div>
    <div class="row" style="text-align: center;" id="SurgyAdvDiv4">
        <textarea class="" id="txtSurgeryAdvice" disabled rows="2" maxlength="200" style="font-size: 13px; width: 65%; margin-left: 19px;border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;"></textarea>
        <i class="fa fa-refresh" aria-hidden="true" style="font-size: 25PX;margin-top: 10PX;vertical-align: top;cursor: pointer;margin-left: 10px;" onclick="HideUnHideSurgDiv('')"></i>
    </div>
    <div class="row" id="SurgMainDiv" style="text-align: center;display:none;">
        <div style="width: 70%;place-self: anchor-center;">
            <div style="margin-bottom: 5px; display: inline-block">
                <label style="margin-right: 10px; width: 120px;">Surgery Advice Date</label>
                <input type="text" id="txtAdviceDate" style="width: 100px;" readonly>
            </div>
            <div style="margin-bottom: 5px; display: inline-block">
                <label style="margin: 0px 10px; width: 120px;">PAC Advice Date</label>
                <input type="text" id="txtPACAdviceDate" style="width: 100px;" readonly disabled>
            </div>
            <div style="margin-bottom: 5px; display: inline-block">
                <div style="display: flex; align-items: center; justify-content: center; margin-bottom: 5px;">
                    <label style="margin: 0px 10px; width: 100px;">Nature of Surgery</label>
                    <div style="display: flex; align-items: center;">
                        <input style="margin: 0;" type="radio" name="NATSURG" id="rbtnNatSurgR" />
                        <label style="margin: 0; padding: 2px 5px 0px 5px;" for="rbtnNatSurgR">Routine</label>
                    </div>
                    <div style="display: flex; align-items: center;">
                        <input style="margin: 0;" type="radio" name="NATSURG" id="rbtnNatSurgE" />
                        <label style="margin: 0; padding: 2px 5px 0px 5px;" for="rbtnNatSurgE">Emergency</label>
                    </div>
                    <div style="display: none; align-items: center;">
                        <input style="margin: 0;" type="radio" name="NATSURG" id="rbtnNatSurgT" />
                        <label style="margin: 0; padding: 2px 5px 0px 5px;" for="rbtnNatSurgT">Tentative</label>
                    </div>
                    <button id="openCalendarBtn" class="btn-calendar" title="Open Calendar">📅</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row" style="margin: 0px;justify-content: center;" id="SchemeMainDiv">
        <div style="width: 70%;">
            <label style="width: 115px;">📋 Scheme</label>
            <input type="text" id="SchemeInput" onkeyup="SearchScheme()" onclick="SearchScheme()" placeholder="&#xF002; Search Scheme.." style="font-family: FontAwesome !important; font-size: 12px; margin-left: 10px; width: 250px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
            <div class="row" style="text-align: center;">
                <div id="tblSchemeWrapper" style="display:none;">
                    <table id="tblScheme" style="z-index:1000;" class="table">
                    </table>
                </div>
            </div>
            <div class="MedicineDiv table-responsive" style="width: 100%; max-height: 150px; overflow: auto;">
                <table id="TableScheme" class="table table-bordered table-striped MedicineTbl" style="width: 100% !important;position: relative;">
                    <thead>
                        <tr>
                            <th style="width: 90px">Action</th>
                            <th>Scheme</th>
                        </tr>
                    </thead>
                    <tbody id="TableSchemeTBody"></tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="ReferToDrHosp">
        <div class="row" style="text-align: center">
            <div>
                <h3>Cross Reference to Other Oncologist
                <i id="btnAddRef" class="fa fa-plus-square" aria-hidden="true" style="display: none; cursor: pointer; color: black; margin-left: 10px; font-size: 20px;" onclick="AddRefDoctNote()"></i>
                </h3>
            </div>
        </div>
        <div class="row" style="text-align: center; display: none" id="SearchDoctDiv">
            <input type="text" id="DoctorInput" onkeyup="SearchDoctors()" placeholder="&#xF002; Search Doctor (Enter atleast 3 chars)" style="font-family: FontAwesome !important; font-size: 16px; height: 31px; margin-left: 19px; width: 70%; background-color: #fdf1f8; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
        </div>
        <div class="row" style="display: none;" id="SearchListDoctDiv">
            <div>
                <table id="tblDoctors" class="table">
                </table>
            </div>
            <input id="hdnDoctCode" type="hidden" />
        </div>
        <div class="row" style="text-align: center; display: none;" id="SelDoctDiv">
            <textarea id="DoctorShow" rows="2" maxlength="240" style="font-size: 13px; width: 70%; margin-left: 19px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty"></textarea>
        </div>
        <div class="row" style="text-align: center; display: none;align-items: center;justify-content: center;" id="NotesWiseDoctDiv">
            <div style="width: 70%;">
                <div class="DoctContNote" id="DoctContNoteDiv">
                </div>
            </div>
        </div>
    </div>

    <div class="row" style="text-align: center">
        <div>
            <h3>Refer to Specialist</h3>
        </div>
    </div>
      <%--div added by vijeta on 20th march 2018--%>
    <!--added by kavita-->
    <div class="row" style="text-align: center;">
        <input type="text" id="ClinicInput" onkeyup="SearchClinic()" placeholder="&#xF002; Search Specialist (Enter atleast 3 chars)" style="font-family: FontAwesome !important;font-size:16px;height: 31px; margin-left: 19px;background-color: #fdf1f8; width: 70%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
    </div>
    <div class="row" style="text-align: center;">
        <div>
            <table id="tblclinic" class="table" style="">
            </table>
        </div>
        <input id="hdnclinic" type="hidden" />
    </div>
    <div class="row" style="text-align: center;">
        <textarea  id="ClinicShow" rows="2" onkeyup="SearchClinic()" style="font-size: 13px; margin-left: 19px; width: 70%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" maxlength="150"> </textarea>
    </div>
   
    <div class="row" style="text-align: center">
        <div>
            <h3>Remark/Note</h3>
        </div>
    </div>
    <div class="row" style="text-align: center;">
        <textarea id="PrescriptionRemark" rows="3"  style="font-size: 13px; margin-left: 19px; width: 70%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" maxlength="800"> </textarea>
    </div>
    <div class="row" style="text-align: center">
        <div>
            <h3>Plan of Treatment</h3>
        </div>
    </div>
     <div class="row" style="text-align: center;">
        <textarea id="PlanOfTreatmnt" rows="3" maxlength ="1500" style=" font-size: 13px; margin-left: 19px; width: 70%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty"> </textarea>
    </div>
    <%----------------------------------%>
      <hr style="height:2px;border-width:0;color:gray;background-color:#ec7777;width: 100%;"> <%-- 24-04-2020--%>
     <div class="row" style="text-align: center" id="DivPrintWithHist">
        <div>
           <h3>Print Format <input type="checkbox" value="" id="chkPrintHistory" checked/><small>&nbsp;(With History)</small> </h3>
        </div>
    </div>
    <div class="row" style="height: 49px; border-color: #bce8f1; border: 1px solid transparent; text-align: center" id="TempFormat" >
        <div class="btn-group Printformat" data-toggle="buttons" style="padding-top: 6px">
            <label class="btn btn-info tempprint">
                <input type="radio" name="options" value="Temp_1" autocomplete="off">
                Temp-1
            </label>
            <label class="btn btn-info tempprint">
                <input type="radio" name="options" value="Temp_2" autocomplete="off">
                Temp-2
            </label>
            <label class="btn btn-info tempprint">
                <input type="radio" name="options" value="Temp_3" autocomplete="off">
                Temp-3
            </label>
        </div>
    </div>
     <div class="row" style="height: 30px; border-color:#bce8f1;color:#d25a05; border: 1px solid transparent;  text-align: center;font-size:18px" id="divmail">
      <label id="P_Email" ></label>
         <span id="Addpencil" style="margin-left:5px;cursor: pointer;"><img style="height:29px;width:29px;" src="../Images/pencil.png" /></span>
    </div>
    <div class="row" style="height:50px; border-color: #bce8f1; border: 1px solid transparent; text-align: center;font-size:18px;"  id="divmailicon">
          <span class="" id="anchorEemailLnk" style="cursor: pointer;">
          <img src="../Images/gmail.png" style ="height:50px;width:60px;margin-top:-5px;"/></span>
    </div>
   
    <div class="row" style="height:48px; border-color: #bce8f1; border: 1px solid transparent; text-align: center; display:none;" id="divPrescriptLang">
        <div class="btn-group Language" data-toggle="buttons" style="padding-top: 6px">
            <label class="btn btn-default borderC active">
                <input type="radio" name="language" value="NAME" autocomplete="off" checked>
                English
            </label>
            <label class="btn btn-default borderC">
                <input type="radio" name="language" value="HINDI" autocomplete="off">
                Hindi
            </label>
            <label class="btn btn-default borderC">
                <input type="radio" name="language" value="MARATHI" autocomplete="off">
                Marathi
            </label>
            <label class="btn btn-default borderC">
                <input type="radio" name="language" value="GUJRATI" autocomplete="off">
                Gujrati
            </label>
        </div>
    </div>

    <input id="hdnlanguage" name="hdnlanguage" type="hidden" value="NAME" />

     <div id="divSMSGoogRating" style="display:none">
    <hr style="height:2px;border-width:0;color:gray;background-color:#44a5ea;width: 100%;">
    <div class="row" style="text-align: center">
        <div>
            <h3>SMS For Google Rating</h3>
        </div>
    </div>
    
    <div class="row" style="height: 24px; border-color: #bce8f1; border: 1px solid transparent; text-align: center;font-size:18px">
      
        <a href="#" title="Send SMS for google rating" id="anchorMsgLnk">
          <span class="fa fa-envelope fa-2x"></span>
        </a>
    
    </div>
         </div>
    
       <% using (Html.BeginForm(null, null, FormMethod.Post, new { id = "SearchForm" }))
       { %>

    <div id="divTran" style="display: none; width: 600px;">
        <a href="#divTran" id="btnTrandiv"></a>
        <fieldset style="height:auto">

            <div id="divCntrlsE">
                 <div id="tbldiv">
                </div>
            </div>
        </fieldset>
        <div style="text-align: center">
            <table>
                <tr>
                   
                    <td>

                          <input type="button" style="margin-top: 10px; margin-bottom: 10px; width: 90px;border-radius: 7px;" name="btnSave" id="btnLogin" class="BtnFormat" value="Ok"  onclick="OKbutton()">
                        <input type="button" style="margin-top: 10px; margin-bottom: 10px; width: 90px;border-radius: 7px;" name="btnSave" id="btnLogin1" class="BtnFormat" value="Not Ok"  onclick="NotOKbutton()">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <% } %>

    <div class="row" style="text-align: center;display:none;">
        <div id="divMarkComplete">
              <% if (@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MarkCompleteBottomYN") == "Y")
          { %>
            <a class="btn btn-app" id="MarkComplete">
                <i class="fa  fa-check-circle fa-4x" style="font-size: 50px"></i>
            </a>
         <%} %>
        </div>
    </div>
     <div id="elementH"></div>
    <%-- Added by Dhananjay 20250530 - Calender --%>
    <div id="divCalenderInfo" style="display: none;">
        <a href="#divCalenderInfo" id="btnCalender"></a>    
<%--        <% Html.RenderPartial("CalendarPartialView", null); %>--%>
    </div>

    
   <%-- Added by Dhananjay 20250926 --%>
      <div style="position: static; bottom: 20px; left: 4%; right: 0; top: 20px; text-align: center; z-index: 1000; margin-top: 10px; margin-bottom: 10px; padding: 10px;">
    
        <!-- Save Button (Green) -->
        <button type="button" id="btnSave" onclick="SaveFollowUpPrint('', 'SS');"
            style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 8px 20px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); margin-right: 10px;"
            onmouseover="this.style.backgroundColor='#218838'"
            onmouseout="this.style.backgroundColor='#28a745'">
            Save
        </button>

        <!-- Save & Complete Button (Orange) -->
        <button type="button" id="btnCompleted" onclick="SaveFollowUpPrint('', 'M');"
            style="display: inline-block; background-color: #dc613a; color: white; border: none; border-radius: 5px; padding: 8px 20px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
            onmouseover="this.style.backgroundColor='#c6532f'"
            onmouseout="this.style.backgroundColor='#dc613a'">
            Save & Complete
        </button>

    </div>

    <div id="POPUPInfoModal" class="SchemeModal" style="justify-content: center; align-items: center;">
        <div class="Scheme-modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv SchemeHeader">
                <label id="InfoHeadLabel"></label>
                <span class="closeMdlBtn"  onclick="ClosePop('POPUPInfoModal');">&times;</span>
            </div>
            <div class="ModelContentDiv">
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Scheme Name</label>
                    <label>:</label>
                    <label id="SchemeLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Pre-requisites</label>
                    <label>:</label>
                    <label id="PreReqLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Advice/Remarks</label>
                    <label>:</label>
                    <label id="AdvRmksLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Pre-Investigations</label>
                    <label>:</label>
                    <label id="PreInvstLbl" style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
                <div style="display: flex;align-items: flex-start;">
                    <label style="width:150px;margin-left:10px">Post-Op/Treatment Inv.</label>
                    <label>:</label>
                    <label id="PostInvstLbl"style="margin-left:5px;text-wrap-mode: wrap;width: 320px;"></label>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>
    <script src="../js/jspdf.min.js"></script>
    <style>
       
        .BtnFormat {
    color: #fdfdfd;
    width: 200px;
    border-style: solid;
    border-color: #C3C2C1;
    background: #007cc3;
    padding: 5px;
    font-size: 12px;
    font-weight: bold;
}
         /*vijeta 30/4/19*/
        table {
            width: 100%;
        }
        /*added by vijeta on 28th July 2018*/
.hide{
    display:none;
}
        h3, .h3 {
    font-size: 18px !important;
    margin-top: 17px !important;
    margin-bottom: 8px !important;
        color: #025f76 !important;
    text-shadow: 0.65px 0 0 #006d88 !important;
    font-family: Verdana, Geneva, sans-serif !important;
}

        .table {
            margin-bottom: 10px !important;
            background-color: #fbe3e3;
            position: absolute;
            /*width: 46% !important;*/
             width: 60% !important;
            font-size: 12px;
            box-shadow: 1px 0px 4px 0px #344;
        }

        .alert-successm {
            background-color: #dff0d8;
            border-color: #d6e9c6;
            color: #3c763d;
        }

        .alert-infos1 {
            background-color: #d9edf7;
            border-color: #bce8f1;
            color: #31708f;
        }

        .active {
            background-color: red;
            border-color: #bce8f1;
            color: #31708f;
        }

        .alert-dangerD {
            background-color: #f2dede;
            border-color: #ebccd1;
            color: #a94442;
        }

        .borderC:first-child {
            border-radius: 16px 0px 0px 16px;
        }

        .borderC:last-child {
            border-radius: 0 16px 16px 0;
        }

        .select {
            -webkit-appearance: none;
            -moz-appearance: none;
            text-indent: 1px;
            width: 50px;
            background-color: #abdaf5;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 23px;
            outline: 0;
        }

        input.empty {
             font-family: Verdana, Geneva, sans-serif !important;
            font-style: normal;
            font-weight: normal;
            text-decoration: inherit;
        }

        .btn-default:active:hover, .btn-default.active:hover {
            color: #333;
            background-color: #09f725;
            border-color: #adadad;
        }

        .btn-default:active,
        .btn-default.active,
        .open > .dropdown-toggle.btn-default {
            color: #333;
            background-color: #3cde67;
            border-color: #adadad;
        }
         /*.content {
    width: 70% !important;
} /*4/10/19*/

         @media only screen and (min-width : 992px) {
           
             #tblDoctors{
      
                margin-left: 128px;
            }

            #tblclinic{
               
                margin-left: 128px;
            }
            #tblSurgery
            {
                margin-left: 128px;
            }

            #tblScheme
            {
                margin-left: 128px;
            }
       
        }
            table:not(#tbldiv) {
            width: 100%;
        }

        .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 13px;
            text-align: center;
            font-weight: bold;
        }

        .divBody {
            padding: 15px;
            background-color: white; /*rgba(128, 128, 128, 0.15);*/
        }

                   Label {
            margin-left: 5px;
        }
        .panel-body {
            width:auto !important;
            height:auto !important;
        }

         /*by vijeta on 23rd Oct 2018*/
        .content{
            width:98%;
        }

            .nopadding 
        {
             padding: 0 !important;
            margin: 0 !important;
        }
            .leftHead{
            font-size: 13px;
            font-weight: bolder;
            background-color: antiquewhite;
        }
            .liClass{
                font-size:13px;
                color:black;
            }

            .tblRx td,th{
                padding:1px;
            }
        .panel-heading {
            padding: 2px 5px;
        }

        #tblSurgery tbody { /*//*/
            display: block;
            height: 250px;
            overflow: auto;
        }

            #tblSurgery tbody tr { /*//*/
                display: table;
                width: 100%;
                table-layout: fixed;
            }

        .footer1 {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
            background-color: red;
            color: white;
            text-align: center;
        }

    /* Added by Dhananjay 20250530  */

        .btn-calendar {
            vertical-align: top;
            /*margin-top: 5px;*/
            margin-left: 10px;
            /*background-color: #337ab7;*/
            color: white;
            border: none;
            padding: 5px;
            border-radius: 60%;
            font-size: 20px;
            cursor: pointer;
            box-shadow: 0 4px 6px -4px rgba(0, 0, 0, 0.3);
        }

    .btn-calendar:hover {
        background-color: #286090;
    }

    /* Added by Dhananjay 20250530 */
    .disabled-icon {
    pointer-events: none; /* disables click */
    opacity: 0.5;          /* optional: makes it look disabled */
}
    </style>

    <script>
        var SignArr = [];
        var infotomail = "", infotomail2 = "";
        var formatclickd = '';//
        var Html = 0;
        var HeaderLang = [];
        var EnglishHeader = ["Chief Complaints", "Vital Examinations", "Final Diagnosis", "Advice", "Investigations / Procedures", "Treatment Advice",
            "Medicine Name", "Generic Name", "Follow Up After", "", "On Examinations", "Cross Reference to Other Oncologist", "Personal History", "Medical History", "Family History",
            "Refer to Specialist", "Remark/Note", "Complaint", "Plan Of Treatment", "Provisional Diagnosis", "History",

            "Allergy", "Final Diagnosis", "ICD Diagnosis", "Surgery Adviced Date", "Surgery Adviced", "PAC on or before", "Site", "Sub-Site", "Stage", "ChemoPlanning", "Cross Reference to Other Oncologist"
        ] // other history in examination heading is made blank
        var DaysContainer = [];
        var EnglishDays = ["Day", "Week", "Month", "Year"];
        var HindiDays = ["दिन", "सप्ताह", "महीने", "साल"]
        var MarathiDays = ["दिवस", "आठवडा", "महिना", "वर्ष"]
        var GujaratDays = ["દિવસ", "સપ્તાહ", "મહિનો", "વર્ષ"]
        var ContinueVisitLanguge = ["Continue till next visit", "अगले जांच तक जारी रखें", "पुढील तपासणी पर्यंत सुरू ठेवा", "આગામી મુલાકાત સુધી ચાલુ રાખો"];
        var SOSLanguge = ["SOS", "आवश्यकतानुसार", "आवश्यकतेनुसार", "જરૂરી મુજબ"];
        var IntakeStatement = "";
        var languageWise = ""
        var IntakeLanguage = ""
        var BeforFoodData = "Before Food"
        var AfterFoodData = "After Food"
        var IntakeIndicator = "";
        var img1, img2;
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var strReferralDocts = ""; //added om 20th march 2018
        var strReferralDoctCodes = ""; //added om 20th march 2018
        var strReferralClinics = ""; //added om 21st march 2018
        var strReferralClinicCodes = ""; //added om 21st march 2018
        var printWithHistory = "Y";//added on 7th may 2018
        var appmntAlreadyBookedYn = "N";//added on 17th jan 19
        <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>//3-10-19
        var RemarkArray = '<%:Html.Raw(Samp.Serialize(ViewBag.RemarkArray))%>';//3-10-19
        var MedRoute = '<%:Html.Raw(Samp.Serialize(ViewBag.MedRoute))%>';//3-10-19
        var ToEmailID = "";
        var onlypay = "";
        var sign1 = "";
        var sign2 = "";
        var sign3 = "";
        var digitsign1 = "";
        var digitsign2 = "";
        var digitsign3 = "";
        var ShowRefDoct = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("showRefToDoctor")%>'; //meenakshi 
        var ShowGoogleRating = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ShowGoogleRating")%>'; //meenakshi 
        var autoComplete = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("AutoCompltPrescript")%>'; //meenakshi 

        var autoCompleteOnPrint = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("AutoCompltOnPrintPrescritpion")%>'; //meenakshi added on 05-08-2024

        var PrintOnCompletion = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DirectPrint")%>'   // Condition Added by Murali on 02/08/224
        var ShowTBRef = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("SHOWTBREF")%>'; // Added by Dhananjay 20241005 
        //Added by Ashvini on 15/11/2024 to check whether to allow to send email for the non completed prescription
        var AllowMailBeforePrescriptionCompl = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("AllowMailBeforePrescriptionCompl")%>';
        var completionstatus = "";
        //  
        //Meenakshi added this setup by nitesh but used this to display send email after tick mark when completion step is mandatory before sending email
        var CompTickDispAtBottom = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MarkCompleteBottomYN")%>';
        var PrintWithLetterHead = "";
        var CareTypeShowYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PRESCRIPTIONCARETYPESHOWYN")%>'; //Rajan 
        var CareTypeLst = JSON.parse('<%:Html.Raw(Samp.Serialize(ViewBag.CareTypeList))%>'); //Rajan
        var ISICDDiagReq = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("isICDDiagnoReq")%>'; //Added By Priyanka on 29/01/2025
        var ISDiagnoMandatory = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DiagnosisMandatory")%>';//Added By Priyanka on 29/01/2025
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';

        var NotesWiseDoct = "Y";
        var AllSchemeList = [];
        var ShowVitalsInPrescPrintYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("ShowVitalsExtraFieldsinPrescPrint")%>';//Priyanka 26/12/2025
        $(document).ready(function (e) {
            SchemePatList();
            HoldOn.open();
            PrintWithLetterHead = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PWLH")%>';
            if (NotesWiseDoct == "Y") {
                document.getElementById("btnAddRef").style.display = "inline-block";
                document.getElementById("SearchDoctDiv").style.display = "none";
                document.getElementById("SearchListDoctDiv").style.display = "none";
                document.getElementById("SelDoctDiv").style.display = "none";
                document.getElementById("NotesWiseDoctDiv").style.display = "flex";
            }
            else {
                document.getElementById("NotesWiseDoctDiv").style.display = "none";
                document.getElementById("btnAddRef").style.display = "none";
                document.getElementById("SearchDoctDiv").style.display = "block";
                document.getElementById("SearchListDoctDiv").style.display = "block";
                document.getElementById("SelDoctDiv").style.display = "block";
            }

            if (ShowRefDoct == "N")
                $("#ReferToDrHosp").hide();
            else
                $("#ReferToDrHosp").show();

            if (ShowGoogleRating == "Y")
                $("#divSMSGoogRating").show();
            else
                $("#divSMSGoogRating").hide();

            if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DispLanguage")%>' == "Y") {
                $("#divPrescriptLang").show();
            }
            else {
                $("#divPrescriptLang").hide();
            }

            ToEmailID = $.session.get('PatEmail');
            if (ToEmailID != "" && ToEmailID != undefined) {
                $("#divmail").show();
                $("#P_Email").html(ToEmailID);
            }
            else {
                $("#P_Email").html("Email ID is not registered.");
                $("#Addpencil").remove();
            }

            //  Added by Dhananjay 20241005 
            if (ShowTBRef == "Y")
                $("#showTBRef").show();
            else
                $("#showTBRef").hide();

            //Meenakshi to relocate the complete tick mark as per the setup if send email is restricted before completion and mark tick display at bottom only
            if (AllowMailBeforePrescriptionCompl == "N" && CompTickDispAtBottom != "N") {
                $("#divmail").insertAfter("#divMarkComplete"); $("#divmailicon").insertAfter("#divmail");
            }

            if ($.session.get('OutRefDrNm') != "" && $.session.get('OutRefDrNm') != undefined)
                $("#divCallDone").removeClass("hide");

            GetSavedData();
            document.body.style.cursor = "wait";
            SetPatientDtl();
            SetDataForPrescriptionPrint();
            $("#slide_sdList").hide();//kavita 12-aug-2019
            document.getElementById('txtSurgeryAdvice').focus();//added by kavita
            // AddClinics(urls); //commented vijeta 30/4/19
            var Days = "";
            $('.trigger1').po({
                alignment: 'center'
            });
            $('.trigger2').po({
                alignment: 'center'
            });
            //(;

            onlypay = "Y";// $.session.get('onlpaySTAT');
            if (onlypay == "Y") {
                $("#divmail").show();
                $("#divmailicon").show();
            }
            else {
                $("#divmail").hide();
                $("#divmailicon").hide();
            }

            if ($(window).width() >= 996) {
                //screen width size comparion

                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";

                // $("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                ActiveMenu("PresPrint");
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }

            for (var i = 0; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' onclick='SetNumber(" + i + ");' style='font-weight:800;font-size:16px' id='NumDaysSc'>" + i + "</a>";
                $("#layer-Numbers").append(s);
            }

            $('.Printformat input[type=radio]').on('change', function () {
                HoldOn.open();//
                formatclickd = this.value;
                if (formatclickd == 'Temp_1') {
                    Continueornot(formatclickd);
                    this.checked = false;
                } else {
                    if (sessionStorage.getItem('PatCompleted') == "Y")
                        SaveFollowUpPrint(this.value, "M");
                    else if (autoCompleteOnPrint == "N")
                        SaveFollowUpPrint(this.value, "SS");
                    else
                        SaveFollowUpPrint(this.value, "M");

                    //SaveFollowUpPrint(this.value, ""); // Commented by Murali on 02/08/224
                    //Meenakhsi... 15/04/2020
                    /*---------------after Print reset the button-------------------------------------------*/
                    //$('.tempprint').removeClass('active');
                    this.checked = false;
                    /*---------------end Here-------------------------------------------------------------*/
                    //HoldOn.close();//
                }
            });


            $('.Language input[type=radio]').on('change', function () {

                var hindiHeader = ["मुख्य शिकायतें", "सामान्य परीक्षाएं", "निदान", "सलाह", "जांच के लिए सलाह", "उपचार सलाह", "दवाई", "सामान्य नाम", "अगला चेक अप", "बाद", "जांच के बाद", "रेफ़रल चिकित्सक", "व्यक्तिगत इतिहास", "चिकित्सा का इतिहास", "परिवार के इतिहास", 'टिप्पणी', 'नि: शुल्क शिकायत', 'इतिहास'
                , "एलर्जी", " अंतिम निदान", "आईसीडी निदान", "सर्जरी की सलाह दी गई तारीख", "सर्जरी की सलाह दी गई", "पीएसी इस तारीख को या उससे पहले", "स्थान", "उप-स्थान", "चरण"]; // other history in examination heading is made blank
                var marathiHeader = ["मुख्य तक्रारी", "सामान्य परीक्षा", "निदान", "सल्ला", "तपासणीसाठी सल्ला", "उपचार सल्ला", "औषधे", "सामान्य नाव", "पुढील तपासणी", "नंतर", "तपासणी नंतर", "संदर्भित डॉक्टर", "वैयक्तिक इतिहास", "वैद्यकीय इतिहास", "कौटुंबिक इतिहास", 'टिप्पणी', "विनामूल्य तक्रार", 'इतिहास'
                , "अ‍ॅलर्जी", "अंतिम निदान", "आयसीडी निदान", "शस्त्रक्रियेची शिफारस केलेली तारीख", "शस्त्रक्रियेची शिफारस केली", "पीएसी या तारीखपूर्वी", "स्थान", "उप-स्थान", "टप्पा"]; // other history in examination heading is made blank
                var gujaratiHeader = ["મુખ્ય ફરિયાદો", "સામાન્ય પરીક્ષાઓ", "નિદાન", "સલાહ", "તપાસ માટે સલાહ", "સારવાર સલાહ", "દવાઓ", "સામાન્ય નામ", "આગામી ચેકઅપ", "પછી", "ચેકઅપ પછી", "સંદર્ભિત ડોક્ટર", "વ્યક્તિગત ઇતિહાસ", "તબીબી ઇતિહાસ", "પારિવારિક ઇતિહાસ", "ટિપ્પણી", "નિઃશુલ્ક ફરિયાદ", 'ઇતિહાસ'
                , "એલર્જી", "અંતિમ નિદાન", "આઇસીડીએ નિદાન", "સર્જરી સૂચવેલ તારીખ", "સર્જરી સૂચવેલ", "પીએસી આ તારીખે અથવા તે પહેલાં", "સ્થાન", "ઉપસ્થાન", "તબક્કો"];// other history in examination heading is made blank
                var teluguHeader = ["ప్రధాన ఫిర్యాదులు", "సాధారణ పరీక్షలు", "చివరి నిర్ధారణ", "సలహా", "పరీక్షల కోసం సలహా", "చికిత్స సలహా", "ఔషధం", "సాధారణ పేరు", "తదుపరి తనిఖీ", "తరువాత", "పరీక్షల తరువాత", "మరొక ఆంకాలజిస్ట్‌కు రిఫరల్", "వ్యక్తిగత చరిత్ర", "వైద్య చరిత్ర", "కుటుంబ చరిత్ర", "గమనిక", "ఉచిత ఫిర్యాదు", "చరిత్ర", "చికిత్సా ప్రణాళిక", "ప్రాథమిక నిర్ధారణ", "అలర్జీ", "చివరి నిర్ధారణ", "ICD నిర్ధారణ", "శస్త్రచికిత్స సూచించిన తేదీ", "శస్త్రచికిత్స సూచించబడింది", "PAC ఈ తేదీకి లేదా అంతకు ముందు", "స్థలం", "ఉప-స్థలం", "దశ"];
                var AfterFood = ["After Food", "भोजन के बाद", "अन्न नंतर", "ભોજન પછી", "ఆహారం తర్వాత"];
                var BeforFood = ["Before Food", "भोजन से पहले", "अन्न करण्यापूर्वी", "ફૂડ પહેલાં", "ఆహారానికి ముందు"];
                var lang = this.value;
                $('#hdnlanguage').val(lang);

                switch (this.value) {

                    case "NAME":
                        HeaderLang = EnglishHeader;
                        BeforFoodData = BeforFood[0];
                        AfterFoodData = AfterFood[0];
                        break;
                    case "HINDI":
                        HeaderLang = hindiHeader;
                        BeforFoodData = BeforFood[1];
                        AfterFoodData = AfterFood[1];
                        break;
                    case "MARATHI":
                        HeaderLang = marathiHeader;
                        BeforFoodData = BeforFood[2];
                        AfterFoodData = AfterFood[2];
                        break;
                    case "GUJRATI":
                        HeaderLang = gujaratiHeader;
                        BeforFoodData = BeforFood[3];
                        AfterFoodData = AfterFood[3];
                        break;
                    case "TELUGU":
                        HeaderLang = teluguHeader;
                        BeforFoodData = BeforFood[4];
                        AfterFoodData = AfterFood[4];
                        break;
                    default:
                        HeaderLang = EnglishHeader;
                        BeforFoodData = BeforFood[0];
                        AfterFoodData = AfterFood[0];
                        break;
                }
            });

            $("#MarkComplete").click(function () {
                SaveFollowUpPrint('', 'M');
            });
            GetCliniclist();
            //added on 20th march 2018
            var tbl = document.getElementById('tblDoctors');
            var doctIn = document.getElementById('DoctorInput');

            var clnctbl = document.getElementById('tblclinic');
            var ClinicIn = document.getElementById('ClinicInput');

            var surgtbl = document.getElementById('tblSurgery');//by vijeta 13thMarch19
            var surgIn = document.getElementById('SurgeryInput');//by vijeta 13thMarch19

            window.onclick = function (event) {
                var nodes = Array.prototype.slice.call(tbl.querySelectorAll("*"), 0);
                if (event.target != tbl && event.target != doctIn && $.inArray(event.target, nodes) == -1) {
                    $("#tblDoctors tr").hide();
                    $("#DoctorInput").val("");
                }

                var clinicNodes = Array.prototype.slice.call(clnctbl.querySelectorAll("*"), 0);
                if (event.target != clnctbl && event.target != ClinicIn && $.inArray(event.target, clinicNodes) == -1) {
                    $("#tblclinic tr").hide();
                    $("#ClinicInput").val("");
                }

                //added on 13th march19
                var surgeryNodes = Array.prototype.slice.call(surgtbl.querySelectorAll("*"), 0);
                if (event.target != surgtbl && event.target != surgIn && $.inArray(event.target, surgeryNodes) == -1) {
                    $("#tblSurgery tr").hide();
                    $("#tblSurgery tbody").hide();
                    $("#SurgeryInput").val("");
                }

                var SchemTbl = document.getElementById('tblScheme');
                var SchemIn = document.getElementById('SchemeInput');
                var SchemeNodes = Array.prototype.slice.call(SchemTbl.querySelectorAll("*"), 0);
                if (event.target != SchemTbl && event.target != SchemIn && $.inArray(event.target, SchemeNodes) == -1) {
                    $("#tblScheme tr").hide();
                    $("#tblScheme tbody").hide();
                    $("#SchemeInput").val("");
                }
            }
            //---------------------------------------------------

            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys

            //added on 7th may 2018
            $("#chkPrintHistory").click(function (e) {
                var val = e.currentTarget.checked;
                if (val) {
                    printWithHistory = "Y";
                }
                else {
                    printWithHistory = "N";
                }
            });

            $("#btnTakeAppointMent").click(function () {
                $("#appnmtDiv").toggleClass("hide");
                if ($("#appnmtDiv").hasClass('hide')) {
                    $("#txtAppointmntDate").val("");
                    $("#txtAppointmntTime").val("--Preferred Time--")
                }
                else {
                    SetAppointmentDateTime();
                }
            });

            $("#txtProposeAdmnDT").datepicker(
              {
                  showButtonPanel: true,
                  changeMonth: true,
                  yearRange: "c-150:c+99",
                  changeYear: true,
                  dateFormat: "dd/mm/yy",
                  minDate: new Date(),

              });

            $("#txtProposeAdmnDT").val("");

            $("#txtAppointmntDate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            minDate: new Date(),

                        });
            //Meenakshi added on 08-10-2024
            $("#txtProposeAdmnDT").change(function () {
                if ($("#txtProposeAdmnDT").val() != "")
                    $("#chkAdmnAdvice")[0].checked = true;
            });

            $("#chkAdmnAdvice").change(function () {
                if ($("#chkAdmnAdvice").prop('checked') == false)
                    $("#txtProposeAdmnDT").val("");
            });

            $("#txtAppointmntDate").change(function () {
                //var d = new Date();
                var strDate = $("#txtAppointmntDate").val();//$.datepicker.formatDate('dd/mm/yy', new Date());

                var NumWeekday = new Date().getDay() + 1;
                var varclicniccode = "";//$("#cmbDoctClinic").val();
                var vardoctorcode = '<%:Session["gDoctCode"]%>';
                var getSearchDate = strDate;
                var SearchDate = getSearchDate.substring(10, 6) + getSearchDate.substring(5, 3) + getSearchDate.substring(0, 2);

                //if (varclicniccode != "" && vardoctorcode != "") {
                if (vardoctorcode != "") {
                    $.ajax({
                        async: false,
                        url: '../DoctorDesk/GetDoctorAval',
                        data: { CLINICCODE: varclicniccode, DOCTORCODE: vardoctorcode, SEARCHDATE: SearchDate, NumWeekday: NumWeekday, Searchwise: "DAY" },
                        dataType: "json",
                        success: function (response) {
                            if (response > 0) {
                                //MsgDia("Doctor not available today as per schedule or on leave.", "Information");
                                $.messager.alert("Information", "Doctor not available today as per schedule or on leave.");
                                $("#txtAppointmntDate").val("");
                                $("#txtAppointmntTime").empty();
                                $('#txtAppointmntTime')
                                .append($("<option>--Preferred Time--</option>"));
                            }
                            else {
                                $.ajax({
                                    url: '../DoctorDesk/GetAppointmnentSlots',
                                    type: "post",
                                    datatype: "json",
                                    data: { strDate: $("#txtAppointmntDate").val() },
                                    success: function (response) {
                                        $("#txtAppointmntTime").empty();
                                        if (response != "") {
                                            $('#txtAppointmntTime')
                                                   .append($("<option>--Preferred Time--</option>"));
                                            $.each(response, function (key, value) {
                                                $('#txtAppointmntTime')
                                                    .append($("<option></option>")
                                                               .attr("value", value.SLOTNO)
                                                               .text(value.Slot));
                                                $('#txtAppointmntTime').css('border', '2px solid green');//added on 17th jan19
                                            });
                                        }
                                        else {
                                            $('#txtAppointmntTime').append($("<option>--Preferred Time--</option>"));
                                            $('#txtAppointmntTime').css('border', '2px solid red');//added on 17th jan19
                                            // $.messager.alert("Information", "No slots for this Date.. Select another date. ");//commented by vijeta on 17thjan19
                                            // $("#txtAppointmntDate").val("");//commented by vijeta on 17thjan19
                                        }
                                    }
                                });
                            }
                        }
                    });
                }

            });

            $("#anchorMsgLnk").click(function () {
                var strMRNo = $.session.get('PatMRNO');
                var patMobile = $.session.get('PatMobile').toString().trim();
                var lang = $("#hdnlanguage").val();
                var strlang = "";
                if (lang == "NAME")
                    strlang = "E";
                else if (lang == "HINDI")
                    strlang = "H";
                else if (lang == "MARATHI")
                    strlang = "M";
                else if (lang == "GUJRATI")
                    strlang = "G";
                $.ajax({
                    url: '../DoctorDesk/SaveSMS',
                    data: { strMRNo: strMRNo, smsLang: strlang, strMobile: patMobile },
                    type: 'post',
                    datatype: 'json',
                    success: function (response) {
                        if (response == null)
                            $.messager.alert("Information", "Message has been sent successfully.");
                        else
                            $.messager.alert("Information", response);
                    }

                });
            });

            $("#anchorBookAppmnt").click(function () {
                HoldOn.open();
                SaveFollowUpPrint();
                var strApptmntDate = $("#txtAppointmntDate").val();
                var strSlotNo = $("#txtAppointmntTime").val();
                var strApptmntTime = $("#txtAppointmntTime option:selected").text();

                var patName = $.session.get('PatName').toString();
                var patAge = $.session.get('PatAge2').toString();
                var patGender = $.session.get('PatGender').toString();
                var patMobile = $.session.get('PatMobile').toString();

                var mrNo = $.session.get('PatMRNO');
                var tranno = $.session.get('PatTRANNO');

                var numberofdays = $('#hdnNumber').val();
                var daySelected = $('#hdnDayselect').val();

                if (strApptmntDate == "" || strApptmntTime == "--Preferred Time--") {
                    $.messager.alert("Information", "Please select Appointment Date and Time");
                    HoldOn.close();
                    return;
                }

                var refDoctName = $("#DoctorShow").val();// added by vijeta on 21st march 2018

                var strRefClinicName = $("#ClinicShow").val();//adbtnTakeAppointMentded by vijeta on 21st march 2018
                var strSurgAdvice = "" + $('#txtSurgeryAdvice').val();

                // $("#MarkComplete").click();

                $.ajax({
                    url: '../DoctorDesk/BookAppoinment',
                    data: {
                        AppmntDate: strApptmntDate, AppmntTime: strApptmntTime, strSlotNo: strSlotNo, patName: patName, patAge: patAge, patGender: patGender,
                        patMobile: patMobile, mrNo: mrNo, tranno: tranno, refDoctName: refDoctName, SurgyAdvice: strSurgAdvice, RefCliniName: strRefClinicName,
                        Number: numberofdays, DaySelected: daySelected
                    },
                    type: 'post',
                    datatype: 'json',
                    async: false,
                    success: function (response) {
                        $.messager.alert("Information", response);
                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {

                            $("#appnmtDiv *").attr("disabled", "disabled");//added on 17th jan19
                            $("#anchorBookAppmnt").off('click');////added on 17th jan19
                            appmntAlreadyBookedYn = "Y";

                            $("#appnmtShowDiv").removeClass("hide");//added 16th march 19
                            $("#appmntStringDisplay").text("Your appointment is booked on " + strApptmntDate + " " + strApptmntTime);//added 16th march 19                          
                            $("#btnTakeAppointMent").hide();//added 16th march 19
                            $("#appnmtDiv").addClass("hide");//added 16th march 19

                        }
                        else {
                            $("#txtAppointmntDate").removeAttr("disabled", "disabled");
                            $("#txtAppointmntTime").removeAttr("disabled", "disabled");
                        }
                    },
                    complete: function () { HoldOn.close(); },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        HoldOn.close();
                    }
                })
            });

            $(function () {
                $("#btnTrandiv").fancybox({
                    openEffect: 'elastic',
                    openSpeed: 100,
                    closeEffect: 'elastic',
                    closeSpeed: 100,
                    helpers: {
                        overlay: { closeClick: true }
                    },
                    afterShow: function () {
                        var anc = '<a title="Close" class="fancybox-item fancybox-close" onclick=CloseFancyBox();></a>';
                        $('.fancybox-outer').append(anc)
                    },
                    autoDimensions: true,
                    cyclic: true,
                    showNavArrows: true,
                    width: 40,
                    closeBtn: true,
                });
            });

            $('#lblSOS').click(function () {
                if ($('#lblSOS').css("background-color") != "rgb(0, 128, 0)") {
                    $('#lblSOS').css('background-color', 'green');
                    $('#layer-Numbers').css('display', 'none');
                    $('#layer-DMY').css('display', 'none');
                    $("#appnmtDiv *").attr("disabled", "disabled");
                }
                else {
                    $('#lblSOS').css('background-color', '#5bc0de');
                    $('#layer-Numbers').css('display', 'block');
                    $('#layer-DMY').css('display', 'block');
                }
                if ($('#lblSOS').css("background-color") == "rgb(0, 128, 0)") {
                    $("#Numbers").text("0");
                    $("#DaySelect").text("Days");
                    $('#hdnNumber').val("0");
                    $('#hdnDayselect').val("Days");
                    $("#txtAppointmntDate").val("");
                    $("#txtAppointmntTime").val("");
                }
            });

            $('.NumDaysCls').click(function () {
                if ($('#hdnNumber').val() != "0" || $('#hdnDayselect').val() != "Days") {
                    if ($('#lblSOS').css("background-color") == "rgb(0, 128, 0)") {
                        $('#lblSOS').css('background-color', '#5bc0de');
                        $('#lblSOS').attr('disabled', false);
                    }
                    if ($('#lblSOS').css("background-color") == "rgb(91, 192, 222)") {

                        $('#lblSOS').attr('disabled', true);
                    }
                    $("#appnmtDiv *").removeAttr("disabled", "disabled");
                }
                else {
                    if ($('#hdnNumber').val() == "0" || $('#hdnDayselect').val() == "Days") {
                        if ($('#lblSOS').css("background-color") == "rgb(91, 192, 222)") {
                            $('#lblSOS').attr('disabled', false);
                        }
                    }
                }
            })

            $("#anchorEemailLnk").click(function () {
                SendMailAction();
            });

            $("#Addpencil").click(function () {
                if (infotomail == "") {
                    $.messager.alert("Information", "Please Select Template");
                    return false;
                }
                //Ashvini ------
                if (AllowMailBeforePrescriptionCompl == "N" && completionstatus != 'Y') {
                    $.messager.alert("Information", "Prescription is not completed. Please click on this <i class='fa fa-check-circle' style='font-size: 20px; padding: 5px;'></i> to complete.");
                    return false;
                }
                else {
                    PopupForMail();
                }
                //------
            });

            if ($("#appmntStringDisplay").text() == "")
                $("#appnmtDiv").removeClass("hide");

            // Added by Dhananjay 20250530 => Opening Calender
            $("#openCalendarBtn").click(function () {
                CalenderActionType = "Y";
                $("a#btnCalender").click();
            });

            $("#txtAdviceDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                minDate: new Date(),
                onSelect: function (selectedDate) {
                    HandlePACAdvDate(selectedDate);
                }
            });
            $("#txtPACAdviceDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
            });


            // Checking Session Patinet Status 
            let patientStatus = sessionStorage.getItem('PatCompleted');
            if (patientStatus && patientStatus == 'Y') {
                DisableAllField();
            }

        });

        function HandlePACAdvDate(selectedDate) {
            var parts = selectedDate.split("/");
            var day = parseInt(parts[0], 10);
            var month = parseInt(parts[1], 10) - 1;
            var year = parseInt(parts[2], 10);
            var date = new Date(year, month, day);
            date.setDate(date.getDate() - 1);
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (date < today) {
                date = new Date();
            }
            var dd = ("0" + date.getDate()).slice(-2);
            var mm = ("0" + (date.getMonth() + 1)).slice(-2);
            var yy = date.getFullYear().toString();
            var newDate = dd + "/" + mm + "/" + yy;
            $("#txtPACAdviceDate").val(newDate);
        }

        function PopupForMail() {
            //Added by Ashvini on 15/11/2024
            $.confirm({
                title: '',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                theme: 'bootstrap',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">Enter Email ID</label><br>' +
                '<textarea  type="varchar" id="txtemail"  placeholder="Enter email" autofocus="autofocus" rows="2" class="setUp form-control" required />' +
                '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Send',
                        btnClass: 'btn-blue',
                        action: function () {
                            tomail = $("#txtemail").val();
                            if ($("#txtemail").val() == "" || $("#txtemail").val() == null) {// 18-12-19	
                                $('#txtemail').css({ 'border-color': 'Red' });
                                $('#txtemail').val("");
                                return false;
                            } else {
                                if (validateEmail(tomail) == false) {
                                    alert("Invalid Email ID format.");
                                    return false;
                                }
                                else {
                                    $('#txtemail').css({ 'border-color': '' });
                                    if (AllowMailBeforePrescriptionCompl == "N" && completionstatus != 'Y') {//This case is need to be here as this send email function is caling with this two criteria  Meenakshi added on 19/11/2024
                                        this.close();
                                        $.messager.alert("Information", "Prescription is not completed. Please click on this <i class='fa fa-check-circle' style='font-size: 20px; padding: 5px;'></i> to complete.");
                                        return false;
                                    }
                                    else {
                                        Callajxmail(tomail);
                                    }
                                }
                            }
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                    }
                },
                onContentReady: function () {
                    if (ToEmailID == "" || ToEmailID == null) {
                        $('#txtemail').val("");
                    }
                    else
                        $("#txtemail").val(ToEmailID);
                }
            });
        }

        function CloseFancyBox() {
            $.fancybox.close();
        }

        function GetSavedData() {
            //$.loader.open();
            HoldOn.open();
            var consNo = $.session.get('PatTRANNO');
            var ReSeqCnt = 0;
            $.ajax({
                type: "POST",
                url: "GetSavedMediList",
                data: { strConsNo: consNo },
                datatype: "json",
                async: false,
                success: function (response) {
                    if (response != "") {
                        var result = JSON.parse(response);
                        BindingFancyRx(result);
                        // var len = result.length;//vijeta 12/4/19
                        // ReSeqCnt = result[len - 1].RESEQ;//vijeta 12/4/19
                        // var RamrkList = JSON.parse(RemarkArray);

                        //RxNewSetData(result);
                    }
                    //$.loader.close();
                    HoldOn.close();
                },


                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }, complete: function () {
                    rowNoFrMedTaper = ReSeqCnt;//vijeta 12/4/19
                },
            });
        }

        function SetAppointmentDateTime() {
            var numberofdays = $('#hdnNumber').val();
            var daySelected = $('#hdnDayselect').val();

            if (Number(numberofdays) > 0) {

                if (daySelected == "Days") {
                    date = new Date();

                    date.setDate(date.getDate() + parseInt(numberofdays));
                    var dateEnd = ("0" + (date.getDate())).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
                    document.getElementById('txtAppointmntDate').value = dateEnd;
                    //var d = new Date();
                    $('#txtAppointmntDate').datepicker('option', 'minDate', new Date(date))//added on 17thjan19
                }
                else if (daySelected == "Months") {
                    date = new Date();
                    date.setMonth(date.getMonth() + Number(numberofdays));
                    var dateEnd = ("0" + (date.getDate())).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
                    document.getElementById('txtAppointmntDate').value = dateEnd;
                    $('#txtAppointmntDate').datepicker('option', 'minDate', new Date(date))//added on 17thjan19
                }
                else if (daySelected == "Weeks") {
                    date = new Date();
                    date.setDate(date.getDate() + (Number(numberofdays) * 7));
                    var dateEnd = ("0" + (date.getDate())).slice(-2) + '/' + ("0" + (date.getMonth() + 1)).slice(-2) + '/' + date.getFullYear();
                    document.getElementById('txtAppointmntDate').value = dateEnd;
                    $('#txtAppointmntDate').datepicker('option', 'minDate', new Date(date))//added on 17thjan19
                }
                else if (daySelected == "Years") {
                    date = new Date();
                    document.getElementById('txtAppointmntDate').value = date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear();
                    var str = $("#txtAppointmntDate").val();

                    if (/^\d{2}\/\d{1}\/\d{4}$/i.test(str)) {

                        var parts = str.split("/");

                        var day = parts[0] && parseInt(parts[0], 10);
                        var month = parts[1] && parseInt(parts[1], 10);
                        var year = parts[2] && parseInt(parts[2], 10);
                        var duration = parseInt(numberofdays, 10);

                        if (day <= 31 && day >= 1 && month <= 12 && month >= 1) {

                            var expiryDate = new Date(year, month - 1, day);
                            expiryDate.setFullYear(expiryDate.getFullYear() + duration);

                            var day = ('0' + expiryDate.getDate()).slice(-2);
                            var month = ('0' + (expiryDate.getMonth() + 1)).slice(-2);
                            var year = expiryDate.getFullYear();

                            $("#txtAppointmntDate").val(day + "/" + month + "/" + year);
                            $('#txtAppointmntDate').datepicker('option', 'minDate', new Date(expiryDate))//added on 17thjan19

                        } else {
                            // display error message
                        }
                    }
                }

                $("#txtAppointmntDate").trigger("change");
            }
        }

        function SetText(obj, str) {

            var selectedText = $(obj).text();
            $('#hdnDayselect').val(str);
            $('#DaySelect').text(selectedText);
            console.log($('#hdnDayselect').val());

            // added by vijeta on 28th July 2018
            if ($("#appnmtDiv").hasClass('hide')) {
                $("#txtAppointmntDate").val("");
                $("#txtAppointmntTime").val("")
            }
            else
                SetAppointmentDateTime();// added by vijeta on 28th July 2018
        }

        function checkFollowUplanguge(FollowUp, language, type) {

            switch (language) {
                case "NAME":
                    laguagewiseselect(FollowUp, EnglishDays, type)
                    break;
                case "HINDI":
                    laguagewiseselect(FollowUp, HindiDays, type)
                    break;
                case "MARATHI":
                    laguagewiseselect(FollowUp, MarathiDays, type)
                    break;
                case "GUJRATI":
                    laguagewiseselect(FollowUp, GujaratDays, type)
                    break;
                default:
                    laguagewiseselect(FollowUp, EnglishDays, type)
                    break;
            }
        }

        function laguagewiseselect(FollowUp, daysof, type) {

            switch ((FollowUp[1]).toString().trim()) {

                case "Days":
                    if (type == 'F')
                        languageWise = daysof[0];
                    else
                        IntakeLanguage = daysof[0];
                    break;
                case "Weeks":
                    if (type == 'F')
                        languageWise = daysof[1];
                    else
                        IntakeLanguage = daysof[1];
                    break;
                case "Months":
                    if (type == 'F')
                        languageWise = daysof[2];
                    else
                        IntakeLanguage = daysof[2];
                    break;
                case "Years":
                    if (type == 'F')
                        languageWise = daysof[3];
                    else
                        IntakeLanguage = daysof[3];
                    break;
                default:
                    if (type == 'F')
                        languageWise = daysof[0];
                    else
                        IntakeLanguage = daysof[0];
                    break;
            }

        }

        function checkInTakeStatement(IntakeIndicator, language) {
            var intakestate = '';

            switch (language) {
                case "NAME":
                    if (IntakeIndicator == "C")
                        intakestate = ContinueVisitLanguge[0]
                    else
                        intakestate = SOSLanguge[0]
                    break;
                case "HINDI":
                    if (IntakeIndicator == "C")
                        intakestate = ContinueVisitLanguge[1]
                    else
                        intakestate = SOSLanguge[1]
                    break;
                case "MARATHI":
                    if (IntakeIndicator == "C")
                        intakestate = ContinueVisitLanguge[2]
                    else
                        intakestate = SOSLanguge[2]
                    break;
                case "GUJRATI":
                    if (IntakeIndicator == "C")
                        intakestate = ContinueVisitLanguge[3]
                    else
                        intakestate = SOSLanguge[3]
                    break;
                default:
                    if (IntakeIndicator == "C")
                        intakestate = ContinueVisitLanguge[0]
                    else
                        intakestate = SOSLanguge[0]
                    break;
            }
            return intakestate;
        }

        function DurationTypeSelect(type, duration) {

            strDay = "Day";
            puralString = "";
            if (Number(duration) > 1) {
                puralString = "s"
            }

            switch (type) {

                case "D":
                    strDay = "Day" + puralString
                    break;
                case "W":
                    strDay = "Week" + puralString;
                    break;
                case "M":
                    strDay = "Month" + puralString
                    break;
                case "Y":
                    strDay = "Year" + puralString
                    break;
                default:
                    strDay = "Day" + puralString
                    break;
            }

            return strDay;

        }

        function SetNumber(str) {
            $('#Numbers').text(str);
            $('#hdnNumber').val(str);
            console.log($('#hdnNumber').val());

            // added by vijeta on 28th July 2018
            if ($("#appnmtDiv").hasClass('hide')) {
                $("#txtAppointmntDate").val("");
                $("#txtAppointmntTime").val("")
            }
            else
                SetAppointmentDateTime();// added by vijeta on 28th July 2018
        }

        function CheckPatSessionNotEmpty() {
            var mrNo = $.session.get('PatMRNO');
            var tranno = $.session.get('PatTRANNO');
            if (tranno != null) {
                if (mrNo != "" && tranno != "")
                    return true;
                else
                    return false;
            }
            else
                return false;
        }

        function SaveFollowUpPrint(TemplateType, RedirectOpt) {
            ////debugger;
            //HoldOn.open();
            var sos, numberofdays, daySelected = "";
            var selectedTemp = TemplateType;
            var mrNo = $.session.get('PatMRNO');
            var tranno = $.session.get('PatTRANNO');
            var advAdmnYN = "N";
            var checkTBRef = "N";           // Added by Dhananjay 20241005
            if ($('#lblSOS').css("background-color") == "rgb(0, 128, 0)") {
                daySelected = "";
                numberofdays = "SOS";
            }
            else {
                numberofdays = $('#hdnNumber').val();
                daySelected = $('#hdnDayselect').val();
            }
            //var refDoctor = $("#DoctorInput").val();
            var refDoctor = $("#DoctorShow").val();
            var strpatName = $.session.get('PatName').toString();
            var strSurgAdvice = "" + $('#txtSurgeryAdvice').val();
            //var strRefClinicName = $("#ClinicInput").val()
            var strRefClinicName = $("#ClinicShow").val();

            var prescRemarks = $("#PrescriptionRemark").val();

            var planOfTreatmnt = $("#PlanOfTreatmnt").val();


            var CallDoneYN = "";

            if ($("#chkCallDoneYN")[0].checked)
                CallDoneYN = "Y";

            if ($("#chkAdmnAdvice")[0].checked)
                advAdmnYN = 'Y';

            // Added by Dhananjay 20241005
            if ($("#chkTBRef")[0].checked)
                checkTBRef = "Y";

            //Added by Meenakshi on 08-10-2024
            var propAdmnDT = "";
            propAdmnDT = $("#txtProposeAdmnDT").val();

            console.log(numberofdays + ":  " + daySelected);

            //added on 16thjan2019
            var patName = $.session.get('PatName').toString();
            var patAge = ($.session.get('PatAge2') == undefined || $.session.get('PatAge2') == null) ? "" : $.session.get('PatAge2').toString();
            var patGender = ($.session.get('PatGender') == undefined || $.session.get('PatGender') == null) ? "" : $.session.get('PatGender').toString();
            var patMobile = ($.session.get('PatMobile') == undefined || $.session.get('PatMobile') == null) ? "" : $.session.get('PatMobile').toString();// by vijeta on 28th jan 2019

            var strApptmntDate = $("#txtAppointmntDate").val();
            var strSlotNo = $("#txtAppointmntTime").val();
            var strApptmntTime = $("#txtAppointmntTime option:selected").text();
            var strAppmntYn = "N";
            if (!$("#appnmtDiv").hasClass('hide') && strApptmntDate != "" && strApptmntTime != "--Preferred Time--")
                strAppmntYn = "Y";

            //Added By Rajan
            var CareType = "";
            if ($("#chkAdmnAdvice").prop("checked") == true && CareTypeShowYN != "" && CareTypeShowYN != "N")
                CareType = $("#CmbCareType").val();
            var NatureOfSurg = "";
            if ($("#rbtnNatSurgR").prop("checked") == true)
                NatureOfSurg = "R";
            if ($("#rbtnNatSurgE").prop("checked") == true)
                NatureOfSurg = "E";
            if ($("#rbtnNatSurgT").prop("checked") == true)
                NatureOfSurg = "T";

            // Added by Dhananjay 20250928 Save Option Only
            var orgRedirectPath = RedirectOpt;
            if (RedirectOpt == 'SS') {
                RedirectOpt = 'N'
            }
            var ApplyScheme = SchemeListForSave.join(',');
            var LevelUrgency = "";
            if ($("#chkAdmnAdvice").prop("checked") == true)
                LevelUrgency = $("#cmbLevelOfUrg").val();
            var datatosend = {
                Number: numberofdays,
                DaySelected: daySelected,
                MrnNo: mrNo,
                Transno: tranno,
                RefDoctor: refDoctor,
                patName: strpatName,
                SurgyAdvice: strSurgAdvice,
                RefCliniName: strRefClinicName,
                patAge: patAge,
                patGender: patGender,
                patMobile: patMobile,
                AppmntDate: strApptmntDate,
                AppmntTime: strApptmntTime,
                strSlotNo: strSlotNo,
                prescRemarks: prescRemarks,
                planOfTreatmnt: planOfTreatmnt,
                CallDoneYN: CallDoneYN,
                strAdveFrAdmn: advAdmnYN, //Meenakshi 
                RedirectOpt: RedirectOpt,
                TBRef: checkTBRef,
                PropAdmnDT: propAdmnDT,
                CareType: CareType, //Added By Rajan
                SurgeryCode: $("#hdnSurgeryCode").val(),
                SurgyAdvDate: $("#txtAdviceDate").val(),
                PACAdvDate: $("#txtPACAdviceDate").val(),
                SurgeryAdviceType: NatureOfSurg,
                NotesLst: JSON.stringify(NoteList),
                SchemeCodes: ApplyScheme,
                LevelUrg: LevelUrgency
            }

            $.ajax({
                type: "Post",
                url: "../DoctorDesk/SaveFollowUpData",
                data: datatosend,
                async: false,
                success: function (Result) {
                    if (Result == "Successful") {

                        // Added by Dhananjay 20250928
                        if (orgRedirectPath == 'SS') {
                            $.messager.alert("Information", "Saved Successfully.");
                            return;
                        }

                        if (RedirectOpt == "N") {
                            window.location.href = 'PatientEntry';
                        }
                        else if (RedirectOpt == "Y") {
                            //do nothing
                        }
                        else if (RedirectOpt == "M") {
                            if (PrintOnCompletion == "Y") {
                                //$.messager.alert("Information", "Completed Successfully.");
                                GetBindingData(($.session.get('PatTRANNO')), selectedTemp, "M");
                            }
                            else {
                                $.messager.alert("Information", "Completed Successfully.");
                                completionstatus = "Y"; //Meenakshi after completion this flag is made y other wise after completion it was not sending email in case of restrict before complete setup
                            }
                            // Setting Data to Patient Completed 
                            sessionStorage.setItem('PatCompleted', 'Y');
                            DisableAllField();

                            var Mrno = ($.session.get('PatMRNO'));

                            var datatosend = {
                                printdata: encodeURIComponent(infotomail),
                                TranNo: ($.session.get('PatTRANNO')),
                                Mrno: Mrno,
                                printdataTop: encodeURIComponent(infotomail2)
                            };
                            $.ajax({
                                type: "POST",
                                url: "../DoctorDesk/SendFileToSQS",
                                async: false,
                                data: datatosend,
                                dataType: "json",
                                success: function (response) {
                                    if (response == "Success") {

                                    }
                                    else
                                        $.messager.alert("Information", response);

                                    //HoldOn.close();
                                },
                                error: function () {
                                    HoldOn.close();
                                    alert('error');
                                }
                            });

                            //window.location.href = '../DoctorDesk/PatientEntry'
                        }
                        else if (RedirectOpt == "" || RedirectOpt == "M") {
                            // $.messager.alert("Information", "Completed Successfully."); // Added by Murali on 07/08/2024
                            GetBindingData(tranno, selectedTemp, RedirectOpt);
                        }
                        if ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("QMSENABLE")%>' == "A") {
                            NextPatCall();
                        }

                    }

                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //ajaxindicatorstop();
                    MsgDia(textStatus, "Error");
                    HoldOn.close();
                }
            });
        }

        function NextPatCall() {
            if ($.session.get('SrchByDoctYN') != undefined)
                SrchByDoctYN = $.session.get('SrchByDoctYN');
            else
                SrchByDoctYN = '<%=System.Web.HttpContext.Current.Session["gDoctCode"]%>';

            if ($("#rbtnYesterday")[0].checked == true)
                dayType = "Y";
            else if ($("#rbtnDayBefYest")[0].checked == true)
                dayType = "B";
            else if ($("#rbtnDayCustom")[0].checked == true)
                dayType = "D"
            else
                dayType = "T";

            var clinicCode = $.session.get('ClinicCode');
            var CustomeDate = "";
            var options1 = ""; var QMSToken = "";
            var url = "../DoctorDesk/GetPatientList";
            //HoldOn.open();

            $.ajax({
                url: url,
                type: 'post',
                dataType: 'json',
                data: { strClinicCode: clinicCode, strSrchByDoctYN: SrchByDoctYN, DateType: dayType, CustomeDate: CustomeDate },
                success: function (result) {
                    if (result.Result != "Something Went Wrong.") {
                        SetPatientDtl();
                        $.each(result.Result, function (i, item) {
                            //$.each(strNextPat, function (i, item) {
                            var patName = item.PatName;
                            var ApptTm = item.APPTTM;
                            var mrNo = item.MRNO;
                            var consNo = item.CONSNO;
                            var timeDiff = item.DIFFTM;
                            var age = item.Age;
                            var dob = item.DOB;
                            var gender = item.Gender;
                            var compltdYn = item.CompletedYN;

                            var ConsDate1 = item.ConsDate.split("/");// 29-04-2020	
                            var ConsDate = ConsDate1[0] + "/" + ConsDate1[1];// 29-04-2020
                            var tranNo = (item.TRANNO).toString().trim();

                            var chkSign = Math.sign(timeDiff);
                            var onlpaystat = (item.OnlyPayStat).toString().trim();
                            var PatEmail = (item.PatEmail).toString().trim();
                            var applyColor = "none";
                            var coloronlpay = "none";

                            var OutRefDoct = item.OutRefDrName;

                            var OutRefDoctContact = item.OutRefDrContact;

                            var MobileNo = item.MobileNo;

                            var TokenNo = item.CONTOKNO

                            if (chkSign == 1) {
                                if (timeDiff > 30) {
                                    //red color
                                    applyColor = "red";
                                }
                                else
                                    applyColor = "#e49f21;";
                                //alert("positive");yellow
                            }
                            else if (chkSign == -1) {
                                applyColor = "green";
                                //alert("negative"); green
                            }
                            else if (chkSign == NaN) {
                                //alert("No time");
                            }
                            if (onlpaystat == "Y") {
                                //coloronlpay = "#b7f1c8";// Meenakshi 14/04/2020
                                coloronlpay = "border: 2px solid #f3d106;background: #75dec1;border-bottom-left-radius: 15px; border-top-right-radius: 15px;";
                            }
                            if (compltdYn == "N" || compltdYn == " ") {
                                if (QMSToken == "") {
                                    //waitingCount++;
                                    options1 += "<li class='' id='PatName" + item.CONSNO + "' style='display: block;'><div style='display: inline-block;width: 80%;'><label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "-" + ConsDate + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='TokenNo' value='" + TokenNo + "' /></div><div style='display: inline-block;vertical-align: sub;' class=''><label  title='Call Patient' style='vertical-align:bottom;'><img style='width:35px; height:35px;' onClick='CallPat(\"\",\"R\")' class='lblImage1 RpatNameCls' src='../Images/notificationnew.png' /></label></div></li>";
                                    //<img id='btnCall' src='../Images/notificationnew.png' alt='Call the Patient' style='width:20px;height:20px;margin-top: 4px;margin-left: 209px;' onclick='List()'/> <input type="button" class="ui-icon ui-icon-volume-on" style=" width: 20px;height: 20px;" id=' + rowid + ' onclick="SaveToCallToken(this)">
                                    QMSToken = TokenNo;
                                    //Changes For Patient Select after Bell Icon Click
                                    $.session.set('NTokenNo', TokenNo);
                                    $.session.set('NPatMRNO', mrNo);
                                    $.session.set('NPatName', patName);
                                    $.session.set('NConsltnNo', item.CONSNO);
                                    $.session.set('NPatTRANNO', item.CONSNO);

                                    $.session.set('NPatAge', age);
                                    $.session.set('NPatGender', gender);
                                    $.session.set('NPatMobile', MobileNo);
                                    $.session.set('NPatAge2', age);
                                    $.session.set('NPatDOB', dob);
                                    $.session.set('NonlpaySTAT', onlpaystat);
                                    $.session.set('NPatEmail', PatEmail);
                                    $.session.set('NOutRefDrNm', OutRefDoct);
                                    $.session.set('NOutRefDrContact', OutRefDoctContact);
                                    $.session.set('NConsltnDT', item.ConsDate);
                                }
                                else if (parseInt(TokenNo) < parseInt(QMSToken)) {
                                    options1 = "<li class='' id='PatName" + item.CONSNO + "' style='display: block;'><div style='display: inline-block;width: 80%;'><label style='padding-left:2px;width:79px;font-size:11px;margin-top: 3px;color:" + applyColor + "'>" + ApptTm + "-" + ConsDate + " </label><label style='padding: 2px 4px 3px 5px;font-size: 11.5px;margin-left: 2px;" + coloronlpay + "' id='" + mrNo + "'>" + patName + "</label><input type=hidden id='wtngTm' value='" + timeDiff + "' ></input><input type=hidden id='age' value='" + age + "' ></input><input type=hidden id='gender' value='" + gender + "' ></input><input type=hidden id='mrNo' value='" + item.MRNO + "' ></input><input type=hidden id='tranNo' value='" + item.CONSNO + "' ></input><input type=hidden id='mobNO' value='" + item.MobileNo + "' ></input><input type=hidden id='dob' value='" + dob + "' /><input type=hidden id='onlpaystat' value='" + onlpaystat + "' /><input type=hidden id='PatEmail' value='" + PatEmail + "' /><input type=hidden id='OutRefDrName' value='" + OutRefDoct + "' /><input type=hidden id='OutRefDrContact' value='" + OutRefDoctContact + "' /><input type=hidden id='TokenNo' value='" + TokenNo + "' /></div><div style='display: inline-block;vertical-align: sub;' class=''><label  title='Call Patient' style='vertical-align: bottom;'><img style='width:35px; height:35px;' onClick='CallPat('',\"R\")' class='lblImage1' src='../Images/notificationnew.png' /></label></div></li>";

                                    QMSToken = TokenNo;
                                    //Changes For Patient Select after Bell Icon Click
                                    $.session.set('NTokenNo', TokenNo);
                                    $.session.set('NPatMRNO', mrNo);
                                    $.session.set('NPatName', patName);
                                    $.session.set('NConsltnNo', item.CONSNO);
                                    $.session.set('NPatTRANNO', item.CONSNO);

                                    $.session.set('NPatAge', age);
                                    $.session.set('NPatGender', gender);
                                    $.session.set('NPatMobile', MobileNo);
                                    $.session.set('NPatAge2', age);
                                    $.session.set('NPatDOB', dob);
                                    $.session.set('NonlpaySTAT', onlpaystat);
                                    $.session.set('NPatEmail', PatEmail);
                                    $.session.set('NOutRefDrNm', OutRefDoct);
                                    $.session.set('NOutRefDrContact', OutRefDoctContact);
                                    $.session.set('NConsltnDT', item.ConsDate);
                                }

                            }

                        });
                        if (options1 != "") {
                            $.confirm({
                                title: '',
                                content: '' +
                                    '<form action="" class="formFreeText" >' +
                                    '<div class="form-group">' +
                                    '<div id="WaitingPats">' +
                                    '<label style="font-size: 15px; color: blue;">Next Waiting Patient </label>' + options1 +
                                    '</form>',
                                buttons: {
                                    CLOSE: function () {
                                        //Changes For Patient Select after Bell Icon Click
                                        $.session.set('NTokenNo', "");
                                        $.session.set('NPatMRNO', "");
                                        $.session.set('NPatName', "");
                                        $.session.set('NConsltnNo', "");
                                        $.session.set('NPatTRANNO', "");

                                        $.session.set('NPatAge', "");
                                        $.session.set('NPatGender', "");
                                        $.session.set('NPatMobile', "");
                                        $.session.set('NPatAge2', "");
                                        $.session.set('NPatDOB', "");
                                        $.session.set('NonlpaySTAT', "");
                                        $.session.set('NPatEmail', "");
                                        $.session.set('NOutRefDrNm', "");
                                        $.session.set('NOutRefDrContact', "");
                                        $.session.set('NConsltnDT', "");
                                        //close
                                        //$('.FoodItems input:checked').focus();
                                    },
                                },

                            });
                        }

                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    HoldOn.close();
                }

            });

            GetAllCounts();
        }
        function Continueornot(obj) {
            $.confirm({
                title: 'Select list to print',
                columnClass: 'col-md-6 col-md-offset-4',
                content: '' +
                    '<form action="" class="formName" style="height:auto,width:auto">' +
                    '<div class="form-group"> ' +
                     '<div class="row" style="text-align: center" id="SelctCheck"> ' +
         '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="SelectPrintAll"/>  All</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" id="chkComplaint" style="vertical-align: sub;" />  Complaints</label> ' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkDiagnosis" />  Final Diagnosis</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkExamin" />  Examination</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkClinicalNotes" />  Clinical Notes</label>' +
        ' <br />' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkVital"/>  Vital Examination</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkPlanOfTreatmnt"/>  Plan of treatment</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkRemark"/>  Remarks</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkInvest" />  Investigations/Procedures</label>' +
         '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkRx"/>  Rx</label>' +
                     '<br />' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkAdvice"/>  Advice</label>' +
                     '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkPersHist"/>  Personal History</label>' +
                     '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkMedHist"/>  Medical History</label>' +
         '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkFamHist"/>  Family History</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;  id="chkAllergy"/>  Allergy</label>' +
                     '</div>' +
                    '<label> Do you Want to Continue?</label>' +
                    '<div id="divSrvcGrpSelect" style="border:1px solid gray;"></div>' +
                    '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Print',
                        btnClass: 'btn-blue',
                        action: function () {
                            if ($('#SelctCheck  input[type=checkbox]:checked').length > 0) {

                                if (sessionStorage.getItem('PatCompleted') == "Y")
                                    SaveFollowUpPrint(obj, "M");
                                else if (autoCompleteOnPrint == "N")
                                    SaveFollowUpPrint(obj, "SS");
                                else
                                    SaveFollowUpPrint(obj, "M");// Auto complete on print
                            }
                            else {
                                $.alert('Please select atleast one parameter.');
                                return false;
                            }
                        }
                    },
                    close: function () {
                        HoldOn.close();
                    },
                },
                onContentReady: function () {
                    $("#SelectPrintAll").click(function () {
                        if ($(this).prop("checked") == true)
                            $('#SelctCheck input:checkbox:not("#SelectPrintAll")').prop("checked", true);
                        else
                            $('#SelctCheck input:checkbox:not("#SelectPrintAll")').prop("checked", false);
                    });
                }
            });
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
                complete: function () {
                    //SendMailAction(Html);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //ajaxindicatorstop();
                    $.messager.alert(textStatus, "Error");
                }
            });
        }

        function GetBindingData(vartranno, selectedTemp, RedirectOpt) {// RedirectOpt added
            var mrNo = $.session.get('PatMRNO');
            var datatosend = {
                tranno: vartranno,//"06C170704NR0001"
                language: "" + $('#hdnlanguage').val(),
                type: 'L',  // to diaply prnint  only in english
                MrNo: mrNo,
            }
            var Html = "", HtmlTopData = "";
            $.ajax({
                type: "Post",
                url: "../DoctorDesk/GetDoctorDeskData",
                data: datatosend,
                async: false,
                success: function (response) {
                    infotomail = "", infotomail2 = "";
                    GetDoctSignature();
                    GridData = response;

                    if (selectedTemp == 'Temp_1') {
                        Html = PrintData1();
                    }
                    else if (selectedTemp == 'Temp_2') {
                        Html = PrintData2();
                    }
                    else if (selectedTemp == 'Temp_3') {
                        Html = PrintData3();
                    }
                    else {
                        Html = PrintData2();
                    }
                    HtmlTopData = PrintPatInfo();
                    infotomail = Html;
                    infotomail2 = HtmlTopData;
                    // PrintListAJAXCommon('<%:Url.Action("PrintPatientReport","DoctorDesk")%>', { strHtml: Html }, "ABDSKFLSDF", "");
                    <%--if (RedirectOpt != "EM" && '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DirectPrint")%>' == "Y") // Modified the condition by Murali on 07/08/2024--%>
                    if (RedirectOpt != "EM")
                        openWin(Html, HtmlTopData);

                    GridData = "";
                    //added by ashvini to get prescription  completed status on 15/11/2024
                    if (response.jsonUserdtls && response.jsonUserdtls.length > 0) {
                        if (response.jsonUserdtls[0].COMPLETEDYN != undefined)
                            completionstatus = response.jsonUserdtls[0].COMPLETEDYN;
                    }

                },
                complete: function () {
                    //SendMailAction(Html);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //ajaxindicatorstop();
                    //MsgDia(textStatus, "Error");

                }
            });
        }

        function SendMailAction() {
            if (infotomail == "") {
                $.messager.alert("Information", "Please Select Template");
                return false;
            }
            if (AllowMailBeforePrescriptionCompl == "N" && completionstatus != 'Y') {
                //This case is need to be here as this send email function is caling with this two criteria  Meenakshi added on 19/11/2024
                $.messager.alert("Information", "Prescription is not completed. Please click on below <i class='fa fa-check-circle' style='font-size: 20px; padding: 5px;'></i> to complete.");
                return false;
            }
            var tomail = ($.session.get('PatEmail'));
            if (tomail == "" || tomail == null) {
                PopupForMail();
            }
            else {
                Callajxmail(tomail)
            }
        };

        function Callajxmail(tomail) {
            HoldOn.open();
            //infotomail = infotomail.replace("<head>", "<head><div style='float:right;margin-bottom:10px' id='jupiterlogo1'><label id='loglab' style='font-size:20px'> Hospital</label><br><label>Eastern Express Highway,Thane(W) 400 601</label><br><label>Tel: 2172 5555</label><br><label>Web:www.jupiterhospital.com</label></div>");//text-transform: uppercase;
            //  if (infotomail.search("jupiterlogo1") == -1)
            //infotomail = infotomail.replace("<head>", "<head><div style='margin-bottom:10px;text-align: center;' id='jupiterlogo1'><label id='loglab' style='font-size:24px'> Hospital</label><br><label>Eastern Express Highway,Thane(W) 400 601</label><label> , Tel: 2172 5555</label></div>");//text-transform: uppercase;

            //to temp1 data we need to do code changes. Meenakshi
            //Temporary pass temp2 even if temp 1 is selected 
            if (formatclickd == 'Temp_1')
                formatclickd = "Temp_2";

            SaveFollowUpPrint(formatclickd, "EM");// 24-04-2020
            //infotomail = infotomail.replace("<div style='float:right;margin-bottom:10px' id='jupiterlogo1'></div>", "<div style='float:right;margin-bottom:10px' id='logo1'><img src='../Images/logo.jpg' /></div>");//text-transform: uppercase;
            // SignArr.push('../Images/nabh_accredited.jpg');
            // SignArr.push('../Images/logo.jpg');
            var Mrno = ($.session.get('PatMRNO'));
            if (Mrno != null && Mrno != undefined && Mrno != "") {
                var datatosend = {
                    printdata: encodeURIComponent(infotomail),
                    TranNo: ($.session.get('PatTRANNO')),
                    ToMailId: tomail,
                    Mrno: Mrno,
                    printdataTop: encodeURIComponent(infotomail2)
                    // SignArr1: SignArr
                };
                $.ajax({
                    type: "POST",
                    url: "../DoctorDesk/SendMailAction",
                    async: false,
                    data: datatosend,
                    dataType: "json",
                    success: function (response) {
                        HoldOn.close();
                        $.messager.alert("Information", response);
                    },
                    error: function () {
                        HoldOn.close();
                        alert('error');
                    }
                });
            }
            else {
                HoldOn.close();
                $.messager.alert("Kindly reselect this patient and try again. Your session got expired !!", response);
            }
        }

        function validateEmail(Toemail) {
            var field;
            var RslValStr;
            var regex = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (Toemail.indexOf(",") > 0) {
                field = Toemail.split(",");
                for (num = 0; num < field.length; num++) {
                    var email = field[num].replace(/[\r\n]+/gm, "");;
                    RslValStr = (regex.test(email)) ? true : false;
                    if (RslValStr == false)
                        return RslValStr;
                }
            }
            else {
                field = Toemail;
                RslValStr = (regex.test(field)) ? true : false;
            }
            return RslValStr
        }

        function openWin(HTML, HtmlTopData) {

            // GetSavedData();
            Html = HTML;
            HtmlTop = HtmlTopData;
            //$("a#btnTrandiv").click();

            OKbutton();
        }

        function BindingFancyRx(result) {
            var strPrindData = "";
            if (result.length > 0) {
                var flag = 0; var flagRoute = 0;
                $.each(result, function (key, value) {
                    if (value.DOSSAGE != "") {
                        flag = 1;
                        return false;
                    }
                });
                $.each(result, function (key, value) {
                    if (value.ROUTE != "") {
                        flagRoute = 1;
                        return false;
                    }
                });
                strPrindData += "<table style='width:100%;border-collapse:collapse;page-break-inside:avoid' border='1'>";
                strPrindData += "<caption style='font-size:40px;text-align:left' > &#x211E;</caption>";
                var Medicine = "";
                for (var i = 0; i < result.length; i++) {
                    var dosage = '';
                    var MDate = "";
                    var advicesplitVal = [];
                    var advicedayNum = '';
                    var IntakeRemark = '';
                    var Route = '';
                    Food = "";
                    var strConS = '';
                    var concateComma = '';
                    var genericNm = GeneralWiseYN == "Y" ? "" : result[i]["GENERICNAME"].toString() != "" ? "(" + result[i]["GENERICNAME"].toString() + ")" : "";
                    if (flag == 1)
                        dosage = (result[i]["DOSSAGE"] == "" || result[i]["DOSSAGE"] == "undefined") ? "" : result[i]["DOSSAGE"];
                    else
                        dosage = (result[i]["DOSSAGE"] == "" || result[i]["DOSSAGE"] == "undefined") ? "" : "-" + result[i]["DOSSAGE"];
                    if (flagRoute == 1)
                        Route = GetRoutText((result[i]["ROUTE"] == "" || result[i]["ROUTE"] == "undefined") ? "" : result[i]["ROUTE"]);
                    else
                        Route = GetRoutText((result[i]["ROUTE"] == "" || result[i]["ROUTE"] == "undefined") ? "" : "-" + result[i]["ROUTE"]);
                    intake = (result[i]["INTAKE"] == "" || result[i]["INTAKE"] == "undefined") ? "" : result[i]["INTAKE"].replace(/0.5/g, "1/2")
                    remark = GetRemarkText((result[i]["Remarks"] == "" || result[i]["Remarks"] == "undefined") ? "" : result[i]["Remarks"]);
                    intake = IntakeFunction(intake);
                    if (result[i]["ABFOOD"] == "A") {
                        Food = "<b>" + AfterFoodData + "</b>";
                    }
                    else if (result[i]["ABFOOD"] == "E") {
                        Food = "<b>" + BeforFoodData + "</b>";
                    }
                    if (Food != "" && remark != "") {
                        concateComma = ", "
                    }
                    MDate = result[i]["MEDSTARTDATE"].toString();
                    if (result[i]["DAYS"].length > 0) {
                        if (result[i]["DAYS"] == "C" || result[i]["DAYS"] == "S") {
                            if (result[i]["DAYS"] == "C") {
                                IntakeIndicator = result[i]["DAYS"];
                                IntakeRemark = checkInTakeStatement(IntakeIndicator, language)
                                if (flag == 1 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 0 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 1 && flagRoute == 0)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            }
                            else if (result[i]["DAYS"] == "S") {
                                IntakeIndicator = result[i]["DAYS"];
                                IntakeRemark = checkInTakeStatement(IntakeIndicator, language)
                                if (flag == 1 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 0 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 1 && flagRoute == 0)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            }
                        }
                        else if (result[i]["INTAKE"] == "SOS" || result[i]["INTAKE"] == "CONTD" || result[i]["INTAKE"] == "STAT") {
                            if (flag == 1 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 0 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 1 && flagRoute == 0)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        }
                        else {
                            day = (result[i]["DAYS"] == "" || result[i]["DAYS"] == "undefined") ? "" : "for " + result[i]["DAYS"]
                            if (day != "" || day != "undefined") {
                                advicedayNum = (day).replace(/[^0-9]+/ig, "");
                                advicedayNum = advicedayNum == 0 ? "-" : advicedayNum;
                                advicesplitVal = (day).split((day).replace(/[^0-9]+/ig, ""));
                                checkFollowUplanguge(advicesplitVal, language, 'I')
                                if (advicedayNum == '-')
                                    IntakeLanguage = "";
                                if (language == "NAME" && advicedayNum.length > 0) {
                                    if (Number(advicedayNum) > 1)
                                        strConS = 's'
                                }
                            }
                            if (flag == 1 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 0 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 1 && flagRoute == 0)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        }
                    }

                    else {
                        advicedayNum = "";
                        IntakeLanguage = "";
                        strConS = "";

                        if (flag == 1 && flagRoute == 1)
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        else if (flag == 0 && flagRoute == 1)
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        else if (flag == 1 && flagRoute == 0)
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        else
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                    }
                }
                var MedHeadLbl = GeneralWiseYN == "Y" ? "Generic Name" : "Medicine Name";
                if (flag == 1 && flagRoute == 1) {
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
                }
                else if (flag == 0 && flagRoute == 1) {
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:34%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";

                } else if (flag == 1 && flagRoute == 0) {
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:44%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
                }
                else
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:34%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:44%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
                strPrindData += "</table>";
                $("#tbldiv").append(strPrindData);

            }
        }

        function GetRoutText(Routcode) {//3-10-19
            if (Routcode != "") {
                var arry = JSON.parse(MedRoute.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));

                arry = jQuery.grep(arry, function (a) {
                    return a.Value == Routcode.toString().trim();
                });
                if (arry.length > 0) {
                    return arry[0].Text;
                } else {
                    return "";
                }
            } else {
                return "";
            }
        }

        function GetRemarkText(remarkcode) {//3-10-19
            if (remarkcode != "") {
                var arry = JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
                arry = jQuery.grep(arry, function (a) {
                    return a.Value == remarkcode.toString().trim();;
                });
                if (arry.length > 0) {
                    return arry[0].Text;
                } else {
                    return "";
                }

            } else {
                return "";
            }
        }

        //function PrintPatInfo() {
        //    var strPrindData = [];
        //    var Mrno = ($.session.get('PatMRNO'));
        //    var strTran = ($.session.get('PatTRANNO'));
        //    var patName = ($.session.get('PatName'));
        //    var strAge = Number(GridData.jsonUserdtls[0].PATAGE.split(":")[0]) > 0 ? Number(GridData.jsonUserdtls[0].PATAGE.split(":")[0]) +
        //        " Years" : Number(GridData.jsonUserdtls[0].PATAGE.split(":")[1]) > 0 ? Number(GridData.jsonUserdtls[0].PATAGE.split(":")[1]) +
        //        " Months" : Number(GridData.jsonUserdtls[0].PATAGE.split(":")[2]) + " Days"
        //    strPrindData.push("<table style='width:100%;margin-bottom:5px;border-collapse:collapse;font-family:cambria !important;;font-size: 13px !important;' id='tblPatInfo'>");
        //    strPrindData.push("<tr><td style='font-weight:bold'>Name</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].PATNAME +
        //        "<td style='font-weight:bold'>Age/Gender</td><td style='font-weight:bold'>:</td>");
        //    strPrindData.push("<td>" + strAge + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr><tr><td style='font-weight:bold'>MR No.</td><td style='font-weight:bold'>:</td><td>" + Mrno + "</td>");
        //    strPrindData.push("<td style='font-weight:bold'>Date/Time</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>");
        //    strPrindData.push("</tr><tr><td style='font-weight:bold'>Dr. Name</td><td style='font-weight:bold'>:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");
        //    strPrindData.push("</td><td style='font-weight:bold'>Consultation No.</td><td style='font-weight:bold'>:</td>");
        //    strPrindData.push("<td>" + strTran + "</tr>");
        //    if (GridData.jsonUserdtls[0].COCANAME != "") {
        //        strPrindData.push("<tr><td style='font-weight:bold'>Exemp Catg.</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].COCANAME + "</td>");
        //        if (GridData.jsonUserdtls[0].EMPID != "") {
        //            strPrindData.push("<td style='font-weight:bold'>Employee ID</td><td style='font-weight:bold'>:</td>");
        //            strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "<td></tr>");
        //        }
        //        else {
        //            strPrindData.push("<td style='font-weight:bold'>Exemp Proof</td><td style='font-weight:bold'>:</td>");
        //            strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "<td></tr>");
        //        }
        //    }
        //    strPrindData.push("</table>");
        //    return strPrindData.join("");
        //}

        function PrintPatInfo() {
            var strPrindData = [];
            var Mrno = ($.session.get('PatMRNO'));
            var strTran = ($.session.get('PatTRANNO'));
            var patName = ($.session.get('PatName'));
            var strAge = Number(GridData.jsonUserdtls[0].PATAGE.split(":")[0]) > 0 ? Number(GridData.jsonUserdtls[0].PATAGE.split(":")[0]) +
                " Years" : Number(GridData.jsonUserdtls[0].PATAGE.split(":")[1]) > 0 ? Number(GridData.jsonUserdtls[0].PATAGE.split(":")[1]) +
                " Months" : Number(GridData.jsonUserdtls[0].PATAGE.split(":")[2]) + " Days"
            strPrindData.push("<table style='width:100%;margin-bottom:5px;border-collapse:collapse;font-family:cambria !important;font-size: 13px !important;' id='tblPatInfo'>");
            strPrindData.push("<tr><td style='font-weight:bold'>Name</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].PATNAME + "</td>");
            strPrindData.push("<td style='font-weight:bold'>Age/Gender</td><td style='font-weight:bold'>:</td>");
            strPrindData.push("<td>" + strAge + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr>");
            strPrindData.push("<tr><td style='font-weight:bold'>MR No.</td><td style='font-weight:bold'>:</td><td>" + Mrno + "</td>");
            strPrindData.push("<td style='font-weight:bold'>Date/Time</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>");
            strPrindData.push("</tr><tr><td style='font-weight:bold'>Dr. Name</td><td style='font-weight:bold'>:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");
            strPrindData.push("<td style='font-weight:bold'>Consultation No.</td><td style='font-weight:bold'>:</td>");
            strPrindData.push("<td>" + strTran + "</td></tr>");
            if (GridData.jsonUserdtls[0].PATMOBILE.toString().trim() != "") {
                strPrindData.push("<td style='font-weight:bold'>Mobile No.</td><td style='font-weight:bold'>:</td>");
                strPrindData.push("<td>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>");
            }
            if (GridData.jsonUserdtls[0].PATEMAIL.toString().trim() != "") {
                strPrindData.push("<td style='font-weight:bold'>Email</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].PATEMAIL + "</td></tr>");
            }
            if (GridData.jsonUserdtls[0].PATADDRESS.toString().trim() != "") {
                strPrindData.push("<tr><td style='font-weight:bold'>Address</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].PATADDRESS + "</td></tr>");
            }
            if (GridData.jsonUserdtls[0].COCANAME != "") {
                strPrindData.push("<tr><td style='font-weight:bold'>Exemp Catg.</td><td style='font-weight:bold'>:</td><td>" + GridData.jsonUserdtls[0].COCANAME + "</td>");
                if (GridData.jsonUserdtls[0].EMPID != "") {
                    strPrindData.push("<td style='font-weight:bold'>Employee ID</td><td style='font-weight:bold'>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "</td></tr>");
                } else {
                    strPrindData.push("<td style='font-weight:bold'>Exemp Proof</td><td style='font-weight:bold'>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "</td></tr>");
                }
            }
            strPrindData.push("</table>");
            return strPrindData.join("");
        }

        function PrintData2() {
            var language = "NAME";
            if (language == "NAME") {
                HeaderLang = EnglishHeader;
                WAfter = " After"
            }
            var FollowUp = [];
            var Medicine = '';
            var Mrno = ($.session.get('PatMRNO'));
            var strTran = ($.session.get('PatTRANNO'));
            var patName = ($.session.get('PatName'));
            var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
            var gRelation = {
                '01': 'Father', '02': 'Mother', '03': 'Wife',
                '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
                '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
                '11': 'Paternal Aunt' //Added the options from 8 - 11 by Murali on 11/04/2024 as per client request. (Ticket : 2528)
            };

            var strPrindData = [];
            strPrindData.push("<html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'/>");
            strPrindData.push(" <style>.cltable {border-collapse: collapse;font-family:Gautami cambria !important} table.cltable td, th {border: 1px solid #ddd;text-align: left;font-family:cambria !important;} .HTextsize{font-size: 13px !important ;padding:3px;font-family:cambria !important;} .DTextsize{font-size: 15px !important;font-family:cambria !important;} .inHeight{line-height:15px !important;font-family:cambria !important;}  @page {margin-top: 4cm;margin-bottom: 3cm; } @media print {body {margin-top: 0mm; margin-bottom: 0mm;  margin-left: 0mm; margin-right: 0mm } #footer{display: block;page-break-after: always; bottom:0;margin-top: 25pt; } } #tblPatInfo td{padding: 1px; white-space:nowrap;font-family:cambria !important;} table { page-break-inside:auto;font-family:cambria !important; } table { page-break-inside:auto;font-family:cambria !important; } table { page-break-inside:auto } tfoot { display:table-footer-group } </style></head>");
            strPrindData.push("<body style='margin-left:25;font-family:Gautami cambria !important;font-size: 1.1em !important'>");
            var label = "Patient Category";
            // var Patcatg = $('#spPatcatgnm')[0].textContent;
            var Patcatg = "";
            var doctName = "";
            ////User Details/////

            //strPrindData.push("<table style='width:100%;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px;border-collapse:collapse;font-family:cambria header !important;font-size: 13.5px !important;' id='tblPatInfo'>");
            ////3/27/19 font size nd family
            //strPrindData.push("<tr><td>Name</td><td>:</td><td>" + GridData.jsonUserdtls[0].PATNAME +
            //    "<td>Age/Gender</td><td>:</td>");
            //strPrindData.push("<td>" + (GridData.jsonUserdtls[0].PATAGE).toString().substring(0, 3) + ' ' + 'Years' + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr><tr><td>MR No.</td><td>:</td><td>" + Mrno + "</td>");
            ////3/27/19 Dr->mrno
            //strPrindData.push("<td>Date/Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>");//3/27/19 gap reduced
            //strPrindData.push("</tr><tr><td>Dr. Name</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
            ////3/27/19 mrno->Dr
            //strPrindData.push("</td><td>Consultn. No.</td><td>:</td>");//3/27/19 changd the name
            //strPrindData.push("<td>" + strTran + "</tr>");//<td class='HTextsize'>Doctor Name</td>
            ////Meenakshi To add exemption and emp ID
            //if (GridData.jsonUserdtls[0].COCANAME != "") {
            //    strPrindData.push("<tr><td>Exemp Catg.</td><td >:</td><td>" + GridData.jsonUserdtls[0].COCANAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
            //    if (GridData.jsonUserdtls[0].EMPID != "") {
            //        strPrindData.push("<td>Employee ID</td><td>:</td>");
            //        strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "<td></tr>");
            //    }
            //    else {
            //        strPrindData.push("<td>Exemp Proof</td><td>:</td>");
            //        strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "<td></tr>");
            //    }
            //}
            //strPrindData.push("</table>");

            //Chief Complaints
            strPrindData.push("<div class='row'>")

            if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
                strPrindData.push("<br><div class='col-md-6'>")
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[0] + " </u>: </label>");
                strPrindData.push("<table>");
            }

            if (GridData.jsonComplaints.length > 0) {
                for (var i = 0; i < GridData.jsonComplaints.length; i++) {
                    var TotalDuration = "";
                    var dur = "" + GridData.jsonComplaints[i].DURATION
                    var durtype = GridData.jsonComplaints[i].DURTYPE
                    if (dur.length > 0) {
                        if (Number(dur) > 0) {
                            TotalDuration = "  since " + dur + " " + DurationTypeSelect(durtype, dur)
                        }
                    }

                    //added on 6th april 2018
                    var rmrk = "";
                    if (GridData.jsonComplaints[i].REMARKS != "") {
                        rmrk = " " + GridData.jsonComplaints[i].REMARKS + "";
                    }
                    //------------------------------------------

                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonComplaints[i].NAME + " " + TotalDuration + " " + rmrk.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    //

                }
            }

            //free complaint vijeta 20th march 19
            if (GridData.jsonFreeComplaints.length > 0) {
                if (GridData.jsonFreeComplaints[0].hasOwnProperty("FREECOMPLAINT")) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeComplaints[0].FREECOMPLAINT.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
            }

            if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
                strPrindData.push("</table>");
                strPrindData.push("</div>")
            }
            //COMPLAINT END
            //Other History
            if (GridData.jsonPastHist.length > 0) {
                if (GridData.jsonPastHist[0]["PASTHIST"] !== "") {
                    strPrindData.push("<br><table>")
                    if (HeaderLang[20] != "")
                        strPrindData.push("<tr><td><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[20] + "</u>:</label></td></tr>");
                    //strPrindData.push("<tr><td><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonPastHist[0]["PASTHIST"].replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</label>" + "</td>");
                    strPrindData.push("<tr><td><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonPastHist[0]["PASTHIST"].replace(/\n/g, '<br />') + "</label>" + "</td>");
                    strPrindData.push("</tr>");
                    strPrindData.push("</table>")
                }
            }
            //Other History END
            if (printWithHistory == "Y") {

                //medical history start
                if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {
                    // if (GridData.jsonPersonalHist.length == 0 && GridData.jsonFreePersonal.length == 0)
                    strPrindData.push("<br><div style='width:100%' id='divMedicalHist'>");
                    //else
                    // strPrindData.push("<br><div style='float:right;width:40%;padding-bottom:10%' id='divMedicalHist'>");
                }
                if (GridData.jsonMedicineHist.length > 0) {
                    strPrindData.push("<table id='medicalHistTable' style='border-collapse:collapse;width:100%;font-size:13px !important' >");
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[13] + " :</u></caption>")
                    for (var i = 0; i < GridData.jsonMedicineHist.length; i++) {
                        //strPrindData.push("<tr><td><li>" + " <b>" + GridData.jsonMedicineHist[i].NAME + "</b>");
                        strPrindData.push("<tr><td><li>" + GridData.jsonMedicineHist[i].NAME);
                        if (GridData.jsonMedicineHist[i].DURATION != "" && GridData.jsonMedicineHist[i].DURATION != 0)
                            strPrindData.push(" since " + GridData.jsonMedicineHist[i].DURATION.toString() + " " + gDurType[GridData.jsonMedicineHist[i].DURTYPE] + "(s)");
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                //free medical history
                if (GridData.jsonFreeMedical != "") {
                    strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:13px !important' class='tblFree'>");
                    if (GridData.jsonMedicineHist.length == 0) {
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[13] + " :</u></caption>")
                    }
                    for (var i = 0; i < GridData.jsonFreeMedical.length; i++) {

                        strPrindData.push("<tr><td><li>" + GridData.jsonFreeMedical[i].MEDHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {
                    strPrindData.push("</div>");
                }

                strPrindData.push("</div>");/// end personalNMediDiv

                //family history start
                if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0) {

                    if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0)
                        strPrindData.push("<br /><div id='familyHistDiv'>");
                    //strPrindData.push("<label class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></label>")
                }
                if (GridData.jsonFamilyHist.length > 0) {
                    strPrindData.push("<table id='familyHistTable' style='width:100%;width:100%;border-collapse:collapse;' class='DTextsize'>");// 4/8/19border color added by vijeta on 19th march 2018s
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></caption>")
                    for (var i = 0; i < GridData.jsonFamilyHist.length; i++) {
                        var DiseaseStatus = GridData.jsonFamilyHist[i].DISEASESTATUS != "" ? (" - " + GridData.jsonFamilyHist[i].DISEASESTATUS.trim()) : "";
                        var DiagDate = GridData.jsonFamilyHist[i].DIAGNOSEDDATE != "" ? (" (" + GridData.jsonFamilyHist[i].DIAGNOSEDDATE.trim() + ")") : "";
                        //if (GridData.jsonFamilyHist[i].DURATION != 0) {
                        //    strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                        //               GridData.jsonFamilyHist[i].DISEASES + "</b> since " + GridData.jsonFamilyHist[i].DURATION + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)");
                        //}
                        //else {
                        //    if (GridData.jsonFamilyHist[i].AGE > 0) {
                        //        strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                        //                        GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                        //    }
                        //    else {
                        //        strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " suffering with <b>" +
                        //                           GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                        //    }
                        //}
                        if (GridData.jsonFamilyHist[i].DURATION != 0) {
                            strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with " +
                                       GridData.jsonFamilyHist[i].DISEASES + " since " + GridData.jsonFamilyHist[i].DURATION + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)" + DiseaseStatus + DiagDate);
                        }
                        else {
                            if (GridData.jsonFamilyHist[i].AGE > 0) {
                                strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with " +
                                                GridData.jsonFamilyHist[i].DISEASES + DiseaseStatus + DiagDate);
                            }
                            else {
                                strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " suffering with " +
                                                   GridData.jsonFamilyHist[i].DISEASES + DiseaseStatus + DiagDate);
                            }
                        }
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");

                    // strPrindData.push("<br>");
                }
                //free family history
                if (GridData.jsonFreeFamily != "") {
                    strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:13px !important' class='tblFree'>");
                    if (GridData.jsonFamilyHist.length == 0) {
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></caption>")
                    }
                    for (var i = 0; i < GridData.jsonFreeFamily.length; i++) {

                        strPrindData.push("<tr><td class='DTextsize'><li>" + GridData.jsonFreeFamily[i].FAMHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0) {
                    strPrindData.push("</div><br>");
                }

                strPrindData.push("<div id='personalNMediDiv'>");

                if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {

                    strPrindData.push("<div style='width:100%' id='divPersonalHist'>");
                }
                if (GridData.jsonPersonalHist.length > 0) {
                    strPrindData.push("<table id='personalHistTable' style='border-collapse:collapse;width:100%;font-size:13px !important'  >");// border color added by vijeta on 19th march 2018
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                    for (var i = 0; i < GridData.jsonPersonalHist.length; i++) {
                        strPrindData.push("<tr><td><li>" + " " + GridData.jsonPersonalHist[i].NAME);
                        //strPrindData.push("<tr><td><li>" + " <b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                        if (GridData.jsonPersonalHist[i].STOPAGE != 0) {
                            if (GridData.jsonPersonalHist[i].STARTAGE != "")
                                var dur = "";

                            dur = GridData.jsonPersonalHist[i].STARTAGE == "Y" ? "Year(s)" : GridData.jsonPersonalHist[i].STARTAGE == "M" ? "Month(s)" :
                                    GridData.jsonPersonalHist[i].STARTAGE == "D" ? "Day(s)" : GridData.jsonPersonalHist[i].STARTAGE;
                            strPrindData.push(" since of " + GridData.jsonPersonalHist[i].STOPAGE + " " + dur);
                        }
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                //free personal history
                if (GridData.jsonFreePersonal != "") {
                    strPrindData.push("<table style='border-collapse:collapse;width:100%;font-size:13px !important' class='tblFree'>");
                    if (GridData.jsonPersonalHist.length == 0) {
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                    }
                    for (var i = 0; i < GridData.jsonFreePersonal.length; i++) {

                        strPrindData.push("<tr><td><li>" + GridData.jsonFreePersonal[i].PERSHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                    strPrindData.push("</div>");
                }

            }

            if (GridData.jsonAllergy.length > 0) {
                strPrindData.push("<br /><table id='AllergyTable' >");
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>Allergy</u>:</caption>");
                for (var i = 0; i < GridData.jsonAllergy.length; i++) {
                    var AllgryDurType = GridData.jsonAllergy[i].DURTYPE == "D" ? "Days" : (GridData.jsonAllergy[i].DURTYPE == "W" ? "Week" : GridData.jsonAllergy[i].DURTYPE == "M" ? "Month" : GridData.jsonAllergy[i].DURTYPE == "Y" ? "Year" : "")
                    var AllgryDur = GridData.jsonAllergy[i].DURATION != "" && Number(GridData.jsonAllergy[i].DURATION) > 0 ? GridData.jsonAllergy[i].DURATION : "";
                    //strPrindData.push("<tr><td class='DTextsize' style='font-size:13px !important;'><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");
                    strPrindData.push("<tr><td class='DTextsize' style='font-size:13px !important;'><li>" + GridData.jsonAllergy[i].ALLERGYTYPE + " Allergy - " + GridData.jsonAllergy[i].NAME + (AllgryDur != "" ? (" For " + AllgryDur + " " + AllgryDurType) : ""));
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            //end of allergy


            //Vitals start       
            if (GridData.jsonVital.length > 0) {

                //strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align=top'><u>" + HeaderLang[1] + " </u>: </label>")

                var flag = false;
                var stopAfterBMI = false;//Priyanka 26/12/2025
                $.each(GridData.jsonVital[0], function (i, val) {

                    if (i == "WEIGHT" && Number(val) > 0)
                        flag = true;
                    if (i == "HEIGHT" && Number(val) > 0)
                        flag = true;
                    if (i == "TEMP" && Number(val) > 0)
                        flag = true;
                    if (i == "PULSE" && Number(val) > 0)
                        flag = true;
                    if (i == "RESP" && val.length > 0)
                        flag = true;
                    if (i == "BP" && val.length > 0)
                        flag = true;
                    if (i == "SPO2" && val.length > 0)
                        flag = true;

                    if (i == "BMI" && val.length > 0)
                        flag = true;
                    if (i == "HEADCIRCMF" && val.length > 0)
                        flag = true;
                    if (i == "PEFR" && val.length > 0)
                        flag = true;
                    if (i == "Technique" && val != "N")
                        flag = true;
                    if (i == "Compliance" && val != "N")
                        flag = true;
                    if (i == "BSA" && val != "")
                        flag = true;
                    if (i == "RBS" && val != "")
                        flag = true;
                    if (i == "KARNOFSKY" && val != "")
                        flag = true;
                    if (i == "ECOG" && val != "")
                        flag = true;
                    if (i == "IBW" && val.length > 0)
                        flag = true;
                    if (i == "BWPERC" && val.length > 0)
                        flag = true;
                    if (i == "WAISTCIRCUM" && val.length > 0)
                        flag = true;
                    if (i == "HIPCIRCUM" && val.length > 0)
                        flag = true;
                    if (i == "WHR" && val.length > 0)
                        flag = true;
                });

                if (flag) {
                    strPrindData.push("<br><div class='col-md-6'>");
                    strPrindData.push("<table class='DTextsize' style='border-collapse: separate; border-spacing: 3px;width:100%;'>")
                    strPrindData.push("<tr  class='inHeight'>")
                    strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align=top'><u>" + HeaderLang[1] + " </u>: </label>");
                }

                if (GridData.jsonVital[0].hasOwnProperty("WEIGHT")) {
                    if (Number(GridData.jsonVital[0]["WEIGHT"]) > 0)//GridData.jsonVital[0]["WEIGHT"].length
                        strPrindData.push("<td class='DTextsize'>Weight: " + GridData.jsonVital[0]["WEIGHT"] + " kg</td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("HEIGHT")) {
                    if (Number(GridData.jsonVital[0]["HEIGHT"]) > 0)//GridData.jsonVital[0]["HEIGHT"].length
                        strPrindData.push("<td class='DTextsize'>Height : " + GridData.jsonVital[0]["HEIGHT"] + " cm</td>")
                }


                //BMI
                if (GridData.jsonVital[0].hasOwnProperty("BMI")) {
                    if (GridData.jsonVital[0]["BMI"].length > 0)
                        strPrindData.push("<td class='DTextsize'>BMI : " + GridData.jsonVital[0]["BMI"] + " kg/(m²)</td>");
                    if (ShowVitalsInPrescPrintYN === "N") {
                        stopAfterBMI = true;//Priyanka 26/12/2025
                    }

                }

                if (!stopAfterBMI) {//Priyanka 26/12/2025
                    if (GridData.jsonVital[0].hasOwnProperty("TEMP")) {
                        if (Number(GridData.jsonVital[0]["TEMP"]) > 0)//GridData.jsonVital[0]["TEMP"].length 
                            strPrindData.push("<td class='DTextsize'>Temperature : " + GridData.jsonVital[0]["TEMP"] + " °F</td>")
                    }

                    strPrindData.push("</tr>")
                    strPrindData.push("<tr class='inHeight'>")
                    if (GridData.jsonVital[0].hasOwnProperty("PULSE")) {
                        if (Number(GridData.jsonVital[0]["PULSE"]) > 0) {
                            strPrindData.push("<td class='DTextsize'>Pulse : " + GridData.jsonVital[0]["PULSE"] + " bpm");

                            if (GridData.jsonVital[0]["PULSECOND"] == "R")
                                strPrindData.push(" (Regular)");
                            else if (GridData.jsonVital[0]["PULSECOND"] == "I")
                                strPrindData.push(" (Irregular)");
                        }
                        strPrindData.push("</td>");

                    }

                    if (GridData.jsonVital[0].hasOwnProperty("RESP")) {
                        if (Number(GridData.jsonVital[0]["RESP"]) > 0)//GridData.jsonVital[0]["RESP"].length
                            strPrindData.push("<td class='DTextsize'>RR : " + GridData.jsonVital[0]["RESP"] + " Breaths/Minutes</td>")
                    }

                    if (GridData.jsonVital[0].hasOwnProperty("BP")) {
                        if (GridData.jsonVital[0]["BP"].length > 0)//
                            strPrindData.push("<td class='DTextsize'>BP : " + GridData.jsonVital[0]["BP"] + " mmHg</td>")
                    }

                    if (GridData.jsonVital[0].hasOwnProperty("BSA")) {
                        if (GridData.jsonVital[0]["BSA"].length > 0)//
                            strPrindData.push("<td class='DTextsize'>BSA : " + GridData.jsonVital[0]["BSA"] + " m²</td>")
                    }

                    strPrindData.push("</tr>")
                    strPrindData.push("<tr>")
                    if (GridData.jsonVital[0].hasOwnProperty("SPO2")) {//added on 5thMarch2019
                        if (GridData.jsonVital[0]["SPO2"].length > 0)
                            strPrindData.push("<td class='DTextsize'>SpO2 : " + GridData.jsonVital[0]["SPO2"] + " %</td>")
                    }

                    if (GridData.jsonVital[0].hasOwnProperty("PAINSCORE")) {
                        if (GridData.jsonVital[0]["PAINSCORE"].length > 0)//
                            strPrindData.push("<td class='DTextsize'>Pain Score : " + GridData.jsonVital[0]["PAINSCORE"] + "  </td>")
                    }

                    if (GridData.jsonVital[0].hasOwnProperty("RBS")) {
                        if (GridData.jsonVital[0]["RBS"].length > 0)//
                            strPrindData.push("<td class='DTextsize'>RBS : " + GridData.jsonVital[0]["RBS"] + " mg/dl</td>")
                    }

                    if (GridData.jsonVital[0].hasOwnProperty("KARNOFSKY")) {
                        if (GridData.jsonVital[0]["KARNOFSKY"].length > 0)
                            strPrindData.push("<td class='DTextsize'>Karnofsky Score : " + GridData.jsonVital[0]["KARNOFSKY"] + "  %</td>")
                    }

                    strPrindData.push("</tr>");

                    strPrindData.push("<tr>");

                    if (GridData.jsonVital[0].hasOwnProperty("ECOG")) {
                        if (GridData.jsonVital[0]["ECOG"].length > 0)//
                            strPrindData.push("<td class='DTextsize'>ECOG Score : " + GridData.jsonVital[0]["ECOG"] + "  </td>")
                    }

                    if (GridData.jsonVital[0].hasOwnProperty("PEFR")) {
                        if (GridData.jsonVital[0]["PEFR"].length > 0)
                            strPrindData.push("<td class='DTextsize'>PEFR : " + GridData.jsonVital[0]["PEFR"] + " li/min</td>")
                    }
                    if (GridData.jsonVital[0].hasOwnProperty("Technique")) {
                        if (GridData.jsonVital[0]["Technique"] != 'N')
                            strPrindData.push("<td class='DTextsize'>Technique : " + GridData.jsonVital[0]["Technique"] + "</td>")
                    }
                    if (GridData.jsonVital[0].hasOwnProperty("Compliance")) {
                        if (GridData.jsonVital[0]["Compliance"] != 'N')
                            strPrindData.push("<td class='DTextsize'>Compliance : " + GridData.jsonVital[0]["Compliance"] + " </td>")
                    }
                    strPrindData.push("</tr>");

                    strPrindData.push("<tr>");

                    if (GridData.jsonVital[0].hasOwnProperty("IBW")) {
                        if (GridData.jsonVital[0]["IBW"].length > 0)//
                            strPrindData.push("<td class='DTextsize'>IBW : " + GridData.jsonVital[0]["IBW"] + "  </td>")
                    }
                    if (GridData.jsonVital[0].hasOwnProperty("BWPERC")) {
                        if (GridData.jsonVital[0]["BWPERC"].length > 0)
                            strPrindData.push("<td class='DTextsize'>BW % : " + GridData.jsonVital[0]["BWPERC"] + " </td>")
                    }
                    if (GridData.jsonVital[0].hasOwnProperty("WAISTCIRCUM")) {
                        if (GridData.jsonVital[0]["WAISTCIRCUM"].length > 0)
                            strPrindData.push("<td class='DTextsize'>Waist Circumference : " + GridData.jsonVital[0]["WAISTCIRCUM"] + " cm</td>")
                    }
                    if (GridData.jsonVital[0].hasOwnProperty("HIPCIRCUM")) {
                        if (GridData.jsonVital[0]["HIPCIRCUM"].length > 0)
                            strPrindData.push("<td class='DTextsize'>Hip Circumference : " + GridData.jsonVital[0]["HIPCIRCUM"] + " cm</td>")
                    }
                    strPrindData.push("</tr>");
                    strPrindData.push("<tr>");

                    if (GridData.jsonVital[0].hasOwnProperty("WHR")) {
                        if (GridData.jsonVital[0]["WHR"].length > 0)//
                            strPrindData.push("<td class='DTextsize'>WHR : " + GridData.jsonVital[0]["WHR"] + "  </td>")
                    }
                    strPrindData.push("</tr>");


                    strPrindData.push("<tr>");
                    if (GridData.jsonVital[0].hasOwnProperty("VOTHERS")) {

                        if (GridData.jsonVital[0]["VOTHERS"].length > 0)
                            strPrindData.push("<td class='DTextsize'>VOTHERS : " + GridData.jsonVital[0]["VOTHERS"] + "</td>")


                        if (GridData.jsonVital[0].hasOwnProperty("HEAD_CIRCUMFERENCE")) {
                            if (GridData.jsonVital[0]["HEAD_CIRCUMFERENCE"].length > 0)
                                strPrindData.push("<td class='DTextsize'>Head Circumference : " + GridData.jsonVital[0]["HEAD_CIRCUMFERENCE"] + " cm</td>")
                        }
                    }
                }

                strPrindData.push("</tr></table>");
                strPrindData.push("</div>")
            }
            strPrindData.push("</div>");

            //Clinical Notes start
            if (GridData.jsonClinicalHist.length > 0 || GridData.jsonClinicalHist.length > 0) {
                strPrindData.push("<br><label class='HTextsize' style='font-weight:bold'><u>Clinical Notes </u>: </label>")
                strPrindData.push("<table>");
                if (GridData.jsonClinicalHist.length > 0) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'>" + GridData.jsonClinicalHist[0].CLINICALHIST.toString().replace(/\n/g, '<br />') + "</td></tr>");
                }
                strPrindData.push("</table>")
            }
            //Clinical Notes End

            //Exam start
            if (GridData.jsonExam[0]["EXAM"] !== "") {
                strPrindData.push("<br>")
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[10] + "</u>: </label><br><p class='DTextsize' style='padding:5px!important;word-wrap: break-word;'>" + GridData.jsonExam[0]["EXAM"].replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p>"); //.replace(/\n/g, '<br />') added by vijeta on 14th march 2018
            }

            if (GridData.ExamImagePath.length > 0) {
                strPrindData.push("<table id='Imagedata'>")
                //strPrindData.push("<table style='width:60%;'><tr><td><label class='HTextsize' style='font-weight:bold;'>")//3/27/19 added

                var strmrno = ($.session.get('PatMRNO')).toString();
                var strtranNo = ($.session.get('PatTRANNO')).toString();

                datatosend = {
                    MrNo: strmrno,
                    TranNo: strtranNo
                }
                $.ajax({
                    type: 'POST',
                    url: 'RetriveExamImages',
                    data: datatosend,
                    async: false,
                    success: function (ImageData) {

                        if (ImageData.length > 0) {
                            var i = ImageData.length;
                            $.each(ImageData, function (index, element) {
                                var imageStr = "";
                                if ((index % 2 == 0)) {
                                    strPrindData.push("<tr>");
                                }

                                var fileNo = element.split("|");
                                var strUrl = "data:[<media type>];charset=utf-8;base64," + fileNo[1];

                                imageStr += '<td><img id=' + fileNo[0] + ' src="' + strUrl + '" alt="no image found" style="width:350px;height:300px; margin:4px;">';
                                imageStr += '</td>';

                                strPrindData.push(imageStr);

                                if ((index % 2 != 0)) {
                                    strPrindData.push("</tr>");
                                }
                            })
                        }
                        else {

                            imageStr += '<tr><td></td></tr>'
                        }
                    },
                    complete: function () {
                        HoldOn.close();
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                        HoldOn.close();
                    }
                });

                strPrindData.push("</table>");
            }
            //Exam end

            //Diagnosis start
            if (GridData.jsonFollowUp[0]["PROVDIAG"].toString().trim() != "")
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[19] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PROVDIAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            if (GridData.jsonFollowUp[0]["SITE"].toString().trim() != "")
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Site</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SITE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            if (GridData.jsonFollowUp[0]["SUBSITE"].toString().trim() != "")
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Sub Site</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SUBSITE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            //Added By Rajan - To Get the TNM List 
            if (GridData.jsonFollowUp[0]["TSTAGE"].toString().trim() != "" || GridData.jsonFollowUp[0]["NSTAGE"].toString().trim() != "" || GridData.jsonFollowUp[0]["MSTAGE"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>TNM</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
                //strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>TNM Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
                strPrindData.push("<td style='align:left'>T : <label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["TSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>N : <label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["NSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>M : <label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["MSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("</tr></table>");
            }

            if (GridData.jsonFollowUp[0]["COMPOSTAG"].toString().trim() != "")
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Stage</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            //strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Composit Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            if (GridData.jsonDiagnosis.length > 0) {
                // strPrindData.push("<br><label class='HTextsize' style='font-weight:bold;vertical-align=top'><u>Diagnosis</u>: </label>")
                if (GridData.jsonICDiagnosis.length <= 0) {
                    strPrindData.push("<br><table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
                } else {
                    strPrindData.push("<br><table style='width:50%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
                }

                // strPrindData.push("<table style='width:100%'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Diagnosis</u>: </label></td></tr>");
                for (var i = 0; i < GridData.jsonDiagnosis.length; i++) {
                    if (GridData.jsonDiagnosis[i].NAME.trim() != "") {
                        var DiagRemark = "";
                        if (GridData.jsonDiagnosis[i].REMARKS != "") {
                            DiagRemark = " " + " - " + GridData.jsonDiagnosis[i].REMARKS.toString()
                        }
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    }
                }
                strPrindData.push("</table>");
            }
            //Diagnosis end

            //ICDiagnosis..................................
            if (GridData.jsonICDiagnosis.length > 0) {


                if (GridData.jsonDiagnosis.length <= 0) {
                    strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")

                } else {
                    strPrindData.push("<table style='width:50%;float:right'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")

                }
                // strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align:top'><u>Diagnosis</u>: </label>")
                //strPrindData.push("<table style='width:100%'>");//3/27/19 commntd


                // width chngd the width nd remvd float
                for (var i = 0; i < GridData.jsonICDiagnosis.length; i++) {
                    var DiagRemark = "";

                    //if (GridData.jsonICDiagnosis[i].REMARKS != "") {
                    //    DiagRemark = " " + " - " + GridData.jsonICDiagnosis[i].REMARKS
                    //}
                    // strPrindData.push("<tr style='line-height:15px;'><td class='DTextsize' style='padding:5px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark + "</li></td></tr>");//3/27/19 commntd
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDiagnosis[i].NAME + "</li></td></tr>");
                    //
                }
                strPrindData.push("</table>");
                //strPrindData.push("<br>");//3/27/19 commntd
            }


            //ICDiagnosis end..................................

            //ICDO Diagnosis..................................
            //if (GridData.jsonICDODiagnosis.length > 0) {
            //    strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICDO Diagnosis</u>: </label></td></tr>")
            //    for (var i = 0; i < GridData.jsonICDODiagnosis.length; i++) {
            //        var DiagRemark = "";
            //        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDODiagnosis[i].NAME + "</li></td></tr>");
            //    }
            //    strPrindData.push("</table>");
            //}

            if (GridData.jsonICDOTopology.length > 0) {
                var ICDOTbl = ICDOTable(GridData.jsonICDOTopology, GridData.jsonICDOHistology);
                strPrindData.push(ICDOTbl);
            }

            //Medicine advice start 
            if (GridData.jsonAdvice.length > 0) {
                var medRxTbl = RxTable();
                strPrindData.push(medRxTbl);
            }
            //medicine advice end

            //Investigation start        
            if (GridData.jsonInvstg.length > 0 || GridData.jsonFreeInvestigation.length > 0) {
                strPrindData.push("<br><table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[4] + "</u>: </label><td></tr>")
                //4/16/19 table tag added
            }

            if (GridData.jsonInvstg.length > 0) {
                for (var i = 0; i < GridData.jsonInvstg.length; i++) {
                    //added on 6th april 2018
                    var TotalDuration = "";
                    var dur = "" + GridData.jsonInvstg[i].DURATION
                    var durtype = GridData.jsonInvstg[i].DURTYPE
                    if (dur.length > 0) {
                        if (Number(dur) > 0) {
                            TotalDuration = "  perform after" + dur + " " + DurationTypeSelect(durtype, dur)
                        }
                    }

                    //------------------------------------------
                    if (GridData.jsonInvstg[i].REMARK.toString() != "") {
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>"
                            + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />') + " - " + GridData.jsonInvstg[i].REMARK.toString() + " " +
                            TotalDuration + "</li></td></tr>");
                    }
                    else {
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>"
                           + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />') + " " +
                           TotalDuration + "</li></td></tr>");
                    }
                }
            }

            //vijeta 20th march 19
            if (GridData.jsonFreeInvestigation.length > 0) {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonFreeInvestigation[0].FREEINVESTIGATION.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
            }
            strPrindData.push("</table>")
            // }

            //Investigation end

            //Patient Advice start
            if (GridData.jsonPatientAdvice.length > 0 || GridData.jsonFreeAdvice.length > 0) {
                strPrindData.push("<br><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[3] + " </u>: </label>")
                strPrindData.push("<table>");
                if (GridData.jsonFreeAdvice.length > 0) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeAdvice[0].FREEADVICE.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
                for (var i = 0; i < GridData.jsonPatientAdvice.length; i++) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonPatientAdvice[i].NAME.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
                strPrindData.push("</table>")
            }

            //Patient Advice end

            //folowup start         
            var dt = "", refDoct = "", AdmAdvDate = "";
            if (GridData.jsonFollowUp.length > 0) {
                var dayNum = "", constString = "";
                refDoct = GridData.jsonFollowUp[0]["REFDOCT"];
                refSpecilist = GridData.jsonFollowUp[0]["REFSPECIALIST"];
                AdmAdvDate = GridData.jsonFollowUp[0]["PROPADMNDT"].toString();
                for (var e = 0; e < GridData.jsonFollowUp.length; e++) {
                    if (GridData.jsonFollowUp[0]["SURGNMADVICE"] != "") {
                        //strPrindData.push("<br>");
                        //strPrindData.push("<table style='width:100%;'>");
                        //strPrindData.push("<tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><u><label class='HTextsize' style='font-weight:bold'>Surgery Advice</label><u></td>");
                        //strPrindData.push("<td style='vertical-align:top;'><b>:</b>&nbsp;&nbsp</td><td><label class='DTextsize'>" + GridData.jsonFollowUp[0]["SURGNMADVICE"].toString().replace(/\n/g, '<br />') + "</label></td></tr>")
                        //strPrindData.push("</table>");
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Adviced Date</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SURGADVDATE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Adviced</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SURGNMADVICE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>PAC on or before</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PACADVDATE"].toString() + "</label></td></tr></table>");
                    }

                    if (refDoct.length > 0) {
                        // strPrindData.push("<br>");
                        var array = refDoct.split(',');
                        if (GridData.jsonFollowUp[e].FOLLOWUPDT.length >= 0) {
                            strPrindData.push("<table style='width:100%;margin-top:15px'><tr>")
                        }
                        strPrindData.push("<td style='width:25%;margin-top:0px;padding:1px;align:left;vertical-align:top;'><label style='font-weight:bold' class='HTextsize'><u>" + HeaderLang[11].toString() + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><ul style='margin-left:-30px'>");
                        $.each(array, function (index, val) {
                            if (val != "")
                                strPrindData.push("&#9679;<li style='display: inline;font-size:13px !important;list-style:circle'>Dr. " + val.replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                        });
                        strPrindData.push("</ul></td>");
                        strPrindData.push("</tr></table>")
                    }

                    if (refSpecilist.length > 0) {
                        //strPrindData.push("<br>");
                        var arraySpec = refSpecilist.split(',');
                        if (GridData.jsonFollowUp[e].FOLLOWUPDT.length >= 0) {
                            strPrindData.push("<table style='width:100%;'><tr>");
                        }
                        strPrindData.push("<td style='width:25%;vertical-align:top;'><label style='font-weight:bold' class='HTextsize'><u>" + HeaderLang[15] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><ul style='margin-left:-30px'>");
                        $.each(arraySpec, function (index, val) {
                            if (val != "")
                                strPrindData.push("&#9679;<li style='display: inline;list-style:circle;font-size:13px !important;'>" + val.replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                        });
                        strPrindData.push("</ul></td>");
                        strPrindData.push("</tr><table>")
                        //strPrindData.push("<table>");
                        //strPrindData.push("<tr class='inHeight'><td><u><label class='HTextsize' style=';font-weight:bold'>Refer to Specialist : </label><u></td><td><label class='DTextsize'>" + refSpecilist + "</label></td></tr>");
                        //strPrindData.push("</table><br>")
                    }


                    if (GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().trim() != "")
                        strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[18] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    //added on 13th march 19 for prescription remark
                    var remark = GridData.jsonFollowUp[0]["REMARK"];
                    if (remark != "")
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[16] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'> <label class='HTextsize' style='left-margin:10px;font-size:13px !important;'>" + remark.toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    var adviceInv = ""
                    if (GridData.jsonFollowUp[e].FOLLOWUPDT.length > 0) {
                        dayNum = (GridData.jsonFollowUp[e].FOLLOWUPDT).replace(/[^0-9]+/ig, "");
                        FollowUp = (GridData.jsonFollowUp[e].FOLLOWUPDT).split(dayNum);
                        checkFollowUplanguge(FollowUp, language, 'F')

                        if (dayNum.length > 0) {
                            if (Number(dayNum) > 1) {
                                constString = "s"
                            }
                        }

                        if (GridData.jsonInvstg.length > 0)
                            adviceInv = "with Advised Investigation Reports if any.";
                    }

                    //vijeta 16th march 19
                    if (GridData.jsonFollowUp[e].FOLLOWUPDT == "SOS") {
                        strPrindData.push("</br><table style='width:100%'>");
                        strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + "Follow Up : " + "&nbsp;" + "SOS" + " if any complaints " + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                    }
                    else if (dayNum != "") {
                        if (GridData.jsonFollowUp[e].APPMNTDT == "") {
                            strPrindData.push("</br><table style='width:100%'>");
                            var TranDate = GridData.jsonUserdtls[0].TRANDATE.split(' ')[0];
                            var CalDate = CalculateAppointDate(TranDate, dayNum, languageWise);
                            strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Follow Up on " + CalDate + "</td></tr></table>")//</label>
                        }
                        else {
                            strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + HeaderLang[8] + "&nbsp;" + dayNum + " " + languageWise + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                        }
                    }
                    if (GridData.jsonFollowUp[e].APPMNTDT != "" && GridData.jsonFollowUp[e].APPMNTTM != "") {//vijeta 16th march 19
                        strPrindData.push("</br><table style='width:100%'>");
                        strPrindData.push("<table style='width:100%'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Your Appointment is booked on " + GridData.jsonFollowUp[e].APPMNTDT + " at " + GridData.jsonFollowUp[e].APPMNTTM + " " + adviceInv + "</td></table><br>");
                    }

                }
            }

            if ($("#chkAdmnAdvice").prop('checked')) {
                var Sentence = (AdmAdvDate != "" ? ("Admission Adviced on " + AdmAdvDate) : "Admission Adviced") + ".";
                strPrindData.push("</br><span class='HTextsize' style='font-size:14px !important;font-weight:bold'>" + Sentence + "</span>");
                //strPrindData.push("<br><table style='width:100%;'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + Sentence + "</td></table>");
            }
            //followup end

            //ChemoPlanning
            if (GridData.ChemoPlan.length > 0) {
                strPrindData.push("<br><table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[30] + "</u>: </label><td></tr>")
            }
            if (GridData.ChemoPlan.length > 0) {
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Plan No. </label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].PLANNO + "</label></td></tr>");
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Chemotherapy Name</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].CHEMONAME + "</label></td></tr>");
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Total Cycle</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].TOTALCYCLE + "</label></td></tr>");
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Chemo Start Date</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].ADVSTARTDATE + "</label></td></tr>");
            }
            //ChemoPlanning end

            //Refered Doctor Note 
            if (GridData.jsonRefDoctNote.length > 0) {
                strPrindData.push("<br><table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[31] + "</u>: </label><td></tr>")
            }
            if (GridData.jsonRefDoctNote.length > 0) {
                for (var i = 0; i < GridData.jsonRefDoctNote.length; i++) {
                    var RefNote = "Referred To Dr." + GridData.jsonRefDoctNote[i].REFDOCTNAME.trim() + " - " + GridData.jsonRefDoctNote[i].NOTE.trim()
                    strPrindData.push("<tr><td><label style='color:black;'>" + RefNote + "</label></td></tr>");
                }
                strPrindData.push("</table>");
            }
            //Refered Doctor Note end

            //doctor details start

            var StrDoctCode = '<%:Session["gDoctCode"]%>';

    //strPrindData.push("<div style='bottom:60;position:absolute;float:right!important'><label style='font-style:Arial;font-size:12px; font-weight:bold;margin-left:440px;margin-bottom:70px'>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</label>");

    //strPrindData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
    //strPrindData.push("<table style='float:right!important;font-family:cambria !important;font-size: 13px !important;'  id='tblDoctInfo'>");
    //if (digitsign1 != "")
    //    strPrindData.push("<tr><td><b><img src=" + digitsign1 + "  /></b></td>");
    //if (digitsign2 != "")
    //    strPrindData.push("<td><b><img src=" + digitsign2 + "  /></b></td>");
    //if (digitsign3 != "")
    //    strPrindData.push("<td><b><img src=" + digitsign3 + "  /></b></td></tr>");
    //strPrindData.push("<tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</b></td></tr>");
    //if (GridData.jsonDoctorDetails[0].SIGN == "") { //vijeta 22/4/19

    //    strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");
    //    strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].QUALI + "</td></tr>");
    //    strPrindData.push("<tr><td>" + "Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "</td></tr>");

    //    strPrindData.push("</table>");
    //}
    //else {
    //    //strPrindData.push("<tr><td style='font-size: 12px !important;'>" + GridData.jsonDoctorDetails[0].SIGN.toString().replace(/\n/g, '<br />') + "</td></tr>");
    //    if (sign1 != "")
    //        strPrindData.push("<tr><td><p>" + sign1.replace(/\n/g, "<br />") + "</P></td></tr>");
    //    else if (sign2 != "")
    //        strPrindData.push("<tr><td><p>" + sign2.replace(/\n/g, "<br />") + "<p/></td></tr>");
    //    else if (sign3 != "")
    //        strPrindData.push("<tr><td><p>" + sign3.replace(/\n/g, "<br />") + "</p></td></tr>");
    //    strPrindData.push("</table>");
    //}
    //strPrindData.push("</div>");

    //Priyanka 16/11/2025
    //strPrindData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
    strPrindData.push("<table style='font-family:cambria !important;font-size: 13px !important; margin-left:80% !important;' id='tblDoctInfo'>");
    if (digitsign1 != "")
        strPrindData.push("<tr><td><b><img src=" + digitsign1 + " style='margin-left:-10%!important;'  /></b></td>");
    if (digitsign2 != "")
        strPrindData.push("<td><b style='text-align:center;' ><img src=" + digitsign2 + " style='margin-left:-10%!important;'  /></b></td>");
    if (digitsign3 != "")
        strPrindData.push("<td><b><img src=" + digitsign3 + " style='margin-left:-10%!important;'  /></b></td></tr>");
    strPrindData.push("<tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</label></b></td></tr>");
    if (GridData.jsonDoctorDetails[0].SIGN == "") {

        strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");
        strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].QUALI + "</td></tr>");
        strPrindData.push("<tr><td>" + "Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "</td></tr>");

        strPrindData.push("</table>");
    }
    else {
        if (sign1 != "")
            strPrindData.push("<tr><td><p><span>" + sign1.replace(/\n/g, "<br />") + "</span></p></td>");
        if (sign2 != "")
            strPrindData.push("<td><b>" + sign2.replace(/\n/g, "<br />") + "</b></td>");
        if (sign3 != "")
            strPrindData.push("<td><b>" + sign3.replace(/\n/g, "<br />") + " </b></td></tr>");
    }

    strPrindData.push("</table>");
    //strPrindData.push("</div>");
    //end


    //doctor details end
    //Meenakshi added this bottom lines on prescription as per the Hospital setup//
    strPrindData.push("<div style='bottom: 0px;font-size: 11px !important;text-align:center;' class='DTextsize'>");
    strPrindData.push("<hr/>");
    strPrindData.push("<p>" + '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine1")%>' + "</P>");
            strPrindData.push("<p>" + '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine2")%>' + "</P>");
    strPrindData.push("</div>");
    //
    strPrindData.push("</body></html>");
    return strPrindData.join("");
}
//added on 29th aug 2018
function isEqualZero(currentValue) {
    return currentValue == 0;
}
function IntakeFunction(intake) {
    intakeArray = intake.split("-");
    var chkInitialIntk = intakeArray.every(isEqualZero);
    if (chkInitialIntk)
        intake = "-";
    return intake;
}
var intake = "";
//----------------------------

function toTitleCase(str) {
    return str.replace(/\w\S*/g, function (txt) {
        return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    });
}

function PrintData1() {
    //Meenakhsi commented to print prescription heading only in english
    //var language = $('#hdnlanguage').val(); 
    var language = "NAME";
    // ---- end ----//
    if (language == "NAME") {
        HeaderLang = EnglishHeader;
        WAfter = " After"
    }
    var FollowUp = [];
    var Medicine = '';
    var GeneralExaminations = ''
    var Mrno = ($.session.get('PatMRNO'));
    var strTran = (GridData.jsonstrTranNo).trim();
    //var strTran = ($.session.get('PatTRANNO'))
    var patName = ($.session.get('PatName'));
    var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
    var gRelation = {
        '01': 'Father', '02': 'Mother', '03': 'Wife',
        '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
        '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
        '11': 'Paternal Aunt' //Added the options from 8 - 11 by Murali on 11/04/2024 as per client request. (Ticket : 2528)
    };// added by vijeta on 15th march 2018

    var strPrindData = [];
    strPrindData.push("<html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'/>");
    strPrindData.push(" <style>.cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;text-align: left;font-size: 1.1em;font-family:cambria !important;} .HTextsize{font-size: 14px !important ;padding:3px;} .DTextsize{font-size: 14px !important;} .inHeight{line-height:15px !important} ");

    strPrindData.push(" @page {margin-top: 4cm;margin-bottom: 3cm;}");

    strPrindData.push(" @media screen, print { {body {margin-top: 0mm; margin-bottom: 0mm;  margin-left: 0mm; margin-right: 0mm ; } #footer{display: block;page-break-after: always; bottom:0;margin-top: 25pt; } } #tblPatInfo td{padding: 1px; white-space:nowrap} table { page-break-inside:auto } table { page-break-inside:auto } table { page-break-inside:auto } tfoot { display:table-footer-group } </style></head>");
    strPrindData.push("<body style='margin-left:25;font-size: 1.1em !important'>");
    var label = "Patient Category";
    // var Patcatg = $('#spPatcatgnm')[0].textContent;
    var Patcatg = "";
    var doctName = "";

    ////container div
    //strPrindData.push("<div id='header' class='container'>");

    //////User Details/////
    //strPrindData.push("<table style='width:100%;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px;border-collapse:collapse;' id='tblPatInfo'>");
    ////3/27/19 font size nd family
    //strPrindData.push("<tr><td>Name</td><td>:</td><td>" + GridData.jsonUserdtls[0].PATNAME + "</td>" +
    //    "<td>Age/Gender</td><td>:</td>");
    //strPrindData.push("<td>" + (GridData.jsonUserdtls[0].PATAGE).toString().substring(0,3) + ' ' + 'Years' + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr><tr><td>MR No.</td><td>:</td><td>" + Mrno + "</td>");
    ////3/27/19  Dr -> mrno
    //strPrindData.push("<td>Date/Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>"); 
    //strPrindData.push("</tr><tr><td>Dr. Name</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
    ////3/27/19  mrno -> Dr
    //strPrindData.push("</td><td>Consultn. No.</td><td>:</td>");
    //strPrindData.push("<td>" + strTran + "<td></tr>");
    ////Meenakshi To add exemption and emp ID
    //if (GridData.jsonUserdtls[0].COCANAME != "") {
    //    strPrindData.push("<tr><td>Exemp Catg.</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].COCANAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
    //    if (GridData.jsonUserdtls[0].EMPID != ""){
    //        strPrindData.push("<td>Employee ID</td><td>:</td>");
    //        strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "<td></tr>");
    //    }
    //    else
    //    {
    //        strPrindData.push("<td>Exemp Proof</td><td>:</td>");
    //        strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "<td></tr>");
    //    }
    //}
    //strPrindData.push("</table></div>");//<td>:</td><td style='color:blue;font-size:12px'> Dr." + GridData.jsonUserdtls[0].DOCTNAME + "</td>

    //Vitals start     
    if ($("#chkVital").prop("checked")) {
        if (GridData.jsonVital.length > 0) {
            var flag = 0;
            for (var t = 0; t < GridData.jsonVital.length; t++) {
                var keyNames = Object.keys(GridData.jsonVital[t]);
                var stopAfterBMI = false;   // priyanka 26/12/2025
                for (var a = 0 ; a < keyNames.length; a++) {
                    if (stopAfterBMI) {//Priyanka 26/12/2025
                        continue;
                    }

                    //if ((GridData.jsonVital[t][keyNames[a]].toString().trim() != "")) {
                    if ((keyNames[a] == "PULSE" || keyNames[a] == "PAINSCORE" || keyNames[a] == "BP" || keyNames[a] == "RESP" || keyNames[a] == "SPO2" ||
                        keyNames[a] == "BMI" || keyNames[a] == "HEAD_CIRCUMFERENCE" || keyNames[a] == "PEFR" || keyNames[a] == "Technique" ||
                        keyNames[a] == "Compliance" || keyNames[a] == "VOTHERS" || keyNames[a] == "PAINSCORE" || keyNames[a] == "BSA" || keyNames[a] == "RBS" ||
                        keyNames[a] == "KARNOFSKY" || keyNames[a] == "ECOG" || keyNames[a] == "IBW" || keyNames[a] == "BWPERC" ||
                        keyNames[a] == "WAISTCIRCUM" || keyNames[a] == "HIPCIRCUM" || keyNames[a] == "WHR") &&
                        (GridData.jsonVital[t][keyNames[a]].toString().trim() == "" ||
                        GridData.jsonVital[t][keyNames[a]].toString().trim() == "/" || GridData.jsonVital[t][keyNames[a]].toString().trim() == "N")) { }
                    else if ((keyNames[a] == "WEIGHT" || keyNames[a] == "HEIGHT" || keyNames[a] == "PULSE" || keyNames[a] == "TEMP") && Number(GridData.jsonVital[t][keyNames[a]]) == 0) {

                    }
                    else if (keyNames[a] == "PULSECOND") {

                    }
                    else {
                        flag = 1;
                        GeneralExaminations += "<tr><td width='25px'><label style='color:black;'>" + keyNames[a] +
                            "</label></td><td><label style='width='50px;'>" + ': ' + GridData.jsonVital[t][keyNames[a]];
                        if (keyNames[a] == "WEIGHT") { GeneralExaminations += " kg"; }
                        else if (keyNames[a] == "HEIGHT") { GeneralExaminations += " cm"; }
                        else if (keyNames[a] == "TEMP") { GeneralExaminations += " °F"; }
                        else if (keyNames[a] == "BP") { GeneralExaminations += " mmHg"; }
                        else if (keyNames[a] == "PULSE") {
                            GeneralExaminations += " bpm";
                            if (GridData.jsonVital[0]["PULSECOND"] == "R")
                                GeneralExaminations += " (Regular)";
                            else if (GridData.jsonVital[0]["PULSECOND"] == "I")
                                GeneralExaminations += " (Irregular)";
                        }
                        else if (keyNames[a] == "SPO2") { GeneralExaminations += " %"; }
                            //else if (keyNames[a] == "BMI") { GeneralExaminations += " kg/(m²)"; }
                        else if (keyNames[a] == "BMI") {//Priyanka 26/12/2025
                            GeneralExaminations += " kg/(m²)";
                            if (ShowVitalsInPrescPrintYN === "N") {
                                stopAfterBMI = true;
                            }

                        }
                        else if (keyNames[a] == "HEAD_CIRCUMFERENCE") { GeneralExaminations += " cm"; }
                        else if (keyNames[a] == "PEFR") { GeneralExaminations += " lit/min"; }
                        else if (keyNames[a] == "RBS") { GeneralExaminations += " mg/dl"; }
                        else if (keyNames[a] == "BSA") { GeneralExaminations += " m²"; }
                            //Added by Murali on 25/05/2024
                            //***************************************************************************
                        else if (keyNames[a] == "IBW") { GeneralExaminations += " "; }
                        else if (keyNames[a] == "BWPERC") { GeneralExaminations += " "; }
                        else if (keyNames[a] == "WAISTCIRCUM") { GeneralExaminations += " cm"; }
                        else if (keyNames[a] == "HIPCIRCUM") { GeneralExaminations += " cm"; }
                        else if (keyNames[a] == "WHR") { GeneralExaminations += " "; }
                        else if (keyNames[a] == "KARNOFSKY") { GeneralExaminations += " %"; }
                        //***************************************************************************
                        GeneralExaminations += "</label></td></tr>";
                    }
                }
            }
            if (flag == 1) {
                if (GridData.jsonComplaints.length == 0 && GridData.jsonFreeComplaints.length == 0) {
                    strPrindData.push("<table style='width:100%;'>");
                }
                else
                    strPrindData.push("<table style='float:right;width:40%;'>");

                if (GeneralExaminations != "")
                    strPrindData.push("<tr><td><label class='HTextsize' style=font-weight:bold><u>" + HeaderLang[1] + " </u>: </label></td></tr>");

                strPrindData.push(GeneralExaminations + "</table>");
            }
        }
        strPrindData.push("</td></tr></table>");
    }
    //Vitals end 

    //Complaint start
    if ($("#chkComplaint").prop("checked")) {
        //Chief Complaints

        if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
            strPrindData.push("<table style='float: left;width:60%;'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>" + HeaderLang[0] + " </u>: </label></td></tr>")
        }

        if (GridData.jsonComplaints.length > 0) {
            for (var i = 0; i < GridData.jsonComplaints.length; i++) {
                var TotalDuration = "";
                var dur = "" + GridData.jsonComplaints[i].DURATION
                var durtype = GridData.jsonComplaints[i].DURTYPE
                if (dur.length > 0) {
                    if (Number(dur) > 0) {
                        TotalDuration = "  since " + dur + " " + DurationTypeSelect(durtype, dur)
                    }
                }
                //added on 6th april 2018
                var rmrk = "";
                if (GridData.jsonComplaints[i].REMARKS != "") {
                    //rmrk = " (" + GridData.jsonComplaints[i].REMARKS + ")";
                    rmrk = " " + GridData.jsonComplaints[i].REMARKS + "";
                }
                //------------------------------------------
                // strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:5px;line-height:17px'><li>" + GridData.jsonComplaints[i].NAME + rmrk + "  " + TotalDuration + "</li></td></tr>");
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;width:50%;'><li>" + GridData.jsonComplaints[i].NAME + " " + TotalDuration + " " + rmrk.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                //3/27/19 4/16/19 changed style
            }
        }

        //free complaint vijeta 20th march 19
        if (GridData.jsonFreeComplaints.length > 0) {
            if (GridData.jsonFreeComplaints[0].hasOwnProperty("FREECOMPLAINT")) {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeComplaints[0].FREECOMPLAINT.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
            }
        }
        if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
            strPrindData.push("</table>");
        }
        //strPrindData.push("</div>")
    }
    //complaint end


    //History start
    if (printWithHistory == "Y") {
        //if (GridData.jsonDoctorDetails[0].PRNTHISTYN == "Y") {
        if ($("#chkPersHist").prop("checked")) {
            strPrindData.push("<div id='personalNMediDiv'>");
            if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                strPrindData.push("<br><div style='width:100%' id='divPersonalHist'>");
            }

            if (GridData.jsonPersonalHist.length > 0) {
                strPrindData.push("<table id='personalHistTable'>");// border color added by vijeta on 19th march 2018
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                for (var i = 0; i < GridData.jsonPersonalHist.length; i++) {
                    //changed by karthick to remove Addicted to
                    //strPrindData.push("<tr><td ><li>" + "Addicted to <b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                    strPrindData.push("<tr><td ><li>" + GridData.jsonPersonalHist[i].NAME);
                    //strPrindData.push("<tr><td ><li>" + "<b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                    if (GridData.jsonPersonalHist[i].STOPAGE != 0) {//
                        if (GridData.jsonPersonalHist[i].STARTAGE != "")
                            strPrindData.push(" since " + GridData.jsonPersonalHist[i].STARTAGE)

                        if (GridData.jsonPersonalHist[i].STOPAGE != "")
                            strPrindData.push(" to " + GridData.jsonPersonalHist[i].STOPAGE);
                    }
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            // }
            //free personal history
            if (GridData.jsonFreePersonal != "") {
                strPrindData.push("<table   class='tblFree'>");
                if (GridData.jsonPersonalHist.length == 0) {
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                }
                for (var i = 0; i < GridData.jsonFreePersonal.length; i++) {

                    strPrindData.push("<tr><td><li>" + GridData.jsonFreePersonal[i].PERSHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                strPrindData.push("</div>");
            }
        }
        ////PERSONAL HISTORY 

        //Other History 
        if ($("#chkExamin").prop("checked")) {
            if (GridData.jsonPastHist.length > 0) {
                if (GridData.jsonPastHist[0]["PASTHIST"] !== "") {
                    strPrindData.push("<br><table>")
                    //strPrindData.push("<tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[20] + "</u>: </label><br><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonPastHist[0]["PASTHIST"].replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</label>" + "</td>");
                    strPrindData.push("<tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[20] + "</u>: </label><br><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonPastHist[0]["PASTHIST"].replace(/\n/g, '<br />') + "</label>" + "</td>");
                    strPrindData.push("</tr>");
                    strPrindData.push("</table>")
                }
            }
        }
        //Other History End

        //medical history start
        if ($("#chkMedHist").prop("checked")) {
            if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {

                //if (GridData.jsonPersonalHist.length == 0 && GridData.jsonFreePersonal.length == 0)
                strPrindData.push("<br><div style='width:100%' id='divMedicalHist'>");
                // else
                // strPrindData.push("<br><div style='float:right;width:40%;' id='divMedicalHist'>");
            }
            if (GridData.jsonMedicineHist.length > 0) {
                strPrindData.push("<table id='medicalHistTable' style='border-collapse:collapse;' >");//4/8/19 border color added by vijeta on 19th march 2018                       
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[13] + " :</u></caption>")
                for (var i = 0; i < GridData.jsonMedicineHist.length; i++) {
                    //strPrindData.push("<tr><td><li>" + " <b>" + GridData.jsonMedicineHist[i].NAME + "</b>");
                    strPrindData.push("<tr><td><li>" + GridData.jsonMedicineHist[i].NAME);
                    if (GridData.jsonMedicineHist[i].DURATION != "" && GridData.jsonMedicineHist[i].DURATION != 0)//
                        strPrindData.push(" since " + GridData.jsonMedicineHist[i].DURATION.toString() + " " + gDurType[GridData.jsonMedicineHist[i].DURTYPE] + "(s)");
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            //free medical history
            if (GridData.jsonFreeMedical != "") {
                strPrindData.push("<table style='border-collapse:collapse;' class='tblFree'>");
                if (GridData.jsonMedicineHist.length == 0) {
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[13] + " :</u></caption>")
                }
                for (var i = 0; i < GridData.jsonFreeMedical.length; i++) {

                    strPrindData.push("<tr><td><li>" + GridData.jsonFreeMedical[i].MEDHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {
                strPrindData.push("</div>");
            }
            //medical history end

            strPrindData.push("</div>");
        }

        //family history start
        if ($("#chkFamHist").prop("checked")) {
            if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0) {

                if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0)
                    strPrindData.push("<br><div id='familyHistDiv'>");
                //strPrindData.push("<label class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></label>")
            }
            if (GridData.jsonFamilyHist.length > 0) {
                strPrindData.push("<table id='familyHistTable' style='width:100%;border-collapse:collapse;'>");// 4/8/19border color added by vijeta on 19th march 2018s
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></caption>")
                for (var i = 0; i < GridData.jsonFamilyHist.length; i++) {
                    var DiseaseStatus = GridData.jsonFamilyHist[i].DISEASESTATUS != "" ? (" - " + GridData.jsonFamilyHist[i].DISEASESTATUS.trim()) : "";
                    var DiagDate = GridData.jsonFamilyHist[i].DIAGNOSEDDATE != "" ? (" (" + GridData.jsonFamilyHist[i].DIAGNOSEDDATE.trim() + ")") : "";
                    //if (GridData.jsonFamilyHist[i].DURATION != 0) {//
                    //    strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                    //               GridData.jsonFamilyHist[i].DISEASES + "</b> since " + GridData.jsonFamilyHist[i].DURATION + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)");
                    //}
                    //else {
                    //    if (GridData.jsonFamilyHist[i].AGE > 0)
                    //        strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                    //                        GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                    //    else
                    //        strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + ", suffering with <b>" +
                    //                  GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                    //}
                    if (GridData.jsonFamilyHist[i].DURATION != 0) {//
                        strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with " +
                                   GridData.jsonFamilyHist[i].DISEASES + " since " + GridData.jsonFamilyHist[i].DURATION + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)" + DiseaseStatus + DiagDate);
                    }
                    else {
                        if (GridData.jsonFamilyHist[i].AGE > 0)
                            strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with " +
                                            GridData.jsonFamilyHist[i].DISEASES + DiseaseStatus + DiagDate);
                        else
                            strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + ", suffering with " +
                                      GridData.jsonFamilyHist[i].DISEASES + DiseaseStatus + DiagDate);
                    }
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table>");

                // strPrindData.push("<br>");
            }
            //free family history
            if (GridData.jsonFreeFamily != "") {
                strPrindData.push("<table style='border-collapse:collapse; ' class='tblFree'>");
                if (GridData.jsonFamilyHist.length == 0) {
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></caption>")
                }
                for (var i = 0; i < GridData.jsonFreeFamily.length; i++) {

                    strPrindData.push("<tr><td><li>" + GridData.jsonFreeFamily[i].FAMHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0) {
                strPrindData.push("</div><br>");
            }
        }
        //family history end
    }
    //end of histry

    //allergy      
    if ($("#chkAllergy").prop("checked")) {
        if (GridData.jsonAllergy.length > 0) {
            strPrindData.push("<table id='AllergyTable'>");
            strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>Allergy</u>:</caption>");
            for (var i = 0; i < GridData.jsonAllergy.length; i++) {
                var AllgryDurType = GridData.jsonAllergy[i].DURTYPE == "D" ? "Days" : (GridData.jsonAllergy[i].DURTYPE == "W" ? "Week" : GridData.jsonAllergy[i].DURTYPE == "M" ? "Month" : GridData.jsonAllergy[i].DURTYPE == "Y" ? "Year" : "")
                var AllgryDur = GridData.jsonAllergy[i].DURATION != "" && Number(GridData.jsonAllergy[i].DURATION) > 0 ? GridData.jsonAllergy[i].DURATION : "";
                //strPrindData.push("<tr><td><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");
                strPrindData.push("<tr><td><li>" + GridData.jsonAllergy[i].ALLERGYTYPE + " Allergy - " + GridData.jsonAllergy[i].NAME + (AllgryDur != "" ? (" For " + AllgryDur + " " + AllgryDurType) : ""));
                strPrindData.push("</li></td></tr>");
            }
            strPrindData.push("</table>");
        }
    }

    //Clinical Notes start
    if ($("#chkClinicalNotes").prop("checked")) {
        if (GridData.jsonClinicalHist.length > 0 || GridData.jsonClinicalHist.length > 0) {
            strPrindData.push("<br><label class='HTextsize' style='font-weight:bold'><u>Clinical Notes </u>: </label>")
            strPrindData.push("<table>");
            if (GridData.jsonClinicalHist.length > 0) {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'>" + GridData.jsonClinicalHist[0].CLINICALHIST.toString().replace(/\n/g, '<br />') + "</td></tr>");
            }
            strPrindData.push("</table>")
        }
    }
    //Clinical Notes End

    //Exam start
    if ($("#chkExamin").prop("checked")) {
        if (GridData.jsonExam[0]["EXAM"] !== "") {

            strPrindData.push("<table style='width:100%;'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>" + HeaderLang[10] + " </u>: </label></td></tr>")
            strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:5px;line-height:20px;word-wrap: break-word;'>" + GridData.jsonExam[0]["EXAM"].toString().replace(/\n/g, '<br />') + "</td></tr>");
            strPrindData.push("</table>");
        }
        if (GridData.ExamImagePath.length > 0) {
            strPrindData.push("<table id='Imagedata'>")
            //strPrindData.push("<table style='width:60%;'><tr><td><label class='HTextsize' style='font-weight:bold;'>")//3/27/19 added
            var strmrno = ($.session.get('PatMRNO')).toString();
            var strtranNo = ($.session.get('PatTRANNO')).toString();
            datatosend = {
                MrNo: strmrno,
                TranNo: strtranNo
            }
            $.ajax({
                type: 'POST',
                url: 'RetriveExamImages',
                data: datatosend,
                async: false,
                success: function (ImageData) {
                    if (ImageData.length > 0) {
                        var i = ImageData.length;
                        $.each(ImageData, function (index, element) {
                            var imageStr = "";
                            if ((index % 2 == 0)) {
                                strPrindData.push("<tr>");
                            }
                            var fileNo = element.split("|");
                            var strUrl = "data:[<media type>];charset=utf-8;base64," + fileNo[1];

                            imageStr += '<td><img id=' + fileNo[0] + ' src="' + strUrl + '" alt="no image found" style="width:350px;height:300px; margin:4px;">';
                            imageStr += '</td>';

                            strPrindData.push(imageStr);

                            if ((index % 2 != 0)) {
                                strPrindData.push("</tr>");
                            }
                        })
                    }
                    else {
                        imageStr += '<tr><td></td></tr>'
                    }
                },
                complete: function () {
                    HoldOn.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });

            strPrindData.push("</table>");
        }
    }
    //Exam end

    //Diagnosis start
    if ($("#chkDiagnosis").prop("checked")) {
        if (GridData.jsonFollowUp[0]["PROVDIAG"].toString().trim() != "")
            strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[19] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + GridData.jsonFollowUp[0]["PROVDIAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

        if (GridData.jsonFollowUp[0]["SITE"].toString().trim() != "")
            strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Site</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + GridData.jsonFollowUp[0]["SITE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

        if (GridData.jsonFollowUp[0]["SUBSITE"].toString().trim() != "")
            strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Sub Site</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + GridData.jsonFollowUp[0]["SUBSITE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

        if (GridData.jsonFollowUp[0]["TSTAGE"].toString().trim() != "") {
            strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
            strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>TNM</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
            //strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>TNM Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
            strPrindData.push("<td style='align:left'>T:<label class='HTextsize'  >" + GridData.jsonFollowUp[0]["TSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
            strPrindData.push("<td style='align:left'>N:<label class='HTextsize'  >" + GridData.jsonFollowUp[0]["NSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
            strPrindData.push("<td style='align:left'>M:<label class='HTextsize'  >" + GridData.jsonFollowUp[0]["MSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
            strPrindData.push("</tr></table>");
        }

        if (GridData.jsonFollowUp[0]["COMPOSTAG"].toString().trim() != "")
            strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Stage</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

        //strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Composit Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

        if (GridData.jsonDiagnosis.length > 0) {

            if (GridData.jsonICDiagnosis.length <= 0) {
                strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
            } else {
                strPrindData.push("<table style='width:50%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
            }

            // width chngd the width nd remvd float
            for (var i = 0; i < GridData.jsonDiagnosis.length; i++) {
                if (GridData.jsonDiagnosis[i].NAME.trim() != "") {
                    var DiagRemark = "";

                    if (GridData.jsonDiagnosis[i].REMARKS != "") {
                        DiagRemark = " " + " - " + GridData.jsonDiagnosis[i].REMARKS
                    }
                    // strPrindData.push("<tr style='line-height:15px;'><td class='DTextsize' style='padding:5px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark + "</li></td></tr>");//3/27/19 commntd
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    //
                }
            }
            strPrindData.push("</table></br>");
            //strPrindData.push("<br>");//3/27/19 commntd
        }

        //Diagnosis end

        //ICDiagnosis..................................
        if (GridData.jsonICDiagnosis.length > 0) {

            if (GridData.jsonDiagnosis.length <= 0) {
                strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")
            } else {
                strPrindData.push("<table style='width:50%;float:right'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICD Diagnosis</u>: </label></td></tr>")
            }

            for (var i = 0; i < GridData.jsonICDiagnosis.length; i++) {
                var DiagRemark = "";
                strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDiagnosis[i].NAME + "</li></td></tr>");
            }
            strPrindData.push("</table>");
        }
    }
    //ICDiagnosis end..................................
    //ICDO Diagnosis..................................
    //if (GridData.jsonICDODiagnosis.length > 0) {
    //    strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICDO Diagnosis</u>: </label></td></tr>")
    //    for (var i = 0; i < GridData.jsonICDODiagnosis.length; i++) {
    //        var DiagRemark = "";
    //        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDODiagnosis[i].NAME + "</li></td></tr>");
    //    }
    //    strPrindData.push("</table>");
    //}

    if (GridData.jsonICDOTopology.length > 0) {
        var ICDOTbl = ICDOTable(GridData.jsonICDOTopology, GridData.jsonICDOHistology);
        strPrindData.push(ICDOTbl);
    }
    //Medicine advice start printdata1
    if ($("#chkRx").prop("checked")) {
        if (GridData.jsonAdvice.length > 0) {
            var rxData = RxTable();
            strPrindData.push(rxData);
        }
    }
    //medicine advice end
    //Investigation start        
    if ($("#chkInvest").prop("checked")) {
        if (GridData.jsonInvstg.length > 0 || GridData.jsonFreeInvestigation.length > 0) {
            strPrindData.push("<br><table style='width:100%;'><tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[4] + "</u>: </label></td></tr>");//
        }
        if (GridData.jsonInvstg.length > 0) {
            for (var i = 0; i < GridData.jsonInvstg.length; i++) {
                //added on 6th april 2018
                var TotalDuration = "";
                var dur = "" + GridData.jsonInvstg[i].DURATION
                var durtype = GridData.jsonInvstg[i].DURTYPE
                if (dur.length > 0) {
                    if (Number(dur) > 0) {
                        TotalDuration = "  perform after" + dur + " " + DurationTypeSelect(durtype, dur)
                    }
                }
                //------------------------------------------
                if (GridData.jsonInvstg[i].REMARK.toString().trim() != "") {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" +
                        GridData.jsonInvstg[i].TESTNAME.toString().trim() + " - " + GridData.jsonInvstg[i].REMARK.toString().trim() + " " + TotalDuration + "</li></td></tr>");
                }
                else {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" +
                        GridData.jsonInvstg[i].TESTNAME.toString().trim() + " " + TotalDuration.toString().trim() + "</li></td></tr>");
                }
            }
        }


        //vijeta 20th march 19

        if (GridData.jsonFreeInvestigation.length > 0) {
            strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeInvestigation[0].FREEINVESTIGATION.toString().replace(/\n/g, '<br />') + "</li></td></tr>");// removed line-hght
        }
        if (GridData.jsonInvstg.length > 0 || GridData.jsonFreeInvestigation.length > 0)
            strPrindData.push("</table>");

    }

    //Investigation end
    //strPrindData.push("<br>");
    //Patient Advice start
    if ($("#chkInvest").prop("checked")) {
        if (GridData.jsonPatientAdvice.length > 0 || GridData.jsonFreeAdvice.length > 0) {
            strPrindData.push("<br><table style='width:100%;'><tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[3] + " </u>: </label></td></tr>");
            if (GridData.jsonFreeAdvice.length > 0) {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize'  style='padding:2px;'><li>" + GridData.jsonFreeAdvice[0].FREEADVICE + "</li></td></tr>");
            }
            for (var i = 0; i < GridData.jsonPatientAdvice.length; i++) {
                strPrindData.push("<tr class='inHeight'><td class='DTextsize'  style='padding:2px;'><li>" + GridData.jsonPatientAdvice[i].NAME + "</li></td></tr>");
            }
            strPrindData.push("</table>")
        }
    }
    //Patient Advice end

    //folowup start         
    var dt = "", refDoct = "", AdmAdvDate = "";
    if (GridData.jsonFollowUp.length > 0) {//
        var dayNum = "", constString = "";
        refDoct = GridData.jsonFollowUp[0]["REFDOCT"];
        refSpecilist = GridData.jsonFollowUp[0]["REFSPECIALIST"];
        AdmAdvDate = GridData.jsonFollowUp[0]["PROPADMNDT"].toString();
        for (var e = 0; e < GridData.jsonFollowUp.length; e++) {
            if (GridData.jsonFollowUp[0]["SURGNMADVICE"] != "") {
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Adviced Date</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label>" + GridData.jsonFollowUp[0]["SURGADVDATE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Adviced</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label>" + GridData.jsonFollowUp[0]["SURGNMADVICE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>PAC on or before</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label>" + GridData.jsonFollowUp[0]["PACADVDATE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
            }

            if (refDoct.length > 0) {
                // strPrindData.push("<br>");
                var array = refDoct.split(',');
                if (GridData.jsonFollowUp[e].FOLLOWUPDT.length >= 0) {
                    strPrindData.push("<table style='width:100%;'><tr>");
                }
                strPrindData.push("<td style='width:25%;vertical-align:top;' ><label style='font-weight:bold' class='HTextsize' ><u>" + HeaderLang[11] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><ul style='margin-left:-30px'>");
                $.each(array, function (index, val) {
                    if (val != "")
                        strPrindData.push("&#9679;<li style='display: inline;list-style:circle;'>Dr. " + val.toString().replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                });
                strPrindData.push("</ul></td>");
                strPrindData.push("</tr></table>")
            }

            if (refSpecilist.length > 0) {
                //strPrindData.push("<br>");
                var arraySpec = refSpecilist.split(',');
                if (GridData.jsonFollowUp[e].FOLLOWUPDT.length >= 0) {
                    strPrindData.push("<table style='width:100%;'><tr>");
                }
                strPrindData.push("<td style='width:25%;vertical-align:top;'><label style='font-weight:bold' class='HTextsize'><u>" + HeaderLang[15] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><ul style='margin-left:-30px'>");
                $.each(arraySpec, function (index, val) {
                    if (val != "")
                        strPrindData.push("&#9679;<li style='display: inline;list-style:circle;'>" + val.toString().replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                });
                strPrindData.push("</ul></td>");
                strPrindData.push("</tr><table>")
            }


            if (GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().trim() != "" && $("#chkPlanOfTreatmnt").prop("checked"))
                strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td class='HTextsize'style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[18] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            //added on 13th march 19 for prescription remark
            var remark = GridData.jsonFollowUp[0]["REMARK"];
            if (remark != "" && $("#chkRemark").prop("checked"))
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[16] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + remark.toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            var adviceInv = ""
            if (GridData.jsonFollowUp[e].FOLLOWUPDT.length > 0) {
                dayNum = (GridData.jsonFollowUp[e].FOLLOWUPDT).replace(/[^0-9]+/ig, "");
                FollowUp = (GridData.jsonFollowUp[e].FOLLOWUPDT).split(dayNum);
                checkFollowUplanguge(FollowUp, language, 'F')

                if (dayNum.length > 0) {
                    if (Number(dayNum) > 1) {
                        constString = "s"
                    }
                }

                if (GridData.jsonInvstg.length > 0)
                    adviceInv = "with Advised Investigation Reports if any";
            }

            //vijeta 16th march 19
            if (GridData.jsonFollowUp[e].FOLLOWUPDT == "SOS") {
                strPrindData.push("<br>");
                strPrindData.push("<table style='width:100%'>");
                strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + "Follow Up : " + "&nbsp;" + "SOS" + " if any complaints " + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
            }
            else if (dayNum != "") {

                if (GridData.jsonFollowUp[e].APPMNTDT == "") {
                    strPrindData.push("</br><table style='width:100%'>");
                    var TranDate = GridData.jsonUserdtls[0].TRANDATE.split(' ')[0];
                    var CalDate = CalculateAppointDate(TranDate, dayNum, languageWise);
                    strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Follow Up on " + CalDate + "</td></tr></table>")//</label>
                }
                else {
                    strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + HeaderLang[8] + "&nbsp;" + dayNum + " " + languageWise + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                }
            }
            if (GridData.jsonFollowUp[e].APPMNTDT != "" && GridData.jsonFollowUp[e].APPMNTTM != "") {
                strPrindData.push("<br>");
                strPrindData.push("<table style='width:100%'>");
                strPrindData.push("<table style='width:100%;'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Your Appointment is booked on " + GridData.jsonFollowUp[e].APPMNTDT + " at " + GridData.jsonFollowUp[e].APPMNTTM + " " + adviceInv + "</td></table><br>");
            }
        }

    }

    if ($("#chkAdmnAdvice").prop('checked')) {
        var Sentence = (AdmAdvDate != "" ? ("Admission Adviced on " + AdmAdvDate) : "Admission Adviced") + ".";
        strPrindData.push("</br><span class='HTextsize' style='font-size:14px !important;font-weight:bold'>" + Sentence + "</span>");
        //strPrindData.push("<br><table style='width:100%;'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + Sentence + "</td></table>");
    }
    //followup end

    //ChemoPlanning
    if (GridData.ChemoPlan.length > 0) {
        strPrindData.push("<br><table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[30] + "</u>: </label><td></tr>")
    }
    if (GridData.ChemoPlan.length > 0) {
        strPrindData.push("<tr><td width='25px'><label style='color:black;'>Plan No. </label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].PLANNO + "</label></td></tr>");
        strPrindData.push("<tr><td width='25px'><label style='color:black;'>Chemotherapy Name</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].CHEMONAME + "</label></td></tr>");
        strPrindData.push("<tr><td width='25px'><label style='color:black;'>Total Cycle</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].TOTALCYCLE + "</label></td></tr>");
        strPrindData.push("<tr><td width='25px'><label style='color:black;'>Chemo Start Date</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].ADVSTARTDATE + "</label></td></tr></table>");
    }
    //ChemoPlanning end

    //Refered Doctor Note 
    if (GridData.jsonRefDoctNote.length > 0) {
        strPrindData.push("<br><table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[31] + "</u>: </label><td></tr>")
    }
    if (GridData.jsonRefDoctNote.length > 0) {
        for (var i = 0; i < GridData.jsonRefDoctNote.length; i++) {
            var RefNote = "Referred To Dr." + GridData.jsonRefDoctNote[i].REFDOCTNAME.trim() + " - " + GridData.jsonRefDoctNote[i].NOTE.trim()
            strPrindData.push("<tr><td><label style='color:black;'>" + RefNote + "</label></td></tr>");
        }
        strPrindData.push("</table>");
    }
    //Refered Doctor Note end

    //container end
    strPrindData.push("</div>");
    var StrDoctCode = '<%:Session["gDoctCode"]%>';

            //  strPrindData.push("<div style='bottom:60;position:absolute;float:right!important'><label style='font-style:Arial;font-size:12px; font-weight:bold;margin-left:440px;margin-bottom:70px'>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</label>");

            //strPrindData.push("<br><div id='footer' style='width:100%;float:right!important;'>");//Priyanka 16/11/2025
            strPrindData.push("<table style='font-family:cambria !important;font-size: 13px !important; margin-left:80% !important;' id='tblDoctInfo'>");
            if (digitsign1 != "")
                strPrindData.push("<tr><td><b><img src=" + digitsign1 + " style='margin-left:-10%!important;'  /></b></td>");
            if (digitsign2 != "")
                strPrindData.push("<td><b style='text-align:center;' ><img src=" + digitsign2 + " style='margin-left:-10%!important;'  /></b></td>");
            if (digitsign3 != "")
                strPrindData.push("<td><b><img src=" + digitsign3 + " style='margin-left:-10%!important;'  /></b></td></tr>");
            strPrindData.push("<tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</label></b></td></tr>");
            if (GridData.jsonDoctorDetails[0].SIGN == "") {

                strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");
                strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].QUALI + "</td></tr>");
                strPrindData.push("<tr><td>" + "Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "</td></tr>");

                strPrindData.push("</table>");
            }
            else {
                if (sign1 != "")
                    strPrindData.push("<tr><td><p><span>" + sign1.replace(/\n/g, "<br />") + "</span></p></td>");
                if (sign2 != "")
                    strPrindData.push("<td><b>" + sign2.replace(/\n/g, "<br />") + "</b></td>");
                if (sign3 != "")
                    strPrindData.push("<td><b>" + sign3.replace(/\n/g, "<br />") + " </b></td></tr>");
            }

            strPrindData.push("</table>");
            //strPrindData.push("</div>");
            //end

            //strPrindData.push("<div id='footer'><label style='font-style:Arial;font-size:14px; font-weight:bold;margin-left:415px;width:220px;float:right!important;text-align:left;'>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</label>"); // div id=footer added by vijeta on 14th march 2018
            //if (StrDoctCode != "000549") {
            //    strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:220px;float:right!important;text-align:left;'>" + GridData.jsonDoctorDetails[0].QUALI + "</label>");
            //    strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:220px;float:right!important;text-align:left;'>" + "Reg No : " + GridData.jsonDoctorDetails[0].MCCNO + "</label>");
            //    //strPrindData.push("<footer><p><label style='font-style:Arial;font-size:14px; font-weight:bold;margin-left:415px;width:200px;float:right!important;text-align:left;'>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</label>");
            //    //strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:200px;float:right!important;text-align:left;'>" + GridData.jsonDoctorDetails[0].QUALI + "</label>");
            //    //strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:200px;float:right!important;text-align:left;'>" + "Reg No : " + GridData.jsonDoctorDetails[0].MCCNO + "</label>");
            //}

            //Meenakshi added this bottom lines on prescription as per the Hospital setup//
            strPrindData.push("<div style='bottom: 0px;font-size: 11px !important;text-align:center;' class='DTextsize'>");
            strPrindData.push("<hr/>");
            strPrindData.push("<p>" + '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine1")%>' + "</P>");
            strPrindData.push("<p>" + '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine2")%>' + "</P>");
            strPrindData.push("</div>");
            //

            strPrindData.push("</div>");
            strPrindData.push("</body></html>");
            return strPrindData.join("");
        }

        //Meenakshi created common function to display a rx table and called from all three template function 
        function RxTable() {
            var Medicine = "";
            var medTbl1 = "";
            var flag = 0;
            var flagDura = 0;
            var flagQty = 0;
            //var flagRoute = 1;
            var CheckForRemarkFlag = 0;  // "CheckForRemarkFlag",this flag is used to check remark column and food ,if both are not present it will not display both column on Print pdf,added by ajinkya 2-12-2019
            $.each(GridData.jsonAdvice, function (key, value) {
                if (value.DOSSAGE != "") {
                    flag = 1;
                    return false;
                }
            });

            $.each(GridData.jsonAdvice, function (key, value) {
                if (value.QTY != "") {
                    flagQty = 1;
                    return false;
                }
            });
            $.each(GridData.jsonAdvice, function (key, value) {
                if (value.REMARKS != "" || value.ABFOOD != "-") {
                    CheckForRemarkFlag = 1;
                    return false;
                }
            });
            //strPrindData.push("<div style='margin-bottom:5px'><label style='font-size:40px;'> &#x211E;</label></div>")
            medTbl1 = "<br><table style='width:100%;empty-cells: hide;border-collapse:collapse;page-break-inside:avoid' border='1'>";
            medTbl1 += "<caption style='font-size:25px;text-align:left'>R<sub>x</sub></caption>";

            for (var i = 0; i < GridData.jsonAdvice.length; i++) {
                var MDate = "";
                var dosage = '';
                var advicesplitVal = [];
                var advicedayNum = '';
                var IntakeRemark = '';
                var Route = ''; QTY = '';
                Food = "";
                var strConS = '';
                var concateComma = '';
                var genericNm = GeneralWiseYN == "Y" ? "" : GridData.jsonAdvice[i]["GENERICNAME"].toString() != "" ? "(" + GridData.jsonAdvice[i]["GENERICNAME"].toString() + ")" : "";

                dosage = (GridData.jsonAdvice[i]["DOSSAGE"] == "" || GridData.jsonAdvice[i]["DOSSAGE"] == "undefined") ? "" : GridData.jsonAdvice[i]["DOSSAGE"]//

                Route = (GridData.jsonAdvice[i]["ROUTE"] == "" || GridData.jsonAdvice[i]["ROUTE"] == "undefined") ? "" : GridData.jsonAdvice[i]["ROUTE"]

                QTY = (GridData.jsonAdvice[i]["QTY"] == "" || GridData.jsonAdvice[i]["QTY"] == "undefined") ? "" : GridData.jsonAdvice[i]["QTY"]

                intake = (GridData.jsonAdvice[i]["INTAKE"] == "" || GridData.jsonAdvice[i]["INTAKE"] == "undefined") ? "" : GridData.jsonAdvice[i]["INTAKE"].replace(/0.5/g, "1/2")

                remark = (GridData.jsonAdvice[i]["REMARKS"] == "" || GridData.jsonAdvice[i]["REMARKS"] == "undefined") ? "" : "<br />" + GridData.jsonAdvice[i]["REMARKS"]

                //added on 29th aug 2018
                intake = IntakeFunction(intake);
                //--------------------------------

                if (GridData.jsonAdvice[i]["ABFOOD"] == "A") {
                    Food = AfterFoodData;
                }
                else if (GridData.jsonAdvice[i]["ABFOOD"] == "E") {
                    Food = BeforFoodData;
                }

                if (Food != "" && remark != "") {
                    concateComma = ", "
                }
                if (GridData.jsonAdvice[i]["DAYS"].length > 0) {
                    if (GridData.jsonAdvice[i]["DAYS"] == "C" || GridData.jsonAdvice[i]["DAYS"] == "S") {
                        if (GridData.jsonAdvice[i]["DAYS"] == "C") {
                            IntakeIndicator = GridData.jsonAdvice[i]["DAYS"];
                            IntakeRemark = checkInTakeStatement(IntakeIndicator, language)
                        }
                        else if (GridData.jsonAdvice[i]["DAYS"] == "S") {
                            IntakeIndicator = GridData.jsonAdvice[i]["DAYS"];
                            IntakeRemark = checkInTakeStatement(IntakeIndicator, language)
                        }
                        flagDura = flagDura + 1;
                    }
                    else if (GridData.jsonAdvice[i]["INTAKE"] == "SOS" || GridData.jsonAdvice[i]["INTAKE"] == "CONTD" || GridData.jsonAdvice[i]["INTAKE"] == "STAT") {
                        advicedayNum = ''; IntakeLanguage = ''; strConS = ''
                    }
                    else {
                        day = (GridData.jsonAdvice[i]["DAYS"] == "" || GridData.jsonAdvice[i]["DAYS"] == "undefined") ? "" : "for " + GridData.jsonAdvice[i]["DAYS"]
                        if (day != "" || day != "undefined") {
                            flagDura = flagDura + 1;
                            advicedayNum = (day).replace(/[^0-9]+/ig, "");// taking Numeric value from alphanumeric
                            advicedayNum = advicedayNum == 0 ? "-" : advicedayNum;// taking Numeric value from alphanumeric //4/11/19 
                            advicesplitVal = (day).split((day).replace(/[^0-9]+/ig, ""));// spliting alphanumeric based on dayGridData.jsonAdvice[i]["GENERICNAME"]//4/11/19 
                            //advicesplitVal = (day).split(advicedayNum);// spliting alphanumeric based on dayGridData.jsonAdvice[i]["GENERICNAME"]//4/11/19
                            checkFollowUplanguge(advicesplitVal, language, 'I')
                            if (advicedayNum == '-')//4/11/19
                                IntakeLanguage = "";
                            if (language == "NAME" && advicedayNum.length > 0) {
                                if (Number(advicedayNum) > 1)
                                    strConS = 's'
                            }
                        }
                    }
                }
                else {
                    advicedayNum = "";
                    IntakeLanguage = "";
                    strConS = "";
                }
                MDate = GridData.jsonAdvice[i]["MEDSTARTDATE"].toString();

                if (flagQty == 1 && flag == 1)
                    Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:13px !important;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"] + "</label>" + "<label style='font-size:8.5px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + QTY + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                else if (flagQty == 1 && flag == 0)
                    Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:13px !important;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"] + "</label>" + "<label style='font-size:8.5px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + QTY + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                else if (flagQty == 0 && flag == 1)
                    Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:13px !important;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"] + "</label>" + "<label style='font-size:8.5px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                if (flagQty == 0 && flag == 0)
                    Medicine += "<tr class='inHeight'><td class='HTextsize' style='width:7%;text-align:center;'><label>" + (i + 1) + "</label></td><td style='padding:3px;width:25%;line-height:15px;'><label style='font-size:13px !important;text-align:center;'>" + GridData.jsonAdvice[i]["DRUGNM"] + "</label>" + "<label style='font-size:8.5px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + MDate + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
            }
            var MedHeadLbl = GeneralWiseYN == "Y" ? "Generic Name" : "Medicine Name";
            if (flagQty == 1 && flag == 1)
                medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Qty</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
            else if (flagQty == 1 && flag == 0)
                medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Qty</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
            else if (flagQty == 0 && flag == 1)
                medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
            if (flagQty == 0 && flag == 0)
                medTbl1 += "<tr><td class='HTextsize' style='width:7%;text-align:center;'><label>Sr.No.</label></td><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>" + MedHeadLbl + "</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Date</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";

            return (medTbl1 + "</table>");
        }

        function PrintData3() { //

            //Meenakhsi commented to print prescription heading only in english
            //var language = $('#hdnlanguage').val(); 
            var language = "NAME";
            // ---- end ----//

            if (language == "NAME") {
                HeaderLang = EnglishHeader;
                WAfter = " After"
            }
            var Mrno = ($.session.get('PatMRNO'));
            var strTran = ($.session.get('PatTRANNO'))
            var strPrindData = [];
            var ChiefComplaints = "";
            var GeneralExaminations = "";
            var Medicine = ""
            var DIAGNOSIS = "";
            var ICDDIAGNOSIS = "";
            var PatAdvice = "";
            var AdviceforInvst = "";
            var SurgryAdvice = "";
            var PersonalHistory = "";
            var medicalHistory = "";
            var familyHistory = "";
            var patName = ($.session.get('PatName'));
            var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
            var gRelation = {
                '01': 'Father', '02': 'Mother', '03': 'Wife',
                '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
                '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
                '11': 'Paternal Aunt' //Added the options from 8 - 11 by Murali on 11/04/2024 as per client request. (Ticket : 2528)
            };

            var FollowUp = []
            var VitalKeyName = ""
            var dayNum = ""

            strPrindData.push("<html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'/><meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            strPrindData.push(" <style> .cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;text-align: left;} .HTextsize{font-size: 14px !important ;padding:3px;} .DTextsize{font-size: 14px !important;} .inHeight{line-height:14px !important}  @page {margin-top: 4cm;margin-bottom: 3cm;} @media print {body {margin-top: 0mm; margin-bottom: 0mm;  margin-left: 0mm; margin-right: 0mm } #footer{ bottom:0;margin-top: 25pt;} }  #tblPatInfo td{padding: 1px; white-space:nowrap;} #header {display: block;position: running(header);}  table { page-break-inside:auto } table { page-break-inside:auto } table { page-break-inside:auto } tfoot { display:table-footer-group } </style></head>");//position: fixed; changed by vijeta on 14th march 2018
            strPrindData.push("<body style='margin-left:25;font-family:cambria !important;font-size: 1.1em !important'>");
            var label = "Patient Category";
            // var Patcatg = $('#spPatcatgnm')[0].textContent;
            var Patcatg = "";
            var doctName = "";

            ////container div
            //strPrindData.push("<div id='header' class='container'>");

            //////User Details/////
            //strPrindData.push("<table style='width:100%;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px;border-collapse:collapse;font-family:cambria header !important;font-size: 13px !important;' id='tblPatInfo'>");

            //strPrindData.push("<tr><td>Name</td><td>:</td><td>" + GridData.jsonUserdtls[0].PATNAME + "</td>" +
            //    "<td>Age/Gender</td><td>:</td>");
            //strPrindData.push("<td>" + (GridData.jsonUserdtls[0].PATAGE).toString().substring(0, 3) + ' ' + 'Years' + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr><tr><td>MR No.</td><td>:</td><td>" + Mrno + "</td>");

            //strPrindData.push("<td>Date/Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>"); //3/27/19 gap reduced
            //strPrindData.push("</tr><tr><td>Dr. Name</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>

            //strPrindData.push("</td><td>Consultn. No.</td><td>:</td>");
            //strPrindData.push("<td>" + strTran + "<td></tr>");
            ////Meenakshi To add exemption and emp ID
            //if (GridData.jsonUserdtls[0].COCANAME != "") {
            //    strPrindData.push("<tr><td>Exemp Catg.</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].COCANAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
            //    if (GridData.jsonUserdtls[0].EMPID != "") {
            //        strPrindData.push("<td>Employee ID</td><td>:</td>");
            //        strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "<td></tr>");
            //    }
            //    else {
            //        strPrindData.push("<td>Exemp Proof</td><td>:</td>");
            //        strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "<td></tr>");
            //    }
            //}
            //strPrindData.push("</table></div>");

            /*****************************************General Examination**********************************************/
            var Gflag = 0;
            if (GridData.jsonVital.length > 0) {

                for (var t = 0; t < GridData.jsonVital.length; t++) {
                    var keyNames = Object.keys(GridData.jsonVital[t]);
                    var stopAfterBMI = false;//Priyanka 26/12/2025
                    for (var a = 0 ; a < keyNames.length; a++) {


                        if (stopAfterBMI) {//Priyanka 26/12/2025
                            continue;
                        }

                        //if ((GridData.jsonVital[t][keyNames[a]].toString().trim() != "")) {
                        if ((keyNames[a] == "PULSE" || keyNames[a] == "BP" || keyNames[a] == "RESP" || keyNames[a] == "SPO2" || keyNames[a] == "BMI" ||
                            keyNames[a] == "HEAD_CIRCUMFERENCE" || keyNames[a] == "PEFR" || keyNames[a] == "PAINSCORE" || keyNames[a] == "Technique" ||
                            keyNames[a] == "Compliance" || keyNames[a] == "VOTHERS" || keyNames[a] == "BSA" || keyNames[a] == "RBS"
                    || keyNames[a] == "KARNOFSKY" || keyNames[a] == "ECOG" || keyNames[a] == "IBW" || keyNames[a] == "BWPERC" || keyNames[a] == "WAISTCIRCUM"
                    || keyNames[a] == "HIPCIRCUM" || keyNames[a] == "WHR") && (GridData.jsonVital[t][keyNames[a]].toString().trim() == "" ||
                            GridData.jsonVital[t][keyNames[a]].toString().trim() == "/" || GridData.jsonVital[t][keyNames[a]].toString().trim() == "N"))
                        { }
                        else if ((keyNames[a] == "WEIGHT" || keyNames[a] == "HEIGHT" || keyNames[a] == "PULSE" || keyNames[a] == "TEMP")
                            && Number(GridData.jsonVital[t][keyNames[a]]) == 0)
                        { }
                        else if (keyNames[a] == "PULSECOND") {

                        }
                        else {
                            Gflag = 1;
                            GeneralExaminations += "<tr class='inHeight'><td class='DTextsize' style='padding-right:3px !important'><label style='color:black;'><li>" + keyNames[a] + "</label></td><td class='DTextsize'><label style=''>" + ': ' + GridData.jsonVital[t][keyNames[a]];
                            if (keyNames[a] == "WEIGHT") { GeneralExaminations += " kg"; }
                            else if (keyNames[a] == "HEIGHT") { GeneralExaminations += " cm"; }
                            else if (keyNames[a] == "TEMP") { GeneralExaminations += " °F"; }
                            else if (keyNames[a] == "BP") { GeneralExaminations += " mmHg"; }
                            else if (keyNames[a] == "PULSE") {
                                GeneralExaminations += " bpm";
                                if (GridData.jsonVital[0]["PULSECOND"] == "R")
                                    GeneralExaminations += " (Regular)";
                                else if (GridData.jsonVital[0]["PULSECOND"] == "I")
                                    GeneralExaminations += " (Irregular)";
                            }
                            else if (keyNames[a] == "SPO2") { GeneralExaminations += " %"; }
                                //else if (keyNames[a] == "BMI") { GeneralExaminations += " kg/(m²)"; }
                            else if (keyNames[a] == "BMI") {//Priyanka 26/12/2025
                                GeneralExaminations += " kg/(m²)";
                                if (ShowVitalsInPrescPrintYN === "N") {
                                    stopAfterBMI = true;
                                }
                            }
                            else if (keyNames[a] == "HEAD_CIRCUMFERENCE") { GeneralExaminations += " cm"; }
                            else if (keyNames[a] == "PEFR") { GeneralExaminations += " lit/min"; }
                            else if (keyNames[a] == "RBS") { GeneralExaminations += " mg/dl"; }
                            else if (keyNames[a] == "BSA") { GeneralExaminations += " m²"; }
                                //Added by Murali on 25/05/2024
                                //***************************************************************************
                            else if (keyNames[a] == "IBW") { GeneralExaminations += " "; }
                            else if (keyNames[a] == "BWPERC") { GeneralExaminations += " "; }
                            else if (keyNames[a] == "WAISTCIRCUM") { GeneralExaminations += " cm"; }
                            else if (keyNames[a] == "HIPCIRCUM") { GeneralExaminations += " cm"; }
                            else if (keyNames[a] == "WHR") { GeneralExaminations += " "; }
                            else if (keyNames[a] == "KARNOFSKY") { GeneralExaminations += " %"; }
                            //*********************************************
                            GeneralExaminations += "</label></td></tr>";
                        }
                    }
                }
            }
            /****************************************end General Examntn***********************************************/
            //
            if ((GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0 || Gflag == 1 || (printWithHistory == "Y" && GridData.jsonFreeFamily.length > 0))
                 && (GridData.jsonDiagnosis.length > 0 || GridData.jsonPatientAdvice.length > 0 || GridData.jsonInvstg.length > 0 || GridData.jsonFreeInvestigation.length > 0 || GridData.jsonFollowUp[0].SURGNMADVICE.length > 0))
                strPrindData.push("<table style='width: 100%;border-collapse:collapse;'><tr><td style='width:40%;vertical-align:top;'>")//border-right:1px solid
            else
                strPrindData.push("<table style='width: 100%;border-collapse:collapse;' ><tr><td style='width:100%;vertical-align:top;'>")//border-right:1px solid

            strPrindData.push("<table style='100%'>")//border-right:1px solid

            /*-----------------Chief Complaints -----------------------------------------------------------------------*/
            if (GridData.jsonComplaints.length > 0) {
                //if (GridData.jsonComplaints[0].hasOwnProperty("FREECOMPLAINT")) {
                //    // strPrindData.push("<table style='float: left;width:70%;'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>" + HeaderLang[0] + " </u>: </label></td></tr>")
                //    ChiefComplaints = "<tr><td class='HTextsize'>" + GridData.jsonComplaints[0].FREECOMPLAINT + "</td></tr>";
                //    // strPrindData.push("</table></br>");
                //}
                //else {
                for (var c = 0; c < GridData.jsonComplaints.length; c++) {
                    var TotalDuration = "";
                    var dur = "" + GridData.jsonComplaints[c].DURATION
                    var durtype = GridData.jsonComplaints[c].DURTYPE
                    if (dur.length > 0) {
                        if (Number(dur) > 0) {
                            TotalDuration = "  since " + dur + " " + DurationTypeSelect(durtype, dur)
                        }
                    }

                    var rmrk = "";
                    if (GridData.jsonComplaints[c].REMARKS != "") {
                        //rmrk = " (" + GridData.jsonComplaints[c].REMARKS+")"; 
                        rmrk = " " + GridData.jsonComplaints[c].REMARKS + "";
                    }
                    //------------------------------------------

                    ChiefComplaints += "<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonComplaints[c].NAME + " " + TotalDuration + " " + rmrk.toString().replace(/\n/g, '<br />') + "</li></td></tr>";
                }
                //}

            }
            /*-----------------Chief End Here -----------------------------------------------------------------------*/

            //FreeComplaint
            if (GridData.jsonFreeComplaints.length > 0) {
                if (GridData.jsonFreeComplaints[0].hasOwnProperty("FREECOMPLAINT")) {
                    ChiefComplaints += "<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonFreeComplaints[0].FREECOMPLAINT.toString().replace(/\n/g, '<br />') + "</li></td></tr>";
                }
            }

            if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
                strPrindData.push("<tr><td><table style='width:100%'><tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>" + HeaderLang[0] + ' :' + "</label></td></tr><tr><td>" + ChiefComplaints + "</td></tr></table><br></tr></td>");
            }

            /*--------start---------General Examinations -----------------------------------------------------------------------*/

            if (GridData.jsonVital.length > 0) {
                if (GeneralExaminations != "") {
                    strPrindData.push("<tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>" + HeaderLang[1] + ' :' + "</label></td></tr>");
                    strPrindData.push("<tr><td><table style='font-family:cambria !important;font-size: 14px !important;width:100%'>" + GeneralExaminations + "</table><br></td></tr>");
                }
                //strPrindData.push("<tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>" + HeaderLang[1] + ' :' + "</label></td></tr><td><table>" + GeneralExaminations + "</table></td></tr>")
            }

            /*-----------------------------History start-----------------------------------------------------------------*/
            if (printWithHistory == "Y" && (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0)) {
                //Family History
                strPrindData.push("<tr><td><table style='width:100%'>");
                if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0) {
                    strPrindData.push("<tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>" + HeaderLang[14] + ' :' + "</label></td></tr>");
                }
                if (GridData.jsonFamilyHist.length > 0) {
                    for (var i = 0; i < GridData.jsonFamilyHist.length; i++) {
                        var DiseaseStatus = GridData.jsonFamilyHist[i].DISEASESTATUS != "" ? (" - " + GridData.jsonFamilyHist[i].DISEASESTATUS.trim()) : "";
                        var DiagDate = GridData.jsonFamilyHist[i].DIAGNOSEDDATE != "" ? (" (" + GridData.jsonFamilyHist[i].DIAGNOSEDDATE.trim() + ")") : "";
                        familyHistory += "<tr><td class='DTextsize' style='padding:0px;'><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION];

                        if (GridData.jsonFamilyHist[i].AGE > 0)
                            familyHistory += " (" + GridData.jsonFamilyHist[i].AGE + "yrs)";

                        //familyHistory += ", suffering with <b>" + GridData.jsonFamilyHist[i].DISEASES + "</b>";
                        familyHistory += ", suffering with " + GridData.jsonFamilyHist[i].DISEASES;

                        if (GridData.jsonFamilyHist[i].DURATION != 0 && GridData.jsonFamilyHist[i].DURATION != '')
                            familyHistory += " since" + GridData.jsonFamilyHist[i].DURATION.toString() + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)" + DiseaseStatus + DiagDate + "</li></td></tr>";
                        else {
                            familyHistory += DiseaseStatus + DiagDate + "</li></td></tr>";
                        }
                    }
                }
                if (GridData.jsonFreeFamily.length > 0) {
                    for (var i = 0; i < GridData.jsonFreeFamily.length; i++) {

                        familyHistory += "<tr><td class='DTextsize' style='padding:0px;'><li>" + GridData.jsonFreeFamily[i].FAMHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>";
                    }
                }
                strPrindData.push(familyHistory + "</table><br></td></tr>");
                //  }
            }
            /*-----------------------------History end ------------------------------------------------------------------*/
            strPrindData.push("</table>")
            if ((GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0 || Gflag == 1 || (printWithHistory == "Y" && GridData.jsonFreeFamily.length > 0))
                && (GridData.jsonDiagnosis.length > 0 || GridData.jsonPatientAdvice.length > 0 || GridData.jsonInvstg.length > 0 || GridData.jsonFreeInvestigation.length > 0 || GridData.jsonFollowUp[0].SURGNMADVICE.length > 0))
                strPrindData.push("</td><td style='width:60%;vertical-align:top;border-left:1px solid'>")
            /*--------start---------Diagnosis -----------------------------------------------------------------------*/


            if (GridData.jsonFollowUp[0]["PROVDIAG"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>" + HeaderLang[19] + "</label> : </td></tr>");
                strPrindData.push("<tr><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PROVDIAG"].toString().replace(/\n/g, '<br />') + ")")
                strPrindData.push("</label></td></tr></table>");
            }

            if (GridData.jsonFollowUp[0]["SITE"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;margin-top:10px;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>Site</label> : </td></tr>");
                strPrindData.push("<tr><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SITE"].toString().replace(/\n/g, '<br />') + "</label>");
                strPrindData.push("</td></tr></table>");
            }

            if (GridData.jsonFollowUp[0]["SUBSITE"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;margin-top:10px;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>Sub Site</label> : </td></tr>");
                strPrindData.push("<tr><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SUBSITE"].toString().replace(/\n/g, '<br />') + "</label>");
                strPrindData.push("</td></tr></table>");
            }

            if (GridData.jsonFollowUp[0]["TSTAGE"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>TNM</label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
                //strPrindData.push("<label class='HTextsize' style='font-weight:bold'>TNM Staging</label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
                strPrindData.push("<td style='align:left'>T:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["TSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>N:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["NSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>M:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["MSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("</tr></table>");
            }


            if (GridData.jsonFollowUp[0]["COMPOSTAG"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;margin-top:10px;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>Stage</label> : </td></tr>");
                //strPrindData.push("<label class='HTextsize' style='font-weight:bold'>Composit Staging</label> : </td></tr>");
                strPrindData.push("<tr><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label>");
                strPrindData.push("</td></tr></table>");
            }

            if (GridData.jsonDiagnosis.length > 0) {
                strPrindData.push("<table style='width:100%;border-collapse:collapse;'>");
                for (var e = 0; e < GridData.jsonDiagnosis.length; e++) {
                    var DiagRemark = "";
                    if (GridData.jsonDiagnosis[e].REMARKS != "") {
                        DiagRemark = " " + " - " + GridData.jsonDiagnosis[e].REMARKS
                    }
                    DIAGNOSIS += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:15px'><li>" + GridData.jsonDiagnosis[e].NAME + DiagRemark.toString().replace(/\n/g, '<br />') + "</label></td></tr>";
                }
                strPrindData.push("<tr><td><table><tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>Diagnosis :</label></td style='line-height:15px;'></tr>" + DIAGNOSIS + "</table><br></td></tr>")

            }
            /*--------End---------Diagnosis end-----------------------------------------------------------------------*/


            // .......................................ICDiagnosis..................................
            if (GridData.jsonICDiagnosis.length > 0) {

                // strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align:top'><u>Diagnosis</u>: </label>")
                //strPrindData.push("<table style='width:100%'>");//3/27/19 commntd


                // width chngd the width nd remvd float
                for (var i = 0; i < GridData.jsonICDiagnosis.length; i++) {
                    var DiagRemark = "";



                    ICDDIAGNOSIS += "<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDiagnosis[i].NAME + "</li></td></tr>"

                    //
                }
                strPrindData.push("<tr><td><table><tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>ICD Diagnosis :</label></td style='line-height:15px;'></tr>" + ICDDIAGNOSIS + "</table><br></td></tr>")

                //strPrindData.push("<br>");//3/27/19 commntd
            }


            //............................................ICDiagnosis end..................................

            //ICDO Diagnosis..................................
            //if (GridData.jsonICDODiagnosis.length > 0) {
            //    strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>ICDO Diagnosis</u>: </label></td></tr>")
            //    for (var i = 0; i < GridData.jsonICDODiagnosis.length; i++) {
            //        var DiagRemark = "";
            //        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonICDODiagnosis[i].NAME + "</li></td></tr>");
            //    }
            //    strPrindData.push("</table>");
            //}


            /*--------start---------Advice for Investigation-----------------------------------------------------------------------*/

            if (GridData.jsonInvstg.length > 0) {
                for (var e = 0; e < GridData.jsonInvstg.length; e++) {
                    //added on 6th april 2018
                    var TotalDuration = "";
                    var dur = "" + GridData.jsonInvstg[e].DURATION
                    var durtype = GridData.jsonInvstg[e].DURTYPE
                    if (dur.length > 0) {
                        if (Number(dur) > 0) {
                            TotalDuration = "  perform after" + dur + " " + DurationTypeSelect(durtype, dur)
                        }
                    }

                    //------------------------------------------
                    if (GridData.jsonInvstg[e].REMARK.toString().trim() != "") {
                        AdviceforInvst += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:15px;'><li>"
                            + GridData.jsonInvstg[e].TESTNAME.toString().trim() + " - " + GridData.jsonInvstg[e].REMARK.toString().trim() + " " +
                            TotalDuration.toString().trim() + "</label></td></tr>"
                    }
                    else {
                        AdviceforInvst += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:15px;'><li>"
                            + GridData.jsonInvstg[e].TESTNAME.toString().trim() + " " + TotalDuration.toString().trim() + "</label></td></tr>"
                    }
                }
            }
            //free investigation vijeta 20th march 19 free investigation
            if (GridData.jsonFreeInvestigation.length > 0) {
                AdviceforInvst += "<tr class='inHeight'><td class='DTextsize' style='padding:5px;line-height:15px;'><li>" + GridData.jsonFreeInvestigation[0].FREEINVESTIGATION.toString().replace(/\n/g, '<br />') + "</li></td></tr>";
            }
            if (GridData.jsonFreeInvestigation.length > 0 || GridData.jsonInvstg.length > 0)
                strPrindData.push("<tr><td><table><tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>" + HeaderLang[4] + ' :' + "</label></td style:'line-height:15px;'></tr>" + AdviceforInvst + "</table><br></td></tr>")
            /*--------End---------Advice for Investigation end here-----------------------------------------------------------------------*/

            /*--------start---------Advice -----------------------------------------------------------------------*/

            if (GridData.jsonPatientAdvice.length > 0 || GridData.jsonFreeAdvice.length > 0) {
                if (GridData.jsonFreeAdvice.length > 0) {
                    PatAdvice += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:13px;'><li>" + GridData.jsonFreeAdvice[0].FREEADVICE + "</label></td></tr>"
                }
                for (var e = 0; e < GridData.jsonPatientAdvice.length; e++) {
                    PatAdvice += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:13px;'><li>" + GridData.jsonPatientAdvice[e].NAME + "</label></td></tr>"
                }
                strPrindData.push("<tr><td class='HTextsize' style='width: 611px'><label style='color:black;font-weight:bold;'>" + HeaderLang[3] + ' :' + "</label></td></tr><tr><td style='width: 611px;line-height:15px;'><table>" + PatAdvice + "</table><br>")
            }
            /*--------End---------Advice end here -----------------------------------------------------------------------*/

            /*---------------------------------start Advice for surgery --------------------------------------------------------------------*/
            if (GridData.jsonFollowUp.length > 0) {
                if (GridData.jsonFollowUp[0]["SURGNMADVICE"] != "") {
                    SurgryAdvice += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:15px;'><li>" + GridData.jsonFollowUp[0]["SURGNMADVICE"] + "</label></td></tr>"
                    //strPrindData.push("<tr class='inHeight'><td><u><label class='HTextsize' style=';font-weight:bold'>Surgery Advice : </label><u></td></tr>");
                    //strPrindData.push("<tr><td><label class='DTextsize'>" + GridData.jsonFollowUp[0]["SURGNMADVICE"] + "</label></td></tr>")                 
                    strPrindData.push("<tr><td><table><tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>" + "Advice for Surgery :" + "</label></td style:'line-height:15px;'></tr>" + SurgryAdvice.toString().replace(/\n/g, '<br />') + "</table><br></td></tr>")
                }
            }
            /*------------------------------------end Advice for surgery-------------------------------------------------------------------*/
            strPrindData.push("</table>")
            strPrindData.push("</td></tr></table>")
            /**************************** histry start*********************************/

            //Other History 
            if (GridData.jsonPastHist.length > 0) {
                if (GridData.jsonPastHist[0]["PASTHIST"] !== "") {
                    strPrindData.push("<br><table>")
                    //strPrindData.push("<tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[20] + "</u>: </label><br><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonPastHist[0]["PASTHIST"].replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</label>" + "</td>");
                    strPrindData.push("<tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[20] + "</u>: </label><br><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonPastHist[0]["PASTHIST"].replace(/\n/g, '<br />') + "</label>" + "</td>");
                    strPrindData.push("</tr>");
                    strPrindData.push("</table>")
                }
            }

            //4/9/19 shift histry
            if (printWithHistory == "Y") {// condition added by vijeta on 7th may 2018
                //if (GridData.jsonDoctorDetails[0].PRNTHISTYN == "Y") {
                //strPrindData.push("<div id='historyDiv'>");

                //   strPrindData.push("<div id='personalNMediDiv'>");
                if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {

                    //
                    if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0)
                        strPrindData.push("<table  style='width:100%;page-break-inside:avoid'><tr><td style='width:49%;vertical-align:top;border:1px solid #757676;padding:5px; border-radius: 10px;page-break-inside:avoid'>");
                    else
                        strPrindData.push("<table ><tr><td style='width:100%;vertical-align:top;border:1px solid #757676;padding:5px; border-radius: 10px;page-break-inside:avoid'>");


                    //strPrindData.push("<br><div style='width:98%' id='divPersonalHist'>");

                    //strPrindData.push("<label class='HTextsize' style='font-weight:bold;'><u>" + HeaderLang[12] + " </u> : </label>");
                    //strPrindData.push("<ul>");
                }
                if (GridData.jsonPersonalHist.length > 0) {
                    strPrindData.push("<table id='personalHistTable'>");
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'>" + HeaderLang[12] + " :</caption>");
                    for (var i = 0; i < GridData.jsonPersonalHist.length; i++) {
                        //strPrindData.push("<tr><td style='font-size:13px !important'><li>" + "Addicted to <b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                        //changed by karthick to remove addicted to
                        strPrindData.push("<tr><td style='font-size:13px !important'><li>" + GridData.jsonPersonalHist[i].NAME);
                        //strPrindData.push("<tr><td style='font-size:13px !important'><li>" + "<b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                        if (GridData.jsonPersonalHist[i].STOPAGE != 0) {
                            if (GridData.jsonPersonalHist[i].STARTAGE != "")
                                strPrindData.push(" since of " + GridData.jsonPersonalHist[i].STARTAGE)

                            if (GridData.jsonPersonalHist[i].STOPAGE != "")
                                strPrindData.push(" to " + GridData.jsonPersonalHist[i].STOPAGE);
                        }
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                //free personal history
                if (GridData.jsonFreePersonal != "") {
                    strPrindData.push("<table style='border-collapse:collapse;' class='tblFree'>");
                    if (GridData.jsonPersonalHist.length == 0) {
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'>" + HeaderLang[12] + " :</caption>");
                    }
                    for (var i = 0; i < GridData.jsonFreePersonal.length; i++) {

                        strPrindData.push("<tr><td style='font-size:13px !important'><li>" + GridData.jsonFreePersonal[i].PERSHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                //if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                // strPrindData.push("</div>");
                // }


                //medical history start

                if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {

                    if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0)
                        strPrindData.push("</td><td style='width:45%;vertical-align:top;border:1px solid #757676;padding:5px; border-radius: 10px;page-break-inside:avoid'>");

                    // if (GridData.jsonPersonalHist.length == 0 && GridData.jsonFreePersonal.length == 0)
                    //strPrindData.push("<br><div style='width:100%' id='divMedicalHist'>");
                    //else
                    // strPrindData.push("<br><div style='float:right;width:40%;padding-bottom:10%' id='divMedicalHist'>");
                }
                if (GridData.jsonMedicineHist.length > 0) {
                    strPrindData.push("<table id='medicalHistTable' style='border-collapse:collapse;' >");
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'>" + HeaderLang[13] + " :</caption>")
                    for (var i = 0; i < GridData.jsonMedicineHist.length; i++) {
                        strPrindData.push("<tr><td style='font-size:13px !important'><li>" + " " + GridData.jsonMedicineHist[i].NAME);
                        //strPrindData.push("<tr><td style='font-size:13px !important'><li>" + " <b>" + GridData.jsonMedicineHist[i].NAME + "</b>");
                        if (GridData.jsonMedicineHist[i].DURATION != "" && GridData.jsonMedicineHist[i].DURATION != 0)//
                            strPrindData.push(" since " + GridData.jsonMedicineHist[i].DURATION.toString() + " " + gDurType[GridData.jsonMedicineHist[i].DURTYPE] + "(s)");
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                //free medical history
                if (GridData.jsonFreeMedical != "") {
                    strPrindData.push("<table style='border-collapse:collapse;' class='tblFree'>");
                    if (GridData.jsonMedicineHist.length == 0) {
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'>" + HeaderLang[13] + " :</caption>")
                    }
                    for (var i = 0; i < GridData.jsonFreeMedical.length; i++) {

                        strPrindData.push("<tr><td style='font-size:13px !important'><li>" + GridData.jsonFreeMedical[i].MEDHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {
                    //   strPrindData.push("</div>");
                }
                strPrindData.push("</td></tr></table>")
                // strPrindData.push("</div>");/// end personalNMediDiv

                // strPrindData.push("<br>");
            }
            if (GridData.jsonAllergy.length > 0) {
                strPrindData.push("<table  style='width:100%;page-break-inside:avoid'><tr><td style='width:49%;vertical-align:top;border:1px solid #757676;padding:5px; border-radius: 10px;page-break-inside:avoid'>");
                strPrindData.push("<table id='personalallergyTable'>");// border color added by vijeta on 19th march 2018
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'>" + "Allergy" + " :</caption>");
                for (var i = 0; i < GridData.jsonAllergy.length; i++) {
                    var AllgryDurType = GridData.jsonAllergy[i].DURTYPE == "D" ? "Days" : (GridData.jsonAllergy[i].DURTYPE == "W" ? "Week" : GridData.jsonAllergy[i].DURTYPE == "M" ? "Month" : GridData.jsonAllergy[i].DURTYPE == "Y" ? "Year" : "")
                    var AllgryDur = GridData.jsonAllergy[i].DURATION != "" && Number(GridData.jsonAllergy[i].DURATION) > 0 ? GridData.jsonAllergy[i].DURATION : "";
                    //strPrindData.push("<tr><td style='font-size:13px !important'><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");
                    strPrindData.push("<tr><td style='font-size:13px !important'><li>" + GridData.jsonAllergy[i].ALLERGYTYPE + " Allergy - " + GridData.jsonAllergy[i].NAME + (AllgryDur != "" ? (" For " + AllgryDur + " " + AllgryDurType) : ""));
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table></table>");
            }
            // end allergy

            /************************end******************************************/

            //Clinical Notes start
            if (GridData.jsonClinicalHist.length > 0 || GridData.jsonClinicalHist.length > 0) {
                strPrindData.push("<br><label class='HTextsize' style='font-weight:bold'><u>Clinical Notes </u>: </label>")
                strPrindData.push("<table>");
                if (GridData.jsonClinicalHist.length > 0) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'>" + GridData.jsonClinicalHist[0].CLINICALHIST.toString().replace(/\n/g, '<br />') + "</td></tr>");
                }
                strPrindData.push("</table>")
            }
            //Clinical Notes End

            //Exam start
            if (GridData.jsonExam[0]["EXAM"] !== "") {
                strPrindData.push("<br>")
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[10] + "</u>: </label><br><p class='DTextsize' style='padding:5px!important;word-wrap: break-word;'>" + GridData.jsonExam[0]["EXAM"].replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p>"); //.replace(/\n/g, '<br />') added by vijeta on 14th march 2018
            }

            if (GridData.ExamImagePath.length > 0) {
                strPrindData.push("<table id='Imagedata'>")
                //strPrindData.push("<table style='width:60%;'><tr><td><label class='HTextsize' style='font-weight:bold;'>")//3/27/19 added

                var strmrno = ($.session.get('PatMRNO')).toString();
                var strtranNo = ($.session.get('PatTRANNO')).toString();

                datatosend = {
                    MrNo: strmrno,
                    TranNo: strtranNo
                }
                $.ajax({
                    type: 'POST',
                    url: 'RetriveExamImages',
                    data: datatosend,
                    async: false,
                    success: function (ImageData) {

                        if (ImageData.length > 0) {
                            var i = ImageData.length;
                            $.each(ImageData, function (index, element) {
                                var imageStr = "";
                                if ((index % 2 == 0)) {
                                    strPrindData.push("<tr>");
                                }

                                var fileNo = element.split("|");
                                var strUrl = "data:[<media type>];charset=utf-8;base64," + fileNo[1];

                                imageStr += '<td><img id=' + fileNo[0] + ' src="' + strUrl + '" alt="no image found" style="width:350px;height:300px; margin:4px;">';
                                imageStr += '</td>';

                                strPrindData.push(imageStr);

                                if ((index % 2 != 0)) {
                                    strPrindData.push("</tr>");
                                }
                            })
                        }
                        else {

                            imageStr += '<tr><td></td></tr>'
                        }
                    },
                    complete: function () {
                        HoldOn.close();
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                        HoldOn.close();
                    }
                });

                strPrindData.push("</table>");
            }
            //Exam end

            if (GridData.jsonICDOTopology.length > 0) {
                var ICDOTbl = ICDOTable(GridData.jsonICDOTopology, GridData.jsonICDOHistology);
                strPrindData.push(ICDOTbl);
            }

            //med advc start 
            if (GridData.jsonAdvice.length > 0) {
                var medRxTbl = RxTable();
                strPrindData.push(medRxTbl);
            }
            /*--------start---------FollowUp----------------------------------------------------------------------*/
            var dt = "", refDoct = "", AdmAdvDate = "";
            if (GridData.jsonFollowUp.length > 0) {
                var dayNum = "", constString = "";
                refDoct = GridData.jsonFollowUp[0]["REFDOCT"];
                refSpecilist = GridData.jsonFollowUp[0]["REFSPECIALIST"];
                AdmAdvDate = GridData.jsonFollowUp[0]["PROPADMNDT"].toString();
                for (var e = 0; e < GridData.jsonFollowUp.length; e++) {

                    if (refDoct.length > 0) {
                        //strPrindData.push("<br>");
                        var array = refDoct.split(',');
                        if (GridData.jsonFollowUp[e].FOLLOWUPDT.length >= 0) {
                            strPrindData.push("<table style='width:100%;'><tr>");
                        }
                        strPrindData.push("<td style='width:25%;vertical-align:top;' ><label style='font-weight:bold' class='HTextsize' >" + HeaderLang[11] + "</label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><ul style='margin-left:-30px'>");
                        $.each(array, function (index, val) {
                            if (val != "")
                                strPrindData.push("&#9679;<li style='display: inline;list-style:circle'>Dr. " + val.toString().replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                        });
                        strPrindData.push("</ul></td>");
                        strPrindData.push("</tr></table>")
                    }

                    if (refSpecilist.length > 0) {
                        //strPrindData.push("<br>");
                        var arraySpec = refSpecilist.split(',');
                        if (GridData.jsonFollowUp[e].FOLLOWUPDT.length >= 0) {
                            strPrindData.push("<table style='width:100%;'><tr>");
                        }
                        strPrindData.push("<td style='width:25%;vertical-align:top;'><label style='font-weight:bold' class='HTextsize'>" + HeaderLang[15] + "</label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><ul style='margin-left:-30px'>");
                        $.each(arraySpec, function (index, val) {
                            if (val != "")
                                strPrindData.push("&#9679;<li style='display: inline;list-style:circle'>" + val.toString().replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                        });
                        strPrindData.push("</ul></td>");
                        strPrindData.push("</tr><table>")
                    }


                    if (GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().trim() != "")
                        strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'>" + HeaderLang[18] + "</label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    var remark = GridData.jsonFollowUp[e]["REMARK"];
                    if (remark != "")
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'>" + HeaderLang[16] + "</label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize'>" + remark.toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    var adviceInv = "";
                    if (GridData.jsonFollowUp[e].FOLLOWUPDT.length > 0) {
                        dayNum = (GridData.jsonFollowUp[e].FOLLOWUPDT).replace(/[^0-9]+/ig, "");
                        FollowUp = (GridData.jsonFollowUp[e].FOLLOWUPDT).split(dayNum);
                        checkFollowUplanguge(FollowUp, language, 'F')

                        if (dayNum.length > 0) {
                            if (Number(dayNum) > 1) {
                                constString = "s"
                            }
                        }

                        if (GridData.jsonInvstg.length > 0)
                            adviceInv = "with Advised Investigation Reports  if any";
                    }

                    //vijeta 16th march 19
                    if (GridData.jsonFollowUp[e].FOLLOWUPDT == "SOS") {
                        strPrindData.push("<br>");
                        strPrindData.push("<table style='width:100%'>");
                        strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + "Follow Up : " + "&nbsp;" + "SOS" + " if any complaints " + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                    }
                    else if (dayNum != "") {
                        if (GridData.jsonFollowUp[e].APPMNTDT == "") {
                            strPrindData.push("</br><table style='width:100%'>");
                            var TranDate = GridData.jsonUserdtls[0].TRANDATE.split(' ')[0];
                            var CalDate = CalculateAppointDate(TranDate, dayNum, languageWise);
                            strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Follow Up on " + CalDate + "</td></tr></table>")//</label>
                        }
                        else {
                            strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + HeaderLang[8] + "&nbsp;" + dayNum + " " + languageWise + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                        }
                    }

                    if (GridData.jsonFollowUp[e].APPMNTDT != "" && GridData.jsonFollowUp[e].APPMNTTM != "") {
                        strPrindData.push("<br>");
                        strPrindData.push("<table style='width:100%'>");
                        strPrindData.push("<table style='width:100%;'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Your Appointment is booked on " + GridData.jsonFollowUp[e].APPMNTDT + " at " + GridData.jsonFollowUp[e].APPMNTTM + " " + adviceInv + "</td></table><br>");
                    }
                }
            }

            if ($("#chkAdmnAdvice").prop('checked')) {
                var Sentence = (AdmAdvDate != "" ? ("Admission Adviced on " + AdmAdvDate) : "Admission Adviced") + ".";
                //strPrindData.push("<br><table style='width:100%;'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + Sentence + "</td></table>");
                strPrindData.push("</br><span class='HTextsize' style='font-size:14px !important;font-weight:bold'>" + Sentence + "</span>");
            }
            //followup end

            //ChemoPlanning
            if (GridData.ChemoPlan.length > 0) {
                strPrindData.push("<br><table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[30] + "</u>: </label><td></tr>")
            }
            if (GridData.ChemoPlan.length > 0) {
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Plan No. </label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].PLANNO + "</label></td></tr>");
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Chemotherapy Name</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].CHEMONAME + "</label></td></tr>");
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Total Cycle</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].TOTALCYCLE + "</label></td></tr>");
                strPrindData.push("<tr><td width='25px'><label style='color:black;'>Chemo Start Date</label></td><td><label style='width='50px;'>" + ': ' + GridData.ChemoPlan[0].ADVSTARTDATE + "</label></td></tr>");
            }
            //ChemoPlanning end

            //Refered Doctor Note 
            if (GridData.jsonRefDoctNote.length > 0) {
                strPrindData.push("<br><table style='width:100%;'><tr><td class='HTextsize'>" + "<label style='font-weight:bold'><u>" + HeaderLang[31] + "</u>: </label><td></tr>")
            }
            if (GridData.jsonRefDoctNote.length > 0) {
                for (var i = 0; i < GridData.jsonRefDoctNote.length; i++) {
                    var RefNote = "Referred To Dr." + GridData.jsonRefDoctNote[i].REFDOCTNAME.trim() + " - " + GridData.jsonRefDoctNote[i].NOTE.trim()
                    strPrindData.push("<tr><td><label style='color:black;'>" + RefNote + "</label></td></tr>");
                }
                strPrindData.push("</table>");
            }
            //Refered Doctor Note end

            var StrDoctCode = '<%:Session["gDoctCode"]%>';

            // strPrindData.push("<div style='bottom:45;position:absolute;float:right!important'><label style='font-style:Arial;font-size:12px; font-weight:bold;margin-left:440px;margin-bottom:70px'>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</label>");
            //by vijeta 14/03/19  
            //strPrindData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
            //strPrindData.push("<table style='float:right!important;font-family:cambria !important;font-size: 13px !important;' id='tblDoctInfo'><tr>");
            //if (digitsign1 != "")
            //    strPrindData.push("<td><b><img src=" + digitsign1 + "  /></b></td>");
            //if (digitsign2 != "")
            //    strPrindData.push("<td><b><img src=" + digitsign2 + "  /></b></td>");
            //if (digitsign3 != "")
            //    strPrindData.push("<td><b><img src=" + digitsign3 + "  /></b></td>");
            //strPrindData.push("</tr><tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</b></td></tr>");
            ////-- end
            //if (GridData.jsonDoctorDetails[0].SIGN == "") {

            //    strPrindData.push("<tr><td>" + "" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");//vijeta 28/03/19
            //    strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].QUALI + "</td></tr>");
            //    strPrindData.push("<tr><td>" + "Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "</td></tr>");

            //    strPrindData.push("</table>");
            //}
            //else {
            //    //strPrindData.push("<table style='float:right!important;' id='tblDoctInfo'>");
            //    //strPrindData.push("<tr><td style='font-size: 12px !important;'>" + GridData.jsonDoctorDetails[0].SIGN.toString().replace(/\n/g, '<br />') + "</td></tr>");
            //    if (sign1 != "")
            //        strPrindData.push("<tr><td><b><p>" + sign1.replace(/\n/g, "<br />") + "</p></b></td>");
            //    if (sign2 != "")
            //        strPrindData.push("<td><b><p>" + sign2.replace(/\n/g, "<br />") + "</p></b></td>");
            //    if (sign3 != "")
            //        strPrindData.push("<td><b><p>" + sign3.replace(/\n/g, "<br />") + "</p></b></td></tr>");
            //    strPrindData.push("</table>");
            //}
            //strPrindData.push("</div>");

            //Priyanka 16/11/2025
            //strPrindData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
            strPrindData.push("<table style='font-family:cambria !important;font-size: 13px !important; margin-left:80% !important;' id='tblDoctInfo'>");
            if (digitsign1 != "")
                strPrindData.push("<tr><td><b><img src=" + digitsign1 + " style='margin-left:-10%!important;'  /></b></td>");
            if (digitsign2 != "")
                strPrindData.push("<td><b style='text-align:center;' ><img src=" + digitsign2 + " style='margin-left:-10%!important;'  /></b></td>");
            if (digitsign3 != "")
                strPrindData.push("<td><b><img src=" + digitsign3 + " style='margin-left:-10%!important;'  /></b></td></tr>");
            strPrindData.push("<tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</label></b></td></tr>");
            if (GridData.jsonDoctorDetails[0].SIGN == "") {

                strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");
                strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].QUALI + "</td></tr>");
                strPrindData.push("<tr><td>" + "Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "</td></tr>");

                strPrindData.push("</table>");
            }
            else {
                if (sign1 != "")
                    strPrindData.push("<tr><td><p><span>" + sign1.replace(/\n/g, "<br />") + "</span></p></td>");
                if (sign2 != "")
                    strPrindData.push("<td><b>" + sign2.replace(/\n/g, "<br />") + "</b></td>");
                if (sign3 != "")
                    strPrindData.push("<td><b>" + sign3.replace(/\n/g, "<br />") + " </b></td></tr>");
            }

            strPrindData.push("</table>");
            //strPrindData.push("</div>");
            //End




            //Meenakshi added this bottom lines on prescription as per the Hospital setup//
            strPrindData.push("<div style='bottom: 0px;font-size: 11px !important;text-align:center;' class='DTextsize'>");
            strPrindData.push("<hr/>");
            strPrindData.push("<p>" + '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine1")%>' + "</P>");
            strPrindData.push("<p>" + '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("PrescBottomLine2")%>' + "</P>");
            strPrindData.push("</div>");
            //

            strPrindData.push("</div>");

            strPrindData.push("</body></html>");
            return strPrindData.join("");

        }



        function PrintListAJAXCommon(Url, data, fileName, dispurl) {
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
                    //  $.loader.close();
                });
            };
            var fdata = new FormData();
            fdata.append('strHtml', data.strHtml);
            oReq.send(fdata);
        }

        function SearchDoctors() {
            //Declare variables 
            var input, filter, table, tr, td, i;
            input = document.getElementById("DoctorInput");
            filter = input.value.toUpperCase();
            //table = document.getElementById("tblDoctors");
            //tr = table.getElementsByTagName("tr");

            //// Loop through all table rows, and hide those who don't match the search query

            //for (i = 0; i < tr.length; i++) {
            //    td = tr[i].getElementsByTagName("td")[0];
            //    if (td) {
            //        if (td.innerHTML.toUpperCase().indexOf(filter) > -1 && filter.length > 2) {
            //            tr[i].style.display = "";

            //        } else {
            //            tr[i].style.display = "none";

            //        }
            //    }
            //}

            GetDoctors(filter);
        }

        function SearchClinic() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            input = document.getElementById("ClinicInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblclinic");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query

            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1 && filter.length > 2) {
                        tr[i].style.display = "";

                    } else {
                        tr[i].style.display = "none";

                    }
                }
            }
        }

        function GetDoctors(DoctName) {
            if (DoctName.length >= 3) {
                $.ajax({
                    url: 'GetDoctors',
                    type: 'post',
                    datatype: 'json',
                    data: { DoctName: DoctName },
                    success: function (data) {
                        if (data.length > 0) {
                            $('#tblDoctors').empty();
                            $.each(data, function (i, item) {
                                //var rows = "<tr id='" + item.DoctCode + "' style='display:none'>" + "<td>" + item.DoctName + "</td>" + "</tr>";//commented by vijeta on 21st march 2018
                                //style='display:none' 
                                var rows = "<tr id='" + item.DoctCode + "' >" + "<td style='width: 20px'> <input type='checkbox' id='" + item.DoctCode + "' value='" + item.DoctName + "' /> </td>" + "<td>" + item.DoctName + "</td>" + "</tr>"; // checkbox td added by vijeta on 20th march 2018
                                $('#tblDoctors').append(rows);
                            });
                        }
                    }
                });
            }
        }

        function GetCliniclist() {
            $.ajax({
                url: 'GetClinic',
                type: 'post',
                datatype: 'json',
                data: {},
                success: function (data) {
                    if (data.length > 0) {
                        $('#tblclinic').empty();
                        $.each(data, function (i, item) {
                            //var rows = "<tr id='" + item.ClinicCode + "' style='display:none'>" + "<td>" + item.ClinicName + "</td>" + "</tr>";//commented by vijeta on 21st march 2018
                            var rows = "<tr id='" + item.ClinicCode + "' style='display:none'>" + "<td style='width: 20px'> <input type='checkbox' id='" + item.ClinicCode + "' value='" + item.ClinicName + "' /> </td>" + "<td>" + item.ClinicName + "</td>" + "</tr>";//added on 21st march 2018
                            $('#tblclinic').append(rows);
                        });
                    }
                },
                complete: function () {

                    HoldOn.close();


                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();

                }
            });
        }

        function SetDataForPrescriptionPrint() {

            var patcompletedyn = $.session.get('PatCompleted').toString();
            if (patcompletedyn == "Y") {
                // $("#DoctorInput").attr('disabled', 'disabled');
                // $("#txtSurgeryAdvice").attr('disabled', 'disabled');
                //  $("#ClinicInput").attr('disabled', 'disabled');

                //added on 28th July 2018
                // $("#txtAppointmntDate").attr('disabled', 'disabled');
                // $("#txtAppointmntTime").attr('disabled', 'disabled');
                // $("#btnTakeAppointMent").hide();
            }

            var tranNo = $.session.get('PatTRANNO');
            $.ajax({
                url: 'SetDataForPrescriptionPrint',
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo },
                success: function (data) {
                    var SchemeCD = "";
                    if (data) {

                        //$("#DoctorInput").val(data["REFDOCTNAME"].toString());// commented by vijeta on 20th march 2018
                        $("#DoctorShow").val(data["REFDOCTNAME"].toString());// added by vijeta on 20th march 2018

                        $("#Numbers").text(data["DURATION"].toString());
                        $("#DaySelect").text(data["DURATIONTYPE"].toString());

                        $("#hdnDoctCode").val(data["REFDOCTNAME"].toString());
                        //$('#hdnNumber').val(data["DURATION"].toString());
                        //$('#hdnDayselect').val(data["DURATIONTYPE"].toString());

                        //VISHAL SOS 
                        if (data["DURATIONTYPE"].toString() == "SOS") {
                            $('#lblSOS').css("background-color", "green");
                            $("#Numbers").text("0");
                            $("#DaySelect").text("Days");
                            $('#hdnNumber').val("0");
                            $('#hdnDayselect').val("Days");
                            $('#layer-Numbers').css('display', 'none');
                            $('#layer-DMY').css('display', 'none');
                        }
                        else {
                            $('#lblSOS').css("background-color", "#5bc0de");
                            $('#hdnNumber').val(data["DURATION"].toString());
                            $('#hdnDayselect').val(data["DURATIONTYPE"].toString());
                            $('#layer-Numbers').css('display', 'block');
                            $('#layer-DMY').css('display', 'blokc');
                        }
                        $("#txtSurgeryAdvice").val(data["SURGNMADVICE"].toString());
                        $("#hdnSurgeryCode").val(data["SURGNMADVICECODE"].toString());
                        if (data["ADVICEDATE"].toString() != "" && data["SURGNMADVICE"].toString() != "") {
                            $("#txtAdviceDate").val(data["ADVICEDATE"].toString());
                            $("#txtPACAdviceDate").val(data["PACADVICEDATE"].toString());
                        }
                        else {
                            var TDate = new Date();
                            var PACTDate = new Date();
                            TDate.setDate(TDate.getDate() + 1);
                            $("#txtAdviceDate").datepicker("setDate", TDate);
                            var dd = ("0" + TDate.getDate()).slice(-2);
                            var mm = ("0" + (TDate.getMonth() + 1)).slice(-2);
                            var yyyy = TDate.getFullYear();
                            var formattedDate = dd + "/" + mm + "/" + yyyy;
                            HandlePACAdvDate(formattedDate);
                        }
                        var NatOfSurgy = data["NATUREOFSURGY"].toString();
                        if (NatOfSurgy != "")
                            $("#rbtnNatSurg" + NatOfSurgy).prop("checked", true);
                        $("#ClinicShow").val(data["REFSPECIALIST"].toString()); // added by vijeta on 21st match 2018
                        if (data["APPMNTDT"].toString() != "" && data["APPMNTTM"].toString() != "") {
                            $("#txtAppointmntDate").val(data["APPMNTDT"].toString());
                            $("#txtAppointmntTime").empty();
                            $("#txtAppointmntTime").append($("<option>" + data["APPMNTTM"].toString() + "</option>"));
                            $("#appnmtDiv *").attr("disabled", "disabled");//added on 17thjan19
                            $("#anchorBookAppmnt").off('click');////added on 17th jan19
                            appmntAlreadyBookedYn = "Y";
                            $("#appnmtShowDiv").removeClass("hide");//added 16th march 19
                            $("#appmntStringDisplay").text("Your appointment is booked on " + data["APPMNTDT"].toString() + " " + data["APPMNTTM"].toString());//added 16th march 19                          
                            $("#btnTakeAppointMent").hide();//added 16th march 19
                            $("#appnmtDiv").addClass("hide");
                        }

                        $("#PrescriptionRemark").val(data["REMARK"].toString().trim());
                        $("#PlanOfTreatmnt").val(data["PLANOFTREAT"].toString().trim());

                        if (data["CALLDONEYN"].toString().trim() == "Y")
                            $("#chkCallDoneYN")[0].checked = true;

                        if (data["ADMADVYN"].toString().trim() == "Y") {
                            $("#chkAdmnAdvice")[0].checked = true;
                            ShowCareType();
                            $("#CmbCareType").val(data["CARETYPE"].toString());// Added by Rajan 
                        }

                        if (data["TBDREFYN"] != undefined && data["TBDREFYN"].toString().trim() == "Y")        // Added by Dhananjay 20241005
                            $("#chkTBRef")[0].checked = true;

                        $("#txtProposeAdmnDT").val(data["PROPADMNDT"].toString());

                        if (NotesWiseDoct == "Y") {
                            SavedList = data["NOTELIST"].toString().trim() == "" ? [] : JSON.parse(data["NOTELIST"].toString().trim());
                        }
                        SchemeCD = ("" + data["SCHEMECODE"]).toString().trim();
                        $("#cmbLevelOfUrg").val(("" + data["LEVELOFURGENCY"]).toString().trim());
                    }
                    else {
                        var TDate = new Date();
                        var PACTDate = new Date();
                        TDate.setDate(TDate.getDate() + 1);
                        $("#txtAdviceDate").datepicker("setDate", TDate);
                        var dd = ("0" + TDate.getDate()).slice(-2);
                        var mm = ("0" + (TDate.getMonth() + 1)).slice(-2);
                        var yyyy = TDate.getFullYear();
                        var formattedDate = dd + "/" + mm + "/" + yyyy;
                        HandlePACAdvDate(formattedDate);
                        $("#RbtnCancerN").prop("checked", true);
                    }
                    LoadFormDoctNote();
                    BindSavedScheme(SchemeCD);
                    HideUnHideSurgDiv($("#hdnSurgeryCode").val());
                },

                complete: function () {
                    document.body.style.cursor = "default";
                }

            })
        }

        //added on 20th march 2018
        var doctCount = 0;

        $(document.body).on('click', '#tblDoctors input,#tblDoctors tr', function (e) {
            if ($("#DoctorInput").val() != "") {
                var doctCode = $(this)[0].id;
                //var doctName = "";

                if ($(this).is('#tblDoctors input')) {
                    //var doctName1 = $(this)[0].defaultValue.trim().toString();
                    var doctName1 = $(this)[0].parentElement.parentElement.innerText.trim().toString();
                    if ($(this)[0].checked == true) {

                        if (strReferralDocts != "")
                            strReferralDocts = strReferralDocts + "," + doctName1;
                        else
                            strReferralDocts = strReferralDocts + doctName1;

                        if (strReferralDoctCodes != "")
                            strReferralDoctCodes = strReferralDoctCodes + "," + doctCode;
                        else
                            strReferralDoctCodes = strReferralDoctCodes + doctCode;

                        doctCount = Number(doctCount) + 1;
                    }
                    else {

                        var strDoctName = doctName1;
                        var strDoctCode = doctCode;

                        if (doctCount > 1) {
                            strDoctName = "," + doctName1;
                            var strDoctCode = "," + doctCode;
                        }


                        var strDoctCode = "," + doctCode;
                        strReferralDocts = strReferralDocts.replace(strDoctName, "");
                        strReferralDoctCodes = strReferralDoctCodes.replace(strDoctCode, "");

                        doctCount = Number(doctCount) - 1;
                    }
                    e.stopPropagation();
                }
                else if ($(this).is('#tblDoctors tr')) {
                    var doctName = $(this)[0].innerText.trim().toString();

                    if ($(this)[0].children[0].children[0].checked == false) {

                        if (strReferralDocts != "")
                            strReferralDocts = strReferralDocts + "," + doctName;
                        else
                            strReferralDocts = strReferralDocts + doctName;

                        if (strReferralDoctCodes != "")
                            strReferralDoctCodes = strReferralDoctCodes + "," + doctCode;
                        else
                            strReferralDoctCodes = strReferralDoctCodes + doctCode;

                        $(this)[0].children[0].children[0].checked = true;

                        doctCount = Number(doctCount) + 1;
                    }
                    else {
                        var strDoctName = doctName;
                        var strDoctCode = doctCode;

                        if (doctCount > 1) {
                            strDoctName = "," + doctName;
                            strDoctCode = "," + doctCode;
                        }

                        strReferralDocts = strReferralDocts.replace(strDoctName, "");
                        strReferralDoctCodes = strReferralDoctCodes.replace(strDoctCode, "");
                        $(this)[0].children[0].children[0].checked = false;

                        doctCount = Number(doctCount) - 1;
                    }
                }
                $("#DoctorShow").val("");
                $("#DoctorShow").val(strReferralDocts);
                $("#hdnDoctCode").val(strReferralDoctCodes);
            }
            else {

            }
        });

        //added on 21st march 2018
        var clinicCount = 0;
        $(document.body).on('click', '#tblclinic input,#tblclinic tr', function (e) {
            var clinicCode = $(this)[0].id;
            //var doctName = "";

            if ($(this).is('#tblclinic input')) {

                var clinicName1 = $(this)[0].parentElement.parentElement.innerText.trim().toString();
                if ($(this)[0].checked == true) {

                    if (strReferralClinics != "")
                        strReferralClinics = strReferralClinics + "," + clinicName1;
                    else
                        strReferralClinics = strReferralClinics + clinicName1;

                    if (strReferralClinicCodes != "")
                        strReferralClinicCodes = strReferralClinicCodes + "," + clinicCode;
                    else
                        strReferralClinicCodes = strReferralClinicCodes + clinicCode;

                    clinicCount = Number(clinicCount) + 1;
                }
                else {
                    var strClinicName = clinicName1;
                    var strClinicCode = clinicCode;

                    if (clinicCount > 1) {
                        strClinicName = "," + clinicName1;
                        strClinicCode = "," + clinicCode;
                    }

                    strReferralClinics = strReferralClinics.replace(strClinicName, "");
                    strReferralClinicCodes = strReferralClinicCodes.replace(strClinicCode, "");

                    clinicCount = Number(clinicCount) - 1;
                }
                e.stopPropagation();
            }
            else if ($(this).is('#tblclinic tr')) {
                var clinicName = $(this)[0].innerText.trim().toString();

                if ($(this)[0].children[0].children[0].checked == false) {

                    if (strReferralClinics != "")
                        strReferralClinics = strReferralClinics + "," + clinicName;
                    else
                        strReferralClinics = strReferralClinics + clinicName;


                    if (strReferralClinicCodes != "")
                        strReferralClinicCodes = strReferralClinicCodes + "," + clinicCode;
                    else
                        strReferralClinicCodes = strReferralClinicCodes + clinicCode;

                    $(this)[0].children[0].children[0].checked = true;

                    clinicCount = Number(clinicCount) + 1;
                }
                else {

                    var strClinicName = clinicName;
                    var strClinicCode = clinicCode;

                    if (clinicCount > 1) {
                        strClinicName = "," + clinicName;
                        strClinicCode = "," + clinicCode;
                    }

                    strReferralClinics = strReferralClinics.replace(strClinicName, "");
                    strReferralClinicCodes = strReferralClinicCodes.replace(strClinicCode, "");
                    $(this)[0].children[0].children[0].checked = false;

                    clinicCount = Number(clinicCount) - 1;
                }

            }
            $("#ClinicShow").val("");
            $("#ClinicShow").val(strReferralClinics);
            $("#hdnclinic").val(strReferralClinicCodes);
        });

        //added on 13th march 19
        function SearchSurgery() {
            HoldOn.open();
            var txtSurg = $("#SurgeryInput").val();
            if (txtSurg.length > 2) {
                $.ajax({
                    url: 'GetSurgeries',
                    type: 'post',
                    datatype: 'json',
                    data: { strSurgName: txtSurg },
                    success: function (data) {
                        if (data.length > 0) {
                            $('#tblSurgery').empty();
                            var SurgChkLst = $("#hdnSurgeryCode").val().split(',');
                            $.each(data, function (i, item) {

                                //var rows = "<tr id='" + item.DoctCode + "' style='display:none'>" + "<td>" + item.DoctName + "</td>" + "</tr>";//commented by vijeta on 21st march 2018
                                var rows = "<tr id='" + item.SurgCode + "' style=''>" + "<td style='width: 20px'> <input type='checkbox' id='" + item.SurgCode + "' value='" + item.SurgName + "' /> </td>" + "<td>" + item.SurgName + "</td>" + "</tr>";

                                $('#tblSurgery').append(rows);
                                if (SurgChkLst.includes(item.SurgCode)) {
                                    $("#tblSurgery tr#" + item.SurgCode + " input[type='checkbox']").prop("checked", true);
                                }
                            });
                        }
                    },
                    complete: function () {
                        HoldOn.close();
                    }

                });
            }
            else {
                $('#tblSurgery').empty();
                HoldOn.close();//27-11-19
            }
        }
        function OKbutton() {

            HoldOn.open();

            //if (PrintWithLetterHead == "Y") 
            // {

            var Mrno = ($.session.get('PatMRNO'));
            var datatosend = {
                printdata: encodeURIComponent(Html),
                TranNo: ($.session.get('PatTRANNO')),
                Mrno: Mrno,
                printdataTop: encodeURIComponent(HtmlTop)
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/PrintPrescription",
                async: false,
                data: datatosend,
                dataType: "json",
                success: function (response) {
                    if (response == "Success") {

                        var url = 'DisplayPrintTemplate?FormName=' + $.session.get('PatName').toString();
                        //var win = window.open(url, '_blank');
                        var win = window.open(url, '', 'width=1024, height=700');
                        //win.document.write(Html);
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
            //}
               <%--else {
                   var myWindow = window.open('', '', '"<%=Server.MapPath("~/")%>"');
                   myWindow.document.write(Html);
                   myWindow.document.close();
                   myWindow.focus();

                   var ind = Html.toString().trim().indexOf("Imagedata");
                   if (ind > 0) {
                       setTimeout(function () {
                           myWindow.print();
                           myWindow.close();
                       }, 600);
                   }
                   else {

                       setTimeout(function () {
                           myWindow.print();
                           myWindow.close();
                       }, 100);
                   }
                   HoldOn.close();

               }--%>

        }
        function NotOKbutton() {

            window.location.href = '../DoctorDesk/RxNewSearch';
        }
        var surgCount = 0;
        $(document.body).on('click', '#tblSurgery input', function (e) {
            var SurgeryCode = $(this)[0].id;
            let selectedNames = [];
            let selectedCodes = [];
            var SurgeryCode = this.id;
            var hdnVal = $('#hdnSurgeryCode').val();
            var hdnTxt = $('#txtSurgeryAdvice').val();
            if (!this.checked) {
                var checkboxValue = $('#' + SurgeryCode).find('input[type="checkbox"]').val();
                let codesArray = hdnVal.split(',');
                codesArray = codesArray.filter(function (code) {
                    return code !== SurgeryCode;
                });
                $('#hdnSurgeryCode').val(codesArray.join(','));
                let NmArray = hdnTxt.split('\n');
                NmArray = NmArray.filter(function (code) {
                    return code !== checkboxValue;
                });
                $('#txtSurgeryAdvice').val(NmArray.join('\n'));
            }
            var alreadyCheckedSurgCD = $('#hdnSurgeryCode').val().split(',');
            var alreadyCheckedSurgNM = $('#txtSurgeryAdvice').val().split('\n');
            $('#tblSurgery input[type="checkbox"]:checked').each(function () {
                selectedNames.push($(this).val());
                selectedCodes.push($(this).attr('id'));
            });
            var allCodes = alreadyCheckedSurgCD.concat(selectedCodes);
            var allNM = alreadyCheckedSurgNM.concat(selectedNames);
            var uniqueCodesSet = new Set(allCodes);
            var uniqueNMSet = new Set(allNM);
            var mergedNM = Array.from(uniqueNMSet).filter(function (x) {
                return x.trim() !== '';
            });
            var mergedCD = Array.from(uniqueCodesSet).filter(function (x) {
                return x.trim() !== '';
            });
            $('#txtSurgeryAdvice').val(mergedNM.length > 1 ? mergedNM.join('\n') : mergedNM.join(''));
            $('#hdnSurgeryCode').val(mergedCD.join(','));
            HideUnHideSurgDiv(mergedCD.join(','));
        });
        function autoResizeTextarea(el) {
            el.style.height = 'auto';
            el.style.height = (el.scrollHeight + 10) + 'px';
        }

        function GetSurgeryList() {
            $.ajax({
                url: 'GetSurgeries',
                type: 'post',
                datatype: 'json',
                data: {},
                success: function (data) {
                    if (data.length > 0) {
                        $('#tblSurgery').empty();

                        $.each(data, function (i, item) {

                            //var rows = "<tr id='" + item.DoctCode + "' style='display:none'>" + "<td>" + item.DoctName + "</td>" + "</tr>";//commented by vijeta on 21st march 2018
                            var rows = "<tr id='" + item.SurgCode + "' style='display:none'>" + "<td style='width: 20px'> <input type='checkbox' id='" + item.SurgCode + "' value='" + item.SurgName + "' /> </td>" + "<td>" + item.SurgName + "</td>" + "</tr>";

                            $('#tblSurgery').append(rows);

                        });
                    }
                }

            });
        }

        //Save on back button vijeta 29/03/19
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './PrescriptionPrint');

                $(window).on('popstate', function () {
                    //based on setup it will get call 
                    if (autoComplete == "Y")
                        SaveFollowUpPrint("", "M");
                    else
                        SaveFollowUpPrint("", "N");
                });
            }
        });

        //Added By Rajan
        function ShowCareType() {
            if ($("#chkAdmnAdvice").prop("checked") == true && CareTypeShowYN != "" && CareTypeShowYN != "N") {
                document.getElementById("TblCareType").style.display = "table";
                AppendPatCareType();
            }
            else {
                document.getElementById("TblCareType").style.display = "none";
            }

            if ($("#chkAdmnAdvice").prop("checked") == true) {
                document.getElementById("DivLevelOfUrg").style.display = "block";
            }
            else {
                document.getElementById("DivLevelOfUrg").style.display = "none";
                $("#cmbLevelOfUrg").val("");
            }

        }
        //Added By Rajan
        function AppendPatCareType() {
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            $("#CmbCareType").empty();
            var Options = Option.replace("{VALUE}", "").replace("{TEXT}", "---Select---");
            jQuery.grep(CareTypeLst, function (e) {
                if (e.Status == "A")
                    Options = Options + Option.replace("{VALUE}", e.Value).replace("{TEXT}", e.Text);
            });
            $("#CmbCareType").append(Options);
        }

        function ClearSurgeryAdvice() {
            $("#txtSurgeryAdvice").val("");
            $("#hdnSurgeryCode").val("");
        }

        function CalculateAppointDate(TranDate, Increase, IncreaseType) {
            var parts = TranDate.split('/');
            var dateObj = new Date(parts[2] + "-" + parts[1] + "-" + parts[0]);
            if (IncreaseType.trim().toUpperCase().includes("D")) {
                dateObj.setDate(dateObj.getDate() + Number(Increase));
            }
            else if (IncreaseType.trim().toUpperCase().includes("W")) {
                dateObj.setDate(dateObj.getDate() + (Number(Increase)) * 7);
            }
            else if (IncreaseType.trim().toUpperCase().includes("M")) {
                dateObj.setMonth(dateObj.getMonth() + Number(Increase));
            }
            else if (IncreaseType.trim().toUpperCase().includes("Y")) {
                dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
            }
            else {
                dateObj.setDate(dateObj.getDate() + Number(Increase));
            }
            //switch (IncreaseType) {
            //    case "Day":
            //        dateObj.setDate(dateObj.getDate() + Number(Increase));
            //        break;
            //    case "Week":
            //        dateObj.setDate(dateObj.getDate() + (Number(Increase)) * 7);
            //        break;
            //    case "Month":
            //        dateObj.setMonth(dateObj.getMonth() + Number(Increase));
            //        break;
            //    case "Year":
            //        dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
            //        break;
            //    default:
            //        console.warn("Invalid IncreaseType");
            //}
            var dd = String(dateObj.getDate()).padStart(2, '0');
            var mm = String(dateObj.getMonth() + 1).padStart(2, '0');
            var yyyy = dateObj.getFullYear();
            return (dd + "/" + mm + "/" + yyyy);
        }

        function ICDOTable(TopologyLst, HistologyLst) {
            TopologyLst = TopologyLst == "" ? [] : TopologyLst;
            HistologyLst = HistologyLst == "" ? [] : HistologyLst;
            var ICDOTbl = "<table style='width:99%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;font-family:cambria !important;'><u>ICD-O Diagnosis</u>: </label></td></tr></table>";
            var MainDiv = '<div id="MainDiv" style="width:99.9%;float:left;border: 1px solid #9d9d9d;margin-bottom:10px;font-family:cambria !important;">{MAINDIVCONTENT}</div>';
            var TopoHeader = '<div style="width:100%;float:left;font-weight:bold;padding: 5px 0px;"><label class="HTextsize" style="font-weight:bold;font-family:cambria !important;">Topography - {TOPOLOGYNAME}</label></div>';
            var HistoTbl = ' <table style="width:100%;float:left;empty-cells: hide;border-collapse: collapse;border: 1px solid #9d9d9d;font-family:cambria !important;">{HISTOTABLECONTENT} </table>';
            //var HistoTblHead = '<thead style="border: 1px solid #9d9d9d;"><tr><td style="border: 1px solid #9d9d9d;width:15%;font-family:cambria !important;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Code Generated</label></td><td style="border: 1px solid #9d9d9d;width:30%;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Topology</label></td><td style="border: 1px solid #9d9d9d;width:30%;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Histology/Behaviour</label></td><td style="width:20%;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Grade</label></td></tr></thead>';
            var HistoTblHead = '<thead style="border: 1px solid #9d9d9d;"><tr><td style="border: 1px solid #9d9d9d;width:120px;font-family:cambria !important;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Code Generated</label></td><td style="border: 1px solid #9d9d9d;text-align:center;"><label class="HTextsize" style="font-weight:bold;">Description</label></td></tr></thead>';
            var HistoTblBody = '<tbody>{HISTOBODYCONTENT}</tbody>';
            var Tr = '<tr style="border: 1px solid #9d9d9d;font-family:cambria !important;">{TRCONTENT}</tr>';
            var Td = '<td style="border: 1px solid #9d9d9d;text-align:center;"><label class="DTextsize" style="font-family:cambria !important;">{TDCONTENT}</label></td>';
            var TNMDiv = '<div style="width:100%;float:left;font-family:cambria !important;">{TNMCONTENT}</div>';
            var TNMTbl = '<table style="width:100%;float:left;font-family:cambria !important;">{TNMTABLECONTENT}</table>';
            var TNMFirstRow = '<tr><td><label class="HTextsize"><span style="font-weight:bold;width:80px;display: inline-block;">Site</span><span style="font-weight:bold;display: inline-block;;padding-right:5px"> : </span>{SITENAME}</label></td><td><label class="HTextsize"><span style="font-weight:bold;width:80px;display: inline-block;">Sub-Site</span><span style="font-weight:bold;display: inline-block;padding-right:5px;"> : </span>{SUBSITENAME}</label></td>' +
                '<td><label class="HTextsize" style="display:inline-block;"><span style="font-weight:bold;width:80px;display:inline-block;">TNM</span><span style="font-weight:bold;display: inline-block;padding-right:5px"> : </span>{PREFIX}{TNM}</label></td</tr>'
            var StageRow = '<tr><td><label class="HTextsize"><span style="font-weight:bold;width:80px;display:inline-block;">Stage</span><span style="font-weight:bold;display: inline-block;padding-right:5px;"> : </span>{STAGE}</label></td></tr>';
            //var TNMSecondRow = '<tr><td><label class="HTextsize" style="display:inline-block;"><span style="font-weight:bold;width:80px;display:inline-block;">TNM</span><span style="font-weight:bold;display: inline-block;padding-right:5px"> : </span>{PREFIX}{TNM}</label></td><td><label class="HTextsize"><span style="font-weight:bold;width:80px;display:inline-block;">Stage</span><span style="font-weight:bold;display: inline-block;padding-right:5px;"> : </span>{STAGE}</label></td></tr>';
            for (var i = 0; i < TopologyLst.length; i++) {
                var RplTopoHeader = TopoHeader.replace("{TOPOLOGYNAME}", (TopologyLst[i].TOPOCODE + " - " + TopologyLst[i].TOPONAME));
                var FilterHisto = HistologyLst.filter(function (a) {
                    return a.TOPOCODE.toString().trim() == TopologyLst[i].TOPOCODE.toString().trim() && a.TOPONAME.toString().trim() == TopologyLst[i].TOPONAME.toString().trim();
                });
                var HistBody = "";
                jQuery.grep(FilterHisto, function (e) {
                    var GenCode = e.TOPOCODE.toString().trim() + e.HISTOCODE.toString().trim() + " " + e.GRADE.toString().trim();
                    var GenCodeTd = Td.replace("{TDCONTENT}", GenCode);
                    //var TopoTd = Td.replace("{TDCONTENT}", (e.TOPOCODE.toString().trim() + " - " + e.TOPONAME.toString().trim()));
                    //var HistoTd = Td.replace("{TDCONTENT}", (e.HISTOCODE.toString().trim() + " - " + e.HISTONAME.toString().trim()));
                    //var GradeTd = Td.replace("{TDCONTENT}", (e.GRADE.toString().trim() + " - " + e.GRADENAME.toString().trim()));
                    //var RplTr = Tr.replace("{TRCONTENT}", (GenCodeTd + TopoTd + HistoTd + GradeTd));
                    var DescTd = '<td class="DTextsize" style="border: 1px solid #9d9d9d;font-family:cambria !important;"><label>' + (e.TOPONAME.toString().trim() + ", " + e.HISTONAME.toString().trim() + ", " + e.GRADENAME.toString().trim()) + '</label></td>';
                    var RplTr = Tr.replace("{TRCONTENT}", (GenCodeTd + DescTd));
                    HistBody = HistBody + RplTr;
                });
                var RplHistoTblBody = HistoTblBody.replace("{HISTOBODYCONTENT}", HistBody);
                var RplHistoTbl = HistBody == "" ? "" : HistoTbl.replace("{HISTOTABLECONTENT}", (HistoTblHead + RplHistoTblBody));
                var TNMVal = TopologyLst[i].T + TopologyLst[i].N + TopologyLst[i].M;
                var RplTNMFirstRow = TNMFirstRow.replace("{SITENAME}", TopologyLst[i].SITE).replace("{SUBSITENAME}", TopologyLst[i].SUBSITE).replace("{PREFIX}", TopologyLst[i].PREFIX).replace("{TNM}", TNMVal);
                //var RplTNMSecondRow = TNMSecondRow.replace("{PREFIX}", TopologyLst[i].PREFIX).replace("{TNM}", TNMVal).replace("{STAGE}", TopologyLst[i].STAGE);
                var RplRemRow = OtherFieldICDO(TopologyLst[i]);
                var RplStageRow = StageRow.replace("{STAGE}", TopologyLst[i].STAGE);
                var RplTNMTbl = TNMTbl.replace("{TNMTABLECONTENT}", (RplTNMFirstRow + RplRemRow + RplStageRow));
                var RplTNM = TNMDiv.replace("{TNMCONTENT}", RplTNMTbl);
                var RplMainDiv = MainDiv.replace("{MAINDIVCONTENT}", (RplTopoHeader + RplHistoTbl + RplTNM));
                ICDOTbl = ICDOTbl + RplMainDiv;
            }
            return ICDOTbl;
        }

        function OtherFieldICDO(OtherDtls) {
            var OtherFieldList = [
                { ID: "GEOGRAPHIC", LABEL: "Geographic" },
                { ID: "LOCATION", LABEL: "Location" },
                { ID: "MITOTIC", LABEL: "Mitotic" },
                { ID: "PSA", LABEL: "PSA" },
                { ID: "SERUMMARKERS", LABEL: "Serum Markers" },
                { ID: "HERITABLETRAIT", LABEL: "Heritable Trait" },
                { ID: "HER2", LABEL: "HER2" },
                { ID: "ER", LABEL: "ER" },
                { ID: "PR", LABEL: "PR" },
                { ID: "BLOODINVL", LABEL: "Blood invl." },
            ];
            var TR = '<tr>{TRCONTENT}</tr>';
            var TD = '<td><label class="HTextsize"><span style="font-weight:bold;width:80px;display: inline-block;">{LABEL}</span><span style="font-weight:bold;display: inline-block;;padding-right:5px"> : </span>{CONTENT}</label></td>';
            var MaxCount = 3;
            var html = '';
            var rowContent = '';
            var count = 0;
            for (var i = 0; i < OtherFieldList.length; i++) {
                var item = OtherFieldList[i];
                var value = (OtherDtls && OtherDtls[item.ID] && OtherDtls[item.ID].toString().trim() !== '') ? OtherDtls[item.ID] : null;
                if (value === null) continue;
                var tdHTML = TD.replace('{LABEL}', item.LABEL).replace('{CONTENT}', OtherDtls[item.ID]);
                rowContent += tdHTML;
                count++;
                if (count % MaxCount === 0) {
                    html += TR.replace('{TRCONTENT}', rowContent);
                    rowContent = '';
                }
            }
            if (rowContent !== '') {
                html += TR.replace('{TRCONTENT}', rowContent);
            }
            return html;
        }

        function HideUnHideSurgDiv(strSurCodes) {
            if (strSurCodes == "") {
                document.getElementById("SurgMainDiv").style.display = "none";
                document.getElementById("SchemeMainDiv").style.display = "none";
                $("#rbtnNatSurgR").prop("checked", false);
                $("#rbtnNatSurgE").prop("checked", false);
                $("#rbtnNatSurgT").prop("checked", false);
                ClearSurgeryAdvice();
            }
            else {
                document.getElementById("SurgMainDiv").style.display = "block";
                if (AllSchemeList.length > 0)
                    document.getElementById("SchemeMainDiv").style.display = "flex";
                else
                    document.getElementById("SchemeMainDiv").style.display = "none";
            }
            var textarea = document.getElementById('txtSurgeryAdvice');
            autoResizeTextarea(textarea);
        }
    </script>

    <style>
        .DoctContNote {
        }

        .MainSepNoteDoctDiv {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            padding: 10px 5px;
            background-color: #f8fbfc;
            border-bottom: 2px solid #ebebeb;
            border-radius: 10px;
        }

        .SpeciDelIcon {
            font-size: 18px;
            width: 5%;
            margin-top: 5px;
            cursor: pointer;
        }

        .MainSepDoctDiv {
            width: 30%;
            display: flex;
            align-items: center;
        }

        .DrLbl {
            width: 40px;
            margin: 0px;
        }

        .CmbMainSepDoct {
            width: 90%;
        }

        .TxtMainSepNote {
            width: 60%;
            resize: none;
        }

    </style>

    <script type="text/javascript">
        var DoctList = [];
        var NoteList = [];
        var SavedList = [];
        function LoadFormDoctNote() {
            $("#DoctContNoteDiv").empty();
            GetDoctForNotes();
            BindRefDoctNote();
        }

        function GetDoctForNotes() {
            $.ajax({
                url: 'GetDoctors',
                type: 'post',
                datatype: 'json',
                data: { DoctName: "", Type: "P" },
                async: false,
                success: function (data) {
                    DoctList = data == "" ? [] : data;
                }
            });
        }

        function BindRefDoctNote() {
            $.grep(SavedList, function (a) {
                AddRefDoctNote();
                var Ind = NoteList[NoteList.length - 1].IND;
                var DoctComboId = "DOCT_NOTE_C_" + Ind;
                var NoteTxtId = "DOCT_NOTE_T_" + Ind;
                $("#" + DoctComboId).val(a.REFDOCTCODE);
                $("#" + NoteTxtId).val(a.NOTE);
                $("#" + NoteTxtId).trigger("change");
            });
        }

        function ValidationAddRefDoctNote() {
            return true;
        }

        function AddRefDoctNote() {
            var Ind = NoteList.length > 0 ? (NoteList[NoteList.length - 1].IND + 1) : 1;
            if (ValidationAddRefDoctNote() == true) {
                var MainDiv = "<div id='{MAINDIVID}' class='MainSepNoteDoctDiv'>{MAINCONTENTDIV}</div>";
                var DelIcon = "<i class='fa fa-trash SpeciDelIcon' aria-hidden='true' onclick=\"UpdateDoctNote('R','" + Ind + "')\"></i>";
                var DoctCombo = "<div class='MainSepDoctDiv'><label class='DrLbl'>Dr.</label><select class='form-control CmbMainSepDoct' id='{COMBOID}' onchange=\"UpdateDoctNote('U','" + Ind + "')\"></select></div>";
                var NoteTxt = " <textarea class='form-control TxtMainSepNote' id='{NOTETEXTAREAID}'onchange=\"UpdateDoctNote('U','" + Ind + "'); autoResize(this.id);\" oninput='autoResize(this.id);' placeholder='Enter Notes'></textarea>";
                var MainDivId = "DOCT_NOTE_M_" + Ind;
                var DoctComboId = "DOCT_NOTE_C_" + Ind;
                var NoteTxtId = "DOCT_NOTE_T_" + Ind;
                var RplDoctCombo = DoctCombo.replace("{COMBOID}", DoctComboId);
                var RplNoteTxt = NoteTxt.replace("{NOTETEXTAREAID}", NoteTxtId);
                var AllDiv = MainDiv.replace("{MAINDIVID}", MainDivId).replace("{MAINCONTENTDIV}", (DelIcon + RplDoctCombo + RplNoteTxt));
                $("#DoctContNoteDiv").append(AllDiv);
                AddDoctlst(DoctComboId);
                $("#" + DoctComboId).val("");
                $("#" + NoteTxtId).val("");
                UpdateDoctNote("N", Ind);
                $("#" + NoteTxtId).trigger("change");
            }
        }

        function AddDoctlst(CmbDoctId) {
            var DOption = "<option value='{OPTVALUE}'>{OPTTEXT}</option>";
            var RplDefOption = DOption.replace("{OPTVALUE}", "").replace("{OPTTEXT}", "---Select---");
            $.grep(DoctList, function (a) {
                var FilterNotes = NoteList.filter(function (A) { return A.REFDOCTCODE == a.DoctCode; });
                if (FilterNotes.length == 0) {
                    var RplDOption = DOption.replace("{OPTVALUE}", a.DoctCode).replace("{OPTTEXT}", a.DoctName);
                    RplDefOption = RplDefOption + RplDOption;
                }
            });
            $(("#" + CmbDoctId)).empty();
            $(("#" + CmbDoctId)).append(RplDefOption);
        }

        function UpdateDoctNote(ActType, Ind) {
            var DoctComboId = "DOCT_NOTE_C_" + Ind;
            var NoteTxtId = "DOCT_NOTE_T_" + Ind;
            var DoctorCD = $("#" + DoctComboId).val();
            var DoctorNM = $('#' + DoctComboId + ' option:selected').text();
            var NoteTXT = $("#" + NoteTxtId).val();
            if (ActType == "N") {
                var NewLst = {
                    REFDOCTCODE: DoctorCD,
                    DOCTNAME: DoctorNM,
                    NOTE: NoteTXT,
                    IND: Ind
                }
                NoteList.push(NewLst);
            }
            else if (ActType == "U") {
                $.grep(NoteList, function (a) {
                    if (a.IND == Ind) {
                        a.REFDOCTCODE = DoctorCD;
                        a.DOCTNAME = DoctorNM;
                        a.NOTE = NoteTXT;
                    }
                });
            }
            else if (ActType == "R") {
                var MainDivId = "DOCT_NOTE_M_" + Ind;
                if (document.getElementById(MainDivId)) {
                    document.getElementById(MainDivId).remove();
                }
                var TData = JSON.parse(JSON.stringify(NoteList));
                var FData = TData.filter(function (c) { return c.IND != Ind; });
                NoteList = FData;
            }
        }

        function autoResize(Id) {
            var textarea = document.getElementById(Id);
            textarea.style.height = '34px';
            textarea.style.height = (textarea.scrollHeight + 5) + 'px';
        }

        function DisableAllField() {
            $('.content *').not('#TempFormat * , #DivPrintWithHist *').prop('disabled', true);
            $('.content *').not('#TempFormat * , #DivPrintWithHist *').css('cursor', 'not-allowed');
            $('.content i').not('#TempFormat i , #DivPrintWithHist *').addClass('disabled-icon').css('cursor', 'not-allowed');
            $('#MarkComplete,#anchorBookAppmnt,#openCalendarBtn,#btnSave,#btnCompleted').hide();
        }

    </script>

    <%-- Scheme --%>
    <script type="text/javascript">
        var SchemeListForSave = [];
        var AllSchemeList = [];
        function SearchScheme() {
            $("#tblSchemeWrapper").css('display', 'block');
            $("#tblScheme tr").show();
            $("#tblScheme tbody").show();
            var input, filter, table, tr, td, i;
            input = document.getElementById("SchemeInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblScheme");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[1];
                if (td) {
                    if ((filter.length > 2 && td.innerHTML.toUpperCase().indexOf(filter) > -1) || filter.length <= 2) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function SchemePatList() {
            var strMRNo = $.session.get('PatMRNO');
            var strCompCode = $.session.get('ComCode');
            AllSchemeList = [];
            $.ajax({
                url: '../DoctorDesk/GetSchemaList',
                data: { PatMRNO: strMRNo, Speciality: "S", strCompCode: strCompCode },
                type: 'post',
                async: true,
                datatype: 'json',
                success: function (response) {
                    if (response.length > 0) {
                        $('#tblScheme').empty();
                        $.each(response, function (i, item) {
                            var rows = "<tr id=TR_'" + item.Value + "' style='display:none'>" + "<td style='width: 20px'> <input type='checkbox' onclick='UpdateSchemeDataForSave(this.id)' id='" + item.Value + "' value='" + item.Text + "' /> </td>" + "<td style='text-align: left;padding: 12px;'>" + item.Text + "</td>" + "</tr>";
                            $('#tblScheme').append(rows);
                        });
                        AllSchemeList = response;
                    }
                    else {
                        document.getElementById("SchemeMainDiv").style.display = "none";
                    }
                }
            });
        }

        function UpdateSchemeDataForSave(ChckId) {
            var CheckedYN = $("#" + ChckId).prop("checked");
            var FilterScheme = AllSchemeList.filter(function (item) { return item.Value.trim() == ChckId.trim(); });
            var TList = SchemeListForSave.filter(function (item) { return item != ChckId.trim(); });
            if (CheckedYN == true) {
                AddSchemeData(FilterScheme[0].Value.trim(), FilterScheme[0].Text.trim());
                TList.push(FilterScheme[0].Value.trim());
            }
            else {
                RemoveSchemeData(ChckId);
            }
            SchemeListForSave = TList;
        }

        function AddSchemeData(SchemeCode, SchemeName) {
            var Tr = "<tr id='{TRID}'>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            var TRID = "TR_SCH_" + SchemeCode;
            var RemIcon = "<i class='fa fa-trash REMOVESCHICON' style='font-size: 18px;' aria-hidden='true' onclick=\"$('#{SCHEMECODE}').trigger('click');\"></i>";
            var InfoIcon = "<i class='fa fa-info-circle INFOSCHICON' style='font-size: 18px;' aria-hidden='true' onclick=\"OpenPopInfoScheme('{SCHEMECODE}')\"></i>";
            var ActDiv = "<div style='display: flex;align-items: center;justify-content: center;gap: 20px;'>{DIVCONTENT}</div>";
            var RplRemIcon = RemIcon.replace("{SCHEMECODE}", SchemeCode);
            var RplInfoIcon = InfoIcon.replace("{SCHEMECODE}", SchemeCode);
            var RplActDiv = ActDiv.replace("{DIVCONTENT}", (RplRemIcon + RplInfoIcon));
            var ActTd = Td.replace("{STYLE}", "").replace("{TDCONTENT}", RplActDiv);
            var NameTd = Td.replace("{STYLE}", "style='text-align: left;'").replace("{TDCONTENT}", SchemeName);
            var RplTR = Tr.replace("{TRID}", TRID).replace("{TRCONTENT}", (ActTd + NameTd));
            $("#TableSchemeTBody").append(RplTR);
        }

        function RemoveSchemeData(SchemeCode) {
            var TRID = "TR_SCH_" + SchemeCode;
            if (document.getElementById(TRID)) {
                document.getElementById(TRID).remove();
            }
        }

        function GetSchemeInfo(SchemeCode) {
            var SchemeInfoDtls = [];
            $.ajax({
                url: '../DoctorDesk/GetSchemaInfo',
                data: { SchemeCode: SchemeCode },
                type: 'post',
                async: false,
                datatype: 'json',
                success: function (response) {
                    if (response != "") {
                        SchemeInfoDtls = response;
                    }
                }
            });
            return SchemeInfoDtls;
        }

        function BindSchemeInfo(SchemeCode) {
            var Dtls = GetSchemeInfo(SchemeCode);
            document.getElementById("SchemeLbl").innerText = Dtls[0][0].SCHEMENAME;
            document.getElementById("PreReqLbl").innerText = Dtls[0][0].PREADVICE;
            document.getElementById("AdvRmksLbl").innerText = Dtls[0][0].POSTADVICE;
            if (Dtls[1] != null && Dtls[1].length > 0) {
                var PreData = "";
                var PostData = "";
                $.grep(Dtls[1], function (e) {
                    if (e.LINKTYPE == "P")
                        PreData = PreData + (PreData == "" ? e.SERVNAME : ("," + e.SERVNAME));
                    if (e.LINKTYPE == "O")
                        PostData = PostData + (PostData == "" ? e.SERVNAME : ("," + e.SERVNAME));
                });
                document.getElementById("PreInvstLbl").innerText = PreData;
                document.getElementById("PostInvstLbl").innerText = PostData;
            }
        }

        function BindSavedScheme(CodeLst) {
            if (CodeLst == "") {
                document.getElementById("SchemeMainDiv").style.display = "none";
            }
            else {
                document.getElementById("SchemeMainDiv").style.display = "flex";
                var SpltCodeLst = CodeLst.split(',');
                $.grep(SpltCodeLst, function (e) {
                    if (e.trim() != "" && document.querySelector('#tblScheme input[type="checkbox"][id="' + e.trim() + '"]')) {
                        document.querySelector('#tblScheme input[type="checkbox"][id="' + e.trim() + '"]').click();
                    }
                });
            }
        }

        //Open Popup Div
        function OpenPopInfoScheme(SchemeCode) {
            document.getElementById("InfoHeadLabel").innerText = "Scheme Info";
            BindSchemeInfo(SchemeCode);
            document.getElementById("POPUPInfoModal").style.display = "flex";
            document.documentElement.style.overflow = 'hidden';
        }

        //Close Popup Div
        function ClosePop(DivId) {
            document.getElementById(DivId).style.display = 'none';
            document.documentElement.style.overflow = '';
        }

    </script>

    <style>
        .MedicineTbl td,
        .MedicineTbl th {
            text-align: center;
            vertical-align: middle !important;
        }

        .MedicineTbl {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: #333;
        }

            .MedicineTbl th, .MedicineTbl td {
                border: 1px solid #ccc;
                padding: 8px 10px;
                text-align: center;
            }

            .MedicineTbl thead {
                font-weight: bold;
                background-color: #6380bb !important;
                color: white;
            }

            .MedicineTbl tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

        #tblSchemeWrapper {
            max-height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
            border-radius: 5px;
            margin-top: 5px;
            /*position: absolute;*/
            width: 100%;
            /*z-index: 100000000000000;*/
        }

        #tblScheme {
            margin-bottom: 10px !important;
            background-color: #fbe3e3;
            font-size: 12px;
            box-shadow: 1px 0px 4px 0px #344;
        }

        #tblScheme tbody { /*//*/
            display: block;
            height: 250px;
            overflow: auto;
        }

            #tblScheme tbody tr { /*//*/
                display: table;
                width: 100%;
                table-layout: fixed;
            }

        @media only screen and (min-width : 992px) {
            #tblScheme {
                margin-left: 60px;
            }
        }   

        .SchemeModal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

            .SchemeModal .Scheme-modal-content {
                background-color: white;
                margin: 10% auto;
                width: auto;
                max-width: 95vw;
                border-radius: 5px;
                bottom: auto !important;
                max-height: 95vh;
                overflow: auto;
            }

        .ModelHeaderDiv {
            background-color: #003f74;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 5px;
            font-size: 13px;
        }

        .SchemeHeader {
            background: #043362 !important;
            border-radius: 0px;
        }

        .closeMdlBtn {
            cursor: pointer;
            font-weight: bold;
            font-size: 25px;
            width: 35px;
            height: 25px;
            position: relative;
            top: -5px;
            text-align: center;
        }

        .ModelContentDiv {
            padding: 5px 0px;
        }
    </style>
</asp:Content>

