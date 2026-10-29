<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="MainDiv">
        <div id="ContentHolderDiv" class="contentHoldClass" style="width:100%">

           <div class="StuckInput" style="margin-top: -18px;"> <%--4/11/19--%>
                <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Add new Medicine">
                    <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
                </label>
                <input type="text" id="ComplaintInput" <%--onkeyup="SearchComplaint()"--%> placeholder="&#xF002; Search Medicines" style="border-radius: 5px; margin-top: 2px;margin-left: 7px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); height: 28px; position: fixed;"
                    class="empty"><%----%>
                <label id="FillButton" style="background-color: transparent; float: right; border-color: transparent;" title="Refill Medicines" class="fillBtn">
                    <button type="button" class="btn bg-olive margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px;  margin-top: 3px;">ReFill</button><%----%>
                </label>
                <label id="PersMedi" style="background-color: transparent; float: right;  border-color: transparent;" title="Create Personalised list" onclick="CreatePersonalList()" class="PersBtn">
                    <button type="button" class="btn btn-info margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 14px; margin-top: 3px;">Pers...</button><%----%>

                </label>
            </div>


            <label id="btnSave" style="background-color: transparent; float: right; margin-right: 52px; border-color: transparent;" title="Save" class="rightbtn">
                <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed; margin-left: 99px;">
            </label>


            <div id="wrapper" style="overflow: hidden; width: 98%; margin-left: 16px" class="wrapperWidth">
                <div class="tableDiv" style="padding-top: 30px;"> <%----%>
                    <table class="HeadRxMainDiv"><thead> <tr style="font-size: 12px;background-color:#fffdc8"><th style="width: 30%;">Medicine</th><th style="width:4%"> </th><th style="width: 13%;">Frequency</th><th style="width:10%;text-align:center" colspan="2">Duration</th><th style="width:5%">Food</th><th style="width:10%">Dosage</th><th style="width:25%">Remark</th><th style="width:4%"></th><th style="width:4.6%"></th></tr></thead>
                        
                        </table><%-- 4/11/19--%>
                    <table id="tblMaterialList" class="table HeadRxMainDiv" style="width: 100%">
                        <tbody id="tblsort"></tbody>
                    </table>
                </div>
                <div style="margin-top:-20px;">
                    <table id="tblNonFreqMtrlList" style="display:none;width: 100%">
                          <tbody id="tblsort1"></tbody>
                    </table>             
                </div>
            </div>


            <div id="layer-intake" class="po__layer list"  onmouseover="document.body.style.overflow='hidden';"  onmouseout="document.body.style.overflow='auto';"><%--4/01/19--%>
                <a href="javascript:;" style="font-size: 16px">Intak1</a>
                <a href="javascript:; " style="font-size: 16px">Intak2</a>
                <a href="javascript:; " style="font-size: 16px">Intak3</a>
                <a href="javascript:;" style="font-size: 16px">Intak4</a>
            </div>
            <div id="layer-durationNum" class="po__layer list"  onmouseover="document.body.style.overflow='hidden';"  onmouseout="document.body.style.overflow='auto';"><%--4/01/19--%>
            </div>
            <div id="layer-durationWords" class="po__layer list"  onmouseover="document.body.style.overflow='hidden';"  onmouseout="document.body.style.overflow='auto';"><%--4/01/19--%>
                <a href="javascript:;" onclick="SetText('D')" style="font-size: 16px">Days</a>
                <a href="javascript:; " onclick="SetText('W')" style="font-size: 16px">Weeks</a>
                <a href="javascript:; " onclick="SetText('M')" style="font-size: 16px">Months</a>
                <a href="javascript:;" onclick="SetText('Y')" style="font-size: 16px">Years</a>
            </div>
            <div id="layer-Food" class="po__layer list"  onmouseover="document.body.style.overflow='hidden';"  onmouseout="document.body.style.overflow='auto';"><%--4/01/19--%>
                <a href="javascript:; " onclick="SetText('-')" style="font-size: 16px">-</a>       <%--Added by Tejashri on 24/12/2018--%>
                <a href="javascript:;" onclick="SetText('A')" style="font-size: 16px">After Food</a>
                <a href="javascript:; " onclick="SetText('B')" style="font-size: 16px">Before Food</a>
            </div>
            <div id="layer-Remark" class="po__layer list"  onmouseover="document.body.style.overflow='hidden';"  onmouseout="document.body.style.overflow='auto';"><%--4/01/19--%>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>


    <style>

          /*vijeta 30/4/19*/
        table {
            width: 100%;
        }

        /*vijeta 29/03/19*/
        .mediAddspan{
               float: right;
        margin-right: 6px;
        margin-top: -28px;
        position: relative;
        z-index: 2;
        color: #3d7da3;
        cursor:pointer;
        }

       .intakeImageSpan{
            color: #4086bf;
            margin-top: -3px;
            pointer-events: auto; cursor: pointer;
        }

          .shadow {
            box-shadow: 2px 2px 2px 2px red;
            }

            .empty {
            width: 62%;
             }

        .OuterRoundWhiteRight {
            background-color: white;
            width: 46px;
            height: 22px;
            border-radius: 2px 12px 12px 2px;
            color: black;
            text-align: center;
            border-width: 1px;
        }


     

        /* added by vijeta on 30th april 2018*/
        .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
        }

      /*added by vijeta on 15th may 2018*/
        .DaysNumber {
            width: 17%;
            height: 28px;
            font-size: 22px;
            cursor:pointer;
        }


        .DN1 {
            margin-top: 27px;
            margin-bottom: 10px;
        }

        .DN2 {
            margin-top: 10px;
            margin-bottom: 27px;
        }
        .BtnInke {
            width: 40px;
            border-radius: 20px 20px 20px 20px;
            height: 38px;
            text-align: center;
            margin-right: 20px;
            background-color: rgba(76, 228, 76, 0.67);
            cursor: pointer;
        }
        .borderC:first-child {
            border-radius: 16px 0px 0px 16px;
        }

        .borderC:last-child {
            border-radius: 0 16px 16px 0;
        }
         .NoBorder {
            border: none !important;
        }
         .ParentDivDN {
            background-color: #d4cfcf75;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 65px;
        }
          .selectedNumber {
            background: #2e312e7a !important;
            color: white;
            border-radius: 3px 3px 3px 3px;
            box-shadow: 3px 1px 4px 0px #3a3436;
        }

        .JsBtnPostion {
            text-align: center !important;
        }

        .delFont{
            font-size:1.5em !important;
        }
  /*-----------19th oct--- 4/11/19 width chngd----------------*/
        .triggerInputIntake {
            /*width: 150px;*/
            /*width: 121px;*/
            height: 27px;
            font-size: 14px;
        }
 td.MaterialName {
            padding: 5px !important;/*//3/28/19*/
            font-size: 13px;
            width: 30%;
        }
        td.tdNewMedSpan {
           width: 4%;
        }

        td.tdIntake {
            width: 13%;
        }

        td.durationNum {
            width: 5%;
        }

        td.durationWord {
            width: 5%;
        }

        td.tdBeforeAfter {
            width: 5%;
        }

        td.tdDosses {
            width: 10%;
            font-size: 14px;
        }

        td.tdRemark {
            width: 25%;
        }

        .triggerInputDosses {
            width: 100%;
            height: 27px;
        }
        
         td.sortTD1 {
           width:4%;
        }
        td.sortTD2{
            width:4%;
        }
       tbody::after {
        content: ''; display: block;
        page-break-after: always;
        page-break-inside: avoid;
        page-break-before: avoid;        
    }
        /*.intakeImage
         {
             width:16px;
             height:16px;
         }*/
        /*-----------19th oct------end-------------*/

        /*----------------------------------*/
        @media only screen and (min-width : 992px) {
            .empty {
                width: 48%; /**/
            }

            /*.fillBtn {
                margin-right: -31px !important;
            }

            .PersBtn {
                margin-right: -87px !important;
            }*/

            .rightbtn {
                margin-right: 99px;
            }

            /*.wrapperWidth {
                width: 122% !important;
            }*/ /*4/11/19*/

            .divtblDisease {
                height: 500px !important;
                overflow-y: hidden !important;
            }

                .divtblDisease:hover {
                    overflow-y: scroll !important;
                }
                
        }
  @media only screen and (min-width:1400px) { /*//4/11/19*/
              /*.wrapperWidth {
                width: 122% !important;
            }*/ /*4/11/19*/
  .empty {
                width: 47.2%; /**/
            }
  .PersBtn {
                margin-right: -7.40% !important;/*//3/28/19*/
            }
              .fillBtn{
                  margin-right: 20.6%;
              }
              
           
             .StuckInput button{
             margin-left: 1%;
         }
        }
  @media only screen and (min-width: 1366px) and  (max-width: 1399px){
             /*.wrapperWidth {
                width: 117% !important;
            }*/
             .fillBtn{
                  margin-right: 17%;/*//3/28/19*/
              }
               .empty {
                width: 49.2%; /**/
            }
               .PersBtn {
                margin-right: -7.40% !important;/*//3/28/19*/
            }
          
        }
           @media only screen and (min-width: 1024px) and  (max-width: 1365px) {
               .empty {
                width: 46.2%; /**/
            }
             /*.wrapperWidth {
                width: 87% !important;
            }*/
             .fillBtn{
                 margin-right: 21%;/*//3/28/19*/
                 
              }
             .PersBtn { /**/
    margin-right: -10.4% !important;
}
                
             
        }
             
        .sortTD {
            width: 20px !important;
        }

 
        .JsBtnPostion {
            text-align: center !important;
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            font-size: 14px !important;
            text-decoration: inherit;
        }

        .tdDe {
            width: 5px !important;
        }

        .disable-clicks {
            pointer-events: none;
            color: red;
        }

        @media (min-width: 1200px) {
            .container {
                width: 1422px !important;
            }
        }

        /*.jconfirm-box {
            margin-top: 50px !important;
        }*/ /* 3/28/19 commntd*/

        .divtblDisease {
            height: 300px;
            overflow-y: scroll;
        }

        div.divtblDisease::-webkit-scrollbar {
            width: 8px;
        }

        div.divtblDisease::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblDisease::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

        #tblPersDiseaselist > tbody > tr > td {
            border-top: 1px solid rgba(234, 228, 228, 0.32) !important;
        }

        /*added by vijeta on 7th July 2018*/
        .ui-jqgrid tr.jqgrow td {
            word-wrap: break-word; /* IE 5.5+ and CSS3 */
            white-space: pre-wrap; /* CSS3 */
            white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
            white-space: -pre-wrap; /* Opera 4-6 */
            white-space: -o-pre-wrap; /* Opera 7 */
            overflow: hidden;
            height: auto;
            vertical-align: middle;
            padding-top: 3px;
            padding-bottom: 3px;
        }

        .RemarkSelc {
            /*-webkit-appearance: none;*/
            -moz-appearance: none;
            text-indent: 1px;
            width: 77px;
            background-color: white;
            /*border-radius: 10px 10px 10px 10px;*/
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 26px;
            outline: 0;
        }
           @media (min-width: 992px) {
            .jconfirm-box-container {
                margin-left: 24.333333%;
            }
        }/*//3/28/19*/
          .jconfirm .jconfirm-scrollpane {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
     overflow-y: hidden; 
    -webkit-perspective: 500px;
    perspective: 500px;
    -webkit-perspective-origin: center;
    perspective-origin: center;
}/*//3/28/19*/
 .jc-bs3-container{
      width: 1500px !important;
    }   
 .table > tbody > tr.active > td{
     border-left:1px solid #bbbbbb;
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
        .table > tbody > tr.active > td > a {
            width: 100%;
            display: table;
        } /**/   
          
      /*4/11/19 start*/    
 table { min-width: 500px; }


thead, tbody tr {
    display: table;
    width: 100%;
    table-layout: fixed;
}

tbody {
    display: block;
    max-height: 500px;
    overflow-x: hidden;
    overflow-y: scroll;
}

td {
    overflow: hidden;
    text-overflow: ellipsis;
}
th{
    text-align:center;
    border: 1px solid #ede4e4;
}
tr{
    width:100%;
}
        @media (min-width: 1400px) {
            table { min-width: 600px; }
            tbody {
    display: block;
    max-height: 600px;
    overflow-x: hidden;
    overflow-y: scroll;
}

        }
       
        .has-feedback .form-control {
    padding-right: 27.5px;
}   
        .formintakecontrol{
    position: absolute;
    top: 4px;
    right: 0;
    z-index: 2;
    display: block;
    width: 27px;
    height: 25px;
    
    text-align: center;
    
    line-height: 28px !important;
    background: #ffebf6;
    border-radius:0px 5px 5px 0px;
}  

        /*end*/

        .HeadRxMainDiv { min-width: 500px; }

.HeadRxMainDiv > thead,
.HeadRxMainDiv > tbody >tr{
/*thead, tbody tr {*/
    display: table;
    width: 100%;
    table-layout: fixed;
}
.HeadRxMainDiv > tbody{
/*tbody {*/
    display: block;
    max-height: 500px;
    overflow-x: hidden;
    overflow-y: scroll;
}

.HeadRxMainDiv > tbody > tr > td {
    overflow: hidden;
    text-overflow: ellipsis;
}
.HeadRxMainDiv > thead > tr > th{
    text-align:center;
    border: 1px solid #ede4e4;
}
.HeadRxMainDiv > thead > tr,
.HeadRxMainDiv > tbody > tr
{
    width:100%;
}
        @media (min-width: 1400px) {
            .HeadRxMainDiv  { min-width: 600px; }
            .HeadRxMainDiv > tbody {
    display: block;
    max-height: 600px;
    overflow-x: hidden;
    overflow-y: scroll;
}

        }
    </style>

    <script>
        var stopProp = true;
        var ResponseCheck = '';
        var ResponseCheck1 = '';//adde by vijeta on 19th may 2018      
        var srvcgrpname = "dblServiceHelpsrvcgrp"; //added on 30th april 2018
        //added on 15th may 2018
        var IncrementalValue = '';
        var RalVal = '';
        var DaysRow1 = '';
        var DaysRow2 = '';
        var labelVal = '';
        var SelectedNumber = '';
        var SelectedDWM = '';
        var SelectedDWMText = '';
        var SelectedBAFood = ''
        var SelectedINTStemnt = ''
        var CalculatdIntake = '';
        var rowNoFrMedTaper = 0;
        //-----------------------------------

        var ItakesArray = [];
        //var RemarkArray = [];
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        //AddClinics(urls);//commented vijeta 3/5/19
        GetSetUpList("Rx");
        var RemarkArray = "<%:ViewData["RemarkArray"] as System.Collections.Generic.List<object>%>";
         <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var RemarkArray = '<%:Html.Raw(Samp.Serialize(ViewBag.RemarkArray))%>';
        $(document).ready(function () {
            var myArray;

            SetPatientDtl();
            document.getElementById('ComplaintInput').focus() //added by kavita
            LoadAllpopUps();
            AddMedicines();

            BindIntakeCombination();
            //GetRemarkList();

            //alert($(".content - wrapper").width());
            if ($(window).width() >= 996) {
                //screen width size comparion

                $("#PatAdviceSetUpList").css("display", "block");// added by vijeta on 4th oct 2018
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";

                //$("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                ActiveMenu("RxDesktop");
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }
            /*---------------------------------Fill Medicine---------------------------------*/
            $("#FillButton").click(function () {
                var Mrno = ($.session.get('PatMRNO'));
                var strTran = ($.session.get('PatTRANNO'))
                var RefillResult;
                $.confirm({
                    title: 'Medicine Fill Confirmation',
                    content: 'Are you sure to refill last prescribed Medicine ?',
                    buttons: {
                        confirm: function () {
                            $.ajax({
                                type: "POST",
                                url: "<%=Url.Action("RefillMedicine","DoctorDesk")%>",
                                data: { strTranNO: strTran, strMRNo: Mrno },
                                async: false,
                                success: function (response) {
                                    RefillResult = response
                                    //if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                    //    window.location.reload();
                                    //   // GetSavedData();
                                    //}

                                    //else {
                                    //    $.alert('No medicine present to refill for current transaction');
                                    //}

                                },
                                complete: function () {
                                    if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        //window.location.reload();
                                        GetSavedData();
                                    }

                                    else {
                                        $.alert('No medicine present to refill for current transaction');
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.loader.close();
                                    $.messager.alert("Error", errorThrown);
                                },


                            });
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        },
                    }
                });
            });

            $("#btnSave").click(function () {
                // window.location.href = 'PatientEntry';
                SaveAllMedicines("N");
            });

            $("#myAdd").click(function () {

                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formName" style="height:60px">' +
                    '<div class="form-group">' +
                    '<label>Medicine</label>' +
                     '<input  type="varchar" id="txtMedicine" maxlength="70"  placeholder="Medicine" autofocus="autofocus" class="medicine form-control" required />' +//kavita
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var medicine = this.$content.find('.medicine').val();
                                var grpCode = "";
                                if (medicine == "") {
                                    $.alert('Enter Medicine');
                                    return false;
                                }
                                if (medicine != "") {
                                    jQuery.expr[':'].contains = function (a, i, m) {
                                        return jQuery(a).text().toUpperCase()
                                            .indexOf(m[3].toUpperCase()) >= 0;
                                    };

                                    rowNoFrMedTaper = rowNoFrMedTaper + 1; //vijeta 12/4/19
                                    var medCode = "NEW" + rowNoFrMedTaper; //vijeta 12/4/19

                                    if ($('#tblMaterialList tr.active > td.MaterialName:contains(' + medicine + ')').length == 0) {
                                        var row = "";
                                        row += "<tr class='' id='" + medCode + "'>" +
                                       //"<td class='AddNewIntake'><a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/add.png'  class='intakeImage'></a></td>" +//27th oct 2018
                                        "<td class='MaterialName' style='padding:5px;font-size: 13px;width:28%'>" + medicine + "</td><td class='tdNewMedSpan'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + "" + "</td><td class='GenricID' style='display:none'>" + "" + "</td>" +
                                        //"<td class='tdIntake' ><input type='text' class='triggerInputIntake' style='display:none;' placeholder='Intake' /></td>" +//intake
                                        "<td class='tdIntake' style='width:15%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='frequency' id='intake" + medCode + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake'></span></div></td>" +
                                        "<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + medCode + "' style='display:none;font-size:16px'>0</a></td>" +
                                        "<td class='durationWord' style='width5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + medCode + "' style='display:none;font-size:16px'>D</a></td>" +
                                        "<td class='tdBeforeAfter style='width:5%' ><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + medCode + "' style='display:none;font-size:16px'>-</a></td>" +//after food before food
                                        "<td class='tdDosses' style='width:10%'><input type='text'class='triggerInputDosses form-control'  style='display:none;'  placeholder='Dosage' id='dossage" + medCode + "'/></td>" + //dosses
                                        "<td class='tdRemark' style='width:25%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + medCode + "' style='display:none;font-size:16px'>Remark</a><input type='hidden' id='hdn" + medCode + "' /></td>" +

                                        "<td class='tdDrugCode' style='display:none'>" + medCode + "</td>" + //vijeta 4/5/19

                                        "<td class='setupyn' style='display:none'>N</td>" + //added on 1/7/19
                                        "<td class='refillyn' style='display:none'>N</td>" +//added on 1/7/19

                                        "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                                        "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
                                        row += "</tr>";

                                        $("#tblMaterialList tbody").prepend(row).closest('tr');
                                        $('#tblMaterialList tr#' + medCode).trigger('click');
                                        $("#tblMaterialList tr#" + medCode + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
                                            source: ItakesArray,
                                            autoFocus: false,
                                            minLength: 0,
                                            select: function (event, ui) { //on select added vijeta 8/4/19

                                                var txtval = ui.item.value;
                                                var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                                                var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();//added 15/4/19
                                                var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();//added 15/4/19
                                                var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();//added 15/4/19
                                                var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;//added 15/4/19
                                                var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();//added 15/4/19

                                                var tableRow = $("#tblMaterialList tr").filter(function () {
                                                    return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim();
                                                }).closest("tr");

                                                if (tableRow.length > 0) {
                                                    $.messager.alert('Information', 'This medicine and Frequency already present');
                                                    $(this).val('');
                                                    $(this).focus();
                                                    return false;
                                                }
                                                else {
                                                    if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                                        $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                                                        $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                                                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                                        //$(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                                                        $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                                                    }

                                                    else {
                                                        // $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                                                        $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                                                    }
                                                }


                                            }
                                        }).focus(function () {
                                            /* Only search if the autocomplete menu is hidden: */
                                            if ($("ul.ui-autocomplete").is(":hidden")) {
                                                $(this).autocomplete('search', '');
                                            }
                                        });
                                    }
                                    else {
                                        $.messager.alert("Information", "This Medicine already selected");
                                    }
                                }

                            }
                        },
                        cancel: function () {

                        },
                    },
                    onContentReady: function () {
                        $('#txtMedicine').focus();
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

            $(".removeMedicine").click(function (e) {
                e.stopPropagation();
                var CurrenRow = ($(this)[0].closest('tr'));
                var CurrenRowId = $(CurrenRow).attr('id');
                var strTranNo = $.session.get("PatTRANNO");
                RemoveMedicine(CurrenRowId, strTranNo);
                // var MedicineName = $(CurrenRow).children("td.MaterialName").text();

                //$.confirm({
                //    title: 'Medicine delete confirmation!',
                //    content: 'Are you sure you want to delete Medicine :' + '  <strong>' + MedicineName + '  </strong>' + '?',
                //    buttons: {
                //        confirm: {
                //            text: 'Yes, sure!',
                //            btnClass: 'btn-orange',
                //            action: function () {
                //                RemoveMedicine(CurrenRowId, strTranNo);
                //            }
                //        },
                //        cancel: function () {
                //            $.alert('canceled');trigg
                //        }
                //    }
                //});
            });



            $('.triggerIntake,.triggerNum,.triggerDays,.triggerFood,.triggerRemark').po({
                alignment: 'center'
            });

            $("#layer-durationNum .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
                //$('.triggerDays').focus();//4/1/19
            });
            $("#layer-durationWords").click(function (e) {


               // $('.triggerFood').focus();//4/1/19
            });

            $("#layer-Food").click(function (e) {

               // $('.triggerInputDosses').focus();//4/1/19
            });


            $(document.body).on('click', '#layer-Remark .anchorRemark', function (e) {
                var txt = $(this).text();
                var code = $(this)[0].id;
                SetRemarkText(txt, code);
            });

            $(document.body).on('click', '.triggerIntake,.triggerNum,.triggerDays,.triggerFood,.triggerInputDosses,.triggerInputIntake,.triggerRemark, .triggerNewIntake,.triggerPrepend,.triggerAppend', function (e) {
                e.stopPropagation();
                idOfPopUpAnchor = $(this).attr("id");              

                if ($(this).is('.triggerPrepend')) {

                    var currntRow = $(this).closest('tr');
                    if (currntRow.hasClass('active')) {
                        if (currntRow.prev().length) {
                            if ($(currntRow.prev()).hasClass('active'))
                                currntRow.prev().before(currntRow);
                        }
                    }
                    stopProp = false;
                }

                if ($(this).is('.triggerAppend')) {
                    var currntRow = $(this).closest('tr');
                    if (currntRow.next().length) {
                        if ($(currntRow.next()).hasClass('active'))
                            currntRow.next().after(currntRow);
                    }
                    stopProp = false;
                }
            });

            $(document.body).on('click', '#tblMaterialList td a,#tblMaterialList td', function (e) {
                var elm = $(this).parents("tr")[0].id;
                $.each($("tr#" + elm + " td a"), function (i, val) {
                    var divId = $(this).attr("data-layer-id");
                    $("div#" + divId + "").css("display", "none");
                });

                $("div#" + $(this).attr("data-layer-id") + "").css("display", "block");
                $('#' + $(this).data('layer-id')).removeClass('is-active');

                if (!$(this).is('.MaterialName'))
                e.stopPropagation();
            });

            $(document.body).on('click', '#tblMaterialList td.tdIntake span.intakeImageSpan', function (e) {
                e.stopPropagation();
                NewIntake("Out", e); //added on 1/4/19
                //var rowId = $(this)[0].closest('tr').id;
                //var mediName = $("#tblMaterialList tr#" + rowId + " .MaterialName")[0].innerText;
                //var row = "";
                //var timestamp = new Date().getUTCMilliseconds();//by vijeta on 11th march 19
                //row += "<tr class='' id='NEW" + timestamp + "'>" +
                //          //"<td class='AddNewIntake'><a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/add.png'  class='intakeImage'></a></td>" +//27th oct 2018
                //          "<td class='MaterialName'>" + mediName + "</td><td class='GenriName' style='display:none'></td>" +
                //          "<td class='tdIntake'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Intake' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add medicine with new intake' ></span></div></td>" +//intake
                //          "<td class='durationNum'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + timestamp + "' style='display:none;font-size:16px'>0</a></td>" +
                //          "<td class='durationWord' ><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + timestamp + "' style='display:none;font-size:16px'>D</a></td>" +
                //           "<td class='tdBeforeAfter'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + timestamp + "' style='display:none;font-size:16px'>A</a></td>" +//after food before food
                //          "<td class='tdDosses' ><input type='text' class='triggerInputDosses form-control'   style='display:none;' placeholder='Dosage'/></td>" + //dosses
                //          "<td class='tdRemark' ><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + timestamp + "' style='display:none;font-size:16px'>Remark</a><input type='hidden' id='hdn" + timestamp + "' /></td>" +
                // "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                //            "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                //row += "</tr>";
              
                //$(row).insertAfter($("#tblMaterialList tr#" + rowId));
                //$("#tblMaterialList tr#NEW" + timestamp + "").trigger("click");

                //$("#tblMaterialList tr#NEW" + timestamp + "").insertAfter($("#tblMaterialList tr#" + rowId));//by vijeta on 12th march19
            });

            //vijeta 1/4/19
            $(document.body).on('click', '#tblMaterialList td span.addMedFrDiffIntk', function (e) {
                var drugCode = $(this).parents('td').siblings(".tdDrugCode")[0].innerText.trim();//vijeta 4/5/19
                var rowId = $(this)[0].closest('tr').id;
                var mediName = $("#tblMaterialList tr#" + rowId + " .MaterialName")[0].innerText;
                var genericId = $("#tblMaterialList tr#" + rowId + " .GenricID")[0].innerText;//vijeta 17/4/19
                var genericName = $("#tblMaterialList tr#" + rowId + " .GenriName")[0].innerText; //vijeta 17/4/19
                var row = "";
                var dt = new Date();
                rowNoFrMedTaper = Number(rowNoFrMedTaper) + 1;
                var newCode = rowId + "_T" + rowNoFrMedTaper;
                row += "<tr class='' id='" + newCode + "'>" +
                         //"<td class='AddNewIntake'><a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/add.png'  class='intakeImage'></a></td>" +//27th oct 2018
                         "<td class='MaterialName' style='width:28%'>" + mediName + "</td><td style='width:4%'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + genericName + "</td><td class='GenricID' style='display:none'>" + genericId + "</td>" +
                         "<td class='tdIntake' style='width:15%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + newCode + "' /><span class='fa fa-plus fa-2x formintakecontrol intakeImageSpan' title='Add new intake' ></span></div></td>" +//intake 4/12/19
                         "<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + newCode + "' style='display:none;font-size:16px'>0</a></td>" +
                         "<td class='durationWord' style='width:5%'><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + newCode + "' style='display:none;font-size:16px'>D</a></td>" +
                          "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + newCode + "' style='display:none;font-size:16px'>-</a></td>" +//after food before food
                         "<td class='tdDosses' style='width:10%'><input type='text'class='triggerInputDosses form-control'  style='display:none;' placeholder='Dose' id='dossage" + newCode + "' /></td>" + //dosses
                         "<td class='tdRemark' style='width:25%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + newCode + "' style='display:none;font-size:14px'>Remark</a><input type='hidden' id='hdn" + newCode + "' /></td>" +//

                         "<td class='tdDrugCode' style='display:none'>" + drugCode + "</td>" + //vijeta 4/5/19

                          "<td class='setupyn' style='display:none'>N</td>" +
                          "<td class='refillyn' style='display:none'>N</td>" +

                            "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                           "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                row += "</tr>";

                $(row).insertAfter($("#tblMaterialList tr#" + rowId));
                $("#tblMaterialList tr#" + newCode + "").trigger("click");

                $("#tblMaterialList tr#" + newCode + "").insertAfter($("#tblMaterialList tr#" + rowId));
                $("#tblMaterialList tr#" + newCode + "" + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
                    source: ItakesArray,
                    autoFocus: false,
                    minLength: 0,
                    select: function (event, ui) { //on select added vijeta 8/4/19

                        var txtval = ui.item.value;
                        var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                        var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();//added 15/4/19
                        var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();//added 15/4/19
                        var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();//added 15/4/19
                        var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;//added 15/4/19
                        var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();//added 15/4/19

                        var tableRow = $("#tblMaterialList tr").filter(function () {
                            return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim();
                        }).closest("tr");

                        if (tableRow.length > 0) {
                            $.messager.alert('Information', 'This medicine and Frequency already present');
                            $(this).val('');
                            $(this).focus();
                            return false;
                        }
                        else {
                            if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                                $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                                $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                // $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                                $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                            }
                            else {
                                //$(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                                $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                            }
                        }

                    }
                }).focus(function () {
                    /* Only search if the autocomplete menu is hidden: */
                    if ($("ul.ui-autocomplete").is(":hidden")) {
                        $(this).autocomplete('search', '');
                    }
                });
            });
            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys



            var options = {
                source: ItakesArray,
                autoFocus: false,
                minLength: 0,
                select: function (event, ui) { //on select added vijeta 8/4/19

                    var txtval = ui.item.value;

                    idOfPopUpAnchor = $(this).parents('td').find('input')[0].id;//vijeta 15/4/19

                    if (ValidateUniqueRow(txtval)) {
                        if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                            $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                            $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                            // $(this).parents('td').siblings('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                            $(this).parents('td').siblings('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                        }
                        else {
                            // $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                            $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                        }
                    }
                    else {
                        event.preventDefault();
                    }

                },

            };
            $(document).on('keydown.autocomplete ', '.triggerInputIntake', function () {
                $(this).autocomplete(options);
            });

            //vijeta 18th march19
            $('.triggerInputIntake').autocomplete(
               options
            ).focus(function () {
                /* Only search if the autocomplete menu is hidden: */
                if ($("ul.ui-autocomplete").is(":hidden")) {
                    $(this).autocomplete('search', '');
                }
            });
            $(".triggerInputIntake").blur(function () {
                var keyEvent = $.Event("keydown");
                keyEvent.keyCode = $.ui.keyCode.ENTER;
                $(this).trigger(keyEvent);
                var txtval = $(this).val();
            }).autocomplete(options);

            //by vij on 28 nov
            $(document).on('change', '.triggerInputIntake ', function (e) {
                var txtval = $(this).val();

                //by vijeta on 11th march 19
                //var mediName = $(this).parents('td').prev().prev().text();
                var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                var tableRow = $("#tblMaterialList tr").filter(function () {

                    return $(this).find('td.MaterialName').text() == mediName && $(this).find('td.tdIntake input').val() == txtval && $(this).find('td.tdIntake input').val() != "";
                }).closest("tr");

                if (tableRow.length > 1) {
                    $.messager.alert('This medicine and intake already present');
                    $(this).val('')
                }
                else {
                    if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD.") {
                        $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                        $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                        $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                    }
                    else {
                        $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                        $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                    }
                }



            });
            $(".triggerInputDosses").attr('maxlength', '15');//

            //vijeta 29/03/19
            $(document.body).on("click", "#spanAddNewMedInSetUp", function (e) {
                $.confirm({
                    title: '',
                    closeIcon: true,
                    offsetTop: 10,
                    type: 'orange',
                    backgroundDismissAnimation: 'glow',
                    theme: 'bootstrap',
                    content: '' +
                    '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Medicine</label><br>' +
                    '<input  type="varchar" id="txtNewMed"  placeholder="Enter Medicine" autofocus="autofocus" class="setUp form-control" required />' +
                    '</div>' +

                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var medName = $("#txtNewMed").val();
                                var newRow = {
                                    act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                                    CODE: "NEW",
                                    NAME: medName
                                    //INTAKE: '----select----',//commenyed by vijeta on 7th dec 2018
                                    //GENERICID: $(this)[0].parentNode.nextSibling.innerText,
                                    //GENERICNAM: $(this)[0].parentNode.nextSibling.nextSibling.innerText
                                };
                                //$("#tblGrid").jqGrid('addRow', "new");
                                //var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                                //if ($.inArray($(this)[0].defaultValue, ids) == -1)
                                $('#tblGrid').addRowData("NEW", newRow, 'last');

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

            //vijeta 11/4/19
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

            $('#ComplaintInput').donetyping(function () {
                SearchComplaint();
                $("#tblNonFreqMtrlList").hide();//vijeta 10/5/19
            });

            //vijeta 11/4/19

            $(document.body).on("change blur", ".triggerInputDosses", function () {
                idOfPopUpAnchor = $(this)[0].id;

                if (idOfPopUpAnchor.toUpperCase().indexOf("DOSSAGE") != -1)
                    $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdRemark').find('a.triggerRemark').trigger('click');//vijeta 20/4/19

                ValidateUniqueRow();
            });
        });

        //vijeta 15/4/19
        function ValidateUniqueRow(txtval) {
            var intakeVal = "";

            if (txtval != undefined)
                intakeVal = txtval
            else
                intakeVal = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdIntake')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdIntake').find('input')[0].value

            var mediName = $("#" + idOfPopUpAnchor).parents('td').prevAll('.MaterialName').text();
            var durationNum = ($("#" + idOfPopUpAnchor).parents('td').hasClass('durationNum')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.durationNum').find('a').text();
            var durationWord = ($("#" + idOfPopUpAnchor).parents('td').hasClass('durationWord')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.durationWord').find('a').text();
            var food = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdBeforeAfter')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdBeforeAfter').find('a').text();
            var dossage = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdDosses')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdDosses').find('input')[0].value;
            var remark = ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdRemark')) ? $("#" + idOfPopUpAnchor).parents('td').find('a').text() : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdRemark').find('a').text();

            var tableRow = $("#tblMaterialList tr").filter(function () {
                return $(this).find('td.MaterialName').text() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (intakeVal).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim();
            }).closest("tr");

            if ((tableRow.length > 1 && txtval == undefined) || (tableRow.length > 0 && txtval != undefined)) {
                $.messager.alert('Information', 'This medicine and intake already present');
                ($("#" + idOfPopUpAnchor).parents('td').hasClass('tdIntake')) ? $("#" + idOfPopUpAnchor).parents('td').find('input')[0].value = "" : $("#" + idOfPopUpAnchor).parents('td').siblings('.tdIntake').find('input')[0].value = "";
                return false;
            }

            return true;
        }
        function SaveAllMedicines(strPlusButton) {
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var medicineArr = [];
            var rows = $('#tblMaterialList > tbody > tr.active').get();
            //if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                var code = rows[i].id
                var MedicineName = $(rows[i]).children('td.MaterialName')[0].innerText; // rows[i].cells[0].innerText;
                var Intake = $(rows[i]).children('td.tdIntake').find('input.triggerInputIntake')[0].value; //rows[i].cells[3].firstElementChild.firstElementChild.value
                var Duration = $(rows[i]).children('td.durationWord')[0].innerText;// rows[i].cells[4].innerText;
                var Days = $(rows[i]).children('td.durationNum')[0].innerText; //rows[i].cells[5].innerText;
                var Food = $(rows[i]).children('td.tdBeforeAfter')[0].innerText; //rows[i].cells[6].innerText;
                var Dosses = $(rows[i]).children('td.tdDosses').find('input.triggerInputDosses')[0].value; // rows[i].cells[7].firstElementChild.value;
                var Remark = $(rows[i]).children('td.tdRemark').children('input')[0].value; //rows[i].cells[8].children[1].value;
                var setupyn = $(rows[i]).children('td.setupyn')[0].innerText; //added on 1/7/19
                var refillyn = $(rows[i]).children('td.refillyn')[0].innerText; //added on 1/7/19
                var fd = "";
                //Added by Tejashri on 24/12/2018
                if (Food.substring(0, 1) == "B")
                    fd = "E";
                else if (Food.substring(0, 1) == "A")
                    fd = "A";
                else if (Food.substring(0, 1) == "-")
                    fd = "-";
                //End
                var a = {
                    DRUGNM: MedicineName,
                    DOSSAGE: Dosses,
                    DAYS: Days,
                    Remarks: Remark,
                    ROUTE: "",
                    GENERICID: "",
                    GENERICNAME: $(rows[i]).children('td.GenriName')[0].innerText, // rows[i].cells[1].innerText,
                    DRUGCD: code,
                    INTAKECD: '',
                    SOSYN: "N",
                    DURATION: Duration,
                    ABFOOD: fd,
                    DRUGFORM: "",
                    INTAKEDESC: Intake,
                    RESEQ: i + 1,
                    SETUPYN: setupyn,//added on 1/7/19
                    REFILLYN: refillyn,//added on 1/7/19
                };

                medicineArr.push(a);
            }


            var strMsg = "";
            var flag = true;
            $.each(medicineArr, function () {
                if ($(this)[0].INTAKEDESC == "") {
                    flag = false;
                    strMsg = "Please select Intakes for all medicines";
                }
                else if ($(this)[0].DAYS == "0" && ($(this)[0].INTAKEDESC != "SOS" && $(this)[0].INTAKEDESC != "STAT" && $(this)[0].INTAKEDESC != "CONTD.")) {
                    flag = false;
                    strMsg = "Please select duration of selected medicine";
                }
            });

            if (flag) {
                $.ajax({
                    url: 'SaveRx',
                    type: 'POST',
                    datatype: 'json',
                    data: { strAdviceList: JSON.stringify(medicineArr), strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                    success: function (response) {
                        if (strPlusButton == "N")
                            window.location.href = 'PatientEntry';

                    },

                })
                return true;//added on 30th nov 2018
            }
            else {
                $.alert(strMsg);
                return false;//added on 30th nov 2018
            }

        }
        function BindIntakeCombination() {
            $.ajax({
                type: "get",
                datatype: "json",
                url: 'GetMedicineInTake',
                success: function (response) {
                    if (response != "Unsucessfull") {
                        IntakeREsult = JSON.parse(response);
                        for (i = 0; i < IntakeREsult.Intake.length; i++) {
                            ItakesArray.push(IntakeREsult.Intake[i].INTAKE);
                        }
                    }
                }
            });
        }

        function SetText(str) {
            $("#" + idOfPopUpAnchor).text(str);

            if (idOfPopUpAnchor.toUpperCase().indexOf("INTAKE") != -1)
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');//vijeta 19/4/19
            else if (idOfPopUpAnchor.toUpperCase().indexOf("NUM") != -1)
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.durationWord').find('a.triggerDays').trigger('click');//vijeta 19/4/19
            else if (idOfPopUpAnchor.indexOf("Days") != -1)
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');//vijeta 19/4/19
            else if (idOfPopUpAnchor.toUpperCase().indexOf("FOOD") != -1)
                $("#" + idOfPopUpAnchor).parents('td').nextAll('td.tdDosses').find('input').trigger('focus');//vijeta 19/4/19

            ValidateUniqueRow();//vijeta 15/4/19
        }

        function SetRemarkText(str, code) {

            $("#" + idOfPopUpAnchor).text(str);
            $("#" + idOfPopUpAnchor).siblings("input")[0].value = code;
            ValidateUniqueRow();//vijeta 15/4/19
        }

        function LoadAllpopUps() {
            //duration 1 to 30
            for (var i = 0; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc' style='font-size:16px'>" + i + "</a>";
                $("#layer-durationNum").append(s);
            }

            GetRemarkList();
        }




        function intakeDiv(obj) {
            var DurgIntakeCode = $(obj).attr('id')
            $('.Next').css("visibility", "visible");
            var label;
            $('.shadow').removeClass("shadow");
            $(obj).find('label').addClass("shadow")
        }

        function showInputDiv() {
            // $('.Intakeinputs').css('visibility','visible')
        }

        function AddMedicines() {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetFregqentMaterial","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    var result = JSON.parse(response)
                    var rows = "";
                    $('#tblMaterialList tbody').empty();
                    for (i = 0; i < result.Table.length; i++) {
                        var DurgidASClass = ''
                        DurgidASClass = (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        var code = $.trim(result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        rows += "<tr class='" + DurgidASClass + "' id='" + DurgidASClass + "'>" +

                            "<td class='MaterialName' style='width:28%'>" + $.trim(result.Table[i].MTRLNAME) + "</td><td class='tdNewMedSpan'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td><td class='GenricID' style='display:none'>" + $.trim(result.Table[i].GENERICID) + "</td>" +
                            "<td class='tdIntake' style='width:15%'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + code + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake' ></span></div></td>" +//intake
                            //"<td class='AddNewIntake'><a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/right.png'  class='intakeImage'></a></td>" +//27th oct 2018
                            "<td class='durationNum' style='width:5%'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + code + "' style='display:none;font-size:16px'>0</a></td>" +
                            "<td class='durationWord' style='width:5%' ><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + code + "' style='display:none;font-size:16px'>D</a></td>" +
                             "<td class='tdBeforeAfter' style='width:5%'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + code + "' style='display:none;font-size:16px'>-</a></td>" +//after food before food
                            "<td class='tdDosses' style='width:10%'><input type='text'class='triggerInputDosses form-control'   style='display:none;' placeholder='Dosage' id='dossage" + code + "' /></td>" + //dosses
                            "<td class='tdRemark' style='width:25%'><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + code + "' style='display:none;font-size:16px'>Remark</a><input type='hidden' id='hdn" + code + "' /></td>" +

                             "<td class='tdDrugCode' style='display:none'>" + $.trim(result.Table[i].MTRLCODE).trim() + "</td>" + //vijeta 4/5/19
                            "<td class='setupyn' style='display:none'>N</td>" + //added 1/7/19
                             "<td class='refillyn' style='display:none'>N</td>" + //added 1/7/19

                            "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                            "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle;width:4%;'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
                        rows += "</tr>";


                    }
                    $('#tblMaterialList tbody').append(rows);

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                },

                complete: function () {
                    //GetRemarkList();
                    GetSavedData();
                },
            });
        }

        function GetRemarkList() {
            var response = JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));
            for (var i = 0; i < response.length; i++) {
                var s = "<a href='javascript:;' id='" + response[i].Value + "' class='anchorRemark' style='font-weight:500;font-size:16px'>" + response[i].Text + "</a>";
                $("#layer-Remark").append(s);
            }
            var staticOther = "<div style='position:sticky;bottom:0;width:100%;background-color:#c2d9e6;text-align:center;font-size:16px;color:#398ebd;font-weight:800' id='divOther' onclick='OtherRemarkClicked()'>Other<div>";
            $("#layer-Remark").append(staticOther);


            //var datatosend = {
            //    strClinincode: $.session.get('ClinicCode').toString().trim()
            //}
            //$.loader.open();
            //$.ajax({
            //    type: "POST",
            //    url: "getRemarkList",
            //    data: datatosend,
            //    datatype: "json",
            //    async: true,
            //    success: function (response) {
            //        if (response != "") {
            //           // RemarkArray = response;

            //            for (var i = 0; i < response.length; i++) {
            //                var s = "<a href='javascript:;' id='" + response[i].Value + "' class='anchorRemark' style='font-weight:500;font-size:16px'>" + response[i].Text + "</a>";
            //            $("#layer-Remark").append(s);
            //            }
            //            var staticOther = "<div style='position:sticky;bottom:0;width:100%;background-color:#c2d9e6;text-align:center;font-size:16px;color:#398ebd;font-weight:800' id='divOther' onclick='OtherRemarkClicked()'>Other<div>";
            //            $("#layer-Remark").append(staticOther);
            //        }

            //    }, error: function (XMLHttpRequest, textStatus, errorThrown) {

            //        $.messager.alert("Error", errorThrown);
            //    }
            //});
            //$.loader.close();

        }

        function OtherRemarkClicked() {
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
                                    url: 'saveIntakeRemark',
                                    data: { strNewRemark: NewRemark, },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {

                                            var strCode = "" + response.toString();
                                            strCode = strCode.substring(strCode.length - 3, strCode.length);

                                            //$.alert("Record Inserted Successfully", "Information");
                                            var s = "<a href='javascript:;' id='" + strCode + "' class='anchorRemark' style='font-weight:500;font-size:16px'>" + NewRemark + "</a>";
                                            $(s).insertBefore("#divOther");
                                            //setTimeout(function () { $("#" + strCode).click() }, 500);
                                            $("#layer-Remark a#" + strCode + "").trigger("click");
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

        function AddMedicineRemark(object, e) {
            e.stopPropagation();
            var RemarkText = $(object).parent().next().text();

            if (RemarkText != "" || RemarkText != "undefined") {

            }
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Medicine Remark</label>' +
                '<textarea rows="4" cols="50"  id="txtMedicineRemark" maxlength="200" placeholder="Enter Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' +//kavita
                //'<input  type="varchar" id="txtComplaintRemark" maxlength="200"  placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required />' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {

                            if (RemarkText != "" || RemarkText != "undefined") {
                                $(object).parent().next().remove();
                            }

                            var CurrentRow = $(object).parent().parent();
                            stringRemarkTd = "<td class='RemarkText' style='display:none'>" + $('#txtMedicineRemark').val() + "</td>";
                            var firstChildVal = $(CurrentRow).find('td:nth-child(1)').text().trim();
                            var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + $('#txtMedicineRemark').val() + '</span>'
                            $(CurrentRow).find('td:nth-child(1)').children().remove();
                            $(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark);
                            CurrentRow.append(stringRemarkTd);
                        }
                    },
                    cancel: function () {
                    },
                },
                onContentReady: function () {
                    $('#txtMedicineRemark').focus();
                    if (RemarkText != "" || RemarkText != "undefined") {
                        $('#txtMedicineRemark').val(RemarkText);
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
                        var len = result.length;//vijeta 12/4/19
                        ReSeqCnt = result[len - 1].RESEQ;//vijeta 12/4/19
                        // var RamrkList = JSON.parse(RemarkArray);

                        RxDesktopSetData(result);
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

        function SearchComplaint() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("ComplaintInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblMaterialList");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.MaterialName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        if (!$(tr[i]).hasClass('display')) {
                            $(tr[i]).addClass('display')
                        }

                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

            search = $(tr).hasClass('display');
            if (search) {

            }
            else {
                gerDrugList(filter)
            }

        }

        function gerDrugList(filter, obj) {
            //$.loader.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetNonFregqentDrugList","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {
                    var result = JSON.parse(response)
                    var checker = '';


                    for (i = 0; i < result.Table.length; i++) {
                        var rows = "";
                        var MatchElement = jQuery.grep(obj, function (element, index) { //added vijeta 10/4/19
                            Name = element.getElementsByTagName("td")[0].innerHTML;
                            return (($.trim(result.Table[i].MTRLNAME)).toString().trim() == Name.toString().trim());
                        });

                        //if (MatchElement.length > 0) {
                        //    //Do not bind
                        //}
                        //else {
                        var DurgidASClass = ''
                        DurgidASClass = (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        DurgidASClass = DurgidASClass.replace(/\//g, '');
                        var code = $.trim(result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        code = code.replace(/\//g, '');

                        rows += "<tr  class='" + DurgidASClass + "' id='" + $.trim(code) + "'>" +
                            "<td class='MaterialName'>" + $.trim(result.Table[i].MTRLNAME) + "</td><td class='tdNewMedSpan'><span class='fa fa-arrow-circle-down fa-2x addMedFrDiffIntk' title='Add Same medicine with different intake' style='display:none;color:#4086bf' ></span></td><td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
                            "<td class='tdIntake'><div class='form-group has-feedback' style='display:none;'><input type='text' class='triggerInputIntake form-control'  placeholder='Frequency' id='intake" + code + "' /><span class='fa fa-plus fa-2x form-control-feedback intakeImageSpan' title='Add new intake' ></span></div></td>" +//intake
                            //"<td class='AddNewIntake'><a style='display:none;' title='Add New Intake for Medicine' class='triggerNewIntake' ><img src='../Images/right.png'  class='intakeImage'></a></td>" +//27th oct 2018
                            "<td class='durationNum'><a class='triggerNum' href='javascript:;' data-layer-id='layer-durationNum' id='Num" + code + "' style='display:none;font-size:16px'>0</a></td>" +
                            "<td class='durationWord' ><a class='triggerDays' href='javascript:;' data-layer-id='layer-durationWords' id='Days" + code + "' style='display:none;font-size:16px'>D</a></td>" +
                             "<td class='tdBeforeAfter'><a class='triggerFood' href='javascript:;' data-layer-id='layer-Food' id='Food" + code + "' style='display:none;font-size:16px'>A</a></td>" +//after food before food
                            "<td class='tdDosses' ><input type='text'class='triggerInputDosses form-control' style='display:none;' placeholder='Dosage' id='dossage" + code + "'/></td>" + //dosses
                            "<td class='tdRemark' ><a class='triggerRemark' href='javascript:;' data-layer-id='layer-Remark' id='Remark" + code + "' style='display:none;font-size:16px'>Remark</a><input type='hidden' id='hdn" + code + "' /></td>" +

                              "<td class='tdDrugCode' style='display:none'>" + $.trim(result.Table[i].MTRLCODE).trim() + "</td>" + //vijeta 4/5/19

                              //added 1/7/19
                          "<td class='setupyn' style='display:none'>N</td>" +
                         "<td class='refillyn' style='display:none'>N</td>" +

                         "<td class='sortTD1' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortMe' style='display:none' class='triggerPrepend'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                            "<td class='sortTD2' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important;display:none' class='triggerAppend'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
                        rows += "</tr>";
                        // }

                        if (rows != "") {
                            $('#tblNonFreqMtrlList tbody').append(rows).closest('tr');

                            //vijeta 13/4/19
                            $("#tblNonFreqMtrlList tr#" + code + "" + " input.triggerInputIntake").autocomplete({  //vijeta 5/4/19
                                source: ItakesArray,
                                autoFocus: false,
                                minLength: 0,
                                select: function (event, ui) { //on select added vijeta 8/4/19

                                    var txtval = ui.item.value;
                                    var mediName = $(this).parents('td').prevAll('.MaterialName').text();
                                    var durationNum = $(this).parents('td').siblings('.durationNum').find('a').text();//added 15/4/19
                                    var durationWord = $(this).parents('td').siblings('.durationWord').find('a').text();//added 15/4/19
                                    var food = $(this).parents('td').siblings('.tdBeforeAfter').find('a').text();//added 15/4/19
                                    var dossage = $(this).parents('td').siblings('.tdDosses').find('input')[0].value;//added 15/4/19
                                    var remark = $(this).parents('td').siblings('.tdRemark').find('a').text();//added 15/4/19
                                    var tableRow = $("#tblMaterialList tr").filter(function () {

                                        return $(this).find('td.MaterialName').text().trim() == mediName.trim() && ($(this).find('td.tdIntake input').val()).toUpperCase().trim() == (txtval).toUpperCase().trim() && $(this).find('td.tdIntake input').val().trim() != "" && ($(this).find('td.tdDosses input')[0].value).toUpperCase().trim() == dossage.toUpperCase().trim() && $(this).find('td.tdRemark a').text().trim() == remark.trim();
                                    }).closest("tr");

                                    if (tableRow.length > 0) {
                                        $.messager.alert('This medicine and frequency already present');
                                        $(this).val('');
                                        $(this).focus();
                                        return false;
                                    }
                                    else {
                                        if (txtval.toUpperCase() == "SOS" || txtval.toUpperCase() == "STAT" || txtval.toUpperCase() == "CONTD." || txtval.toUpperCase() == "CONTD") {
                                            $(this).parents('td').siblings('td.durationNum').find('a')[0].innerText = "0";
                                            $(this).parents('td').siblings('td.durationWord').find('a')[0].innerText = "D";
                                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'none');
                                            // $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('focus');
                                            $(this).parents('td').nextAll('td.tdBeforeAfter').find('a.triggerFood').trigger('click');
                                        }
                                        else {
                                            //$(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('focus');
                                            $(this).parents('td').nextAll('td.durationNum').find('a.triggerNum').trigger('click');
                                            $(this).parents('td').siblings('td.durationNum,td.durationWord').find('a').css('pointer-events', 'auto');
                                        }
                                    }


                                }
                            }).focus(function () {
                                /* Only search if the autocomplete menu is hidden: */
                                if ($("ul.ui-autocomplete").is(":hidden")) {
                                    $(this).autocomplete('search', '');
                                }
                            });
                        }


                    }
                    //}

                    ResponseCheck = result;

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //$.loader.close();
                    $.messager.alert("Error", errorThrown);
                },
                //complete: function (jqXHR, status) {

            });

        }


      

        function GetpersonalisedList() {

            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersDiseaseList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    var result = JSON.parse(response)
                    var rows = "";
                    for (i = 0; i < result.Table1.length; i++) {
                        rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);'></td><td class='DiseaseName' style='padding:5px;font-size: 16px;vertical-align:middle' onclick='CheckedSetUp(this);'><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='SetUpAddEdit(this);'></i></span></td>";
                        //3/29/19 chngd font size
                        rows += "</tr>";
                    }
                    $('#tblPersDiseaselist tbody').empty();// added by vijeta on 17th may 2018
                    $('#tblPersDiseaselist tbody').prepend(rows).closest('tr');

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        //function CreatePersonalList() {

        //    $.confirm({
        //        title: 'SetUp Disease',
        //        theme: 'supervan',
        //        // theme: 'material',
        //        closeIcon: true,
        //        offsetTop: 10,
        //        type: 'orange',
        //        backgroundDismissAnimation: 'glow',
        //        //  columnClass: 'col-md-6',
        //        content: '' +
        //        '<form action="" class="formName"><div class="form-group"><input id="txtDisease" type="text" id="input-name" placeholder="Search Disease" class="form-control" onkeyup="SearchDiseases()"></div>' +
        //        '<div id="divtblDisease" class="divtblDisease"><table id="tblPersDiseaselist" style="width:100%;" class="table"><tbody></tbody></table></div>' +
        //        '</form>',
        //        buttons: {
        //            formSubmit: {
        //                text: '<i class="fa fa-check-circle-o"></i>',
        //                btnClass: 'btn-default',
        //                action: function () {
        //                    stringcode = '';
        //                    var row = $('#tblPersDiseaselist tr')
        //                    for (r = 0; r < row.length; r++) {
        //                        var Chk = $(row[r]).find('.chkPersDis')
        //                        if (Chk[0].checked) {
        //                            //CodeTosend.push($(row[r]).attr('id'));
        //                            stringcode += "'" + $(row[r]).attr('id') + "'" + ','
        //                            // stringcode +=  $(row[r]).attr('id') +  ','
        //                        }
        //                    }
        //                    var codeT = stringcode.slice(1)
        //                    var strCode = codeT.substr(0, codeT.length - 2);
        //                    SavePersDiseaseList(strCode);
        //                }
        //            },
        //            Closeed: {
        //                text: '<i class="fa fa-close "></i>'
        //                //close
        //            }
        //        },

        //        onOpen: function () {
        //            $('jconfirm-box').css('margin-top', '10px !important;')
        //        },
        //        onContentReady: function () {
        //            GetpersonalisedList()

        //            $('.jconfirm-buttons').addClass('JsBtnPostion')
        //            var defaultbtn = $('.jconfirm-buttons>button');
        //            $.each(defaultbtn, function (index, val) {
        //                $(defaultbtn[index]).css('font-size', '35px');
        //                $(defaultbtn[index]).css('margin-right', '10px');
        //            })
        //            $(defaultbtn[0]).attr('id', 'btnSubmit');
        //            $(defaultbtn[0]).addClass('disable-clicks');

        //            $('.jc-bs3-row').removeClass('row')
        //            $('.jconfirm-box-container').removeClass('col-xs-offset-1')
        //            $('.jconfirm-box-container').removeClass('col-xs-10');
        //            $('.jconfirm-box-container').removeClass('col-md-4');
        //            var jc = this;
        //            this.$content.find('form').on('submit', function (e) {
        //                // if the user submits the form by pressing enter in the field.
        //                e.preventDefault();
        //                jc.$$formSubmit.trigger('click'); // reference the button and click it
        //            });

        //        }
        //    });

        //}


        function CreatePersonalList() {

            $.confirm({
                title: 'SetUp Disease',
                theme: 'supervan',
                // theme: 'material',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                //  columnClass: 'col-md-6',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:0px" class="form-control" id="RxSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtDisease" type="text" id="input-name" placeholder="Search Disease" class="form-control" onkeyup="SearchDiseases()"  style="margin-left:10px" ></td></tr></table></div>' +
                '<div id="divtblDisease" class="divtblDisease" style=""><table id="tblPersDiseaselist" style="width:100%;border-top:1px solid #29884bd6 !important" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: '<i class="fa fa-check-circle-o"></i>',
                        btnClass: 'btn-default',
                        action: function () {
                            stringcode = '';
                            var row = $('#tblPersDiseaselist tr')
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
                            SavePersDiseaseList(strCode);
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
                    $('.jconfirm-box').css('box-shadow', 'rgb(62, 62, 50) 0px -1px 14px 4px');

                }
            });

        }

        function SavePersDiseaseList(strCode) {
            $.ajax({
                type: "POST",
                url: 'SavePersonDises',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            window.location.href = 'RxDesktop';
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
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }

            });
        }
        function handleChange(obj) {
            var parentRow = $(obj).parent().parent();
            $('#tblPersDiseaselist tbody').prepend(parentRow).closest('tr');
            $('table tr:nth-child(1)').find('input:first').focus(); // added by vijeta on 7th july 2018
            CountCheckBoxChecked();
        }
        function CheckedSetUp(obj) {
            var CurrentChkBox = $(obj).prev().children();
            if (CurrentChkBox.prop("checked") == true)
                CurrentChkBox.prop('checked', false);
            else
                CurrentChkBox.prop('checked', true);

            CountCheckBoxChecked();

            var parentRow = $(obj).parent();
            $('#tblPersDiseaselist tbody').prepend(parentRow).closest('tr');
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
        function RemoveMedicine(CurrenRowId, strTranNo) {
            $.ajax({
                url: '../DoctorDesk/DeleteMedicine',
                type: 'POST',
                datatype: 'json',
                data: { strMaterialCode: CurrenRowId.toString().trim(), strTranNo: strTranNo },
                success: function (response) {
                    if (response.indexOf("successful") != -1) {

                        $("tr#" + CurrenRowId).removeClass('active');
                        $("tr#" + CurrenRowId).children('td').children('i').hide();
                        $("tr#" + CurrenRowId).children('td.sortTD').hide();
                        //CurrenRow.removeClass('active');
                    }

                },
            })
        }
        function SaveMedicineResequence(str) {
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var MaterlstArr = [];
            var rows = $('#tblMaterialList > tbody > tr.active').get();
            //if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                var strDrugcode = rows[i].id

                if (strDrugcode.toString().trim().toUpperCase() != "NEW") {
                    var strResquence = i + 1;
                    var a = {
                        DRUGCD: strDrugcode,
                        RESEQ: strResquence,
                    };
                    MaterlstArr.push(a);
                }
            }

            $.ajax({
                type: "POST",
                url: 'SaveMedicineResequence',
                datatype: "json",
                data: { strMedicineList: JSON.stringify(MaterlstArr), strTranNO: tranNo, strMRNo: mrno },
                success: function (result) {
                    if (str != "Y") //added on 18th april 2018
                        window.location.href = '../DoctorDesk/PatientEntry';
                },
            });

        }
        function SearchDiseases() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("txtDisease");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblPersDiseaselist");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = $(tr[i]).children("td.DiseaseName")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";

                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }

        }

        //added on 30th April 2018
        $(document.body).on('click', '#RxSetUpAdd', function (e) {

            SetUpAddEdit(this);//added on 6th march 2019
        });

        //added on 30th April 2018
        //$(document.body).on('click', '#txtServiceGrpsearch', function (e) {
        //    $("#dblServiceHelpsrvcgrp").show();

        //    $("#divSrvcGrpGrid").show();// added by vijeta on 14th May 2018
        //});

        //added on 22nd sep 2018
        $(document.body).on({
            'click': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
                $("#divSrvcGrpGrid").show();
            },
            'focus': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
                $("#divSrvcGrpGrid").show();
            },

        }, '#txtServiceGrpsearch');

        //added on 30th April 2018
        $(document.body).on('click', '#btnsrvgrp', function (e) {
            $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);

            $('#tblGrid').jqGrid('clearGridData'); // added by vijeta on1 16th may 2018
        });

        //added on 30th April 2018
        //$(document.body).on('click', '.formName', function (e) {
        //    if (e.target.id != "txtServiceGrpsearch" && !$(event.target).closest('#divSrvcGrpSelect').length && !$(event.target).closest('#divSrvcGrpGrid').length && !$(event.target).closest('#formDetails').length) {
        //        $('#dblServiceHelpsrvcgrp').hide();

        //        $('#divSrvcGrpGrid').hide();// added by vijeta on 14th May 2018
        //    }

        //});//3/29/19comntd

        //added on 30th april 2018
        function SerivceGrpData(srvcgrpname) {
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcgrpname);
            $newDiv.attr("name", srvcgrpname);
            $newDiv.addClass("searchdivclass");
            //$newDiv.css('width', '188px');
            $newDiv.css('height', '200px');//3/28/19
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

            //added on 17th may 2018
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetFregqentMaterial","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {

                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        for (i = 0; i < result.Table.length; i++) {
                            var title = result.Table[i].MTRLNAME;
                            var idstring = result.Table[i].MTRLCODE;
                            options += "<li><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + result.Table[i].MTRLCODE + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" + result.Table[i].GENERICID + "</label><label id='genericName' style='display:none'>" + result.Table[i].GENERICNAM + "</label><li>";
                        }
                    }



                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                },

            });
            //-------------------------------------


            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divSrvcGrpSelect').append($newDiv);
        }

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
                colNames: ['', 'Code', 'Medicine Name', 'Dose', '<label>Frequency</label><span style="float:right;width: 22px;font-size: large;color: #3d7da3" title="Add Frequency" id="btnNewIntake" onclick="NewIntake()"> <i class="fa fa-plus"></i></span>', 'Intake Calculated', 'Days', 'Duration', 'Food', 'Remark', 'Generic Id', 'Generic Name'],
                //3/28/19 changd label name ,titl chngd
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
                      name: 'NAME', index: 'NAME', width: 100, align: "left", sortable: false, searchoptions: { clearSearch: false }//3/29/19 width chngd
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
                               });//3/29/19 width chngd
                               //$(e).width(155).height(20).select2({
                               //    dropdownCssClass: "ui-widget ui-jqdialog"
                               //});
                               //$(e).change(function (evnt) {
                               //    var rowId = $("#tblGrid").jqGrid('getGridParam', 'selrow');
                               //    AddMedicineDetail(evnt.target.value, rowId);
                               //});
                           },
                           dataEvents: [{
                               type: 'change',
                               // type:'click',
                               fn: function (e) {
                                   //e.stopPropagation();
                                   var rowId = e.target.id.replace(/[^0-9]/gi, '');
                                   jQuery("#tblGrid").jqGrid("editCell", Number(rowId), 7, true);//3/29/19

                                   // AddMedicineDetail(e.target.value, rowId);// commented by vij on 7th dec 2018

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
                          name: 'GENERICNAM', index: 'GENERICNAM', width: 220, align: "left", sortable: false, hidden: false
                      },
                ],

                rowNum: 9999999999,
                sortname: 'id',
                width: 440,//3/28/19
                //footerrow: true,
                height: 200,//3/28/19
                viewrecords: true,
                sortorder: "desc",
                loadtext: 'Loading...',
                loadonce: true,
                rownumbers: true,
                shrinkToFit: false,
                cellEdit: true,
                //footerrow: true,
                ignoreCase: true,
                cellsubmit: 'clientArray',
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
                    $("#tblGrid").css('font-size', '11.1px');
                    // totbed = $("#gvBedOccup").jqGrid('getCol', 'TOTBED', false, 'sum');
                },
                ondblClickRow: function (rowId) {
                    //GetMedicineDetails(rowId);// commented by vijeta on 6th July 2018
                    var rowdat = $('#tblGrid').getRowData(rowId);// added by vijeta on 6th july 2018
                    var intakesList = IntakeREsult.Table;
                    var InTKNAME = rowdat["INTAKE"];
                    value = jQuery.grep(IntakeREsult.Table, function (n, i) {
                        return (n.INTAKE == InTKNAME);
                    });
                    // AddMedicineDetail(value[0].CODE, rowId);// added by vijeta on 6th july 2018
                },
                onCellSelect: function (rowId, iCol, content, event) {
                    rows = $('#tblGrid')[0].rows;
                    var rowdat = $('#tblGrid').getRowData(rowId);

                    if (iCol == 1) {

                        $('#tblGrid').jqGrid('delRowData', rowId);

                        $("ul#SrvcGrpdata input[value='" + rowId + "']").prop('checked', false);// changed by vij on 24th sep 2018
                    }
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



        //added on 14th may 2018
        $(document.body).on('click', 'ul#SrvcGrpdata input', function (e) {
            if ($(this)[0].checked) {
                var newRow = {
                    act: '<span class="ui-icon ui-icon-cancel">Remove</span>',
                    CODE: $(this)[0].defaultValue,
                    NAME: $(this)[0].parentNode.innerText,
                    //INTAKE: '----select----',//commenyed by vijeta on 7th dec 2018
                    GENERICID: $(this)[0].parentNode.nextSibling.innerText,
                    GENERICNAM: $(this)[0].parentNode.nextSibling.nextSibling.innerText
                };
                //$("#tblGrid").jqGrid('addRow', "new");
                var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                if ($.inArray($(this)[0].defaultValue, ids) == -1)
                    $('#tblGrid').addRowData($(this)[0].defaultValue, newRow, 'last');
            }
            else {
                $('#tblGrid').jqGrid('delRowData', $(this)[0].defaultValue);
            }
        });

        //added on 14th may 2018
        function load_Intake() {
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


                }
            });
            return s;
        }

        //added on 7th dec 2018
        function load_Days() {
            var s;
            s = ":--select--;";
            for (i = 0; i <= 30; i++) {
                s += i + ":" + i + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }

        //added on 7th dec 2018
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

        //added on 7th dec 2018
        function load_Food() {
            var s;
            s = ":--select--;";
            s += "After:After;";
            s += "Before:Before;";

            s = s.substring(0, s.length - 1);
            return s;
        }

        //added on 7th dec 2018
        function load_Remarks() {
            var arry = JSON.parse(RemarkArray.replace(/\n/g, "\\\\n").replace(/\r/g, "\\\\r").replace(/\t/g, "\\\\t"));//vijeta 13/4/19
            var s = "";
            for (i = 0; i < arry.length; i++) {
                s += arry[i].Value + ":" + arry[i].Text + ";";
            }
            s = s.substring(0, s.length - 1);
            return s;
        }


        //added on 14th may 2018
        function AddMedicineDetail(IntakeId, rowId) {
            var medicineData = $("#tblGrid").getRowData(rowId);
            IncrementalValue = '';
            RalVal = '';
            DaysRow1 = '';
            DaysRow2 = '';
            labelVal = '';
            SelectedNumber = '';
            SelectedDWM = '';
            CalculatdIntake = '';
            SelectedDWMText = '';
            SelectedINTStemnt = '';
            for (I = 1; I < 6; I++) {
                DaysRow1 += '<label id="D' + I + '" class="DaysNumber DN1" onclick="CallSelectedNumber(this)">' + I + '</label>'
            }

            for (I = 6; I < 11; I++) {
                DaysRow2 += '<label id="D' + I + '" class="DaysNumber DN2" onclick="CallSelectedNumber(this)">' + I + '</label>'
            }

            var Id = IntakeId;
            value = jQuery.grep(IntakeREsult.Table, function (n, i) {
                return (n.CODE == Id);
            });

            var InatkeCombi = value[0].INTAKE;
            strx = InatkeCombi.split('-');

            for (m = 0; m < strx.length; m++) {
                labelVal += '<label class="BtnInke"><span style="font-size: 27px;">' + strx[m] + '</span></label>'
            }

            //added on 6th july 2018
            //food
            var aftrfd = medicineData.FOOD == "After Food" ? "active" : "";
            var bfrfd = medicineData.FOOD == "Before Food" ? "active" : "";

            //DAYS
            var activeDay = medicineData.DAYS;

            //duration
            var dura = medicineData.DURATION
            //
            $.confirm({
                theme: 'material',
                type: 'orange',
                columnClass: 'medium',
                closeIcon: true,
                title: '' + medicineData.NAME + '',
                content: '' +
                '<form action="" class="formName" style="text-align:center" id="formDetails">' +
                 '<div style="margin-bottom:15px;"><div class="btn-group groupCombi" data-toggle="buttons" style="padding-top: 6px" id="GropSeelect">' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="0.5" autocomplete="off" checked="">0.5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="1" autocomplete="off" checked="">1</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="5" autocomplete="off" checked="">5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="10" autocomplete="off" checked="">10</label>' +
                  '</div></div>' +
                '<div class="form-group" id="btnCalulatedIntaKe">' + labelVal + '</div>' +
                 '<div style="margin-bottom:15px;"><div class="btn-group Food" data-toggle="buttons" style="padding-top: 6px" id="foodIntake">' +
               '<label class="btn btn-default borderC ' + bfrfd + '" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="E" autocomplete="off" checked="">Befor Meal</label>' +
              '<label class="btn btn-default borderC ' + aftrfd + '" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="A" autocomplete="off" checked="">After Meal</label>' +
            '</div></div>' +

             '<div style="margin-bottom:15px;" class=""><div class="btn-group IntkeStatement" data-toggle="buttons" style="padding-top: 6px" id="IntkeStatement">' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraConti"><input type="radio" name="IntkeStatement" value="Contd" autocomplete="off" checked="">Contd</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraSOS"><input type="radio" name="IntkeStatement" value="SOS" autocomplete="off" checked="">SOS</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraStat"><input type="radio" name="IntkeStatement" value="STAT" autocomplete="off" checked="">STAT</label>' +//added on 4th sep 2018
               '<label class="btn btn-default active" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraOther"><input type="radio" name="IntkeStatement" value="Other" autocomplete="off" checked="">Other</label>' +
            '</div></div>' +
            '<div class="ParentDivDN">' +
               '<div class=Drow1>' + DaysRow1 +
            '</div>' +
            '<div class=Drow2>' + DaysRow2 +
          '</div>' +
          '<div>' +
            '<div style="margin-bottom:15px;"><div class="btn-group btn-group-sm MedicineDays" data-toggle="buttons" style="padding-top: 6px;margin-bottom:30px" id="MedicineDays">' +
                '<label id="DAYS" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="D" autocomplete="off" checked="">DAYS</label>' +
                '<label id="WEEK" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="W" autocomplete="off" checked="">WEEK</label>' +
                '<label  id="MONTH" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="M" autocomplete="off" checked="">MONTH</label>' +
                '<label  id="YEAR" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="Y" autocomplete="off" checked="">YEAR</label>' +
           '</div>' +
         '</div>' +
          '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn btn-green',
                        action: function () {
                            bfFood = ''
                            var Chlength = $('#btnCalulatedIntaKe').children().children().length;
                            for (var c = 0; c < Chlength; c++) {
                                var childElement = $('#btnCalulatedIntaKe').children().children()[c];
                                CalculatdIntake += childElement.innerHTML + '-';
                            }
                            CalculatdIntake.slice(0, -1)

                            //createdRow = '</tr><td id=IntakeCombination>' + CalculatdIntake.slice(0, -1) + '</td><td id=DaySel>' + SelectedNumber + ' ' + SelectedDWM + '</td><td id=FoodVal>' + SelectedBAFood + '</td><td id="tdDoses"><input type="text" id="txtDoses"></td><td><select class="RemarkSelc" style="text-align:center;width:92%"></select></td></tr>'
                            // $(createdRow).appendTo($("#MediTbl tbody"));
                            //validation added by vijeta on 18th Aug 2018
                            var medType = $("div.IntkeStatement label.active").children()[0].value;
                            if (medType == "Other") {
                                if (!($(".Drow1").children(".selectedNumber").length > 0 || $(".Drow2").children(".selectedNumber").length > 0) || ($('.MedicineDays').children('label.active').length == 0)) {
                                    $.alert("Please Select Duration.");
                                    return false;
                                }
                            }
                            //----------------------------
                            AddMedicineRow(rowId);
                        }
                    },
                    cancel: function () {
                        //close

                    },

                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });


                    $(".BtnInke").on('click', function () {
                        var child = $(this).children();
                        if (longpress) {
                            $(this).children().text(0);
                        }
                        else {
                            ChangeCombinationVal(child);
                        }
                    });

                    $(".BtnInke").on('mousedown', function () {
                        startTime = new Date().getTime();
                    });

                    $(".BtnInke").on('mouseup', function () {
                        endTime = new Date().getTime();
                        longpress = (endTime - startTime > 500) ? true : false;
                    });

                    $(".BtnInke").bind("taphold", function tapholdHandler(event) {
                        $(this).children().text(0);
                    });

                    //added on 6th July 18
                    if (activeDay != " ")
                        CallSelectedNumber($("#D" + activeDay)[0]);

                    if (dura == "Contd")
                        StoreINTStatementVal($("#lblDuraConti")[0]);
                    else if (dura == "SOS")
                        StoreINTStatementVal($("#lblDuraSOS")[0]);
                    else if (dura == "STAT")//added on 4th sep 2018
                        StoreINTStatementVal($("#lblDuraStat")[0]);//added on 4th sep 2018
                    else
                        StoreINTStatementVal($("#lblDuraOther")[0]);


                    //for days weeks months n years
                    if (dura == "DAYS")
                        StoreDaysValue($("#DAYS")[0]);
                    else if ((dura == "WEEK"))
                        StoreDaysValue($("#WEEK")[0]);
                    else if ((dura == "MONTH"))
                        StoreDaysValue($("#MONTH")[0]);
                    else if ((dura == "YEAR"))
                        StoreDaysValue($("#YEAR")[0]);
                }
            });
        }

        //added on 15th may 2018
        function CallSelectedNumber(obj) {
            var lblchild = obj.parentElement.children

            $('.Drow1').children().each(function () {
                if ($(this).hasClass('selectedNumber')) {
                    $(this).removeClass('selectedNumber')
                }
            });

            $('.Drow2').children().each(function () {
                if ($(this).hasClass('selectedNumber')) {
                    $(this).removeClass('selectedNumber')
                }
            });

            $(obj).addClass('selectedNumber');
            SelectedNumber = $(obj).text();
        }

        //added on 15th may 2018
        function ValueToStore(obj) {
            IncrementalValue = (obj).children[0].value;
            RalVal = (obj).children[0].value;
        }

        //added on 15th may 2018
        function StoreABFoodVal(obj) {
            SelectedBAFood = (obj).children[0].value;
        }

        //added on 15th may 2018
        function StoreINTStatementVal(obj) {
            SelectedINTStemnt = (obj).children[0].value;
            if (SelectedINTStemnt.length > 0) {
                $("#lblDuraOther").removeClass("active");//added on 4th sep 2018
                obj.className = "btn btn-default active"; //added on 6th July 2018
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    $('.ParentDivDN').addClass('disable-clicks')

                    $('.Drow1').children().each(function () {
                        if ($(this).hasClass('selectedNumber')) {
                            $(this).removeClass('selectedNumber')
                        }
                    });

                    $('.Drow2').children().each(function () {
                        if ($(this).hasClass('selectedNumber')) {
                            $(this).removeClass('selectedNumber')
                        }
                    });

                    $('.MedicineDays > .btn-default').removeClass('active');
                    SelectedNumber = "";//added on 6th July 2018
                }
                else {
                    $('.ParentDivDN').removeClass('disable-clicks')
                }
            }

        }

        //added on 15th may 2018
        function StoreDaysValue(obj) {
            obj.className = "btn btn-default NoBorder active";// added by vijeta on 6th July 2018
            SelectedDWM = (obj).children[0].value;
            SelectedDWMText = $(obj).attr('id');
        }

        //added on 15th may 2018
        function AddMedicineRow(rowId) {

            // calculated intake
            var calIntk = "";
            if (CalculatdIntake.length > 0) {
                calIntk = CalculatdIntake.slice(0, -1);
            }
            else {
                calIntk = '';
            }

            // Food status
            var FoodStatus = ''
            if (SelectedBAFood == "A") {
                FoodStatus = "After Food";
            }
            else if (SelectedBAFood == "E") {
                FoodStatus = "Before Food";
            }

            // Days
            var days = " ";
            days = SelectedNumber;

            //Duration 
            var duration = "";
            if (SelectedINTStemnt.length > 0) {
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    duration = SelectedINTStemnt;
                    days = " ";//added on 6th july 2018
                }
                else {
                    duration = SelectedDWMText;
                }
            }
            else {
                duration = SelectedDWMText;
            }

            jQuery("#tblGrid").jqGrid('setCell', rowId, "INTAKECALC", calIntk);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DAYS", days);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DURATION", duration);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "FOOD", FoodStatus);
            jQuery("#tblGrid").jqGrid('setCell', rowId, "DOSAGE", "");
            jQuery("#tblGrid").jqGrid('setCell', rowId, "REMARK", "");

        }


        //added on 15th may 2018
        function ChangeCombinationVal(obj) {

            obj.text(Number(obj.text()) + Number(RalVal))
        }

        //added on 15th may 2018
        function GetMedicineDetails(rowId) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:60px">' +
                '<div class="form-group">' +
                '<table style="width: 100%; margin-bottom: 5px; margin-left: 5px; font-size: 14px;" id="MediTbl">' +
                            '<tr>' +
                                '<th class="hide">Code</th>' +
                                '<th class="">Intake</th>' +
                                '<th class="">Duration</th>' +
                                '<th style="width: 18%">Food</th>' +

                            '</tr>' +
                        '</table>' +
                        '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'OK',
                        btnClass: 'btn-blue',
                        action: function () {

                        }
                    },
                    //cancel: function () {
                    //    text: 'OK'
                    //},
                },
                onContentReady: function () {
                    fillData(rowId);
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

        //added on 15th may 2018
        function fillData(rowId) {
            var table = $('#MediTbl');
            var rowCount = table[0].rows.length;
            var row = table[0].insertRow(rowCount);

            var data = $('#tblGrid').jqGrid('getRowData', rowId);
            var FoodStatus = ''


            var cell1 = row.insertCell(0);
            if (data["INTAKECALC"].length > 0) {
                cell1.innerHTML = data["INTAKECALC"].toString();
            }
            else {
                cell1.innerHTML = '';
            }

            var cell2 = row.insertCell(1);
            if (data["DURATION"].length > 0) {
                if (data["DAYS"] != "")
                    cell2.innerHTML = data["DAYS"] + " " + data["DURATION"];
                else
                    cell2.innerHTML = data["DURATION"];
            }

            var Cell3 = row.insertCell(2)
            Cell3.innerHTML = data["FOOD"].toString();
            Cell3.setAttribute('style', 'width:18%');

        }

        //added on 16th may 2018
        function CancelImg(value, options, rowObject) {
            var flag = false;
            var radioHtml = "";
            radioHtml = '<span class="ui-icon ui-icon-cancel">Remove</span>';
            return radioHtml;
        }

        // added by vijeta on 17th may 2018
        function MedicineFilter() {
            //document.removeEventListener('keyup', doc_keyUpForShortCutMenus, false);//added on 24th sep 2018
            input = document.getElementById("txtServiceGrpsearch");
            filter = input.value.toUpperCase();
            var elem = $("#SrvcGrpdata li");
            var search = false;

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

            search = $(elem).hasClass('display');
            if (search) {

            }
            else {
                getNonFreqInChkBxList(filter);
            }
        }

        //added on 18th May 2018
        function getNonFreqInChkBxList(filter) {
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetNonFregqentDrugList","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {

                    var result = JSON.parse(response)
                    var checker = '';
                    //if (ResponseCheck1.hasOwnProperty("Table")) {
                    //    if (ResponseCheck1.Table.length > 0) {
                    //        checker = $.grep(ResponseCheck1.Table, function (n, i) {
                    //            return (n.MTRLCODE = result.Table[i].MTRLCODE);
                    //        });
                    //    }
                    //}
                    //if (checker.length == 0) {
                    var rows = "";
                    var options = "";
                    for (i = 0; i < result.Table.length; i++) {
                        var title = result.Table[i].MTRLNAME;
                        var idstring = result.Table[i].MTRLCODE;
                        options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + result.Table[i].MTRLCODE + "'>" + title + "</label><label id='genericId' style='display:none'>" + result.Table[i].GENERICID + "</label><label id='genericName' style='display:none'>" + result.Table[i].GENERICNAM + "</label><li>";
                        //var DurgidASClass = ''
                        //DurgidASClass = (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        //rows += "<tr onclick='myFunction(this);' class='" + DurgidASClass + "' id='" + $.trim(result.Table[i].MTRLCODE) + "'>" +
                        //     "<td class='tdDe'><i class='fa fa-trash-o removeMedicine fa-2x' style='display:none'></i></td>" +
                        //    "<td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table[i].MTRLNAME) + "</td>" +
                        //    "<td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
                        //    "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortMe'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                        //    "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                        //rows += "</tr>";
                    }
                    //}
                    $(options).insertAfter('a[id="btnsrvgrp"]');
                    //$('ul#SrvcGrpdata').prepend(options).closest('li');
                    ResponseCheck1 = result;

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }

        function SetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Medicine SetUp</label>' +
                '<input  type="varchar" id="txtSetUp"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +
                //'<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Medicines...." title="Search For Medicines" class="form-control" onkeyup="MedicineFilter()" />' +
                '<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Medicines" class="form-control" onkeyup="MedicineFilter()" /><span class="fa fa-plus fa-2x mediAddspan" title="Add new Medicine" id="spanAddNewMedInSetUp"></span>' + //vijeta 29/03/19
                '<div id="divSrvcGrpSelect" style="border:1px solid gray;"></div>' +
                '<div id="divSrvcGrpGrid"  style="display:none;margin-top:5px"><table id="tblGrid"></table></div>' +
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

                            //added on 17th may 2018
                            var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                            myDataWithIds = $.map(ids, function (index, key) {
                                $('#tblGrid').jqGrid("editCell", 0, 0, false);
                                DRUGNM = $("#tblGrid").jqGrid('getCell', index, 'NAME');
                                if ($("#tblGrid").jqGrid('getCell', index, 'DAYS') != "--select--")//
                                    DAYS = $("#tblGrid").jqGrid('getCell', index, 'DAYS');
                                else
                                    DAYS = '';
                                DRUGCD = $("#tblGrid").jqGrid('getCell', index, 'CODE');
                                if ($("#tblGrid").jqGrid('getCell', index, 'DURATION') != "--select--")//
                                    DURATION = $("#tblGrid").jqGrid('getCell', index, 'DURATION');
                                else
                                    DURATION = '';
                                if ($("#tblGrid").jqGrid('getCell', index, 'FOOD') != "--select--")//
                                    ABFOOD = $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "B" ? "E" : $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "A" ? "A" : "";
                                else
                                    ABFOOD = '';
                                if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")//
                                    INTAKEDESC = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                                else
                                    INTAKEDESC = '';

                                if ($("#tblGrid").jqGrid('getCell', index, 'INTAKE') != "--select--")//

                                    INTAKECD = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                                else
                                    INTAKECD = '';
                                SOSYN = $("#tblGrid").jqGrid('getCell', index, 'DURATION').substring(0, 1) == "S" ? "Y" : "N";
                                GENERICID = $("#tblGrid").jqGrid('getCell', index, 'GENERICID');
                                GENERICNAM = $("#tblGrid").jqGrid('getCell', index, 'GENERICNAM');
                                DOSSAGE = $("#tblGrid").jqGrid('getCell', index, 'DOSAGE');
                                REMARKS = $("#tblGrid").jqGrid('getCell', index, 'REMARK');


                                if (DURATION == "STAT")//added on 4th sep 2018
                                    DURATION = "T";

                                return { DRUGNM: DRUGNM, DOSSAGE: DOSSAGE, DAYS: DAYS, Remarks: REMARKS, ROUTE: "", GENERICID: GENERICID, GENERICNAME: GENERICNAM, DRUGCD: DRUGCD, DRUGFORM: "", SOSYN: SOSYN, DURATION: DURATION, ABFOOD: ABFOOD, INTAKEDESC: INTAKEDESC, INTAKECD: "" };
                            });

                            var servData = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC == "" || e.INTAKEDESC == "--select--") });
                            var servicedt = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC != "" || e.INTAKEDESC != "--select--") });
                            var ServiceData = (JSON.stringify(servicedt));

                            if (servData.length > 0) {
                                $.alert('Please select intake for all medicines');
                                return false;
                            }
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
                            //---------------------------------------------

                            //added on 6th march 2019
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil"))
                                strSetUpCode = $(obj).parents("tr")[0].id;

                            if (setUp != "" && ServiceData != "[]") {
                                //$('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").
                                //var senddata = "strMedicineSetUpName=" + setUp + "&&strMedicineLst=" + ServiceData.toString();
                                $.ajax({
                                    type: "get",
                                    dataType: "json",
                                    url: '../DoctorDesk/AddMedicineSetUp',
                                    //data: { strMedicineSetUpName: setUp, strMedicineLst: ServiceData.toString() },
                                    //data: senddata,

                                    data: { strMedicineSetUpName: setUp, strMedicineLst: ServiceData.toString(), strSetUpCode: strSetUpCode },  //Meenakshi don't replace this if there is & in genericname it will not work  //strSetUpCode added by vijeta on 6th march 19

                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUp").val("");
                                            $.alert("Record inserted successfully");
                                            GetpersonalisedList();
                                            GetSetUpList("Rx");//vij 29th oct 2018
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {

                                            $.alert("This Set Up is already Present.");
                                        }
                                        else {
                                            $.alert("Error!!Please Contact IT Dept");
                                        }
                                    },
                                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                                        $.loader.close();
                                        $.messager.alert("Error", errorThrown);
                                    }
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
                    $('#txtSetUp').focus();

                    //added ON 6TH mARCH 2019
                    if ($(obj).hasClass("fa fa-pencil")) {
                        $('#txtSetUp').val($(obj).parents('td').prev().text());
                        $("#dblServiceHelpsrvcgrp").show();
                        $("#divSrvcGrpGrid").show();
                        // $('#divSrvcGrpSelect').show();
                    }

                    else
                        $('#txtSetUp').val("");

                    SerivceGrpData(srvcgrpname)// added by vijeta on 30th april 2018

                    load_Intake();// added by vijeta on 14th may 2018
                    BindSelectedMedicineGrid();// added by vijeta on 14th may 2018

                    //added on 6th march 2019
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectedSetUpsMedi($(obj).parents('tr')[0].id);
                    }

                    // bind to events
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    //$(".jconfirm-box-container").last().css('width', '480px');// added by vijeta on 7/3/19
                }
            });
        }

        //added on 6th march 2019
        function FillSelectedSetUpsMedi(setUpId) {
            $.ajax({
                url: '../DoctorDesk/GetMedListBySetupCode',
                data: { strSetUpCode: setUpId },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {
                        $("#tblGrid").jqGrid('setGridParam', { data: response }).trigger("reloadGrid");

                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }
        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './RxDesktop');

                $(window).on('popstate', function () {
                    if (stopProp)
                        SaveAllMedicines("N");
                });

            }
        });


        //vijeta 18th march 19
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
                }


            })
        }
    </script>
</asp:Content>
