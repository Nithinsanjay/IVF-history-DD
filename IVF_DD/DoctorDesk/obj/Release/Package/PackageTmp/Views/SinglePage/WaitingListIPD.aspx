<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SinglePage.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.WaitingListIPD>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <%--Added By Abhishesh || 20260904--%>
    <link href="<%=ResolveUrl("~/plugins/select2/select2.css")%>" rel="stylesheet" />
    <script src="<%=ResolveUrl("~/plugins/select2/select2.full.min.js")%>"></script>
    <%--End--%>
    <style>
        /* Custom Colors based on IPD Screenshot */
        .bg-ipd-green {
            background-color: #d1fae5;
        }
        /* Light Cyan/Green */
        .bg-ipd-purple {
            background-color: #dbeafe;
        }
        /* Light Blue/Purple */
        .bg-header-gray {
            background-color: #f8f9fa;
            color: #333;
        }

        /* Typography & Spacing */
        .fs-7 {
            font-size: 0.85rem;
        }

        .fw-600 {
            font-weight: 600;
        }

        .cursor-pointer {
            cursor: pointer;
        }

        .avatar-img {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            object-fit: cover;
        }

        /* Transition for hover effects */
        .patient-row:hover {
            filter: brightness(0.95);
            transition: 0.2s;
            cursor: pointer;
        }

        /* Checkbox styling to match image colors */
        .chk-green:checked {
            background-color: #198754;
            border-color: #198754;
        }

        .chk-blue:checked {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }

        .bg-completed-header {
            background-color: #5cfc88;
            color: #333;
        }
        #IPDDoctorListDiv {
            position: relative;
        }
        #IPDNurseListDiv {
            position: relative;
        }
    </style>

    <script type="text/javascript">

        // 10. Global Variables
        var GLB_SelectedIPD_ID = "";

        // Store data globally to allow filtering/searching
        var GLB_IPDData = [];
        var FlagForSelPat = true;
        //window.onload = function () {
        //    SetIPDPatInfoClick(false, "");
        //};
        var IPDWaitListtimer = 0; //priyanka 23/04/2026
        $(document).ready(function (e) {
            //Abhishesh || select2 20260904
            $("#IPDDoctor_List").select2({
                width: '200px',
                closeOnSelect: true,
                dropdownParent: $("#IPDDoctorListDiv")
            });
            $("#IPDDashboard_NursingStation").select2({
                width: '200px',
                closeOnSelect: true,
                dropdownParent: $("#IPDNurseListDiv")
            });
            //End
            sessionStorage.setItem('TreatmentTranNo', "");
            GetDoctForIPDWaitingList(); //priyanka 01/04/2026
            if ('<%: Session["RMOYN"] ?? "" %>' == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y") {
                $(".ConsultYN").hide();
                $(".RMOYN").show();
                $("#IPDDashboard_ChkReferred").prop("checked", true);
                IPDWaitingList_FilterRecords();
            }
            else {
                $(".RMOYN").hide();
                $(".ConsultYN").show();
                $(".FlexDisply").css("display", "flex");
            }
            //end

            BindSessionSearchIPD();
            //SetIPDPatInfoClick(false, "");
            try {
                // Initialize Search Listener
                initSearchListener();


            } catch (err) {
                console.error("Error in document ready: " + err.message);
            }
            if (RefreshWithinSec && Number(RefreshWithinSec) > 0) {
                //priyanka 23/04/2026
                IPDWaitListtimer = 0;
                $("#timerLabelIPD").text("0 sec");

                setInterval(function () {
                    IPDWaitListtimer++;

                    $("#timerLabelIPD").text(IPDWaitListtimer + " sec");

                    if (IPDWaitListtimer === Number(RefreshWithinSec)) {
                        loadIPDPatientData();
                    }

                }, 1000);
            }
            //end
            $("#IPDDashboard_CaseType").on("change", function () {
                var selectedValue = $(this).val();
                IPDWaitingList_FilterRecords();
            });

            $("#IPDDashboard_ChkMyPatients,#IPDDashboard_ChkReferred").click(function () {
                IPDWaitingList_FilterRecords();
            });

            //Priyanka 01/04/2026
            //$("#IPDDoctor_List").on("change", function () {
            //    loadIPDPatientData();
            //});
            $("#IPDDoctor_List").on("select2:select", function (e) {
                var $this = $(this);
                $this.select2("close");
                setTimeout(function () {
                    $this.next(".select2-container")
                        .find(".select2-selection")
                        .blur();
                    document.activeElement.blur();
                    loadIPDPatientData();
                }, 100);
            });

            //Abhishesh || 20260904
            $("#IPDDashboard_NursingStation").on("change", function () {
                FilterByNursingStation();
            });
            //End

        });

        window.addEventListener('load', function () {
            SetIPDPatInfoClick(false, "");
        });

        window.addEventListener('pageshow', function (event) {
            if (event.persisted) { // page was loaded from cache
                SetIPDPatInfoClick(false, "");
            }
        });

        //Doctor Dropdown
        //function GetDoctForIPDWaitingList() {
        //    $.ajax({
        //        url: '../DoctorDesk/GetDoctors',
        //        type: 'post',
        //        datatype: 'json',
        //        data: { DoctName: "", Type: "P" },
        //        async: true,
        //        success: function (data) {
        //            var IPDWaitngLstDoctList = data == "" ? [] : data;
        //            BindIPDDoctorDropdown(IPDWaitngLstDoctList);
        //        }
        //    });
        //}

        //Abhishesh || 20260902
        //Doctor Dropdown
        function GetDoctForIPDWaitingList() {
            $.ajax({
                url: '../DoctorDesk/GetIPDAdmDoctors',
                type: 'post',
                datatype: 'json',
                data: { userid: gDoctId },
                async: true,
                success: function (data) {
                    var IPDWaitngLstDoctList = data == "" ? [] : data;
                    BindIPDDoctorDropdown(IPDWaitngLstDoctList);

                    var doctToSelect = "";
                    if (IPDWaitngLstDoctList.length === 1) {
                        doctToSelect = IPDWaitngLstDoctList[0].DoctCode;
                        $("#IPDDoctor_List").prop("disabled", true);
                    } else if (sessionStorage.getItem("IPCmbDoct")) {
                        doctToSelect = sessionStorage.getItem("IPCmbDoct");
                    }

                    if (doctToSelect) {
                        $("#IPDDoctor_List")
                            .val(doctToSelect)
                            .trigger('change.select2');

                        //$("#IPDDoctor_List").val(doctToSelect).trigger('change');
                    }
                    loadIPDPatientData();
                }
            });
        }
        //End
        function BindIPDDoctorDropdown(IPDWaitngLstDoctList) {
            var $ddl = $("#IPDDoctor_List");
            $ddl.empty();
            $ddl.append('<option value="">---All---</option>');
            $.each(IPDWaitngLstDoctList, function (i, item) {
                $ddl.append(
                    '<option value="' + item.DoctCode + '">' +
                    item.DoctName +
                    '</option>'
                );
            });
            $ddl.trigger('change.select2');
            //$ddl.trigger('change'); //Abhishesh || refresh select2 display
        }


        // --- SEARCH FUNCTIONALITY ---
        function initSearchListener() {
            //priyanka 06/03/2026
            $("#chkAllIPDPatLst").on("change", function () {
                IPDWaitListtimer = 0;
                if ($(this).is(':checked')) {
                    $("#lblIPDSelect img").css("opacity", "1.0");
                    var dataobject = {
                        SrchByDoctYN: "N"
                    }
                    SetShowAllPatList(true, dataobject);
                } else {
                    $("#lblIPDSelect img").css("opacity", "0.6");
                    var dataobject = {
                        SrchByDoctYN: "Y"
                    }
                    SetShowAllPatList(false, dataobject);
                }
                loadIPDPatientData();
            });
            //end


            $("#IPDDashboard_SearchInput").on("keyup", debounce(function () {
                IPDWaitListtimer = 0;
                var value = $(this).val().toLowerCase();
                // Filter IPD Patients
                // Checks: IP Number OR MR Number OR Patient Name
                var filteredData = GLB_IPDData.filter(function (item) {
                    return (item.IPNO.toLowerCase().indexOf(value) > -1) ||
                        (item.MRNO.toLowerCase().indexOf(value) > -1) ||
                        (item.PATNAME.toLowerCase().indexOf(value) > -1);

                });
                if (value.length < 3) {
                    $("#PatDetailsSearchListi").hide();
                    if (value == "") {
                        renderIPDList(filteredData, 'IPDDashboard_Container');
                        IPDWaitingList_FilterRecords();
                    } /*{ ResetOPDWaitingListData();}*/

                    return;
                }
                renderIPDList(filteredData, 'IPDDashboard_Container');
                // AddPatientDetailsInSearList(value);
                IPDWaitingList_FilterRecords();

            }, 400));
        }
        function debounce(fn, delay) {
            let timer;
            return function () {
                let context = this, args = arguments;
                clearTimeout(timer);
                timer = setTimeout(() => fn.apply(context, args), delay);
            };
        }
        function IPDWaitingList_FilterRecords() //Priyanka 07/01/2026
        {
            var count = 0;
            var SelectedCaseTypeID = $("#IPDDashboard_CaseType").val();
            $("#IPDDashboard_Container .row").each(function () {
                var CaseTypeCode = $(this).find("div:eq(11)").text().trim();
                var AdmnDoctCode = $(this).find("div:eq(10)").text().trim();
                if (SelectedCaseTypeID != "" && $("#IPDDashboard_ChkMyPatients").is(':checked') === false) {
                    if (CaseTypeCode === SelectedCaseTypeID) {
                        $(this).show(); count++;
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if (SelectedCaseTypeID != "" && $("#IPDDashboard_ChkMyPatients").is(':checked') === true) {
                    if (CaseTypeCode === SelectedCaseTypeID && AdmnDoctCode === gDoctCode) {
                        $(this).show(); count++;
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if ((SelectedCaseTypeID === "" || SelectedCaseTypeID === null) && $("#IPDDashboard_ChkMyPatients").is(':checked') === true && $("#IPDDashboard_ChkReferred").is(':checked') === false) {
                     if (AdmnDoctCode === gDoctCode) {
                        $(this).show(); count++;
                    }
                    else {
                        $(this).hide();
                    }
                }
                else if ((SelectedCaseTypeID === "" || SelectedCaseTypeID === null) && $("#IPDDashboard_ChkMyPatients").is(':checked') === true && $("#IPDDashboard_ChkReferred").is(':checked') === true) {
                    $(this).show(); count++;
                    //if (AdmnDoctCode === gDoctCode) {
                    //    $(this).show(); count++;
                    //}
                    //else {
                    //    $(this).hide();
                    //}
                }
                else if ((SelectedCaseTypeID === "" || SelectedCaseTypeID === null) && $("#IPDDashboard_ChkMyPatients").is(':checked') === false) {
                    $(this).show(); count++;
                }
                else {
                    $(this).hide();
                }
            });
            $("#PatientDashboard_CollapseWaiting_Ipd").text("(" + count + ") Patient List(s) ");

            var sn = 1;
            $('#IPDDashboard_Container .row:visible').each(function () {
                $(this).find('div:eq(0)').text(sn);
                sn++;
            });
        }

       function IPDWaitingList_FilterRecords() {
           var count = 0;
           var selectedCaseType = $("#IPDDashboard_CaseType").val();
           var showMy = $("#IPDDashboard_ChkMyPatients").is(':checked');
           var showRef = $("#IPDDashboard_ChkReferred").is(':checked');
       
           $("#IPDDashboard_Container .row").each(function () {
               //var caseTypeCode = $(this).find("div:eq(11)").text().trim();
               //var AdmittingDoct = $(this).find("div:eq(9)").text().trim();
               //var isMyPatient = (!AdmittingDoct || AdmittingDoct === ""); // My Patient
               //var isReferred = (AdmittingDoct && AdmittingDoct !== "");   // Referred Patient
               //Abhishesh 20260824
               var caseTypeCode = $(this).find("div:eq(11)").text().trim();
               var isReferred = ($(this).attr("data-isreferred") === "true"); // Referred Patient
               var isMyPatient = !isReferred; // My Patient
               //End
               var caseTypeMatch = (selectedCaseType === "" || selectedCaseType === null || caseTypeCode === selectedCaseType);
       
               // Set row background
               $(this).removeClass("bg-ipd-purple bg-ipd-green");
               if (isMyPatient) {
                   $(this).addClass("bg-ipd-green");
               } else if (isReferred) {
                   $(this).addClass("bg-ipd-purple");
               }
       
               // Show/hide row based on checkboxes
               if ((showMy && isMyPatient && caseTypeMatch) ||
                   (showRef && isReferred && caseTypeMatch)) {
                   $(this).show();
                   count++;
               } else {
                   $(this).hide();
               }
           });
       
           $("#PatientDashboard_CollapseWaiting_Ipd").text("(" + count + ") Patient List(s)");
       
           // Renumber visible rows
           var sn = 1;
           $('#IPDDashboard_Container .row:visible').each(function () {
               $(this).find('div:eq(0)').text(sn);
               sn++;
           });
       }
       
       function ResetOPDWaitingListData() {
           window.location.reload();
       }
       $('#OPDspanSearchPat').click(function (e) {
            SetIPDPatSearch(false, "");   
           IPDWaitingList_FilterRecords();
       });
       // --- DATA LOADING ---
        function loadIPDPatientData() {
            var FrmdateA = "14/12/2025";
            var ToDateA = "07/01/2026";
            var IPNoA = "";
            var MRNOA = "";
            var PAtNameA = "";
            var nursingSta = "";
            var StatusA = "A";
            var strSrchByDoctYN = $("#chkAllIPDPatLst").is(':checked') === true ? "Y" : "N"; //priyanka 06/03/2026
            var strDoctCode = $("#IPDDoctor_List").val(); //priyanka 01/04/2026
            if (('<%: Session["RMOYN"] ?? "" %>' == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y") && strDoctCode == "") {
                strSrchByDoctYN = "Y"
            }
            $("#IPDDashboard_Container").html('<div class="text-center p-3 text-primary"><i class="fa fa-spinner fa-spin"></i> Loading...</div>');
            $("#IPDDashboard_Container").html('');
            startLoading("Loading");
            $.ajax({
                url: "../SinglePage/GetAdmissionFrmList",
                type: 'post',
                dataType: 'json',
                data: {
                    FrmdateA: FrmdateA,
                    ToDateA: ToDateA,
                    IPNoA: IPNoA,
                    MRNOA: MRNOA,
                    PAtNameA: PAtNameA,
                    nursingSta: nursingSta,
                    StatusA: StatusA,
                    strSrchByDoctYN: strSrchByDoctYN,
                    strDoctCode: strDoctCode //priyanka 01/04/2026
                },
                success: function (response) {
                    if (response.rows && response.rows.length > 0) {
                        GLB_IPDData = response.rows;
                        renderIPDList(GLB_IPDData, 'IPDDashboard_Container');
                        //IPDWaitingList_FilterRecords();
                        ApplySavedIPDFilters();
                    } else {
                        renderEmptyState();
                    }
                    LoadNursingStationDropdown(response.nursList || []);
                    IPDWaitListtimer = 0;
                    stopLoading();
                },
                error: function (xhr, textStatus, errorThrown) {
                    //console.error("AJAX Error:", errorThrown);
                    ToastMsg(textStatus, "error");
                    $("#IPDDashboard_Container").html('<div class="p-3 text-center text-danger">Error loading data.</div>');
                    stopLoading();
                }
            });
            //}
            //catch (err) {
            //    stopLoading();
            //    ToastMsg("Error loading IPD data", "error");
            //    console.error(err);
            //}
        }
        //Added By Abhishesh || 20260902
        function ApplySavedIPDFilters() {
            if (!GLB_IPDData || GLB_IPDData.length === 0) return;
            var savedSearchTxt = sessionStorage.getItem("IPSearchTxt") || "";
            var savedNursStation = sessionStorage.getItem("IPNursStation") || "";
            var filteredData = GLB_IPDData;
            if (savedNursStation) {
                filteredData = filteredData.filter(function (item) {
                    return ("" + item.NURSCODE).trim() === savedNursStation;
                });
            }
            if (savedSearchTxt) {
                var value = savedSearchTxt.toLowerCase();
                filteredData = filteredData.filter(function (item) {
                    return (item.IPNO.toLowerCase().indexOf(value) > -1) ||
                        (item.MRNO.toLowerCase().indexOf(value) > -1) ||
                        (item.PATNAME.toLowerCase().indexOf(value) > -1);
                });
            }
            renderIPDList(filteredData, 'IPDDashboard_Container');
            IPDWaitingList_FilterRecords();
        }

        function LoadNursingStationDropdown(list) {
            var $ddl = $("#IPDDashboard_NursingStation");
            $ddl.empty();
            $ddl.append('<option value="">---All Nursing Station---</option>');
            $.each(list, function (i, item) {
                $ddl.append('<option value="' + item.Value + '">' + item.Text + '</option>');
            });
            if (sessionStorage.getItem("IPNursStation")) {
                $ddl.val(sessionStorage.getItem("IPNursStation"));
            }
            $ddl.trigger('change'); 
        }

        function FilterByNursingStation() {
            var selectedStation = $("#IPDDashboard_NursingStation").val();
            var filteredData = !selectedStation ? GLB_IPDData : GLB_IPDData.filter(function (item) {
                return ("" + item.NURSCODE).trim() === selectedStation;
            });
            renderIPDList(filteredData, 'IPDDashboard_Container');
            IPDWaitingList_FilterRecords();
        }
        //End
        // --- RENDERING FUNCTION ---

        function renderEmptyState() {
            var emptyHtml = '<div class="p-3 text-center text-muted">No records found</div>';
            $("#IPDDashboard_Container").html(emptyHtml);
            $("#IPDDashboard_Container").html(emptyHtml);
        }
        function formatDoctorName(name) {
            if (!name || name.trim() === "") return "";
            return name.split(',')
                .map(function (n) {
                    var trimmed = n.trim();
                    if (trimmed === "") return "";
                    if (trimmed.toLowerCase() === "system") return trimmed; // NEW: skip "Dr." for System
                    return "Dr. " + trimmed;
                })
                .filter(function (n) { return n !== ""; })
                .join(", ");
        }
 
        function renderIPDList(data, containerId) {
            try {
                var container = $("#" + containerId);
                container.empty();
        
                if (!data || data.length === 0) {
                    container.append('<div class="p-3 text-center text-muted">No records found</div>');
                    return;
                }
        
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    var dataStr = encodeURIComponent(JSON.stringify(item));
        
                    // Set color based on ADMNDOCTNM
                    //var rowColorClass = (!item.ADMNDOCTNM || item.ADMNDOCTNM.trim() === "")
                    //    ? "bg-ipd-green"   // My Patient
                    //    : "bg-ipd-purple"; // Referred Doctor
                   //Abhishesh || 20260824
                    var rowColorClass = (!item.IsReferred)
                        ? "bg-ipd-green"   // My Patient
                        : "bg-ipd-purple"; // Referred Doctor
                        //End
        
                    var html = ''
                        + '<div class="row m-0 align-items-center p-2 mb-0 border-bottom '
                        + rowColorClass
                        //+ ' patient-row div_IPDRow" onclick="getPatientInfo(\'' + dataStr + '\', \'IPDWAITING\')">'
                        // Abhishesh || 20260824
                        + ' patient-row div_IPDRow" data-isreferred="' + item.IsReferred + '" onclick="getPatientInfo(\'' + dataStr + '\', \'IPDWAITING\')">'
                        //End
                        + '<div class="col-md-1 text-center">' + (i + 1) + '</div>'
                        + '<div class="col-md-1 text-break small" style="white-space: nowrap;">' + item.IPNO + '</div>'
                        + '<div class="col-md-4 d-flex align-items-center" title="' + item.PATNAME + '">'
                        + '<img src="' + item.GetPatientImageBase64 + '" alt="Patient Image" class="img-fluid rounded-circle" style="height:40px; width:40px;" />'
                        + '<div class="ms-2 flex-grow-1 overflow-hidden">'
                        + '<div class="fw-bold text-truncate">' + item.PATNAME + '</div>'
                        + '<div class="text-muted small fw-bold text-truncate">' + item.MRNO + ' | ' + item.PATAGE + ' | ' + item.Gender + '</div>'
                        + '</div>'
                        + '</div>'
                        + '<div class="col-md-1 small">' + item.CURRBEDNO + ' | ' + item.WARDNM + '</div>'
                        + '<div class="col-md-1 small text-truncate" title="' + item.NURSTNM + '">' + item.NURSTNM + '</div>'
                        + '<div class="col-md-2 small text-truncate" title="' + item.PATCATGNM + '">' + item.PATCATGNM + '</div>'
                        + '<div class="col-md-2 small">' + item.ADMNDOCTNM + '</div>'
                        + '<div class="col-md-1 small text-end d-none">' + item.ADMNDOCT + '</div>'
                        + '<div class="col-md-1 small text-end d-none">' + item.CASETYPECD + '</div>'
                        + '<div class="col-md-1 small text-end d-none">' + item.CASETYPECDValue + '</div>'
                        + '</div>';
        
                    container.append(html);
                }
                $("#PatientDashboard_CollapseWaiting_Ipd").text("(" + data.length + ") Patient List(s) ");
            } catch (err) {
                console.error("Render Error: " + err.message);
            }
        }

        let currentRequest = null;

        // --- NAVIGATION / ACTIONS ---
        function getPatientInfo(encodedItem, type) {
            try {

                if (FlagForSelPat == false) { FlagForSelPat = true; return false; }
                var item = JSON.parse(decodeURIComponent(encodedItem));

                var dataobject = {
                    IPPatName: item.PATNAME,
                    IPPatIPNO: item.IPNO,
                    IPPatAge: item.PATAGE,
                    IPPatGender: item.Gender,
                    IPPatMRNO: item.MRNO,
                    IPPatWard: item.WARDNM,
                    IPPatNurstaionNM: item.NURSTNM,
                    IPPatBedNo: item.CURRBEDNO,
                    IPPatAdmnDoctCode: item.ADMNDOCT,
                    IPPatCaseTypeID: item.CASETYPECD,
                    IPDPatImgURL: item.GetPatientImageBase64,
                    IPDADMNDATETIME: (item.ADMNDATE + "/" + item.ADMNTIME),  //10/03/2024/10:04:00 PM"
                    IPDADMNDATE: item.ADMNDATE,
                    IPDCompCode: item.IPDCompCode, //priyanka 04/05/2026
                    IPDCompNM: item.IPDCompNM //priyanka 04/05/2026
                };

                //const patientInfoObj = {
                //    MRNO: mrno,
                //    CONSULTATION_NO: consultationNo,
                //    PATIENT_NAME: patname
                //};

                // Call Master/Global function
                if (typeof SetIPDPatInfoClick === "function") {
                    SetIPDPatInfoClick(true, dataobject);
                }
                var Srchdataobject = {
                    IPCmbDoct: $("#IPDDoctor_List").val(),
                    IPAllPat: $("#chkAllIPDPatLst").is(':checked') === true ? "Y" : "N",
                    IPMyPat: $("#IPDDashboard_ChkMyPatients").is(':checked') ? "Y" : "N",
                    IPRefPat: $("#IPDDashboard_ChkReferred").is(':checked') ? "Y" : "N",
                    IPSearchTxt: $("#IPDDashboard_SearchInput").val(),          //Abhishesh || 20260902
                    IPNursStation: $("#IPDDashboard_NursingStation").val()      //Abhishesh || 20260902
                };
                SetIPDPatSearch(true, Srchdataobject);
                redirectToPatientInfo();
            } catch (err) {
                console.error("Error in getPatientInfo: " + err.message);
            }
        }

        function BindSessionSearchIPD() {
            if (sessionStorage.getItem("IPCmbDoct")) {
                $("#IPDDoctor_List").val(sessionStorage.getItem("IPCmbDoct"));
            }
            //Abhishesh || 20260902 - restore actual checked/unchecked state, not just "Y"
            if (sessionStorage.getItem("IPMyPat") !== null) {
                $("#IPDDashboard_ChkMyPatients").prop("checked", sessionStorage.getItem("IPMyPat") == "Y");
            }
            if (sessionStorage.getItem("IPRefPat") !== null) {
                $("#IPDDashboard_ChkReferred").prop("checked", sessionStorage.getItem("IPRefPat") == "Y");
            }
            if (sessionStorage.getItem("IPAllPat") == "Y") {
                $("#chkAllIPDPatLst").prop("checked", true);
                $("#lblIPDSelect img").css("opacity", "1.0");
            }
            if (sessionStorage.getItem("IPSearchTxt")) {
                $("#IPDDashboard_SearchInput").val(sessionStorage.getItem("IPSearchTxt"));
            }
            //End
            //else {
            //    loadIPDPatientData();
            //}
        }

        function redirectToPatientInfo() {
            try {
                sessionStorage.removeItem("scrollPos");
                window.location.href = '../SinglePage/SinglePageIPD';
            } catch (err) {
                console.error(err);
            }
        }

        // Back click redirect
        document.getElementById("IPDDashboard_BackBtn").addEventListener("click", function () {
            SetIPDPatSearch(false, ""); 
            window.location.href = "../SinglePage/SinglePageMenuList";
        });

        // Placeholders 
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
                    $("#PatDetailsSearchListi").show();
                    stopLoading("loading-PatientSearchInfo");
                },
                complete: function () {
                    stopLoading("loading-PatientSearchInfo");
                    currentRequest = null;
                }
            });
        } 

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

     $("#PatDetailsSearchListi").html(html ||
         '<div class="list-group-item text-muted">No records found</div>');
 }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <div class="container-fluid p-3">

        <div class="row mb-3 align-items-center bg-white p-2 shadow-sm rounded">
            <div class="col-md-1 d-flex align-items-center">
                <button class="btn btn-link text-dark p-0 me-2 btn_Back" id="IPDDashboard_BackBtn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0" />
                    </svg>
                    Back
                </button>
            </div>

            <div class="col-md-1 ConsultYN">
                <div class="input-group" id="AllPatListChkDivMain">
                    <input type="checkbox" style="display: none;" id="chkAllIPDPatLst">
                    <label class="lblImg" id="lblIPDSelect" style="border: 1px solid #c3c1c1;padding: 5px;cursor: pointer" title="Show all patient" for="chkAllIPDPatLst">
                        <img class="lblImage" src="../Images/patient.png" style="width: 25px; height: 25px; opacity: 0.6" alt="P">
                    </label>
                </div>
            </div>
            <%= Html.DropDownList("CaseType", Model.CaseTypeList, "---Select---", new { id = "IPDDashboard_CaseType", @class = "form-select form-select-sm ddl_CaseType", @style="display:none;" }) %>
            <div class="col-md-2 align-items-center gap-2 RMOYN" id="IPDDoctorListDiv">
                <label class="fw-bold fs-7 mb-0" id="IPDDoctorList_Label">Doctors</label>
                <%--Abhishesh || 20260904--%>
                <select id="IPDDoctor_List" style="width: 180px;">
                    <option value="">---All Doctor---</option>
                </select>
                <%--End--%>
            </div>

            <div class="col-md-2 align-items-center gap-2" id="IPDNurseListDiv">
                <label class="fw-bold fs-7 mb-0" id="IPDNurseList_Label">Nurs. Station</label>
                <select id="IPDDashboard_NursingStation" style="width: 180px;">
                    <option value="">---All Nursing Station---</option>
                </select>
            </div>

            <div class="col-md-5 justify-content-center gap-4 ConsultYN FlexDisply" id="IPDRadioBtnDivMain">
                <div class="form-check">
                    <input class="form-check-input chk-green" type="checkbox" id="IPDDashboard_ChkMyPatients" checked>
                    <label class="form-check-label text-success fw-bold" for="IPDDashboard_ChkMyPatients">My Patients</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input chk-blue" type="checkbox" id="IPDDashboard_ChkReferred">
                    <label class="form-check-label text-primary fw-bold" for="IPDDashboard_ChkReferred">Referred Patients</label>
                </div>
            </div>

            <div class="col-md-3" id="SrchofPatDivMain">
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control txt_Search" id="IPDDashboard_SearchInput" autocomplete="off" placeholder="Search For Patient">
                    <span class="input-group-text bg-white" id="OPDspanSearchPat"><i class="fa fa-search"></i></span>
                    <div style="margin-left: 6px;">
                        <svg xmlns="http://www.w3.org/2000/svg" style="height: 20px; width: 30px; cursor: pointer;" viewBox="0 0 640 640" onclick="ResetOPDWaitingListData();">
                            <path d="M129.9 292.5C143.2 199.5 223.3 128 320 128C373 128 421 149.5 455.8 184.2C456 184.4 456.2 184.6 456.4 184.8L464 192L416.1 192C398.4 192 384.1 206.3 384.1 224C384.1 241.7 398.4 256 416.1 256L544.1 256C561.8 256 576.1 241.7 576.1 224L576.1 96C576.1 78.3 561.8 64 544.1 64C526.4 64 512.1 78.3 512.1 96L512.1 149.4L500.8 138.7C454.5 92.6 390.5 64 320 64C191 64 84.3 159.4 66.6 283.5C64.1 301 76.2 317.2 93.7 319.7C111.2 322.2 127.4 310 129.9 292.6zM573.4 356.5C575.9 339 563.7 322.8 546.3 320.3C528.9 317.8 512.6 330 510.1 347.4C496.8 440.4 416.7 511.9 320 511.9C267 511.9 219 490.4 184.2 455.7C184 455.5 183.8 455.3 183.6 455.1L176 447.9L223.9 447.9C241.6 447.9 255.9 433.6 255.9 415.9C255.9 398.2 241.6 383.9 223.9 383.9L96 384C87.5 384 79.3 387.4 73.3 393.5C67.3 399.6 63.9 407.7 64 416.3L65 543.3C65.1 561 79.6 575.2 97.3 575C115 574.8 129.2 560.4 129 542.7L128.6 491.2L139.3 501.3C185.6 547.4 249.5 576 320 576C449 576 555.7 480.6 573.4 356.5z" />
                        </svg>
                    </div>
                </div>
                <div id="PatSearchDetailsMainDivi">
                    <div id="PatDetailsSearchListi" class=" list-group position-absolute" style="z-index: 1000; max-height: 200px; overflow-y: auto; display: none; background: white; border: 1px solid #ccc;">
                    </div>
                    <div id="loading-PatientSearchInfo" class="loading-screen" style="display: none; opacity: 0;">
                    </div>
                </div>
                <span id="timerLabelIPD" style="display:none;">0</span> 
            </div>
        </div>

        <div class="card border-0 shadow-sm">
            <div class="card-header bg-completed-header d-flex justify-content-between align-items-center py-3 cursor-pointer">
                <h6 class="m-0 fw-bold" id="PatientDashboard_CollapseWaiting_Ipd">Patient List(s)</h6>
            </div>
            <div class="card-body p-0">
                <div class="row bg-header-gray fw-bold p-2 border-bottom m-0 fs-7">
                    <div class="col-md-1 text-center">SR No.</div>
                    <div class="col-md-1">IP No.</div>
                    <div class="col-md-4">Patient Name</div>
                    <div class="col-md-1">Bed No. / Ward</div>
                    <div class="col-md-1">Nursing Station</div>
                    <div class="col-md-2">Category</div>
                    <div class="col-md-2" id="IPDReferredDoctorHeader">Admitting,Consultant / Referral Doctor</div>
                    <div class="col-md-1 text-end d-none">Admission Doctor Id</div>
                    <div class="col-md-1 text-end d-none">Case Type Id</div>
                    <div class="col-md-1 text-end d-none">Case type</div>
                </div>
                <div id="IPDDashboard_Container" class="p-0 w-100">
                </div>
            </div>
        </div>
    </div>

</asp:Content>