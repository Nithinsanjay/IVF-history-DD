<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style type="text/css">

    .MaxMinpopup-body{
        padding : 0px;
    }
    #searchOptions .option-item {
        padding: 6px 10px;
        cursor: pointer;
    }

        #searchOptions .option-item:hover {
            background-color: #f1f3f5;
        }

    
    #ui-datepicker-div.ui-datepicker ui-widget {
        position: absolute;
        top: 92px;
        left: 343.656px;
        z-index: 1000;
        display: block;
        font-size: 14px;
        z-index: 1000;
    }

  /* Specific row highlight */
    .highlight-row {
        background-color: #fff3cd !important; /* The yellow shade from your screenshot */
        outline: 1px solid #ffeeba;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    /* Style for the search dropdown results */
    .search-item:hover {
        background-color: #007bff;
        color: white;
    }

    #searchOptions {
        box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        border: 1px solid #ddd;
    }
</style>


<script type="text/javascript">
    var rptType = "";
    var IsbarType = "";
    var dateConfig = "";
    var s = "";
    var ServerTime = '<%=  ViewBag.ServerTime %>';
    var ServerDate = '<%=  ViewBag.ServerDate %>';
    var icuStatus = ""; <%--'<%= Session["ICUNSYN"].ToString().ToUpper() ?? "N" %>';--%>
    var chkInvstg = "";
    var rbtnprogn = "";
    var prbmlst = "";
    var Formname = "";
    var urlName = "";
    var gUnitCode = '<%: Session["UNITCODE"] ?? ""%>';
    $(document).ready(function () {
        //debugger;
        SetDateTime();
        $("#TISS28Score").change(function () {
            if (icuStatus != "Y") {
                ToastMsg("Tiss Acuity Scoring is only allowed for ICU patients.", "warning");
                $("#TISS28Score1").prop('checked', true);
                return false;
            }
            rbtnchange();
        });

        $("#TISS28Score1").change(function () {
            if (icuStatus == "Y") {
                ToastMsg("Patient Acuity Score is not allowed for ICU patients.", "warning");
                $("#TISS28Score").prop('checked', true);
                return false;
            }
            rbtnchange();
        });
        $('#btnDisplayEMRRecordsBtn').click(PrintICUReport);

        $('#Nurse, #RMO, #consultant').prop('disabled', true);
        FormName = "Reports";
        $('#Rptdate').attr('readonly', true);
        $('#Rptdate1').attr('readonly', true);


        document.getElementById("TimeLabel").style.display = 'none';
        document.getElementById('Time').style.display = "none";

        //var timeLabel1 = document.getElementById("TimeLabel1");
        //if (timeLabel1) timeLabel1.style.display = 'none';
        //var isbarYTime = document.getElementById('IsbarYTime');
        //if (isbarYTime) isbarYTime.style.display = "none";

        $('#FrmTime').hide();
        $('#ToTime').hide();
        $('#ShiftTm').hide();
        var Time = new Date();
        CuurentTime = Time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
        $('#txtFrmTime').val(CuurentTime);
        var time = CuurentTime.split(':');
        if (time[0] < 10)
            time[0] = '0' + time[0];
        var timespan = time[1].split(' ');
        $('#txtToTime').val(time[0] + ":" + timespan[0]);

        $('#ISBAR').click(function () {
            GetIsbarYTimeSlots("ISBAR");
        });

        $('#NursngAssesmnt').click(function () {
            GetIsbarYTimeSlots("NURSASSMNT");
        });

        $('#ISBARDR').click(function () {
            GetIsbarYTimeSlots("ISBARDR");
        });

        $('#Rptdate').change(function () {
            if ($('#ISBAR').prop('checked'))
                GetIsbarYTimeSlots("ISBAR");
            else if ($('#NursngAssesmnt').prop('checked'))
                GetIsbarYTimeSlots("NURSASSMNT");
            else if ($('#ISBARDR').prop('checked'))
                GetIsbarYTimeSlots("ISBARDR");
        });

        $('#txtFrmTime').timepicker({
            timeFormat: 'hh:mm TT',
            onClose: function () {
            }
        });
        $('#txtToTime').timepicker({
            timeFormat: 'hh:mm TT',
            onClose: function () {
            }
        });

        $('#InvestReport').change(function () {
            if (this.checked) {
                $('#chkInvstg').prop('checked', true);
                chkInvstg = "ALL";
            }
            else {
                chkInvstg = "D";
            }
        });

        $('#chkInvstg').attr('disabled', 'disabled');
        $(".EmpLst").hide();

        $('#Rptdate').change(function () {
            var ipno = sessionStorage.getItem("IPPatIPNO");
            if (ipno === '') {
                alert("IPNO cannot be empty!"); 
                return;
            }
            fetchProblemList();
        });
        $('#Rptdate1').change(function () {
            var ipno = sessionStorage.getItem("IPPatIPNO");
            if (ipno === '') {
                alert("IPNO cannot be empty!");
                return;
            }
            fetchProblemList();

        });
        $('#txtFrmTime').change(function () {
            var ipno = sessionStorage.getItem("IPPatIPNO");
            if (ipno === '') {
                alert("IPNO cannot be empty!");
                return;
            }
            fetchProblemList();

        });
        $('#txtToTime').change(function () {
            var ipno = sessionStorage.getItem("IPPatIPNO");
            if (ipno === '') {
                alert("IPNO cannot be empty!");
                return;
            }
            fetchProblemList();
        });

        var reportNames = [];

        $(".Maintable label").each(function () {
            var labelText = $(this).text().trim();
            if (labelText) {
                reportNames.push(labelText);
            }
        });

        var reportList = $("#reportList");
        reportNames.forEach(function (name) {
            reportList.append("<li style='cursor:pointer; padding:5px;' onclick='selectReport(this)'>" + name + "</li>");
        });

        $("#txtReportSearch").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#reportList").toggle(value.length > 0); // Show list if input is not empty

            $("#reportList li").each(function () {
                $(this).toggle($(this).text().toLowerCase().includes(value));
            });
        });

        //*********************************************//
        const $searchInput = $('#txtSearchReport');
        const $optionsContainer = $('#searchOptions');

        $searchInput.on('input', function () {
            const query = $(this).val().toLowerCase();
            $optionsContainer.empty().hide();

            if (query.length === 0) return;

            $('.Maintable label.form-check-label').each(function () {
                const text = $(this).text().trim();
                const id = $(this).attr('for');

                if (text.toLowerCase().includes(query)) {
                    const item = $(`<div class="p-2 search-item" style="cursor:pointer; border-bottom: 1px solid #eee;">${text}</div>`);

                    item.on('click', function () {
                        $searchInput.val(text);
                        $optionsContainer.hide();
                        highlightRow(id);
                    });

                    $optionsContainer.append(item);
                }
            });

            if ($optionsContainer.children().length > 0) {
                $optionsContainer.show();
            }
        });

        function highlightRow(elementId) {
            $('.highlight-row').removeClass('highlight-row');

            const $targetInput = $('#' + elementId);
            const $row = $targetInput.closest('.form-check, .d-flex');

            $row.addClass('highlight-row');
            $targetInput.prop('checked', true).trigger('change');
            $row[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        $(document).on('click', function (e) {
            if (!$(e.target).closest('.position-relative').length) {
                $optionsContainer.hide();
            }
        });

    });//end of ready function

    function rbtnchange() {
        document.getElementById("Rptdate").style.display = 'none';
        document.getElementById("DATE").style.display = 'none';
        document.getElementById("Rptdate1").style.display = 'none';
        document.getElementById("DATE1").style.display = 'none';
        document.getElementById("TimeLabel").style.display = 'none';
        document.getElementById('Time').style.display = 'none';
        document.getElementById("TimeLabel1").style.display = 'none';
        document.getElementById('IsbarYTime').style.display = "none";
        document.getElementById("cmbBundleType").style.display = 'none';
        document.getElementById("cmbPBundleType").style.display = 'none';
        document.getElementById("lblBundletype").style.display = 'none';
        $('#FrmTime').hide();
        $('#ToTime').hide();
        $('#ShiftTm').hide();
        $(".EmpLst").hide();
        $('#Nurse, #RMO, #Consultant').prop('disabled', true).prop('checked', false);
        if ($('#CriticalCare').prop('checked') || $('#TreatmentSheetAdminst').prop('checked') || $('#TreatmentSheetMedRemark').prop('checked') ||
            $('#rbtnCriticalAssmnt2').prop('checked') || $('#RespAss').prop('checked') || $('#InvestReport').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
        }
        if ($('#ProgrNot').prop('checked') || $('#NursingNotes').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            document.getElementById("Rptdate1").style.display = 'inline';
            document.getElementById("FrmTime").style.display = 'inline';
            document.getElementById("ToTime").style.display = 'inline';
            if ($('#NursingNotes').prop('checked')) {
                $('#FrmTime').val("12:00 AM");
                fetchProblemList();
            }
            if ($('#ProgrNot').prop('checked')) {
                $('#Nurse, #RMO, #Consultant').prop('disabled', false);
            }
        }
        if ($('#rbtnPrphlBndleChkLst').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            document.getElementById("TimeLabel").style.display = 'inline';
            document.getElementById("Time").style.display = 'inline';
            document.getElementById("lblBundletype").style.display = 'inline';
            document.getElementById("cmbPBundleType").style.display = 'inline';
            $('#ShiftTm').show();
            //Combo Binding Function Time
        }

        if ($('#NursngAssesmnt').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            document.getElementById("TimeLabel").style.display = 'inline';
            document.getElementById("Time").style.display = 'inline';
            //Combo Binding Function Time
        }

        if ($('#BundleChkList').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            document.getElementById("Rptdate1").style.display = 'inline';
            $('#ShiftTm').show();
        }

        if ($('#TISS28Score').prop('checked') || $('#TISS28Score1').prop('checked') || $('#TISS28Score2').prop('checked') || $('#DiacomImg').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
        }

        if ($('#DiabeticChart').prop('checked') || $('#rbtnBradenScore').prop('checked') || $('#rbtnHourlyChart').prop('checked')
            || $('#PainChart').prop('checked') || $('#PainChartUnCons').prop('checked') || $("#MAEAAudit").prop('checked')
            || $("#CNDAAudit").prop('checked') || $("#PMAAudit").prop('checked') || $("#Assesmentexcel").prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            document.getElementById("Rptdate1").style.display = 'inline';
        }

        if ($('#ISBARDR').prop('checked') || $('#ISBAR').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            $('#ShiftTm').show();
        }

        if ($('#ISBARDR').prop('checked') || $('#ISBAR').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            $('#ShiftTm').show();
        }

        if ($('#SIIPAudit').prop('checked') || $('#CSNPAudit').prop('checked')) {
            document.getElementById("Rptdate").style.display = 'inline';
            document.getElementById("DATE").style.display = 'inline';
            document.getElementById("Rptdate1").style.display = 'inline';
            $(".EmpLst").show();
        }
    }

    function SetDateTime() {
        //debugger;
        $("#Rptdate").val(ServerDate);
        $("#Rptdate1").val(ServerDate);
        $("#Rptdate").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            minDate: new Date(),
        });

        $("#Rptdate1").datepicker({
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            maxDate: new Date(),
        });

        MinDate();
        $('#Time').val(ServerTime);
        var ServTM = ServerTime.substring(0, ServerTime.indexOf(":"));
        var hh = ServTM;
        var dd = "AM";
        var h = hh;
        if (h >= 12) {
            h = hh - 12;
            dd = "PM";
        }
        if (h == 0) {
            h = 12;
        }
        var replacement = h;
        replacement += " " + dd;
        $('#Time').val(replacement);
        $("#ShiftTime").val("M");
    }

    function SetDateTimeForChkLst() {
        $("#Rptdate").datepicker("destroy");
        $("#Rptdate1").datepicker("destroy");

        $("#Rptdate").val(ServerDate);
        $("#Rptdate1").val(ServerDate);
        $("#Rptdate").datepicker(
            {
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });

        $("#Rptdate1").datepicker(
            {
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });
        MinDate();
    }

    function MinDate() {
        var admnDt = sessionStorage.getItem("IPDADMNDATE");
        var DisDt = ''; 
        if (admnDt && admnDt.length >= 10) {
            var dd = admnDt.substring(0, 2);
            var MM = admnDt.substring(3, 5);
            var yyyy = admnDt.substring(6, 10);
            var date1 = new Date(yyyy + "-" + MM + "-" + dd);

            date1.setDate(date1.getDate() - 1);
            $("#Rptdate").datepicker("option", "minDate", date1);
            $("#Rptdate1").datepicker("option", "minDate", date1);
        }

        if (DisDt && DisDt.length >= 10) {
            var enddd = DisDt.substring(0, 2);
            var endMM = DisDt.substring(3, 5);
            var endyyyy = DisDt.substring(6, 10);

            var date2 = new Date(endyyyy + "-" + endMM + "-" + enddd);

            $("#Rptdate").datepicker("option", "maxDate", date2);
            $("#Rptdate1").datepicker("option", "maxDate", date2);
        } else {
            $("#Rptdate").datepicker("option", "maxDate", new Date());
            $("#Rptdate1").datepicker("option", "maxDate", new Date());
        }
    }

    function changeAudit() {
        $("#EmpLst").val("");
        $('#Time, #IsbarYTime, #cmbBundleType, #cmbPBundleType, #FrmTime, #ToTime, #ShiftTime, #ShiftTm, #TimeLabel, #TimeLabel1').hide();
        $("#Rptdate").show();
        $("#Rptdate1").show();
        ShowHideEmpLst();
    }

    function ShowHideEmpLst() {

        $(".EmpLst").hide();
        const selectedAudit = document.querySelector('input[name="icu"]:checked');
        var stripno = sessionStorage.getItem("IPPatIPNO");
        if (!selectedAudit) return;

        switch (selectedAudit.id) {
            case "SIIPAudit":
                $(".EmpLst").show();
                $("#Rptdate").val(ServerDate);
                $("#Rptdate1").val(ServerDate);
                SetDateTimeForChkLst();
                break;
            case "MAEAAudit":
                $(".EmpLst").hide();
                $("#Rptdate").val(ServerDate);
                $("#Rptdate1").val(ServerDate);
                SetDateTimeForChkLst();
                break;
            case "PMAAudit":
                $(".EmpLst").hide();
                $("#Rptdate").val(ServerDate);
                $("#Rptdate1").val(ServerDate);
              
                SetDateTimeForChkLst();
                break;
            case "CSNPAudit":
                $(".EmpLst").show();
                $("#Rptdate").val(ServerDate);
                $("#Rptdate1").val(ServerDate);
              
                SetDateTimeForChkLst();
                break;
            case "CNDAAudit":
                $(".EmpLst").hide();
                $("#Rptdate").val(ServerDate);
                $("#Rptdate1").val(ServerDate);
                SetDateTimeForChkLst();
                break;
            default:
                $(".EmpLst").hide();
                break;
        }
    }

    function fetchProblemList() {
        var strIPNO = sessionStorage.getItem("IPPatIPNO");
        var strMrNo = sessionStorage.getItem("IPPatMRNO");
        var strDate = $("#Rptdate").val();
        var strToDt = $("#Rptdate1").val();
        var strTime = $('#txtFrmTime').val();
        var strToTime = $('#txtToTime').val();
        var ProblemCode = "";
        var CloseYN = "";
        $.ajax({
            url: '../SinglePage/GetProblemList?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&strToTime=' + strToTime + '&&strToDt=' + strToDt + '&&strproblemcd=' + ProblemCode + '&&CloseYN=' + CloseYN,
            type: 'POST',
            dataType: 'json',
            success: function (response) {
                var $dropdown = $("#Problist");
                $dropdown.empty();
                $dropdown.append('<option value="">---Select---</option>');

                if (response && response.length > 0) {
                    $.each(response, function (index, item) {
                        $dropdown.append($('<option></option>').val(item.Value).text(item.Text));
                    });
                }
            },
            error: function (xhr, status, error) {
                ToastMsg('An error occurred while fetching the problem list.', "error");
            }
        });
    }

    function GetIsbarYTimeSlots(type) {
        var strIPNO = sessionStorage.getItem("IPPatIPNO");
        var strDate = $("#Rptdate").val();
        $.ajax({
            url: '../SinglePage/GetIsbarYTimeSlots?strDate=' + strDate + '&&strIPNo=' + strIPNO + '&&strType=' + type,
            type: "POST",
            dataType: "JSON",
            success: function (response) {
                if (type == "ISBAR" || type == "ISBARDR") {
                    $('#IsbarYTime').empty();
                    $('#IsbarYTime').append($('<option/>').val("").text("---Select---"));
                    //$.each($.parseJSON(response), function (i, option) {
                    //    $('#IsbarYTime').append($('<option/>').val(option.Value).text(option.Text));
                    //});


                    //priyanka 12/06/2026
                    var data = JSON.parse(response);

                    $.each(data, function (i, option) {
                        $('#IsbarYTime').append(
                            $('<option/>')
                                .val(option.Value)
                                .text(option.Text)
                        );
                    });

                    $("#TimeLabel1").show();
                    $("#IsbarYTime").show();

                    //End
                    
                }
                else if (type == "NURSASSMNT") {
                    $('#Time').empty();
                    $('#Time').append($('<option/>').val("").text("---Select---"));
                    $.each($.parseJSON(response), function (i, option) {
                        $('#Time').append($('<option/>').val(option.Value).text(option.Text));
                    });
                }

            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg('An error occurred while processing your request.', "error");
            }
        });
    }









    function PrintICUReport() {
        var strIPNO = sessionStorage.getItem("IPPatIPNO");
        var strMrNo = sessionStorage.getItem("IPPatMRNO");
        var strDate = $("#Rptdate").val() || "";
        var strDate1 = $("#Rptdate1").val() || "";
        var strTime = "";
        var strToTime = "";
        var strBundletype = "";
        var IsbarType = "";
        var patStatus = "";
        var rptType = "";
        var UnitCD = gUnitCode;
        var ProblemCD = ""; var NoteType = "";
        var Type = "";
        var UserNM = gDoctName;

        const selectedRadio = document.querySelector('#ChkLstExcel input[type="radio"]:checked');
        if (selectedRadio) {
            ExcelRecords(selectedRadio);
        }
        else {
            if ($('#CriticalCare').prop('checked')) {
                rptType = "CRITICAL CARE FLOW SHEET GRAPH";
            }
            else if ($('#TISS28Score').prop('checked') || $('#TISS28Score1').prop('checked') || $('#TISS28Score2').prop('checked')) {
                rptType = "TISS28";
                Type = $('#TISS28Score').prop('checked') ? "TISSREPORT" : "BEDWISE";
            }
            else {
                if ($('#ISBAR').prop('checked') || $('#ISBARDR').prop('checked')) {
                    rptType = "ISBAR";
                    IsbarType = $('#ISBAR').prop('checked') ? "N" : "D";
                    strTime = $("#IsbarYTime").val();
                }
                if ($('#NursngAssesmnt').prop('checked')) {
                    rptType = "NURSES NOTES";
                    strTime = $("#Time").val();
                }
                if ($('#TreatmentSheetAdminst').prop('checked')) {
                    rptType = "TS_ADMINISTRATION_REPORT";
                }
                if ($('#TreatmentSheetMedRemark').prop('checked')) {
                    rptType = "TS_MEDREMARK_REPORT";
                }
                if ($('#TreatmentSheetChemoRemark').prop('checked')) {
                    rptType = "Chemo";
                }
                if ($('#rbtnCriticalAssmnt2').prop('checked')) {
                    rptType = "IntakeOutput_REPORT";
                }
                if ($('#RespAss').prop('checked')) {
                    rptType = "RESPIRATORY";
                }
                if ($('#rbtnInvasiveLines').prop('checked')) {
                    rptType = "InvasiveLines_REPORT";
                }
                if ($('#DiabeticChart').prop('checked')) {
                    rptType = "DIABETIC";
                }
                if ($('#rbtnOrderTestList').prop('checked')) {
                    rptType = "OrderTestList_REPORT";
                }
                if ($('#rbtnHourlyChart').prop('checked')) {
                    rptType = "Hourly_Chart";
                }
                if ($('#PainChart').prop('checked')) {
                    rptType = "Pain_Chart";
                    patStatus = "C";
                }
                if ($('#PainChartUnCons').prop('checked')) {
                    rptType = "Pain_ChartUn";
                    patStatus = "U";
                }
                if ($('#BundleChkList').prop('checked')) {
                    rptType = "BUNDLECHECKLIST";
                    strBundletype = $('#cmbBundleType').val();
                    strTime = $('#ShiftTime').val();
                }
                if ($('#rbtnPrphlBndleChkLst').prop('checked')) {
                    rptType = "PERIPHERALBUNDLECHECKLIST";
                    strBundletype = $('#cmbPBundleType').val();
                    strTime = $('#ShiftTime').val();
                }
                if ($('#MaxTemp').prop('checked')) {
                    rptType = "DATE WISE MAX TEMP";
                }
                if ($('#Nursing').prop('checked')) {
                    rptType = "NURSING ASSESSMENT";
                    strTime = $("#txtFrmTime").val();
                    strtoTime = $("#txtToTime").val();
                }

                if ($('#NursingWithoutChk').prop('checked')) {
                    rptType = "NURSING ASSESSMENT COMMA";
                    strTime = $("#txtFrmTime").val();
                    strtoTime = $("#txtToTime").val();
                }
                if ($('#InvestChart').prop('checked')) {
                    rptType = "INVESTIGATION";
                }
                if ($('#NursingNotes').prop('checked')) {
                    rptType = "NURSINGNOTES";
                    strTime = $('#txtFrmTime').val();
                    strToTime = $('#txtToTime').val();
                    ProblemCD = $("#Problist option:selected").val();
                }
                if ($('#ProgrNot').prop('checked')) {
                    rptType = "PROGNOTE";
                    strTime = $('#txtFrmTime').val();
                    strToTime = $('#txtToTime').val();
                    let selectedTypes = [];
                    if ($('#Nurse').is(':checked')) selectedTypes.push("N");
                    if ($('#RMO').is(':checked')) selectedTypes.push("R");
                    if ($('#Consultant').is(':checked')) selectedTypes.push("D");
                    NoteType = selectedTypes.length > 0 ? selectedTypes.join("|") : "N|R|D";
                }
                if ($('#rbtnOrderTestList').prop('checked')) {
                    rptType = "OrderTestList_REPORT";
                }
                if ($('#rbtnBradenScore').prop('checked')) {
                    rptType = "BradenScore_REPORT";
                }

                if ($('#rbtnPhysclRestrnt').prop('checked')) {
                    rptType = "PHYSICALRESTRAINTS";

                //}
                if ($("#rbtnFallRisk").prop('checked')) {
                    rptType = "FALLRISK";
                    strTime = $('#ShiftTime').val()
                }

            
                }
                if ($("#InvestReport").prop("checked")) { //PRIYANKA  09/06/2026
                    rptType = "INVESTIGATION REPORT";
                }

            }
            if (!rptType) {
                ToastMsg("Please select a report type", "warning");
                return;
            }
            var urlName = "";
            if (rptType === "CRITICAL CARE FLOW SHEET GRAPH")
                urlName = '/GetICUSetCritCareGraphDatePrint';
            else if (rptType === "DIACOM_IMAGES")
                urlName = '/GetDiacomImages';
            else if (rptType === "TISS28")
                urlName = '/GetICUSetTISSDatesNIPNO2';
            else if (rptType === "INVESTIGATION REPORT") //priyanka 09/06/2026
                urlName = "/GetICUGetInvestReportData";
            else
                urlName = '/GetEmtReportPrint';

            var url = ExternalCallForEMRURL + urlName;
            if (urlName === '/GetEmtReportPrint') {
                var params = [
                    strIPNO,
                    strDate,
                    strTime,
                    rptType,
                    strDate1,
                    strBundletype,
                    strToTime,
                    IsbarType,
                    patStatus,
                    NoteType,
                    ProblemCD,
                    gUnitCode,
                    UserNM
                ];
                var query = params.map(val =>
                    'Parameters=' + encodeURIComponent(val || '')
                ).join('&');
                var url = ExternalCallForEMRURL + '/GetEmtReportPrint?' + query;
                var win = window.open(url, '_blank', 'width=' + screen.availWidth + ',height=' + screen.availHeight);  //'width=1024,height=700,scrollbars=yes');
                win.focus();
                win.onload = function () {
                    var jsonResponse = JSON.parse(win.document.body.innerText);
                    if (jsonResponse.Status.toLowerCase().includes("success") && jsonResponse.Data) {
                        var base64PDF = jsonResponse.Data;
                        var byteCharacters = atob(base64PDF);
                        var byteNumbers = new Array(byteCharacters.length);
                        for (var i = 0; i < byteCharacters.length; i++) {
                            byteNumbers[i] = byteCharacters.charCodeAt(i);
                        }
                        var byteArray = new Uint8Array(byteNumbers);
                        var blob = new Blob([byteArray], { type: 'application/pdf' });
                        var blobURL = URL.createObjectURL(blob);
                        var pdfWindow = window.open(blobURL, '_blank', 'width=' + screen.availWidth + ',height=' + screen.availHeight); // 'width=1024,height=700,scrollbars=yes');
                        pdfWindow.focus();
                        win.close();
                    }
                    else {
                        ToastMsg("No Data Found", "warning");
                        win.close();
                    }
                }
            } 
            else if (urlName === '/GetICUGetInvestReportData') { //priyanka 09/06/2026
                var query = '?strIPNO=' + encodeURIComponent(strIPNO) +
                    '&strDate=' + encodeURIComponent(strDate) +
                    '&strTime=' + encodeURIComponent(strTime) +
                    '&ReportType=' + encodeURIComponent(rptType) +
                    '&strToDt=' + encodeURIComponent(strDate1) +
                    '&strToDt=' + encodeURIComponent(strDate1) +
                    '&chkInvstg=' + encodeURIComponent(chkInvstg) +
                    '&unitcode=' + encodeURIComponent(UnitCD) +
                    '&UserName=' + encodeURIComponent(UserNM);

                var fullUrl = url + query;
                var win = window.open(fullUrl, '_blank', 'width=' + screen.availWidth + ',height=' + screen.availHeight);  //'width=1024,height=700,scrollbars=yes');
                win.focus();
            }
            else {
                var query = '?strIPNO=' + encodeURIComponent(strIPNO) +
                    '&strDate=' + encodeURIComponent(strDate) +
                    '&strToDt=' + encodeURIComponent(strDate1) +
                    '&strTime=' + encodeURIComponent(strTime) +
                    '&strToTime=' + encodeURIComponent(strToTime) +
                    '&strBundletype=' + encodeURIComponent(strBundletype) +
                    '&IsbarType=' + encodeURIComponent(IsbarType) +
                    '&PatStatus=' + encodeURIComponent(patStatus) +
                    '&ReportType=' + encodeURIComponent(rptType) +
                    '&unitcode=' + encodeURIComponent(UnitCD) +
                    '&ProblemCD=' + encodeURIComponent(ProblemCD) +
                    '&NoteType=' + encodeURIComponent(NoteType) +
                    '&Type=' + encodeURIComponent(Type) +
                    '&UserName=' + encodeURIComponent(UserNM);
                var fullUrl = url + query;
                var win = window.open(fullUrl, '_blank', 'width=' + screen.availWidth + ',height=' + screen.availHeight);  //'width=1024,height=700,scrollbars=yes');
                win.focus();
            }
        }
    }

    function ExcelChkLst(radioId, subtype) {
        var EmpCode = "";
        var Type = "";
        var IPNO = sessionStorage.getItem("IPPatIPNO");
        var fileName = "";
        var UnitCD = "ICU1";
        switch (radioId) {
            case "SIIPAudit":
                Type = "SI";
                if (subtype == "N") {
                    fileName = "Safe Injection.xls";
                }
                else {
                    fileName = "Safe Injection-Summary.xls";
                }
                break;
            case "MAEAAudit":
                Type = "MA";
                if (subtype == "N") {
                    fileName = "Medication Administration.xls";
                }
                else {
                    fileName = "Medication Administration-summary.xls";
                }
                break;
            case "PMAAudit":
                Type = "PA";
                fileName = "Pain Management.xls";
                break;
            case "CSNPAudit":
                Type = "NP";
                if (subtype == "N") {
                    fileName = "Nursing Practice.xls";
                }
                else {
                    fileName = "Nursing Practice-summary.xls";
                }
                break;
            case "CNDAAudit":
                Type = "ND";
                if (subtype == "N") {
                    fileName = "Nursing Documentation.xls";
                }
                else {
                    fileName = "Nursing Documentation-summary.xls";
                }
                break;
            default:
                Type = "";
                fileName = "";
                return;
        }
        var strFrmDate = $('#Rptdate').val();
        var strToDate = $('#Rptdate1').val();

        var urlName = '/GetChkLstExcel';
        var query = '?Type=' + encodeURIComponent(Type) +
            '&strFrmDate=' + encodeURIComponent(strFrmDate) +
            '&strToDate=' + encodeURIComponent(strToDate) +
            '&EmpCode=' + encodeURIComponent(EmpCode) +
            '&IPNO=' + encodeURIComponent(IPNO) +
            '&subtype=' + encodeURIComponent(subtype) +
            '&filename=' + encodeURIComponent(fileName) +
            '&unitcode=' + encodeURIComponent(UnitCD);

        var finalUrl = ExternalCallForEMRURL + urlName + query;

        var downloadLink = document.createElement("a");
        downloadLink.href = finalUrl;
        downloadLink.target = "_blank";
        downloadLink.download = fileName;
        document.body.appendChild(downloadLink);
        downloadLink.click();
        document.body.removeChild(downloadLink);
    }

    function ExcelRecords(selectedRadio) {
        if (selectedRadio.id == "SIIPAudit") { 
            var SubType = "N"
            ExcelChkLst(selectedRadio.id, SubType);
            SubType = "V"
            ExcelChkLst(selectedRadio.id, SubType);
        }
        else if (selectedRadio.id == "CSNPAudit") {  
            var SubType = "N"
            ExcelChkLst(selectedRadio.id, SubType);
            SubType = "O"
            ExcelChkLst(selectedRadio.id, SubType);
        }
        else if (selectedRadio.id == "CNDAAudit") {   
            var SubType = "N"
            ExcelChkLst(selectedRadio.id, SubType);
            SubType = "O"
            ExcelChkLst(selectedRadio.id, SubType);
        }
        else if (selectedRadio.id == "MAEAAudit") {  
            var SubType = "N"
            ExcelChkLst(selectedRadio.id, SubType);
            SubType = "O"
            ExcelChkLst(selectedRadio.id, SubType);
        }
        else if (selectedRadio.id == "PMAAudit") {  
            ExcelChkLst(selectedRadio.id);
        }
        else if (selectedRadio.id == "Assesmentexcel") {
            ExcelReports();
        }

    }

    function ExcelReports() {
        var strFrmDate = $('#Rptdate').val();
        var strToDate = $('#Rptdate1').val();
        var IPNO = sessionStorage.getItem("IPPatIPNO");
        var fileName = "Assesment Report.xls";
        var datatosend = {
            strFrmDate: strFrmDate,
            strToDate: strToDate,
            IPNO: IPNO,
            filename: fileName
        }
        $.ajax({
            url: '../SinglePage/GenerateExcelReports',
            type: "POST",
            dataType: "JSON",
            data: datatosend,
            success: function (response) {
                if (response == "success") {
                    window.location.href = '../SinglePage/DisplayGenerateExcelReports';
                }
                else {
                    ToastMsg("No Data Found", "info");
                }
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg('An error occurred while processing your request.', "error");
            }
        });
    }



</script>

<div class="container-fluid bg-white">

    <div class="">
        <!-- Header Div Above Search -->
        <div class="container-fluid border rounded bg-light" id="Head" style="z-index: 2; border-radius: 0px;">
            <div class="row g-2 align-items-center">
                <div class="col-auto">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text" id="DATE">Date :</span>
                        <input type="text" id="Rptdate" class="form-control TextBxFormat" readonly style="width: 100px;" />

                        <span class="input-group-text" id="DATE1" style="display: none;">To Date :</span>
                        <input type="text" id="Rptdate1" class="form-control TextBxFormat" style="display: none; width: 100px;" />
                    </div>
                </div>

                <div class="col-auto EmpLst" style="display: none;">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text">Select Emp:</span>
                        <select id="EmpLst" class="form-select TextBxFormat ComboFormat">
                            <option value="">--Select--</option>
                        </select>
                    </div>
                </div>

                <div class="col-auto">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text" id="TimeLabel">Time :</span>
                        <select id="Time" class="form-select ComboFormat" style="width: 130px;">
                            <option value="">---Select---</option>
                        </select>

                        <span class="input-group-text" id="TimeLabel1" style="display: none;">Time :</span>
                        <select id="IsbarYTime" class="form-select ComboFormat" style="display: none; width: 130px;">
                            <option value="">---Select---</option>
                        </select>
                    </div>
                </div>

                <div class="col-auto">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text" id="lblBundletype" style="display: none">Bundle Type</span>
                        <select id="cmbBundleType" class="form-select ComboFormat" style="display: none; width: 80px;">
                            <option value="II">II</option>
                            <option value="III">III</option>
                            <option value="IV">IV</option>
                        </select>
                        <select id="cmbPBundleType" class="form-select ComboFormat" style="display: none; width: 80px;">
                            <option value="I">I</option>
                            <option value="II">II</option>
                            <option value="III">III</option>
                            <option value="IV">IV</option>
                            <option value="V">V</option>
                            <option value="VI">VI</option>
                            <option value="VII">VII</option>
                            <option value="VIII">VIII</option>
                            <option value="IX">IX</option>
                            <option value="X">X</option>
                            <option value="XI">XI</option>
                            <option value="XII">XII</option>
                            <option value="XIII">XIII</option>
                            <option value="XIV">XIV</option>
                            <option value="XV">XV</option>
                        </select>
                    </div>
                </div>

                <div class="col-auto" id="FrmTime">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text"><b>From Time :</b></span>
                        <input type="text" id="txtFrmTime" class="form-control TextBxFormat" readonly style="width: 80px;" />
                    </div>
                </div>

                <div class="col-auto" id="ToTime">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text"><b>To Time :</b></span>
                        <input type="text" id="txtToTime" class="form-control TextBxFormat" readonly style="width: 80px;" />
                    </div>
                </div>

                <div class="col-auto">
                    <div id="ShiftTm" class="input-group input-group-sm">
                        <span class="input-group-text"><b>Shift :</b></span>
                        <select id="ShiftTime" class="form-select ComboFormat" style="width: 100px;">
                            <option value="">---Select---</option>
                            <option value="M">Morning</option>
                            <option value="E">Evening</option>
                            <option value="N">Night</option>
                        </select>
                    </div>
                </div>


                <div class="col-auto" style="flex: 1;text-align: end;">
                    <button id="btnDisplayEMRRecordsBtn" class="btn btn-success btn-sm px-5 fw-semibold"><i class="bi bi-search me-1"></i>Display</button>
                </div>
            </div>
        </div>

        <!-- Search -->
        <div class="row mb-2 align-items-center position-relative">
            <div class="position-relative" style="display: flex;">
                <label for="txtSearchReport" class="mb-0" style="display: inline-block; width: 100px;">Search :</label>
                <input type="text" class="form-control" id="txtSearchReport" placeholder="Search Report..." autocomplete="off" style="display: inline-block;" />
                <div id="searchOptions" class="border rounded mt-1 bg-white shadow-sm" style="left: 100px; position: absolute; top: 100%; width: 100%; z-index: 1000; max-height: 200px; overflow-y: auto;">
                </div>
            </div>
        </div>

    </div>

    <div class="row Maintable">

        <!-- LEFT COLUMN -->
        <div class="col-md-6">

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="CriticalCare" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="CriticalCare">
                    Nursing Care Flowsheet
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TreatmentSheetAdminst" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="TreatmentSheetAdminst">
                    Medication Administration (Incl. Non-Drug)
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TreatmentSheetMedRemark" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="TreatmentSheetMedRemark">
                    Medication Administration
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TreatmentSheetChemoRemark" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="TreatmentSheetChemoRemark">
                    Chemo Administration
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnCriticalAssmnt2" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnCriticalAssmnt2">
                    INTAKE - OUTPUT Record
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="RespAss" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="RespAss">
                    Respiratory &amp; Neurology Assessment
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnInvasiveLines" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnInvasiveLines">
                    Invasive Lines &amp; Tubes
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="DiabeticChart" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="DiabeticChart">
                    Diabetic Chart
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="DiacomImg" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="DiacomImg">
                    Dicom Images
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnOrderTestList" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnOrderTestList">
                    Patient Investigation Details
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnPrphlBndleChkLst" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnPrphlBndleChkLst">
                    Peripheral Vascular Care Bundle
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnHourlyChart" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnHourlyChart">
                    Hourly Monitoring Chart
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="ISBARDR" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="ISBARDR">
                    ISBAR (Doctor Hand Over Sheet)
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="ISBAR" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="ISBAR">
                    ISBAR (Nursing Hand Over Sheet)
                </label>
            </div>
        </div>

        <!-- RIGHT COLUMN -->
        <div class="col-md-6">

            <!-- Progress Notes -->
            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                <div class="form-check mb-0">
                    <input class="form-check-input" type="radio" name="icu" id="ProgrNot" onchange="rbtnchange();">
                    <label class="form-check-label fw-semibold" for="ProgrNot">
                        Progress Notes
                    </label>
                </div>

                <div class="d-flex gap-3">
                    <div class="form-check mb-0">
                        <%--<input class="form-check-input" type="checkbox" id="Nurse" onchange="rbtnchange();">--%>
                        <input class="form-check-input" type="checkbox" id="Nurse" data-parent="ProgrNot" disabled>
                        <label class="form-check-label" for="Nurse">Nurse</label>
                    </div>

                    <div class="form-check mb-0">
                        <%--<input class="form-check-input" type="checkbox" id="RMO" onchange="rbtnchange();">--%>
                        <input class="form-check-input" type="checkbox" id="RMO" data-parent="ProgrNot" disabled>
                        <label class="form-check-label" for="RMO">GDMO / RMO</label>
                    </div>

                    <div class="form-check mb-0">
                        <%--<input class="form-check-input" type="checkbox" id="Consultant" onchange="rbtnchange();">--%>
                        <input class="form-check-input" type="checkbox" id="Consultant" data-parent="ProgrNot" disabled>
                        <label class="form-check-label" for="Consultant">Consultant</label>
                    </div>
                </div>
            </div>

            <!-- Nursing Care Plans -->
            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                <div class="form-check mb-0">
                    <input class="form-check-input" type="radio" name="icu" id="NursingNotes" onchange="rbtnchange();">
                    <label class="form-check-label fw-semibold" for="NursingNotes">
                        Nursing Care Plans
                    </label>
                </div>

                <div style="min-width: 180px;">
                    <%--<select class="form-select " id="Problist">
                        <option value="">---Select---</option>
                    </select>--%>
                    <select class="form-select" id="Problist" data-parent="NursingNotes" disabled>
                        <option value="">---Select---</option>
                    </select>
                </div>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="NursngAssesmnt" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="NursngAssesmnt">
                    Ongoing Nursing Assessment
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="BundleChkList" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="BundleChkList">
                    Bundle Check List
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="NursingWithoutChk" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="NursingWithoutChk">
                    Initial Nursing Assessment On Admission
                </label>
            </div>


            <div class="form-check py-2 border-bottom" style="display:none;">
                <input class="form-check-input" type="radio" name="icu" id="TISS28Score" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="TISS28Score">
                    Tiss Acuity Scoring
                </label>
            </div>

            <div class="form-check py-2 border-bottom" style="display:none;">
                <input class="form-check-input" type="radio" name="icu" id="TISS28Score1" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="TISS28Score1">
                    Patient Acuity Scoring
                </label>
            </div>

            <div class="form-check py-2 border-bottom" style="display:none;">
                <input class="form-check-input" type="radio" name="icu" id="TISS28Score2" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="TISS28Score2">
                    BedWise Acuity Score
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnBradenScore" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnBradenScore">
                    Skin Re-Assessment Braden Score
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="MaxTemp" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="MaxTemp">
                    Date Wise Max. Temperature
                </label>
            </div>

            <!-- Consolidated Investigation -->
            <div class="d-flex justify-content-between align-items-center py-2 border-bottom" onchange="rbtnchange();">
                <div class="form-check mb-0">
                    <input class="form-check-input" type="radio" name="icu" id="InvestReport" onchange="rbtnchange();">
                    <label class="form-check-label fw-semibold" for="InvestReport">
                        Consolidated Investigation Reports
                    </label>
                </div>

                <div class="form-check mb-0">
                   <%-- <input class="form-check-input" type="checkbox" id="chkInvstg" onchange="rbtnchange();">--%>
                   <%--<label class="form-check-label" for="chkInvstg">All Test</label>--%>
                    <input class="form-check-input" type="checkbox" id="chkInvstg" data-parent="InvestReport" disabled>
                    <label class="form-check-label" for="chkInvstg">All Test</label>
                </div>
            </div>

            <div class="form-check py-2 border-bottom" style="display:none;">
                <input class="form-check-input" type="radio" name="icu" id="rbtnFallRisk" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnFallRisk">
                    Fall Risk Assessment
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnPhysclRestrnt" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="rbtnPhysclRestrnt">
                    Physical Restraints Monitoring Sheet
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="PainChart" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="PainChart">
                    Pain Monitoring Chart (Conscious)
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="PainChartUnCons" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="PainChartUnCons">
                    Pain Monitoring Chart (Unconscious)
                </label>
            </div>

        </div>

    </div>

    <div class="row Maintable" id="ChkLstExcel">
        <!-- Row 1 -->
        <div class="col-md-6 py-2 border-bottom">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="icu" id="SIIPAudit" value="1" onchange="changeAudit();">
                <label class="form-check-label fw-semibold" for="SIIPAudit">
                    Safe Injection and Infusion Practice
                </label>
            </div>
        </div>
        <div class="col-md-6 py-2 border-bottom">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="icu" id="MAEAAudit" value="1" onchange="changeAudit();">
                <label class="form-check-label fw-semibold" for="MAEAAudit">
                    Medication Administration Error Audit
                </label>
            </div>
        </div>

        <!-- Row 2 -->
        <div class="col-md-6 py-2 border-bottom">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="icu" id="CSNPAudit" value="1" onchange="changeAudit();">
                <label class="form-check-label fw-semibold" for="CSNPAudit">
                    Compliance to Safe Nursing Practice Audit
                </label>
            </div>
        </div>
        <div class="col-md-6 py-2 border-bottom">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="icu" id="CNDAAudit" value="1" onchange="changeAudit();">
                <label class="form-check-label fw-semibold" for="CNDAAudit">
                    Compliance to Nursing Documentation Audit
                </label>
            </div>
        </div>

        <!-- Row 3 -->
        <div class="col-md-6 py-2 border-bottom">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="icu" id="PMAAudit" value="1" onchange="changeAudit();">
                <label class="form-check-label fw-semibold" for="PMAAudit">
                    Pain Management Audit
                </label>
            </div>
        </div>
        <div class="col-md-6 py-2 border-bottom">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="icu" id="Assesmentexcel" value="1" onchange="rbtnchange();">
                <label class="form-check-label fw-semibold" for="Assesmentexcel">
                    Assessment Reports
                </label>
            </div>
        </div>

    </div>



    <div id='loading-EMRRecords' class='loading-screen' style='display: none; opacity: 0;'></div>

</div>
