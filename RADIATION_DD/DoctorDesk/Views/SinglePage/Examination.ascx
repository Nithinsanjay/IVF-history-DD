<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<style>
    textarea {
        box-sizing: border-box;
    }
</style>

<script type="text/javascript">
    var RMOFlagExamYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVEEXAMYN")%>' == "Y" ? "N" : "Y") : "N";
    var SessionCompExam = '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagExamYN == "Y" ? "Y" : sessionStorage.getItem('PatCompleted');

    $(document).ready(function () {
        // Added By Abhishesh || 20260321 
        $("#btnEXFittoContent2").on("click", function () {
            fitToContent('Exam_HistoryFreetext');
        });
        $("#btnEXSetMaxHeight2").on("click", function () {

            setMaxHeight('Exam_HistoryFreetext');
        });

        $("#btnEXFitToContent").on("click", function () { // Abhishesh 

            fitToContent('Exam_Freetext');
        });

        $("#btnEXSetMaxHeight").on("click", function () {

            setMaxHeight('Exam_Freetext');
        });
        //End
        $("#ddlExamTemplate").on("change", function () {
            switch (this.value) {
                case "SYS": loadSystemicExaminations(); break;

                case "RHEU": loadRheumatology(); break;

                case "OP1": loadOpthal1(); break;

                case "OP2": loadOpthal2(); break;

                case "OP3": loadOpthal3(); break;

                case "RESP": loadRespiratoryMedicine(); break;
            }
            this.value = "";
        });

        $("#ddlHistoryTemplate").on("change", function () {
            switch (this.value) {
                case "GYNAC": loadGynac(); break;

                case "OBST": loadOBST(); break;
            }
            this.value = "";
        });

        $("#Exam_Freetext").on("input", function () {
            autoResizeTextareaForSinglePage(this);
        });

        $("#Exam_HistoryFreetext").on("input", function () {
            autoResizeTextareaForSinglePage(this);
        });

        $("#BtnExaminationImageToggle").on("click", function () {
            var $container = $("#DivExaminationImagesContainer");
            var $icon = $(this).find("i");
            if ($container.is(":visible")) {
                $container.slideUp();
                $icon.removeClass("fa-chevron-up").addClass("fa-chevron-down");
            } else {
                $container.slideDown();
                $icon.removeClass("fa-chevron-down").addClass("fa-chevron-up");
                LoadSavedExamImages();
            }
        });

        $('#BtnExaminationImageToggle').trigger('click');

        /* Bind Already Saved Examination */
        SetDataForExamination();
        //Added by Haritha 25/02/26
        if (sessionStorage.getItem("PatCompleted").toString() === "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" || RMOFlagExamYN == "Y") {
            $("#sec-exam *").attr("disabled", "disabled");
            $("#Exam_PrevHistory").removeAttr("disabled");
        }
        else {
            $("#sec-complaints *").removeAttr("disabled");
        }
    });
    function ValidationForExamination(Type) {
        return true;
    }

    function SaveForExaminations(DataSaveObj) {
        DataSaveObj.ExamDet = $("#Exam_Freetext").val();
        DataSaveObj.PastHist = $("#Exam_HistoryFreetext").val();
    }

    function loadSystemicExaminations() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push(" General Examination		:	NAD \n\n");
        strPrindData.push("  Systemic Examination\n");
        strPrindData.push("\t\t 1.  Cardiovascular System		:	NAD\n");
        strPrindData.push("\t\t 2.  Central Nervous System		:	NAD\n");
        strPrindData.push("\t\t 3.  Respiratory System		        :	NAD\n");
        strPrindData.push("\t\t 4.  Per Abdomen			        :	NAD\n\n");
        strPrindData.push("  Local Examination			            :	Not Applicable\n");
        if (HideECGRow == "Y")
            strPrindData.push("  ECG                             :   Done / Not Done - Within Normal Limits\n");
        appendToExamText(strPrindData, "");
    }

    function loadRheumatology() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("  \n Synovitis \n");
        strPrindData.push("  Deformities \n");
        strPrindData.push("  Phalen's Test \n");
        strPrindData.push("  Finkelstein's Test \n\n");
        strPrindData.push(" 	\n");
        strPrindData.push(" Power - Upper Limb 	:	\n");
        strPrindData.push(" \t     - Lower Limb	:	\n");
        strPrindData.push(" Neck  Flexors	:	\n\n");
        var strPrindData1 = [];
        strPrindData1.push(" SLR :  \n");
        appendToExamText(strPrindData, "");
        appendToExamText(strPrindData1, "");
    }

    function loadOpthal1() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push(".                    Right Eye                          Left  Eye	\n");
        strPrindData.push("Vision    :                                       \n");
        strPrindData.push("--------------------------------------------------------------------------\n");
        strPrindData.push("Tension  :                                                  \n");
        strPrindData.push("--------------------------------------------------------------------------\n");
        strPrindData.push("Cornea   :                                                  \n");
        strPrindData.push("--------------------------------------------------------------------------\n");
        strPrindData.push("Lens       :                                                  \n");
        var strPrindData1 = [];
        strPrindData1.push("--------------------------------------------------------------------------\n");
        strPrindData1.push("Retina    :                                                  \n");
        appendToExamText(strPrindData, "");
        appendToExamText(strPrindData1, "");
    }

    function loadOpthal2() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("\n  EOM   :  \n");
        strPrindData.push("   Lid   :  \n");
        strPrindData.push("   Cornea   :  \n");
        strPrindData.push("   Pupil   :  \n");
        strPrindData.push("   Lens   :  \n");
        strPrindData.push("   Anterior Segment   :  \n");
        strPrindData.push("   Fundus   CDR:   :  \n");
        strPrindData.push("   FR    :  \n");
        var strPrindData1 = [];
        strPrindData1.push("\n  Vision <   :  \n");
        strPrindData1.push("   Refraction <   :             AR <  :           \n");
        strPrindData1.push("   Vision with glass <   :  \n");
        strPrindData1.push("   IOP <   :  \n");
        strPrindData1.push("   Dilated AR <   :  \n");
        strPrindData1.push("   Dilated Retraction <   :  \n");
        strPrindData1.push("   Fogging <   :  \n");
        strPrindData1.push("   FR    :  \n");
        appendToExamText(strPrindData, "");
        appendToExamText(strPrindData1, "");
    }

    function loadOpthal3() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("\n   DISTANCE VISION - WITH / WITHOUT GLASS    \n");
        strPrindData.push("   RIGHT EYE - 6/6     \n");
        strPrindData.push("   LEFT EYE - 6/6     \n\n");
        strPrindData.push("   NEAR VISION - WITH / WITHOUT GLASS     \n");
        strPrindData.push("   RIGHT EYE - N6     \n");
        strPrindData.push("   LEFT EYE - N6     \n\n");
        strPrindData.push("   INTRAOCULAR PRESSURE   \n");
        strPrindData.push("   RIGHT EYE - 16      \n");
        var strPrindData1 = [];
        strPrindData1.push("   LEFT EYE - 16 <     \n\n");
        strPrindData1.push("   ANTERIOR SEGMENT                     \n");
        strPrindData1.push("   RIGHT EYE - NORMAL     \n");
        strPrindData1.push("   LEFT EYE - NORMAL    \n\n");
        strPrindData1.push("   POSTERIOR SEGMENT   \n");
        strPrindData1.push("   RIGHT EYE - NORMAL     \n");
        strPrindData1.push("   LEFT EYE - NORMAL   \n\n");
        strPrindData1.push("   VISION ACCEPTANCE     \n\n");
        var strPrindData2 = [];
        strPrindData2.push("   RE :  \n\n");
        strPrindData2.push("   LE :  \n\n");
        strPrindData2.push("   ADD:  \n\n");
        strPrindData2.push("   OTHER OBSERVATIONS : \n\n");
        appendToExamText(strPrindData, "");
        appendToExamText(strPrindData1, "");
        appendToExamText(strPrindData2, "");
    }

    function loadRespiratoryMedicine() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("\n   Chief Complaints : \n");
        strPrindData.push("   C/o breathlessness since \n");
        strPrindData.push("   C/o cough with expectoration since \n");
        strPrindData.push("   C/o fever since     \n");
        strPrindData.push("   C/o chest pain since \n");
        strPrindData.push("   Symptomatically better \n\n");
        strPrindData.push("   Past History :   \n\n\n");
        strPrindData.push("   On Examination :      \n");
        var strPrindData1 = [];
        strPrindData1.push("   P - /min \n"); strPrindData1.push("   BP - / mmHg \n"); strPrindData1.push("   SpO2 - % \n"); strPrindData1.push("   Chest - % \n\n");
        strPrindData1.push("   Plan – Start empirical ATT     \n  The rationale for starting empirical ATT, along with the possible duration and side effects \n");
        strPrindData1.push("   explained to the patient and her relative. \n\n");
        strPrindData1.push("    Advice - \n");
        var strPrindData2 = [];
        strPrindData2.push("   Follow Up  - \n");
        strPrindData2.push("   Refer To    - \n");
        appendToExamText(strPrindData, "");
        appendToExamText(strPrindData1, "");
        appendToExamText(strPrindData2, "");
    }

    function loadGynac() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push("  Menstrual History  :\n");
        strPrindData.push("\t\t 1.  LMP		:	\n");
        strPrindData.push("\t\t 2.  LLMP 	:	\n");
        strPrindData.push("\t\t 3.  PRMC	:	\n");
        strPrindData.push("\t\t 4.  PAMC	:	\n\n");
        strPrindData.push("  Obstetric History -MS-  :	 \n");
        strPrindData.push("\t\t P\t L\t A\t \n\n");
        strPrindData.push("  Surgical History   :	\n\n");
        var strPrindData1 = [];
        strPrindData1.push("  Medical History:  	\n\n");
        appendToExamText(strPrindData, "History");
        appendToExamText(strPrindData1, "History");
    }

    function loadOBST() {
        var sysExamString = "";
        var strPrindData = [];
        strPrindData.push(" Menstrual History : \n");
        strPrindData.push("\t\t 1.  LMP		:	\n");
        strPrindData.push("\t\t 2.  EDD 	:	\n");
        strPrindData.push("\t\t 3.  GA  	:	\n");
        strPrindData.push("\t\t 4.  PAMC	:	\n\n");
        strPrindData.push("  Obstetric History  :	 \n");
        strPrindData.push("\t\t G\t P\t L\t A\t \n\n");
        var strPrindData1 = [];
        strPrindData1.push("  Immunization Status   :	\n");
        strPrindData1.push("\t\t 1.  T.T.		:	\n");
        strPrindData1.push("\t\t 2.  Tdap / Boostrix Inj 	:	\n");
        strPrindData1.push("\t\t 4.  Influvac Adult Inj 	:	\n\n");
        strPrindData1.push("  Surgical History : \n\n");
        strPrindData1.push("  Medical History : \n\n");
        appendToExamText(strPrindData, "History");
        appendToExamText(strPrindData1, "History");
    }

    function appendToExamText(linesArray, Type) {
        var txt = "";
        if (Type == "History") {
            txt = $("#Exam_HistoryFreetext");
        } else {
            txt = $("#Exam_Freetext");
        }
        txt.val(txt.val() + linesArray.join(""));
        autoResizeTextareaForSinglePage(txt[0]);
    }

    function SetDataForExamination() {
        var strTran = sessionStorage.getItem('PatTRANNO');
        var strtype = "E";
        startLoading("Loading", "loading-Examinations");
        $.ajax({
            type: "POST",
            url: '../DoctorDesk/GetExam',
            data: {
                Tran: strTran,
                Type: strtype
            },
            async: true,
            success: function (result) {
                $('#Exam_Freetext').empty();
                $('#Exam_HistoryFreetext').empty();
                if (result != "") {
                    $('#Exam_Freetext').val(result[0].EXAM);
                    $('#Exam_HistoryFreetext').val(result[0].PASTHIST);
                    //autoResizeTextareaForSinglePage(document.getElementById('Exam_Freetext'));
                    //priyanka 02/04/2026
                    fitToContent('Exam_Freetext');
                    $("#btnEXFitToContent").show();
                    $("#btnEXSetMaxHeight").show();

                    //priyanka 02/04/2026
                    fitToContent('Exam_HistoryFreetext');
                    $("#btnEXFittoContent2").show();
                    $("#btnEXSetMaxHeight2").show();
                    //end
                    //autoResizeTextareaForSinglePage(document.getElementById('Exam_HistoryFreetext'));
                }
                stopLoading("loading-Examinations");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Examinations");
                ToastMsg(textStatus, "error");
            }
        });
    }

</script>

<%--Examination Image Style--%>
<style type="text/css">
    .activeExaminationImage img {
        border: 2px solid #28a745;
    }

    #preExaminationImagesWrapper {
        display: flex;
        flex-wrap: nowrap;
        overflow-x: hidden;
        gap: 10px;
    }

    /* === ExamImageEditor Popup Styling === */
    .ExamImageEditor-modal {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1250;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.2);
        max-width: 900px;
        width: 95%;
        overflow: hidden;
        animation: fadeInScale 0.3s ease;
    }

    @keyframes fadeInScale {
        from {
            opacity: 0;
            transform: translate(-50%, -50%) scale(0.9);
        }

        to {
            opacity: 1;
            transform: translate(-50%, -50%) scale(1);
        }
    }

    /* Header */
    .ExamImageEditor-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(135deg, #007bff, #0056b3);
        color: #fff;
        padding: 12px 16px;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
    }

        .ExamImageEditor-header h5 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .ExamImageEditor-header button {
            border: none;
            background: transparent;
            color: #fff;
            font-size: 1.2rem;
            cursor: pointer;
            transition: transform 0.2s;
        }

            .ExamImageEditor-header button:hover {
                transform: scale(1.2);
            }

    /* Body */
    .ExamImageEditor-body {
        padding: 20px;
        background-color: #f9fbfd;
        overflow: auto;
        max-height: 95vh;
    }

    /* Carousel */
    .ExamImageEditor-carousel button {
        border-radius: 50%;
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

        .ExamImageEditor-carousel button:hover {
            background-color: #e9ecef;
        }

    /* Canvas */
    .ExamImageEditor-canvas canvas {
        border: 2px solid #dee2e6;
        border-radius: 8px;
        transition: box-shadow 0.3s ease;
    }

        .ExamImageEditor-canvas canvas:hover {
            box-shadow: 0 0 12px rgba(0,123,255,0.4);
        }

    /* Action Buttons */
    .ExamImageEditor-actions .btn {
        min-width: 120px;
        font-size: 1rem;
        font-weight: 500;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

        .ExamImageEditor-actions .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

    /* Loader Overlay */
    .ExamImageEditor-loader {
        border-radius: 12px;
    }

        .ExamImageEditor-loader .spinner-border {
            width: 3rem;
            height: 3rem;
        }
    .newlyAddedImage img {
       border: 2px solid #003366 !important;
    }
    .editedExaminationImage img {
        border: 2px solid #007bff !important; /* Blue */
    }
</style>

<%--Examination Image Script--%>
<script type="text/javascript">
    var ctx = '';
    var drag = false;
    var imageObj = null;
    var rect = {};
    var clickX = new Array();
    var clickY = new Array();
    var clickDrag = new Array();

    // Open Popup For Examination Editor
    function OpenExaminationImageEditorPopup() {
        var HeaderNM = "Examination Image Editor";
        var Section = "ExaminationImageEditor";
        CloseExaminationImageEditorPopup(Section);
        var MainDivID = "ImageEditor_M_" + Section;
        var HeaderDivID = "ImageEditor_H_" + Section;
        var CloseBtnID = "ImageEditor_H_Close_" + Section;
        var ContentID = "ImageEditor_C_" + Section;
        var MinDiv = "<div class='ExamImageEditor-modal fade show' id='" + MainDivID + "'>{ALLPOPMAINCONTENT}</div>";
        var HeaderDiv = "<div class='ExamImageEditor-header d-flex justify-content-between align-items-center shadow-sm' id='" + HeaderDivID + "'>{ALLPOPHEAD}</div>";
        var HeaderLbl = "<h5>" + HeaderNM + "</h5>";
        var CloseBtn = "<button id='" + CloseBtnID + "' class='btn btn-outline-danger btn-sm rounded-circle' onclick=\"CloseExaminationImageEditorPopup('" + Section + "')\" tabindex='1'><i class='fa fa-times'></i></button>";
        var ContentDiv = "<div class='ExamImageEditor-body p-3 bg-light' id='" + ContentID + "'>{ALLPOPCONTENT}</div>";
        var Content = "";
        if (Section == "ExaminationImageEditor") {
            Content = ExaminationImageEditorContentTemp();
        }
        var RplHeaderDiv = HeaderDiv.replace("{ALLPOPHEAD}", (HeaderLbl + CloseBtn));
        var RplContentDiv = ContentDiv.replace("{ALLPOPCONTENT}", (Content));
        var ExaminationImageEditorLoader = "<div id='loading-Examinations-Image-Editor' class='loading-screen' style='display: none; opacity: 0;'></div>";
        var RplMinDiv = MinDiv.replace("{ALLPOPMAINCONTENT}", (RplHeaderDiv + RplContentDiv + ExaminationImageEditorLoader));
        $("body").append(RplMinDiv);
        document.getElementById("popupOverlay").style.display = "block";
        if (Section == "ExaminationImageEditor") {
            LoadExamImageEditor();
        }
    }

    // Content For Examination Editor
    function ExaminationImageEditorContentTemp() {
        return `
        <!-- Carousel -->
        <div class="ExamImageEditor-carousel d-flex align-items-center mb-3">
            <button class="btn btn-outline-secondary btn-sm me-2" id="carouselPrev">
                <i class="fa fa-chevron-left"></i>
            </button>
            <div class="overflow-hidden flex-grow-1">
                <div class="d-flex PreImages flex-nowrap" id="preExaminationImagesWrapper" style="gap: 10px;">
                </div>
            </div>
            <button class="btn btn-outline-secondary btn-sm ms-2" id="carouselNext">
                <i class="fa fa-chevron-right"></i>
            </button>
        </div>

        <!-- Canvas Area -->
        <div class="ExamImageEditor-canvas d-flex justify-content-center mb-3">
             <input type="text" id="CanvasExaminationImgEditorId" style="display:none"/>
            <canvas id="canvas" width="800" height="500" class="border rounded shadow-sm" style="background-color: #fff; cursor: crosshair;"></canvas>
        </div>

     <!-- Action Buttons Wrapper -->
<div style="position: relative;">

    <!-- Action Buttons (UNCHANGED) -->
    <div class="ExamImageEditor-actions d-flex justify-content-center gap-3 mb-2">
        <button type="button" class="btn btn-outline-secondary btn-lg" id="clearCanvasSimple">
            <i class="fa fa-eraser"></i> Clear
        </button>
        <button type="button" class="btn btn-success btn-lg" id="SaveImages" onclick="saveExaminImages()" style="display:none;">
            <i class="fa fa-check-circle-o"></i> Save
        </button>
    </div>

    <!-- Right Corner Indicator -->
    <div style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); display: flex; align-items: center;">
        <span style="width:15px; height:15px; background-color:#003366; border-radius:3px; margin-right:6px;"></span>
        <span style="font-size:14px; color:#333;">Edited Image </span>
    </div>

</div>

    `;
    }

    // Close Popup
    function CloseExaminationImageEditorPopup(Section) {
        var MainDivID = "ImageEditor_M_" + Section;
        document.getElementById("popupOverlay").style.display = "none";
        if (document.getElementById(MainDivID)) {
            document.getElementById(MainDivID).style.display = "none";
            document.getElementById(MainDivID).remove();
        }
    }

    function LoadExamImageEditor() {
        var canvas = document.getElementById('canvas');
        if (!ctx) {
            ctx = canvas.getContext('2d');
        }

        $('#clearCanvasSimple').mousedown(function (e) {
            if (!ctx || !imageObj) return;
            clickX = [];
            clickY = [];
            clickDrag = [];
            ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height)
            ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height);
            $('.PreImages').children().removeClass('activeExaminationImage');
            $("#SaveImages").hide();
        });

        canvas.addEventListener("touchstart", function (e) {
            var mouseX = (e.changedTouches ? e.changedTouches[0].pageX : e.pageX) - this.offsetLeft,
                mouseY = (e.changedTouches ? e.changedTouches[0].pageY : e.pageY) - this.offsetTop;
            drag = true;
            addClick(mouseX, mouseY, false);
            redraw();
        }, false);

        canvas.addEventListener("touchmove", function (e) {
            var mouseX = (e.changedTouches ? e.changedTouches[0].pageX : e.pageX) - this.offsetLeft,
                mouseY = (e.changedTouches ? e.changedTouches[0].pageY : e.pageY) - this.offsetTop;
            if (drag) {
                addClick(mouseX, mouseY, true);
                redraw();
            }
            e.preventDefault()
        }, false);

        canvas.addEventListener("touchend", function (e) {
            drag = false;
            redraw();
        }, false);

        canvas.addEventListener("touchcancel", function (e) {
            drag = false;
        }, false);

        $('#carouselPrev').click(function () {
            let container = document.getElementById('preExaminationImagesWrapper');
            container.scrollBy({ left: -160, behavior: 'smooth' });
        });

        $('#carouselNext').click(function () {
            let container = document.getElementById('preExaminationImagesWrapper');
            container.scrollBy({ left: 160, behavior: 'smooth' });
        });

        LoadPrescImages();
    }

    function LoadPrescImages() {
        $('.PreImages').empty();
        clickX = [];
        clickY = [];
        clickDrag = [];
        var canvas = document.getElementById('canvas');
        ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        $("#CanvasExaminationImgEditorId").val("");
        GetAllImages();
    }

    function GetAllImages() {
        var ConultCode = '<%: Session["RMOYN"] ?? "" %>' == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" ? sessionStorage.getItem("ConsultDoctorCode") : ""; 
        startLoading("Loading", "loading-Examinations-Image-Editor");
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/RetriveAllImages?ConultCode=' + ConultCode,
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: true,
            success: function (ImageData) {
                LoadSavedExaminationImageInEditor(ImageData);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Examinations-Image-Editor");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function LoadSavedExaminationImageInEditor(NewImageData) {
        var strmrno = sessionStorage.getItem('PatMRNO');
        var strtranNo = sessionStorage.getItem('PatTRANNO');
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/RetriveExamImages',
            aync: true,
            data: {
                MrNo: strmrno,
                TranNo: strtranNo
            },
            success: function (ImageData) {
                var imageStr = '';
                if (ImageData.length > 0) {
                    $.each(ImageData, function (index, element) {
                        var fileNo = element.split("|");
                        var strUrl = "data:image/png;base64," + fileNo[1];
                        imageStr += `
                        <div class="flex-shrink-0 newlyAddedImage" style="width:150px; cursor:pointer;">
                           <img src="${strUrl}" id="${fileNo[0]}"
                            class="img-thumbnail"
                            style="width:150px; height:100px;" onclick="ChangeImage(this)">
                       </div>`;
                    });

                }
                RetriveExaminationImages(imageStr);
                stopLoading("loading-Examinations-Image-Editor");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Examinations-Image");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function RetriveExaminationImages(imageStr) { //priyanka 11/04/2026
        var strmrno = sessionStorage.getItem('PatMRNO');
        var strtranNo = sessionStorage.getItem('PatTRANNO');
        var ConultCode = '<%: Session["RMOYN"] ?? "" %>' == "Y" || '<%: Session["AUTHYN"] ?? "" %>' == "Y" ? sessionStorage.getItem("ConsultDoctorCode") : ""; 

        $.ajax({
            type: 'POST',
            url: '../SinglePage/RetriveUploadedExamImages',
            aync: true,
            data: {
                MrNo: strmrno,
                TranNo: strtranNo,
                ConultCode: ConultCode,
            },
            success: function (ExamImgData) {
                //var imageStr = '';
                if (ExamImgData.length > 0) {
                    $.each(ExamImgData, function (index, element) {
                        var fileNo = element.split("|");
                        var strUrl = "data:image/png;base64," + fileNo[1];
                        imageStr += `
                        <div class="flex-shrink-0 " style="width:150px; cursor:pointer;">
                            <img src="${strUrl}"
                             class="img-thumbnail"
                             style="width:150px; height:100px;" onclick="ChangeImage(this)">
                        </div>`;
                    });
                }
                $('#preExaminationImagesWrapper').html(imageStr);
                $('#preExaminationImagesWrapper').scrollLeft(0);
                stopLoading("loading-Examinations-Image-Editor");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Examinations-Image");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function ChangeImage(obj) {
        var strUrl = $(obj).attr('src');
        var strId = $(obj).attr('id') || "";
        $("#CanvasExaminationImgEditorId").val(strId);
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        clickX = [];
        clickY = [];
        clickDrag = [];
        imageObj = new Image();
        imageObj.onload = function () {
            ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height);
        };
        imageObj.src = strUrl;
        canvas.addEventListener('mousedown', mouseDown, false);
        canvas.addEventListener('mouseup', mouseUp, false);
        canvas.addEventListener('mousemove', mouseMove, false);
        $('.PreImages').children().removeClass('activeExaminationImage');
        $(obj).parent().addClass('activeExaminationImage');
        EnableField();
        $("#SaveImages").show();
    }

    function DisableField() {
        $('#clearCanvasSimple').attr('disabled', true);
        $('#SaveImages').attr('disabled', true);
    }

    function EnableField() {
        $('#clearCanvasSimple').attr('disabled', false);
        $('#SaveImages').attr('disabled', false);
    }

    function addClick(x, y, dragging) {
        clickX.push(x);
        clickY.push(y);
        clickDrag.push(dragging);
        $("#SaveImages").show();
    }

    function init() {
        imageObj = new Image();
        imageObj.onload = function () { ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height); };
        imageObj.src = "";
        canvas.addEventListener('mousedown', mouseDown, false);
        canvas.addEventListener('mouseup', mouseUp, false);
        canvas.addEventListener('mousemove', mouseMove, false);
    }

    function mouseDown(e) {
        var pos = getMousePos(canvas, e);
        drag = true;
        addClick(pos.x, pos.y);
    }

    function mouseUp() {
        drag = false;
    }

    function mouseMove(e) {
        if (drag) {
            var pos = getMousePos(canvas, e);
            ctx.drawImage(imageObj, 0, 0, canvas.width, canvas.height);
            addClick(pos.x, pos.y, true);
            redraw();
        }
    }

    function getMousePos(canvas, evt) {
        var rect = canvas.getBoundingClientRect();
        return {
            x: (evt.clientX - rect.left),
            y: (evt.clientY - rect.top)
        };
    }

    function redraw() {
        ctx.strokeStyle = "#df4b26";
        ctx.lineJoin = "round";
        ctx.lineWidth = 2;

        for (var i = 0; i < clickX.length; i++) {
            ctx.beginPath();
            if (clickDrag[i] && i) {
                ctx.moveTo(clickX[i - 1], clickY[i - 1]);
            } else {
                ctx.moveTo(clickX[i] - 1, clickY[i]);
            }
            ctx.lineTo(clickX[i], clickY[i]);
            ctx.closePath();
            ctx.stroke();
        }
    }

    function resizeCanvas(strUrl) {

        imageObjNew = new Image();
        imageObjNew.src = strUrl
        ctx.drawImage(imageObjNew, 0, 0, canvas.width, canvas.height);
    }

    function saveExaminImages() {
        var Pic = document.getElementById('canvas').toDataURL("image/png");
        Pic = Pic.replace(/^data:image\/(png|jpg);base64,/, "");
        var strmrno = sessionStorage.getItem('PatMRNO');
        var strtranNo = sessionStorage.getItem('PatTRANNO');
        var imagesData = [];
        $('#preExaminationImagesWrapper img').each(function () {
            if ($(this).attr('id') && $(this).attr('id') != "") {
                if ($(this).attr('id') == $("#CanvasExaminationImgEditorId").val()) {
                    imagesData.push({
                        Id: $(this).attr('id'),
                        Src: Pic
                    });
                    Pic = "";
                }
                else {
                    imagesData.push({
                        Id: $(this).attr('id'),
                        Src: $(this).attr('src')
                    });
                }
            }
        });
        var datatosend = {
            imageData: Pic,
            MrNo: strmrno,
            TranNo: strtranNo,
            existingImages: imagesData
        };
        startLoading("Loading", "loading-Examinations-Image-Editor");
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/Save_Picture',
            data: JSON.stringify(datatosend),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                if (response && response.toUpperCase().indexOf("SUCCESSFUL") !== -1) {
                    CloseExaminationImageEditorPopup("ExaminationImageEditor");
                    LoadSavedExamImages();
                }
                ToastMsg(response, "success");
                stopLoading("loading-Examinations-Image-Editor");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Examinations-Image-Editor");
                ToastMsg(textStatus, "error");
            }
        });
    }

    function OpenImage(obj, e) {
        var largeImage = $(obj).children();
        var url = $(largeImage).attr('src');
        NAME = obj.innerText;
        var MRNO = sessionStorage.getItem('PatMRNO');
        var url = "../DoctorDesk/DisplayFile?path=" + url;
        window.open(url);
    }

    function RemoveImages(obj, e) {
        var imgSource = $(obj).next().find('img').attr('src');
        var strfilename = $(obj).next().find('img').attr('id');
        var strmrno = sessionStorage.getItem('PatMRNO');
        var strtranNo = sessionStorage.getItem('PatTRANNO');
        datatosend = {
            MrNo: strmrno,
            TranNo: strtranNo,
            FileName: strfilename
        }
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/RemoveExaminationFile',
            data: datatosend,
            async: false,
            success: function (ImageData) {
                if (ImageData.indexOf("Success") > -1) {
                    $(obj).parent().remove();
                    if ($("#DivExaminationImages").children().length === 0)
                        NoDataFound("No Data Found.", "DivExaminationImages", "NoDataFoundStyle2", "NoDataFoundStyle2h2");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
        e.stopPropagation();
    }

    function LoadSavedExamImages() {
        var strmrno = sessionStorage.getItem('PatMRNO');
        var strtranNo = sessionStorage.getItem('PatTRANNO');
        startLoading("Loading", "loading-Examinations-Image");
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/RetriveExamImages',
            aync: true,
            data: {
                MrNo: strmrno,
                TranNo: strtranNo
            },
            success: function (ImageData) {
                $('#DivExaminationImages').empty();
                if (ImageData.length > 0) {
                    $.each(ImageData, function (index, element) {
                        var fileNo = element.split("|");
                        var strUrl = "data:image/png;base64," + fileNo[1];
                        var imageStr = `
                         <div class="col-md-6" style="background:#f5f5f5;">
                            <div class="jconfirm-closeIcon"
                                 onclick="RemoveImages(this,event);">
                                <i class="fa fa-trash-o"></i>
                            </div>
                            <div class="thumbnail">
                                <img style="width:100%" id="${fileNo[0]}" src="${strUrl}"/>
                            </div>
                        </div>`;

                        $('#DivExaminationImages').append(imageStr);
                    });
                }
                else {
                    NoDataFound("No Data Found.", "DivExaminationImages", "NoDataFoundStyle2", "NoDataFoundStyle2h2");
                }
                stopLoading("loading-Examinations-Image");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                stopLoading("loading-Examinations-Image");
                ToastMsg(textStatus, "error");
            }
        });
    }
</script>

<%-- Examination History --%>
<script type="text/javascript">
function HistPopExaminationTemp(AllHistoryData, ContentID) {

    var ConsultLst =
        AllHistoryData[0] || [];

    var ExaminationLst =
        AllHistoryData[5] || [];

    var isVisitCompleted =
        (typeof SessionCompExam !== 'undefined' &&
            SessionCompExam === "Y");

    var currentExamText =
        ($("#Exam_Freetext").val() || "").trim();

    var currentPastHistText =
        ($("#Exam_HistoryFreetext").val() || "").trim();

    var $container =
        $('<div class="history-list-wrapper"></div>');

    for (var i = 0; i < ConsultLst.length; i++) {

        var consult = ConsultLst[i];

        if (
            !consult.TRANNO ||
            consult.TRANNO ==
            sessionStorage.getItem("PatTRANNO")
        )
            continue;

        // =====================================
        // Find Examination Rows
        // =====================================

        var examRow = null;

        var pastHistRow = null;

        for (var j = 0; j < ExaminationLst.length; j++) {

            if (
                ExaminationLst[j].TRANNO ===
                consult.TRANNO
            ) {

                if (
                    ExaminationLst[j].EXAM &&
                    !examRow
                ) {

                    examRow =
                        ExaminationLst[j];
                }

                if (
                    ExaminationLst[j].PASTHIST &&
                    !pastHistRow
                ) {

                    pastHistRow =
                        ExaminationLst[j];
                }
            }
        }

        var examText =
            examRow ? examRow.EXAM : "";

        var pastHistText =
            pastHistRow ? pastHistRow.PASTHIST : "";

        if (!examText && !pastHistText)
            continue;

        // =====================================
        // Copy All Check
        // =====================================

        var examCopied =
            examText &&
            currentExamText === examText;

        var pastHistCopied =
            pastHistText &&
            currentPastHistText === pastHistText;

        var allCopied =
            (
                (!examText || examCopied) &&
                (!pastHistText || pastHistCopied)
            );

        // =====================================
        // Main Panel
        // =====================================

        var $panel =
            $('<div class="History-panel mb-3"></div>');

        // =====================================
        // Header
        // =====================================

        var $panelHead =
            $('<div class="History-header d-flex justify-content-between align-items-center p-3"></div>');

        // =====================================
        // Left Header
        // =====================================

        var $leftDiv =
            $('<div class="d-flex align-items-center flex-grow-1"></div>');

        var docText =
            (consult.DOCTNAME
                ? "Dr. " + consult.DOCTNAME
                : "") +
            (consult.SPECNAME
                ? " (" + consult.SPECNAME + ")"
                : "");

        var $docDiv =
            $('<div class="History-doctor"></div>')
                .text(docText);

        var $dateDiv =
            $('<div class="History-date mt-1"></div>')
                .text(
                    consult.TRANDATE +
                    " " +
                    ConvertTo12Hour(
                        "O",
                        consult.TRANTIME
                    )
                );

        $leftDiv.append(
            $('<div></div>').append(
                $docDiv,
                $dateDiv
            )
        );

        // =====================================
        // Right Header
        // =====================================

        var $rightDiv =
            $('<div class="d-flex align-items-center"></div>');

        var $copyDiv = $();

        if (!isVisitCompleted) {

            if (allCopied) {

                $copyDiv = $(`
                <button class="btn btn-sm btn-outline-success"
                        style="background:#dbfdf8;"
                        disabled>

                    <i class="fa fa-check text-success"></i>

                </button>
            `);
            }
            else {

                $copyDiv = $(`
                <button class="btn btn-sm btn-outline-primary copy-all-btn">

                    <i class="fa fa-copy"></i> Copy All

                </button>
            `);
            }
        }

        $rightDiv.append($copyDiv);

        $panelHead.append(
            $leftDiv,
            $rightDiv
        );

        // =====================================
        // Body
        // =====================================

        var $panelBody =
            $('<div class="History-body p-2"></div>');

        // =====================================
        // Examination Section
        // =====================================

        if (examText) {

            var examActionBtn = "";

            if (
                !isVisitCompleted &&
                currentExamText !== examText
            ) {

                examActionBtn = `
                <button class="btn btn-link btn-sm p-0 copy-row-btn"
                        title="Copy to List">

                    <i class="fa fa-clone text-primary"></i>

                </button>
            `;
            }
            else if (currentExamText === examText) {

                examActionBtn = `
                <span class="text-success mr-2">

                    <i class="fa fa-check-circle"></i>

                </span>
            `;
            }

            var examHtml = `

            <div class="History-section">

                <label>
                    <b>Examination</b>
                </label>

                <div class="History-row
                            d-flex
                            justify-content-between
                            align-items-start
                            p-2
                            border-bottom">

                    <div class="flex-grow-1">

                        <textarea class="History-textarea exam-History-textarea"
                                  readonly>${examText}</textarea>

                    </div>

                    <div class="ml-2">

                        ${examActionBtn}

                    </div>

                </div>

            </div>
        `;

            $panelBody.append(examHtml);
        }

        // =====================================
        // Other Examination History
        // =====================================

        if (pastHistText) {

            var pastActionBtn = "";

            if (
                !isVisitCompleted &&
                currentPastHistText !== pastHistText
            ) {

                pastActionBtn = `
                <button class="btn btn-link btn-sm p-0 copy-row-btn"
                        title="Copy to List">

                    <i class="fa fa-clone text-primary"></i>

                </button>
            `;
            }
            else if (currentPastHistText === pastHistText) {

                pastActionBtn = `
                <span class="text-success mr-2">

                    <i class="fa fa-check-circle"></i>

                </span>
            `;
            }

            var pastHtml = `

            <hr style="margin:0;">

            <div class="History-section mt-2">

                <label>
                    <b>Other Examination History</b>
                </label>

                <div class="History-row
                            d-flex
                            justify-content-between
                            align-items-start
                            p-2
                            border-bottom">

                    <div class="flex-grow-1">

                        <textarea class="History-textarea examother-History-textarea"
                                  readonly>${pastHistText}</textarea>

                    </div>

                    <div class="ml-2">

                        ${pastActionBtn}

                    </div>

                </div>

            </div>
        `;

            $panelBody.append(pastHtml);
        }

        // =====================================
        // Append Panel
        // =====================================

        $panel.append(
            $panelHead,
            $panelBody
        );

        $container.append($panel);
    }

    if (ContentID) {

        $('#' + ContentID).html($container);
    }

    return $container.html();
}

function CopyFuncExamination() {

    $(".exam-History-textarea, .examother-History-textarea")
        .each(function () {

            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";

        });

    $(".copy-row-btn")
        .off("click")
        .on("click", function () {

            var $btn = $(this);

            var $row =
                $btn.closest(".History-row");

            if (
                $row.find(".exam-History-textarea").length > 0
            ) {

                $("#Exam_Freetext").val(
                    $row.find(".exam-History-textarea").val()
                );

                autoResizeTextareaForSinglePage(
                    document.getElementById("Exam_Freetext")
                );
            }

            if (
                $row.find(".examother-History-textarea").length > 0
            ) {

                $("#Exam_HistoryFreetext").val(
                    $row.find(".examother-History-textarea").val()
                );

                autoResizeTextareaForSinglePage(
                    document.getElementById("Exam_HistoryFreetext")
                );
            }

            $btn.html(
                '<i class="fa fa-check text-success"></i>'
            )
                .removeClass("copy-row-btn")
                .prop("disabled", true);

            CheckAndUpdateCopyAllButtonExamination(
                $btn.closest(".History-panel")
            );
        });

    $(".copy-all-btn")
        .off("click")
        .on("click", function () {

            var $btn = $(this);

            var $panel =
                $btn.closest(".History-panel");

            var examText =
                $panel.find(".exam-History-textarea")
                    .val() || "";

            var pastHistText =
                $panel.find(".examother-History-textarea")
                    .val() || "";

            $("#Exam_Freetext").val(examText);

            $("#Exam_HistoryFreetext")
                .val(pastHistText);

            autoResizeTextareaForSinglePage(
                document.getElementById("Exam_Freetext")
            );

            autoResizeTextareaForSinglePage(
                document.getElementById("Exam_HistoryFreetext")
            );

            $panel.find(".copy-row-btn")
                .each(function () {

                    $(this)
                        .html(
                            '<i class="fa fa-check text-success"></i>'
                        )
                        .removeClass("copy-row-btn")
                        .prop("disabled", true);

                });

            $btn.html(
                '<i class="fa fa-check text-success"></i>'
            )
                .removeClass("copy-all-btn")
                .prop("disabled", true);
        });
}


function CheckAndUpdateCopyAllButtonExamination($panel) {

    var remainingButtons =
        $panel.find(".copy-row-btn").length;

    if (remainingButtons === 0) {

        var $copyAll =
            $panel.find(".copy-all-btn");

        if ($copyAll.length > 0) {

            $copyAll.html(
                '<i class="fa fa-check text-success"></i>'
            )
                .removeClass("copy-all-btn")
                .prop("disabled", true);
        }
    }
}
</script>

<%--Setup Popup--%>
<script type="text/javascript">
    function SetupPopupExaminationContent() {
        return `
         <div class="FilterClassDivPopup">
         <button class="btn btn-primary" onclick="ValidationForSetupExamBindTran('Setup_Examination')"><i class="fa fa-save"></i> Apply</button>
         <img src="../Images/Singlepage/Plus.png" alt="Add" style="width:34px; height:34px; cursor:pointer; object-fit:contain;" title="Add New Setup" onclick="OpenPopupForNewItem('Examination', 'ExaminationSetup')">
         </div>
         <div id="SetupMainListTable"></div>
         <div id="loading-Setup-Setting" class="loading-screen" style="display: none; opacity: 0;"></div>
        `;
    }

    function CreateTabulatorExamSetup(TabulatorSetupId) {
        var SetupExamListTable = new Tabulator(("#" + TabulatorSetupId), {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "auto",
            index: "code",
            columns: [
                {
                    title: "Action",
                    field: "act",
                    width: 100,
                    headerSort: false,
                    hozAlign: "center",
                    // This allows the column to contain HTML
                    formatter: function (cell, formatterParams, onRendered) {
                        return `
            <div style="display: flex; gap: 15px; justify-content: center; align-items: center;">
                <input type="checkbox" class="row-checkbox" style="cursor:pointer; width:16px; height:16px;">
                <i class="fa fa-pencil text-primary edit-row" style="cursor:pointer; font-size: 16px;" title="Edit"></i>
            </div>
        `;
                    },
                    cellClick: function (e, cell) {
                        var row = cell.getRow();
                        var target = e.target;
                        var rowData = cell.getRow().getData();
                        if (target.classList.contains("row-checkbox")) {
                            var isChecked = target.checked;
                            var newValue = isChecked ? "Y" : "N";
                            row.update({ CHECKYN: newValue });
                        }
                        if (target.classList.contains("edit-row")) {
                            OpenPopupForNewItem('Examination', 'ExaminationSetup');
                            BindExaminationEditSetup(rowData)
                        }
                    }
                },
                { title: "CHECKYN", field: "CHECKYN", visible: false },
                { title: "Code", field: "code", visible: false },
                {
                    title: "Name",
                    field: "name",
                    editor: false,
                    formatter: "textarea",
                    formatterParams: {
                        minHeight: "auto",
                    },
                    cssClass: "wrap-text"
                }
            ]
        });
        BindExaminationSetupList(TabulatorSetupId);
    }

    function BindExaminationSetupList(TabulatorSetupId) {
        $.ajax({
            type: "POST",
            url: "<%=Url.Action("GetExamSetupList","DoctorDesk")%>",
            data: {},
            asycn: false,
            success: function (response) {
                if (response != "Unsucessfull") {
                    var result = JSON.parse(response);

                    if (result.Table1 && result.Table1.length > 0) {

                        var formattedData = result.Table1.map(function (row) {
                            return {
                                CHECKYN: "N",
                                code: row.CODE,
                                name: row.DESC
                            };
                        });
                        var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

                        if (table) {
                            table.setData(formattedData);
                        }
                    }
                }
            }
        });
    }

    function ValidationForSetupExamBindTran(TabulatorSetupId) {
        var SelCode = "";
        var table = Tabulator.findTable("#" + TabulatorSetupId)[0];

        if (table) {
            // 1. Get all current data from the table
            var TableAllData = table.getData();
            SelCode = TableAllData
                .filter(function (row) {
                    return row.CHECKYN === "Y";
                })
                .map(function (row) {
                    return row.code;
                })
                .join(",");
            SetExamSetupToTxtExam(SelCode);
        }
    }

    function SetExamSetupToTxtExam(strCode) {
        $.ajax({
            url: '../DoctorDesk/GetExamSetupDataByCode',
            data: { strSetUpCode: strCode },
            type: 'post',
            datatype: 'get',
            async: true,
            success: function (response) {
                if (response != "") {
                    for (i = 0; i < response.length; i++) {
                        if ($("#Exam_Freetext").val() == "") {
                            $("#Exam_Freetext").val($("#Exam_Freetext").val() + '\n' + response[i]);
                        }
                        else {
                            $("#Exam_Freetext").val($("#Exam_Freetext").val() + '\n\n' + response[i]);
                        }
                    }
                    autoResizeTextareaForSinglePage(document.getElementById('Exam_Freetext'));
                    closeMaxMinPopup('Hist_M_Examination');
                }
            }
        })
    }

    function ContentForAddNewItemExaminatonSetup() {
        return `
        <div class="mb-3">
                 <input id="txtSetupNameCode" type="text" class="form-control " style="display:none" />
               </div>
        <div class="mb-3">
          <input id="txtSetupName" type="text" class="form-control SetupName" maxlength="250" autocomplete="off" placeholder="Enter Setup Name" tabindex="2" />
        </div>
        <div class="mb-3">
          <textarea id="txtExamSetup" type="text" class="form-control ExaminationSetup"  autocomplete="off" placeholder="Enter Examination" tabindex="2" > </textarea>
        </div>
    `;
    }

    function FooterContentForAddNewItemExaminatonSetup() {
        return `
        <button class="btn btn-primary" onclick="SaveNewItemForExaminationSetup('Complaints')" tabindex="4">Save</button>
        `;
    }

    function BindExaminationEditSetup(RowData) {
        $.ajax({
            url: '../DoctorDesk/GetExamSetupDataByCode',
            data: { strSetUpCode: RowData.code },
            type: 'post',
            datatype: 'get',
            async: true,
            success: function (response) {
                if (response != "") {
                    $("#txtSetupNameCode").val(RowData.code);
                    $("#txtSetupName").val(RowData.name);
                    $("#txtExamSetup").val(response);
                }
            }
        });
    }

    //Validation For New Item Complaints
    function ValidationForNewItemExaminationSetup() {
        if ($("#txtSetupName").val().trim().length === 0) {
            ToastMsg("Enter Setup Name", "warning");
            $("#txtSetupName").focus();
            return false;
        }
        if ($("#txtExamSetup").val().trim().length === 0) {
            ToastMsg("Enter Examination Setup", "warning");
            $("#txtExamSetup").focus();
            return false;
        }
        return true;
    }
    //Save For New Item Complaints
    function SaveNewItemForExaminationSetup() {
        if (ValidationForNewItemExaminationSetup() == true) {
            $.ajax({
                type: "post",
                datatype: "json",
                url: '../DoctorDesk/AddExaminationSetUp',
                data: { strSetUpName: $("#txtSetupName").val(), strExamSetupTempData: $("#txtExamSetup").val(), strSetUpCode: $("#txtSetupNameCode").val() },
                success: function (response) {
                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                        ToastMsg(response, "success");
                        BindExaminationSetupList('Setup_Examination');
                        closeAddNewItemPopup('ExaminationSetup');
                    }
                    else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {
                        ToastMsg("This Set Up is already Present.", "warning");
                    }
                    else {
                        ToastMsg("Error!!Please Contact IT Dept.", "error");
                    }
                }
            });
        }
    }

    function fitToContent(id) {
        var textArea = document.getElementById(id);


        textArea.style.height = 'auto';


        var newHeight = Math.ceil(textArea.scrollHeight);

        textArea.style.height = newHeight + 'px';
        textArea.style.overflow = 'hidden';
    }

    function setMaxHeight(id) {
        var textArea = document.getElementById(id);
        if (!textArea) return;

        textArea.style.height = "400px";
        textArea.style.overflowY = "auto";
    }
</script>
<script>
    function HASDataInExamination() { //priyanka 16/04/2026
        var ExaminationHistFreeTxt = $("#Exam_HistoryFreetext").val();
        var ExaminationFreeTxt = $("#Exam_Freetext").val();
        if ((ExaminationHistFreeTxt === "" || ExaminationHistFreeTxt === null) && (ExaminationFreeTxt === "" || ExaminationFreeTxt == null ) ) {
            return false;
        }
        else {
            return true;
        }
    }
</script>
<div id="sec-exam" class="opd-section-card anchor-offset">
    <div class="d-flex justify-content-between mb-3">
        <h4 class="section-title">Examination</h4>
        <div>
            <button class="btn btn-outline-success btn-sm" id="Exam_PrevHistory" onclick="HistoryPopupOpen('Examination History', 'Examination')"><i class="fa fa-history"></i></button>
            <button class="btn btn-outline-success btn-sm" id="Exam_Emplate" onclick="SetupPopupOpen('Examination','Examination',false)">Setup</button>
        </div>
    </div>

    <div class="d-flex align-items-center justify-content-between">
        <h6 class="fw-bold">Enter The Examination</h6>
        <div class="text-end mb-2">
            <select class="form-select form-select-sm d-inline-block w-auto" id="ddlExamTemplate">
                <option value="">---Select---</option>
                <option value="SYS">Systemic Examinations</option>
                <option value="RHEU">Rheumatoloy</option>
                <option value="OP1">Opthal_1</option>
                <option value="OP2">Opthal_2</option>
                <option value="OP3">Opthal_3</option>
                <option value="RESP">Respiratory Medicine</option>
            </select>
        </div>
    </div>
    <textarea class="form-control TextAreaBorder" id="Exam_Freetext" name="Exam_Freetext" oninput="autoResizeTextareaForSinglePage(this);" onchange="autoResizeTextareaForSinglePage(this);"
        style="height: 100px; overflow-y: auto; resize: none; display: block;">
</textarea>
    <%--Added By Abhishesh || 20260321--%>
    <div class="text-end mb-4">
        <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnEXFitToContent" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
        <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnEXSetMaxHeight" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer;" />
    </div>
    <%--End--%>

    <!-- Examination Images Card -->
    <div class="card mb-3">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0">Examination Images</h6>
            <div>
                <button type="button" class="btn btn-light btn-sm me-1" onclick="OpenExaminationImageEditorPopup()"
                    title="Add Examination Images" id="imgOpenExaminationImageEditorPopup">
                    <i class="fa fa-image fa-lg text-success"></i>
                </button>

                <button class="btn btn-light btn-sm" type="button" id="BtnExaminationImageToggle">
                    <i class="fa fa-chevron-down"></i>
                </button>
            </div>
        </div>

        <div id="DivExaminationImagesContainer" style="display: none;">
            <div class="card-body position-relative">
                <div id="DivExaminationImages" class="row g-2 mt-2"></div>
                <div id="loading-Examinations-Image" class="loading-screen" style="display: none; opacity: 0;"></div>
            </div>
        </div>
    </div>

    <div class="d-flex align-items-center justify-content-between">
        <h6 class="fw-bold"><%--Other Examination History--%></h6>
        <div class="text-end mb-2">
            <select class="form-select form-select-sm d-inline-block w-auto" id="ddlHistoryTemplate">
                <option value="">---Select---</option>
                <option value="GYNAC">Gynac</option>
                <option value="OBST">OBST</option>
            </select>
        </div>
    </div>
    <textarea class="form-control TextAreaBorder" id="Exam_HistoryFreetext" name="Exam_HistoryFreetext"
          placeholder="Enter Other Examination History" oninput="autoResizeTextareaForSinglePage(this);"
        onchange="autoResizeTextareaForSinglePage(this);"
        style="height: 100px; overflow-y: auto; resize: none;">
</textarea>
    <%--Added By Abhishesh || 20260321--%>
    <div class="text-end mb-4">
        <img src="<%= Url.Content("~/images/singlepage/SortAscending.png") %>" id="btnEXFittoContent2" title="Fit to Content" style="width: 35px; height: 30px; cursor: pointer;" />
        <img src="<%= Url.Content("~/images/singlepage/SortDescending.png") %>" id="btnEXSetMaxHeight2" title="Set Max Height" style="width: 35px; height: 30px; cursor: pointer;" />
    </div>
    <%--End--%>
    <div id="loading-Examinations" class="loading-screen"
        style="display: none; opacity: 0;">
    </div>
</div>
