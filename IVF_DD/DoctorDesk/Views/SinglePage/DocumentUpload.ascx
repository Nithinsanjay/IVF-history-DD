<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OncologyEMR.Models.DMSDocUpload>" %>

<style>
    #DivMainDMSDocUpload {
        /*background-color: #f8f9fa;
        border-radius: 8px;*/
    }

    #ddlDMSDocType {
        cursor: pointer;
    }

        #ddlDMSDocType:focus {
            box-shadow: 0 0 0 0.15rem rgba(13, 110, 253, 0.25);
        }

    #DMSDocUploadTable {
        min-height: 120px;
    }

   #DMSDocUploadTable table {
        margin-bottom: 0;
    }

    #DMSDocUploadTable table thead {
            background-color: #e9ecef;
            font-weight: 600;
    }

   #DMSDocUploadTable table tbody tr:hover {
            background-color: #f1f3f5;
   }
   .custom-popup_doc{
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 90%;
        max-width: 1200px;
        /*height: 80vh;*/
        height: auto;
        overflow : auto;
        background: #fff;
        border-radius: 6px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
        z-index: 1000;
        display: flex;
        flex-direction: column;
   }
</style>
<script>
    var DMSDocUploadListtable;
    $(document).ready(function () {
        /* Tabulator For Document Upload */
        DMSDocUploadListtable = new Tabulator("#DMSDocUploadTable", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "50",
            index: "code",
            rowHeader: {
                headerSort: false,
                frozen: true,
                hozAlign: "center",
                formatter: "rownum",
                width: 40
            },
            columns: [
                {
                    headerSort: false,
                    title: "Action",
                    field: "act",
                    width: 60,
                    formatter: function (cell) {
                        return "<i class='fa fa-eye IFrameEyeIcon' style='cursor:pointer'></i>";
                    },
                    hozAlign: "center",
                    cellClick: function (e, cell) {
                        var rowData = cell.getRow().getData();

                        var docPath = rowData.DOCPATH;
                        var docName = rowData.DOCNM;

                        openDMSDocument(docPath, docName);
                    },

                },
                {
                    title: "Document Type Name",
                    field: "DOCTYPENM",
                    headerSort: true,
                },
                {
                    title: "Document Name",
                    field: "DOCNM",
                    headerSort: true,
                    width: 586,
                },
                {
                    title: "Document Path",
                    field: "DOCPATH",
                    //width: auto,
                    tooltip: true,
                    visible: false
                },
                {
                    title: "Document Code",
                    field: "DOCTYPECD",
                 /*   width: 80,*/
                    tooltip: true,
                    visible: false
                }
            ]
        });

        DMSDocUploadListtable.on("cellEdited", function (cell) {
            var RowData = cell.getRow().getData();
            if (RowData.ALIVEYN == true) {
                cell.getRow().update({ DATEOFDEATH: "", CAUSEOFDEATH: "" });
            }

            cell.getRow().normalizeHeight();
            adjustTableHeight("DMSDocUploadTable");
        });

        DMSDocUploadListtable.on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("DMSDocUploadTable");
        });

        DMSDocUploadListtable.on("rowDeleted", function (row) {
            adjustTableHeight("DMSDocUploadTable");
        });

        DMSDocUploadListtable.on("dataLoaded", function () {
            adjustTableHeight("DMSDocUploadTable");
        });

        DMSDocUploadListtable.on("tableBuilt", function () {
            adjustTableHeight("DMSDocUploadTable");
        });

        DMSDocUploadListtable.on("dataChanged", function () {
            adjustTableHeight("DMSDocUploadTable");
        });
        GetDocumentDetails("");
    });

    function GetDocumentDetails(element) {
        //debugger;
        var strDocType = "";
        if (element != "") {
            strDocType = element.value;
        }

        var strDocArray = new Array();
        var MRNo = GetSessionMRNO();
        var billIp = "";
        if (sessionStorage.getItem("MODULE_FLAG") === "IPD") {
            billIp = sessionStorage.getItem("IPPatIPNO").toString().trim();
        }

        $.ajax({
            datatype: 'json',
            url: "../SinglePage/GetUploadDocuments?strBillIP=" + billIp + "&&strDocType=" + strDocType + "&&strMRNo=" + MRNo,
            type: 'get',
            success: function (result) {
                if (result[0] != null) {
                    if (result[0].rows.length > 0) {
                        for (var i = 0; i < result[0].rows.length; i++) {
                            BILLIPNO = result[0].rows[i].IPNO;
                            DOCPATH = result[0].rows[i].DOCPATH;
                            DOCTYPECD = result[0].rows[i].DOCTYPECD;
                            DOCNAME = result[0].rows[i].DOCNAME;
                            docName = { BILLIPNO: BILLIPNO, DOCPATH: DOCPATH, DOCTYPECD: DOCTYPECD, DOCNAME: DOCNAME, DOCTYPENM: result[0].rows[i].DOCTYPENM };
                            strDocArray.push(docName);
                        }
                    }
                    BindDocumentList(strDocArray);
                }
                else {
                    docName = { BILLIPNO: '', DOCPATH: '', DOCTYPECD: '', DOCNAME: '', DOCTYPENM: '' };
                    strDocArray.push(docName);
                    BindDocumentList([]);
                }
                docName = [];
                strDocArray = [];
            },
            error: function (xhr, textStatus, errorThrown) {
                //$.messager.alert("Error", 'Something Went Wrong.');
            }
        });
    }
    function BindDocumentList(docname) {
        //debugger;
        var doctlist = docname;
        var doctlist = docname.map(function (item) {
            return {
                DOCNM: item.DOCNAME.trim(),
                DOCPATH: item.DOCPATH,
                DOCTYPECD: item.DOCTYPECD,
                DOCTYPENM: item.DOCTYPENM,
            };
        });

        DMSDocUploadListtable.setData(doctlist);
        adjustTableHeight("DMSDocUploadTable");
    }
    function openDMSDocument(docPath, docName) {
        //debugger;
        var url = '../SinglePage/PrintDMSUploadDoc?docPath=' + docPath + '&&docName=' + docName;
        $.ajax({
            url: url,
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            type: 'POST',
            async: true,
            success: function (result) {
                if (result == "Success") {
                    var url = 'DisplayDMSUploadDocPrintAction?FileName=' + docName;
                    var win = window.open(url, '_blank');
                    win.focus();
                }
                else {
                    ToastMsg(result, "warning");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                ToastMsg(textStatus, "error");
            }
        });
    }
</script>

<div id="DivMainDMSDocUpload">

    <!-- Document Type Section -->
    <div class="mb-3 d-flex align-items-center">
        <label for="ddlDMSDocType" class="form-label fw-semibold mb-0 me-2 text-nowrap">
            Document Type
        </label>
        <select class="form-select form-select-sm ddl_DMSDocType" id="ddlDMSDocType" onchange="GetDocumentDetails(this)">
            <% if (Model != null && Model.DocTypeList != null)
                { %>
            <option value="" selected>All</option>
            <% foreach (var item in Model.DocTypeList)
                { %>
            <option value="<%= item.Value %>"><%= item.Text %></option>
            <% } %>
            <% } %>
        </select>
    </div>


    <!-- Table Section -->
    <div id="DMSDocUploadTable" class="table-responsive border rounded bg-white p-2">
        <div class="text-center text-muted py-4 small">
            No documents available. Please select a document type.
        </div>
    </div>

</div>