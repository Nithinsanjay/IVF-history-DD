<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.GenericUsrCntrlMdl>" %>
<style type="text/css">
    .btn_sclose {
        background-image: url(../Images/close_button.gif);
        background-size: cover;
        position: absolute;
        width: 18px;
        height: 18px;
    }

    .white_content {
        display: none;
        position: fixed;
        width: 847px;
        z-index: 1002;
        overflow: auto;
    }
</style>
<script type="text/javascript">
       <%: System.Web.Optimization.Scripts.Render("~/Scripts/jqGrid") %>
    $(document).ready(function () {
        $('#btnGenericSearch').click(function (e) {
            e.preventDefault();
            //var code = "";
            var name = "";
            // code = ("" + $("#txtGenericCode").val()).trim();
            name = ("" + $("#txtGenericName").val()).trim();
            if (name == "") {
                $.messager.alert("Information", 'Please select at Least One Search Criteria.');

                return;
            }
            $("#txtGenericCode").val(""); $("#txtGenericName").val("");
            document.getElementById('divtblGenericGrid').style.display = 'block';
            var urlq = '../DoctorDesk/GetGENERICLIST?name=' + name;

            colnames = ['GENERIC Code', 'DRUG NAME','GENERIC Name', 'DRUG CODE'];
            $("#tblGenericGrid").jqGrid('GridUnload');
            jQuery("#tblGenericGrid").jqGrid({
                url: urlq,
                datatype: 'json',
                mtype: 'post',
                colNames: colnames,
                colModel: [{
                    name: 'GENERICCODE',
                    index: 'GENERICCODE', width: 80, hidden: true,
                    editable: false
                },
                   {
                       name: 'DRUGNAME',
                       index: 'DRUGNAME', width: 300,
                       editable: false
                   },
                {
                    name: 'GENERICNAME',
                    index: 'GENERICNAME', width: 300, hidden: true,
                    editable: false
                },
                {
                    name: 'DRUGCODE',
                    index: 'DRUGCODE', width: 80, hidden: true,
                    editable: false
                },
             
              
                ],
                sortname: 'id',
                sortorder: "desc",
                caption: "DRUG Details",
                shrinkToFit: false,
                loadtext: "Loading...",
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadonce: true,
                sortable: true,
                rowNum: 9999999999,
              //  width: 410,
                height: 200,
                //sOMNATH
                gridComplete: function () {
                    var top_rowid = $('#tblGenericGrid tr:nth-child(2)').attr('id');
                    $("#tblGenericGrid").setSelection(top_rowid, true).focus();
                },//end
                beforeSelectRow: function (rowid, e) {
                    jQuery("#tblGenericGrid").jqGrid('resetSelection');
                    return (true);
                },
                ondblClickRow: function (rowId) {
                    // var mrno = jQuery("#tblICDGrid").jqGrid('getGridParam', 'selrow');
                    var rowData = jQuery("#tblGenericGrid").getRowData(rowId);
                    document.getElementById('divtblGenericGrid').style.display = 'none';
                    FillGenericInfoUserCntrl(rowData);
                },
                loadComplete: function (rowid, e) {
                    var countgd = jQuery("#tblGenericGrid").jqGrid('getGridParam', 'reccount');
                    if (countgd == 0) {
                        $.messager.alert("Information", "No data for display.");

                        document.getElementById('divtblGenericGrid').style.display = 'none';
                        ClrIpUsrCntrl();
                        $("#txtGenericCode").val("");
                        $("#txtGenericName").val("");
                        //$("#txtICDCD").val("");
                        //$("#txtICDNM").val("");
                        $("#txtGenericCode").focus();
                    }
                }
            }).trigger("reloadGrid");
            $("#tblGenericGrid").jqGrid('bindKeys');
            $("#tblGenericGrid").bind('keydown', function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    var rowId = $("#tblGenericGrid").jqGrid("getGridParam", "selrow")
                    var rowData = jQuery("#tblGenericGrid").getRowData(rowId);
                    document.getElementById('divtblGenericGrid').style.display = 'none';
                    FillGenericInfoUserCntrl(rowData);
                }
            });
        });
        $('#btnGClose').click(function () {
            $("#tblGenericGrid").jqGrid('GridUnload');
            document.getElementById('divtblGenericGrid').style.display = 'none';
        });
        //restrict on enter key press
        $('#txtGenericName').keydown(function (e) {
            if (event.keyCode == 13) {
                return false;
            }
        });
    });
    function BtnSearchEnt2() {
        if (event.keyCode == 13) { $('#btnGenericSearch').trigger('click'); }
    }
</script>
<% using (Html.BeginForm())
   { %>

<div class="col-md-12" id="GenericSearchCntrl" class="SrchDiv">
    <div class="row">
        <%: Html.TextBoxFor(m => m.Text, new { id = "txtGenericName", @class = "TextBxFormat", Style = "margin-left: 18px; background-color: #c2e1f3;width:300px", PlaceHolder = "Search for Drug Name",onKeydown="BtnSearchEnt2()"})%> <%--,Generic Name--%>

        <a id="btnGenericSearch" href="#">
            <span class="fa fa-search fa-lg" style="font-weight: bold; color: black;"></span>
        </a>
    </div>
    <div id="divtblGenericGrid" class="white_content" style="position: relative;">
        <div class="panel-heading">Drug Details<input id="btnGClose" type="button" style="left: 303px;" class="btn_sclose" /></div>
        <table id="tblGenericGrid">
        </table>
    </div>
</div>

<% } %>