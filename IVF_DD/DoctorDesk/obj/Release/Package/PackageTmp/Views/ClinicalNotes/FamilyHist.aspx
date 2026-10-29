<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Clinicalnotes>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>
    <html>
    <head>
        <title></title>
    </head>
    <body>

        <div id="MainDiv" style="width: 100%">
            <div style="width: 100%;">
                <a class="button1 button1-green" id="divForBack" style="margin-bottom: -1%;" onclick="SetpageDirctn()">
                    <i class="fa fa-arrow-left"></i>
                    <strong>Back</strong>
                </a>
            </div>
            <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%">
                <div class="StuckInput" style="margin-top: -18px !important; margin-left: 57%">
                    <button id='freeHandBtn' style="border-radius: 50%; height: 28px; width: 28px; color: white; margin-top: 3px; background-color: #398ebd; border-color: transparent; outline-style: none;" title="Free Text" onclick="AddFreeHistory('F');"><span><i class="fa fa-pencil"></i></span></button>
                </div>
                <%----%>

                <label id="btnSaveFamily" style="background-color: transparent; float: right; margin-right: 25px; border-color: transparent; display: none" title="Save">
                    <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                </label>

                <div style="position: fixed; bottom: 5%; left: 25%; right: 15%; text-align: center; z-index: 1000;">
                    <button id="btnSave" onclick="$('#btnSaveFamily').trigger('click');"
                        style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                        onmouseover="this.style.backgroundColor='#218838'"
                        onmouseout="this.style.backgroundColor='#28a745'">
                        Save
                    </button>
                </div>

              <div id="wrapper" style="width: 100%">
                    <div class="tableDiv" style="padding-top: 20px;">
                        <div style="overflow-x:auto;">  
                            <table class="HeadPatTab" style="text-align: center; width:100%;">
                                <thead>
                                    <tr style="background-color: #fffdc8; font-size: 12px;">
                                        <th style="width:12%;">Relation</th>
                                        <th style="width:5%;">Age</th>
                                        <th style="width:15%;">Disease</th>
                                        <th style="width:8%;" colspan="2">Duration</th>
                                        <th style="width:10%;">Diagnosed Date</th>
                                        <th style="width:10%;">Diseases Status</th>
                                        <th style="width:5%;">Alive</th>
                                        <th style="width:10%;">Death Date</th>
                                        <th style="width:15%;">Cause Death</th>
                                        <th style="width:5%;" class="delete"></th>
                                    </tr>
                                </thead>
                            </table>

                            <table id="tblfamily" class="table HeadPatTab" style="width:100%; text-align:center;">
                                <tbody style="height:70vh;overflow-y: auto;"></tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="layer-Rel" class="po__layer list">
                    <a href="javascript:;" onclick="SetText('Father')" style="font-weight: 500; font-size: 16px">Father</a>
                    <a href="javascript:;" onclick="SetText('Mother')" style="font-weight: 500; font-size: 16px">Mother</a>
                    <a href="javascript:;" onclick="SetText('Wife')" style="font-weight: 500; font-size: 16px">Wife</a>
                    <a href="javascript:;" onclick="SetText('Brother')" style="font-weight: 500; font-size: 16px">Brother</a>
                    <a href="javascript:;" onclick="SetText('Sister')" style="font-weight: 500; font-size: 16px">Sister</a>
                    <a href="javascript:;" onclick="SetText('Grand Father')" style="font-weight: 500; font-size: 16px">Grand Father</a>
                    <a href="javascript:;" onclick="SetText('Grand Mother')" style="font-weight: 500; font-size: 16px">Grand Mother</a>
                    <a href="javascript:;" onclick="SetText('Maternal Aunt')" style="font-weight: 500; font-size: 16px">Maternal Aunt</a>
                    <a href="javascript:;" onclick="SetText('Maternal Uncle')" style="font-weight: 500; font-size: 16px">Maternal Uncle</a>
                    <a href="javascript:;" onclick="SetText('Paternal Uncle')" style="font-weight: 500; font-size: 16px">Paternal Uncle</a>
                    <a href="javascript:;" onclick="SetText('Paternal Aunt')" style="font-weight: 500; font-size: 16px">Paternal Aunt</a>
                </div>
                <div id="layer-demo" class="po__layer list">
                </div>
                <div id="layer-Dis" class="po__layer list col-md-6 col-sm-12 col-xs-6 col-lg-3">
                </div>
                <div id="layer-DMY" class="po__layer list">
                    <a href="javascript:;" onclick="SetText('D')" style="font-weight: 500; font-size: 16px">Days</a>
                    <a href="javascript:; " onclick="SetText('M')" style="font-weight: 500; font-size: 16px">Months</a>
                    <a href="javascript:;" onclick="SetText('Y')" style="font-weight: 500; font-size: 16px">Years</a>
                </div>

                <div id="layer-days" class="po__layer list">
                </div>
                <div id="layer-DiaDate" class="po__layer list">
                </div>
                <div id="layer-DisStatus" class="po__layer list">
                    <a href="javascript:;" onclick="SetText('Ongoing')" style="font-weight: 500; font-size: 16px">Ongoing</a>
                    <a href="javascript:; " onclick="SetText('Recovered')" style="font-weight: 500; font-size: 16px">Recovered</a>
                </div>
                <div id="layer-Alive" class="po__layer list">
                </div>
                <div id="layer-DeathDate" class="po__layer list">
                </div>
                <div id="layer-CauseDeath" class="po__layer list">
                </div>

            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .removeRelation {
            font-size: large;
        }

        table {
            width: 100%;
        }

        thead th {
            height: 30px;
            text-align: left;
        }

        tbody {
            overflow-y: auto;
        }

        .StuckInput {
            width: 100%;
            position: fixed;
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
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

        .table > tbody > tr.active > td {
            border-left: 1px solid #bbbbbb;
            text-align: center;
            padding: 2px;
            cursor: pointer;
        }

            .table > tbody > tr.active > td > a {
                width: 100%;
                display: table;
            }

        .delete {
            width: 16%;
        }

        @media only screen and (min-device-width : 640px)and (max-device-width : 1152px) {

            .delete {
                width: 16.3%;
            }
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            .duration {
                width: 11%;
            }

            day-td {
                width: 11%;
            }

            .dis {
                width: 36%;
            }

            .delete {
                width: 18.08%;
            }

            .HeadPatTab > thead > tr > th {
                text-align: center;
                border: 1px solid #ede4e4;
                font-size: 10px;
            }
        }
    </style>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/Doctorlist.js"></script>
    <script type="text/javascript">
        var idOfDMY = "";
        var freeHandHistory = "";
        var pathFrom = "";
        var gRelation = {
            '01': 'Father', '02': 'Mother', '03': 'Wife',
            '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
            '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
            '11': 'Paternal Aunt'
        };
        var Relcode = {
            'Father': '01', 'Mother': '02', 'Wife': '03',
            'Brother': '04', 'Sister': '05', 'Grand Father': '06',
            'Grand Mother': '07', 'Maternal Aunt': '08', 'Maternal Uncle': '09', 'Paternal Uncle': '10',
            'Paternal Aunt': '11'
        };
        var mandatoryCheckYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("FamHistMandatoryCheck")%>';
        $(document).ready(function (e) {
            HoldOn.open();
            var doctCode = $.session.get('DoctCode');
            var doctName = $.session.get('DoctName');
            SetPatientDtl();
            AddDisease();
            if ($(window).width() >= 996) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";
                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
            }
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
                $('#menuBar').attr('disabled', 'disabled');
            }
            else {
                $("#DoctorInput").val(doctName);
                $("#divForBack").hide();
                $("#iformenubar").show();
                $('#menuBar').removeAttr('disabled');

            }
            var DisStatusSel = "<option value=''>Select</option><option value='Ongoing'>Ongoing</option><option value='Recovered'>Recovered</option><option value='Deceased'>Deceased</option>";
            for (var i = 0; i <= 11; i++) {
                var rows = "<tr class='clickable-row' id='" + i + "'>" +
                    "<td class='rel' style='width:12%;'>" +
                        "<a class='trigger1' href='javascript:;' data-layer-id='layer-Rel' id='Rel" + i + "' style='display:none;font-weight:800;font-size:16px;'>None</a>" +
                    "</td>" +
                    "<td class='age' style='width:5%;'>" +
                        "<a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Age" + i + "' style='display:none;font-weight:800;font-size:16px;'>0</a>" +
                    "</td>" +
                    "<td class='dis' style='width:15%;'>" +
                        "<a class='trigger3' href='javascript:;' data-layer-id='layer-Dis' id='Dis" + i + "' style='display:none;font-weight:800;font-size:16px;'>None</a>" +
                    "</td>" +
                    "<td class='duration' style='width:4%;'>" +
                        "<a class='trigger5' href='javascript:;' data-layer-id='layer-days' id='Num" + i + "' style='display:none;font-weight:800;font-size:16px;'>0</a>" +
                    "</td>" +
                    "<td class='day-td' style='width:4%;'>" +
                        "<a class='trigger4' href='javascript:;' data-layer-id='layer-DMY' id='Days" + i + "' style='display:none;font-weight:800;font-size:16px;'>D</a>" +
                    "</td>" +
                    "<td class='DiaDate' style='width:10%; padding: 0px 2px;'>" +
                        "<input type='text' id='DiaDate" + i + "' class='form-control form-control-sm DatePick trigger6' data-layer-id='layer-DiaDate' style='display:none;' readonly />" +
                    "</td>" +
                    "<td class='DisStatus' style='width:10%;'>" +
                        "<a class='trigger7' href='javascript:;' data-layer-id='layer-DisStatus' id='DisStatus" + i + "' style='display:none;font-weight:800;font-size:16px;'>-</a>" +
                    "</td>" +
                    "<td class='Alive' style='width:5%; text-align:center;'>" +
                        "<input type='checkbox' id='Alive" + i + "' class='trigger8' data-layer-id='layer-Alive' style='display:none;' />" +
                    "</td>" +
                    "<td class='DeathDate' style='width:10%;'>" +
                        "<input type='text' id='DeathDate" + i + "' class='form-control form-control-sm DatePick trigger9' data-layer-id='layer-DeathDate' style='display:none;' readonly />" +
                    "</td>" +
                    "<td class='CauseDeath' style='width:15%;'>" +
                        "<input type='text' id='CauseDeath" + i + "' class='form-control form-control-sm trigger10' data-layer-id='layer-CauseDeath' placeholder='Cause of death' style='display:none;' />" +
                    "</td>" +
                    "<td style='width:5%; text-align:center; vertical-align:middle;'>" +
                        "<i class='fa fa-trash-o removeRelation' style='cursor:pointer;'></i>" +
                    "</td>" +
                "</tr>";

                $('#tblfamily tbody').append(rows);
            }

            for (var i = 0; i <= 99; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='Numage' id='ageSc' style='font-weight:500;font-size:16px;'>" + i + "</a>";
                $("#layer-demo").append(s);

            }
            for (var i = 0; i <= 100; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc' style='font-weight:500;font-size:16px;'>" + i + "</a>";
                $("#layer-days").append(s);

            }
            $('.trigger1').po({ alignment: 'center' });
            $('.trigger2').po({ alignment: 'center' });
            $('.trigger3').po({ alignment: 'center' });
            $('.trigger4').po({ alignment: 'center' });
            $('.trigger5').po({ alignment: 'center' });
            $('.trigger6').po({ alignment: 'center' });
            $('.trigger7').po({ alignment: 'center' });
            $('.trigger8').po({ alignment: 'center' });
            $('.trigger9').po({ alignment: 'center' });
            $('.trigger10').po({ alignment: 'center' });

            $("#layer-demo .Numage").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
            });
            $("#layer-days .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
            });

            $(document.body).on('click', '#layer-Dis .mycls', function (e) {
                var txt = $(this).text();
                SetText(txt);
            });

            $("#btnSaveFamily").click(function () {
                SaveAllFamily("N");
            });

            $(document).on("click", "#tblfamily tr", function () {
                $(this).find("td input[type='date'],td input[type='checkbox'],td input[type='text'], td select").show();
            });
            $(".DatePick").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });

            $(document).on('change', '.trigger8', function () {
                var isChecked = $(this).is(':checked'); 
                var $row = $(this).closest('tr');
                enableDisable(!isChecked, $row); 
            });
        });

        // Enable / Disable 
        function enableDisable(enable, $row) {
            var $death = $row.find('.trigger9');
            var $other = $row.find('.trigger10');

            if (enable) {
                $death.prop('disabled', false).show();
                $other.prop('disabled', false).show();

                if (!$death.data('datepicker')) {
                    $death.datepicker({
                        dateFormat: 'dd-mm-yy',
                        changeMonth: true,
                        changeYear: true
                    });
                } else {
                    $death.datepicker('enable');
                }
            } else {
                $death.val('').prop('disabled', true).hide();
                $other.val('').prop('disabled', true).hide();

                if ($death.data('datepicker')) {
                    $death.datepicker('disable');
                }
            }
        }

        function enableDisable(isChecked, $row) {
            var $el9 = $row.find('.trigger9');
            var $el10 = $row.find('.trigger10');

            if (isChecked) {
                $el9.prop('disabled', false).show();
                $el10.prop('disabled', false).show();
            } else {
                $el9.prop('disabled', true).val('').hide(); 
                $el10.prop('disabled', true).val('').hide();
            }
        }

        function SetText(str) {
            $("#" + idOfDMY).text(str);
            if (idOfDMY.toUpperCase().indexOf("REL") != -1)
                $("#" + idOfDMY).parents('td').nextAll('td.age').find('a.trigger2').trigger('click');
            else if (idOfDMY.toUpperCase().indexOf("AGE") != -1) {
                var Code = idOfDMY.split("Age")[1];
                $("#Num" + Code).text("0");
                $("#Days" + Code).text("D");
                $("#DiaDate" + Code).val("");
                var MinDate = GetMinDateOfAge(str);
                $("#DiaDate" + Code).val("");
                $("#DeathDate" + Code).val("");
                $("#DiaDate" + Code).datepicker("option", "minDate", MinDate);
                $("#DeathDate" + Code).datepicker("option", "minDate", MinDate);
                $("#" + idOfDMY).parents('td').nextAll('td.dis').find('a.trigger3').trigger('click');
            }
            else if (idOfDMY.toUpperCase().indexOf("DIS") != -1)
                $("#" + idOfDMY).parents('td').nextAll('td.duration').find('a.trigger5').trigger('click');
            else if (idOfDMY.toUpperCase().indexOf("NUM") != -1) {
                var Code = idOfDMY.split("Num")[1];
                var Age = $("#Age" + Code).text();
                var Num = $("#Num" + Code).text();
                var Day = $("#Days" + Code).text();
                if (Age != "" && Num != "" && Day != "") {
                    var AgeInDays = ConvertAgeYrsToDay(Age);
                    if (CalcToDay(Num, Day) > AgeInDays) {
                        $.messager.alert("Information", "Duration is greater than Age");
                        $("#Num" + Code).text("0");
                        $("#Days" + Code).text("D");
                    }
                    else {
                        $("#" + idOfDMY).parents('td').nextAll('td.day-td').find('a.trigger4').trigger('click');
                    }
                }
                else {
                    $("#" + idOfDMY).parents('td').nextAll('td.day-td').find('a.trigger4').trigger('click');
                }
            }
            else if (idOfDMY.toUpperCase().indexOf("DAYS") != -1) {
                var Code = idOfDMY.split("Days")[1];
                var Age = $("#Age" + Code).text();
                var Num = $("#Num" + Code).text();
                var Day = $("#Days" + Code).text();
                if (Age != "" && Num != "" && Day != "") {
                    var AgeInDays = ConvertAgeYrsToDay(Age);
                    if (CalcToDay(Num, Day) > AgeInDays) {
                        $.messager.alert("Information", "Duration is greater than Age");
                        $("#Num" + Code).text("0");
                        $("#Days" + Code).text("D");
                    }
                }
            }
        }

        function GetMinDateOfAge(age) {
            var today = new Date();
            today.setFullYear(today.getFullYear() - age);
            return today;
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
                return Number(Age) * 365;
        }

        function SetpageDirctn() {
            SaveAllFamily("N");
        }

        function AddDisease() {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetDiseaseList","Clinicalnotes")%>",
                data: {},
                success: function (result) {
                    var rows = "";
                    if (result.length > 0) {
                        var SearchBox = "<div style='position: fixed;' class='col-md-6 col-sm-12 col-xs-6 col-lg-3'><input type='text' id='txtsearch' onkeyup='DiseaseSearch()' style='width: 98%;height: 27px;' placeholder='Search...'/></div><div style='margin-top:37px;' id='Searchid'></div>";
                        $("#layer-Dis").append(SearchBox);
                    }
                    for (i = 0; i < result.length; i++) {
                        var rows = "<a href='javascript:;' class='mycls' id='" + result[i].DESCCD + "' style='font-weight:500;font-size:16px'>" + result[i].DESC + "</a>";
                        $("#layer-Dis").append(rows);
                    }
                },
                complete: function () {
                    SetDataForFamily();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        function SetDataForFamily() {
            var tranNo = $.session.get('PatTRANNO');
            var mrNo = ($.session.get('PatMRNO'));
            $.ajax({
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo, strMrNo: mrNo },
                url: 'SetDataForFamily',
                success: function (data) {
                    //debugger;
                    if (data[0] != null) {
                        var DisStatusSel = "<option value=''>Select</option><option value='Ongoing'>Ongoing</option><option value='Recovered'>Recovered</option><option value='Deceased'>Deceased</option>";
                        for (var i = 0; i < data[0].length; i++) {
                            flagCheckRowsFamiHist = true;
                            var DiseStatus = data[0][i]["DISEASESTATUS"] == "O" ? "Ongoing" : data[0][i]["DISEASESTATUS"] == "R" ? "Recovered" : "-";
                            $('#tblfamily tr#' + i + ' td.rel')[0].innerHTML = "<a class='trigger1' href='javascript:;' data-layer-id='layer-Rel' id='Rel" + i + "' style='display:none;font-weight:800;font-size:16px;'>" + gRelation[data[0][i]["RELATION"]] + "</a>";
                            $('#tblfamily tr#' + i + ' td.age')[0].innerHTML = "<a class='trigger2' href='javascript:;' data-layer-id='layer-demo' id='Age" + i + "' style='display:none;font-weight:800;font-size:16px;'>" + data[0][i]["AGE"] + "</a>";
                            $('#tblfamily tr#' + i + ' td.dis')[0].innerHTML = "<a class='trigger3' href='javascript:;' data-layer-id='layer-Dis' id='Dis" + i + "' style='display:none;font-weight:800;font-size:16px;'>" + data[0][i]["DISEASES"] + "</a>";
                            $('#tblfamily tr#' + i + ' td.day-td')[0].innerHTML = "<a class='trigger4' href='javascript:;' data-layer-id='layer-DMY' id='Days" + i + "' style='display:none;font-weight:800;font-size:16px;'>" + data[0][i]["DURTYPE"] + "</a>";
                            $('#tblfamily tr#' + i + ' td.duration')[0].innerHTML = "<a class='trigger5' href='javascript:;' data-layer-id='layer-days' id='Num" + i + "' style='display:none;font-weight:800;font-size:16px;'>" + data[0][i]["DURATION"] + "</a>";

                            $('#tblfamily tr#' + i + ' td.DiaDate')[0].innerHTML = "<input type='text' id='DiaDate" + i + "' class='form-control form-control-sm DatePick trigger6' data-layer-id='layer-DiaDate' style='display:none;' value=" + data[0][i]["DIAGNOSEDDATE"] + " readonly />";
                            //$('#tblfamily tr#' + i + ' td.duration')[0].innerHTML = "<a class='trigger7' href='javascript:;' data-layer-id='layer-DisStatus' id='DisStatus" + i + "' style='display:none;font-weight:800;font-size:16px;'>" + data[0][i]["DURATION"] + "</a>";
                            
                            $('#tblfamily tr#' + i + ' td.DisStatus')[0].innerHTML =  "<a class='trigger7' href='javascript:;' data-layer-id='layer-DisStatus' id='DisStatus" + i +
                             "' style='display:none;font-weight:800;font-size:16px;'>" + (DiseStatus) + "</a>";

                            $('#tblfamily tr#' + i + ' td.Alive')[0].innerHTML = "<input  style='display:none;' type='checkbox' id='Alive" + i + "' class='trigger8' data-layer-id='layer-Alive'" + (data[0][i]["ALIVEYN"] == "Y" ? "Checked" : "") + " />";
                            //$('#tblfamily tr#' + i + ' td.DeathDate')[0].innerHTML = "<input type='text' id='DeathDate" + i + "' class='form-control form-control-sm DatePick trigger9' data-layer-id='layer-DeathDate' style='display:none;' value=" + data[0][i]["DATEOFDEATH"] + " readonly />";

                            var $deathTd = $('#tblfamily tr#' + i + ' td.DeathDate');
                            $deathTd.html("<input type='text' id='DeathDate" + i + "' class='form-control form-control-sm DatePick trigger9' " +
                                          "data-layer-id='layer-DeathDate' style='display:none;' value='" + data[0][i]["DATEOFDEATH"] + "' readonly />");
                            $deathTd.find('.trigger9').datepicker({
                                dateFormat: 'dd-mm-yy',
                                changeMonth: true,
                                changeYear: true
                            });
                            var cause = data[0][i]["CAUSEOFDEATH"];
                            cause = (cause == null ? "" : cause.toString().trim().replace(/"/g, '&quot;'));

                            $('#tblfamily tr#' + i + ' td.CauseDeath')[0].innerHTML =
                                "<input type='text' id='CauseDeath" + i + "' " +
                                "class='form-control form-control-sm trigger10' " +
                                "data-layer-id='layer-CauseDeath' " +
                                "placeholder='Cause of death' " +
                                "style='display:none;' " +
                                "value=\"" + cause + "\" />";

                            $('#tblfamily tr#' + i).trigger('click');
                            if (data[0][i]["ALIVEYN"] == "Y") {
                                $("#DeathDate" + i).hide();
                                $("#CauseDeath" + i).hide();
                            }
                        }
                    }
                    if (data[1] != null) {
                        if (data[1][0]["FAMHIST"] != "") {
                            freeHandHistory = data[1][0]["FAMHIST"].toString();
                            $("#freeHandBtn").css("background-color", "green");
                            $("#txtFreeHistory").val(data[1][0]["FAMHIST"].toString());
                            $("#freeHandBtn").trigger('click');
                        }
                    }
                },
                complete: function () {
                    flagCheckRowsFamiHist = false;
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }
            });
        }

        function SaveAllFamily(strPlusBtn) {
            HoldOn.open();
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var familyArr = [];
            var rows = $('#tblfamily > tbody > tr.active').get();
            var flag = true;
            var strMsg = "";
            //debugger;
            if (rows.length > 0) {
                for (var i = 0; i < rows.length; i++) {
                    var code = rows[i].id;
                    var rel = Relcode[rows[i].cells[0].innerText];
                    var age = rows[i].cells[1].innerText;
                    var disease = rows[i].cells[2].innerText;
                    var durType = rows[i].cells[4].innerText;
                    var dur = rows[i].cells[3].innerText;

                    var DiagDate = $("#DiaDate" + code).val();
                    var DisStatus = $("#DisStatus" + code)[0].innerText;
                    var AliveYN = $("#Alive" + code).is(":checked") ? "Y" : "N";
                    var DeathDate = $("#DeathDate" + code).val();
                    var CauseDeath = $("#CauseDeath" + code).val();

                    let Remarks = $('#txtFreeHistory').val();
                    let personRel = gRelation[rel];

                    var a = {
                        MRNO: mrno,
                        NAME: personRel,
                        AGE: age,
                        RELATION: rel,
                        STATUS: "",
                        DISEASES: disease,
                        DURATION: dur,
                        DURTYPE: durType,
                        REMARKS: Remarks,
                        DIAGNOSEDDATE: DiagDate,
                        DISEASESTATUS: DisStatus,
                        ALIVEYN: AliveYN,
                        DATEOFDEATH: DeathDate,
                        CAUSEOFDEATH: CauseDeath
                    };
                    familyArr.push(a);
                }
                $.each(familyArr, function () {
                    if ($(this)[0].RELATION == undefined) {
                        flag = false;
                        strMsg = "Please select Relation";
                    }
                    else if ($(this)[0].DISEASES == "None") {
                        flag = false;
                        strMsg = "Please select Diseases";
                    }
                    if (mandatoryCheckYN == "Y") {
                        if ($(this)[0].AGE == "0") {
                            flag = false;
                            strMsg = "Please select Age";
                        }
                        else if ($(this)[0].DURATION == "0") {
                            flag = false;
                            strMsg = "Please select Duration";
                        }
                    }
                });
            }
            if (flag) {
                $.ajax({
                    type: "POST",
                    url: 'SaveFamily',
                    async: false,
                    datatype: "json",
                    data: { strMedic: JSON.stringify(familyArr), strMRNO: mrno, strTranNo: tranNo },
                    success: function (result) {
                        if (strPlusBtn == "N")
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
            }
            else {
                $.alert(strMsg);
                HoldOn.close();
            }
        }

        jQuery(document).ready(function ($) {
            if (window.history && window.history.pushState) {
                window.history.pushState('forward', null, './FamilyHist');
                $(window).on('popstate', function () {
                    SaveAllFamily("N")
                });
            }
        });

        $(document.body).on('click', 'td.rel a,td.rel', function () {
            document.getElementById('layer-demo').style.display = "none";
            document.getElementById('layer-Dis').style.display = "none";
            document.getElementById('layer-days').style.display = "none";
            document.getElementById('layer-DMY').style.display = "none";
            document.getElementById('layer-DiaDate').style.display = "none";
            document.getElementById('layer-DisStatus').style.display = "none";
            document.getElementById('layer-Alive').style.display = "none";
            document.getElementById('layer-DeathDate').style.display = "none";
            document.getElementById('layer-CauseDeath').style.display = "none";
            document.getElementById('layer-Rel').style.display = "block";
            $('#' + $(this).data('layer-id')).removeClass('is-active');
        });

        $(document.body).on('click', 'td.age a,td.age', function () {
            document.getElementById('layer-Rel').style.display = "none";
            document.getElementById('layer-Dis').style.display = "none";
            document.getElementById('layer-days').style.display = "none";
            document.getElementById('layer-DMY').style.display = "none";
            document.getElementById('layer-DiaDate').style.display = "none";
            document.getElementById('layer-DisStatus').style.display = "none";
            document.getElementById('layer-Alive').style.display = "none";
            document.getElementById('layer-DeathDate').style.display = "none";
            document.getElementById('layer-CauseDeath').style.display = "none";
            document.getElementById('layer-demo').style.display = "block";
            $('#' + $(this).data('layer-id')).removeClass('is-active');
        });
        $(document.body).on('click', 'td.dis a,td.dis', function () {
            document.getElementById('layer-Rel').style.display = "none";
            document.getElementById('layer-demo').style.display = "none";
            document.getElementById('layer-days').style.display = "none";
            document.getElementById('layer-DMY').style.display = "none";
            document.getElementById('layer-DiaDate').style.display = "none";
            document.getElementById('layer-DisStatus').style.display = "none";
            document.getElementById('layer-Alive').style.display = "none";
            document.getElementById('layer-DeathDate').style.display = "none";
            document.getElementById('layer-CauseDeath').style.display = "none";
            document.getElementById('layer-Dis').style.display = "block";
            $('#' + $(this).data('layer-id')).removeClass('is-active');
        });
        $(document.body).on('click', 'td.duration a,td.duration', function () {
            document.getElementById('layer-Rel').style.display = "none";
            document.getElementById('layer-demo').style.display = "none";
            document.getElementById('layer-Dis').style.display = "none";
            document.getElementById('layer-DMY').style.display = "none";
            document.getElementById('layer-DiaDate').style.display = "none";
            document.getElementById('layer-DisStatus').style.display = "none";
            document.getElementById('layer-Alive').style.display = "none";
            document.getElementById('layer-DeathDate').style.display = "none";
            document.getElementById('layer-CauseDeath').style.display = "none";
            document.getElementById('layer-days').style.display = "block";
            $('#' + $(this).data('layer-id')).removeClass('is-active');
        });
        $(document.body).on('click', 'td.day-td a,td.day-td', function () {
            document.getElementById('layer-Rel').style.display = "none";
            document.getElementById('layer-demo').style.display = "none";
            document.getElementById('layer-Dis').style.display = "none";
            document.getElementById('layer-days').style.display = "none";
            document.getElementById('layer-DiaDate').style.display = "none";
            document.getElementById('layer-DisStatus').style.display = "none";
            document.getElementById('layer-Alive').style.display = "none";
            document.getElementById('layer-DeathDate').style.display = "none";
            document.getElementById('layer-CauseDeath').style.display = "none";
            document.getElementById('layer-DMY').style.display = "block";
            $('#' + $(this).data('layer-id')).removeClass('is-active');
        });

        $(document.body).on('click', 'td.DisStatus a,td.DisStatus', function () {
            document.getElementById('layer-Rel').style.display = "none";
            document.getElementById('layer-demo').style.display = "none";
            document.getElementById('layer-Dis').style.display = "none";
            document.getElementById('layer-days').style.display = "none";
            document.getElementById('layer-DiaDate').style.display = "none";
            document.getElementById('layer-DMY').style.display = "none";
            document.getElementById('layer-Alive').style.display = "none";
            document.getElementById('layer-DeathDate').style.display = "none";
            document.getElementById('layer-CauseDeath').style.display = "none";
            document.getElementById('layer-DisStatus').style.display = "block";
            $('#' + $(this).data('layer-id')).removeClass('is-active');
        });

        function ConvertDateFormat() {

        }
    </script>
</asp:Content>
