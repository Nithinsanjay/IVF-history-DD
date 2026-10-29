<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
        <head>
            <title></title>
        </head>
        <body>
     <div>
        <input style="width: 100%; background-color: #ecf0f5; margin-left: -17px; margin-top: -22px; position: fixed;display:none;" class="empty">
    </div>
    <div id="MainDiv">

            <div id="ContentHolderDiv" class="contentHoldClass" style="width:100%;margin-top: 15px;">
            <%--    <div class="InputWrapper">--%>
           <div class="StuckInput" style="margin-top: -25px;">
                <label   id="myAdd" style="background-color: transparent; float: left;  margin-left: -8px;  margin-right: 24px; border-color: transparent;" title="Add New Advice"><%----%>
                      <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; ">
                 </label>
                <%----%>
                <input type="text" id="PatAdviceInput" onkeyup="SearchPatAdvice()" placeholder="&#xF002; Search Patient Advice" style="height:28px; border-radius: 5px;border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black;    -moz-box-shadow: 0 8px 6px -6px black;    box-shadow: 0 7px 4px -6px rgb(181, 181, 181);margin-top: 2px;margin-left: 7px;" class="empty">
                <button type="button" class="btn btn-info margin" style=" padding: 2px 12px; font-size: 14px; margin-left: 4px; margin-top: -7px;" id="btnPersonalized">Pers...</button><%-- added by vijeta on 17th sep 2018--%> <%----%>
                <button id='freeHandBtn' style="border-radius: 50%;height: 28px;width: 28px;color: white;margin-top: 3px;background-color: #398ebd;border-color: transparent; outline-style: none;vertical-align: super;" title="Add Other Advice"><span><i class="fa fa-pencil"></i></span></button>
             </div>
            <%--</div>--%>
            <label   id="myBtn" style="background-color: transparent; float: right;    margin-right: 25%;   border-color: transparent;display:none;" title="Save">
                      <img src="../Images/check-round.png"  style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                 </label>
          <div id="wrapper" style="overflow: hidden;width:100%">
                <div class="tableDiv" style="padding-top: 9px;">
                    <table class="HeadPatTab" style="text-align:center;"><thead> <tr style="background-color:#fffdc8"><th style="width: 101%;">Patient Advice</th></tr></thead>
                        
                        </table><%-- 4/11/19--%>
                    <table id="tblpatadv" class="table HeadPatTab" style="width: 100%">
                        <tbody id="tblsort" style="height:100%"></tbody> <%--tblsort added vijeta 19/4/19--%>
                    </table>
                </div>
            </div>
             <div id="layer-demo" class="po__layer list">
                <%--<a href="javascript:;">0</a>   --%>
            </div>
            <div id="layer-DMY" class="po__layer list">
                <a href="javascript:;" style="text-decoration: none;" onclick="SetText('D')">Days</a>
                <a href="javascript:; " style="text-decoration: none;" onclick="SetText('M')">Months</a>
                <a href="javascript:;" style="text-decoration: none;" onclick="SetText('Y')">Years</a>
            </div>
        </div>
    </div>
                  <%-- Added by Dhananjay 20250926 --%>
      <div style="position: fixed; bottom: 20px; left: 25%; right: 15%; text-align: center; z-index: 1000;">
            <button id="btnSave" onclick="SavePatientAdvice('SS');"
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
       
            tr:after {
                content: ' ';
                display: block;
                visibility: hidden;
                clear: both;
            }


        /*tbody {
            height: 280px;
            overflow-y: auto;
        }*/

        .StuckInput {
            width: 100%;
            position: fixed;
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-decoration: inherit;
            font-size: 16px !important; /*added by vijeta on 22nd march 2018*/
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
                max-width:100%;
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
                color:#555
            }

                        Label {
            margin-left: 5px;
        }

       /*added by vijeta on 22nd march 2018*/
        .empty {
            width: 62%;
        }

          /* added by vijeta on 22nd sep 2018*/
       .searchlistclass {
            list-style-type: none;
            list-style-position: inside;
            overflow: auto;
            color: #000;
            font-weight: normal;
        }
        /*added by vijeta on 22nd march 2018*/
           @media only screen and (min-width : 992px) {
            .empty {
                width: 59%;
            }
             #PatAdviceInput{
                width:52%
                /*//*/
            }

              /*added by vijeta on 7/03/19 */
             .divtblInvestigation{
                height: 500px !important;
                overflow-y: hidden !important;
             }
              .divtblInvestigation:hover {
                    overflow-y: scroll !important;
                }
        }

        /*added by vijeta on 22nd march 2018*/
        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            .empty {
                width: 85%;
            }

              #PatAdviceInput{
                width:70%
            }
        }

          /* added by vijeta on 07/03.19 */
        .divtblInvestigation {
            height: 300px;
            overflow-y: scroll;
        }

        div.divtblInvestigation::-webkit-scrollbar {
            width: 8px;
        }

        div.divtblInvestigation::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        div.divtblInvestigation::-webkit-scrollbar-thumb {
            background: #b4b6f2;
            border-radius: 3px;
        }

         thead th {
                height: 30px;
element.style {
}
tbody {
                text-align: left;
            }

        #tblPersInvestigationlist > tbody > tr > td {
            border-top: 1px solid rgba(234, 228, 228, 0.32) !important;
        }
           .mediAddspan {
              float: right;
              margin-right: 6px;
              margin-top: -28px;
              position: relative;
              z-index: 2;
              color: #3d7da3;
              cursor: pointer;
          }/* 16-12-19*/
        /*----------------------------------------*/
    </style>
    <%-- <script src="../plugins/alert/jquery-confirm.js"></script>
    <link href="../plugins/alert/jquery-confirm.css" rel="stylesheet">--%>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var newlyAddedAdvice = "";//added on 19th Sep  2018
        var idOfDMY = "";
        var srvcgrpname = "dblServiceHelpsrvcgrp"; //added on 17th Sep  2018
        var rxnewTaper = 0;
        var NonFreqDataSetupList = '';
        var FreqDataSetupList = '';
        var freeHandPatAdvice = "";
        GetSetUpList("Advice");//added on 1st oct 2018

        $(document).ready(function (e) {
            HoldOn.open();//
            SetPatientDtl();
	        document.getElementById('PatAdviceInput').focus() //added by kavita
           
            AddPatAdvice();

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                //kavita 12-aug-2019
                // dispLst.style.display = "block";  
                $("#slide_sdList").click();

                // $("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                $("#PatAdviceSetUpList").css("display", "block");// added by vijeta on 1st oct 2018
                ActiveMenu("PatAdviceLi");
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
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' style='    text-decoration: none;' id='NumDaysSc'>" + i + "</a>";
                $("#layer-demo").append(s);
            }


            $('.trigger1').po({
                alignment: 'center'
            });
            $('.trigger2').po({
                alignment: 'center'
            });

            //$('.trigger1').click(function (e) {
            //    e.stopPropagation();
            //});
            //$('.trigger2').click(function (e) {
            //    e.stopPropagation();
            //});

            $("#layer-demo .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
            });

            $("#myBtn").click(function () {
                SavePatientAdvice("N");
            });

            $("#myAdd").click(function () {
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
                  //  
                  '<label>Patient Advice</label>' +
                  '<textarea type="varchar" id="txtPatAdv" maxlength="250"  placeholder="Patient Advice" autofocus="autofocus" class="complaint form-control" required  rows="5" cols="30"  />' +//added length kavita 
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                //17/12/2019 14:46
                                var patadv = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');
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
                                            //    $("#txtPatAdv").val("");
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
                                               // $.messager.alert("Information", "This Advice is already Present.");
                                                $("#PatAdviceInput").val(patadv);//
                                                // SearchPatAdvice();
                                                afterSearchPatAdvicepresent(patadv);//added by 10/12/2019
                                            }
                                            else {
                                                $("#txtPatAdv").val("");
                                                //$.messager.alert("Information", response);
                                                //  $.messager.alert("Information", "Record inserted successfully");
                                                //SavePatientAdvice("Y");
                                                //AddPatAdvice();
                                                newlyAddedAdvice = response.split(' ').pop().trim(); //13/12/2019 14:40
                                                // 18-12-19
                                                var rows = "<tr class='clickable-row' id='" + newlyAddedAdvice + "'>" + "<td style='padding:5px;    font-size: 14px;width:100%;text-align:left;'>" + patadv + "</td>" +
                                   "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                              "</tr>";

                                                $("#tblpatadv tbody").prepend(rows).closest('tr');
                                                $('#tblpatadv tr#' + newlyAddedAdvice).trigger('click');
                                                //end
                                                
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
                        $('#txtPatAdv').focus();
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

            //added on 17th sep 2018
            $("#btnPersonalized").click(function () {
                CreatePersonalizedList()
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
                    '<label>Other Advice</label>' +
                    '<textarea id="txtFreeAdvice" maxlength="500"  placeholder="Advice" autofocus="autofocus" class="complaint form-control" required rows="5" cols="30" />' +
                        '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var Adv = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');;
                                if ($("#freeHandBtn").css("background-color") != "rgb(0, 128, 0)") { 
                                    if (Adv.length == 0) {
                                        $.alert('Enter Advice');
                                        this.$content.find('.complaint').val(""); 
                                        return false;
                                    }
                                }

                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: '../DoctorDesk/AddFreeAdvice',
                                    data: { strAdvice: Adv, strTran: strTran, strMrNo: Mrno },
                                    success: function (response) {

                                        if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                                            $.messager.alert("Information", "Record Not Inserted.");
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                            var jc = this;

                                            $.messager.alert("Information", "This complaint is already Present.");
                                        }
                                        else {
                                            $("#txtFreeAdvice").val(Adv);
                                            freeHandPatAdvice = Adv;
                                            if (Adv != "") {
                                                $("#freeHandBtn").css("background-color", "green");
                                            }
                                            else {
                                                $("#freeHandBtn").css("background-color", "#398ebd");
                                            }

                                        }
                                    },

                                });
                            }
                        },
                        REMOVE: function () {
                            $("#txtFreeAdvice").val("");
                            $('.formFreeText').submit();
                        },
                        Close: function () {
                            $("#txtFreeAdvice").val("");
                        },
                    },
                    onContentReady: function () {
                        $('#txtFreeAdvice').focus();
                        $('#txtFreeAdvice').val(freeHandPatAdvice);
                        var jc = this;
                        this.$content.find('form').on('submit', function (e) {
                            e.preventDefault();
                            jc.$$formSubmit.trigger('click'); 
                        });
                        if ($('#txtFreeAdvice').val() == "") {
                            jc.$$REMOVE.attr("style", "display:none")
                        }
                    }
                });
            });
        });

        //added on 4th sep 2018
        function CreatePersonalizedList() {
            $.confirm({
                title: 'SetUp Advice',
                theme: 'supervan',
                // theme: 'material',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                //  columnClass: 'col-md-6',
                content: '' +//style added by 
                '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:0px" class="form-control" id="AdviceSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtInvestigation" type="text" id="input-name" placeholder="Search Advice SetUp" class="form-control" onkeyup="SearchPatAdviceSetUps()"  style="margin-left:10px" ></td></tr></table></div>' +
                '<div id="divtblInvestigation" class="divtblInvestigation" style=""><table id="tblPersInvestigationlist" style="width:100%;border-top:1px solid #29884bd6 !important" class="table"><tbody></tbody></table></div>' +
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
                            SavePersPatAdviceList(strCode);
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
                    GetAdvicePersonalisedList()

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

        //added on 6th sep 2018
        function SavePersPatAdviceList(strCode) {
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: 'SavePersonalizedAdvces',
                datatype: "json",
                aysc: false,
                data: { Code: strCode, strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO') },
                success: function (result) {
                    if (result.length > 0) {
                        if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                            window.location.href = 'PatientAdvice';
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
                     HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }

            });
        }

        //added on 5th sep 2018
        function GetAdvicePersonalisedList() {
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersPatientAdviceList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);' ></td><td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='PatAdvSetUpAddEdit(this);'></i></span></td>";//onchange='handleChange(this);;//onchange='handleChange(this);
                            // rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td><input class='chkPersDis' type='checkbox' style='margin-left:10px'></td><td><div class='icheckbox_flat-green' aria-checked='false' aria-disabled='false' style='position: relative;'><input type='checkbox' class='flat-red' style='position: absolute; opacity: 0;'><ins class='iCheck-helper' style='position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div></td><td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table1[i].DESC) + "</td>";

                            rows += "</tr>";
                        }
                        $('#tblPersInvestigationlist tbody').empty();// added by vijeta on 2nd may 2018
                        $('#tblPersInvestigationlist tbody').append(rows).closest('tr');
                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();//
                },

            });
        }

        //added on 4th sep 2018
        $(document.body).on('click', '#AdviceSetUpAdd', function (e) {
            PatAdvSetUpAddEdit(this);//added on 6th march19
        });

        function SearchServiceGroup() {// 16-12-19

            input = document.getElementById("txtServiceGrpsearch");
            filter = input.value.toUpperCase();
            //var elem = $("#SrvcGrpdata li");
            var elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent();// added by vijeta on 24th sep 2018
            var search = false;//added on  19th may 2018
            //added on 19th may 2018
            search = $(elem).hasClass('display');
            if ($(input).val().length >= 3) {
                getNonFreqInChkBxList(filter);
            } else {
                elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent().parent().remove();
                var checdelem = $("#SrvcGrpdata li input[type='checkbox']:checked").parent();

                $.each(checdelem, function (j, item) {

                    var label = checdelem[j].getElementsByTagName("input")[0];
                    if (label)
                        FreqDataSetupList = FreqDataSetupList.filter(function (e, index) {

                            return FreqDataSetupList[index]["DESCCD"].toString().trim() != label.defaultValue.toString().trim();
                        });
                });
                $.each(FreqDataSetupList, function (i, item) {
                    var title = item.DESC;
                    var idstring = item.DESCCD;
                    $("#SrvcGrpdata").append("<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + idstring + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>" + title + "</label></label><li>");
                    //  return FreqDataSetupList[index]["DESCCD"].toString().trim() == label.defaultValue.toString().trim();
                });
            }
            //---------------------------------------
            var elem = $("#SrvcGrpdata li input[type='checkbox']").not(":checked").parent();
            for (i = 0; i < elem.length; i++) {
                $(elem[i]).removeClass('display');
                label = elem[i].getElementsByTagName("input")[0];
                if (label) {
                    if (label.title.toUpperCase().indexOf(filter) > -1) {
                        elem[i].style.display = "";
                        if (!$(elem[i]).hasClass('display')) {
                            $(elem[i]).addClass('display')
                        }
                    }
                    else {
                        elem[i].style.display = "none";
                    }
                }
            }
        }

        //added on 24th sep 2018
        function getNonFreqInChkBxList(filter) {//
            HoldOn.open();//sumayyya
            var strClinincode = $.session.get('ClinicCode').toString().trim();
            $.ajax({
                type: "POST",
                datatype: "json",
                url: "<%=Url.Action("GetDBPatientAdvice","DoctorDesk")%>",
                data: { PatAdvice: filter, ClinicCode: strClinincode },
                asycn: false,
                success: function (response) {
                    if (response != "" && response != null) {
                        var result = JSON.parse(response);
                        var options = "";
                        NonFreqDataSetupList = result.Table1;
                        $.each(result.Table1, function (i, item) {
                            var title = item.NAME;
                            var idstring = item.CODE;
                            options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.CODE + "'>" + title + "</label><li>";
                        });
                        $("ul#SrvcGrpdata").append(options);//added on 24th sep 2018
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

        // added by vijeta on 5th sep 2018
        $(document.body).on('click', '#dblServiceHelpsrvcgrp li input', function (e) {
            if (e.currentTarget.checked === true) {
                $(this).parent().parent().remove();
                var element = $("#dblServiceHelpsrvcgrp li input:checkbox:checked");
                //if (element.length == 0) {
                $($(this).parent().parent()).insertAfter('a[id="btnsrvgrp"]');
                $(this).focus();
            }
            else {

            }
            $("#dblServiceHelpsrvcgrp").show();
            $("#txtServiceGrpsearch").val("").trigger("keyup");//added on 24th sep 2018
            e.stopPropagation();
        });

        //added on 4th sep 2018
        function SerivceGrpData(srvcgrpname) {
            HoldOn.open();//
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

            var strClinincode = $.session.get('ClinicCode').toString().trim();
            var DataToSend = {
                ClinicCode: strClinincode
            };

            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPatAdvList","DoctorDesk")%>",
                data: DataToSend,
                async: false,
                success: function (response) {
                    FreqDataSetupList = response;// 16-12-19
                    if (response != "") {
                        //var result = JSON.parse(response);
                        $.each(response, function (i, item) {
                            var title = item.DESC;
                            var idstring = item.DESCCD;
                            options += "<li><label><input type=checkbox id='" + idstring + "' title='" + title + "' value='" + item.DESCCD + "' />" + "<label style='vertical-align:middle;margin-left:10px;'>"+ title + "</label></label></li>";
                        });
                    }
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
            });
            //-------------------------------------
            $newul.append(abc);
            $newul.append(options);
            $newDiv.append($newul);
            $('#divSrvcGrpSelect').append($newDiv);
        }

        //added on 22nd sep 2018
        $(document.body).on({
            'click': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },
            'focus': function (e) {
                $("#dblServiceHelpsrvcgrp").show();
            },
        }, '#txtServiceGrpsearch');

        //added on 5th sep 2018
        $(document.body).on('click', '#btnsrvgrp', function (e) {
            $('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").prop('checked', false);
        });

        $(document.body).on("click", "#spanAddNewMedInSetUp", function (e) {
            $.confirm({
                title: '',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                theme: 'bootstrap',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">New Advice</label><br>' +
                '<input  type="varchar" id="txtNewMed"  placeholder="Enter Advice" autofocus="autofocus" class="setUp form-control" required />' +
                '</div>' +

                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            if ($("#txtNewMed").val() == "" || $("#txtNewMed").val() == null) {//18-12-19

                                $('#txtNewMed').css({ 'border-color': 'Red' });
                                return false;

                            } else {
                                $('#txtNewMed').css({ 'border-color': '' });
                            }
                            var medName = $("#txtNewMed").val();
                            //rowNoFrMedTaper = rowNoFrMedTaper + 1;
                            //var medCode = "NEW" + rowNoFrMedTaper;
                            rxnewTaper = rxnewTaper + 1;
                            //var medCode = "NEW" + rxnewTaper;
                            var medCode = "";
                            var flagset = 0;
                            //Meenakshi To add new advices
                            $.ajax({
                                type: "post",
                                datatype: "json",
                                url: 'AddPatAdvice', //
                                async:false,
                                data: { strPatAdv: medName },
                                success: function (response) {
                                    
                                    if (("" + response).toUpperCase().indexOf("Not Inserted") != -1) {
                                        $.messager.alert("Information", "Record Not Inserted.");
                                    }
                                    else if (("" + response).toUpperCase().indexOf("PRESENT.") != -1) {
                                        $.messager.alert("Information", "Record already present please search and select.");
                                    }
                                    else {
                                        
                                        medCode = response.split(' ').pop().trim();
                                         
                                    }
                                },

                            });

                            

                            $('#SrvcGrpdata li').each(function () {
                                if ($(this)[0].innerText.toString().trim() == medName.toString().trim())
                                    flagset = 1;
                            });

                            if (flagset == 0) {
                                var elemnet = "<li><label><input type=checkbox id='" + "" + "' title='" + medName + "' value='" + medCode + "' checked />" + "<label style='vertical-align:middle'>" + medName + "</label></label><li>";
                                $(elemnet).insertAfter('a[id="btnsrvgrp"]');
                                $(elemnet).focus();
                                $("#dblServiceHelpsrvcgrp").show();
                                $("#divSrvcGrpGrid").show();
                            } else {
                                $.alert("Advice Already Existing", "Information");
                            }
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                        //close
                    }
                },
                onContentReady: function () {

                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                }

            });
        });

        //added on 11th sep 2018
        function SearchPatAdviceSetUps() {
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

        function SetText(str) {
            $("#" + idOfDMY).text(str);
        }

        function AddPatAdvice() {

            var strClinincode = $.session.get('ClinicCode').toString().trim();
            var DataToSend = {
                ClinicCode: strClinincode
            };

            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPatAdvList","DoctorDesk")%>",
                data: DataToSend,
                success: function (result) {
                    FreqAdviceList = result;
                    var rows = "";
                    $('#tblpatadv tbody').empty();

                    $.each(result, function (i, item) {

                        var rows = "<tr class='clickable-row' id='" + item.DESCCD.trim() + "'>" + "<td style='padding:5px;width:100%;text-align:left; font-size: 14px;'>" + item.DESC + "</td>" +
                                "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                        "</tr>";//
                        $('#tblpatadv tbody').append(rows);
                       

                    });

                },
                complete: function () {
                    SetDataForPatAdv();
                }
                , error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SearchPatAdvice() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            input = document.getElementById("PatAdviceInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblpatadv");
            var tr = $("#tblpatadv  tr");


            if ($(input).val().length >= 3) {
                GetDatabasePatAdvice(filter, tr);
            } else {
                var tr = $("#tblpatadv  tr").not(".active").remove();
             
                var checdelem = $("#tblpatadv  tr.active");

                if ($(input).val().length == 0) {

                    for (var i = 0; i < checdelem.length; i++) {
                        
                        checdelem[i].style.display = "";

                        if (!$(checdelem[i]).hasClass('display')) {
                            $(checdelem[i]).addClass('display')

                        }


                    }


                } else {


                    for (i = 0; i < checdelem.length; i++) {
                        $(checdelem[i]).removeClass('display');
                        td = checdelem[i].getElementsByTagName("td")[0];
                        if (td) {
                            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
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

                $.each(checdelem, function (j, item) {

                    td = checdelem[j].getElementsByTagName("td")[0];
                    if (td)
                        FreqAdviceList = FreqAdviceList.filter(function (e, index) {
                            return FreqAdviceList[index]["DESCCD"].toString().trim() != td.parentElement.id.toString().trim();
                        });
                });

                i = checdelem.length;
                $.each(FreqAdviceList, function (i, item) {
                    var rows = "<tr class='clickable-row' id='" + item.DESCCD.trim() + "'>" + "<td style='padding:5px;width:100%;text-align:left; font-size: 14px;'>" + item.DESC + "</td>" +
                                 "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                         "</tr>";//
                    $('#tblpatadv tbody').append(rows);
                });
            }
            // tr = table.getElementsByTagName("tr");
            var tr = $("#tblpatadv  tr");
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = tr[i].getElementsByTagName("td")[0];
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
        }
        //...................................
        //10/12/2019 16:07
        function afterSearchPatAdvicepresent(patadv) {
            var table = document.getElementById("tblpatadv");
            var tr = table.getElementsByTagName("tr");
            var strClinincode = $.session.get('ClinicCode').toString().trim();

            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetDBPatientAdvice","DoctorDesk")%>",
                async: false,
                data: { PatAdvice: patadv, ClinicCode: strClinincode },
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response);
                        var rows = "";

                        var AllreadyPresent = jQuery.grep(result.Table1, function (element, index) {
                            Name = patadv;
                            return ((element.NAME).toString().trim().toUpperCase() == patadv.toString().trim().toUpperCase());
                        });

                        $.each(AllreadyPresent, function (i, item) {
                            $('#PatAdviceInput').val("");
                            var MatchElement = jQuery.grep(tr, function (element, index) {
                                Name = element.getElementsByTagName("td")[0].innerText;
                                return ((item.NAME).toString().trim().toUpperCase() == Name.toString().trim().toUpperCase());
                            });

                            if (MatchElement.length > 0) {
                                //Do not bind
                                //  GetDatabaseComplain(filter, tr);
                                if ($('#tblpatadv tr#' + MatchElement[0].id).hasClass("active") == false)
                                $('#tblpatadv tr#' + MatchElement[0].id).trigger('click');
                            }
                            else {
                                var rows = "<tr class='clickable-row' id='" + item.CODE + "'>" + "<td style='padding:5px;    font-size: 14px;width:100%;text-align:left;'>" + item.NAME + "</td>" +
                                    "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                               "</tr>";
                                $('#tblpatadv tbody').append(rows);
                                $('#tblpatadv tr#' + item.CODE.trim()).trigger('click');// 18-12-19

                            }//4/22/19
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
            });
        }

        function SearchData(tr, filter) {
            for (i = 0; i < tr.length; i++) {
                $(tr[i]).removeClass('display');
                td = tr[i].getElementsByTagName("td")[0];
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
        }

        function GetDatabasePatAdvice(SearchText, obj) {
           // HoldOn.open();//
            var strClinincode = $.session.get('ClinicCode').toString().trim();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetDBPatientAdvice","DoctorDesk")%>",
                data: { PatAdvice: SearchText, ClinicCode: strClinincode },
                async: false,
                success: function (Response) {
                    if (Response != "Unsucessfull" && Response != '' && Response != null) {
                        var result = JSON.parse(Response);
                        var rows = "";
                        $.each(result.Table1, function (i, item) {

                            var MatchElement = jQuery.grep(obj, function (element, index) {
                                Name = $(element)[0].cells[0].innerText;
                                return ((item.NAME).toString().trim() == Name.toString().trim());
                            });

                            if (MatchElement.length > 0) {
                                //Do not bind
                            }
                            else {
                                var rows = "<tr class='clickable-row' id='" + item.CODE + "'>" + "<td style='padding:5px;    font-size: 14px;width:100%;text-align:left;'>" + item.NAME + "</td>" +
                                    "<td class='tdSetUpYn' style='display:none;'></td>" + //added on 25th july 2019
                                    "</tr>";
                                $('#tblpatadv tbody').append(rows);
                            }
                        });
                    }
                },
                //complete: function () {
                //    HoldOn.close();//
                //},
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SetDataForPatAdv() {
            var tranNo = $.session.get('PatTRANNO');
            $.ajax({
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo },
                url: 'SetDataForPatAdv',
                success: function (Response) {
                    if (Response[0] != null) {
                        var data = Response[0];
                        for (var i = 0; i < data.length; i++) {
                            if ($('#tblpatadv tr#' + data[i]["DESCCD"] + ' td.day-td')[0] != undefined) {
                                $('#tblpatadv tr#' + data[i]["DESCCD"] + ' td.tdSetUpYn')[0].innerHTML = data[i]["SETUPYN"]; //added on 25th July 2019
                                $('#tblpatadv tr#' + data[i]["DESCCD"]).trigger('click');
                            }
                            else //added by Meenakshi 18/08/2020 as we are binding only top 100 from frequent list so if the data is not there it was giving error
                            {
                                var rows = "<tr class='clickable-row' id='" + data[i]["DESCCD"] + "'>" + "<td style='padding:5px; " +
                                        "font-size: 14px;width:100%;text-align:left;'>" + data[i]["DESC"] + "</td>" +
                                        "<td class='tdSetUpYn' style='display:none;'>" + data[i]["SETUPYN"] + "</td>" + //added on 25th july 2019
                                        "</tr>";
                                $('#tblpatadv tbody').append(rows);
                                $('#tblpatadv tr#' + data[i]["DESCCD"]).trigger('click');
                            }
                        }
                    }
                    if (Response[1] != null) {
                        if (Response[1][0]["FreePatAdvice"] != "") {
                            freeHandPatAdvice = Response[1][0]["FreePatAdvice"].toString();
                            $("#freeHandBtn").css("background-color", "green");
                            $("#txtFreeInvestigation").val(Response[1][0]["FreePatAdvice"].toString());
                            $("#freeHandBtn").trigger('click');
                        }
                    }
                },
                //added on 18th sep 2018
                complete: function () {
                     HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });
        }

        //Save on back button
        jQuery(document).ready(function ($) {
            if (window.history && window.history.pushState) {
                window.history.pushState('forward', null, './PatientAdvice');
                $(window).on('popstate', function () {
                    SavePatientAdvice("N");
                });
            }
        });

        function SavePatientAdvice(strPlusButton) {
            HoldOn.open();//
            //alert('saved');
            var mrno = ($.session.get('PatMRNO'));
            var tranNo = ($.session.get('PatTRANNO'));
            var patadvArr = [];
            var rows = $('#tblpatadv > tbody > tr.active').get();
            //if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                //var cd = rows[i].cells[1].children[0].id
                //var code = cd.substr(4);
                var code = rows[i].id
                var setupYn = $(rows[i]).children('td.tdSetUpYn')[0].innerText; //added on 25/7/19
                // var durType = rows[i].cells[1].innerText;
                // var dur = rows[i].cells[2].innerText;
                var a = {
                    DESCCD: code,
                    SETUPYN: setupYn,//added on 25/7/19
                    //  DURTYPE: durType,
                    //  DURATION: dur,
                };
                patadvArr.push(a);
            }

            $.ajax({
                type: "POST",
                url: 'SavePatAdv',
                datatype: "json",
                data: { strPatAdv: JSON.stringify(patadvArr), strMRNO: mrno, strTranNo: tranNo },
                success: function (result) {

                    if (strPlusButton == 'SS') {
                        if (result != true)
                            $.messager.alert("Info", 'Please try again');
                        //$.messager.alert("Info", result == true ? 'Saved Successfully' : 'Please try again');
                    }
                    else {
                        if (strPlusButton == "N")
                            window.location.href = 'PatientEntry';
                    }

                    
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });
        }

        function PatAdvSetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Advice SetUp</label>' +
                 '<input  type="varchar" id="txtSetUp" maxlength="50"  placeholder="Enter SetUp Name"  class="setUp form-control" required />' +//added length kavita
                //'<br><input id="txtServiceGrpsearch" type="varchar" style="" placeholder="Search For Advices...." title="Search For Advice" class="form-control" onkeyup="SearchServiceGroup()" />' +
                 '<br><input id="txtServiceGrpsearch" autocomplete="off" type="varchar" style="" placeholder="Search For Advices (Search Atleast Three Characters)" class="form-control"  onkeyup="SearchServiceGroup()" /><span class="fa fa-plus fa-2x mediAddspan" style="" title="Add new Medicine" id="spanAddNewMedInSetUp"></span>' + //

               '<div id="divSrvcGrpSelect" style="border:1px solid gray;"></div>' +
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

                            if (strArry == "") {
                                $.alert('Select at least one test ');
                                return false;
                            }

                            //added on 19th may 2018
                            var chlBoxTitleLst = null;
                            chlBoxTitleLst = [];
                            $('#dblServiceHelpsrvcgrp input:checkbox:checked').each(function () {
                                chlBoxTitleLst.push($(this).attr('title'));
                            });
                            var strArry1 = chlBoxTitleLst.join(",");

                            //------------------

                            //added on 07/03/18
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }

                            if (setUp != "") {
                                //$('#dblServiceHelpsrvcgrp').find("input[type=checkbox]:checked").

                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'AddPatAdviceSetUp',
                                    data: { strPatAdviceSetUpName: setUp, strAdviceLst: strArry, strNameLst: strArry1, strSetUpCode: strSetUpCode },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUp").val("");
                                            $("#txtInvestigation").val("");//added on 07/03/19
                                            $.alert(response);
                                            GetAdvicePersonalisedList();
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
                    close: function () {

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
                        FillSelectedSetUpsPatAdvc($(obj).parents('tr')[0].id);
                    }
                    // bind to events
                    var jc = this;
                    //this.$content.find('form').on('submit', function (e) {
                    //    // if the user submits the form by pressing enter in the field.
                    //    e.preventDefault();
                    //    jc.$$formSubmit.trigger('click'); // reference the button and click it
                    //});
                    $(".jconfirm-box-container").last().css('width', '480px');// added by vijeta on 7/3/19
                }
            });

        }

        function FillSelectedSetUpsPatAdvc(strSetUpCode) {
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/GetPatAdvcListBySetupCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {

                        $.each(response, function (i, val) {
                            $("#dblServiceHelpsrvcgrp li input#" + val).trigger("click");
                        });

                    }

                },
                complete: function(){
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                     HoldOn.close();
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
