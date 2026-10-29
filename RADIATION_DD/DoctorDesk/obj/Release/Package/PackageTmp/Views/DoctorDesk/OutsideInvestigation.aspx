<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.OutsideInvstMdl>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">

    <script src="../Scripts/Doctorlist.js"></script>
    <%-- Investigation --%>
    <style>
        .InvstFieldSet {
            width: 100%;
        }

        .InvstFieldSetLegend {
            margin-bottom: 10px;
            border-bottom: 1px solid #009300;
            color: black;
            font-size: 15px;
        }

        .AdviListMainDiv {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
        }

        .AdviListSepDiv {
            display: flex;
            align-items: center;
            border: 1px solid grey;
            background-color: #d1d1d1;
            margin: 5px 5px;
            border-radius: 10px;
            padding: 2px 0px;
            cursor: pointer;
        }

        .AdvListChkbox {
            margin-left: 5px !important;
            cursor: pointer;
        }

        .AdvListLbl {
            cursor: pointer;
            padding: 2px 10px 0px 10px;
        }

        .MedListSepDiv {
            display: flex;
            align-items: center;
            border: 1px solid grey;
            background-color: rgb(92, 184, 92);
            margin: 5px 5px;
            border-radius: 10px;
            padding: 2px 0px;
            cursor: pointer;
            border: 1px solid rgb(74, 163, 74);
            color: white;
        }
    </style>

    <%-- Investigation -Result Entry --%>
    <style>
        .EModal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

            .EModal .modal-content {
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

        .ModelContentDiv {
            padding: 5px 0px;
        }

        .ModelLbl {
            margin: 0px;
            width: 100px;
            padding: 5px 0px 5px 10px;
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

        .fc-event-main {
            font-size: 12px !important;
        }

        .ui-dialog {
            z-index: 100000000000000000000000000000;
        }

        .ResultHeader {
            background: #043362 !important;
            border-radius: 0px;
        }

        table.tblpopupList {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            min-height: 100px;
        }

            table.tblpopupList thead {
                background: #314b81;
                color: white;
                color: white;
                font-size: 12px;
            }

            table.tblpopupList th {
                padding: 5px 15px;
                border: none;
                border: 1px solid #e6e6e6;
                text-align: center;
            }

            table.tblpopupList tbody tr {
                background-color: #f9f9f9;
                transition: background-color 0.3s;
            }

                table.tblpopupList tbody tr:nth-child(even) {
                    background-color: #f1f1f1;
                }

                table.tblpopupList tbody tr:hover {
                    background-color: #f1f1f1;
                }

            table.tblpopupList tbody td {
                padding: 5px;
                border: 1px solid #e6e6e6;
                text-align: center;
            }

        .TestTd {
            text-align: center;
            color: black;
            font-weight: bold;
            padding: 0px 5px;
            background-color: #ededed;
            border: 1px solid #c9c9c9;
        }

        .TestDateINTd {
            padding: 5px 10px !important;
        }

        .TestDateOTTd {
            padding: 5px 10px !important;
        }

        .InvstHeaderTd {
            text-align: left;
            font-weight: bold;
            padding: 2px 5px;
            background-color: #fbf9f9;
            border: 1px solid #c9c9c9;
        }

        .InvstFieldTd {
            padding: 5px 10px;
            border: 1px solid #c9c9c9;
            background-color: white;
        }

        .InfoIconPopup {
            font-size: 14px;
            margin-right: 10px;
            color: #398ebd;
            cursor: pointer;
            padding-left: 5px;
        }
    </style>

    <%-- Common --%>
    <style>
        #LblInvstNotifi {
            margin-left: 10px;
            background-color: red;
            padding: 2px;
            color: white;
            border-radius: 5px;
        }

        label {
            margin: 0px !important;
        }

        input[type="radio"], input[type="checkbox"] {
            margin: 0px;
        }

        :checked + label:before {
            content: "" !important;
        }

        :checked + label {
            border: none;
        }

        .input-form-label {
            cursor: pointer;
        }

        .MainDivHeader {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            background-color: #00930012;
            color: #363636;
            border-top: 2px solid #009300;
            margin-top: 5px !important;
        }

        .MDHeaderLbl {
            padding: 5px;
            font-size: 14px;
            font-weight: bold;
            width: 70%;
            text-align: left;
        }

        .MainDivContent {
            margin-top: 5px;
            /*display: none;*/
            font-size: 12px;
        }

        .HeaderBtnIcon {
            padding-right: 10px;
            align-items: center;
        }

        .ArrowDiv {
            width: 30%;
            text-align: right;
        }

        .DownArrow {
            padding-right: 15px;
            font-size: 20px;
        }

        .UpArrow {
            padding-right: 15px;
            font-size: 20px;
        }

        .ContentFieldDiv {
            display: flex;
            align-items: flex-start;
            padding-top: 5px;
        }

        .FieldDiv {
            display: flex;
            align-items: flex-start;
            flex-wrap: wrap;
        }

        .RadioDiv {
            display: flex;
            align-items: flex-start;
        }

        .EachRow {
            display: flex;
            flex-wrap: wrap;
            align-items: flex-start;
        }

        .RadioLbl {
            padding: 0px 20px 10px 5px;
        }

        .MeasureInd {
            border: 1px solid #cccccc;
            border-radius: 5px;
            padding: 5px;
            color: #fff;
            background-color: #31b0d5;
            border-color: #269abc;
            border-top-left-radius: 0px;
            border-bottom-left-radius: 0px;
            min-width: 60px;
            text-align: center;
            align-content: center;
        }

        .SpeciPrintIcon {
            cursor: pointer;
            color: black;
            margin-left: 10px;
            font-size: 20px;
        }

        .SpeciDelIcon {
            color: black;
            margin-left: 10px;
            font-size: 20px;
        }
    </style>

    <script>
        var MRNo = '<%=Model.MRNO %>';
        var Gaction = '<%=Model.Gaction %>';
        var TranNo = '<%=Model.TRANNO %>';
        var AllTestAdviceList = [];
        var AllResultInvstList = [];

        var PatVitalsList = [];
        var AllAdviceList = [];
        var srvcgrpname = "dblServiceHelpsrvcgrp";
        var BckAllResultInvstList = [];
        var SearchInvestigationsList = [];
        var SpecialityRefList = [];
        var SpecialityTypeList = [];
        var defaultValue = "";
        var DoctorList = '<%:Html.Raw(ViewBag.DoctorList)%>';
        var AdvicedOutsideInvstg = [];
        var CurrTestCode = "";
        var AdvicedTestId = "";
        function SetpageDirctn() {
            window.location.href = '../DoctorDesk/PatientEntry';
        }
        $(document).ready(function (e) {
            InvestigationInfoLoad();
            $('#NewInvstg').click(function () {
                OpenNewEntryPopup();
            });

            $(document).on("click", ".btnEdit", function () {
                var row = $(this).closest("tr");
                var testName = row.find("td:nth-child(2)").text().trim();
                var testCode = getTestCodeByName(testName);

                if (!testCode) return;

                OpenNewEntryPopup(testName, testCode);
            });

            $(document).on("click", ".btnDelete", function () {
                var row = $(this).closest("tr");
                var testName = row.find("td:nth-child(2)").text().trim();
                var testCode = CurrTestCode != "" ? CurrTestCode : getTestCodeByName(testName);

                if (!testCode) return;

                if (confirm("Are you sure you want to delete this test and its related rows?")) {
                    AllResultInvstList = AllResultInvstList.filter(function (x) {
                        return x.TESTCODE !== testCode;
                    });

                    AllTestAdviceList = AllTestAdviceList.filter(function (x) {
                        return x.TESTCODE !== testCode;
                    });
                    $("#tblResultInvstListBody").empty();
                    BindResultEntryList(AllResultInvstList);
                    AdviceListColorChange(AdvicedTestId);

                }
            });

            GetOutsideInvestigationResultList();
        });

        //Investigation Info Load
        function InvestigationInfoLoad() {
            BindDoctorList();
            BindPatientDtls();
            $("#InvestRpt").click(function () {
                var MRNO = $.session.get('PatMRNO');
                if (MRNO == "" || MRNO == null) {
                    $.messager.alert("Alert", "Please Select Patient");
                }
                else {
                    $.session.set('Pagefrom', "PAC");
                    var url = '../DoctorDesk/Investigation?MRNO=' + MRNO;
                    window.open(url, '_blank');
                }
            });
            document.addEventListener('click', function (event) {
                const searchInput = document.getElementById('txtSearchInvst');
                const resultsDiv = document.getElementById('DivSearchInvstList');
                if (!searchInput.contains(event.target) && !resultsDiv.contains(event.target)) {
                    resultsDiv.style.display = 'none';
                    $("#txtSearchInvst").val("");
                }
            });
            document.getElementById('txtSearchInvst').addEventListener('input', function () {
                const query = this.value.trim().toLowerCase();
                const resultsDiv = document.getElementById('DivSearchInvstList');
                resultsDiv.innerHTML = '';
                if (query.length >= 3) {
                    resultsDiv.style.display = "block";
                    const matched = SearchInvestigationsList.filter(function (item) { return item.TESTNAME.toLowerCase().includes(query); });
                    if (matched.length > 0) {
                        matched.forEach(function (item) {
                            var FilterData = AllTestAdviceList.filter(function (A) { return A.TESTCODE == item.TESTCODE && A.CHECKED == "Y"; });
                            var Check = false; var Disable = false;
                            if (FilterData.length > 0) {
                                Check = true;
                                Disable = true;
                                //Disable = FilterData[0].TRANYN == "Y" ? true : false;
                            }
                            const checkbox = document.createElement('input');
                            checkbox.className = 'TestListSearchChk';
                            checkbox.type = 'checkbox';
                            checkbox.id = 'invst_' + item.TESTCODE;
                            checkbox.checked = Check;
                            checkbox.disabled = Disable;
                            //checkbox.onclick = function () {
                            //    var Id = ("ChkAdvTest_EDITADVTEST_" + item.TESTCODE);
                            //    var Check = checkbox.checked == true ? "Y" : "N";
                            //    var FilterD = AllTestAdviceList.filter(function (A) { return A.TESTCODE == item.TESTCODE; });
                            //    const container = document.getElementById('AdviceTestListOption');
                            //    const matchingElements = Array.from(container.querySelectorAll('[id]')).filter(function (el) {
                            //        return el.id.startsWith('ChkAdvTest_') && el.id.endsWith(item.TESTCODE);
                            //    });
                            //    if (FilterD.length > 0) {
                            //        AllTestAdviceList[0].CHECKED = Check;
                            //        if (matchingElements.length == 0) {
                            //            BindTestListForAdvice(FilterD, "EDITADVTEST", true);
                            //        }
                            //    }
                            //    else {
                            //        var FList = [];
                            //        var Lst = {
                            //            CHECKED: "Y",
                            //            CODE: item.TESTCODE,
                            //            SETUPCODE: "",
                            //            TESTCODE: item.TESTCODE,
                            //            TESTNAME: item.TESTNAME,
                            //            TRANYN: "N"
                            //        };
                            //        AllTestAdviceList.push(Lst);
                            //        FList.push(Lst);
                            //        if (checkbox.checked) {
                            //            BindTestListForAdvice(FList, "EDITADVTEST", true);
                            //        }
                            //    }
                            //    //AddRemTestFromInvstList(item.TESTCODE, Check);
                            //    if (matchingElements.length > 0) {
                            //        Id = matchingElements[0].id;
                            //    }
                            //    var CheckYN = $("#" + Id).prop("checked", (Check == "Y" ? true : false));
                            //    AdviceListColorChange(Id);
                            //};
                            checkbox.onclick = function () {
                                const Id = "ChkAdvTest_EDITADVTEST_" + item.TESTCODE;
                                const Check = checkbox.checked ? "Y" : "N";
                                const existing = AllTestAdviceList.find(function (A) {
                                    return (
                                        A.TESTCODE === item.TESTCODE ||
                                        A.TESTNAME.trim().toLowerCase() === item.TESTNAME.trim().toLowerCase()
                                    );
                                });

                                if (!existing) {
                                    const Lst = {
                                        CHECKED: "Y",
                                        CODE: item.TESTCODE,
                                        SETUPCODE: "",
                                        TESTCODE: item.TESTCODE,
                                        TESTNAME: item.TESTNAME,
                                        TRANYN: "N"
                                    };

                                    AllTestAdviceList.push(Lst);
                                    if (checkbox.checked) {
                                        BindTestListForAdvice([Lst], "EDITADVTEST", true);
                                    }
                                    GetResultEntryList(item.TESTCODE);
                                    OpenResultEntryPopup();

                                } else {
                                    checkbox.checked = true;
                                }

                                const container = document.getElementById('AdviceTestListOption');
                                const matchEl = Array.from(container.querySelectorAll('[id]')).find(function (el) {
                                    return el.id.startsWith('ChkAdvTest_') && el.id.endsWith(item.TESTCODE);
                                });
                                if (matchEl) {
                                    AdviceListColorChange(matchEl.id);
                                    AdvicedTestId = matchEl.id;
                                }
                            };

                            const label = document.createElement('label');
                            label.className = 'TestListSearchLbl';
                            label.htmlFor = checkbox.id;
                            label.innerHTML = item.TESTNAME;
                            const div = document.createElement('div');
                            div.className = 'TestListSearchDiv';
                            div.appendChild(checkbox);
                            div.appendChild(label);
                            resultsDiv.appendChild(div);
                        });
                    } else {
                        resultsDiv.innerHTML = '<small>No results found.</small>';
                    }
                }
                else {
                    resultsDiv.style.display = "none";
                }
            });
            BindInvestigationInfoGaction();
        }

        //Investigation Info Gaction
        function BindInvestigationInfoGaction() {
            GetAllTest();
            if (Gaction == "N") {
                ClearInvestigationInfo();
                // GetInvestigationAdviceList();
            }
            else {
                BindInvestDtls();
                document.getElementById("AdviceList").style.display = "none";
                document.getElementById("InvstSearchList").style.display = "none";
                document.querySelectorAll('#AdviceTestListOption input, #AdviceTestListOption button').forEach(function (el) { el.disabled = true });
            }
        }

        //Get All Test List
        function GetAllTest() {
            HoldOn.open();
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetInvestigationList","DoctorDesk")%>",
                data: {},
                async: false,
                success: function (response) {
                    SearchInvestigationsList = response;
                },
                complete: function () {
                    HoldOn.close();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HoldOn.close();
                    $.messager.alert("Error", errorThrown);
                },
            });
        }

        //Clear Investigation Info
        function ClearInvestigationInfo() {
            // GetInvestigationAdviceList();
        }

        //Bind Investigation Info
        function BindInvestDtls() {
            var InvstData = '<%=Model.InvstData %>';
            var ResultData = '<%=Model.ResultInvstData %>';
            AllTestAdviceList = InvstData != "" ? JSON.parse(InvstData) : [];
            AllResultInvstList = ResultData != "" ? JSON.parse(ResultData) : [];
            BckAllResultInvstList = ResultData != "" ? JSON.parse(ResultData) : [];
            BindTestListForAdvice(AllTestAdviceList, "EDITADVTEST", true);
        }

        //Bind Advice Setup list
        function BindInvestigationAdviceList(List) {
            $("#AdviceTestListOption").empty();
            $("#AdviceListOption").empty();
            var SepDiv = '<div class="AdviListSepDiv" id="{SEPDIVID}">{DIVCONTENT}</div>';
            var CheckBox = '<input type="checkbox" id="{SEPCHKBOXID}" class="AdvListChkbox" onclick="AdviceListColorChange(this.id);AddUpdateInvstAdviceandTestList(this.id);" />';
            var CheckBoxLbl = '<label for="{SEPCHKBOXID}" class="AdvListLbl">{LABELCONTENT}</label>';
            $.grep(List, function (a) {
                var ChkId = "ChkAdv_" + a.CODE;
                var DivId = "Div" + ChkId;
                var RplCheckBox = CheckBox.replace("{SEPCHKBOXID}", ChkId);
                var RplCheckBoxLbl = CheckBoxLbl.replace("{SEPCHKBOXID}", ChkId).replace("{LABELCONTENT}", a.DESC);
                var RplSepDiv = SepDiv.replace("{SEPDIVID}", DivId).replace("{DIVCONTENT}", (RplCheckBox + RplCheckBoxLbl));
                $("#AdviceListOption").append(RplSepDiv);
            });
        }

        //Add or Update Advice and Test List
        function AddUpdateInvstAdviceandTestList(Id) {
            var SplitCode = Id.split("_");
            var CheckYN = $("#" + Id).prop("checked") == true ? "Y" : "N";
            if (Id.includes("ChkAdvTest_")) {
                var Code = SplitCode[2];
                $.grep(AllTestAdviceList, function (a) {
                    if (a.CODE == Code) {
                        a.CHECKED = CheckYN;
                        AddRemTestFromInvstList(a.TESTCODE, CheckYN);
                    }
                });
            }
            else {
                var Code = SplitCode[1];
                var FilterLst = AllTestAdviceList.filter(function (a) { return a.SETUPCODE === Code; });
                if (FilterLst.length == 0) {
                    GetTestListForAdvice(Code);
                    $.grep(AllTestAdviceList, function (a) {
                        if (a.SETUPCODE == Code) {
                            a.CHECKED = "Y";
                            GetResultEntryList(a.TESTCODE);
                        }
                    });
                }
                else {
                    var AdvCode = FilterLst[0].SETUPCODE;
                    $.grep(AllTestAdviceList, function (a) {
                        if (a.SETUPCODE == AdvCode) {
                            a.CHECKED = CheckYN;
                            var ChkId = "ChkAdvTest_" + AdvCode + "_" + a.CODE;
                            var DivId = "Div" + ChkId;
                            if (CheckYN == "N") {
                                let element = document.getElementById(DivId);
                                if (element) {
                                    element.remove();
                                }
                            }
                            else {
                                var AppendL = [];
                                AppendL.push(a);
                                BindTestListForAdvice(AppendL, AdvCode, true);
                            }
                            AddRemTestFromInvstList(a.TESTCODE, CheckYN);
                        }
                    });
                }
                $.grep(AllAdviceList, function (a) {
                    if (a.CODE == Code) {
                        a.CHECKED = CheckYN;
                    }
                });
            }
        }

        //Bind Test Code and Name For Invst From Setup Change
        function AddRemTestFromInvstList(TCode, AddYN) {
            var TList = [];
            if (AddYN == "N") {
                TList = AllResultInvstList.filter(function (a) { return a.TESTCODE != TCode; });
                AllResultInvstList = TList;
                CurrTestCode = TCode;
                $(".btnDelete").trigger('click'); // To delete test from grid too when unchecked
            }
            else {
                GetResultEntryList(TCode);
            }
        }

        //Validation For Open Result Popup
        function ValidationForResultPopup() {
            if (AllTestAdviceList.length == 0) {
                $.messager.alert("Information", "No Data Found");
                return false;
            }
            var FilterData = AllTestAdviceList.filter(function (a) { return a.CHECKED == "Y"; });
            if (FilterData.length == 0) {
                $.messager.alert("Information", "Select the Advice Test");
                return false;
            }
            return true;
        }

        //Open Result Entry Popup
        function OpenResultEntryPopup() {
            $("#tblResultInvstListBody").empty();
            if (ValidationForResultPopup() == true && AllTestAdviceList.length > 0) {
                if (AllResultInvstList.length == 0 && Gaction != "D") {
                    $.grep(AllTestAdviceList, function (a) {
                        GetResultEntryList(a.TESTCODE);
                    });
                }
                if (AllResultInvstList.length > 0) {
                    BindResultEntryList(AllResultInvstList);
                }
                else {
                    $.messager.alert("Information", "No Result Entry Data Found.");
                }
            }
        }

        //Get Result Entry
        function GetResultEntryList(Code) {
            var TestList = Code.split(',');
            var DataToSend = {
                TestCode: JSON.stringify(
                    TestList.map(function (item) {
                        return { TESTCODE: item.trim() };
                    })
                )
            };
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetOutInvestList",
                data: DataToSend,
                async: false,
                success: function (response) {
                    if (response != "" && response != "UNSUCCESSFULL") {
                        AllResultInvstList = AllResultInvstList.concat(response);
                    }
                    else {
                        $.grep(TestList, function (a) {
                            var Filt = AllTestAdviceList.filter(function (f) { return f.CHECKED == "Y" && f.TESTCODE == a; });
                            if (Filt.length > 0) {
                                var Data = {
                                    INVDATE: "",
                                    TESTCODE: Filt[0].TESTCODE,
                                    INVSETCODE: "",
                                    INVSETDESC: Filt[0].TESTNAME,
                                    RESULTTYPE: "",
                                    SEQNO: "",
                                    RESULTDT: "",
                                    INRESULTDT: ""
                                };
                                AllResultInvstList.push(Data);
                            }
                        });
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                }
            });
        }

        //Bind Advice Test List
        function BindTestListForAdvice(List, AdviceId, CheckedFlag) {
            var SepDiv = '<div class="AdviListSepDiv" id="{SEPDIVID}">{DIVCONTENT}</div>';
            var CheckBox = '<input type="checkbox" id="{SEPCHKBOXID}" class="AdvListChkbox" onclick="AdviceListColorChange(this.id);AddUpdateInvstAdviceandTestList(this.id);" {CHECKED} />';
            var CheckBoxLbl = '<label for="{SEPCHKBOXID}" class="AdvListLbl">{LABELCONTENT}</label>';
            $.grep(List, function (a) {
                var ChkId = "ChkAdvTest_" + AdviceId + "_" + a.TESTCODE;
                var DivId = "Div" + ChkId;
                var RplCheckBox = CheckBox.replace("{SEPCHKBOXID}", ChkId).replace("{CHECKED}", (CheckedFlag == true ? "checked" : ""));
                var RplCheckBoxLbl = CheckBoxLbl.replace("{SEPCHKBOXID}", ChkId).replace("{LABELCONTENT}", a.TESTNAME);
                var RplSepDiv = SepDiv.replace("{SEPDIVID}", DivId).replace("{DIVCONTENT}", (RplCheckBox + RplCheckBoxLbl));
                $("#AdviceTestListOption").append(RplSepDiv);
                if (CheckedFlag) {
                    AdviceListColorChange(ChkId);
                   // OpenResultEntryPopup();
                }
            });
        }

        //Advice List Color Change
        function AdviceListColorChange(ChkId) {
            var DivId = "Div" + ChkId;
            if ($("#" + ChkId).prop("checked") == true) {
                document.getElementById(DivId).style.backgroundColor = "rgb(92, 184, 92)";
                document.getElementById(DivId).style.border = "1px solid #4aa34a";
                document.getElementById(DivId).style.color = "white";
            }
            else {
                if (ChkId.includes("ChkAdv_")) {
                    document.getElementById(DivId).style.backgroundColor = "#d1d1d1";
                    document.getElementById(DivId).style.border = "1px solid grey";
                    document.getElementById(DivId).style.color = "black";
                }
                else {
                    var SpltId = ChkId.split('_');
                    var DivId = "DivChkAdvTest_" + SpltId[1] + "_" + SpltId[2];
                    if (document.getElementById(DivId)) {
                        document.getElementById(DivId).remove();
                    }
                }
            }
        }

        //Add or Update Advice and Test List
        function AddUpdateInvstAdviceandTestList(Id) {
            var SplitCode = Id.split("_");
            var CheckYN = $("#" + Id).prop("checked") == true ? "Y" : "N";
            if (Id.includes("ChkAdvTest_")) {
                var Code = SplitCode[2];
                $.grep(AllTestAdviceList, function (a) {
                    if (a.CODE == Code) {
                        a.CHECKED = CheckYN;
                        AddRemTestFromInvstList(a.TESTCODE, CheckYN);
                    }
                });
            }
            else {
                var Code = SplitCode[1];
                var FilterLst = AllTestAdviceList.filter(function (a) { return a.SETUPCODE === Code; });
                if (FilterLst.length == 0) {
                    GetTestListForAdvice(Code);
                    $.grep(AllTestAdviceList, function (a) {
                        if (a.SETUPCODE == Code) {
                            a.CHECKED = "Y";
                            GetResultEntryList(a.TESTCODE);
                        }
                    });
                }
                else {
                    var AdvCode = FilterLst[0].SETUPCODE;
                    $.grep(AllTestAdviceList, function (a) {
                        if (a.SETUPCODE == AdvCode) {
                            a.CHECKED = CheckYN;
                            var ChkId = "ChkAdvTest_" + AdvCode + "_" + a.CODE;
                            var DivId = "Div" + ChkId;
                            if (CheckYN == "N") {
                                let element = document.getElementById(DivId);
                                if (element) {
                                    element.remove();
                                }
                            }
                            else {
                                var AppendL = [];
                                AppendL.push(a);
                                BindTestListForAdvice(AppendL, AdvCode, true);
                            }
                            AddRemTestFromInvstList(a.TESTCODE, CheckYN);
                        }
                    });
                }
                $.grep(AllAdviceList, function (a) {
                    if (a.CODE == Code) {
                        a.CHECKED = CheckYN;
                    }
                });
            }
        }

        function BindResultEntryList(List) {
            var Tr = "<tr {DATACODE}>{TRCONTENT}</tr>";
            var Td = "<td class='{TDCLASS}' {TDCOLSPAN} {STYLE} {TDID}>{TDCONTENT}</td>";
            var InputField = "<input type='text' id='{INPUTID}' class='form-control' {READONLY}/>";
            var DatePicker = "<input type='text' id='{INPUTID}' class='form-control ResultDate' readonly {DISABLED} />";
            var InhouseFlag = List.filter(function (a) { return a.INRESULTDT != ""; });
            var TestCodeList = [];
            var TestNameList = [];

            var EditButton = "<button type='button' class='btnEdit' title='Edit' style='border:none;background:none;cursor:pointer;margin-right:5px;'>" +
                "<i class='fa fa-edit' style='color:#007bff;'></i>" + "</button>";

            var DeleteButton = "<button type='button' class='btnDelete' title='Delete' style='border:none;background:none;cursor:pointer;'>" +
                "<i class='fa fa-trash' style='color:#dc3545;'></i>" + "</button>";


            $.grep(AllTestAdviceList, function (a) {
                if (a.CHECKED == "Y") {
                    TestCodeList.push(a.TESTCODE);
                    TestNameList.push(a.TESTNAME);
                }
            });
            for (var i = 0; i < TestCodeList.length; i++) {
                var FilterTestWise = List.filter(function (a) { return a.TESTCODE == TestCodeList[i]; });

                var ActionsContent = DeleteButton;

                if (FilterTestWise.length > 0 && FilterTestWise[0].RESULTTYPE == "O") {
                    ActionsContent = EditButton + ActionsContent; 
                }
                var Actions = Td.replace("{TDCLASS}", 'InvstActionsTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:70px;text-align:center;'").replace("{TDCONTENT}", ActionsContent);
                var Actions = Td.replace("{TDCLASS}", 'InvstActionsTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:70px;text-align:center;'").replace("{TDCONTENT}", ActionsContent);
                var RplTestTd = Td.replace("{TDCLASS}", 'TestTd TestName').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", TestNameList[i]).replace("{TDID}", ("id='LBL_TEST_" + TestCodeList[i]+ "'"));
                var RplInhouseDT = DatePicker.replace("{INPUTID}", ('txt_IN_' + TestCodeList[i])).replace("{DISABLED}", "disabled");
                var RplInhouseDTTd = Td.replace("{TDCLASS}", 'TestTd TestDateINTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none;'").replace("{TDCONTENT}", RplInhouseDT);
                var OutDateDisabled = Gaction == "D" || Gaction == "V" ? "disabled" : List.filter(function (a) { return a.TESTCODE == TestCodeList[i] && a.RESULTDT.trim() != ""; }).length > 0 ? "disabled" : "";
                var RplOutSideDT = DatePicker.replace("{INPUTID}", ('txt_OT_' + TestCodeList[i])).replace("{DISABLED}", Gaction == "N" ? "" : OutDateDisabled);
                var RplOutSideDTTd = Td.replace("{TDCLASS}", 'TestTd TestDateOTTd').replace("{TDCOLSPAN}", "3").replace("{STYLE}", "").replace("{TDCONTENT}", RplOutSideDT);
                var RplTestTr = Tr.replace("{TRCONTENT}", (Actions + RplTestTd + RplInhouseDTTd + RplOutSideDTTd)).replace("{DATACODE}", ("data-testcode='" + TestCodeList[i] + "'"));
                //var RplFinalTR = Tr.replace("{TRCONTENT}", (RplTestTr));
                $("#tblResultInvstListBody").append(RplTestTr);
                var FilterTestWise = List.filter(function (a) { return a.TESTCODE == TestCodeList[i]; });
                if (FilterTestWise.length > 0) {
                    var FilterGetINDate = FilterTestWise.filter(function (a) { return a.INVDATE != ""; });
                    var FilterGetOUTDate = FilterTestWise.filter(function (a) { return a.INVINHOUSEDATE != ""; });
                    if (FilterGetINDate.length > 0) {
                        $("#" + ('txt_OT_' + TestCodeList[i])).val(FilterGetINDate[0].INVDATE);
                    }
                    if (FilterGetOUTDate.length > 0) {
                        $("#" + ('txt_IN_' + TestCodeList[i])).val(FilterGetOUTDate[0].INVINHOUSEDATE);
                    }
                    $.grep(FilterTestWise, function (a) {
                        if (a.RESULTTYPE == "H") {
                            var RplInvstHeaderTd = Td.replace("{TDCLASS}", 'InvstHeaderTd').replace("{TDCOLSPAN}", "colspan='5'").replace("{STYLE}", "").replace("{TDCONTENT}", a.INVSETDESC);
                            var RplInvstHeaderTr = Tr.replace("{TRCONTENT}", RplInvstHeaderTd).replace("{DATACODE}", ("data-testcode='" + TestCodeList[i] + "'"));
                            $("#tblResultInvstListBody").append(RplInvstHeaderTr);
                        }
                        else {
                            var ActionsContent = "";
                            var Actions = Td.replace("{TDCLASS}", 'InvstActionsTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:70px;text-align:center;'").replace("{TDCONTENT}", ActionsContent);
                            var OutSideValudeReadOnly = Gaction == "D" || Gaction == "V" ? "readonly" : (BckAllResultInvstList.filter(function (a) { return a.TESTCODE == TestCodeList[i] && a.RESULTDT.trim() != ""; }).length > 0 ? "readonly" : "");
                            var RplInvstNameTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", a.INVSETDESC).replace("{TDID}", ("id='LBL_TESTINVST_" + TestCodeList[i]+ "'"));
                            var RplInvstInhouse = InputField.replace("{INPUTID}", ("Txt_I_" + TestCodeList[i] + "_" + a.INVSETCODE)).replace("{READONLY}", "readonly").replace("{STYLE}", "style='display:none;'");
                            var RplInvstInhouseTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", (InhouseFlag.length == 0 ? "style='display:none'" : "style='display:none'")).replace("{TDCONTENT}", RplInvstInhouse);
                            var RplInvstOutside = InputField.replace("{INPUTID}", ("Txt_O_" + TestCodeList[i] + "_" + a.INVSETCODE)).replace("{READONLY}", OutSideValudeReadOnly);
                            var RplInvstOutsideTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInvstOutside);
                            var RplInvstCode = InputField.replace("{INPUTID}", ("Txt_" + TestCodeList[i] + "_" + a.INVSETCODE)).replace("{READONLY}", "");
                            var RplInvstCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", RplInvstCode);
                            var RplTestCode = InputField.replace("{INPUTID}", ("Txt_" + TestCodeList[i])).replace("{READONLY}", "");
                            var RplTestCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", RplTestCode);
                            var RplInvstFieldTr = Tr.replace("{TRCONTENT}", (Actions + RplInvstNameTd + RplInvstInhouseTd + RplInvstOutsideTd + RplInvstCodeTd + RplTestCodeTd)).replace("{DATACODE}", ("data-testcode='" + TestCodeList[i] + "'"));
                            //var RplFinalTR = "<tr data-testcode='" + TestCodeList[i] + "'>" + RplInvstFieldTr + "</tr>";
                            $("#tblResultInvstListBody").append(RplInvstFieldTr);

                            //if (a.INRESULTDT != "") {
                            //    $("#" + CSS.escape("Txt_I_" + TestCodeList[i] + "_" + a.INVSETCODE)).val(a.INRESULTDT);
                            //}
                            if (a.RESULTDT != "") {
                                $("#" + CSS.escape("Txt_O_" + TestCodeList[i] + "_" + a.INVSETCODE)).val(a.RESULTDT);
                            }
                        }
                    });
                }
                else {
                    // var Actions = Td.replace("{TDCLASS}", 'InvstActionsTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:70px;text-align:center;'").replace("{TDCONTENT}", ActionsContent);
                    // === START: CODE FOR CASES WHERE THERE ARE NO NESTED FIELDS, TREAT AS MAIN ROW ===
                    var ActionsContent = EditButton + DeleteButton; // Retain both for non-nested tests
                    var Actions = Td.replace("{TDCLASS}", 'InvstActionsTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:70px;text-align:center;'").replace("{TDCONTENT}", ActionsContent);
                    // === END: CODE FOR CASES WHERE THERE ARE NO NESTED FIELDS, TREAT AS MAIN ROW ===
                    var RplInvstNameTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", TestNameList[i]).replace("{TDID}", ("id='LBL_TEST_" + TestCodeList[i]+ "'"));
                    var RplInvstInhouse = InputField.replace("{INPUTID}", ("Txt_I_" + TestCodeList[i])).replace("{READONLY}", "readonly").replace("{STYLE}", "style='display:none;'");
                    var RplInvstInhouseTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", (InhouseFlag.length == 0 ? "style='display:none'" : "")).replace("{TDCONTENT}", RplInvstInhouse);
                    var RplInvstOutside = InputField.replace("{INPUTID}", ("Txt_O_" + TestCodeList[i])).replace("{READONLY}", "");
                    var RplInvstOutsideTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInvstOutside);
                    var RplInvstCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", "");
                    var RplTestCode = InputField.replace("{INPUTID}", ("Txt_" + TestCodeList[i])).replace("{READONLY}", "");
                    var RplTestCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", RplTestCode);
                    var RplInvstFieldTr = Tr.replace("{TRCONTENT}", (Actions + RplInvstNameTd + RplInvstInhouseTd + RplInvstOutsideTd + RplInvstCodeTd + RplTestCodeTd)).replace("{DATACODE}", ("data-testcode='" + TestNameList[i] + "'"));
                    //var RplFinalTR = "<tr data-testcode='" + TestCodeList[i] + "'>" + RplInvstFieldTr + "</tr>";
                    $("#tblResultInvstListBody").append(RplInvstFieldTr);

                    var TestADD = {
                        INVDATE: List[0].INVDATE,
                        INVINHOUSEDATE: "",
                        TESTCODE: TestCodeList[i],
                        INVSETCODE: "",
                        INVSETDESC: TestNameList[i],
                        RESULTTYPE: "V",
                        SEQNO: AllResultInvstList.length,
                        RESULTDT: "",
                        INRESULTDT: "",
                    }
                    AllResultInvstList.push(TestADD);
                }
            }
            if (InhouseFlag.length == 0) {
                document.getElementById("thInhouse").style.display = "none";
                document.querySelectorAll('.TestDateINTd').forEach(function (el) {
                    el.style.display = 'none';
                });
            }
            $(".ResultDate").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });
        }

        function ValidationForResultEntryDtls() {
            return true;
        }

        function UpdateResultList(DivId) {
            if (DivId == "ReventModal") {
                if (ValidationForResultEntryDtls() == true) {
                    $.grep(AllResultInvstList, function (a) {
                        a.INVDATE = $("#" + ('txt_OT_' + a.TESTCODE)).val();
                        if (a.RESULTTYPE == "H") {
                            a.RESULTDT = "";
                        }
                        else {
                            var Id = "Txt_O_" + a.TESTCODE + "_" + a.INVSETCODE;
                            var InputField = document.getElementById(Id);
                            if (InputField != null) {
                                a.RESULTDT = $("#" + CSS.escape(Id)).val();
                            }
                            else {
                                Id = "Txt_O_" + a.TESTCODE;
                                InputField = document.getElementById(Id);
                                if (InputField != null) {
                                    a.RESULTDT = $("#" + CSS.escape(Id)).val();
                                }
                                else {
                                    a.RESULTDT = "";
                                }
                            }
                        }
                    });
                }
            }
            else if (DivId == "NewInvstgModal") {
                var newTestName = $("#txtNewTestName").val().trim();
                if (newTestName == "") {
                    alert("Please enter a test name.");
                    return;
                }
                var InvstFilter = AllResultInvstList.filter(function (a) { return a.INVSETDESC.trim() == newTestName; });
                if (InvstFilter.length > 0) {
                    alert("Already test name are present.");
                    return;
                }
                var existingCode = $("#txtNewTestName").attr("data-editcode");

                if (existingCode) {
                    AllTestAdviceList.forEach(function (x) {
                        if (x.TESTCODE === existingCode) { x.TESTNAME = newTestName; }
                    });

                    AllResultInvstList.forEach(function (x) {
                        if (x.TESTCODE === existingCode) {
                            x.INVSETDESC = newTestName;
                        }
                    });

                    if(document.getElementById("LBL_TEST_" + existingCode)){
                        document.getElementById("LBL_TEST_" + existingCode).innerText = newTestName;
                    }
                    if(document.getElementById("LBL_TESTINVST_" + existingCode)){
                        document.getElementById("LBL_TESTINVST_" + existingCode).innerText = newTestName;
                    }
                } else {
                    var newTestCode = "T" + (AllResultInvstList.length + 1);
                    var newTest = {
                        INVDATE: "",
                        INVINHOUSEDATE: "",
                        TESTCODE: newTestCode,
                        INVSETCODE: "",
                        INVSETDESC: newTestName,
                        RESULTTYPE: "O",
                        SEQNO: AllResultInvstList.length,
                        RESULTDT: "",
                        INRESULTDT: ""
                    };
        
                    AllResultInvstList.push(newTest);
                    AllTestAdviceList.push({
                        CODE: newTestCode,
                        TESTCODE: newTestCode,
                        TESTNAME: newTestName,
                        CHECKED: "Y"
                    });
        
                    AppendNewResultRow(newTestCode, newTestName);
                }
                document.getElementById("NewInvstgModal").style.display = "none";
                document.documentElement.style.overflow = '';
            }
        }

        function decodeHtmlEntities(str) {
            var txt = document.createElement("textarea");
            txt.innerHTML = str;
            return txt.value;
        }

        function getTestCodeByName(name) {
            var normalizedName = name.replace(/\s+/g, ' ').trim();
            var found = null;
            for (var i = 0; i < AllTestAdviceList.length; i++) {
                var decodedTestName = decodeHtmlEntities(AllTestAdviceList[i].TESTNAME).replace(/\s+/g, ' ').trim();

                if (decodedTestName === normalizedName) {
                    found = AllTestAdviceList[i];
                    break;
                }
            }
            return found ? found.CODE : null;
        }

        // Open modal for Add/Edit
        function OpenNewEntryPopup(existingName, existingCode) {
            if (typeof existingName === "undefined") existingName = "";
            if (typeof existingCode === "undefined") existingCode = "";

            //$("#tblResultInvstListBody2").empty();
            BindNewEntryList(existingName);

            if (existingCode !== "") {
                $("#txtNewTestName").attr("data-editcode", existingCode);
                $("#NewInvstgModal .ModelHeaderDiv label").text("Edit Investigation Name");
                $("#NewInvstgModal input[value='Ok']").val("Update");
            } else {
                $("#txtNewTestName").removeAttr("data-editcode");
                $("#NewInvstgModal .ModelHeaderDiv label").text("Add New Investigation");
                $("#NewInvstgModal input[value='Update']").val("Ok");
            }

            $("#NewInvstgModal").fadeIn(200).css("display", "flex");
        }

        // Bind the input field inside modal
        function BindNewEntryList(value) {
            if (typeof value === "undefined") value = "";
            $("#txtNewTestName").val(value)
            //if (value !== "") {
            //    var tr = "<tr><td><input type='text' id='txtNewTestName' value='" + value + "' class='form-control' style='width:100%; padding:6px; font-size:13px;' placeholder='Enter test name' /></td></tr>";
            //    $("#tblResultInvstListBody2").append(tr);
            //} else {
            //    var tr = "<tr><td><input type='text' id='txtNewTestName' value='" + "' class='form-control' style='width:100%; padding:6px; font-size:13px;' placeholder='Enter test name' /></td></tr>";
            //    $("#tblResultInvstListBody2").append(tr);
            //}
        }

        // Close Popup
        function ClosePop(DivId) {
            $("#" + DivId).fadeOut(150);
            document.documentElement.style.overflow = '';
        }
        function SaveForInvestInfo(PostData) {
            const parentDiv = document.getElementById("AdviceTestListOption");
            const childDivs = parentDiv.querySelectorAll("div");
            var FilterData = [];

            for (var i = 0; i < childDivs.length; i++) {
                var id = childDivs[i].id;
                if (id) {
                    var IdSplit = id.split('_');
                    var SetupCode = IdSplit[1];
                    var TestCode = IdSplit[2];
                    var SelY = AllTestAdviceList.filter(function (a) {
                        return a.CHECKED == "Y" && a.CODE === TestCode && a.SETUPCODE === SetupCode && a.TRANYN == "N";
                    });
                    if (Gaction != "N") {
                        SelY = AllTestAdviceList.filter(function (a) {
                            return a.CHECKED == "Y" && a.TESTCODE === TestCode && a.TRANYN == "N";
                        });
                    }
                    if (SelY.length > 0) {
                        var PushData = {
                            SEQNO: (FilterData.length + 1),
                            TESTCODE: TestCode,
                            TESTNAME: SelY[0].TESTNAME.trim()
                        };
                        FilterData.push(PushData);
                    }
                }
            }

            var FilterResult = [];
            $.grep(AllResultInvstList, function (a) {
                if (a.RESULTTYPE != "H") {
                    var Id = "Txt_O_" + a.TESTCODE + "_" + a.INVSETCODE;
                    var InputField = document.getElementById(Id);

                    if (InputField != null) {
                        a.RESULTDT = $("#" + CSS.escape(Id)).val();
                    } else {
                        Id = "Txt_O_" + a.TESTCODE;
                        InputField = document.getElementById(Id);
                        a.RESULTDT = (InputField != null) ? $("#" + CSS.escape(Id)).val() : "";
                    }

                    if (a.RESULTDT != "") {
                        var alreadyExists = FilterResult.some(function (x) {
                            return x.TESTCODE === a.TESTCODE && x.INVSETCODE === a.INVSETCODE;
                        });

                        if (!alreadyExists) {
                            var TestNameList = AllTestAdviceList.filter(function (c) {
                                return c.TESTCODE == a.TESTCODE;
                            });
                            a.TESTNAME = TestNameList.length > 0 ? TestNameList[0].TESTNAME : "";

                            if (!a.INVDATE || a.INVDATE == "") {
                                a.INVDATE = $("#" + ('txt_OT_' + a.TESTCODE)).val() || "";
                            }

                            FilterResult.push(a);
                        }
                    }
                }
            });

            for (var i = 0; i < FilterResult.length; i++) {
                delete FilterResult[i].INRESULTDT;
            }

            PostData.push({ name: 'ResultInvstData', value: JSON.stringify(FilterResult) });
            return PostData;
        }


        //Bind Patient Details
        function BindPatientDtls() {
            if ($.session.get('PatMRNO') != undefined && $.session.get('PatMRNO') != "") {
                $("#txtPACMRNO").val($.session.get('PatMRNO'));
                $("#txtPACPatName").val($.session.get('PatName'));
                $("#txtPACPatAge").val($.session.get('PatAge'));
                $("#txtPACPatGen").val($.session.get('PatGender'));
            }
        }

        function SaveOutSideInvstg() {
            var PostData = new Array();
            var mrno = ""; var tranno = "";
            mrno = $.session.get('PatMRNO');
            tranno = $.session.get('PatTRANNO');
            PostData.push({ name: 'MRNO', value: mrno });
            PostData.push({ name: 'TRANNO', value: tranno });
            PostData.push({ name: 'Gaction', value: Gaction });

            SaveForInvestInfo(PostData);
            $.ajax({
                url: '../DoctorDesk/SaveOutsideInvstg',
                data: PostData,
                type: 'post',
                async: false,
                success: function (response) {
                    if (response.toUpperCase().includes("SUCCESS")) {
                        $.messager.confirm("Confirmation", response, function (result) {
                            window.location.href = '../DoctorDesk/PatientEntry';
                        });
                        $(".ui-dialog-titlebar-close").hide();
                        $('.ui-dialog-buttonset button').each(function () {
                            if ($(this).text().trim() === 'Cancel') {
                                $(this).hide();
                            }
                        });
                    }
                    else {
                        $.messager.alert("Information", response);
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                }
            })
        }

        function BindDoctorList() {
            var DoctorListData = JSON.parse(DoctorList);
            $("#cmbDoctList").select2();
            $("#cmbDoctList").empty();
            var Option = '<option value="{Value}">{TEXT}</option>';
            var DefaultOption = '<option value="">---All---</option>';
            $("#cmbDoctList").append(DefaultOption);
            for (var i = 0 ; i < DoctorListData.length; i++) {
                var Doctor = Option.replace("{Value}", DoctorListData[i].CODE).replace("{TEXT}", DoctorListData[i].NAME);
                $("#cmbDoctList").append(Doctor);
            }
        }

        function saveCurrentInputs() {
            var savedData = {};
            $("#tblResultInvstListBody input").each(function () {
                savedData[this.id] = $(this).val();
            });
            return savedData;
        }

        function restoreInputs(savedData) {
            for (var id in savedData) {
                if (document.getElementById(id)) {
                    $("#" + CSS.escape(id)).val(savedData[id]);
                }
            }
        }

        function GetOutsideInvestigationResultList() {
            var TranNo = $.session.get('PatTRANNO');
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/GetOutsideInvestigationResult",
                data: { strTranNo: TranNo },
                async: false,
                success: function (response) {
                    AdvicedOutsideInvstg = [];
                    console.log("Response:", response);
                    if (response && response !== "[]") {
                        AllResultInvstList = JSON.parse(response);

                        var uniqueTestsMap = new Map();
                        AllResultInvstList.forEach(function (a) {
                            if (!uniqueTestsMap.has(a.TESTCODE)) {
                                uniqueTestsMap.set(a.TESTCODE, {
                                    CODE: a.TESTCODE,
                                    TESTCODE: a.TESTCODE,
                                    TESTNAME: a.TESTNAME.replace(/&nbsp;&nbsp\[.*?\]&nbsp;&nbsp$/, ''),
                                    CHECKED: "Y"
                                });
                            }
                        });

                        AllTestAdviceList = Array.from(uniqueTestsMap.values());
                        var distinctAdvices = [];
                        var distinctCodes = new Set();
                        AllResultInvstList.forEach(function (a) {
                            if (!distinctCodes.has(a.TESTCODE)) {
                                distinctCodes.add(a.TESTCODE);
                                distinctAdvices.push({
                                    CODE: a.TESTCODE,
                                    DESC: a.TESTNAME.replace(/&nbsp;&nbsp\[.*?\]&nbsp;&nbsp$/, '')
                                });
                            }
                        });
                        BindInvestigationAdviceList(distinctAdvices);
                        BindResultEntryList(AllResultInvstList);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.messager.alert("Error", errorThrown);
                },
                complete: function () {
                    HoldOn.close();
                }
            });
        }

        // New function to append a single new row
        function AppendNewResultRow(testCode, testName) {
            // Replicate template variables from BindResultEntryList if they are not global
            // If they are local to BindResultEntryList, you must define them here or make them global.
            // Assuming you move the template variables outside of BindResultEntryList:
            var Tr = "<tr {DATACODE}>{TRCONTENT}</tr>";
            var Td = "<td class='{TDCLASS}' {TDCOLSPAN} {STYLE} {TDID}>{TDCONTENT}</td>";
            var InputField = "<input type='text' id='{INPUTID}' class='form-control' {READONLY} />";
            var DatePicker = "<input type='text' id='{INPUTID}' class='form-control ResultDate' readonly {DISABLED} />";
            var EditButton = "<button type='button' class='btnEdit' title='Edit' style='border:none;background:none;cursor:pointer;margin-right:5px;'>" +
                "<i class='fa fa-edit' style='color:#007bff;'></i>" + "</button>";
            var DeleteButton = "<button type='button' class='btnDelete' title='Delete' style='border:none;background:none;cursor:pointer;'>" +
                "<i class='fa fa-trash' style='color:#dc3545;'></i>" + "</button>";

            // Build the Action/Name/Date row for the new test
            var ActionsContent = EditButton + DeleteButton;
            var Actions = Td.replace("{TDCLASS}", 'InvstActionsTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='width:70px;text-align:center;'").replace("{TDCONTENT}", ActionsContent);
            var RplTestTd = Td.replace("{TDCLASS}", 'TestTd TestName').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", testName).replace("{TDID}", ("id ='LBL_TEST_" + testCode + "'"));
            var RplInhouseDTTd = Td.replace("{TDCLASS}", 'TestTd TestDateINTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none;'").replace("{TDCONTENT}", DatePicker.replace("{INPUTID}", ('txt_IN_' + testCode)).replace("{DISABLED}", "disabled"));
            var RplOutSideDT = DatePicker.replace("{INPUTID}", ('txt_OT_' + testCode)).replace("{DISABLED}", "");
            var RplOutSideDTTd = Td.replace("{TDCLASS}", 'TestTd TestDateOTTd').replace("{TDCOLSPAN}", "3").replace("{STYLE}", "").replace("{TDCONTENT}", RplOutSideDT);
            var RplTestTr = Tr.replace("{TRCONTENT}", (Actions + RplTestTd + RplInhouseDTTd + RplOutSideDTTd)).replace("{DATACODE}", ("data-testcode='" + testCode + "'"));
            //var RplFinalTestTR = Tr.replace("{TRCONTENT}", (RplTestTr));
            $("#tblResultInvstListBody").append(RplTestTr);
            // Build the value row for the new test (Since it's a simple 'V' type, it only has one result field)
            var OutSideValudeReadOnly = Gaction == "D" || Gaction == "V" ? "readonly" : "";
            var RplInvstNameTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", testName).replace("{TDID}", ("id ='LBL_TESTINVST_" + testCode + "'"));
            var RplInvstInhouseTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", InputField.replace("{INPUTID}", ("Txt_I_" + testCode)).replace("{READONLY}", "readonly"));
            var RplInvstOutside = InputField.replace("{INPUTID}", ("Txt_O_" + testCode)).replace("{READONLY}", OutSideValudeReadOnly);
            var RplInvstOutsideTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "").replace("{TDCONTENT}", RplInvstOutside);
            var RplInvstCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", "");
            var RplTestCodeTd = Td.replace("{TDCLASS}", 'InvstFieldTd').replace("{TDCOLSPAN}", "").replace("{STYLE}", "style='display:none'").replace("{TDCONTENT}", InputField.replace("{INPUTID}", ("Txt_" + testCode)).replace("{READONLY}", ""));
            var RplInvstFieldTr = Tr.replace("{TRCONTENT}", (Actions + RplInvstNameTd + RplInvstInhouseTd + RplInvstOutsideTd + RplInvstCodeTd + RplTestCodeTd)).replace("{DATACODE}", ("data-testcode='" + testCode + "'"));
            //var RplFinalFieldTR = "<tr data-testcode='" + testCode + "'>" + RplInvstFieldTr + "</tr>";
    
            // Append both the header and value rows
            $("#tblResultInvstListBody").append(RplInvstFieldTr);
            ///$("#tblResultInvstListBody").append(RplFinalFieldTR);

            // Initialize datepicker on the new date field
            $("#" + ('txt_OT_' + testCode)).datepicker({
                showButtonPanel: true,
                changeMonth: true,
                yearRange: "c-150:c+99",
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date(),
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display: flex; justify-content: space-between; align-items: center; margin: 10px 0;">
        <!-- Back Button (Left) -->
        <a class="button1 button1-green" id="divForBack" onclick="SetpageDirctn()">
            <i class="fa fa-arrow-left"></i>Back
        </a>

        <div class="tab-container">
        </div>
    </div>
    <div id="MainDivINVST">
        <div class="MainDivHeader row">
            <label class="MDHeaderLbl" onclick="TriggerToggleDiv('INVSTUp', 'INVSTDown', 'DivContentINVST')">Investigations</label>
            <div class="ArrowDiv" style="display: none; justify-content: flex-end; align-items: center;">
                <button type="button" class="btn btn-success" style="margin-left: 20px; padding: 3px 10px; margin-right: 10px;" id="BtnResultInvst" onclick="OpenResultEntryPopup()">Result</button>
                <i class="fa fa-chevron-circle-down DownArrow" id="INVSTDown" onclick="ToggleDiv(this.id,'INVSTUp','DivContentINVST','Y')" style="" aria-hidden="true"></i>
                <i class="fa fa-chevron-circle-up UpArrow" id="INVSTUp" onclick="ToggleDiv(this.id,'INVSTDown','DivContentINVST','N')" aria-hidden="true"></i>
            </div>
        </div>
        <div class="MainDivContent" id="DivContentINVST">
            <div class="row EachRow">
                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                    <div class="ContentFieldDiv">
                        <div class="col-xs-12 FieldDiv" id="InvstSearchList">
                            <fieldset class="InvstFieldSet">
                                <legend class="InvstFieldSetLegend">Investigation</legend>
                                <input type="text" maxlength="100" id="txtSearchInvst" placeholder="Search Investigation" class="form-control" />
                                <div id="DivSearchInvstList" style="max-width: 100%; display: none; margin-top: 0px; z-index: 100000; position: absolute; background-color: #fbfbfb; border: 1px solid black; padding: 0px 5px;"></div>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;display:none;">
                    <div class="ContentFieldDiv">
                        <div class="col-xs-12 FieldDiv" id="AdviceTestList">
                            <fieldset class="InvstFieldSet">
                                <legend class="InvstFieldSetLegend">Test Advice List</legend>
                                <div class="AdviListMainDiv" id="AdviceTestListOption">
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- Investigation Result Entry --%>
        <div class="col-xs-12 FieldDiv" id="ReventModal" style="display: block;">
            <div class="row EachRow">
                <div class="col-xs-12" style="padding: 0px 0px 5px 0px;">
                    <fieldset class="InvstFieldSet">
                        <legend class="InvstFieldSetLegend">Result Entry</legend>
                    </fieldset>
                </div>
                <div class="col-xs-12">
                    <div style="-webkit-box-shadow: 0px 1px 2px 0px #878888; overflow: auto; margin: 10px 10px;">
                        <div class="Tablewrapper" style="font-size: 12px; background: white;">
                            <table id="tblResultInvstList" class="tblpopupList">
                                <thead>
                                    <tr>
                                        <th id="NewInvstg" title="Add Outside Investigations"><i class="fa fa-plus"></i></th>
                                        <th style="width: 45%;">Name</th>
                                        <th id="thInhouse" style="display: none;">Inhouse</th>
                                        <th>Outside</th>
                                        <th style="min-width: 150px; display: none">Investion Code</th>
                                        <th style="min-width: 150px; display: none">Test Code</th>
                                    </tr>
                                </thead>
                                <tbody id="tblResultInvstListBody"></tbody>
                            </table>
                        </div>
                    </div>
                    <div style="display: flex; align-items: center; justify-content: center; margin: 10px 0px;">
                        <%--<input type="button" onclick="UpdateResultList('ReventModal')" class="" style="width: 100px; font-size: 13px; text-align: center; display: block; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" value="Ok">--%>
                        <input type="button" onclick="SaveOutSideInvstg();" class="" style="width: 100px; font-size: 13px; text-align: center; display: block; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" value="Save">
                    </div>
                </div>
            </div>
        </div>

        <%-- Add new Investigation --%>
        <div id="NewInvstgModal" class="EModal" style="justify-content: center; align-items: center;">
            <div class="modal-content" style="width: 450px;">
                <div class="ModelHeaderDiv ResultHeader">
                    <label>Add New Investigation</label>
                    <span class="closeMdlBtn" id="closeModalBtn2" onclick="ClosePop('NewInvstgModal');">&times;</span>
                </div>
                <div class="ModelContentDiv">
                    <div style="overflow: auto; margin: 10px 5px;">
                        <label style="font-size: 13px;padding-bottom: 5px;">Name</label>
                        <input type='text' id='txtNewTestName'class='form-control' style='width:100%; padding:6px; font-size:13px;' placeholder='Enter test name' />
<%--                    <div class="Tablewrapper" style="font-size: 12px; background: white;">
                            <table id="tblResultInvstList2" class="tblpopupList">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                    </tr>
                                </thead>
                                <tbody id="tblResultInvstListBody2"></tbody>
                            </table>
                        </div>--%>
                    </div>
                    <div style="display: flex; align-items: center; justify-content: center; margin: 10px 0px;">
                        <input type="button" onclick="UpdateResultList('NewInvstgModal');" class="" style="width: 100px; font-size: 13px; text-align: center; display: block; cursor: pointer; color: white !important; background-color: #008bce; border-radius: 5px; background-position-x: 6px; border: 1px; border-radius: 5px; background-position-y: 2px; padding-top: 3px; padding-bottom: 3px;" value="Ok">
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
