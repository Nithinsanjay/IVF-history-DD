<%@ Control Language="C#"  Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.ICDUserCntrlMdl>" %>
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
        $('#btnICDSearch').click(function (e) {
            e.preventDefault();
            //var code = "";
            var name = "";            
           // code = ("" + $("#txtICDCode").val()).trim();
            name = ("" + $("#txtICDName").val()).trim();
            if (name == "") {
                $.messager.alert("Information", 'Please select at Least One Search Criteria.');
           
                return;
            }
            $("#txtICDCode").val(""); $("#txtICDName").val("");          
            document.getElementById('divtblICDGrid').style.display = 'block';          
            var urlq = '../DoctorDesk/GetICDLISTVALUE?name=' + name;

            colnames = ['ICD Code', 'ICD Name','Index Type'];
            $("#tblICDGrid").jqGrid('GridUnload');
            jQuery("#tblICDGrid").jqGrid({
                url: urlq,
                datatype: 'json',
                mtype: 'post',
                colNames: colnames,
                colModel: [{
                    name: 'ICDCODE',
                    index: 'ICDCODE', width: 80, hidden: true,
                    editable: false
                },
                {
                    name: 'ICDNAME',
                    index: 'ICDNAME', width: 400,
                    editable: false
                },
                {
                    name: 'ICDTYPE', index: 'ICDTYPE', width: 80, editable: false, hidden: true,
                },                                       
                ],
                sortname: 'id',
                sortorder: "desc",
                caption: "Inpatient Details",
                shrinkToFit: false,
                loadtext: "Loading...",
                cellEdit: true,
                cellsubmit: 'clientArray',
                loadonce: true,
                sortable: true,
                rowNum: 9999999999,
                width: 410,
                height: 200,
                //sOMNATH
                gridComplete: function () {
                    var top_rowid = $('#tblICDGrid tr:nth-child(2)').attr('id');
                    $("#tblICDGrid").setSelection(top_rowid, true).focus();
                },//end
                beforeSelectRow: function (rowid, e) {
                    jQuery("#tblICDGrid").jqGrid('resetSelection');
                    return (true);
                },
                ondblClickRow: function (rowId) {
                   // var mrno = jQuery("#tblICDGrid").jqGrid('getGridParam', 'selrow');
                    var rowData = jQuery("#tblICDGrid").getRowData(rowId);
                    document.getElementById('divtblICDGrid').style.display = 'none';              
                    FillICDInfoUserCntrl(rowData);                
                },
                loadComplete: function (rowid, e) {                  
                    var countgd = jQuery("#tblICDGrid").jqGrid('getGridParam', 'reccount');
                    if (countgd == 0) {
                        $.messager.alert("Information", "No data for display.");
                      
                        document.getElementById('divtblICDGrid').style.display = 'none';
                        ClrIpUsrCntrl();
                        $("#txtICDCode").val("");
                        $("#txtICDName").val("");
                        //$("#txtICDCD").val("");
                        //$("#txtICDNM").val("");
                        $("#txtICDCode").focus();
                    }                                  
                }
            }).trigger("reloadGrid");         
            $("#tblICDGrid").jqGrid('bindKeys');
            $("#tblICDGrid").bind('keydown', function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    var rowId = $("#tblICDGrid").jqGrid("getGridParam", "selrow")
                    var rowData = jQuery("#tblICDGrid").getRowData(rowId);
                    document.getElementById('divtblICDGrid').style.display = 'none';
                    FillICDInfoUserCntrl(rowData);
                }
            });          
        });
        $('#btnSClose').click(function () {
            $("#tblICDGrid").jqGrid('GridUnload');
            document.getElementById('divtblICDGrid').style.display = 'none';
        });       
    });   
    function BtnSearchEnt() {
        if (event.keyCode == 13) { $('#btnICDSearch').trigger('click'); }
    }   
</script>
<% using (Html.BeginForm())
   { %>
 
<div class="col-md-12" id="ICDSearchCntrl" class="SrchDiv">
    <div class="row">
 <%: Html.TextBoxFor(m => m.Text, new { id = "txtICDName", @class = "TextBxFormat", Style = "margin-left: 18px; background-color: #c2e1f3; ", PlaceHolder = "Search for ICD",onKeydown="BtnSearchEnt()"})%>
           
                 <a id="btnICDSearch" href="#">
                                <span class="fa fa-search fa-lg" style="font-weight: bold; color: black;"></span>
                            </a>
         </div> 
    <div id="divtblICDGrid" class="white_content" style="position:relative;" >
    <div class="panel-heading">ICD Details<input id="btnSClose" type="button" style="left: 390px;" class="btn_sclose" /></div>
<table id="tblICDGrid" >
</table>
</div> 
    </div>
     
<% } %>