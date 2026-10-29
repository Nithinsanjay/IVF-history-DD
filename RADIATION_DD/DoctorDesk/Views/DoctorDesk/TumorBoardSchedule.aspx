<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master"Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TumorBoardSchedule>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
     <style type="text/css">
            .ui-jqgrid tr.jqgrow td {                                                                                 
                word-wrap: break-word; /* IE 5.5+ and CSS3 */
                white-space: pre-wrap; /* CSS3 */
                white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
                white-space: -pre-wrap; /* Opera 4-6 */
                white-space: -o-pre-wrap; /* Opera 7 */x
                overflow: hidden;
                height: auto;
                vertical-align: middle;
                padding-top: 3px;
                padding-bottom: 3px
            } 

    .ui-jqgrid .ui-jqgrid-htable th div                
    {
        height: auto;
        overflow: hidden;
        padding-right: 4px;
        padding-top: 2px;
        position: relative;
        vertical-align: text-top;
        white-space: normal !important;
    }
      .content {
                   width :80%;
                  
               }
        .row{
             margin-right: -7px !important;
    margin-left: -15px !important;
        }
       
        label{
            font-size:12px;
        }
        .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
    background: #fffdc8;
    border: 1px solid #D3D3D3;
    line-height: 15px;
    font-weight:normal;
    color: #272323;
    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
}
.ui-button{
             background: #ffffff !important;
        }
        .ui-datepicker td .ui-state-default{
            background:#005382 !important;
            color: #ffffff !important;
        }
      
         .jqgrid-rownum{
               background: #42525b;
         }

        @media only screen and (max-width : 1024px) {
            #txtDOB{
                width:55%;
            }
            #txtTime{
                width:47%;margin-left: 24% !important;
            }
              #txtweight{
                width:55%;
            }
                #cmbBirthHistorySel{
                width:55% !important;
            }
                  #txtBloodGrp{
                width:55%;
            }
                    #txtMBloodGrp{
                width:55%;
                margin-left:11% !important;
            }
                      #txtEDD{
                          margin-left:26% !important;
                width:55%;
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

              /*Label {
            margin-left: -25px; /*5px;*/
        }*/
               
      .input-group-addon
      {
          width:50px;
      }


      
       .panel-body {
            width:auto !important;
            height:auto !important;
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

        .borderC{

            width: 30%;
    height: 25px;
    padding-top: 2px;
    padding-left: 0px;
        }
        #cmbBirthHistorySel{
            height: 28px !important;}
        /* jQuery UI Datepicker */
.ui-datepicker,
.ui-datepicker-div {
    z-index: 2000 !important;
    position: absolute !important;
}

    </style>
     <style>
        #tblSchemeWrapper {
            max-height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
            border-radius: 5px;
            margin-top: 5px;
            position: absolute;
            width: 100%;
            z-index: 100000000000000;
        }

        #tblScheme {
            margin-bottom: 10px !important;
            background-color: #fbe3e3;
            font-size: 12px;
            box-shadow: 1px 0px 4px 0px #344;
        }

        @media only screen and (min-width : 992px) {
            #tblScheme {
                margin-left: 60px;
            }
        }   

        .SchemeModal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

            .SchemeModal .Scheme-modal-content {
                background-color: white;
                margin: 10% auto;
                width: auto;
                max-width: 95vw;
                border-radius: 5px;
                bottom: auto !important;
                max-height: 95vh;
                overflow: auto;
            }

        .ModelHeaderDiv {
            background-color: #003f74;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 5px;
            font-size: 13px;
        }

        .SchemeHeader {
            background: #043362 !important;
            border-radius: 0px;
        }

        .closeMdlBtn {
            cursor: pointer;
            font-weight: bold;
            font-size: 25px;
            width: 35px;
            height: 25px;
            position: relative;
            top: -5px;
            text-align: center;
        }

        .ModelContentDiv {
            padding: 5px 0px;
        }
    </style>
    <script>
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
            ShowPlanCompleteLst();
            TumorDataBind();
            //$("#btnSearch").click(function () {
            //    //ajaxindicatorstart('Processing...');
            //    Search();
            //});

        });
        function TumorDataBind() {
            var doctorcode = '<%:Session["gDoctCode"]%>';

            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetDoctorsMeetingDet",
                datatype: 'json',
                data: { strDoctCode: doctorcode },
                success: function (response) {
                    console.log(response);
                    $('#GridPlanComplete').jqGrid('setGridParam', {
                        data: response,
                    }).trigger('reloadGrid');
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error:", status, error);
                }
            });
        }


        function Search() {
            var sfrom = "";
            var sto = ""; var MRNumber, PatName, RTNumber = "";
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
            var doctorcode = '<%:Session["gDoctCode"]%>';
            var Type = "L";
            $("#divSearch").find('*').attr('disabled', false);

            //document.getElementById('divGPatDTRpt').style.display = 'block';

            if (sfrom != "" || sto != "") {
                $('.srcInput').css('border-color', '');
                $("#divSearch").find('*').attr('disabled', true);
                //var urlq = '../Oncology/GetPlanCompletedStatus?FromDT=' + sfrom + '&&ToDT=' + sto + '&&FormName=' + FormName + '&&RTNumber=' + RTNumber + '&&MRNumber=' + MRNumber + '&&PatName=' + PatName;
                var urlq = '../DoctorDesk/GetDoctorsMeetingDet?strDoctCode=' + doctorcode + '&type=' + type;
                $("#GridPlanComplete").jqGrid('setGridParam',
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
        function DynamicInv(cellvalue, options, rowObject, GACTION) {
            var rowid = options.rowId;


            var infoBtn = $("<div>")
                .css({
                    "margin-right": "5px",
                    float: "left",
                    cursor: "pointer",
                    "pointer-events": "auto"
                })
                .addClass("ui-pg-div ui-inline-info")
             .attr("onclick", "OpenPopInfoScheme('" + rowObject.MRNO + "', '" + rowObject.TRANNO + "')")

                .attr("title", "Info")
                .append('<span class="ui-icon ui-icon-info"></span>')
                .prop("outerHTML");

            // Combine both icons
            return infoBtn;
        }
        function ShowPlanCompleteLst() {

            $("#GridPlanComplete").jqGrid("GridUnload");

            jQuery("#GridPlanComplete").jqGrid({
                datatype: 'local',
                mtype: 'post',
                colNames: ['Tran No.', 'MR No', 'Patient Name', 'Age', 'Date Of Birth', 'Gender', 'Schedule Date', 'Schedule Time', 'Action'],
                colModel: [
                    { name: 'TRANNO', index: 'TRANNO', width: 150, sortable: false },
                    { name: 'MRNO', index: 'MRNO', width: 100, sortable: false },
                    { name: 'PATNAME', index: 'PATNAME', width: 150, sortable: false },
                    { name: 'PATAGE', index: 'PATAGE', width: 100, sortable: false },
                    { name: 'PATDOB', index: 'PATDOB', width: 100, sortable: false },
                    { name: 'GENDER', index: 'PATCATG', width: 100, align: "left", sortable: true },
                    { name: 'TBMSDATE', index: 'TBMSDATE', width: 100, align: "left", sortable: true },
                    { name: 'TBMSTIME', index: 'TBMSTIME', width: 100, align: "left", sortable: true },
                    { name: 'Action', index: 'Action', align: 'center', width: 200, formatter: DynamicInv }
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
                    // Add visual polishing here if needed
                },
                loadComplete: function () {
                    var ids = $("#GridPlanComplete").jqGrid('getDataIDs');
                    //if (ids.length <= 0) {
                    //    $('#btnSearch').removeClass('DisableButton');
                    //    $.messager.alert("Information", 'No Data Found');
                    //}
                }
            }).trigger("reloadGrid");

            $("#GridPlanComplete").jqGrid('filterToolbar', {
                searchOnEnter: false,
                searchOperators: false,
                defaultSearch: "cn",
                beforeSearch: function () {
                    searchGDYN = "Y";
                }
            });

            // Initial responsive set
            var newWidth = $("#ContentDiv").width();
            $("#GridPlanComplete").jqGrid("setGridWidth", newWidth - 9, false);
            $("#GridPlanComplete").jqGrid("setGridHeight", $("#ContentDiv").height() - 225, true);

            // Make grid responsive on window resize
            $(window).on("resize", function () {
                var newWidth = $("#ContentDiv").width();
                $("#GridPlanComplete").jqGrid("setGridWidth", newWidth - 9, false);
            });
        }
        function OpenPopInfoScheme(Mrno, Tranno) {
            document.getElementById("InfoHeadLabel").innerText = "        Diagnosis Info";
            GetICDDiagnosis(Mrno, Tranno);
            document.getElementById("POPUPInfoModal").style.display = "block";
            document.documentElement.style.overflow = 'hidden';
        }

        //Close Popup Div
        function ClosePop(DivId) {
            document.getElementById(DivId).style.display = 'none';
            document.documentElement.style.overflow = '';
        }
        function BindICDDiagnosisTable(Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDTBody").empty();
            $.grep(Lst, function (a) {
                var Code = a.ICDCODE;
                var Desc = a.NAME;
                var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                var RplTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd);
                $("#TableICDTBody").append(RplTr);
            });
        }
        //Bind ICD-O Diagnosis Table
        function BindICDODiagnosisTable(TopoLst, Lst) {
            var Tr = "<tr>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            $("#TableICDOTBody").empty();
            $.each(Lst, function (_, item) {
                var matchedTopo = TopoLst.find(function (t) {
                    return t.TOPOCODE === item.TOPOCODE;
                });
                if (matchedTopo) {
                    var Code = item.TOPOCODE + item.HCODE + " " + item.HGRADE;
                    var Desc = item.TOPODESC + ", " + item.HDESC + ", " + item.GRADENAME;
                    var TNM = (matchedTopo.TNMPREFIX || '') + (matchedTopo.T || '') + (matchedTopo.N || '') + (matchedTopo.M || '');
                    var CodeTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", Code);
                    var DescTd = Td.replace("{STYLE}", "style='text-align:left;'").replace("{TDCONTENT}", Desc);
                    var TNMTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", TNM || '-');
                    var StageTd = Td.replace("{STYLE}", "style='text-align:center;'").replace("{TDCONTENT}", matchedTopo.STAGE || '-');
                    var FinalTr = Tr.replace("{TRCONTENT}", CodeTd + DescTd + TNMTd + StageTd);
                    $("#TableICDOTBody").append(FinalTr);
                }
            });
        }
        function GetICDDiagnosis(Mrno, Tranno) {

            var DataToSend = {
                strTranNo: Tranno,
                strMRNO: Mrno
            }
            $.ajax({
                url: 'SetDataForDiagnosis',
                type: 'post',
                datatype: 'json',
                data: DataToSend,
                async: false,
                success: function (data) {
                    ICDDiagnosis = "";
                    $("#TableICDOTBody").empty();
                    $("#TableICDTBody").empty();
                    if (data.length > 0) {
                        if (data[1] != null) {
                            $.grep(data[1], function (a) {
                                ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                            });
                            BindICDDiagnosisTable(data[1]);
                        }
                        else if (data[0] != null) {
                            $.grep(data[0], function (a) {
                                ICDDiagnosis = ICDDiagnosis + (ICDDiagnosis == "" ? a.NAME : ("," + a.NAME));
                            });
                        }
                        BindICDODiagnosisTable((data[4] != null ? data[4] : []), (data[5] != null ? data[5] : []));
                    }
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                }
            });
        }


    </script>
    <style>
 .table-responsive {
            overflow-x: auto;
        }

        .MedicineTbl td,
        .MedicineTbl th {
            text-align: center;
            vertical-align: middle !important;
        }

        .MedicineTbl {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: #333;
        }

            .MedicineTbl th, .MedicineTbl td {
                border: 1px solid #ccc;
                padding: 8px 10px;
                text-align: center;
            }

            .MedicineTbl thead {
                font-weight: bold;
                background-color: #6380bb !important;
                color: white;
            }

            .MedicineTbl tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

        .tdCombo {
            padding: 8px 0px !important;
            text-align: center;
        }

        .tdtxt {
            padding: 0px !important;
            text-align: center;
        }
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="PlanCompletedStatus" runat="server" action="./">

           <div style="-webkit-box-shadow: 0px 0px 6px 2px #878888;" class="panel">
    <div class="panel-heading divHeads"
         style="font-size:14px; display: flex; justify-content: space-between; align-items: center; padding: 6px 10px;width: 99.2%; ">
        
        <!-- Left Side: Heading -->
        <span style="font-weight: bold;">Tumor Board Schedule</span>

        <!-- Right Side: Buttons -->
      <%--  <div style="display: flex; align-items: center; gap: 10px;">
<%--            <div id="btnClear" title="Reset" class="btnExcel" onclick="RefreshAction()"></div>--%>
<%--            <div id="btnExcel" title="Excel" class="btnExcel"></div>--%>
<%--            <div id="btnSearch" title="Search" class="fa fa-search"></div>--%>

<%--        </div>--%>
    </div>
</div>

        <div style="display: flex; align-items: center; gap: 10px;">
            <div class="seprateDiv">
                <img src="" class="SeprateClass" />
            </div>
                     <div style="font-size: 12px; display: block" class="panel-body divBody">
                         <table id="tblVitals" style="float: left;;margin-left: -10px;font-size:11px;">
                            <tbody style="line-height: 1.9">
                                <tr>
                                    <td>
                                        <div style="display: flex; align-items: center;">
                                            <!-- Date Checkbox + Label -->
                                            <label style="margin-bottom: 0; display: flex; align-items: center; font-weight: bold; margin-top: -50px;">
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
                                </tr>
                            </tbody>
                        </table>
                
                         </div>
                 </div>
          <div class="container-fluid">
    <div class="row" style="margin-right: 8px; margin-left: -1px;">
        <div class="panel-heading divHeads" style="font-size: 14px; margin-bottom: -2px;">
            Tumor Board Schedule
        </div>
        <div id="ContentDiv" class="col-8" style="overflow-x: auto;">
            <fieldset>
                <table id="GridPlanComplete" class="table table-bordered"></table>
            </fieldset>
        </div>
    </div>
</div>

      </form>
     <div id="POPUPInfoModal" class="SchemeModal" style="justify-content: center; align-items: center ; display:none;">
        <div class="Scheme-modal-content" style="min-width: 300px;">
            <div class="ModelHeaderDiv SchemeHeader">
                <label id="InfoHeadLabel"></label>
                <span class="closeMdlBtn"  onclick="ClosePop('POPUPInfoModal');">&times;</span>
            </div>
            
            <div class="MedicineDiv table-responsive" style="width: 100%">
                <table id="TableICD" class="table table-bordered table-striped MedicineTbl">
                    <thead>
                        <tr>
                            <th style="width: 150px">Code</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody id="TableICDTBody"></tbody>
                </table>
            </div>
            <div class="MedicineDiv table-responsive" style="width: 100%">
                <table id="TableICDO" class="table table-bordered table-striped MedicineTbl">
                    <thead>
                        <tr>
                            <th style="width: 150px">Code</th>
                            <th>Description</th>
                            <th>TNM</th>
                            <th>Stage</th>
                        </tr>
                    </thead>
                    <tbody id="TableICDOTBody"></tbody>
                </table>
            </div>
        </div>
    </div>

</asp:Content>

