<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Clinicalnotes.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.Clinicalnotes>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>
    <html>
    <head>
        <title></title>
    </head>
    <body>
        <div>
            <input style="width: 100%; background-color: #f7fcff; margin-left: -17px; margin-top: -22px; position: fixed; border: none;display:none" class="empty" disabled>
        </div>
        <div id="MainDiv">
           <div style="width:100%;text-align:center">
               <a class="button1 button1-green" id="divForBack" style="margin-bottom: 2.5%" onclick="SetpageDirctn()">
                   <i class="fa fa-arrow-left"></i>
                   <strong>Back</strong>
               </a>
               <input type="button" class="btn btn-primary" style="float:right" id="AllergyAdd" value="Add New Allergy" />
            </div>
            <div id="ContentHolderDiv" class="contentHoldClass" style="width: 100%;">
                <label id="btnSaveAllergy" style="display:none; background-color: transparent; float: right; margin-right: 25px; border-color: transparent;" title="Save">
                    <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                </label>

     <%-- Added by Dhananjay 20250926 --%>
     <div style="position: fixed; bottom: 5%; left: 25%; right: 15%; text-align: center; z-index: 1000;">
             <button id="btnSave" onclick="$('#btnSaveAllergy').trigger('click');"
                    style="display: inline-block; background-color: #28a745; color: white; border: none; border-radius: 5px; padding: 5px 15px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background-color 0.3s ease, transform 0.2s ease; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);"
                    onmouseover="this.style.backgroundColor='#218838'"
                    onmouseout="this.style.backgroundColor='#28a745'">
                    Save
             </button>
     </div>

                <div class="col-xs-12" id="AllergyList" style="padding: 0px;">
                    <div class="AllergyDiv table-responsive" style="width: 100%">
                        <table id="TableAllergy" class="table table-bordered table-striped AllergyTbl">
                            <thead>
                                <tr>
                                    <th style="width: 40px;"><i class="fa fa-plus AddRowIcon" aria-hidden="true" onclick="AddNewRow()"></i></th>
                                    <th style="width: 100px;">Allergy Type</th>
                                    <th>Allergies / Description</th>
                                    <th colspan="2" style="text-align: center; min-width: 50px;">Duration</th>
                                    <th style="width: 150px;">Remark / Reaction</th>
                                    <th style="width: 150px;display:none">RemarkText</th>
                                </tr>
                            </thead>
                            <tbody id="TableAllergyTBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
    </html>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .table-responsive {
            overflow-x: auto;
        }

        .AllergyTbl td, th {
            text-align: center;
            vertical-align: middle !important;
        }

        #TableAllergyTBody td{
            padding:0px !important;
        } 

        .AllergyTbl {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            font-family: Arial, sans-serif;
            font-size: 14px;
            color: #333;
        }

            .AllergyTbl th, .AllergyTbl td {
                border: 1px solid #ccc;
                padding: 8px 10px;
                text-align: center;
            }

            .AllergyTbl thead {
                font-weight: bold;
                background-color: #2d70aa;
                color: white;
            }

            .AllergyTbl tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .AllergyTbl td {
                word-wrap: break-word;
                white-space: normal; 
                min-height: 40px; 
                vertical-align: middle;
            }

        .SelectTd {
            padding: 0px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background: transparent;
            border: none;
            text-align: center;
            text-wrap-mode: wrap;
            height: auto;
            word-wrap: break-word;
            white-space: normal;
            -webkit-box-shadow : none;
            box-shadow : none;
        }
        .AllegeryDelIcon {
            cursor: pointer;
            font-size: 18px;
        }

        .AddRowIcon {
            cursor: pointer;
            font-size: 18px;
        }
    </style>

    <style>

    </style>

    <link href="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.css" rel="stylesheet" />
    <script src="../Scripts/Small-Popover-Modal-Plugin-jQuery/popover.js"></script>
    <script type="text/javascript">
       <% var Samp = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
        var AllergyTypeList = '<%:Html.Raw(Samp.Serialize(ViewBag.AllergyTypeLst))%>';
        AllergyTypeList = JSON.parse(AllergyTypeList);
        var AllergyList = [];
        var RemarkList = [];
        var DaysList = [];
        var DaysCatgList = [];
        var AllergyListForSave = [];
        var pathFrom = "";

        $(document).ready(function (e) {
            HoldOn.open();
               var doctCode =sessionStorage.getItem('DoctCode');
   var doctName =sessionStorage.getItem('DoctName');
   pathFrom =sessionStorage.getItem('Pagefrom') == undefined ? "" :sessionStorage.getItem('Pagefrom');
            SetPatientDtl();
            GetDaysList();
            GetDaysCatgList();
            GetAllergyList();
            BindSaveAllergyLst();

            $("#AllergyAdd").click(function () {
                $.confirm({
                    title: '',
                    content: '' +
                 '<form action="" class="formName" style="height:200px">' +
                    '<div class="form-group">' +
                    '<label>Allergy Type</label>' +
                    '<select id="cmbAddAllergyType" class="form-control"></select>' +
                    '<label>Allergy</label>' +
                    '<textarea  type="varchar" id="txtAddAllergy" maxlength="100"  placeholder="Allergy" autofocus="autofocus" class="Allergy form-control" required rows="5" cols="30"/>' +
                    '</form>',
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var allergy = this.$content.find('.Allergy').val().toString().trim().replace(/\s/g, ' ');
                                var selectedType = $("#cmbAddAllergyType").val();
                                var exists = AllergyList.some(function (a) {
                                    return a.TEXT.toLowerCase().trim() === allergy.toLowerCase().trim() &&
                                        String(a.TYPE).trim() === String(selectedType).trim();
                                });
                                if (exists) {
                                    $.alert("Allergy already exists.");
                                    return false;
                                } 
                                var grpCode = "";
                                if ($("#cmbAddAllergyType").val() == "") {
                                    $.alert('Select Allergy Type.');
                                    $("#cmbAddAllergyType").focus();
                                    return false;
                                }
                                if (allergy.length == 0) { 
                                    $.alert('Enter Allergy');
                                    this.$content.find('.Allergy').val("");
                                    return false;
                                }
                                if (allergy != "") {
                                    $.ajax({
                                        type: "post",
                                        datatype: "json",
                                        url: 'AddAllergy',
                                        data: { strMedical: allergy, strGrpCode: grpCode, Type: $("#cmbAddAllergyType").val() },
                                        success: function (response) {
                                            if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1)
                                            {
                                                GetAllergyList();
                                                AddNewRow();
                                                var Ind = AllergyListForSave[AllergyListForSave.length - 1].IND;
                                                var ATypeId = "cmbAllergyType_" + Ind;
                                                var AllergyId = "cmbAllergy_" + Ind;
                                                var AllerCode = response.trim().split(' ')[response.trim().split(' ').length - 1];
                                                $('[id="' + ATypeId + '"]').val($("#cmbAddAllergyType").val());
                                                $('[id="' + ATypeId + '"]').trigger('change');
                                                $('[id="' + AllergyId + '"]').val(AllerCode);
                                                $('[id="' + AllergyId + '"]').trigger('change');
                                                $("#txtAddAllergy").val("");
                                                $("#cmbAddAllergyType").val("");
                                            }
                                            else {
                                                $.messager.alert("Information", response);
                                            }
                                            $("#secCont").trigger("click");
                                        },
                                    });
                                }
                            }
                        },
                        CLOSE: function () {},
                    },
                    onContentReady: function () {
                        BindComboList("cmbAddAllergyType", AllergyTypeList, "Value", "Text", "Y");
                        $('#cmbAddAllergyType').focus();
                        var jc = this;
                        this.$content.find('form').on('submit', function (e) {
                            e.preventDefault();
                            jc.$$formSubmit.trigger('click');
                        });
                    }
                });
            });

            $("#btnSaveAllergy").click(function () {
                SaveAllAllergy("N");
            });

            HoldOn.close();
        });

        jQuery(document).ready(function ($) {
            if (window.history && window.history.pushState) {
                window.history.pushState('forward', null, './AllergyHist');
                $(window).on('popstate', function () {
                    SaveAllAllergy("N")
                });
            }
        });

        function BindSaveAllergyLst() {
            var tranNo =sessionStorage.getItem('PatTRANNO');
            var mrNo = ($.session.get('PatMRNO'));
            $.ajax({
                type: 'post',
                datatype: 'json',
                data: { strTranNo: tranNo, strMrNo: mrNo },
                url: 'SetDataForAllergy',
                success: function (data) {
                    if (data[0] != null) {
                        var Lst = data[0];
                        for (var i = 0; i < Lst.length; i++) {
                            AddNewRow();
                            var Ind = AllergyListForSave[AllergyListForSave.length - 1].IND;
                            var TypeCmbId = "cmbAllergyType_" + Ind;
                            var AllergyId = "cmbAllergy_" + Ind;
                            var DaysId = "cmbDurDays_" + Ind;
                            var DCatgId = "cmbDurCatg_" + Ind;
                            var RemarkLblId = "LBLREMARK_" + Ind;
                            $('[id="' + TypeCmbId + '"]').val(Lst[i].ALLERGYTYPE);
                            $('[id="' + TypeCmbId + '"]').trigger('change');
                            $('[id="' + AllergyId + '"]').val(Lst[i].ALLERGYCD);
                            $('[id="' + AllergyId + '"]').trigger('change');
                            $('[id="' + DaysId + '"]').val(Lst[i].DURATION);
                            $('[id="' + DaysId + '"]').trigger('change');
                            $('[id="' + DCatgId + '"]').val(Lst[i].DURTYPE);
                            $('[id="' + DCatgId + '"]').trigger('change');
                            document.getElementById(RemarkLblId).innerText = Lst[i].REMARK;
                            AllergyListForSave[AllergyListForSave.length - 1].REMARKS = Lst[i].REMARK;
                            if (Lst[i].REMARK != "") {
                                document.querySelector('#' + AllergyId + ' option[value="' + $('[id="' + AllergyId + '"]').val() + '"]').text = document.querySelector('#' + AllergyId + ' option[value="' + $('[id="' + AllergyId + '"]').val() + '"]').text
                                    + " - " + Lst[i].REMARK;
                            }
                        }
                    }
                },
                complete: function () {
                    HoldOn.close();
                }
            });
        }

        function GetDaysList() {
            for (var i = 0; i <= 100; i++) {
                var NewD = {
                    CODE: i, TEXT: i
                };
                DaysList.push(NewD);
            }
        }

        function GetDaysCatgList() {
            DaysCatgList = [
                { CODE: "D", TEXT: "Days" },
                { CODE: "W", TEXT: "Weeks" },
                { CODE: "M", TEXT: "Months" },
                { CODE: "Y", TEXT: "Years" },
            ];
        }

        function GetAllergyList() {
            $.ajax({
                type: "post",
                datatype: "json",
                async: false,
                url: 'GetMainAllergyListdt',
                success: function (response) {
                    AllergyList = response;
                },
            });
        }

        function BindAllergyList() {

        }

        function BindComboList(ComboId, ListData, PropVal, PropText, DefaultYN) {
            $('[id="' + ComboId + '"]').empty();
            var Option = '<option value="{VALUE}">{TEXT}</option>';
            if (DefaultYN == "Y") {
                var DefSel = Option.replace("{VALUE}", "").replace("{TEXT}", "--- Select ---");
                $('[id="' + ComboId + '"]').append(DefSel);
            }
            jQuery.grep(ListData, function (e) {
                var Options = Option.replace("{VALUE}", e[PropVal]).replace("{TEXT}", e[PropText]);
                $('[id="' + ComboId + '"]').append(Options);
            });
            $('[id="' + ComboId + '"]').val("");
        }

        function UpdateComboHeight(Type, Ind) {
            var TypeCmbId = "cmbAllergyType_" + Ind;
            var AllergyId = "cmbAllergy_" + Ind;
            var DaysId = "cmbDurDays_" + Ind;
            var DCatgId = "cmbDurCatg_" + Ind;
            var RemarkLblId = "LBLREMARK_" + Ind;
            if (Type == "T") {
                if ($('[id="' + TypeCmbId + '"]').val() != "") {
                    var Lst = AllergyList.filter(function (a) { return a.TYPE == $('[id="' + TypeCmbId + '"]').val(); });
                    BindComboList(AllergyId, Lst, "CODE", "TEXT", "N");
                }
                else {
                    BindComboList(AllergyId, [], "", "", "N");
                }
                $('[id="' + AllergyId + '"]').val("");
            }
            document.getElementById(TypeCmbId).style.height = "auto";
            document.getElementById(AllergyId).style.height = "auto";
            var TypeH = document.getElementById(TypeCmbId).clientHeight;
            var AllergyH = document.getElementById(AllergyId).clientHeight;
            var FHeight = TypeH > AllergyH ? TypeH : AllergyH;
            document.getElementById(TypeCmbId).style.height = FHeight + "px";
            document.getElementById(AllergyId).style.height = FHeight + "px";
            document.getElementById(DaysId).style.height = FHeight + "px";
            document.getElementById(DCatgId).style.height = FHeight + "px";
        }

        function AddNewRow() {
            var Ind = 1;
            if (AllergyListForSave.length > 0) {
                Ind = Math.max.apply(null, AllergyListForSave.map(function (item) {
                    return item.IND;
                }));
                Ind = Ind + 1;
            }
            AddRowAllergyTbl(Ind);
        }

        function AddRowAllergyTbl(Ind) {
            var Tr = "<tr id='{TRID}'>{TRCONTENT}</tr>";
            var Td = "<td {STYLE}>{TDCONTENT}</td>";
            var Act = "<i class='fa fa-trash AllegeryDelIcon' onclick=\"RemoveRowAllergyTbl('" + Ind + "');\" aria-hidden='true'></i>";
            var Combo = "<select id='{COMBOID}' onchange=\"UpdateComboHeight('{TYPE}','" + Ind + "');UpdateAllergySaveList('" + Ind + "','U');\" class='form-control SelectTd'></select>"
            var Label = "<label id='{LABELID}'></label>";
            var ATag = "<i class='fa fa-pencil fa-2x' onclick=\"AddRemark('" + Ind + "');\" aria-hidden='true'></i>";
            var RplActTd = Td.replace("{TDCONTENT}", Act).replace("{STYLE}", "");
            var TypeCmbId = "cmbAllergyType_" + Ind;
            var RplTypeCmb = Combo.replace("{COMBOID}", TypeCmbId).replace("{TYPE}", "T");
            var RplTypeTd = Td.replace("{TDCONTENT}", RplTypeCmb).replace("{STYLE}", "");
            var AllergyId = "cmbAllergy_" + Ind;
            var RplAllergyCmb = Combo.replace("{COMBOID}", AllergyId).replace("{TYPE}", "A");
            var RplAllergyTd = Td.replace("{TDCONTENT}", RplAllergyCmb).replace("{STYLE}", "");
            var DaysId = "cmbDurDays_" + Ind;
            var RplDaysCmb = Combo.replace("{COMBOID}", DaysId).replace("{TYPE}", "D");
            var RplDaysTd = Td.replace("{TDCONTENT}", RplDaysCmb).replace("{STYLE}", "");
            var DCatgId = "cmbDurCatg_" + Ind;
            var RplDCatgCmb = Combo.replace("{COMBOID}", DCatgId).replace("{TYPE}", "C");
            var RplDCatgTd = Td.replace("{TDCONTENT}", RplDCatgCmb).replace("{STYLE}", "");
            var RplRemarkIconTd = Td.replace("{TDCONTENT}", ATag).replace("{STYLE}", "");
            var RemarkLblId = "LBLREMARK_" + Ind;
            var RplLabel = Label.replace("{LABELID}", RemarkLblId);
            var RplRmkTd = Td.replace("{TDCONTENT}", RplLabel).replace("{STYLE}", "style='display: none;'");
            var TrID = "ALLERGYROW_" + Ind;
            var RplTR = Tr.replace("{TRID}", TrID).replace("{TRCONTENT}", (RplActTd + RplTypeTd + RplAllergyTd + RplDaysTd + RplDCatgTd + RplRemarkIconTd + RplRmkTd));
            $("#TableAllergyTBody").append(RplTR);
            BindComboList(TypeCmbId, AllergyTypeList, "Value", "Text", "N");
            BindComboList(DaysId, DaysList, "CODE", "TEXT", "N");
            BindComboList(DCatgId, DaysCatgList, "CODE", "TEXT", "N");
            UpdateAllergySaveList(Ind, "A");
        }

        function RemoveRowAllergyTbl(Id) {
            var RowID = "ALLERGYROW_" + Id;
            if (document.getElementById(RowID) != null) {
                document.getElementById(RowID).remove();
            }
            UpdateAllergySaveList(Id, 'D');
        }

        function AddRemark(Ind) {


            var RemarkText = "";
            $.confirm({
                title: '',
                content: '' +
                '<form action="" class="formName" style="height:auto">' +
                '<div class="form-group">' +
                '<label>Remark</label>' +
                '<textarea rows="6" id="txtRemark" maxlength="100" placeholder="Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' +//kavita
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Save',
                        btnClass: 'btn-blue',
                        action: function () {
                            var TypeCmbId = "cmbAllergyType_" + Ind;
                            var AllergyId = "cmbAllergy_" + Ind;
                            if ($('[id="' + TypeCmbId + '"]').val() == "") {
                                $.alert('Select Allergy Type.');
                                return false;
                            }
                            if ($("#txtRemark").val() == "") {
                                $.alert('Enter Remark.');
                                return false;
                            }
                            jQuery.grep(AllergyListForSave, function (e) {
                                if (e.IND == Ind) {
                                    var TAllergyLst = JSON.parse(JSON.stringify(AllergyList));
                                    var Lst = TAllergyLst.filter(function (a) {
                                        if (a.TYPE == $('[id="cmbAllergyType_' + Ind + '"]').val() && a.CODE == e.ALLERGYCD)
                                            a.TEXT = a.TEXT + "-" + $('#txtRemark').val();
                                        return a.TYPE == $('[id="cmbAllergyType_' + Ind + '"]').val();
                                    });
                                    BindComboList(AllergyId, Lst, "CODE", "TEXT", "N");
                                    e.REMARKS = $('#txtRemark').val();
                                    $('[id="' + AllergyId + '"]').val(e.ALLERGYCD);
                                }
                            });
                        }
                    },
                    REMOVE: function () {
                        $("#txtRemark").val("");
                        var TypeCmbId = "cmbAllergyType_" + Ind;
                        var AllergyId = "cmbAllergy_" + Ind;
                        jQuery.grep(AllergyListForSave, function (e) {
                            if (e.IND == Ind) {
                                var Lst = AllergyList.filter(function (a) { return a.TYPE == $('[id="cmbAllergyType_' + Ind + '"]').val(); });
                                BindComboList(AllergyId, Lst, "CODE", "TEXT", "N");
                                $('[id="' + AllergyId + '"]').val(e.ALLERGYCD);
                                e.REMARKS = $('#txtRemark').val();
                            }
                        });
                    },
                    close: function () {
                        $("#txtRemark").val("");
                    },
                },
                onContentReady: function () {
                    $('#txtRemark').focus();
                    var RemarkText = "";
                    jQuery.grep(AllergyListForSave, function (e) {
                        if (e.IND == Ind) {
                            RemarkText = e.REMARKS;
                        }
                    });
                    $('#txtRemark').val(RemarkText);
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    if ($('#txtRemark').val() == "") {
                        jc.$$REMOVE.attr("style", "display:none")
                    }
                }
            });

        }

        function UpdateAllergySaveList(Ind, Type) {
            if (Type == "A") {
                var NewD = {
                    IND: Ind,
                    MRNO:sessionStorage.getItem("PatMRNO"),
                    ALLERGYTYPE: "",
                    ALLERGYCD: "",
                    DURATION: "",
                    DURTYPE: "",
                    REMARKS: ""
                };
                AllergyListForSave.push(NewD);
            }
            else if (Type == "U") {
                ValidationForAge(Ind)
                jQuery.grep(AllergyListForSave, function (e) {
                    if (e.IND == Ind) {
                        var TypeCmbId = "cmbAllergyType_" + Ind;
                        var AllergyId = "cmbAllergy_" + Ind;
                        var DaysId = "cmbDurDays_" + Ind;
                        var DCatgId = "cmbDurCatg_" + Ind;
                        var RemarkLblId = "LBLREMARK_" + Ind;
                        e.ALLERGYTYPE = $('[id="' + TypeCmbId + '"]').val();
                        e.ALLERGYCD = $('[id="' + AllergyId + '"]').val();
                        e.DURATION = $('[id="' + DaysId + '"]').val();
                        e.DURTYPE = $('[id="' + DCatgId + '"]').val();
                        e.REMARKS = document.getElementById(RemarkLblId).innerText;
                    }
                });
            }
            else if (Type == "D") {
                var TData = JSON.parse(JSON.stringify(AllergyListForSave));
                var Filter = AllergyListForSave.filter(function (a) { return a.IND != Ind; });
                AllergyListForSave = Filter;
            }
        }

        function ValidationForAge(Ind) {
            var AgeInDays = ConvertAgeYrsToDay($.session.get('PatAge'));
            var DaysId = "cmbDurDays_" + Ind;
            var DCatgId = "cmbDurCatg_" + Ind;
            var DaysVal = $('[id="' + DaysId + '"]').val();
            var DurCatgVal = $('[id="' + DCatgId + '"]').val();
            if (DaysVal != null && DaysVal != "" && DurCatgVal != null && DurCatgVal != "" && CalcToDay(DaysVal, DurCatgVal) > AgeInDays) {
                $.messager.alert("Information", "Duration is greater than Age");
                $('[id="' + DaysId + '"]').val("0");
                $('[id="' + DCatgId + '"]').val("D");
            }
        }

        function CalcToDay(Num, DurType) {
            var MultiNum = 1;
            if (DurType == "W")
                MultiNum = 7
            if (DurType == "M")
                MultiNum = 30
            if (DurType == "Y")
                MultiNum = 365
            return (Number(Num) * MultiNum);
        }

        function ConvertAgeYrsToDay(Age) {
            var SpltAge = Age.split(' ');
            var Age = SpltAge[0];
            var Dur = SpltAge[1];
            var AgeInDay = 0;
            if (Dur == "Days")
                return Number(Age);
            else
                return Number(Age) * 365;
        }

        function SaveAllAllergy(strPlusBtn) {
            HoldOn.open();
            var mrno = ($.session.get('PatMRNO')).toString();
            var tranNo = ($.session.get('PatTRANNO')).toString();
            var FilterLst = AllergyListForSave.filter(function (a) { return a.ALLERGYCD != "" && a.ALLERGYCD != null && a.ALLERGYTYPE != null && a.ALLERGYTYPE != ""; });

            for (let i = 0; i < AllergyListForSave.length; i++) {
                let row = AllergyListForSave[i];
                if (row.ALLERGYTYPE || row.ALLERGYCD || row.DURATION || row.DURTYPE) {
                    if (!row.ALLERGYTYPE || !row.ALLERGYCD || !row.DURATION || !row.DURTYPE) {
                        alert("Please fill all required fields (Allergy Type, Allergy/Description, Duration, Duration Catrgory) in row " + (i + 1));
                        HoldOn.close();
                        return false;
                    }
                }
            }
            $.ajax({
                type: "POST",
                url: 'SaveAllergy',
                datatype: "json",
                data: { strMedic: JSON.stringify(FilterLst), strMRNO: mrno, strTranNo: tranNo },
                success: function (result) {
                    if (strPlusBtn == "N")
                        if (pathFrom != "") {
                            window.location.href = pathFrom;
                        }
                        else {
                            window.location.href = '../ClinicalNotes/ClinicEntry';
                        }
                },
                complete: function () {
                    HoldOn.close();
                }
            });
        }

        function SetpageDirctn() {
            //SaveAllAllergy("N");
            if (pathFrom == "") {
                window.location.href = '../ClinicalNotes/ClinicEntry';
            } else
                window.location.href = '../DoctorDesk/PatientEntry';
        }
    </script>

</asp:Content>
