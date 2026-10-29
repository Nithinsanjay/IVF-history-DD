<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>

    <style type="text/css">
        .FilterDiv1 {
            background-color: #efefef;
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 10px 0px;
        }
    
        .investigation-parent-wrapper{
            padding:10px;
        }

        .custom-inv-header{
            border-bottom:4px solid orange;
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

    <style style="text/css">

        .dateColumn {
                width: 140px !important;
            text-align: center;
        }

        .chart-wrapper {
            position: relative;
            width: 100%;
            height: 180px;
        }

        canvas {
            width: 100% !important;
            height: 100% !important;
            background-color: #000;
        }

    #fixedTable,
#outsiderptfixedTable {
    flex: 1;
    overflow-y: auto;
    overflow-x: auto;
    position: relative;
    height: calc(100vh - 220px);
}


    #investigationReportContentSection {
    height: calc(100vh - 220px);
}

.tab-pane {
    height: 100%;
    overflow-y: auto;
}
    
    </style>

<style>
    .table-wrapper {
    width: 100%;
    max-height: 600px;
    overflow: auto;
    position: relative;
}

#tblInvestigationChart {
    border-collapse: separate;
    border-spacing: 0;
    table-layout: fixed;
    min-width: max-content;
}

/* Common cells */
#tblInvestigationChart th,
#tblInvestigationChart td {
    padding: 8px;
    white-space: nowrap;
       border: 1px solid #aaa !important;
    background: #fff;
}

/* Sticky Header */
#tblInvestigationChart thead th {
    position: sticky;
    top: 0;
   background: #bde5f8  !important;
    color: #000;
    z-index: 20;
}

/* Fixed widths */
.first {
    width: 260px;
    min-width: 260px;

}

.second {
    width: 300px;
    min-width: 300px;
}

.third {
    width: 180px;
    min-width: 180px;
}

/* Sticky columns */
#tblInvestigationChart tbody .first,
#tblInvestigationChart thead .first {
    position: sticky;
    left: 0;
    text-align: center;
}

#tblInvestigationChart tbody .second,
#tblInvestigationChart thead .second {
    position: sticky;
    left: 260px;
}

#tblInvestigationChart tbody .third,
#tblInvestigationChart thead .third {
    position: sticky;
    left: 560px; /* 260 + 300 */
}

/* Body z-index */
#tblInvestigationChart tbody .first { z-index: 10; }
#tblInvestigationChart tbody .second { z-index: 9; }
#tblInvestigationChart tbody .third { z-index: 8; }

/* Header z-index */
#tblInvestigationChart thead .first { z-index: 30; }
#tblInvestigationChart thead .second { z-index: 29;text-align: center; }
#tblInvestigationChart thead .third { z-index: 28; text-align: center;}

/* Shadow after last frozen column */
#tblInvestigationChart .third {
    box-shadow: 4px 0 6px rgba(0,0,0,0.15);
}
#tblInvestigationChart th,
#tblInvestigationChart td {
    padding: 8px;
    border: 1px solid #ddd;

    /* Enable wrapping */
    white-space: normal;
    word-break: break-word;
    overflow-wrap: anywhere;

    vertical-align: top;
}
</style>

<style>
    #DateWiseTab table {
    width: 100%;
    border-collapse: collapse !important;
    margin-bottom: 0px;
}

#DateWiseTab th {
    background: #d9edf7;
    border: 1px solid #999 !important;
    text-align: center;
    font-weight: 600;
    padding: 8px 12px !important;
    min-width: 140px;
}

#DateWiseTab td {
    border: 1px solid #999 !important;
    text-align: center;
    padding: 8px 12px !important;
    min-width: 140px;
}

#DateWiseTab .box {
    border: 1px solid #999;
    margin-bottom: 15px;
}
</style>


<style>
    #AbnormalTab table {
    width: 100%;
    border-collapse: collapse !important;
    margin-bottom: 0px;
}

#AbnormalTab th {
    background: #d9edf7;
    border: 1px solid #999 !important;
    text-align: center;
    font-weight: 600;
    padding: 8px 12px !important;
    min-width: 140px;
}

#AbnormalTab td {
    border: 1px solid #999 !important;
    text-align: center;
    padding: 8px 12px !important;
    min-width: 140px;
}

#AbnormalTab .box {
    border: 1px solid #999;
    margin-bottom: 15px;
}
</style>

<script type="text/javascript">

    <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
    var LabFile = $.parseJSON('<%:Html.Raw(Samp.Serialize(ViewBag.LabAttach))%>');
    var InvestigationOrderList = []; //Abhishesh || 20260805 
    var TestNameOrderList = []; //Abhishesh || 20260805 
    $(document).ready(function () {
        //debugger;
        PageLoad();
        BindInvestigationReportPatDetails(); //Abhishesh || 20260806 
        //loadInvestigationReport(sessionStorage.getItem('PatMRNO'));
        loadInvestigationReport(GetSessionMRNO());
        $('#Investigation-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "none";
            loadInvestigationReport(GetSessionMRNO());
        });

        $('#DateWise-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "flex";
            $("#investigationFromDate").val(GetSixLastMonthDate());
            BindDatewiseInvest();
        });

        $('#Abnormal-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "flex";
            $("#investigationFromDate").val(GetSixLastMonthDate());
            BindAbNormalData();
        });

        $('#Trends-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "flex";
            $("#investigationFromDate").val(GetSixLastMonthDate());
            GetTestList();
        });

        $('#OthRpt-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "flex";
            $("#investigationFromDate").val(GetSixLastMonthDate());
            BindTemplRptData();
        });

        $('#Culture-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "flex";
            $("#investigationFromDate").val(GetSixLastMonthDate());
            getCultureResult();
        });

        $('#OutsideRpt-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "none";
            getOutsideReportService();
        });

        $('#OrderWise-tab').click(function () {
            document.getElementById("investigationReportDatePickerSection").style.display = "none";
            $('#txtOrderWiseMRNo').val(GetSessionMRNO());
            $("#OrderWiseFrmDate").val(GetSixLastMonthDate());
            $("#OrderWiseToDate").datepicker("setDate", new Date());
            if ($('#ddlOrderWiseDoctor option').length <= 1) {
                LoadOrderWiseDoctorList();
            }
            $('#btnOrderWiseSearch').trigger('click');
        });


        $("#OrderWiseFrmDate").datepicker({
            showButtonPanel: true, changeMonth: true,
            yearRange: "c-150:c+99", changeYear: true,
            dateFormat: "dd/mm/yy", maxDate: new Date()
        });
        $("#OrderWiseToDate").datepicker({
            showButtonPanel: true, changeMonth: true,
            yearRange: "c-150:c+99", changeYear: true,
            dateFormat: "dd/mm/yy", maxDate: new Date()
        });

        $('#chkMyOrder').on('change', function () {
            if ($(this).is(':checked')) {
                var currentDoctCode = $('#hdnCurrentDoctCode').val().trim();
                $('#ddlOrderWiseDoctor').val(currentDoctCode);
                $('#ddlOrderWiseDoctor').prop('disabled', true);
            } else {
                $('#ddlOrderWiseDoctor').prop('disabled', false);
                $('#ddlOrderWiseDoctor').val('');
            }
        });

        $('#btnOrderWiseSearch').on('click', function () {
            BindOrderWiseData();
        });
    });

    //Get Last 6 Month Date
    function GetSixLastMonthDate() {
        var CurrentDT = new Date();
        CurrentDT.setMonth(CurrentDT.getMonth() - 6);
        var formattedDate =
            String(CurrentDT.getDate()).padStart(2, '0') + '/' +
            String(CurrentDT.getMonth() + 1).padStart(2, '0') + '/' +
            CurrentDT.getFullYear();
        return formattedDate;
    }

    //Abhishesh || 20260806 
    function BindInvestigationReportPatDetails() {
        var moduleFlag = sessionStorage.getItem('MODULE_FLAG') || 'OPD';
        if (moduleFlag == "PAC") {
            $('#InvRpt_PatName').text(sessionStorage.getItem("PACPatName"));
            $('#InvRpt_MRNO').text(sessionStorage.getItem("PACPatMRNO"));
            $('#InvRpt_Gender').text(sessionStorage.getItem("PACPatGender"));
            $('#InvRpt_Age').text(sessionStorage.getItem("PACPatAge"));
            $('#InvRpt_IPNoWrap').hide();
        }
        else {
            $('#InvRpt_PatName').text($('#HeaderSection_PatDetails_PatName').text().trim());
            $('#InvRpt_MRNO').text($('#HeaderSection_PatDetails_MRNO').text().replace(/\s+/g, ' ').trim());
            $('#InvRpt_Gender').text($('#HeaderSection_PatDetails_GENDER').text().replace(/\s+/g, ' ').trim());
            $('#InvRpt_Age').text($('#HeaderSection_PatDetails_AGE').text().replace(/\s+/g, ' ').trim());
            if (moduleFlag == 'IPD') {
                $('#InvRpt_IPNo').text($('#HeaderSection_PatDetails_ipNo').text().replace(/\s+/g, ' ').trim());
                $('#InvRpt_IPNoWrap').show();
            } else {
                $('#InvRpt_IPNoWrap').hide();
            }
        }
    }
    //End
        function LoadOrderWiseDoctorList() {
            $.ajax({
                type: 'GET',
                url: '../DoctorDesk/GetDoctors',
                data: { DoctName: '', Type: 'D' },
                dataType: 'json',
                success: function (response) {
                    var ddl = $('#ddlOrderWiseDoctor');
                    ddl.empty();
                    ddl.append('<option value="">---Select Doctor---</option>');
                    if (response && response.length > 0) {
                        $.each(response, function (i, doc) {
                            ddl.append('<option value="' + doc.DoctCode + '">'
                                + doc.DoctName + '</option>');
                        });
                    }
                }
            });
        }

        function BindOrderWiseData() {
            var mrno = $('#txtOrderWiseMRNo').val().trim();
            var frmDate = $('#OrderWiseFrmDate').val().trim();
            var toDate = $('#OrderWiseToDate').val().trim();
            var doctCode = $('#ddlOrderWiseDoctor').val();

            if (frmDate === '' || toDate === '') {
                $.alert("Please select From and To dates.", "Validation");
                return;
            }

            $('#divOrderWiseResult').html(
                '<div style="text-align:center;padding:20px;color:#555;">' +
                '<i class="fa fa-spinner fa-spin"></i> Loading...</div>'
            );

            $.ajax({
                type: 'GET',
                url: '../DoctorDesk/GetInvestigationAdviceOrderStatus',
                data: { MrnNo: mrno, FrmDate: frmDate, ToDate: toDate, DoctCode: doctCode },
                dataType: 'json',
                success: function (response) {
                    if (!response || response === 'Unsucessfull') {
                        ToastMsg('No Data found', 'info');
                        $('#divOrderWiseResult').html('');
                        return;
                    }
                    RenderOrderWiseTable(response);
                },
                error: function () {
                    ToastMsg('Error loading Order Wise Report', 'error');
                    $('#divOrderWiseResult').html('');
                }
            });
        }
    function RenderOrderWiseTable(data) {
        if (!data || data.length === 0) {
            ToastMsg('No Data found', 'info');
            $('#divOrderWiseResult').html('');
            return;
        }

        // Create table container
        $('#divOrderWiseResult').html(
            '<div id="tblOrderWiseReport"></div>'
        );

        // Map data for Tabulator
        var tableData = [];
        $.each(data, function (i, row) {
            var statusText = '';
            if (!row.BILLNO || row.BILLNO.toString().trim() === '') {
                statusText = 'UnBilled';
            } else if (!row.TESTSTATUS || row.TESTSTATUS.toString().trim() === '') {
                statusText = 'Billed';
            } else {
                statusText = row.TESTSTATUS;
            }

            tableData.push({
                CONSULTATIONNO: row.CONSULTATIONNO || '',
                DATETIME: row.DATETIME || '',
                ADVISEDBY: row.ADVISEDBY || '',
                TESTNAME: row.TESTNAME || '',
                STATUS: statusText,
                BILLNO: row.BILLNO || '',
                RESULTNO: row.RESULTNO || '' // Abhsihesh || 20260805
            });
        });

        // Initialize Tabulator
        new Tabulator("#tblOrderWiseReport", {
            data: tableData,
            layout: "fitColumns",
            height: "calc(100vh - 300px)",
            autoResize: true,
            resizableColumns: true,
            rowHeader: {
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 40
            },
            columns: [
                //Abhsihesh || 20260805
                {
                    title: "Action",
                    field: "act",
                    hozAlign: "center",
                    width: 60,
                    frozen: true,
                    headerSort: false,
                    formatter: function (cell) {
                        var rowData = cell.getRow().getData();
                        if (!rowData.RESULTNO || rowData.RESULTNO.toString().trim() === "") {
                            return "";
                        }
                        if (rowData.STATUS == "Reported") {
                            return "<img src='../Images/result-entry-no.png' title='Print Report' style='cursor:pointer;width:18px;height:18px;' />";
                        }
                        else if (rowData.STATUS == "Verified") {
                            return "<img src='../Images/result-entry-yes.png' title='Print Report' style='cursor:pointer;width:18px;height:18px;' />";
                        }
                        return "";
                    },
                    cellClick: function (e, cell) {
                        //var rowData = cell.getRow().getData();
                        //PrintOrderWiseResult(rowData);
                        if (e.target.tagName === "IMG") {
                            var rowData = cell.getRow().getData();
                            PrintOrderWiseResult(rowData);
                        }
                    }
                },
                //End
                {
                    title: "Consultation No.",
                    field: "CONSULTATIONNO",
                    headerFilter: "input",
                    width: 160,
                    frozen: true
                },
                {
                    title: "Date Time",
                    field: "DATETIME",
                    headerFilter: "input",
                    width: 160
                },
                {
                    title: "Advised By Doctor",
                    field: "ADVISEDBY",
                    headerFilter: "input",
                    width: 180
                },
                {
                    title: "Test",
                    field: "TESTNAME",
                    headerFilter: "input",
                    widthGrow: 2
                },
                {
                    title: "Status",
                    field: "STATUS",
                    headerFilter: "input",
                    width: 120,
                    formatter: function (cell) {
                        return cell.getValue();

                    }
                }
            ]
        });
    }
    //Abhishesh || 20260805
    function PrintOrderWiseResult(rowData) {
        if (!rowData.RESULTNO) {
            ToastMsg('Result not yet available for this order', 'warning');
            return;
        }
        var Mrno = GetSessionMRNO();
        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/PrintInvestigationOrderResult',
            data: { ResultNo: rowData.RESULTNO, MRNo: Mrno  },
            dataType: 'json',
            success: function (result) {
                if (result == "Success") {
                    var win = window.open('../DoctorDesk/DisplayPrintInvestigationOrderResult', '_blank');
                    win.focus();
                } else {
                    ToastMsg(result, 'info');
                }
            },
            error: function () {
                ToastMsg('Error printing report', 'error');
            }
        });
    }
   // End
   function BuildOrderWiseRows(data) {
       var rows = '';
       $.each(data, function (i, row) {
           var bgColor = (i % 2 === 0) ? '#c5eff17a' : '#e8ba541c';

           var statusText = '';
           if (!row.BILLNO || row.BILLNO.toString().trim() === '') {
               statusText = '<span style="color:red;font-weight:bold;">UnBilled</span>';
           } else if (!row.TESTSTATUS || row.TESTSTATUS.toString().trim() === '') {
               statusText = '<span style="color:orange;font-weight:bold;">Billed</span>';
           } else {
               statusText = '<span style="color:green;font-weight:bold;">'
                   + row.TESTSTATUS + '</span>';
           }

           rows += '<tr style="background:' + bgColor + ';">' +
               '<td style="padding:6px;border:1px solid #ddd;white-space:nowrap;">' + (row.CONSULTATIONNO || '') + '</td>' +
               '<td style="padding:6px;border:1px solid #ddd;white-space:nowrap;">' + (row.DATETIME || '') + '</td>' +
               '<td style="padding:6px;border:1px solid #ddd;white-space:nowrap;">' + (row.ADVISEDBY || '') + '</td>' +
               '<td style="padding:6px;border:1px solid #ddd;">' + (row.TESTNAME || '') + '</td>' +
               '<td style="padding:6px;border:1px solid #ddd;white-space:nowrap;">' + statusText + '</td>' +
               '</tr>';
       });
       return rows;
   }

   function sortOrderWiseTable(colIndex) {
       var data = window.orderWiseData;
       var keys = ['CONSULTATIONNO', 'DATETIME', 'ADVISEDBY', 'TESTNAME', 'BILLNO'];

       // Toggle direction
       if (window.orderWiseSortCol === colIndex) {
           window.orderWiseSortDir = window.orderWiseSortDir === 'asc' ? 'desc' : 'asc';
       } else {
           window.orderWiseSortCol = colIndex;
           window.orderWiseSortDir = 'asc';
       }

       // Reset all arrows
       for (var i = 0; i <= 4; i++) {
           $('#arrow_' + i).html('&#9652;');
       }

       // Set active arrow
       if (window.orderWiseSortDir === 'asc') {
           $('#arrow_' + colIndex).html('&#9652;');
       } else {
           $('#arrow_' + colIndex).html('&#9662;');
       }

       // Sort data
       var key = keys[colIndex];
       var sorted = data.slice().sort(function (a, b) {
           var valA = (a[key] || '').toString().toLowerCase();
           var valB = (b[key] || '').toString().toLowerCase();
           if (window.orderWiseSortDir === 'asc') {
               return valA > valB ? 1 : valA < valB ? -1 : 0;
           } else {
               return valA < valB ? 1 : valA > valB ? -1 : 0;
           }
       });

       // Re-render rows only
       $('#orderWiseTbody').html(BuildOrderWiseRows(sorted));
   }

   function PageLoad() {


        $("#investigationFromDate").datepicker(
        {
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            maxDate: new Date(),
            onSelect: function (selected) {
                if (new Date($('#RptFrmDate').datepicker('getDate')) > new Date($('#RptToDate').datepicker('getDate'))) {
                    $.alert("From date should be less then or equal to todate.", "Validation");
                    return;
                }
                callActiveTabFunction();
            }
        })

        $("#investigationToDate").datepicker(
        {
            showButtonPanel: true,
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            maxDate: new Date(),
            //minDate: admissiondate
            onSelect: function (selected) {
                if (new Date($('#RptToDate').datepicker('getDate')) < new Date($('#RptFrmDate').datepicker('getDate'))) {
                    $.alert("To date should be greater then or equal to from date.", "Validation");
                    return;
                }
                callActiveTabFunction();
            }
        });

        $("#investigationFromDate").datepicker("setDate", new Date());
        $("#investigationToDate").datepicker("setDate", new Date());
        document.getElementById("investigationReportDatePickerSection").style.display = "none";
    }

    // Get Active Tab & Auto Call Start

    function getActiveTabId() {
        return $('#investigationReportTabsSection .nav-link.active').attr('id');
    }

    function callActiveTabFunction() {
        const activeTabId = getActiveTabId();

        if (!activeTabId) return;

        if (activeTabId == 'Investigation-tab') {
            loadInvestigationReport(GetSessionMRNO());
        }
        else if (activeTabId == 'DateWise-tab') {
            BindDatewiseInvest();
        }
        else if (activeTabId == 'Abnormal-tab') {
            BindAbNormalData();
        }
        else if (activeTabId == 'Trends-tab') {
            GetTestList();
        }
        else if (activeTabId == 'OthRpt-tab') {
            BindTemplRptData();
        }
        else if (activeTabId == 'Culture-tab') {
            getCultureResult();
        }
        else if (activeTabId == 'OutsideRpt-tab') {
            getOutsideReportService();
        }
        else if (activeTabId == 'OrderWise-tab') {
            BindOrderWiseData();
        } 
    }

    // Get Active Tab & Auto Call Ends 

    //Abhishesh || 20260805 
    function sortByInvestigationOrder(list, key, orderList) {
        var useList = orderList || InvestigationOrderList;
        return list.slice().sort(function (a, b) {
            var idxA = useList.indexOf($.trim(a[key]));
            var idxB = useList.indexOf($.trim(b[key]));
            if (idxA === -1) idxA = useList.length;
            if (idxB === -1) idxB = useList.length;
            return idxA - idxB;
        });
    }
    //End


    // Outside Report Start

    function getOutsideReportService() {
        return new Promise(function (resolve, reject) {
            startLoading('Loading');
            $.ajax({
                type: 'POST',
                url: '../DoctorDesk/GetLabAttachment',
                datatype: 'json',
                data: { MRNO: GetSessionMRNO() },
                success: function (response) {
                    //priyanika 14/03/2026
                    if (response && response.length > 0) {
                        showLabFiles(response);
                    }
                    else {
                        ToastMsg('No Data found', 'info');
                    }
                },
                error: function (xhr, status, error) {
                    ToastMsg("Error loading outside report", "error");
                },
                complete: function () {
                    stopLoading();
                }
            })
        })
    }

    function showLabFiles(File) {
        if (File != null) {
            if (File.length >= 1) {
                $('#tbl1 tbody').empty();
                for (i = 0; i < File.length; i++) {
                    var rows = "<tr> <td class='disp' style='cursor:pointer' onclick='openLabNewWin(this)'><u>" + File[i] + "</u></td><tr>";
                    $('#tbl1 tbody').append(rows);
                }
                $("#outRptPresent").show();
            }
            else
                $("#outRptPresent").hide();
        }
        else
            $("#outRptPresent").hide();
    }

    function openLabNewWin(obj) {
        NAME = obj.innerText;
        var MRNO = GetSessionMRNO();
        var url = "../DoctorDesk/LabFileDownload?MRNo=" + MRNO + "&&filename=" + NAME
        window.open(url, 'Image/pdf', 'width=900px,height=600px,resizable=1');
        //var Details = '<a href=' + url + ' id="imgdownload" download=' + NAME + '>Download file</a>';
        //return Details;
    }

    // Outside Report Ends 


    // Culture Tab Starts

    function getCultureResult() {

        $('#CultureTab').empty();

        var strMRNO = GetSessionMRNO();
        var frmDate = $("#investigationFromDate").val();
        var toDate = $("#investigationToDate").val();

        startLoading('Loading');
        $.ajax({
            type: "POST",
            url: "../DoctorDesk/GetCultureResult",
            data: {
                MrnNo: strMRNO,
                strFrmDate: frmDate,
                strTodate: toDate
            },
            dataType: "json",
            success: function (response) {
                if (response) {
                    var data = (JSON.parse(response)).Results
                    for (let i = 0; i < data.length; i++) {
                        BindCultureRptData(data[i])
                    }
                }
                else {
                    ToastMsg('No Data found', 'info');
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                ToastMsg("Error loading Culture report", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
    }

    function BindCultureRptData(result) {

        if (result != null) {
            $("#tblVitalHistory").empty();
            $("#resultInfoDiv").remove(); // Remove existing resultInfoDiv if present
            $("#footerInfoDiv").remove(); // Remove existing footerInfoDiv if present

            // Create tbldiv CultureTab for each record with a unique ID
            var $tbldiv = $('<div class="tbldiv" id="tbldiv_' + result.RESULTNO + '" style="overflow-x:auto;"></div>');

            // Create divCaption with a toggle icon
            var formattedDate = formatDate(result.RESULTDATE);
            var resultNo = result.RESULTNO || '';
            // var $divCaption = $('<div class="panel-heading divHeads" style="text-align:center;font-size:14px;background-color:rgba(107, 107, 107, 0.12941176470588237);"></div>');
             // var $divCaption = $('<div class="panel-heading divHeads" style="text-align:center;font-size:14px;background-color:rgba(107, 107, 107, 0.12941176470588237);"></div>');
            var $divCaption = $('<div class="panel-heading divHeads" style="text-align:center;font-size:14px;background-color:lightgreen;"></div>');
            var leftText = "Result Date " + formattedDate;
            var leftText1 = "Time " + ':' + result.RESULTTIME;
            var middleText = "Result No : " + resultNo + " ";

            //$divCaption.html('<div class="left-side" style="position:relative;padding:0;margin: 0; flex: 1;background:none;">' + leftText + '</div>' +
            //                 '<div class="left-side" style="position:relative;padding:0;margin: 0; flex: 1;background:none;font-size:14px;">' + leftText1 + '</div>' +
            //                 '<div class="middle-side" >' + middleText + '</div>' +
            //                 '<i class="fa fa-caret-right spanCls"></i>'); // Add toggle icon

            //$tbldiv.append($divCaption); // Append caption to tbldiv

            $divCaption.html(
                "<table style='width:100%;color:black;font-size:16px;'>" +    /* Font-Size Change  By Abhishesh || 20260420*/
                "<tr>" +
                "<td style='width:24.90%;position:relative;padding:0;margin:0;'>" + leftText + "</td>" +
                "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + leftText1 + "</td>" +
                "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + '<span class="TestName">Test Name:</h4> <span>' + (result.TESTNAME || '') + '</span>' + "</td>" +
                "<td style='width:24.90%;position:relative;padding:0;margin:0;background:none;'>" + middleText + "</td>" +
                "<td style='width:auto;position:relative;padding:0;margin:0;'><i class='fa fa-caret-right spanCls'></i></td>" +
                "</tr>" +
                "</table>"
            );

            $tbldiv.append($divCaption);

            // First row: Result Date and Result No
            var $firstRow = $('<div class="first-row" style="display:flex;margin-bottom:10px;"></div>');
            //  $firstRow.append('<h5 style="font-weight:bold;">Result Date/Time:</h5> <h5 style="margin-right: 57%;">' + (formattedDate + ' ' + result.RESULTTIME || '') + '</h5>');
            $firstRow.append('');
            $tbldiv.append($firstRow);

            // Second row: Test Name
            var $secondRow = $('<div class="second-row"></div>');
            // $firstRow.append('<h4 class="TestName" style="font-weight:bold;font-size:16px;">Test Name:</h4> <h4 style="font-size:16px;">' + (result.TESTNAME || '') + '</h4>');
            $tbldiv.append($secondRow);

            var $tblVitalHistory = $('<table class="table" style="width:100%; border-collapse:collapse; border:1px solid #999;"></table>');

            // Create table headers
            var $th = "<thead><tr style='background-color:#d9edf7;font-size:14px;'>" +
                "<th style='border:1px solid #999 ;background: lightblue;text-align:center;'>Antibiotics</th>" +
                "<th style='border:1px solid #999;background: lightblue;text-align:center;'>MIC</th>" +
                "<th style='border:1px solid #999; background: lightblue;text-align:center;'>Interpretation</th>" +
                "</tr></thead>"; /* Font-Size Added By Abhishesh || 20260420*/
            $tblVitalHistory.append($th); // Append headers to tblVitalHistory
            var $tbody = $("<tbody></tbody>"); // Create tbody for table data

            // Add table rows with result details
            var rows = "";
            $.each(result.CultureResults, function (i, item) {
                var cultypeStyle = (item.CULTYPE === "O") ? "font-size:12px; color:yellowgreen;" : ""; /* Font-Size Added By Abhishesh || 20260420*/
                rows += "<tr>" +
                    "<td style='width:20%; font-size:12px;text-align:center;" + cultypeStyle + "'>" + item.ANTIBIOTIC + "</td>" +
                    "<td style='width:20%;font-size:12px;border:1px solid #999;text-align:center;'>" + item.MICVALUE + "</td>" +
                    "<td style='width:20%;font-size:12px;border:1px solid #999;text-align:center;'>" + item.Column1 + "</td>" +
                    "</tr>";
            });

            $tbody.append(rows);
            $tblVitalHistory.append($tbody); // Append tbody to tblVitalHistory

            // Append tblVitalHistory to tbldiv
            $tbldiv.append($tblVitalHistory);

            var $footerInfoDiv = $('<div class="footerInfo" style="margin-top:0px;padding:5px;background-color:#f0f0f1;box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);"></div>');
            //$footerInfoDiv.append('<div style="display:flex;margin-bottom:10px;">' +
            //    '<h5 style="font-weight:bold;font-size:14px;">Verify Date/Time:</h5> <h5 style="margin-right: 58%;font-size:14px;">' + (formatDate(result.VERIFIEDON) + '  ' + result.VERIFIEDAT || '') + '</h5>' +
            //    '<h5 style="font-weight:bold;font-size:14px;float:right;">Verify By:</h5> <h5 style="font-size:14px;">' + (result.VERIFIEDBY || '') + '</h5>' +
            //    '</div>');
            //$footerInfoDiv.append('<span style="font-weight:bold;font-size:14px;">Culture Comment:</span> <span style="font-size:14px;">' + result.CULTCOMMENT || '' + '</span>');

            $footerInfoDiv.html(
                "<table style='width:100%;color:black;'>" +
                "<tr>" +
                "<td style='width:33.33%;position:relative;padding:0;margin:0;font-size:14px;'>" + "<span style='font-weight:bold;font-size:14px;'>Verify Date/Time: </span>" + (formatDate(result.VERIFIEDON) + '  ' + result.VERIFIEDAT || '') + "</td>" +
                "<td style='width:33.33%;position:relative;padding:0;margin:0;font-size:14px;'>" + "<span style='font-weight:bold;font-size:14px;'>Verify By: </span>" + (result.VERIFIEDBY || '') + "</td>" +
                "</tr>" +
                "<tr>" +
                "<td colspan='2' style='position:relative;padding:0;margin:0;margin-top:5px;font-size:12px;'>" +
                "<span style='font-weight:bold;font-size:14px;'>Culture Comment:</span> <span style='font-size:14px;'>" + (result.CULTCOMMENT || '') + "</span>" +
                "</td>" +
                "</tr>" +
                "</table>"
            );


            $tbldiv.append($footerInfoDiv);

            // Append footerInfoDiv to tbldiv - 
            $tbldiv.append($footerInfoDiv);

            // Append tbldiv to the parent container - 
            $("#CultureTab").append($tbldiv);

            $divCaption.click(function () {
                var $tbldiv = $(this).closest('.tbldiv');
                var $table = $tbldiv.find('.table');
                var $firstRow = $tbldiv.find('.first-row');
                var $footerInfoDiv = $tbldiv.find('.footerInfo');
                var $icon = $(this).find('.spanCls');
                var $secondrow = $(this).find('.second-row')

                $table.toggle();
                $firstRow.toggle();
                $footerInfoDiv.toggle();
                $secondrow.toggle();

                // Rotate icon based on visibility 
                $(this).toggleClass('open');
            });

            // Initially hide the table, firstRow, and footerInfoDiv content
            $tbldiv.find('.table, .first-row, .second-row ,.footerInfo').hide();

        } else {
            // Handle scenario when no data is found
            $("#CultureTab").empty().append("<div>No data available</div>"); // Replace #container with your parent element ID or class
        }
    }

    function formatDate(yyyymmdd) {
        var year = yyyymmdd.substring(0, 4);
        var month = parseInt(yyyymmdd.substring(4, 6), 10) - 1;
        var day = yyyymmdd.substring(6, 8);

        // Create a new Date object
        var date = new Date(year, month, day);

        var options = { year: 'numeric', month: 'long', day: 'numeric' };

        // Format the date using toLocaleDateString
        return date.toLocaleDateString('en-US', options);
    }


    // Culture Tab Ends 


    // Trends Starts

    function GetTestList() {

        const frmDate = $("#investigationFromDate").val();
        const toDate = $("#investigationToDate").val();
        const strmrno = GetSessionMRNO();

        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/GetTrendsTestCode',
            dataType: 'json',
            cache: false,
            async: false,
            data: {
                mrNo: strmrno,
                FrmDate: frmDate,
                ToDate: toDate
            },
            success: function (response) {

                if (response === "Unsucessfull") {
                    resetTrendUI();
                    ToastMsg('No Data found', 'info');
                    return;
                }

                const ParseResult = sortByInvestigationOrder(JSON.parse(response), 'TESTNAME', TestNameOrderList); //Abhishesh || 20260805
                
                $("#chartNote").hide();
                $("#divCharts").empty();
                $("#lblTestName").text("");
                $("#TestListDivHead").removeClass("d-none");
                $("#TestListDiv").empty();

                let html = "";

                $.each(ParseResult, function (i, e) {

                    const color = getRandomColor();
                    const fullName = e.TESTNAME.trim();
                    const shortName = fullName.length > 20
                        ? fullName.substring(0, 20) + "..."
                        : fullName;

                    html += `
                    <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-2">
                        <button 
                    type="button"
                    id="${e.TESTCODE}"
                            class="btn w-100 text-truncate fw-semibold"
                            style="background-color:${color}; font-size:11px;"
                    title="${fullName}"
                    onclick="GetTestTrends(this)">
                    ${shortName}
                    </button>
                </div>`;
                });

                $("#TestListDiv").append(html);
            },
            error: function () {
                ToastMsg("Error loading investigation report", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
    }

    function resetTrendUI() {
        $("#TestListDiv").empty();
        $("#TestListDivHead").addClass("d-none");
        $("#divCharts").empty();
        $("#chartNote").hide();
    }

    function getRandomColor() {
        color = "hsl(" + Math.random() * 12000 + ", 30%, 60%)";
        return color; 
    }
    function GetTestTrends(obj) {
        $('#lblTestName').text('');

        const TestCode = obj.id;
        const TestName = obj.title;

        GetTrendWiseData(TestCode);

        $('#lblTestName').text(" [" + TestName.trim() + "] ");
    }

    function GetTrendWiseData(TestCode) {

        const frmDate = $("#investigationFromDate").val();
        const toDate = $("#investigationToDate").val();
        const strmrno = GetSessionMRNO();

        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/GetTrendsInvestigation',
            dataType: 'json',
            cache: false,
            async: false,
            data: {
                mrNo: strmrno,
                TestCode: TestCode,
                strFrmDate: frmDate,
                strTodate: toDate
            },
            success: function (response) {

                if (response === "Unsucessfull") {
                    ToastMsg('No Data found', 'info');
                    return;
                }

                $('#chartNote').removeClass('d-none');

                const result = JSON.parse(response);
                result.INVESTDESC = sortByInvestigationOrder(result.INVESTDESC, 'INVESTDESC', InvestigationOrderList); //Abhishesh || 20260805
                const $chartContainer = $('#divCharts');

                $chartContainer.empty();

                $.each(result.INVESTDESC, function (i, v) {

                    const chartId = "line-chart" + i;

                    const html = `
                    <div class="col-12 col-md-6 mb-2">
                        <div class="card">
                            <div class="card-body p-2">
                                <p class="fw-semibold mb-1 small">${v.INVESTDESC}</p>
                                <canvas id="${chartId}" width="203" height="77"></canvas>
                            </div>
                        </div>
                    </div>`;

                    $chartContainer.append(html);

                    // IMPORTANT: Delay chart rendering until canvas is in DOM
                    setTimeout(function () {
                        tableTrendsLineData(result, v.INVESTDESC, i);
                    }, 0);
                });
            },
            error: function () {
                ToastMsg("Error loading Trend report", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
    }


    function tableTrendsLineData(result, datafilter, idval) {
        var finalFilterdata = jQuery.grep(result.Table, function (a, index) {
            return (a.INVESTDESC == datafilter);
        });

        /*----------------------labeldata-------------------------------------------------------*/
        var lablelval = $(finalFilterdata).map(function (idex, val) {
            return (val.RESULTDATE);
        }).get().join(',');

        var temp = new Array();
        temp = lablelval.split(",");

        /*----------------------labeldata-------------------------------------------------------*/

        /*----------------------Resultdata-------------------------------------------------------*/

        var actulD = $(finalFilterdata).map(function (idex, val) {
            return $.trim(parseFloat(val.RESULTDT));
        }).get().join(',')

        var Actualdata = new Array();
        Actualdata = actulD.split(",");

        /*----------------------Resultdata-------------------------------------------------------*/

        var Norm1 = $(finalFilterdata).map(function (idex, val) {
            return $.trim(parseFloat(val.NORMALVAL1));
        }).get().join(',')

        var normalData1 = new Array();
        normalData1 = Norm1.split(",");
        console.log(normalData1);

        var Normdata1 = new Array();
        for (var m = 0; m < finalFilterdata.length; m++) {
            Normdata1.push(normalData1[0])
        }

        var Norm2 = $(finalFilterdata).map(function (idex, val) {
            return $.trim(parseFloat(val.NORMALVAL2));
        }).get().join(',')

        var normalData2 = new Array();
        normalData2 = Norm2.split(",");

        var Normdata2 = new Array();
        for (var m = 0; m < finalFilterdata.length; m++) {
            Normdata2.push(normalData2[0])
        }


        var selector = '#line-chart' + idval
        var lineChartData = {
            labels: temp,
            datasets: [
                {
                    label: "My dataset",
                    fillColor: "rgba(255,255,255,0)",
                    strokeColor: "#120dd6",
                    pointColor: "#120dd6",
                    pointStrokeColor: "#120dd6",
                    pointHighlightFill: "#120dd6",
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
                    data: Normdata2
                }, {
                    label: "My dataset",
                    fillColor: "rgba(255,255,255,0)",
                    strokeColor: "#f6ea0a",
                    pointColor: "#f6ea0a ",
                    pointStrokeColor: "#f6ea0a",
                    pointHighlightFill: "#f6ea0a",
                    pointHighlightStroke: "rgba(220,220,220,1)",
                    data: Normdata1
                }
            ]
        }


        var lineChart = $(selector).get(0).getContext("2d")

        window.lineChart = new Chart(lineChart).Line(lineChartData, {
            scaleShowGridLines: false,
            bezierCurve: false,
            scaleFontSize: 11,
            scaleFontStyle: "normal",
            scaleFontColor: "#fff",
            responsive: true,
            pointDotRadius: 1,
            pointDotStrokeWidth: 3,
            pointLabelFontSize: 10,
            tooltipFontSize: 10,
            tooltipFontStyle: "normal",
        });

    }

    // Trends Ends



    // Date Wise Report Start

    function BindDatewiseInvest() {
        var frmDate = $("#investigationFromDate").val();
        var toDate = $("#investigationToDate").val();
        startLoading("Loading");
        $.ajax({
            type: 'post',
            url: '../DoctorDesk/GetDateWiseInvestigation',
            cache: false,
            dataType: "json",
            data: { mrNo: GetSessionMRNO(), strFrmDate: frmDate, strTodate: toDate },
            async: false,
            success: function (response) {
                $('#DateWiseTab').empty();

                if (response != "Unsucessfull") {
                    var resultDateWise = JSON.parse(response);
                    var mainDateWisediv = $('#DateWiseTab');
                    var filterAbnormal = '';
                    //localStorage.setItem('IsDatewiseData', true);

                    $.each(resultDateWise.RESULTDATE, function (i, v) {
                        mainDateWisediv.append('<div class="" id="DateWiseDiv_' + (i) + '">'
                            + '<div style=" background-color: lightgreen; font-size:14px; font-weight:bold; text-align:center; padding:6px; border:1px solid #999;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label><div></div>');
                        filterAbnormal = v.RESULTDATE;
                        tableGenteDatewiseData(resultDateWise, filterAbnormal, i);
                        filterAbnormal = ''
                    });
                }
                else {
                    ToastMsg('No Data found', 'info');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg("Error loading investigation report", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
    }

    function tableGenteDatewiseData(result, datafilter, idval) {
        var DateWiseData = jQuery.grep(result.Table, function (j, k) {
            return (j.RESULTDATE == datafilter);
        });
        DateWiseData = sortByInvestigationOrder(DateWiseData, 'INVESTDESC'); //Abhishesh || 20260805
        var selector = '#DateWiseDiv_' + idval;
        var element = $(selector);
        element.append('<div class="box"><div class="box-body table-responsive no-padding"><table class="table table-hover" id="table_Datewise' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

        var tableElementSelect = '#table_Datewise' + idval;
        var tableElement = $(tableElementSelect)
        var headerRow = $(tableElement).children('thead').children('tr:first')
        var BodyRow = $(tableElement).children('tbody').children('tr:first')

        $.each(DateWiseData, function (j, item) {
            headerRow.append(
                '<th style="text-align:center;padding:4px !important;font-size:16px;">' + $.trim(item.INVESTDESC) + '</th>'
            );
        });

        $.each(DateWiseData, function (i, item) {
            BodyRow.append(
                '<td style="text-align:center;padding:4px !important;font-size:14px;">' + '<span class="' + item.ABNORMAL + '">' + $.trim(item.RESULTDT) + '</span>' + '</td>'
            );
        });
    }




    // Date Wise Report Ends 



    // Other Report Starts 
    function BindTemplRptData() {
        var frmDate = $("#investigationFromDate").val();
        var toDate = $("#investigationToDate").val();
        startLoading('Loading');
        $.ajax({
            type: 'post',
            url: '../DoctorDesk/GetTemplateResult',
            cache: false,
            dataType: "json",
            data: { mrNo: GetSessionMRNO(), strFrmDate: frmDate, strTodate: toDate },
            async: false,
            success: function (response) {
                $('#OthRptTab').empty();
                if (response != "Unsucessfull") {
                    var resultDateWise = JSON.parse(response);
                    var mainDateWisediv = $('#OthRptTab');
                    $.each(resultDateWise.Table, function (i, v) {
                        var CollectionNo = v.SAMLECOLNO;
                        var DicomLink = v.LABTYPE == "R" && v.SAMLECOLNO != "" ? "<a style='float: right; text-decoration: underline; cursor: pointer;' onclick='RedirecttoDICOMSampleCollect(" + CollectionNo + ")'>DICOM</a>" : "";
                        mainDateWisediv.append('<div class="parent" style="background-color:#cdf5cb; font-size: 13px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.RESULTDATE + ' </label>' + DicomLink + '</div>');
                        mainDateWisediv.append('<div class="parent" id="TmpRptDtWise_' + (i) + '" onClick="selectText(this.id);" > ');
                        v.RESULTDT = v.RESULTDT.replace(/<link[^>]*href="data:text\/css[^"]*"[^>]*>/i, '');
                        $("#TmpRptDtWise_" + (i)).html(v.RESULTDT);
                        mainDateWisediv.append('</div><div style="font-size: 13px !important;"><div class="parent" id="TmpRptAmentDtWise_' + (i) + '">');
                        $("#TmpRptAmentDtWise_" + (i)).html(v.Ammendments);
                        mainDateWisediv.append('</div><div style="float:left;" class="" id="TmpRptVerifiedDtWise_' + (i) + '">');
                        $("#TmpRptVerifiedDtWise_" + (i)).html("<b>Verified By : " + v.VERIFIEDBY + "</b>");
                        mainDateWisediv.append('</div><div style="margin-left : 50px ;float:left;" class="" id="TmpRprtByDtWise_' + (i) + '">');
                        $("#TmpRprtByDtWise_" + (i)).html("<b>Reported By : " + v.CREATEDBY + "</b>");
                        mainDateWisediv.append('</div></div></br><hr>');
                    });
                }

                else {
                    ToastMsg('No Data found', 'info');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg("Error loading investigation report", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
    }

    // Other Report Ends 

    function BindAbNormalData() {
        var frmDate = $("#investigationFromDate").val();
        var toDate = $("#investigationToDate").val();
        startLoading("Loading");
        $.ajax({
            type: 'post',
            url: '../DoctorDesk/GetInvestigation',
            cache: false,
            dataType: "json",
            data: { mrNo: GetSessionMRNO(), strFrmDate: frmDate, strTodate: toDate },
            async: false,
            success: function (response) {
                $('#AbnormalTab').empty();

                if (response != "Unsucessfull") {
                    var resultAbnormal = JSON.parse(response);
                    var mainAbNdiv = $('#AbnormalTab');
                    var filterAbnormal = '';
                    resultAbnormal.INVESTDESC = sortByInvestigationOrder(resultAbnormal.INVESTDESC, 'INVESTDESC'); //Abhishesh || 20260805
                    $.each(resultAbnormal.INVESTDESC, function (i, v) {
                        mainAbNdiv.append('<div class="" id="abnormal_' + (i) + '">'
                            + '<div style="background-color: lightgreen;border:1px solid #999;font-weight:bold;padding:6px; font-size: 16px; text-align: center; padding: 0px 10px; margin-top: 0;"><label class="any_name description-header" > ' + v.INVESTDESC + ' </label><div></div>');  /* Font- Size Added By Abhishesh || 20260420*/
                        filterAbnormal = v.INVESTDESC;
                        tableGenteAbnormalData(resultAbnormal, filterAbnormal, i);
                        filterAbnormal = ''
                    });
                }
                else {
                    ToastMsg('No Data found', 'info');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg("Error loading investigation report", "error");
            },
            complete: function () {
                stopLoading();
            }
        });
    }

    function tableGenteAbnormalData(result, datafilter, idval) {
        var AbnormFinalData = jQuery.grep(result.Table, function (j, k) {
            return (j.INVESTDESC == datafilter && j.ABNORMAL == 'Y');
        });
        var selector = '#abnormal_' + idval;
        var element = $(selector);

        if (AbnormFinalData.length > 0) {
            element.append('<div class="box"><div class="box-body table-responsive no-padding"><table class="table table-hover" id="table_Abn' + (idval) + '">' + '<thead><tr></tr></thead><tbody><tr></tr></tbody></table></div></div>')

            var tableElementSelect = '#table_Abn' + idval;
            var tableElement = $(tableElementSelect)
            var headerRow = $(tableElement).children('thead').children('tr:first')
            var BodyRow = $(tableElement).children('tbody').children('tr:first')

            $.each(AbnormFinalData, function (j, item) {
                headerRow.append(
                    '<th style="text-align:center;padding:4px !important;font-size: 14px;">' + $.trim(item.RESULTDATE) + '</th>'  /* Font-Size Added By Abhishesh || 20260420*/
                );
            });

            $.each(AbnormFinalData, function (i, item) {
                BodyRow.append(
                    '<td style="text-align:center;padding:4px !important;font-size: 14px;">' + '<span class="' + item.ABNORMAL + '">' + $.trim(item.RESULTDT) + '</span>' + '</td>' /* Font-Size Added By Abhishesh || 20260420*/
                );
            });
        }
        else {
            element.css('display', 'none')
        }
    }


    function loadInvestigationReport(Mrno) {
        BindInvestigationReportPatDetails(); //Abhishesh || 20260806 
        startLoading("Loading");

        $.ajax({
            type: 'POST',
            url: '../DoctorDesk/GetInvestigationResult',
            dataType: 'json',
            data: { mrNo: Mrno },
            cache: false,

            success: function (response) {

                const $table = $("#tblInvestigationChart");
                $table.empty();

                if (response === "Unsucessfull")
                    return;

                if (response === "No Data Found" || response === "") {
                    $('#fixedTable').hide();
                    ToastMsg('No Data found', 'info');
                    return;
                }

                const result = JSON.parse(response);
                //Abhishesh || 20260805
                InvestigationOrderList = [];
                TestNameOrderList = [];
                result.Investigate.forEach(function (item) {
                    var name = $.trim(item.INVESTDESC);
                    if (name && InvestigationOrderList.indexOf(name) === -1) {
                        InvestigationOrderList.push(name);
                    }
                    var testName = $.trim(item.TESTNAME);
                    if (testName && TestNameOrderList.indexOf(testName) === -1) {
                        TestNameOrderList.push(testName);
                    }
                });
                //End
                localStorage.setItem('IsInvestigationData', true);

                $('#fixedTable').show();

                $table.html(`
                <thead></thead>
                <tbody></tbody>
            `);

                let dateHeaders = "";

                result.TblDate.forEach(dateObj => {

                    var dateTime = dateObj.DATETIME.replace(" ", "<br>");

                    dateHeaders += `
        <th class="dateColumn">
            ${dateTime}
        </th>`;
                });
                const theadHtml = `
                <tr class="sticky-row" style="font-size:16px;">
                    <th class="first">Test Name</th>
                    <th class="second">Investigation</th>
                    <th class="third">Normal Range</th>
                    ${dateHeaders}
                </tr>
                `;

                $table.find('thead').append(theadHtml);

                const tbodyHtml = result.Investigate.map(item => {

                    let dateResult = result.TblDate.map(dateObj => {
                        const val = item[dateObj.DATETIME] != null
                            ? item[dateObj.DATETIME]
                            : "";

                        return `<td class="dateColumn">${val}</td>`;
                    }).join('');

                    return `
                    <tr class="GridViewScrollItem">
                        <td class="first">${item.TESTNAME.trim()}</td>
                        <td class="second">${item.INVESTDESC.trim()}</td>
                        <td class="third">${item.NORMRANGE.trim()}</td>
                        ${dateResult}
                    </tr>
                    `;
                }).join('');

                $table.find('tbody').append(tbodyHtml);
            },

            error: function (xhr, textStatus, errorThrown) {
                ToastMsg("Error loading investigation report", "error");
            },

            complete: function () {
                groupTable($('#tblInvestigationChart tr:has(td)'), 0, 1);
                $('#tblInvestigationChart .deleted').remove();
                stopLoading();
            }
        });
    }

    function groupTable($rows, startIndex, total) {
        if (total === 0) {
            return;
        }
        var i, currentIndex = startIndex, count = 1, lst = [];
        var tds = $rows.find('td:eq(' + currentIndex + ')');
        var ctrl = $(tds[0]);
        lst.push($rows[0]);
        for (i = 1; i <= tds.length; i++) {
            if (ctrl.text() == $(tds[i]).text()) {
                count++;
                $(tds[i]).addClass('deleted');
                lst.push($rows[i]);
            }
            else {
                if (count > 1) {
                    ctrl.attr('rowspan', count);
                    groupTable($(lst), startIndex + 1, total - 1)
                }
                count = 1;
                lst = [];
                ctrl = $(tds[i]);
                lst.push($rows[i]);
            }
        }
    }

</script>


<%-- HTML --%>
<div class="container-fluid RightMenuSlideContainer min-vh-100">

    <%-- Header Section  --%>
    <div class="row DivRightMenuHeader">

        <div class="DivRightMenuHeaderLbl col-10">
            <h2 class="LblRightMenuHeader">Investigation Report</h2>
            <div id="investigationReportPatInfoBar"
                style="display: flex; flex-wrap: wrap; align-items: center; gap: 6px; padding: 6px 15px;font-size: 15px;">
                <span> - </span>
                <span id="InvRpt_PatName" style="font-weight: bold;"></span>
                <span>| MR No: <b id="InvRpt_MRNO"></b></span>
                <span>| Gender: <b id="InvRpt_Gender"></b></span>
                <span>| Age: <b id="InvRpt_Age"></b></span>
                <span id="InvRpt_IPNoWrap" style="display: none;">| IP No: <b id="InvRpt_IPNo"></b></span>
            </div>
        </div>

        <div class="DivRightMenuBack col-2">
            <i class="fa fa-chevron-right RightMenuBackIcon" onclick="closeRightMenu();" title="Close" aria-hidden="true"></i>
        </div>

    </div>
    <%-- Body Content --%>
    <div>
         <%-- Tabs Section --%>
         <div id="investigationReportTabsSection" class="container-fluid px-0 py-2 overflow-x-auto">

              <ul class="nav nav-pills flex-nowrap bg-light border rounded-3 p-2 text-nowrap" id="investigationTabs" role="tablist">

                <li class="nav-item me-2" role="presentation">
                  <button class="nav-link active fw-semibold" 
                          id="Investigation-tab" 
                          data-bs-toggle="tab" 
                          data-bs-target="#InvestigationTab" 
                          type="button" 
                          role="tab" 
                          aria-controls="InvestigationTab" 
                          aria-selected="true">
                    Investigation Wise
                  </button>
                </li>

                <li class="nav-item me-2" role="presentation">
                  <button class="nav-link fw-semibold" 
                          id="DateWise-tab" 
                          data-bs-toggle="tab" 
                          data-bs-target="#DateWiseTab" 
                          type="button" 
                          role="tab" 
                          aria-controls="DateWiseTab" 
                          aria-selected="false">
                    Date Wise
                  </button>
                </li>

                <li class="nav-item me-2" role="presentation">
                  <button class="nav-link fw-semibold" 
                          id="Abnormal-tab" 
                          data-bs-toggle="tab" 
                          data-bs-target="#AbnormalTab" 
                          type="button" 
                          role="tab" 
                          aria-controls="AbnormalTab" 
                          aria-selected="false">
                    Abnormal Values
                  </button>
                </li>

                <li class="nav-item me-2" role="presentation">
                  <button class="nav-link fw-semibold" 
                          id="Trends-tab" 
                          data-bs-toggle="tab" 
                          data-bs-target="#TrendsTab" 
                          type="button" 
                          role="tab" 
                          aria-controls="TrendsTab" 
                          aria-selected="false">
                    Trends
                  </button>
                </li>

                <li class="nav-item me-2" role="presentation">
                  <button class="nav-link fw-semibold" 
                          id="OthRpt-tab" 
                          data-bs-toggle="tab" 
                          data-bs-target="#OthRptTab" 
                          type="button" 
                          role="tab" 
                          aria-controls="OthRptTab" 
                          aria-selected="false">
                    Other Reports
                  </button>
                </li>

                <li class="nav-item me-2" role="presentation">
                  <button class="nav-link fw-semibold" 
                          id="Culture-tab" 
                          data-bs-toggle="tab" 
                          data-bs-target="#CultureTab" 
                          type="button" 
                          role="tab" 
                          aria-controls="CultureTab" 
                          aria-selected="false">
                    Culture Report
                  </button>
                </li>

                <li class="nav-item me-2" role="presentation">
                  <button class="nav-link fw-semibold" 
                          id="OutsideRpt-tab" 
                          data-bs-toggle="tab" 
                          data-bs-target="#OutsideRptTab" 
                          type="button" 
                          role="tab" 
                          aria-controls="OutsideRptTab" 
                          aria-selected="false">
                    Outside Reports
                    <%--<i id="outRptPresent" class="fa fa-info-circle text-primary ms-1" style="font-size:15px;"></i>--%>
                  </button>
                </li>
                  <li class="nav-item me-2" role="presentation">
  <button class="nav-link fw-semibold" 
          id="OrderWise-tab" 
          data-bs-toggle="tab" 
          data-bs-target="#OrderWiseTab" 
          type="button" 
          role="tab" 
          aria-controls="OrderWiseTab" 
          aria-selected="false">
    Order Wise Report
  </button>
</li>

              </ul>
         <div id="investigationReportDatePickerSection" class="FilterDiv1">
                    <div class="row align-items-center g-1" style="gap: 20px;">

                        <div class="col-auto">
                            <label class="form-label fw-bold mb-0">
                                From 
                            </label>
                        </div>
                        <div class="col-auto">
                            <input type="text"
                                id="investigationFromDate"
                                class="form-control form-control-sm"
                                style="width: 150px;"
                                placeholder="From date" readonly>
                        </div>

                    </div>
                    <div class="row align-items-center g-1" style="gap: 20px;">
                        <div class="col-auto">
                            <label class="form-label fw-bold mb-0">
                                To
                            </label>
                        </div>
                        <div class="col-auto ms-3">
                            <input type="text"
                                id="investigationToDate"
                                class="form-control form-control-sm"
                                style="width: 150px;"
                                placeholder="To date" readonly>
                        </div>

                </div>
            </div>
       </div>

   <%-- Tab Content Section --%>
   <div class="tab-content mt-0" id="investigationReportContentSection">

    <div class="tab-pane fade show active" id="InvestigationTab" role="tabpanel" aria-labelledby="Investigation-tab">             
      
        <div class="sticky-table sticky-headers sticky-ltr-cells" id="fixedTable">
             <table id="tblInvestigationChart"
       style="line-height: 1.3; font-size:14px; width: 100%;" class="table table-striped">  <%--Abhishesh || 20260420--%>
                 <thead class="fixedHeader"></thead>    
                 <tbody></tbody>
             </table>
         </div>

    </div>

    <div class="tab-pane fade" id="DateWiseTab" role="tabpanel" aria-labelledby="DateWise-tab" ">
       
    </div>

    <div class="tab-pane fade" id="AbnormalTab" role="tabpanel" aria-labelledby="Abnormal-tab" ">
      Abnormal Values content goes here.
    </div>

    <div class="tab-pane fade" id="TrendsTab" role="tabpanel" aria-labelledby="Trends-tab" ">

                <!-- Test Header -->
                <div class="border border-info rounded mb-2 p-2" id="TestListDivHead">
                    <div class="d-flex align-items-center gap-2 flex-wrap">
                        <span class="fs-5 fw-normal text-dark">Tests</span>
                        <strong>
                            <span id="lblTestName" class="fs-6 text-dark"></span>
                        </strong>
                    </div>
                </div>

                <!-- Test Buttons -->
                <div class="border border-primary rounded p-2 mb-3">
                    <div id="TestListDiv" class="row g-2">
                        <!-- Buttons appended dynamically -->
                    </div>
                </div>

                <!-- Chart Note -->
                <div id="chartNote" class="mb-2 d-none">
                    <div class="d-flex align-items-center gap-2">
                        <span>Note -</span>
                        <span class="square"></span>
                        <span>Result</span>
                    </div>
                </div>

                <!-- Charts -->
                <div class="divSubList">
                    <div id="divCharts" class="row g-2">
                        <!-- Charts injected here -->
                    </div>
                </div>

          </div>


          <div class="tab-pane fade" id="OthRptTab" role="tabpanel" aria-labelledby="OthRpt-tab" ">
              
          </div>

          <div class="tab-pane fade" id="CultureTab" role="tabpanel" aria-labelledby="Culture-tab" ">
            Culture Report content goes here.
          </div>

          <div class="tab-pane fade" id="OutsideRptTab" role="tabpanel" aria-labelledby="OutsideRpt-tab" ">
                <div class="tableDiv sticky-table sticky-headers sticky-ltr-cells" id="outsiderptfixedTable">
                 <table id="tbl1" class="table" style="width: 100%">
                       <tbody id="tblsort1"></tbody>
                 </table>
          </div>

        </div>
       <div class="tab-pane fade" id="OrderWiseTab" role="tabpanel" 
     aria-labelledby="OrderWise-tab" style="overflow-y:auto;">
           <input type="hidden" id="hdnCurrentDoctCode" 
           value='<%: System.Web.HttpContext.Current.Session["gDoctCode"] %>' />
    <input type="hidden" id="hdnCurrentDoctName" 
           value='<%: System.Web.HttpContext.Current.Session["gDoctName"] %>' />

    <%-- Search Criteria --%>
    <div style="position:sticky;top:0;z-index:100;
            border:1px solid #ccc;border-radius:6px;padding:10px;
            margin:10px 0;background-color:#f9f9f9;
            box-shadow:0 2px 4px rgba(0,0,0,0.1);">
       
        <table style="width:100%;">
            <tr>
                <td style="width:80px;font-size:13px;font-weight:bold;">
                    <label>From</label>
                </td>
                <td style="width:140px;">
                    <input type="text" id="OrderWiseFrmDate" readonly
                           style="width:110px;height:26px;" 
                           class="form-control form-control-sm" />
                </td>
                <td style="width:40px;font-size:13px;font-weight:bold;">
                    <label>To</label>
                </td>
                <td style="width:140px;">
                    <input type="text" id="OrderWiseToDate" readonly
                           style="width:110px;height:26px;" 
                           class="form-control form-control-sm" />
                </td>
                <td style="width:70px;font-size:13px;font-weight:bold;display:none">
                    <label>MR No</label>
                </td>
                <td style="width:130px;display:none">
                    <input type="text" id="txtOrderWiseMRNo" readonly
                           style="width:110px;height:26px;background-color:#f0f0f0;" 
                           class="form-control form-control-sm" />
                </td>
                <td style="width:100px;font-size:13px;font-weight:bold;">
                    <label>
                        <input type="checkbox" id="chkMyOrder" 
                               style="margin-right:4px;" />
                        My Order(s)
                    </label>
                </td>
                <td style="width:70px;font-size:13px;font-weight:bold;">
                    <label>Doctor</label>
                </td>
                <td style="width:200px;">
                    <select id="ddlOrderWiseDoctor" 
                            class="form-select form-select-sm"
                            style="width:180px;height:28px;font-size:12px;">
                        <option value="">---Select Doctor---</option>
                    </select>
                </td>
                <td style="padding-left:10px;">
                    <i class="fa fa-search" id="btnOrderWiseSearch" 
                       style="font-size:17px;cursor:pointer;"></i>
                </td>
            </tr>
        </table>
    </div>

    <%-- Result Grid --%>
    <div id="divOrderWiseResult" style="margin-top:5px;"></div>
</div>

   </div>

</div>

 </div>




