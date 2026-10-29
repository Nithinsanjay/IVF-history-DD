<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<style type="text/css">
    .switch-field {
        position: relative;
        top: 50%;
        left: 50%;
        transform: translate(-50%,1%);
        height: 26px;
    }

        .switch-field input[type="radio"] {
            position: relative;
            opacity: 0;
            z-index: -1;
        }

        .switch-field label {
            position: relative;
            display: inline-block;
            margin-right: 5px;
            margin-bottom: 5px;
            padding-left: 25px;
            padding-right: 5px;
            line-height: 25px;
            cursor: pointer;
        }

            .switch-field label::before {
                content: " ";
                position: absolute;
                top: 6px;
                left: 0;
                display: block;
                width: 15px;
                height: 15px;
                border: 2px solid #545b62;
                border-radius: 4px;
                z-index: -1;
            }

        .switch-field input[type="radio"] + label::before {
            border-radius: 20px;
        }
        /* Checked */

        .switch-field input[type="radio"]:checked + label {
            padding-left: 5px;
            color: #fff;
            width: 16%;
            height: 25px;
            text-align: center;
        }

            .switch-field input[type="radio"]:checked + label::before {
                top: 0;
                width: 100%;
                height: 100%;
                background: #545b62;
            }
        /* Transition */
        .switch-field label,
        .switch-field label::before {
            -webkit-transition: .25s all ease;
            -o-transition: .25s all ease;
            transition: .25s all ease;
        }

    .btnType {
        cursor: pointer;
        color: #fff;
        font-weight: 400;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        border: 1px solid transparent;
        padding: .375rem .75rem;
        font-size: 1.2rem;
        border-radius: .25rem;
        margin-left: 15px;
    }

    .divHistory {
        padding: 0.2rem;
       border-bottom: 0.2px solid #414142;
        border-left-width: 0.25rem;
        border-radius: .25rem;
        box-sizing: border-box;
        /*font-size: small;*/   font-size: 13px;
        color: #fbf3a9;
        /*border-bottom-color: burlywood;*/
    }
</style>
<script type="text/javascript">
    var responceJSON = "";
    $(document).ready(function () {

        $("#btnShowPatHistory").click(function (e) {
            $("#btnAll").val("All");
            $("#btnAdmission").val("Admissions");
            $("#btnConsultation").val("OPD Consultations");
            $("#divPatHist").empty();
            $('#divPatHistory input[type="radio"]').removeAttr("checked", "checked");
            $("a#btnShowPatHist").click();
        });
        $("#btnShowPatHist").fancybox({
            openEffect: 'elastic',
            openSpeed: 100,
            closeEffect: 'elastic',
            closeSpeed: 100,
            helpers: {
                overlay: { closeClick: false }
            },
            autoDimensions: false,
            cyclic: true,
            showNavArrows: true,
        });
        $('.btnType').click(function () {
            var filterText = ($(this)[0].id === "btnAdmission") ? "I" : (($(this)[0].id === "btnConsultation") ? "O" : "");
            CreateList(filterText);
        })

        $("#rbtnMax")[0].chec
   
        $('#divPatHistory input[type="radio"]').click(function () {
            BindPatientHistoryData($(this).val());
        });

        function BindPatientHistoryData(forDays) {
            if (($.session.get('PatMRNO')).toString().trim() === "") {
                MsgDia('Please Select Patient.', 'Validation');
                return false;
            } else {
                $.ajax({
                    type: "POST",
                    url: "../DoctorDesk/GetPatientMedicalHistory",
                    data: { sMRNo: ($.session.get('PatMRNO')).toString().trim(), sDays: forDays },
                    dataType: "json",
                    success: function (response) {
                        //console.log(response);
                        responceJSON = JSON.parse(response);
                            CreateList("");
                    }, onerror: function () {
                        MsgDia('Please Enter Required Fields.', 'Error Information');
                    }
                });
            }
        }

        function CreateList(sfilterText) {
            if (sfilterText.length > 0) {
                responceData = $.grep(responceJSON, function (i, n) { return i.TYPE === sfilterText });
            } else {
                responceData = responceJSON;
            }
            $("#divPatHist").empty();
            var divSubmit = $(document.createElement('div'));
            if (responceData.length == 0) {
                $(divSubmit).append('<div class="divHistory" style="color:#ffffff"><b>No Data</b></div>');
                if (sfilterText.length === 0) {
                    $("#btnAll").val("All");
                    $("#btnAdmission").val("Admissions");
                    $("#btnConsultation").val("OPD Consultations");
                }
            } else {
                var iAdm = 0, iCons = 0;
                for (i = 0; i < responceData.length; i++) {
                    //$(divSubmit).append('<b>' + responceData[i].TYPE + '</b><br>');
                    var selem = '<div class="divHistory" style="color: ' + ((responceData[i].TYPE == "I") ? '#a1aced' : '#e5a77b') + '">'
                    selem += '<span style=" text-decoration: underline; ">' + responceData[i].DT + ' : </span>';
                    selem += (responceData[i].TYPE == "I") ? ' Admitted with IP No ' + responceData[i].IPNO + ' Under ' : ' ' + responceData[i].VISITTYPE + ' visit to ';
                    selem +=  responceData[i].DOCTOR ;
                    selem += (responceData[i].TYPE == "O") ? ' at ' + responceData[i].CNTRNAME + '' : '';
                    selem += (responceData[i].COMPLAINT != "" || responceData[i].DIAGNOSIS != "") ? ' : ' : '';
                    selem += (responceData[i].COMPLAINT != "") ? '<b>Complaint</b> ' + responceData[i].COMPLAINT : '';
                    selem += (responceData[i].COMPLAINT != "" && responceData[i].DIAGNOSIS != "") ? ',' : '';
                    selem += (responceData[i].DIAGNOSIS != "") ? ' <b>Diagnosis</b> ' + responceData[i].DIAGNOSIS : '';
                    selem += ' </div>';
                    $(divSubmit).append(selem);
                    if (responceData[i].TYPE == "I") { iAdm += 1; } else { iCons += 1; }
                }
                if (sfilterText.length === 0) {
                    $("#btnAll").val("All (" + (iAdm + iCons) + ")");
                    $("#btnAdmission").val("Admissions (" + iAdm + ")");
                    $("#btnConsultation").val("OPD Consultations (" + iCons + ")");
                }
            }
            $('#divPatHist').append(divSubmit);
        }
    });

</script>
<div>
    <button type="button" class="btn" style="background-color: #008CBA !important;" id="btnShowPatHistory">Patient History</button>
</div>
<div id="divPatHistory" style="position: relative; display: none; width: 550px; height: 500px;">
    <a href="#divPatHistory" id="btnShowPatHist"></a>
    <div class="HeadDivMaster">Visit/Admission History</div>
    <fieldset id="SearchCriteria" style="box-shadow: 3px -2px 10px 1px #333; border: 1px solid #dfdfdf;">
        <div style="padding: 3px;">
            <div class="switch-field">
                <input type="radio" id="rbtnMonth" name="Type" value="30" />
                <label for="rbtnMonth">1 Month</label>
                <input type="radio" id="rbtn3Month" name="Type" value="90" />
                <label for="rbtn3Month">3 Months</label>
                <input type="radio" id="rbtnYear" name="Type" value="365" />
                <label for="rbtnYear">1 Year</label>
                <input type="radio" id="rbtnMax" name="Type" value="0" />
                <label for="rbtnMax">Till Now</label>
            </div>
        </div>
       <div style="top:10px;margin-bottom:4px;">
            <input type="button" class="btnType" style="background-color: #7f88c1; border-color: #0062cc;" id="btnAdmission" value="Admissions" />
            <input type="button" class="btnType" style="background-color: #b17f5c; border-color: #de7a34;" id="btnConsultation" value="OPD Consultations" />
            <input type="button" class="btnType" style="color: black; background-color: #dae0e5; border-color: #d3d9df;" id="btnAll" value="All" />
        </div>
    </fieldset>
    <fieldset id="DataBind" style="margin-top:6px;">
        <div id="divPatHist" style="overflow: auto; height: 400px; background-color: #131212;"></div>
    </fieldset>
</div>
