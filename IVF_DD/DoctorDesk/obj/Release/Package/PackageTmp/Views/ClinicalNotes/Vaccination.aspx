<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.VaccinationModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   <%-- <div class="row">--%>
   <%--     <div class="col-xs-12">--%>
  <%--<!DOCTYPE html>--%>
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div>
            <input style="width: 100%; background-color: #f7fcff; margin-left: -17px; margin-top: -22px; position: fixed; display:none;border: none;" class="empty" disabled>
        </div>
        <div id="MainDiv">
            <%-- ...............................................--%>
             



           <%-- <div style="width:100%;text-align:center">
            <a class="button1 button1-green" id="divForBack"  style="margin-bottom: 10px;margin-top: -10px;" onclick="SetpageDirctn()">
  <i class="fa fa-arrow-left"></i>
  <strong>Back</strong>
</a>
            </div>--%>
         <%--   .................................................--%>
            <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%;">
                


<div class="container" style="width:100%">

   <%-- ----------------------------------%>
      <div class="row" >
    <div class="col-md-12 col-sm-12">
                    <div style="float:right;">
            <a class="button1 button1-Addnew" id="myAdd11"  style="margin-bottom: 10px;margin-top: -10px;" onclick="ClearAllData()">
  <i class="fa fa-plus"></i>
  Clear
</a>
            </div>
            
            <div style="">
            <a class="button1 button1-green" id="divForBack"  style="margin-bottom: 10px;margin-top: -10px;" onclick="SetpageDirctn()">
  <i class="fa fa-arrow-left"></i>
  Back
</a>
            </div>
                    <div style="-webkit-box-shadow: 0px 0px 6px 2px #878888;" class="panel">
                        <div style="font-size:14px;" class="panel-heading divHeads">
                          Immunization Record</div>
                        <div style="font-size:12px;display:block" class="panel-body divBody">
                           
                               
                    
                     <table id="tblVitals" style="float: left;;margin-left: -10px;font-size:11px;">
                            <tbody style="line-height: 1.9">
                       <tr>
                                    <td style="width: 15%;">
                                        <label class="input-form-label" style="">Date of birth</label>
                                    </td>
                                   
                                    <td>
                                       
                                        <div class="input-group" style="">
                                            <%--<input id="txtCurrWeight" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Weight" value="0">--%>
                                              <input type="text" id="txtDOB" class="form-control input-form-control" readonly="readonly" class="form-control input-form-control" placeholder="DOB"/>
                                           <%-- <span class="input-group-addon input-form-addon">Kg</span>--%>
                                        </div>
                                    </td>

                               <%-- </tr>
                                <tr>--%>
                                    <td style="width: 15%;">
                                        <label class="input-form-label">Time</label>
                                    </td>

                                    
                    
                                    <td>
                                        <div class="input-group" style="">
                                           <%-- <input id="txtPrev" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Prev Weight" readonly="readonly">--%>
                                            <input type="text" id="txtTime" class="form-control input-form-control" style="" placeholder="Time"/>
                                        </div>
                                    </td>
                               <%-- </tr>

                                <tr>--%>
                                    
                                </tr>

                                <tr>
                                   <td>
                                        <label class="input-form-label">Birth weight</label>
                                    </td>

                                   
                    
                                    <td >
                                        <div class="input-group" style="">
                                          <%--  <input id="txtWghtLG" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Weight Loss" readonly="readonly">--%>
                                          <input type="text" id="txtweight" class="form-control input-form-control"  placeholder="Birth weight"/>
                                        </div>
                                    </td>
                   
                                    <td>
                                        <label class="input-form-label">Birth history</label></td>
                                    
                                    <td>
                                        <div class="input-group" style="width:100%">
                                         <%--   <input id="txtHeight" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Height" value="0">--%>
                                            <%=Html.DropDownListFor(x => Model.BirthHistory, new SelectList(Model.BirthHistoryList, "Value", "Text"), "---Select---", new { id="cmbBirthHistorySel",style="",maxlength="6",@class="form-control input-form-control"})%>
                      
                                        </div>
                                    </td>
                               <%-- </tr>

                                <tr>--%>
                                   
                                </tr>

                              

                                <tr>
                                     <td>
                                        <label class="input-form-label" style="">Blood group</label>
                                    </td>   
                                    
                                        
                                    <td>
                                        <div class="input-group" style=";">
                                          <%--  <input id="txtTemp" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Temperature" value="0">--%>
                                             <input type="text" id="txtBloodGrp" class="form-control input-form-control" placeholder="Blood group"/>         

                                        </div>
                                    </td>
                               <%-- </tr>

                                <tr>--%>
                                    <td>
                                        <label class="input-form-label" >Mother's</label>
                                    </td>
                                 
                  
                                    <td>
                                        <div class="input-group" style="">
                                          <%--  <input id="txtPulse" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Pulse">--%>
                                              <input type="text" id="txtMBloodGrp" class="form-control input-form-control" style="" placeholder="Mother's Group"/>
                                        </div>
                                    </td>
               </tr><tr>
                                    <td>
                                        <label class="input-form-label" style="">Apgar</label>
                                    </td>                                 
                                    <td>
                                        <div class="input-group" style="">
                                           <%-- <input id="txtResp" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Respiratory" style="width:100%;">
                                       --%>
                                              <span>1 min. <input type="text" id="txtOneMin" class="" style="width: 30PX;text-align:center" maxlength="2" />/10 </span>
               <span style="margin-left: 14PX"> 5 min. <input type="text" id="txtFiveMin" class="" style="width: 30PX;text-align:center" maxlength="2" />/10</span>
                                             </div>
                                    </td>
                               <%-- </tr>
                                 
                                <tr>--%>
                                    <td>
                                        <label class="input-form-label" style="">EDD</label>
                                    </td>
                                     
                                                
                                    <td>
                                        <div class="input-group" style="">
                                           <%-- <input id="txtSPO2" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="SPO2" style="width:100%;">--%>
                                         <input type="text" id="txtEDD" class="form-control input-form-control" style="" placeholder="EDD" />    
                                        </div>
                                    </td>
                             <%--   </tr>
                                 
                                  <tr>--%>
                   </tr><tr>
                                   
                       
                   
                                    <td style="">
                                        <label class="input-form-label" style="padding-left:0px !important;">Inj. Vit-K 1.0 mg</label>
                                    </td>
                                    <td>
                                       
                                        <div class="input-group" style="width:100%">
                                            <%--<input id="txtBMI" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="BMI" readonly="">
                                            <span class="input-group-addon input-form-addon">kg/(m²)</span>--%>
                                             <input type="radio" name="rbtnInj" id="rbtnGiven" value="Y" style="margin-left:4%"><label style="vertical-align:middle">Given</label>
                  
                        <input type="radio" name="rbtnInj" id="rbtnNGiven" style="margin-left:14%" value="N" checked ><label style="vertical-align:middle">Not Given</label>
                                        </div>
                                    </td>

                                

                                </tr>
                             

                               
                         
                   
                            </tbody>
                        </table>
                
                         </div></div>
               
               </div>

          </div>
 <%--   -----------------------------------------%>


 <%-- <div class="row" >
               
                  
                <div class="col-md-4 col-xs-4 col-sm-4">
                    <label class="" for="">Date of birth </label>
                    <input type="text" id="txtDOB" class=" input-sm" readonly="readonly"/>
                </div>
                 
                <div class="col-md-4 col-xs-4 col-sm-4">
                     <label class="" for="">Time</label>
                    <input type="text" id="txtTime" class=" input-sm" style="margin-left:16%"/>
                </div>
                
                <div class="col-md-4 col-xs-4 col-sm-4">
                     <label class="" for="">Birth weight </label>
                    <input type="text" id="txtweight" class=" input-sm" />

                </div>

            </div>--%>
           <%-- <div class="row" >
              

              

                 
                <div class="col-md-4">
                     <label class="" for="">Birth history</label>
                    <%=Html.DropDownListFor(x => Model.BirthHistory, new SelectList(Model.BirthHistoryList, "Value", "Text"), "---Select---", new { id="cmbBirthHistorySel",style="width:64%;height: 28px !important;",maxlength="6",@class="input-sm"})%>
                      
                </div>
              
                <div class="col-md-4">
                    <label class="" for="">Blood group</label>
                    <input type="text" id="txtBloodGrp" class=" input-sm" />
                </div>
                 
                <div class="col-md-4">
                    <label class="" for="">Mother's</label>
                    <input type="text" id="txtMBloodGrp" class=" input-sm" style="margin-left:8%"/>
                </div>
            </div>--%>
         <%--    <div class="row" >--%>
               

              
               
               <%-- <div class="col-md-4">
                     <label class=" " for="">Apgar</label>
                1 min. <input type="text" id="txtOneMin" class=" input-sm" style="width:20%" maxlength="2" />/10 
                5 min. <input type="text" id="txtFiveMin" class="input-sm" style="width:20%" maxlength="2" />/10
                        <input type="radio" name="rbtnApgar" id="rbtn1min">1 min. /10
                  
                        <input type="radio" name="rbtnApgar" id="rbtn5min">5 min. /10-
                  

     </div>
               
                <div class="col-md-4">
                     <label class="" for="">EDD</label>
                    <input type="text" id="txtEDD" class="input-sm" style="margin-left: 17%;" />
                </div>
                     --%>
              <%--  <div class="col-md-4">
                         <label class="" for="">Inj. Vit-K 1.0 mg</label>
                        <input type="radio" name="rbtnInj" id="rbtnGiven" value="Y" style="margin-left:4%"><label style="vertical-align:middle">Given</label>
                  
                        <input type="radio" name="rbtnInj" id="rbtnNGiven" style="margin-left:4%" value="N" checked ><label style="vertical-align:middle">Not Given</label>
                   
                </div>--%>


           <%-- </div>--%>
           

             
   
           <div class="row" style="margin-right: 8px !important;margin-left: -1px !important;">
                <div style="font-size:14px;margin-bottom: -2px;" class="panel-heading divHeads">
                          Vaccination Schedule</div>
               <table id="tblVaccination">

               </table>
           </div>
          <div class="row" style="margin-top:5px;margin-left: -22px !important;">
             <label   id="btnSaveVaccines" style="background-color: transparent; float: right;   border-color: transparent;" title="Save"><!--kavita margin-Right 25px to 25% -->
                      <img src="../Images/check-round.png"  style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; ">
                 </label>

         </div>
    <%--    </div>--%>
    </div>
                 </div>
    </div>
            </body>
        </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
           .content {
                   widt :80%;
                  
               }
        .row{
             margin-right: -7px !important;
    margin-left: -15px !important;
        }
       
        label{
            font-size:12px;
        }
        .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
    background: #fffdc8;
    border: 1px solid #D3D3D3;
    line-height: 15px;
    font-weight:normal;
    color: #272323;
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
}
.ui-button{
             background: #ffffff !important;
        }
        .ui-datepicker td .ui-state-default{
            background:#005382 !important;
            color: #ffffff !important;
        }
      
         .jqgrid-rownum{
               background: #42525b;
         }

        @media only screen and (max-width : 1024px) {
            #txtDOB{
                width:55%;
            }
            #txtTime{
                width:47%;margin-left: 24% !important;
            }
              #txtweight{
                width:55%;
            }
                #cmbBirthHistorySel{
                width:55% !important;
            }
                  #txtBloodGrp{
                width:55%;
            }
                    #txtMBloodGrp{
                width:55%;
                margin-left:11% !important;
            }
                      #txtEDD{
                          margin-left:26% !important;
                width:55%;
            }

        }
        .panel {
            margin-bottom: 13px;
        }
        .container {
     padding-right: 0px; 
     padding-left: 0px; 
    margin-right: auto;
    margin-left: auto;
}

            /*vijeta 3/5/19*/
        table:not(#tblVitals) {
            width: 100%;
        }

        .switch {
            position: relative;
            display: block;
            vertical-align: top;
            width: 60px;
            height: 21px;
            padding: 3px;
            /*margin: 0 10px 10px 0;*/
            /*background: linear-gradient(to bottom, #eeeeee, #FFFFFF 25px);
  background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF 25px);*/
            border-radius: 18px;
            /*box-shadow: inset 0 -1px white, inset 0 1px 1px rgba(0, 0, 0, 0.05);*/
            cursor: pointer;
        }

        .switch-input {
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
        }

        .switch-label {
            position: relative;
            display: block;
            height: inherit;
            font-size: 10px;
            text-transform: uppercase;
            background: #eceeef;
            border-radius: inherit;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.12), inset 0 0 2px rgba(0, 0, 0, 0.15);
        }

            .switch-label:before, .switch-label:after {
                position: absolute;
                top: 50%;
                margin-top: -.5em;
                line-height: 1;
                -webkit-transition: inherit;
                -moz-transition: inherit;
                -o-transition: inherit;
                transition: inherit;
            }

            .switch-label:before {
                content: attr(data-off);
                right: 11px;
                color: #aaaaaa;
                text-shadow: 0 1px rgba(255, 255, 255, 0.5);
            }

            .switch-label:after {
                content: attr(data-on);
                left: 11px;
                color: #FFFFFF;
                text-shadow: 0 1px rgba(0, 0, 0, 0.2);
                opacity: 0;
            }

        /*.switch-input:checked ~ .switch-label {
        ackground: #0088cc;
            /*box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15 ,rgba(0, , 0, 0.2)*/
        }*/

            .switch-input:checked ~ .switch-label:before {
                opacity: 0;
            }

            .switch-input:checked ~ .switch-label:after {
                opacity: 1;
            }

        .switch-handle {
            position: absolute;
            top: 4px;
            left: 4px;
            width: 20px;
            height: 20px;
            background: linear-gradient(to bottom, #FFFFFF 40%, #f0f0f0);
            /*background-image: -webkit-linear-gradient(top, #FFFFFF 40%, #f0f0f0);*/
            border-radius: 100%;
            /*box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);*/
        }

            .switch-handle:before {
                content: "";
                position: absolute;
                top: 50%;
                left: 50%;
                margin: -6px 0 0 -6px;
                width: 12px;
                height: 12px;
                background: linear-gradient(to bottom, #eeeeee, #FFFFFF);
                background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF);
                border-radius: 6px;
                box-shadow: inset 0 1px rgba(0, 0, 0, 0.02);
            }

        .switch-input:checked ~ .switch-handle {
            left: 38px;
            box-shadow: -1px 1px 5px rgba(0, 0, 0, 0.2);
        }

        /* Transition
========================== */
        .switch-label, .switch-handle {
            transition: All 0.3s ease;
            -webkit-transition: All 0.3s ease;
            -moz-transition: All 0.3s ease;
            -o-transition: All 0.3s ease;
        }

        .input-form-control {
            height: 24px !important;
        }

        .input-form-addon {
            height: 24.6px;
            padding: 5px 12px !important;
            font-size: 11px !important;
        }

        .input-form-label {
            /*padding-left: 40px !important;*/
            font-size: 13px !important;
        }

              Label {
            margin-left: 5px;
        }
               
      .input-group-addon
      {
          width:50px;
      }


      
       .panel-body {
            width:auto !important;
            height:auto !important;
        }
        .panel-heading {
            padding: 2px 5px;
        }
        .divHeads {
    color: #f4f4f4;
    background-color: #3c8dbc;
    border-color: #ddd;
    box-shadow: none;
    font-size: 12px;
    text-align: center;
    font-weight: bold;
}
        
   .btn-default:active:hover, .btn-default.active:hover {
           color: #fff;
    background-color: #31b0d5;
    border-color: #269abc;
        }

        .btn-default:active,
        .btn-default.active,
        .open > .dropdown-toggle.btn-default {
          color: #fff;
    background-color: #31b0d5;
    border-color: #269abc;
        }

        .borderC{

            width: 30%;
    height: 25px;
    padding-top: 2px;
    padding-left: 0px;
        }
        #cmbBirthHistorySel{
            height: 28px !important;}
    </style>

    <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    <script src="../plugins/timeEntry/jquery.timeentry.js"></script>
     <script src="../Scripts/Doctorlist.js"></script>
      <link href="../css/timedropper.css" rel="stylesheet" />
    <script src="../js/timedropper.js"></script>

    <script type="text/javascript">
        var userId = ('<%: Session["gOncoUserId"]%>').toString().trim();
        var lastRow;
        var lastCell;
        var doctCode = $.session.get('DoctCode');
        var doctName = $.session.get('DoctName');
        var pathFrom = '';
        var ChangeAnyData = false;
        var ChangeGrid = false;
        $(document).ready(function (e) {
            
            SetPatientDtl();
            if ($.session.get('PatDOB') != null) {
                $("#txtDOB").val($.session.get('PatDOB'));
            }
            
            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";

            }
            //$("#txtTime").timeEntry({
            //    show24Hours: false, // True to use 24 hour time, false for 12 hour (AM/PM)             
            //    separator: ':', // The separator between time fields      
            //    ampmPrefix: ' ', // The separator before the AM/PM text      
            //    ampmNames: ['AM', 'PM'], // Names of morning/evening markers
            //    showSeconds: false,
            //    defaultTime: null,
            //});
          pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');

            if (pathFrom != "") {
                var doctCd = ('<%:Session["gDoctCode"]%>').toString();
                SearchFunction(doctCd);
                $("#DoctorInput").css("display", "none");
                var menuL = document.getElementById('menuList');
                menuL.style.display = "none";
                //
                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
                $("#divForBack").show();
                $("#iformenubar").hide();
                // $("#menuBar").css("margin-top", "11px");
                $("#menuBar").hide();
                $("#anchrSignOut").css("margin-left", "22px");
                $("#anchrSignOut").css("font-size", "13px");
                //end
            }
            else {
                $("#DoctorInput").val(doctName);
                $("#divForBack").hide();
                $("#iformenubar").show();
                $("#menuBar").show();
                $("#menuBar").css("margin-top", "0px");
                $("#anchrSignOut").css("margin-left", "0px");
                $("#anchrSignOut").css("font-size", "10px");

            }
          
            BindGrid();
            BindGridData("");
            $("#btnSaveVaccines").click(function () {
                SaveVaccines("N");
            });
            $("#txtOneMin,#txtFiveMin").keypress(function (e) {
                //if the letter is not digit then display error and don't type anything
                var charCode = (e.which) ? e.which : e.keyCode;
                if (charCode != 46 && charCode > 31
                  && (charCode < 48 || charCode > 57)) {
                    //display error message
                    return false;
                }
            });
            $("#txtweight").on("keyup", function () {
                var regexp = /^\d{0,2}(\.\d{0,1})?$/;
                if (regexp.test($("#txtweight").val()) == false) {
                    var s = $("#txtweight").val();
                    $("#txtweight").val(s.substring(0, s.length - 1));
                 
                }
            });

            jQuery("#tblVaccination").change(function (e) {// 19-12-19
                ChangeGrid = false;
                var arr = $("#tblVaccination").jqGrid("getCol", "CREATEDON");

                $.each(arr, function (index, value) {
                    if (value != "" && value != null) {
                        ChangeGrid = true;
                        return false;
                    }
                });
            });
            $("input,select").change(function () {// 19-12-19


                if ($("#txtweight").val() != "" ||
                 $("#txtBloodGrp").val() != "" ||
                 $("#txtMBloodGrp").val() != "" ||
                 $("#txtEDD").val() != "" ||
                 $("#cmbBirthHistorySel").val() != "" ||
                 $("#txtOneMin").val() != "" ||
                 $("#txtFiveMin").val() != "") {

                    ChangeAnyData = true;
                }
                else {
                    ChangeAnyData = false;
                }
               


            });

            $("#txtTime").timeDropper({//
                meridians: true,
            });
            //$("#txtTime").val("");// 29-04-2020 // Commented by Murali on 29/07/2024
        });
        function SetpageDirctn() {// 19-12-19
            //var flag = 0;
            //var arr = $("#tblVaccination").jqGrid("getCol", "CREATEDON");
          
            //$.each(arr, function (index, value) {
            //    if (value != "" && value != null) {
            //        flag = 1;
            //        return false;
            //    }
            //});
            if (ChangeAnyData || ChangeGrid) {
                SaveVaccines("Y");
            }
            else {
                if (pathFrom == "") {
                    window.location.href = '../ClinicalNotes/ClinicEntry';
                } else
                    window.location.href = '../DoctorDesk/PatientEntry';
            }
        }
        function tConvert(time) {
            // Check correct time format and split into components
            time = time.toString().match(/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time];

            if (time.length > 1) { // If time format correct
                time = time.slice(1);  // Remove full string match value
                time[5] = +time[0] < 12 ? 'AM' : 'PM'; // Set AM/PM
                time[0] = +time[0] % 12 || 12; // Adjust hours
            }
            return time.join(''); // return adjusted time or original string
        }
        function BindGrid() {
         
            colnames = ['Age Code', 'Age', 'Vaccine Code', 'Vaccine', 'Due Date', 'Given Date', 'Remark', 'User Id','Created On','Created At','Due Date(Hidden)'];

           // arrtSetting = 
            var prevCellVal = { cellId: undefined, value: undefined };
            var dob = $.session.get('PatDOB');
            jQuery("#tblVaccination").jqGrid({
                datatype: 'local',
                colNames: colnames,
                colModel: [
                    { name: 'AGEGRPCD', index: 'AGEGRPCD', width: 120, align: "right", hidden:true},
                    {
                        name: 'AGEGROUP', index: 'AGEGROUP', width: 120, align: "left", cellattr: function (rowId, val, rawObject, cm, rdata) {
                            var result;
                            
                            if (prevCellVal.value == val) {
                                //result = ' style="display: none" rowspanid="' + prevCellVal.cellId + '"'; //Commented by Murali on 30/07/2024
                                // Added below condition by Murali on 30/07/2024 (Because with the above statement , agegroup is hiding.
                                //**********************************************************************************
                                if (result != undefined)
                                    result = ' style="display: none" rowspanid="' + prevCellVal.cellId + '"';
                                else
                                    result = ' rowspan="1" id="' + cellId + '"';
                                //**********************************************************************************
                            }
                            else {
                                var cellId = this.id + '_row_' + rowId + '_' + cm.name;

                                result = ' rowspan="1" id="' + cellId + '"';
                                prevCellVal = { cellId: cellId, value: val };
                            }

                            return result;
                        }
                    },
                    { name: 'VACCINECD', index: 'VACCINECD', width: 120, align: "right", hidden: true },
                    { name: 'VACCINENM', index: 'VACCINENM', width: 270, align: "left", },
                    {
                        name: 'DUEDATE', index: 'DUEDATE', width: 90, align: "right", readonly: false,
                        // Commented by Murali on 29/07/2024
                        //**********************************************************************************
                        editable: true,
                        editoptions: {
                            size: 20,
                            dataInit: function (el) {
                                var date = new Date();
                                var currentMonth = date.getMonth();
                                var currentDate = date.getDate();
                                var currentYear = date.getFullYear();
                                $(el).datepicker({
                                    yearRange: 'c-150:c+150',
                                    minDate: '-10y', //new Date(currentYear-10, currentMonth, currentDate),
                                    maxDate: '+10y', //new Date(currentYear + 10, currentMonth, currentDate),
                                    //minDate: new Date('2022-03-07'),
                                    //maxDate: new Date(),
                                    gotoCurrent: true,
                                    changeMonth: true,
                                    changeYear: true,
                                    dateFormat: "dd/mm/yy",
                                    //onSelect: function (dateText) {
                                    //    $('#tblFirstPhysical').saveCell(dtids, 1);
                                    //}
                                });
                            },
                        }
                      //*******************************************************************************************
                    },
                    {
                        name: 'GIVDATE', index: 'GIVDATE', width: 90, align: "right", editable: true,
                        editoptions: {
                            size: 20,
                            dataInit: function (el) {

                                var today = new Date();
                                var d = ((today.getMonth() + 1) < 10 ? '0' : '') + (today.getMonth() + 1) + "/" + (today.getDate() < 10 ? '0' : '') + today.getDate() + "/" + today.getFullYear();

                                //if (new Date(el.value.substr(3, 2) + "/" + el.value.substr(0, 2) + "/" + el.value.substr(6)) != new Date(d)) {
                                //    $.messager.alert("Information", "Date should be same.");
                                //    return false;

                                //}
                                var datenew = $(el).parent()[0].previousElementSibling.innerText;
                                var arry = datenew.split("/");
                                $(el).datepicker({
                                    dateFormat: 'dd/mm/yy', maxDate: new Date(), minDate: new Date(arry[1] + "/" + arry[0] + "/" + arry[2]), changeYear: true, changeMonth: true,
                                    onSelect: function (dates) {
                                        // ChangeAnyData = true;
                                        var rowid = el.parentElement.parentElement.id;
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'USERID', userId);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDON', '<%:ViewBag.CurrntDate%>');
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDAT', '<%:ViewBag.CurrntTime%>');
                                        // 19-12-19
                                        ChangeGrid = false;
                                        var arr = $("#tblVaccination").jqGrid("getCol", "CREATEDON");

                                        $.each(arr, function (index, value) {
                                            if (value != "" && value != null) {
                                                ChangeGrid = true;
                                                return false;
                                            }
                                        });
                                       //end
                                    }
                                  
                                })
                                $(el).bind("keyup", function (e) {
                                    //var charCode = (e.which) ? e.which : e.keyCode
                                    //if (charCode > 31 && (charCode < 48 || charCode > 57))
                                    //    return false;

                                    var rowid = el.parentElement.parentElement.id;
                                    //if (e.keyCode == 8 || e.keyCode == 46) {
                                    //    jQuery('#tblVaccination').jqGrid('setCell', rowid, 'USERID', null);
                                    //    $.messager.alert("Information", "Please enter or select correct date");
                                    //}
                                    if (el.value == "") {
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'USERID', null);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDON', null);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDAT', null);
                                        //$.messager.alert("Information", "Please enter or select correct date");
                                    }
                                    else if (!/^\d{2}\/\d{2}\/\d{4}$/.test(el.value)) {
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'USERID', null);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDON', null);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDAT', null);
                                        // $.messager.alert("Information", "Please enter or select correct date");
                                    }
                                    else if (new Date(el.value.substr(3, 2) + "/" + el.value.substr(0, 2) + "/" + el.value.substr(6)) > new Date(d)) {
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'USERID', null);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDON', null);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDAT', null);
                                        $.messager.alert("Information", "Date should be less than todays date.");
                                    }
                                    else {
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'USERID', userId);
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDON', '<%:ViewBag.CurrntDate%>');
                                        jQuery('#tblVaccination').jqGrid('setCell', rowid, 'CREATEDAT', '<%:ViewBag.CurrntTime%>');
                                    }
                                })
                            },
                        }
                       
                    },
                    { name: 'REMARK', index: 'REMARK', width: 150, align: "left", editable: true ,maxlength:200},
                    { name: 'USERID', index: 'USERID', width: 150, align: "left", readonly: true },
                    { name: 'CREATEDON', index: 'CREATEDON', width: 150, align: "left", readonly: true },
                    { name: 'CREATEDAT', index: 'CREATEDAT', width: 150, align: "left", readonly: true },
                     {name: 'HDUEDATE', index: 'HDUEDATE', width: 90, align: "right", readonly: true, hidden: true}
                   
                   
                ],
             
                shrinkToFit: false,
                forceFit: false,
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadonce: true, // to enable sorting on client side
             
                rownumbers: true,
                rowNum: 99999999,
               
                hidegrid: false,
                height: 460,
                ignoreCase: true,
               
                scrollerbar: true,
                loadtext: 'Loading...',
                gridComplete: function () {
                  //  $('#tblVaccination').jqGrid('setGridWidth', $('#secCont').width() - 20, false);
                  
                    var grid = this;

                    $('td[rowspan="1"]', grid).each(function () {
                        var spans = $('td[rowspanid="' + this.id + '"]', grid).length + 1;

                        if (spans > 1) {
                            $(this).attr('rowspan', spans);
                        }
                    });

                },
                afterSaveCell:function(rowid,cellname,value,irow,icol){
                    if (cellname == "GIVDATE") {
                        if (!/^\d{2}\/\d{2}\/\d{4}$/.test(value)) {
                            jQuery('#tblVaccination').jqGrid('setCell', rowid, 'GIVDATE', null);
                        }
                    }
                    if (cellname == "DUEDATE") {
                        if (!/^\d{2}\/\d{2}\/\d{4}$/.test(value)) {
                            jQuery('#tblVaccination').jqGrid('setCell', rowid, 'DUEDATE', value);
                        }
                    }
                },
                onCellSelect: function (rowid, iCol, cellcontent, e) {
                    lastRow = rowid;
                    lastCell = iCol;
                },
                loadComplete: function () {
                    if ($('#tblVaccination').jqGrid('getGridParam', 'reccount') == 0)
                        $(".jqgfirstrow").css("height", "1px");

                

                }
            }).trigger("reloadGrid");
            //$("#tblVaccination").jqGrid('filterToolbar', {
            //    searchOnEnter: false,
            //    searchOperators: false,
            //    defaultSearch: "cn"
            //});
            $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
            $('.ui-jqgrid-sdiv').addClass('AddFooterClass');
            var newWidth = $("#MainDiv").width();
            $("#tblVaccination").jqGrid("setGridWidth", newWidth - 9, false);
          //  $("#tblVaccination").jqGrid("setGridHeight", $("#MainDiv").height() - 215, true);
        }
        function BindGridData(temp) {
            $("#tblVaccination").clearGridData();
            
            $.ajax({
                async: false,
                url: '../Clinicalnotes/GetVaccinationData',
                data: { strMrNo: $.session.get('PatMRNO'), strDOB: $.session.get('PatDOB') },
                dataType: "json",
                success: function (response) {
                    if (response.length > 0) {

                        if (response[0] != "") {
                            if (temp == "") {
                                var res = JSON.parse(response[0]);

                                $("#txtTime").val(res[0].BIRTHTM.trim());
                                $("#txtweight").val(res[0].BIRTHWT.trim());
                                $("#cmbBirthHistorySel").val(res[0].BRTHHIST.trim());
                                $("#txtBloodGrp").val(res[0].BLDGRP.trim());
                                $("#txtMBloodGrp").val(res[0].MTHBLDGRP.trim());

                                $("#txtOneMin").val(res[0].APGAR1MIN.trim());
                                $("#txtFiveMin").val(res[0].APGAR5MIN.trim());
                                $("#txtEDD").val(res[0].EDD.trim());
                                if (res[0].VITKGIVEYN.trim() == "Y")

                                    $("#rbtnGiven").prop("checked", true);
                                else
                                    $("#rbtnNGiven").prop("checked", true);
                            }
                        } if (response[1].length > 0) {

                            $("#tblVaccination").jqGrid('setGridParam', { data: response[1] }).trigger("reloadGrid");
                        }

                    }
                    else {


                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });

        }

        function Validation() {

            
            var str = $.session.get('PatAge');
           
            var lastIndexOf = str.lastIndexOf('.');
            var numAge = str.substring(0, lastIndexOf);
            var TextAge = str.substring(lastIndexOf + 1);

            //var AgeinNum = age.split(".");
            var flagAge = 0;

            if (TextAge.toUpperCase() != "YRS") {
                if (Number(numAge) < 6) {
                    flagAge = 1;
                }
            }
            var i = 0;

            if (flagAge == 1) {
                if ($("#txtTime").val().toString().trim() == '') {
                    $("#txtTime").css("border-color", "red");
                    $("#txtTime").focus();
                    i = 1;
                } else {
                    $("#txtTime").css("border-color", "");
                }


                if ($("#txtweight").val().toString().trim() == '') {
                    $("#txtweight").css("border-color", "red");
                    $("#txtweight").focus();
                    i = 1;
                } else {
                    $("#txtweight").css("border-color", "");
                }
            }
            if ($("#cmbBirthHistorySel").val().toString().trim() == '') {
                    $("#cmbBirthHistorySel").css("border-color", "red");
                    $("#cmbBirthHistorySel").focus();
                    i = 1;
                } else {
                    $("#cmbBirthHistorySel").css("border-color", "");
                }
            
            if ($("#txtBloodGrp").val().toString().trim() == '') {
                $("#txtBloodGrp").css("border-color", "red");
                $("#txtBloodGrp").focus();
                i = 1;
            } else {
                $("#txtBloodGrp").css("border-color", "");
            }
         
           
            if ($("#txtMBloodGrp").val().toString().trim() == '') {
                $("#txtMBloodGrp").css("border-color", "red");
                $("#txtMBloodGrp").focus();
                i = 1;
            } else {
                $("#txtMBloodGrp").css("border-color", "");
            }        
            if (i == 1)
                return false;
            else
                return true;
        }

        function SaveVaccines(BackOrNot) {

            var status = Validation()
            if (status == true) {
                var mrNo = $.session.get('PatMRNO');
                var BirthTime = $("#txtTime").val();
                var BirthWeight = $("#txtweight").val();
                var BirthHistory = $("#cmbBirthHistorySel").val();
                var BloodGrp = $("#txtBloodGrp").val();
                var MotBloodGrp = $("#txtMBloodGrp").val();
                var ApgarOneMin = $("#txtOneMin").val();
                var ApgarFivMin = $("#txtFiveMin").val();
                var EDD = $("#txtEDD").val();
                var Vit_K = $('input[name=rbtnInj]:checked').val();
              
                $('#tblVaccination').jqGrid("saveCell", lastRow, lastCell);
                var GridData = $('#tblVaccination').jqGrid('getRowData');
                var selectedData = "";
               
                selectedData = jQuery.grep(GridData, function (n, i) {
                    //return n.GIVDATE.trim() != "" && n.USERID.trim() != ""; // Commented by Murali on 29/07/2024
                    return (n.GIVDATE.trim() != "" && n.USERID.trim() != "") || (n.DUEDATE != n.HDUEDATE); // Added Duedate Condition by Murali on 31/07/2024
                });

                if (selectedData.length > 0) {
                    $.ajax({
                        async: false,
                        type: "post",
                        datatype: "json",
                        url: '../Clinicalnotes/SaveVaccinationData11',
                       data: {strMRNO:mrNo, strTime: BirthTime, strWeight: BirthWeight, strHis: BirthHistory, strBloodGrp: BloodGrp, strMotBldGrp: MotBloodGrp, strApOne: ApgarOneMin, strApFiv: ApgarFivMin, strVitk: Vit_K, strEDD: EDD ,strData:JSON.stringify(selectedData)},
                      
                        success: function (response) {
                            if (response.toUpperCase().includes("SUCCESSFULLY")) {
                                BindGridData("");
                                $.messager.confirm('Information', 'Saved Successfully!', function (r) {
                                    if (BackOrNot == "Y") {
                                        if (pathFrom == "") {
                                            window.location.href = '../ClinicalNotes/ClinicEntry';
                                        } else
                                            window.location.href = '../DoctorDesk/PatientEntry';
                                    }
                                });
                            }
                            else {
                                //  $.messager.alert("Information", "Not Saved !");
                                $.messager.confirm('Information', 'Not Saved!', function (r) {
                                    if (BackOrNot == "Y") {
                                        if (pathFrom == "") {
                                            window.location.href = '../ClinicalNotes/ClinicEntry';
                                        } else
                                            window.location.href = '../DoctorDesk/PatientEntry';
                                    }
                                });

                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {

                        }
                    });
                } else {
                    $.messager.alert("Information", "Please enter or select given date / Due Date.");
                    return false;
                }
            } else {
                return false;
            }
        }


        function ClearAllData() {// 19-12-19
            $("#txtweight").val("");
            $("#txtBloodGrp").val("");
            $("#txtMBloodGrp").val("");
            $("#txtEDD").val("");
            $("#cmbBirthHistorySel").val("");
            $("#txtOneMin").val("");
            $("#txtFiveMin").val("");
            $("#rbtnNGiven").prop("checked", true);
            
            BindGrid();
           // BindGridData("Clear");


            


            var arr = $("#tblVaccination").jqGrid("getCol", "CREATEDON");

            $.each(arr, function (index, value) {
                jQuery('#tblVaccination').jqGrid('setCell', index+1, 'USERID', null);
                jQuery('#tblVaccination').jqGrid('setCell', index+1, 'GIVDATE', null);
                jQuery('#tblVaccination').jqGrid('setCell', index+1, 'REMARK', null);
                jQuery('#tblVaccination').jqGrid('setCell', index+1, 'CREATEDON', null);
                jQuery('#tblVaccination').jqGrid('setCell', index+1, 'CREATEDAT', null);
            });
            ChangeAnyData = false;
            ChangeGrid = false;
        }

    </script>
</asp:Content>
