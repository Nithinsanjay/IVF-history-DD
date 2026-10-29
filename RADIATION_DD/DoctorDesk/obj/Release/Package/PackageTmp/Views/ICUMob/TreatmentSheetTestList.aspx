<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TreatmentSheet>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12" id="DivMedicinList">
        <div class="StuckInput" style="margin-top: -11px;">
            <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Go to top">
                <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
            </label>
            <input type="text" id="InvestigationInput" onkeyup="SearchInvestigation()" placeholder="&#xF002; Search Test" style="width: 90%; border-radius: 5px; margin-top: -2px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); position: fixed;"
                class="empty">
        </div>
        <label id="FillButton" style="background-color: transparent; float: right; margin-right: 95px; border-color: transparent;" title="Go to top">
            <button type="button" class="btn bg-olive margin" style="float: right; bottom: 0px; margin-bottom: 573px; position: fixed; padding: 2px 12px; font-size: 11px" onclick="refillMedicine()">ReFill Test</button>
        </label>

        <label id="btnSave" style="background-color: transparent; float: right; margin-right: 25px; border-color: transparent;" title="Go to top">
            <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
        </label>

        <div id="wrapper" style="overflow: hidden; width: 100%; margin-left: 15px;">
            <div class="tableDiv" style="padding-top: 13px;">
                <table id="tblinvestigate" class="table" style="width: 100%">
                    <tbody></tbody>
                </table>
            </div>
        </div>

    </div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <style>
        .RegisteredClass {
            background-color: #f1fff8;
            font-weight: bold !important;
            font-size: 12px;
            color: #077107 !important;
        }

        input.empty {
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-decoration: inherit;
        }

        .hide {
            display: none !important;
        }

        .SearchDiv .Date {
            width: 90px !important;
        }

        .SearchDiv input {
            margin-top: 2px;
        }

        .required label:after {
            color: red;
            content: '*';
        }

        .dropdownInvestTime {
            -webkit-appearance: none;
            -moz-appearance: none;
            text-indent: 1px;
            width: 60px;
            background-color: #a9fbad;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 26px;
            outline: 0;
        }
    </style>
      <script src="../Scripts/PatList.js"></script>
    <script type="text/javascript">
        var idOfDMY = "";
        var splitpatname = $.session.get('PatName');
        var patsplival = splitpatname.toString().split('.');
        var TransNo = $.session.get('PatTRANNO');
        var IsRollover = 'N';
        var strIPNo = '108'; //$.session.get('ICUPatIPNO')
        var CheckRemoveDrop = false;
        var resultInvtG = '';
        $(document).ready(function (e) {
            GetNursStationsNPAtients();
            SetPatientDtl();

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

            }

            getTreatmentSheetTestData();
            
            $('#InvestigationInput').on('keyup', function () {
                var input = $(this);
                if (input.val().length === 0) {
                    input.addClass('empty');
                } else {
                    input.removeClass('empty');
                }
            });

           

            $("#btnSave").click(function () {
                SaveInvestigations();
            });


        });

        function GetMedicineByDataBase() {
            $.ajax({
                type: "POST",
                url: "<%=Url.Action("GetInvetiLst","ICUMob")%>",
                    data: { searchstring: $("#InvestigationInput").val() },
                    success: function (result) {
                        if (result != "Unsuccessful") {
                            var rows = "";
                            // $('#tblinvestigate tbody').empty();
                            $.each(result.rows, function (i, item) {
                                var rows = "<tr class='clickable-row' id='" + item.CODE + "'>" + "<td style='padding:5px; font-size: 14px;' onclick='SelectProcess(this)'>" + item.NAME + "</td>" +
                                    "<td class='InDate'><span style='display:none'>Time:</span><select id='Time" + item.CODE + "' class='dropdownInvestTime' style='display:none'></select></td>" +
                                "</tr>";
                                $('#tblinvestigate tbody').append(rows);
                            });
                        }
                    },
                    complete: function () {
                        //   SetDataForInvestigation();
                        GetTranslstData();
                        if (resultInvtG != 'Unsucessfull') {
                            SetTretSheetDropdownData(resultInvtG);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $.loader.close();
                        $.messager.alert("Error", errorThrown);
                    }
                });
            }
            function GetTranslstData() {
                $('.dropdownInvestTime').find('option').remove();
                var Url = "<%=Url.Action("GetTestTimingList","ICUMob")%>";
                var s;
                $.ajax({
                    url: Url,
                    type: 'get',
                    async: false,
                    success: function (data) {
                        var sel = $('.dropdownInvestTime')
                        sel.append($("<option>").attr('value', '').text('----Select----'));
                        $(data).each(function (index, value) {
                            sel.append($("<option>").attr('value', this.Value).text(this.Text));
                        });
                    },

                });
                return s;
            }



            function callMe(obj) {
                var currid = $(obj).attr('id');
                var m = $('#tblinvestigate tbody tr.clickable-row.CN');
                $.each(m, function (i, p) {
                    var ids = $(p).attr('id');
                    if (ids != currid) {
                        $(p).remove();
                    }

                });
                console.log(m);
            }
            function SetText(str) {

                $("#" + idOfDMY).text(str);
            }




            function SelectProcess(obj) {
                var CurrenTr = $(obj).parent('tr');
                $(CurrenTr).toggleClass('active');
                if ($(CurrenTr).hasClass('active')) {
                    $("#tblinvestigate tbody").prepend($(CurrenTr)).closest('tr');
                    $(CurrenTr).children('td').children('select').show();
                    $(CurrenTr).children('td').children('span').show();
                    $(CurrenTr).children('td').children('span').css('display', 'inherit');
                }
                else {
                    $(CurrenTr).children('td').children('select').hide();
                    $(CurrenTr).children('td').children('span').hide();
                }

                var activerow = $('#tblinvestigate tbody  tr.active').get();

                $.each(activerow, function (index, row) {
                    $('#tblinvestigate').children('tbody').prepend(row);
                });

                var rows = $('#tblinvestigate tbody  tr:not(.active)').get();


                rows.sort(function (a, b) {

                    var A = $(a).children('td').eq(0).text().toUpperCase();
                    var B = $(b).children('td').eq(0).text().toUpperCase();

                    if (A < B) {
                        return -1;
                    }

                    if (A > B) {
                        return 1;
                    }

                    return 0;
                });

                $.each(rows, function (index, row) {
                    $('#tblinvestigate').children('tbody').append(row);
                });             //sorted unselected rows

            }

            function SearchInvestigation() {
                // Declare variables 
                var input, filter, table, tr, td, i, search = '';
                var search = false;
                input = document.getElementById("InvestigationInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("tblinvestigate");
                tr = table.getElementsByTagName("tr");

                // Loop through all table rows, and hide those who don't match the search query
                for (i = 0; i < tr.length; i++) {
                    $(tr[i]).removeClass('display');
                    td = tr[i].getElementsByTagName("td")[0];
                    if (td) {
                        if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                            if (!$(tr[i]).hasClass('display')) {
                                $(tr[i]).addClass('display')
                            }

                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }

                search = $(tr).hasClass('display');
                if (search) {
                    console.log('data present');
                }
                else {
                    GetMedicineByDataBase();
                }

            }



            function SaveInvestigations() {
                var mrno = $.session.get('PatMRNO');
                var tranNo = TransNo;
                var IPno = '108'
                var investArr = [];
                var rows = $('#tblinvestigate > tbody > tr.active').get();
                //if (rows.length > 0) {
                for (var i = 0; i < rows.length; i++) {
                    var testcode = rows[i].id
                    var testname = rows[i].cells[0].innerText;
                    var durType = rows[i].cells[1].children[1].value == '----Select----' ? "" : rows[i].cells[1].children[1].value;
                    var a = {
                        TESTCODE: testcode,
                        TESTNAME: testname,
                        TESTPRIORITY: durType,
                        ORDERDATE: '',
                        ORDERTIME: '',
                    };
                    investArr.push(a);
                }

                $.ajax({
                    type: "POST",
                    url: 'SaveTreatsheetTestData',
                    datatype: "json",
                    data: { strtableTestData: JSON.stringify(investArr), strMRNO: mrno, strIpNo: IPno, strTranNo: tranNo, stringPatName: patsplival[1] },
                    success: function (result) {
                        if (result.indexOf('Successful') >= 0) {
                            var splitval = result.toString().split(':');
                            var TranNumb = splitval[1].toString().trim();
                            if (TranNumb.length > 0) {
                                $.session.set('PatTRANNO', TranNumb);
                            }
                        }
                        window.location.href = 'TreatmentSheet?TreatsheetType=IG';
                    },
                });
            }

            function getTreatmentSheetTestData() {
               
                var DataToSend = {
                    strTranNo: TransNo,
                    strRollOverYN: IsRollover,
                    strIPNO: strIPNo,
                    strType: 'T',
                    TableTypeCode: 'IG'
                };
                $.ajax({
                    type: "get",
                    url: "GetMedicineTretSheetList", //For all Retrive have same function name in controller in respective of type (take GetMedicineTretSheetList)
                    data: DataToSend,
                    async: false,
                    success: function (response) {
                        if (response != 'Unsucessfull') {
                            resultInvtG = JSON.parse(response)
                            var rows = "";
                            $('#tblinvestigate tbody').empty();
                            $.each(resultInvtG.Table, function (i, item) {
                                var rows = "<tr class='clickable-row active TS' id='" + item.TESTCODE + "'>" + "<td style='padding:5px; font-size: 14px;' onclick='SelectProcess(this)'>" + item.TESTNAME + "</td>" +
                                    "<td class='InDate'><span style='display:none'>Time:</span><select id='Time" + item.TESTCODE + "' class='dropdownInvestTime' style='display:block'></select></td>" +
                                "</tr>";
                                $('#tblinvestigate tbody').append(rows);
                            });
                        }
                        else
                        {
                            resultInvtG = response;
                        }
                    }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                        // $.loader.close();
                        $.messager.alert("Error", errorThrown);
                    },

                    complete: function () {
                        GetTranslstData();
                        if (resultInvtG != 'Unsucessfull')
                        {
                            SetTretSheetDropdownData(resultInvtG);
                        }
                    },
                });
            }


            function SetTretSheetDropdownData(resultInvtG) {

                for (i = 0; i < resultInvtG.Table.length; i++) {
                    $('#Time' + resultInvtG.Table[i].TESTCODE).val(resultInvtG.Table[i].TESTPRIORITY)
                }

            }

            function refillMedicine() {
                var strTran = ($.session.get('PatTRANNO'))
                var Mrno = ($.session.get('PatMRNO'));
                var RefillResult;
                $.confirm({
                    title: 'Medicine Fill Confirmation',
                    content: 'Are you sure want to use last verified referral Doctor ?',
                    buttons: {
                        confirm: function () {
                            $.ajax({
                                type: "POST",
                                url: "<%=Url.Action("TSRefillMedicine","ICUMOB")%>",
                            data: { strTranNO: strTran, strMRNo: Mrno, strTYEPCode: 'T', strIPNo: strIPNo, strPatName: patsplival[1] },
                            async: false,
                            success: function (response) {
                                RefillResult = response

                            }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                $.loader.close();
                                $.messager.alert("Error", errorThrown);
                            },

                            complete: function () {
                                if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                    var splitval = RefillResult.toString().split(':');
                                    var TranNumb = splitval[1].toString().trim();
                                    if (TranNumb.length > 0) {
                                        $.session.set('PatTRANNO', TranNumb);
                                        window.location.href = 'TreatmentSheetList?TreatsheetType=' + strTypecode;
                                    }

                                }

                                else {
                                    $.alert('No medicine present to refill for current transaction');
                                }
                            },
                        });
                    },
                    cancel: function () {
                        //$.alert('Canceled!');
                    },
                }
            });
        }
    </script>

</asp:Content>
