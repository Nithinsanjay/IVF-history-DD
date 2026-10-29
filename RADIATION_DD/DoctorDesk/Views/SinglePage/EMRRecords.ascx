<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<style type="text/css">
   
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

</style>

  <SCRIPT type="text/javascript">
      var s = "";
      var ServerTime = '<%=  ViewBag.ServerTime %>';
      var ServerDate = '<%=  ViewBag.ServerDate %>';
      var icuStatus = "N";//Session["ICUNSYN"].ToString().ToUpper()
      var chkInvstg = "";
      var rbtnprogn = "";
      var prbmlst = "";
      var Formname = "";
      $(document).ready(function () {


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

          $('#Nurse, #RMO, #consultant').prop('disabled', true);
          FormName = "Reports";
          $('#Rptdate').attr('readonly', true);
          $('#Rptdate1').attr('readonly', true);
          $('#btnOpen').click(function (e) {
              $('#MenuDiv').show("slide", { direction: "right" }, 1000);
              $('#ContentDiv').removeClass('MainColumn1');
              $('#ContentDiv').addClass('MainColumn');
              $('.HeadDiv').css("width", "99%");
              $('.HeadDiv').css("margin-left", "1px");
              $('.part-85').css({ "margin-left": "0%" });
              $('.sticky-footer').css({ "margin-left": "16%" });
              $('#sticky-button').css({ "margin-left": "533px" });

              if ($(window).width() < 1220) {
                  $('#InfoTable').css({ "margin-left": "0.30px" });
                  $("#sticky-button").css({ "margin-left": "422px" });
              }
          });
          document.getElementById("TimeLabel").style.display = 'none';
          document.getElementById('Time').style.display = "none";

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
          //$('#txtToTime').val(time[0] + ":" + timespan[0] + ' ' + timespan[1]);
          $('#txtToTime').val(time[0] + ":" + timespan[0]);

          $('#btnPrint').click(function () {
              const selectedRadio = document.querySelector('#ChkLstExcel input[type="radio"]:checked');
              if (selectedRadio) {
                  ExcelRecords(selectedRadio);
              } else {
                  if (Checkrequiredfield()) {
                      s = "";
                      startLoading("Loading", "loading-EMRRecords");
                      var strIPNO = $("#txtstrUIPNo").val();
                      var strMrNo = $("#txtstrUMrNo").val();
                      var strDate = $("#Rptdate").val();
                      var strDate1 = $("#Rptdate1").val();
                      var strTime = "";
                      var rptType = "";
                      var strToTime = "";
                      var IsbarType = "";
                      var patStatus = ""; //Added by Murali on 06/06/2024
                      if ($('#ISBAR').prop('checked') || $('#ISBARDR').prop('checked')) {
                          rptType = "ISBAR";
                          IsbarType = $('#ISBAR').prop('checked') ? "N" : "D";
                          var strTime = $("#IsbarYTime").val();
                      }
                      else if ($('#NursngAssesmnt').prop('checked')) {
                          rptType = "NURSES NOTES";
                          strTime = $("#Time").val();
                      }
                      else if ($('#RespAss').prop('checked')) {
                          rptType = "RESPIRATORY";
                      }
                      else if ($('#CriticalCare').prop('checked')) {
                          rptType = "CRITICAL CARE FLOW SHEET GRAPH";
                      }
                      else if ($('#MaxTemp').prop('checked')) {
                          rptType = "DATE WISE MAX TEMP";
                      }
                      else if ($('#Nursing').prop('checked')) {
                          rptType = "NURSING ASSESSMENT";
                          strTime = $("#txtFrmTime").val();
                          strtoTime = $("#txtToTime").val();
                      }
                      else if ($('#NursingWithoutChk').prop('checked')) {
                          rptType = "NURSING ASSESSMENT COMMA";
                          strTime = $("#txtFrmTime").val();
                          strtoTime = $("#txtToTime").val();
                      }
                      else if ($('#InvestChart').prop('checked')) {
                          rptType = "INVESTIGATION";
                      }
                      else if ($('#DiabeticChart').prop('checked')) {
                          rptType = "DIABETIC";
                      }
                      else if ($('#InvestReport').prop('checked')) {
                          rptType = "INVESTIGATION_REPORT";
                      }
                      else if ($('#DiacomImg').prop('checked')) {//kavita 11-10-18

                          rptType = "DIACOM_IMAGES"
                      }//kavita
                      else if ($('#NursingNotes').prop('checked')) {
                          rptType = "NURSINGNOTES";
                          strTime = $('#txtFrmTime').val();
                          strToTime = $('#txtToTime').val();
                          NursingNotesPrint(rptType);
                          return false;
                      }
                      /*Madhuri:-Code for seprating 2 reports*/
                      else if ($('#ProgrNot').prop('checked')) {
                          rptType = "PROGNOTE";
                          strTime = $('#txtFrmTime').val();
                          strToTime = $('#txtToTime').val();
                          NursingNotesPrint(rptType);
                          return false;
                      }
                      /*Madhuri:-End Code for seprating 2 reports*/
                      else if ($('#TISS28Score').prop('checked')) {
                          rptType = "TISS28";
                      }
                      //added on 16/07/2020
                      else if ($('#TISS28Score1').prop('checked')) {
                          rptType = "TISS28";
                      }
                      else if ($('#TISS28Score2').prop('checked')) {
                          rptType = "TISS28";
                      }
                      else if ($('#TreatmentSheetAdminst').prop('checked')) {
                          rptType = "TS_ADMINISTRATION_REPORT";
                      }
                      else if ($('#TreatmentSheetMedRemark').prop('checked')) {
                          rptType = "TS_MEDREMARK_REPORT";
                      }
                      else if ($('#TreatmentSheetChemoRemark').prop('checked')) {
                          rptType = "Chemo";
                          strTime = $("#txtFrmTime").val();
                          strtoTime = $("#txtToTime").val();
                      }
                      else if ($('#rbtnOrderTestList').prop('checked')) { //added by vijeta on 21st july 2018
                          rptType = "OrderTestList_REPORT";
                      }
                      else if ($('#rbtnBradenScore').prop('checked'))       //vishal 18th Feb 2019
                      {
                          rptType = "BradenScore_REPORT";
                      }
                      else if ($('#rbtnInvasiveLines').prop('checked'))       //vishal 18th Feb 2019
                      {
                          rptType = "InvasiveLines_REPORT";
                          strTime = $('#ShiftTime').val()
                      }
                      else if ($('#rbtnCriticalAssmnt2').prop('checked'))       //vishal 18th Feb 2019
                      {
                          rptType = "IntakeOutput_REPORT";
                          strDate = $("#Rptdate").val();
                      }
                      else if ($('#BundleChkList').prop('checked')) {            //vishal 17TH jUNE 2019
                          rptType = "BUNDLECHECKLIST";
                          strBundletype = $('#cmbBundleType').val();
                          strTime = $('#ShiftTime').val()
                      }
                      else if ($('#rbtnPrphlBndleChkLst').prop('checked'))    ///vishal 17th June 2019
                      {
                          rptType = "PERIPHERALBUNDLECHECKLIST";
                          strTime = $('#ShiftTime').val()


                      }
                      else if ($('#PainChart').prop('checked'))       //vishal 2nd July 2019
                      {
                          rptType = "Pain_Chart";
                          patStatus = "C"; //Added by Murali on 06/06/2024
                      }
                      else if ($('#PainChartUnCons').prop('checked'))       //Added by Murali on 06/06/2024
                      {
                          rptType = "Pain_ChartUn";
                          patStatus = "U";
                      }
                      else if ($('#rbtnHourlyChart').prop('checked'))       //vishal 2nd July 2019
                      {
                          rptType = "Hourly_Chart";
                      }
                      else if ($('#rbtnPhysclRestrnt').prop('checked'))    ///vishal 12th Aug 2019
                      {
                          rptType = "PHYSICALRESTRAINTS";

                      }
                      else if ($('#rbtnApacheIIScore').prop('checked'))    ///vishal 12the Feb 2020
                      {
                          rptType = "APACHEIISCORE";
                          strTime = $('#txtstrUAgeGender').val();

                      }
                      else if ($("#rbtnFallRisk").prop('checked')) {
                          rptType = "FALLRISK";
                          strTime = $('#ShiftTime').val()
                      }
                      if (rptType != "CRITICAL CARE FLOW SHEET GRAPH" && rptType != "TISS28") {
                          if (rptType != "BUNDLECHECKLIST") {
                              strBundletype = "";
                          }
                          if (rptType == "PERIPHERALBUNDLECHECKLIST") {
                              strBundletype = $('#cmbPBundleType').val();
                          }
                          if (rptType == "INVESTIGATION_REPORT") {
                              InvestigateData(strIPNO, strDate, strTime, rptType, strDate1);
                              return false;
                          }
                          if (rptType == "DIACOM_IMAGES") {//kavita
                              DiacomData(strMrNo);
                          }
                          else {
                              $.ajax({
                                  url: '../ICU/ICUPrint?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&strToTime=' + strToTime + '&&ReportType=' + rptType + '&&strToDt=' + strDate1 + '&&strBundletype=' + strBundletype + '&&IsbarType=' + IsbarType + '&&PatStatus=' + patStatus,
                                  type: "POST",
                                  dataType: "JSON",
                                  success: function (response) {
                                      stopLoading("loading-EMRRecords");
                                      if (response == "No Data Found") {
                                          ToastMsg('No Data Found', "warning");
                                      }
                                      else {
                                          if (rptType == "NURSINGNOTES") {
                                          }
                                          else {
                                              var url = 'DisplayICUPrint';
                                              var win = window.open(url, '', 'width=1024, height=700');
                                              win.document.close();
                                              win.focus();
                                          }
                                      }

                                  }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                      stopLoading("loading-EMRRecords");
                                      sWaitForPrint = "";
                                      ToastMsg('An error occurred while processing your request.', "error");
                                  }
                              });
                          }
                      }
                      else if (rptType == "CRITICAL CARE FLOW SHEET GRAPH") {
                          $('#Time').attr('visible', true);
                          $.ajax({
                              url: '../ICU/SetCritCareGraphDate?strDate=' + strDate + '&&strIPNo=' + strIPNO,
                              type: "POST",
                              dataType: "JSON",
                              success: function (response) {
                                  stopLoading("loading-EMRRecords");
                                  var url = 'CriticalCareGraph';
                                  var win = window.open(url, '', 'width=1024, height=700');
                                  win.document.close();
                                  win.focus();

                              }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                  ToastMsg('An error occurred while processing your request.', "error");
                              }
                          });

                      }
                      if ($('#TISS28Score').is(':checked')) {
                          $.ajax({
                              url: '../ICU/SetTISSDatesNIPNO?strFrmDate=' + strDate + '&&strToDate=' + strDate1 + '&&strIPNo=' + strIPNO,
                              type: "POST",
                              dataType: "JSON",
                              success: function (response) {
                                  stopLoading("loading-EMRRecords");
                                  if (response == "No Data Found") {
                                      ToastMsg('No Data Found', "warning");
                                  }
                                  var url = "TISSReport";
                                  var win = window.open(url, '', 'width=1500, height=900');
                                  win.document.close();
                                  win.focus();
                              },
                              error: function () {
                                  ToastMsg('An error occurred while processing your request.', "error");
                              }
                          });
                      }
                      else if ($('#TISS28Score1').is(':checked')) {
                          $.ajax({
                              url: '../ICU/SetTISSDatesNIPNO',
                              type: "POST",
                              dataType: "JSON",
                              data: {
                                  strFrmDate: strDate,
                                  strToDate: strDate1,
                                  strIPNo: strIPNO
                              },
                              success: function (response) {
                                  stopLoading("loading-EMRRecords");
                                  if (response === "No Data Found") {
                                      ToastMsg('No Data Found', "warning");
                                  } else if (response === "Success") {
                                      var url = "TISSReport";
                                      var win = window.open(url, '', 'width=1500, height=900');
                                      win.document.close();
                                      win.focus();
                                  }
                              },
                              error: function () {
                                  ToastMsg('An error occurred while processing your request.', "error");
                              }
                          });
                      }
                      else if ($('#TISS28Score2').is(':checked')) {
                          $.ajax({
                              url: '../ICU/SetTISSDatesNIPNO',
                              type: "POST",
                              dataType: "JSON",
                              data: {
                                  strFrmDate: strDate,
                                  strToDate: strDate1,
                                  strIPNo: strIPNO
                              },
                              success: function (response) {
                                  stopLoading("loading-EMRRecords");
                                  if (response === "No Data Found") {
                                      ToastMsg('No Data Found', "warning");
                                  } else if (response === "Success") {
                                      var url = "BedwiseReport";
                                      var win = window.open(url, '', 'width=1500, height=900');
                                      win.document.close();
                                      win.focus();
                                  }
                              },
                              error: function () {
                                  ToastMsg('An error occurred while processing your request.', "error");
                              }
                          });
                      }
                  }
                  else {
                      s = "REQUIRED";
                  }
              }
          });

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

          ////Added by vishal as on 14th March 2018 For Nursing Notes Report////
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
                  chkInvstg = "ALL"; // Update variable directly
              }
              else {
                  chkInvstg = "D";
              }
          });
          $('#chkInvstg').attr('disabled', 'disabled');
          $(".EmpLst").hide();
          /*Madhuri:-Code for seprating 2 reports*/
          $('input[name="icu"]').change(function () {
              if ($('#ProgrNot').prop('checked')) {
                  $('#Nurse, #RMO, #Consultant').prop('disabled', false);
              } else {
                  $('#Nurse, #RMO, #Consultant').prop('disabled', true).prop('checked', false); // Also uncheck checkboxes
              }

              if ($('#NursingNotes').prop('checked')) {
                  $('#Problist').prop('disabled', false);
              } else {
                  $('#Problist').prop('disabled', true).val(""); // Disable & clear selection
                  ProblemCD = ""; // Clear value if disabled
              }

              ShowHideEmpLst();
          });

          $('#Rptdate').change(function () {
              var ipno = $(this).val().trim(); // Get input value and trim spaces
              if (ipno === '') {
                  alert("IPNO cannot be empty!");  // Validation check
                  return;
              }
              fetchProblemList();
          });
          $('#Rptdate1').change(function () {
              var ipno = $(this).val().trim(); // Get input value and trim spaces
              if (ipno === '') {
                  alert("IPNO cannot be empty!");  // Validation check
                  return;
              }
              fetchProblemList();

          });
          $('#txtFrmTime').change(function () {
              var ipno = $(this).val().trim(); // Get input value and trim spaces
              if (ipno === '') {
                  alert("IPNO cannot be empty!");  // Validation check
                  return;
              }
              fetchProblemList();

          });
          $('#txtToTime').change(function () {
              var ipno = $(this).val().trim(); // Get input value and trim spaces
              if (ipno === '') {
                  alert("IPNO cannot be empty!");  // Validation check
                  return;
              }
              fetchProblemList();

          });

          var reportNames = [];

          // Extract label text from the table and store in an array
          $(".Maintable label").each(function () {
              var labelText = $(this).text().trim();
              if (labelText) {
                  reportNames.push(labelText);
              }
          });

          // Populate the list dynamically
          var reportList = $("#reportList");
          reportNames.forEach(function (name) {
              reportList.append("<li style='cursor:pointer; padding:5px;' onclick='selectReport(this)'>" + name + "</li>");
          });

          // Show/hide list based on search
          $("#txtReportSearch").on("keyup", function () {
              var value = $(this).val().toLowerCase();
              $("#reportList").toggle(value.length > 0); // Show list if input is not empty

              $("#reportList li").each(function () {
                  $(this).toggle($(this).text().toLowerCase().includes(value));
              });
          });
          document.querySelectorAll(".Maintable input[type='radio']").forEach(function (radio) {
              radio.addEventListener("change", function () {
                  RemoveHighlight();
              });
          });
      });  //end of ready 




      function closeme() {
          $.fancybox.close();
      }

      function InvestigateData(strIPNO, strDate, strTime, rptType, strDate1) {
          $.ajax({
              url: '../ICU/GetInvestReportData?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&ReportType=' + rptType + '&&strToDt=' + strDate1 + '&&chkInvstg=' + chkInvstg,
              type: "POST",
              dataType: "JSON",
              success: function (response) {
                  stopLoading("loading-EMRRecords");
                  if (response == "No Data Found") {
                      ToastMsg('No Data Found', "warning");
                  }
                  else {
                      sWaitForPrint = "";
                      //window.open("InvestigateResult", '_blank');
                      var url = 'InvestigateResult';
                      var win = window.open(url, '', 'width=1024, height=700');
                      win.document.close();
                      win.focus();
                  }
              }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                  sWaitForPrint = "";
                  ToastMsg('An error occurred while processing your request.', "error");
              }
          });
      }

      //kavita
      function DiacomData(strMrNo) {
          if (strMrNo != "") {
              $.ajax({
                  type: 'POST',
                  url: 'RedirectToDicom',
                  data: { strMrNo: strMrNo },
                  success: function (data) {
                      stopLoading("loading-EMRRecords");
                      window.open(data, '_blank');
                  }
              });
          }
      }

      function MinDate() {
          var admnDt = $('#txtstrUAdmDtTm').val().substring(0, $('#txtstrUAdmDtTm').val().indexOf("/") + 8);
          var DisDt = $('#txtstrUDisDtTm').val().substring(0, $('#txtstrUDisDtTm').val().indexOf("/") + 8);
          var dd = admnDt.substring(0, 2);
          var MM = admnDt.substring(3, 5);
          var yyyy = admnDt.substring(6, 10);

          var dateString = yyyy + "-" + MM + "-" + dd;
          var date1 = new Date(dateString);
          date1.setDate(date1.getDate() - 1)

          var month = date1.getMonth() + 1;
          var prevDt = date1.getDate();
          var year = date1.getFullYear();

          if (prevDt < 10) {
              prevDt = '0' + prevDt
          }
          if (month < 10) {
              month = '0' + month
          }

          var prevDate = prevDt + '/' + month + '/' + year;
          $("#Rptdate").datepicker("option", "minDate", prevDate);

          $("#Rptdate1").datepicker("option", "minDate", prevDate);


          //Raja on start 28/01/2023
          var enddd = DisDt.substring(0, 2);
          var endMM = DisDt.substring(3, 5);
          var endyyyy = DisDt.substring(6, 10);
          var dateString = endyyyy + "-" + endMM + "-" + enddd;
          var date2 = new Date(dateString);
          date2.setDate(date2.getDate())
          var endmonth = date2.getMonth() + 1;
          var endprevDt = date2.getDate();
          var endyear = date2.getFullYear();
          if (endprevDt < 10) {
              endprevDt = '0' + endprevDt
          }
          if (endmonth < 10) {
              endmonth = '0' + endmonth
          }
          var endprevDate = endprevDt + '/' + endmonth + '/' + endyear;
          $("#Rptdate").datepicker("option", "maxDate", endprevDate);
          $("#Rptdate1").datepicker("option", "maxDate", endprevDate);
          //end
      }

      function GetIsbarYTimeSlots(type) {
          var strIPNO = $("#txtstrUIPNo").val();
          var strDate = $("#Rptdate").val();
          $.ajax({
              url: '../ICU/GetIsbarYTimeSlots?strDate=' + strDate + '&&strIPNo=' + strIPNO + '&&strType=' + type,
              type: "POST",
              dataType: "JSON",
              success: function (response) {
                  if (type == "ISBAR" || type == "ISBARDR") {
                      $('#IsbarYTime').empty();
                      $('#IsbarYTime').append($('<option/>').val("").text("---Select---"));
                      $.each($.parseJSON(response), function (i, option) {
                          $('#IsbarYTime').append($('<option/>').val(option.Value).text(option.Text));
                      });
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

      function fnload(IPNO) {
          //debugger;
          SetDateTime();
          var IPNo = IPNO;
          var DATE = $("#Rptdate").val();
          var TIME = $("#Time").val();
      }

      function SetDateTime() {
          //var today = new Date();
          //var dd = today.getDate();
          //var mm = today.getMonth() + 1;
          //var yyyy = today.getFullYear();
          //if (dd < 10) {
          //    dd = '0' + dd
          //}
          //if (mm < 10) {
          //    mm = '0' + mm
          //}
          //today = dd + '/' + mm + '/' + yyyy;
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

          //  MinDate();

      }
      function rbtnchange() {
          if ($('#NursngAssesmnt').prop('checked')) {
              document.getElementById("TimeLabel").style.display = 'inline';
              document.getElementById('Time').style.display = 'inline';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();

          }
          else {
              document.getElementById("TimeLabel").style.display = 'none';
              document.getElementById('Time').style.display = "none";
          }

          if ($('#ISBAR').prop('checked') || $('#ISBARDR').prop('checked')) {
              document.getElementById("TimeLabel1").style.display = 'inline';
              document.getElementById('IsbarYTime').style.display = 'inline';
              document.getElementById("TimeLabel").style.display = 'none';
              document.getElementById('Time').style.display = "none";

              document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
          }
          if ($('#MaxTemp').prop('checked')) {
              document.getElementById("DATE").style.display = 'none';
              document.getElementById('Rptdate').style.display = "none";
              document.getElementById("Rptdate1").style.display = 'none';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              document.getElementById("DATE").style.display = 'inline';
              document.getElementById('Rptdate').style.display = "inline";
          }
          if ($('#Nursing').prop('checked')) {
              document.getElementById("DATE").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              //document.getElementById("DATE1").style.display = 'none';
              document.getElementById('Rptdate').style.display = "none";
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          if ($('#NursingWithoutChk').prop('checked')) {
              document.getElementById("DATE").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              //document.getElementById("DATE1").style.display = 'none';
              document.getElementById('Rptdate').style.display = "none";
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          if ($('#CriticalCare').prop('checked')) {
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          if ($('#RespAss').prop('checked')) {
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          if ($('#InvestChart').prop('checked')) {
              document.getElementById("Rptdate1").style.display = 'inline';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              //document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("DATE1").style.display = 'none';
          }
          if ($('#InvestReport').prop('checked')) {
              document.getElementById("Rptdate1").style.display = 'inline';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
              $('#chkInvstg').prop('checked');
              $('#chkInvstg').prop('disabled', false);
          }
          else {
              //document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("DATE1").style.display = 'none';
              $('#chkInvstg').prop('disabled', true);
              //$('#chkInvstg')[0].checked = false;
          }
          if ($('#DiabeticChart').prop('checked')) {
              document.getElementById("Rptdate").style.display = 'inline';    //vishal 27th Aug 2019 showing the frm date
              document.getElementById("Rptdate1").style.display = 'inline';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";

              $('#Rptdate').val($('#txtstrUAdmDtTm').val().substring(0, 10));          //vishal 27th Aug 2019

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
              return;
          }
          else {
              //document.getElementById("TimeLabel1").style.display = 'none';            
          }

          if ($('#TreatmentSheetAdminst').prop('checked')) {
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }

          if ($('#TreatmentSheetMedRemark').prop('checked')) {
              //rptType = "TS_MEDREMARK_REPORT";

              // Optional: hide fields not needed for this report
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          if ($('#TreatmentSheetChemoRemark').prop('checked')) {
              //rptType = "TS_MEDREMARK_REPORT";

              // Optional: hide fields not needed for this report
              document.getElementById("DATE").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              //document.getElementById("DATE1").style.display = 'none';
              document.getElementById('Rptdate').style.display = "none";
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }

          if ($('#NursingNotes').prop('checked')) {
              document.getElementById("Rptdate").style.display = 'inline';

          }
          else {
              //document.getElementById("TimeLabel1").style.display = 'none';            
          }
          if ($('#ProgrNot').prop('checked')) {
              document.getElementById("Rptdate").style.display = 'inline';

          }


          if ($('#TISS28Score').prop('checked')) {
              document.getElementById("Rptdate1").style.display = 'inline';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              //document.getElementById("Rptdate1").style.display = 'none';

          }

          if ($('#rbtnOrderTestList').prop('checked')) {//added by vijeta on 21st july 2018
              document.getElementById("DATE").style.display = 'none';
              document.getElementById('Rptdate').style.display = "none";
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
          }

          if ($('#DiacomImg').prop('checked')) {
              document.getElementById("Rptdate1").style.display = 'inline';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }


          if ($('#rbtnBradenScore').prop('checked')) {                //added by vishal 18th Feb 2018
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#Rptdate').val($('#txtstrUAdmDtTm').val().substring(0, 10));
              $('#Rptdate1').val();
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              SetDateTime();
              document.getElementById("Rptdate1").style.display = 'none';
          }
          if ($('#rbtnFallRisk').prop('checked')) {
              $('#ShiftTm').hide();
          }
          //vishal 22ndMarch 2019
          if ($('#rbtnInvasiveLines').prop('checked')) {
              document.getElementById("Rptdate1").style.display = 'none';
              $('#ShiftTm').hide();
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $("#Rptdate").hide();
              $("#DATE").hide();
          }
          if ($('#rbtnCriticalAssmnt2').prop('checked')) {
              document.getElementById("Rptdate1").style.display = 'none';
              $('#ShiftTm').hide();
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#FrmTime').hide();
              $('#ToTime').hide();
          }

          if ($('#PainChart').prop('checked')) {                //added by vishal 18th Feb 2018
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#Rptdate').val($('#txtstrUAdmDtTm').val().substring(0, 10));
              $('#Rptdate1').val();
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              //SetDateTime();
              //document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
          }

          if ($('#PainChartUnCons').prop('checked')) {                //Added by Murali on 06/06/2024
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#Rptdate').val($('#txtstrUAdmDtTm').val().substring(0, 10));
              $('#Rptdate1').val();
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              //SetDateTime();
              //document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
          }

          if ($('#rbtnHourlyChart').prop('checked')) {                //added by vishal 18th Feb 2018
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#Rptdate').val($('#txtstrUAdmDtTm').val().substring(0, 10));
              $('#Rptdate1').val();
              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          else {
              //SetDateTime();
              //document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
          }

          if ($('#rbtnPhysclRestrnt').prop('checked')) {                                 ///vishal 12th Aug 2019
              document.getElementById("DATE").style.display = 'none';
              document.getElementById('Rptdate').style.display = "none";
              document.getElementById("Rptdate1").style.display = 'none';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
          }
          if ($('#rbtnApacheIIScore').prop('checked')) {
              document.getElementById("Rptdate1").style.display = 'none';
              $('#ShiftTm').hide();
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#FrmTime').hide();
              $('#ToTime').hide();
          }

          if ($('#Assesmentexcel').prop('checked')) {
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';

              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";

              $('#Rptdate').val($('#txtstrUAdmDtTm').val().substring(0, 10));

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').hide();
              $("#Rptdate").val(ServerDate);
              $("#Rptdate1").val(ServerDate);
              SetDateTimeForChkLst();
              return;
          }

      }

      function rbtnchangeNursg() {

          if ($('#NursingNotes').prop('checked')) {
              document.getElementById("DATE").style.display = 'inline';
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              document.getElementById("TimeLabel").style.display = 'none';
              document.getElementById('Time').style.display = "none";
              $('#FrmTime').show();
              $('#ToTime').show();
              $('#ShiftTm').hide();
              //$('#FrmTime').val("12:00 AM");
              $('#txtFrmTime').val("12:00 AM");
              fetchProblemList();
          }

          if ($('#ProgrNot').prop('checked')) {
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              document.getElementById("TimeLabel").style.display = 'none';
              document.getElementById('Time').style.display = "none";
              $('#FrmTime').show();
              $('#ToTime').show();
              $('#ShiftTm').hide();
              //$('#FrmTime').val("12:00 AM");
              $('#txtFrmTime').val("12:00 AM");
          }

      }

      function rbtnchangeBundle() {
          if ($('#BundleChkList').prop('checked')) {
              document.getElementById("DATE").style.display = 'inline'
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              document.getElementById('Time').style.display = "none";

              $('#FrmTime').hide();
              $('#ToTime').hide();
              $('#ShiftTm').show();



              // Get admission date from textbox
              var admnDtStr = $('#txtstrUAdmDtTm').val();

              if (admnDtStr) {
                  // Extract date parts (assuming dd/mm/yyyy)
                  var parts = admnDtStr.split("/");
                  var admnDt = new Date(parts[2], parts[1] - 1, parts[0]);

                  // Calculate 10 days back
                  var today = new Date();
                  var tenDaysBack = new Date();
                  tenDaysBack.setDate(today.getDate() - 10);

                  // Compare admission date with 10 days back
                  if (admnDt < tenDaysBack) {
                      // Older than 10 days → set to 10 days back
                      $('#Rptdate').val($.datepicker.formatDate("dd/mm/yy", tenDaysBack));
                  } else {
                      // Within last 10 days → keep original date
                      $('#Rptdate').val($.datepicker.formatDate("dd/mm/yy", admnDt));
                  }
              }
          }
          else {
              document.getElementById("Rptdate").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
          }
      }

      function rbtnPrphlchangeBundle() {                      ///added by vishal as on 17th June 2019
          if ($('#rbtnPrphlBndleChkLst').prop('checked')) {
              document.getElementById("DATE").style.display = 'inline';
              document.getElementById("Rptdate").style.display = 'inline';
              document.getElementById("Rptdate1").style.display = 'inline';
              $('#ShiftTm').show();//Madhuri to fix the issue of the display shiftm
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'inline';
              document.getElementById("lblBundletype").style.display = 'inline';
              document.getElementById("TimeLabel1").style.display = 'none';
              document.getElementById('IsbarYTime').style.display = "none";
              $('#FrmTime').hide();
              $('#ToTime').hide();
          }
          else {
              document.getElementById("Rptdate").style.display = 'none';
              document.getElementById("Rptdate1").style.display = 'none';
              document.getElementById("cmbBundleType").style.display = 'none';
              document.getElementById("cmbPBundleType").style.display = 'none';
              document.getElementById("lblBundletype").style.display = 'none';
          }
      }

      function Checkrequiredfield() {
          var i = 0;
          if ($('#txtstrUIPNo').val() == "") {
              ToastMsg('Please select Valid Patient IP No.', 'warning');
              s = "REQUIRED";
              return;
          }
          if ($('#txtstrUIPNo').val() != "") {
              count = 0;
              if ($("#ISBAR").is(':checked') || $("#ISBARDR").is(':checked')) {
                  count = count + 1;
              }
              if ($("#NursngAssesmnt").is(':checked')) {
                  count = count + 1;
              }
              if ($("#RespAss").is(':checked')) {
                  count = count + 1;
              }
              if ($("#CriticalCare").is(':checked')) {
                  count = count + 1;
              }
              if ($("#MaxTemp").is(':checked')) {
                  count = count + 1;
              }
              if ($("#Nursing").is(':checked')) {
                  count = count + 1;
              }
              if ($("#NursingWithoutChk").is(':checked')) {
                  count = count + 1;
              }
              if ($("#InvestChart").is(':checked')) {
                  count = count + 1;
              }
              if ($("#DiabeticChart").is(':checked')) {
                  count = count + 1;
              }
              if ($("#NursingNotes").is(':checked')) {
                  count = count + 1;
              }
              if ($("#ProgrNot").is(':checked')) {
                  count = count + 1;
              }
              if ($("#InvestReport").is(':checked')) {
                  count = count + 1;
              }
              if ($("#DiacomImg").is(':checked')) {//kavita
                  count = count + 1;
              }//kavita
              if ($("#BundleChkList").is(':checked')) {
                  count = count + 1;
              }
              if ($("#TreatmentSheetAdminst").is(':checked')) {
                  count = count + 1;
              }
              if ($("#TreatmentSheetMedRemark").is(':checked')) {
                  count = count + 1;
              }
              if ($("#TreatmentSheetChemoRemark").is(':checked')) {
                  count = count + 1;
              }
              if ($("#BundleChkList").is(':checked')) {
                  days();
                  if (diffDays > 10) {
                      ToastMsg("Between Selected Dates difference should not more than 10 Days", "warning");
                      return false;
                  }
              }
              if ($("#rbtnPrphlBndleChkLst").is(':checked')) {
                  days();
                  if (diffDays > 10) {
                      ToastMsg("Between Selected Dates difference should not more than 10 Days", "warning");
                      return false;
                  }
              }
              if ($("#TISS28Score").is(':checked')) {
                  count = count + 1;
              }
              if ($("#TISS28Score1").is(':checked')) {
                  count = count + 1;
              }
              if ($("#TISS28Score2").is(':checked')) {
                  count = count + 1;
              }
              //added by vijeta on 21st july 2018
              if ($("#rbtnOrderTestList").is(':checked')) {
                  count = count + 1;
              }
              if ($("#rbtnBradenScore").is(':checked')) {//vishal 18th Feb 2018
                  count = count + 1;
              }
              if ($("#rbtnInvasiveLines").is(':checked')) {//vishal 22nd Mar 2019
                  count = count + 1;
              }
              if ($("#rbtnCriticalAssmnt2").is(':checked')) {//vishal 22nd Mar 2019
                  count = count + 1;
              }
              if ($('#rbtnFallRisk').is(':checked'))  ///vishal 17th June 2019
              {
                  count = count + 1;
              }
              if ($('#rbtnPrphlBndleChkLst').is(':checked'))  ///vishal 17th June 2019
              {
                  count = count + 1;
              }
              if ($("#PainChart").is(':checked')) {//vishal 18th Feb 2018
                  count = count + 1;
              }
              if ($("#PainChartUnCons").is(':checked')) {//Added by Murali on 06/06/2024
                  count = count + 1;
              }
              if ($("#rbtnHourlyChart").is(':checked')) {//vishal 18th Feb 2018
                  count = count + 1;
              }
              if ($('#rbtnPhysclRestrnt').is(':checked'))  ///vishal 12th Aug 2019
              {
                  count = count + 1;
              }
              if ($('#rbtnApacheIIScore').is(':checked'))  ///vishal 12th Feb 2021
              {
                  count = count + 1;
              }
              if ($("#rbtnPrphlBndleChkLst").is(':checked')) {
                  days();
                  if (diffDays > 10) {
                      ToastMsg("Between Selected Dates difference should not more than 10 Days", "warning");
                      return false;
                  }
              }
              //---------------------
              if ($('#ISBAR').prop('checked') || $('#ISBARDR').prop('checked')) {
                  strTime = $("#IsbarYTime").val();
                  if (strTime == "") {
                      ToastMsg('Please Select time', "warning");
                      return false;
                  }
              }
              if ($('#NursngAssesmnt').prop('checked')) {
                  strTime = $("#Time").val();
                  if (strTime == "") {
                      ToastMsg('Please Select time', "warning");
                      return false;
                  }
              }
              if ($('#SIIPAudit').is(':checked')) {
                  count = count + 1;
              }

              if ($('#MAEAAudit').is(':checked')) {
                  count = count + 1;
              }

              if ($('#PMAAudit').is(':checked')) {
                  count = count + 1;
              }

              if ($('#CSNPAudit').is(':checked')) {
                  count = count + 1;
              }

              if ($('#CNDAAudit').is(':checked')) {
                  count = count + 1;
              }

              if (count >= 1) {
                  return true;
              }
              else {
                  ToastMsg("Please select Report type", "warning");
                  return false;
              }

              if (i == 1) {
                  return false;
              }
              else {
                  return true;
              }
          }
      }

      function daydiff(first, second) {
          return Math.round((second - first) / (1000 * 60 * 60 * 24));
      }
      function parseDate(str) {
          var mdy = str.split('/');
          return new Date(mdy[2], mdy[0] - 1, mdy[1]);
      }

      function days() {
          var txtrptdate = $('#Rptdate').val();
          var newrptdate = txtrptdate.split('/');
          var mm = newrptdate[1];
          var dd = newrptdate[0];
          var yy = newrptdate[2];
          var rptdate = mm + "/" + dd + "/" + yy;

          var txtrptdate1 = $('#Rptdate1').val();
          var newrptdate1 = txtrptdate1.split('/');
          var mm = newrptdate1[1];
          var dd = newrptdate1[0];
          var yy = newrptdate1[2];
          var rptdate1 = mm + "/" + dd + "/" + yy;

          diffDays = (daydiff(parseDate(rptdate), parseDate(rptdate1)));
      }

      ////Added by vishal as on 18thJuly  2018

      //$(function () {
      //    $("#btnFancy").fancybox({
      //        openEffect: 'elastic',
      //        openSpeed: 100,
      //        closeEffect: 'elastic',
      //        closeSpeed: 100,
      //        showCloseButton: true,
      //        helpers: {
      //            overlay: { closeClick: false }
      //        },
      //        autoDimensions: false,
      //        cyclic: true,
      //        showNavArrows: true,
      //        width: 100,
      //        height: 250,
      //        afterShow: function () {
      //            var anc = '<a title="Close" class="fancybox-item fancybox-close" onclick=closeme();></a>';
      //            $('.fancybox-outer').append(anc)

      //        },
      //    });
      //});




      function NursingNotesPrint(rptType) {
          var strIPNO = $("#txtstrUIPNo").val();
          var strDate = $("#Rptdate").val();
          var strDate1 = $("#Rptdate1").val();
          var strTime = "";
          var NoteType = "";
          var strToTime = "";
          var strBundletype = "";
          strTime = $('#txtFrmTime').val();
          strToTime = $('#txtToTime').val();

          if (rptType == "NURSINGNOTES") {
              ProblemCD = $("#Problist option:selected").val(); 
          }

          if (rptType === "PROGNOTE") {
              let selectedTypes = [];
              if ($('#Nurse').is(':checked')) selectedTypes.push("N");
              if ($('#RMO').is(':checked')) selectedTypes.push("R");
              if ($('#Consultant').is(':checked')) selectedTypes.push("D");

              NoteType = selectedTypes.length > 0 ? selectedTypes.join("|") : "N|R|D";
          }

          $.ajax({
              url: '../ICU/ICUPrint?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&strToTime=' + strToTime + '&&ReportType=' + rptType + '&&strToDt=' + strDate1 + '&&strBundletype=' + strBundletype + '&&NoteType=' + NoteType + '&&ProblemCD=' + ProblemCD, /*Madhuri:- added 2 more parameters for Note type and  problems code*/
              type: "POST",
              dataType: "JSON",
              success: function (response) {
                  stopLoading("loading-EMRRecords");
                  if (response == "No Data Found") {
                      ToastMsg('No Data Found', "warning");
                  }
                  else {
                      var Success = response.Success;
                      if (Success == "Success") {
                          if (rptType == "NURSINGNOTES") {
                              var NursingNotes = JSON.parse(response.NursingNotes);
                              console.log(NursingNotes);
                              if (NursingNotes.length > 0 && NursingNotes.some(function (row) { return row.VSTATUS === 'V'; })) {
                                  var url = 'DisplayICUPrint';
                                  var win = window.open(url, '', 'width=1024, height=700');
                                  win.document.close();
                                  win.focus();
                              }
                              else {
                                  var url = 'DisplayICUPrint';
                                  var win = window.open(url, '', 'width=1024, height=700');
                                  win.document.close();
                                  win.focus();
                                  $("a#btnFancy").click();
                                  $('#lblNrsNT')[0].hidden = true;
                                  GridBindingNursNotes();
                              }
                          }
                          else if (rptType == "PROGNOTE") {
                              var NURSADDNOTES = JSON.parse(response.NURSADDNOTES);
                              if (NURSADDNOTES.length > 0 && NURSADDNOTES.some(function (row) { return row.VSTATUS === 'V'; })) {
                                  var url = 'DisplayICUPrints';
                                  var win = window.open(url, '', 'width=1024, height=700');
                                  win.document.close();
                                  win.focus();
                              }
                              else {
                                  $("a#btnFancy").click();
                                  $('#lblNrsCP')[0].hidden = true;
                                  GridBindingNursAddNotes();
                              }
                          }
                      }
                      var grpNursNotes = $.grep(NursingNotes, function (e) { return e.VSTATUS == "" });
                      var mapNursNotes = new Array();
                      var mapNursAddNotes = new Array();
                      for (var i = 0; i <= grpNursNotes.length - 1; i++) {
                          mapNursNotes.push({ NOTEDT: grpNursNotes[i]["NOTEDT"], PROBLEMTIME: grpNursNotes[i]["PROBLEMTIME"] })
                      }
                      var dupes = [];
                      var unique = [];
                      $.each(mapNursNotes, function (index, entry) {
                          if (!dupes[entry.PROBLEMTIME]) {
                              dupes[entry.PROBLEMTIME] = true;
                              unique.push(entry);
                          }
                      });
                      if (mapNursNotes.length > 0) {
                          $('#GrdNursNotes').jqGrid('clearGridData');
                          $('#GrdNursNotes').jqGrid('setGridParam', {
                              data: unique
                          }).trigger("reloadGrid");
                      }

                      var grpNursAddNotes = $.grep(NURSADDNOTES, function (e) { return e.VSTATUS == "" })
                      for (var i = 0; i <= grpNursAddNotes.length - 1; i++) {
                          mapNursAddNotes.push({ NOTEDT: grpNursAddNotes[i]["NOTEDT"], NOTETM: grpNursAddNotes[i]["NOTETM"] })

                      }
                      var dupes1 = [];
                      var unique1 = [];
                      $.each(mapNursAddNotes, function (index, entry) {
                          if (!dupes1[entry.NOTETM]) {
                              dupes1[entry.NOTETM] = true;
                              unique1.push(entry);
                          }
                      });
                      if (mapNursAddNotes.length > 0) {
                          $('#GrdNursAddNotes').jqGrid('clearGridData');
                          $('#GrdNursAddNotes').jqGrid('setGridParam', {
                              data: unique1
                          }).trigger("reloadGrid");
                      }

                      if (unique.length == 0 && unique1.length == 0) {
                          //$.fancybox.close();
                      }
                  }

              }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                  sWaitForPrint = "";
                  ToastMsg('An error occurred while processing your request.', "error");
              }
          });
      }

      function GridBindingNursNotes() {
          jQuery("#GrdNursNotes").jqGrid({
              datatype: 'local',
              colNames: ['Dates', 'Time',],
              colModel: [
                  { name: 'NOTEDT', index: 'NOTEDT', width: 90, align: "left", sortable: false },
                  { name: 'PROBLEMTIME', index: 'PROBLEMTIME', width: 100, sortable: false },],
              rowNum: 9999999999,
              width: 230,
              height: 92,
              viewrecords: true,
              sortorder: "desc",
              loadtext: 'Loading...',
              loadonce: true,
              rownumbers: true,
              shrinkToFit: false,
              cellsubmit: 'clientArray',
          }).trigger("reloadGrid");
      }

      function GridBindingNursAddNotes() {
          jQuery("#GrdNursAddNotes").jqGrid({
              datatype: 'local',
              colNames: ['Dates', 'Time',],
              colModel: [
                  { name: 'NOTEDT', index: 'NOTEDT', width: 90, align: "left", sortable: false },
                  { name: 'NOTETM', index: 'NOTETM', width: 100, sortable: false },],
              rowNum: 9999999999,
              width: 230,
              height: 92,
              viewrecords: true,
              sortorder: "desc",
              loadtext: 'Loading...',
              loadonce: true,
              rownumbers: true,
              shrinkToFit: false,
              cellsubmit: 'clientArray',
          }).trigger("reloadGrid");
      }

      function fetchProblemList() {
          var strIPNO = $("#txtstrUIPNo").val();
          var strMrNo = $("#txtstrUMrNo").val();
          var strDate = $("#Rptdate").val();
          var strToDt = $("#Rptdate1").val();
          var strTime = $('#txtFrmTime').val();
          var strToTime = $('#txtToTime').val();
          var ProblemCode = "";
          var CloseYN = "";
          $.ajax({
              url: '../ICU/GetProblemList?strIPNO=' + strIPNO + '&&strDate=' + strDate + '&&strTime=' + strTime + '&&strToTime=' + strToTime + '&&strToDt=' + strToDt + '&&strproblemcd=' + ProblemCode + '&&CloseYN=' + CloseYN,
              type: 'POST',
              dataType: 'json',
              success: function (response) {

                  var $dropdown = $("#Problist");
                  $dropdown.empty();
                  $dropdown.append('<option value="">---Select---</option>'); // Default option

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

      //Madhuri : Code To search report and highlight
      function selectReport(element) {
          $("#txtReportSearch").val($(element).text());
          $("#reportList").hide(); // Hide dropdown
      }

      function filterTableList() {
          let input = document.getElementById("txtReportSearch").value.toLowerCase();
          let list = document.getElementById("reportList");
          let items = list.getElementsByTagName("li");

          let found = false;
          for (let i = 0; i < items.length; i++) {
              let text = items[i].textContent.toLowerCase();
              if (text.includes(input) && input !== "") {
                  items[i].style.display = "block";
                  found = true;
                  // On click, select report and highlight its corresponding td
                  items[i].onclick = function () {
                      document.getElementById("txtReportSearch").value = items[i].textContent;
                      list.style.display = "none";
                      highlightReportTd(items[i].textContent);
                      $("#txtReportSearch").val("");
                  };
              } else {
                  items[i].style.display = "none";
              }
          }

          list.style.display = found ? "block" : "none"; // Show/hide dropdown list
      }
      function highlightReportTd(selectedText) {
          // Remove highlight from all td elements
          document.querySelectorAll(".Maintable td").forEach(function (td) {
              td.style.border = "";
              td.style.backgroundColor = "";
              td.classList.remove("blink");
              td.style.transition = "all 0.3s ease-in-out";
          });

          document.querySelectorAll(".Maintable input[type='radio']").forEach(function (radio) {
              radio.checked = false;
          });
          let found = false; // Flag to check if a match is found
          let targetTd = null;
          // Find the label matching the selected text
          let labels = document.querySelectorAll(".Maintable label");
          labels.forEach(function (label) {
              if (label.textContent.trim().toLowerCase() === selectedText.trim().toLowerCase()) {
                  let parentTd = label.closest("td"); 
                  if (parentTd) {
                      parentTd.style.border = "1px solid red";
                      parentTd.classList.add("blink");
                      parentTd.style.backgroundColor = "#eaffea"; // Light green 
                      parentTd.setAttribute("tabindex", "-1"); // Make it focusable
                      targetTd = parentTd; // Store the highlighted <td>
                      found = true;
                      $("#txtReportSearch").val("");
                      if (targetTd) {
                          targetTd.focus();
                          targetTd.scrollIntoView({ behavior: "smooth", block: "bottom" }); // Scroll to center of page
                      }

                  }
              }
          });

      }

      function RemoveHighlight() {
          document.querySelectorAll(".Maintable td").forEach(function (td) {
              td.style.border = "";
              td.style.backgroundColor = "";
              td.classList.remove("blink");
              td.style.transition = "all 0.3s ease-in-out";
          });
      }


      // Added by Dhananjay 20250606
      function changeAudit() {
          $("#EmpLst").val("");
          $('#Time, #IsbarYTime, #cmbBundleType, #cmbPBundleType, #FrmTime, #ToTime, #ShiftTime, #ShiftTm, #TimeLabel, #TimeLabel1').hide();
          $("#Rptdate").show();
          $("#Rptdate1").show();
          ShowHideEmpLst();
      }

      //added by ashvini 
      function ExcelChkLst(radioId, subtype) {
          var EmpCode = "";
          var Type = "";
          var IPNO = "";
          var fileName = "";
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
          var datatosend = {
              Type: Type,
              strFrmDate: strFrmDate,
              strToDate: strToDate,
              EmpCode: EmpCode,
              IPNO: IPNO,
              subtype: subtype,
              filename: fileName
          }
          $.ajax({
              url: '../ICU/ChkLstExcel',
              type: "POST",
              dataType: "JSON",
              data: datatosend,
              success: function (response) {
                  stopLoading("loading-EMRRecords");
                  if (response == "success") {
                      window.location.href = '../ICU/DisplayExcelChkLst';

                  }
                  else {
                      if (response == "No Summary Data") {
                          return;
                      }
                      else {
                          ToastMsg("No Data Found","warning");
                      }
                  }
              }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                  ToastMsg('An error occurred while processing your request.', "error");
              }
          });
      }

      function ShowHideEmpLst() {

          $(".EmpLst").hide();
          const selectedAudit = document.querySelector('input[name="icu"]:checked');
          var stripno = $("#txtstrUIPNo").val();
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
          var IPNO = $("#txtstrUIPNo").val();
          var fileName = "Assesment Report.xls";
          var datatosend = {
              strFrmDate: strFrmDate,
              strToDate: strToDate,
              IPNO: IPNO,
              filename: fileName
          }
          $.ajax({
              url: '../ICU/GenerateExcelReports',
              type: "POST",
              dataType: "JSON",
              data: datatosend,
              success: function (response) {
                  stopLoading("loading-EMRRecords");
                  if (response == "success") {
                      window.location.href = '../ICU/DisplayGenerateExcelReports';

                  }
                  else {
                      ToastMsg("No Data Found","warning");
                  }
              }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                  ToastMsg('An error occurred while processing your request.', "error");
              }
          });
      }
  </SCRIPT>

<div class="container-fluid bg-white p-3">

    <!-- Header Div Above Search -->
    <div class="mb-3">
        <div class="card p-2" id="HeadDiv" style="border-radius: 0;">
            <div class="d-flex flex-wrap align-items-center gap-2">

                <!-- Date Fields -->
                <div class="d-flex align-items-center gap-1 flex-wrap">
                    <span id="DATE">Date :</span>
                    <input type="text" id="Rptdate" class="form-control form-control-sm" style="width: 90px;" readonly />
                    <span id="DATE1" style="display: none">To Date :</span>
                    <input type="text" id="Rptdate1" class="form-control form-control-sm" style="width: 90px; display: none" readonly />
                </div>

                <!-- Employee Dropdown -->
                <div class="d-flex align-items-center gap-1 d-none">
                    <span class="EmpLst" style="display: none">Select Emp:</span>
                    <select id="EmpLst" class="form-select form-select-sm" style="min-width: 200px; display: none">
                        <option>--Select--</option>
                    </select>
                </div>

                <!-- Time Dropdowns -->
                <div class="d-flex align-items-center gap-1 flex-wrap">
                    <span id="TimeLabel" style="display: none">Time :</span>
                    <select id="Time" class="form-select form-select-sm" style="width: 80px; display: none">
                        <option>---Select---</option>
                    </select>

                    <span id="TimeLabel1" style="display: none">Time :</span>
                    <select id="IsbarYTime" class="form-select form-select-sm" style="width: 80px; display: none"></select>
                </div>

                <!-- Bundle Type -->
                <div class="d-flex align-items-center gap-1">
                    <span id="lblBundletype" style="display: none">Bundle Type :</span>
                    <select id="cmbBundleType" class="form-select form-select-sm" style="width: 50px; display: none"></select>
                    <select id="cmbPBundleType" class="form-select form-select-sm" style="width: 50px; display: none"></select>
                </div>

                <!-- From / To Time -->
                <div class="d-flex align-items-center gap-1 flex-wrap">
                    <span id="FrmTime">
                        <label>From Time :</label>
                        <input type="text" id="txtFrmTime" class="form-control form-control-sm" style="width: 72px;" readonly />
                    </span>
                    <span id="ToTime">
                        <label>To Time :</label>
                        <input type="text" id="txtToTime" class="form-control form-control-sm" style="width: 72px;" readonly />
                    </span>
                </div>

                <!-- Shift Dropdown -->
                <div class="d-flex align-items-center gap-1" id="ShiftTm">
                    <label><b>Shift :</b></label>
                    <select id="ShiftTime" class="form-select form-select-sm" style="width: 80px;">
                        <option>---Select---</option>
                    </select>
                </div>

            </div>
        </div>
    </div>


    <!-- Search -->
    <div class="row mb-2 align-items-center position-relative">
        <div class="col-md-4 position-relative">
            <input type="text"
                   class="form-control form-control-sm"
                   id="txtSearchReport"
                   placeholder="Search Report..."
                   autocomplete="off" />
            <!-- Dropdown options -->
            <div id="searchOptions" class="border rounded mt-1 bg-white shadow-sm" style="position:absolute;top:100%;width:100%;z-index:1000;max-height:200px; overflow-y:auto;">
                
            </div>
        </div>

    </div>

    <div class="row Maintable">

        <!-- LEFT COLUMN -->
        <div class="col-md-6">

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="CriticalCare">
                <label class="form-check-label fw-semibold" for="CriticalCare">
                    Nursing Care Flowsheet
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TreatmentSheetAdminst">
                <label class="form-check-label fw-semibold" for="TreatmentSheetAdminst">
                    Medication Administration (Incl. Non-Drug)
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TreatmentSheetMedRemark">
                <label class="form-check-label fw-semibold" for="TreatmentSheetMedRemark">
                    Medication Administration
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TreatmentSheetChemoRemark">
                <label class="form-check-label fw-semibold" for="TreatmentSheetChemoRemark">
                    Chemo Administration
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnCriticalAssmnt2">
                <label class="form-check-label fw-semibold" for="rbtnCriticalAssmnt2">
                    INTAKE - OUTPUT Record
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="RespAss">
                <label class="form-check-label fw-semibold" for="RespAss">
                    Respiratory &amp; Neurology Assessment
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnInvasiveLines">
                <label class="form-check-label fw-semibold" for="rbtnInvasiveLines">
                    Invasive Lines &amp; Tubes
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="DiabeticChart">
                <label class="form-check-label fw-semibold" for="DiabeticChart">
                    Diabetic Chart
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="DiacomImg">
                <label class="form-check-label fw-semibold" for="DiacomImg">
                    Dicom Images
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnOrderTestList">
                <label class="form-check-label fw-semibold" for="rbtnOrderTestList">
                    Patient Investigation Details
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnPrphlBndleChkLst">
                <label class="form-check-label fw-semibold" for="rbtnPrphlBndleChkLst">
                    Peripheral Vascular Care Bundle
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnHourlyChart">
                <label class="form-check-label fw-semibold" for="rbtnHourlyChart">
                    Hourly Monitoring Chart
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="ISBARDR">
                <label class="form-check-label fw-semibold" for="ISBARDR">
                    ISBAR (Doctor Hand Over Sheet)
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="ISBAR">
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
                    <input class="form-check-input" type="radio" name="icu" id="ProgrNot">
                    <label class="form-check-label fw-semibold" for="ProgrNot">
                        Progress Notes
                    </label>
                </div>

                <div class="d-flex gap-3">
                    <div class="form-check mb-0">
                        <input class="form-check-input" type="checkbox" id="Nurse">
                        <label class="form-check-label" for="Nurse">Nurse</label>
                    </div>

                    <div class="form-check mb-0">
                        <input class="form-check-input" type="checkbox" id="RMO">
                        <label class="form-check-label" for="RMO">GDMO / RMO</label>
                    </div>

                    <div class="form-check mb-0">
                        <input class="form-check-input" type="checkbox" id="Consultant">
                        <label class="form-check-label" for="Consultant">Consultant</label>
                    </div>
                </div>
            </div>

            <!-- Nursing Care Plans -->
            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                <div class="form-check mb-0">
                    <input class="form-check-input" type="radio" name="icu" id="NursingNotes">
                    <label class="form-check-label fw-semibold" for="NursingNotes">
                        Nursing Care Plans
                    </label>
                </div>

                <div style="min-width:180px;">
                    <select class="form-select form-select-sm" id="Problist">
                        <option value="">---Select---</option>
                    </select>
                </div>
            </div>

           <div class="form-check py-2 border-bottom">
               <input class="form-check-input" type="radio" name="icu" id="NursngAssesmnt">
               <label class="form-check-label fw-semibold" for="NursngAssesmnt">
                   Ongoing Nursing Assessment
               </label>
           </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="BundleChkList">
                <label class="form-check-label fw-semibold" for="BundleChkList">
                    Bundle Check List
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="NursingWithoutChk">
                <label class="form-check-label fw-semibold" for="NursingWithoutChk">
                    Initial Nursing Assessment On Admission
                </label>
            </div>


            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TISS28Score">
                <label class="form-check-label fw-semibold" for="TISS28Score">
                    Tiss Acuity Scoring
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TISS28Score1">
                <label class="form-check-label fw-semibold" for="TISS28Score1">
                    Patient Acuity Scoring
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="TISS28Score2">
                <label class="form-check-label fw-semibold" for="TISS28Score2">
                    BedWise Acuity Score
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnBradenScore">
                <label class="form-check-label fw-semibold" for="rbtnBradenScore">
                    Skin Re-Assessment Braden Score
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="MaxTemp">
                <label class="form-check-label fw-semibold" for="MaxTemp">
                    Date Wise Max. Temperature
                </label>
            </div>

            <!-- Consolidated Investigation -->
            <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                <div class="form-check mb-0">
                    <input class="form-check-input" type="radio" name="icu" id="InvestReport">
                    <label class="form-check-label fw-semibold" for="InvestReport">
                        Consolidated Investigation Reports
                    </label>
                </div>

                <div class="form-check mb-0">
                    <input class="form-check-input" type="checkbox" id="chkInvstg">
                    <label class="form-check-label" for="chkInvstg">All Test</label>
                </div>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnFallRisk">
                <label class="form-check-label fw-semibold" for="rbtnFallRisk">
                    Fall Risk Assessment
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="rbtnPhysclRestrnt">
                <label class="form-check-label fw-semibold" for="rbtnPhysclRestrnt">
                    Physical Restraints Monitoring Sheet
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="PainChart">
                <label class="form-check-label fw-semibold" for="PainChart">
                    Pain Monitoring Chart (Conscious)
                </label>
            </div>

            <div class="form-check py-2 border-bottom">
                <input class="form-check-input" type="radio" name="icu" id="PainChartUnCons">
                <label class="form-check-label fw-semibold" for="PainChartUnCons">
                    Pain Monitoring Chart (Unconscious)
                </label>
            </div>

        </div>

    </div>

    <div class="d-flex justify-content-center align-items-center">
            <button
                id="btnDisplayEMRRecordsBtn"
                type="button"
                class="btn btn-success btn-sm px-4 fw-semibold shadow-sm">
                <i class="bi bi-search me-1"></i>Display
           </button>
    </div>

  <div id='loading-EMRRecords' class='loading-screen' style='display: none; opacity: 0;'></div>

</div>
