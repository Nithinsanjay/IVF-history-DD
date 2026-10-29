<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div style="width: 100%; text-align: center">
            <a class="button1 button1-green" id="divForBack" style="margin-bottom: 1.5%;" onclick="SetpageDirctn()">
                <i class="fa fa-arrow-left"></i>
                <strong>Back</strong>
            </a>
        </div>
        <div id="MainDiv">
            <div id="ContentHolderDiv">
                <%--    <div class="InputWrapper">--%>


                <div id="tbldiv">
                </div>
                <div id="layer-demo" class="po__layer list">
                    <%--<a href="javascript:;">0</a>   --%>
                </div>

            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
         /*vijeta 9/5/19*/
        table {
            width: 100%;
        }

        .divHeads {
                padding-left: 2px;
    font-size: 13px;
    color: #ffffff;
    font-weight: bold;
    padding: 4px;
    background-color: #a9a9a9;
    /*border-top: 3px solid #00a65a;*/
     
        }

        .divBody {
            padding: 13px;
            background-color: white; /*rgba(128, 128, 128, 0.15);*/
            font-size: 14px;/*//*/
        }

                   Label {
            margin-left: 5px;
        }
        .panel-body {
            width:auto !important;
            height:auto !important;
            -webkit-box-shadow: 0px 1px 2px 0px #878888;
        }

          .tblFree td
        {
            padding:3px;
            border:1px solid gray;
        }
    </style>
    <%-- <script src="../plugins/alert/jquery-confirm.js"></script>
    <link href="../plugins/alert/jquery-confirm.css" rel="stylesheet">--%>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>
    <script src="../js/canvasjs.min.js"></script>

    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var idOfDMY = "";
        var exam = "";
        $(document).ready(function (e) {
            //debugger;
            HoldOn.open();//
            var doctCode = $.session.get('DoctCode');// added by vijeta on  29th march 2018
            var doctName = $.session.get('DoctName');// added by vijeta on  29th march 2018
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');// added by vijeta on  29th march 2018

            SetPatientDtl();// added by vijeta on  9th march 2018
            AddClinics(urls);
            PatHistory();

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                //kavita 12-aug-2019
                 dispLst.style.display = "block";  
               // $("#slide_sdList").hide();


            }

            // added by vijeta on  29th march 2018
            if (pathFrom != "") {
              
            }
            else {
                //$("#DoctorInput").val(doctName);
                 var doctCd = ('<%:Session["gDoctCode"]%>').toString();
                SearchFunction(doctCd);
                $("#DoctorInput").css("display", "none");
                var leftSideNenuLst = document.getElementById('menuList');
                var rightSideMenuLst = document.getElementById('sideList');
                leftSideNenuLst.style.display = "none";
                rightSideMenuLst.style.display = "none";
            }

            // added by vijeta on 7th april 2018
            //var lst = document.getElementById('sideList');
            //window.onclick = function (event) {
            //    if (event.target == document.getElementById('menuDots') && pathFrom != "") {
            //        lst.style.display = "block";
            //    }
            //    else {
            //        if ($(window).width() >= 996 && pathFrom != "") {
            //            lst.style.display = "block";
            //        }
            //        else
            //            lst.style.display = "none";
            //    }
            //}// commntd
        
        });

        //function PatHistory() {
        //    var tranNo = ($.session.get('PatTRANNO'));
        //    var mrNo = ($.session.get('PatMRNO'));// added by vijeta on 23rd May
        //    $.ajax({
        //        type: "POST",
        //        url: 'GetHistory',
        //        datatype: "json",
        //        data: { strMrNo: mrNo },
        //        success: function (result) {
        //            //window.location.href = 'PatientEntry';
        //            //var x = typeOf(result);
        //            strPrintData = [];
        //            var name = $.session.get('PatName').toString().trim();// changed by vijeta on 9th march 2018
        //            //var name = $.session.get('PatName').split(" ")[1];
        //            var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
        //            //var gRelation = {
        //            //    '01': 'Father', '02': 'Mother', '03': 'Wife',
        //            //    '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
        //            //    '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
        //            //    '11': 'Paternal Aunt' //Added the options from 8 - 11 by Murali on 10/04/2024 as per client request. (Ticket : 2528)
        //            //};
        //            var gPersonaldata = {
        //                '01': 'Alcohol', '02': 'Amphetamines', '03': 'Cocaine',
        //                '04': 'Drugs', '05': 'Opioids', '06': 'Smoking', '07': 'Tobacco'
        //            };
        //            var gPerMeddata = {
        //                '01': 'Hypertension', '02': 'Diabetes', '03': 'Tuberculosis', '04': 'Cancer', '05': 'Asthma', '06': 'Obesity', '07': 'Alzheimer disease',
        //                '08': 'Osteoporosis', '09': 'Cardiovascular Disease'
        //            };

        //            if (result != "") {
        //                //Append each row to html table
        //                //if (result.jsonFamily.length > 0)

        //                if (result.jsonFamily != "" || result.jsonFreeFamily != "") {
        //                    strPrintData = [];
        //                    var tempData = "<div class='panel'><div class='panel-heading divHeads'>Family History</div>    <div class='panel-body divBody'>";
        //                if (result.jsonFamily != "") {
        //                    tempData += "<ul>";
        //                    for (var i = 0; i < result.jsonFamily.length; i++) {
        //                        var dur = (result.jsonFamily[i].DURATION != "0" ? " since " + result.jsonFamily[i].DURATION + " " + gDurType[result.jsonFamily[i].DURTYPE] + "(s)" : "")
        //                        tempData = tempData + "<li><div>" + gRelation[result.jsonFamily[i].RELATION] + " (" + result.jsonFamily[i].AGE + "yrs), suffering with <b>" +
        //                            result.jsonFamily[i].DISEASES + "</b>"+dur +"</div>";

        //                    }
        //                    tempData += "</ul>";
        //                }
        //                if (result.jsonFreeFamily != "") {
        //                    tempData += "<table style='width:90%;border-collapse:collapse;border:1px solid gray;margin-left:22px;' class='tblFree'>";
        //                    for (var i = 0; i < result.jsonFreeFamily.length; i++) {

        //                        tempData = tempData + "<tr><td style='width:20%'>" + result.jsonFreeFamily[i].TRANDATE + "</td><td>" + result.jsonFreeFamily[i].FAMHIST + "</td></tr>";
        //                    }
        //                    tempData += "</table>";
        //                }

        //                strPrintData.push(tempData);
        //                document.getElementById("tbldiv").innerHTML += strPrintData[0];
        //                tempData = tempData + '</div></div>';
        //            }
        //            else {
        //                //tempData = tempData + "<div>No Family History Found.</div>";
        //            }



        //                //if (result.jsonPersonal.length > 0)

        //                if (result.jsonPersonal != "" || result.jsonFreePersonal != "") {
        //                    strPrintData = [];
        //                    var tempData = "<div class='panel'><div class='panel-heading divHeads'>Personal History</div>    <div class='panel-body divBody'>";
        //                    if (result.jsonPersonal != "") {
        //                        tempData += "<ul>";
        //                        for (var i = 0; i < result.jsonPersonal.length; i++) {
        //                            //changed by karthick to remove Addicted to
        //                            //tempData = tempData + "<li><div>Addicted to <b>" + result.jsonPersonal[i].NAME + "</b>";
        //                            tempData = tempData + "<li><div><b>" + result.jsonPersonal[i].NAME + "</b>";
        //                            if (result.jsonPersonal[i].STOPAGE != "") {
        //                                var dur = (result.jsonPersonal[i].STOPAGE != "0") ? " from " + result.jsonPersonal[i].STOPAGE + " " + result.jsonPersonal[i].STARTAGE : "";
        //                                tempData = tempData + dur;
        //                            }

        //                            tempData = tempData + "</div>";
        //                        }
        //                        tempData += "</ul>";
        //                    }
        //                    if (result.jsonFreePersonal != "") {
        //                        tempData += "<table style='width:90%;border-collapse:collapse;border:1px solid gray;margin-left:22px;' class='tblFree'>";
        //                        for (var i = 0; i < result.jsonFreePersonal.length; i++) {

        //                            tempData = tempData + "<tr><td style='width:20%'>" + result.jsonFreePersonal[i].TRANDATE + "</td><td>" + result.jsonFreePersonal[i].PERSHIST + "</td></tr>";
        //                        }
        //                        tempData += "</table>";
        //                    }
        //                    tempData = tempData + '</div></div>';
        //                    strPrintData.push(tempData);
        //                    document.getElementById("tbldiv").innerHTML += strPrintData[0];
        //                }
        //                else {
        //                    //tempData = tempData + "<div>No Personal History Found.</div>";
        //                }
        //                if (result.jsonMedical != "" || result.jsonFreeMedical != "") {
        //                    strPrintData = [];
        //                    var tempData = "<div class='panel'><div class='panel-heading divHeads'>Medical History</div>    <div class='panel-body divBody'>";
        //                    if (result.jsonMedical != "") {
        //                        tempData += "<ul>";
        //                        for (var i = 0; i < result.jsonMedical.length; i++) {
        //                            tempData = tempData + "<li><div>Suffering with <b>" + result.jsonMedical[i].NAME + "</b>";
        //                            if (result.jsonMedical[i].DURATION != "") {
        //                                var dur = (result.jsonMedical[i].DURATION != "0") ? " since " + result.jsonMedical[i].DURATION + " " + gDurType[result.jsonMedical[i].DURTYPE] + "(s)" : "";
        //                                tempData = tempData + dur;
        //                            }
        //                            tempData = tempData + "</div></li>";

        //                        }
        //                        tempData += "</ul>";
        //                    }
        //                    if (result.jsonFreeMedical != "") {
        //                        tempData += "<table style='width:90%;border-collapse:collapse;border:1px solid gray;margin-left:22px;' class='tblFree'>";
        //                        for (var i = 0; i < result.jsonFreeMedical.length; i++) {

        //                            tempData = tempData + "<tr><td style='width:20%'>" + result.jsonFreeMedical[i].TRANDATE + "</td><td>" + result.jsonFreeMedical[i].MEDHIST + "</td></tr>";
        //                        }
        //                        tempData += "</table>";
        //                    }
        //                    tempData = tempData + '</div></div>';
        //                    strPrintData.push(tempData);
        //                    document.getElementById("tbldiv").innerHTML += strPrintData[0];
        //                }


        //                else {
        //                   // tempData = tempData + "<div>No Medical History Found.</div>";
        //                }





        //                if (result.jsonAllergy != "") {
        //                    strPrintData = [];
        //                    var tempData = "<div class='panel'><div class='panel-heading divHeads'>Allergy</div>    <div class='panel-body divBody'>";
        //                    if (result.jsonAllergy != "") {
        //                        tempData += "<ul>";
        //                        for (var i = 0; i < result.jsonAllergy.length; i++) {
        //                            tempData = tempData + "<li><div>Allergy - <b>" + result.jsonAllergy[i].NAME + "</b>";  //25-11-2019 17:17
        //                            if (result.jsonAllergy[i].DURATION != "") {
        //                                var dur = (result.jsonAllergy[i].DURATION != "0") ? " since " + result.jsonAllergy[i].DURATION + " " + gDurType[result.jsonAllergy[i].DURTYPE] + "(s)" : "";
        //                                tempData = tempData + dur;
        //                            }
        //                            if (result.jsonAllergy[i].REMARKS != "") {
        //                                var rem = "( " + result.jsonAllergy[i].REMARKS + " )";
        //                                tempData = tempData + rem;
        //                            }
        //                            tempData = tempData + "</div>";
        //                        }
        //                        tempData += "</ul>";
        //                    }
        //                    tempData = tempData + '</div></div>';
        //                    strPrintData.push(tempData);
        //                    document.getElementById("tbldiv").innerHTML += strPrintData[0];
        //                }
        //                else {
        //                   // tempData = tempData + "<div>No Allergy Found.</div>";
        //                }



        //            }
        //            else {
        //                document.getElementById("tbldiv").innerHTML = "<div class='panel'><div class='panel-body divBody'>No History Found</div></div>";
        //            }
        //        },
        //        complete: function () {
        //            HoldOn.close();//
        //        },
        //        error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
        //    });
        //}

        function PatHistory() {
            var tranNo = $.session.get('PatTRANNO');
            var mrNo = $.session.get('PatMRNO');

            $.ajax({
                type: "POST",
                url: 'GetHistory',
                datatype: "json",
                data: { strMrNo: mrNo },
                success: function (result) {
                    strPrintData = [];
                    var name = $.session.get('PatName').toString().trim();

                    var gDurType = { 'Select': ' ', 'D': 'Day', 'W': 'Week', 'M': 'Month', 'Y': 'Year' };
                    var gRelation = {
                        '01': 'Father', '02': 'Mother', '03': 'Wife',
                        '04': 'Brother', '05': 'Sister', '06': 'Grand Father',
                        '07': 'Grand Mother', '08': 'Maternal Aunt', '09': 'Maternal Uncle', '10': 'Paternal Uncle',
                        '11': 'Paternal Aunt'
                    };

                    function appendPanel(title, content) {
                        document.getElementById("tbldiv").innerHTML += "<div class='panel' style='width:77%'><div class='panel-heading divHeads'>" + title + "</div><div class='panel-body divBody' style='width:200px;font-size:14px;height:50px;'>" + content + "</div></div>";
                    }

                    // FAMILY HISTORY
                    if ((result.jsonFamily && result.jsonFamily.length > 0) || (result.jsonFreeFamily && result.jsonFreeFamily.length > 0)) {
                        var tempData = "";
                        if (result.jsonFamily && result.jsonFamily.length > 0) {
                            tempData += "<ul>";
                            for (var i = 0; i < result.jsonFamily.length; i++) {
                                var dur = (result.jsonFamily[i].DURATION != "0") ?
                                    " since " + result.jsonFamily[i].DURATION + " " + gDurType[result.jsonFamily[i].DURTYPE] + "(s)" : "";
                                tempData += "<li><div>" + gRelation[result.jsonFamily[i].RELATION] + " (" + result.jsonFamily[i].AGE + "yrs), suffering with <b>" +
                                    result.jsonFamily[i].DISEASES + "</b>" + dur + "</div></li>";
                            }
                            tempData += "</ul>";
                        }

                        if (result.jsonFreeFamily && result.jsonFreeFamily.length > 0) {
                            tempData += "<table style='width:90%;border-collapse:collapse;border:1px solid gray;margin-left:22px;' class='tblFree'>";
                            for (var i = 0; i < result.jsonFreeFamily.length; i++) {
                                tempData += "<tr><td style='width:20%'>" + result.jsonFreeFamily[i].TRANDATE + "</td><td>" + result.jsonFreeFamily[i].FAMHIST + "</td></tr>";
                            }
                            tempData += "</table>";
                        }

                        appendPanel("Family History", tempData);
                    } else {
                        appendPanel("Family History", "No Vital History Found");
                    }

                    // PERSONAL HISTORY
                    if ((result.jsonPersonal && result.jsonPersonal.length > 0) || (result.jsonFreePersonal && result.jsonFreePersonal.length > 0)) {
                        var tempData = "";
                        if (result.jsonPersonal && result.jsonPersonal.length > 0) {
                            tempData += "<ul>";
                            for (var i = 0; i < result.jsonPersonal.length; i++) {
                                tempData += "<li><div><b>" + result.jsonPersonal[i].NAME + "</b>";
                                if (result.jsonPersonal[i].STOPAGE != "" && result.jsonPersonal[i].STOPAGE != "0") {
                                    tempData += " from " + result.jsonPersonal[i].STOPAGE + " " + result.jsonPersonal[i].STARTAGE;
                                }
                                tempData += "</div></li>";
                            }
                            tempData += "</ul>";
                        }

                        if (result.jsonFreePersonal && result.jsonFreePersonal.length > 0) {
                            tempData += "<table style='width:90%;border-collapse:collapse;border:1px solid gray;margin-left:22px;' class='tblFree'>";
                            for (var i = 0; i < result.jsonFreePersonal.length; i++) {
                                tempData += "<tr><td style='width:20%'>" + result.jsonFreePersonal[i].TRANDATE + "</td><td>" + result.jsonFreePersonal[i].PERSHIST + "</td></tr>";
                            }
                            tempData += "</table>";
                        }

                        appendPanel("Personal History", tempData);
                    } else {
                        appendPanel("Personal History", "No Vital History Found");
                    }

                    // MEDICAL HISTORY
                    if ((result.jsonMedical && result.jsonMedical.length > 0) || (result.jsonFreeMedical && result.jsonFreeMedical.length > 0)) {
                        var tempData = "";
                        if (result.jsonMedical && result.jsonMedical.length > 0) {
                            tempData += "<ul>";
                            for (var i = 0; i < result.jsonMedical.length; i++) {
                                tempData += "<li><div>Suffering with <b>" + result.jsonMedical[i].NAME + "</b>";
                                if (result.jsonMedical[i].DURATION != "" && result.jsonMedical[i].DURATION != "0") {
                                    tempData += " since " + result.jsonMedical[i].DURATION + " " + gDurType[result.jsonMedical[i].DURTYPE] + "(s)";
                                }
                                tempData += "</div></li>";
                            }
                            tempData += "</ul>";
                        }

                        if (result.jsonFreeMedical && result.jsonFreeMedical.length > 0) {
                            tempData += "<table style='width:90%;border-collapse:collapse;border:1px solid gray;margin-left:22px;' class='tblFree'>";
                            for (var i = 0; i < result.jsonFreeMedical.length; i++) {
                                tempData += "<tr><td style='width:20%'>" + result.jsonFreeMedical[i].TRANDATE + "</td><td>" + result.jsonFreeMedical[i].MEDHIST + "</td></tr>";
                            }
                            tempData += "</table>";
                        }

                        appendPanel("Medical History", tempData);
                    } else {
                        appendPanel("Medical History", "No Vital History Found");
                    }

                    // ALLERGY
                    if (result.jsonAllergy && result.jsonAllergy.length > 0) {
                        var tempData = "<ul>";
                        for (var i = 0; i < result.jsonAllergy.length; i++) {
                            tempData += "<li><div>Allergy - <b>" + result.jsonAllergy[i].NAME + "</b>";
                            if (result.jsonAllergy[i].DURATION != "" && result.jsonAllergy[i].DURATION != "0") {
                                tempData += " since " + result.jsonAllergy[i].DURATION + " " + gDurType[result.jsonAllergy[i].DURTYPE] + "(s)";
                            }
                            if (result.jsonAllergy[i].REMARKS != "") {
                                tempData += " (" + result.jsonAllergy[i].REMARKS + ")";
                            }
                            tempData += "</div></li>";
                        }
                        tempData += "</ul>";
                        appendPanel("Allergy", tempData);
                    } else {
                        appendPanel("Allergy", "No Vital History Found");
                    }

                    // If all empty, show general message
                    if ((!result.jsonFamily || result.jsonFamily.length == 0) &&
                        (!result.jsonFreeFamily || result.jsonFreeFamily.length == 0) &&
                        (!result.jsonPersonal || result.jsonPersonal.length == 0) &&
                        (!result.jsonFreePersonal || result.jsonFreePersonal.length == 0) &&
                        (!result.jsonMedical || result.jsonMedical.length == 0) &&
                        (!result.jsonFreeMedical || result.jsonFreeMedical.length == 0) &&
                        (!result.jsonAllergy || result.jsonAllergy.length == 0)) {

                        document.getElementById("tbldiv").innerHTML = "<div class='panel' style='width:77%'><div class='panel-body divBody' style='width:200px;font-size:14px;height:50px;'>No Vital History Found</div></div>";
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function () {
                    HoldOn.close();
                }
            });
        }

        function SetpageDirctn() {
            if (pathFrom == "") {
                window.location.href = '../ClinicalNotes/ClinicEntry';
            } else
                window.location.href = '../DoctorDesk/PatientEntry';
        }
    </script>
</asp:Content>
