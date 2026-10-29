<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   
    <div id="MainDiv">
        <div id="ContentHolderDiv" class="contentHoldClass">
            <%--    <div class="InputWrapper">--%>
            <div class="StuckInput" <%--style="margin-top: -18px;"--%>>
                <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Add new medicine">
                    <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed; margin-top: -18px;">
                </label>
                <input type="text" id="ComplaintInput" onkeyup="SearchComplaint()" placeholder="&#xF002; Search Medicines" style="border-radius: 5px; margin-top: -16px;margin-left:8px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); height: 28px; position: fixed;"
                    class="empty">
                <label id="FillButton" style="background-color: transparent; float: right; margin-right: 91px; border-color: transparent;" title="Refill Medicines" class="fillBtn">
                    <button type="button" class="btn bg-olive margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 11px; margin-left: -5px; margin-top: -13px;">ReFill</button>
                </label>
                <label id="PersMedi" style="background-color: transparent; float: right; margin-right: -51px; border-color: transparent;" title="create Personalised list" onclick="CreatePersonalList()" class="PersBtn">
                    <button type="button" class="btn btn-info margin" style="float: right; position: fixed; padding: 2px 12px; font-size: 11px; margin-left: 0px; margin-top: -13px;">Per...</button>

                </label>
            </div>
         
             <label id="myBtn" style="background-color: transparent; float: right; margin-right: 52px; border-color: transparent;" title="Save" class="rightbtn" onclick="SaveReSequence();">
                <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed; margin-left: 99px;">
            </label>

            <div id="wrapper" style="overflow: hidden; width: 98%; margin-left: 16px" class="wrapperWidth">
                <div class="tableDiv" style="padding-top: 13px;">
                    <table id="tblMaterialList" class="table" style="width: 100%">
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <div id="layer-demo" class="po__layer list">
            </div>

        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>


    <style>
        .OuterRoundWhiteRight {
            background-color: white;
            width: 46px;
            height: 22px;
            border-radius: 2px 12px 12px 2px;
            color: black;
            text-align: center;
            border-width: 1px;
        }


        .shadow {
            box-shadow: 2px 2px 2px 2px red;
        }
         .empty {
            width: 57%;
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
        /*----------------------------------*/
        @media only screen and (min-width : 992px) {
            .empty {
                width: 51%;
            }

            .fillBtn {
                margin-right: -31px !important;
            }

            .PersBtn {
                margin-right: -87px !important;
            }

            .rightbtn {
                margin-right: 99px;
            }

            .wrapperWidth {
                width: 102% !important;
            }

            .divtblDisease {
                height: 500px !important;
                overflow-y: hidden !important;
            }

             .divtblDisease:hover { overflow-y:scroll !important; }
        }

        .sortTD {
            width: 20px !important;
        }

        .fa-2x {
            font-size: 2.0em !important;
            cursor: pointer;
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

        .jconfirm-box {
            margin-top: 50px !important;
        }

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
        padding-bottom: 3px
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
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
        //-----------------------------------
        $(document).ready(function () {
            var myArray;
            var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
            SetPatientDtl();
 	    document.getElementById('ComplaintInput').focus() //added by kavita
            AddClinics(urls);
            AddComplaints();

            if ($(window).width() >= 996) {
                //screen width size comparion

                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";

                //$("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                ActiveMenu("Advice");
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
                    content: 'Are you sure want to override privious transaction Medicine ?',
                    buttons: {
                        confirm: function () {
                            $.ajax({
                                type: "POST",
                                url: "<%=Url.Action("RefillMedicine","DoctorDesk")%>",
                                data: { strTranNO: strTran, strMRNo: Mrno },
                                async: false,
                                success: function (response) {
                                    RefillResult = response

                                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.loader.close();
                                    $.messager.alert("Error", errorThrown);
                                },

                                complete: function () {
                                    if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        window.location.reload();
                                    }

                                    else {
                                        $.alert('No medicine present to refill for current transaction');
                                    }
                                },
                            });
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        },
                    }
                });
            });

            $("#myBtn").click(function () {
                window.location.href = 'PatientEntry';
            });

            $("#myAdd").click(function () {

                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formName" style="height:60px">' +
                    '<div class="form-group">' +
                    '<label>Medicine</label>' +
                    '<input  type="varchar" id="txtMedicine"  placeholder="Medicine" autofocus="autofocus" class="medicine form-control" required />' +

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

                                    if ($('#tblMaterialList tr.active > td.MaterialName:contains(' + medicine + ')').length == 0) {
                                        var row = "";
                                        row += "<tr onclick='myFunction(this);' id='NEW' class='active'>" +
                                            "<td class='removeMedicine tdDe'><i class='fa fa-trash-o fa-2x'></i></td>" +
                                            "<td class='MaterialName' style='padding:5px;font-size: 13px;'>" + medicine + "</td><td class='GenriName' style='display:none'></td>" +
                                            "<td class='sortTD' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortMe'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                                            "<td class='sortTD' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa  fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
                                        row += "</tr>";
                                        $("#tblMaterialList tbody").prepend(row).closest('tr');
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
                //            $.alert('canceled');
                //        }
                //    }
                //});
            });


            $(".prependRow").click(function (e) {
                var currntRow = $(this).closest('tr');
                if (currntRow.hasClass('active')) {
                    if (currntRow.prev().length) {
                        if ($(currntRow.prev()).hasClass('active'))
                            currntRow.prev().before(currntRow);
                    }
                }
                stopProp = false;
                e.stopPropagation();
            });

            $(".apendRow").click(function (e) {
                var currntRow = $(this).closest('tr');
                if (currntRow.next().length) {
                    if ($(currntRow.next()).hasClass('active'))
                        currntRow.next().after(currntRow);
                }
                stopProp = false;
                e.stopPropagation();
            });
           
            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys
        });


        function CallAdviceNewView(mediName, mediCode, GenricName, GenricID) {//vijeta GenricID added 17/4/19) {

            $.ajax({
                type: "GET",
                url: "<%=Url.Action("CallToAdviceNew","DoctorDesk")%>",
                data: { MediName: mediName, MediCode: mediCode, GenricName: GenricName, GenricID: GenricID },//vijeta GenricID added 17/4/19
                async: false,
                success: function (data) {
                    window.location.href = '../DoctorDesk/AdviceNew'; // your action should return an object having [redirecturl] property
                }
            });
           //window.location.href = '../DoctorDesk/AdviceNew?MediName=' + mediName + "&&MediCode=" + mediCode + "&&GenricName=" + GenricName;
        }

        function myFunction(obj) {
            var MaterialCode = $(obj).attr("id");
            var MaterialName = $(obj).find(".MaterialName").text();
            var GenricName = $(obj).find(".GenriName").text();
            var GenricID = $(obj).find(".GenricID").text();//vijeta 17/4/19
            CallAdviceNewView(MaterialName, MaterialCode, GenricName, GenricID);

        }

        function SaveReSequence() {
            SaveMedicineResequence();
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

        function AddComplaints() {
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
                        DurgidASClass = GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '') : (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                        rows += "<tr onclick='myFunction(this);' class='" + DurgidASClass + "' id='" + (GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICID) : $.trim(result.Table[i].MTRLCODE)) + "'>" +
                            "<td class='tdDe'><i class='fa fa-trash-o removeMedicine fa-2x' style='display:none'></i></td>" +
                            "<td class='MaterialName' style='padding:5px;font-size: 13px;'>" + (GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICNAM) : $.trim(result.Table[i].MTRLNAME)) + "</td><td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td><td class='GenricID' style='display:none'>" + $.trim(result.Table[i].GENERICID) + "</td>" + // genericID vijeta 17/4/19
                            "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortMe'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                            "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";
                        rows += "</tr>";
                    }
                    $('#tblMaterialList tbody').append(rows);

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                },

                complete: function () {
                    GetSavedData();
                },
            });
        }


        function GetSavedData() {
            $.loader.open();
            var consNo = $.session.get('PatTRANNO');
            $.ajax({
                type: "POST",
                url: "GetSavedMediList",
                data: { strConsNo: consNo },
                datatype: "json",
                async: false,
                success: function (response) {
                    if (response != "") {
                        var result = JSON.parse(response)
                        for (var i = 0; i < result.length; i++) {
                            var NonFrqRows = '';
                            var DurgID = (result[i]["DRUGCD"]).replace(/[^0-9a-zA-Z]/gi, '');
                            var row = $('#tblMaterialList tr.' + DurgID).get();

                            if (row.length > 0) {
                                $("#tblMaterialList tbody").prepend(row).closest('tr');
                                $('#tblMaterialList tr.' + DurgID).addClass('active');

                                $('#tblMaterialList tr.' + DurgID + ' td').children('i').show();
                                $('#tblMaterialList tr.' + DurgID).children('td.sortTD').show();
                            }
                            else {
                                NonFrqRows += "<tr onclick='myFunction(this);' class='" + DurgID + " active' id='" + $.trim(result[i].DRUGCD) + "'>" +
                                    "<td class='removeMedicine tdDe'><i class='fa fa-trash-o fa-2x'></i></td>" +
                                    "<td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result[i].DRUGNM) + "</td><td class='GenriName' style='display:none'>" + $.trim(result[i].GENERICNAME) + "</td>" +
                                    "<td class='sortTD' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortMe'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                                    "<td class='sortTD' style='line-height:0px !important;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa  fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>"
                                NonFrqRows += "</tr>";
                                $('#tblMaterialList tbody').prepend(NonFrqRows).closest('tr');
                            }
                        }
                    }
                    $.loader.close();
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }, complete: function () {
                    var selRows = $('#tblMaterialList > tbody > tr.active').get();
                    if (selRows.length > 0) {
                        $.each(selRows, function (index, row) {
                            $('#tblMaterialList').children('tbody').prepend(row);
                        });
                    }
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

        function gerDrugList(filter) {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetNonFregqentDrugList","DoctorDesk")%>",
                data: { NonFreqDrug: filter },
                asycn: false,
                success: function (response) {
                    var result = JSON.parse(response)
                    var checker = '';
                    //if block commented by vijeta on 6th july 2018
                    //if (ResponseCheck.hasOwnProperty("Table")) {
                    //    if (ResponseCheck.Table.length > 0) {
                    //        checker = $.grep(ResponseCheck.Table, function (n, i) {
                    //            return (n.MTRLCODE = result.Table[i].MTRLCODE);
                    //        });
                    //    }
                    //}
                    //if (checker.length == 0) {//commented by vijeta on 6th july 2018
                        var rows = "";
                        for (i = 0; i < result.Table.length; i++) {
                            var DurgidASClass = '';
                            DurgidASClass = GeneralWiseYN == "Y" ? (result.Table[i].GENERICID).replace(/[^0-9a-zA-Z]/gi, '') : (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                            rows += "<tr onclick='myFunction(this);' class='" + DurgidASClass + "' id='" + (GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICID) : $.trim(result.Table[i].MTRLCODE)) + "'>" +
                                 "<td class='tdDe'><i class='fa fa-trash-o removeMedicine fa-2x' style='display:none'></i></td>" +
                                "<td class='MaterialName' style='padding:5px;font-size: 13px;'>" + (GeneralWiseYN == "Y" ? $.trim(result.Table[i].GENERICNAM) : $.trim(result.Table[i].MTRLNAME)) + "</td>" +
                                "<td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>" +
                                "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortMe'><div><span sort='asc' class='prependRow' id='prependRow'><i class='fa  fa-arrow-circle-o-up fa-2x'></i></span></div></a></td>" +
                                "<td class='sortTD' style='line-height:0px !important;display:none;vertical-align:middle'><a href='#' id='SortApend' style='margin-right:20px !important'><div><span sort='desc' class='apendRow' id='apendRow'><i class='fa fa-arrow-circle-o-down fa-2x'></i></span></div></a></td>";

                            rows += "</tr>";
                        }
                   // }
                    $('#tblMaterialList tbody').prepend(rows).closest('tr');
                    ResponseCheck = result;

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });

        }


        //$(document.body).on('click', '.removeMedicine', function (event) {
        //    //if (!e) var e = window.event
        //    //e.cancelBubble = true;
        //    //if (e.stopPropagation) e.stopPropagation();

        //    if ($(event.target).is('.removeMedicine')) {
        //        event.stopPropagation();
        //        return;
        //    }

        //    var CurrenRow = ($(this)[0].closest('tr'));
        //    var CurrenRowId = $(CurrenRow).attr('id');

        //    var strTranNo = $.session.get("PatTRANNO");
        //    $.ajax({
        //        url:'../DoctorDesk/DeleteMedicine',
        //        type:'POST',
        //        datatype: 'json',
        //        data: { strMaterialCode: CurrenRowId.toString().trim(), strTranNo: strTranNo },
        //        success: function (response) {
        //            if (response.indexOf("successful") != -1)
        //            {
        //                //alert(response);
        //                e.stopPropagation();
        //                CurrenRow.removeClass('active');
        //            }

        //    },
        //    })

        //});

        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                $(window).on('popstate', function () {
                    var hashLocation = location.hash;
                    var hashSplit = hashLocation.split("#!/");
                    var hashName = hashSplit[1];

                    if (hashName !== '') {
                        var hash = window.location.hash;
                        if (hash === '') {
                            //alert('Back button was pressed.');
                            if (stopProp)
                                window.location = '../DoctorDesk/PatientEntry';
                            stopProp = false;
                            return false;
                        }
                    }
                });

                window.history.pushState('forward', null, '../DoctorDesk/Advice');
            }
        });

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
                        rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);'></td><td class='DiseaseName' style='padding:5px;font-size: 13px;vertical-align:middle' onclick='CheckedSetUp(this);'><b>" + $.trim(result.Table1[i].DESC) + "</b></td>";
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
                    Closeed: {
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
                            window.location.href = 'Advice';
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

            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Medicine SetUp</label>' +
                '<input  type="varchar" id="txtSetUp"  placeholder="Enter SetUp Name" autofocus="autofocus" class="setUp form-control" required />' +
                '<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Medicines...." title="Search For Medicines" class="form-control" onkeyup="MedicineFilter()" />' +
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
                                DAYS = $("#tblGrid").jqGrid('getCell', index, 'DAYS');
                                DRUGCD = $("#tblGrid").jqGrid('getCell', index, 'CODE');
                                DURATION = $("#tblGrid").jqGrid('getCell', index, 'DURATION');
                                ABFOOD = $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "B" ? "E" : $("#tblGrid").jqGrid('getCell', index, 'FOOD').substring(0, 1) == "A" ? "A" : "";
                                INTAKEDESC = $("#tblGrid").jqGrid('getCell', index, 'INTAKECALC');
                                INTAKECD = $("#tblGrid").jqGrid('getCell', index, 'INTAKE');
                                SOSYN = $("#tblGrid").jqGrid('getCell', index, 'DURATION').substring(0, 1) == "S" ? "Y" : "N";
                                GENERICID = $("#tblGrid").jqGrid('getCell', index, 'GENERICID');
                                GENERICNAM = $("#tblGrid").jqGrid('getCell', index, 'GENERICNAM');


                                if (DURATION == "STAT")//added on 4th sep 2018
                                    DURATION = "T";

                                return { DRUGNM: DRUGNM, DOSSAGE: "", DAYS: DAYS, Remarks: "", ROUTE: "", GENERICID: GENERICID, GENERICNAME: GENERICNAM, DRUGCD: DRUGCD, DRUGFORM: "", SOSYN: SOSYN, DURATION: DURATION, ABFOOD: ABFOOD, INTAKEDESC: INTAKEDESC, INTAKECD: "" };
                            });

                            var servData = $.grep(myDataWithIds, function (e) { return (e.INTAKEDESC != "") });
                            var ServiceData = (JSON.stringify(servData));

                            if (ServiceData == "[]") {
                                $.alert('Please select intake for at least one medicine');
                                return false;
                            }
                            //---------------------------------------------

                            if (setUp != "" && ServiceData != "[]") {
                                //$('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").
                                
                                $.ajax({
                                    type: "POST",
                                    dataType: "json",
                                    url: '../DoctorDesk/AddMedicineSetUp',
                                    //data: { strMedicineSetUpName: setUp, strMedicineLst: ServiceData.toString() },
                                    data: {strMedicineSetUpName :setUp , strMedicineLst : ServiceData.toString() },   //Meenakshi
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUp").val("");
                                            $.alert("Record inserted successfully");
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

                        }
                    },
                    cancel: function () {
                       
                        //close
                        //$('.FoodItems input:checked').focus();
                    },
                },
                onContentReady: function () {
                    $('#txtSetUp').focus();
                    SerivceGrpData(srvcgrpname)// added by vijeta on 30th april 2018

                    load_Intake();// added by vijeta on 14th may 2018
                    BindSelectedMedicineGrid();// added by vijeta on 14th may 2018


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
        $(document.body).on('click', '.formName', function (e) {
            if (e.target.id != "txtServiceGrpsearch" && !$(event.target).closest('#divSrvcGrpSelect').length && !$(event.target).closest('#divSrvcGrpGrid').length && !$(event.target).closest('#formDetails').length) {
                $('#dblServiceHelpsrvcgrp').hide();

                $('#divSrvcGrpGrid').hide();// added by vijeta on 14th May 2018
            }

        });

        //added on 30th april 2018
        function SerivceGrpData(srvcgrpname) {
            var $newDiv = $('<div>');
            $newDiv.attr("id", srvcgrpname);
            $newDiv.attr("name", srvcgrpname);
            $newDiv.addClass("searchdivclass");
            //$newDiv.css('width', '188px');
            $newDiv.css('height', '150px');
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
                            var title = GeneralWiseYN == "Y" ? result.Table[i].GENERICNAM : result.Table[i].MTRLNAME;
                            var idstring = GeneralWiseYN == "Y" ? result.Table[i].GENERICID : result.Table[i].MTRLCODE;
                            options += "<li><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + (GeneralWiseYN == "Y" ? result.Table[i].GENERICID : result.Table[i].MTRLCODE) + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label><label id='genericId' style='display:none'>" + result.Table[i].GENERICID + "</label><label id='genericName' style='display:none'>" + result.Table[i].GENERICNAM + "</label><li>";
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
                colNames: ['', 'Code', 'Medicine Name', 'Intake', 'Intake Calculated', 'Days', 'Duration', 'Food', 'DOSAGE', 'Remark', 'Generic Id', 'Generic Name'],
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
                      name: 'NAME', index: 'NAME', width: 220, align: "left", sortable: false, searchoptions: { clearSearch: false }
                  },
                   {
                       name: 'INTAKE', index: 'INTAKE', width: 138, align: "left", sortable: false, searchoptions: { clearSearch: false }, edittype: 'select', editable: true,
                       editoptions: {
                           value: load_Intake(),
                           defaultvalue: "----select----",
                           dataInit: function (e) {
                               jQuery("#tblGrid").setColProp("INTAKE", {
                                   editoptions: {
                                       value: load_Intake(),
                                   }
                               });
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
                                   var rowId = $("#tblGrid").jqGrid('getGridParam', 'selrow');
                                   AddMedicineDetail(e.target.value, rowId);

                               }
                           }]
                       }
                   },
                    {
                        name: 'INTAKECALC', index: 'INTAKECALC', width: 100, align: "left", sortable: false, hidden: false
                    },
                     {
                         name: 'DAYS', index: 'DAYS', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false
                     },
                    {
                        name: 'DURATION', index: 'DURATION', width: 60, align: "left", sortable: false, searchoptions: { clearSearch: false }, hidden: false
                    },
                    {
                        name: 'FOOD', index: 'FOOD', width: 80, align: "left", sortable: false, hidden: false
                    },
                    {
                        name: 'DOSAGE', index: 'DOSAGE', width: 80, align: "left", sortable: false, hidden: false
                    },
                    {
                        name: 'REMARK', index: 'REMARK', width: 150, align: "left", sortable: false, hidden: false
                    },
                     {
                         name: 'GENERICID', index: 'GENERICID', width: 120, align: "left", sortable: false, hidden: false
                     },
                      {
                          name: 'GENERICNAM', index: 'GENERICNAM', width: 220, align: "left", sortable: false, hidden: false
                      },
                ],
                rowNum: 9999999999,
                sortname: 'id',
                width: 410,
                //footerrow: true,
                height: 200,
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
                    AddMedicineDetail(value[0].CODE, rowId);// added by vijeta on 6th july 2018
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
                    INTAKE: '----select----',
                    //GENERICID:$(this)[0].parentNode.nextSibling.innerText, //commented vijeta 16/4/19
                    // GENERICNAM: $(this)[0].parentNode.nextSibling.nextSibling.innerText//commented vijeta 16/4/19
                    GENERICID: $(this).siblings('#genericId')[0].innerText,//added vijeta 16/4/19
                    GENERICNAM: $(this).siblings('#genericName')[0].innerText //added vijeta 16/4/19
                };
                //$("#tblGrid").jqGrid('addRow', "new");
                var ids = jQuery("#tblGrid").jqGrid('getDataIDs');

                if($.inArray($(this)[0].defaultValue, ids) == -1)
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
                        s = "----Select----:----select----;";
                        for (i = 0; i < IntakeREsult.Intake.length; i++) {
                            s += IntakeREsult.Table[i].CODE + ":" + IntakeREsult.Table[i].INTAKE + ";";
                        }
                        s = s.substring(0, s.length - 1);
                    }
                }
            });
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
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)" id="lblDuraOther"><input type="radio" name="IntkeStatement" value="Other" autocomplete="off" checked="">Other</label>' +
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
                    //var checker = '';
                    //if (ResponseCheck1.hasOwnProperty("Table")) {
                    //    if (ResponseCheck1.Table.length > 0) {
                    //        checker = $.grep(ResponseCheck1.Table, function (n, i) {
                    //            return (n.MTRLCODE = result.Table[i].MTRLCODE);
                    //        });
                    //    }
                    //}
                    // if (checker.length == 0) {
                        var rows = "";
                        var options = "";
                        for (i = 0; i < result.Table.length; i++) {
                            var title = GeneralWiseYN == "Y" ? result.Table[i].GENERICNAM : result.Table[i].MTRLNAME;
                            var idstring = GeneralWiseYN == "Y" ? result.Table[i].GENERICID : result.Table[i].MTRLCODE;
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
                   // }
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
    </script>
</asp:Content>
