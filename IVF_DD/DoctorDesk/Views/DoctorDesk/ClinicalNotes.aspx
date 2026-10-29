<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>

        table {
            width: 100%;
        }

        thead, tbody, tr, td, th {
        }

            tr:after {
                content: ' ';
                display: block;
                visibility: hidden;
                clear: both;
            }

            thead th {
                height: 30px;
                text-align: left;
            }

        tbody {
            max-height: 280px;
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

        .thumbnail {
            cursor: pointer;
        }

        .jconfirm-closeIcon {
            position: absolute;
            top: 4px;
            right: 21px;
            cursor: pointer;
            text-align: center;
            font-size: 18px !important;
            line-height: 14px !important;
            display: none;
           
        }
    </style>
    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script src="../Scripts/PatList.js"></script>
    <script type="text/javascript">

        var urls = "<%=Url.Action("GetDctrClinic","Account")%>";
        var idOfDMY = "";
        var exam = "";
        var addExamImageClicked = "N";//added on 22nd march 2018
        var HideECGRow = '<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("HideECGRow")%>';
        $(document).ready(function (e) {
            HoldOn.open();//
            SetPatientDtl();
            document.getElementById('txtexam').focus();
            // AddClinics(urls);//commented vijeta 30/4/19
            GetChemoNotes();
            GetAllImages();
            if ($(window).width() >= 996) {
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

                var dispLst = document.getElementById('sideList');
                //kavita 12-aug-2019
                // dispLst.style.display = "block";  
                $("#slide_sdList").click();

                //$("#shortCutMenus").css("display", "block");// added by vijeta on 17th april 2018
                ActiveMenu("PresClinicalNotes");
            }
            if ($(window).width() >= 1200) {
                $("#tabMenu").css("display", "block");
            }

            $("#myBtn").click(function () {
                Save();
            });
            $("#btnPlanning").fancybox({
                  
                //type: 'ajax',
                openEffect: 'elastic',
                openSpeed: 100,
                closeEffect: 'elastic',
                closeSpeed: 100,
                helpers: {
                    overlay: { closeClick: false }
                },
                autoDimensions: false,
                width: '80%',        // 80% of viewport width
                height: '80%%',       // 80% of viewport height
                fitToView: true,
                aspectRatio: false,
                cyclic: true,
                showNavArrows: true,
                autoSize: false,
                scrolling: 'auto'
            });

            $("#copyPrevNotes").click(function () {
                if ($.session.get('PatMRNO') == "" || $.session.get('PatMRNO') == null) {
                    $.messager.alert("Alert", "Please Select Patient.");
                    return false;
                }
                PatMedicationHistory();
                $("a#btnPlanning").click();
            });

            //Meenakshi added on 8th dec 2023 to add personalised setup for examination
            $("#btnPersonalized").click(function () {
                CreatePersonalizedList()
            });
            // ----//

            $("#btnAddSysExam").click(function () {
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
                    strPrindData.push("  ECG					            :	Done / Not Done  - With In Normal limits\n");
                $("#txtexam").val($("#txtexam").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
            });

            $("#btnAddGynac").click(function () {
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

                $("#txtothrHist").val($("#txtothrHist").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtothrHist").val($("#txtothrHist").val() + strPrindData1.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
            });

            $("#btnAddObstractic").click(function () {
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

                //var strPrindData2= [];
                //strPrindData2.push("  General Condition : \n\n");
                //strPrindData2.push("  Systemic Examination : \n");
                //strPrindData2.push("\t\t 1.  Cardiovascular System		:	NAD\n");
                //strPrindData2.push("\t\t 3.  Respiratory System		        :	NAD\n");
                //strPrindData2.push("\t\t 4.  Per Abdomen			        :	NAD\n\n");
                //strPrindData2.push("  Local Examination : Not Applicable\n\n");
                $("#txtothrHist").val($("#txtothrHist").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtothrHist").val($("#txtothrHist").val() + strPrindData1.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                //$("#txtothrHist").val($("#txtothrHist").val() + strPrindData2.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
            });

            $("#btnRheumatoloy").click(function () {
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
                $("#txtexam").val($("#txtexam").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtexam").val($("#txtexam").val() + strPrindData1.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
            });

            $("#Opthal1").click(function () {
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
                $("#txtexam").val($("#txtexam").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtexam").val($("#txtexam").val() + strPrindData1.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
            });

            $("#Opthal2").click(function () {
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

                $("#txtexam").val($("#txtexam").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtexam").val($("#txtexam").val() + strPrindData1.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
            });

            $("#Opthal3").click(function () {
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

                $("#txtexam").val($("#txtexam").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtexam").val($("#txtexam").val() + strPrindData1.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtexam").val($("#txtexam").val() + strPrindData2.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
            });

            $("#RespMed").click(function () {
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
                $("#txtexam").val($("#txtexam").val() + strPrindData.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtexam").val($("#txtexam").val() + strPrindData1.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));
                $("#txtexam").val($("#txtexam").val() + strPrindData2.toString().replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', ''));

            });

            document.addEventListener('keyup', doc_keyUpForShortCutMenus, false);// added by vijeta on 17th April 2018 for shoetcut keys




        });

        function GetChemoNotes() {
            ////debugger;
            var strTran = ($.session.get('PatTRANNO')).toString();
            var strtype = "1";
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetChemoNotes","DoctorDesk")%>",
                data: { Tran: strTran, Type: strtype },
                success: function (result) {

                    $('#txtexam').empty();

                    if (result != "") {
                        $('#txtexam').val(result[0].CLINICALHIST);
                      
                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();//
                    $.messager.alert("Error", errorThrown);
                }
            });
        }

        //added by Meenakshi on 8th dec 2023 HFH Requirement ////Examination Setup creation, edit and display code end //
        function CreatePersonalizedList() {
            $.confirm({
                title: 'SetUp Examination',
                theme: 'supervan',
                // theme: 'material',
                closeIcon: true,
                offsetTop: 10,
                type: 'orange',
                backgroundDismissAnimation: 'glow',
                //  columnClass: 'col-md-6',
                content: '' +//style added by 
                '<form action="" class="formName" style="height:410px;"><div class="form-group"><table style="width:100%"><tr><td style="width:6%"><label style="background-color: transparent; border-color: transparent;margin-left:0px" class="form-control" id="AdviceSetUpAdd"> <img src="../Images/add.png"  style=" background-color: white;   border-radius: 50%;position:fixed; "></label></td><td><input id="txtInvestigation" type="text" id="input-name" placeholder="Search Advice SetUp" class="form-control" onkeyup="SearchPatAdviceSetUps()"  style="margin-left:10px" ></td></tr></table></div>' +
                '<div id="divtblInvestigation" class="divtblInvestigation" style=""><table id="tblPersInvestigationlist" style="width:100%;border-top:1px solid #29884bd6 !important" class="table"><tbody></tbody></table></div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: '<i class="fa fa-check-circle-o"></i>',
                        btnClass: 'btn-default',
                        action: function () {
                            stringcode = '';
                            var row = $('#tblPersInvestigationlist tr')
                            for (r = 0; r < row.length; r++) {
                                var Chk = $(row[r]).find('.chkPersDis')
                                if (Chk[0].checked) {
                                    //CodeTosend.push($(row[r]).attr('id'));
                                    stringcode += $(row[r]).attr('id') + ','
                                    // stringcode +=  $(row[r]).attr('id') +  ','
                                }
                            }
                            //var codeT = stringcode.slice(1)
                            var strCode = stringcode.substr(0, stringcode.length - 1);
                            SetExamSetupToTxtExam(strCode);
                        }
                    },
                    Closeed: {
                        text: '<i class="fa fa-close "></i>'
                        //close
                    }
                },
                onOpen: function () {
                    $('jconfirm-box').css('margin-top', '10px !important;')
                },
                onContentReady: function () {
                    GetExamSetupList();

                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    var defaultbtn = $('.jconfirm-buttons>button');
                    $.each(defaultbtn, function (index, val) {
                        $(defaultbtn[index]).css('font-size', '35px');
                        $(defaultbtn[index]).css('margin-right', '10px');
                    })
                    $(defaultbtn[0]).attr('id', 'btnSubmit');
                    $(defaultbtn[0]).addClass('disable-clicks');

                    $('.jc-bs3-row').removeClass('row')
                    $('.jconfirm-box-container').removeClass('col-xs-offset-1')
                    $('.jconfirm-box-container').removeClass('col-xs-10');
                    $('.jconfirm-box-container').removeClass('col-md-4');
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                    $('.jconfirm-bg').css('background-color', 'rgba(255, 255, 255, 0.62)');
                    $('.jconfirm-box').css('background-color', 'rgba(43, 43, 60, 0.98)');
                    $('.jconfirm-box').css('box-shadow', 'rgb(62, 62, 50) 0px -1px 14px 4px');

                }
            });

        }

        function PatMedicationHistory(Type) {
            var mrno = $.session.get('PatMRNO');
            $("#tbldiv").empty();

            $.ajax({
                type: "POST",
                url: 'GetPreviousNotes',
                datatype: "json",
                data: { strMrNo: mrno },
                success: function (result) {
                    if (Array.isArray(result) && result.length > 0) {
                        for (var i = 0; i < result.length; i++) {
                            // Panel container
                            var $divPanel = $("<div style='border: 1px solid #ccc; border-radius: 6px; margin-bottom: 10px; overflow: hidden;'></div>");

                            // Panel header
                            var $divPanelHead = $("<div style='background-color: #6c88c4; color: white; padding: 6px 10px; font-weight: bold; display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; font-size: 14px; cursor: pointer;'></div>");
                    
                            var strHeader =
                                "<span style='color: #b9ffb1; font-size: 1.2em;'><i class='fa fa-check' aria-hidden='true'></i></span>" +
                                "<span style='margin-left: 5px;'>Plan No : " + result[i].PLANID + "</span>" +
                                "<span style='margin-left: auto; display: flex; align-items: center;'>" +
                                "Date : " + formatDate(result[i].TRANDATE)
                            "</span>";
                    
                            $divPanelHead.html(strHeader);

                            // Panel body with only Protocol
                            var $divPanelBody = $("<div style='background: #fff; padding: 10px 15px; font-size: 14px; border-top: none;'></div>");

                            var strBody =
                                "<div style='margin-top: 10px;'><b>Clinical Notes:</b><br>" +
                                "<div ondblclick='copyToNotes(this)' style='border: 1px solid #ccc; padding: 10px; background-color: #f9f9f9; font-size: 13px; line-height: 1.6; white-space: pre-wrap;'>" +
                                result[i].CLINICALHIST + "</div></div>";

                            $divPanelBody.html(strBody);

                            // Toggle body visibility on header click
                            $divPanelHead.on('click', function () {
                                $(this).next().slideToggle();
                            });

                            // Append to DOM
                            $divPanel.append($divPanelHead).append($divPanelBody);
                            $("#tbldiv").append($divPanel);
                        }
                    } else {
                        document.getElementById("tbldiv").innerHTML =
                            `<div class='panel'>
                                <div class='panel-body divBody' style="font-size:20px; text-align:center; font-weight:bold; color:#555; white-space:nowrap;">
                                    No History Found for this record
                                </div>
                            </div>`;
                                    }
                }
            });
        }

        function copyToNotes(element)
        {
            var text= $(element).text();
            $('#txtexam').val(text);
            $.fancybox.close(); 

        }

        
        function formatDate(yyyymmdd) {
            if (!yyyymmdd || yyyymmdd.length !== 8) return yyyymmdd; // fallback
            var year = yyyymmdd.substring(0, 4);
            var month = yyyymmdd.substring(4, 6);
            var day = yyyymmdd.substring(6, 8);
            return day + "-" + month + "-" + year;
        }




        function SetExamSetupToTxtExam(strCode) {
            $.ajax({
                url: '../DoctorDesk/GetExamSetupDataByCode',
                data: { strSetUpCode: strCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {

                        for (i = 0; i < response.length; i++) {
                            if ($("#txtexam").val() == "") {
                                $("#l").val($("#txtexam").val() + '\n' + response[i]);
                            }
                            else {
                                $("#txtexam").val($("#txtexam").val() + '\n\n' + response[i]);
                            }
                        }

                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        //added on 4th sep 2018
        $(document.body).on('click', '#AdviceSetUpAdd', function (e) {
            ExamSetUpAddEdit(this);//added on 6th march19
        });

        //added on 5th sep 2018
        function GetAdvicePersonalisedList() {
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetPersPatientAdviceList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);' ></td><td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='ExamSetUpAddEdit(this);'></i></span></td>";//onchange='handleChange(this);;//onchange='handleChange(this);
                            // rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td><input class='chkPersDis' type='checkbox' style='margin-left:10px'></td><td><div class='icheckbox_flat-green' aria-checked='false' aria-disabled='false' style='position: relative;'><input type='checkbox' class='flat-red' style='position: absolute; opacity: 0;'><ins class='iCheck-helper' style='position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div></td><td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table1[i].DESC) + "</td>";

                            rows += "</tr>";
                        }
                        $('#tblPersInvestigationlist tbody').empty();
                        $('#tblPersInvestigationlist tbody').append(rows).closest('tr');
                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();//
                },

            });
        }


        function ExamSetUpAddEdit(obj) {
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label style="font-size:12px">Examination Template SetUp</label>' +
                 '<input  type="varchar" id="txtSetUpNm" maxlength="50"  placeholder="Enter Template Name"  class="setUp form-control" required />' +
                 '<br><textarea id="txtExamSetupVal" autocomplete="off" type="varchar" rows="5"  style="" placeholder="Enter Examination setup" class="form-control"  />' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var setUp = this.$content.find('.setUp').val();
                            var grpCode = "";
                            if (setUp == "") {
                                $.alert('Enter SetUp Name');
                                return false;
                            }

                            if ($("#txtExamSetupVal").val() == "") {
                                $.alert('Please enter setup details.');
                                return false;
                            }

                            //added on 07/03/18
                            var strSetUpCode = "";
                            if ($(obj).hasClass("fa fa-pencil")) {
                                strSetUpCode = $(obj).parents("tr")[0].id;
                            }

                            if (setUp != "" && $("#txtExamSetupVal").val() != "") {

                                $.ajax({
                                    type: "post",
                                    datatype: "json",
                                    url: 'AddExaminationSetUp',
                                    data: { strSetUpName: setUp, strExamSetupTempData: $("#txtExamSetupVal").val(), strSetUpCode: strSetUpCode },
                                    success: function (response) {
                                        if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                            $("#txtSetUpNm").val("");
                                            $("#txtExamSetupVal").val("");
                                            $.alert(response);
                                            GetExamSetupList();
                                        }
                                        else if (("" + response).toUpperCase().indexOf("PRESENT") != -1) {

                                            $.alert("This Set Up is already Present.");
                                        }
                                        else {
                                            $.alert("Error!!Please Contact IT Dept");
                                        }
                                    },

                                });

                            }
                            else {
                                $.messager.alert("Information", "Please select at least one test");
                            }
                        }
                    },
                    close: function () {

                    },
                },
                onContentReady: function () {

                    if ($(obj).hasClass("fa fa-pencil")) {
                        $('#txtSetUpNm').val($(obj).parents('td').prev().text());
                    }
                    else {
                        $('#txtSetUpNm').focus();
                        $('#txtSetUpNm').val("");
                    }

                    var jc = this;

                    $(".jconfirm-box-container").last().css('width', '480px');

                    //added on 6th march 2019
                    if ($(obj).hasClass("fa fa-pencil")) {
                        FillSelectExamnSet($(obj).parents('tr')[0].id);
                    }
                }
            });

        }

        function FillSelectExamnSet(strSetUpCode) {
            HoldOn.open();
            $.ajax({
                url: '../DoctorDesk/GetExamSetupDataByCode',
                data: { strSetUpCode: strSetUpCode },
                type: 'post',
                datatype: 'get',
                success: function (response) {
                    if (response != "") {
                        $("#txtExamSetupVal").val(response[0]);
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                }
            })
        }

        function GetExamSetupList() {
            HoldOn.open();//
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetExamSetupList","DoctorDesk")%>",
                data: {},
                asycn: false,
                success: function (response) {
                    if (response != "Unsucessfull") {
                        var result = JSON.parse(response)
                        var rows = "";
                        for (i = 0; i < result.Table1.length; i++) {
                            rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td style='width:40px !important'><input class='chkPersDis' type='checkbox' style='margin-left:10px;height:20px;width:20px' onchange='handleChange(this);' ></td><td class='InvestigationName' style='padding:5px;font-size: 13px;vertical-align:middle' ><b>" + $.trim(result.Table1[i].DESC) + "</b></td>" + "<td><span><i class='fa fa-pencil' title='Edit' style='cursor:pointer;' onclick='ExamSetUpAddEdit(this);'></i></span></td>";//onchange='handleChange(this);;//onchange='handleChange(this);
                            // rows += "<tr id='" + $.trim(result.Table1[i].CODE) + "'>" + "<td><input class='chkPersDis' type='checkbox' style='margin-left:10px'></td><td><div class='icheckbox_flat-green' aria-checked='false' aria-disabled='false' style='position: relative;'><input type='checkbox' class='flat-red' style='position: absolute; opacity: 0;'><ins class='iCheck-helper' style='position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div></td><td class='MaterialName' style='padding:5px;font-size: 13px;'>" + $.trim(result.Table1[i].DESC) + "</td>";

                            rows += "</tr>";
                        }
                        $('#tblPersInvestigationlist tbody').empty();// added by vijeta on 2nd may 2018
                        $('#tblPersInvestigationlist tbody').append(rows).closest('tr');

                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();//
                },
            });
        }

        ////Examination Setup creation, edit and display code end //

        function Save(str) {
            HoldOn.open();//
            var strTran = ($.session.get('PatTRANNO')).toString();
            var strMr = ($.session.get('PatMRNO')).toString();
            notes = document.getElementById("txtexam").value;
           
            $.ajax({
                type: "POST",
                url: 'SaveClinicalNotes',
                datatype: "json",
                data: { notes: notes, strTranno: strTran, strMrNo: strMr },
                success: function (result) {
                    if(str == 'SS'){
                        if (!result.toUpperCase().includes("SUCCESS"))
                            $.messager.alert("Info", result);
                    }
                    else{
                        if (addExamImageClicked == "N" && str != "Y")
                            window.location.href = 'PatientEntry';
                    }
                   
                },
                complete: function () { HoldOn.close(); },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });


            //}
            //else {
            //    $.messager.alert("Information", "Please Enter Examination");
            //    // alert('Please Enter Examination');
            //}
        }

        //Save on back button
        jQuery(document).ready(function ($) {

            if (window.history && window.history.pushState) {

                window.history.pushState('forward', null, './ClinicalNotes');

                $(window).on('popstate', function () {
                    SaveExamination();
                });
            }
        });

        function LoadPrescImages() {
            addExamImageClicked = "Y"; //added on 22nd march 2018
            SaveExamination();//added on 22nd march 2018
            window.location.href = '../DoctorDesk/PrecriptionImages';
        }

        function GetAllImages() {
            var strmrno = ($.session.get('PatMRNO')).toString();;
            var strtranNo = ($.session.get('PatTRANNO')).toString();

            datatosend = {
                MrNo: strmrno,
                TranNo: strtranNo
            }

            $.ajax({
                type: 'POST',
                url: 'RetriveExamImages',
                data: datatosend,
                async: true,
                success: function (ImageData) {
                    var imageStr = '';
                    $.each(ImageData, function (index, element) {
                        //var strfilename = element.replace(/^.*[\\\/]/, '');
                        var fileNo = element.split("|");
                        // var strUrl = element + '/PrescriptionImages/' + strmrno + '/' + strtranNo + '/' + strfilename;
                        var strUrl = "data:[<media type>];charset=utf-8;base64," + fileNo[1];
                        imageStr += '<div class="col-md-6" style="background: #f5f5f5;"><div class="jconfirm-closeIcon" style="display: block;" onclick="RemoveImages(this,event);">';
                        imageStr += '<i class="fa fa-trash-o" aria-hidden="true"></i></div><div class="thumbnail" >';  //onclick="OpenImage(this,event)"
                        imageStr += '<img id=' + fileNo[0] + ' src="' + strUrl + '" alt="Lights" ></div></div>';  //style="width:100px;height:100px"
                    });

                    $('#DivExaminationImages').append(imageStr);

                    if (ImageData.length > 0) {
                        $(".box-body").show();
                        $("#plusButton").empty();
                        $("#plusButton").append("<i class='fa fa-minus'></i>")
                    }
                },
                complete: function () {
                    HoldOn.close();//
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });
        }

        function OpenImage(obj, e) {
            var largeImage = $(obj).children();
            //$(largeImage).height(500)
            //$(largeImage).width(600);
            var url = $(largeImage).attr('src');
            //window.open(url, 'Image', "");
            //e.stopPropagation();

            NAME = obj.innerText;
            var MRNO = ($.session.get('PatMRNO'));
            var url = "../DoctorDesk/DisplayFile?path=" + url;
            window.open(url);
        }

        function RemoveImages(obj, e) {
            HoldOn.open();//
            var imgSource = $(obj).next().find('img').attr('src');
            var strfilename = $(obj).next().find('img').attr('id');// imgSource.replace(/^.*[\\\/]/, '')
            var strmrno = ($.session.get('PatMRNO')).toString();;
            var strtranNo = ($.session.get('PatTRANNO')).toString();

            datatosend = {
                MrNo: strmrno,
                TranNo: strtranNo,
                FileName: strfilename
            }
            $.ajax({
                type: 'POST',
                url: 'RemoveExaminationFile',
                data: datatosend,
                async: false,
                success: function (ImageData) {
                    $.messager.alert("Information", ImageData);
                    if (ImageData.indexOf("Success") > -1)
                        $(obj).parent().remove();
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });

            e.stopPropagation();
        }

    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div id="MainDiv">
            <div id="ContentHolderDiv">
                <div style="height: 70%">
                    <table>
                        <tr>
                            <td>
                                <label>
                                    Clinical Notes
                                </label>

                                 <input type="button" id="btnAddSysExam" value="Systemic Examinations"/> &nbsp;&nbsp;

                               <%--  <input type="button" id="btnAddGynac" value="Gynac"/> &nbsp;&nbsp;
                                 <input type="button" id="btnAddObstractic" value="OBST"/> &nbsp;&nbsp;--%>
                                 <input type="button" id="btnRheumatoloy" value="Rheumatoloy"/> &nbsp;&nbsp;
                                 <input type="button" id="Opthal1" value="Opthal_1"/> &nbsp;&nbsp;
                                 <input type="button" id="Opthal2" value="Opthal_2"/> &nbsp;&nbsp;
                                 <input type="button" id="Opthal3" value="Opthal_3"/> &nbsp;&nbsp;
                                 <input type="button" id="RespMed" value="Respiratory Medicine"/> &nbsp;&nbsp;
                                <button type="button" class="btn btn-info margin" style="padding: 2px 12px; font-size: 14px; 
                                margin-left: 4px; margin-top: -3px;" id="btnPersonalized">Pers...</button><%-- added by vijeta on 17th sep 2018--%> <%----%>
        <span  style="color: black; text-decoration: underline; margin-left: 20px; cursor: pointer; font-size: 13px;"
          id="copyPrevNotes">
        Copy from Previous Notes
    </span>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <textarea id="txtexam" rows="18" placeholder="Enter Notes" maxlength="1500" style="width: 95%; height:350px ; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;font-size:16px;" class="empty"></textarea>
                            </td>
                        </tr>
                        </table>
                   
<%--                        <div>
            <div class="box box-default box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">Examination Images</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" onclick="LoadPrescImages()" title="Add Examination Images" data-toggle="tooltip">
                            <i class="fa fa-image fa-2x text-green"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                    <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body" style="display: none;">
                    <div id="DivExaminationImages" class="col-md-12" style="margin-top: 20px">
                    </div>

                </div>
                <!-- /.box-body -->
            </div>
        </div>--%>


<%--                        <table>        --%>                
                           <%-- <tr>
                            <td>
                                <label id="myBtn" style="background-color: transparent; float: right; margin-right: 25%; border-color: transparent;" title="Save">
                                    <img src="../Images/check-round.png" style="float: right; bottom: -10px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                                </label>
                            </td>
                            </tr>
                        <tr>
                            <td>
                                <label id="lblresult"></label>
                            </td>
                        </tr>--%>
                      <%--   <tr>
                            <td>
                                <label>
                                     History
                                </label>
                                 <input type="button" id="btnAddGynac" value="Gynac"/> &nbsp;&nbsp;
                                 <input type="button" id="btnAddObstractic" value="OBST"/> &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <textarea id="txtothrHist" rows="18" placeholder="Enter Other History" maxlength="1500" style="width: 99%; height:350px ; border-radius: 5px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); margin-top: 2px;font-size:16px;" class="empty"></textarea>
                            </td>
                        </tr>
                    </table>--%>
                </div>
                <div id="layer-demo" class="po__layer list">
               
                </div>
                <div id="layer-DMY" class="po__layer list">
                    <a href="javascript:;" style="text-decoration: none;" onclick="SetText('D')">Days</a>
                    <a href="javascript:; " style="text-decoration: none;" onclick="SetText('M')">Months</a>
                    <a href="javascript:;" style="text-decoration: none;" onclick="SetText('Y')">Years</a>
                </div>
                 
            </div>

     <button id="myBtn" style="background-color: transparent; float: right; margin-right: 25%; border: none;display:none;" title="Save">
    <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
</button>
     <div id="divPlanningInfo" style="display: none;">
        <a href="#divPlanningInfo" id="btnPlanning"></a>
        <style>
                #divPlanningInfo {
                    width: 100%;
                    height: 100%;
                    overflow-y: auto;
                    padding: 10px;
                    box-sizing: border-box;
                }

                .panel-heading {
                    background: #24417c;
                    color: white;
                    padding: 8px 12px;
                    border-radius: 7px 7px 0 0;
                }

                /* Responsive typography */
                .panel-heading h3 {
                    margin: 0;
                    font-size: 1.3em;
                }
        </style>
      <%--  <div class="panel-heading">
            <h3 class="panel-title">History</h3>
        </div>--%>
        <div style="position: relative; overflow: hidden;" id="divPlanning">
           <div id="tbldiv">

                </div>
        </div>
    </div>
     </div>

   <%-- Added by Dhananjay 20250926 --%>
   <div style="position: fixed; bottom: 20px; left: 25%; right: 15%; text-align: center; z-index: 1000;">
        <button id="btnSave" onclick="Save('SS');"
            style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
            onmouseover="this.style.backgroundColor='#218838'"
            onmouseout="this.style.backgroundColor='#28a745'">
            Save
        </button>
   </div>

</asp:Content>
