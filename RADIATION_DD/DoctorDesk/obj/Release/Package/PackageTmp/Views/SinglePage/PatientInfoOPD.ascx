<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style>
/*    @keyframes blink {
  0%, 49% {
 color: black; 
}

  50%, 100% {
 color: red; 
}*/

.auto-resize {
    overflow: hidden;
    resize: none; 
    min-height: 40px;
    max-height: 200px; 
}


/* Container for the single-line vitals */
.vitals-strip {
    display: flex;
    align-items: center;
    background: transparent;
    padding: 0;
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
}

/* Individual vital containers */
.vital-box {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 13px;
    white-space: nowrap;
}

/* Label styling (Weight, Height, etc.) */
.vital-box .label {
    color: #6c757d; /* Muted grey */
    font-weight: 400;
}

/* Value styling (The numbers/units) */
.vital-box .val {
    color: #212529; /* Dark text */
    font-weight: 600;
}

/* Alert styling for high Temp or abnormal BP */
.val-alert {
    color: #d93025 !important; /* Medical Alert Red */
}

/* The vertical | separator */
.vital-separator {
    height: 14px;
    width: 1px;
    background-color: #dee2e6;
    margin: 0 10px;
}

/* Icon button styling in the header */
.btn-header {
    background: none;
    border: none;
    padding: 4px 8px;
    color: #5f6368;
    cursor: pointer;
}

.btn-header:hover {
    color: #000;
}

/* Badge for Notes (red circle) */
.nt-badge {
    position: absolute;
    top: -2px;
    right: 0px;
    background-color: #d93025;
    color: #fff;
    font-size: 10px;
    padding: 1px 4px;
    border-radius: 50%;
    font-weight: bold;
}

/* Ensure the parent d-flex keeps everything centered */
.d-flex.align-items-center {
    align-items: center !important;
}


.PatientInfo-PatTag {
  animation: blink 1s infinite;
}
.PatientInfo-Profile-Image
{
    width:50px;
    height:50px;
    border:1px solid #f3f3f3;
    margin-right: 10px;
}
.HeaderSection_Vitals_InputFields
{
    flex:1;
    min-width:60px; 
    padding:6px 8px; 
    border:1px solid #d1d1d1; 
    border-top-left-radius:6px; 
    border-bottom-left-radius:6px;
}

.HeaderSection_Vitals_Span
{
    padding:6px 8px;
    background:#f0f0f0; 
    border:1px solid #d1d1d1; 
    border-left:none; 
    border-top-right-radius:6px; 
    border-bottom-right-radius:6px; 
    font-size:0.85em; 
    color:#555;
}
.HeaderSection_Vitals_Label{
    font-size:0.85em; margin-bottom:3px;
}
.HeaderSection_Vitals_InputFieldMainDiv
{
    flex:1 1 150px; 
    display:flex; 
    flex-direction:column;
}
.HeaderSection_Vitals_InputFieldSubDiv{
    display:flex;
}
.HeaderSection_VitalDetails_MainDiv{
    font-family:Segoe UI, Arial; 
    display:flex; 
    flex-direction:column; 
    gap:15px;
}
.HeaderSection_VitalDetails_Section1{
    display:flex; 
    justify-content:space-between; 
    align-items:center;
}
.HeaderSection_VitalDetails_Section1_Div1_Heading1{
    color:green; font-weight:700; font-size:1.2em;
    display:none;
}
.HeaderSection_VitalDetails_Section1_Div1_Heading2
{
    color:green; font-weight:600; font-size:1em; margin-top:4px;
}
.HeaderSection_VitalDetails_Section1_Div2{
    display:flex; 
    gap:10px;
    position:fixed;
    right:30px;
    z-index:9999;
}
.HeaderSection_VitalDetails_Section1_Div2_Btn1{
    padding:6px 14px; 
    border:1px solid green; 
    border-radius:6px; 
    background:white; 
    color:green; 
    cursor:pointer;
}
.HeaderSection_VitalDetails_Section1_Div2_Btn2
{
    padding:6px 14px; 
    border:1px solid green; 
    border-radius:6px; 
    background:green; 
    color:white; 
    cursor:pointer;
    position:sticky;
    z-index: 9999;
    top:20px;
}
.HeaderSection_VitalDetails_Section2_MainDiv , 
.HeaderSection_VitalDetails_Section3_MainDiv
{
    border:1px solid #ccc; 
    border-radius:10px; 
    padding:15px; 
    display:flex; 
    flex-wrap:wrap; 
    gap:15px;
}
.HeaderSection_VitalDetails_Section2_SubDiv,
.HeaderSection_VitalDetails_Section3_SubDiv,
.HeaderSection_VitalDetails_Section4_SubDiv
{
    width:100%; 
    color:black; 
    font-weight:600; 
    margin-bottom:10px;
}
.HeaderSection_VitalDetails_Section4_MainDiv
{
    border:1px solid #ccc; border-radius:10px; padding:15px; display:flex; flex-wrap:wrap; gap:20px;
}
.vitals-disabled {
    background-color: #f2f2f2;
    color: #888;
    border: 1px solid #ccc;
    cursor: not-allowed;
}

.vitals-disabled:focus {
    outline: none;
    box-shadow: none;
}



.h-icon-size {
    width: 28px;
    height: 28px;
    border: 1px solid transparent;
    border-radius: 4px;
    padding: 1px;
    transition: all 0.3s ease;
    object-fit: contain;
}

    .h-icon-size:hover {
       /* border-color: #007bff;*/
        box-shadow: 0 4px 15px rgba(0, 123, 255, 0.2);
        transform: translateY(-5px);
        /*background-color: #fff;*/
    }

    .h-icon-size.disabled {
        pointer-events: none;
        cursor: auto;
    }
</style>

<script type="text/javascript">
    var ageOfPat = sessionStorage.getItem("PatAge");
    var VitalsWeightLmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalWeight")%>';
    var VitalsHeightLmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalHeight")%>';
    var VitalsTempLmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalTemp")%>';
    var VitalsBPLmt1 = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalBP1")%>';
    var VitalsBPLmt2 = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalBP2")%>';
    var VitalsRespRateLmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalRespRate")%>';
    var VitalsSPO2Lmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalSPO2")%>';
    var VitalsBMILmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalBMI")%>';
    var VitalsBSALmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalBSA")%>';
    var VitalsPulseLmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalPulse")%>';//priyanka 16/03/2026
    var VitalsRBSLmt = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("MaxValForVitalRBS")%>';//priyanka 16/03/2026
    var HidePulseType = '<%:OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("HidePulseType")%>';
    var SummarizeYN = '<%= ConfigurationManager.AppSettings["SummarizeYN"]%>';
    var userScrolling = false;
    $(document).ready(function () {
        $(document).on("click", function (e) {
            if (!$(e.target).closest("#btnVitalsQuickView").length) {
                $("#VitalsQuickViewDropdown").removeClass("show");
            }
        });
        document.getElementById("OPDContentMainDiv").addEventListener("wheel", () => userScrolling = true);
        document.getElementById("OPDContentMainDiv").addEventListener("touchmove", () => userScrolling = true);
        document.getElementById("OPDContentMainDiv").addEventListener("keydown", (e) => {
            if (["ArrowUp", "ArrowDown", "PageUp", "PageDown", "Home", "End"].includes(e.key)) {
                userScrolling = true;
            }
        });
        document.getElementById("OPDContentMainDiv").addEventListener("scroll", function () {
            if (userScrolling) {
                let dropdowns = document.getElementsByClassName("tabulator-edit-list");
                for (let i = 0; i < dropdowns.length; i++) {
                    dropdowns[i].style.display = "none";
                }
                let DatePickers = document.getElementsByClassName("ui-datepicker");
                for (let i = 0; i < DatePickers.length; i++) {
                    DatePickers[i].style.display = "none";
                }
                userScrolling = false;
            }
        });
        SetHeaderPatientDetails();
        GetDataForVitals();
        document.getElementById("OPDPatientDashboard_BackBtn").addEventListener("click", function () {
            //sessionStorage.setItem('ConsultationDate', '');
            window.location.href = "../SinglePage/WaitingListOPD";
        });

        $(document).on("change", "#Vitals_txtWeight", function () {
            SetWeightLoss();
            CalBMI();
        });

        $(document).on("change", "#Vitals_txtHeight", function () {
            CalBMI();
        });

        $(document).on("change", "#Vitals_txtWaist", function () {
            CalWHR();
        });

        $(document).on("change", "#Vitals_txtHip", function () {
            CalWHR();
        });
        BindPatRefNote();
        $(document).on("click", "button[name='vitalhisttblgraph']", function () {
            let val = $(this).val();
            $(".vh-tab-btn").removeClass("active");
            $(this).addClass("active");
            if (val == "G") {
                $('#VitalHistorygraphsDiv').show();
                $('#VitalHistorytbldiv').hide();
            }
            else if (val == "T") {
                $('#VitalHistorygraphsDiv').hide();
                $('#VitalHistorytbldiv').show();
            }
            else {
                $('#VitalHistorygraphsDiv').show();
                $('#VitalHistorytbldiv').show();
            }
        });
        $(document).on("input", ".decimal-validation", function () {
            var value = $(this).val();
            value = value.replace(/[^0-9.]/g, '');

            var parts = value.split('.');
            if (parts.length > 2) {
                value = parts[0] + '.' + parts[1];

            }
            $(this).val(value);
        });

        
        $(document).on("blur", "#Vitals_txtTemperature", function () {

            var val = $.trim($(this).val());

            if (val === "")
                return;

            var num = parseFloat(val);

            if (!isNaN(num)) {
                $(this).val(num.toFixed(1));
            }
        });

        /*Added By Devendra - 28042026 */
        $(document).on("mousedown", function (e) {
            if (!$(e.target).closest(
                "#Vitals_txtWalkingDuration, #Vitals_txtWalkingDuration_list, " +
                "#Vitals_txtWalkingDurationDays, #Vitals_txtWalkingDurationDays_list," +
                "#Vitals_txtBPSystolic , #Vitals_txtBPSystolic_list, " +
                "#Vitals_txtBPDiastolic , #Vitals_txtBPDiastolic_list "
            ).length) {

                $("#Vitals_txtWalkingDuration_list").hide();
                $("#Vitals_txtWalkingDurationDays_list").hide();
                $("#Vitals_txtBPSystolic_list").hide();
                $("#Vitals_txtBPDiastolic_list").hide();
            }
        });
        if (HidePulseType == "Y") {
            $("#divPulseCond").hide();
        }
        else {
            $("#divPulseCond").show();
        }
        
    });


    function openDropdown(currentListId) {
        $("#Vitals_txtWalkingDuration_list, #Vitals_txtWalkingDurationDays_list").hide();
        $(currentListId).show();
    }

    $("#Vitals_txtWalkingDuration").on("click focus", function () {
        openDropdown("#Vitals_txtWalkingDuration_list");
    });

    $("#Vitals_txtWalkingDurationDays").on("click focus", function () {
        openDropdown("#Vitals_txtWalkingDurationDays_list");
    });
    function GetLblCodeData(strMrNo, ClickType) {
        if (strMrNo != undefined && strMrNo != null && strMrNo != "") {
            ClickType == "Y" ? startLoading("", "loading-VitalsQuickInfo"): startLoading("Loading","loading-PatientInfo");
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetAllHistoryCounts",
                data: { strMrNo: strMrNo },
                async: true,
                success: function (data) {
                    if (data.InvestNotifCode != "" && $("#HeaderSection_PatDetails_lblInvNotiCD") != undefined) {
                        $("#HeaderSection_PatDetails_lblInvNotiCD").text('Code : ' + data.InvestNotifCode);
                        $("#HeaderSection_PatDetails_lblInvNotiCD").show();
                    }
                    else {
                        $("#HeaderSection_PatDetails_lblInvNotiCD").hide();
                    }

                    ClickType == "Y" ? stopLoading("loading-VitalsQuickInfo") : stopLoading("loading-PatientInfo");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ClickType == "Y" ? stopLoading("loading-VitalsQuickInfo") : stopLoading("loading-PatientInfo");
                    ToastMsg(textStatus, "error");
                }
            });
        }
    }

    function SetHeaderPatientDetails() {
        // Patient Name with category in brackets
        $("#HeaderSection_PatDetails_PatName").text(sessionStorage.getItem('PatName') + ' (' + sessionStorage.getItem('OPDCompNM') + ')');
        $("#HeaderSection_PatDetails_MRNO").text(sessionStorage.getItem('PatMRNO'));
        $("#HeaderSection_PatDetails_GENDER").text(sessionStorage.getItem('PatGender'));
        $("#HeaderSection_PatDetails_AGE").text(sessionStorage.getItem('PatAge'));
        $("#HeaderSection_PatDetails_IPDPatImg").attr("src", sessionStorage.getItem("OPDPatImgURL"));
    }

    function GetDataForVitals(ClickType = "") {
        var selMrno = sessionStorage.getItem('PatMRNO');
        var Type = "";
        var tranNo = sessionStorage.getItem('PatTRANNO');
        ClickType == "Y" ? startLoading("", "loading-VitalsQuickInfo") : startLoading("Loading", "loading-PatientInfo");
        $.ajax({
            type: 'post',
            datatype: 'json',
            async: true,
            url: '../DoctorDesk/SetDataForVitals',
            data: { strTranNo: tranNo, Type: Type, strMRNo: selMrno },
            success: function (data) {
                if (data != "") {
                    SetDataForVitals(data);
                }
                GetLblCodeData(sessionStorage.getItem('PatMRNO'), ClickType);
                ClickType == "Y" ? stopLoading("loading-VitalsQuickInfo") : stopLoading("loading-PatientInfo");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                ClickType == "Y" ? stopLoading("loading-VitalsQuickInfo") : stopLoading("loading-PatientInfo");
            }
        });
    }

    function SetDataForVitals(data) {
        //debugger;
        var SplitBP = (data["BP"] || "").toString().split("/");
        var BP1 = SplitBP[0] || "";
        var BP2 = SplitBP[1] || "";
        var vitalsMap = [
                     { id: "VitalsDetails_txtWeight", key: "Weight", unit: " kg" },
                     { id: "VitalsDetails_txtHeight", key: "HEIGHT", unit: " cm" },
                     { id: "VitalsDetails_txtTemp", key: "TEMP", unit: " °F" },
                     { id: "VitalsDetails_txtPulse", key: "Pulse", unit: " bpm" },
                     { id: "VitalsDetails_txtRR", key: "RESP", unit: " Breaths/Minute" },
                     { id: "VitalsDetails_txtSPO2", key: "SPO2", unit: " %" },
                     { id: "VitalsDetails_txtPainScore", key: "Pain Score", unit: "" },
                     { id: "VitalsDetails_txtBMI", key: "BMI", unit: "kg/m²" },
                     { id: "VitalsDetails_txtBSA", key: "BSA", unit: "m²" },
                     { id: "VitalsDetails_txtRBS", key: "RBS", unit: " mg/dl" }
        ];
        for (var i = 0; i < vitalsMap.length; i++) {
            var vital = vitalsMap[i];
            var value = data[vital.key];
            $("#" + vital.id).text(value + vital.unit);
            checkVitalsDataMaxVal(vital.id, value);
        }
        checkVitalsDataMaxVal("VitalsDetails_txtBP1", BP1);
        checkVitalsDataMaxVal("VitalsDetails_txtBP2", BP2);
        $("#VitalsDetails_txtWeight").text(((data["Weight"] == "" || data["Weight"].trim()  == 0.00) ? "--" : data["Weight"] )+ " kg");
        $("#VitalsDetails_txtHeight").text(((data["HEIGHT"] == "" || data["HEIGHT"].trim() == 0.00)? "--" : data["HEIGHT"] )+ " cm");/* $("#VitalsDetails_txtHeight").text(data["HEIGHT"] + " Cm");*/
        /* $("#VitalsDetails_txtTemp").text(((data["TEMP"] == "" || data["TEMP"].trim() == 0.00) ? "--" : data["TEMP"]) + "°f");*/
        var tempVal = data["TEMP"];

        $("#VitalsDetails_txtTemp").text(
            (tempVal == "" || parseFloat(tempVal) == 0
                ? "--"
                : parseFloat(tempVal).toFixed(1))
            + "°F"
        );
        $("#VitalsDetails_txtPulse").text(((data["PULSE"] == "" || data["PULSE"].trim() == 0.00) ? "--" : data["PULSE"]) + "bpm"); //priyanka 16/03/2026

        $("#VitalsDetails_txtBP1").text(BP1);
        if (BP2 != "")
        {
            $("#VitalsDetails_txtBP2").text("/" + BP2 + " mmHg"); //priyanka 03/04/2026
        }
        else {
            $("#VitalsDetails_txtBP2").text("-- mmHg");//priyanka 03/04/2026
        }
        $("#VitalsDetails_txtRR").text(((data["RESP"] == "" || data["RESP"].trim() == 0.00) ? "--" : data["RESP"]) + " Breaths/Minute");//priyanka 16/03/2026
        $("#VitalsDetails_txtSPO2").text(((data["SPO2"] == "" || data["SPO2"].trim()==0.00)?"--":data["SPO2"]) + " %");
        $("#VitalsDetails_txtBMI").text(((data["BMI"] == "" || data["BMI"].trim()==0.00)?"--":data["BMI"]) + " kg/m²");
        $("#VitalsDetails_txtBSA").text(((data["BSA"] == "" || data["BSA"].trim() == 0.00) ? "--" : data["BSA"]) + " m²");

        //priyanka 16/03/2026
        // $("#VitalsDetails_txtPainScore").text(((data["PAINSCORE"] == "" || data["PAINSCORE"].trim() == 0.00) ? "--" : data["PAINSCORE"]) + "");

        //Added By devendra 
        var painLabels = ["No Pain", "Very Mild", "Hurts Little Bit", "Tolerable", "Hurts Little More", "Very Distressing", "Hurts Even More", "Very Intense", "Hurts Whole Lot", "Unbearable", "Hurts Worst"];

        var score = parseInt(data["PAINSCORE"]);

        $("#VitalsDetails_txtPainScore").text(
            isNaN(score) ? "--" : score + " (" + painLabels[score] + ")"
        );
        $("#VitalsDetails_txtRBS").text(((data["RBS"] == "" || data["RBS"].trim() == 0.00) ? "--" : data["RBS"]) + " mg/dl");
        $("#txtProxyYN").val(data["PROXYVISITYN"]);
        //end
        SetWeightLoss();//priyanka 17/04/2026
        vitalClone();
        HideShowProxy();
    }

    function SetWeightLoss() {
        var currWt = $("#Vitals_txtWeight").val();
        var prevWt = $("#Vitals_txtPreviousWeight").val();
        if (currWt != "" && prevWt != "" && Number(prevWt) > 0 && Number(currWt) > 0) {
            var diffWt = Number(currWt) - Number(prevWt);
            diffWt = (Number(diffWt) < 0 ? "" : "+") + Number(diffWt).toFixed(2);
            $("#Vitals_txtWeightLoss").val(diffWt);
        }
        else
            $("#Vitals_txtWeightLoss").val(0);
    }

    function CalBMI() {
        var sum = 0;
        if ($("#Vitals_txtWeight").val() != 0 && $("#Vitals_txtHeight").val() != 0) {
            sum = Number($("#Vitals_txtWeight").val()) / (((Number($("#Vitals_txtHeight").val())) / 100) * ((Number($("#Vitals_txtHeight").val())) / 100));
        }
        $('#Vitals_txtBMI').val(sum.toFixed(2));
        CalBSA();
    }

    function CalBSA() {
        var height = parseFloat($("#Vitals_txtHeight").val());
        var weight = parseFloat($("#Vitals_txtWeight").val());
        var myBSA = Math.sqrt((weight * height) / 3600);
        var bsa = myBSA.toFixed(2);
        if (isNaN(bsa)) bsa = 0;
        $('#Vitals_txtBSA').val((bsa));
    }

    function CalWHR() {
        var sum = 0;
        if ($("#Vitals_txtWaist").val() != 0 && $("#Vitals_txtHip").val() != 0) {
            sum = Number($("#Vitals_txtWaist").val()) / Number($("#Vitals_txtHip").val());
        }
        $('#Vitals_txtWHR').val(sum.toFixed(2));
    }

    function validateWeightHeight(input, maxValue) {
        input.value = input.value.replace(/[^0-9.]/g, '');
        if ((input.value.match(/\./g) || []).length > 1) {
            input.value = input.value.substring(0, input.value.length - 1);
            return;
        }
        let value = parseFloat(input.value);
        if (value > Number(maxValue)) {
            input.value = parseFloat(maxValue).toFixed(2);
        } else if (value < 0 || isNaN(value)) {
            input.value = '0.00';
        }
    }

    function checkdata() {
        if (isNaN(String.fromCharCode(event.keyCode))) return false;
        else return (event.keyCode != 32 && event.which != 32);
    }

    function SaveVitals(str) {
        var flag = true;
        var strWt = "" + $('#Vitals_txtWeight').val();
        var strHt = "" + $('#Vitals_txtHeight').val();
        var strTp = "" + $('#Vitals_txtTemperature').val();
        var strPu = "" + $('#Vitals_txtPulse').val();
        var strWtRemark = $("#Vitals_txtWeight_Status").val();
        var strHtRemark = $("#Vitals_txtHeight_Status").val();
        if (!ValidateHeightandWeightRemark(strHt, strHtRemark)) {
            var strMsg = "Please Enter Height.";
            ToastMsg(strMsg, "Info");
            return false
        }
        if (!ValidateHeightandWeightRemark(strWt, strWtRemark)) {
            var strMsg = "Please Enter Weight.";
            ToastMsg(strMsg, "Info");
            return false
        }


        //Validate Vitals Priyanka 16/03/2026
        if ($("#Vitals_txtTemperature").val() === "" || $("#Vitals_txtTemperature").val() === null || $("#Vitals_txtTemperature").val() === undefined) {
            var strMsg = "Please Enter Temprature.";
            ToastMsg(strMsg, "Info");
            focus("#Vitals_txtTemperature");
            return false
        }
        if ($("#Vitals_txtPulse").val() === "" || $("#Vitals_txtPulse").val() === null || $("#Vitals_txtPulse").val() === undefined) {
            var strMsg = "Please Enter Pulse.";
            ToastMsg(strMsg, "Info");
            focus("#Vitals_txtPulse");
            return false
        }
        if (HidePulseType != "Y") {
            if ($("#Vitals_hdnPulseCond").val() === "" || $("#Vitals_hdnPulseCond").val() === null || $("#Vitals_hdnPulseCond").val() === undefined) {
                var strMsg = "Please Select Pulse Type.";
                ToastMsg(strMsg, "Info");
                return false
            }
        }
        if ($("#Vitals_txtBPSystolic").val() === "" || $("#Vitals_txtBPSystolic").val() === null || $("#Vitals_txtBPSystolic").val() === undefined) {
            var strMsg = "Please Select BP Systolic.";
            ToastMsg(strMsg, "Info");
            focus("#Vitals_txtBPSystolic");
            return false
        }
        if ($("#Vitals_txtBPDiastolic").val() === "" || $("#Vitals_txtBPDiastolic").val() === null || $("#Vitals_txtBPDiastolic").val() === undefined) {
            var strMsg = "Please Select BP Diastolic.";
            focus("#Vitals_txtBPDiastolic");
            ToastMsg(strMsg, "Info");
            return false
        }
        if ($("#Vitals_txtRespRate").val() === "" || $("#Vitals_txtRespRate").val() === null || $("#Vitals_txtRespRate").val() === undefined) {
            var strMsg = "Please Enter Respiratory Rate.";
            ToastMsg(strMsg, "Info");
            //focus("#Vitals_txtRespRate");
            //$("#Vitals_txtRespRate").css('border', '1px solid red');
            return false
        }
        if ($("#Vitals_txtSpO2").val() === "" || $("#Vitals_txtSpO2").val() === null || $("#Vitals_txtSpO2").val() === undefined) {
            var strMsg = "Please Enter SPO2.";
            ToastMsg(strMsg, "Info");
            focus("#Vitals_txtSpO2");
            return false
        }
        if ($("#Vitals_txtRBS").val() === "" || $("#Vitals_txtRBS").val() === null || $("#Vitals_txtRBS").val() === undefined) {
            var strMsg = "Please Enter Random Blood Sugar.";
            ToastMsg(strMsg, "Info");
            focus("#Vitals_txtRBS");
            return false
        }
        //Devendra => Head Circumference  should not be mandatory 

        //if ($("#Vitals_txtHeadCirc").val() === "" || $("#Vitals_txtHeadCirc").val() === null || $("#Vitals_txtHeadCirc").val() === undefined) {
        //    var strMsg = "Please Enter Head Circumference.";
        //    ToastMsg(strMsg, "Info");
        //    focus("#Vitals_txtHeadCirc");
        //    return false
        //}
        //End
        var PainScore = $("#Vitals_hdnPainScore").val();
        if (PainScore == undefined)
            PainScore = "";
        var strSystolicVal = $("#Vitals_txtBPSystolic").val();
        var strDiastolicVal = $("#Vitals_txtBPDiastolic").val();
        if (strSystolicVal == "" && strDiastolicVal != "") {
            $("#Vitals_txtBPSystolic").css('border-color', 'red');
            $("#Vitals_txtBPDiastolic").css('border-color', '');
            flag = false;
            strMsg = "Please enter required field";
        } else if (strSystolicVal != "" && strDiastolicVal == "") {
            $("#Vitals_txtBPSystolic").css('border-color', '');
            $("#Vitals_txtBPDiastolic").css('border-color', 'red');
            flag = false;
            strMsg = "Please enter required field";
        }
        var strBp = strSystolicVal + "/" + strDiastolicVal;
        var streleTp = "" + $('#Vitals_txteleTemp').val();
        var strelePu = "" + $('#Vitals_txtelePulse').val();
        var streleSystolicVal = $("#Vitals_eleSelSystolic").val();
        var streleDiastolicVal = $("#Vitals_eleSelDiastolic").val();
        if (streleSystolicVal == "" && streleDiastolicVal != "") {
            $("#Vitals_eleSelSystolic").css('border-color', 'red');
            $("#Vitals_eleSelDiastolic").css('border-color', '');
            flag = false;
            strMsg = "Please enter required field";
        } else if (streleSystolicVal != "" && streleDiastolicVal == "") {
            $("#Vitals_eleSelSystolic").css('border-color', '');
            $("#Vitals_eleSelDiastolic").css('border-color', 'red');
            flag = false;
            strMsg = "Please enter required field";
        }
        var streleBp = streleSystolicVal + "/" + streleDiastolicVal;
        var strRp = "" + $('#Vitals_txtRespRate').val();
        var strOt = "" + "";
        var strPrev = "" + $('#Vitals_txtPreviousWeight').val();
        var strTran = sessionStorage.getItem("PatTRANNO").toString();
        var strMr = sessionStorage.getItem("PatMRNO").toString();
        var strWalkngYN = $("#Vitals_hdnWalkingYN").val();
        var strDietYN = $("#Vitals_hdnDietYN").val();
        var strMedicineYN = $("#Vitals_hdnRegMedYN").val();
        var strWalkDur = $("#Vitals_txtWalkingDuration").val();
        var strWalkDurType = $("#Vitals_txtWalkingDurationDays").val().substr(0, 1);
        var strSPO2 = $("#Vitals_txtSpO2").val();
        var strPulseCond = $("#Vitals_hdnPulseCond").val();
        var strBMI = $("#Vitals_txtBMI").val();
        var strBSA = $("#Vitals_txtBSA").val();
        var strRBS = $("#Vitals_txtRBS").val();
        var strkarkyscore = $("#Vitals_txtKarnofsky").val();
        var strEcogScore = $("input[name='Vitals_EOCGScore']:checked").val();
        var strHeadCircf = "";
        if ($("#Vitals_txtHeadCirc").length > 0) {
            strHeadCircf = $("#Vitals_txtHeadCirc").val();
        }
        var strPerf = $("#Vitals_txtPEFR").val();
        var strTech = $("#Vitals_hdnTechniqueVal").val();
        var strCompli = $("#Vitals_hdnComplianceVal").val();
        var strIBW = "" + $('#Vitals_txtIBW').val();
        var strBWPerc = "" + $('#Vitals_txtBWPercent').val();
        var strWaistCircum = "" + $('#Vitals_txtWaist').val();
        var strHip = "" + $('#Vitals_txtHip').val();
        var strWHR = "" + $('#Vitals_txtWHR').val();
        var strCmbWeight = $("#Vitals_txtWeight_Status").val();
        var strCmbHeight = $("#Vitals_txtHeight_Status").val();
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
                strSPO2: strSPO2,
                strBMI: strBMI,
                strHeadCircf: strHeadCircf,
                strPEFR: strPerf,
                strTechnique: strTech,
                strCompliance: strCompli,
                streleTemp: streleTp,
                strelePulse: strelePu,
                streleBlood: streleBp,
                strPainScore: PainScore,
                strBSA: strBSA,
                strRBS: strRBS,
                strkarkyscore: strkarkyscore, strEcogScore: strEcogScore, strPulseCond: strPulseCond,
                strIBW: strIBW, strBWPerc: strBWPerc, strWaistCircum: strWaistCircum, strHip: strHip, strWHR: strWHR, //Added by Murali on 25/04/2024
                strCmbWeight: strCmbWeight, strCmbHeight: strCmbHeight
            }
        SaveForNutrSrc(dataToSend);
        startLoading("Loading");
        if (flag) {
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/SaveVitals',
                datatype: "json",
                data: dataToSend,
                async: true,
                success: function (result) {
                    if (str == 'SS') {
                        if (result.toUpperCase().includes("SUCCESS") === true)
                        {
                            ToastMsg(result, "Success");
                            GetDataForVitals();//priyanka 07/03/2026
                        } 
                    }
                    else {
                        if (str != "Y") {
                            if (pathFrom == "") {
                                window.location.href = '../ClinicalNotes/ClinicEntry';
                            } else
                                window.location.href = '../DoctorDesk/PatientEntry';
                        }
                    }
                    stopLoading();
                },
                complete: function () { stopLoading(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) { stopLoading(); }
            });
            return true;
        } else {
            ToastMsg(strMsg, "error");
            stopLoading();
            return false;
        }
    }
    
    function ValidateHeightandWeightRemark(strNum, strRemark) {
        if (strRemark != "" && (strRemark != "04" && (strNum == "" && Number(strNum) == 0))) {
            return false;
        }
        else {
            return true;
        }
    }

    function SaveForNutrSrc(dataToSend) {
        var group0 = $('#tblNutrSrc input[type=radio][name="nsGroup_0"]:checked').val();
        var group1 = $('#tblNutrSrc input[type=radio][name="nsGroup_1"]:checked').val();
        var group2 = $('#tblNutrSrc input[type=radio][name="nsGroup_2"]:checked').val();
        var group3 = $('#tblNutrSrc input[type=radio][name="nsGroup_3"]:checked').val();
        var group4 = $('#tblNutrSrc input[type=radio][name="nsGroup_4"]:checked').val();
        var group5 = $('#tblNutrSrc input[type=radio][name="nsGroup_5"]:checked').val();
        dataToSend.NutriScore = $("#nsTotal").val();
        dataToSend.NutriScoreNA = $('#chkNutrSrcNA').prop("checked") == true ? "Y" : "N";
        dataToSend.NutriDescreseFoodInTake = group0 === "" || group0 === null || group0 === undefined ? "" : group0;
        dataToSend.NutriWeightLoss = group1 === "" || group1 === null || group1 === undefined ? "" : group1;
        dataToSend.NutriMobility = group2 === "" || group2 === null || group2 === undefined ? "" : group2;
        dataToSend.NutriAcuteDisease = group3 === "" || group3 === null || group3 === undefined ? "" : group3;
        dataToSend.NutriNeuropsy = group4 === "" || group4 === null || group4 === undefined ? "" : group4;
        dataToSend.NutriBodyHabit = group5 === "" || group5 === null || group5 === undefined ? "" : group5;
    }

    function RollBackDataForVitals() {
        var Type = "R";
        var tranNo = sessionStorage.getItem("PatTRANNO");
        if (tranNo && tranNo.trim() !== "") {
            var Response = GetVitalDetailsInfo(Type);
            var Data = MapVitalsData(Response);
            var contentHtml = HistPopEditVitalDetailsTemp(Data, "");
            $("#Hist_C_EditVitalsInfo").html(contentHtml);
            BindNutritionalData(Data);
        }
    }

    function ResetDataForVitals() {
        $("#txtWghtLG").val("");
        $("#txtCurrWeight").val("");
        $("#txtPrev").val("");
        $("#txtHeight").val("");
        $("#cmbHeight").val("");
        $("#cmbWeight").val("");
        $("#txtTemp").val("");
        $("#txtPulse").val("");
        $("#txtSPO2").val("");
        $("#txtBMI").val("");
        $("#txtBSA").val("");
        $("#txtHeadCirc").val("");
        $("#txtRBS").val(""); $("#txtkarkyscore").val("");
        document.querySelectorAll('input[name="rbtnECOG"]').forEach(function (radio) { radio.checked = false });
        $("#SelSystolic").val("");
        $("#SelDiastolic").val("");
        $('#txtelePulse').val("")        
        $('#txteleTemp').val("");
        $("#eleSelSystolic").val("");
        $("#eleSelDiastolic").val("");    
        $("#txtResp").val("");
        $("#txtOthr").val("");
        $("#Numbers").text("0");
        $("#DaySelect").text("Days");
        $("#rbtnCompliNA").trigger("click");
        $("#btnTechnqNA").trigger("click");
        $("#txtlowestPefr").val("");
        $("#txtHighestPefr").val("");
        $("#btnWalkY").removeClass('btn btn-xs btn-info active');
        $("#btnWalkN").removeClass().addClass('btn btn-xs btn-info active');
        $("#btnWalkY").addClass('btn btn-xs btn-default');
        $("#hdnWalkingYN").val('N');
        $("#btnDietY").removeClass('btn btn-xs btn-info active');
        $("#btnDietN").removeClass().addClass('btn btn-xs btn-info active');
        $("#btnDietY").addClass('btn btn-xs btn-default');
        $("#hdnDietYN").val('N');
        $("#btnRegMedY").removeClass('btn btn-xs btn-info active');
        $("#btnRegMedN").removeClass().addClass('btn btn-xs btn-info active');
        $("#btnRegMedY").addClass('btn btn-xs btn-default');
        $("#hdnRegMedYN").val('N');
        $("#btnPulseIReg").removeClass('btn btn-xs btn-info active');
        $("#btnPulseReg").removeClass().addClass('btn btn-xs btn-info active');
        $("#btnPulseIReg").addClass('btn btn-xs btn-default');
        $("#hdnPulseCond").val('R');
        document.getElementById("divRollBack").style.display = "block";
        $("#txtIBW").val("");
        $("#txtBWPerc").val("");
        $("#txtWaistCircum").val("");
        $("#txtHip").val("");
        $("#txtWHR").val("");
    }

    function BindNutritionalData(Data) {
        if (Data === "" || Data === null || Object.keys(Data).length === 0) {
            $("#nsTotal").prop('disabled', true);
        }
        else {
            if (Data.NutriScoreNA === "N") {
                $("#rbtnD_" + Data.NutriDescreseFoodInTake).prop("checked", true);
                $("#rbtnW_" + Data.NutriWeightLoss).prop("checked", true);
                $("#rbtnM_" + Data.NutriMobility).prop("checked", true);
                $("#rbtnA_" + Data.NutriAcuteDisease).prop("checked", true);
                $("#rbtnN_" + Data.NutriNeuropsy).prop("checked", true);
                $("#rbtnB_" + Data.NutriBodyHabit).prop("checked", true);
                $("#chkNutrSrcNA").prop("checked", false);
                $("#nsTotal").prop('disabled', true);
                calculateNSTotal();
            }
            else if (Data.NutriScoreNA === "Y") {
                $("#chkNutrSrcNA").prop("checked", true);
                IsNutriScreen();
            }
        }
    }

    function FillBPList() {
        var arreay = [];
        for (var i = 0; i <= 300; i++) {
            arreay.push(i.toString());
        }
        var len = $(".triggerInputBP").closest("input[type='text']").prevObject.length;
        for (var i = 0; i < len  ; i++) {
            var text = $(".triggerInputBP").closest("input[type='text']").prevObject[i];
            var txtObj = $("#" + text.id);
            txtObj.autocomplete({
                source: arreay,
                minLength: 0,
                open: function (event, ui) {
                    $(".ui-autocomplete").css({
                        "max-height": "200px",
                        "overflow-y": "auto"
                    });
                }
            }).focus(function () {
                $(this).autocomplete("search", "");
            });
        }
    }

    function IsNutriScreen() {
        if ($('#chkNutrSrcNA').prop("checked") == true) {
            $("#tblNutrSrc input[type='radio']").attr('checked', false);
            $("#tblNutrSrc input[type='radio']").attr("disabled", "disabled");
            $("#nsTotal").val("");
            $("#nsTotal").prop('disabled', true);
        }
        else {
            $("#tblNutrSrc input[type='radio']").prop('disabled', false);
            $("#tblNutrSrc input[type='radio']").attr('checked', false);
            $("#nsTotal").val("0");
            $("#nsTotal").prop('disabled', true);
        }
    }

    function MapPatientData(Response) {
        if (!Response || !Response.rows || Response.rows.length === 0) return null;
        var cell = Response.rows[0].cell;
        var Data = {
            MR: cell[0] || "",
            Name: cell[1] || "",
            DOB: cell[2] || "",
            Age: cell[3] || "",
            Gender: cell[4] || "",
            Address: cell[5] || "",
            Address2: cell[6] || "",
            Category: cell[8] || "",
            Company: cell[11] || "",
            PayType: cell[12] || "",
            Contact: cell[10] || "",
            Tariff: cell[9] || "",
            Priority: cell[25],
            Amount: cell[14] || "0.00",
            AvailableLimit: cell[15] || "0.00",
            Balance: cell[21] || "0.00",
            Email: cell[32] || ""
        };
        return Data;
    }

    function GetBindPatandBillInfo() { 
        var mrno = sessionStorage.getItem("PatMRNO");
        var Result = [];
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GETOPSEARCHDATA',
            datatype: "json",
            async: false,
            data: { SMRNO: mrno, },
            success: function (Response) {
                Result = Response;
            }
        });
        return Result;
    }

    function GetBillInfo() {
        var strConsNo = sessionStorage.getItem("PatTRANNO");
        var Result = [];
        startLoading("Loading");
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GetBillInfo',
            datatype: "json",
            async: false,
            data: { strConsNo: strConsNo, },
            success: function (Response) {
                Result = Response;
                stopLoading();
            }
        });
        return Result;
    }

    function MapBillData(Resoponse2) {
        if (!Resoponse2 || Resoponse2.length === 0) return null;
        var cell = Resoponse2[0];
        var BillData = {
            BillNo: Resoponse2[0]["BillNo"] || "",
            AvailLimit: Resoponse2[0]["AvailLimit"] || "",
            Balance: Resoponse2[0]["Balance"] || "",
            CompName: Resoponse2[0]["CompName"] || "",
            PatCatgName: Resoponse2[0]["PatCatgName"] || "",
            TOTBillAmt: Resoponse2[0]["TOTBillAmt"] || "",
            TariffName: Resoponse2[0]["TariffName"] || "",
        };
        return BillData;
    }

    function HistPopPatientInfoTemp(Data, BillData) {
        var PatInfoData = Data[0];
        function txt(value, width) {
            return "<input type='text' readonly value='" + (value || "") +
                   "' style='width:" + width + "; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px; background:#fff;' />";
        }
        var Res = "";
        Res += "<div style='padding:15px; font-family:Segoe UI, Arial;overflow: auto;'>";
        Res += "<div style='color:#2a66f5; font-weight:600; margin-bottom:10px;'>Patient Info</div>";
        Res += "<table style='width:100%; border-collapse:separate; border-spacing:12px 10px;'>";
        Res += "<tr>" +
            "<td>Name</td>" +
            "<td>" + txt(Data.Title || "Mr", "50px") + "</td>" +
            "<td>" + txt(Data.Name, "180px") + "</td>" +
            "<td>Company</td>" +
            "<td>" + txt(Data.Company, "180px") + "</td>" +
            "<td>Age</td>" +
            "<td>" + txt(Data.Age, "120px") + "</td>" +
            "<td>Gender</td>" +
            "<td>" + txt(Data.Gender, "120px") + "</td>" +
            "</tr>";
        Res += "<tr>" +
            "<td>Category</td>" +
            "<td colspan='2'>" + txt(Data.Category, "250px") + "</td>" +
            "<td>Pay Type</td>" +
            "<td>" + txt(Data.PayType, "180px") + "</td>" +
            "<td>MR</td>" +
            "<td>" + txt(Data.MR, "160px") + "</td>" +
            "<td>Contact</td>" +
            "<td>" + txt(Data.Contact, "140px") + "</td>" +
            "</tr>";
        Res += "<tr>" +
            "<td>Tariff</td>" +
            "<td colspan='2'>" + txt(Data.Tariff, "250px") + "</td>" +
            "<td>DOB</td>" +
            "<td>" + txt(Data.DOB, "180px") + "</td>" +
            "<td>Priority</td>" +
            "<td>" + txt(Data.Priority, "160px") + "</td>" +
            "<td colspan='2'></td>" +
            "</tr>";
        Res += "</table>";
        Res += "<div style='color:#2a66f5; font-weight:600; margin:18px 0 10px;'>Bill Info</div>";
        Res += "<table style='width:100%; border-collapse:separate; border-spacing:12px 10px;'>" +
            "<tr>" +
            "<td>Amount</td>" +
            "<td>" + txt(BillData.TOTBillAmt, "200px") + "</td>" +
            "<td>Available Limit</td>" +
            "<td>" + txt(BillData.AvailLimit, "200px") + "</td>" +
            "<td>Balance</td>" +
            "<td>" + txt(BillData.Balance, "200px") + "</td>" +
            "</tr>" +
            "</table>";
        Res += "</div>";

        return Res;
    }

    function GetVitalDetailsInfo() {
        var selMrno = sessionStorage.getItem('PatMRNO');
        var Type = "";
        var tranNo = sessionStorage.getItem('PatTRANNO');
        var Result = [];
        //startLoading("Loading");
        $.ajax({
            type: 'post',
            datatype: 'json',
            async: true,
            url: '../DoctorDesk/SetDataForVitals',
            data: { strTranNo: tranNo, Type: Type, strMRNo: selMrno },
            success: function (data) {
                if (data != "") {
                    Result = data;
                }
                stopLoading();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading();
            }
        });
        return Result;
    }

    function MapVitalsData(Response) {
        var prevWt = Response.PrevWeight;
        var weightloss = 0;
        if (Number(prevWt) > Number(currWt) && currWt != "") {
            var diffWt = Number(prevWt) - Number(currWt);
            weightloss = diffWt;
        }
        if (!Response || Object.keys(Response).length === 0) return null;
        var Data = {
            Weight: Response.Weight,
            PreviousWeight: Response.PrevWeight,
            WeightLoss: weightloss ,
            Height: Response.HEIGHT,
            Waist: Response.WAISTCIRCUM,
            Hip: Response.HIPCIRCUM,
            WHR: Response.WHR,
            IBW: Response.IBW,
            BWPercent: Response.BWPERC,
            BMI: Response.BMI,
            BSA: Response.BSA,
            Temperature: Response.TEMP,
            Pulse: Response.PULSE,
            RespRate: Response.RESP,
            SpO2: Response.SPO2,
            BPSystolic: Response.BP.toString().substring(0, Response.BP.toString().indexOf("/")),
            BPDiastolic: Response.BP.toString().substring(Response.BP.toString().indexOf("/") + 1),
            PulseType: Response.PULSECOND,
            KarnofskyScore: Response.KARNOFSKY,
            Vitals_EOCGScore: Response.ECOG,
            DailyWalking: Response.WALKINGYN === "Y" ? true : Response.WALKINGYN === "N" ? false : false,
            WalkingDuration: Response.WALKINGDURATION,
            DailyDiet: Response.DIETYN === "Y" ? true : Response.DIETYN === "N" ? false : false,
            DailyMedicine: Response.REGULARMEDIYN === "Y" ? true : Response.REGULARMEDIYN === "N" ? false : false,
            RandomBloodSugar: Response.RBS,
            PEFR: Response.PEFR,
            LowestPEFR: 0,
            HighestPEFR: 0,
            PEFRTechnique: Response.TECHNIQUE === "G" ? "Good" : Response.TECHNIQUE === "F" ? "Fair" : Response.TECHNIQUE === "P" ? "Poor" : Response.TECHNIQUE === "N" ? "N/A" : Response.TECHNIQUE === "" || Response.TECHNIQU === null || Response.TECHNIQU === undefiend ? "N/A" : "N/A",
            PEFRCompliance: Response.COMPLIANCE === "G" ? "Good" : Response.COMPLIANCE === "A" ? "Average" : Response.COMPLIANCE === "P" ? "Poor" : Response.TECHNIQUE === "N" ? "N/A" : Response.COMPLIANCE === "" ? "N/A" : "N/A",
            PainScore: parseInt(Response.PAINSCORE, 10) || 0,
            NutriDescreseFoodInTake: Response.NutriDescreseFoodInTake,
            NutriWeightLoss: Response.NutriWeightLoss,
            NutriMobility: Response.NutriMobility,
            NutriAcuteDisease: Response.NutriAcuteDisease,
            NutriNeuropsy: Response.NutriNeuropsy,
            NutriBodyHabit: Response.NutriBodyHabit,
            NutriScoreNA: Response.NutriScoreNA,
            NutriScore: Response.NutriScore
        };
        return Data;
    }

    function HistPopEditVitalDetailsTemp(Data) {
        var V = Data || {};
        var Res = "";
        Res += "<div class='HeaderSection_VitalDetails_MainDiv'>";

        // Header with buttons
        Res += "<div class='HeaderSection_VitalDetails_Section1'>";
        Res += "<div>";
        Res += "<div class='HeaderSection_VitalDetails_Section1_Div1_Heading1'>Vitals</div>";
        Res += "<div class='HeaderSection_VitalDetails_Section1_Div1_Heading2'>General Vitals</div>";
        Res += "</div>";
        Res += "<div class='HeaderSection_VitalDetails_Section1_Div2'>";
        Res += "<button id='btnRollback' class='HeaderSection_VitalDetails_Section1_Div2_Btn1'>Rollback</button>";
        Res += "<button id='btnSave' class='HeaderSection_VitalDetails_Section1_Div2_Btn2' onclick='SaveVitals('SS');'>Save</button>";
        Res += "</div></div>";

        function addInput(label, value, unit, id, events, extraClass,isReadonly) {
            // Ensure value is safe
            value = value === "" || value === null || value === undefined ? "" : value;

            // Prepare event attributes
            var eventAttrs = "";
            if (events) {
                for (var key in events) {
                    if (events[key]) {
                        eventAttrs += ` ${key}="${events[key]}"`;
                    }
                }
            }

            // add extra class
            var classes = "HeaderSection_Vitals_InputFields";
            if (extraClass) {
                classes += " " + extraClass;
            }

            // Prepare readonly attribute
            var readonlyAttr = "";
            if (isReadonly) {
                readonlyAttr = " readonly";
                classes += " vitals-disabled"; // visual disabled class
            }

            // Return HTML with unit or without unit
            if (unit) {
                return "<div class='HeaderSection_Vitals_InputFieldMainDiv'>" +
                           "<label for='Vitals_" + id + "' class='HeaderSection_Vitals_Label'>" + label + "</label>" +
                           "<div class='HeaderSection_Vitals_InputFieldSubDiv'>" +
                               "<input type='text' id='Vitals_" + id + "' value='" + value + "' class='" + classes + "'" + eventAttrs +  readonlyAttr + " />" +
                               "<span class='HeaderSection_Vitals_Span'>" + unit + "</span>" +
                           "</div>" +
                       "</div>";
            } else {
                return "<div class='HeaderSection_Vitals_InputFieldMainDiv'>" +
                           "<label for='Vitals_" + id + "' class='HeaderSection_Vitals_Label'>" + label + "</label>" +
                           "<input type='text' id='Vitals_" + id + "' value='" + value + "' class='" + classes + "'" + eventAttrs + readonlyAttr + " />" +
                       "</div>";
            }
        }




        // Helper: Toggle
        function addToggle(label, value, id, hiddenId) {
            var yesBg = value ? "green" : "#f0f0f0";
            var yesColor = value ? "white" : "#000";
            var noBg = !value ? "green" : "#f0f0f0";
            var noColor = !value ? "white" : "#000";
            var hiddenVal = value ? "Y" : "N";

            return "<div style='flex:1 1 150px; display:flex; flex-direction:column;'>" +
                   "<label style='font-size:0.85em; margin-bottom:3px;'>" + label + "</label>" +

                   "<div id='" + "Vitals_" + id + "' style='display:flex; border:1px solid #d1d1d1; border-radius:6px; overflow:hidden;'>" +

                   "<div onclick=\"toggleYesNo(this,true,'" + "Vitals_" + id + "','" + hiddenId + "')\" " +
                   "style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + yesBg + "; color:" + yesColor + ";'>Yes</div>" +

                   "<div onclick=\"toggleYesNo(this,false,'" + "Vitals_" + id + "','" + hiddenId + "')\" " +
                   "style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + noBg + "; color:" + noColor + ";'>No</div>" +

                   "</div>" +

                   "<input type='hidden' id='" + "Vitals_" + hiddenId + "' value='" + hiddenVal + "' />" +
                   "</div>";
        }

        function addSegment(label, selected, options, id, hiddenId) {
            // Get first letter of selected as default value
            var hiddenVal = selected ? selected.charAt(0).toUpperCase() : "";

            var html = "<div style='flex:1 1 220px; display:flex; flex-direction:column;'>";
            html += "<label style='font-size:0.85em; margin-bottom:6px;'>" + label + "</label>";

            html += "<div id='" + "Vitals_" + id + "' style='display:flex; border:1px solid #d1d1d1; border-radius:8px; overflow:hidden;'>";

            options.forEach(function (opt, index) {
                html += "<div onclick=\"selectSegment(this,'" + "Vitals_" + hiddenId + "')\" data-value='" + opt + "' " +
                        "style='flex:1; padding:8px; text-align:center; cursor:pointer; " +
                        "background:" + (selected === opt ? "green" : "#fff") + "; color:" + (selected === opt ? "#fff" : "#555") + "; " +
                        (index < options.length - 1 ? "border-right:1px solid #d1d1d1;" : "") + "'>" + opt + "</div>";
            });

            html += "</div>";

            // Single hidden input per segment
            html += "<input type='hidden' id='" + "Vitals_" + hiddenId + "' value='" + hiddenVal + "' />";

            html += "</div>";
            return html;
        }

        function addPainScale(selected, hiddenId) {
            var labels = ["Pain Free", "Very Mild", "Hurts Little Bit", "Tolerable", "Hurts Little More", "Very Distressing", "Hurts Even More", "Very Intense", "Hurts Whole Lot", "Unbearable", "Hurts Worst"];
            var html = "<div style='display:grid; grid-template-columns:repeat(auto-fit,minmax(90px,1fr)); gap:18px;'>";

            for (var i = 0; i <= 10; i++) {
                html += "<div onclick=\"selectPain(this,'" + "Vitals_" + hiddenId + "')\" id='painScore" + i + "' data-score='" + i + "' " +
                        "style='text-align:center; cursor:pointer; padding:10px; border-radius:10px; " +
                        "border:2px solid " + (selected === i ? "green" : "#e0e0e0") + "; " +
                        "background:" + (selected === i ? "#e9f7ef" : "#fff") + ";'>" +
                        "<img src='../images/PainSmiley/" + i + "pain.png' style='width:48px; height:48px; object-fit:contain;' />" +
                        "<div style='font-size:0.8em; margin-top:6px;'>" + i + " " + labels[i] + "</div>" +
                        "</div>";
            }

            html += "</div>";

            // Single hidden input
            var hiddenVal = selected !== undefined ? selected : "";
            html += "<input type='hidden' id='" + "Vitals_" + hiddenId + "' value='" + hiddenVal + "' />";

            return html;
        }


        // Anthropometrics
             Res += "<div class='HeaderSection_VitalDetails_Section2_MainDiv'>";
        Res += "<div class='HeaderSection_VitalDetails_Section2_SubDiv'>Anthropometrics</div>";
        Res += addInput("Weight", V.Weight, "Kg", "txtWeight", { oninput: "validateWeightHeight(this,'300')" });
        Res += addInput("Previous Weight", V.PreviousWeight, "Kg", "txtPreviousWeight", { onkeypress: " return checkdata();" }, "", true);
        Res += addInput("Weight Loss/ Gain", V.WeightLoss, "Kg", "txtWeightLoss", { onkeypress: " return checkdata();" }, "", true);
        Res += addInput("Height", V.Height, "Cm", "txtHeight", { oninput: "validateWeightHeight(this,'300')" }, "decimal-validation");
        Res += addInput("Waist Circumference", V.Waist, "Cm", "txtWaist", "", "decimal-validation");
        Res += addInput("Hip Circumference", V.Hip, "Cm", "txtHip", "", 'decimal-validation');
        Res += addInput("WHR", V.WHR, "", "txtWHR", "", true);
        Res += addInput("IBW", V.IBW, "", "txtIBW", "", "decimal-validation");
        Res += addInput("BW%", V.BWPercent, "", "txtBWPercent", "", "decimal-validation");
        Res += addInput("BMI", V.BMI, "Kg/m²", "txtBMI", "", "", true);
        Res += addInput("BSA", V.BSA, "m²", "txtBSA", "", "", true);
        Res += "</div>";

        // Vital Signs
        Res += "<div class='HeaderSection_VitalDetails_Section3_MainDiv'>";
        Res += "<div class='HeaderSection_VitalDetails_Section3_SubDiv'>Vital Signs</div>";
        /* Res += addInput("Temperature", V.Temperature, "°F", "txtTemperature", '', 'decimal-validation');*/
        Res += addInput(
            "Temperature",
            (V.Temperature != null && V.Temperature != "" ? parseFloat(V.Temperature).toFixed(1) : ""),
            "°F",
            "txtTemperature",
            '',
            'decimal-validation'
        );
        Res += addInput("Pulse", V.Pulse, "Bpm", "txtPulse", '', 'decimal-validation');

        // Pulse Type
        if (V.PulseType === "" || V.PulseType === null || V.PulseType === undefined) {
            V.PulseType = "R";
        }
        if (HidePulseType !== "Y") {
            Res += "<div style='flex:1 1 150px; display:flex; flex-direction:column;' id='divPulseCond'>";
            Res += "<label style='font-size:0.85em; margin-bottom:3px;'>Pulse Type</label>";
            Res += "<div id='togglePulseType' style='display:flex; border:1px solid #d1d1d1; border-radius:6px; overflow:hidden;'>" +
                "<div onclick=\"selectPulseType(this,'Regular')\" style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + (V.PulseType === 'R' ? 'green' : '#f0f0f0') + "; color:" + (V.PulseType === 'R' ? 'white' : '#000') + ";'>Regular</div>" +
                "<div onclick=\"selectPulseType(this,'Irregular')\" style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + (V.PulseType === 'I' ? 'green' : '#f0f0f0') + "; color:" + (V.PulseType === 'I' ? 'white' : '#000') + ";'>Irregular</div>" +
                "<input type='hidden' id='Vitals_hdnPulseCond' value='R' />" +
                "</div></div>";
        }
        Res += addInput("Respiratory Rate", V.RespRate, "Breaths/Minute", "txtRespRate", '', 'decimal-validation');
        // Blood Pressure
        if (V.BPSystolic === "" || V.BPSystolic === null || V.BPSystolic === undefined)
        {
            V.BPSystolic = "";
        }
        if (V.BPDiastolic === "" || V.BPDiastolic === null || V.BPDiastolic === undefined) {
            V.BPDiastolic = "";
        }
        Res += "<div style='flex:1 1 150px; display:flex; flex-direction:column;'>" +
            "<label style='font-size:0.85em; margin-bottom:3px;'>Blood Pressure</label>" +
     "<div style='display:flex; gap:5px;'>" +
     "<input type='text' id='Vitals_txtBPSystolic' value='" + V.BPSystolic + "' style='flex:1; min-width:60px; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='triggerInputBP decimal-validation'/>" +
     "<span style='align-self:center;'>/</span>" +
     "<input type='text' id='Vitals_txtBPDiastolic' value='" + V.BPDiastolic + "' style='flex:1; min-width:60px; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='triggerInputBP decimal-validation' />" +
     "</div></div>";

 Res += addInput("SpO2", V.SpO2, "%", "txtSpO2", '', 'decimal-validation');
 Res += addInput("Random Blood Sugar", V.RandomBloodSugar, "Mg/Dl", "txtRBS", '', 'decimal-validation');
 Res += "</div>";



        function addEOCGScore(selected) {
            var html = "<div style='display:flex; gap:18px;'>";

            for (var i = 1; i <= 5; i++) {
                var checked = (selected == i) ? "checked" : "";

                html += "<label style='display:flex; align-items:center; gap:6px; cursor:pointer; font-size:0.85em;'>";

                html += "<input type='radio' name='Vitals_EOCGScore' value='" + i + "' " + checked + " " +
                        "style='accent-color:green; cursor:pointer;' />";

                html += i;

                html += "</label>";
            }

            html += "</div>";
            return html;
        }

        // Performance Scores
        Res += "<div class='HeaderSection_VitalDetails_Section4_MainDiv'>";
        Res += "<div class='HeaderSection_VitalDetails_Section4_SubDiv'>Performance Scores</div>";

        // Karnofsky Score
        Res += "<div style='flex:1 1 200px; display:flex; flex-direction:column;'>";
        Res += "<label style='font-size:0.85em; margin-bottom:3px;'>Karnofsky Score</label>";
        Res += "<div style='display:flex;'>";
        Res += "<input type='text' id='Vitals_txtKarnofsky' value='" + (V.KarnofskyScore || "") + "' " +
            "style='flex:1; padding:6px 8px; border:1px solid #d1d1d1; border-top-left-radius:6px; border-bottom-left-radius:6px;' class='decimal-validation'/>";
        Res += "<span style='padding:6px 10px; background:#f0f0f0; border:1px solid #d1d1d1; border-left:none; " +
               "border-top-right-radius:6px; border-bottom-right-radius:6px; font-size:0.85em;'>In °F</span>";
        Res += "</div></div>";

        // EOCG Score
        Res += "<div style='flex:1 1 300px; display:flex; flex-direction:column;'>";
        Res += "<label style='font-size:0.85em; margin-bottom:6px;'>ECOG Score</label>";
        Res += addEOCGScore(V.EOCGScore);
        Res += "</div>";

        Res += "</div>";

        // Daily Activity
        Res += "<div style='border:1px solid #ccc; border-radius:10px; padding:15px; display:flex; flex-wrap:wrap; gap:15px;'>";
        Res += "<div style='width:100%; color:black; font-weight:600; margin-bottom:10px;'>Daily Activity</div>";
        Res += addToggle("Daily Walking", V.DailyWalking, "toggleDailyWalking", "hdnWalkingYN");
        Res += addInput("Walking Duration", V.WalkingDuration, "Days", "txtWalkingDuration", '', 'decimal-validation');
        Res += addToggle("Daily Diet", V.DailyDiet, "toggleDailyDiet", "hdnDietYN");
        Res += addToggle("Daily Medicine", V.DailyMedicine, "toggleDailyMedicine", "hdnRegMedYN");
        Res += "</div>";

        // Pulmonary Function (PEFR)

        if (V.PEFRTechnique === "" || V.PEFRTechnique === null || V.PEFRTechnique === undefined)
        {
            V.PEFRTechnique = "N/A";
        }
        if (V.PEFRCompliance === "" || V.PEFRCompliance === null || V.PEFRCompliance === undefined) {
            V.PEFRCompliance = "N/A";
        }
        Res += "<div style='border:1px solid #ccc; border-radius:10px; padding:15px;'>";
        Res += "<div style='color:green; font-weight:600; margin-bottom:12px;'>Pulmonary Function (PEFR) Assessment</div>";
        Res += "<div style='display:flex; flex-wrap:wrap; gap:15px;'>";
        Res += addInput("PEFR", V.PEFR, "Lit/Min", "txtPEFR", '', 'decimal-validation');
        Res += addInput("Lowest PEFR", V.LowestPEFR, "Lit/Min", "txtLowestPEFR","","",true);
        Res += addInput("Highest PEFR", V.HighestPEFR, "Lit/Min", "txtHighestPEFR","","",true);
        Res += "</div>";
        Res += "<div style='display:flex; gap:20px; margin-top:15px;'>";
        Res += addSegment("Technique", V.PEFRTechnique, ["Good", "Fair", "Poor", "N/A"], "segmentPEFRTechnique", "hdnTechniqueVal");
        Res += addSegment("Compliance", V.PEFRCompliance, ["Good", "Average", "Poor", "N/A"], "segmentPEFRCompliance", "hdnComplianceVal");
        Res += "</div></div>";

        // Pain Score
        Res += "<div style='border:1px solid #ccc; border-radius:10px; padding:15px;'>";
        Res += "<div style='color:green; font-weight:600; margin-bottom:15px;'>Pain Score (Wong-Baker)</div>";
        //Res += addPainScale(V.PainScore);
        Res += addPainScale(V.PainScore,"hdnPainScore");
        Res += "</div>";


        //Nutrition
        // Row prefixes for unique radio IDs
        const nsRowPrefixes = ["rbtnd","rbtnW","rbtnM","rbtnA","rbtnN","rbtnB"];

        // Generate a single radio option
        function addNSOption(text, score, rowIndex, optionIndex, selected) {
            var id = nsRowPrefixes[rowIndex] + "_" + optionIndex;
            var name = "nsGroup_" + rowIndex; // radios in same row are grouped
            var checked = selected ? "checked" : "";
            return '<div style="display:flex; align-items:center; gap:6px; cursor:pointer;">' +
                       '<input type="radio" name="' + name + '" id="' + id + '" value="' + score + '" ' + checked + ' onclick="calculateNSTotal()" />' +
                       '<label for="' + id + '" style="font-size:0.85em; cursor:pointer;">' + text + '</label>' +
                   '</div>';
        }

        // Generate a row with multiple options
        function addNSRow(label, options, rowIndex) {
            var html = "<tr>";
            html += "<td style='padding:10px; border:1px solid #ddd; font-size:0.85em; text-align:left;'>" + label + "</td>";
    
            for (var idx = 0; idx < options.length; idx++) {
                var opt = options[idx];
                html += "<td style='padding:10px; border:1px solid #ddd; vertical-align:top;'>" +
                            (opt ? addNSOption(opt.text, opt.score, rowIndex, idx, opt.selected) : "") +
                        "</td>";
            }

            html += "</tr>";
            return html;
        }


        // Build the Nutrition table
        Res += "<div style='border:1px solid #ccc; border-radius:10px; padding:15px; max-width:100%; box-sizing:border-box;'>";

        Res += "<div style='display:flex; flex-wrap:wrap; justify-content:space-between; align-items:center; margin-bottom:12px;'>";
        Res += "<div style='color:green; font-weight:600;'>Nutritional Screening</div>";
        Res += "<div style='display:flex; flex-wrap:wrap; align-items:center; gap:10px; margin-top:6px;'>";
        Res += "<label>Total</label>";
        Res += "<input id='nsTotal' type='text' readonly style='width:60px; padding:6px; border:1px solid #ccc; border-radius:6px;' />";
        Res += "<label style='display:flex; align-items:center; gap:4px;'><input type='checkbox' id='chkNutrSrcNA'onclick='IsNutriScreen()' /> NA</label>";
        Res += "</div></div>";

        // Responsive table
        Res += "<div style='overflow-x:auto;'>";
        Res += "<table id='tblNutrSrc' style='width:100%; border-collapse:collapse; text-align:center; min-width:600px;'>";
        Res += "<thead><tr style='background:#f5f5f5; font-size:0.85em;'>";
        Res += "<th style='border:1px solid #ddd; padding:10px;'>Criteria</th>";
        Res += "<th style='border:1px solid #ddd;'>0</th>";
        Res += "<th style='border:1px solid #ddd;'>1</th>";
        Res += "<th style='border:1px solid #ddd;'>2</th>";
        Res += "<th style='border:1px solid #ddd;'>3</th>";
        Res += "</tr></thead><tbody>";

        // Add rows
        Res += addNSRow("Decreased Food Intake Over Last 3 Months", [
            { text: "Severe loss", score: 0, selected: false },
            { text: "Moderate loss", score: 1, selected: false },
            null,
            { text: "No", score: 3, selected: false }
        ], 0);

        Res += addNSRow("Weight Loss In Last 3 Months", [
            { text: "> 3kg", score: 0, selected: false },
            null,
            null,
            { text: "No loss", score: 3, selected: false }
        ], 1);

        Res += addNSRow("Mobility", [
            { text: "Bed/Chair Bound", score: 0, selected: false },
            { text: "Able to but doesn’t", score: 1, selected: false },
            { text: "Fully Mobile", score: 2, selected: false },
            null
        ], 2);

        Res += addNSRow("Acute Disease In Last 3 Months", [
            { text: "Yes", score: 0, selected: false },
            null,
            { text: "No", score: 2, selected: false },
            null
        ], 3);

        Res += addNSRow("Neuropsychological Problem", [
            { text: "Severe Dementia", score: 0, selected: false },
            { text: "Mild Dementia", score: 1, selected: false },
            { text: "None", score: 2, selected: false },
            null
        ], 4);

        Res += addNSRow("Body Habits", [
            { text: "Cachexic / emaciated", score: 0, selected: false },
            { text: "Thin", score: 1, selected: false },
            { text: "Average", score: 2, selected: false },
            { text: "Obese", score: 3, selected: false }
        ], 5);

        Res += "</tbody></table></div>"; // table container

        // Notes
        Res += "<div style='margin-top:12px; font-size:0.85em;'>";
        Res += "<span style='color:black;font-weight:700;'>Note :</span> &nbsp; ";
        Res += "<span style='color:green;'>12–15 : Normal</span> &nbsp; ";
        Res += "<span style='color:#c89b00;'>8–11 : At Risk Of Malnutrition</span> &nbsp; ";
        Res += "<span style='color:red;'>Below 8 : Malnourished</span></div>";

        Res += "<div style='margin-top:6px; font-size:0.85em; font-weight:600;'>";
        Res += "Score &lt; 12, Notify To Consultant / Refer To Dietician</div>";

        Res += "</div>"; // main container


        //End Nutrition



        Res += "</div>"; // End outer container
        return Res;
    }

    function toggleYesNo(el, isYes, containerId, hiddenFieldId) {
        var container = document.getElementById(containerId);
        if (!container) return;

        var yes = container.children[0];
        var no = container.children[1];

        if (isYes) {
            yes.style.background = "green";
            yes.style.color = "white";
            no.style.background = "#f0f0f0";
            no.style.color = "#000";
        } else {
            no.style.background = "green";
            no.style.color = "white";
            yes.style.background = "#f0f0f0";
            yes.style.color = "#000";
        }

        // update hidden field
        if (hiddenFieldId) {
            var hdn = document.getElementById(hiddenFieldId);
            if (hdn) {
                hdn.value = isYes ? "Y" : "N";
            }
        }
    }

    function selectSegment(el, hiddenId) {
        var parent = el.parentNode;
        var children = parent.children;

        // Reset all buttons
        for (var i = 0; i < children.length; i++) {
            children[i].style.background = "#fff";
            children[i].style.color = "#555";
        }

        // Highlight clicked
        el.style.background = "green";
        el.style.color = "#fff";

        // Store first letter of selected option in hidden field
        if (hiddenId) {
            var hdn = document.getElementById(hiddenId);
            if (hdn) {
                hdn.value = el.getAttribute("data-value").charAt(0).toUpperCase();
            }
        }
    }

    function selectPain(el, hiddenId) {
        var parent = el.parentNode;
        var children = parent.children;

        // Reset all children borders/backgrounds
        for (var i = 0; i < children.length; i++) {
            if (children[i].tagName === "DIV") { // skip hidden input if present
                children[i].style.border = "2px solid #e0e0e0";
                children[i].style.background = "#fff";
            }
        }

        // Highlight clicked
        el.style.border = "2px solid green";
        el.style.background = "#e9f7ef";

        // Update hidden field
        if (hiddenId) {
            var hdn = document.getElementById(hiddenId);
            if (hdn) {
                hdn.value = el.getAttribute("data-score");
            }
        }
    }

    function selectNS(el) {
        // Find parent TD (ES5 safe)
        var td = el;
        while (td && td.tagName !== "TD") {
            td = td.parentNode;
        }

        if (!td) return;

        // Reset all spans inside TD
        var children = td.children;
        for (var i = 0; i < children.length; i++) {
            var span = children[i].getElementsByTagName("span")[0];
            if (span) {
                span.style.background = "#fff";
            }
        }

        // Set selected span
        var selectedSpan = el.getElementsByTagName("span")[0];
        if (selectedSpan) {
            selectedSpan.style.background = "#2dbb2d";
        }

        calculateNSTotal();
    }

    function calculateNSTotal() {
        var total = 0;

        // Select all checked radios that have a data-score
        var elements = document.querySelectorAll("input[type=radio]:checked");

        elements.forEach(function (el) {
            var val = parseInt(el.value, 10); // use radio value as score
            if (!isNaN(val)) {
                total += val;
            }
        });

        // Set total to the input box
        var box = document.getElementById("nsTotal");
        if (box) {
            box.value = total;
        }

        SVCSClr(total);
    }
    function SVCSClr(total) {
        var $txt = $("#nsTotal");
        $txt.val(total);

        if (total < 8) {
            $txt.css({ backgroundColor: "#fff6f9", border: "1px solid red", fontWeight: "900", color: "red", textAlign: "center" });
        }
        else if (total >= 8 && total <= 11) {
            $txt.css({ backgroundColor: "#fff6f9", border: "1px solid #af7c04", fontWeight: "900", color: "#af7c04", textAlign: "center" });
        }
        else if (total >= 12 && total <= 15) {
            $txt.css({ backgroundColor: "#fff6f9", border: "1px solid #006300", fontWeight: "900", color: "#006300", textAlign: "center" });
        }
    }

    function selectEOCG(el) {
        var container = el.parentNode;
        var items = container.children;

        for (var i = 0; i < items.length; i++) {
            items[i].children[0].style.background = "#fff";
        }

        el.children[0].style.background = "green";
        container.setAttribute("data-selected", el.getAttribute("data-value"));
    }
    function selectPulseType(el, value) {
        var container = el.parentNode;
        var buttons = container.children;

        // Reset both buttons
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].style.background = "#f0f0f0";
            buttons[i].style.color = "#000";
        }

        // Activate selected
        el.style.background = "green";
        el.style.color = "white";

        // Store selected value (for save)
        container.setAttribute("data-value", value);
        $("#Vitals_hdnPulseCond").val(value.substr(0, 1));
    }


    function CalNutrSrc() {
        var total = 0;
        $('#tblNutrSrc input[type=radio]:checked').each(function () {
            var val = parseInt($(this).val());
            if (!isNaN(val)) {
                total += val;
            }
        });
        // $('#txtNutrSrcTotal').val(total);
        SVCSClr(total)
    }


    //End

</script>

<%-- Patient More Details --%>
<script type="text/javascript">
    function checkVitalsDataMaxVal(id, val)
    {
        if (id === "VitalsDetails_txtTemp" && VitalsTempLmt != "" && document.getElementById("VitalsDetails_txtTemp") != null) {
            if (Number(val) > Number(VitalsTempLmt)) {
                document.getElementById("VitalsDetails_txtTemp").classList.add("val", "val-alert");
                document.getElementById("VitalsDetails_txtTemp_Clone").classList.add("val", "val-alert");
            }
        }
        else if (id === "VitalsDetails_txtBP1" && VitalsBPLmt1 != "" && document.getElementById("VitalsDetails_txtBP1") != null) {
            if (Number(val) > Number(VitalsBPLmt1) || Number(val) > Number(VitalsBPLmt2)) {
                document.getElementById("VitalsDetails_txtBP1").classList.add("val", "val-alert");
                document.getElementById("VitalsDetails_txtBP2").classList.add("val", "val-alert");

                document.getElementById("VitalsDetails_txtBP1_Clone").classList.add("val", "val-alert");
                document.getElementById("VitalsDetails_txtBP2_Clone").classList.add("val", "val-alert");
            }
        }
        else if (id === "VitalsDetails_txtBP2" && VitalsBPLmt2 != ""&& document.getElementById("VitalsDetails_txtBP2") != null) {
            if (Number(val) > Number(VitalsBPLmt2) || Number(val) > Number(VitalsBPLmt1) ) {
                document.getElementById("VitalsDetails_txtBP2").classList.add("val", "val-alert");
                document.getElementById("VitalsDetails_txtBP1").classList.add("val", "val-alert");

                document.getElementById("VitalsDetails_txtBP1_Clone").classList.add("val", "val-alert");
                document.getElementById("VitalsDetails_txtBP2_Clone").classList.add("val", "val-alert");
            }
        }
        else if (id === "VitalsDetails_txtRR" && VitalsRespRateLmt != ""&& document.getElementById("VitalsDetails_txtRR") != null) {
            if (Number(val) > Number(VitalsRespRateLmt)) {
                document.getElementById("VitalsDetails_txtRR").classList.add("val", "val-alert");
            }
        }
        else if (id === "VitalsDetails_txtSPO2" && VitalsSPO2Lmt != ""&& document.getElementById("VitalsDetails_txtSPO2") != null) {
            if (Number(val) > Number(VitalsSPO2Lmt)) {
                document.getElementById("VitalsDetails_txtSPO2").classList.add("val", "val-alert");
            }
        }
        //Priyanka 16/03/2026
        else if (id === "VitalsDetails_txtPulse" && VitalsSPO2Lmt != "" && document.getElementById("VitalsDetails_txtPulse") != null)
        {
            if (Number(val) > Number(VitalsPulseLmt)) {
                document.getElementById("VitalsDetails_txtPulse").classList.add("val", "val-alert");
            }
        }
        else if (id === "VitalsDetails_txtRBS" && VitalsSPO2Lmt != "" && document.getElementById("VitalsDetails_txtRBS") != null)
        {
            if (Number(val) > Number(VitalsRBSLmt)) {
                document.getElementById("VitalsDetails_txtRBS").classList.add("val", "val-alert");
            }
        }
        else if (id === "VitalsDetails_txtBMI" && VitalsBMILmt != ""&& document.getElementById("VitalsDetails_txtBMI") != null) {
            if (Number(val) > Number(VitalsBMILmt)) {
                document.getElementById("VitalsDetails_txtBMI").classList.add("val", "val-alert");
                document.getElementById("VitalsDetails_txtBMI_Clone").classList.add("val", "val-alert");
            }
        }
        else if (id === "VitalsDetails_txtBSA" && VitalsBSALmt != ""&& document.getElementById("VitalsDetails_txtBSA") != null) {
            if (Number(val) > Number(VitalsBSALmt)) {
                document.getElementById("VitalsDetails_txtBSA").classList.add("val", "val-alert");
            }
        }
       
    }

    function checkVitalsDataMaxValEMRVitals(id, val) {
        if (id === "EMR_txtTemp" && VitalsTempLmt != "" && document.getElementById("EMR_txtTemp") != null) {
            if (Number(val) > Number(VitalsTempLmt)) {
                document.getElementById("EMR_txtTemp").classList.add("val", "val-alert");
            }
        }
        else if (id === "EMR_txtBP1" && VitalsBPLmt1 != "" && document.getElementById("EMR_txtBP1") != null) {
            if (Number(val) > Number(VitalsBPLmt1) || Number(val) > Number(VitalsBPLmt2) ) {
                document.getElementById("EMR_txtBP1").classList.add("val", "val-alert");
                document.getElementById("EMR_txtBP2").classList.add("val", "val-alert");
            }
        }
        else if (id === "EMR_txtBP2" && VitalsBPLmt2 != "" && document.getElementById("EMR_txtBP2") != null) {
            if (Number(val) > Number(VitalsBPLmt2) || Number(val) > Number(VitalsBPLmt1)) {
                document.getElementById("EMR_txtBP2").classList.add("val", "val-alert");
                document.getElementById("EMR_txtBP1").classList.add("val", "val-alert");
            }
        }
        else if (id === "EMR_txtRR" && VitalsRespRateLmt != "" && document.getElementById("EMR_txtRR") != null) {
            if (Number(val) > Number(VitalsRespRateLmt)) {
                document.getElementById("EMR_txtRR").classList.add("val", "val-alert");
            }
        }
        else if (id === "EMR_txtSPO2" && VitalsSPO2Lmt != "" && document.getElementById("EMR_txtSPO2") != null) {
            if (Number(val) > Number(VitalsSPO2Lmt)) {
                document.getElementById("EMR_txtSPO2").classList.add("val", "val-alert");
            }
        }
        else if (id === "EMR_txtBMI" && VitalsBMILmt != "" && document.getElementById("EMR_txtBMI") != null) {
            if (Number(val) > Number(VitalsBMILmt)) {
                document.getElementById("EMR_txtBMI").classList.add("val", "val-alert");
            }
        }
        else if (id === "EMR_txtBSA" && VitalsBSALmt != "" && document.getElementById("EMR_txtBSA") != null) {
            if (Number(val) > Number(VitalsBSALmt)) {
                document.getElementById("EMR_txtBSA").classList.add("val", "val-alert");
            }
        }
    }

    function MapPatientData(Response) {
        if (!Response || !Response.rows || Response.rows.length === 0) return null;
        var cell = Response.rows[0].cell;
        var Data = {
            MR: cell[0] || "",
            Name: cell[1] || "",
            DOB: cell[2] || "",
            Age: cell[3] || "",
            Gender: cell[4] || "",
            Address: cell[5] || "",
            Address2: cell[6] || "",
            Category: cell[8] || "",
            Company: cell[11] || "",
            PayType: cell[12] || "",
            Contact: cell[10] || "",
            Tariff: cell[9] || "",
            //Priority: cell[19],
            Priority: cell[25],
            Amount: cell[14] || "0.00",
            AvailableLimit: cell[15] || "0.00",
            Balance: cell[21] || "0.00",
            Email: cell[32] || ""
        };

        return Data;
    }

    function GetBindPatandBillInfo() { 
        var mrno = sessionStorage.getItem("PatMRNO");
        var Result = [];
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GETOPSEARCHDATA',
            datatype: "json",
            async: false,
            data: { SMRNO: mrno, },
            success: function (Response) {
                Result = Response;
            }
        });
        return Result;
    }

    function GetBillInfo() { 
            var strConsNo = sessionStorage.getItem("PatTRANNO");
            var Result = [];
            startLoading("Loading");
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/GetBillInfo',
                datatype: "json",
                async: false,
                data: { strConsNo: strConsNo, },
                success: function (Response) {
                    Result = Response;
                    stopLoading();
                }
            });
            return Result;    
    }

    function MapBillData(Resoponse2) {
        if (!Resoponse2 || Resoponse2.length === 0) return null;

        var cell = Resoponse2[0];

        var BillData = {
            BillNo: Resoponse2[0]["BillNo"] || "",
            AvailLimit: Resoponse2[0]["AvailLimit"] || "",
            Balance: Resoponse2[0]["Balance"] || "",
            CompName: Resoponse2[0]["CompName"] || "",
            PatCatgName: Resoponse2[0]["PatCatgName"] || "",
            TOTBillAmt: Resoponse2[0]["TOTBillAmt"] || "",
            TariffName: Resoponse2[0]["TariffName"] || "",
        };

        return BillData;
    }

    //function HistPopPatientInfoTemp(Data, BillData) {

    //    var PatInfoData = Data[0];

    //    function txt(value, width) {
    //        return "<input type='text' readonly value='" + (value || "") +
    //               "' style='width:" + width + "; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px; background:#fff;' />";
    //    }

    //    var Res = "";

    //    Res += "<div style='padding:15px; font-family:Segoe UI, Arial;overflow: auto;'>";

    //    /* ================= Patient Info ================= */
    //    Res += "<div style='color:#2a66f5; font-weight:600; margin-bottom:10px;'>Patient Info</div>";

    //    Res += "<table style='width:100%; border-collapse:separate; border-spacing:12px 10px;'>";

    //    // Row 1
    //    Res += "<tr>" +
    //        "<td>Name</td>" +
    //        "<td>" + txt(Data.Title || "Mr", "50px") + "</td>" +
    //        "<td>" + txt(Data.Name, "180px") + "</td>" +
    //        "<td>Company</td>" +
    //        "<td>" + txt(Data.Company, "180px") + "</td>" +
    //        "<td>Age</td>" +
    //        "<td>" + txt(Data.Age, "120px") + "</td>" +
    //        "<td>Gender</td>" +
    //        "<td>" + txt(Data.Gender, "120px") + "</td>" +
    //        "</tr>";

    //    // Row 2
    //    Res += "<tr>" +
    //        "<td>Category</td>" +
    //        "<td colspan='2'>" + txt(Data.Category, "250px") + "</td>" +
    //        "<td>Pay Type</td>" +
    //        "<td>" + txt(Data.PayType, "180px") + "</td>" +
    //        "<td>MR</td>" +
    //        "<td>" + txt(Data.MR, "160px") + "</td>" +
    //        "<td>Contact</td>" +
    //        "<td>" + txt(Data.Contact, "140px") + "</td>" +
    //        "</tr>";

    //    // Row 3
    //    Res += "<tr>" +
    //        "<td>Tariff</td>" +
    //        "<td colspan='2'>" + txt(Data.Tariff, "250px") + "</td>" +
    //        "<td>DOB</td>" +
    //        "<td>" + txt(Data.DOB, "180px") + "</td>" +
    //        "<td>Priority</td>" +
    //        "<td>" + txt(Data.Priority, "160px") + "</td>" +
    //        "<td colspan='2'></td>" +
    //        "</tr>";

    //    Res += "</table>";

    //    /* ================= Bill Information ================= */
    //    Res += "<div style='color:#2a66f5; font-weight:600; margin:18px 0 10px;'>Bill Info</div>";


    //    if (!BillData) {
    //        BillData = {
    //            TOTBillAmt: "",
    //            AvailLimit: "",
    //            Balance: ""
    //        };
    //    }


    //    Res += "<table style='width:100%; border-collapse:separate; border-spacing:12px 10px;'>" +
    //        "<tr>" +
    //        "<td>Amount</td>" +
    //        "<td>" + txt(BillData.TOTBillAmt, "200px") + "</td>" +
    //        "<td>Available Limit</td>" +
    //        "<td>" + txt(BillData.AvailLimit, "200px") + "</td>" +
    //        "<td>Balance</td>" +
    //        "<td>" + txt(BillData.Balance, "200px") + "</td>" +
    //        "</tr>" +
    //        "</table>";

    //    Res += "</div>";

    //    return Res;
    //}

    //End
    function HistPopPatientInfoTemp(Data, BillData) {
        var PatInfoData = Data || {};

        function txt(value, width) {
            return "<input type='text' readonly value='" + (value || "") +
                "' style='width:" + width + "; padding:8px 10px; border:1px solid #dce1e7; border-radius:4px; background:#f9f9f9; color:#333; font-size:13px; box-sizing:border-box;' />";
        }

        var headerStyle = "background:#f0f5ff; color:#2a66f5; font-weight:700; padding:10px 15px; border-radius:4px; border-left:4px solid #2a66f5; font-size:14px; margin-bottom:15px;";
        var labelStyle = "font-size:12px; font-weight:600; color:#666;";

        var Res = "";
        Res += "<div style='padding:20px; font-family:\"Segoe UI\", Arial, sans-serif; background:#fff;'>";

        /* ================= Patient Info Section ================= */
        Res += "<div style='" + headerStyle + "'>PATIENT INFORMATION</div>";

        // Adjusted widths: Age/MR/Priority cells are now wider, Gender/Contact are narrower
        Res += "<table style='width:100%; border-collapse:separate; border-spacing:0 10px; table-layout:fixed; margin-bottom:20px;'>";

        // Row 1
        Res += "<tr>" +
            "<td style='" + labelStyle + " width:8%;'>Name</td>" +
            "<td style='width:6%;'>" + txt(PatInfoData.Title || "Mr", "100%") + "</td>" +
            "<td style='width:18%;'>" + txt(PatInfoData.Name, "100%") + "</td>" +
            "<td style='" + labelStyle + " width:10%; padding-left:15px;'>Company</td>" +
            "<td style='width:22%;'>" + txt(PatInfoData.Company, "100%") + "</td>" +
            "<td style='" + labelStyle + " width:8%; padding-left:15px;'>Age</td>" +
            "<td style='width:12%;'>" + txt(PatInfoData.Age, "100%") + "</td>" + // Increased width
            "<td style='" + labelStyle + " width:8%; padding-left:15px;'>Gender</td>" +
            "<td style='width:8%;'>" + txt(PatInfoData.Gender, "100%") + "</td>" + // Reduced width
            "</tr>";

        // Row 2
        Res += "<tr>" +
            "<td style='" + labelStyle + "'>Category</td>" +
            "<td colspan='2'>" + txt(PatInfoData.Category, "100%") + "</td>" +
            "<td style='" + labelStyle + " padding-left:15px;'>Pay Type</td>" +
            "<td>" + txt(PatInfoData.PayType, "100%") + "</td>" +
            "<td style='" + labelStyle + " padding-left:15px;'>MR</td>" +
            "<td>" + txt(PatInfoData.MR, "100%") + "</td>" + // Increased width
            "<td style='" + labelStyle + " padding-left:15px;'>Contact</td>" +
            "<td>" + txt(PatInfoData.Contact, "100%") + "</td>" + // Reduced width
            "</tr>";

        // Row 3
        Res += "<tr>" +
            "<td style='" + labelStyle + "'>Tariff</td>" +
            "<td colspan='2'>" + txt(PatInfoData.Tariff, "100%") + "</td>" +
            "<td style='" + labelStyle + " padding-left:15px;'>DOB</td>" +
            "<td>" + txt(PatInfoData.DOB, "100%") + "</td>" +
            "<td style='" + labelStyle + " padding-left:15px;'>Priority</td>" +
            "<td>" + txt(PatInfoData.Priority, "100%") + "</td>" + // Increased width
            "<td colspan='2'></td>" +
            "</tr>";

        Res += "</table>";

        /* ================= Bill Info Section ================= */
        Res += "<div style='" + headerStyle + " margin-top:10px;'>BILLING DETAILS</div>";

        if (!BillData) {
            BillData = { TOTBillAmt: "", AvailLimit: "", Balance: "" };
        }

        Res += "<table style='width:100%; border-collapse:separate; border-spacing:0 10px; table-layout:fixed;'>" +
            "<tr>" +
            "<td style='" + labelStyle + " width:10%;'>Amount</td>" +
            "<td style='width:23%;'>" + txt(BillData.TOTBillAmt, "100%") + "</td>" +
            "<td style='" + labelStyle + " width:15%; padding-left:40px;'>Available Limit</td>" +
            "<td style='width:22%;'>" + txt(BillData.AvailLimit, "100%") + "</td>" +
            "<td style='" + labelStyle + " width:10%; padding-left:40px;'>Balance</td>" +
            "<td style='width:20%;'>" + txt(BillData.Balance, "100%") + "</td>" +
            "</tr>" +
            "</table>";

        Res += "</div>";

        return Res;
    }
</script>

<%-- Edit Vitals --%>
<script type="text/javascript">

    function LoadOfRditVitals() {

    //DEVENDRA => Age less than 18 Head circumference will be hidden
    if (typeof ageOfPat != "undefined") {
        if (parseInt(ageOfPat) <= 18)
            $("#Vitals_txtHeadCirc").hide();
        else
            
        $("#Vitals_txtHeadCirc").show();
    }

        $("#Vitals_txtWeight").focus();

        $("#Vitals_txtWeight,#Vitals_txtHeight").on('keyup', function (e) {
            if (event.keyCode == 46 || event.keyCode == 8) {
                $('#Vitals_txtBMI').val(""); $('#Vitals_txtBSA').val("");
            }
        });

        $('#Vitals_txtWeight_Status').change(function () {
            let val = $(this).val();
            if (val == '04') {
                $('#Vitals_txtWeight').prop('disabled', true).val('');
            }
            else {
                $('#Vitals_txtWeight').prop('disabled', false);
            }
            SetWeightLoss();
            CalBMI();
        });

        // Addded by Dhananjay 20251106
        $('#Vitals_txtHeight_Status').change(function () {
            let val = $(this).val();
            if (val == '04') {
                $('#Vitals_txtHeight').prop('disabled', true).val('');
            }
            else {
                $('#Vitals_txtHeight').prop('disabled', false);
            }
            CalBMI();
        });

        //$('#Vitals_txtWeight,#Vitals_txtHeight,#Vitals_txtTemperature,#Vitals_txtPulse,#Vitals_txtSpO2,#Vitals_txtBMI,#Vitals_txtBSA,#Vitals_txtHeadCirc,#Vitals_txtPEFR,#Vitals_txtRBS,#Vitals_txtKarnofsky,#Vitals_txtIBW,#Vitals_txtBWPercent,#Vitals_txtWaist,#txtHip,#Vitals_txtHip').blockInput({ regex: '[0-9.]' });
        

        //Open and close BP Dropdowns
        document.addEventListener("click", function (e) {

            // Systolic
            const sysInput = document.getElementById("Vitals_txtBPSystolic");
            const sysList = document.getElementById("Vitals_txtBPSystolic_list");

            if (sysList && !sysInput.contains(e.target) && !sysList.contains(e.target)) {
                sysList.style.display = "none";
            }

            // Diastolic
            const diaInput = document.getElementById("Vitals_txtBPDiastolic");
            const diaList = document.getElementById("Vitals_txtBPDiastolic_list");

            if (diaList && !diaInput.contains(e.target) && !diaList.contains(e.target)) {
                diaList.style.display = "none";
            }
        });

        //Close Walking Duration Number and Days Dropdowns
        document.addEventListener("click", function (e) {

            // Walking Duration Number
            const WalkingDurNumInput = document.getElementById("Vitals_txtWalkingDuration");
            const WalkingDurNumList = document.getElementById("Vitals_txtWalkingDuration_list");

            if (WalkingDurNumList && !WalkingDurNumInput.contains(e.target) && !WalkingDurNumList.contains(e.target)) {
                WalkingDurNumList.style.display = "none";
            }

            // Walking Duration Days
            const WalkingDurDaysInput = document.getElementById("Vitals_txtWalkingDurationDays");
            const WalkingDurDaysList = document.getElementById("Vitals_txtWalkingDurationDays_list");

            if (WalkingDurDaysList && !WalkingDurDaysInput.contains(e.target) && !WalkingDurDaysList.contains(e.target)) {
                WalkingDurDaysList.style.display = "none";
            }
        });
    }

    function BindNutritionalData(Data)
    {
        if (Data === "" || Data === null || Object.keys(Data).length === 0) {
            $("#nsTotal").prop('disabled', true);
        }
        else
        {
            if (Data.NutriScoreNA === "N") {
                $("#rbtnd_" + Data.NutriDescreseFoodInTake).prop("checked", true);
                $("#rbtnW_" + Data.NutriWeightLoss).prop("checked", true);
                $("#rbtnM_" + Data.NutriMobility).prop("checked", true);
                $("#rbtnA_" + Data.NutriAcuteDisease).prop("checked", true);
                $("#rbtnN_" + Data.NutriNeuropsy).prop("checked", true);
                $("#rbtnB_" + Data.NutriBodyHabit).prop("checked", true);
                $("#chkNutrSrcNA").prop("checked", false);
                $("#chkNutrSrcNA").prop('disabled',true);
                $("#nsTotal").prop('disabled', true);
                calculateNSTotal();
            }
            else if (Data.NutriScoreNA === "Y") {
                $("#chkNutrSrcNA").prop("checked", true);
                IsNutriScreen();
            }
        }
    }

    function BindVitalsComboData(Data)
    {
        $("#Vitals_txtBPSystolic").val(Data.BPSystolic);
        $("#Vitals_txtBPDiastolic").val(Data.BPDiastolic);
        $("#Vitals_txtWeight_Status").val(Data.vitals_CmbWeight);
        $("#Vitals_txtHeight_Status").val(Data.vitals_CmbHeight);
        $("#Vitals_txtWalkingDuration").val(Data.WalkingDuration);
        $("#Vitals_txtWalkingDurationDays").val(Data.Vitals_WalkingDurationType);
        $("#Vitals_eleSelSystolic").val(Data.teleBPSystolic);
        $("#Vitals_eleSelDiastolic").val(Data.teleBPDiastolic);
    }

    function IsNutriScreen() {
        if ($('#chkNutrSrcNA').prop("checked") == true) {
            $("#tblNutrSrc input[type='radio']").attr('checked', false);
            $("#tblNutrSrc input[type='radio']").attr("disabled", "disabled");
            $("#nsTotal").val("");
            $("#nsTotal").prop('disabled', true);
        }
        else {
            $("#tblNutrSrc input[type='radio']").prop('disabled', false);
            $("#tblNutrSrc input[type='radio']").attr('checked', false);
            $("#nsTotal").val("0");
            $("#nsTotal").prop('disabled', true);
        }
    }
    //End

    function GetVitalDetailsInfo(Type) {
        var selMrno = sessionStorage.getItem('PatMRNO');
        var Type = Type;
        var tranNo = sessionStorage.getItem('PatTRANNO');
        var Result = [];
        //startLoading("Loading");
        $.ajax({
            type: 'post',
            datatype: 'json',
            async: false,
            url: '../DoctorDesk/SetDataForVitals',
            data: { strTranNo: tranNo, Type: Type, strMRNo: selMrno },
            success: function (data) {
                if (data != "") {
                    Result = data;
                }
                stopLoading();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading();
            }
        });
        return Result;
    }

    function MapVitalsData(Response) {
        var currWt = Response.Weight;
        var prevWt = Response.PrevWeight;
        var weightloss = 0;
        if (Number(prevWt) > Number(currWt) && currWt != "") {
            var diffWt = Number(prevWt) - Number(currWt);
            weightloss = diffWt;
        }
        if (!Response || Object.keys(Response).length === 0) 
        {
            var Data = {
                Weight:"" ,
                PreviousWeight: "",
                WeightLoss: 0,
                Height: "",
                Waist: "",
                Hip: "",
                WHR: "",
                IBW: "",
                BWPercent: "",
                BMI: "",
                BSA: "",
                Temperature: "",
                Pulse: "",
                RespRate: "",
                SpO2: "",
                BPSystolic: "",
                BPDiastolic: "",
                PulseType: "",
                KarnofskyScore:"",
                Vitals_EOCGScore: Response.ECOG,
                DailyWalking: false,
                WalkingDuration: "",
                DailyDiet: false,
                DailyMedicine: false,
                RandomBloodSugar: "",
                // Pulmonary Function
                PEFR: "",
                LowestPEFR: 0,
                HighestPEFR: 0,
                PEFRTechnique: "N/A",
                PEFRCompliance:"N/A" ,
                // Pain Score
                PainScore: 0,
                NutriDescreseFoodInTake:"",
                NutriWeightLoss: "",
                NutriMobility:"",
                NutriAcuteDisease:"",
                NutriNeuropsy:"",
                NutriBodyHabit:"",
                NutriScoreNA:"",
                NutriScore:"",
                //teleBPSystolic:"",
                //teleBPDiastolic:"",
                //telePulse:"",
                //teleTemperature: "0",
                teleBPSystolic:"",
                teleBPDiastolic:"",
                telePulse:"",
                teleTemperature: "",
                HeadCircum: "",
                vitals_CmbWeight: "",
                vitals_CmbHeight: "",
                Vitals_WalkingDurationType : "Days"
            };
        }
        else{
            var Data = {
                Weight:Response.Weight ,
                PreviousWeight: Response.PrevWeight,
                WeightLoss: weightloss,
                Height: Response.HEIGHT,
                Waist: Response.WAISTCIRCUM,
                Hip: Response.HIPCIRCUM,
                WHR: Response.WHR,
                IBW: Response.IBW,
                BWPercent: Response.BWPERC,
                BMI: Response.BMI,
                BSA: Response.BSA,
                Temperature: Response.TEMP,
                Pulse: Response.PULSE,
                RespRate: Response.RESP,
                SpO2: Response.SPO2,
                BPSystolic: Response.BP.toString().substring(0, Response.BP.toString().indexOf("/")),
                BPDiastolic: Response.BP.toString().substring(Response.BP.toString().indexOf("/") + 1),
                PulseType: Response.PULSECOND,
                KarnofskyScore: Response.KARNOFSKY,
                Vitals_EOCGScore: Response.ECOG,
                DailyWalking: Response.WALKINGYN === "Y" ? true : Response.WALKINGYN === "N" ? false : false,
                WalkingDuration: Response.WALKINGDURATION.trim(),
                DailyDiet: Response.DIETYN === "Y" ? true : Response.DIETYN === "N" ? false : false,
                DailyMedicine: Response.REGULARMEDIYN === "Y" ? true : Response.REGULARMEDIYN === "N" ? false : false,
                RandomBloodSugar: Response.RBS,
                // Pulmonary Function
                PEFR: Response.PEFR,
                LowestPEFR: 0,
                HighestPEFR: 0,
                PEFRTechnique: Response.TECHNIQUE === "G" ? "Good" : Response.TECHNIQUE === "F" ? "Fair" : Response.TECHNIQUE === "P" ? "Poor" : Response.TECHNIQUE === "N" ? "N/A" : Response.TECHNIQUE === "" || Response.TECHNIQU === null || Response.TECHNIQU === undefiend ? "N/A" : "N/A",
                PEFRCompliance: Response.COMPLIANCE === "G" ? "Good" :Response.COMPLIANCE === "A" ?"Average" : Response.COMPLIANCE === "P" ? "Poor" : Response.TECHNIQUE === "N" ? "N/A" : Response.COMPLIANCE === "" ? "N/A" : "N/A" ,
                // Pain Score
                PainScore: parseInt(Response.PAINSCORE, 10) || 0,
                NutriDescreseFoodInTake:Response.NutriDescreseFoodInTake,
                NutriWeightLoss: Response.NutriWeightLoss,
                NutriMobility:Response.NutriMobility,
                NutriAcuteDisease:Response.NutriAcuteDisease,
                NutriNeuropsy:Response.NutriNeuropsy,
                NutriBodyHabit:Response.NutriBodyHabit,
                NutriScoreNA:Response.NutriScoreNA,
                NutriScore:Response.NutriScore,
                //teleBPSystolic:"",
                //teleBPDiastolic:"",
                //telePulse:"",
                //teleTemperature: "0",
                teleBPSystolic:Response.ELEBP.toString().substring(0, Response.ELEBP.toString().indexOf("/")),
                teleBPDiastolic:Response.ELEBP.toString().substring(Response.ELEBP.toString().indexOf("/") + 1),
                telePulse:Response.ELEPULSE,
                teleTemperature: Response.ELETEMP,
                HeadCircum: Response.HEADCIRCMF,
                vitals_CmbWeight: Response.CMBWEIGHT,
                vitals_CmbHeight: Response.CMBHEIGHT,
                Vitals_WalkingDurationType : Response.WALKINGDURTYPE != "" || Response.WALKINGDURTYPE != null || Response.WALKINGDURTYPE != undefiend ? "Days" : 
                                             Response.WALKINGDURTYPE === "D" ? "Days" : Response.WALKINGDURTYPE === "W" ? "Weeks" :
                                             Response.WALKINGDURTYPE === "M" ? "Months" : Response.WALKINGDURTYPE === "Y" ? "Years" : "Days"
            };
        }
        //return null;

        //var cell = Response;

    

        return Data;
    }

    function HistPopEditVitalDetailsTemp(Data) {
        var V = Data || {};
        var Res = "";

        // Outer container
        Res += "<div class='HeaderSection_VitalDetails_MainDiv'>";

        // Header with buttons
        Res += "<div class='HeaderSection_VitalDetails_Section1'>";
        Res += "<div>";
        Res += "<div class='HeaderSection_VitalDetails_Section1_Div1_Heading1'>Vitals</div>";
        Res += "<div class='HeaderSection_VitalDetails_Section1_Div1_Heading2'>General Vitals</div>";
        Res += "</div>";
        Res += "<div class='HeaderSection_VitalDetails_Section1_Div2'>";
        Res += "<button id='btnRollback' class='HeaderSection_VitalDetails_Section1_Div2_Btn1'  onclick='RollBackDataForVitals();'>Rollback</button>";
        Res += "<button id='btnSave' class='HeaderSection_VitalDetails_Section1_Div2_Btn2' onclick='SaveVitals(\"SS\");'>Save</button>";
        Res += "</div></div>";

        // Helper: Input
        //function addInput(label, value, unit, id) {
        //    var value = value === "" || value === null || value === undefined ? "" : value;
        //    if (unit) {
        //        return "<div class='HeaderSection_Vitals_InputFieldMainDiv'>" +
        //                    "<label for='" + "Vitals_" + id + "' class='HeaderSection_Vitals_Label'>" + label + "</label>" +
        //                    "<div class='HeaderSection_Vitals_InputFieldSubDiv'>" +
        //                        "<input type='text' id='" + "Vitals_" + id + "' value='" + value + "' class='HeaderSection_Vitals_InputFields' />" +
        //                        "<span class='HeaderSection_Vitals_Span'>" + unit + "</span>" +
        //                    "</div>" +
        //               "</div>";
        //    } else {
        //        return "<div class='HeaderSection_Vitals_InputFieldMainDiv'>" +
        //                    "<label for='" + "Vitals_" + id + "' class='HeaderSection_Vitals_Label'>" + label + "</label>" +
        //                    "<input type='text' id='" + "Vitals_" + id + "' value='" + value + "' class='HeaderSection_Vitals_InputFields' />" +
        //               "</div>";
        //    }
        //}

  

        function addInput(label, value, unit, id, events, extraClass, isReadonly, unitOptions, statusOptions) {
            // Ensure value is safe
            if (value === "" || value === null || value === undefined) {
                value = "";
            }

            // Prepare event attributes
            var eventAttrs = "";
            if (events) {
                for (var key in events) {
                    if (events[key]) {
                        eventAttrs += " " + key + "='" + events[key] + "'";
                    }
                }
            }

            // Add extra class
            var classes = "HeaderSection_Vitals_InputFields";
            if (extraClass) {
                classes += " " + extraClass;
            }

            // Prepare readonly attribute
            var readonlyAttr = "";
            if (isReadonly) {
                readonlyAttr = " readonly";
                classes += " vitals-disabled";
            }

            // Prepare unit: either text span or dropdown
            var DropDownunitHtml = "";
            if (unitOptions && unitOptions.length) {
                var dropdownId = "Vitals_" + id + "_Unit";
                DropDownunitHtml = "<select id='" + dropdownId + "' class='HeaderSection_Vitals_UnitDropdown'>";
                for (var i = 0; i < unitOptions.length; i++) {
                    var opt = unitOptions[i];
                    var optionValue, optionText;

                    // Check if opt is an object with value and text
                    if (typeof opt === "object" && opt !== null) {
                        optionValue = opt.value;
                        optionText = opt.text;
                    } else {
                        optionValue = opt;
                        optionText = opt;
                    }

                    var selected = (unit === optionText || unit === optionValue) ? " selected" : "";
                    DropDownunitHtml += "<option value='" + optionValue + "'" + selected + ">" + optionText + "</option>";
                }
                DropDownunitHtml += "</select>";
            } else if (unit) {
                DropDownunitHtml = "<span class='HeaderSection_Vitals_Span'>" + unit + "</span>";
            }


            //Status 
            var statusDropdownHtml = "";
            if (statusOptions && statusOptions.length) {
                var statusId = "Vitals_" + id + "_Status";
                statusDropdownHtml = "<select id='" + statusId + "' class='HeaderSection_Vitals_StatusDropdown'>";

                for (var j = 0; j < statusOptions.length; j++) {
                    var opt = statusOptions[j];
                    var val = opt.value;
                    var txt = opt.text;

                    statusDropdownHtml += "<option value='" + val + "'>" + txt + "</option>";
                }
                statusDropdownHtml += "</select>";
            }

            // Return HTML
            return "<div class='HeaderSection_Vitals_InputFieldMainDiv'>" +
                       "<label for='Vitals_" + id + "' class='HeaderSection_Vitals_Label'>" + label + "</label>" +
                       "<div class='HeaderSection_Vitals_InputFieldSubDiv'>" +
                           "<input type='text' id='Vitals_" + id + "' value='" + value + "' class='" + classes + "'" + eventAttrs + readonlyAttr + " />" +
                           DropDownunitHtml +
                           statusDropdownHtml +
                       "</div>" +
                   "</div>";
        }

        // Helper: Toggle
        function addToggle(label, value, id, hiddenId) {
            var yesBg = value ? "green" : "#f0f0f0";
            var yesColor = value ? "white" : "#000";
            var noBg = !value ? "green" : "#f0f0f0";
            var noColor = !value ? "white" : "#000";
            var hiddenVal = value ? "Y" : "N";

            return "<div style='flex:1 1 150px; display:flex; flex-direction:column;'>" +
                   "<label style='font-size:0.85em; margin-bottom:3px;'>" + label + "</label>" +

                   "<div id='" + "Vitals_" + id + "' style='display:flex; border:1px solid #d1d1d1; border-radius:6px; overflow:hidden;'>" +

                   "<div onclick=\"toggleYesNo(this,true,'" + "Vitals_" + id + "','" + "Vitals_" + hiddenId + "')\" " +
                   "style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + yesBg + "; color:" + yesColor + ";'>Yes</div>" +

                   "<div onclick=\"toggleYesNo(this,false,'" + "Vitals_" + id + "','" + "Vitals_" + hiddenId + "')\" " +
                   "style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + noBg + "; color:" + noColor + ";'>No</div>" +

                   "</div>" +

                   "<input type='hidden' id='" + "Vitals_" + hiddenId + "' value='" + hiddenVal + "' />" +
                   "</div>";
        }


        // Helper: Segment (PEFR/EOCG)
        function addSegment(label, selected, options, id, hiddenId) {
            // Get first letter of selected as default value
            var hiddenVal = selected ? selected.charAt(0).toUpperCase() : "";

            var html = "<div style='flex:1 1 220px; display:flex; flex-direction:column;'>";
            html += "<label style='font-size:0.85em; margin-bottom:6px;'>" + label + "</label>";

            html += "<div id='" + "Vitals_" + id + "' style='display:flex; border:1px solid #d1d1d1; border-radius:8px; overflow:hidden;'>";

            options.forEach(function (opt, index) {
                html += "<div onclick=\"selectSegment(this,'" + "Vitals_" + hiddenId + "')\" data-value='" + opt + "' " +
                        "style='flex:1; padding:8px; text-align:center; cursor:pointer; " +
                        "background:" + (selected === opt ? "green" : "#fff") + "; color:" + (selected === opt ? "#fff" : "#555") + "; " +
                        (index < options.length - 1 ? "border-right:1px solid #d1d1d1;" : "") + "'>" + opt + "</div>";
            });

            html += "</div>";

            // Single hidden input per segment
            html += "<input type='hidden' id='" + "Vitals_" + hiddenId + "' value='" + hiddenVal + "' />";

            html += "</div>";
            return html;
        }


        // Helper: Pain Score
        function addPainScale(selected, hiddenId) {
            var labels = ["Pain Free", "Very Mild", "Hurts Little Bit", "Tolerable", "Hurts Little More", "Very Distressing", "Hurts Even More", "Very Intense", "Hurts Whole Lot", "Unbearable", "Hurts Worst"];
            var html = "<div style='display:grid; grid-template-columns:repeat(auto-fit,minmax(90px,1fr)); gap:18px;'>";

            for (var i = 0; i <= 10; i++) {
                html += "<div onclick=\"selectPain(this,'" + "Vitals_" + hiddenId + "')\" id='painScore" + i + "' data-score='" + i + "' " +
                        "style='text-align:center; cursor:pointer; padding:10px; border-radius:10px; " +
                        "border:2px solid " + (selected === i ? "green" : "#e0e0e0") + "; " +
                        "background:" + (selected === i ? "#e9f7ef" : "#fff") + ";'>" +
                        "<img src='../images/PainSmiley/" + i + "pain.png' style='width:48px; height:48px; object-fit:contain;' />" +
                        "<div style='font-size:0.8em; margin-top:6px;'>" + i + " " + labels[i] + "</div>" +
                        "</div>";
            }

            html += "</div>";

            // Single hidden input
            var hiddenVal = selected !== undefined ? selected : "";
            html += "<input type='hidden' id='" + "Vitals_" + hiddenId + "' value='" + hiddenVal + "' />";

            return html;
        }


        // Anthropometrics
        Res += "<div class='HeaderSection_VitalDetails_Section2_MainDiv' id='HeaderSection_VitalDetails_Section2_MainDiv'>";
        Res += "<div class='HeaderSection_VitalDetails_Section2_SubDiv'>Anthropometrics</div>";
        //Res += addInput("Weight", V.Weight, "Kg", "txtWeight", { oninput: 'validateWeightHeight(this,"300")' });

        //Res += addInput(
        //"",
        //V.WalkingDuration,
        //"", // default selected
        //"cmbWeight",
        //null,   // no events
        //null,   // no extra class
        //false,  // not readonly
        //[
        //    { value: "01", text: "Measured" },
        //    { value: "02", text: "As per history given" },
        //    { value: "03", text: "Approximate" },
        //    { value: "04", text: "Not able to check" }
        //] // dropdown options with value and text
        //);

        Res += addInput(
                "Weight",
                V.Weight,
                "Kg",
                "txtWeight",
                { oninput: 'validateWeightHeight(this,"300")' },
                null,
                false,
                //["Kg", "Lb"],
                "",
                [
                    { value: "01", text: "Measured" },
                    { value: "02", text: "As per history given" },
                    { value: "03", text: "Approximate" },
                    { value: "04", text: "Not able to check" }
                ]
              );

        Res += addInput("Previous Weight", V.PreviousWeight, "Kg", "txtPreviousWeight",{onkeypress:"return checkdata();"},"",true);
        Res += addInput("Weight Loss/ Gain", V.WeightLoss, "Kg", "txtWeightLoss",{onkeypress:"return checkdata();"},"",true);
        //Res += addInput("Height", V.Height, "Cm", "txtHeight", { oninput: 'validateWeightHeight(this,"300")' });
        Res += addInput("Height", V.Height, "Cm", "txtHeight", { oninput: 'validateWeightHeight(this,"300")' },
                null,
                false,
                "",
                [
                    { value: "01", text: "Measured" },
                    { value: "02", text: "As per history given" },
                    { value: "03", text: "Approximate" },
                    { value: "04", text: "Not able to check" }
                ]
            );
         Res += addInput("Waist Circumference", V.Waist, "Cm", "txtWaist", "", 'decimal-validation');
 Res += addInput("Hip Circumference", V.Hip, "Cm", "txtHip", '', 'decimal-validation');
 Res += addInput("WHR", V.WHR, "", "txtWHR","","",true);
 Res += addInput("IBW", V.IBW, "", "txtIBW", "", "decimal-validation");
 Res += addInput("BW%", V.BWPercent, "", "txtBWPercent", "", "decimal-validation");
        Res += addInput("BMI", V.BMI, "Kg/m²", "txtBMI","","",true);
        Res += addInput("BSA", V.BSA, "m²", "txtBSA","","",true);
 Res += "</div>";

 // Vital Signs
 Res += "<div class='HeaderSection_VitalDetails_Section3_MainDiv' id='HeaderSection_VitalDetails_Section3_MainDiv'>";
 Res += "<div class='HeaderSection_VitalDetails_Section3_SubDiv'>Vital Signs</div>";
 Res += addInput("Temperature", V.Temperature, "°F", "txtTemperature", '', 'decimal-validation');
 Res += addInput("Pulse", V.Pulse, "Bpm", "txtPulse", '', 'decimal-validation');

 // Pulse Type
 if (V.PulseType === "" || V.PulseType === null || V.PulseType === undefined) {
     V.PulseType = "R";
 }

        if (HidePulseType !== "Y") {

            Res += "<div style='flex:1 1 150px; display:flex; flex-direction:column;' id='divPulseCond'>";
            Res += "<label style='font-size:0.85em; margin-bottom:3px;'>Pulse Type</label>";
            Res += "<div id='togglePulseType' style='display:flex; border:1px solid #d1d1d1; border-radius:6px; overflow:hidden;'>" +
                "<div onclick=\"selectPulseType(this,'Regular')\" style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + (V.PulseType === 'R' ? 'green' : '#f0f0f0') + "; color:" + (V.PulseType === 'R' ? 'white' : '#000') + ";'>Regular</div>" +
                "<div onclick=\"selectPulseType(this,'Irregular')\" style='flex:1; text-align:center; padding:6px; cursor:pointer; background:" + (V.PulseType === 'I' ? 'green' : '#f0f0f0') + "; color:" + (V.PulseType === 'I' ? 'white' : '#000') + ";'>Irregular</div>" +
                "<input type='hidden' id='Vitals_hdnPulseCond' value='R' />" +
                "</div></div>";
        }   
        Res += addInput("Respiratory Rate", V.RespRate, "Breaths/Minute", "txtRespRate", '', 'decimal-validation');

 // Blood Pressure
 if (V.BPSystolic === "" || V.BPSystolic === null || V.BPSystolic === undefined)
 {
     V.BPSystolic = "";
 }
 if (V.BPDiastolic === "" || V.BPDiastolic === null || V.BPDiastolic === undefined) {
     V.BPDiastolic = "";
 }
 if (V.HeadCircum === "" || V.HeadCircum === null || V.HeadCircum === undefined)
 {
     V.HeadCircum = "";
 }
 //Res += "<div style='flex:1 1 150px; display:flex; flex-direction:column;'>" +
 //       "<label style='font-size:0.85em; margin-bottom:3px;'>Blood Pressure</label>" +
 //       "<div style='display:flex; gap:5px;'>" +
 //       "<input type='text' id='Vitals_txtBPSystolic' value='" + V.BPSystolic + "' style='flex:1; min-width:60px; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='triggerInputBP'/>" +
 //       "<span style='align-self:center;'>/</span>" +
 //       "<input type='text' id='Vitals_txtBPDiastolic' value='" + V.BPDiastolic + "' style='flex:1; min-width:60px; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='triggerInputBP' />" +
 //       "</div></div>";

 Res +=
     "<div style='flex:1 1 150px; display:flex; flex-direction:column;'>" +

     "<label style='font-size:0.85em; margin-bottom:3px;'>Blood Pressure</label>" +

     "<div style='display:flex; gap:5px;'>" +

         // Systolic
         "<div style='position:relative; flex:1;'>" +
             "<input id='Vitals_txtBPSystolic' " +
             "onfocus=\"toggleBPList('Vitals_txtBPSystolic')\" " +
             "onkeyup=\"filterBPList('Vitals_txtBPSystolic')\" " +
 "style='width:100%; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='decimal-validation'/>" +

             "<div id='Vitals_txtBPSystolic_list' " +
             "style='display:none; position:absolute; top:100%; left:0; right:0;" +
             "max-height:120px; overflow-y:auto; background:#fff; border:1px solid #ccc; z-index:9999;'>" +
                 generateBPList(300, 'Vitals_txtBPSystolic') +
             "</div>" +
         "</div>" +

         "<span style='align-self:center;'>/</span>" +

         // Diastolic
         "<div style='position:relative; flex:1;'>" +
             "<input id='Vitals_txtBPDiastolic' " +
             "onfocus=\"toggleBPList('Vitals_txtBPDiastolic')\" " +
             "onkeyup=\"filterBPList('Vitals_txtBPDiastolic')\" " +
 "style='width:100%; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;'  class='decimal-validation'/>" +

             "<div id='Vitals_txtBPDiastolic_list' " +
             "style='display:none; position:absolute; top:100%; left:0; right:0;" +
             "max-height:120px; overflow-y:auto; background:#fff; border:1px solid #ccc; z-index:9999;'>" +
                 generateBPList(200, 'Vitals_txtBPDiastolic') +
             "</div>" +
         "</div>" +

     "</div>" +
     "</div>";





 Res += addInput("SpO2", V.SpO2, "%", "txtSpO2", '', 'decimal-validation');
 Res += addInput("Random Blood Sugar", V.RandomBloodSugar, "Mg/Dl", "txtRBS", '', 'decimal-validation');
 Res += addInput("Head Circumference", V.HeadCircum, "Cm", "txtHeadCirc", '', 'decimal-validation');
 Res += "</div>";



 function addEOCGScore(selected) {
     var html = "<div style='display:flex; gap:18px;'>";

     for (var i = 1; i <= 5; i++) {
         var checked = (selected == i) ? "checked" : "";

         html += "<label style='display:flex; align-items:center; gap:6px; cursor:pointer; font-size:0.85em;'>";

         html += "<input type='radio' name='Vitals_EOCGScore' value='" + i + "' " + checked + " " +
                 "style='accent-color:green; cursor:pointer;' />";

         html += i;

         html += "</label>";
     }

     html += "</div>";
     return html;
 }

 // Performance Scores
 Res += "<div class='HeaderSection_VitalDetails_Section4_MainDiv' id='HeaderSection_VitalDetails_Section4_MainDiv'>";
 Res += "<div class='HeaderSection_VitalDetails_Section4_SubDiv'>Performance Scores</div>";

 // Karnofsky Score
 Res += "<div style='flex:1 1 200px; display:flex; flex-direction:column;'>";
 Res += "<label style='font-size:0.85em; margin-bottom:3px;'>Karnofsky Score</label>";
 Res += "<div style='display:flex;'>";
 Res += "<input type='text' id='Vitals_txtKarnofsky' value='" + (V.KarnofskyScore || "") + "' " +
     "style='flex:1; padding:6px 8px; border:1px solid #d1d1d1; border-top-left-radius:6px; border-bottom-left-radius:6px;' class='decimal-validation'/>";
 Res += "<span style='padding:6px 10px; background:#f0f0f0; border:1px solid #d1d1d1; border-left:none; " +
        "border-top-right-radius:6px; border-bottom-right-radius:6px; font-size:0.85em;'>In °F</span>";
 Res += "</div></div>";

 // EOCG Score
 Res += "<div style='flex:1 1 300px; display:flex; flex-direction:column;'>";
 Res += "<label style='font-size:0.85em; margin-bottom:6px;'>ECOG Score</label>";
 Res += addEOCGScore(V.Vitals_EOCGScore);
 Res += "</div>";

 Res += "</div>";

 // Daily Activity
 Res += "<div class='HeaderSection_VitalDetails_Section5_MainDiv' id='HeaderSection_VitalDetails_Section5_MainDiv'>";
 Res += "<div style='width:100%; color:black; font-weight:600; margin-bottom:10px;'>Daily Activity</div>";
 Res += addToggle("Daily Walking", V.DailyWalking, "toggleDailyWalking", "hdnWalkingYN");
 //Res += addInput("Walking Duration", V.WalkingDuration, "Days", "txtWalkingDuration");
 //Res += addInput(
 //"Walking Duration",
 //V.WalkingDuration,
 //"Days", // default selected
 //"txtWalkingDuration",
 //null,   // no events
 //null,   // no extra class
 //false,  // not readonly
 //[
 //    { value: "Days", text: "Days" },
 //    { value: "Weeks", text: "Weeks" },
 //    { value: "Months", text: "Months" },
 //    { value: "Years", text: "Years" }
 //] // dropdown options with value and text
 //);
        Res +=
            "<div id='WalkingDurationDiv' style='flex:1 1 150px; display:" + (V.DailyWalking ? "flex" : "none") + "; flex-direction:column;'>" +

     "<label style='font-size:0.85em; margin-bottom:3px;'>Walking Duration</label>" +

     "<div style='display:flex; gap:5px;'>" +

         // Duration Number
         "<div style='position:relative; flex:1;'>" +
             "<input id='Vitals_txtWalkingDuration' " +
                 "onfocus=\"toggleWalkingDurationNumberList('Vitals_txtWalkingDuration')\" " +
                 "onkeyup=\"filterWalkingDurationNumberList('Vitals_txtWalkingDuration')\" " +
 "style='width:100%; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='decimal-validation'/>" +

             "<div id='Vitals_txtWalkingDuration_list' " +
                 "style='display:none; position:absolute; top:100%; left:0; right:0;" +
                 "max-height:120px; overflow-y:auto; background:#fff; border:1px solid #ccc; border-radius:6px; z-index:9999;'>" +
                 generateWalkingDurationDaysNumList(30, 'Vitals_txtWalkingDuration') +
             "</div>" +
         "</div>" +

         // Duration Unit
         "<div style='position:relative; flex:1;'>" +
             "<input id='Vitals_txtWalkingDurationDays' " +
                 "onfocus=\"toggleWalkingDurationDaysList('Vitals_txtWalkingDurationDays')\" " +
                 "onkeyup=\"filterWalkingDurationDaysList('Vitals_txtWalkingDurationDays')\" " +
                 "autocomplete='off' " +
                 "placeholder='Select Days...' " +
                 "style='width:100%; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' />" +

             "<div id='Vitals_txtWalkingDurationDays_list' " +
                 "style='display:none; position:absolute; top:100%; left:0; right:0;" +
                 "max-height:120px; overflow-y:auto; background:#fff; border:1px solid #ccc; border-radius:6px; z-index:9999;'>" +
         
                 // Options dynamically generated from array
                 (["Days","Weeks","Months","Years"].map(unit =>
                     "<div class='bp-option' onclick=\"selectWalkingDurationDaysValue('Vitals_txtWalkingDurationDays','" + unit + "')\" style='padding:5px 8px; cursor:pointer;'>" + unit + "</div>"
                 ).join("")) +

             "</div>" +
         "</div>" +

     "</div>" +
 "</div>";


 Res += addToggle("Daily Diet", V.DailyDiet, "toggleDailyDiet", "hdnDietYN");
 Res += addToggle("Daily Medicine", V.DailyMedicine, "toggleDailyMedicine", "hdnRegMedYN");
 Res += "</div>";

 // Pulmonary Function (PEFR)

 if (V.PEFRTechnique === "" || V.PEFRTechnique === null || V.PEFRTechnique === undefined)
 {
     V.PEFRTechnique = "N/A";
 }
 if (V.PEFRCompliance === "" || V.PEFRCompliance === null || V.PEFRCompliance === undefined) {
     V.PEFRCompliance = "N/A";
 }
 Res += "<div class='HeaderSection_VitalDetails_Section6_MainDiv' id='HeaderSection_VitalDetails_Section6_MainDiv'>";
 Res += "<div style='color:green; font-weight:600; margin-bottom:12px;'>Pulmonary Function (PEFR) Assessment</div>";
 Res += "<div style='display:flex; flex-wrap:wrap; gap:15px;'>";
 Res += addInput("PEFR", V.PEFR, "Lit/Min", "txtPEFR", '', 'decimal-validation');
 Res += addInput("Lowest PEFR", V.LowestPEFR, "Lit/Min", "txtLowestPEFR",{onkeypress:"return checkdata();"},"",true);
 Res += addInput("Highest PEFR", V.HighestPEFR, "Lit/Min", "txtHighestPEFR",{onkeypress:"return checkdata();"},"",true);
 Res += "</div>";
        Res += "<div style='display:flex; gap:20px; margin-top:15px;'>";
        Res += addSegment("Technique", V.PEFRTechnique, ["Good", "Fair", "Poor", "N/A"], "segmentPEFRTechnique", "hdnTechniqueVal");
        Res += addSegment("Compliance", V.PEFRCompliance, ["Good", "Average", "Poor", "N/A"], "segmentPEFRCompliance", "hdnComplianceVal");
        Res += "</div></div>";


        // Pain Score
        Res += "<div class='HeaderSection_VitalDetails_Section7_MainDiv' id='HeaderSection_VitalDetails_Section7_MainDiv'>";
        Res += "<div style='color:green; font-weight:600; margin-bottom:15px;'>Pain Score (Wong-Baker)</div>";
        //Res += addPainScale(V.PainScore);
        Res += addPainScale(V.PainScore,"hdnPainScore");
        Res += "</div>";


        //Electronic Readings
        Res += "<div class='HeaderSection_VitalDetails_Section8_MainDiv' style='display:none;'>";
        Res += "<div class='HeaderSection_VitalDetails_Section8_SubDiv'>Electronic Readings</div>";
        Res += addInput("Temperature", V.teleTemperature, "°F", "txteleTemp");
        Res += addInput("Pulse", V.telePulse, "Bpm", "txtelePulse");
        // Blood Pressure
        if (V.teleBPSystolic === "" || V.teleBPSystolic === null || V.teleBPSystolic === undefined)
        {
            V.teleBPSystolic = "";
        }
        if (V.teleBPDiastolic === "" || V.teleBPDiastolic === null || V.teleBPDiastolic === undefined) {
            V.teleBPDiastolic = "";
        }
        Res += "<div style='flex:1 1 150px; display:flex; flex-direction:column;'>" +
               "<label style='font-size:0.85em; margin-bottom:3px;'>Blood Pressure</label>" +
               "<div style='display:flex; gap:5px;'>" +
               "<input type='text' id='Vitals_eleSelSystolic' value='" + V.teleBPSystolic + "' style='flex:1; min-width:60px; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='triggerInputBP'/>" +
               "<span style='align-self:center;'>/</span>" +
               "<input type='text' id='Vitals_eleSelDiastolic' value='" + V.teleBPDiastolic + "' style='flex:1; min-width:60px; padding:6px 8px; border:1px solid #d1d1d1; border-radius:6px;' class='triggerInputBP' />" +
               "</div></div>";
        Res += "</div>";


   

        //Nutrition
        // Row prefixes for unique radio IDs
        const nsRowPrefixes = ["rbtnd","rbtnW","rbtnM","rbtnA","rbtnN","rbtnB"];

        // Generate a single radio option
        function addNSOption(text, score, rowIndex, optionIndex, selected) {
            var id = nsRowPrefixes[rowIndex] + "_" + optionIndex;
            var name = "nsGroup_" + rowIndex; // radios in same row are grouped
            var checked = selected ? "checked" : "";
            return '<div style="display:flex; align-items:center; gap:6px; cursor:pointer;">' +
                       '<input type="radio" name="' + name + '" id="' + id + '" value="' + score + '" ' + checked + ' onclick="calculateNSTotal()" />' +
                       '<label for="' + id + '" style="font-size:0.85em; cursor:pointer;">' + text + '</label>' +
                   '</div>';
        }

        // Generate a row with multiple options
        function addNSRow(label, options, rowIndex) {
            var html = "<tr>";
            html += "<td style='padding:10px; border:1px solid #ddd; font-size:0.85em; text-align:left;'>" + label + "</td>";
    
            for (var idx = 0; idx < options.length; idx++) {
                var opt = options[idx];
                html += "<td style='padding:10px; border:1px solid #ddd; vertical-align:top;'>" +
                            (opt ? addNSOption(opt.text, opt.score, rowIndex, idx, opt.selected) : "") +
                        "</td>";
            }

            html += "</tr>";
            return html;
        }


        // Build the Nutrition table
        Res += "<div style='border:1px solid #ccc; border-radius:10px; padding:15px; max-width:100%; box-sizing:border-box;'>";

        Res += "<div style='display:flex; flex-wrap:wrap; justify-content:space-between; align-items:center; margin-bottom:12px;'>";
        Res += "<div style='color:green; font-weight:600;'>Nutritional Screening</div>";
        Res += "<div style='display:flex; flex-wrap:wrap; align-items:center; gap:10px; margin-top:6px;'>";
        Res += "<label>Total</label>";
        Res += "<input id='nsTotal' type='text' readonly style='width:60px; padding:6px; border:1px solid #ccc; border-radius:6px;' />";
        Res += "<label style='display:flex; align-items:center; gap:4px;'><input type='checkbox' id='chkNutrSrcNA'onclick='IsNutriScreen()' /> NA</label>";
        Res += "</div></div>";

        // Responsive table
        Res += "<div style='overflow-x:auto;'>";
        Res += "<table id='tblNutrSrc' style='width:100%; border-collapse:collapse; text-align:center; min-width:600px;'>";
        Res += "<thead><tr style='background:#f5f5f5; font-size:0.85em;'>";
        Res += "<th style='border:1px solid #ddd; padding:10px;'>Criteria</th>";
        Res += "<th style='border:1px solid #ddd;'>0</th>";
        Res += "<th style='border:1px solid #ddd;'>1</th>";
        Res += "<th style='border:1px solid #ddd;'>2</th>";
        Res += "<th style='border:1px solid #ddd;'>3</th>";
        Res += "</tr></thead><tbody>";

        // Add rows
        Res += addNSRow("Decreased Food Intake Over Last 3 Months", [
            { text: "Severe loss", score: 0, selected: false },
            { text: "Moderate loss", score: 1, selected: false },
            null,
            { text: "No", score: 3, selected: false }
        ], 0);

        Res += addNSRow("Weight Loss In Last 3 Months", [
            { text: "> 3kg", score: 0, selected: false },
            null,
            null,
            { text: "No loss", score: 3, selected: false }
        ], 1);

        Res += addNSRow("Mobility", [
            { text: "Bed/Chair Bound", score: 0, selected: false },
            { text: "Able to but doesn’t", score: 1, selected: false },
            { text: "Fully Mobile", score: 2, selected: false },
            null
        ], 2);

        Res += addNSRow("Acute Disease In Last 3 Months", [
            { text: "Yes", score: 0, selected: false },
            null,
            { text: "No", score: 2, selected: false },
            null
        ], 3);

        Res += addNSRow("Neuropsychological Problem", [
            { text: "Severe Dementia", score: 0, selected: false },
            { text: "Mild Dementia", score: 1, selected: false },
            { text: "None", score: 2, selected: false },
            null
        ], 4);

        Res += addNSRow("Body Habits", [
            { text: "Cachexic / emaciated", score: 0, selected: false },
            { text: "Thin", score: 1, selected: false },
            { text: "Average", score: 2, selected: false },
            { text: "Obese", score: 3, selected: false }
        ], 5);

        Res += "</tbody></table></div>"; // table container

        // Notes
        Res += "<div style='margin-top:12px; font-size:0.85em;'>";
        Res += "<span style='color:black;font-weight:700;'>Note :</span> &nbsp; ";
        Res += "<span style='color:green;'>12–15 : Normal</span> &nbsp; ";
        Res += "<span style='color:#c89b00;'>8–11 : At Risk Of Malnutrition</span> &nbsp; ";
        Res += "<span style='color:red;'>Below 8 : Malnourished</span></div>";

        Res += "<div style='margin-top:6px; font-size:0.85em; font-weight:600;'>";
        Res += "Score &lt; 12, Notify To Consultant / Refer To Dietician</div>";

        Res += "</div>"; // main container


        //End Nutrition



        Res += "</div>"; // End outer container
        return Res;
    }

    function toggleYesNo(el, isYes, containerId, hiddenFieldId) {
        var container = document.getElementById(containerId);
        if (!container) return;

        var yes = container.children[0];
        var no = container.children[1];

        if (isYes) {
            yes.style.background = "green";
            yes.style.color = "white";
            no.style.background = "#f0f0f0";
            no.style.color = "#000";
        } else {
            no.style.background = "green";
            no.style.color = "white";
            yes.style.background = "#f0f0f0";
            yes.style.color = "#000";
        }

        // update hidden field
        if (hiddenFieldId) {
            var hdn = document.getElementById(hiddenFieldId);
            if (hdn) {
                hdn.value = isYes ? "Y" : "N";
            }
        }
        if (hiddenFieldId) {
            var hdn = document.getElementById(hiddenFieldId);
            if (hdn) {
                hdn.value = isYes ? "Y" : "N";
            }
            if (hiddenFieldId === "Vitals_hdnWalkingYN") {
                if (isYes) {
                    $("#WalkingDurationDiv").show();
                }
                else {
                    $("#WalkingDurationDiv").hide();
                    $("#Vitals_txtWalkingDuration").val("");
                    $("#Vitals_txtWalkingDurationDays").val("");
                }
            }
        }
    }

    function selectSegment(el, hiddenId) {
        var parent = el.parentNode;
        var children = parent.children;

        // Reset all buttons
        for (var i = 0; i < children.length; i++) {
            children[i].style.background = "#fff";
            children[i].style.color = "#555";
        }

        // Highlight clicked
        el.style.background = "green";
        el.style.color = "#fff";

        // Store first letter of selected option in hidden field
        if (hiddenId) {
            var hdn = document.getElementById(hiddenId);
            if (hdn) {
                hdn.value = el.getAttribute("data-value").charAt(0).toUpperCase();
            }
        }
    }

    function selectPain(el, hiddenId) {
        var parent = el.parentNode;
        var children = parent.children;

        // Reset all children borders/backgrounds
        for (var i = 0; i < children.length; i++) {
            if (children[i].tagName === "DIV") { // skip hidden input if present
                children[i].style.border = "2px solid #e0e0e0";
                children[i].style.background = "#fff";
            }
        }

        // Highlight clicked
        el.style.border = "2px solid green";
        el.style.background = "#e9f7ef";

        // Update hidden field
        if (hiddenId) {
            var hdn = document.getElementById(hiddenId);
            if (hdn) {
                hdn.value = el.getAttribute("data-score");
            }
        }
    }


    function autoResizeTextarea(el) {
        el.style.height = "auto";             // reset
        el.style.height = el.scrollHeight + "px"; // grow based on content
    }
    function selectNS(el) {
        // Find parent TD (ES5 safe)
        var td = el;
        while (td && td.tagName !== "TD") {
            td = td.parentNode;
        }

        if (!td) return;

        // Reset all spans inside TD
        var children = td.children;
        for (var i = 0; i < children.length; i++) {
            var span = children[i].getElementsByTagName("span")[0];
            if (span) {
                span.style.background = "#fff";
            }
        }

        // Set selected span
        var selectedSpan = el.getElementsByTagName("span")[0];
        if (selectedSpan) {
            selectedSpan.style.background = "#2dbb2d";
        }

        calculateNSTotal();
    }

    function calculateNSTotal() {
        var total = 0;

        // Loop through checked radios inside the table using querySelectorAll
        var elements = document.querySelectorAll("#tblNutrSrc input[type=radio]:checked");

        elements.forEach(function (el) {
            var val = parseInt(el.value);
            if (!isNaN(val)) {
                total += val;
            }
        });

        // Set the total in the nsTotal input
        var box = document.getElementById("nsTotal");
        if (box) {
            box.value = total;
        }

        // Call SVCSClr with the total value
        SVCSClr(total);
    }

    function SVCSClr(total) {
        var $txt = $("#nsTotal");
        $txt.val(total);

        if (total < 8) {
            $txt.css({ backgroundColor: "#fff6f9", border: "1px solid red", fontWeight: "900", color: "red", textAlign: "center" });
        }
        else if (total >= 8 && total <= 11) {
            $txt.css({ backgroundColor: "#fff6f9", border: "1px solid #af7c04", fontWeight: "900", color: "#af7c04", textAlign: "center" });
        }
        else if (total >= 12 && total <= 15) {
            $txt.css({ backgroundColor: "#fff6f9", border: "1px solid #006300", fontWeight: "900", color: "#006300", textAlign: "center" });
        }
    }

    function selectEOCG(el) {
        var container = el.parentNode;
        var items = container.children;

        for (var i = 0; i < items.length; i++) {
            items[i].children[0].style.background = "#fff";
        }

        el.children[0].style.background = "green";
        container.setAttribute("data-selected", el.getAttribute("data-value"));
    }

    function selectPulseType(el, value) {
        var container = el.parentNode;
        var buttons = container.children;

        // Reset both buttons
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].style.background = "#f0f0f0";
            buttons[i].style.color = "#000";
        }

        // Activate selected
        el.style.background = "green";
        el.style.color = "white";

        // Store selected value (for save)
        container.setAttribute("data-value", value);
        $("#Vitals_hdnPulseCond").val(value.substr(0, 1));
    }

    function CalNutrSrc() {
        var total = 0;
        $('#tblNutrSrc input[type=radio]:checked').each(function () {
            var val = parseInt($(this).val());
            if (!isNaN(val)) {
                total += val;
            }
        });
        // $('#txtNutrSrcTotal').val(total);
        SVCSClr(total)
    }

    function generateWalkingDurationDaysNumList(max, targetId) {
        var html = "";
        for (var i = 0; i <= max; i++) {
            html += "<div class='walkingdurationdaysnum-item' data-value='" + i +
                    "' onclick=\"selectBP('" + targetId + "', '" + i + "')\">" +
                    i + "</div>";
        }
        return html;
    }

    function toggleWalkingDurationNumberList(inputId) {
        var list = document.getElementById(inputId + "_list");
        list.style.display = "block";
        filterBPList(inputId);
    }

    function filterWalkingDurationNumberList(inputId) {
        var input = document.getElementById(inputId);
        var filter = input.value.trim();
        var items = document.querySelectorAll("#" + inputId + "_list .walkingdurationdaysnum-item");

        items.forEach(function (item) {
            if (filter === "" || item.dataset.value.startsWith(filter)) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    }

    function selectWalkingDurationDaysValue(inputId, value) {
        document.getElementById(inputId).value = value;
        document.getElementById(inputId + "_list").style.display = 'none';
    }

    function toggleWalkingDurationDaysList(inputId) {
        const list = document.getElementById(inputId + "_list");
        list.style.display = list.style.display === 'block' ? 'none' : 'block';
    }

    function filterWalkingDurationDaysList(inputId) {
        const filter = document.getElementById(inputId).value.toLowerCase();
        const list = document.getElementById(inputId + "_list");
        const options = list.getElementsByClassName('walkingdurationdays-option');
        for (let i = 0; i < options.length; i++) {
            const txt = options[i].innerText.toLowerCase();
            options[i].style.display = txt.includes(filter) ? 'block' : 'none';
        }
    }


    function generateBPList(max, targetId) {
        var html = "";
        for (var i = 0; i <= max; i++) {
            html += "<div class='bp-item' data-value='" + i +
                    "' onclick=\"selectBP('" + targetId + "', '" + i + "')\">" +
                    i + "</div>";
        }
        return html;
    }

    function selectBP(inputId, value) {
        document.getElementById(inputId).value = value;
        document.getElementById(inputId + "_list").style.display = "none";
    }

    function toggleBPList(inputId) {
        var list = document.getElementById(inputId + "_list");
        list.style.display = "block";
        filterBPList(inputId); // apply filter immediately
    }

    function filterBPList(inputId) {
        var input = document.getElementById(inputId);
        var filter = input.value.trim();
        var items = document.querySelectorAll("#" + inputId + "_list .bp-item");

        items.forEach(function (item) {
            if (filter === "" || item.dataset.value.startsWith(filter)) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    }

    function PatCompletedDisableFields()
    {
        var RMOFlagVitalsYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ?  ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEVITALSYN")%>' == "Y" ? "N" : "Y") : "N";
        if (sessionStorage.getItem("PatCompleted") === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagVitalsYN == "Y")
        {
            $("#HeaderSection_VitalDetails_Section2_MainDiv").find("*").attr("disabled", true);
            $("#HeaderSection_VitalDetails_Section3_MainDiv").find("*").attr("disabled", true);
            $("#HeaderSection_VitalDetails_Section4_MainDiv").find("*").attr("disabled", true);
            $("#HeaderSection_VitalDetails_Section5_MainDiv").find("*").attr("disabled", true);
            $("#HeaderSection_VitalDetails_Section6_MainDiv").find("*").attr("disabled", true);
            $("#HeaderSection_VitalDetails_Section7_MainDiv").find("*").attr("disabled", true);
            $("#HeaderSection_VitalDetails_Section8_MainDiv").find("*").attr("disabled", true);
            $("#Hist_C_EditVitalsInfo").find("*").attr("disabled", true);
            $("#divPulseCond").css({"pointer-events": "none","opacity": "0.8" });
            $("#HeaderSection_VitalDetails_Section5_MainDiv").css({"pointer-events": "none","opacity": "0.8" });
            $("#HeaderSection_VitalDetails_Section6_MainDiv").css({"pointer-events": "none","opacity": "0.8" });
            $("#HeaderSection_VitalDetails_Section7_MainDiv").css({"pointer-events": "none","opacity": "0.8" });
            $("#btnRollback").hide();
            $("#btnSave").hide();
        }
        else
        {
            $("#HeaderSection_VitalDetails_Section2_MainDiv").find("*").attr("disabled", false);
            $("#HeaderSection_VitalDetails_Section3_MainDiv").find("*").attr("disabled", false);
            $("#HeaderSection_VitalDetails_Section4_MainDiv").find("*").attr("disabled", false);
            $("#HeaderSection_VitalDetails_Section5_MainDiv").find("*").attr("disabled", false);
            $("#HeaderSection_VitalDetails_Section6_MainDiv").find("*").attr("disabled", false);
            $("#HeaderSection_VitalDetails_Section7_MainDiv").find("*").attr("disabled", false);
            $("#HeaderSection_VitalDetails_Section8_MainDiv").find("*").attr("disabled", false);
            $("#Hist_C_EditVitalsInfo").find("*").not("#tblNutrSrc input, #chkNutrSrcNA").attr("disabled", false);
            $("#btnRollback").show();
            $("#btnSave").show();
            $("#divPulseCond").css({
                "pointer-events": "",
                "opacity": ""
            });
            $("#HeaderSection_VitalDetails_Section5_MainDiv").css({
                "pointer-events": "",
                "opacity": ""
            });

            $("#HeaderSection_VitalDetails_Section6_MainDiv").css({
                "pointer-events": "",
                "opacity": ""
            });
            $("#HeaderSection_VitalDetails_Section7_MainDiv").css({
                "pointer-events": "",
                "opacity": ""
            });

        }
    }
    //End

</script>

<%--  NOTES  --%>
<style>
    .nt-badge {
        position: absolute;
        top: -5px; /* Adjust vertical position */
        right: -5px; /* Adjust horizontal position */
        background-color: #ffc107; /* Yellow background like your image */
        color: #333; /* CHANGE THIS for font color */
        font-weight: bold;
        font-size: 11px;
        padding: 2px 6px;
        border-radius: 50%; /* Makes it circular */
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        display: none; /* Hidden by default until count > 0 */
    }

    .nt-note-tagged {
        /*border-left: 4px solid #ffcc00;*/ /* Yellow highlight for tagged notes */
        background-color: #fffdf5;
    }
</style>
<script type="text/javascript">
    var patientNotesData = [];
    var AllpatientNotesData = [];

    /* --- POPUP TEMPLATES --- */
    function NotesTemp() {
        var currentVisitHtml = renderMiniNotesList();

        let historyHtml = "";
        if (!AllpatientNotesData || AllpatientNotesData.length === 0) {
            historyHtml = `<div style="text-align:center; padding:10px; color:#777;">No history found.</div>`;
        } else {
            let allNotes = AllpatientNotesData.flat().filter(n => n !== null);

            allNotes.sort((a, b) => {
                const parseDate = (dateStr) => {
                    try {
                        const parts = dateStr.split(' - ');
            const dateParts = parts[0].split('/');
            const timePart = parts[1];
            return new Date(`${dateParts[2]}-${dateParts[1]}-${dateParts[0]}T${timePart}`).getTime();
    } catch (e) {
        return 0;
    }
    };
    return parseDate(b.DATE) - parseDate(a.DATE); 
    });

    const notesByTranNo = {};
    const tranOrder = [];

    allNotes.forEach(note => {
        const tranNo = note.TRANNO || "Unknown";
    if (!notesByTranNo[tranNo]) {
        notesByTranNo[tranNo] = [];
        tranOrder.push(tranNo); 
    }
    notesByTranNo[tranNo].push(note);
    });

    tranOrder.forEach(tranNo => {
        historyHtml += `
    <div class="nt-tranno-header" style="margin-top:15px; font-weight:bold; font-size:0.9em; color:#333; background: #e8eaf6; padding: 10px;display:none;">
        Consultation No - ${tranNo}
    </div>`;

    notesByTranNo[tranNo].forEach(note => {
        const isTag = note.TAGYN === "Y";
    const prefix = isTag ? "<b style='color:#d32f2f;'># </b>" : "";
    const tagStyle = isTag ? "background-color: #fff9c4;" : "";
    let extraClass = note.NOTETYPE === "P" ? "nt-note-public" : "";

    if (isTag) {
        extraClass += " nt-note-tagged";
    }
    historyHtml += `
<div class="nt-note-item ${extraClass}" style="margin-left:10px; border-bottom: 1px solid #eee; ${tagStyle}">
    <div class="nt-note-text">${prefix}${note.NOTE}</div>
    <div class="nt-note-meta" style="font-size:0.8em; color:#555;">
     ${note.ISDOCT === "Y" ? "Dr. " : ""}${note.DOCTNAME} | ${note.DATE}
    </div>
    <div class="nt-note-code" style="display: none;">
    ${note.NOTECODE}
    </div>
                    
    ${note.ISDOCT === "Y" && note.DOCTNAME === gDoctName.trim() ? `
    <div style="display:flex; align-items:center; gap:8px;">
        <i class="fa fa-edit" style="font-size:20px; cursor:pointer;" title="Edit Note" onclick="EditNotes(this);"></i>
        <span style="font-size:18px; line-height:1;">|</span>
        <i class="fa fa-trash text-danger delete-row" style="font-size:20px; cursor:pointer;" title="Delete Note" onclick="DeleteNotes(this);"></i>
    </div>` : ""}
</div>`;
    });
    });
    }

    var Display = "";
    var RMOFlagNotesYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVENOTESYN")%>' == "Y" ? "N" : "Y") : "N";
        if (sessionStorage.getItem("PatCompleted") == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagNotesYN == "Y") {
        Display = "d-none";
    }

    return `
    <div class="nt-wrapper">
       <textarea
    id="txtNoteInput"
        class="nt-textarea TextAreaBorder ${Display} auto-resize" 
        placeholder="Enter patient notes here..."
    oninput="autoResizeTextarea(this)">
</textarea>
<input type="hidden" id="txtnotecd" value=""/>
<div class="nt-controls ${Display}" >
           <div class="nt-radio-group">
               <label><input type="radio" name="noteType" value="R" checked> Private</label>
               <label style="margin-left:10px;"><input type="radio" name="noteType" value="P"> Public</label>
               <label style="margin-left:15px; color: #d32f2f; font-weight: bold;">
                   <input type="checkbox" id="chkIsTag" onchange="handleTagToggle(this)"> Tag
               </label>
           </div>
           <div class="nt-btn-group">
               <button class="nt-btn-update" onclick="SavePatientNote()" id="btnSaveNotes" value="N">Save</button>
               <button class="nt-btn-clear" onclick="$('#txtNoteInput').val('')">Clear</button>
           </div>
       </div>

       <div id="NoteListContainer" class="nt-list-container" style="margin-top:10px;display:none;">
           ${currentVisitHtml}
    </div>

    <div class="aln-header">
    
<div style="display:flex; justify-content:space-between; align-items:center;">
        
    <div>
        <i class="fa fa-history"></i> Historical Patient Notes
    </div>

    <div class="nt-legend-wrapper">
        <div class="nt-legend-item">
            <span class="nt-dot" style="background-color:#0d6efd;"></span> Private
        </div>
        <div class="nt-legend-item">
            <span class="nt-dot nt-pending"></span> Public
        </div>
        <div class="nt-legend-item">
            <span class="nt-dot" style="background-color:yellow;"></span> #
        </div>
    </div>

</div>

</div>
    <div id="NotesHistory" class="aln-list" style="max-height: 350px; overflow-y: auto;">
        ${historyHtml}
    </div>

    <div id="loading-Notes-popup" class="loading-screen" style="display: none; opacity: 0;"></div>
</div>
    `;
    }
    //priyanka 21/04/2026
    function EditNotes(el) {
        $("#btnSaveNotes").text("Update");
        $("#btnSaveNotes").val("E");
        //NoteGact = "E";
        const parent = el.closest('.nt-note-item');
        const noteText = parent.querySelector('.nt-note-text').innerText.trim();
        const noteCode = parent.querySelector('.nt-note-code').innerText.trim();
        console.log("Edit Note Code:", noteCode);
        console.log("Edit Note Text:", noteText);
        document.getElementById("txtNoteInput").value = noteText;
        document.getElementById("txtnotecd").value = noteCode;
    }
    function DeleteNotes(el) {
        const parent = el.closest('.nt-note-item');
        const noteText = parent.querySelector('.nt-note-text').innerText.trim();
        const noteCode = parent.querySelector('.nt-note-code').innerText.trim();
        console.log("Edit Note Code:", noteCode);
        console.log("Edit Note Text:", noteText);
        document.getElementById("txtnotecd").value = noteCode;
        
        var isPublic = $("input[name='noteType']:checked").val() === "P";
        var user = "Dr. " + gDoctName.toString().trim();
        var date = new Date().toLocaleString();
        var strTranno = sessionStorage.getItem('PatTRANNO');
        if (strTranno == undefined) { strTranno = ""; }
        var strMrNo = sessionStorage.getItem('PatMRNO');
        var strNotes = noteText;
        var strNoteType = $("input[name='noteType']:checked")[0].value;
        var NoteTranMode = "3";
        var strNoteCode = $("#txtnotecd").val();
        var isTag = $("#chkIsTag").is(":checked");
        var TagYN = isTag ? "Y" : "N";

        $.ajax({
            url: '../DoctorDesk/SaveNotes',
            data: { strNotes: strNotes, strTranNo: strTranno, strMrNo: strMrNo, strNoteType: strNoteType, strNoteCode: strNoteCode, tranMode: NoteTranMode, TagYN: TagYN },
            datatype: 'json',
            type: 'post',
            async: false,
            success: function (result) {
                if (result.includes("Successfully")) {
                    ToastMsg(result, "Information");
                    clearNoteInput();
                    //GetPatNotes();
                    GetNotes("Y");
                    BindPatRefNote();
                    //closeMaxMinPopup('Hist_M_Notes');
                    //HistoryPopupOpen('Patient Notes', 'Notes', true);
                } else {
                    ToastMsg(result, "Information");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }

        });
    }
    //End
    function AllNotesTemp() {
        let listHtml = "";

        if (!AllpatientNotesData || AllpatientNotesData.length === 0) {
            listHtml = `<div style="text-align:center; padding:20px; color:#777;">No notes found.</div>`;
        } else {
            let allNotes = AllpatientNotesData.flat().filter(n => n !== null);

            allNotes.sort((a, b) => {
                const parseDate = (dateStr) => {
                    try {
                        const parts = dateStr.split(' - ');
            const dateParts = parts[0].split('/'); 
            const timePart = parts[1]; 

            return new Date(`${dateParts[2]}-${dateParts[1]}-${dateParts[0]}T${timePart}`).getTime();
    } catch (e) {
        console.error("Date parsing error:", e);
        return 0;
    }
    };
    return parseDate(b.DATE) - parseDate(a.DATE); 
    });

    const notesByTranNo = {};
    const tranOrder = [];

    allNotes.forEach(note => {
        const tranNo = note.TRANNO || "Unknown";
    if (!notesByTranNo[tranNo]) {
        notesByTranNo[tranNo] = [];
        tranOrder.push(tranNo);
    }
    notesByTranNo[tranNo].push(note);
    });

    tranOrder.forEach(tranNo => {
        listHtml += `<div class="nt-tranno-header" style="margin-top:15px; font-weight:bold; font-size:0.95em; color:#333; background: lavender; padding: 11px;display:none;">Consultation No - ${tranNo}</div>`;

    notesByTranNo[tranNo].forEach(note => {
        const isTag = note.TAGYN === "Y";
    const prefix = isTag ? "<b style='color:#d32f2f;'># </b>" : "";
    const tagStyle = isTag ? "background-color: #fff9c4;" : "";
    let extraClass = note.NOTETYPE === "P" ? "nt-note-public" : "";
    if (isTag) extraClass += " nt-note-tagged";

    listHtml += `
<div class="nt-note-item ${extraClass}" style="margin-left:10px; margin-bottom:5px; ${tagStyle}">
    <div class="nt-note-text">${prefix}${note.NOTE}</div>
    <div class="nt-note-meta" style="font-size:0.8em; color:#555;">
    ${note.ISDOCT === "Y" ? "Dr. " : ""}${note.DOCTNAME} | ${note.DATE}
    </div>
    <div class="nt-note-code" style="display: none;">
    ${note.NOTECODE}
    </div>
    ${note.ISDOCT === "Y" && note.DOCTNAME === gDoctName.trim() ? `
    <div style="display:flex; align-items:center; gap:8px;">
        <i class="fa fa-edit" style="font-size:20px; cursor:pointer;" title="Edit Note" onclick="EditNotes(this);"></i>
        <span style="font-size:18px; line-height:1;">|</span>
        <i class="fa fa-trash text-danger delete-row" style="font-size:20px; cursor:pointer;" title="Delete Note" onclick="DeleteNotes(this);"></i>
    </div>` : ""}

</div>`;
    });
    });
    }

    return `
    <div class="aln-wrapper">
        <div class="aln-header"><i class="fa fa-list-alt"></i> All Patient Notes</div>
        <div class="aln-list">${listHtml}</div>
    </div>
    <div class="nt-footer">
        <div class="nt-legend-wrapper">
            <div class="nt-legend-item"><span class="nt-dot nt-pending"></span> Public Notes</div>
        </div>
    </div>`;
    }

    function SavePatientNote() {
        var NoteTranMode = "";
        var text = $("#txtNoteInput").val().trim();
        if (!text) {
            ToastMsg("Please enter a note.", "Info");
            return;
        }
        var isPublic = $("input[name='noteType']:checked").val() === "P";
        var user = "Dr. " + gDoctName.toString().trim();
        var date = new Date().toLocaleString();

        var strTranno = sessionStorage.getItem('PatTRANNO');
        if (strTranno == undefined) { strTranno = ""; }
        var strMrNo = sessionStorage.getItem('PatMRNO');
        var strNotes = $("#txtNoteInput").val();
        var strNoteType = $("input[name='noteType']:checked")[0].value;

        //priyanka 21/04/2026
        var strNoteCode = $("#txtnotecd").val();
        if ($("#btnSaveNotes").val() === "N") {
            NoteTranMode = "1";
        }
        else if ($("#btnSaveNotes").val() === "E") {
            NoteTranMode = "2";
        }
        //end

        var isTag = $("#chkIsTag").is(":checked");
        var TagYN = isTag ? "Y" : "N";

        $.ajax({
            url: '../DoctorDesk/SaveNotes',
            data: { strNotes: strNotes, strTranNo: strTranno, strMrNo: strMrNo, strNoteType: strNoteType, strNoteCode: strNoteCode, tranMode: NoteTranMode, TagYN: TagYN },
            datatype: 'json',
            type: 'post',
            async: false,
            success: function (result) {
                if (result.includes("Successfully")) {
                    ToastMsg(result, "Information");
                    clearNoteInput();
                    GetNotes("Y");
                    BindPatRefNote();
                    //closeMaxMinPopup('Hist_M_Notes');
                    //HistoryPopupOpen('Patient Notes', 'Notes', true);
                } else {
                    ToastMsg(result, "Information");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });


        $("#btnSaveNotes").text("Save");
        $("#btnSaveNotes").val("N");
        $("#txtnotecd").val("");
        $("#txtNoteInput").val("");
    }

    function renderMiniNotesList() {
        var html = "";
        patientNotesData.forEach(function (note) {
            var isTag = note.type === "Y"; // Adjust based on how your data returns
            var prefix = isTag ? "<b style='color:#d32f2f;'># </b>" : "";
            var extraClass = note.type === "Public" ? " nt-note-public" : "";

            html += `
            <div class="nt-note-item ${extraClass}">
                <div class="nt-note-text">${prefix}${note.text}</div>
                <div class="nt-note-meta">
                ${note.ISDOCT === "Y" ? "Dr. " : ""}${note.user} | ${note.date}
            </div>
            <div class="nt-note-code" style="display: none;">
            ${note.NOTECODE}
            </div>
            ${note.ISDOCT === "Y" && note.DOCTNAME === gDoctName.trim() ? `
            <div style="display:flex; align-items:center; gap:8px;">
                <i class="fa fa-edit" style="font-size:20px; cursor:pointer;" title="Edit Note" onclick="EditNotes(this);"></i>
                <span style="font-size:18px; line-height:1;">|</span>
                <i class="fa fa-trash text-danger delete-row" style="font-size:20px; cursor:pointer;" title="Delete Note" onclick="DeleteNotes(this);"></i>
            </div>` : ""}
       </div>`;
            });
            return html;
        }

        function GetPatNotes() {
            var strTranno = sessionStorage.getItem('PatTRANNO');
            if (strTranno == undefined) { strTranno = ""; }
            var strMrNo = sessionStorage.getItem('PatMRNO');

            $.ajax({
                url: '../DoctorDesk/GetPatNotes',
                data: { strTranNo: strTranno, strMrNo: strMrNo },
                datatype: 'json',
                type: 'post',
                async: true,
                success: function (response) {
                    if (response != "" && response.length > 0) {
                        $("#NoteListContainer").empty();
                        patientNotesData = [];

                        // --- SORTING LOGIC: Latest Date & Time First ---
                        response.sort(function (a, b) {
                            // Convert date strings to Date objects for accurate comparison
                            return new Date(b.DATE) - new Date(a.DATE);
                        });

                        $.each(response, function (i, val) {
                            var date = val.DATE;
                            var isPublic = (val.NOTETYPE) == "R" ? "Private" : "Public";
                            var user = (val.ISDOCT === "Y" ? "Dr. " : "") + (val.DOCTNAME?.trim() || "")//priyanka 16/04/2026
                            var TagYN = val.TAGYN == "Y" ? true : false;
                            var displayText = TagYN ? "#" + val.NOTE : val.NOTE;
                            var NoteCD = val.CODE;//priyanka 21/04/2026

                            var newNoteObj = {
                                id: val.CODE,
                                text: displayText,
                                user: val.DOCTNAME,
                                date: val.DATE,
                                type: isPublic,
                                tagYN: TagYN,
                            };

                            patientNotesData.push(newNoteObj);

                            var noteClass = isPublic == "Public" ? "nt-note-item nt-note-public" : "nt-note-item";
                            if (TagYN) { noteClass += " nt-note-tagged"; }

                            var newNoteHtml = `
                            <div class="${noteClass}">
                                <div class="nt-note-text">${displayText}</div>
                                <div class="nt-note-meta">${user} | ${date}</div>
                                <div class="nt-note-text">${NoteCD}</div>
                            </div>`;
                            $("#NoteListContainer").append(newNoteHtml);
                            $("#NoteListContainer").hide();
                        });
                    }
                }
            });
        }

        function GetNotes(IsRedirect) {
            var mrNo = sessionStorage.getItem('PatMRNO');
            $.ajax({
                type: "POST",
                url: '../DoctorDesk/GetAllNotes',
                datatype: "json",
                data: { strMrNo: mrNo },
                async: true,
                success: function (result) {
                    if (result[0] != null) {
                        AllpatientNotesData = result;
                    }
                    var validNotes = result.flat().filter(x => x !== null && x !== undefined);
                    var totalNotes = validNotes.length;
                    var badge = $("#notesNotificationBadge");

                    if (totalNotes > 0) {
                        badge.text(totalNotes).show();
                    } else {
                        badge.hide();
                    }
                    BindTaggedNotes();

                    if (IsRedirect === "Y") { //priyanka 22/04/2026
                        $("#Hist_C_Notes").html(NotesTemp());
                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                }
            });
        }

        function handleTagToggle(chk) {
            const txtArea = $('#txtNoteInput');
            const currentText = txtArea.val();

            if (chk.checked) {
                if (currentText.length > 50) {
                    const userConfirmed = confirm("Tag max length is 50. Do you want to continue?");

                    if (userConfirmed) {
                        txtArea.val('');
                        applyTagStyles(txtArea, true);
                    } else {
                        $(chk).prop('checked', false);
                        applyTagStyles(txtArea, false);
                    }
                } else {
                    applyTagStyles(txtArea, true);
                }
            } else {
                applyTagStyles(txtArea, false);
            }
        }

        function applyTagStyles(txtArea, isTagMode) {
            if (isTagMode) {
                txtArea.attr('maxlength', '50');
                txtArea.attr('placeholder', 'Enter short tag (max 50 chars)...');
            } else {
                txtArea.removeAttr('maxlength');
                txtArea.attr('placeholder', 'Enter patient notes here...');
            }
        }

        function clearNoteInput() {
            $('#txtNoteInput').val('');
            $('#chkIsTag').prop('checked', false);
            applyTagStyles($('#txtNoteInput'), false);
        }

        function BindTaggedNotes() {
            if (!AllpatientNotesData || AllpatientNotesData.length === 0) return;

            const flatNotes = AllpatientNotesData.flat();
            const taggedNotes = flatNotes.filter(n => n.TAGYN === "Y");

            const tagContainer = $(".tag-chemo");
            tagContainer.empty();

            if (taggedNotes.length > 0) {
                taggedNotes.forEach(n => {
                    const tagHtml = `<span class="individual-tag"># ${n.NOTE}</span>`;
            tagContainer.append(tagHtml);
        });
        tagContainer.show();
    } else {
            tagContainer.hide();
    }
    }
</script>


<%-- Upload Attachment --%>
<script type="text/javascript">
    function UploadTemp() {
        getAttchments();
        var Display = "";
        var RMOFlagNotesYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEUPLOADYN")%>' == "Y" ? "N" : "Y") : "N";
        if (sessionStorage.getItem("PatCompleted") == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagNotesYN == "Y") {
            Display = "d-none";
        }
        return `
        <div class="upl-wrapper">
            <div class="upl-header-box ${Display}">
                <span style="font-weight:600;">Upload File:</span>
                <input type="file" id="uplFile" style="font-size:13px;" accept="image/*, application/pdf">
                <button class="upl-btn-upload" onclick="UploadPatientFile()">Upload File</button>
            </div>
            <div class="upl-section">
                <div class="upl-title">Attachments</div>
                <div id="UplAttachmentsList" class="upl-list">
                   <div class="upl-item">
                   </div>
                </div>
            </div>
            <div id="loading-Upload-popup" class="loading-screen" style="display: none; opacity: 0;"></div>
        </div>`;
    }

    function UploadPatientFile() {
        var fileInput = document.getElementById('uplFile');
        if (fileInput.files.length === 0) {
            ToastMsg("Please select a file first.");
            return;
        }
        var file = fileInput.files[0];
        var blobUrl = URL.createObjectURL(file);
        var MRNO = sessionStorage.getItem('PatMRNO');

        if (MRNO) {
            var formData = new FormData();
            formData.append("File", file);
            formData.append("Mrno", MRNO);
            startLoading("Loading...", "loading-Upload-popup");
            $.ajax({
                type: "POST",
                /*url: '../SinglePage/UploadFile',*/
                url: '../DoctorDesk/UploadFile',
                data: formData,
                dataType: 'json',
                contentType: false,
                processData: false,
                success: function (response) {
                    console.log(response);
                    if (response.Message.toLowerCase().includes("success")) {
                        ToastMsg(response.Message, "Information");
                        showFiles([file.name]); // append only on success
                    } else {
                        ToastMsg(response.Message || "File upload failed", "error");
                        document.getElementById("uplFile").value = "";
                    }
                    stopLoading("loading-Upload-popup");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    ToastMsg(textStatus, "error");
                    stopLoading("loading-Upload-popup");
                }
            });
        }
    }

    function showFiles(files) {
        
        if (files && files.length > 0) {
            files.forEach(function (fileObj) {
                var itemHtml = `
                    <div class="upl-item">
                        <a   target="_blank" class="upl-link" onclick='openNewWin(this)'>
                            <i class="fa fa-file-text-o"></i> ${fileObj}
                        </a>
                        <button class="upl-btn-delete"
                        onclick="deleteFile('${fileObj}', this)">
                        Delete
                        </button>
                    </div>`;
                $("#UplAttachmentsList").append(itemHtml);
            });
        }
        document.getElementById("uplFile").value = "";
    } 

    function deleteFile(FileName,btn) {
        var MrNo = GetSessionMRNO();//priyanka 28/02/2026
     
        $.ajax({
            type: "POST",
            url: '../SinglePage/DeleteUploadedFile',
            data: {
                MrNo: MrNo,
                FileName: FileName
            },
            dataType: 'json',
            success: function (response) {
                console.log(response);
                if (response.isDeleted) {
                    $(btn).closest('.upl-item').remove();
                    ToastMsg(response.Message, "Success");
                }
                else {
                    ToastMsg(response.Message, "Info");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });


    }

 function openNewWin(obj) {
      NAME = obj.innerText;
      var MRNO = sessionStorage.getItem('PatMRNO');
      var url = "../DoctorDesk/FileDownload?MRNo=" + MRNO + "&&filename=" + NAME
      window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
      //return Details;
  }
  function getAttchments() {
      var mr = sessionStorage.getItem('PatMRNO');
      $.ajax({
          type: "Post",
          url: '../DoctorDesk/GetAttachment',
          dataType: 'json',
         data: { MRNO: mr },
          success: function (response) {
              showFiles(response);
              stopLoading("loading-Upload-popup");
          },
          error: function (XMLHttpRequest, textStatus, errorThrown) {
              ToastMsg(textStatus, "error");
              stopLoading("loading-upload-popup");
          }
      });
  }

</script>

<%-- Patient History--%>         <%--vandana 20226--%>
<script type="text/javascript">

    var visitData = [];

    function VisitHistoryTemp() {
        return `
        <div class="vh-wrapper">
          <div class="vh-header">
              <div class="vh-radios">
                  <label><input type="radio" name="vhT" value="30" onchange="OnVisitPeriodChange(this)"> 1 Month</label>
                  <label><input type="radio" name="vhT" value="90" onchange="OnVisitPeriodChange(this)"> 3 Months</label>
                  <label><input type="radio" name="vhT" value="365" onchange="OnVisitPeriodChange(this)"> 1 Year</label>
                  <label><input  type="radio" name="vhT" value="0" onchange="OnVisitPeriodChange(this)" checked> Till Now</label>
              </div>

              <div class="vh-tabs">
                  <button id="btnVhAdm" class="vh-tab-btn" onclick="FilterVisitHistory('I', this)">Admissions (0)</button>
                  <button id="btnVhOpd" class="vh-tab-btn" onclick="FilterVisitHistory('O', this)">OPD Consultations (0)</button>
                  <button id="btnVhAll" class="vh-tab-btn" onclick="FilterVisitHistory('ALL', this)">All (0)</button>
              </div>
          </div>
          <div id="VhListContainer" class="vh-list-container"></div>
<div style="display:flex;align-items:center;gap:10px;"><div style="height:15px;width:15px;background:peachpuff;"></div><label style="font-size: 13px;">Admissions</label><div style="height:15px;width:15px;background:lightblue;"></div><label style="font-size: 13px;">OPD</label></div>
          <div id="loading-History-popup" class="loading-screen" style="display: none; opacity: 0;"></div>
        </div>`;

    }

    function OnVisitPeriodChange(radio) {
        BindPatientHistoryData(parseInt(radio.value, 10));
    }

    function LoadVisitHistory() {
        var opdCount = visitData.filter(x => x.TYPE === "O").length;
        var admCount = visitData.filter(x => x.TYPE === "I").length;
        var allCount = visitData.length;

        $("#btnVhAdm").text(`Admissions (${admCount})`);
    $("#btnVhOpd").text(`OPD Consultations (${opdCount})`);
    $("#btnVhAll").text(`All (${allCount})`);
        FilterVisitHistory('ALL', '#btnVhAll');
    }


    function FilterVisitHistory(type, btn) {

        $(".vh-tab-btn").removeClass("active");
        $(btn).addClass("active");

        var filtered = (type === 'ALL')
            ? visitData
            : visitData.filter(x => x.TYPE === type);

        var container = $("#VhListContainer");
        container.empty();

        if (filtered.length === 0) {
            container.html("<div style='color:#777; padding:20px; text-align:center;'>No records found.</div>");
            return;
        }

        filtered.forEach(item => {
            var html = "";

        if (item.TYPE === "I") {
            var doctors = Array.isArray(item.DOCTOR) ? item.DOCTOR.join(", ") : item.DOCTOR;
            html = `
            <div class="vh-item" style="background: peachpuff;">
                <span class="vh-date">${item.DT} :</span>
                <span class="vh-details">  Admitted with IP No (${item.IPNO || ''}) Under DR NAME (${doctors || ''})
    </span>
</div>
    `;
    } else if (item.TYPE === "O") {
        var complaints = Array.isArray(item.COMPLAINT) ? item.COMPLAINT.join(", ") : item.COMPLAINT;
        html = `
       <div class="vh-item" style="background: lightblue;">
            <span class="vh-date">${item.DT} :</span>
            <span class="vh-details">
                ${item.VISITTYPE} visit to ${item.DOCTOR || ''} at ${item.CNTRNAME || ''} : Complaint (${complaints || ''})
    </span>
    </div>
    `;
    }
    container.append(html);
    });
    }

    function BindPatientHistoryData(forDays) {
        var mrno = sessionStorage.getItem('PatMRNO');
        if (!mrno || mrno.trim() === "") {
            ToastMsg('Please Select Patient.', 'Validation');
            return;
        }
        startLoading("Loading...", "loading-History-popup");
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetPatientMedicalHistory",
            data: {
                sMRNo: mrno.trim(),
                sDays: forDays
            },
            dataType: "json",
            success: function (response) {
                visitData = [];

                if (response) {
                    visitData = (typeof response === "string")
                        ? JSON.parse(response)
                        : response;
                }
                stopLoading("loading-History-popup");
                LoadVisitHistory();
            },
            error:  function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
                stopLoading("loading-History-popup");
                visitData = [];
                LoadVisitHistory();
            }
        });
    }

</script>


<%-- Patient Vital History --%>
<style>
    .VitalHistorycard-panel {
        transition: box-shadow .25s;
        padding: 20px;
        margin: 0.5rem 0 1rem 0;
        border-radius: 2px;
        background-color: #fff;
    }

    .VitalHistorycard {
        position: relative;
        margin: 0.5rem 0 1rem 0;
        background-color: #fff;
        transition: box-shadow .25s;
        border-radius: 2px;
        height: 285px;
    }

        .VitalHistorycard .VitalHistorycard-title {
            font-size: 24px;
            font-weight: 300;
            color: #f6ea0a;
        }

        .VitalHistorycard .VitalHistorycard-content {
            padding: 10px 14px;
        }

    .teal.darken-2 {
        background-color: #292727;
        /*height: 282px;*/
        height: 300px;
    }

    .white-text {
        color: #fff !important;
    }

    #VitalHistorychartNote {
        height: 27px;
        font-size: 14px;
        font-weight: bold;
        background-color: #afe3f3;
    }

    .square {
        height: 10px;
        width: 10px;
        background-color: #0e6b80;
        float: left;
        margin-top: 6px;
        margin-left: 10px;
    }

    .VitalHistorynavbar1 {
        overflow: hidden;
        background-color: #3f9dc9;
        width: fit-content;
        margin-left: 60px;
        width: 192px;
    }

        .VitalHistorynavbar1 a {
            float: left;
            font-size: 14px;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

    .VitalHistorydropdown1 {
        float: left;
        overflow: hidden;
    }

        .VitalHistorydropdown1 .VitalHistorydropbtn {
            font-size: 16px;
            border: none;
            outline: none;
            color: white;
            padding: 9px 13px;
            background-color: inherit;
            font-family: inherit;
            margin: 0;
        }

        .VitalHistorynavbar1 a:hover, .VitalHistorydropdown1:hover .VitalHistorydropbtn {
            background-color: #337ab7;
        }

    .VitalHistorydropdown1-contents {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 120px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
    }

        .VitalHistorydropdown1-contents a {
            float: none;
            color: black;
            padding: 4px 14px;
            text-decoration: none;
            display: block;
            text-align: left;
        }

            .VitalHistorydropdown1-contents a:hover {
                background-color: #ddd;
            }

    .VitalHistorydropdown1:hover .VitalHistorydropdown1-contents {
        display: block;
    }

    .VitalHistorybtn-groupMeasurs button {
        background-color: #3f9dc9;
        border: 1px solid #337ab7;
        color: white;
        padding: 8px 16px;
        cursor: pointer;
        float: left;
    }

    .VitalHistorybtn-groupMeasurs:after {
        content: "";
        clear: both;
        display: table;
    }

    .VitalHistorybtn-groupMeasurs:not(:last-child) {
        border-right: none;
    }

    .VitalHistorybtn-groupMeasurs button:hover {
        background-color: #337ab7;
    }

    .VitalHistorybtn-groupMeasurs .active {
        background-color: #337ab7;
    }

    #Hist_C_VitalHistory{
        overflow:auto;
    }

    .VitalHistoryGraphCanvas {
        width: 100% !important;
        height: 250px !important;
    }

    .VitalHistoryFilterDiv {
        text-align: left;
        padding: 10px 5px;
        display: flex;
        gap: 20px;
        align-items: center;
    }
    .VitalHistoryFilterLbl {
            padding-left: 10px;
    }

    .hide-actions {
    display: none !important;
     }

  #HeaderListMenu {
    display: none;
}
  
  .table > :not(caption) > * > * { /*devendra 24/03/2026*/
    padding: 0 !important;
  }
</style>

<script type="text/javascript">
    var VitalsHistoryweightAgeArray = [];
    var VitalsHistoryheightAgeArray = [];
    var VitalsHistoryBMIAgeArray = [];
    var VitalsHistoryHeadCirAgeArray = [];
    function PatientVitalsHistoryTemp() {
        return `<div class="vh-tabs" style="padding-bottom:10px;"><button type="button" name="vitalhisttblgraph" value="G" class="vh-tab-btn">Graph</button><button value="T" type="button" name="vitalhisttblgraph" class="vh-tab-btn">Table</button><button type="button" value="A" name ="vitalhisttblgraph" class="vh-tab-btn active">All</button></div>
                <div id="VitalHistorytbldiv" class="tbldiv" style="overflow-x:auto">
                    <div  id="VitalHistoryVitalHistoryTable"></div>
                    <table id="VitalHistorytblVitalHistory" class="table" style="border-collapse: collapse;border: 1px solid #afadad;"></table>
                </div>
                <div id="VitalHistorygraphsDiv" style="display: flex;flex-wrap: wrap;">
                    <div style="float: left;">
                    <button id='VitalHistorybtnGrowthChart' style="display: none; margin-left: 5px; border-radius: 50%; height: 37px; width: 39px; color: white; margin-top: 3px;
        background-color: #398ebd; border-color: transparent; outline-style: none;" title="Show Growth chart" data-toggle="modal" data-target="#myModal">
            <span><i class="fa fa-line-chart fa-2x"></i></span></button>
    </div>
        <div class="col-md-12  col-xs-12 panel-heading divHeads" id="VitalHistorychartNote" style="display:none">
                <div style="float: left">Note-</div>
                <div class="square"></div>
                 &nbsp;&nbsp;Result</div>
    </div>
      `;
    }

    function LoadPatientVitalHistory() {
        HistoryPopupOpen("Vital History", "VitalHistory", true)
        VitalsHistoryweightAgeArray = [];
        VitalsHistoryheightAgeArray = [];
        VitalsHistoryBMIAgeArray = [];
        VitalsHistoryHeadCirAgeArray = [];
        VitalHistoryPatientData();
        $("#VitalHistorybtnGrowthChart").click(function () {
            $.dialog({
                title: 'Growth Chart',
                closeIcon: true,
                boxWidth: '70%',
                useBootstrap: false,
                content: '' +
                    '<div style="width:100%;height:45px;">' +
                    '<div class="VitalHistorynavbar1" style="float:left">' +
                    '<div class="VitalHistorydropdown1">' +
                    '<button class="VitalHistorydropbtn" id="VitalHistoryfirstBtn">0-5 Years' +
                    '</button>' +
                    '<div class="VitalHistorydropdown1-contents">' +
                    '<a href="#" class="active" id="anchorMonthly">Monthly</a>' +
                    '<a href="#" >Quarterly</a>' +
                    ' <a href="#">Half Yearly</a>' +
                    '<a href="#">Yearly</a>' +
                    '</div>' +
                    '</div> ' +
                    '<div class="VitalHistorydropdown1">' +
                    '<button class="VitalHistorydropbtn" id="VitalHistorysecondBtn">5-18 Years' +
                    '</button>' +
                    '<div class="VitalHistorydropdown1-contents">' +
                    '<a href="#">Quarterly</a>' +
                    ' <a href="#">Half Yearly</a>' +
                    '<a href="#">Yearly</a>' +
                    '</div>' +
                    '</div> ' +
                    '</div>' +
                    '<div style="float:right;width:329px;" class="VitalHistorybtn-groupMeasurs">' +
                    '<button type="button" class="active">Weight</button>' +
                    '<button type="button">Height</button>' +
                    '<button type="button">BMI</button>' +
                    '<button type="button">Head Circumference</button>' +
                    '</div>' +
                    '</div>' +
                    '<div>' +
                    '<div class="VitalHistorycard" style="height:430px">' +
                    '<div class="VitalHistorycard-content" style="-webkit-box-shadow: 0 0 5px 2px #d0d0d0; -moz-box-shadow: 0 0 5px 2px #d0d0d0; box-shadow: 0 0 5px 2px #d0d0d0;">' +
                    '<div class="VitalHistoryline-chart-wrapper" id="VitalHistorychartMainDiv">' +
                    '<p class="margin" style="font-weight: bold; font-size: 13px"></p>' +
                    '<div style="width: 100%; height: 380px;" id="VitalHistoryline-chart"></div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>'
                ,
                onContentReady: function () {
                    $(".VitalHistorybtn-groupMeasurs .active").trigger("click");
                }
            });
        });

        $(document.body).on('click', ".VitalHistorydropdown1-contents a", function (e) {
            $(".VitalHistorydropdown1-contents a").removeClass("active");
            $(this).addClass("active");
            VitalHistoryDrawGrowthChart(e);
        });

        $(document.body).on('click', ".VitalHistorybtn-groupMeasurs button", function (e) {
            $(".VitalHistorybtn-groupMeasurs button").removeClass("active");
            $(this).addClass("active");
            if ($(this)[0].innerText.indexOf("Head") != -1) {
                $("#VitalHistorysecondBtn").hide();
                $(".VitalHistorynavbar1").width("94px");
                $(".VitalHistorydropdown1-contents a#anchorMonthly").trigger("click");
            }
            else {
                $(".VitalHistorynavbar1").width("192px");
                $("#VitalHistorysecondBtn").show();
            }
            VitalHistoryDrawGrowthChart(e);
        });
    }

    function VitalHistoryDrawGrowthChart(obj) {
        var xInterval = "";
        var yInterval = "";
        var xMin = "", xMax = "", yMin = "", yMax = "";
        var toolTipContenStr = "", xAxisTitle = "", yAxisTitle = "", chartTitle = "", xAxisTitle2 = "";
        var gender = sessionStorage.getItem('PatGender') != "" ? sessionStorage.getItem('PatGender').substr(0, 1) : "M";
        var dynamicArryOfDataPnts = [];
        var unitCondition = ($(".VitalHistorydropdown1-contents .active")[0].innerText).substr(0, 1);
        var ageCondition = $(".VitalHistorydropdown1-contents .active").parents().siblings("button")[0].id;
        var parameter = $(".VitalHistorybtn-groupMeasurs .active")[0].innerText;
        var dataArray = [];
        var ArrayOfArray = [];
        var xArray = [];
        var arrPercentiles = ["3rd", "15th", "50th", "85th", "97th"];
        var axisXTitleArray = [];
        xAxisTitle = "Age(Months)";
        xAxisTitle2 = "Age(Years)";
        if (ageCondition == "VitalHistoryfirstBtn") {
            for (var i = 0; i <= 60; i++) {
                xArray.push(i);
            }
        }
        else if (ageCondition == "VitalHistorysecondBtn") {
            if (parameter == "Weight") {
                for (var i = 61; i <= 120; i++) {
                    xArray.push(i);
                }
            }
            else {
                for (var i = 61; i <= 216; i++) {
                    xArray.push(i);
                }
            }
        }
        var WFABoys1_3 = [2.5, 3.4, 4.4, 5.1, 5.6, 6.1, 6.4, 6.7, 7.0, 7.2, 7.5, 7.7, 7.8, 8.0, 8.2, 8.4, 8.5, 8.7, 8.9, 9.0, 9.2, 9.3, 9.5, 9.7, 9.8, 10.0, 10.1, 10.2, 10.4, 10.5, 10.7, 10.8, 10.9, 11.1, 11.2, 11.3, 11.4, 11.6, 11.7, 11.8, 11.9, 12.1, 12.2, 12.3, 12.4, 12.5, 12.7, 12.8, 12.9, 13.0, 13.1, 13.3, 13.4, 13.5, 13.6, 13.7, 13.8, 13.9, 14.1, 14.2, 14.3];
        var WFABoys1_15 = [2.9, 3.9, 4.9, 5.6, 6.2, 6.7, 7.1, 7.4, 7.7, 7.9, 8.2, 8.4, 8.6, 8.8, 9.0, 9.2, 9.4, 9.6, 9.7, 9.9, 10.1, 10.3, 10.5, 10.6, 10.8, 11.0, 11.1, 11.3, 11.5, 11.6, 11.8, 11.9, 12.1, 12.2, 12.4, 12.5, 12.7, 12.8, 12.9, 13.1, 13.2, 13.4, 13.5, 13.6, 13.8, 13.9, 14.1, 14.2, 14.3, 14.5, 14.6, 14.7, 14.9, 15.0, 15.2, 15.3, 15.4, 15.6, 15.7, 15.8, 16.0];
        var WFABoys1_50 = [3.3, 4.5, 5.6, 6.4, 7.0, 7.5, 7.9, 8.3, 8.6, 8.9, 9.2, 9.4, 9.6, 9.9, 10.1, 10.3, 10.5, 10.7, 10.9, 11.1, 11.3, 11.5, 11.8, 12.0, 12.2, 12.4, 12.5, 12.7, 12.9, 13.1, 13.3, 13.5, 13.7, 13.8, 14.0, 14.2, 14.3, 14.5, 14.7, 14.8, 15.0, 15.2, 15.3, 15.5, 15.7, 15.8, 16.0, 16.2, 16.3, 16.5, 16.7, 16.8, 17.0, 17.2, 17.3, 17.5, 17.7, 17.8, 18.0, 18.2, 18.3];
        var WFABoys1_85 = [3.9, 5.1, 6.3, 7.2, 7.9, 8.4, 8.9, 9.3, 9.6, 10.0, 10.3, 10.5, 10.8, 11.1, 11.3, 11.6, 11.8, 12.0, 12.3, 12.5, 12.7, 13.0, 13.2, 13.4, 13.7, 13.9, 14.1, 14.4, 14.6, 14.8, 15.0, 15.2, 15.5, 15.7, 15.9, 16.1, 16.3, 16.5, 16.7, 16.9, 17.1, 17.3, 17.5, 17.7, 17.9, 18.1, 18.3, 18.5, 18.7, 18.9, 19.1, 19.3, 19.5, 19.7, 19.9, 20.1, 20.3, 20.5, 20.7, 20.9, 21.1];
        var WFABoys1_97 = [4.3, 5.7, 7.0, 7.9, 8.6, 9.2, 9.7, 10.2, 10.5, 10.9, 11.2, 11.5, 11.8, 12.1, 12.4, 12.7, 12.9, 13.2, 13.5, 13.7, 14.0, 14.3, 14.5, 14.8, 15.1, 15.3, 15.6, 15.9, 16.1, 16.4, 16.6, 16.9, 17.1, 17.3, 17.6, 17.8, 18.0, 18.3, 18.5, 18.7, 19.0, 19.2, 19.4, 19.7, 19.9, 20.1, 20.4, 20.6, 20.9, 21.1, 21.3, 21.6, 21.8, 22.1, 22.3, 22.5, 22.8, 23.0, 23.3, 23.5, 23.8];
        var WFAGirls1_3 = [2.4, 3.2, 4.0, 4.6, 5.1, 5.5, 5.8, 6.1, 6.3, 6.6, 6.8, 7.0, 7.1, 7.3, 7.5, 7.7, 7.8, 8.0, 8.2, 8.3, 8.5, 8.7, 8.8, 9.0, 9.2, 9.3, 9.5, 9.6, 9.8, 10.0, 10.1, 10.3, 10.4, 10.5, 10.7, 10.8, 11.0, 11.1, 11.2, 11.4, 11.5, 11.6, 11.8, 11.9, 12.0, 12.1, 12.3, 12.4, 12.5, 12.6, 12.8, 12.9, 13.0, 13.1, 13.2, 13.4, 13.5, 13.6, 13.7, 13.8, 14.0];
        var WFAGirls1_15 = [2.8, 3.6, 4.5, 5.1, 5.6, 6.1, 6.4, 6.7, 7.0, 7.3, 7.5, 7.7, 7.9, 8.1, 8.3, 8.5, 8.7, 8.8, 9.0, 9.2, 9.4, 9.6, 9.8, 9.9, 10.1, 10.3, 10.5, 10.7, 10.8, 11.0, 11.2, 11.3, 11.5, 11.7, 11.8, 12.0, 12.1, 12.3, 12.5, 12.6, 12.8, 12.9, 13.1, 13.2, 13.4, 13.5, 13.7, 13.8, 14.0, 14.1, 14.3, 14.4, 14.5, 14.7, 14.8, 15.0, 15.1, 15.3, 15.4, 15.5, 15.7];
        var WFAGirls1_50 = [3.2, 4.2, 5.1, 5.8, 6.4, 6.9, 7.3, 7.6, 7.9, 8.2, 8.5, 8.7, 8.9, 9.2, 9.4, 9.6, 9.8, 10.0, 10.2, 10.4, 10.6, 10.9, 11.1, 11.3, 11.5, 11.7, 11.9, 12.1, 12.3, 12.5, 12.7, 12.9, 13.1, 13.3, 13.5, 13.7, 13.9, 14.0, 14.2, 14.4, 14.6, 14.8, 15.0, 15.2, 15.3, 15.5, 15.7, 15.9, 16.1, 16.3, 16.4, 16.6, 16.8, 17.0, 17.2, 17.3, 17.5, 17.7, 17.9, 18.0, 18.2];
        var WFAGirls1_85 = [3.7, 4.8, 5.9, 6.7, 7.3, 7.8, 8.3, 8.7, 9.0, 9.3, 9.6, 9.9, 10.2, 10.4, 10.7, 10.9, 11.2, 11.4, 11.6, 11.9, 12.1, 12.4, 12.6, 12.8, 13.1, 13.3, 13.6, 13.8, 14.0, 14.3, 14.5, 14.7, 15.0, 15.2, 15.4, 15.7, 15.9, 16.1, 16.3, 16.6, 16.8, 17.0, 17.3, 17.5, 17.7, 17.9, 18.2, 18.4, 18.6, 18.9, 19.1, 19.3, 19.5, 19.8, 20.0, 20.2, 20.4, 20.7, 20.9, 21.1, 21.3];
        var WFAGirls1_97 = [4.2, 5.4, 6.5, 7.4, 8.1, 8.7, 9.2, 9.6, 10.0, 10.4, 10.7, 11.0, 11.3, 11.6, 11.9, 12.2, 12.5, 12.7, 13.0, 13.3, 13.5, 13.8, 14.1, 14.3, 14.6, 14.9, 15.2, 15.4, 15.7, 16.0, 16.2, 16.5, 16.8, 17.0, 17.3, 17.6, 17.8, 18.1, 18.4, 18.6, 18.9, 19.2, 19.5, 19.7, 20.0, 20.3, 20.6, 20.8, 21.1, 21.4, 21.7, 22.0, 22.2, 22.5, 22.8, 23.1, 23.3, 23.6, 23.9, 24.2, 24.4];
        var WFABoys2_3 = [14.6, 14.7, 14.8, 15.0, 15.1, 15.3, 15.4, 15.5, 15.7, 15.8, 16.0, 16.1, 16.3, 16.4, 16.5, 16.7, 16.8, 17.0, 17.2, 17.3, 17.5, 17.6, 17.8, 17.9, 18.1, 18.2, 18.4, 18.5, 18.7, 18.8, 19.0, 19.1, 19.3, 19.5, 19.6, 19.8, 19.9, 20.1, 20.2, 20.4, 20.5, 20.7, 20.8, 21.0, 21.1, 21.3, 21.4, 21.6, 21.8, 21.9, 22.1, 22.2, 22.4, 22.6, 22.7, 22.9, 23.1, 23.2, 23.4, 23.6];
        var WFABoys2_15 = [16.2, 16.4, 16.5, 16.7, 16.8, 17.0, 17.1, 17.3, 17.4, 17.6, 17.7, 17.9, 18.1, 18.2, 18.4, 18.6, 18.7, 18.9, 19.1, 19.2, 19.4, 19.6, 19.8, 19.9, 20.1, 20.3, 20.5, 20.6, 20.8, 21.0, 21.2, 21.3, 21.5, 21.7, 21.9, 22.0, 22.2, 22.4, 22.6, 22.7, 22.9, 23.1, 23.3, 23.5, 23.6, 23.8, 24.0, 24.2, 24.4, 24.6, 24.7, 24.9, 25.1, 25.3, 25.5, 25.7, 25.9, 26.1, 26.3, 26.6];
        var WFABoys2_50 = [18.5, 18.7, 18.9, 19.0, 19.2, 19.4, 19.6, 19.8, 19.9, 20.1, 20.3, 20.5, 20.7, 20.9, 21.1, 21.3, 21.5, 21.7, 21.9, 22.1, 22.3, 22.5, 22.7, 22.9, 23.1, 23.3, 23.5, 23.7, 23.9, 24.1, 24.3, 24.6, 24.8, 25.0, 25.2, 25.4, 25.6, 25.9, 26.1, 26.3, 26.5, 26.7, 27.0, 27.2, 27.4, 27.6, 27.9, 28.1, 28.3, 28.6, 28.8, 29.1, 29.3, 29.6, 29.8, 30.1, 30.4, 30.6, 30.9, 31.2];
        var WFABoys2_85 = [21.2, 21.4, 21.6, 21.9, 22.1, 22.3, 22.5, 22.7, 23.0, 23.2, 23.4, 23.6, 23.9, 24.1, 24.3, 24.6, 24.8, 25.0, 25.3, 25.5, 25.8, 26.0, 26.3, 26.5, 26.8, 27.0, 27.3, 27.5, 27.8, 28.1, 28.3, 28.6, 28.9, 29.1, 29.4, 29.7, 30.0, 30.2, 30.5, 30.8, 31.1, 31.4, 31.7, 32.0, 32.3, 32.6, 32.9, 33.2, 33.5, 33.8, 34.2, 34.5, 34.8, 35.2, 35.5, 35.8, 36.2, 36.6, 36.9, 37.3];
        var WFABoys2_97 = [23.8, 24.0, 24.3, 24.5, 24.8, 25.1, 25.3, 25.6, 25.8, 26.1, 26.4, 26.7, 26.9, 27.2, 27.5, 27.8, 28.1, 28.3, 28.6, 28.9, 29.2, 29.5, 29.8, 30.1, 30.4, 30.7, 31.1, 31.4, 31.7, 32.0, 32.3, 32.7, 33.0, 33.3, 33.7, 34.0, 34.4, 34.7, 35.1, 35.5, 35.8, 36.2, 36.6, 37.0, 37.4, 37.8, 38.2, 38.6, 39.0, 39.4, 39.8, 40.3, 40.7, 41.1, 41.6, 42.0, 42.5, 43.0, 43.5, 43.9];
        var WFAGirls2_3 = [14.2, 14.3, 14.4, 14.5, 14.7, 14.8, 14.9, 15.0, 15.2, 15.3, 15.4, 15.5, 15.6, 15.8, 15.9, 16.0, 16.1, 16.3, 16.4, 16.5, 16.6, 16.8, 16.9, 17.0, 17.2, 17.3, 17.5, 17.6, 17.8, 17.9, 18.1, 18.2, 18.4, 18.6, 18.7, 18.9, 19.1, 19.2, 19.4, 19.6, 19.8, 20.0, 20.1, 20.3, 20.5, 20.7, 20.9, 21.1, 21.3, 21.5, 21.7, 21.9, 22.1, 22.3, 22.6, 22.8, 23.0, 23.2, 23.4, 23.7];
        var WFAGirls2_15 = [15.8, 16.0, 16.1, 16.3, 16.4, 16.5, 16.7, 16.8, 17.0, 17.1, 17.2, 17.4, 17.5, 17.7, 17.8, 17.9, 18.1, 18.2, 18.4, 18.5, 18.7, 18.8, 19.0, 19.2, 19.3, 19.5, 19.7, 19.8, 20.0, 20.2, 20.4, 20.6, 20.7, 20.9, 21.1, 21.3, 21.5, 21.7, 21.9, 22.1, 22.3, 22.6, 22.8, 23.0, 23.2, 23.4, 23.7, 23.9, 24.1, 24.4, 24.6, 24.8, 25.1, 25.3, 25.6, 25.8, 26.1, 26.3, 26.6, 26.9];
        var WFAGirls2_50 = [18.3, 18.4, 18.6, 18.8, 19.0, 19.1, 19.3, 19.5, 19.6, 19.8, 20.0, 20.2, 20.3, 20.5, 20.7, 20.9, 21.0, 21.2, 21.4, 21.6, 21.8, 22.0, 22.2, 22.4, 22.6, 22.8, 23.0, 23.2, 23.4, 23.6, 23.9, 24.1, 24.3, 24.5, 24.8, 25.0, 25.3, 25.5, 25.8, 26.0, 26.3, 26.6, 26.8, 27.1, 27.4, 27.6, 27.9, 28.2, 28.5, 28.8, 29.1, 29.4, 29.7, 30.0, 30.3, 30.6, 30.9, 31.2, 31.5, 31.9];
        var WFAGirls2_85 = [21.3, 21.5, 21.7, 21.9, 22.2, 22.4, 22.6, 22.8, 23.0, 23.2, 23.5, 23.7, 23.9, 24.1, 24.3, 24.6, 24.8, 25.0, 25.3, 25.5, 25.7, 26.0, 26.2, 26.5, 26.7, 27.0, 27.3, 27.5, 27.8, 28.1, 28.4, 28.7, 28.9, 29.2, 29.5, 29.8, 30.2, 30.5, 30.8, 31.1, 31.4, 31.8, 32.1, 32.5, 32.8, 33.2, 33.5, 33.9, 34.2, 34.6, 35.0, 35.3, 35.7, 36.1, 36.5, 36.9, 37.3, 37.7, 38.1, 38.5];
        var WFAGirls2_97 = [24.3, 24.6, 24.9, 25.1, 25.4, 25.7, 25.9, 26.2, 26.5, 26.7, 27.0, 27.3, 27.5, 27.8, 28.1, 28.4, 28.7, 28.9, 29.2, 29.5, 29.8, 30.1, 30.4, 30.8, 31.1, 31.4, 31.7, 32.1, 32.4, 32.8, 33.1, 33.5, 33.8, 34.2, 34.6, 34.9, 35.3, 35.7, 36.1, 36.5, 36.9, 37.4, 37.8, 38.2, 38.6, 39.1, 39.5, 40.0, 40.4, 40.9, 41.3, 41.8, 42.3, 42.7, 43.2, 43.7, 44.2, 44.7, 45.2, 45.7];
        var HFABoys1_3 = [46.3, 51.1, 54.7, 57.6, 60.0, 61.9, 63.6, 65.1, 66.5, 67.7, 69.0, 70.2, 71.3, 72.4, 73.4, 74.4, 75.4, 76.3, 77.2, 78.1, 78.9, 79.7, 80.5, 81.3, 82.1, 82.1, 82.8, 83.5, 84.2, 84.9, 85.5, 86.2, 86.8, 87.4, 88.0, 88.5, 89.1, 89.7, 90.2, 90.8, 91.3, 91.9, 92.4, 92.9, 93.4, 93.9, 94.4, 94.9, 95.4, 95.9, 96.4, 96.9, 97.4, 97.9, 98.4, 98.8, 99.3, 99.8, 100.3, 100.8, 101.2];
        var HFABoys1_15 = [47.9, 52.7, 56.4, 59.3, 61.7, 63.7, 65.4, 66.9, 68.3, 69.6, 70.9, 72.1, 73.3, 74.4, 75.5, 76.5, 77.5, 78.5, 79.5, 80.4, 81.3, 82.2, 83.0, 83.8, 84.6, 84.7, 85.5, 86.3, 87.0, 87.7, 88.4, 89.1, 89.7, 90.4, 91.0, 91.6, 92.2, 92.8, 93.4, 94.0, 94.6, 95.2, 95.7, 96.3, 96.8, 97.4, 97.9, 98.5, 99.0, 99.5, 100.0, 100.5, 101.1, 101.6, 102.1, 102.6, 103.1, 103.6, 104.1, 104.7, 105.2];
        var HFABoys1_50 = [49.9, 54.7, 58.4, 61.4, 63.9, 65.9, 67.6, 69.2, 70.6, 72.0, 73.3, 74.5, 75.7, 76.9, 78.0, 79.1, 80.2, 81.2, 82.3, 83.2, 84.2, 85.1, 86.0, 86.9, 87.8, 88.0, 88.8, 89.6, 90.4, 91.2, 91.9, 92.7, 93.4, 94.1, 94.8, 95.4, 96.1, 96.7, 97.4, 98.0, 98.6, 99.2, 99.9, 100.4, 101.0, 101.6, 102.2, 102.8, 103.3, 103.9, 104.4, 105.0, 105.6, 106.1, 106.7, 107.2, 107.8, 108.3, 108.9, 109.4, 110.0];
        var HFABoys1_85 = [51.8, 56.7, 60.5, 63.5, 66.0, 68.1, 69.8, 71.4, 72.9, 74.3, 75.6, 77.0, 78.2, 79.4, 80.6, 81.8, 82.9, 84.0, 85.1, 86.1, 87.1, 88.1, 89.1, 90.0, 91.0, 91.2, 92.1, 93.0, 93.8, 94.7, 95.5, 96.2, 97.0, 97.8, 98.5, 99.2, 99.9, 100.6, 101.3, 102.0, 102.7, 103.3, 104.0, 104.6, 105.2, 105.8, 106.5, 107.1, 107.7, 108.3, 108.9, 109.5, 110.1, 110.7, 111.2, 111.8, 112.4, 113.0, 113.6, 114.2, 114.8];
        var HFABoys1_97 = [53.4, 58.4, 62.2, 65.3, 67.8, 69.9, 71.6, 73.2, 74.7, 76.2, 77.6, 78.9, 80.2, 81.5, 82.7, 83.9, 85.1, 86.2, 87.3, 88.4, 89.5, 90.5, 91.6, 92.6, 93.6, 93.8, 94.8, 95.7, 96.6, 97.5, 98.3, 99.2, 100.0, 100.8, 101.5, 102.3, 103.1, 103.8, 104.5, 105.2, 105.9, 106.6, 107.3, 108.0, 108.6, 109.3, 109.9, 110.6, 111.2, 111.8, 112.5, 113.1, 113.7, 114.3, 115.0, 115.6, 116.2, 116.8, 117.4, 118.1, 118.7];
        var HFABoys2_3 = [101.6, 102.1, 102.6, 103.1, 103.5, 104.0, 104.4, 104.9, 105.4, 105.8, 106.2, 106.7, 107.1, 107.6, 108.0, 108.4, 108.8, 109.3, 109.7, 110.1, 110.5, 111.0, 111.4, 111.8, 112.2, 112.6, 113.0, 113.4, 113.8, 114.3, 114.7, 115.1, 115.5, 115.9, 116.2, 116.6, 117.0, 117.4, 117.8, 118.2, 118.6, 119.0, 119.3, 119.7, 120.1, 120.5, 120.9, 121.3, 121.6, 122.0, 122.4, 122.8, 123.2, 123.5, 123.9, 124.3, 124.7, 125.0, 125.4, 125.8, 126.2, 126.5, 126.9, 127.3, 127.7, 128.1, 128.5, 128.9, 129.2, 129.6, 130.0, 130.5, 130.9, 131.3, 131.7, 132.1, 132.6, 133.0, 133.4, 133.9, 134.3, 134.8, 135.3, 135.8, 136.2, 136.7, 137.2, 137.7, 138.3, 138.8, 139.3, 139.9, 140.4, 141.5, 142.1, 142.6, 143.2, 143.8, 144.3, 144.9, 145.4, 146.0, 146.6, 147.1, 147.6, 148.2, 148.7, 149.2, 149.7, 150.3, 150.7, 151.2, 151.7, 152.2, 152.6, 153.0, 153.5, 153.9, 154.3, 154.7, 155.1, 155.4, 155.8, 156.1, 156.5, 156.8, 157.1, 157.4, 157.7, 158.0, 158.3, 158.5, 158.8, 159.0, 159.3, 159.5, 159.7, 159.9, 160.1, 160.3, 160.5, 160.6, 160.8, 160.9, 161.1, 161.2, 161.3, 161.4, 161.5, 161.7, 161.7, 161.8, 161.9, 162.0, 162.1];
        var HFABoys2_15 = [105.5, 106.0, 106.5, 107.0, 107.5, 108.0, 108.5, 109.0, 109.4, 109.9, 110.4, 110.8, 111.3, 111.8, 112.2, 112.7, 113.1, 113.6, 114.0, 114.5, 114.9, 115.4, 115.8, 116.3, 116.7, 117.1, 117.6, 118.0, 118.4, 118.9, 119.3, 119.7, 120.2, 120.6, 121.0, 121.4, 121.8, 122.2, 122.7, 123.1, 123.5, 123.9, 124.3, 124.7, 125.1, 125.5, 125.9, 126.3, 126.7, 127.1, 127.6, 128.0, 128.4, 128.8, 129.2, 129.6, 130.0, 130.4, 130.8, 131.2, 131.6, 132.0, 132.4, 132.8, 133.2, 133.6, 134.0, 134.4, 134.9, 135.3, 135.7, 136.1, 136.6, 137.0, 137.5, 137.9, 138.4, 138.8, 139.3, 139.8, 140.3, 140.7, 141.2, 141.7, 142.2, 142.8, 143.3, 143.8, 144.4, 144.9, 145.5, 146.0, 146.6, 147.2, 147.8, 148.3, 148.9, 149.5, 150.1, 150.7, 151.3, 151.8, 152.4, 153.0, 153.6, 154.1, 154.7, 155.2, 155.7, 156.3, 156.8, 157.3, 157.8, 158.3, 158.7, 159.2, 159.6, 160.0, 160.5, 160.9, 161.3, 161.6, 162.0, 162.4, 162.7, 163.1, 163.4, 163.7, 164.0, 164.3, 164.6, 164.8, 165.1, 165.3, 165.6, 165.8, 166.0, 166.2, 166.4, 166.6, 166.8, 166.9, 167.1, 167.2, 167.4, 167.5, 167.6, 167.7, 167.8, 167.9, 168.0, 168.1, 168.2, 168.3, 168.3, 168.4];
        var HFABoys2_50 = [110.3, 110.8, 111.3, 111.9, 112.4, 112.9, 113.4, 113.9, 114.5, 115.0, 115.5, 116.0, 116.4, 117.4, 117.9, 118.4, 118.9, 119.4, 119.8, 120.3, 120.8, 121.3, 121.7, 122.2, 122.7, 123.1, 123.6, 124.1, 124.5, 125.0, 125.5, 125.9, 126.4, 126.8, 127.3, 127.7, 128.2, 128.6, 129.0, 129.5, 129.9, 130.4, 130.8, 131.3, 131.7, 132.1, 132.6, 133.0, 133.4, 133.9, 134.3, 134.7, 135.2, 135.6, 136.1, 136.5, 136.9, 137.3, 137.8, 138.2, 138.6, 139.1, 139.5, 140.0, 140.4, 140.8, 141.3, 141.7, 142.2, 142.7, 143.1, 143.6, 144.1, 144.5, 145.0, 145.5, 146.0, 146.5, 147.0, 147.5, 148.0, 148.5, 149.1, 149.6, 150.2, 150.7, 151.3, 151.9, 152.4, 153.0, 153.6, 154.2, 154.8, 155.4, 156.0, 156.7, 157.3, 157.9, 158.5, 159.1, 159.7, 160.3, 160.9, 161.5, 162.1, 162.6, 163.2, 163.7, 164.3, 164.8, 165.3, 165.8, 166.3, 166.8, 167.2, 167.7, 168.1, 168.5, 169.0, 169.4, 169.7, 170.1, 170.5, 170.8, 171.1, 171.5, 171.8, 172.1, 172.4, 172.6, 172.9, 173.1, 173.4, 173.6, 173.8, 174.0, 174.2, 174.4, 174.6, 174.7, 174.9, 175.0, 175.2, 175.3, 175.4, 175.5, 175.6, 175.7, 175.8, 175.8, 175.9, 176.0, 176.0, 176.1, 176.1];
        var HFABoys2_85 = [115.0, 115.6, 116.2, 116.7, 117.3, 117.8, 118.4, 118.9, 119.5, 120.0, 120.5, 121.1, 121.6, 122.1, 122.6, 123.1, 123.6, 124.2, 124.7, 125.2, 125.7, 126.2, 126.7, 127.2, 127.7, 128.2, 128.7, 129.2, 129.7, 130.2, 130.7, 131.2, 131.7, 132.2, 132.6, 133.1, 133.6, 134.1, 134.6, 135.0, 135.5, 136.0, 136.4, 136.9, 137.4, 137.9, 138.3, 138.8, 139.3, 139.7, 140.2, 140.7, 141.1, 141.6, 142.1, 142.5, 143.0, 143.5, 143.9, 144.4, 144.8, 145.3, 145.8, 146.2, 146.7, 147.2, 147.7, 148.1, 148.6, 149.1, 149.6, 150.1, 150.6, 151.1, 151.6, 152.1, 152.6, 153.1, 153.7, 154.2, 154.8, 155.3, 155.9, 156.4, 157.0, 157.6, 158.2, 158.8, 159.4, 160.0, 160.6, 161.2, 161.8, 162.5, 163.1, 163.7, 164.4, 165.0, 165.7, 166.3, 166.9, 167.5, 168.2, 168.8, 169.4, 170.0, 170.6, 171.2, 171.7, 172.3, 172.8, 173.3, 173.9, 174.4, 174.8, 175.3, 175.8, 176.2, 176.6, 177.0, 177.4, 177.8, 178.2, 178.6, 178.9, 179.2, 179.6, 179.9, 180.1, 180.4, 180.7, 181.0, 181.2, 181.4, 181.6, 181.8, 182.0, 182.2, 182.4, 182.6, 182.7, 182.8, 183.0, 183.1, 183.2, 183.3, 183.4, 183.5, 183.5, 183.6, 183.7, 183.7, 183.8, 183.8, 183.9, 183.9];
        var HFABoys2_97 = [118.9, 119.5, 120.1, 120.7, 121.3, 121.8, 122.4, 123.0, 123.5, 124.1, 124.7, 125.2, 125.8, 126.3, 126.9, 127.4, 127.9, 128.5, 129.0, 129.5, 130.1, 130.6, 131.1, 131.7, 132.2, 132.7, 133.3, 133.8, 134.3, 134.8, 135.3, 135.9, 136.4, 136.9, 137.4, 137.9, 138.4, 138.9, 139.4, 139.9, 140.4, 140.9, 141.4, 141.9, 142.4, 142.9, 143.4, 143.9, 144.4, 144.9, 145.4, 145.8, 146.3, 146.8, 147.3, 147.8, 148.3, 148.8, 149.3, 149.8, 150.3, 150.7, 151.2, 151.7, 152.2, 152.7, 153.2, 153.7, 154.2, 154.7, 155.3, 155.8, 156.3, 156.8, 157.4, 157.9, 158.4, 159.0, 159.5, 160.1, 160.7, 161.2, 161.8, 162.4, 163.0, 163.6, 164.2, 164.8, 165.5, 166.1, 166.7, 167.4, 168.0, 168.7, 169.4, 170.0, 170.7, 171.3, 172.0, 172.6, 173.3, 173.9, 174.6, 175.2, 175.8, 176.5, 177.1, 177.6, 178.2, 178.8, 179.3, 179.9, 180.4, 180.9, 181.4, 181.9, 182.3, 182.8, 183.2, 183.6, 184.0, 184.4, 184.8, 185.1, 185.5, 185.8, 186.1, 186.4, 186.7, 187.0, 187.3, 187.5, 187.7, 188.0, 188.2, 188.4, 188.6, 188.7, 188.9, 189.0, 189.2, 189.3, 189.4, 189.5, 189.6, 189.7, 189.8, 189.9, 189.9, 190.0, 190.0, 190.1, 190.1, 190.1, 190.2, 190.2];
        var HFAGirls1_3 = [45.6, 50.0, 53.2, 55.8, 58.0, 59.9, 61.5, 62.9, 64.3, 65.6, 66.8, 68.0, 69.2, 70.3, 71.3, 72.4, 73.3, 74.3, 75.2, 76.2, 77.0, 77.9, 78.7, 79.6, 80.3, 80.4, 81.2, 81.9, 82.6, 83.4, 84.0, 84.7, 85.4, 86.0, 86.7, 87.3, 87.9, 88.5, 89.1, 89.7, 90.3, 90.8, 91.4, 92.0, 92.5, 93.0, 93.6, 94.1, 94.6, 95.1, 95.7, 96.2, 96.7, 97.2, 97.6, 98.1, 98.6, 99.1, 99.6, 100.0, 100.5];
        var HFAGirls1_15 = [47.2, 51.7, 55.0, 57.6, 59.8, 61.7, 63.4, 64.9, 66.3, 67.6, 68.9, 70.2, 71.3, 72.5, 73.6, 74.7, 75.7, 76.7, 77.7, 78.7, 79.6, 80.5, 81.4, 82.2, 83.1, 83.2, 84.0, 84.8, 85.5, 86.3, 87.0, 87.7, 88.4, 89.1, 89.8, 90.5, 91.1, 91.7, 92.4, 93.0, 93.6, 94.2, 94.8, 95.4, 96.0, 96.6, 97.2, 97.7, 98.3, 98.8, 99.4, 99.9, 100.4, 101.0, 101.5, 102.0, 102.5, 103.0, 103.5, 104.0, 104.5];
        var HFAGirls1_50 = [49.1, 53.7, 57.1, 59.8, 62.1, 64.0, 65.7, 67.3, 68.7, 70.1, 71.5, 72.8, 74.0, 75.2, 76.4, 77.5, 78.6, 79.7, 80.7, 81.7, 82.7, 83.7, 84.6, 85.5, 86.4, 86.6, 87.4, 88.3, 89.1, 89.9, 90.7, 91.4, 92.2, 92.9, 93.6, 94.4, 95.1, 95.7, 96.4, 97.1, 97.7, 98.4, 99.0, 99.7, 100.3, 100.9, 101.5, 102.1, 102.7, 103.3, 103.9, 104.5, 105.0, 105.6, 106.2, 106.7, 107.3, 107.8, 108.4, 108.9, 109.4];
        var HFAGirls1_85 = [51.1, 55.7, 59.2, 62.0, 64.3, 66.3, 68.1, 69.7, 71.2, 72.6, 74.0, 75.4, 76.7, 77.9, 79.2, 80.3, 81.5, 82.6, 83.7, 84.8, 85.8, 86.8, 87.8, 88.8, 89.8, 90.0, 90.9, 91.8, 92.7, 93.5, 94.3, 95.2, 95.9, 96.7, 97.5, 98.3, 99.0, 99.7, 100.5, 101.2, 101.9, 102.6, 103.3, 103.9, 104.6, 105.3, 105.9, 106.6, 107.2, 107.8, 108.4, 109.1, 109.7, 110.3, 110.9, 111.5, 112.1, 112.6, 113.2, 113.8, 114.4];
        var HFAGirls1_97 = [52.7, 57.4, 60.9, 63.8, 66.2, 68.2, 70.0, 71.6, 73.2, 74.7, 76.1, 77.5, 78.9, 80.2, 81.4, 82.7, 83.9, 85.0, 86.2, 87.3, 88.4, 89.4, 90.5, 91.5, 92.5, 92.8, 93.7, 94.6, 95.6, 96.4, 97.3, 98.2, 99.0, 99.8, 100.6, 101.4, 102.2, 103.0, 103.7, 104.5, 105.2, 106.0, 106.7, 107.4, 108.1, 108.8, 109.5, 110.2, 110.8, 111.5, 112.1, 112.8, 113.4, 114.1, 114.7, 115.3, 116.0, 116.6, 117.2, 117.8, 118.4];
        var HFAGirls2_3 = [100.6, 101.1, 101.5, 102.0, 102.4, 102.9, 103.3, 103.8, 104.2, 104.6, 105.1, 105.5, 105.9, 106.3, 106.8, 107.2, 107.6, 108.0, 108.4, 108.9, 109.3, 109.7, 110.1, 110.5, 110.9, 111.4, 111.8, 112.2, 112.6, 113.1, 113.5, 113.9, 114.4, 114.8, 115.2, 115.7, 116.1, 116.5, 117.0, 117.4, 117.9, 118.3, 118.7, 119.2, 119.6, 120.1, 120.5, 121.0, 121.5, 121.9, 122.4, 122.8, 123.3, 123.8, 124.2, 124.7, 125.2, 125.7, 126.1, 126.6, 127.1, 127.6, 128.1, 128.5, 129.0, 129.5, 130.0, 130.5, 131.0, 131.5, 132.0, 132.5, 133.0, 133.5, 134.0, 134.5, 135.0, 135.5, 136.0, 136.5, 136.9, 137.4, 137.9, 138.4, 138.8, 139.3, 139.7, 140.2, 140.6, 141.0, 141.4, 141.8, 142.2, 142.6, 143.0, 143.3, 143.7, 144.0, 144.3, 144.6, 144.9, 145.2, 145.5, 145.8, 146.0, 146.3, 146.5, 146.7, 146.9, 147.2, 147.3, 147.5, 147.7, 147.9, 148.0, 148.2, 148.3, 148.5, 148.6, 148.7, 148.8, 149.0, 149.1, 149.2, 149.2, 149.3, 149.4, 149.5, 149.6, 149.6, 149.7, 149.8, 149.8, 149.9, 149.9, 150.0, 150.0, 150.0, 150.1, 150.1, 150.2, 150.2, 150.2, 150.3, 150.3, 150.3, 150.4, 150.4, 150.4, 150.5, 150.5, 150.5, 150.5, 150.6, 150.6, 150.6];
        var HFAGirls2_15 = [104.7, 105.1, 105.6, 106.1, 106.6, 107.1, 107.5, 108.0, 108.5, 108.9, 109.4, 109.8, 110.3, 110.7, 111.2, 111.6, 112.0, 112.5, 112.9, 113.4, 113.8, 114.3, 114.7, 115.1, 115.6, 116.0, 116.5, 116.9, 117.4, 117.8, 118.3, 118.7, 119.2, 119.6, 120.1, 120.5, 121.0, 121.5, 121.9, 122.4, 122.9, 123.3, 123.8, 124.3, 124.7, 125.2, 125.7, 126.2, 126.6, 127.1, 127.6, 128.1, 128.6, 129.1, 129.5, 130.0, 130.5, 131.0, 131.5, 132.0, 132.5, 133.0, 133.5, 134.0, 134.5, 135.0, 135.5, 136.0, 136.6, 137.1, 137.6, 138.1, 138.6, 139.1, 139.7, 140.2, 140.7, 141.2, 141.7, 142.2, 142.7, 143.2, 143.7, 144.1, 144.6, 145.1, 145.5, 146.0, 146.4, 146.8, 147.3, 147.7, 148.1, 148.4, 148.8, 149.2, 149.5, 149.9, 150.2, 150.5, 150.8, 151.1, 151.4, 151.6, 151.9, 152.1, 152.4, 152.6, 152.8, 153.0, 153.2, 153.4, 153.6, 153.7, 153.9, 154.0, 154.2, 154.3, 154.4, 154.5, 154.6, 154.8, 154.8, 154.9, 155.0, 155.1, 155.2, 155.2, 155.3, 155.4, 155.4, 155.5, 155.5, 155.6, 155.6, 155.7, 155.7, 155.7, 155.8, 155.8, 155.8, 155.9, 155.9, 155.9, 155.9, 156.0, 156.0, 156.0, 156.1, 156.1, 156.1, 156.1, 156.1, 156.2, 156.2, 156.2];
        var HFAGirls2_50 = [109.6, 110.1, 110.6, 111.2, 111.7, 112.2, 112.7, 113.2, 113.7, 114.2, 114.6, 115.1, 115.6, 116.1, 116.6, 117.0, 117.5, 118.0, 118.4, 118.9, 119.4, 119.9, 120.3, 120.8, 121.3, 121.8, 122.2, 122.7, 123.2, 123.7, 124.1, 124.6, 125.1, 125.6, 126.1, 126.6, 127.0, 127.5, 128.0, 128.5, 129.0, 129.5, 130.0, 130.5, 131.0, 131.5, 132.0, 132.5, 133.0, 133.5, 134.0, 134.5, 135.0, 135.5, 136.1, 136.6, 137.1, 137.6, 138.1, 138.6, 139.2, 139.7, 140.2, 140.7, 141.3, 141.8, 142.3, 142.9, 143.4, 143.9, 144.5, 145.0, 145.5, 146.1, 146.6, 147.1, 147.7, 148.2, 148.7, 149.2, 149.7, 150.2, 150.7, 151.2, 151.7, 152.2, 152.7, 153.1, 153.6, 154.0, 154.4, 154.8, 155.2, 155.6, 156.0, 156.4, 156.7, 157.1, 157.4, 157.7, 158.0, 158.3, 158.6, 158.8, 159.1, 159.3, 159.6, 159.8, 160.0, 160.2, 160.4, 160.6, 160.7, 160.9, 161.0, 161.2, 161.3, 161.4, 161.6, 161.7, 161.8, 161.9, 162.0, 162.0, 162.1, 162.2, 162.3, 162.3, 162.4, 162.4, 162.5, 162.5, 162.6, 162.6, 162.6, 162.7, 162.7, 162.7, 162.7, 162.8, 162.8, 162.8, 162.8, 162.9, 162.9, 162.9, 162.9, 162.9, 162.9, 163.0, 163.0, 163.0, 163.0, 163.0, 163.0, 163.1];
        var HFAGirls2_85 = [114.5, 115.1, 115.7, 116.2, 116.8, 117.3, 117.8, 118.4, 118.9, 119.4, 119.9, 120.4, 120.9, 121.4, 122.0, 122.5, 123.0, 123.5, 124.0, 124.5, 125.0, 125.5, 126.0, 126.5, 127.0, 127.5, 128.0, 128.5, 129.0, 129.5, 130.0, 130.5, 131.0, 131.5, 132.1, 132.6, 133.1, 133.6, 134.1, 134.6, 135.2, 135.7, 136.2, 136.7, 137.2, 137.8, 138.3, 139.4, 139.9, 140.4, 141.0, 141.5, 142.0, 142.6, 143.1, 143.6, 144.2, 144.7, 145.3, 145.8, 146.4, 146.9, 147.5, 148.0, 148.6, 149.1, 149.7, 150.2, 150.8, 151.3, 151.9, 152.4, 153.0, 153.5, 154.1, 154.6, 155.2, 155.7, 156.3, 156.8, 157.3, 157.8, 158.3, 158.8, 159.3, 159.8, 160.3, 160.7, 161.2, 161.6, 162.0, 162.4, 162.8, 163.2, 163.6, 163.9, 164.9, 164.3, 164.6, 164.9, 165.2, 165.5, 165.8, 166.0, 166.3, 166.5, 166.8, 167.0, 167.2, 167.4, 167.6, 167.7, 167.9, 168.1, 168.2, 168.3, 168.5, 168.6, 168.7, 168.8, 168.9, 169.0, 169.1, 169.1, 169.2, 169.3, 169.3, 169.4, 169.4, 169.5, 169.5, 169.6, 169.6, 169.6, 169.6, 169.7, 169.7, 169.7, 169.7, 169.7, 169.8, 169.8, 169.8, 169.8, 169.8, 169.8, 169.8, 169.8, 169.8, 169.9, 169.9, 169.9, 169.9, 169.9, 169.9, 169.9];
        var HFAGirls2_97 = [118.6, 119.2, 119.7, 120.3, 120.9, 121.5, 122.0, 122.6, 123.1, 123.7, 124.2, 124.8, 125.3, 125.8, 126.4, 126.9, 127.4, 127.9, 128.5, 129.0, 129.5, 130.0, 130.6, 131.1, 131.6, 132.1, 132.7, 133.2, 133.7, 134.3, 134.8, 135.3, 135.9, 136.4, 136.9, 137.5, 138.0, 138.5, 139.1, 139.6, 140.2, 140.7, 141.2, 141.8, 142.3, 142.9, 143.4, 144.0, 144.5, 145.1, 145.6, 146.2, 146.8, 147.3, 147.9, 148.4, 149.0, 149.5, 150.1, 150.7, 151.2, 151.8, 152.4, 152.9, 153.5, 154.1, 154.6, 155.2, 155.8, 156.3, 156.9, 157.5, 158.1, 158.6, 159.2, 159.8, 160.3, 160.9, 161.4, 162.0, 162.5, 163.1, 163.6, 164.1, 164.6, 165.1, 165.6, 166.1, 166.5, 167.0, 167.4, 167.9, 168.3, 168.7, 169.1, 169.4, 169.8, 170.1, 170.5, 170.8, 171.1, 171.4, 171.7, 171.9, 172.2, 172.4, 172.6, 172.8, 173.0, 173.2, 173.4, 173.6, 173.8, 173.9, 174.0, 174.2, 174.3, 174.4, 174.5, 174.6, 174.7, 174.8, 174.9, 174.9, 175.0, 175.0, 175.1, 175.1, 175.2, 175.2, 175.3, 175.3, 175.3, 175.3, 175.3, 175.4, 175.4, 175.4, 175.4, 175.4, 175.4, 175.4, 175.4, 175.4, 175.4, 175.5, 175.5, 175.5, 175.5, 175.5, 175.5, 175.5, 175.5, 175.5, 175.5, 175.5];
        var BFABoys1_3_0T2 = [11.3, 12.6, 13.8, 14.4, 14.7, 14.8, 14.9, 14.9, 14.9, 14.8, 14.7, 14.6, 14.5, 14.4, 14.3, 14.2, 14.2, 14.1, 14.0, 13.9, 13.9, 13.8, 13.8, 13.7, 13.7];//bmi fr age boys 0-2 years 3rd
        var BFABoys1_15_0T2 = [12.2, 13.6, 14.9, 15.5, 15.7, 15.9, 15.9, 15.9, 15.9, 15.8, 15.7, 15.6, 15.5, 15.4, 15.3, 15.2, 15.1, 15.0, 14.9, 14.8, 14.8, 14.7, 14.6, 14.6, 14.5];//bmi fr age boys 0-2 years 15th
        var BFABoys1_50_0T2 = [13.4, 14.9, 16.3, 16.9, 17.2, 17.3, 17.3, 17.3, 17.3, 17.2, 17.0, 16.9, 16.8, 16.7, 16.6, 16.4, 16.3, 16.2, 16.1, 16.1, 16.0, 15.9, 15.8, 15.8, 15.7];//bmi fr age boys 0-2 years 50th
        var BFABoys1_85_0T2 = [14.8, 16.4, 17.8, 18.5, 18.7, 18.9, 18.9, 18.9, 18.8, 18.7, 18.6, 18.4, 18.3, 18.1, 18.0, 17.9, 17.8, 17.6, 17.5, 17.4, 17.4, 17.3, 17.2, 17.1, 17.1];//bmi fr age boys 0-2 years 85th
        var BFABoys1_97_0T2 = [16.1, 17.6, 19.2, 19.8, 20.1, 20.2, 20.3, 20.3, 20.2, 20.1, 19.9, 19.8, 19.6, 19.5, 19.3, 19.2, 19.1, 18.9, 18.8, 18.7, 18.6, 18.6, 18.5, 18.4, 18.3];//bmi fr age boys 0-2 years 97th
        var BFABoys1_3_2T5 = [13.9, 13.9, 13.8, 13.8, 13.8, 13.7, 13.7, 13.7, 13.6, 13.6, 13.5, 13.5, 13.5, 13.5, 13.4, 13.4, 13.4, 13.3, 13.3, 13.3, 13.3, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.1, 13.1, 13.1, 13.1, 13.1, 13.1, 13.0, 13.0, 13.0, 13.0];
        var BFABoys1_15_2T5 = [14.8, 14.8, 14.7, 14.7, 14.7, 14.6, 14.6, 14.5, 14.5, 14.5, 14.4, 14.4, 14.4, 14.4, 14.3, 14.3, 14.3, 14.2, 14.2, 14.2, 14.2, 14.2, 14.1, 14.1, 14.1, 14.1, 14.1, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 13.9, 13.9, 13.9];
        var BFABoys1_50_2T5 = [16.0, 16.0, 15.9, 15.9, 15.9, 15.8, 15.8, 15.8, 15.7, 15.7, 15.7, 15.6, 15.6, 15.6, 15.5, 15.5, 15.5, 15.5, 15.4, 15.4, 15.4, 15.4, 15.4, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.2, 15.2, 15.2, 15.2, 15.2, 15.2];
        var BFABoys1_85_2T5 = [17.4, 17.4, 17.3, 17.3, 17.2, 17.2, 17.2, 17.1, 17.1, 17.0, 17.0, 17.0, 17.0, 16.9, 16.9, 16.9, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7];
        var BFABoys1_97_2T5 = [18.7, 18.6, 18.6, 18.5, 18.5, 18.4, 18.4, 18.4, 18.3, 18.3, 18.2, 18.2, 18.2, 18.1, 18.1, 18.1, 18.1, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 18.1, 18.1];
        var BFAGirls1_3_0T2 = [11.2, 12.1, 13.2, 13.7, 14.0, 14.2, 14.3, 14.3, 14.3, 14.2, 14.1, 14.0, 13.9, 13.8, 13.7, 13.7, 13.6, 13.5, 13.4, 13.4, 13.3, 13.3, 13.3, 13.2, 13.2];
        var BFAGirls1_15_0T2 = [12.1, 13.2, 14.3, 14.9, 15.2, 15.3, 15.4, 15.4, 15.4, 15.3, 15.2, 15.1, 15.0, 14.8, 14.7, 14.6, 14.6, 14.5, 14.4, 14.3, 14.3, 14.2, 14.2, 14.2, 14.1];
        var BFAGirls1_50_0T2 = [13.3, 14.6, 15.8, 16.4, 16.7, 16.8, 16.9, 16.9, 16.8, 16.7, 16.6, 16.5, 16.4, 16.2, 16.1, 16.0, 15.9, 15.8, 15.7, 15.7, 15.6, 15.5, 15.5, 15.4, 15.4];
        var BFAGirls1_85_0T2 = [14.7, 16.1, 17.4, 18.0, 18.3, 18.5, 18.6, 18.6, 18.5, 18.4, 18.2, 18.1, 17.9, 17.8, 17.7, 17.5, 17.4, 17.3, 17.2, 17.2, 17.1, 17.0, 17.0, 16.9, 16.9];
        var BFAGirls1_97_0T2 = [15.9, 17.3, 18.8, 19.4, 19.8, 20.0, 20.1, 20.1, 20.0, 19.9, 19.7, 19.6, 19.4, 19.2, 19.1, 19.0, 18.8, 18.7, 18.6, 18.5, 18.5, 18.4, 18.3, 18.3, 18.2];
        var BFAGirls1_3_2T5 = [13.5, 13.4, 13.4, 13.4, 13.4, 13.4, 13.3, 13.3, 13.3, 13.3, 13.2, 13.2, 13.2, 13.2, 13.2, 13.1, 13.1, 13.1, 13.1, 13.0, 13.0, 13.0, 13.0, 13.0, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 12.8, 12.8, 12.8, 12.8, 12.8];
        var BFAGirls1_15_2T5 = [14.4, 14.4, 14.4, 14.3, 14.3, 14.3, 14.3, 14.2, 14.2, 14.2, 14.2, 14.1, 14.1, 14.1, 14.1, 14.1, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.8, 13.8, 13.8, 13.8, 13.8];
        var BFAGirls1_50_2T5 = [15.7, 15.7, 15.6, 15.6, 15.6, 15.6, 15.5, 15.5, 15.5, 15.5, 15.4, 15.4, 15.4, 15.4, 15.4, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.2, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3];
        var BFAGirls1_85_2T5 = [17.2, 17.1, 17.1, 17.1, 17.0, 17.0, 17.0, 17.0, 16.9, 16.9, 16.9, 16.9, 16.9, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 17.0];
        var BFAGirls1_97_2T5 = [18.5, 18.5, 18.5, 18.4, 18.4, 18.4, 18.3, 18.3, 18.3, 18.3, 18.2, 18.2, 18.2, 18.2, 18.2, 18.2, 18.2, 18.2, 18.2, 18.2, 18.2, 18.3, 18.3, 18.3, 18.3, 18.3, 18.3, 18.4, 18.4, 18.4, 18.4, 18.4, 18.5, 18.5, 18.5, 18.5, 18.6];
        var BFABoys2_3 = [13.1, 13.1, 13.1, 13.1, 13.1, 13.1, 13.1, 13.1, 13.1, 13.1, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.2, 13.3, 13.3, 13.3, 13.3, 13.3, 13.3, 13.3, 13.3, 13.4, 13.4, 13.4, 13.4, 13.4, 13.4, 13.4, 13.5, 13.5, 13.5, 13.5, 13.5, 13.5, 13.5, 13.6, 13.6, 13.6, 13.6, 13.6, 13.7, 13.7, 13.7, 13.7, 13.7, 13.8, 13.8, 13.8, 13.8, 13.8, 13.9, 13.9, 13.9, 13.9, 14.0, 14.0, 14.0, 14.0, 14.1, 14.1, 14.1, 14.2, 14.2, 14.2, 14.3, 14.3, 14.3, 14.4, 14.4, 14.4, 14.5, 14.5, 14.5, 14.6, 14.6, 14.6, 14.7, 14.7, 14.8, 14.8, 14.8, 14.9, 14.9, 15.0, 15.0, 15.0, 15.1, 15.1, 15.2, 15.2, 15.3, 15.3, 15.4, 15.4, 15.5, 15.5, 15.5, 15.6, 15.6, 15.7, 15.7, 15.8, 15.8, 15.9, 15.9, 16.0, 16.0, 16.1, 16.1, 16.1, 16.2, 16.2, 16.3, 16.3, 16.4, 16.4, 16.4, 16.5, 16.5, 16.6, 16.6, 16.7, 16.7, 16.7, 16.8, 16.8, 16.8, 16.9, 16.9, 17.0, 17.0, 17.0, 17.1, 17.1, 17.1, 17.2, 17.2, 17.2, 17.3, 17.3, 17.3, 17.4, 17.4, 17.4, 17.4, 17.5, 17.5];
        var BFABoys2_15 = [14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.1, 14.1, 14.1, 14.1, 14.1, 14.1, 14.1, 14.1, 14.1, 14.2, 14.2, 14.2, 14.2, 14.2, 14.2, 14.2, 14.3, 14.3, 14.3, 14.3, 14.3, 14.3, 14.4, 14.4, 14.4, 14.4, 14.4, 14.4, 14.5, 14.5, 14.5, 14.5, 14.5, 14.6, 14.6, 14.6, 14.6, 14.6, 14.7, 14.7, 14.7, 14.7, 14.8, 14.8, 14.8, 14.8, 14.9, 14.9, 14.9, 15.0, 15.0, 15.0, 15.1, 15.1, 15.1, 15.2, 15.2, 15.2, 15.3, 15.3, 15.3, 15.4, 15.4, 15.4, 15.5, 15.5, 15.6, 15.6, 15.6, 15.7, 15.7, 15.8, 15.8, 15.9, 15.9, 16.0, 16.0, 16.1, 16.1, 16.2, 16.2, 16.3, 16.3, 16.4, 16.4, 16.5, 16.5, 16.6, 16.6, 16.7, 16.7, 16.8, 16.8, 16.9, 16.9, 17.0, 17.0, 17.1, 17.2, 17.2, 17.3, 17.3, 17.4, 17.4, 17.5, 17.5, 17.6, 17.6, 17.7, 17.7, 17.8, 17.8, 17.9, 17.9, 18.0, 18.0, 18.1, 18.1, 18.2, 18.2, 18.3, 18.3, 18.4, 18.4, 18.5, 18.5, 18.5, 18.6, 18.6, 18.7, 18.7, 18.7, 18.8, 18.8, 18.9, 18.9, 18.9, 19.0, 19.0, 19.1, 19.1, 19.1, 19.2];
        var BFABoys2_50 = [15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.4, 15.4, 15.4, 15.4, 15.4, 15.4, 15.4, 15.5, 15.5, 15.5, 15.5, 15.5, 15.6, 15.6, 15.6, 15.6, 15.6, 15.7, 15.7, 15.7, 15.7, 15.8, 15.8, 15.8, 15.8, 15.9, 15.9, 15.9, 15.9, 16.0, 16.0, 16.0, 16.0, 16.1, 16.1, 16.1, 16.2, 16.2, 16.2, 16.3, 16.3, 16.3, 16.4, 16.4, 16.4, 16.5, 16.5, 16.6, 16.6, 16.6, 16.7, 16.7, 16.8, 16.8, 16.9, 16.9, 16.9, 17.0, 17.0, 17.1, 17.1, 17.2, 17.2, 17.3, 17.3, 17.4, 17.4, 17.5, 17.5, 17.6, 17.6, 17.7, 17.8, 17.8, 17.9, 17.9, 18.0, 18.0, 18.1, 18.2, 18.2, 18.3, 18.4, 18.4, 18.5, 18.6, 18.6, 18.7, 18.7, 18.8, 18.9, 18.9, 19.0, 19.1, 19.1, 19.2, 19.3, 19.3, 19.4, 19.5, 19.5, 19.6, 19.6, 19.7, 19.8, 19.8, 19.9, 20.0, 20.0, 20.1, 20.1, 20.2, 20.3, 20.3, 20.4, 20.4, 20.5, 20.6, 20.6, 20.7, 20.7, 20.8, 20.8, 20.9, 20.9, 21.0, 21.0, 21.1, 21.1, 21.2, 21.2, 21.3, 21.3, 21.4, 21.4, 21.5, 21.5, 21.6, 21.6, 21.7, 21.7];
        var BFABoys2_85 = [16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.7, 16.8, 16.8, 16.8, 16.8, 16.8, 16.8, 16.9, 16.9, 16.9, 16.9, 16.9, 17.0, 17.0, 17.0, 17.1, 17.1, 17.1, 17.1, 17.2, 17.2, 17.2, 17.3, 17.3, 17.3, 17.4, 17.4, 17.4, 17.5, 17.5, 17.5, 17.6, 17.6, 17.7, 17.7, 17.7, 17.8, 17.8, 17.9, 17.9, 17.9, 18.0, 18.0, 18.1, 18.1, 18.2, 18.2, 18.3, 18.3, 18.4, 18.4, 18.5, 18.5, 18.6, 18.6, 18.7, 18.7, 18.8, 18.8, 18.9, 19.0, 19.0, 19.1, 19.1, 19.2, 19.3, 19.3, 19.4, 19.4, 19.5, 19.6, 19.6, 19.7, 19.8, 19.8, 19.9, 20.0, 20.1, 20.1, 20.2, 20.3, 20.3, 20.4, 20.5, 20.6, 20.6, 20.7, 20.8, 20.9, 20.9, 21.0, 21.1, 21.2, 21.3, 21.3, 21.4, 21.5, 21.6, 21.7, 21.7, 21.8, 21.9, 22.0, 22.0, 22.1, 22.2, 22.3, 22.4, 22.4, 22.5, 22.6, 22.7, 22.7, 22.8, 22.9, 23.0, 23.0, 23.1, 23.2, 23.2, 23.3, 23.4, 23.5, 23.5, 23.6, 23.7, 23.7, 23.8, 23.9, 23.9, 24.0, 24.0, 24.1, 24.2, 24.2, 24.3, 24.3, 24.4, 24.5, 24.5, 24.6, 24.6, 24.7, 24.7, 24.8, 24.8, 24.9, 24.9, 25.0, 25.0];
        var BFABoys2_97 = [18.1, 18.1, 18.1, 18.1, 18.1, 18.1, 18.2, 18.2, 18.2, 18.2, 18.3, 18.3, 18.3, 18.4, 18.4, 18.4, 18.5, 18.5, 18.5, 18.6, 18.6, 18.7, 18.7, 18.8, 18.8, 18.8, 18.9, 18.9, 19.0, 19.0, 19.1, 19.2, 19.2, 19.3, 19.3, 19.4, 19.4, 19.5, 19.5, 19.6, 19.7, 19.7, 19.8, 19.9, 19.9, 20.0, 20.0, 20.1, 20.2, 20.2, 20.3, 20.4, 20.5, 20.5, 20.6, 20.7, 20.8, 20.8, 20.9, 21.0, 21.1, 21.1, 21.2, 21.3, 21.4, 21.5, 21.6, 21.6, 21.7, 21.8, 21.9, 22.0, 22.1, 22.2, 22.2, 22.3, 22.4, 22.5, 22.6, 22.7, 22.8, 22.9, 23.0, 23.1, 23.1, 23.2, 23.3, 23.4, 23.5, 23.6, 23.7, 23.8, 23.9, 24.0, 24.1, 24.2, 24.3, 24.4, 24.5, 24.6, 24.7, 24.8, 24.9, 24.9, 25.0, 25.1, 25.2, 25.3, 25.4, 25.5, 25.6, 25.7, 25.8, 25.8, 25.9, 26.0, 26.1, 26.2, 26.3, 26.4, 26.4, 26.5, 26.6, 26.7, 26.7, 26.8, 26.9, 27.0, 27.0, 27.1, 27.2, 27.3, 27.3, 27.4, 27.5, 27.5, 27.6, 27.7, 27.7, 27.8, 27.8, 27.9, 28.0, 28.0, 28.1, 28.1, 28.2, 28.2, 28.3, 28.4, 28.4, 28.5, 28.5, 28.6, 28.6, 28.6];
        var BFAGirls2_3 = [12.9, 12.9, 12.9, 12.9, 12.9, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.8, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 12.9, 13.0, 13.0, 13.0, 13.0, 13.0, 13.0, 13.1, 13.1, 13.1, 13.1, 13.1, 13.2, 13.2, 13.2, 13.2, 13.3, 13.3, 13.3, 13.3, 13.4, 13.4, 13.4, 13.4, 13.5, 13.5, 13.5, 13.6, 13.6, 13.6, 13.6, 13.7, 13.7, 13.7, 13.8, 13.8, 13.9, 13.9, 13.9, 14.0, 14.0, 14.0, 14.1, 14.1, 14.2, 14.2, 14.2, 14.3, 14.3, 14.4, 14.4, 14.5, 14.5, 14.6, 14.6, 14.7, 14.7, 14.7, 14.8, 14.8, 14.9, 14.9, 15.0, 15.0, 15.1, 15.1, 15.2, 15.2, 15.3, 15.3, 15.3, 15.4, 15.4, 15.5, 15.5, 15.6, 15.6, 15.6, 15.7, 15.7, 15.8, 15.8, 15.8, 15.9, 15.9, 15.9, 16.0, 16.0, 16.0, 16.1, 16.1, 16.1, 16.2, 16.2, 16.2, 16.2, 16.3, 16.3, 16.3, 16.3, 16.4, 16.4, 16.4, 16.4, 16.4, 16.5, 16.5, 16.5, 16.5, 16.5, 16.5, 16.6, 16.6, 16.6, 16.6, 16.6, 16.6, 16.6, 16.6, 16.6, 16.6, 16.7, 16.7, 16.7, 16.7, 16.7];
        var BFAGirls2_15 = [13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.8, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 13.9, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.1, 14.1, 14.1, 14.1, 14.2, 14.2, 14.2, 14.2, 14.3, 14.3, 14.3, 14.4, 14.4, 14.4, 14.4, 14.5, 14.5, 14.5, 14.6, 14.6, 14.6, 14.7, 14.7, 14.7, 14.8, 14.8, 14.9, 14.9, 14.9, 15.0, 15.0, 15.1, 15.1, 15.1, 15.2, 15.2, 15.3, 15.3, 15.4, 15.4, 15.5, 15.5, 15.6, 15.6, 15.7, 15.7, 15.8, 15.8, 15.9, 15.9, 16.0, 16.1, 16.1, 16.2, 16.2, 16.3, 16.3, 16.4, 16.4, 16.5, 16.5, 16.6, 16.7, 16.7, 16.8, 16.8, 16.9, 16.9, 17.0, 17.0, 17.1, 17.1, 17.2, 17.2, 17.3, 17.3, 17.4, 17.4, 17.4, 17.5, 17.5, 17.6, 17.6, 17.6, 17.7, 17.7, 17.8, 17.8, 17.8, 17.9, 17.9, 17.9, 18.0, 18.0, 18.0, 18.0, 18.1, 18.1, 18.1, 18.1, 18.2, 18.2, 18.2, 18.2, 18.3, 18.3, 18.3, 18.3, 18.3, 18.3, 18.4, 18.4, 18.4, 18.4, 18.4, 18.4, 18.4, 18.5, 18.5, 18.5, 18.5];
        var BFAGirls2_50 = [15.2, 15.2, 15.2, 15.2, 15.2, 15.2, 15.2, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, 15.4, 15.4, 15.4, 15.4, 15.4, 15.4, 15.5, 15.5, 15.5, 15.5, 15.5, 15.6, 15.6, 15.6, 15.7, 15.7, 15.7, 15.7, 15.8, 15.8, 15.8, 15.9, 15.9, 15.9, 16.0, 16.0, 16.1, 16.1, 16.1, 16.2, 16.2, 16.3, 16.3, 16.3, 16.4, 16.4, 16.5, 16.5, 16.6, 16.6, 16.7, 16.7, 16.8, 16.8, 16.9, 16.9, 17.0, 17.0, 17.1, 17.1, 17.2, 17.2, 17.3, 17.4, 17.4, 17.5, 17.5, 17.6, 17.7, 17.7, 17.8, 17.9, 17.9, 18.0, 18.1, 18.1, 18.2, 18.3, 18.3, 18.4, 18.5, 18.5, 18.6, 18.7, 18.7, 18.8, 18.9, 18.9, 19.0, 19.1, 19.1, 19.2, 19.3, 19.3, 19.4, 19.4, 19.5, 19.6, 19.6, 19.7, 19.7, 19.8, 19.9, 19.9, 20.0, 20.0, 20.1, 20.1, 20.2, 20.2, 20.3, 20.3, 20.4, 20.4, 20.4, 20.5, 20.5, 20.6, 20.6, 20.6, 20.7, 20.7, 20.7, 20.8, 20.8, 20.8, 20.9, 20.9, 20.9, 20.9, 21.0, 21.0, 21.0, 21.0, 21.1, 21.1, 21.1, 21.1, 21.1, 21.2, 21.2, 21.2, 21.2, 21.2, 21.2, 21.3];
        var BFAGirls2_85 = [16.9, 16.9, 17.0, 17.0, 17.0, 17.0, 17.0, 17.0, 17.0, 17.0, 17.1, 17.1, 17.1, 17.1, 17.1, 17.2, 17.2, 17.2, 17.2, 17.3, 17.3, 17.3, 17.3, 17.4, 17.4, 17.4, 17.5, 17.5, 17.5, 17.6, 17.6, 17.6, 17.7, 17.7, 17.8, 17.8, 17.9, 17.9, 18.0, 18.0, 18.1, 18.1, 18.2, 18.2, 18.3, 18.3, 18.4, 18.4, 18.5, 18.5, 18.6, 18.7, 18.7, 18.8, 18.8, 18.9, 18.9, 19.0, 19.1, 19.1, 19.2, 19.3, 19.3, 19.4, 19.5, 19.5, 19.6, 19.7, 19.8, 19.8, 19.9, 20.0, 20.0, 20.1, 20.2, 20.3, 20.4, 20.4, 20.5, 20.6, 20.7, 20.8, 20.8, 20.9, 21.0, 21.1, 21.2, 21.3, 21.3, 21.4, 21.5, 21.6, 21.7, 21.8, 21.8, 21.9, 22.0, 22.1, 22.2, 22.3, 22.3, 22.4, 22.5, 22.6, 22.6, 22.7, 22.8, 22.9, 22.9, 23.0, 23.1, 23.2, 23.2, 23.3, 23.4, 23.4, 23.5, 23.5, 23.6, 23.7, 23.7, 23.8, 23.8, 23.9, 23.9, 24.0, 24.0, 24.1, 24.1, 24.2, 24.2, 24.2, 24.3, 24.3, 24.4, 24.4, 24.4, 24.5, 24.5, 24.5, 24.6, 24.6, 24.6, 24.7, 24.7, 24.7, 24.7, 24.8, 24.8, 24.8, 24.8, 24.8, 24.9, 24.9, 24.9, 24.9];
        var BFAGirls2_97 = [18.6, 18.6, 18.7, 18.7, 18.7, 18.7, 18.8, 18.8, 18.8, 18.9, 18.9, 18.9, 19.0, 19.0, 19.0, 19.1, 19.1, 19.2, 19.2, 19.3, 19.3, 19.3, 19.4, 19.4, 19.5, 19.6, 19.6, 19.7, 19.7, 19.8, 19.8, 19.9, 20.0, 20.0, 20.1, 20.2, 20.2, 20.3, 20.4, 20.4, 20.5, 20.6, 20.7, 20.7, 20.8, 20.9, 21.0, 21.1, 21.1, 21.2, 21.3, 21.4, 21.5, 21.6, 21.6, 21.7, 21.8, 21.9, 22.0, 22.1, 22.2, 22.2, 22.3, 22.4, 22.5, 22.6, 22.7, 22.8, 22.9, 23.0, 23.1, 23.2, 23.3, 23.4, 23.5, 23.6, 23.7, 23.8, 23.9, 24.0, 24.1, 24.2, 24.3, 24.4, 24.5, 24.6, 24.7, 24.8, 24.9, 25.0, 25.1, 25.2, 25.3, 25.4, 25.5, 25.6, 25.7, 25.8, 25.9, 26.0, 26.1, 26.1, 26.2, 26.3, 26.4, 26.5, 26.6, 26.7, 26.8, 26.8, 26.9, 27.0, 27.1, 27.1, 27.2, 27.3, 27.4, 27.4, 27.5, 27.6, 27.6, 27.7, 27.7, 27.8, 27.9, 27.9, 28.0, 28.0, 28.1, 28.1, 28.2, 28.2, 28.2, 28.3, 28.3, 28.4, 28.4, 28.4, 28.5, 28.5, 28.5, 28.6, 28.6, 28.6, 28.6, 28.7, 28.7, 28.7, 28.7, 28.8, 28.8, 28.8, 28.8, 28.8, 28.9, 28.9];
        var CFABoys1_3 = [32.1, 35.1, 36.9, 38.3, 39.4, 40.3, 41.0, 41.7, 42.2, 42.6, 43.0, 43.4, 43.6, 43.9, 44.1, 44.3, 44.5, 44.7, 44.9, 45.0, 45.2, 45.3, 45.4, 45.6, 45.7, 45.8, 45.9, 46.0, 46.1, 46.2, 46.3, 46.4, 46.5, 46.6, 46.6, 46.7, 46.8, 46.9, 46.9, 47.0, 47.0, 47.1, 47.2, 47.2, 47.3, 47.3, 47.4, 47.4, 47.5, 47.5, 47.5, 47.6, 47.6, 47.7, 47.7, 47.7, 47.8, 47.8, 47.9, 47.9, 47.9];//head circumference for age  boys 0 to 5 years 3rd percentile
        var CFABoys1_15 = [33.1, 36.1, 37.9, 39.3, 40.4, 41.3, 42.1, 42.7, 43.2, 43.7, 44.1, 44.4, 44.7, 45.0, 45.2, 45.5, 45.6, 45.8, 46.0, 46.2, 46.3, 46.4, 46.6, 46.7, 46.8, 47.0, 47.1, 47.2, 47.3, 47.4, 47.5, 47.6, 47.7, 47.8, 47.8, 47.9, 48.0, 48.1, 48.1, 48.2, 48.3, 48.3, 48.4, 48.4, 48.5, 48.5, 48.6, 48.6, 48.7, 48.7, 48.8, 48.8, 48.9, 48.9, 49.0, 49.0, 49.0, 49.1, 49.1, 49.2, 49.2];//head circumference for age  boys 0 to 5 years 15th percentile
        var CFABoys1_50 = [34.5, 37.3, 39.1, 40.5, 41.6, 42.6, 43.3, 44.0, 44.5, 45.0, 45.4, 45.8, 46.1, 46.3, 46.6, 46.8, 47.0, 47.2, 47.4, 47.5, 47.7, 47.8, 48.0, 48.1, 48.3, 48.4, 48.5, 48.6, 48.7, 48.8, 48.9, 49.0, 49.1, 49.2, 49.3, 49.4, 49.5, 49.5, 49.6, 49.7, 49.7, 49.8, 49.9, 49.9, 50.0, 50.1, 50.1, 50.2, 50.2, 50.3, 50.3, 50.4, 50.4, 50.4, 50.5, 50.5, 50.6, 50.6, 50.7, 50.7, 50.7];//head circumference for age  boys 0 to 5 years 50th percentile
        var CFABoys1_85 = [35.8, 38.5, 40.3, 41.7, 42.9, 43.8, 44.6, 45.3, 45.8, 46.3, 46.7, 47.1, 47.4, 47.7, 47.9, 48.2, 48.4, 48.6, 48.7, 48.9, 49.1, 49.2, 49.4, 49.5, 49.7, 49.8, 49.9, 50.0, 50.2, 50.3, 50.4, 50.5, 50.6, 50.7, 50.8, 50.8, 50.9, 51.0, 51.1, 51.2, 51.2, 51.3, 51.4, 51.4, 51.5, 51.6, 51.6, 51.7, 51.7, 51.8, 51.8, 51.9, 51.9, 52.0, 52.0, 52.1, 52.1, 52.2, 52.2, 52.2, 52.3];//head circumference for age  boys 0 to 5 years 85th percentile
        var CFABoys1_97 = [36.9, 39.5, 41.3, 42.7, 43.9, 44.8, 45.6, 46.3, 46.9, 47.4, 47.8, 48.2, 48.5, 48.8, 49.0, 49.3, 49.5, 49.7, 49.9, 50.0, 50.2, 50.4, 50.5, 50.7, 50.8, 50.9, 51.1, 51.2, 51.3, 51.4, 51.5, 51.6, 51.7, 51.8, 51.9, 52.0, 52.0, 52.1, 52.2, 52.3, 52.4, 52.4, 52.5, 52.6, 52.7, 52.7, 52.8, 52.8, 52.9, 53.0, 53.0, 53.1, 53.1, 53.2, 53.2, 53.3, 53.3, 53.4, 53.4, 53.5, 53.5, 53.5];//head circumference for age  boys 0 to 5 years 97th percentile
        var CFAGirls1_3 = [31.7, 34.3, 36.0, 37.2, 38.2, 39.0, 39.7, 40.4, 40.9, 41.3, 41.7, 42.0, 42.3, 42.6, 42.9, 43.1, 43.3, 43.5, 43.6, 43.8, 44.0, 44.1, 44.3, 44.4, 44.6, 44.7, 44.8, 44.9, 45.1, 45.2, 45.3, 45.4, 45.5, 45.6, 45.7, 45.8, 45.9, 45.9, 46.0, 46.1, 46.2, 46.2, 46.3, 46.4, 46.4, 46.5, 46.5, 46.6, 46.7, 46.7, 46.8, 46.8, 46.9, 46.9, 47.0, 47.0, 47.1, 47.1, 47.2, 47.2, 47.2]; // head circumference fr age 0 to 5 years girls 3rd percentile
        var CFAGirls1_15 = [32.7, 35.3, 37.0, 38.2, 39.3, 40.1, 40.8, 41.5, 42.0, 42.4, 42.8, 43.2, 43.5, 43.8, 44.0, 44.2, 44.4, 44.6, 44.8, 45.0, 45.1, 45.3, 45.4, 45.6, 45.7, 45.9, 46.0, 46.1, 46.3, 46.4, 46.5, 46.6, 46.7, 46.8, 46.9, 47.0, 47.0, 47.1, 47.2, 47.3, 47.4, 47.4, 47.5, 47.6, 47.6, 47.7, 47.7, 47.8, 47.9, 47.9, 48.0, 48.0, 48.1, 48.1, 48.2, 48.2, 48.3, 48.3, 48.4, 48.4, 48.4]; // head circumference fr age 0 to 5 years girls 15th percentile
        var CFAGirls1_50 = [33.9, 36.5, 38.3, 39.5, 40.6, 41.5, 42.2, 42.8, 43.4, 43.8, 44.2, 44.6, 44.9, 45.2, 45.4, 45.7, 45.9, 46.1, 46.2, 46.4, 46.6, 46.7, 46.9, 47.0, 47.2, 47.3, 47.5, 47.6, 47.7, 47.8, 47.9, 48.0, 48.1, 48.2, 48.3, 48.4, 48.5, 48.6, 48.7, 48.7, 48.8, 48.9, 49.0, 49.0, 49.1, 49.2, 49.2, 49.3, 49.3, 49.4, 49.4, 49.5, 49.5, 49.6, 49.6, 49.7, 49.7, 49.8, 49.8, 49.9, 49.9]; // head circumference fr age 0 to 5 years girls 50th percentile
        var CFAGirls1_85 = [35.1, 37.8, 39.5, 40.8, 41.9, 42.8, 43.5, 44.2, 44.7, 45.2, 45.6, 46.0, 46.3, 46.6, 46.8, 47.1, 47.3, 47.5, 47.7, 47.8, 48.0, 48.2, 48.3, 48.5, 48.6, 48.8, 48.9, 49.0, 49.2, 49.3, 49.4, 49.5, 49.6, 49.7, 49.8, 49.9, 50.0, 50.1, 50.1, 50.2, 50.3, 50.4, 50.4, 50.5, 50.6, 50.6, 50.7, 50.7, 50.8, 50.9, 50.9, 51.0, 51.0, 51.1, 51.1, 51.2, 51.2, 51.3, 51.3, 51.4, 51.4]; // head circumference fr age 0 to 5 years girls 85th percentile
        var CFAGirls1_97 = [36.1, 38.8, 40.5, 41.9, 43.0, 43.9, 44.6, 45.3, 45.9, 46.3, 46.8, 47.1, 47.5, 47.7, 48.0, 48.2, 48.5, 48.7, 48.8, 49.0, 49.2, 49.4, 49.5, 49.7, 49.8, 49.9, 50.1, 50.2, 50.3, 50.5, 50.6, 50.7, 50.8, 50.9, 51.0, 51.1, 51.2, 51.3, 51.3, 51.4, 51.5, 51.6, 51.6, 51.7, 51.8, 51.8, 51.9, 51.9, 52.0, 52.1, 52.1, 52.2, 52.2, 52.3, 52.3, 52.4, 52.4, 52.5, 52.5, 52.6, 52.6]; // head circumference fr age 0 to 5 years girls 97th percentile
        if (gender == "M") {
            if (ageCondition == "VitalHistoryfirstBtn" && parameter == "Weight") {
                ArrayOfArray = [WFABoys1_3, WFABoys1_15, WFABoys1_50, WFABoys1_85, WFABoys1_97];
            }
            else if (ageCondition == "VitalHistorysecondBtn" && parameter == "Weight") {
                ArrayOfArray = [WFABoys2_3, WFABoys2_15, WFABoys2_50, WFABoys2_85, WFABoys2_97];
            }
            else if (ageCondition == "VitalHistoryfirstBtn" && parameter == "Height") {
                ArrayOfArray = [HFABoys1_3, HFABoys1_15, HFABoys1_50, HFABoys1_85, HFABoys1_97];
            }
            else if (ageCondition == "VitalHistorysecondBtn" && parameter == "Height") {
                ArrayOfArray = [HFABoys2_3, HFABoys2_15, HFABoys2_50, HFABoys2_85, HFABoys2_97];
            }
            else if (ageCondition == "VitalHistoryfirstBtn" && parameter == "BMI") {
                ArrayOfArray = [BFABoys1_3_0T2, BFABoys1_15_0T2, BFABoys1_50_0T2, BFABoys1_85_0T2, BFABoys1_97_0T2];
            }
            else if (ageCondition == "VitalHistorysecondBtn" && parameter == "BMI") {
                ArrayOfArray = [BFABoys2_3, BFABoys2_15, BFABoys2_50, BFABoys2_85, BFABoys2_97];
            }
            else if (ageCondition == "VitalHistoryfirstBtn" && parameter.indexOf("Head") != -1) {
                ArrayOfArray = [CFABoys1_3, CFABoys1_15, CFABoys1_50, CFABoys1_85, CFABoys1_97];
            }
            backColor = "#add8e6a6";
        }
        else {
            if (ageCondition == "VitalHistoryfirstBtn" && parameter == "Weight") {
                ArrayOfArray = [WFAGirls1_3, WFAGirls1_15, WFAGirls1_50, WFAGirls1_85, WFAGirls1_97];
            }
            else if (ageCondition == "VitalHistorysecondBtn" && parameter == "Weight") {
                ArrayOfArray = [WFAGirls2_3, WFAGirls2_15, WFAGirls2_50, WFAGirls2_85, WFAGirls2_97];
            }
            else if (ageCondition == "VitalHistoryfirstBtn" && parameter == "Height") {
                ArrayOfArray = [HFAGirls1_3, HFAGirls1_15, HFAGirls1_50, HFAGirls1_85, HFAGirls1_97];
            }
            else if (ageCondition == "VitalHistorysecondBtn" && parameter == "Height") {
                ArrayOfArray = [HFAGirls2_3, HFAGirls2_15, HFAGirls2_50, HFAGirls2_85, HFAGirls2_97];
            }
            else if (ageCondition == "VitalHistoryfirstBtn" && parameter == "BMI") {
                ArrayOfArray = [BFAGirls1_3_0T2, BFAGirls1_15_0T2, BFAGirls1_50_0T2, BFAGirls1_85_0T2, BFAGirls1_97_0T2];
            }
            else if (ageCondition == "VitalHistorysecondBtn" && parameter == "BMI") {
                ArrayOfArray = [BFAGirls2_3, BFAGirls2_15, BFAGirls2_50, BFAGirls2_85, BFAGirls2_97];
            }
            else if (ageCondition == "VitalHistoryfirstBtn" && parameter.indexOf("Head") != -1) {
                ArrayOfArray = [CFAGirls1_3, CFAGirls1_15, CFAGirls1_50, CFAGirls1_85, CFAGirls1_97];
            }
            backColor = "#ffc0cb8a";
        }
        var colorsArray = ["orange", "red", "green", "orange", "red"];
        var genderString = (gender == "M") ? "Boys " : "Girls";
        if (ageCondition == "VitalHistoryfirstBtn" && parameter == "Weight") {
            yInterval = 2;
            xMin = 0;
            xMax = 60;
            yMin = 0;
            yMax = gender == "M" ? 26 : 28;
            toolTipContenStr = "Age: {x} months<br/>Weight: {y} kg";
            yAxisTitle = "Weight(kg)";
            $("#VitalHistorychartMainDiv p")[0].innerText = "Weight for Age(0-5 Years) " + genderString;
        }
        if (ageCondition == "VitalHistorysecondBtn" && parameter == "Weight") {
            yInterval = 5;
            xMin = 61;
            xMax = 120;
            yMin = 0;
            yMax = gender == "M" ? 50 : 55;
            toolTipContenStr = "Age: {x} months<br/>Weight: {y} kg";
            yAxisTitle = "Weight(kg)";
            $("#VitalHistorychartMainDiv p")[0].innerText = "Weight for Age(5-10 Years) " + genderString;
        }
        if (ageCondition == "VitalHistoryfirstBtn" && parameter == "Height") {
            yInterval = 5;
            xMin = 0;
            xMax = 60;
            yMin = 45;
            yMax = gender == "M" ? 130 : 135;
            toolTipContenStr = "Age: {x} months<br/>Height: {y} cm";
            yAxisTitle = "Height(cm)";
            $("#VitalHistorychartMainDiv p")[0].innerText = "Height for Age(0-5 Years) " + genderString;
        }
        if (ageCondition == "VitalHistorysecondBtn" && parameter == "Height") {
            yInterval = 10;
            xMin = 60;
            xMax = 216;
            yMin = gender == "M" ? 100 : 95;
            yMax = gender == "M" ? 210 : 190;
            toolTipContenStr = "Age: {x} months<br/>Height: {y} cm";
            yAxisTitle = "Height(cm)";
            $("#VitalHistorychartMainDiv p")[0].innerText = "Height for Age(5-18 Years) " + genderString;
        }
        if (ageCondition == "VitalHistoryfirstBtn" && parameter == "BMI") {
            yInterval = 1;
            xMin = 0;
            xMax = 60;
            yMin = 10;
            yMax = gender == "M" ? 22 : 23;
            toolTipContenStr = "Age: {x} months<br/>BMI: {y} kg/m²";
            yAxisTitle = "BMI(kg/m²)";
            $("#VitalHistorychartMainDiv p")[0].innerText = "BMI for Age(0-5 Years) " + genderString;
        }
        if (ageCondition == "VitalHistorysecondBtn" && parameter == "BMI") {
            yInterval = 2;
            xMin = 60;
            xMax = 216;
            yMin = 12;
            yMax = 32;
            toolTipContenStr = "Age: {x} months<br/>BMI: {y} kg/m²";
            yAxisTitle = "BMI(kg/m²)";
            $("#VitalHistorychartMainDiv p")[0].innerText = "BMI for Age(5-18 Years) " + genderString;
        }
        if (ageCondition == "VitalHistoryfirstBtn" && parameter.indexOf("Head") != -1) {
            yInterval = 2;
            xMin = 0;
            xMax = 60;
            yMin = 32;
            yMax = gender == "M" ? 58 : 56;
            toolTipContenStr = "Age: {x} months<br/>Head Circumference: {y} cm";
            yAxisTitle = "Head Circumference(cm)";
            $("#VitalHistorychartMainDiv p")[0].innerText = "Head Circumference for Age(0-5 Years) " + genderString;
        }
        if (unitCondition == "M") {
            xInterval = 1;
        }
        else if (unitCondition == "Q") {
            xInterval = 3;
        }
        else if (unitCondition == "H") {
            xInterval = 6;
        }
        else if (unitCondition == "Y") {
            xInterval = 12;
        }
        axisXTitleArray.push({
            gridThickness: 1,
            gridColor: "#cacaca",
            lineColor: "#cacaca",
            tickColor: "#cacaca",
            interval: xInterval,
            title: xAxisTitle,
            minimum: xMin,
            maximum: xMax,
        });
        for (var i = 0; i < ArrayOfArray.length; i++) {
            var arryPoints = [];
            $.each(ArrayOfArray[i], function (j, val) {
                if (j == ArrayOfArray[i].length - 2) {
                    indexLabel = arrPercentiles[i];
                }
                else
                    indexLabel = "";
                var xy = {
                    x: xArray[j],
                    y: val,
                    indexLabel: indexLabel,
                    indexLabelPlacement: "auto",
                    indexLabelFontSize: 12,
                    indexLabelOrientation: "horizontal",
                }
                arryPoints.push(xy);
            });
            var dataObject = {
                type: "spline",
                lineColor: colorsArray[i],
                markerSize: 0,
                axisYType: "secondary",
                color: "#0c6a80",
                dataPoints: arryPoints,
                toolTipContent: null,
            }
            dataArray.push(dataObject);
        }
        if (ageCondition == "VitalHistoryfirstBtn" && parameter == "BMI") {
            var arryPoints = [];
            xArray = [];
            for (var k = 24; k <= 60; k++) {
                xArray.push(k);
            }
            if (gender == "M")
                ArrayOfArray = [BFABoys1_3_2T5, BFABoys1_15_2T5, BFABoys1_50_2T5, BFABoys1_85_2T5, BFABoys1_97_2T5];
            else
                ArrayOfArray = [BFAGirls1_3_2T5, BFAGirls1_15_2T5, BFAGirls1_50_2T5, BFAGirls1_85_2T5, BFAGirls1_97_2T5];
            for (var i = 0; i < ArrayOfArray.length; i++) {
                var arryPoints = [];
                $.each(ArrayOfArray[i], function (j, val) {
                    if (j == ArrayOfArray[i].length - 1) {
                        indexLabel = "";
                    }
                    else
                        indexLabel = "";
                    var xy = {
                        x: xArray[j],
                        y: val,
                        indexLabel: indexLabel,
                        indexLabelPlacement: "outside",
                        indexLabelFontSize: 14,
                        indexLabelOrientation: "horizontal",
                        labelAlign: "right"
                    }
                    arryPoints.push(xy);
                });
                var dataObject = {
                    type: "spline",
                    lineColor: colorsArray[i],
                    markerSize: 0,
                    axisYType: "secondary",
                    color: "#0c6a80",
                    dataPoints: arryPoints,
                    toolTipContent: null,
                }
                dataArray.push(dataObject);
            }
        }
        var selector = '#VitalHistoryline-chart';
        var rangechart = $(selector).get(0);
        var chart = new CanvasJS.Chart(rangechart, {
            theme: "light1",
            animationEnabled: true,
            backgroundColor: backColor,
            legend: {
                maxWidth: 200,
                maxHeight: 220,
                fontSize: 14,
                fontWeight: "bold",
                verticalAlign: "bottom",
                horizontalAlign: "center"
            },
            toolTip: {
                fontColor: "White",
                backgroundColor: "rgba(0, 0, 0, 0.85)",
                borderColor: "rgba(0, 0, 0, 0.85)",
            },
            axisX: axisXTitleArray,
            axisY: {
                gridThickness: 1,
                gridColor: "#cacaca",
                lineColor: "#cacaca",
                tickColor: "#cacaca",
                includeZero: false,
                title: yAxisTitle,
                titleFontColor: "#4F81BC",
                lineColor: "#4F81BC",
                tickColor: "#4F81BC",
                interval: yInterval,
                minimum: yMin,
                maximum: yMax,

            },
            axisY2: {
                title: yAxisTitle,
                titleFontColor: "#4F81BC",
                lineColor: "#4F81BC",
                tickColor: "#4F81BC",
                interval: yInterval,
                minimum: yMin,
                maximum: yMax,
            },
            data: dataArray,
        });
        if (parameter == "Weight")
            dynamicArryOfDataPnts = VitalsHistoryweightAgeArray;
        else if (parameter == "Height")
            dynamicArryOfDataPnts = VitalsHistoryheightAgeArray;
        else if (parameter == "BMI")
            dynamicArryOfDataPnts = VitalsHistoryBMIAgeArray;
        else if (parameter.indexOf("Head") != -1)
            dynamicArryOfDataPnts = VitalsHistoryHeadCirAgeArray;
        chart.options.data.push({
            type: "scatter",
            legendMarkerColor: "blue",
            lineThickness: 5,
            showInLegend: true,
            legendText: "Baby's Percentile",
            dataPoints: dynamicArryOfDataPnts,
            lineColor: "blue",
            color: "blue",
            toolTipContent: toolTipContenStr
        });
        chart.render();
        var jc = this;
    }

    function VitalHistoryPatientData() {
        var tranNo = sessionStorage.getItem('PatTRANNO');
        var strMRNO = sessionStorage.getItem('PatMRNO');
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GetVitalHistory',
            datatype: "json",
            data: { strMRNO: strMRNO },
            success: function (result) {
                if (result[0] != null) {
                    var ageRange = result[0].filter(function (obj) {
                        return Number(obj.AGE.split(":")[0]) < 19;
                    });
                    if (ageRange.length > 0) {
                        $("#VitalHistorybtnGrowthChart").show();
                    }
                    $("#VitalHistorytblVitalHistory").empty();
                    var flag = 0;
                    $.each(result[0], function (key, value) {
                        if (value.HEADCIR != "" && Number(value.HEADCIR) != 0) {
                            flag = 1;
                            return false;
                        }
                    });
                    LoadVitalHistoryPatientTable(result[0]);
                    VitalHistoryAddGraphs(result[0]);
                }
                else {
                    document.getElementById("VitalHistorytbldiv").innerHTML = "<div class='panel' style='width:77%'><div class='panel-body divBody' style='width:200px;font-size:14px;height:50px;'>No Vital History Found</div></div>";
                }
                if (result[1] != null) {
                    $.each(result[1], function (i, val) {
                        var obj = {
                            x: Number(val["AGE"]),
                            y: Number(val["WEIGHT"])
                        }
                        VitalsHistoryweightAgeArray.push(obj);
                    });
                    $.each(result[1], function (i, val) {
                        var obj = {
                            x: Number(val["AGE"]),
                            y: Number(val["HEIGHT"])
                        }
                        VitalsHistoryheightAgeArray.push(obj);
                    });
                    $.each(result[1], function (i, val) {
                        var obj = {
                            x: Number(val["AGE"]),
                            y: Number(val["BMI"])
                        }
                        VitalsHistoryBMIAgeArray.push(obj);
                    });
                    $.each(result[1], function (i, val) {
                        var obj = {
                            x: Number(val["AGE"]),
                            y: Number(val["HEADCIR"])
                        }
                        VitalsHistoryHeadCirAgeArray.push(obj);
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    function LoadVitalHistoryPatientTable(DataForVitalHistoryPatient) {
        var LoadVitalHistoryGrid = new Tabulator("#VitalHistorytblVitalHistory", {
            data: DataForVitalHistoryPatient || [],   
            height: "400px",         
            layout: "fitColumns",    
            placeholder: "No Vital History Found",
            columns: [
                { title: "", formatter: "rownum", width: 50, hozAlign: "center", headerSort: false },
                { title: "Recorded On", field: "TRANDATE", width: 150, headerFilter: "input", tooltip: true },
                { title: "Age", field: "AGE", width: 100, headerFilter: "input", tooltip: true },
                { title: "Weight (kg)", field: "WEIGHT", width: 120, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "Height (cm)", field: "HEIGHT", width: 120, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "Temp (℉)", field: "TEMP", width: 100, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "Pulse (bpm)", field: "PULSE", width: 120, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "RR (Breaths/Minutes)", field: "RESP", width:  120, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "BP (mmHg)", field: "BP", width: 120, headerFilter: "input", tooltip: true },
                { title: "SpO2 (%)", field: "SPO2", width: 100, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "BMI (kg/m²)", field: "BMI", width: 120, hozAlign: "right", headerFilter: "input", tooltip: true },
                { title: "Head Circumference (cm)", field: "HEADCIR", width: 150, hozAlign: "right", headerFilter: "input", tooltip: true, visible: SummarizeYN=="Y"?false:true },
                { title: "Walking", field: "WALKINGYN", width: 100, headerFilter: "input", tooltip: true, visible: SummarizeYN == "Y" ? false : true },
                { title: "Duration", field: "WALKINGDURATION", width: 150, headerFilter: "input", tooltip: true, visible: SummarizeYN == "Y" ? false : true },
                { title: "Diet", field: "DIETYN", width: 100, headerFilter: "input", tooltip: true, visible: SummarizeYN == "Y" ? false : true },
                { title: "Regular Medicine", field: "REGULARMEDIYN", width: 150, headerFilter: "input", tooltip: true, visible: SummarizeYN == "Y" ? false : true },
                { title: "Created By", field: "CREATEDBY", headerFilter: "input", tooltip: true }//devendra 24/03/2026
            ],
        });

    }

    function VitalHistoryAddGraphs(result) {
        result.reverse();
        $('.content').css('width', '100%');
        var DESC = ["WEIGHT", "HEIGHT", "TEMP", "PULSE", "SPO2", "BP"];
        var datafilter;
        var Color = ["#e6f4ff", "#ebffdc", "#fef1ff", "#ffefe1", "#e7fffd", "#fff9dc"];
        $.each(DESC, function (i, v) {
            var actulD = $(result).map(function (idex, val) {
                if (val["" + v] != "-" && val["" + v] != "" && val["" + v] != "0.00")
                    if (v != "BP")
                        return $.trim(parseFloat(val["" + v + ""]));
                    else
                        return $.trim(val["" + v + ""]);
            }).get().join(',')
            if (actulD != "") {
                if (v != "BP") {
                    $("#VitalHistorygraphsDiv").append('<div class="col-md-6" style="padding:5px !important" id="VitalHistorymy_test_' + (i) + '">'
                        + '<div class="VitalHistorycard"><div class="VitalHistorycard-content  teal darken-2" style="background:' + Color[i] + ';  -webkit-box-shadow: 0 0 5px 2px #d0d0d0;-moz-box-shadow: 0 0 5px 2px #d0d0d0; box-shadow: 0 0 5px 2px #d0d0d0;"><div class="VitalHistoryline-chart-wrapper"><p class="margin" style="font-weight:400;font-size:13px">'
                        + v + '</p><canvas class="VitalHistoryGraphCanvas" id="VitalHistoryline-chart' + (i) + '"></canvas></div></div></div>');
                } else {
                    $("#VitalHistorygraphsDiv").append('<div class="col-md-6" style="padding:5px !important" id="VitalHistorymy_test_' + (i) + '">'
                        + '<div class="VitalHistorycard"><div class="VitalHistorycard-content  teal darken-2" style="background:' + Color[i] + ';  -webkit-box-shadow: 0 0 5px 2px #d0d0d0;-moz-box-shadow: 0 0 5px 2px #d0d0d0; box-shadow: 0 0 5px 2px #d0d0d0;"><div class="VitalHistoryline-chart-wrapper"><p class="margin" style="font-weight:400;font-size:13px">'
                        + v + '</p><div  class="VitalHistoryGraphCanvas" id="VitalHistoryline-chart' + (i) + '"></div></div></div></div>');
                }
                datafilter = v;
                VitalHistorytableTrendsLineData(result, datafilter, i)
            }
            if ($("#VitalHistorygraphsDiv div").length > 0) {
                $("#VitalHistorychartNote").show();
            }
        });
    }

    function VitalHistorytableTrendsLineData(result, datafilter, idval) {
        var finalFilterdata = result;
        var lablelval = $(finalFilterdata).map(function (idex, val) {
            if (val["" + datafilter] != "-" && val["" + datafilter] != "" && val["" + datafilter] != "0.00")
                return (val.TRANDT);
        }).get().join(',');
        var temp = new Array();
        temp = lablelval.split(",");
        var actulD = $(finalFilterdata).map(function (idex, val) {
            if (val["" + datafilter] != "-" && val["" + datafilter] != "" && val["" + datafilter] != "0.00")
                if (datafilter != "BP")
                    return $.trim(parseFloat(val["" + datafilter + ""]));
                else
                    return $.trim(val["" + datafilter + ""]);
        }).get().join(',')
        var Actualdata = new Array();
        Actualdata = actulD.split(",");
        var selector = '#VitalHistoryline-chart' + idval;
        if (datafilter != "BP") {
            var lineChartData = {
                labels: temp,
                datasets: [
                    {
                        label: "My dataset",
                        fillColor: "rgba(255,255,255,0)",
                        strokeColor: "#0e6b80",
                        pointColor: "#0e6b80",
                        pointStrokeColor: "#0e6b80",
                        pointHighlightFill: "#0e6b80",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                        data: Actualdata
                    },
                    {
                        label: "My dataset",
                        fillColor: "rgba(255,255,255,0)",
                        strokeColor: "#dd4b39",
                        pointColor: "#dd4b39 ",
                        pointStrokeColor: "#dd4b39",
                        pointHighlightFill: "#dd4b39",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                    }, {
                        label: "My dataset",
                        fillColor: "rgba(255,255,255,0)",
                        strokeColor: "#f6ea0a",
                        pointColor: "#f6ea0a ",
                        pointStrokeColor: "#f6ea0a",
                        pointHighlightFill: "#f6ea0a",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                    }
                ]
            }
            var lineChart = $(selector).get(0).getContext("2d");
            window.lineChart = new Chart(lineChart).Line(lineChartData, {
                bezierCurve: false,
                scaleFontSize: 11,
                scaleFontColor: "black",
                responsive: true,
                pointDotRadius: 1,
                pointDotStrokeWidth: 3,
                pointLabelFontSize: 10,
                tooltipFontSize: 10,
                tooltipFontStyle: "normal",
                scales: {
                    xAxes: [{
                        gridLines: {
                            display: true
                        }
                    }],
                    yAxes: [{
                        gridLines: {
                            display: false
                        }
                    }]
                },
                showTooltips: false,
                options: { responsive: true, maintainAspectRatio: false },
                onAnimationComplete: function () {
                    var lc = lineChart;
                    lc.fillStyle = this.scale.textColor
                    lc.textAlign = "center";
                    lc.textBaseline = "bottom";
                    this.datasets.forEach(function (dataset) {
                        dataset.points.forEach(function (points) {
                            lc.fillText(points.value, points.x, points.y - 10);
                        });
                    })
                }
            });
        } else {
            var rangechart = $(selector).get(0);
            var chart = new CanvasJS.Chart(rangechart, {
                theme: "light2",
                animationEnabled: true,
                backgroundColor: "transparent",
                toolTip: {
                    fontColor: "White",
                    backgroundColor: "rgba(0, 0, 0, 0.85)",
                    borderColor: "rgba(0, 0, 0, 0.85)"
                },
                axisX: {
                    gridThickness: 1,
                    gridColor: "#cacaca",
                    lineColor: "#cacaca",
                    tickColor: "#cacaca",
                },
                axisY: {
                    gridThickness: 1,
                    gridColor: "#cacaca",
                    lineColor: "#cacaca",
                    tickColor: "#cacaca",
                    includeZero: false
                },
                data: [
                    {
                        type: "rangeColumn", indexLabel: "{y[#index]}", indexLabelPlacement: "outside", indexLabelFontSize: 12,
                        indexLabelOrientation: "horizontal", color: "#0c6a80",
                        dataPoints: [], toolTipContent: "{label}: {y[0]} / {y[1]}"
                    },
                ]
            });
            var dataPoints = [];
            var range = [];
            for (var i = 0; i < temp.length; i++) {
                range = Actualdata[i].split("/");
                chart.options.data[0].dataPoints.push({ label: temp[i], y: [parseInt(range[0]), parseInt(range[1])] });
            }
            chart.render();
        }
    }
    function BindPatRefNote() {
        var strTranno = sessionStorage.getItem('PatTRANNO');
        if (strTranno == undefined) { strTranno = ""; }
        var strMrNo = sessionStorage.getItem('PatMRNO');
        if (strTranno != "" && strTranno != null && strMrNo != "" && strMrNo != null) {
            $.ajax({
                url: '../DoctorDesk/GetPatReferralNotes',
                type: "POST",
                datatype: "json",
                async: true,
                data: { TranNo: strTranno, Mrno: strMrNo },
                success: function (data) {
                    GetPatReferalNotes(data)
                }
            });
        }
    }

    function GetPatReferalNotes(NotesLstData) {
        if (NotesLstData.length == 0) {
            $('#HeaderSection_PatNoteIcon').css("display", "none");
            // ToastMsg("Information", "No Data Found.");
        }
        else {
            var RplMainDiv = "";
            for (var i = 0; i < NotesLstData.length; i++) {

                var formattedNote = NotesLstData[i].NOTE.replace(/\n/g, "<br/>");

                var RplMainDiv1 =
                    '<div style="border:1px solid #ccc; padding:8px;">' +
                    '<div style="margin-bottom:5px;">' +
                    '<span style="font-weight:bold;">Referred By</span>' +
                    '<span style="padding:0 5px;">: </span>' +
                    '<span>Dr.' + NotesLstData[i].REFBYDOCTOR + '</span>' +
                    '</div>' +
                    '<div>' +
                    '<span style="font-weight:bold;margin-top:5px;">Date-Time </span><span>' +
                    '<span style="padding:0 5px;">:</span>' 
                    + NotesLstData[i].Date + ' - ' + NotesLstData[i].Time + '</span>' +
                    '</div>' +
                    '<div>' +
                    '<span style="font-weight:bold;margin-top:5px;">Note </span><span>' +
                    '<span style="padding:0 5px;">:</span>' 
                    + formattedNote + '</span>' +
                    '</div>';

                RplMainDiv += RplMainDiv1;
            }
            openPopupDynamic("Note", RplMainDiv);
            $('#HeaderSection_PatNoteIcon').css("display", "inline-block");
        }
    }

    function ToggleVitals() {
        if (document.getElementById("HeaderPatDetails_VitalDetails").style.display == "flex") {
            document.getElementById("HeaderPatDetails_VitalDetails").style.display = "none";
            document.getElementById("HeaderPatDetails_VitalDetails_Clone").style.display = "flex";
        }
        else {
            document.getElementById("HeaderPatDetails_VitalDetails").style.display = "flex";
            document.getElementById("HeaderPatDetails_VitalDetails_Clone").style.display = "none";
        }
        HideShowProxy();
    }
  function vitalClone() {
      var ids = ["txtWeight", "txtHeight", "txtTemp", "txtRR", "txtSPO2", "txtBMI", "txtBSA", "txtBP1", "txtBP2"];

      ids.forEach(function (id) {
          var value = $("#VitalsDetails_" + id).text();
          $("#VitalsDetails_" + id + "_Clone").text(value);
      });
    }

    function getNumber(selector) {//priyanka 24/04/2026
        return $(selector).text().replace(/[^\d.]/g, '');
    }

    function OnOverOfVitalQuickView() {
        $("#VitalsQuickViewDropdown").toggleClass("show");
        if ($("#VitalsQuickViewDropdown").hasClass("show")) {
            vitalClone();
            GetDataForVitals("Y");
            $("#EMR_txtWeight").text($("#VitalsDetails_txtWeight_Clone").text());
            $("#EMR_txtHeight").text($("#VitalsDetails_txtHeight_Clone").text());
            $("#EMR_txtTemp").text($("#VitalsDetails_txtTemp_Clone").text());
            $("#EMR_txtBP1").text($("#VitalsDetails_txtBP1_Clone").text());
            $("#EMR_txtBP2").text($("#VitalsDetails_txtBP2_Clone").text());
            $("#EMR_txtBMI").text($("#VitalsDetails_txtBMI_Clone").text());
            $("#EMR_txtRR").text($("#VitalsDetails_txtRR").text());
            $("#EMR_txtSPO2").text($("#VitalsDetails_txtSPO2").text());
            $("#EMR_txtBSA").text($("#VitalsDetails_txtBSA").text());
            var vitalsMap = [
                { id: "EMR_txtWeight", key: "Weight", unit: " kg", cloneid: "VitalsDetails_txtWeight_Clone" },
                { id: "EMR_txtHeight", key: "HEIGHT", unit: " cm", cloneid: "VitalsDetails_txtHeight_Clone" },
                { id: "EMR_txtTemp", key: "TEMP", unit: " °F", cloneid: "VitalsDetails_txtTemp_Clone" },
                { id: "EMR_txtRR", key: "RESP", unit: " Breaths/Minute", cloneid: "VitalsDetails_txtRR" },
                { id: "EMR_txtSPO2", key: "SPO2", unit: " %", cloneid: "VitalsDetails_txtSPO2" },
                { id: "EMR_txtBMI", key: "BMI", unit: "kg/m²", cloneid: "VitalsDetails_txtBMI_Clone" },
                { id: "EMR_txtBSA", key: "BSA", unit: "m²", cloneid: "VitalsDetails_txtBSA" },
            ];
            for (var i = 0; i < vitalsMap.length; i++) {
                var vital = vitalsMap[i];
                var value = getNumber("#" + vitalsMap[i].cloneid);
                checkVitalsDataMaxValEMRVitals(vital.id, value);
            }
            checkVitalsDataMaxValEMRVitals("EMR_txtBP1", $("#VitalsDetails_txtBP1_Clone").text());
            checkVitalsDataMaxValEMRVitals("EMR_txtBP2", $("#VitalsDetails_txtBP2_Clone").text());
        }
    }

    function ToggleVitals(btn) {

        const vitalsStrip = document.getElementById('HeaderPatDetails_VitalDetails_Clone');
        const normalVitals = document.getElementById('HeaderPatDetails_VitalDetails');
        const listMenu = document.getElementById('HeaderListMenu'); // 

        const actionButtons = document.getElementById('HeaderActionButtons');

        const image = document.getElementById('HeaderSection_PatDetails_IPDPatImg');
        const seprator1 = document.getElementById('seperator1');
        const seprator2 = document.getElementById('seperator2');
        const PatGender = document.getElementById('HeaderSection_PatDetails_GENDER');
        const PatAge = document.getElementById('HeaderSection_PatDetails_AGE');
        const PatMRNO = document.getElementById('HeaderSection_PatDetails_MRNO');
        const invCode = document.getElementById('HeaderSection_PatDetails_lblInvNotiCD');
        const TagCode = document.getElementById('HeaderSection_PatDetails_TegChemo');

        if (!vitalsStrip) return;

        const isExpanded = vitalsStrip.style.display === "flex";

        if (!isExpanded) {

            // =========================
            // EXPAND (Chevron Up)
            // =========================

            vitalsStrip.style.display = "flex";
            if (normalVitals) normalVitals.style.display = "none";
            if (listMenu) listMenu.style.display = "block";
            if (listMenu) listMenu.style.display = "flex"; // show list when expande
            // Hide patient info
            if (image) image.style.display = "none";
            if (seprator1) seprator1.style.display = "none";
            if (seprator2) seprator2.style.display = "none";
            if (PatGender) PatGender.style.display = "none";
            if (PatAge) PatAge.style.display = "none";
            if (PatMRNO) PatMRNO.style.display = "none";
            if (invCode) invCode.style.display = "none";
            if (TagCode) TagCode.style.display = "none";

            // 🔥 Properly hide buttons
            if (actionButtons) actionButtons.classList.add("hide-actions");

            //btn.querySelector('i').classList.remove('fa-chevron-down');
            //btn.querySelector('i').classList.add('fa-chevron-up');

            btn.querySelector('i').classList.add('fa-chevron-down');
            btn.querySelector('i').classList.remove('fa-chevron-up');


        } else {

            // =========================
            // COLLAPSE (Chevron Down)
            // =========================

            vitalsStrip.style.display = "none";
            if (normalVitals) normalVitals.style.display = "flex";
            if (listMenu) listMenu.style.display = "none";
            if (listMenu) listMenu.style.display = "none"; // hide list when collapsed

            // Show patient info
            if (image) image.style.display = "flex";
            if (seprator1) seprator1.style.display = "flex";
            if (seprator2) seprator2.style.display = "flex";
            if (PatGender) PatGender.style.display = "flex";
            if (PatAge) PatAge.style.display = "flex";
            if (PatMRNO) PatMRNO.style.display = "flex";
            if (invCode) invCode.style.display = "flex";
            if (TagCode) TagCode.style.display = "flex";

            // 🔥 Properly show buttons again
            if (actionButtons) actionButtons.classList.remove("hide-actions");

            //btn.querySelector('i').classList.remove('fa-chevron-up');
            //btn.querySelector('i').classList.add('fa-chevron-down');

            btn.querySelector('i').classList.add('fa-chevron-up');
            btn.querySelector('i').classList.remove('fa-chevron-down');
        }
    }

    function HideShowProxy() {
        if ($("#txtProxyYN").val() == "Y") {
            $(".vital-box").hide();
            $(".vital-separator").hide();
            $(".VitalsEdit").hide();
            $(".Vital_QuickView").hide();
            $(".ProxyVisitLbl").show();
        }
        else {
            $(".vital-box").show();
            $(".vital-separator").show();
            $(".VitalsEdit").show();
            $(".Vital_QuickView").show();
            $(".ProxyVisitLbl").hide();
        }
    }
</script>

<style>
    .ProxyVisitLbl {
        color: red;
        font-weight: bold;
        font-size: large;
    }
    .DivVitals {
        display: flex;
    }

    .LblVitals {
        display: inline-block;
        width: 130px;
    }

    .SepVitals {
        display: inline-block;
        width: 15px;
        text-align: center;
    }

    .ValueVitals {
        display: inline-block;
    }

.Vital_QuickView {
    position: relative;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.Vital_QuickView_dropdown {
    display: none;
    position: absolute;
    top: 100%;
    right: 0;
    min-width: 280px;
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(0,0,0,.15);
    padding: 10px;
    z-index: 9999;
}

.Vital_QuickView_dropdown.show {
    display: block;
    font-size:14px;
}

</style>
<div class="d-flex justify-content-between align-items-start">

    <!-- LEFT SIDE (Patient Info) -->
    <div class="d-flex align-items-center">

        <button class="btn btn-link text-dark p-0 me-3" id="OPDPatientDashboard_BackBtn">
            <i class="fa fa-chevron-left"></i>Back
        </button>

        <img class="rounded-circle PatientInfo-Profile-Image" id="HeaderSection_PatDetails_IPDPatImg" alt="User">

        <div id="HeaderPatDetails_PatientDetails">

            <div class="d-flex align-items-center">
                <span class="patient-name-large"
                      id="HeaderSection_PatDetails_PatName"></span>

                <a id="HeaderSection_PatInfoIcon">
                    <i class="fa fa-info-circle ms-2 text-muted"
                       onclick="HistoryPopupOpen('Patient Info', 'PatientInfo',true)"></i>
                </a>

                <a id="HeaderSection_PatNoteIcon">
                    <i class="fa fa-book ms-2 text-muted"
                       onclick="BindPatRefNote()"></i>
                </a>
            </div>

            <div class="patient-meta">

                <div id="HeaderSection_PatDetails_PatMRNO"
                     class="d-flex align-items-center gap-1">

                    <span id="HeaderSection_PatDetails_MRNO"
                          class="fw-semibold text-muted"></span>

                    <span class="fw-semibold text-muted"
                          id="seperator1">|</span>

                    <span id="HeaderSection_PatDetails_GENDER"
                          class="fw-semibold text-muted"></span>

                    <span class="fw-semibold text-muted"
                          id="seperator2">|</span>

                    <span id="HeaderSection_PatDetails_AGE"
                          class="fw-semibold text-muted"></span>
                </div>

                <div id="HeaderSection_InvestigationCode"
                     class="d-flex align-items-center gap-1">

                    <span id="HeaderSection_PatDetails_lblInvNotiCD"
                          class="fw-semibold PatientInfo-PatTag"></span>

                    <span id="HeaderSection_PatDetails_TegChemo"
                          class="tag-chemo"></span>
                </div>

            </div>
        </div>
    </div>

 <!-- RIGHT SIDE (Buttons) -->
<div class="d-flex align-items-center">

    <!-- ✅ Vitals Clone Strip (MOVED OUTSIDE) -->
    <div class="vitals-strip"
         style="margin-top:0px; gap:0px; display:none;"
         id="HeaderPatDetails_VitalDetails_Clone">

        <div class="vital-box">
            <span class="label">Weight</span>
            <span class="val" id="VitalsDetails_txtWeight_Clone" val=""></span>
        </div>

        <div class="vital-separator"></div>

        <div class="vital-box">
            <span class="label">Height</span>
            <span class="val" id="VitalsDetails_txtHeight_Clone" val=""></span>
        </div>

        <div class="vital-separator"></div>

                <div class="vital-box">
            <span class="label">Temp</span>
            <span class="val" id="VitalsDetails_txtTemp_Clone" val=""></span>
        </div>

        <div class="vital-separator"></div>

        <div class="vital-box">
            <span class="label">BP</span>
            <span class="val" id="VitalsDetails_txtBP1_Clone" val=""></span>
            <span class="val" id="VitalsDetails_txtBP2_Clone"></span>
        </div>
        <div class="vital-separator" style="display:none;"></div>
        <div class="vital-box" style="display:none;">
            <span class="label">BMI</span>
            <span class="val" id="VitalsDetails_txtBMI_Clone" val=""></span>
        </div>



        <div class="Vital_QuickView header_settings ms-2" id="btnVitalsQuickView" onclick="event.stopPropagation(); OnOverOfVitalQuickView()" style="align-items: center; justify-content: center;">
            <button class="btn btn-header p-0" style="margin-left: 0px">
                <i class="fa fa-ellipsis-v" style="font-size:20px"></i>
            </button>

            <div class="Vital_QuickView_dropdown" id="VitalsQuickViewDropdown">
                <div class="DivVitals"><strong class="LblVitals">Weight</strong><span class="SepVitals">:</span><span class="ValueVitals" id="EMR_txtWeight"></span></div>
                <div class="DivVitals"><strong class="LblVitals">Height</strong><span class="SepVitals">:</span> <span class="ValueVitals" id="EMR_txtHeight"></span></div>
                <div class="DivVitals"><strong class="LblVitals">Temp</strong> <span class="SepVitals">:</span><span class="ValueVitals" id="EMR_txtTemp"></span></div>
                <div class="DivVitals"><strong class="LblVitals">BP</strong><span class="SepVitals">:</span> <span class="ValueVitals" id="EMR_txtBP1"></span><span id="EMR_txtBP2"></span></div>
                <div class="DivVitals"><strong class="LblVitals">BMI</strong> <span class="SepVitals">:</span><span class="ValueVitals" id="EMR_txtBMI"></span></div>
                <div class="DivVitals"><strong class="LblVitals">Respiratory Rate</strong> <span class="SepVitals">:</span><span class="ValueVitals" id="EMR_txtRR"></span></div>
                <div class="DivVitals"><strong class="LblVitals">SpO2</strong><span class="SepVitals">:</span> <span class="ValueVitals" id="EMR_txtSPO2"></span></div>
                <div class="DivVitals"><strong class="LblVitals">BSA</strong><span class="SepVitals">:</span> <span class="ValueVitals" id="EMR_txtBSA"></span></div>
            </div>
                <div id='loading-VitalsQuickInfo' class='loading-screen' style='display: none; opacity: 0;'></div>

        </div>

        <label id="LblProxyVisitClone" class="ProxyVisitLbl" style="display:none" >Proxy Visit</label>

    </div>


  <!-- WRAP ONLY ACTION BUTTONS -->
<div id="HeaderActionButtons" class="d-flex align-items-center">

    <!-- Tumor -->
    <button class="btn btn-header" id="RedirectToTumor">
        <img src="../images/Singlepage/tumorboardicon.png"
             class="rounded-circle"
             id="TumorBoardCount"
             alt="Tumor List"
             style="width:32px;height:33px;border:1px solid #f3f3f3;">
    </button>

    <!-- Notes -->  
    <button class="btn btn-header" id="BtnPatientNotes"
            onclick="HistoryPopupOpen('Patient Notes', 'Notes', true)"
            style="position:relative;">
        <i class="fa fa-edit" style="font-size: 25px;"></i>
        <span id="notesNotificationBadge" class="nt-badge">0</span>
    </button>

    <!-- Upload -->
    <button class="btn btn-header" id="BtnUpload"
            onclick="HistoryPopupOpen('Attachments', 'Upload',true)">
        <i class="fa fa-upload" style="font-size: 25px;"></i>
    </button>

          <!-- Visit History -->
    <button class="btn btn-visit-history ms-2" id="BtnVisitHistory"
            onclick="HistoryPopupOpen('Visit History', 'VisitHistory',true)">
        <i class="fa fa-clock-o" style="font-size: 25px;"></i>
    </button>

</div>

<!-- LIST DROPDOWN -->
<div class="header_settings ms-2" id="HeaderListMenu"style="align-items: center;justify-content: center;">
    <button class="btn btn-header p-0"style="margin-left: 0px">
           <img class="h-icon-size" src="../Images/Singlepage/List.png" alt="Settings" />
    </button>

    <div class="header_settings_dropdown">
        <div class="header_settings_item h-font-size" onclick="document.getElementById('TumorBoardCount').click()">
          <span><img src="../images/Singlepage/tumorboardicon.png" style="width:16px; height:16px; margin-right:5px;margin-left: 0px;"></span>
          Tumor Board 
        </div>

        <div class="header_settings_item h-font-size" onclick="document.getElementById('BtnPatientNotes').click()">
         <span> <i class="fa fa-edit"></i></span>  Patient Notes
        </div>

        <div class="header_settings_item h-font-size" onclick="document.getElementById('BtnUpload').click()">
           <span> <i class="fa fa-upload"></i></span>Attachments
        </div>

        <div class="header_settings_item h-font-size" onclick="document.getElementById('BtnVisitHistory').click()">
          <span> <i class="fa fa-clock-o"></i></span> Visit History
        </div>
    </div>
</div>

    <!-- CHEVRON -->
    <button class="btn btn-light ms-2"
            onclick="ToggleVitals(this)">
        <i class="fa fa-chevron-up"></i>
    </button>

</div>
</div>
  <%--normal--%>
<div class="vitals-strip mt-3 mb-2" id="HeaderPatDetails_VitalDetails">
<%--<div class="vital-box"><span class="label" id="VitalDetails_lblWeight">Weight</span> <span class="val" id="VitalsDetails_txtWeight"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblHeight">Height</span> <span class="val" id="VitalsDetails_txtHeight"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblTemp">Temp</span> <span class="val val-alert" id="VitalsDetails_txtTemp"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_BP">BP</span> <span class="val val-alert" id="VitalsDetails_txtBP1"></span><span class="val" id="VitalsDetails_txtBP2"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblRR">Respiratory Rate</span> <span class="val val-alert" id="VitalsDetails_txtRR"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblSPO2">SpO2</span> <span class="val val-alert" id="VitalsDetails_txtSPO2"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblBMI">BMI</span> <span class="val val-alert" id="VitalsDetails_txtBMI"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblBSA">BSA</span> <span class="val" id="VitalsDetails_txtBSA"></span></div>--%>

<%--priyanka 16/03/2026--%>
<div class="vital-box"><span class="label" id="VitalDetails_lblWeight">Weight</span> <span class="val" id="VitalsDetails_txtWeight"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblHeight">Height</span> <span class="val" id="VitalsDetails_txtHeight"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblTemp">Temp</span> <span class="val" id="VitalsDetails_txtTemp"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblPulse">Pulse</span> <span class="val" id="VitalsDetails_txtPulse"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblRR">RR</span> <span class="val" id="VitalsDetails_txtRR"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_BP">BP</span> <span class="val " id="VitalsDetails_txtBP1"></span><span class="val" id="VitalsDetails_txtBP2"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblSPO2">SpO2</span> <span class="val " id="VitalsDetails_txtSPO2"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblPainScore">PainScore</span> <span class="val" id="VitalsDetails_txtPainScore"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblBMI">BMI</span> <span class="val" id="VitalsDetails_txtBMI"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblBSA">BSA</span> <span class="val" id="VitalsDetails_txtBSA"></span></div>
<div class="vital-separator"></div>
<div class="vital-box"><span class="label" id="VitalDetails_lblRBS">RBS</span> <span class="val" id="VitalsDetails_txtRBS"></span></div>
<input type="text" id="txtProxyYN" style="display:none" />
<label id="LblProxyVisit" class="ProxyVisitLbl"  style="display:none" >Proxy Visit</label>
<%--end--%>

<div class="ms-auto">
        <%--<button class="btn btn-edit-vitals" onclick="HistoryPopupOpen('Edit Vitals Info', 'EditVitalsInfo')">Edit Vitals</button>--%>
<button class="btn btn-edit-vitals VitalsEdit" onclick="HistoryPopupOpen('Edit Vitals Info', 'EditVitalsInfo',true)"><i class="fa fa-tint"></i></button>
        <button class="btn btn-edit-vitals ms-1" onclick="LoadPatientVitalHistory()"><i class="fa fa-line-chart"></i></button>

        <button class="btn btn-edit-vitals ms-1 position-relative" id="AllergyCountbtn" onclick="openRightMenu('../SinglePage/History','','')">
            <img src="../Images/allergy.png"
                alt="Allergy"
                style="width: 20px; height: 20px;" />

            <span id="allergyCountBadge"
                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0
    </span>
        </button>

    </div>
</div>
