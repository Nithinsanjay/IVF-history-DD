<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.SchemeApprovalStatus>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .ui-jqgrid tr.jqgrow td {
            word-wrap: break-word; /* IE 5.5+ and CSS3 */
            white-space: pre-wrap; /* CSS3 */
            white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
            white-space: -pre-wrap; /* Opera 4-6 */
            white-space: -o-pre-wrap; /* Opera 7 */
            overflow: hidden;
            height: auto;
            vertical-align: middle;
            padding-top: 3px;
            padding-bottom: 3px;
        }

        .ui-jqgrid .ui-jqgrid-htable th div {
            height: auto;
            overflow: hidden;
            padding-right: 4px;
            padding-top: 2px;
            position: relative;
            vertical-align: text-top;
            white-space: normal !important;
        }

        .content {
            width: 80%;
        }

        .row {
            margin-right: -7px !important;
            margin-left: -15px !important;
        }

        label {
            font-size: 12px;
        }

        .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
            background: #fffdc8;
            border: 1px solid #D3D3D3;
            line-height: 15px;
            font-weight: normal;
            color: #272323;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
        }

        .ui-button {
            background: #ffffff !important;
        }

        .ui-datepicker td .ui-state-default {
            background: #005382 !important;
            color: #ffffff !important;
        }

        .jqgrid-rownum {
            background: #42525b;
        }

        @media only screen and (max-width : 1024px) {
            #txtDOB {
                width: 55%;
            }

            #txtTime {
                width: 47%;
                margin-left: 24% !important;
            }

            #txtweight {
                width: 55%;
            }

            #cmbBirthHistorySel {
                width: 55% !important;
            }

            #txtBloodGrp {
                width: 55%;
            }

            #txtMBloodGrp {
                width: 55%;
                margin-left: 11% !important;
            }

            #txtEDD {
                margin-left: 26% !important;
                width: 55%;
            }
        }

        .panel {
            margin-bottom: 13px;
        }

        .container {
            padding-right: 0px;
            padding-left: 0px;
            margin-right: auto;
            margin-left: auto;
        }

        /*vijeta 3/5/19*/
        table:not(#tblVitals) {
            width: 100%;
        }

        .switch {
            position: relative;
            display: block;
            vertical-align: top;
            width: 60px;
            height: 21px;
            padding: 3px;
            /*margin: 0 10px 10px 0;*/
            /*background: linear-gradient(to bottom, #eeeeee, #FFFFFF 25px);
  background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF 25px);*/
            border-radius: 18px;
            /*box-shadow: inset 0 -1px white, inset 0 1px 1px rgba(0, 0, 0, 0.05);*/
            cursor: pointer;
        }

        .switch-input {
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
        }

        .switch-label {
            position: relative;
            display: block;
            height: inherit;
            font-size: 10px;
            text-transform: uppercase;
            background: #eceeef;
            border-radius: inherit;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.12), inset 0 0 2px rgba(0, 0, 0, 0.15);
        }

            .switch-label:before, .switch-label:after {
                position: absolute;
                top: 50%;
                margin-top: -.5em;
                line-height: 1;
                -webkit-transition: inherit;
                -moz-transition: inherit;
                -o-transition: inherit;
                transition: inherit;
            }

            .switch-label:before {
                content: attr(data-off);
                right: 11px;
                color: #aaaaaa;
                text-shadow: 0 1px rgba(255, 255, 255, 0.5);
            }

            .switch-label:after {
                content: attr(data-on);
                left: 11px;
                color: #FFFFFF;
                text-shadow: 0 1px rgba(0, 0, 0, 0.2);
                opacity: 0;
            }

        /*.switch-input:checked ~ .switch-label {
        ackground: #0088cc;
            /*box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15 ,rgba(0, , 0, 0.2)}/
        */

        .switch-input:checked ~ .switch-label:before {
            opacity: 0;
        }

        .switch-input:checked ~ .switch-label:after {
            opacity: 1;
        }

        .switch-handle {
            position: absolute;
            top: 4px;
            left: 4px;
            width: 20px;
            height: 20px;
            background: linear-gradient(to bottom, #FFFFFF 40%, #f0f0f0);
            /*background-image: -webkit-linear-gradient(top, #FFFFFF 40%, #f0f0f0);*/
            border-radius: 100%;
            /*box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);*/
        }

            .switch-handle:before {
                content: "";
                position: absolute;
                top: 50%;
                left: 50%;
                margin: -6px 0 0 -6px;
                width: 12px;
                height: 12px;
                background: linear-gradient(to bottom, #eeeeee, #FFFFFF);
                background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF);
                border-radius: 6px;
                box-shadow: inset 0 1px rgba(0, 0, 0, 0.02);
            }

        .switch-input:checked ~ .switch-handle {
            left: 38px;
            box-shadow: -1px 1px 5px rgba(0, 0, 0, 0.2);
        }

        /* Transition
========================== */
        .switch-label, .switch-handle {
            transition: All 0.3s ease;
            -webkit-transition: All 0.3s ease;
            -moz-transition: All 0.3s ease;
            -o-transition: All 0.3s ease;
        }

        .input-form-control {
            height: 24px !important;
        }

        .input-form-addon {
            height: 24.6px;
            padding: 5px 12px !important;
            font-size: 11px !important;
        }

        .input-form-label {
            /*padding-left: 40px !important;*/
            font-size: 12px !important;
        }

        Label {
            margin-left: -25px; /*5px;*/
        }

        .input-group-addon {
            width: 50px;
        }



        .panel-body {
            width: auto !important;
            height: auto !important;
        }

        .panel-heading {
            padding: 2px 5px;
        }

        .divHeads {
            color: #f4f4f4;
            background-color: #3c8dbc;
            border-color: #ddd;
            box-shadow: none;
            font-size: 12px;
            text-align: center;
            font-weight: bold;
        }

        .btn-default:active:hover, .btn-default.active:hover {
            color: #fff;
            background-color: #31b0d5;
            border-color: #269abc;
        }

        .btn-default:active,
        .btn-default.active,
        .open > .dropdown-toggle.btn-default {
            color: #fff;
            background-color: #31b0d5;
            border-color: #269abc;
        }

        .borderC {
            width: 30%;
            height: 25px;
            padding-top: 2px;
            padding-left: 0px;
        }

        #cmbBirthHistorySel {
            height: 28px !important;
        }
        /* jQuery UI Datepicker */
        .ui-datepicker,
        .ui-datepicker-div {
            z-index: 2000 !important;
            position: absolute !important;
        }
      
    </style>

    <script type="text/javascript">
        var SearchCriData = "";
        $(document).ready(function () {

            $("#txtFromDT").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
                onSelect: function () {
                    if (new Date($('#txtFromDT').datepicker('getDate')) > new Date($('#txtToDT').datepicker('getDate'))) {
                        $.messager.alert("Validation", "From date should be less then or equal to todate.");
                    }
                }
            });
            $("#txtToDT").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
                onSelect: function () {
                    if (new Date($('#txtToDT').datepicker('getDate')) < new Date($('#txtFromDT').datepicker('getDate'))) {
                        $.messager.alert("Validation", "To date should be greater then or equal to from date.");
                        $('#txtToDT').datepicker('setDate', 'today');
                    }
                }
            });
            $("#txtToDT").datepicker('setDate', 'today');
            $("#txtFromDT").datepicker('setDate', 'today');
            ShowSchemeApprovalLst();
            document.getElementById("ChkNOFTDate").checked = true;
            $('#ChkNOFTDate').change(function () {
                if (document.getElementById("ChkNOFTDate").checked == true) {
                    $('#txtToDT').removeAttr("disabled", "disabled");
                    $("#txtFromDT").removeAttr("disabled", "disabled");
                    changeColor();
                }
                else {
                    $('#txtToDT').datepicker('setDate', 'today');
                    $('#txtFromDT').datepicker('setDate', 'today');
                    $('#txtToDT').attr("disabled", "disabled");
                    $('#txtFromDT').attr("disabled", "disabled");
                    changeColor();
                }
            });
            $("#PreAPAuthStatus").change(function () {
                changeColor();
            });

            $("#btnSearch").click(function () {
                Search();
            });

            $("#btnExcel").click(function () {
                if ($('#GridSchemeApprovalStat').jqGrid('getGridParam', 'reccount') == 0)
                { $.messager.alert("Information", "No Data for Send to Excel."); return false; }
                var FrmDate, ToDate = "";
                if (document.getElementById('ChkNOFTDate').checked) {
                    FrmDate = $('#txtFromDT').val();
                    ToDate = $('#txtToDT').val();
                }
                else { FrmDate = ""; ToDate = ""; }
                data = $("#GridSchemeApprovalStat").jqGrid('getRowData');
                data = JSON.stringify(data);

                var datatosend = {
                    FrmDate: FrmDate,
                    ToDate: ToDate,
                    data: data,
                    SearchCriteria: SearchCriData
                }
                //ajaxindicatorstart('Processing...');
                PrintExcelAJAXCommon('../DoctorDesk/ExcelBindSchemeApprovalStatusLst', datatosend, false, '../DoctorDesk/DisplayExcelSchemeApprovalStatusLst', true)
            });

            $("#btnClear").click(function () {
                $("#btnSearch").removeClass("DisableButton");
                $('.srchInput').css('border-color', '');
                $('#divSearch').find('*').attr('disabled', false);
                $("#GridSchemeApprovalStat").jqGrid('clearGridData');
            });

        });

        function SetpageDirctn() {
            window.location.href = '../DoctorDesk/PatientEntry';
        }
        function ShowSchemeApprovalLst() {

            $("#GridSchemeApprovalStat").jqGrid("GridUnload");

            jQuery("#GridSchemeApprovalStat").jqGrid({
                datatype: 'json',
                mtype: 'post',
                colNames: ['Transaction No.', 'Transaction Date', 'Transaction Time', 'MR No.', 'Patient Name', 'Company Name', 'Scheme Codes','Schemes', 'Pre Auth Approval Status'],
                colModel: [
                    { name: 'TRANNO', index: 'TRANNO', width: 120, sortable: false },
                    { name: 'TRANDATE', index: 'TRANDATE', width: 101, sortable: false },
                    { name: 'TRANTIME', index: 'TRANTIME', width: 104, sortable: false },
                    { name: 'MRNO', index: 'MRNO', width: 128, sortable: false },
                    { name: 'PATNAME', index: 'PATNAME', width: 290, align: "left", sortable: true },
                    { name: 'COMPNAME', index: 'COMPNAME', width: 290, align: "left", sortable: true },
                    { name: 'SCHEMECODES', index: 'SCHEMECODES', width: 190, align: "left", sortable: true, hidden: true },
                    { name: 'SchemeNames', index: 'SchemeNames', width: 290, align: "left", sortable: true },
                    { name: 'PreAuthStatus', index: 'PreAuthStatus', width: 120, align: "left", sortable: true },
                ],
                shrinkToFit: false,
                forceFit: false,
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadonce: true,
                rownumbers: true,
                rowNum: 99999999,
                hidegrid: false,
                height: 500,
                ignoreCase: true,
                scrollerbar: true,
                loadtext: 'Loading...',
                gridComplete: function () {
                },
                loadComplete: function () {
                    var ids = $("#GridSchemeApprovalStat").jqGrid('getDataIDs');
                    if (ids.length <= 0) {
                        $('#btnSearch').removeClass('DisableButton');
                        $.messager.alert("Information", 'No Data Found');
                    }
                }
            }).trigger("reloadGrid");

            $("#GridSchemeApprovalStat").jqGrid('filterToolbar', {
                searchOnEnter: false,
                searchOperators: false,
                defaultSearch: "cn",
                beforeSearch: function () {
                    searchGDYN = "Y";
                }
            });

            // Initial responsive set
            var newWidth = $("#ContentDiv").width();
            //$("#GridSchemeApprovalStat").jqGrid("setGridWidth", newWidth - 9, false);
            $("#GridSchemeApprovalStat").jqGrid("setGridWidth", newWidth - 2, false);
            $("#GridSchemeApprovalStat").jqGrid("setGridHeight", $("#ContentDiv").height() - 225, true);

            // Make grid responsive on window resize
            $(window).on("resize", function () {
                var newWidth = $("#ContentDiv").width();
                //$("#GridSchemeApprovalStat").jqGrid("setGridWidth", newWidth - 9, false);
                $("#GridSchemeApprovalStat").jqGrid("setGridWidth", newWidth - 2, false);
            });
        }
        function Search() {
            var sfrom = "";
            var sto = "";
            if ($("#ChkNOFTDate").prop('checked')) {
                sfrom = ("" + document.getElementById("txtFromDT").value);
                sto = ("" + document.getElementById("txtToDT").value);
            }
            else {
                sfrom = ""; sto = "";
            }
            if (sto.trim() == '') {
                sto = sfrom;
            }
            var strPreAuthStatus = $("#PreAPAuthStatus").val();
            $("#divSearch").find('*').attr('disabled', false);
            if (sfrom != "" || sto != "" || strPreAuthStatus != "") {
                $('.srcInput').css('border-color', '');
                $("#divSearch").find('*').attr('disabled', true);
                var urlq = '../DoctorDesk/GetSchemeApprovalStatusDetails?FromDT=' + sfrom + '&&ToDT=' + sto + '&&strPreAuthStatus=' + strPreAuthStatus;
                $("#GridSchemeApprovalStat").jqGrid('setGridParam',
                    {
                        url: urlq,
                        datatype: 'json',
                        mtype: 'POST'
                    }).trigger('reloadGrid');
                $('#btnSearch').addClass('DisableButton');
            }
            else {
                $('.srchInput').css('border-color', 'red');
                return false;
            }
        }
        function PrintExcelAJAXCommon(Url, data, async, DisplayURL, flagExcel) {
            $.ajax({
                type: 'POST',
                data: data,
                url: Url,
                cache: false,
                dataType: "json",
                async: async,
                success: function (result) {
                    if (flagExcel == true) {
                        $('#btnExcel').attr('href', DisplayURL);
                        // window.open(DisplayURL);
                        //ajaxindicatorstop();
                    }
                    else {
                        var win = window.open(DisplayURL, "_blank", '', true);
                        win.focus();
                        //ajaxindicatorstop();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error Information", 'An error occurred while processing your request.');
                    //ajaxindicatorstop();
                }
            });
        }
        function changeColor() {
            if ($('#PreAPAuthStatus').val() == "" && $('#ChkNOFTDate').prop('checked') == false) {
                $('#PreAPAuthStatus').css('border-color', 'red');
            }
            else { $('#PreAPAuthStatus').css('border-color', ''); }
        }
    </script>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <form id="PlanCompletedStatus" runat="server" action="./">
      <div style="display: flex; justify-content: space-between; align-items: center; margin: 10px 0;">
        <!-- Back Button (Left) -->
        <a class="button1 button1-green" id="divForBack" onclick="SetpageDirctn()">
            <i class="fa fa-arrow-left"></i>Back
        </a>

        <div class="tab-container">
        </div>
    </div>
      <div style="-webkit-box-shadow: 0px 0px 6px 2px #878888;" class="panel">
          <div class="panel-heading divHeads"
              style="font-size: 14px; display: flex; justify-content: space-between; align-items: center; padding: 6px 10px;">

              <!-- Left Side: Heading -->
              <span style="font-weight: bold;">Scheme Approval Status List</span>


              <!-- Right Side: Buttons -->
              
              <div style="display: flex; align-items: center; gap: 10px;">
                  <div id="btnSearch" style="cursor:pointer;" title="Search" class="fa fa-search"></div>

                  <a id="btnExcel" title="Excel" class="btnExcel" style="cursor:pointer;">
                      <img src="../Images/excel-icon.png" />
                  </a>

                  <a id="btnClear" title="Reset" class="btnClear" style="cursor:pointer;">
                      <img src="../Images/loop.png" style="height:20px;width:20px;" />
                  </a>
              </div>
          </div>
      </div>
      <div style="display: flex; align-items: center; gap: 10px;">
          <div class="seprateDiv">
                <img src="" class="SeprateClass" />
          </div>
          <div style="font-size:12px;display:block" class="panel-body divBody">
              <table id="tblSchemeApprovalLst" style="float: left;margin-left: -10px;font-size:11px;">
                  <tbody style="line-height: 1.9">
                      <tr>
                          <td>
                              <div style="display: flex; align-items: center;">
                                  <!-- Date Checkbox + Label -->
                                  <label style="margin-bottom: 0; display: flex; align-items: center; font-weight: bold; margin-top: -50px;margin-left: -10px;">
                                      <input type="checkbox" id="ChkNOFTDate" style="margin-right: 4px;" />
                                      Date
                                  </label>

                                  <!-- From Date Label -->
                                  <label style="margin-bottom: 0;">From</label>

                                  <!-- From Date Input -->
                                  <%: Html.TextBoxFor(x => x.strFromDt, new {id = "txtFromDT", @class = "form-control input-form-control", style = "width: 100px; margin-left: 4px;"}) %>

                                  <!-- To Date Label -->
                                  <label style="margin-left: 10px; margin-bottom: 0;">To</label>

                                  <!-- To Date Input -->
                                  <%: Html.TextBoxFor(x => x.strToDt, new { id = "txtToDT", @class = "form-control input-form-control", style = "width: 100px; margin-left: 4px;" }) %>
                              </div>
                          </td>
                          <td>
                              <label class="input-form-label" style="margin-left: 20px;margin-top: 5px; width:160px;" >Pre Auth Approval Status</label>
                          </td>

                          <td>
                              <select id="PreAPAuthStatus" name="PreAPSchemeCD" class="form-control srcInput " style="width: 100%;height:0%;">
                                  <option value="">-- Select --</option>
                                  <option value="P">Pending</option>
                                  <option value="W">Waiting For Approval</option>
                                  <option value="A">Approved</option>
                                  <option value="R">Rejected</option>
                              </select>
                          </td>
                      </tr>
                  </tbody>
              </table>
          </div>
      </div>
      <div class="container-fluid">
          <div class="row" style="margin-right: 8px; margin-left: -1px;">
              <div class="panel-heading divHeads" style="font-size: 14px; margin-bottom: -2px;">
                  Scheme Approval Status Details
              </div>
              <div id="ContentDiv" class="col-12" style="overflow-x: auto;">
                  <fieldset>
                      <table id="GridSchemeApprovalStat" class="table table-bordered"></table>
                  </fieldset>
              </div>
          </div>
      </div>
  </form>      
</asp:Content>


