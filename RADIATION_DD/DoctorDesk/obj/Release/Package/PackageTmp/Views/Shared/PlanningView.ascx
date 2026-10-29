<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.Planning>" %>

<style type="text/css">
   
    /* dispay dialog box top of fancybox */
    .ui-dialog {
        z-index:100000;
    }

    .TextBxFormat {
        font-size: 15px;
        line-height: 1.5;
        color: #333;
        font-family: 'Segoe UI', 'Arial', sans-serif;
    }

    .TextBxFormat::placeholder {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-size: 14px;
        color: #888; /* lighter gray for placeholder */
        font-style: italic; /* optional, for subtle differentiation */
    }

    .form-control::placeholder{
         font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
         font-size: 14px;
         color: #888; 
         font-style: italic; 
    }

    .form-container {
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        max-width: 100%;
        margin: 0 auto;
    }

    .form-row {
        display: flex;
        flex-direction: column;
        margin-bottom: 16px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        margin-bottom: 12px;
        flex: 1;
        padding: 5px;
        overflow:auto;  
    }

    @media (min-width: 1050px) {
        
        .form-row.horizontal-3 {
            flex-direction: row;
            gap: 10px;
        }

        .form-row.horizontal-2 {
            flex-direction: row;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 0;
        }
    

    }

     /* Dropdown Style Code */
    .custom-dropdown {
      position: relative;
      display: inline-block;
      /* width: 320px;*/
      width:99%;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      font-size: 16px;
      color: #333;
      overflow: visible;
    }

    .custom-dropdown select {
      width: 100%;
      padding: 6px 40px 6px 12px; /* Reduced top & bottom padding */
      border-radius: 6px;
      border: 1.5px solid #ced4da;
      background-color: #fff;
      appearance: none;
      -webkit-appearance: none;
      -moz-appearance: none;
      cursor: pointer;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      box-sizing: border-box;
      font-size: 15px; /* Optional: slightly smaller font */
    }

    /*.custom-dropdown select {
      width: 100%;
      padding: 12px 60px 12px 16px;*/ /* ✅ more right padding */
      /*border-radius: 8px;
      border: 1.8px solid #ced4da;
      background-color: #fff;
      appearance: none;
      -webkit-appearance: none;
      -moz-appearance: none;
      cursor: pointer;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
      box-shadow: 0 2px 6px rgb(0 0 0 / 0.07);
      box-sizing: border-box;*/ /* ✅ important for width calc */
    /*}*/

    .custom-dropdown select:focus {
      border-color: #4a90e2;
      box-shadow: 0 0 6px #4a90e2aa;
      outline: none;
    }

    .custom-dropdown::after {
      content: "";
      position: absolute;
      top: 50%; /* center vertically */
      right: 16px; /* space from edge */
      width: 0;
      height: 0;
      pointer-events: none;
      border-left: 6px solid transparent;
      border-right: 6px solid transparent;
      border-top: 6px solid #4a90e2; /* small neat arrow */
      transform: translateY(-50%);
    }


    .custom-dropdown select:hover {
      border-color: #a9c4f2;
    }

    .custom-dropdown select:disabled {
      background-color: #f0f0f0;
      color: #999;
      cursor: not-allowed;
      border-color: #ddd;
    }

    /* Dropdown Style Code */

    .form-input {
      padding: 10px 14px;
      font-size: 15px;
      border: 1.5px solid #ccc;
      border-radius: 6px;
      background-color: #fff;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    .form-input:focus {
      border-color: #4a90e2;
      box-shadow: 0 0 5px rgba(74, 144, 226, 0.4);
      outline: none;
    }

    .info-icon {
        display: inline-block;
        width: 20px;
        height: 20px;
        background-color: #007bff;
        color: white;
        border-radius: 50%;
        text-align: center;
        font-size: 16px;
        font-family: Arial, sans-serif;
        line-height: 22px;
        font-weight: bold;
        cursor: help;
    }

</style>

<script type="text/javascript">
    var gaction = '<%= Model.TempGaction %>';
    var PerformStatusList = [{ VALUE: "", TEXT: "---Select---" }, { VALUE: "0", TEXT: "0" }, { VALUE: "1", TEXT: "1" }, { VALUE: "2", TEXT: "2" }, { VALUE: "3", TEXT: "3" }, { VALUE: "4", TEXT: "4" }, { VALUE: "5", TEXT: "5" }];
    $(document).ready(function () {
        AppendPerformStatus();
        $("#txtRepeatAfter").on('input', function () {
            let value = $(this).val();
            let regex = /^\d+(\d{0,0})?$/;
            if (!regex.test(value)) {
                $(this).val(value.slice(0, -1));
            }
        });

        $("#txtCycles").on('input', function () {
            let value = $(this).val();
            let regex = /^\d+(\d{0,0})?$/;
            if (!regex.test(value)) {
                $(this).val(value.slice(0, -1));
            }
        });

        $("#LstChemoTName").change(function () {
            GetProtocol();
        });

        $("#btnSave").click(function () {
            //debugger;
            let validateAction = ValidateBeforeSave();
            if (validateAction) {
                let prepDt = prepSaveData();
                if (prepDt) {
                    SaveService(prepDt);
                }
            }
        });


        $("#LstChemoCourse, #LstTreatmentPlan, #LstChemoTName ,#LstScheme, #LstPatCat").change(function () {
            if ($(this).val() !== "" && $(this).val() !== null) {
                $(this).css("border", "");
            }
        });

        $("#txtPrevTreatTextArea, #txtCycles, #txtRepeatAfter, #txtModificationTextArea, #cmbPerformanceStatus, #txtCoMorbiditiesTextArea").change(function () {
            if ($(this).val() !== "" && $(this).val() !== null) {
                $(this).css("border", "");
            }
        });


        // Get Vital Data Height,Weight,BSA 
        GetVitalData();
        GetDiagnosisData();

        setTimeout(function () {
            GetMedOncoData();
        });

    });


    function GetProtocol() {
        var selected_val = $('#LstChemoTName').find(":selected").attr('value');
        if (selected_val != "") {
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetProtocol",
                datatype: 'json',
                data: { id: selected_val },
                success: function (data) {
                    console.log(data);
                    if (data.length > 0) {
                        $('#txtChemoTextArea').val(data[0]);
                        $("#ChkHours").prop("checked", true);
                        $("#txtDurationHrs").val(data[2]);
                        //if (data[1] == "H") {
                        //    $("#ChkHours").prop("checked", true);
                        //    $("#txtDurationHrs").val(data[2]);
                        //}
                        //else if (data[1] == "D") {
                        //    $("#ChkDay").prop("checked", true);
                        //    $("#txtDurationDays").val(data[2]);
                        //}
                        //else {
                        //    $("#ChkHours").prop("checked", false);
                        //    $("#ChkDay").prop("checked", false);
                        //}
                        DurationShowHide();
                    }
                    else {
                        $('#txtChemoTextArea').val('');
                    }
                }
            });
        }
        else {
            $('#txtChemoTextArea').val('');
        }
    }

    function ValidateBeforeSave() {
        HoldOn.open();

        let i = 0

        //if ($("#LstDiagnosis").val() == "") {
        //    $("#LstDiagnosis").css("border", "2px solid red");
        //    i = 1;
        //} else {
        //    $("#LstDiagnosis").css("border", "");
        //}

        if ($("#LstChemoCourse").val() == "") {
            $("#LstChemoCourse").css("border", "2px solid red");
            i = 1;
        } else {
            $("#LstChemoCourse").css("border", "");
        }


        if ($("#LstTreatmentPlan").val() == "") {
            $("#LstTreatmentPlan").css("border", "2px solid red");
            i = 1;
        } else {
            $("#LstTreatmentPlan").css("border", "");
        }

        if ($("#txtPrevTreatTextArea").val() == "") {
            $("#txtPrevTreatTextArea").css("border", "2px solid red");
            i = 1;
        } else {
            $("#txtPrevTreatTextArea").css("border", "");
        }

        //if ($("#LstChemoTName").val() == "") {
        //    $("#LstChemoTName").css("border", "2px solid red");
        //    i = 1;
        //} else {
        //    $("#LstChemoTName").css("border", "");
        //}

        if ($("#txtCycles").val() == "") {
            $("#txtCycles").css("border", "2px solid red");
            i = 1;
        } else {
            $("#txtCycles").css("border", "");
        }

        if ($("#txtRepeatAfter").val() == "") {
            $("#txtRepeatAfter").css("border", "2px solid red");
            i = 1;
        } else {
            $("#txtRepeatAfter").css("border", "");
        }

        if ($("#txtModificationTextArea").val() == "") {
            $("#txtModificationTextArea").css("border", "2px solid red");
            i = 1;
        } else {
            $("#txtModificationTextArea").css("border", "");
        }

        if ($("#cmbPerformanceStatus").val() == "") {
            $("#cmbPerformanceStatus").css("border", "2px solid red");
            i = 1;
        }
        else {
            $("#cmbPerformanceStatus").css("border", "");
        }

        //if ($("#txtHPReport").val() == "") {
        //    $("#txtHPReport").css("border", "2px solid red");
        //    i = 1;
        //}
        //else {
        //    $("#txtHPReport").css("border", "");
        //}

        if ($("#txtCoMorbiditiesTextArea").val() == "") {
            $("#txtCoMorbiditiesTextArea").css("border", "2px solid red");
            i = 1;
        }
        else {
            $("#txtCoMorbiditiesTextArea").css("border", "");
        }

        //if ($("#LstPatCat").val() == "") {
        //    $("#LstPatCat").css("border", "2px solid red");
        //    i = 1;
        //} else {
        //    $("#LstPatCat").css("border", "");
        //}

        //if ($("#LstScheme").val() == "") {
        //    $("#LstScheme").css("border", "2px solid red");
        //    i = 1;
        //} else {
        //    $("#LstScheme").css("border", "");
        //}

        if (i == 1) {
            HoldOn.close();
            $.messager.alert("Alert", "Please fill required Details");
            return false;
        } else {
            HoldOn.close();
            return true;
        }
    }

    function prepSaveData() {
        let consultNo = $.session.get("PatTRANNO");
        let tranno = $("#txtTRANID").val() || "";
        let mrno = $.session.get('PatMRNO');
        let chemoCourseName = $("#LstChemoCourse").val();
        let drugTextArea = $("#txtChemoTextArea").val();
        let chemoName = $("#LstChemoTName").val();
        let noOfCyle = $("#txtCycles").val();
        let repeatAfterDays = $("#txtRepeatAfter").val();
        let prevTreatment = $("#txtPrevTreatTextArea").val();
        let treatmentPlanCode = $("#LstTreatmentPlan").val();
        let tratmentModification = $("#txtPrevTreatTextArea").val();
        //let diagnosis = $("#LstDiagnosis").val();

        let height = $("#txtHeight").val();
        let weight = $("#txtWeight").val();
        let bsa = $("#txtHeight").val();

        let hptReport = $("#txtHPReport").val();
        let hptReportRemark = $("#txtHPReportRemark").val();
        let patCat = $("#LstPatCat").val();
        let performanceStatus = $("#cmbPerformanceStatus").val();
        let scheme = $("#LstScheme").val();

        let t = $("#txtTstage").val();
        let n = $("#txtNstage").val();
        let m = $("#txtMstage").val();

        let prechemoFinding = $("#txtCoMorbiditiesTextArea").val();

        let entryDate = "";
        let m2 = "";
        let regime = "";
        let cancelRemarks = "";
        let schemeoth = "";
        let HrsDay = "";
        let DuraHrDay = "";
        if ($("#ChkHours").prop("checked") == true) {
            HrsDay = "H";
            DuraHrDay = $("#txtDurationHrs").val();
        }
        //else if ($("#ChkDay").prop("checked") == true) {
        //    HrsDay = "D";
        //    DuraHrDay = $("#txtDurationDays").val();
        //}
        const dataToSend = {
            ConsultNo: consultNo,
            MRNO: mrno,
            EntryDate: entryDate,
            //Diagnosis: diagnosis,
            T: t,
            N: n,
            M: m,
            ChemoCourse: chemoCourseName,
            HPReport: hptReport,
            PrevTreatment: prevTreatment,
            PreChemoFindings: prechemoFinding,
            Height: height,
            Weight: weight,
            BSA: bsa,
            PerformStatus: performanceStatus,
            M2: m2,
            Regime: regime,
            ChemoName: chemoName,
            Protocol: drugTextArea,
            ToRepeat: repeatAfterDays,
            TreatmentPlan: treatmentPlanCode,
            TotalCycles: noOfCyle,
            TreatmentModification: tratmentModification,
            ICDYN: "Y",
            CancelRemarks: cancelRemarks,
            Scheme: scheme,
            SchemeOth: schemeoth,
            PatCatg: patCat,
            gact: gaction,
            TranNo: tranno,
            Duration: DuraHrDay,
            HourorDay: HrsDay,
            ReportRemark : hptReportRemark
            //Consultant:"" // Passing in Model 
        }

        console.log("datato send => ", dataToSend);

        return dataToSend;
    }

    function SaveService(dataToSend) {
        HoldOn.open();
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/GetMedOncoSave',
            datatype: 'json',
            data: dataToSend,
            success: function (response) {
                $.messager.alert("Alert", response.message);
                if (response.success) {
                    $("#txtTRANID").val(response.ConsultNo);
                    $("#btnSave").text('💾 Update');
                    gaction = "E";
                    window.location.reload();
                    //sessionStorage.setItem("ChemoConsultNo", response.ConsultNo);
                }
                else {

                }
            },
            error: function (xhr, status, error) {
                console.log("error =>", status);
            },
            complete: function () {
                HoldOn.close()
            }
        });
    }


    // Get Vital Data 
    function GetVitalData() {
        let tranNo = $.session.get('PatTRANNO');
        let mrno = $.session.get('PatMRNO');
        HoldOn.open();
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/SetDataForVitals',
            datatype: 'json',
            data: { strTranNo: tranNo, Type: "V", strMRNo: mrno },
            success: function (response) {
                if (response != "") {

                    if (response.Weight > 0) {
                        $("#txtWeight").val(response.Weight);
                    }
                    else {
                        $("#txtWeight").val('0');
                    }

                    if (response.HEIGHT > 0) {
                        $("#txtHeight").val(response.HEIGHT);
                    }
                    else {
                        $("#txtHeight").val('0');
                    }

                    $("#txtBSA").val(response.BSA);
                }
            },
            error: function (xhr, status, error) {
                console.log("error =>", status);
            },
            complete: function () {
                HoldOn.close()
            }
        });
    }

    function GetDiagnosisData() {
        let tranNo = $.session.get('PatTRANNO');
        HoldOn.open();
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/SetDataForDiagnosis',
            datatype: 'json',
            data: { strTranNo: tranNo },
            success: function (response) {
                if (response != "") {
                    let tstage = response[2][0].TSTAGE || ""
                    let nstage = response[2][0].NSTAGE || ""
                    let mstage = response[2][0].MSTAGE || ""

                    $("#txtTstage").val(tstage);
                    $("#txtNstage").val(nstage);
                    $("#txtMstage").val(mstage);
                }

            },
            error: function (xhr, status, error) {
                console.log("error =>", status);
            },
            complete: function () {
                HoldOn.close()
            }
        });
    }

    // Get Onco Data =>
    function GetMedOncoData() {
        //let ConsultNo = $.session.get('PatTRANNO');
        let ConsultNo = $.session.get('ChemoConsultNo');
        let mrno = $.session.get('PatMRNO');
        DurationShowHide();
        if (!mrno) {
            $.messager.alert("Alert", "Please Select Patient.");
            return false;
        }
        HoldOn.open();
        $.ajax({
            type: 'POST',
            datatype: 'json',
            url: '../DoctorDesk/GetMedOncoData',
            data: { strConsultNo: ConsultNo, MrNo: mrno },
            success: function (response) {
                response = response.data;
                if (Array.isArray(response) && response.length > 0) {
                    let chemoCourse = response[0].CHEMOCOURSE;
                    let treatmentPlan = response[0].TREATMENTPLAN;
                    let previousTreatment = response[0].PREVTREATMENT;
                    let chemoName = response[0].CHEMOTHERAPYNM;
                    let protocol = response[0].PROTOCOL;
                    let performanceStatus = response[0].PERFORMANCESTATUS;
                    let hpreport = response[0].HPREPORT;
                    let patcat = response[0].PATCAT;
                    let scheme = response[0].SCHEME;
                    let totalNocycle = response[0].TOTALCYCLE;
                    let repeateAfterCyle = response[0].REPEATAFTER;
                    let modification = response[0].MODIFICATION;
                    let morbidies = response[0].CLINICALFIND;
                    let hpreportremark = response[0].HPREPORTREMARK;

                    $("#LstChemoCourse").val(chemoCourse);
                    $("#LstTreatmentPlan").val(treatmentPlan);
                    $("#txtPrevTreatTextArea").val(previousTreatment);
                    $("#LstChemoTName").val(chemoName);
                    $("#txtChemoTextArea").val(protocol);
                    $("#cmbPerformanceStatus").val(performanceStatus);
                    $("#txtHPReport").val(hpreport);
                    $("#txtHPReportRemark").val(hpreportremark);
                    $("#txtCoMorbiditiesTextArea").val("");
                    $("#LstPatCat").val(patcat);
                    $("#LstScheme").val(scheme);
                    $("#txtCycles").val(totalNocycle);
                    $("#txtRepeatAfter").val(repeateAfterCyle);
                    $("#txtModificationTextArea").val(modification);
                    $("#txtCoMorbiditiesTextArea").val(morbidies);

                    let tstage = response[0].T;
                    let nstage = response[0].N;
                    let mstage = response[0].M;
                    let weight = response[0].WEIGHT;
                    let height = response[0].HEIGHT;
                    let bsa = response[0].BSA;
                    let TranID = response[0].TRANID;

                    $("#txtTstage").val(tstage);
                    $("#txtNstage").val(nstage);
                    $("#txtMstage").val(mstage);
                    $("#txtWeight").val(weight);
                    $("#txtHeight").val(height);
                    $("#txtBSA").val(bsa);
                    $("#txtTRANID").val(TranID);

                    $("#ChkHours").prop("checked", true);
                    $("#txtDurationHrs").val(response[0].DURATION);
                    //if (response[0].HRSORDAY == "H") {
                    //    $("#ChkHours").prop("checked", true);
                    //    $("#txtDurationHrs").val(response[0].DURATION);
                    //}
                    //else if (response[0].HRSORDAY == "D") {
                    //    $("#ChkDay").prop("checked", true);
                    //    $("#txtDurationDays").val(response[0].DURATION);
                    //}
                    //else {
                    //    $("#ChkHours").prop("checked", false);
                    //    $("#ChkDay").prop("checked", false);
                    //}

                    gaction = "E";
                    $("#btnSave").text('💾 Update');
                    $("#btnPrint").show();
                }
                else {
                    $("#btnPrint").hide();
                }
                DurationShowHide();
            },
            error: function (xhr, status, error) {
                console.log("error =>", status);
            },
            complete: function () {
                HoldOn.close();
            }
        })
    }

    function DurationShowHide() {
        if ($("#ChkHours").prop("checked") == true) {
            $("#txtDurationHrs").show();
            $("#txtDurationDays").hide();
            $("#txtDurationDays").val("");
        }
        //else if ($("#ChkDay").prop("checked") == true) {
        //    $("#txtDurationDays").show();
        //    $("#txtDurationHrs").hide();
        //    $("#txtDurationHrs").val("");
        //}
        else {
            $("#txtDurationDays").hide();
            $("#txtDurationHrs").hide();
            $("#txtDurationHrs").val("");
            $("#txtDurationDays").val("");
        }
    }

    function AppendPerformStatus() {
        $("#cmbPerformanceStatus").empty();
        var Option = "<option value='{OPTVALUE}'>{OPTTEXT}</>"
        $.grep(PerformStatusList, function (a) {
            var RplOption = Option.replace("{OPTVALUE}", a.VALUE).replace("{OPTTEXT}", a.TEXT);
            $("#cmbPerformanceStatus").append(RplOption);
        });
    }

    function PrintChemo() {
        HoldOn.open();
        var DataToSend = {
            MRNo: $.session.get('PatMRNO'),
            ConsultNo: $.session.get('ChemoConsultNo')
        }
        $.ajax({
            url: '../DoctorDesk/PrintChemoPlanning',
            data: DataToSend,
            type: 'post',
            async: false,
            success: function (response) {
                var win = window.open('../DoctorDesk/DisplayPrintChemoPlan', "_blank", '', true);
                win.focus();
                HoldOn.close();
            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                $.messager.alert("Error", errorThrown);
                HoldOn.close();
            },
            complete: function () {
                HoldOn.close();
            }
        })
    }
</script>

<div class="" style="text-align: center; padding: 15px;">
    <h3 class="panel-title" style="margin: 0; font-weight: bold; font-size: 1.8em; display: flex; align-items: center; justify-content: center; gap: 10px;">
        <img width="20" height="20" src="../Images/Planning.png">
        <span>Planning <small style="font-weight: normal; font-size: 0.6em; color: #666;">(Chemotherapy Planning)</small></span>
    </h3>
</div>

<div class="form-container">
    <div class="form-row horizontal-3">
        <input type="text" hidden="hidden" id="txtWeight" value="0" />
        <input type="text" hidden="hidden" id="txtHeight" value="0" />
        <input type="text" hidden="hidden" id="txtBSA" value="" />
        <input type="text" hidden="hidden" id="txtTstage" value="0" />
        <input type="text" hidden="hidden" id="txtNstage" value="0" />
        <input type="text" hidden="hidden" id="txtMstage" value="0" />
        <input type="text" hidden="hidden" id="txtTRANID" value="" />
        <div class="form-group">
            <label for="LstChemoCourse">💊 Chemotherapy Course</label>
            <div class="custom-dropdown">
                <%: Html.DropDownListFor(x => x.CouseName,
                    new SelectList((IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem>)Model.LstCourse,"Value", "Text"),
                    "--Select--",
                    new { @id = "LstChemoCourse" }) %>
            </div>
        </div>
        <div class="form-group">
            <label for="LstTreatmentPlan">🎯 Intent of Treatment</label>
            <div class="custom-dropdown">
                <%: Html.DropDownListFor(x => x.TreatmentName,
                new SelectList((IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem>)Model.LstTreatPlan,"Value", "Text"),
                "--Select--",
                new { @id = "LstTreatmentPlan" }) %>
            </div>
        </div>
    </div>
    <div class="form-row">
        <div class="form-group">
            <label for="txtPrevTreatTextArea">🕒 Previous Treatment</label>
            <%= Html.TextAreaFor(x => Model.PrevTreatmentTextArea, new { 
                 id = "txtPrevTreatTextArea", 
                 @class = "TextBxFormat", 
                 rows = "6", 
                 style = "width: 99%; resize: none; min-height: 50%; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" ,
             }) %>
        </div>
    </div>
    <div class="row" style="margin: 0;">
        <div class="col-12 col-sm-6" style="padding: 0;">
            <div class="form-group">
                <label for="cmbPerformanceStatus">🧍 Performance Status </label>
                <div style="display: flex; align-items: center; gap: 10px; padding: 10px; border-left: 1px solid #ddd; width: 100%;">
                    <select id="cmbPerformanceStatus" class="form-control"></select>
                    <span class="info-icon" title="Performance Status Info" onclick="OpenCloseAlert('O', 'DivPerformStat');">i</span>
                </div>
            </div>
            <div class="form-group">
                <label for="txtCoMorbiditiesTextArea">⚠️ Co-morbidities</label>
                <div style="display: flex; align-items: center; gap: 10px; padding: 10px; border-left: 3px solid #ccc; background: #f9f9f9;">
                    <%= Html.TextAreaFor(x => Model.CoMorbiditiesTextArea, new {
                    id = "txtCoMorbiditiesTextArea",
                    @class = "TextBxFormat",
                    rows = "2",
                    style = "width: 100%; resize: none; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;"
                }) %>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-6" style="padding: 0;">
            <div class="form-group">
                <label for="txtHPReport">🩺 H.P. Report</label>
                <div style="display: flex; flex-wrap: wrap; align-items: center; gap: 10px; padding: 10px; border-left: 3px solid #ccc; background: #f9f9f9;">
                    <%= Html.TextAreaFor(x => Model.HPReportTextArea, new {
                    id = "txtHPReport",
                    @class = "TextBxFormat",
                    rows = "2",
                    @readonly = "readonly",
                    style = "width: 100%; resize: none; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;"
                }) %>

                    <label for="txtHPReport">Remark</label>
                    <%= Html.TextAreaFor(x => Model.HPReportRemark, new {
                    id = "txtHPReportRemark",
                    @class = "TextBxFormat",
                    rows = "2",
                    @maxlength = "100",
                    style = "width: 100%; resize: none; padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px;"
                }) %>
                </div>
            </div>
        </div>
    </div>
    <div class="form-row horizontal-2">
        <div class="form-group">
            <label for="txtModificationTextArea">🛠️ Modification During Treatment </label>
            <%= Html.TextAreaFor(x => Model.ModifttreatTextArea, new { 
              id = "txtModificationTextArea", 
              @class = "TextBxFormat", 
              rows = "6", 
              style = "width: 99%; resize: none; min-height: 40%; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" ,
          }) %>
        </div>
    </div>
    <div class="form-row">
        <div class="form-group">
            <label for="LstChemoTName">💉 Chemotherapy Name / Protocol </label>
            <div class="custom-dropdown">
                <%: Html.DropDownListFor(x => x.ChemotherapyName,
                 new SelectList((IEnumerable<OncologyEMR.CommonSerRef.SelectLstItem>)Model.LstChemoName,"Value", "Text"),
                 "--Select--",
                 new { @id = "LstChemoTName" }) %>
            </div>
            <div style="display: flex; align-items: center; gap: 10px; padding: 10px; border-left: 1px solid #ddd; width: 100%;">
                <%= Html.TextAreaFor(x => Model.ChemoTextArea, new { 
                    id = "txtChemoTextArea", 
                    @class = "TextBxFormat", 
                    rows = "8", 
                    style = "width: 100%; resize: none; min-height: 50%; padding: 5px; border: 1px solid #ccc; border-radius: 4px;" ,
                }) %>
            </div>
            <div style="display: flex; align-items: center; gap: 10px; padding: 10px; border-left: 1px solid #ddd; width: 100%; flex-wrap: wrap;">
                <div style="display: flex; align-items: center;">
                    <input style="margin: 0;" type="radio" name="DurType" id="ChkHours" onchange="DurationShowHide()" />
                    <label style="margin: 0; padding-left: 10px; padding-right: 10px;">Hours</label>
                    <input style="margin: 0;display:none" type="radio" name="DurType" id="ChkDay" onchange="DurationShowHide()" />
                    <label style="margin: 0;display:none" padding-left:" 10px; padding-right: 10px;">Day</label>
                    <div>
                        <%: Html.DropDownListFor(x => x.Duration,new SelectList((IEnumerable<SelectListItem>)Model.LstTreatmentHrs,"Value", "Text"),"Select", new { @id = "txtDurationHrs",@class="form-control" }) %>
                        <%= Html.TextBoxFor(x => Model.Duration, new { id = "txtDurationDays", @class = "form-control",style="width: 70px;",type = "number", maxlength="3",max ="999",min="0"}) %>
                    </div>
                </div>
                <div style="display: flex; align-items: center;">
                    <label for="txtCycles" style="padding: 0px 10px; width: 160px;">🔁 Total No of Cycles </label>
                    <input type="text" class="form-control" id="txtCycles" style="padding: 5px; border: 1px solid #ccc; border-radius: 4px; width: 50px;" maxlength="2" />
                </div>
                <div style="display: flex; align-items: center;">
                    <label for="txtRepeatAfter" style="padding: 0px 10px; width: 160px;">📅 To Repeat After (Days)</label>
                    <input type="text" class="form-control" id="txtRepeatAfter" style="padding: 5px; border: 1px solid #ccc; border-radius: 4px; width: 50px;" />
                </div>
            </div>
        </div>
    </div>
</div>
<hr />
<div style="text-align: center; margin-top: 10px; padding: 10px;">
    <button id="btnSave" style="background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 10px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);" onmouseover="this.style.backgroundColor='#218838'" onmouseout="this.style.backgroundColor='#28a745'">
        💾 Save
    </button>

    <button id="btnPrint" onclick="PrintChemo()" style="display:none; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 10px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);" onmouseover="this.style.backgroundColor='#218838'" onmouseout="this.style.backgroundColor='#28a745'">
        🖨️ Print
    </button>
</div>


