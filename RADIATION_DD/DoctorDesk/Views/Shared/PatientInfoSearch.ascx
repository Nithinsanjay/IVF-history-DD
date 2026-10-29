<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.UserControlModel>" %>
 <style type ="text/css" >
     .SrchTextBox{
         inline-size: -webkit-fill-available !important;
    border-radius: 50px;
    border: none !important;
    margin-right: 5px;
    padding-left: 10px;
    box-shadow: 1px 1px #3b5998;font-size: 12px;
     }
 </style>
<script type="text/javascript">
    var forignPatCheck = false;
    var companyPatYN = false;
    var onlyComp = false;
    var OPFormName = '';//------------sOMNATH------------
    var FormName = '';
    var SelFrmApmntLstNoMR = "N";
    var inc = 0;
    $(document).ready(function () {
        $("#txtContact").focus();
        $("#txtDoB").datepicker({
            changeMonth: true,
            yearRange: "c-150:c+99",
            changeYear: true,
            dateFormat: "dd/mm/yy",
            maxDate: new Date()
        });
        $('#divgrid').width($('#ContentDiv').width());
        $('#btnSearch').click(function () {
            HoldOn.open();
            inc = 0;
            var smrno = "";
            var sfname = "";
            var smname = "";
            var slname = "";
            var scontact = "";
            var sdob = "";
            var sOnlyComp = "";
            smrno = ("" + document.getElementById("txtSrchMrNo").value);
            smrno = smrno.toUpperCase();
            sfname = ("" + document.getElementById("txtFirstNm").value);
            smname = ("" + document.getElementById("txtMidNm").value);
            slname = ("" + document.getElementById("txtLstNm").value);
            scontact = ("" + document.getElementById("txtContact").value);
            sdob = ("" + document.getElementById("txtDoB").value); sEmpNo = ("" + document.getElementById("txtSrchEmpID").value);
            if (onlyComp)
                sOnlyComp = "Y";

            var urlq = '../DoctorDesk/GETOPSEARCHDATA?SMRNO=' + smrno + '&&SFNAME=' + sfname + '&&SMNAME=' + smname + '&&SLNAME=' + slname + '&&SCONTACT=' + scontact + '&&SDOB=' + sdob + '&&SOnlyComp=' + sOnlyComp + '&&strEMPID=' + sEmpNo;;

            colnames = ['MR No', 'Patient Name', 'DOB', 'Age', 'Gender', 'Address1', 'Address2', 'Address3', 'Patient Catg', 'Tariff', 'Contact', 'Company',
                    'Paytype', 'Salutation', 'CARDLIMIT', 'AVLLMT', 'COCANAME', 'APLIDAMT', 'PREFDOCT', 'PRIORITY', 'ADMNSTATUS', 'DEPSTAMT', 'REFNDAMT', 'IPTRANSFR', 'EXEMPTION', 'PRIODESC', 'TPALMT', 'CITYID', 'DISTRICID', 'PATFNAME', 'PATMNAME', 'PATLNAME', 'EMAIL', 'EMPID', 'LETTERNO', 'BALANCE']
            $("#grid").jqGrid('GridUnload');
            
            if (smrno.trim() != "" || sfname.trim() != "" || smname.trim() != "" || slname.trim() != "" || scontact.trim() != "" || sdob.trim() != "" || sEmpNo.trim() != "") {
                jQuery("#grid").jqGrid({
                    url: urlq,
                    datatype: 'json',
                    async: false,
                    mtype: 'post',
                    colNames: colnames,
                    colModel: [
                    { name: 'MRNO', index: 'MRNO', width: 80, editable: false },
                    { name: 'PATNAME', index: 'PATNAME', width: 200, editable: false },
                    { name: 'PATDOB', index: 'DOB', width: 80, align: "left", editable: false },
                    { name: 'PATAGE', index: 'AGE', width: 80, align: "left", editable: false },
                    { name: 'GENDER', index: 'GENDER', width: 80, align: "left", editable: false },
                    { name: 'PATADDR1', index: 'PATADDR1', hidden: true },
                    { name: 'PATADDR2', index: 'PATADDR2', hidden: true },
                    { name: 'PATADDR3', index: 'PATADDR3', hidden: true },
                    { name: 'PATIENTCAT', index: 'PATIENTCAT', width: 120, align: "left" },
                    { name: 'TARIFF', index: 'TARIFF', width: 120, align: "left" },
                    { name: 'CONTACT', index: 'CONTACT', width: 80, align: "left" },
                    { name: 'COMPANY', index: 'COMPANY', width: 170, align: "left" },
                    { name: 'PAYTYPE', index: 'PAYTYPE', width: 80, align: "left" },
                  //  { name: 'PRIORITY', index: 'PRIORITY', width: 100, align: "left" },
                    { name: 'SALUTATION', index: 'SALUTATION', width: 70, align: "left" },
                    { name: 'CARDLIMIT', index: 'CARDLIMIT', hidden: true },
                    { name: 'AVLLMT', index: 'AVLLMT', hidden: true },
                    { name: 'COCANAME', index: 'COCANAME', hidden: true },
                    { name: 'APLIDAMT', index: 'APLIDAMT', hidden: true },
                    { name: 'PREFDOCT', index: 'PREFDOCT', hidden: true },
                    { name: 'PRIORITY', index: 'PRIORITY', hidden: true },
                    { name: 'ADMNSTATUS', index: 'ADMNSTATUS', hidden: true },
                    { name: 'DEPSTAMT', index: 'DEPSTAMT', hidden: true },
                    { name: 'REFNDAMT', index: 'REFNDAMT', hidden: true },
                  //  { name: 'APLIDAMT', index: 'APLIDAMT', hidden: true },
                    { name: 'IPTRANSFR', index: 'IPTRANSFR', hidden: true },
                    { name: 'EXEMPTION', index: 'EXEMPTION', hidden: true },
                    { name: 'PRIODESC', index: 'PRIODESC', hidden: true },
                    { name: 'TPALMT', index: 'TPALMT', hidden: true },
                    { name: 'CITYID', index: 'CITYID', hidden: true },
                    //{ name: 'ZIP', index: 'ZIP', hidden: true },
                    //{ name: 'DEPTCODE', index: 'DEPTCODE', hidden: true },
                    { name: 'DISTRICTID', index: 'DISTRICTID', hidden: true },
                    { name: 'PATFNAME', index: 'PATFNAME', hidden: true },
                    { name: 'PATMNAME', index: 'PATMNAME', hidden: true },
                    { name: 'PATLNAME', index: 'PATLNAME', hidden: true },
                    { name: 'PATEMAIL', index: 'PATEMAIL', hidden: true },
                    { name: 'EMPID', index: 'EMPID', hidden: false },
                     { name: 'LETTERNO', index: 'LETTERNO', hidden: true },
                     { name: 'BALANCE', index: 'BALANCE', hidden: true }
                    ],
                    sortname: 'id',
                    viewrecords: true,
                    sortorder: "desc",
                    // caption: "Patient Details",
                    // forceFit: true,
                    shrinkToFit: false, //It is Used For Scroll display in overflow time on the grid
                    //  cellEdit: true,  // i have commented for using enterkey press
                    cellsubmit: 'clientArray',
                    loadonce: true, // to enable sorting on client side
                    sortable: true,
                    rownumbers: true,
                    rowNum: 500,
                    ignoreCase: true,
                    width: 'auto',
                    height: '200',
                    ondblClickRow: true,
                    gridComplete: function () {
                        //var firstid = $("tr:first", "#grid").attr("id");
                        //$("#grid").setSelection(firstid).focus();
                        var top_rowid = $('#grid tr:nth-child(2)').attr('id');
                        $("#grid").setSelection(top_rowid, true).focus();
                    },
                    loadComplete: function () {
                        //jQuery("#grid").jqGrid('editCell', 1, 1, true);
                        var countgd = jQuery("#grid").jqGrid('getGridParam', 'reccount');
                        if (countgd == 0) {
                            alert("No data for display.", "Information");
                            document.getElementById('divgrid').style.display = 'none';
                            PatSerControlClear();
                            $("#txtContact").focus();
                            PatInfoClearControl();
                            HoldOn.close();
                        }
                        else if (countgd == 1) {
                            var ids = $("#grid").jqGrid('getDataIDs');
                            SearchFinish(ids[0]);
                            inc++;
                        }
                        else {
                            document.getElementById('divgrid').style.display = 'block';
                            $("#grid").focus;
                            HoldOn.close();
                        }
                    },
                    ondblClickRow: function (rowId, iRow, iCol, e) {
                        inc++;
                        SearchFinish(rowId);
                    }
                }).trigger("reloadGrid");
                $("#grid").jqGrid('filterToolbar', {
                    searchOnEnter: false,
                    searchOperators: false,
                    defaultSearch: "cn",
                    beforeSearch: function () { searchGDYN = "Y"; }
                });
                fixSearchOperators();
                var newWidth = $(".content").width();
                $("#grid").jqGrid("setGridWidth", newWidth - 10, false);
                //$("#grid").jqGrid("setGridHeight", $(".content").height() - 370, true);
            }
            else {
                document.getElementById('divgrid').style.display = 'none';
                HoldOn.close();
                alert("Please enter at least one search criteria.", "Validation");
            }
            jQuery("#grid").jqGrid('bindKeys');
            $("#grid").bind('keydown', function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    var rowId = $("#grid").jqGrid("getGridParam", "selrow")
                    SearchFinish(rowId);
                }
            });
        });
        $('#btnSClose').click(function () {
            $("#grid").jqGrid('GridUnload');
            document.getElementById('divgrid').style.display = 'none';
        });
        function fixSearchOperators() {
            var $grid = $("#grid"),
            columns = $grid.jqGrid('getGridParam', 'colModel'),
                filterToolbar = $($grid[0].grid.headers).find("tr.ui-search-toolbar");
            filterToolbar.find("th").each(function (index) {
                var $searchOper = $(this).find(".ui-search-oper");
                if (!(columns[index].searchoptions && columns[index].searchoptions.searchOperators)) {
                    $searchOper.hide();
                }
            });
        }
    });
   
    function custom_alertCon(output_msg, title_msg, SelRowData) {
        if (!title_msg)
            title_msg = 'Alert';
        if (!output_msg)
            output_msg = 'No Message to Display.';
        $("#lblCustomAlert").text(output_msg);
        $("#Customalert").dialog({
            title: title_msg,
            resizable: false,
            modal: true,
            buttons: {
                "Yes": function (response) {
                    if ($("#txtUCMrNo").val() == "") {

                        var doc = document.getElementById('PatInfoCtrl');

                        if (doc != null) {
                            fillUCdata(SelRowData);
                        }
                        filldata(SelRowData);
                        $(this).dialog("close");
                    }
                    else {
                        $(this).dialog("close");
                    }
                },
                "No": function (response) {
                    jQuery.fancybox.close();
                    $(this).dialog("close");
                }
            }
        });
    }

    function SearchFinish(rowId) {
        var rowData = jQuery("#grid").getRowData(rowId); // this show selected  row objecte
        PatSerControlClear();
        if (FormName == "Consultaion" && SelFrmApmntLstNoMR == "Y") {
            if (($('#txtUCContactNo').val().replace(/\s\s+/g, ' ') != rowData['CONTACT'].replace(/\s\s+/g, ' ') || $('#txtUCPatname').val().toUpperCase() != rowData['PATNAME'].toUpperCase().replace(/\s\s+/g, ' '))) {
                custom_alertCon("Mismatch Patient Information. Do you want to continue ?", "Information", rowData);
                return false
            }
        }
        else {
            var doc = document.getElementById('PatInfoCtrl');
            document.getElementById('divgrid').style.display = 'none';
            //if (("" + rowData.ADMNSTATUS).trim() == 'A') {
            //    custom_alertSea("", "", rowData);
            //}
            //else {
                if (doc != null) {
                    fillUCdata(rowData);
                }
                filldata(rowData);
                PatSerControlClear();
            
        }
        HoldOn.close();
    }
    function PatSerControlClear() {
        $("#txtSrchMrNo").val("");
        $("#txtFirstNm").val("");
        $("#txtMidNm").val("");
        $("#txtLstNm").val("");
        $("#txtContact").val("");
        $("#txtDoB").val("");
        $("#txtSrchEmpID").val();
    }
    //---------Modified By sOMNATH----------
    function custom_alertSea(output_msg, title_msg, rowData) {
        if (OPFormName == "AdmissionForm") {
            alert("Selected patient is already addmitted.", "Information");
            return;
        }
        else if (OPFormName == "IPRoomReservation") {
            alert("Sorry You Cannot reserve Bed For Addmited Patient.", "Information");
            return;
        }
        else {
            output_msg = "This patient is already addmitted, do you wants to continue?";
            title_msg = "Confirmation";
        }
        if (!title_msg)
            title_msg = 'Alert';
        if (!output_msg)
            output_msg = 'No records to Display.';
        $("#lblCustomAlert").text(output_msg);
        //$('<div style="font-size:14px;padding:10px"></div>').html(output_msg).dialog({
        if (OPFormName == "AdmissionForm") {
            $("#Customalert").dialog({
                title: title_msg,
                resizable: false,
                autoClose: false,
                modal: true,
                buttons: {
                    "Ok": function () {
                        $(this).dialog("close");
                        //filldata('');
                    }

                }
            });
        }
        else {
            $("#Customalert").dialog({
                title: title_msg,
                resizable: false,
                autoClose: false,
                modal: true,
                buttons: {
                    "Yes": function () {
                        var doc = document.getElementById('PatInfoCtrl');
                        if (doc != null) {
                            fillUCdata(rowData);
                        }
                        filldata(rowData);
                        $(this).dialog("close");
                    },
                    "No": function () {
                        $(this).dialog("close");
                        //filldata(''); by diptesh
                    }
                }
            });
        }
    }
</script>
<% using (Html.BeginForm())
   { %> 
<div class="SrchDiv" style="padding: 5px;    border: 2px solid #c7c7c7;   margin-bottom: 3px;" >
<table cellpadding="1" cellspacing="1" style="width:100%;">
<tr style="vertical-align: -webkit-baseline-middle; vertical-align: top;">
    
                                          
<td><%: Html.TextBoxFor(m => m.strContactNo , new { id = "txtContact", @class = "form-control input-form-control", Style = "border: 1px solid #ff2f06; border-radius: 19px;", PlaceHolder = "Contact No",onKeydown="BtnSearchEnt()" })%></td>
<td><%: Html.TextBoxFor(m => m.strMrNo, new { id = "txtSrchMrNo", @class = "form-control input-form-control", Style = "border: 1px solid #ff2f06; border-radius: 19px;", PlaceHolder = "MR No",onKeydown="BtnSearchEnt()" })%></td>
<td><%: Html.TextBoxFor(m => m.strEmpNo, new { id = "txtSrchEmpID", @class = "form-control input-form-control", Style = "border: 1px solid #ff2f06;border-radius: 19px;", PlaceHolder = "Emp Code",onKeydown="BtnSearchEnt()"})%></td>
</tr>
<tr>
    <td><%: Html.TextBoxFor(m=>m.strFirstNm ,new { id = "txtFirstNm", @class = "form-control input-form-control", Style = "border: 1px solid #ff2f06; border-radius: 19px;margin-top:2px;",PlaceHolder="First Name",onKeydown="BtnSearchEnt()" }) %></td>
<td><%: Html.TextBoxFor(m => m.strMidNm, new { id = "txtMidNm", @class = "form-control input-form-control", Style = "border: 1px solid #ff2f06; border-radius: 19px;margin-top:2px;", PlaceHolder = "Middle Name",onKeydown="BtnSearchEnt()"})%></td>
<td><%: Html.TextBoxFor(m => m.strLstNm, new { id = "txtLstNm", @class = "form-control input-form-control", Style = "border: 1px solid #ff2f06;border-radius: 19px;margin-top:2px;", PlaceHolder = "Last Name" ,onKeydown="BtnSearchEnt()"})%></td
<td><%: Html.TextBoxFor(m => m.strDOB, new { id = "txtDoB",@readonly="readonly", @class = "form-control input-form-control", Style = "width: 90px;display:none;", PlaceHolder = "DOB",onKeydown="BtnSearchEnt()"})%></td>

    </tr>
    <tr >
         <td colspan="3" style="text-align:center;    "><input type="button" value="Search" id="btnSearch" class="button1 button1-green" style="margin-top: 5px;" />
</td>
    </tr>
</table>

</div>
<%--<div id="TitleSerDiv"class="panel-heading" style="display:none;"></div>--%>
<div id="divgrid" class="" style="vertical-align:middle;position:inherit;display:none;" >
    <div class="panel-heading"> Patient Details<input id="btnSClose" type="button" class="btn_sclose" style="float: right;
    height: 19px;
    width: 19px;
    color: #f54a08;
    font-weight: 900;
    /* text-align: center; */
    padding: 0px;" value="X" /></div>
<table id="grid" style="    margin-bottom: 1px;width:50%;height:500px;">
</table>
 </div><% } %> 
