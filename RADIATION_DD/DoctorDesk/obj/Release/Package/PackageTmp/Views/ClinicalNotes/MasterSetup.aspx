<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Clinicalnotes>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div id="MainDiv">
             <%-- ...............suamyya 10-12-19................................--%>
             <div style="float:right;">
            <a class="button1 button1-Addnew" id="myAdd11"  style="margin-bottom: 10px;margin-top: -10px;">
  <i class="fa fa-plus"></i>
  New
</a>
            </div>
            
            <div style="">
            <a class="button1 button1-green" id="divForBack"  style="margin-bottom: 10px;margin-top: -10px;" onclick="SetpageDirctn()">
  <i class="fa fa-arrow-left"></i>
  Back
</a>
            </div>
         <%--   .................................................--%>
              <div id="ContentHolderDiv" class="contentHoldClass" style="width:100%">
               <%--    <div class="InputWrapper">--%>
                <div style="width: 100%;margin-top: -5px;border: 1px solid #e5dada;" class="topdiv">

  
            <div class="StuckInput" style="margin-top: 8px;">
                <div class="col-md-12 col-sm-12">
                <label   id="myAdd" class="input-form-label" style=" margin-top: 3px; ">
                     
                    Name:
                 </label>
               <input type="text" id="MastersetupInput" style="height: 29px;border-radius: 5px;    -webkit-box-shadow: 0 8px 6px -6px black;    -moz-box-shadow: 0 8px 6px -6px black;    box-shadow: 0 7px 4px -6px rgb(181, 181, 181);margin-top: 2px;margin-left: 4%;display: -webkit-inline-box;" class="form-control input-form-control empty"><%----%> <%--onkeyup="SearchComplaint()"--%>
              <%-- <label id="myAdd1" style="background-color: transparent; float: right;margin-top: 3px; border-color: transparent;" title="Go to top"> 
                    </label>--%>
                   <%-- <input type="text" id="MastersetupInput" onkeyup="SearchComplaint()" style="height: 29px;border-radius: 5px;    -webkit-box-shadow: 0 8px 6px -6px black;    -moz-box-shadow: 0 8px 6px -6px black;    box-shadow: 0 7px 4px -6px rgb(181, 181, 181);margin-top: 2px;margin-left: 4%;" class="empty">
               --%>

                   
            </div><%----%> </div>
                <div class="StuckInput" style="margin-top: 44px;">
                    <div class="col-md-12 col-sm-12">
               
                       <div class="col-md-4 col-sm-12" style="padding-left: 0px;">
                           <label   id="Genderid" class="input-form-label" style=" margin-top: 9px;   margin-right: 2%; ">
                     
                    Gender:
                 </label>
                 
                          
        <%--<div class="btn-group Language" data-toggle="buttons" style="padding-top: 0px;width:60%;margin-left: 6%;">
            <label class="btn btn-default borderC" style="width:50%;height: 30px;">
                <input type="radio" name="genderNM" value="M" autocomplete="off" id="maleradio">
                Male
            </label>
            <label class="btn btn-default borderC" style="width:50%;height: 30px;">
                <input type="radio" name="genderNM" value="F" autocomplete="off" id="femaleradio">
                Female
            </label>
           
            
        </div>--%>
   <%---------------------------------------------%>
                            
                           <div class="btn-group Language" data-toggle="buttons" style="width:100%; margin-top: -15%;margin-left: 31%;" >
                                             <label class="btn btn-default borderC " style="width:25%">
                                                    <input type="radio" name="genderNM" value="M" autocomplete="off"  id="maleradio">
                                                     Male
                                             </label>
                                              <label class="btn btn-default borderC" style="width:35%">
                                                    <input type="radio" name="genderNM" value="F" autocomplete="off" id="femaleradio">
                                                     Female
                                             </label>
                                            <label class="btn btn-default borderC" style="width:25%">
                                                     <input type="radio" name="genderNM" value="B" autocomplete="off" id="bothradio">
                                                         Both
                                             </label>
                                           
                                        </div>
                          <%-- -----------------------------------------%>

                        </div>
                         
                         <div class="col-md-5 col-sm-12" style="margin-top:4px">
                              <label   id="ageF" class="input-form-label" style=" margin-top: 9px;  ">
                     
                                 Age:
                           </label>
                             <label   id="ageFrom" class="input-form-label" style=" margin-top: 3px; margin-left: 4%; ">
                      
                                 From
                           </label>
                           <%--  <input  type="number" oninput="maxLengthCheck(this)"  max="125" id="Agefromid"  style="width: 15%;height: 29px;border-radius: 5px;  -webkit-box-shadow: 0 8px 6px -6px black;    -moz-box-shadow: 0 8px 6px -6px black;    box-shadow: 0 7px 4px -6px rgb(181, 181, 181);margin-top: 2px;margin-left: 7px;" class="empty1">--%>

                             <input type="number" oninput="maxLengthCheck(this)"  max="125" id="Agefromid" style="width: 25%;height: 29px;border-radius: 5px;    -webkit-box-shadow: 0 8px 6px -6px black;    -moz-box-shadow: 0 8px 6px -6px black;    box-shadow: 0 7px 4px -6px rgb(181, 181, 181);margin-top: 2px;margin-left: 3%;display: -webkit-inline-box;" class="form-control input-form-control empty1"><%----%>
               
                             
                             <label   id="ageTo" class="input-form-label" style=" margin-top: 3px;  margin-left: 7px; ">

                                 To
                            </label>

                        <%--<input type="number" oninput="maxLengthCheck(this)" min="1" max="125"  id="Agetoid"   style="width: 15%;height: 29px;border-radius: 5px;   -webkit-box-shadow: 0 8px 6px -6px black;    -moz-box-shadow: 0 8px 6px -6px black;    box-shadow: 0 7px 4px -6px rgb(181, 181, 181);margin-top: 2px;margin-left: 7px;" class="empty1">--%>
 <input type="number" oninput="maxLengthCheck(this)"  max="125" id="Agetoid" style="width: 25%;height: 29px;border-radius: 5px;    -webkit-box-shadow: 0 8px 6px -6px black;    -moz-box-shadow: 0 8px 6px -6px black;    box-shadow: 0 7px 4px -6px rgb(181, 181, 181);margin-top: 2px;margin-left: 3%;display: -webkit-inline-box;" class="form-control input-form-control empty1"><%----%>
               
                        </div>
                          <div class="col-md-3 col-sm-12" style="margin-top:4px">

                              <label   id="ageFs" class="input-form-label" style=" margin-top: 9px;  ">
                      
                                 Status:
                           </label>
                              <select id="SelSystolic" style="width: 50%;height: 29px;margin-left: 7%;">
                                  <option value="A">Active</option>
                                    <option value="I">Inactive</option>
                                      </select>
                          </div>
                          <%-- </tr></table>--%>
               </div>
            </div><%----%> <br> <br>  <br>
                <%--   </div>--%>
                </div>
                <label id="btnSaveMasterSetup" style="background-color: transparent; float: right; margin-right: 25px; border-color: transparent;" title="Save">
                    <img src="../Images/check-round.png" style="z-index: 999;float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                </label>
                <br />
               <div id="wrapper" style="width: 100%">
                    <div class="tableDiv" style="" id="tbldiv">
                       
                     
                   </div>
                </div>


             
            </div>
        </div>
    </body>
    </html>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    <style>
        
     .topdiv{
            height:95px;
        }


      input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            /*font-size: 14px !important;*/ /*commented by vijeta on 22nd march 2018*/
            font-size: 16px !important; /*added by vijeta on 22nd march 2018*/
            text-decoration: inherit;
        }
    .input-form-label {
            padding-left: 5px !important;
            font-size: 13px !important;
        }

        

        a:hover {
            color: #555;
        }

        Label {
            margin-left: 5px;
        }

      
         /*added by vijeta on 22nd march 2018*/
        .empty {
             width: 85.5%;
            
        }
        .empty1{
           
            font-size: 14px;
        }

       
        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) { /*//4/23/19*/
            /*.empty {
                width: 80%;
            }*/
              .StuckInput{
                width:100% !important;
            }
              .empty{
                  width: 70% !important;
                 
                  margin-left: 9% !important;
              }
              .empty1{
                  width: 27% !important;
                 
              }
            
            input.empty {
                margin-left:8% !important;
            }

          
         .input-form-label {
                padding-left: 0px !important;
                    font-size: 13px !important;
                   margin-left: 0px;

            
                 }


            .col-sm-12,.col-sm-6 {
         position: relative;
    min-height: 1px;
    padding-right: 15px;
   padding-left: 0px !important;
}
     
            .topdiv{
            height:121px;
        }      
        }

        @media only screen and (min-device-width : 640px) and (max-device-width : 767px) {
            .empty {
                width: 85%;

            }
            .StuckInput{
                width:95% !important;
            }
        }
        @media only screen and (min-device-width : 1024px) and (max-device-width : 1200px) {
         .empty {
                width: 82%;
            }
        
        }


              .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 13px;/*//*/
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
         

            .panel-heading {
            padding: 2px 5px;
        }


               .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
            font-size: small; /*added by vijeta on 22nd sep 2018*/
        }
               .invsAddspan {
    float: right;
    margin-right: 6px;
    margin-top: -28px;
    position: relative;
    z-index: 2;
    color: #3d7da3;
    cursor: pointer;
}
        .btn-default:active:hover, .btn-defau
        lt.active:hover {
       color: #fff;
       color: #3cde67;
        
                
      }

        .btn-default :active,
        .btn-default.active,
        .open > .dropdown-toggle.btn-default {
            color: #fff;
            background-color: #3cde67;
            border-color: #adadad;
        }
         .borderC:first-child {
            border-radius: 16px 0px 0px 16px;
          
        }

        .borderC:last-child {
              border-radius: 0 16px 16px 0;
              
            }
          .ErrorClass {
            border-color: #a94442 !important;
            -webkit-box-shadow: inset 0 1px 1px rg
        ba(0, 0, 0, .075);
        
            x-shad ow:  i
             rgba(0, 0, 0, . 075);
    }

         /*added by vijeta20/6/19*/
          #tblMasterSetUplist{
              width:100%;
              border-collapse:collapse;
             margin-bottom:20%;
         }
        #tblMasterSetUplist td{
            border : 1px solid gray;
            text-align:center;
        }
       
            .tblMasterSetUpTrCls{
                color:#3c8dbc;box-shadow:0px 3px 30px -3px;
            }
            .inactiveSetUp
            {
                  color:red;
            }


         .ui-autocomplete { max-height: 200px;
              overflow-y: auto; 
              overflow-x: hidden;cursor: default;z-index:9999999999 !important;} 

          .tsStatus {
            width: 13px;
            height: 13px;
            float: left;
          
            border: 1px solid #313131;
            margin-left: 10px;
            /*margin-top: -5px;*/
            /*margin: 3px 3px 3px 5px;*/
        }


          
    </style>
     <script type="text/javascript">
         //added vijeta 12/6/19
         var RemarkArray = "<%:ViewData["RemarkArray"] as System.Collections.Generic.List<object>%>";
         <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
         var RemarkArray = '<%:Html.Raw(Samp.Serialize(ViewBag.RemarkArray))%>';
         var RouteArray = '<%:Html.Raw(Samp.Serialize(ViewBag.RouteArray))%>';
         var SetUpCode = "";
         var ItakesArray = [];//
         var SetupNoFrMedTaper = 0;
         var CommonFlag = 0;
         var FreqMainCompList = "";
         var FregqentMaterial = "";
         var FregqentCIMS = "";
         var FregqentDiagno = "";
         var FregqentInvest = "";
         var FregqentAdvice = "";


         var NonFreqMainCompList = "";
         var NonFregqentMaterial = "";
         var NonFregqentMaterialCIMS = "";
         var NonFregqentDiagno = "";
         var NonFregqentInvest = "";
         var NonFregqentAdvice = "";
         //------------------
         var dataal = ["GetMainCompList", "GetMainDiagnoList", "GetInvestigationList", "GetPatAdvList"];
         var RxListDiv = "";

         var mscimsYN = '';
         mscimsYN = '<%:Session["CIMYN"]%>';

         if (mscimsYN == "Y") {
             dataal.push("GetFregqentMaterialCIMS")
             RxListDiv = "GetFregqentMaterialCIMS";
         } else {
             dataal.push("GetFregqentMaterial")
             RxListDiv = "GetFregqentMaterial";
         }
         var CommonForRemark = [];

         var DoseMandatoryYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DoseMandatoryYN")%>';
       
         var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
         $(document).ready(function (e) {

             CommonForRemark = JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
             if ($(window).width() >= 996) {
                 //screen width size comparion

                 var menuL = document.getElementById('menuList');
                 menuL.style.display = "block";
                 $("#DoctorInput").hide();
                 $("#tblMasterSetUplist").show();
                 $("#labelForInactive").show();
                 
                 var dispLst = document.getElementById('sideList');
                 dispLst.style.display = "block";

             }
             var pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');//

             if (pathFrom != "") {//
                 $("#DoctorInput").css("display", "none");
                 var rightSideMenuLst = document.getElementById('sideList');
                 rightSideMenuLst.style.display = "none";
                 //end
             }

            // GetAllMasterSetup();
             AddAllMasterSetUp();
             CreatePersonalizedList();//added 20/6/19
             $(document).on('click', '.ExColicon', function (e) {

                 $(this).closest('tr').find('span.spanCls').toggleClass('fa fa-caret-down fa fa-caret-right');
                 if ($(this).context.offsetParent.parentElement.nextElementSibling.style.display == "block")
                     $(this).context.offsetParent.parentElement.nextElementSibling.style.display = "none";
                 else
                     $(this).context.offsetParent.parentElement.nextElementSibling.style.display = "block";
             });//4/2/19
             $(document.body).on('click', '.medInfoSpan', function (e) {
                 HoldOn.open();
                 var refCode = "";

                 if ($(this).hasClass('FromGrid')) {

                     refCode = $("#tblGrid").jqGrid('getCell', $(this).parent().parent()[0].id, 'CODE');
                 }
                 else {
                     refCode = $(this).parents('td').siblings('.tdDrugCode')[0].innerText;
                 }




                 $.ajax({
                     url: '../DoctorDesk/GetMonographInfo',
                     data: { refCode: refCode },
                     type: 'Get',
                     cache: false,
                     contentType: 'application/html; charset=utf-8',
                     datatype: 'html',
                     success: function (response) {
                         if (response != "") {
                             //var d = window.open('', '', '"<%=Server.MapPath("~/")%>"');
                             var d = window.open();
                             d.document.open()
                             d.document.write(response)
                             d.document.close()
                             //if (!$("#MonographMaterail").dialog("isOpen")) {
                             //    $("#MonographMaterail").dialog("open");
                             //} else {
                             //    $("#MonographMaterail").dialog("close");
                             //}
                             //$("#MonographMaterail").html(response);              
                         }
                         HoldOn.close();
                     },
                     error: function (XMLHttpRequest, textStatus, errorThrown) {
                         HoldOn.close();
                         $.messager.alert("Error", errorThrown);
                     }
                 });
             });

             $("#btnSaveMasterSetup").click(function () {
                 SaveAllMasterSetUp("N");
             });
             $("#myAdd").click(function () {

                 $.confirm({
                     title: '',
                     content: '' +
                     '<form action="" class="formName" style="height:60px">' +
                     '<div class="form-group">' +
                   //  
                   '<label>Master SetUp</label>' +
                   '<input  type="varchar" id="txtMasterSetup" maxlength="50" placeholder="Master SetUp" autofocus="autofocus" class="complaint form-control" required />' +//length by kavita

                     '</form>',
                     buttons: {
                         formSubmit: {
                             text: 'Save',
                             btnClass: 'btn-blue',
                             action: function () {
                                 var patadv = this.$content.find('.complaint').val();
                                 var grpCode = "";
                                 if (patadv == "") {
                                     $.alert('Enter Patient Advice'); //
                                     return false;
                                 }
                                 if (patadv != "") {
                                     $.ajax({
                                         type: "post",
                                         datatype: "json",
                                         url: 'AddPatAdvice', //
                                         data: { strPatAdv: patadv },
                                         success: function (response) {
                                             //if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                             //    $("#txtMasterSetup").val("");
                                             //    $.messager.alert("Information", response);
                                             //    SavePatientAdvice("Y");
                                             //    AddPatAdvice();
                                             //}
                                             //else {

                                             //    var jc = this;
                                             //    jc.$$formSubmit.trigger('click');
                                             //    $.messager.alert("Information", "This Diagnosis is already Present."); //

                                             //}
                                             if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                                                 $.messager.alert("Information", "Record Not Inserted.");
                                             }
                                             else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                                 var jc = this;
                                                 //jc.$formSubmit.trigger('click');
                                                 $.messager.alert("Information", "This Advice is already Present.");
                                             }
                                             else {
                                                 $("#txtMasterSetup").val("");
                                                 //$.messager.alert("Information", response);
                                                 $.messager.alert("Information", "Record inserted successfully");
                                                 SavePatientAdvice("Y");
                                                 AddPatAdvice();
                                                 newlyAddedAdvice = response;//added on 19th sep 2018
                                             }
                                         },

                                     });
                                 }

                             }
                         },
                         cancel: function () {
                             //close
                             //$('.FoodItems input:checked').focus();
                         },
                     },
                     onContentReady: function () {
                         $('#txtMasterSetup').focus();
                         // bind to events
                         var jc = this;
                         this.$content.find('form').on('submit', function (e) {
                             // if the user submits the form by pressing enter in the field.
                             e.preventDefault();
                             jc.$$formSubmit.trigger('click'); // reference the button and click it
                         });
                     }
                 });
             });
             $("#myAdd11").click(function () {

                ClearFormControls();

             });


             //..................................
             (function ($) {
                 $.fn.extend({
                     donetyping: function (callback, timeout) {
                         timeout = timeout || 1e3; // 1 second default timeout
                         var timeoutReference,
                             doneTyping = function (el) {
                                 if (!timeoutReference) return;
                                 timeoutReference = null;
                                 callback.call(el);
                             };
                         return this.each(function (i, el) {
                             var $el = $(el);
                             // Chrome Fix (Use keyup over keypress to detect backspace)
                             // thank you @palerdot
                             $el.is(':input') && $el.on('keyup keypress paste', function (e) {
                                 // This catches the backspace button in chrome, but also prevents
                                 // the event from triggering too preemptively. Without this line,
                                 // using tab/shift+tab will make the focused element fire the callback.
                                 if (e.type == 'keyup' && e.keyCode != 8) {

                                     if ($(this).val() != "")//vijeta 3/5/19
                                         return;
                                 }

                                 // Check if timeout has been set. If it has, "reset" the clock and
                                 // start over again.
                                 if (timeoutReference) clearTimeout(timeoutReference);
                                 timeoutReference = setTimeout(function () {
                                     // if we made it here, our timeout has elapsed. Fire the
                                     // callback
                                     doneTyping(el);
                                 }, timeout);
                             }).on('blur', function () {
                                 // If we can, fire the event since we're leaving the field
                                 doneTyping(el);
                             });
                         });
                     }
                 });
             })(jQuery);

             $('.searchCheckBoxCls').donetyping(function () {
                 var id1 = $(this)[0].id;


                

               
                 if (id1.indexOf("GetMainCompList") != -1) {
                     SearchServiceGroup("GetMainCompList");
                 } else if (id1.indexOf("GetMainDiagnoList") != -1) {
                     SearchServiceGroup("GetMainDiagnoList")
                 }  else if (id1.indexOf("GetFregqentMaterialCIMS") != -1) {
                     SearchServiceGroup("GetFregqentMaterialCIMS")
                 } else if (id1.indexOf("GetFregqentMaterial") != -1) {
                     SearchServiceGroup("GetFregqentMaterial")
                 } else if (id1.indexOf("GetInvestigationList") != -1) {
                     SearchServiceGroup("GetInvestigationList")
                 } else if (id1.indexOf("GetPatAdvList") != -1) {
                     SearchServiceGroup("GetPatAdvList")
                 } 
                // SearchComplaint();
                 //$("#tblMtrlNewSearch").hide();//vijeta 1/7/19
             });

             //.................................



             $("#btnInteraction1").click(function (e) {//
                 //if (!$("#MonographMaterail").dialog("isOpen")) {
                 //    $("#MonographMaterail").dialog("open");
                 //} else {
                 //    $("#MonographMaterail").dialog("close");
                 //}
                 //$("#MonographMaterail").empty();

                 //$("#MonographMaterail").html(medicineInterStr);
                 GetMaterialInteraction("SetUp");
                 var frog = window.open();
                 frog.document.open()
                 frog.document.write(medicineInterStr)
                 frog.document.close()
             });

             
         });
         function SetpageDirctn() {
             //'#divGetMainCompList li input,#divGetMainDiagnoList li input,#divGetInvestigationList li input,#divGetPatAdvList li input', function (e
             var flag = 0;
             if ($("#divGetMainCompList input[type='checkbox']:checked").length != 0 || $("#divGetMainDiagnoList input[type='checkbox']:checked").length != 0 || $("#divGetInvestigationList input[type='checkbox']:checked").length != 0
                 || $("#divGetFregqentMaterial input[type='checkbox']:checked").length != 0 || $("#divGetPatAdvList input[type='checkbox']:checked").length != 0
                 || $("#divGetFregqentMaterialCIMS input[type='checkbox']:checked").length != 0 || ($("#MastersetupInput").val() != "" && $("#MastersetupInput").val() != null)) {
                 flag = 1;
             }


             if (flag == 1)
                 SaveAllMasterSetUp("Y");
             else
                 window.location.href = '../DoctorDesk/PatientEntry';
         }
         function ClearAllCheckd(datacheck) {
             $('#div' + datacheck).find("input[type=checkbox]:checked").prop('checked', false);
         }
         function SaveAllMasterSetUp(BackOrNot) {
             //AgeCalc();

             var flag = 0;

             if ($("#MastersetupInput").val() == '') {
                 $("#MastersetupInput").addClass('ErrorClass');
                 flag = 1;
             } else {
                 $("#MastersetupInput").removeClass('ErrorClass');
             }
             if (($("#femaleradio").prop("checked") == false) && ($("#maleradio").prop("checked") == false) && ($("#bothradio").prop("checked") == false)) {

                 //alert("Please Select the Gender..");
                 $(".borderC").addClass('ErrorClass');

                 //return false;
                 flag = 1;
             } else {
                 $(".borderC").removeClass("ErrorClass");
             }

             if ($("#Agetoid").val() == '' || $("#Agefromid").val() == '') {
                 // alert("Please Enter the Age..");
                 if ($("#Agetoid").val() == '') { $("#Agetoid").addClass('ErrorClass'); } else $("#Agetoid").removeClass('ErrorClass');
                 if ($("#Agefromid").val() == '') { $("#Agefromid").addClass('ErrorClass'); } else $("#Agefromid").removeClass('ErrorClass');

                 // return false;
                 flag = 1;
             } else {
                 $("#Agetoid").removeClass('ErrorClass');
                 $("#Agefromid").removeClass('ErrorClass');

                 if ((Number($("#Agetoid").val()) < Number($("#Agefromid").val()))) {
                     // alert("not allowd");
                     $.alert('Age To must be greater than Age From'); //
                     $("#Agefromid").val('');
                     $("#Agetoid").val('');
                     $("#Agefromid").addClass('ErrorClass');
                     $("#Agetoid").addClass('ErrorClass');
                     // return false;
                     flag = 1;
                 }
             }

             if (flag == 1)
                 return false;


             var strComplaints = '', strInvestigtn = '', strRxdata = '', strDiagnosis = '', strPatadv = '';
             var strComplaintsTitle = '', strDiagnosisTitle = '', strRxdataTitle = '', strInvestigtnTitle = '', strPatadvTitle = '';
             var SaveArray = [];

             for (i = 0; i < dataal.length; i++) {
                 var chlBoxValLst = [];
                 var strArry = '';
                 $('#div' + dataal[i] + ' input:checkbox:checked').each(function () {
                     chlBoxValLst.push($(this).attr('value'));
                 });
                 strArry = chlBoxValLst.join(",");
                 if (dataal[i] == "GetMainCompList") { strComplaints = strArry; }
                 if (dataal[i] == "GetMainDiagnoList") { strDiagnosis = strArry; }
                 else if (dataal[i] == "GetFregqentMaterial" || dataal[i]=="GetFregqentMaterialCIMS") {
                     strRxdata = strArry;
                     var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                     myDataWithIds = $.map(ids, function (index, key) {
                        // $('#tblGrid').jqGrid("editCell", 0, 0, false);
                         DRUGNM = $("#tblGrid").jqGrid('getCell', index, 'NAME').replace('<span class="fa fa-info-circle fa-1x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf"></span>', "").toString().trim();
                         if ($("#tblGrid").jqGrid('getCell', index, 'DAYS') != "--select--")
                             DAYS = $("#tblGrid").jqGrid('getCell', index, 'DAYS');
                         else
                             DAYS = '';//3/30/19
                         DRUGCD = $("#tblGrid").jqGrid('getCell', index, 'CODE');
                         if ($("#tblGrid").jqGrid('getCell', index, 'DURATION') != "--select--")//3/30/19
                             DURATION = $("#tblGrid").jqGrid('getCell', index, 'DURATION');
                         else
                             DURATION = '';
                         if ($("#tblGrid").jqGrid('getCell', index, 'FOOD') != "--select--")//3/30/19
                             ABFOOD = $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "B" ? "E" : $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "A" ? "A" : "";
                         else
                             ABFOOD = '';
                         if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")//3/30/19
                             INTAKEDESC = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                         else
                             INTAKEDESC = '';
                         if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")//3/30/19

                             INTAKECD = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                         else
                             INTAKECD = '';
                         SOSYN = $("#tblGrid").jqGrid('getCell', index, 'DURATION').substring(0, 1) == "S" ? "Y" : "N";
                         GENERICID = $("#tblGrid").jqGrid('getCell', index, 'GENERICID');
                         GENERICNAM = $("#tblGrid").jqGrid('getCell', index, 'GENERICNAM');
                         DOSSAGE = $("#tblGrid").jqGrid('getCell', index, 'DOSAGE');
                         ROUTE = $("#tblGrid").jqGrid('getCell', index, 'ROUTE');
                         REMARKS = $("#tblGrid").jqGrid('getCell', index, 'REMARK');
                         DRUGFORM = $("#tblGrid").jqGrid('getCell', index, 'DRUGFORM');//

                         if (DURATION == "STAT")//added on 4th sep 2018
                             DURATION = "T";

                         return { DRUGNM: DRUGNM, DOSSAGE: DOSSAGE, DAYS: DAYS, Remarks: REMARKS, ROUTE: ROUTE, GENERICID: GENERICID, GENERICNAME: GENERICNAM, DRUGCD: DRUGCD, DRUGFORM: DRUGFORM, SOSYN: SOSYN, DURATION: DURATION, ABFOOD: ABFOOD, INTAKEDESC: INTAKEDESC, INTAKECD: "" };
                     });

                     var servData = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC == "" || e.INTAKEDESC == "--select--") });
                     var servicedt = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC != "" || e.INTAKEDESC != "--select--") });
                     var servDossage = $.grep(myDataWithIds, function (e) { return (e.DOSSAGE == "" || e.DOSSAGE == null) });//
                     var servRoute = $.grep(myDataWithIds, function (e) { return (e.ROUTE == "" || e.ROUTE == null) });//
                     var servDrugForm = $.grep(myDataWithIds, function (e) { return (e.DRUGFORM == "" || e.DRUGFORM == null) });//
                     var ServiceData = (JSON.stringify(servicedt));

                     if (servData.length > 0) {
                         $.alert('Please select frequency for all medicines.');
                         return false;
                     }
                     if (servDossage.length > 0) {
                         if (DoseMandatoryYN == "Y") {
                             $.alert('Please select Dossage for all medicines');
                             return false;
                         }
                     }//
                     if (servRoute.length > 0) {
                         $.alert('Please select Route for all medicines');
                         return false;
                     }//
                     if (servDrugForm.length > 0) {
                         $.alert('Please select Drug Form for all medicines');
                         return false;
                     }//
                         //if (ServiceData == "[]") {
                         //    $.alert('Please select intake for at least one medicine');
                         //    return false;
                         //}
                     else {//by vij on 6th dec 2018
                         var emptyDays = $.grep(myDataWithIds, function (e) { return ((e.DAYS == "" || e.DAYS == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                         var emptyDuration = $.grep(myDataWithIds, function (e) { return ((e.DURATION == "" || e.DURATION == "--select--") && e.INTAKEDESC != "SOS" && e.INTAKEDESC != "STAT" && e.INTAKEDESC != "CONTD.") });
                         if (emptyDays.length > 0 || emptyDuration.length > 0) {
                             $.alert('Please select duration for all medicines');
                             return false;
                         }
                     }
                 }
                 else if (dataal[i] == "GetInvestigationList") { strInvestigtn = strArry; }
                 else if (dataal[i] == "GetPatAdvList") { strPatadv = strArry; }


                 var chlBoxTitleLst = null;
                 chlBoxTitleLst = [];
                 $('#div' + dataal[i] + ' input:checkbox:checked').each(function () {
                     chlBoxTitleLst.push($(this).attr('title').toString().trim());
                 });
                 var strArry1 = chlBoxTitleLst.join(",");
                 if (dataal[i] == "GetMainCompList") { strComplaintsTitle = strArry1; }
                 if (dataal[i] == "GetMainDiagnoList") { strDiagnosisTitle = strArry1; }
                 else if (dataal[i] == "GetFregqentMaterial" || dataal[i]=="GetFregqentMaterialCIMS") { strRxdataTitle = strArry1; }
                 else if (dataal[i] == "GetInvestigationList") { strInvestigtnTitle = strArry1; }
                 else if (dataal[i] == "GetPatAdvList") { strPatadvTitle = strArry1; }

                 //SaveArray.push(strArry);
             }

             if (strComplaints == '' && strDiagnosis == '' && strRxdata == '' && strInvestigtn == '' && strPatadv == '') {
                 $.alert("Select atleast one list data");
                 return false;
             }
             $.ajax({
                 type: "post",
                 datatype: "json",
                 url: '../Clinicalnotes/AddMasterSetUp',
                 data: { masterSetup: $("#MastersetupInput").val(), Gender: $("input[name='genderNM']:checked").val(), AgeF: $("#Agefromid").val(), AgeT: $("#Agetoid").val(), strComplaints: strComplaints, strDiagnosis: strDiagnosis, strRxdata: ServiceData.toString(), strInvestigtn: strInvestigtn, strPatadv: strPatadv, strInvestigtnTitle: strInvestigtnTitle, strPatadvTitle: strPatadvTitle, strPatadvTitle: strPatadvTitle, strDiagnosisTitle: strDiagnosisTitle, strComplaintsTitle: strComplaintsTitle, setUpCode: SetUpCode, status: $("#SelSystolic option:selected").val() },
                 success: function (response) {
                     if (("" + response).toUpperCase().indexOf("INSERTED") != -1) {
                         ClearFormControls();
                         CreatePersonalizedList();
                         $.messager.confirm('Information', 'Record inserted successfully', function (r) {
                             if (BackOrNot == "Y") {
                                 window.location.href = '../DoctorDesk/PatientEntry';
                             }
                         });
                        
                     }
                     else if (("" + response).toUpperCase().indexOf("UPDATED") != -1) {
                         ClearFormControls();
                         CreatePersonalizedList();
                         // $.alert('Record Updated successfully');
                         $.messager.confirm('Information', 'Record Updated successfully', function (r) {//10-12-19
                             if (BackOrNot == "Y") {
                                 window.location.href = '../DoctorDesk/PatientEntry';
                             }
                         });
                      
                     }
                     else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {

                         // $.alert("This Set Up is already Present.");
                         $.messager.confirm('Information', 'This Set Up is already Present.', function (r) {//10-12-19
                             if (BackOrNot == "Y") {
                                 window.location.href = '../DoctorDesk/PatientEntry';
                             }
                         });

                     }
                     else {
                         // $.alert("Error!!Please Contact IT Dept");
                         $.messager.confirm('Error', 'Error!!Please Contact IT Dept.', function (r) {//10-12-19
                             if (BackOrNot == "Y") {
                                 window.location.href = '../DoctorDesk/PatientEntry';
                             }
                         });
                     }
                 },
             });
         }

         function SearchServiceGroup(data) {
             input = document.getElementById("txtServiceGrp" + data);
             filter = input.value.toUpperCase();
             var elem = $("#SrvcGrpdata" + data + " li input[type='checkbox']").not(":checked").parent();
             var search = false;//added on  19th may 2018
             CommonFlag = 0;
             if ($(input).val().length >= 3) {
                 
                 getNonFreqInChkBxList(filter, elem, data);
             } else {

                 //if (CommonFlag == 1) {
                 if (data == "GetFregqentMaterial" || data == "GetFregqentMaterialCIMS") {
                     var elem = $("#SrvcGrpdata" + data + " li input[type='checkbox']").not(":checked").parent().remove();
                 }
                 else
                 var elem = $("#SrvcGrpdata" + data + " li input[type='checkbox']").not(":checked").parent().parent().remove();
                 //var elem = $("#SrvcGrpdata" + data + " li input[type='checkbox']").parent();


                 //................................................
                 var FreqDataSetupList = '';
                 if (data == "GetMainCompList") {
                     FreqDataSetupList = FreqMainCompList;
                 }

                 else if (data == "GetMainDiagnoList") {
                     FreqDataSetupList = FregqentDiagno;
                 }

                 else if (data == "GetPatAdvList") {
                     FreqDataSetupList = FregqentAdvice;
                 }

                 else if (data == "GetFregqentMaterial") {

                     FreqDataSetupList = FregqentMaterial;
                 }
                 else if (data == "GetFregqentMaterialCIMS") {

                     FreqDataSetupList = FregqentCIMS;

                 }
                 else if (data == "GetInvestigationList") {
                     FreqDataSetupList = FregqentInvest;
                 }


                 var checdelem = $("#SrvcGrpdata" + data + " li input[type='checkbox']:checked").parent()
                
                

                 //var freqdata = [];
                 $.each(checdelem, function (j, item) {

                     var label = checdelem[j].getElementsByTagName("input")[0];
                     if (label)
                         FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {

                             if (data == "GetFregqentMaterial" || data == "GetFregqentMaterialCIMS") {
                                 if (GeneralWiseYN == "Y")
                                     return FreqDataSetupList[index]["GENERICID"].toString().trim() != label.defaultValue.toString().trim();
                                 else
                                     return FreqDataSetupList[index]["MTRLCODE"].toString().trim() != label.defaultValue.toString().trim();
                             } else if (data == "GetPatAdvList" || data == "GetMainDiagnoList") {

                                 return FreqDataSetupList[index]["DESCCD"].toString().trim() != label.defaultValue.toString().trim();
                             } else if (data == "GetInvestigationList") {

                                 return FreqDataSetupList[index]["TESTCODE"].toString().trim() != label.defaultValue.toString().trim();
                             }
                             else
                                 return FreqDataSetupList[index]["CODE"].toString().trim() != label.defaultValue.toString().trim();
                         });
                 });


                 $.each(FreqDataSetupList, function (i, item) {
                    
                    
                                 
                     if (data == "GetFregqentMaterial" || data == "GetFregqentMaterialCIMS") {



                         $("#SrvcGrpdata" + data).append("<li><input type=checkbox id='" + (GeneralWiseYN == "Y" ? item.GENERICID.trim().replace(/[^0-9a-zA-Z]/gi, '') : item.MTRLCODE.trim().replace(/[^0-9a-zA-Z]/gi, '')) + "' title='" + (GeneralWiseYN == "Y" ? item.GENERICNAM.toString().trim() : item.MTRLNAME.toString().trim()) + "' value='" + (GeneralWiseYN == "Y" ? item.GENERICID.toString().trim() : item.MTRLCODE.toString().trim()) + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + (GeneralWiseYN == "Y" ? item.GENERICNAM.toString().trim() : item.MTRLNAME.toString().trim()) + "</label><label id='genericId' style='display:none'></label><label id='genericName' style='display:none'></label><li>");

                         //return FreqDataSetupList[index]["MTRLCODE"].toString().trim() == label.defaultValue.toString().trim();
                     } else if (data == "GetPatAdvList" || data == "GetMainDiagnoList") {
                         var title = item.DESC;
                         var idstring = item.DESCCD;
                         $("#SrvcGrpdata" + data).append("<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>");
                         //  return FreqDataSetupList[index]["DESCCD"].toString().trim() == label.defaultValue.toString().trim();
                     } else if (data == "GetInvestigationList") {
                         var title = item.TESTNAME.trim();
                        var idstring = item.TESTCODE.trim();
                         $("#SrvcGrpdata" + data).append("<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>");
                         // return FreqDataSetupList[index]["TESTCODE"].toString().trim() == label.defaultValue.toString().trim();
                     }
                     else {

                        var title = item.NAME;
                         var idstring = item.CODE;
                         $("#SrvcGrpdata" + data).append("<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>");
                         // return FreqDataSetupList[index]["CODE"].toString().trim() == label.defaultValue.toString().trim();
                     }
                 });

                 //.............................................


                // for (i = 0; i < elem.length; i++) {

                    // options += "<li><input type=checkbox id='" + item.MTRLCODE.trim().replace(/[^0-9a-zA-Z]/gi, '') + "' title='" + title + "' value='" + item.MTRLCODE.trim() + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'></label><label id='genericName' style='display:none'></label><li>";


                        // $(elem[i]).removeClass('display');
                         //label = elem[i].getElementsByTagName("input")[0];


                       //  if (label) {


                             //if (label.title.toUpperCase() == NonFreqDataSetupList[i].NAME.toUpperCase()) {

                             //var nonfreqCount = NonFreqDataSetupList.filter(function () {
                             //    return $(this).val().toUpperCase() == label.title.toUpperCase();
                             //}).length;
                           

                             //if (freqCount > 0) {
                             //    elem[i].style.display = "";
                             //    if (!$(elem[i]).hasClass('display')) {
                             //        $(elem[i]).addClass('display');
                             //    }
                             //} else {
                             //    elem[i].remove();
                             //}



                             //  }


                        // }

                     


                 }
             


             //var elem = $("#SrvcGrpdata li");
             // var elem = $("#SrvcGrpdata" + data + " li input[type='checkbox']").not(":checked").parent();// added by vijeta on 24th sep 2018
             var elem = $("#SrvcGrpdata" + data + " li input[type='checkbox']").not(":checked").parent();
             for (i = 0; i < elem.length; i++) {
                 $(elem[i]).removeClass('display');
                 label = elem[i].getElementsByTagName("input")[0];
                 if (label) {
                     if (label.title.toUpperCase().indexOf(filter) > -1) {
                         elem[i].style.display = "";
                         if (!$(elem[i]).hasClass('display')) {
                             $(elem[i]).addClass('display')
                         }
                     } else {
                         elem[i].style.display = "none";
                     }
                 }
             }
         }

         function getNonFreqInChkBxList(filter, obj, data) {


             HoldOn.open();//
             CommonFlag = 1;
             var strClinincode = $.session.get('ClinicCode').toString().trim();

             if (data == "GetMainCompList") {
                 GetComplaintsFrmDB(filter, obj, data);
             }

             else if (data == "GetMainDiagnoList") {
                 GetDiagnosisFrmDB(filter, obj, data);
             }

             else if (data == "GetPatAdvList") {
                 GetPatAdviceFrmDB(filter, obj, data);
             }

             else if (data == "GetFregqentMaterial" || data=="GetFregqentMaterialCIMS") {
                 GetRxFrmDB(filter, obj, data);
             }

             else if (data == "GetInvestigationList") {
                 GetInvestigationsFrmDB(filter, obj, data);
             }



         }
         //added 10/6/19
         function GetComplaintsFrmDB(filter, obj, data) {
             var strClinincode = $.session.get('ClinicCode').toString().trim();
             HoldOn.open();//
             $.ajax({
                 type: "POST",
                 url: "<%=Url.Action("GetDBComplainList","DoctorDesk")%>",
                async: false,
                data: { complainName: filter, ClinicCode: strClinincode },
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        var rows = "";
                        var NonFreqMainCompList = result.Table1;
                        $.each(result.Table1, function (i, item) {


                            var MatchElement = jQuery.grep(obj, function (element, index) {
                                code = element.getElementsByTagName("input")[0].id;
                                return ((item.CODE).toString().trim() == code.toString().trim());
                            });

                            if (MatchElement.length > 0) {
                                //Do not bind
                            }
                            else {
                                var title = item.NAME;
                                var idstring = item.CODE;
                                rows = "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE + "'>" + title + "</label></li>";
                                $("ul#SrvcGrpdata" + data).append(rows);
                            }

                           
                        });
                    }
                    HoldOn.close();//     
                },
                complete: function () {
                    HoldOn.close();//              
                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

         //added 10/6/19
         function GetDiagnosisFrmDB(filter, obj, data) {
             var strClinincode = $.session.get('ClinicCode').toString().trim();
             HoldOn.open();
             $.ajax({
                 type: "POST",
                 url: "<%=Url.Action("GetNonFregqentDiagnoList","DoctorDesk")%>",
                 data: { NonFreqDiagno: filter, strClinincode: strClinincode },
                 asycn: false,
                 success: function (response) {
                     if (response != "") {
                         var result = JSON.parse(response)

                         var rows = "";
                         NonFregqentDiagno = result.Table1;
                         for (i = 0; i < result.Table1.length; i++) {

                             var MatchElement = jQuery.grep(obj, function (element, index) {
                                 code = element.getElementsByTagName("input")[0].id;
                                 return ((result.Table1[i].CODE).toString().trim() == code.toString().trim());
                             });

                             if (MatchElement.length > 0) {
                                 //Do not bind
                             }
                             else {

                                 var title = result.Table1[i].NAME.trim();
                                 var idstring = result.Table1[i].CODE;
                                 rows = "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + result.Table1[i].CODE + "'>" + title + "</label></li>";

                                 $("ul#SrvcGrpdata" + data).append(rows);
                             }

                             
                         }
                     } 

                 },
                 complete: function () {
                     HoldOn.close();//

                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                     $.messager.alert("Error", errorThrown);
                 }
             });
         }

         //added 10/6/19
         function GetPatAdviceFrmDB(filter, obj, data) {
             HoldOn.open();//
             var strClinincode = $.session.get('ClinicCode').toString().trim();
             $.ajax({
                 type: "POST",
                 url: "<%=Url.Action("GetDBPatientAdvice","DoctorDesk")%>",
                 data: { PatAdvice: filter, ClinicCode: strClinincode },
                 async: false,
                 success: function (Response) {
                     if (Response != "Unsucessfull") {
                         var result = JSON.parse(Response);
                         var rows = "";
                         NonFregqentAdvice = result.Table1;
                         $.each(result.Table1, function (i, item) {

                             var MatchElement = jQuery.grep(obj, function (element, index) {
                                 code = element.getElementsByTagName("input")[0].id;
                                 return ((item.CODE).toString().trim() == code.toString().trim());
                             });

                             if (MatchElement.length > 0) {
                                 //Do not bind
                             }
                             else {
                                 var title = item.NAME.trim();
                                 var idstring = item.CODE.trim();
                                 rows = "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE.trim() + "'>" + title + "</label></li>";
                                 $("ul#SrvcGrpdata" + data).append(rows);

                             }
                            
                         });
                     }
                 },
                 complete: function () {
                     HoldOn.close();//
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                     $.messager.alert("Error", errorThrown);
                 }
             });
         }

         function GetRxFrmDB(filter, obj, data) {
             HoldOn.open();
             var url = "";
             if (data == "GetFregqentMaterial") {
                 url = "<%=Url.Action("GetNonFreqDrugLstFrRxDesktop","DoctorDesk")%>";
             } else if (data == "GetFregqentMaterialCIMS") {
                 url = "<%=Url.Action("SearchMaterial","DoctorDesk")%>";
             }
         $.ajax({
             type: "POST",
             url: url,
             data: { NonFreqDrug: filter },
             async: false,
             success: function (response) {
                 if (response != "Unsucessfull") {
                     if (data == "GetFregqentMaterial") {// 18-09-19 - added separate conditions for cims and non cims materials
                         var result = JSON.parse(response)


                         for (i = 0; i < result.Table.length; i++) {
                             var result = JSON.parse(response);
                             var rows = "";
                             var MatchElement = jQuery.grep(obj, function (element, index) {
                                 code = element.getElementsByTagName("input")[0].value;
                                 if (GeneralWiseYN == "Y")
                                     return (($.trim(result.Table[i].GENERICID)).toString().trim() == code.toString().trim());
                                 else
                                     return (($.trim(result.Table[i].MTRLCODE)).toString().trim() == code.toString().trim());
                             });

                             if (MatchElement.length > 0) {
                                 //Do not bind
                             }
                             else {

                                 var DurgidASClass = ''
                                 DurgidASClass = GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                                 DurgidASClass = DurgidASClass.replace(/\//g, '');
                                 var code = GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : $.trim(result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                                 code = code.replace(/\//g, '');

                                 var title = GeneralWiseYN == "Y" ? result.Table[i].GENERICNAM.trim() : result.Table[i].MTRLNAME.trim();
                                 var idstring = code;
                                 rows = "<li><input type=checkbox id='" + (GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '').trim() : (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '').trim()) + "' title='" + title + "' value='" + (GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).trim() : (result.Table[i].MTRLCODE).trim()) + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" + result.Table[i].GENERICID.trim() + "</label><label id='genericName' style='display:none'>" + result.Table[i].GENERICNAM + "</label></li>";
                                 $("ul#SrvcGrpdata" + data).append(rows);
                             }

                           

                         }
                         NonFregqentMaterial = result.Table;
                     }
                     else {

                         for (i = 0; i < response.length; i++) {
                             var result = response[i];
                             var rows = "";
                             var MatchElement = jQuery.grep(obj, function (element, index) {
                                 code = element.getElementsByTagName("input")[0].value;
                                 return (($.trim(result.CODE)).toString().trim() == code.toString().trim());
                             });

                             if (MatchElement.length > 0) {
                                 //Do not bind
                             }
                             else {

                                 var DurgidASClass = ''
                                 DurgidASClass = (result.CODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                                 DurgidASClass = DurgidASClass.replace(/\//g, '');
                                 var code = $.trim(result.CODE).replace(/[^0-9a-zA-Z]/gi, '').trim();
                                 code = code.replace(/\//g, '');

                                 var title = result.NAME.trim();
                                 var idstring = code;
                                 rows = "<li><input type=checkbox id='" + (result.CODE).replace(/[^0-9a-zA-Z]/gi, '').trim() + "' title='" + title + "' value='" + (result.CODE).trim() + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" + '' + "</label><label id='genericName' style='display:none'>" + '' + "</label></li>";
                                 $("ul#SrvcGrpdata" + data).append(rows);

                             }

                           

                         }


                         NonFregqentMaterialCIMS = response;
                     }
                 }
             },
             complete: function () {
                 HoldOn.close();
             },//
             error: function (XMLHttpRequest, textStatus, errorThrown) {
                 // HoldOn.close();
                 $.messager.alert("Error", errorThrown);
             },

         });
     }
         function OtherRemarkClicked(newthis) {
             $.confirm({
                 title: '',
                 content: '' +
                 '<form action="" class="formName" style="height:auto">' +
                 '<div class="form-group"><textarea rows="4" cols="50" maxlength="500"  id="txtRemark"   placeholder="Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' //kavita
                      ,
                 buttons: {
                     formSubmit: {
                         text: 'Save',
                         btnClass: 'btn-blue',
                         action: function () {
                             var NewRemark = '' + $('#txtRemark').val();
                             if (NewRemark != "") {
                                 $.ajax({
                                     type: "post",
                                     datatype: "json",
                                     url: '../DoctorDesk/saveIntakeRemark',
                                     data: { strNewRemark: NewRemark, },
                                     success: function (response) {
                                         if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {

                                             var strCode = "" + response.toString();
                                             strCode = strCode.substring(strCode.length - 3, strCode.length);

                                             //$.alert("Record Inserted Successfully", "Information");
                                             //var s = "<a href='javascript:;' id='" + strCode + "' class='anchorRemark' style='font-weight:500;font-size:14px;border-bottom: 1px solid #cecece'>" + NewRemark + "</a>";
                                             //$(s).insertAfter("#Remarkid");
                                             //setTimeout(function () { $("#" + strCode).click() }, 500);
                                             //if ($(newthis)[0].id.toString().trim() == "divOther")
                                             //    $("#layer-Remark a#" + strCode + "").trigger("click");



                                             CommonForRemark.push({
                                                 Value: strCode,
                                                 Text: NewRemark
                                             });
                                             var selRowId = $('#tblGrid').jqGrid('getGridParam', 'selrow');


                                             jQuery("#tblGrid").setColProp("REMARK", {
                                                 editoptions: {
                                                     value: load_Remarks(),
                                                 }
                                             }).trigger("reloadGrid");

                                             $('#tblGrid').setCell(selRowId, 'REMARK', strCode);

                                         }
                                         else {
                                             $.alert(response, "Information");
                                         }
                                     },

                                 });
                             }

                         }
                     },
                     cancel: function () {
                         //close
                         //$('.FoodItems input:checked').focus();
                     },
                 },
                 onContentReady: function () {
                     $('#1').focus();
                     // bind to events
                     var jc = this;
                     this.$content.find('form').on('submit', function (e) {
                         // if the user submits the form by pressing enter in the field.
                         e.preventDefault();
                         jc.$$formSubmit.trigger('click'); // reference the button and click it
                     });
                 }
             });
         }
         //added on 12/6/19
         $(document.body).on('click', '#divGetMainCompList li input,#divGetMainDiagnoList li input,#divGetInvestigationList li input,#divGetPatAdvList li input', function (e) {
             var id = $(this).parents('ul')[0].firstChild.id;
             var divId = $(this).parents('div')[0].id;
             if (e.currentTarget.checked === true) {


                 $(this).parent().parent().remove();

                 if ($("#" + divId + " input[type='checkbox']:checked").length == 0) {
                     $($(this).parent().parent()).insertAfter('a[id=' + id + ']');
                 }
                 else {
                     $($(this).parent().parent()).insertAfter($("#" + divId + " input[type='checkbox']:checked").last().parents('li'));

                 }

                // $(this).focus();
                 //$(".searchCheckBoxCls").val("").trigger("keyup");
             }
             else {

             }
             $("#dblServiceHelpsrvcgrp").show();
             $("#txtServiceGrpsearch").val("").trigger("keyup");
             e.stopPropagation();
         });

         //added on 12/6/19
         $(document.body).on('click', '#div' + RxListDiv + ' li input', function (e) {
             if ($(this)[0].checked) {
                 var matcode = $(this)[0].defaultValue;
                 var matnam = $(this)[0].parentNode.innerText;
                 //meenakshi
                 var mtrlInfoUrl = '../DoctorDesk/GetMaterialInfo';
                 var newRow = "";
                 if (GeneralWiseYN != "Y") {
                     if (mscimsYN == "Y")
                         mtrlInfoUrl = '../DoctorDesk/GetMaterialInfo';
                     else
                         mtrlInfoUrl = '../DoctorDesk/GetPHMaterialInfo';
                     $.ajax({

                         url: mtrlInfoUrl,
                         data: { mtrlCode: $(this)[0].defaultValue },
                         type: 'post',
                         datatype: 'json',
                         async: false,
                         success: function (response) {
                             var dossage = response.Strength + (response.StrengthUnit != "" ? (" " + response.StrengthUnit) : "");
                             newRow = {
                                 act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                 CODE: response.CODE,
                                 NAME: '<span class="fa fa-info-circle fa-1x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf" ></span> ' + response.NAME,
                                 DRUGFORM: response.Form,
                                 GENERICID: response.GenericCode,
                                 GENERICNAM: response.Generic,
                                 DOSAGE: dossage,
                             };
                             if (response.CODE == "" || response.CODE == null) {
                                 newRow = {
                                     act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                     CODE: matcode,
                                     NAME: '<span class="fa fa-info-circle fa-1x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf" ></span> ' + matnam,
                                 };
                             }
                         },
                         complete: function () {

                         },
                         error: function (XMLHttpRequest, textStatus, errorThrown) {
                             $.messager.alert("Error", errorThrown);
                         }
                     });
                 }
                 else {
                     newRow = {
                         act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                         CODE: matcode,
                         NAME: '<span class="fa fa-info-circle fa-1x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf" ></span> ' + matnam,
                         DRUGFORM: "",
                         GENERICID: matcode,
                         GENERICNAM: matnam,
                         DOSAGE: "",
                     };
                 }
                 var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                 if ($.inArray($(this)[0].defaultValue, ids) == -1) {
                     $('#tblGrid').addRowData($(this)[0].defaultValue, newRow, 'last');
                        if(mscimsYN == "Y")
                            GetMaterialInteraction($(this)[0].defaultValue);

                     var ids = jQuery("#tblGrid").jqGrid('getDataIDs');
                     if (typeof newRow.DRUGFORM == "undefined" || newRow.DRUGFORM == "") {
                         //jQuery("#tblGrid").jqGrid("editCell", 'last', 15, true);//3/29/19
                         jQuery("#tblGrid").jqGrid('setCell', ids[ids.length - 1], 'DRUGFORM', '', 'editable-cell');

                     } else {
                         
                        // jQuery("#tblGrid").jqGrid("editCell", Number(ids.length) + 1, 15, false);

                        // jQuery("#tblGrid").jqGrid("editCell", 1, 15, false);
                         //jQuery("#tblGrid").jqGrid("editCell", 1, 14, false);
                         //jQuery("#tblGrid").jqGrid("editCell", 1, 13, false);
                        // jQuery("#tblGrid").jqGrid("editCell", ids[0], 15, false);
                         jQuery("#tblGrid").jqGrid('setCell', ids[ids.length - 1], 'DRUGFORM', '', 'not-editable-cell');
                         if (newRow.DRUGFORM == "TAB" || newRow.DRUGFORM == "SYP" || newRow.DRUGFORM == "CAP" || newRow.DRUGFORM == "FILM-COATE") {
                             jQuery('#tblGrid').jqGrid('setCell', ids[ids.length - 1], 'ROUTE', '09');
                         } else if (newRow.DRUGFORM == "INJ" || newRow.DRUGFORM == "IV" || newRow.DRUGFORM == "CAP") {
                             jQuery('#tblGrid').jqGrid('setCell', ids[ids.length - 1], 'ROUTE', '02');
                         }
                         //jQuery("#tblGrid").jqGrid('setCell', 1, 'DRUGFORM', '','not-editable-cell');
                        // .jqGrid('setCell', rowID, ColName, '', 'not-editable-cell');
                         //jQuery("#tblGrid").jqGrid("editCell", ids[0], 14, false);
                     }
                 }


                 $(this).parents('li').remove();
                 if ($("#div" + RxListDiv + " input[type='checkbox']:checked").length == 0) {
                     $($(this).parents('li')).insertAfter('a[id=btn' + RxListDiv + ']');
                 }
                 else {
                     $($(this).parents('li')).insertAfter($("#div" + RxListDiv + " input[type='checkbox']:checked").last().parents('li'));

                 }

                // $(this).focus();
               //  $("#txtServiceGrp" + RxListDiv).val("").trigger("keyup");
             }
             else {
                 $('#tblGrid').jqGrid('delRowData', $(this)[0].defaultValue);
                 GetMaterialInteraction($(this)[0].defaultValue);
             }
         });
         //added 10/6/19
         function GetInvestigationsFrmDB(filter, obj, data) {
             HoldOn.open();
             $.ajax({
                 type: "POST",
                 url: "<%=Url.Action("GetTestList","DoctorDesk")%>",
                 async: false,
                 data: { testname: filter },
                 success: function (response) {
                     var result = response
                     var rows = "";
                     NonFregqentInvest = result;

                     $.each(result, function (i, item) {

                         var MatchElement = jQuery.grep(obj, function (element, index) {
                             code = element.getElementsByTagName("input")[0].id;
                             return ((item.TESTCODE).toString().trim() == code.toString().trim());
                         });

                         if (MatchElement.length > 0) {
                             //Do not bind
                         }
                         else {
                             var title = item.TESTNAME.trim();
                             var idstring = item.TESTCODE.trim();
                             rows = "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.TESTCODE.trim() + "'>" + title + "</label></li>";

                             $("ul#SrvcGrpdata" + data).append(rows);
                         }
                        
                     });

                 }, complete: function () {
                     HoldOn.close();//
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                     $.messager.alert("Error", errorThrown);
                 }
             });

         }

         function AddAllMasterSetUp() {

             //Iterated over the IEnumerable list.
             //var abc = "<a id=btnsrvgrp style=color:blue;cursor:pointer float:right;>ClearSelection</a>"
             var i = 0;


             HoldOn.open();//
             for (i = 0; i < dataal.length; i++) {
                 var kk = dataal[i].toString();
                 var urlal = '';
                 var strClinincode = $.session.get('ClinicCode').toString().trim();
                 // '../Trans/TransactionCall?value=' + deptName.value + '&Text=' + repcText1; 
                 if (kk == "GetMainCompList" || kk == "GetMainDiagnoList" || kk == "GetPatAdvList")
                     urlal = "../DoctorDesk/" + kk + "?ClinicCode=" + strClinincode;
                 else
                     urlal = "../DoctorDesk/" + kk;


                 $.ajax({
                     type: "POST",
                     //url: "",
                     url: urlal,
                     data: {},
                     async: false,
                     success: function (response) {

                         if (response != "" && response != "Unsucessfull") {
                             var $divPanel = $('<div>', { style: '-webkit-box-shadow: 0px 0px 6px 2px #878888;', class: 'panel' });
                             var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });

                             var patCompleteYn = $.session.get('PatCompleted');


                             var strdata = '';
                             if (dataal[i] == "GetMainCompList") {
                                 strdata = 'Complaint List';
                                 if (response != "UNSUCCESSFULL") {
                                     var data = JSON.parse(response);
                                     response = data.Table1;
                                     FreqMainCompList = response;
                                 }
                             } else if (dataal[i] == "GetMainDiagnoList") {
                                 strdata = 'Diagnosis List';
                                 FregqentDiagno = response;
                             } else if (dataal[i] == "GetFregqentMaterial") {
                                 strdata = 'RxData List';
                                 var data = JSON.parse(response);
                                 response = data.Table;
                                 FregqentMaterial = response;

                             } else if (dataal[i] == "GetFregqentMaterialCIMS") {
                                 strdata = 'CIMS Rx List';

                                 var data = JSON.parse(response);
                                 response = data.Table;
                                 FregqentCIMS = response
                             }
                             else if (dataal[i] == "GetInvestigationList") {
                                 strdata = 'Investigation List';
                                 FregqentInvest = response
                             } else {
                                 strdata = 'Patient Advice List';
                                 FregqentAdvice = response;
                             }
                             var strTable = "<table style='width:100%'><tr><td id='ListName' class='ExColicon' style='width:80%;text-align:left'>" + strdata + "</td><td class='ExColicon' style='text-align:right'><span class='fa fa-caret-down spanCls'></span></td></tr></table>";


                             $divPanelHead.append(strTable);
                             var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });//
                             var $divMasterSetUp = $('<div>', { class: 'row nopadding' });
                             var strMasterSetUpLst = "<div class='form-group'><input id='txtServiceGrp" + dataal[i] + "' type='text'  placeholder='Search in " + strdata + "'  class='form-control searchCheckBoxCls' /> <span class='fa fa-plus fa-2x invsAddspan' title='Add free Invetigation' id='spanAddNew" + dataal[i].toString() + "' onclick='AddNewSetupListwise( \"" + dataal[i] + "\")'></span>"
                             strMasterSetUpLst += " <div id='divSrvcGrp" + dataal[i] + "' style='border:1px solid gray;'>";
                             strMasterSetUpLst += "<div class='searchdivclass' id='div" + dataal[i] + "' style='height:300px;margin-left:0px;overflow:auto;border-color:#f47b02;border-style:solid;background:azure'>";
                             strMasterSetUpLst += "<ul id='SrvcGrpdata" + dataal[i] + "' class='searchlistclass'><a id='btn" + dataal[i] + "'  style='color:blue;cursor:pointer float:right;' onclick='ClearAllCheckd(\"" + dataal[i] + "\")'>ClearSelection</a>";
                             //var result = JSON.parse(response);
                             //if (dataal[i] == "GetMainCompList") {
                             //    var data = JSON.parse(response);
                             //    response = data.Table1;
                                 
                             //}
                             //if (dataal[i] == "GetFregqentMaterial" || dataal[i]=="GetFregqentMaterialCIMS") {
                             //    var data = JSON.parse(response);
                             //    response = data.Table;
                                  
                             //}
                             var options = '';
                             if (response != "UNSUCCESSFULL") {
                                 $.each(response, function (j, item) {
                                     var title = '';
                                     var idstring = '';
                                     if (dataal[i] == "GetMainCompList") {
                                         title = item.NAME;
                                         idstring = item.CODE;
                                     } else if (dataal[i] == "GetMainDiagnoList" || dataal[i] == "GetPatAdvList") {
                                         title = item.DESC;
                                         idstring = item.DESCCD;
                                     } else if (dataal[i] == "GetFregqentMaterial" || dataal[i] == "GetFregqentMaterialCIMS") {
                                         title = GeneralWiseYN == "Y" ? item.GENERICNAM : item.MTRLNAME;
                                         idstring = GeneralWiseYN == "Y" ? item.GENERICID : item.MTRLCODE;
                                     }
                                     else if (dataal[i] == "GetInvestigationList") {
                                         title = item.TESTNAME.trim();
                                         idstring = item.TESTCODE.trim();
                                     }


                                     if (dataal[i] == "GetFregqentMaterial" || dataal[i] == "GetFregqentMaterialCIMS") {
                                         // options += "<li><input type=checkbox id='" + item.MTRLCODE.trim().replace(/[^0-9a-zA-Z]/gi, '') + "' title='" + title + "' value='" + item.MTRLCODE.trim() + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" + item.GENERICID.trim() + "</label><label id='genericName' style='display:none'>" + item.GENERICNAM + "</label><li>";
                                         options += "<li><input type=checkbox id='" + (GeneralWiseYN == "Y" ? item.GENERICID.trim().replace(/[^0-9a-zA-Z]/gi, '') : item.MTRLCODE.trim().replace(/[^0-9a-zA-Z]/gi, '')) + "' title='" + title + "' value='" + (GeneralWiseYN == "Y" ? item.GENERICID.trim() : item.MTRLCODE.trim()) + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'></label><label id='genericName' style='display:none'></label><li>";


                                     }
                                     else {
                                         options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>";
                                     }

                                 });
                             }
                             strMasterSetUpLst += options + "</ul></div></div></div>";

                             if (dataal[i] == "GetFregqentMaterial" || dataal[i]=="GetFregqentMaterialCIMS")
                                 strMasterSetUpLst += "<div id='divSrvcGrpGrid'  style='margin-top:5px'><table id='tblGrid'></table></div>"
                                    + "<div><label style='background-color: transparent;  border-color: transparent;' title='Severity' class='SeverityBtn'><button type='button' id='btnInteraction1' class='btn btn-info margin' style='float: right; padding: 2px 12px; font-size: 14px; margin-top: 3px;border-radius: 50%;height: 28px;width: 28px;background-color:green;'></button></label></div>"; 

                             $divMasterSetUp.append(strMasterSetUpLst);
                             $divPanelBody.append($divMasterSetUp);
                             $divPanel.append($divPanelHead);
                             $divPanel.append($divPanelBody);


                             $("#tbldiv").append($divPanel)
                         }



                     },
                     complete: function () {

                         //added on 12/6/19
                         if (dataal[i] == "GetFregqentMaterial" || dataal[i]=="GetFregqentMaterialCIMS") {
                             load_Intake();
                             BindSelectedMedicineGrid();
                         }

                         //added on 15/6/19
                         //if (i == dataal.length - 1)
                         //    FillMasterSetupData();

                         HoldOn.close();//
                     },
                     error: function (XMLHttpRequest, textStatus, errorThrown) {
                         HoldOn.close();//
                         $.messager.alert("Error", errorThrown);
                     },

                 });
                 //-------------------------------------
             }
             //$('#divSrvcGrpSelect').append($newDiv);
         }

         function maxLengthCheck(object) {
             if (Number(object.value) > Number(object.max))
                 object.value = Number(object.max);
             else if (Number(object.value) < 1) {
                 object.value = 1;
             }
         }
         function AgeCalc(object) {
             
         }
         function GetMaterialInteraction(mtrlCode) {
             var arr = [];
             flagforConfirmChckbox = 1;
           //  if (flagforConfirmChckbox == 1) {
                 var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                 $.each(ids, function (i, val) {
                     var id = $("#tblGrid").jqGrid('getCell', val, 'CODE');
                     //var id = $(this).children('td.tdDrugCode')[0].innerText;
                     arr.push(id);
                 });

             //} else {
             //    var selRows = $('#tblMedicineList > tbody > tr.active').get();
             //    // var arr = [];
             //    $.each(selRows, function (i, val) {
             //        var id = $(this).children('td.tdDrugCode')[0].innerText;
             //        arr.push(id);
             //    });
             //}
             HoldOn.open();
             $.ajax({
                 url: '../DoctorDesk/GetMaterialInteraction',
                 data: { refCodeArry: JSON.stringify(arr) },
                 type: 'Get',
                 async: true,
                 //datatype: 'json',
                 success: function (response) {
                     medicineInterStr = "";
                     if (response[0] != null && response[1] != null) {
                         //based on severity change color of button

                         medicineInterStr = response[1];
                         if (response[0] != "0") {
                             //$("#btnInteraction").show();
                             severityLevel = 1;

                             if (Number(response[0]) > severityLevel) {
                                 severityLevel = response[0];
                             }
                             if (severityLevel == 1) {
                                 if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "green"); } else
                                     $("#btnInteraction").css("background-color", "green");
                             }
                             else if (severityLevel == 2) {
                                 if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "greenyellow"); } else
                                     $("#btnInteraction").css("background-color", "greenyellow");
                             }
                             else if (severityLevel == 3) {
                                 if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "yellow"); } else
                                     $("#btnInteraction").css("background-color", "yellow");
                             }
                             else if (severityLevel == 4) {
                                 if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "orange"); } else
                                     $("#btnInteraction").css("background-color", "orange");
                             }
                             else if (severityLevel == 5) {
                                 if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "red"); } else
                                     $("#btnInteraction").css("background-color", "red");
                             }
                         }
                         else {
                             if (flagforConfirmChckbox == 1) { $("#btnInteraction1").css("background-color", "green"); }
                             else
                                 $("#btnInteraction").css("background-color", "green");

                         }


                     }
                     HoldOn.close();
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                     $.messager.alert("Error", errorThrown);
                 }
             });
         }
         // $(document.body).on("click", "#spanAddNewInvtInSetUp", function (e) {
         function AddNewSetupListwise(MasterList) {

             //......................
             var HeadName = "";

             if (MasterList == "GetMainCompList") {
                 HeadName = "New Complaint"
             } else if (MasterList == "GetMainDiagnoList") {
                 HeadName = "New Diagnosis"
             } else if (MasterList == "GetInvestigationList") {
                 HeadName = "New Investigation"
             } else if (MasterList == "GetPatAdvList") {
                 HeadName = "New Patient Advice"
             } else if (MasterList == "GetFregqentMaterialCIMS" || MasterList == "GetFregqentMaterial") {
                 HeadName = "New Rx"
             }

             //......................



             $.confirm({
                 title: '',
                 closeIcon: true,
                 offsetTop: 10,
                 type: 'orange',
                 backgroundDismissAnimation: 'glow',
                 theme: 'bootstrap',
                 content: '' +
                 '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">' + HeadName + '</label><br>' +
                 '<input  type="varchar" id="txtNewMInvst"  placeholder="Enter Text" autofocus="autofocus" class="setUp form-control" required />' +
                 '</div>' +

                 '</form>',
                 buttons: {
                     formSubmit: {
                         text: 'Save',
                         btnClass: 'btn-blue',
                         action: function () {
                             if ($("#txtNewMInvst").val() == "" || $("#txtNewMInvst").val() == null) {

                                 $('#txtNewMInvst').css({ 'border-color': 'Red' });
                                 return false;

                             } else {
                                 $('#txtNewMInvst').css({ 'border-color': '' });
                             }
                             var invstName = $("#txtNewMInvst").val();
                             //freeHandInvestigation = freeHandInvestigation + " " + invstName;
                             //$("#freeHandBtn").css("background-color", "green");
                             //$("#txtFreeInvestigation").val(freeHandInvestigation);



                             SetupNoFrMedTaper = SetupNoFrMedTaper + 1;
                             var medCode = "NEW" + SetupNoFrMedTaper;
                             var flagset = 0;
                             if (MasterList.toString().trim() == "GetFregqentMaterialCIMS")
                                 $('#SrvcGrpdataGetFregqentMaterialCIMS li').each(function () {
                                     if ($(this)[0].innerText.toString().trim() == invstName.toString().trim())
                                         flagset = 1;

                                 });

                             if (flagset == 0) {

                                 var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + invstName + "' value='" + medCode + "' checked />" + "<label style='vertical-align:middle'>" + invstName + "</label></label><li>";
                                 $(elemnet).insertAfter('a[id="btn' + MasterList + '"]');
                                 $(elemnet).focus();
                                 // $("#dblServiceHelpsrvcgrp").show();
                                 // $("#divSrvcGrpGrid").show();ssss

                                 //.................................................
                                 var medName = $("#txtNewMInvst").val();

                                 var newRow = {
                                     act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                     CODE: medCode,
                                     NAME: '<span class="fa fa-info-circle fa-1x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf" ></span>' + medName
                                     //INTAKE: '----select----',//commenyed by vijeta on 7th dec 2018
                                     //GENERICID: $(this)[0].parentNode.nextSibling.innerText,
                                     //GENERICNAM: $(this)[0].parentNode.nextSibling.nextSibling.innerText
                                 };
                                 //$("#tblGrid").jqGrid('addRow', "new");
                                 //var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                                 //if ($.inArray($(this)[0].defaultValue, ids) == -1)
                                 $('#tblGrid').addRowData(medCode, newRow, 'last');


                                 $("#dblServiceHelpsrvcgrp").show();
                                 $("#divSrvcGrpGrid").show();
                             } else {
                                 $.alert("Medicine Already Existing", "Information");
                             }

                             //.................................................

                         }
                     },
                     Closed: {
                         text: 'Cancel'
                         //close
                     }
                 }

             });
         }

        // });
         //Save on back button
         //jQuery(document).ready(function ($) {

         //    if (window.history && window.history.pushState) {

         //        window.history.pushState('forward', null, './MasterSetup');

         //        $(window).on('popstate', function () {
         //            SaveAllMasterSetUp();
         //        });
         //    }
         //});

        //added 12/6/19
        function BindSelectedMedicineGrid() {
            function getColumnIndexByName(grid, columnName) {
                var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
                for (i = 0; i < l; i++) {
                    if (cm[i].name === columnName) {
                        return i; // return the index
                    }
                }
                return -1;
            }
            jQuery("#tblGrid").jqGrid({
                datatype: 'local',
                colNames: ['', 'Code', 'Medicine Name', 'Generic Name', 'Dose', '<label>Frequency</label><span style="float:right;width: 22px;font-size: large;color: #3d7da3" title="Add Frequency" id="btnNewIntake" onclick="NewIntake()"> <i class="fa fa-plus"></i></span>', 'Intake Calculated', 'Days', 'Duration', 'Food', 'Route', '<label>Remark</label><span style="float:right;width: 22px;font-size: large;color: #3d7da3" title="Add Frequency" id="btnNewIntake" onclick="OtherRemarkClicked(this)"> <i class="fa fa-plus"></i></span>', 'Generic Id', 'Drug Form'],
                colModel: [
                    {
                        name: 'act',
                        name: 'act',
                        width: 25,//50,
                        editable: false,
                        formatter: CancelImg
                    },
                     { name: 'CODE', index: 'CODE', width: 10, hidden: true, align: "right", sortable: false, searchoptions: { clearSearch: false } },
                  {
                      name: 'NAME', index: 'NAME', width: 140, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: GeneralWiseYN == "Y" ? true : false
                  },
                      {
                          name: 'GENERICNAM', index: 'GENERICNAM', width: 170, align: "left", sortable: false, hidden: false
                      },
                  {
                      name: 'DOSAGE', index: 'DOSAGE', width: 80, align: "left", sortable: false, hidden: false, editable: true
                  },
                   {
                       name: 'INTAKE', index: 'INTAKE', width: 100, align: "left", sortable: false, searchoptions: { clearSearch: false }, edittype: 'select', editable: true,
                       editoptions: {
                           value: load_Intake(),
                           defaultvalue: "--select--",
                           style: "width:88px;font-size: 12px;",
                           dataInit: function (e) {
                               jQuery("#tblGrid").setColProp("INTAKE", {
                                   editoptions: {
                                       value: load_Intake(),
                                   }
                               });
                           },
                           dataEvents: [{
                               type: 'change',
                               fn: function (e) {

                                   var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                   jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 7, true);
                               }
                           }]
                       }
                   },
                    {
                        name: 'INTAKECALC', index: 'INTAKECALC', width: 100, align: "left", sortable: false, hidden: true
                    },
                     {
                         name: 'DAYS', index: 'DAYS', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false, edittype: 'select', editable: true,
                         editoptions: {
                             value: load_Days(),
                             defaultvalue: "--select--",
                             style: "width:50px;font-size: 12px;",
                             dataInit: function (e) {
                                 jQuery("#tblGrid").setColProp("DAYS", {
                                     editoptions: {
                                         value: load_Days(),
                                     }
                                 });

                             },
                             dataEvents: [
                                {
                                    type: 'change',
                                    fn: function (e) {

                                        var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                        jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 8, true);//3/29/19

                                    }
                                }
                             ]
                         }
                     },
                    {
                        name: 'DURATION', index: 'DURATION', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false, edittype: 'select', editable: true,
                        editoptions: {
                            value: load_Duration(),
                            defaultvalue: "--select--",
                            style: "width:57px;font-size: 12px;",
                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("DURATION", {
                                    editoptions: {
                                        value: load_Duration(),
                                    }
                                });

                            },
                            dataEvents: [
                               {
                                   type: 'change',
                                   fn: function (e) {

                                       var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                       jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 9, true);//3/29/19

                                   }
                               }
                            ]
                        }
                    },
                    {
                        name: 'FOOD', index: 'FOOD', width: 80, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true,
                        editoptions: {
                            value: load_Food(),
                            defaultvalue: "--select--",

                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("FOOD", {
                                    editoptions: {
                                        value: load_Food(),
                                    }
                                });

                            },
                            dataEvents: [
                              {
                                  type: 'change',
                                  fn: function (e) {

                                      var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                      jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 10, true);//3/29/19


                                  }
                              }
                            ]
                        }
                    },
                     {
                         name: 'ROUTE', index: 'ROUTE', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                         editoptions: {
                             value: load_Route(),
                             defaultvalue: "--select--",
                             style: "width:140px;font-size: 12px;",
                             dataInit: function (e) {
                                 jQuery("#tblGrid").setColProp("ROUTE", {
                                     editoptions: {
                                         value: load_Route(),
                                     }
                                 });

                             },
                             dataEvents: [
                              {
                                  type: 'change',
                                  fn: function (e) {

                                      var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                      jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 11, true);//3/29/19


                                  }
                              }
                             ]
                         }
                     },
                    {
                        name: 'REMARK', index: 'REMARK', width: 150, align: "left", sortable: false, hidden: false, edittype: 'select', editable: true, formatter: 'select',
                        editoptions: {
                            value: load_Remarks(),
                            defaultvalue: "--select--",
                            style: "width:140px;font-size: 12px;",
                            dataInit: function (e) {
                                jQuery("#tblGrid").setColProp("REMARK", {
                                    editoptions: {
                                        value: load_Remarks(),
                                    }
                                });

                            },
                        }
                    },
                     {
                         name: 'GENERICID', index: 'GENERICID', width: 120, align: "left", sortable: false, hidden: true
                     },
                      {
                          name: 'DRUGFORM', index: 'DRUGFORM', width: 100,  sortable: false, align: 'left', editable: true,
                          editoptions: {
                              //value: load_DrugForms(),
                              //defaultvalue: "--select--",
                              //style: "width:95px;font-size: 12px;",
                              dataInit: function (el) {
                                //  var gridArrayData1 = [];
                                  var Arr = [];
                                  Arr = ["BILAYER CO", "CAP", "CHEWABLE T ", "COATED TAB", "CREAM", "DISPERTAB", "DR TAB", "EAR DROPS", "ENTERIC-CO", "ER CAP",
                                  "ER TAB", "EXTENTAB", "EYE DROPS", "EYE/EAR DR", "FILM-COATE", "GRANULES F", "INHALATION", "INJ", "MDI", "MODIFIED-R", "NASAL DROP",
                                  "NASAL SPRA", "OINT", "ORAL EMULS", "ORAL LIQD", "ORAL SOLN", "ORAL SUSP", "PENFILL", "POWD FOR I", "POWD FOR O",
                                  "PRE-FILLED", "SOFT-GELAT", "SOFTGEL", "SR CAP", "SR COATED", "SR TAB", "SR-FC TAB", "SUSP FOR I", "SYR", "TAB ", "TOPICAL GE", "VAG SUPP"]
                                  //$.each(Arr, function (k, key) {


                                  //    gridArrayData1.push({
                                  //        Text: key,
                                  //        Drug: key
                                          


                                  //    });
                                  //});
                                  $(el).autocomplete({
                                     
                                      minLength: 0,
                                      multiselect: true,
                                      source: Arr
                                     
                                    
                                  }).bind("focus", function () {
                                     
                                      $(this).autocomplete("search","");
                                  });




                                 

                              }
                             
                          }


                      },
                      
                ],

                rowNum: 9999999999,
                sortname: 'id',
                width: 870,//3/28/19
                //footerrow: true,
                height: 200,//3/28/19
                viewrecords: true,
                sortorder: "desc",
                loadtext: 'Loading...',
                loadonce: true,
                rownumbers: true,
                // toolbar: [true, "top"],
                shrinkToFit: false,
                cellEdit: true,
                cellsubmit: 'clientArray',
                ignoreCase: true,
                scrollrows: true,
                loadComplete: function () {
                    $("#tblGrid").css('font-size', '11.1px');
                    //var iCol = getColumnIndexByName($("#tblGrid"), 'act'); var inc = 0;
                    //$("#tblGrid").find(">tbody>tr.jqgrow>td:nth-child(" + (iCol + 1) + ")")
                    //             .each(function () {


                    //                         $("<div>", {
                    //                             title: "Remove",
                    //                             mouseover: function () {
                    //                                 $(this).addClass('ui-state-hover');
                    //                             },
                    //                             mouseout: function () {
                    //                                 $(this).removeClass('ui-state-hover');
                    //                             },
                    //                             click: function (e) {
                    //                                 l_orowId = $(e.target).closest("tr.jqgrow").attr("id");
                    //                                 var rowData = jQuery("#tblGrid").getRowData(l_orowId);

                    //                             }
                    //                         }
                    //                    ).css({ "margin-right": "5px", float: "left", cursor: "pointer" })
                    //                     .addClass("ui-pg-div ui-inline-custom")
                    //                     .append('<span class="ui-icon  ui-icon-cancel"></span>')
                    //                     .prependTo($(this));



                    //             });
                },
                gridComplete: function () {
                    $("#tblGrid").css('font-size', '12px');
                    // totbed = $("#gvBedOccup").jqGrid('getCol', 'TOTBED', false, 'sum');
                },
                ondblClickRow: function (rowId) {
                    //GetMedicineDetails(rowId);// commented by vijeta on 6th July 2018
                    var rowdat = $('#tblGrid').getRowData(rowId);// added by vijeta on 6th july 2018
                    var intakesList = IntakeREsult.Table == undefined ? IntakeREsult.Intake : IntakeREsult.Table;
                    var InTKNAME = rowdat["INTAKE"];
                    value = jQuery.grep(intakesList, function (n, i) {
                        return (n.INTAKE == InTKNAME);
                    });

                },
                onCellSelect: function (rowId, iCol, content, event) {
                    rows = $('#tblGrid')[0].rows;
                    var rowdat = $('#tblGrid').getRowData(rowId);

                    if (iCol == 1) {
                        $('#tblGrid').jqGrid('delRowData', rowId);
                        GetMaterialInteraction("");
                        $("ul#SrvcGrpdata"+RxListDiv+" input[value='" + rowId + "']").prop('checked', false);
                    }
                },
                afterEditCell: function (id, name, val, iRow, iCol) {

                    //if (name == 'DRUGFORM' ) {
                    //    $("#" + iRow + "_" + name).bind('keyup', function (e) {
                    //        var a = e.currentTarget.value.toUpperCase();
                    //        e.currentTarget.value = a;
                    //    });
                    //}
                  
                    $("#" + iRow + "_" + name).bind('blur', function () {
                        $('#tblGrid').saveCell(iRow, iCol);
                    });
                },
            }).trigger("reloadGrid");
            $("#tblGrid").jqGrid('bindKeys');
            $('.ui-jqgrid-sdiv').removeClass('ui-widget-content');
            //$('.ui-jqgrid-sdiv').addClass('AddFooterClass');
            jQuery('#tblGrid').closest('.ui-jqgrid-view')
        .find(".ui-jqgrid-htable .ui-search-toolbar .ui-th-column")
        .find("input, select")
        .focus(function (e) {
            var $header = $(e.target).closest('.ui-jqgrid-hdiv'),
                $body = $header.siblings('.ui-jqgrid-bdiv');
            setTimeout(function () {
                $body[0].scrollLeft = $header[0].scrollLeft;
            }, 0);
        });
        }

        function CancelImg(value, options, rowObject) {
            var flag = false;
            var radioHtml = "";
            radioHtml = '<span class="ui-icon ui-icon-cancel">Remove</span>';
            return radioHtml;
        }
        function load_Intake() {
            HoldOn.open();
            var s;
            $.ajax({
                url: '../DoctorDesk/GetMedicineInTake',
                data: {},
                type: 'get',
                datatype: 'json',
                async: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        IntakeREsult = JSON.parse(response);
                        s = ":--select--;";
                        for (i = 0; i < IntakeREsult.Intake.length; i++) {
                            s += IntakeREsult.Intake[i].CODE + ":" + IntakeREsult.Intake[i].INTAKE + ";";
                        }
                        s = s.substring(0, s.length - 1);
                    }


                }, complete: function () { HoldOn.close(); }
            });
            return s;
        }
        function load_Days() {
            var s;
            s = ":--select--;";
            for (i = 0; i <= 30; i++) {
                s += i + ":" + i + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }
        function load_DrugForms() {
            var s;
            s = ":--select--;";
            var Arr = [];
            Arr = ["BILAYER CO"," CAP","CHEWABLE T ","COATED TAB","CREAM","DISPERTAB","DR TAB"," EAR DROPS","ENTERIC-CO","ER CAP",   
            "ER TAB", "EXTENTAB", "EYE DROPS","EYE/EAR DR","FILM-COATE","GRANULES F","INHALATION","INJ","MDI","MODIFIED-R"," NASAL DROP",
            "NASAL SPRA","OINT","ORAL EMULS","ORAL LIQD","ORAL SOLN","ORAL SUSP","PENFILL","POWD FOR I" , "POWD FOR O",
            "PRE-FILLED","SOFT-GELAT","SOFTGEL","SR CAP","SR COATED","SR TAB","SR-FC TAB"," SUSP FOR I","SYR","TAB ","TOPICAL GE","VAG SUPP"]
            
            
            
            for (i = 0; i < Arr.length; i++) {
                s += Arr[i] + ":" + Arr[i] + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }
        function load_Duration() {
            var s;
            s = ":--select--;";
            s += "Days:Days;";
            s += "Weeks:Weeks;";
            s += "Months:Months;";
            s += "Years:Years;";

            s = s.substring(0, s.length - 1);
            return s;
        }
        function load_Food() {
            var s;
            s = ":--select--;";
            s += "After:After;";
            s += "Before:Before;";

            s = s.substring(0, s.length - 1);
            return s;
        }
        function load_Route() {
            if (RouteArray != "")//condition added vijeta 26/4/19
            {
                var route = JSON.parse(RouteArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
             
                var r = "";
                for (i = 0; i < route.length; i++) {
                    r += route[i].Value + ":" + route[i].Text + ";";
                }
                r = r.substring(0, r.length - 1);
                return r;
            }

        }
        function load_Remarks() {
            if (RemarkArray != "")//condition added vijeta 26/4/19
            {
                var arry = CommonForRemark;//vijeta 13/4/19
                //var arry = JSON.parse(RemarkArray);
                var s = " " + ":" + " " + ";";
                for (i = 0; i < arry.length; i++) {
                    s += arry[i].Value + ":" + arry[i].Text + ";";
                }
                s = s.substring(0, s.length - 1);
                return s;
            }

        }

        function NewIntake(location, obj) {
            $.confirm({
                title: '',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                theme: 'bootstrap',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Intake</label><br>' +
                '<input  type="varchar" id="txtNewIntake"  placeholder="Enter Intake Combination" autofocus="autofocus" class="setUp form-control" required />' +
                '</div>' +

                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var intake = $("#txtNewIntake").val();
                            $.ajax({
                                url: '../DoctorDesk/saveMedIntkCombintn',
                                type: 'post',
                                datatype: 'json',
                                data: { strMedIntkComb: intake },
                                success: function (response) {
                                    if ($("#txtNewIntake").val() == "" || $("#txtNewIntake").val() == null) {// 18-09-19

                                        $('#txtNewIntake').css({ 'border-color': 'Red' });
                                        return false;

                                    } else {
                                        $('#txtNewIntake').css({ 'border-color': '' });
                                    }
                                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        $.alert("Intake added successfully", "Information");

                                        ItakesArray.push(intake);//vijeta 30/3/19
                                        var selRowId = $('#tblGrid').jqGrid('getGridParam', 'selrow');
                                        $('#tblGrid').setCell(selRowId, 'INTAKE', intake);
                                        jQuery("#tblGrid").setColProp("INTAKE", {
                                            editoptions: {
                                                value: load_Intake(),
                                            }
                                        }).trigger("reloadGrid");//4/01/19 width chngd

                                        if (location == "Out")//added on 1/4/19
                                        {
                                            obj.currentTarget.previousSibling.value = intake;
                                        }
                                    }
                                    else {
                                        $.alert(response, "Information");
                                    }
                                }
                            });
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                        //close
                    }
                },
                onOpen: function () {
                    //$('jconfirm-box').css('width', '10% !important;');
                    $('.jconfirm-box').addClass('JsBoxCss');
                    $('jconfirm-buttons').css('border-top', 'none !important;');
                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    $('.jconfirm-box').addClass('JsBoxCss');
                    $('.jconfirm-buttons').css('border-top', 'none !important;');
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        //$(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-top', '20px');
                    })
                }


            })
        }

        function FillMasterSetupData(strSetUpCode) {
            HoldOn.open();
            $.ajax({
                url: "../Clinicalnotes/GetMasterSetUpData",
                datatype: "json",
                type: "get",
                async:false,
                data: { strSetUpCode: strSetUpCode },
                success: function (response) {
                    var e = $.Event("keypress", { which: 13 });
                    //setup data
                    if (response[0] != null) {
                        $("#MastersetupInput").val(response[0][0].NAME); //setup name
                        if (response[0][0].Gender == "M") //gender
                        {
                            //$("#maleradio").prop("checked", "checked");
                            $("#maleradio").trigger("click");

                        }
                        else if(response[0][0].Gender == "F") //gender
                        {
                            //$("#maleradio").prop("checked", "checked");
                            $("#femaleradio").trigger("click");

                        } else{
                            //$("#femaleradio").prop("checked", "checked");
                            $("#bothradio").trigger("click");
                        }
                        
                        $("#Agefromid").val(response[0][0].FromAge); //from age
                        $("#Agetoid").val(response[0][0].ToAge);      //to age
                        $("#SelSystolic").val(response[0][0].STATUS); //status
                        //$('select[id^="SelSystolic"] option[value="' + response[0][0].STATUS + '"]').attr("selected", "selected");
                    }

                    //RxData
                    if (response[1] != null) {


                        for (i = 0; i < response[1].length; i++) {

                            var newRow = "";

                            //if (response[i].NAME != "" && response[i].CODE != "" && response.NAME != null && response.CODE != null) {
                            newRow = {
                                //act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                //CODE: response.CODE,
                                //NAME: '<span class="fa fa-info-circle fa-2x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf" ></span> ' + response.NAME,
                                //DRUGFORM: response.Form,
                                //GENERICID: response.GenericCode,
                                //GENERICNAM: response.Generic,
                                //DOSAGE: dossage,
                                //SETUPCODE = row["CODE"].ToString().Trim(),
                                //NAME = row["DRUGNM"].ToString().Trim(),
                                //DOSAGE = row["Dossage"].ToString().Trim(),
                                //REMARK = row["Remarks"].ToString().Trim(),
                                //DAYS = row["Days"].ToString().Trim(),
                                //DURATION = GetDaysString(row["DURATION"].ToString().Trim()),
                                //GENERICID = row["GENERICID"].ToString().Trim(),
                                //GENERICNAM = row["GENERICNAME"].ToString().Trim(),
                                //ROUTE = row["ROUTE"].ToString().Trim(),//
                                //CODE = row["DRUGCD"].ToString().Trim(),
                                //FOOD = (row["ABFOOD"].ToString().Trim()) == "A" ? "After" : (row["ABFOOD"].ToString().Trim() == "E" ? "Before" : ""),
                                //INTAKE = row["INTAKEDESC"].ToString().Trim(),
                                //DRUGFORM = row["DRUGFORM"].ToString().Trim()  //Meenakshi


                                SETUPCODE: response[1][i].SETUPCODE.toString().trim(),
                                CODE: response[1][i].CODE.toString().trim(),
                                NAME: '<span class="fa fa-info-circle fa-1x medInfoSpan FromGrid" title="Medicine info" style="color:#4086bf" ></span> ' + response[1][i].NAME.toString().trim(),
                                INTAKE: response[1][i].INTAKE.toString().trim(),
                                DAYS: response[1][i].DAYS.toString().trim(),
                                DURATION: response[1][i].DURATION.toString().trim(),
                                FOOD: response[1][i].FOOD.toString().trim(),
                                DOSAGE: response[1][i].DOSAGE.toString().trim(),
                                REMARK: response[1][i].REMARK.toString().trim(),
                                GENERICID: response[1][i].GENERICID.toString().trim(),
                                GENERICNAM: response[1][i].GENERICNAM.toString().trim(),
                                DRUGFORM: response[1][i].DRUGFORM.toString().trim(),
                                ROUTE: response[1][i].ROUTE.toString().trim(),
                            };
                            //} else {
                            //    newRow = {
                            //        act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                            //        CODE: mtlrlcode,
                            //        NAME: mtlrlname,
                            //        //DRUGFORM: response.Form,
                            //        //GENERICID: response.GenericCode,
                            //        //GENERICNAM: response.Generic,
                            //    };

                            $('#tblGrid').addRowData(response[1][i].CODE.toString().trim(), newRow, 'last');

                            var ids = jQuery("#tblGrid").jqGrid('getDataIDs');
                            if (typeof newRow.DRUGFORM == "undefined" || newRow.DRUGFORM == "" || newRow.DRUGFORM == null) {
                                //jQuery("#tblGrid").jqGrid("editCell", 'last', 15, true);//3/29/19
                                jQuery("#tblGrid").jqGrid('setCell', ids[ids.length - 1], 'DRUGFORM', '', 'editable-cell');
                            } else {
                                jQuery("#tblGrid").jqGrid('setCell', ids[ids.length - 1], 'DRUGFORM', '', 'not-editable-cell');
                               

                                if (newRow.DRUGFORM == "TAB" || newRow.DRUGFORM == "SYP" || newRow.DRUGFORM == "CAP" || newRow.DRUGFORM == "FILM-COATE") {
                                    jQuery('#tblGrid').jqGrid('setCell', ids[ids.length - 1], 'ROUTE', '09');
                                } else if (newRow.DRUGFORM == "INJ" || newRow.DRUGFORM == "IV" || newRow.DRUGFORM == "CAP") {
                                    jQuery('#tblGrid').jqGrid('setCell', ids[ids.length - 1], 'ROUTE', '02');
                                }
                            }
                        }

                     //   $("#tblGrid").jqGrid('setGridParam', { data: response[1] }).trigger("reloadGrid");

                       // GetMaterialInteraction("");
                        $.each(response[1], function (i, item) {
                            var medCode = item.CODE.replace(/[^0-9a-zA-Z]/gi, '').trim();;
                            if ($("#SrvcGrpdata" + RxListDiv + " input[type='checkbox'][id=" + medCode + "]").length <= 0) {
                               // $("#SrvcGrpdata" + RxListDiv + " input[type='checkbox'][id=" + medCode + "]").prop("checked", "checked");
                                if ($("#div"+ RxListDiv + " input[type='checkbox']:checked").last().parents('li').length <= 0) {
                                    $(liElement).insertAfter($("#btn"+ RxListDiv));
                                }
                                else
                                var liElement = "<li><input type=checkbox id='" + item.CODE.trim().replace(/[^0-9a-zA-Z]/gi, '').trim(); + "' title='" + item.NAME.trim() + "' value='" + item.CODE.trim() + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + item.NAME.trim() + "</label><label id='genericId' style='display:none'>" + item.GENERICID.trim() + "</label><label id='genericName' style='display:none'>" + item.GENERICNAM + "</label><li>";
                                $(liElement).insertAfter($("#div" + RxListDiv + " input[type='checkbox']:checked").last().parents('li'));

                            }
                            $("#SrvcGrpdata" + RxListDiv + " input[type='checkbox'][id=" + medCode + "]").parent().show();
                            $("#SrvcGrpdata" + RxListDiv + " input[type='checkbox'][id=" + medCode + "]").prop("checked", "checked");

                        })
                    }

                    //investData
                    if (response[2] != null) {
                        

                        $.each(response[2], function (i, item) {
                            var invstCd = item.TESTCODE;
                            if ($("#SrvcGrpdataGetInvestigationList input[type='checkbox'][id=" + invstCd + "]").length <= 0) {
                              
                                var liElement = "<li><label><input type=checkbox id='" + invstCd.trim() + "' title='" + item.TESTNAME + "' value='" + item.TESTCODE.trim() + "'>" + item.TESTNAME + "</label></li>";
                                if ($("#divGetInvestigationList input[type='checkbox']:checked").last().parents('li').length <= 0) {
                                    $(liElement).insertAfter($("#btnGetInvestigationList"));
                                }
                                else

                                $(liElement).insertAfter($("#divGetInvestigationList input[type='checkbox']:checked").last().parents('li'));
                            }
                            $("#SrvcGrpdataGetInvestigationList input[type='checkbox'][id=" + invstCd + "]").parent().show();
                            $("#SrvcGrpdataGetInvestigationList input[type='checkbox'][id=" + invstCd + "]").trigger("click");

                        });
                    }

                    //patAdvData
                    if (response[3] != null) {
                        $.each(response[3], function (i, item) {
                            var patAdvCd = item.PATADVICECODE;
                            if ($("#SrvcGrpdataGetPatAdvList input[type='checkbox'][id=" + patAdvCd + "]").length <= 0) {
                           
                                var liElement = "<li><label><input type=checkbox id='" + patAdvCd.trim() + "' title='" + item.NAME + "' value='" + patAdvCd.trim() + "'>" + item.NAME + "</label></li>";

                                if ($("#divGetPatAdvList input[type='checkbox']:checked").last().parents('li').length <= 0) {
                                    $(liElement).insertAfter($("#btnGetPatAdvList"));
                                }
                                else

                                $(liElement).insertAfter($("#divGetPatAdvList input[type='checkbox']:checked").last().parents('li'));
                            }
                            $("#SrvcGrpdataGetPatAdvList input[type='checkbox'][id=" + patAdvCd + "]").parent().show();
                            $("#SrvcGrpdataGetPatAdvList input[type='checkbox'][id=" + patAdvCd + "]").trigger("click");
                        });
                    }

                    //diagnoData
                    if (response[4] != null) {

                        $.each(response[4], function (i, item) {
                            var dignoCode = item.DIAGNCD;
                            if ($("#SrvcGrpdataGetMainDiagnoList input[type='checkbox'][id=" + dignoCode + "]").length <= 0) {
                                var liElement = "<li><label><input type=checkbox id='" + dignoCode.trim() + "' title='" + item.NAME + "' value='" + dignoCode.trim() + "'>" + item.NAME + "</label></li>";

                                if ($("#divGetMainDiagnoList input[type='checkbox']:checked").last().parents('li').length <= 0) {
                                    $(liElement).insertAfter($("#btnGetMainDiagnoList"));
                                }
                                else
                                $(liElement).insertAfter($("#divGetMainDiagnoList input[type='checkbox']:checked").last().parents('li'));
                            }
                            $("#SrvcGrpdataGetMainDiagnoList input[type='checkbox'][id=" + dignoCode + "]").parent().show();
                            $("#SrvcGrpdataGetMainDiagnoList input[type='checkbox'][id=" + dignoCode + "]").trigger("click");
                        })
                    }

                    //complaints data
                    if (response[5] != null) {

                        $('#txtServiceGrpGetMainCompList').val("");
                       
                        $('#txtServiceGrpGetMainCompList').trigger(e);

                       


                        $.each(response[5], function (i, item) {
                            var cmplntCode = item.CMPLNTCODE;
                            if ($("#SrvcGrpdataGetMainCompList input[type='checkbox'][id=" + cmplntCode.trim() + "]").length <= 0){
                                var liElement = "<li><label><input type=checkbox id='" + cmplntCode.trim() + "' title='" + item.NAME + "' value='" + cmplntCode.trim() + "'>" + item.NAME + "</label></li>";

                                if ($("#divGetMainCompList input[type='checkbox']:checked").last().parents('li').length <= 0) {
                                    $(liElement).insertAfter($("#btnGetMainCompList"));
                                }
                                    else
                                $(liElement).insertAfter($("#divGetMainCompList input[type='checkbox']:checked").last().parents('li'));
                               
                            }
                            $("#SrvcGrpdataGetMainCompList input[type='checkbox'][id=" + cmplntCode.trim() + "]").parent().show();
                            $("#SrvcGrpdataGetMainCompList input[type='checkbox'][id=" + cmplntCode.trim() + "]").trigger("click");
                        })
                    }
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    GetMaterialInteraction("");
                },
            })
            HoldOn.close();

          //  $('html, body').animate({ scrollTop: $('#searchdivclass').position().top }, 'slow');
        }

        function CreatePersonalizedList() {
            var strAge = "";
            //var strAge = ($.session.get('PatAge2') == undefined || $.session.get('PatAge2') == null) ? "" : $.session.get('PatAge2').toString();
            HoldOn.open();
            $.ajax({
                type: "POST",
                <%--  url: "<%=Url.Action("GetMasterSetUpList","Clinicalnotes")%>",--%>
                url: "../Clinicalnotes/GetMasterSetUpList",
                data: { strAge: strAge, strCimsYN: mscimsYN },
                 async: false,
                 success: function (response) {
                     if (response != "" && response.toUpperCase() != "UNSUCCESSFULL") {
                         var result = JSON.parse(response)
                         var rows = "";
                         for (i = 0; i < result.Table1.length; i++) {
                             var rowClass = "";

                             if (result.Table1[i].STATUS == "I")
                                 rowClass = "inactiveSetUp";

                             rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "' class='" + rowClass + "' >" + "<td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle;width:70%' ><b>" + $.trim(result.Table1[i].NAME) + "</b></td>"
                                 + "<td style='font-size:13px;width:15%;vertical-align:middle;'>" + result.Table1[i].GENDER + "</td><td style='font-size:13px;width:15%;vertical-align:middle;'>" + result.Table1[i].FROMAGE + " - " + result.Table1[i].TOAGE + "</td>";
                             // "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='MasterSetUpAddEdit(this);'></i></span></td>"

                             rows += "</tr>";
                         }
                         $('#tblMasterSetUplist tbody').empty();
                         $('#tblMasterSetUplist tbody').append(rows).closest('tr');
                     }

                 }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                     $.messager.alert("Error", errorThrown);
                 },
                 complete: function () {
                     HoldOn.close();
                 },

             });
         }

         $(document.body).on("click", "#tblMasterSetUplist tr", function (e) {
             $("#tblGrid").jqGrid("clearGridData");// 18-9-19
             $('input:checkbox').removeAttr('checked');
             //.......................................
             //for (i = 0; i < dataal.length; i++) {
             //    $('#txtServiceGrp' + dataal[i]).val("");
             //    e.preventDefault();
             //    var e = $.Event("keypress", { which: 13 });
             //    $('#txtServiceGrp' + dataal[i]).trigger(e);
             //}

           
             //......................................
             $("#tblMasterSetUplist tr").removeClass("tblMasterSetUpTrCls");
             $(this).addClass("tblMasterSetUpTrCls");
             SetUpCode = $(this)[0].id; //assign strCode to global variable
             FillMasterSetupData($(this)[0].id);
             


             var container = $('#divGetMainCompList');
        //     var top = $("#divSrvcGrpGetMainCompList").position().top,
        //currentScroll = container.scrollTop();

        //     container.animate({
        //         scrollTop: currentScroll - top
        //     }, 1000);
            
             $('.searchdivclass').animate({
                 scrollTop: 0
             }, 'slow');
         });

         function ClearFormControls() {
             SetUpCode = "";//global variable setupCode set to empty
             $("input[type='text']").val("");
             $("input[type='number']").val("");
             $("input[type='checkbox']").removeAttr('checked', 'checked');
             $("#tblGrid").jqGrid("clearGridData");
             $("#bothradio").trigger("click");
             //$("#bothradio").prop("checked", true);
             //$('#bothradio').attr('checked', true);
             //$("#bothradio").trigger("click");
         }
     </script>
</asp:Content>
