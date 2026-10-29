<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <html>
    <head>
        <title></title>
    </head>
    <body>
      <div class="row" style="height: 30px; border-color:#bce8f1;color:#d25a05; border: 1px solid transparent;  text-align: center;font-size:18px;display:none" id="divmail">
      <label id="P_Email" ></label>
            <%-- <span id="Addpencil" style="margin-left:5px;cursor: pointer;"><img style="height:29px;width:29px;" src="../Images/pencil.png" /></span>--%>
       </div>

         <div id="FilterDiv" style="margin-top: 0px;display:block;" class="row panel-body">
                    <div class="col-xs-12 col-sm-8 col-md-12 col-lg-8" style="padding-bottom: 10px;">
                        <div class="col-xs-12 col-sm-6" style="width:45%;">
                            <label class="col-12 col-sm-4" style="font-weight: bold; font-size: 13px; margin-top: 10px; padding: 0;">From Date</label>
                            <div class="col-12 col-sm-7">
                                <input type="text" class="form-control" id="txtFromDate" onchange="$('#txtToDate').datepicker('option', 'minDate', $('#txtFromDate').val());" readonly="readonly">
                            </div>
                        </div>

                        <div class="col-xs-12 col-sm-6" style="width: 45%;">
                            <label class="col-12 col-sm-4" style="font-weight: bold; font-size: 13px; margin-top: 10px; padding: 0;">To Date</label>
                            <div class="col-12 col-sm-7">
                                <input type="text" class="form-control" id="txtToDate" readonly="readonly">
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-4 col-md-12 col-lg-4">
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-12 doctordiv">
                            <label class="col-12 col-sm-4" style="font-weight: bold; font-size: 13px; margin-top: 10px; padding: 0;">Doctor</label>
                            <div class="col-12 col-sm-7">
                                <select id="cmbDoctList" class="form-control" style="width: 100%;"><option value="">---All---</option></select>
                            </div>
                        </div>
                         <div class="col-xs-2 searchdiv" style="text-align: end;">
                            <i class="fa fa-search searchIcon" aria-hidden="true" title="Search" onclick="PatMedicationHistory('S')"></i>
                        </div>
                    </div>
                    
                    <div class="col-xs-12" style="display: flex;align-items: center;">
                        <div class="col-xs-10">
                        <fieldset class="FilterFieldset" id="ChkFieldSet">
                            <legend style="font-size: 13px;margin-bottom: 10px;font-weight: bold;margin-left: 5px;">Show</legend>
                            <div class="FCheckBoxDiv">
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkCheifComp" onclick="FilterData('CheifCompDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkCheifComp');FilterData('CheifCompDispYN', 'chkCheifComp')">Chief Complaints</label>
                            </div>
                            <div class="FCheckBoxDiv">
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkGeneralExam" onclick="FilterData('GenExamDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkGeneralExam');FilterData('GenExamDispYN', 'chkGeneralExam')">Vitals</label>
                            </div>
                            <div class="FCheckBoxDiv">
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkHistory" onclick="FilterData('HistoryDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkHistory');FilterData('HistoryDispYN', 'chkHistory')">History</label>
                            </div>
                            <div class="FCheckBoxDiv">
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkDiagnosis" onclick="FilterData('DiagnosisDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkDiagnosis');FilterData('DiagnosisDispYN', 'chkDiagnosis')">Diagnosis</label>
                            </div>

                            <div class="FCheckBoxDiv"> 
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkOnExam" onclick="FilterData('OnExamDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkOnExam');FilterData('OnExamDispYN', 'chkOnExam')">Physical Examination</label>
                            </div>

                            <div class="FCheckBoxDiv">
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkRx" onclick="FilterData('RxDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkRx');FilterData('RxDispYN', 'chkRx')">Rx</label>
                            </div>

                            <div class="FCheckBoxDiv">
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkAdvInvst" onclick="FilterData('AdvInvstDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkAdvInvst');FilterData('AdvInvstDispYN', 'chkAdvInvst')">Advice for Investigations</label>
                            </div>

                            <div class="FCheckBoxDiv">
                                <input type="checkbox" name="AllCheck" class="Chkbox" id="chkRAdvice" onclick="FilterData('AdviceDispYN', this.id)" />
                                <label class="ChkBoxLbl" onclick="CheckedBox('chkRAdvice');FilterData('AdviceDispYN', 'chkRAdvice')">Other Advices</label>
                            </div>
                        </fieldset>
                        </div>
                       <%-- <div class="col-xs-2" style="text-align: end;">
                            <i class="fa fa-search searchIcon" aria-hidden="true" title="Search" onclick="PatMedicationHistory('S')"></i>
                        </div>--%>
                    </div>
                </div>

        <div id="MainDiv">
            <div id="ContentHolderDiv">
                <div id="tbldiv">
                </div>
            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    
    <style>
  
        table:not(#tbldiv) {
            width: 100%;
        }

        .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 13px;
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
        .panel-body 
     {
            width:auto !important;
            height:auto !important;
            -webkit-box-shadow: 0px 1px 2px 0px #878888;
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
            .leftHead{
            font-size: 13px;
            font-weight: bolder;
            background-color: antiquewhite;
        }
            .liClass{
                font-size:13px;
                color:black;
            }

            .tblRx td,th{
                padding:1px;
            }
            .panel-heading {
            padding: 2px 5px;
        }
        /*==============================*/
        :checked + label:before {
            content: "";
            background-color: #f5f8fa;
            transform: none;
        }

        :checked + label {
            border: none;
            border-color: #f5f8fa;
        }
        .FilterDiv {
            padding: 10px 0px;
            width: 100%;
            display: inline-block;
            border-radius: 15px;
            -webkit-box-shadow: 0px 0px 2px 0px #878888;
                margin-bottom: 10px;
        }
        .FilterFieldset {
            width: 100%;
            display: inline-block;
            border-radius: 15px;
            margin-top: 10px;
        }
        .FCheckBoxDiv {
            display: inline-block;
            padding: 0px 10px;
        }
        .Chkbox{
            vertical-align: text-bottom;
        }
        .ChkBoxLbl{
            font-size: 13px;
            margin-bottom: 0px;
        }
        .searchIcon {
            font-size: 30px;
            border: 1px solid;
            padding: 5px;
            border-radius: 10px;
            color: white;
            background: #6d9cf5;
            transition: background-color 0.2s;
            cursor:pointer;
        }
        .searchIcon:hover{
            background:#4985f7;
        }

        .CheifCompDispYN {
            display: block;
        }

        .GenExamDispYN {
            display: block;
        }

        .HistoryDispYN {
            display: block;
        }

        .DiagnosisDispYN {
            display: block;
        }

        .OnExamDispYN {
            display: block;
        }

        .RxDispYN {
            display: block;
        }
                .AdvInvstDispYN {
            display: block;
        }
                        .AdviceDispYN {
            display: block;
        }
        /*Tablet Sizes Start*/
         @media only screen and (min-device-width : 600px) and (max-device-width : 768px) {
            .doctordiv {
                width: 70%;
            }

            .searchdiv {
                   margin-top: 5%;
            }
        }

        @media only screen and (min-device-width : 768px) and (max-device-width : 991px) {
            .doctordiv {
                width: 100%;
                margin-left: -30%;
            }

            .searchdiv {
                           margin-top: -0.5%;
            }
        }
        @media only screen and (min-device-width : 992px) and (max-device-width : 1024px) {
            .doctordiv {
               margin-left:0%;
            }
            .select2-container--default .select2-selection--single
            {
                margin-left:-10%;
            }

            .searchdiv {
                           margin-top: -0.5%;
            }
        }
        /*Tablet Size End*/

        /*Mobile Size Start*/
        @media only screen and (min-device-width : 320px) and (max-device-width : 474px) {
            .doctordiv {
                width: 70%;
            }

            .searchdiv {
                margin-top: 8.5%;
                margin-left:3%;
            }
        }

        @media only screen and (min-device-width : 475px) and (max-device-width : 540px) {
            .doctordiv {
                width: 70%;
            }

            .searchdiv {
                margin-top: 7%;
                margin-left:3%;
            }
        }
        /*Mobile Size End*/

        /*Desktop and Laptop Size Start*/
        @media only screen and (min-device-width : 1200px) and (max-device-width : 1366px) {
            .doctordiv {
                width: 100%;
                 margin-left: -30%;
            }

            .searchdiv {
                        margin-top: -2%;
                
            }
        }
         @media only screen and (min-device-width : 1366px) and (max-device-width : 1920px) {
            .doctordiv {
                       width: 100%;
                       margin-left: -30%;
            }

            .searchdiv {
                /*margin-top: 3%;
                margin-left:-1%;*/
                        margin-top: -2%;
            }
        }
       /*Desktop and Laptop Size End*/
    </style>
    <script src="../Scripts/PatList.js"></script>
    <script type="text/javascript">
        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var idOfDMY = "";
        var exam = "";
        var result = "";
        var DoctorList = '<%:Html.Raw(ViewBag.DoctorList)%>';
        //Added by Ashvini on 20/11/2024 to check whether to allow to send email for the non completed prescription
        var AllowMailBeforePrescriptionCompl = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("AllowMailBeforePrescriptionCompl")%>';
        //added by ashvini  on 25/11/2024 to hide the div if the value of the  DispSrchCritInMedHistory  is other than Y 
        var DispSrchCritInMedHistory = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("DispSrchCritInMedHistory")%>';
        var GeneralWiseYN = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("GENERICWISEDATAYN")%>';
        $(document).ready(function (e) {
            $("#txtFromDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });
            $("#txtToDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                minDate: new Date(),
                maxDate: new Date()
            });
            //$('#txtFromDate').datepicker('setDate', 'today');
            //$('#txtToDate').datepicker('setDate', 'today');
            $('#ChkFieldSet input[type="checkbox"]').prop('checked', true);
            BindDoctorList();
            HoldOn.open();//
            var doctCode = $.session.get('DoctCode');// added by vijeta on  29th march 2018
            var doctName = $.session.get('DoctName');// added by vijeta on  29th march 2018
            pathFrom = $.session.get('Pagefrom') == undefined ? "" : $.session.get('Pagefrom');// added by vijeta on  29th march 2018

            SetPatientDtl();// added by vijeta on  9th march 2018
            AddClinics(urls);
            PatMedicationHistory();

            ToEmailID = $.session.get('PatEmail');
            if (ToEmailID != "" && ToEmailID != undefined) {
                //$("#divmail").show();
                $("#P_Email").html(ToEmailID);
            }
            else {
                $("#P_Email").html("Email ID is not registered.");
                //$("#Addpencil").remove();
            }

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                dispLst.style.display = "block";
                $("#slide_sdList").hide();
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
            var lst = document.getElementById('sideList');
            window.onclick = function (event) {
                if (event.target == document.getElementById('menuDots') && pathFrom != "") {
                    lst.style.display = "block";
                }
                else {
                    if ($(window).width() >= 996 && pathFrom != "") {
                        lst.style.display = "block";
                    }
                    else
                        lst.style.display = "none";
                }
            }

            $(document).on('click', '.copyHisCls', function (e) {
                //GetCopy($(this)[0].id);
                var id = $(this)[0].id;
                $.confirm({
                    title: 'Confirmation',
                    content: 'Are you sure to copy/overwrite present prescription?',
                    buttons: {
                        confirm: function () {
                            GetCopy(id);
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        },
                    }
                });
            });

            $(document).on('click', '.sendEmail', function (e) {
                ////GetCopy($(this)[0].id);
                //var id = $(this)[0].id;
                //SendMailAction(id);
                //added by ashvini 20/11/2024
                var completedYN = $(this).data('completedyn');
                var id = $(this).attr('id');
                if (AllowMailBeforePrescriptionCompl != 'Y') {
                    if (completedYN === "N") {
                        $.messager.alert("Information", "The prescription is not complete. You cannot send the mail before completion.");
                    } else {
                        SendMailAction(id);
                    }
                }
                else {
                    SendMailAction(id);
                }
            });

            $(window.document).on('mouseup touchend', function (event) {
                // Capture this event anywhere in the document, since the mouse may leave our element while mouse is down and then the 'up' event will not fire within the element.
                mouseDown = true;
            });

            $(document).on('click', '.ExColicon', function (e) {
                $(this).closest('tr').find('span.spanCls').toggleClass('fa fa-caret-down fa fa-caret-right');
                if ($(this).context.offsetParent.parentElement.nextElementSibling.style.display == "block")
                    $(this).context.offsetParent.parentElement.nextElementSibling.style.display = "none";
                else
                    $(this).context.offsetParent.parentElement.nextElementSibling.style.display = "block";
            });

            //added by ashvini on 25/11/2024 to hide the filter div based on value set in the appsetting 
            if (DispSrchCritInMedHistory == 'Y') {
                $('#FilterDiv').css('display', '');
            }  
        });

        function PopupForMail(strTranNo) {
            $.confirm({
                title: '',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                theme: 'bootstrap',
                content: '' +
                '<form action="" class="formName"><div class="form-group"><label style="font-size:12px">Enter Email ID</label><br>' +
                '<textarea  type="varchar" id="txtemail"  placeholder="Enter email" autofocus="autofocus" rows="2" class="setUp form-control" required />' +
                '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Send',
                        btnClass: 'btn-blue',
                        action: function () {
                            tomail = $("#txtemail").val();
                            if ($("#txtemail").val() == "" || $("#txtemail").val() == null) {// 18-12-19	
                                $('#txtemail').css({ 'border-color': 'Red' });
                                $('#txtemail').val("");
                                return false;
                            } else {
                                if (validateEmail(tomail) == false) {
                                    alert("Invalid Email ID format.");
                                    return false;
                                }
                                else {
                                    $('#txtemail').css({ 'border-color': '' });
                                    Callajxmail(tomail, strTranNo);
                                }
                            }
                        }
                    },
                    Closed: {
                        text: 'Cancel'
                    }
                },
                onContentReady: function () {
                    if (ToEmailID == "" || ToEmailID == null) {
                        $('#txtemail').val("");
                    }
                    else
                        $("#txtemail").val(ToEmailID);
                }
            });
        }

        function CloseFancyBox() {
            $.fancybox.close();
        }

        function SendMailAction(strTranNo) {

            var id = strTranNo;
            $.confirm({
                title: 'Confirmation',
                content: 'Are you sure , you want to send an prescription over email?',
                buttons: {
                    confirm: function () {
                        var tomail = ($.session.get('PatEmail'));
                        if (tomail == "" || tomail == null) {
                            PopupForMail(id);
                        }
                        else {
                            Callajxmail(tomail, id)
                        }
                    },
                    cancel: function () {

                    },
                }
            });
        };

        function Callajxmail(tomail, TranNo) {
            HoldOn.open();
            var infotomail = "";
            var Mrno = ($.session.get('PatMRNO'));
            var datatosend = {
                tranno: TranNo,//"06C170704NR0001"
                type: "NAME",
                MrNo: Mrno,
            }

            var Html = "";
            $.ajax({
                type: "Post",
                url: "../DoctorDesk/GetDoctorDeskData",
                data: datatosend,
                async: false,
                success: function (response) {

                    GridData = response;
                    //Meenakshi to get the personalized signature of the doctor
                    digitsign1 = "";
                    digitsign2 = "";
                    digitsign3 = "";
                    sign1 = "";
                    sign2 = "";
                    sign3 = "";
                    if (GridData.jsonDoctorDetails.length > 0)
                        GetDoctSignature(GridData.jsonDoctorDetails[0].DOCTCODE);
                    infotomail = PrintData(TranNo, Mrno); //only update this function , take latest code from the doctor desk module from the Printdata2 function

                    //Addded by ashvini to set header i.e patient info 
                    infotomail2 = PrintPatInfo();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    ajaxindicatorstop();
                    MsgDia(textStatus, "Error");
                    HoldOn.close();//01-10-19
                }
            });

            var datatosend1 = {
                printdata: encodeURIComponent(infotomail),
                TranNo: TranNo,
                ToMailId: tomail,
                Mrno: Mrno,
                printdataTop: encodeURIComponent(infotomail2),
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/SendMailAction",
                async: false,
                data: datatosend1,
                dataType: "json",
                success: function (response) {
                    HoldOn.close();
                    $.messager.alert("Information", response);
                },
                error: function () {
                    HoldOn.close();
                    alert('error');
                }
            });
        }

        function validateEmail(Toemail) {
            var field;
            var RslValStr;
            var regex = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (Toemail.indexOf(",") > 0) {
                field = Toemail.split(",");
                for (num = 0; num < field.length; num++) {
                    var email = field[num].replace(/[\r\n]+/gm, "");;
                    RslValStr = (regex.test(email)) ? true : false;
                    if (RslValStr == false)
                        return RslValStr;
                }
            }
            else {
                field = Toemail;
                RslValStr = (regex.test(field)) ? true : false;
            }
            return RslValStr
        }


        function selectText(node) {
            node = document.getElementById(node);

            if (document.body.createTextRange) {
                const range = document.body.createTextRange();
                range.moveToElementText(node);
                range.select();
            } else if (window.getSelection) {
                const selection = window.getSelection();
                const range = document.createRange();
                range.selectNodeContents(node);
                selection.removeAllRanges();
                selection.addRange(range);
            } else {
                console.warn("Could not select text in node: Unsupported browser.");
            }
        }


        function GetCopy(oldTranno) {
            HoldOn.open();//
            var mrno = ($.session.get('PatMRNO'));
            var tranNo = ($.session.get('PatTRANNO'));

            $.ajax({
                type: "POST",
                url: 'SaveCopy',
                datatype: "json",
                data: { PrevTranNo: oldTranno, strMRNO: mrno, strTranNo: tranNo },
                success: function (result) {
                    if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        window.location.href = '../DoctorDesk/PatientEntry';
                        $.messager.alert('Information', 'Copied Successfully');
                    }

                    //GetAllCounts();
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
            });

        }

        function PatMedicationHistory(Type) {
            var tranNo = ($.session.get('PatTRANNO'));
            var mrno = ($.session.get('PatMRNO'));
            if (Type == "S" && ($("#txtFromDate").val() == "" || $("#txtToDate").val() == "")) {
                $('#txtFromDate').datepicker('setDate', 'today');
                $('#txtToDate').datepicker('setDate', 'today');
            }
            var FromDate = $("#txtFromDate").val();
            var ToDate = $("#txtToDate").val();
            var DCode = $("#cmbDoctList").val() != "" ? $("#cmbDoctList option:selected").text() : "";
            $("#tbldiv").empty();
            $.ajax({
                type: "POST",
                url: 'GetMedicationtHistory',
                datatype: "json",
                data: { strMrNo: mrno, FromDate: FromDate, ToDate: ToDate, DoctCode: DCode },
                success: function (result) {
                    if (result[0] != null && result[0].length > 0) {
                        for (var i = 0; i < result[0].length; i++) {
                            var $divPanel = $('<div>', { style: '', class: 'panel' });
                            var $divPanelHead = $('<div>', { style: 'font-size:13px;', class: 'panel-heading divHeads' });

                            var patCompleteYn = $.session.get('PatCompleted');// added by vijeta on 7/3/19
                            var flg = (tranNo == result[0][i].TRANNO.toString() || patCompleteYn != "N") ? false : true;
                            //*********************** 17-9-19 - for refill and copy button display******************************

                            var flagHead = 0;
                            var flagRoute = 0;
                            var flagDrugForm = 0;
                            var flagFromCims = 0;
                            var flagNotFromCims = 0;
                            //flg = true;
                            $.each(result[1], function (key, value) {
                                if (result[0][i].TRANNO.toString() == value.TRANNO) {
                                    if (value.DOSSAGE != "") {
                                        flagHead = 1;
                                        //return false;
                                    }
                                    if (value.ROUTE != "") {
                                        flagRoute = 1;
                                        // return false;
                                    }
                                    if (value.DRUGFORM != "") {
                                        flagDrugForm = 1;
                                        // return false;
                                    }
                                    if (value.CIMSMEDYN == "Y") {
                                        flagFromCims = 1;
                                        // return false;

                                    }
                                    if (value.CIMSMEDYN == "N") {
                                        flagNotFromCims = 1;
                                        // return false;
                                    }
                                }
                            });

                            //...........................

                            if ((('<%:Session["CIMYN"]%>').toString() == "Y")) {
                                if ((flagNotFromCims == 0) && flg && CheckPatSessionNotEmpty())
                                    flg = true;
                                else
                                    flg = false;


                            } else {

                                if ((flagFromCims == 0) && flg && CheckPatSessionNotEmpty())
                                    flg = true;
                                else
                                    flg = false;
                            }
                            //...........................................

                            //******************end*********************************

                            //if (CheckPatSessionNotEmpty() && flg)//
                            //    flg = true;
                            //else
                            //    flg = false;

                            var str = (flg) ? "<span><i class='fa fa-clone'  aria-hidden='true' style='font-weight:700;cursor:pointer' title='Copy' ></i></span>" : "";

                            var strTable = "<table style='width:100%'><tr><td id='" + result[0][i].TRANNO.toString() + "' class='copyHisCls'>" + str + "</td>" +
                           "<td class='ComplStatus' id='" + result[0][i].TRANNO.toString() + "'>" +
                          (result[0][i].COMPLETEDYN.toString() === "Y" ? "<span><i class='fa fa-check fa-2x' aria-hidden='true' style='font-size: 1.0em; color: #b9ffb1; cursor:pointer' title='Completed Status'></i></span>" : "") +
                           "</td>" +
                             "<td class='ExColicon'>Consultation No : " + result[0][i].TRANNO.toString() +
                            "<td class='sendEmail' id='" + result[0][i].TRANNO.toString() + "', data-completedyn='" + result[0][i].COMPLETEDYN.toString() + "'> <span><i class='fa fa-envelope-o' aria-hidden='true'  style='font-size: 1.5em;font-weight:700;cursor:pointer' title='Send Email' ></i></span> </td>" +
                            "</td><td class='ExColicon'> Date :" + result[0][i].TRANDATE + "</td>" +
                            "<td class='ExColicon'>Time : " + result[0][i].TRANTIME + "</td><td class='ExColicon'><span class='fa fa-caret-down spanCls'></span></td></tr></table>";
                            $divPanelHead.append(strTable);

                            //
                            var $divPanelBody = $('<div>', { style: 'font-size:13px;display:block', class: 'panel-body divBody' });//
                            // start
                            var patSex = "", agesx = "";
                            if (result[0][i].PATSEX.toString() == "M") {
                                patSex = "Male"
                            } else if (result[0][i].PATSEX.toString() == "F") {
                                patSex = "Female";
                            }
                            var PatAge = '';
                            if (result[0][i].PATAGE.toString() != "" && result[0][i].PATAGE.toString() != null) {
                                PatAge = result[0][i].PATAGE.toString().replace(/\./g, ':');//
                                PatAge = PatAge.split(":");

                                if (PatAge[1] != "") {
                                    PatAge = PatAge[0].replace(/^0+/, '') + " years," + PatAge[1].replace(/^0+/, '') + " months";
                                } else
                                    PatAge = PatAge[0].replace(/^0+/, '') + " years";
                            }
                            if (result[0][i].PATSEX.toString() == "" && result[0][i].PATAGE.toString() == "")
                                agesx = "";
                            else if (result[0][i].PATSEX.toString() == "" || result[0][i].PATAGE.toString() == "") {

                                agesx = "&nbsp(&nbsp;" + PatAge + patSex + "&nbsp;)&nbsp;";
                            } else
                                agesx = "&nbsp(&nbsp;" + PatAge + "|" + patSex + "&nbsp;)&nbsp;";

                            var strTable1 = "<div class='col-md-12 col-sm-12' style='background: #e6e9eb;margin-top: -10px;border: 1px solid #c8c4c4;font-weight:bold'>"
                                + result[0][i].PATNAME.toString() + agesx + "</div><br>";
                            $divPanelBody.append(strTable1);
                            //end
                            //Complaints N Vitals
                            var $divComplaintsNVitals = $('<div>', { class: 'row nopadding' });
                            //Complaints
                            //var strComplaintLst = "<div class='col-md-6'>";

                            if (result[2].length > 0) {

                                // Array of trandates from result[2] i. e complaints
                                var TranDateArryFrmResultTwo = [];
                                //iterate through object keys
                                Object.keys(result[2]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[2][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultTwo.push(val);
                                });

                                //var res = TranDateArryFrmResultZero.filter(function (n) { return this.has(n) }, new Set(TranDateArryFrmResultTwo));
                                var rs = TranDateArryFrmResultTwo.includes(result[0][i].TRANNO);
                            }//

                            //free complaint vijeta 22nd march 19
                            if (result[10].length > 0) {
                                // Array of trandates from result[2] i. e complaints
                                var TranDateArryFrmResultTen = [];
                                //iterate through object keys
                                Object.keys(result[10]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[10][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultTen.push(val);
                                });
                                var rs1 = TranDateArryFrmResultTen.includes(result[0][i].TRANNO);
                            }//
                            if (result[4].length > 0 && ((result[2].length > 0 && rs) || (result[10].length > 0 && rs1)))
                                var strComplaintLst = "<div class='col-md-6 CheifCompDispYN' style='display:" + ($("#chkCheifComp").prop("checked") == true ? "block" : "none") + "'>";
                            else
                                var strComplaintLst = "<div class='col-md-12 CheifCompDispYN' style='display:" + ($("#chkCheifComp").prop("checked") == true ? "block" : "none") + "'>";

                            if ((result[2].length > 0 && rs) || (result[10].length > 0 && rs1)) {
                                strComplaintLst += "<label><u>Chief Complaints : </u></label>";//
                                strComplaintLst += "<ul class='liClass'>";
                            }
                            if (result[2].length > 0) {
                                if (rs) {

                                    for (var j = 0; j < result[2].length; j++) {
                                        if (result[0][i].TRANNO == result[2][j].TRANNO) {
                                            var dash = (result[2][j].REMARKS == "") ? "" : "-";
                                            var totalDurationString = Number(result[2][j].DURATION) > 0 ? " since " + result[2][j].DURATION + " " + result[2][j].DURTYPE : "";
                                            strComplaintLst += "<li>" + result[2][j].NAME + dash + result[2][j].REMARKS + totalDurationString + "</li>"
                                        }
                                    }
                                }
                            }
                            //var res = TranDateArryFrmResultZero.filter(function (n) { return this.has(n) }, new Set(TranDateArryFrmResultTwo));
                            if (result[10].length > 0) {
                                if (rs1) {
                                    for (var j = 0; j < result[10].length; j++) {
                                        if (result[0][i].TRANNO == result[10][j].TRANNO) {
                                            strComplaintLst += "<li>" + result[10][j].FREECOMPLAINT + "</li>"
                                        }
                                    }
                                }
                            }
                            if ((result[2].length > 0 && rs) || (result[10].length > 0 && rs1)) {
                                strComplaintLst += "</ul><br>";
                            }
                            strComplaintLst += "</div>";
                            $divComplaintsNVitals.append(strComplaintLst);

                            //Vitals
                            var strVitalsLst = '';
                            if (result[4].length > 0 && ((result[2].length > 0 && rs) || (result[10].length > 0 && rs1)))
                                strVitalsLst = "</div><div class='col-md-6 GenExamDispYN' style='display:" + ($("#chkGeneralExam").prop("checked") == true ? "block" : "none") + "'>";
                            else
                                strVitalsLst = "</div><div class='col-md-12 GenExamDispYN' style='display:" + ($("#chkGeneralExam").prop("checked") == true ? "block" : "none") + "'>";

                            //var strVitalsLst = "<div class='col-md-6'>";
                            if (result[4].length > 0) {

                                // Array of trandates from result[4] i. e Vitals
                                var TranDateArryFrmResultFour = [];
                                //iterate through object keys
                                Object.keys(result[4]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[4][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultFour.push(val);
                                });

                                var rs = TranDateArryFrmResultFour.includes(result[0][i].TRANNO);

                                if (rs) {
                                    //strDiagnoLst += "<div class='leftHead'>Diagnosis</div>";
                                    var flag = false;
                                    var strLiVitalsLst = "";
                                    for (var j = 0; j < result[4].length; j++) {
                                        if (result[0][i].TRANNO == result[4][j].TRANNO) {

                                            if (result[4][j].WEIGHT.toString() != "" && Number(result[4][j].WEIGHT) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>Weight :&emsp; " + result[4][j].WEIGHT + " Kg</li>";
                                            }

                                            if (result[4][j].HEIGHT.toString() != "" && Number(result[4][j].HEIGHT) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>Height:&emsp; " + result[4][j].HEIGHT + " cm</li>";
                                            }

                                            if (result[4][j].TEMP.toString() != "" && Number(result[4][j].TEMP) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>Temperature:&emsp; " + result[4][j].TEMP + " &#x2109;</li>";
                                            }

                                            if (result[4][j].PULSE.toString() != "" && Number(result[4][j].PULSE) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>Pulse:&emsp; " + result[4][j].PULSE + " bpm</li>";
                                            }

                                            if (result[4][j].RESP.toString() != "" && Number(result[4][j].RESP) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>Resp:&emsp; " + result[4][j].RESP + "</li>";
                                            }

                                            if (result[4][j].BP.toString() != "" && Number(result[4][j].BP) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>BP:&emsp; " + result[4][j].BP + " mmhg</li>";//
                                            }

                                            if (result[4][j].VOTHERS.toString() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>VOthers:&emsp; " + result[4][j].VOTHERS + "</li>";
                                            }

                                            if (result[4][j].SPO2.toString() != "" && Number(result[4][j].SPO2) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>SpO2:&emsp; " + result[4][j].SPO2 + "%</li>";//
                                            }

                                            //vijeta 17th may 2019
                                            if (result[4][j].BMI.trim() != "" && Number(result[4][j].BMI) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>BMI:&emsp; " + result[4][j].BMI + "kg/(m²)</li>";
                                            }

                                            if (result[4][j].HEADCIRCMF.trim() != "" && Number(result[4][j].HEADCIRCMF) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>Head Circumference:&emsp; " + result[4][j].SPO2 + "cm</li>";
                                            }

                                            if (result[4][j].PEFR.trim() != "" && Number(result[4][j].PEFR) != 0) {
                                                flag = true;
                                                strLiVitalsLst += "<li>PEFR:&emsp; " + result[4][j].PEFR + " lit/min</li>";
                                            }

                                            if (result[4][j].Technique.trim() != "" && result[4][j].Technique != "N") {
                                                flag = true;
                                                if (result[4][j].Technique == "G")
                                                    result[4][j].Technique = "Good";
                                                if (result[4][j].Technique == "A")
                                                    result[4][j].Technique = "Average";
                                                if (result[4][j].Technique == "L")
                                                    result[4][j].Technique = "Low";
                                                strLiVitalsLst += "<li>Technique:&emsp; " + result[4][j].Technique + "</li>";
                                            }
                                            if (result[4][j].Compliance.trim() != "" && result[4][j].Compliance != "N") {
                                                flag = true;
                                                if (result[4][j].Compliance == "G")
                                                    result[4][j].Compliance = "Good";
                                                if (result[4][j].Compliance == "A")
                                                    result[4][j].Compliance = "Average";
                                                if (result[4][j].Compliance == "L")
                                                    result[4][j].Compliance = "Low"
                                                strLiVitalsLst += "<li>Compliance:&emsp; " + result[4][j].Compliance + "</li>";
                                            }
                                            if (result[4][j].DIETYN.trim() != "" && result[4][j].DIETYN != "N") {
                                                flag = true;

                                                strLiVitalsLst += "<li>Diet:&emsp; Yes</li>";
                                            }
                                            if (result[4][j].REGMEDYN.trim() != "" && result[4][j].REGMEDYN != "N") {
                                                flag = true;

                                                strLiVitalsLst += "<li>Regular Medicine:&emsp; Yes</li>";
                                            }
                                            if (result[4][j].WALKYN.trim() != "" && result[4][j].WALKYN != "N") {
                                                flag = true;

                                                strLiVitalsLst += "<li>Walking:&emsp; Yes</li>";
                                            }
                                            if (result[4][j].PAINSCORE.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>Pain Score:&emsp; " + result[4][j].PAINSCORE + " </li>";
                                            }
                                            if (result[4][j].BSA.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>BSA:&emsp; " + result[4][j].BSA + " m²</li>";
                                            }
                                            if (result[4][j].RBS.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>RBS:&emsp; " + result[4][j].RBS + " mg/dl</li>";
                                            }
                                            if (result[4][j].KARNOFSKY.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>Karnofsky Score:&emsp; " + result[4][j].KARNOFSKY + " %</li>";
                                            }
                                            if (result[4][j].ECOG.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>ECOG Score:&emsp; " + result[4][j].ECOG + " </li>";
                                            }

                                            //Added by Murali on 25/04/2024
                                            //*******************************************
                                            if (result[4][j].IBW.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>IBW:&emsp; " + result[4][j].IBW + " </li>";
                                            }
                                            if (result[4][j].BWPERC.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>BW %:&emsp; " + result[4][j].BWPERC + " </li>";
                                            }
                                            if (result[4][j].WAISTCIRCUM.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>Waist Circumference:&emsp; " + result[4][j].WAISTCIRCUM + " cm</li>";
                                            }
                                            if (result[4][j].HIPCIRCUM.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>Hip Circumference:&emsp; " + result[4][j].HIPCIRCUM + " cm</li>";
                                            }
                                            if (result[4][j].WHR.trim() != "") {
                                                flag = true;
                                                strLiVitalsLst += "<li>WHR:&emsp; " + result[4][j].WHR + " </li>";
                                            }
                                            //*******************************************

                                        }
                                    }

                                    if (flag) {
                                        strVitalsLst += "<label><u>Vitals : </u></label>";//
                                        strVitalsLst += "<ul class='liClass'>";
                                        strVitalsLst += strLiVitalsLst;
                                        strVitalsLst += "</ul>";
                                    }
                                    //strVitalsLst += "</ul>";
                                }

                            }
                            strVitalsLst += "</div>";
                            $divComplaintsNVitals.append(strVitalsLst);

                            //hISTORY ADDED BY MEENAKSHI
                            var $divPastHist = $('<div>', { class: 'row nopadding HistoryDispYN', style: ("display:" + ($("#chkHistory").prop("checked") == true ? "block" : "none")) });
                            var strPasterHIst = "<div class='col-md-12 HistoryDispYN' >";
                            for (var j = 0; j < result[12].length; j++) {
                                if (result[0][i].TRANNO == result[12][j].TRANNO) {
                                    if (result[12][j]["PASTHIST"] != "") {
                                        strPasterHIst += "<label><u>History : </u></label>";

                                        strPasterHIst += "<p  id=H" + j + result[12][j].TRANNO + " onClick='selectText(this.id);'>" + result[12][j]["PASTHIST"].toString().replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p></ul>";
                                    }
                                }
                            }
                            strPasterHIst += "</div>";
                            $divPastHist.append(strPasterHIst);
                            //Past History 

                            // Diagnosis
                            var $divDiagno = $('<div>', { class: 'row nopadding DiagnosisDispYN', style: ("display:" + ($("#chkDiagnosis").prop("checked") == true ? "block" : "none")) });
                            var strProvDiagnos = "<div class='col-md-12 '>";
                            //medicineList += "<div class='leftHead'>Rx</div>";

                            for (var j = 0; j < result[8].length; j++) {
                                if (result[0][i].TRANNO == result[8][j].TRANNO) {
                                    if (result[8][j]["PROVDIAG"] != "") {
                                        strProvDiagnos += "<label><u>Provisional Diagnosis : </u></label>";
                                        strProvDiagnos += "<ul class='liClass'>";
                                        strProvDiagnos += "<li>" + result[8][j]["PROVDIAG"] + "</li></ul>";
                                    }
                                }
                                if (result[0][i].TRANNO == result[8][j].TRANNO) {
                                    if (result[8][j]["SITE"] != "") {
                                        strProvDiagnos += "<label><u>Site :</u></label>";
                                        //strProvDiagnos += "<label><u>Composit Staging :</u></label>";
                                        strProvDiagnos += "<ul class='liClass'>";
                                        strProvDiagnos += "<li>" + result[8][j]["SITE"] + "</li></ul>";
                                    }
                                }
                                if (result[0][i].TRANNO == result[8][j].TRANNO) {
                                    if (result[8][j]["SUBSITE"] != "") {
                                        strProvDiagnos += "<label><u>Sub Site :</u></label>";
                                        //strProvDiagnos += "<label><u>Composit Staging :</u></label>";
                                        strProvDiagnos += "<ul class='liClass'>";
                                        strProvDiagnos += "<li>" + result[8][j]["SUBSITE"] + "</li></ul>";
                                    }
                                }
                                if (result[0][i].TRANNO == result[8][j].TRANNO) {
                                    if (result[8][j]["TSTAGE"] != "") {
                                        strProvDiagnos += "<label><u>TNM :</u></label>";
                                        //strProvDiagnos += "<label><u>TNM Staging :</u></label>";
                                        strProvDiagnos += "<ul class='liClass'>";
                                        strProvDiagnos += "<li> T<sub>" + result[8][j]["TSTAGE"] + "</sub>  N<sub>" + result[8][j]["NSTAGE"] + "</sub>  M<sub>" + result[8][j]["MSTAGE"] + "</sub></li></ul>";
                                    }
                                }
                                if (result[0][i].TRANNO == result[8][j].TRANNO) {
                                    if (result[8][j]["COMPOSTAG"] != "") {
                                        strProvDiagnos += "<label><u>Stage :</u></label>";
                                        //strProvDiagnos += "<label><u>Composit Staging :</u></label>";
                                        strProvDiagnos += "<ul class='liClass'>";
                                        strProvDiagnos += "<li>" + result[8][j]["COMPOSTAG"] + "</li></ul>";
                                    }
                                }

                                strProvDiagnos += "</ul></div>";
                            }
                            $divDiagno.append(strProvDiagnos);


                            if (result[3].length > 0) {

                                // Array of trandates from result[3] i. e Diagnosis
                                var TranDateArryFrmResultTHree = [];
                                //iterate through object keys
                                Object.keys(result[3]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[3][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultTHree.push(val);
                                });

                                var rs = TranDateArryFrmResultTHree.includes(result[0][i].TRANNO);

                                if (rs) {
                                    var strDiagnoLst = "<div class='col-md-12'>"
                                    //medicineList += "<div class='leftHead'>Rx</div>";
                                    strDiagnoLst += "<label><u>Diagnosis : </u></label>";
                                    strDiagnoLst += "<ul class='liClass'>";
                                    for (var j = 0; j < result[3].length; j++) {
                                        if (result[0][i].TRANNO == result[3][j].TRANNO) {
                                            var dash = (result[3][j].REMARKS == "") ? "" : "-";
                                            strDiagnoLst += "<li>" + result[3][j].NAME + "&emsp; " + dash + "&emsp; " + result[3][j].REMARKS + "</li>";
                                        }
                                    }
                                    strDiagnoLst += "</ul></div>";

                                    $divDiagno.append(strDiagnoLst);
                                }
                            }

                            if (result[9].length > 0) {
                                // Array of trandates from result[3] i. e Diagnosis
                                var TranDateArryFrmResultTHree = [];
                                //iterate through object keys
                                Object.keys(result[9]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[9][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultTHree.push(val);
                                });

                                var rs = TranDateArryFrmResultTHree.includes(result[0][i].TRANNO);

                                if (rs) {
                                    var strDiagnoLst = "<div class='col-md-12'>"
                                    //medicineList += "<div class='leftHead'>Rx</div>";
                                    strDiagnoLst += "<label><u>ICD Diagnosis : </u></label>";
                                    strDiagnoLst += "<ul class='liClass'>";
                                    for (var j = 0; j < result[9].length; j++) {
                                        if (result[0][i].TRANNO == result[9][j].TRANNO) {
                                            var dash = (result[9][j].REMARKS == "") ? "" : "-";
                                            strDiagnoLst += "<li>" + result[9][j].ICDCODE + "&emsp; " + result[9][j].NAME + "</li>";
                                        }
                                    }
                                    strDiagnoLst += "</ul></div>";

                                    $divDiagno.append(strDiagnoLst);
                                }

                            }

                            if (result[13].length > 0) {
                                var TranDateArryFrmResultTHree = [];
                                Object.keys(result[13]).forEach(function (key) {
                                    var val = result[13][key]["TRANNO"];
                                    TranDateArryFrmResultTHree.push(val);
                                });
                                var rs = TranDateArryFrmResultTHree.includes(result[0][i].TRANNO);
                                if (rs) {
                                    var strDiagnoLst = "<div class='col-md-12'>"
                                    strDiagnoLst += "<label><u>ICD-O Diagnosis : </u></label>";
                                    strDiagnoLst += "<ul class='liClass'>";
                                    for (var j = 0; j < result[13].length; j++) {
                                        if (result[0][i].TRANNO == result[13][j].TRANNO) {
                                            var dash = (result[13][j].REMARKS == "") ? "" : "-";
                                            strDiagnoLst += "<li>" + result[13][j].ICDOCODE + "&emsp; " + result[13][j].NAME + "</li>";
                                        }
                                    }
                                    strDiagnoLst += "</ul></div>";
                                    $divDiagno.append(strDiagnoLst);
                                }
                            }

                            // Examination
                            var $divExamination = $('<div>', { class: 'row nopadding OnExamDispYN', style: ("display:" + ($("#chkOnExam").prop("checked") == true ? "block" : "none")) });
                            if (result[5].length > 0) {

                                // Array of trandates from result[5] i. e Examination
                                var TranDateArryFrmResultFive = [];
                                //iterate through object keys
                                Object.keys(result[5]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[5][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultFive.push(val);
                                });

                                var rs = TranDateArryFrmResultFive.includes(result[0][i].TRANNO);

                                if (rs) {

                                    var strExmLst = "<div class='col-md-12'>";

                                    for (var j = 0; j < result[5].length; j++) {
                                        if (result[0][i].TRANNO == result[5][j].TRANNO && result[5][j].EXAM != "") {
                                            strExmLst += "<label><u>Physical Examination : </u></label>";//
                                            var id = "P" + j + result[5][j].TRANNO;
                                            strExmLst += "<p id='" + id + "' onClick='selectText(this.id);' style='font-size:13px;font-weight:500'>&emsp;" + result[5][j].EXAM.toString().replace(/ /g, '&nbsp;').replace(/\n/g, '<br />') + "</p>";
                                        }
                                        strExmLst += "<table>";

                                        if (result[0][i].TRANNO == result[5][j].TRANNO) {

                                            datatosend = {
                                                MrNo: mrno,
                                                TranNo: result[0][i].TRANNO
                                            }
                                            $.ajax({
                                                type: 'POST',
                                                url: 'RetriveExamImages',
                                                data: datatosend,
                                                async: false,
                                                success: function (ImageData) {
                                                    var imageStr = ''
                                                    $.each(ImageData, function (index, element) {
                                                        strExmLst += "<tr>";
                                                        //var strfilename = element.replace(/^.*[\\\/]/, '');

                                                        // var strUrl = element + '/PrescriptionImages/' + strmrno + '/' + strtranNo + '/' + strfilename;

                                                        var fileNo = element.split("|");

                                                        var strUrl = "data:[<media type>];charset=utf-8;base64," + fileNo[1];
                                                        imageStr += '<div class="col-md-6" style="background: #f5f5f5;">';
                                                        imageStr += '<div class="thumbnail" >';  //onclick="OpenImage(this,event)"
                                                        imageStr += '<img id=' + fileNo[0] + ' src="' + strUrl + '" alt="Lights" ></div></div>';  //style="width:100px;height:100px"

                                                    })
                                                    strExmLst += imageStr;
                                                    strExmLst += "</tr>";
                                                    strExmLst += "</table>";
                                                    strExmLst += "</div>";
                                                },
                                                complete: function () {
                                                    HoldOn.close();
                                                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                    HoldOn.close();
                                                }
                                            });
                                        }
                                    }
                                }
                                $divExamination.append(strExmLst);
                            }

                            // Advices 
                            var $divAdvices = $('<div>', { class: 'row nopadding' });
                            var medicineList = "";
                            if (result[1].length > 0) {

                                // Array of trandates from result[1] i. e Advices
                                var TranDateArryFrmResultOne = [];
                                //iterate through object keys
                                Object.keys(result[1]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[1][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultOne.push(val);
                                });

                                var rs = TranDateArryFrmResultOne.includes(result[0][i].TRANNO);
                                if (rs) {
                                    var flag = 0;
                                    var flagRoute = 0;
                                    var flagDrugForm = 0;
                                    var flagFromCims = 0;
                                    var flagNotFromCims = 0;
                                    var FlagQty = 0; //Meenakshi
                                    $.each(result[1], function (key, value) {
                                        if (result[0][i].TRANNO == result[1][key]["TRANNO"]) {
                                            if (value.DOSSAGE != "") {
                                                flag = 1;
                                                //return false;
                                            }
                                            if (value.QTY != "") {
                                                FlagQty = 1;
                                                //return false;
                                            }
                                            if (value.ROUTE != "") {//
                                                flagRoute = 1;
                                                // return false;
                                            }
                                            if (value.DRUGFORM != "") {//
                                                flagDrugForm = 1;
                                                // return false;
                                            }
                                            if (value.CIMSMEDYN == "Y") {
                                                flagFromCims = 1;
                                                // return false;

                                            }//
                                            if (value.CIMSMEDYN == "N") {
                                                flagNotFromCims = 1;
                                                // return false;
                                            }//

                                        }
                                    });

                                    if (('<%:Session["CIMYN"]%>').toString() == "Y") {
                                        if ((flagFromCims == 1) && flg)
                                            flg = true;
                                        else
                                            flg = false;
                                    } else {
                                        if ((flagNotFromCims == 1) && flg)
                                            flg = true;
                                        else
                                            flg = false;
                                    }
                                    //..................end.........................
                                    //$.each(result[1], function (key, value) {

                                    //});
                                    //07-09-19
                                    var concateComma = '';//3/28/19

                                    medicineList = "<div class='col-md-12 RxDispYN' style='display:" + ($("#chkRx").prop("checked") == true ? "block" : "none") + "'>";
                                    //medicineList += "<div class='leftHead'>Rx</div>";
                                    medicineList += "<label><u>Rx : </u></label>";
                                    if (flg)
                                        medicineList += "<button style='float:right;background-color: #f3d0b7;' onclick='RefillFuncRx(\"" + result[0][i].TRANNO + "\",\"" + result[0][i].TRANDATE + '-' + result[0][i].TRANTIME + "\");'><b>Refill</b></button>";//4/6/19

                                    medicineList += "<div class='table-responsive' style='display:block;overflow:auto;max-height:248px;'><table style='width:100%;border-collapse:collapse' border='1' class='tblRx'>";
                                    // 27-04-20202 div added
                                    var HeadRow = "<tr  style='background: #fdd283;color: #4e4e4e;'>";
                                    var thHead = ""
                                    thHead += "<th>Sr.No.</th>";
                                    if (flagDrugForm == 1) {
                                        thHead += "<th style=''>Form</th><th>" + (GeneralWiseYN == "Y" ? "Generic" : "Medicine") + "</th><th>Date</th><th>Frequency</th>";// 27-04-2020
                                    }
                                    else
                                        thHead += "<th>" + (GeneralWiseYN == "Y" ? "Generic" : "Medicine") + "</th><th>Date</th><th>Frequency</th>";


                                    if (flagHead == 1) {
                                        thHead = thHead + "<th>Dose</th>";
                                    }

                                    if (FlagQty == 1) {
                                        thHead = thHead + "<th>Qty</th><th>Duration</th>";
                                    } else {
                                        thHead = thHead + "<th>Duration</th>";
                                    }

                                    if (flagRoute == 1) {
                                        thHead = thHead + "<th>Route</th><th>Remark</th></tr>";
                                    }
                                    else {
                                        thHead = thHead + "<th>Remark</th></tr>";
                                    }

                                    HeadRow = HeadRow + thHead;
                                    medicineList += HeadRow;

                                    var serialNumber = 1; //added by ashvini to reset the serial no on 15/10/2024
                                    for (var j = 0; j < result[1].length; j++) {
                                        if (result[0][i].TRANNO == result[1][j].TRANNO) {

                                            if (result[1][j].ABFOOD != "" && result[1][j].Remarks != "") {
                                                concateComma = ", "
                                            }
                                            if (result[0][i].TRANDATE == result[1][j].TRANDATE) {
                                                var days = (result[1][j].DAYS.substr(0, 1) != "0" ? result[1][j].DAYS : "-");
                                                var Newrow = "<tr>";
                                                var NewColumns = "";
                                                //Meenakshi Pass sr number column
                                                NewColumns += "<td style='width:5%;'>" + serialNumber + "</td>";  //added by ashvini to reset the serial no on 15/10/2024
                                                var DrugNm = GeneralWiseYN == "Y" ? result[1][j].DRUGNM : result[1][j].DRUGNM + "(" + result[1][j].GENERICNAM + ")";
                                                if (flagDrugForm == 1)
                                                    NewColumns += "<td>" + result[1][j].DRUGFORM + "." + "</td><td style='width:25%;'>" + DrugNm + "</td><td style='width:7%;'>" + result[1][j].MEDSTARTDATE + "</td><td style='width:10%;'>" + (result[1][j].INTAKE).replace("0.5", "1,2") + "</td>";
                                                else
                                                    NewColumns += "<td style='width:30%;'>" + DrugNm + "</td><td style='width:7%;'>" + result[1][j].MEDSTARTDATE + "</td><td style='width:10%;'>" + (result[1][j].INTAKE).replace("0.5", "1,2") + "</td>";

                                                if (flagHead == 1) {
                                                    NewColumns += "<td style='width:10%;'>" + result[1][j].DOSSAGE + "</td>";
                                                }

                                                if (FlagQty == 1) {//Meenakshi
                                                    NewColumns += "<td style='width:10%;'>" + result[1][j].QTY + "</td><td style='width:10%;'>" + days + "</td>";
                                                }
                                                else {
                                                    NewColumns += "<td style='width:10%;'>" + days + "</td>";
                                                }

                                                if (flagRoute == 1) {
                                                    NewColumns += "<td style='width:10%;'>" + result[1][j].ROUTE + "</td><td style='width:28%'>" + result[1][j].ABFOOD + concateComma + result[1][j].Remarks + "</td></tr>"  //kavita 14-aug-2016
                                                }
                                                else
                                                    NewColumns += "<td style='width:30%'>" + result[1][j].ABFOOD + concateComma + result[1][j].Remarks + "</td></tr>"  //kavita 14-aug-2016

                                                Newrow = Newrow + NewColumns;
                                                medicineList += Newrow;

                                                // Increment the serial number for the next entry
                                                serialNumber++;  //added by ashvini to reset the serial no on 15/10/2024
                                            }
                                        }
                                    }
                                }
                                medicineList += "</table></div></div></div>";
                                $divAdvices.append(medicineList);
                                medicineList = "";
                            }

                            //Investigations                       
                            var $divInvestpatAdv = $('<div>', { class: 'row nopadding' });
                            //Investigations

                            var rs = "", rs1 = "";
                            if (result[6].length > 0) {

                                // Array of trandates from result[2] i. e complaints
                                var TranDateArryFrmResultSix = [];
                                //iterate through object keys
                                Object.keys(result[6]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[6][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultSix.push(val);
                                });

                                rs = TranDateArryFrmResultSix.includes(result[0][i].TRANNO);
                            }

                            if (result[11].length > 0) {
                                // Array of trandates from result[2] i. e complaints
                                var TranDateArryFrmResultEleven = [];
                                //iterate through object keys
                                Object.keys(result[11]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[11][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultEleven.push(val);
                                });


                                //var res = TranDateArryFrmResultZero.filter(function (n) { return this.has(n) }, new Set(TranDateArryFrmResultTwo));
                                rs1 = TranDateArryFrmResultEleven.includes(result[0][i].TRANNO);


                            }
                            var strInvestigationLst = '';
                            if (((result[6].length > 0 && rs) || (result[11].length > 0 && rs1)) && result[7].length > 0) {

                                strInvestigationLst = "<div class='col-md-6 AdvInvstDispYN' style='display:" + ($("#chkAdvInvst").prop("checked") == true ? "block" : "none") + "'>";

                            } else {
                                strInvestigationLst = "<div class='col-md-12 AdvInvstDispYN' style='display:" + ($("#chkAdvInvst").prop("checked") == true ? "block" : "none") + "'>";

                            }//
                            if ((result[6].length > 0 && rs) || (result[11].length > 0 && rs1)) {
                                strInvestigationLst += "<label><u>Advice for Investigations : </u></label>";//
                                strInvestigationLst += "<ul class='liClass'>";
                            }
                            if (result[6].length > 0) {
                                if (rs) {

                                    for (var j = 0; j < result[6].length; j++) {
                                        if (result[0][i].TRANNO == result[6][j].TRANNO) {
                                            var TotalDuration = "";
                                            var dur = "" + result[6][j].DURATION;
                                            var durtype = result[6][j].DURTYPE;
                                            if (dur.length > 0) {
                                                if (Number(dur) > 0) {
                                                    TotalDuration = "  perform after" + dur + " " + DurationTypeSelect(durtype, dur);
                                                }
                                            }
                                            //var dash = (result[6][j].REMARKS == "") ? "" : "-";
                                            strInvestigationLst += "<li>" + result[6][j].TESTNAME + " " + result[6][j].REMARK + " " + TotalDuration + "</li>"
                                        }
                                    }

                                }

                            }
                            //free investigation vijeta 22nd march 2019
                            if (result[11].length > 0) {

                                if (rs1) {

                                    for (var j = 0; j < result[11].length; j++) {
                                        if (result[0][i].TRANNO == result[11][j].TRANNO) {
                                            strInvestigationLst += "<li>" + result[11][j].FREEINVESTIGATION + "</li>"
                                        }
                                    }

                                }
                            }
                            if ((result[6].length > 0 && rs) || (result[11].length > 0 && rs1)) {
                                strInvestigationLst += "</ul>";
                            }
                            $divInvestpatAdv.append(strInvestigationLst);//

                            var strPatAdviceLst = '';
                            if (((result[6].length > 0 && rs) || (result[11].length > 0 && rs1)) && result[7].length > 0) {
                                strPatAdviceLst += "</div><div class='col-md-6 AdviceDispYN' style='display:" + ($("#chkRAdvice").prop("checked") == true ? "block" : "none") + "'>";
                            }//
                            else {
                                strPatAdviceLst += "</div><div class='col-md-12 AdviceDispYN' style='display:" + ($("#chkRAdvice").prop("checked") == true ? "block" : "none") + "'>";
                            }


                            //Patient Advices
                            if (result[14].length > 0 || result[7].length > 0) {
                                var TranDateArryFrmResultSvn = [];
                                var TranDateArryFrmResultSvnFree = [];
                                Object.keys(result[7]).forEach(function (key) {
                                    var val = result[7][key]["TRANNO"];
                                    TranDateArryFrmResultSvn.push(val);
                                });
                                Object.keys(result[14]).forEach(function (key) {
                                    var val = result[14][key]["TRANNO"];
                                    TranDateArryFrmResultSvnFree.push(val);
                                });
                                var rs = TranDateArryFrmResultSvn.includes(result[0][i].TRANNO);
                                var rsFree = TranDateArryFrmResultSvnFree.includes(result[0][i].TRANNO);
                                if (rs || rsFree) {
                                    strPatAdviceLst += "<label><u>Other Advices : </u></label>";
                                    strPatAdviceLst += "<ul class='liClass'>";
                                    if (rsFree) {
                                        for (var j = 0; j < result[14].length; j++) {
                                            if (result[0][i].TRANNO == result[14][j].TRANNO) {
                                                strPatAdviceLst += "<li>" + result[14][j].FREEADVICE + "</li>";
                                            }
                                        }
                                    }
                                    if (rs) {
                                        for (var j = 0; j < result[7].length; j++) {
                                            if (result[0][i].TRANNO == result[7][j].TRANNO) {
                                                strPatAdviceLst += "<li>" + result[7][j].NAME + "</li>";
                                            }
                                        }
                                    }
                                    strPatAdviceLst += "</ul>";
                                }
                            }
                            strPatAdviceLst += "</div>";
                            $divInvestpatAdv.append(strPatAdviceLst);//

                            //Follow up details
                            var $divFollowUps = $('<div>', { class: 'row nopadding' });

                            if (result[8].length > 0) {

                                // Array of trandates from result[8] i. e Follow up details
                                var TranDateArryFrmResultEight = [];
                                //iterate through object keys
                                Object.keys(result[8]).forEach(function (key) {
                                    //get the value of name
                                    var val = result[8][key]["TRANNO"];
                                    //push the name string in the array
                                    TranDateArryFrmResultEight.push(val);
                                });


                                var rs = TranDateArryFrmResultEight.includes(result[0][i].TRANNO);

                                if (rs) {

                                    for (var j = 0; j < result[8].length; j++) {
                                        //Changes By Abhishesh || 20260820
                                        //surgery advice
                                        if (result[0][i].TRANNO == result[8][j].TRANNO && result[8][j]["SURGNMADVICE"] != "") {
                                            // Surgery Adviced Date - only show if not empty
                                            if (result[8][j]["SURGADVDATE"] != "") {
                                                var surgAdviceDate = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                                surgAdviceDate += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Adviced Date</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + result[8][j]["SURGADVDATE"] + "</p></td></tr></table>"
                                                surgAdviceDate += "</div>";
                                                $divFollowUps.append(surgAdviceDate);
                                            }
                                            // Surgery Adviced - names only, each on its own line
                                            var surgNamesOnly = result[8][j]["SURGNMADVICE"].split(',').join('<br>');
                                            var surgAdvice = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            surgAdvice += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Adviced</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + surgNamesOnly + "</p></td></tr></table>"
                                            surgAdvice += "</div>";
                                            $divFollowUps.append(surgAdvice);
                                            // Surgery Description (free text) - separate label, only if not empty
                                            if (result[8][j]["SURGADVICEOTHER"] != "") {
                                                var surgDesc = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                                surgDesc += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Surgery Description</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + result[8][j]["SURGADVICEOTHER"] + "</p></td></tr></table>"
                                                surgDesc += "</div>";
                                                $divFollowUps.append(surgDesc);
                                            }
                                            // PAC Advice Date - only show if not empty
                                            if (result[8][j]["PACADVDATE"] != "") {
                                                var PACAdviceDate = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                                PACAdviceDate += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>PAC Advice Date</u><span style='float:right'> :&emsp;</span></labe></td><td style='width:76%'  class='liClass'><p>" + result[8][j]["PACADVDATE"] + "</p></td></tr></table>"
                                                PACAdviceDate += "</div>";
                                                $divFollowUps.append(PACAdviceDate);
                                            }
                                        }
                                    //end

                                        //Refferred doct
                                        if (result[0][i].TRANNO == result[8][j].TRANNO && result[8][j]["DOCTNAME"] != "") {

                                            var array = result[8][j]["DOCTNAME"].split(',');

                                            var ReferredDoctLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            ReferredDoctLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Cross Reference to Other Oncologist</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' class='liClass' >";
                                            $.each(array, function (index, val) {
                                                if (val != "") {
                                                    ReferredDoctLst += "&#9679; Dr. " + val + "&nbsp;&nbsp;&nbsp;&nbsp;";
                                                }

                                            });
                                            //ReferredDoctLst += " </label>";
                                            ReferredDoctLst += "</td></tr></table></div>";

                                            $divFollowUps.append(ReferredDoctLst);
                                        }//

                                        //Refferred specialisation
                                        if (result[0][i].TRANNO == result[8][j].TRANNO && result[8][j]["REFSPECIALIST"] != "") {
                                            var array = result[8][j]["REFSPECIALIST"].split(',');


                                            var ReferredSpcLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            ReferredSpcLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Refer to Specialist</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' class='liClass'>";
                                            ReferredSpcLst += "<p id='refSpeciality'>"
                                            $.each(array, function (index, val) {
                                                if (val != "") {
                                                    ReferredSpcLst += "&#9679; " + val + "&nbsp;&nbsp;";
                                                }
                                            });
                                            ReferredSpcLst += "</p>"
                                            ReferredSpcLst += "</td></tr></table>";
                                            ReferredSpcLst += "</div>";

                                            $divFollowUps.append(ReferredSpcLst);
                                        }//


                                        //plan Of treatment  // added by meenakshi 1st may
                                        if (result[0][i].TRANNO == result[8][j].TRANNO && result[8][j]["PLANOFTREAT"] != "") {

                                            var ReferredSpcLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            ReferredSpcLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Plan of Treatment</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' onClick='selectText(this.id);' id='planOfTreat" + j + "' class='liClass'>";

                                            ReferredSpcLst += result[8][j]["PLANOFTREAT"] + "&nbsp;&nbsp;";

                                            ReferredSpcLst += "</td></tr></table>";
                                            ReferredSpcLst += "</div>";

                                            $divFollowUps.append(ReferredSpcLst);
                                        }

                                        //Prescription Remark
                                        if (result[0][i].TRANNO == result[8][j].TRANNO && result[8][j]["PRESCREMARK"] != "") {
                                            var array = result[8][j]["PRESCREMARK"].split(',');

                                            var ReferredSpcLst = "<div class='col-md-12' style='white-space:pre-wrap;'>";
                                            ReferredSpcLst += "<table style='width:100%'><tr><td style='width:24%;vertical-align: top;padding-top: 1px;'><label style='width: 100%;'><u>Remark / Notes</u><span style='float:right'> :&emsp;</span> </label></td><td style='width:76%' onClick='selectText(this.id);' id='remarknote" + j + "' class='liClass'>";
                                            $.each(array, function (index, val) {
                                                if (val != "") {
                                                    ReferredSpcLst += val + "&nbsp;&nbsp;";
                                                }
                                            });

                                            ReferredSpcLst += "</td></tr></table>";
                                            ReferredSpcLst += "</div>";

                                            $divFollowUps.append(ReferredSpcLst);
                                        }//
                                        //Follow up date
                                        if (result[0][i].TRANNO == result[8][j].TRANNO && result[8][j]["FOLLOWUPDT"] != "") {
                                            $divFollowUps.append("</br>");
                                            var ReferredSpcLst = "<div class='col-md-12' >";
                                            if (result[8][j]["FOLLOWUPDT"] == "SOS") {
                                                ReferredSpcLst += "<label class='liClass'>Follow up : " + result[8][j]["FOLLOWUPDT"] + " if any complaints</label>";      //vishal sos
                                            }
                                            else {
                                                if (result[8][j]["APPMNTDT"] == "" && result[0][i].TRANNO == result[8][j].TRANNO) {
                                                    var TranDate = result[0][i].TRANDATE;
                                                    var dayNum = (result[8][j]["FOLLOWUPDT"]).replace(/[^0-9]+/ig, "");
                                                    var FollowUp = (result[8][j]["FOLLOWUPDT"]).split(dayNum)[1];
                                                    var DayNum = result[8][j]["FOLLOWUPDT"].toLowerCase().replace(/s$/, '');
                                                    var CalDate = CalculateAppointDate(TranDate, dayNum, FollowUp);
                                                    ReferredSpcLst += "<label class='liClass'>Follow up on " + CalDate + " </label>";
                                                }
                                                else {
                                                    ReferredSpcLst += "<label class='liClass'>Follow up after " + result[8][j]["FOLLOWUPDT"] + " </label>";//
                                                }
                                            }
                                            ReferredSpcLst += "</div>";
                                            $divFollowUps.append(ReferredSpcLst);
                                        }

                                        if (result[8][j]["APPMNTDT"] != "" && result[0][i].TRANNO == result[8][j].TRANNO) {
                                            ReferredSpcLst = "<div class='col-md-12'>";
                                            ReferredSpcLst += "<label class='liClass'>Your Appointment is booked on " + result[8][j]["APPMNTDT"] + " at " + result[8][j]["APPMNTTM"] + " </label>";//
                                            ReferredSpcLst += "</div>";
                                            $divFollowUps.append(ReferredSpcLst);
                                        }

                                        if (result[0][i].TRANNO == result[8][j].TRANNO && result[8][j]["ADMNADVYN"] == "Y") {
                                            $divFollowUps.append("</br>");
                                            var AdmAdv = "<div class='col-md-12' ><label class='liClass'>" + (("" + result[8][j]["PROPADMNDT"]).trim() != "" ? ("Admission Adviced on " + ("" + result[8][j]["PROPADMNDT"]).trim()) : "Admission Adviced") + ".</label></div>";
                                            $divFollowUps.append(AdmAdv);
                                        }

                                    }

                                }
                            }


                            //Doct Name at right side
                            var $divDoctName = $('<div>', { class: 'row nopadding' });
                            if (result[0][i].DOCTNAME != "") {
                                //var strDoctName = "<div class='col-md-12' style='background-color:aliceblue;'><label style='text-align:right;float:right;font-size:13px;'>Dr. " + result[0][i].DOCTNAME + "</label></div>";
                                var strDoctName = "<div class='col-md-12' style='background-color:aliceblue;display: flex;flex-direction: column;'><label style='text-align:right;float:right;font-size:13px;'>Dr. " + result[0][i].DOCTNAME + "</label><label style='text-align:right;float:right;font-size:12px;'>" + result[0][i].DEPTNAME + "</label></div>";
                                $divDoctName.append(strDoctName);
                            }


                            $divPanelBody.append($divComplaintsNVitals);// append complaint n vitals div to panel body
                            $divPanelBody.append($divPastHist);
                            // $divPanelBody.append($divFreeCmplnt);// append free complaint div to panel body  
                            $divPanelBody.append($divDiagno);// append Diagno  div to panel body   
                            $divPanelBody.append($divExamination);// append Examination  div to panel body 
                            //$divPanelBody.append($divExaminationImages);// append Examination  div to panel body 
                            $divPanelBody.append($divAdvices);//append Rx div to panel body
                            $divPanelBody.append($divInvestpatAdv);//append investigations  div to panel body
                            // $divPanelBody.append($divPatAdvice);//append Pat advices  div to panel body  commntd
                            $divPanelBody.append($divFollowUps);//append follow up div to panel body
                            $divPanelBody.append($divDoctName);//append doctName div to panel body
                            //-------------------------



                            //if (result[1].length > 0)
                            //{
                            //    var strList = "<ul>";
                            //    for(var j=0;j<result[1].length;j++)
                            //    {

                            //        if(result[0][i].TRANDATE==result[1][j].TRANDATE)
                            //        {
                            //            strList += "<li>" + result[1][j].DRUGNM + "&emsp; " + result[1][j].INTAKE + "&emsp; " + result[1][j].ABFOOD + "";

                            //            if (result[1][j].Remarks != "")
                            //                strList += "<p>(" + result[1][j].Remarks + ")</p>";



                            //            strList +=  "</li>";

                            //        }


                            //    }
                            //    strList += "</ul>";

                            //    //added on 5th may 2018
                            //    if (result[0][i].DOCTNAME != "") {

                            //        //if (result[1][j].Remarks == "")
                            //        //    strList += "<br>";

                            //        strList += "<p style='float:right'>" + "- Dr " + result[0][i].DOCTNAME + "</p>";
                            //    }
                            //    //-----------------------------------------------

                            //    $divPanelBody.append(strList);
                            //}

                            $divPanel.append($divPanelHead);
                            $divPanel.append($divPanelBody);


                            $("#tbldiv").append($divPanel)
                        }
                    }
                    else {

                        document.getElementById("tbldiv").innerHTML = "<div class='panel'><div class='panel-body divBody' style='font-size:13px;'>No Medication History Found</div></div>";

                    }

                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
            });


        }

        function DurationTypeSelect(type, duration) {

            strDay = "Day";
            puralString = "";
            if (Number(duration) > 1) {
                puralString = "s"
            }

            switch (type) {

                case "D":
                    strDay = "Day" + puralString
                    break;
                case "W":
                    strDay = "Week" + puralString;
                    break;
                case "M":
                    strDay = "Month" + puralString
                    break;
                case "Y":
                    strDay = "Year" + puralString
                    break;
                default:
                    strDay = "Day" + puralString
                    break;
            }

            return strDay;

        }
        function RefillFuncRx(ConsultNo, Date) {//4/6/19

            HoldOn.open();//
            var splitcon = Date.split('-');

            var tranNo = ($.session.get('PatTRANNO'));
            var mrno = ($.session.get('PatMRNO'));

            var patName = $.session.get('PatName').toString();
            var patAge = ($.session.get('PatAge2') == undefined || $.session.get('PatAge2') == null) ? "" : $.session.get('PatAge2').toString();
            var patGender = ($.session.get('PatGender') == undefined || $.session.get('PatGender') == null) ? "" : $.session.get('PatGender').toString();

            // $(".tblRx"+i).empty();
            // alert(ConsultNo + Date);
            $.ajax({
                type: "POST",
                url: 'RefillRxFromMedHist',
                datatype: "json",
                data: { strTranNo: tranNo, strConsultNo: ConsultNo, strMrno: mrno, strpatName: patName, strpatAge: patAge, strpatGender: patGender, strTranDate: splitcon[0], strTranTime: splitcon[1] },
                success: function (result) {
                    if (("" + result).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        //window.location.href = '../DoctorDesk/PatientEntry';
                        $.messager.alert('Information', 'Copied Successfully');
                    }

                    //GetAllCounts();
                },
                complete: function () {
                    HoldOn.close();//
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { HoldOn.close(); }//
            });
        }
        function FilterData(CName, ChkId) {
            const divs = document.querySelectorAll(('.' + CName));
            divs.forEach(function (div) {
                div.style.display = $(("#" + ChkId)).prop("checked") == true ? 'block' : 'none';
            });
        }
        function BindDoctorList() {
            var DoctorListData = JSON.parse(DoctorList);
            $("#cmbDoctList").select2();
            $("#cmbDoctList").empty();
            var Option = '<option value="{Value}">{TEXT}</option>';
            var DefaultOption = '<option value="">---All---</option>';
            $("#cmbDoctList").append(DefaultOption);
            for (var i = 0 ; i < DoctorListData.length; i++) {
                var Doctor = Option.replace("{Value}", DoctorListData[i].CODE).replace("{TEXT}", DoctorListData[i].NAME);
                $("#cmbDoctList").append(Doctor);
            }
        }
        function CheckedBox(Id) {
            if ($(("#") + Id).prop("checked") == true)
                $(("#") + Id).prop("checked", false);
            else
                $(("#") + Id).prop("checked", true);
        }

        function CalculateAppointDate(TranDate, Increase, IncreaseType) {
            var parts = TranDate.split('/');
            var dateObj = new Date(parts[2] + "-" + parts[1] + "-" + parts[0]);
            if (IncreaseType.trim().toUpperCase().includes("D")) {
                dateObj.setDate(dateObj.getDate() + Number(Increase));
            }
            else if (IncreaseType.trim().toUpperCase().includes("W")) {
                dateObj.setDate(dateObj.getDate() + (Number(Increase)) * 7);
            }
            else if (IncreaseType.trim().toUpperCase().includes("M")) {
                dateObj.setMonth(dateObj.getMonth() + Number(Increase));
            }
            else if (IncreaseType.trim().toUpperCase().includes("Y")) {
                dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
            }
            else {
                dateObj.setDate(dateObj.getDate() + Number(Increase));
            }
            //switch (IncreaseType) {
            //    case "day":
            //        dateObj.setDate(dateObj.getDate() + Number(Increase));
            //        break;
            //    case "week":
            //        dateObj.setDate(dateObj.getDate() + (Number(Increase)) * 7);
            //        break;
            //    case "month":
            //        dateObj.setMonth(dateObj.getMonth() + Number(Increase));
            //        break;
            //    case "year":
            //        dateObj.setFullYear(dateObj.getFullYear() + Number(Increase));
            //        break;
            //    default:
            //        dateObj.setDate(dateObj.getDate() + Number(Increase));
            //}
            var dd = String(dateObj.getDate()).padStart(2, '0');
            var mm = String(dateObj.getMonth() + 1).padStart(2, '0');
            var yyyy = dateObj.getFullYear();
            return (dd + "/" + mm + "/" + yyyy);
        }
    </script>
    </asp:Content>