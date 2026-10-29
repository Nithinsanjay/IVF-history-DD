<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SinglePage.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


        <!--Added By devendra-->
    <style>
        button:not(:disabled),
        input[type="button"]:not(:disabled),
        input[type="submit"]:not(:disabled),
        input[type="reset"]:not(:disabled),
        input[type="radio"]:not(:disabled),
        input[type="checkbox"]:not(:disabled),
        img,
        .fa,
        .fas,
        .far,
        .fab,
        .glyphicon,
        select:not(:disabled),
        input[type="file"]:not(:disabled),
input[type="file"]:not(:disabled)::-webkit-file-upload-button ,
     input[type="date"]:not(:disabled)::-webkit-calendar-picker-indicator ,
        a {
            cursor: pointer !important;
        }
    </style>

    <style>
        .sticky-top-custom {
            position: sticky;
            top: 0;
            z-index: 1020;
        }

        .transition-icon {
            transition: transform 0.3s ease-in-out;
        }

        [aria-expanded="true"] .transition-icon {
            transform: rotate(180deg);
        }

        .cursor-pointer {
            cursor: pointer;
            user-select: none;
        }

        .bg-waiting-header {
            background-color: #ffe0cc;
            color: #333;
        }

        .bg-completed-header {
            background-color: #5cfc88;
            color: #333;
        }

        .bg-row-green {
            background-color: #d1fae5;
        }

        .bg-row-purple {
            background-color: #e0e7ff;
        }

        .bg-row-pink {
            background-color: #fce7f3;
        }

        .fs-7 {
            font-size: 0.85rem;
        }

        .fw-600 {
            font-weight: 600;
        }

        .patient-row:hover {
            filter: brightness(0.95);
            transition: 0.2s;
        }

        /* New Helper for Doctor Name */
        .doc-name-sub {
            font-size: 0.75rem;
            color: #6c757d;
            font-weight: normal;
        }

        .blink {
            border: 2px solid brown;
        }

        .bellIconImg {
            margin-top: 5px;
            padding-left: 5px;
        }
    </style>

    <script type="text/javascript">
        var GLB_AllPatients = [];//priyanka 24/02/2026
        var PACWaitListtimer = 0; //priyanka 23/04/2026
        $(document).ready(function () {
           

            SetPACPatInfoClick(false, "");
            if (RefreshWithinSec && Number(RefreshWithinSec) > 0) {
                //priyanka 23/04/2026
                PACWaitListtimer = 0;
                $("#timerLabelPAC").text("0 sec");

                setInterval(function () {
                    PACWaitListtimer++;

                    $("#timerLabelPAC").text(PACWaitListtimer + " sec");

                    if (PACWaitListtimer === Number(RefreshWithinSec)) {
                        GetPatientListForPAC();
                    }

                }, 1000);
                //end
            }
            document.getElementById("PatientDashboard_BackBtn").addEventListener("click", function () {
                SetPACPatInfoClick(false);
                SetPACSearchFilter(false);
                SetShowAllPACPatList(false); // Abhishesh || 20261022
                setModuleSession(false);
                window.location.href = "../SinglePage/SinglePageMenuList";
            });

            $("#chkAllPatLst").on("change", function () {
                PACWaitListtimer = 0;
                var PACSEARCHKEYS = {};
                if ($(this).is(':checked')) {
                    $("#lblSelect img").css("opacity", "1.0");
                    PACSEARCHKEYS.PACClinicWise = "N";
                    //priyanka 23/02/2026
                    var dataobject = {
                        PACSrchByDoctYN: "N"
                    }
                    SetShowAllPACPatList(true, dataobject);

                } else {
                    $("#lblSelect img").css("opacity", "0.6");
                    PACSEARCHKEYS.PACClinicWise = "Y";
                    var dataobject = {
                        PACSrchByDoctYN: "Y"
                    }
                    SetShowAllPACPatList(false, dataobject);
                }
                PACSEARCHKEYS.PACConsultDate = sessionStorage.getItem("PACConsultDate");
                SetPACSearchFilter(true, PACSEARCHKEYS);
                GetPatientListForPAC();
            });

            $("#PatientDashboard_DateInput").on("change", function () {
                var PACSEARCHKEYS = {};
                PACSEARCHKEYS.PACConsultDate = $("#PatientDashboard_DateInput").val();
                PACSEARCHKEYS.PACClinicWise = sessionStorage.getItem("PACClinicWise");
                SetPACSearchFilter(true, PACSEARCHKEYS);
                GetPatientListForPAC();
            });

            $('.card-header').on('click', function () {
                var $header = $(this);
                var $icon = $header.find('.transition-icon');
                var $collapse = $header.next('.collapse');
                $collapse.collapse('toggle');
                $collapse.one('shown.bs.collapse', function () {
                    $icon.removeClass('fa-chevron-down').addClass('fa-chevron-up');
                });
                $collapse.one('hidden.bs.collapse', function () {
                    $icon.removeClass('fa-chevron-up').addClass('fa-chevron-down');
                });
            });

            window.addEventListener('load', function () {
                SetPACPatInfoClick(false);
                setModuleSession(true, "PAC");
            });
            window.addEventListener('pageshow', function (event) {
                if (event.persisted) {
                    SetPACPatInfoClick(false);
                    setModuleSession(true, "PAC");
                }
            });
            SetMaxPACConsultDate();
            // Abhishesh || 20261022
            if (sessionStorage.getItem("PACSrchByDoctYN") == "N") {
                $("#chkAllPatLst").prop("checked", true);
                $("#lblSelect img").css("opacity", "1.0");
            }
            //End
            SetSessionData();
            GetPatientListForPAC();

            //priyanka 24/02/2026
            $("#PAC_PatientDashboard_SearchInput").on("keyup", debounce(function () {
                PACWaitListtimer = 0;
                var value = $(this).val().trim().toLowerCase();

                // If less than 3 characters → reset full list
                if (value.length < 3) {
                    BindPatientWaitingList(GLB_AllPatients);
                    return;
                }

                var filteredData = GLB_AllPatients.filter(function (item) {

                    return (
                        (item.PatName && item.PatName.toLowerCase().includes(value)) ||
                        (item.MRNO && item.MRNO.toLowerCase().includes(value)) ||
                        (item.ConsDoctName && item.ConsDoctName.toLowerCase().includes(value)) ||
                        (item.AdvisedDoctName && item.AdvisedDoctName.toLowerCase().includes(value)) ||
                        (item.SurgName && item.SurgName.toLowerCase().includes(value)) ||
                        (item.NatureSurgy && item.NatureSurgy.toLowerCase().includes(value))
                    );

                });

                BindPatientWaitingList(filteredData);

            }, 400));
            //end


        });
        function debounce(fn, delay) {
            let timer;
            return function () {
                let context = this, args = arguments;
                clearTimeout(timer);
                timer = setTimeout(() => fn.apply(context, args), delay);
            };
        }
        function ResetPACWaitingListData() {
            window.location.reload();
        }

        function SetMaxPACConsultDate() {
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            var currentDate = yyyy + '-' + mm + '-' + dd;
            $("#PatientDashboard_DateInput").attr("max", currentDate);
        }

        function SetSessionData() {
            var PACSEARCHKEYS = {};
            if ((sessionStorage.getItem("PACConsultDate") == "" || sessionStorage.getItem("PACConsultDate") == null) &&
                (sessionStorage.getItem("PACClinicWise") == "" || sessionStorage.getItem("PACClinicWise") == null)) {
                SetCurrentDate();
                PACSEARCHKEYS.PACConsultDate = $("#PatientDashboard_DateInput").val();
                PACSEARCHKEYS.PACClinicWise = "N";
            }
            else {
                if (sessionStorage.getItem("PACConsultDate")) {
                    $("#PatientDashboard_DateInput").val(sessionStorage.getItem("PACConsultDate"));
                }
                //if (sessionStorage.getItem("PACClinicWise")) { //commented on 23/02/2026
                //    $("#chkAllPatLst").prop("checked", (sessionStorage.getItem("PACClinicWise") == "Y" ? true : false));
                //}
            }
            PACSEARCHKEYS.PACConsultDate = $("#PatientDashboard_DateInput").val();
            PACSEARCHKEYS.PACClinicWise = $("#chkAllPatLst").prop("checked") == true ? "N" : "Y";
            SetPACSearchFilter(true, PACSEARCHKEYS);
        }

        function SetCurrentDate() {
            var now = new Date();
            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            var today = now.getFullYear() + "-" + (month) + "-" + (day);
            $("#PatientDashboard_DateInput").val(today);
        }


        function GetPatientListForPAC() {
            var dateInputVal = sessionStorage.getItem("PACConsultDate");
            var today = new Date().toISOString().split('T')[0];
            var dateType = (dateInputVal === today) ? "T" : "D";
            var dateParts = dateInputVal.split("-");
            var formattedDate = dateParts[2] + "/" + dateParts[1] + "/" + dateParts[0];
            var isAllPACPatients = $("#chkAllPatLst").is(':checked');
            var strPACSrchByDoctYN = isAllPACPatients ? "N" : "Y";
            startLoading("Loading");
            $.ajax({
                url: "../SinglePage/GetPatientList",
                type: 'post',
                async:true,
                dataType: 'json',
                data: {
                    strClinicCode: sessionStorage.getItem('ClinicCode'),
                    strSrchByDoctYN: strPACSrchByDoctYN,
                    DateType: dateType,
                    CustomeDate: formattedDate,
                    Type: "PAC"
                },
                success: function (response) {
                    console.log(response);
                    if (response.Status.toUpperCase().includes("SUCCESS"))
                        GLB_AllPatients = response.Result;//priyanka 24/02/2026
                        BindPatientWaitingList(response.Result);
                    PACWaitListtimer = 0;
                    stopLoading();
                },
                error: function (xhr, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    stopLoading();
                }
            });
        }

        function BindPatientWaitingList(PatientListData) {
            var WaitingPatList = [];
            var WaitingApprPatList = [];
            var ApprovedPatList = [];
            var srNoWait = 1;
            var srNoWaitAppr = 1;
            var srNoApproved = 1;
            var $WaitingPatContainer = $("#PatientDashboard_WaitingContainer");
            var $WaitingApprPatContainer = $("#PatientDashboard_WaitApprovalContainer");
            var $ApprovedPatContainer = $("#PatientDashboard_ApprovedContainer");
            $WaitingPatContainer.empty();
            $WaitingApprPatContainer.empty();
            $ApprovedPatContainer.empty();
            if (PatientListData.length == 0) {
                $WaitingPatContainer.append('<div class="p-3 text-center text-muted">No records found</div>');
                $WaitingApprPatContainer.append('<div class="p-3 text-center text-muted">No records found</div>');
                $ApprovedPatContainer.append('<div class="p-3 text-center text-muted">No records found</div>');
                ToastMsg("No Data Found.", "warning");
                return false;
            }

            $.each(PatientListData, function (i, item) {
                var mrNo = item.MRNO;
                var patName = item.PatName;
                var docName = item.ConsDoctName;
                var apptTime = item.APPTTM;
                var completedYN = item.CompletedYN;
                var category = item.CompName || "Self Paying Patient";
                var colorClass = "bg-white";
                if (item.DIFFTM > 30) colorClass = "bg-row-pink";
                else if (item.DIFFTM < 0) colorClass = "bg-row-green";
                var patientObj = {
                    sr: 0,
                    mr: mrNo,
                    name: patName,
                    cat: category,
                    time: apptTime,
                    colorClass: colorClass,
                    raw: item
                };
                if (completedYN == "N" || completedYN == " ") {
                    patientObj.sr = srNoWait++;
                    WaitingPatList.push(patientObj);
                } else if (completedYN == "A") {
                    patientObj.sr = srNoWaitAppr++;
                    WaitingApprPatList.push(patientObj);
                }
                else {
                    patientObj.sr = srNoApproved++;
                    ApprovedPatList.push(patientObj);
                }
            });

            for (var i = 0; i < WaitingPatList.length; i++) {
                var item = WaitingPatList[i];
                var dataStr = encodeURIComponent(JSON.stringify(item.raw));
                var PatGender = "";
                if (item.raw["Gender"] === "F") {
                    PatGender = "Female";
                }
                else if (item.raw["Gender"] === "M") {
                    PatGender = "Male"
                }
                else if (item.raw["Gender"] === "O") {
                    PatGender = "Other";
                }
                var imgUrl = item.raw["PatImageURL"] || '';
                var imgHtml = '' + '<img src="' + imgUrl + '" ' + 'class="img-fluid rounded-circle" ' + 'style=" height: 40px;width: 40px;position: relative;" />';
                var html = ''
                    + '<div class="row m-0 align-items-center p-2 mb-1 border-bottom' + item.colorClass + ' patient-row" '
                    + 'style="cursor:pointer;" onclick="onPatientClick(\'' + dataStr + '\', \'N\', \'N\')">'
                    + '<div class="col-md-1 text-center small"><div class="text-muted">' + item.sr + '</div><div class=" fw-bold">' + '#' + item.raw["CONTOKNO"] + '</div></div>'
                    + '<div class="col-md-4 d-flex align-items-center" title="' + item.name + '">'
                    + imgHtml
                    + '<div class="ms-2 flex-grow-1 overflow-hidden">'
                    + '<div class="fw-bold text-truncate">'
                    + item.name +
                    '</div>'
                    + '<div class="text-muted small fw-bold text-truncate">'
                    + item.mr + '|' + item.raw["Age"] + ' | ' + PatGender +
                    '</div>' +
                    (sessionStorage.getItem('PACSrchByDoctYN') == "N" ? ('<div class="text-muted small fw-bold text-truncate"> Dr. ' + item.raw["ConsDoctName"] + '</div>') : "")
                    + '</div>'
                    + '</div>'
                    /*+ '<div class="col-md-2 text-truncate small" title="' + item.raw.RefDoctor + '">' + item.raw.RefDoctor + '</div>'*/
                    + '<div class="col-md-2 text-truncate small" title="' + item.raw.AdvisedDoctName + '">' + item.raw.AdvisedDoctName + '</div>'
                    + '<div class="col-md-2 text-truncate small" title="' + item.raw.SurgName + '">' + item.raw.SurgName + '</div>'
                    + '<div class="col-md-2 text-truncate small">' + item.raw.NatureSurgy + '</div>'
                    + '<div class="col-md-1 text-center small fw-bold d-flex justify-content-center">' + item.time
                    + '<i class="fa fa-bell text-primary ms-2 bellIconImg" title="Call Patient" onclick="onPatientClick(\'' + dataStr + '\', \'N\', \'Y\'); event.stopPropagation();"></i>'
                    + '</div>'
                    + '</div>';
                $WaitingPatContainer.append(html);
            }

            for (var i = 0; i < WaitingApprPatList.length; i++) {
                ////debugger;
                var item = WaitingApprPatList[i];
                var dataStr = encodeURIComponent(JSON.stringify(item.raw));
                var PatGender = "";
                if (item.raw["Gender"] === "F") {
                    PatGender = "Female";
                }
                else if (item.raw["Gender"] === "M") {
                    PatGender = "Male"
                }
                else if (item.raw["Gender"] === "O") {
                    PatGender = "Other";
                }
                var imgUrl = item.raw["PatImageURL"] || '';
                var imgHtml = '' + '<img src="' + imgUrl + '" ' + 'class="img-fluid rounded-circle" ' + 'style=" height: 40px;width: 40px;position: relative;" />';
                var html = ''
                    + '<div class="row m-0 align-items-center p-2 mb-1 border-bottom' + item.colorClass + ' patient-row" '
                    + 'style="cursor:pointer;" onclick="onPatientClick(\'' + dataStr + '\', \'W\', \'N\')">'
                    //+ '<div class="col-md-1 text-center small"><div class=" fw-bold">' + item.raw["CONTOKNO"] + ' /' + '</div><div class="text-muted">' + item.sr + '</div></div>'
                    + '<div class="col-md-1 text-center small"><div class="text-muted">' + item.sr + '</div><div class=" fw-bold">' + '#' + item.raw["CONTOKNO"] + '</div></div>'
                    + '<div class="col-md-4 d-flex align-items-center" title="' + item.name + '">'
                    + imgHtml
                    + '<div class="ms-2 flex-grow-1 overflow-hidden">'
                    + '<div class="fw-bold text-truncate">'
                    + item.name +
                    '</div>'
                    + '<div class="text-muted small fw-bold text-truncate">'
                    + item.mr + '|' + item.raw["Age"] + ' | ' + PatGender +
                    '</div>' +
                    (sessionStorage.getItem('PACSrchByDoctYN') == "N" ? ('<div class="text-muted small fw-bold text-truncate"> Dr. ' + item.raw["ConsDoctName"] + '</div>') : "")
                    + '</div>'
                    + '</div>'
                    /*+ '<div class="col-md-2 text-truncate small" title="' + item.raw.RefDoctor + '">' + item.raw.RefDoctor + '</div>'*/
                    + '<div class="col-md-2 text-truncate small" title="' + item.raw.AdvisedDoctName + '">' + item.raw.AdvisedDoctName + '</div>'
                    + '<div class="col-md-2 text-truncate small" title="' + item.raw.SurgName + '">' + item.raw.SurgName + '</div>'
                    + '<div class="col-md-2 text-truncate small">' + item.raw.NatureSurgy + '</div>'
                    + '<div class="col-md-1 text-center small fw-bold d-flex justify-content-center">' + item.time
                    + '<i class="fa fa-bell text-primary ms-2 bellIconImg" title="Call Patient" onclick="onPatientClick(\'' + dataStr + '\', \'W\', \'Y\'); event.stopPropagation();"></i>'
                    + '</div>'
                    + '</div>';
                $WaitingApprPatContainer.append(html);
            }


            for (var i = 0; i < ApprovedPatList.length; i++) {
                var item = ApprovedPatList[i];
                var dataStr = encodeURIComponent(JSON.stringify(item.raw));
                var PatGender = "";
                if (item.raw["Gender"] === "F") {
                    PatGender = "Female";
                }
                else if (item.raw["Gender"] === "M") {
                    PatGender = "Male"
                }
                else if (item.raw["Gender"] === "O") {
                    PatGender = "Other";
                }
                var imgUrl = item.raw["PatImageURL"] || '';
                var imgHtml = '' + '<img src="' + imgUrl + '" ' + 'class="img-fluid rounded-circle" ' + 'style=" height: 40px;width: 40px;position: relative;" />';
                var html = ''
                    + '<div class="row m-0 align-items-center p-2 mb-1 border-bottom' + item.colorClass + ' patient-row" '
                    + 'style="cursor:pointer;" onclick="onPatientClick(\'' + dataStr + '\', \'A\', \'N\')">'
                    //+ '<div class="col-md-1 text-center small"><div class=" fw-bold">' + item.raw["CONTOKNO"] + ' /' + '</div><div class="text-muted">' + item.sr + '</div></div>'
                    + '<div class="col-md-1 text-center small"><div class="text-muted">' + item.sr + '</div><div class=" fw-bold">' + '#' + item.raw["CONTOKNO"] + '</div></div>'
                    + '<div class="col-md-4 d-flex align-items-center" title="' + item.name + '">'
                    + imgHtml
                    + '<div class="ms-2 flex-grow-1 overflow-hidden">'
                    + '<div  class="fw-bold text-truncate">'
                    + item.name +
                    '</div>'
                    + '<div class="text-muted small fw-bold text-truncate">'
                    + item.mr + '|' + item.raw["Age"] + ' | ' + PatGender +
                    '</div>' +
                    (sessionStorage.getItem('PACSrchByDoctYN') == "N" ? ('<div class="text-muted small fw-bold text-truncate"> Dr. ' + item.raw["ConsDoctName"] + '</div>') : "")
                    + '</div>'
                    + '</div>'
                    /*+ '<div class="col-md-2 text-truncate small" title="' + item.raw.RefDoctor + '">' + item.raw.RefDoctor + '</div>'*/
                    + '<div class="col-md-2 text-truncate small" title="' + item.raw.AdvisedDoctName + '">' + item.raw.AdvisedDoctName + '</div>'
                    + '<div class="col-md-2 text-truncate small" title="' + item.raw.SurgName + '">' + item.raw.SurgName + '</div>'
                    + '<div class="col-md-2 text-truncate small">' + item.raw.NatureSurgy + '</div>'
                    + '<div class="col-md-1 text-center small fw-bold d-flex justify-content-center ">' + item.time + '</div>'
                    + '</div>';
                $ApprovedPatContainer.append(html);
            }
            $("#PatientDashboard_CollapseWaiting_waiting").text("(" + WaitingPatList.length + ") Waiting Patient(s) ");
            $("#PatientDashboard_CollapseWaiting_WaitApproval").text("(" + WaitingApprPatList.length + ") Waiting For Approval");
            $("#PatientDashboard_CollapseWaiting_Approved").text("(" + ApprovedPatList.length + ") Approved");
        }
        var PendingPAC = {};
        function onPatientClick(encodedItem, type , CallPatYN) {
            var item = JSON.parse(decodeURIComponent(encodedItem));
            if (item.Gender === "F") {
                item.Gender = "Female";
            }
            else if (item.Gender === "M") {
                item.Gender = "Male";
            }
            else if (item.Gender === "O") {
                item.Gender = "Other";
            }
            const dataobject = {
                PACTOKENNO: item.CONTOKNO,
                PACConsltNo: item.CONSNO,
                PACAdvConsltNo: item.TRANNO,
                PACSTATUS: type,
                PACPatMRNO: item.MRNO,
                PACPatName: item.PatName,
                PACPatAge: item.Age,
                PACPatGender: item.Gender,
                PACRefDoctor: item.RefDoctor,
                PACSurgName: item.SurgName,
                PACNatureSurg: item.NatureSurg,
                PACDPatImgURL: item.PatImageURL,
                PACRefPACTranNo: item.TRANNO //priyanka 19/02/2026
            };
            //CheckPatOnConsult(item.MRNO, item.ConsDate, item.PatName, item.TRANNO, dataobject, CallPatYN);//priyanka 17/02/2026

            if (type !== "N") {   // existing PAC: open as before
                CheckPatOnConsult(item.MRNO, item.ConsDate, item.PatName, item.TRANNO, dataobject, CallPatYN, "");
                return;
            }
            startLoading("Loading");
            $.ajax({
                url: '../SinglePage/GetPendingSurgAdvList',
                type: 'post',
                dataType: 'json',
                data: { mrno: item.MRNO },
                success: function (list) {
                    stopLoading();
                    PendingPAC = { item: item, dataobject: dataobject, CallPatYN: CallPatYN };
                    // 1. Zero advices: Do NOT open form, just show info toast
                    if (!list || list.length === 0) {
                        ToastMsg("There is currently no pending surgery advice for the selected patient.", "info");
                        return;
                    }

                    // 2. Exactly 1 advice: Directly open without popup
                    if (list.length === 1) {
                        CheckPatOnConsult(item.MRNO, item.ConsDate, item.PatName, item.TRANNO, dataobject, CallPatYN, list[0].TRANNO);
                        return;
                    }

                    var $b = $("#SurgAdvPopupBody").empty();
                    $.each(list, function (i, a) {
                        var $tr = $("<tr/>");
                        $tr.append($("<td/>").append($("<input type='radio' name='SurgAdvSel'/>").val(a.TRANNO).prop("checked", i === 0)));
                        $tr.append($("<td/>").text(a.SURGADVDATE));
                        $tr.append($("<td/>").text(a.SURGNMADVICE));
                        $tr.append($("<td/>").text(a.DOCTNAME));
                        $tr.append($("<td/>").text(a.SURGADVTYPE));
                        $b.append($tr);
                    });
                    $("#SurgAdvPopup").css("display", "flex");
                },
                error: function (xhr, textStatus) { stopLoading(); ToastMsg(textStatus, "error"); }
            });
        }
        function CloseSurgAdvPopup() { $("#SurgAdvPopup").hide(); }

        function ContinueSurgAdv() {
            var sel = $("input[name='SurgAdvSel']:checked").val();
            if (!sel) { ToastMsg("Please select a surgery advice.", "warning"); return; }
            CloseSurgAdvPopup();
            var p = PendingPAC;
            CheckPatOnConsult(p.item.MRNO, p.item.ConsDate, p.item.PatName, p.item.TRANNO, p.dataobject, p.CallPatYN, sel);
        }

        function CheckPatOnConsult(MRNO, CONSULTDT, PATNAME, PACPatTranNo, dataobject, CallPatYN, SurgAdvTranNo) {//priyanka 17/02/2026
            startLoading("Loading");
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/CheckPatConsult',
                data: { mrno: MRNO, ConsDate: CONSULTDT },
                async: true,
                success: function (response) {
                    SetPACPatInfoClick(true, dataobject);
                    if (CallPatYN == "Y")
                        SaveToken(CONSULTDT);
                    window.location.href = '../SinglePage/PAC?PatMRNO=' + MRNO + '&PatTRANNO=' + PACPatTranNo +
                        (SurgAdvTranNo ? '&SurgAdvTranNo=' + encodeURIComponent(SurgAdvTranNo) : '');
                    stopLoading();
                },
                error: function (xhr, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    stopLoading();
                }
            });
        } 

        function SaveToken(CONSULTDT) {
            var Mrno = sessionStorage.getItem('PACPatMRNO');
            var strPatName = sessionStorage.getItem('PACPatName');
            var ConsToken = sessionStorage.getItem('PACTOKENNO');
            var ConsltnNo = sessionStorage.getItem('PACConsltNo');
            var CONSULTDT = CONSULTDT;
            if (Mrno != "") {
                startLoading("Loading");
                $.ajax({
                    type: 'POST',
                    url: '../DoctorDesk/CallWaitPatSave',
                    data: { mrno: Mrno, consNo: ConsltnNo, TokenNo: ConsToken, Patient: strPatName, ConsDate: CONSULTDT },
                    async: true,
                    success: function (response) {
                        stopLoading();
                    },
                    error: function () {
                        ToastMsg("Something went wrong please try again.", "error");
                        stopLoading();
                    }
                });
            }
        }


    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <div id="SurgAdvPopup" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,.5); z-index: 9999; align-items: center; justify-content: center;">
        <div class="bg-white rounded shadow" style="width: 80vw; max-width: 900px; max-height: 85vh; overflow: auto;">
            <div class="d-flex justify-content-between p-2" style="background: #022548; color: #fff;">
                <b>Surgery Advice List</b>
                <span style="cursor: pointer; font-size: 20px;" onclick="CloseSurgAdvPopup()">&times;</span>
            </div>
            <table class="table table-sm table-bordered mb-0 text-center">
                <thead class="bg-light">
                    <tr>
                        <th style="align-content: center">Action</th>
                        <th>Surgery Advice Date</th>
                        <th style="align-content: center">Surgery Advice</th>
                        <th style="align-content: center">Doctor</th>
                        <th>Nature of Surgery</th>
                    </tr>
                </thead>
                <tbody id="SurgAdvPopupBody"></tbody>
            </table>
            <div class="text-center p-2">
                <button type="button" class="btn btn-success" onclick="ContinueSurgAdv()">Continue</button>
            </div>
        </div>
</div>
    <div class="container-fluid p-3">

        <div class="row mb-3 align-items-center bg-white p-2 shadow-sm rounded sticky-top-custom">
            <div class="col-md-1 d-flex align-items-center justify-content-center">
                <button class="btn btn-link text-dark p-0 btn_Back" id="PatientDashboard_BackBtn">
                    <i class="fa fa-chevron-left"></i>Back
                </button>
            </div>

            <div class="col-md-2">
                <div class="input-group">
                    <input type="checkbox" style="display: none;" id="chkAllPatLst">
                    <label class="lblImg input-group-text bg-white border-end-0" id="lblSelect" title="Show all patient" for="chkAllPatLst" style="cursor: pointer">
                        <img class="lblImage" src="../Images/patient.png" style="width: 25px; height: 25px; opacity: 0.6" alt="P"></label>
                    <input type="date" class="form-control form-control-sm date_Filter border-start-0 ps-0" id="PatientDashboard_DateInput" style="background-color: white;">
                </div>
            </div>

            <div class="col-md-4 d-none justify-content-center gap-3">
                <div class="form-check">
                    <input class="form-check-input chk_Filter" type="checkbox" id="PatientDashboard_ChkNew">
                    <label class="form-check-label text-success fw-bold" for="PatientDashboard_ChkNew">New</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input chk_Filter" type="checkbox" id="PatientDashboard_ChkFollowUp">
                    <label class="form-check-label text-primary fw-bold" for="PatientDashboard_ChkFollowUp">Follow Up</label>
                </div>
                <div class="form-check" id="RRChkDiv">
                    <input class="form-check-input chk_Filter" type="checkbox" id="PatientDashboard_ChkReview">
                    <label class="form-check-label text-danger fw-bold" for="PatientDashboard_ChkReview">Review With Reports</label>
                </div>
            </div>

            <div class="col-md-3" style="margin-left:50%;">
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control txt_Search" id="PAC_PatientDashboard_SearchInput" placeholder="Search For Patient">
                    <span class="input-group-text bg-white" id="OPDspanSearchPat"><i class="fa fa-search"></i></span>
                    <div style="margin-left: 6px;">
                        <svg xmlns="http://www.w3.org/2000/svg" style="height: 20px; width: 30px; cursor: pointer;" viewBox="0 0 640 640" onclick="ResetPACWaitingListData();">
                            <!--!Font Awesome Free v7.1.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2026 Fonticons, Inc.-->
                            <path d="M129.9 292.5C143.2 199.5 223.3 128 320 128C373 128 421 149.5 455.8 184.2C456 184.4 456.2 184.6 456.4 184.8L464 192L416.1 192C398.4 192 384.1 206.3 384.1 224C384.1 241.7 398.4 256 416.1 256L544.1 256C561.8 256 576.1 241.7 576.1 224L576.1 96C576.1 78.3 561.8 64 544.1 64C526.4 64 512.1 78.3 512.1 96L512.1 149.4L500.8 138.7C454.5 92.6 390.5 64 320 64C191 64 84.3 159.4 66.6 283.5C64.1 301 76.2 317.2 93.7 319.7C111.2 322.2 127.4 310 129.9 292.6zM573.4 356.5C575.9 339 563.7 322.8 546.3 320.3C528.9 317.8 512.6 330 510.1 347.4C496.8 440.4 416.7 511.9 320 511.9C267 511.9 219 490.4 184.2 455.7C184 455.5 183.8 455.3 183.6 455.1L176 447.9L223.9 447.9C241.6 447.9 255.9 433.6 255.9 415.9C255.9 398.2 241.6 383.9 223.9 383.9L96 384C87.5 384 79.3 387.4 73.3 393.5C67.3 399.6 63.9 407.7 64 416.3L65 543.3C65.1 561 79.6 575.2 97.3 575C115 574.8 129.2 560.4 129 542.7L128.6 491.2L139.3 501.3C185.6 547.4 249.5 576 320 576C449 576 555.7 480.6 573.4 356.5z" />
                        </svg>
                    </div>
                </div>
                <div id="PatSearchDetailsMainDiv" style="position: absolute;">
                    <div id="PatDetailsSearchList" class=" list-group position-absolute" style="z-index: 1000; max-height: 200px; overflow-y: auto; display: none; background: white; border: 1px solid #ccc;">
                    </div>
                    <div id="loading-PatientSearchInfo" class="loading-screen" style="display: none; opacity: 0;">
                    </div>
                </div>

                <span id="timerLabelPAC" style="display:none;">0</span> 

            </div>
        </div>

        <div class="card mb-3 border-0 shadow-sm">
            <div class="card-header bg-waiting-header d-flex justify-content-between align-items-center py-3 cursor-pointer">
                <h6 class="m-0 fw-bold" id="PatientDashboard_CollapseWaiting_waiting">Waiting Patient(s)</h6>
                <i class="fa fa-chevron-up transition-icon"></i>
            </div>
            <div id="PatientDashboard_CollapseWaiting" class="collapse show">
                <div class="card-body p-0">
                    <div class="row bg-light fw-bold p-2 border-bottom m-0 fs-7">
                        <%--<div class="col-md-1 text-center">Token No.<div class="">SR No.</div></div>--%>
                        <div class="col-md-1 text-center">SR No.<div class="">TK No.</div></div>
                        <div class="col-md-4">Patient Name</div>
                        <div class="col-md-2">Prescribed Doctor</div>
                        <div class="col-md-2">Surgery Name</div>
                        <div class="col-md-2">Nature Of Surgery</div>
                        <div class="col-md-1 text-center" style="overflow-wrap: normal;">Appt. Time</div>
                    </div>
                    <div id="PatientDashboard_WaitingContainer" class="p-0 w-100"></div>
                </div>
            </div>
        </div>

        <div class="card mb-3 border-0 shadow-sm">
            <div class="card-header bg-completed-header d-flex justify-content-between align-items-center py-3 cursor-pointer">
                <h6 class="m-0 fw-bold" id="PatientDashboard_CollapseWaiting_WaitApproval">Waiting For Approval</h6>
                <i class="fa fa-chevron-up transition-icon"></i>
            </div>
            <div id="PatientDashboard_CollapseWaitApproval" class="collapse show">
                <div class="card-body p-0">
                    <div class="row bg-light fw-bold p-2 border-bottom m-0 fs-7">
                        <%--<div class="col-md-1 text-center">Token No. /<div class="">SR No.</div></div>--%>
                        <div class="col-md-1 text-center">SR No.<div class="">TK No.</div></div>
                        <div class="col-md-4">Patient Name</div>
                        <div class="col-md-2">Prescribed Doctor</div>
                        <div class="col-md-2">Surgery Name</div>
                        <div class="col-md-2">Nature Of Surgery</div>
                        <div class="col-md-1 text-center" style="overflow-wrap: normal;">Appt. Time</div>
                    </div>
                    <div id="PatientDashboard_WaitApprovalContainer" class="p-0 w-100"></div>
                </div>
            </div>
        </div>

        <div class="card mb-3 border-0 shadow-sm">
            <div class="card-header bg-completed-header d-flex justify-content-between align-items-center py-3 cursor-pointer">
                <h6 class="m-0 fw-bold" id="PatientDashboard_CollapseWaiting_Approved">Approved</h6>
                <i class="fa fa-chevron-up transition-icon"></i>
            </div>
            <div id="PatientDashboard_CollapseApproved" class="collapse show">
                <div class="card-body p-0">
                    <div class="row bg-light fw-bold p-2 border-bottom m-0 fs-7">
                        <%--<div class="col-md-1 text-center">Token No. /<div class="">SR No.</div></div>--%>
                        <div class="col-md-1 text-center">SR No.<div class="">TK No.</div></div>
                        <div class="col-md-4">Patient Name</div>
                        <div class="col-md-2">Prescribed Doctor</div>
                        <div class="col-md-2">Surgery Name</div>
                        <div class="col-md-2">Nature Of Surgery</div>
                        <div class="col-md-1 text-center" style="overflow-wrap: normal;">Appt. Time</div>
                    </div>
                    <div id="PatientDashboard_ApprovedContainer" class="p-0 w-100"></div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>