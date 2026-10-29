<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TreatmentSheet>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12" id="DivMedicinList">
        <div class="StuckInput" style="margin-top: -11px;">
            <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Go to top">
                <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
            </label>
            <input type="text" id="DoctorInput" onkeyup="SearchDoctor()" placeholder="&#xF002; Search Test" style="width: 90%; border-radius: 5px; margin-top: -2px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); height: 28px; position: fixed;"
                class="empty">
        </div>
        <label id="FillButton" style="background-color: transparent; float: right; margin-right: 95px; border-color: transparent;" title="Go to top">
            <button type="button" class="btn bg-olive margin" style="float: right; bottom: 0px; margin-bottom: 573px; position: fixed; padding: 2px 12px; font-size: 11px" onclick="refillMedicine()">Refill Doc. list</button>
        </label>

        <label id="btnSave" style="background-color: transparent; float: right; margin-right: 25px; border-color: transparent;" title="Go to top">
            <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
        </label>

        <div id="wrapper" style="overflow: hidden; width: 100%; margin-left: 15px;">
            <div class="tableDiv" style="padding-top: 13px;">
                <table id="tblDoctor" class="table" style="width: 100%">
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

    <script type="text/javascript">


        var strMRNo = $.session.get('PatMRNO');
        var strIPNo = '108';//$.session.get('ICUPatIPNO')
        var TransNo =  $.session.get('PatTRANNO');
        var IsRollover = 'N';
        var MdecinTypeFilter = 'M'
        var splitpatname = $.session.get('PatName');
        var patsplival = splitpatname.toString().split('.');

        $(document).ready(function (e) {
            GetNursStationsNPAtients();
            SetPatientDtl();


            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

            }
            GetDoctorList();

            for (var i = 0; i <= 30; i++) {
                var s = "<a href='javascript:;' id='" + i + "' class='NumDaysCls' id='NumDaysSc'>" + i + "</a>";
                $("#layer-demo").append(s);
            }

            $('#DoctorInput').on('keyup', function () {
                var input = $(this);
                if (input.val().length === 0) {
                    input.addClass('empty');
                } else {
                    input.removeClass('empty');
                }
            });

            $("#layer-demo .NumDaysCls").click(function (e) {
                var txt = $(this).text();
                SetText(txt);
            });

            $("#btnSave").click(function () {
                SaveDoctors();
            });

        });

        function GetDoctorList() {
            var rows = ''
            $('#tblDoctor').empty();
            URL = '../DoctorDesk/GetDoctors'
            $.ajax({
                url: URL,
                type: 'post',
                datatype: 'json',
                data: {},
                success: function (data) {
                    if (data.length > 0) {
                        $.each(data, function (i, item) {
                            rows += "<tr id='" + item.DoctCode + "' class='clickable-row' style='padding:5px; font-size: 14px;' onclick='SelectProcess(this)'>" + "<td>" + item.DoctName + "</td>" + "</tr>";
                        });
                        $('#tblDoctor').append(rows);
                    }
                },
                complete: function () {
                    GetTreatmentSheetDoctData();
                },

            });
        }
        function callMe(obj) {
            var currid = $(obj).attr('id');
            var m = $('#tblDoctor tbody tr.clickable-row.CN');
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
            $(obj).toggleClass('active');

            if ($(obj).hasClass('active')) {

                $("#tblDoctor tbody").prepend($(obj)).closest('tr');

                $(obj).children('td').children('a').show();
                // selected rows moved to top  
                //$.session.set($(this)[0].id , 'Y');
            }
            else {
                $(obj).children('td').children('a').hide();
                //$.session.set($(this)[0].id, 'N');
            }


            var rows = $('#tblDoctor tbody  tr:not(.active)').get();

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
                $('#tblCmplts').children('tbody').append(row);
            });
        }

        function SearchDoctor() {
            // Declare variables 
            var input, filter, table, tr, td, i, search = '';
            var search = false;
            input = document.getElementById("DoctorInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("tblDoctor");
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
                // GetDoctorListByDB();
            }

        }

        function SaveDoctors() {
            var mrno = $.session.get('PatMRNO');
            var IPno = '108'
            var investArr = [];
            var rows = $('#tblDoctor > tbody > tr.active').get();
            for (var i = 0; i < rows.length; i++) {
                var strDocCode = rows[i].id
                var strDocName = rows[i].cells[0].innerText;
                //     var RFTYPE = rows[i].cells[1].children[1].value == '----Select----' ? "" : rows[i].cells[1].children[1].value;
                var a = {
                    Doctor: strDocName,
                    DoctorCode: strDocCode,
                    ReferralType: 'RF1',
                    TYPECODE: 'RF',
                };
                investArr.push(a);
            }

            $.ajax({
                type: "POST",
                url: 'SaveTreatsheetDoctData',
                datatype: "json",
                data: { strtableTestData: JSON.stringify(investArr), strMRNO: mrno, strIpNo: IPno, strTranNo: TransNo, stringPatName: patsplival[1] },
                success: function (result) {
                    if (result.indexOf('Successful') >= 0) {
                        var splitval = result.toString().split(':');
                        var TranNumb = splitval[1].toString().trim();
                        if (TranNumb.length > 0) {
                            $.session.set('PatTRANNO', TranNumb);

                            $.alert({
                                title: 'Transaction status',
                                content: result,
                            });
                        }
                    }
                    window.location.href = 'TSDoctorList?TreatsheetType=RF';
                },
            });
        }


        function GetTreatmentSheetDoctData() {
            var DataToSend = {
                strTranNo: TransNo,
                strRollOverYN: IsRollover,
                strIPNO: strIPNo,
                strType: 'D',
                TableTypeCode: 'RF'
            };
            $.ajax({
                type: "get",
                url: "GetMedicineTretSheetList", //For all Retrive have same function name in controller in respective of type (take GetMedicineTretSheetList)
                data: DataToSend,
                async: false,
                success: function (response) {
                    if (response != 'Unsucessfull') {
                        var result = JSON.parse(response)
                        for (var i = 0; i < result.Table.length; i++) {
                            var row = $('#tblDoctor tr#' + result.Table[i].DOCTCODE).get();

                            if (row.length > 0) {
                                $("#tblDoctor tbody").prepend(row).closest('tr');
                                $('#tblDoctor tr#' + result.Table[i].DOCTCODE).addClass('active');
                            }
                        }
                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // $.loader.close();
                    $.messager.alert("Error", errorThrown);
                },

                complete: function () {
                },
            });
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
                            data: { strTranNO: strTran, strMRNo: Mrno, strTYEPCode: 'D', strIPNo: strIPNo, strPatName: patsplival[1] },
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
