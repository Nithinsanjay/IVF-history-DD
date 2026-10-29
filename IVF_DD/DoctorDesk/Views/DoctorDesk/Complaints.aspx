<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div>

            <input style="width: 100%; background-color: #ecf0f5; margin-left: -17px; margin-top: -22px; position: fixed; display: none" class="empty">
        </div>
        <div id="MainDiv">
            <div style="width: 100%; text-align: center">
                <a class="button1 button1-green" id="divForBack" style="margin-bottom: 1.5%;" onclick="SetpageDirctn()">
                    <i class="fa fa-arrow-left"></i>
                    <strong>Back</strong>
                </a>
            </div>

            <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%; margin-top: 10px; display: flex;">
                <%--    <div class="InputWrapper">--%>
                <div class="StuckInput" style="margin-top: -25px;">
                    <label id="complaintAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Add new Complaint">
                        <img src="../Images/add.png" style="background-color: white; border-radius: 50%; position: fixed;">
                    </label>
                    <input type="text" id="ComplaintInput" onkeyup="SearchComplaint()" placeholder="&#xF002; Search Complaints" style="height: 29px; width: 55%; border-radius: 5px; margin-top: 4px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-left: 7px;" class="empty"><%----%><%--margin-top: 2px;--%>
                    <button id='freeHandBtn' style="border-radius: 50%; height: 30px; width: 28px; color: white; margin-top: 3px; background-color: #398ebd; border-color: transparent; outline-style: none;" title="Save Free Complaint"><span><i class="fa fa-pencil"></i></span></button>
                    <button id="PrevHistoryBtn" onclick="OpenCloseHistoryInfo('O');" style="display: inline-block; background-color: rgb(40, 167, 69); color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s, transform 0.2s; box-shadow: rgba(0, 0, 0, 0.1) 0px 4px 6px;" onmouseover="this.style.backgroundColor='#218838'" onmouseout="this.style.backgroundColor='#28a745'">
                        History
                    </button>
                </div>
                <%----%>
                <%--   </div>--%>

                <label id="btnSaveComplaints" style="background-color: transparent; float: right; margin-right: 25%; border-color: transparent; display: none;" title="Save">
                    <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                </label>

                <div id="wrapper" style="overflow: hidden; width: 100%">
                    <div class="tableDiv" style="padding-top: 12px;">
                        <table class="HeadPatTab" style="text-align: center">
                            <thead>
                                <tr style="background-color: #fffdc8; font-size: 12px">
                                    <th style="width: 65%;">Complaint</th>
                                    <th style="text-align: center; width: 20%;" colspan="2" class="Headdur">Duration</th>
                                    <th style="width: 15.79%;" class='HeadRemark'>Remark</th>
                                </tr>
                            </thead>

                        </table>
                        <%-- 4/22/19--%>
                        <table id="tblCmplts" class="table HeadPatTab" style="width: 100%">
                            <tbody id="tblsort" style="height: 50%"></tbody>
                        </table>
                        <%-- 4/22/19--%>
                    </div>
                </div>


                <div id="layer-demo" class="po__layer list">
                    <%--<a href="javascript:;">0</a>   --%>
                </div>
                <div id="layer-DMY" class="po__layer list">
                    <a href="javascript:;" onclick="SetText('D')" style="font-weight: 500; font-size: 16px">Days</a>
                    <a href="javascript:; " onclick="SetText('W')" style="font-weight: 500; font-size: 16px">Weeks</a>
                    <a href="javascript:; " onclick="SetText('M')" style="font-weight: 500; font-size: 16px">Months</a>
                    <a href="javascript:;" onclick="SetText('Y')" style="font-weight: 500; font-size: 16px">Years</a>
                </div>
            </div>
        </div>

        <%-- Added by Dhananjay 20250926 --%>
        <div style="position: fixed; bottom: 10%; left: 25%; right: 15%; bottom: 5%; text-align: center; z-index: 1000;">
            <button id="btnSave" onclick="SaveAllComplaints('SS');"
                style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                onmouseover="this.style.backgroundColor='#218838'"
                onmouseout="this.style.backgroundColor='#28a745'">
                Save
            </button>
        </div>

    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
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
            max-height: 280px;
            overflow-y: auto;
        }

        .StuckInput {
            width: 100%;
            position: fixed;
            /*top: 0;
            left: 0;*/
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            /*font-size: 14px !important;*/ /*commented by vijeta on 22nd march 2018*/
            font-size: 16px !important; /*added by vijeta on 22nd march 2018*/
            text-decoration: inherit;
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

        .number-select {
            width: 20px;
        }

        .Days-select {
            width: 9px;
        }

        select {
            -webkit-appearance: none;
            -moz-appearance: none;
            text-indent: 1px;
            width: 18px;
            background-color: #abdaf5;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 26px;
            outline: 0;
        }

      
        .empty {
            width: 62%;
        }

        .HeadPatTab > thead > tr > th {
                text-align: center;
                border: 1px solid #ede4e4;
                height: 22px;
                font-size: 10px;
            }
       
        @media only screen and (min-width : 992px) {
            .empty {
                width: 56%; /*//4/10/19*/
            }
        }

        .HeadRemark {
            width: 16%;
        }

        .Headdur {
            width: 19.9%;
        }
        
        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) { /*//4/23/19*/
            .empty {
                width: 80%;
            }

            .duration {
                width: 12% !important;
            }

            day-td {
                width: 12% !important;
            }

            .HeadRemark {
                width: 16.8%;
            }

            .Headdur {
                width: 22.3%;
            }

            .HeadPatTab > thead > tr > th {
                text-align: center;
                border: 1px solid #ede4e4;
                height: 22px;
                font-size: 10px;
            }
        }

        #tblCmplts tr td:not(:first-child) {
            width: 10%;
            text-align: center;
        }

            #tblCmplts tr td:not(:first-child) a {
                width: 98%;
                display: block;
            }

              @media only screen and (min-device-width : 1024px)and (max-device-width : 1152px) {

           .HeadRemark {
                width: 15.99% !important;
            }
        }

        @media only screen and (min-device-width : 640px) and (max-device-width : 767px) {
            .empty {
                width: 85%;
            }

            .duration {
                width: 12% !important;
            }

            day-td {
                width: 12% !important;
            }

            .HeadRemark {
                width: 16%;
            }

            .Headdur {
                width: 22%;
            }

            
        }
    </style>
    <%-- <script src="../plugins/alert/jquery-confirm.js"></script>
    <link href="../plugins/alert/jquery-confirm.css" rel="stylesheet">--%>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>
    <script type="text/javascript">
        var newlyAddedComplaint = "";//added on 18th sep 2018  
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var idOfDMY = "";
        var daysPas = "";
        var numPass = "";
        var firstOptnYN = "Y";
        var RowCount = 0;
        var freeHandComplaint = "";
        var addclick = false;  
        var FreqDataSetupList = "";
        var pathFrom = "";
        $(document).ready(function (e) {

            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');
            HoldOn.open();//

            SetPatientDtl();
            document.getElementById('ComplaintInput').focus();    //added by kavita
            //AddClinics(urls);//commented vijeta 30/4/19
            AddComplaints(addclick); //06-12-2019 17:43
            //var documentWidth = $(document).width();

           
           

            if ($(window).width() >= 996) {
                //screen width size comparion

                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                //kavita 12-aug-2019
                // dispLst.style.display = "block";  
                $("#slide_sdList").click();

                // $("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                ActiveMenu("Complaint");
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }


            if (pathFrom != "") {//
                $("#divForBack").hide();
                $('#menuBar').removeAttr('disabled');
            }
            else {

                $("#divForBack").show()

                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
                $("#Complaint").show();
                $("#Examination").hide();
                $("#Diagnosis").hide();
                $("#RxDesktop").hide();
                $("#Investigation").hide();
                $("#RxNewSearch").hide();
                $("#PatAdviceLi").hide();
                $("#PresPrint").hide();
                $("#Vitals").hide();
                $("#PresClinicalNotes").hide();
                $("#PresChemo").hide();
                $('#menuBar').attr('disabled', 'disabled');

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

            $("#btnSaveComplaints").click(function () {

                SaveAllComplaints("N");

            });

            $("#complaintAdd").click(function () {
                $.confirm({
                    title: '',
                    boxWidth: '90%',    
                    useBootstrap: false,
                    content: '' +
                        '<style>' +
                        '.custom-popup .jconfirm-box { min-width: 300px !important; }' +
                        '</style>' +
                    '<form action="" class="formName" style="height:134px">' +
                    '<div class="form-group">' +
                    '<label>Complaint</label>' +
                     '<textarea type="varchar" id="txtComplaint" maxlength="120"  placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required  rows="5" cols="30"  />' +//added length kavita 
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                //var cmplnt = this.$content.find('.complaint').val().toString().replace(/\s/g, ''); //27-11-2019 12:16  commented by Meenakshi on 30/11/2019 problem was all spaces are getting removed between the words 
                                var cmplnt = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' '); //Meenakshi  30/11/2019
                                var grpCode = "";
                                if (cmplnt.length == 0) {  //27-11-2019 12:16
                                    $.alert('Enter Complaint');
                                    this.$content.find('.complaint').val(""); //added by 10/12/2019 12:37
                                    return false;
                                }
                                if (cmplnt != "") {
                                    $.ajax({
                                        type: "post",
                                        datatype: "json",
                                        url: 'AddComplaint',
                                        data: { strComplaint: cmplnt, strGrpCode: grpCode },
                                        success: function (response) {
                                            if (("" + response).toUpperCase().indexOf("SUCCESS") != -1) {
                                                $("#txtComplaint").val("");
                                                //$.messager.alert("Information", response);
                                                //  $.messager.alert("Information", "Record inserted successfully");
                                                //SaveAllComplaints("Y");
                                                //addclick = true; //06-12-2019 17:43
                                                //AddComplaints(addclick); //added by 06/12/2019 16:46
                                                newlyAddedComplaint = response.split(' ').pop().trim(); //13/12/2019 15:00    



                                                //...................18-12-19.......................................
                                                var rows = "<tr class='clickable-row" + ' Tr' + RowCount + "'  id='" + newlyAddedComplaint + "'>" + "<td style='padding:5px;text-align:left; font-size: 14px;text-align:left;width:65%' class='CmplntNm'>" + cmplnt.trim() + "</td>" +
                               //"<td class='day-td'><label class='lblDay'>Days</label></td>" +
                                "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + newlyAddedComplaint + "' style='display:none;font-weight:800;font-size:16px'>D</a></td>" +
                                "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + newlyAddedComplaint + "' style='display:none;font-weight:800;font-size:16px'>0</a></td>" +
                                "<td class='complainRemark' style='width:15%'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddComplainRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                "<td class='tdSetUpYn' style='display:none;'></td>" +
                                   "<td class='RemarkText' style='display:none;'></td>" +
                                "</tr>";

                                                $("#tblCmplts tbody").prepend(rows).closest('tr');
                                                $('#tblCmplts tr#' + newlyAddedComplaint).trigger('click');

                                                RowCount++;
                                                //..............................................................
                                            }
                                            else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                                var jc = this;
                                                //jc.$formSubmit.trigger('click');
                                                //$.messager.alert("Information", "This complaint is already Present.");
                                                $('#ComplaintInput').val(cmplnt);//
                                                AfterSameComplaintPresent(cmplnt) //pradnnya 10-12-2019
                                                SearchComplaint();//
                                            }
                                            else {
                                                $.messager.alert("Information", response);
                                            }
                                        },

                                    });
                                }

                            }
                        },
                        CLOSE: function () {
                            //close
                            //$('.FoodItems input:checked').focus();
                        },
                    },
                    onContentReady: function () {
                        $('#txtComplaint').focus();
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

            // register the handler 
            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys

            $(document.body).on('click', '#tblCmplts td a,#tblCmplts td', function (e) {

                if (!$(this).is('.CmplntNm'))
                    e.stopPropagation();
            });

            $("#freeHandBtn").click(function () {
                var Mrno = ($.session.get('PatMRNO'));
                var strTran = ($.session.get('PatTRANNO'))
                $.confirm({
                    title: '',
                    boxWidth: '90%',
                    useBootstrap: false,
                    content: '' +
                        '<style>' +
                        '.custom-popup .jconfirm-box { min-width: 300px !important; }' +
                        '</style>' +
                    '<form action="" class="formFreeText" >' +
                    '<div class="form-group">' +
                    '<label>Other Complaints</label>' +
                    '<textarea id="txtFreeComplaint" maxlength="3000"  placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required rows="10" cols="50" />' +//added length kavita
                    //'<input  type="varchar" id="txtFreeComplaint" maxlength="50"  placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required />' +//added length kavita
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                //var cmplnt = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');;  THIS LINE WAS USED TO replace ALL such as spaces, tabs, and newlines with a single space we want to spaces, new line in this so we commented this line
                                var cmplnt = this.$content.find('.complaint').val().toString().trim();
                                if ($("#freeHandBtn").css("background-color") != "rgb(0, 128, 0)") {  //27-11-2019 12:16
                                    if (cmplnt.length == 0) {
                                        $.alert('Enter Complaint');
                                        this.$content.find('.complaint').val(""); //added by 10/12/2019 12:37
                                        return false;
                                    }
                                }
                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'AddFreeComplaint',
                                    data: { strComplaint: cmplnt, strTran: strTran, strMrNo: Mrno },
                                    success: function (response) {

                                        if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                                            $.messager.alert("Information", "Record Not Inserted.");
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                            var jc = this;

                                            $.messager.alert("Information", "This complaint is already Present.");
                                        }
                                        else {
                                            $("#txtFreeComplaint").val(cmplnt);
                                            freeHandComplaint = cmplnt;

                                            if (cmplnt != "") {
                                              //  $.messager.alert("Information", "Record inserted successfully");
                                                //$("#tblCmplts tr").prop("disabled", true); //commented by vijeta on 18th mrch 19
                                                $("#freeHandBtn").css("background-color", "green");
                                                //$("#tblCmplts tr").removeClass("active");//commented by vijeta on 18th mrch 19
                                                //$("#tblCmplts tr a").hide();//commented by vijeta on 18th mrch 19
                                            }
                                            else {
                                              //  $.messager.alert("Information", "Complaint removed");
                                                //$("#tblCmplts tr").removeProp("disabled", true); //commented by vijeta on 18th mrch 19
                                                $("#freeHandBtn").css("background-color", "#398ebd");
                                            }

                                        }
                                    },

                                });
                                // }

                            }
                        },
                        REMOVE: function () {
                            $("#txtFreeComplaint").val("");
                            $('.formFreeText').submit();
                        },
                        CLOSE: function () {
                            //close
                            //$('.FoodItems input:checked').focus();
                        },
                    },
                    onContentReady: function () {
                        $('#txtFreeComplaint').focus();
                        $('#txtFreeComplaint').val(freeHandComplaint);
                        // bind to events
                        var jc = this;
                      
                        this.$content.find('form').on('submit', function (e) {
                            // if the user submits the form by pressing enter in the field.
                            e.preventDefault();
                            jc.$$formSubmit.trigger('click'); // reference the button and click it
                        });
                        //29-11-2019  18:37
                        if ($('#txtFreeComplaint').val() == "") {
                            jc.$$REMOVE.attr("style", "display:none")
                        }
                    }
                });
            });
        });


        function SetText(str) {

            $("#" + idOfDMY).text(str);

            //vijeta 26/4/19
            if (idOfDMY.toUpperCase().indexOf("DAYS") != -1)
                $("#" + idOfDMY).parents('td').nextAll('td.duration').find('a.trigger2').trigger('click');

            //Commented by meenakshi 28/04/2019 not required 
            //else if (idOfDMY.toUpperCase().indexOf("NUM") != -1)
            //    $("#" + idOfDMY).parents('td').nextAll('td.complainRemark').find('a.trigger3').trigger('click');
            /// ----- //
        }

        function AddComplaints(addclick) {  //06/12/2019 16:47
            var strClinincode = "";
           
                strClinincode = ( "" + $.session.get('ClinicCode')).toString().trim();

            var DataToSend = {
                ClinicCode: strClinincode
            };

            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetMainCompList","DoctorDesk")%>",
                data: DataToSend,
                success: function (result) {

                    if (result != "" && result.toUpperCase() != "UNSUCCESSFULL") //condition added by vijeta 26/4/19
                    {
                        var tbResult = JSON.parse(result);
                        var rows = "";
                        $('#tblCmplts tbody').empty();

                        if (tbResult.hasOwnProperty("Table1")) {
                            RowCount = tbResult.Table1.length;
                        }
                        
                        FreqDataSetupList = tbResult.Table1;
                        $.each(tbResult.Table1, function (i, item) {

                            var rows = "<tr class='clickable-row" + ' Tr' + (i + 1) + "'  id='" + item.CODE.trim() + "'>" + "<td style='padding:5px;text-align:left; font-size: 14px;text-align:left;width:65%' class='CmplntNm'>" + item.NAME.trim() + "</td>" +
                                //"<td class='day-td'><label class='lblDay'>Days</label></td>" +
                                 "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>D</a></td>" +
                                 "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>0</a></td>" +
                                 "<td class='complainRemark' style='width:15%'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddComplainRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                 "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                    "<td class='RemarkText' style='display:none;'></td>" +//16-12-2019 10:36
                                 "</tr>";
                            $('#tblCmplts tbody').append(rows);

                        });//4/22/19
                    }


                },
                complete: function () {
                    //addclick = true;  //06/12/2019 17:44
                        SetDataForComplaints();
                   

                    //if ($('#tblCmplts').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");

                    //}
                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });
        }
        function SearchComplaint() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            input = document.getElementById("ComplaintInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblCmplts");
            var tr = $("#tblCmplts  tr");

            // Loop through all table rows, and hide those who don't match the search query
            
            if ($(input).val().length >= 3) {
                GetDatabaseComplain(filter, tr);
            } else {
                var tr = $("#tblCmplts  tr").not(".active").remove();
                //var elem = $("#SrvcGrpdata" + data + " li input[type='checkbox']").not(":checked").parent().remove();

                var checdelem = $("#tblCmplts  tr.active");

                if ($(input).val().length == 0) {

                    for (var i = 0; i < checdelem.length; i++) {
                        // divsToHide[i].style.visibility = "hidden"; // or
                            checdelem[i].style.display = "";
                            if (!$(checdelem[i]).hasClass('display')) {
                                $(checdelem[i]).addClass('display')
                            }
                    }
                }
                else
                {
                    for (i = 0; i < checdelem.length; i++) {
                        $(checdelem[i]).removeClass('display');
                        td = checdelem[i].getElementsByTagName("td")[0];
                        if (td) {
                            if (td.innerText.toUpperCase().indexOf(filter) > -1) {
                                checdelem[i].style.display = "";
                                if (!$(checdelem[i]).hasClass('display')) {
                                    $(checdelem[i]).addClass('display')
                                }
                            } else {
                                checdelem[i].style.display = "none";
                            }
                        }
                    }                  
                }

                if (FreqDataSetupList != "") {
                    $.each(checdelem, function (j, item) {
                        td = checdelem[j].getElementsByTagName("td")[0];
                        if (td)
                            FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {
                                return FreqDataSetupList[index]["CODE"].toString().trim() != td.parentElement.id.toString().trim();
                            });
                    });

                    i = checdelem.length;
                    $.each(FreqDataSetupList, function (i, item) {

                        //var title = item.NAME;
                        //var idstring = item.CODE;
                        //$("#SrvcGrpdata" + data).append("<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>");


                        var rows = "<tr class='clickable-row" + ' Tr' + (i + 1) + "'  id='" + item.CODE.trim() + "'>" + "<td style='padding:5px;text-align:left; font-size: 14px;text-align:left;width:65%' class='CmplntNm'>" + item.NAME.trim() + "</td>" +
                                   //"<td class='day-td'><label class='lblDay'>Days</label></td>" +
                                    "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>D</a></td>" +
                                    "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>0</a></td>" +
                                    "<td class='complainRemark' style='width:15%'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddComplainRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                    "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                       "<td class='RemarkText' style='display:none;'></td>" +//16-12-2019 10:36
                                    "</tr>";
                        $('#tblCmplts tbody').append(rows);
                    });

                }

            }
            HoldOn.open();//

           // tr = table.getElementsByTagName("tr");
            var tr = $("#tblCmplts  tr");
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if (td.innerText.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        if (!$(tr[i]).hasClass('display')) {
                            $(tr[i]).addClass('display')

                        }
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
           
            HoldOn.close();//
           

        }

        //....................................................
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



                        $("#SrvcGrpdata" + data).append("<li><input type=checkbox id='" + item.MTRLCODE.trim().replace(/[^0-9a-zA-Z]/gi, '') + "' title='" + item.MTRLNAME.toString().trim() + "' value='" + item.MTRLCODE.trim() + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + item.MTRLNAME.toString().trim() + "</label><label id='genericId' style='display:none'></label><label id='genericName' style='display:none'></label><li>");

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


        function SetpageDirctn() {
            SaveAllComplaints();
            if (pathFrom == "") {
                window.location.href = '../ClinicalNotes/ClinicEntry';
            } else
                window.location.href = '../DoctorDesk/PatientEntry';
        }


        //.................................................


        //10/12/2019  11:30
        function AfterSameComplaintPresent(cmplnt) {
            var table = document.getElementById("tblCmplts");
            var tr = table.getElementsByTagName("tr");
            //for (i = 0; i < tr.length; i++) {
            //    $(tr[i]).removeClass('display');
            //    td = tr[i].getElementsByTagName("td")[0];
            //    if (td) {
            //        if (td.innerHTML.toUpperCase().toString().trim() == cmplnt) {
            //            tr[i].style.display = "";
            //            if (!$(tr[i]).hasClass('display')) {
            //                $(tr[i]).addClass('display')
            //            }
            //        } else {
            //            tr[i].style.display = "none";
            //        }
            //    }
            //}
            var strClinincode = $.session.get('ClinicCode').toString().trim();

            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetDBComplainList","DoctorDesk")%>",
                async: false,
                data: { complainName: cmplnt, ClinicCode: strClinincode },
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        var rows = "";

                        var AllreadyPresent = jQuery.grep(result.Table1, function (element, index) {
                            Name = cmplnt;
                            return ((element.NAME).toString().trim().toUpperCase() == cmplnt.toString().trim().toUpperCase());
                        });


                        $.each(AllreadyPresent, function (i, item) {
                            $('#ComplaintInput').val("");
                            var MatchElement = jQuery.grep(tr, function (element, index) {
                                //Name = element.getElementsByTagName("td")[0].innerText;
                                Name = element.getElementsByTagName("td")[0].innerHTML;
                                return ((item.NAME).toString().trim().toUpperCase() == Name.toString().trim().toUpperCase());
                            });

                            if (MatchElement.length > 0) {
                                //Do not bind
                                if ($('#tblCmplts tr#' + MatchElement[0].id).hasClass("active") == false)
                                $('#tblCmplts tr#' + MatchElement[0].id).trigger('click');
                            }
                            else {
                                var rows = "<tr class='clickable-row" + ' Tr' + (RowCount + 1) + "'  id='" + item.CODE.trim() + "'>" + "<td style='padding:5px;  text-align:left;text-align:left;   font-size: 14px;width:65%' class='CmplntNm'>" + item.NAME.trim() + "</td>" +
                                //"<td class='day-td'><label class='lblDay'>Days</label></td>" +
                                 "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>D</a></td>" +
                                 "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>0</a></td>" +
                                 "<td class='complainRemark' style='width:15%'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddComplainRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                  "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                     "<td class='RemarkText' style='display:none;'></td>" +//16-12-2019 10:36
                                 "</tr>";
                                $('#tblCmplts tbody').append(rows);
                                $('#tblCmplts tr#' + item.CODE.trim()).trigger('click');
                                RowCount++;

                            }//4/22/19

                        });
                    }
                },
                complete: function () {
                    HoldOn.close();//
                    //if ($('#tblCmplts').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");

                    //}

                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });


        }

        function GetDatabaseComplain(filter, obj) {
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
                        $.each(result.Table1, function (i, item) {
                            
                            var MatchElement = jQuery.grep(obj, function (element, index) {
                                Name = element.getElementsByTagName("td")[0].innerHTML.split("-")[0];
                               // Name = $(element)[0].cells[0].innerText.split("-")[0];
                                return ((item.NAME).toString().trim().toUpperCase() == Name.toString().trim().toUpperCase());
                            });

                            if (MatchElement.length > 0) {
                                //Do not bind
                            }
                            else {
                                var rows = "<tr class='clickable-row" + ' Tr' + (RowCount + 1) + "'  id='" + item.CODE.trim() + "'>" + "<td style='padding:5px;  text-align:left;text-align:left;   font-size: 14px;width:65%' class='CmplntNm'>" + item.NAME.trim() + "</td>" +
                                //"<td class='day-td'><label class='lblDay'>Days</label></td>" +
                                 "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>D</a></td>" +
                                 "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.CODE.trim() + "' style='display:none;font-weight:800;font-size:16px'>0</a></td>" +
                                 "<td class='complainRemark' style='width:15%'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddComplainRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                                  "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                     "<td class='RemarkText' style='display:none;'></td>" +//16-12-2019 10:36
                                 "</tr>";
                                $('#tblCmplts tbody').append(rows);
                                RowCount++;
                            }//4/22/19
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();//
                    //if ($('#tblCmplts').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");

                    //}

                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });

        }


        function AddComplainRemark(object, e) {
            e.stopPropagation();
            var RemarkText = ""
  
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Complaint Remark</label>' +
                '<textarea rows="5" id="txtComplaintRemark" maxlength="495" placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required></textarea>' +//kavita
                //'<input  type="varchar" id="txtComplaintRemark" maxlength="200"  placeholder="Complaint" autofocus="autofocus" class="complaint form-control" required />' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            //17/12/2019 11:09
                            var cmplnt = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');
                            if ($(object).parent().siblings('.RemarkText')[0].innerText == "") {
                                if (cmplnt.length == 0) {
                                    $.alert('Enter Remark');
                                    this.$content.find('.complaint').val(""); //added by 10/12/2019 12:37
                                    return false;
                                }

                            }
                            if (RemarkText != "" || RemarkText != "undefined") {
                                $(object).parent().siblings('.RemarkText').remove();
                            }

                            var CurrentRow = $(object).parent().parent();
                            stringRemarkTd = "<td class='RemarkText' style='display:none'>" + $('#txtComplaintRemark').val() + "</td>";
                            var firstChildVal = $(CurrentRow).find('td:nth-child(1)').text().trim();
                            var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + $('#txtComplaintRemark').val() + '</span>'
                            $(CurrentRow).find('td:nth-child(1)').children().remove();
                            //$(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark); //commented by 05-12-2019 18:31
                            if ($("#txtComplaintRemark").val() != "") { $(CurrentRow).find('td:nth-child(1)').append(ComplainwithRemark); }  //05-12-2019 18:31
                            CurrentRow.append(stringRemarkTd);
                        }
                    },
                    REMOVE: function () {
                        $("#txtComplaintRemark").val("");
                        $('.formName').submit();
                        },
                    close: function () {
                    },
                },
                onContentReady: function () {
                    $('#txtComplaintRemark').focus();
                    RemarkText = $(object).parent().siblings('.RemarkText')[0].innerText; //added by Meenakshi 30/11/19
                    $('#txtComplaintRemark').val(RemarkText);
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });
                    //29-11-2019  18:37
                    if ($('#txtComplaintRemark').val() == "") {
                        jc.$$REMOVE.attr("style", "display:none")
                    }
                }
            });

        }

        function SetDataForComplaints() {
            var tranNo = $.session.get('PatTRANNO');
            if (typeof tranNo == 'undefined' || tranNo == null) { HoldOn.close(); }//
            $.ajax({
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo },
                url: 'SetDataForComplaints',
                success: function (data) {
                    if (data != "") {
                        if (data[0] != null) {
                            var table = $('#tblCmplts');
                            for (var i = 0; i < data[0].length; i++) {
                                flagCheckRowsCmplnt = true;
                                var rowCount = table[0].rows.length;

                                //var row = table[0].insertRow(rowCount);// commented by vijeta on 19th sep 2018
                                if ($('#tblCmplts tr#' + data[0][i]["DESCCD"] + ' td.day-td')[0] != undefined) {

                                    $('#tblCmplts tr#' + data[0][i]["DESCCD"] + ' td.day-td')[0].innerHTML = "<a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + data[0][i]["DESCCD"] + "' style='display:none;font-weight:800;font-size:16px'>" + data[0][i]["DURTYPE"] + "</a>";
                                    $('#tblCmplts tr#' + data[0][i]["DESCCD"] + ' td.duration')[0].innerHTML = "<a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + data[0][i]["DESCCD"] + "' style='display:none;font-weight:800;font-size:16px'>" + data[0][i]["DURATION"] + "</a>";
                                    //commented by 17/12/2019
                                    //var colRemark = "<td class='RemarkText' style='display:none'>" + data[0][i]["REMARKS"].toString().trim() + "</td>";

                                    //$('#tblCmplts tr#' + data[0][i]["DESCCD"]).append(colRemark);
                                    $('#tblCmplts tr#' + data[0][i]["DESCCD"]).find('.RemarkText')[0].innerText = data[0][i]["REMARKS"].toString().trim(); //17/12/2019

                                    if (data[0][i]["REMARKS"].toString().trim() != "") {
                                        var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + data[0][i]["REMARKS"].toString().trim() + '</span>'
                                        $('#tblCmplts tr#' + data[0][i]["DESCCD"]).find('td:nth-child(1)').append(ComplainwithRemark);
                                    }

                                    $('#tblCmplts tr#' + data[0][i]["DESCCD"] + ' td.tdSetUpYn')[0].innerText = data[0][i]["SETUPYN"]; //added on 25th July 2019

                                    $('#tblCmplts tr#' + data[0][i]["DESCCD"]).trigger('click');
                                }
                                else
                                {
                           
                                    //Added by meenakshi on 18/08/2020
                                   
                               var ComplainwithRemark = '<strong><span style="font-size:14px;">   -  </span></strong><span>' + data[0][i]["REMARKS"].toString().trim() + '</span>'

                               var rows = "<tr class='clickable-row" + ' Tr' + (rowCount + 1) + "'  id='" + data[0][i]["DESCCD"] + "'>" + "<td style='padding:5px;  text-align:left;text-align:left;   font-size: 14px;width:65%' class='CmplntNm'>" + data[0][i]["DESC"] + "</td>" +
                               "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + data[0][i]["DESCCD"] + "' style='display:none;font-weight:800;font-size:16px'>" + data[0][i]["DURTYPE"] + "</a></td>" +
                               "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + data[0][i]["DESCCD"] + "' style='display:none;font-weight:800;font-size:16px'>" + data[0][i]["DURATION"] + "</a></td>" +
                               "<td class='complainRemark' style='width:15%'><a class='trigger3' href='javascript:;' style='display:none' onclick='AddComplainRemark(this,event);'><i class='fa fa-pencil fa-2x' aria-hidden='true'></i></a></td>" +
                               "<td class='tdSetUpYn' style='display:none;'>" + data[0][i]["SETUPYN"] + "</td>" +
                               "<td class='RemarkText' style='display:none;'>" + data[0][i]["REMARKS"] + "</td>" +
                               "</tr>";
                               $('#tblCmplts tbody').append(rows);

                               if (data[0][i]["REMARKS"].toString().trim() != "")
                                   $('#tblCmplts tr#' + data[0][i]["DESCCD"]).find('td:nth-child(1)').append(ComplainwithRemark);

                                    $('#tblCmplts tr#' + data[0][i]["DESCCD"]).trigger('click');
                                }
                            }
                        }
                        if (data[1] != null) {
                            if (data[1][0]["FreeComplaint"] != "") {
                                freeHandComplaint = data[1][0]["FreeComplaint"].toString();
                                $("#freeHandBtn").css("background-color", "green");
                                //$("#tblCmplts tr").prop("disabled", true);
                                $("#txtFreeComplaint").val(data[1][0]["FreeComplaint"].toString());
                                if (addclick == false)
                                $("#freeHandBtn").trigger('click');//added on 3rd jan 2109
                            }
                        }
                    }
                },
                //added on 18th sep 2018
                complete: function () {
                    flagCheckRowsCmplnt = false;
                   // if (newlyAddedComplaint != "")
                     //   $('#tblCmplts tr#' + newlyAddedComplaint).trigger('click');
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                }
            });
        }

        function SaveAllComplaints(strPlusBtn) {
            HoldOn.open();//
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var cmpltArr = [];
            var rows = $('#tblCmplts > tbody > tr.active').get();
            //if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                var code = rows[i].id
                var durType = rows[i].cells[1].innerText;
                var dur = rows[i].cells[2].innerText;
                var RemarkElement = $(rows[i]).children('.RemarkText');
                var ComplainRemark = $(RemarkElement).text();
                var setupYn = $(rows[i]).children('td.tdSetUpYn')[0].innerText; //added on 25/7/19
                var a = {
                    DESCCD: code,
                    DURTYPE: durType,
                    DURATION: dur,
                    REMARKS: "" + ComplainRemark,
                    GRPCD: "",
                    SETUPYN: setupYn,//added on 25/7/19
                };
                cmpltArr.push(a);
            }

            $.ajax({
                type: "POST",
                url: 'SaveComplaints',
                datatype: "json",
                data: { strComplaints: JSON.stringify(cmpltArr), strMRNO: mrno, strTranNo: tranNo },
                success: function (result) {

                    if (strPlusBtn == 'SS') {
                        if (result != true)
                            $.messager.alert("Info", 'Please try again');
                    } else {
                        if (pathFrom == "") {
                            window.location.href = '../ClinicalNotes/ClinicEntry';
                        } else {
                            if (strPlusBtn == "N")
                                window.location.href = '../DoctorDesk/PatientEntry';
                        }
                    }
                   
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                }
            });
        }

        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './Complaints');

                $(window).on('popstate', function () {
                    SaveAllComplaints("N")
                });
            }
        });



    </script>
</asp:Content>
