<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%
    string clinicType = Convert.ToString(ViewBag.SchemeClinicType);
%>

<style>
    .tabulator-row.tabulator-selected {
    background-color: #b8d8ff !important;
    color: #000 !important;
}
    /* Pre-Auth Scheme Type Colors */
.scheme-type-R {
    background-color: #e3f2fd !important;
}

.scheme-type-M {
    background-color: #fff3e0 !important;
}

.scheme-type-S {
    background-color: #e8f5e9 !important;
}

.clsdivtatus {
    width: 13px;
    height: 13px;
    float: left;
    margin-top: 8px;
    border: 1px solid #313131;
    margin-left: 19px;
    margin-right: 5px;
}
</style>

<script>
    var RMOFlagSchemeYN = '<%: Session["RMOYN"] ?? "" %>' == "Y" ? ('<%:@OncologyEMR.DataClass.GeneralFunction.GetAppsettingUnitWiseValue("RMOSAVESCHEMEYN")%>' == "Y" ? "Y" : "N") : "Y";
    var EnableScheme = sessionStorage.getItem("PatCompleted") != "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" ? (RMOFlagSchemeYN == "Y" ? true : false) : false;
    window.NewReqSchemeAdviceTbl = window.NewReqSchemeAdviceTbl || {};
    window.ReqSchemeAdviceTbl = window.ReqSchemeAdviceTbl || {};
    window.reqSchemeLockedTranNo = window.reqSchemeLockedTranNo || {}; 
    var isProcessingSelection = false;
    var PatientCompCode = sessionStorage.getItem('OPDCompCode');
    $(document).ready(function () {
        ReqSchemePatList('<%= clinicType %>', PatientCompCode);
        NewReqSchemeAdviceTbl['<%= clinicType %>'] = new Tabulator(
          "#NewReqSchemeAdviceTbl_<%= clinicType %>",
            {
                layout: "fitColumns",
                autoResize: true,
                cellVertAlign: "top",
                resizableColumns: true,
                height: "50",
                index: "code",
                rowHeader: {
                    frozen: true,
                    hozAlign: "center",
                    formatter: "rownum",
                    width: 50
                },
                columns: [
                    {
                        title: "Action",
                        field: "act",
                        width: 80,
                        visible: true,
                        formatter: function (cell) {
                            return cell.getValue();
                        },
                        hozAlign: "center",
                        cellClick: function (e, cell) {
                            var row = cell.getRow();
                            var data = row.getData();
                            if ($(e.target).hasClass("info-row")) {
                                HistoryPopupOpen('Advice Schemes Info', 'AdviceSchemeInfo', true, data);
                            }
                            if ($(e.target).hasClass("delete-row")) {
                                row.delete();
                                adjustTableHeight("NewReqSchemeAdviceTbl_<%= clinicType %>");
                                if (PatientCompCode == "") {
                                    HandleReqSchemeTableState("<%= clinicType %>"); // Pournima 1st Sept 2026
                                }
                            }
                        }
                    },
                    { title: "Code", field: "code", visible: false },
                    {
                        title: "Name",
                        field: "name",
                        editor: false,
                        formatter: "textarea",
                        formatterParams: {
                            minHeight: "auto",
                        },
                        cssClass: "wrap-text"
                    }
                ]
            });

        NewReqSchemeAdviceTbl['<%= clinicType %>'].on("cellEdited", function (cell) {
            cell.getRow().normalizeHeight();
            adjustTableHeight("NewReqSchemeAdviceTbl_<%= clinicType %>");
        });

        NewReqSchemeAdviceTbl['<%= clinicType %>'].on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("NewReqSchemeAdviceTbl_<%= clinicType %>");
            HandleReqSchemeTableState("<%= clinicType %>");  // Pournima 1st Sept 2026
        });

        NewReqSchemeAdviceTbl['<%= clinicType %>'].on("rowDeleted", function (row) {
            adjustTableHeight("NewReqSchemeAdviceTbl_<%= clinicType %>");
            var code = row.getData().code;
            //$(".scheme-checkbox[data-code='" + code + "']").prop("checked", false);
            $("#ReqAllSchemesList_<%= clinicType %>").find(".reqscheme-checkbox-<%= clinicType %>[data-code='" + code + "']").prop("checked", false); // Pournima 1st Sept 2026

            // Re-enable Pre Auth checkboxes if Request Scheme table is now empty
            if (NewReqSchemeAdviceTbl['<%= clinicType %>'].getData().length === 0) {
                DisablePreAuthSelection('<%= clinicType %>', false);
            }
            if (PatientCompCode == "") {
                HandleReqSchemeTableState('<%= clinicType %>'); // Pournima 1st Sept 2026
            }
        });

        NewReqSchemeAdviceTbl['<%= clinicType %>'].on("tableBuilt", function () {
            adjustTableHeight("NewReqSchemeAdviceTbl_<%= clinicType %>");
        });

        NewReqSchemeAdviceTbl['<%= clinicType %>'].on("dataChanged", function () {
            adjustTableHeight("NewReqSchemeAdviceTbl_<%= clinicType %>");
        });
        ReqSchemeAdviceTbl['<%= clinicType %>'] = new Tabulator("#ReqSchemeAdviceTbl_<%= clinicType %>", {
            layout: "fitColumns",
            autoResize: true,
            cellVertAlign: "top",
            resizableColumns: true,
            height: "50",
            index: "TRANNO",
            selectableRows: true,
            selectableRowsPersistence: false,
            headerSort: false,
            rowFormatter: function (row) {
                var el = row.getElement();
                if (!el._reqSchemeClickGuardAttached) {
                    el.addEventListener("click", function (e) {
                        if (!$(e.target).closest("input[type='checkbox']").length) {
                            e.stopPropagation();
                            e.stopImmediatePropagation();
                        }
                    }, true);
                    el._reqSchemeClickGuardAttached = true;
                }
            },
            rowClick: function (e, row) {
                if (!$(e.target).closest("input[type='checkbox']").length) {
                    e.stopPropagation();
                }
            },
            columns: [
                {
                    formatter: "rowSelection",
                    hozAlign: "center",
                    headerSort: false,
                    width: 35,
                    visible : false
                },
                { title: "MRNo", field: "MRNO", visible: false, headerSort: false, width: 50 },
                { title: "Pre Auth Tran No.", field: "TRANNO", headerSort: false, width: 120 },
                { title: "Advice Tran No", field: "ADVICETRANNO", headerSort: false, visible: false, width: 120 },
                { title: "Advice Date/Time", field: "ADVICEDTTM", headerSort: false, width: 110 },
                { title: "Scheme Codes", field: "SCHEMECODES", headerSort: false, visible: false, width: 50 },
                { title: "Scheme Name", field: "SCHEMENAME", headerSort: false },
                { title: "Ref Tran No.", field: "REFTRANNO", headerSort: false, visible: false, width: 50 },
                { title: "Type", field: "SCHEMETYPE", headerSort: false, visible: false, width: 50 },
                { title: "Company Code", field: "COMPANYCODE", headerSort: false, visible: false, width: 50 },
                { title: "Status", field: "AUTHSTATUS", headerSort: false, width: 100 }
            ]
        });
        ReqSchemeAdviceTbl['<%= clinicType %>'].on("cellEdited", function (cell) {
            cell.getRow().normalizeHeight();
            adjustTableHeight("ReqSchemeAdviceTbl_<%= clinicType %>");
            });

        ReqSchemeAdviceTbl['<%= clinicType %>'].on("rowAdded", function (row) {
            row.normalizeHeight();
            adjustTableHeight("ReqSchemeAdviceTbl_<%= clinicType %>");
                var reqTable = NewReqSchemeAdviceTbl['<%= clinicType %>'];
                if (reqTable && reqTable.getData().length > 0) {
                    DisablePreAuthSelection('<%= clinicType %>', true);
                }
            });

        ReqSchemeAdviceTbl['<%= clinicType %>'].on("rowDeleted", function (row) {
            adjustTableHeight("ReqSchemeAdviceTbl_<%= clinicType %>");
            });

        ReqSchemeAdviceTbl['<%= clinicType %>'].on("dataLoaded", function () {
            adjustTableHeight("ReqSchemeAdviceTbl_<%= clinicType %>");
                var reqTable = NewReqSchemeAdviceTbl['<%= clinicType %>'];
                if (reqTable && reqTable.getData().length > 0) {
                    DisablePreAuthSelection('<%= clinicType %>', true);
                }
            });

        ReqSchemeAdviceTbl['<%= clinicType %>'].on("tableBuilt", function () {
            adjustTableHeight("ReqSchemeAdviceTbl_<%= clinicType %>");
            });

        ReqSchemeAdviceTbl['<%= clinicType %>'].on("dataChanged", function () {
            adjustTableHeight("ReqSchemeAdviceTbl_<%= clinicType %>");
            });
        ReqSchemeAdviceTbl['<%= clinicType %>'].on("rowSelected", function (row) {
            var CType = '<%= clinicType %>';
                var tranNo = row.getData().TRANNO;

                if (window.reqSchemeLockedTranNo[CType] !== undefined &&
                    window.reqSchemeLockedTranNo[CType] == tranNo) {
                    return;
                }

                if (!isProcessingSelection) {
                    if (!ValidateTreatmentAdviceForPreAuth(CType)) {
                        isProcessingSelection = true;
                        row.deselect();
                        isProcessingSelection = false;
                        return;
                    }
                }

                var data = ReqSchemeAdviceTbl[CType].getSelectedRows()
                    .map(row => row.getData())
                    .filter(x => x.REFTRANNO == "");
                if (data.length > 0) {
                    $("#ReqSchemeInputSearch_" + CType).prop("disabled", true);
                    $("#Req_DivSchemeSearchMainDiv_" + CType).hide();
                }

                var reqTable = NewReqSchemeAdviceTbl[CType];
                if (reqTable && reqTable.getData().length > 0) {
                    reqTable.setData([]);
                }

                if (isProcessingSelection) return;
                isProcessingSelection = true;
                //var table = ReqSchemeAdviceTbl[CType];
                //table.getRows().forEach(function (r) {
                //    if (r.getData().TRANNO === tranNo) {
                //        r.select();
                //    } else {
                //        r.deselect();
                //    }
                //});
                isProcessingSelection = false;
            });

        ReqSchemeAdviceTbl['<%= clinicType %>'].on("rowDeselected", function (row) {
            var CType = '<%= clinicType %>';
                var tranNo = row.getData().TRANNO;

                if (window.reqSchemeLockedTranNo[CType] !== undefined &&
                    window.reqSchemeLockedTranNo[CType] == tranNo) {
                    return;
                }

                var data = ReqSchemeAdviceTbl[CType].getSelectedRows()
                    .map(row => row.getData())
                    .filter(x => x.REFTRANNO == "");
                if (data.length == 0) {
                    $("#ReqSchemeInputSearch_" + CType).prop("disabled", false);
                }


                if (isProcessingSelection) return;
                isProcessingSelection = true;
                table.getRows().forEach(function (r) {
                    if (r.getData().TRANNO === tranNo) {
                        r.deselect();
                    }
                });
                isProcessingSelection = false;
            });
        $(document).on("click", function (e) {
            var clinicType = '<%= clinicType %>';
            if (!$(e.target).closest("#ReqSchemeInputSearch_" + clinicType + ", #Req_DivSchemeSearchMainDiv_" + clinicType).length) {
                $("#Req_DivSchemeSearchMainDiv_" + clinicType).hide();
                $("#ReqSchemeInputSearch_" + clinicType).val("");
            }
        });
        $(document).off("input", "#ReqSchemeInputSearch_<%= clinicType %>")
            .on("input", "#ReqSchemeInputSearch_" + '<%= clinicType %>', function () {
                FilterBindedSearchListForReqSchemes('<%= clinicType %>');
            });

            <%--$(document).off("click", "#ReqSchemeInputSearch_<%= clinicType %>")
            .on("click", "#ReqSchemeInputSearch_" + '<%= clinicType %>', function () {
                ReqSchemePatList('<%= clinicType %>');
            });--%>
        var CType = "<%= clinicType %>";

        function initReqSchemeAfterSavedList() {
            if (CType == "R") {
                $("#PreAuthListHeader").hide();
                $("#PreAuthListTbl").hide();
            } else {
                LoadPreAuthScheme(CType);
            }
            LoadReqScheme(CType);

            if (!EnableScheme) {
                $("#ReqSchemeInputSearch_" + CType).prop("disabled", true);
            }
        }

        var needsSavedListPreload = (CType == "M" && typeof MedSchemeCodes !== "undefined" && MedSchemeCodes != "");
        if (needsSavedListPreload) {
            if (typeof MedSchemeCodesFrom !== "undefined" && MedSchemeCodesFrom == "C") {
                $("#ReqSchemeInputSearch_" + CType).prop("disabled", true);
            }
            BindSavedNewReqSchemeList(MedSchemeCodes, CType, (typeof MedSchemeCodesFrom !== "undefined" && MedSchemeCodesFrom == "C" ? "Y" : ""), initReqSchemeAfterSavedList);
        } else {
            initReqSchemeAfterSavedList();
        }
        //************************* Pournima 1st Sept 2026 *************************
        if (PatientCompCode == "") {
            $("#GovSchemeDiv").show();
            $("#ReqCompInputSearch").prop("disabled", true);
            $("#ReqSchemeInputSearch_" + '<%= clinicType %>').prop("disabled", true);

            $("#ReqCompInputSearch").off("change").on("change", function () {
                var CType = "<%= clinicType %>";
                var selectedCompCode = $(this).val();
                if (!selectedCompCode) {
                    $("#ReqSchemeInputSearch_" + CType).prop("disabled", true).val("");
                    $("#Req_DivSchemeSearchMainDiv_" + CType).hide();
                    return;
                }
                ReqSchemePatList(CType, selectedCompCode);
                $("#ReqSchemeInputSearch_" + CType).prop("disabled", false);
            });

            $("#RbtnGovScheme").off("change").on("change", function () {
                var CType = "<%= clinicType %>";
                    SetGovSchemeControls(CType);
                });
        }
        //************************* End *************************
    });


  <%-- New Scheme Request --%>
    function GetSelectedSchemeCodes(CType) {
        var SchemeCodes = ""; var ReqSchemeCompCode = "";
        if (PatientCompCode != "") {
            var table = NewReqSchemeAdviceTbl[CType];
            var Pretable = ReqSchemeAdviceTbl[CType];
            if (table && table.getData().length > 0) {
                var data = table.getData();
                SchemeCodes = data.map(row => row.code).join(",");
                return {
                    SchemeCodes: SchemeCodes, ReqSchemeCompCode: ReqSchemeCompCode
                };
            }

        } else {
            if ($("#ReqCompInputSearch").val() != null && $("#ReqCompInputSearch").val() != "") {
                var table = NewReqSchemeAdviceTbl[CType];
                var Pretable = ReqSchemeAdviceTbl[CType];
                if (table && table.getData().length > 0) {
                    var data = table.getData();
                    SchemeCodes = data.map(row => row.code).join(",");
                }
                if (SchemeCodes.length > 0) {
                    ReqSchemeCompCode = $("#ReqCompInputSearch").val();
                }
                return {
                    SchemeCodes: SchemeCodes, ReqSchemeCompCode: ReqSchemeCompCode
                };
            }
        }
        return "";
    }

    function BindSavedNewReqSchemeList(SchemeCodes, CType, DisabledRow, callback) {
        debugger;
        var table = NewReqSchemeAdviceTbl[CType];
        if (table && SchemeCodes != "") {
            var strCompCode = PatientCompCode != "" ? sessionStorage.getItem('OPDCompCode') : "";
            $.ajax({
                url: '../SinglePage/GetSchemeCodeToList',
                type: 'post',
                async: true,
                datatype: 'json',
                data: {
                    CreditComp: strCompCode,
                    SchemeType: CType,
                    SchemeCodes: SchemeCodes
                },
                success: function (data) {
                    table.setData([]);
                    var ShowDelIcon = DisabledRow == "Y" ? false : sessionStorage.getItem("PatCompleted") != "Y" && '<%: Session["AUTHYN"] ?? "" %>' != "Y" ? (RMOFlagSchemeYN == "Y" ? true : false) : false;
                    if (data && data.length > 0) {
                        data.forEach(function (item) {
                            table.addRow({
                                act: '<i class="fa fa-info-circle text-primary info-row" style="margin-right:10px;"></i>' +
                                    (ShowDelIcon ? '<i class="fa fa-trash text-danger delete-row"></i>' : ""),
                                code: item.SCHEMECODE,
                                name: item.SCHEMENAME
                            });
                        });

                        // Pournima 1st Sept 2026
                        if (ReqSchemeCompCode != "") {
                            var $ddl = $("#ReqCompInputSearch");
                            $ddl.find("option:not(:first)").remove();
                            if ($ddl.find("option[value='" + ReqSchemeCompCode + "']").length === 0) {
                                $ddl.append($("<option>", { value: ReqSchemeCompCode, text: ReqSchemeCompName || ReqSchemeCompCode }));
                            }
                            $ddl.val(ReqSchemeCompCode);
                            $("#RbtnGovScheme").prop("checked", true);
                            $ddl.prop("disabled", true);
                            if (!ShowDelIcon) {
                                $("#RbtnGovScheme").prop("disabled", true);
                                $("#ReqSchemeInputSearch_" + CType).prop("disabled", true);
                            }
                            else {
                                $("#RbtnGovScheme").prop("disabled", false);
                                $("#ReqSchemeInputSearch_" + CType).prop("disabled", false);
                                var CType = "<%= clinicType %>";
                                ReqSchemePatList(CType, ReqSchemeCompCode);
                            }
                        }
                    }
                    if (typeof callback === "function") callback();
                },
                error: function () {
                    if (typeof callback === "function") callback();
                }
            });
        } else {
            if (typeof callback === "function") callback();
        }
    }

    function CallForReqPreAuthScheme(Type) {
        var CType = "<%= clinicType %>";
        var PreAuthTable = ReqSchemeAdviceTbl[CType];
        var ReqSchemeTbl = NewReqSchemeAdviceTbl[CType];
        if (Type === "C") {
            if (CType == "S") {
                if (ReqSchemeTbl && ReqSchemeTbl.getData().length > 0) {
                    return true;
                }
                if (PreAuthTable && PreAuthTable.getData().length > 0) {
                    var selectedRows = PreAuthTable.getSelectedData();
                    if (selectedRows.length > 0) {
                        var SchemetranNo = selectedRows.map(x => x.REFTRANNO == "").join(",");
                        if (SchemetranNo.length == 0)
                            return false;
                        return true;
                    }
                }
                return false;
            }
            else if (CType == "M") {
                if (ReqSchemeTbl && ReqSchemeTbl.getData().length > 0) {
                    return true;
                }
                if (PreAuthTable && PreAuthTable.getData().length > 0) {
                    var selectedRows = PreAuthTable.getSelectedData();
                    if (selectedRows.length > 0) {
                        var SchemetranNo = selectedRows.map(x => x.REFTRANNO == "").join(",");
                        if (SchemetranNo.length == 0)
                            return false;
                        return true;
                    }
                }
            }
            else if (CType == "R") {
                return true;
            }
        }
        else {
            if (CType == "S") {
                if (ReqSchemeTbl && ReqSchemeTbl.getData().length > 0) {
                    return false;
                }
                if (PreAuthTable && PreAuthTable.getData().length > 0) {
                    var selectedRows = PreAuthTable.getSelectedData();
                    if (selectedRows.length > 0) {
                        var SchemetranNo = selectedRows.map(x => x.REFTRANNO == "").join(",");
                        if (SchemetranNo.length == 0)
                            return false;
                        return true;
                    }
                }
                return false;
            }
            else if (CType == "M") {
                if (ReqSchemeTbl && ReqSchemeTbl.getData().length > 0) {
                    return false;
                }
                if (PreAuthTable && PreAuthTable.getData().length > 0) {
                    var selectedRows = PreAuthTable.getSelectedData();
                    if (selectedRows.length > 0) {
                        var SchemetranNo = selectedRows.map(x => x.REFTRANNO == "").join(",");
                        if (SchemetranNo.length == 0)
                            return false;
                        return true;
                    }
                }
                return false;
            }
            else if (CType == "R") {
                return true;
            }
        }
        return false;
    }

    function SaveForReqScheme(OPDDataToSendForDraft, Type) {
        OPDDataToSendForDraft.SaveSchemeYN = "N";
        var CType = "<%= clinicType %>";
        if (CallForReqPreAuthScheme(Type)) {
            var Reqtable = NewReqSchemeAdviceTbl[CType];
            if (Reqtable && Reqtable.getData().length > 0) {
                var tableData = Reqtable.getData();
                var schemeCodes = tableData.map(x => x.code).join(",");
                OPDDataToSendForDraft.SaveSchemeYN = "Y";
                OPDDataToSendForDraft.AllSchemeCodes = schemeCodes;
                OPDDataToSendForDraft.SchemeMRNO = sessionStorage.getItem('PatMRNO');
                OPDDataToSendForDraft.SchemeRefTranNo = "";//CType == "M" ? $("#ChemoPlan_txtTRANID").val() : sessionStorage.getItem('PatTRANNO');
                OPDDataToSendForDraft.SchemeType = CType;
                OPDDataToSendForDraft.SchemeTranMode = 1;
                OPDDataToSendForDraft.SchemeCompanyCode = PatientCompCode != "" ? SchemeCompany : "";
                OPDDataToSendForDraft.SchemeAdviceTranNo = sessionStorage.getItem('PatTRANNO');
                OPDDataToSendForDraft.ReqSchemeCompCode = PatientCompCode == "" ? $("#ReqCompInputSearch").val() : "";
            }
            if (CType != "R") {
                var PreAuthTable = ReqSchemeAdviceTbl[CType];
                if (PreAuthTable && PreAuthTable.getData().length > 0) {
                    var selectedRows = PreAuthTable.getSelectedData();
                    if (selectedRows.length > 0) {
                        var schemeCodes = selectedRows.map(x => x.SCHEMECODES).join(",");
                        var SchemetranNo = selectedRows.map(x => x.TRANNO).join(",");
                        var SchemeCompany = selectedRows.map(x => x.COMPANYCODE).join(",");
                        OPDDataToSendForDraft.SaveSchemeYN = "Y";
                        OPDDataToSendForDraft.AllSchemeCodes = schemeCodes;
                        OPDDataToSendForDraft.SchemeMRNO = sessionStorage.getItem('PatMRNO');
                        OPDDataToSendForDraft.SchemeRefTranNo = CType == "M" ? $("#ChemoPlan_txtTRANID").val() : sessionStorage.getItem('PatTRANNO');
                        OPDDataToSendForDraft.SchemeType = CType;
                        OPDDataToSendForDraft.SchemeTranMode = 2;
                        OPDDataToSendForDraft.SchemeTranNo = SchemetranNo;
                        OPDDataToSendForDraft.SchemeCompanyCode = PatientCompCode != "" ? SchemeCompany : "";
                        OPDDataToSendForDraft.SchemeAdviceTranNo = sessionStorage.getItem('PatTRANNO');
                        OPDDataToSendForDraft.ReqSchemeCompCode = PatientCompCode == "" ? $("#ReqCompInputSearch").val() : "";
                    }
                }
            }
        }
    }

    function ValidateTreatmentAdviceForPreAuth(CType) {
        if (CType === "S") {
            if (typeof advicesurgerylisttable === "undefined" ||
                advicesurgerylisttable.getData().length === 0) {
                ToastMsg("Please add Surgery Advice before selecting Pre Auth.", "warning");
                return false;
            }
        }
        if (CType === "M") {
            if ($("#ChkSaveChemoPlan").prop("checked") == false) {
                ToastMsg("Please check enable planning before selecting Pre Auth.", "warning");
                return false;
            }
            if ($("#ddlChemoPlanTName").val() == "") {
                ToastMsg("Please select Protocol before selecting Pre Auth.", "warning");
                return false;
            }
        }
        if (CType === "R") {
            return true;
        }
        return true;
    }

    function LoadReqScheme(clinicType) {
        $(document).off("change.reqScheme", ".reqscheme-checkbox-" + clinicType).on("change.reqScheme", ".reqscheme-checkbox-" + clinicType, function () {
            var code = $(this).data("code");
            var name = $(this).data("name");
            var table = NewReqSchemeAdviceTbl[clinicType];
            if (this.checked) {
                var preAuthTable = ReqSchemeAdviceTbl[clinicType];
                if (preAuthTable) {
                    var preAuthData = preAuthTable.getData();
                    var pendingScheme = preAuthData.find(function (row) {
                        if (!row.SCHEMECODES || !row.AUTHSTATUS) {
                            return false;
                        }
                        var schemeCodes = row.SCHEMECODES.toString().split(",").map(function (x) { return x.trim(); });
                        return schemeCodes.indexOf(code.toString()) >= 0 &&
                            row.AUTHSTATUS.toString().toLowerCase() === "pending";
                    });
                    if (pendingScheme) {
                        ToastMsg("Same scheme is already applied and is in Pending mode.", "warning");
                        $(this).prop("checked", false);
                        return;
                    }
                }
                var exists = table.getData().some(function (r) {
                    return r.code.toString() === code.toString();
                });
                if (exists) {
                    ToastMsg("Scheme already added", "warning");
                    $(this).prop("checked", false);
                    return;
                }
                table.addRow({
                    act: '<i class="fa fa-info-circle text-primary info-row" style="margin-right:10px;"></i>' + '<i class="fa fa-trash text-danger delete-row"></i>',
                    code: code,
                    name: name
                });
                DisablePreAuthSelection(clinicType, true);
            }
            else {
                var row = table.getRow(code);
                if (row) {
                    row.delete();
                }
                if (table.getData().length === 0) {
                    DisablePreAuthSelection(clinicType, false);
                }
                HandleReqSchemeTableState(clinicType);
            }
        });
    }

    function DisablePreAuthSelection(clinicType, disable) {
        var preAuthTable = ReqSchemeAdviceTbl[clinicType];
        if (!preAuthTable) return;

        if (disable) {
            // Deselect all rows first
            //preAuthTable.getSelectedRows().forEach(function (r) { r.deselect(); });
            preAuthTable.getSelectedRows().forEach(function (r) {
                var DeSelectFlg = true;
                var ConsultNo = sessionStorage.getItem('PatTRANNO') || "";
                if ($("#ChemoPlan_txtTRANID").val() != "" && r.getData().ADVICETRANNO == $("#ChemoPlan_txtTRANID").val()) {
                    DeSelectFlg = false;
                }
                if (ConsultNo != "" && r.getData().ADVICETRANNO == ConsultNo) {
                    DeSelectFlg = false;
                }
                if (DeSelectFlg)
                    r.deselect();
            });
            // Disable only the row selection checkboxes
            $(preAuthTable.element).find("input[type='checkbox']").each(function () {
                $(this).prop("disabled", true).css("cursor", "not-allowed").css("opacity", "0.4");
            });
        } else {
            // Re-enable the row selection checkboxes
            $(preAuthTable.element).find("input[type='checkbox']").each(function () {
                var DisableFlg = true;
                var ConsultNo = sessionStorage.getItem('PatTRANNO') || "";
                var row = preAuthTable.getRow($(this).closest(".tabulator-row")[0]);
                if (row) {
                    var data = row.getData();
                    if ($("#ChemoPlan_txtTRANID").val() != "" &&
                        data.ADVICETRANNO == $("#ChemoPlan_txtTRANID").val()) {
                        DisableFlg = false;
                    }
                    if (ConsultNo != "" &&
                        data.ADVICETRANNO == ConsultNo) {
                        DisableFlg = false;
                    }
                }
                if (DisableFlg) {
                    $(this).prop("disabled", false).css("cursor", "").css("opacity", "");
                }
            });
        }
    }

    function ReqSchemePatList(clinicType, CompCode) {
        var searchTxt = $("#ReqSchemeInputSearch_" + clinicType).val().toLowerCase();
        var strMRNo = sessionStorage.getItem('PatMRNO');
        var strCompCode = PatientCompCode != "" ? sessionStorage.getItem('OPDCompCode') : CompCode;
        $.ajax({
            url: '../DoctorDesk/GetSchemaList',
            data: {
                PatMRNO: strMRNo,
                Speciality: clinicType,
                strCompCode: strCompCode
            },
            async: true,
            type: 'post',
            datatype: 'json',
            success: function (response) {
                //BindSearchListForReqAllSchemes(
                //    response || [],
                //    clinicType
                //);
                    //Modified by Pournima on 1st Sept 2026
                if (CompCode != "") {
                    BindSearchListForReqAllSchemes(response || [], clinicType);
                    $("#ReqSchemeInputSearch_" + clinicType).prop("disabled", false);
                }
                else {
                    BindReqCompanyList(response || []);
                    $("#ReqSchemeInputSearch_" + clinicType).prop("disabled", true).val("");
                    $("#Req_DivSchemeSearchMainDiv_" + clinicType).hide();
                }
            },
            error: function () {
                if (CompCode == "") {
                    $("#ReqCompInputSearch").prop("disabled", true);
                }
                $("#ReqSchemeInputSearch_" + clinicType).prop("disabled", true);
            }
        });
    }

    function BindSearchListForReqAllSchemes(data, clinicType) {
        var $list = $("#ReqAllSchemesList_" + clinicType);
        $list.empty();
        $("#ReqSchemeInputSearch_" + clinicType).val("");
        var addedCodes = ReqGetAddedSchemeCodes(clinicType);
        var html = "";
        if (data.length == 0) {
            html = '<div class="list-group-item text-muted">' +
                'No schemes found' +
                '</div>';
        }
        else {
            $.each(data, function (i, item) {
                var isChecked = addedCodes.indexOf(item.Value) >= 0 ? "checked" : "";
                html +=
                    '<div class="list-group-item reqschemes-row">' +
                    '<input type="checkbox" ' +
                    'class="reqscheme-checkbox-' + clinicType + '" ' +
                    'data-code="' + item.Value + '" ' +
                    'data-name="' + item.Text + '" ' +
                    'id="reqscheme_' + clinicType + '_' + i + '" ' +
                    isChecked +
                    '/>' +
                    '<label for="reqscheme_' + clinicType + '_' + i + '" style="margin-left:5px;">' +
                    item.Text + ' (' + item.Value + ')' +
                    '</label>' +
                    '</div>';
            });
        }
        $list.append(html);
        //$("#Req_DivSchemeSearchMainDiv_" + clinicType).show();
    }

    function ReqGetAddedSchemeCodes(clinicType) {
        if (!NewReqSchemeAdviceTbl[clinicType])
            return [];
        return NewReqSchemeAdviceTbl[clinicType].getData().map(function (r) { return r.code; });
    }

    function FilterBindedSearchListForReqSchemes(clinicType) {
        var searchTxt = $("#ReqSchemeInputSearch_" + clinicType).val().toLowerCase();
        if (searchTxt.length >= 3) {
            $("#ReqAllSchemesList_" + clinicType + " .reqschemes-row").each(function () {
                var $chk = $(this).find(".reqscheme-checkbox-" + clinicType);
                var name = ($chk.data("name") || "").toString().toLowerCase();
                var code = ($chk.data("code") || "").toString().toLowerCase();
                if (name.indexOf(searchTxt) > -1 || code.indexOf(searchTxt) > -1) {
                    $(this).show();
                }
                else {
                    $(this).hide();
                }
            });
            $("#Req_DivSchemeSearchMainDiv_" + clinicType).show();
        }
        else {
            $("#Req_DivSchemeSearchMainDiv_" + clinicType).hide();
        }
    }

    //**************************** Pournima 1st Sept 2026 ****************************
    function BindReqCompanyList(response) {
        var $ddl = $("#ReqCompInputSearch");
        $ddl.empty();
        $ddl.append($('<option>', { value: '', text: '--Select--', disabled: true, selected: true }));
        var uniqueCompanies = {};
        $.each(response, function (index, item) {
            var compCode = item.CompCode;
            var compName = item.CompName;
            if (compCode && !uniqueCompanies[compCode]) {
                uniqueCompanies[compCode] = true;
                $ddl.append($('<option>', { value: compCode, text: compName }));
            }
        });
        if ($("#RbtnGovScheme").prop("checked")) {
            $ddl.prop("disabled", false);
        }
        else {
            $ddl.prop("disabled", true);
        }
    }

    function SetGovSchemeControls(clinicType) {
        var isGovScheme = $("#RbtnGovScheme").prop("checked");
        var $company = $("#ReqCompInputSearch");
        var $schemeSearch = $("#ReqSchemeInputSearch_" + clinicType);
        var $schemeDiv = $("#Req_DivSchemeSearchMainDiv_" + clinicType);

        if (!isGovScheme) {
            $company.prop("disabled", true).val("");
            $schemeSearch.prop("disabled", true).val("");
            $schemeDiv.hide();
            $company.empty().append($('<option>', { value: '', text: '--Select--', disabled: true, selected: true }));
            $("#ReqAllSchemesList_" + clinicType).empty();
            var table = NewReqSchemeAdviceTbl[clinicType];
            if (table) {
                table.setData([]);
            }
            return;
        }
        $company.prop("disabled", false);
        $schemeSearch.prop("disabled", true).val("");
        $schemeDiv.hide();
        ReqSchemePatList(clinicType, "");
    }

    function HandleReqSchemeTableState(clinicType) {
        var table = NewReqSchemeAdviceTbl[clinicType];
        if (!table) return;
        var schemeCount = table.getData().length;
        var $company = $("#ReqCompInputSearch");
        var $schemeSearch = $("#ReqSchemeInputSearch_" + clinicType);

        if (schemeCount > 0) {
            $company.prop("disabled", true);
        }
        else {
            if ($("#RbtnGovScheme").prop("checked")) {
                $company.prop("disabled", false);
                if ($company.val()) {
                    $schemeSearch.prop("disabled", false);
                }
                else {
                    $schemeSearch.prop("disabled", true);
                }
            }
            else {
                $company.prop("disabled", true);
                $schemeSearch.prop("disabled", true);
            }
        }
    }
    //**************************** End ****************************

<%-- Scheme Attach --%>
    function LoadPreAuthScheme(CType) {
        GetAllReqSchemeList(CType, true, function () {
            var otherTypes = ["R", "M", "S"].filter(function (type) {
                return type !== CType;
            });

            var index = 0;
            function loadNextType() {
                if (index >= otherTypes.length) {
                    return;
                }
                var type = otherTypes[index];
                index++;
                GetAllReqSchemeList(type, false, loadNextType);
            }
            loadNextType();
        });
    }

    function GetAllReqSchemeList(CType, ShowCheckbox, callback) {
        var strMRNo = sessionStorage.getItem('PatMRNO');
        $.ajax({
            url: '../SinglePage/GetPreAuthSchemeList',
            data: {
                SchemeType: CType,
                MRNo: strMRNo,
                IPNo: ""
            },
            type: 'post',
            datatype: 'json',
            async: true,

            success: function (response) {
                var isCompleted = sessionStorage.getItem('PatCompleted') === "Y" || '<%: Session["AUTHYN"] ?? "" %>' === "Y";
                var patTranNo = sessionStorage.getItem('PatTRANNO');
                var table = ReqSchemeAdviceTbl['<%= clinicType %>'];
                if (!table) {
                    if (typeof callback === "function") callback();
                    return;
                }
                if (ShowCheckbox) {
                    table.setData([]);
                    window.reqSchemeLockedTranNo['<%= clinicType %>'] = undefined;
                }
                if (response && response.length > 0) {
                    var lockedTranNos = [];
                    var unselectableTranNos = [];

                    // ==========================================
                    // SCHEME TYPE = S
                    // ==========================================
                    if (CType == "S") {
                        var matchedRecord = response.filter(function (item) {
                            return item.REFTRANNO && item.REFTRANNO != "" && item.REFTRANNO == patTranNo;
                        });
                        response = response.filter(function (item) {
                            return !item.REFTRANNO || item.REFTRANNO === "" || item.REFTRANNO == patTranNo;
                        });
                        if (matchedRecord.length > 0) {
                            if (isCompleted)
                                response = matchedRecord;
                            lockedTranNos = matchedRecord.map(function (item) { return item.TRANNO; }).filter(function (tranNo) {
                                return tranNo && tranNo != "";
                            });
                        }
                        else {
                            response = response.filter(function (item) {
                                return !item.REFTRANNO || item.REFTRANNO === "";
                            });
                        }
                    }
                    // ==========================================
                    // SCHEME TYPE = M
                    // ==========================================
                    else if (CType == "M") {
                        var chemoPlanNo = $("#ChemoPlan_txtTRANID").val();
                        if (chemoPlanNo && chemoPlanNo != "") {
                            if (response.length === 1 && (!response[0].REFTRANNO || response[0].REFTRANNO === "")) {
                                unselectableTranNos.push(response[0].TRANNO);
                            }
                            else {
                                var matchedRecordM = response.filter(function (item) {
                                    return item.REFTRANNO && item.REFTRANNO != "" && item.REFTRANNO == chemoPlanNo;
                                });
                                if (matchedRecordM.length > 0) {
                                    response = !EnableScheme ? matchedRecordM : response;
                                    lockedTranNos = matchedRecordM.map(function (item) { return item.TRANNO; }).filter(function (tranNo) { return tranNo && tranNo != ""; });
                                }
                            }
                        }
                    }

                    // ==========================================
                    // ADD RESPONSE ROWS
                    // ==========================================
                    response.forEach(function (item) {
                        item.ShowCheckbox = ShowCheckbox;
                        item.PreAuthSchemeType = CType;
                        table.addRow(item);
                    });



                    table.on("renderComplete", function () {
                        table.off("renderComplete");

                        // ==========================================
                        // APPLY COLOR BASED ON SCHEME TYPE
                        // ==========================================
                        table.getRows().forEach(function (row) {
                            var rowData = row.getData();
                            var rowElement = row.getElement();

                            // Remove any previous scheme type color
                            $(rowElement).removeClass(
                                "scheme-type-R scheme-type-M scheme-type-S"
                            );

                            // Add color ONLY for R, M, S
                            if (rowData.PreAuthSchemeType === "R") {
                                $(rowElement).addClass("scheme-type-R");
                            }
                            else if (rowData.PreAuthSchemeType === "M") {
                                $(rowElement).addClass("scheme-type-M");
                            }
                            else if (rowData.PreAuthSchemeType === "S") {
                                $(rowElement).addClass("scheme-type-S");
                            }
                        });

                        // ==========================================
                        // EXISTING CODE
                        // ==========================================
                        if (ShowCheckbox) {
                            if (lockedTranNos.length > 0) {
                                window.reqSchemeLockedTranNo['<%= clinicType %>'] = lockedTranNos;

                                lockedTranNos.forEach(function (tranNo) {
                                    var lockedRow = table.getRow(tranNo);

                                    if (lockedRow) {
                                        isProcessingSelection = true;
                                        lockedRow.select();

                                        $(lockedRow.getElement())
                                            .find("input[type='checkbox']")
                                            .prop("disabled", true)
                                            .css({
                                                "cursor": "not-allowed",
                                                "opacity": "0.4"
                                            });
                                    }
                                });

                                NewReqSchemeAdviceTbl['<%= clinicType %>'].setData([]);
                            }

                            // Disable all checkboxes if scheme is disabled
                            if (!EnableScheme) {
                                $(table.element)
                                    .find("input[type='checkbox']")
                                    .each(function () {
                                        $(this)
                                            .prop("disabled", true)
                                            .css("cursor", "not-allowed")
                                            .css("opacity", "0.4");
                                    });
                            }
                            else if (unselectableTranNos.length > 0) {
                                unselectableTranNos.forEach(function (tranNo) {
                                    var targetRow = table.getRow(tranNo);

                                    if (targetRow) {
                                        $(targetRow.getElement())
                                            .find("input[type='checkbox']")
                                            .prop("disabled", true)
                                            .css({
                                                "cursor": "not-allowed",
                                                "opacity": "0.4"
                                            });
                                    }
                                });
                            }
                        }

                        // ==========================================
                        // HIDE CHECKBOX FOR OTHER SCHEME TYPES
                        // ==========================================
                        if (!ShowCheckbox) {
                            $(table.element).find(".tabulator-row").each(function () {
                                var row = table.getRow(this);

                                if (row) {
                                    var rowData = row.getData();

                                    if (rowData.ShowCheckbox === false) {
                                        $(this)
                                            .find(".tabulator-cell.tabulator-row-selection")
                                            .hide();

                                        $(this)
                                            .find("input[type='checkbox']")
                                            .prop("disabled", true)
                                            .hide();
                                    }
                                }
                            });
                        }
                    });
                }
                if (typeof callback === "function") {
                    callback();
                }
            },
            error: function () {
                if (typeof callback === "function") {
                    callback();
                }
            }
        });
    }


</script>

<div id="sec-ReqScheme_<%= clinicType %>">
    <hr />
        <%--Pournima 1st Sept 2026--%>
    <div id="GovSchemeDiv" class="row mb-3" style="display:none;">
        <div style="display: flex;align-items: center;width: 100%;">
            <h4 class="text-custom-black fw-semibold" style="font-size: 1.1rem; margin-right: 22px;">Government Scheme</h4>
            <input type="checkbox" class="Chkbox" name="GovScheme" id="RbtnGovScheme" style="vertical-align: middle;margin-right: 22px;">
            <h4 class="text-custom-black fw-semibold" style="font-size: 1.1rem; margin-right: 22px;"> Company Name</h4>
            <select type="text" id="ReqCompInputSearch" class="form-control" style="width: 25%;">
                <option value="" selected disabled>--Select--</option>
            </select>
        </div>
    </div>
    <%-- ********************* --%>

    <div class="row mb-3">
        <div class="col-md-6">
            <div style="display: flex; align-items: center;">
                <h4 class="text-custom-black fw-semibold"
                    style="font-size: 1.1rem; margin-right: 10px;">Request Scheme
                </h4>
                <div class="flex-grow-1 position-relative ms-5">

                    <div class="input-group input-group-sm w-100">
                        <input type="text" id="ReqSchemeInputSearch_<%= clinicType %>" class="form-control" placeholder="Search Scheme" />
                    </div>

                    <div id="Req_DivSchemeSearchMainDiv_<%= clinicType %>"
                        class="list-group position-absolute w-100"
                        style="z-index: 1000; max-height: 200px; overflow: auto; display: none; background: white; border: 1px solid #ccc;">

                        <div id="ReqAllSchemesList_<%= clinicType %>"
                            class="list-group w-100">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6" id="PreAuthListHeader">
            <h4 class="text-custom-black fw-semibold" style="font-size: 1.1rem;">Pre Auth List
            </h4>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div id="NewReqSchemeAdviceTbl_<%= clinicType %>">
            </div>
        </div>
        <div class="col-md-6" id="PreAuthListTbl">
            <div id="ReqSchemeAdviceTbl_<%= clinicType %>">
            </div>

            <div id="divStatus">
                <fieldset>
                    <div style="padding-top: 1px; float: right;">
                        <table>
                            <tr>
                                <td>
                                    <label class="LBLFormat" style="font-weight: bold">SchemeType : </label>
                                </td>
                                <td>
                                    <div class="clsdivtatus" style="background-color: #fff3e0;"></div>
                                    <label class="LBLFormat" style="font-weight: bold; vertical-align: middle;">Medical</label>
                                </td>
                                <td>
                                    <div class="clsdivtatus" style="background-color: #e3f2fd ;"></div>
                                    <label class="LBLFormat" style="font-weight: bold; vertical-align: middle;">Radiation</label>
                                </td>
                                <td>
                                    <div class="clsdivtatus" style="background-color: #e8f5e9 ;"></div>
                                    <label class="LBLFormat" style="font-weight: bold; vertical-align: middle;">Surgical</label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
    <hr />
</div>
