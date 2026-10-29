<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TreatmentSheet>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12" id="DivMedicinList">
        <div class="StuckInput" style="margin-top: -11px;">
            <label id="myAdd" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Go to top">
                <img src="../Images/add.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
            </label>
            <input type="text" id="txtSearchMedicine" placeholder="&#xF002; Search Medicines" style="width: 63%; border-radius: 5px; margin-top: -2px; border-color: rgba(51, 122, 183, 0.55); -webkit-box-shadow: 0 8px 6px -6px black; -moz-box-shadow: 0 8px 6px -6px black; box-shadow: 0 7px 4px -6px rgb(181, 181, 181); position: fixed;"
                class="empty">
        </div>
        <%--   </div>--%>
        <label id="FillButton" style="background-color: transparent; float: right; margin-right: 95px; border-color: transparent;" title="Go to top">
            <button type="button" class="btn bg-olive margin" style="float: right; bottom: 0px; margin-bottom: 573px; position: fixed; padding: 2px 12px; font-size: 11px" onclick="refillMedicine()">Medicine Fill</button>
        </label>

        <label id="myBtn" style="background-color: transparent; float: right; margin-right: 25px; border-color: transparent;" title="Go to top" onclick="backtoHome();">
            <img src="../Images/check-round.png" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
        </label>

        <div id="wrapper" style="overflow: hidden; width: 100%; margin-left: 15px;">
            <div class="tableDiv" style="padding-top: 13px;">
                <table id="tblMaterialList" class="table" style="width: 100%">
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
    </style>

    <script>
        var TreatmentType = '<%= ViewBag.TrentSheetType %>';
        var strMRNo = $.session.get('PatMRNO');
        var strIPNo = '108'; // $.session.get('ICUPatIPNO')
        var TransNo = $.session.get('PatTRANNO'); //'TS171129MD0001'; // 
        var IsRollover = 'N';
        var MdecinTypeFilter = 'M'
        var splitpatname = $.session.get('PatName');
        var patsplival = splitpatname.toString().split('.');
        var DeleteMedicineType='';
        GetTypeOfData(TreatmentType)
        $(document).ready(function () {
            GetNursStationsNPAtients();
            SetPatientDtl();

            if ($(window).width() >= 996) {                                            //screen width size comparion
                var menuL = document.getElementById('menuList');
                menuL.style.display = "block";

            }
            getTreatmentSheetData();
            $('#txtSearchMedicine').keyup(function (e) {
                if ($("#txtSearchMedicine").val().length > 3) {
                    $.ajax({
                        type: "get",
                        url: "GetDruglst",
                        data: { searchstring: $("#txtSearchMedicine").val() },
                        async: false,
                        success: function (response) {
                            if (response != 'Unsucessfull') {
                                var result = JSON.parse(response)
                                var rows = "";
                                $('#tblMaterialList tbody').empty();
                                for (i = 0; i < result.Table.length; i++) {
                                    var DurgidASClass = ''
                                    DurgidASClass = (result.Table[i].MTRLCODE).replace(/[^0-9a-zA-Z]/gi, '');
                                    rows += "<tr class='" + DurgidASClass + "' id='" + $.trim(result.Table[i].MTRLCODE) + "'>" + "<td  class='MaterialName' id='" + $.trim(result.Table[i].MTRLCODE) + "' onclick='CallTreatSheetDets(this);' style='padding:5px;font-size: 13px;cursor:pointer'>" + $.trim(result.Table[i].MTRLNAME) + "</td><td><span style='cursor:pointer' onclick='DeleteMedicine(this);'><i class='fa fa-trash-o fa-2x'></i></span></td><td class='GenriName' style='display:none'>" + $.trim(result.Table[i].GENERICNAM) + "</td>";
                                    rows += "</tr>";
                                }
                                $('#tblMaterialList tbody').append(rows);
                            }
                        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                            // $.loader.close();
                            $.messager.alert("Error", errorThrown);
                        },

                        complete: function () {

                        },
                    });
                }
            });

        })
        function CallTreatSheetDets(obj) {
            var MaterialCode = $(obj).attr("id");
            var MaterialName = $(obj).text();
            var GenricName = $(obj).find(".GenriName").text();
            treatShtDet(MaterialName, MaterialCode);
        }

        function treatShtDet(mediName, mediCode, GenricName) {
            window.location.href = '../ICUMob/TreatmentSheetDetails?MediName=' + mediName + "&&MediCode=" + mediCode + "&&TreatsheetType=" + TreatmentType
        }

        function backtoHome() {
            window.location.href = '../ICUMob/TreatmentSheet';
        }

        function getTreatmentSheetData() {

            var DataToSend = {
                strTranNo: TransNo,
                strRollOverYN: IsRollover,
                strIPNO: strIPNo,
                strType: MdecinTypeFilter,
                TableTypeCode: TreatmentType
            };
            $.ajax({
                type: "get",
                url: "GetMedicineTretSheetList",
                data: DataToSend,
                async: false,
                success: function (response) {
                    if (response != 'Unsucessfull') {
                        var result = JSON.parse(response)
                        var rows = "";
                        $('#tblMaterialList tbody').empty();
                        for (i = 0; i < result.Table.length; i++) {
                            var DurgidASClass = ''
                            DurgidASClass = (result.Table[i].CODE).replace(/[^0-9a-zA-Z]/gi, '');
                            rows += "<tr class='" + DurgidASClass + " clickable-row active' id='" + $.trim(result.Table[i].CODE) + "'>" + "<td  class='MaterialName' id='" + $.trim(result.Table[i].CODE) + "' onclick='CallTreatSheetDets(this);' style='padding:5px;font-size: 13px;cursor:pointer'>" + $.trim(result.Table[i].DRUGNAME) + "</td><td><span onclick='DeleteMedicine(this);'><i class='fa fa-trash-o fa-2x'></i></span></td><td class='GenriName' style='display:none'></td>";
                            rows += "</tr>";
                        }
                        $('#tblMaterialList tbody').append(rows);
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // $.loader.close();
                    $.messager.alert("Error", errorThrown);
                },

                complete: function () {

                },
            });
        }


        function GetTypeOfData(TreatmentType) {
            switch (TreatmentType) {
                case 'MD':
                    MdecinTypeFilter = 'M'
                    break;
                case 'NB':
                    MdecinTypeFilter = 'N'
                    break;
                case 'SI':
                    MdecinTypeFilter = 'P'
                    break;
                case 'SO':
                    MdecinTypeFilter = 'S'
                    $('#FillButton').hide();
                    break;
                default:
                    MdecinTypeFilter = 'M'
                    break;
            }
        }

        function SetTypeForDelete(TreatmentType){
            switch (TreatmentType) {
                case 'MD':
                    DeleteMedicineType = 'MD'
                    break;
                case 'NB':
                    DeleteMedicineType = 'ND'
                    break;
                case 'SI':
                    DeleteMedicineType = 'PD'
                    break;
                case 'SO':
                    DeleteMedicineType = 'SD'
                    break;
                default:
                    DeleteMedicineType = 'MD'
                    break;
            }
        }

        function refillMedicine() {
            var strTran = ($.session.get('PatTRANNO'))
            var Mrno = ($.session.get('PatMRNO'));
            var RefillResult;
            $.confirm({
                title: 'Medicine Fill Confirmation',
                content: 'Are you sure want to use last verified test for new Transaction ?',
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "POST",
                            url: "<%=Url.Action("TSRefillMedicine","ICUMOB")%>",
                            data: { strTranNO: strTran, strMRNo: Mrno, strTYEPCode: MdecinTypeFilter, strIPNo: strIPNo, strPatName: patsplival[1]},
                                async: false,
                                success: function (response) {
                                    if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        RefillResult = response
                                        $.alert(response);
                                    }

                                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.loader.close();
                                    $.messager.alert("Error", errorThrown);
                                },

                                complete: function () {
                                    if (("" + RefillResult).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                        var splitval = RefillResult.toString().split(':');
                                        var TranNumb = splitval[1].toString().trim();
                                        if (TranNumb.length > 0)
                                        {
                                            $.session.set('PatTRANNO', TranNumb);
                                            window.location.href = 'TreatmentSheetList?TreatsheetType=' + TreatmentType;
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


        function DeleteMedicine(obj) {
          var Row=  $(obj)[0].closest('tr');
          var MaterialCode = $(Row).attr("id");
     
          var Datatosend={
              DRUGCODE:MaterialCode,
              TRANNO: TransNo,
              TYPE: DeleteMedicineType
          }

          $.ajax({
              type: "POST",
              url: "DeleteMedicine",
              data: Datatosend,
              datatype: "json",
              async: false,
              success: function (response) {
                  if (response != "") {
                      getTreatmentSheetData();
                  }

              },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                  $.messager.alert("Error", errorThrown);
              }
          })
        
        }
    </script>


</asp:Content>
