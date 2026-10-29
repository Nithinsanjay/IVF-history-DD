<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.IPInvestigation>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <%--<di>v
        <input style="width: 100%; background-color: #ecf0f5; margin-left: -17px; margin-top: -22px; position: fixed;" class="empty">
    </div>--%>
        <div id="MainDiv">
           <%-- //...................................................--%>
            <div class="row" style="margin-left: 0px !important;margin-right: 0px !important">
       
   
      
     
  
      <table style="width: 85.5%;margin: 1% 0 1% 0;" id="infotab"><!--kavita-->
                <tr>
                    <td colspan="2" style="width:50%">
                        <label style="width: 21.5%; display: inline-block;">Provisional Diagnosis</label>
                       
                        <%=Html.TextAreaFor(x => Model.ProvDiagno, new { id = "txtProvDiagno", @class = "TextBxFormat", maxlength = "1000", Style = "width: 65%;height:30px;vertical-align: middle;",@rows = "5",@readonly="True"})%></td>
                    <td colspan="2">
                        <label style=" display: inline-block;width: 30%;">Allergies</label>
                        
                        <%: Html.TextAreaFor(x => Model.Allergies, new { id = "txtAllergies", @class = "TextBxFormat", maxlength = "1000", Style = "width: 62%;height:30px;vertical-align: middle;",@rows = "5" ,@readonly="True"})%>
                    </td>
                  <%--  vishal 16th Nov--%>
                     <td>                    <%--<input type="button" id="btnCancelShwHide" class="Nbutton" value ="" />--%>
                       
                         <%-- <button id="btnSearch" class="btn btn-primary" style="background-color: #337ab7; border-color: #2e6da4;"><i class="fa fa-search" aria-hidden="true"></i></button>
                   --%>
                          <input type="button" id="btnCancelShwHide" class="btn btn-primary" value ="" style="background-color: #337ab7; border-color: #2e6da4;"/>
                       
                          </td>
                </tr>
         <%-- ---------------------------------------------------------------------%>

           <tr>
                    <td colspan="2">
                                        <label style="width: 22%; display: inline-block;">Nurtrition / Intake</label><%: Html.DropDownListFor(x => Model.NutriIntake,new SelectList(Model.NutritionList, "Value", "Text"),"-----Select-----", new { id = "cmbNutriIntake", @class = "TextBxFormat Mandatory", Style = "width: 65%;height:30px;border-right: 3px solid #ed1001;" ,maxlength="100"})%>
                                   
                                         </td>
                                    <td colspan="3">
                                         <label style="width: 23%; display: inline-block;vertical-align: text-bottom;">Volume / Supplements</label><%: Html.TextAreaFor(x => Model.VolSupplmnt, new { id = "txtVolSupplmnt", @class = "TextBxFormat Mandatory", Style = "width: 47%;height:30px;border-right: 3px solid #ed1001;" ,maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                    
                                         </td>
                </tr>
          <tr>
               <td colspan="5">
                                        <label style="width: 11%;display: inline-block;vertical-align: text-bottom;">Remark</label><%: Html.TextAreaFor(x => Model.DocRemarks, new { id = "txtDocRemarks", @class = "TextBxFormat", Style = "width: 74%;height:30px",maxlength="100",onkeyup="this.value = this.value.toUpperCase();"})%>
                                   
                                         </td>
          </tr>
          <%-----------------------------------------------------------------------------%>

            <tr>
                            <td colspan="5">
                            <input type="text" id="InvestigationInput" onkeyup="SearchInvestigation()" placeholder="&#xF002; Search Investigation" style="width: 85.5%; height: 28px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181);" class="empty">
                           </td>

                        </tr>

            </table>
        </div>

           <%-- //...........................................................--%>
            <div id="ContentHolderDiv" class="contentHoldClass" style="width:100%">
             
               <%-- <div class="StuckInput" style="margin-top: -10px;margin-left:3%">--%>
                  <%--  <table style="width: 73%;margin: 1% 0 1% 0;">
                <tr>
                    <td style="width:50%">
                        <label style=" display: inline-block;">Provisional Diagnosis</label>
                       
                        <%=Html.TextAreaFor(x => Model.ProvDiagno, new { id = "txtProvDiagno", @class = "TextBxFormat", maxlength = "1000", Style = "width:76%;height:30px;vertical-align: middle;",@rows = "5",@readonly="True"})%></td>
                    <td>
                        <label style=" display: inline-block;">Allergies</label>
                        
                        <%: Html.TextAreaFor(x => Model.Allergies, new { id = "txtAllergies", @class = "TextBxFormat", maxlength = "1000", Style = "width:89%;height:30px;vertical-align: middle;",@rows = "5" ,@readonly="True"})%>
                    </td>
               
                </tr>
                        <tr>
                            <td colspan="2">
                            <input type="text" id="InvestigationInput" onkeyup="SearchInvestigation()" placeholder="&#xF002; Search Investigation" style=" height: 28px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 1%;" class="empty">
                           </td>

                        </tr>
            </table>--%>
                    
                   
                  <%-- <input type="text" id="InvestigationInput" onkeyup="SearchInvestigation()" placeholder="&#xF002; Search Investigation" style=" height: 28px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">

                    <label id="PersMedi" style="background-color: transparent;border-color: transparent;" title="Save" onclick="CreatePersonalList()" class="PersBtn">
                        <button type="button" class="btn btn-info margin" style="position: fixed; padding: 2px 12px; font-size: 14px; margin-left: 0px; margin-top: -16px;">Pers...</button>
                    </label>
                    
                     <button id='freeHandBtn' style="border-radius: 50%;height: 28px;width: 28px;color: white;margin-top: 3px;background-color: #398ebd;border-color: transparent; outline-style: none;margin-left:63px;vertical-align: super;" title="Save Free Complaint"><span><i class="fa fa-pencil"></i></span></button>
              --%>
                     
                    
                     <%-- </div>--%>
              

                <label id="btnSave" style="background-color: transparent; float: right; margin-right: 25%; border-color: transparent;" title="Save">
                    <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                </label>

              <div id="wrapper" style="overflow: hidden;width: 75%;">
                    <div class="tableDiv">
                         <table class="HeadPatTab" style="text-align:center"><thead> 
                             <tr style="background-color:#fffdc8;font-size:12px">
                                  <th style="width:5%;"></th>
                                 <th style="width: 30%;">Investigation</th>
                                 <th style="text-align:center;width:10%" >ProposedDate</th>
                                 <th style="width: 10%;">ProposedTime</th>
                                  <th style="width: 5%;">Select</th>
                               <%--   <th style="width: 65%;">TestCode</th>
                                  <th style="width: 65%;">TypeCode</th>
                                  <th style="width: 65%;">SQNumber</th>
                                  <th style="width: 65%;">Status</th>
                                  <th style="width: 65%;">ADMINYN</th>--%>
                                  <th style="width: 30%;">Remark</th>
                                 <th style="width: 9%;">OrderedBy</th>
                                 
                                 <%-- <th style="width: 65%;">OrderDate</th>
                                  <th style="width: 65%;">OrderTime</th>
                                  <th style="width: 65%;">Cancel BY</th>
                                  <th style="width: 65%;">Cancel DT</th>
                                 <th class='HeadRemark'>Cancel TM</th>--%>
                             </tr>
                                                    </thead>
                        
                        </table><%-- 4/22/19--%>
                        <table id="tblinvestigate" class="table  HeadPatTab" style="width: 100%">
                          <tbody id="tblsort" style="height:100%"></tbody><%--tblsort added vijeta 19/4/19--%>
                        </table>
                    </div>
                </div>

                <div id="layer-demo" class="po__layer list">
                    <%--<a href="javascript:;">0</a>   --%>
                </div>
                <div id="layer-DMY" class="po__layer list">
                    <a href="javascript:;" onclick="SetText('D')" style='font-weight: 500; font-size: 16px'>Days</a>
                    <a href="javascript:; " onclick="SetText('W')" style="font-weight: 500; font-size: 16px">Weeks</a>
                    <a href="javascript:; " onclick="SetText('M')" style='font-weight: 500; font-size: 16px'>Months</a>
                    <a href="javascript:;" onclick="SetText('Y')" style='font-weight: 500; font-size: 16px'>Years</a>
                </div>
            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        /*vijeta 29/03/19*/
        .invsAddspan{
               float: right;
        margin-right: 6px;
        margin-top: -28px;
        position: relative;
        z-index: 2;
        color: #3d7da3;
        cursor:pointer;
        }

        table {
            width: 100%;
        }
        thead, tbody, tr, td, th {
        }

            tr:after {
                content: ' ';
                display: block;
                visibility: hidden;
                clear: both;
            }

            thead th {
                height: 30px;
                text-align: left;
            }

        tbody {
            height: 260px;
            overflow-y: auto;
        }

        .StuckInput {
            width: 100%;
            position: fixed;
        }
        /*.InputWrapper {
    height: 100%;
   
}*/

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-decoration: inherit;
             font-size: 16px !important; /*added by vijeta on 31st march 2018*/
        }



        .spinner {
            width: 100px;
        }

            .spinner input {
                text-align: right;
            }

        .input-group-btn-vertical {
            position: relative;
            white-space: nowrap;
            width: 1%;
            vertical-align: middle;
            display: table-cell;
        }
            .input-group-btn-vertical > .btn {
                display: block;
                float: none;
                width: 100%;
                max-width: 100%;
                padding: 8px;
                margin-left: -1px;
                position: relative;
                border-radius: 0;
            }

                .input-group-btn-vertical > .btn:first-child {
                    border-top-right-radius: 4px;
                }

                .input-group-btn-vertical > .btn:last-child {
                    margin-top: -2px;
                    border-bottom-right-radius: 4px;
                }

            .input-group-btn-vertical i {
                position: absolute;
                top: 0;
                left: 4px;
            }

        a:hover {
            color: #555;
        }

        Label {
            margin-left: 5px;
        }


        #tblPersInvestigationlist > tbody > tr > td {
            border-top: 1px solid rgba(234, 228, 228, 0.32) !important;
        }

        /* added by vijeta on 2nd may 2018*/
       .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
            font-size: small; /*added by vijeta on 22nd sep 2018*/
        }

        @media only screen and (min-width : 992px) {
            .divtblInvestigation {
                height: 500px !important;
                overflow-y: hidden !important;
            }

                .divtblInvestigation:hover {
                    overflow-y: scroll !important;
                    transition-duration: 0.4s;
                    transition-timing-function: cubic-bezier(0.36, 0.55, 0.19, 1);
                }
        }



        .divtblInvestigation {
            height: 300px;
            overflow-y: scroll;
        }

        div.divtblInvestigation::-webkit-scrollbar {
            width: 7px;
        }

        div.divtblInvestigation::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblInvestigation::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

        div.divtblInvestigation:hover {
            overflow-y: scroll;
        }

         #tblinvestigate tr td:not(:first-child) {
            width: 10%;
            text-align:center;
        }
         #tblinvestigate tr td:not(:first-child) a{
            width: 98%;
            display:block;
        }
          @media (min-width: 992px) {
             .jconfirm-box-container {
                margin-left: 25.333333%;
            }
        }/*//3/28/19*/
        @media only screen and (min-width: 1400px) {
            .jc-bs3-row {
                margin-left: -6px;
            }
        }
        /*//3/28/19*/
          .HeadRemark {
    width: 15.8%;
}
        .empty{
            width: 100%;
        }

        @media only screen and (min-device-width : 1024px)and (max-device-width : 1152px){/*//*/

             .HeadRemark{
 width:16.2%;
        }


             .tableDiv{
                 padding-top:10% !important;
             }
              .empty{
           width: 94.5%;
       }
              .StuckInput table {
            width: 95% !important;
            position: fixed;
        }
        }
       .Headdur {
    width: 19.98%;
}
        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {/*//*/
       .empty{
           width: 65%;
       }
      .duration{
          width:12% !important;
      }
      day-td{
           width:12% !important;
      }
      .HeadRemark {
  width: 16.7%;
}
      .Headdur{
            width:22.3%
        }
      .HeadPatTab > thead > tr > th {
    text-align: center;
    border: 1px solid #ede4e4;
    height: 22px;
    font-size: 10px;
}
        }

         .HeadPatTab > thead > tr > th {
    text-align: center;
    border: 1px solid #af3131;
    height: 22px;
    font-size: 12px;
}
          .table > tbody > tr.active > td:not(.MaterialName):not(.tdRemark){   /*:not added vijeta 10/4/19*/
     border-left:1px solid #bbbbbb;
     /*padding:0px;*/
     padding-left: 0px;
    padding-right: 0px;
    padding-top: 3px;
    padding-bottom: 0px;
     text-align: center;
    vertical-align: middle;
 } /**/
    .table > tbody > tr.Canceled > td:not(.MaterialName):not(.tdRemark){   /*:not added vijeta 10/4/19*/
     border-left:1px solid #bbbbbb;
     /*padding:0px;*/
     padding-left: 0px;
    padding-right: 0px;
    padding-top: 3px;
    padding-bottom: 0px;
     text-align: center;
    vertical-align: middle;
 } /**/
     
     @media only screen and (max-width : 1024px) {
             
              .tabcontainer {
                  margin-left: -3px;
              }
             #wrapper{
                 width:95% !important;
             }

          }  
     
         @media only screen and (max-width : 1024px) {
             .content-wrapper {
                 margin-left: 0px !important;
             }
         }

 .Canceled{
              background: #f9af8e !important;
           }

    
    </style>
    <%-- <script src="../plugins/alert/jquery-confirm.js"></script>
    <link href="../plugins/alert/jquery-confirm.css" rel="stylesheet">--%>
    <script src="../Scripts/ipInvstAndMed.js"></script>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <link href="../css/timedropper.css" rel="stylesheet" />
    <script src="../js/timedropper.js"></script>
    <%--<script src="../Scripts/PatList.js"></script>--%>
      <script src="../Scripts/ICUPatList.js"></script>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var idOfDMY = "";
        var todayfor = "";
        var MaxForInvestArray = [];
        // var freeHandInvestigation = "";//vijeta 20th march 19
        //GetSetUpList("Investigation");//added on 4th oct 2018
        //AddClinics(urls); //commented by vijeta 30/4/19
        var srvcgrpname = "dblServiceHelpsrvcgrp"; //added on 2nd may  2018
        $(document).ready(function (e) {


          //  ActiveMenu("Referrals");
            load_Doctor();
            //  SetDateTime();
            GetNursStationsNPAtients();
            $("#tabMenu").css("display", "block");
           // HoldOn.open();//
            SetPatientDtl();
           // document.getElementById('InvestigationInput').focus();    //added by kavita

            //AddInvestigation();

            
            if ($(window).width() >= 996) {
                //screen width size comparion

                if ($(window).width() >= 1025) {
                    var menuL = document.getElementById('menuList');
                    menuL.style.display = "block";

                }
             

                var dispLst = document.getElementById('sideList');
                //kavita 12-aug-2019
                // dispLst.style.display = "block";  
                $("#slide_sdList").click();

                //$("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                $("#PatAdviceSetUpList").css("display", "block");// added by vijeta on 4th oct 2018
             
                //kavita 10-aug-2019
                var tblheadHeight = $("#PatAdviceSetUpList").height();
                var menulistheight = $("#menuList").height();
                $('#divMenuList').css("height", (menulistheight - (tblheadHeight + 7)) + "px");
                //kavita 10-aug-2019
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }

            for (var i = 0; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc' style='font-weight:500;font-size:16px'>" + i + "</a>";
                $("#layer-demo").append(s);
            }

            $('.trigger1').po({
                alignment: 'center'
            });
            $('.trigger2').po({
                alignment: 'center'
            });



            $("#layer-demo .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
            });

            $("#btnSave").click(function () {
                SaveInvestigations("N");
            });

            $('#txtComplaintRemark').keydown(function (e) {

                var k = String.fromCharCode(e.which);

                if (k.match(/[^-]/g))
                    e.preventDefault();
            });

            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys

            $(document.body).on('click', '#tblinvestigate td a,#tblinvestigate td', function (e) {
                if (!$(this).is('.InvestNm'))
                    e.stopPropagation();
            });

            //vijeta 18th march 19
            $("#freeHandBtn").click(function () {
                var Mrno = ($.session.get('PatMRNO'));
                var strTran = ($.session.get('PatTRANNO'))
                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formFreeText" >' +
                    '<div class="form-group">' +
                    '<label>Free Investigation</label>' +
                    '<textarea id="txtFreeInvestigation" maxlength="500"  placeholder="Investigation" autofocus="autofocus" class="complaint form-control" required rows="5" cols="30" />' +
                    //'<input  type="varchar" id="txtFreeComplaint" maxlength="50"  placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required />' +
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var invs = this.$content.find('.complaint').val();

                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'AddFreeInvestigation',
                                    data: { strInvestigation: invs, strTran: strTran, strMrNo: Mrno },
                                    success: function (response) {

                                        if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                                            $.messager.alert("Information", "Record Not Inserted.");
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                            var jc = this;

                                            $.messager.alert("Information", "This complaint is already Present.");
                                        }
                                        else {
                                            $("#txtFreeInvestigation").val(invs);
                                            freeHandInvestigation = invs;

                                            if (invs != "") {
                                                $.messager.alert("Information", "Record inserted successfully");
                                                $("#freeHandBtn").css("background-color", "green");
                                            }
                                            else {
                                                $.messager.alert("Information", "free Investigation removed");
                                                $("#freeHandBtn").css("background-color", "#398ebd");
                                            }

                                        }
                                    },

                                });
                                // }

                            }
                        },
                        clear: function () {
                            $("#txtFreeInvestigation").val("");
                            $('.formFreeText').submit();
                        },
                        cancel: function () {
                            //close
                            //$('.FoodItems input:checked').focus();
                        },
                    },
                    onContentReady: function () {
                        $('#txtFreeInvestigation').focus();
                        $('#txtFreeInvestigation').val(freeHandInvestigation);
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

            //vijeta 30/03/19
            $(document.body).on("click", "#spanAddNewInvtInSetUp", function (e) {
                $.confirm({
                    title: '',
                    closeIcon: true,
                    offsetTop: 10,
                    type: 'orange',
                    backgroundDismissAnimation: 'glow',
                    theme: 'bootstrap',
                    content: '' +
                    '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Investigation</label><br>' +
                    '<input  type="varchar" id="txtNewMInvst"  placeholder="Enter Text" autofocus="autofocus" class="setUp form-control" required />' +
                    '</div>' +

                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var invstName = $("#txtNewMInvst").val();
                                //freeHandInvestigation = freeHandInvestigation + " " + invstName;
                                //$("#freeHandBtn").css("background-color", "green");
                                //$("#txtFreeInvestigation").val(freeHandInvestigation);
                                var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + invstName + "' value='" + "" + "' checked />" + "<label style='vertical-align:middle'>" + invstName + "</label></label><li>";
                                $(elemnet).insertAfter('a[id="btnsrvgrp"]');
                                $(elemnet).focus();
                                $("#dblServiceHelpsrvcgrp").show();
                                $("#divSrvcGrpGrid").show();
                            }
                        },
                        Closed: {
                            text: 'Cancel'
                            //close
                        }
                    }

                });
            });

            todayfor = new Date();
            var dd = todayfor.getDate();
            var mm = todayfor.getMonth() + 1;
            var yyyy = todayfor.getFullYear();
            if (dd < 10) {
                dd = '0' + dd
            }
            if (mm < 10) {
                mm = '0' + mm
            }
            todayfor = dd + '/' + mm + '/' + yyyy;
            $(".triggerInputSDate").val(todayfor);


            $(".triggerInputSDate").datepicker(
                        {
                            showButtonPanel: true,
                            changeMonth: true,
                            yearRange: "c-150:c+99",
                            changeYear: true,
                            dateFormat: "dd/mm/yy",
                            maxDate: new Date(),
                            // minDate: admissiondate
                        });
            ActiveMenu("IPInvestigation1");
            GetTreat();

            if (resultofal.hasOwnProperty("jsonStatOrderData"))
            SetGridDataInvestigation(resultofal);
        });
        function SetGridDataInvestigation(result) {

            var rows = "";

            var result1 = result.jsonTestData;
            if (result1.length > 0) {
                result1.sort(function (a, b) {
                    return parseFloat(a.SEQNO) - parseFloat(b.SEQNO);
                });
            }
          
            
            $('#tblinvestigate tbody').empty();
           
            $.each(result1, function (i, item) {

           
                  var Bindstr = "Binding";
               
                  //  var rows = "<tr class='clickable-row" + ' CN' + "' id='" + item.TestCode.trim() + "' >" + "<td style='padding:5px; width:40%;text-align:left;font-size: 14px;' class='InvestNm'>" + item.Test.trim() + "</td>" +
                      
                  //      "<td class='tdSDate' style='width:10%'><input type='text'class='triggerInputSDate form-control'   style='display:none;font-size: 12px'  id='SDate" + item.TestCode.trim() + "' /></td>" +
                  //      "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.TestCode.trim() + "' style='display:none;font-weight:800;font-size:16px'>0</a></td>" +

                  //      "<td class='tdOmit' style='width:5%'><input type='checkbox' style='display:none' id='Omit" + item.TestCode.trim() + "' value='N' class='triggerInputOmit checkboxomit' /></td>" +
                  //   "<td class='investigationRemark' style='width:25%;'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddInvestigationRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                  //   "<td class='OrderBy' style='width:10%;vertical-align: initial;color: #337ab7;'>" + item.ORDERBY.trim() + "</td>" +
                  //+ "<td class='tdTestCode' style='display:none'>" + item.TestCode + "</td>" +
                  // "<td class='tdTypeCode' style='display:none'>" + item.TypeCode + "</td>" +
                  //"<td class='tdSequenceNo' style='display:none'>" + item.SEQNO + "</td>" +
                  // "<td class='tdStatus' style='display:none'>" + item.STATUS + "</td>" +
                  // "<td class='tdADMINYN' style='display:none'>" + item.CNT + "</td>" +
                  //"<td class='tdCancelBY' style='display:none'>" + item.CancelBY + "</td>" +
                  // "<td class='tdCancelDT' style='display:none'>" + item.CancelDT + "</td>" +
                  //  "<td class='tdCancelTM' style='display:none'>" + item.CancelTM + "</td>" +

                  //  "</tr>";
                  //  $('#tblinvestigate tbody').append(rows);

                MaxForInvestArray.push(Number(item.SEQNO.trim()));
                //************************************************************
                   // if (data[0] != null) {
                        //for (var i = 0; i < data[0].length; i++) {
                            flagCheckRowsInvst = true;
                            row = $('#tblinvestigate tr#' + item.TestCode.trim());

                           // var durType = (item.OrderDate.trim() != "") ? item.OrderDate.trim() : "";
                           // var durNum = (item.OrderTime.trim() != "") ? item.OrderTime.trim() : "";
                            var Cancelspan = "<span class='ui-icon ui-icon-cancel' style='' onclick = 'CancellFun(this)'></span>"
                            //if (row.length > 0) {


                            //    //var rowdy = $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.day-td')[0];
                            //    //var rowdur = $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.duration')[0];
                            //    if (item.STATUS.trim() == "C") {
                                    
                            //        $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdCancel')[0].innerHTML = "";
                            //    } else {
                            //        $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdCancel')[0].innerHTML = Cancelspan;
                            //    }
                                
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdSDate')[0].innerHTML = "<input type='text' class='triggerInputSDate form-control'  style='display:none;' value='" + item.OrderDate.trim() + "' id='SDate" + item.TestCode.trim() + "' />";
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdStime')[0].innerHTML = "<input type='text' class='triggerInputStime form-control'  style='display:none;' value='" + item.OrderTime.trim() + "' id='Stime" + item.TestCode.trim() + "' />";
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.investigationRemark')[0].innerHTML = "<i class='fa fa-pencil fa-2x' aria-hidden='true' style='float: left;margin: 1% 2% 0% 2%;display:none'></i><input type='text' class='triggerInputStime form-control'  style='display:none;width: 90%;' value='" + item.REMARKS.toString().trim() + "' id='Remark" + item.TestCode.trim() + "' />";

                              
                            //    //var colRemark = "<td class='RemarkText' style='display:none;width:30%'>" + item.REMARKS.toString().trim() + "</td>"; // added by vijeta on 30th march 2018
                            //    //$('#tblinvestigate tr#' + item.TestCode.trim()).append(colRemark);// added by vijeta on 30th march 2018

                            //    //if (item.REMARKS.toString().trim() != "") {
                            //    //    var investigationWithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + item.REMARKS.toString().trim() + '</span>'// added by vijeta on 30th march 2018
                            //    //    $('#tblinvestigate tr#' + item.TestCode.trim()).find('td:nth-child(1)').append(investigationWithRemark);// added by vijeta on 30th march 2018
                            //    //}

                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.OrderBy')[0].innerHTML = item.ORDERBY.trim(); //added on 25th July 2019
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdTestCode')[0].innerHTML = item.TestCode.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdTypeCode')[0].innerHTML = item.TypeCode.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdSequenceNo')[0].innerHTML = item.SEQNO.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdStatus')[0].innerHTML = item.STATUS.trim();
                            //    //$('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdADMINYN')[0].innerHTML = item.CNT.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdCancelBY')[0].innerHTML = item.CancelBY.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdCancelDT')[0].innerHTML = item.CancelDT.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdCancelTM')[0].innerHTML = item.CancelTM.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.OrderDate')[0].innerHTML = item.ORDERBY.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.OrderTM')[0].innerHTML = item.ORDERBY.trim();
                            //    $('#tblinvestigate tr#' + item.TestCode.trim() + ' td.tdTempBind')[0].innerHTML = Bindstr;
                            //    $('#tblinvestigate tr#' + item.TestCode.trim()).trigger('click');


                            //}

                           // else {

                                if (item.STATUS.trim() == "C") {
                                    Cancelspan = "";
                                }

                                var rows = "<tr class='clickable-row" + ' CN' + "' id='" + item.TestCode.trim() + "' >" + "<td style='padding:5px; width:5%;text-align:left;font-size: 14px;' class='tdCancel'>" + Cancelspan + "</td>" + "<td style='width:30%;text-align:left;font-size: 14px;' class='InvestNm'>" + item.Test.trim() + "</td>" +

                        "<td class='tdSDate' style='width:10%'><input type='text'class='triggerInputSDate form-control'   style='display:none;font-size: 12px'  id='SDate" + item.TestCode.trim() + "' value=" + item.OrderDate.trim() + " /></td>" +
                           "<td class='tdStime' style='width:10%'><input type='text'class='triggerInputStime form-control'   style='display:none;font-size: 12px'  id='Stime" + item.TestCode.trim() + "' value=" + item.OrderTime.trim() + " /></td>" +

                        "<td class='tdOmit' style='width:5%'><input type='checkbox' style='display:none' id='Omit" + item.TestCode.trim() + "' value='N' class='triggerInputOmit checkboxomit' /></td>" +
                    // "<td class='investigationRemark' style='width:30%;'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddInvestigationRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                      "<td class='investigationRemark' style='width:30%'><i class='fa fa-pencil fa-2x' style='float: left;margin: 1% 2% 0% 2%;display:none' aria-hidden='true'></i><input type='text'class='triggerInputRemark form-control'   style='display:none;font-size: 12px;width: 88%;'  id='Remark" + item.TestCode.trim() + "' value=" + item.REMARKS.toString().trim() + " /></td>" +



                     "<td class='OrderBy' style='width:10%;vertical-align: initial;color: #337ab7;'>" + item.ORDERBY.trim() + "</td>" +
                  "<td class='tdTestCode' style='display:none'>" + item.TestCode + "</td>" +
                   "<td class='tdTypeCode' style='display:none'>" + item.TypeCode + "</td>" +
                  "<td class='tdSequenceNo' style='display:none'>" + item.SEQNO + "</td>" +
                   "<td class='tdStatus' style='display:none'>" + item.STATUS + "</td>" +
                   //"<td class='tdADMINYN' style='display:none'>" + item.CNT + "</td>" +
                  "<td class='tdCancelBY' style='display:none'>" + item.CancelBY + "</td>" +
                   "<td class='tdCancelDT' style='display:none'>" + item.CancelDT + "</td>" +
                    "<td class='tdCancelTM' style='display:none'>" + item.CancelTM + "</td>" +
                     "<td class='OrderDate' style='display:none'>" + item.OrderDate + "</td>" +
                     "<td class='OrderTM' style='display:none'>" + item.OrderTime + "</td>" +
                      "<td class='tdTempBind' style='display:none'>" + Bindstr + "</td>" +

                    "</tr>";
                                $('#tblinvestigate tbody').append(rows);
                                $('#tblinvestigate tr#' + item.TestCode.trim()).trigger('click');/*4/22/19*/
                           // }
                       // }

                   // }

                //************************************************************
                
            });

        }
        function callMe(obj) {
            var currid = $(obj).attr('id');
            var m = $('#tblinvestigate tbody tr.clickable-row.CN');
            $.each(m, function (i, p) {
                var ids = $(p).attr('id');
                if (ids != currid) {
                    $(p).remove();
                }

            });
            console.log(m);
        }

        function SetText(str) {

            $("#" + idOfDMY).text(str);

            //vijeta 26/4/19
            if (idOfDMY.toUpperCase().indexOf("DAYS") != -1)
                $("#" + idOfDMY).parents('td').nextAll('td.duration').find('a.trigger2').trigger('click');

            //Commented by meenakshi 28/04/2019 not required 
            //else if (idOfDMY.toUpperCase().indexOf("NUM") != -1)
            //    $("#" + idOfDMY).parents('td').nextAll('td.investigationRemark').find('a.trigger3').trigger('click');
            // ----- //
        }
        function CancellFun(newval) {
            $(newval).parent().parent().removeClass("active");
            //$(newval).parent().parent().removeClass("Omited");
            //$(newval).parent().parent().removeClass("planclass");
            //$(newval).parent().parent().removeClass("plannedAndOmitted");
            $(newval).parent().parent().addClass("Canceled");



            $(newval).parents('td').siblings('td.tdStatus')[0].innerText = "C";
            $(newval).parents('td').siblings('td.tdCancelBY')[0].innerText = userid;
            $(newval).parents('td').siblings('td.tdCancelDT')[0].innerText = GetTodaysDate();
            $(newval).parents('td').siblings('td.tdCancelTM')[0].innerText = GetTimewithAMPM();
            //  $(newval).parent().parent().prop("disabled", true);

            $("tr.Canceled input, tr.Canceled select, tr.Canceled textarea, tr.Canceled a, tr.Canceled span, tr.Canceled div").prop('disabled', true);
            //$(newval).parents('td').siblings('td.tdCancel')[0].innerHTML = "";
           // $(newval).parents('td.tdOmit')[0].innerHTML = "";
            $(newval).remove();

        }
        function AddInvestigation() {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetInvestigationList","DoctorDesk")%>",
                data: {},
                success: function (result) {
                    var rows = "";
                    $('#tblinvestigate tbody').empty();
                    $.each(result, function (i, item) {
                        var rows = "<tr class='clickable-row" + ' C' + item.CNT + "' id='" + item.TestCode.trim() + "'>" + "<td style='padding:5px; width:35%;text-align:left;   font-size: 14px;' class='InvestNm'>" + item.Test.trim() + "</td>" +
                            "<td class='tdSDate' style='width:10%'><input type='text'class='triggerInputSDate form-control'   style='display:none;font-size: 12px'  id='SDate" + item.TestCode.trim() + "'  /></td>" +
                             "<td class='tdStime' style='width:10%'><input type='text'class='triggerInputStime form-control'   style='display:none;font-size: 12px'  id='Stime" + item.TestCode.trim() + "' /></td>" +
                            
                             "<td class='tdOmit' style='width:5%'><input type='checkbox'  style='display:none;'  id='Omit" + item.TestCode.trim() + "' value='N' class='triggerInputOmit checkboxomit' /></td>" +
                           //  "<td class='investigationRemark' style='width:30%;'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i><a class='trigger3' href='javascript:;' style='display:none' onclick='AddInvestigationRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                           "<td class='investigationRemark' style='width:30%'><i class='fa fa-pencil fa-2x' style='float: left;margin: 1% 2% 0% 2%;display:none' aria-hidden='true'></i><input type='text'class='triggerInputRemark form-control'   style='display:none;font-size: 12px;width:88%'  id='Days" + item.TestCode.trim() + "' /></td>" +
                             "<td class='OrderBy' style='width:10%;vertical-align: initial;color: #337ab7;'>" + item.CNT + "</td>" +
                          + "<td class='tdTestCode' style='display:none'>" + item.CNT + "</td>" +
                           "<td class='tdTypeCode' style='display:none'>" + item.CNT + "</td>" +
                          "<td class='tdSequenceNo' style='display:none'>" + item.CNT + "</td>" +
                           "<td class='tdStatus' style='display:none'>" + item.CNT + "</td>" +
                           //"<td class='tdADMINYN' style='display:none'>" + item.CNT + "</td>" +
                          "<td class='tdCancelBY' style='display:none'>" + item.CNT + "</td>" +
                           "<td class='tdCancelDT' style='display:none'>" + item.CNT + "</td>" +
                            "<td class='tdCancelTM' style='display:none'>" + item.CNT + "</td>" +
                            
                        "</tr>";/*4/22/19*/
                        $('#tblinvestigate tbody').append(rows);
                    });
                },
                complete: function () {
                    SetDataForInvestigation();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });
        }


        //added on 29th march 2018
        function AddInvestigationRemark(object, e) {
            e.stopPropagation();

            var RemarkText = ""


            if (RemarkText != "") {
                RemarkText = $(object).parent().siblings('.RemarkText')[0].innerText;//added 25/7/19
            }


            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Investaigation Remark</label>' +
                '<textarea rows="4" cols="50"  id="txtComplaintRemark" maxlength="200" placeholder="Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' +//kavita
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {

                            if (RemarkText != "" || RemarkText != "undefined") {
                                $(object).parent().siblings('.RemarkText').remove();
                            }

                            var CurrentRow = $(object).parent().parent();
                            stringRemarkTd = "<td class='RemarkText' style='display:none'>" + $('#txtComplaintRemark').val() + "</td>";
                            var firstChildVal = $(CurrentRow).find('td:nth-child(1)').text().trim();
                            var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + $('#txtComplaintRemark').val() + '</span>'
                            $(CurrentRow).find('td:nth-child(1)').children().remove();
                            $(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark);
                            CurrentRow.append(stringRemarkTd);
                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    $('#txtComplaintRemark').focus();
                    if (RemarkText != "") {
                        $('#txtComplaintRemark').val(RemarkText);
                    }
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                }
            });

        }

        function SearchInvestigation() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("InvestigationInput");
            filter = input.value.replace(/[^a-z0-9\s]/gi, '').toUpperCase();

            var arr = [];
            if (/\s/.test(filter)) {
                // It has any kind of whitespace
                arr = filter.split(" ");
            }
            table = document.getElementById("tblinvestigate");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if (arr.length > 0) {
                        var arrFlags = [];
                        $.each(arr, function (i, val) {
                            if (td.innerHTML.replace(/[^a-z0-9\s]/gi, '').toUpperCase().indexOf(val) > -1) {
                                //tr[i].style.display = "";
                                //if (!$(tr[i]).hasClass('display')) {
                                //    $(tr[i]).addClass('display')
                                //}
                                arrFlags.push(true);

                            } else {
                                //tr[i].style.display = "none";
                                arrFlags.push(false);
                            }
                        });
                        if ($.inArray(false, arrFlags) == -1) {
                            tr[i].style.display = "";
                            if (!$(tr[i]).hasClass('display')) {
                                $(tr[i]).addClass('display')
                            }
                        }
                        else {
                            tr[i].style.display = "none";
                        }
                    }
                    else {
                        if (td.innerHTML.replace(/[^a-z0-9\s]/gi, '').toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                            if (!$(tr[i]).hasClass('display')) {
                                $(tr[i]).addClass('display')
                            }

                        } else {
                            tr[i].style.display = "none";
                        }
                    }

                }
            }

            //search = $(tr).hasClass('display');
            //if (search) {
            //    console.log('data present');
            //}
            //else {
            //    gerTestList(filter)
            //}

            if ($(input).val().length >= 3) {
                gerTestList(filter, tr);
            }
        }

        //added 28/3/19
      

        function gerTestList(filter,obj) {
          $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetInvetiLst","ICUMob")%>",
                async: false,
                data: { searchstring: filter },
                success: function (response) {
                    var result = response;
            var rows = "";
            
            $.each(result, function (i, item) {
                        var MatchElement = jQuery.grep(obj, function (element, index) {
                            Name = element.getElementsByTagName("td")[0].innerHTML;
                            return ((item.TESTNAME).toString().trim() == Name.toString().trim());
                        });

                        if (MatchElement.length > 0) {
                            //Do not bind
                        }
                        else {



                          //  var rows = "<tr class='clickable-row" + ' CN' + "' id='" + item.TESTCODE.trim() + "' >" +
                          //      "<td style='padding:5px; width:5%;text-align:left;font-size: 14px;' class='tdCancel'></td>" + "<td style='width:30%;text-align:left;font-size: 14px;' class='InvestNm'>" + item.TESTNAME.trim() + "</td>" +
                                
                               
                          
                          // "<td class='tdSDate' style='width:10%'><input type='text'class='triggerInputSDate form-control'   style='display:none;font-size: 12px'  id='SDate" + item.TESTCODE.trim() + "' /></td>" +
                          //  "<td class='tdStime' style='width:10%'><input type='text'class='triggerInputStime form-control'   style='display:none;font-size: 12px'  id='Stime" + item.TESTCODE.trim() + "' /></td>" +

                          //   "<td class='tdOmit' style='width:5%'><input type='checkbox'  style='display:none;'  id='Omit" + item.TESTCODE.trim() + "' value='N' class='triggerInputOmit checkboxomit' /></td>" +
                            
                          //   "<td class='investigationRemark' style='width:30%'><i class='fa fa-pencil fa-2x' style='float: left;margin: 1% 2% 0% 2%;display:none' aria-hidden='true'></i><input type='text'class='triggerInputRemark form-control'   style='display:none;font-size: 12px;width:88%'  id='Remark" + item.TESTCODE.trim() + "' /></td>" +

                          //  "<td class='OrderBy' style='width:10%;vertical-align: initial;color: #337ab7;display:none'>" + userid + "</td>"
                          //+ "<td class='tdTestCode' style='display:none'>" + item.TESTCODE + "</td>" +
                          // "<td class='tdTypeCode' style='display:none'>IG</td>" +
                          //"<td class='tdSequenceNo' style='display:none'></td>" +
                          // "<td class='tdStatus' style='display:none'>A</td>" +
                           
                          //"<td class='tdCancelBY' style='display:none'></td>" +
                          // "<td class='tdCancelDT' style='display:none'></td>" +
                          //  "<td class='tdCancelTM' style='display:none'></td>" +
                          //  "<td class='OrderDate' style='display:none'>" + GetTodaysDate() + "</td>" +
                          //  "<td class='OrderTM' style='display:none'>" + GetTimewithAMPM() + "</td>" +
                          //   "<td class='tdTempBind' style='display:none'></td>" +
                            
                          //  "</tr>";
                          //  $('#tblinvestigate tbody').append(rows);


                            //...................................................................................


                            var rows = "<tr class='clickable-row" + ' CN' + "' id='" + item.TESTCODE.trim() + "' >" +
                                "<td style='padding:5px; width:5%;text-align:left;font-size: 14px;' class='tdCancel'></td>" + "<td style='width:30%;text-align:left;font-size: 14px;' class='InvestNm'>" + item.TESTNAME.trim() + "</td>" +

                        "<td class='tdSDate' style='width:10%'><input type='text'class='triggerInputSDate form-control'   style='display:none;font-size: 12px'  id='SDate" + item.TESTCODE.trim() + "' /></td>" +
                           "<td class='tdStime' style='width:10%'><input type='text'class='triggerInputStime form-control'   style='display:none;font-size: 12px'  id='Stime" + item.TESTCODE.trim() + "' /></td>" +

                        "<td class='tdOmit' style='width:5%'><input type='checkbox' style='display:none' id='Omit" + item.TESTCODE.trim() + "' value='N' class='triggerInputOmit checkboxomit' /></td>" +
                    // "<td class='investigationRemark' style='width:30%;'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddInvestigationRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                      "<td class='investigationRemark' style='width:30%'><i class='fa fa-pencil fa-2x' style='float: left;margin: 1% 2% 0% 2%;display:none' aria-hidden='true'></i><input type='text'class='triggerInputRemark form-control'   style='display:none;font-size: 12px;width: 88%;'  id='Remark" + item.TESTCODE.trim() + "' /></td>" +



                     "<td class='OrderBy' style='width:10%;vertical-align: initial;color: #337ab7;display:none'>" + userid + "</td>" +
                  "<td class='tdTestCode' style='display:none'>" + item.TESTCODE + "</td>" +
                   "<td class='tdTypeCode' style='display:none'>IG</td>" +
                  "<td class='tdSequenceNo' style='display:none'></td>" +
                   "<td class='tdStatus' style='display:none'>A</td>" +
                   //"<td class='tdADMINYN' style='display:none'>" + item.CNT + "</td>" +
                  "<td class='tdCancelBY' style='display:none'></td>" +
                   "<td class='tdCancelDT' style='display:none'></td>" +
                    "<td class='tdCancelTM' style='display:none'></td>" +
                     "<td class='OrderDate' style='display:none'></td>" +
                     "<td class='OrderTM' style='display:none'>" + GetTodaysDate() + "</td>" +
                      "<td class='tdTempBind' style='display:none'>" + GetTimewithAMPM() + "</td>" +

                    "</tr>";
                            $('#tblinvestigate tbody').append(rows);
                            //$('#tblinvestigate tr#' + item.TestCode.trim()).trigger('click');/*4/22/19*/


                        }
                    });

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }
        //vijeta 28/3/19
     <%--   function gerTestList(filter, obj) { /*4/22/19*/
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetTestList","DoctorDesk")%>",
                async: false,
                data: { testname: filter },
                success: function (response) {
                    var result = response
                    var rows = "";
                    $.each(result, function (i, item) {

                        var MatchElement = jQuery.grep(obj, function (element, index) {
                            Name = element.getElementsByTagName("td")[0].innerHTML;
                            return ((item.TESTNAME).toString().trim() == Name.toString().trim());
                        });

                        if (MatchElement.length > 0) {
                            //Do not bind
                        }
                        else {
                            var rows = "<tr class='clickable-row" + ' CN' + "' id='" + item.TESTCODE.trim() + "' >" + "<td style='padding:5px; width:40%;text-align:left;font-size: 14px;' class='InvestNm'>" + item.TESTNAME.trim() + "</td>" +
                                "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + item.TESTCODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>D</a></td>" +
                                "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.TESTCODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>0</a></td>" +

                                "<td class='tdOmit' style='width:5%'><input type='checkbox' style='display:none' id='Omit" + item.TESTCODE.trim() + "' value='N' class='triggerInputOmit checkboxomit' /></td>" +
                             "<td class='investigationRemark' style='width:25%;'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddInvestigationRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                             "<td class='OrderBy' style='width:10%;vertical-align: initial;color: #337ab7;'>" + item.ORDERBY.trim() + "</td>" +
                          + "<td class='tdTestCode' style='display:none'>" + item.TestCode + "</td>" +
                           "<td class='tdTypeCode' style='display:none'>" + item.TypeCode + "</td>" +
                          "<td class='tdSequenceNo' style='display:none'>" + item.SEQNO + "</td>" +
                           "<td class='tdStatus' style='display:none'>" + item.STATUS + "</td>" +
                           "<td class='tdADMINYN' style='display:none'>" + item.CNT + "</td>" +
                          "<td class='tdCancelBY' style='display:none'>" + item.CancelBY + "</td>" +
                           "<td class='tdCancelDT' style='display:none'>" + item.CancelDT + "</td>" +
                            "<td class='tdCancelTM' style='display:none'>" + item.CancelTM + "</td>" +
                                  
                            "</tr>";
                            $('#tblinvestigate tbody').append(rows);
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

        }--%>
        //function SetDataForInvestigation() {
        //    var tranNo = $.session.get('PatTRANNO');
        //    $.ajax({
        //        type: 'post',
        //        datatype: 'json',
        //        data: { strTranNo: tranNo },
        //        url: '../DoctorDesk/SetDataForInvestigation',
        //        success: function (data) {
        //            if (data[0] != null) {
        //                for (var i = 0; i < data[0].length; i++) {
        //                    flagCheckRowsInvst = true;
        //                    row = $('#tblinvestigate tr#' + data[0][i]["TESTCODE"]);

        //                    var durType = (data[0][i]["DURTYPE"] == "") ? "D" : data[0][i]["DURTYPE"];
        //                    var durNum = (data[0][i]["DURATION"] == "") ? "0" : data[0][i]["DURATION"];

        //                    if (row.length > 0) {


        //                        var rowdy = $('#tblinvestigate tr#' + data[0][i]["TESTCODE"] + ' td.day-td')[0];
        //                        var rowdur = $('#tblinvestigate tr#' + data[0][i]["TESTCODE"] + ' td.duration')[0];



        //                        $(rowdy)[0].innerHTML = "<a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + data[0][i]["TESTCODE"] + "' style='display:none;font-weight:800;font-size:16px'>" + durType + "</a>";
        //                        $(rowdur)[0].innerHTML = "<a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='NumDays" + data[0][i]["TESTCODE"] + "' style='display:none;font-weight:800;font-size:16px'>" + durNum + "</a>";

        //                        var colRemark = "<td class='RemarkText' style='display:none;width:30%'>" + data[0][i]["REMARKS"].toString().trim() + "</td>"; // added by vijeta on 30th march 2018
        //                        $('#tblinvestigate tr#' + data[0][i]["TESTCODE"]).append(colRemark);// added by vijeta on 30th march 2018

        //                        if (data[0][i]["REMARKS"].toString().trim() != "") {
        //                            var investigationWithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + data[0][i]["REMARKS"].toString().trim() + '</span>'// added by vijeta on 30th march 2018
        //                            $('#tblinvestigate tr#' + data[0][i]["TESTCODE"]).find('td:nth-child(1)').append(investigationWithRemark);// added by vijeta on 30th march 2018
        //                        }

        //                        $('#tblinvestigate tr#' + data[0][i]["TESTCODE"] + ' td.tdSetUpYn')[0].innerHTML = data[0][i]["SETUPYN"]; //added on 25th July 2019

        //                        $('#tblinvestigate tr#' + data[0][i]["TESTCODE"]).trigger('click');



        //                    }

        //                    else {
        //                        var rows = "<tr class='clickable-row C0' id='" + data[0][i].TESTCODE + "' >" + "<td style='padding:5px; font-size: 14px;width:35%;text-align:left' class='InvestNm'>" + data[0][i].TESTNAME + "</td>" +
        //                        "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + data[0][i].TESTCODE + "' style='display:none;font-weight:800;font-size:16px'>" + durType + "</a></td>" +
        //                        "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + data[0][i].TESTCODE + "' style='display:none;font-weight:800;font-size:16px'>" + durNum + "</a></td>" +
        //                        // "<td style='display:none'>" + "" + "</td>" +//added on 19th May 2018
        //                         "<td class='investigationRemark' style='width:30%'><a  class='trigger3' href='javascript:;' style='display:none' onclick='AddInvestigationRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +//added on 19th May 2018
        //                        // "<td class='tdSetUpYn' style='display:none;'>" + data[0][i]["SETUPYN"] + "</td>" + //added on 25th july 2019
        //                         "<td class='tdOmit' style='width:4%'><input type='checkbox'  style='display:none;'  id='Omit" + code + "' value='N' class='triggerInputOmit checkboxomit' /></td>" +
        //                     //"<td class='investigationRemark' style='width:15%;'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddInvestigationRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
        //                     "<td class='OrderBy' style='width:6%;vertical-align: initial;color: #337ab7;'><span>" + OrderBy + "</span></td>" +
        //                  + "<td class='tdTestCode'>" + data[0][i].CNT + "</td>" +
        //                   "<td class='tdTypeCode'>" + data[0][i].CNT + "</td>" +
        //                  "<td class='tdSequenceNo'>" + data[0][i].CNT + "</td>" +
        //                   "<td class='tdStatus'>" + data[0][i].CNT + "</td>" +
        //                   "<td class='tdADMINYN'>" + data[0][i].CNT + "</td>" +
        //                  "<td class='tdCancelBY'>" + data[0][i].CNT + "</td>" +
        //                   "<td class='tdCancelDT'>" + data[0][i].CNT + "</td>" +
        //                    "<td class='tdCancelTM'>" + data[0][i].CNT + "</td>" +
        //                          "</tr>";

        //                        $('#tblinvestigate tbody').prepend(rows);
        //                        $('#tblinvestigate tr#' + data[0][i]["TESTCODE"]).trigger('click');/*4/22/19*/
        //                    }
        //                }

        //            }
        //            if (data[1] != null) {
        //                if (data[1][0]["FreeInvestigation"] != "") {
        //                    freeHandInvestigation = data[1][0]["FreeInvestigation"].toString();
        //                    $("#freeHandBtn").css("background-color", "green");
        //                    $("#txtFreeInvestigation").val(data[1][0]["FreeInvestigation"].toString());
        //                    $("#freeHandBtn").trigger('click');
        //                }
        //            }

        //        },
        //        complete: function () {
        //            flagCheckRowsInvst = false;
        //            HoldOn.close();//
        //        },
        //        error: function (XMLHttpRequest, textStatus, errorThrown) {
        //            HoldOn.close();//
        //        }
        //    });
        //}


        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './IPInvestigation');

                $(window).on('popstate', function () {
                    if (stopProp)
                    SaveInvestigations("Y");
                });

            }
        });

        function SaveInvestigations(st) {
            HoldOn.open();//

            IpNo = '' + $.session.get('ICUPatIPNO');
            MrNo = '' + $.session.get('ICUPatMRNO');
            PatName = '' + $.session.get('ICUPatName');
          //  var tranNo = ($.session.get('PatTRANNO')).toString();
            var investArr = [];
            
            var rows = [];


            for (i = 0; i < $('#tblinvestigate > tbody > tr.Canceled').get().length; i++) rows.push($('#tblinvestigate > tbody > tr.Canceled').get()[i])
           
            for (i = 0; i < $('#tblinvestigate > tbody > tr.active').get().length; i++) rows.push($('#tblinvestigate > tbody > tr.active').get()[i])

            //if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
               // var testcode = rows[i].id
               // var testname = rows[i].cells[0].innerText;
               // var durType = rows[i].cells[1].innerText;
               // var dur = rows[i].cells[2].innerText;

                //var RemarkElement = $(rows[i]).children('.investigationRemark');//added on 3oth march 2018
                //var strRemark = $(RemarkElement).text();//added on 3oth march 2018
                //var setupYn = $(rows[i]).children('td.tdSetUpYn')[0].innerText; //added on 25/7/19
                var a = {
                    //TESTCODE: testcode,
                    //TESTNAME: testname,
                    //DURATION: dur,
                    //DURTYPE: durType,
                    //REMARKS: "" + strRemark,
                    //SETUPYN: setupYn,//added on 25/7/19



                    action: "",
                    Test: $(rows[i]).children('td.InvestNm')[0].innerText,
                    ProposedDate: $(rows[i]).children('td.tdSDate').find('input.triggerInputSDate')[0].value,
                    ProposedTime: $(rows[i]).children('td.tdStime').find('input.triggerInputStime')[0].value,
                    Select: $(rows[i]).children('td.tdOmit')[0].innerText,
                    Remark: $(rows[i]).children('td.investigationRemark').find('input.triggerInputRemark')[0].value,
                    OrderedBy: userid,
                    TestCode: $(rows[i]).children('td.tdTestCode')[0].innerHTML,
                    TypeCode: $(rows[i]).children('td.tdTypeCode')[0].innerHTML,
                    SQNumber: $(rows[i]).children('td.tdSequenceNo')[0].innerHTML,
                    STATUS: $(rows[i]).children('td.tdStatus')[0].innerHTML,
                    //ADMINYN: $(rows[i]).children('td.tdADMINYN')[0].innerHTML,
                    CancelBY: $(rows[i]).children('td.tdCancelBY')[0].innerHTML,
                    CancelDT: $(rows[i]).children('td.tdCancelDT')[0].innerHTML,
                    CancelTM: $(rows[i]).children('td.tdCancelTM')[0].innerHTML,
                    OrderDate:  GetTodaysDate(),
                    OrderTime: GetTimewithAMPM()
                   
                };
                investArr.push(a);
            }
            if ($('#tractiondropdown').val() == "" || $('#tractiondropdown').val() == null) {
                gact = "N";
            }
            else {
                gact = "E";
            }
            $.ajax({
                type: "POST",
                url: '../ICUMob/SaveTreatmentIpInVestigation',
                datatype: "json",
                data: {
                    action: gact, tableInvest: JSON.stringify(investArr), MrNo: MrNo, IpNo: IpNo, PatName: PatName, TranctionId: "" + $('#tractiondropdown').val(), Prov: $('#txtProvDiagno').val(), Allergy: $('#txtAllergies').val(),
                    NutIntake: "" + $('#cmbNutriIntake').val(), DoctorRemark: "" + $('#txtDocRemarks').val(), VolSuplmnt: "" + $('#txtVolSupplmnt').val()
                },
                success: function (result) {
                   // MsgDia(result, "Information");
                    if (result.toUpperCase().indexOf("SUCCESSFUL") >= 0) {
                         
                        if (typeof resultofal.jsonDetailsData == "undefined" || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                            window.location.href = '../ICUMob/NonDrugOrder';
                        }
                        else if (st.toString().trim() != "Y")
                            MsgDia(result, "Information");


                        GetTreat();
                        SetGridDataInvestigation(resultofal);
                    }else{
                        MsgDia(result, "Error");
                        return false;
                    }

                },
                complete: function () {
                   
                   // if (str != "Y") //added on 18th april 2018
                    //  window.location.href = 'IPInvestigation';
                   
                    HoldOn.close();//
                    if (!resultofal.hasOwnProperty("jsonMedicineData") || resultofal.jsonDetailsData[0].VITALSIGNS.toString().trim() == "" || resultofal.jsonDetailsData[0].HGT.toString().trim() == "" || resultofal.jsonDetailsData[0].OXYGENADMIN.toString().trim() == "") {

                        window.location.href = '../ICUMob/NonDrugOrder';
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                }
            });


            //}
            //else {
            //    $.messager.alert("Information", "No Investigation selected");
            //    //alert('No Investigation selected');
            //}
        }


        function GetpersonalisedList() {

            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersInvestigationList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {//added vijeta 26/4/19
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);'></td><td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle;width:80%' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='InvestigationSetUpAddEdit(this);'></i></span></td>";
                            // rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td><input class='chkPersDis' type='checkbox' style='margin-left:10px'></td><td><div class='icheckbox_flat-green' aria-checked='false' aria-disabled='false' style='position: relative;'><input type='checkbox' class='flat-red' style='position: absolute; opacity: 0;'><ins class='iCheck-helper' style='position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div></td><td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table1[i].DESC) + "</td>";

                            rows += "</tr>";
                        }
                        $('#tblPersInvestigationlist tbody').empty();// added by vijeta on 2nd may 2018
                        $('#tblPersInvestigationlist tbody').append(rows).closest('tr');
                    }



                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();//
                },

            });


        }

        function CreatePersonalList() {

            $.confirm({
                title: 'Investigation setup',
                theme: 'supervan',
                // theme: 'material',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                //  columnClass: 'col-md-6',
                content: '' +
                 '<form action="" class="formName"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:0px" class="form-control" id="investigationSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtInvestigation" type="text" id="input-name" placeholder="Search Setup" class="form-control" onkeyup="SearchInvestigations()" style="margin-left:10px" autofocus></td></tr></table></div>' +
                '<div id="divtblInvestigation" class="divtblInvestigation" style=""><table id="tblPersInvestigationlist" style="width:100%;border-top:1px solid #29884bd6 !important;" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: '<i class="fa fa-check-circle-o"></i>',
                        btnClass: 'btn-default',
                        action: function () {
                            stringcode = '';
                            var row = $('#tblPersInvestigationlist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    //CodeTosend.push($(row[r]).attr('id'));
                                    stringcode += "'" + $(row[r]).attr('id') + "'" + ','
                                    // stringcode +=  $(row[r]).attr('id') +  ','
                                }
                            }
                            var codeT = stringcode.slice(1)
                            var strCode = codeT.substr(0, codeT.length - 2);
                            SavePersInvestigationList(strCode);
                        }
                    },
                    Closed: {
                        text: '<i class="fa fa-close "></i>'
                        //close
                    }
                },

                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    GetpersonalisedList()

                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-right', '10px');
                    })
                    $(defaultbtn[0]).attr('id', 'btnSubmit');
                    $(defaultbtn[0]).addClass('disable-clicks');

                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    $('.jconfirm-bg').css('background-color', 'rgba(255, 255, 255, 0.62)');
                    $('.jconfirm-box').css('background-color', 'rgba(43, 43, 60, 0.98)');
                    $('.jconfirm-box').css('box-shadow', '#868686 0px -1px 14px 4px');

                }
            });

        }
        function SavePersInvestigationList(strCode) {
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: 'SavePersonInvestigation',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            window.location.href = '../ICUMob/IPInvestigation';




                        }
                        else if (("" + result).toUpperCase().indexOf("FAILED") != -1) {
                            $.alert({
                                title: 'Transaction Failed!',
                                animation: 'scale',
                                closeAnimation: 'scale',
                                buttons: {
                                    okay: {
                                        text: 'Okay',
                                        btnClass: 'btn-blue'
                                    }
                                }
                            });
                        }

                    }
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

        //added on 30th April 2018
        $(document.body).on('click', '#investigationSetUpAdd', function (e) {
            InvestigationSetUpAddEdit(this);

        });

        //added on 2nd may 2018
        function SerivceGrpData(srvcgrpname) {
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcgrpname);
            $newDiv.attr("name", srvcgrpname);
            $newDiv.addClass("searchdivclass");
            //$newDiv.css('width', '188px');
            $newDiv.css('height', '300px');
            $newDiv.css('margin-left', '0px');
            $newDiv.css('overflow', 'auto');
            $newDiv.css('display', 'none');
            $newDiv.css('border-color', '#f47b02;')
            $newDiv.css(' border-style', 'solid');
            $newDiv.css('background', 'azure')
            var $newul = $('<ul>');
            $newul.attr("id", "SrvcGrpdata");
            $newul.addClass("searchlistclass");
            var options = "";
            //Iterated over the IEnumerable list.
            var abc = "<a id=btnsrvgrp style=color:blue;cursor:pointer float:right;>ClearSelection</a>"
            var i = 0;
            //$.each(SRVCGRPLIST, function (i, item) {
            //    var title = item.Text;
            //    var idstring = name + i;
            //    //Each option represents a value in dropdown. For each element in the list, option element is created and appended to the stringBuilder object.
            //    options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.Value + "'>" + title + "</label><li>";
            //});
            //added on 18th may 2018
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetInvestigationList","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {

                    if (response != "") {
                        //var result = JSON.parse(response);
                        $.each(response, function (i, item) {
                            var title = item.TESTNAME;
                            var idstring = item.TESTCODE;
                            options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.TESTCODE + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>";
                        });
                    }



                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                },

            });
            //-------------------------------------
            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divSrvcGrpSelect').append($newDiv);
        }

        //added on 2nd may 2018
        //$(document.body).on('click', '#txtServiceGrpsearch', function (e) {
        //    $("#dblServiceHelpsrvcgrp").show();
        //});

        //added on 22nd sep 2018
        $(document.body).on({
            'click': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },
            'focus': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },

        }, '#txtServiceGrpsearch');

        //added on 2nd may 2018
        $(document.body).on('click', '#btnsrvgrp', function (e) {
            $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);
        });

        //added on 2nd may 2018
        $(document.body).on('click', '.formName', function (e) {
            if (e.target.id != "txtServiceGrpsearch" && !$(event.target).closest('#divSrvcGrpSelect').length) {
                $('#dblServiceHelpsrvcgrp').hide();
            }

            //if (e.target.id != "txtServiceGrpsearch" && e.target.parentNode.parentNode.id != "divSrvcGrpSelect")
            //{
            //    $('#dblServiceHelpsrvcgrp').hide();
            //}
        });

        // added by vijeta on 7th may 2018
        function SearchServiceGroup() {

            input = document.getElementById("txtServiceGrpsearch");
            filter = input.value.toUpperCase();
            //var elem = $("#SrvcGrpdata li");
            var elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent();// added by vijeta on 24th sep 2018
            var search = false;//added on  19th may 2018

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
            //added on 19th may 2018
            search = $(elem).hasClass('display');
            if (search) {

            }
            else {
                getNonFreqInChkBxList(filter);
            }
            //---------------------------------------
        }

        // added by vijeta on 7th may 2018
        $(document.body).on('click', '#dblServiceHelpsrvcgrp li input', function (e) {
            if (e.currentTarget.checked === true) {
                //var SrvGrpCode = e.currentTarget.value;

                $(this).parent().parent().remove();

                var element = $("#dblServiceHelpsrvcgrp li input:checkbox:checked");
                //if (element.length == 0) {
                $($(this).parent().parent()).insertAfter('a[id="btnsrvgrp"]');
                //}
                //else {

                // $('#dblServiceHelpsrvcgrp li:eq(' + (element.length - 1) + ')').after($(this).parent().parent());
                //}
                $(this).focus();

            }
            else {

            }
            $("#dblServiceHelpsrvcgrp").show();
            $("#txtServiceGrpsearch").val("").trigger("keyup");//added on 24th sep 2018
            e.stopPropagation();
        });

        //added on 19th May 2018
        function getNonFreqInChkBxList(filter) {
            HoldOn.open();//
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetTestList","DoctorDesk")%>",
                data: { testname: filter },
                asycn: false,
                success: function (response) {

                    var result = response;
                    var options = "";
                    $.each(result, function (i, item) {
                        var title = item.TESTNAME;
                        var idstring = item.TESTCODE;
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.TESTCODE + "'>" + title + "</label><li>";
                        // $('#tblinvestigate tbody').prepend(rows);
                    });
                    //$(options).insertAfter('a[id="btnsrvgrp"]');
                    $("ul#SrvcGrpdata").append(options);//added on 24th sep 2018
                    //$('ul#SrvcGrpdata').prepend(options).closest('li');
                    //ResponseCheck1 = result;

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

        //added on 23rd may 2018
        function SearchInvestigations() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtInvestigation");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersInvestigationlist");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.InvestigationName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";

                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

        }

        //added on 07/03/19
        function InvestigationSetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Investigation SetUp</label>' +
                 '<input  type="varchar" id="txtSetUp" maxlength="50"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +//added length kavita
                '<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Investigations"  class="form-control" onkeyup="SearchServiceGroup()" /> <span class="fa fa-plus fa-2x invsAddspan" title="Add free Invetigation" id="spanAddNewInvtInSetUp"></span>' +
                '<div id="divSrvcGrpSelect" style="border:1px solid gray;" ></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var setUp = this.$content.find('.setUp').val();
                            var grpCode = "";
                            if (setUp == "") {
                                $.alert('Enter SetUp Name');
                                return false;
                            }
                            var chlBoxValLst = null;
                            chlBoxValLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxValLst.push($(this).attr('value'));
                            });
                            var strArry = chlBoxValLst.join(",");

                            //added on 19th may 2018
                            var chlBoxTitleLst = null;
                            chlBoxTitleLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxTitleLst.push($(this).attr('title'));
                            });
                            var strArry1 = chlBoxTitleLst.join(",");
                            if (strArry == "" && strArry1 == "") {
                                $.alert('Select at least one test ');
                                return false;
                            }
                            //------------------

                            //added on 7/3/19
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }
                            //--------------------


                            if (setUp != "") {
                                //$('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").

                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'AddInvestnSetUp',
                                    data: { strInvestSetUpName: setUp, strInvestigationLst: strArry, strNameLst: strArry1, strSetUpCode: strSetUpCode },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUp").val("");
                                            $("#txtInvestigation").val("");//added on 07/03/19
                                            $.alert('Record inserted successfully');
                                            GetpersonalisedList();
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {

                                            $.alert("This Set Up is already Present.");
                                        }
                                        else {
                                            $.alert("Error!!Please Contact IT Dept");
                                        }
                                    },

                                });

                            }
                            else {
                                $.messager.alert("Information", "Please select at least one test");
                            }
                        }
                    },
                    cancel: function () {

                        //close
                        //$('.FoodItems input:checked').focus();
                    },
                },
                onContentReady: function () {

                    if ($(obj).hasClass("fa fa-pencil")) {
                        $('#txtSetUp').val($(obj).parents('td').prev().text());
                    }
                    else {
                        $('#txtSetUp').focus();
                        $('#txtSetUp').val("");
                    }

                    SerivceGrpData(srvcgrpname)// added by vijeta on 30th april 2018

                    //added on 6th march 2019
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsInvst($(obj).parents('tr')[0].id);
                    }

                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    $(".jconfirm-box-container").last().css('width', '480px');// added by vijeta on 22nd sep 2018
                }
            });

        }

        //added on 07/03/19
        function FillSelectedSetUpsInvst(strSetUpCode) {
            HoldOn.open();//

            $.ajax({
                url: '../DoctorDesk/GetInvstListBySetupCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {

                        $.each(response, function (i, val) {
                            if (val["CODE"] != "")//vijeta 30/3/19
                            {
                                $("#dblServiceHelpsrvcgrp li input#" + val["CODE"]).trigger("click");
                            }
                            else {
                                var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + val["TESTNAME"] + "' value='" + "" + "' checked />" + "<label style='vertical-align:middle'>" + val["TESTNAME"] + "</label></label><li>";
                                $(elemnet).insertAfter('a[id="btnsrvgrp"]');
                            }
                        });

                    }

                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        /*added by vij 0n 7/3/19 */
        function handleChange(obj) {
            var parentRow = $(obj).parent().parent();
            $('#tblPersInvestigationlist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus(); // added by vijeta on 7th july 2018
            CountCheckBoxChecked();
        }

        function CountCheckBoxChecked() {
            var CheckBoxCount = $('.chkPersDis:checked').size();
            if (CheckBoxCount > 0) {
                $('#btnSubmit').removeClass('disable-clicks');
            }
            else {
                $('#btnSubmit').addClass('disable-clicks');
            }
        }
        /*----------------------------*/
    </script>
</asp:Content>
