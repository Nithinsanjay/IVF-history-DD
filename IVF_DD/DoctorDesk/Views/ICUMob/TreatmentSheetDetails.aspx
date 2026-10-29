<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/ICUMobMaster.Master" Inherits="System.Web.Mvc.ViewPage<OncologyEMR.Models.TreatmentSheet>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row" style="margin-left: 0px">
        <div class="col-md-12" style="padding-left: 0px; padding-right: 0px">
            <div class="chatdiv">
                <div id="OuterDiv" class="OuterDiv" style="margin-top: 0px;">
                    <div style="width: 100%; background-color: #e0e0e0 !important;">
                        <table style="width: 100%; margin-bottom: 10px;">

                            <tr style="border-bottom: solid 1px #cad4dc; border-top: solid 1px #cad4dc; margin-top: 10px;">
                                <td>
                                    <label style="margin: 7px; font-weight: bold; color: #086e9e; font-size: 14px;" id="lblMedicine"></label>
                                </td>
                                <td>
                                    <label style="margin-left: 10px; font-weight: bold; color: #086e9e; display: none;" id="lblMedicineCD"></label>
                                </td>
                                <td>
                                    <label style="margin-left: 10px; font-weight: bold; color: #086e9e; display: none;" id="lblGenricName"></label>
                                </td>

                                <td>
                                    <div class="pull-right box-tools">
                                        <button type="button" id="addNewRemark" class="btn btn-info btn-sm" data-widget="collapse" data-toggle="tooltip" title="Add New Remark" data-original-title="Collapse">
                                            <i class="fa fa-plus"></i>&nbsp;Remark
                                        </button>
                                    </div>
                                </td>
                                <td>
                                    <div style="float: right">
                                        <label id="addIntakeCombination" style="background-color: transparent; float: left; margin-left: -8px; margin-top: 3px; margin-right: 24px; border-color: transparent;" title="Add New combination">
                                            <img src="../Images/plus.png" id="addAdvice" style="background-color: white; border-radius: 50%; position: fixed;">
                                        </label>
                                    </div>
                                </td>
                            </tr>

                        </table>


                    </div>

                    <div style="width: 100%; margin-top: 10px; border-bottom: solid 1px #cad4dc;">
                        <table style="width: 97%; margin-bottom: 5px; margin-left: 5px; font-size: 14px;" id="MediTbl">
                            <tr>
                                <th class="hide">Code</th>
                                <th class="hide">DayofDrug</th>
                                <th class="" style="width: 16%">Type</th>
                                <th class="">Intake</th>
                                <th>Route</th>
                                <th class="" style="width: 18%">Dosage</th>
                                <th class="" style="width: 18%">Remark</th>
                            </tr>
                        </table>
                    </div>

                </div>

                <div id="fixedDiv" class="fixedDiv" style="padding-top: 10px; background-color: white">
                </div>

            </div>
        </div>
        <div class="col-md-12" style="padding-top: 20px; margin-left: 53px">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <a class="btn btn-app shadow" id="btnSave">
                    <i class="fa fa-check-circle fa-3x" style="font-size: 50px"></i>
                </a>

                <a class="btn btn-app shadow" id="myCancel" style="padding-left: 5px">
                    <i class="fa fa-times-circle-o fa-3x" style="font-size: 50px"></i>
                </a>
            </div>
        </div>

    </div>

    <div id="log"></div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">

    <style>
        .sbutton {
            background-color: white; /* Green */
            border: 1px solid #38c;
            color: black;
            padding: 6px 12px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 12px;
            cursor: pointer;
        }

        .shadow {
            box-shadow: 2px 2px 2px 2px #c1bfbf;
        }

        .sbuttonleft {
            border-top-left-radius: 9px;
            border-bottom-left-radius: 9px;
        }

        .sbuttonright {
            border-top-right-radius: 9px;
            border-bottom-right-radius: 9px;
        }

        .sbutton:hover {
            background-color: #38c;
        }

        .align-center {
            text-align: center;
        }

        .conv2 {
            background-color: rgba(76, 228, 76, 0.67);
            width: 34px;
            height: 25px;
            border-radius: 0px 0px 0px 0px;
            color: white;
            text-align: center;
            border: 1px solid #b6ff00;
            cursor: pointer;
        }

        .float {
            position: fixed;
            width: 60px;
            height: 60px;
            bottom: 40px;
            right: 40px;
            background-color: #0C9;
            color: #FFF;
            border-radius: 50px;
            text-align: center;
            box-shadow: 2px 2px 3px #999;
        }

        .col-xs-7 {
            width: 52.333333%;
        }

        .col-xs-4 {
            width: 31.333333%;
        }

        .col-xs-8 {
            width: 61.666667%;
        }

        @media (min-width: 768px) {
            .col-sm-4 {
                width: 26.33333333%;
                padding-left: 4px !important;
            }
        }

        @media (min-width: 768px) {
            .col-sm-2 {
                width: 16.66666667%;
                padding-left: 4px !important;
            }
        }

        @media (min-width: 768px) {
            .col-sm-3 {
                width: 23%;
                padding-left: 4px !important;
            }
        }

        .conv2:first-child {
            border-radius: 12px 0px 0px 12px;
        }

        .CSOS {
            border-radius: 12px 12px 12px 12px !important;
        }

        .hide {
            display: none !important;
        }

        .conv2:last-child {
            border-radius: 0px 12px 12px 0px;
        }

        .C1 {
            background-color: rgba(76, 228, 76, 0.67);
            color: white;
        }

        .C05 {
            background-color: rgba(76, 228, 76, 0.67);
            color: white;
        }

        .C0 {
            background-color: white;
        }

        .w3-btn, .w3-button {
            border: none;
            display: inline-block;
            outline: 0;
            padding: 3px 11px;
            vertical-align: middle;
            overflow: hidden;
            text-decoration: none;
            color: inherit;
            background-color: inherit;
            text-align: center;
            cursor: pointer;
            white-space: nowrap;
        }



        .w3-theme {
            color: #fff !important;
            background-color: #4CAF50 !important;
        }

        .w3-col.l4 .w3-card-2 {
            padding: 15px 10px;
            height: 260px;
        }

        .w3-col .w3-button {
            margin: 5px 5px 5px 0;
            font-size: 16px;
        }

        .ownbtnstyle {
            border-radius: 25px 25px 25px 25px;
            height: 30px;
            margin: 10px 5px 10px 5px;
            font-size: 14px;
            color: #fff !important;
            background-color: #7c9a03 !important;
            border: none;
            display: inline-block;
            outline: 0;
            padding: 3px 11px;
            vertical-align: middle;
            overflow: hidden;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            white-space: nowrap;
        }

        .ownbtnstyle2 {
            background-color: rgba(9, 97, 9, 0.67);
        }

        .ownTextstyle {
            border-radius: 5px 5px 5px 5px;
            height: 25px;
            font-size: 12px;
            border: solid 1px #808080;
            vertical-align: middle;
            overflow: hidden;
            font-weight: bold;
            color: #086e9e;
            outline: 0;
        }

        .optionButtonLeft {
            border-radius: 25px 0px 0px 25px;
            height: 23px;
            margin: 5px 5px 5px 5px;
            color: #000 !important;
            background-color: #99be03 !important; /*#f1ac3e*/
            border: none;
            display: inline-block;
            outline: 0;
            padding: 3px 11px;
            vertical-align: middle;
            overflow: hidden;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            white-space: nowrap;
            margin-right: 0px;
            border-right: solid 1px #e0e0e0;
            width: 10px;
        }

        .optionSelStyle {
            background-color: #f1ac3e !important; /*#f1ac3e*/
        }

        .optionButtonRight {
            border-radius: 0px 25px 25px 0px;
            height: 23px;
            /*margin: 5px 5px 5px 5px;*/
            color: #000 !important;
            background-color: #99be03;
            border: none;
            display: inline-block;
            outline: 0;
            padding: 3px 11px;
            vertical-align: middle;
            overflow: hidden;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            white-space: nowrap;
            margin-left: 0px;
            width: 10px;
        }

        .number-select {
            width: 20px;
        }

        select {
            -webkit-appearance: none;
            -moz-appearance: none;
            text-indent: 1px;
            width: 18px;
            background-color: #abdaf5;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 26px;
            outline: 0;
        }

        .RemarkSelc {
            -webkit-appearance: none;
            -moz-appearance: none;
            text-indent: 1px;
            width: 55px;
            background-color: #abdaf5;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 3px;
            margin-right: 3px;
            border: none;
            height: 26px;
            outline: 0;
        }

        .disable-clicks {
            pointer-events: none;
            color: red;
        }
    </style>
    <script>

        GetNursStationsNPAtients();
        SetPatientDtl();

        if ($(window).width() >= 996) {                                            //screen width size comparion
            var menuL = document.getElementById('menuList');
            menuL.style.display = "block";

        }
        var btnID = "";
        var IntakeREsult = '';
        var savedCode = '';
        var UserDefiCombi = '';
        var RemarkList = '';
        var MediTypeList = '';
        var RouteList = '';
        var splitpatname = $.session.get('PatName');
        var patsplival = splitpatname.toString().split('.');
        var strMRNo = $.session.get('PatMRNO');
        var strTypecode = '<%= ViewBag.TrentSheetType %>';
        var strIPNo = 108 //$.session.get('ICUPatIPNO');//
        var TransNo = $.session.get('PatTRANNO');
        var IsRollover = 'N';
        var MdecinTypeFilter = 'M'

        $(document).ready(function () {
            CheckTodaysTranction();
            GetTypeOfData(strTypecode)
            var MedicineName = <%=HttpUtility.JavaScriptStringEncode(ViewBag.MedicineName, true)%>
            $("#lblMedicine")[0].innerHTML = MedicineName;
            $("#lblMedicineCD")[0].innerHTML = '<%= ViewBag.MediCode %>';
            GetRemarkList();
            GetTypeList();
            GetRouteList();
            callIntakeCombination();
            $("#btnSave").click(function () {
                var MedicineCode = $("#lblMedicineCD")[0].innerHTML
                var rows = $('#MediTbl > tbody > tr').get();
                // var strIPNO = $.session.get('ICUPatIPNO').toString();

                if (rows.length > 0) {
                    var mediLstArr = [];
                    for (var i = 1; i < rows.length; i++) {

                        var a = {
                            TYPE: rows[i].cells[1].children[0].selectedOptions[0].innerHTML,
                            DrugName: $("#lblMedicine")[0].innerHTML,
                            DayOfDrug: rows[i].cells[7].innerHTML,
                            Dose: "" + rows[i].cells[4].children[0].value,
                            Route: rows[i].cells[3].children[0].selectedOptions[0].innerHTML,
                            Freq: rows[i].cells[2].innerText,
                            Omit: '',
                            Remark: rows[i].cells[5].children[0].selectedOptions[0].innerHTML,
                            DrugCode: $("#lblMedicineCD")[0].innerHTML,
                            TypeCode: strTypecode,
                        };
                        mediLstArr.push(a);
                    }


                    $.ajax({
                        type: "POST",
                        url: 'SaveTreatmentSheetTran',
                        datatype: "json",
                        data: { tableMedicationData: JSON.stringify(mediLstArr), strIpNo: '108', MrNo: strMRNo, strTranNO: TransNo, stringPatName: patsplival[1], stringType: MdecinTypeFilter, strDrugCode: $("#lblMedicineCD")[0].innerHTML },
                        success: function (result) {
                            if (result.indexOf('Successful') >= 0) {
                                var splitval = result.toString().split(':');
                                var TranNumb = splitval[1].toString().trim();
                                if (TranNumb.length > 0) {
                                    $.session.set('PatTRANNO', TranNumb);
                                }
                            }
                            window.location.href = 'TreatmentSheetList?TreatsheetType=' + strTypecode;
                        },

                    });
                }
                else {
                    $.messager.alert("Information", "Please select prescription details.");
                }
            });

            $("#myCancel").click(function () {
                window.location.href = 'TreatmentSheetList?TreatsheetType=' + strTypecode;
            });

            $("#addIntakeCombination").click(function () {

                var options = '<option value=""></option><option value="0">0</option><option value="0.5">0.5</option><option value="1">1</option><option value="1.5">1.5</option>'

                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formName" style="height:60px">' +
                    '<div class="form-group">' +
                    '<select id=1>' + options + '</select>' +
                    '<select id=2>' + options + '</select>' +
                    '<select id=3>' + options + '</select>' +
                    '<select id=4>' + options + '</select>' +
                    '<select id=5>' + options + '</select>' +
                    '<select id=6>' + options + '</select>'
                    ,
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var mediPreComb = "";

                                if ($('#1').val() != "") {
                                    mediPreComb = $('#1').val();
                                }
                                else {
                                    $.alert("Please select first 3 slots sequentially.", "Information");
                                    return 0;
                                }

                                if ($('#2').val() != "") {
                                    mediPreComb += '-' + $('#2').val();
                                }
                                else {
                                    $.alert("Please select first 3 slots sequentially.", "Information");
                                    return 0;
                                }

                                if ($('#3').val() != "") {
                                    mediPreComb += '-' + $('#3').val();
                                }
                                else {
                                    $.alert("Please select first 3 slots sequentially.", "Information");
                                    return 0;
                                }


                                if ($('#4').val() != "")
                                    mediPreComb += '-' + $('#4').val();

                                if ($('#5').val() != "")
                                    mediPreComb += '-' + $('#5').val();

                                if ($('#6').val() != "")
                                    mediPreComb += '-' + $('#6').val();

                                if (mediPreComb == "") {
                                    $.alert('Select Combinations');
                                    return false;
                                }

                                if (mediPreComb != "") {
                                    $.ajax({
                                        type: "post",
                                        datatype: "json",
                                        url: 'saveMedIntkCombintn',
                                        data: { strMedIntkComb: mediPreComb, },
                                        success: function (response) {
                                            if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                                var maindiv = $('.OuterDiv');
                                                var strCode = "" + response.toString();
                                                strCode = strCode.substring(strCode.length - 3, strCode.length);
                                                savedCode = strCode;
                                                UserDefiCombi = mediPreComb
                                                strx = mediPreComb.split('-');
                                                var l1 = '';
                                                for (i = 0; i < strx.length; i++) {
                                                    if (!strx[i] == "") {
                                                        l1 += '<label class="conv2 ' + 'C' + strx[i] + '">' + strx[i] + '</label>'
                                                    }
                                                }
                                                var stringHTML = '<div id=' + strCode + ' class="col-md-4" style="" onclick="AddMedicine(this);">' + l1 + '</div>';
                                                maindiv.append(stringHTML);
                                            }
                                            else {
                                                $.alert(response, "Information");
                                            }
                                        },

                                    });
                                }

                            }
                        },
                        cancel: function () {
                            //close
                            //$('.FoodItems input:checked').focus();
                        },
                    },
                    onContentReady: function () {
                        $('#1').focus();
                        // bind to events
                        var jc = this;
                        this.$content.find('form').on('submit', function (e) {
                            // if the user submits the form by pressing enter in the field.
                            e.preventDefault();
                            jc.$$formSubmit.trigger('click'); // reference the button and click it
                        });
                    }
                });
            });

            $("#addNewRemark").click(function () {
                $.confirm({
                    title: '',
                    content: '' +
                    '<form action="" class="formName" style="height:60px">' +
                    '<div class="form-group"><input id="txtRemark" type="text" class="ownTextstyle" placeholder="Add Remark" style="width:250px;border-radius:3px 3px 3px 3px;height:43px">'
                    ,
                    buttons: {
                        formSubmit: {
                            text: 'Save',
                            btnClass: 'btn-blue',
                            action: function () {
                                var NewRemark = '' + $('#txtRemark').val();
                                if (NewRemark != "") {
                                    $.ajax({
                                        type: "post",
                                        datatype: "json",
                                        url: 'saveIntakeRemark',
                                        data: { strNewRemark: NewRemark, },
                                        success: function (response) {
                                            if (("" + response).toUpperCase().indexOf("SUCCESSFUL") != -1) {
                                                var maindiv = $('.OuterDiv');
                                                var strCode = "" + response.toString();
                                                strCode = strCode.substring(strCode.length - 3, strCode.length);
                                                var rows = $('#MediTbl > tbody > tr').get();
                                                if (rows.length > 0) {
                                                    for (var i = 1; i < rows.length; i++) {
                                                        var childLengh = $(rows[i].cells[5].children[0]).children().length;
                                                        SelectRemark = $(rows[i].cells[5].children[0]);
                                                        $(SelectRemark).append($("<option></option>").attr("value", strCode).text(NewRemark));
                                                    }
                                                }

                                            }
                                            else {
                                                $.alert(response, "Information");
                                            }
                                        },

                                    });
                                }

                            }
                        },
                        cancel: function () {
                            //close
                            //$('.FoodItems input:checked').focus();
                        },
                    },
                    onContentReady: function () {
                        $('#1').focus();
                        // bind to events
                        var jc = this;
                        this.$content.find('form').on('submit', function (e) {
                            // if the user submits the form by pressing enter in the field.
                            e.preventDefault();
                            jc.$$formSubmit.trigger('click'); // reference the button and click it
                        });
                    }
                });
            });

            $('.fixedDiv').slimScroll({
                color: '#e21616',
                size: '4px',
                height: '300px',

            });

            $('.chatdiv').slimScroll({
                color: '#00f',
                size: '4px',
                height: '400px',

            });

            $("#target").scroll(function () {
                //  $("#log").append("<div>Handler for .scroll() called.</div>");
            });
        })

        function GetRemarkList() {
            $.loader.open();
            $.ajax({
                type: "POST",
                url: "../DoctorDesk/getRemarkList",
                datatype: "json",
                async: false,
                success: function (response) {
                    if (response != "") {
                        RemarkList = response

                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {

                    $.messager.alert("Error", errorThrown);
                }
            });
            $.loader.close();
        }

        function GetTypeList() {
            $.loader.open();
            $.ajax({
                type: "POST",
                url: "GetMedicineType",
                datatype: "json",
                async: false,
                success: function (response) {
                    if (response != "") {
                        MediTypeList = response
                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {

                    $.messager.alert("Error", errorThrown);
                }
            });
            $.loader.close();
        }

        function GetRouteList() {
            $.loader.open();
            $.ajax({
                type: "POST",
                url: "GetMedicineRoute",
                datatype: "json",
                async: false,
                success: function (response) {
                    if (response != "") {
                        RouteList = response
                    }

                }, error: function (XMLHttpRequest, textStatus, errorThrown) {

                    $.messager.alert("Error", errorThrown);
                }
            });
            $.loader.close();
        }

        function checkdivelement(Childlength) {
            for (var m = 1; m < Childlength + 1; m++) {
                //   var ids = $('.fixedDiv div:nth-child(' + m + ')').attr('id');
                var innerChildDiv = $('.fixedDiv div:nth-child(' + m + ')')
                innerChildDivLengh = $(innerChildDiv).children().length;
                if (innerChildDivLengh == 3) {
                    $(innerChildDiv).removeClass('col-md-4');
                    $(innerChildDiv).addClass('col-xs-4 col-sm-2');
                }
                else if (innerChildDivLengh == 4) {
                    $(innerChildDiv).removeClass('col-md-4');
                    $(innerChildDiv).addClass('col-xs-5 col-sm-3');
                    $(innerChildDiv).css('padding-right', '0px');
                }
                else if (innerChildDivLengh == 2) {
                    $(innerChildDiv).removeClass('col-md-4');
                    $(innerChildDiv).addClass('col-md-2');
                }
                else if (innerChildDivLengh == 1) {
                    $(innerChildDiv).removeClass('col-md-4');
                    $(innerChildDiv).addClass('col-xs-2 col-sm-1');
                }
                else if (innerChildDivLengh == 6) {
                    $(innerChildDiv).removeClass('col-md-4');
                    $(innerChildDiv).addClass('col-xs-8 col-sm-4');
                }
                else if (innerChildDivLengh == 5) {
                    $(innerChildDiv).removeClass('col-md-4');
                    $(innerChildDiv).addClass('col-xs-7 col-sm-3');
                }
            }
        }


        function getTreatmentSheetData() {

            var DataToSend = {
                strTranNo: TransNo,
                strRollOverYN: IsRollover,
                strIPNO: strIPNo,
                strType: MdecinTypeFilter,
                TableTypeCode: strTypecode,
                MedicinCode: $("#lblMedicineCD")[0].innerHTML
            };
            $.ajax({
                type: "get",
                url: "GetMedicineDetailsList",
                data: DataToSend,
                async: false,
                success: function (response) {
                    if (response != 'Unsucessfull') {
                        var result = JSON.parse(response)

                        var table = $('#MediTbl');
                        for (var i = 0 ; i < result.FilterMDTable.length; i++) {
                            var rowCount = table[0].rows.length;
                            var row = table[0].insertRow(rowCount);

                            value = jQuery.grep(IntakeREsult.Intake, function (n, m) {
                                return (n.INTAKE == result.FilterMDTable[i]["FREQ"].toString().trim());
                            });
                            row.id = "row" + value[0]["CODE"].toString().trim();
                            var btn = $("#" + value[0]["CODE"].toString().trim())[0];

                            $(btn).find('label').each(function () {
                                $(this).addClass('ownbtnstyle2');
                            });

                            $(btn).addClass('disable-clicks');

                            AddRow(row, btn);

                            $(row.cells[1].children[0]).val(result.FilterMDTable[i]["TYPE"].toString().trim());
                            $(row.cells[3].children[0]).val(result.FilterMDTable[i]["ROUTE"].toString().trim());
                            $(row.cells[4].children[0]).val(result.FilterMDTable[i]["DOSE"].toString().trim())
                            $(row.cells[5].children[0]).val(result.FilterMDTable[i]["REMARK"].toString().trim())
                            if (!CheckTodaysTranction())
                            {
                                var Numofday = row.cells[7].innerText
                                row.cells[7].innerText = parseInt(Numofday) + 1;
                            }
                            

                            /*----find row of remark and update the value selected------------------------*/
                            var CurrentRows = $('#MediTbl > tbody > #' + row.id)
                            console.log($(CurrentRows).attr('id'));
                            SelectRemark = $(CurrentRows).find('td').eq(5);
                            var selectElement = $(SelectRemark).children(0);
                            var optval = result.FilterMDTable[i]["REMARK"].toString().trim();
                            $(selectElement).val(optval);
                            setSelectedValue(selectElement, result.FilterMDTable[i]["REMARK"].toString().trim())
                            /*----end Here-------------------------------------------------------------*/

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

        function AddMedicine(btnIntake) {

            if (!($(btnIntake).hasClass('disable-clicks'))) {
                $(btnIntake).addClass('disable-clicks');
            }

            $(btnIntake).children().each(function () {
                if (!$(this).hasClass('ownbtnstyle2')) {
                    $(this).addClass('ownbtnstyle2');
                }
            })

            var table = $('#MediTbl');
            var rowCount = table[0].rows.length;

            var v = $("#MediTbl tbody  tr#" + btnIntake.id).get();

            if (v.length == 0) {

                var row = table[0].insertRow(rowCount);
                AddRow(row, btnIntake);
            }
            else {
                $("#MediTbl tbody tr#" + btn.id).remove();
                btn.className = 'ownbtnstyle';
            }

        }

        function AddRow(row, btnIntake) {

            var btn = btnIntake;
            row.id = "row" + btn.id;
            var cell1 = row.insertCell(0);
            cell1.innerHTML = btn.id;
            cell1.className = 'hide';



            /*----start---------add Medicine Type----------------------------------------*/

            var Cell2 = row.insertCell(1)
            var TypeElement = document.createElement("Select");
            TypeElement.className = "RemarkSelc"
            var blankType = document.createElement("option");
            TypeElement.add(blankType, null);
            for (t = 0 ; t < MediTypeList.length; t++) {
                var MediType = document.createElement("option");
                MediType.text = MediTypeList[t].Text;
                MediType.value = MediTypeList[t].Value;
                TypeElement.add(MediType, null);
            }

            TypeElement.setAttribute('style', 'width:55%')
            Cell2.appendChild(TypeElement)

            /*---End----------add Medicine Type----------------------------------------*/

            /*-------------Intake Code--------*/

            var cell3 = row.insertCell(2);
            value = jQuery.grep(IntakeREsult.Intake, function (n, i) {
                return (n.CODE == btn.id);
            });
            if (value != '') {
                cell3.innerHTML = value[0].INTAKE;
            }
            else {
                cell1.innerHTML = "";
                cell1.innerHTML = savedCode;
                cell3.innerHTML = UserDefiCombi;
            }

            cell3.setAttribute("style", "width:22%");



            // var cell4 = row.insertCell(3);

            var Cell4 = row.insertCell(3)
            var RouteElement = document.createElement("Select");
            RouteElement.className = "RemarkSelc"
            var blankRoute = document.createElement("option");
            RouteElement.add(blankRoute, null);
            for (t = 0 ; t < RouteList.length; t++) {
                var RouteType = document.createElement("option");
                RouteType.text = RouteList[t].Text;
                RouteType.value = RouteList[t].Value;
                RouteElement.add(RouteType, null);
            }
            RouteElement.setAttribute('style', 'width:85%')
            Cell4.appendChild(RouteElement)

            var cell5 = row.insertCell(4);
            var inputelement = document.createElement("input");
            inputelement.type = "text";
            inputelement.className = 'ownTextstyle';
            inputelement.placeholder = "Dosage"
            inputelement.setAttribute('style', 'width: 50px;')
            cell5.appendChild(inputelement)



            //Remark Row

            var cell6 = row.insertCell(5);
            var Remarkelement = document.createElement("Select");
            //element2.setAttribute("style", "font-size:22px");
            Remarkelement.className = "RemarkSelc"
            var blankRemark = document.createElement("option");
            Remarkelement.add(blankRemark, null);
            for (p = 0 ; p < RemarkList.length; p++) {
                var remark = document.createElement("option");
                remark.text = RemarkList[p].Text;
                remark.value = RemarkList[p].Value;
                Remarkelement.add(remark, null);
            }

            Remarkelement.setAttribute('style', 'text-align:center;width:85%')
            cell6.appendChild(Remarkelement)


            /* Remove row -----------------------------*/
            var cell7 = row.insertCell(6);
            var element7 = document.createElement("label");
            element7.className = "removeIntake";

            element8 = document.createElement("i");
            element8.className = "fa fa-trash-o"

            element7.appendChild(element8);
            element7.setAttribute('style', 'padding-left:6%')
            cell7.appendChild(element7)





            /*----------------Cell3 for Non of days drug taken hide the column since calculated cell-------------------------------*/

            var cell8 = row.insertCell(7);
            cell8.setAttribute("style", "width:12%");
            cell8.innerHTML = '1';
            cell8.className = 'hide'

            /*---------end-------Cell3 for Non of days drug taken-------------------------------*/

        }

        function SelUnselAFood(btnID, txtID) {
            if (btnID.className.toString().search("optionSelStyle") == -1) {
                btnID.className += ' optionSelStyle';
                txtID.value = txtID.value + "A";
            }
            else {
                btnID.className = "optionButtonLeft";
                txtID.value = "badge bg-red";
            }
        }


        function callIntakeCombination() {
            $.ajax({
                type: "get",
                datatype: "json",
                url: '../DoctorDesk/GetMedicineInTake',
                success: function (response) {
                    if (response != "Unsucessfull") {
                        IntakeREsult = JSON.parse(response)
                        var maindiv = $('.fixedDiv');
                        var stringHTML = '';
                        for (i = 0; i < IntakeREsult.Intake.length; i++) {
                            array = [] = '';
                            var string = IntakeREsult.Intake[i].INTAKE
                            strx = string.split('-');
                            array = array.concat(strx);
                            var l1 = ''; l2 = ''; l3 = '', l4 = '', l5 = '', l6 = '';

                            if (!strx[0] == "") {
                                l1 = '<label class="conv2 ' + 'C' + strx[0] + '">' + strx[0] + '</label>'
                            }
                            if (!strx[1] == "") {
                                l2 = '<label class="conv2 ' + 'C' + strx[1] + '">' + strx[1] + '</label>';
                            }
                            if (!strx[2] == "") {
                                l3 = '<label class="conv2 ' + 'C' + strx[2] + '">' + strx[2] + '</label>';
                            }
                            if (!strx[3] == "") {
                                l4 = '<label class="conv2 ' + 'C' + strx[3] + '">' + strx[3] + '</label>';
                            }
                            if (!strx[4] == "") {
                                l5 = '<label class="conv2 ' + 'C' + strx[4] + '">' + strx[4] + '</label>';
                            }

                            if (!strx[5] == "") {
                                l6 = '<label class="conv2 ' + 'C' + strx[5] + '">' + strx[5] + '</label>';
                            }

                            stringHTML += '<div id=' + IntakeREsult.Intake[i].CODE + ' class="col-md-4" style="padding-bottom:3px;padding-right:0px;padding-left:0px" onclick="AddMedicine(this);">' + l1 + l2 + l3 + l4 + l5 + l6 + '</div>';

                            // stringHTML += '<input type="button" class="ownbtnstyle" onClick="AddMedicine(this)" id=' + IntakeREsult.Table[i].CODE + ' value="' + l1 + '"/>'
                        }

                        maindiv.append(stringHTML);
                    }
                    else {

                    }
                },
                complete: function () {
                    getTreatmentSheetData()
                    var Childlength = $('.fixedDiv').children().length
                    checkdivelement(Childlength);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $.loader.close();
                    $.messager.alert("Error", errorThrown);
                }
            });
        }



        $(document).on('click', '.removeIntake', function () {
            var CurrenRow = ($(this)[0].closest('tr'));
            var CurrenRowId = $(CurrenRow).attr('id');
            var CodeID = CurrenRowId.substr(3);
            Childlength = $('.fixedDiv').children().each(function () {
                var ClidDiv = $(this);
                var currDivId = $(this).attr('id');
                if (currDivId == CodeID) {
                    if ($(this).hasClass("disable-clicks")) {
                        $(this).removeClass('disable-clicks')
                    }

                    $($(this)).children().each(function () {

                        if ($(this).hasClass('ownbtnstyle2')) {
                            $(this).removeClass('ownbtnstyle2');

                        }
                    })
                }

            });
            $(this)[0].closest('tr').remove();
            return false;
        });


        function GetTypeOfData(strTypecode) {
            switch (strTypecode) {
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
                    break;
                default:
                    MdecinTypeFilter = 'M'
                    break;

            }

        }

        function setSelectedValue(selectObj, valueToSet) {
            for (var i = 0; i < selectObj[0].childElementCount; i++) {
                if (selectObj[0].options[i].text == valueToSet) {
                    selectObj[0].options[i].selected = true;
                    return;
                }
            }
        }

        function CheckTodaysTranction() {
            todaysdate = false;
            var TransDate = TransNo.substring(8, 6);
            var today = new Date();
            var dd = today.getDate();
            if(TransDate==dd)
            {
                todaysdate = true;
            }

            return todaysdate;
        }
    </script>


</asp:Content>
