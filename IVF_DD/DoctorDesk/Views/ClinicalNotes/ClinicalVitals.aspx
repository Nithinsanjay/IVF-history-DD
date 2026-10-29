<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Clinicalnotes>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <html>
    <head>
        <title></title>
    </head>
    <body>

        <div id="MainDiv">

            <%--	  <a href="#test1" style="font-size:10px;">Treatment Advice</a>--%>

            <div id="ContentHolderDiv">
                <div>
 <table id="tblVitals" style="float: left">
                            <tbody style="line-height: 1.9">
                                <tr>
                                    <td style="width: 40%;">
                                        <label class="input-form-label">Weight</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group">
                                            <input id="txtCurrWeight" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Weight">
                                            <span class="input-group-addon input-form-addon">Kg</span>
                                        </div>
                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <label class="input-form-label">Prev Weight</label>
                                    </td>

                                    <%--<td>
                                    <input type="text" id="txtPrev" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 147px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="Kg" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtPrev" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Prev Weight" readonly="readonly">
                                            <span class="input-group-addon input-form-addon">Kg</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label">Weight Loss</label>
                                    </td>

                                    <%--                                <td>
                                    <input type="text" id="txtWghtLG" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 165px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="Kg" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtWghtLG" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Weight Loss" readonly="readonly">
                                            <span class="input-group-addon input-form-addon">Kg</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label">Height</label></td>
                                    <%-- <td>
                                    <input type="text" id="txtHeight" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 165px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td>
                                    <input type="text" value="ft" style="width: 20px; margin-left: -21px; font-weight: bold; background-color: #f1efef; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty" readonly>
                                </td>--%>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtHeight"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Height">
                                            <span class="input-group-addon input-form-addon">cm</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label">Temp</label>
                                    </td>                                 
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtTemp"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Temperature">
                                            <span class="input-group-addon input-form-addon"> &#x2109;</span><%--DEGREE FAHRENHEIT--%>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label">Pulse</label>
                                    </td>
                                    <%--<td>
                                    <input type="text" id="txtPulse" maxlength="5" value="0" onkeypress=" return checkdata();" style="width: 165px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;" class="empty">
                                </td>
                                <td></td>--%>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtPulse"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Pulse">
                                             <span class="input-group-addon input-form-addon">bpm</span>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label">BP</label>
                                    </td>                                 
                                    <td>
                                     <select id="SelSystolic" style="width: 115px;height: 22px;"></select>
                                    </td>
                                    <td>
                                     <label>/</label>
                                    </td>
                                    <td>
                                        <select id="SelDiastolic" style="width: 115px;margin-left:5px;height: 22px;"></select>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <label class="input-form-label">Resp</label>
                                    </td>                                 
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtResp"   type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Respiratory">
                                        </div>
                                    </td>
                                </tr>
                                  <%--  added by vijeta on 21st aug 2018--%>
                                <tr>
                                    <td>
                                        <label class="input-form-label">SpO2</label>
                                    </td>                                 
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtSPO2"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="SpO2" style="width:226px;">
                                        </div>
                                    </td>
                                </tr>

                                 <%--  vijeta 17/5/19--%>
                                  <tr>
                                    <td style="width: 42%;">
                                        <label class="input-form-label">BMI</label>
                                    </td>
                                    <td colspan="3">
                                       
                                        <div class="input-group">
                                            <input id="txtBMI"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="BMI" readonly>
                                            <span class="input-group-addon input-form-addon">kg/(m²)</span>
                                        </div>
                                    </td>

                                </tr>
                                  <tr id="trHeadCircmfr">
                                    <td style="width: 42%;">
                                        <label class="input-form-label">Head Circumference</label>
                                    </td>

                                    <td colspan="3">
                                       
                                        <div class="input-group">
                                            <input id="txtHeadCirc"  type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Head Circumference" >
                                            <span class="input-group-addon input-form-addon">cm</span>
                                        </div>
                                    </td>

                                </tr>
                             <%--  vijeta 17/5/19--%>

                               <%-- <tr>
                                    <td>
                                        <label class="input-form-label">Others</label>
                                    </td>
                                    <td colspan="3">
                                        <div class="input-group">
                                            <input id="txtOthr" onkeypress=" return checkdata();" type="text" maxlength="5" class="form-control input-form-control" name="msg" placeholder="Other">
                                        </div>
                                    </td>
                                </tr>--%>

                                <tr>
                                    <td>
                                        <label class="input-form-label">Daily Walking</label>
                                    </td>
                                    <td colspan="3">
                                        <div class="btn-group btn-toggle" id="divWalking" style="float: left;width: 37%;">
                                            <button class="btn btn-xs btn-default" id="btnWalkY">YES</button>
                                            <button class="btn btn-xs btn-info active" id="btnWalkN">NO</button>
                                            <input type="hidden" id="hdnWalkingYN" value="N" />
                                        </div>
                                        <div style="width: 100%;float: right;margin-left: 12px" id="divWalkingNoInfo" >
                                           
                                        <div style="float: right;margin-top: -23px;margin-right: 45px;margin-left: -155px;">
                                                 <label id="lblDuration">Duration</label>
                                            <span data-toggle="tooltip" title="" class="badge bg-aqua" style="width: 45px;height: 25px;padding-top: 7px;">
                                                <a class="trigger2" href="javascript:;" data-layer-id="layer-Numbers" id="Numbers" style="color: white">0</a>
                                            </span>                                      
                                             <div id="layer-Numbers" class="po__layer list">
                                            </div>
                                        </div>
                                            <div style="float: right;/* margin-right: -86px; */margin-top: -23px;/* margin-left: -6px; */margin-right: -15px;">
                                            <span data-toggle="tooltip" title="" class="badge bg-aqua" data-original-title="3 New Messages" style="width: 56px;height: 25px;padding-top: 7px;">
                                                <a class="trigger1" href="javascript:;" data-layer-id="layer-DMY" id="DaySelect" style="text-decoration: none; color: white">Days</a>
                                            </span>
                                           
                                            <div id="layer-DMY" class="po__layer list">
                                                <a href="javascript:;" style="text-decoration: none; color: blue" onclick="SetText('Days')">Days</a>
                                                <a href="javascript:;" style="text-decoration: none; color: blue" onclick="SetText('Weeks')">Weeks</a>
                                                <a href="javascript:; " style="text-decoration: none; color: blue" onclick="SetText('Months')">Months</a>
                                                <a href="javascript:;" style="text-decoration: none; color: blue" onclick="SetText('Years')">Years</a>
                                            </div>
                                        </div>
                                        </div>                             
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="input-form-label">Diet</label></td>
                                    <td colspan="3">
                                        <div class="btn-group btn-toggle" id="divDiet">
                                            <button class="btn btn-xs btn-default" id="btnDietY">YES</button>
                                            <button class="btn btn-xs btn-info active" id="btnDietN">NO</button>
                                            <input type="hidden" id="hdnDietYN" value="N" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label class="input-form-label">Regular Medicine</label></td>
                                    <td colspan="3">
                                        <div class="btn-group btn-toggle" id="divRegMedicineYN">
                                            <button class="btn btn-xs btn-default" id="btnRegMedY">YES</button>
                                            <button class="btn btn-xs btn-info active" id="btnRegMedN">NO</button>
                                            <input type="hidden" id="hdnRegMedYN" value="N" />
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>                   
                </div>
               <div>
                    <label id="myBtn" style="background-color: transparent; float: right;    margin-right: 65px;   border-color: transparent;" title="Go to top">
                        <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                    </label>
                </div>

            </div>

        </div>
    </body>
    </html>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style>
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

        .switch-input:checked ~ .switch-label {
            background: #0088cc;
            border-color: #0088cc;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15), inset 0 0 3px rgba(0, 0, 0, 0.2);
        }

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
            height: 23px !important;
            font-size: 13px !important;
        }

        .input-form-addon {
            padding: 5px 12px !important;
            font-size: 11px !important;
        }

        .input-form-label {
            font-weight: normal !important;
            padding-left: 40px !important;
            font-size: 13px !important;
        }

              Label {
            margin-left: 5px;
        }
                    .input-group-addon
      {
          width:50px;
      }
    </style>

  <%--  <script src="../Scripts/Doctorlist.js"></script>--%>
  
     <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
     <script src="../Scripts/Doctorlist.js"></script>
    <script type="text/javascript">
        <%--  var urls = "<%=Url.Action("GetDctrClinic","Account")%>";--%>
        var ageOfPat = $.session.get('PatAge2'); //vijeta 17th may 2019
        $(document).ready(function (e) {
            var doctCode = $.session.get('DoctCode');
            var doctName = $.session.get('DoctName');
            //$("#DoctorInput").val(doctName);

            SetPatientDtl();
            var tranNo = $.session.get('PatTRANNO');
            for (var i = 0; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' onclick='SetNumber(" + i + ");' style='text-decoration: none;color:blue' id='NumDaysSc'>" + i + "</a>";
                $("#layer-Numbers").append(s);
            }


            //AddClinics(urls);
            SetDataForVitals(tranNo);
            SetWeightLoss();

            //vijeta 17th may 2019
            if (Number(ageOfPat.substr(0, ageOfPat.indexOf(":"))) <= 18)
                $("#trHeadCircmfr").show();
            else
                $("#trHeadCircmfr").hide();

            //ShowHideWalkNoDiv($("#hdnWalkingYN").val());

            $('.trigger1').po({
                alignment: 'center'
            });
            $('.trigger2').po({
                alignment: 'center'
            });

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";

            }



            $("#myBtn").click(function () {
                SaveVitals();
            });

            $("#txtCurrWeight").change(function () {
                SetWeightLoss();
                CalBMI(); //vijeta 17th may 2019
            });

            $("#txtHeight").change(function () {
                CalBMI(); //vijeta 17th may 2019
            });


            $('.btn-toggle').click(function () {
                $(this).find('.btn').toggleClass('active');

                if ($(this).find('.btn-primary').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-primary');
                }
                if ($(this).find('.btn-danger').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-danger');
                }
                if ($(this).find('.btn-success').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-success');
                }
                if ($(this).find('.btn-info').size() > 0) {
                    $(this).find('.btn').toggleClass('btn-info');
                }

                $(this).find('.btn').toggleClass('btn-default');

            });

            $("#divWalking").click(function () {
                var walkngYNVal = $(this).find('.active').text().substr(0, 1);
                $("#hdnWalkingYN").val(walkngYNVal);

                //ShowHideWalkNoDiv(walkngYNVal);
            });

            $("#divDiet").click(function () {
                $("#hdnDietYN").val($(this).find('.active').text().substr(0, 1));
            });

            $("#divRegMedicineYN").click(function () {
                $("#hdnRegMedYN").val($(this).find('.active').text().substr(0, 1));
            });

            AddOptionsToBPSelect();

            $('#txtCurrWeight,#txtHeight,#txtTemp,#txtPulse,#txtSPO2,#txtBMI,#txtHeadCirc').blockInput({ regex: '[0-9.]' });// #txtSPO2 added by vijeta on 20th aug 2018

            // added by vijeta on 13th april 2018
            $("#divDurationNum").click(function () {
                document.getElementById('layer-DMY').style.display = "none";
                document.getElementById('layer-Numbers').style.display = "block";
                ($('#layer-Numbers')).removeClass('is-active');
            });
            $("#divDurationDays").click(function () {
                document.getElementById('layer-Numbers').style.display = "none";
                document.getElementById('layer-DMY').style.display = "block";
                ($('#layer-DMY')).removeClass('is-active');
            });

            // added by vijeta on 7th april 2018
            var lst = document.getElementById('sideList');
            window.onclick = function (event) {

                if (event.target == document.getElementById('menuDots')) {
                    lst.style.display = "block";
                }
                else {
                    if ($(window).width() >= 996) {
                        lst.style.display = "block";
                    }
                    else
                        lst.style.display = "none";
                }

            }
        });

        //vijeta 17/5/19
        function CalBMI() {
            var sum = 0;
            if ($("#txtCurrWeight").val() != 0 && $("#txtHeight").val() != 0) {
                sum = Number($("#txtCurrWeight").val()) / (((Number($("#txtHeight").val())) / 100) * ((Number($("#txtHeight").val())) / 100));
                $('#txtBMI').val(sum.toFixed(2));
            }
        }

        function AddOptionsToBPSelect() {
            // added by vijeta on 13th april 2018
            var emptyElement = document.createElement("option");
            emptyElement.text = "";
            emptyElement.value = "";
            emptyElement.selected = true;


            document.getElementById("SelSystolic").add(emptyElement);
            for (var i = 80; i <= 200; i++) {
                var selectElem = document.getElementById("SelSystolic");
                var element = document.createElement("option");
                element.text = i;
                element.value = i;
                //if (i == 120) { // commented by vijeta on 13th april 2018
                //    element.selected = true;
                //}
                selectElem.add(element);
            }

            // added by vijeta on 13th april 2018
            var emptyElement1 = document.createElement("option");
            emptyElement1.text = "";
            emptyElement1.value = "";
            emptyElement1.selected = true;

            document.getElementById("SelDiastolic").add(emptyElement1);
            for (var i = 50; i <= 120; i++) {
                var selectElem = document.getElementById("SelDiastolic");
                var element = document.createElement("option");
                element.text = i;
                element.value = i;
                //if (i == 80) {// commented by vijeta on 13th april 2018
                //    element.selected = true;
                //}
                selectElem.add(element);
            }
        }

        // commented by vijeta on 13th april 2018
        //function ShowHideWalkNoDiv(walkngYNVal) {
        //    if (walkngYNVal == "N") {
        //        $("#divWalkingNoInfo").show();

        //    }
        //    else {
        //        $("#divWalkingNoInfo").hide();
        //        $("#Numbers").text("0");
        //        $("#DaySelect").text("Days");

        //    }

        //}

        function checkdata() {
            if (isNaN(String.fromCharCode(event.keyCode))) return false;
            else return (event.keyCode != 32 && event.which != 32);
        }

        function SetDataForVitals(tranNo) {
            $.ajax({
                type: 'post',
                datatype: 'json',
                url: 'SetDataForVitals',
                data: { strTranNo: tranNo },
                success: function (data) {
                    if (data != "") {
                        $("#txtCurrWeight").val(data["Weight"]);
                        $("#txtPrev").val(data["PrevWeight"]);
                        $("#txtHeight").val(data["HEIGHT"]);
                        $("#txtTemp").val(data["TEMP"]);
                        $("#txtPulse").val(data["PULSE"]);
                        $("#txtSPO2").val(data["SPO2"]);//added on 20th Aug 2018

                        //vijeta 17th may 19
                        $("#txtBMI").val(data["BMI"]);
                        $("#txtHeadCirc").val(data["HEADCIRCMF"]);
                        //vijeta 17th may 19

                        //$("#txtBP").val(data["BP"]);
                        if (data["BP"] != "") {
                            var strBP = data["BP"].toString();
                            var strSystolic = strBP.substring(0, strBP.indexOf("/"));
                            var strDiastolic = strBP.substring(strBP.indexOf("/") + 1);

                            $('#SelSystolic option[value=' + strSystolic + ']').attr('Selected', true);
                            $('#SelDiastolic option[value=' + strDiastolic + ']').attr('Selected', true);

                        }

                        $("#txtResp").val(data["RESP"]);
                        $("#txtOthr").val(data["VOTHERS"]);

                        if (data["WALKINGYN"].toString() == "Y") {
                            $("#btnWalkN").removeClass('btn btn-xs btn-info active');
                            $("#btnWalkY").removeClass().addClass('btn btn-xs btn-info active');
                            $("#btnWalkN").addClass('btn btn-xs btn-default');
                            $("#hdnWalkingYN").val('Y');
                            //ShowHideWalkNoDiv($("#hdnWalkingYN").val());// commented by vijeta on 13th april 2018
                            //$("#Numbers").text("0");//commented by vijeta on 13th april 2018
                            //$("#DaySelect").text("Days");//commented by vijeta on 13th april 2018
                        }
                        else {

                        }
                        //added on 14th april 2018
                        if (data["WALKINGDURATION"].toString().trim() == "")
                            $("#Numbers").text("0");
                        else
                            $("#Numbers").text(data["WALKINGDURATION"].toString().trim());

                        if (data["WALKINGDURTYPE"] == "D")
                            $("#DaySelect").text("Days");
                        else if (data["WALKINGDURTYPE"] == "W")
                            $("#DaySelect").text("Weeks");
                        else if (data["WALKINGDURTYPE"] == "M")
                            $("#DaySelect").text("Months");
                        else if (data["WALKINGDURTYPE"] == "Y")
                            $("#DaySelect").text("Years");

                        if (data["DIETYN"].toString() == "Y") {
                            $("#btnDietN").removeClass('btn btn-xs btn-info active');
                            $("#btnDietY").removeClass().addClass('btn btn-xs btn-info active');
                            $("#btnDietN").addClass('btn btn-xs btn-default');
                            $("#hdnDietYN").val('Y');
                        }
                        if (data["REGULARMEDIYN"].toString() == "Y") {
                            $("#btnRegMedN").removeClass('btn btn-xs btn-info active');
                            $("#btnRegMedY").removeClass().addClass('btn btn-xs btn-info active');
                            $("#btnRegMedN").addClass('btn btn-xs btn-default');
                            $("#hdnRegMedYN").val('Y');
                        }
                    }
                }
            });
        }

        function SetWeightLoss() {
            var currWt = $("#txtCurrWeight").val();
            var prevWt = $("#txtPrev").val();

            if (Number(prevWt) > Number(currWt) && currWt != "") {
                var diffWt = Number(prevWt) - Number(currWt);
                $("#txtWghtLG").val(diffWt);
            }
            else
                $("#txtWghtLG").val(0);
        }

        function SaveVitals() {
            var strWt = "" + $('#txtCurrWeight').val();
            var strHt = "" + $('#txtHeight').val();
            var strTp = "" + $('#txtTemp').val();
            var strPu = "" + $('#txtPulse').val();

            //var strBp = "" + $('#txtBP').val();
            var strSystolicVal = $("#SelSystolic").val();
            var strDiastolicVal = $("#SelDiastolic").val();
            var strBp = strSystolicVal + "/" + strDiastolicVal;

            var strRp = "" + $('#txtResp').val();
            var strOt = "" + $('#txtOthr').val();
            var strPrev = "" + $('#txtPrev').val();
            var strTran = ($.session.get('PatTRANNO')).toString();
            var strMr = ($.session.get('PatMRNO')).toString();
            var strWalkngYN = $("#hdnWalkingYN").val();
            var strDietYN = $("#hdnDietYN").val();
            var strMedicineYN = $("#hdnRegMedYN").val();
            var strWalkDur = $("#Numbers").text();
            var strWalkDurType = $("#DaySelect").text().substr(0, 1);
            var strSPO2 = $("#txtSPO2").val();//added on 20th aug 2018

            //vijeta 17th may 2019
            var strBMI = $("#txtBMI").val();
            var strHeadCircf = "";
            if ($("#txtHeadCirc").length > 0) {
                strHeadCircf = $("#txtHeadCirc").val();
            }
            //vijeta 17th may 2019

            var dataToSend =
                {
                    strWeight: strWt,
                    strHeight: strHt,
                    strTemp: strTp,
                    strPulse: strPu,
                    strBlood: strBp,
                    strResp: strRp,
                    strOther: "",
                    strPrevWt: strPrev,
                    strTranno: strTran,
                    strMrNo: strMr,
                    strWalkngYN: strWalkngYN,
                    strDietYN: strDietYN,
                    strMedicineYN: strMedicineYN,
                    strWalkDur: strWalkDur,
                    strWalkDurType: strWalkDurType,
                    strSPO2: strSPO2,//added on 20th aug 2018
                    strBMI: strBMI, //vijeta 17th may 2019
                strHeadCircf: strHeadCircf,//vijeta 17th may 2019
                }


            // window.location.href = 'PatientEntry';

            $.ajax({
                type: "POST",
                url: 'SaveVitals',
                datatype: "json",
                data: dataToSend,
                success: function (result) {
                    window.location.href = 'ClinicEntry';
                },
            });

        }

        function SetText(str) {
            $('#DaySelect').text(str);
        }
        function SetNumber(str) {
            $('#Numbers').text(str);
        }

        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './ClinicalVitals');

                $(window).on('popstate', function () {
                    SaveVitals();
                });

            }
        });
    </script>
</asp:Content>
