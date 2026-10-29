<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SinglePage.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* --- Styles --- */
        .sticky-top-custom {
            position: sticky;
            top: 0;
            z-index: 1020;
        }

        /* Icon Rotation Logic for Collapse */
        .transition-icon {
            transition: transform 0.3s ease-in-out;
        }
        /* This rotates the icon when the collapse is NOT expanded (collapsed) */
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
    </style>

    <%--Waiting List--%>
    <script type="text/javascript">
        // --- 1. Global Variables ---
        var GLB_RawData = [];
        var FlagForSelPat = true;
        var consultationDate = "";
        $(document).ready(function () {

            SetOPDPatInfoClick(false, "");
            setDefaultDate();
            loadPatientData();
            initEventListeners();

            document.getElementById("PatientDashboard_BackBtn").addEventListener("click", function () {
                sessionStorage.setItem('ConsultationDate', '');
                window.location.href = "../SinglePage/SinglePageMenuList";
            });

            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            var currentDate = yyyy + '-' + mm + '-' + dd;
            $("#PatientDashboard_DateInput").attr("max", currentDate);


            const checkboxValues = {
                'PatientDashboard_ChkNew': '01',
                'PatientDashboard_ChkFollowUp': '02',
                'PatientDashboard_ChkReview': 'Y'
            };

            // On any checkbox click
            //Priyanka 13/01/2026
            $('#PatientDashboard_ChkNew, #PatientDashboard_ChkFollowUp,#PatientDashboard_ChkReview').click(function () {

                /*$('#PatientDashboard_ChkNew, #PatientDashboard_ChkFollowUp').not(this).prop('checked', false);*/

                // Enable or disable Review With Reports based on Follow Up
                //if ($('#PatientDashboard_ChkFollowUp').is(':checked')) {
                //    $('#PatientDashboard_ChkReview').prop('disabled', false);
                //    $("#RRChkDiv").show();
                //} else {
                //    $('#PatientDashboard_ChkReview').prop('checked', false).prop('disabled', true);
                //    $("#RRChkDiv").hide();
                //}

                OPDWaitingList_FilterRecords();
            });


            $('#PatientDashboard_ChkReview').click(function () {
                OPDWaitingList_FilterRecords();
            });

            // Initialize on page load
            $(document).ready(function () {
               // sessionStorage.setItem('ConsultationDate', '');
                //if ($('#PatientDashboard_ChkFollowUp').is(':checked')) {
                //    $('#PatientDashboard_ChkReview').prop('disabled', false);
                //} else {
                //    $('#PatientDashboard_ChkReview').prop('checked', false).prop('disabled', true);
                //}
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
        });

        window.addEventListener('load', function () {
            SetOPDPatInfoClick(false, "");
        });
        window.addEventListener('pageshow', function (event) {
            if (event.persisted) { // page was loaded from cache
                SetOPDPatInfoClick(false, "");
            }
        });

        function OPDWaitingList_FilterRecords() {
            let selectedValues = [];
            if ($('#PatientDashboard_ChkNew').is(':checked') === true) {
                selectedValues.push("01")

            }

            if ($('#PatientDashboard_ChkFollowUp').is(':checked') === true) {
                selectedValues.push("02")
            }

            if ($('#PatientDashboard_ChkReview').is(':checked') === true) {
                var ReviewRptYn = "Y";
                selectedValues.push("03")
            }
            var SelectedPurposeCode = $("#PatientDashboard_VisitPurpose").val();
            var countw = 0;
            $("#PatientDashboard_WaitingContainer .row").each(function () {
                var purposeCode = $(this).find("div:eq(9)").text().trim(); // 0-based index
                var visittypecode = $(this).find("div:eq(10)").text().trim();
                var reviewrptyn = $(this).find("div:eq(11)").text().trim();


                if (selectedValues.length != 0 && SelectedPurposeCode === "") {
                    if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === false) {
                        $(this).show(); countw++;
                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === true) {
                        if (reviewrptyn === "N") {
                            $(this).show(); countw++;
                        }
                        else {
                            $(this).hide();
                        }

                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && $('#PatientDashboard_ChkReview').is(':checked') === true) {
                        if (reviewrptyn === "Y") {
                            $(this).show(); countw++;
                        }
                        else {
                            $(this).hide();
                        }
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if (selectedValues.length != 0 && SelectedPurposeCode != "") {
                    if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && SelectedPurposeCode === purposeCode && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === false) {
                        $(this).show(); countw++;
                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && SelectedPurposeCode === purposeCode && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === true) {
                        if (reviewrptyn === "N") {
                            $(this).show(); countw++;
                        }
                        else {
                            $(this).hide();
                        }

                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && SelectedPurposeCode === purposeCode && $('#PatientDashboard_ChkReview').is(':checked') === true) {
                        if (reviewrptyn === "Y") {
                            $(this).show(); countw++;
                        }
                        else {
                            $(this).hide();
                        }
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if (selectedValues.length === 0 && SelectedPurposeCode != "") {
                    if (SelectedPurposeCode === purposeCode) {
                        $(this).show(); countw++;
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if (selectedValues.length === 0 && SelectedPurposeCode === "") {
                    $(this).show(); countw++;
                }
                else {
                    $(this).hide();
                }

            });
            //Completed List
            var count = 0;
            $("#PatientDashboard_CompletedContainer .row").each(function () {
                var purposeCode = $(this).find("div:eq(9)").text().trim(); // 0-based index
                var visittypecode = $(this).find("div:eq(10)").text().trim();
                var reviewrptyn = $(this).find("div:eq(11)").text().trim();

                if (selectedValues.length != 0 && SelectedPurposeCode === "") {
                    if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === false) {
                        $(this).show(); count++;
                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === true) {
                        if (reviewrptyn === "N") {
                            $(this).show(); count++;
                        }
                        else {
                            $(this).hide();
                        }

                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && $('#PatientDashboard_ChkReview').is(':checked') === true) {
                        if (reviewrptyn === "Y") {
                            $(this).show(); count++;
                        }
                        else {
                            $(this).hide();
                        }
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if (selectedValues.length != 0 && SelectedPurposeCode != "") {
                    if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && SelectedPurposeCode === purposeCode && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === false) {
                        $(this).show(); count++;
                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && SelectedPurposeCode === purposeCode && $('#PatientDashboard_ChkReview').is(':checked') === false && $('#PatientDashboard_ChkFollowUp').is(':checked') === true) {
                        if (reviewrptyn === "N") {
                            $(this).show(); count++;
                        }
                        else {
                            $(this).hide();
                        }

                    }
                    else if (selectedValues.length != 0 && selectedValues.includes(visittypecode) && SelectedPurposeCode === purposeCode && $('#PatientDashboard_ChkReview').is(':checked') === true) {
                        if (reviewrptyn === "Y") {
                            $(this).show(); count++;
                        }
                        else {
                            $(this).hide();
                        }
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if (selectedValues.length === 0 && SelectedPurposeCode != "") {
                    if (SelectedPurposeCode === purposeCode) {
                        $(this).show(); count++;
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if (selectedValues.length === 0 && SelectedPurposeCode === "") {
                    $(this).show(); count++;
                }
                else {
                    $(this).hide();
                }
            });
            $('#PatientDashboard_CollapseWaiting_waiting').text("(" + countw + ") Waiting Patient(s) ");
            $("#PatientDashboard_CollapseWaiting_completed").text("(" + count + ") Completed Patient(s) ");
        }
        function setDefaultDate() {
            var now = new Date();
            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);
            var today = now.getFullYear() + "-" + (month) + "-" + (day);
            $("#PatientDashboard_DateInput").val(today);
        }

        function initEventListeners() {
            // Reload on Date Change
            $("#PatientDashboard_DateInput").on("change", function () {
                sessionStorage.setItem('ConsultationDate', '');
                loadPatientData();
            });

            // Reload on Toggle (My/All Patients)
             $("#chkAllPatLst").on("change", function () {
     if ($(this).is(':checked')) {
         /*$("#lblSelect img").css("opacity", "1.0");*/
         $("#lblSelect img").attr('src', "../Images/Singlepage/patient2.png");
         var dataobject = {
             SrchByDoctYN: "N"
         }
         SetShowAllPatList(true, dataobject);
     } else {
         /*$("#lblSelect img").css("opacity", "0.6");*/
         $("#lblSelect img").attr('src', "../Images/Singlepage/patient.png");
         var dataobject = {
             SrchByDoctYN: "Y"
         }
                    SetShowAllPatList(false, dataobject);
                }
                loadPatientData();
            });

            // Client-Side Search
            $("#PatientDashboard_SearchInput").on("keyup", debounce(function () {

                var value = $(this).val().trim().toLowerCase();

                // Minimum characters before searching
                if (value.length < 3) {
                    $("#PatDetailsSearchList").hide();
                    if (value == "") {
                        filterAndRender(GLB_RawData, "");
                    } /*{ ResetOPDWaitingListData();}*/

                    return;
                }

                // Check in main dashboard list first
                var foundInMain = GLB_RawData.some(function (item) {
                    return (item.PatName && item.PatName.toLowerCase().includes(value)) ||
                        (item.MRNO && item.MRNO.includes(value));
                });

                if (foundInMain) {
                    filterAndRender(GLB_RawData, value);
                    $("#PatDetailsSearchList").hide();
                    AddPatientDetailsInSearList(value);
                } else {
                    AddPatientDetailsInSearList(value);
                    //$("#PatDetailsSearchList").show();
                }

            }, 400)); // 400ms debounce

            //Priyanika 06/01/2026
            $("#PatientDashboard_VisitPurpose").on("change", function () {
                OPDWaitingList_FilterRecords();
            });
            //End
        }

        // --- 2. Load Data from Controller ---
        function loadPatientData() {
            consultationDate = sessionStorage.getItem("ConsultationDate");
            var inputDateVal = $("#PatientDashboard_DateInput").val();
            var dateInputVal = "";

            if (consultationDate && consultationDate.trim() !== "") {
                var parts = consultationDate.split("/");
                dateInputVal = parts[2] + "-" + parts[1] + "-" + parts[0];
                $("#PatientDashboard_DateInput").val(dateInputVal);
            } else {
                dateInputVal = inputDateVal;
            }
            // var dateInputVal = $("#PatientDashboard_DateInput").val();
            var today = new Date().toISOString().split('T')[0];

            var dateType = (dateInputVal === today) ? "T" : "D";
            var dateParts = dateInputVal.split("-");
            var formattedDate = dateParts[2] + "/" + dateParts[1] + "/" + dateParts[0];

            var isAllPatients = $("#chkAllPatLst").is(':checked');
            var strSrchByDoctYN = isAllPatients ? "N" : "Y";

            $("#PatientDashboard_WaitingContainer").html('<div class="text-center p-3 text-primary"><i class="fa fa-spinner fa-spin"></i> Loading...</div>');
            $("#PatientDashboard_CompletedContainer").html('');

            startLoading("Loading");
            $.ajax({
                url: "../SinglePage/GetPatientList",
                type: 'post',
                dataType: 'json',
                data: {
                    strClinicCode: sessionStorage.getItem('ClinicCode'),
                    strSrchByDoctYN: strSrchByDoctYN,
                    DateType: dateType,
                    CustomeDate: formattedDate,
                    Type: window.location.href.includes("PAC") ? "PAC" : ""
                },
                success: function (response) {
                    if (response.Result && response.Result !== "Something Went Wrong.") {
                        GLB_RawData = response.Result;
                        filterAndRender(GLB_RawData, "");
                        OPDWaitingList_FilterRecords();
                    } else {
                        renderEmptyState();
                    }
                    stopLoading();
                },
                error: function (xhr, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    $("#PatientDashboard_WaitingContainer").html('<div class="p-3 text-center text-danger">Error loading data.</div>');
                    stopLoading();
                }
            });
        }

        // --- 3. Filter & Split Data ---
        function filterAndRender(data, searchValue) {
            var waitingList = [];
            var completedList = [];
            var srNoWait = 1;
            var srNoComp = 1;

            if (!data || data.length === 0) { renderEmptyState(); return; }

            $.each(data, function (i, item) {
                // Map Data
                var mrNo = item.MRNO;
                var patName = item.PatName;
                var docName = item.OutRefDrName || "Self";
                var apptTime = item.APPTTM;
                var completedYN = item.CompletedYN;
                // Get Completion Time (Time part of ConsDate)
                var completionTime = item.ConsDate && item.ConsDate.includes(" ") ? item.ConsDate.split(' ')[1] : item.ConsDate;

                // Determine Purpose
                var purpose = "Consultation";
                if (item.VisitType === "NW") purpose = "New Visit";
                if (item.VisitType === "FU") purpose = "Follow Up";

                // Determine Category
                var category = item.CompName || "Self Paying Patient";

                // Filter
                if (searchValue !== "" && (patName + mrNo).toLowerCase().indexOf(searchValue) === -1) return;

                // Color Logic
                var colorClass = "bg-white";
                if (item.DIFFTM > 30) colorClass = "bg-row-pink";
                else if (item.DIFFTM < 0) colorClass = "bg-row-green";

                var patientObj = {
                    sr: 0,
                    mr: mrNo,
                    name: patName,
                    cat: category,
                    purpose: purpose,
                    time: apptTime,
                    compTime: completionTime,
                    colorClass: colorClass,
                    raw: item
                };

                // Split List
                if (completedYN === "N" || completedYN === " " || completedYN === null) {
                    patientObj.sr = srNoWait++;
                    waitingList.push(patientObj);
                } else {
                    patientObj.sr = srNoComp++;
                    completedList.push(patientObj);
                }
            });
            renderWaitingHTML(waitingList);
            renderCompletedHTML(completedList);
            $("#PatientDashboard_CollapseWaiting_waiting").text("(" + waitingList.length + ") Waiting Patient(s) ");
            $("#PatientDashboard_CollapseWaiting_completed").text("(" + completedList.length + ") Completed Patient(s) ");
        }

        // --- 4. Render Waiting Grid ---
        function renderWaitingHTML(list) {
            var value = $("#PatientDashboard_SearchInput").val().trim().toLowerCase();

            var isAllPatients = $("#chkAllPatLst").is(':checked');
            var strSrchByDoctYN = isAllPatients ? "N" : "Y";
            var $container = $("#PatientDashboard_WaitingContainer");
            $container.empty();

            if (!list || list.length === 0) {
                $container.html('<div class="p-3 text-center text-muted">No records found</div>');
                return;
            }

            for (var i = 0; i < list.length; i++) {
                var item = list[i];
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
                var found = false;
                if (value && value.trim()) {
                    found = (item.name || "").toLowerCase().indexOf(value) !== -1 || (item.mr || "").toLowerCase().indexOf(value) !== -1;
                }


                var imgUrl = item.raw["PatImageURL"] || '';
                var imgHtml = '' + '<img src="' + imgUrl + '" ' + 'class="img-fluid rounded-circle" ' + 'style=" height: 40px;width: 40px;position: relative;" />';
                var html = ''
                    + '<div class="row m-0 align-items-center p-2 mb-1 border-bottom' + item.colorClass + ' ' + (found ? 'blink' : '') + ' patient-row" '
                    + 'style="cursor:pointer;" onclick="onPatientClick(\'' + dataStr + '\', \'WAITING\')">'
                    + '<div class="col-md-1 text-center small"><div class=" fw-bold">' + item.raw["CONTOKNO"] + ' /' + '</div><div class="text-muted">' + item.sr + '</div></div>'


                    + '<div class="col-md-4 d-flex align-items-center" title="' + item.name + '">'
                    + imgHtml
                    + '<div class="ms-2 flex-grow-1 overflow-hidden">'
                    + '<div class="fw-bold text-truncate">'
                    + item.name +
                    '</div>'
                    + '<div class="text-muted small fw-bold text-truncate">'
                    + item.mr + '|' + item.raw["Age"] + ' | ' + PatGender +
                    '</div>' +
                    (strSrchByDoctYN == "N" ? ('<div class="text-muted small fw-bold text-truncate"> Dr. ' + item.raw["ConsDoctName"] + '</div>') : "")
                    /*        '<div class="text-muted small fw-bold text-truncate">'+ 'Dr. ' + item.raw["ConsDoctName"] + '</div>'*/

                    + '</div>'
                    + '</div>'
                    + '<div class="col-md-2 text-truncate small" title="' + item.cat + '">' + item.cat + '</div>'
                    + '<div class="col-md-2 text-truncate small">' + item.purpose + '</div>'
                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["VisitType"] + '</div>'
                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["VisitTypeCD"] + '</div>'
                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["ReviewRYN"] + '</div>'
                    + '<div class="col-md-1 text-center small fw-bold d-flex ">'
                    + item.time
                    + '<i class="fa fa-bell text-primary ms-2" title="Call Patient" '
                    + 'onclick="event.stopPropagation();"></i>'
                    + '</div>'
                    + '<div class="col-md-1 text-truncate small">' + item.raw["ARRIVEDTM"] + '</div>'
                    + '<div class="col-md-1 text-truncate small">' + item.raw["Status"] + '</div>'

                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["MobileNo"] + '</div>'

                    + '</div>';
                $container.append(html);
            }
        }


        // --- 5. Render Completed Grid ---
        function renderCompletedHTML(list) {
            var isAllPatients = $("#chkAllPatLst").is(':checked');
            var strSrchByDoctYN = isAllPatients ? "N" : "Y";
            var $container = $("#PatientDashboard_CompletedContainer");
            $container.empty();

            if (!list || list.length === 0) {
                $container.html('<div class="p-3 text-center text-muted">No records found</div>');
                return;
            }

            for (var i = 0; i < list.length; i++) {
                var item = list[i];
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
                    + '<div class="row m-0 align-items-center p-2 mb-1 border-bottom ' + item.colorClass + ' patient-row" '
                    + 'style="cursor:pointer;" onclick="onPatientClick(\'' + dataStr + '\', \'COMPLETED\')">'
                    + '<div class="col-md-1 text-center small"><div class=" fw-bold">' + item.raw["CONTOKNO"] + ' /' + '</div><div class="text-muted">' + item.sr + '</div></div>'


                    //+ '<div class="col-md-3 fw-bold text-truncate" title="' + item.name + '">' + +imgHtml + "  " + item.name + '</div>'
                    + '<div class="col-md-4 d-flex align-items-center" title="' + item.name + '">'
                    + imgHtml
                    + '<div class="ms-2 flex-grow-1 overflow-hidden">'
                    + '<div class="fw-bold text-truncate">'
                    + item.name +
                    '</div>'
                    + '<div class="text-muted small fw-bold text-truncate">'
                    + item.mr + ' | ' + item.raw["Age"] + ' | ' + PatGender +
                    '</div>'
                    +
                    //        '<div class="text-muted small fw-bold text-truncate">'
                    //    + 'Dr. ' + item.raw["ConsDoctName"] +
                    //'</div>'
                    (strSrchByDoctYN == "N" ? ('<div class="text-muted small fw-bold text-truncate"> Dr. ' + item.raw["ConsDoctName"] + '</div>') : "")
                    + '</div>'
                    + '</div>'
                    + '<div class="col-md-2 text-truncate small" title="' + item.cat + '">' + item.cat + '</div>'
                    + '<div class="col-md-2 text-truncate small">' + item.purpose + '</div>'
                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["VisitType"] + '</div>'
                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["VisitTypeCD"] + '</div>'
                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["ReviewRYN"] + '</div>'
                    + '<div class="col-md-1 text-center small">' + item.time + '</div>'
                    + '<div class="col-md-1 text-truncate small">' + item.raw["ARRIVEDTM"] + '</div>'
                    + '<div class="col-md-1  fw-bold text-success small">' + item.raw["Compltm"] + '</div>'


                    + '<div class="col-md-2 text-truncate small d-none">' + item.raw["MobileNo"] + '</div>'
                    + '</div>';

                $container.append(html);
            }
        }


        function renderEmptyState() {
            var emptyHtml = '<div class="p-3 text-center text-muted">No records found</div>';
            $("#PatientDashboard_WaitingContainer").html(emptyHtml);
            $("#PatientDashboard_CompletedContainer").html(emptyHtml);
        }
        //Priyanka 06/01/2026
        function SaveToken(CONSULTDT) {
            var Mrno = sessionStorage.getItem('PatMRNO');
            var strPatName = sessionStorage.getItem('PatName');
            var ConsToken = sessionStorage.getItem('PatContokNo');
            var ConsltnNo = sessionStorage.getItem('PatTRANNO');
            var CONSULTDT = CONSULTDT;
            if (Mrno != "") {
                startLoading("Loading");
                $.ajax({
                    type: 'POST',
                    url: '../DoctorDesk/CallWaitPatSave',
                    data: { mrno: Mrno, consNo: ConsltnNo, TokenNo: ConsToken, Patient: strPatName, ConsDate: CONSULTDT },
                    async: false,
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

        function CheckPatOnConsult(MRNO, CONSULTDT, PATNAME) {
            startLoading("Loading");
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/CheckPatConsult',
                data: { mrno: MRNO, ConsDate: CONSULTDT },
                async: false,
                success: function (response) {
                    if (response == "") {
                        FlagForSelPat = true;
                    }
                    else {
                        FlagForSelPat = false;
                        var Msg = "Patient Name : " + PATNAME + "is currently being seen by Dr." + response;
                        ToastMsg(Msg, "Info");
                    }
                    stopLoading();
                },
                error: function (xhr, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    stopLoading();
                }
            });
            return FlagForSelPat;
        }
        //End

        // --- 6. On Click (Session Set) ---
        function onPatientClick(encodedItem, type) {
            if (FlagForSelPat == false) { FlagForSelPat = true; return false; }
            var item = JSON.parse(decodeURIComponent(encodedItem));
            //PRIYANKA 06/01/2026
            var CONSULTDT = item.ConsDate;

            if (CONSULTDT != null && CONSULTDT != "") {
                sessionStorage.setItem("ConsultationDate", CONSULTDT);
            }

            if (item.Gender === "F") {
                item.Gender = "Female";
            }
            else if (item.Gender === "M") {
                item.Gender = "Male";
            }
            else if (item.Gender === "O") {
                item.Gender = "Other";
            }
            var ContNo = item.MobileNo == "" || item.MobileNo == null ? (item.ContactNo == "" || item.ContactNo == null ? "" : item.ContactNo) : item.MobileNo;

            var Status = item.Status.trim();
            var dataobject = {
                PatEmail: item.PatEmail,
                PatMRNO: item.MRNO,
                PatTRANNO: item.CONSNO,
                PatCompleted: item.CompletedYN,
                PatAge: item.Age,
                PatGender: item.Gender,
                PatName: item.PatName,
                PatContokNo: item.CONTOKNO,
                OPDPatImgURL: item.PatImageURL,
                OPDPatMobile: ContNo,
                OPDCompCode: item.ComCode.trim(),
                OPDCompNM: item.CompName.trim(),
            };
            if (Status === "Not Arrived") {
                ToastMsg("Patient has not yet arrived", "information");
                return;
            } else if (Status === "Arrived") {
                ToastMsg("Patient not posted to consultant", "information");
                return;
            }
            var Flg = CheckPatOnConsult(item.MRNO, CONSULTDT, item.PatName);
            if (Flg == true) {
                SetOPDPatInfoClick(true, dataobject);
                SaveToken(CONSULTDT);
                window.location.href = '../SinglePage/SinglePageOPD';
            }
            //End
        }
    </script>

    <%--Waiting List Search Filter--%>
    <script>
        /* ===================== GLOBAL ===================== */
        var PatSearchData = [];
        var table;

        $(document).ready(function () {
            $(document).click(function (e) {
                var target = $(e.target);
                if (!target.closest("#PatSearchDetailsMainDiv").length &&
                    !target.is("#PatientDashboard_SearchInput")) {
                    $("#PatDetailsSearchList").hide();
                }
            });

            $(document).on("click", ".PatientSearchInfo-row", function () {
                var selectedData = {
                    MRNO: $(this).data("mrno"),
                    NAME: $(this).data("name"),
                    AGE: $(this).data("age"),
                    GENDER: $(this).data("gender"),
                    DOB: $(this).data("patdob"),
                    Email: $(this).data("patemail"),
                    PatImageUrl: $(this).data("patimg"),
                    MOBILENO: $(this).data("patmobileno")
                };
                //console.log("Selected Patient:", selectedData);
                onPatientSelected(selectedData);
            });


            $("#OPDspanSearchPat").click(function (e) {
                var value = $("#PatientDashboard_SearchInput").val().trim().toLowerCase();

                if (value.length < 3) {
                    $("#PatDetailsSearchList").hide();
                    return;
                }

                // Check in main dashboard list first
                var foundInMain = GLB_RawData.some(function (item) {
                    return (item.PatName && item.PatName.toLowerCase().includes(value)) ||
                        (item.MRNO && item.MRNO.includes(value));
                });

                if (foundInMain) {
                    filterAndRender(GLB_RawData, value);
                    $("#PatDetailsSearchList").hide();
                } else {
                    AddPatientDetailsInSearList(value);
                    //$("#PatDetailsSearchList").show();
                }
            });

        });

        function onPatientSelected(selectedData) {
            if (FlagForSelPat == false) { FlagForSelPat = true; return false; }
            var CONSULTDT = "";
            if (selectedData["GENDER"] === "F") {
                selectedData["GENDER"] = "Female";
            }
            else if (selectedData["GENDER"] === "M") {
                selectedData["GENDER"] = "Male";
            }
            else if (selectedData["GENDER"] === "O") {
                selectedData["GENDER"] = "Other";
            }

            var dataobject = {
                PatEmail: selectedData["Email"],
                PatMRNO: selectedData["MRNO"],
                PatTRANNO: "",
                PatCompleted: "",
                PatAge: selectedData["AGE"],
                PatGender: selectedData["GENDER"],
                PatName: selectedData["NAME"],
                PatContokNo: "",
                OPDPatImgURL: selectedData["PatImageUrl"],
                OPDPatMobile: selectedData["MOBILENO"]
            };
            SetOPDPatInfoClick(true, dataobject);
            window.location.href = '../SinglePage/SinglePageOPD';
        }

        let currentRequest = null;

        function AddPatientDetailsInSearList(mrorname) {

            if (currentRequest) {
                currentRequest.abort(); // cancel previous request
            }

            startLoading("Loading", "loading-PatientSearchInfo");
            currentRequest = $.ajax({
                url: '../DoctorDesk/SearchNotAppointedPatients',
                data: { strMrName: mrorname },
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    PatSearchData = data || [];
                    renderPatSearchList(mrorname);
                    $("#PatDetailsSearchList").show();
                    stopLoading("loading-PatientSearchInfo");
                },
                complete: function () {
                    stopLoading("loading-PatientSearchInfo");
                     currentRequest = null;
                }
            });
        }


        /* ===================== Render Patient List ===================== */
        function renderPatSearchList() {
            var html = "";

            for (var i = 0; i < PatSearchData.length; i++) {
                var item = PatSearchData[i];
                html +=
                    '<div class="list-group-item PatientSearchInfo-row" ' +
                    'data-mrno="' + item.MRNO + '" ' +
                    'data-name="' + item.NAME + '" ' +
                    'data-age="' + item.AGE + '" ' +
                    'data-gender="' + item.GENDER + '" ' +
                    'data-patdob="' + item.PATDOB + '" ' +
                    'data-patemail="' + item.EMAIL + '" ' +
                    'data-patimg="' + item.PATIMAGE + '" ' +
                    'data-patmobileno="' + item.MOBILE + '" ' +
                    'style="cursor:pointer;">' +
                    item.NAME + ' (' + item.MRNO + ')' +
                    '</div>'
            }

            $("#PatDetailsSearchList").html(html ||
                '<div class="list-group-item text-muted">No records found</div>');
        }
        function debounce(fn, delay) {
            let timer;
            return function () {
                let context = this, args = arguments;
                clearTimeout(timer);
                timer = setTimeout(() => fn.apply(context, args), delay);
            };
        }

        function ResetOPDWaitingListData() {
            window.location.reload();
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

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

            <div class="col-md-2">
                <select class="form-select form-select-sm ddl_VisitPurpose" id="PatientDashboard_VisitPurpose">
                    <% foreach (var item in Model.VisitPurposeList)
                        { %>
                    <option value="<%= item.Value %>"><%= item.Text %></option>
                    <% } %>
                </select>
            </div>

            <div class="col-md-4 d-flex justify-content-center gap-3">
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

            <div class="col-md-3">
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control txt_Search" id="PatientDashboard_SearchInput" placeholder="Search For Patient">
                    <span class="input-group-text bg-white" id="OPDspanSearchPat"><i class="fa fa-search"></i></span>
                    <div style="margin-left: 6px;">
                        <svg xmlns="http://www.w3.org/2000/svg" style="height: 20px; width: 30px; cursor: pointer;" viewBox="0 0 640 640" onclick="ResetOPDWaitingListData();">
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
                        <div class="col-md-1 text-center">Token No. /<div class="">SR No.</div>
                        </div>


                        <div class="col-md-4">Patient Name</div>
                        <div class="col-md-2">Patient Category</div>
                        <div class="col-md-2">Purpose Of Visit</div>
                        <div class="col-md-1 d-none">Purpose of Visit Code</div>
                        <div class="col-md-2 d-none">Visit Type Code</div>
                        <div class="col-md-2 d-none">Review With Report</div>
                        <div class="col-md-1 text-center" style="overflow-wrap: normal;">Appointment Time</div>
                        <div class="col-md-1">Arrival Time</div>
                        <div class="col-md-1 ">Status</div>


                        <div class="col-md-2 d-none">Contact No.</div>
                    </div>
                    <div id="PatientDashboard_WaitingContainer" class="p-0 w-100"></div>
                </div>
            </div>
        </div>

        <div class="card mb-3 border-0 shadow-sm">
            <div class="card-header bg-completed-header d-flex justify-content-between align-items-center py-3 cursor-pointer">
                <h6 class="m-0 fw-bold" id="PatientDashboard_CollapseWaiting_completed">Completed Patient(s)</h6>
                <i class="fa fa-chevron-up transition-icon"></i>
            </div>
            <div id="PatientDashboard_CollapseCompleted" class="collapse show">
                <div class="card-body p-0">
                    <div class="row bg-light fw-bold p-2 border-bottom m-0 fs-7">
                        <div class="col-md-1 text-center">Token No. /<div class="">SR No.</div>
                        </div>

                        <div class="col-md-4">Patient Name</div>
                        <div class="col-md-2">Patient Category</div>
                        <div class="col-md-2">Purpose Of Visit</div>
                        <div class="col-md-2 d-none">Purpose of Visit Code</div>
                        <div class="col-md-2 d-none">Visit Type Code</div>
                        <div class="col-md-2 d-none">Review With Report</div>
                        <div class="col-md-1 text-center" style="overflow-wrap: normal;">Appointment Time</div>
                        <div class="col-md-1">Arrival Time</div>
                        <div class="col-md-1">Completion Time</div>


                        <div class="col-md-2 d-none">Contact No.</div>
                    </div>
                    <div id="PatientDashboard_CompletedContainer" class="p-0 w-100"></div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>