<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" style="text-align: center">
        <div>
            <h3>Follow Up after</h3>
        </div>
    </div>
   
    <div class="row" style="padding-bottom: 5px; text-align: center;" id="followUpDiv">

        <%--<div class="badge bg-aqua" data-toggle="buttons"  style="padding-top: 6px;height: 33px;">--%>
            <label id="lblSOS" class="btn btn-info tempprint">
                SOS
            </label>
          <%--  </div>--%>  
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
      
        <span><i class="fa fa-calendar-check-o fa-2x" aria-hidden="true" style="margin-left:8px;cursor:pointer;" title="Book Appointment" id="btnTakeAppointMent"></i></span>
    </div>
 
    <hr style="height:2px;border-width:0;color: grey;background-color: #fbea23;width: 100%;">
     <div class="row hide" style="text-align: center;font-size:13px;margin-top:10px;" id="appnmtDiv">
        <input type="text" id="txtAppointmntDate"  style="height:30px;border-radius:5px;" readonly placeholder="Appointment Date" />
        <select id="txtAppointmntTime" style="height:30px;border-radius:5px;">
            <option>--Preferred Time-</option>
        </select>
    <Label style="font-size:16px;margin-left:10px;" id="anchorBookAppmnt">Book</Label>  
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

    <div class="row" style="text-align: center">
        <div>
            <h3>Surgery Advice</h3>
        </div>
    </div>
     <%-- added by vijeta on 13th march 19--%>
     <div class="row" style="text-align: center;">
        <input type="text" id="SurgeryInput" onkeyup="SearchSurgery()" placeholder="&#xF002; Search Surgery" style="font-family: FontAwesome !important; font-size: 16px; height: 31px; margin-left: 19px; width: 70%; background-color: #fdf1f8; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
      </div>
    <div class="row">
        <div>
            <table id="tblSurgery" class="table" >
            </table>
        </div>
        <input id="hdnSurgeryCode" type="hidden" />
    </div>
    <div class="row" style="text-align: center;">
        <textarea class="" id="txtSurgeryAdvice" rows="2" maxlength="200" style="font-size: 13px; width: 70%; margin-left: 19px;border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;"></textarea>
    </div>
   <%-- --%>

    <div id="ReferToDrHosp">
    <div class="row" style="text-align: center">
        <div>
            <h3>Refer To Doctor</h3>
        </div>
    </div>
    <div class="row" style="text-align: center;">
        <input type="text" id="DoctorInput" onkeyup="SearchDoctors()" placeholder="&#xF002; Search Doctor" style="font-family: FontAwesome !important;font-size:16px;height: 31px; margin-left: 19px; width: 70%;background-color: #fdf1f8; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
    </div>
    <div class="row" style="">
        <div>
            <table id="tblDoctors" class="table" >
            </table>
        </div>
        <input id="hdnDoctCode" type="hidden" />
    </div>
     <div class="row" style="text-align: center;">
        <textarea  id="DoctorShow" rows="2" maxlength="240" style="font-size: 13px; width: 70%; margin-left: 19px;border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" ></textarea>
    </div>
     </div>

    <div class="row" style="text-align: center">
        <div>
            <h3>Refer To Specilization</h3>
        </div>
    </div>
      <%--div added by vijeta on 20th march 2018--%>
    <!--added by kavita-->
    <div class="row" style="text-align: center;">
        <input type="text" id="ClinicInput" onkeyup="SearchClinic()" placeholder="&#xF002; Search Specilization" style="font-family: FontAwesome !important;font-size:16px;height: 31px; margin-left: 19px;background-color: #fdf1f8; width: 70%; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
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
     <%--added by vijeta on 13th march 19--%>
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
     <div class="row" style="text-align: center">
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
    <div id="divSMSGoogRating">
    <hr style="height:2px;border-width:0;color:gray;background-color:#44a5ea;width: 100%;">
    <div class="row" style="text-align: center">
        <div>
            <h3>SMS For Google Rating</h3>
        </div>
    </div>
    <div class="row" style="height:48px; border-color: #bce8f1; border: 1px solid transparent; text-align: center">
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
            <%--<label class="btn btn-default borderC">
                <input type="radio" name="language" value="GUJRATI" autocomplete="off">
                Gujrati
            </label>--%>
        </div>
    </div>
    <input id="hdnlanguage" name="hdnlanguage" type="hidden" value="NAME" />
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
           <%-- <div id="tdnew" class="HeadDiv" style="">
                <label id="lblMode">Search Item</label>
                <button type="button" class="btn btn-box-tool pull-right" data-widget="remove" style="height: 19px" onclick="CloseFancy();"><span class="ui-icon ui-icon-circle-close" style="margin-top: -2px"></span></button>

            </div>--%>
            <div id="divCntrlsE">
                 <div id="tbldiv">
                </div>
            </div>
        </fieldset>

       
        <div style="text-align: center">
            <table>
                <tr>
                   
                    <td>
                        <%--<input type="button" id="btnAddItem" class="btn btn-minier btn-yellow" value="ADD" style="line-height: 39px; width: 110px; margin-top: 3px; margin-left: 170px" onclick="AddItemToGrid()" />--%>
                          <%-- <span data-toggle="tooltip" title="" class="badge bg-aqua" data-original-title="3 New Messages" style="width: 107px; height: 33px; padding-top: 10px">
            <a class="trigger1" href="javascript:;" data-layer-id="layer-DMY" id="DaySelect1" style="font-weight:800;font-size:16px;color: white;display: inline-block;position: relative; z-index: 1;padding: 1em;margin: -2em;">Days</a>
        </span>--%>
                          <input type="button" style="margin-top: 10px; margin-bottom: 10px; width: 90px;border-radius: 7px;" name="btnSave" id="btnLogin" class="BtnFormat" value="Ok"  onclick="OKbutton()">
                        <input type="button" style="margin-top: 10px; margin-bottom: 10px; width: 90px;border-radius: 7px;" name="btnSave" id="btnLogin1" class="BtnFormat" value="Not Ok"  onclick="NotOKbutton()">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <% } %>

    <div class="row" style="text-align: center">
        <div>
            <a class="btn btn-app" id="MarkComplete">
                <i class="fa  fa-check-circle fa-4x" style="font-size: 50px"></i>
            </a>
        </div>
    </div>
     <div id="elementH"></div>
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
    width: 46% !important;
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
            #tblSurgery tbody {/*//*/
    display:block;
    height:250px;
    overflow:auto;
}
#tblSurgery tbody tr {/*//*/
    display:table;
    width:100%;
    table-layout:fixed;
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


 
    </style>

    <script>
        var SignArr = [];
        var infotomail = "";
        var formatclickd = '';//
        var Html = 0;
        var HeaderLang = [];
        var EnglishHeader = ["Chief Complaints", "Vital Examinations", "Final Diagnosis", "Advice", "Advice for Investigations/Procedures", "Treatment Advice",
            "Medicine Name", "Generic Name", "Follow Up After", "", "On Examinations", "Referred To", "Personal History", "Medical History", "Family History",
            "Referred to Specilization", "Remark/Note", "Complaint", "Plan Of Treatment", "Provisional Diagnosis"]
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
        var strSurgeries = ""; //added om 13th march 2019
        var strSurgeryCodes = ""; //added om 13th march 2019
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
        var ShowRefDoct = '<%:@System.Configuration.ConfigurationManager.AppSettings["showRefToDoctor"]%>'; //meenakshi 
        var ShowGoogleRating = '<%:@System.Configuration.ConfigurationManager.AppSettings["ShowGoogleRating"]%>'; //meenakshi 
        $(document).ready(function (e) {
            HoldOn.open();
            
            if (ShowRefDoct == "N")
                $("#ReferToDrHosp").hide();
            else
                $("#ReferToDrHosp").show();

            if (ShowGoogleRating== "Y")
                $("#divSMSGoogRating").show();
            else
                $("#divSMSGoogRating").hide();

            ToEmailID = $.session.get('PatEmail');
            if (ToEmailID != "" && ToEmailID != undefined) {
                $("#divmail").show();
                $("#P_Email").html(ToEmailID);
            }
            else {
                $("#P_Email").html("Email ID is not registered.");
                $("#Addpencil").remove();
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
                $("#tabMenu").css("display", "block");// added by vijeta on 27th sep 2018
                ActiveMenu("PresPrint");
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
                    SaveFollowUpPrint(this.value, "");
                    //Meenakhsi... 15/04/2020
                    /*---------------after Print reset the button-------------------------------------------*/
                    //$('.tempprint').removeClass('active');
                    this.checked = false;
                    /*---------------end Here-------------------------------------------------------------*/
                    HoldOn.close();//
                }
            });


            $('.Language input[type=radio]').on('change', function () {

                var hindiHeader = ["मुख्य शिकायतें", "सामान्य परीक्षाएं", "निदान", "सलाह", "जांच के लिए सलाह", "उपचार सलाह", "दवाई", "सामान्य नाम", "अगला चेक अप", "बाद", "जांच के बाद", "रेफ़रल चिकित्सक", "व्यक्तिगत इतिहास", "चिकित्सा का इतिहास", "परिवार के इतिहास", 'टिप्पणी', 'नि: शुल्क शिकायत']//history headers added by vijeta on 16th march 2018
                var marathiHeader = ["मुख्य तक्रारी", "सामान्य परीक्षा", "निदान", "सल्ला", "तपासणीसाठी सल्ला", "उपचार सल्ला", "औषधे", "सामान्य नाव", "पुढील तपासणी", "नंतर", "तपासणी नंतर", "संदर्भित डॉक्टर", "वैयक्तिक इतिहास", "वैद्यकीय इतिहास", "कौटुंबिक इतिहास", 'टिप्पणी', "विनामूल्य तक्रार"]//history headers added by vijeta on 16th march 2018
                var gujaratiHeader = ["મુખ્ય ફરિયાદો", "સામાન્ય પરીક્ષાઓ", "નિદાન", "સલાહ", "તપાસ માટે સલાહ", "સારવાર સલાહ", "દવાઓ", "સામાન્ય નામ", "આગામી ચેકઅપ", "પછી", "ચેકઅપ પછી", "સંદર્ભિત ડોક્ટર", "વ્યક્તિગત ઇતિહાસ", "તબીબી ઇતિહાસ", "પારિવારિક ઇતિહાસ", "ટિપ્પણી", "નિઃશુલ્ક ફરિયાદ"]//history headers added by vijeta on 16th march 2018
                var AfterFood = [" After Food", " भोजन के बाद", " अन्न नंतर", " ભોજન પછી"];
                var BeforFood = [" Before Food", " भोजन से पहले", " अन्न करण्यापूर्वी", " ફૂડ પહેલાં"]
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
                    default:
                        HeaderLang = EnglishHeader;
                        BeforFoodData = BeforFood[0];
                        AfterFoodData = AfterFood[0];
                        break;
                }
            });

            $("#MarkComplete").click(function () {
                <%--  if (CheckPatSessionNotEmpty()) {
                    var strTran = ($.session.get('PatTRANNO')).toString();
                    var patName = $.session.get('PatName').toString();
                    var patAge = $.session.get('PatAge2').toString();
                    var patGender = $.session.get('PatGender').toString();
                    var patMobile = ($.session.get('PatMobile') == undefined || $.session.get('PatMobile') == null) ? "" : $.session.get('PatMobile').toString();//by vijeta on 28th jan 2019
                    var mrNo = $.session.get('PatMRNO');
                    var tranno = $.session.get('PatTRANNO');
                    var numberofdays = $('#hdnNumber').val();
                    var daySelected = $('#hdnDayselect').val();
                    //var refDoctName = $("#DoctorInput").val();// commented by vijeta on 21st march 2018
                    var refDoctName = $("#DoctorShow").val();// added by vijeta on 21st march 2018
                    //var strRefClinicName = $("#ClinicInput").val();// commented by vijeta on 21st march 2018
                    var strRefClinicName = $("#ClinicShow").val();//added on 21st march 2018
                    var strSurgAdvice = "" + $('#txtSurgeryAdvice').val();
                    //added on 27th July 2018
                    var strApptmntDate = $("#txtAppointmntDate").val();
                    var strSlotNo = $("#txtAppointmntTime").val();
                    var strApptmntTime = $("#txtAppointmntTime option:selected").text();
                    var strAppmntYn = "N";
                    if (!$("#appnmtDiv").hasClass('hide') && strApptmntDate != "" && strApptmntTime != "--select slot--")
                        strAppmntYn = "Y";

                    if (!$("#appnmtDiv").hasClass('hide') && (strApptmntDate == "" || strApptmntTime == "--select slot--")) {
                        $.messager.alert("Information", "Select Appointment Date and Time");
                        return;
                    }
                    //------------------------------------------------------------

                    if (refDoctName != "") {
                        var doctCode = $("#hdnDoctCode").val();
                        // var row= $("#tblDoctors tr#" + doctCode).get();
                        if (doctCode == "") {
                            $.messager.alert("Information", "Select correct doctor");
                            return;
                        }
                    }
                    if (strRefClinicName.trim() != "") {
                        var ClinicCode = $("#hdnclinic").val();
                        if (ClinicCode == "") {
                            $.messager.alert("Information", "Select correct Specilization");
                            return;
                        }
                    }
                    console.log(numberofdays + ":  " + daySelected)
                    var datatosend = {
                        Number: numberofdays,
                        DaySelected: daySelected,
                        MrnNo: mrNo,
                        Transno: tranno,
                        refDoctName: refDoctName,
                        patName: patName,
                        patAge: patAge,
                        patGender: patGender,
                        patMobile: patMobile,
                        SurgyAdvice: strSurgAdvice,
                        RefCliniName: strRefClinicName,
                        AppmntDate: strApptmntDate,
                        AppmntTime: strApptmntTime,
                        strSlotNo: strSlotNo,
                    }
                    var PatCompletedYN = $.session.get('PatCompleted').toString();
                    HoldOn.open();
                    if (typeof PatCompletedYN == 'undefined' || PatCompletedYN == null) {
                        HoldOn.close();
                    }
                    if (PatCompletedYN != "Y") { 
                        $.ajax({
                            type: "POST",
                            url: 'SaveComplete',
                            datatype: "json",
                            data: datatosend,
                            success: function (result) {
                                if (result.includes("success")) {
                                    $.session.set('PatTRANNO', "");
                                    $.session.set('PatMRNO', "");
                                    $.session.set('PatName', "");
                                    $.session.set('PatAge', "");
                                    $.session.set('PatGender', "");
                                    $.session.set('PatCompleted', "");
                                    $.messager.alert("Information", "Saved Successfully");
                                    SetPatientDtl();
                                    var StrClinicCode = '<%:Session["ClinicCode"]%>'
                                    SearchFunction(StrClinicCode)
                                    window.location.href = '../DoctorDesk/PatientEntry'
                                }
                                else {
                                    $.messager.alert("Information", "Please fill all data");
                                }
                                //window.location.href = 'PatientEntry';
                            },
                            complete: function () { HoldOn.close(); }
                        });
                    }
                }
                else
                    $.messager.alert("Information", "Please Select Patient");--%>
                SaveFollowUpPrint('', 'M');

            });

            //$('#followUpDiv a').click(function (e) {
            //    var PatCompletedYN = $.session.get('PatCompleted').toString();
            //    if (PatCompletedYN == "Y" || appmntAlreadyBookedYn == "Y") {
            //        e.stopPropagation();
            //    }

            //});//4/2/19

            //GetDoctors();
            GetCliniclist();
            //GetSurgeryList();//by vijeta 13thMarch19

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
                } btnTakeAppointMent
            });

            //added on 26th July 2018
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
            $("#txtAppointmntDate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            minDate: new Date(),

                        });
            $("#txtAppointmntDate").change(function () {
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
            });
            //------------------------------------------

            //added on 2nd jan 2019
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

            //added on 16th jan19
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

                if (!$("#appnmtDiv").hasClass('hide') && (strApptmntDate == "" || strApptmntTime == "--Preferred Time--")) {
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
                //$("#btnTrandiv").fancybox({
                //    helpers: {
                //        overlay: { closeClick: false }
                //    },
                //    autoDimensions: false,
                //    width: 270,
                //    height: 90,
                //    'autoSize': false,
                //    beforeShow: function () {
                //        $(".fancybox-outer").css("height", "90px");
                //    }
                //});

            });


            //vishal SOS
            $('#lblSOS').click(function () {                                 
                if ($('#lblSOS').css("background-color") != "rgb(0, 128, 0)")
                {
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
                if ($('#lblSOS').css("background-color") == "rgb(0, 128, 0)")
                {
                    $("#Numbers").text("0");
                    $("#DaySelect").text("Days");
                    $('#hdnNumber').val("0");
                    $('#hdnDayselect').val("Days");
                    $("#txtAppointmntDate").val("");
                    $("#txtAppointmntTime").val("");
                    
                }
               
            });
            $('.NumDaysCls').click(function () {
                if ($('#hdnNumber').val() != "0" || $('#hdnDayselect').val() != "Days")
                {
                    if ($('#lblSOS').css("background-color") == "rgb(0, 128, 0)")
                    {
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

                PopupForMail();
            });
        });

        function PopupForMail() {
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
                            if ($("#txtemail").val() == "" || $("#txtemail").val() == null ) {// 18-12-19	
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
                                    Callajxmail(tomail);
                                }
                            }
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                        //close	
                    }
                 },
                    onContentReady: function () {
                        if (ToEmailID == "" || ToEmailID == null )
                        {
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
            $.loader.open();
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
                    $.loader.close();
                },


                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }, complete: function () {
                    rowNoFrMedTaper = ReSeqCnt;//vijeta 12/4/19
                },
            });
        }
        //added on 28th July 2018
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
            var sos, numberofdays, daySelected = "";
            var selectedTemp = TemplateType;
            var mrNo = $.session.get('PatMRNO');
            var tranno = $.session.get('PatTRANNO');
            //var numberofdays = $('#hdnNumber').val();
            //var daySelected = $('#hdnDayselect').val();
            if ($('#lblSOS').css("background-color") == "rgb(0, 128, 0)")    //vishal SOS
            {
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

            console.log(numberofdays + ":  " + daySelected)

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

            if (!$("#appnmtDiv").hasClass('hide') && (strApptmntDate == "" || strApptmntTime == "--Preferred Time--")) {
                $.messager.alert("Information", "Select Appointment Date and Time");
                return;
            }
            //--------------------------------------
            HoldOn.open();
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
                CallDoneYN: CallDoneYN
            }

            $.ajax({
                type: "Post",
                url: "../DoctorDesk/SaveFollowUpData",
                data: datatosend,
                async: false,
                success: function (Result) {
                    if (Result == "Successful") {

                        if (RedirectOpt == "N") {
                            window.location.href = 'PatientEntry';
                        }
                        else if (RedirectOpt == "Y") {
                            //do nothing
                        }
                        else if (RedirectOpt == "M")
                        {
                            $.messager.alert("Information", "Completed Successfully.");
                            //window.location.href = '../DoctorDesk/PatientEntry'
                        }
                        else if (RedirectOpt == "" || RedirectOpt == "EM") {
                            GetBindingData(tranno, selectedTemp, RedirectOpt);
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
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkVital"/>  Vital Examination</label>' +
       ' <br />'+
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkPlanOfTreatmnt"/>  Plan of treatment</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkRemark"/>  Remarks</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkInvest" />  Investigations/Procedures</label>' +
         '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkRx"/>  Rx</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkAdvice"/>  Advice</label>' +
      '  <br />'+
       ' <label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkPersHist"/>  Personal History</label>' +
       ' <label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkMedHist"/>  Medical History</label>' +
         '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;" id="chkFamHist"/>  Family History</label>' +
        '<label style="margin-left:10px;"><input type="checkbox" style="vertical-align: sub;  id="chkAllergy"/>  Allergy</label>' +
         
   ' </div>'+
                    '<label> Do you Want to Continue?</label>' +
                    '<div id="divSrvcGrpSelect" style="border:1px solid gray;"></div>' +
                    '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Print',
                        btnClass: 'btn-blue',
                        action: function () {
                            if ($('#SelctCheck  input[type=checkbox]:checked').length > 0)
                                SaveFollowUpPrint(obj, "");
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
                     if (data.length > 0)
                     {
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
            debugger;
            var mrNo = $.session.get('PatMRNO');
            var datatosend = {
                tranno: vartranno,//"06C170704NR0001"
                // type: $('#hdnlanguage').val(),
                type: 'L',  //Meenash to diaply prnint  only in english
                MrNo: mrNo,
            }

            var Html = "";
            $.ajax({
                type: "Post",
                url: "../DoctorDesk/GetDoctorDeskData",
                data: datatosend,
                async: false,
                success: function (response) {
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
                        Html = PrintData3();
                    }
                    infotomail = Html;
                    // PrintListAJAXCommon('<%:Url.Action("PrintPatientReport","DoctorDesk")%>', { strHtml: Html }, "ABDSKFLSDF", "");
                    if (RedirectOpt != "EM")
                        openWin(Html);
                    GridData = "";
                
                },
                complete: function () {
                    //SendMailAction(Html);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //ajaxindicatorstop();
                    MsgDia(textStatus, "Error");
                }
            });
        }
        function SendMailAction() {
            if (infotomail == "") {
                $.messager.alert("Information", "Please Select Template");
                return false;
            }
            var tomail = ($.session.get('PatEmail'));
            if (tomail == "" || tomail == null ) {
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
            var datatosend = {
                                   printdata: encodeURIComponent(infotomail),
                                   TranNo: ($.session.get('PatTRANNO')),
                                   ToMailId: tomail,
                                   Mrno: Mrno
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
        function validateEmail(Toemail) {
            var field;
            var RslValStr;
            var regex = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (Toemail.indexOf(",") > 0) {
                field = Toemail.split(",");
                for (num = 0; num < field.length; num++) {
                    var email = field[num].replace( /[\r\n]+/gm, "" ); ;
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
        function openWin(HTML) {

            // GetSavedData();
            Html = HTML;
            //$("a#btnTrandiv").click();

            OKbutton();
               
            
        }
        function BindingFancyRx(result) {//3-10-19
            debugger;
            var strPrindData = "";

            //Medicine advice start 
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
                //strPrindData +=("<div style='margin-bottom:5px'><label style='font-size:40px;'> &#x211E;</label></div>")
                strPrindData += "<table style='width:100%;border-collapse:collapse;page-break-inside:avoid' border='1'>";
                strPrindData += "<caption style='font-size:40px;text-align:left' > &#x211E;</caption>";
                var Medicine = "";
                for (var i = 0; i < result.length; i++) {

                    var dosage = '';
                    var advicesplitVal = [];
                    var advicedayNum = '';
                    var IntakeRemark = '';
                    var Route = '';
                    Food = "";
                    var strConS = '';
                    var concateComma = '';

                    var genericNm = result[i]["GENERICNAME"].toString() != "" ? "(" + result[i]["GENERICNAME"].toString() + ")" : "";//added by vij on 26th oct 2018
                    if (flag == 1)
                        dosage = (result[i]["DOSSAGE"] == "" || result[i]["DOSSAGE"] == "undefined") ? "" : result[i]["DOSSAGE"]//
                    else
                        dosage = (result[i]["DOSSAGE"] == "" || result[i]["DOSSAGE"] == "undefined") ? "" : "-" + result[i]["DOSSAGE"]//

                    if (flagRoute == 1)
                        Route = GetRoutText((result[i]["ROUTE"] == "" || result[i]["ROUTE"] == "undefined") ? "" : result[i]["ROUTE"]);
                    else
                        Route = GetRoutText((result[i]["ROUTE"] == "" || result[i]["ROUTE"] == "undefined") ? "" : "-" + result[i]["ROUTE"]);


                    intake = (result[i]["INTAKE"] == "" || result[i]["INTAKE"] == "undefined") ? "" : result[i]["INTAKE"].replace(/0.5/g, "1/2")
                    remark = GetRemarkText((result[i]["Remarks"] == "" || result[i]["Remarks"] == "undefined") ? "" : result[i]["Remarks"]);

                    //added on 29th aug 2018
                    intake = IntakeFunction(intake);
                    //--------------------------------

                    if (result[i]["ABFOOD"] == "A") {
                        Food = AfterFoodData;
                    }
                    else if (result[i]["ABFOOD"] == "E") {
                        Food = BeforFoodData;
                    }

                    if (Food != "" && remark != "") {
                        concateComma = ", "
                    }
                    if (result[i]["DAYS"].length > 0) {
                        if (result[i]["DAYS"] == "C" || result[i]["DAYS"] == "S") {
                            if (result[i]["DAYS"] == "C") {
                                IntakeIndicator = result[i]["DAYS"];
                                IntakeRemark = checkInTakeStatement(IntakeIndicator, language)
                                if (flag == 1 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 0 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 1 && flagRoute == 0)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"

                                //if (flag == 0)
                                //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:35%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                //else
                                //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:23%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                // dossage added 

                            }
                            else if (result[i]["DAYS"] == "S") {
                                IntakeIndicator = result[i]["DAYS"];
                                IntakeRemark = checkInTakeStatement(IntakeIndicator, language)

                                if (flag == 1 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 0 && flagRoute == 1)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else if (flag == 1 && flagRoute == 0)
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                else
                                    Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"

                                //if (flag == 0)
                                //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:35%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                //else
                                //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;font-weight:bold;'><label style='font-size:13px !important;text-align:center;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important;text-align:center;'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:23%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                                // dossage added 
                            }

                        }
                        else if (result[i]["INTAKE"] == "SOS" || result[i]["INTAKE"] == "CONTD" || result[i]["INTAKE"] == "STAT") {

                            if (flag == 1 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 0 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 1 && flagRoute == 0)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"


                            //if (flag == 0)
                            //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:35%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            //else
                            //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + '-' + "</td><td class='HTextsize' style='width:23%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            // dossage added 

                        }
                        else {
                            day = (result[i]["DAYS"] == "" || result[i]["DAYS"] == "undefined") ? "" : "for " + result[i]["DAYS"]
                            if (day != "" || day != "undefined") {
                                advicedayNum = (day).replace(/[^0-9]+/ig, "");// taking Numeric value from alphanumeric
                                advicedayNum = advicedayNum == 0 ? "-" : advicedayNum;// taking Numeric value from alphanumeric //4/11/19 
                                advicesplitVal = (day).split((day).replace(/[^0-9]+/ig, ""));// spliting alphanumeric based on dayresult[i]["GENERICNAME"]//4/11/19 
                                //advicesplitVal = (day).split(advicedayNum);// spliting alphanumeric based on dayresult[i]["GENERICNAME"]//4/11/19
                                checkFollowUplanguge(advicesplitVal, language, 'I')
                                if (advicedayNum == '-')//4/11/19
                                    IntakeLanguage = "";
                                if (language == "NAME" && advicedayNum.length > 0) {
                                    if (Number(advicedayNum) > 1)
                                        strConS = 's'
                                }
                            }

                            if (flag == 1 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 0 && flagRoute == 1)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else if (flag == 1 && flagRoute == 0)
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            else
                                Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"

                            //if (flag == 0)
                            //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:35%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            //else
                            //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:23%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                            // dossage added 
                        }
                    }

                    else {
                        advicedayNum = "";
                        IntakeLanguage = "";
                        strConS = "";

                        if (flag == 1 && flagRoute == 1)
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:10%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:12%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:22%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        else if (flag == 0 && flagRoute == 1)
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:24%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        else if (flag == 1 && flagRoute == 0)
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:10px !important'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:32%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        else
                            Medicine += "<tr class='inHeight'><td style='padding:3px;width:34%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:10px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center;'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center;line-height:17px;'>" + IntakeRemark + "</td><td class='HTextsize' style='width:44%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"

                        //if (flag == 0)
                        //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + dosage + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + "  " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:35%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                        //else
                        //    Medicine += "<tr class='inHeight'><td style='padding:3px;width:40%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + result[i]["DRUGNM"] + "</label>" + "<label style='font-size:13px !important;text-align:center'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + intake + "</label></td><td class='HTextsize' style='width:12%;text-align:center'><label>" + dosage + "</label></td><td class='HTextsize' style='width:15%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:23%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"

                    }

                }

                if (flag == 1 && flagRoute == 1) {
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Medicine Name</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
                }
                else if (flag == 0 && flagRoute == 1) {
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:34%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Medicine Name</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";

                } else if (flag == 1 && flagRoute == 0) {
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Medicine Name</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:44%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
                }
                else
                    strPrindData += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:34%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Medicine Name</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:44%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
                //if (flag == 0)

                //    strPrindData +=("<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:40%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Medicine Name</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:15%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:35%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "")
                //else
                //    strPrindData +=("<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:30%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Medicine Name</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:15%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:35%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "")

                strPrindData += "</table>";
                $("#tbldiv").append(strPrindData);

            }


            //medicine advice end
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
        function PrintData2() {
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
            var Mrno = ($.session.get('PatMRNO'));
            var strTran = ($.session.get('PatTRANNO'));
            var patName = ($.session.get('PatName')); // added by vijeta on 15th march 2018
            var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' }; // added by vijeta on 15th march 2018
            var gRelation = {
                '01': 'Father', '02': 'Mother', '03': 'Wife',
                '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
                '07': 'Grand Mother'
            };// added by vijeta on 15th march 2018

            var strPrindData = [];
            strPrindData.push("<html><head>");
            strPrindData.push(" <style>.cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;text-align: left;} .HTextsize{font-size: 14px !important ;padding:3px;} .DTextsize{font-size: 14px !important;} .inHeight{line-height:15px !important}  @page {margin-top: 4cm;margin-bottom: 3cm; } @media print {body {margin-top: 0mm; margin-bottom: 0mm;  margin-left: 0mm; margin-right: 0mm } #footer{display: block;page-break-after: always; bottom:0;margin-top: 25pt; } } #tblPatInfo td{padding: 1px; white-space:nowrap} </style></head>");//position: fixed; changed by vijeta on 14th march 2018
            strPrindData.push("<body style='margin-left:25;font-family:cambria header !important;font-size: 13px'>");
            var label = "Patient Category";
            // var Patcatg = $('#spPatcatgnm')[0].textContent;
            var Patcatg = "";
            var doctName = "";
            ////User Details/////

            strPrindData.push("<table style='width:100%;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px;border-collapse:collapse;font-family:cambria header !important;font-size: 13.5px !important;' id='tblPatInfo'>");
            //3/27/19 font size nd family
            strPrindData.push("<tr><td>Name</td><td>:</td><td>" + GridData.jsonUserdtls[0].PATNAME +
                "<td>Age/Gender</td><td>:</td>");
            strPrindData.push("<td>" + (GridData.jsonUserdtls[0].PATAGE).toString().substring(0, 3) + ' ' + 'Years' + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr><tr><td>MR No.</td><td>:</td><td>" + Mrno + "</td>");
            //3/27/19 Dr->mrno
            strPrindData.push("<td>Date/Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>");//3/27/19 gap reduced
            strPrindData.push("</tr><tr><td>Dr. Name</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
            //3/27/19 mrno->Dr
            strPrindData.push("</td><td>Consultn. No.</td><td>:</td>");//3/27/19 changd the name
            strPrindData.push("<td>" + strTran + "</tr>");//<td class='HTextsize'>Doctor Name</td>
            //Meenakshi To add exemption and emp ID
            if (GridData.jsonUserdtls[0].COCANAME != "") {
                strPrindData.push("<tr><td>Exemp Catg.</td><td >:</td><td>" + GridData.jsonUserdtls[0].COCANAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
                if (GridData.jsonUserdtls[0].EMPID != "") {
                    strPrindData.push("<td>Employee ID</td><td>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "<td></tr>");
                }
                else {
                    strPrindData.push("<td>Exemp Proof</td><td>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "<td></tr>");
                }
            }
            strPrindData.push("</table>");
            
            //History related changes added by vijeta //4/9/19 chngd position of histry
            //4/9/19 shift histry
            if (printWithHistory == "Y") {// condition added by vijeta on 7th may 2018
                //if (GridData.jsonDoctorDetails[0].PRNTHISTYN == "Y") {
                //strPrindData.push("<div id='historyDiv'>");

                strPrindData.push("<div id='personalNMediDiv'>");

                if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {


                    //if (GridData.jsonMedicineHist.length == 0 && GridData.jsonFreeMedical.length == 0)
                    //    strPrindData.push("<div style='width:100%' id='divPersonalHist'>");
                    //else
                    strPrindData.push("<br><div style='width:100%' id='divPersonalHist'>");

                    //strPrindData.push("<label class='HTextsize' style='font-weight:bold;'><u>" + HeaderLang[12] + " </u> : </label>");
                    //strPrindData.push("<ul>");
                }
                if (GridData.jsonPersonalHist.length > 0) {
                    strPrindData.push("<table id='personalHistTable' style='border-collapse:collapse;font-size:13px !important'  >");// border color added by vijeta on 19th march 2018
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                    for (var i = 0; i < GridData.jsonPersonalHist.length; i++) {
                        strPrindData.push("<tr><td><li>" + "Addicted to <b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                        if (GridData.jsonPersonalHist[i].STOPAGE != 0) {//
                            if (GridData.jsonPersonalHist[i].STARTAGE != "")
                                strPrindData.push(" from the age of " + GridData.jsonPersonalHist[i].STARTAGE)

                            if (GridData.jsonPersonalHist[i].STOPAGE != "")
                                strPrindData.push(" to " + GridData.jsonPersonalHist[i].STOPAGE);
                        }
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
                //free personal history
                if (GridData.jsonFreePersonal != "") {
                    strPrindData.push("<table style='border-collapse:collapse;font-size:13px !important' class='tblFree'>");
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


                //medical history start

                if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {


                    // if (GridData.jsonPersonalHist.length == 0 && GridData.jsonFreePersonal.length == 0)
                    strPrindData.push("<br><div style='width:100%' id='divMedicalHist'>");
                    //else
                    // strPrindData.push("<br><div style='float:right;width:40%;padding-bottom:10%' id='divMedicalHist'>");
                }
                if (GridData.jsonMedicineHist.length > 0) {
                    strPrindData.push("<table id='medicalHistTable' style='border-collapse:collapse;font-size:13px !important' >");                       
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[13] + " :</u></caption>")
                    for (var i = 0; i < GridData.jsonMedicineHist.length; i++) {
                        strPrindData.push("<tr><td><li>" + "Suffering with <b>" + GridData.jsonMedicineHist[i].NAME + "</b>");
                        if (GridData.jsonMedicineHist[i].DURATION != "" && GridData.jsonMedicineHist[i].DURATION != 0)
                            strPrindData.push(" since " + GridData.jsonMedicineHist[i].DURATION.toString() + " " + gDurType[GridData.jsonMedicineHist[i].DURTYPE] + "(s)");
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table><br>");
                }
                //free medical history
                if (GridData.jsonFreeMedical != "") {
                    strPrindData.push("<table style='border-collapse:collapse;font-size:13px !important' class='tblFree'>");
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

                // strPrindData.push("<br>");
                //family history start
                if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0) {

                    if (GridData.jsonFamilyHist.length > 0 || GridData.jsonFreeFamily.length > 0)
                        strPrindData.push("<div id='familyHistDiv'>");
                    //strPrindData.push("<label class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></label>")
                }
                if (GridData.jsonFamilyHist.length > 0) {

                    strPrindData.push("<table id='familyHistTable' style='width:100%;border-collapse:collapse;' >");// 4/8/19border color added by vijeta on 19th march 2018s
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></caption>")
                    for (var i = 0; i < GridData.jsonFamilyHist.length; i++) {
                        if (GridData.jsonFamilyHist[i].DURATION != 0) {
                            strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                                       GridData.jsonFamilyHist[i].DISEASES + "</b> since " + GridData.jsonFamilyHist[i].DURATION + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)");
                        }
                        else {
                            if (GridData.jsonFamilyHist[i].AGE > 0) {
                                strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                                                GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                            }
                            else
                            {
                                strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] +   " suffering with <b>" +
                                                   GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                            }
                        }
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");

                    // strPrindData.push("<br>");
                }
                //free family history
                if (GridData.jsonFreeFamily != "") {
                    strPrindData.push("<table style='border-collapse:collapse;font-size:13px !important' class='tblFree'>");
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

            if (GridData.jsonAllergy.length > 0) {
                strPrindData.push("<table id='AllergyTable' >");
                strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>Allergy</u>:</caption>");
                for (var i = 0; i < GridData.jsonAllergy.length; i++) {
                    strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");
                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table>");
            }
            //end of allergy

            //Vitals start       
            if (GridData.jsonVital.length > 0) {

                //strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align=top'><u>" + HeaderLang[1] + " </u>: </label>")

                var flag = false;
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
                    
                });

                if (flag) {
                    strPrindData.push("<br><div class='col-md-6'>");
                    strPrindData.push("<table style='border-collapse: separate; border-spacing: 3px;width:100%;style='font-family:cambria header !important;font-size: 13px !important;'>")
                    strPrindData.push("<tr  class='inHeight'>")
                    strPrindData.push("<label class='HTextsize' style='font-weight:bold;vertical-align=top'><u>" + HeaderLang[1] + " </u>: </label>");
                }

                if (GridData.jsonVital[0].hasOwnProperty("WEIGHT")) {
                    if (Number(GridData.jsonVital[0]["WEIGHT"]) > 0)//GridData.jsonVital[0]["WEIGHT"].length
                        strPrindData.push("<td class='DTextsize'>Weight: " + GridData.jsonVital[0]["WEIGHT"] + " kgs</td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("HEIGHT")) {
                    if (Number(GridData.jsonVital[0]["HEIGHT"]) > 0)//GridData.jsonVital[0]["HEIGHT"].length
                        strPrindData.push("<td class='DTextsize'>Height : " + GridData.jsonVital[0]["HEIGHT"] + " cms</td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("PAINSCORE")) {
                    if (GridData.jsonVital[0]["PAINSCORE"].length > 0)//
                        strPrindData.push("<td class='DTextsize'>Pain Score : " + GridData.jsonVital[0]["PAINSCORE"] + "  </td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("TEMP")) {
                    if (Number(GridData.jsonVital[0]["TEMP"]) > 0)//GridData.jsonVital[0]["TEMP"].length 
                        strPrindData.push("<td class='DTextsize'>Temprature : " + GridData.jsonVital[0]["TEMP"] + " °F</td>")
                }


                if (GridData.jsonVital[0].hasOwnProperty("RBS")) {
                    if (GridData.jsonVital[0]["RBS"].length > 0)//
                        strPrindData.push("<td class='DTextsize'>RBS : " + GridData.jsonVital[0]["RBS"] + " mg/dl</td>")
                }

                strPrindData.push("</tr>")
                strPrindData.push("<tr class='inHeight'>")
                if (GridData.jsonVital[0].hasOwnProperty("PULSE")) {
                    if (Number(GridData.jsonVital[0]["PULSE"]) > 0)//GridData.jsonVital[0]["PULSE"].length 
                        strPrindData.push("<td class='DTextsize'>Pulse : " + GridData.jsonVital[0]["PULSE"] + " bpm</td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("RESP")) {
                    if (Number(GridData.jsonVital[0]["RESP"]) > 0)//GridData.jsonVital[0]["RESP"].length
                        strPrindData.push("<td class='DTextsize'>RR : " + GridData.jsonVital[0]["RESP"] + "</td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("BP")) {
                    if (GridData.jsonVital[0]["BP"].length > 0)//
                        strPrindData.push("<td class='DTextsize'>BP : " + GridData.jsonVital[0]["BP"] + " mmHg</td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("BSA")) {
                    if (GridData.jsonVital[0]["BSA"].length > 0)//
                        strPrindData.push("<td class='DTextsize'>BSA : " + GridData.jsonVital[0]["BSA"] + " m<sup>2</sup></td>")
                }

                strPrindData.push("</tr>")
                strPrindData.push("<tr>")
                if (GridData.jsonVital[0].hasOwnProperty("SPO2")) {//added on 5thMarch2019
                    if (GridData.jsonVital[0]["SPO2"].length > 0)
                        strPrindData.push("<td class='DTextsize'>SPO2 : " + GridData.jsonVital[0]["SPO2"] + " %</td>")
                }

                //vijeta 17th may 2019
                if (GridData.jsonVital[0].hasOwnProperty("BMI")) {
                    if (GridData.jsonVital[0]["BMI"].length > 0)
                        strPrindData.push("<td class='DTextsize'>BMI : " + GridData.jsonVital[0]["BMI"] + " kg/(m^2)</td>")
                }
                if (GridData.jsonVital[0].hasOwnProperty("HEAD_CIRCUMFERENCE")) {
                    if (GridData.jsonVital[0]["HEAD_CIRCUMFERENCE"].length > 0)
                        strPrindData.push("<td class='DTextsize'>Head Circumference : " + GridData.jsonVital[0]["HEAD_CIRCUMFERENCE"] + " cms</td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("KARNOFSKY")) {
                    if (GridData.jsonVital[0]["KARNOFSKY"].length > 0)//
                        strPrindData.push("<td class='DTextsize'>Karnofsky Score : " + GridData.jsonVital[0]["KARNOFSKY"] + "  </td>")
                }
                strPrindData.push("</tr>");
             
                //vijeta 17th may 2019

                //vijeta 4th june 2019
                strPrindData.push("<tr>");
                if (GridData.jsonVital[0].hasOwnProperty("PEFR")) {
                    if (GridData.jsonVital[0]["PEFR"].length > 0)
                        strPrindData.push("<td class='DTextsize'>PEFR : " + GridData.jsonVital[0]["PEFR"] + " li/min</td>")
                }
                if (GridData.jsonVital[0].hasOwnProperty("Technique")) {
                    if (GridData.jsonVital[0]["Technique"] != 'N')
                        strPrindData.push("<td class='DTextsize'>Technique : " + GridData.jsonVital[0]["Technique"] + "</td>")
                }
                if (GridData.jsonVital[0].hasOwnProperty("Compliance")) {  //vijeta 4th june 2019
                    if (GridData.jsonVital[0]["Compliance"] != 'N')
                        strPrindData.push("<td class='DTextsize'>Compliance : " + GridData.jsonVital[0]["Compliance"] + " </td>")
                }

                if (GridData.jsonVital[0].hasOwnProperty("ECOG")) {
                    if (GridData.jsonVital[0]["ECOG"].length > 0)//
                        strPrindData.push("<td class='DTextsize'>Ecog Score : " + GridData.jsonVital[0]["ECOG"] + "  </td>")
                }
                strPrindData.push("</tr>");
                //vijeta 4th june 2019

                strPrindData.push("<tr>");
                if (GridData.jsonVital[0].hasOwnProperty("VOTHERS")) {
                    if (GridData.jsonVital[0]["VOTHERS"].length > 0)
                        strPrindData.push("<td >VOTHERS : " + GridData.jsonVital[0]["VOTHERS"] + "</td>")
                }

                strPrindData.push("</tr></table>");
                strPrindData.push("</div>")
            }
            strPrindData.push("</div>");

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
                        rmrk = " (" + GridData.jsonComplaints[i].REMARKS + ")";
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
                    //
                }
            }

            if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
                strPrindData.push("</table>");
                strPrindData.push("</div>")
            }
            //strPrindData.push("<br>")//
            //}


            //Exam start
            if (GridData.jsonExam[0]["EXAM"] !== "") {
                strPrindData.push("<br><table>")
                strPrindData.push("<tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[10] + "</u>: </label><br><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonExam[0]["EXAM"].replace(/\n/g, '<br />') + "</label>" + "</td>"); //.replace(/\n/g, '<br />') added by vijeta on 14th march 2018
                strPrindData.push("</tr>");
                strPrindData.push("</table>")
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


            if (GridData.jsonFollowUp[0]["COMPOSTAG"].toString().trim() != "")
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Composit Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

            if (GridData.jsonFollowUp[0]["TSTAGE"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>TNM Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
                strPrindData.push("<td style='align:left'>T:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["TSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>N:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["NSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>M:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["MSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("</tr></table></br>");
            }

            if (GridData.jsonDiagnosis.length > 0) {
                // strPrindData.push("<br><label class='HTextsize' style='font-weight:bold;vertical-align=top'><u>Diagnosis</u>: </label>")
                if (GridData.jsonICDiagnosis.length <= 0) {
                    strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
                } else {
                    strPrindData.push("<table style='width:50%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
                }

               // strPrindData.push("<table style='width:100%'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Diagnosis</u>: </label></td></tr>");
                for (var i = 0; i < GridData.jsonDiagnosis.length; i++) {
                    var DiagRemark = "";
                    if (GridData.jsonDiagnosis[i].REMARKS != "") {
                        DiagRemark = " " + " - " + GridData.jsonDiagnosis[i].REMARKS.toString()
                    }
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
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
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;line-height:17px;'><li>" + GridData.jsonInvstg[i].TESTNAME.toString().replace(/\n/g, '<br />') + " - " + GridData.jsonInvstg[i].REMARK.toString() + " " + TotalDuration + "</li></td></tr>");
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
            if (GridData.jsonPatientAdvice.length > 0) {
                strPrindData.push("<br><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[3] + " </u>: </label>")
                strPrindData.push("<table>")
                for (var i = 0; i < GridData.jsonPatientAdvice.length; i++) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonPatientAdvice[i].NAME.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                }
                strPrindData.push("</table>")
            }
            //Patient Advice end

            //folowup start         
            var dt = "", refDoct = "";
            if (GridData.jsonFollowUp.length > 0) {
                var dayNum = "", constString = "";
                refDoct = GridData.jsonFollowUp[0]["REFDOCT"];
                refSpecilist = GridData.jsonFollowUp[0]["REFSPECIALIST"];
                for (var e = 0; e < GridData.jsonFollowUp.length; e++) {
                    if (GridData.jsonFollowUp[0]["SURGNMADVICE"] != "") {
                        //strPrindData.push("<br>");
                        //strPrindData.push("<table style='width:100%;'>");
                        //strPrindData.push("<tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><u><label class='HTextsize' style='font-weight:bold'>Surgery Advice</label><u></td>");
                        //strPrindData.push("<td style='vertical-align:top;'><b>:</b>&nbsp;&nbsp</td><td><label class='DTextsize'>" + GridData.jsonFollowUp[0]["SURGNMADVICE"].toString().replace(/\n/g, '<br />') + "</label></td></tr>")
                        //strPrindData.push("</table>");
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Advice</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SURGNMADVICE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

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
                        //strPrindData.push("<tr class='inHeight'><td><u><label class='HTextsize' style=';font-weight:bold'>Referred to Specilization : </label><u></td><td><label class='DTextsize'>" + refSpecilist + "</label></td></tr>");
                        //strPrindData.push("</table><br>")
                    }

                  
                    if (GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().trim() != "")
                        strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[18] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    //added on 13th march 19 for prescription remark
                    var remark = GridData.jsonFollowUp[0]["REMARK"];
                    if (remark != "")
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[16] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'> <label class='HTextsize' style='left-margin:10px;font-size:13px !important;'>" + remark.toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    if (GridData.jsonFollowUp[e].FOLLOWUPDT.length > 0) {
                        dayNum = (GridData.jsonFollowUp[e].FOLLOWUPDT).replace(/[^0-9]+/ig, "");
                        FollowUp = (GridData.jsonFollowUp[e].FOLLOWUPDT).split(dayNum);
                        checkFollowUplanguge(FollowUp, language, 'F')
                        //strPrindData.push("<br>");
                        strPrindData.push("</br><table style='width:100%'>")
                        var adviceInv = ""

                        if (dayNum.length > 0) {
                            if (Number(dayNum) > 1) {
                                constString = "s"
                            }
                        }

                        if (GridData.jsonInvstg.length > 0)
                            adviceInv = "with Advised Investigation Reports if any.";

                        //vijeta 16th march 19
                        if (GridData.jsonFollowUp[e].APPMNTDT != "" && GridData.jsonFollowUp[e].APPMNTTM != "") {//vijeta 16th march 19
                            strPrindData.push("<table style='width:100%'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Follow up on " + GridData.jsonFollowUp[e].APPMNTDT + " at " + GridData.jsonFollowUp[e].APPMNTTM + " " + adviceInv + "</td></table><br>");
                        }
                        else if (GridData.jsonFollowUp[e].FOLLOWUPDT == "SOS")
                        {
                            strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + "Follow Up : " + "&nbsp;" + "SOS" + " if any complaints "  + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                        }
                        else
                        strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + HeaderLang[8] + "&nbsp;" + dayNum + " " + languageWise + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>

                    }
                    
                }
            }
            //followup end

            //doctor details start

            var StrDoctCode = '<%:Session["gDoctCode"]%>';
            
                //strPrindData.push("<div style='bottom:60;position:absolute;float:right!important'><label style='font-style:Arial;font-size:12px; font-weight:bold;margin-left:440px;margin-bottom:70px'>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</label>");

            strPrindData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
            strPrindData.push("<table style='float:right!important;font-family:cambria header !important;font-size: 12px !important;'  id='tblDoctInfo'>");
            if (digitsign1 != "")
                        strPrindData.push("<tr><td><b><img src=" + digitsign1 + "  /></b></td>");
            if (digitsign2 != "")
                        strPrindData.push("<td><b><img src=" + digitsign2 + "  /></b></td>");
            if (digitsign3 != "")
                        strPrindData.push("<td><b><img src=" + digitsign3 + "  /></b></td></tr>");
                strPrindData.push("<tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</b></td></tr>");
                if (GridData.jsonDoctorDetails[0].SIGN == "") { //vijeta 22/4/19
                    
                        strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");
                        strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].QUALI + "</td></tr>");
                        strPrindData.push("<tr><td>" + "Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "</td></tr>");
                    
                    strPrindData.push("</table>");
                }
                else {
                    //strPrindData.push("<tr><td style='font-size: 12px !important;'>" + GridData.jsonDoctorDetails[0].SIGN.toString().replace(/\n/g, '<br />') + "</td></tr>");
                if (sign1 != "")
                    strPrindData.push("<tr><td><p>" + sign1.replace(/\n/g, "<br />") + "</P></td></tr>");
                else if (sign2 != "")
                    strPrindData.push("<tr><td><p>" + sign2.replace(/\n/g, "<br />") + "<p/></td></tr>");
                else if (sign3 != "")
                    strPrindData.push("<tr><td><p>" + sign3.replace(/\n/g, "<br />") + "</p></td></tr>");
                    strPrindData.push("</table>");
                }

               
                strPrindData.push("</div>");

              
            //doctor details end

            strPrindData.push("</div>");
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
                '07': 'Grand Mother'
            };// added by vijeta on 15th march 2018

            var strPrindData = [];
            strPrindData.push("<html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'/>");// 23-04-2020
            strPrindData.push(" <style> .cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;text-align: left;font-family:cambria header !important;font-size: 13px !important;} .HTextsize{font-size: 14px !important ;padding:3px;} .DTextsize{font-size: 14px !important;} .inHeight{line-height:14px !important}  @page {margin-top: 4cm;margin-bottom: 3cm;} @media print {body {margin-top: 0mm; margin-bottom: 0mm;  margin-left: 0mm; margin-right: 0mm } #footer{ bottom:0;margin-top: 25pt;page-break-after: always; } }  #tblPatInfo td{padding: 1px; white-space:nowrap;} #header {display: block;position: running(header);}</style></head>");//position: fixed; changed by vijeta on 14th march 2018
            strPrindData.push("<body style='margin-left:25;font-family:cambria header !important;font-size: 13px !important;'>");
            var label = "Patient Category";
            // var Patcatg = $('#spPatcatgnm')[0].textContent;
            var Patcatg = "";
            var doctName = "";

            //container div
            strPrindData.push("<div id='header' class='container'>");

            ////User Details/////
            strPrindData.push("<table style='width:100%;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px;border-collapse:collapse;font-family:cambria header !important;font-size: 13.5px !important;' id='tblPatInfo'>");
            //3/27/19 font size nd family
            strPrindData.push("<tr><td>Name</td><td>:</td><td>" + GridData.jsonUserdtls[0].PATNAME + "</td>" +
                "<td>Age/Gender</td><td>:</td>");
            strPrindData.push("<td>" + (GridData.jsonUserdtls[0].PATAGE).toString().substring(0,3) + ' ' + 'Years' + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr><tr><td>MR No.</td><td>:</td><td>" + Mrno + "</td>");
            //3/27/19  Dr -> mrno
            strPrindData.push("<td>Date/Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>"); 
            strPrindData.push("</tr><tr><td>Dr. Name</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
            //3/27/19  mrno -> Dr
            strPrindData.push("</td><td>Consultn. No.</td><td>:</td>");
            strPrindData.push("<td>" + strTran + "<td></tr>");
            //Meenakshi To add exemption and emp ID
            if (GridData.jsonUserdtls[0].COCANAME != "") {
                strPrindData.push("<tr><td>Exemp Catg.</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].COCANAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
                if (GridData.jsonUserdtls[0].EMPID != ""){
                    strPrindData.push("<td>Employee ID</td><td>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "<td></tr>");
                }
                else
                {
                    strPrindData.push("<td>Exemp Proof</td><td>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "<td></tr>");
                }
            }
            strPrindData.push("</table></div>");//<td>:</td><td style='color:blue;font-size:12px'> Dr." + GridData.jsonUserdtls[0].DOCTNAME + "</td>

            //History start
            if (printWithHistory == "Y") {
                //if (GridData.jsonDoctorDetails[0].PRNTHISTYN == "Y") {
                if ($("#chkPersHist").prop("checked")) {
                    strPrindData.push("<div style='font-family:cambria header !important;font-size: 13px !important;' id='personalNMediDiv'>");
                    if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                        strPrindData.push("<br><div style='width:100%' id='divPersonalHist'>");
                    }

                    if (GridData.jsonPersonalHist.length > 0) {
                        strPrindData.push("<table id='personalHistTable'>");// border color added by vijeta on 19th march 2018
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                        for (var i = 0; i < GridData.jsonPersonalHist.length; i++) {
                            strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + "Addicted to <b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                            if (GridData.jsonPersonalHist[i].STOPAGE != 0) {//
                                if (GridData.jsonPersonalHist[i].STARTAGE != "")
                                    strPrindData.push(" from the age of " + GridData.jsonPersonalHist[i].STARTAGE)

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
                        strPrindData.push("<table style='font-family:cambria header !important;' class='tblFree'>");
                        if (GridData.jsonPersonalHist.length == 0) {
                            strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[12] + " :</u></caption>");
                        }
                        for (var i = 0; i < GridData.jsonFreePersonal.length; i++) {

                            strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + GridData.jsonFreePersonal[i].PERSHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                        }
                        strPrindData.push("</table>");
                    }
                    if (GridData.jsonPersonalHist.length > 0 || GridData.jsonFreePersonal.length > 0) {
                        strPrindData.push("</div>");
                    }
                }
                ////PERSONAL HISTORY 
                //medical history start
                if ($("#chkMedHist").prop("checked")) {
                    if (GridData.jsonMedicineHist.length > 0 || GridData.jsonFreeMedical.length > 0) {

                        //if (GridData.jsonPersonalHist.length == 0 && GridData.jsonFreePersonal.length == 0)
                        strPrindData.push("<br><div style='width:100%' id='divMedicalHist'>");
                        // else
                        // strPrindData.push("<br><div style='float:right;width:40%;' id='divMedicalHist'>");
                    }
                    if (GridData.jsonMedicineHist.length > 0) {
                        strPrindData.push("<table id='medicalHistTable' style='border-collapse:collapse;font-family:cambria header !important;' >");//4/8/19 border color added by vijeta on 19th march 2018                       
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[13] + " :</u></caption>")
                        for (var i = 0; i < GridData.jsonMedicineHist.length; i++) {
                            strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + "Suffering with <b>" + GridData.jsonMedicineHist[i].NAME + "</b>");
                            if (GridData.jsonMedicineHist[i].DURATION != "" && GridData.jsonMedicineHist[i].DURATION != 0)//
                                strPrindData.push(" since " + GridData.jsonMedicineHist[i].DURATION.toString() + " " + gDurType[GridData.jsonMedicineHist[i].DURTYPE] + "(s)");
                            strPrindData.push("</li></td></tr>");
                        }
                        strPrindData.push("</table>");
                    }
                    //free medical history
                    if (GridData.jsonFreeMedical != "") {
                        strPrindData.push("<table style='border-collapse:collapse;font-family:cambria header !important;' class='tblFree'>");
                        if (GridData.jsonMedicineHist.length == 0) {
                            strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[13] + " :</u></caption>")
                        }
                        for (var i = 0; i < GridData.jsonFreeMedical.length; i++) {

                            strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + GridData.jsonFreeMedical[i].MEDHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
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

                        strPrindData.push("<table id='familyHistTable' style='width:100%;border-collapse:collapse;font-family:cambria header !important;' >");// 4/8/19border color added by vijeta on 19th march 2018s
                        strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></caption>")
                        for (var i = 0; i < GridData.jsonFamilyHist.length; i++) {
                            if (GridData.jsonFamilyHist[i].DURATION != 0) {//
                                strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                                           GridData.jsonFamilyHist[i].DISEASES + "</b> since " + GridData.jsonFamilyHist[i].DURATION + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)");
                            }
                            else {
                                if (GridData.jsonFamilyHist[i].AGE > 0)
                                strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] + " (" + GridData.jsonFamilyHist[i].AGE + "yrs), suffering with <b>" +
                                                GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                                else
                                    strPrindData.push("<tr><td><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION] +  ", suffering with <b>" +
                                              GridData.jsonFamilyHist[i].DISEASES + "</b> ");
                            }
                            strPrindData.push("</li></td></tr>");
                        }
                        strPrindData.push("</table>");

                        // strPrindData.push("<br>");
                    }
                    //free family history
                    if (GridData.jsonFreeFamily != "") {
                        strPrindData.push("<table style='border-collapse:collapse;font-family:cambria header !important;' class='tblFree'>");
                        if (GridData.jsonFamilyHist.length == 0) {
                            strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'><u>" + HeaderLang[14] + " :</u></caption>")
                        }
                        for (var i = 0; i < GridData.jsonFreeFamily.length; i++) {

                            strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + GridData.jsonFreeFamily[i].FAMHIST.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
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
                        strPrindData.push("<tr><td style='font-size:13px !important;font-family:cambria header !important;'><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table>");
                }
            }

            //Vitals start     
            if ($("#chkVital").prop("checked")) {
                if (GridData.jsonVital.length > 0) {
                   
                    var flag = 0;
                    for (var t = 0; t < GridData.jsonVital.length; t++) {
                        var keyNames = Object.keys(GridData.jsonVital[t]);
                        for (var a = 0 ; a < keyNames.length; a++) {
                            //if ((GridData.jsonVital[t][keyNames[a]].toString().trim() != "")) {
                            if ((keyNames[a] == "PULSE" || keyNames[a] == "PAINSCORE" || keyNames[a] == "BP" || keyNames[a] == "RESP" || keyNames[a] == "SPO2" ||
                                keyNames[a] == "BMI" || keyNames[a] == "HEAD_CIRCUMFERENCE" || keyNames[a] == "PEFR" || keyNames[a] == "Technique" ||
                                keyNames[a] == "Compliance" || keyNames[a] == "VOTHERS" || keyNames[a] == "PAINSCORE" || keyNames[a] == "BSA" || keyNames[a] == "RBS" ||
                                keyNames[a] == "KARNOFSKY" || keyNames[a] == "ECOG") &&
                                (GridData.jsonVital[t][keyNames[a]].toString().trim() == "" ||
                                GridData.jsonVital[t][keyNames[a]].toString().trim() == "/" || GridData.jsonVital[t][keyNames[a]].toString().trim() == "N")) { }
                            else if ((keyNames[a] == "WEIGHT" || keyNames[a] == "HEIGHT" || keyNames[a] == "PULSE" || keyNames[a] == "TEMP") && Number(GridData.jsonVital[t][keyNames[a]]) == 0) {

                            }
                            else {
                                flag = 1;
                                GeneralExaminations += "<tr><td width='25px'><label style='color:black;'>" + keyNames[a] +
                                    "</label></td><td><label style='width='50px;font-size:13px !important'>" + ': ' + GridData.jsonVital[t][keyNames[a]];
                                if (keyNames[a] == "WEIGHT") { GeneralExaminations += " kgs"; }
                                else if (keyNames[a] == "HEIGHT") { GeneralExaminations += " cms"; }
                                else if (keyNames[a] == "TEMP") { GeneralExaminations += " °F"; }
                                else if (keyNames[a] == "BP") { GeneralExaminations += " mmHg"; }
                                else if (keyNames[a] == "PULSE") { GeneralExaminations += " bpm"; }
                                else if (keyNames[a] == "SPO2") { GeneralExaminations += " %"; }
                                else if (keyNames[a] == "BMI") { GeneralExaminations += " kg/(m^2)"; }
                                else if (keyNames[a] == "HEAD_CIRCUMFERENCE") { GeneralExaminations += " cms"; }
                                else if (keyNames[a] == "PEFR") { GeneralExaminations += " lit/min"; }
                                else if (keyNames[a] == "RBS") { GeneralExaminations += " mg/dl"; }
                                else if (keyNames[a] == "BSA") { GeneralExaminations += " m<sup>2</sup>"; }
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
                            rmrk = " (" + GridData.jsonComplaints[i].REMARKS + ")";
                        }
                        //------------------------------------------
                        // strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:5px;line-height:17px'><li>" + GridData.jsonComplaints[i].NAME + rmrk + "  " + TotalDuration + "</li></td></tr>");
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;width:50%;font-size:13px !important'><li>" + GridData.jsonComplaints[i].NAME + " " + TotalDuration + " " + rmrk.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                        //3/27/19 4/16/19 changed style
                    }
                }

                //free complaint vijeta 20th march 19
                if (GridData.jsonFreeComplaints.length > 0) {
                    if (GridData.jsonFreeComplaints[0].hasOwnProperty("FREECOMPLAINT")) {
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;font-size:13px !important'><li>" + GridData.jsonFreeComplaints[0].FREECOMPLAINT.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                    }
                }
                if (GridData.jsonComplaints.length > 0 || GridData.jsonFreeComplaints.length > 0) {
                    strPrindData.push("</table>");
                }
                strPrindData.push("</div>")
            }
            //complaint end

            //Exam start
            if ($("#chkExamin").prop("checked")) {
                if (GridData.jsonExam[0]["EXAM"] !== "") {
                   
                    strPrindData.push("<table style='width:100%;'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>" + HeaderLang[10] + " </u>: </label></td></tr>")
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:5px;line-height:20px;'>" + GridData.jsonExam[0]["EXAM"].toString().replace(/\n/g, '<br />') + "</td></tr>");
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
                    strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[19] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PROVDIAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                if (GridData.jsonFollowUp[0]["COMPOSTAG"].toString().trim() != "")
                    strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Composit Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                if (GridData.jsonFollowUp[0]["TSTAGE"].toString().trim() != "") {
                    strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                    strPrindData.push("<label class='HTextsize' style='font-weight:bold'><u>TNM Staging</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
                    strPrindData.push("<td style='align:left'>T:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["TSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                    strPrindData.push("<td style='align:left'>N:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["NSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                    strPrindData.push("<td style='align:left'>M:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["MSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                    strPrindData.push("</tr></table></br>");
                }

                if (GridData.jsonDiagnosis.length > 0) {

                    if (GridData.jsonICDiagnosis.length <= 0) {
                        strPrindData.push("<table style='width:100%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
                    } else {
                        strPrindData.push("<table style='width:50%;float:left'><tr><td><label class='HTextsize' style='font-weight:bold;'><u>Final Diagnosis</u>: </label></td></tr>")
                    }

                    // width chngd the width nd remvd float
                    for (var i = 0; i < GridData.jsonDiagnosis.length; i++) {
                        var DiagRemark = "";

                        if (GridData.jsonDiagnosis[i].REMARKS != "") {
                            DiagRemark = " " + " - " + GridData.jsonDiagnosis[i].REMARKS
                        }
                        // strPrindData.push("<tr style='line-height:15px;'><td class='DTextsize' style='padding:5px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark + "</li></td></tr>");//3/27/19 commntd
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='line-height:15px;'><li>" + GridData.jsonDiagnosis[i].NAME + DiagRemark.toString().replace(/\n/g, '<br />') + "</li></td></tr>");
                        //
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
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;font-size:13px !important;'><li>" + GridData.jsonInvstg[i].TESTNAME + " - " + GridData.jsonInvstg[i].REMARK + TotalDuration + "</li></td></tr>");//
                    }
                }


                //vijeta 20th march 19

                if (GridData.jsonFreeInvestigation.length > 0) {
                    strPrindData.push("<tr class='inHeight'><td class='DTextsize' style='padding:2px;font-size:13px !important;'><li>" + GridData.jsonFreeInvestigation[0].FREEINVESTIGATION.toString().replace(/\n/g, '<br />') + "</li></td></tr>");// removed line-hght
                }
                if (GridData.jsonInvstg.length > 0 || GridData.jsonFreeInvestigation.length > 0)
                    strPrindData.push("</table>");

            }

            //Investigation end
            //strPrindData.push("<br>");
            //Patient Advice start
            if ($("#chkInvest").prop("checked")) {
                if (GridData.jsonPatientAdvice.length > 0) {
                    // strPrindData.push("<br><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[3] + " </u>: </label>")

                    strPrindData.push("<br><table style='width:100%;'><tr><td>" + "<label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[3] + " </u>: </label></td></tr>");//

                    // strPrindData.push("<table>")
                    for (var i = 0; i < GridData.jsonPatientAdvice.length; i++) {
                        strPrindData.push("<tr class='inHeight'><td class='DTextsize'  style='padding:2px;font-size:13px !important'><li>" + GridData.jsonPatientAdvice[i].NAME + "</li></td></tr>");
                    }
                    strPrindData.push("</table>")
                    ///strPrindData.push("<br>");
                }
            }
            //Patient Advice end

            //folowup start         
            var dt = "", refDoct = "";
            if (GridData.jsonFollowUp.length > 0) {//
                var dayNum = "", constString = "";
                refDoct = GridData.jsonFollowUp[0]["REFDOCT"];
                refSpecilist = GridData.jsonFollowUp[0]["REFSPECIALIST"];
                for (var e = 0; e < GridData.jsonFollowUp.length; e++) {
                    if (GridData.jsonFollowUp[0]["SURGNMADVICE"] != "") {
                      strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>Surgery Advice</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label  style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["SURGNMADVICE"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");
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
                                strPrindData.push("&#9679;<li style='display: inline;list-style:circle;font-size:13px !important'>Dr. " + val.toString().replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
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
                                strPrindData.push("&#9679;<li style='display: inline;list-style:circle;font-size:13px !important'>" + val.toString().replace(/\n/g, '<br />') + "&nbsp;&nbsp;&nbsp;&nbsp;</li>");
                        });
                        strPrindData.push("</ul></td>");
                        strPrindData.push("</tr><table>")
                    }

                
                    if (GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().trim() != "" && $("#chkPlanOfTreatmnt").prop("checked"))
                        strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[18] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PLANOFTREAT"].toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    //added on 13th march 19 for prescription remark
                    var remark = GridData.jsonFollowUp[0]["REMARK"];
                    if (remark != "" && $("#chkRemark").prop("checked"))
                        strPrindData.push("<table style='width:100%;margin-top:10px'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'><label class='HTextsize' style='font-weight:bold'><u>" + HeaderLang[16] + "</u></label></td><td style='vertical-align:top;width:3%'><b>:</b></td><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + remark.toString().replace(/\n/g, '<br />') + "</label></td></tr></table>");

                    if (GridData.jsonFollowUp[e].FOLLOWUPDT.length > 0) {
                        dayNum = (GridData.jsonFollowUp[e].FOLLOWUPDT).replace(/[^0-9]+/ig, "");
                        FollowUp = (GridData.jsonFollowUp[e].FOLLOWUPDT).split(dayNum);
                        checkFollowUplanguge(FollowUp, language, 'F')
                        strPrindData.push("<br>");
                        strPrindData.push("<table style='width:100%'>")
                        var adviceInv = ""

                        if (dayNum.length > 0) {
                            if (Number(dayNum) > 1) {
                                constString = "s"
                            }
                        }

                        if (GridData.jsonInvstg.length > 0)
                            adviceInv = "with Advised Investigation Reports if any";

                        //vijeta 16th march 19
                        if (GridData.jsonFollowUp[e].APPMNTDT != "" && GridData.jsonFollowUp[e].APPMNTTM != "") {//vijeta 16th march 19
                            strPrindData.push("<table style='width:100%;'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Follow up on " + GridData.jsonFollowUp[e].APPMNTDT + " at " + GridData.jsonFollowUp[e].APPMNTTM + " " + adviceInv + "</td></table><br>");
                        }
                        else if (GridData.jsonFollowUp[e].FOLLOWUPDT == "SOS") {
                            strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + "Follow Up : " + "&nbsp;" + "SOS" + " if any complaints " +  constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                        }
                        else
                        strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + HeaderLang[8] + "&nbsp;" + dayNum + " " + languageWise + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                    }

                }

            }
            //followup end


            //container end
            strPrindData.push("</div>");
            var StrDoctCode = '<%:Session["gDoctCode"]%>';
            
                //  strPrindData.push("<div style='bottom:60;position:absolute;float:right!important'><label style='font-style:Arial;font-size:12px; font-weight:bold;margin-left:440px;margin-bottom:70px'>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</label>");

                //by vijeta 14/03/19  
            strPrindData.push("<br><div id='footer' style='width:100%;float:right!important;'>");
            strPrindData.push("<table style='float:left!important;font-family:cambria header !important;font-size: 12px !important;' id='tblDoctInfo'>");
            if (digitsign1 != "")
                strPrindData.push("<tr><td><b><img src=" + digitsign1 + "  /></b></td>");
            if (digitsign2 != "")
                strPrindData.push("<td><b><img src=" + digitsign2 + "  /></b></td>");
            if (digitsign3 != "")
                strPrindData.push("<td><b><img src=" + digitsign3 + "  /></b></td></tr>");
                strPrindData.push("<tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</b></td></tr>");
                if (GridData.jsonDoctorDetails[0].SIGN == "") {
                   
                        strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");//vijeta 28/03/19
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
                strPrindData.push("</div>");

                //strPrindData.push("<div id='footer'><label style='font-style:Arial;font-size:14px; font-weight:bold;margin-left:415px;width:220px;float:right!important;text-align:left;'>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</label>"); // div id=footer added by vijeta on 14th march 2018
                //if (StrDoctCode != "000549") {
                //    strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:220px;float:right!important;text-align:left;'>" + GridData.jsonDoctorDetails[0].QUALI + "</label>");
                //    strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:220px;float:right!important;text-align:left;'>" + "Reg No : " + GridData.jsonDoctorDetails[0].MCCNO + "</label>");
                //    //strPrindData.push("<footer><p><label style='font-style:Arial;font-size:14px; font-weight:bold;margin-left:415px;width:200px;float:right!important;text-align:left;'>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</label>");
                //    //strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:200px;float:right!important;text-align:left;'>" + GridData.jsonDoctorDetails[0].QUALI + "</label>");
                //    //strPrindData.push("<label style='font-style:Arial;font-size:13px; margin-left:415px;width:200px;float:right!important;text-align:left;'>" + "Reg No : " + GridData.jsonDoctorDetails[0].MCCNO + "</label>");
                //}
               
                strPrindData.push("</div>");
                strPrindData.push("</body></html>");
            return strPrindData.join("");
        }

        //Meenakshi created common function to display a rx table and called from all three template function 
            function RxTable()
            {
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
                    $.each(GridData.jsonAdvice, function (key, value) {  // here we set flag " CheckForRemarkFlag" and display coloumn on print pdf,added by ajinkya 2-12-2019
                        if (value.REMARKS != "" || value.ABFOOD != "-") {
                            CheckForRemarkFlag = 1;
                            return false;
                        }
                    });
                    //strPrindData.push("<div style='margin-bottom:5px'><label style='font-size:40px;'> &#x211E;</label></div>")
                    medTbl1 = "<br><table style='width:100%;empty-cells: hide;border-collapse:collapse;page-break-inside:avoid' border='1'>";
                    medTbl1 += "<caption style='font-size:40px;text-align:left' > &#x211E;</caption>";

                    for (var i = 0; i < GridData.jsonAdvice.length; i++) {
                        var dosage = '';
                        var advicesplitVal = [];
                        var advicedayNum = '';
                        var IntakeRemark = '';
                        var Route = ''; QTY = '';
                        Food = "";
                        var strConS = '';
                        var concateComma = '';
                        var genericNm = GridData.jsonAdvice[i]["GENERICNAME"].toString() != "" ? "(" + GridData.jsonAdvice[i]["GENERICNAME"].toString() + ")" : "";//added by vij on 26th oct 2018

                        dosage = (GridData.jsonAdvice[i]["DOSSAGE"] == "" || GridData.jsonAdvice[i]["DOSSAGE"] == "undefined") ? "" : GridData.jsonAdvice[i]["DOSSAGE"]//
                        
                        Route = (GridData.jsonAdvice[i]["ROUTE"] == "" || GridData.jsonAdvice[i]["ROUTE"] == "undefined") ? "" : GridData.jsonAdvice[i]["ROUTE"]
                 
                        QTY = (GridData.jsonAdvice[i]["QTY"] == "" || GridData.jsonAdvice[i]["QTY"] == "undefined") ? "" : GridData.jsonAdvice[i]["QTY"]
                       
                        intake = (GridData.jsonAdvice[i]["INTAKE"] == "" || GridData.jsonAdvice[i]["INTAKE"] == "undefined") ? "" : GridData.jsonAdvice[i]["INTAKE"].replace(/0.5/g, "1/2")

                        remark = (GridData.jsonAdvice[i]["REMARKS"] == "" || GridData.jsonAdvice[i]["REMARKS"] == "undefined") ? "" : GridData.jsonAdvice[i]["REMARKS"]

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
                                advicedayNum = ''; IntakeLanguage = ''; strConS =''
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

                        Medicine += "<tr class='inHeight'><td style='padding:3px;width:35%;line-height:15px;'><label style='font-size:13px !important;text-align:center;font-weight:bold;'>" + GridData.jsonAdvice[i]["DRUGNM"] + "</label>" + "<label style='font-size:8.5px !important'>" + " " + genericNm + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + intake + " " + IntakeRemark + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + dosage + "</label></td><td class='HTextsize' style='width:8%;text-align:center;'><label>" + QTY + "</label></td><td class='HTextsize' style='width:8%;text-align:center;line-height:17px;'>" + advicedayNum + ' ' + IntakeLanguage + strConS + "</td><td class='HTextsize' style='width:10%;line-height:17px;'>" + Route + "</td><td class='HTextsize' style='width:30%;line-height:17px;'>" + Food + concateComma + remark + "</td></tr>"
                    }

                    medTbl1 += "<tr><td style='padding:3px;font-weight:bold;font-size:13px; width:24%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Medicine Name</label></td><td style='padding:3px;font-weight:bold;width:10%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Regime</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Dosage</label></td><td style='padding:3px;font-weight:bold;width:8%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Qty</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;'><label style='font-size:13px !important;text-align:center;'>Duration</label></td><td style='padding:3px;font-weight:bold;width:12%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Route</label></td><td style='padding:3px;font-weight:bold;width:24%;text-align:center;line-height:17px;'><label style='font-size:14px !important;text-align:center;line-height:17px;'>Remark</label></td></tr>" + Medicine + "";
                    //medTbl1 += "</table>";

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
                '07': 'Grand Mother'
            };
            var FollowUp = []
            var VitalKeyName = ""
            var dayNum = ""

            strPrindData.push("<html><head><meta http-equiv='Content-Type' content='text/html;charset=utf-8'/>");// metacode added23-04-2020
            strPrindData.push(" <style> .cltable {border-collapse: collapse;} table.cltable td, th {border: 1px solid #ddd;text-align: left;} .HTextsize{font-size: 14px !important ;padding:3px;} .DTextsize{font-size: 14px !important;} .inHeight{line-height:14px !important}  @page {margin-top: 4cm;margin-bottom: 3cm;} @media print {body {margin-top: 0mm; margin-bottom: 0mm;  margin-left: 0mm; margin-right: 0mm } #footer{ bottom:0;margin-top: 25pt;} }  #tblPatInfo td{padding: 1px; white-space:nowrap;} #header {display: block;position: running(header);}</style></head>");//position: fixed; changed by vijeta on 14th march 2018
            strPrindData.push("<body style='margin-left:25;font-family:cambria header !important;font-size: 13.5px !important;'>");
            var label = "Patient Category";
            // var Patcatg = $('#spPatcatgnm')[0].textContent;
            var Patcatg = "";
            var doctName = "";

            //container div
            strPrindData.push("<div id='header' class='container'>");

            ////User Details/////
            strPrindData.push("<table style='width:100%;border-bottom:solid 1px black;border-top:solid 1px black;margin-bottom:5px;border-collapse:collapse;font-family:cambria header !important;font-size: 13px !important;' id='tblPatInfo'>");
           
            strPrindData.push("<tr><td>Name</td><td>:</td><td>" + GridData.jsonUserdtls[0].PATNAME + "</td>" +
                "<td>Age/Gender</td><td>:</td>");
            strPrindData.push("<td>" + (GridData.jsonUserdtls[0].PATAGE).toString().substring(0, 3) + ' ' + 'Years' + " / " + (GridData.jsonUserdtls[0].PATSEX == 'M' ? 'Male' : 'Female') + "</td></tr><tr><td>MR No.</td><td>:</td><td>" + Mrno + "</td>");
          
            strPrindData.push("<td>Date/Time</td><td>:</td><td>" + GridData.jsonUserdtls[0].TRANDATE + " </td>"); //3/27/19 gap reduced
            strPrindData.push("</tr><tr><td>Dr. Name</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
           
            strPrindData.push("</td><td>Consultn. No.</td><td>:</td>");
            strPrindData.push("<td>" + strTran + "<td></tr>");
            //Meenakshi To add exemption and emp ID
            if (GridData.jsonUserdtls[0].COCANAME != "") {
                strPrindData.push("<tr><td>Exemp Catg.</td><td >:</td><td>Dr. " + GridData.jsonUserdtls[0].COCANAME + "</td>");//<td style='color:blue; font-size:13px'>Mobile No.</td><td >:</td><td style='color:blue;font-size:12px'>" + GridData.jsonUserdtls[0].PATMOBILE + "</td>
                if (GridData.jsonUserdtls[0].EMPID != "") {
                    strPrindData.push("<td>Employee ID</td><td>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].EMPID + "-" + GridData.jsonUserdtls[0].EMPDEPNDCD + "<td></tr>");
                }
                else {
                    strPrindData.push("<td>Exemp Proof</td><td>:</td>");
                    strPrindData.push("<td>" + GridData.jsonUserdtls[0].CONSCATPROOF + "<td></tr>");
                }
            }
            strPrindData.push("</table></div>");

            /*****************************************General Examination**********************************************/
            var Gflag = 0;
            if (GridData.jsonVital.length > 0) {

                for (var t = 0; t < GridData.jsonVital.length; t++) {
                    var keyNames = Object.keys(GridData.jsonVital[t]);
                    for (var a = 0 ; a < keyNames.length; a++) {
                        //if ((GridData.jsonVital[t][keyNames[a]].toString().trim() != "")) {
                        if ((keyNames[a] == "PULSE" || keyNames[a] == "BP" || keyNames[a] == "RESP" || keyNames[a] == "SPO2" || keyNames[a] == "BMI" ||
                            keyNames[a] == "HEAD_CIRCUMFERENCE" || keyNames[a] == "PEFR" || keyNames[a] == "PAINSCORE" || keyNames[a] == "Technique" ||
                            keyNames[a] == "Compliance" || keyNames[a] == "VOTHERS" || keyNames[a] == "BSA" || keyNames[a] == "RBS"
                    || keyNames[a] == "KARNOFSKY" || keyNames[a] == "ECOG") && (GridData.jsonVital[t][keyNames[a]].toString().trim() == "" ||
                            GridData.jsonVital[t][keyNames[a]].toString().trim() == "/" || GridData.jsonVital[t][keyNames[a]].toString().trim() == "N"))
                        { }
                        else if ((keyNames[a] == "WEIGHT" || keyNames[a] == "HEIGHT" || keyNames[a] == "PULSE" || keyNames[a] == "TEMP")
                            && Number(GridData.jsonVital[t][keyNames[a]]) == 0)
                        {                        }
                        else {
                            Gflag = 1;
                            GeneralExaminations += "<tr class='inHeight'><td class='DTextsize' style='padding-right:3px !important'><label style='color:black;'><li>" + keyNames[a] + "</label></td><td class='DTextsize'><label style=''>" + ': ' + GridData.jsonVital[t][keyNames[a]];
                            if (keyNames[a] == "WEIGHT") { GeneralExaminations += " kgs"; }
                            else if (keyNames[a] == "HEIGHT") { GeneralExaminations += " cms"; }
                            else if (keyNames[a] == "TEMP") { GeneralExaminations += " °F"; }
                            else if (keyNames[a] == "BP") { GeneralExaminations += " mmHg"; }
                            else if (keyNames[a] == "PULSE") { GeneralExaminations += " bpm"; }
                            else if (keyNames[a] == "SPO2") { GeneralExaminations += " %"; }
                            else if (keyNames[a] == "BMI") { GeneralExaminations += " kg/(m^2)"; }
                            else if (keyNames[a] == "HEAD_CIRCUMFERENCE") { GeneralExaminations += " cms"; }
                            else if (keyNames[a] == "PEFR") { GeneralExaminations += " lit/min"; }
                            else if (keyNames[a] == "RBS") { GeneralExaminations += " mg/dl"; }
                            else if (keyNames[a] == "BSA") { GeneralExaminations += " m<sup>2</sup>"; }
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
                        rmrk = " (" + GridData.jsonComplaints[c].REMARKS+")";
                    }
                    //------------------------------------------

                    ChiefComplaints += "<tr class='inHeight'><td class='DTextsize' style='padding:2px;'><li>" + GridData.jsonComplaints[c].NAME + " " + TotalDuration + " "+rmrk.toString().replace(/\n/g, '<br />')+"</li></td></tr>";
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
                    strPrindData.push("<tr><td><table style='font-family:cambria header !important;font-size: 13px !important;width:100%'>" + GeneralExaminations + "</table><br></td></tr>");
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
                       
                        familyHistory += "<tr><td class='DTextsize' style='padding:0px;'><li>" + patName + "'s " + gRelation[GridData.jsonFamilyHist[i].RELATION];

                        if(GridData.jsonFamilyHist[i].AGE  > 0)
                            familyHistory += " (" + GridData.jsonFamilyHist[i].AGE + "yrs)";
                        
                        familyHistory += ", suffering with <b>" + GridData.jsonFamilyHist[i].DISEASES + "</b>";

                        if (GridData.jsonFamilyHist[i].DURATION != 0 && GridData.jsonFamilyHist[i].DURATION != '')
                            familyHistory += " since" + GridData.jsonFamilyHist[i].DURATION.toString() + " " + gDurType[GridData.jsonFamilyHist[i].DURTYPE] + "(s)" + "</li></td></tr>";
                        else {
                            familyHistory += "</li></td></tr>";
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


            if (GridData.jsonFollowUp[0]["PROVDIAG"].toString().trim() != "")
            {
                strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>" + HeaderLang[19] + "</label> : </td></tr>");
                strPrindData.push("<tr><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["PROVDIAG"].toString().replace(/\n/g, '<br />') + ")")
                strPrindData.push("</label></td></tr></table>");
            }


            if (GridData.jsonFollowUp[0]["COMPOSTAG"].toString().trim() != ""){
                strPrindData.push("<table style='width:100%;margin-top:10px;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>Composit Staging</label> : </td></tr>");
                strPrindData.push("<tr><td style='align:left'><label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["COMPOSTAG"].toString().replace(/\n/g, '<br />') + "</label>");
                strPrindData.push("</td></tr></table>");
            }
    

            if (GridData.jsonFollowUp[0]["TSTAGE"].toString().trim() != "") {
                strPrindData.push("<table style='width:100%;'><tr style='line-height:19px;'><td style='width:25%;vertical-align:top;'>");
                strPrindData.push("<label class='HTextsize' style='font-weight:bold'>TNM Staging</label></td><td style='vertical-align:top;width:3%'><b>:</b></td>");
                strPrindData.push("<td style='align:left'>T:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["TSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>N:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["NSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("<td style='align:left'>M:<label class='HTextsize' style='font-size:13px !important'>" + GridData.jsonFollowUp[0]["MSTAGE"].toString().replace(/\n/g, '<br />') + "</label></td>");
                strPrindData.push("</tr></table></br>");
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

            /*--------start---------Advice -----------------------------------------------------------------------*/


            if (GridData.jsonPatientAdvice.length > 0) {
                for (var e = 0; e < GridData.jsonPatientAdvice.length; e++) {
                    PatAdvice += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:13px;'><li>" + GridData.jsonPatientAdvice[e].NAME + "</label></td></tr>"
                }
                strPrindData.push("<tr><td class='HTextsize' style='width: 611px'><label style='color:black;font-weight:bold;'>" + HeaderLang[3] + ' :' + "</label></td></tr><tr><td style='width: 611px;line-height:15px;'><table>" + PatAdvice + "</table><br>")

            }
            /*--------End---------Advice end here -----------------------------------------------------------------------*/

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
                    AdviceforInvst += "<tr class='inHeight'><td class='DTextsize'><label style='color:black;line-height:15px;'><li>" + GridData.jsonInvstg[e].TESTNAME + " - " + GridData.jsonInvstg[i].REMARK + " " + TotalDuration + "</label></td></tr>"
                }
            }
            //free investigation vijeta 20th march 19 free investigation
            if (GridData.jsonFreeInvestigation.length > 0) {
                AdviceforInvst += "<tr class='inHeight'><td class='DTextsize' style='padding:5px;line-height:15px;'><li>" + GridData.jsonFreeInvestigation[0].FREEINVESTIGATION.toString().replace(/\n/g, '<br />') + "</li></td></tr>";
            }
            if (GridData.jsonFreeInvestigation.length > 0 || GridData.jsonInvstg.length > 0)
                strPrindData.push("<tr><td><table><tr><td class='HTextsize'><label style='color:black;font-weight:bold;'>" + HeaderLang[4] + ' :' + "</label></td style:'line-height:15px;'></tr>" + AdviceforInvst + "</table><br></td></tr>")
            /*--------End---------Advice for Investigation end here-----------------------------------------------------------------------*/

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
                        strPrindData.push("<tr><td style='font-size:13px !important'><li>" + "Addicted to <b>" + GridData.jsonPersonalHist[i].NAME + "</b>");
                        if (GridData.jsonPersonalHist[i].STOPAGE != 0) {
                            if (GridData.jsonPersonalHist[i].STARTAGE != "")
                                strPrindData.push(" from the age of " + GridData.jsonPersonalHist[i].STARTAGE)

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
                    strPrindData.push("<table id='medicalHistTable' style='border-collapse:collapse;' >");//4/8/19 border color added by vijeta on 19th march 2018                       
                    strPrindData.push("<caption class='HTextsize' style='font-weight:bold;text-align:left'>" + HeaderLang[13] + " :</caption>")
                    for (var i = 0; i < GridData.jsonMedicineHist.length; i++) {
                        strPrindData.push("<tr><td style='font-size:13px !important'><li>" + "Suffering with <b>" + GridData.jsonMedicineHist[i].NAME + "</b>");
                        if (GridData.jsonMedicineHist[i].DURATION != "" && GridData.jsonMedicineHist[i].DURATION != 0)//
                            strPrindData.push(" since " + GridData.jsonMedicineHist[i].DURATION.toString() + " " + gDurType[GridData.jsonMedicineHist[i].DURTYPE] + "(s)");
                        strPrindData.push("</li></td></tr>");
                    }
                    strPrindData.push("</table><br>");
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
                    strPrindData.push("<tr><td style='font-size:13px !important'><li>" + "Allergy - <b>" + GridData.jsonAllergy[i].NAME + "</b>");

                    strPrindData.push("</li></td></tr>");
                }
                strPrindData.push("</table></table>");
            }
            // end allergy

            /************************end******************************************/
            //Exam start

            if (GridData.jsonExam[0]["EXAM"] !== "") {
                // strPrindData.push("<div style='width:100%'>");
                strPrindData.push("<br><table style='width:100%'>")
                strPrindData.push("<tr><td>" + "<label class='HTextsize' style='font-weight:bold;padding-bottom:5px'>" + HeaderLang[10] + ": </label><br><label  class='DTextsize' style='padding:5px!important;'>" + GridData.jsonExam[0]["EXAM"].toString().replace(/\n/g, '<br />') + "</label>" + "</td>"); //.replace(/\n/g, '<br />') added by vijeta on 14th march 2018
                strPrindData.push("</tr>");
                strPrindData.push("</table><br>")
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

            //med advc start 
            if (GridData.jsonAdvice.length > 0) {
                var medRxTbl = RxTable();
                strPrindData.push(medRxTbl);
            }
            /*--------start---------FollowUp----------------------------------------------------------------------*/
            var dt = "", refDoct = "";
            if (GridData.jsonFollowUp.length > 0) {
                var dayNum = "", constString = "";
                refDoct = GridData.jsonFollowUp[0]["REFDOCT"];
                refSpecilist = GridData.jsonFollowUp[0]["REFSPECIALIST"];
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

                    if (GridData.jsonFollowUp[e].FOLLOWUPDT.length > 0) {
                        dayNum = (GridData.jsonFollowUp[e].FOLLOWUPDT).replace(/[^0-9]+/ig, "");
                        FollowUp = (GridData.jsonFollowUp[e].FOLLOWUPDT).split(dayNum);
                        checkFollowUplanguge(FollowUp, language, 'F')
                        strPrindData.push("<br>");
                        strPrindData.push("<table style='width:100%'>")
                        var adviceInv = ""

                        if (dayNum.length > 0) {
                            if (Number(dayNum) > 1) {
                                constString = "s"
                            }
                        }

                        if (GridData.jsonInvstg.length > 0)
                            adviceInv = "with Advised Investigation Reports  if any";

                        //vijeta 16th march 19
                        if (GridData.jsonFollowUp[e].APPMNTDT != "" && GridData.jsonFollowUp[e].APPMNTTM != "") {//vijeta 16th march 19
                            strPrindData.push("<table style='width:100%;'><tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>Follow up on " + GridData.jsonFollowUp[e].APPMNTDT + " at " + GridData.jsonFollowUp[e].APPMNTTM + " " + adviceInv + "</td></table><br>");
                        }
                        else if (GridData.jsonFollowUp[e].FOLLOWUPDT == "SOS") {
                            strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + "Follow Up : " + "&nbsp;" + "SOS" + " if any complaints " +  constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>
                        }
                        else
                        strPrindData.push("<tr class='inHeight'><td><label class='HTextsize' style=';font-weight:bold'>" + HeaderLang[8] + "&nbsp;" + dayNum + " " + languageWise + constString + " " + HeaderLang[9] + adviceInv + "</td></tr></table>")//</label>

                    }

                }
            }
            //followup end

            var StrDoctCode = '<%:Session["gDoctCode"]%>';
                
                    // strPrindData.push("<div style='bottom:45;position:absolute;float:right!important'><label style='font-style:Arial;font-size:12px; font-weight:bold;margin-left:440px;margin-bottom:70px'>Dr. " + GridData.jsonUserdtls[0].DOCTNAME + "</label>");
                    //by vijeta 14/03/19  
                    strPrindData.push("<br><div id='footer' style='width:100%;'>");

  
                    strPrindData.push("<table style='float:left!important;font-family:cambria header !important;font-size: 12px !important;'  id='tblDoctInfo'>");
                    strPrindData.push("<tr><td><b>Dr. " + GridData.jsonDoctorDetails[0].DOCTNAME + "</b></td></tr>");
                    //-- end
                    if (GridData.jsonDoctorDetails[0].SIGN == "") { 
                        
                            strPrindData.push("<tr><td>" + "" + GridData.jsonDoctorDetails[0].SPECIALIZATION + "</td></tr>");//vijeta 28/03/19
                            strPrindData.push("<tr><td>" + GridData.jsonDoctorDetails[0].QUALI + "</td></tr>");
                            strPrindData.push("<tr><td>" + "Reg No. : " + GridData.jsonDoctorDetails[0].MCCNO + "</td></tr>");
                        
                        strPrindData.push("</table>");
                    }
                    else {
                        //strPrindData.push("<table style='float:right!important;' id='tblDoctInfo'>");
                        //strPrindData.push("<tr><td style='font-size: 12px !important;'>" + GridData.jsonDoctorDetails[0].SIGN.toString().replace(/\n/g, '<br />') + "</td></tr>");
                        if (sign1 != "")
                            strPrindData.push("<tr><td><b><p>" + sign1.replace(/\n/g, "<br />") + "</p></b></td>");
                        if (sign2 != "")
                            strPrindData.push("<td><b><p>" + sign2.replace(/\n/g, "<br />") + "</p></b></td>");
                        if (sign3 != "")
                            strPrindData.push("<td><b><p>" + sign3.replace(/\n/g, "<br />") + "</p></b></td></tr>");
                        strPrindData.push("</table>");
                    }
                    strPrindData.push("</div>");

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
                        if (data) {

                            //$("#DoctorInput").val(data["REFDOCTNAME"].toString());// commented by vijeta on 20th march 2018
                            $("#DoctorShow").val(data["REFDOCTNAME"].toString());// added by vijeta on 20th march 2018

                            $("#Numbers").text(data["DURATION"].toString());
                            $("#DaySelect").text(data["DURATIONTYPE"].toString());

                            $("#hdnDoctCode").val(data["REFDOCTNAME"].toString());
                            //$('#hdnNumber').val(data["DURATION"].toString());
                            //$('#hdnDayselect').val(data["DURATIONTYPE"].toString());

                            //VISHAL SOS 
                            if (data["DURATIONTYPE"].toString() == "SOS")
                            {                              
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
                            //$("#ClinicInput").val(data["REFSPECIALIST"].toString());// commented by vijeta on 21st march 2018
                            $("#ClinicShow").val(data["REFSPECIALIST"].toString()); // added by vijeta on 21st match 2018
                            //added on 28th July 2018
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
                            }

                            $("#PrescriptionRemark").val(data["REMARK"].toString().trim());
                            $("#PlanOfTreatmnt").val(data["PLANOFTREAT"].toString().trim());

                            if (data["CALLDONEYN"].toString().trim() == "Y")
                                $("#chkCallDoneYN")[0].checked = true;
                        }
                    },

                    complete: function () {
                        document.body.style.cursor = "default";
                    }

                })
            }
        

            //commented by vijeta on 20th march 2018
            //$(document.body).on('click', '#tblDoctors tr', function (e) {

            //    var doctName = $(this)[0].innerText.toString();
            //    var doctCode = $(this)[0].id;
            //    $("#DoctorInput").val(doctName);
            //    $("#tblDoctors tr").hide();
            //    $("#hdnDoctCode").val(doctCode);

            //});

            //commented by vijeta on 21st march 2018
            //$(document.body).on('click', '#tblclinic tr', function (e) {

            //    var ClinicName = $(this)[0].innerText.toString();
            //    var ClinicCode = $(this)[0].id;
            //    $("#ClinicInput").val(ClinicName);
            //    $("#tblclinic tr").hide();
            //    $("#hdnclinic").val(ClinicCode);
            //});

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
                else
                {

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

                                $.each(data, function (i, item) {

                                    //var rows = "<tr id='" + item.DoctCode + "' style='display:none'>" + "<td>" + item.DoctName + "</td>" + "</tr>";//commented by vijeta on 21st march 2018
                                    var rows = "<tr id='" + item.SurgCode + "' style=''>" + "<td style='width: 20px'> <input type='checkbox' id='" + item.SurgCode + "' value='" + item.SurgName + "' /> </td>" + "<td>" + item.SurgName + "</td>" + "</tr>";

                                    $('#tblSurgery').append(rows);

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
               // $.fancybox.close();
            }
            function NotOKbutton() {

                window.location.href = '../DoctorDesk/RxNewSearch';
            }
            var surgCount = 0;
            $(document.body).on('click', '#tblSurgery input,#tblSurgery tr', function (e) {
                var SurgeryCode = $(this)[0].id;
                //var doctName = "";

                if ($(this).is('#tblSurgery input')) {
                    //var doctName1 = $(this)[0].defaultValue.trim().toString();
                    var surgName1 = $(this)[0].parentElement.parentElement.innerText.trim().toString();
                    if ($(this)[0].checked == true) {

                        if (strSurgeries != "")
                            strSurgeries = strSurgeries + "," + surgName1;
                        else
                            strSurgeries = strSurgeries + surgName1;

                        if (strSurgeryCodes != "")
                            strSurgeryCodes = strSurgeryCodes + "," + SurgeryCode;
                        else
                            strSurgeryCodes = strSurgeryCodes + SurgeryCode;

                        surgCount = Number(surgCount) + 1;
                    }
                    else {

                        var strSurgeryName = surgName1;
                        var strSurgeryCode = SurgeryCode;

                        if (surgCount > 1) {
                            strSurgeryName = "," + surgName1;
                            var strSurgeryCode = "," + SurgeryCode;
                        }


                        var strSurgeryCode = "," + SurgeryCode;
                        strSurgeries = strSurgeries.replace(strSurgeryName, "");
                        strSurgeryCodes = strSurgeryCodes.replace(strSurgeryCode, "");

                        surgCount = Number(surgCount) - 1;
                    }
                    e.stopPropagation();
                }
                else if ($(this).is('#tblSurgery tr')) {
                    var surgName = $(this)[0].innerText.trim().toString();

                    if ($(this)[0].children[0].children[0].checked == false) {

                        if (strSurgeries != "")
                            strSurgeries = strSurgeries + "," + surgName;
                        else
                            strSurgeries = strSurgeries + surgName;

                        if (strSurgeryCodes != "")
                            strSurgeryCodes = strSurgeryCodes + "," + SurgeryCode;
                        else
                            strSurgeryCodes = strSurgeryCodes + SurgeryCode;

                        $(this)[0].children[0].children[0].checked = true;

                        surgCount = Number(surgCount) + 1;
                    }
                    else {
                        var strSurgeryName = surgName;
                        var strSurgeryCode = SurgeryCode;

                        if (surgCount > 1) {
                            strSurgeryName = "," + surgName;
                            strSurgeryCode = "," + SurgeryCode;
                        }



                        strSurgeries = strSurgeries.replace(strSurgeryName, "");
                        strSurgeryCodes = strSurgeryCodes.replace(strSurgeryCode, "");
                        $(this)[0].children[0].children[0].checked = false;

                        surgCount = Number(surgCount) - 1;
                    }

                }
                $("#txtSurgeryAdvice").val("");
                $("#txtSurgeryAdvice").val(strSurgeries);
                $("#hdnSurgeryCode").val(strSurgeryCodes);
            });

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
                      //  SaveFollowUpPrint("", "N");
                    });

                }
            });
        
    </script>
</asp:Content>

