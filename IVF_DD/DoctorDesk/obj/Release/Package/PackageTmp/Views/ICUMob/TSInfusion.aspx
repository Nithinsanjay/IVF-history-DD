<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TreatmentSheet>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12">
        <div class="box box-warning box-solid" style="border:1px solid #084e4e !important">
            <div class="box-header" style="background-color:#084e4e !important">
                <h4 class="box-title">Infusion</h4>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" id="btnRefillInfusion" onclick="RefillData()">
                        <span class="label pull-right bg-green" style="font-size:86%">Refill Infusion</span>
                    </button>
                    <button type="button" class="btn btn-box-tool" id="btnAddNewRow" onclick="AddNewRow()">
                        <i class="fa fa-plus"></i>
                    </button>
                </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body table-responsive no-padding">
                <table id="tblInfusion" class="table table-hover">
                    <thead>
                        <tr>
                            <td>
                                <h4>Infusion</h4>
                            </td>
                            <td>
                                <h4>Rate</h4>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>

                </table>
            </div>
            <!-- /.box-body -->
            <div class="box-footer" style="text-align: center">
                <a class="btn btn-app" id="anchorSaveInfusion" onblur="" onclick="SaveInfusionData()" style="border-radius: 50px 50px 50px 50px !important; border: 1px solid #29c141 !important; height: 38px !important">
                    <i class="fa fa-check-circle fa-4x" style="font-size:28px !important"></i>
                </a>
                <a class="btn btn-app" id="anchorExit" style="border-radius: 50px 50px 50px 50px !important; border: 1px solid #29c141 !important; height: 38px !important" onclick="BackToTreatmentsheet()">
                    <i class="fa fa-sign-out fa-3x" style="font-size:28px !important"></i>
                </a>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <script>
        GetNursStationsNPAtients();
        SetPatientDtl();


        if ($(window).width() >= 996) {                                            //screen width size comparion
            var menuL = document.getElementById('menuList');
            menuL.style.display = "block";

        }

        /*--------Global variable-----------------------*/
        var strmrNo = $.session.get('PatMRNO');
        var strIPNo = '108'; //$.session.get('ICUPatIPNO')
        var TransNo = $.session.get('PatTRANNO');// 'TS171129MD0001';
        var IsRollover = 'N';
        var MdecinTypeFilter = 'M'
        var splitpatname = $.session.get('PatName');
        var patsplival = splitpatname.toString().split('.');
        var InfusionRate='@ 60 cc/HR'

        /*--end------Global variable-----------------------*/

        $(document).ready(function () {
            GenerateRow();
            GetTreatmentSheetInfusionData();
        })

        function GenerateRow() {
            var row = ''
            for (r = 0; r < 4; r++) {
                row += '<tr><td style="width:70%"><textarea name="Infusion00' + (r + 1) + '" class="form-control" placeholder="Infusion" onblur="SetInfusionRate(this)" style="font-size:12px !important"></textarea></td><td style="width:40%;vertical-align:middle"><input type="text" name="Rate00"' + r + 1 + '" class="form-control" placeholder="Rate" style="font-size:12px !important"></td><td style="vertical-align:middle"><span style="cursor:pointer" onclick="RemoveRow(this);"><i class="fa fa-trash-o fa-2x"></i></span></td>'
            }
            $('#tblInfusion tbody').append(row)
        }

        function SaveInfusionData() {
            var investArr = [];
            var rows = $('#tblInfusion > tbody > tr').get();
            for (var i = 0; i < rows.length; i++) {
                var strInfusionName = rows[i].cells[0].children[0].value
                var strInfusionRate = rows[i].cells[1].children[0].value;
                var a = {
                    Infusion: "" + strInfusionName.toString().trim(),
                    InfusionRate: "" + strInfusionRate,
                    StartTime: '',
                    EndTime: '',
                };
                investArr.push(a);

                FinalInfusionData = jQuery.grep(investArr, function (n, m) {
                    return (n.Infusion != "");
                });
            }

            $.ajax({
                type: "POST",
                url: 'SaveTreatsheetInfusionData',
                datatype: "json",
                data: { strInfusionDTtable: JSON.stringify(FinalInfusionData), strMRNO: strmrNo, strIpNo: strIPNo, strTranNo: TransNo, stringPatName: patsplival[1] },
                success: function (result) {
                    if (result.indexOf('Successful') >= 0) {
                        var splitval = result.toString().split(':');
                        var TranNumb = splitval[1].toString().trim();
                        if (TranNumb.length > 0) {
                            $.session.set('PatTRANNO', TranNumb);
                        }
                    }
                    window.location.href = 'TSInfusion?TreatsheetType=IN';
                },
            });
        }

        function GetTreatmentSheetInfusionData() {
            var DataToSend = {
                strTranNo: TransNo,
                strRollOverYN: IsRollover,
                strIPNO: strIPNo,
                strType: 'I',
                TableTypeCode: 'IN'
            };
            $.ajax({
                type: "get",
                url: "GetMedicineTretSheetList", //For all Retrive have same function name in controller in respective of type (take GetMedicineTretSheetList)
                data: DataToSend,
                async: false,
                success: function (response) {
                    var row = $('#tblInfusion tbody tr').get();
                    if (response != 'Unsucessfull') {
                        var result = JSON.parse(response)
                        for (i = 0; i < result.Table.length; i++) {
                            row[i].cells[0].children[0].value = result.Table[i]["INFUSION"].toString().trim();
                            row[i].cells[1].children[0].value = result.Table[i]["RATE"].toString().trim();
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

        function BackToTreatmentsheet() {
            window.location.href = 'TreatmentSheet?TSInfusion=IN';
        }


        function RefillData() {
            var strTran = ($.session.get('PatTRANNO'))
            var Mrno = ($.session.get('PatMRNO'));
            var RefillResult;
            $.confirm({
                title: 'Medicine Fill Confirmation',
                content: 'Are you sure want to use last verified Infusion Data ?',
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "POST",
                            url: "<%=Url.Action("TSRefillMedicine","ICUMOB")%>",
                            data: { strTranNO: strTran, strMRNo: Mrno, strTYEPCode: 'I', strIPNo: strIPNo, strPatName: patsplival[1] },
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
                                    $.alert('No last verified data prsent for refill');
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

        function SetInfusionRate(obj) {
            obj.parentElement.nextElementSibling.firstElementChild.value = '';
            if ((obj.value).toString().trim().length > 0) {
                obj.parentElement.nextElementSibling.firstElementChild.value = InfusionRate
            }
        }

        function AddNewRow() {
            var rows = $('#tblInfusion > tbody > tr').get();
            var Rowcount = rows.length;
            var row = '<tr><td style="width:70%"><textarea name="Infusion00' + (Rowcount + 1) + '" class="form-control" placeholder="Infusion" onblur="SetInfusionRate(this)" style="font-size:12px !important"></textarea></td><td style="width:40%;vertical-align:middle"><input type="text" name="Rate00"' + r + 1 + '" class="form-control" placeholder="Rate" style="font-size:12px !important"></td><td style="vertical-align:middle"><span style="cursor:pointer" onclick="RemoveRow(this);"><i class="fa fa-trash-o fa-2x"></i></span></td>'
            $('#tblInfusion tbody').append(row);
        }

        function RemoveRow(obj) {
            $(obj)[0].closest('tr').remove();
        }
    </script>

   
    
</asp:Content>
