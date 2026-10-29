<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Oncology.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

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
                                  <%--Vijeta 17/4/19--%>
                                <td>
                                    <label style="margin-left: 10px; font-weight: bold; color: #086e9e; display: none;" id="lblGenricID"></label>
                                </td>
                                <td>
                                    <%--<input type="text" placeholder="Dosage" style="width: 100px;" class="ownTextstyle" id="txtDosage" />--%>
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
                                    <%--<div style="float: right">
                                    <label id="myBtn" style="background-color: transparent; float: right; margin-right: 25px; border-color: transparent;" title="Go to top">
                                        <img src="../Images/check-round.png" id="btnSave" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                                    </label>
                                </div>--%>

                                    <%--                                   <label id="myBtn" class=" title="Go to top">
                                    <img src="../Images/check-round.png" id="btnSave" style="float: right; bottom: 0px; margin-bottom: 10px; background-color: white; border-radius: 50%; position: fixed;">
                                </label>--%>


                                </td>
                            </tr>

                        </table>


                    </div>

                    <div style="width: 100%; margin-top: 10px; border-bottom: solid 1px #cad4dc;">
                        <table style="width: 100%; margin-bottom: 5px; margin-left: 5px; font-size: 14px;" id="MediTbl">
                            <tr>
                                <th class="hide">Code</th>
                                <th class="">Intake</th>
                                <th class="">Duration</th>
                                <th style="width: 18%">Food</th>
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
        <div class="col-md-12" style="padding-top: 5px; margin-left: 53px">
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
        <script src="../Scripts/jquery.mobile-1.4.5.min.js"></script>

    <style>
        .borderC:first-child {
            border-radius: 16px 0px 0px 16px;
        }

        .borderC:last-child {
            border-radius: 0 16px 16px 0;
        }

        .shadow {
            box-shadow: 2px 2px 2px 2px #c1bfbf;
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

        .DrugAmt {
            /*background-color: rgba(76, 228, 76, 0.67);*/
            color: black;
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

        .BtnInke {
            width: 40px;
            border-radius: 20px 20px 20px 20px;
            height: 38px;
            text-align: center;
            margin-right: 20px;
            background-color: rgba(76, 228, 76, 0.67);
            cursor: pointer;
        }

        .Plus1 {
            border: 1px solid red;
            width: 40px;
            border-radius: 0px 3px 3px 0px;
            height: 22px;
            text-align: center;
            margin-right: 20px;
            background-color: hsla(172, 80%, 55%, 0.1);
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

        .DaysNumber {
            width: 17%;
            height: 28px;
            font-size: 22px;
            cursor:pointer;
        }


        .DN1 {
            margin-top: 27px;
            margin-bottom: 10px;
        }

        .DN2 {
            margin-top: 10px;
            margin-bottom: 27px;
        }

        .NoBorder {
            border: none !important;
        }

        .ParentDivDN {
            background-color: #d4cfcf75;
            border-radius: 10px 10px 10px 10px;
            margin-bottom: 65px;
        }

        .selectedNumber {
            background: #2e312e7a !important;
            color: white;
            border-radius: 3px 3px 3px 3px;
            box-shadow: 3px 1px 4px 0px #3a3436;
        }

        .JsBtnPostion {
            text-align: center !important;
        }

        .delFont{
            font-size:1.5em !important;
        }

    </style>
    <script>

        var btnID = "";
        var IntakeREsult = '';
        var savedCode = '';
        var UserDefiCombi = '';
        var RemarkList = '';

        var IncrementalValue = '';
        var RalVal = '';
        var DaysRow1 = '';
        var DaysRow2 = '';
        var labelVal = '';
        var SelectedNumber = '';
        var SelectedDWM = '';
        var SelectedDWMText = '';
        var SelectedBAFood = ''
        var SelectedINTStemnt = ''
        var CalculatdIntake = '';
        $(document).ready(function () {
            var MedicineName = <%=HttpUtility.JavaScriptStringEncode(ViewBag.MedicineName, true)%>
            $("#lblMedicine")[0].innerHTML = MedicineName;
            $("#lblMedicineCD")[0].innerHTML = '<%= ViewBag.MediCode %>';
            var GeneRicName =<%=HttpUtility.JavaScriptStringEncode(ViewBag.GenricName, true)%>
             $("#lblGenricName")[0].innerHTML = GeneRicName;
            var GenericID =<%=HttpUtility.JavaScriptStringEncode(ViewBag.GenricID, true)%> //vijeta 17/4/19
          $("#lblGenricID")[0].innerHTML = GenericID; //vijeta 17/4/19
            GetRemarkList();
            callIntakeCombination();
            $("#btnSave").click(function () {
                var MedicineCode = $("#lblMedicineCD")[0].innerHTML
                var rows = $('#MediTbl > tbody > tr').get();
                if (rows.length > 0) {
                    var mediLstArr = [];
                    for (var i = 1; i < rows.length; i++) {

                        var a = {
                            DRUGNM: $("#lblMedicine")[0].innerHTML,
                            DOSSAGE: "" + rows[i].cells[3].children[0].value,
                            DAYS: rows[i].cells[7].innerHTML,
                            Remarks: rows[i].cells[4].children[0].value,
                            ROUTE: "",
                            GENERICID: $("#lblGenricID")[0].innerHTML, //vijeta 17/4/19
                            GENERICNAME: $("#lblGenricName")[0].innerHTML,
                            DRUGCD: $("#lblMedicineCD")[0].innerHTML.toString().trim() == "NEW" ? "" : $("#lblMedicineCD")[0].innerHTML,
                            INTAKECD: '',
                            SOSYN: "N",
                            DURATION: rows[i].cells[6].innerHTML,
                            ABFOOD: "" + rows[i].cells[8].innerHTML,
                            DRUGFORM: "",
                            INTAKEDESC: rows[i].cells[0].innerHTML

                        };
                        mediLstArr.push(a);
                    }


                    $.ajax({
                        type: "POST",
                        url: 'SaveAdvice',
                        datatype: "json",
                        data: { strAdviceList: JSON.stringify(mediLstArr), strTranNO: $.session.get('PatTRANNO'), strMRNo: $.session.get('PatMRNO'), MedicineCD: MedicineCode.toString().trim() == "NEW" ? "" : MedicineCode, Medicinename: MedicineName },
                        success: function (result) {
                            window.location.href = 'Advice';
                        },

                    });
                }
                else {
                    $.messager.alert("Information", "Please select prescription details.");
                }
            });

            $("#myCancel").click(function () {
                window.location.href = 'Advice';
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
                    '<form action="" class="formName" style="height:auto">' +//kavita
                    '<div class="form-group"><textarea rows="4" cols="50"  id="txtRemark" maxlength="500"  placeholder="Remark" autofocus="autofocus" class="complaint form-control" required></textarea>' //kavita
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
                                                        var childLengh = $(rows[i].cells[4].children[0]).children().length;
                                                        SelectRemark = $(rows[i].cells[4].children[0]);
                                                        $(SelectRemark).append($("<option></option>").attr("value", strCode).text(NewRemark));
                                                    }
                                                }
                                                $.alert("Record Inserted Successfully", "Information");
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
            GetRemarkList();
        })

        function GetRemarkList() {
            var datatosend = {
                strClinincode: $.session.get('ClinicCode').toString().trim()
            }
            $.loader.open();
            $.ajax({
                type: "POST",
                url: "getRemarkList",
                datatype: "json",
                data: datatosend,
                async: true,
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

        function GetSavedmediDet() {
            $.loader.open();
            $.ajax({
                type: "POST",
                url: "GetSavedMediList",
                data: { strConsNo: $.session.get('PatTRANNO'), strMedicineCode: $("#lblMedicineCD")[0].innerHTML },
                datatype: "json",
                async: true,
                success: function (response) {
                    if (response != "") {
                        var result = JSON.parse(response)
                        var table = $('#MediTbl');
                        for (var i = 0 ; i < result.length; i++) {
                            var DWMtext = '';
                            var rowCount = table[0].rows.length;
                            var row = table[0].insertRow(rowCount);
                            var strConS = ''
                            AddNewRow(row);

                            /*-------------start-----------------------populating first cell of Table with INTAKEDESC-------------------*/
                            if (result[i]["INTAKEDESC"] == "") {
                                row.cells[0].innerText = result[i]["INTAKE"].toString()
                            }
                            else {
                                row.cells[0].innerText = result[i]["INTAKEDESC"].toString();
                            }

                            /*------------end------------------------end here--------------------------------*/

                            /*-------------start-----------------------Check duration with Full Text and Assigning to Second Cell-------------------*/
                            if (result[i]["DURATION"].toString() != '' || result[i]["DURATION"].toString() != "undefined") {
                                if (Number(result[i]["DAYS"].toString() > 1)) {
                                    strConS = "s"
                                }

                                if (result[i]["DURATION"].toString() == "W")
                                    DWMtext = "Week" + strConS;
                                else if (result[i]["DURATION"].toString() == "M")
                                    DWMtext = "Month" + strConS;
                                else if (result[i]["DURATION"].toString() == "D")
                                    DWMtext = "Day" + strConS;
                                else if (result[i]["DURATION"].toString() == "Y")
                                    DWMtext = "Year" + strConS;
                                else if (result[i]["DURATION"].toString() == "C")
                                    DWMtext = "Contd";
                                else if (result[i]["DURATION"].toString() == "S")
                                    DWMtext = "SOS";
                                else if (result[i]["DURATION"].toString() == "T")//added on 4th sep 2018
                                    DWMtext = "STAT";//added on 4th sep 2018
                                else
                                    DWMtext = "Day" + strConS;

                            }

                            if (result[i]["DURATION"].toString() == "C" || result[i]["DURATION"].toString() == "S" || result[i]["DURATION"].toString() == "T") {////"T" condition added by vijeta on 4th sep 2018
                                row.cells[1].innerText = '' + DWMtext;

                                row.cells[6].innerHTML = result[i]["DURATION"].toString(); //Assign the DURATION to hidden cell 8
                                row.cells[7].innerHTML = "0";     //Assign the DAYS to hidden cell 9
                            }
                            else {
                                row.cells[1].innerText = result[i]["DAYS"].toString() + ' ' + DWMtext;

                                row.cells[6].innerHTML = result[i]["DURATION"].toString(); //Assign the DURATION to hidden cell 8
                                row.cells[7].innerHTML = result[i]["DAYS"].toString();     //Assign the DAYS to hidden cell 9
                            }


                            /*------------end------------------------end here---------------------------------------------------------------------------*/

                            /*-------------start-----------------------Check Food Type with code and Assigning to third Cell-------------------*/
                            if (result[i]["ABFOOD"].toString() == "A") {

                                row.cells[2].innerHTML = "AF.Food"
                            }
                            else if (result[i]["ABFOOD"].toString() == "E") {
                                row.cells[2].innerHTML = "BF.Food"
                            }
                            else if (result[i]["ABFOOD"].toString() == "EA") {
                                row.cells[2].innerHTML = "NA"

                            }
                            row.cells[8].innerHTML = result[i]["ABFOOD"].toString();  //Assign the Food Type to hidden cell 8
                            /*------------end------------------------end here---------------------------------------------------------------------------*/

                            /*-------------start-----------------------Assigning the Dossage to third(3) Cell-------------------*/

                            row.cells[3].children[0].value = result[i]['DOSSAGE'].toString();

                            /*------------end------------------------end here---------------------------------------------------------------------------*/

                            /*-------------start-----------------------Setting selected Remark in  to fourth(4) Cell-------------------*/
                            SelectRemark = $(row).find('td').eq(4);
                            var selectElement = $(SelectRemark).children(0);
                            var optval = result[i]['Remarks'].toString();
                            $(selectElement).val(optval);

                            /*----end Here--------------------end selection setting---------------------------------------------------------------*/
                        }
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {

                    $.messager.alert("Error", errorThrown);
                }
            });
            $.loader.close();
        }



        function callIntakeCombination() {
            $.ajax({
                type: "get",
                datatype: "json",
                url: 'GetMedicineInTake',
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

                            // stringHTML += '<div id=' + IntakeREsult.Table[i].CODE + ' class="col-md-4" style="padding-bottom:3px;padding-right:0px;padding-left:0px" onclick="AddMedicine(this);">' + l1 + l2 + l3 + l4 + l5 + l6 + '</div>';
                            stringHTML += '<div id=' + IntakeREsult.Intake[i].CODE + ' class="col-md-4" style="padding-bottom:3px;padding-right:0px;padding-left:0px" onclick="AddMedicineNew(this);">' + l1 + l2 + l3 + l4 + l5 + l6 + '</div>';

                            // stringHTML += '<input type="button" class="ownbtnstyle" onClick="AddMedicine(this)" id=' + IntakeREsult.Table[i].CODE + ' value="' + l1 + '"/>'
                        }

                        maindiv.append(stringHTML);
                    }
                    else {

                    }
                },
                complete: function () {
                    GetSavedmediDet();
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
            $(this)[0].closest('tr').remove();
            return false;
        });

        function AddMedicineNew(obj) {
            IncrementalValue = '';
            RalVal = '';
            DaysRow1 = '';
            DaysRow2 = '';
            labelVal = '';
            SelectedNumber = '';
            SelectedDWM = '';
            CalculatdIntake = '';
            SelectedDWMText = '';
            SelectedINTStemnt = '';
            for (I = 1; I < 6; I++) {
                DaysRow1 += '<label id="D' + I + '" class="DaysNumber DN1" onclick="CallSelectedNumber(this)">' + I + '</label>'
            }

            for (I = 6; I < 11; I++) {
                DaysRow2 += '<label id="D' + I + '" class="DaysNumber DN2" onclick="CallSelectedNumber(this)">' + I + '</label>'
            }

            var Id = $(obj).attr('id');
            value = jQuery.grep(IntakeREsult.Intake, function (n, i) {
                return ((n.CODE).trim() == Id); //trim added by vijeta 17/4/19
            });

            var InatkeCombi = value[0].INTAKE;
            strx = InatkeCombi.split('-');

            for (m = 0; m < strx.length; m++) {
                labelVal += '<label class="BtnInke"><span style="font-size: 27px;">' + strx[m] + '</span></label>'
            }
            $.confirm({
                theme: 'material',
                type: 'orange',
                columnClass: 'medium',
                closeIcon: true,
                title: '' + $("#lblMedicine")[0].innerHTML,
                content: '' +
                '<form action="" class="formName" style="text-align:center">' +
                 '<div style="margin-bottom:15px;"><div class="btn-group groupCombi" data-toggle="buttons" style="padding-top: 6px" id="GropSeelect">' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="0.5" autocomplete="off" checked="">0.5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="1" autocomplete="off" checked="">1</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="5" autocomplete="off" checked="">5</label>' +
                  '<label class="btn btn-default borderC" onclick="ValueToStore(this)"><input type="radio" name="groupCombi" value="10" autocomplete="off" checked="">10</label>' +
                  '</div></div>' +
                '<div class="form-group" id="btnCalulatedIntaKe">' + labelVal + '</div>' +
                 '<div style="margin-bottom:15px;"><div class="btn-group Food" data-toggle="buttons" style="padding-top: 6px" id="foodIntake">' +
               '<label class="btn btn-default borderC" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="E" autocomplete="off" checked="">Befor Meal</label>' +
              '<label class="btn btn-default borderC" onclick="StoreABFoodVal(this)"><input type="radio" name="FoodInfo" value="A" autocomplete="off" checked="">After Meal</label>' +
            '</div></div>' +

             '<div style="margin-bottom:15px;" class=""><div class="btn-group IntkeStatement" data-toggle="buttons" style="padding-top: 6px" id="IntkeStatement">' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)"><input type="radio" name="IntkeStatement" value="Contd" autocomplete="off" checked="">Contd</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)"><input type="radio" name="IntkeStatement" value="SOS" autocomplete="off" checked="">SOS</label>' +
               '<label class="btn btn-default" style="width: 85px;" onclick="StoreINTStatementVal(this)"><input type="radio" name="IntkeStatement" value="STAT" autocomplete="off" checked="">STAT</label>' +//added on 4th sep 2018
               '<label class="btn btn-default active" style="width: 85px;" onclick="StoreINTStatementVal(this)"><input type="radio" name="IntkeStatement" value="Other" autocomplete="off" checked="">Other</label>' +
            '</div></div>' +
            '<div class="ParentDivDN">' +
               '<div class=Drow1>' + DaysRow1 +
            '</div>' +
            '<div class=Drow2>' + DaysRow2 +
          '</div>' +
          '<div>' +
            '<div style="margin-bottom:15px;"><div class="btn-group btn-group-sm MedicineDays" data-toggle="buttons" style="padding-top: 6px;margin-bottom:30px" id="MedicineDays">' +
                '<label id="DAYS" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="D" autocomplete="off" checked="">DAYS</label>' +
                '<label id="WEEK" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="W" autocomplete="off" checked="">WEEK</label>' +
                '<label  id="MONTH" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="M" autocomplete="off" checked="">MONTH</label>' +
                '<label  id="YEAR" class="btn btn-default NoBorder" onclick="StoreDaysValue(this)"><input  type="radio" name="MDDay" value="Y" autocomplete="off" checked="">YEAR</label>' +
           '</div>' +
         '</div>' +
          '</div>' +
                '</form>',
                buttons: {
                    formSubmit: {
                        text: 'Submit',
                        btnClass: 'btn btn-green',
                        action: function () {
                            bfFood = ''
                            var Chlength = $('#btnCalulatedIntaKe').children().children().length;
                            for (var c = 0; c < Chlength; c++) {
                                var childElement = $('#btnCalulatedIntaKe').children().children()[c];
                                CalculatdIntake += childElement.innerHTML + '-';
                            }
                            CalculatdIntake.slice(0, -1)

                            //createdRow = '</tr><td id=IntakeCombination>' + CalculatdIntake.slice(0, -1) + '</td><td id=DaySel>' + SelectedNumber + ' ' + SelectedDWM + '</td><td id=FoodVal>' + SelectedBAFood + '</td><td id="tdDoses"><input type="text" id="txtDoses"></td><td><select class="RemarkSelc" style="text-align:center;width:92%"></select></td></tr>'
                            // $(createdRow).appendTo($("#MediTbl tbody"));
                            //validation added by vijeta on 18th Aug 2018
                            var medType = $("div.IntkeStatement label.active").children()[0].value;
                            if (medType == "Other") {
                                if (!($(".Drow1").children(".selectedNumber").length > 0 || $(".Drow2").children(".selectedNumber").length > 0) || ($('.MedicineDays').children('label.active').length == 0)) {
                                    $.alert("Please Select Duration.");
                                    return false;
                                }
                            }
                            //----------------------------
                            AddMedicineRow();
                        }
                    },
                    cancel: function () {
                        //close
                    },

                },
                onContentReady: function () {
                    // bind to events
                    var jc = this;
                    $('.jconfirm-buttons').addClass('JsBtnPostion')
                    this.$content.find('form').on('submit', function (e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });


                    $(".BtnInke").on('click', function () {
                        var child = $(this).children();
                        if (longpress) {
                            $(this).children().text(0);
                        }
                        else {
                            ChangeCombinationVal(child);
                        }
                    });

                    $(".BtnInke").on('mousedown', function () {
                        startTime = new Date().getTime();
                    });

                    $(".BtnInke").on('mouseup', function () {
                        endTime = new Date().getTime();
                        longpress = (endTime - startTime > 500) ? true : false;
                    });

                    $(".BtnInke").bind("taphold", function tapholdHandler(event) {
                        $(this).children().text(0);
                    });
                }
            });
        }

        function ValueToStore(obj) {
            IncrementalValue = (obj).children[0].value;
            RalVal = (obj).children[0].value;
        }

        function ChangeCombinationVal(obj) {
            //if (IncrementalValue != '') {
            //    obj.innerHTML = IncrementalValue;
            //    IncrementalValue = '';
            //}
            //else {
             //   obj.innerHTML = Number(obj.innerHTML) + Number(RalVal);
            //}
            obj.text(Number(obj.text()) + Number(RalVal))
        }

        function CallSelectedNumber(obj) {
            var lblchild = obj.parentElement.children

            $('.Drow1').children().each(function () {
                if ($(this).hasClass('selectedNumber')) {
                    $(this).removeClass('selectedNumber')
                }
            });

            $('.Drow2').children().each(function () {
                if ($(this).hasClass('selectedNumber')) {
                    $(this).removeClass('selectedNumber')
                }
            });

            $(obj).addClass('selectedNumber');
            SelectedNumber = $(obj).text();
        }

        function StoreDaysValue(obj) {
            SelectedDWM = (obj).children[0].value;
            SelectedDWMText = $(obj).attr('id');
        }

        function StoreABFoodVal(obj) {
            SelectedBAFood = (obj).children[0].value;
        }

        function StoreINTStatementVal(obj) {
            SelectedINTStemnt = (obj).children[0].value;
            if (SelectedINTStemnt.length > 0) {
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    $('.ParentDivDN').addClass('disable-clicks')

                    $('.Drow1').children().each(function () {
                        if ($(this).hasClass('selectedNumber')) {
                            $(this).removeClass('selectedNumber')
                        }
                    });

                    $('.Drow2').children().each(function () {
                        if ($(this).hasClass('selectedNumber')) {
                            $(this).removeClass('selectedNumber')
                        }
                    });

                    $('.MedicineDays > .btn-default').removeClass('active');
                    $(".ParentDivDN").hide();// added by vijeta on 20th sep 2018
                }
                else {
                    $(".ParentDivDN").show();// added by vijeta on 20th sep 2018
                    $('.ParentDivDN').removeClass('disable-clicks')
                }
            }

        }



        function AddMedicineRow() {

            var table = $('#MediTbl');
            var rowCount = table[0].rows.length;
            var row = table[0].insertRow(rowCount);
            AddNewRow(row);

        }


        function AddNewRow(row) {
            var FoodStatus = ''
            if (SelectedBAFood == "A") {
                FoodStatus = "AF.Food";
            }
            else if (SelectedBAFood == "E") {
                FoodStatus = "BF.Food";
            }

            var cell1 = row.insertCell(0);
            if (CalculatdIntake.length > 0) {
                cell1.innerHTML = CalculatdIntake.slice(0, -1);
            }
            else {
                cell1.innerHTML = '';
            }

            var cell2 = row.insertCell(1);
            if (SelectedINTStemnt.length > 0) {
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    cell2.innerHTML = SelectedINTStemnt;
                }
                else {
                    cell2.innerHTML = SelectedNumber + ' ' + SelectedDWMText;
                }
            }
            else {
                cell2.innerHTML = SelectedNumber + ' ' + SelectedDWMText;
            }


            var Cell3 = row.insertCell(2)
            Cell3.innerHTML = FoodStatus;
            Cell3.setAttribute('style', 'width:18%');


            var cell4 = row.insertCell(3);
            var inputelement = document.createElement("input");
            inputelement.type = "text";
            inputelement.className = 'ownTextstyle';
            inputelement.placeholder = "Dosage"
            inputelement.setAttribute('style', 'width: 50px;')
            cell4.appendChild(inputelement)

            var cell5 = row.insertCell(4);
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

            Remarkelement.setAttribute('style', 'text-align:center;width:92%')
            cell5.appendChild(Remarkelement)

            var cell6 = row.insertCell(5);
            var element7 = document.createElement("label");
            element7.className = "removeIntake";

            element8 = document.createElement("i");
            element8.className = "fa fa-trash-o delFont"

            element7.appendChild(element8);
            cell6.appendChild(element7)

            var Cell7 = row.insertCell(6);
            var Cell8 = row.insertCell(7);

            if (SelectedINTStemnt.length > 0) {
                if (SelectedINTStemnt.substring(0, 1) == "S" || SelectedINTStemnt.substring(0, 1) == "C") {
                    if (SelectedINTStemnt == "STAT")//added on 4th sep 2018
                        Cell7.innerHTML = "T";//added on 4th sep 2018
                    else
                        Cell7.innerHTML = SelectedINTStemnt.substring(0, 1);

                    Cell8.innerHTML = "0";
                }
                else {
                    Cell7.innerHTML = SelectedDWM;
                    Cell8.innerHTML = SelectedNumber;
                }
            }
            else {
                Cell7.innerHTML = SelectedDWM;
                Cell8.innerHTML = SelectedNumber;
            }

            Cell7.className = 'hide Days';
            Cell8.className = 'hide Number';

            var Cell9 = row.insertCell(8);
            Cell9.innerHTML = SelectedBAFood
            Cell9.className = 'hide';
        }

    </script>
</asp:Content>

