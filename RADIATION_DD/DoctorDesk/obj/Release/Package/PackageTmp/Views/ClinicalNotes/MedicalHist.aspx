<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Clinicalnotes>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div>
            <input style="width: 100%; background-color: #f7fcff; margin-left: -17px; margin-top: -22px; position: fixed; border: none;display:none" class="empty" disabled>
        </div>
        <div id="MainDiv">
              <%-- ..................10-12-19.............................--%>
            <div style="width:100%;text-align:center">
            <a class="button1 button1-green" id="divForBack"  style="margin-bottom: 2.5%;" onclick="SetpageDirctn()">
  <i class="fa fa-arrow-left"></i>
  <strong>Back</strong>
</a>
            </div>
         <%--   .................................................--%>
            <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%;">
                <%--    <div class="InputWrapper">--%>
              <div class="StuckInput" style="margin-top: -18px !important;">
                    <label id="MedicalAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-right: 24px; border-color: transparent;" title="Go to top"><%----%>
                        <img src="../Images/plus.png" style="background-color: white; border-radius: 50%; position: fixed;">
                    </label>
                    <input type="text" id="MedicalInput" onkeyup="SearchMedical()" placeholder="&#xF002; Search Diseases" style="height: 28px; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;margin-left: 8px;" class="empty">
                     <%--added by vijeta on 23rd march 19--%>
                 <button id='freeHandBtn' style="border-radius: 50%;height: 28px;width: 28px;color: white;margin-top: 3px;background-color: #398ebd;border-color: transparent; outline-style: none;" title="Free Text" onclick="AddFreeHistory('M');"><span><i class="fa fa-pencil"></i></span></button> 
                </div><%----%>
                <%--   </div>--%>

                <label id="btnSaveMedical" style="display:none; background-color: transparent; float: right; margin-right: 25px; border-color: transparent;" title="Save">
                    <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                </label>

     <%-- Added by Dhananjay 20250926 --%>
     <div style="position: fixed; bottom: 5%; left: 25%; right: 15%; text-align: center; z-index: 1000;">
             <button id="btnSave" onclick="$('#btnSaveMedical').trigger('click');"
                    style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                    onmouseover="this.style.backgroundColor='#218838'"
                    onmouseout="this.style.backgroundColor='#28a745'">
                    Save
             </button>
     </div>

                 <div id="wrapper" style="overflow: hidden; width: 100%">
                    <div class="tableDiv" style="padding-top: 25px;"> <%----%>
                         <table class="HeadPatTab" style="text-align:center" id="HeadDiog"><thead> <tr style="background-color:#fffdc8"><th style="width: 80%;">Medical History</th><th class='HeadRemark'>Duration</th></tr></thead>
                        
                        </table><%-- 4/11/19--%>
                        <table id="tblmedical" class="table HeadPatTab" style="width: 100%">
                   <tbody id="tblsort" style="height: 100%"></tbody> <%-- 18/12/2019--%>
                        </table>
                    </div>
                </div>

                <div id="layer-demo" class="po__layer list">
                    <%--<a href="javascript:;">0</a>   --%>
                </div>
                <div id="layer-DMY" class="po__layer list">
                    <a href="javascript:;" onclick="SetText('D')" style="font-weight:500;font-size:16px">Days</a>
                    <a href="javascript:; " onclick="SetText('M')" style="font-weight:500;font-size:16px">Months</a>
                    <a href="javascript:;" onclick="SetText('Y')" style="font-weight:500;font-size:16px">Years</a>
                </div>
            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        table {
            width: 100%;
        }

        /*thead, tbody, tr, td, th {
        }*/

            /*tr:after {
                content: ' ';
                display: block;
                visibility: hidden;
                clear: both;
            }*/

            thead th {
                height: 30px;
                text-align: left;
            }

        tbody {
            /*height: 280px;*/
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
            text-decoration: inherit;
            font-size: 16px !important; /*added by vijeta on 27th march 2018*/
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

        /*added by vijeta on 27th march 2018*/
        .empty {
            width: 62%;
        }

        /*added by vijeta on 27th march 2018*/
        @media only screen and (min-width : 992px) {
            .empty {
                width: 57%;/*//4/12/19*/
            }
        }

        /*added by vijeta on 27th march 2018*/
        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            .empty {
                width: 85%;
            }
        }
  .HeadRemark{
  width:20.8%;
        }
        

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            .empty {
                width: 85%;
            }
             .duration{
          width:12% !important;
      }
      day-td{
           width:12% !important;
      }
      .HeadRemark {
    width: 23.8%;
}
      .HeadPatTab > thead > tr > th {
    text-align: center;
    border: 1px solid #ede4e4;
    /*height: 22px;*/
    font-size: 10px;
}
        }

       
        @media only screen and (min-device-width : 1024px)and (max-device-width : 1152px){

             .HeadRemark{
 width:21.1%;
        }
        }

          @media only screen and (min-device-width : 490px) and (max-device-width : 767px) {
      .duration{
          width:12% !important;
      }
      day-td{
           width:12% !important;
      }
      .HeadRemark {
    width: 23.1%;
}
      .HeadPatTab > thead > tr > th {
    text-align: center;
    border: 1px solid #ede4e4;
    /*height: 22px;*/
    font-size: 10px;
}
        }  
    </style>
    <%-- <script src="../plugins/alert/jquery-confirm.js"></script>
    <link href="../plugins/alert/jquery-confirm.css" rel="stylesheet">--%>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/Doctorlist.js"></script>
    <script type="text/javascript">
        <%--var urls = "<%=Url.Action("GetDctrClinic","Account")%>";--%>
        var idOfDMY = "";
        var pathFrom = "";
        var freeHandHistory = "";//vijeta 23rd march19
        var NewlyAddedmedic = "";
        var plusclick = false;  //18/12/2019
        $(document).ready(function (e) {
            HoldOn.open();//
            var doctCode = $.session.get('DoctCode');
            var doctName = $.session.get('DoctName');
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');//

            //end
            SetPatientDtl();
	    document.getElementById('MedicalInput').focus()//added by kavita
            //AddClinics(urls);
	    AddMedical(plusclick);
            // SearchFunction(doctCode);
            //var documentWidth = $(document).width();


            if ($(window).width() >= 996) {
                //screen width size comparion


                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";

            }

            if (pathFrom != "") {
                var doctCd = ('<%:Session["gDoctCode"]%>').toString();
                SearchFunction(doctCd);
                $("#DoctorInput").css("display", "none");
               // var menuL = document.getElementById('menuList');
                //menuL.style.display = "none";
                //
                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
                $("#divForBack").show();
                $("#iformenubar").hide();
                $('#menuBar').attr('disabled', 'disabled');
                //$("#menuBar").css("margin-top", "11px");
                //end
            }
            else {
                $("#DoctorInput").val(doctName);
                $("#divForBack").hide();
                $("#iformenubar").show();
               // $("#menuBar").css("margin-top", "0px");
                $('#menuBar').removeAttr('disabled');
            }

            for (var i = 0; i <= 100; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc' style='font-weight:500;font-size:16px;'>" + i + "</a>";
                $("#layer-demo").append(s);

            }

            //$('#MedicalInput').on('keyup', function () {
            //    var input = $(this);
            //    if (input.val().length === 0) {
            //        input.addClass('empty');
            //    } else {
            //        input.removeClass('empty');
            //    }
            //});




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

            $("#btnSaveMedical").click(function () {

                SaveAllMedical("N");

            });
            //18/12/2019
            //    document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys

            $(document.body).on('click', '#tblmedical td a,#tblmedical td', function (e) {

                if ($(this).is('.CmplntNm'))
                    e.stopPropagation();
            });
            $("#MedicalAdd").click(function () {

                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formName" style="height:134px">' +
                    '<div class="form-group">' +
                    '<label>Diseases</label>' +
                    '<textarea  type="varchar" id="txtMedical" maxlength="250"  placeholder="Diseases" autofocus="autofocus" class="complaint form-control" required rows="5" cols="30" />' +//length by kavita

                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                //13/12/2019 10:10
                                var medic = this.$content.find('.complaint').val().toString().trim().replace(/\s/g, ' ');;
                                var grpCode = "";
                                if (medic == "") {
                                    $.alert('Enter Diseases');
                                    return false;
                                }
                                if (medic != "") {
                                    $.ajax({
                                        type: "post",
                                        datatype: "json",
                                        url: 'AddMedical',
                                        data: { strMedical: medic, strGrpCode: grpCode },
                                        success: function (response) {
                                            if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                                $("#txtMedical").val("");
                                                //$.messager.alert("Information", response);
                                                // SaveAllMedical("Y");
                                                //  AddMedical();
                                                NewlyAddedmedic = response.split(' ').pop().trim(); //13/12/2019 15:00    


                                                // 19-12-19------------------------
                                                var rows = "<tr class='clickable-row' id='" + NewlyAddedmedic + "'>" + "<td style='padding:5px;  text-align:left;width:80%;   font-size: 14px;'>" + medic + "</td>" +
                            //"<td class='day-td'><label class='lblDay'>Days</label></td>" +
                            "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + NewlyAddedmedic + "' style='display:none;font-weight:800;font-size:16px;width:100%'>D</a></td>" + // font-weight:800;font-size:16px added by vijeta on 27th march 2018
                            "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + NewlyAddedmedic + "' style='display:none;font-weight:800;font-size:16px;width:100%'>0</a></td>" + //// font-weight:800;font-size:16px added by vijeta on 27th march 2018

                        "</tr>";

                                                //  $('#tblmedical tbody').append(rows);
                                                $("#tblmedical tbody").prepend(rows).closest('tr');
                                                $('#tblmedical tr#' + NewlyAddedmedic).trigger('click');
                                                //end-------------------------
                                            }
                                            else {
                                                //var jc = this;
                                                //jc.$formSubmit.trigger('click');
                                                // $.messager.alert("Information", "This Addiction is already Present.");
                                                $("#MedicalInput").val(medic);//
                                                AfterpresentSearchMedicalhist(medic); //16/12/2019
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
                        $('#txtMedical').focus();
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

           
        });


        //function SetText(str) {

        //    $("#" + idOfDMY).text(str);

        //    //vijeta 27/4/19
        //    if (idOfDMY.toUpperCase().indexOf("DAYS") != -1)
        //        $("#" + idOfDMY).parents('td').nextAll('td.duration').find('a.trigger2').trigger('click');
        //}
        function SetText(str) {
            var SelNum = "";
            var SelDays = "";
            var AgeInDays = ConvertAgeYrsToDay($.session.get('PatAge'));
            if (idOfDMY.toUpperCase().indexOf("DAYS") != -1) {
                var Code = idOfDMY.split("Days")[1];
                var SelNum = $("#Num" + Code).text();
                var SelDays = str;
                if (CalcToDay(SelNum, SelDays) < AgeInDays) {
                    $("#Num" + Code).text(SelNum);
                    $("#Days" + Code).text(SelDays);
                    $("#" + idOfDMY).parents('td').nextAll('td.duration').find('a.trigger2').trigger('click');
                }
                else {
                    $.messager.alert("Information", "Duration is greater than Age");
                    $("#Num" + Code).text("0");
                    $("#Days" + Code).text("D");
                }
            }
            else {
                var Code = idOfDMY.split("Num")[1];
                var SelNum = str;
                var SelDays = $("#Days" + Code).text();;
                if (CalcToDay(SelNum, SelDays) <= AgeInDays) {
                    $("#Num" + Code).text(SelNum);
                    $("#Days" + Code).text(SelDays);
                }
                else {
                    $.messager.alert("Information", "Duration is greater than Age");
                    $("#Num" + Code).text("0");
                    $("#Days" + Code).text("D");
                }
            }
        }

        function CalcToDay(Num, DurType) {
            var MultiNum = 1;
            if (DurType == "W")
                MultiNum = 7
            if (DurType == "M")
                MultiNum = 30
            if (DurType == "Y")
                MultiNum = 365
            return (Number(Num) * MultiNum);
        }

        function ConvertAgeYrsToDay(Age) {
            var SpltAge = Age.split(' ');
            var Age = SpltAge[0];
            var Dur = SpltAge[1];
            var AgeInDay = 0;
            if (Dur == "Days")
                return Number(Age);
            else
                return Number(Age) * 365;
        }




        function AddMedical(plusclick) {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetMainMedicList","Clinicalnotes")%>",
                data: {},
                success: function (result) {

                    var rows = "";
                    $('#tblmedical tbody').empty();

                    $.each(result, function (i, item) {
                        //4/23/19
                        var rows = "<tr class='clickable-row' id='" + item.DESCCD + "'>" + "<td style='padding:5px;  text-align:left;width:80%;   font-size: 14px;'>" + item.DESC + "</td>" +
                            //"<td class='day-td'><label class='lblDay'>Days</label></td>" +
                            "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + item.DESCCD + "' style='display:none;font-weight:800;font-size:16px;width:100%'>D</a></td>" + // font-weight:800;font-size:16px added by vijeta on 27th march 2018
                            "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.DESCCD + "' style='display:none;font-weight:800;font-size:16px;width:100%'>0</a></td>" + //// font-weight:800;font-size:16px added by vijeta on 27th march 2018
                        //"<td>0</td>" +
                        //"<td>" +
                        //"<div class='input-group spinner'>" +
                        //"<input type='text' class='form-control' value='42'>"+
                        //"<div class='input-group-btn-vertical'>"+
                        //" <button class='btn btn-default' type='button'><i class='fa fa-caret-up'></i></button>"+
                        //"<button class='btn btn-default' type='button'><i class='fa fa-caret-down'></i></button>"+
                        //"</div>"+
                        //"</div>"+
                        //"</td>" +
                        "</tr>";
                        $('#tblmedical tbody').append(rows);

                    });

                },
                complete: function () {
                    //if ($('#tblmedical').height() < 600) {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "hidden");
                    //    $(".HeadRemark").css("width", "10%");
                    //} else {
                    //    $(".HeadPatTab > tbody").css("overflow-y", "visible");



                    //}
                    SetDataForMedical();

                },

                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SearchMedical() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            input = document.getElementById("MedicalInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblmedical");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function SetDataForMedical() {
            var tranNo = $.session.get('PatTRANNO');
            var mrNo = ($.session.get('PatMRNO'));// added by vijeta on 23rd May
            $.ajax({
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo, strMrNo: mrNo },
                url: 'SetDataForMedical',
                success: function (data) {
                    if (data[0] != null) {
                        for (var i = 0; i < data[0].length; i++) {
                            flagCheckRowsMedHist = true;//vijeta 27/4/19

                            $('#tblmedical tr#' + data[0][i]["MEDCD"] + ' td.day-td')[0].innerHTML = "<a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + data[0][i]["MEDCD"] + "' style='display:none;font-weight:800;font-size:16px'>" + data[0][i]["DURTYPE"] + "</a>";
                            $('#tblmedical tr#' + data[0][i]["MEDCD"] + ' td.duration')[0].innerHTML = "<a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + data[0][i]["MEDCD"] + "' style='display:none;font-weight:800;font-size:16px'>" + data[0][i]["DURATION"] + "</a>";


                            $('#tblmedical tr#' + data[0][i]["MEDCD"]).trigger('click');
                        }
                    }
                    if (data[1] != null) {
                        if (data[1][0]["MEDHIST"] != "") {
                            freeHandHistory = data[1][0]["MEDHIST"].toString();
                            $("#freeHandBtn").css("background-color", "green");
                            $("#txtFreeHistory").val(data[1][0]["MEDHIST"].toString());
                            if (plusclick == false) //18/12/2019
                            $("#freeHandBtn").trigger('click');
                        }
                    }
                },
                complete: function () {

                    flagCheckRowsMedHist = false;
                    //16/12/2019  18:59
                   // if (NewlyAddedmedic != "")
                     //   $('#tblmedical tr#' + NewlyAddedmedic).trigger('click');
                    HoldOn.close();//
                }
            });
        }
        //16/12/2019
        function AfterpresentSearchMedicalhist(medic) {
            var table = document.getElementById("tblmedical");
            var tr = table.getElementsByTagName("tr");

            //  var strClinincode = $.session.get('ClinicCode').toString().trim();

            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetMainMedicList","Clinicalnotes")%>",
                async: false,
                //  data: { NonFreqDiagno: medic, ClinicCode: strClinincode },
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result1 = JSON.stringify(response);
                        var result = JSON.parse(result1);
                        var rows = "";

                        var AllreadyPresent = jQuery.grep(result, function (element, index) {
                            Name = medic;;
                            return ((element.DESC).toString().trim().toUpperCase() == medic.toString().trim().toUpperCase());
                        });

                        $.each(AllreadyPresent, function (i, item) {
                            $('#MedicalInput').val("");
                            var MatchElement = jQuery.grep(tr, function (element, index) {
                                Name = element.getElementsByTagName("td")[0].innerText;
                                return ((item.DESC).toString().trim().toUpperCase() == Name.toString().trim().toUpperCase());
                            });

                            if (MatchElement.length > 0) {
                                if ($('#tblmedical tr#' + MatchElement[0].id).hasClass("active") == false)
                                    $('#tblmedical  tr#' + MatchElement[0].id).trigger('click');
                            }
                            else {
                                var rows = "<tr class='clickable-row' id='" + item.DESCCD + "'>" + "<td style='padding:5px;  text-align:left;width:80%;   font-size: 14px;'>" + item.DESC + "</td>" +
                           "<td class='day-td' style='width:10%'><a class='trigger1' href='javascript:;' data-layer-id='layer-DMY' id='Days" + item.DESCCD + "' style='display:none;font-weight:800;font-size:16px;width:100%'>D</a></td>" + // font-weight:800;font-size:16px added by vijeta on 27th march 2018
                           "<td class='duration' style='width:10%'><a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Num" + item.DESCCD + "' style='display:none;font-weight:800;font-size:16px;width:100%'>0</a></td>" + //// font-weight:800;font-size:16px added by vijeta on 27th march 2018
                       "</tr>";

                                $('#tblmedical tbody').append(rows);
                                $('#tblmedical tr#' + item.DESCCD.trim()).trigger('click');//19-12-19

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
        function SetpageDirctn() {
            SaveAllMedical("N");
            if (pathFrom == "") {
                window.location.href = '../ClinicalNotes/ClinicEntry';
            } else
                window.location.href = '../DoctorDesk/PatientEntry';
        }
        function SaveAllMedical(strPlusBtn) {
            HoldOn.open();
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var medicArr = [];
            var rows = $('#tblmedical > tbody > tr.active').get();
            //if (rows.length > 0) {
            for (var i = 0; i < rows.length; i++) {
                //var cd = rows[i].cells[1].children[0].id
                //var code = cd.substr(4);
                var code = rows[i].id
                var durType = rows[i].cells[1].innerText;
                var dur = rows[i].cells[2].innerText;
                var a = {
                    MRNO: mrno,
                    MEDCD: code,
                    DURATION: dur,
                    DURTYPE: durType
                };
                medicArr.push(a);
            }

            $.ajax({
                type: "POST",
                url: 'SaveMedical',
                datatype: "json",
                data: { strMedic: JSON.stringify(medicArr), strMRNO: mrno, strTranNo: tranNo },
                success: function (result) {
                    if (strPlusBtn == "N")
                        //
                        if (pathFrom != "") {
                            window.location.href = pathFrom;
                        }
                        else {
                            window.location.href = '../ClinicalNotes/ClinicEntry';
                        }
                },
                complete: function () {
                    HoldOn.close();
                }
            });
            //window.location.href = '/DoctorDesk/PatientEntry';

            //}
            //else {
            //    if (strPlusBtn == "N")
            //        $.messager.alert("Information", "No complaints selected");
            //}
        }
        // jQuery(window).load(function () {

        //    setTimeout(function () {             
        //        var tr = $('#tblCmplts tbody  tr').get();

        //        for (i = 0; i < tr.length; i++) {
        //            var id = tr[i].id;
        //            if ($.session.get(id) != null || $.session.get(id) != "undefined") {
        //                if ($.session.get(id) == "Y") {                          
        //                    //tr[i].className = "active";
        //                    $("#" + id).trigger('click');
        //                }
        //                else {
        //                    //tr[i].className = "";
        //                }
        //            }
        //            else {
        //                tr[i][0].removeClass('active');
        //            }

        //        }
        //    }, 1000);

        //});

        //$(document).ready(function () {
        //    var tranNo = $.session.get('PatTRANNO');
        //    $.ajax({
        //        type: 'post',
        //        datatype: 'json',
        //        data: { strTranNo: tranNo },
        //        url: 'SetDataForComplaints',
        //        async:true,
        //        success: function (data) {
        //            for (var i = 0; i < data.length; i++) {
        //                //$('#tblCmplts tr#' + data[i]["DESCCD"]).addClass('Active');
        //                //$('#tblCmplts tr#' + data[i]["DESCCD"])[0].className = "active";
        //                $('#tblCmplts tr#' + data[i]["DESCCD"]).trigger('click');
        //                $('#tblCmplts tr#' + data[i]["DESCCD"] + ' td.day-td')[0].innerText = data[i]["DURTYPE"];
        //                $('#tblCmplts tr#' + data[i]["DESCCD"] + ' td.duration')[0].innerText = data[i]["DURATION"];
        //            }
        //        }
        //    });
        //});

        //$(document).on('DOMNodeInserted', '#tblCmplts', function (e) {
        //    var tranNo = $.session.get('PatTRANNO');
        //    $.ajax({
        //        type: 'post',
        //        datatype: 'json',
        //        data: { strTranNo: tranNo },
        //        url: 'SetDataForComplaints',
        //        success: function (data) {
        //            for (var i = 0; i < data.length; i++) {
        //                //$('#tblCmplts tr#' + data[i]["DESCCD"]).addClass('Active');
        //                //$('#tblCmplts tr#' + data[i]["DESCCD"])[0].className = "active";
        //                $('#tblCmplts tr#' + data[i]["DESCCD"]).trigger('click');
        //                $('#tblCmplts tr#' + data[i]["DESCCD"] + ' td.day-td')[0].innerText = data[i]["DURTYPE"];
        //                $('#tblCmplts tr#' + data[i]["DESCCD"] + ' td.duration')[0].innerText = data[i]["DURATION"];
        //            }
        //        }
        //    });
        //});

        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './MedicalHist');

                $(window).on('popstate', function () {
                    SaveAllMedical("N")
                });

            }
        });
    </script>
</asp:Content>
